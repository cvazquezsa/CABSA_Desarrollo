SET ANSI_DEFAULTS OFF
GO

/* SP PLANEACION      */

SET ANSI_NULLS OFF
SET DATEFIRST 7
SET NOCOUNT ON

/**************** spPlanCentroCarga ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCentroCarga') and type = 'P') drop procedure dbo.spPlanCentroCarga
GO
CREATE PROCEDURE spPlanCentroCarga
			@Empresa 	char(5),
			@Centro		char(10)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @TipoPeriodo	varchar(20)

  SELECT @TipoPeriodo = UPPER(PlanTipoPeriodo) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  IF @TipoPeriodo = 'DIA'    SELECT Periodo, Estado, Carga FROM PlanCentroDayCarga   WHERE Empresa = @Empresa AND Centro = @Centro ELSE
  IF @TipoPeriodo = 'SEMANA' SELECT Periodo, Estado, Carga FROM PlanCentroWeekCarga  WHERE Empresa = @Empresa AND Centro = @Centro ELSE
  IF @TipoPeriodo = 'MES'    SELECT Periodo, Estado, Carga FROM PlanCentroMonthCarga WHERE Empresa = @Empresa AND Centro = @Centro 
END
GO

-- spPlanCentroCarga 'DEMO', 'ARMADO'
/**************** spPlanCentroCapacidadCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCentroCapacidadCalc') and type = 'P') drop procedure dbo.spPlanCentroCapacidadCalc
GO
CREATE PROCEDURE spPlanCentroCapacidadCalc
			@Empresa 	char(5),
			@Centro		char(10)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @TipoPeriodo	varchar(20)

  SELECT @TipoPeriodo = UPPER(PlanTipoPeriodo) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  IF @TipoPeriodo = 'DIA'      SELECT Capacidad FROM PlanCentroDayCapacidadCalc   WHERE Centro = @Centro ELSE
  IF @TipoPeriodo = 'SEMANA'   SELECT Capacidad FROM PlanCentroWeekCapacidadCalc  WHERE Centro = @Centro ELSE
  IF @TipoPeriodo = 'MES'      SELECT Capacidad FROM PlanCentroMonthCapacidadCalc WHERE Centro = @Centro 
END
GO
-- spPlanCentro 'DEMO'
/**************** spPlanCentro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCentro') and type = 'P') drop procedure dbo.spPlanCentro
GO
CREATE PROCEDURE spPlanCentro
			@Empresa 	char(5),
			@Centro		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @TipoPeriodo	varchar(20)

  SELECT @TipoPeriodo = UPPER(PlanTipoPeriodo) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  IF @TipoPeriodo = 'DIA'     	EXEC spPlanCentroDay   @Empresa, @Centro ELSE
  IF @TipoPeriodo = 'SEMANA'	EXEC spPlanCentroWeek  @Empresa, @Centro ELSE
  IF @TipoPeriodo = 'MES'	EXEC spPlanCentroMonth @Empresa, @Centro
END
GO
-- spPlanCentro 'DEMO'

/**************** spPlanDemanda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanDemanda') and type = 'P') drop procedure dbo.spPlanDemanda
GO
CREATE PROCEDURE spPlanDemanda
			@Estacion		int,
			@Empresa		char(5),
    			@Articulo		char(20),
			@Almacen		char(10) = NULL,
			@Hoy			datetime = NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @TipoPeriodo	varchar(20)

  SELECT @TipoPeriodo = UPPER(PlanTipoPeriodo) FROM EmpresaCfg2 WHERE Empresa = @Empresa
  SELECT @Almacen = NULLIF(NULLIF(RTRIM(@Almacen), ''), '0')
  IF @Hoy IS NULL SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT

  IF @TipoPeriodo = 'DIA'     	EXEC spPlanDemandaDay   @Estacion, @Empresa, @Articulo, @Almacen, @Hoy ELSE
  IF @TipoPeriodo = 'SEMANA'	EXEC spPlanDemandaWeek  @Estacion, @Empresa, @Articulo, @Almacen, @Hoy ELSE
  IF @TipoPeriodo = 'MES'	EXEC spPlanDemandaMonth @Estacion, @Empresa, @Articulo, @Almacen, @Hoy
END
GO
-- spPlanDemanda 501, 'DEMO', 'A1'

-- select * from plandemanda

/**************** spPlanSeleccionEstado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanSeleccionEstado') and type = 'P') drop procedure dbo.spPlanSeleccionEstado
GO
CREATE PROCEDURE spPlanSeleccionEstado
			@Estacion	int,
			@Estado		varchar(20)
--//WITH ENCRYPTION
AS BEGIN 
  UPDATE PlanArtOP 
     SET Estado = @Estado
    FROM PlanArtOP p, ListaID l 
   WHERE p.ID = l.ID AND l.Estacion = @Estacion
END
GO

/**************** spPlanHist ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanHist') and type = 'P') drop procedure dbo.spPlanHist
GO
CREATE PROCEDURE spPlanHist
			@EnSilencio bit = 0
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Hoy	datetime,
    @Conteo	int
  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT

  DELETE PlanArtOPHist WHERE Fecha = @Hoy
  INSERT PlanArtOPHist (Fecha, Empresa, Articulo, SubCuenta, Almacen, ID, Sucursal, AlmacenDestino, FechaLiberacionOriginal, FechaEntregaOriginal, CantidadOriginal, RutaOriginal, FechaLiberacion, FechaEntrega, Cantidad, Ruta, Unidad, Proveedor, Accion, Estado, LiberacionModulo, LiberacionID, LiberacionMov, LiberacionMovID)
                  SELECT @Hoy, Empresa, Articulo, SubCuenta, Almacen, ID, Sucursal, AlmacenDestino, FechaLiberacionOriginal, FechaEntregaOriginal, CantidadOriginal, RutaOriginal, FechaLiberacion, FechaEntrega, Cantidad, Ruta, Unidad, Proveedor, Accion, Estado, LiberacionModulo, LiberacionID, LiberacionMov, LiberacionMovID
                    FROM PlanArtOP
  SELECT @Conteo = @@ROWCOUNT
  IF @EnSilencio = 0
    SELECT CONVERT(varchar, @Conteo)+' Registros Almacenados'
END
GO

/**************** spPlanLiberarOrdenesDe ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanLiberarOrdenesDe') and type = 'P') drop procedure dbo.spPlanLiberarOrdenesDe
GO
CREATE PROCEDURE spPlanLiberarOrdenesDe
			@Empresa	char(5),
			@Accion		varchar(20),
			@Campo		varchar(50),
			@Valor		varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  BEGIN TRANSACTION
    IF @Campo = 'Ruta' 			UPDATE PlanArtOp SET Estado = 'Liberado' WHERE Empresa = @Empresa AND Accion = @Accion AND Ruta      	  = @Valor ELSE
    IF @Campo = 'Proveedor' 		UPDATE PlanArtOp SET Estado = 'Liberado' WHERE Empresa = @Empresa AND Accion = @Accion AND Proveedor 	  = @Valor ELSE
    IF @Campo = 'Almacen' 		UPDATE PlanArtOp SET Estado = 'Liberado' WHERE Empresa = @Empresa AND Accion = @Accion AND Almacen   	  = @Valor ELSE
    IF @Campo = 'Almacen Destino' 	UPDATE PlanArtOp SET Estado = 'Liberado' WHERE Empresa = @Empresa AND Accion = @Accion AND AlmacenDestino = @Valor ELSE
    IF @Campo = 'Articulo' 		UPDATE PlanArtOp SET Estado = 'Liberado' WHERE Empresa = @Empresa AND Accion = @Accion AND Articulo       = @Valor ELSE
    IF @Campo = 'Categoria Proveedor'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Prov p WHERE o.Proveedor = p.Proveedor AND o.Empresa = @Empresa AND o.Accion = @Accion AND p.Categoria = @Valor ELSE
    IF @Campo = 'Familia Proveedor'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Prov p WHERE o.Proveedor = p.Proveedor AND o.Empresa = @Empresa AND o.Accion = @Accion AND p.Familia   = @Valor ELSE
    IF @Campo = 'Categoria Articulo'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Art a  WHERE o.Articulo  = a.Articulo  AND o.Empresa = @Empresa AND o.Accion = @Accion AND a.Categoria = @Valor ELSE
    IF @Campo = 'Grupo Articulo'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Art a  WHERE o.Articulo  = a.Articulo  AND o.Empresa = @Empresa AND o.Accion = @Accion AND a.Grupo     = @Valor ELSE
    IF @Campo = 'Familia Articulo'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Art a  WHERE o.Articulo  = a.Articulo  AND o.Empresa = @Empresa AND o.Accion = @Accion AND a.Familia   = @Valor ELSE
    IF @Campo = 'Fabricante Articulo'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Art a  WHERE o.Articulo  = a.Articulo  AND o.Empresa = @Empresa AND o.Accion = @Accion AND a.Fabricante= @Valor ELSE
    IF @Campo = 'Linea Articulo'	UPDATE PlanArtOp SET Estado = 'Liberado' FROM PlanArtOp o, Art a  WHERE o.Articulo  = a.Articulo  AND o.Empresa = @Empresa AND o.Accion = @Accion AND a.Linea     = @Valor
  COMMIT TRANSACTION
END
GO

-- spPlanArtOPLiberar 0, 'VINOS', 'DEMO'
/**************** spPlanArtOPLiberar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPLiberar') and type = 'P') drop procedure dbo.spPlanArtOPLiberar
GO
CREATE PROCEDURE spPlanArtOPLiberar
    			@Sucursal		int,
			@Empresa		char(5),
			@Usuario		char(10),
			@Referencia		varchar(50) = NULL,
			@ReferenciaModulo	varchar(5)  = NULL,
			@ReferenciaActividad	varchar(5)  = NULL
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Conteo			int,
    @Modulo			char(5),
    @Accion			char(20),
    @Estatus			char(15),
    @ProdMov			char(20),
    @CompraMov			char(20),
    @OrdenTransferencia 	char(20),
    @OrdenTraspaso		char(20),
    @ID				int,
    @Mov			char(20),
    @MovID			varchar(20),
    @Renglon			float,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @Almacen			char(10),
    @SucursalDestino		int,
    @AlmacenDestino		char(10),
    @FechaRegistro		datetime,
    @FechaEmision		datetime,
    @FechaEntrega		datetime,
    @FechaEntregaEncabezado	datetime,
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @MovZonaImpuesto		varchar(30),
    @Cantidad			float,
    @CantidadInventario		float,
    @CantidadOrden		float,
    @Unidad			varchar(50),
    @Ruta			varchar(20),
    @Proveedor			char(10),
    @ArtTipo			char(20),
    @ArtImpuesto1		float,
    @ArtImpuesto2		float,
    @ArtImpuesto3		money,
    @ArtRetencion1		float,
    @ArtRetencion2		float,
    @ArtRetencion3		float,
    @Moneda			char(10),
    @TipoCambio			float,
    @AutoReservar		bit,
    @IDGenerar			int,
    @ContID			int,
    @Ok				int,
    @OkRef			varchar(255),
    @VolverAfectar		int,
    @UltProv			char(10),
    @UltRuta			varchar(20),
    @UltAlmacen			char(10),
    @UltAlmacenDestino		char(10),
    @AfectarOrdenesDistribucion bit,
    @CfgCompraCostoSugerido  	char(20),
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @PlanLiberarCompra		char(30),
    @PlanLiberarProduccion	char(30),
    @PlanLiberarDistribucion	char(30), 
    @PlanUnidadDistribucion	varchar(20),
    @Costo			money,
    @PlanEditarOrdenes		bit,
    @CompraMultiAlmacen		bit,
    @CfgBackOrders		bit, 
    @VerDestino			bit,
    @VentaID			int,
    @VentaMov			varchar(20),
    @VentaMovID			varchar(20),
    @InvID			int,
    @InvMov			varchar(20),
    @InvMovID			varchar(20),
    @DestinoTipo		varchar(10),
    @Destino			varchar(20),
    @DestinoID			varchar(20),
    @ReferenciaProyecto		varchar(50),
    @PrecioListaProv varchar(50)

  SELECT @FechaRegistro    = GETDATE(), @Conteo = 0, @AutoReservar = 0, @Ok = NULL, @OkRef = NULL, @PlanEditarOrdenes = 0, @VerDestino = 0,
         @Referencia       = NULLIF(NULLIF(NULLIF(RTRIM(@Referencia), '(Todos)'), ''), '0'),
         @ReferenciaModulo = NULLIF(NULLIF(NULLIF(RTRIM(@ReferenciaModulo), '(Todos)'), ''), '0')

  SELECT @FechaEmision = @FechaRegistro
  EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT @ProdMov            = ProdOrdenProduccion,
         @CompraMov          = CompraOrden,
         @OrdenTransferencia = InvOrdenTransferencia,
         @OrdenTraspaso      = InvOrdenTraspaso
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF (SELECT ISNULL(PlanEditarOrdenes, 0) FROM UsuarioCfg2 WHERE Usuario = @Usuario) = 1
    SELECT @ProdMov            = ISNULL(NULLIF(RTRIM(PlanOrdenProduccion), ''), @ProdMov),
           @CompraMov          = ISNULL(NULLIF(RTRIM(PlanOrdenCompra), ''), @CompraMov),
           @OrdenTransferencia = ISNULL(NULLIF(RTRIM(PlanOrdenTransferencia), ''), @OrdenTransferencia),
           @OrdenTraspaso      = ISNULL(NULLIF(RTRIM(PlanOrdenTraspaso), ''), @OrdenTraspaso)
      FROM UsuarioCfg2 
     WHERE Usuario = @Usuario

  SELECT @Moneda = m.Moneda, 
         @TipoCambio = m.TipoCambio,
         @CfgCompraCostoSugerido = cfg.CompraCostoSugerido,
         @CfgBackOrders	= cfg.BackOrders  
    FROM EmpresaCfg cfg, Mon m
   WHERE Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT @AutoReservar 		     = ProdAutoReservar,
         @AfectarOrdenesDistribucion = PlanAfectarOrdenesDistribucion,
         @CfgMultiUnidades           = MultiUnidades,
	 @CfgMultiUnidadesNivel      = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
   	 @PlanLiberarCompra	     = ISNULL(UPPER(PlanLiberarCompra),	'ORDEN POR PROVEEDOR'),
	 @PlanLiberarProduccion	     = ISNULL(UPPER(PlanLiberarProduccion), 'ORDEN POR SELECCION'),
         @PlanLiberarDistribucion    = ISNULL(UPPER(PlanLiberarDistribucion), 'ORDEN POR ALMACEN'),
         @PlanUnidadDistribucion     = ISNULL(UPPER(PlanUnidadDistribucion), 'COMPRA/PRODUCCION'),
         @CompraMultiAlmacen	     = CompraMultiAlmacen
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa
  IF @Referencia IS NOT NULL
  BEGIN
    IF @ReferenciaModulo = 'VTAS'
    BEGIN
      SELECT @VentaID = MAX(ID) FROM Venta WHERE Empresa = @Empresa AND @Referencia = RTRIM(Mov)+' '+RTRIM(MovID) AND Estatus = 'PENDIENTE'
      IF @VentaID IS NOT NULL
      BEGIN
        SELECT @VerDestino = @CfgBackOrders
        SELECT @VentaMov = Mov, @VentaMovID = MovID FROM Venta WHERE ID = @VentaID
      END
    END ELSE 
    IF @ReferenciaModulo = 'INV'
    BEGIN
      SELECT @InvID = MAX(ID) FROM Inv WHERE Empresa = @Empresa AND @Referencia = RTRIM(Mov)+' '+RTRIM(MovID) AND Estatus = 'PENDIENTE'
      IF @InvID IS NOT NULL
      BEGIN
        SELECT @VerDestino = @CfgBackOrders
        SELECT @InvMov = Mov, @InvMovID = MovID FROM Inv WHERE ID = @InvID
      END
    END 
  END

  BEGIN TRANSACTION

    /********** Orden Produccion **********/
    SELECT @Mov = @ProdMov, @ID = NULL, @Modulo = 'PROD', @UltRuta = NULL, @Accion = 'CONSECUTIVO', @Estatus = 'CONFIRMAR'

    IF @PlanLiberarProduccion = 'ORDEN POR RUTA'
      DECLARE crLiberarProd CURSOR FOR 
       SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(p.SubCuenta), ''), NULLIF(RTRIM(p.Almacen), ''), p.FechaEntrega, ISNULL(p.Cantidad, 0.0), a.UnidadCompra, NULLIF(RTRIM(p.Ruta), ''), a.Tipo
         FROM PlanArtOP p, Art a
        WHERE p.Articulo = a.Articulo AND p.Empresa = @Empresa AND UPPER(p.Estado) = 'LIBERADO' AND UPPER(p.Accion) = 'PRODUCIR' AND p.LiberacionID IS NULL AND ISNULL(p.Cantidad, 0.0) > 0.0
        ORDER BY p.Ruta, p.FechaLiberacion, p.Articulo, p.SubCuenta, p.Almacen, p.Cantidad
    ELSE
      DECLARE crLiberarProd CURSOR FOR 
       SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(p.SubCuenta), ''), NULLIF(RTRIM(p.Almacen), ''), p.FechaEntrega, ISNULL(p.Cantidad, 0.0), a.UnidadCompra, NULLIF(RTRIM(p.Ruta), ''), a.Tipo
         FROM PlanArtOP p, Art a
        WHERE p.Articulo = a.Articulo AND p.Empresa = @Empresa AND UPPER(p.Estado) = 'LIBERADO' AND UPPER(p.Accion) = 'PRODUCIR' AND p.LiberacionID IS NULL AND ISNULL(p.Cantidad, 0.0) > 0.0
        ORDER BY p.FechaLiberacion, p.Articulo, p.SubCuenta, p.Ruta, p.Almacen, p.Cantidad

    OPEN crLiberarProd
    FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @FechaEntrega, @Cantidad, @Unidad, @Ruta, @ArtTipo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @ID IS NULL OR (@UltRuta <> @Ruta AND @PlanLiberarProduccion = 'ORDEN POR RUTA') OR @PlanLiberarProduccion = 'ORDEN POR RENGLON'
        BEGIN
          IF @Almacen IS NULL SELECT @Ok = 20820, @OkRef = @Articulo
          IF @ID IS NOT NULL
          BEGIN
            SELECT @FechaEntregaEncabezado = MIN(FechaRequerida) FROM ProdD WHERE ID = @ID
            UPDATE Prod SET RenglonID = @RenglonID, FechaEntrega = @FechaEntregaEncabezado WHERE ID = @ID 
            EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL, 
                       @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
            IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

            UPDATE PlanArtOP 
               SET LiberacionModulo = @Modulo,
                   LiberacionID     = @ID,
                   LiberacionMov    = @Mov,
                   LiberacionMovID  = @MovID
             WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'PRODUCIR' AND LiberacionID IS NULL
          END

          IF @ReferenciaModulo = 'PROY' SET @ReferenciaProyecto = @Referencia
  
          INSERT Prod (Sucursal, SucursalDestino, OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Almacen,  Prioridad, AutoReservar,  Referencia,  VerDestino, Proyecto,             Actividad)
          SELECT      @Sucursal, @SucursalDestino, 'PLAN',    @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Almacen, 'Normal',  @AutoReservar, @Referencia, @VerDestino, @ReferenciaProyecto, @ReferenciaActividad
          SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
          SELECT @UltRuta = @Ruta
          IF @VentaID IS NOT NULL
            EXEC xpSetVentaProdID @VentaID, @ID
        END

        EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @CantidadOrden = ROUND(@Cantidad / (@CantidadInventario / @Cantidad), 4), @CantidadInventario = @Cantidad

        SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL
        IF @VerDestino = 1
        BEGIN
          IF @ReferenciaModulo = 'VTAS'
            IF (SELECT ISNULL(SUM(CantidadPendiente), 0) FROM VentaD WHERE ID = @VentaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')) >= @CantidadOrden
              SELECT @DestinoTipo = 'VTAS', @Destino = @VentaMov, @DestinoID = @VentaMovID
 
          IF @ReferenciaModulo = 'INV'
            IF (SELECT ISNULL(SUM(CantidadPendiente), 0) FROM InvD WHERE ID = @InvID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')) >= @CantidadOrden
              SELECT @DestinoTipo = 'INV', @Destino = @InvMov, @DestinoID = @InvMovID
        END

        INSERT ProdD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Almacen,  Cantidad,        Unidad,  CantidadInventario, Ruta,  FechaRequerida, DestinoTipo,  Destino,  DestinoID)
              VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @Ruta, @FechaEntrega,  @DestinoTipo, @Destino, @DestinoID) 

        EXEC xpPlanArtOPLiberar @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Moneda, @Renglon, 0, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @Ruta, @FechaEntrega, @Ok OUTPUT, @OkRef OUTPUT
      END
      FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @FechaEntrega, @Cantidad, @Unidad, @Ruta, @ArtTipo
    END
    CLOSE crLiberarProd
    DEALLOCATE crLiberarProd
 
    IF @ID IS NOT NULL
    BEGIN
      SELECT @FechaEntregaEncabezado = MIN(FechaRequerida) FROM ProdD WHERE ID = @ID

      -- Quitar Destino
      IF @VerDestino = 1
        IF NOT EXISTS(SELECT * FROM ProdD WHERE ID = @ID AND DestinoTipo IS NOT NULL)
          UPDATE Prod SET VerDestino = 0 WHERE ID = @ID

      UPDATE Prod SET RenglonID = @RenglonID, FechaEntrega = @FechaEntregaEncabezado WHERE ID = @ID 
      EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL, 
                 @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
      IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

      UPDATE PlanArtOP 
         SET LiberacionModulo = @Modulo,
             LiberacionID     = @ID,
             LiberacionMov    = @Mov,
             LiberacionMovID  = @MovID
       WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'PRODUCIR' AND LiberacionID IS NULL
    END

    /********** Ordenes Compra **********/
    SELECT @Mov = @CompraMov, @ID = NULL, @UltAlmacen = NULL, @Modulo = 'COMS', @UltProv = NULL, @Accion = 'CONSECUTIVO', @Estatus = 'CONFIRMAR'
    DECLARE crLiberarProd CURSOR FOR 
     SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(p.SubCuenta), ''), NULLIF(RTRIM(p.Almacen), ''), p.FechaEntrega, ISNULL(p.Cantidad, 0.0), a.UnidadCompra, NULLIF(RTRIM(p.Proveedor), ''), a.Tipo, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.Retencion1, a.Retencion2, a.Retencion3
       FROM PlanArtOP p, Art a
      WHERE p.Articulo = a.Articulo AND p.Empresa = @Empresa AND UPPER(p.Estado) = 'LIBERADO' AND UPPER(p.Accion) = 'COMPRAR' AND p.LiberacionID IS NULL AND ISNULL(p.Cantidad, 0.0) > 0.0
      ORDER BY p.Proveedor, p.Almacen, p.FechaLiberacion, p.Articulo, p.SubCuenta, p.Cantidad

    OPEN crLiberarProd
    FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @FechaEntrega, @Cantidad, @Unidad, @Proveedor, @ArtTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @ID IS NULL OR @UltProv <> @Proveedor OR @PlanLiberarCompra = 'ORDEN POR RENGLON' OR (@UltAlmacen <> @Almacen AND @CompraMultiAlmacen = 0)
        BEGIN
          IF @Almacen IS NULL SELECT @Ok = 20820, @OkRef = @Articulo
          IF @ID IS NOT NULL
          BEGIN
    	    UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID 
            EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL, 
                       @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
            IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

            UPDATE PlanArtOP 
               SET LiberacionModulo = @Modulo,
                   LiberacionID     = @ID,
                   LiberacionMov    = @Mov,
                   LiberacionMovID  = @MovID
             WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'COMPRAR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Proveedor), '') = @UltProv
          END

          IF @ReferenciaModulo = 'PROY' SET @ReferenciaProyecto = @Referencia

          INSERT Compra (Sucursal,  OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,  Moneda,  TipoCambio,   Proveedor,  Almacen,  Prioridad, Referencia,  VerDestino,  FechaRequerida, Proyecto,            Actividad)
                 VALUES (@Sucursal, 'PLAN',     @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Proveedor, @Almacen, 'Normal',   @Referencia, @VerDestino, @FechaEntrega,  @ReferenciaProyecto, @ReferenciaActividad)

          SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1

          IF @Proveedor IS NOT NULL
            UPDATE Compra 
               SET Proyecto 	= ISNULL(Compra.Proyecto,p.Proyecto), 
                   FormaEnvio 	= p.FormaEnvio, 
                   Agente	= p.Agente, 
                   Condicion	= p.Condicion, 
		   ZonaImpuesto	= p.ZonaImpuesto, 
  		   Idioma 	= p.Idioma,
                   Moneda       = m.Moneda,
                   TipoCambio	= m.TipoCambio
              FROM Compra, Prov p, Mon m
             WHERE Compra.ID = @ID AND p.Proveedor = @Proveedor AND m.Moneda = ISNULL(p.DefMoneda, @Moneda)

          SELECT @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @MovZonaImpuesto = ZonaImpuesto FROM Compra WHERE ID = @ID
          SELECT @UltProv = @Proveedor, @UltAlmacen = @Almacen
        END

        EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto1 OUTPUT
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto2 OUTPUT
        EXEC spZonaImp @MovZonaImpuesto, @ArtImpuesto3 OUTPUT
        EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Contacto = @Proveedor, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @ArtImpuesto1 OUTPUT, @Impuesto2 = @ArtImpuesto2 OUTPUT, @Impuesto3 = @ArtImpuesto3 OUTPUT
        
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @CantidadOrden = ROUND(@Cantidad / (@CantidadInventario / @Cantidad), 4), @CantidadInventario = @Cantidad
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0

        --Validacion cuando el proveedor tiene configurado una "Lista de Precios" trae el precio como costo para generar la Orden de Compra.
        SELECT @PrecioListaProv=ListaPreciosEsp FROM Prov WHERE Proveedor=@Proveedor
        IF ISNULL(@PrecioListaProv,'')<>''
        BEGIN    
	        SET @Costo = NULL
	        EXEC spPrecioEsp @PrecioListaProv, @Moneda, @Articulo, @SubCuenta, @Costo OUTPUT, @Unidad = @Unidad
	        SET @PrecioListaProv = NULL
        END

        SELECT @DestinoTipo = NULL, @Destino = NULL, @DestinoID = NULL
        IF @VerDestino = 1
        BEGIN
          IF @ReferenciaModulo = 'VTAS'
            IF (SELECT ISNULL(SUM(CantidadPendiente), 0) FROM VentaD WHERE ID = @VentaID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')) >= @CantidadOrden
              SELECT @DestinoTipo = 'VTAS', @Destino = @VentaMov, @DestinoID = @VentaMovID
 
          IF @ReferenciaModulo = 'INV'
            IF (SELECT ISNULL(SUM(CantidadPendiente), 0) FROM InvD WHERE ID = @InvID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')) >= @CantidadOrden
              SELECT @DestinoTipo = 'INV', @Destino = @InvMov, @DestinoID = @InvMovID
        END

        INSERT CompraD (Sucursal, ID, Renglon,   RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,   Almacen,  Cantidad,       Unidad,  CantidadInventario,  Costo,  FechaEntrega,  FechaRequerida, Impuesto1,     Impuesto2,     Impuesto3,     Retencion1,     Retencion2,     Retencion3,     DestinoTipo,  Destino,  DestinoID)
                VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @Costo, @FechaEntrega, @FechaEntrega,  @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3, @DestinoTipo, @Destino, @DestinoID)

        EXEC xpPlanArtOPLiberar @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Moneda, @Renglon, 0, @Articulo, @SubCuenta, @Almacen, @Cantidad, @Unidad, @CantidadInventario, @Proveedor, @FechaEntrega, @Ok OUTPUT, @OkRef OUTPUT
      END
      FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @FechaEntrega, @Cantidad, @Unidad, @Proveedor, @ArtTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @ArtRetencion1, @ArtRetencion2, @ArtRetencion3
    END
    CLOSE crLiberarProd
    DEALLOCATE crLiberarProd

    IF @ID IS NOT NULL
    BEGIN
      -- Quitar Destino
      IF @VerDestino = 1
        IF NOT EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND DestinoTipo IS NOT NULL)
          UPDATE Compra SET VerDestino = 0 WHERE ID = @ID

      UPDATE Compra SET RenglonID = @RenglonID WHERE ID = @ID 
      EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                 @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
      IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

      UPDATE PlanArtOP 
         SET LiberacionModulo = @Modulo,
             LiberacionID     = @ID,
             LiberacionMov    = @Mov,
             LiberacionMovID  = @MovID
       WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'COMPRAR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Proveedor), '') = @UltProv
    END


    /********** Ordenes Distribucion **********/
    SELECT @ID = NULL, @UltAlmacen = NULL, @UltAlmacenDestino = NULL, @Modulo = 'INV'
    IF @AfectarOrdenesDistribucion = 1 
      SELECT @Accion = 'AFECTAR', @Estatus = 'SINAFECTAR' 
    ELSE SELECT @Accion = 'CONSECUTIVO', @Estatus = 'CONFIRMAR'
    DECLARE crLiberarProd CURSOR FOR 
     SELECT NULLIF(p.Sucursal, @Sucursal), p.Articulo, NULLIF(RTRIM(p.SubCuenta), ''), NULLIF(RTRIM(p.Almacen), ''), NULLIF(RTRIM(p.AlmacenDestino), ''), p.FechaEntrega, ISNULL(p.Cantidad, 0.0), CASE @PlanUnidadDistribucion WHEN 'VENTA' THEN a.Unidad WHEN 'TRASPASO' THEN ISNULL(a.UnidadTraspaso, a.UnidadCompra) ELSE a.UnidadCompra END, a.Tipo
       FROM PlanArtOP p, Art a
      WHERE p.Articulo = a.Articulo AND p.Empresa = @Empresa AND UPPER(p.Estado) = 'LIBERADO' AND UPPER(p.Accion) = 'DISTRIBUIR' AND p.LiberacionID IS NULL AND ISNULL(p.Cantidad, 0.0) > 0.0
      ORDER BY p.Almacen, p.AlmacenDestino, p.FechaLiberacion, a.Categoria, a.Familia, p.Articulo, p.SubCuenta, p.Cantidad 

    OPEN crLiberarProd
    FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, @FechaEntrega, @Cantidad, @Unidad, @ArtTipo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @UltAlmacen <> @Almacen OR @UltAlmacenDestino <> @AlmacenDestino OR @PlanLiberarDistribucion = 'ORDEN POR RENGLON'
        BEGIN
          IF @Almacen IS NULL SELECT @Ok = 20830, @OkRef = @Articulo
          IF @AlmacenDestino IS NULL SELECT @Ok = 20840, @OkRef = @Articulo
          IF @ID IS NOT NULL
          BEGIN
    	    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID 
            EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL, 
                       @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
            IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL
   
            IF @Accion = 'AFECTAR'
              DELETE PlanArtOP
               WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'DISTRIBUIR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Almacen), '') = @UltAlmacen AND NULLIF(RTRIM(AlmacenDestino), '') = @UltAlmacenDestino
            ELSE
              UPDATE PlanArtOP 
                 SET LiberacionModulo = @Modulo,
                     LiberacionID     = @ID,
                     LiberacionMov    = @Mov,
                     LiberacionMovID  = @MovID
               WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'DISTRIBUIR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Almacen), '') = @UltAlmacen AND NULLIF(RTRIM(AlmacenDestino), '') = @UltAlmacenDestino
          END

          IF (SELECT Sucursal FROM Alm WHERE Almacen = @Almacen) <> (SELECT Sucursal FROM Alm WHERE Almacen = @AlmacenDestino)
            SELECT @Mov = @OrdenTraspaso
          ELSE
            SELECT @Mov = @OrdenTransferencia

          IF @ReferenciaModulo = 'PROY' SET @ReferenciaProyecto = @Referencia

          INSERT Inv (Sucursal,  OrigenTipo, Empresa,  Usuario,  Estatus,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Almacen,  AlmacenDestino,  Prioridad, Referencia, FechaRequerida, Proyecto,            Actividad)
          SELECT      @Sucursal, 'PLAN',     @Empresa, @Usuario, @Estatus, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Almacen, @AlmacenDestino, 'Normal', @Referencia, @FechaEntrega,  @ReferenciaProyecto, @ReferenciaActividad
          SELECT @ID = SCOPE_IDENTITY(), @Renglon = 0.0, @RenglonID = 0, @Conteo = @Conteo + 1
          SELECT @UltAlmacen = @Almacen, @UltAlmacenDestino = @AlmacenDestino
        END

        EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
        EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @CantidadOrden = ROUND(@Cantidad / (@CantidadInventario / @Cantidad), 4), @CantidadInventario = @Cantidad
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @CfgCompraCostoSugerido, @MovMoneda, @MovTipoCambio, @Costo OUTPUT, 0

        INSERT InvD (Sucursal,  ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Almacen,  Cantidad,       Unidad,  CantidadInventario, FechaRequerida, Costo)
             VALUES (@Sucursal, @ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @FechaEntrega, @Costo)
        EXEC xpPlanArtOPLiberar @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Moneda, @Renglon, 0, @Articulo, @SubCuenta, @Almacen, @CantidadOrden, @Unidad, @CantidadInventario, @AlmacenDestino, @FechaEntrega, @Ok OUTPUT, @OkRef OUTPUT
      END
      FETCH NEXT FROM crLiberarProd INTO @SucursalDestino, @Articulo, @SubCuenta, @Almacen, @AlmacenDestino, @FechaEntrega, @Cantidad, @Unidad, @ArtTipo
    END
    CLOSE crLiberarProd
    DEALLOCATE crLiberarProd

    IF @ID IS NOT NULL
    BEGIN
      UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID 
      EXEC spInv @ID, @Modulo, @Accion, 'TODO', @FechaRegistro, @Mov, @Usuario, 1, 0, NULL,
                 @Mov, @MovID OUTPUT, @IDGenerar, @ContID, @Ok, @OkRef, @VolverAfectar
      IF @Ok = 80060 SELECT @Ok = NULL, @OkRef = NULL

      IF @Accion = 'AFECTAR'
        DELETE PlanArtOP
         WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'DISTRIBUIR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Almacen), '') = @UltAlmacen AND NULLIF(RTRIM(AlmacenDestino), '') = @UltAlmacenDestino
      ELSE
        UPDATE PlanArtOP
           SET LiberacionModulo = @Modulo,
               LiberacionID     = @ID,
               LiberacionMov    = @Mov,
               LiberacionMovID  = @MovID
         WHERE Empresa = @Empresa AND UPPER(Estado) = 'LIBERADO' AND UPPER(Accion) = 'DISTRIBUIR' AND LiberacionID IS NULL AND NULLIF(RTRIM(Almacen), '') = @UltAlmacen AND NULLIF(RTRIM(AlmacenDestino), '') = @UltAlmacenDestino
    END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    IF @Conteo = 1
      SELECT 'Se generó con éxito '+LTRIM(CONVERT(char, @Conteo))+' Orden'
    ELSE
      SELECT 'Se generaron con éxito '+LTRIM(CONVERT(char, @Conteo))+' Ordenes'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

