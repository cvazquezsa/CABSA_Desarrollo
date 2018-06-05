/* SP DINERO     */

-- DIN.SD  = Solicitud Deposito
-- DIN.D   = Deposito
-- DIN.DE  = Deposito Electronico
-- DIN.SCH = Solicitud Cheque
-- DIN.CH  = Cheque
-- DIN.CHE = Cheque Electronico
-- DIN.CB  = Cargo Bancario
-- DIN.AB  = Abono Bancario
-- DIN.DF  = Deposito en Falso
-- DIN.CD  = Cheque Devuelto
-- DIN.T   = Transferencia
-- DIN.DA  = Deposito Anticipado

-- DIN.A   = Apertura Caja
-- DIN.AP  = Aumento Caja
-- DIN.I   = Ingreso
-- DIN.E   = Egreso
-- DIN.F   = Faltante Caja
-- DIN.TC  = Transferencia Caja
-- DIN.CP  = Corte Parcial Caja
-- DIN.C   = Corte Caja

/******************************* spDineroChequeDevueltoCxp *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroChequeDevueltoCxp') and type = 'P') drop procedure dbo.spDineroChequeDevueltoCxp --MEJORA6013
GO             
CREATE PROCEDURE spDineroChequeDevueltoCxp
		@Estacion			int,
		@DineroID			int,
		@Usuario			varchar(10)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Sucursal				int,
  @SucursalOrigen		int,
  @SucursalDestino		int,
  @Empresa				varchar(10),
  @Modulo				varchar(5),
  @Mov					varchar(20),
  @MovID				varchar(20),
  @MovTipo				varchar(20),
  @MovMoneda			varchar(10),
  @MovTipoCambio		float,
  @FechaEmision			datetime,
  @Proyecto				varchar(50),
  @Referencia			varchar(50),
  @Observaciones		varchar(100),
  @FechaRegistro		datetime,
  @Condicion			varchar(50),
  @Contacto				varchar(10),
  @CtaDinero			varchar(10),
  @FormaPago			varchar(50),
  @Importe				money,
  @Impuestos			money,
  @Retencion			money,
  @ComisionTotal		money,
  @Beneficiario			varchar(100),
  @CxMov				varchar(20),
  @UEN					int,
  @IEPSFiscal			float,
  @IVAFiscal			float,
  @IDGenerar			int,
  @Ok					int,
  @OkRef				varchar(255),
  @Transaccion			varchar(50),
  @CxMovID				varchar(20),
  @ChequeDevuelto		bit,
  @ContactoTipo Varchar(50),
  @CxModulo varchar(5),
  @Ejercicio int,
  @Periodo int,
  @CfgMovChequeDevuelto varchar(20),
  @Cajero varchar(20),
  @DineroMovID varchar(20),
  @FEchaAfectacion datetime,
  @CxMovTipo varchar(20),
  @DineroIDChequeDevuelto int,
  @DineroChequeDevueltoMovID varchar(20),
  @IDGenerarCD int
  

  SET @Transaccion = 'spDineroGenerarChequeDevuelto' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@Estacion,0))))

  SELECT @FechaAfectacion = getdate()
  
  SELECT @ChequeDevuelto = ISNULL(ChequeDevuelto,0), @ContactoTipo = Contactotipo FROM Dinero WHERE ID = @DineroID
  
  BEGIN TRANSACTION @Transaccion
  
  IF @ChequeDevuelto = 0
  BEGIN  
    SET @Modulo = 'DIN'
    SET @FechaRegistro = GETDATE()
    SET @FechaEmision = dbo.fnFechaSinHora(@FechaRegistro)
  
    IF @Contactotipo = 'Proveedor'
	BEGIN 
      SELECT
        @Sucursal = d.Sucursal,
        @SucursalOrigen = d.SucursalOrigen,
        @SucursalDestino = d.SucursalDestino,
        @Empresa = d.Empresa, 
        @Mov = d.Mov,
        @MovID = d.MovID,
        @MovTipo = mt.Clave,
        @MovMoneda = d.Moneda,
        @MovTipoCambio = d.TipoCambio,
        @Proyecto = d.Proyecto,
        @Referencia = d.Referencia,
        @Observaciones = d.Observaciones,
        @Condicion = p.Condicion,
        @Contacto = d.Contacto,
        @CtaDinero = d.CtaDinero,
        @FormaPago = d.FormaPago,
        @Importe = d.Importe, 
        @Impuestos = d.Impuestos,
        @Retencion = d.Retencion,
        @ComisionTotal = d.Comisiones,
        @Beneficiario = d.Beneficiario,
        @IVAFiscal = IVAFiscal,    
        @IEPSFiscal = IEPSFiscal,
        @UEN = d.UEN
        FROM Dinero d JOIN MovTipo mt
          ON mt.Mov = d.Mov AND mt.Modulo = 'DIN' LEFT OUTER JOIN Prov p
          ON p.Proveedor = d.Contacto AND d.ContactoTipo = 'Proveedor'
       WHERE ID = @DineroID

	  SELECT @CxModulo = 'CXP'
      SELECT @CxMov = CxpChequeDevuelto FROM EmpresaCfgMovCxp WHERE Empresa = @Empresa
	  UPDATE Dinero SET ChequeDevuelto = 1 WHERE ID = @DineroID IF @@ERROR <> 0 SET @Ok = 1
      IF @Ok IS NULL
      BEGIN    
	    INSERT Cxp (Empresa,  Mov,    FechaEmision,  Proyecto,  UEN,  Moneda,     TipoCambio,     ProveedorMoneda, ProveedorTipoCambio, Usuario,  Referencia,  Observaciones,  Estatus,      Proveedor, CtaDinero,  FormaPago,  Importe,  Impuestos,  Retencion,  Beneficiario,  OrigenTipo, Origen, OrigenID, FechaRegistro,  Sucursal,  IVAFiscal,  IEPSFiscal)
        VALUES (@Empresa, @CxMov, @FechaEmision, @Proyecto, @UEN, @MovMoneda, @MovTipoCambio, @MovMoneda,      @MovTipoCambio,      @Usuario, @Referencia, @Observaciones, 'SINAFECTAR', @Contacto, @CtaDinero, @FormaPago, @Importe, @Impuestos, @Retencion, @Beneficiario, 'DIN',      @Mov,   @MovID,   @FechaRegistro, @Sucursal, @IVAFiscal, @IEPSFiscal) 
        SET @IDGenerar = Scope_identity()      
        IF @@ERROR <> 0 SET @Ok = 1    
      END
	  IF @Ok IS NULL
      BEGIN
        INSERT MovImpuesto (
               Modulo, ModuloID,   OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	          OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
        SELECT @CxModulo,  @IDGenerar, OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
          FROM MovImpuesto
         WHERE Modulo = 'DIN' AND ModuloID = @DineroID        
        IF @@ERROR <> 0 SET @Ok = 1         
      END
        
      IF @Ok IS NULL
        EXEC spAfectar @CxModulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, 1, @Estacion 
      
      IF @Ok IS NULL OR @Ok = 80030
      BEGIN
        SELECT @CxMovID = MovID FROM CXP WHERE ID = @IDGenerar    
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'DIN', @DineroID, @Mov, @MovID, @CxModulo, @IDGenerar, @CxMov, @CxMovID, @Ok OUTPUT
      END   
	END
	ELSE IF @ContactoTipo = 'Cliente'  
	BEGIN 
    	SELECT @Ok = 20380, @OkRef = 'El Origen De Este Cheque No es de Cuentas por Pagar'
	/*
	  SELECT
        @Sucursal = d.Sucursal,
        @SucursalOrigen = d.SucursalOrigen,
        @SucursalDestino = d.SucursalDestino,
        @Empresa = d.Empresa, 
        @Mov = d.Mov,
        @MovID = d.MovID,
        @MovTipo = mt.Clave,
        @MovMoneda = d.Moneda,
        @MovTipoCambio = d.TipoCambio,
        @Proyecto = d.Proyecto,
        @Referencia = d.Referencia,
        @Observaciones = d.Observaciones,
        @Condicion = p.Condicion,
        @Contacto = d.Contacto,
        @CtaDinero = d.CtaDinero,
        @FormaPago = d.FormaPago,
        @Importe = d.Importe, 
        @Impuestos = d.Impuestos,
        @Retencion = d.Retencion,
        @ComisionTotal = d.Comisiones,
        @Beneficiario = d.Beneficiario,
        @IVAFiscal = IVAFiscal,    
        @IEPSFiscal = IEPSFiscal,
        @UEN = d.UEN,
		@Ejercicio = d.Ejercicio,
		@Periodo = d.Periodo,
		@Cajero = d.Cajero
        FROM Dinero d JOIN MovTipo mt
          ON mt.Mov = d.Mov AND mt.Modulo = 'DIN' LEFT OUTER JOIN Cte p
          ON p.Cliente = d.Contacto AND d.ContactoTipo = 'Cliente'
       WHERE ID = @DineroID

	  SELECT @CxModulo = 'CXC' 
      SELECT @CfgMovChequeDevuelto =  NULLIF(RTRIM(BancoChequeDevuelto), '') FROM EmpresaCfgMov WHERE Empresa = @Empresa
      SELECT  @CxMov = CxcNCredito from EmpresaCfgMov WHERE Empresa = @Empresa
	  UPDATE Dinero SET ChequeDevuelto = 1 WHERE ID = @DineroID IF @@ERROR <> 0 SET @Ok = 1
	  IF @Ok IS NULL
      BEGIN    
	    INSERT Cxc (Empresa,  Mov,    FechaEmision,  Proyecto,  UEN,  Moneda,     TipoCambio,     ClienteMoneda, ClienteTipoCambio, Usuario,  Referencia,  Observaciones,  Estatus,      Cliente, CtaDinero,  FormaCobro,  Importe,  Impuestos,  Retencion,  OrigenTipo, Origen, OrigenID, FechaRegistro,  Sucursal,  IVAFiscal,  IEPSFiscal)
        VALUES (@Empresa, @CxMov, @FechaEmision, @Proyecto, @UEN, @MovMoneda, @MovTipoCambio, @MovMoneda,      @MovTipoCambio,      @Usuario, @Referencia, @Observaciones, 'SINAFECTAR', @Contacto, @CtaDinero, @FormaPago, @Importe, @Impuestos, @Retencion, 'DIN',      @Mov,   @MovID,   @FechaRegistro, @Sucursal, @IVAFiscal, @IEPSFiscal) 
        SET @IDGenerar = Scope_identity()      
        IF @@ERROR <> 0 SET @Ok = 1    
      END
      IF @Ok IS NULL
      BEGIN
        INSERT MovImpuesto (
               Modulo, ModuloID,   OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,	          OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
        SELECT @CxModulo,  @IDGenerar, OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1, Importe2, Importe3, SubTotal, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
          FROM MovImpuesto
         WHERE Modulo = 'DIN' AND ModuloID = @DineroID        
        IF @@ERROR <> 0 SET @Ok = 1         
      END
        
      IF @Ok IS NULL
        EXEC spAfectar @CxModulo, @IDGenerar, 'AFECTAR', 'TODO', NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, 1, @Estacion 
      
      IF @Ok IS NULL OR @Ok = 80030
      BEGIN
	    SELECT @CxMovID = movID FROM Cxc WHERE ID = @IdGenerar
	    SELECT @CxMovTipo = Clave FROM MovTipo WHERE Modulo = @CxModulo AND Mov = @CxMov

        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'DIN', @DineroID, @Mov, @MovID, @CxModulo, @IDGenerar, @CxMov, @CxMovID, @Ok OUTPUT
 
        INSERT Dinero (Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa,  Mov,        MovID,        FechaEmision,     Concepto,  Proyecto,  Moneda,     TipoCambio,     Usuario,  Autorizacion,  Referencia,  DocFuente,  Observaciones,  Estatus,        CtaDinero,  Cajero,  Importe,  Impuestos,  ConDesglose,  FormaPago,  OrigenTipo, Origen, OrigenID, UEN,        FechaProgramada, IVAFiscal,  IEPSFiscal,  Contacto,  ContactoTipo)
        VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @CfgMovChequeDevuelto, NULL, @FechaAfectacion, NULL, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, NULL, @Referencia, NULL, @Observaciones, 'SINAFECTAR', @CtaDinero, @Cajero, @Importe, @Impuestos,  0,            @FormaPago, @CxModulo,    @CxMov,   @CxMovID,   NULL, NULL,    @IVAFiscal, @IEPSFiscal, @Contacto, @ContactoTipo)
        IF @@ERROR <> 0 SELECT @Ok = 1
        SELECT @DineroIDChequeDevuelto = SCOPE_IDENTITY()
  
         -- Copiar Anexos
        EXEC spMovCopiarAnexos @Sucursal, @CxModulo, @IDGenerar, 'DIN', @DineroIDChequeDevuelto
	  
        IF @Ok IS NULL AND @DineroIDChequeDevuelto IS NOT NULL
          EXEC spDinero @DineroIDChequeDevuelto, 'DIN', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                        @CfgMovChequeDevuelto OUTPUT, @DineroChequeDevueltoMovID OUTPUT, @IDGenerarCD OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

        IF @Ok IS NULL OR @Ok = 80030
          EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'CXC', @IDGenerar, @CxMov, @CxMovID, 'DIN', @DineroIDChequeDevuelto, @CfgMovChequeDevuelto, @DineroChequeDevueltoMovID, @Ok OUTPUT  
      END*/   
	END
  END
  
  IF @Ok IS NULL OR @Ok = 80030
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso exitoso.'
  END  
  ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion      
    SELECT CONVERT(varchar,@Ok) + '. ' + ISNULL(@OkRef,'')
  END  

END
GO

