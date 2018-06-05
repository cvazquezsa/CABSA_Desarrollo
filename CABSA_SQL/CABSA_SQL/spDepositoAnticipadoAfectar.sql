SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**************** spDepositoAnticipadoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDepositoAnticipadoAfectar') and type = 'P') drop procedure dbo.spDepositoAnticipadoAfectar
GO             
CREATE PROCEDURE spDepositoAnticipadoAfectar
		   @Sucursal		int,
		   @Accion		char(20),
		   @ID			int,
		   @Mov			char(20),
                   @MovID		varchar(20),
                   @Empresa		char(5),
    		   @Modulo	      	char(5),
		   @CtaDinero		char(10),
    		   @ImporteTotal	money,	 
    		   @MovMoneda	      	char(10),
		   @RedondeoMonetarios	int,	
		   @ConDesglose		bit,
		   @FormaPago		varchar(50),
		   @FormaPagoDA		varchar(50),
		   @Referencia		varchar(50),
		   @CfgDARef		bit,

       		   @Ok                	int          OUTPUT,
    		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DineroID			int,
    @DineroMov			varchar(20),
    @DineroMovID		varchar(20),
    @DineroSaldo		money,
    @DineroEstatus		varchar(15),
    @DineroEstatusAnterior	varchar(15),
    @DineroUsuario		varchar(10),
    @DineroConciliado		bit,
    @CfgConciliarEstatus	bit,
    @FechaEmision		datetime,
    @FechaRegistro		datetime,
    @ContAuto			bit,
    @MovTipo			varchar(20),

    @AfectarFiscal		varchar(20),
    @Fiscal				bit,
    @Usuario			varchar(20),
    @OkTemp             int,
    @OkRefTemp          varchar(255),
    @Total				float,
    @OrigenTotal		Float,
    @OrigenFactor		float

  SELECT @CfgConciliarEstatus = ISNULL(DineroConciliarEstatus, 0) 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa 

    SELECT @AfectarFiscal = NULL
    SELECT @Fiscal = ISNULL(Fiscal, 0)
      FROM EmpresaGral 
     WHERE Empresa = @Empresa

  SELECT @DineroID = NULL, @DineroEstatus = NULL
  IF @Accion = 'CANCELAR'
  BEGIN
    IF @CfgDARef = 1
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM Dinero d
        JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
       WHERE d.Empresa = @Empresa 
         AND d.Estatus IN ('PENDIENTE', 'CONCLUIDO', 'CONCILIADO')
         --AND d.CtaDinero = @CtaDinero 
         --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
         AND d.MovID = @Referencia
         AND d.Moneda = @MovMoneda
      IF @DineroID IS NOT NULL 
      BEGIN
        DELETE MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @DineroID
        IF (SELECT Estatus FROM Dinero WHERE ID = @DineroID) = 'CONCLUIDO'
          EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        SELECT @DineroEstatusAnterior = Estatus FROM Dinero WHERE ID = @DineroID
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE',
               Saldo = ISNULL(Saldo, 0.0) + @ImporteTotal
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'     
    END ELSE
    BEGIN
      SELECT @DineroID = MIN(d.ID)
        FROM MovFlujo mf
        JOIN Dinero d ON d.ID = mf.DID AND d.CtaDinero = @CtaDinero AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios) AND d.Moneda = @MovMoneda AND d.Estatus IN ('CONCLUIDO', 'CONCILIADO')
       WHERE mf.Cancelado = 0 
         AND mf.Empresa = @Empresa 
         AND mf.OModulo = @Modulo 
         AND mf.OID = @ID

      IF @DineroID IS NOT NULL 
      BEGIN
        DELETE MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @DineroID
        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        SELECT @DineroEstatusAnterior = Estatus FROM Dinero WHERE ID = @DineroID
        UPDATE Dinero 
           SET Estatus = 'PENDIENTE' 
         WHERE ID = @DineroID
      END ELSE SELECT @Ok = 30120, @OkRef = 'Deposito Anticipado'
    END
    IF @DineroID IS NOT NULL AND @Fiscal = 1 
    BEGIN
      SELECT @DineroMov = Mov, @DineroEstatus = Estatus, @FechaRegistro = FechaRegistro, @FechaEmision= FEchaEmision,  @Usuario = Usuario, @DineroMovID = MovID FROM Dinero WHERE ID = @DineroID
          SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov

      SELECT @AfectarFiscal = UPPER(NULLIF(RTRIM(AfectarFiscal), ''))
        FROM MovTipo
       WHERE Modulo = 'DIN' AND Mov = @DineroMov

      IF @AfectarFiscal NOT IN (NULL, 'NO')       
      BEGIN
        SELECT @OkTemp = @Ok, @OkRefTemp = @OkRef
        SELECT @Ok = NULL, @OkRef = NULL

        EXEC spGenerarFiscal @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, 'CANCELADO', @Usuario, @FechaEmision, @FechaRegistro, @DineroMov, @DineroMovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp
      END
    END

  END ELSE
  BEGIN
    IF @ConDesglose = 1 AND UPPER(@FormaPago) <> UPPER(@FormaPagoDA) 
      SELECT @Ok = 35161
    ELSE BEGIN
      IF @CfgDARef = 1
      BEGIN
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroSaldo = ISNULL(Saldo, Importe), @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           --AND d.CtaDinero = @CtaDinero 
           --AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.MovID = @Referencia
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL
        BEGIN
          
					IF ROUND(@DineroSaldo, @RedondeoMonetarios)-ROUND(@ImporteTotal, @RedondeoMonetarios) > -0.1 --CABSA Ticket 132
					--IF ROUND(@ImporteTotal, @RedondeoMonetarios) <= ROUND(@DineroSaldo, @RedondeoMonetarios)
          BEGIN
            SELECT @DineroSaldo = ROUND(@DineroSaldo, @RedondeoMonetarios) - ROUND(@ImporteTotal, @RedondeoMonetarios) --CABSA
            IF @DineroSaldo < 0.1 
              SELECT @DineroEstatus = 'CONCLUIDO'
            ELSE
              UPDATE Dinero SET Saldo = @DineroSaldo WHERE ID = @DineroID
          END ELSE 
            SELECT @Ok = 35162
        END
      END ELSE
      BEGIN
        SELECT @DineroID = d.ID, @DineroMov = d.Mov, @DineroMovID = d.MovID, @DineroConciliado = ISNULL(Conciliado, 0), @DineroUsuario = Usuario, @DineroEstatusAnterior = Estatus
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.DA'
         WHERE d.Empresa = @Empresa 
           AND d.Estatus = 'PENDIENTE' 
           AND d.CtaDinero = @CtaDinero 
           AND ROUND(d.Importe, @RedondeoMonetarios) = ROUND(@ImporteTotal, @RedondeoMonetarios)
           AND d.Moneda = @MovMoneda
        IF @DineroID IS NOT NULL SELECT @DineroEstatus = 'CONCLUIDO'
      END

      IF @DineroEstatus = 'CONCLUIDO'
      BEGIN

        SELECT @OrigenFactor = 1
 
        IF @Modulo = 'CXC' AND EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = 'CXC' AND ModuloID = @ID)
        BEGIN
          EXEC spMovInfo @ID, 'CXC', @Mov, @MovID, @Empresa = @Empresa, @Total = @OrigenTotal OUTPUT
          SELECT @OrigenFactor = @ImporteTotal / NULLIF(@OrigenTotal, 0.0)
  
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,              OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,               Importe2,               Importe3,               SubTotal,               ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
          SELECT 'DIN', @DineroID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@OrigenFactor, Importe2*@OrigenFactor, Importe3*@OrigenFactor, SubTotal*@OrigenFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
            FROM MovImpuesto
           WHERE Modulo = 'CXC' AND ModuloID = @ID
        END

        EXEC spValidarTareas @Empresa, 'DIN', @DineroID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero  
           SET Estatus = CASE WHEN @CfgConciliarEstatus = 1 AND @DineroConciliado = 1 THEN 'CONCILIADO' ELSE 'CONCLUIDO' END,
               Saldo = NULL
         WHERE ID = @DineroID

        SELECT @ContAuto = ISNULL(ContAuto, 0)
          FROM EmpresaGral 
         WHERE Empresa = @Empresa

          SELECT @FechaRegistro = GETDATE()
          SElECT @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)

        IF @CfgConciliarEstatus = 1 AND @ContAuto = 1
        BEGIN
          SELECT @FechaRegistro = GETDATE()
          SElECT @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)
          SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov
          SELECT @DineroEstatus = Estatus FROM Dinero WHERE ID = @DineroID
          EXEC spMovContAuto @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, @DineroEstatus, @DineroUsuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, NULL, NULL
        END
      END

      IF @DineroID IS NULL SELECT @Ok = 35160
    END
  END

  IF @Ok IS NULL
  BEGIN
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT

      SELECT @AfectarFiscal = NULL
      SELECT @AfectarFiscal = UPPER(NULLIF(RTRIM(AfectarFiscal), ''))
        FROM MovTipo
       WHERE Modulo = 'DIN' AND Mov = @DineroMov

    SELECT @Fiscal = ISNULL(Fiscal, 0)
      FROM EmpresaGral 
     WHERE Empresa = @Empresa

    IF @Fiscal = 1 AND @AfectarFiscal NOT IN (NULL, 'NO') 
    BEGIN
      SELECT @OkTemp = @Ok, @OkRefTemp = @OkRef
      SELECT @Ok = NULL, @OkRef = NULL

      EXEC spGenerarFiscal @Empresa, @Sucursal, 'DIN', @DineroID, @DineroEstatusAnterior, @DineroEstatus, @DineroUsuario, @FechaEmision, @FechaRegistro, @DineroMov, @DineroMovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT
	  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp
    END

  END

END
GO

