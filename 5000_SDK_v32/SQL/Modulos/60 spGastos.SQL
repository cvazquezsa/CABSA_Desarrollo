/* SP GASTOS    */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
GO

-- GAS.S   = Solicitud
-- GAS.A   = Anticipo
-- GAS.ASC = Anticipo S/Comprobar
-- GAS.C   = Comprobante
-- GAS.CCH = Caja Chica
-- GAS.DC  = Dev. Comprobante
-- GAS.DA  = Devolucion Anticipo
-- GAS.G   = Gasto
-- GAS.GC  = Gasto Cliente
-- GAS.GTC = Gasto T/Credito
-- GAS.GR  = Gasto Recurrente
-- GAS.CTO = Contrato
-- GAS.GP  = Gasto Prorrateado
-- GAS.CP  = Comprobante Prorrateado
-- GAS.DG  = Devolucion Gasto
-- GAS.DGP = Devolucion Prorrateado
-- GAS.OI  = Otros Ingresos
-- GAS.PR  = Presupuesto
-- GAS.PRP = Presup. Prorrateado
-- GAS.DPR = Disminucion Presupuesto

-- select * from  movtipo where modulo ='gas'gasto
-- spafectar 'gas', 35, 'verificar'
-- spborrarmovimientos


/**************** spGastoVerificarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoVerificarDetalle') and type = 'P') drop procedure dbo.spGastoVerificarDetalle
GO             
CREATE PROCEDURE spGastoVerificarDetalle
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
      @Renglon					float,
      @RenglonSub				int,
      @Concepto					varchar(20),
      @CantidadNueva				int,
      @Precio					money,
      @Importe					money,
      @Impuestos				money,
      @ConceptoInventariable			bit,  
      @CantidadMinima				int,
      @CantidadMax				int,
      @Cantidad					int,
      @EsInventariable				bit,
      @Factor					int,
      @Retencion		money,
      @CfgImpuesto2Info		bit,
      @CfgImpuesto3Info		bit,
      @TipoRetencion1		varchar(10),
      @TipoRetencion2		varchar(10),
      @TipoRetencion3		varchar(10),
      @ImporteRet		money

  SELECT @ConceptoInventariable = GastoConceptosInventariables
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @CfgImpuesto2Info = ISNULL(Impuesto2Info, 0),
         @CfgImpuesto3Info = ISNULL(Impuesto2Info, 0)
    FROM Version

  SELECT @Factor = Factor FROM MovTipo WHERE Mov = @Mov AND Clave = @MovTipo AND Modulo = @Modulo

  DECLARE crVerificar CURSOR  FOR
   SELECT g.Renglon , g.RenglonSub,  g.Concepto, g.Cantidad, g.Precio, ISNULL(g.Importe,0), 
          ISNULL(g.Impuestos, 0)+ISNULL(CASE WHEN @CfgImpuesto2Info = 1 THEN 0.0 ELSE g.Impuestos2 END, 0)+ISNULL(CASE WHEN @CfgImpuesto3Info = 1 THEN 0.0 ELSE g.Impuestos3 END, 0), 
          ISNULL(c.EsInventariable,0), ISNULL(g.Retencion, 0)+ISNULL(g.Retencion2, 0)+ISNULL(g.Retencion3, 0)            
     FROM GastoD g JOIN Concepto c 
       ON g.Concepto = c.Concepto AND c.Modulo = 'GAS'
    WHERE g.ID = @ID 

  OPEN crVerificar
  FETCH NEXT FROM crVerificar INTO @Renglon, @RenglonSub , @Concepto, @CantidadNueva ,@Precio, @Importe, @Impuestos, @EsInventariable, @Retencion 
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF @ConceptoInventariable = 1 AND @MovTipo = 'GAS.CI' AND @Factor = -1 AND @Accion = 'AFECTAR'
    BEGIN
      IF @EsInventariable = 1
      BEGIN
        SELECT @Cantidad = Disponible 
          FROM ConceptoGastoDisponible
         WHERE Concepto = @Concepto 
    
        IF (@Cantidad - @CantidadNueva) < 0.0
          SELECT @Ok = 20020, @OkRef = @Concepto
      END
    END    
--JGD 24Marzo2011 Ticket 2950
    IF @MovTipo NOT IN ('GAS.DA','GAS.ASC','GAS.SR') AND @Ok IS NULL
    BEGIN
      SELECT @TipoRetencion1 = NULLIF(TipoRetencion1,''),@TipoRetencion2 = NULLIF(TipoRetencion2,''),@TipoRetencion3 = NULLIF(TipoRetencion3,'')
        FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo
      IF @TipoRetencion1 IS NOT NULL OR @TipoRetencion3 IS NOT NULL OR @TipoRetencion3 IS NOT NULL
      BEGIN          
        SELECT @ImporteRet = - @Retencion + @Impuestos
        IF ABS(@ImporteRet) > @Importe  
          SELECT @Ok = 51041, @OkRef = 'Concepto: ' + @Concepto
      END          
    END

    FETCH NEXT FROM crVerificar INTO @Renglon,@RenglonSub, @Concepto, @CantidadNueva ,@Precio, @Importe, @Impuestos, @EsInventariable, @Retencion 
  END
  CLOSE crVerificar
  DEALLOCATE crVerificar
END
GO

/**************** spGastoGenerarEntrada ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoGenerarEntrada') and type = 'P') drop procedure dbo.spGastoGenerarEntrada
GO             
CREATE PROCEDURE spGastoGenerarEntrada
			@ID		int,
			@Accion		char(20),
			@Empresa       	char(5),
			@Usuario	char(10),
			@Modulo	      	char(5),
			@Mov           	char(20),
			@MovID		varchar(20),
			@MovTipo	char(20),
			@MovMoneda	char(10),
			@FechaEmision	datetime,
			@Estatus	char(15),
			@EstatusNuevo	char(15),
			@Acreedor	char(10),
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
   @ConceptoInventariable	bit,
   @Inventariable		bit,
   @MovEntrada			varchar(20),
   @MovSalida			varchar(20),
   @MovNuevo			varchar(20),
   @MovIDNuevo			varchar(20),
   @Concepto			varchar(20),
   @IDNuevo			int,
   @Renglon			float, 
   @Renglonsub			int, 
   @Concepto1			varchar(50), 
   @Fecha			datetime, 
   @Cantidad			float, 
   @Precio			money, 
   @Importe			money, 
   @Impuestos			money,
   @Sucursal			int,
   @PorcentajeDeducible		float,
   @SucursalOrigen		int,
   @Impuesto1			float,
   @Impuestos2			money,
   @Impuestos3			money,
   @Conexion			int,
   @EnSilencio			int,
   @DID				int,
   @DMov			varchar(20),
   @DMovID			varchar(20),
   @OkOriginal			int,
   @OkRefOriginal		varchar(255)

  IF @Ok = 80030 
  BEGIN
    SELECT @OkOriginal = @Ok, @OkRefOriginal = @OkRef
    SELECT @Ok = NULL, @OkRef = NULL
  END

  SELECT @ConceptoInventariable = GastoConceptosInventariables,
         @MovEntrada = GASCIMovEntrada ,
         @MovSalida = GASCIMovSalida
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @ConceptoInventariable = 0 RETURN

  SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID
 
  IF @MovTipo IN('GAS.DC','GAS.DG') SELECT @MovNuevo =  @MovSalida
  IF @MovTipo IN('GAS.G', 'GAS.C', 'GAS.CCH') SELECT @MovNuevo =  @MovEntrada

  IF  @Modulo = 'GAS' AND @ConceptoInventariable = 1 AND @Accion IN ('AFECTAR','CANCELAR') AND @MovTipo IN ('GAS.G', 'GAS.C', 'GAS.CCH' ,'GAS.DG','GAS.DC')
  BEGIN
    IF @Accion = 'AFECTAR' AND @Ok IS NULL
    BEGIN
      INSERT INTO Gasto  (Empresa, Mov,        FechaEmision, UltimoCambio, Proyecto, UEN, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus,      Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Periodicidad, TieneRetencion, Acreedor, Clase, Subclase, CtaDinero, FormaPago, Condicion, Vencimiento, Importe, Retencion, Impuestos, Saldo, Anticipo, /*MovAplica, MovAplicaID,*/ Multiple, OrigenTipo, Origen, OrigenID, Poliza, PolizaID, GenerarPoliza, ContID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, FechaRequerida, CXP, GenerarDinero, Dinero, DineroID, DineroCtaDinero, DineroConciliado, DineroFechaConciliacion, AnexoModulo, AnexoID, ProdSerieLote, Sucursal, Mensaje, Logico1, Logico2, Logico3, Logico4, Logico5, Logico6, Actividad, IVAFiscal, IEPSFiscal, EspacioResultado, EstaImpreso, AF, AFArticulo, AFSerie, Pagado, Comentarios, ConVigencia, VigenciaDesde, VigenciaHasta, ContratoTipo, ContratoDescripcion, ContratoSerie, ContratoValor, ContratoSeguro, ContratoVencimiento, ContratoResponsable, Prioridad, CostoPisoD, CostoPisoA, Nota, RetencionAlPago, SubModulo, ClienteRef, ArticuloRef,  SincroC, SucursalOrigen, SucursalDestino, ContratoValorMoneda, ContUso, ContUso2, ContUso3, ContratoID, ContratoMov, ContratoMovID)
      SELECT              Empresa, @MovNuevo , FechaEmision, UltimoCambio, Proyecto, UEN, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, 'SINAFECTAR', Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Periodicidad, TieneRetencion, Acreedor, Clase, Subclase, CtaDinero, FormaPago, Condicion, Vencimiento, Importe, Retencion, Impuestos, Saldo, Anticipo, /*MovAplica, MovAplicaID,*/ Multiple, OrigenTipo, Mov, MovID /*Origen, OrigenID*/, Poliza, PolizaID, GenerarPoliza, ContID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, FechaRequerida, CXP, GenerarDinero, Dinero, DineroID, DineroCtaDinero, DineroConciliado, DineroFechaConciliacion, AnexoModulo, AnexoID, ProdSerieLote, Sucursal, Mensaje, Logico1, Logico2, Logico3, Logico4, Logico5, Logico6, Actividad, IVAFiscal, IEPSFiscal, EspacioResultado, EstaImpreso, AF, AFArticulo, AFSerie, Pagado, Comentarios, ConVigencia, VigenciaDesde, VigenciaHasta, ContratoTipo, ContratoDescripcion, ContratoSerie, ContratoValor, ContratoSeguro, ContratoVencimiento, ContratoResponsable, Prioridad, CostoPisoD, CostoPisoA, Nota, RetencionAlPago, SubModulo, ClienteRef, ArticuloRef,  SincroC, SucursalOrigen, SucursalDestino, ContratoValorMoneda, ContUso, ContUso2, ContUso3, ContratoID, ContratoMov, ContratoMovID
        FROM Gasto 
       WHERE ID = @ID  
      IF @@ERROR <> 0 SET @Ok = 1
      SELECT @IDNuevo = SCOPE_IDENTITY()

      IF @Ok IS NULL
      BEGIN	   
        DECLARE crActualizar CURSOR  FOR
         SELECT g.Renglonsub, g.Concepto, g.Fecha, g.Cantidad, g.Precio, g.Importe, g.Impuestos, g.Sucursal, g.PorcentajeDeducible, g.SucursalOrigen, g.Impuesto1, g.Impuestos2, g.Impuestos3
           FROM GastoD g JOIN Concepto c 
             ON g.Concepto = c.Concepto
          WHERE g.ID = @ID AND c.EsInventariable = 1     
        
        SET @Renglon = 0.0        
        OPEN crActualizar
        FETCH NEXT FROM crActualizar INTO @RenglonSub, @Concepto1, @Fecha, @Cantidad, @Precio, @Importe, @Impuestos, @Sucursal, @PorcentajeDeducible, @SucursalOrigen, @Impuesto1, @Impuestos2, @Impuestos3   
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          SET @Renglon = @Renglon + 2048.0
          INSERT INTO GastoD  (ID,        Renglon,  Renglonsub,  Concepto,   Fecha,   Cantidad,  Precio,    Importe,  Impuestos,  Sucursal,   PorcentajeDeducible,   SucursalOrigen,    Impuesto1,      Impuestos2,   Impuestos3)
                       SELECT  @IDNuevo , @Renglon, @Renglonsub, @Concepto1, @Fecha,  @Cantidad, @Precio,   @Importe, @Impuestos, @Sucursal,  @PorcentajeDeducible,  @SucursalOrigen,   @Impuesto1,     @Impuestos2,  @Impuestos3   
          IF @@ERROR <> 0 SET @Ok = 1

          FETCH NEXT FROM crActualizar INTO @RenglonSub, @Concepto1, @Fecha, @Cantidad, @Precio, @Importe, @Impuestos, @Sucursal, @PorcentajeDeducible, @SucursalOrigen, @Impuesto1, @Impuestos2, @Impuestos3   
	END
        CLOSE crActualizar
        DEALLOCATE crActualizar
      END
      IF NOT EXISTS(SELECT * FROM  GastoD g JOIN  Concepto C ON g.Concepto = c.Concepto WHERE g.ID =  @IDNuevo) 
      BEGIN
        DELETE FROM Gasto WHERE ID = @IDNuevo       
	DELETE FROM GastoD WHERE ID = @IDNuevo       
      END
      --IF @@ERROR <> 0 SET @OK = 1
      IF @OK IS NULL AND EXISTS(SELECT * FROM  GastoD g JOIN  Concepto C ON g.Concepto = c.Concepto WHERE g.ID =  @IDNuevo)
      BEGIN
        IF @MovNuevo IS NULL AND @ConceptoInventariable = 1 SET @Ok = 30120
        IF @Ok IS NULL
        BEGIN
          EXEC spAfectar @Modulo = @Modulo, @ID=@IDNuevo, @Accion = @Accion, @Base='Todo',@GenerarMov = NULL, @Usuario=@Usuario, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

          IF @OK IS NULL
          BEGIN
            SELECT @MovIDNuevo = MovID FROM Gasto WHERE ID = @IDNuevo
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDNuevo, @MovNuevo, @MovIDNuevo, @Ok OUTPUT
          END
        END
      END  
    END ELSE 
    IF @Accion = 'CANCELAR' AND @Ok IS NULL
    BEGIN
      DECLARE crCancelar CURSOR  FOR
       SELECT DID, DMov, DMovID
         FROM MovFlujo mf 
        WHERE mf.Empresa = @Empresa 
          AND mf.OModulo = 'GAS'
          AND mf.OID = @ID
          AND mf.DModulo = 'GAS'

      OPEN crCancelar
      FETCH NEXT FROM crCancelar INTO @DID, @DMov, @DMovID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        EXEC spAfectar @Modulo= @Modulo, @ID=@DID, @Accion=@Accion, @Base='Todo', @GenerarMov= NULL, @Usuario=@Usuario,@Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        IF @OK IS NULL
        BEGIN
          SELECT @MovIDNuevo = MovID FROM Gasto WHERE ID = @IDNuevo
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @DID, @DMov, @DMovID, @Ok OUTPUT
        END
        FETCH NEXT FROM crCancelar INTO @DID, @DMov, @DMovID
      END
      CLOSE crCancelar
      DEALLOCATE crCancelar
    END

    IF @Ok IS NULL SELECT @Ok = @OkOriginal, @OkRef = @OkRefOriginal
  END     

END
GO

/**************** spGastoEjercidoPresupuesto ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spGastoEjercidoPresupuesto') AND type = 'P') DROP PROCEDURE dbo.spGastoEjercidoPresupuesto
GO             
CREATE PROCEDURE spGastoEjercidoPresupuesto
			@Empresa	varchar(5),
			@Ejercicio	int,
			@Periodo	int,
			@Concepto	varchar(50),
			@MovMoneda	varchar(10),
			@Proyecto 	varchar(50) = NULL,
			
			@GastoEjercido	float OUTPUT
			
WITH ENCRYPTION
AS BEGIN

  SELECT @Proyecto = NULLIF(NULLIF(RTRIM(@Proyecto), '0'), '')

  IF (SELECT GastoValidarPresupuestoFR FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
    SELECT @GastoEjercido = SUM((d.Importe-ISNULL(d.Provision, 0.0))*CASE WHEN mt.Clave='GAS.DG' THEN -1 ELSE 1 END) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND DATEPART(year, e.FechaRequerida) = @Ejercicio AND DATEPART(month, e.FechaRequerida) = @Periodo
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.Proyecto, '') = ISNULL(ISNULL(@Proyecto, d.Proyecto), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.DG', 'GAS.DPR', 'GAS.EST')
  ELSE
    SELECT @GastoEjercido = SUM((d.Importe-ISNULL(d.Provision, 0.0))*CASE WHEN mt.Clave='GAS.DG' THEN -1 ELSE 1 END) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND DATEPART(year, e.FechaEmision) = @Ejercicio AND DATEPART(month, e.FechaEmision) = @Periodo
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda AND ISNULL(d.Proyecto, '') = ISNULL(ISNULL(@Proyecto, d.Proyecto), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.DG', 'GAS.DPR', 'GAS.EST')
  RETURN       
END
GO

/**************** spGastoPendientePresupuesto ****************/
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.spGastoPendientePresupuesto') AND type = 'P') DROP PROCEDURE dbo.spGastoPendientePresupuesto
GO             
CREATE PROCEDURE spGastoPendientePresupuesto
			@Empresa	varchar(5),
			@Ejercicio	int,
			@Periodo	int,
			@Concepto	varchar(50),
			@MovMoneda	varchar(10),
			@Proyecto 	varchar(50) = NULL,
			
			@GastoPendiente	float OUTPUT