/**************** spDineroGenerarMultimoneda****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroGenerarMultimoneda') and type = 'P') drop procedure dbo.spDineroGenerarMultimoneda
GO
CREATE PROCEDURE spDineroGenerarMultimoneda
		    @Accion			varchar(20),
    		    @Empresa          		varchar(5),
		    @Sucursal	      		int,
	            @Usuario			varchar(10),
    		    @ID               		int,
		    @Mov			varchar(20),
	            @MovID			varchar(20),
	            @MovTipo                    varchar(20),
	            @SubClave                   varchar(20),
	            @Estatus                    varchar(15),
	            @EstatusNuevo               varchar(15),
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda               varchar(10),
    @DineroID             int,
    @DineroMov            varchar(20),
    @CtaDinero            varchar(10),               
    @CtaDineroDestino	  varchar(10),
    @Importe              money,
    @ImporteTotal         money,
    @FormaPago            varchar(50),
    @Referencia           varchar(50),
    @Renglon              float,
    @SucursalD            int,
    @MovIDGenerar         varchar(20),
    @TipoCambio           float,
    @OModulo              varchar(20),
    @OID                  int,
    @FechaEmision         datetime

  SET @FechaEmision = dbo.fnFechaSinHora(GETDATE())  

  IF @MovTipo = 'DIN.A'
  BEGIN
    SELECT @DineroMov =  CajaApertura 
      FROM EmpresaCfgMov WHERE Empresa = @Empresa
      
    IF NULLIF(@DineroMov,'') IS NULL 
      SELECT @Ok = 70130, @OkRef = @OkRef +'Apertura Caja'      
  END  

  IF @MovTipo = 'DIN.CP'
  BEGIN
    SELECT @DineroMov =  CajaCorteParc   
      FROM EmpresaCfgMovDinero WHERE Empresa = @Empresa
    IF NULLIF(@DineroMov,'') IS NULL 
      SELECT @Ok = 70130 , @OkRef = @OkRef +'Corte Parcial Caja'           
  END    
        
            
    
    
  IF (@Accion = 'AFECTAR'  AND @MovTipo = 'DIN.A'   AND @SubClave ='DIN.AMULTIMONEDA' AND @EstatusNuevo = 'CONCLUIDO') OR
     (@Accion = 'AFECTAR'  AND @MovTipo = 'DIN.CP'   AND @SubClave ='DIN.CPMULTIMONEDA' AND @EstatusNuevo = 'CONCLUIDO') AND @Ok IS NULL  
  BEGIN
    DECLARE crMoneda CURSOR FOR
     SELECT d.Moneda,d.CtaDinero,d.CtaDineroDestino,d.TipoCambio
       FROM DineroD d JOIN CtaDinero c ON d.CtaDinero = c.CtaDinero
      WHERE d.ID = @ID 
      GROUP BY d.Moneda, d.CtaDinero, d.CtaDineroDestino, d.TipoCambio 
    
    OPEN crMoneda
    FETCH NEXT FROM crMoneda INTO @Moneda, @CtaDinero, @CtaDineroDestino, @TipoCambio
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
    
      IF @Moneda IS NULL
      SELECT @Ok = 35040
      IF EXISTS(SELECT *  FROM Dinero d JOIN MovTipo m ON d.Mov = m.Mov AND m.Modulo = 'DIN'  WHERE d.Empresa = @Empresa AND d.Origen = @Mov AND d.OrigenID = @MovID AND Estatus = 'CONCLUIDO' ) AND @MovTipo = 'DIN.A'
      BEGIN
        SELECT @DineroMov = CajaAumento
          FROM EmpresaCfgMovDinero 
         WHERE Empresa = @Empresa
         
        IF NULLIF(@DineroMov,'') IS NULL 
          SELECT @Ok = 70130 , @OkRef = @OkRef +'Aumento Caja'      
      END  
      
      IF  @Ok IS NULL
      INSERT Dinero (Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, Mov,         FechaEmision,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Usuario, Referencia, Observaciones, Estatus,      CtaDinero, CtaDineroDestino, Cajero,   ConDesglose, OrigenTipo, Origen, OrigenID,Prioridad)
      SELECT         Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, @DineroMov,  @FechaEmision, Concepto,  Proyecto,  @Moneda, @TipoCambio, Usuario, Referencia, Observaciones, 'SINAFECTAR', @CtaDinero, @CtaDineroDestino,Cajero,   1,           'DIN',      Mov,    MovID,Prioridad
        FROM Dinero WHERE ID = @ID
      IF @@ERROR <> 0 SELECT @Ok = 1
      
      SELECT @DineroID = SCOPE_IDENTITY()
     
      IF @Ok IS NULL AND @DineroID IS NOT NULL
      BEGIN
        DECLARE crDetalle CURSOR FOR
         SELECT d.Importe ,d.FormaPago,d.Referencia,d.Sucursal
           FROM DineroD d JOIN CtaDinero c ON d.CtaDinero = c.CtaDinero
          WHERE d.ID = @ID
            AND  d.CtaDinero =@CtaDinero
            AND d.CtaDineroDestino = @CtaDineroDestino
            AND d.Moneda = @Moneda
           
        SET @Renglon = 2048.0   
        OPEN crDetalle
        FETCH NEXT FROM crDetalle INTO @Importe, @FormaPago, @Referencia,@SucursalD
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN 
        
          INSERT DineroD (Sucursal,   ID,         Renglon,  Importe,  FormaPago,  Referencia) 
          SELECT          @SucursalD, @DineroID,  @Renglon, @Importe, @FormaPago, @Referencia
          IF @@ERROR <> 0 SELECT @Ok = 1
          SET @Renglon = @Renglon + 2048.0

        FETCH NEXT FROM crDetalle INTO  @Importe, @FormaPago, @Referencia,@SucursalD
        END 
        CLOSE crDetalle
        DEALLOCATE crDetalle       
      
      END
  
      IF @Ok IS NULL AND @DineroID IS NOT NULL
      BEGIN
    
        SELECT @ImporteTotal = SUM(Importe) FROM DineroD WHERE ID = @DineroID

        UPDATE Dinero SET Importe = ISNULL(@ImporteTotal,0.0) WHERE ID = @DineroID   
        IF @@ERROR <> 0 SET @Ok = 1
           
        EXEC spAfectar 'DIN', @DineroID, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        
        SELECT @MovIDGenerar = MovID FROM Dinero WHERE ID = @DineroID	
        
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @MovIDGenerar, @Ok OUTPUT   
      END
    FETCH NEXT FROM crMoneda INTO  @Moneda,@CtaDinero,@CtaDineroDestino,@TipoCambio
    END 
    CLOSE crMoneda
    DEALLOCATE crMoneda   
  END
  IF (@Accion = 'CANCELAR'  AND @MovTipo = 'DIN.A'   AND @SubClave ='DIN.AMULTIMONEDA' AND @EstatusNuevo = 'CANCELADO')OR  
     (@Accion = 'CANCELAR'  AND @MovTipo = 'DIN.C'   AND @SubClave ='DIN.CMULTIMONEDA' AND @EstatusNuevo = 'CANCELADO')OR  
     (@Accion = 'CANCELAR'  AND @MovTipo = 'DIN.CP'   AND @SubClave ='DIN.CPMULTIMONEDA' AND @EstatusNuevo = 'CANCELADO')  
  BEGIN
    DECLARE crCancelar CURSOR FOR
     SELECT DModulo, DID 
       FROM MovFlujo 
      WHERE OID = @ID AND OModulo = 'DIN' and Empresa = @Empresa
    ORDER BY DID  DESC

   
    OPEN crCancelar
    FETCH NEXT FROM crCancelar INTO  @OModulo,@OID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
 
      EXEC spAfectar @OModulo, @OID, 'CANCELAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    FETCH NEXT FROM crCancelar INTO  @OModulo,@OID
    END 
    CLOSE crCancelar
    DEALLOCATE crCancelar   
  
  
  END

END
GO


/**************** spDineroGenerarCorteMultimoneda****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroGenerarCorteMultimoneda') and type = 'P') drop procedure dbo.spDineroGenerarCorteMultimoneda
GO
CREATE PROCEDURE spDineroGenerarCorteMultimoneda
		    @Accion			varchar(20),
    		    @Empresa          		varchar(5),
		    @Sucursal	      		int,
	            @Usuario			varchar(10),
    		    @ID               		int,
		    @Mov			varchar(20),
	            @MovID			varchar(20),
	            @MovTipo                    varchar(20),
	            @SubClave                   varchar(20),
	            @Estatus                    varchar(15),
	            @EstatusNuevo               varchar(15),
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda               varchar(10),
    @MonedaCont           varchar(10),
    @DineroID             int,
    @DineroMov            varchar(20),
    @CorteMov             varchar(20),
    @CtaDinero            varchar(10),               
    @CtaDineroDestino	  varchar(10),
    @Importe              money,
    @ImporteTotal         money,
    @FormaPago            varchar(50),
    @Referencia           varchar(50),
    @Renglon              float,
    @SucursalD            int,
    @MovIDGenerar         varchar(20),
    @TipoCambio           float,
    @OModulo              varchar(20),
    @OID                  int,
    @FechaEmision         datetime,
    @RID                  int,
    @LID                  int
    
    
    
  DECLARE @Tabla table
  (
   ID                   int IDENTITY(1,1),
   Moneda               varchar(10),
   CtaDinero            varchar(10),
   CtaDineroDestino     varchar(10),  
   TipoCambio           float  
  )  
    

  SELECT @MonedaCont = ContMoneda
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 
 
  INSERT @Tabla(Moneda,CtaDinero,CtaDineroDestino,TipoCambio)    
  SELECT d.Moneda,d.CtaDinero,d.CtaDineroDestino,d.TipoCambio
    FROM DineroD d JOIN CtaDinero c ON d.CtaDinero = c.CtaDinero
   WHERE d.ID = @ID 
   GROUP BY d.Moneda, d.CtaDinero, d.CtaDineroDestino, d.TipoCambio 
   
  SELECT @RID = MAX(ID) FROM @Tabla
  


  SET @FechaEmision = dbo.fnFechaSinHora(GETDATE())  

  SELECT @DineroMov =  CajaCorteParc   
    FROM EmpresaCfgMovDinero WHERE Empresa = @Empresa    
  
  IF @Accion = 'AFECTAR'  AND @MovTipo = 'DIN.C'   AND @SubClave ='DIN.CMULTIMONEDA' AND @EstatusNuevo = 'CONCLUIDO'
   BEGIN
    DECLARE crMoneda CURSOR FOR
     SELECT ID, Moneda,CtaDinero,CtaDineroDestino,TipoCambio
       FROM @Tabla
      ORDER BY ID ASC
    
    OPEN crMoneda
    FETCH NEXT FROM crMoneda INTO @LID, @Moneda, @CtaDinero, @CtaDineroDestino, @TipoCambio
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
      IF @Moneda IS NULL
      SELECT @Ok = 35040       

      IF @LID = @RID
      SELECT @DineroMov = CajaCorteCaja
        FROM EmpresaCfgMov 
       WHERE Empresa = @Empresa
      IF @Ok IS NULL       
      INSERT Dinero (Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, Mov,         FechaEmision,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Usuario, Referencia, Observaciones, Estatus,      CtaDinero, CtaDineroDestino, Cajero,   ConDesglose, Prioridad)
      SELECT         Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, @DineroMov,  @FechaEmision, Concepto,  Proyecto,  @Moneda, @TipoCambio, Usuario, Referencia, Observaciones, 'SINAFECTAR', @CtaDinero, @CtaDineroDestino,Cajero,   1,          Prioridad
        FROM Dinero WHERE ID = @ID
      IF @@ERROR <> 0 SELECT @Ok = 1
      
      SELECT @DineroID = SCOPE_IDENTITY()
     
      IF @Ok IS NULL  AND EXISTS(SELECT * FROM DineroD WHERE ID = @ID AND CtaDinero =@CtaDinero AND CtaDineroDestino = @CtaDineroDestino AND Moneda = @Moneda)
      BEGIN
        DECLARE crDetalle CURSOR FOR
         SELECT d.Importe ,d.FormaPago,d.Referencia,d.Sucursal
           FROM DineroD d JOIN CtaDinero c ON d.CtaDinero = c.CtaDinero
          WHERE d.ID = @ID
            AND  d.CtaDinero =@CtaDinero
            AND d.CtaDineroDestino = @CtaDineroDestino
            AND d.Moneda = @Moneda
           
        SET @Renglon = 2048.0   
        OPEN crDetalle
        FETCH NEXT FROM crDetalle INTO @Importe, @FormaPago, @Referencia,@SucursalD
        WHILE @@FETCH_STATUS = 0 --AND @Ok IS NULL
        BEGIN 
        
          INSERT DineroD (Sucursal,   ID,         Renglon,  Importe,  FormaPago,  Referencia) 
          SELECT          @SucursalD, @DineroID,  @Renglon, @Importe, @FormaPago, @Referencia
          IF @@ERROR <> 0 SELECT @Ok = 1
          SET @Renglon = @Renglon + 2048.0

        FETCH NEXT FROM crDetalle INTO  @Importe, @FormaPago, @Referencia,@SucursalD
        END 
        CLOSE crDetalle
        DEALLOCATE crDetalle       
      END
      IF NOT EXISTS(SELECT * FROM DineroD WHERE ID = @ID AND CtaDinero =@CtaDinero AND CtaDineroDestino = @CtaDineroDestino AND Moneda = @Moneda)
      BEGIN
        INSERT DineroD (Sucursal,   ID,         Renglon,  Importe,  FormaPago,  Referencia) 
        SELECT          @Sucursal, @DineroID,  2048.0,   0.0,       NULL,      NULL
        IF @@ERROR <> 0 SELECT @Ok = 1      
      END  
      IF @Ok IS NULL AND @DineroID IS NOT NULL
      BEGIN
        SELECT @ImporteTotal = SUM(Importe) FROM DineroD WHERE ID = @DineroID

        UPDATE Dinero SET Importe = ISNULL(@ImporteTotal,0.0) WHERE ID = @DineroID   
        IF @@ERROR <> 0 SET @Ok = 1

        EXEC spAfectar 'DIN', @DineroID, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        
        SELECT @MovIDGenerar = MovID FROM Dinero WHERE ID = @DineroID	
        
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @MovIDGenerar, @Ok OUTPUT   
      END
    FETCH NEXT FROM crMoneda INTO  @LID, @Moneda, @CtaDinero, @CtaDineroDestino, @TipoCambio
    END 
    CLOSE crMoneda
    DEALLOCATE crMoneda   
  END

END
GO

   /**************** spDineroVerificarCorteMultimoneda ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spDineroVerificarCorteMultimoneda') and type = 'P') drop procedure dbo.spDineroVerificarCorteMultimoneda
GO             
CREATE PROCEDURE spDineroVerificarCorteMultimoneda

                   @ID                  int,
                   @Renglon             float,
                   @Empresa             varchar(5),
                   @Estatus             varchar(15),
                   @MovTipo             varchar(20),
                   @FormaPagoD		varchar(50),
                   @ReferenciaD	        varchar(50),
                   @ImporteD		money,                   
        	   @Ok                  int	        OUTPUT,
        	   @OkRef		varchar(255)	OUTPUT		
        	   
      	   
		           
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

        @CtaDinero	        varchar(10),
        @CtaDineroTipo		varchar(20), 
        @CtaDineroDestinoTipo	varchar(20),        
        @CtaDineroDestino	varchar(10),
        @CtaDineroMoneda	varchar(10),
        @CtaEmpresa		varchar(5)
        
        
  SELECT @CtaDinero =  CtaDineroDestino    ,@CtaDineroDestino=    CtaDinero FROM DineroD WHERE ID = @ID AND Renglon = @Renglon   
  SELECT @CtaDineroTipo = UPPER(Tipo), @CtaDineroMoneda = Moneda, @CtaEmpresa = NULLIF(RTRIM(Empresa), '') FROM CtaDinero WHERE CtaDinero = @CtaDinero 
  
  SELECT @CtaDineroDestinoTipo = UPPER(Tipo)FROM CtaDinero WHERE CtaDinero = @CtaDineroDestino
  
  IF  @CtaDineroTipo <> 'CAJA'   
    IF @CtaDinero IS NULL SELECT @Ok = 40120

  IF @MovTipo IN ('DIN.T', 'DIN.TI', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP', 'DIN.CP', 'DIN.C')
  BEGIN
    IF @CtaDineroDestino IS NULL SELECT @Ok = 40040 ELSE 
    IF @CtaDineroDestino = @CtaDinero AND @Estatus = 'SINAFECTAR' SELECT @Ok = 40050
  END

  IF @CtaDineroTipo = 'CAJA' OR @CtaDineroDestinoTipo <> 'CAJA'
   SELECT @Ok = 30460     
  
  IF @CtaDineroTipo = 'ESTRUCTURA' OR @CtaDineroDestinoTipo = 'ESTRUCTURA' SELECT @Ok = 20680  

END
GO




   /**************** spDineroVerificarAperturaMultimoneda ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spDineroVerificarAperturaMultimoneda') and type = 'P') drop procedure dbo.spDineroVerificarAperturaMultimoneda
GO             
CREATE PROCEDURE spDineroVerificarAperturaMultimoneda

                   @ID                  int,
                   @Renglon             float,
                   @Empresa             varchar(5),
                   @Estatus             varchar(15),
                   @MovTipo             varchar(20),
                   @FormaPagoD		varchar(50),
                   @ReferenciaD	        varchar(50),
                   @ImporteD		money,                   
        	   @Ok                  int	        OUTPUT,
        	   @OkRef		varchar(255)	OUTPUT		
        	   
      	   
		           
--//WITH ENCRYPTION
AS BEGIN
  DECLARE

        @CtaDinero	        varchar(10),
        @CtaDineroTipo		varchar(20), 
        @CtaDineroDestinoTipo	varchar(20),        
        @CtaDineroDestino	varchar(10),
        @CtaDineroMoneda	varchar(10),
        @CtaEmpresa		varchar(5)
        
        
  SELECT @CtaDinero =  CtaDinero    ,@CtaDineroDestino=    CtaDineroDestino FROM DineroD WHERE ID = @ID AND Renglon = @Renglon   
  SELECT @CtaDineroTipo = UPPER(Tipo), @CtaDineroMoneda = Moneda, @CtaEmpresa = NULLIF(RTRIM(Empresa), '') FROM CtaDinero WHERE CtaDinero = @CtaDinero 
  
  SELECT @CtaDineroDestinoTipo = UPPER(Tipo)FROM CtaDinero WHERE CtaDinero = @CtaDineroDestino
  
  IF  @CtaDineroTipo <> 'CAJA'   
    IF @CtaDinero IS NULL SELECT @Ok = 40120

  IF @MovTipo IN ('DIN.T', 'DIN.TI', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP', 'DIN.CP', 'DIN.C')
  BEGIN
    IF @CtaDineroDestino IS NULL SELECT @Ok = 40040 ELSE 
    IF @CtaDineroDestino = @CtaDinero AND @Estatus = 'SINAFECTAR' SELECT @Ok = 40050
  END

  IF @CtaDineroTipo = 'CAJA' OR @CtaDineroDestinoTipo <> 'CAJA'
   SELECT @Ok = 30460     
  
  IF @CtaDineroTipo = 'ESTRUCTURA' OR @CtaDineroDestinoTipo = 'ESTRUCTURA' SELECT @Ok = 20680  

END
GO 
 

/**************** spDineroGenerarTCMultimoneda****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroGenerarTCMultimoneda') and type = 'P') drop procedure dbo.spDineroGenerarTCMultimoneda
GO
CREATE PROCEDURE spDineroGenerarTCMultimoneda
		    @Accion			varchar(20),
    		    @Empresa          		varchar(5),
		    @Sucursal	      		int,
	            @Usuario			varchar(10),
    		    @ID               		int,
		    @Mov			varchar(20),
	            @MovID			varchar(20),
	            @MovTipo                    varchar(20),
	            @SubClave                   varchar(20),
	            @Estatus                    varchar(15),
	            @EstatusNuevo               varchar(15),
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda               varchar(10),
    @DineroID             int,
    @DineroMov            varchar(20),
    @CtaDinero            varchar(10),               
    @CtaDineroDestino	  varchar(10),
    @Importe              money,
    @ImporteTotal         money,
    @FormaPago            varchar(50),
    @Referencia           varchar(50),
    @Renglon              float,
    @SucursalD            int,
    @MovIDGenerar         varchar(20),
    @TipoCambio           float,
    @OModulo              varchar(20),
    @OID                  int,
    @FechaEmision         datetime,
    @RequiereReferencia   bit

  SET @FechaEmision = dbo.fnFechaSinHora(GETDATE())  

  SELECT @DineroMov = CajaTransferencia
    FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
  IF (@Accion = 'AFECTAR'  AND @MovTipo = 'DIN.TC'   AND @SubClave ='DIN.TCMULTIMONEDA' AND @EstatusNuevo = 'CONCLUIDO')   
  BEGIN
    DECLARE crMoneda CURSOR FOR
     SELECT Importe, FormaPago,   CtaDinero, CtaDineroDestino, Moneda, TipoCambio
       FROM DineroD 
      WHERE ID = @ID 
    
    OPEN crMoneda
    FETCH NEXT FROM crMoneda INTO @Importe, @FormaPago,  @CtaDinero, @CtaDineroDestino, @Moneda, @TipoCambio
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN  
      SELECT @RequiereReferencia = ISNULL(RequiereReferencia, 0)
        FROM FormaPago 
       WHERE FormaPago = @FormaPago

      INSERT Dinero (Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, Mov,        Importe,  FechaEmision,  Concepto,  Proyecto,  Moneda,  TipoCambio,  Usuario, Referencia, Observaciones, Estatus,      CtaDinero, CtaDineroDestino, Cajero,   ConDesglose, OrigenTipo, Origen, OrigenID,Prioridad,FormaPago)
      SELECT         Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa, @DineroMov, @Importe, @FechaEmision, Concepto,  Proyecto,  @Moneda, @TipoCambio, Usuario, CASE WHEN @RequiereReferencia = 1 THEN ISNULL(Referencia,'(Varios)') ELSE Referencia END , Observaciones, 'SINAFECTAR', @CtaDinero, @CtaDineroDestino,Cajero,   0,           OrigenTipo,      Mov,    MovID,Prioridad, @FormaPago
        FROM Dinero WHERE ID = @ID
      IF @@ERROR <> 0 SELECT @Ok = 1
      
      SELECT @DineroID = SCOPE_IDENTITY()
     
      IF @Ok IS NULL AND @DineroID IS NOT NULL
      BEGIN
        EXEC spAfectar 'DIN', @DineroID, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        
        SELECT @MovIDGenerar = MovID FROM Dinero WHERE ID = @DineroID	
        
        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @MovIDGenerar, @Ok OUTPUT   
      END
    FETCH NEXT FROM crMoneda INTO  @Importe, @FormaPago,  @CtaDinero, @CtaDineroDestino, @Moneda, @TipoCambio
    END 
    CLOSE crMoneda
    DEALLOCATE crMoneda   
  END
  IF (@Accion = 'CANCELAR'  AND @MovTipo = 'DIN.TC'   AND @SubClave ='DIN.TCMULTIMONEDA' AND @EstatusNuevo = 'CANCELADO')  
  BEGIN
    DECLARE crCancelar CURSOR FOR
     SELECT DModulo, DID 
       FROM MovFlujo 
      WHERE OID = @ID AND OModulo = 'DIN' and Empresa = @Empresa
    ORDER BY DID  
    
    OPEN crCancelar
    FETCH NEXT FROM crCancelar INTO  @OModulo,@OID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
 
      EXEC spAfectar @OModulo, @OID, 'CANCELAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    FETCH NEXT FROM crCancelar INTO  @OModulo,@OID
    END 
    CLOSE crCancelar
    DEALLOCATE crCancelar   
  
  
  END

END
GO 

/**************** spDineroAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAplicar') and type = 'P') drop procedure dbo.spDineroAplicar
GO             
CREATE PROCEDURE spDineroAplicar
		    @Sucursal			int, 	
                    @ID		  		int,
		    @Accion			char(20),
                    @Empresa			char(5),
		    @Usuario			char(10),
        	    @Modulo			char(5),
		    @Mov			char(20),
		    @MovID			varchar(20),
		    @MovTipo			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,

		    @FechaEmision		datetime,
		    @FechaRegistro		datetime,
		    @FechaAfectacion		datetime, 
		    @Ejercicio			int, 
		    @Periodo			int,

		    @CtaDinero			char(10),
		    @CtaDineroFactor		float,
		    @CtaDineroTipoCambio	float,
		    @ImporteTotal		money,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),

		    @VerificarAplica		bit,
		    @Ok 			int		OUTPUT, 
		    @OkRef 			varchar(255)	OUTPUT,
		    @EstacionTrabajo int = NULL -- REQ12336
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @EsCargo		bit,
    @Abono		bit,
    @IDAplica		int,
    @AplicaMov		char(20),
    @AplicaMovID	varchar(20),
    @AplicaMovTipo	char(20),
    @AplicaEstatus	char(15),
    @AplicaEstatusNuevo	char(15),
    @AplicaImporte	money,
    @AplicaMoneda	char(10),
    @AplicaContacto	char(10),
    @AplicaContactoTipo	varchar(20),
    @AplicaFactor	float,
    @AplicaTotal	money,
    @AplicaTipoCambio	float,
    @CxModulo		char(5),
    @CxID 		int,
    @CxEsCargo		bit,
    @CxContacto		char(10),
    @CxImporte		money,
    @Contacto		char(10),
    @ContactoTipo	varchar(20),
    @Saldo		money,
    @SaldoNuevo		money,
    @CtaDineroImporte	money,
    @ImporteAplicado	money,
    @ImporteDetalle	money,
    @Renglon		float,
    @PrimeraVez		bit,
    @PPTO		bit,
    
    -- 9319
    @AplicaFechaEmision		datetime,
    @AplicaEjercicio		int,
    @AplicaPeriodo			int,
--23579
	@Proyecto           varchar(50),
    @AplicaProyecto     varchar(50),
    @CP                 bit

  SELECT @PPTO = PPTO, @CP = ISNULL(CP,0)  FROM EmpresaGral WHERE Empresa = @Empresa

  IF @VerificarAplica = 0
  BEGIN
    CREATE TABLE #DineroAplicaMovImpuesto (
	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	SubTotal		money		NULL,
        TipoImpuesto1		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto2		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto3		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion1		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion2		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion3		varchar(10)	COLLATE Database_Default NULL,
        LoteFijo		varchar(20)	COLLATE Database_Default NULL,
	OrigenModulo		varchar(5)	COLLATE Database_Default NULL,
	OrigenModuloID		int		NULL,
	OrigenConcepto		varchar(50)	COLLATE Database_Default NULL,
	OrigenDeducible		float		NULL	DEFAULT 100, 
        OrigenFecha		datetime	NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,
	Excento1		bit		NULL	DEFAULT 0,
	Excento2		bit		NULL	DEFAULT 0,
	Excento3		bit		NULL	DEFAULT 0,
	ContUso			varchar(20)	COLLATE Database_Default NULL,
	ContUso2		varchar(20)	COLLATE Database_Default NULL,
	ContUso3		varchar(20)	COLLATE Database_Default NULL,
	ClavePresupuestal		varchar(50)	COLLATE Database_Default NULL,
	ClavePresupuestalImpuesto1	varchar(50)	COLLATE Database_Default NULL,
	DescuentoGlobal		float		NULL
    )

    IF @PPTO = 1
      CREATE TABLE #DineroAplicaMovPresupuesto (
  	  Importe		money		NULL,
          CuentaPresupuesto	varchar(20)	COLLATE Database_Default NULL)
  END
  SELECT @Proyecto = NULLIF(Proyecto,'') FROM Dinero WHERE ID = @ID
  SELECT @ImporteAplicado = 0.0, @PrimeraVez = 1, @Contacto = NULL, @ContactoTipo = NULL
  DECLARE crDineroDetalle CURSOR FOR 
   SELECT NULLIF(RTRIM(d.Aplica), ''), d.AplicaID, ISNULL(SUM(d.Importe), 0.0), mt.Clave
     FROM DineroD d, MovTipo mt
    WHERE ID = @ID AND mt.Modulo = 'DIN' AND mt.Mov = d.Aplica
    GROUP BY mt.Clave, NULLIF(RTRIM(d.Aplica), ''), d.AplicaID
    ORDER BY mt.Clave, NULLIF(RTRIM(d.Aplica), ''), d.AplicaID

  OPEN crDineroDetalle
  FETCH NEXT FROM crDineroDetalle INTO @AplicaMov, @AplicaMovID, @AplicaImporte, @AplicaMovTipo
  IF @@ERROR <> 0 SELECT @Ok = 1
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @AplicaImporte <> 0.0 AND @Ok IS NULL
    BEGIN
      SELECT @CtaDineroImporte = @AplicaImporte / @CtaDineroFactor
      SELECT @IDAplica = NULL, @Saldo = NULL
      -- 9319
      SELECT @IDAplica = ID, @Saldo = ISNULL(Saldo, 0.0), @AplicaEstatus = Estatus, @AplicaMoneda = NULLIF(RTRIM(Moneda), ''), @AplicaContacto = Contacto, @AplicaContactoTipo = ContactoTipo, @AplicaTotal = Importe, @AplicaTipoCambio = TipoCambio,
			 @AplicaFechaEmision = FechaEmision, @AplicaEjercicio = Ejercicio, @AplicaPeriodo = Periodo, @AplicaProyecto = NULLIF(Proyecto,'')
        FROM Dinero
       WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'POSFECHADO', 'CANCELADO')
      IF @@ERROR <> 0 SELECT @Ok = 1
   
      IF  @CP = 1
        IF @Proyecto <> @AplicaProyecto
          SET @Ok = 70216
      IF @Ok IS NULL AND @Accion <> 'CANCELAR'
        EXEC spValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
  								      @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								      @OkRef = @OkRef OUTPUT
      IF @Ok IS NULL AND @Accion <> 'CANCELAR'
        EXEC spEmpresaValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								             @AplicaMov, @AplicaMovID, @Modulo, @IDAplica, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								             @OkRef = @OkRef OUTPUT

      IF @VerificarAplica = 0 AND @IDAplica IS NOT NULL
      BEGIN

        IF NULLIF(RTRIM(@AplicaMoneda), '') <> NULLIF(RTRIM(@MovMoneda), '') SELECT @AplicaFactor = (@AplicaImporte * @MovTipoCambio) / NULLIF(CONVERT(float, @AplicaTotal * @AplicaTipoCambio), 0)
		ELSE SELECT @AplicaFactor = (@AplicaImporte) / NULLIF(CONVERT(float, @AplicaTotal), 0)

        EXEC xpDineroAplicaFactorMovImpuesto @Sucursal, @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @IDAplica, @AplicaMov, @AplicaMovID, @AplicaMovTipo, @AplicaImporte, @VerificarAplica, @AplicaFactor OUTPUT, @Ok OUTPUT,  @OkRef OUTPUT

        INSERT #DineroAplicaMovImpuesto (
               OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible, OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,               Importe2,               Importe3,               SubTotal,               ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
        SELECT OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible, OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@AplicaFactor, Importe2*@AplicaFactor, Importe3*@AplicaFactor, SubTotal*@AplicaFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
          FROM MovImpuesto
         WHERE Modulo = @Modulo
           AND ModuloID = @IDAplica

        IF @PPTO = 1 
          INSERT #DineroAplicaMovPresupuesto
                (CuentaPresupuesto, Importe)
          SELECT CuentaPresupuesto, Importe*@AplicaFactor
            FROM MovPresupuesto
           WHERE Modulo = @Modulo
             AND ModuloID = @IDAplica
      END

      IF @VerificarAplica = 1 
      BEGIN
        IF @PrimeraVez = 1
          SELECT @PrimeraVez = 0, @Contacto = @AplicaContacto, @ContactoTipo = @AplicaContactoTipo
        ELSE
          IF @MovTipo IN ('DIN.CH', 'DIN.CHE') AND (@Contacto <> @AplicaContacto OR @ContactoTipo <> @AplicaContactoTipo)
          BEGIN
            IF EXISTS(SELECT * FROM EmpresaGral WHERE Empresa = @Empresa AND ContAuto = 1 AND ContAutoChequesMultiContacto = 0) AND 
               (SELECT NULLIF(RTRIM(ContMov), '') FROM MovClave WHERE Modulo = @Modulo AND Clave = @MovTipo) IS NOT NULL
              SELECT @Ok = 40180
          END
        EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @IDAplica, @Ok OUTPUT, @OkRef OUTPUT
      END

      IF (@MovTipo IN ('DIN.CH', 'DIN.CHE','DIN.E', 'DIN.F') AND @AplicaMovTipo NOT IN ('DIN.SCH', 'DIN.E', 'DIN.F')) OR
         (@MovTipo IN ('DIN.D', 'DIN.DE', 'DIN.I') AND @AplicaMovTipo NOT IN ('DIN.SD',  'DIN.I', 'DIN.TI')) OR 
         (@MovTipo IN ('DIN.INV', 'DIN.RET') AND @AplicaMovTipo NOT IN ('DIN.INV'))
        SELECT @Ok = 20180

      -- si no encontro el registro
      IF @Saldo IS NULL SELECT @Ok = 30120
      IF @AplicaMoneda <> @MovMoneda AND @Ok IS NULL SELECT @Ok = 30280
      IF @Accion <> 'CANCELAR' AND @Ok IS NULL
      BEGIN
        IF @AplicaEstatus <> 'PENDIENTE' SELECT @Ok = 30060
        IF ROUND(@Saldo, 2) < ROUND(@CtaDineroImporte, 2) SELECT @Ok = 30070 
      END
      IF @Ok IS NULL
      BEGIN
        IF @VerificarAplica = 0
        BEGIN
          IF @Accion <> 'CANCELAR' SELECT @EsCargo = 0, @ImporteDetalle = - @CtaDineroImporte ELSE SELECT @EsCargo = 1, @ImporteDetalle = @CtaDineroImporte 

          SELECT @CxID = NULL, @CxEsCargo = 0
          IF @AplicaMovTipo IN ('DIN.SD', 'DIN.SCH')
          BEGIN
            IF @AplicaContactoTipo = 'Cliente'   SELECT @CxModulo = 'CXC' ELSE
            IF @AplicaContactoTipo = 'Proveedor' SELECT @CxModulo = 'CXP'

            IF @CxModulo = 'CXC' SELECT @CxID = ID, @CxContacto = Cliente   FROM Cxc WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
            IF @CxModulo = 'CXP' SELECT @CxID = ID, @CxContacto = Proveedor FROM Cxp WHERE Empresa = @Empresa AND Mov = @AplicaMov AND MovID = @AplicaMovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') 

            IF (@AplicaMovTipo = 'DIN.SCH' AND @CxModulo = 'CXC') OR (@AplicaMovTipo = 'DIN.SD' AND @CxModulo = 'CXP') SELECT @CxEsCargo = 1
          END

          -- Actualizar Saldo del Movimiento

          /** JH 25.10.2006 **/
          IF @Accion = 'CANCELAR' 
            SELECT @SaldoNuevo = @Saldo + @ImporteDetalle
          ELSE
            SELECT @SaldoNuevo = ROUND(@Saldo + @ImporteDetalle, 0)
          /** JH 25.10.2006 **/

          IF @SaldoNuevo = 0.0
          BEGIN
            SELECT @AplicaEstatusNuevo = 'CONCLUIDO'
            EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
            UPDATE Dinero SET Saldo = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaEmision WHERE ID = @IDAplica
            IF @CxID IS NOT NULL
            BEGIN
              IF @CxModulo = 'CXC' UPDATE Cxc SET Saldo = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaEmision WHERE ID = @CxID ELSE
              IF @CxModulo = 'CXP' UPDATE Cxp SET Saldo = NULL, Estatus = @AplicaEstatusNuevo, FechaConclusion = @FechaEmision WHERE ID = @CxID
            END
          END ELSE 
          BEGIN
            SELECT @AplicaEstatusNuevo = 'PENDIENTE'
            EXEC spValidarTareas @Empresa, @Modulo, @IDAplica, @AplicaEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
            UPDATE Dinero SET Saldo = @Saldo + @ImporteDetalle, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL WHERE ID = @IDAplica
            IF @CxID IS NOT NULL
            BEGIN
              IF @CxModulo = 'CXC' UPDATE Cxc SET Saldo = @Saldo + @ImporteDetalle, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL WHERE ID = @CxID ELSE
              IF @CxModulo = 'CXP' UPDATE Cxp SET Saldo = @Saldo + @ImporteDetalle, Estatus = @AplicaEstatusNuevo, FechaConclusion = NULL WHERE ID = @CxID
            END
          END
          IF @CxID IS NOT NULL
          BEGIN
            SELECT @CxImporte = -@ImporteDetalle
            EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @CxModulo, @MovMoneda, @MovTipoCambio, @CxContacto, NULL, NULL, NULL,
                         @Modulo, @ID, @Mov, @MovID, @CxEsCargo, @CxImporte, NULL, NULL,
                         @FechaAfectacion, @Ejercicio, @Periodo, @AplicaMov, @AplicaMovID, 0, 0, 0,
                         @Ok OUTPUT, @OkRef OUTPUT
          END

          -- Agregar a Estatus Log
          IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
            EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @IDAplica, @AplicaEstatus, @AplicaEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @AplicaMov, @AplicaMovID, @AplicaMovTipo, NULL, @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo -- REQ12336

          -- Registrar el Flujo	
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDAplica, @AplicaMov, @AplicaMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
        END
      END

      -- Checar Que no pongan importes negativos
      IF @AplicaImporte < 0.0 AND @MovTipo NOT IN ('DIN.C', 'DIN.CP', 'DIN.D', 'DIN.RE', 'DIN.REI', 'DIN.RND', 'DIN.CB', 'DIN.AB') SELECT @Ok = 30100

      IF @Ok IS NOT NULL 
        SELECT @OkRef = RTRIM(@AplicaMov)+' '+LTRIM(Convert(char, @AplicaMovID))

      -- Acumular Importe por Linea
      IF @Ok IS NULL 
        SELECT @ImporteAplicado = @ImporteAplicado + @AplicaImporte
    END -- Fetch_Status <> 2
    FETCH NEXT FROM crDineroDetalle INTO @AplicaMov, @AplicaMovID, @AplicaImporte, @AplicaMovTipo
    IF @@ERROR <> 0 SELECT @Ok = 1
  END -- While
  CLOSE crDineroDetalle
  DEALLOCATE crDineroDetalle

  IF @Ok IS NULL AND @ImporteAplicado < @ImporteTotal AND @Accion <> 'CANCELAR' SELECT @Ok = 30070

  IF @VerificarAplica = 1 AND @MovTipo IN ('DIN.CH', 'DIN.CHE')
    UPDATE Dinero SET Contacto = @Contacto, ContactoTipo = @ContactoTipo WHERE ID = @ID AND (Contacto <> @Contacto OR ContactoTipo <> @ContactoTipo)

  IF @VerificarAplica = 0
  BEGIN
    DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
    IF EXISTS(SELECT * FROM #DineroAplicaMovImpuesto)
    BEGIN
      INSERT MovImpuesto (
             Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		    OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,      Importe2,      Importe3,      SubTotal,      ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
      SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(SubTotal), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
        FROM #DineroAplicaMovImpuesto
       GROUP BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
       ORDER BY OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
    END
    IF @PPTO = 1
    BEGIN
      DELETE MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ID
      IF EXISTS(SELECT * FROM #DineroAplicaMovPresupuesto)
      BEGIN
        INSERT MovPresupuesto
              (Modulo,  ModuloID, CuentaPresupuesto, Importe)
        SELECT @Modulo, @ID,      CuentaPresupuesto, SUM(Importe)
          FROM #DineroAplicaMovPresupuesto
         GROUP BY CuentaPresupuesto
         ORDER BY CuentaPresupuesto
      END
    END
  END

  RETURN
END
GO

/**************** spDineroFaltanteSobrante ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroFaltanteSobrante') and type = 'P') drop procedure dbo.spDineroFaltanteSobrante
GO
CREATE PROCEDURE spDineroFaltanteSobrante
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Sucursal	      		int,
	            @Usuario			char(10),
    		    @ID               		int,
		    @Mov			char(20),
	            @MovID			varchar(20),
		    @CajeroSaldo      		money,
		    @CtaDinero			char(10),
		    @CtaDineroMoneda		char(10),
		    @TieneSaldoOtrasMonedas	bit,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro	datetime,
    @DineroID		int,
    @DineroMov		char(20),
    @DineroMovID	varchar(20),
    @FormaPago		varchar(50),
    @MovFaltanteCaja  	varchar(20),
    @MovSobranteCaja  	varchar(20),
    @ConDesglose	bit,
    @Moneda		char(10),
    @Importe		money,
    @IDGenerar		int 

  SELECT @FechaRegistro = GETDATE()
  SELECT @ConDesglose = DineroDesgloseObligatorio,
         @FormaPago   = FormaPagoEfectivo
    FROM EmpresaCfg
   WHERE Empresa = @Empresa
  SELECT @MovFaltanteCaja = CajaFaltanteCaja,
         @MovSobranteCaja = CajaSobranteCaja
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crCancelarFaltanteSobrante CURSOR LOCAL FOR 
     SELECT ID 
       FROM Dinero 
      WHERE Empresa = @Empresa AND OrigenTipo = 'DIN' AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    OPEN crCancelarFaltanteSobrante
    FETCH NEXT FROM crCancelarFaltanteSobrante INTO @DineroID
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spDinero @DineroID, 'DIN', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL
           EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crCancelarFaltanteSobrante INTO @DineroID
    END -- While
    CLOSE crCancelarFaltanteSobrante
    DEALLOCATE crCancelarFaltanteSobrante
  END ELSE
  BEGIN
    SELECT @Importe = ABS(@CajeroSaldo)
    IF @Importe <> 0.0
    BEGIN
      SELECT @DineroMov = CASE WHEN @CajeroSaldo > 0 THEN @MovFaltanteCaja ELSE @MovSobranteCaja END
      INSERT Dinero (OrigenTipo, Origen, OrigenID, Sucursal,  SucursalOrigen, SucursalDestino,  Empresa,  Mov,        FechaEmision,  Moneda,     TipoCambio,     Usuario,  Estatus,      CtaDinero,  Cajero,  Importe,  ConDesglose,  FormaPago,  UEN, Proyecto)
             SELECT  'DIN',      @Mov,   @MovID,   Sucursal,  SucursalOrigen, SucursalDestino,  Empresa,  @DineroMov, FechaEmision,  Moneda,     TipoCambio,     Usuario,  'SINAFECTAR', CtaDinero,  Cajero,  @Importe, @ConDesglose, @FormaPago, UEN, Proyecto
               FROM Dinero
              WHERE ID = @ID
      SELECT @DineroID = SCOPE_IDENTITY()
      INSERT DineroD (Sucursal,  ID,        Renglon, Importe,  FormaPago) 
              VALUES (@Sucursal, @DineroID, 2048,    @Importe, @FormaPago) 

      EXEC spDinero @DineroID, 'DIN', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                    @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
         EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
    END

    IF @TieneSaldoOtrasMonedas = 1 AND @Ok IS NULL
    BEGIN
      DECLARE crFaltanteSobrante CURSOR LOCAL FOR 
      SELECT Moneda, ISNULL(SUM(Saldo), 0.0) 
        FROM Saldo 
       WHERE Empresa = @Empresa
         AND Rama = 'DIN'
         AND Moneda <> @CtaDineroMoneda
         AND Cuenta = @CtaDinero
       GROUP BY Moneda
       ORDER BY Moneda
      OPEN crFaltanteSobrante
      FETCH NEXT FROM crFaltanteSobrante INTO @Moneda, @Importe
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL AND @Importe <> 0.0
      BEGIN                         
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          SELECT @DineroMov = CASE WHEN @Importe > 0 THEN @MovFaltanteCaja ELSE @MovSobranteCaja END
          INSERT Dinero (OrigenTipo, Origen, OrigenID, Sucursal,    SucursalOrigen,   SucursalDestino,    Empresa,    Mov,        FechaEmision,    Moneda,    TipoCambio,     Usuario,    Estatus,      CtaDinero,    Cajero,    Importe,       ConDesglose,  FormaPago,  UEN,   Proyecto)
                 SELECT  'DIN',      @Mov,   @MovID,   d.Sucursal,  d.SucursalOrigen, d.SucursalDestino,  d.Empresa,  @DineroMov, d.FechaEmision,  @Moneda,   m.TipoCambio,   d.Usuario,  'SINAFECTAR', d.CtaDinero,  d.Cajero,  ABS(@Importe), @ConDesglose, @FormaPago, d.UEN, d.Proyecto
                   FROM Dinero d
                   JOIN Mon m ON m.Moneda = @Moneda
                  WHERE d.ID = @ID
          SELECT @DineroID = SCOPE_IDENTITY()
          INSERT DineroD (Sucursal,  ID,        Renglon, Importe,       FormaPago) 
                   SELECT @Sucursal, @DineroID, 2048,    ABS(@Importe), @FormaPago

          EXEC spDinero @DineroID, 'DIN', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                        @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
             EXEC spMovFlujo @Sucursal, @Accion, @Empresa, 'DIN', @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
        END
        FETCH NEXT FROM crFaltanteSobrante INTO @Moneda, @Importe
      END -- While
      CLOSE crFaltanteSobrante
      DEALLOCATE crFaltanteSobrante
    END
  END
  RETURN
END
GO
  
/**************** spDineroVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroVerificar') and type = 'P') drop procedure dbo.spDineroVerificar
GO
CREATE PROCEDURE spDineroVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
 	    	    @EstatusNuevo	      	char(15),
		    @BeneficiarioNombre		varchar(100),
                    @CtaDinero			char(10),
		    @CtaDineroTipo		char(20),         
		    @CtaDineroDestino		char(10),
		    @CtaDineroFactor		float,
		    @CtaDineroTipoCambio	float,
		    @CtaDineroMoneda		char(10),
		    @CtaDineroDestinoMoneda	char(10),
		    @CtaDineroDestinoTipo	char(20),
		    @CtaEmpresa			char(5),
    		    @Cajero			char(10),
		    @FormaPago			varchar(50),
    		    @Referencia	      		varchar(50),

		    @Importe			money,
		    @Impuestos			money,
		    @Saldo			money,
		    @Corte			int,
		    @CorteDestino		int,
                    @Dias			int,
                    @TasaDiaria			float,
                    @Retencion			money,
                    @CfgInversionIntereses	varchar(20),
                    @InteresTipo		varchar(20), 
		    @Titulo			varchar(10), 
		    @TituloValor		float, 
		    @ValorOrigen		float,

		    @Contacto			char(10),
		    @ContactoTipo		varchar(20),
     		    @ContactoEnviarA		int,

  		    @Directo	                bit,
  		    @ConDesglose                bit,
		    @CfgCajeros			bit,
		    @CfgSobregiros		bit,
		    @CfgFormaPagoRequerida	bit,
		    @CfgChequesDirectos		bit,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @OrigenTipo			char(20),
		    @OrigenMovTipo		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @Autorizacion		char(10),	
		    @Autorizar			bit	     OUTPUT,
		    @ChequeDevuelto		bit, --MEJORA6013
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT,
		    @EstacionTrabajo int = NULL -- REQ12336

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     
    @ImporteTotal 	money,
    @ImporteD		money,
    @SumaImporte	money,
    @CtaSaldo		money,
    @CajeroSaldo	money,
    @FormaPagoD		varchar(50),
    @ReferenciaD	varchar(50),
    @FormaMoneda	char(10),
    @FormaTipoCambio	float,
    @FormaCobroVales	varchar(50),
    @CfgValidarAF	varchar(20),
    @SubClave   	varchar(20),
    @Renglon            float,
    @InterfazEmida		bit				-- REQ12336

  SELECT @InterfazEmida = ISNULL(InterfazEmida, 0) FROM EmpresaGral WHERE Empresa = @Empresa -- REQ12336

  SELECT @FormaCobroVales = CxcFormaCobroVales,
         @CfgValidarAF = UPPER(RHValidarAF)
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa
  SELECT @Autorizar = 0

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --Mejora 5669
  -- Si el movimiento no debe de llevar impuestos borrar el campo
  IF @MovTipo NOT IN ('DIN.CB','DIN.AB') SELECT @Impuestos = 0.0

  IF @MovTipo IN ('DIN.CH', 'DIN.CHE') AND @Accion <> 'CANCELAR' AND UPPER(@ContactoTipo) = 'PERSONAL' AND @CfgValidarAF = 'PAGO'
  BEGIN
    IF (SELECT Estatus FROM Personal WHERE Personal = @Contacto) = 'BAJA'
      IF EXISTS(SELECT * FROM ActivoF WHERE Empresa = @Empresa AND Responsable = @Contacto)
        SELECT @Ok = 44160, @OkRef = @Contacto
  END

  -- Calcula el Importe Total
  SELECT @ImporteTotal = @Importe + @Impuestos

  -- REQ12336
  IF @MovTipo IN('DIN.CHE', 'DIN.CH', 'DIN.DE', 'DIN.D') AND @Accion = 'AFECTAR' AND @InterfazEmida = 1 AND dbo.fnDineroEsPagoEmida(@ID) > 1
    SELECT @Ok = 20184, @OkRef = '(' + RTRIM(ISNULL(@Mov,'')) + ' ' + RTRIM(ISNULL(@MovID,'')) + ')'
  -- REQ12336
  
  IF @MovTipo IN ('DIN.CH') AND @Accion IN ('CANCELAR') AND @ChequeDevuelto = 1 AND @Ok IS NULL 
    SELECT @Ok = 35360, @OkRef = '(' + RTRIM(ISNULL(@Mov,'')) + ' ' + RTRIM(ISNULL(@MovID,'')) + ')' --MEJORA6013
    
  IF /*@CfgChequesDirectos = 0 AND */@MovTipo IN ('DIN.SCH', 'DIN.SCH', 'DIN.CH', 'DIN.CHE', 'DIN.SD', 'DIN.D', 'DIN.DE') AND @OrigenMovTipo IS NULL 
  BEGIN
    SELECT @Ok = 35310
    EXEC xpOk_35310 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @MovTipo IN ('DIN.SD', 'DIN.SCH') AND @OrigenTipo NOT IN ('VTAS', 'CXC', 'AGENT', 'CXP', 'NOM', 'GAS', 'COMS', 'AF', 'CR', 'DIN', 'CAM') AND @Accion <> 'CANCELAR' 
  BEGIN
    SELECT @Ok = 60420, @OkRef = @OrigenTipo
    EXEC xpOk_60420 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @MovTipo IN ('DIN.INV', 'DIN.RET') AND @InteresTipo = 'TITULO' AND (@Titulo IS NULL OR @TituloValor = 0.0 OR @ValorOrigen = 0.0)
    SELECT @Ok = 10610

  IF @Accion = 'CANCELAR'
  BEGIN
    IF @OrigenMovTipo IN ('DIN.C', 'DIN.CP') AND @Conexion = 0 AND @SubClave NOT IN('DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA')--Mejora 5669
      SELECT @Ok = 30470

/*    
    IF @SubClave NOT IN('DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA')--Mejora 5669
    SELECT @Corte = NULL, @CorteDestino = NULL
 */
    
    IF @Corte IS NOT NULL OR @CorteDestino IS NOT NULL 
      IF NOT (@MovTipo IN ('DIN.C', 'DIN.CP') AND @ID = @Corte)
        SELECT @Ok = 30470

    IF @MovTipo IN ('DIN.I', 'DIN.SD' ,'DIN.E', 'DIN.F', 'DIN.SCH', 'DIN.INV', 'DIN.TI') AND @CtaDineroTipo <> 'CAJA'
      IF ROUND(@Saldo, 2) <> ROUND(@ImporteTotal, 2) SELECT @Ok = 60060

    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0
    BEGIN
      IF EXISTS(SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
        SELECT @Ok = 60070
      IF @MovTipo IN ('DIN.CB', 'DIN.AB') AND @OrigenTipo = @Modulo AND @Ok IS NULL
        SELECT @Ok = 60070
      IF @MovTipo IN ('DIN.I', 'DIN.SD') AND @OrigenMovTipo = 'DIN.C' AND @Ok IS NULL
        SELECT @Ok = 60072
--JGD 07Junio2011 Ticket 4858. Se Agrega que No se Permita poder Cancelar una SOLICITUD CHEQUE que tenga un Movimiento Origen TRASPASO
      IF @MovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.SCH') AND @OrigenMovTipo = 'DIN.TI' AND @Ok IS NULL
        SELECT @Ok = 60072
    END
  END ELSE
  BEGIN
--    IF @MovTipo = 'DIN.INV' AND ISNULL(@Dias, 0) = 0 SELECT @Ok = 30020
    IF @MovTipo = 'DIN.RE'
    BEGIN
      IF @OrigenTipo <> 'AUTO/RE' SELECT @Ok = 25410 ELSE
      IF @MovTipoCambio <> 1 SELECT @Ok = 44090 
    END
    IF @Accion = 'AFECTAR' AND @CtaDinero IS NOT NULL AND @Ok IS NULL
    BEGIN
   
      IF @CtaEmpresa IS NULL SELECT @Ok = 40160 ELSE
      IF @CtaEmpresa <> @Empresa SELECT @Ok = 40170
    END

    IF @MovTipo NOT IN ('DIN.SD', 'DIN.SCH', 'DIN.DF', 'DIN.CD', 'DIN.RE', 'DIN.REI', 'DIN.RND') AND @Ok IS NULL
    BEGIN
      IF @ConDesglose = 0 
      BEGIN
        IF @CfgFormaPagoRequerida = 1 AND @FormaPago IS NULL AND @Importe <> 0.0 
          SELECT @Ok = 30530
        ELSE BEGIN
          EXEC spFormaPagoMonTC @FormaPago, @Referencia, @MovMoneda, @MovTipoCambio, NULL, NULL, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
          IF @MovMoneda <> @FormaMoneda SELECT @Ok = 30045, @OkRef = @FormaPago
        END
        -- 9150
        IF @CfgFormaPagoRequerida = 1 AND NULLIF(@FormaPago, '') IS NOT NULL AND NULLIF(@Ok, 0) IS NULL
          IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
            SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago

      END ELSE
      BEGIN
        SELECT @SumaImporte = 0.0
        DECLARE crFormaPagoD CURSOR FOR 
         SELECT Renglon,NULLIF(RTRIM(FormaPago), ''), Referencia, ISNULL(Importe, 0.0)
           FROM DineroD
          WHERE ID = @ID AND ISNULL(Importe, 0.0) <> 0.0

        OPEN crFormaPagoD
        FETCH NEXT FROM crFormaPagoD INTO @Renglon,@FormaPagoD, @ReferenciaD, @ImporteD
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN                         
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          BEGIN
            IF @CfgFormaPagoRequerida = 1 AND @FormaPagoD IS NULL 
              SELECT @Ok = 30530
            ELSE 
            BEGIN
            --Mejora 5669    
              IF @SubClave NOT IN( 'DIN.AMULTIMONEDA','DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA')
              BEGIN
                EXEC spFormaPagoMonTC @FormaPagoD, @ReferenciaD, @MovMoneda, @MovTipoCambio, NULL, NULL, @FormaMoneda OUTPUT, @FormaTipoCambio OUTPUT, @Ok OUTPUT, @FormaCobroVales
                IF @MovMoneda <> @FormaMoneda SELECT @Ok = 30045, @OkRef = @FormaPagoD
                
              END
            END
            -- 9150
            IF @CfgFormaPagoRequerida = 1 AND NULLIF(@FormaPagoD, '') IS NOT NULL AND NULLIF(@Ok, 0) IS NULL
              IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPagoD, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
                SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPagoD
                
            SELECT @SumaImporte = @SumaImporte + @ImporteD
            --Mejora 5669
            IF @Ok IS NULL AND @SubClave = 'DIN.AMULTIMONEDA' AND @MovTipo IN ('DIN.A')
            EXEC spDineroVerificarAperturaMultimoneda @ID, @Renglon, @Empresa, @Estatus,  @MovTipo, @FormaPagoD, @ReferenciaD, @ImporteD ,@Ok OUTPUT ,@OkRef OUTPUT
            
            IF @Ok IS NULL AND @SubClave IN('DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA') AND @MovTipo IN ('DIN.C','DIN.CP')
            EXEC spDineroVerificarCorteMultimoneda @ID, @Renglon, @Empresa, @Estatus,  @MovTipo, @FormaPagoD, @ReferenciaD, @ImporteD ,@Ok OUTPUT ,@OkRef OUTPUT            
          END
          FETCH NEXT FROM crFormaPagoD INTO @Renglon,@FormaPagoD, @ReferenciaD, @ImporteD
        END -- While
        CLOSE crFormaPagoD
        DEALLOCATE crFormaPagoD
        IF @Ok IS NULL
        
          IF ABS(ROUND(@SumaImporte, 0)) <> ABS(ROUND(@ImporteTotal, 0))  AND @SubClave NOT IN('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA' ) SELECT @Ok = 30230
      END
    END
    IF @Importe = 0.0 AND @MovTipo NOT IN ('DIN.A', 'DIN.C', 'DIN.I', 'DIN.RE', 'DIN.REI', 'DIN.RND') OR
    @Importe = 0.0 AND @MovTipo NOT IN ('DIN.A', 'DIN.C','DIN.CP', 'DIN.I', 'DIN.RE', 'DIN.REI', 'DIN.RND')AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA' )--Mejora 5669
    SELECT @Ok = 30100
    IF @MovTipo NOT IN ('DIN.I', 'DIN.SD', 'DIN.E', 'DIN.F', 'DIN.SCH') AND @CtaDineroTipo <> 'CAJA' OR (@MovTipo IN ('DIN.A','DIN.C','DIN.CP') AND @SubClave IN('DIN.AMULTIMONEDA','DIN.AMULTIMONEDA','DIN.AMULTIMONEDA') AND @CtaDineroTipo <> 'CAJA')--Mejora 5669
      IF @CtaDinero IS NULL SELECT @Ok = 40120 

    IF @MovTipo IN ('DIN.DA', 'DIN.CNI') AND @Estatus = 'PENDIENTE' SELECT @Ok = 60040


    IF @CtaDinero IS NOT NULL AND @Ok IS NULL AND @CtaDineroMoneda <> @MovMoneda AND @MovTipo NOT IN ('DIN.D', 'DIN.SD', 'DIN.SCH', 'DIN.RE', 'DIN.REI')
    AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA' )--Mejora 5669
         SELECT @Ok = 30040
      
    IF @CtaDinero IS NOT NULL AND @Ok IS NULL AND @MovTipo = 'DIN.RE' AND @CtaDineroMoneda = @MovMoneda SELECT @Ok = 30040 

    IF @MovTipo IN ('DIN.CH', 'DIN.CHE') AND NULLIF(RTRIM(@BeneficiarioNombre), '') IS NULL SELECT @Ok = 35020

    -- Checar Que no pongan importes negativos
    IF (@Importe < 0.0 OR @Impuestos < 0.0) AND @MovTipo NOT IN ('DIN.C', 'DIN.CP', 'DIN.RE', 'DIN.REI', 'DIN.RND', 'DIN.CB', 'DIN.AB') SELECT @Ok = 30100

    IF @MovTipo IN ('DIN.T', 'DIN.TI', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP', 'DIN.CP', 'DIN.C') AND @SubClave NOT IN('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA' )--Mejora 5669
    BEGIN
      IF @CtaDineroDestino IS NULL SELECT @Ok = 40040 ELSE 
      IF @CtaDineroDestino = @CtaDinero AND @Estatus = 'SINAFECTAR' SELECT @Ok = 40050
    END

--JGD 22Febrero2011 Ticket 3526.
    IF @MovTipo = 'DIN.INV'
    BEGIN
      IF @CtaDinero IS NOT NULL AND @CtaDineroDestino IS NOT NULL AND @Ok IS NULL AND @CtaDineroMoneda <> @CtaDineroDestinoMoneda AND @Estatus = 'SINAFECTAR' SELECT @Ok = 30081
    END 

    IF @MovTipo IN ('DIN.T', 'DIN.TI', 'DIN.INV', 'DIN.RET') AND (@CtaDineroTipo = 'CAJA'  OR @CtaDineroDestinoTipo  = 'CAJA') SELECT @Ok = 40130 ELSE

    IF @MovTipo = 'DIN.TC'  AND @SubClave NOT IN('DIN.TCULTIMONEDA') AND (@CtaDineroTipo <> 'CAJA' OR @CtaDineroDestinoTipo <> 'CAJA') SELECT @Ok = 40130
    IF @CtaDineroTipo = 'ESTRUCTURA' OR @CtaDineroDestinoTipo = 'ESTRUCTURA' SELECT @Ok = 20680

    IF @MovTipo IN ('DIN.A', 'DIN.AP') AND (@CtaDineroTipo = 'CAJA' AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ) OR @CtaDineroDestinoTipo <> 'CAJA')AND @SubClave NOT IN ('DIN.AMULTIMONEDA' )--Mejora 5669
      SELECT @Ok = 30460
/*    IF @MovTipo = 'DIN.T' AND @Ok IS NULL
      IF @CtaDineroDestinoMoneda <> @CtaDineroMoneda SELECT @Ok = 30220
*/
    IF @Ok IS NOT NULL RETURN 

    SELECT @CtaSaldo = ISNULL(SUM(Saldo), 0.0) 
      FROM Saldo 
     WHERE Empresa = @Empresa
       AND Rama = @Modulo
       AND Moneda = @CtaDineroMoneda
       AND Cuenta = @CtaDinero

    -- Verificar la Aplicacion Manual
    IF @Directo = 0 AND @MovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.I', 'DIN.E', 'DIN.F', 'DIN.INV', 'DIN.RET') AND (@Estatus <> 'PENDIENTE' OR @Accion = 'CANCELAR')
      EXEC spDineroAplicar @Sucursal, @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, NULL, @MovTipo, @MovMoneda, @MovTipoCambio, 
			   @FechaEmision, NULL, NULL, NULL, NULL, 
                           @CtaDinero, @CtaDineroFactor, @CtaDineroTipoCambio, @ImporteTotal, @CfgContX, @CfgContXGenerar, 1,
                           @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @EstacionTrabajo -- REQ12336

    -- Verificar Sobregiros de la cuenta
    IF ((@CfgSobregiros = 1 AND @CtaDineroTipo <> 'CAJA') OR @Accion = 'VERIFICAR') AND @MovTipo IN ('DIN.E', 'DIN.F', 'DIN.CH', 'DIN.CHE', 'DIN.CB', 'DIN.DF', 'DIN.CP', 'DIN.C', 'DIN.T', 'DIN.TI', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP') AND @CtaDinero IS NOT NULL AND @Ok IS NULL AND @Autorizacion IS NULL AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA' )--Mejora 5669
      IF @CtaSaldo-@ImporteTotal < 0.0 SELECT @Ok = 60130, @Autorizar = 1 
  END
  --JGD 01Sep2011. Ticket 5672. Se quita el Simbolo <> sustutuyendolo solo por >
  IF @MovTipo = 'DIN.A' AND @Accion = 'CANCELAR' AND @SubClave NOT IN ('DIN.AMULTIMONEDA' )--Mejora 5669
  BEGIN
    IF EXISTS(SELECT * 
                FROM Dinero f, MovTipo mt 
               WHERE f.ID > @ID AND f.Empresa = @Empresa AND f.Mov = mt.Mov AND mt.Clave IN ('DIN.I', 'DIN.E', 'DIN.F', 'DIN.TC', 'DIN.A', 'DIN.AP', 'DIN.CP') AND f.Estatus = 'CONCLUIDO' AND f.Moneda = @MovMoneda AND
                    ((f.CtaDinero = @CtaDineroDestino AND f.Corte IS NULL) OR (f.CtaDineroDestino = @CtaDineroDestino AND f.CorteDestino IS NULL)))
      SELECT @Ok = 30480
  END
  
  IF @Accion NOT IN ('GENERAR', 'CANCELAR') AND @Ok IS NULL AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA' )--Mejora 5669
    EXEC spValidarMovImporteMaximo @Usuario, @Modulo, @Mov, @ID, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC xpDineroVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @BeneficiarioNombre,
                           @CtaDinero, @CtaDineroTipo, @CtaDineroDestino, @CtaDineroFactor, @CtaDineroTipoCambio, @CtaDineroMoneda, @CtaDineroDestinoMoneda, @CtaDineroDestinoTipo, @CtaEmpresa, @Cajero,
                           @Importe, @Impuestos, @Saldo, @Corte, @CorteDestino,
      	                   @Directo, @CfgContX, @CfgContXGenerar, @OrigenMovTipo, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO



/**************** spDineroRelacionar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroRelacionar') and type = 'P') drop procedure dbo.spDineroRelacionar
GO             
CREATE PROCEDURE spDineroRelacionar
		    @Empresa	char(5),
		    @Accion	char(20),
		    @Modulo	char(5),
		    @ID		int,
                    @Mov	char(20),
		    @MovID	varchar(20),
		    @CtaDinero	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OModulo	char(5),
    @OID	int

  DECLARE crMovFlujo CURSOR FOR 
   SELECT OModulo, OID 
     FROM MovFlujo 
    WHERE /*Cancelado = 0 AND */DID = @ID AND DModulo = @Modulo and Empresa = @Empresa

  OPEN crMovFlujo
  FETCH NEXT FROM crMovFlujo INTO @OModulo, @OID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @OModulo = @Modulo SELECT @OModulo = OModulo, @OID = OID FROM MovFlujo WHERE Cancelado = 0 AND DID = @OID AND DModulo = @OModulo AND Empresa = @Empresa
      IF @OModulo = @Modulo SELECT @OModulo = OModulo, @OID = OID FROM MovFlujo WHERE Cancelado = 0 AND DID = @OID AND DModulo = @OModulo AND Empresa = @Empresa
      IF @OModulo = @Modulo SELECT @OModulo = OModulo, @OID = OID FROM MovFlujo WHERE Cancelado = 0 AND DID = @OID AND DModulo = @OModulo AND Empresa = @Empresa
      IF @OModulo = @Modulo SELECT @OModulo = OModulo, @OID = OID FROM MovFlujo WHERE Cancelado = 0 AND DID = @OID AND DModulo = @OModulo AND Empresa = @Empresa
      IF @OModulo = @Modulo SELECT @OModulo = OModulo, @OID = OID FROM MovFlujo WHERE Cancelado = 0 AND DID = @OID AND DModulo = @OModulo AND Empresa = @Empresa
      IF @OModulo IS NOT NULL AND @OID IS NOT NULL
      BEGIN
        IF @Accion = 'CANCELAR' SELECT @Mov = NULL, @MovID = NULL, @CtaDinero = NULL
        IF @OModulo = 'CXC'  UPDATE Cxc   SET GenerarDinero = 0, Dinero = @Mov, DineroID = @MovID, DineroCtaDinero = @CtaDinero WHERE ID = @OID AND (@Accion = 'CANCELAR' OR DineroID IS NULL) ELSE
        IF @OModulo = 'CXP'  UPDATE Cxp   SET GenerarDinero = 0, Dinero = @Mov, DineroID = @MovID, DineroCtaDinero = @CtaDinero WHERE ID = @OID AND (@Accion = 'CANCELAR' OR DineroID IS NULL) ELSE
        IF @OModulo = 'GAS'  UPDATE Gasto SET GenerarDinero = 0, Dinero = @Mov, DineroID = @MovID, DineroCtaDinero = @CtaDinero WHERE ID = @OID AND (@Accion = 'CANCELAR' OR DineroID IS NULL) ELSE
        IF @OModulo = 'VTAS' UPDATE Venta SET GenerarDinero = 0, Dinero = @Mov, DineroID = @MovID, DineroCtaDinero = @CtaDinero WHERE ID = @OID AND (@Accion = 'CANCELAR' OR DineroID IS NULL)
      END
    END -- Fetch_Status <> 2
    FETCH NEXT FROM crMovFlujo INTO @OModulo, @OID
  END -- While
  CLOSE crMovFlujo
  DEALLOCATE crMovFlujo
  RETURN
END
GO

/**************** spDineroPagado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroPagado') and type = 'P') drop procedure dbo.spDineroPagado
GO             
CREATE PROCEDURE spDineroPagado
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@DineroA	char(20),
			@DineroN	char(20),
			@DineroIDA	varchar(20), 
			@DineroIDN	varchar(20),
			@CtaDinero	char(10),
			@PorcentajeBase	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Inc		bit,
    @IDAplica		int,
    @IDOrigen		int,
    @OrigenTipo		varchar(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
    @Porcentaje		float,
    @Pagado		float,
    @FechaPago		datetime,
    @DineroConciliado	bit

  IF (SELECT AC FROM EmpresaGral WHERE Empresa = @Empresa) = 1 RETURN

  IF @DineroN IS NOT NULL AND @DineroIDN IS NOT NULL SELECT @Inc = 1 ELSE
  IF @DineroN IS NULL     AND @DineroIDN IS NULL     SELECT @Inc = 0 ELSE RETURN

  IF (SELECT DineroPagoConciliado FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
  BEGIN
    SELECT @DineroConciliado = 0
    IF @Modulo = 'CXC'  SELECT @DineroConciliado = DineroConciliado FROM Cxc   WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @DineroConciliado = DineroConciliado FROM Cxp   WHERE ID = @ID ELSE
    IF @Modulo = 'VTAS' SELECT @DineroConciliado = DineroConciliado FROM Venta WHERE ID = @ID 
    IF ISNULL(@DineroConciliado, 0) = 0 RETURN
  END

  IF @Modulo = 'CXC'
    DECLARE crDineroPagado CURSOR LOCAL FOR
     SELECT a.OrigenTipo, a.Origen, a.OrigenID, a.ID, @PorcentajeBase*ISNULL(CONVERT(float, d.Importe)/NULLIF(a.ImporteTotal, 0), 0)
       FROM CxcD d, CxcAplica a
      WHERE d.ID = @ID AND a.Mov=d.Aplica AND a.MovID=d.AplicaID AND a.Empresa=@Empresa
        AND a.OrigenTipo IS NOT NULL AND a.Origen IS NOT NULL AND a.OrigenID IS NOT NULL
  ELSE
  IF @Modulo = 'CXP'
    DECLARE crDineroPagado CURSOR LOCAL FOR
     SELECT a.OrigenTipo, a.Origen, a.OrigenID, a.ID, @PorcentajeBase*ISNULL(CONVERT(float, d.Importe)/NULLIF(a.ImporteTotal, 0), 0)
       FROM CxpD d, CxpAplica a
      WHERE d.ID = @ID AND a.Mov=d.Aplica AND a.MovID=d.AplicaID AND a.Empresa=@Empresa
        AND a.OrigenTipo IS NOT NULL AND a.Origen IS NOT NULL AND a.OrigenID IS NOT NULL
  ELSE
  IF @Modulo = 'VTAS'
    DECLARE crDineroPagado CURSOR LOCAL FOR
     SELECT @Modulo, v.Mov, v.MovID, v.ID, @PorcentajeBase
       FROM Venta v
      WHERE v.ID = @ID
  
  OPEN crDineroPagado
  FETCH NEXT FROM crDineroPagado INTO @OrigenTipo, @Origen, @OrigenID, @IDAplica, @Porcentaje
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @OrigenTipo IN ('CXC', 'CXP')
        EXEC spDineroPagado @Empresa, @OrigenTipo, @IDAplica, @DineroA, @DineroN, @DineroIDA, @DineroIDN, @CtaDinero, @Porcentaje
      ELSE 
      IF @OrigenTipo IN ('VTAS', 'COMS', 'GAS')
      BEGIN
        IF @Inc = 1
          SELECT @FechaPago = FechaEmision FROM Dinero WHERE Empresa = @Empresa AND Mov = @DineroN AND MovID = @DineroIDN AND CtaDinero = @CtaDinero AND Estatus = 'CONCLUIDO'
        ELSE BEGIN
          SELECT @Porcentaje =-@Porcentaje, @FechaPago = GETDATE()
          EXEC spExtraerFecha @FechaPago OUTPUT
        END
        SELECT @IDOrigen = NULL
        IF @OrigenTipo = 'VTAS' UPDATE Venta  SET @IDOrigen = ID, Pagado = ISNULL(Pagado, 0) + @Porcentaje WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') ELSE
        IF @OrigenTipo = 'COMS' UPDATE Compra SET @IDOrigen = ID, Pagado = ISNULL(Pagado, 0) + @Porcentaje WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') ELSE
        IF @OrigenTipo = 'GAS'  UPDATE Gasto  SET @IDOrigen = ID, Pagado = ISNULL(Pagado, 0) + @Porcentaje WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 

        IF @IDOrigen IS NOT NULL
          INSERT PagadoAux (Modulo, ModuloID, Fecha, Pagado) VALUES (@OrigenTipo, @IDOrigen, @FechaPago, @Porcentaje)
      END
    END 
    FETCH NEXT FROM crDineroPagado INTO @OrigenTipo, @Origen, @OrigenID, @IDAplica, @Porcentaje
  END -- While
  CLOSE crDineroPagado
  DEALLOCATE crDineroPagado

  RETURN
END
GO

/**************** spDineroAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroAfectar') and type = 'P') drop procedure dbo.spDineroAfectar
GO             
CREATE PROCEDURE spDineroAfectar
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)  OUTPUT,
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	      	float,
    		   @FechaEmision      		datetime,
		   @FechaAfectacion		datetime,
	           @FechaConclusion	 	datetime,

    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @CtaDinero			char(10),
	    	   @CtaDineroTipo		char(20),         
		   @CtaDineroDestino		char(10),
		   @CtaDineroFactor		float,
	    	   @CtaDineroTipoCambio		float,
		   @CtaDineroMoneda		char(10),
		   @CtaDineroDestinoMoneda	char(10),
		   @TipoCambioDestino		float,
    		   @Cajero		 	char(10),
		   @FormaPago			varchar(50),
                   @IVAFiscal			float,
                   @IEPSFiscal			float,

    		   @Importe   			money,	 
    		   @Impuestos	        	money,
		   @Saldo			money,
                   @Dias			int,
                   @TasaDiaria			float,
                   @Retencion			money,
                   @CfgInversionIntereses	varchar(20),
                   @InteresTipo			varchar(20), 
		   @Titulo			varchar(10), 
		   @TituloValor			float, 
		   @ValorOrigen			float,
		   
		   @Contacto			char(10),
		   @ContactoTipo		varchar(20),
     		   @ContactoEnviarA		int,

                   @Directo			bit,
  		   @ConDesglose                 bit,
		   @AutoConciliar		bit,			
		   @OrigenTipo			varchar(20),
		   @OrigenMov			varchar(20),
		   @OrigenMovID			varchar(20),
		   @OrigenMovTipo		varchar(20),

		   @Conexion			bit,
		   @SincroFinal			bit,
		   /*@Verificar			bit,*/
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,
			
		   @GenerarGasto		bit,
		   @CfgCajeros			bit,
		   @CfgAutoFaltanteSobrante	bit,
		   @CfgSobregiros		bit, 
		   @CfgAfectarComision		bit,
		   @CfgAfectarComisionIVA	bit,
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @CfgEmbarcar			bit,
		   @GenerarPoliza		bit,

		   @Utilizar			bit,
		   @UtilizarID			int,
		   @UtilizarMov			char(20),
		   @UtilizarMovTipo		char(20),
		   @UtilizarMovID		varchar(20),

                   @Generar                     bit,
                   @GenerarMov                  char(20),
		   @GenerarAfectado		bit,
		   @GenerarAfectando		bit,
		   @GenerarCopia		bit,

		   @IDGenerar			int	     OUTPUT,	
    		   @GenerarMovID	  	varchar(20)  OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,
    		   @EstacionTrabajo int = NULL -- REQ12336
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Comision		 money,
    @ComisionIVA	 money,
    @ComisionImpuestos	 money,
    @Comision2		 money,
    @Comision2IVA	 money,
    @Comision2Impuestos	 money,
    @ImporteTotal	 money,
    @Intereses		 money,
    @NuevoPendiente      float,
    @CtaDineroImporte    money,
    @CtaDineroIntereses  money,
    @CtaDineroSaldo	 money,
    @SaldoNuevo	         money,
    @FechaCancelacion	 datetime,
    @EsCargo		 bit,
    @GenerarEstatus	 char(15),
    @Serie		 char(20),
    @GenerarPolizaTemp	 bit,
    @DineroMov		 char(20),
    @DineroMovID	 varchar(20),
    @ComisionMov	 char(20),
    @ComisionMovIVA	 char(20),
    @ComisionMovID	 varchar(20),
    @Comision2Mov	 char(20),
    @Comision2MovIVA	 char(20),
    @UltimoID		 int,
    @CajeroActual	 char(10),
    @CxID		 int,
    @CxModulo		 char(5), 
    @CxMov		 char(20), 
    @CxMovID		 varchar(20),
    @GenerarCxSolicitud  bit,
    @DepositoFactor	 float,
    @DepositoTipoCambio  float,
    @DepositoImporte	 money,
    @AbonoImporte	 money,
    @CtaSaldo		 money,
    @TieneSaldoOtrasMonedas bit,
    @CajeroSaldo	 money,
    @FormaPagoD		 varchar(50),
    @ReferenciaD	 varchar(50),
    @ImporteD		 money,
    @CtaDineroD		 char(10),
    @FaltanteCajaModulo	 char(5),
    @RedondeoMonetarios	 int,
    @CargoImporte	 money,
    @OrigenID		 int,
    @OrigenTotal	 money,
    @OrigenFactor	 float,
    @sOk		 int,
    @sOkRef		 varchar(255),
    @ReferenciaID	 int,
    @PPTO		 bit,
    @ImporteTotalCorte	 money,
    @AplicaCorteFactor	 float,
    @Retencion2BaseImpuesto1		bit  ,         
    @SubClave   	 varchar(20),
    @CfgProrrateoMovImpuesto    bit	,
    @TotalMovCargoCorte         float,
    @TotalMovAbonoCorte         float,
	@CorteImporteDiferir	money,
	@CDID					int, 
	@CDMov					varchar(20), 
	@CDMovId				varchar(20), 
	@CDImporte				money, 
	@CDImpuestos			money, 
	@CDTipoCambio			float, 
	@CorteImporteD			money,
	@CorteDisminuciones     money,
	@DMovTipo				varchar(20),
	@CorteFaltante			money,
	@CorteImporteDAnterior	money

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 
  SELECT @Retencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1,0) FROM Version
  
  SELECT @CfgProrrateoMovImpuesto = DineroProrrateoMovImpuesto FROM EmpresaCfg WHE
  
  SELECT @PPTO = PPTO FROM EmpresaGral WHERE Empresa = @Empresa
    
  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  -- Inicializar Variables
  SELECT @CtaDineroImporte   = 0.0,
         @SaldoNuevo         = 0.0,
         @EsCargo            = 0,
         @Intereses	     = 0.0,
         @CtaDineroIntereses = 0.0,
	 @Serie		     = NULL

  -- Asignar el Consecutivo al Movimiento
  IF @MovTipo IN ('DIN.CH', 'DIN.CHE') SELECT @Serie = @CtaDinero
  IF @MovID IS NULL --OR @Utilizar = 0 
    EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, @Serie, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, @Serie, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    -- Si el movimiento no debe de llevar impuestos borrar el campo
    IF @MovTipo NOT IN ('DIN.CB','DIN.AB') SELECT @Impuestos = 0.0

    -- Calcula el Importe Total
    SELECT @ImporteTotal = @Importe + @Impuestos

    IF @MovTipo = 'DIN.RET' --AND @CfgInversionIntereses = 'RETIRO INVERSION' 
    BEGIN
       --  SELECT @Intereses = (ISNULL(@ImporteTotal * @Dias * (@TasaDiaria/100.0) , 0)) * (1-(@TasaRetencion /100.0))
       --  SELECT @Intereses = (ISNULL(@ImporteTotal * @Dias * (@TasaDiaria/100.0) , 0)) - (ISNULL(@ImporteTotal * @Dias * (@TasaRetencionDiaria/100.0) , 0))
      IF @InteresTipo = 'TASA FIJA'
        SELECT @Intereses = (ISNULL(@ImporteTotal * @Dias * (@TasaDiaria/100.0) , 0)) - @Retencion
      ELSE
      IF @InteresTipo = 'TITULO'
        SELECT @Intereses = (@ImporteTotal * ((@TituloValor/@ValorOrigen)-1.0)) - @Retencion
    END

    IF @MovTipo = 'DIN.REI' AND @Accion <> 'CANCELAR'
    BEGIN 
      IF @Titulo IS NULL OR NULLIF(@TituloValor, 0.0) IS NULL OR NULLIF(@ValorOrigen, 0.0) IS NULL SELECT @Ok = 10610 ELSE 
      BEGIN
        SELECT @ReferenciaID = MIN(d.ID)
          FROM Dinero d
          JOIN MovTipo mt ON mt.Modulo = @Modulo AND mt.Mov = d.Mov AND mt.Clave = 'DIN.INV'
         WHERE d.Empresa = @Empresa AND d.Estatus = 'PENDIENTE' AND @Referencia = RTRIM(d.Mov)+' '+RTRIM(d.MovID) AND CtaDinero = @CtaDinero
 
        IF @ReferenciaID IS NULL
          SELECT @Ok = 20915, @OkRef = @Referencia
        ELSE 
         UPDATE Dinero SET TituloValor = @TituloValor WHERE ID = @ReferenciaID
      END
    END

    -- Con Aplicacion
    IF @MovTipo IN ('DIN.D', 'DIN.DE', 'DIN.DA', 'DIN.I', 'DIN.SD', 'DIN.E', 'DIN.F', 'DIN.SCH', 'DIN.C', 'DIN.CNI') 
    BEGIN
      -- Aplicacion Automatica
      IF (@MovTipo IN ('DIN.DA', 'DIN.CNI') OR (@ConDesglose = 0 AND @Directo = 1)) AND @Accion <> 'CANCELAR'
        -- Borrar Aplicaciones anteriores
        DELETE DineroD WHERE ID = @ID 
    END

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR')
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE DineroD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

    IF NULLIF(@IVAFiscal, 0) IS NULL
      SELECT @IVAFiscal = SUM(d.Importe*a.IVAFiscal)/SUM(d.Importe) FROM DineroD d, Dinero a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.id = @ID
    IF NULLIF(@IEPSFiscal, 0) IS NULL
      SELECT @IEPSFiscal = SUM(d.Importe*a.IEPSFiscal)/SUM(d.Importe) FROM DineroD d, Dinero a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.id = @ID
    IF NULLIF(@IVAFiscal, 0) IS NULL
      SELECT @IVAFiscal = CONVERT(float, NULLIF(@Impuestos, 0)) / NULLIF(@Importe + @Impuestos, 0)

    IF @MovTipo = 'DIN.C' AND @Accion = 'AFECTAR' AND @SubClave NOT IN ('DIN.CMULTIMONEDA')
    BEGIN
      SELECT @CtaSaldo = 0.0, @TieneSaldoOtrasMonedas = 0
      SELECT @CtaSaldo = ISNULL(SUM(Saldo), 0.0) 
        FROM Saldo 
       WHERE Empresa = @Empresa
         AND Rama = @Modulo
         AND Moneda = @CtaDineroMoneda
         AND Cuenta = @CtaDinero

      IF EXISTS(SELECT Moneda, ISNULL(SUM(Saldo), 0.0) 
        FROM Saldo 
       WHERE Empresa = @Empresa
         AND Rama = @Modulo
         AND Moneda <> @CtaDineroMoneda
         AND Cuenta = @CtaDinero
       GROUP BY Moneda)
        SELECT @TieneSaldoOtrasMonedas = 1

      SELECT @CajeroSaldo = ROUND(@CtaSaldo, @RedondeoMonetarios) - ROUND(@ImporteTotal, @RedondeoMonetarios)
      IF (@CajeroSaldo <> 0.0 OR @TieneSaldoOtrasMonedas = 1) AND @CfgCajeros = 1 AND @CfgAutoFaltanteSobrante = 1 AND @Accion = 'AFECTAR'
      BEGIN
	  	IF @CajeroSaldo > 0 SELECT @CorteFaltante = @CajeroSaldo 
        EXEC spDineroFaltanteSobrante @Accion, @Empresa, @Sucursal, @Usuario, @ID, @Mov, @MovID, @CajeroSaldo, @CtaDinero, @CtaDineroMoneda, @TieneSaldoOtrasMonedas, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL SELECT @CajeroSaldo = 0.0
      END
      IF @Ok IS NULL
      BEGIN
        IF @CajeroSaldo > 0 AND @CfgCajeros = 1
          SELECT @Ok = 30450, @OkRef = 'Importe Faltante: '+LTRIM(CONVERT(char, @CajeroSaldo))+' '+@CtaDineroMoneda
        IF @CajeroSaldo < 0 
           SELECT @Ok = 30455, @OkRef = 'Importe Sobrante: '+LTRIM(CONVERT(char, -@CajeroSaldo))+' '+@CtaDineroMoneda
        IF @Ok IS NULL
        BEGIN
          IF (SELECT ISNULL(ROUND(SUM(s.Saldo), @RedondeoMonetarios), 0) FROM Saldo s WHERE s.Empresa = @Empresa AND s.Rama = @Modulo AND s.Moneda <> @CtaDineroMoneda AND s.Cuenta = @CtaDinero) <> 0.0
            SELECT @Ok = 30540
        END
      END
    END
    IF @CfgCajeros = 1
    BEGIN
    
      --Mejora 5669
      IF @MovTipo = 'DIN.A' AND @SubClave   NOT IN( 'DIN.AMULTIMONEDA')
      BEGIN
        IF @Accion = 'CANCELAR' SELECT @CajeroActual = NULL ELSE SELECT @CajeroActual = @Cajero
        UPDATE CtaDineroCajero
           SET Cajero = @CajeroActual
         WHERE Moneda = ''/*@MovMoneda*/ AND CtaDinero = @CtaDineroDestino
        IF @@ROWCOUNT = 0
          INSERT CtaDineroCajero (CtaDinero, Moneda, Cajero) VALUES (@CtaDineroDestino, ''/*@MovMoneda*/, @CajeroActual)
      END
      IF @MovTipo = 'DIN.C' AND @SubClave   NOT IN( 'DIN.CMULTIMONEDA')
      BEGIN
        IF @Accion <> 'CANCELAR' 
          SELECT @CajeroActual = NULL 
        ELSE
          SELECT @CajeroActual = @Cajero 

        UPDATE CtaDineroCajero
           SET Cajero = @CajeroActual
         WHERE Moneda = ''/*@MovMoneda*/ AND CtaDinero = @CtaDinero
        IF @@ROWCOUNT = 0
          INSERT CtaDineroCajero (CtaDinero, Moneda, Cajero) VALUES (@CtaDinero, ''/*@MovMoneda*/, @CajeroActual)
      END
    END
    --Mejora 5669
    IF (@Accion IN('AFECTAR','CANCELAR')  AND @MovTipo = 'DIN.A'   AND @SubClave ='DIN.AMULTIMONEDA' AND @EstatusNuevo IN('CONCLUIDO','CANCELADO'))OR
       (@Accion IN('CANCELAR')  AND @MovTipo = 'DIN.C'   AND @SubClave ='DIN.CMULTIMONEDA' AND @EstatusNuevo IN('CANCELADO'))OR
       (@Accion IN('AFECTAR','CANCELAR')  AND @MovTipo = 'DIN.CP'   AND @SubClave ='DIN.CPMULTIMONEDA' AND @EstatusNuevo IN('CONCLUIDO','CANCELADO'))
      EXEC spDineroGenerarMultimoneda @Accion,@Empresa,@Sucursal,@Usuario,@ID,@Mov,@MovID,@MovTipo,@SubClave,@Estatus,@EstatusNuevo,@Ok  OUTPUT,@OkRef OUTPUT 
      
      
    IF @Accion IN('AFECTAR','CANCELAR')  AND @MovTipo = 'DIN.TC'   AND @SubClave ='DIN.TCMULTIMONEDA' AND @EstatusNuevo IN('CONCLUIDO','CANCELADO')  
      EXEC spDineroGenerarTCMultimoneda @Accion,@Empresa,@Sucursal,@Usuario,@ID,@Mov,@MovID,@MovTipo,@SubClave,@Estatus,@EstatusNuevo,@Ok  OUTPUT,@OkRef OUTPUT 
      
    IF @Accion IN('AFECTAR')  AND @MovTipo = 'DIN.C'   AND @SubClave ='DIN.CMULTIMONEDA' AND @EstatusNuevo IN('CONCLUIDO')
      EXEC spDineroGenerarCorteMultimoneda @Accion,@Empresa,@Sucursal,@Usuario,@ID,@Mov,@MovID,@MovTipo,@SubClave,@Estatus,@EstatusNuevo,@Ok  OUTPUT,@OkRef OUTPUT    
	     
    -- Corte de Caja
    IF @MovTipo IN ('DIN.C', 'DIN.CP') AND @Ok IS NULL AND @SubClave   NOT IN( 'DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA')
    BEGIN
      IF @CfgProrrateoMovImpuesto = 1 AND @CfgCajeros = 1
	  BEGIN
	    IF @Accion = 'CANCELAR'
        BEGIN
          SELECT @CorteImporteD = NULL
          DECLARE crCancelarCorte CURSOR FOR
             SELECT ID, CorteImporte FROM MovCorteDetalle WHERE IDCorte = @ID AND Cancelado = 0
          OPEN crCancelarCorte
          FETCH NEXT FROM crCancelarCorte INTO @CDID,  @CorteImporteD
          WHILE @@FETCH_STATUS <> -1 
            BEGIN                         
              IF @@FETCH_STATUS <> -2 
              BEGIN                
	            UPDATE Dinero SET CorteImporte = ISNULL(CorteImporte,0) - ISNULL(@CorteImporteD,0) WHERE ID = @CDID
	            UPDATE MovCorteDetalle SET Cancelado = 1 WHERE IDCorte = @ID AND ID = @CDID
			    SELECT @CorteImporteD = NULL
			  END
              FETCH NEXT FROM crCancelarCorte INTO @CDID,  @CorteImporteD
            END -- While
          CLOSE crCancelarCorte
          DEALLOCATE crCancelarCorte
        END ELSE
        BEGIN
	      SELECT @UltimoID = ISNULL(MAX(ID), 0) 
           FROM Dinero d, MovTipo mt 
          WHERE d.ID < @ID AND d.Mov = mt.Mov AND mt.Modulo = 'DIN' AND mt.Clave = 'DIN.C' AND d.Estatus = 'CONCLUIDO' AND d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero 

		  UPDATE Dinero
             SET Corte = @ID FROM Dinero d join MovTipo mt ON d.Mov = mt.Mov AND mt.Modulo = 'DIN' WHERE D.ID > @UltimoID AND (D.Estatus = 'CONCLUIDO' OR D.ID = @ID) AND D.Moneda = @MovMoneda AND D.Empresa = @Empresa AND D.CtaDinero = @CtaDinero AND D.CtaDineroDestino IS NULL--AND Corte IS NULL
	         AND MT.Clave IN ('DIN.I', 'DIN.E')

          SELECT @IVAFiscal = NULL, @IEPSFiscal = NULL
          SELECT @IVAFiscal = SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IVAFiscal)/SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0)),
                 @IEPSFiscal = SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IEPSFiscal)/SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0)),
                 @ImporteTotalCorte = SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0))
            FROM Dinero 
           WHERE Estatus='CONCLUIDO' AND (Corte = @ID OR CorteDestino = @ID) AND ID <> @ID

		  SELECT @CorteImporteDiferir = 0.0
          SELECT @CorteDisminuciones = SUM(ISNULL(d.Importe, 0.0))+ SUM(ISNULL(d.Impuestos,0.0))
            FROM Dinero d JOIN MovTipo mt ON d.Mov = mt.Mov AND mt.Modulo = 'DIN'
           WHERE (d.Corte = @ID OR d.CorteDestino = @ID) AND d.ID <> @ID AND ISNULL(d.Importe, 0.0) + ISNULL(d.Impuestos,0.0) > ISNULL(d.CorteImporte,0) 
		   AND mt.Clave = 'DIN.E'

		  SELECT @CorteImporteDiferir = @ImporteTotal + ISNULL(@CorteFaltante,0.0)
          DECLARE crDiferirCorte CURSOR FOR
          SELECT d.ID, d.Mov, d.MovId, ISNULL(d.Importe, 0.0), ISNULL(d.Impuestos,0.0), d.TipoCambio, mt.Clave, ISNULL(CorteImporte,0.0)
            FROM Dinero d JOIN MovTipo mt ON d.Mov = mt.Mov AND mt.Modulo = 'DIN'
           WHERE (d.Corte = @ID OR d.CorteDestino = @ID) AND d.ID <> @ID AND ISNULL(d.Importe, 0.0) + ISNULL(d.Impuestos,0.0) > ISNULL(d.CorteImporte,0) 
		   AND d.Estatus = 'CONCLUIDO'
		   ORDER BY mt.Clave asc, d.ID asc
          OPEN crDiferirCorte
          FETCH NEXT FROM crDiferirCorte INTO @CDID, @CDMov, @CDMovId, @CDImporte, @CDImpuestos, @CDTipoCambio, @DMovTipo, @CorteImporteDAnterior
          WHILE @@FETCH_STATUS <> -1 
            BEGIN                         
              IF @@FETCH_STATUS <> -2 AND @CorteImporteDiferir+ISNULL(@CorteDisminuciones,0.0) > 0
              BEGIN                
	            SELECT @CorteImporteD = 0

				IF @DMovTipo = 'DIN.E'
				  SELECT @CorteImporteD =  @CDImporte + @CDImpuestos 
                ELSE
				BEGIN
			      IF (@CDImporte + @CDImpuestos) - @CorteImporteDAnterior <= @CorteImporteDiferir + ISNULL(@CorteDisminuciones,0.0) SELECT @CorteImporteD =  (@CDImporte + @CDImpuestos) - @CorteImporteDAnterior
			      ELSE SELECT @CorteImporteD = @CorteImporteDiferir 
				END

                INSERT MovCorteDetalle (IDcorte, ID, Mov, MovID, CorteImporte) VALUES (@ID, @CDID, @CDMov, @CDMovID, @CorteImporteD)
			    UPDATE Dinero SET CorteImporte = ISNULL(CorteImporte,0.0)+@CorteImporteD WHERE ID =  @CDID

			    IF @DMovTipo = 'DIN.E'
				BEGIN
				  SELECT @CorteDisminuciones = @CorteDisminuciones - @CorteImporteD
			      SELECT @CorteImporteDiferir = @CorteImporteDiferir + @CorteImporteD
				END
				ELSE
			      SELECT @CorteImporteDiferir = @CorteImporteDiferir-@CorteImporteD
              END 
              FETCH NEXT FROM crDiferirCorte INTO @CDID, @CDMov, @CDMovId, @CDImporte, @CDImpuestos, @CDTipoCambio, @DMovTipo, @CorteImporteDAnterior
            END -- While
          CLOSE crDiferirCorte
          DEALLOCATE crDiferirCorte
       	
		  INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo,    OrigenModuloID,    OrigenConcepto,    OrigenDeducible,		  OrigenFecha,    LoteFijo,    Retencion1,    Retencion2,    Retencion3,    Excento1,    Excento2,    Excento3,    Impuesto1,    Impuesto2,    Impuesto3,    TipoImpuesto1,    TipoImpuesto2,    TipoImpuesto3,    TipoRetencion1,    TipoRetencion2,    TipoRetencion3,    Importe1,                            Importe2,                            Importe3,                            SubTotal,                            ContUso,    ContUso2,    ContUso3,    ClavePresupuestal,    ClavePresupuestalImpuesto1,    DescuentoGlobal)
          SELECT @Modulo, @ID,      mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, 
                 ROUND(SUM(mi.Importe1*ISNULL(mcd.CorteImporte,0.0)/(ISNULL(Importe,0.0)+ISNULL(Impuestos,0.0))*CASE WHEN mt.Clave IN ('DIN.E', 'DIN.F', 'DIN.CP', 'DIN.TC') THEN -1 ELSE 1 END),@RedondeoMonetarios), 
                 ROUND(SUM(mi.Importe2*ISNULL(mcd.CorteImporte,0.0)/(ISNULL(Importe,0.0)+ISNULL(Impuestos,0.0))*CASE WHEN mt.Clave IN ('DIN.E', 'DIN.F', 'DIN.CP', 'DIN.TC') THEN -1 ELSE 1 END),@RedondeoMonetarios), 
                 ROUND(SUM(mi.Importe3*ISNULL(mcd.CorteImporte,0.0)/(ISNULL(Importe,0.0)+ISNULL(Impuestos,0.0))*CASE WHEN mt.Clave IN ('DIN.E', 'DIN.F', 'DIN.CP', 'DIN.TC') THEN -1 ELSE 1 END),@RedondeoMonetarios), 
                 ROUND(SUM(mi.SubTotal*ISNULL(mcd.CorteImporte,0.0)/(ISNULL(Importe,0.0)+ISNULL(Impuestos,0.0))*CASE WHEN mt.Clave IN ('DIN.E', 'DIN.F', 'DIN.CP', 'DIN.TC') THEN -1 ELSE 1 END),@RedondeoMonetarios), 
                 mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal
            FROM MovImpuesto mi
            JOIN Dinero d ON d.Estatus = 'CONCLUIDO' AND d.ID <> @ID
            JOIN MovTipo mt ON Mt.Modulo = 'DIN' AND mt.Mov = d.Mov
		    JOIN MovCorteDetalle mcd ON mcd.IDCorte = @ID AND mcd.ID = D.ID AND mcd.Cancelado = 0
           WHERE mi.Modulo = @Modulo AND mi.ModuloID = d.ID
           GROUP BY mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal
           ORDER BY mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal	

          IF @PPTO = 1
            INSERT MovPresupuesto (
                   Modulo,  ModuloID, CuentaPresupuesto,    Importe)
            SELECT @Modulo, @ID,      mp.CuentaPresupuesto, SUM(mp.Importe)
              FROM MovPresupuesto mp
              JOIN Dinero d ON d.Estatus = 'CONCLUIDO' AND (d.Corte = @ID OR d.CorteDestino = @ID) AND d.ID <> @ID
             WHERE mp.Modulo = @Modulo AND mp.ModuloID = d.ID
             GROUP BY mp.CuentaPresupuesto
             ORDER BY mp.CuentaPresupuesto

          IF @IVAFiscal IS NULL AND @IEPSFiscal IS NULL
            SELECT @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal FROM Dinero WHERE ID = @UltimoID
        END  
	  END ELSE
      BEGIN
        IF @Accion = 'CANCELAR'
        BEGIN
          UPDATE Dinero SET Corte = NULL WHERE Corte = @ID
          UPDATE Dinero SET CorteDestino = NULL WHERE CorteDestino = @ID
        END ELSE 
        BEGIN      
          IF @MovTipo = 'DIN.C' 
            UPDATE CtaDinero SET UltimoCorte = @FechaRegistro WHERE CtaDinero = @CtaDinero 

          SELECT @UltimoID = ISNULL(MAX(ID), 0) 
            FROM Dinero d, MovTipo mt 
           WHERE d.ID < @ID AND d.Mov = mt.Mov AND mt.Modulo = 'DIN' AND mt.Clave = 'DIN.C' AND d.Estatus = 'CONCLUIDO' AND d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero 

          UPDATE Dinero
             SET Corte = @ID
           WHERE ID > @UltimoID AND (Estatus = 'CONCLUIDO' OR ID = @ID) AND Moneda = @MovMoneda AND Empresa = @Empresa AND CtaDinero = @CtaDinero AND Corte IS NULL

          UPDATE Dinero
             SET CorteDestino = @ID
           WHERE ID > @UltimoID AND (Estatus = 'CONCLUIDO' OR ID = @ID) AND Moneda = @MovMoneda AND Empresa = @Empresa AND CtaDineroDestino = @CtaDinero AND CorteDestino IS NULL

          SELECT @IVAFiscal = NULL, @IEPSFiscal = NULL
          SELECT @IVAFiscal = SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IVAFiscal)/SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0)),
                 @IEPSFiscal = SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IEPSFiscal)/SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0)),
                 @ImporteTotalCorte = SUM(ISNULL(Importe, 0)+ISNULL(Impuestos, 0))
            FROM Dinero 
           WHERE Estatus='CONCLUIDO' AND (Corte = @ID OR CorteDestino = @ID) AND ID <> @ID

          SELECT @AplicaCorteFactor = @ImporteTotal / @ImporteTotalCorte 
          INSERT MovImpuesto (
                 Modulo,  ModuloID, OrigenModulo,    OrigenModuloID,    OrigenConcepto,    OrigenDeducible,		  OrigenFecha,    LoteFijo,    Retencion1,    Retencion2,    Retencion3,    Excento1,    Excento2,    Excento3,    Impuesto1,    Impuesto2,    Impuesto3,    TipoImpuesto1,    TipoImpuesto2,    TipoImpuesto3,    TipoRetencion1,    TipoRetencion2,    TipoRetencion3,    Importe1,                            Importe2,                            Importe3,                            SubTotal,                            ContUso,    ContUso2,    ContUso3,    ClavePresupuestal,    ClavePresupuestalImpuesto1,    DescuentoGlobal)
          SELECT @Modulo, @ID,      mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, SUM(mi.Importe1*@AplicaCorteFactor), SUM(mi.Importe2*@AplicaCorteFactor), SUM(mi.Importe3*@AplicaCorteFactor), SUM(mi.SubTotal*@AplicaCorteFactor), mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal
            FROM MovImpuesto mi
            JOIN Dinero d ON d.Estatus = 'CONCLUIDO' AND (d.Corte = @ID OR d.CorteDestino = @ID) AND d.ID <> @ID
           WHERE mi.Modulo = @Modulo AND mi.ModuloID = d.ID
           GROUP BY mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal
           ORDER BY mi.OrigenModulo, mi.OrigenModuloID, mi.OrigenConcepto, ISNULL(mi.OrigenDeducible, 100), mi.OrigenFecha, mi.LoteFijo, mi.Retencion1, mi.Retencion2, mi.Retencion3, mi.Excento1, mi.Excento2, mi.Excento3, mi.Impuesto1, mi.Impuesto2, mi.Impuesto3, mi.TipoImpuesto1, mi.TipoImpuesto2, mi.TipoImpuesto3, mi.TipoRetencion1, mi.TipoRetencion2, mi.TipoRetencion3, mi.ContUso, mi.ContUso2, mi.ContUso3, mi.ClavePresupuestal, mi.ClavePresupuestalImpuesto1, mi.DescuentoGlobal

          IF @PPTO = 1
            INSERT MovPresupuesto (
                   Modulo,  ModuloID, CuentaPresupuesto,    Importe)
            SELECT @Modulo, @ID,      mp.CuentaPresupuesto, SUM(mp.Importe)
              FROM MovPresupuesto mp
              JOIN Dinero d ON d.Estatus = 'CONCLUIDO' AND (d.Corte = @ID OR d.CorteDestino = @ID) AND d.ID <> @ID
             WHERE mp.Modulo = @Modulo AND mp.ModuloID = d.ID
             GROUP BY mp.CuentaPresupuesto
             ORDER BY mp.CuentaPresupuesto

          IF @IVAFiscal IS NULL AND @IEPSFiscal IS NULL
            SELECT @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal FROM Dinero WHERE ID = @UltimoID
        END
      END
    END

    IF @Directo = 0 AND @MovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.I', 'DIN.E', 'DIN.F', 'DIN.INV', 'DIN.RET') AND (@Estatus <> 'PENDIENTE' OR @Accion = 'CANCELAR')
      EXEC spDineroAplicar @Sucursal, @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
			   @FechaEmision, @FechaRegistro, @FechaAfectacion, @Ejercicio, @Periodo, 
                           @CtaDinero, @CtaDineroFactor, @CtaDineroTipoCambio, @ImporteTotal, @CfgContX, @CfgContXGenerar, 0,
                           @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @EstacionTrabajo -- REQ12336

    SELECT @CtaDineroImporte   = @ImporteTotal / @CtaDineroFactor, 
           @CtaDineroIntereses = @Intereses / @CtaDineroFactor

    IF (@MovTipo IN ('DIN.I', 'DIN.SD', 'DIN.E', 'DIN.F', 'DIN.SCH') AND @CtaDineroTipo <> 'CAJA') OR (@MovTipo IN ('DIN.CH', 'DIN.CHE') AND @Accion = 'AFECTAR' AND @Estatus = 'PENDIENTE')
      SELECT @Ok = @Ok

    ELSE
    IF @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR','POSFECHADO','PENDIENTE') OR @Accion <> 'AFECTAR'
    BEGIN     
      -- Abono
      IF @MovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.E', 'DIN.F', 'DIN.CB', 'DIN.DF', 'DIN.CP', 'DIN.C', 'DIN.T', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP', 'DIN.CNI') AND @SubClave  NOT IN( 'DIN.AMULTIMONEDA','DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA') 
      BEGIN
        IF @Accion <> 'CANCELAR' SELECT @EsCargo = 0 ELSE SELECT @EsCargo = 1
        SELECT @AbonoImporte = @CtaDineroImporte
        IF @MovTipo = 'DIN.RET' AND @CfgInversionIntereses = 'CIERRE DIARIO' SELECT @AbonoImporte = @AbonoImporte + @CtaDineroIntereses
        EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @MovMoneda, @CtaDineroTipoCambio, @CtaDinero, NULL, NULL, NULL,
                     @Modulo, @ID, @Mov, @MovID, @EsCargo, @AbonoImporte, NULL, NULL,
                     @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
  		     @Ok OUTPUT, @OkRef OUTPUT

        IF @MovTipo IN ('DIN.CP', 'DIN.C') AND @Ok IS NULL AND ISNULL(@CtaDineroImporte, 0.0) <> 0.0 AND @SubClave  NOT IN('DIN.CMULTIMONEDA','DIN.CPMULTIMONEDA') --Mejora 5669
        BEGIN
          IF (SELECT DineroCorteSDPorFormaPago FROM EmpresaCfg WHERE Empresa = @Empresa) = 0
          BEGIN
    	    EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa,@Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
	 	                 @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 1, 1,
		                 @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDineroDestino, NULL, @CtaDineroImporte, NULL, NULL, NULL, NULL,
			         @DineroMov OUTPUT, @DineroMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @OrigenTipo = @OrigenTipo, @IgnorarFormaPago = 1
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          END ELSE
          BEGIN
            SELECT @CtaDineroSaldo = @CtaDineroImporte
            DECLARE crCorteFormaPago CURSOR FOR
             SELECT RTRIM(d.FormaPago), RTRIM(d.Referencia), ISNULL(d.Importe, 0), NULLIF(RTRIM(fp.DefCtaDinero), '')
               FROM DineroD d, FormaPago fp 
              WHERE d.ID = @ID AND d.FormaPago = fp.FormaPago
            OPEN crCorteFormaPago
            FETCH NEXT FROM crCorteFormaPago INTO @FormaPagoD, @ReferenciaD, @ImporteD, @CtaDineroD
            WHILE @@FETCH_STATUS <> -1 
            BEGIN                         
              IF @@FETCH_STATUS <> -2 AND @CtaDineroD IS NOT NULL
              BEGIN                
                EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa,@Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
	 	                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaD, @DocFuente, @Observaciones, 0, 1,
		                     @FechaRegistro, @Ejercicio, @Periodo, @FormaPagoD, NULL, NULL, NULL, @CtaDineroD, NULL, @ImporteD, NULL, NULL, NULL, NULL,
			             @DineroMov OUTPUT, @DineroMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @OrigenTipo = @OrigenTipo, @IgnorarFormaPago = 1
                IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
                SELECT @CtaDineroSaldo = @CtaDineroSaldo - @ImporteD
              END 
              FETCH NEXT FROM crCorteFormaPago INTO @FormaPagoD, @ReferenciaD, @ImporteD, @CtaDineroD
            END -- While
            CLOSE crCorteFormaPago
            DEALLOCATE crCorteFormaPago
            IF @CtaDineroSaldo <> 0.0
            BEGIN
    	      EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa,@Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
	 	                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 1,
		                   @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDineroDestino, NULL, @CtaDineroSaldo, NULL, NULL, NULL, NULL,
			           @DineroMov OUTPUT, @DineroMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @OrigenTipo = @OrigenTipo, @IgnorarFormaPago = 1
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            END
          END
        END 
      END
	  SELECT @SubClave = ISNULL(@SubClave,'Sin')
      -- Cargo
      IF @MovTipo IN ('DIN.D', 'DIN.DE', 'DIN.I', 'DIN.DA', 'DIN.AB', 'DIN.CD', 'DIN.T', 'DIN.INV', 'DIN.RET', 'DIN.REI', 'DIN.TC', 'DIN.A', 'DIN.AP') AND @SubClave  NOT IN( 'DIN.AMULTIMONEDA','DIN.TCMULTIMONEDA')--Mejora 5669
      BEGIN
        IF @Accion <> 'CANCELAR' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
        IF @MovTipo NOT IN ('DIN.T', 'DIN.INV', 'DIN.RET', 'DIN.TC', 'DIN.A', 'DIN.AP') SELECT @CtaDineroDestino = @CtaDinero

        IF @MovTipo IN ('DIN.T', 'DIN.INV', 'DIN.RET') AND @CtaDineroDestinoMoneda <> @MovMoneda
        BEGIN
          SELECT @DepositoImporte = ((@ImporteTotal + ISNULL(@Intereses, 0)) * @MovTipoCambio) / @TipoCambioDestino
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @CtaDineroDestinoMoneda, @TipoCambioDestino, @CtaDineroDestino, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @DepositoImporte, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
	  	       @Ok OUTPUT, @OkRef OUTPUT
        END ELSE
        IF @MovTipo = 'DIN.D' AND @CtaDineroMoneda <> @MovMoneda
        BEGIN
          /** JH 22.08.2006 **/ 
          /*IF @TipoCambioDestino IS NULL*/
          IF @Accion ='CANCELAR'
			 SELECT @DepositoTipoCambio=Tipocambio,@DepositoFactor=TipoCambio  from Auxiliar where ModuloID =@ID 
		   ELSE
            EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @CtaDineroMoneda, @DepositoFactor OUTPUT, @DepositoTipoCambio OUTPUT, @Ok OUTPUT, @ModuloID = @ID
         /*ELSE
            SELECT @DepositoFactor = @TipoCambioDestino */

          /** Inicia cambio Bug 24360 **/  
          IF @Accion = 'CANCELAR' AND @MovTipo = 'DIN.D' AND @OrigenMovTipo = 'DIN.TI' AND @CtaDineroDestinoMoneda <> @MovMoneda
            SELECT @DepositoImporte = ((@ImporteTotal + ISNULL(@Intereses, 0)) * @MovTipoCambio) / @TipoCambioDestino
          ELSE
          /** Termina cambio Bug 24360 **/  
            SELECT @DepositoImporte = (@ImporteTotal + ISNULL(@Intereses, 0)) / @DepositoFactor

          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @CtaDineroMoneda, @DepositoTipoCambio, @CtaDineroDestino, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @DepositoImporte, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
	  	       @Ok OUTPUT, @OkRef OUTPUT
        END ELSE
        BEGIN
          SELECT @CargoImporte = @CtaDineroImporte + ISNULL(@CtaDineroIntereses, 0)
          EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @MovMoneda, @CtaDineroTipoCambio, @CtaDineroDestino, NULL, NULL, NULL,
                       @Modulo, @ID, @Mov, @MovID, @EsCargo, @CargoImporte, NULL, NULL,
                       @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
	  	       @Ok OUTPUT, @OkRef OUTPUT
        END
      END
    END

    IF @CfgAfectarComision = 1 AND @MovTipo IN ('DIN.D', 'DIN.DE', 'DIN.CH', 'DIN.CHE') AND @EstatusNuevo <> 'PENDIENTE'
    BEGIN
      SELECT @Comision = NULL, @Comision2 = NULL, @ComisionIVA = NULL
      IF @ConDesglose = 0 OR @MovTipo IN ('DIN.CHE', 'DIN.CH')
      BEGIN
        IF @MovTipo IN ('DIN.CHE', 'DIN.CH')
          SELECT @Comision = CargoBancario, @ComisionIVA = CargoBancarioIVA FROM Dinero WHERE ID = @ID
        ELSE
          SELECT @Comision    = @ImporteTotal*(Comision/100.0),
                 @ComisionIVA = (@ImporteTotal*(Comision/100.0))*(Impuestos/100.0),
                 @Comision2   = @ImporteTotal*(Comision2/100.0),
                 @Comision2IVA= (@ImporteTotal*(Comision2/100.0))*(Impuestos/100.0)
            FROM FormaPago 
           WHERE FormaPago = @FormaPago

        SELECT @ComisionMov     = CASE WHEN @Comision     < 0.0 THEN BancoAbonoBancario    ELSE BancoCargoBancario    END, 
               @Comision2Mov    = CASE WHEN @Comision2    < 0.0 THEN BancoAbonoBancario    ELSE BancoCargoBancario    END, 
               @ComisionMovIVA  = CASE WHEN @ComisionIVA  < 0.0 THEN BancoAbonoBancarioIVA ELSE BancoCargoBancarioIVA END, 
               @Comision2MovIVA = CASE WHEN @Comision2IVA < 0.0 THEN BancoAbonoBancarioIVA ELSE BancoCargoBancarioIVA END
          FROM EmpresaCfgMov 
         WHERE Empresa = @Empresa
        SELECT @Comision = ABS(@Comision), @ComisionIVA = ABS(@ComisionIVA), @Comision2 = ABS(@Comision2), @Comision2IVA = ABS(@Comision2IVA)

        IF @CfgAfectarComisionIVA = 0 
          SELECT @ComisionImpuestos = @ComisionIVA, @Comision2Impuestos = @Comision2IVA 
        ELSE SELECT @ComisionImpuestos = NULL, @Comision2Impuestos = NULL
        IF ISNULL(@Comision, 0.0) <> 0.0
          EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 1, 1,
		  	       @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDinero, NULL, @Comision, @ComisionImpuestos, @ComisionMov, NULL, NULL,
			       @ComisionMov, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF ISNULL(@Comision2, 0.0) <> 0.0
          EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 1, 1,
		  	       @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDinero, NULL, @Comision2, @Comision2Impuestos, @Comision2Mov, NULL, NULL,
			       @Comision2Mov, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo

        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF @CfgAfectarComisionIVA = 1 
        BEGIN
          IF ISNULL(@ComisionIVA, 0.0) <> 0.0 
            EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                 @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 1, 1,
	  	  	         @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDinero, NULL, @ComisionIVA, NULL, @ComisionMovIVA, NULL, NULL,
			         @ComisionMovIVA, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          IF @Ok = 60060 AND @Accion = 'CANCELAR' SELECT @Ok = NULL, @OkRef = NULL
          IF ISNULL(@Comision2IVA, 0.0) <> 0.0 
            EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                 @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 1, 1,
	  	  	         @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDinero, NULL, @Comision2IVA, NULL, @Comision2MovIVA, NULL, NULL,
			         @Comision2MovIVA, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          IF @Ok = 60060 AND @Accion = 'CANCELAR' SELECT @Ok = NULL, @OkRef = NULL
        END
      END ELSE 
      BEGIN
        DECLARE crComisionFormaPago CURSOR FOR
         SELECT d.FormaPago, d.Referencia, 
                ISNULL(d.Importe, 0)*ISNULL(fp.Comision/100.0, 0),
                (ISNULL(d.Importe, 0)*ISNULL(fp.Comision/100.0, 0))*ISNULL(fp.Impuestos/100.0, 0), 
                ISNULL(d.Importe, 0)*ISNULL(fp.Comision2/100.0, 0),
                (ISNULL(d.Importe, 0)*ISNULL(fp.Comision2/100.0, 0))*ISNULL(fp.Impuestos/100.0, 0)
           FROM DineroD d, FormaPago fp 
          WHERE d.ID = @ID AND d.FormaPago = fp.FormaPago
        OPEN crComisionFormaPago
        FETCH NEXT FROM crComisionFormaPago INTO @FormaPagoD, @ReferenciaD, @Comision, @ComisionIVA, @Comision2, @Comision2IVA
        WHILE @@FETCH_STATUS <> -1 
        BEGIN                         
          IF @@FETCH_STATUS <> -2 
          BEGIN
            SELECT @ComisionMov     = CASE WHEN @Comision     < 0.0 THEN BancoAbonoBancario    ELSE BancoCargoBancario    END, 
                   @Comision2Mov    = CASE WHEN @Comision2    < 0.0 THEN BancoAbonoBancario    ELSE BancoCargoBancario    END, 
                   @ComisionMovIVA  = CASE WHEN @ComisionIVA  < 0.0 THEN BancoAbonoBancarioIVA ELSE BancoCargoBancarioIVA END, 
                   @Comision2MovIVA = CASE WHEN @Comision2IVA < 0.0 THEN BancoAbonoBancarioIVA ELSE BancoCargoBancarioIVA END
              FROM EmpresaCfgMov 
             WHERE Empresa = @Empresa
            SELECT @Comision = ABS(@Comision), @ComisionIVA = ABS(@ComisionIVA), @Comision2 = ABS(@Comision2), @Comision2IVA = ABS(@Comision2IVA)

            IF @CfgAfectarComisionIVA = 0 
              SELECT @ComisionImpuestos = @ComisionIVA, @Comision2Impuestos = @Comision2IVA
            ELSE SELECT @ComisionImpuestos = NULL, @Comision2Impuestos = NULL
            IF ISNULL(@Comision, 0.0) <> 0.0
              EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaD, @DocFuente, @Observaciones, 1, 1,
	    	  	           @FechaRegistro, @Ejercicio, @Periodo, @FormaPagoD, NULL, NULL, NULL, @CtaDinero, NULL, @Comision, @ComisionImpuestos, @ComisionMov, NULL, NULL,
			           @ComisionMov, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF ISNULL(@Comision2, 0.0) <> 0.0
              EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaD, @DocFuente, @Observaciones, 1, 1,
	    	  	           @FechaRegistro, @Ejercicio, @Periodo, @FormaPagoD, NULL, NULL, NULL, @CtaDinero, NULL, @Comision2, NULL, @Comision2Mov, NULL, NULL,
			           @Comision2Mov, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF @CfgAfectarComisionIVA = 1 
            BEGIN
              IF ISNULL(@ComisionIVA, 0.0) <> 0.0
                EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaD, @DocFuente, @Observaciones, 1, 1,
	      	  	             @FechaRegistro, @Ejercicio, @Periodo, @FormaPagoD, NULL, NULL, NULL, @CtaDinero, NULL, @ComisionIVA, NULL, @ComisionMovIVA, NULL, NULL,
			             @ComisionMovIVA, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
              IF @Ok = 60060 AND @Accion = 'CANCELAR' SELECT @Ok = NULL, @OkRef = NULL
              IF ISNULL(@Comision2IVA, 0.0) <> 0.0
                EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaD, @DocFuente, @Observaciones, 1, 1,
	      	  	             @FechaRegistro, @Ejercicio, @Periodo, @FormaPagoD, NULL, NULL, NULL, @CtaDinero, NULL, @Comision2IVA, NULL, @Comision2MovIVA, NULL, NULL,
			             @Comision2MovIVA, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = NULL, @IEPSFiscal = NULL, @DesgloseManual = 1, @OrigenTipo = @OrigenTipo
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
              IF @Ok = 60060 AND @Accion = 'CANCELAR' SELECT @Ok = NULL, @OkRef = NULL
            END
          END 
          FETCH NEXT FROM crComisionFormaPago INTO @FormaPagoD, @ReferenciaD, @Comision, @ComisionIVA, @Comision2, @Comision2IVA
        END -- While
        CLOSE crComisionFormaPago
        DEALLOCATE crComisionFormaPago
      END
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    END

    IF @Ok IS NULL
    BEGIN
      IF @Accion = 'CANCELAR' SELECT @SaldoNuevo = 0.0
      IF @EstatusNuevo = 'PENDIENTE'  AND @MovTipo IN ('DIN.I', 'DIN.SD','DIN.E', 'DIN.F', 'DIN.SCH', 'DIN.INV', 'DIN.TI', 'DIN.DA', 'DIN.CNI') SELECT @SaldoNuevo = @CtaDineroImporte
      IF @EstatusNuevo <> 'PENDIENTE' AND @SaldoNuevo > 0.0 SELECT @EstatusNuevo = 'PENDIENTE'
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR','POSFECHADO') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR','CONFIRMAR','POSFECHADO') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  
      IF @SaldoNuevo = 0.0 SELECT @SaldoNuevo = NULL

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Dinero 
         SET FechaConclusion 	= @FechaConclusion, 
             FechaCancelacion 	= @FechaCancelacion, 
             UltimoCambio       = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus 		= @EstatusNuevo, 
	     Situacion 	      	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
             Concepto 		= @Concepto, 
	     GenerarPoliza 	= @GenerarPoliza, 
             IVAFiscal		= @IVAFiscal,
             IEPSFiscal		= @IEPSFiscal,
             Impuestos 		= @Impuestos, 
             Saldo 		= @SaldoNuevo,
             Mensaje            = NULL
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1

      IF @Conexion = 0 AND @MovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.I','DIN.E') AND (@Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') OR @Accion = 'CANCELAR') AND @Ok IS NULL
        EXEC spDineroRelacionar @Empresa, @Accion, @Modulo, @ID, @Mov, @MovID, @CtaDinero

      IF @AutoConciliar = 1 
        UPDATE Auxiliar SET Conciliado = 1 WHERE Empresa = @Empresa AND Modulo = 'DIN' AND ModuloID = @ID AND Conciliado = 0

      EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT

      IF @Utilizar = 1 
      BEGIN
        SELECT @FechaConclusion = @FechaEmision
        EXEC spValidarTareas @Empresa, @Modulo, @UtilizarID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero SET FechaConclusion = @FechaConclusion, Estatus = 'CONCLUIDO', Saldo = NULL WHERE ID = @UtilizarID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END

      IF @Generar = 1
      BEGIN
        IF @GenerarAfectado = 1 SELECT @GenerarEstatus = 'CONCLUIDO' ELSE SELECT @GenerarEstatus = 'SINAFECTAR'
        IF @GenerarEstatus = 'CONCLUIDO' SELECT @FechaConclusion = @FechaEmision ELSE IF @GenerarEstatus <> 'CANCELADO' SELECT @FechaConclusion = NULL
        IF @GenerarEstatus = 'CONCLUIDO' AND @CfgContX = 1 AND @CfgContXGenerar <> 'NO' SELECT @GenerarPolizaTemp = 1 ELSE SELECT @GenerarPolizaTemp = 0
        EXEC spValidarTareas @Empresa, @Modulo, @IDGenerar, @GenerarEstatus, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Dinero SET FechaConclusion = @FechaConclusion, Estatus = @GenerarEstatus, GenerarPoliza = @GenerarPolizaTemp WHERE ID = @IDGenerar 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    IF @MovTipo = 'DIN.F' AND @Ok IS NULL
    BEGIN
      SELECT @FaltanteCajaModulo = DineroFaltanteModulo FROM EmpresaCfg WHERE Empresa = @Empresa
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @FaltanteCajaModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                       @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                       @FechaRegistro, @Ejercicio, @Periodo, 
                       NULL, NULL, @Cajero, NULL, @Cajero, NULL, NULL, NULL, 
                       @ImporteTotal, NULL, NULL, @ImporteTotal, 
                       NULL, NULL, NULL, NULL, NULL, NULL,
                       @CxModulo, @CxMov, @CxMovID, @Ok OUTPUT, @OkRef  OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    END

    IF @MovTipo IN ('DIN.SD', 'DIN.SCH') AND @OrigenTipo IN ('CXC', 'CXP'/*, 'VTAS', 'AGENT', 'NOM', 'GAS', 'COMS'*/) AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) 
    BEGIN
      SELECT @sOk = @Ok, @sOkRef = @OkRef
      SELECT @Ok = NULL, @OkRef = NULL, @GenerarCxSolicitud = 1
      IF @OrigenTipo IN ('VTAS', 'CXC') SELECT @CxModulo = 'CXC' ELSE SELECT @CxModulo = 'CXP'
      IF @Accion = 'CANCELAR'
      BEGIN
        IF @CxModulo = 'CXC' AND NOT EXISTS(SELECT * FROM Cxc WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID) SELECT @GenerarCxSolicitud = 0 ELSE
        IF @CxModulo = 'CXP' AND NOT EXISTS(SELECT * FROM Cxp WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID) SELECT @GenerarCxSolicitud = 0
      END ELSE
      BEGIN
        IF @ContactoTipo = 'Cliente'   
        BEGIN
          IF NOT EXISTS(SELECT * FROM Cte  WHERE Cliente   = @Contacto) SELECT @Ok = 26060, @OkRef = @Contacto 
        END ELSE 
          IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Contacto) SELECT @Ok = 26050, @OkRef = @Contacto 
      END
      IF @GenerarCxSolicitud = 1
      BEGIN
        EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                 @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                 @FechaRegistro, @Ejercicio, @Periodo, 
                                 NULL, NULL, @Contacto, @ContactoEnviarA, NULL, NULL, @CtaDinero, NULL, 
                                 @ImporteTotal, NULL, NULL, NULL, 
                                 NULL, NULL, NULL, NULL, NULL, NULL,
                                 @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
      END
      IF @Ok IS NULL
        SELECT @Ok = @sOk, @OkRef = @sOkRef
    END

    IF @MovTipo IN ('DIN.ACXC', 'DIN.ACXP') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) 
    BEGIN
      SELECT @sOk = @Ok, @sOkRef = @OkRef
      SELECT @Ok = NULL, @OkRef = NULL
      UPDATE Dinero SET ContactoTipo = @ContactoTipo, Contacto = @Contacto, ContactoEnviarA = @ContactoEnviarA WHERE ID = @ID
      IF @MovTipo = 'DIN.ACXC' SELECT @CxModulo = 'CXC' ELSE SELECT @CxModulo = 'CXP'
      EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                               @FechaRegistro, @Ejercicio, @Periodo, 
                               NULL, NULL, @Contacto, @ContactoEnviarA, NULL, NULL, NULL, NULL, 
                               @ImporteTotal, NULL, NULL, NULL, 
                               NULL, NULL, NULL, NULL, NULL, NULL,
                               @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
      IF @Ok IS NULL
        SELECT @Ok = @sOk, @OkRef = @sOkRef
    END

    IF @MovTipo = 'DIN.TI'
      EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa,@Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
	                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @ConDesglose, 1,
		           @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, NULL, NULL, NULL, @CtaDinero, NULL, @CtaDineroImporte, NULL, NULL, NULL, NULL,
		           @DineroMov OUTPUT, @DineroMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = @IVAFiscal, @IEPSFiscal = @IEPSFiscal, @OrigenTipo = @OrigenTipo, @IgnorarFormaPago = 1

    IF (SELECT TieneMovimientos FROM CtaDinero WHERE CtaDinero = @CtaDinero) = 0    
      UPDATE CtaDinero SET TieneMovimientos = 1 WHERE CtaDinero = @CtaDinero

    IF @CtaDineroDestino IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM CtaDinero WHERE CtaDinero = @CtaDineroDestino) = 0    
        UPDATE CtaDinero SET TieneMovimientos = 1 WHERE CtaDinero = @CtaDineroDestino
    END

    /* MovImpuesto */
    IF @OrigenTipo IS NOT NULL AND NOT EXISTS(SELECT * FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID)
    BEGIN
      EXEC spMovInfo @OrigenID OUTPUT, @OrigenTipo, @OrigenMov, @OrigenMovID, @Empresa = @Empresa, @Total = @OrigenTotal OUTPUT
      SELECT @OrigenFactor = @Importe / NULLIF(@OrigenTotal, 0.0)

      DECLARE @OrigenImporte money
      SELECT @OrigenImporte = Importe FROM Dinero WHERE ID = @OrigenID
      EXEC xpDineroOrigenFactorMovImpuesto @Sucursal, @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @OrigenID, @OrigenMov, @OrigenMovID, @OrigenTipo, @OrigenImporte, NULL, @OrigenFactor OUTPUT, @Ok OUTPUT,  @OkRef OUTPUT

      INSERT MovImpuesto (
             Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,              OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1,               Importe2,               Importe3,               SubTotal,               ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal)
      SELECT @Modulo, @ID,      OrigenModulo, OrigenModuloID, OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, Impuesto1, Impuesto2, Impuesto3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoRetencion1, TipoRetencion2, TipoRetencion3, Importe1*@OrigenFactor, Importe2*@OrigenFactor, Importe3*@OrigenFactor, SubTotal*@OrigenFactor, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, DescuentoGlobal
        FROM MovImpuesto
       WHERE Modulo = @OrigenTipo AND ModuloID = @OrigenID
    END

    /* MovPresupuesto */
    IF @PPTO = 1 AND @OrigenTipo IS NOT NULL AND NOT EXISTS(SELECT * FROM MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ID)
    BEGIN
      EXEC spMovInfo @OrigenID OUTPUT, @OrigenTipo, @OrigenMov, @OrigenMovID, @Empresa = @Empresa, @Total = @OrigenTotal OUTPUT
      SELECT @OrigenFactor = @Importe / NULLIF(@OrigenTotal, 0.0)
      INSERT MovPresupuesto (
             Modulo,  ModuloID, CuentaPresupuesto, Importe)
      SELECT @Modulo, @ID,      CuentaPresupuesto, Importe*@OrigenFactor
        FROM MovPresupuesto
       WHERE Modulo = @OrigenTipo AND ModuloID = @OrigenID
    END

    IF @Accion <> 'CANCELAR' AND (SELECT DineroValidarMovImpuesto FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
     IF ROUND(@Importe, 2) <> (SELECT ROUND(SUM(ISNULL(Importe1, 0.0)+ISNULL(Importe2, 0.0)+ISNULL(Importe3, 0.0)+ISNULL(SubTotal, 0.0)-ISNULL(SubTotal*(Retencion1/100),0.0) - ISNULL(CASE WHEN @Retencion2BaseImpuesto1 = 0 THEN SubTotal ELSE Importe1 END*(Retencion2/100),0.0)- ISNULL(SubTotal*(Retencion3/100),0.0) ), 2) FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID)
       SELECT @Ok = 35330

    IF @MovTipo = 'DIN.C' AND @CfgCajeros = 1 AND @CfgAutoFaltanteSobrante = 1 AND @Accion = 'CANCELAR' AND @SubClave  NOT IN('DIN.CMULTIMONEDA') 
      EXEC spDineroFaltanteSobrante @Accion, @Empresa, @Sucursal, @Usuario, @ID, @Mov, @MovID, NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      IF @GenerarGasto = 1 
         EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipoGenerarGasto = 1

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC xpDineroAfectar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, 
                           @CtaDinero, @CtaDineroTipo, @CtaDineroDestino, @CtaDineroFactor, @CtaDineroTipoCambio, @CtaDineroMoneda, @Cajero,
                           @Importe, @Impuestos, @Saldo, 
      	                   @Directo, @CfgContX, @CfgContXGenerar, @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo -- REQ12336

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT

--IF @Ok IN (NULL, 80030) SELECT @Ok = 1 --breakpoint
  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      BEGIN
        DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
        INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
        ROLLBACK TRANSACTION
        DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
        INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada
      END
  RETURN
END
GO



/**************** spDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDinero') and type = 'P') drop procedure dbo.spDinero
GO
CREATE PROCEDURE spDinero
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),
		   @FechaRegistro		datetime,
		   @GenerarMov			char(20),
		   @Usuario			char(10), 

    		   @Conexion			bit,
		   @SincroFinal			bit,

    		   @Mov	      			char(20)	OUTPUT,
    		   @MovID            		varchar(20)	OUTPUT,
		   @IDGenerar			int		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @EstacionTrabajo int = NULL -- REQ12336
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @PuedeEditar		bit,
    @EnLinea			bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Concepto	      		varchar(50),
    @Proyecto	      		varchar(50),
    @MovMoneda	      		char(10),
    @MovTipoCambio	   	float,
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @Referencia	      		varchar(50),
    @DocFuente	      		int,
    @Beneficiario		int,
    @BeneficiarioNombre		varchar(100),
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @AutoConciliar		bit,
    @Cajero			char(10),
    @FormaPago			varchar(50),
    @IVAFiscal			float,
    @IEPSFiscal			float,

    @CtaDinero		        char(10),
    @CtaDineroTipo		char(20),
    @CtaDineroDestino		char(10),
    @CtaDineroDestinoTipo	char(20),
    @CtaDineroFactor		float,
    @CtaDineroTipoCambio	float,
    @CtaDineroMoneda  		char(10),
    @CtaDineroDestinoMoneda	char(10),
    @Contacto			char(10),
    @ContactoTipo		varchar(20),
    @ContactoEnviarA		int,
    @TipoCambioDestino		float,    
    @CtaEmpresa			char(5),
    @Importe   			money,	 
    @Impuestos	        	money,
    @Saldo			money,
    @Serie		 	char(20),
    @Corte			int,
    @CorteDestino		int,   
    @Directo			bit,
    @ConDesglose                bit,
    @CfgAfectarComision		bit,
    @CfgAfectarComisionIVA	bit,
    @CfgChequesPendientes	bit,
    @CfgeChequesPendientes	bit,
    @CfgCajeros			bit,
    @CfgAutoFaltanteSobrante	bit,
    @CfgSobregiros		bit,
    @CfgFormaPagoRequerida	bit,
    @CfgChequesDirectos		bit,
    @CfgContX			bit, 
    @CfgEmbarcar		bit,
    @CfgContXGenerar		char(20),
    @GenerarPoliza		bit,
    @OrigenTipo			char(10),
    @OrigenMov			char(20),
    @OrigenMovID		varchar(20),
    @OrigenMovTipo		char(20),
    @CajeroActual		char(10),
    @Dias			int,
    @TasaDiaria			float,
    @Retencion			money,
    @CfgInversionIntereses 	varchar(20),
    @InteresTipo		varchar(20),
    @Titulo			varchar(10),
    @TituloValor		float,
    @ValorOrigen		float,
    @Cliente			varchar(10),
    @ClienteEnviarA		int,
    @Proveedor			varchar(10),
    @GenerarGasto		bit, 

    @EstatusNuevo	      	char(15),
    @Generar                    bit,
    @GenerarAfectado		bit,
    @GenerarAfectando		bit,
    @GenerarCopia		bit,
    @GenerarMovID		varchar(20),
    @GenerarSerie		char(20),
    @GenerarEstatus	 	char(15),
    @GenerarMovTipo 		char(20), 
    @GenerarPeriodo 		int, 
    @GenerarEjercicio 		int,

    @Autorizar			bit,

    @Utilizar			bit,
    @UtilizarID 		int, 
    @UtilizarMov 		char(20), 
    @UtilizarMovID 		varchar(20), 
    @UtilizarMovTipo		char(20)/*,
    @Verificar			bit*/,
    @SubClave                   varchar(20),
    @ChequeDevuelto		bit --MEJORA6013
    
  
  

  -- Inicializar Variables
  SELECT @Generar	  	 = 0,
	 @GenerarAfectado 	 = 0,
	 @GenerarAfectando	 = 0,
	 @GenerarCopia	  	 = 1,
         @GenerarSerie		 = NULL,
	 @Utilizar		 = 0,
         @Impuestos		 = 0.0,
	 @Saldo			 = 0.0,
	 @Directo		 = 0,
	 @Beneficiario		 = NULL,
         @BeneficiarioNombre     = NULL,
    	 @CtaDineroMoneda  	 = NULL,
         @CtaDineroDestinoMoneda = NULL,
         @TipoCambioDestino	 = 1.0,
         @Serie			 = NULL, 
         @CfgContX		 = 0,
         @CfgContXGenerar	 = 'NO',
         @CfgEmbarcar		 = 0,
         @Autorizar		 = 0,
         @OrigenMovTipo		 = NULL/*,
	 @Verificar		 = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @MovUsuario = Usuario, @Autorizacion = Autorizacion, @Referencia = Referencia,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Beneficiario = Beneficiario, @BeneficiarioNombre = BeneficiarioNombre, @Estatus = UPPER(Estatus), @Directo = Directo,
         @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @CtaDineroDestino = NULLIF(RTRIM(CtaDineroDestino), ''), @FormaPago = NULLIF(RTRIM(FormaPago), ''),
         @Importe = ISNULL(Importe, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Saldo = ISNULL(Saldo, 0.0), @ConDesglose = ConDesglose,
         @GenerarPoliza = GenerarPoliza, @OrigenTipo = OrigenTipo, @OrigenMov = Origen, @OrigenMovID = OrigenID, @FechaConclusion = FechaConclusion,
         @AutoConciliar = AutoConciliar, @Corte = Corte, @CorteDestino = CorteDestino, @Cajero = NULLIF(RTRIM(Cajero), ''), @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal,
         @TipoCambioDestino = TipoCambioDestino, @Dias = DATEDIFF(day, FechaOrigen, Vencimiento), @TasaDiaria = Tasa / NULLIF(TasaDias, 0), @Retencion = ISNULL(Retencion, 0.0), --@TasaRetencionDiaria = ISNULL(TasaRetencion / NULLIF(TasaDias, 0), 0.0), --@TasaRetencion = ISNULL(TasaRetencion, 0.0),  /** JH 1.18.2007 **/
         @InteresTipo = ISNULL(NULLIF(RTRIM(UPPER(InteresTipo)), ''), 'TASA FIJA'), @Titulo = NULLIF(RTRIM(Titulo), ''), @TituloValor = ISNULL(TituloValor, 0.0), @ValorOrigen = ISNULL(ValorOrigen, 0.0),
         @Contacto = Contacto, @ContactoTipo = ContactoTipo, @ContactoEnviarA = ContactoEnviarA, @Cliente = NULLIF(RTRIM(Cliente), ''), @ClienteEnviarA = ClienteEnviarA, @Proveedor = NULLIF(RTRIM(Proveedor), ''), @ChequeDevuelto = ISNULL(ChequeDevuelto,0) --MEJORA6013
    FROM Dinero
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 

  IF @Accion = 'AUTORIZAR'
    SELECT @Autorizacion = @Usuario, @Accion = 'AFECTAR'

  -- Si va a Generar un Movimiento 
  IF @GenerarMov IS NOT NULL 
    IF @Accion = 'AFECTAR' SELECT @Utilizar = 1 ELSE
    IF @Accion = 'GENERAR' SELECT @Generar = 1

  IF @Generar = 1 SELECT @EstatusNuevo = @Estatus

  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('VERIFICAR', 'AFECTAR', 'CANCELAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT, @GenerarGasto = @GenerarGasto OUTPUT

  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
          
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        -- Nota usa serie
        -- Asignar el Consecutivo al Movimiento
        IF @MovTipo IN ('DIN.CH', 'DIN.CHE') SELECT @Serie = @CtaDinero

        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, @Serie, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
        SELECT @Sucursal = @SucursalDestino
      END ELSE
        SELECT @Accion = 'SINCRO'
    END

    IF @Estatus = 'SINCRO' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spPuedeEditarMovMatrizSucursal @Sucursal, @SucursalOrigen, @ID, @Modulo, @Empresa, @Usuario, @Mov, @Estatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 0 
        SELECT @Ok = 60300 
      ELSE BEGIN
        SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR','POSFECHADO', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO',  'PENDIENTE'))
  BEGIN
    IF @OrigenMovID IS NOT NULL AND @OrigenMov IS NOT NULL
      SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @OrigenMov

    SELECT @CfgChequesPendientes    = ChequesPendientes,
	   @CfgeChequesPendientes   = eChequesPendientes,
           @CfgCajeros              = Cajeros,
           @CfgAutoFaltanteSobrante = DineroAutoFaltanteSobrante,
           @CfgSobregiros	    = DineroControlarSobregiros,
	   @CfgFormaPagoRequerida   = FormaPagoRequerida,
           @CfgChequesDirectos      = ChequesDirectos, 
           @CfgAfectarComision	    = DineroAfectarComision,
           @CfgAfectarComisionIVA   = DineroAfectarComisionIVA,
           @CfgInversionIntereses   = UPPER(DineroInversionIntereses)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgCajeros = 1 
      SELECT @CfgCajeros = Cajeros FROM Sucursal WHERE Sucursal = @Sucursal

    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF EXISTS(SELECT * FROM EmpresaCfgMovEsp WHERE Empresa = @Empresa AND Asunto = 'EMB' AND Modulo = @Modulo AND Mov = @Mov)
      SELECT @CfgEmbarcar = 1

    SELECT @CtaDineroTipo = UPPER(Tipo), @CtaDineroMoneda = Moneda, @CtaEmpresa = NULLIF(RTRIM(Empresa), '') FROM CtaDinero WHERE CtaDinero = @CtaDinero
    IF @CtaDineroDestino IS NOT NULL 
      SELECT @CtaDineroDestinoTipo = UPPER(Tipo), @CtaDineroDestinoMoneda = Moneda FROM CtaDinero WHERE CtaDinero = @CtaDineroDestino
  
    -- Checar Tipo de Movimiento
    IF @Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR','POSFECHADO')
    BEGIN
      IF @MovTipo IN ('DIN.INV', 'DIN.TI') SELECT @EstatusNuevo = 'PENDIENTE' 
      IF @MovTipo = 'DIN.CH'  AND @CfgChequesPendientes = 1 SELECT @EstatusNuevo = 'PENDIENTE' ELSE
      IF @MovTipo = 'DIN.CHE' AND @CfgeChequesPendientes = 1 SELECT @EstatusNuevo = 'PENDIENTE' ELSE
      IF (@MovTipo IN ('DIN.DA', 'DIN.I', 'DIN.E', 'DIN.F', 'DIN.CNI') AND @CtaDineroTipo <> 'CAJA') OR (@MovTipo IN ('DIN.SD', 'DIN.SCH')) SELECT @EstatusNuevo = 'PENDIENTE'
    END

    IF @CtaDineroTipo        = 'CAJA' SELECT @CtaDineroMoneda        = @MovMoneda
    IF @CtaDineroDestinoTipo = 'CAJA' SELECT @CtaDineroDestinoMoneda = @MovMoneda

    -- Calcular CuentaFactor
    IF @Ok IS NULL
      EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @MovMoneda, @CtaDineroFactor OUTPUT, @CtaDineroTipoCambio OUTPUT, @Ok OUTPUT

    IF @MovTipo = 'DIN.ACXC' SELECT @ContactoTipo = 'Cliente',   @Contacto = @Cliente, @ContactoEnviarA = @ClienteEnviarA ELSE
    IF @MovTipo = 'DIN.ACXP' SELECT @ContactoTipo = 'Proveedor', @Contacto = @Proveedor

    -- Verificar esto antes, por las formas de pago
    IF @Accion <> 'GENERAR'
    BEGIN
      IF @CtaDineroTipo = 'CAJA' 
      BEGIN
        IF @MovTipo NOT IN ('DIN.TC','DIN.A','DIN.AP','DIN.I', 'DIN.SD', 'DIN.E', 'DIN.F', 'DIN.SCH', 'DIN.CP', 'DIN.C', 'DIN.RND', 'DIN.PR') SELECT @Ok = 30270
      END ELSE 
      BEGIN 
        IF @MovTipo NOT IN ('DIN.D','DIN.DE','DIN.CH','DIN.CHE','DIN.CB','DIN.AB','DIN.DF','DIN.CD','DIN.T','DIN.INV','DIN.RET','DIN.A','DIN.AP','DIN.DA','DIN.SD','DIN.SCH','DIN.RE','DIN.REI','DIN.RND', 'DIN.PR', 'DIN.ACXC', 'DIN.ACXP', 'DIN.TI', 'DIN.CNI')  AND @SubClave <>'DIN.TCMULTIMONEDA' SELECT @Ok = 30260 ELSE
        IF @CtaDinero IS NULL AND @EstatusNuevo = 'PENDIENTE' AND @MovTipo NOT IN ( 'DIN.SD', 'DIN.SCH') SELECT @Ok = 40030
      END
    END

    IF @Accion <> 'GENERAR'
    BEGIN
      SELECT @CajeroActual = NULL
      IF @MovTipo IN ('DIN.I', 'DIN.E', 'DIN.F', 'DIN.A', 'DIN.AP','DIN.CP', 'DIN.C', 'DIN.TC') AND @CfgCajeros = 1 AND @SubClave NOT IN ('DIN.AMULTIMONEDA' ,'DIN.CMULTIMONEDA' ,'DIN.CPMULTIMONEDA','DIN.TCMULTIMONEDA' )
      BEGIN
        SELECT @CajeroActual = NULLIF(RTRIM(Cajero), '') 
          FROM CtaDineroCajero 
         WHERE Moneda = ''/*@MovMoneda*/ AND CtaDinero = CASE WHEN @MovTipo IN ('DIN.A', 'DIN.AP') THEN @CtaDineroDestino ELSE @CtaDinero END 

        IF @Cajero IS NULL 
        BEGIN
          IF @MovTipo IN ('DIN.I', 'DIN.E') 
          BEGIN
            SELECT @Cajero = @CajeroActual
            UPDATE Dinero SET Cajero = @Cajero WHERE ID = @ID
          END ELSE
            SELECT @Ok = 30490
        END 

        IF (@MovTipo = 'DIN.A' AND @Accion <> 'CANCELAR') AND @SubClave NOT IN( 'DIN.AMULTIMONEDA') OR (@MovTipo = 'DIN.C' AND @Accion = 'CANCELAR' AND @SubClave  NOT IN('DIN.CMULTIMONEDA')OR (@MovTipo = 'DIN.TC' AND @Accion = 'CANCELAR' AND @SubClave  NOT IN('DIN.TCMULTIMONEDA')))--Mejora 5669
        BEGIN
          IF @CajeroActual IS NOT NULL AND @OrigenTipo <>'POS' SELECT @Ok = 30430, @OkRef = @CajeroActual
        END ELSE
        BEGIN
          IF @CajeroActual IS NULL
            SELECT @Ok = 30440
          ELSE
          IF @CajeroActual <> @Cajero AND @OrigenTipo <>'POS'
            SELECT @Ok = 30430, @OkRef = @CajeroActual
        END
        IF @MovTipo = 'DIN.TC'
          IF (SELECT NULLIF(RTRIM(Cajero), '') FROM CtaDineroCajero WHERE Moneda = ''/*@MovMoneda*/ AND CtaDinero = @CtaDineroDestino) IS NULL
            SELECT @Ok = 30440
      END 
    END

    -- Verificar antes de Afectar
    IF /*(@Conexion = 0 OR @Accion = 'CANCELAR') AND */@Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spDineroVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, @BeneficiarioNombre,
                             @CtaDinero, @CtaDineroTipo, @CtaDineroDestino, @CtaDineroFactor, @CtaDineroTipoCambio, @CtaDineroMoneda, @CtaDineroDestinoMoneda, @CtaDineroDestinoTipo, @CtaEmpresa, @Cajero, @FormaPago, @Referencia,
                             @Importe, @Impuestos, @Saldo, @Corte, @CorteDestino, @Dias, @TasaDiaria, @Retencion, @CfgInversionIntereses, @InteresTipo, @Titulo, @TituloValor, @ValorOrigen,
                             @Contacto, @ContactoTipo, @ContactoEnviarA, 
			     @Directo, @ConDesglose, @CfgCajeros, @CfgSobregiros, @CfgFormaPagoRequerida, @CfgChequesDirectos, @CfgContX, @CfgContXGenerar, @OrigenTipo, @OrigenMovTipo, @Conexion, @SincroFinal, @Sucursal, 
	                     @Autorizacion, @Autorizar OUTPUT, @ChequeDevuelto, @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @EstacionTrabajo -- REQ12336 --MEJORA6013
	                     

      IF @Autorizar = 1 
        UPDATE Dinero SET Mensaje = @Ok WHERE ID = @ID

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR','GENERAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
    
    IF (@Generar = 1 OR @Utilizar = 1) AND @Ok IS NULL
    BEGIN
      EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
      IF @GenerarMovTipo IN ('DIN.CH', 'DIN.CHE') SELECT @GenerarSerie = @CtaDinero

      -- Generar Mov Nuevo
      IF @Accion = 'GENERAR' SELECT @GenerarEstatus = 'SINAFECTAR' ELSE SELECT @GenerarEstatus = 'CANCELADO' 
      EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
	  	        NULL, NULL, 
                        @Mov, @MovID, 0, 
                        @GenerarMov, @GenerarSerie, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
      BEGIN
        UPDATE Dinero SET Beneficiario = @Beneficiario, BeneficiarioNombre = @BeneficiarioNombre, ConDesglose = @ConDesglose, Directo = 0, Importe = @Saldo WHERE ID = @IDGenerar 
        IF @@ERROR <> 0 SELECT @Ok = 1

        IF @MovTipo = 'DIN.TI' AND @GenerarMovTipo IN ('DIN.D', 'DIN.DE')
          UPDATE Dinero SET CtaDinero = CtaDineroDestino, CtaDineroDestino = NULL WHERE ID = @IDGenerar 

        IF @GenerarMovTipo = 'DIN.RET'
          UPDATE Dinero SET CtaDinero = CtaDineroDestino, CtaDineroDestino = CtaDinero WHERE ID = @IDGenerar 

        IF @ConDesglose = 1 
        BEGIN --MEJORA5916
          INSERT DineroD (Sucursal,  ID,         Renglon, Aplica, AplicaID, Importe, FormaPago, Referencia) 
                   SELECT @Sucursal, @IDGenerar, Renglon, @Mov,   @MovID,   Importe, FormaPago, Referencia
                     FROM DineroD 
                    WHERE ID = @ID

