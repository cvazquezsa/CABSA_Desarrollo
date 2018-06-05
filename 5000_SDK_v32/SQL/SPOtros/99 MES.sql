SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO

/*
Sp's integrados en la versión

xpMovFinal
xpSaldoU
xpAntesAfectar
xpMovCopiarEncabezado
spAccesoOk
spDesAsignarAcceso
spCompraCostoInv
*/


/********************* spMESImporta **********************/
if exists (select * from sysobjects where id = object_id('dbo.spMESImporta') and type = 'P') drop procedure dbo.spMESImporta
GO             
CREATE PROCEDURE spMESImporta
    @Empresa        varchar(5),
    @Usuario        varchar(10),
    @Sucursal       int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
	@IDCompra         int,
	@ID               int,
	@MovCompra        varchar(20),
	@Serie            varchar(20),
	@Numero           varchar(20),
	@SucursalMov      int,
	
	@Proveedor        varchar(10),
	@Cliente		  varchar(10),
	@ZonaImpuesto     varchar(30),
	@FechaRequerida   datetime,
	@Condicion        varchar(50),
	@Concepto         varchar(50),
	@Estatus          varchar(15),
	@Articulo         varchar(20),
	@SubCuenta        varchar(50),
	@Almacen          varchar(10),
	@AlmacenArt       varchar(10),
	@FechaRequeridaD  datetime,
	@FechaEntrega     datetime,
	@Cantidad         float,
	@CantidadInventario float,
	@Costo            float,
	@CosteMaquinaria  money,
  @CosteMaterial    money,
  @CosteIndirecto   money,
  @CosteOperarios   money,
	@PorcIVA          float,
	@Unidad           varchar(50),
	@CfgMultiUnidades		bit,
  @CfgMultiUnidadesNivel		varchar(20),
  @ArtTipo            varchar(20),
  @Renglon            float,
  @RenglonID          int,
  @RenglonTipo        varchar(1),
  @Lanzamiento        varchar(100),
  @OrdenProduccion    varchar(100),
 	@IDInv            int,
	@MovInvE          varchar(20),
	@MovInvS          varchar(20),
	@Lote             varchar(20),
	
	@FechaEmision     datetime,
	@Referencia       varchar(50),
	@Moneda           varchar(10),
	@TipoCambio       float,
  @Propiedades      varchar(20),
  @Proyecto         varchar(50),
  @SubProyecto      varchar(50),
  @Origen			      varchar(20),
  @OrigenID         varchar(20),
  @IDOport          int,
  @Mensaje          varchar(255),
  @CostoInv         money,
  @Ok               int,
  @OkRef            varchar(255),

/*  jsmv contuso 1 y 2 */ 

  @ContUso	        varchar(20),
  @ContUso2         varchar(20),
  @IDReserva		    int,
  @RenglonReserva	  float

	CREATE TABLE #MesCompra(
	ID               int,
	Serie            varchar(20)  NULL,
	Numero           varchar(20)  NULL,
	Proveedor        varchar(10)  NULL,
	FechaEmision     datetime     NULL,
	FechaRequerida   datetime     NULL,
	Referencia       varchar(50)  NULL,
	Condicion        varchar(50)  NULL,
	Concepto         varchar(50)  NULL,
	Moneda           varchar(10)  NULL,
	Estatus          varchar(15)  NULL,
	Sucursal         int          NULL,
	Renglon          float        NULL,
	Articulo         varchar(20)  NULL,
	SubCuenta        varchar(50)  NULL,
	Almacen          varchar(10)  NULL,
	AlmacenArt       varchar(10)  NULL,
	FechaRequeridaD  datetime     NULL,
	FechaEntrega     datetime     NULL,
	Cantidad         float        NULL,
	Costo            float        NULL,
	PorcIVA          float        NULL,
	Unidad           varchar(50)  NULL,
	Lanzamiento      varchar(100) NULL,
	OrdenProduccion  varchar(100) NULL,
	Proyecto         varchar(50)  NULL,
	SubProyecto      varchar(50)  NULL)
	
	-- BEGIN TRAN
	
	SELECT @MovCompra = CompraOrden FROM EmpresaCfgMov ecm WHERE ecm.Empresa = @Empresa
	
	SELECT @CfgMultiUnidades         = MultiUnidades, 
	       @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
	  FROM EmpresaCfg2 
	 WHERE Empresa = @Empresa

	INSERT INTO #MesCompra
	         (ID,    Serie,    Numero,            Proveedor,    FechaEmision,    FechaRequerida,    Referencia,    Condicion, Moneda,                             Sucursal,    Renglon,    Articulo,    SubCuenta,    Almacen,   AlmacenArt,    FechaRequeridaD, FechaEntrega,       Cantidad,   Costo,                              PorcIVA,    Unidad,         Lanzamiento,    OrdenProduccion,    Proyecto)
	SELECT cm.ID, cm.Serie, cm.NumerodePedido, cm.Proveedor, cm.FechaEmision, cm.FechaRequerida, cm.Referencia, cm.Condicion, ISNULL(mm.Descripcion, 'Pesos'), cm.Sucursal, cd.Renglon, cd.Articulo, cd.SubCuenta, cd.Almacen, a.AlmMesComs, cd.FechaEntrega, cd.FechaRequerida, cd.Cantidad, ISNULL(acs.UltimoCosto, cd.Precio), cd.PorcIVA, um.Descripcion, cd.Lanzamiento, cd.OrdenProduccion, cm.Proyecto
	  FROM CompraMES cm
--	  JOIN CompraDMES cd ON cm.ID  = cd.ID
	  JOIN CompraDMES cd ON cm.Lanzamiento = cd.Lanzamiento AND cd.NumerodePedido = cm.NumerodePedido
	  JOIN Art a ON cd.Articulo = a.Articulo
	  LEFT OUTER JOIN MonMES mm ON cm.Moneda = mm.Moneda
	  LEFT OUTER JOIN UnidadMes um ON cd.UnidadPedida = um.UnidadMedida
	  LEFT OUTER JOIN ArtCostoSucursal acs ON acs.Empresa = @Empresa AND acs.Sucursal = ISNULL(cm.Sucursal, 0) AND acs.Articulo = cd.Articulo
	 WHERE ISNULL(cm.ModuloID, 0) = 0
	   AND ISNULL(a.AlmMesComs, '') <> ''
	   AND ISNULL(cm.EstatusIntelIMES, 0) = 0
	 
	-- UPDATE #MesCompra	SET Moneda = 'Pesos' WHERE Moneda = 'PES'
--	UPDATE #MesCompra	SET Moneda = 'Pesos' WHERE Moneda <> 'Pesos'

	DECLARE crMesCompra CURSOR FOR
	--SELECT mc.ID, mc.Serie, mc.Numero, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	SELECT mc.Serie, mc.Numero, mc.Lanzamiento, mc.Proveedor, mc.Moneda, mc.Almacen, mc.AlmacenArt--, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	  FROM #MesCompra mc
	  JOIN Art a ON mc.Articulo = a.Articulo AND (a.TipoArticulo <> '3')
	 GROUP BY mc.Serie, mc.Numero, mc.Lanzamiento, mc.Proveedor, mc.Moneda, mc.Almacen, mc.AlmacenArt--, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	 
	OPEN crMesCompra
	FETCH NEXT FROM crMesCompra INTO @Serie, @Numero, @Lanzamiento, @Proveedor, @Moneda, @Almacen, @AlmacenArt--, @Proveedor, @FechaEmision, @FechaRequerida, @Referencia, @Condicion, @Moneda, @Almacen, @SucursalMov
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
	/*  jsmv lee contuso de venta referente a Lanzamiento  LEE EL PRIMERO YA QUE LOS PEDIDOS SON POR SILLAS MUEBLES */
	
  	SELECT  @ContUso = NULL, @ContUso2 = NULL
	  SELECT	TOP 1 @ContUso = ContUso, @ContUso2 = ContUso2
	  FROM	VentaDMES
	  WHERE	Lanzamiento = @Lanzamiento
			
		SELECT @IDCompra = NULL
		SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
		-- SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = 'Pesos'
		SELECT @ZonaImpuesto = p.ZonaImpuesto FROM Prov p WHERE p.Proveedor = @Proveedor
		
		INSERT INTO Compra(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Referencia, Observaciones,                          Estatus, Proveedor, Almacen, Condicion, OrigenTipo, Sucursal, ZonaImpuesto, MesLanzamiento)
		-- VALUES(@Empresa, @MovCompra, @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Referencia, RTRIM(@Serie) + ' ' + RTRIM(@Numero), 'SINAFECTAR', @Proveedor, @Almacen, @Condicion, 'MES', @SucursalMov)
    SELECT TOP 1 @Empresa, @MovCompra, FechaEmision, Moneda, @TipoCambio, @Usuario, @Lanzamiento, RTRIM(@Serie) + ' ' + RTRIM(@Numero), 'CONFIRMAR', mc.Proveedor, @AlmacenArt, Condicion, 'MES', Sucursal, @ZonaImpuesto, @Lanzamiento
      FROM #MesCompra mc
      JOIN Art a ON mc.Articulo = a.Articulo AND a.TipoArticulo <> '3'
     WHERE Serie = @Serie AND Numero = @Numero AND Lanzamiento = @Lanzamiento AND mc.Proveedor = @Proveedor AND mc.Almacen = @Almacen

		SELECT @IDCompra = @@IDENTITY

		IF @IDCompra IS NOT NULL
		BEGIN
			
			DECLARE crMesCompraD CURSOR FOR
			 SELECT mc.Renglon, mc.Articulo, mc.SubCuenta, mc.FechaRequeridaD, mc.FechaEntrega, mc.Cantidad, mc.Costo, mc.PorcIVA, mc.Unidad, a.Tipo, mc.Lanzamiento, mc.OrdenProduccion
			   FROM #MesCompra mc
			   JOIN Art a ON mc.Articulo = a.Articulo AND a.TipoArticulo <> '3'
			  WHERE mc.Serie = @Serie AND mc.Numero = @Numero AND mc.Lanzamiento = @Lanzamiento AND mc.Proveedor = @Proveedor AND Almacen = @Almacen
			  
			OPEN crMesCompraD
			FETCH NEXT FROM crMesCompraD INTO @Renglon, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Cantidad, @Costo, @PorcIVA, @Unidad, @ArtTipo, @Lanzamiento, @OrdenProduccion
			WHILE @@FETCH_STATUS = 0
			BEGIN
        EXEC spZonaImp @ZonaImpuesto, @PorcIVA OUTPUT
        SELECT @Costo = (@Costo/@TipoCambio)*dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)
				
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @RenglonID = @Renglon

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

				INSERT INTO CompraD
				       (ID,        Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,     Articulo,  SubCuenta,  FechaRequerida,   FechaEntrega,  Costo,  Impuesto1, Unidad, ReferenciaExtra, DescripcionExtra, ContUso, ContUso2, MesLanzamiento)
				VALUES(@IDCompra, @Renglon, 0,         @RenglonID, @RenglonTipo, @Cantidad, @CantidadInventario, @AlmacenArt, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Costo, @PorcIVA, @Unidad, @Lanzamiento, @OrdenProduccion, @ContUso, @ContUso2, @Lanzamiento)
				
				FETCH NEXT FROM crMesCompraD INTO @Renglon, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Cantidad, @Costo, @PorcIVA, @Unidad, @ArtTipo, @Lanzamiento, @OrdenProduccion
			END
			
			CLOSE crMesCompraD
			DEALLOCATE crMesCompraD
			
	--		EXEC spAfectar 'COMS', @IDCompra, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
			
		END

	  UPDATE CompraMes SET EstatusIntelIMES = 1, ModuloID = @IDCompra
     WHERE Serie = @Serie AND NumerodePedido = @Numero AND Lanzamiento = @Lanzamiento AND Proveedor = @Proveedor

    UPDATE CompraDMes SET CantidadPendiente = Cantidad, ModuloID = @IDCompra, EstatusIntelIMES = 1
     WHERE Serie = @Serie AND NumerodePedido = @Numero AND Lanzamiento = @Lanzamiento AND Almacen = @Almacen
		
		FETCH NEXT FROM crMesCompra INTO @Serie, @Numero, @Lanzamiento, @Proveedor, @Moneda, @Almacen, @AlmacenArt--, @Proveedor, @FechaEmision, @FechaRequerida, @Referencia, @Condicion, @Moneda, @Almacen, @SucursalMov
	END
	
	CLOSE crMesCompra
	DEALLOCATE crMesCompra
	
-- Servicio Maquila
	DECLARE crMesCompra CURSOR FOR
	--SELECT mc.ID, mc.Serie, mc.Numero, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	SELECT mc.Serie, mc.Numero, mc.Lanzamiento, mc.Proveedor, mc.Moneda, mc.Almacen, mc.AlmacenArt--, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	  FROM #MesCompra mc
	  JOIN Art a ON mc.Articulo = a.Articulo AND a.TipoArticulo = '3'
	 GROUP BY mc.Serie, mc.Numero, mc.Lanzamiento, mc.Proveedor, mc.Moneda, mc.Almacen, mc.AlmacenArt--, mc.Proveedor, mc.FechaEmision, mc.FechaRequerida, mc.Referencia, mc.Condicion, mc.Moneda, mc.Almacen, mc.Sucursal
	 
	OPEN crMesCompra
	FETCH NEXT FROM crMesCompra INTO @Serie, @Numero, @Lanzamiento, @Proveedor, @Moneda, @Almacen, @AlmacenArt--, @Proveedor, @FechaEmision, @FechaRequerida, @Referencia, @Condicion, @Moneda, @Almacen, @SucursalMov
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
	/*  jsmv lee contuso de venta referente a Lanzamiento  LEE EL PRIMERO YA QUE LOS PEDIDOS SON POR SILLAS MUEBLES */
	
  	SELECT  @ContUso = NULL, @ContUso2 = NULL
	  SELECT	TOP 1 @ContUso = ContUso, @ContUso2 = ContUso2
	  FROM	VentaDMES
	  WHERE	Lanzamiento = @Lanzamiento
			
		SELECT @IDCompra = NULL
		SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
		-- SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = 'Pesos'
		SELECT @ZonaImpuesto = p.ZonaImpuesto FROM Prov p WHERE p.Proveedor = @Proveedor
		
		INSERT INTO Compra(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Concepto, Referencia, Observaciones,                          Estatus, Proveedor, Almacen, Condicion, OrigenTipo, Sucursal, ZonaImpuesto, MesLanzamiento)
		-- VALUES(@Empresa, @MovCompra, @FechaEmision, @Moneda, @TipoCambio, @Usuario, @Referencia, RTRIM(@Serie) + ' ' + RTRIM(@Numero), 'SINAFECTAR', @Proveedor, @Almacen, @Condicion, 'MES', @SucursalMov)
    SELECT TOP 1 @Empresa, 'Orden Compra', mc.FechaEmision, mc.Moneda, @TipoCambio, @Usuario, 'Maquila Proveedor', mc.Lanzamiento, RTRIM(@Serie) + ' ' + RTRIM(@Numero), 'CONFIRMAR', mc.Proveedor, @AlmacenArt, mc.Condicion, 'MES', mc.Sucursal, @ZonaImpuesto, @Lanzamiento
      FROM #MesCompra mc
      JOIN Art a ON mc.Articulo = a.Articulo AND a.TipoArticulo = '3'
     WHERE Serie = @Serie AND Numero = @Numero AND Lanzamiento = @Lanzamiento AND mc.Proveedor = @Proveedor AND a.AlmMesComs = @AlmacenArt

		SELECT @IDCompra = @@IDENTITY

		IF @IDCompra IS NOT NULL
		BEGIN
			
			DECLARE crMesCompraD CURSOR FOR
			 SELECT mc.Renglon, mc.Articulo, mc.SubCuenta, mc.FechaRequeridaD, mc.FechaEntrega, mc.Cantidad, ISNULL(ap.CostoAutorizado, mc.Costo), ISNULL(a.CostoEstandar, 0) + ISNULL(ap.CostoAutorizado, mc.Costo), mc.PorcIVA, mc.Unidad, a.Tipo, mc.Lanzamiento, mc.OrdenProduccion
			   FROM #MesCompra mc
			   JOIN Art a ON mc.Articulo = a.Articulo AND a.TipoArticulo = '3'
			   LEFT OUTER JOIN ArtProv ap ON ap.Articulo = a.Articulo AND ap.Proveedor = @Proveedor
			  WHERE mc.Serie = @Serie AND mc.Numero = @Numero AND mc.Lanzamiento = @Lanzamiento AND mc.Proveedor = @Proveedor AND a.AlmMesComs = @AlmacenArt
			  
			OPEN crMesCompraD
			FETCH NEXT FROM crMesCompraD INTO @Renglon, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Cantidad, @Costo, @CostoInv, @PorcIVA, @Unidad, @ArtTipo, @Lanzamiento, @OrdenProduccion
			WHILE @@FETCH_STATUS = 0
			BEGIN
        EXEC spZonaImp @ZonaImpuesto, @PorcIVA OUTPUT
        SELECT @Costo = (@Costo/@TipoCambio)*dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)
				
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @RenglonID = @Renglon

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

				INSERT INTO CompraD
				       (ID,        Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,     Articulo,  SubCuenta,  FechaRequerida,   FechaEntrega,  Costo,  CostoInv, Impuesto1, Unidad, ReferenciaExtra, DescripcionExtra, ContUso, ContUso2, MesLanzamiento)
				VALUES(@IDCompra, @Renglon, 0,         @RenglonID, @RenglonTipo, @Cantidad, @CantidadInventario, @AlmacenArt, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Costo, @CostoInv, @PorcIVA, @Unidad, @Lanzamiento, @OrdenProduccion, @ContUso, @ContUso2, @Lanzamiento)
				
				FETCH NEXT FROM crMesCompraD INTO @Renglon, @Articulo, @SubCuenta, @FechaRequeridaD, @FechaEntrega, @Cantidad, @Costo, @CostoInv, @PorcIVA, @Unidad, @ArtTipo, @Lanzamiento, @OrdenProduccion
			END
			
			CLOSE crMesCompraD
			DEALLOCATE crMesCompraD
			
	--		EXEC spAfectar 'COMS', @IDCompra, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
			
		END

	  UPDATE CompraMes SET EstatusIntelIMES = 1, ModuloID = @IDCompra
     WHERE Serie = @Serie AND NumerodePedido = @Numero AND Lanzamiento = @Lanzamiento AND Proveedor = @Proveedor

    UPDATE CompraDMes SET CantidadPendiente = Cantidad, ModuloID = @IDCompra
	  FROM Art a	   
     WHERE Serie = @Serie AND NumerodePedido = @Numero AND Lanzamiento = @Lanzamiento --AND Almacen = @Almacen
	   AND CompraDMes.Articulo = a.Articulo AND a.TipoArticulo = '3' AND a.AlmMesComs = @AlmacenArt
		
		FETCH NEXT FROM crMesCompra INTO @Serie, @Numero, @Lanzamiento, @Proveedor, @Moneda, @Almacen, @AlmacenArt--, @Proveedor, @FechaEmision, @FechaRequerida, @Referencia, @Condicion, @Moneda, @Almacen, @SucursalMov
	END
	
	CLOSE crMesCompra
	DEALLOCATE crMesCompra

	CREATE TABLE #MesInv(
	ID               int,
	Cliente			varchar(10),
	OrdenProduccion  varchar(100) NULL,
	Almacen          varchar(10)  NULL,
	Articulo         varchar(20)  NULL,
	SubCuenta        varchar(50)  NULL,
	Cantidad         float        NULL,
	Lanzamiento      varchar(50)  NULL,
	Lote             varchar(20)  NULL,
  Moneda           varchar(10)  NULL,
  Unidad           varchar(50)  NULL,
	Costo            money        NULL,
	CosteMaquinaria  money        NULL,
	CosteMaterial    money        NULL,
	CosteIndirecto   money        NULL,
	CosteOperarios   money        NULL,
	FechaRequerida   datetime     NULL,
	Proyecto         varchar(50)  NULL,
	SubProyecto      varchar(50)  NULL)
  
 	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = 'Entrada Produccion')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('INV', 'Entrada Produccion', 2000, 'INV.E', NULL,    'INV',             'Entrada Produccion', 1     )
	
	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = 'Consumo Produccion')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('INV', 'Consumo Produccion', 2010, 'INV.S', NULL,    'INV',             'Consumo Produccion', 1     )
	  
	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'COMS' AND mt.Mov = 'EntradaCompraMaquila')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('COMS', 'EntradaCompraMaquila', 50, 'COMS.EG', NULL,    'CXP',             'EntradaCompraMaquila', 1     )

	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'CXP' AND mt.Mov = 'EntradaCompraMaquila')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('CXP', 'EntradaCompraMaquila', 50, 'CXP.F', NULL,    'CXP',             'EntradaCompraMaquila', 1     )

