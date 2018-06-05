/*
use matriz
set nocount on
DECLARE
  @Ok		int,
  @OkRef	varchar(255)
EXEC spContAutoManual 'VTAS', 238878, @Ok OUTPUT, @OkRef OUTPUT
SELECT @Ok, @OkRef

update dinero set contid = null WHERE ID = 4457
select ContID , Poliza , PolizaID , GenerarPoliza FROM Dinero WHERE ID = 4457

*/


/**************** fnContactoEspecifico ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoEspecifico') DROP FUNCTION fnContactoEspecifico
GO
CREATE FUNCTION fnContactoEspecifico (@ContAutoContactoEsp varchar(50), @Contacto varchar(10), @ContactoAplica varchar(10), @ContactoDetalle varchar(10), @Agente varchar(10), @Personal varchar(10), @CtaDinero varchar(10), @CtaDineroDestino varchar(10), @Almacen varchar(10), @AlmacenDestino varchar(10), @AlmacenDetalle varchar(10))
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado varchar(10)

  SELECT @Resultado = NULL
  SELECT @Resultado = 
    CASE UPPER(@ContAutoContactoEsp) 
         WHEN 'CONTACTO'		THEN @Contacto 
         WHEN 'CONTACTO APLICA'		THEN @ContactoAplica
         WHEN 'CONTACTO DETALLE'	THEN @ContactoDetalle
         WHEN 'CONTACTO ARRASTRE'	THEN @ContactoDetalle
         WHEN 'AGENTE'			THEN @Agente
         WHEN 'PERSONAL'		THEN @Personal
         WHEN 'CUENTA DINERO'		THEN @CtaDinero
         WHEN 'CUENTA DINERO DESTINO'   THEN @CtaDineroDestino
         WHEN 'ALMACEN'			THEN @Almacen
         WHEN 'ALMACEN DESTINO'		THEN @AlmacenDestino
         WHEN 'ALMACEN DETALLE'		THEN @AlmacenDetalle
     END
  RETURN(@Resultado)
END
GO

--REQ 13147
/**************** fnTipoContactoEspecifico ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoContactoEspecifico') DROP FUNCTION fnTipoContactoEspecifico
GO
CREATE FUNCTION fnTipoContactoEspecifico (@ContAutoContactoEsp varchar(50), @TipoContacto varchar(20))
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado varchar(20)

  SELECT @Resultado = NULL
  SELECT @Resultado = 
    CASE UPPER(@ContAutoContactoEsp) 
         WHEN 'AGENTE'			THEN 'Agente'
         WHEN 'PERSONAL'		THEN 'Personal'
         WHEN 'CUENTA DINERO'		THEN 'Cuenta Dinero'
         WHEN 'CUENTA DINERO DESTINO'   THEN 'Cuenta Dinero'
         WHEN 'ALMACEN'			THEN 'Almacen'
         WHEN 'ALMACEN DESTINO'		THEN 'Almacen'
         WHEN 'ALMACEN DETALLE'		THEN 'Almacen'
         ELSE @TipoContacto
     END
  RETURN(@Resultado)
END
GO

/************** spContAutoManual *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoManual') and type = 'P') drop procedure dbo.spContAutoManual
GO
CREATE PROCEDURE spContAutoManual
			@Modulo		char(5),
			@ID		int,
		   	@Ok		int		= NULL OUTPUT,
		   	@OkRef		varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @Sucursal			int,
    @Estatus			char(15), 
    @EstatusNuevo		char(15),
    @Usuario			char(10),
    @FechaEmision		datetime,
    @FechaRegistro 		datetime,
    @Mov			char(20),
    @MovID			varchar(20),
    @MovTipo			char(20),
    @ContMov			char(20),
    @UEN			int,
    @EstatusContabilizar	char(15),
    @EstatusMovTipo		char(15),
    @Mensaje			varchar(255),
	@ContAutoEmpresa	varchar(10)

  EXEC spMovInfo @ID, @Modulo, @Mov OUTPUT, @MovID OUTPUT, @Estatus OUTPUT, @Sucursal OUTPUT, @UEN OUTPUT
/*  SELECT @Mov = Mov, @MovID = MovID, @Estatus = Estatus, @Sucursal = Sucursal, @UEN = UEN
    FROM dbo.fnMovReg(@Modulo, @ID)*/

  SELECT @Empresa = Empresa,
         @Usuario = Usuario,
         @FechaRegistro = FechaRegistro,
         @FechaEmision = FechaEmision
    FROM Mov 
   WHERE Modulo = @Modulo AND ID = @ID

  SELECT @MovTipo = mc.Clave, 
         @EstatusContabilizar = NULLIF(RTRIM(mc.EstatusContabilizar), ''),
         @EstatusMovTipo = NULLIF(RTRIM(mt.EstatusContabilizar), ''),
         @ContMov = NULLIF(RTRIM(mc.ContMov), '')
    FROM MovTipo mt, MovClave mc
   WHERE mt.Modulo = @Modulo AND mt.Mov = @Mov AND mc.Clave = mt.Clave

  IF UPPER(@EstatusMovTipo) NOT IN (NULL, '(POR OMISION)') SELECT @EstatusContabilizar = @EstatusMovTipo
  SELECT @EstatusNuevo = @Estatus
  IF @ContMov IS NOT NULL AND @Estatus = @EstatusContabilizar 
  BEGIN
    BEGIN TRANSACTION
	  IF EXISTS (SELECT * FROM MovTipoContAuto WHERE Modulo=@Modulo AND Clave=@Mov AND Empresa=@Empresa)
		SELECT @ContAutoEmpresa=@Empresa
	  ELSE
		SELECT @ContAutoEmpresa='(Todas)'

      EXEC spContAuto @Empresa, @Sucursal, @Modulo,  @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @ContMov, @Ok OUTPUT, @OkRef OUTPUT, @ContAutoEmpresa

    IF @Ok IS NULL 
    BEGIN
      COMMIT TRANSACTION
      SELECT @Mensaje = NULL
    END ELSE
    BEGIN
      ROLLBACK TRANSACTION
      SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, RTRIM(@Mov)+' '+RTRIM(@MovID))) FROM MensajeLista WHERE Mensaje = @Ok
    END
  END
  SELECT @Mensaje
END
GO

/************** spContAutoRegistrar *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoRegistrar') and type = 'P') drop procedure dbo.spContAutoRegistrar
GO
CREATE PROCEDURE spContAutoRegistrar
                   @Empresa		  char(5),
		   @Sucursal		  int,
		   @Modulo		  char(5), 
		   @ID			  int, 			
		   @Estatus		  char(15), 
                   @EstatusNuevo	  char(15),
		   @Usuario		  char(10),
		   @FechaEmision	  datetime,
		   @FechaRegistro 	  datetime,
		   @Mov			  char(20),
		   @MovID		  varchar(20),
		   @MovTipo		  char(20),
		   @ContMov		  char(20),
    		   @ContMovID		  varchar(20),
    		   @ContMoneda		  char(10),
    		   @ContTipoCambio	  float,
    		   @Referencia		  varchar(50),
    		   @Concepto		  varchar(50), 
    		   @Proyecto		  varchar(50),
    		   @UEN			  int,
		   @Contacto		  varchar(10),
		   @ContactoTipo	  varchar(20),
		   @ContactoAplica	  varchar(20),
		   @Intercompania	  bit,
		   @OrigenMoneda	  varchar(10),
		   @OrigenTipoCambio	  float,
    		   @CfgPartidasSinImporte bit,
		   @CfgRegistro		  bit,

		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @ModuloInicial		char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @ContID			int,
    @Cuenta			char(20), 
    @SubCuenta			varchar(50),
    @SubCuenta2			varchar(50),    
    @SubCuenta3			varchar(50),	
    @ContactoEspecifico		varchar(10),
    @Articulo			varchar(20),
    @DepartamentoDetallista	int,
    @Presupuesto		bit,
    @AfectarPresupuesto		varchar(30),
    @DisminuirPresupuesto	bit,
    @SucursalContable   	int,
    @Debe			money, 
    @Haber			money,
    @SucursalOrigen		int,
    @RedondeoMonetarios		int,
	@Campo					varchar(20),
	@ContactoTipoEsp		varchar(20) --REQ 13147

  /** JH 08.08.2006 **/
  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  -- Bug 18308
  CREATE INDEX Presup ON #Poliza(Presupuesto)
  CREATE INDEX CuentaPresupuesto ON #Poliza(Cuenta,Presupuesto)
   
  SELECT @SucursalOrigen = Sucursal FROM Version
  SELECT @DisminuirPresupuesto = 0
  SELECT @AfectarPresupuesto = NULLIF(NULLIF(RTRIM(AfectarPresupuesto), ''), '(por Omision)') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov
  SELECT @AfectarPresupuesto = ISNULL(@AfectarPresupuesto, ISNULL(NULLIF(RTRIM(AfectarPresupuesto), ''), 'No')) FROM MovClave WHERE Clave = @MovTipo
  IF @AfectarPresupuesto <> 'No'
  BEGIN
    IF @AfectarPresupuesto = 'Desasignar'           	SELECT @AfectarPresupuesto = 'Asignar',           	@DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desreservar'          	SELECT @AfectarPresupuesto = 'Reservar',          	@DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desejercer Reservado' 	SELECT @AfectarPresupuesto = 'Ejercer Reservado', 	@DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desejercer Directo'   	SELECT @AfectarPresupuesto = 'Ejercer Directo',   	@DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Descomprometer Directo'   SELECT @AfectarPresupuesto = 'Comprometer Directo',     @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Descomprometer Reservado' SELECT @AfectarPresupuesto = 'Comprometer Reservado',   @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desdevengar Directo'   	SELECT @AfectarPresupuesto = 'Devengar Directo',        @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desdevengar Reservado'   	SELECT @AfectarPresupuesto = 'Devengar Reservado',      @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desdevengar Comprometido' SELECT @AfectarPresupuesto = 'Devengar Comprometido',   @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desejercer Comprometido'  SELECT @AfectarPresupuesto = 'Ejercer Comprometido',    @DisminuirPresupuesto = 1 ELSE
    IF @AfectarPresupuesto = 'Desejercer Devengado'   	SELECT @AfectarPresupuesto = 'Ejercer Devengado',       @DisminuirPresupuesto = 1 

    IF @DisminuirPresupuesto = 0
      INSERT #Poliza (Presupuesto, Cuenta, Debe)  SELECT 1, CuentaPresupuesto, Importe*@OrigenTipoCambio FROM MovPresupuesto WHERE Modulo = @Modulo AND ModuloID =  @ID
    ELSE
      INSERT #Poliza (Presupuesto, Cuenta, Haber) SELECT 1, CuentaPresupuesto, Importe*@OrigenTipoCambio FROM MovPresupuesto WHERE Modulo = @Modulo AND ModuloID =  @ID
  END

  IF EXISTS(SELECT * FROM #Poliza) 
  BEGIN
    INSERT Cont (OrigenTipo, Origen, OrigenID, Sucursal,  SucursalOrigen,  Empresa,  Mov,      FechaEmision,  FechaContable, Moneda,      TipoCambio,      Usuario,  Concepto,  Proyecto,  UEN,  Contacto,  ContactoTipo,  ContactoAplica,  Intercompania,  AfectarPresupuesto,  OrigenMoneda,  OrigenTipoCambio,  Referencia,  Estatus)
         VALUES (@Modulo,    @Mov,   @MovID,   @Sucursal, @SucursalOrigen, @Empresa, @ContMov, @FechaEmision, @FechaEmision, @ContMoneda, @ContTipoCambio, @Usuario, @Concepto, @Proyecto, @UEN, @Contacto, @ContactoTipo, @ContactoAplica, @Intercompania, @AfectarPresupuesto, @OrigenMoneda, @OrigenTipoCambio, @Referencia, 'SINAFECTAR')
    SELECT @ContID = SCOPE_IDENTITY()
    SELECT @Renglon = 0.0

    IF @EstatusNuevo = 'CANCELADO' 
      UPDATE #Poliza SET Debe = -Debe, Haber = -Haber

   -- Eliminar Centros de Costos no Requeridos
   IF (SELECT ContAutoEliminarCCNoReq FROM EmpresaGral WHERE Empresa = @Empresa) = 1
   BEGIN
     UPDATE #Poliza
        SET SubCuenta = NULL
       FROM #Poliza p
       JOIN Cta c ON c.Cuenta = p.Cuenta
      WHERE c.CentrosCostos = 0
      
     UPDATE #Poliza
        SET SubCuenta2 = NULL
       FROM #Poliza p
       JOIN Cta c ON c.Cuenta = p.Cuenta
      WHERE c.CentroCostos2 = 0

     UPDATE #Poliza
        SET SubCuenta3 = NULL
       FROM #Poliza p
       JOIN Cta c ON c.Cuenta = p.Cuenta
      WHERE c.CentroCostos3 = 0
      
   END   
   
   UPDATE #Poliza SET ContactoTipo = NULL WHERE ISNULL(ContactoEspecifico,'') = '' --REQ 13147

   
    DECLARE crPoliza CURSOR FOR
     /** JH 08.08.2006 **/
     -- Se esta redondeando al guardar la poliza 
     SELECT ISNULL(Presupuesto, 0), NULLIF(RTRIM(Cuenta), ''), NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(SubCuenta2), ''), NULLIF(RTRIM(SubCuenta3), ''), SucursalContable, NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(ContactoEspecifico), ''), NULLIF(RTRIM(Articulo), ''), NULLIF(DepartamentoDetallista, 0), ROUND(NULLIF(SUM(Debe), 0.0), @RedondeoMonetarios), ROUND(NULLIF(SUM(Haber), 0.0), @RedondeoMonetarios), Campo, ContactoTipo --REQ 13147
       FROM #Poliza
      GROUP BY Presupuesto, Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, SucursalContable, Concepto, ContactoEspecifico, Articulo, DepartamentoDetallista, Campo, ContactoTipo --REQ 13147
      ORDER BY Presupuesto, Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, SucursalContable, Concepto, ContactoEspecifico, Articulo, DepartamentoDetallista, Campo, ContactoTipo --REQ 13147

    OPEN crPoliza
    FETCH NEXT FROM crPoliza INTO @Presupuesto, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @SucursalContable, @Concepto, @ContactoEspecifico, @Articulo, @DepartamentoDetallista, @Debe, @Haber, @Campo, @ContactoTipoEsp --REQ 13147
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        IF @Cuenta IS NOT NULL AND (@CfgPartidasSinImporte = 1 OR (@Debe IS NOT NULL OR @Haber IS NOT NULL))
        BEGIN
          SELECT @Renglon = @Renglon + 2048
          IF @Debe  IS NOT NULL SELECT @Debe  = @Debe  / @ContTipoCambio
          IF @Haber IS NOT NULL SELECT @Haber = @Haber / @ContTipoCambio
          --IF @EstatusNuevo = 'CANCELADO' SELECT @Debe = -@Debe, @Haber = -@Haber
          INSERT ContD (Sucursal,  SucursalContable,  ID,      Renglon,  Presupuesto,  Cuenta,  SubCuenta,  SubCuenta2,  SubCuenta3,  Concepto,  ContactoEspecifico,  Articulo,  DepartamentoDetallista,  Debe,  Haber,  Campo,  ContactoTipo) --REQ 13147
                VALUES (@Sucursal, @SucursalContable, @ContID, @Renglon, @Presupuesto, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @Concepto, @ContactoEspecifico, @Articulo, @DepartamentoDetallista, @Debe, @Haber, @Campo, @ContactoTipoEsp) --REQ 13147
        END
      END
      FETCH NEXT FROM crPoliza INTO @Presupuesto, @Cuenta, @SubCuenta, @SubCuenta2, @SubCuenta3, @SucursalContable, @Concepto, @ContactoEspecifico, @Articulo, @DepartamentoDetallista, @Debe, @Haber, @Campo, @ContactoTipoEsp --REQ 13147
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crPoliza
    DEALLOCATE crPoliza

    IF @CfgRegistro = 1
      INSERT ContReg (
             ID, Empresa, Sucursal, Modulo, ModuloID, ModuloRenglon, ModuloRenglonSub, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, Haber)

      /** JH 08.08.2006 **/
      -- tambien aqui se guarda con el round
      --SELECT @ContID, @Empresa, SucursalContable, @Modulo, @ID, Renglon, RenglonSub, NULLIF(RTRIM(Cuenta), ''), NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(SubCuenta2), ''), NULLIF(RTRIM(SubCuenta3), ''), NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(ContactoEspecifico), ''), ROUND(Debe/@ContTipoCambio, @RedondeoMonetarios), ROUND(Haber/@ContTipoCambio, @RedondeoMonetarios) Antes del Bug17936 PGC 02.01.2014
	  SELECT @ContID, @Empresa, SucursalContable, @Modulo, @ID, Renglon, RenglonSub, NULLIF(RTRIM(Cuenta), ''), NULLIF(RTRIM(SubCuenta), ''), NULLIF(RTRIM(SubCuenta2), ''), NULLIF(RTRIM(SubCuenta3), ''), NULLIF(RTRIM(Concepto), ''), NULLIF(RTRIM(ContactoEspecifico), ''), ROUND(CONVERT(money, Debe/@ContTipoCambio),@RedondeoMonetarios), ROUND(CONVERT(money, Haber/@ContTipoCambio),@RedondeoMonetarios) --Correción: Bug17936 PGC 02.01.2014
        FROM #Poliza
       WHERE Presupuesto = 0

--  select Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable from ContD where id = @ContID
--select * from contd where id = @contid
--select @ok = 1
    -- Afectar
    EXEC spCont @ContID, 'CONT', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario,  1, 0,
        	@ContMov OUTPUT, @ContMovID OUTPUT,  NULL, @Ok OUTPUT, @OkRef OUTPUT, @ContAuto = 1, @ModuloInicial = @ModuloInicial
    IF @Ok IS NOT NULL 
      SELECT @OkRef = ISNULL(@OkRef, '')+' ('+RTRIM(Nombre)+' / '+RTRIM(@Mov)+' '+RTRIM(@MovID)+')'
        FROM Modulo WHERE Modulo = @Modulo

    DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
    IF @Ok = 50010 	-- La Poliza No Cuadra
    BEGIN
      INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable)
      SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable
        FROM ContD
       WHERE ID = @ContID
    END
    -- Registrar el Flujo	
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'CONT', @ContID, @ContMov, @ContMovID, @Ok OUTPUT
    EXEC spContAutoSetDatos @Empresa, @Modulo, @ID, @ContID, @ContMov, @ContMovID
  END
END
GO

/************** spContAuto *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAuto') and type = 'P') drop procedure dbo.spContAuto
GO
CREATE PROCEDURE spContAuto
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime,
		   @FechaRegistro 	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @ContMov		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @ContAutoEmpresa	varchar(10)	= '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Hoy			datetime,
    @FechaPoliza		datetime,
    @Referencia			varchar(50),
    @Concepto			varchar(50), 
    @Proyecto			varchar(50),
    @UEN			int,
    @Contacto			varchar(10),
    @ContactoTipo		varchar(20),
    @ContactoAplica		varchar(10),
    @ContID			int,
    @ContMovID			varchar(20),
    @ContMoneda			char(10),
    @ContTipoCambio		float,
    @ContContacto		varchar(10),
    @ContContactoTipo		varchar(20),
    @ContFechaEmision		datetime,
    @ContFechaContable		datetime,
    @SaveOk			int,
    @SaveOkRef			varchar(255),
    @CfgClaseConceptoGastos 	bit,
    @CfgPartidasSinImporte  	bit,
    @CfgRegistro		bit,
    @CfgConsolidacion   	bit,
    @CfgTipoFilial		varchar(20),
    @CfgCancelarMismoMes 	bit,
    @CfgContArticulo		bit,
    @GenerarPoliza		bit,
    @Poliza			varchar(20),
    @PolizaID			varchar(20),
    @ContSucursal		int, 
    @ContSucursalOrigen		int, 
    @ContEstatus		varchar(15),
    @PermitirCancelacionOrigen	bit,
    @PuedeEditar		bit,
    @CancelarID			int,
    @CancelarMov		char(20), 
    @CancelarMovID		varchar(20),
    @FechaTrabajo		datetime,
    @Intercompania		bit,
    @OrigenMoneda 		varchar(10), 
    @OrigenTipoCambio 		float,
    
    /* Variable para tener el modulo inicial*/
    @ModuloInicial      char(5)
    
  IF @Modulo = 'DIN'  SELECT @ModuloInicial = OrigenTipo FROM Dinero WHERE ID = @ID
  IF @Modulo = 'CXC'  SELECT @ModuloInicial = OrigenTipo FROM Cxc WHERE ID = @ID
  IF @Modulo = 'CXP'  SELECT @ModuloInicial = OrigenTipo FROM Cxp WHERE ID = @ID
  IF @Modulo = 'CONC' SELECT @ModuloInicial = @Modulo

  SELECT @SaveOk = @Ok, @SaveOkRef = @OkRef
  SELECT @Ok = NULL, @OkRef = NULL, @ContID = NULL, @Intercompania = 0, @OrigenMoneda = NULL, @OrigenTipoCambio = NULL
  SELECT @ContMoneda = cfg.ContMoneda, @ContTipoCambio = m.TipoCambio, @PermitirCancelacionOrigen = ISNULL(ContPermitirCancelacionOrigen, 0)
    FROM Mon m, EmpresaCfg cfg
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @CfgContArticulo = ISNULL(ContArticulo, 0)
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgCancelarMismoMes = ContAutoCancelarMismoMes
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @Hoy = @FechaRegistro
  EXEC spExtraerFecha @Hoy OUTPUT

  EXEC xpContAuto @Empresa, @Sucursal, @Modulo,  @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @ContMov, @Ok OUTPUT, @OkRef OUTPUT, @Referencia OUTPUT

  IF @EstatusNuevo = 'CANCELADO'
  BEGIN
    EXEC spContAutoGetDatos @Modulo, @ID, 
                            @ContID OUTPUT, @Poliza OUTPUT, @PolizaID OUTPUT
    IF @ContID IS NOT NULL
    BEGIN
      SELECT @PuedeEditar = 1
      SELECT @ContMov = Mov,
             @ContSucursal = Sucursal,
             @ContSucursalOrigen = SucursalOrigen,
             @ContEstatus = Estatus,
             @ContContacto = Contacto,
             @ContContactoTipo = ContactoTipo,
             @ContFechaEmision = FechaEmision,
             @ContFechaContable = FechaContable
        FROM Cont
       WHERE ID = @ContID

      EXEC spPuedeEditarMovMatrizSucursal @ContSucursal, @ContSucursalOrigen, @ContID, 'CONT', @Empresa, @Usuario, @ContMov, @ContEstatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 1 AND ((DATEPART(month, @FechaEmision)=DATEPART(month, @FechaRegistro) AND DATEPART(year, @FechaEmision)=DATEPART(year, @FechaRegistro)) 
      OR (@CfgCancelarMismoMes = 1))
      BEGIN
        IF NOT (@PermitirCancelacionOrigen = 1 AND (NOT EXISTS(SELECT * FROM Cont WHERE ID = @ContID AND Estatus IN ('CONCLUIDO', 'SINCRO'))))
        BEGIN
          EXEC spCont @ContID, 'CONT', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario,  1, 0,
       	              @ContMov OUTPUT, @ContMovID OUTPUT,  NULL, @Ok OUTPUT, @OkRef OUTPUT, @ContAuto = 1, @ModuloInicial = @ModuloInicial
          -- Registrar el Flujo	
          EXEC spCancelarFlujo @Empresa, 'CONT', @ContID, @Ok OUTPUT
        END
      END ELSE
      BEGIN
        SELECT @FechaTrabajo = @FechaRegistro
        EXEC spExtraerFecha @FechaTrabajo OUTPUT
        SELECT @CancelarMov = @Poliza, @CancelarMovID = NULL
        EXEC @CancelarID = spMovCopiar @Sucursal, 'CONT', @ContID, @Usuario, @FechaTrabajo, 1
        IF @CfgCancelarMismoMes = 1 UPDATE Cont SET FechaEmision = @ContFechaEmision, FechaContable = @ContFechaContable WHERE ID = @CancelarID

        UPDATE ContD 
           SET Debe=-Debe, Haber=-Haber, Debe2=-Debe2, Haber2=-Haber2
         WHERE ID = @CancelarID
        UPDATE Cont
           SET Contacto = @ContContacto,
               ContactoTipo = @ContContactoTipo
         WHERE ID = @CancelarID

        -- Afectar
        EXEC spCont @CancelarID, 'CONT', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario,  1, 0,
                    @CancelarMov OUTPUT, @CancelarMovID OUTPUT,  NULL, @Ok OUTPUT, @OkRef OUTPUT, @ContAuto = 1, @ModuloInicial = @ModuloInicial

        EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'CONT', @CancelarID, @CancelarMov, @CancelarMovID, @Ok OUTPUT        
      END
    END
  END ELSE
  BEGIN
    SELECT @CfgClaseConceptoGastos = ISNULL(ContAutoClaseConceptoGastos, 0), 
           @CfgPartidasSinImporte  = ISNULL(ContAutoPartidasSinImporte, 0),
	   @CfgConsolidacion       = ISNULL(ContAutoConsolidacion, 0),
           @CfgTipoFilial          = ContAutoCteTipoFilial,
           @CfgRegistro		   = ISNULL(Registro, 0)
      FROM EmpresaGral
     WHERE Empresa = @Empresa

   CREATE TABLE #Poliza (
       Renglon			float		NULL,
       RenglonSub		int		NULL,
       Presupuesto		bit		NULL	DEFAULT 0,
       Orden			int		NULL,
       Cuenta			char(20) 	COLLATE Database_Default NULL, 
       SubCuenta 		varchar(50) 	COLLATE Database_Default NULL,
       SubCuenta2 		varchar(50) 	COLLATE Database_Default NULL,
       SubCuenta3 		varchar(50) 	COLLATE Database_Default NULL,
       SucursalContable		int		NULL,
       Concepto			varchar(50) 	COLLATE Database_Default NULL,
       ContactoEspecifico	varchar(20)	COLLATE Database_Default NULL,
       Articulo			varchar(20)	COLLATE Database_Default NULL,
       DepartamentoDetallista 	int		NULL,
       Debe			money		NULL,
       Haber			money		NULL,
       Campo			varchar(20)	COLLATE Database_Default NULL,
	   ContactoTipo		varchar(20)	COLLATE Database_Default NULL) --REQ 13147

    CREATE INDEX Presupuesto ON #Poliza(Presupuesto)
    CREATE INDEX Cuenta ON #Poliza(Cuenta)
    CREATE INDEX Consulta ON #Poliza(Presupuesto, Orden, Cuenta, SubCuenta, SucursalContable, Concepto, ContactoEspecifico, Articulo, DepartamentoDetallista)

    IF @EstatusNuevo = 'CANCELADO' AND @CfgCancelarMismoMes = 0 SELECT @FechaPoliza = @Hoy ELSE SELECT @FechaPoliza = @FechaEmision
    EXEC spContAutoPoliza @Empresa, @Sucursal, @Modulo,  @ID, @Mov, @MovID, @MovTipo, @Estatus, @EstatusNuevo, @Usuario, @FechaPoliza, @FechaRegistro, @CfgClaseConceptoGastos, @Concepto OUTPUT, @Proyecto OUTPUT, @UEN OUTPUT, @Contacto OUTPUT, @ContactoTipo OUTPUT, @ContactoAplica OUTPUT, @Intercompania OUTPUT, @OrigenMoneda OUTPUT, @OrigenTipoCambio OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @CfgConsolidacion, @CfgTipoFilial, @CfgContArticulo, @ContAutoEmpresa = @ContAutoEmpresa
    IF @Ok IS NULL
      EXEC spContAutoRegistrar @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaPoliza, @FechaRegistro, @Mov, @MovID, @MovTipo,
                               @ContMov, @ContMovID, @ContMoneda, @ContTipoCambio, @Referencia, @Concepto, @Proyecto, @UEN, @Contacto, @ContactoTipo, @ContactoAplica, @Intercompania, @OrigenMoneda, @OrigenTipoCambio, @CfgPartidasSinImporte, @CfgRegistro,
                               @Ok OUTPUT, @OkRef OUTPUT, @ModuloInicial = @ModuloInicial

  END
  IF @Ok IS NULL
    SELECT @Ok = @SaveOk, @OkRef = @SaveOkRef
  RETURN