--Se comenta esta parte porque estaba poniendo en el detalle el importe total a todas las partidas
  --        IF @MovTipo IN ('DIN.SCH') OR @MovTipo IN ('DIN.SD') --MEJORA5916
  --      BEGIN
  --          UPDATE DineroD
  --             SET Importe = ISNULL(d.Saldo,dd.Importe)
  --            FROM DineroD dd LEFT OUTER JOIN Dinero d
  --              ON d.Mov = dd.Aplica AND d.MovID = dd.AplicaID AND d.Empresa = @Empresa --BUG14781
  --           WHERE dd.ID = @IDGenerar    
  --        END     
                    
        END --MEJORA5916            
        ELSE
          INSERT DineroD (Sucursal,  ID,         Renglon, Aplica, AplicaID, Importe) 
                  VALUES (@Sucursal, @IDGenerar,  2048.0, @Mov,   @MovID,   @Saldo)

        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Si va a Utilizar el Movimiento 
    IF @Utilizar = 1 AND @Ok IS NULL
    BEGIN
      SELECT @Estatus =  'SINAFECTAR'
      SELECT @UtilizarID = @ID, @UtilizarMov = @Mov, @UtilizarMovID = @MovID, @UtilizarMovTipo = @MovTipo,
	     @ID = @IDGenerar, @Mov = @GenerarMov, @MovID = @GenerarMovID, @GenerarMov = NULL, 
             @ConDesglose = 1, @Directo = 0

      -- Leer MovTipo, Periodo y Ejercicio	
      EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
    END

    IF @Accion IN ('AFECTAR','CONSECUTIVO','SINCRO','CANCELAR') AND @Ok IS NULL
      EXEC spDineroAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @FechaAfectacion, @FechaConclusion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                           @CtaDinero, @CtaDineroTipo, @CtaDineroDestino, @CtaDineroFactor, @CtaDineroTipoCambio, @CtaDineroMoneda, @CtaDineroDestinoMoneda, @TipoCambioDestino, @Cajero, @FormaPago, @IVAFiscal, @IEPSFiscal,
                           @Importe, @Impuestos, @Saldo, @Dias, @TasaDiaria, @Retencion, @CfgInversionIntereses, @InteresTipo, @Titulo, @TituloValor, @ValorOrigen,
			   @Contacto, @ContactoTipo, @ContactoEnviarA,
                           @Directo, @ConDesglose, @AutoConciliar,
		           @OrigenTipo, @OrigenMov, @OrigenMovID, @OrigenMovTipo, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, 
			   @GenerarGasto, @CfgCajeros, @CfgAutoFaltanteSobrante, @CfgSobregiros, @CfgAfectarComision, @CfgAfectarComisionIVA, @CfgContX, @CfgContXGenerar, @CfgEmbarcar, @GenerarPoliza, 
		   	   @Utilizar, @UtilizarID, @UtilizarMov, @UtilizarMovTipo, @UtilizarMovID,
                           @Generar, @GenerarMov, @GenerarAfectado, @GenerarAfectando, @GenerarCopia, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, 
                           @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @EstacionTrabajo -- REQ12336

    IF (@Utilizar = 1 OR @Generar = 1) AND @Ok IS NULL
    BEGIN
      IF @Utilizar = 1 EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @UtilizarID, @UtilizarMov, @UtilizarMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      IF @Generar  = 1 EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGenerar, @GenerarMov, @GenerarMovID, @Ok OUTPUT

      -- Avisar Movimiento generado
      IF @Accion <> 'CANCELAR' AND @Ok IS NULL
        SELECT @Ok = 80030, @OkRef = NULL
    END

  END ELSE 
    IF @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR','POSFECHADO') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus


  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 
  BEGIN

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
    BEGIN
      IF @Utilizar = 1 SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)        + ' ' +LTRIM(Convert(Char, @MovID))
      IF @Generar  = 1 SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov) + ' ' +LTRIM(Convert(Char, @GenerarMovID))
    END

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL
  END
  RETURN