/*
	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'COMS' AND mt.Mov = 'Servicio Maquila')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('COMS', 'Servicio Maquila', 40, 'COMS.O', NULL,    'COMS',             'Servicio Maquila', 1     )

	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'COMS' AND mt.Mov = 'Recibo Maquila')
	  INSERT INTO MovTipo
	        (Modulo, Mov,                 Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	  VALUES('COMS', 'Recibo Maquila', 50, 'COMS.CP', NULL,    'COMS',             'Recibo Maquila', 1     )
*/
/*
	SELECT @MovInvE = ecm.InvEntradaDiversa,
	       @MovInvS = ecm.InvSalidaDiversa
	  FROM EmpresaCfgMov ecm 
	 WHERE ecm.Empresa = @Empresa
	*/
	
	SELECT @MovInvE = 'Entrada Produccion'
	SELECT @MovInvS = 'Consumo Produccion'
	
	SELECT @FechaEmision = GETDATE()
	EXEC spExtraerFecha @FechaEmision OUTPUT
	
	SELECT @CfgMultiUnidades         = MultiUnidades, 
	       @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
	  FROM EmpresaCfg2 
	 WHERE Empresa = @Empresa

  -- Entradas
	INSERT INTO #MesInv
	         (ID, Almacen, Articulo, SubCuenta, Cantidad, Lanzamiento, Lote, Moneda, Unidad, Costo, CosteMaquinaria, CosteMaterial, CosteIndirecto, CosteOperarios, OrdenProduccion, Proyecto, SubProyecto,Cliente)
   SELECT mm.ID, mm.Almacen, mm.Articulo, mm.SubCuenta, mm.Cantidad, mm.Lanzamiento, mm.Lote, ISNULL(m.Descripcion, 'Pesos'), um.Descripcion, 
   ((ISNULL(mm.CosteOperarios, 0) + ISNULL(mm.CosteMaterial, 0) + ISNULL(mm.CosteIndirecto, 0) + ISNULL(mm.CosteMaquinaria, 0))/mm.cantidad), 
   CosteMaquinaria, CosteMaterial, CosteIndirecto, CosteOperarios,
   mm.OrdenProduccion, mm.Proyecto, mm.SubProyecto, '1'
   FROM MovMES mm
   LEFT OUTER JOIN MonMES m ON mm.Moneda = m.Moneda
   LEFT OUTER JOIN UnidadMes um ON mm.Unidad = um.UnidadMedida
  WHERE mm.ProcesadoINTELISIS = 0
    AND mm.Direccion = 'E'
	
/*  
SELECT mm.ID, mm.Almacen, mm.Articulo, mm.SubCuenta, mm.Cantidad, mm.Lanzamiento, mm.Lote, ISNULL(m.Descripcion, 'Pesos'), um.Descripcion, 
--   ISNULL(mm.PrecioCosteMedio, 0) /*ISNULL(mm.CosteOperarios, 0) + ISNULL(mm.CosteMaterial, 0) + ISNULL(mm.CosteIndirecto, 0) + ISNULL(mm.CosteMaquinaria, 0)*/, 
/*   ISNULL(mm.PrecioCosteMedio, 0)*/ 
   ISNULL(mm.CosteOperarios, 0) + ISNULL(mm.CosteMaterial, 0) + ISNULL(mm.CosteIndirecto, 0) + ISNULL(mm.CosteMaquinaria, 0), 
   mm.OrdenProduccion, mm.Proyecto, mm.SubProyecto, '1'
	  FROM MovMES mm
	  LEFT OUTER JOIN MonMES m ON mm.Moneda = m.Moneda
	  LEFT OUTER JOIN UnidadMes um ON mm.Unidad = um.UnidadMedida
	 WHERE mm.ProcesadoINTELISIS = 0
	   AND mm.Direccion = 'E'
*/	   
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda = 'PES'
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda <> 'Pesos'

	DECLARE crMesInv CURSOR FOR
--	SELECT mi.Almacen, mi.Moneda, 'Lanz:' + RTRIM(mi.Lanzamiento) + ' Lote:' + RTRIM(mi.Lote)
	SELECT mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto
	  FROM #MesInv mi
	 GROUP BY mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto
	 
	OPEN crMesInv
	FETCH NEXT FROM crMesInv INTO @Almacen, @Moneda, @Referencia, @Proyecto
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		SELECT @IDInv = NULL
		SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
		-- SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = 'Pesos'
		
		INSERT INTO Inv(Empresa, Mov, FechaEmision, Referencia, Moneda, TipoCambio, Usuario, Estatus, Almacen, OrigenTipo, Sucursal, Proyecto, MesLanzamiento)
		VALUES(@Empresa, @MovInvE, @FechaEmision, @Referencia, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, 'MES', @Sucursal, @Proyecto, @Referencia)

		SELECT @IDInv = @@IDENTITY
		SELECT @Renglon = 0, @RenglonID = 0

--        insert Into RastreoError (ClaveProyecto) Values (@IDInv)
		IF @IDInv IS NOT NULL
		BEGIN

			DECLARE crMesInvD CURSOR FOR
			 SELECT mi.ID, mi.Articulo, mi.SubCuenta, mi.Cantidad, mi.Lote, mi.Unidad, mi.Costo, mi.CosteMaquinaria,
			        mi.CosteMaterial, mi.CosteIndirecto, mi.CosteOperarios, a.Tipo, mi.OrdenProduccion
			   FROM #MesInv mi
			   JOIN Art a ON mi.Articulo = a.Articulo
			  WHERE mi.Almacen = @Almacen
			    AND mi.Moneda = @Moneda
			    --AND 'Lanz:' + RTRIM(mi.Lanzamiento) + ' Lote:' + RTRIM(mi.Lote) = @Referencia
			    AND mi.Lanzamiento = @Referencia
			    AND mi.Proyecto = @Proyecto
			  
			OPEN crMesInvD
			FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @CosteMaquinaria, @CosteMaterial, @CosteIndirecto, @CosteOperarios, @ArtTipo, @OrdenProduccion
			WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
			BEGIN
				SELECT @Costo = (@Costo/@TipoCambio)*dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)
				
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 1048, @RenglonID = @RenglonID + 1

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

        /*  jsmv Actualizar InvD en Espacios id de MovMes / prodserielote = lote de MES */

				INSERT INTO InvD
				       (ID,     Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo,  SubCuenta,  Costo, Unidad, Espacio, ProdSerieLote, MesLanzamiento, MesProdCostoMaquinaria, MesProdCostoConsumoMat, MesProdCostoIndirecto, MesProdCostoManoObra)
				VALUES(@IDInv, @Renglon, 0,         @RenglonID, @RenglonTipo, @Cantidad, @CantidadInventario, @Almacen, @Articulo, @SubCuenta, @Costo, @Unidad, CAST(@id as VARCHAR), @Lote, @Referencia, @CosteMaquinaria, @CosteMaterial, @CosteIndirecto, @CosteOperarios)

			  SELECT @IDReserva = NULL,  @RenglonReserva = NULL
			  SELECT TOP 1 @IDReserva  = vdm.ID,  @RenglonReserva = vdm.Renglon
			    FROM	VentaMES vm
			   INNER JOIN VentaDMES vdm ON vdm.id = vm.ID
			   WHERE	vdm.Lanzamiento	= @Referencia AND vdm.Articulo	= @Articulo

--			SELECT * FROM DYBITACORA
--			TRUNCATE TABLE DYBITACORA
---	 	  INSERT INTO DYBITACORA(ID1, renglon1,  T1, t2) VALUES (@IDReserva, @RenglonReserva,  @Referencia, @Articulo)
/*
			  IF @IDReserva > 0  and @RenglonReserva > 0
			  BEGIN
			  
          UPDATE  Venta 
          SET     Situacion = 'Autorizado'
          WHERE   ID = @IDReserva


			    UPDATE VentaD SET	Espacio = CAST(@IDReserva as varchar), CantidadA = @Cantidad , CantidadOrdenada = null, CantidadPendiente = @Cantidad
			     WHERE ID = @IDReserva AND Renglon = @RenglonReserva

			    EXEC spAfectar 'VTAS', @IDReserva, 'RESERVAR', 'Seleccion', null, @Usuario  --, 0, 1, @Ok OUTPUT, @OkRef output, 1

          UPDATE  Venta 
          SET     Situacion = 'Autorizado x Cobranza'
          WHERE   ID = @IDReserva

			  END
*/				
				IF @RenglonTipo = 'L'
				BEGIN
					SELECT @Propiedades = RTRIM(YEAR(@FechaEmision)) + '-' + RTRIM(MONTH(@FechaEmision)) + '-' + RTRIM(DAY(@FechaEmision))
					IF NOT EXISTS(SELECT * FROM SerieLoteProp slp WHERE slp.Propiedades = @Propiedades)
					  INSERT INTO SerieLoteProp(Propiedades, Extra1, Extra2, Fecha1)
					  VALUES(@Propiedades, @Lote, @OrdenProduccion, @FechaEmision)
					
				  INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Propiedades)
				  VALUES(@Empresa, 'INV', @IDInv, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @Lote, @Cantidad, @Propiedades)
				END

        UPDATE MovMES SET ProcesadoINTELISIS = 1 WHERE ID = @ID			
				
				FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @CosteMaquinaria, @CosteMaterial, @CosteIndirecto, @CosteOperarios, @ArtTipo, @OrdenProduccion
			END
			
			CLOSE crMesInvD
			DEALLOCATE crMesInvD

			EXEC spAfectar 'INV', @IDInv, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 0

		END
		
		FETCH NEXT FROM crMesInv INTO @Almacen, @Moneda, @Referencia, @Proyecto
	END
	
	CLOSE crMesInv
	DEALLOCATE crMesInv
	
	DELETE FROM #MesInv
	
	-- Salida
	INSERT INTO #MesInv
	         (ID, Almacen, Articulo, SubCuenta, Cantidad, Lanzamiento, Lote, Moneda, Unidad, Proyecto,Cliente)
	SELECT mm.ID, mm.Almacen, mm.Articulo, mm.SubCuenta, mm.Cantidad, mm.Lanzamiento, mm.Lote, ISNULL(m.Descripcion, 'Pesos'), um.Descripcion, mm.Proyecto,'1'
	  FROM MovMES mm
	  LEFT OUTER JOIN MonMES m ON mm.Moneda = m.Moneda
	  LEFT OUTER JOIN UnidadMes um ON mm.Unidad = um.UnidadMedida
	 WHERE mm.ProcesadoINTELISIS = 0
	   AND mm.Direccion = 'S'
	   
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda = 'PES'
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda <> 'Pesos'

	DECLARE crMesInv CURSOR FOR
	-- SELECT mi.Almacen, mi.Moneda, 'Lanz:' + RTRIM(mi.Lanzamiento) + ' Lote:' + RTRIM(mi.Lote)
	SELECT mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto
	  FROM #MesInv mi
	 GROUP BY mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto
	 
	OPEN crMesInv
	FETCH NEXT FROM crMesInv INTO @Almacen, @Moneda, @Referencia, @Proyecto
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		SELECT @IDInv = NULL
		-- SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
		SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = 'Pesos'

--        insert Into RastreoError (ClaveProyecto) Values (@Proyecto)
		
		INSERT INTO Inv(Empresa, Mov, FechaEmision, Referencia, Moneda, TipoCambio, Usuario, Estatus, Almacen, OrigenTipo, Sucursal, Proyecto, MesLanzamiento)
		VALUES(@Empresa, @MovInvS, @FechaEmision, @Referencia, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, 'MES', @Sucursal, @Proyecto, @Referencia)

		SELECT @IDInv = @@IDENTITY
		SELECT @Renglon = 0, @RenglonID = 0

		IF @IDInv IS NOT NULL
		BEGIN

			DECLARE crMesInvD CURSOR FOR
			 SELECT mi.ID, mi.Articulo, mi.SubCuenta, mi.Cantidad, mi.Lote, mi.Unidad, mi.Costo, a.Tipo
			   FROM #MesInv mi
			   JOIN Art a ON mi.Articulo = a.Articulo
			  WHERE mi.Almacen = @Almacen
			    AND mi.Moneda = @Moneda
			    AND RTRIM(mi.Lanzamiento) = @Referencia
			    AND mi.Proyecto = @Proyecto
			  
			OPEN crMesInvD
			FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @ArtTipo
			WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
			BEGIN
				
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 1048, @RenglonID = @RenglonID + 1

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

				INSERT INTO InvD
				       (ID,     Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  Almacen,  Articulo, SubCuenta,  Costo, Unidad, MesLanzamiento)
				VALUES(@IDInv, @Renglon, 0,         @RenglonID, @RenglonTipo, @Cantidad, @Almacen, @Articulo, @SubCuenta, @Costo, @Unidad, @Referencia)
				
				IF @RenglonTipo = 'L'
				  INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad)
				  VALUES(@Empresa, 'INV', @IDInv, @RenglonID, @Articulo, @SubCuenta, @Lote, @Cantidad)

        UPDATE MovMES SET ProcesadoINTELISIS = 1 WHERE ID = @ID			
				
				FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @ArtTipo
			END
			
			CLOSE crMesInvD
			DEALLOCATE crMesInvD

			EXEC spAfectar 'INV', @IDInv, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 0

		END
		
		FETCH NEXT FROM crMesInv INTO @Almacen, @Moneda, @Referencia, @Proyecto
	END
	
	CLOSE crMesInv
	DEALLOCATE crMesInv

	DELETE FROM #MesInv
	
	  -- Cotizacion
	INSERT INTO #MesInv
	         (ID,    Cliente,  Almacen,          Articulo,    SubCuenta,    Cantidad,          Lanzamiento, Lote,           Moneda,							      Unidad,			  Costo,                FechaRequerida,           Proyecto,     SubProyecto)
	SELECT cm.ID, cm.Cliente, cd.AlmacenSalida, cd.Articulo, cd.SubCuenta, cd.CantidadPedida, cd.Lanzamiento, NULL, ISNULL(m.Descripcion, 'Pesos'), um.Descripcion, cd.PrecioIntroducido, cd.FechaEntregaRequerida, cd.Proyecto, cd.SubProyecto
	  FROM CotizaMes cm
	  JOIN CotizaDMES cd ON cm.ID = cd.ID
	  LEFT OUTER JOIN MonMES m ON cm.Moneda = m.Moneda
	  LEFT OUTER JOIN UnidadMes um ON cd.UnidadPedida = um.UnidadMedida
	WHERE cm.EstatusIntelIMES = 0