WITH ENCRYPTION
AS BEGIN
  SELECT @Proyecto = NULLIF(NULLIF(RTRIM(@Proyecto), '0'), '')

  IF (SELECT GastoValidarPresupuestoFR FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
    SELECT @GastoPendiente = SUM(d.Importe*mt.Factor) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaRequerida) = @Ejercicio AND DATEPART(month, e.FechaRequerida) = @Periodo
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda AND ISNULL(d.Proyecto, '') = ISNULL(ISNULL(@Proyecto, d.Proyecto), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
   ELSE
    SELECT @GastoPendiente = SUM(d.Importe*mt.Factor) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaEmision) = @Ejercicio AND DATEPART(month, e.FechaEmision) = @Periodo
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.Proyecto, '') = ISNULL(ISNULL(@Proyecto, d.Proyecto), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
   RETURN       
END
GO

/**************** spGastoConcluirPresupuestos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoConcluirPresupuestos') and type = 'P') drop procedure dbo.spGastoConcluirPresupuestos
GO
CREATE PROCEDURE spGastoConcluirPresupuestos
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Concepto		varchar(50),
    @Moneda		varchar(10),
    @FechaEmision	datetime,
    @FechaRequerida	datetime,
    @ContUso		varchar(20),
    @ContUso2		varchar(20),
    @ContUso3		varchar(20),
    @Importe		money,
    @GastoEjercido	money,
    @GastoPendiente	money,
    @TienePendientes	bit

  IF (SELECT ISNULL(GastoPresupuestoPendiente, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 0 RETURN

  DECLARE crGasto CURSOR LOCAL FOR
   SELECT e.ID, e.Moneda, e.FechaEmision, e.FechaRequerida
     FROM Gasto e
     JOIN MovTipo mt ON mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave = 'GAS.PR'
    WHERE e.Empresa = @Empresa AND e.Estatus = 'PENDIENTE'
  OPEN crGasto
  FETCH NEXT FROM crGasto INTO @ID, @Moneda, @FechaEmision, @FechaRequerida
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @TienePendientes = 0
      DECLARE crGastoD CURSOR LOCAL FOR
       SELECT d.Concepto, d.Importe, d.ContUso, d.ContUso2, d.ContUso3
         FROM GastoD d
        WHERE d.ID = @ID
      OPEN crGastoD
      FETCH NEXT FROM crGastoD INTO @Concepto, @Importe, @ContUso, @ContUso2, @ContUso3
      WHILE @@FETCH_STATUS <> -1 AND @TienePendientes = 0
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          EXEC spVerGastoPendiente @Empresa, @FechaEmision, @FechaRequerida, @Concepto, @Moneda, @ContUso, @EnSilencio = 1, @GastoPendiente = @GastoPendiente OUTPUT, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3
          IF @GastoPendiente = 0.0
          BEGIN
            EXEC spVerGastoEjercido  @Empresa, @FechaEmision, @FechaRequerida, @Concepto, @Moneda, @ContUso, @EnSilencio = 1, @GastoEjercido = @GastoEjercido OUTPUT, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3
            IF @GastoEjercido < @Importe 
              SELECT @TienePendientes = 1
          END ELSE
            SELECT @TienePendientes = 1
        END
        FETCH NEXT FROM crGastoD INTO @Concepto, @Importe, @ContUso, @ContUso2, @ContUso3
      END 
      CLOSE crGastoD
      DEALLOCATE crGastoD
    END
    FETCH NEXT FROM crGasto INTO @ID, @Moneda, @FechaEmision, @FechaRequerida
  END 
  CLOSE crGasto
  DEALLOCATE crGasto

  RETURN
END
GO

/**************** spGastoValidarPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoValidarPresupuesto') and type = 'P') drop procedure dbo.spGastoValidarPresupuesto
GO
CREATE PROCEDURE spGastoValidarPresupuesto
			@Empresa	char(5),
			@ID		int,
			@FechaEmision	datetime,			
			@FechaRequerida	datetime,			
			@Acreedor	char(10),
			@AntecedenteID	int,
			@MovMoneda	char(10),
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mes		int,
    @Ano		int,
    @Dias		int,
    @CfgValidar		bit,
    @CfgValidarCC	bit,
    @CfgValidarFR	bit,
    @CfgProvPresupuesto	char(10),
    @AcreedorValidar	char(10),
    @FechaValidar	datetime,
    @Concepto		varchar(50),
    @ContUso		varchar(20),
    @ContUso2		varchar(20),
    @ContUso3		varchar(20),
    @Validar		varchar(20),
    @Importe		money,
    @Presupuesto	money,
    @Acumulado		money,
    @Pendiente		money,
    @Devoluciones	money,
    @Diferencia		money,
    @FechaD		datetime,
    @FechaA		datetime

  SELECT @CfgValidar         = ISNULL(GastoValidarPresupuesto, 0),
         @CfgValidarCC       = ISNULL(GastoValidarPresupuestoCC, 0),
         @CfgValidarFR       = ISNULL(GastoValidarPresupuestoFR, 0),
         @CfgProvPresupuesto = ProvPresupuesto
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  IF @CfgValidar = 0 AND @CfgValidarCC = 0 RETURN
  IF @CfgValidarFR = 1 
    SELECT @FechaValidar = ISNULL(@FechaRequerida, @FechaEmision)
  ELSE 
    SELECT @FechaValidar = @FechaEmision 

  EXEC spExtraerFecha @FechaValidar OUTPUT
  SELECT @Mes = DATEPART(month, @FechaValidar),
         @Ano = DATEPART(year, @FechaValidar)
  
  EXEC spDiasMes @Mes, @Ano, @Dias OUTPUT

  IF @CfgValidarCC = 1
    DECLARE crGasto CURSOR FOR
     SELECT g.Concepto, NULLIF(RTRIM(g.ContUso), ''), NULLIF(RTRIM(g.ContUso2), ''), NULLIF(RTRIM(g.ContUso3), ''), UPPER(c.ValidarPresupuesto), SUM(g.Importe-ISNULL(g.Provision, 0.0))
       FROM GastoD g, Concepto c
      WHERE g.ID = @ID AND g.Concepto = c.Concepto AND UPPER(c.ValidarPresupuesto) IN ('MENSUAL', 'ACUMULADO', 'ANUAL')
      GROUP BY g.Concepto, g.ContUso, g.ContUso2, g.ContUso3, UPPER(c.ValidarPresupuesto)
  ELSE
    DECLARE crGasto CURSOR FOR
     SELECT g.Concepto, CONVERT(varchar(20), NULL), CONVERT(varchar(20), NULL), CONVERT(varchar(20), NULL), UPPER(c.ValidarPresupuesto), SUM(g.Importe-ISNULL(g.Provision, 0.0))
       FROM GastoD g, Concepto c
      WHERE g.ID = @ID AND g.Concepto = c.Concepto AND UPPER(c.ValidarPresupuesto) IN ('MENSUAL', 'ACUMULADO', 'ANUAL')
      GROUP BY g.Concepto, UPPER(c.ValidarPresupuesto)

  OPEN crGasto
  FETCH NEXT FROM crGasto INTO @Concepto, @ContUso, @ContUso2, @ContUso3, @Validar, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Presupuesto = 0.0, @Acumulado = 0.0, @Pendiente = 0.0, @Devoluciones = 0.0    

      IF @Validar = 'MENSUAL'
      BEGIN
        EXEC spIntToDateTime 1,     @Mes, @Ano, @FechaD OUTPUT
        EXEC spIntToDateTime @Dias, @Mes, @Ano, @FechaA OUTPUT
      END ELSE
      IF @Validar = 'ACUMULADO'
      BEGIN
        EXEC spIntToDateTime 1,     1,    @Ano, @FechaD OUTPUT
        EXEC spIntToDateTime @Dias, @Mes, @Ano, @FechaA OUTPUT
      END ELSE
      IF @Validar = 'ANUAL'
      BEGIN
        EXEC spIntToDateTime 1,   1, @Ano, @FechaD OUTPUT
        EXEC spIntToDateTime 31, 12, @Ano, @FechaA OUTPUT
      END

      IF @CfgValidarFR = 1 
      BEGIN
        SELECT @Presupuesto = ISNULL(SUM(d.Importe*mt.Factor), 0.0) 
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND e.FechaRequerida BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.PR', 'GAS.DPR')

        SELECT @Acumulado = ISNULL(SUM(d.Importe), 0.0)-ISNULL(SUM(d.Provision), 0.0)
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.FechaRequerida BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.CCH')

        SELECT @Pendiente = ISNULL(SUM(d.Importe), 0.0) 
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.FechaRequerida BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND e.Estatus = 'PENDIENTE' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
           AND e.ID <> @AntecedenteID

        SELECT @Devoluciones = ISNULL(SUM(d.Importe), 0.0)-ISNULL(SUM(d.Provision), 0.0)
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'CONCLUIDO' AND e.FechaRequerida BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.OI', 'GAS.DG', 'GAS.DC')
      END ELSE
      BEGIN
        SELECT @Presupuesto = ISNULL(SUM(d.Importe*mt.Factor), 0.0) 
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND e.FechaEmision BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.PR', 'GAS.DPR')

        SELECT @Acumulado = ISNULL(SUM(d.Importe), 0.0)-ISNULL(SUM(d.Provision), 0.0)
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.FechaEmision BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.CCH')

        SELECT @Pendiente = ISNULL(SUM(d.Importe), 0.0) 
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.FechaEmision BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND e.Estatus = 'PENDIENTE' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
           AND e.ID <> @AntecedenteID

        SELECT @Devoluciones = ISNULL(SUM(d.Importe), 0.0)-ISNULL(SUM(d.Provision), 0.0)
          FROM Gasto e, GastoD d, MovTipo mt 
         WHERE e.Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'CONCLUIDO' AND e.FechaEmision BETWEEN @FechaD AND @FechaA 
           AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
           AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
           AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
           AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
           AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.OI', 'GAS.DG', 'GAS.DC')
      END

      SELECT @Acumulado = @Acumulado - @Devoluciones
      SELECT @Diferencia = @Presupuesto - @Acumulado - @Pendiente - @Importe

      IF @Diferencia < 0.0
        SELECT @Ok = 20900, @OkRef = RTRIM(@Concepto)+'<BR><BR>Presupuesto: '+LTRIM(CONVERT(char, @Presupuesto))+'<BR>Acumulado: '+LTRIM(CONVERT(char, @Acumulado))+'<BR>Pendiente: '+LTRIM(CONVERT(char, @Pendiente))+'<BR>Excedente: '+LTRIM(CONVERT(char, -@Diferencia))
    END
    FETCH NEXT FROM crGasto INTO @Concepto, @ContUso, @ContUso2, @ContUso3, @Validar, @Importe
  END 
  CLOSE crGasto
  DEALLOCATE crGasto
END
GO

/**************** spGastoVerificarPeru ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoVerificarPeru') and type = 'P') drop procedure dbo.spGastoVerificarPeru
GO             
/*CREATE PROCEDURE spGastoVerificarPeru
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT

AS BEGIN
  DECLARE
    @ImporteConImpuestos		money,
    @CfgPeruRetenciones			bit,
    @CfgPeruRetencionesTopeExcento	money,
    @FiscalRegimen			varchar(30)

  SELECT @CfgPeruRetenciones            = ISNULL(PeruRetenciones, 0),
         @CfgPeruRetencionesTopeExcento = ISNULL(PeruRetencionesTopeExcento, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa
  
  IF @CfgPeruRetenciones = 1
  BEGIN
    SELECT @ImporteConImpuestos = SUM(ISNULL(Importe, 0.0)+ISNULL(Impuestos, 0.0)) FROM GastoD WHERE ID = @ID
    UPDATE GastoD SET Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL WHERE ID = @ID  
    SELECT @FiscalRegimen = UPPER(p.FiscalRegimen)
      FROM Gasto g, Prov p
     WHERE g.ID = @ID AND g.Acreedor = p.Proveedor

    IF @FiscalRegimen = 'NORMAL'
    BEGIN
      UPDATE Gasto SET RetencionAlPago = 1 WHERE ID = @ID
      UPDATE GastoD SET Retencion2 = (ISNULL(Importe, 0.0)+ISNULL(Impuestos, 0.0)) * 0.06 WHERE ID = @ID 
    END ELSE
    IF ISNULL(@ImporteConImpuestos, 0.0) > @CfgPeruRetencionesTopeExcento
    BEGIN
      IF @FiscalRegimen = 'EXTRANJERO SIN DOMICILIO'  UPDATE GastoD SET Retencion2 = Impuestos WHERE ID = @ID ELSE
      IF @FiscalRegimen = 'EXTRANJERO LOCAL'          UPDATE GastoD SET Retencion  = (ISNULL(Importe, 0.0)+ISNULL(Impuestos, 0.0)) * 0.24 WHERE ID = @ID ELSE
      IF @FiscalRegimen = 'PERSONA NATURAL RETENCION' UPDATE GastoD SET Retencion  = (ISNULL(Importe, 0.0)+ISNULL(Impuestos, 0.0)) * 0.10, Retencion3 = Importe * 0.017 WHERE ID = @ID
    END
  END
  RETURN
END*/
GO

/**************** spGastoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoVerificar') and type = 'P') drop procedure dbo.spGastoVerificar
GO
CREATE PROCEDURE spGastoVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Autorizacion      		char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),

                    @Acreedor			char(10),
		    @Importe			money,
		    @RetencionTotal		money,
                    @ImpuestoTotal		money,
		    @Saldo			money,
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,

		    @MovAplica			char(20),
		    @MovAplicaID		varchar(20),
		    @Multiple			bit,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @OrigenMovTipo		char(20),
		    @FechaRequerida		datetime,

		    @AF				bit,
                    @AFArticulo			varchar(20),
		    @AFSerie			varchar(50),	-- BUG12333

		    @Clase			varchar(50),
                    @SubClase			varchar(50),
             	    @CfgClaseRequerida		bit,
                    @CfgValidarCC		bit,
		    @CfgConceptoCxp		bit,
		    -- 9150
		    @FormaPago			varchar(50),
    		    @ConceptoCxp		varchar(50)  OUTPUT,
		    @AntecedenteID		int	     OUTPUT,
    		    @AntecedenteEstatus		char(15)     OUTPUT,
                    @AntecedenteSaldo		money	     OUTPUT, 
                    @AntecedenteImporteTotal	money	     OUTPUT, 
		    @AntecedenteMovTipo		char(20)     OUTPUT,
		    @Autorizar			bit	     OUTPUT,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteTotal		money,
    @SumaSaldo			money,
    @Cuantos			int,
    @ContUso			varchar(20),
    @LimiteAnticiposMN		money,
    @ChecarLimite 		varchar(20),
    @AnticiposPendientesMN 	money,
    @SolicitudesPendientesMN 	money,
    @Diferencia			money, 
    @ConLimiteAnticipos 	bit,
    @Origen				varchar(20),
    @OrigenID			varchar(20),
    @GasConceptoMultiple        bit --mejora 5425
	 
  SELECT @GasConceptoMultiple = GasConceptoMultiple FROM EmpresaCfg2 WHERE Empresa = @Empresa --mejora 5425

  SELECT @Autorizar = 0
  SELECT @AntecedenteID = NULL, @AntecedenteEstatus = NULL, @AntecedenteSaldo = 0.0, @AntecedenteImporteTotal = 0.0, @AntecedenteMovTipo = NULL,
         @ImporteTotal = @Importe - @RetencionTotal + @ImpuestoTotal

  IF @Accion = 'CANCELAR'
  BEGIN
    IF @Conexion = 0 AND @OrigenMovTipo IN ('GAS.GP', 'GAS.CP', 'GAS.DGP', 'GAS.PRP') SELECT @Ok = 60072
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo) AND @OrigenMovTipo <> 'PROY.PR'
	SELECT @Ok = 60070

    IF @Ok IS NULL 
      IF @MovTipo IN ('GAS.S', 'GAS.P', 'GAS.A') AND ABS(@ImporteTotal-@Saldo) > 1.0 SELECT @Ok = 60060
  END 

  IF @MovTipo IN ('GAS.DA','GAS.ASC','GAS.SR') AND @Importe = 0.0 SELECT @Ok = 30100

  -- 9150
  IF @MovTipo IN('GAS.A', 'GAS.DA', 'GAS.ASC', 'GAS.C', 'GAS.CCH', 'GAS.DC', 'GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.CP', 'GAS.DG', 'GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB') AND @Ok IS NULL AND NULLIF(@FormaPago, '') IS NOT NULL
  BEGIN
    IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
      SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago    
  END

  --Bug 18958
  IF @MovTipo IN ('GAS.A') AND @Accion = 'CANCELAR' AND @OK IS NULL
  BEGIN
    IF EXISTS(SELECT * FROM Gasto WHERE Empresa = @Empresa AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONCLUIDO')
      SELECT @Ok = 20180, @OkRef = 'El movimiento ' + Mov + ' ' + MovID +' esta relacionado (Cancelar)' FROM Gasto WHERE Empresa = @Empresa AND Origen = @Mov AND OrigenID = @MovID AND Estatus = 'CONCLUIDO'
  END
  
  -- Checar Antecendentes Vivos
  IF @MovTipo IN ('GAS.A','GAS.C','GAS.ASC','GAS.CCH','GAS.CP','GAS.G','GAS.GTC','GAS.GP','GAS.DA','GAS.SR') AND (@Multiple = 1 OR @MovAplica IS NOT NULL)
  BEGIN
    IF @Multiple = 1 
    BEGIN
      SELECT @SumaSaldo = 0.0, @Cuantos = 0

      DECLARE crVerificarGasto CURSOR FOR 
       SELECT g.ID, g.Estatus, ISNULL(g.Saldo, 0.0), ISNULL(g.Importe, 0.0) - ISNULL(g.Retencion, 0.0) + ISNULL(g.Impuestos, 0.0), mt.Clave
         FROM GastoAplica ga, Gasto g, MovTipo mt
        WHERE ga.ID = @ID AND g.Empresa = @Empresa AND g.Mov = ga.Aplica AND g.MovID = ga.AplicaID AND mt.Modulo = @Modulo and mt.Mov = g.Mov AND g.Moneda = @MovMoneda
        ORDER BY ga.Renglon

      OPEN crVerificarGasto
      FETCH NEXT FROM crVerificarGasto INTO @AntecedenteID, @AntecedenteEstatus, @AntecedenteSaldo, @AntecedenteImporteTotal, @AntecedenteMovTipo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @AntecedenteID, @Ok OUTPUT, @OkRef OUTPUT
     
          IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP') AND @AntecedenteMovTipo = 'GAS.A' SELECT @Ok = 20182
          SELECT @SumaSaldo = @SumaSaldo + @AntecedenteSaldo, @Cuantos = @Cuantos + 1
          IF @AntecedenteEstatus = 'PENDIENTE' OR (@Accion = 'CANCELAR' AND @AntecedenteEstatus = 'CONCLUIDO')
          BEGIN
            IF (@AntecedenteMovTipo = @MovTipo) 
            OR (@AntecedenteMovTipo NOT IN ('GAS.S', 'GAS.P', 'GAS.A')) 
            OR (@MovTipo IN ('GAS.DA','GAS.ASC','GAS.SR') AND @AntecedenteMovTipo <> 'GAS.A') 
              SELECT @Ok = 20180
  	  END ELSE SELECT @Ok = 20180
        END
        FETCH NEXT FROM crVerificarGasto INTO @AntecedenteID, @AntecedenteEstatus, @AntecedenteSaldo, @AntecedenteImporteTotal, @AntecedenteMovTipo
      END  -- While
      CLOSE crVerificarGasto
      DEALLOCATE crVerificarGasto

      IF @MovTipo IN ('GAS.DA', 'GAS.SR', 'GAS.ASC') AND @Accion <> 'CANCELAR' AND @Importe - @RetencionTotal + @ImpuestoTotal > @SumaSaldo AND @Ok IS NULL 
        SELECT @Ok = 20360
      IF @Ok IS NULL AND @Cuantos <> (SELECT COUNT(*) FROM GastoAplica WHERE ID = @ID)
        SELECT @Ok = 20180
      IF @Ok IS NULL AND @Cuantos = 0 
        SELECT @Ok = 20175
    END ELSE 
    BEGIN
      SELECT @AntecedenteID           = ID,
             @AntecedenteEstatus      = Estatus,
             @AntecedenteSaldo        = ISNULL(Saldo, 0.0),
             @AntecedenteImporteTotal = ISNULL(Importe, 0.0) - ISNULL(Retencion, 0.0) + ISNULL(Impuestos, 0.0) 
        FROM Gasto 
       WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Acreedor = @Acreedor  AND Moneda = @MovMoneda

      IF @AntecedenteID IS NOT NULL AND (@AntecedenteEstatus = 'PENDIENTE' OR (@Accion = 'CANCELAR' AND @AntecedenteEstatus = 'CONCLUIDO'))
      BEGIN
      
        EXEC spAplicaOk @Empresa, @Usuario, @Modulo, @AntecedenteID, @Ok OUTPUT, @OkRef OUTPUT
        SELECT @AntecedenteMovTipo = UPPER(MovTipo.Clave) FROM MovTipo WHERE Modulo = @Modulo AND Mov = @MovAplica
        
        IF @AntecedenteMovTipo NOT IN ('GAS.S', 'GAS.P', 'GAS.A') OR (@MovTipo IN ('GAS.DA','GAS.ASC') AND @AntecedenteMovTipo <> 'GAS.A') SELECT @Ok = 20180
       
        IF @MovTipo = 'GAS.SR' 
        BEGIN
          IF @AntecedenteMovTipo <> 'GAS.S' SELECT @Ok = 20180 
--JGD 10 Febrero2011 Ticket 2944. 
          IF @ImporteTotal <> @AntecedenteImporteTotal SELECT @Ok = 30100
          --IF @ImporteTotal <> @AntecedenteSaldo SELECT @Ok = 30100
        END
        IF @MovTipo IN ('GAS.DA','GAS.ASC','GAS.SR') AND @Accion <> 'CANCELAR' AND @Importe - @RetencionTotal + @ImpuestoTotal> @AntecedenteSaldo AND @Ok IS NULL SELECT @Ok = 20360
        IF @AntecedenteMovTipo = @MovTipo SELECT @Ok = 20180
        IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP') AND @AntecedenteMovTipo = 'GAS.A' SELECT @Ok = 20182
      END ELSE 
        IF @AntecedenteEstatus = 'RECURRENTE' OR @OrigenMovTipo = 'GAS.GR' SELECT @AntecedenteID = NULL ELSE SELECT @Ok = 20180
    END
  END
  IF @AntecedenteID IS NULL AND @MovTipo IN ('GAS.DA','GAS.ASC','GAS.SR') SELECT @Ok = 20180  

  IF @MovTipo NOT IN ('GAS.S', 'GAS.P', 'GAS.DA','GAS.ASC','GAS.SR') AND @Accion = 'AFECTAR' AND @Ok IS NULL 
  BEGIN
    IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID AND NULLIF(RTRIM(Concepto), '') IS NULL) SELECT @Ok = 20480
    IF @Ok IS NULL
      IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID AND ISNULL(Importe, 0.0) = 0.0) SELECT @Ok = 30100
  END

  IF @MovTipo IN ('GAS.A', 'GAS.S', 'GAS.P', 'GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.C', 'GAS.CCH', 'GAS.CP','GAS.DPR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL AND @Autorizacion IS NULL
  BEGIN
    EXEC spGastoValidarPresupuesto @Empresa, @ID, @FechaEmision, @FechaRequerida, @Acreedor, @AntecedenteID, @MovMoneda, @Ok OUTPUT, @OkRef OUTPUT
    IF @Ok IS NOT NULL SELECT @Autorizar = 1
  END

  IF @MovTipo NOT IN ('GAS.DA','GAS.ASC','GAS.SR')
    IF NOT EXISTS(SELECT * FROM GastoD WHERE ID = @ID) SELECT @Ok = 60010

  IF @MovTipo = 'GAS.CTO'
    IF EXISTS(SELECT * FROM Gasto WHERE ID = @ID AND (ConVigencia=0 OR VigenciaDesde IS NULL OR VigenciaHasta IS NULL OR VigenciaHasta < VigenciaDesde))
      SELECT @Ok = 10095

  IF @Accion IN ('AFECTAR', 'VERIFICAR')
  BEGIN
    IF @MovTipo <> 'GAS.EST' AND (SELECT SUM(Importe) FROM GastoD WHERE ID = @ID) < 0.0 SELECT @Ok = 30100
    IF @MovTipo IN ('GAS.CCH', 'GAS.GTC')
      IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID AND NULLIF(RTRIM(AcreedorRef), '') IS NULL) SELECT @Ok = 25480
    IF @MovTipo = 'GAS.GTC'
      IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID AND NULLIF(RTRIM(EndosarA), '') IS NULL) SELECT @Ok = 25490
  END

  IF @CfgConceptoCxp = 1 AND @Accion IN ('AFECTAR', 'VERIFICAR') AND @MovTipo <> 'GAS.GTC' AND @Ok IS NULL
  BEGIN
    SELECT @ConceptoCxp = MIN(c.ConceptoCxp) FROM GastoD d, Concepto c WHERE d.ID = @ID AND c.Modulo = @Modulo AND c.Concepto = d.Concepto
    IF EXISTS(SELECT * FROM GastoD d, Concepto c WHERE d.ID = @ID AND c.Modulo = @Modulo AND c.Concepto = d.Concepto AND c.ConceptoCxp <> @ConceptoCxp) AND @GasConceptoMultiple=0
      SELECT @Ok = 30630, @OkRef = @ConceptoCxp
 
   --mejora 5425 mandar error si no esta mapeado el conceptocxp      
   IF EXISTS (SELECT * FROM GastoD d LEFT JOIN Concepto c  ON c.Concepto = d.Concepto WHERE d.ID = @ID AND c.Modulo = @Modulo   AND c.ConceptoCxp IS NULL) AND @GasConceptoMultiple=1
     SELECT @Ok = 30632 ,@OkRef = @OkRef +( SELECT TOP 1 d.Concepto FROM GastoD d LEFT JOIN Concepto c  ON c.Concepto = d.Concepto WHERE d.ID = @ID AND c.Modulo = @Modulo   AND c.ConceptoCxp IS NULL)
    
  END

  IF @CfgClaseRequerida = 1 AND @Accion IN ('AFECTAR', 'VERIFICAR')
    IF @Clase IS NULL 
      SELECT @Ok = 10080
    ELSE
      IF @SubClase IS NULL AND EXISTS(SELECT * FROM SubClase WHERE Modulo = @Modulo AND Clase = @Clase)
        SELECT @Ok = 10090

  IF @Accion IN ('AFECTAR', 'VERIFICAR') AND @CfgValidarCC = 1 AND @Ok IS NULL
  BEGIN
    SELECT @ContUso = NULL
    IF @ContUso IS NULL SELECT @ContUso = MIN(d.ContUso) FROM GastoD d WHERE d.ID = @ID AND NULLIF(RTRIM(d.ContUso), '') IS NOT NULL AND d.ContUso NOT IN (SELECT v.CentroCostos FROM CentroCostosEmpresa v  WHERE v.Empresa  = @Empresa)
    IF @ContUso IS NULL SELECT @ContUso = MIN(d.ContUso) FROM GastoD d WHERE d.ID = @ID AND NULLIF(RTRIM(d.ContUso), '') IS NOT NULL AND d.ContUso NOT IN (SELECT v.CentroCostos FROM CentroCostosSucursal v WHERE v.Sucursal = @Sucursal)
    IF @ContUso IS NULL SELECT @ContUso = MIN(d.ContUso) FROM GastoD d WHERE d.ID = @ID AND NULLIF(RTRIM(d.ContUso), '') IS NOT NULL AND d.ContUso NOT IN (SELECT v.CentroCostos FROM CentroCostosUsuario v  WHERE v.Usuario  = @Usuario)

    IF @ContUso IS NOT NULL SELECT @Ok = 20765, @OkRef = @ContUso
  END

  IF @Accion NOT IN ('GENERAR', 'CANCELAR') AND @Ok IS NULL 
    EXEC spValidarMovImporteMaximo @Usuario, @Modulo, @Mov, @ID, @Ok OUTPUT, @OkRef OUTPUT

  -- Limite
  IF @MovTipo IN ('GAS.A', 'GAS.S') AND @Accion IN ('AFECTAR', 'VERIFICAR')
  BEGIN
    SELECT @ConLimiteAnticipos = ISNULL(ConLimiteAnticipos, 0), 
           @LimiteAnticiposMN = ISNULL(LimiteAnticiposMN, 0), 
           @ChecarLimite = UPPER(ChecarLimite) 
      FROM Prov 
     WHERE Proveedor = @Acreedor

    IF @ConLimiteAnticipos = 1 AND (@ChecarLimite = 'SOLICITUD' OR @MovTipo = 'GAS.A')
    BEGIN
      SELECT @AnticiposPendientesMN = ISNULL(SUM(g.Saldo*g.TipoCambio), 0)
        FROM Gasto g, MovTipo mt
       WHERE mt.Modulo = @Modulo AND mt.Mov = g.Mov AND mt.Clave = 'GAS.A'
         AND g.Empresa = @Empresa AND g.Acreedor = @Acreedor AND g.Estatus = 'PENDIENTE'
      SELECT @Diferencia = @AnticiposPendientesMN + (ISNULL(@ImporteTotal, 0) * @MovTipoCambio) - @LimiteAnticiposMN

      IF @ChecarLimite = 'SOLICITUD' AND @MovTipo IN ('GAS.A', 'GAS.S')
      BEGIN
--JGD 24Marzo2011. Ticket 3814
        SELECT @Origen = NULL,@OrigenID = NULL
        IF @OrigenMovTipo = 'GAS.S'
          SELECT @Origen = Origen,@OrigenID = OrigenID FROM Gasto WHERE ID = @ID

        SELECT @SolicitudesPendientesMN = ISNULL(SUM(g.Saldo*g.TipoCambio), 0)
          FROM Gasto g, MovTipo mt
         WHERE mt.Modulo = @Modulo AND mt.Mov = g.Mov AND mt.Clave = 'GAS.S'
           AND (ISNULL(g.Mov,'') <> ISNULL(@Origen,'') OR ISNULL(g.MovID,'') <> ISNULL(@OrigenID,'')) --Ticket 3814
           AND g.Empresa = @Empresa AND g.Acreedor = @Acreedor AND g.Estatus = 'PENDIENTE'
        SELECT @Diferencia = @Diferencia + @SolicitudesPendientesMN
        IF @Diferencia > 0.0
          SELECT @Ok = 65015, @OkRef = 'Limite Anticipos MN: '+CONVERT(varchar, @LimiteAnticiposMN) +
                                  '<BR>Solicitudes Pendientes MN: '+CONVERT(varchar, @SolicitudesPendientesMN) +
                                  '<BR>Anticipos Pendientes MN: '+CONVERT(varchar, @AnticiposPendientesMN) +
                                  '<BR>Importe Movimiento MN: '+CONVERT(varchar, @ImporteTotal*@MovTipoCambio) + 
                                  '<BR><BR>Diferencia MN: '+CONVERT(varchar, @Diferencia)
      END
      IF @ChecarLimite = 'ANTICIPO' AND @MovTipo = 'GAS.A' AND @Diferencia > 0.0
        SELECT @Ok = 65015, @OkRef = 'Limite Anticipos MN: '+CONVERT(varchar, @LimiteAnticiposMN) +
                                  '<BR>Anticipos Pendientes MN: '+CONVERT(varchar, @AnticiposPendientesMN) +
                                  '<BR>Importe Movimiento MN: '+CONVERT(varchar, @ImporteTotal*@MovTipoCambio) + 
                                  '<BR><BR>Diferencia MN: '+CONVERT(varchar, @Diferencia)
    END
  END

  IF NOT EXISTS (SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @ID) AND @AF = 1 AND (@AFArticulo IS NULL OR @AFSerie IS NULL) AND (SELECT GastoAFDetalle FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 0 SELECT @Ok = 44170

  /*IF @Ok IS NULL AND (SELECT Peru FROM Version) = 1
    EXEC spGastoVerificarPeru @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT*/

  IF @Ok IS NULL
    EXEC xpGastoVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL --arcc
    EXEC spGastoVerificarDetalle @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL AND (SELECT EsGuatemala FROM Empresa WHERE Empresa = @Empresa) = 1
      EXEC xpGastoVerificarGuatemala @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO


/**************** spGastoCopiarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoCopiarDetalle') and type = 'P') drop procedure dbo.spGastoCopiarDetalle
GO       
CREATE PROCEDURE spGastoCopiarDetalle
		   @Sucursal			int,
    		   @ID                		int,
    		   @IDGenerar          		int,
		   @MovTipo			char(20),
		   @GenerarMovTipo		char(20),
		   @CfgGastoCopiarImporte	bit,
		   @CfgGastoSolicitudAnticipoImpuesto bit,
       		   @Ok                		int OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT * INTO #GastoDetalle FROM cGastoD WHERE ID = @ID 
  IF @@ERROR <> 0 SELECT @Ok = 1

  UPDATE #GastoDetalle SET Sucursal = @Sucursal, ID = @IDGenerar
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @MovTipo = 'GAS.P' 
    UPDATE #GastoDetalle SET Provision = Importe
  ELSE
    UPDATE #GastoDetalle SET Provision = NULL

  IF @GenerarMovTipo IN ('GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.C', 'GAS.ASC', 'GAS.CCH', 'GAS.CP', 'GAS.DG', 'GAS.DC', 'GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB')
  BEGIN
    IF @CfgGastoCopiarImporte = 1
    BEGIN
      IF @CfgGastoSolicitudAnticipoImpuesto = 0
        UPDATE #GastoDetalle 
           SET Precio    = d.Precio/(1+ISNULL(c.Impuestos/100.0, 0.0)),
	       Importe   = d.Importe/(1+ISNULL(c.Impuestos/100.0, 0.0)),
               Impuestos = (d.Importe/(1+ISNULL(c.Impuestos/100.0, 0.0)))*ISNULL(c.Impuestos/100.0, 0.0)
          FROM #GastoDetalle d, Concepto c
         WHERE d.ID = @IDGenerar AND c.Modulo = 'GAS' AND c.Concepto = d.Concepto
    END ELSE
      UPDATE #GastoDetalle SET Cantidad = NULL, Precio = NULL, Importe = NULL, Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL, Impuestos = NULL
    IF @@ERROR <> 0 SELECT @Ok = 1
  END

  INSERT INTO cGastoD SELECT * FROM #GastoDetalle
  
  IF @@ERROR <> 0 SELECT @Ok = 1
  RETURN
END
GO

/**************** spGastoInvTienePendientes ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoInvTienePendientes') and type = 'P') drop procedure dbo.spGastoInvTienePendientes
GO
CREATE PROCEDURE spGastoInvTienePendientes
			@ID			int,
			@MovTipo		varchar(20),
			@TienePendientesInv	bit	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @TienePendientesInv = 0
  IF @MovTipo = 'GAS.S'
    IF EXISTS(SELECT * 
                FROM GastoD d
                JOIN InvD i ON i.ID = d.InvID AND i.Renglon = d.Renglon AND i.RenglonSub = d.RenglonSub
               WHERE d.ID = @ID AND (ISNULL(i.CantidadPendiente, 0.0) > 0 OR ISNULL(i.CantidadOrdenada, 0.0) > 0.0 OR ISNULL(i.CantidadReservada, 0.0) > 0.0) )
    SELECT @TienePendientesInv = 0
END
GO


/**************** spGastoInv ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoInv') and type = 'P') drop procedure dbo.spGastoInv
GO
CREATE PROCEDURE spGastoInv
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),		   
		    @Usuario			char(10),
    		    @Sucursal			int,
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @FechaEmision		datetime,
		    @Estatus			char(15),		
		    @AntecedenteID		int, 
		    @Almacen			varchar(10),

       		    @Ok                		int          OUTPUT,
    		    @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @GastoID				int,
    @CopiarMov				bit,
    @InvID					int,
    @InvMov					varchar(20),
    @InvMovID				varchar(20),
    @Directo				bit,
    @Aplica					varchar(20),
    @AplicaID				varchar(20),
    @CfgMultiUnidadesNivel	varchar(20),
    @CfgMultiUnidades		bit,
    @Articulo				varchar(100),
    @Unidad					varchar(20),
	@Cantidad				int,
	@CantidadInventario		int,
    @OrigenTipo				varchar(20),
    @Origen					varchar(20),
    @OrigenID				varchar(20),
    @AntecedenteOrigen		varchar(20),
    @AntecedenteOrigenID	varchar(20)

  SELECT @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID FROM Gasto WHERE ID = @ID
  SELECT @OrigenTipo = OrigenTipo, @AntecedenteOrigen = Origen, @AntecedenteOrigenID = OrigenID FROM Gasto WHERE Empresa  = @Empresa AND Mov = @Origen AND MovID = @OrigenId AND Sucursal = @Sucursal
  SELECT @AntecedenteID = ID FROM Gasto WHERE Empresa  = @Empresa AND Mov = @AntecedenteOrigen AND MovID = @AntecedenteOrigenID AND Sucursal = @Sucursal

  SELECT @InvID = NULL, @InvMovID = NULL
  SELECT @CopiarMov = ISNULL(GastoInvCopiarMov, 0)
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @CopiarMov = 1 
  BEGIN
    SELECT @InvMov = @Mov, @InvMovID = @MovID
    IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'INV' AND Mov = @InvMov) SELECT @Ok = 70150, @OkRef = @InvMov+' (Modulo Inventarios)'
  END ELSE
    SELECT @InvMov = CASE @MovTipo 
			WHEN 'GAS.S'  THEN InvSolicitud
			WHEN 'GAS.SR' THEN InvSolicitudRechazada
			WHEN 'GAS.CI' THEN InvConsumo
		     END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @InvID = MAX(ID) 
      FROM Inv 
     WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  END ELSE 
  BEGIN    
    SELECT @GastoID = @ID, @Directo = 1, @Aplica = NULL, @AplicaID = NULL
    IF @AntecedenteID IS NOT NULL
    BEGIN
      SELECT @Directo = 0
      SELECT @Aplica = Mov, @AplicaID = MovID FROM Inv WHERE ID = (SELECT MIN(InvID) FROM GastoD WHERE ID = (SELECT MIN(ID) FROM Gasto WHERE ID = @AntecedenteID))
      IF @MovTipo = 'GAS.SR' SELECT @GastoID = @AntecedenteID
    END
    INSERT Inv (
           OrigenTipo,  Origen, OrigenID, UltimoCambio,  Sucursal,  Empresa, Usuario,  Estatus,     Mov,     MovID,     FechaEmision, Almacen,  Proyecto, Moneda, TipoCambio, Observaciones, FechaRequerida, Directo)
    SELECT @Modulo,     Mov,    MovID,    GETDATE(),     @Sucursal, Empresa, Usuario, 'SINAFECTAR', @InvMov, @InvMovID, FechaEmision, @Almacen, Proyecto, Moneda, TipoCambio, Observaciones, FechaRequerida, @Directo
      FROM Gasto
     WHERE ID = @GastoID 
    SELECT @InvID = SCOPE_IDENTITY()
    
    --BUG 22800
    SELECT @CfgMultiUnidades       = MultiUnidades,@CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD') FROM EmpresaCfg2 WHERE Empresa = @Empresa
		
	SELECT  @Articulo=a.Articulo, @Cantidad=d.Cantidad,@Unidad=a.Unidad FROM GastoD d JOIN Gasto e ON e.ID = d.ID JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto AND c.EsInventariable = 1
	JOIN Art a ON a.Articulo = c.Articulo WHERE d.ID = @GastoID
	      
	EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
	
	INSERT InvD (
		   Aplica,  AplicaID,  Sucursal,  ID,     Renglon,CantidadInventario ,   RenglonSub,   RenglonID,                                            RenglonTipo,               Articulo,   Cantidad,   Unidad,   Almacen,  FechaRequerida)
	SELECT @Aplica, @AplicaID, @Sucursal, @InvID, d.Renglon,@CantidadInventario, d.RenglonSub, ROW_NUMBER() OVER (ORDER BY d.Renglon, d.RenglonSub), dbo.fnRenglonTipo(a.Tipo), a.Articulo, d.Cantidad, a.Unidad, @Almacen, e.FechaRequerida
	FROM GastoD d
	JOIN Gasto e ON e.ID = d.ID
	JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto AND c.EsInventariable = 1
	JOIN Art a ON a.Articulo = c.Articulo  
	WHERE d.ID = @GastoID   
	
    UPDATE Inv SET RenglonID = (SELECT MAX(RenglonID) FROM InvD WHERE ID = @InvID) WHERE ID = @InvID

    UPDATE GastoD SET InvID = @InvID WHERE ID = @ID
  END

  IF @InvID IS NOT NULL
  BEGIN
    EXEC spAfectar 'INV', @InvID, @Accion, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    SELECT @InvMovID = MovID FROM Inv WHERE ID = @InvID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @InvID, @InvMov, @InvMovID, @Ok OUTPUT
  END
  RETURN
END
GO

--REQ 13451
/**************** spGastoAfectarClavePresupuestal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAfectarClavePresupuestal') and type = 'P') drop procedure dbo.spGastoAfectarClavePresupuestal
GO             
CREATE PROCEDURE spGastoAfectarClavePresupuestal
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OrigenTipo		char(5),
    @Origen			varchar(20),
    @Clave			varchar(20),
    @OrigenID		varchar(20),
    @IDOrigen		int,
    @Proyecto		varchar(50)
  
  SELECT
    @OrigenTipo = OrigenTipo,
    @Origen		= Origen,
    @OrigenID	= OrigenID
    FROM Gasto
   WHERE ID = @ID
  
  SELECT @Clave = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen
  
  IF @OrigenTipo = 'NOM' AND @Clave = 'NOM.N'
  BEGIN  
    SELECT @IDOrigen = ID FROM Nomina WHERE Mov = @Origen AND MovID = @OrigenID AND Empresa = @Empresa
    SELECT @Proyecto = Proyecto FROM Nomina WHERE ID = @IDOrigen
    UPDATE Gasto
       SET Proyecto = @Proyecto
     WHERE ID = @ID
  END
  RETURN
END
GO

/**************** spGastoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAfectar') and type = 'P') drop procedure dbo.spGastoAfectar
GO             
CREATE PROCEDURE spGastoAfectar
    		   @ID                		int,

		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
    		   @MovMoneda			char(10),
    		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
		   @FechaConclusion		datetime,


    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Acreedor			char(10),
		   @Periodicidad		char(20),
		   @Condicion			varchar(50),
		   @Vencimiento			datetime,
                   @CtaDinero			char(10),
		   @FormaPago			varchar(50),
		   @Importe			money,
                   @RetencionTotal		money,
                   @ImpuestoTotal		money,
                   @Saldo			money,
                   @Anticipo			money,

	    	   @MovAplica			char(20),
		   @MovAplicaID			varchar(20),
		   @Multiple			bit,
		   @Nota			varchar(100),

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @AntecedenteID 		int,
    		   @AntecedenteEstatus		char(15),
                   @AntecedenteSaldo		money, 
                   @AntecedenteImporteTotal	money, 
		   @AntecedenteMovTipo		char(20),
		   @CXP				bit,
		   @Origen			char(20),
                   @OrigenID			varchar(20),
		   @OrigenMovTipo		char(20),
		   @AnexoModulo			char(5),
                   @AnexoID			int,

		   @CfgGastoCopiarImporte	bit,
	           @CfgGastoSolicitudAnticipoImpuesto bit,

                   @RetencionAlPago		bit,
                   @CfgRetencionMov		char(20),
    		   @CfgRetencionAcreedor	char(10),
    		   @CfgRetencionConcepto	varchar(50),
    		   @CfgRetencion2Acreedor	char(10),
    		   @CfgRetencion2Concepto	varchar(50),
    		   @CfgRetencion3Acreedor	char(10),
    		   @CfgRetencion3Concepto	varchar(50),
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @CfgGastoAutoCargos		bit,
		   @CfgBorradorComprobantes	bit,
		   @CfgBorradorCajaChica	bit,
		   @CfgGenerarAnticiposBorrador bit,
		   @CfgConceptoCxp		bit,	
    		   @ConceptoCxp	 		varchar(50),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar			bit,
    @GenerarAfectado		bit,
    @GenerarModulo		char(5),
    @GenerarMovTipo		char(20),
    @GenerarEstatus		char(15),
    @GenerarPeriodo 	 	int, 
    @GenerarEjercicio 	 	int,
    @DineroImporte		money,
    @DineroMov		 	char(20),
    @DineroMovID	 	varchar(20),
    @CxModulo			char(5),
    @CxMov			char(20),
    @CxMovID			varchar(20),
    @CxImporte			money,
    @CxImpuestos		money,
    @CxRetencion		money,
    @CxRetencion2		money,
    @CxRetencion3		money,
    @CxConcepto			varchar(50),
    @Dias			int,
    @ConceptoLinea		varchar(50),
    @FechaLinea			datetime,
    @ReferenciaLinea		varchar(50),
    @ImporteLinea		float,
    @RetencionLinea		float,
    @Retencion2Linea		float,   
    @Retencion3Linea		float,   
    @ImpuestosLinea		float,
    @Impuestos2Linea		float,
    @Impuestos3Linea		float,
    @Impuestos5Linea		float,
    @ImpuestosLineaTotal	float,
    @TotalLinea			float,
    @ImporteTotal		float,
    @ImporteSinRetenciones	money,
    @ImportePendiente		money,
    @ImporteAplicado		money,
    @SumaRetencion		money,
    @SumaRetencion2		money,
    @SumaRetencion3		money,
    @SumaImporte		money,
    @SumaRetenciones		money,
    @SumaImpuestos		money,
    @SumaImpuestos2		money,
    @SumaImpuestos3		money,
    @SumaImpuestos5		money,
    @FechaCancelacion		datetime,
    @AntecedenteEstatusNuevo	char(15),
    @AntecedenteFechaConclusion	datetime,
    @AntecedenteMov		char(20),
    @AntecedenteMovID		char(20),
    @CxAgente			char(10),
    @CxComision			money,
    @AnexoMov			char(20),
    @AnexoMovID			varchar(20),
    @Renglon			float,
    @RenglonSub			int,
    @ContUso			varchar(20),
    @ContUso2			varchar(20),
    @ContUso3			varchar(20),
    @ClavePresupuestal		varchar(50),
    @ClavePresupuestalImpuesto1	varchar(50),
    
    @VIN			varchar(20),
    @Espacio			char(10),
    @AFArticulo			varchar(20),
    @AFSerie			varchar(50),	-- BUG12333
    @Lectura			int,
    @LecturaAnterior		int,
    @Deducible			float,
    @Referencia			varchar(50),
    @EndosarA			varchar(20),
    @Conteo			int,	
    @RedondeoMonetarios		int,
    @PPTO			bit,
    @CP				bit,
    @GastoAnticipoMov		varchar(20),
    @AfectarOtrosModulos	bit,
    @SistemaDetallista		bit,
    @MovImpuesto		bit,
    @Excento1			bit,
    @Excento2			bit,
    @Excento3			bit,
    @TipoImpuesto1		varchar(10),
    @TipoImpuesto2		varchar(10),
    @TipoImpuesto3		varchar(10),
    @TipoImpuesto5		varchar(10),
    @TipoRetencion1		varchar(10),
    @TipoRetencion2		varchar(10),
    @TipoRetencion3		varchar(10),   
    @CuentaPresupuesto		varchar(20),
    @Fiscal			bit,
    @FiscalGenerarRetenciones	bit,
    @SubFolio 			varchar(20),
    @n				int,
    @CfgInv			bit,
    @CfgInvAlmacen		varchar(10),
    @CantidadPendiente		float, 
    @CantidadReservada		float,
    @Cantidad			float,
    @Articulo			varchar(20),
    @Disponible			float,
    @AntecedenteTienePendientesInv bit,
    @Precio			float,
    @GastoEjercido		money,
    @GastoPendiente		money,
    @GastoDisponible		money,
    @Retencion			money,
    @Retencion2			money,
    @Retencion3			money,
    @CfgFormaCobroDA		varchar(50),
    @CfgRetencion2BaseImpuesto1	bit,
    @CfgImpuesto2Info		bit,
    @CfgImpuesto3Info		bit,
    @SubClave			varchar(20),
    @EsEcuador			bit,
    @GasConceptoMultiple        bit, --mejora 5425

    -- 9319
    @AplicaMov					varchar(20),
    @AplicaMovID				varchar(20),
    @AplicaEjercicio			int,
    @AplicaPeriodo				int,
    @AplicaFechaEmision			datetime,
    @AcreedorRef				char(10),
	@IVAFiscal					float,
	@IEPSFiscal					float,
	@OrigenGasto				varchar(20),
    @OrigenIDGasto				varchar(20)

  SELECT @SubClave = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 
  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  SELECT @CfgImpuesto2Info = ISNULL(Impuesto2Info, 0),
	 @CfgImpuesto3Info = ISNULL(Impuesto2Info, 0),
	 @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0)
    FROM Version   
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR',
         @Referencia		= RTRIM(@Mov)+' '+RTRIM(@MovID),
         @MovImpuesto 		= 0

  SELECT @EsEcuador = ISNULL(EsEcuador,0) FROM Empresa WHERE Empresa = @Empresa

  SELECT @CfgFormaCobroDA = NULLIF(RTRIM(CxcFormaCobroDA), '')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgInv = ISNULL(GastoConceptosInventariables, 0),
         @CfgInvAlmacen = GastoAlmacen,
         @FiscalGenerarRetenciones = ISNULL(FiscalGenerarRetenciones, 0),
         @GasConceptoMultiple = ISNULL(GasConceptoMultiple,0) --mejora 5425
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @PPTO = PPTO,
         @CP = CP,
         @SistemaDetallista = SistemaDetallista,
         @Fiscal = ISNULL(Fiscal, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  IF @MovTipo NOT IN ('GAS.S', 'GAS.SR', /*'GAS.GP', 'GAS.CP', 'GAS.DGP',*/ 'GAS.PR', 'GAS.PRP', 'GAS.DPR') AND @Accion <> 'CANCELAR'
  BEGIN
    SELECT @MovImpuesto = 1
    CREATE TABLE #GastoMovImpuesto (
    	Renglon			float		NOT NULL,
	RenglonSub		int		NOT NULL,

	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,	
	Importe1		money		NULL,
	Importe2		money		NULL,
	Importe3		money		NULL,
	Importe5		money		NULL,
	SubTotal		money		NULL,
        LoteFijo		varchar(20)	COLLATE Database_Default NULL,
	OrigenConcepto		varchar(50)	COLLATE Database_Default NULL,
	OrigenDeducible		float		NULL	DEFAULT 100,
        OrigenFecha		datetime	NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,
	Excento1		bit		NULL	DEFAULT 0,
	Excento2		bit		NULL	DEFAULT 0,
	Excento3		bit		NULL	DEFAULT 0,
        TipoImpuesto1		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto2		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto3		varchar(10)	COLLATE Database_Default NULL,
        TipoImpuesto5		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion1		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion2		varchar(10)	COLLATE Database_Default NULL,
        TipoRetencion3		varchar(10)	COLLATE Database_Default NULL,
	ContUso 		varchar(20)	COLLATE Database_Default NULL,
	ContUso2 		varchar(20)	COLLATE Database_Default NULL,
	ContUso3 		varchar(20)	COLLATE Database_Default NULL,	
	ClavePresupuestal		varchar(50)	COLLATE Database_Default NULL,	
	ClavePresupuestalImpuesto1	varchar(50)	COLLATE Database_Default NULL,	
	SubFolio 		varchar(20)	COLLATE Database_Default NULL,
	ImporteBruto		money	NULL
    )
  END

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, NULL, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok = 60300 AND @Accion = 'CANCELAR' AND @OrigenMovTipo IN ('GAS.GP', 'GAS.CP', 'GAS.DGP') SELECT @Ok = NULL, @OkRef = NULL

  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  -- 6625 Verificamos que exista el Acreedor
  IF NOT EXISTS(SELECT Proveedor FROM Prov WHERE Proveedor = @Acreedor) SELECT @Ok = 26050, @OkRef = @Acreedor
  
  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
   -- Leer MovTipo, Periodo y Ejercicio	
   EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
   IF @@ERROR <> 0 SELECT @Ok = 1
   IF @Ok IS NULL 
     SELECT @FechaEmision = FechaEmision FROM Gasto WHERE ID = @IDGenerar
     IF @MovTipo IN ('GAS.S', 'GAS.P', 'GAS.A')  EXEC spCalcularVencimiento 'GAS', @Empresa, @Acreedor, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT ELSE
     EXEC spExtraerFecha @Vencimiento OUTPUT

     SELECT @SumaImporte = SUM(Importe), 
            @SumaRetenciones = SUM(ISNULL(Retencion, 0.0)+ISNULL(Retencion2, 0.0)+ISNULL(Retencion3, 0.0)), 
            @SumaImpuestos = SUM(ISNULL(Impuestos, 0.0)+CASE WHEN @CfgImpuesto2Info = 1 THEN 0.0 ELSE ISNULL(Impuestos2, 0.0) END + CASE WHEN @CfgImpuesto3Info = 1 THEN 0.0 ELSE ISNULL(Impuestos3, 0.0) END + ISNULL(Impuestos5, 0.0)) 
       FROM GastoD 
      WHERE ID = @IDGenerar
     UPDATE Gasto SET MovAplica = @Mov, MovAplicaID = @MovID, Saldo = NULL, Anticipo = NULL, FormaPago = NULL, Importe = @SumaImporte, Retencion = @SumaRetenciones, Impuestos = @SumaImpuestos, Vencimiento = @Vencimiento WHERE ID = @IDGenerar

     IF @GenerarMovTipo IN ('GAS.DA', 'GAS.ASC','GAS.SR')
       UPDATE Gasto SET Importe = @Saldo WHERE ID = @IDGenerar
     ELSE
       EXEC spGastoCopiarDetalle @Sucursal, @ID, @IDGenerar, @MovTipo, @GenerarMovTipo, @CfgGastoCopiarImporte, @CfgGastoSolicitudAnticipoImpuesto, @Ok OUTPUT

    IF @MovTipo = 'GAS.PR'
    BEGIN
      UPDATE Gasto SET MovAplica = NULL, MovAplicaID = NULL WHERE ID = @IDGenerar
      DECLARE crPresupuesto CURSOR FOR
       SELECT Concepto, ContUso, ContUso2, ContUso3, Cantidad, Precio
         FROM GastoD
        WHERE ID = @IDGenerar

      OPEN crPresupuesto
      FETCH NEXT FROM crPresupuesto INTO @ConceptoLinea, @ContUso, @ContUso2, @ContUso3, @Cantidad, @Precio
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @ImporteLinea = @Cantidad * @Precio
          EXEC spVerGastoEjercido  @Empresa, @FechaEmision, @FechaEmision, @ConceptoLinea, @MovMoneda, @ContUso, @EnSilencio = 1, @GastoEjercido = @GastoEjercido OUTPUT, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3
          EXEC spVerGastoPendiente @Empresa, @FechaEmision, @FechaEmision, @ConceptoLinea, @MovMoneda, @ContUso, @EnSilencio = 1, @GastoPendiente = @GastoPendiente OUTPUT, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3
          SELECT @GastoDisponible = @ImporteLinea - @GastoEjercido - @GastoPendiente
          IF @GastoDisponible > 0.0
          BEGIN
            SELECT @Cantidad = ROUND(dbo.fnR3(@ImporteLinea, @Cantidad, @GastoDisponible), 0)
            SELECT @Importe = @Cantidad * @Precio
            SELECT @Retencion  = @Importe * (Retencion/100.0),
                   @Retencion2 = CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN @Importe * (Impuestos/100.0) * (Retencion2/100.0) ELSE @Importe * (Retencion2/100.0) END,
                   @Retencion3 = @Importe * (Retencion3/100.0),
                   @ImpuestosLinea  = @Importe * (Impuestos/100.0)
              FROM Concepto
             WHERE Modulo = 'GAS' AND Concepto = @ConceptoLinea

            UPDATE GastoD 
               SET Cantidad = @Cantidad, Importe = @Importe, Impuestos = @ImpuestosLinea, Retencion = @Retencion, Retencion2 = @Retencion2, Retencion3 = @Retencion3 
             WHERE CURRENT OF crPresupuesto
          END ELSE
            DELETE GastoD WHERE CURRENT OF crPresupuesto
        END
        FETCH NEXT FROM crPresupuesto INTO @ConceptoLinea, @ContUso, @ContUso2, @ContUso3, @Cantidad, @Precio
      END
      CLOSE crPresupuesto
      DEALLOCATE crPresupuesto
    END ELSE
    IF @GenerarMovTipo = 'GAS.CI'
    BEGIN
      DELETE GastoD FROM GastoD d JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto AND (c.EsInventariable = 0 OR NULLIF(c.Articulo, '') IS NULL) WHERE d.ID = @IDGenerar

      DECLARE crConsumo CURSOR FOR
       SELECT d.Renglon, d.RenglonSub, c.Articulo, ISNULL(i.CantidadPendiente, 0.0)-ISNULL(CantidadCancelada, 0), ISNULL(i.CantidadReservada, 0.0)
         FROM GastoD d
         JOIN Concepto c ON c.Modulo = @Modulo AND c.Concepto = d.Concepto AND c.EsInventariable = 1
         JOIN Art a ON a.Articulo = c.Articulo
         JOIN InvD i ON i.ID = d.InvID AND i.Renglon = d.Renglon AND i.RenglonSub = d.RenglonSub
        WHERE d.ID = @ID

      OPEN crConsumo
      FETCH NEXT FROM crConsumo INTO @Renglon, @RenglonSub, @Articulo, @CantidadPendiente, @CantidadReservada
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Cantidad = NULL
          IF @Base = 'PENDIENTE' SELECT @Cantidad = @CantidadPendiente+@CantidadReservada ELSE
          IF @Base = 'RESERVADO' SELECT @Cantidad = @CantidadReservada ELSE
          IF @Base = 'DISPONIBLE'
          BEGIN
            SELECT @Cantidad = @CantidadReservada
            IF @CantidadPendiente > 0.0
            BEGIN
              SELECT @Disponible = SUM(Disponible) FROM ArtDisponible WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @CfgInvAlmacen
              IF @CantidadPendiente>@Disponible SELECT @Cantidad = @Cantidad + @Disponible ELSE SELECT @Cantidad = @Cantidad + @CantidadPendiente
            END           
          END
          IF NULLIF(@Cantidad, 0.0) IS NULL
            DELETE GastoD WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = @RenglonSub
          ELSE
            UPDATE GastoD SET Cantidad = @Cantidad, Importe = dbo.fnR3(Cantidad, Importe, @Cantidad) WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = @RenglonSub
        END
        FETCH NEXT FROM crConsumo INTO @Renglon, @RenglonSub, @Articulo, @CantidadPendiente, @CantidadReservada
      END
      CLOSE crConsumo
      DEALLOCATE crConsumo
    END

    IF @GenerarMovTipo = 'GAS.A' AND @CfgGenerarAnticiposBorrador = 1 
    BEGIN
      EXEC spValidarTareas @Empresa, @Modulo, @IDGenerar, 'BORRADOR', @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Gasto SET Estatus = 'BORRADOR' WHERE ID = @IDGenerar
    END

    IF @Ok IS NULL SELECT @Ok = 80030
    
    RETURN
  END

  IF @OK IS NOT NULL RETURN 


  IF @Estatus = 'SINAFECTAR' AND @Accion = 'AFECTAR' AND ((@CfgBorradorComprobantes = 1 AND @MovTipo = 'GAS.C') OR (@CfgBorradorCajaChica = 1 AND @MovTipo = 'GAS.CCH'))
  BEGIN
    EXEC spValidarTareas @Empresa, @Modulo, @ID, 'BORRADOR', @Ok OUTPUT, @OkRef OUTPUT
    UPDATE Gasto SET Estatus = 'BORRADOR' WHERE ID = @ID
    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
    BEGIN
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE GastoD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

      IF @SistemaDetallista = 1 
        IF (SELECT EditarDeptoDetallista FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) = 0
          UPDATE GastoD 
             SET DepartamentoDetallista = c.DepartamentoDetallista
            FROM GastoD d, Concepto c 
           WHERE d.ID = @ID AND c.Modulo = 'GAS' AND c.Concepto = d.Concepto
    END

    IF @Accion <> 'CANCELAR' 
    BEGIN
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

      -- Calcular Fecha Vencimiento