END
GO


/**************** spGenerarDineroDesglose ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarDineroDesglose') and type = 'P') drop procedure dbo.spGenerarDineroDesglose
GO
CREATE PROCEDURE spGenerarDineroDesglose
			@Sucursal		int,
                        @Modulo			char(5),
			@ID			int, 
			@DineroID		int,
		   	@CtaDinero		char(10),
		   	@BeneficiarioEspecifico	varchar(100),
			@CfgFormaPagoCambio	varchar(50),
			@Ok			int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
   @Renglon	float,
   @FormaCobro1	varchar(50),
   @FormaCobro2 varchar(50),
   @FormaCobro3 varchar(50),   @FormaCobro4 varchar(50),
   @FormaCobro5 varchar(50),
   @Importe1	money,
   @Importe2	money,
   @Importe3	money,
   @Importe4	money,
   @Importe5	money,
   @Referencia1	varchar(50),
   @Referencia2	varchar(50),
   @Referencia3	varchar(50),
   @Referencia4	varchar(50),
   @Referencia5	varchar(50),
   @Cambio	money

  SELECT @Renglon = 0

  IF @Modulo = 'NOM'
  BEGIN
    INSERT DineroD (Sucursal,  ID,        Renglon, Importe,      FormaPago, Referencia)  
             SELECT @Sucursal, @DineroID, Renglon, ABS(Importe), FormaPago, Referencia
               FROM NominaD
              WHERE ID = @ID AND Cuenta = @CtaDinero AND Beneficiario = @BeneficiarioEspecifico
    RETURN
  END
  IF @Modulo = 'DIN' 
  BEGIN
    INSERT DineroD (Sucursal,  ID,        Renglon, Importe, FormaPago, Referencia)  
             SELECT @Sucursal, @DineroID, Renglon, Importe, FormaPago, Referencia
               FROM DineroD
              WHERE ID = @ID
    RETURN
  END

  IF @Modulo = 'CXC'
    SELECT @FormaCobro1 = FormaCobro1,           @FormaCobro2 = FormaCobro2,           @FormaCobro3 = FormaCobro3,           @FormaCobro4 = FormaCobro4,           @FormaCobro5 = FormaCobro5,
           @Importe1    = ISNULL(Importe1, 0.0), @Importe2    = ISNULL(Importe2, 0.0), @Importe3    = ISNULL(Importe3, 0.0), @Importe4    = ISNULL(Importe4, 0.0), @Importe5    = ISNULL(Importe5, 0.0),
 	   @Referencia1 = Referencia1,           @Referencia2 = Referencia2,           @Referencia3 = Referencia3,           @Referencia4 = Referencia4,           @Referencia5 = Referencia5,
           @Cambio      = ISNULL(Cambio, 0.0)
      FROM Cxc
     WHERE ID = @ID
  ELSE
  IF @Modulo = 'VTAS'
    SELECT @FormaCobro1 = FormaCobro1,           @FormaCobro2 = FormaCobro2,           @FormaCobro3 = FormaCobro3,           @FormaCobro4 = FormaCobro4,           @FormaCobro5 = FormaCobro5,
           @Importe1    = ISNULL(Importe1, 0.0), @Importe2    = ISNULL(Importe2, 0.0), @Importe3    = ISNULL(Importe3, 0.0), @Importe4    = ISNULL(Importe4, 0.0), @Importe5    = ISNULL(Importe5, 0.0),
 	   @Referencia1 = Referencia1,           @Referencia2 = Referencia2,           @Referencia3 = Referencia3,           @Referencia4 = Referencia4,           @Referencia5 = Referencia5,
           @Cambio      = ISNULL(Cambio, 0.0)
      FROM VentaCobro
     WHERE ID = @ID

  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @Importe1 <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, @Importe1, @FormaCobro1, @Referencia1) 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  IF @Importe2 <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, @Importe2, @FormaCobro2, @Referencia2) 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  IF @Importe3 <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, @Importe3, @FormaCobro3, @Referencia3) 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  IF @Importe4 <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, @Importe4, @FormaCobro4, @Referencia4) 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  IF @Importe5 <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, @Importe5, @FormaCobro5, @Referencia5) 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
  IF @Cambio <> 0.0 
  BEGIN
    SELECT @Renglon = @Renglon + 2048
    INSERT INTO DineroD (Sucursal, ID, Renglon, Importe, FormaPago, Referencia) VALUES (@Sucursal, @DineroID, @Renglon, -@Cambio, @CfgFormaPagoCambio, 'Cambio') 
    IF @@ERROR <> 0 SELECT @Ok = 1
  END 
END
GO

/**************** spGenerarDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarDinero') and type = 'P') drop procedure dbo.spGenerarDinero
GO
CREATE PROCEDURE spGenerarDinero
		   @Sucursal			int,
	           @SucursalOrigen		int, 
	           @SucursalDestino		int, 
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
    		   @FechaAfectacion    		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),

		   @ConDesglose			bit,
		   @GenerarSolicitud		bit,

    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @FormaPago			varchar(50),
		   @Tipo			char(20),
                   @Beneficiario		int,

		   @Cuenta			char(10), 
		   @CtaDinero			char(10),
		   @Cajero			char(10),
		   @Importe			money,
    		   @Impuestos			money,

		   @MovEspecifico		char(20),
		   @BeneficiarioEspecifico	varchar(100),
		   @Vencimiento			datetime,

    		   @DineroMov			char(20)	OUTPUT,
    		   @DineroMovID			varchar(20)	OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @ContactoEspecifico		char(10)	= NULL,
                   @IVAFiscal			float		= NULL,
                   @IEPSFiscal			float		= NULL,
                   @DesgloseManual		bit		= 0,
		   @OrigenTipo			char(10)	= NULL,
		   @ProveedorAutoEndoso		varchar(10)	= NULL,
		   @Nota			varchar(100)	= NULL,
		   @IgnorarFormaPago		bit		= 0,
		   @SeparacionDelIVA		bit		= 0,
		   @EstacionTrabajo				int = NULL -- REQ12336

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DineroID			int,
    @IDGenerar			int,
    @OID			int,
    @AplicaMov			char(20),
    @AplicaMovID		varchar(20),
    @CtaDineroTipo		char(20),
    @CfgMovDeposito		char(20),
    @CfgMovCheque		char(20),
    @CfgMovChequeTraspaso	char(20),
    @CfgMovSolicitudDeposito	char(20),
    @CfgMovSolicitudCheque	char(20),
    @CfgMovChequeDevuelto	char(20),
    @CfgMovCajaIngreso		char(20),
    @CfgMovCajaEgreso		char(20),
    @CfgTipoAfectacion		char(20),
    @CfgCargoBancario		char(20),
    @CfgCargoBancarioIVA	char(20),
    @CfgAbonoBancario		char(20),
    @CfgAbonoBancarioIVA	char(20),
    @CfgCreditoDA		char(20),
    @CfgEmpresaDinero		char(5),
    @CfgFormaPagoCambio		varchar(50),
    @CfgFormaPagoRequerida	bit,
    @ImporteTotal		money,
    @MovIngreso			char(20),
    @MovEgreso			char(20),
    @DineroEstatus		char(15),
    @DineroAccion		char(20),
    @Nombre			varchar(100),
    @BeneficiarioNombre		varchar(100),
    @LeyendaCheque		varchar(100),
    @DineroMovTipo		char(20),
    @GenerarDinero		bit,
    @FormasPagoRestringidas	bit,
    @Contacto			char(10),
    @ContactoTipo		varchar(20),
    @ContactoEnviarA		int,
    @OrigenID			int,
    @OrigenEstatus 		char(15), 
    @OrigenSucursal		int,
    @OrigenUEN			int,
    @Hoy			datetime,
    @DetalleNegativo		bit,
    @ArrastrarMovID		bit

  -- Inicializar
  SELECT @DineroID              = NULL,
         @Nombre             	= NULL,
         @BeneficiarioNombre 	= NULL, 
         @LeyendaCheque		= NULL,
         @MovIngreso         	= NULL,
         @MovEgreso          	= NULL,
         @CtaDineroTipo	     	= NULL,
         @DineroMov	     	= NULL,
         @DineroMovID        	= NULL,    
         @DineroEstatus		= 'SINAFECTAR',
         @DineroAccion		= @Accion,
	 @FormasPagoRestringidas = 1,
         @DetalleNegativo       = 0, 
         @Contacto		= NULL,
         @ContactoTipo		= NULL,
         @ContactoEnviarA	= NULL

  SELECT @CtaDinero = NULLIF(RTRIM(@CtaDinero), '')
  EXEC xpCuentaDineroNivelSucursal @Empresa, @Sucursal, @FormaPago, @CtaDinero OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Modulo = 'CXC'
    SELECT @Contacto = Cte.Cliente,
           @ContactoEnviarA = Cxc.ClienteEnviarA,
           @ContactoTipo = 'Cliente', 
           @FormasPagoRestringidas = Cte.FormasPagoRestringidas,
           @IVAFiscal = Cxc.IVAFiscal,
           @IEPSFiscal = Cxc.IEPSFiscal
      FROM Cxc, Cte
     WHERE Cxc.ID = @ID AND Cxc.Cliente = Cte.Cliente
  IF @Modulo = 'VTAS'
    SELECT @Contacto = Cte.Cliente,
           @ContactoTipo = 'Cliente', 
           @FormasPagoRestringidas = Cte.FormasPagoRestringidas,
           @IVAFiscal = Venta.IVAFiscal,
           @IEPSFiscal = Venta.IEPSFiscal
      FROM Venta, Cte
     WHERE Venta.ID = @ID AND Venta.Cliente = Cte.Cliente
  IF @Modulo = 'CXP'
    SELECT @Contacto = Proveedor,
           @ContactoTipo = 'Proveedor', 
           @IVAFiscal = IVAFiscal,
           @IEPSFiscal = IEPSFiscal
      FROM Cxp
     WHERE ID = @ID
  IF @Modulo = 'GAS'
    SELECT @Contacto = Acreedor,
           @ContactoTipo = 'Proveedor', 
           @IVAFiscal = IVAFiscal,
           @IEPSFiscal = IEPSFiscal
      FROM Gasto
     WHERE ID = @ID
  IF @Modulo = 'AF'
    SELECT @Contacto = Proveedor,
           @ContactoTipo = 'Proveedor'
      FROM ActivoFijo
     WHERE ID = @ID
  IF @Modulo = 'COMS'
    SELECT @Contacto = Proveedor,
           @ContactoTipo = 'Proveedor'
      FROM Compra
     WHERE ID = @ID
  IF @Modulo = 'CREDI'
    SELECT @Contacto = Acreedor,
           @ContactoTipo = 'Proveedor'
      FROM Credito
     WHERE ID = @ID
  IF @Modulo = 'AGENT'
    SELECT @Contacto = Agente,
           @ContactoTipo = 'Agente'
      FROM Agent
     WHERE ID = @ID
  IF @Modulo = 'NOM' 
  BEGIN
    IF @ContactoEspecifico IS NOT NULL
      SELECT @Contacto = @ContactoEspecifico,
             @ContactoTipo = 'Personal'
    ELSE BEGIN
      SELECT @Contacto = MIN(Proveedor) FROM Prov WHERE Nombre = @BeneficiarioEspecifico
      IF @Contacto IS NOT NULL SELECT @ContactoTipo = 'Proveedor'
    END
  END

  IF @Modulo = 'VALE'
    SELECT @Contacto = Cliente,
           @ContactoTipo = 'Cliente',
           @ImporteTotal = ISNULL(Importe, 0) -- Etoral, Toma importe           
      FROM Vale
     WHERE ID = @ID

  IF @Modulo = 'CR'
    SELECT @Contacto = Cajero,
           @ContactoTipo = 'Agente'
      FROM CR
     WHERE ID = @ID

  IF @Modulo = 'CAM' 
    SELECT @Contacto = Cliente,
           @ContactoTipo = 'Cliente', 
           @Referencia = LTRIM(CONVERT(char, @MovID)) 
      FROM Cambio
     WHERE ID = @ID

--  ELSE SELECT @Referencia = RTRIM(@Mov)+' '+LTRIM(CONVERT(char, @MovID))

  SELECT @CfgFormaPagoCambio      = FormaPagoCambio,
         @CfgFormaPagoRequerida   = FormaPagoRequerida
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgMovSolicitudDeposito = BancoSolicitudDeposito,
         @CfgMovDeposito	  = BancoDeposito,
         @CfgMovSolicitudCheque   = BancoSolicitudCheque,
         @CfgMovCheque		  = BancoCheque,
         @CfgMovChequeTraspaso    = BancoChequeTraspaso,
	 @CfgMovCajaIngreso       = CajaIngreso,
         @CfgMovCajaEgreso        = CajaEgreso,         
         @CfgMovChequeDevuelto    = CASE @Modulo
			             WHEN 'CXC' THEN NULLIF(RTRIM(BancoDepositoEnFalso), '')
  			  	     WHEN 'CXP' THEN NULLIF(RTRIM(BancoChequeDevuelto), '')
  				     ELSE NULL
  		         	   END,
         @CfgCargoBancario	 = BancoCargoBancario,
         @CfgCargoBancarioIVA    = BancoCargoBancarioIVA,
         @CfgAbonoBancario	 = BancoAbonoBancario,
         @CfgAbonoBancarioIVA	 = BancoAbonoBancarioIVA,
         @CfgCreditoDA	         = CreditoDepositoAnticipado
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @CtaDineroTipo = ISNULL(UPPER(Tipo), 'BANCO') FROM CtaDinero WHERE CtaDinero = @CtaDinero

  SELECT @CfgEmpresaDinero  = UPPER(NULLIF(RTRIM(EmpresaDinero), ''))
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @CfgEmpresaDinero <> 'MISMA' AND @CfgEmpresaDinero <> 'MISMO' AND @CfgEmpresaDinero IS NOT NULL
    SELECT @Empresa = @CfgEmpresaDinero

  IF @IgnorarFormaPago = 0 AND @CtaDinero IS NOT NULL AND @FormaPago IS NOT NULL --AND @CtaDineroTipo <> 'CAJA' AND @MovTipo NOT IN ('DIN.C', 'DIN.CP')/*AND @GenerarSolicitud = 0*/
    SELECT @MovIngreso = NULLIF(RTRIM(MovIngresos), ''),
           @MovEgreso  = NULLIF(RTRIM(MovEgresos), '')
      FROM FormaPago
     WHERE FormaPago = @FormaPago

  IF @MovIngreso IS NULL 
    SELECT @MovIngreso = CASE @CtaDineroTipo
		           WHEN 'CAJA' THEN @CfgMovCajaIngreso
  	    	           ELSE @CfgMovSolicitudDeposito
		         END
  IF @MovEgreso IS NULL 
    SELECT @MovEgreso  = CASE @CtaDineroTipo
     	                   WHEN 'CAJA' THEN @CfgMovCajaEgreso
		           ELSE @CfgMovSolicitudCheque
  		         END
  IF @MovTipo IN ('VTAS.N','VTAS.FM','VTAS.F','VTAS.FAR','VTAS.FB','VTAS.P','VTAS.S') 
  BEGIN
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovIngreso 
    ELSE 
    BEGIN
      SELECT @DineroMov = @MovEgreso, @Importe = -@Importe, @ConDesglose = 0
      IF @Cuenta IS NOT NULL 
        SELECT @BeneficiarioNombre = NULLIF(RTRIM(Nombre), '') FROM Cte WHERE Cliente = @Cuenta 
    END
  END ELSE
  IF @MovTipo IN ('VTAS.VP', 'VTAS.SD', 'VTAS.B', 'VTAS.D', 'VTAS.DF')
  BEGIN 
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovEgreso 
    ELSE
      SELECT @DineroMov = @MovIngreso, @Importe = -@Importe, @DetalleNegativo = 1
  END ELSE
  IF @MovTipo = 'DIN.TI'
    SELECT @DineroMov = @CfgMovChequeTraspaso, @ContactoTipo = 'Empresa', @Contacto = @Empresa, @BeneficiarioNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
  ELSE
  IF @MovTipo IN ('DIN.C', 'DIN.CP')
  BEGIN 
    IF @OrigenTipo = 'CR'
      SELECT @MovIngreso = @CfgMovDeposito, @MovEgreso = @CfgMovCheque

    IF @Importe > 0.0 
      SELECT @DineroMov = @MovIngreso
    ELSE
      SELECT @DineroMov = @MovEgreso, @Importe = -@Importe, @DetalleNegativo = 1
  END ELSE
  IF @MovTipo IN ('CXC.C','CXC.DP','CXC.NCP','CXC.ANC','CXC.A','CXC.AA','CXC.AR','CXP.CAP','CXP.C','CXP.DE','CXP.DC','GAS.DA','GAS.DC','GAS.OI','AGENT.CO') SELECT @DineroMov = @MovIngreso ELSE
  IF @MovTipo IN ('CXP.P','CXP.DP','CXP.NCP','CXP.ANC','CXP.A','CXP.AA','CXC.CAP','CXC.DE','CXC.DFA','CXC.DI','CXC.DC','AGENT.P','AGENT.A','GAS.A','GAS.C','GAS.CCH','GAS.CP','AF.RE','AF.MA', 'AF.PS', 'AF.PM') 
  BEGIN
    SELECT @DineroMov = @MovEgreso
    IF @Cuenta IS NOT NULL
    BEGIN
      IF @Modulo = 'CXC' 
      BEGIN
        SELECT @BeneficiarioNombre = NULLIF(RTRIM(Nombre), '') FROM Cte  WHERE Cliente   = @Cuenta 
        IF (SELECT CxcEnviarABeneficiario FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
          SELECT @BeneficiarioNombre = NULLIF(RTRIM(Nombre), '') FROM CteEnviarA WHERE Cliente = @Contacto AND ID = @ContactoEnviarA
      END ELSE
      IF @Modulo IN ('CXP','GAS', 'AF') SELECT @Nombre = NULLIF(RTRIM(Nombre), ''), @BeneficiarioNombre = NULLIF(RTRIM(BeneficiarioNombre), ''), @LeyendaCheque = NULLIF(RTRIM(LeyendaCheque), '') FROM Prov WHERE Proveedor = @Cuenta 
      IF @Modulo = 'AGENT' SELECT @Nombre = NULLIF(RTRIM(Nombre), ''), @BeneficiarioNombre = NULLIF(RTRIM(BeneficiarioNombre), '') FROM Agente WHERE Agente = @Cuenta 
      IF @BeneficiarioNombre IS NULL SELECT @BeneficiarioNombre = @Nombre
    END
  END ELSE
  IF @MovTipo IN ('GAS.CB', 'GAS.AB')
  BEGIN
    SELECT @DineroMovID = @MovID
    IF @SeparacionDelIVA = 0
    BEGIN
      IF @MovTipo = 'GAS.CB' SELECT @DineroMov = @Mov ELSE
      IF @MovTipo = 'GAS.AB' SELECT @DineroMov = @Mov
    END ELSE 
    BEGIN
      IF @MovTipo = 'GAS.CB' SELECT @DineroMov = @CfgCargoBancarioIVA ELSE
      IF @MovTipo = 'GAS.AB' SELECT @DineroMov = @CfgAbonoBancarioIVA
    END
    IF EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'DIN' AND Mov=@DineroMov AND GenerarGasto = 1)
      SELECT @Ok = 70140, @OkRef = @DineroMov
  END ELSE
  IF @MovTipo IN ('CXC.CD','CXP.CD') 
    SELECT @DineroMov = @CfgMovChequeDevuelto
  ELSE
  IF @MovTipo IN ('AC.SE', 'AC.C')
  BEGIN
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovIngreso
    ELSE
      SELECT @DineroMov = @MovEgreso, @Importe = -@Importe, @DetalleNegativo = 1
  END ELSE
  IF @MovTipo IN ('AC.D', 'AC.R')
  BEGIN
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovEgreso
    ELSE
      SELECT @DineroMov = @MovIngreso, @Importe = -@Importe, @DetalleNegativo = 1
  END ELSE
  IF @MovTipo IN ('CAM.O', 'CAM.V', 'CAM.S')
  BEGIN
    IF @MovTipo = 'CAM.V' AND UPPER(@Tipo) IN ('COMPRA', 'COBRO')
    BEGIN
      SELECT @DineroMov = @MovIngreso
    END ELSE
    BEGIN
      SELECT @DineroMov = @MovEgreso
      SELECT @BeneficiarioNombre = NULLIF(RTRIM(Nombre), '') FROM Beneficiario WHERE Beneficiario = @Beneficiario
      IF @BeneficiarioNombre IS NULL SELECT @BeneficiarioNombre = '.'
    END
  END ELSE 
  IF @MovTipo IN ('VALE.A', 'VALE.AT') 	-- ETO Tarjetas 9-Feb-2007
  BEGIN -- Etoral
    SELECT @DineroMov = @MovEgreso, @BeneficiarioNombre = RTRIM(@Mov)+' '+RTRIM(@MovID)