/*
	SELECT mm.ID, mm.Almacen, mm.Articulo, mm.SubCuenta, mm.Cantidad, mm.Lanzamiento, mm.Lote, ISNULL(m.Descripcion, 'Pesos'), um.Descripcion, ISNULL(mm.PrecioCosteMedio, 0) /*ISNULL(mm.CosteOperarios, 0) + ISNULL(mm.CosteMaterial, 0) + ISNULL(mm.CosteIndirecto, 0) + ISNULL(mm.CosteMaquinaria, 0)*/, mm.OrdenProduccion, mm.Proyecto
	  FROM MovMES mm
	  LEFT OUTER JOIN MonMES m ON mm.Moneda = m.Moneda
	  LEFT OUTER JOIN UnidadMes um ON mm.Unidad = um.UnidadMedida
	 WHERE mm.ProcesadoINTELISIS = 0
	   AND mm.Direccion = 'C'
	*/   
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda = 'PES'
	-- UPDATE #MesInv	SET Moneda = 'Pesos' WHERE Moneda <> 'Pesos'

	DECLARE crMesInv CURSOR FOR
--	SELECT mi.Almacen, mi.Moneda, 'Lanz:' + RTRIM(mi.Lanzamiento) + ' Lote:' + RTRIM(mi.Lote)
	SELECT mi.Cliente, mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto, mi.SubProyecto
	  FROM #MesInv mi
	 GROUP BY mi.Cliente, mi.Almacen, mi.Moneda, RTRIM(mi.Lanzamiento), mi.Proyecto, mi.SubProyecto
	 
	OPEN crMesInv
	FETCH NEXT FROM crMesInv INTO @Cliente, @Almacen, @Moneda, @Referencia, @Proyecto, @SubProyecto
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		SELECT @IDInv = NULL, @Origen = NULL, @OrigenID = NULL
		SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
		-- SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = 'Pesos'
		
-- Aqui HMH

        --insert Into RastreoError (ClaveProyecto) Values (@SubProyecto)

		SELECT top 1 @Origen = Mov, @OrigenID = MovID, @IDOport = ID FROM Oportunidad WHERE Estatus = 'REVISION' AND Proyecto = @SubProyecto
		
		INSERT INTO Venta(Empresa, Mov, Cliente, FechaEmision, Referencia, Moneda, TipoCambio, Usuario, Estatus, Almacen, OrigenTipo, Sucursal, Proyecto, Origen, OrigenID, IDOport, FechaRequerida, Condicion, FormaPagoTipo, MesLanzamiento)
		VALUES(@Empresa, 'Cotizacion', @Cliente, @FechaEmision, @Referencia, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, 'OPORT', @Sucursal, @Proyecto, @Origen, @OrigenID, @IDOport, (@FechaEmision+7), '(Fecha)', 'TRANSFERENCIA', @Referencia)

		SELECT @IDInv = @@IDENTITY
		SELECT @Renglon = 0, @RenglonID = 0

		IF @IDInv IS NOT NULL
		BEGIN

			DECLARE crMesInvD CURSOR FOR
			 SELECT mi.ID, mi.Articulo, mi.SubCuenta, mi.Cantidad, mi.Lote, mi.Unidad, mi.Costo, a.Tipo, mi.FechaRequerida, mi.SubProyecto
			   FROM #MesInv mi
			   JOIN Art a ON mi.Articulo = a.Articulo
			  WHERE mi.Cliente = @Cliente
			    AND mi.Almacen = @Almacen
			    AND mi.Moneda = @Moneda
			    --AND 'Lanz:' + RTRIM(mi.Lanzamiento) + ' Lote:' + RTRIM(mi.Lote) = @Referencia
			    AND mi.Lanzamiento = @Referencia
			    AND mi.Proyecto = @Proyecto
			    AND a.Situacion = 'MES'
			  
			OPEN crMesInvD
			FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @ArtTipo, @FechaRequerida, @SubProyecto
			WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
			BEGIN
				SELECT @Costo = (@Costo/@TipoCambio)*dbo.fnArtUnidadFactor(@Empresa, @Articulo, @Unidad)

        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 1048, @RenglonID = @RenglonID + 1

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

				INSERT INTO VentaD
				       (ID,     Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  Almacen,  Articulo,  SubCuenta,  Precio, Unidad, ABC, FechaRequerida, MesLanzamiento)
				VALUES(@IDInv, @Renglon, 0,         @RenglonID, @RenglonTipo, @Cantidad, @Almacen, @Articulo, @SubCuenta, @Costo, @Unidad, @SubProyecto, @FechaRequerida, @Referencia)
				/*
				IF @RenglonTipo = 'L'
				BEGIN
					SELECT @Propiedades = RTRIM(YEAR(@FechaEmision)) + '-' + RTRIM(MONTH(@FechaEmision)) + '-' + RTRIM(DAY(@FechaEmision))
					IF NOT EXISTS(SELECT * FROM SerieLoteProp slp WHERE slp.Propiedades = @Propiedades)
					  INSERT INTO SerieLoteProp(Propiedades, Extra1, Extra2, Fecha1)
					  VALUES(@Propiedades, @Lote, @OrdenProduccion, @FechaEmision)
					
				  INSERT INTO SerieLoteMov(Empresa, Modulo, ID, RenglonID, Articulo, SubCuenta, SerieLote, Cantidad, Propiedades)
				  VALUES(@Empresa, 'INV', @IDInv, @RenglonID, @Articulo, ISNULL(@SubCuenta, ''), @Lote, @Cantidad, @Propiedades)
				END*/
				
				FETCH NEXT FROM crMesInvD INTO @ID, @Articulo, @SubCuenta, @Cantidad, @Lote, @Unidad, @Costo, @ArtTipo, @FechaRequerida, @SubProyecto
			END
			
			CLOSE crMesInvD
			DEALLOCATE crMesInvD
			
			--UPDATE MovMES SET ProcesadoINTELISIS = 1 WHERE ID = @ID
			UPDATE CotizaMES SET EstatusIntelIMES = 1 WHERE ID = @ID

			EXEC spAfectar 'VTAS', @IDInv, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 0

		END
		
		FETCH NEXT FROM crMesInv INTO @Cliente, @Almacen, @Moneda, @Referencia, @Proyecto, @SubProyecto
	END
	
	CLOSE crMesInv
	DEALLOCATE crMesInv
	
	DELETE FROM #MesInv
	
--  IF @Ok IS NULL
  --BEGIN
  	--COMMIT TRAN
  	SELECT 'Proceso Concluido'
  --END
  --ELSE
  --BEGIN
  --	SELECT @Mensaje = ml.Descripcion FROM MensajeLista ml WHERE ml.Mensaje = @Ok
  --	SELECT @Mensaje = RTRIM(@Mensaje) + '. ' + RTRIM(@OkRef)
  --	SELECT @Mensaje
  --	ROLLBACK TRAN
  --END
	
	RETURN
END
GO

/********************* xpMESMovFinal **********************/
if exists (select * from sysobjects where id = object_id('dbo.xpMESMovFinal') and type = 'P') drop procedure dbo.xpMESMovFinal
GO             
CREATE PROCEDURE xpMESMovFinal
    @Empresa		    char(5),
    @Sucursal		    int,
    @Modulo		      char(5),
    @ID			        int,
    @Estatus		    char(15),
    @EstatusNuevo	  char(15),
    @Usuario		    char(10),
    @FechaEmision	  datetime,
    @FechaRegistro	datetime,
    @Mov			      char(20),
    @MovID		      varchar(20),
    @MovTipo		    char(20),
    @IDGenerar		  int,
    @Ok			        int		        OUTPUT,
    @OkRef		      varchar(255)	OUTPUT
AS
BEGIN
	DECLARE
	@Origen           varchar(20),
	@OrigenID         varchar(20),
	@CompraID         int,
	@GastoID          int,
	@InvID            int,
	@IDMES            int,
	@CantidadRecibo   float,
	@Factor           int,
	@Directo          bit,
	@Articulo         varchar(20),
	@Cantidad         float,
	@CantidadA        float,
	@CantidadInventario       float,
	@Renglon          float,
	@CantidadAplica   float,
	@FormadePago      varchar(50),
	@Almacen          varchar(10),
	@IDSalida         int,
	@MovSalida        varchar(20),
	@Unidad           varchar(50),
	@ArtTipo          varchar(20),
	@RenglonTipo      varchar(1),
	@CfgMultiUnidades	      	bit,
  @CfgMultiUnidadesNivel		varchar(20),
	
/*  jsmv  Centro de Costos */
	@ContUso	      varchar(20),
	@ContUso2         varchar(20),
  @OrigenTipo       varchar(10),
  @Lanzamiento      varchar(100)

	IF @Modulo = 'COMS'
	BEGIN
		-- Cancelar orden de compra
		IF @MovTipo = 'COMS.O' AND @Estatus IN ('PENDIENTE') AND @EstatusNuevo IN ('CANCELADO')
		BEGIN
			UPDATE CompraMes SET ModuloID = NULL, EstatusIntelIMES = 0, Cancelado = 1 WHERE ModuloID = @ID
		END
		ELSE
		-- Afectar/cancelar entrada con origen orden
--SELECT 5, @MovTipo, @Estatus, @EstatusNuevo
		IF @MovTipo IN ('COMS.CC', 'COMS.FL', 'COMS.F', 'COMS.EG', 'COMS.EI', 'COMS.CP') AND @Estatus IN ('SINAFECTAR', 'CONCLUIDO') AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO')
		BEGIN
		  IF @EstatusNuevo = 'CANCELADO' OR @MovTipo = 'COMS.CP' SELECT @Factor = -1 ELSE SELECT @Factor = 1
		  
		  SELECT @Directo = ISNULL(c.Directo, 0) FROM Compra c WHERE c.ID = @ID

		  IF @Directo = 0
		  BEGIN
		  	CREATE TABLE #CompraDMesAplica(
		  	AplicaID          int,
		  	Articulo          varchar(20),
		  	Cantidad          float)
		  	
		  	INSERT INTO #CompraDMesAplica(AplicaID, Articulo, Cantidad)
		  	SELECT c.ID, cd.Articulo, SUM(cd.Cantidad)
          FROM CompraD cd
          JOIN Compra c ON cd.Aplica = c.Mov AND cd.AplicaID = c.MovID
          JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS' AND mt.Clave = 'COMS.O'
         WHERE cd.ID = @ID
           AND NULLIF(RTRIM(cd.Aplica), '') IS NOT NULL AND NULLIF(RTRIM(cd.AplicaID), '') IS NOT NULL
         GROUP BY c.ID, cd.Articulo
         
        DECLARE crCompraDMesAplica CURSOR FOR
        SELECT cda.AplicaID, cda.Articulo, cda.Cantidad
          FROM #CompraDMesAplica cda
          
        OPEN crCompraDMesAplica
        FETCH next FROM crCompraDMesAplica INTO @CompraID, @Articulo, @Cantidad
        WHILE @@FETCH_STATUS = 0
        BEGIN
--SELECT 20, @CompraID, @Articulo, @Cantidad
        	IF @EstatusNuevo = 'CANCELADO'
        	  DECLARE crCompraDMesAplicaD CURSOR FOR
        	  SELECT cd.ID, cd.Renglon, cd.CantidadRecibida
        	    FROM CompraMES cm
        	    JOIN CompraDMES cd ON cm.ID = cd.ID
        	   WHERE cm.ModuloID = @CompraID
        	     AND cd.Articulo = @Articulo
        	     AND ISNULL(cd.CantidadRecibida, 0) > 0
          ELSE
          	DECLARE crCompraDMesAplicaD CURSOR FOR
        	  SELECT cd.ID, cd.Renglon, cd.CantidadPendiente
        	    FROM CompraMES cm
        	    JOIN CompraDMES cd ON cm.ID = cd.ID
        	   WHERE cm.ModuloID = @CompraID
        	     AND cd.Articulo = @Articulo
        	     AND ISNULL(cd.CantidadPendiente, 0) > 0
        	     
        	OPEN crCompraDMesAplicaD
        	FETCH next FROM crCompraDMesAplicaD INTO @IDMES, @Renglon, @CantidadA
        	WHILE @@FETCH_STATUS = 0 AND @Cantidad > 0
        	BEGIN
--SELECT 30, @IDMES, @Renglon, @CantidadA
        		IF @Cantidad > @CantidadA
        		  SELECT @CantidadAplica = @CantidadA
        		ELSE
        			SELECT @CantidadAplica = @Cantidad
--SELECT 40, @CantidadAplica
        		IF @MovTipo = 'COMS.CP'
         		  UPDATE CompraDMes SET CantidadPendiente = ISNULL(CantidadPendiente, 0) - @CantidadAplica, EstatusIntelIMES = 2
         		  WHERE ID = @IDMES AND Renglon = @Renglon
            ELSE
        		  UPDATE CompraDMes SET CantidadRecibida = ISNULL(CantidadRecibida, 0) + (@CantidadAplica*@Factor), CantidadPendiente = ISNULL(CantidadPendiente, 0) - (@CantidadAplica*@Factor), EstatusIntelIMES = 2
        		   WHERE ID = @IDMES AND Renglon = @Renglon