--      SELECT @Vencimiento = NULL
      IF @MovTipo IN ('GAS.S', 'GAS.P', 'GAS.A')  EXEC spCalcularVencimiento 'CXP', @Empresa, @Acreedor, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT ELSE
      IF @MovTipo = 'GAS.GR' SELECT @Vencimiento = ISNULL(CASE WHEN ConVigencia = 1 THEN VigenciaDesde END, @FechaEmision) FROM Gasto WHERE ID = @ID
      EXEC spExtraerFecha @Vencimiento OUTPUT
    END

    IF @MovTipo NOT IN ('GAS.DA', 'GAS.ASC','GAS.SR')
    BEGIN
      SELECT @Importe = 0.0, @RetencionTotal = 0.0, @ImpuestoTotal = 0.0, 
             @SumaRetencion = 0.0, @SumaRetencion2 = 0.0, @SumaRetencion3 = 0.0,
             @SumaImpuestos = 0.0, @SumaImpuestos2 = 0.0, @SumaImpuestos3 = 0.0, @SumaImpuestos5 = 0.0
          
      SELECT @n = 0, @SubFolio = NULL
DECLARE crGasto CURSOR FOR
       SELECT Renglon, RenglonSub, NULLIF(RTRIM(Concepto), ''), Fecha, NULLIF(RTRIM(Referencia), ''), ISNULL(Importe, 0.0), ISNULL(Retencion, 0.0), ISNULL(Retencion2, 0.0), ISNULL(Retencion3, 0.0), ISNULL(Impuestos, 0.0), ISNULL(Impuestos2, 0.0), ISNULL(Impuestos3, 0.0), ISNULL(Impuestos5, 0.0), NULLIF(RTRIM(ContUso), ''), NULLIF(RTRIM(VIN), ''), NULLIF(RTRIM(Espacio), ''),
              AFArticulo, AFSerie, Lectura, LecturaAnterior, ISNULL(PorcentajeDeducible, 100), NULLIF(RTRIM(ContUso2),''), NULLIF(RTRIM(ContUso3),''), NULLIF(RTRIM(ClavePresupuestal), ''),
			  ISNULL(Cantidad, 0.0)
         FROM GastoD WHERE ID = @ID
      OPEN crGasto
      FETCH NEXT FROM crGasto INTO @Renglon, @RenglonSub, @ConceptoLinea, @FechaLinea, @ReferenciaLinea, @ImporteLinea, @RetencionLinea, @Retencion2Linea, @Retencion3Linea, @ImpuestosLinea, @Impuestos2Linea, @Impuestos3Linea, @Impuestos5Linea, @ContUso, @VIN, @Espacio, @AFArticulo, @AFSerie, @Lectura, @LecturaAnterior, @Deducible, @ContUso2, @ContUso3, @ClavePresupuestal, @Cantidad
      IF @@ERROR <> 0 SELECT @Ok = 1
      IF @@FETCH_STATUS = -1 SELECT @Ok = 60010
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @ConceptoLinea IS NOT NULL AND @Ok IS NULL
        BEGIN
          IF @CfgImpuesto2Info = 1 SELECT @Impuestos2Linea = 0.0
          IF @CfgImpuesto3Info = 1 SELECT @Impuestos3Linea = 0.0
          
          SELECT @CuentaPresupuesto = NULL, @Excento1 = 0, @Excento2 = 0, @Excento3 = 0,
                 @TipoImpuesto1 = NULL, @TipoImpuesto2 = NULL, @TipoImpuesto3 = NULL, @TipoImpuesto5 = NULL, 
		 @TipoRetencion1 = NULL, @TipoRetencion2 = NULL, @TipoRetencion3 = NULL
                 
          SELECT @CuentaPresupuesto = NULLIF(RTRIM(CuentaPresupuesto), ''),
                 @Excento1 = ISNULL(Impuesto1Excento, 0),
                 @Excento2 = ISNULL(Excento2, 0),
                 @Excento3 = ISNULL(Excento3, 0),
		 @TipoImpuesto1 = TipoImpuesto1, @TipoImpuesto2 = TipoImpuesto2, @TipoImpuesto3 = TipoImpuesto3, @TipoImpuesto5 = TipoImpuesto5,  
		 @TipoRetencion1 = TipoRetencion1, @TipoRetencion2 = TipoRetencion2, @TipoRetencion3 = TipoRetencion3,                 
                 @ClavePresupuestalImpuesto1 = ClavePresupuestalImpuesto1
            FROM Concepto
           WHERE Modulo = @Modulo AND Concepto = @ConceptoLinea

          IF @CP = 0 SELECT @ClavePresupuestalImpuesto1 = NULL
          IF @PPTO = 1 AND @Accion <> 'CANCELAR' AND @CuentaPresupuesto IS NULL
          BEGIN
            SELECT @Ok = 40035, @OkRef = @ConceptoLinea
            EXEC xpOk_40035 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
          END

          IF @MovTipo NOT IN ('GAS.S', 'GAS.P', 'GAS.A', 'GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.C', 'GAS.ASC', 'GAS.CCH', 'GAS.CP', 'GAS.DG','GAS.DGP', 'GAS.OI', 'GAS.GR', 'GAS.CTO', 'GAS.DC', 'GAS.EST', 'GAS.CI') AND (@RetencionLinea <> 0 OR @Retencion2Linea <> 0 OR @Retencion3Linea <> 0) SELECT @Ok = 30550

          SELECT @TotalLinea = @ImporteLinea - @RetencionLinea - @Retencion2Linea - @Retencion3Linea + @ImpuestosLinea + @Impuestos2Linea + @Impuestos3Linea + @Impuestos5Linea
          IF @MovTipo IN ('GAS.GP', 'GAS.CP', 'GAS.DGP', 'GAS.PRP')
            EXEC spGastoDProrrateo @Empresa, @Sucursal, @ID, @Renglon, @RenglonSub, @ConceptoLinea, @TotalLinea, @ContUso, @Espacio, @Ok OUTPUT, @OkRef OUTPUT, @ContUso2 = @ContUso2, @ContUso3 = @ContUso3

          IF @MovTipo IN ('GAS.S', 'GAS.P', 'GAS.A') AND (@ImpuestosLinea <> 0.0 OR @Impuestos2Linea <> 0.0 OR @Impuestos3Linea <> 0.0 OR @Impuestos5Linea <> 0.0 OR @RetencionLinea <> 0.0 OR @Retencion2Linea <> 0.0 OR @Retencion3Linea <> 0.0) AND @CfgGastoSolicitudAnticipoImpuesto = 0
          BEGIN
            UPDATE GastoD SET Retencion = NULL, Retencion2 = NULL, Retencion3 = NULL, Impuestos = NULL, Impuestos2 = NULL, Impuestos3 = NULL, Impuestos5 = NULL WHERE CURRENT OF crGasto
            SELECT @RetencionLinea = 0.0, @Retencion2Linea = 0.0, @Retencion3Linea = 0.0, @ImpuestosLinea = 0.0, @Impuestos2Linea = 0.0, @Impuestos3Linea = 0.0, @Impuestos5Linea = 0.0
          END

          IF @MovTipo IN ('GAS.G', 'GAS.GTC', 'GAS.C', 'GAS.CCH')
            UPDATE Concepto SET UltimoCosto = @ImporteLinea, UltimoGasto = @FechaEmision, MonedaCosto = @MovMoneda WHERE Concepto = @ConceptoLinea AND Modulo = 'GAS'

	  IF @MovTipo IN ('GAS.G', 'GAS.GTC', 'GAS.C', 'GAS.CCH') AND @AFArticulo IS NOT NULL AND @AFSerie IS NOT NULL AND @Lectura IS NOT NULL
          BEGIN
	    EXEC spActivoFLectura @Accion, @Empresa, @AFArticulo, @AFSerie, @ConceptoLinea, @FechaEmision, @Lectura, @LecturaAnterior OUTPUT
            IF @Accion <> 'CANCELAR'
              UPDATE GastoD SET LecturaAnterior = @LecturaAnterior WHERE CURRENT OF crGasto
          END
          SELECT @Importe        = @Importe        + /*ROUND(*/@ImporteLinea, /*@RedondeoMonetarios),*/
                 @SumaRetencion  = @SumaRetencion  + /*ROUND(*/@RetencionLinea, /*@RedondeoMonetarios),*/
                 @SumaRetencion2 = @SumaRetencion2 + /*ROUND(*/@Retencion2Linea, /*@RedondeoMonetarios),*/
                 @SumaRetencion3 = @SumaRetencion3 + /*ROUND(*/@Retencion3Linea, /*@RedondeoMonetarios),*/
                 @SumaImpuestos  = @SumaImpuestos  + /*ROUND(*/@ImpuestosLinea, /*, @RedondeoMonetarios)*/
                 @SumaImpuestos2 = @SumaImpuestos2 + /*ROUND(*/@Impuestos2Linea, /*, @RedondeoMonetarios)*/
                 @SumaImpuestos3 = @SumaImpuestos3 + /*ROUND(*/@Impuestos3Linea, /*, @RedondeoMonetarios)*/
                 @SumaImpuestos5 = @SumaImpuestos5 + /*ROUND(*/@Impuestos5Linea /*, @RedondeoMonetarios)*/