--  spPlanArtOPLiberar 0, 'DEMO', 'DEMO'

/**************** spPlanArtOPDividir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPDividir') and type = 'P') drop procedure dbo.spPlanArtOPDividir
GO
CREATE PROCEDURE spPlanArtOPDividir
			@Empresa		char(5),
			@Almacen		char(10),
    			@Articulo		char(20),
    			@SubCuenta		varchar(50),
			@ID			int
--//WITH ENCRYPTION
AS BEGIN 
  BEGIN TRANSACTION
    INSERT PlanArtOP (Sucursal, Empresa,  Almacen, AlmacenDestino, Articulo,  SubCuenta,  FechaLiberacionOriginal,  FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal,    Cantidad,    RutaOriginal,  Ruta, Unidad, Proveedor, Accion, Estado)
               SELECT Sucursal, Empresa,  Almacen, AlmacenDestino, Articulo,  SubCuenta,  FechaLiberacionOriginal,  FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal/2,  Cantidad/2,  RutaOriginal,  Ruta, Unidad, Proveedor, Accion, Estado
                 FROM PlanArtOP
                WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND ID = @ID
    INSERT PlanArtOP (Sucursal, Empresa,  Almacen, AlmacenDestino, Articulo,  SubCuenta,  FechaLiberacionOriginal,  FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal,    Cantidad,    RutaOriginal,  Ruta, Unidad, Proveedor, Accion, Estado)
               SELECT Sucursal, Empresa,  Almacen, AlmacenDestino, Articulo,  SubCuenta,  FechaLiberacionOriginal,  FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal/2,  Cantidad/2,  RutaOriginal,  Ruta, Unidad, Proveedor, Accion, Estado
                 FROM PlanArtOP
                WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND ID = @ID
    DELETE PlanArtOP
     WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND ID = @ID
  COMMIT TRANSACTION
  RETURN
END
GO


/**************** spPlanArtOPUnir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPUnir') and type = 'P') drop procedure dbo.spPlanArtOPUnir
GO
CREATE PROCEDURE spPlanArtOPUnir
			@Empresa		char(5),
			@Almacen		char(10),
    			@Articulo		char(20),
    			@SubCuenta		varchar(50), 
			@ID			int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Sucursal			int,
    @Cantidad			float,
    @CantidadOriginal		float,
    @AlmacenDestino		char(10),
    @Ruta			varchar(20),
    @RutaOriginal		varchar(20),
    @FechaLiberacionOriginal	datetime,
    @FechaLiberacion		datetime,
    @FechaEntregaOriginal	datetime,
    @FechaEntrega		datetime,
    @Proveedor			char(10),
    @Unidad			varchar(50),
    @Accion			varchar(20),
    @Estado			varchar(20)

  BEGIN TRANSACTION
    SELECT @Sucursal = Sucursal, 
           @AlmacenDestino = AlmacenDestino,
           @Ruta = Ruta, 
           @RutaOriginal = RutaOriginal, 
           @FechaLiberacion = FechaLiberacion, 
           @FechaLiberacionOriginal = FechaLiberacionOriginal, 
           @FechaEntrega = FechaEntrega, 
           @FechaEntregaOriginal = FechaEntregaOriginal, 
           @Unidad = Unidad,
           @Proveedor = Proveedor,
           @Accion = Accion,
           @Estado = Estado
      FROM PlanArtOP
     WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND ID = @ID

    SELECT @Cantidad = SUM(Cantidad), @CantidadOriginal = SUM(CantidadOriginal) 
      FROM PlanArtOP
     WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
       AND AlmacenDestino = @AlmacenDestino AND Ruta = @Ruta AND RutaOriginal = @RutaOriginal 
       AND FechaLiberacion = @FechaLiberacion AND FechaLiberacionOriginal = @FechaLiberacionOriginal
       AND FechaEntrega = @FechaEntrega AND FechaEntregaOriginal = @FechaEntregaOriginal
       AND Unidad = @Unidad AND Proveedor = @Proveedor AND Accion = @Accion AND Estado = @Estado

    DELETE PlanArtOP
     WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
       AND AlmacenDestino = @AlmacenDestino AND Ruta = @Ruta AND RutaOriginal = @RutaOriginal 
       AND FechaLiberacion = @FechaLiberacion AND FechaLiberacionOriginal = @FechaLiberacionOriginal
       AND FechaEntrega = @FechaEntrega AND FechaEntregaOriginal = @FechaEntregaOriginal
       AND Unidad = @Unidad AND Proveedor = @Proveedor AND Accion = @Accion AND Estado = @Estado
     
    INSERT PlanArtOP (Sucursal,  Empresa,  Almacen,  AlmacenDestino,  Articulo,  SubCuenta,  FechaLiberacionOriginal,  FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal,  Cantidad,  RutaOriginal,  Ruta,  Unidad,  Proveedor,  Accion,  Estado)
              VALUES (@Sucursal, @Empresa, @Almacen, @AlmacenDestino, @Articulo, @SubCuenta, @FechaLiberacionOriginal, @FechaLiberacion, @FechaEntrega,         @FechaEntrega,  @CantidadOriginal, @Cantidad, @RutaOriginal, @Ruta, @Unidad, @Proveedor, @Accion, @Estado)
  COMMIT TRANSACTION
  RETURN
END
GO

/**************** spPlanArtExplotar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtExplotar') and type = 'P') drop procedure dbo.spPlanArtExplotar
GO
CREATE PROCEDURE spPlanArtExplotar
			@Empresa		char(5),
                        @Almacen		char(10),
			@Vuelta			int,
			@ProductoPeriodo	int,
			@MaterialPeriodo	int,
    			@Articulo		char(20),
    			@SubCuenta		varchar(50),
    			@Cantidad		float,
			@ArtCantidad		float,
                	@ArtUnidad		varchar(50),
			@Acronimo		char(10),
			@CfgMermaIncluida	bit,
			@CfgDesperdicioIncluido	bit,
			@CfgTipoMerma		char(1),
		    	@CfgMultiUnidades	bit,
		    	@CfgMultiUnidadesNivel	char(20),

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtFactor	 	  float,
    @ArtDecimales	  int,
    @Veces		  float,
    @SiOpcion		  varchar(100),
    @Material		  char(20),
    @mSubCuenta		  varchar(50),
    @mCantidad		  float,
    @mCantidadVeces	  float,
    @mUnidad		  varchar(50),
    @mFactor		  float,
    @mDecimales		  int,
    @mMerma	  	  float,
    @mDesperdicio 	  float,
    @mArtEsFormula	  bit,
    @mArtCantidad	  float,
    @mAlmacen		  char(10),
    @mArtTipo		  char(20),
    @mArtTipoOpcion	  char(20),
    @Continuar		  bit

  EXEC xpUnidadFactorProd @CfgMultiUnidades, @CfgMultiUnidadesNivel,
   		          @Articulo, @SubCuenta, @ArtUnidad, 
 		 	  @ArtFactor OUTPUT, @ArtDecimales OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @ArtCantidad = 0 OR @ArtFactor = 0.0 SELECT @Ok = 25030 
  IF @Ok IS NULL SELECT @Veces = @Cantidad / (@ArtCantidad*@ArtFactor)

  IF ROUND(@Cantidad, 4) > 0.0 AND @Ok IS NULL
  BEGIN
    DECLARE crArtMaterial CURSOR LOCAL FOR 
     SELECT NULLIF(RTRIM(e.SiOpcion), ''), e.Material, NULLIF(RTRIM(e.SubCuenta), ''), ISNULL(e.Cantidad, 0.0), e.Unidad, ISNULL(e.Merma, 0.0), ISNULL(e.Desperdicio, 0.0), a.EsFormula, a.ProdCantidad, NULLIF(RTRIM(e.Almacen), ''), a.Tipo, a.TipoOpcion
       FROM ArtMaterial e, Art a
      WHERE e.Material = a.Articulo AND a.Estatus NOT IN ('BAJA', 'DESCONTINUADO')
        AND e.Articulo = @Articulo
      ORDER BY e.SiOpcion, e.Material, e.SubCuenta

    OPEN crArtMaterial
    FETCH NEXT FROM crArtMaterial INTO @SiOpcion, @Material, @mSubCuenta, @mCantidad, @mUnidad, @mMerma, @mDesperdicio, @mArtEsFormula, @mArtCantidad, @mAlmacen, @mArtTipo, @mArtTipoOpcion
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF UPPER(@mAlmacen) = '(DEMANDA)' SELECT @mAlmacen = @Almacen
        IF NULLIF(RTRIM(@mAlmacen), '') IS NULL SELECT @Ok = 20855, @OkRef = RTRIM(@Material)

        SELECT @Continuar = 1
        IF @SubCuenta IS NOT NULL AND @SiOpcion IS NOT NULL
          EXEC spOpcionContinuar @SiOpcion, @SubCuenta, @Continuar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Continuar = 1
        BEGIN
          EXEC xpUnidadFactorProd @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Material, @mSubCuenta, @mUnidad, @mFactor OUTPUT, @mDecimales OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL
          BEGIN
            IF @mSubCuenta IS NULL AND UPPER(@mArtTipoOpcion) = 'SI'
              EXEC spOpcionHeredar @SubCuenta, @Material, @mSubCuenta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
            ELSE IF CHARINDEX(':', @mSubCuenta) > 0 AND CHARINDEX(':', @SiOpcion) > 0 
              EXEC spOpcionHeredarRango @SiOpcion, @SubCuenta, @mSubCuenta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            IF UPPER(@mArtTipo) IN ('MATRIZ', 'PARTIDA') AND NULLIF(RTRIM(@mSubCuenta), '') IS NULL
              SELECT @Ok = 20730, @OkRef = @Material

            IF @Ok IS NULL
            BEGIN
              SELECT @mCantidadVeces = (@mCantidad*@mFactor) * @Veces
              IF @CfgMermaIncluida       = 0 AND @mMerma       <> 0.0
              BEGIN 
                IF @CfgTipoMerma = '#' 
                  SELECT @mCantidadVeces = @mCantidadVeces + @mMerma
                ELSE
                  SELECT @mCantidadVeces = @mCantidadVeces * (1+(@mMerma/100))
              END
              IF @CfgDesperdicioIncluido = 0 AND @mDesperdicio <> 0.0 
              BEGIN
                IF @CfgTipoMerma = '#' 
                  SELECT @mCantidadVeces = @mCantidadVeces + @mDesperdicio
                ELSE
                  SELECT @mCantidadVeces = @mCantidadVeces * (1+(@mDesperdicio/100))
              END

              IF @mCantidadVeces <> 0.0 AND @Ok IS NULL 
              BEGIN
                IF @mArtEsFormula = 1
	          EXEC spPlanArtExplotar @Empresa, @mAlmacen, @Vuelta, @ProductoPeriodo, @MaterialPeriodo, @Material, @mSubCuenta, @mCantidadVeces, @mArtCantidad, @mUnidad, @Acronimo,
		                         @CfgMermaIncluida, @CfgDesperdicioIncluido, @CfgTipoMerma, @CfgMultiUnidades, @CfgMultiUnidadesNivel,
   		                         @Ok OUTPUT, @OkRef OUTPUT
                ELSE 
                BEGIN
                  UPDATE PlanArt 
                     SET Cantidad = ISNULL(Cantidad, 0) + @mCantidadVeces
                   WHERE Empresa = @Empresa AND Almacen = @mAlmacen AND Articulo = @Material AND SubCuenta = ISNULL(@mSubCuenta, '') AND Acronimo = 'RB' AND Periodo = @MaterialPeriodo
                  IF @@ROWCOUNT = 0
                  BEGIN
                    INSERT PlanArt (Empresa,  Almacen,   Articulo,  SubCuenta,                Acronimo, Cantidad,        Periodo)
                            VALUES (@Empresa, @mAlmacen, @Material, ISNULL(@mSubCuenta, ''), 'RB',      @mCantidadVeces, @MaterialPeriodo)
                  END

                  IF NOT EXISTS(SELECT * FROM #PlanCorrida WHERE Articulo = @Material AND SubCuenta = ISNULL(@mSubCuenta, '') AND Almacen = @mAlmacen AND DRP = 0 AND Vuelta = @Vuelta + 1)
                    INSERT #PlanCorrida (Articulo, SubCuenta, Almacen, DRP, Vuelta) VALUES (@Material, ISNULL(@mSubCuenta, ''), @mAlmacen, 0, @Vuelta + 1)
                  
                  UPDATE PlanArtFlujo
                     SET MaterialCantidad = ISNULL(MaterialCantidad, 0) + @mCantidadVeces,
                         ProductoCantidad = ISNULL(ProductoCantidad, 0) + @Cantidad
                   WHERE Empresa = @Empresa AND Material = @Material AND MaterialPeriodo = @MaterialPeriodo AND MaterialSubCuenta = ISNULL(@mSubCuenta, '') AND MaterialAlmacen = @mAlmacen AND MaterialAcronimo = 'RB' AND Producto = @Articulo AND ProductoPeriodo = @ProductoPeriodo AND ProductoSubCuenta = ISNULL(@SubCuenta, '') AND ProductoAlmacen = @Almacen AND ProductoAcronimo = @Acronimo
                  IF @@ROWCOUNT = 0
                    INSERT PlanArtFlujo (Empresa,  Material,  MaterialPeriodo,  MaterialSubCuenta,       MaterialAlmacen, MaterialAcronimo, Producto,  ProductoPeriodo,  ProductoSubCuenta,      ProductoAlmacen, ProductoAcronimo, MaterialCantidad, ProductoCantidad)
                                 VALUES (@Empresa, @Material, @MaterialPeriodo, ISNULL(@mSubCuenta, ''), @mAlmacen,      'RB',             @Articulo, @ProductoPeriodo, ISNULL(@SubCuenta, ''), @Almacen,        @Acronimo,        @mCantidadVeces,  @Cantidad)

                END
              END
            END
          END
        END
      END
      FETCH NEXT FROM crArtMaterial INTO @SiOpcion, @Material, @mSubCuenta, @mCantidad, @mUnidad, @mMerma, @mDesperdicio, @mArtEsFormula, @mArtCantidad, @mAlmacen, @mArtTipo, @mArtTipoOpcion
    END
    CLOSE crArtMaterial
    DEALLOCATE crArtMaterial
  END
  RETURN
END
GO



/**************** spPlanArtExcepcion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtExcepcion') and type = 'P') drop procedure dbo.spPlanArtExcepcion
GO
CREATE PROCEDURE spPlanArtExcepcion
			@EsDistribucion		bit,
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@Almacen		char(10),
               		@ProdRuta		char(20)	OUTPUT,
    	       		@LoteOrdenar		varchar(30)	OUTPUT,
       	       		@CantidadOrdenar	float		OUTPUT,
      	       		@MultiplosOrdenar   	float		OUTPUT,
       	       		@CantidadOrdenarTiempo	float		OUTPUT,
               		@TiempoEntrega	    	int		OUTPUT,
    	       		@TiempoEntregaUnidad	varchar(10)	OUTPUT,
               		@TiempoEntregaSeg    	int		OUTPUT,
    	       		@TiempoEntregaSegUnidad varchar(10)	OUTPUT,
    	       		@InvSeguridad	    	float		OUTPUT,
               		@AlmacenROP	    	char(10)	OUTPUT,
               		@RutaDistribucion    	varchar(50)	OUTPUT,
	        	@Proveedor 		char(10)	OUTPUT,

   		   	@Ok             	int          	OUTPUT,
    		   	@OkRef          	varchar(255) 	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @AlmacenOk			bit,
    @SubCuentaOk		bit,
    @SiOpcion			varchar(100),
    @SiAlmacen			char(10),
    @ExTiempoEntrega		int,
    @ExTiempoEntregaUnidad	varchar(10),
    @ExTiempoEntregaSeg		int,
    @ExTiempoEntregaSegUnidad	varchar(10),
    @ExInvSeguridad		float,
    @ExLoteOrdenar		varchar(30),
    @ExCantidadOrdenar		float,
    @ExMultiplosOrdenar		float,
    @ExCantidadOrdenarTiempo	float,
    @ExProdRuta			char(20),
    @ExAlmacenROP		char(10),
    @ExRutaDistribucion		varchar(50),
    @ExProveedor		char(10)

  DECLARE crEx CURSOR FOR 
   SELECT NULLIF(RTRIM(SiOpcion), ''), NULLIF(RTRIM(SiAlmacen), ''), NULLIF(TiempoEntrega, 0), NULLIF(RTRIM(TiempoEntregaUnidad), ''), NULLIF(TiempoEntregaSeg, 0), NULLIF(RTRIM(TiempoEntregaSegUnidad), ''), NULLIF(InvSeguridad, 0), NULLIF(RTRIM(LoteOrdenar), ''), NULLIF(CantidadOrdenar, 0), NULLIF(MultiplosOrdenar, 0), NULLIF(CantidadOrdenarTiempo, 0), NULLIF(RTRIM(ProdRuta), ''), NULLIF(RTRIM(AlmacenROP) ,''), NULLIF(RTRIM(RutaDistribucion), ''), NULLIF(RTRIM(Proveedor), '')
     FROM ArtPlanEx
    WHERE Articulo = @Articulo

  OPEN crEx
  FETCH NEXT FROM crEx INTO @SiOpcion, @SiAlmacen, @ExTiempoEntrega, @ExTiempoEntregaUnidad, @ExTiempoEntregaSeg, @ExTiempoEntregaSegUnidad, @ExInvSeguridad, @ExLoteOrdenar, @ExCantidadOrdenar, @ExMultiplosOrdenar, @ExCantidadOrdenarTiempo, @ExProdRuta, @ExAlmacenROP, @ExRutaDistribucion, @ExProveedor
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN   
      SELECT @SubCuentaOk = 1, @AlmacenOk = 1 
      IF @SiAlmacen IS NOT NULL
        IF @Almacen <> @SiAlmacen SELECT @AlmacenOk = 0

      IF @SubCuenta IS NOT NULL AND @SiOpcion IS NOT NULL
        EXEC spOpcionContinuar @SiOpcion, @SubCuenta, @SubCuentaOk OUTPUT, @Ok OUTPUT, @OkRef OUTPUT     

      IF @SubCuentaOk = 1 AND @AlmacenOk = 1
      BEGIN
        IF @EsDistribucion = 1 OR @ExTiempoEntrega           IS NOT NULL SELECT @TiempoEntrega 	        = @ExTiempoEntrega
    	IF @EsDistribucion = 1 OR @ExTiempoEntregaUnidad     IS NOT NULL SELECT @TiempoEntregaUnidad    = @ExTiempoEntregaUnidad
        IF @EsDistribucion = 1 OR @ExTiempoEntregaSeg 	     IS NOT NULL SELECT @TiempoEntregaSeg 	= @ExTiempoEntregaSeg
    	IF @EsDistribucion = 1 OR @ExTiempoEntregaSegUnidad  IS NOT NULL SELECT @TiempoEntregaSegUnidad = @ExTiempoEntregaSegUnidad
    	IF @EsDistribucion = 1 OR @ExInvSeguridad	     IS NOT NULL SELECT @InvSeguridad	  	= @ExInvSeguridad
    	IF @EsDistribucion = 1 OR @ExLoteOrdenar   	     IS NOT NULL SELECT @LoteOrdenar	  	= @ExLoteOrdenar
    	IF @EsDistribucion = 1 OR @ExCantidadOrdenar	     IS NOT NULL SELECT @CantidadOrdenar	= @ExCantidadOrdenar
    	IF @EsDistribucion = 1 OR @ExMultiplosOrdenar	     IS NOT NULL SELECT @MultiplosOrdenar	= @ExMultiplosOrdenar
    	IF @EsDistribucion = 1 OR @ExCantidadOrdenarTiempo   IS NOT NULL SELECT @CantidadOrdenarTiempo	= @ExCantidadOrdenarTiempo
    	IF @ExProdRuta	       IS NOT NULL SELECT @ProdRuta		= @ExProdRuta
    	IF @ExAlmacenROP       IS NOT NULL SELECT @AlmacenROP		= @ExAlmacenROP, @RutaDistribucion = NULL
    	IF @ExRutaDistribucion IS NOT NULL SELECT @RutaDistribucion	= @ExRutaDistribucion
    	IF @ExProveedor	       IS NOT NULL SELECT @Proveedor		= @ExProveedor
      END
    END
    FETCH NEXT FROM crEx INTO @SiOpcion, @SiAlmacen, @ExTiempoEntrega, @ExTiempoEntregaUnidad, @ExTiempoEntregaSeg, @ExTiempoEntregaSegUnidad, @ExInvSeguridad, @ExLoteOrdenar, @ExCantidadOrdenar, @ExMultiplosOrdenar, @ExCantidadOrdenarTiempo, @ExProdRuta, @ExAlmacenROP, @ExRutaDistribucion, @ExProveedor
  END
  CLOSE crEx
  DEALLOCATE crEx

  RETURN
END
GO
-- spPlanArt 'DEMO', 'C920'

/**************** spPlanArtLeyenda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtLeyenda') and type = 'P') drop procedure dbo.spPlanArtLeyenda
GO
CREATE PROCEDURE spPlanArtLeyenda
			@Empresa	    	char(5),
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@Almacen		char(10),
    			@CantidadOrdenar	float,
    			@MultiplosOrdenar	float,
    			@CantidadOrdenarTiempo	float,
    			@InvSeguridad		float,
    			@TiempoEntrega		int,
    			@TiempoEntregaUnidad 	varchar(10),
    			@TiempoEntregaSeg	int,
    			@TiempoEntregaSegUnidad varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Leyenda	varchar(100),
    @TEU	char(1),
    @TESU	char(1)

  SELECT @Leyenda = ''

  SELECT @TEU = '', @TESU = ''
  IF UPPER(@TiempoEntregaUnidad) = 'DIAS'    SELECT @TEU = 'd' ELSE
  IF UPPER(@TiempoEntregaUnidad) = 'SEMANAS' SELECT @TEU = 's' ELSE
  IF UPPER(@TiempoEntregaUnidad) = 'MESES'   SELECT @TEU = 'm'

  IF UPPER(@TiempoEntregaSegUnidad) = 'DIAS'    SELECT @TESU = 'd' ELSE
  IF UPPER(@TiempoEntregaSegUnidad) = 'SEMANAS' SELECT @TESU = 's' ELSE
  IF UPPER(@TiempoEntregaSegUnidad) = 'MESES'   SELECT @TESU = 'm'

  IF @CantidadOrdenarTiempo > 0
  BEGIN
    SELECT @Leyenda = @Leyenda + 'TL='+LTRIM(CONVERT(char, @CantidadOrdenarTiempo))
    IF @CantidadOrdenar > 0
      SELECT @Leyenda = @Leyenda + ' LM='+LTRIM(CONVERT(char, @CantidadOrdenar))
  END ELSE
  BEGIN
    IF @CantidadOrdenar > 0
      SELECT @Leyenda = @Leyenda + 'TL='+LTRIM(CONVERT(char, @CantidadOrdenar))
  END
  IF @MultiplosOrdenar > 1 
     SELECT @Leyenda = @Leyenda + ' M='+LTRIM(CONVERT(char, @MultiplosOrdenar))
  IF @InvSeguridad > 0
    SELECT @Leyenda = @Leyenda + ' IS='+LTRIM(CONVERT(char, @InvSeguridad))
  IF @TiempoEntrega > 0
    SELECT @Leyenda = @Leyenda + ' TE='+LTRIM(CONVERT(char, @TiempoEntrega))+RTRIM(@TEU)
  IF @TiempoEntregaSeg > 0
    SELECT @Leyenda = @Leyenda + ' TES='+LTRIM(CONVERT(char, @TiempoEntregaSeg))+RTRIM(@TESU)

  UPDATE PlanArtLeyenda
     SET Leyenda = @Leyenda
   WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen
  IF @@ROWCOUNT = 0
    INSERT PlanArtLeyenda (Empresa, Articulo, SubCuenta, Almacen, Leyenda) VALUES (@Empresa, @Articulo, @SubCuenta, @Almacen, @Leyenda)
  RETURN
END
GO

/**************** spPlanArtOPLiberacionBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPLiberacionBorrar') and type = 'P') drop procedure dbo.spPlanArtOPLiberacionBorrar
GO
CREATE PROCEDURE spPlanArtOPLiberacionBorrar
			@Empresa	     char(5),
			@Modulo		     char(5),
    			@Articulo	     char(20)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Articulo IS NULL
  BEGIN
    IF @Modulo = 'INV'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Inv m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
    IF @Modulo = 'PROD'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Prod m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
    IF @Modulo = 'COMS'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Compra m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
  END ELSE 
  BEGIN
    IF @Modulo = 'INV'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND Articulo = @Articulo AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Inv m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
    IF @Modulo = 'PROD'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND Articulo = @Articulo AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Prod m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
    IF @Modulo = 'COMS'
      UPDATE PlanArtOP 
         SET LiberacionModulo = NULL, LiberacionID = NULL, LiberacionMov = NULL, LiberacionMovID = NULL
       WHERE Empresa = @Empresa AND Articulo = @Articulo AND LiberacionModulo = @Modulo AND LiberacionID IN (SELECT p.LiberacionID FROM PlanArtOP p LEFT OUTER JOIN Compra m ON m.ID = p.LiberacionID WHERE p.Empresa = @Empresa AND p.Estado = 'Liberado' AND p.LiberacionModulo = @Modulo AND p.LiberacionID IS NOT NULL GROUP BY p.LiberacionID, m.ID HAVING m.ID IS NULL)
  END
END
GO

/**************** spPlanArtBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtBorrar') and type = 'P') drop procedure dbo.spPlanArtBorrar
GO
CREATE PROCEDURE spPlanArtBorrar
			@Empresa	     char(5),
    			@Articulo	     char(20) 	 = NULL,

			@OperacionRemota     varchar(255)= NULL	

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @q 	varchar(255)
  SELECT @Articulo = NULLIF(RTRIM(@Articulo), '')

  IF @Articulo IS NULL
  BEGIN
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'INV'
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'COMS'
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'PROD'
    DELETE PlanArt        WHERE Empresa = @Empresa 
    DELETE PlanArtFlujo   WHERE Empresa = @Empresa 
    DELETE PlanArtLeyenda WHERE Empresa = @Empresa 
    DELETE PlanArtOP      WHERE Empresa = @Empresa /*AND UPPER(Estado) = 'PLAN'*/ AND LiberacionModulo IS NULL AND LiberacionID IS NULL
  END ELSE 
  BEGIN
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'INV', @Articulo
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'COMS', @Articulo
    EXEC spPlanArtOPLiberacionBorrar @Empresa, 'PROD', @Articulo
    DELETE PlanArt        WHERE Empresa = @Empresa AND Articulo = @Articulo AND Acronimo <> 'RB'  -- No se pone el RD porque es otro metodo para calcularlo
    DELETE PlanArtFlujo   WHERE Empresa = @Empresa AND Material = @Articulo AND MaterialAcronimo <> 'RB'
    DELETE PlanArtLeyenda WHERE Empresa = @Empresa AND Articulo = @Articulo
  END

  IF @OperacionRemota IS NOT NULL
  BEGIN
    SELECT @q = RTRIM(@OperacionRemota)+'spPlanArtBorrar "'+
                RTRIM(@Empresa)+'", "'+ISNULL(RTRIM(@Articulo), '')+'"'
    EXEC(@q)
  END