--SELECT 50, * FROM CompraDMes WHERE ID = @IDMES AND Renglon = @Renglon
        		SELECT @Cantidad = @Cantidad - @CantidadAplica
 
        		FETCH next FROM crCompraDMesAplicaD INTO @IDMES, @Renglon, @CantidadA
        	END
        	
        	CLOSE crCompraDMesAplicaD
        	DEALLOCATE crCompraDMesAplicaD

          UPDATE CompraMes SET Entrada = 1 WHERE ModuloID = @CompraID
        	 
        	FETCH next FROM crCompraDMesAplica INTO @CompraID, @Articulo, @Cantidad
        END
        
        CLOSE crCompraDMesAplica
        DEALLOCATE crCompraDMesAplica
        
		END
		  
		END

    /*
		IF @MovTipo = 'COMS.CP' AND @Mov = 'Recibo Maquila' AND @Estatus IN ('SINAFECTAR', 'CONCLUIDO') AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO')
		BEGIN
	
			IF @EstatusNuevo = 'CANCELADO'
			BEGIN
				SELECT @GastoID = ID FROM Gasto g WHERE g.Mov = 'Gasto' AND g.OrigenTipo = 'COMS' AND g.Origen = @Mov AND g.OrigenID = @MovID AND g.Estatus = 'CONCLUIDO'
				IF @GastoID IS NOT NULL
				  EXEC spAfectar 'GAS', @GastoID, 'CANCELAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
			END
			ELSE
			BEGIN

				IF NOT EXISTS(SELECT * FROM Concepto c WHERE c.Modulo = 'GAS' AND c.Concepto = 'Maquila')
				  INSERT INTO Concepto(Modulo, Concepto, EsDeducible, Impuestos, MonedaCosto)
				  VALUES('GAS', 'Maquila', 1, 16, 'Pesos')
				  
				INSERT INTO Gasto
				        (Empresa, Mov,       FechaEmision,   Moneda,   TipoCambio,  Usuario, Estatus,        Acreedor, Observaciones, SubModulo, Sucursal, SucursalOrigen, SucursalDestino, MesLanzamiento)
				SELECT c.Empresa, 'Gasto', c.FechaEmision, c.Moneda, c.TipoCambio, @Usuario, 'SINAFECTAR', c.Proveedor, c.Referencia, 'GAS', c.Sucursal, c.SucursalOrigen, c.SucursalDestino, c.MesLanzamiento
				  FROM Compra c
				 WHERE c.ID = @ID
				 
				SELECT @GastoID = @@IDENTITY

				IF @GastoID IS NULL
				  SELECT @Ok = 10060, @OkRef = 'No se Generó el Gasto'
				ELSE
				BEGIN
					INSERT INTO GastoD
					       (ID,         Renglon,    RenglonSub, Concepto,    Fecha,          Referencia,    Cantidad, Precio,                Importe,                     Impuestos,                            Impuesto1, Sucursal, SucursalOrigen)
					SELECT @GastoID, cd.Renglon, cd.RenglonSub, 'Maquila', c.FechaEmision, c.Referencia, cd.Cantidad, ap.CostoAutorizado, cd.Cantidad*ap.CostoAutorizado, cd.Cantidad*ap.CostoAutorizado*1.16, 0.16, c.Sucursal, c.SucursalOrigen
					  FROM Compra c
					  JOIN CompraD cd ON c.ID = cd.ID
					  JOIN ArtProv ap ON ap.Articulo = cd.Articulo AND ap.Proveedor = c.Proveedor
					 WHERE c.ID = @ID

					EXEC spAfectar 'GAS', @GastoID, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1

          IF @OK = 80010 SELECT @OK = NULL
					IF @Ok = NULL
					BEGIN
						
					 	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = 'Entrada Maquila')
	            INSERT INTO MovTipo
	                  (Modulo, Mov,              Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	            VALUES('INV', 'Entrada Maquila', 100, 'INV.E', NULL,    'INV',             'Entrada Maquila', 1     )

            INSERT INTO Inv
                    (Empresa, Mov,                 FechaEmision,   Moneda,   TipoCambio,  Usuario,   Referencia, Estatus,        Almacen, OrigenTipo, Origen, OrigenID, Sucursal,   SucursalOrigen,   SucursalDestino, MesLanzamiento)
            SELECT c.Empresa, 'Entrada Maquila', c.FechaEmision, c.Moneda, c.TipoCambio, @Usuario, c.Referencia, 'SINAFECTAR', c.Almacen, 'COMS',   c.Mov,  c.MovID,  c.Sucursal, c.SucursalOrigen, c.SucursalDestino, c.MesLanzamiento
              FROM Compra c
            WHERE ID = @ID

            SELECT @InvID = @@IDENTITY

				    IF @InvID IS NULL
				      SELECT @Ok = 10060, @OkRef = 'No se Generó la Entrada'
				    ELSE
				    BEGIN
					    INSERT INTO InvD
					           (ID,       Renglon,    RenglonSub,    RenglonID,    RenglonTipo,    Cantidad,    Unidad, Almacen,    Articulo,    Costo,    Factor,   Sucursal,   SucursalOrigen, MesLanzamiento)
					    SELECT @InvID, cd.Renglon, cd.RenglonSub, cd.RenglonID, cd.RenglonTipo, cd.Cantidad, cd.Unidad, c.Almacen, cd.Articulo, cd.Costo, cd.Factor, c.Sucursal, c.SucursalOrigen, c.MesLanzamiento
					      FROM Compra c
					      JOIN CompraD cd ON c.ID = cd.ID
					     WHERE c.ID = @ID

					    EXEC spAfectar 'INV', @InvID, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1

				    END
				    
            IF @OK = 80010 SELECT @OK = NULL
					  IF @Ok = NULL
					  BEGIN
  					 	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = 'SalidaMPMaquila')
	            INSERT INTO MovTipo
	                  (Modulo, Mov,              Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
	            VALUES('INV', 'SalidaMPMaquila', 200, 'INV.S', NULL,    'INV',             'SalidaMPMaquila', 1     )

              CREATE TABLE #MesSalidaPadre(
              Articulo        varchar(20),
              Cantidad        money,
              Unidad          varchar(50)   NULL,
              Almacen         varchar(10))

 	            -- Salida Padre
              INSERT INTO #MesSalidaPadre(Articulo, Cantidad, Unidad, Almacen)
              SELECT mt.Padre, mt.CantidadTotalPadre, mt.UnidMedidaAlmacen, mt.AlmacenDefecto ---a.AlmMesComs, a.AlmacenROP
                FROM PrevisionesConsumoMES mt
                JOIN Art a ON mt.Padre = a.Articulo
               WHERE ISNULL(mt.EstatusIntelIMES, 0) = 1
                 AND NULLIF(RTRIM(mt.AlmacenDefecto), '') IS NOT NULL
                 AND ISNULL(mt.FaseConsumo, 0) = '999'
     
              DECLARE crMesSalidaPadre CURSOR FOR
              SELECT mt.Almacen
                FROM #MesSalidaPadre mt
              GROUP BY mt.Almacen
               
              OPEN crMesSalidaPadre
              FETCH NEXT FROM crMesSalidaPadre INTO @Almacen
              WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
              BEGIN
  	            SELECT @IDSalida = NULL

            --	INSERT INTO dyBitacora (CAMPO01) VALUES ( @MovTransfer)
              	
  	            INSERT INTO Inv(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Almacen, Sucursal, MesLanzamiento)
		            SELECT @Empresa, 'SalidaMPMaquila', c.FechaEmision, c.Moneda, c.TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, @Sucursal, c.MesLanzamiento
            		  FROM Compra c
            		  WHERE c.ID = @ID
            		  
		            SELECT @IDSalida = @@IDENTITY
            		
		            IF @IDSalida IS NOT NULL
		            BEGIN
			            SELECT @Renglon = 2048
            			
                  DECLARE crMesSalidaPadreD CURSOR FOR
            --      SELECT mt.ID, mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
                  SELECT mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
                    FROM #MesSalidaPadre mt
                    JOIN Art a ON mt.Articulo = a.Articulo
                   WHERE mt.Almacen = @Almacen
            			
                  OPEN crMesSalidaPadreD
            --      FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
                  FETCH next FROM crMesSalidaPadreD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
                  WHILE @@FETCH_STATUS = 0
                  BEGIN
               	
                    EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
                    SELECT @Renglon = @Renglon + 2048

                    EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

                    /*  jsmv Actualizar InvD en Espacios id de MovMes / prodserielote = lote de MES */

				            INSERT INTO InvD
				                   (ID,          Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo, Unidad)
				            VALUES(@IDSalida, @Renglon, 0,         0,          @RenglonTipo, @Cantidad, @CantidadInventario, @Almacen, @Articulo, @Unidad)

      	            EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT	
                  	
      	            FETCH next FROM crMesSalidaPadreD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
            --      	FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
                  END
                  
                  EXEC spAfectar 'INV', @IDSalida, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
                  
                  CLOSE crMesSalidaPadreD
                  DEALLOCATE crMesSalidaPadreD
            		  
		            END
  	            ELSE
  		            SELECT @Ok = 10060, @OkRef = 'No se generó el movimiento'
              	
  	            FETCH NEXT FROM crMesSalidaPadre INTO @Almacen
              END
              
              CLOSE crMesSalidaPadre
              DEALLOCATE crMesSalidaPadre

             	UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 2
  	            FROM Art a 
               WHERE Hijo = a.Articulo
                 AND ISNULL(EstatusIntelIMES, 0) = 1
                 AND NULLIF(RTRIM(AlmacenDefecto), '') IS NOT NULL
                 AND ISNULL(FaseConsumo, 0) = '999'

            END
					END
				END
			END
		END*/
		
  	IF @MovTipo = 'COMS.EG' AND @Mov = 'EntradaCompraMaquila' AND @Estatus IN ('SINAFECTAR', 'CONCLUIDO') AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO')
		BEGIN
	
			IF @EstatusNuevo = 'CANCELADO'
			BEGIN
				SELECT @IDSalida = ID FROM Inv g WHERE g.Mov = 'SalidaMPMaquila' AND g.OrigenTipo = 'COMS' AND g.Origen = @Mov AND g.OrigenID = @MovID AND g.Estatus = 'CONCLUIDO'
				IF @IDSalida IS NOT NULL
				BEGIN
				  EXEC spAfectar 'INV', @IDSalida, 'CANCELAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
				  
				  IF @Ok IS NULL
				    UPDATE MovFlujo SET Cancelado = 1 WHERE DModulo = 'INV' AND DID = @IDSalida AND Cancelado = 0
				END
			END
			ELSE
			BEGIN
				SELECT @Lanzamiento = c.MesLanzamiento FROM Compra c WHERE c.ID = @ID

			 	IF NOT EXISTS(SELECT mt.Clave FROM MovTipo mt WHERE mt.Modulo = 'INV' AND mt.Mov = 'SalidaMPMaquila')
        INSERT INTO MovTipo
              (Modulo, Mov,              Orden, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov,       Factor)
        VALUES('INV', 'SalidaMPMaquila', 200, 'INV.S', NULL,    'INV',             'SalidaMPMaquila', 1     )

        CREATE TABLE #MesSalidaPadre(
        Articulo        varchar(20),
        Cantidad        money,
        Unidad          varchar(50)   NULL,
        Almacen         varchar(10))

        -- Salida Padre
/*        INSERT INTO #MesSalidaPadre(Articulo, Cantidad, Unidad, Almacen)
        SELECT mt.Hijo, mt.CantidadTotalPadre, mt.UnidMedidaAlmacen, a.AlmMesComs-- mt.AlmacenDefecto ---a.AlmMesComs, a.AlmacenROP
          FROM PrevisionesConsumoMES mt
          JOIN Art a ON mt.Hijo = a.Articulo
         WHERE ISNULL(mt.EstatusIntelIMES, 0) in (0, 1, 2)
           AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
           AND ISNULL(mt.FaseConsumo, 0) = 'ext'
           AND mt.Lanzamiento = @Lanzamiento
		   */
		    INSERT INTO #MesSalidaPadre(Articulo, Cantidad, Unidad, Almacen)
        SELECT mt.Hijo, mt.CantidadTotalHijo*mt2.CantidadTotalHijo, mt.UnidMedidaAlmacen, a.AlmacenROP ---a.AlmMesComs, mt.AlmacenDefecto
          FROM CompraD d
          JOIN PrevisionesConsumoMES mt ON d.MesLanzamiento = mt.Lanzamiento AND d.Articulo = mt.Padre
          JOIN PrevisionesConsumoMES mt2 ON mt.Lanzamiento = mt2.Lanzamiento AND mt.Padre = mt2.Hijo
          JOIN Art a ON mt.Hijo = a.Articulo
         WHERE d.ID = @ID
           AND ISNULL(mt.EstatusIntelIMES, 0) in (0, 1, 2)
           AND ISNULL(mt2.EstatusIntelIMES, 0) in (0, 1, 2)
           AND NULLIF(RTRIM(mt.AlmacenDefecto), '') IS NOT NULL
           AND ISNULL(mt.FaseConsumo, 0) = 'ext'
           AND ISNULL(mt2.FaseConsumo, 0) = 'exthijo'
           AND mt.Lanzamiento = @Lanzamiento

        DECLARE crMesSalidaPadre CURSOR FOR
        SELECT mt.Almacen
          FROM #MesSalidaPadre mt
        GROUP BY mt.Almacen
         
        OPEN crMesSalidaPadre
        FETCH NEXT FROM crMesSalidaPadre INTO @Almacen
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          SELECT @IDSalida = NULL

      --	INSERT INTO dyBitacora (CAMPO01) VALUES ( @MovTransfer)
        	
          INSERT INTO Inv(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Referencia, Usuario, Estatus, Almacen, Sucursal, MesLanzamiento, OrigenTipo, Origen, OrigenID)
          SELECT @Empresa, 'SalidaMPMaquila', c.FechaEmision, c.Moneda, c.TipoCambio, @Lanzamiento, @Usuario, 'SINAFECTAR', @Almacen, @Sucursal, c.MesLanzamiento, 'COMS', @Mov, @MovID
      		  FROM Compra c
      		  WHERE c.ID = @ID
      		  
          SELECT @IDSalida = @@IDENTITY
      		
          IF @IDSalida IS NOT NULL
          BEGIN
            SELECT @Renglon = 2048
      			
            DECLARE crMesSalidaPadreD CURSOR FOR
      --      SELECT mt.ID, mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
            SELECT mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
              FROM #MesSalidaPadre mt
              JOIN Art a ON mt.Articulo = a.Articulo
             WHERE mt.Almacen = @Almacen
      			
            OPEN crMesSalidaPadreD
      --      FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
            FETCH next FROM crMesSalidaPadreD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
            WHILE @@FETCH_STATUS = 0
            BEGIN
         	
              EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
              SELECT @Renglon = @Renglon + 2048

              EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

              /*  jsmv Actualizar InvD en Espacios id de MovMes / prodserielote = lote de MES */

	            INSERT INTO InvD
	                   (ID,          Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo, Unidad)
	            VALUES(@IDSalida, @Renglon, 0,         0,          @RenglonTipo, @Cantidad, @CantidadInventario, @Almacen, @Articulo, @Unidad)

	            EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT	
            	
	            FETCH next FROM crMesSalidaPadreD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
      --      	FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
            END
            
            EXEC spAfectar 'INV', @IDSalida, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
            
            IF @Ok IS NULL
            BEGIN
            	SELECT @MovSalida =  i.MovID FROM Inv i WHERE i.ID = @IDSalida
            	
            	EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'INV', @IDSalida, 'SalidaMPMaquila', @MovSalida, @Ok OUTPUT
            END
            
            CLOSE crMesSalidaPadreD
            DEALLOCATE crMesSalidaPadreD
      		  
          END
          ELSE
            SELECT @Ok = 10060, @OkRef = 'No se generó el movimiento'
        	
          FETCH NEXT FROM crMesSalidaPadre INTO @Almacen
        END
        
        CLOSE crMesSalidaPadre
        DEALLOCATE crMesSalidaPadre