--            IF @RetencionAlPago = 0 AND (@MovTipo IN (/*'GAS.GP',*/'GAS.C','GAS.CCH',/*'GAS.CP',*/'GAS.DGP','GAS.OI','GAS.DC') OR (@MovTipo IN ('GAS.G','GAS.GTC') AND @OrigenMovTipo<>'GAS.GP') OR (@MovTipo='GAS.DG' AND @OrigenMovTipo<>'GAS.DGP'))

            IF (@Fiscal = 0 OR @FiscalGenerarRetenciones = 1) AND @RetencionAlPago = 0 AND @MovTipo IN ('GAS.G','GAS.GTC','GAS.DG','GAS.C','GAS.CCH','GAS.DGP','GAS.OI','GAS.DC')
            BEGIN
            IF @RetencionLinea <> 0.0 AND @CfgRetencionConcepto IN ('(Concepto Gasto)', 'ISR - (Concepto Gasto)')
            BEGIN
              EXEC spGastoConcepto @CfgRetencionConcepto, @ConceptoLinea, @CxConcepto OUTPUT
              IF @CfgRetencionAcreedor IS NULL 
                SELECT @Ok = 70100
              ELSE
                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                                 @FechaEmision, @CxConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	    	                 @FechaRegistro, @Ejercicio, @Periodo,
		                 NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                                 @RetencionLinea, NULL, NULL, NULL, 
                                 NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
	  	                 @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                 @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota, @ContUso = @ContUso
            END
            IF @Retencion2Linea <> 0.0 AND @CfgRetencion2Concepto IN ('(Concepto Gasto)', 'IVA - (Concepto Gasto)')
            BEGIN
              EXEC spGastoConcepto @CfgRetencion2Concepto, @ConceptoLinea, @CxConcepto OUTPUT
              IF @CfgRetencion2Acreedor IS NULL 
                SELECT @Ok = 70100
              ELSE
                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                                 @FechaEmision, @CxConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	    	                 @FechaRegistro, @Ejercicio, @Periodo,
		                 NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                                 @Retencion2Linea, NULL, NULL, NULL, 
                                 NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		                 @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                 @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota, @ContUso = @ContUso
            END
            IF @Retencion3Linea <> 0.0 AND @CfgRetencion3Concepto IN ('(Concepto Gasto)', 'R3 - (Concepto Gasto)')
            BEGIN
              EXEC spGastoConcepto @CfgRetencion3Concepto, @ConceptoLinea, @CxConcepto OUTPUT
              IF @CfgRetencion3Acreedor IS NULL 
                SELECT @Ok = 70100
              ELSE
                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                                 @FechaEmision, @CxConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	    	                 @FechaRegistro, @Ejercicio, @Periodo,
		                 NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                                 @Retencion3Linea, NULL, NULL, NULL, 
                                 NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		                 @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                 @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota, @ContUso = @ContUso
            END
          END

          IF @MovImpuesto = 1 
          BEGIN
            IF @MovTipo = 'GAS.GTC'
            BEGIN
              SELECT @n = @n +1
              SELECT @SubFolio = Convert(varchar(20), @n)
            END
            --IF NULLIF(@ImpuestosLinea, 0.0) IS NOT NULL
              INSERT #GastoMovImpuesto (
                     Renglon,  RenglonSub,  OrigenConcepto, OrigenDeducible, OrigenFecha,
                     Impuesto1,
                     Impuesto2,
                     Impuesto3,
                     Impuesto5,
                     Importe1,
                     Importe2,
                     Importe3,
                     Importe5,
                     Retencion1,
                     Retencion2,
                     Retencion3,
                     Excento1,
                     Excento2,
                     Excento3,
                     TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, 
                     TipoRetencion1, TipoRetencion2, TipoRetencion3, 
                     SubTotal,
                     ContUso,
  		     ContUso2,
		     ContUso3,
		     ClavePresupuestal,
		     ClavePresupuestalImpuesto1,
		     ImporteBruto,
                     SubFolio)
              SELECT @Renglon, @RenglonSub, @ConceptoLinea, ISNULL(@Deducible, 100), ISNULL(@FechaLinea, @FechaEmision),
                     ROUND((@ImpuestosLinea/NULLIF(@ImporteLinea, 0.0))*100.0, @RedondeoMonetarios), 
                     ROUND((@Impuestos2Linea/NULLIF(@ImporteLinea, 0.0))*100.0, @RedondeoMonetarios), 
                     ROUND((@Impuestos3Linea/NULLIF(@Cantidad, 0.0)), @RedondeoMonetarios), 
                     ROUND(@Impuestos5Linea, @RedondeoMonetarios), 
                     @ImpuestosLinea, 
                     @Impuestos2Linea, 
                     @Impuestos3Linea, 
                     @Impuestos5Linea, 
                     ROUND((@RetencionLinea/NULLIF(@ImporteLinea, 0.0))*100.0, @RedondeoMonetarios), 
                     ROUND((@Retencion2Linea/NULLIF(CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN @ImpuestosLinea ELSE @ImporteLinea END, 0.0))*100.0, @RedondeoMonetarios), 
                     ROUND((@Retencion3Linea/NULLIF(@ImporteLinea, 0.0))*100.0, @RedondeoMonetarios), 
                     @Excento1,
                     @Excento2,
                     @Excento3,
                     @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5,
                     @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, 
                     @ImporteLinea, 
                     @ContUso,
                     @ContUso2,
                     @ContUso3,           
		     @ClavePresupuestal,
		     @ClavePresupuestalImpuesto1,
                     @ImporteLinea,          
                     @SubFolio