END
GO

/**************** spPlanArtOPEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPEliminar') and type = 'P') drop procedure dbo.spPlanArtOPEliminar
GO
CREATE PROCEDURE spPlanArtOPEliminar
			@Empresa	     char(5),
			@Almacen	     char(10),
			@Articulo	     char(20),
			@SubCuenta	     varchar(50),

			@OperacionRemota     varchar(255)= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @q 	varchar(255)

  SELECT @Articulo = ISNULL(RTRIM(@Articulo), ''),
         @SubCuenta = ISNULL(RTRIM(@SubCuenta), '')

  DELETE PlanArtOP
   WHERE Empresa = @Empresa AND Almacen = @Almacen AND AlmacenDestino = NULL AND Articulo = @Articulo AND SubCuenta = @SubCuenta
     /*AND UPPER(Estado) = 'PLAN' */AND LiberacionModulo IS NULL AND LiberacionID IS NULL

  IF @OperacionRemota IS NOT NULL
  BEGIN
    SELECT @q = RTRIM(@OperacionRemota)+'spPlanArtOPEliminar "'+
                RTRIM(@Empresa)+'", "'+RTRIM(@Almacen)+'", "'+ISNULL(RTRIM(@Articulo), '')+'", "'+ISNULL(RTRIM(@SubCuenta), '')+'"'
    EXEC(@q)
  END