-- Considera si Aplicacion Tarjeta es negativo, genera ingreso
    IF @MovTipo = 'VALE.AT' AND ISNULL(@ImporteTotal, 0) < 0
      SELECT @DineroMov = @MovIngreso
  END
  ELSE
  IF @MovTipo = 'NOM.DP'
  BEGIN
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovIngreso
    ELSE
      SELECT @DineroMov = @MovEgreso, 
             @BeneficiarioNombre = @BeneficiarioEspecifico,
             @Importe = -@Importe 
  END ELSE
  IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NC')
  BEGIN
    IF @Importe > 0.0 
      SELECT @DineroMov = @MovEgreso, 
             @DineroMov = ISNULL(NULLIF(RTRIM(@MovEspecifico), ''), @MovEgreso),
             @BeneficiarioNombre = @BeneficiarioEspecifico
    ELSE
      SELECT @DineroMov = @MovIngreso, @Importe = -@Importe 
  END ELSE
  IF @MovTipo = 'CREDI.DA'
    SELECT @DineroMov = @CfgCreditoDA
  ELSE IF @MovTipo = 'NOM.PI'
    SELECT @DineroMov = @MovEgreso, @BeneficiarioNombre = @BeneficiarioEspecifico
  ELSE 
    IF @MovEspecifico IS NOT NULL SELECT @DineroMov = @MovEspecifico
  ELSE SELECT @Ok = 70020

  IF EXISTS(SELECT * FROM EmpresaCfgMovGenera WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND GeneraModulo = 'DIN')
  BEGIN
    SELECT @DineroMov = GeneraMov, @ArrastrarMovID = ArrastrarMovID FROM EmpresaCfgMovGenera WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov AND GeneraModulo = 'DIN'
    IF @ArrastrarMovID = 1 SELECT @DineroMovID = @MovID
  END

  IF @DineroMov IS NULL SELECT @Ok = 70020
  SELECT @DineroMovTipo = Clave FROM MovTipo WHERE Modulo = 'DIN' AND Mov = @DineroMov