/*

            IF NULLIF(@Retencion2Linea, 0.0) IS NOT NULL
              INSERT #GastoMovImpuesto (
                     Renglon,  RenglonSub,  Impuesto1,                                           Importe1,         SubTotal)
              SELECT @Renglon, @RenglonSub, (@Retencion2Linea/NULLIF(@ImporteLinea, 0.0))*100.0, -@Retencion2Linea, @ImporteLinea*/
          END
        END
        FETCH NEXT FROM crGasto INTO @Renglon, @RenglonSub, @ConceptoLinea, @FechaLinea, @ReferenciaLinea, @ImporteLinea, @RetencionLinea, @Retencion2Linea, @Retencion3Linea, @ImpuestosLinea, @Impuestos2Linea, @Impuestos3Linea, @Impuestos5Linea, @ContUso, @VIN, @Espacio, @AFArticulo, @AFSerie, @Lectura, @LecturaAnterior, @Deducible, @ContUso2, @ContUso3, @ClavePresupuestal, @Cantidad
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crGasto
      DEALLOCATE crGasto
    END

    IF @MovImpuesto = 1
    BEGIN
      DELETE MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
      INSERT MovImpuesto (
             Modulo,  ModuloID, OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenDeducible,		    OrigenFecha, LoteFijo, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, SubFolio, Importe1,      Importe2,      Importe3,      Importe5,      SubTotal,      ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, ImporteBruto)
      SELECT @Modulo, @ID,      @Modulo,      @ID,            OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, SubFolio, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(Importe5), SUM(SubTotal), ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1, SUM(ImporteBruto)
        FROM #GastoMovImpuesto
       GROUP BY OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, SubFolio, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1
       ORDER BY OrigenConcepto, ISNULL(OrigenDeducible, 100), OrigenFecha, LoteFijo, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Retencion1, Retencion2, Retencion3, Excento1, Excento2, Excento3, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3, SubFolio, ContUso, ContUso2, ContUso3, ClavePresupuestal, ClavePresupuestalImpuesto1
    END

    SELECT @RetencionTotal = @SumaRetencion + @SumaRetencion2 + @SumaRetencion3
    SELECT @ImpuestoTotal = @SumaImpuestos + @SumaImpuestos2 + @SumaImpuestos3 + @SumaImpuestos5
    SELECT @ImporteTotal = ROUND(ISNULL(@Importe, 0.0) - ISNULL(@RetencionTotal, 0.0) + ISNULL(@ImpuestoTotal, 0.0), @RedondeoMonetarios)
    SELECT @ImporteSinRetenciones = ROUND(ISNULL(@Importe, 0.0) - ISNULL(@RetencionTotal, 0.0), @RedondeoMonetarios)

    -- Afectar Antecendetes
    SELECT @ImportePendiente = @ImporteTotal
    IF @MovTipo IN ('GAS.C','GAS.ASC','GAS.CCH','GAS.CP','GAS.OI') AND @Accion = 'CANCELAR'
      SELECT @ImportePendiente = @ImportePendiente - ISNULL(SUM(Importe), 0) 
        FROM Dinero 
       WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

    IF @Multiple = 1
    BEGIN
      CREATE TABLE #GastoAplica (
		    ID                  int             NOT NULL PRIMARY KEY,
		    Estatus		char(15)	COLLATE Database_Default NULL,
		    FechaConclusion	datetime	NULL,
		    Saldo		money		NULL)

      DECLARE crGastoAplica CURSOR LOCAL FOR
       SELECT g.ID, g.Mov, g.MovID, g.Estatus, ISNULL(g.Saldo, 0.0), ISNULL(g.Importe, 0.0) - ISNULL(g.Retencion, 0.0) + ISNULL(g.Impuestos, 0.0), ISNULL(ga.Importe, 0.0), mt.Clave
         FROM GastoAplica ga, Gasto g, MovTipo mt
        WHERE ga.ID = @ID AND g.Empresa = @Empresa AND g.Mov = ga.Aplica AND g.MovID = ga.AplicaID AND g.Estatus IN ('PENDIENTE', 'CONCLUIDO')
          AND mt.Modulo = @Modulo and mt.Mov = g.Mov
        ORDER BY ga.Renglon

      OPEN crGastoAplica
      FETCH NEXT FROM crGastoAplica INTO @AntecedenteID, @AntecedenteMov, @AntecedenteMovID, @AntecedenteEstatus, @AntecedenteSaldo, @AntecedenteImporteTotal, @ImporteAplicado, @AntecedenteMovTipo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @ImportePendiente > 0.0
        BEGIN
          IF @MovTipo IN ('GAS.A','GAS.C','GAS.ASC','GAS.CCH','GAS.G','GAS.GTC','GAS.GP','GAS.CP','GAS.DA','GAS.SR','GAS.CI') AND @AntecedenteID IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @Accion <> 'CANCELAR' 
            BEGIN
              -- 9319
              EXEC spMovInfo @AntecedenteID, @Modulo, @Mov = @AplicaMov OUTPUT, @MovID = @AplicaMovID OUTPUT, @FechaEmision = @AplicaFechaEmision OUTPUT, @Ejercicio = @AplicaEjercicio OUTPUT, @Periodo = @AplicaPeriodo OUTPUT

              IF @Ok IS NULL AND @Accion <> 'CANCELAR'
                EXEC spValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								              @AplicaMov, @AplicaMovID, @Modulo, @AntecedenteID, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								              @OkRef = @OkRef OUTPUT

              IF @Ok IS NULL AND @Accion <> 'CANCELAR'
                EXEC spEmpresaValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								                     @AplicaMov, @AplicaMovID, @Modulo, @AntecedenteID, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								                     @OkRef = @OkRef OUTPUT
            
              IF @AntecedenteMovTipo IN ('GAS.A', 'GAS.S', 'GAS.P')
              BEGIN
                IF @AntecedenteMovTipo IN ('GAS.S', 'GAS.P') OR @ImportePendiente > @AntecedenteSaldo
                  SELECT @ImporteAplicado = @AntecedenteSaldo
                ELSE
                  SELECT @ImporteAplicado = @ImportePendiente
                SELECT @ImportePendiente = @ImportePendiente - @ImporteAplicado

                IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.ASC','GAS.CCH','GAS.CP') AND @AntecedenteMovTipo = 'GAS.A'
                  SELECT @Anticipo = @Anticipo + @ImporteAplicado

                SELECT @AntecedenteSaldo = @AntecedenteSaldo - @ImporteAplicado
                IF @AntecedenteMovTipo IN ('GAS.S', 'GAS.P') SELECT @AntecedenteSaldo = 0.0
                UPDATE GastoAplica SET Importe = @ImporteAplicado WHERE CURRENT OF crGastoAplica
              END
            END ELSE
              SELECT @AntecedenteSaldo = @AntecedenteSaldo + @ImporteAplicado

            SELECT @AntecedenteSaldo = ROUND(@AntecedenteSaldo, 2)
  --          EXEC spGastoInvTienePendientes @AntecedenteID, @AntecedenteMovTipo, @AntecedenteTienePendientesInv OUTPUT

            IF @AntecedenteSaldo = 0.0 --AND @AntecedenteTienePendientesInv = 0
              SELECT @AntecedenteEstatusNuevo = 'CONCLUIDO', @AntecedenteFechaConclusion = @FechaEmision
            ELSE SELECT @AntecedenteEstatusNuevo = 'PENDIENTE', @AntecedenteFechaConclusion = NULL

            EXEC spValidarTareas @Empresa, @Modulo, @AntecedenteID, @AntecedenteEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

            IF NOT EXISTS(SELECT * FROM #GastoAplica WHERE ID = @AntecedenteID)
              INSERT #GastoAplica (ID, Estatus, FechaConclusion, Saldo) VALUES (@AntecedenteID, @AntecedenteEstatusNuevo, @AntecedenteFechaConclusion, @AntecedenteSaldo)
/*
            UPDATE Gasto 
               SET Estatus = @AntecedenteEstatusNuevo,
                   FechaConclusion = @AntecedenteFechaConclusion,
                   Saldo = NULLIF(@AntecedenteSaldo, 0.0)
             WHERE CURRENT OF crGastoAplica --ID = @AntecedenteID
*/
            -- Agregar a Estatus Log
            IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
              EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @AntecedenteID, @AntecedenteEstatus, @AntecedenteEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @AntecedenteMov, @AntecedenteMovID, @AntecedenteMovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
 
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @AntecedenteID, @AntecedenteMov, @AntecedenteMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
          END
        END

        FETCH NEXT FROM crGastoAplica INTO @AntecedenteID, @AntecedenteMov, @AntecedenteMovID, @AntecedenteEstatus, @AntecedenteSaldo, @AntecedenteImporteTotal, @ImporteAplicado, @AntecedenteMovTipo
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crGastoAplica
      DEALLOCATE crGastoAplica

      UPDATE Gasto 
         SET Estatus = ga.Estatus,
             FechaConclusion = ga.FechaConclusion,
             Saldo  = NULLIF(ga.Saldo, 0.0)
        FROM Gasto g, #GastoAplica ga
       WHERE g.ID = ga.ID 

    END ELSE
    BEGIN
      IF @MovTipo IN ('GAS.A','GAS.C','GAS.ASC','GAS.CCH','GAS.G','GAS.GTC','GAS.GP','GAS.CP','GAS.DA','GAS.SR','GAS.CI') AND @AntecedenteID IS NOT NULL AND @Ok IS NULL
      BEGIN
        IF @Accion <> 'CANCELAR' 
        BEGIN
          -- 9319
          EXEC spMovInfo @AntecedenteID, @Modulo, @Mov = @AplicaMov OUTPUT, @MovID = @AplicaMovID OUTPUT, @FechaEmision = @AplicaFechaEmision OUTPUT, @Ejercicio = @AplicaEjercicio OUTPUT, @Periodo = @AplicaPeriodo OUTPUT

          IF @Ok IS NULL AND @Accion <> 'CANCELAR'
            EXEC spValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								          @AplicaMov, @AplicaMovID, @Modulo, @AntecedenteID, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								          @OkRef = @OkRef OUTPUT

          IF @Ok IS NULL AND @Accion <> 'CANCELAR'
            EXEC spEmpresaValidarFechaAplicacion @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @Ejercicio, @Periodo,  
								                 @AplicaMov, @AplicaMovID, @Modulo, @AntecedenteID, @AplicaFechaEmision, @AplicaEjercicio, @AplicaPeriodo, @Ok = @Ok OUTPUT,
								                 @OkRef = @OkRef OUTPUT

           
          IF @AntecedenteMovTipo IN ('GAS.S', 'GAS.P') SELECT @AntecedenteSaldo = 0.0 ELSE
          IF @AntecedenteMovTipo IN ('GAS.A')
          BEGIN
            IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.ASC','GAS.CCH','GAS.CP') SELECT @Anticipo = @AntecedenteSaldo
            SELECT @AntecedenteSaldo = @AntecedenteSaldo - @ImportePendiente
            IF @AntecedenteMovTipo = 'GAS.S' SELECT @AntecedenteSaldo = 0.0
          END
        END ELSE
        BEGIN       
          IF @AntecedenteMovTipo IN ('GAS.S', 'GAS.P') SELECT @AntecedenteSaldo = @AntecedenteImporteTotal ELSE
          IF @AntecedenteMovTipo IN ('GAS.A')
          BEGIN
            /*IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP')
              SELECT @AntecedenteSaldo = @AntecedenteSaldo + @Anticipo
            ELSE*/ SELECT @AntecedenteSaldo = @AntecedenteSaldo + @ImportePendiente
          END
        END

        SELECT @AntecedenteSaldo = ROUND(@AntecedenteSaldo, 2)
        IF @AntecedenteSaldo < 0.0 SELECT @AntecedenteSaldo = 0.0 ELSE
        IF @AntecedenteSaldo > @AntecedenteImporteTotal SELECT @AntecedenteSaldo = @AntecedenteImporteTotal
       
--        IF @MovTipo NOT IN ('GAS.CI')
--          EXEC spGastoInvTienePendientes @AntecedenteID, @AntecedenteMovTipo, @AntecedenteTienePendientesInv OUTPUT

        IF ISNULL(@AntecedenteSaldo,0) = 0.0 --AND ISNULL(@AntecedenteTienePendientesInv,0) = 0
          SELECT @AntecedenteEstatusNuevo = 'CONCLUIDO', @AntecedenteFechaConclusion = @FechaEmision
        ELSE SELECT @AntecedenteEstatusNuevo = 'PENDIENTE', @AntecedenteFechaConclusion = NULL

        EXEC spValidarTareas @Empresa, @Modulo, @AntecedenteID, @AntecedenteEstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

        UPDATE Gasto 
           SET Estatus = @AntecedenteEstatusNuevo, 
               FechaConclusion = @AntecedenteFechaConclusion,
               Saldo = NULLIF(@AntecedenteSaldo, 0.0)
         WHERE ID = @AntecedenteID

        -- Agregar a Estatus Log
        IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
          EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @AntecedenteID, @AntecedenteEstatus, @AntecedenteEstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @MovAplica, @MovAplicaID, @AntecedenteMovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @AntecedenteID, @MovAplica, @MovAplicaID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      END
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'PENDIENTE' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') SELECT @Saldo = @ImporteTotal
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro, @Saldo = NULL ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision, @Saldo = NULL  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Gasto
         SET Importe	      = @Importe,
             Retencion 	      = @RetencionTotal,
             Impuestos	      = @ImpuestoTotal,
             Saldo	      = NULLIF(@Saldo, 0.0),
             Anticipo	      = NULLIF(@Anticipo, 0.0),
             IVAFiscal	      = CONVERT(float, NULLIF(@SumaImpuestos, 0)) / NULLIF(@Importe + @ImpuestoTotal - @RetencionTotal, 0),
             IEPSFiscal	      = CONVERT(float, NULLIF(@SumaImpuestos2, 0)) / NULLIF(@Importe + @ImpuestoTotal - @RetencionTotal, 0),
             FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion, 
             UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	     Vencimiento      = @Vencimiento,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza,
	     Autorizacion     = @Autorizacion,             
             Mensaje 	      = NULL
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1

      IF @MovTipo IN ('GAS.DA', 'GAS.SR', 'GAS.ASC') AND @AntecedenteID IS NOT NULL
        UPDATE Gasto 
           SET IVAFiscal = (SELECT IVAFiscal FROM Gasto WHERE ID = @AntecedenteID)
         WHERE ID = @ID 
    END

    SELECT @IVAFiscal = IVAFiscal, @IEPSFiscal = IEPSFiscal FROM Gasto WHERE ID = @ID

    SELECT @AfectarOtrosModulos = 0
    IF (@MovTipo IN ('GAS.A','GAS.DA', 'GAS.ASC') OR (@MovTipo IN ('GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.DG','GAS.DC','GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB') AND @ImporteTotal - @Anticipo > 0)) AND @OrigenMovTipo NOT IN ('GAS.GP', 'GAS.CP', 'GAS.DGP') 
      SELECT @AfectarOtrosModulos = 1

    EXEC xpGastoAfectarOtrosModulos @MovTipo, @OrigenMovTipo, @AfectarOtrosModulos OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @AfectarOtrosModulos = 1 AND @Ok IS NULL
    BEGIN      
      -- Retenciones 

--      IF @RetencionAlPago = 0 AND (@MovTipo IN (/*'GAS.GP',*/'GAS.C','GAS.CCH',/*'GAS.CP',*/'GAS.DGP','GAS.OI') OR (@MovTipo IN ('GAS.G','GAS.GTC') AND @OrigenMovTipo<>'GAS.GP') OR (@MovTipo='GAS.DG' AND @OrigenMovTipo<>'GAS.DGP'))
      IF (@Fiscal = 0 OR @FiscalGenerarRetenciones = 1) AND @RetencionAlPago = 0 AND @MovTipo IN ('GAS.G','GAS.GTC','GAS.DG','GAS.C','GAS.CCH','GAS.DGP','GAS.OI')
      BEGIN
        IF @SumaRetencion <> 0.0 AND @CfgRetencionConcepto NOT IN ('(Concepto Gasto)', 'ISR - (Concepto Gasto)')
        BEGIN
          IF @CfgRetencionAcreedor IS NULL 
            SELECT @Ok = 70100
          ELSE
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                             @FechaEmision, @CfgRetencionConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	  	             @FechaRegistro, @Ejercicio, @Periodo,
		             NULL, NULL, @CfgRetencionAcreedor, NULL, NULL, NULL, NULL, NULL,
                             @SumaRetencion, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota
        END
        IF @SumaRetencion2 <> 0.0 AND @CfgRetencion2Concepto NOT IN ('(Concepto Gasto)', 'IVA - (Concepto Gasto)')
        BEGIN
          IF @CfgRetencion2Acreedor IS NULL 
            SELECT @Ok = 70100
          ELSE
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                             @FechaEmision, @CfgRetencion2Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	  	             @FechaRegistro, @Ejercicio, @Periodo,
		             NULL, NULL, @CfgRetencion2Acreedor, NULL, NULL, NULL, NULL, NULL,
                             @SumaRetencion2, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota
        END
        IF @SumaRetencion3 <> 0.0 AND @CfgRetencion3Concepto NOT IN ('(Concepto Gasto)', 'R3 - (Concepto Gasto)')
        BEGIN
          IF @CfgRetencion3Acreedor IS NULL 
            SELECT @Ok = 70100
          ELSE
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                             @FechaEmision, @CfgRetencion3Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	  	             @FechaRegistro, @Ejercicio, @Periodo,
		             NULL, NULL, @CfgRetencion3Acreedor, NULL, NULL, NULL, NULL, NULL,
                             @SumaRetencion3, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, @CfgRetencionMov,
		             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota
        END
      END

      IF @MovTipo IN ('GAS.G','GAS.GTC','GAS.GP','GAS.DG','GAS.DGP','GAS.ASC') 
      BEGIN
        IF @Anticipo > 0.0 AND @MovTipo <> 'GAS.ASC' SELECT @Ok = 30420
      
        SELECT @CxImporte = @Importe, @CxImpuestos = @ImpuestoTotal, @CxRetencion = @SumaRetencion, @CxRetencion2 = @SumaRetencion2, @CxRetencion3 = @SumaRetencion3

        IF @SubClave = 'GAS.GE/GT' 
        BEGIN 
          DECLARE
	    @GTImpuesto1Mov		varchar(20),
            @GTImpuesto1Acreedor	varchar(10)
          SELECT @GTImpuesto1Mov      = NULLIF(RTRIM(Impuesto1Mov), ''),
                 @GTImpuesto1Acreedor = NULLIF(RTRIM(Impuesto1Acreedor), '')
           FROM EmpresaCfgGT
          WHERE Empresa = @Empresa
          
          IF @GTImpuesto1Mov IS NULL OR @GTImpuesto1Acreedor IS NULL
            SELECT @Ok = 20500, @OkRef = 'EmpresaCfgGT'
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                           @FechaEmision, @CfgRetencionConcepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
  	  	           @FechaRegistro, @Ejercicio, @Periodo,
		           NULL, NULL, @GTImpuesto1Acreedor, NULL, NULL, NULL, NULL, NULL,
                           @ImpuestoTotal, NULL, NULL, NULL, 
                           NULL, NULL, NULL, NULL, NULL, @GTImpuesto1Mov,
		           @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT, @Nota = @Nota        
          SELECT @CxImporte = @CxImporte - ISNULL(@CxRetencion, 0.0)

          SELECT @CxRetencion = NULL, @CxImpuestos = NULL
        END

/** 04.08.2006 **/
/*        IF @RetencionAlPago = 0
          SELECT @CxImporte = @CxImporte - @RetencionTotal, @CxRetencion = NULL, @CxRetencion2 = NULL, @CxRetencion3 = NULL*/

        IF @MovTipo = 'GAS.ASC'
        BEGIN
          SELECT @CxAgente = NULLIF(RTRIM(Agente), '') FROM Prov WHERE Proveedor = @Acreedor
          IF @CxAgente IS NULL SELECT @Ok = 20935, @OkRef = @Acreedor
          SELECT @CxComision = @ImporteTotal, @CxImporte = NULL, @CxImpuestos = NULL, @CxRetencion = NULL, @CxRetencion2 = NULL, @CxRetencion3 = NULL
        END 
        IF @Ok IS NULL
        BEGIN
          IF @MovTipo = 'GAS.GTC'
          BEGIN
            SELECT @Conteo = 0
            DECLARE crGastoD CURSOR FOR
--JGD 10Junio2011 Ticket 4861. Se Agregarón las Variables en el Cursor para la Retención2 y Retención3
--             SELECT NULLIF(RTRIM(EndosarA), ''), NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(Referencia), ''), ISNULL(Importe, 0.0), ISNULL(Retencion, 0.0)+ISNULL(Retencion2, 0.0)+ISNULL(Retencion3, 0.0), ISNULL(Impuestos, 0.0), ISNULL(Impuestos2, 0.0), ISNULL(Impuestos3, 0.0), ISNULL(Impuestos5, 0.0)
             SELECT NULLIF(RTRIM(EndosarA), ''), NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(Referencia), ''), ISNULL(Importe, 0.0), ISNULL(Retencion, 0.0), ISNULL(Retencion2, 0.0), ISNULL(Retencion3, 0.0), ISNULL(Impuestos, 0.0), ISNULL(Impuestos2, 0.0), ISNULL(Impuestos3, 0.0), ISNULL(Impuestos5, 0.0)
               FROM GastoD WHERE ID = @ID
            OPEN crGastoD
            FETCH NEXT FROM crGastoD INTO @EndosarA, @ConceptoLinea, @ReferenciaLinea, @ImporteLinea, @RetencionLinea, @Retencion2Linea, @Retencion3Linea, @ImpuestosLinea, @Impuestos2Linea, @Impuestos3Linea, @Impuestos5Linea
            WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
            BEGIN
              IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
              BEGIN 
                IF @CfgImpuesto2Info = 1 SELECT @Impuestos2Linea = 0.0
                IF @CfgImpuesto3Info = 1 SELECT @Impuestos3Linea = 0.0
                SELECT @ImpuestosLineaTotal = @ImpuestosLinea + @Impuestos2Linea + @Impuestos3Linea + @Impuestos5Linea
                SELECT @Conteo = @Conteo + 1
                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                                 @FechaEmision, @ConceptoLinea, @Proyecto, @Usuario, @Autorizacion, @ReferenciaLinea, @DocFuente, @Observaciones,
  	  	                 @FechaRegistro, @Ejercicio, @Periodo,
		                 @Condicion, @Vencimiento, @EndosarA, NULL, @CxAgente, NULL, NULL, NULL,
                                 @ImporteLinea, @ImpuestosLineaTotal, @RetencionLinea, @ImporteLinea, 
                                 NULL, NULL, NULL, NULL, NULL, NULL,
		                 @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                                 @Ok OUTPUT, @OkRef OUTPUT, @Retencion2 = @Retencion2Linea, @Retencion3 = @Retencion3Linea, @Conteo = @Conteo, @Nota = @Nota
              END
              FETCH NEXT FROM crGastoD INTO @EndosarA, @ConceptoLinea, @ReferenciaLinea, @ImporteLinea, @RetencionLinea, @Retencion2Linea, @Retencion3Linea, @ImpuestosLinea, @Impuestos2Linea, @Impuestos3Linea, @Impuestos5Linea
            END  -- While
            CLOSE crGastoD
            DEALLOCATE crGastoD
          END ELSE 
          --Mejora 5425          
          BEGIN
            IF @GasConceptoMultiple = 1
            BEGIN
              DECLARE crCursorConcepto CURSOR FOR
              SELECT ISNULL(SUM(d.Importe), 0), SUM(ISNULL(d.Impuestos, 0)+ISNULL(CASE WHEN @CfgImpuesto2Info = 1 THEN 0.0 ELSE d.Impuestos2 END, 0)+ISNULL(CASE WHEN @CfgImpuesto3Info = 1 THEN 0.0 ELSE d.Impuestos3 END, 0))  ,SUM(ISNULL(d.Retencion, 0)),SUM(ISNULL(d.Retencion2, 0)),c.ConceptoCxp
                 FROM GastoD d 
                 JOIN Concepto c  ON c.Concepto = d.Concepto WHERE d.ID = @ID AND c.Modulo = @Modulo 
              GROUP BY c.ConceptoCxp    
        
              OPEN crCursorConcepto
              FETCH NEXT FROM crCursorConcepto INTO @CxImporte, @CxImpuestos, @CxRetencion,@CxRetencion2,@ConceptoCxp
              WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
              BEGIN 
              
                SELECT @ImporteTotal = ROUND(ISNULL(@CxImporte, 0.0) - ISNULL(@CxRetencion, 0.0) + ISNULL(@CxImpuestos, 0.0), @RedondeoMonetarios)
                IF @MovTipo = 'GAS.ASC'
                  SELECT @CxComision = @ImporteTotal, @CxImporte = NULL, @CxImpuestos = NULL, @CxRetencion = NULL, @CxRetencion2 = NULL, @CxRetencion3 = NULL
                
              
                EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                       @FechaEmision, @ConceptoCxp, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                       @FechaRegistro, @Ejercicio, @Periodo,
                       @Condicion, @Vencimiento, @Acreedor, NULL, @CxAgente, NULL, @CtaDinero, NULL,
                       @CxImporte, @CxImpuestos, @CxRetencion, @CxComision, 
                       NULL, NULL, NULL, NULL, NULL, NULL,
                       @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                       @Ok OUTPUT, @OkRef OUTPUT, @Retencion2 = @CxRetencion2, @Retencion3 = @CxRetencion3, @Nota = @Nota, @CopiarMovImpuesto = 1
                                       
              
                FETCH NEXT FROM crCursorConcepto INTO  @CxImporte, @CxImpuestos, @CxRetencion,@CxRetencion2,@ConceptoCxp
              END 
              CLOSE crCursorConcepto
              DEALLOCATE crCursorConcepto          
            END
            ELSE
            BEGIN
              EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                               @FechaEmision, @ConceptoCxp, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   	 	               @FechaRegistro, @Ejercicio, @Periodo,
 		               @Condicion, @Vencimiento, @Acreedor, NULL, @CxAgente, NULL, @CtaDinero, NULL,
                               @CxImporte, @CxImpuestos, @CxRetencion, @CxComision, 
                               NULL, NULL, NULL, NULL, NULL, NULL,
		               @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT, @IVAFiscal = @IVAfiscal, @IEPSFiscal = @IEPSFiscal, @Retencion2 = @CxRetencion2, @Retencion3 = @CxRetencion3, @Nota = @Nota, @CopiarMovImpuesto = 1
            END                     
          END
        END
      END ELSE
      BEGIN
        IF @MovTipo IN ('GAS.C','GAS.CCH','GAS.CP','GAS.OI') SELECT @DineroImporte = @ImporteTotal - @Anticipo ELSE SELECT @DineroImporte = @ImporteTotal
        IF ROUND(@DineroImporte, 1) > 0.0
        BEGIN
          IF @MovTipo IN ('GAS.A', 'GAS.DA') AND (SELECT ISNULL(GastoAnticipoCxp, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
          BEGIN
            IF @Estatus = 'PENDIENTE' AND @EstatusNuevo = 'CONCLUIDO' AND @MovTipo = 'GAS.A'
               SELECT @OK = 60090

            SELECT @GastoAnticipoMov = 
                     CASE @MovTipo 
                       WHEN 'GAS.A'  THEN CxpGastoAnticipo 
                       WHEN 'GAS.DA' THEN CxpGastoDevAnticipo 
                     END 
              FROM EmpresaCfgMov 
             WHERE Empresa = @Empresa

            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                             @FechaEmision, @ConceptoLinea, @Proyecto, @Usuario, @Autorizacion, @ReferenciaLinea, @DocFuente, @Observaciones,
      	                     @FechaRegistro, @Ejercicio, @Periodo,
		             '(Fecha)', @FechaEmision, @Acreedor, NULL, @CxAgente, NULL, @CtaDinero, NULL,
                             @DineroImporte, NULL, NULL, NULL, 
                             NULL, NULL, NULL, NULL, NULL, @GastoAnticipoMov,
		             @CxModulo OUTPUT, @CxMov OUTPUT, @CxMovID OUTPUT,
                             @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = 'CXP', @MovIDEspecifico = @MovID, @CopiarMovImpuesto = 1
          END ELSE
          BEGIN
            IF @MovTipo IN ('GAS.DA','GAS.DC','GAS.OI') AND UPPER(@FormaPago) = UPPER(@CfgFormaCobroDA) 
              -- Aplicar Deposito Anticipado de Dinero
              EXEC spDepositoAnticipado @Sucursal, @Accion, @ID, @Mov, @MovID, @Empresa, @Modulo, @CtaDinero, @DineroImporte, @MovMoneda, @RedondeoMonetarios, 0, @FormaPago, @CfgFormaCobroDA, @Referencia, @Ok OUTPUT, @OkRef OUTPUT
            ELSE BEGIN
              IF @MovTipo IN ('GAS.CB', 'GAS.AB') SELECT @DineroImporte = @ImporteSinRetenciones
              EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, NULL, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaPago, NULL, NULL,
                                   @Acreedor, @CtaDinero, NULL, @DineroImporte, NULL,
               	                   NULL, NULL, NULL,
  	                           @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT
            END
            IF @MovTipo IN ('GAS.CB', 'GAS.AB') AND NULLIF(@ImpuestoTotal, 0.0) IS NOT NULL
            BEGIN
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
              EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, NULL, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 0,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @FormaPago, NULL, NULL,
                                   @Acreedor, @CtaDinero, NULL, @ImpuestoTotal, NULL,
               	                   NULL, NULL, NULL,
  	                           @DineroMov OUTPUT, @DineroMovID OUTPUT,
                                   @Ok OUTPUT, @OkRef OUTPUT, @SeparacionDelIVA = 1
            END
          END
        END
      END
    END

    IF @OrigenMovTipo = 'GAS.GR'
      EXEC spAfectarMovRecurrente @Accion, @Empresa, @Modulo, @Origen, @OrigenID, @Ok OUTPUT, @OkRef OUTPUT

    IF @MovTipo = 'GAS.CTO'
      EXEC spMovContratoGenerar @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

    IF @CfgGastoAutoCargos = 1 AND @MovTipo IN ('GAS.G', 'GAS.GTC', 'GAS.C', 'GAS.CCH', 'GAS.DC', 'GAS.DG') AND @Ok IS NULL
      EXEC xpCompraAutoCargos @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Modulo, @Empresa, @ID, @Mov,
		              @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision , NULL, @Proyecto,
			      @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones, @FechaRegistro, @Ejercicio, @Periodo,
			      @Condicion, @Vencimiento, @Acreedor, @Importe, @ImpuestoTotal, NULL, @Ok OUTPUT, @OkRef OUTPUT

  IF (SELECT TieneMovimientos FROM Prov WHERE Proveedor = @Acreedor) = 0
    UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @Acreedor
  
  SELECT  @AcreedorRef = AcreedorRef from GastoD where ID = @ID  
  IF  ISNULL(@AcreedorRef,'')<>''  
	IF (SELECT TieneMovimientos FROM Prov WHERE Proveedor = @AcreedorRef) = 0
    UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @AcreedorRef


  IF @MovTipo IN ('GAS.GP', 'GAS.CP', 'GAS.DGP', 'GAS.PRP')
  BEGIN
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    EXEC spGastoProrratear @Sucursal, @ID, @Modulo, @Accion, @Empresa, @Usuario, @FechaRegistro, @Mov, @MovID, @MovTipo, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @CfgInv = 1 AND @MovTipo IN ('GAS.S', 'GAS.SR', 'GAS.CI')
  BEGIN
    IF @MovTipo = 'GAS.CI'
    BEGIN
      SELECT @OrigenGasto = Origen, @OrigenIDGasto = OrigenID FROM Gasto WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND Mov = @Origen AND MovID = @OrigenID

      IF NOT EXISTS (SELECT ID FROM Inv WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND OrigenTipo = 'GAS' AND Origen = @OrigenGasto AND OrigenID = @OrigenIDGasto AND Estatus = 'CONCLUIDO')
         AND EXISTS (SELECT * FROM GastoD d JOIN Concepto c ON d.Concepto =c.Concepto and c.Modulo =@Modulo  AND c.EsInventariable = 1  WHERE d.ID = @ID )
            EXEC spGastoInv @ID, @Accion, @Empresa, @Usuario, @Sucursal, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @AntecedenteID, @CfgInvAlmacen, @Ok OUTPUT, @OkRef OUTPUT
    END ELSE 
      IF @MovTipo = 'GAS.SR' OR EXISTS(SELECT * FROM GastoD d JOIN Concepto c ON d.Concepto =c.Concepto and c.Modulo =@Modulo  AND c.EsInventariable = 1  WHERE d.ID = @ID )
        EXEC spGastoInv @ID, @Accion, @Empresa, @Usuario, @Sucursal, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @AntecedenteID, @CfgInvAlmacen, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @EsEcuador = 1
    EXEC spEcuadorAutorizacion @Sucursal, @Empresa, @Modulo, @ID, @Accion, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

  --REQ 13451
  IF @Ok IS NULL
    EXEC spGastoAfectarClavePresupuestal @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @EstatusNuevo, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC xpGastoAfectar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @EstatusNuevo, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL OR @Ok = 80030 --arcc
    EXEC spGastoGenerarEntrada  @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, @Estatus, @EstatusNuevo, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT


  IF @PPTO = 1 AND @Accion <> 'CANCELAR' AND @Ok IS NULL
  BEGIN
    IF @MovTipo IN ('GAS.DA', 'GAS.SR', 'GAS.ASC') AND @AntecedenteID IS NOT NULL
    BEGIN
      IF @Multiple = 1 
         SELECT @Ok = 20176
      ELSE BEGIN
        DELETE MovPresupuesto WHERE Modulo = @Modulo AND ModuloID = @ID
        INSERT MovPresupuesto (Modulo, ModuloID, CuentaPresupuesto, Importe) 
        SELECT @Modulo, @ID, CuentaPresupuesto, @ImporteTotal*Importe/NULLIF(@AntecedenteImporteTotal, 0.0)
          FROM MovPresupuesto
         WHERE Modulo = @Modulo AND ModuloID = @AntecedenteID
      END
    END ELSE 
      EXEC spModuloAgregarMovPresupuesto @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT

  IF @AnexoID IS NOT NULL AND @AnexoModulo IS NOT NULL
  BEGIN
    SELECT @AnexoMov = Mov, @AnexoMovID = MovID
      FROM Mov 
     WHERE Empresa = @Empresa AND Modulo = @AnexoModulo AND ID = @AnexoID
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @AnexoModulo, @AnexoID, @AnexoMov, @AnexoMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
  END

--IF @Ok IS NULL SELECT @Ok = 1 -- breakpoint

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

/**************** spGastoDProrratear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoDProrratear') and type = 'P') drop procedure dbo.spGastoDProrratear
GO
CREATE PROCEDURE spGastoDProrratear
			@ID			int,
			@IDGasto		int,
			@FechaDestino		datetime,
			@SucursalDestino	int,
			@ProyectoDestino    varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto		 varchar(50),
    @Fecha		 datetime,
    @Referencia		 varchar(50),
    @Cantidad		 float,
    @Precio		 money,
    @Importe		 money,
    @Retencion		 money,
    @Retencion2 	 money,
    @Retencion3 	 money,
    @Impuestos		 money,
    @Impuestos2		 money,
    @Impuestos3		 money,
    @Sucursal		 int,
    @Renglon		 float,
    @ContUso		 varchar(20),
    @ContUso2		 varchar(20),
    @ContUso3		 varchar(20),
    @VIN 		 varchar(20),
    @Espacio		 char(10),
    @Proyecto		 varchar(50),
    @Actividad		 varchar(50),
    @AFArticulo		 varchar(20),
    @AFSerie		 varchar(50),	-- BUG12333
    @PorcentajeDeducible float,
    @UEN		 int,
    @AcreedorRef         varchar(10), 
    @TipoImpuesto1       varchar(10), 
    @TipoImpuesto2       varchar(10), 
    @TipoImpuesto3       varchar(10), 
    @TipoImpuesto4       varchar(10), 
    @TipoImpuesto5       varchar(10), 
    @TipoRetencion1      varchar(10), 
    @TipoRetencion2      varchar(10), 
    @TipoRetencion3      varchar(10),
    @ClavePresupuestal   varchar(50),
	@Impuesto1			 float,
	@Impuesto2			 float,
	@Impuesto3			 float

  SELECT @Renglon = 0.0
  DECLARE crGastoDProrrateo CURSOR FOR
   SELECT d.Concepto, ISNULL(p.Fecha, d.Fecha), d.Referencia, "Cantidad" = d.Cantidad*(p.Porcentaje/100.0), d.Precio, "Importe" = d.Importe*(p.Porcentaje/100.0), "Retencion" = d.Retencion*(p.Porcentaje/100.0), "Retencion2" = d.Retencion2*(p.Porcentaje/100.0), "Retencion3" = d.Retencion3*(p.Porcentaje/100.0), d.Impuestos*(p.Porcentaje/100.0), d.Impuestos2*(p.Porcentaje/100.0), d.Impuestos3*(p.Porcentaje/100.0), d.Sucursal, p.ContUso, p.ContUso2, p.ContUso3, p.VIN, p.Espacio, p.Proyecto, p.Actividad, p.AFArticulo, p.AFSerie, d.PorcentajeDeducible, p.UEN, d.AcreedorRef, d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, d.TipoImpuesto4, d.TipoImpuesto5, d.TipoRetencion1, d.TipoRetencion2, d.TipoRetencion3,d.ClavePresupuestal, d.Impuesto1, d.Impuesto2, d.Impuesto3
     FROM GastoD d, GastoDProrrateo p
    WHERE d.ID = p.ID AND d.Renglon = p.Renglon AND d.RenglonSub = p.RenglonSub AND d.Concepto = p.Concepto AND p.SucursalProrrateo = @SucursalDestino AND p.Fecha = @FechaDestino
      AND p.Proyecto=@ProyectoDestino
      AND d.ID = @ID

  OPEN crGastoDProrrateo
  FETCH NEXT FROM crGastoDProrrateo INTO @Concepto, @Fecha, @Referencia, @Cantidad, @Precio, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @Impuestos2, @Impuestos3, @Sucursal, @ContUso, @ContUso2, @ContUso3, @VIN, @Espacio, @Proyecto, @Actividad, @AFArticulo, @AFSerie, @PorcentajeDeducible, @UEN, @AcreedorRef, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto4, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3,@ClavePresupuestal, @Impuesto1, @Impuesto2, @Impuesto3
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND ISNULL(@Importe, 0) <> 0.0
    BEGIN
      /*SELECT @PorcentajeDeducible = 0.0
      SELECT @PorcentajeDeducible = ISNULL(PorcentajeDeducible, 0.0) FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @Concepto*/
      SELECT @Renglon = @Renglon + 2048.0
      INSERT GastoD (ID,       Renglon,    RenglonSub, Concepto,  Fecha,  Referencia,  Cantidad,  Precio,  Importe,  Retencion,  Retencion2,  Retencion3,  Impuestos,  Impuestos2,  Impuestos3,  ContUso,  ContUso2,  ContUso3,  VIN,   Espacio,  Sucursal,  Proyecto,  Actividad,  AFArticulo,  AFSerie,  PorcentajeDeducible,  UEN,  AcreedorRef,   TipoImpuesto1, TipoImpuesto2,  TipoImpuesto3,  TipoImpuesto4,  TipoImpuesto5,  TipoRetencion1,  TipoRetencion2,  TipoRetencion3, ClavePresupuestal, Impuesto1, Impuesto2, Impuesto3)
             VALUES (@IDGasto, @Renglon,   0,          @Concepto, @Fecha, @Referencia, @Cantidad, @Precio, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @Impuestos2, @Impuestos3, @ContUso, @ContUso2, @ContUso3, @VIN,  @Espacio, @Sucursal, @Proyecto, @Actividad, @AFArticulo, @AFSerie, @PorcentajeDeducible, @UEN, @AcreedorRef, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto4, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ClavePresupuestal, @Impuesto1, @Impuesto2, @Impuesto3)
    END
    FETCH NEXT FROM crGastoDProrrateo INTO @Concepto, @Fecha, @Referencia, @Cantidad, @Precio, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @Impuestos2, @Impuestos3, @Sucursal, @ContUso, @ContUso2, @ContUso3, @VIN, @Espacio, @Proyecto, @Actividad, @AFArticulo, @AFSerie, @PorcentajeDeducible, @UEN, @AcreedorRef, @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto4, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ClavePresupuestal, @Impuesto1, @Impuesto2, @Impuesto3
  END  -- While
  CLOSE crGastoDProrrateo
  DEALLOCATE crGastoDProrrateo
  RETURN
END
GO


/**************** spGastoProrratear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoProrratear') and type = 'P') drop procedure dbo.spGastoProrratear
GO
CREATE PROCEDURE spGastoProrratear
		   @Sucursal		int,
                   @ID                  int,
    		   @Modulo	      	char(5),
		   @Accion		char(20),		   
		   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @GastoMov		char(20),
    @GastoMovID		varchar(20),
    @IDGasto		int,
    @SucursalDestino	int,
    @FechaDestino	datetime,
    @ProyectoDestino                varchar(50)

  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crGastoID CURSOR FOR
     SELECT ID, Mov, MovID
       FROM Gasto
      WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
    OPEN crGastoID
    FETCH NEXT FROM crGastoID INTO @IDGasto, @GastoMov, @GastoMovID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        EXEC spGasto @IDGasto, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, @IDGasto, @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGasto, @GastoMov, @GastoMovID, @Ok OUTPUT
        IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@OkRef) + ' - ' + RTRIM(@GastoMov) + ' ' + RTRIM(@GastoMovID)
      END
      FETCH NEXT FROM crGastoID INTO @IDGasto, @GastoMov, @GastoMovID
    END  -- While
    CLOSE crGastoID
    DEALLOCATE crGastoID
  END ELSE
  BEGIN
    SELECT @GastoMovID = NULL, @GastoMov = NULL
    SELECT @GastoMov = CASE @MovTipo 
                         WHEN 'GAS.GP'  THEN Gasto
                         WHEN 'GAS.CP'  THEN GastoComprobante 
                         WHEN 'GAS.EST'     THEN CASE WHEN EXISTS(SELECT * FROM MovTipo mt WHERE mt.Modulo = @Modulo AND mt.Mov = @Mov AND mt.SubClave = 'GAS.EST/GP') THEN Gasto ELSE NULL END
                         WHEN 'GAS.DGP' THEN GastoDev 
                         WHEN 'GAS.PRP' THEN GastoPresupuesto
                       END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    DECLARE crSucursal CURSOR FOR
     SELECT Fecha, SucursalProrrateo, Proyecto
       FROM GastoDProrrateo
      WHERE ID = @ID 
      GROUP BY Fecha, SucursalProrrateo, Proyecto
      ORDER BY Fecha, SucursalProrrateo, Proyecto

    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @FechaDestino, @SucursalDestino, @ProyectoDestino
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        INSERT Gasto (UltimoCambio, Sucursal,  SucursalOrigen, SucursalDestino,  OrigenTipo,  Origen, OrigenID,  Empresa, Usuario,  Estatus,     Mov,       FechaEmision,                        Proyecto, Moneda, TipoCambio, Observaciones, Acreedor, Clase, SubClase, TieneRetencion, FechaRequerida, AnexoModulo, AnexoID, Prioridad)
               SELECT GETDATE(),    @Sucursal, @Sucursal,      @SucursalDestino, @Modulo,     Mov,    MovID,     Empresa, Usuario, 'SINAFECTAR', @GastoMov, ISNULL(@FechaDestino, FechaEmision),  @ProyectoDestino, Moneda, TipoCambio, Observaciones, Acreedor, Clase, SubClase, TieneRetencion, FechaRequerida, AnexoModulo, AnexoID, 'Normal'
                 FROM Gasto 
                WHERE ID = @ID 
        SELECT @IDGasto = SCOPE_IDENTITY() 

        EXEC spGastoDProrratear @ID, @IDGasto, @FechaDestino, @SucursalDestino, @ProyectoDestino
        IF EXISTS(SELECT * FROM GastoD WHERE ID = @IDGasto)
        BEGIN
          EXEC spGasto @IDGasto, @Modulo, @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, @IDGasto, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @IDGasto, @GastoMov, @GastoMovID, @Ok OUTPUT
        END ELSE 
          DELETE Gasto WHERE ID = @IDGasto
      END
      FETCH NEXT FROM crSucursal INTO @FechaDestino, @SucursalDestino, @ProyectoDestino
    END  -- While
    CLOSE crSucursal
    DEALLOCATE crSucursal
  END
END
GO


/**************** spGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGasto') and type = 'P') drop procedure dbo.spGasto
GO
CREATE PROCEDURE spGasto
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
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @ValidarSucursal		bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @FechaRequerida		datetime,
    @Proyecto	      		varchar(50),
    @Actividad			varchar(50),
    @AF				bit,
    @AFArticulo			varchar(20),
    @AFSerie			varchar(50),	-- BUG12333
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @Importe			money,
    @RetencionTotal		money,
    @Impuestos			money,
    @Saldo			money,
    @Anticipo			money,
    @DocFuente	      		int,
    @CXP			bit,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgGastoCopiarImporte	bit,
    @CfgGastoSolicitudAnticipoImpuesto bit,
    @CfgRetencionMov		char(20),
    @RetencionAlPago		bit,
    @CfgRetencionAlPago		bit,
    @CfgRetencionAcreedor	char(10),
    @CfgRetencionConcepto	varchar(50),
    @CfgRetencion2Acreedor	char(10),
    @CfgRetencion2Concepto	varchar(50),
    @CfgRetencion3Acreedor	char(10),
    @CfgRetencion3Concepto	varchar(50),
    @CfgGastoAutoCargos		bit,
    @CfgBorradorComprobantes	bit,
    @CfgBorradorCajaChica	bit,
    @CfgGenerarAnticiposBorrador bit, 
    @CfgActividadDetalle	bit,
    @CfgAFDetalle		bit,
    @CfgProyectoDetalle		bit,
    @CfgUENDetalle		bit,
    @CfgClaseRequerida		bit,
    @CfgValidarCC		bit,
    @CfgConceptoCxp		bit,
    @CfgPresupuestoPendiente	bit,
    @ConceptoCxp		varchar(50),
    @Clase			varchar(50),
    @SubClase			varchar(50),
    @MovAplica			char(20),
    @MovAplicaID		varchar(20),
    @Multiple			bit,
    @Nota			varchar(100),
    @AntecedenteID		int,
    @AntecedenteSaldo		money,
    @AntecedenteEstatus		char(15),
    @AntecedenteImporteTotal	money,
    @AntecedenteMovTipo		char(20),
    @Acreedor		        char(10), 
    @AcreedorTipo		char(20),
    @Periodicidad		char(20),
    @Condicion			varchar(50),
    @Vencimiento		datetime,
    @CtaDinero			char(10),
    @FormaPago			varchar(50),
    @OrigenTipo			char(10),
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @OrigenMovTipo		char(20),
    @CfgRetencion2BaseImpuesto1	bit,
    @CfgImpuesto2Info		bit,
    @CfgImpuesto3Info		bit,
    @UEN			int,
    @AnexoModulo		char(5),    
    @AnexoID			int,
    @Autorizar			bit,
    @SubClave			varchar(20),
    @Factor			int,
    @MovFactor			varchar(20)/*,
    @Verificar			bit*/

  SELECT @MovFactor = Mov FROM Gasto WHERE ID = @ID
  SELECT @Factor = Factor FROM MovTipo WHERE Modulo = @Modulo AND Mov = @MovFactor

  SELECT @CfgImpuesto2Info = ISNULL(Impuesto2Info, 0),
	 @CfgImpuesto3Info = ISNULL(Impuesto2Info, 0),
	 @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0)
    FROM Version
    
  -- Inicializar Variables
  SELECT @CfgContX        = 0,
         @CfgContXGenerar = 'NO',
	 @AcreedorTipo    = NULL,
         @OrigenMovTipo	  = NULL,
         @ValidarSucursal = 1,
         @Autorizar       = 0,
         @Nota            = NULL/*,
         @Verificar	  = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @CXP = CXP,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Acreedor = NULLIF(RTRIM(Acreedor), ''), @Periodicidad = NULLIF(RTRIM(Periodicidad), ''), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento, 
         @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @FormaPago = NULLIF(RTRIM(FormaPago), ''),
         @Importe = ISNULL(Importe, 0.0), @RetencionTotal = ISNULL(Retencion, 0.0), @Impuestos = ISNULL(Impuestos, 0.0), @Saldo = ISNULL(Saldo, 0.0), 
         @Anticipo = ISNULL(Anticipo, 0.0), @MovAplica = NULLIF(RTRIM(MovAplica), ''), @MovAplicaID = MovAplicaID, @Multiple = Multiple,
	 @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @AnexoModulo = NULLIF(RTRIM(AnexoModulo), ''), @AnexoID = AnexoID,
         @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = OrigenID, @UEN = UEN,
         @Clase = NULLIF(RTRIM(Clase), ''), @SubClase = NULLIF(RTRIM(SubClase), ''),
         @Actividad = Actividad, @AF = ISNULL(AF, 0), @AFArticulo = NULLIF(RTRIM(AFArticulo), ''), @AFSerie = NULLIF(RTRIM(AFSerie), ''), @Nota = Nota,
         @FechaRequerida = FechaRequerida
    FROM Gasto
   WHERE ID = @ID

  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @AcreedorTipo = UPPER(Tipo)
    FROM Prov
   WHERE Proveedor = @Acreedor

  IF @Accion = 'AUTORIZAR'
    SELECT @Autorizacion = @Usuario, @Accion = 'AFECTAR'

  IF @AcreedorTipo = 'ESTRUCTURA' SELECT @Ok = 20680

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('VERIFICAR', 'AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT, @SubClave = @SubClave OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
  IF @Origen IS NOT NULL
    SELECT @OrigenMovTipo = Clave FROM MovTipo WHERE Modulo = @OrigenTipo AND Mov = @Origen

  IF @MovTipo NOT IN ('GAS.DA','GAS.ASC','GAS.SR')
    SELECT @Importe = ISNULL(SUM(Importe), 0), 
           @RetencionTotal = SUM(ISNULL(Retencion, 0)+ISNULL(Retencion2, 0)+ISNULL(Retencion3, 0)), 
           @Impuestos = SUM(ISNULL(Impuestos, 0)+ISNULL(CASE WHEN @CfgImpuesto2Info = 1 THEN 0.0 ELSE Impuestos2 END, 0)+ISNULL(CASE WHEN @CfgImpuesto3Info = 1 THEN 0.0 ELSE Impuestos3 END, 0))
      FROM GastoD
     WHERE ID = @ID

  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, NULL, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE', 'RECURRENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE','RECURRENTE')) OR
     (@Accion = 'GENERAR')
  BEGIN
    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @CfgRetencionMov = CASE WHEN @MovTipo IN ('GAS.DG', 'GAS.DGP', 'GAS.DC') THEN CxpDevRetencion ELSE CxpRetencion END
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    SELECT @CfgValidarCC = ISNULL(CentroCostosValidar, 0)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa 

    SELECT @CfgGastoCopiarImporte = ISNULL(GastoCopiarImporte, 0),
           @CfgGastoSolicitudAnticipoImpuesto = ISNULL(GastoSolicitudAnticipoImpuesto, 0),
           @CfgRetencionAlPago    = ISNULL(RetencionAlPago, 0),
           @CfgRetencionAcreedor  = NULLIF(RTRIM(GastoRetencionAcreedor), ''),
    	   @CfgRetencionConcepto  = NULLIF(RTRIM(GastoRetencionConcepto), ''),
           @CfgRetencion2Acreedor  = NULLIF(RTRIM(GastoRetencion2Acreedor), ''),
    	   @CfgRetencion2Concepto  = NULLIF(RTRIM(GastoRetencion2Concepto), ''),
           @CfgRetencion3Acreedor  = NULLIF(RTRIM(GastoRetencion3Acreedor), ''),
    	   @CfgRetencion3Concepto  = NULLIF(RTRIM(GastoRetencion3Concepto), ''),
    	   @CfgActividadDetalle	= ISNULL(GastoActividad, 0),
           @CfgAFDetalle = GastoAFDetalle,
    	   @CfgProyectoDetalle	= ISNULL(GastoProyectoDetalle, 0),
           @CfgUENDetalle = GastoUENDetalle,
           @CfgClaseRequerida = ISNULL(GastoClaseRequerida, 0),
           @CfgGastoAutoCargos = ISNULL(GastoAutoCargos, 0),
           @CfgBorradorComprobantes = ISNULL(GastoBorradorComprobantes, 0),
           @CfgBorradorCajaChica = ISNULL(GastoBorradorCajaChica, 0),
           @CfgGenerarAnticiposBorrador = ISNULL(GastoGenerarAnticiposBorrador,0),
           @CfgConceptoCxp = ISNULL(GastoConceptoCxp, 0),
           @CfgPresupuestoPendiente = ISNULL(GastoPresupuestoPendiente, 0)
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @CfgContX = 1 
      SELECT @CfgContXGenerar = ContXGenerar
        FROM EmpresaCfgModulo
       WHERE Empresa = @Empresa
         AND Modulo  = @Modulo
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF (@MovTipo IN ('GAS.S', 'GAS.P', 'GAS.A') OR (@MovTipo = 'GAS.PR' AND @CfgPresupuestoPendiente = 1)) AND 
       @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' SELECT @EstatusNuevo = 'PENDIENTE'
    IF @MovTipo = 'GAS.GR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' SELECT @EstatusNuevo = 'RECURRENTE' 

    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'SINCRO')
    BEGIN
      IF @CfgActividadDetalle = 0 UPDATE GastoD SET Actividad  = @Actividad  WHERE ID = @ID AND Actividad <> @Actividad
      IF @CfgActividadDetalle = 1 UPDATE GastoD SET Actividad  = @Actividad  WHERE ID = @ID AND NULLIF(RTRIM(Actividad), '') IS NULL
      IF @CfgProyectoDetalle  = 0 UPDATE GastoD SET Proyecto   = @Proyecto   WHERE ID = @ID AND Proyecto  <> @Proyecto
      IF @CfgProyectoDetalle  = 1 UPDATE GastoD SET Proyecto   = @Proyecto   WHERE ID = @ID AND NULLIF(RTRIM(Proyecto), '') IS NULL
      IF @CfgUENDetalle       = 0 UPDATE GastoD SET UEN        = @UEN        WHERE ID = @ID AND UEN <> @UEN
      IF @CfgUENDetalle       = 1 UPDATE GastoD SET UEN        = @UEN        WHERE ID = @ID AND UEN IS NULL
      IF @CfgAFDetalle        = 0 UPDATE GastoD SET AFArticulo = @AFArticulo, AFSerie = @AFSerie WHERE ID = @ID AND (AFArticulo <> @AFArticulo OR AFSerie <> @AFSerie)
      IF @CfgAFDetalle        = 1 UPDATE GastoD SET AFArticulo = @AFArticulo, AFSerie = @AFSerie WHERE ID = @ID AND (NULLIF(RTRIM(AFArticulo), '') IS NULL OR NULLIF(RTRIM(AFSerie), '') IS NULL)
    END

    -- Verificar antes de Afectar
    IF ((@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL) OR
       (@Ok IS NULL AND @Accion = 'AFECTAR' AND @MovTipo = 'GAS.CI')
    BEGIN
      -- 9150
      EXEC spGastoVerificar @ID, @Accion, @Empresa, @Usuario, @Autorizacion, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, 
			    @Acreedor, @Importe, @RetencionTotal, @Impuestos, @Saldo, @Condicion, @Vencimiento, @MovAplica, @MovAplicaID, @Multiple,
                            @Conexion, @SincroFinal, @Sucursal, @OrigenMovTipo, @FechaRequerida,
                            @AF, @AFArticulo, @AFSerie,
                            @Clase, @SubClase, @CfgClaseRequerida, @CfgValidarCC, @CfgConceptoCxp, @FormaPago, @ConceptoCxp OUTPUT,
                            @AntecedenteID OUTPUT, @AntecedenteEstatus OUTPUT, @AntecedenteSaldo OUTPUT, @AntecedenteImporteTotal OUTPUT, @AntecedenteMovTipo OUTPUT,
                            @Autorizar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Autorizar = 1 
        UPDATE Gasto SET Mensaje = @Ok WHERE ID = @ID

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
    
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR', 'CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
    BEGIN
      SELECT @RetencionAlPago = ISNULL(RetencionAlPago, 0)
        FROM Gasto
       WHERE ID = @ID
      IF @CfgRetencionAlPago = 1 SELECT @RetencionAlPago = 1
      IF (@MovTipo IN ('GAS.C', 'GAS.CP', 'GAS.CCH', 'GAS.DC')) OR (@SubClave = 'GAS.GE/GT') SELECT @RetencionAlPago = 0

      EXEC spGastoAfectar @ID, @Accion, @Base, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			  @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, 
                          @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                          @Acreedor, @Periodicidad, @Condicion, @Vencimiento, @CtaDinero, @FormaPago, @Importe, @RetencionTotal, @Impuestos, @Saldo, @Anticipo, @MovAplica, @MovAplicaID, @Multiple, @Nota,
		          @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, 
                          @AntecedenteID, @AntecedenteEstatus, @AntecedenteSaldo, @AntecedenteImporteTotal, @AntecedenteMovTipo, @CXP, @Origen, @OrigenID, @OrigenMovTipo, @AnexoModulo, @AnexoID,
			  @CfgGastoCopiarImporte, @CfgGastoSolicitudAnticipoImpuesto, 
                          @RetencionAlPago, @CfgRetencionMov, @CfgRetencionAcreedor, @CfgRetencionConcepto, @CfgRetencion2Acreedor, @CfgRetencion2Concepto, @CfgRetencion3Acreedor, @CfgRetencion3Concepto, @CfgContX, @CfgContXGenerar, @CfgGastoAutoCargos, @CfgBorradorComprobantes, @CfgBorradorCajaChica, @CfgGenerarAnticiposBorrador, @CfgConceptoCxp, @ConceptoCxp,
                          @GenerarPoliza, @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                          @Ok OUTPUT, @OkRef OUTPUT

    END
  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    IF @OrigenTipo <> 'PROY' SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

/**************** spGastoAnexo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAnexo') and type = 'P') drop procedure dbo.spGastoAnexo
GO
CREATE PROCEDURE spGastoAnexo
		   @Empresa			char(5),
    		   @AnexoModulo	      		char(5),
                   @AnexoID                  	int,
		   @Accion			char(20),
		   @FechaRegistro		datetime,
		   @Usuario			char(10),
		
		   @GastoAnexoTotalPesos	money		OUTPUT,
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID           	int,
    @GenerarMov		char(20),
    @Mov	      	char(20),
    @MovID            	varchar(20),
    @IDGenerar		int,
    @Estatus		char(15)

  IF EXISTS(SELECT * FROM Gasto WHERE Empresa = @Empresa AND AnexoModulo = @AnexoModulo AND AnexoID = @AnexoID AND Estatus = 'PENDIENTE')
  BEGIN
    SELECT @Ok = 30345
    RETURN
  END

  IF @Accion = 'CANCELAR' SELECT @Estatus = 'CONCLUIDO' ELSE SELECT @Estatus = 'SINAFECTAR'

  DECLARE crGastoAnexo CURSOR FOR
   SELECT ID
     FROM Gasto 
    WHERE Empresa = @Empresa AND AnexoModulo = @AnexoModulo AND AnexoID = @AnexoID AND Estatus = @Estatus 

  OPEN crGastoAnexo
  FETCH NEXT FROM crGastoAnexo INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Accion = 'AFECTAR'
      BEGIN
        EXEC spGasto @ID, 'GAS', 'VERIFICAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, 
                     @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT,
	             @Ok OUTPUT, @OkRef OUTPUT  
        IF @Ok = 80000 SELECT @Ok = NULL, @OkRef = NULL
      END
      IF @Ok IS NULL
        EXEC spGasto @ID, 'GAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, 
                     @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT,
	             @Ok OUTPUT, @OkRef OUTPUT  
    END
    FETCH NEXT FROM crGastoAnexo INTO @ID
  END  -- While
  CLOSE crGastoAnexo
  DEALLOCATE crGastoAnexo

  SELECT @GastoAnexoTotalPesos = SUM((ISNULL(g.Importe, 0)-ISNULL(g.Retencion, 0)+ISNULL(g.Impuestos, 0)) * g.TipoCambio * mt.Factor)
    FROM Gasto g, MovTipo mt
   WHERE g.Empresa = @Empresa AND g.AnexoModulo = @AnexoModulo AND g.AnexoID = @AnexoID AND g.Estatus = 'CONCLUIDO'
     AND mt.Modulo = 'GAS' AND mt.Mov = g.Mov AND mt.Clave IN ('GAS.G', 'GAS.GTC', 'GAS.C', 'GAS.CCH', 'GAS.OI', 'GAS.DG', 'GAS.DC')
  RETURN
END
GO

/**************** spGastoAnexoEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAnexoEliminar') and type = 'P') drop procedure dbo.spGastoAnexoEliminar
GO
CREATE PROCEDURE spGastoAnexoEliminar
		   @Empresa			char(5),
    		   @AnexoModulo	      		char(5),
                   @AnexoID                  	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID     int

  DECLARE crGastoAnexo CURSOR FOR
   SELECT ID
     FROM Gasto 
    WHERE Empresa = @Empresa AND AnexoModulo = @AnexoModulo AND AnexoID = @AnexoID AND Estatus = 'SINAFECTAR'

  OPEN crGastoAnexo
  FETCH NEXT FROM crGastoAnexo INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      DELETE GastoD WHERE ID = @ID
      DELETE Gasto WHERE CURRENT OF crGastoAnexo 
    END
    FETCH NEXT FROM crGastoAnexo INTO @ID
  END  -- While
  CLOSE crGastoAnexo
  DEALLOCATE crGastoAnexo
END
GO

/**************** spGastoAnexoTarifaPrecio ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spGastoAnexoTarifaPrecio') and sysstat & 0xf = 4) drop procedure dbo.spGastoAnexoTarifaPrecio
GO             
/*CREATE PROCEDURE spGastoAnexoTarifaPrecio
		    	@ArtGrupo	varchar(50),
			@Zona		varchar(50),
			@Moneda		char(10),
			@TipoCambio	float,
			@EmbarqueModulo	char(5),
			@Precio		money 		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TarifaMoneda	char(10),
    @TarifaFactor	float,
    @TarifaTipoCambio	float,
    @Tarifa		money,
    @ZonaPorcentaje	float

  SELECT @ZonaPorcentaje = 0.0, @Tarifa = 0.0, @Precio = 0.0

  SELECT @Tarifa = CASE @EmbarqueModulo
			  WHEN 'VTAS' THEN ISNULL(CostoVenta, 0.0)
			  WHEN 'INV'  THEN ISNULL(CostoInv, 0.0)
			  WHEN 'COMS' THEN ISNULL(CostoCompra, 0.0)
                   END,
         @TarifaMoneda = Moneda
    FROM EmbarqueTarifa
   WHERE Agrupador = 'Grupo' AND Nombre = @ArtGrupo

  EXEC spMoneda NULL, @Moneda, @TipoCambio, @TarifaMoneda, @TarifaFactor OUTPUT, @TarifaTipoCambio OUTPUT, @Ok OUTPUT
  IF @Ok IS NOT NULL SELECT @OkRef = 'Tarifa: '+RTRIM(@ArtGrupo)
  SELECT @Precio = @Tarifa * @TarifaFactor

  SELECT @ZonaPorcentaje = ISNULL(Porcentaje, 0)
    FROM Zona
   WHERE Zona = @Zona

  SELECT @Precio = @Precio * (1 + (@ZonaPorcentaje / 100))
  RETURN
END*/
GO


/**************** spGastoAnexoTarifa ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAnexoTarifa') and sysstat & 0xf = 4) drop procedure dbo.spGastoAnexoTarifa
GO             
CREATE PROCEDURE spGastoAnexoTarifa
			@Sucursal		int,
                        @Empresa		char(5),
			@OrigenModulo		char(5),
			@OrigenID		int,
			@OrigenMov		char(20),
			@OrigenMovID		varchar(20),
			@FechaEmision		datetime,
			@FechaRegistro		datetime,
			@Usuario		char(10),
			@Afectar		bit,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		char(20),
    @MovTipo		char(20),
    @Moneda		char(10),
    @TipoCambio		float,
    @Clase		varchar(50),
    @Subclase		varchar(50),
    @Acreedor		char(10),
    @Condicion		varchar(50),
    @Renglon		float,
    @Referencia		varchar(50),
    @Concepto		varchar(50),
    @Cantidad		float,
    @CostoTotal		money,
    @Precio		money,
    @Importe		money,
    @Retencion		money,
    @Retencion2		money,
    @Retencion3		money,
    @Impuestos		money,
    @SumaImporte	money,
    @SumaRetencion	money,
    @SumaImpuestos	money,
    @EmbarqueModulo	char(5),
    @Agrupador		varchar(50),    
    @Porcentaje 	float,
    @TieneRetencion	bit,
    @GenerarGasto	bit,
    @PorcentajeImpuestos	float,
    @PorcentajeRetencion	float,
    @PorcentajeRetencion2	float,
    @PorcentajeRetencion3	float,
    @CfgRetencion2BaseImpuesto1	bit


  SELECT @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version   
  SELECT @Acreedor             = v.Proveedor,
         @GenerarGasto	       = v.GenerarGasto,
         @Clase  	       = v.Clase,
	 @SubClase	       = v.SubClase,
	 @Condicion	       = v.Condicion,
	 @PorcentajeImpuestos  = v.Impuestos,
	 @PorcentajeRetencion  = v.Retencion,
	 @PorcentajeRetencion2 = v.Retencion2,
	 @PorcentajeRetencion3 = v.Retencion3
    FROM Embarque e, Vehiculo v
   WHERE e.Vehiculo = v.Vehiculo AND e.ID = @OrigenID

  IF @Acreedor IS NULL OR @GenerarGasto = 0 RETURN

  SELECT @Mov = EmbarqueGastoTarifas
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'GAS' AND Mov = @Mov
  IF @MovTipo NOT IN ('GAS.G', 'GAS.GTC', 'GAS.GP') SELECT @Ok = 35005, @OkRef = @Mov

  SELECT @Moneda = ContMoneda
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @TipoCambio  = TipoCambio FROM Mon WHERE Moneda = @Moneda

  IF @Acreedor IS NULL SELECT @Ok = 40020
  IF @MovTipo IN ('GAS.GP', 'GAS.CP') DELETE GastoDProrrateo WHERE ID = @ID

  INSERT Gasto (Sucursal,  Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,     UltimoCambio, Acreedor,  Clase,  SubClase,  Condicion,  AnexoModulo,   AnexoID, Prioridad)
        VALUES (@Sucursal, @Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'CONFIRMAR', GETDATE(),    @Acreedor, @Clase, @SubClase, @Condicion, @OrigenModulo, @OrigenID, 'Normal')

  SELECT @ID = SCOPE_IDENTITY()

  DECLARE crEmbarqueArt CURSOR FOR
   SELECT e.Modulo, a.Familia, SUM(e.Cantidad), SUM(e.Cantidad*e.Costo)
     FROM EmbarqueArt e, Art a
    WHERE e.EmbarqueID = @OrigenID AND e.Articulo = a.Articulo AND UPPER(e.Tipo) NOT IN ('DESEMBARCAR', 'PENDIENTE')
      AND e.Modulo IN ('VTAS', 'INV', 'COMS')
    GROUP BY e.Modulo, a.Familia
    ORDER BY e.Modulo, a.Familia

  SELECT @Renglon 	= 0.0, 
         @SumaImporte	= 0.0,
  	 @SumaRetencion	= 0.0, 
    	 @SumaImpuestos	= 0.0

  OPEN crEmbarqueArt
  FETCH NEXT FROM crEmbarqueArt INTO @EmbarqueModulo, @Agrupador, @Cantidad, @CostoTotal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0,
             @Concepto = 'Flete',
             @Referencia = @Agrupador

      SELECT @Porcentaje = 0.0
      SELECT @Porcentaje = CASE @EmbarqueModulo
	  		  WHEN 'VTAS' THEN ISNULL(PorcentajeVenta, 0.0)
			  WHEN 'INV'  THEN ISNULL(PorcentajeInv, 0.0)
			  WHEN 'COMS' THEN ISNULL(PorcentajeCompra, 0.0)
                   END
        FROM EmbarqueTarifa
       WHERE Agrupador = 'Familia' AND Nombre = @Agrupador

      IF @MovTipo = 'GAS.GP'
        EXEC spGastoAnexoTarifaProrrateo @OrigenID, @ID, @Renglon, 0, @Concepto, @Agrupador, @CostoTotal, @EmbarqueModulo

      SELECT @Importe = @CostoTotal * @Porcentaje/100.0
      SELECT @Precio = @Importe / @Cantidad

      SELECT @Retencion  = @Importe * (@PorcentajeRetencion/100.0),
             @Retencion2 = CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN @Importe * (@PorcentajeImpuestos/100.0) * (@PorcentajeRetencion2/100.0) ELSE @Importe * (@PorcentajeRetencion2/100.0) END,
             @Retencion3 = @Importe * (@PorcentajeRetencion3/100.0),
             @Impuestos  = @Importe * (@PorcentajeImpuestos/100.0)

      SELECT @SumaImporte   = @SumaImporte   + ISNULL(@Importe, 0),
             @SumaRetencion = @SumaRetencion + ISNULL(@Retencion, 0) + ISNULL(@Retencion2, 0) + ISNULL(@Retencion3, 0),
             @SumaImpuestos = @SumaImpuestos + ISNULL(@Impuestos, 0)

      INSERT GastoD (ID,  Renglon,  Concepto,  Fecha,         Referencia,  Cantidad,  Precio,  Importe,  Retencion,  Retencion2,  Retencion3,  Impuestos,  Sucursal)
             VALUES (@ID, @Renglon, @Concepto, @FechaEmision, @Referencia, @Cantidad, @Precio, @Importe, @Retencion, @Retencion2, @Retencion3, @Impuestos, @Sucursal)
    END
    FETCH NEXT FROM crEmbarqueArt INTO @EmbarqueModulo, @Agrupador, @Cantidad, @CostoTotal
  END 
  CLOSE crEmbarqueArt
  DEALLOCATE crEmbarqueArt

  IF @SumaRetencion > 0.0 SELECT @TieneRetencion = 1 ELSE SELECT @TieneRetencion = 0
  UPDATE Gasto
     SET TieneRetencion = @TieneRetencion, Importe = @SumaImporte, Retencion = @SumaRetencion, Impuestos = @SumaImpuestos
   WHERE ID = @ID

  IF @Afectar = 1
  BEGIN
    IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID)
      EXEC spGasto @ID, 'GAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
    ELSE
      DELETE Gasto WHERE ID = @ID
  END
     
  RETURN
END
GO

/**************** spGastoAnexoTarifaProrrateo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoAnexoTarifaProrrateo') and sysstat & 0xf = 4) drop procedure dbo.spGastoAnexoTarifaProrrateo
GO             
CREATE PROCEDURE spGastoAnexoTarifaProrrateo
			@OrigenID	int,
			@ID		int,
		        @Renglon	float,
			@RenglonSub	int,
			@Concepto	varchar(50),
			@Agrupador	varchar(50),
			@CostoTotal	money,
		        @Modulo		char(10) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CentroCostos	varchar(20),
    @Sucursal		int,
    @Costo		money,
    @Porcentaje		float

  DECLARE crEmbarqueSucursal CURSOR FOR
   SELECT e.SucursalOrigen, SUM(e.Cantidad*e.Costo)
     FROM EmbarqueSucursalOrigen e, Art a
    WHERE e.EmbarqueID = @OrigenID AND e.Articulo = a.Articulo AND UPPER(e.Tipo) NOT IN ('DESEMBARCAR', 'PENDIENTE')
      AND a.Familia = @Agrupador
      AND e.Modulo = ISNULL(@Modulo, e.Modulo)
    GROUP BY e.SucursalOrigen
    ORDER BY e.SucursalOrigen

  OPEN crEmbarqueSucursal
  FETCH NEXT FROM crEmbarqueSucursal INTO @Sucursal, @Costo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @CentroCostos = NULL
      SELECT @CentroCostos = NULLIF(RTRIM(CentroCostos), '') FROM Sucursal WHERE Sucursal = @Sucursal
      IF @CostoTotal = 0 
        SELECT @Porcentaje = 0
      ELSE
        SELECT @Porcentaje = (@Costo * 100) / @CostoTotal

      INSERT GastoDProrrateo (Sucursal,  ID,  Renglon,  RenglonSub,  Concepto,  SucursalProrrateo, ContUso,       Porcentaje)
                      VALUES (@Sucursal, @ID, @Renglon, @RenglonSub, @Concepto, @Sucursal,         @CentroCostos, @Porcentaje)
    END
    FETCH NEXT FROM crEmbarqueSucursal INTO @Sucursal, @Costo
  END 
  CLOSE crEmbarqueSucursal
  DEALLOCATE crEmbarqueSucursal

  RETURN
END
GO

/**************** spGastoDProrrateo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoDProrrateo') and type = 'P') drop procedure dbo.spGastoDProrrateo
GO
CREATE PROCEDURE spGastoDProrrateo
		   @Empresa		char(5),
		   @Sucursal		int,
		   @ID			int,
		   @Renglon		float,
		   @RenglonSub		int,
		   @Concepto		varchar(50),
		   @Importe		money,
		   @ContUso		varchar(20),
                   @Espacio		char(10),
		   @Ok			int		= NULL OUTPUT,
		   @OkRef		varchar(255)	= NULL OUTPUT,
		   @ContUso2		varchar(20)	= NULL,
		   @ContUso3		varchar(20)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Total		float,
    @RedondeoMonetarios int,
    @Clase		varchar(50),
    @SubClase		varchar(50)

  SELECT @Clase = Clase, @SubClase = NULLIF(RTRIM(SubClase), '') FROM Gasto WHERE ID = @ID

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  SELECT @ContUso  = NULLIF(RTRIM(@ContUso), ''),
         @ContUso2 = NULLIF(RTRIM(@ContUso2), ''),
         @ContUso3 = NULLIF(RTRIM(@ContUso3), ''),
         @Espacio  = NULLIF(RTRIM(@Espacio), '')
  IF @ContUso  = '0' SELECT @ContUso  = NULL
  IF @ContUso2 = '0' SELECT @ContUso2 = NULL
  IF @ContUso3 = '0' SELECT @ContUso3 = NULL
  IF @Espacio  = '0' SELECT @Espacio  = NULL
  IF NOT EXISTS(SELECT * FROM GastoDProrrateo WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto)
  BEGIN
    INSERT GastoDProrrateo (
    	     Sucursal,  ID,  Renglon,  RenglonSub,  Concepto,  ContUso,                       ContUso2,                        ContUso3,                        VIN,          Espacio,                            SucursalProrrateo, Proyecto,          UEN,          Actividad,          AFArticulo,          AFSerie,          Porcentaje)
      SELECT @Sucursal, @ID, @Renglon, @RenglonSub, @Concepto, ISNULL(CCProrrateo, @ContUso), ISNULL(CC2Prorrateo, @ContUso2), ISNULL(CC3Prorrateo, @ContUso3), VINProrrateo, ISNULL(EspacioProrrateo, @Espacio), SucursalProrrateo, ProyectoProrrateo, UENProrrateo, ActividadProrrateo, AFArticuloProrrateo, AFSerieProrrateo, Porcentaje 
        FROM ConceptoProrrateo 
       WHERE Modulo = 'GAS' AND Concepto = @Concepto AND NULLIF(RTRIM(UPPER(EmpresaProrrateo)), '') IN (NULL, '(TODAS)', @Empresa)
    IF @@ROWCOUNT = 0
      INSERT GastoDProrrateo (
      	      Sucursal,  ID,  Renglon,  RenglonSub,  Concepto,  ContUso,                       ContUso2,                        ContUso3,                        VIN,          Espacio,                            SucursalProrrateo, Proyecto,          UEN,          Actividad,          AFArticulo,          AFSerie,          Porcentaje)
       SELECT @Sucursal, @ID, @Renglon, @RenglonSub, @Concepto, ISNULL(CCProrrateo, @ContUso), ISNULL(CC2Prorrateo, @ContUso2), ISNULL(CC3Prorrateo, @ContUso3), VINProrrateo, ISNULL(EspacioProrrateo, @Espacio), SucursalProrrateo, ProyectoProrrateo, UENProrrateo, ActividadProrrateo, AFArticuloProrrateo, AFSerieProrrateo, Porcentaje 
         FROM ClaseProrrateo 
        WHERE Modulo = 'GAS' AND Clase = @Clase AND ISNULL(SubClase, '') = ISNULL(@SubClase, '') AND NULLIF(RTRIM(UPPER(EmpresaProrrateo)), '') IN (NULL, '(TODAS)', @Empresa)
  END
  UPDATE GastoDProrrateo
     SET Importe = NULLIF(ROUND(@Importe*(Porcentaje/100.0), @RedondeoMonetarios), 0)
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto

  SELECT @Total = 0.0
  SELECT @Total = ROUND(SUM(Porcentaje), @RedondeoMonetarios) FROM GastoDProrrateo WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto 
  IF @Total NOT IN (0.0, 100.0) SELECT @Ok = 30520, @OkRef = @Concepto
  RETURN
END
GO

/**************** spGastoDProrrateoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoDProrrateoFechas') and type = 'P') drop procedure dbo.spGastoDProrrateoFechas
GO
CREATE PROCEDURE spGastoDProrrateoFechas
		   @Empresa		char(5),
		   @Sucursal		int,
		   @ID			int,
		   @Renglon		float,
		   @RenglonSub		int,
		   @Concepto		varchar(50),
		   @ImporteTotal	money,
		   @FechaD		datetime,
		   @FechaA		datetime,
		   @MetodoProrrateo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mes		int,
    @Ano		int,
    @Dia		int,
    @Dias		int,
    @DiasMes		int,
    @a			int,
    @Saldo		money,
    @Fecha		datetime,
    @Porcentaje		float,
    @Importe		float,
    @ImporteDia		float,
    @Meses		float,
    @RedondeoMonetarios int

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  SELECT @Meses = DATEDIFF(month, @FechaD, @FechaA) + 1,
         @Dias  = DATEDIFF(day,   @FechaD, @FechaA) + 1

  DELETE GastoDProrrateo 
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto

  SELECT @ImporteDia = @ImporteTotal/@Dias, @Saldo = @ImporteTotal, @Fecha = @FechaD, @a = 1
  SELECT @Importe = ROUND(@ImporteTotal/NULLIF(@Meses, 0), @RedondeoMonetarios)
  WHILE @a <= @Meses
  BEGIN
    IF UPPER(@MetodoProrrateo) = 'PROPORCIONAL POR DIA'
    BEGIN
      SELECT @Dia = DATEPART(day, @Fecha), @Mes = DATEPART(month, @Fecha), @Ano = DATEPART(year, @Fecha)
      EXEC spDiasMes @Mes, @Ano, @DiasMes OUTPUT
      IF @a = 1 
        SELECT @Importe = (@DiasMes - @Dia + 1) * @ImporteDia
      ELSE 
        SELECT @Importe = @DiasMes * @ImporteDia
    END

    IF @a = @Meses SELECT @Importe = @Saldo
    INSERT GastoDProrrateo 
           (Sucursal, ID,  Renglon,  RenglonSub,  Concepto,  Fecha,  Importe,  Porcentaje)
    SELECT @Sucursal, @ID, @Renglon, @RenglonSub, @Concepto, @Fecha, @Importe, (@Importe/CONVERT(float, @ImporteTotal))*100.0
    SELECT @Saldo = @Saldo - @Importe, @a = @a + 1
    SELECT @Fecha = DATEADD(month, 1, @Fecha)
    EXEC spPrimerDiaMes @Fecha OUTPUT
  END
  RETURN
END
GO

/**************** spGastoDProrrateoFechas2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoDProrrateoFechas2') and type = 'P') drop procedure dbo.spGastoDProrrateoFechas2
GO
CREATE PROCEDURE spGastoDProrrateoFechas2
		   @Empresa		char(5),
		   @Sucursal		int,
		   @ID			int,
		   @Renglon		float,
		   @RenglonSub		int,
		   @Concepto		varchar(50),
		   @FechaD		datetime,
		   @FechaA		datetime,
		   @MetodoProrrateo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mes		int,
    @Ano		int,
    @Dia		int,
    @Dias		int,
    @DiasMes		int,
    @a			int,
    @Saldo		money,
    @Fecha		datetime,
    @Porcentaje		float,
    @Importe		float,
    @ImporteDia		float,
    @Meses		float,
    @RedondeoMonetarios int,
    @ImporteTotal	money

  DECLARE
    @GastoDProrrateo TABLE (SucursalProrrateo int NULL, ContUso varchar(20) NULL, ContUso2 varchar(20) NULL, ContUso3 varchar(20) NULL, Proyecto varchar(50) NULL, UEN int NULL, VIN varchar(20) NULL, Actividad varchar(100) NULL, AFArticulo varchar(20) NULL, AFSerie varchar(20) NULL, Fecha datetime NULL, Porcentaje float NULL, ImporteDia money NULL, Saldo money NULL, Importe money NULL)

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  SELECT @Meses = DATEDIFF(month, @FechaD, @FechaA) + 1,
         @Dias  = DATEDIFF(day,   @FechaD, @FechaA) + 1

  INSERT @GastoDProrrateo (
         SucursalProrrateo, ContUso, ContUso2, ContUso3, Proyecto, UEN, VIN, Actividad, AFArticulo, AFSerie, Fecha, Porcentaje, Saldo,   ImporteDia,    Importe)
  SELECT SucursalProrrateo, ContUso, ContUso2, ContUso3, Proyecto, UEN, VIN, Actividad, AFArticulo, AFSerie, Fecha, Porcentaje, Importe, Importe/@Dias, ROUND(Importe/NULLIF(@Meses, 0), @RedondeoMonetarios)
    FROM GastoDProrrateo
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto
  SELECT @ImporteTotal = SUM(Saldo) FROM @GastoDProrrateo

  DELETE GastoDProrrateo 
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub AND Concepto = @Concepto

  SELECT @Fecha = @FechaD, @a = 1
  WHILE @a <= @Meses
  BEGIN
    IF UPPER(@MetodoProrrateo) = 'PROPORCIONAL POR DIA'
    BEGIN
      SELECT @Dia = DATEPART(day, @Fecha), @Mes = DATEPART(month, @Fecha), @Ano = DATEPART(year, @Fecha)
      EXEC spDiasMes @Mes, @Ano, @DiasMes OUTPUT
      IF @a = 1 
        UPDATE @GastoDProrrateo SET Importe = (@DiasMes - @Dia + 1) * ImporteDia
      ELSE 
        UPDATE @GastoDProrrateo SET Importe = @DiasMes * ImporteDia
    END
    IF @a = @Meses UPDATE @GastoDProrrateo SET Importe = Saldo
    INSERT GastoDProrrateo (
           SucursalProrrateo, ContUso, ContUso2, ContUso3, Proyecto, UEN, VIN, Actividad, AFArticulo, AFSerie, Sucursal,  ID,  Renglon,  RenglonSub,  Concepto,  Fecha,  Importe, Porcentaje)
    SELECT SucursalProrrateo, ContUso, ContUso2, ContUso3, Proyecto, UEN, VIN, Actividad, AFArticulo, AFSerie, @Sucursal, @ID, @Renglon, @RenglonSub, @Concepto, @Fecha, Importe, (Importe/CONVERT(float, @ImporteTotal))*100.0
      FROM @GastoDProrrateo

    UPDATE @GastoDProrrateo 
       SET Saldo = Saldo - Importe

    SELECT @a = @a + 1
    SELECT @Fecha = DATEADD(month, 1, @Fecha)
    EXEC spPrimerDiaMes @Fecha OUTPUT
  END
  RETURN
END
GO

-- 11042
/**************** spAFGenerarGastoInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAFGenerarGastoInfo') and sysstat & 0xf = 4) drop procedure dbo.spAFGenerarGastoInfo
GO             
CREATE PROCEDURE spAFGenerarGastoInfo
			@Empresa				varchar(5),
			@Mov					varchar(20),
			@GastoConcepto	 		varchar(50)	OUTPUT,
			@GastoFactor			float		OUTPUT,
			@GastoMov				varchar(20)	OUTPUT,
			@GastoAcreedor			varchar(10)	OUTPUT,
			@GastoClase				varchar(50)	OUTPUT,
			@GastoSubClase			varchar(50)	OUTPUT,
			@AFGenerarGastoCfg		varchar(20)	OUTPUT,
			@AFMovGenerarGastoCfg	varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @AFGenerarGastoCfg = AFGenerarGastoCfg FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @AFMovGenerarGastoCfg = AFMovGenerarGastoCfg
    FROM MovTipo
   WHERE Modulo = 'AF' AND Mov = @Mov
     
  IF @AFGenerarGastoCfg = 'Empresa'
  BEGIN
    SELECT @GastoMov = NULLIF(LTRIM(RTRIM(GastoDepreciacion)), '') FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
    SELECT @GastoAcreedor = NULLIF(LTRIM(RTRIM(AFAcreedorDepreciacion)), ''), @GastoConcepto = NULLIF(LTRIM(RTRIM(AFConceptoDepreciacion)), '') FROM EmpresaCfg WHERE Empresa = @Empresa
    
    SELECT @GastoClase = NULLIF(LTRIM(RTRIM(Clase)), ''), @GastoSubClase = NULLIF(LTRIM(RTRIM(SubClase)), '') FROM Concepto WHERE Concepto = @GastoConcepto AND Modulo = 'GAS'
  END
  ELSE
  BEGIN
    IF @AFMovGenerarGastoCfg = 'Especifico'
    BEGIN
      SELECT @GastoFactor = GastoFactor, @GastoMov = NULLIF(LTRIM(RTRIM(GastoMov)), ''), @GastoAcreedor = NULLIF(LTRIM(RTRIM(GastoAcreedor)), ''), @GastoClase = NULLIF(LTRIM(RTRIM(GastoClase)), ''), @GastoSubClase = NULLIF(LTRIM(RTRIM(GastoSubClase)), ''), @GastoConcepto = NULLIF(LTRIM(RTRIM(GastoConcepto)), '')
        FROM MovTipo
       WHERE Modulo = 'AF' AND Mov = @Mov
    END
    ELSE
    BEGIN
      SELECT @GastoFactor = GastoFactor, @GastoMov = NULLIF(LTRIM(RTRIM(GastoMov)), ''), @GastoAcreedor = NULLIF(LTRIM(RTRIM(GastoAcreedor)), ''), @GastoClase = NULL, @GastoSubClase = NULL, @GastoConcepto = NULL
        FROM MovTipo
       WHERE Modulo = 'AF' AND Mov = @Mov    
    END
  END
  
END
GO

-- 11042
/**************** spAFGenerarGastoD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAFGenerarGastoD') and sysstat & 0xf = 4) drop procedure dbo.spAFGenerarGastoD
GO
CREATE PROCEDURE spAFGenerarGastoD
			@Empresa				varchar(5),
			@Mov					varchar(20), 
			@ID						int, 
			@GastoID				int,
			@MovTipo				varchar(20), 
			@Concepto				varchar(50), 
			@GastoFactor			float, 
			@AFGenerarGastoCfg		varchar(20),
			@AFMovGenerarGastoCfg	varchar(20),
			@Ok						int			OUTPUT,
			@OkRef					varchar(255)OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF (@AFGenerarGastoCfg = 'Empresa') OR(@AFGenerarGastoCfg = 'Movimiento' AND @AFMovGenerarGastoCfg = 'Especifico')
  BEGIN
    IF @MovTipo IN('AF.DP', 'AF.DT')
      INSERT INTO #GastoD(
			   ID,       Concepto,  Cantidad, Precio,              Importe,             Impuestos,        PorcentajeDeducible, UEN,    Proyecto)
        SELECT @GastoID, @Concepto, 1,        SUM(d.Depreciacion), SUM(d.Depreciacion), SUM(d.Impuestos), PorcentajeDeducible, af.UEN, af.Proyecto
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID
          JOIN Concepto ON Concepto.Concepto = @Concepto AND Modulo = 'GAS'
         WHERE d.ID = @ID
        GROUP BY PorcentajeDeducible, af.UEN, af.Proyecto, af.ContUso, af.ContUso2, af.ContUso3
    ELSE
      INSERT INTO #GastoD(
			   ID,       Concepto,  Cantidad, Precio,         Importe,        Impuestos,        PorcentajeDeducible, UEN,    Proyecto)
        SELECT @GastoID, @Concepto, 1,        SUM(d.Importe), SUM(d.Importe), SUM(d.Impuestos), PorcentajeDeducible, af.UEN, af.Proyecto
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID
          JOIN Concepto ON Concepto.Concepto = @Concepto AND Modulo = 'GAS'
         WHERE d.ID = @ID
        GROUP BY PorcentajeDeducible, af.UEN, af.Proyecto, af.ContUso, af.ContUso2, af.ContUso3

    UPDATE Gasto SET AF = 0, AFArticulo = NULL, AFSerie = NULL WHERE ID = @GastoID -- BUG13486
  END
  ELSE IF @AFGenerarGastoCfg = 'Movimiento' AND @AFMovGenerarGastoCfg = 'Categoria'
  BEGIN
    IF @MovTipo IN('AF.DP', 'AF.DT')
      INSERT INTO #GastoD(
			   ID,       Categoria,   Concepto,   Cantidad, Precio,			     Importe,             Impuestos,        PorcentajeDeducible,   UEN,    Proyecto)
        SELECT @GastoID, a.Categoria, m.Concepto, 1,        SUM(d.Depreciacion), SUM(d.Depreciacion), SUM(d.Impuestos), c.PorcentajeDeducible, af.UEN, af.Proyecto
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID
          JOIN ActivoF a ON d.Articulo = a.Articulo AND d.Serie = a.Serie
          LEFT OUTER JOIN MovTipoAFConceptoGAS m ON a.Categoria = m.Categoria AND m.Mov = @Mov
          LEFT OUTER JOIN Concepto c ON m.Concepto = c.Concepto AND Modulo = 'GAS'
         WHERE d.ID  = @ID
        GROUP BY a.Categoria, m.Concepto, c.PorcentajeDeducible, af.UEN, af.Proyecto
    ELSE
      INSERT INTO #GastoD(
			   ID,       Categoria,   Concepto,   Cantidad, Precio,         Importe,        Impuestos,        PorcentajeDeducible,   UEN,    Proyecto)
        SELECT @GastoID, a.Categoria, m.Concepto, 1,        SUM(d.Importe), SUM(d.Importe), SUM(d.Impuestos), c.PorcentajeDeducible, af.UEN, af.Proyecto
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID
          JOIN ActivoF a ON d.Articulo = a.Articulo AND d.Serie = a.Serie
          LEFT OUTER JOIN MovTipoAFConceptoGAS m ON a.Categoria = m.Categoria AND m.Mov = @Mov
          LEFT OUTER JOIN Concepto c ON m.Concepto = c.Concepto AND Modulo = 'GAS'
         WHERE d.ID  = @ID
        GROUP BY a.Categoria, m.Concepto, c.PorcentajeDeducible, af.UEN, af.Proyecto

    UPDATE Gasto SET AF = 0, AFArticulo = NULL, AFSerie = NULL WHERE ID = @GastoID -- BUG13486

    IF EXISTS(SELECT ID FROM #GastoD WHERE Concepto IS NULL)
      SELECT @Ok = 10115, @OkRef = Categoria FROM #GastoD WHERE Concepto IS NULL
  END
  ELSE IF @AFGenerarGastoCfg = 'Movimiento' AND @AFMovGenerarGastoCfg = 'Activo Fijo'
  BEGIN
    IF @MovTipo IN('AF.DP', 'AF.DT')  
      INSERT INTO #GastoD(
			   ID,       Articulo,   Serie,   Concepto,   Cantidad, Precio,              Importe,             Impuestos,        PorcentajeDeducible,   UEN,    Proyecto,    ContUso,        ContUso2,   ContUso3,   Impuesto1,     Impuesto2,     Impuesto3,     Retencion,     Retencion2,     Retencion3)    
        SELECT @GastoID, a.Articulo, a.Serie, m.Concepto, 1,        SUM(d.Depreciacion), SUM(d.Depreciacion), SUM(d.Impuestos), c.PorcentajeDeducible, af.UEN, af.Proyecto, a.CentroCostos, a.ContUso2, a.ContUso3, Art.Impuesto1, Art.Impuesto2, Art.Impuesto3, Art.Retencion1, Art.Retencion2, Art.Retencion3
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID        
          JOIN ActivoF a ON d.Articulo = a.Articulo AND d.Serie = a.Serie
          JOIN Art       ON a.Articulo = Art.Articulo
          LEFT OUTER JOIN MovTipoAFConceptoGAS m ON a.Articulo = m.Articulo AND a.Serie = m.Serie AND m.Mov = @Mov
          LEFT OUTER JOIN Concepto c ON m.Concepto = c.Concepto AND Modulo = 'GAS'
         WHERE d.ID  = @ID
        GROUP BY a.Articulo, a.Serie, m.Concepto, c.PorcentajeDeducible, af.UEN, af.Proyecto, a.CentroCostos, a.ContUso2, a.ContUso3, Art.Impuesto1, Art.Impuesto2, Art.Impuesto3, Art.Retencion1, Art.Retencion2, Art.Retencion3
    ELSE
      INSERT INTO #GastoD(
			   ID,       Articulo,   Serie,   Concepto,   Cantidad, Precio,         Importe,        Impuestos,        PorcentajeDeducible,   UEN,    Proyecto,    ContUso,        ContUso2,   ContUso3,   Impuesto1,     Impuesto2,     Impuesto3,     Retencion,     Retencion2,     Retencion3)    
        SELECT @GastoID, a.Articulo, a.Serie, m.Concepto, 1,        SUM(d.Importe), SUM(d.Importe), SUM(d.Impuestos), c.PorcentajeDeducible, af.UEN, af.Proyecto, a.CentroCostos, a.ContUso2, a.ContUso3, Art.Impuesto1, Art.Impuesto2, Art.Impuesto3, Art.Retencion1, Art.Retencion2, Art.Retencion3
          FROM ActivoFijoD d
          JOIN ActivoFijo af ON d.ID = af.ID        
          JOIN ActivoF a ON d.Articulo = a.Articulo AND d.Serie = a.Serie
          JOIN Art       ON a.Articulo = Art.Articulo
          LEFT OUTER JOIN MovTipoAFConceptoGAS m ON a.Articulo = m.Articulo AND a.Serie = m.Serie AND m.Mov = @Mov
          LEFT OUTER JOIN Concepto c ON m.Concepto = c.Concepto AND Modulo = 'GAS'
         WHERE d.ID  = @ID
        GROUP BY a.Articulo, a.Serie, m.Concepto, c.PorcentajeDeducible, af.UEN, af.Proyecto, a.CentroCostos, a.ContUso2, a.ContUso3, Art.Impuesto1, Art.Impuesto2, Art.Impuesto3, Art.Retencion1, Art.Retencion2, Art.Retencion3

    UPDATE Gasto  -- BUG13486
       SET Gasto.AF = 1, Gasto.AFArticulo = #GastoD.Articulo, Gasto.AFSerie = #GastoD.Serie 
      FROM #GastoD 
     WHERE Gasto.ID = @GastoID

    IF EXISTS(SELECT ID FROM #GastoD WHERE Concepto IS NULL)
      SELECT @Ok = 10115, @OkRef = RTRIM(Articulo) + ' - ' + RTRIM(Serie) FROM #GastoD WHERE Concepto IS NULL
  END  
END
GO

/**************** spGenerarGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarGasto') and sysstat & 0xf = 4) drop procedure dbo.spGenerarGasto
GO             
CREATE PROCEDURE spGenerarGasto
			@Accion		char(20),
		   	@Empresa	char(5),
		   	@Sucursal	int,
			@Usuario	char(10),
			@Modulo		char(5),
			@ID		int,
			@Mov		char(20),
			@MovID		varchar(20),
			@FechaEmision	datetime,
			@FechaRegistro	datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT,
			@CRMovimiento	varchar(20) = NULL,
			@MovTipo	varchar(20) = NULL,
			@MovTipoGenerarGasto bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgImpRetencionConcepto		BIT,
    @TieneRetencion					BIT,
    @GastoID		 				INT,
    @GastoMov		 				CHAR(20),
    @GastoMovID		 				VARCHAR(20),
    @GastoClase		 				VARCHAR(50),
    @GastoSubClase	 				VARCHAR(50),
    @GastoConcepto	 				VARCHAR(50),
    @GastoAcreedor	 				CHAR(10),
    @GastoFactor	 				FLOAT,     
    @Espacio		 				CHAR(10),
    @Acreedor		 				CHAR(10),
    @Concepto   	 				VARCHAR(50),
    @Referencia		 				VARCHAR(50),
    @PorcentajeDeducible 			FLOAT,
    @CfgRetencion2BaseImpuesto1		BIT,
    @Importe		 				MONEY,
    @Impuestos		 				MONEY,
    @Retencion		 				MONEY,
    @Retencion2		 				MONEY,
    -- 11042
    @Retencion3		 				MONEY,/*,
    @Fecha		 					datetime,
    @Moneda		 					char(10),
    @TipoCambio		 				float,
    @RenglonID		 				int*/
    @AFGenerarGastoCfg				VARCHAR(20),
    @AFMovGenerarGastoCfg			VARCHAR(20),
    @CentroCostos					VARCHAR(20)
    
  SELECT @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version   
  SELECT @GastoID = NULL
  SELECT @GastoMov = CASE  
                       WHEN @Modulo = 'CR' AND @CRMovimiento = 'Gasto' THEN GastoComprobante
                       WHEN @Modulo = 'CR' AND @CRMovimiento = 'Devolucion Gasto' THEN GastoDevComprobante
                       WHEN @Modulo = 'AF'    THEN GastoDepreciacion 
                       WHEN @Modulo = 'AGENT' THEN AgentPagoGastos
		       WHEN @Modulo = 'VTAS'  THEN VentaFacturaGasto
                       ELSE Gasto 
                     END 
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @Importe = NULL, @Impuestos = NULL, @Retencion = NULL, @Retencion2 = NULL, @Retencion3 = NULL
  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @GastoID = ID, @GastoMov = Mov, @GastoMovID = MovID 
      FROM Gasto 
     WHERE Empresa = @Empresa AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
  END ELSE
  BEGIN
    IF @MovTipoGenerarGasto = 1
    BEGIN
      SELECT @GastoFactor = GastoFactor, @GastoMov = GastoMov, @GastoAcreedor = GastoAcreedor, @GastoClase = GastoClase, @GastoSubClase = GastoSubClase, @GastoConcepto = NULLIF(RTRIM(GastoConcepto), '')
        FROM MovTipo
       WHERE Modulo = @Modulo AND Mov = @Mov

      SELECT @GastoConcepto = NULLIF(NULLIF(@GastoConcepto, '(Movimiento)'), '(Articulo)')

      IF @GastoAcreedor IS NULL AND @Modulo NOT IN('AF','AGENT') -- BUG13486
        SELECT @Ok = 10118
      ELSE 
      BEGIN
        SELECT @Acreedor = @GastoAcreedor

        IF @Modulo = 'INV'
        BEGIN
          INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,       Clase,       SubClase,       OrigenTipo, Origen, OrigenID, Prioridad, UEN,   Proyecto)
                SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @GastoAcreedor, @GastoClase, @GastoSubClase, @Modulo,    e.Mov,  e.MovID, 'Normal',   e.UEN, e.Proyecto
                  FROM Inv e
                 WHERE e.ID = @ID
          SELECT @GastoID = SCOPE_IDENTITY()     
          IF @GastoID IS NOT NULL AND @Ok IS NULL
            IF UPPER(@GastoConcepto) IS NULL
              INSERT GastoD (ID,      Renglon,   Concepto,       Fecha,         Cantidad,                Precio,  Importe,                         Sucursal, ContUso)
                     SELECT @GastoID, d.Renglon, a.Descripcion1, @FechaEmision, d.Cantidad*@GastoFactor, d.Costo, d.Cantidad*d.Costo*@GastoFactor, @Sucursal, d.ContUso
                       FROM InvD d, Art a 
                      WHERE d.ID = @ID AND a.Articulo = d.Articulo        
            ELSE
              INSERT GastoD (ID,      Renglon,   Concepto,       Fecha,         Cantidad,                Precio,  Importe,                         Sucursal, ContUso)
                     SELECT @GastoID, d.Renglon, @GastoConcepto, @FechaEmision, d.Cantidad*@GastoFactor, d.Costo, d.Cantidad*d.Costo*@GastoFactor, @Sucursal, d.ContUso
                       FROM InvD d, Art a 
                      WHERE d.ID = @ID AND a.Articulo = d.Articulo        

        END ELSE
        IF @Modulo = 'DIN'
        BEGIN
          INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,       Clase,       SubClase,       OrigenTipo, Origen, OrigenID, Prioridad, UEN,   Proyecto)
                SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @GastoAcreedor, @GastoClase, @GastoSubClase, @Modulo,    e.Mov,  e.MovID, 'Normal',   e.UEN, e.Proyecto
                  FROM Dinero e
                 WHERE e.ID = @ID
          SELECT @GastoID = SCOPE_IDENTITY()     
          IF @GastoID IS NOT NULL AND @Ok IS NULL
            INSERT GastoD (ID,      Renglon, Concepto,                                                             Fecha,         Cantidad,     Precio,    Importe,                Impuestos,                Sucursal,  ContUso)
                   SELECT @GastoID, 2048.0,  ISNULL(@GastoConcepto, ISNULL(NULLIF(RTRIM(e.Concepto), ''), e.Mov)), @FechaEmision, @GastoFactor, e.Importe, e.Importe*@GastoFactor, e.Impuestos*@GastoFactor, @Sucursal, e.ContUso
                     FROM Dinero e
                    WHERE e.ID = @ID
        END ELSE
        IF @Modulo = 'CXC'
        BEGIN
          INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,       Clase,       SubClase,       OrigenTipo, Origen, OrigenID, Prioridad, UEN,   Proyecto)
                SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @GastoAcreedor, @GastoClase, @GastoSubClase, @Modulo,    e.Mov,  e.MovID, 'Normal',   e.UEN, e.Proyecto
                  FROM Cxc e
                 WHERE e.ID = @ID
          SELECT @GastoID = SCOPE_IDENTITY()     
          IF @GastoID IS NOT NULL AND @Ok IS NULL
            INSERT GastoD (ID,      Renglon, Concepto,                                                             Fecha,         Cantidad,     Precio,    Importe,                Impuestos,                Sucursal,  ContUso)
                   SELECT @GastoID, 2048.0,  ISNULL(@GastoConcepto, ISNULL(NULLIF(RTRIM(e.Concepto), ''), e.Mov)), @FechaEmision, @GastoFactor, e.Importe, e.Importe*@GastoFactor, e.Impuestos*@GastoFactor, @Sucursal, e.ContUso
                     FROM Cxc e
                    WHERE e.ID = @ID
        END ELSE
        IF @Modulo = 'CR'
        BEGIN
          INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,                          Clase,       SubClase,       FormaPago,       OrigenTipo, Origen, OrigenID, CtaDinero, Prioridad, UEN,    Proyecto)
                SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    NULLIF(RTRIM(cfg.CRAcreedor), ''), cfg.CRClase, cfg.CRSubClase, cfg.CRFormaPago, @Modulo,    Mov,    MovID,    cr.Caja,   'Normal',  cr.UEN, cr.Proyecto
                  FROM CR, EmpresaCfg cfg
                 WHERE cr.ID = @ID AND cfg.Empresa = @Empresa
          SELECT @GastoID = SCOPE_IDENTITY()     
          IF (SELECT Acreedor FROM Gasto WHERE ID = @GastoID) IS NULL SELECT @Ok = 10117
          IF @GastoID IS NOT NULL AND @Ok IS NULL
            INSERT GastoD (ID,      Renglon,   Concepto,   Fecha,         Referencia,   Cantidad,  Precio,    Importe,                                      Impuestos,                                                                   Sucursal,  PorcentajeDeducible)
                   SELECT @GastoID, d.Renglon, d.Concepto, @FechaEmision, d.Referencia, 1,         d.Importe, d.Importe/(1+(ISNULL(c.Impuestos, 0)/100.0)), d.Importe/(1+(ISNULL(c.Impuestos, 0)/100.0))*(ISNULL(c.Impuestos, 0)/100.0), @Sucursal, ISNULL(c.PorcentajeDeducible, 0.0)
                     FROM CRCaja d, Concepto c
                    WHERE d.ID = @ID AND d.Movimiento = @CRMovimiento
                      AND c.Modulo = 'GAS' AND c.Concepto = d.Concepto
        END ELSE
        IF @Modulo = 'VTAS'
        BEGIN
          SELECT @Espacio = NULLIF(RTRIM(Espacio), ''), @Concepto = NULLIF(RTRIM(GastoConcepto), ''), @Acreedor = NULLIF(RTRIM(GastoAcreedor), '') FROM Venta WHERE ID = @ID
          IF @Concepto IS NULL OR @Acreedor IS NULL
            SELECT @Ok = 10115
          ELSE BEGIN
            SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)
            /*IF @MovTipo = 'VTAS.FX'
              SELECT @Importe = SUM(CostoTotal), @Impuestos = SUM(CostoTotal*(Impuesto1/100.0)) FROM VentaTCalc WHERE ID = @ID
            ELSE*/
              SELECT @Importe = SUM(SubTotal), @Impuestos = SUM(Impuestos) FROM VentaTCalc WHERE ID = @ID
            INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,  Clase,   SubClase,   Condicion,   OrigenTipo, Origen, OrigenID, Prioridad, UEN,   Proyecto)
                  SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @Acreedor, c.Clase, c.SubClase, p.Condicion, @Modulo,    Mov,    MovID,    'Normal',  m.UEN, m.Proyecto
                    FROM Venta m, Concepto c, Prov p
                   WHERE m.ID = @ID AND c.Modulo = 'GAS' AND c.Concepto = m.GastoConcepto AND p.Proveedor = m.GastoAcreedor
            SELECT @GastoID = SCOPE_IDENTITY()
          END
        END ELSE
        IF @Modulo = 'AF'
        BEGIN
          EXEC spAFGenerarGastoInfo @Empresa, @Mov, @Concepto OUTPUT, @GastoFactor OUTPUT, @GastoMov OUTPUT, @Acreedor OUTPUT, @GastoClase OUTPUT, @GastoSubClase OUTPUT, @AFGenerarGastoCfg OUTPUT, @AFMovGenerarGastoCfg OUTPUT

		  IF (SELECT Clave FROM MovTipo WHERE Mov = @GastoMov AND Modulo = 'GAS') = 'GAS.GTC' -- BUG13563
            SELECT @Ok = 35005, @OkRef = @GastoMov -- BUG13563
          ELSE IF (@AFGenerarGastoCfg = 'Empresa' AND @Concepto IS NULL) OR
			      (@AFGenerarGastoCfg = 'Movimiento' AND @AFMovGenerarGastoCfg = 'Especifico' AND @Concepto IS NULL) OR
			      (@AFGenerarGastoCfg = 'Movimiento' AND @GastoMov IS NULL) OR 
			      (@Acreedor IS NULL)
            SELECT @Ok = 10116
          ELSE BEGIN
            SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)

            INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,  Clase,       SubClase,       OrigenTipo, Origen, OrigenID, Prioridad, UEN,   Proyecto,   Observaciones)
                  SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @Acreedor, @GastoClase, @GastoSubClase, @Modulo,    Mov,    MovID,    'Normal',  m.UEN, m.Proyecto, m.Observaciones
                    FROM ActivoFijo m, Prov p
                   WHERE m.ID = @ID AND p.Proveedor = @Acreedor            
            SELECT @GastoID = SCOPE_IDENTITY()
          END
        END ELSE
        IF @Modulo = 'AGENT' 
        BEGIN
		  		
          IF (SELECT Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) IN('AGENT.CO')
            SELECT @GastoMov = GastoOtrosIngresos FROM EmpresaCfgMov WHERE Empresa  = @Empresa
          IF (SELECT Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov) IN('AGENT.P')
            SELECT @GastoMov = AgentPagoGastos FROM EmpresaCFGMov WHERE Empresa  = @Empresa

          SELECT @Concepto = NULLIF(RTRIM(AgentConceptoGastos), ''), @CfgImpRetencionConcepto = AgentImpRetencionConcepto FROM EmpresaCfg2 WHERE Empresa = @Empresa
          SELECT @Acreedor = NULLIF(RTRIM(a.Acreedor), '') FROM Agente a, Agent m WHERE a.Agente = m.Agente AND m.ID = @ID
          
          SELECT @CentroCostos = CentroCostos FROM Prov WHERE Proveedor = @Acreedor
          
          EXEC xpGenerarGastoConceptoAcreedor @Modulo, @ID, @Acreedor OUTPUT, @Concepto OUTPUT
          IF @Concepto IS NULL OR @Acreedor IS NULL
            SELECT @Ok = 10116
          ELSE BEGIN
            SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)
            SELECT @Importe = Importe, @Impuestos = Impuestos, @Retencion = Retencion FROM Agent WHERE ID = @ID

            IF @CfgImpRetencionConcepto = 1        
              SELECT @Impuestos  = @Importe * (Impuestos/100.0),
                     @Retencion  = @Importe * (Retencion/100.0),
                     @Retencion2 = CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN @Importe * (Impuestos/100.0) * (Retencion2/100.0) ELSE @Importe * (Retencion2/100.0) END,
                     @Retencion3 = @Importe * (Retencion3/100.0)
                FROM Concepto
               WHERE Modulo = 'GAS' AND Concepto = @Concepto
            IF NULLIF(@Retencion, 0.0) IS NOT NULL OR NULLIF(@Retencion2, 0.0) IS NOT NULL SELECT @TieneRetencion = 1 ELSE SELECT @TieneRetencion = 0

            INSERT Gasto (Sucursal, Empresa,  Mov,       FechaEmision,  Moneda, TipoCambio, Usuario,  Estatus,      UltimoCambio, Acreedor,  Clase,   SubClase,   OrigenTipo, Origen, OrigenID, CtaDinero,   FormaPago,   TieneRetencion,  Prioridad, UEN,   Proyecto)
                  SELECT @Sucursal, @Empresa, @GastoMov, @FechaEmision, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @Acreedor, c.Clase, c.SubClase, @Modulo,    Mov,    MovID,    m.CtaDinero, m.FormaPago, @TieneRetencion, 'Normal',  m.UEN, m.Proyecto
                    FROM Agent m, Concepto c, Prov p
                   WHERE m.ID = @ID AND c.Modulo = 'GAS' AND c.Concepto = @Concepto AND p.Proveedor = @Acreedor
            SELECT @GastoID = SCOPE_IDENTITY()
          END
        END
        IF @Ok IS NULL
        BEGIN
          IF @GastoID IS NULL
            SELECT @Ok = 10110, @OkRef = @Modulo
          ELSE 
          BEGIN
            SELECT @PorcentajeDeducible = 0.0
            SELECT @PorcentajeDeducible = ISNULL(PorcentajeDeducible, 0.0) FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @Concepto
            
            IF @Modulo <> 'AF'
              INSERT GastoD (
                     ID,       Renglon,  Concepto,  Fecha,         Referencia,  Cantidad,  Precio,   Importe,  Impuestos,  Retencion,  Retencion2,  Retencion3,  Sucursal,  Espacio,  PorcentajeDeducible,  UEN, Proyecto, ContUso)
              SELECT @GastoID, 2048,     @Concepto, @FechaEmision, @Referencia, 1,         @Importe, @Importe, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Sucursal, @Espacio, @PorcentajeDeducible, UEN, Proyecto, @CentroCostos
                FROM Gasto
               WHERE ID = @GastoID
            ELSE
            BEGIN
              CREATE TABLE #GastoD(
			    ID						int, 
			    Renglon					int			IDENTITY(2048, 2048), 
			    Categoria				varchar(50) COLLATE Database_Default NULL, 
			    Articulo				varchar(20) COLLATE Database_Default NULL, 
			    Serie					varchar(20) COLLATE Database_Default NULL, 
			    Concepto				varchar(50) COLLATE Database_Default NULL, 
			    Cantidad				float		NULL, 
			    Precio					float		NULL, 
			    Importe					float		NULL, 
			    Impuestos				float		NULL, 
			    PorcentajeDeducible		float		NULL,
			    Impuesto1				float		NULL,
			    Impuesto2				float		NULL,
			    Impuesto3				float		NULL,
			    Retencion				float		NULL,
			    Retencion2				float		NULL,
			    Retencion3				float		NULL,
				Espacio					varchar(10)	COLLATE Database_Default NULL,							    
				UEN						int			NULL,
				Proyecto				varchar(50)	COLLATE Database_Default NULL,
				ContUso					varchar(20)	COLLATE Database_Default NULL,
				ContUso2				varchar(20)	COLLATE Database_Default NULL,
				ContUso3				varchar(20)	COLLATE Database_Default NULL
			    )

              EXEC spAFGenerarGastoD @Empresa, @Mov, @ID, @GastoID, @MovTipo, @Concepto, @GastoFactor, @AFGenerarGastoCfg, @AFMovGenerarGastoCfg, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

              IF @Ok IS NULL
                INSERT GastoD (
                       ID,       Renglon, Concepto,   Fecha,         Referencia,  Cantidad, Precio, Importe,   Retencion,   Retencion2,   Retencion3,   Impuestos,   Sucursal,  Espacio,  PorcentajeDeducible,   UEN,   Proyecto,   ContUso,   ContUso2,   ContUso3,   AFArticulo, AFSerie, Impuesto1, Impuesto2, Impuesto3)
                SELECT @GastoID, Renglon, d.Concepto, @FechaEmision, @Referencia, Cantidad, Precio, d.Importe, d.Retencion, d.Retencion2, d.Retencion3, d.Impuestos, @Sucursal, @Espacio, d.PorcentajeDeducible, d.UEN, d.Proyecto, d.ContUso, d.ContUso2, d.ContUso3, Articulo,   Serie,   Impuesto1, Impuesto2, Impuesto3
                  FROM #GastoD d
                  JOIN Gasto g ON d.ID = g.ID                  
            END
          END
        END
      END
    END
  END

  IF @GastoID IS NOT NULL AND @Ok IS NULL 
    EXEC xpGenerarGasto @GastoID, @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
  IF @GastoID IS NOT NULL AND @Ok IS NULL 
    EXEC spGasto @GastoID, 'GAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
  IF @GastoID IS NOT NULL AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) 
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'GAS', @GastoID, @GastoMov, @GastoMovID, @Ok OUTPUT

  RETURN
END
GO

PRINT "******************* SP GASTOS ******************"
GO