END
GO

/**************** spPlanArtOPActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArtOPActualizar') and type = 'P') drop procedure dbo.spPlanArtOPActualizar
GO
CREATE PROCEDURE spPlanArtOPActualizar
			@Sucursal		int, 
			@Empresa		char(5), 
			@AlmacenOrigen		char(10), 
			@AlmacenDestino		char(10), 
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@FechaLiberacion	datetime,  
			@FechaEntrega		datetime,   
			@Cantidad		float,
			@Ruta			varchar(20),
			@Unidad			varchar(50),     
			@Proveedor		char(10),  
			@Accion			varchar(20),  
			@Estado			varchar(20),

			@OperacionRemota   	varchar(255)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @q 	varchar(255)

  SELECT @AlmacenOrigen = NULLIF(RTRIM(@AlmacenOrigen), ''),
         @AlmacenDestino = NULLIF(RTRIM(@AlmacenDestino), ''),
         @Ruta = NULLIF(RTRIM(@Ruta), ''),
         @Proveedor = NULLIF(RTRIM(@Proveedor), '')

  UPDATE PlanArtOP
     SET Cantidad         = ISNULL(Cantidad, 0) + @Cantidad,
         CantidadOriginal = ISNULL(CantidadOriginal, 0) + @Cantidad
   WHERE Empresa = @Empresa AND Almacen = @AlmacenOrigen AND Sucursal = @Sucursal AND AlmacenDestino = @AlmacenDestino AND Articulo = @Articulo AND SubCuenta = @SubCuenta
     AND FechaLiberacionOriginal = @FechaLiberacion AND FechaLiberacion = @FechaLiberacion AND FechaEntregaOriginal = @FechaEntrega AND FechaEntrega = @FechaEntrega
     AND RutaOriginal = @Ruta AND Ruta = @Ruta AND Unidad = @Unidad AND Proveedor = @Proveedor AND Accion = @Accion AND UPPER(Estado) = UPPER(@Estado)

  IF @@ROWCOUNT = 0
    INSERT PlanArtOP (Sucursal,  Empresa,  Almacen,        AlmacenDestino,  Articulo,  SubCuenta,  FechaLiberacionOriginal, FechaLiberacion,  FechaEntregaOriginal,  FechaEntrega,   CantidadOriginal,  Cantidad,  RutaOriginal,  Ruta,  Unidad,  Proveedor,  Accion,  Estado)
              VALUES (@Sucursal, @Empresa, @AlmacenOrigen, @AlmacenDestino, @Articulo, @SubCuenta, @FechaLiberacion, 	    @FechaLiberacion, @FechaEntrega,         @FechaEntrega,  @Cantidad,         @Cantidad, @Ruta,         @Ruta, @Unidad, @Proveedor, @Accion, @Estado)

  IF @OperacionRemota IS NOT NULL
  BEGIN
    SELECT @q = RTRIM(@OperacionRemota)+'spPlanArtOPActualizar '+
                LTRIM(CONVERT(char, @Sucursal))+', "'+RTRIM(@Empresa)+'", "'+ISNULL(RTRIM(@AlmacenOrigen), '')+'", "'+ISNULL(RTRIM(@AlmacenDestino), '')+'", "'+
                ISNULL(RTRIM(@Articulo), '')+'", "'+ISNULL(RTRIM(@SubCuenta), '')+'", "'+
                RTRIM(CONVERT(char, @FechaLiberacion, 100))+'", "'+RTRIM(CONVERT(char, @FechaEntrega, 100))+'", '+
                LTRIM(CONVERT(char, @Cantidad))+', "'+ISNULL(RTRIM(@Ruta), '')+'", "'+ISNULL(RTRIM(@Unidad), '')+'", "'+ISNULL(RTRIM(@Proveedor), '')+'", "'+RTRIM(@Accion)+'", "'+RTRIM(@Estado)+'"'
    EXEC(@q)
  END
END
GO

/**************** spPlanBitacoraFin ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanBitacoraFin') and type = 'P') drop procedure dbo.spPlanBitacoraFin
GO
CREATE PROCEDURE spPlanBitacoraFin
			@ID			int,
			@Estatus		char(15),
			@Mensaje		varchar(255),
			@Empresa		char(5), 
			@Categoria		varchar(50), 
			@Grupo			varchar(50), 
			@Familia		varchar(50), 
			@Fabricante		varchar(50), 
			@Linea			varchar(50), 
			@Temporada		varchar(50), 
			@Proveedor		varchar(10), 
			@FechaInicio		datetime,

			@OperacionRemota   	varchar(255)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @q 	varchar(1000)

  IF @ID IS NULL
    INSERT PlanBitacora (Empresa,  Categoria,  Grupo,  Familia,  Fabricante,  Linea,  Temporada,  Proveedor,  Estatus,  FechaInicio,  FechaFin,  Mensaje)
                 VALUES (@Empresa, @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @Proveedor, @Estatus, @FechaInicio, GETDATE(), @Mensaje)
  ELSE
    UPDATE PlanBitacora 
       SET Estatus = @Estatus, FechaFin = GETDATE(), Mensaje = @Mensaje 
     WHERE ID = @ID

  EXEC xpPlanBitacoraFin @ID

  IF @OperacionRemota IS NOT NULL
  BEGIN
    SELECT @q = RTRIM(@OperacionRemota)+'spPlanBitacoraFin NULL, "'+RTRIM(@Estatus)+'", "'+ISNULL(RTRIM(@Mensaje), '')+'", "'+ISNULL(RTRIM(@Empresa), '')+'", "'+ISNULL(RTRIM(@Categoria), '')+'", "'+
                ISNULL(RTRIM(@Grupo), '')+'", "'+ISNULL(RTRIM(@Familia), '')+'", "'+ISNULL(RTRIM(@Fabricante), '')+'", "'+ISNULL(RTRIM(@Linea), '')+'", "'+ISNULL(RTRIM(@Temporada), '')+'", "'+ISNULL(RTRIM(@Proveedor), '')+'", "'+
                RTRIM(CONVERT(char, @FechaInicio, 100))+'"' 
    EXEC(@q)
  END
  
END
GO

/**************** spPlanMensaje ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanMensaje') and type = 'P') drop procedure dbo.spPlanMensaje
GO
CREATE PROCEDURE spPlanMensaje
			@ID			int,
			@Mensaje		varchar(255),
			@OperacionRemota   	varchar(255)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @q 	varchar(1000)

  IF @ID IS NOT NULL
  BEGIN
    INSERT PlanMensaje (BitacoraID, Mensaje) VALUES (@ID, @Mensaje)

    IF @OperacionRemota IS NOT NULL
    BEGIN
      SELECT @q = RTRIM(@OperacionRemota)+'spPlanMensaje '+CONVERT(varchar, @ID)+', "'+ISNULL(RTRIM(@Mensaje), '')+'"'
      EXEC(@q)
    END
  END
END
GO


/**************** spVerPlanArtConteo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPlanArtConteo') and type = 'P') drop procedure dbo.spVerPlanArtConteo
GO
CREATE PROCEDURE spVerPlanArtConteo
			@Categoria	    	varchar(50),
			@Grupo		    	varchar(50),
			@Familia	    	varchar(50),
			@Fabricante	    	varchar(50),
			@Linea		    	varchar(50),
			@Temporada	    	varchar(50),
			@ProveedorEspecifico 	char(10),
                        @Referencia		varchar(50),
                        @ReferenciaModulo	varchar(5),
			@ReferenciaActividad	varchar(50)

--//WITH ENCRYPTION
AS BEGIN 
    DECLARE	@CantidadProyecto	int
  
    SELECT @Categoria	        = NULLIF(NULLIF(RTRIM(@Categoria), '(Todos)'), ''),
	   @Grupo		= NULLIF(NULLIF(RTRIM(@Grupo), '(Todos)'), ''),
   	   @Familia	        = NULLIF(NULLIF(RTRIM(@Familia), '(Todos)'), ''),
 	   @Fabricante	        = NULLIF(NULLIF(RTRIM(@Fabricante), '(Todos)'), ''),
	   @Linea		= NULLIF(NULLIF(RTRIM(@Linea), '(Todos)'), ''),
	   @Temporada	        = NULLIF(NULLIF(RTRIM(@Temporada), '(Todos)'), ''),
	   @ProveedorEspecifico = NULLIF(NULLIF(RTRIM(@ProveedorEspecifico), '(TODOS)'), ''),
	   @Referencia	        = NULLIF(NULLIF(NULLIF(RTRIM(@Referencia), '(Todos)'), ''), '0'),
	   @ReferenciaModulo    = NULLIF(NULLIF(NULLIF(RTRIM(@ReferenciaModulo), '(Todos)'), ''), '0'),
	   @ReferenciaActividad = NULLIF(NULLIF(NULLIF(RTRIM(@ReferenciaActividad), '(Todos)'), ''), '0')

  IF @Referencia IS NOT NULL
  BEGIN
    IF @ReferenciaModulo = 'VTAS'
      SELECT COUNT(*) FROM VentaD d, Venta e WHERE d.ID = e.ID AND RTRIM(e.Mov)+' '+RTRIM(e.MovID) = @Referencia AND Estatus = 'PENDIENTE'
    ELSE
    IF @ReferenciaModulo = 'INV'
      SELECT COUNT(*) FROM InvD d, Inv e WHERE d.ID = e.ID AND RTRIM(e.Mov)+' '+RTRIM(e.MovID) = @Referencia AND Estatus = 'PENDIENTE'
    ELSE
    IF @ReferenciaModulo = 'PROY' --arcc
    BEGIN
      SELECT @CantidadProyecto = COUNT(*) FROM InvD d, Inv e WHERE d.ID = e.ID AND e.Proyecto = @Referencia AND ISNULL(e.Actividad,'') = ISNULL(@ReferenciaActividad,ISNULL(e.Actividad,'')) AND Estatus = 'PENDIENTE'
      SELECT @CantidadProyecto = @CantidadProyecto + COUNT(*) FROM VentaD d, Venta e WHERE d.ID = e.ID AND e.Proyecto = @Referencia AND Estatus = 'PENDIENTE'
      SELECT @CantidadProyecto
    END
  END ELSE
    SELECT COUNT(*) 
      FROM Art a
     WHERE ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')
  RETURN
END
GO

/**************** spPlanCoberturaEnMeses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCoberturaEnMeses') and type = 'P') drop procedure dbo.spPlanCoberturaEnMeses
GO
CREATE PROCEDURE spPlanCoberturaEnMeses
			@Empresa	     	char(5),
			@Almacen		char(10), 
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@Periodo		int,
			@InvFinal		float,
			@CoberturaEnMeses	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN   
  DECLARE
    @Presupuesto	float
  SELECT @CoberturaEnMeses = 0, @Presupuesto = 0.0 -- para que entre al while
  IF ISNULL(@InvFinal, 0.0) < 0.0 RETURN
  WHILE (ISNULL(@InvFinal, 0.0) > 0 OR @Presupuesto = 0.0) AND @Periodo <= 12
  BEGIN
    SELECT @Periodo = @Periodo + 1
    SELECT @Presupuesto = 0.0
    SELECT @Presupuesto = ISNULL(SUM(Cantidad), 0.0)
      FROM PlanArt
     WHERE Empresa = @Empresa AND Acronimo = 'DT' 
       AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
       AND Almacen = @Almacen AND Periodo = @Periodo

    IF ISNULL(@Presupuesto, 0.0) > 0.0
    BEGIN
      IF @Presupuesto <= @InvFinal 
        SELECT @CoberturaEnMeses = @CoberturaEnMeses + 1.0, 
               @InvFinal = @InvFinal - @Presupuesto
      ELSE 
         SELECT @CoberturaEnMeses = @CoberturaEnMeses + (@InvFinal / @Presupuesto), 
               @InvFinal = 0.0
    END ELSE
     SELECT @CoberturaEnMeses = @CoberturaEnMeses + 1.0 

  END
  RETURN
END
GO


/**************** spPlanCantidadOrdenarEnMeses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanCantidadOrdenarEnMeses') and type = 'P') drop procedure dbo.spPlanCantidadOrdenarEnMeses
GO
CREATE PROCEDURE spPlanCantidadOrdenarEnMeses
			@Empresa	     	char(5),
			@Almacen		char(10), 
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@Periodo		int,
			@InvFinal		float,
			@TamanoLoteEnMeses	float,
			@RN			float OUTPUT
--//WITH ENCRYPTION
AS BEGIN   
  DECLARE
    @Presupuesto	float,
    @LotePendiente	float,
    @Fraccion		float

--  IF @InvFinal < 0.0 SELECT @InvFinal = 0.0
  IF @InvFinal = 0.0 AND @Periodo = 0 SELECT @Periodo = @Periodo - 1
-- IF @InvFinal <= 0.0 AND @Periodo = 0 SELECT @Periodo = @Periodo - 1, @InvFinal = 0.0

  SELECT @RN = 0.0, @LotePendiente = @TamanoLoteEnMeses, @Presupuesto = 0.0 -- para que entre al while
  WHILE @LotePendiente > 0.0 AND @Periodo <= 12
  BEGIN
    SELECT @Periodo = @Periodo + 1
    SELECT @Presupuesto = 0.0
    SELECT @Presupuesto = ISNULL(SUM(Cantidad), 0.0)
      FROM PlanArt
     WHERE Empresa = @Empresa AND Acronimo = 'DT' 
       AND Articulo = @Articulo AND SubCuenta = @SubCuenta 
       AND Almacen = @Almacen AND Periodo = @Periodo

--    IF ISNULL(@Presupuesto, 0.0) = 0.0 SELECT @Presupuesto = 1.0
    IF ISNULL(@Presupuesto, 0.0) > 0.0
    BEGIN
      IF @Presupuesto <= @InvFinal 
        SELECT @InvFinal = @InvFinal - @Presupuesto
      ELSE BEGIN
        SELECT @Fraccion = 1.0-ISNULL(@InvFinal / NULLIF(@Presupuesto, 0.0), 0.0),
               @InvFinal = 0.0
        IF @InvFinal = 0.0
        BEGIN
          IF @Fraccion > @LotePendiente SELECT @Fraccion = @LotePendiente
          SELECT @RN = @RN + (@Presupuesto * @Fraccion),
                 @LotePendiente = @LotePendiente - @Fraccion
        END
      END
    END ELSE
     SELECT @LotePendiente = @LotePendiente - 1.0
  END
  SELECT @RN = ROUND(@RN, 0)

  RETURN
END
GO
-- select RecibirFormaHTML from empresagral
-- spPlanArt 'DEMO', 'PLAN01', @Debug = 1

/**************** spPlanArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPlanArt') and type = 'P') drop procedure dbo.spPlanArt
GO
CREATE PROCEDURE spPlanArt
			@Empresa	     	char(5),
    			@ArticuloEspecifico  	char(20)    = NULL,
			@Hoy		     	datetime    = NULL,
			@Debug		     	bit 	    = 0,
			@Categoria	     	varchar(50) = NULL,
			@Grupo		     	varchar(50) = NULL,
			@Familia	     	varchar(50) = NULL,
			@Fabricante	     	varchar(50) = NULL,
			@Linea		     	varchar(50) = NULL,
			@Temporada	     	varchar(50) = NULL,
			@ProveedorEspecifico 	char(10)    = NULL,
			@Referencia		varchar(50) = NULL,	
			@ReferenciaModulo	varchar(5)  = NULL,	
			@OperacionServidor   	varchar(100)= NULL,
			@OperacionBase	     	varchar(100)= NULL,	
			@OperacionLigarServidor bit	    = 1,
			@ReferenciaActividad	varchar(50) = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgProd			bit,
    @TipoPeriodo		varchar(20),
    @CalcATP			bit,
    @AbortarPrimerError		bit,
    @Periodos			int,
    @BitacoraID			int,
    @BitacoraEstatus		char(15),
    @Sucursal			int,
    @p				int,
    @a				int,
    @f				float,
    @Ult_ATP			int,
    @DA				money,
    @DT				money,
    @RP				money,
    @ATP			money,
    @EP				money,
    @IS				money,
    @RN				money,
    @ROPF			money,
    @REPF			money,
    @ROP			float,
    @RO				char(10),
    @LO				char(10),
    @Almacen			char(10),
    @AlmacenDestino		char(10),
    @AlmacenOrigen		char(10),
    @Articulo			char(20),
    @SubCuenta			varchar(50),
    @SeVende			bit,
    @SeProduce			bit,
    @SeCompra			bit,
    @Ruta			varchar(20),
    @ArtCantidad		float,
    @ArtUnidad			varchar(50),
    @LoteOrdenar		varchar(30),
    @InvSeguridad		float,
    @CantidadOrdenar		float,
    @MultiplosOrdenar		float,
    @CantidadOrdenarTiempo	float,
    @TiempoEntrega		int,
    @TiempoEntregaUnidad 	varchar(10),
    @TiempoEntregaSeg		int,
    @TiempoEntregaSegUnidad 	varchar(10),
    @FechaEntrega		datetime,
    @FechaEntregaLOP		datetime,
    @FechaLiberacion		datetime,
    @FechaCongelada		datetime,
    @PeriodoROP			int,
    @PeriodoLOP			int,
    @PeriodoLOPF		int,
    @PeriodoLODF		int,
    @PeriodoInicialDemanda	int,
    @PeriodoCongelado		int,
    @Vuelta			int,
    @Ok				int,
    @OkRef			varchar(255),
    @Dias			int,
    @PrimerDia			datetime,
    @CfgPlanSinDemanda		 bit,
    @CfgPlanIgnorarDemanda	 bit,
    @CfgPlanIgnorarZonaCongelada bit,
    @CfgPlanISDemanda		 bit,
    @CfgMermaIncluida		 bit,
    @CfgDesperdicioIncluido	 bit,
    @CfgTipoMerma		 char(1),
    @CfgMultiUnidades		 bit,
    @CfgMultiUnidadesNivel 	 char(20),
    @CfgPlanHist		 bit,
    @CfgPlanBasePresupuesto	 bit,
    @Accion			 varchar(20),
    @Proveedor			 char(10),
    @AlmacenROP			 char(10),
    @AlmacenTipo		 char(15),
    @RutaDistribucion		 varchar(50),
    @EsDistribucion		 bit,
    @InsertoPlanArtSinDemanda	 bit,   
    @DRP			 int,
    @UltDRP			 int,
    @DRPDistribucion		 bit,
    @VueltaDistribucion		 int,
    @CfgRutaDistribucion         varchar(50),
    @CfgRutaDistribucionNivelArticulo bit,
    @CfgPlanTESeguridad		bit,
    @CfgDiasHabiles		varchar(20), 
    @CfgPlanRecorrerLiberacion	bit,
    @EstadoOmision		varchar(20),
    @CorridaOrden		varchar(50),
    @FechaInicio		datetime,
    @CfgPlanInicio		varchar(20), 
    @Mensaje			varchar(255),
    @OperacionRemota		varchar(255),
    @CoberturaEnMeses		float,
    @EP2			float,
    @RN2			float,
    @RD				char(10),
    @SODF			char(10)

SET NOCOUNT ON
/* Explicacion
 
  Cuando se maneja DRP y MRP es muy importante que primero se recalcule el DRP y despues el MRP
  para ello en la tabla #PlanCorrida se metio el campo DRP, lo que hace este cursor es mientras exista 
  algo que recalcular que sea DRP = 1, lo va a hacer y despues DRP = 0

  Las vueltas son importantes para el DRP ya que se va recalculando de donde hay demanda para arriba.

*/

  SELECT @OperacionRemota = NULL,
         @TipoPeriodo	  = 'SEMANA',
         @FechaInicio     = GETDATE()

  IF @OperacionBase IS NOT NULL
  BEGIN
    SELECT @OperacionRemota = '' 
    IF @OperacionServidor IS NOT NULL SELECT @OperacionRemota = RTRIM(@OperacionServidor) + '.'
    SELECT @OperacionRemota = @OperacionRemota + RTRIM(@OperacionBase)+'.dbo.'
  END
  
  IF @OperacionServidor IS NOT NULL AND @OperacionLigarServidor = 1 
    EXEC sp_addlinkedserver @OperacionServidor

  SELECT @Mensaje = NULL
  IF @ArticuloEspecifico IS NULL
  BEGIN
    INSERT PlanBitacora (Empresa, Categoria, Grupo, Familia, Fabricante, Linea, Temporada, Proveedor, Referencia, Estatus, FechaInicio)
                 VALUES (@Empresa, @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @ProveedorEspecifico, @Referencia, 'BORRADOR', @FechaInicio)
    SELECT @BitacoraID = SCOPE_IDENTITY()

    SELECT @Categoria	        = NULLIF(NULLIF(RTRIM(@Categoria), '(Todos)'), ''),
	   @Grupo		= NULLIF(NULLIF(RTRIM(@Grupo), '(Todos)'), ''),
   	   @Familia	        = NULLIF(NULLIF(RTRIM(@Familia), '(Todos)'), ''),
 	   @Fabricante	        = NULLIF(NULLIF(RTRIM(@Fabricante), '(Todos)'), ''),
	   @Linea		= NULLIF(NULLIF(RTRIM(@Linea), '(Todos)'), ''),
	   @Temporada	        = NULLIF(NULLIF(RTRIM(@Temporada), '(Todos)'), ''),
	   @ProveedorEspecifico = NULLIF(NULLIF(RTRIM(@ProveedorEspecifico), '(TODOS)'), ''), 
	   @Referencia	        = NULLIF(NULLIF(NULLIF(RTRIM(@Referencia), '(Todos)'), ''), '0'),
	   @ReferenciaModulo    = NULLIF(NULLIF(NULLIF(RTRIM(@ReferenciaModulo), '(Todos)'), ''), '0')
  END

  SELECT @CfgRutaDistribucionNivelArticulo = 0, @InsertoPlanArtSinDemanda = 0
  SELECT @Ok = NULL, @OkRef = NULL

  SELECT @CfgProd = Prod,
         @CfgDiasHabiles = DiasHabiles
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgMermaIncluida       = ProdMermaIncluida,
         @CfgDesperdicioIncluido = ProdDesperdicioIncluido,
         @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'),
         @CfgRutaDistribucion    = NULLIF(RTRIM(RutaDistribucion), ''),
         @CfgRutaDistribucionNivelArticulo = ISNULL(RutaDistribucionNivelArticulo, 0),
         @CfgPlanSinDemanda	 = PlanSinDemanda,
         @CfgPlanIgnorarDemanda  = ISNULL(PlanIgnorarDemandaDirecta, 0),
         @CfgPlanIgnorarZonaCongelada = ISNULL(PlanIgnorarZonaCongelada, 0),
         @CfgPlanISDemanda	 = PlanISDemanda,
         @CfgPlanTESeguridad     = PlanTESeguridad,
         @CfgTipoMerma		 = ISNULL(ProdTipoMerma, '%'),
         @Periodos	         = ISNULL(ProdPeriodosCorrida, 10),
         @CalcATP		 = ISNULL(PlanCalcATP, 1),
         @AbortarPrimerError     = ISNULL(PlanAbortarPrimerError, 1),
         @EstadoOmision		 = ISNULL(NULLIF(RTRIM(PlanEstadoOmision), ''), 'Plan'),
         @CorridaOrden		 = UPPER(NULLIF(RTRIM(PlanCorridaOrden), '')),
         @TipoPeriodo	 	 = UPPER(ISNULL(RTRIM(PlanTipoPeriodo), 'SEMANA')),
         @CfgPlanHist		 = PlanAutoGuardarHist,
         @CfgPlanBasePresupuesto = ISNULL(PlanBasePresupuesto, 0),
         @CfgPlanRecorrerLiberacion = ISNULL(PlanRecorrerLiberacion, 0),
         @CfgPlanInicio       = ISNULL(PlanInicio, 'HOY')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  IF @CfgProd = 1 SELECT /*| = 0, @CfgPlanISDemanda = 0, */@EstadoOmision = 'Plan'

  IF @ArticuloEspecifico IS NOT NULL SELECT @AbortarPrimerError = 1

  EXEC spPlanArtBorrar @Empresa, @ArticuloEspecifico, @OperacionRemota

  CREATE TABLE #PlanCorrida (
            	Articulo 	char(20) 	COLLATE Database_Default NOT NULL, 
		SubCuenta 	varchar(50) 	COLLATE Database_Default NOT NULL,
		Almacen		char(10)	COLLATE Database_Default NOT NULL,
		DRP		int		NOT NULL	DEFAULT 0,
		Vuelta		int		NOT NULL,

		EsDistribucion	bit		NOT NULL	DEFAULT 0,
	CONSTRAINT tempPlanCorrida PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, DRP, Vuelta))