END
GO

/************** spContAutoGetCuenta *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoGetCuenta') and type = 'P') drop procedure dbo.spContAutoGetCuenta
GO
CREATE PROCEDURE spContAutoGetCuenta
			@Modulo			varchar(5),
			@Cuenta			varchar(20),
    			@CuentaOmision		varchar(20),
			@CtaCtoTipo		varchar(20),
		   	@CtaCtoTipoAplica	varchar(20),
			@CtaClase		varchar(50),
			@Articulo		varchar(20),
			@Almacen		varchar(10),
			@AlmacenTipo		varchar(20),
			@Concepto		varchar(50),
			@Contacto		varchar(10),
			@ContactoTipo		varchar(20),
                        @CtaDinero		varchar(10),
                        @CtaDineroDestino	varchar(10),
			@FormaPago		varchar(50),
			@Cta			varchar(20)	OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT,
			@TipoImpuesto1		varchar(10) = NULL,
			@TipoImpuesto2		varchar(10) = NULL,
			@TipoImpuesto3		varchar(10) = NULL,
			@TipoImpuesto5		varchar(10) = NULL,
			@TipoRetencion1		varchar(10) = NULL,
			@TipoRetencion2		varchar(10) = NULL,
			@TipoRetencion3		varchar(10) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CtaRetencion	varchar(20),
    @CtaNombre		varchar(100),
    @CtaEsAcumulativa	bit,
    @CtaRama		varchar(20),
    @CategoriaAF	varchar(50),
    @Rama		char(20),
    @Cuenta2	varchar(20),
    @Cuenta3	varchar(20)

  SELECT @Cta = NULL

  IF UPPER(@Cuenta) IN ('CONTACTO', 'RETENCION CONTACTO', 'CONTACTO ORIGEN', 'RETENCION CTO ORIGEN', 'RAMA CONTACTO', 'CUENTA DINAMICA')
  BEGIN
    IF NULLIF(RTRIM(@Contacto), '') IS NOT NULL OR UPPER(@Cuenta) = 'CUENTA DINAMICA'
    BEGIN
      IF UPPER(@ContactoTipo) = 'CLIENTE'   OR @Modulo IN ('VTAS', 'CXC')        SELECT @Cta = Cuenta, @CtaNombre = Nombre, @CtaRetencion = CuentaRetencion, @Rama = Rama     FROM Cte      WHERE Cliente   = @Contacto ELSE
      IF UPPER(@ContactoTipo) = 'PROVEEDOR' OR @Modulo IN ('COMS', 'CXP', 'GAS') SELECT @Cta = Cuenta, @CtaNombre = Nombre, @CtaRetencion = CuentaRetencion, @Rama = Rama     FROM Prov     WHERE Proveedor = @Contacto ELSE
      IF UPPER(@ContactoTipo) = 'PERSONAL'  OR @Modulo IN ('NOM', 'RH', 'ASIS')  SELECT @Cta = Cuenta, @CtaNombre = RTRIM(ApellidoPaterno)+' '+RTRIM(ApellidoMaterno)+' '+RTRIM(Nombre), @CtaRetencion = CuentaRetencion, @Rama = ReportaA FROM Personal WHERE Personal  = @Contacto 

      IF UPPER(@Cuenta) IN ('RETENCION CONTACTO', 'RETENCION CTO ORIGEN')
        SELECT @Cta = @CtaRetencion
      ELSE
      IF UPPER(@Cuenta) = 'RAMA CONTACTO'
      BEGIN
        SELECT @Cta = NULL
        IF UPPER(@ContactoTipo) = 'CLIENTE'   OR @Modulo IN ('VTAS', 'CXC')        SELECT @Cta = Cuenta, @CtaNombre = Nombre FROM Cte      WHERE Cliente   = @Rama ELSE
        IF UPPER(@ContactoTipo) = 'PROVEEDOR' OR @Modulo IN ('COMS', 'CXP', 'GAS') SELECT @Cta = Cuenta, @CtaNombre = Nombre FROM Prov     WHERE Proveedor = @Rama ELSE
        IF UPPER(@ContactoTipo) = 'PERSONAL'  OR @Modulo IN ('NOM', 'RH', 'ASIS')  SELECT @Cta = Cuenta, @CtaNombre = RTRIM(ApellidoPaterno)+' '+RTRIM(ApellidoMaterno)+' '+RTRIM(Nombre) FROM Personal WHERE Personal  = @Rama
      END
    END
  END ELSE
  IF UPPER(@Cuenta) IN ('ARTICULO', 'ARTICULO (CUENTA 2)', 'ARTICULO (CUENTA 3)', 'RAMA ARTICULO', 'CATEGORIA AF', 'CATEGORIA AF/FISCAL')
  BEGIN
    SELECT @Cta = Cuenta, @Cuenta2 = Cuenta2, @Cuenta3 = Cuenta3, @Rama = Rama, @CategoriaAF = CategoriaActivoFijo FROM Art WHERE Articulo = @Articulo

    IF UPPER(@Cuenta) = 'RAMA ARTICULO'
    BEGIN
      SELECT @Cta = NULL
      SELECT @Cta = Cuenta FROM Art WHERE Articulo = @Rama
    END ELSE
    IF UPPER(@Cuenta) IN ('CATEGORIA AF', 'CATEGORIA AF/FISCAL')
    BEGIN
      SELECT @Cta = NULL
      SELECT @Cta = CASE UPPER(@Cuenta) WHEN 'CATEGORIA AF' THEN Cuenta ELSE CuentaFiscal END FROM ActivoFCat WHERE Categoria = @CategoriaAF
    END ELSE
    IF UPPER(@Cuenta) = 'ARTICULO (CUENTA 2)' SELECT @Cta = @Cuenta2 ELSE
    IF UPPER(@Cuenta) = 'ARTICULO (CUENTA 3)' SELECT @Cta = @Cuenta3
  END ELSE
  IF UPPER(@Cuenta) = 'CUENTA DINERO'   	SELECT @Cta = Cuenta FROM CtaDinero WHERE CtaDinero = @CtaDinero        ELSE
  IF UPPER(@Cuenta) = 'CUENTA DESTINO'  	SELECT @Cta = Cuenta FROM CtaDinero WHERE CtaDinero = @CtaDineroDestino ELSE
  IF UPPER(@Cuenta) = 'FORMA PAGO'      	SELECT @Cta = Cuenta FROM FormaPago WHERE FormaPago = @FormaPago        ELSE
  IF UPPER(@Cuenta) = 'TIPO CONTACTO'   	SELECT @Cta = @CtaCtoTipo  ELSE
  IF UPPER(@Cuenta) = 'TIPO CONTACTO APLICA'   	SELECT @Cta = @CtaCtoTipoAplica  ELSE
  IF UPPER(@Cuenta) = 'CLASIFICACION'   	SELECT @Cta = @CtaClase	 ELSE
  IF UPPER(@Cuenta) = 'CONCEPTO'        	SELECT @Cta = Cuenta FROM Concepto WHERE Modulo = @Modulo AND Concepto = @Concepto ELSE

--  IF UPPER(@Cuenta) = 'CONCEPTO RECIBO' SELECT @Cta = MIN(CuentaContAuto) FROM NomXPersonal WHERE Concepto = @Concepto AND NULLIF(RTRIM(CuentaContAuto), '') IS NOT NULL
  IF UPPER(@Cuenta) IN ('ALMACEN/AF', 'ALMACEN/AF DESTINO', 'TIPO ALMACEN/AF', 'CATEGORIA AF','DEPRECIACION AF')
  BEGIN
    IF UPPER(@Cuenta) IN ('ALMACEN/AF', 'ALMACEN/AF DESTINO') SELECT @Cta = Cuenta FROM Alm WHERE Almacen = @Almacen ELSE
    IF UPPER(@Cuenta) = 'TIPO ALMACEN/AF' SELECT @Cta = Cuenta FROM CtoTipo WHERE Tipo = 'Almacen' AND SubTipo = @AlmacenTipo ELSE
    IF UPPER(@Cuenta) = 'CATEGORIA AF' SELECT @Cta = cat.Cuenta  FROM ActivoFCat cat, Art a  WHERE a.Articulo = @Articulo AND a.CategoriaActivoFijo = cat.Categoria
    IF UPPER(@Cuenta) = 'DEPRECIACION AF' SELECT @Cta = cat.CuentaDepreciacion FROM ActivoFCat cat, Art a WHERE a.Articulo = @Articulo AND a.CategoriaActivoFijo = cat.Categoria
  END 

    
  IF UPPER(@Cuenta) = 'CUENTA DINAMICA'
  BEGIN
    SELECT @Cta = RTRIM(@CtaCtoTipo)+'/'+RTRIM(@Contacto)
    IF NOT EXISTS(SELECT * FROM Cta WHERE Cuenta = @Cta)
    BEGIN
      SELECT @CtaRama = Rama, 
             @CtaEsAcumulativa = ISNULL(EsAcumulativa, 0)
        FROM Cta
       WHERE Cuenta = @CtaCtoTipo
      IF @@ROWCOUNT = 0 OR @CtaCtoTipo IS NULL 
        SELECT @Ok = 50110, @OkRef = @ContactoTipo
      ELSE BEGIN
        IF @CtaEsAcumulativa = 1 
          SELECT @CtaRama = @CtaCtoTipo

        INSERT Cta (
               Cuenta, Rama,     Descripcion, Tipo,        Categoria, Familia, Grupo, EsAcreedora, EsAcumulativa, CentrosCostos, CentroCostosRequerido, CentroCostosOmision, AjusteInflacionario, Bucket, BucketSt, Estatus, Alta)
        SELECT @Cta,   @CtaRama, @CtaNombre,  'Auxiliar',  Categoria, Familia, Grupo, EsAcreedora, 0,             CentrosCostos, CentroCostosRequerido, CentroCostosOmision, AjusteInflacionario, Bucket, BucketSt, 'ALTA',  GETDATE()
          FROM Cta
         WHERE Cuenta = @CtaCtoTipo

        INSERT CtaSub (Cuenta, SubCuenta)
        SELECT @Cta, SubCuenta
          FROM CtaSub
         WHERE Cuenta = @CtaCtoTipo      
      END
    END
  END
  
  IF @Cuenta IN ('Tipo Imp 1 Acreedora', 'Tipo Imp 1 Deudora', 'Tipo Imp 2 Acreedora', 'Tipo Imp 2 Deudora', 'Tipo Imp 3 Acreedora', 'Tipo Imp 3 Deudora',
                 'Tipo Ret 1 Acreedora', 'Tipo Ret 1 Deudora', 'Tipo Ret 2 Acreedora', 'Tipo Ret 2 Deudora', 'Tipo Ret 3 Acreedora', 'Tipo Ret 3 Deudora')
  BEGIN
    IF @Cuenta = 'Tipo Imp 1 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto1  ELSE
    IF @Cuenta = 'Tipo Imp 1 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto1  ELSE
    IF @Cuenta = 'Tipo Imp 2 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto2  ELSE
    IF @Cuenta = 'Tipo Imp 2 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto2  ELSE
    IF @Cuenta = 'Tipo Imp 3 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto3  ELSE
    IF @Cuenta = 'Tipo Imp 3 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto3  ELSE
    IF @Cuenta = 'Tipo Imp 5 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto5  ELSE
    IF @Cuenta = 'Tipo Imp 5 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoImpuesto5  ELSE
    IF @Cuenta = 'Tipo Ret 1 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion1 ELSE
    IF @Cuenta = 'Tipo Ret 1 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion1 ELSE
    IF @Cuenta = 'Tipo Ret 2 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion2 ELSE
    IF @Cuenta = 'Tipo Ret 2 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion2 ELSE
    IF @Cuenta = 'Tipo Ret 3 Acreedora' SELECT @Cta = CuentaAcreedora FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion3 ELSE
    IF @Cuenta = 'Tipo Ret 3 Deudora'   SELECT @Cta = CuentaDeudora   FROM TipoImpuesto WHERE TipoImpuesto = @TipoRetencion3      
  END
  
  IF NULLIF(RTRIM(@Cta), '') IS NULL SELECT @Cta = @CuentaOmision
  SELECT @Cta = NULLIF(RTRIM(@Cta), '')
  RETURN
END
GO

/************** spContAutoGetCuentaTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoGetCuentaTabla') and type = 'P') drop procedure dbo.spContAutoGetCuentaTabla

go
CREATE PROCEDURE spContAutoGetCuentaTabla
			@Modulo			char(5),
			@Clave			varchar(20),
			@Nombre			varchar(50),
			@Monto			float,
			@Importe		float,
			@Cta			char(20)	OUTPUT,
			@Excento		bit		= 0,
			@ContAutoEmpresa	varchar(10)	= '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Porcentaje	money,
  @Tolerancia	float
 
  SELECT @Tolerancia = 0.02
  SELECT @Porcentaje = ROUND((@Monto * 100.0) / CONVERT(float, NULLIF(@Importe, 0)), 2)
  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje BETWEEN @Porcentaje - @Tolerancia AND @Porcentaje + @Tolerancia AND Excento = @Excento
RETURN
END
go

/************** spContAutoGetDatos *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoGetDatos') and type = 'P') drop procedure dbo.spContAutoGetDatos
GO
CREATE PROCEDURE spContAutoGetDatos
		   @Modulo		char(5),
		   @ID			int,

		   @ContID		int		= NULL OUTPUT,
		   @Poliza		varchar(20)	= NULL OUTPUT,
		   @PolizaID		varchar(20)	= NULL OUTPUT,

		   @Concepto		varchar(50)	= NULL OUTPUT,
		   @Proyecto		varchar(50)	= NULL OUTPUT,
		   @UEN			int		= NULL OUTPUT,
		   @OrigenTipo		varchar(10)	= NULL OUTPUT,
		   @CtaClase		varchar(20)	= NULL OUTPUT,
		   @CtaCtoTipo		varchar(20)	= NULL OUTPUT,
		   @CtaCtoTipoAplica	varchar(20)	= NULL OUTPUT,
		   @Contacto		varchar(10)	= NULL OUTPUT,
		   @CtaDinero		varchar(10)	= NULL OUTPUT,
		   @CtaDineroDestino	varchar(10)	= NULL OUTPUT,
		   @FormaPago		varchar(50)	= NULL OUTPUT,
		   @ConDesglose		bit		= NULL OUTPUT,
		   @GenerarPoliza	bit		= NULL OUTPUT,
    		   @ContactoTipo	varchar(20)	= NULL OUTPUT,
    		   @ContactoSubTipo	varchar(20)	= NULL OUTPUT,
    		   @Clase		varchar(50)	= NULL OUTPUT,
    		   @SubClase		varchar(50)	= NULL OUTPUT,
		   @Intercompania	bit		= NULL OUTPUT,
		   @OrigenMoneda	varchar(10)	= NULL OUTPUT,
		   @OrigenTipoCambio	float		= NULL OUTPUT,
		   @CentroCostosSucursal varchar(20)    = NULL OUTPUT,
                   @CentroCostosDestino  varchar(20)    = NULL OUTPUT,
		   @CentroCostosMatriz	 varchar(20)    = NULL OUTPUT,
                   @RetencionPorcentaje	float		= NULL OUTPUT,
		   @Directo		bit		= NULL OUTPUT,
                   @ContactoAplica	varchar(10)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			char(5),
    @MovSucursal		int,
    @MovAplica			varchar(20),
    @MovAplicaID		varchar(20),
    @AlmacenDestino		char(10),
    @ContactoTipoAplica 	varchar(20),
    @ContactoSubTipoAplica 	varchar(20)

  SELECT @ContactoTipo = NULL, @ContactoSubTipo = NULL, @Contacto = NULL, @Clase = NULL, @SubClase = NULL, @CtaClase = NULL, @CtaCtoTipo = NULL, @CtaCtoTipoAplica = NULL, @Concepto = NULL, @Proyecto = NULL, @UEN = NULL, @OrigenTipo = NULL, @CtaDinero = NULL, @CtaDineroDestino = NULL, @FormaPago = NULL, @ConDesglose = 0, @OrigenMoneda = NULL, @OrigenTipoCambio = NULL,
         @CentroCostosSucursal = NULL, @CentroCostosDestino = NULL, @CentroCostosMatriz = NULL, @AlmacenDestino = NULL, @RetencionPorcentaje = NULL, @Directo = 0, @ContactoAplica = NULL

  IF @Modulo = 'DIN'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = ContactoTipo, @Contacto = Contacto,  @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @CtaDinero = CtaDinero, @CtaDineroDestino = CtaDineroDestino, @ConDesglose = ConDesglose, @Directo = Directo, @FormaPago = FormaPago FROM Dinero WHERE ID = @ID ELSE
  IF @Modulo = 'COMS'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Proveedor',  @Contacto = Proveedor, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @Directo = Directo FROM Compra WHERE ID = @ID ELSE
  IF @Modulo = 'VALE'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Cliente',    @Contacto = Cliente,   @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto FROM Vale   WHERE ID = @ID ELSE
  IF @Modulo = 'CR'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Agente',     @Contacto = Cajero,    @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto FROM CR     WHERE ID = @ID ELSE
  IF @Modulo = 'CAM'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, /*@OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, */@ContactoTipo = 'Cliente',    @Contacto = Cliente,   @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto FROM Cambio WHERE ID = @ID ELSE
  IF @Modulo = 'CXC'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Cliente',    @Contacto = Cliente,   @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @CtaDinero = CtaDinero, @MovAplica = MovAplica, @MovAplicaID = MovAplicaID FROM Cxc WHERE ID = @ID ELSE
  IF @Modulo = 'CXP'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Proveedor',  @Contacto = Proveedor, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @CtaDinero = CtaDinero, @MovAplica = MovAplica, @MovAplicaID = MovAplicaID FROM Cxp WHERE ID = @ID ELSE
  IF @Modulo = 'VTAS'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Cliente',    @Contacto = Cliente,   @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @Clase = Clase, @SubClase = SubClase, @RetencionPorcentaje = NULLIF(CONVERT(float,Retencion), 0.0)/NULLIF(CONVERT(float,Importe), 0.0)*100, @Directo = Directo FROM Venta WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Proveedor',  @Contacto = Acreedor,  @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @CtaDinero = CtaDinero, @Clase = Clase, @SubClase = SubClase FROM Gasto WHERE ID = @ID ELSE
  IF @Modulo = 'AF'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Proveedor',  @Contacto = Proveedor, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto FROM ActivoFijo WHERE ID = @ID ELSE
  IF @Modulo = 'AGENT' SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @ContactoTipo = 'Agente',     @Contacto = Agente,    @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto FROM Agent  WHERE ID = @ID ELSE
  IF @Modulo = 'PROD'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @Directo = Directo FROM Prod WHERE ID = @ID ELSE
  IF @Modulo = 'INV'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto, @AlmacenDestino = NULLIF(RTRIM(AlmacenDestino), ''), @Directo = Directo FROM Inv WHERE ID = @ID ELSE
  IF @Modulo = 'EMB'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Embarque WHERE ID = @ID ELSE
  IF @Modulo = 'NOM'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Nomina 	WHERE ID = @ID ELSE
  IF @Modulo = 'RH'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM RH 	WHERE ID = @ID ELSE
  IF @Modulo = 'ASIS'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN		          FROM Asiste 	WHERE ID = @ID ELSE
  IF @Modulo = 'PC'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM PC 	WHERE ID = @ID ELSE 
  IF @Modulo = 'ST'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, /*@OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, */@OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Soporte  WHERE ID = @ID ELSE
  IF @Modulo = 'CAP'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Capital      WHERE ID = @ID ELSE
  IF @Modulo = 'INC'   SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Incidencia   WHERE ID = @ID ELSE
  IF @Modulo = 'CONC'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Conciliacion WHERE ID = @ID ELSE
  IF @Modulo = 'PPTO'  SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Presup       WHERE ID = @ID ELSE
  IF @Modulo = 'CP'    SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM CP           WHERE ID = @ID ELSE
  IF @Modulo = 'CREDI' SELECT @Empresa = Empresa, @MovSucursal = ISNULL(SucursalDestino, Sucursal), @Poliza = Poliza, @PolizaID = PolizaID, @ContID = ContID, @GenerarPoliza = GenerarPoliza, @OrigenMoneda = Moneda, @OrigenTipoCambio = TipoCambio, @OrigenTipo = OrigenTipo, @Proyecto = Proyecto, @UEN = UEN, @Concepto = Concepto  FROM Credito      WHERE ID = @ID 