--  IF @CfgFormaPagoRequerida = 1 AND @DineroMovTipo IN ('DIN.A', 'DIN.AP', 'DIN.I', 'DIN.E', 'DIN.F', 'DIN.TC', 'DIN.CP', 'DIN.C') AND NULLIF(RTRIM(@FormaPago), '') IS NULL SELECT @Ok = 30530

  IF @Ok IS NOT NULL RETURN

  IF @Accion = 'CANCELAR' SELECT @GenerarDinero = 0 ELSE SELECT @GenerarDinero = 1
  IF @Modulo = 'CXC'  UPDATE Cxc   SET GenerarDinero = @GenerarDinero WHERE ID = @ID ELSE
  IF @Modulo = 'CXP'  UPDATE Cxp   SET GenerarDinero = @GenerarDinero WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'  UPDATE Gasto SET GenerarDinero = @GenerarDinero WHERE ID = @ID ELSE
  IF @Modulo = 'VTAS' UPDATE Venta SET GenerarDinero = @GenerarDinero WHERE ID = @ID 


  IF @Accion = 'CANCELAR' OR @Tipo = 'APLICA_POSFECHADO'
  BEGIN
    SELECT @OID = NULL
    IF @Tipo = 'APLICA_POSFECHADO'
    BEGIN 
      IF @MovTipo IN ('CXC.ANC','CXP.ANC')
      BEGIN
        IF @Modulo = 'CXC' SELECT @OID = c.ID, @AplicaMov = c.Mov, @AplicaMovID = c.MovID FROM Cxc d, Cxc c WHERE d.ID = @ID AND d.MovAplica = c.Mov AND d.MovAplicaID = c.MovID AND c.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'CANCELADO') AND c.Empresa = @Empresa ELSE
        IF @Modulo = 'CXP' SELECT @OID = c.ID, @AplicaMov = c.Mov, @AplicaMovID = c.MovID FROM Cxp d, Cxp c WHERE d.ID = @ID AND d.MovAplica = c.Mov AND d.MovAplicaID = c.MovID AND c.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'CANCELADO') AND c.Empresa = @Empresa 
      END ELSE
      BEGIN
        IF @Modulo = 'CXC' SELECT @OID = c.ID, @AplicaMov = d.Aplica, @AplicaMovID = d.AplicaID FROM CxcD d, Cxc c WHERE d.ID = @ID AND d.Aplica = c.Mov AND d.AplicaID = c.MovID AND c.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'CANCELADO') AND c.Empresa = @Empresa ELSE
        IF @Modulo = 'CXP' SELECT @OID = c.ID, @AplicaMov = d.Aplica, @AplicaMovID = d.AplicaID FROM CxpD d, Cxp c WHERE d.ID = @ID AND d.Aplica = c.Mov AND d.AplicaID = c.MovID AND c.Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'CANCELADO') AND c.Empresa = @Empresa 
      END
    END ELSE 
      SELECT @OID = @ID  

    IF @OID IS NULL SELECT @Ok = 60220

    SELECT @DineroID = DID, @DineroMov = DMov, @DineroMovID = DMovID 
      FROM MovFlujo 
     WHERE Cancelado = 0 
       AND Empresa = @Empresa 
       AND OModulo = @Modulo 
       AND OID     = @OID
       AND DModulo = 'DIN'
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @DineroID IS NULL 
    BEGIN
      IF @Accion = 'CANCELAR' SELECT @Ok = 60060 ELSE SELECT @Ok = 60065
      SELECT @OkRef = RTRIM(@DineroMov)+' '+LTRIM(Convert(Char, @DineroMovID))

      IF @Accion = 'CANCELAR' AND @Ok = 60060 AND @MovTipo = 'CXP.P' --BUG8660
      BEGIN
        IF EXISTS(SELECT MovFlujo.* 
                    FROM MovFlujo
                    JOIN MovTipo ON DMov = Mov AND Modulo = @Modulo
                   WHERE Cancelado = 0
                     AND Empresa = @Empresa 
                     AND DModulo = @Modulo
                     AND OModulo = @Modulo
                     AND OID     = @ID
                     AND Clave   = 'CXP.NCF')
          SELECT @Ok = NULL, @OkRef = NULL      
      END
    END ELSE
    BEGIN
      IF @Tipo = 'APLICA_POSFECHADO' AND @Accion <> 'CANCELAR' 
      BEGIN
        SELECT @Hoy = GETDATE()
        EXEC spExtraerFecha @Hoy OUTPUT
        UPDATE Dinero SET FechaEmision = @Hoy WHERE ID = @DineroID AND Estatus = 'POSFECHADO'
      END
    END
  END ELSE
  BEGIN  
    SELECT @DineroAccion = 'AFECTAR'
    IF @Modulo NOT IN ('DIN', 'NOM') AND @MovTipo NOT IN ('CXC.C', 'CXC.DE','CXC.DFA','CXC.A','CXC.AA','CXC.AR','CXC.CAP','VTAS.N','VTAS.FM','VTAS.F','VTAS.FAR','VTAS.FB','VTAS.P','VTAS.S') SELECT @ConDesglose = 0

    IF @MovTipo IN ('CXC.DP','CXC.NCP','CXP.DP','CXP.NCP')
    BEGIN
      SELECT @DineroEstatus = 'POSFECHADO'
      IF @DineroAccion = 'AFECTAR' SELECT @DineroAccion = 'CONSECUTIVO'
    END
    SELECT @ImporteTotal = @Importe + ISNULL(@Impuestos, 0.0)

    SELECT @OrigenID = dbo.fnModuloID(@Empresa, @Modulo, @Mov, @MovID, @Ejercicio, @Periodo)
    /*SELECT @OrigenEstatus = Estatus, @OrigenSucursal = Sucursal, @OrigenUEN = UEN
      FROM dbo.fnMovReg(@Modulo, @OrigenID)*/
    EXEC spMovInfo NULL, @Modulo, @Mov, @MovID, @OrigenEstatus OUTPUT, @OrigenSucursal OUTPUT, @OrigenUEN OUTPUT, @Empresa = @Empresa

    INSERT Dinero (Sucursal,  SucursalOrigen,  SucursalDestino,  Empresa,  Mov,        MovID,        FechaEmision,     Concepto,  Proyecto,  Moneda,     TipoCambio,     Usuario,  Autorizacion,  Referencia,  DocFuente,  Observaciones,  Estatus,        CtaDinero,  Cajero,  Importe,  Impuestos,  BeneficiarioNombre,  LeyendaCheque,  Beneficiario,  ConDesglose,  FormaPago,  OrigenTipo, Origen, OrigenID, UEN,        FechaProgramada, IVAFiscal,  IEPSFiscal,  Contacto,  ContactoTipo,  ContactoEnviarA,  ProveedorAutoEndoso,  Nota)
           VALUES (@Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @DineroMov, @DineroMovID, @FechaAfectacion, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @DineroEstatus, @CtaDinero, @Cajero, @Importe, @Impuestos, @BeneficiarioNombre, @LeyendaCheque, @Beneficiario, 1,            @FormaPago, @Modulo,    @Mov,   @MovID,   @OrigenUEN, @Vencimiento,    @IVAFiscal, @IEPSFiscal, @Contacto, @ContactoTipo, @ContactoEnviarA, @ProveedorAutoEndoso, @Nota)
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @DineroID = SCOPE_IDENTITY()

    IF @ConDesglose = 0 OR @DesgloseManual = 1
      INSERT DineroD (Sucursal,  ID,        Renglon, Importe,  FormaPago,  Referencia) 
              VALUES (@Sucursal, @DineroID, 2048,    @ImporteTotal, @FormaPago, @Referencia) 
    ELSE
      EXEC spGenerarDineroDesglose @Sucursal, @Modulo, @ID, @DineroID, @CtaDinero, @BeneficiarioEspecifico, @CfgFormaPagoCambio, @Ok OUTPUT

    IF @DetalleNegativo = 1
      UPDATE DineroD SET Importe = -Importe WHERE ID = @DineroID

    IF @FormasPagoRestringidas = 0
    BEGIN 
      SELECT @OkRef = NULL 
      SELECT @OkRef = MIN(fp.FormaPago) 
        FROM DineroD d
        LEFT OUTER JOIN FormaPago fp ON d.FormaPago = fp.FormaPago AND fp.Restringida = 1
        WHERE d.ID = @DineroID
      IF @OkRef IS NOT NULL
        SELECT @Ok = 30580
      ELSE
        SELECT @OkRef = NULL
    END

    -- Copiar Anexos
    EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, 'DIN', @DineroID
  END

  IF @Ok IS NULL AND @DineroID IS NOT NULL
    EXEC xpGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, 
                         @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaAfectacion,
                         @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                         @ConDesglose, @GenerarSolicitud, @FechaRegistro, @Ejercicio, @Periodo, @FormaPago, @Tipo,
                         @Beneficiario, @Cuenta, @CtaDinero, @Cajero, @Importe, @Impuestos, @MovEspecifico, @BeneficiarioEspecifico,
                         @Vencimiento, @DineroMov, @DineroMovID, @Ok OUTPUT, @OkRef OUTPUT, @DineroID

  IF @Ok IS NULL AND @DineroID IS NOT NULL
    EXEC spDinero @DineroID, 'DIN', @DineroAccion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @DineroMov OUTPUT, @DineroMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @EstacionTrabajo = @EstacionTrabajo -- REQ12336		   
  IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

  -- Registrar el Flujo    
  EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT

  IF @Accion = 'CANCELAR' AND @Tipo = 'APLICA_POSFECHADO'
  BEGIN
    EXEC spValidarTareas @Empresa, @Modulo, @DineroID, 'POSFECHADO', @Ok OUTPUT, @OkRef OUTPUT
    UPDATE Dinero SET Estatus = 'POSFECHADO', FechaCancelacion = NULL, Saldo = NULL WHERE ID = @DineroID
    UPDATE MovFlujo SET Cancelado = 0 WHERE Empresa = @Empresa AND OModulo = @Modulo AND OID  = @OID AND DModulo = 'DIN' AND DID = @DineroID
   /* EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @OID, @AplicaMov, @AplicaMovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT*/
  END

  IF @DineroMovTipo IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.I', 'DIN.E') AND @Ok IS NULL 
    EXEC spDineroRelacionar @Empresa, @Accion, 'DIN', @DineroID, @DineroMov, @DineroMovID, @CtaDinero

  -- Avisar Movimiento Generado
  IF @Modulo NOT IN ('CAM','VTAS') AND @Accion <> 'CANCELAR' AND @Tipo <> 'APLICA_POSFECHADO' AND @Ok IS NULL 
    SELECT @Ok = 80030, @OkRef = 'Movimiento: '+RTRIM(@DineroMov)+' '+LTRIM(Convert(Char, @DineroMovID))

  RETURN @DineroID