/*
  CREATE TABLE #PlanCorrida2 (
            	Articulo 	char(20) 	COLLATE Database_Default NOT NULL, 
		SubCuenta 	varchar(50) 	COLLATE Database_Default NOT NULL,
		Almacen		char(10)	COLLATE Database_Default NOT NULL,
		DRP		int		NOT NULL	DEFAULT 0,
		Vuelta		int		NOT NULL,

		EsDistribucion	bit		NOT NULL	DEFAULT 0,
	CONSTRAINT tempPlanCorrida2 PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, DRP, Vuelta))
*/
  IF @Hoy IS NULL SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT

  IF @TipoPeriodo = 'DIA'
  BEGIN
    SELECT @PrimerDia = @Hoy
    EXEC spPlanArtDay @Empresa, @Periodos, @ArticuloEspecifico, @Hoy, @CfgPlanSinDemanda, @CfgPlanISDemanda, @CfgPlanIgnorarDemanda,
	  	      @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @ProveedorEspecifico, @Referencia, @ReferenciaModulo, @ReferenciaActividad
  END ELSE
  IF @TipoPeriodo = 'SEMANA'
  BEGIN
    SELECT @PrimerDia = DATEADD(day, -DATEPART(weekday, @Hoy)+1, @Hoy)
    IF @CfgPlanInicio = 'PRIMER DIA PERIODO' SELECT @Hoy = @PrimerDia
    EXEC spPlanArtWeek @Empresa, @Periodos, @ArticuloEspecifico, @Hoy, @CfgPlanSinDemanda, @CfgPlanISDemanda, @CfgPlanIgnorarDemanda,
	  	       @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @ProveedorEspecifico, @Referencia, @ReferenciaModulo, @ReferenciaActividad
  END ELSE
  IF @TipoPeriodo = 'MES'
  BEGIN
    SELECT @PrimerDia = DATEADD(day, -DATEPART(day, @Hoy)+1, @Hoy)
    IF @CfgPlanInicio = 'PRIMER DIA PERIODO' SELECT @Hoy = @PrimerDia
    EXEC spPlanArtMonth @Empresa, @Periodos, @ArticuloEspecifico, @Hoy, @CfgPlanSinDemanda, @CfgPlanISDemanda, @CfgPlanIgnorarDemanda,
	  	        @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @ProveedorEspecifico, @Referencia, @ReferenciaModulo, @ReferenciaActividad
  END

  INSERT #PlanCorrida (Articulo, SubCuenta, Almacen, Vuelta, DRP)
  SELECT p.Articulo, ISNULL(p.SubCuenta, ''), p.Almacen, 0, CASE WHEN a.AlmacenROP IN (p.Almacen, '(Demanda)') THEN 0 ELSE 1 END
    FROM PlanArt p, Art a
   WHERE p.Empresa = @Empresa AND p.Articulo = a.Articulo AND p.Articulo = ISNULL(@ArticuloEspecifico, p.Articulo)
   GROUP BY p.Articulo, ISNULL(p.SubCuenta, ''), p.Almacen, a.AlmacenROP
  
  --Bugs 2045 y 2049
  IF @ReferenciaModulo = 'VTAS' AND @Referencia IS NOT NULL
  BEGIN
    DELETE #PlanCorrida 
     WHERE Articulo NOT IN(
    SELECT d.Articulo
      FROM Venta v
      JOIN VentaD d ON v.ID = d.ID
     WHERE RTRIM(v.Mov) +' ' + RTRIM(v.MovID) = @Referencia)
      
  END
  IF @ReferenciaModulo = 'INV' AND @Referencia IS NOT NULL
  BEGIN
    DELETE #PlanCorrida 
     WHERE Articulo NOT IN(
    SELECT d.Articulo
      FROM Inv v
      JOIN InvD d ON v.ID = d.ID
     WHERE RTRIM(v.Mov) +' ' + RTRIM(v.MovID) = @Referencia)
  END
  IF @ReferenciaModulo = 'PROY' AND @Referencia IS NOT NULL
  BEGIN
    DELETE #PlanCorrida 
     WHERE Articulo NOT IN(
    SELECT d.Articulo
      FROM Venta v
      JOIN VentaD d ON v.ID = d.ID
     WHERE v.Proyecto = @Referencia)
  END


  -- Abastecimiento Directo
  UPDATE #PlanCorrida
     SET DRP = 0
    FROM #PlanCorrida pc
    JOIN ArtAlm aa ON aa.Empresa = @Empresa AND aa.Almacen = pc.Almacen AND aa.Articulo = pc.Articulo AND ISNULL(aa.SubCuenta, '') = ISNULL(pc.SubCuenta, '') AND AbastecimientoDirecto = 1