--select @modulo, @contactotipo, @contacto
  SELECT @Concepto = NULLIF(RTRIM(@Concepto), '')
  EXEC spContactoSubTipo @Contacto, @ContactoTipo, @ContactoSubTipo OUTPUT, @Intercompania OUTPUT
  SELECT @CtaCtoTipo = Cuenta FROM CtoTipo WHERE Tipo = @ContactoTipo AND SubTipo = @ContactoSubTipo

  IF @Clase IS NOT NULL
    EXEC spCuentaClase @Modulo, @Clase, @SubClase, @CtaClase OUTPUT

  SELECT @CentroCostosSucursal = CentroCostos FROM Sucursal WHERE Sucursal = @MovSucursal
  IF @AlmacenDestino IS NOT NULL
    SELECT @CentroCostosDestino = s.CentroCostos FROM Alm a, Sucursal s WHERE a.Almacen = @AlmacenDestino AND a.Sucursal = s.Sucursal
  SELECT @CentroCostosMatriz = CentroCostos FROM Sucursal WHERE Sucursal = 0
/*
  IF @Modulo IN ('CXC', 'CXP') AND @MovAplica IS NOT NULL AND @MovAplicaID IS NOT NULL
  BEGIN
    IF @Modulo = 'CXC' SELECT @ContactoAplica = Cliente   FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
    IF @Modulo = 'CXP' SELECT @ContactoAplica = Proveedor FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
  END ELSE*/
  IF @Modulo IN ('CXC', 'CXP') AND @MovAplica IS NOT NULL AND @MovAplicaID IS NOT NULL
  BEGIN
    IF @Modulo = 'CXC' SELECT @ContactoAplica = Cliente,   @ContactoTipoAplica = 'CLIENTE'   FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus IN ('PENDIENTE', 'CONCLUIDO') ELSE
    IF @Modulo = 'CXP' SELECT @ContactoAplica = Proveedor, @ContactoTipoAplica = 'PROVEEDOR' FROM Cxp WHERE Empresa = @Empresa AND Mov = @MovAplica AND MovID = @MovAplicaID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

    EXEC spContactoSubTipo @ContactoAplica, @ContactoTipoAplica, @ContactoSubTipoAplica OUTPUT, @Intercompania OUTPUT
    SELECT @CtaCtoTipoAplica = Cuenta FROM CtoTipo WHERE Tipo = @ContactoTipoAplica AND SubTipo = @ContactoSubTipoAplica
  END ELSE
  IF @Modulo = 'DIN' SELECT @ContactoAplica = @CtaDineroDestino ELSE
  IF @Modulo = 'INV' SELECT @ContactoAplica = @AlmacenDestino ELSE
  IF @Modulo = 'COMS'
  BEGIN
    IF (SELECT CompraAutoEndoso FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
      SELECT @ContactoAplica = AutoEndoso FROM Prov WHERE Proveedor = @Contacto
  END

  IF @ContactoAplica = @Contacto SELECT @ContactoAplica = NULL

  RETURN
END
GO


/************** spContAutoSetDatos *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoSetDatos') and type = 'P') drop procedure dbo.spContAutoSetDatos
GO
CREATE PROCEDURE spContAutoSetDatos
		   @Empresa		char(5),
		   @Modulo		char(5),
		   @ID			int,
		   @ContID		int,
		   @ContMov		char(20),
		   @ContMovID		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Mov 
     SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID 
   WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID

  IF @Modulo = 'DIN'   UPDATE Dinero 	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'COMS'  UPDATE Compra 	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'VALE'  UPDATE Vale   	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CR'    UPDATE CR    	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CAP'   UPDATE Capital	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'INC'   UPDATE Incidencia   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CONC'  UPDATE Conciliacion SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'PPTO'  UPDATE Presup	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CP'    UPDATE CP 	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CREDI' UPDATE Credito      SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CAM'   UPDATE Cambio   	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CXC'   UPDATE Cxc    	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'CXP'   UPDATE Cxp    	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'VTAS'  UPDATE Venta  	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'   UPDATE Gasto  	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'AF'    UPDATE ActivoFijo   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'AGENT' UPDATE Agent	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'PROD'  UPDATE Prod	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'INV'   UPDATE Inv	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'EMB'   UPDATE Embarque	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'NOM'   UPDATE Nomina	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'RH'    UPDATE RH	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'ASIS'  UPDATE Asiste	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'PC'    UPDATE PC	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID ELSE
  IF @Modulo = 'ST'    UPDATE Soporte	   SET ContID = @ContID, Poliza = @ContMov, PolizaID = @ContMovID, GenerarPoliza = 0 WHERE ID = @ID 

  RETURN
END
GO

/************** spContAutoVTASCambiario *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoVTASCambiario') and type = 'P') drop procedure dbo.spContAutoVTASCambiario
GO
CREATE PROCEDURE spContAutoVTASCambiario
            @Empresa				varchar(5),
		   	@Sucursal				int,
		   	@Modulo					varchar(5), 
		   	@ID						int,
		   	@Mov					varchar(20),
		   	@MovID					varchar(20),
		   	@MovTipo				varchar(20),
    		@Orden					int,
    		@Debe					varchar(20),
    		@Haber					varchar(20),
    		@Cta					varchar(20),
			@ContUso				varchar(20),
			@ContUso2				varchar(20),			
			@ContUso3				varchar(20),						
			@Concepto				varchar(50),
    		@ContactoSubTipo		varchar(20),
			@ContAutoContactoEsp	varchar(50),
			@Contacto				varchar(10),
			@ContactoAplica			varchar(10),
			@CtaDinero				varchar(10), 
			@CtaDineroDestino		varchar(10),
			@Ok						int				OUTPUT,
			@OkRef					varchar(255)	OUTPUT,
			@ContactoTipo			varchar(20) --REQ 13147

--//WITH ENCRYPTION
AS BEGIN
  DECLARE @ImporteTotalMN			float,
		  @TipoCambio				float,
		  @ContactoTipoCambio		float,
		  @IVAMN					float,
		  @IEPSMN					float,
		  @ImporteAplicaMN			float,
		  @IVAAplicaMN				float,
		  @IEPSAplicaMN				float,
		  @Diferencia				float,
		  @DiferenciaIVA			float,
          @DiferenciaIEPS			float,
          @CxID						int,
          @ContactoEspecifico		varchar(10),
          @Agente					varchar(10),
          @Personal					varchar(10)

  CREATE TABLE #Anticipo(
    ID				int			NULL,
    Mov				varchar(20)	NULL,
    MovID			varchar(20)	NULL,
    Importe			float		NULL,
    TipoCambio		float		NULL,
    IVAFiscal		float		NULL,
    IEPSFiscal		float		NULL
    )
   
  SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, NULL, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL)
  
  INSERT INTO #Anticipo(
              ID,   Mov,   MovID,   Importe,   TipoCambio, IVAFiscal,              IEPSFiscal) 
     SELECT c.ID, c.Mov, c.MovID, v.Importe, c.TipoCambio, ISNULL(c.IVAFiscal, 0), ISNULL(c.IEPSFiscal , 0)
       FROM VentaFacturaAnticipo v
       JOIN Cxc c ON v.CxcID = c.ID
      WHERE v.ID = @ID

  SELECT @CxID = ID, @Agente = Agente, @Personal = PersonalCobrador FROM Cxc WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID
  
  SELECT @TipoCambio = TipoCambio FROM Venta WHERE ID = @ID
  
  SELECT @ImporteTotalMN = SUM(Importe*TipoCambio) FROM #Anticipo
  
  SELECT @ContactoTipoCambio = ClienteTipoCambio FROM Cxc WHERE ID = @CxID

  IF @TipoCambio <> 1.0 OR @ContactoTipoCambio <> 1.0
  BEGIN
    SELECT @IVAMN = SUM(Importe*TipoCambio*IVAFiscal), @IEPSMN = SUM(Importe*TipoCambio*IEPSFiscal) FROM #Anticipo

    SELECT @ImporteAplicaMN = AnticiposFacturados*TipoCambio,
           @IVAAplicaMN = AnticiposFacturados*IVAFiscal/@ContactoTipoCambio*TipoCambio,
           @IEPSAplicaMN = AnticiposFacturados*IEPSFiscal/@ContactoTipoCambio*TipoCambio
      FROM Venta 
     WHERE ID = @ID

    SELECT @Diferencia = @ImporteTotalMN - @ImporteAplicaMN
    SELECT @DiferenciaIVA = @IVAMN - @IVAAplicaMN,
           @DiferenciaIEPS = @IEPSMN - @IEPSAplicaMN

    IF ISNULL(@Diferencia, 0) <> 0
    BEGIN
      IF @Debe   = 'ANT FACT. DIFEREN C' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ABS(@Diferencia)) ELSE
      IF @Haber  = 'ANT FACT. DIFEREN C' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ABS(@Diferencia)) ELSE
      IF @Debe   = 'ANT FACT. UTILIDAD C'   AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)   VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia) ELSE
      IF @Haber  = 'ANT FACT. UTILIDAD C'   AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia) ELSE
      IF @Debe   = 'ANT FACT. PERDIDA C'    AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)   VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia) ELSE
      IF @Haber  = 'ANT FACT. PERDIDA C'    AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia) --ELSE
      /*IF @Debe   = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA)  ELSE
      IF @Haber  = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA)  ELSE
      IF @Debe   = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA) ELSE
      IF @Haber  = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA) ELSE
      IF @Debe   = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA) ELSE
      IF @Haber  = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA) ELSE
      IF @Debe   = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS) ELSE
      IF @Haber  = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS) ELSE
      IF @Debe   = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS)  ELSE
      IF @Haber  = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS)  ELSE
      IF @Debe   = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS) ELSE
      IF @Haber  = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS)  */
    END
  END
  RETURN
END
GO

/************** spContAutoInv *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoInv') and type = 'P') drop procedure dbo.spContAutoInv
GO
CREATE PROCEDURE spContAutoInv
                   @Modulo		  char(5), 
		   @Clave		  varchar(20), 
		   @Nombre		  varchar(50), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  varchar(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20), 
		   @CtaClase		  varchar(20), 
		   @Concepto		  varchar(50),
                   @Contacto		  varchar(10),
		   @ContactoTipo	  varchar(20), 	
                   @CtaDinero		  varchar(10),
                   @CtaDineroDestino	  varchar(10),
		   @FormaPago		  varchar(50), 	
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
	           @CfgPartidasSinImporte bit,
		   @CfgContArticulo	  bit,
                   @IncluirArticulos	  bit,
		   @IncluirDepartamento	  bit,
		   @RetencionPorcentaje	  float,
		   @ContAutoContactoEsp	  varchar(50),
                   @ContactoAplica	  varchar(10),
                   @ContAutoEmpresa	  varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa			varchar(5),
    @Renglon			float,
    @RenglonSub			int,
    @RenglonID			int,
    @AlmacenOrigen		varchar(10),
    @AlmacenDestino		varchar(10),
    @Almacen			varchar(10),
    @AlmacenTipo		varchar(20),
    @Agente			varchar(10),
    @ContUso			varchar(20),
    @ContUso2			varchar(20),
    @ContUso3			varchar(20),
    @Articulo			varchar(20),
    @TipoCambio			float,
    @Importe			money,
    @Cantidad			float,
    @Costo			money, 
    @Precio			money,
    @AjusteCosteo		money,
    @CostoUEPS			money,
    @CostoPEPS			money,
    @UltimoCosto		money,
    @CostoEstandar		money,
    @CostoPromedio		money,
    @CostoReposicion		money,
    @PrecioLista		money,
    @AjustePrecioLista		money,
    @CostoActividad		money, 
    @Descuentos			money, 
    @Comisiones			money,
    @Impuesto1			money, 
    @Impuesto1Excento		bit,
    @Excento			bit,
    @Impuesto2			money, 
    @Impuesto3			money, 
    @Impuesto5			money, 
    @Impuestos			money, 
    @ImporteTotal		money,
    @Cta			varchar(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @DepartamentoDetallista	int,
    @TipoImpuesto1		varchar(10), 
    @TipoImpuesto2		varchar(10), 
    @TipoImpuesto3		varchar(10), 
    @TipoImpuesto5		varchar(10), 
    @TipoRetencion1		varchar(10), 
    @TipoRetencion2		varchar(10), 
    @TipoRetencion3		varchar(10),
	@ArtImpuesto1       float,
	@ArtImpuesto1Excento bit,
	@Condicion           varchar(50),
	@TipoCondicion       varchar(20)

  IF @Campo IS NULL RETURN

  IF @Modulo = 'VTAS' 
    DECLARE crMovD CURSOR FAST_FORWARD READ_ONLY FOR--BUG 18854
     SELECT e.Empresa, e.Almacen, e.AlmacenDestino, e.Agente, d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, Alm.Tipo, d.ContUso, d.ContUso2, d.ContUso3, d.Articulo, d.CantidadNeta, d.AjusteCosteo, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.CostoPromedio, d.CostoReposicion, d.PrecioLista, d.TipoCambio, d.SubTotal, d.CostoTotal, d.DescuentosTotales, d.Impuesto1Total, d.Impuesto2Total, d.Impuesto3Total, CONVERT(money,NULL), d.Impuestos, d.ImporteTotal-(d.SubTotal*(ISNULL(@RetencionPorcentaje, 0.0)/100.0)), d.Comision, d.CostoActividadTotal, CONVERT(money, null), CONVERT(money, null), ISNULL(Art.Impuesto1Excento, 0), 
            d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, CONVERT(varchar(10),NULL), art.TipoRetencion1, art.TipoRetencion2, art.TipoRetencion3, Art.Impuesto1, Art.Impuesto1Excento, e.Condicion
       FROM Venta e
       JOIN VentaTCalc d ON e.ID = d.ID
       JOIN Alm ON d.Almacen = Alm.Almacen
       JOIN Art ON d.Articulo = Art.Articulo
      WHERE e.ID = @ID 

  IF @Modulo = 'COMS'
    DECLARE crMovD CURSOR FAST_FORWARD READ_ONLY FOR--BUG 18854
     SELECT e.Empresa, e.Almacen, NULL, e.Agente, d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, Alm.Tipo, d.ContUso, d.ContUso2, d.ContUso3, d.Articulo, d.CantidadNeta, d.AjusteCosteo, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.CostoPromedio, d.CostoReposicion, d.PrecioLista, d.TipoCambio, d.SubTotal, d.SubTotalInv, d.DescuentosTotales, d.Impuesto1Total, d.Impuesto2Total, d.Impuesto3Total, d.Impuesto5Total, d.Impuestos, d.ImporteTotal, CONVERT(money, NULL), CONVERT(money, null), CONVERT(money, null), CONVERT(money, null), ISNULL(Art.Impuesto1Excento, 0),
            d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, d.TipoImpuesto5, d.TipoRetencion1, d.TipoRetencion2, d.TipoRetencion3, Art.Impuesto1, Art.Impuesto1Excento, e.Condicion
       FROM Compra e
       JOIN CompraTCalc d ON e.ID = d.ID
       JOIN Alm ON d.Almacen = Alm.Almacen
       JOIN Art ON d.Articulo = Art.Articulo
      WHERE e.ID = @ID

  IF @Modulo = 'INV'
    DECLARE crMovD CURSOR FAST_FORWARD READ_ONLY FOR--BUG 18854
     SELECT e.Empresa, e.Almacen, e.AlmacenDestino, e.Agente, d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, Alm.Tipo, d.ContUso, CONVERT(varchar, NULL), CONVERT(varchar, NULL), d.Articulo, d.Cantidad-ISNULL(d.CantidadCancelada, 0), d.AjusteCosteo, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.CostoPromedio, d.CostoReposicion, d.PrecioLista, e.TipoCambio, d.Costo*(d.Cantidad-ISNULL(d.CantidadCancelada, 0)), ISNULL(d.CostoInv, d.Costo)*(d.Cantidad-ISNULL(d.CantidadCancelada, 0)), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), d.Precio*(d.Cantidad-ISNULL(d.CantidadCancelada, 0)), d.AjustePrecioLista, ISNULL(Art.Impuesto1Excento, 0),
            art.TipoImpuesto1, art.TipoImpuesto2, art.TipoImpuesto3, CONVERT(varchar(10),NULL), art.TipoRetencion1, art.TipoRetencion2, art.TipoRetencion3, Art.Impuesto1, Art.Impuesto1Excento, e.Condicion         
       FROM Inv e
       JOIN InvD d ON e.ID = d.ID
       JOIN Alm ON d.Almacen = Alm.Almacen
       JOIN Art ON d.Articulo = Art.Articulo
      WHERE e.ID = @ID

  IF @Modulo = 'PROD'
    DECLARE crMovD CURSOR FAST_FORWARD READ_ONLY FOR--BUG 18854
     SELECT e.Empresa, e.Almacen, NULL, NULL, d.Renglon, d.RenglonSub, d.RenglonID, d.Almacen, Alm.Tipo, CONVERT(varchar, NULL), CONVERT(varchar, NULL), CONVERT(varchar, NULL), d.Articulo, d.Cantidad-ISNULL(d.CantidadCancelada, 0), d.AjusteCosteo, d.CostoUEPS, d.CostoPEPS, d.UltimoCosto, d.CostoEstandar, d.CostoPromedio, d.CostoReposicion, d.PrecioLista, e.TipoCambio, CONVERT(money, NULL), d.Costo*(d.Cantidad-ISNULL(d.CantidadCancelada, 0)), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, NULL), CONVERT(money, null), CONVERT(money, null), CONVERT(money, null), ISNULL(Art.Impuesto1Excento, 0),
            art.TipoImpuesto1, art.TipoImpuesto2, art.TipoImpuesto3, CONVERT(varchar(10),NULL), art.TipoRetencion1, art.TipoRetencion2, art.TipoRetencion3, Art.Impuesto1, Art.Impuesto1Excento, CONVERT(varchar, NULL)         
       FROM Prod e
       JOIN ProdD d ON e.ID = d.ID
       JOIN Alm ON d.Almacen = Alm.Almacen
       JOIN Art ON d.Articulo = Art.Articulo
      WHERE e.ID = @ID

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Empresa, @AlmacenOrigen, @AlmacenDestino, @Agente, @Renglon, @RenglonSub, @RenglonID, @Almacen, @AlmacenTipo, @ContUso, @ContUso2, @ContUso3, @Articulo, @Cantidad, @AjusteCosteo, @CostoUEPS, @CostoPEPS, @UltimoCosto, @CostoEstandar, @CostoPromedio, @CostoReposicion, @PrecioLista, @TipoCambio, @Importe, @Costo, @Descuentos, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuestos, @ImporteTotal, @Comisiones, @CostoActividad, @Precio, @AjustePrecioLista, @Impuesto1Excento,
                              @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ArtImpuesto1, @ArtImpuesto1Excento, @Condicion
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
	  IF UPPER(@Cuenta) = 'ALMACEN/AF DESTINO' AND @Modulo = 'INV' 
	  BEGIN
	   SELECT @Almacen = @AlmacenDestino
	   SELECT @AlmacenTipo = Tipo FROM Alm WHERE Almacen = @Almacen
	  END

      SELECT @Monto = NULL, @Cta = NULL, @DepartamentoDetallista = NULL
	  IF UPPER(@Cuenta) IN ('CUENTA IMP 1','CUENTA IMP 1 COND') AND @Modulo = 'VTAS'
	  BEGIN
	   SELECT @TipoCondicion = UPPER(TipoCondicion) FROM Condicion WHERE Condicion = @Condicion
	   
	   IF UPPER(@Cuenta) = 'CUENTA IMP 1' AND ISNULL(@ArtImpuesto1Excento,0) = 0
	    SELECT @Cta = Cuenta FROM CfgCuentasContablesImpuesto1 WHERE UPPER(Nombre) <> 'EXENTO' AND ISNULL(Tasa,0) = @ArtImpuesto1
	   ELSE IF UPPER(@Cuenta) = 'CUENTA IMP 1' AND ISNULL(@ArtImpuesto1Excento,0) = 1
	    SELECT @Cta = Cuenta FROM CfgCuentasContablesImpuesto1 WHERE UPPER(Nombre) = 'EXENTO'
	   ELSE IF UPPER(@Cuenta) = 'CUENTA IMP 1 COND' AND ISNULL(@ArtImpuesto1Excento,0) = 0
	    SELECT @Cta = Cuenta FROM CfgCuentasContablesCondImpuesto1 WHERE UPPER(Condicion) = UPPER(@TipoCondicion) AND UPPER(Nombre) <> 'EXENTO' AND ISNULL(Tasa,0) = @ArtImpuesto1	
	   ELSE IF UPPER(@Cuenta) = 'CUENTA IMP 1 COND' AND ISNULL(@ArtImpuesto1Excento,0) = 1
	     SELECT @Cta = Cuenta FROM CfgCuentasContablesCondImpuesto1 WHERE UPPER(Condicion) = UPPER(@TipoCondicion) AND UPPER(Nombre) = 'EXENTO'
	  END
	  
	  IF @Cta IS NULL
       EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, @Almacen, @AlmacenTipo, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                                @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, @Almacen, @AlmacenTipo, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NOT NULL OR @Cuenta = 'TABLA %'
      BEGIN
        SELECT @Excento = 0
        IF @Campo = 'IMPORTE BRUTO'        SELECT @Monto = @Importe+@Descuentos 	ELSE
        IF @Campo = 'IMPORTE' 		   SELECT @Monto = @Importe 	     		ELSE
        IF @Campo = 'COSTO'   		   SELECT @Monto = @Costo 			ELSE
        IF @Campo = 'PRECIO'   		   SELECT @Monto = @Precio 			ELSE
        IF @Campo = 'AJUSTE COSTEO'	   SELECT @Monto = @AjusteCosteo*@Cantidad   	ELSE
        IF @Campo = 'COSTO UEPS' 	   SELECT @Monto = @CostoUEPS*@Cantidad   	ELSE
        IF @Campo = 'COSTO PEPS' 	   SELECT @Monto = @CostoPEPS*@Cantidad   	ELSE
        IF @Campo = 'ULTIMO COSTO' 	   SELECT @Monto = @UltimoCosto*@Cantidad 	ELSE
        IF @Campo = 'COSTO ESTANDAR' 	   SELECT @Monto = @CostoEstandar*@Cantidad 	ELSE
        IF @Campo = 'COSTO PROMEDIO' 	   SELECT @Monto = @CostoPromedio*@Cantidad	ELSE
        IF @Campo = 'COSTO REPOSICION' 	   SELECT @Monto = @CostoReposicion*@Cantidad	ELSE
        IF @Campo = 'PRECIO LISTA' 	   SELECT @Monto = @PrecioLista*@Cantidad 	ELSE
        IF @Campo = 'AJUSTE PRECIO LISTA'  SELECT @Monto = @AjustePrecioLista*@Cantidad ELSE
        IF @Campo = 'COSTO ACTIVIDAD' 	   SELECT @Monto = @CostoActividad   		ELSE
        IF @Campo = 'COMISIONES' 	   SELECT @Monto = @Comisiones			ELSE
        IF @Campo = 'DESCUENTOS'  	   SELECT @Monto = @Descuentos 			ELSE
        IF @Campo = 'IMPUESTO 1'  	   SELECT @Monto = @Impuesto1, @Excento = @Impuesto1Excento ELSE
        IF @Campo = 'IMPUESTO 2'  	   SELECT @Monto = @Impuesto2			ELSE
        IF @Campo = 'IMPUESTO 3'    	   SELECT @Monto = @Impuesto3			ELSE
        IF @Campo = 'IMPUESTO 5'    	   SELECT @Monto = @Impuesto5			ELSE
        IF @Campo = 'IMPUESTOS'     	   SELECT @Monto = @Impuestos			ELSE
        IF @Campo = 'IMPORTE TOTAL' 	   SELECT @Monto = @ImporteTotal		ELSE
        IF @Campo = 'UTILIDAD' 		   SELECT @Monto = ISNULL(@Importe, 0)-ISNULL(@Costo, 0)-ISNULL(@CostoActividad, 0) ELSE
        IF @Campo = 'MERMA DEPARTAMENTO'   SELECT @Monto = @Importe * (dd.Merma/100.0) FROM Art a, DepartamentoDetallista dd WHERE a.Articulo = @Articulo AND dd.Departamento = a.DepartamentoDetallista ELSE
        IF @Campo = 'AF VALOR ADQUISICION' SELECT @Monto = SUM(af.AdquisicionValor*m.TipoCambio) FROM SerieLoteMov sl JOIN ActivoF af ON af.Empresa = sl.Empresa AND af.Articulo = sl.Articulo AND af.Serie = sl.SerieLote JOIN Mon m ON m.Moneda = af.Moneda WHERE sl.Empresa = @Empresa AND sl.Modulo = @Modulo AND sl.ID = @ID AND sl.RenglonID = @RenglonID AND sl.Articulo = @Articulo ELSE
        IF @Campo = 'AF DEPRECIACION ACUM' SELECT @Monto = SUM(af.DepreciacionAcum*m.TipoCambio) FROM SerieLoteMov sl JOIN ActivoF af ON af.Empresa = sl.Empresa AND af.Articulo = sl.Articulo AND af.Serie = sl.SerieLote JOIN Mon m ON m.Moneda = af.Moneda WHERE sl.Empresa = @Empresa AND sl.Modulo = @Modulo AND sl.ID = @ID AND sl.RenglonID = @RenglonID AND sl.Articulo = @Articulo ELSE
        IF @Campo = 'AF HISTORICO NETO'    SELECT @Monto = SUM((ISNULL(af.AdquisicionValor, 0)-ISNULL(af.DepreciacionAcum, 0))*m.TipoCambio) FROM SerieLoteMov sl JOIN ActivoF af ON af.Empresa = sl.Empresa AND af.Articulo = sl.Articulo AND af.Serie = sl.SerieLote JOIN Mon m ON m.Moneda = af.Moneda WHERE sl.Empresa = @Empresa AND sl.Modulo = @Modulo AND sl.ID = @ID AND sl.RenglonID = @RenglonID AND sl.Articulo = @Articulo 
        IF @Campo = 'AF UTILIDAD/PERDIDA'  SELECT @Monto = (SUM(af.AdquisicionValor*m.TipoCambio)) - @Importe FROM SerieLoteMov sl JOIN ActivoF af ON af.Empresa = sl.Empresa AND af.Articulo = sl.Articulo AND af.Serie = sl.SerieLote JOIN Mon m ON m.Moneda = af.Moneda WHERE sl.Empresa = @Empresa AND sl.Modulo = @Modulo AND sl.ID = @ID AND sl.RenglonID = @RenglonID AND sl.Articulo = @Articulo
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, @RenglonSub, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Cuenta = 'TABLA %'
          EXEC spContAutoGetCuentaTabla @Modulo, @Clave, @Nombre, @Monto, @Importe, @Cta OUTPUT, @Excento = @Excento, @ContAutoEmpresa = @ContAutoEmpresa
        IF @Cta IS NOT NULL AND (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 
		  BEGIN
		    SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL 
          END ELSE 
			SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @Campo <> 'AF UTILIDAD/PERDIDA'
		  BEGIN
           IF @EsDebe = 1 
             SELECT @Debe = CASE WHEN @Campo IN ('AF VALOR ADQUISICION', 'AF DEPRECIACION ACUM', 'AF HISTORICO NETO') THEN @Monto ELSE @Monto*@TipoCambio END
           ELSE
             SELECT @Haber = CASE WHEN @Campo IN ('AF VALOR ADQUISICION', 'AF DEPRECIACION ACUM', 'AF HISTORICO NETO') THEN @Monto ELSE @Monto*@TipoCambio END
          END
		  ELSE IF @Campo = 'AF UTILIDAD/PERDIDA'
		  BEGIN
		   SELECT @Debe = NULL, @Haber = NULL
		   IF @EsDebe = 1 
		    SELECT @Debe = CASE WHEN ISNULL(@Monto,0) > 0 THEN @Monto ELSE NULL END
		   ELSE
		    SELECT @Haber = CASE WHEN ISNULL(@Monto,0) > 0 THEN NULL ELSE ABS(@Monto) END
		  END
		  
          IF @IncluirDepartamento = 1 SELECT @DepartamentoDetallista = DepartamentoDetallista FROM Art WHERE Articulo = @Articulo
          IF @CfgContArticulo = 0 OR @IncluirArticulos = 0 SELECT @Articulo = NULL
          INSERT #Poliza (
            	 Renglon,  RenglonSub,  Orden,  Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto,  Articulo,  DepartamentoDetallista,  Debe,  Haber,  ContactoEspecifico,                                                                                                                                                        ContactoTipo) --REQ 13147
          SELECT @Renglon, @RenglonSub, @Orden, @Cta,   @ContUso,  @ContUso2,  @ContUso3,  @Concepto, @Articulo, @DepartamentoDetallista, @Debe, @Haber, dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, NULL, @Agente, NULL, @CtaDinero, @CtaDineroDestino, @AlmacenOrigen, @AlmacenDestino, @Almacen), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) --REQ 13147
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Empresa, @AlmacenOrigen, @AlmacenDestino, @Agente, @Renglon, @RenglonSub, @RenglonID, @Almacen, @AlmacenTipo, @ContUso, @ContUso2, @ContUso3, @Articulo, @Cantidad, @AjusteCosteo, @CostoUEPS, @CostoPEPS, @UltimoCosto, @CostoEstandar, @CostoPromedio, @CostoReposicion, @PrecioLista, @TipoCambio, @Importe, @Costo, @Descuentos, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Impuestos, @ImporteTotal, @Comisiones, @CostoActividad, @Precio, @AjustePrecioLista, @Impuesto1Excento,
                                @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3, @ArtImpuesto1, @ArtImpuesto1Excento, @Condicion
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO

/************** spContAutoCx *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoCx') and type = 'P') drop procedure dbo.spContAutoCx
GO
CREATE PROCEDURE spContAutoCx
                   @Modulo		  varchar(5), 
		   @Clave		  varchar(20), 
		   @Nombre		  varchar(50), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  varchar(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20), 
		   @CtaClase		  varchar(20), 
		   @Concepto		  varchar(50),
                   @Contacto		  varchar(10),
		   @ContactoTipo	  varchar(20),
                   @CtaDinero		  varchar(10),
                   @CtaDineroDestino	  varchar(10),
		   @FormaPago		  varchar(50), 	
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit,
		   @ContAutoContactoEsp	  varchar(50),
                   @ContactoAplica	  varchar(10),
		   @ContAutoEmpresa	  varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @RenglonSub		int,
    @Importe		money,
    @ImporteTotal	money,
    @IVAFiscal		float,
    @IEPSFiscal		float,
    @pRetencion		float,
    @pRetencion2	float,
    @pRetencion3	float,
    @Retencion		money,
    @Retencion2		money,
    @Retencion3		money,
    @TipoCambio		float,
    @Cta		char(20),
    @ContUso		varchar(20),
    @ContUso2		varchar(20), --MERJOA4752   
    @ContUso3		varchar(20), --MERJOA4752    
    @Monto		money,
    @Debe		money,
    @Haber		money,
    @ContactoDetalle	varchar(10),
    @Agente		varchar(10),
    @Personal		varchar(10),
    @CfgRetencion2BaseImpuesto1	bit

  SELECT @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version   
  SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL  --MERJOA4752

  IF @Modulo = 'CXC' SELECT @ContUso = ContUso, @ContUso2 = ContUso2, @ContUso3 = ContUso3 FROM Cxc WHERE ID = @ID ELSE --MERJOA4752
  IF @Modulo = 'CXP' SELECT @ContUso = ContUso, @ContUso2 = ContUso2, @ContUso3 = ContUso3 FROM Cxp WHERE ID = @ID --MEJORA4752

  IF @Campo IS NULL RETURN

  IF @Modulo = 'CXC'
    DECLARE crMovD CURSOR FOR
     SELECT c.Agente, c.PersonalCobrador, d.Renglon, d.RenglonSub, d.Importe, ISNULL(a.IVAFiscal, 0), ISNULL(a.IEPSFiscal, 0), c.TipoCambio, 
            ISNULL(ISNULL(a.Retencion, 0)/NULLIF(a.Importe, 0)*100, 0), 
            ISNULL(ISNULL(a.Retencion2, 0)/NULLIF(a.Importe, 0)*100, 0), 
            ISNULL(ISNULL(a.Retencion3, 0)/NULLIF(a.Importe, 0)*100, 0), 
            a.Cliente
       FROM Cxc c, CxcD d, Cxc a
      WHERE c.ID = @ID AND d.ID = c.ID AND a.Empresa = c.Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

  IF @Modulo = 'CXP'
    DECLARE crMovD CURSOR FOR
     SELECT NULL, NULL, d.Renglon, d.RenglonSub, d.Importe, ISNULL(a.IVAFiscal, 0), ISNULL(a.IEPSFiscal, 0), c.TipoCambio, 
            ISNULL(ISNULL(a.Retencion, 0)/NULLIF(a.Importe, 0)*100, 0), 
            ISNULL(ISNULL(a.Retencion2, 0)/NULLIF(CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN d.Importe*ISNULL(a.IVAFiscal, 0) ELSE a.Importe END, 0)*100, 0), 
            ISNULL(ISNULL(a.Retencion3, 0)/NULLIF(a.Importe, 0)*100, 0), 
            a.Proveedor
       FROM Cxp c, CxpD d, Cxp a
      WHERE c.ID = @ID AND d.ID = c.ID AND a.Empresa = c.Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Agente, @Personal, @Renglon, @RenglonSub, @ImporteTotal, @IVAFiscal, @IEPSFiscal, @TipoCambio, @pRetencion, @pRetencion2, @pRetencion3, @ContactoDetalle
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Importe = @ImporteTotal - (@ImporteTotal*@IVAFiscal) - (@ImporteTotal*@IEPSFiscal)
      SELECT @Importe = (100*@Importe)/(100-@pRetencion-CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN 0.0 ELSE @pRetencion2 END-@pRetencion3)	-- Importe sin Retenciones
      SELECT @Retencion  = @Importe * (@pRetencion/100.0),
             @Retencion2 = CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN (@ImporteTotal*@IVAFiscal) * (@pRetencion2/100.0) ELSE @Importe * (@pRetencion2/100.0) END,
             @Retencion3 = @Importe * (@pRetencion3/100.0)
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NOT NULL OR @Cuenta = 'TABLA %'
      BEGIN
        IF @Campo = 'IMPORTE TOTAL' 	SELECT @Monto = @ImporteTotal  				ELSE
        IF @Campo = 'IVA FISCAL'	SELECT @Monto = @ImporteTotal*@IVAFiscal        	ELSE
        IF @Campo = 'IEPS FISCAL'	SELECT @Monto = @ImporteTotal*@IEPSFiscal       	ELSE
        IF @Campo = 'IMPORTE S/FISCAL' 	SELECT @Monto = @ImporteTotal-ISNULL(@ImporteTotal*@IVAFiscal, 0.0)-ISNULL(@ImporteTotal*@IEPSFiscal, 0.0) ELSE
        IF @Campo = 'IMPUESTOS'		SELECT @Monto = (@ImporteTotal*@IVAFiscal)+(@ImporteTotal*@IEPSFiscal) ELSE
        IF @Campo = 'RETENCIONES'       SELECT @Monto = @Retencion+@Retencion2+@Retencion3 	ELSE
        IF @Campo = 'RETENCION ISR'     SELECT @Monto = @Retencion				ELSE
        IF @Campo = 'RETENCION IVA'     SELECT @Monto = @Retencion2				ELSE
        IF @Campo = 'RETENCION 3'     	SELECT @Monto = @Retencion3
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, @RenglonSub, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Cuenta = 'TABLA %'
          EXEC spContAutoGetCuentaTabla @Modulo, @Clave, @Nombre, @Monto, @Importe, @Cta OUTPUT, @ContAutoEmpresa = @ContAutoEmpresa

        IF @Cta IS NOT NULL AND (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN --MERJOA4752
          SELECT @Debe = NULL, @Haber = NULL --MERJOA4752
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL --MERJOA4752
          IF @OmitirCentroCostos = 1 --MERJOA4752 
          BEGIN --MERJOA4752
            SELECT @ContUso   = NULL --MERJOA4752 
            SELECT @ContUso2  = NULL --MERJOA4752             
            SELECT @ContUso3  = NULL --MERJOA4752             
          END --MERJOA4752
          ELSE --MERJOA4752 
          BEGIN --MERJOA4752
            SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END --MERJOA4752
          END --MERJOA4752  

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          INSERT #Poliza (
         	     Renglon,  RenglonSub,  Orden,  Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto,  Debe,  Haber,  ContactoEspecifico,                                                                                                                                                ContactoTipo) --REQ 13147
          SELECT @Renglon, @RenglonSub, @Orden, @Cta,   @ContUso,  @ContUso2,  @ContUso3,  @Concepto, @Debe, @Haber, dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) --REQ 13147
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Agente, @Personal, @Renglon, @RenglonSub, @ImporteTotal, @IVAFiscal, @IEPSFiscal, @TipoCambio, @pRetencion, @pRetencion2, @pRetencion3, @ContactoDetalle
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO

/************** spContAutoGasto *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoGasto') and type = 'P') drop procedure dbo.spContAutoGasto
GO
CREATE PROCEDURE spContAutoGasto
                   @Modulo			char(5), 
		   @Clave			varchar(20), 
		   @Nombre			varchar(50), 
		   @ID				int,
		   @Cuenta			varchar(20), 
		   @CuentaOmision		char(20), 
		   @OmitirConcepto		bit,	
		   @OmitirCentroCostos		bit,
		   @CentroCostos		varchar(20), 
		   @CentroCostosSucursal  	varchar(20), 
		   @CentroCostosDestino	  	varchar(20), 
                   @CentroCostosMatriz	  	varchar(20), 
		   @CtaCtoTipo			varchar(20), 
		   @CtaCtoTipoAplica		varchar(20),  
		   @CtaClase			char(20), 
		   @Concepto			varchar(50),
		   @Contacto			char(10),
		   @ContactoTipo		varchar(20),	
		   @CtaDinero			char(10),
		   @CtaDineroDestino		char(10),
		   @FormaPago			varchar(50), 	
		   @Orden			int,
    		   @Campo			varchar(20),
		   @EsDebe			bit,
		   @CfgClaseConceptoGastos 	bit,
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte	bit,
                   @IncluirDepartamento		bit,
                   @ContAutoContactoEsp		varchar(50),
                   @ContAutoEmpresa		varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @RenglonSub			int,
    @Almacen			char(10),
    @AlmacenTipo		varchar(20),
    @ContUso			char(20),
    @ContUso2			char(20),
    @ContUso3			char(20),
    @Articulo			char(20),
    @TipoCambio			float,
    @Importe			money,
    @Provision			money,
    @Impuestos			money, 
    @Retencion1			money, 
    @Retencion2			money, 
    @Retencion3			money, 
    @Retenciones		money, 
    @ImporteTotal		money,
    @Clase			varchar(50),
    @SubClase			varchar(50),
    @Cta			char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @PorcentajeDeducible 	float,
    @DepartamentoDetallista	int,
    @Impuesto1Excento		bit,
    @Excento			bit,
    @Personal			varchar(10),
    @EndosarA			varchar(10),
    @ContactoDetalle		varchar(10),
    @TipoImpuesto1		varchar(10), 
    @TipoImpuesto2		varchar(10), 
    @TipoImpuesto3		varchar(10), 
    @TipoImpuesto5		varchar(10), 
    @TipoRetencion1		varchar(10), 
    @TipoRetencion2		varchar(10), 
    @TipoRetencion3		varchar(10)

  IF @Campo IS NULL RETURN
-- concepto
  DECLARE crMovD CURSOR FOR
   SELECT d.Renglon, d.RenglonSub, d.ContUso, d.ContUso2, d.ContUso3, d.Concepto, d.TipoCambio, d.ImporteLinea, d.ImpuestosLinea, d.Retencion1, d.Retencion2, d.Retencion3, d.RetencionLinea, d.TotalLinea, ISNULL(d.PorcentajeDeducible, 0.0), d.Provision, d.Impuesto1Excento, d.Personal, d.EndosarA,
          d.TipoImpuesto1, d.TipoImpuesto2, d.TipoImpuesto3, d.TipoImpuesto5, d.TipoRetencion1, d.TipoRetencion2, d.TipoRetencion3
     FROM GastoT d
    WHERE d.ID = @ID

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @ContUso, @ContUso2, @ContUso3, @Concepto, @TipoCambio, @Importe, @Impuestos, @Retencion1, @Retencion2, @Retencion3, @Retenciones, @ImporteTotal, @PorcentajeDeducible, @Provision, @Impuesto1Excento, @Personal, @EndosarA,
                              @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Excento = 0
      SELECT @Monto = NULL, @Cta = NULL, @DepartamentoDetallista = NULL
      IF @CfgClaseConceptoGastos = 1 AND UPPER(@Cuenta) = 'CLASIFICACION' 
      BEGIN
        SELECT @Clase = Clase, @SubClase = SubClase FROM Concepto WHERE Modulo = @Modulo AND Concepto = @Concepto
        EXEC spCuentaClase @Modulo, @Clase, @SubClase, @CtaClase OUTPUT
      END

	  IF UPPER(@Cuenta) = 'CONCEPTO CONTX'
	  BEGIN
		SELECT @Cta = c.CuentaContable FROM Gastod g JOIN ContXCta c ON c.Cuenta=g.Concepto 
          JOIN CtaSub cc ON c.CuentaContable=cc.Cuenta AND cc.Subcuenta=g.ContUso 
          WHERE cc.Subcuenta=@ContUso AND g.Concepto=@Concepto AND g.ID=@ID
	  END

	  IF @Cta IS NULL
       EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                                @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NOT NULL OR @Cuenta = 'TABLA %'
      BEGIN
             IF @Campo = 'IMPORTE' 		SELECT @Monto = @Importe
        ELSE IF @Campo = 'RETENCION 1'  	SELECT @Monto = @Retencion1
        ELSE IF @Campo = 'RETENCION 2'  	SELECT @Monto = @Retencion2
        ELSE IF @Campo = 'RETENCION 3'  	SELECT @Monto = @Retencion3
        ELSE IF @Campo = 'RETENCIONES'  	SELECT @Monto = @Retenciones
        ELSE IF @Campo = 'IMPUESTOS'     	SELECT @Monto = @Impuestos, @Excento = @Impuesto1Excento 
        ELSE IF @Campo = 'IMPORTE TOTAL' 	SELECT @Monto = @ImporteTotal
        ELSE IF @Campo = 'IMPORTE DEDUCIBLE'    SELECT @Monto = @Importe*(@PorcentajeDeducible/100.0)
        ELSE IF @Campo = 'IMPUESTO DEDUCIBLE'   SELECT @Monto = @Impuestos*(@PorcentajeDeducible/100.0)
        ELSE IF @Campo = 'TOTAL DEDUCIBLE'      SELECT @Monto = @ImporteTotal*(@PorcentajeDeducible/100.0)
        ELSE IF @Campo = 'IMPORTE N/DEDUCIBLE'  SELECT @Monto = @Importe*(1-(@PorcentajeDeducible/100.0))
        ELSE IF @Campo = 'IMPUESTO N/DEDUCIBLE' SELECT @Monto = @Impuestos*(1-(@PorcentajeDeducible/100.0))
        ELSE IF @Campo = 'TOTAL N/DEDUCIBLE'    SELECT @Monto = @ImporteTotal*(1-(@PorcentajeDeducible/100.0))
        ELSE IF @Campo = 'IMPORTE S/PROVISION'  SELECT @Monto = @Importe-@Provision
        ELSE IF @Campo = 'PROVISION'            SELECT @Monto = @Provision
	ELSE IF @Campo = 'IMPORTE NETO GT'		SELECT @Monto = @Importe - ISNULL(@Retencion1,0.0)

        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, @RenglonSub, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        --ELSE IF @Campo = 'MERMA DEPARTAMENTO'   SELECT @Monto = @Importe * (dd.Merma/100.0) FROM Concepto c, DepartamentoDetallista dd WHERE c.Modulo = @Modulo AND c.Concepto = @Concepto AND dd.Departamento = c.DepartamentoDetallista

        IF @Cuenta = 'TABLA %'
          EXEC spContAutoGetCuentaTabla @Modulo, @Clave, @Nombre, @Monto, @Importe, @Cta OUTPUT, @Excento = @Excento, @ContAutoEmpresa = @ContAutoEmpresa

        IF @Cta IS NOT NULL AND (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 
		  BEGIN
			SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL 
		  END ELSE 
			SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          IF @IncluirDepartamento = 1 SELECT @DepartamentoDetallista = DepartamentoDetallista FROM Concepto WHERE Modulo = @Modulo AND Concepto = @Concepto
          INSERT #Poliza (
          	     Renglon,  RenglonSub,  Orden,  Cuenta, SubCuenta, SubCuenta2, SubCuenta3,  Concepto,  DepartamentoDetallista,  Debe,  Haber, ContactoEspecifico,                                                                                                                            ContactoTipo) --REQ 13147
          SELECT @Renglon, @RenglonSub, @Orden, @Cta,   @ContUso,   @ContUso2, @ContUso3,   @Concepto, @DepartamentoDetallista, @Debe, @Haber, dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, NULL, @EndosarA, NULL, @Personal, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) --REQ 13147
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @ContUso, @ContUso2, @ContUso3, @Concepto, @TipoCambio, @Importe, @Impuestos, @Retencion1, @Retencion2, @Retencion3, @Retenciones, @ImporteTotal, @PorcentajeDeducible, @Provision, @Impuesto1Excento, @Personal, @EndosarA,
                                @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO


/************** spContAutoAF *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoAF') and type = 'P') drop procedure dbo.spContAutoAF
GO
CREATE PROCEDURE spContAutoAF
                   @Modulo		  char(5), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  char(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20),		
		   @CtaClase		  char(20), 
		   @Concepto		  varchar(50),
		   @Contacto		  char(10),
		   @ContactoTipo	  varchar(20), 
		   @CtaDinero		  char(10),
		   @CtaDineroDestino	  char(10),
		   @FormaPago		  varchar(50), 	
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @RenglonSub			int,
    @Almacen			char(10),
    @Articulo			char(20),
    @Importe			money,
    @Impuestos			money, 
    @Depreciacion		money, 
    @ActualizacionCapital	money, 
    @ActualizacionGastos	money, 
    @ActualizacionDepreciacion	money, 
    @TipoCambio			float,
    @Cta			char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @ContUso		char(20),

    -- 9036
    @ContUso2		char(20),
    @ContUso3		char(20)

  IF @Campo IS NULL RETURN
  
   -- 9036
  DECLARE crMovD CURSOR FOR
   SELECT d.Renglon, d.RenglonSub, d.Articulo, d.Importe, d.Impuestos, d.Depreciacion, d.ActualizacionCapital, d.ActualizacionGastos, d.ActualizacionDepreciacion, e.TipoCambio, af.CentroCostos, af.Almacen,
          af.ContUso2, af.ContUso3
     FROM ActivoFijoD d, ActivoFijo e, ActivoF af
    WHERE e.ID = d.ID AND e.ID = @ID 
      AND af.Empresa = e.Empresa AND af.Articulo = d.Articulo AND af.Serie = d.Serie

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @Articulo, @Importe, @Impuestos, @Depreciacion, @ActualizacionCapital, @ActualizacionGastos, @ActualizacionDepreciacion, @TipoCambio, @ContUso, @Almacen, @ContUso2, @ContUso3
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, @Almacen, 'ACTIVOS FIJOS', @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, @Almacen, 'ACTIVOS FIJOS', @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo = 'IMPORTE'   	SELECT @Monto = @Importe 		ELSE
        IF @Campo = 'IMPUESTOS'   	SELECT @Monto = @Impuestos		ELSE
        IF @Campo = 'DEPRECIACION'   	SELECT @Monto = @Depreciacion		ELSE
        IF @Campo = 'ACT. CAPITAL'   	SELECT @Monto = @ActualizacionCapital	ELSE
        IF @Campo = 'ACT. GASTOS'   	SELECT @Monto = @ActualizacionGastos	ELSE
        IF @Campo = 'ACT. DEPRECIACION' SELECT @Monto = @ActualizacionDepreciacion
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, @RenglonSub, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          
          -- 9036
          IF @OmitirCentroCostos = 1 
            SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL
          ELSE SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          -- 9036
          INSERT #Poliza (Renglon,  RenglonSub,  Orden,  Cuenta, SubCuenta, Concepto,  Debe,  Haber, SubCuenta2, SubCuenta3)  
                  VALUES (@Renglon, @RenglonSub, @Orden, @Cta,   @ContUso,  @Concepto, @Debe, @Haber, @ContUso2, @ContUso3)
        END
      END
    END    
    -- 9036
    FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @Articulo, @Importe, @Impuestos, @Depreciacion, @ActualizacionCapital, @ActualizacionGastos, @ActualizacionDepreciacion, @TipoCambio, @ContUso, @Almacen, @ContUso2, @ContUso3
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO

/************** spContAutoCP *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoCP') and type = 'P') drop procedure dbo.spContAutoCP
GO
CREATE PROCEDURE spContAutoCP
                   @Modulo		  char(5), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  char(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20),		
		   @CtaClase		  char(20), 
		   @Concepto		  varchar(50),
		   @Contacto		  char(10),
		   @ContactoTipo	  varchar(20), 
		   @CtaDinero		  char(10),
		   @CtaDineroDestino	  char(10),
		   @FormaPago		  varchar(50), 	
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @ClavePresupuestal		varchar(50),
    @Presupuesto		money,
    @Comprometido		money,
    @Comprometido2		money,
    @Devengado			money,
    @Devengado2			money,
    @Ejercido			money,
    @EjercidoPagado		money,
    @Anticipos			money,
    @RemanenteDisponible	money,
    @Sobrante			money,
    @Importe			money,
    @TipoCambio			float,
    @Cta			char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @ContUso			char(20)

  IF @Campo IS NULL RETURN

  DECLARE crMovD CURSOR FOR
   SELECT d.Renglon, d.ClavePresupuestal, d.Presupuesto, d.Comprometido, d.Comprometido2, d.Devengado, d.Devengado2, d.Ejercido, d.EjercidoPagado, d.Anticipos, d.RemanenteDisponible, d.Sobrante, d.Importe, c.TipoCambio
     FROM CPD d
     JOIN CP c ON c.ID = d.ID 
    WHERE d.ID = @ID

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Renglon, @ClavePresupuestal, @Presupuesto, @Comprometido, @Comprometido2, @Devengado, @Devengado2, @Ejercido, @EjercidoPagado, @Anticipos, @RemanenteDisponible, @Sobrante, @Importe, @TipoCambio
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo = 'PRESUPUESTO'   	   SELECT @Monto = @Presupuesto 	ELSE
        IF @Campo = 'COMPROMETIDO'   	   SELECT @Monto = @Comprometido	ELSE
        IF @Campo = 'COMPROMETIDO 2'   	   SELECT @Monto = @Comprometido2	ELSE
        IF @Campo = 'DEVENGADO'   	   SELECT @Monto = @Devengado		ELSE
        IF @Campo = 'DEVENGADO 2'   	   SELECT @Monto = @Devengado2		ELSE
        IF @Campo = 'EJERCIDO'		   SELECT @Monto = @Ejercido		ELSE
        IF @Campo = 'EJERCIDO PAGADO'	   SELECT @Monto = @EjercidoPagado	ELSE
        IF @Campo = 'ANTICIPOS'		   SELECT @Monto = @Anticipos		ELSE
        IF @Campo = 'REMANENTE DISPONIBLE' SELECT @Monto = @RemanenteDisponible ELSE
        IF @Campo = 'SOBRANTE'		   SELECT @Monto = @Sobrante		ELSE
        IF @Campo = 'IMPORTE'		   SELECT @Monto = @Importe
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, NULL, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT


        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 SELECT @ContUso  = NULL ELSE SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          INSERT #Poliza (Renglon,  Orden,  Cuenta, SubCuenta, Concepto,  Debe,  Haber)  
                  VALUES (@Renglon, @Orden, @Cta,   @ContUso,  @Concepto, @Debe, @Haber)
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Renglon, @ClavePresupuestal, @Presupuesto, @Comprometido, @Comprometido2, @Devengado, @Devengado2, @Ejercido, @EjercidoPagado, @Anticipos, @RemanenteDisponible, @Sobrante, @Importe, @TipoCambio
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD

  RETURN
END
GO


/************** spContAutoFiscal *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoFiscal') and type = 'P') drop procedure dbo.spContAutoFiscal
GO
CREATE PROCEDURE spContAutoFiscal
                   @Modulo		  char(5), 
		   @Clave		  varchar(20), 
		   @Nombre		  varchar(50), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  char(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20),		
		   @CtaClase		  char(20), 
		   @Concepto		  varchar(50),
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit,
		   @ObligacionFiscal	  varchar(50),
		   @ContAutoEmpresa	  varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @Cta			char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @ContUso			char(20),
    @Importe			money, 
    @OtrosImpuestos		money, 
    @Base			money, 
    @BaseDeducible		money, 
    @BaseNoDeducible		money, 
    @Tasa			float,
    @Deducible			float,
    @Excento			bit,
    @Neto			money, 
    @NetoNoDeducible		money, 
    @Contacto			varchar(10), 
    @ContactoTipo		varchar(20), 
    @TipoCambio			float,
    @Articulo			varchar(20)

  IF @Campo IS NULL RETURN

  DECLARE crMovD CURSOR FOR
   SELECT e.TipoCambio, d.Renglon, d.ObligacionFiscal, d.Importe, d.OtrosImpuestos, d.Base, d.Tasa, d.Deducible, ISNULL(d.Excento, 0), d.Neto, d.Contacto, d.ContactoTipo, d.AFArticulo
     FROM FiscalD d
     JOIN Fiscal e ON e.ID = d.ID
    WHERE d.ID = @ID AND d.ObligacionFiscal = ISNULL(@ObligacionFiscal, d.ObligacionFiscal)

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @TipoCambio, @Renglon, @ObligacionFiscal, @Importe, @OtrosImpuestos, @Base, @Tasa, @Deducible, @Excento, @Neto, @Contacto, @ContactoTipo, @Articulo
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, NULL, @ContactoTipo, @Concepto, @Contacto, @ContactoTipo, NULL, NULL, NULL, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, NULL, @ContactoTipo, @Concepto, @Contacto, @ContactoTipo, NULL, NULL, NULL, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cuenta = 'TABLA %'
        SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND ROUND(ISNULL(Porcentaje, 0.0), 10) = ROUND(ISNULL(@Tasa, 0.0), 10) AND Excento = @Excento
      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo IN ('Ingreso Acumulable', 'Deduccion Fiscal') SELECT @Monto = @Base	ELSE
        IF @Campo = 'No Deducibles'		SELECT @Monto = @Base*((100.0-@Deducible)/100.0)	ELSE
        IF @Campo = 'Impuesto Generado'         SELECT @Monto = @Neto					ELSE
        IF @Campo = 'Impuesto Acreditable'	SELECT @Monto = @Neto					ELSE
		IF @Campo = 'Retencion Pagar'	SELECT @Monto = @Neto				ELSE
		IF @Campo = 'Retencion Acreditar'	SELECT @Monto = @Neto		ELSE
        IF @Campo = 'Impuesto No Acredita'	SELECT @Monto = @Base*((100.0-@Deducible)/100.0)*(@Tasa/100.0) 
/*
        IF @Campo = 'BASE G DED/ACUM'		SELECT @Monto = @Base*(@Deducible/100.0)		
        IF @Campo = 'IMPUESTO TOTAL'		SELECT @Monto = @Neto+(@Base*((100.0-@Deducible)/100.0)*(@Tasa/100.0))*/

        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, NULL, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 SELECT @ContUso  = NULL ELSE SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          INSERT #Poliza (Renglon,  Orden,  Cuenta, SubCuenta, Concepto,  Debe,  Haber)  
                  VALUES (@Renglon, @Orden, @Cta,   @ContUso,  @Concepto, @Debe, @Haber)
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @TipoCambio, @Renglon, @ObligacionFiscal, @Importe, @OtrosImpuestos, @Base, @Tasa, @Deducible, @Excento, @Neto, @Contacto, @ContactoTipo, @Articulo
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO


/************** spContAutoPC *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoPC') and type = 'P') drop procedure dbo.spContAutoPC
GO
CREATE PROCEDURE spContAutoPC
                   @Modulo		  char(5), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  char(20), 
		   @OmitirConcepto	  bit,
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20), 
		   @CtaClase		  char(20), 
		   @Concepto		  varchar(50),
		   @Contacto		  char(10),
		   @ContactoTipo	  varchar(20), 
		   @CtaDinero		  char(10),
		   @CtaDineroDestino	  char(10),
		   @FormaPago		  varchar(50), 	
		   @Orden		  int,
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit,
		   @CfgContArticulo	  bit,
                   @IncluirArticulos	  bit,
		   @IncluirDepartamento	  bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @Articulo			char(20),
    @PrecioNuevo		money,
    @PrecioAnterior		money,
    @ExistenciaSucursal		float,
    @TipoCambio			float,
    @Cta			char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @ContUso			char(20),
    @DepartamentoDetallista	int 

  IF @Campo IS NULL RETURN

  DECLARE crMovD CURSOR FOR
   SELECT d.Renglon, d.Articulo, d.Nuevo, d.Anterior, d.ExistenciaSucursal, e.TipoCambio
     FROM PCD d, PC e
    WHERE e.ID = d.ID AND e.ID = @ID 

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Renglon, @Articulo, @PrecioNuevo, @PrecioAnterior, @ExistenciaSucursal, @TipoCambio
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Articulo, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo = 'INCREMENTO' AND @PrecioNuevo > @PrecioAnterior SELECT @Monto = (@PrecioNuevo - @PrecioAnterior) * @ExistenciaSucursal ELSE
        IF @Campo = 'DECREMENTO' AND @PrecioNuevo < @PrecioAnterior SELECT @Monto = (@PrecioAnterior - @PrecioNuevo) * @ExistenciaSucursal 
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, NULL, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL, @DepartamentoDetallista = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 SELECT @ContUso  = NULL ELSE SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          IF @IncluirDepartamento = 1 SELECT @DepartamentoDetallista = DepartamentoDetallista FROM Art WHERE Articulo = @Articulo
          IF @CfgContArticulo = 0 OR @IncluirArticulos = 0 SELECT @Articulo = NULL
          INSERT #Poliza (Renglon,  Orden,  Cuenta, SubCuenta, Concepto,  Articulo,  DepartamentoDetallista,  Debe,  Haber)  
                  VALUES (@Renglon, @Orden, @Cta,   @ContUso,  @Concepto, @Articulo, @DepartamentoDetallista, @Debe, @Haber)
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Renglon, @Articulo, @PrecioNuevo, @PrecioAnterior, @ExistenciaSucursal, @TipoCambio
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO

/************** spContAutoNomina *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoNomina') and type = 'P') drop procedure dbo.spContAutoNomina
GO
CREATE PROCEDURE spContAutoNomina
		   @Empresa		  char(5),
                   @Modulo		  char(5), 
		   @ID			  int,
		   @Cuenta		  varchar(20), 
		   @CuentaOmision	  char(20), 
		   @OmitirConcepto	  bit,	
	           @QueConcepto		  varchar(20), 
		   @OmitirCentroCostos	  bit,
		   @CentroCostos	  varchar(20), 
		   @CentroCostosSucursal  varchar(20), 
		   @CentroCostosDestino	  varchar(20), 
                   @CentroCostosMatriz	  varchar(20), 
		   @CtaCtoTipo		  varchar(20), 
		   @CtaCtoTipoAplica	  varchar(20), 
		   @CtaClase		  char(20), 
		   @Concepto		  varchar(50),
		   @Contacto		  char(10),
		   @ContactoTipo	  varchar(20), 
		   @CtaDinero		  char(10),
		   @CtaDineroDestino	  char(10),
		   @FormaPago		  varchar(50),  	
		   @Orden		  int,
		   @Condicion 		  varchar(50),
    		   @Campo		  varchar(20),
		   @EsDebe		  bit,
		   @Ok			  int		OUTPUT,
		   @OkRef		  varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte bit,
		   @ContAutoContactoEsp	  varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @RenglonModulo		char(5),
    @Almacen			char(10),
    @AlmacenTipo		varchar(20),
    @ContUso			char(20),
    @Articulo			char(20),
    @TipoCambio			float,
    @Importe			money,
    @Cta			char(20),
    @CtaConcepto		char(20),
    @CtaConcepto2		char(20),
    @Monto			money,
    @Debe			money,
    @Haber			money,
    @Movimiento			varchar(20),
    @ContPersonalSucursal	bit,
    @SucursalContable		int,
    @Personal			varchar(10)

  SELECT @ContPersonalSucursal = ISNULL(ContPersonalSucursal, 0) FROM EmpresaGral WHERE Empresa = @Empresa

  IF @Campo IS NULL RETURN

  IF @Campo = 'IMPORTE'
    DECLARE crMovD CURSOR FOR
     SELECT d.Personal, d.Renglon, d.Modulo, p.SucursalTrabajo, p.CentroCostos, CASE WHEN @QueConcepto = 'Detalle' THEN d.Concepto ELSE e.Concepto END, e.TipoCambio, d.Importe, d.Movimiento, NULLIF(RTRIM(d.CuentaContable), ''), NULLIF(RTRIM(nc.Cuenta2), '')
       FROM Nomina e
       JOIN NominaD d ON d.ID = e.ID /*AND d.Modulo = 'NOM' */
       JOIN Personal p ON p.Personal = d.Personal
       LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
      WHERE e.ID = @ID 
  ELSE
  IF @Campo IN ('IMPORTE TESORERIA', 'IMPORTE CXP')
    DECLARE crMovD CURSOR FOR
     SELECT d.Personal, d.Renglon, d.Modulo, p.SucursalTrabajo, p.CentroCostos, CASE WHEN @QueConcepto = 'Detalle' THEN d.Concepto ELSE e.Concepto END, e.TipoCambio, d.Importe, d.Movimiento, NULLIF(RTRIM(d.CuentaContable), ''), NULLIF(RTRIM(nc.Cuenta2), '')
       FROM Nomina e
       JOIN NominaD d ON d.ID = e.ID /*AND d.Modulo = 'NOM' */
       LEFT OUTER JOIN Personal p ON p.Personal = d.Personal
       LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
      WHERE e.ID = @ID 
  ELSE
  IF @Campo = 'IMPORTE ESTADISTICA'
    DECLARE crMovD CURSOR FOR
     SELECT d.Personal, d.Renglon, d.Modulo, p.SucursalTrabajo, p.CentroCostos, CASE WHEN @QueConcepto = 'Detalle' THEN d.Concepto ELSE e.Concepto END, e.TipoCambio, d.Importe, d.Movimiento, NULLIF(RTRIM(d.CuentaContable), ''), NULLIF(RTRIM(nc.Cuenta2), '')
       FROM Nomina e
       JOIN NominaD d ON d.ID = e.ID /*AND d.Modulo = 'NOM' */AND UPPER(d.Movimiento) = 'ESTADISTICA'
       JOIN Personal p ON p.Personal = d.Personal
       LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
      WHERE e.ID = @ID 
  ELSE
    DECLARE crMovD CURSOR FOR
     SELECT d.Personal, d.Renglon, d.Modulo, p.SucursalTrabajo, p.CentroCostos, CASE WHEN @QueConcepto = 'Detalle' THEN d.Concepto ELSE e.Concepto END, e.TipoCambio, d.Importe, d.Movimiento, NULLIF(RTRIM(d.CuentaContable), ''), NULLIF(RTRIM(nc.Cuenta2), '')
       FROM Nomina e
       JOIN NominaD d ON d.ID = e.ID /*AND d.Modulo = 'NOM' */AND UPPER(d.Movimiento) IN ('PERCEPCION', 'DEDUCCION')
       JOIN Personal p ON p.Personal = d.Personal
       LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
      WHERE e.ID = @ID 
  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Personal, @Renglon, @RenglonModulo, @SucursalContable, @ContUso, @Concepto, @TipoCambio, @Importe, @Movimiento, @CtaConcepto, @CtaConcepto2
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      IF @ContPersonalSucursal = 0 SELECT @SucursalContable = NULL
      SELECT @Monto = NULL, @Cta = NULL
      IF UPPER(@Cuenta) = 'CONCEPTO RECIBO' AND @CtaConcepto IS NOT NULL
        SELECT @Cta = @CtaConcepto
      ELSE
      IF UPPER(@Cuenta) = 'CONCEPTO RECIBO 2' AND @CtaConcepto2 IS NOT NULL
        SELECT @Cta = @CtaConcepto2
      ELSE 
        EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @CtaConcepto IS NULL AND @Condicion = 'CONCEPTO RECIBO C/CUENTA'
        SELECT @Cta = NULL

      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo IN ('IMPORTE', 'IMPORTE ESTADISTICA')
          SELECT @Monto = @Importe
        ELSE
        IF @Campo = 'IMPORTE NETO'
        BEGIN
          IF UPPER(@Movimiento) = 'PERCEPCION' SELECT @Monto = @Importe ELSE
          IF UPPER(@Movimiento) = 'DEDUCCION'  SELECT @Monto = -@Importe 
        END ELSE
        IF @Campo = 'IMPORTE PERCEPCIONES' AND UPPER(@Movimiento) = 'PERCEPCION' SELECT @Monto = @Importe ELSE
        IF @Campo = 'IMPORTE DEDUCCIONES'  AND UPPER(@Movimiento) = 'DEDUCCION'  SELECT @Monto = @Importe ELSE
        IF @Campo = 'IMPORTE TESORERIA'    AND @RenglonModulo     = 'DIN'        SELECT @Monto = @Importe ELSE
        IF @Campo = 'IMPORTE CXP' 	   AND @RenglonModulo     = 'CXP'        SELECT @Monto = @Importe 
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, NULL, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 SELECT @ContUso  = NULL ELSE SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          INSERT #Poliza (
        	     Renglon,  Orden,  Cuenta, SubCuenta, Concepto,  Debe,  Haber,  SucursalContable,  ContactoEspecifico,                                                                                              ContactoTipo) --REQ 13147
          SELECT @Renglon, @Orden, @Cta,   @ContUso,  @Concepto, @Debe, @Haber, @SucursalContable, dbo.fnContactoEspecifico(@ContAutoContactoEsp, NULL, NULL, NULL, NULL, @Personal, NULL, NULL, NULL, NULL, NULL), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) --REQ 13147
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Personal, @Renglon, @RenglonModulo, @SucursalContable, @ContUso, @Concepto, @TipoCambio, @Importe, @Movimiento, @CtaConcepto, @CtaConcepto2
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO


/************** spContAutoDinero *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoDinero') and type = 'P') drop procedure dbo.spContAutoDinero
GO
CREATE PROCEDURE spContAutoDinero
           @Modulo					char(5), 
		   @ID						int,
		   @Cuenta					varchar(20), 
		   @CuentaOmision			char(20), 
		   @OmitirConcepto			bit,
		   @OmitirCentroCostos		bit,
		   @CentroCostos			varchar(20), 
		   @CentroCostosSucursal	varchar(20), 
		   @CentroCostosDestino		varchar(20), 
           @CentroCostosMatriz		varchar(20), 
		   @Concepto				varchar(50),
		   @Orden					int,
    	   @Campo					varchar(20),
		   @EsDebe					bit,
		   @Ok						int		OUTPUT,
		   @OkRef					varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte	bit,
		   @Cta						char(20),
		   @SucursalContable		varchar(20),
		   @ContAutoContactoEsp		varchar(50),
		   @Contacto				varchar(10),
           @ContactoAplica			varchar(10),
		   @ContactoTipo			varchar(20) --REQ 13147

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Renglon		float,
    @RenglonSub		int,
    @Importe		float, --BUG12841
    @Impuestos		float, --BUG12841
    @IVAFiscal		float, --BUG12841
    @IEPSFiscal		float, --BUG12841
    @ImporteTotal	float, --BUG12841
    @ImporteDetalle	float, --BUG12841
    @TipoCambio		float,
    @FormaPago		varchar(50),
    @ContUso		char(20),
    @ContUso2		char(20), --MEJORA4752    
    @ContUso3		char(20), --MEJORA4752            
    @Monto			float, --BUG12841
    @Debe			float, --BUG12841
    @Haber			float, --BUG12841
    @Dias			int,
    @TasaDiaria		float, --BUG12841
    @AplicaSucursal	int,
    @PolizaSucursal	int,
    @ContactoDetalle	varchar(10),
    @CtaDinero		varchar(10),
    @CtaDineroDestino	varchar(10),
    @Agente		varchar(10)

  IF @Campo IS NULL RETURN
  SELECT @Empresa = Empresa,
         @TipoCambio = TipoCambio, 
         @Importe = Importe, 
         @Impuestos = Impuestos, 
         @IVAFiscal = (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IVAFiscal, 
         @IEPSFiscal = (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*IEPSFiscal,
         @Dias = DATEDIFF(day, FechaOrigen, Vencimiento),
         @TasaDiaria = Tasa / NULLIF(TasaDias, 0),
         @ContUso = ContUso,
         @ContUso2 = ContUso2, --MEJORA4752
         @ContUso3 = ContUso3, --MEJORA4752                  
         @CtaDinero = CtaDinero,
         @CtaDineroDestino = CtaDineroDestino,
         @Agente = Cajero
    FROM Dinero 
   WHERE ID = @ID
  SELECT @ImporteTotal = @Importe + @Impuestos

  DECLARE crMovD CURSOR FOR
   SELECT d.Renglon, d.RenglonSub, d.FormaPago, d.Importe, ISNULL(d.ContUso,@ContUso), ISNULL(d.ContUso2,@ContUso2), ISNULL(d.ContUso3,@ContUso3), a.Sucursal, a.Contacto --MEJORA4752
     FROM DineroD d
     LEFT OUTER JOIN Dinero a ON a.Empresa = @Empresa AND a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Estatus IN ('PENDIENTE', 'CONCLUIDO')
    WHERE d.ID = @ID

  OPEN crMovD
  FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @FormaPago, @ImporteDetalle, @ContUso, @ContUso2, @ContUso3, @AplicaSucursal, @ContactoDetalle
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      IF UPPER(@SucursalContable) = 'DETALLE' SELECT @PolizaSucursal = @AplicaSucursal ELSE SELECT @PolizaSucursal = NULL

      IF @Cta IS NULL
        SELECT @Cta = Cuenta FROM FormaPago WHERE FormaPago = @FormaPago
      IF @Cta IS NULL
        EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, NULL, NULL, NULL, NULL, NULL, NULL, @Concepto, NULL, NULL, NULL, NULL, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      IF @Cta IS NOT NULL
      BEGIN
        IF @Campo = 'IMPORTE' 		SELECT @Monto = @ImporteDetalle*@Importe/@ImporteTotal		ELSE
        IF @Campo = 'IMPUESTOS'     	SELECT @Monto = @ImporteDetalle*@Impuestos/@ImporteTotal	ELSE
        IF @Campo = 'IVA FISCAL'     	SELECT @Monto = @ImporteDetalle*@IVAFiscal/@ImporteTotal	ELSE
        IF @Campo = 'IEPS FISCAL'     	SELECT @Monto = @ImporteDetalle*@IEPSFiscal/@ImporteTotal	ELSE
        IF @Campo = 'IMPORTE TOTAL' 	SELECT @Monto = @ImporteDetalle					ELSE
        IF @Campo = 'INTERESES' 	SELECT @Monto = @ImporteDetalle*@Dias*(@TasaDiaria/100.0)		
        ELSE EXEC xpContAutoCampoExtra @Modulo, @ID, @Renglon, @RenglonSub, @Campo, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 
          BEGIN
            SELECT @ContUso   = NULL 
            SELECT @ContUso2  = NULL             
            SELECT @ContUso3  = NULL             
          END
          ELSE 
          BEGIN
            SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END
          END
          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          INSERT #Poliza (
          	      Renglon,  RenglonSub,  Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto,  Debe,  Haber,  SucursalContable, ContactoEspecifico,                                                                                                                                           ContactoTipo) --MEJORA4752 --REQ 13147
          SELECT @Renglon, @RenglonSub, @Orden, @Cta,   @ContUso,  @ContUso2,  @ContUso3,  @Concepto, @Debe, @Haber, @PolizaSucursal,  dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, NULL, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) --MEJORA4752 --REQ 13147
          IF @Cuenta = 'FORMA PAGO' SELECT @Cta = NULL
        END
      END
    END
    FETCH NEXT FROM crMovD INTO @Renglon, @RenglonSub, @FormaPago, @ImporteDetalle, @ContUso, @ContUso2, @ContUso3, @AplicaSucursal, @ContactoDetalle --MEJORA4752
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovD
  DEALLOCATE crMovD
  RETURN
END
GO

/************** spContAutoMovImpuesto *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoMovImpuesto') and type = 'P') drop procedure dbo.spContAutoMovImpuesto
GO
CREATE PROCEDURE spContAutoMovImpuesto
                 @Modulo					char(5), 
				 @Clave						varchar(20), 
				 @Nombre					varchar(50), 
				 @ID						int,
				 @Cuenta					varchar(20), 
				 @CuentaOmision				char(20), 
				 @OmitirConcepto			bit,
				 @OmitirCentroCostos		bit,
				 @CentroCostos				varchar(20), 
				 @CentroCostosSucursal		varchar(20), 
				 @CentroCostosDestino		varchar(20), 
				 @CentroCostosMatriz		varchar(20), 
				 @CtaCtoTipo				varchar(20), 
				 @CtaCtoTipoAplica			varchar(20),  
				 @CtaClase					char(20), 
				 @Concepto					varchar(50),
				 @Contacto					char(10),
				 @ContactoTipo				varchar(20),
				 @CtaDinero					char(10),
				 @CtaDineroDestino			char(10),
				 @FormaPago					varchar(50), 	
				 @Orden						int,
    			 @Campo						varchar(20),
				 @EsDebe					bit,
				 @Ok						int				OUTPUT,
				 @OkRef						varchar(255)	OUTPUT,
				 @CfgPartidasSinImporte		bit,
    			 @TipoCambio				float,
    		     @ContAutoContactoEsp		varchar(50),
    		     @ContactoAplica			varchar(10),
    		     @ContAutoEmpresa			varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Impuesto1						float,
    @Impuesto2						float,
    @Impuesto3						float,
    @Impuesto5						float,
    @Retencion1						float,
    @Retencion2						float,
    @Retencion3						float,
    @Importe1						money,
    @Importe2						money,
    @Importe3						money,
    @Importe5						money,
    @ImporteRetencion1				money, 
    @ImporteRetencion2				money, 
    @ImporteRetencion3 				money,
    @Excento1						bit,
    @Cta							char(20),
    @ContUso						varchar(20),
    @LoteFijo						varchar(50),
    @OrigenModulo					varchar(5),
    @OrigenModuloID					varchar(20),
    @OrigenConcepto					varchar(50),
    @OrigenFecha					datetime,
    @Monto							money,
    @Debe							money,
    @Haber							money,
    @ContUso2						varchar(20),
    @ContUso3						varchar(20),
    @SubTotal						money,
    @Total							money,
    @DescuentoGlobal				float,    
    @DescuentoImporte				money,
    @TotalBruto						money,
    @ContactoArrastre				varchar(10),
    @ContactoEspecifico				varchar(10),
    @CfgRetencion2BaseImpuesto1		bit,
    @TipoImpuesto1					varchar(10), 
    @TipoImpuesto2					varchar(10), 
    @TipoImpuesto3					varchar(10), 
    @TipoImpuesto5					varchar(10), 
    @TipoRetencion1					varchar(10), 
    @TipoRetencion2					varchar(10), 
    @TipoRetencion3					varchar(10), 
	@RetencionIVA					varchar(10)

  SELECT @CfgRetencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version   
  SELECT @ContUso  = NULL
  IF @Campo IS NULL RETURN

  DECLARE crMovImpuesto CURSOR FOR
   SELECT OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha, Retencion1, Retencion2, Retencion3, LoteFijo, ContUso, ContUso2, ContUso3, Impuesto1, Impuesto2, Impuesto3, Impuesto5, SUM(Importe1), SUM(Importe2), SUM(Importe3), SUM(Importe5), SUM(SubTotal*(Retencion1/100.0)), SUM(CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN Importe1 ELSE SubTotal END*(Retencion2/100.0)), SUM(SubTotal*(Retencion3/100.0)), Excento1, ISNULL(DescuentoGlobal,0.0), 
          TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3,
          SUM(ISNULL(Subtotal,0.0)), 
          SUM(ISNULL(SubTotal,0.0) + ISNULL(Importe1,0.0) + ISNULL(Importe2,0.0) + ISNULL(Importe3,0.0) + ISNULL(Importe5,0.0) - (ISNULL(SubTotal,0.0)*(ISNULL(Retencion1,0.0)/100.0)) - (CASE WHEN @CfgRetencion2BaseImpuesto1 = 1 THEN ISNULL(Importe1,0.0) ELSE ISNULL(SubTotal,0.0) END*(ISNULL(Retencion2,0.0)/100.0)) - (ISNULL(SubTotal,0.0)*(ISNULL(Retencion3,0.0)/100.0))),           
          SUM(ImporteBruto * (ISNULL(DescuentoGlobal,0.0)/100)),
          SUM(ImporteBruto),
		  (SUM(ISNULL(Subtotal,0.0))*(Retencion2/100))
     FROM MovImpuesto
    WHERE Modulo = @Modulo AND ModuloID = @ID
    GROUP BY OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha, Retencion1, Retencion2, Retencion3, LoteFijo, ContUso, ContUso2, ContUso3, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Excento1, DescuentoGlobal, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3
    ORDER BY OrigenModulo, OrigenModuloID, OrigenConcepto, OrigenFecha, Retencion1, Retencion2, Retencion3, LoteFijo, ContUso, ContUso2, ContUso3, Impuesto1, Impuesto2, Impuesto3, Impuesto5, Excento1, DescuentoGlobal, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3

  OPEN crMovImpuesto
  FETCH NEXT FROM crMovImpuesto INTO @OrigenModulo, @OrigenModuloID, @OrigenConcepto, @OrigenFecha, @Retencion1, @Retencion2, @Retencion3, @LoteFijo, @ContUso, @ContUso2, @ContUso3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Importe1, @Importe2, @Importe3, @Importe5, @ImporteRetencion1, @ImporteRetencion2, @ImporteRetencion3, @Excento1, @DescuentoGlobal, 
                                     @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3,
                                     @SubTotal, @Total, @DescuentoImporte, @TotalBruto, @RetencionIVA
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      SELECT @Monto = NULL, @Cta = NULL
      EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT,
                               @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3
      IF @Cta IS NOT NULL OR @Cuenta IN ('TABLA %', 'LOTE FIJO', 'LOTE FIJO ESPECIFICO', 'CONCEPTO ORIGEN')
      BEGIN
        IF @Campo = 'TOTAL IMPUESTO 1' 		SELECT @Monto = @Importe1 ELSE
        IF @Campo = 'TOTAL IMPUESTO 2' 		SELECT @Monto = @Importe2 ELSE
        IF @Campo = 'TOTAL IMPUESTO 3' 		SELECT @Monto = @Importe3 ELSE
        IF @Campo = 'TOTAL IMPUESTO 5' 		SELECT @Monto = @Importe5 ELSE
        IF @Campo = 'TOTAL RETENCION 1'		SELECT @Monto = @ImporteRetencion1 ELSE
        IF @Campo = 'TOTAL RETENCION 2'		SELECT @Monto = @ImporteRetencion2 ELSE
        IF @Campo = 'TOTAL RETENCION 3'		SELECT @Monto = @ImporteRetencion3
        IF @Campo = 'SUBTOTAL ARRASTRE'		SELECT @Monto = @SubTotal
        IF @Campo = 'TOTAL ARRASTRE'		SELECT @Monto = @Total
        IF @Campo = 'TOTAL BRUTO ARRASTRE'	SELECT @Monto = @TotalBruto        
        IF @Campo = 'DESCUENTO ARRASTRE'	SELECT @Monto = @DescuentoImporte
		IF @Campo = 'Retencion IVA'			SELECT @Monto = @RetencionIVA

        IF @Cuenta = 'CONCEPTO ORIGEN'
          SELECT @Cta = Cuenta FROM Concepto WHERE Modulo = @OrigenModulo AND Concepto = @OrigenConcepto 
        ELSE
        IF @Cuenta = 'TABLA %'
        BEGIN
          IF @Campo = 'TOTAL IMPUESTO 1'  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Impuesto1  AND Excento = ISNULL(@Excento1, 0) ELSE
          IF @Campo = 'TOTAL IMPUESTO 2'  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Impuesto2  AND Excento = 0 ELSE
          IF @Campo = 'TOTAL IMPUESTO 3'  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Impuesto3  AND Excento = 0 ELSE
          IF @Campo = 'TOTAL IMPUESTO 5'  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Impuesto5  AND Excento = 0 ELSE
          IF @Campo = 'TOTAL RETENCION 1' SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Retencion1 AND Excento = 0 ELSE
          IF @Campo = 'TOTAL RETENCION 2' SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Retencion2 AND Excento = 0 ELSE
          IF @Campo = 'TOTAL RETENCION 3' SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Retencion3 AND Excento = 0 ELSE
		  IF @Campo = 'Retencion IVA'	  SELECT @Cta = ISNULL(Cuenta, @Cta) FROM MovTipoContAutoTabla WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Porcentaje = @Retencion2 AND Excento = 0
        END ELSE
        IF @Cuenta = 'LOTE FIJO'
        BEGIN
          IF @Campo = 'TOTAL IMPUESTO 1'  SELECT @Cta = ISNULL(Cuenta1, @Cta) FROM LoteFijo WHERE Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 2'  SELECT @Cta = ISNULL(Cuenta2, @Cta) FROM LoteFijo WHERE Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 3'  SELECT @Cta = ISNULL(Cuenta3, @Cta) FROM LoteFijo WHERE Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 5'  SELECT @Cta = ISNULL(Cuenta5, @Cta) FROM LoteFijo WHERE Lote = @LoteFijo 
        END ELSE
        IF @Cuenta = 'LOTE FIJO ESPECIFICO'
        BEGIN
          IF @Campo = 'TOTAL IMPUESTO 1' SELECT @Cta = ISNULL(Cuenta1, @Cta) FROM MovTipoContAutoLoteFijo WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 2' SELECT @Cta = ISNULL(Cuenta2, @Cta) FROM MovTipoContAutoLoteFijo WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 3' SELECT @Cta = ISNULL(Cuenta3, @Cta) FROM MovTipoContAutoLoteFijo WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Lote = @LoteFijo ELSE
          IF @Campo = 'TOTAL IMPUESTO 5' SELECT @Cta = ISNULL(Cuenta5, @Cta) FROM MovTipoContAutoLoteFijo WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave AND Nombre = @Nombre AND Lote = @LoteFijo 
        END 
        IF @Cta IS NOT NULL AND (NULLIF(@Monto, 0) IS NOT NULL OR @CfgPartidasSinImporte = 1)
        BEGIN
          SELECT @Debe = NULL, @Haber = NULL
          IF @OmitirConcepto     = 1 SELECT @Concepto = NULL
          IF @OmitirCentroCostos = 1 
          BEGIN
            SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL 
          END ELSE 
          BEGIN
            SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE @ContUso END
          END 

          IF @EsDebe = 1 
            SELECT @Debe = @Monto*@TipoCambio
          ELSE
            SELECT @Haber = @Monto*@TipoCambio

          IF UPPER(@ContAutoContactoEsp) = 'CONTACTO ARRASTRE'
            EXEC spMovInfo @OrigenModuloID, @OrigenModulo, @Contacto = @ContactoArrastre OUTPUT

          SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoArrastre, NULL, NULL, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL)
          --IF @Campo = 'IMPORTE CENTRO COSTO'   
          INSERT #Poliza (Orden,  Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico,  Debe,  Haber,  Campo,  ContactoTipo) --REQ 13147
                  VALUES (@Orden, @Cta,   @ContUso,  @ContUso2,  @ContUso3, @Concepto, @ContactoEspecifico, @Debe, @Haber, @Campo, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)) --REQ 13147
          --ELSE
          --  INSERT #Poliza (Orden,  Cuenta, SubCuenta, Concepto,  Debe,  Haber)  
          --          VALUES (@Orden, @Cta,   @ContUso,  @Concepto, @Debe, @Haber)          	          

        END
      END
    END
    FETCH NEXT FROM crMovImpuesto INTO @OrigenModulo, @OrigenModuloID, @OrigenConcepto, @OrigenFecha, @Retencion1, @Retencion2, @Retencion3, @LoteFijo, @ContUso, @ContUso2, @ContUso3, @Impuesto1, @Impuesto2, @Impuesto3, @Impuesto5, @Importe1, @Importe2, @Importe3, @Importe5, @ImporteRetencion1, @ImporteRetencion2, @ImporteRetencion3, @Excento1, @DescuentoGlobal, 
                                       @TipoImpuesto1, @TipoImpuesto2, @TipoImpuesto3, @TipoImpuesto5, @TipoRetencion1, @TipoRetencion2, @TipoRetencion3,
                                       @SubTotal, @Total, @DescuentoImporte, @TotalBruto, @RetencionIVA
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crMovImpuesto
  DEALLOCATE crMovImpuesto
  RETURN
END
GO

--REQ 13147
/************** spContAutoPolizaCtaAgente *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoPolizaCtaAgente') and type = 'P') drop procedure dbo.spContAutoPolizaCtaAgente
GO
CREATE PROCEDURE spContAutoPolizaCtaAgente
		   @Modulo			char(5), 
		   @ID				int, 			
		   @Cta				varchar(20)	OUTPUT,
		   @Ok				int			= NULL OUTPUT,
		   @OkRef			varchar(255)= NULL OUTPUT
		   
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL					nvarchar(max)
  
  SET @SQL = N'SELECT @Cta = p.Cuenta FROM Prov p JOIN Agente a ON p.Proveedor = a.Acreedor WHERE a.Agente = (SELECT Agente FROM '+ @Modulo + ' WHERE ID = ' + CONVERT(varchar,@ID) + ' )'

  EXEC sp_executesql @SQL, N'@Cta varchar(20) OUTPUT, @Modulo varchar(5), @ID varchar(20)', @Cta = @Cta OUTPUT, @Modulo = @Modulo, @ID = @ID

END
GO

/************** spContAutoPoliza *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoPoliza') and type = 'P') drop procedure dbo.spContAutoPoliza
GO
CREATE PROCEDURE spContAutoPoliza
           @Empresa					char(5),
		   @Sucursal				int,
		   @Modulo					char(5), 
		   @ID						int, 			
		   @Mov						varchar(20),
		   @MovID					varchar(20),
		   @MovTipo					char(20),
		   @Estatus					char(15),
           @EstatusNuevo			char(15),
		   @Usuario					char(10),
		   @FechaEmision			datetime,
		   @FechaRegistro			datetime,
		   @CfgClaseConceptoGastos 	bit,
		   @Concepto				varchar(50)		OUTPUT,
		   @Proyecto				varchar(50)		OUTPUT,
		   @UEN						int				OUTPUT,
    	   @Contacto				char(10)		OUTPUT,
	       @ContactoTipo			varchar(20)		OUTPUT,
	       @ContactoAplica			varchar(20)		OUTPUT,
		   @Intercompania			bit				OUTPUT,
    	   @OrigenMoneda			varchar(10)		OUTPUT,
    	   @OrigenTipoCambio		float			OUTPUT,
		   @Ok						int				OUTPUT,
		   @OkRef					varchar(255)	OUTPUT,
		   @CfgPartidasSinImporte	bit,
           @CfgConsolidacion		bit,
		   @CfgTipoFilial			varchar(20),
           @CfgContArticulo			bit,
           @ContAutoEmpresa			varchar(10) = '(Todas)'
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nombre					varchar(50),
    @Clave					varchar(20),
    @CtaCtoTipo				varchar(20),
    @CtaCtoTipoAplica		varchar(20),  
    @CtaClase				varchar(20),
    @CtaDinero				varchar(10),
    @CtaDineroDestino		varchar(10),
    @FormaPago				varchar(50),
    @ConDesglose			bit,
    @Directo				bit,
    @Orden					int,
    @Debe					varchar(20),
    @Haber					varchar(20),
    @DebeHaber				varchar(20),
    @Cuenta					varchar(20),
    @CuentaOmision			varchar(20),
    @Cta					varchar(20),
    @OmitirConcepto			bit,
    @QueConcepto			varchar(20),
    @OmitirCentroCostos		bit,
    @CentroCostos			varchar(20),
    @SucursalContable		varchar(20),
    @IncluirArticulos		bit,
    @IncluirDepartamento	bit,
    @ContAutoContactoEsp	varchar(50),
    @Condicion				varchar(50),
    @OrigenTipo				varchar(10),
    @Continuar				bit,
    @GenerarPoliza			bit,
    @ContID					int,
    @Poliza					varchar(20),
    @PolizaID				varchar(20),
    @Diferencia				money,
    @DiferenciaIVA			money,
    @DiferenciaIEPS			money,
    @CxTipoCambio			float,
    @ContactoTipoCambio		float,
    @CxImporteTotalMN		money,
    @CxImporteAplicaMN		money,
    @CxIVAMN				money, 
    @CxIVAAplicaMN			money, 
    @CxIEPSMN				money, 
    @CxIEPSAplicaMN			money,
    @CxPicosMN				money, 
    @ContactoSubTipo		varchar(20),
    @Clase					varchar(50),
    @SubClase				varchar(50),
    @EsFilial				bit,
    @Monto					money,
    @Importe				money,
    @CentroCostosSucursal	varchar(20),
    @CentroCostosDestino	varchar(20),
    @CentroCostosMatriz		varchar(20),
    @ContUso				varchar(20), --MERJOA4752
    @ContUso2				varchar(20), --MERJOA4752    
    @ContUso3				varchar(20), --MERJOA4752    
    @RetencionPorcentaje	float,
    @ObligacionFiscal		varchar(50),
    @ContactoEspecifico		varchar(10),
    @ContactoDetalle		varchar(10),
    @Agente					varchar(10),
    @Personal				varchar(10),
    @Almacen				varchar(10),
    @AlmacenDestino			varchar(10),
    @AlmacenDetalle			varchar(10),
    @OrigenModulo			char(5), 
	@OrigenModuloID			int 

  SELECT @EsFilial = 0
  EXEC spContAutoGetDatos @Modulo, @ID, 
                          @ContID OUTPUT, @Poliza OUTPUT, @PolizaID OUTPUT, 
                          @Concepto OUTPUT, @Proyecto OUTPUT, @UEN OUTPUT, @OrigenTipo OUTPUT, @CtaClase OUTPUT, @CtaCtoTipo OUTPUT, @CtaCtoTipoAplica OUTPUT, 
                          @Contacto OUTPUT, @CtaDinero OUTPUT, @CtaDineroDestino OUTPUT, @FormaPago OUTPUT, @ConDesglose OUTPUT, @GenerarPoliza OUTPUT, 
                          @ContactoTipo OUTPUT, @ContactoSubTipo OUTPUT, @Clase OUTPUT, @SubClase OUTPUT, @Intercompania OUTPUT, @OrigenMoneda OUTPUT, @OrigenTipoCambio OUTPUT, 
                          @CentroCostosSucursal OUTPUT, @CentroCostosDestino OUTPUT, @CentroCostosMatriz OUTPUT, @RetencionPorcentaje OUTPUT, @Directo OUTPUT, @ContactoAplica OUTPUT

  IF @EstatusNuevo = 'CANCELADO'
  BEGIN
    IF NULLIF(RTRIM(@PolizaID), '') IS NULL RETURN
  END ELSE
  BEGIN
    IF NULLIF(RTRIM(@PolizaID), '') IS NOT NULL RETURN
  END

  IF @CfgConsolidacion = 1 AND @Modulo = 'VTAS' AND @ContactoSubTipo = @CfgTipoFilial SELECT @EsFilial = 1

  IF EXISTS(SELECT * FROM MovTipoContAuto WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Mov)
    SELECT @Clave = @Mov
  ELSE
    SELECT @Clave = '('+RTRIM(@MovTipo)+')'
  EXEC xpContAutoPolizaClave @Empresa, @Sucursal, @Modulo,  @ID, @Mov, @MovID, @MovTipo, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Clave OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  DECLARE crContAuto CURSOR FOR
   SELECT Nombre, Orden, NULLIF(RTRIM(UPPER(Condicion)), ''), NULLIF(RTRIM(UPPER(Debe)), ''), NULLIF(RTRIM(UPPER(Haber)), ''), Cuenta, CuentaOmision, ISNULL(OmitirConcepto, 0), Concepto, ISNULL(OmitirCentroCostos, 0), CentroCostos, Sucursal, ISNULL(IncluirArticulos, 0), ISNULL(IncluirDepartamento, 0), ISNULL(RTRIM(ContactoEspecifico), ''), NULLIF(RTRIM(ObligacionFiscal), ''), @Contacto --REQ 13147
     FROM MovTipoContAuto
    WHERE Empresa = @ContAutoEmpresa AND Modulo = @Modulo AND Clave = @Clave

  OPEN crContAuto
  FETCH NEXT FROM crContAuto INTO @Nombre, @Orden, @Condicion, @Debe, @Haber, @Cuenta, @CuentaOmision, @OmitirConcepto, @QueConcepto, @OmitirCentroCostos, @CentroCostos, @SucursalContable, @IncluirArticulos, @IncluirDepartamento, @ContAutoContactoEsp, @ObligacionFiscal, @Contacto --REQ 13147
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
		
     IF (select estatus from Cta WHERE Cuenta = @CuentaOmision ) in ('BLOQUEADO','BAJA')
	    SELECT @Ok = 50070

	  -- REQ CONTA AUTOMATICA
	  IF UPPER(@Cuenta) IN ('CONTACTO ORIGEN', 'RETENCION CTO ORIGEN') AND @Modulo IN ('CXC', 'CXP') SELECT @Contacto = @ContactoAplica

      IF @Debe = 'IMPORTE S/FISCAL'
        SELECT @Debe = 'SUBTOTAL ARRASTRE'
      IF @Haber = 'IMPORTE S/FISCAL'
        SELECT @Haber = 'SUBTOTAL ARRASTRE'

      IF @Debe = 'IVA FISCAL'
        SELECT @Debe = 'TOTAL IMPUESTO 1'
      IF @Haber = 'IVA FISCAL'
        SELECT @Haber = 'TOTAL IMPUESTO 1'
        
      IF @Debe = 'IEPS FISCAL'
        SELECT @Debe = 'TOTAL IMPUESTO 2'
      IF @Haber = 'IEPS FISCAL'
        SELECT @Haber = 'TOTAL IMPUESTO 2'

      IF @Debe IS NOT NULL SELECT @DebeHaber = @Debe ELSE SELECT @DebeHaber = @Haber
      SELECT @Continuar = 1 
      IF @Condicion IS NOT NULL
      BEGIN
        IF @MovTipo = 'VTAS.F'
        BEGIN
          IF @Condicion = 'VENTA NORMAL'    AND @OrigenTipo =  'VMOS' SELECT @Continuar = 0
          IF @Condicion = 'VENTA MOSTRADOR' AND @OrigenTipo <> 'VMOS' SELECT @Continuar = 0
        END
      END
      IF @Continuar = 1
      BEGIN        
		IF @Modulo IN ('VTAS', 'COMS', 'CXC', 'CXP', 'GAS', 'DIN', 'CONC') AND (@Debe IN ('TOTAL IMPUESTO 1', 'TOTAL IMPUESTO 2', 'TOTAL IMPUESTO 3', 'TOTAL IMPUESTO 5', 'TOTAL RETENCION 1', 'TOTAL RETENCION 2', 'TOTAL RETENCION 3', 'SUBTOTAL ARRASTRE', 'TOTAL ARRASTRE', 'TOTAL BRUTO ARRASTRE', 'DESCUENTO ARRASTRE') OR @Haber IN ('TOTAL IMPUESTO 1', 'TOTAL IMPUESTO 2', 'TOTAL IMPUESTO 3', 'TOTAL IMPUESTO 5', 'TOTAL RETENCION 1', 'TOTAL RETENCION 2', 'TOTAL RETENCION 3', 'SUBTOTAL ARRASTRE', 'TOTAL ARRASTRE', 'TOTAL BRUTO ARRASTRE', 'DESCUENTO ARRASTRE', 'Retencion IVA'))
        BEGIN
          IF @Debe  IS NOT NULL EXEC spContAutoMovImpuesto @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @OrigenTipoCambio, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
          IF @Haber IS NOT NULL EXEC spContAutoMovImpuesto @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @OrigenTipoCambio, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
          SELECT @Continuar = 0
        END
      END
      IF @Continuar = 1
      BEGIN
        IF @OmitirConcepto = 1 SELECT @Concepto = NULL
        IF @Modulo IN ('COMS', 'VTAS', 'INV', 'PROD')
        BEGIN
          --BUG16104
           IF @Debe  IN ('ANT FACT. DIFEREN C', 'ANT FACT. UTILIDAD C', 'ANT FACT. PERDIDA C') OR 
              @Haber IN ('ANT FACT. DIFEREN C', 'ANT FACT. UTILIDAD C', 'ANT FACT. PERDIDA C')
           BEGIN
             EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT           
             IF @Debe  IS NOT NULL EXEC spContAutoVTASCambiario @Empresa, @Sucursal, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Orden, @Debe, @Haber, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoSubTipo, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @CtaDinero, @CtaDineroDestino, @Ok OUTPUT, @OkRef OUTPUT, @ContactoTipo
             IF @Haber IS NOT NULL EXEC spContAutoVTASCambiario @Empresa, @Sucursal, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Orden, @Debe, @Haber, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoSubTipo, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @CtaDinero, @CtaDineroDestino, @Ok OUTPUT, @OkRef OUTPUT, @ContactoTipo
           END ELSE
           IF @Debe  IN ('GASTOS/RETENCION IVA', 'GASTOS/RETENCION ISR', 'GASTOS/IMPORTE', 'GASTOS/IMPUESTOS', 'GASTOS/IMPORTE TOTAL', 'GASTOS/RETENCION 3') OR 
              @Haber IN ('GASTOS/RETENCION IVA', 'GASTOS/RETENCION ISR', 'GASTOS/IMPORTE', 'GASTOS/IMPUESTOS', 'GASTOS/IMPORTE TOTAL', 'GASTOS/RETENCION 3')
           BEGIN
             EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
             IF @Debe  = 'GASTOS/RETENCION ISR' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Retencion*TipoCambio  FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/RETENCION ISR' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Retencion*TipoCambio  FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Debe  = 'GASTOS/RETENCION IVA' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Retencion2*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/RETENCION IVA' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Retencion2*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Debe  = 'GASTOS/RETENCION 3'   INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Retencion3*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/RETENCION 3'   INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Retencion3*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Debe  = 'GASTOS/IMPORTE'       INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Importe*TipoCambio    FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/IMPORTE'       INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Importe*TipoCambio    FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Debe  = 'GASTOS/IMPUESTOS'     INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Impuestos*TipoCambio  FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/IMPUESTOS'     INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Impuestos*TipoCambio  FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Debe  = 'GASTOS/IMPORTE TOTAL' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, (Importe+ISNULL(Impuestos, 0.0)-ISNULL(Retencion, 0.0)-ISNULL(Retencion2, 0.0)-ISNULL(Retencion3, 0.0))*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID ELSE
             IF @Haber = 'GASTOS/IMPORTE TOTAL' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, (Importe+ISNULL(Impuestos, 0.0)-ISNULL(Retencion, 0.0)-ISNULL(Retencion2, 0.0)-ISNULL(Retencion3, 0.0))*TipoCambio FROM CompraGastoDiverso WHERE ID = @ID 
           END ELSE
           BEGIN
             IF @Modulo = 'VTAS' AND (@Debe IN ('RETENCIONES', 'COMISIONES', 'COMISIONES IVA', 'TOTAL COMISIONES', 'ANTICIPOS FACTURADOS') OR @Haber IN ('RETENCIONES', 'COMISIONES', 'COMISIONES IVA', 'TOTAL COMISIONES', 'ANTICIPOS FACTURADOS'))
             BEGIN
               EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
               IF @Debe  = 'RETENCIONES'      INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Retencion*TipoCambio     FROM Venta WHERE ID = @ID ELSE
               IF @Haber = 'RETENCIONES'      INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Retencion*TipoCambio     FROM Venta WHERE ID = @ID ELSE
               IF @Debe  = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Comisiones*TipoCambio    FROM Venta WHERE ID = @ID ELSE
               IF @Haber = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Comisiones*TipoCambio    FROM Venta WHERE ID = @ID ELSE
               IF @Debe  = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, ComisionesIVA*TipoCambio FROM Venta WHERE ID = @ID ELSE
               IF @Haber = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, ComisionesIVA*TipoCambio FROM Venta WHERE ID = @ID ELSE
               IF @Debe  = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, (ISNULL(Comisiones, 0.0) + ISNULL(ComisionesIVA, 0.0))*TipoCambio FROM Venta WHERE ID = @ID ELSE
               IF @Haber = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, (ISNULL(Comisiones, 0.0) + ISNULL(ComisionesIVA, 0.0))*TipoCambio FROM Venta WHERE ID = @ID ELSE
               IF @Debe  = 'ANTICIPOS FACTURADOS' IF EXISTS(SELECT 1 FROM VentaD WHERE AnticipoFacturado = 1 AND ID = @ID) INSERT #Poliza (Orden, Cuenta, Concepto, Debe) SELECT @Orden, @Cta, @Concepto, ISNULL(Importe, 0.0) FROM VentaFacturaAnticipo WHERE ID = @ID ELSE INSERT #Poliza (Orden, Cuenta, Concepto, Debe) SELECT @Orden, @Cta, @Concepto, AnticiposFacturados*TipoCambio FROM Venta WHERE ID = @ID ELSE
               IF @Haber = 'ANTICIPOS FACTURADOS' IF EXISTS(SELECT 1 FROM VentaD WHERE AnticipoFacturado = 1 AND ID = @ID) INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, ISNULL(Importe, 0.0) FROM VentaFacturaAnticipo WHERE ID = @ID ELSE INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, AnticiposFacturados*TipoCambio FROM Venta WHERE ID = @ID
             END ELSE
             IF @Modulo = 'COMS' AND (@Debe IN ('COMISIONES', 'COMISIONES IVA', 'TOTAL COMISIONES') OR @Haber IN ('COMISIONES', 'COMISIONES IVA', 'TOTAL COMISIONES'))
             BEGIN
               EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
               IF @Debe  = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Comisiones*TipoCambio    FROM Compra WHERE ID = @ID ELSE
               IF @Haber = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Comisiones*TipoCambio    FROM Compra WHERE ID = @ID ELSE
               IF @Debe  = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, ComisionesIVA*TipoCambio FROM Compra WHERE ID = @ID ELSE
               IF @Haber = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, ComisionesIVA*TipoCambio FROM Compra WHERE ID = @ID ELSE
               IF @Debe  = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, (ISNULL(Comisiones, 0.0) + ISNULL(ComisionesIVA, 0.0))*TipoCambio FROM Compra WHERE ID = @ID ELSE
               IF @Haber = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, (ISNULL(Comisiones, 0.0) + ISNULL(ComisionesIVA, 0.0))*TipoCambio FROM Compra WHERE ID = @ID 
             END ELSE
             BEGIN
               IF @Debe  IS NOT NULL EXEC spContAutoInv @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @CfgContArticulo, @IncluirArticulos, @IncluirDepartamento, @RetencionPorcentaje, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
               IF @Haber IS NOT NULL EXEC spContAutoInv @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @CfgContArticulo, @IncluirArticulos, @IncluirDepartamento, @RetencionPorcentaje, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
             END
           END
        END ELSE
        IF @Modulo = 'GAS'
        BEGIN
           IF @MovTipo IN ('GAS.DA', 'GAS.ASC', 'GAS.SR')
           BEGIN
             EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
             IF @Debe  IN ('IMPORTE', 'IMPORTE TOTAL') INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, Importe*TipoCambio FROM Gasto WHERE ID = @ID ELSE
             IF @Haber IN ('IMPORTE', 'IMPORTE TOTAL') INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, Importe*TipoCambio FROM Gasto WHERE ID = @ID 
           END ELSE
           BEGIN
             IF @Debe  IS NOT NULL EXEC spContAutoGasto @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @CfgClaseConceptoGastos, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @IncluirDepartamento, @ContAutoContactoEsp, @ContAutoEmpresa = @ContAutoEmpresa ELSE
             IF @Haber IS NOT NULL EXEC spContAutoGasto @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @CfgClaseConceptoGastos, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @IncluirDepartamento, @ContAutoContactoEsp, @ContAutoEmpresa = @ContAutoEmpresa
           END
        END ELSE
        IF @Modulo = 'AF'
        BEGIN
          IF @Debe  IS NOT NULL EXEC spContAutoAF @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte
          IF @Haber IS NOT NULL EXEC spContAutoAF @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte
        END ELSE
        IF @Modulo = 'CP'
        BEGIN
          IF @Debe  IS NOT NULL EXEC spContAutoCP @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte
          IF @Haber IS NOT NULL EXEC spContAutoCP @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte
        END ELSE
        IF @Modulo = 'FIS'
        BEGIN
          IF @Debe  IS NOT NULL EXEC spContAutoFiscal @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ObligacionFiscal, @ContAutoEmpresa = @ContAutoEmpresa
          IF @Haber IS NOT NULL EXEC spContAutoFiscal @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ObligacionFiscal, @ContAutoEmpresa = @ContAutoEmpresa
        END ELSE
        IF @Modulo = 'PC'
        BEGIN
          IF @Debe  IS NOT NULL EXEC spContAutoPC @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @CfgContArticulo, @IncluirArticulos, @IncluirDepartamento
          IF @Haber IS NOT NULL EXEC spContAutoPC @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @CfgContArticulo, @IncluirArticulos, @IncluirDepartamento
        END ELSE
        IF @Modulo = 'NOM'
        BEGIN
          IF @Debe  IS NOT NULL  EXEC spContAutoNomina @Empresa, @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @QueConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Condicion, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp
          IF @Haber IS NOT NULL  EXEC spContAutoNomina @Empresa, @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @QueConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Condicion, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp
        END ELSE
        BEGIN
          IF @Cuenta = 'CONTACTO' AND NULLIF(RTRIM(@ContAutoContactoEsp),'') IS NOT NULL
          BEGIN
            SELECT @Contacto = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, @Almacen, @AlmacenDestino, @AlmacenDetalle)
            IF UPPER(@ContAutoContactoEsp) = 'CONTACTO ARRASTRE'
            BEGIN
              SELECT @OrigenModulo = OrigenModulo, @OrigenModuloID = OrigenModuloID FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID
              EXEC spMovInfo @OrigenModuloID, @OrigenModulo, @Contacto = @Contacto OUTPUT
            END
          END

          EXEC spContAutoGetCuenta @Modulo, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

		  --REQ 13147
		  IF @ContAutoContactoEsp = 'Agente' AND @Contacto IS NULL AND @Cta IS NULL
		    EXEC spContAutoPolizaCtaAgente @Modulo, @ID, @Cta OUTPUT

          IF @Modulo = 'CXC'
          BEGIN
            IF @OmitirCentroCostos = 1 
            BEGIN --MEJORA4752
              SELECT @ContUso   = NULL --MEJORA4752 
              SELECT @ContUso2  = NULL --MEJORA4752               
              SELECT @ContUso3  = NULL --MEJORA4752                             
            END --MEJORA4752
            ELSE --MEJORA4752 
            BEGIN --MEJORA4752
              SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE (SELECT ContUso FROM Cxc WHERE ID = @ID) END --MEJORA4752
              SELECT @ContUso2 = ContUso2, @ContUso3 = ContUso3  FROM Cxc WHERE ID = @ID --MEJORA4752
            END --MEJORA4752  
            IF @Cuenta = 'TABLA %'
            BEGIN
              IF EXISTS(SELECT * FROM CxcD WHERE ID = @ID)
              BEGIN
                IF @Debe  IS NOT NULL EXEC spContAutoCx @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
                IF @Haber IS NOT NULL EXEC spContAutoCx @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
              END ELSE
              BEGIN
                IF @Debe IN ('IMPUESTOS', 'IVA FISCAL') OR @Haber IN ('IMPUESTOS', 'IVA FISCAL')
                BEGIN
                  SELECT @Agente = Agente, @Personal = PersonalCobrador, @Monto = Impuestos*TipoCambio, @Importe = Importe*TipoCambio FROM Cxc WHERE ID = @ID
                  SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, @Almacen, @AlmacenDestino, @AlmacenDetalle)
                  EXEC spContAutoGetCuentaTabla @Modulo, @Clave, @Nombre, @Monto, @Importe, @Cta OUTPUT, @ContAutoEmpresa = @ContAutoEmpresa
                  IF @Cta IS NOT NULL
                  BEGIN
                    IF @Debe  IN ('IMPUESTOS', 'IVA FISCAL') INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Debe,  ContactoEspecifico, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Monto, @ContactoEspecifico, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)) --REQ 13147
                    IF @Haber IN ('IMPUESTOS', 'IVA FISCAL') INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Haber, ContactoEspecifico, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Monto, @ContactoEspecifico, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)) --REQ 13147
                  END
                END
              END
            END ELSE
            BEGIN
              IF @Cta IS NULL
                EXEC xpContAutoCuentaExtra @Modulo, @ID, @Cuenta, @CuentaOmision, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, NULL, NULL, NULL, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Cta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              EXEC spContAutoCxEncabezado @Empresa, @Sucursal, @Modulo, @ID, @MovTipo, @Orden, @Debe, @Haber, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Diferencia, @DiferenciaIVA,@DiferenciaIEPS, @CxTipoCambio, @ContactoTipoCambio, @CxImporteTotalMN, @CxImporteAplicaMN, @CxIVAMN, @CxIVAAplicaMN, @CxIEPSMN, @CxIEPSAplicaMN, @CxPicosMN, @ContactoSubTipo, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @CtaDinero, @CtaDineroDestino, @Ok OUTPUT, @OkRef OUTPUT, @ContactoTipo --REQ 13147
            END
             
          END ELSE
          IF @Modulo = 'CXP'
          BEGIN
            IF @OmitirCentroCostos = 1 
            BEGIN --MEJORA4752
              SELECT @ContUso  = NULL, @ContUso2 = NULL, @ContUso3 = NULL --MEJORA4752
            END --MEJORA4752
            ELSE --MEJORA4752 
            BEGIN --MEJORA4752
              SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE (SELECT ContUso FROM Cxp WHERE ID = @ID) END
              SELECT @ContUso2 = ContUso2, @ContUso3 = ContUso3  FROM Cxp WHERE ID = @ID --MEJORA4752              
            END --MEJORA4752
            IF @Cuenta = 'TABLA %'
            BEGIN
              IF EXISTS(SELECT * FROM CxpD WHERE ID = @ID)
              BEGIN
                IF @Debe  IS NOT NULL EXEC spContAutoCx @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
                IF @Haber IS NOT NULL EXEC spContAutoCx @Modulo, @Clave, @Nombre, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @CtaCtoTipo, @CtaCtoTipoAplica, @CtaClase, @Concepto, @Contacto, @ContactoTipo, @CtaDinero, @CtaDineroDestino, @FormaPago, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @ContAutoContactoEsp, @ContactoAplica, @ContAutoEmpresa = @ContAutoEmpresa
              END ELSE
              BEGIN
                IF @Debe = 'IMPUESTOS' OR @Haber = 'IMPUESTOS'
                BEGIN
                  SELECT @Monto = Impuestos*TipoCambio, @Importe = Importe*TipoCambio FROM Cxp WHERE ID = @ID
                  SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, @Almacen, @AlmacenDestino, @AlmacenDetalle)
                  EXEC spContAutoGetCuentaTabla @Modulo, @Clave, @Nombre, @Monto, @Importe, @Cta OUTPUT, @ContAutoEmpresa = @ContAutoEmpresa
                  IF @Cta IS NOT NULL
                  BEGIN
                    IF @Debe   = 'IMPUESTOS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Debe,  ContactoEspecifico, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Monto, @ContactoEspecifico, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)) --MEJORA4752 --REQ 13147
                    IF @Haber  = 'IMPUESTOS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, Haber, ContactoEspecifico, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Monto, @ContactoEspecifico, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)) --MEJORA4752 --REQ 13147
                  END
                END
              END
            END ELSE
             EXEC spContAutoCxEncabezado @Empresa, @Sucursal, @Modulo, @ID, @MovTipo, @Orden, @Debe, @Haber, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @Diferencia, @DiferenciaIVA,@DiferenciaIEPS, @CxTipoCambio, @ContactoTipoCambio, @CxImporteTotalMN, @CxImporteAplicaMN, @CxIVAMN, @CxIVAAplicaMN, @CxIEPSMN, @CxIEPSAplicaMN, @CxPicosMN, @ContactoSubTipo, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @CtaDinero, @CtaDineroDestino, @Ok OUTPUT, @OkRef OUTPUT, @ContactoTipo --MEJORA4752 --REQ 13147
          END ELSE
          IF @Modulo = 'AGENT'
          BEGIN
            SELECT @Agente = Agente FROM Agent WHERE ID = @ID
            SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, @Almacen, @AlmacenDestino, @AlmacenDetalle)
            IF @Debe   = 'IMPORTE'   	  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Importe*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)			FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Haber  = 'IMPORTE'   	  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Haber, ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Importe*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) 		FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Debe   = 'IMPUESTOS' 	  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Impuestos*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)    	FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Haber  = 'IMPUESTOS' 	  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Haber, ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Impuestos*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)    	FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Debe   = 'RETENCIONES' 	  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Retencion*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)    	FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Haber  = 'RETENCIONES'    INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Haber, ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM(Retencion*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)    	FROM Agent WHERE ID = @ID ELSE --REQ 13147
            IF @Debe   = 'IMPORTE TOTAL'  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Agent WHERE ID = @ID ELSE -- MEJORA 12143
            IF @Haber  = 'IMPORTE TOTAL'  INSERT #Poliza (Orden, Cuenta, Concepto, ContactoEspecifico, Haber, ContactoTipo)  SELECT @Orden, @Cta, @Concepto, @ContactoEspecifico, SUM((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Agent WHERE ID = @ID -- MEJORA 12143
          END ELSE
          IF @Modulo = 'DIN'
          BEGIN
            IF @ConDesglose = 1 AND @Cuenta = 'FORMA PAGO' 
            BEGIN
              IF @Debe  IS NOT NULL EXEC spContAutoDinero @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @Concepto, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, NULL, @SucursalContable, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoTipo --REQ 13147
              IF @Haber IS NOT NULL EXEC spContAutoDinero @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @Concepto, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, NULL, @SucursalContable, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoTipo --REQ 13147
            END ELSE
            IF @Directo = 0 AND @DebeHaber IN ('IMPORTE', 'IMPUESTOS', 'IMPORTE TOTAL', 'IVA FISCAL', 'IEPS FISCAL', 'INTERESES')
            BEGIN
              IF @Debe  IS NOT NULL EXEC spContAutoDinero @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @Concepto, @Orden, @Debe,  1, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @Cta, @SucursalContable, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoTipo --REQ 13147
              IF @Haber IS NOT NULL EXEC spContAutoDinero @Modulo, @ID, @Cuenta, @CuentaOmision, @OmitirConcepto, @OmitirCentroCostos, @CentroCostos, @CentroCostosSucursal, @CentroCostosDestino, @CentroCostosMatriz, @Concepto, @Orden, @Haber, 0, @Ok OUTPUT, @OkRef OUTPUT, @CfgPartidasSinImporte, @Cta, @SucursalContable, @ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoTipo --REQ 13147
            END ELSE
            BEGIN
              SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, @ContactoDetalle, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, @Almacen, @AlmacenDestino, @AlmacenDetalle)
              IF @OmitirCentroCostos = 1 
              BEGIN --MEJORA4752
                SELECT @ContUso   = NULL --MEJORA4752 
                SELECT @ContUso2  = NULL --MEJORA4752                 
                SELECT @ContUso3  = NULL --MEJORA4752                                 
              END --MEJORA4752
              ELSE --MEJORA4752 
              BEGIN --MEJORA4752
                SELECT @ContUso = CASE @CentroCostos WHEN 'Sucursal' THEN @CentroCostosSucursal WHEN 'Sucursal Destino' THEN @CentroCostosDestino WHEN 'Matriz' THEN @CentroCostosMatriz ELSE (SELECT ContUso FROM Dinero WHERE ID = @ID) END --MEJORA4752
                SELECT @ContUso2 = ContUso2, @ContUso3 = ContUso3 FROM Dinero WHERE ID = @ID --MEJORA4752
              END --MEJORA4752  
              IF @Debe   = 'IMPORTE'   	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) 	 FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'IMPORTE'   	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) 	 FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'IMPUESTOS' 	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'IMPUESTOS' 	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'IMPORTE TOTAL'     INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'IMPORTE TOTAL'     INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'IVA FISCAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*IVAFiscal, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)  FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'IVA FISCAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*IVAFiscal, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)  FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'IEPS FISCAL'       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*IEPSFiscal, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'IEPS FISCAL'       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*IEPSFiscal, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'INTERES BRUTO'     INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*Tasa/NULLIF(TasaDias, 0)/100.0*DATEDIFF(day, FechaOrigen, Vencimiento), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'INTERES BRUTO'     INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*Tasa/NULLIF(TasaDias, 0)/100.0*DATEDIFF(day, FechaOrigen, Vencimiento), dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'INTERES NETO'      INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*Tasa/NULLIF(TasaDias, 0)/100.0*DATEDIFF(day, FechaOrigen, Vencimiento))-ISNULL(Retencion, 0.0)*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'INTERES NETO'      INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0))*TipoCambio*Tasa/NULLIF(TasaDias, 0)/100.0*DATEDIFF(day, FechaOrigen, Vencimiento))-ISNULL(Retencion, 0.0)*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'INTERES RETENCION' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'INTERES RETENCION' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'UTILIDAD'          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID AND Importe>0 ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'UTILIDAD'          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID AND Importe>0 ELSE --MEJORA4752 --REQ 13147
              IF @Debe   = 'PERDIDA'   	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID AND Importe<0 ELSE --MEJORA4752 --REQ 13147
              IF @Haber  = 'PERDIDA'   	       INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -Importe*TipoCambio, dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo) FROM Dinero WHERE ID = @ID AND Importe<0 --MEJORA4752 --REQ 13147
            END
          END ELSE
          IF @Modulo = 'VALE'
          BEGIN
            IF @Debe   = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(Importe*TipoCambio) 	FROM Vale WHERE ID = @ID ELSE
            IF @Haber  = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(Importe*TipoCambio) 	FROM Vale WHERE ID = @ID 
          END ELSE
          IF @Modulo = 'CR'
          BEGIN
            IF @Debe   = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) 	FROM CRVenta d, CR e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) 	FROM CRVenta d, CR e WHERE d.ID = e.ID AND e.ID = @ID 
          END ELSE
          IF @Modulo = 'CAM'
          BEGIN
            IF @Debe   = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(Monto*TipoCambio) 	FROM CambioD WHERE ID = @ID ELSE
            IF @Haber  = 'IMPORTE'   	INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(Monto*TipoCambio) 	FROM CambioD WHERE ID = @ID 
          END ELSE
          IF @Modulo = 'CAP'
          BEGIN
            IF @Debe   = 'PRECIO' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Precio*d.Cantidad*e.TipoCambio) FROM CapitalD d, Capital e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'PRECIO' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Precio*d.Cantidad*e.TipoCambio) FROM CapitalD d, Capital e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Debe   = 'COSTO'  INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Costo*d.Cantidad*e.TipoCambio)  FROM CapitalD d, Capital e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'COSTO'  INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Costo*d.Cantidad*e.TipoCambio)  FROM CapitalD d, Capital e WHERE d.ID = e.ID AND e.ID = @ID 
          END ELSE
          IF @Modulo = 'INC'
          BEGIN
            IF @Debe   = 'IMPORTE' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) FROM IncidenciaD d, Incidencia e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'IMPORTE' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) FROM IncidenciaD d, Incidencia e WHERE d.ID = e.ID AND e.ID = @ID 
          END ELSE
          IF @Modulo = 'CONC'
          BEGIN
            IF @Debe   = 'CARGO' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Cargo*e.TipoCambio) FROM ConciliacionD d, Conciliacion e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'ABONO' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Abono*e.TipoCambio) FROM ConciliacionD d, Conciliacion e WHERE d.ID = e.ID AND e.ID = @ID 
          END ELSE
          IF @Modulo = 'PPTO'
          BEGIN
            IF @Debe   = 'IMPORTE' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) FROM PresupD d, Presup e WHERE d.ID = e.ID AND e.ID = @ID ELSE
            IF @Haber  = 'IMPORTE' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(d.Importe*e.TipoCambio) FROM PresupD d, Presup e WHERE d.ID = e.ID AND e.ID = @ID 
          END ELSE
          IF @Modulo = 'CREDI'
          BEGIN
            IF @Debe   = 'IMPORTE'          INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(e.Importe*e.TipoCambio)       FROM Credito e WHERE e.ID = @ID ELSE
            IF @Haber  = 'IMPORTE'          INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(e.Importe*e.TipoCambio)       FROM Credito e WHERE e.ID = @ID ELSE
            IF @Debe   = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(e.Comisiones*e.TipoCambio)    FROM Credito e WHERE e.ID = @ID ELSE
            IF @Haber  = 'COMISIONES'       INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(e.Comisiones*e.TipoCambio)    FROM Credito e WHERE e.ID = @ID ELSE
            IF @Debe   = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(e.ComisionesIVA*e.TipoCambio) FROM Credito e WHERE e.ID = @ID ELSE
            IF @Haber  = 'COMISIONES IVA'   INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(e.ComisionesIVA*e.TipoCambio) FROM Credito e WHERE e.ID = @ID ELSE
            IF @Debe   = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Debe)  SELECT @Orden, @Cta, @Concepto, SUM(ISNULL(e.Comisiones, 0.0)+ISNULL(e.ComisionesIVA, 0.0)*e.TipoCambio) FROM Credito e WHERE e.ID = @ID ELSE
            IF @Haber  = 'TOTAL COMISIONES' INSERT #Poliza (Orden, Cuenta, Concepto, Haber) SELECT @Orden, @Cta, @Concepto, SUM(ISNULL(e.Comisiones, 0.0)+ISNULL(e.ComisionesIVA, 0.0)*e.TipoCambio) FROM Credito e WHERE e.ID = @ID 
          END
        END
      END
    END
    FETCH NEXT FROM crContAuto INTO @Nombre, @Orden, @Condicion, @Debe, @Haber, @Cuenta, @CuentaOmision, @OmitirConcepto, @QueConcepto, @OmitirCentroCostos, @CentroCostos, @SucursalContable, @IncluirArticulos, @IncluirDepartamento, @ContAutoContactoEsp, @ObligacionFiscal, @Contacto --REQ 13147
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crContAuto
  DEALLOCATE crContAuto  
  DELETE #Poliza WHERE ISNULL(Debe,0) = 0 AND ISNULL(Haber,0) = 0 --Bug 17150
  RETURN
END
GO

/************** spContAutoCxEncabezado *************/
if exists (select * from sysobjects where id = object_id('dbo.spContAutoCxEncabezado') and type = 'P') drop procedure dbo.spContAutoCxEncabezado
GO
CREATE PROCEDURE spContAutoCxEncabezado
                   	@Empresa		varchar(5),
		   	@Sucursal		int,
		   	@Modulo			varchar(5), 
		   	@ID			int,
		   	@MovTipo		varchar(20),
    			@Orden			int,
    			@Debe			varchar(20),
    			@Haber			varchar(20),
    			@Cta			varchar(20),
			@ContUso		varchar(20),
			@ContUso2		varchar(20),			
			@ContUso3		varchar(20),						
			@Concepto		varchar(50),
    			@Diferencia		money,	
    			@DiferenciaIVA		money,
    			@DiferenciaIEPS		money,
    			@CxTipoCambio		float,
    			@ContactoTipoCambio	float,
    			@CxImporteTotalMN	money,
    			@CxImporteAplicaMN	money,
    			@CxIVAMN		money, 
    			@CxIVAAplicaMN		money, 
    			@CxIEPSMN		money, 
    			@CxIEPSAplicaMN		money,
    			@CxPicosMN		money, 
    			@ContactoSubTipo	varchar(20),
			@ContAutoContactoEsp	varchar(50),
			@Contacto		varchar(10),
			@ContactoAplica		varchar(10),
			@CtaDinero		varchar(10), 
			@CtaDineroDestino	varchar(10),
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT,
			@ContactoTipo	varchar(20) --REQ 13147