END
GO

/**************** spLiberarDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLiberarDinero') and type = 'P') drop procedure dbo.spLiberarDinero
GO
CREATE PROCEDURE spLiberarDinero
			@Empresa	char(5),
			@Usuario	char(10),
			@Sucursal	int,
			@CtaDinero	char(10),
			@GenerarMov	char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo		int,
    @ID			int,
    @IDGenerar		int,
    @Mov		char(20),
    @MovID		varchar(20),
    @FechaRegistro	datetime,
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL, @Conteo = 0
  DECLARE crLiberarDinero CURSOR FOR 
   SELECT d.ID, d.Mov, d.MovID
     FROM Dinero d
    WHERE d.Empresa = @Empresa AND d.CtaDinero = @CtaDinero AND d.Estatus = 'PENDIENTE' AND d.Liberar = 1
      AND NOT EXISTS(SELECT * FROM Dinero WHERE Empresa = @Empresa AND OrigenTipo = 'DIN' AND Origen = d.Mov AND OrigenID = d.MovID AND Estatus = 'BORRADOR')

  OPEN crLiberarDinero
  FETCH NEXT FROM crLiberarDinero INTO @ID, @Mov, @MovID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spDinero @ID, 'DIN', 'GENERAR', 'TODO', @FechaRegistro, @GenerarMov, @Usuario, 0, 0, 
                    @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                    @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok = 80030 AND @IDGenerar IS NOT NULL
      BEGIN       
        SELECT @Ok = NULL, @OkRef = NULL
        EXEC spDinero @IDGenerar, 'DIN', 'CONSECUTIVO', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, 
                      @GenerarMov, NULL, NULL, 
                      @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IN (80060, NULL)
        BEGIN
          EXEC spValidarTareas @Empresa, 'DIN', @IDGenerar, 'BORRADOR', @Ok OUTPUT, @OkRef OUTPUT
          UPDATE Dinero SET Estatus = 'BORRADOR' WHERE ID = @IDGenerar
          SELECT @Ok = NULL, @OkRef = NULL, @Conteo = @Conteo + 1         
        END ELSE BEGIN
          UPDATE Dinero SET Liberar = 0 WHERE ID = @ID
          DELETE Dinero  WHERE ID = @IDGenerar
          DELETE DineroD WHERE ID = @IDGenerar
        END
      END

    END -- Fetch_Status <> 2
    FETCH NEXT FROM crLiberarDinero INTO @ID, @Mov, @MovID
  END -- While
  CLOSE crLiberarDinero
  DEALLOCATE crLiberarDinero

  IF @Ok IS NULL 
    SELECT @Mensaje = LTRIM(CONVERT(char, @Conteo))+' Solicitudes Liberadas.'
  ELSE
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

  SELECT "Mensaje" = @Mensaje

  RETURN
END
GO
-- spLiberarDinero 'DEMO', 'DEMO', 0, 'BITAL', 'Cheque'



/*

en el caso de la tasa fija, se generan intereses ganados 
y en el caso de titulo se reevalua la inversion
*/