/*

  -- Dejar los Materiales como segunda vuelta
  INSERT #PlanCorrida2 (
         Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion)
  SELECT Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion
    FROM #PlanCorrida
   WHERE Articulo IN (SELECT DISTINCT Material FROM ArtMaterial)


  -- Borrar Materiales
  DELETE #PlanCorrida
  WHERE Articulo IN (SELECT DISTINCT Material FROM ArtMaterial)

  
  -- si no tiene mas productos usar los materiales
  IF NOT EXISTS(SELECT * FROM #PlanCorrida)
  BEGIN
    INSERT #PlanCorrida (
           Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion)
    SELECT Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion
      FROM #PlanCorrida2
    DELETE #PlanCorrida2
  END
*/

  IF EXISTS(SELECT * FROM RutaDistribucionD WHERE AlmacenOrigen = AlmacenDestino) 
    SELECT @Ok = 20851

  SELECT @UltDRP = NULL
  WHILE EXISTS(SELECT * FROM #PlanCorrida) AND @Ok IS NULL
  BEGIN
    IF EXISTS(SELECT * FROM #PlanCorrida WHERE DRP = 1) SELECT @DRP = 1 ELSE SELECT @DRP = 0
    IF @DRP <> @UltDRP SELECT @Vuelta = 0, @UltDRP = @DRP
    IF @CorridaOrden = 'ALMACEN' 
      DECLARE crCorrida CURSOR FOR
       SELECT p.Articulo, ISNULL(p.SubCuenta, ''), p.Almacen, p.EsDistribucion
         FROM #PlanCorrida p
         JOIN Art ON p.Articulo = Art.Articulo
         LEFT OUTER JOIN Alm ON p.Almacen = Alm.Almacen 
        WHERE p.Vuelta <= @Vuelta 
          AND DRP = @DRP
        ORDER BY Alm.Orden, Alm.Almacen, p.Articulo, p.SubCuenta
    ELSE
      DECLARE crCorrida CURSOR FOR
       SELECT p.Articulo, ISNULL(p.SubCuenta, ''), p.Almacen, p.EsDistribucion
         FROM #PlanCorrida p, Art
        WHERE p.Vuelta <= @Vuelta AND p.Articulo = Art.Articulo
          AND DRP = @DRP
        ORDER BY p.Articulo, p.SubCuenta

    OPEN crCorrida
    FETCH NEXT FROM crCorrida INTO @Articulo, @SubCuenta, @Almacen, @EsDistribucion
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN

/*        -- Elimina de PlanCorrida2 lo que ya fue planeado
        DELETE #PlanCorrida2 
         WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = @SubCuenta AND Almacen = @Almacen
*/ 
         
        IF @Debug = 1 SELECT "Articulo" = @Articulo, "SubCuenta" = @SubCuenta, "Almacen" = @Almacen, "DRP" = @EsDistribucion
        SELECT @AlmacenTipo = UPPER(Tipo) FROM Alm WHERE Almacen = @Almacen
        IF @@ROWCOUNT = 0 SELECT @Ok = 20830, @OkRef = @Almacen

        DELETE PlanArt 
        WHERE Empresa = @Empresa AND AlmacenDestino = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'RD' 

        IF @ArticuloEspecifico IS NULL
	  EXEC spPlanArtOPEliminar @Empresa, @Almacen, @Articulo, @SubCuenta, @OperacionRemota

        -- Inicializar
        SELECT @Proveedor = NULL, @InvSeguridad = 0.0

	-- Leer Valores por Omision
        SELECT @SeVende 	       = SeVende,
               @SeProduce 	       = SeProduce,
	       @SeCompra    	       = SeCompra,
               @Ruta		       = ProdRuta,
               @TiempoEntrega	       = ISNULL(TiempoEntrega, 0),
    	       @TiempoEntregaUnidad    = TiempoEntregaUnidad,
               @TiempoEntregaSeg       = ISNULL(TiempoEntregaSeg, 0),
    	       @TiempoEntregaSegUnidad = TiempoEntregaSegUnidad,
               @AlmacenROP	       = NULLIF(RTRIM(AlmacenROP), ''),
               @RutaDistribucion       = NULLIF(RTRIM(RutaDistribucion), ''),
               @ArtCantidad	       = ISNULL(NULLIF(ProdCantidad, 0.0), 1.0),
               @ArtUnidad	       = UnidadCompra,
               @Proveedor 	       = Proveedor
          FROM Art 
         WHERE Articulo = @Articulo

        IF @CfgPlanTESeguridad = 0 
          SELECT @TiempoEntregaSeg = 0, @TiempoEntregaSegUnidad = NULL

        SELECT @InvSeguridad = 0, @LoteOrdenar = NULL, @CantidadOrdenar = 0, @MultiplosOrdenar = 1, @CantidadOrdenarTiempo = 0

    	SELECT @InvSeguridad     	= ISNULL(Minimo, 0),
    	       @LoteOrdenar 	 	= UPPER(LoteOrdenar),
       	       @CantidadOrdenar	 	= ISNULL(CantidadOrdenar, 0),
      	       @MultiplosOrdenar 	= ISNULL(NULLIF(MultiplosOrdenar, 0.0), 1),
       	       @CantidadOrdenarTiempo	= ISNULL(CantidadOrdenarTiempo, 0)
          FROM ArtAlm
         WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen AND NULLIF(SubCuenta, '') = NULLIF(@SubCuenta, '')
        IF @@ROWCOUNT = 0 AND NULLIF(@SubCuenta, '') IS NULL
       	  SELECT @InvSeguridad     	= ISNULL(Minimo, 0),
    	         @LoteOrdenar 	   	= UPPER(LoteOrdenar),
       	         @CantidadOrdenar  	= ISNULL(CantidadOrdenar, 0),
      	         @MultiplosOrdenar 	= ISNULL(NULLIF(MultiplosOrdenar, 0.0), 1),
       	         @CantidadOrdenarTiempo = ISNULL(CantidadOrdenarTiempo, 0)
            FROM ArtAlm
           WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen AND NULLIF(SubCuenta, '') IS NULL

        IF @CfgRutaDistribucionNivelArticulo = 0 OR @RutaDistribucion IS NULL SELECT @RutaDistribucion = @CfgRutaDistribucion

	-- Zona Congelada	
        EXEC spIncTiempo @PrimerDia, @TiempoEntrega, @TiempoEntregaUnidad, @FechaCongelada OUTPUT
        IF @TipoPeriodo = 'DIA'    SELECT @PeriodoCongelado = DATEDIFF(day, @PrimerDia, @FechaCongelada)   ELSE
        IF @TipoPeriodo = 'SEMANA' SELECT @PeriodoCongelado = DATEDIFF(week, @PrimerDia, @FechaCongelada)  ELSE
        IF @TipoPeriodo = 'MES'    SELECT @PeriodoCongelado = DATEDIFF(month, @PrimerDia, @FechaCongelada) 
          
        IF @CfgPlanIgnorarZonaCongelada = 1 SELECT @PeriodoCongelado = -1

        IF EXISTS(SELECT * FROM ArtPlanEx WHERE Articulo = @Articulo)
	  EXEC spPlanArtExcepcion @EsDistribucion, @Articulo, @SubCuenta, @Almacen, 
                                  @Ruta OUTPUT, @LoteOrdenar OUTPUT, @CantidadOrdenar OUTPUT, @MultiplosOrdenar OUTPUT, @CantidadOrdenarTiempo OUTPUT, 
	      	     	          @TiempoEntrega OUTPUT, @TiempoEntregaUnidad OUTPUT, @TiempoEntregaSeg OUTPUT, @TiempoEntregaSegUnidad OUTPUT, 
				  @InvSeguridad OUTPUT, @AlmacenROP OUTPUT, @RutaDistribucion OUTPUT, @Proveedor OUTPUT,
                                  @Ok OUTPUT, @OkRef OUTPUT

        IF UPPER(@AlmacenROP) = '(DEMANDA)' SELECT @AlmacenROP = @Almacen

        --IF @Debug = 1 SELECT @Articulo, @AlmacenROP, @Ruta, @CantidadOrdenar, @InvSeguridad, @RutaDistribucion

        IF @Almacen <> @AlmacenROP 
          SELECT /*@LoteOrdenar = 'LOTE POR LOTE', */@TiempoEntrega = 0, @TiempoEntregaSeg = 0

        IF NULLIF(RTRIM(@AlmacenROP), '') IS NULL SELECT @Ok = 20855, @OkRef = RTRIM(@Articulo)

        IF @LoteOrdenar = 'LOTE POR LOTE' SELECT @CantidadOrdenar = 1, @MultiplosOrdenar = 1 ELSE
        IF @LoteOrdenar = 'CANTIDAD FIJA' SELECT @MultiplosOrdenar = @CantidadOrdenar

        IF @CfgPlanISDemanda = 1 OR @Referencia IS NOT NULL SELECT @InvSeguridad = 0

        -- TE=2S, IS=5, TL=20, M=10, TES=?
        EXEC spPlanArtLeyenda @Empresa, @Articulo, @SubCuenta, @Almacen,
                              @CantidadOrdenar, @MultiplosOrdenar, @CantidadOrdenarTiempo, @InvSeguridad, @TiempoEntrega, 
                              @TiempoEntregaUnidad, @TiempoEntregaSeg, @TiempoEntregaSegUnidad

        SELECT @MultiplosOrdenar = ISNULL(NULLIF(@MultiplosOrdenar, 0.0), 1)

        -- Borrar Calculos Anteriores
        DELETE #PlanCorrida WHERE CURRENT OF crCorrida

        DELETE PlanArt 
         WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta
           AND Acronimo IN ('DA', 'DT', 'ATP', 'EP', 'RN', 'ROP', 'REP', 'LOP', 'LEP'/*, 'LOPF', 'LODF'*/) 

        IF @CfgPlanISDemanda = 0
          DELETE PlanArt 
           WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta
             AND Acronimo = 'IS'
  
        -- Demanda Actual (DA)
        IF @DRP = 0 OR @EsDistribucion = 1 
          SELECT @RD = 'RD', @SODF = 'SODF' -- esto es para que no incluya la demanda en almacenes de distribucion, porque si no la duplica
        ELSE
          SELECT @RD = '', @SODF = ''

        IF @DRP = 0 OR @EsDistribucion = 1 
          INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
          SELECT @Empresa, @Almacen, @Articulo, @SubCuenta, 'DA', SUM(Cantidad), Periodo
            FROM PlanArt
           WHERE Empresa = @Empresa AND Acronimo IN ('IS', 'PV', 'PVE', 'SOL', 'OT', 'OI', 'RB', @RD)
             AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen 
           GROUP BY Periodo
        ELSE
          INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
          SELECT @Empresa, @Almacen, @Articulo, @SubCuenta, 'DA', SUM(Cantidad), Periodo
            FROM PlanArt
           WHERE Empresa = @Empresa AND Acronimo IN ('IS', 'PV', 'PVE', 'SOL', 'OT', 'OI', 'RB', @RD)
             AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen AND OrigenPlan = 0
           GROUP BY Periodo

        -- Demanda Total (DT)
        INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
        SELECT @Empresa, @Almacen, @Articulo, @SubCuenta, 'DT', SUM(Cantidad), Periodo
          FROM PlanArt
         WHERE Empresa = @Empresa AND Acronimo = 'DA'
           AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen AND Periodo <= @PeriodoCongelado
         GROUP BY Periodo

        INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo)
        SELECT @Empresa, @Almacen, @Articulo, @SubCuenta, 'DT', MAX(Cantidad), Periodo
          FROM PlanArt
         WHERE Empresa = @Empresa AND Acronimo IN ('DA', 'PRV')
           AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen AND Periodo > @PeriodoCongelado
         GROUP BY Periodo

        SELECT @EP = 0.0, @Ult_ATP = 0
        SELECT @EP = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'E' AND Periodo < 0
        SELECT @ATP = @EP

        -- Agregar Existencia Proyectada (EP)
        IF @EP <> 0.0
          INSERT PlanArt (Empresa,  Almacen,  Articulo,  SubCuenta,  Acronimo, Cantidad, Periodo) 
                  VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, 'EP',     @EP,      -1)
       
        SELECT @p = 0, @PeriodoInicialDemanda = NULL
        WHILE @p <= @Periodos 
        BEGIN
 	  -- Existencia Proyectada (EP)
          SELECT @Accion = NULL, @RP = 0.0, @DT = 0.0, @RN = 0.0, @ROPF = 0.0, @REPF = 0.0, @ROP = 0.0, @IS = 0.0--, @LEP = 0.0
          IF @p = 0
          BEGIN
            SELECT @RP  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo IN ('RP', 'ROPF', 'REPF') AND Periodo <= 0
            SELECT @DT  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo IN ('DT', @SODF)          AND Periodo <= 0 
            SELECT @DA  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'DA'                    AND Periodo <= 0 
            --SELECT @LEP = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'LEP' AND Periodo <= 0          
          END ELSE
          BEGIN
            SELECT @RP  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo IN ('RP', 'ROPF', 'REPF') AND Periodo = @p
            SELECT @DT  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo IN ('DT', @SODF)          AND Periodo = @p
            SELECT @DA  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'DA'                    AND Periodo = @p
            SELECT @IS  = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'IS'                    AND Periodo = @p
            --SELECT @LEP = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'LEP' AND Periodo = @p
          END