/*
       	UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 5
          FROM Art a
         WHERE PrevisionesConsumoMES.Hijo = a.Articulo
           AND ISNULL(PrevisionesConsumoMES.EstatusIntelIMES, 0) in (0, 1, 2)
           AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
           AND ISNULL(PrevisionesConsumoMES.FaseConsumo, 0) = 'ext'
           AND PrevisionesConsumoMES.Lanzamiento = @Lanzamiento
*/

       	UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 5
          FROM PrevisionesConsumoMES, CompraD d, Art a, PrevisionesConsumoMES mt2
         WHERE d.MesLanzamiento = PrevisionesConsumoMES.Lanzamiento AND d.Articulo = PrevisionesConsumoMES.Padre
           AND d.ID = @ID
           AND PrevisionesConsumoMES.Hijo = a.Articulo
           AND ISNULL(PrevisionesConsumoMES.EstatusIntelIMES, 0) in (0, 1, 2)
           AND ISNULL(mt2.EstatusIntelIMES, 0) in (0, 1, 2)
           AND PrevisionesConsumoMES.Lanzamiento = mt2.Lanzamiento AND PrevisionesConsumoMES.Padre = mt2.Hijo
           AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
           AND ISNULL(PrevisionesConsumoMES.FaseConsumo, 0) = 'ext'
           AND ISNULL(mt2.FaseConsumo, 0) = 'exthijo'
           AND PrevisionesConsumoMES.Lanzamiento = @Lanzamiento

			END
		END
	--	SELECT @Ok = 1	
	END -- Modulo COMS
	
	IF @Modulo = 'VTAS' AND @MovTipo IN ('VTAS.P', 'VTAS.PR') AND ((@Estatus = 'SINAFECTAR' AND @EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO')) OR @EstatusNuevo = 'CANCELADO')
	BEGIN
		IF @EstatusNuevo = 'CANCELADO'
		  UPDATE VentaMES SET Cancelado = 1 WHERE ID = @ID
		ELSE
		BEGIN
			--SELECT @FormadePago = vc.FormaCobro1 FROM VentaCobro vc WHERE vc.ID = @ID
			SELECT @FormadePago = vc.FormaPagoTipo, @Almacen = vc.Almacen FROM Venta vc WHERE vc.ID = @ID
			
			IF (SELECT a.MES FROM Alm a WHERE a.Almacen = @Almacen) = 1
			BEGIN

        INSERT VentaMES
              (ID, Serie, NumerodePedido, Cliente,   FechaPedido,    FechaEntrega,     SuPedido,    FormadePago, TipoDocumento, DiaPago1,   DiaPago2, DiaPago3, Moneda, Cancelado, Sucursal, Proyecto)
        SELECT ID, Mov,   MovID,        v.Cliente, v.FechaEmision, v.FechaRequerida, v.Referencia, @FormadePago, v.Mov,         NULL,		NULL,     NULL,   m.Moneda, 0, @Sucursal, v.Proyecto
          FROM Venta v
          JOIN Cte c ON v.Cliente = c.Cliente
          LEFT OUTER JOIN MonMES m on v.Moneda = m.Descripcion
         WHERE v.ID = @ID

/*  jsmv  se agrego contuso 1 y 2   */

        INSERT INTO VentaDMES
                 (ID,    Renglon, Serie, NumerodePedido, Articulo,    AlmacenSalida, FechaEntregaRequerida, FechaEntregaConfirmada, CantidadPedida, CantidadServida, CantidadPendiente,    PrecioIntroducido, PorcIVA, SuReferencia, UnidadPedida, UnidadPrecio, SubCuenta, Proyecto,SubProyecto, ContUso, ContUso2)
        SELECT vd.ID, vd.Renglon, v.Mov, v.MovID,     vd.Articulo, vd.Almacen,    vd.FechaRequerida,     vd.FechaRequerida,      vd.Cantidad,       0,            vd.CantidadPendiente, vd.Precio,          vd.Impuesto1, '', um.UnidadMedida, vd.Precio, vd.SubCuenta, v.Proyecto, vd.ABC, vd.ContUso, vd.ContUso2
          FROM Venta v
          JOIN VentaD vd ON vd.ID = v.ID
          JOIN Art a ON vd.Articulo = a.Articulo
          LEFT OUTER JOIN UnidadMes um ON vd.Unidad = um.Descripcion
         WHERE vd.ID = @ID
           --AND a.SeProduce = 1
      END      
    END
	END
	
  IF @Modulo = 'INV' AND @Mov = 'Transferencia' AND @Estatus = 'CONCLUIDO' AND @EstatusNuevo = 'CANCELADO'
  BEGIN
  	SELECT @OrigenTipo = i.OrigenTipo, @Almacen = i.AlmacenDestino FROM Inv i WHERE i.ID = @ID

  	IF @OrigenTipo = 'MESTxfer'
  	BEGIN
  		UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 1, Transferido = ISNULL(Transferido, 0) - d.Cantidad
  		  FROM InvD d
  		  JOIN Art a ON d.Articulo = a.Articulo
  		 WHERE d.ID = @ID
  		   AND d.Articulo = PrevisionesConsumoMES.Hijo
  		   AND d.MesLanzamiento = PrevisionesConsumoMES.Lanzamiento
  		   AND a.AlmacenROP = @Almacen
  	END
  END

-- Aplica VERSA
/* Modulo Fiscal: Registro pMovImpuesto. */  
/*
DECLARE  
@OkTemp   int,  
@OkRefTemp  varchar(255),  
@AfectarFiscal varchar(20),  
/* IETU SergioReyes 03/06/2009: Evita que el sistema registre más de una vez en el módulo Fiscal las Obligaciones Fiscales a la Emisión. El Error sucede la primera vez para los movimientos cuyo Estatus nuevo es PENDIENTE, y la segunda vez cuando pasa a Estatus nuevo CONLUIDO. */  
@CtaDinero  char(10)  
*/
/*  
SELECT  
'xpMovFinal',  
Empresa = @Empresa,  
Sucursal = @Sucursal,  
Modulo = @Modulo,  
ID = @ID,  
Estatus = @Estatus,  
EstatusNuevo = @EstatusNuevo,  
Usuario = @Usuario,  
FechaEmision = @FechaEmision,  
FechaRegistro = @FechaRegistro,  
Mov = @Mov,  
MovID = @MovID,  
MovTipo = @MovTipo,  
IDGenerar = @IDGenerar,  
Ok = @Ok,  
OkRef = @OkRef  
*/  
-- Aplica VERSA
/*
EXEC ppMovImpuestoMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT  

-- SELECT @AfectarFiscal = UPPER(NULLIF(RTRIM(AfectarFiscal), ''))  
SELECT @AfectarFiscal = NULLIF(RTRIM(AfectarFiscal), '')  
FROM MovTipo  
WHERE Modulo = @Modulo AND Mov = @Mov  

-- IF @AfectarFiscal NOT IN (NULL, 'NO') AND @EstatusNuevo = 'CONCLUIDO'  
/* IETU Sergio Reyes 27/05/08: Desconozco la razón del por que filtre por @EstatusNuevo = 'CONCLUIDO', sin embargo esto provoca que los movimientos Endoso, Endoso a favor no generen en el módulo Fiscal el movimiento Endoso Acumulable o Endoso Deducible. Se sustituye la línea superior por la siguiente instrucción. */  
IF @AfectarFiscal NOT IN (NULL, 'NO') AND @EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO', 'PROCESAR')  
BEGIN  
	SELECT @OkTemp = @Ok, @OkRefTemp = @OkRef  
	SELECT @Ok = NULL, @OkRef = NULL  

	/* IETU SergioReyes 03/06/2009: Evita que el sistema registre más de una vez en el módulo Fiscal las Obligaciones Fiscales a la Emisión. El Error sucede la primera vez para los movimientos cuyo Estatus nuevo es PENDIENTE, y la segunda vez cuando pasa a Estatus nuevo CONLUIDO. */  
	SELECT @CtaDinero = NULL  
	IF @Modulo = 'DIN'  
		SELECT @CtaDinero = CtaDinero FROM Dinero WHERE ID = @ID  

	/* IETU SergioReyes 26/07/2011: Se agregó la siguiente sentencia IF para excluir que el sistema no registre la información fiscal de los movimientos en Dinero con Estatus POSFECHADO. */  
	IF @Estatus = 'POSFECHADO'  
	BEGIN  
		EXEC ppGenerarFiscal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT  
		IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  
			SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp  
	END  
	ELSE  
		/* IETU SergioReyes 03/06/2009: Se agregó la siguiente sentencia IF para evitar que el sistema registre más de una vez en el módulo Fiscal las Obligaciones Fiscales a la Emisión. El Error sucede la primera vez para los movimientos cuyo Estatus nuevo es PENDIENTE, y la segunda vez cuando pasa a Estatus nuevo CONLUIDO. */  
		IF NOT EXISTS (SELECT * FROM pFiscal WHERE Empresa = @Empresa AND Mov = @AfectarFiscal AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND ISNULL(DineroCtaDinero, '') = ISNULL(@CtaDinero, ISNULL(DineroCtaDinero, ''))) OR @EstatusNuevo = 'CANCELADO'  
		BEGIN  
			EXEC ppGenerarFiscal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @AfectarFiscal, @Ok OUTPUT, @OkRef OUTPUT  
			IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000  
				SELECT @Ok = @OkTemp, @OkRef = @OkRefTemp  
		END  
END  
*/

	RETURN

END
GO

/********************* xpMESSaldoU **********************/
if exists (select * from sysobjects where id = object_id('dbo.xpMESSaldoU') and type = 'P') drop procedure dbo.xpMESSaldoU
GO             
CREATE PROCEDURE xpMESSaldoU
    @Sucursal		int,
    @Accion		char(20),
    @Empresa		char(5),
    @Usuario		char(10),
    @Rama		char(5),
    @Moneda		char(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @Grupo		char(10),
    @Modulo		char(5),
    @ID			int,
    @Mov			char(20),
    @MovID		varchar(20),
    @Cargo		money,
    @Abono		money,
    @CargoU		float,
    @AbonoU		float,
    @Fecha		datetime,
    @EjercicioAfectacion int,
    @PeriodoAfectacion   int,
    @AcumulaSinDetalles	bit,
    @AcumulaEnLinea	bit,
    @GeneraAuxiliar	bit,
    @GeneraSaldo	        bit,
    @Conciliar		bit,
    @Aplica		char(20),
    @AplicaID		varchar(20),
    @EsTransferencia     bit,
    @EsResultados	bit,
    @EsTipoSerie		bit,
    @InvNegativoU   	float,
    @ConsignacionU	float,
    @Ok			int		OUTPUT,
    @OkRef		varchar(255)	OUTPUT,
    @Renglon		float		= NULL,
    @RenglonSub		int		= NULL,
    @RenglonID		int		= NULL,
    @SubGrupo		varchar(20)	= NULL
    
AS BEGIN
  DECLARE
  @eCommerce              bit,
  @FechaSinHora           datetime,
  @SubCuentaAcum          varchar(50),
  @ImporteConciliarU      float,
  @ImporteConciliar       money,
  @ModuloID2              int,
  @CargoAuxU              float,
  @AbonoAuxU              float,
  @CargoAux               money,
  @AbonoAux               money,
  @EsCancelacion          bit
  
  SELECT @eCommerce = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF @eCommerce = 1
  BEGIN
    IF NOT EXISTS(SELECT * FROM eCommerceSaldoU WHERE Articulo = @Cuenta AND SubCuenta = @SubCuenta)
      INSERT eCommerceSaldoU(Articulo, SubCuenta)
      SELECT                 @Cuenta, @SubCuenta
  END
  
  IF @Accion IN ('CANCELAR' ,'DESAFECTAR')
    SELECT @EsCancelacion = 1
  ELSE
    SELECT @EsCancelacion = 0

  IF @GeneraSaldo=1 AND @Ok IS NULL
  BEGIN
    IF @AcumulaSinDetalles = 1
      SELECT @SubCuentaAcum = ''
    ELSE
      SELECT @SubCuentaAcum = @SubCuenta
      
    IF @Conciliar=1
      SELECT @ImporteConciliar   = @Cargo- @Abono,
             @ImporteConciliarU  = @CargoU- @AbonoU
    ELSE
      SELECT @ImporteConciliar   = 0.0,
             @ImporteConciliarU  = 0.0

    IF @EsResultados=0
    BEGIN
      IF (SELECT a.MES FROM Alm a WHERE a.Almacen = @Grupo) = 1
      BEGIN
        UPDATE SaldoMESU WITH (ROWLOCK) SET Saldo          = ISNULL(Saldo ,0.0)+@Cargo- @Abono,
                                            SaldoU         = ISNULL(SaldoU ,0.0)+@CargoU- @AbonoU,
                                            PorConciliar   = PorConciliar+@ImporteConciliar,
                                            PorConciliarU  = PorConciliarU+@ImporteConciliarU
         WHERE  Sucursal       = @Sucursal
           AND Empresa    = @Empresa
           AND Rama       = @Rama
           AND Moneda     = @Moneda
           AND Grupo      = @Grupo
           AND SubGrupo   = @SubGrupo
           AND Cuenta     = @Cuenta
           AND SubCuenta  = @SubCuentaAcum

        IF @@ROWCOUNT=0            
          INSERT SaldoMESU
              (Sucursal,            Empresa,           Rama,               Moneda,  Grupo, 
               SubGrupo,            Cuenta,            SubCuenta,          Saldo,   SaldoU, 
               PorConciliar,        PorConciliarU,     UltimoCambio)
          VALUES
              (@Sucursal,           @Empresa,          @Rama,              @Moneda, @Grupo,
               @SubGrupo,          @Cuenta,           @SubCuentaAcum,     (@Cargo- @Abono),
               (@CargoU- @AbonoU), @ImporteConciliar, @ImporteConciliarU, @Fecha)
      END

      IF @@ERROR<>0
      SELECT @Ok = 1
    END
  END 
    
  IF @GeneraAuxiliar=1 AND @Ok IS NULL
  BEGIN
    IF @Accion='DESAFECTAR'
    BEGIN
      IF @EsResultados=0
      BEGIN
        SELECT @FechaSinHora = @Fecha,
               @CargoAux     = NULLIF(@Cargo ,0.0),
               @AbonoAux     = NULLIF(@Abono ,0.0),
               @CargoAuxU    = NULLIF(@CargoU ,0.0),
               @AbonoAuxU    = NULLIF(@AbonoU ,0.0)
               
        EXEC spExtraerFecha @FechaSinHora OUTPUT

        IF (SELECT a.MES FROM Alm a WHERE a.Almacen = @Grupo) = 1
          DELETE AuxiliarMESU
           WHERE  Sucursal = @Sucursal
             AND Empresa = @Empresa
             AND Rama = @Rama
             AND Moneda = @Moneda
             AND Grupo = @Grupo
             AND SubGrupo = @SubGrupo
             AND Cuenta = @Cuenta
             AND SubCuenta = @SubCuenta
             AND Mov = @Mov
             AND MovID = @MovID
             AND Ejercicio = @EjercicioAfectacion
             AND Periodo = @PeriodoAfectacion
      END
    END
    ELSE
    BEGIN
      IF @Modulo = 'COMS' AND (SELECT a.MES FROM Alm a WHERE a.Almacen = @Grupo) = 1
      BEGIN
        SELECT @ModuloID2 = c2.ID
	        FROM Compra c 
	        JOIN Compra c2 ON c.Origen = c2.Mov AND c.OrigenID = c2.MovID AND c.Empresa = c2.Empresa
 	       WHERE c.ID = @ID
      END
 
      IF (SELECT a.MES FROM Alm a WHERE a.Almacen = @Grupo) = 1
        INSERT AuxiliarMESU
          (Sucursal,              Empresa,            Rama,          Moneda,          Cuenta,     SubCuenta, 
           Ejercicio,             Periodo,            Fecha,         Grupo,           SubGrupo,   Modulo, 
           ModuloID,              Mov,                MovID,         Cargo,           Abono,      CargoU, 
           AbonoU,                Aplica,             AplicaID,      Acumulado,       Conciliado, EsCancelacion,
           Renglon,               RenglonSub, EstatusIntelIMES, ModuloID2)
        VALUES
          (@Sucursal,             @Empresa,           @Rama,         @Moneda,         @Cuenta,    @SubCuenta, 
           @EjercicioAfectacion,  @PeriodoAfectacion, @FechaSinHora, @Grupo,          @SubGrupo,  @Modulo,
           @ID,                   @Mov,               @MovID,        @CargoAux,       @AbonoAux,  @CargoAuxU, 
           @AbonoAuxU,            @Aplica,            @AplicaID,     @AcumulaEnLinea, 0,          @EsCancelacion,
           @Renglon,              @RenglonSub, CASE @Mov WHEN 'Entrada Produccion' THEN 5 WHEN 'Consumo Produccion' THEN 5 ELSE NULL END, @ModuloID2)
    END
  END
  
  IF @AcumulaEnLinea=1 AND @Ok IS NULL
  BEGIN
    IF @EsResultados=0
    BEGIN
      IF (SELECT a.MES FROM Alm a WHERE a.Almacen = @Grupo) = 1
      BEGIN
        UPDATE AcumMESU WITH (ROWLOCK) SET Cargos = ISNULL(Cargos ,0.0)+@Cargo,
                                           Abonos        = ISNULL(Abonos ,0.0)+@Abono,
                                           CargosU       = ISNULL(CargosU ,0.0)+@CargoU,
                                           AbonosU       = ISNULL(AbonosU ,0.0)+@AbonoU,
                                           UltimoCambio  = @Fecha
         WHERE  Sucursal      = @Sucursal
           AND Empresa   = @Empresa
           AND Rama      = @Rama
           AND Moneda    = @Moneda
           AND Grupo     = @Grupo
           AND SubGrupo  = @SubGrupo
           AND Cuenta    = @Cuenta
           AND SubCuenta = @SubCuentaAcum
           AND Periodo   = @PeriodoAfectacion
           AND Ejercicio = @EjercicioAfectacion
            

        IF @@ROWCOUNT=0
          INSERT AcumMESU
            (Sucursal,  Empresa,  Rama,           Moneda,               Grupo,
             SubGrupo,  Cuenta,   SubCuenta,      Ejercicio,            Periodo,
             Cargos,    Abonos,   CargosU,        AbonosU,              UltimoCambio)
          VALUES
            (@Sucursal, @Empresa, @Rama,          @Moneda,              @Grupo,
             @SubGrupo, @Cuenta,  @SubCuentaAcum, @EjercicioAfectacion, @PeriodoAfectacion, 
             @Cargo,    @Abono,   @CargoU,        @AbonoU,              @Fecha)

      END

    END
  END
  
RETURN
END
GO

/********************* xpMESAntesAfectar **********************/
if exists (select * from sysobjects where id = object_id('dbo.xpMESAntesAfectar') and type = 'P') drop procedure dbo.xpMESAntesAfectar
GO             
CREATE PROCEDURE xpMESAntesAfectar
    @Modulo		        char(5),
    @ID               int,
    @Accion		        char(20),
    @Base		          char(20),
    @GenerarMov		    char(20),
    @Usuario		      char(10),
    @SincroFinal		  bit,
    @EnSilencio	      bit,
    @Ok               int 		      OUTPUT,
    @OkRef            varchar(255) 	OUTPUT,
    @FechaRegistro	  datetime
AS
BEGIN
	DECLARE
  @Empresa						varchar(5),
  @Mov							varchar(20),
	@MovTipo			varchar(10),
  @GrupoSaldos		varchar(20),
	@Cliente			varchar(20),
	@LimiteCredito		Money,
	@ImporteMov			Money,
	@Articulo			varchar(20),
	@ImpuestosC			Money,
	@DescuentoC			Money,
	@DescuentoI			Money,
	@ImporteMovT		Money,
  @Lanzamiento    int

	IF @Modulo = 'VTAS' 
	BEGIN
		EXEC spMovInfo @ID, @Modulo, @MovTipo = @MovTipo OUTPUT
		IF @MovTipo IN ('VTAS.P', 'VTAS.PR') AND @Accion = 'CANCELAR'
		BEGIN
			IF EXISTS(SELECT vd.ID FROM VentaDMES vd WHERE vd.ID = @ID AND vd.LineaPedidoMes = 1)
			  SELECT @Ok = 10060, @OkRef = 'Los productos ya fueron importados en MES'
		END

		-- modulo para validar limites de credito agrupadores / JSMV /
		-- Aplica VERSA
/*
		IF @MovTipo IN ('VTAS.P', 'VTAS.PR') AND @Accion IN ('VERIFICAR','AFECTAR')
		BEGIN

		 SELECT @GrupoSaldos = NULL, @Cliente = NULL, @LimiteCredito = NULL, @ImporteMov = NULL,
				@DescuentoC   = NULL, @DescuentoI = NULL,  @ImporteMovT = NULL, @ImpuestosC = NULL

		 SELECT @Cliente = Cliente , @ImporteMov = Importe, @DescuentoC = DescuentoGlobal, @ImpuestosC = Impuestos 
		 FROM	Venta  WHERE	Id = @ID

		 SELECT @DescuentoI = @ImporteMov * @DescuentoC / 100
		 SELECT @ImporteMovT = @ImporteMov - @DescuentoI + @ImpuestosC

		 SELECT @GrupoSaldos = Rama FROM Cte WHERE Cliente = @Cliente

		 IF @GrupoSaldos <> '' 
		 BEGIN
		   SELECT @LimiteCredito = LimiteCredito FROM VersaConsolidaSaldos WHERE Grupo = @GrupoSaldos
		   IF @ImporteMovT > @LimiteCredito
				SELECT @Ok = 20014, @OkRef = 'Agrupador de Saldos : ' + CHAR(13) + CHAR(13)+ @GrupoSaldos
			END

			-- cursor busca estructura
			DECLARE crVentaD CURSOR FOR 
			SELECT Articulo
		    FROM   VentaD
			WHERE  ID = @ID
  
			OPEN crVentaD
			FETCH next FROM crVentaD INTO @Articulo
			WHILE @@FETCH_STATUS = 0
			BEGIN

				IF NOT EXISTS(SELECT Padre FROM	IPmesversa.dbo.vw_SeleccionEstructura WHERE Padre = @Articulo)
				  SELECT @Ok = 25300, @OkRef = 'Debe especificar Estructura en MES / Articulo : ' + @Articulo

 				FETCH next FROM crVentaD INTO @Articulo
			END
  
			CLOSE crVentaD
			DEALLOCATE crVentaD

		END
*/
/* validacion para que centro de costos en el articulo en cualquier movimiento de ventas sea obligatorio. JRD 07-Mar-2016 */
	--IF (@Accion IN ('VERIFICAR','AFECTAR'))
	--BEGIN 
	--	IF (EXISTS(SELECT ContUso FROM VentaD WHERE ID=@ID AND NULLIF(ContUso,'') IS NULL))
	--		SELECT @Ok=10130, @OkRef=(SELECT TOP 1 Articulo FROM VentaD WHERE ID=@ID AND NULLIF(ContUso, '') IS NULL) 
	--END


	END

-- Aplica VERSA
/* VERSA: Valida que el Periodo en Ventas este Abierto Antes de Cancelar. */
/*
DECLARE
@Estatus						varchar(20),
@Ejercicio						int,
@Periodo						int
--, @MovTipo						varchar(20)

/* VERSA: No Permite Afectar un Movimiento del Modulo de Ventas sino hay Detalle. */
IF @Modulo = 'VTAS' AND @Accion = 'AFECTAR'
	IF NOT EXISTS (SELECT Articulo FROM VentaD WHERE ID = @ID)
		SELECT @Ok = 20400	

/* VERSA: Valida que el Periodo en Ventas este Abierto Antes de Cancelar. */
IF @Modulo = 'COMS' AND @Accion = 'CANCELAR'
BEGIN
	SELECT @Empresa = Empresa, 
	@Mov = Mov, 
	@Estatus = Estatus, 
	@Ejercicio = Ejercicio, 
	@Periodo = Periodo 
	FROM Compra 
	WHERE ID = @ID

	SELECT @MovTipo = Clave 
	FROM MovTipo 
	WHERE Modulo = @Modulo 
	AND Mov = @Mov

	IF (@MovTipo IN ('COMS.GX') OR (@MovTipo = 'COMS.B' AND @Mov = 'Bonif. Extemporanea')) AND @Estatus = 'CONCLUIDO'
		IF EXISTS(SELECT EsEstadistica FROM CompraD WHERE ID = @ID AND EsEstadistica = 1)
			IF EXISTS (SELECT * FROM CerrarPeriodo WHERE Empresa = @Empresa AND Rama = 'VTAS' AND Ejercicio = @Ejercicio AND Periodo = @Periodo) 
				SELECT @Ok = 60110                 
END
*/

  IF @Modulo = 'COMS' AND @Accion IN ('VERIFICAR', 'AFECTAR')
  BEGIN
    EXEC spMovInfo @ID, @Modulo, @Mov = @Mov OUTPUT, @Empresa = @Empresa OUTPUT
    IF @Mov = 'EntradaCompraMaquila'
    BEGIN

      DECLARE crCompraValidar CURSOR FOR
       SELECT d.Articulo, d.MesLanzamiento
         FROM CompraD d
        WHERE d.ID = @ID
        GROUP BY d.Articulo, d.MesLanzamiento

      OPEN crCompraValidar
      FETCH NEXT FROM crCompraValidar INTO @Articulo, @Lanzamiento
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN

        IF NOT EXISTS(
          SELECT d.Articulo
            FROM Inv e
            JOIN InvD d ON e.ID = d.ID
            JOIN PrevisionesConsumoMes p ON d.MesLanzamiento = p.Lanzamiento AND d.Articulo = p.Hijo  AND p.FaseConsumo = 'Ext'
           WHERE e.Empresa = @Empresa
             AND e.Estatus = 'CONCLUIDO'
             AND e.Mov = 'Entrada Produccion'
             AND p.Padre = @Articulo
             AND d.MesLanzamiento = @Lanzamiento)
          SELECT @Ok = 10060, @OkRef = 'No se ha capturado la Entrada Producción del Artículo ' + RTRIM(@Articulo) + ' con el lanzamiento ' + RTRIM(@Lanzamiento) 

        FETCH NEXT FROM crCompraValidar INTO @Articulo, @Lanzamiento
      END

      CLOSE crCompraValidar
      DEALLOCATE crCompraValidar

    END
  END


	RETURN
END
GO


/********************* spArtMesImportar **********************/
if exists (select * from sysobjects where id = object_id('dbo.spArtMesImportar') and type = 'P') drop procedure dbo.spArtMesImportar
GO             
CREATE PROCEDURE spArtMesImportar
--//WITH ENCRYPTION
AS
BEGIN
	
	INSERT INTO ArtMES(Articulo, Descripcion1, Descripcion2, Categoria,
	            Inventariable, Almacen, Ubicacion, UnidadAlmacen, UnidadCompra,
	            UnidadVenta, CostoEstandar, Impuesto1, TipoCosteo, PrecioLista,
	            Estatus, Cuenta, EstatusIntelIMES, Proveedor, TiempoEntrega,
	            TiempoEntregaSeg, Familia, SubFamilia)
	SELECT a.Articulo, a.Descripcion1, SUBSTRING(a.Descripcion2, 1, 100), a.TipoArticulo,
	            'S', a.AlmacenROP, '(none)', (SELECT um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = a.UnidadTraspaso), (SELECT um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = a.UnidadCompra),
	            (SELECT um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = a.Unidad), a.CostoEstandar, a.Impuesto1, a.TipoCosteo, a.PrecioLista,
	            Estatus, Cuenta, 0, Proveedor, TiempoEntrega,
	            TiempoEntregaSeg,
				(SELECT TOP 1 Clave FROM ArtFamMes afm WHERE afm.Descripcion = a.Familia),
				(SELECT TOP 1 Clave FROM ArtSubFamMes afm WHERE afm.Descripcion = a.Grupo)
	  FROM Art a
	WHERE a.Articulo IN (SELECT  a2.Articulo
	                       FROM Art a2
	                       LEFT OUTER JOIN ArtMES am ON a2.Articulo = am.Articulo
	                      WHERE a2.TipoArticulo IS NOT NULL
	                      GROUP BY a2.Articulo, am.Articulo
	                     HAVING am.Articulo IS NULL)
	                     
  SELECT 'Proceso Concluido'
	
	RETURN
END
GO

/********************* spCteMesImportar **********************/
if exists (select * from sysobjects where id = object_id('dbo.spCteMesImportar') and type = 'P') drop procedure dbo.spCteMesImportar
GO             
CREATE PROCEDURE spCteMesImportar
--//WITH ENCRYPTION
AS
BEGIN
	
  INSERT INTO CteMES(Cliente, RazonSocial, NombreComercial, Direccion1, Direccion2,
              Poblacion, Provincia, CodigoPostal, Pais, CIFDNI, FormaPago,
              TipoDocumento, CodigoMoneda, Idioma, CodigoPortes, DiaPago1,
              DiaPago2, DiaPago3, Cuenta, SubCuenta, EstatusIntelIMES)
  SELECT c.Cliente, c.Nombre, c.Nombre, RTRIM(ISNULL(Direccion, '')) + ' ' + RTRIM(ISNULL(DireccionNumero, '')) + ' ' + RTRIM(ISNULL(DireccionNumeroInt, '')), c.Colonia,
              RTRIM(ISNULL(Delegacion, '')) + ' ' + RTRIM(ISNULL(Poblacion, '')), c.Estado, c.CodigoPostal, c.Pais, c.RFC, c.Condicion,
              '', (SELECT m.Moneda FROM MonMes m WHERE m.Descripcion = c.DefMoneda), '', '', NULL,
              NULL, NULL, c.Cuenta, '', 0
  FROM Cte c
  WHERE c.Cliente IN (SELECT c2.Cliente
                        FROM Cte c2
                        LEFT OUTER JOIN CteMES cm ON c2.Cliente = cm.Cliente
                       --WHERE c2.Situacion = 'MES'
                       GROUP BY c2.Cliente, cm.Cliente
                      HAVING cm.Cliente IS NULL)
  
  SELECT 'Proceso Concluido'
	
	RETURN
END
GO

/********************* spProvMesImportar **********************/
if exists (select * from sysobjects where id = object_id('dbo.spProvMesImportar') and type = 'P') drop procedure dbo.spProvMesImportar
GO             
CREATE PROCEDURE spProvMesImportar
--//WITH ENCRYPTION
AS
BEGIN
	
  INSERT INTO ProvMes(Proveedor, RazonSocial, NombreComercial, Direccion1,
              Direccion2, Poblacion, Provincia, CodigoPostal, CodigoPais, CIFDNI,
              FormaPago, TipoDocumento, DefMoneda, Idioma, CodigoPortes, DiaPago1,
              DiaPago2, DiaPago3, Cuenta, SubCuenta, EstatusIntelIMES)
  SELECT p.Proveedor, p.Nombre, p.Nombre, RTRIM(ISNULL(Direccion, '')) + ' ' + RTRIM(ISNULL(DireccionNumero, '')) + ' ' + RTRIM(ISNULL(DireccionNumeroInt, '')),
              p.Colonia, RTRIM(ISNULL(Delegacion, '')) + ' ' + RTRIM(ISNULL(Poblacion, '')), p.Estado, p.CodigoPostal, p.Pais, p.RFC,
              '(NONE)', '', (SELECT m.Moneda FROM MonMes m WHERE m.Descripcion = p.DefMoneda), '', '', NULL, 
              NULL, NULL, p.Cuenta, '', 0
    FROM Prov p
   WHERE p.Proveedor IN (SELECT pr.Proveedor
                           FROM Prov pr
                           LEFT OUTER JOIN ProvMES pm ON pr.Proveedor = pm.Proveedor
                          --WHERE pr.Situacion = 'MES'
                          GROUP BY pr.Proveedor, pm.Proveedor
                         HAVING pm.Proveedor IS NULL)
  
  SELECT 'Proceso Concluido'
	
	RETURN
END
GO

/********************* spFormaPagoComparaMes **********************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaPagoComparaMes') and type = 'P') drop procedure dbo.spFormaPagoComparaMes
GO             
CREATE PROCEDURE spFormaPagoComparaMes
      @Empresa        varchar(5)
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
	@Servidor         varchar(50),
	@BD               varchar(50),
	@Comando          varchar(1000)
	
	SELECT @Servidor = ecm.Servidor, @BD = ecm.BD
	  FROM EmpresaCfgMES ecm
	 WHERE ecm.Empresa = @Empresa
	 
	CREATE TABLE #FPMES
	(Codigo varchar(50)) 
	 
	--SELECT @Comando = 'CREATE TABLE #FPMES(Codigo varchar(50)) INSERT INTO #FPMES(Codigo) SELECT Codigo FROM [' + @Servidor + '].' + @BD + '.dbo.MFormaPago'
	SELECT @Comando = 'INSERT INTO #FPMES(Codigo) SELECT Codigo FROM [' + @Servidor + '].' + @BD + '.dbo.MFormaPago'
	
	EXEC(@Comando)
	
	SELECT fp.FormaPago, f.Codigo
	  FROM FormaPago fp
	  LEFT OUTER JOIN #FPMES f ON fp.FormaPago = f.Codigo
	 ORDER BY fp.FormaPago
	 
  RETURN	
END
GO

/********************* spFormaPagoComparaMes **********************/
if exists (select * from sysobjects where id = object_id('dbo.spMaestroMesImportar') and type = 'P') drop procedure dbo.spMaestroMesImportar
GO             
CREATE PROCEDURE spMaestroMesImportar
--//WITH ENCRYPTION
AS
BEGIN

  IF NOT EXISTS(SELECT * FROM AlmMes)
    INSERT AlmMES 
                 (CodigoAlmacen, RazonSocial,   NombreComercial,  Direccion1,    Direccion2,
                  Poblacion,     Provincia,     Pais,             CodigoPostal,  Idioma, Sucursal, EstatusIntelIMES)
    SELECT Almacen, Nombre, Nombre, RTRIM(ISNULL(Direccion, ''))+' '+RTRIM(ISNULL(DireccionNumero, '')), Colonia,
           Poblacion, Estado, Pais, CodigoPostal, Idioma, Sucursal, 0
      FROM Alm
     WHERE ISNULL(Mes, 0) = 1

  IF NOT EXISTS(SELECT * FROM FormaPagoMES)
    INSERT INTO FormaPagoMES(FormaPago, Descripcion, TipoDocumento, DiasPrimerVencimiento, DiasEntreVencimientos, EstatusIntelIMES)
    SELECT FormaPago, FormaPago, '',            0,                     0, 0
      FROM FormaPago

  IF NOT EXISTS(SELECT * FROM MonMes)
    INSERT INTO MonMes(Moneda, Descripcion, DescripcionAbreviada, NumeroDecimales, EstatusIntelIMES)
    SELECT Clave, Moneda, Clave, 2, 0
      FROM Mon
      
  IF NOT EXISTS(SELECT * FROM PaisMes)
 	   INSERT PaisMES 
 	          (Pais,   Clave,   DescripcionAbreviada, CodPaisIntrastat, DigitosNIF, MiembroCE) 
     SELECT ISNULL(Pais,'Mexico'), Clave, Clave, Clave, 13, 0
       FROM Pais

  if not exists(SELECT * FROM UnidadMes)
    INSERT UnidadMES (UnidadMedida, Descripcion, EstatusIntelIMES)
    SELECT SUBSTRING(Clave, 1, 5), Unidad, 0
      FROM Unidad
     WHERE NULLIF(RTRIM(Clave), '') is not null

  IF NOT EXISTS(SELECT * FROM SucursalMes)
    INSERT INTO SucursalMes(Sucursal)
    SELECT Sucursal FROM Sucursal s

  IF NOT EXISTS(SELECT * FROM ArtFamMes)
    INSERT INTO ArtFamMes(Clave, Descripcion, EstatusIntelIMES)
    SELECT af.ClaveMES, af.Familia, 0 FROM ArtFam af

  IF NOT EXISTS(SELECT * FROM ArtSubFamMes)
    INSERT INTO ArtSubFamMes(Clave, Descripcion, EstatusIntelIMES)
    SELECT ag.ClaveMES, ag.Grupo, 0 FROM ArtGrupo ag
    
  SELECT 'Proceso Concluido'

  RETURN	
END
GO


/********************* spMesTransfer **********************/
if exists (select * from sysobjects where id = object_id('dbo.spMesTransfer') and sysstat & 0xf = 4) drop procedure dbo.spMesTransfer
GO
CREATE PROCEDURE spMesTransfer
  @Empresa      varchar(5),
  @Usuario      varchar(10),
  @Sucursal     int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ID           		        int,
  @IDTransfer               int,
  @MovTransfer              varchar(20),
  @FechaEmision             datetime,
  @Articulo                 varchar(20),
  @Cantidad                 float,
  @CantidadInventario       float,
  @Unidad                   varchar(50),
  @Almacen                  varchar(10),
  @AlmacenDestino           varchar(10),
  @CfgMultiUnidades	      	bit,
  @CfgMultiUnidadesNivel		varchar(20),
  @ArtTipo                  varchar(20),
  @Moneda                   varchar(10),
  @TipoCambio               float,
  @Renglon                  float,
  @RenglonTipo              varchar(1),
  @Mensaje                  varchar(255),
  @Ok                       int,
  @OkRef                    varchar(255)
  
  IF ISNULL((SELECT ecm.TransferenciaManual FROM EmpresaCfgMES ecm WHERE ecm.Empresa = @Empresa), 0) = 1
  BEGIN
  	SELECT 'Desactivado'
  	RETURN
  END
  
  BEGIN TRANSACTION

 -- 	INSERT INTO dyBitacora (CAMPO01, CAMPO02) VALUES ( @Almacen, @AlmacenDestino)

	SELECT @CfgMultiUnidades         = MultiUnidades, 
	       @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
	  FROM EmpresaCfg2 
	 WHERE Empresa = @Empresa
	
	SELECT @Moneda = ec.MonedaCosteo
	  FROM EmpresaCfg ec
	 WHERE ec.Empresa = @Empresa
	 
	SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
	 
	SELECT @FechaEmision = GETDATE()
	EXEC spExtraerFecha @FechaEmision OUTPUT

  CREATE TABLE #MesTransfer(
--  ID              int,
  Articulo        varchar(20),
  Cantidad        money,
  Unidad          varchar(50)   NULL,
  Almacen         varchar(10),
  AlmacenDestino  varchar(10))
  
 -- SELECT @MovTransfer = ecm.ITransferencia  // jsmv 23/abr/16 se cambio a orden de transferencia

  SELECT @MovTransfer = ecm.InvOrdenTransferencia
    FROM EmpresaCfgMov ecm 
   WHERE ecm.Empresa = @Empresa
  
  INSERT INTO #MesTransfer(Articulo, Cantidad, Unidad, Almacen, AlmacenDestino)
  SELECT mt.Hijo, mt.CantidadTotalHijo, mt.UnidMedidaAlmacen, a.AlmMesComs, a.AlmacenROP
    FROM PrevisionesConsumoMES mt
    JOIN Art a ON mt.Hijo = a.Articulo
   WHERE ISNULL(mt.EstatusIntelIMES, 0) = 0 AND
          a.AlmMesComs <> a.AlmacenROP
     AND NULLIF(RTRIM(a.AlmacenROP), '') IS NOT NULL
     AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
     
  DECLARE crMesTransfer CURSOR FOR
  SELECT mt.Almacen, mt.AlmacenDestino
    FROM #MesTransfer mt
  GROUP BY mt.Almacen, mt.AlmacenDestino
   
  OPEN crMesTransfer
  FETCH NEXT FROM crMesTransfer INTO @Almacen, @AlmacenDestino
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
  	SELECT @IDTransfer = NULL

--	INSERT INTO dyBitacora (CAMPO01) VALUES ( @MovTransfer)
  	
  	INSERT INTO Inv(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Almacen, AlmacenDestino, OrigenTipo, Sucursal)
		VALUES(@Empresa, @MovTransfer, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, @AlmacenDestino, 'MESTrfer', @Sucursal)
		
		SELECT @IDTransfer = @@IDENTITY
		
		IF @IDTransfer IS NOT NULL
		BEGIN
			SELECT @Renglon = 2048
			
      DECLARE crMesTransferD CURSOR FOR
--      SELECT mt.ID, mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
      SELECT mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
        FROM #MesTransfer mt
        JOIN Art a ON mt.Articulo = a.Articulo
       WHERE mt.Almacen = @Almacen AND mt.AlmacenDestino = @AlmacenDestino 
			
      OPEN crMesTransferD
--      FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
      FETCH next FROM crMesTransferD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
      WHILE @@FETCH_STATUS = 0
      BEGIN
   	
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 2048

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

        /*  jsmv Actualizar InvD en Espacios id de MovMes / prodserielote = lote de MES */

				INSERT INTO InvD
				       (ID,          Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo, Unidad)
				VALUES(@IDTransfer, @Renglon, 0,         0,          @RenglonTipo, @Cantidad, @CantidadInventario, @AlmacenDestino, @Articulo, @Unidad)

      	EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT	
      	
      	FETCH next FROM crMesTransferD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
--      	FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
      END
      
      EXEC spAfectar 'INV', @IDTransfer, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
      
      CLOSE crMesTransferD
      DEALLOCATE crMesTransferD
		  
		END
  	ELSE
  		SELECT @Ok = 10060, @OkRef = 'No se generó el movimiento'
  	
  	FETCH NEXT FROM crMesTransfer INTO @Almacen, @AlmacenDestino
  END
  
  CLOSE crMesTransfer
  DEALLOCATE crMesTransfer
  
  DELETE FROM #MesTransfer
  
-- TransferenciaPadre
  INSERT INTO #MesTransfer(Articulo, Cantidad, Unidad, Almacen, AlmacenDestino)
  SELECT mt.Padre, mt.CantidadTotalPadre, mt.UnidMedidaAlmacen, a.AlmacenROP, a.AlmMesComs ---a.AlmMesComs, a.AlmacenROP
    FROM PrevisionesConsumoMES mt
    JOIN Art a ON mt.Padre = a.Articulo
   WHERE ISNULL(mt.EstatusIntelIMES, 0) = 0
     AND a.AlmMesComs <> a.AlmacenROP
     AND NULLIF(RTRIM(a.AlmacenROP), '') IS NOT NULL
     AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
     AND ISNULL(mt.FaseConsumo, 0) = '999'
     
  DECLARE crMesTransfer CURSOR FOR
  SELECT mt.Almacen, mt.AlmacenDestino
    FROM #MesTransfer mt
  GROUP BY mt.Almacen, mt.AlmacenDestino
   
  OPEN crMesTransfer
  FETCH NEXT FROM crMesTransfer INTO @Almacen, @AlmacenDestino
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
  	SELECT @IDTransfer = NULL

--	INSERT INTO dyBitacora (CAMPO01) VALUES ( @MovTransfer)
  	
  	INSERT INTO Inv(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Almacen, AlmacenDestino, OrigenTipo, Sucursal)
		VALUES(@Empresa, @MovTransfer, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Almacen, @AlmacenDestino, 'MESTrfer', @Sucursal)
		
		SELECT @IDTransfer = @@IDENTITY
		
		IF @IDTransfer IS NOT NULL
		BEGIN
			SELECT @Renglon = 2048
			
      DECLARE crMesTransferD CURSOR FOR
--      SELECT mt.ID, mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
      SELECT mt.Articulo, mt.Cantidad, mt.Unidad, a.Tipo
        FROM #MesTransfer mt
        JOIN Art a ON mt.Articulo = a.Articulo
       WHERE mt.Almacen = @Almacen AND mt.AlmacenDestino = @AlmacenDestino
			
      OPEN crMesTransferD
--      FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
      FETCH next FROM crMesTransferD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
      WHILE @@FETCH_STATUS = 0
      BEGIN
   	
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        SELECT @Renglon = @Renglon + 2048

        EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

        /*  jsmv Actualizar InvD en Espacios id de MovMes / prodserielote = lote de MES */

				INSERT INTO InvD
				       (ID,          Renglon, RenglonSub, RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo, Unidad)
				VALUES(@IDTransfer, @Renglon, 0,         0,          @RenglonTipo, @Cantidad, @CantidadInventario, @AlmacenDestino, @Articulo, @Unidad)

      	EXEC xpCantidadInventario @Articulo, NULL, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT	
      	
      	FETCH next FROM crMesTransferD INTO  @Articulo, @Cantidad, @Unidad, @ArtTipo
--      	FETCH next FROM crMesTransferD INTO @ID, @Articulo, @Cantidad, @Unidad, @ArtTipo
      END
      
      EXEC spAfectar 'INV', @IDTransfer, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 1
      
      CLOSE crMesTransferD
      DEALLOCATE crMesTransferD
		  
		END
  	ELSE
  		SELECT @Ok = 10060, @OkRef = 'No se generó el movimiento'
  	
  	FETCH NEXT FROM crMesTransfer INTO @Almacen, @AlmacenDestino
  END
  
  CLOSE crMesTransfer
  DEALLOCATE crMesTransfer

  IF @Ok IS NULL
  BEGIN
    UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 1 
      FROM PrevisionesConsumoMES mt
      JOIN Art a ON mt.Hijo = a.Articulo
     WHERE ISNULL(mt.EstatusIntelIMES, 0) = 0 
	     AND a.AlmMesComs <> a.AlmacenROP
       AND NULLIF(RTRIM(a.AlmacenROP), '') IS NOT NULL
       AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL

  	UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = 1 
  	  FROM Art a 
     WHERE Hijo = a.Articulo
       AND ISNULL(EstatusIntelIMES, 0) = 0
       AND a.AlmMesComs <> a.AlmacenROP
     AND NULLIF(RTRIM(a.AlmacenROP), '') IS NOT NULL
     AND NULLIF(RTRIM(a.AlmMesComs), '') IS NOT NULL
     AND ISNULL(FaseConsumo, 0) = '999'
     
  	SELECT @Mensaje = 'Proceso concluido con éxito'
  	COMMIT TRAN
  END
  ELSE
  BEGIN
  	SELECT @Mensaje = m.Descripcion FROM MensajeLista m WHERE m.Mensaje = @Ok
  	SELECT @Mensaje = RTRIM(ISNULL(@Mensaje, '')) + ' ' + RTRIM(ISNULL(@OkRef, ''))
  	ROLLBACK TRAN
  END
  
  SELECT @Mensaje

  RETURN
END
GO


/**************** spMesInvTransferGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMesInvTransferGenerar') and type = 'P') drop procedure dbo.spMesInvTransferGenerar
GO             
CREATE PROCEDURE spMesInvTransferGenerar
    @Empresa          varchar(5),
    @Usuario          varchar(10),
    @Sucursal         int,
    @Lanzamiento      int
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
	@IDInv              int,
	@MovInv             varchar(20),
	@FechaEmision       datetime,
	@Articulo           varchar(20),
	@Almacen            varchar(10),
	@AlmacenDestino     varchar(10),
	@Renglon            int,
	@RenglonID          int,
	@ID                 int,
	@Cantidad           float,
	@Unidad             varchar(50),
	@Ok                 int,
	@OkRef              varchar(255),
	@Moneda             varchar(10),
	@TipoCambio         float,
	@Mensaje            varchar(255),
	@CfgMultiUnidades		bit,
  @CfgMultiUnidadesNivel		varchar(20),
  @ArtTipo            varchar(20),
  @RenglonTipo        varchar(1),
  @CantidadInventario float
	
  IF ISNULL((SELECT ecm.TransferenciaManual FROM EmpresaCfgMES ecm WHERE ecm.Empresa = @Empresa), 0) = 0
  BEGIN
  	SELECT 'Desactivado'
  	RETURN
  END
  
-- 7/Ago/2016
  IF (SELECT SeriesLotesAutoOrden FROM EmpresaCfg ec WHERE ec.Empresa = @Empresa) = 'No'
  BEGIN
    SELECT @Articulo = MIN(m.Hijo)
      FROM MesInvTransfer m
      JOIN Art a ON m.Hijo = a.Articulo
      LEFT OUTER JOIN MesInvTransferSerieLote sl ON sl.Usuario = m.Usuario AND sl.ID = m.ID
     WHERE m.Usuario = @Usuario
       AND a.Tipo IN ('Serie', 'Lote')
     GROUP BY m.Hijo, m.CantidadA
    HAVING m.CantidadA <> SUM(sl.Cantidad)
    
    IF @Articulo IS NOT NULL
    BEGIN
  	  SELECT 'La Cantidad capturada de la Serie/Lote no coincide con la cantidad a Afectar. Artículo: ' + RTRIM(@Articulo)
  	  RETURN
    END
  END
  	
	BEGIN TRAN
	
	SELECT @FechaEmision = GETDATE()
	EXEC spExtraerFecha	@FechaEmision OUTPUT
	
	SELECT @CfgMultiUnidades         = MultiUnidades, 
         @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
	 WHERE Empresa = @Empresa
	
	SELECT @Moneda = MonedaCosteo FROM EmpresaCfg WHERE Empresa = @Empresa
	SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = @Moneda
	
	DECLARE crMesInvTransferGenerar CURSOR FOR
	SELECT mit.Almacen, mit.AlmacenD
	  FROM MesInvTransfer mit
	 WHERE mit.Usuario = @Usuario
	   AND mit.Lanzamiento = @Lanzamiento
	   AND ISNULL(mit.CantidadA, 0) > 0
	   AND ISNULL(mit.Almacen, '') <> ISNULL(mit.AlmacenD, '')
	 GROUP BY mit.Almacen, mit.AlmacenD
	 
	OPEN crMesInvTransferGenerar
	FETCH NEXT FROM crMesInvTransferGenerar INTO @Almacen, @AlmacenDestino
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		SELECT @IDInv = NULL
		
		INSERT INTO Inv
		       (Empresa,  Mov,             FechaEmision,  Moneda,  TipoCambio,  Referencia,   Usuario, Estatus,       Almacen,  AlmacenDestino, OrigenTipo, Sucursal, MesLanzamiento)
		VALUES(@Empresa, 'Transferencia', @FechaEmision, @Moneda, @TipoCambio, @Lanzamiento, @Usuario, 'SINAFECTAR', @Almacen, @AlmacenDestino, 'MESTxfer', @Sucursal, @Lanzamiento)
		
		SELECT @IDInv = @@IDENTITY
		
		IF @IDInv IS NOT NULL
		BEGIN
			DECLARE crMesInvTransferGenerarD CURSOR FOR
		  SELECT mit.ID, (ROW_NUMBER() OVER(order by Hijo))*2048, mit.CantidadA, mit.Hijo, mit.UnidMedidaAlmacen, a.Tipo
		    FROM MesInvTransfer mit
		    JOIN Art a ON mit.Hijo = a.Articulo
	     WHERE mit.Usuario = @Usuario
	       AND mit.Lanzamiento = @Lanzamiento
	       AND ISNULL(mit.CantidadA, 0) > 0
	       AND ISNULL(mit.Almacen, '') = @Almacen
	       AND ISNULL(mit.AlmacenD, '') = @AlmacenDestino
	     
      SELECT @RenglonID = 1

      OPEN crMesInvTransferGenerarD
      FETCH next FROM crMesInvTransferGenerarD INTO @ID, @Renglon, @Cantidad, @Articulo, @Unidad, @ArtTipo
      WHILE @@FETCH_STATUS = 0
      BEGIN
     		
     		EXEC spRenglonTipo @ArtTipo, '', @RenglonTipo OUTPUT
     		
 		    EXEC xpCantidadInventario @Articulo, '', @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
         		
        INSERT INTO InvD
				       (ID,     Renglon, RenglonSub,  RenglonID,  RenglonTipo,  Cantidad,  CantidadInventario,  Almacen,  Articulo, Unidad, MesLanzamiento)
				VALUES(@IDInv, @Renglon, 0,          @RenglonID, @RenglonTipo, @Cantidad, @CantidadInventario, @Almacen, @Articulo, @Unidad, @Lanzamiento)
				
				IF @ArtTipo IN ('Serie', 'Lote')
				  INSERT INTO SerieLoteMov
				         (Empresa, Modulo, ID,     RenglonID,  Articulo, SubCuenta, SerieLote, Cantidad, Sucursal)
				  SELECT @Empresa, 'INV', @IDInv, @RenglonID, @Articulo, '',        sl.SerieLote, sl.Cantidad, @Sucursal
				    FROM MesInvTransferSerieLote sl
				   WHERE sl.Usuario = @Usuario
				     AND sl.ID = @ID
				     AND ISNULL(sl.Cantidad, 0) > 0
				
				SELECT @RenglonID = @RenglonID + 1

      	FETCH next FROM crMesInvTransferGenerarD INTO @ID, @Renglon, @Cantidad, @Articulo, @Unidad, @ArtTipo
      END
      
      CLOSE crMesInvTransferGenerarD
      DEALLOCATE crMesInvTransferGenerarD
	     
	     
	    EXEC spAfectar 'INV', @IDInv, 'AFECTAR', NULL, NULL, @Usuario, 0, 1, @Ok OUTPUT, @OkRef OUTPUT, NULL, 0
  		  
		END
		ELSE
			SELECT @Ok = 10060, @OkRef = 'No se generó la Transferencia'
		
		FETCH NEXT FROM crMesInvTransferGenerar INTO @Almacen, @AlmacenDestino
	END
	
	CLOSE crMesInvTransferGenerar
	DEALLOCATE crMesInvTransferGenerar
	
  IF @Ok IS NULL
  BEGIN
  	--UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = CASE WHEN ISNULL(PrevisionesConsumoMES.Transferido, 0)+ISNULL(mit.CantidadA, 0) >= ISNULL(mit.Cantidad, 0) THEN 2 ELSE 1 END, 
   --                                  PrevisionesConsumoMES.Transferido = ISNULL(PrevisionesConsumoMES.Transferido, 0) + ISNULL(mit.CantidadA, 0)
  	UPDATE PrevisionesConsumoMES SET EstatusIntelIMES = CASE WHEN ISNULL(PrevisionesConsumoMES.Transferido, 0)+ CASE a.AlmacenROP WHEN mit.AlmacenD THEN ISNULL(mit.CantidadA, 0) ELSE 0 END >= ISNULL(mit.Cantidad, 0) THEN 2 ELSE 1 END, 
                                     PrevisionesConsumoMES.Transferido = ISNULL(PrevisionesConsumoMES.Transferido, 0) + CASE a.AlmacenROP WHEN mit.AlmacenD THEN ISNULL(mit.CantidadA, 0) ELSE 0 END
  	  FROM MesInvTransfer mit
  	  JOIN Art a ON mit.Hijo = a.Articulo
	   WHERE mit.Usuario = @Usuario
	     AND mit.Lanzamiento = PrevisionesConsumoMES.Lanzamiento AND PrevisionesConsumoMES.Padre = mit.Padre AND PrevisionesConsumoMES.Hijo = mit.Hijo
	     AND ISNULL(mit.CantidadA, 0) > 0
  	  
  	DELETE FROM MesInvTransfer WHERE Usuario = @Usuario
  	DELETE FROM MesInvTransferSerieLote WHERE Usuario = @Usuario
  	
  	COMMIT TRAN
  	SELECT 'Proceso Concluido'
  END
  ELSE
  BEGIN
  	SELECT @Mensaje = ml.Descripcion FROM MensajeLista ml WHERE ml.Mensaje = @Ok
  	SELECT @Mensaje = RTRIM(@Mensaje) + '. ' + RTRIM(@OkRef)
  	SELECT @Mensaje
  	ROLLBACK TRAN
  END
	
	RETURN
END
GO

/**************** spMesInvTransferLanzamiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMesInvTransferLanzamiento') and type = 'P') drop procedure dbo.spMesInvTransferLanzamiento
GO             
CREATE PROCEDURE spMesInvTransferLanzamiento
    @Empresa          varchar(5),
    @Usuario          varchar(10),
    @Lanzamiento      int
--//WITH ENCRYPTION
AS
BEGIN
	DELETE FROM MesInvTransfer WHERE Usuario = @Usuario
	DELETE FROM MesInvTransferSerieLote WHERE Usuario = @Usuario
	
	INSERT INTO MesInvTransfer
	       (Usuario,     Lanzamiento,     Padre,     Hijo,   Almacen,      AlmacenD,       Cantidad,          
	        CantidadA,
	        UltimoPrecioCoste, PrecioCosteMedio, UnidMedidaCompra, UnidMedidaAlmacen, Transferido)
	SELECT @Usuario, pcm.Lanzamiento, pcm.Padre, pcm.Hijo, a.AlmMesComs, a.AlmacenROP, pcm.CantidadTotalHijo, 
	        CASE WHEN ISNULL(ad.Disponible, 0)<= 0 THEN 0 ELSE pcm.CantidadTotalHijo END, 
	        pcm.UltimoPrecioCoste, pcm.PrecioCosteMedio, pcm.UnidMedidaCompra, pcm.UnidMedidaAlmacen, pcm.Transferido
	  FROM PrevisionesConsumoMES pcm
	  JOIN Art a ON pcm.Hijo = a.Articulo
	  LEFT OUTER JOIN ArtDisponible ad ON ad.Empresa = @Empresa AND ad.Articulo = a.Articulo AND ad.Almacen = a.AlmMesComs
	 WHERE pcm.Lanzamiento = @Lanzamiento
	   AND ISNULL(pcm.EstatusIntelIMES, 0) IN (0,1)
	 
	RETURN
END
GO


IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_id('dbo.spMESCatalogos') AND type = 'P') DROP PROCEDURE spMESCatalogos
GO
CREATE PROCEDURE dbo.spMESCatalogos
					@Catalogo	VARCHAR(50),
					@INTCuenta	VARCHAR(20),
					@Eliminar	BIT = 0
					
--//WITH ENCRYPTION
AS
BEGIN
	--DECLARE
	--	@ClavePais		VARCHAR(10),
	--	@ClaveMoneda	VARCHAR(10),
	--	@UnidadAlmacen  VARCHAR(50),
	--	@UnidadCompra   VARCHAR(50),
 --       @UnidadVenta    VARCHAR(50)


	--IF @Catalogo = 'ArtMES'
	--BEGIN
		
	--	DELETE FROM ArtMES WHERE Articulo = @INTCuenta
		
	--	IF @Eliminar = 0
	--	BEGIN	
	--		SELECT @UnidadAlmacen = UnidadTraspaso, @UnidadCompra = UnidadCompra, @UnidadVenta = Unidad FROM Art
			
	--		SELECT @UnidadAlmacen = um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = @UnidadAlmacen
 --     		SELECT @UnidadCompra = um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = @UnidadCompra
 --     		SELECT @UnidadVenta = um.UnidadMedida FROM UnidadMES um WHERE um.Descripcion = @UnidadVenta
			
	--		INSERT ArtMES ( Articulo,			Descripcion1,		Descripcion2,							Categoria,						Inventariable,
 --          					Almacen,			Ubicacion,			UnidadAlmacen,							UnidadCompra,					UnidadVenta,
	--						CostoEstandar,		Impuesto1,			TipoCosteo,								PrecioLista,					Estatus,
	--						Cuenta,				Proveedor,			TiempoEntrega,							TiempoEntregaSeg,				EstatusIntelIMES,
	--						Familia,			SubFamilia,			SMR,									MinimoCompra,					StockMinimo, 
	--						StockMaximo)             
	--		SELECT			Art.Articulo,		Art.Descripcion1,	SUBSTRING(Art.Descripcion2, 1, 100),	Art.TipoArticulo,				'S',
 --          					Art.AlmacenROP,     '(none)',			@UnidadAlmacen,							@UnidadCompra,					@UnidadVenta,
	--						Art.CostoEstandar,	Art.Impuesto1,		Art.TipoCosteo,							Art.PrecioLista,				Art.Estatus,
	--						Art.Cuenta,			Art.Proveedor,		Art.TiempoEntrega,						Art.TiempoEntregaSeg,			0,
	--						afm.Clave,			asfm.Clave,			Art.SMR,								ISNULL(Art.MinimoCompra, 0),	ISNULL(Art.StockMinimo, 0),						
	--						ISNULL(StockMaximo, 0)
	--		FROM Art
	--			LEFT JOIN ArtFam AS af ON af.Familia = Art.Familia
	--			LEFT JOIN ArtFamMes AS afm ON afm.Descripcion = af.Familia
	--			LEFT JOIN ArtSubFamMes AS asfm ON asfm.Descripcion = Art.Grupo
	--		WHERE Art.Articulo = @INTCuenta
			
	--		UPDATE Art SET TieneMovimientos = 1 WHERE Articulo = @INTCuenta
	--	END			
	--END

	--IF @Catalogo = 'CteMES'
	--BEGIN
		
	--	DELETE FROM CteMES WHERE Cliente = @INTCuenta
		
	--	IF @Eliminar = 0
	--	BEGIN
	--		SELECT @ClavePais = Clave FROM Pais WHERE Pais = (SELECT Pais FROM Cte WHERE Cliente = @INTCuenta)
			
	--		INSERT CteMES (	Cliente,		RazonSocial,    NombreComercial,	Direccion1,														Direccion2,
	--						Poblacion,																											Provincia,      
	--						CodigoPostal,   Pais,			CIFDNI,				FormaPago,		TipoDocumento,  CodigoMoneda,					Idioma,      
	--						CodigoPortes,	DiaPago1,		DiaPago2,			DiaPago3,       Cuenta,			SubCuenta,						EstatusIntelIMES)
	--		SELECT			Cliente,		Nombre,			Nombre,				(Direccion + ' ' + DireccionNumero + ' ' + DireccionNumeroInt), Colonia, 
	--						COALESCE(NULLIF(RTRIM(Delegacion), ''), NULLIF(RTRIM(Poblacion), '')),												Estado,     
	--						CodigoPostal,   ISNULL(@ClavePais, '116'),			RFC,				Condicion,		'',				ISNULL(mm.Moneda,DefMoneda),		'',     
	--						'',				NULL,			NULL,				NULL,			Cuenta,			'',										0
	--		FROM Cte
	--			LEFT JOIN MonMes AS mm ON mm.Descripcion = DefMoneda
	--		WHERE Cliente = @INTCuenta
			
	--		UPDATE Cte SET TieneMovimientos = 1 WHERE Cliente = @INTCuenta
	--	END

	--END
	
	--ELSE IF @Catalogo = 'ProvMES'
	--BEGIN

	--	DELETE FROM ProvMES WHERE Proveedor = @INTCuenta
		
	--	IF @Eliminar = 0
	--	BEGIN
						
	--		SELECT @ClavePais = Clave FROM Pais WHERE Pais = (SELECT Pais FROM Prov WHERE Proveedor = @INTCuenta) 
	--		SELECT @ClaveMoneda = Clave FROM Mon WHERE Moneda = (SELECT ISNULL(Prov.DefMoneda,'Pesos') FROM Prov WHERE Proveedor = @INTCuenta) 
			
	--		INSERT ProvMES (Proveedor,		RazonSocial,			NombreComercial,	Direccion1,														Direccion2, 
	--						Poblacion,																Provincia,      CodigoPostal,						CodigoPais, 
	--						CIFDNI,			FormaPago,				TipoDocumento,		DefMoneda,					Idioma,			CodigoPortes,		DiaPago1,		
	--						DiaPago2,		DiaPago3,				Cuenta,				SubCuenta,	EstatusIntelIMES)
	--		SELECT			Proveedor,		Nombre,					Nombre,				(Direccion + ' ' + DireccionNumero + ' ' + DireccionNumeroInt),	Colonia,
	--						COALESCE(NULLIF(RTRIM(Delegacion), ''), NULLIF(RTRIM(Poblacion), '')),  Estado,			CodigoPostal,						ISNULL(@ClavePais, '116'), 
	--						RFC,			ISNULL(FormaPago,'Transferencia'),   '',					@ClaveMoneda,	Idioma,			'',					NULL,   
	--						NULL,			NULL,					Cuenta,				NULL,		0
	--		FROM Prov	
	--		WHERE Proveedor = @INTCuenta
			
	--		UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @INTCuenta 
	--	END
	--END		
	
	--ELSE IF @Catalogo = 'AlmMES'
	--BEGIN

	--	DELETE FROM AlmMES WHERE CodigoAlmacen = @INTCuenta
		
	--	IF @Eliminar = 0	
	--	BEGIN
	--		INSERT AlmMES (CodigoAlmacen,	RazonSocial,	NombreComercial,	Direccion1,																Direccion2, Poblacion, Provincia,   Pais,														CodigoPostal,	Idioma, Sucursal, EstatusIntelIMES)  
	--		SELECT		   Almacen,			Nombre,			Nombre,				RTRIM(ISNULL(Direccion, ''))+' '+RTRIM(ISNULL(DireccionNumero, '')),	Colonia,	Poblacion, Estado,		ISNULL((SELECT Clave FROM Pais WHERE Pais=Alm.Pais),'116'),	CodigoPostal,	Idioma, Sucursal, 0
	--		FROM Alm
	--		WHERE Almacen = @INTCuenta
		
	--		UPDATE Alm SET TieneMovimientos = 1 WHERE Almacen = @INTCuenta
	--	END
	--END						 
	
	--ELSE IF @Catalogo = 'UsuarioMES'
	--BEGIN

	--	DELETE FROM UsuarioMES WHERE Usuario = @INTCuenta

	--	IF @Eliminar = 0
	--	BEGIN
				
	--		INSERT UsuarioMES (Usuario, Nombre, Supervisor, Sucursal, EstatusIntelIMES)
	--		SELECT Usuario, Nombre, MESScheduling, Sucursal, 0
	--		FROM Usuario
	--		WHERE Usuario = @INTCuenta
		
	--		UPDATE Usuario SET TieneMovimientos = 1 WHERE Usuario = @INTCuenta
	--	END
	--END 
	
	--ELSE IF @Catalogo = 'ProyMES'
	--BEGIN

	--	DELETE FROM ProyMES WHERE Proy = @INTCuenta

	--	IF @Eliminar = 0	
	--		INSERT ProyMES (Proy, Descripcion, Categoria, FechaInicio, FechaFin, Tipo, Estatus, Cliente, ProyectoRama, EstatusIntelIMES)
	--		SELECT Proyecto, Descripcion, Categoria, FechaInicio, FechaFin, Tipo, CASE Estatus WHEN 'CONCLUIDO' THEN 'CIERRE' WHEN 'REVISION' THEN 'REAPERTURA' ELSE Estatus END, 
	--			Cliente, ProyectoRama, CASE Estatus WHEN 'CONCLUIDO' THEN 2 WHEN 'REVISION' THEN 2 ELSE 0 END
	--		FROM Proy
	--		WHERE Proyecto = @INTCuenta
	
	--END

	--ELSE IF @Catalogo = 'OperMES'
	--BEGIN

	--	DELETE FROM OperMES WHERE Operario = @INTCuenta

	--	IF @Eliminar = 0
	--	BEGIN	
	--		IF (SELECT MES FROM Personal WHERE Personal = @INTCuenta) = 1
	--			INSERT OperMES (Operario, Nombre, Sucursal, EstatusIntelIMES)
	--			SELECT Personal, RTRIM(Nombre) + ' ' + RTRIM(ISNULL(ApellidoPaterno, '')) + ' ' + RTRIM(ISNULL(ApellidoMaterno, '')), SucursalTrabajo, 0
	--			FROM Personal
	--			WHERE Personal = @INTCuenta
			
	--		UPDATE Personal SET TieneMovimientos = 1 WHERE Personal = @INTCuenta
		
	--	END
	
	--END

	--SELECT 'MES - Se Actualizo: ' + @Catalogo + ' : ' + @INTCuenta
	SELECT NULL
 RETURN
END
GO
-- EXEC spMESCatalogos 'Articulo', '0001'
-- EXEC spMESCatalogos NULL, NULL

IF exists(SELECT * FROM sysobjects WHERE ID = object_id('dbo.spMESSaldoInicial') AND type = 'p') DROP PROCEDURE spMESSaldoInicial
GO
CREATE PROCEDURE dbo.spMESSaldoInicial
					@Empresa	varchar ( 5)

AS 
BEGIN
 DECLARE

	@Articulo	varchar(20),
	@SubCuenta  varchar(50),
	@Almacen    varchar(10),
	@Sucursal	int,
	@ArtCosto	float,
	@Fecha		datetime

	IF NOT EXISTS (SELECT * FROM SaldoInicialMes)
	BEGIN
		SELECT @Fecha = GETDATE()

		INSERT INTO SaldoInicialMes (Articulo,   Subcuenta,			Almacen,	Lote, Cantidad, 
									 Moneda,	 EstatusIntelIMES,	Sucursal,	Unidad)

		SELECT						 a.Articulo, u.SubCuenta,		u.Grupo,	'',   SUM(ISNULL(u.CargoU, 0)-ISNULL(u.AbonoU, 0)),
									 m.Moneda,	 0,					u.Sucursal, a.Unidad
		  FROM AuxiliarU u
		  JOIN Art a				ON u.Cuenta = a.Articulo
		  JOIN MonMes m				ON u.Moneda = m.Descripcion
		  JOIN ArtCostoEmpresa ac	ON ac.Empresa = @Empresa AND a.Articulo = ac.Articulo
		 WHERE u.Rama			= 'INV'
		   AND a.TipoArticulo	IS NOT NULL
		   AND u.Empresa		= @Empresa
	  GROUP BY a.Articulo, u.SubCuenta, u.Grupo, m.Moneda, u.Sucursal, a.Unidad
		HAVING SUM(ISNULL(u.CargoU, 0)-ISNULL(u.AbonoU, 0)) > 0

		DECLARE crActualizaCosto CURSOR FOR
				SELECT Articulo, SubCuenta, Almacen, Sucursal FROM SaldoInicialMes
			OPEN crActualizaCosto
				FETCH NEXT FROM crActualizaCosto INTO @Articulo, @SubCuenta, @Almacen, @Sucursal
				WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
				BEGIN
					IF @@FETCH_STATUS <> -2 
					BEGIN
					
						SELECT @ArtCosto = CostoPromedio FROM ArtCosto WHERE Articulo = @Articulo AND Sucursal = @Sucursal AND Empresa = @Empresa

						UPDATE SaldoInicialMes SET Costo	= @ArtCosto, FechaProcesado = @Fecha
											 WHERE Articulo = @Articulo 
											   AND SubCuenta = @SubCuenta 
											   AND Almacen = @Almacen
					
					END
					FETCH NEXT FROM crActualizaCosto INTO @Articulo, @SubCuenta, @Almacen, @Sucursal
				END
			CLOSE crActualizaCosto
		DEALLOCATE crActualizaCosto
	END
	
	SELECT 'Proceso Concluido'

 RETURN
END
GO