/**************** spDineroGenerarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDineroGenerarIntereses') and type = 'P') drop procedure dbo.spDineroGenerarIntereses
GO
CREATE PROCEDURE spDineroGenerarIntereses
		   @Sucursal		int,
                   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaD		datetime,
		   @FechaA		datetime,
                   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRegistro   		datetime,
    @Conteo	     		int,
    @Hoy	     		datetime,
    @InteresesMov		varchar(20),
    @ReevaluacionMov		varchar(20),
    @DineroID			int,
    @DineroMov	     		varchar(20),
    @DineroMovID		varchar(20),
    @ConDesglose		bit,
    @ID				int,
    @Mov			varchar(20), 
    @MovID			varchar(20), 
    @Saldo			money, 
    @Importe			money,
    @InteresTipo		varchar(20),
    @Titulo			varchar(10),
    @TasaDiaria			float,
    @TituloValor		float,
    @ValorOrigen		float,
    @Referencia			varchar(50),
    @CfgInversionIntereses	varchar(20)
  
  SELECT @InteresesMov = BancoIntereses,
         @ReevaluacionMov = DineroReevaluacionTitulo
    FROM EmpresaCfgMov 
   WHERE Empresa = @Empresa

  SELECT @ConDesglose           = DineroDesgloseObligatorio,
         @CfgInversionIntereses = UPPER(DineroInversionIntereses)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @CfgInversionIntereses <> 'CIERRE DIARIO' RETURN

  SELECT @Conteo = 0  
  EXEC spExtraerFecha @FechaD OUTPUT
  EXEC spExtraerFecha @FechaA OUTPUT
  SELECT @FechaRegistro = GETDATE() 

  SELECT @Hoy = @FechaD
  WHILE @Hoy < @FechaA
  BEGIN
    DECLARE crInversionPendiente CURSOR FOR 
     SELECT d.ID, d.Mov, d.MovID, ISNULL(d.Saldo, 0.0), d.Tasa / NULLIF(d.TasaDias, 0), UPPER(d.InteresTipo), d.Titulo, d.TituloValor, t.Valor
       FROM Dinero d
       LEFT OUTER JOIN Titulo t ON t.Titulo = d.Titulo
       JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov AND mt.Clave = 'DIN.INV'
      WHERE d.Empresa = @Empresa AND d.Estatus = 'PENDIENTE'

    OPEN crInversionPendiente
    FETCH NEXT FROM crInversionPendiente INTO @ID, @Mov, @MovID, @Saldo, @TasaDiaria, @InteresTipo, @Titulo, @ValorOrigen, @TituloValor
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Saldo <> 0.0 AND @Ok IS NULL
      BEGIN
        SELECT @Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID), @Importe = 0.0

        IF @InteresTipo = 'TASA FIJA'
          SELECT @DineroMov = @InteresesMov, 
                 @Importe = (ISNULL(@Saldo * (@TasaDiaria/100.0), 0.0)),
                 @Titulo = NULL, @ValorOrigen = NULL, @TituloValor = NULL
        ELSE 
        IF @InteresTipo = 'TITULO'
          SELECT @DineroMov = @ReevaluacionMov, 
                 @Importe = (@Saldo * ((@TituloValor/@ValorOrigen)-1.0))

        INSERT Dinero (
               Sucursal, SucursalOrigen, Empresa, Mov,  FechaEmision,  Concepto, Proyecto, UEN, Moneda, TipoCambio, Usuario,  Referencia,  Estatus,      CtaDinero, CtaDineroDestino, Importe,  ConDesglose,  FormaPago, Titulo,  TituloValor,  ValorOrigen)
        SELECT Sucursal, Sucursal,       Empresa, @DineroMov, @Hoy,          Concepto, Proyecto, UEN, Moneda, TipoCambio, @Usuario, @Referencia, 'SINAFECTAR', CtaDinero, CtaDineroDestino, @Importe, @ConDesglose, FormaPago, @Titulo, @TituloValor, @ValorOrigen
          FROM Dinero
         WHERE ID = @ID
        IF @@ERROR <> 0 SELECT @Ok = 1

        SELECT @DineroID = SCOPE_IDENTITY()
  
        IF @ConDesglose = 1
          INSERT DineroD (
                 Sucursal,  ID,        Renglon, Importe) 
          SELECT @Sucursal, @DineroID, 2048,    @Importe
        EXEC spAfectar 'DIN', @DineroID, @Usuario = @Usuario, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      END 
      FETCH NEXT FROM crInversionPendiente INTO @ID, @Mov, @MovID, @Saldo, @TasaDiaria, @InteresTipo, @Titulo, @ValorOrigen, @TituloValor
    END -- While
    CLOSE crInversionPendiente
    DEALLOCATE crInversionPendiente

    SELECT @Hoy = DATEADD(day, 1, @Hoy)
  END
  RETURN
END
GO

GO
PRINT "******************* SP DINERO ******************"