/*if @p=1  and @Almacen = 'PT'
select  "EP" = @EP, "RP" = @RP, "DT" = @DT*/
          SELECT @EP = @EP + @RP - @DT

          IF @CfgPlanBasePresupuesto = 0 OR NULLIF(RTRIM(@LoteOrdenar), '') IS NOT NULL 
          BEGIN
            IF ((@CfgPlanSinDemanda = 1 AND @InvSeguridad > 0) OR @DA > 0 OR @DT > 0) AND @PeriodoInicialDemanda IS NULL SELECT @PeriodoInicialDemanda = @p
            IF @EP = 0.0 AND @PeriodoInicialDemanda IS NOT NULL SELECT @RN = @InvSeguridad ELSE
            IF @EP < 0.0 SELECT @RN = -@EP + @InvSeguridad ELSE           
            IF @EP > 0.0 AND @EP < @InvSeguridad SELECT @RN = @InvSeguridad - @EP          
            IF @CfgPlanIgnorarZonaCongelada = 0 AND @CfgPlanSinDemanda = 0 AND @RN <= @InvSeguridad AND @p <= @PeriodoCongelado SELECT @RN = 0	-- Si el requirerimiento Neto Es Menor o Igual al InvSeguridad y Esta en la Zona Congelada que no haga nada
          END

    	  -- Requerimientos Netos (RN)
          IF @CfgPlanBasePresupuesto = 1 AND NULLIF(RTRIM(@LoteOrdenar), '') IS NULL AND EXISTS(SELECT * FROM PlanArt WHERE Empresa = @Empresa AND Acronimo = 'DT' AND Articulo = @Articulo)
          BEGIN
            EXEC spPlanCoberturaEnMeses @Empresa, @Almacen, @Articulo, @SubCuenta, @p, @EP, @CoberturaEnMeses OUTPUT
            IF @CoberturaEnMeses < @InvSeguridad
            BEGIN
              EXEC spPlanCantidadOrdenarEnMeses @Empresa, @Almacen, @Articulo, @SubCuenta, @p, @EP, @CantidadOrdenarTiempo, @RN OUTPUT
              IF @EP < 0.0 SELECT @RN = -@EP 
              SELECT @EP2 = @EP + @RN
              EXEC spPlanCoberturaEnMeses @Empresa, @Almacen, @Articulo, @SubCuenta, @p, @EP2, @CoberturaEnMeses OUTPUT
              IF @CoberturaEnMeses < @InvSeguridad
              BEGIN
                EXEC spPlanCantidadOrdenarEnMeses @Empresa, @Almacen, @Articulo, @SubCuenta, @p, @EP2, @CantidadOrdenarTiempo, @RN2 OUTPUT
                SELECT @RN = @RN + @RN2
              END
            END
          END