--//WITH ENCRYPTION
AS BEGIN
  DECLARE		
    @Monto		money,
    @ContactoEspecifico	varchar(10),
    @Agente		varchar(10),
    @Personal		varchar(10),
    @ContactoTipoEspecifico varchar(20)

   --MEJORA4752 (Cambios masivos a todo el stored procedure)
   IF @Modulo = 'CXC'
     SELECT @Agente = Agente, @Personal = PersonalCobrador
      FROM Cxc
     WHERE ID = @ID

   SELECT @ContactoEspecifico = dbo.fnContactoEspecifico(@ContAutoContactoEsp, @Contacto, @ContactoAplica, NULL, @Agente, @Personal, @CtaDinero, @CtaDineroDestino, NULL, NULL, NULL)
   SELECT @ContactoTipoEspecifico = dbo.fnTipoContactoEspecifico(@ContAutoContactoEsp,@ContactoTipo)
      
   IF @Modulo = 'CXC'
   BEGIN   
    IF @Debe   = 'IMPORTE'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, @ContactoTipoEspecifico 	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, @ContactoTipoEspecifico 	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPUESTOS' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPUESTOS' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'RETENCIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Retencion, 0)+ISNULL(Retencion2, 0)+ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'RETENCIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Retencion, 0)+ISNULL(Retencion2, 0)+ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPORTE TOTAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE TOTAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IVA FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, @ContactoTipoEspecifico  FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IVA FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, @ContactoTipoEspecifico  FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IEPS FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IEPS FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPORTE S/FISCAL'     INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, 0.0)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, 0.0), @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE S/FISCAL'    	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, 0.0)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, 0.0), @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'SALDO A FAVOR'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'SALDO A FAVOR'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'REDONDEO'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'REDONDEO'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'ANTICIPOS ACUMULADOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'ANTICIPOS ACUMULADOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'UTILIDAD'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe>0 ELSE --REQ 13147
    IF @Haber  = 'UTILIDAD'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe>0 ELSE --REQ 13147
    IF @Debe   = 'PERDIDA'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(-d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe<0 ELSE --REQ 13147
    IF @Haber  = 'PERDIDA'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(-d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe<0 ELSE --REQ 13147
    IF @Debe  IN ('DIFERENCIA IVA', 'UTILIDAD IVA', 'PERDIDA IVA', 'DIFERENCIA IEPS', 'UTILIDAD IEPS', 'PERDIDA IEPS') OR
       @Haber IN ('DIFERENCIA IVA', 'UTILIDAD IVA', 'PERDIDA IVA', 'DIFERENCIA IEPS', 'UTILIDAD IEPS', 'PERDIDA IEPS')
    BEGIN
      SELECT @DiferenciaIVA = SUM(d.Importe*a.IVAFiscal), 
             @DiferenciaIEPS = SUM(d.Importe*a.IEPSFiscal) 
        FROM CxcD d
        JOIN CxcAplica a  ON a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Empresa = @Empresa 
       WHERE d.ID = @ID 
      IF @Debe  = 'DIFERENCIA IVA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
      IF @Haber = 'DIFERENCIA IVA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
      IF @Debe  = 'UTILIDAD IVA'    AND @DiferenciaIVA  > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'UTILIDAD IVA'    AND @DiferenciaIVA  > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'PERDIDA IVA'     AND @DiferenciaIVA  < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'PERDIDA IVA'     AND @DiferenciaIVA  < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'DIFERENCIA IEPS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'DIFERENCIA IEPS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'UTILIDAD IEPS'   AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'UTILIDAD IEPS'   AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'PERDIDA IEPS'    AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'PERDIDA IEPS'    AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico)  --REQ 13147
    END ELSE
    IF @Debe   = 'INTERESES'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(1-(ISNULL(d.InteresesOrdinariosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(1-(ISNULL(d.InteresesOrdinariosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(d.InteresesOrdinariosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(d.InteresesOrdinariosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(1-(ISNULL(d.InteresesMoratoriosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(1-(ISNULL(d.InteresesMoratoriosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(d.InteresesMoratoriosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(d.InteresesMoratoriosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxc e, CxcD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'COMISIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Comisiones*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'COMISIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Comisiones*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'COMISIONES IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ComisionesIVA*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'COMISIONES IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ComisionesIVA*TipoCambio, @ContactoTipoEspecifico    	FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'TOTAL COMISIONES' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0)*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'TOTAL COMISIONES' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0)*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES ANTICIPADO' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, InteresesAnticipados*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES ANTICIPADO' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, InteresesAnticipados*TipoCambio, @ContactoTipoEspecifico FROM Cxc WHERE ID = @ID ELSE --REQ 13147
    IF @Debe  IN ('IVA DIF. CAMBIARIA', 'IVA UTI. CAMBIARIA', 'IVA PER. CAMBIARIA', 'IEPS DIF. CAMBIARIA', 'IEPS UTI. CAMBIARIA', 'IEPS PER. CAMBIARIA', 'DIFERENCIA CAMBIARIA', 'UTILIDAD CAMBIARIA', 'PERDIDA CAMBIARIA') OR
       @Haber IN ('IVA DIF. CAMBIARIA', 'IVA UTI. CAMBIARIA', 'IVA PER. CAMBIARIA', 'IEPS DIF. CAMBIARIA', 'IEPS UTI. CAMBIARIA', 'IEPS PER. CAMBIARIA', 'DIFERENCIA CAMBIARIA', 'UTILIDAD CAMBIARIA', 'PERDIDA CAMBIARIA') 
    BEGIN
	  SELECT @CxImporteTotalMN = (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio, @CxTipoCambio = TipoCambio, @ContactoTipoCambio = ClienteTipoCambio FROM Cxc WHERE ID = @ID
      IF @CxTipoCambio <> 1.0 OR @ContactoTipoCambio <> 1.0
      BEGIN
        SELECT @CxPicosMN = SUM(Importe)*@CxTipoCambio FROM CxcD WHERE ID = @ID AND UPPER(Aplica) IN ('REDONDEO', 'SALDO A FAVOR', 'ANTICIPOS ACUMULADOS')
        SELECT @CxImporteTotalMN = @CxImporteTotalMN - ISNULL(@CxPicosMN, 0)
        SELECT @CxIVAMN = @CxImporteTotalMN * IVAFiscal, @CxIEPSMN = @CxImporteTotalMN * IEPSFiscal FROM Cxc WHERE ID = @ID

	-- JHA 23/12/2008 ahora considera reevaluaciones
        SELECT @CxImporteAplicaMN = SUM(d.Importe/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXC.RE' THEN l.TipoCambio ELSE a.TipoCambio END),
               @CxIVAAplicaMN = SUM(d.Importe*a.IVAFiscal/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXC.RE' THEN l.TipoCambio ELSE a.TipoCambio END), 
               @CxIEPSAplicaMN = SUM(d.Importe*a.IEPSFiscal/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXC.RE' THEN l.TipoCambio ELSE a.TipoCambio END) 
          FROM CxcD d
          JOIN CxcAplica a  ON a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Empresa = @Empresa 
          LEFT OUTER JOIN CxReevaluacionLog l ON l.Modulo = @Modulo AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
         WHERE d.ID = @ID 
        --24226
        --SELECT @CxIVAMN = SUM(d.Importe*a.IVAFiscal)*  @ContactoTipoCambio
          SELECT @CxIVAMN = SUM(d.Importe*a.IVAFiscal)*  @CxTipoCambio          
        FROM CxcD d
        JOIN CxcAplica a  ON a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Empresa = @Empresa 
        WHERE d.ID = @ID 
            
        SELECT @Diferencia = @CxImporteTotalMN - @CxImporteAplicaMN
        SELECT @DiferenciaIVA = @CxIVAMN - @CxIVAAplicaMN,
               @DiferenciaIEPS = @CxIEPSMN - @CxIEPSAplicaMN
        IF ISNULL(@Diferencia, 0) <> 0
        BEGIN
          IF @Debe   = 'DIFERENCIA CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'DIFERENCIA CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'UTILIDAD CAMBIARIA'  AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso,  @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Haber  = 'UTILIDAD CAMBIARIA'  AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso,  @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Debe   = 'PERDIDA CAMBIARIA'   AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso,  @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Haber  = 'PERDIDA CAMBIARIA'   AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso,  @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Debe   = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,   ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Haber  = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Debe   = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,   ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,   ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,   ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Haber  = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Debe   = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,   ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber,  ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico)   --REQ 13147
        END
      END              
    END
    ELSE
    BEGIN
      IF @Debe IS NOT NULL
      BEGIN
        EXEC xpContAutoCampoExtra @Modulo, @ID, NULL, NULL, @Debe, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Monto IS NOT NULL
          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Monto*TipoCambio, @ContactoTipoEspecifico 	FROM Cxc WHERE ID = @ID --REQ 13147
      END ELSE 
      IF @Haber IS NOT NULL
      BEGIN
        EXEC xpContAutoCampoExtra @Modulo, @ID, NULL, NULL, @Haber, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Monto IS NOT NULL
          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Monto*TipoCambio, @ContactoTipoEspecifico 	FROM Cxc WHERE ID = @ID --REQ 13147
      END
    END
    
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    IF @Debe   = 'IMPORTE'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, @ContactoTipoEspecifico 	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Importe*TipoCambio, @ContactoTipoEspecifico 	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPUESTOS' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, @ContactoTipoEspecifico    	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPUESTOS' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Impuestos*TipoCambio, @ContactoTipoEspecifico    	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'RETENCIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Retencion, 0)+ISNULL(Retencion2, 0)+ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'RETENCIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Retencion, 0)+ISNULL(Retencion2, 0)+ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'RETENCION ISR' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion*TipoCambio, @ContactoTipoEspecifico        FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'RETENCION ISR' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion*TipoCambio, @ContactoTipoEspecifico        FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'RETENCION IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion2*TipoCambio, @ContactoTipoEspecifico       FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'RETENCION IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion2*TipoCambio, @ContactoTipoEspecifico       FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'RETENCION 3' 		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion3*TipoCambio, @ContactoTipoEspecifico       FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'RETENCION 3' 		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Retencion3*TipoCambio, @ContactoTipoEspecifico       FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPORTE TOTAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE TOTAL'        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IVA FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio*IVAFiscal, @ContactoTipoEspecifico  FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IVA FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio*IVAFiscal, @ContactoTipoEspecifico  FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IEPS FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio*IEPSFiscal, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IEPS FISCAL'        	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio*IEPSFiscal, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'IMPORTE S/FISCAL'    	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, 0.0)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, 0.0), @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'IMPORTE S/FISCAL'   	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IVAFiscal, 0.0)-ISNULL((ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0))*TipoCambio*IEPSFiscal, 0.0), @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'SALDO A FAVOR'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'SALDO A FAVOR'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'REDONDEO'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'REDONDEO'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'ANTICIPOS ACUMULADOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Debe  ELSE --REQ 13147
    IF @Haber  = 'ANTICIPOS ACUMULADOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, d.Importe*e.TipoCambio, @ContactoTipoEspecifico    	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND UPPER(d.Aplica) = @Haber ELSE --REQ 13147
    IF @Debe   = 'UTILIDAD'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(-d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe<0 ELSE --REQ 13147
    IF @Haber  = 'UTILIDAD'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(-d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe<0 ELSE --REQ 13147
    IF @Debe   = 'PERDIDA'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe>0 ELSE --REQ 13147
    IF @Haber  = 'PERDIDA'   	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.Importe*e.TipoCambio), @ContactoTipoEspecifico 	FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID AND d.Importe>0 ELSE --REQ 13147
    IF @Debe  IN ('DIFERENCIA IVA', 'UTILIDAD IVA', 'PERDIDA IVA', 'DIFERENCIA IEPS', 'UTILIDAD IEPS', 'PERDIDA IEPS') OR
       @Haber IN ('DIFERENCIA IVA', 'UTILIDAD IVA', 'PERDIDA IVA', 'DIFERENCIA IEPS', 'UTILIDAD IEPS', 'PERDIDA IEPS')
    BEGIN
      SELECT @DiferenciaIVA = SUM(d.Importe*a.IVAFiscal), 
             @DiferenciaIEPS = SUM(d.Importe*a.IEPSFiscal) 
        FROM CxpD d
        JOIN CxpAplica a  ON a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Empresa = @Empresa 
       WHERE d.ID = @ID 
      IF @Debe  = 'DIFERENCIA IVA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
      IF @Haber = 'DIFERENCIA IVA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
      IF @Debe  = 'UTILIDAD IVA'    AND @DiferenciaIVA  > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'UTILIDAD IVA'    AND @DiferenciaIVA  > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'PERDIDA IVA'     AND @DiferenciaIVA  < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'PERDIDA IVA'     AND @DiferenciaIVA  < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'DIFERENCIA IEPS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'DIFERENCIA IEPS' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'UTILIDAD IEPS'   AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'UTILIDAD IEPS'   AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Debe  = 'PERDIDA IEPS'    AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
      IF @Haber = 'PERDIDA IEPS'    AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico) 
    END ELSE
    IF @Debe   = 'INTERESES'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(1-(ISNULL(d.InteresesOrdinariosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(1-(ISNULL(d.InteresesOrdinariosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(d.InteresesOrdinariosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesOrdinarios*(d.InteresesOrdinariosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS'		INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(1-(ISNULL(d.InteresesMoratoriosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS NETOS'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(1-(ISNULL(d.InteresesMoratoriosQuita, 0.0)/100.0))*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'MORATORIOS QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(d.InteresesMoratoriosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Haber  = 'MORATORIOS QUITA'	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, SUM(d.InteresesMoratorios*(d.InteresesMoratoriosQuita/100.0)*e.TipoCambio), @ContactoTipoEspecifico FROM Cxp e, CxpD d WHERE e.ID = @ID AND d.ID = e.ID ELSE --REQ 13147
    IF @Debe   = 'COMISIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Comisiones*TipoCambio, @ContactoTipoEspecifico    	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'COMISIONES' 	        INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, Comisiones*TipoCambio, @ContactoTipoEspecifico    	FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'COMISIONES IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ComisionesIVA*TipoCambio, @ContactoTipoEspecifico   FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'COMISIONES IVA' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ComisionesIVA*TipoCambio, @ContactoTipoEspecifico   FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'TOTAL COMISIONES' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0)*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'TOTAL COMISIONES' 	INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0)*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe   = 'INTERESES ANTICIPADO' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, InteresesAnticipados*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Haber  = 'INTERESES ANTICIPADO' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, InteresesAnticipados*TipoCambio, @ContactoTipoEspecifico FROM Cxp WHERE ID = @ID ELSE --REQ 13147
    IF @Debe  IN ('IVA DIF. CAMBIARIA', 'IVA UTI. CAMBIARIA', 'IVA PER. CAMBIARIA', 'IEPS DIF. CAMBIARIA', 'IEPS UTI. CAMBIARIA', 'IEPS PER. CAMBIARIA', 'DIFERENCIA CAMBIARIA', 'UTILIDAD CAMBIARIA', 'PERDIDA CAMBIARIA') OR
       @Haber IN ('IVA DIF. CAMBIARIA', 'IVA UTI. CAMBIARIA', 'IVA PER. CAMBIARIA', 'IEPS DIF. CAMBIARIA', 'IEPS UTI. CAMBIARIA', 'IEPS PER. CAMBIARIA', 'DIFERENCIA CAMBIARIA', 'UTILIDAD CAMBIARIA', 'PERDIDA CAMBIARIA') 
    BEGIN
      SELECT @CxImporteTotalMN = (ISNULL(Importe, 0)+ISNULL(Impuestos, 0)-ISNULL(Retencion, 0)-ISNULL(Retencion2, 0)-ISNULL(Retencion3, 0))*TipoCambio, @CxTipoCambio = TipoCambio, @ContactoTipoCambio = ProveedorTipoCambio FROM Cxp WHERE ID = @ID
      IF @CxTipoCambio <> 1.0 OR @ContactoTipoCambio <> 1.0
      BEGIN
        SELECT @CxPicosMN = SUM(Importe)*@CxTipoCambio FROM CxpD WHERE ID = @ID AND UPPER(Aplica) IN ('REDONDEO', 'SALDO A FAVOR', 'ANTICIPOS ACUMULADOS')
        SELECT @CxImporteTotalMN = @CxImporteTotalMN - ISNULL(@CxPicosMN, 0)
        SELECT @CxIVAMN = @CxImporteTotalMN * IVAFiscal, @CxIEPSMN = @CxImporteTotalMN * IEPSFiscal FROM Cxp WHERE ID = @ID

	-- JHA 23/12/2008 ahora considera reevaluaciones
        SELECT @CxImporteAplicaMN = SUM(d.Importe/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXP.RE' THEN l.TipoCambio ELSE a.TipoCambio END),
               @CxIVAAplicaMN = SUM(d.Importe*a.IVAFiscal/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXP.RE' THEN l.TipoCambio ELSE a.TipoCambio END), 
               @CxIEPSAplicaMN = SUM(d.Importe*a.IEPSFiscal/@ContactoTipoCambio*@CxTipoCambio*CASE WHEN @MovTipo = 'CXP.RE' THEN l.TipoCambio ELSE a.TipoCambio END) 
          FROM CxpD d
          JOIN CxpAplica a  ON a.Mov = d.Aplica AND a.MovID = d.AplicaID AND a.Empresa = @Empresa 
          LEFT OUTER JOIN CxReevaluacionLog l ON l.Modulo = @Modulo AND l.ID = d.ID AND l.Renglon = d.Renglon AND l.RenglonSub = d.RenglonSub
         WHERE d.ID = @ID 

        SELECT @Diferencia = @CxImporteTotalMN - @CxImporteAplicaMN
        SELECT @DiferenciaIVA = @CxIVAMN - @CxIVAAplicaMN,
	       @DiferenciaIEPS = @CxIEPSMN - @CxIEPSAplicaMN
        IF ISNULL(@Diferencia, 0) <> 0
        BEGIN
          IF @Debe   = 'DIFERENCIA CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'DIFERENCIA CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'UTILIDAD CAMBIARIA'   AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Haber  = 'UTILIDAD CAMBIARIA'   AND @Diferencia < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Debe   = 'PERDIDA CAMBIARIA'    AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe,  ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Haber  = 'PERDIDA CAMBIARIA'    AND @Diferencia > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Diferencia, @ContactoTipoEspecifico) ELSE
          IF @Debe   = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Haber  = 'IVA DIF. CAMBIARIA'  INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Debe   = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IVA UTI. CAMBIARIA'  AND @DiferenciaIVA > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IVA PER. CAMBIARIA'  AND @DiferenciaIVA < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIVA, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IEPS DIF. CAMBIARIA' INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Debe   = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Haber  = 'IEPS UTI. CAMBIARIA' AND @DiferenciaIEPS > 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @DiferenciaIEPS, @ContactoTipoEspecifico)  ELSE --REQ 13147
          IF @Debe   = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico) ELSE --REQ 13147
          IF @Haber  = 'IEPS PER. CAMBIARIA' AND @DiferenciaIEPS < 0 INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber, ContactoTipo) VALUES (@Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, -@DiferenciaIEPS, @ContactoTipoEspecifico)   --REQ 13147
        END
      END
    END
    ELSE
    BEGIN
      IF @Debe IS NOT NULL
      BEGIN
        EXEC xpContAutoCampoExtra @Modulo, @ID, NULL, NULL, @Debe, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Monto IS NOT NULL
          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Debe, ContactoTipo)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Monto*TipoCambio, @ContactoTipoEspecifico 	FROM Cxc WHERE ID = @ID --REQ 13147
      END ELSE 
      IF @Haber IS NOT NULL
      BEGIN
        EXEC xpContAutoCampoExtra @Modulo, @ID, NULL, NULL, @Haber, @Monto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Monto IS NOT NULL
          INSERT #Poliza (Orden, Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Concepto, ContactoEspecifico, Haber)  SELECT @Orden, @Cta, @ContUso, @ContUso2, @ContUso3, @Concepto, @ContactoEspecifico, @Monto*TipoCambio 	FROM Cxc WHERE ID = @ID
      END
    END            
  END
  RETURN
END
GO