/*if @p=1  and @Almacen = 'PT'
  select "RN" = @RN, "EP" = @EP, "DT" = @DT, "CantidadOrdenar" = @CantidadOrdenar, "InvSeguridad" = @InvSeguridad*/

          -- Recibo Ordenes Planeadas en Firme 
          SELECT @ROPF = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'ROPF' AND Periodo = @p
          -- Recibo Ordenes Distribucion en Firme 
          SELECT @REPF = ISNULL(SUM(Cantidad), 0.0) FROM PlanArt WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'REPF' AND Periodo = @p

          -- Recibo Ordenes Planeadas (ROP y LOP)
          IF @RN > 0.0 
          BEGIN        
            SELECT @ROP = @RN
            IF @LoteOrdenar IN ('CANTIDAD MINIMA / MULTIPLOS', 'CANTIDAD FIJA') 
            BEGIN
              IF @RN < @CantidadOrdenar SELECT @ROP = @CantidadOrdenar
              SELECT @ROP = ROUND(CEILING(CONVERT(float, @ROP) / @MultiplosOrdenar) * @MultiplosOrdenar, 10)
            END

     	    -- Calcular Liberacion Ordenes Planeadas (LOP)
            IF @ROP <> 0.0 
            BEGIN
              SELECT @PeriodoROP = @p
              IF @TipoPeriodo = 'DIA'    SELECT @FechaEntrega = DATEADD(day, @p, @PrimerDia)   ELSE
              IF @TipoPeriodo = 'SEMANA' SELECT @FechaEntrega = DATEADD(week, @p, @PrimerDia)  ELSE
              IF @TipoPeriodo = 'MES'    SELECT @FechaEntrega = DATEADD(month, @p, @PrimerDia)                

              IF (SELECT AbastecimientoDirecto FROM ArtAlm aa WHERE aa.Empresa = @Empresa AND aa.Almacen = @Almacen AND aa.Articulo = @Articulo AND ISNULL(aa.SubCuenta, '') = ISNULL(@SubCuenta, '')) = 1
                SELECT @AlmacenROP = @Almacen

              SELECT @AlmacenOrigen = @AlmacenROP, @AlmacenDestino = @Almacen

              IF @AlmacenROP <> @Almacen AND @AlmacenTipo <> 'PROCESO' 
              BEGIN
                SELECT @RO = 'REP', @LO = 'LEP', @Accion = 'Distribuir'
                SELECT @AlmacenOrigen       = AlmacenOrigen,
                       @TiempoEntrega       = TiempoEntrega, 
                       @TiempoEntregaUnidad = TiempoEntregaUnidad
                  FROM RutaDistribucionD
                 WHERE Ruta = @RutaDistribucion AND AlmacenDestino = @AlmacenDestino
                IF @@ROWCOUNT = 0 
                BEGIN
                  SELECT @Ok = 20850, @OkRef = '<BR><BR>Origen: '+RTRIM(@AlmacenOrigen)+', Destino:'+RTRIM(@AlmacenDestino)+', Articulo:'+RTRIM(@Articulo)
                END ELSE
                BEGIN
                  IF NULLIF(RTRIM(@AlmacenOrigen), '') IS NULL SELECT @Ok = 20855, @OkRef = RTRIM(@Articulo)      
                  IF EXISTS(SELECT * FROM Art WHERE Articulo = @Articulo AND AlmacenROP = @AlmacenOrigen) SELECT @DRPDistribucion = 0 ELSE SELECT @DRPDistribucion = 1 
                  IF @DRP = @DRPDistribucion SELECT @VueltaDistribucion = @Vuelta + 1 ELSE SELECT @VueltaDistribucion = 0
     	          IF NOT EXISTS(SELECT * FROM #PlanCorrida WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @AlmacenOrigen AND DRP = @DRPDistribucion AND Vuelta = @VueltaDistribucion) AND @Ok IS NULL
                    INSERT #PlanCorrida (Articulo,  SubCuenta,  Almacen,        DRP,			Vuelta, 		EsDistribucion) 
                                 VALUES (@Articulo, @SubCuenta, @AlmacenOrigen, @DRPDistribucion,	@VueltaDistribucion, 	1)

                  -- TE=2S, IS=5, TL=20, M=10, TES=?
                  EXEC spPlanArtLeyenda @Empresa, @Articulo, @SubCuenta, @Almacen,
                                        @CantidadOrdenar, @MultiplosOrdenar, @CantidadOrdenarTiempo, @InvSeguridad, @TiempoEntrega, 
                                        @TiempoEntregaUnidad, @TiempoEntregaSeg, @TiempoEntregaSegUnidad
                END
              END ELSE
              BEGIN
                SELECT @RO = 'ROP', @LO = 'LOP', @Accion = NULL, @AlmacenDestino = NULL
  	        IF @TiempoEntregaSeg > 0
                BEGIN
       	          EXEC spDecTiempo @FechaEntrega, @TiempoEntregaSeg, @TiempoEntregaSegUnidad, @FechaEntrega OUTPUT
                  IF @TipoPeriodo = 'DIA'    SELECT @PeriodoROP = DATEDIFF(day, @PrimerDia, @FechaEntrega)   ELSE
                  IF @TipoPeriodo = 'SEMANA' SELECT @PeriodoROP = DATEDIFF(week, @PrimerDia, @FechaEntrega)  ELSE
                  IF @TipoPeriodo = 'MES'    SELECT @PeriodoROP = DATEDIFF(month, @PrimerDia, @FechaEntrega) 
                END
              END
  
              INSERT PlanArt (Empresa,  Almacen,  Articulo,  SubCuenta,  Acronimo, Cantidad, Periodo) 
                      VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, @RO,      @ROP,     @PeriodoROP)

              EXEC spDecTiempo @FechaEntrega, @TiempoEntrega, @TiempoEntregaUnidad, @FechaLiberacion OUTPUT

              IF @CfgPlanRecorrerLiberacion = 1 
                EXEC spRetrocederDiaHabil @CfgDiasHabiles, 0, @FechaLiberacion OUTPUT
            
              IF @TipoPeriodo = 'DIA'    SELECT @FechaEntregaLOP = DATEADD(day, @PeriodoROP, @PrimerDia)  ELSE
              IF @TipoPeriodo = 'SEMANA' SELECT @FechaEntregaLOP = DATEADD(week, @PeriodoROP, @PrimerDia) ELSE
              IF @TipoPeriodo = 'MES'    SELECT @FechaEntregaLOP = DATEADD(month, @PeriodoROP, @PrimerDia) 

    	      EXEC spDecTiempo @FechaEntregaLOP, @TiempoEntrega, @TiempoEntregaUnidad, @FechaLiberacion OUTPUT

              IF @CfgPlanRecorrerLiberacion = 1 
                EXEC spRetrocederDiaHabil @CfgDiasHabiles, 0, @FechaLiberacion OUTPUT

              IF @TipoPeriodo = 'DIA'    SELECT @PeriodoLOP = DATEDIFF(day, @PrimerDia, @FechaLiberacion)   ELSE
              IF @TipoPeriodo = 'SEMANA' SELECT @PeriodoLOP = DATEDIFF(week, @PrimerDia, @FechaLiberacion)  ELSE
              IF @TipoPeriodo = 'MES'    SELECT @PeriodoLOP = DATEDIFF(month, @PrimerDia, @FechaLiberacion)
        

              IF @Accion = 'Distribuir' AND @Ok IS NULL
              BEGIN
                UPDATE PlanArt 
                   SET Cantidad = ISNULL(Cantidad, 0.0) + @ROP
                 WHERE Empresa = @Empresa AND Almacen = @AlmacenOrigen AND AlmacenDestino = @AlmacenDestino AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = 'RD' AND Periodo = @PeriodoLOP 
                IF @@ROWCOUNT = 0
                  INSERT PlanArt (Empresa,  Almacen,        AlmacenDestino,  Articulo,  SubCuenta,  Acronimo, Cantidad, Periodo) 
                          VALUES (@Empresa, @AlmacenOrigen, @AlmacenDestino, @Articulo, @SubCuenta, 'RD',     @ROP,     @PeriodoLOP)

                UPDATE PlanArtFlujo
                   SET MaterialCantidad = ISNULL(MaterialCantidad, 0) + @ROP,
     	               ProductoCantidad = ISNULL(ProductoCantidad, 0) + @ROP
                 WHERE Empresa = @Empresa AND Material = @Articulo AND MaterialPeriodo = @PeriodoLOP AND MaterialSubCuenta = ISNULL(@SubCuenta, '') AND MaterialAlmacen = @AlmacenOrigen AND MaterialAcronimo = 'LEP' AND Producto = @Articulo AND ProductoPeriodo = @PeriodoROP AND ProductoSubCuenta = ISNULL(@SubCuenta, '') AND ProductoAlmacen = @AlmacenDestino AND ProductoAcronimo = 'RD'
                IF @@ROWCOUNT = 0
                  INSERT PlanArtFlujo (Empresa,  Material,  MaterialPeriodo, MaterialSubCuenta,      MaterialAlmacen, MaterialAcronimo, Producto,  ProductoPeriodo, ProductoSubCuenta,      ProductoAlmacen, ProductoAcronimo, MaterialCantidad, ProductoCantidad)
                               VALUES (@Empresa, @Articulo, @PeriodoLOP,     ISNULL(@SubCuenta, ''), @AlmacenOrigen, 'LEP',             @Articulo, @PeriodoROP,     ISNULL(@SubCuenta, ''), @AlmacenDestino,  'RD',            @ROP,             @ROP)
              END

              UPDATE PlanArt 
                 SET Cantidad = ISNULL(Cantidad, 0.0) + @ROP
               WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Acronimo = @LO AND Periodo = @PeriodoLOP 
              IF @@ROWCOUNT = 0
                INSERT PlanArt (Empresa,  Almacen,  Articulo,  SubCuenta,  Acronimo, Cantidad, Periodo) 
                        VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, @LO,      @ROP,     @PeriodoLOP)

              IF @ArticuloEspecifico IS NULL AND (@Accion = 'Distribuir' OR @DRP = 0) AND @Ok IS NULL
              BEGIN
                -- Insertar ROP 
                IF ISNULL(@ROP, 0) <> 0.0 
                BEGIN
                  IF @Accion IS NULL
                  BEGIN
                    IF @SeProduce = 1 AND @CfgProd = 1 SELECT @Accion = 'Producir' ELSE SELECT @Accion = 'Comprar'
                  END

                  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @AlmacenOrigen

		  EXEC spPlanArtOPActualizar @Sucursal, @Empresa, @AlmacenOrigen, @AlmacenDestino, @Articulo, @SubCuenta,
                                             @FechaLiberacion,  @FechaEntrega,
                                             @ROP, @Ruta, @ArtUnidad, @Proveedor, @Accion, @EstadoOmision,
					     @OperacionRemota

                  IF @Accion = 'Producir' 
                    EXEC spPlanArtExplotar @Empresa, @AlmacenOrigen, @Vuelta, @p, @PeriodoLOP, @Articulo, @SubCuenta, @ROP, 
             		                   @ArtCantidad, @ArtUnidad, @LO,
  			                   @CfgMermaIncluida, @CfgDesperdicioIncluido, @CfgTipoMerma, @CfgMultiUnidades, @CfgMultiUnidadesNivel,
		  	                   @Ok OUTPUT, @OkRef OUTPUT
                END
              END
            END
          END

  	  -- Calcular Nuevamente (EP)
          SELECT @EP = @ROP + @EP + @IS
          IF @EP <> 0.0
            INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, 'EP', @EP, @p)
          IF @RN > 0.0
            INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, 'RN', @RN, @p)

          IF @SeVende = 1 AND @CalcATP = 1
          BEGIN
            -- ATP (Notas RP incluye ROPF, Si maneja TE Seguridad ROP entra sin la seguridad )
            IF (@RP > 0.0 OR @ROP > 0.0) 
            BEGIN
              IF @ATP < 0.0
                SELECT @Ult_ATP = @Ult_ATP + 1
              ELSE
                WHILE @Ult_ATP < @p 
                BEGIN
                  INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, 'ATP', @ATP, @Ult_ATP)
                  SELECT @Ult_ATP = @Ult_ATP + 1
                END
            END
            SELECT @ATP = @ATP - @DA + @RP + @ROP + @IS
          END

          SELECT @p = @p + 1 
        END

        IF @SeVende = 1 AND @CalcATP = 1
        BEGIN
          -- ATP
          IF @ATP > 0.0
            WHILE @Ult_ATP <= @Periodos
            BEGIN
              INSERT PlanArt (Empresa, Almacen, Articulo, SubCuenta, Acronimo, Cantidad, Periodo) VALUES (@Empresa, @Almacen, @Articulo, @SubCuenta, 'ATP', @ATP, @Ult_ATP)
              SELECT @Ult_ATP = @Ult_ATP + 1
            END
        END
      END
      IF @Ok IS NOT NULL AND @ArticuloEspecifico IS NULL
      BEGIN
        SELECT @Mensaje = RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok
        EXEC spPlanMensaje @BitacoraID, @Mensaje
        IF @AbortarPrimerError = 0 SELECT @Ok = NULL, @OkRef = NULL
      END
      FETCH NEXT FROM crCorrida INTO @Articulo, @SubCuenta, @Almacen, @EsDistribucion
    END -- While
    CLOSE crCorrida
    DEALLOCATE crCorrida
    SELECT @Vuelta = @Vuelta + 1

/*
    -- si no tiene mas productos usar los materiales
    IF NOT EXISTS(SELECT * FROM #PlanCorrida)
    BEGIN
      INSERT #PlanCorrida (
             Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion)
      SELECT Articulo, SubCuenta, Almacen, DRP, Vuelta, EsDistribucion
        FROM #PlanCorrida2
      DELETE #PlanCorrida2
    END
*/
  END  -- While

  IF @ArticuloEspecifico IS NULL
  BEGIN
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM PlanMensaje WHERE BitacoraID = @BitacoraID)
    BEGIN
      UPDATE Version SET UltimaCorrida = GETDATE(), PlanReferencia = @Referencia, PlanReferenciaModulo = @ReferenciaModulo
      IF @CfgPlanHist = 1 EXEC spPlanHist 1
      SELECT @BitacoraEstatus = 'CONCLUIDO'
      SELECT @Mensaje = "Se generó con éxito la Corrida Planeación."
    END ELSE
    BEGIN
      SELECT @BitacoraEstatus = 'BAJA'
      IF @Ok IS NULL
        SELECT @Mensaje = "Se generó con ERRORES la Corrida Planeación." 
      ELSE BEGIN
        SELECT @Mensaje = RTRIM(Descripcion)+' '+RTRIM(@OkRef) FROM MensajeLista WHERE Mensaje = @Ok
        EXEC spPlanMensaje @BitacoraID, @Mensaje
      END 
      IF @AbortarPrimerError = 1
        EXEC spPlanArtBorrar @Empresa, @ArticuloEspecifico, @OperacionRemota
    END
    EXEC spPlanBitacoraFin @BitacoraID, @BitacoraEstatus, @Mensaje, @Empresa, @Categoria, @Grupo, @Familia, @Fabricante, @Linea, @Temporada, @Proveedor, @FechaInicio, @OperacionRemota
  END

  IF @OperacionServidor IS NOT NULL AND @OperacionLigarServidor = 1 
    EXEC sp_dropserver @OperacionServidor

  IF @ArticuloEspecifico IS NULL
    SELECT "Mensaje" = @Mensaje

  RETURN
END
GO

/*

spPlanArt 'RE', '1115'



spPlanArt 'SLP', 'AG0001'
select * from planart where articulo = 'AG0001'
select * from planartop where articulo = 'AG0001'

select * from  planartop where articulo = 'AG0001' and estado = 'liberado'
  	select * from PlanArtOP order by articulo, subcuenta
	delete planartop

	select * from PlanArt where articulo = 'TELA' and subCuenta = 'BCO'
	update PlanArtOP SET EnFirme = 0

select * from planart where Articulo = 'CAJA'
select * from PlanArtOP where Articulo = 'CAJA' order by articulo, subcuenta

delete planartop


spPlanArt 'DEMO', 'C10', @Debug = 1
select * from planart where articulo = 'c10'
select * from planart where articulo = 'A10' and almacen = 'stock'
select * from PlanArtFlujo

SELECT DISTINCT Articulo, Subcuenta, Almacen FROM PlanArt
select * from PlanArtOP where Articulo = 'BIC'
select * from PlanArt where Articulo = 'BIC'


SET NOCOUNT ON
EXEC spPlanArt 'VIANA', @Debug = 1 , @Categoria = 'BLANCA'

select categoria, * from art where Categoria = 'BLANCA'
select * from artgrupo 
select * from planbitacora


declare
			@Categoria	     varchar(50),
			@Grupo		     varchar(50),
			@Familia	     varchar(50),
			@Fabricante	     varchar(50),
			@Linea		     varchar(50),
			@Temporada	     varchar(50),
			@ProveedorEspecifico char(10)
select @grupo = 'ventilador'

select Articulo, Grupo, Categoria, Familia, Fabricante, Linea, Temporada, Proveedor
  from art a
 where ISNULL(a.Categoria, '') = ISNULL(ISNULL(@Categoria, a.Categoria) , '') AND ISNULL(a.Grupo, '') = ISNULL(ISNULL(@Grupo, a.Grupo), '') AND ISNULL(a.Familia, '') = ISNULL(ISNULL(@Familia, a.Familia), '') AND ISNULL(a.Fabricante, '') = ISNULL(ISNULL(@Fabricante, a.Fabricante), '') AND ISNULL(a.Linea, '') = ISNULL(ISNULL(@Linea, a.Linea), '') AND ISNULL(a.Proveedor, '') = ISNULL(ISNULL(@ProveedorEspecifico, a.Proveedor), '') AND ISNULL(a.Temporada, '') = ISNULL(ISNULL(@Temporada, a.Temporada), '')



SET NOCOUNT ON
EXEC spPlanArt 'VIANA', @Grupo = 'ANTENA', @OperacionBase = 'Viana2301'

EXEC spPlanArt 'DEMO', @Debug = 1

SELECT PlanArt.Articulo,
  PlanArt.SubCuenta,
    PlanArt.Periodo,
  PlanArt.Cantidad,
          PlanArtLeyenda.Leyenda,
    PlanEstructura.Orden,
        Acronimo.Termino,
    Art.Descripcion1 FROM
  PlanArt,
  PlanArtLeyenda,
  PlanEstructura,
  Acronimo,
  Art

WHERE (PlanArt.Acronimo=PlanEstructura.Acronimo AND 
  PlanArt.Empresa=PlanArtLeyenda.Empresa AND PlanArt.Almacen=PlanArtLeyenda.Almacen AND PlanArt.Articulo=PlanArtLeyenda.Articulo AND PlanArt.SubCuenta=PlanArtLeyenda.SubCuenta AND 
  PlanArt.Articulo=Art.Articulo AND 
  PlanEstructura.Acronimo=Acronimo.Acronimo) AND (PlanArt.Empresa='DEMO' AND
PlanArt.Articulo='A1' AND
PlanEstructura.TipoPlan='ART' AND PlanEstructura.Visible=1) ORDER BY PlanArt.SubCuenta 


SET NOCOUNT ON
EXEC spPlanArt 'DEMO', @Debug = 1
select * from PlanArt  where acronimo = 'ROP'
select * from PlanArtOP  

*/




