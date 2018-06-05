SET ANSI_DEFAULTS OFF
GO


--DROP TABLE SorianaRemision
/****** SorianaRemision ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaRemision')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaRemision','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaRemision') and type = 'U') 
CREATE TABLE dbo.SorianaRemision (
	ID						int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	Consecutivo				int			NULL,
	FechaRemision			varchar(10)	NULL,--datetime	NULL,
	Tienda					varchar(20) NULL,	
	TipoMoneda				varchar(10)	 NULL,
	TipoBulto				varchar(10) NULL,
	EntregaMercancia		varchar(20)	NULL,
	CumpleReqFiscales		varchar(10)	NULL,
	CantidadBultos			Float NULL,
	Subtotal				float NULL,
	Descuentos				float NULl,
	IEPS					float NULL,
	IVA						float NULL,
	OtrosImpuestos			float NULL, 
	Total					float NULL,
	CantidadPedidos			int NULL, 
	FechaEntregaMercancia	varchar(10)	NULL,--datetime NULL,
	EmpaqueEnCajas			varchar(10) NULL,
	EmpaqueEnTarimas		varchar(10) NULL,
	CantidadCajasTarimas	float NULL
	)


/****** SorianaPedimento ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaPedimento')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaPedimento','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaPedimento') and type = 'U') 
CREATE TABLE dbo.SorianaPedimento (
	ID						int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	Pedimento				varchar(20) NULL,
	Aduana					varchar(20) NULL,
	AgenteAduanal			varchar(50) NULL,	
	TipoPedimento			varchar(20) NULL,
	FechaPedimento			datetime NULL,
	FechaReciboLaredo		datetime NULL,
	FechaBillOfLading		datetime NULL)
	
/****** SorianaPedidos ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaPedidos')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaPedidos','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaPedidos') and type = 'U') 
CREATE TABLE dbo.SorianaPedidos (
	ID						Int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	FolioPedido				varchar(20) NULL,
	Tienda					varchar(20) NULL,
	CantidadArticulos		float NULL)


/****** SorianaArtCajaTarima ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaArtCajaTarima')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaArtCajaTarima','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaArtCajaTarima') and type = 'U') 
CREATE TABLE dbo.SorianaArtCajaTarima (
	ID						int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	FolioPedido				varchar(20) NULL,
	NumeroCajaTarima		int			NULL, 
	SucursalDistribuir		int			NULL, 
	Codigo					varchar(20) NULL, 
	CantidadUnidadCompra	float		NULL
	)

/****** SorianaCajasTarimas ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaCajasTarimas')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaCajasTarimas','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaCajasTarimas') and type = 'U') 
CREATE TABLE dbo.SorianaCajasTarimas (
	ID						Int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	NumeroCajaTarima		int			NULL,
	CodigoBarraCajaTarima	varchar(20) NULL,
	SucursalDistribuir		int			NULL,
	CantidadArticulos		float		NULL
	)

/****** SorianaArticulos ******/
if not exists(select * from SysTabla where SysTabla = 'SorianaArticulos')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('SorianaArticulos','Movimiento','VTAS')
if not exists (select * from sysobjects where id = object_id('dbo.SorianaArticulos') and type = 'U') 
CREATE TABLE dbo.SorianaArticulos (
	ID						Int			NOT NULL,
	Proveedor				varchar(20) NULL,
	Remision				varchar(20) NULL,
	FolioPedido				varchar(20) NULL,
	Tienda					varchar(20) NULL,
	Codigo					varchar(20) NULL,
	CantidadUnidadCompra	float		NULL,
	CostoNetoUnidadCompra	money		NULL,
	PorcentajeIEPS			float		NULL,
	PorcentajeIVA			float		NULL
	)
        

--EXEC spGenerarCFD 2, 'VTAS', 7182, 'CONSOLIDADO SORIANA'
--EXEC spCFDSorianaConsolidado 1, 'VTAS', 7182, 'CONSOLIDADO SORIANA'
/**************** spCFDSorianaConsolidado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDSorianaConsolidado') and type = 'P') drop procedure dbo.spCFDSorianaConsolidado
GO             
CREATE PROCEDURE spCFDSorianaConsolidado
			@Estacion	int,
			@Modulo		char(5),
			@ID		int,
			@Layout		varchar(50),

			@Validar	bit		= 0,
			@Ok		int		= NULL OUTPUT,
			@OkRef		varchar(255)	= NULL OUTPUT
WITH ENCRYPTION
AS BEGIN
DECLARE 
@Estatus varchar(20),
@Empresa varchar(10),
    @Sucursal			int,
    @Version			varchar(10),
    @noCertificado		varchar(20),
    @Mov			varchar(20),
    @MovID			varchar(20),
    @Referencia			varchar(50),
    @ReferenciaFecha		datetime,
    @ConsecutivoModulo		char(5),
    @ConsecutivoMov		varchar(20),
    @Fecha			datetime,
    @Serie 			varchar(20),
    @Folio			bigint,
    @FechaEmision		datetime,
    @noAprobacion		int,
    @fechaAprobacion		datetime,
    @MovTipo			varchar(20),
    @tipoDeComprobante		varchar(20),
    @FormaEnvio			varchar(50),
    @Condicion			varchar(50),
    @Vencimiento		datetime,
    @formaDePago		varchar(100),
    @metodoDePago		varchar(100),
    @Importe			money,
    @SubTotal			money,
    @Descuento			varchar(50),
    @DescuentosTotales		money,
    @ImpuestosTotal		money,
    @Total			money,
    @Cliente			varchar(10),
    @EnviarA			int,
    @Renglon			float,
    @RenglonSub			int,
    @RenglonID			int,
    @RenglonTipo		char(1),
    @Cantidad			float,
    @CantidadTotal		float,
    @Codigo			varchar(50),
    @Unidad			varchar(50),
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @noIdentificacion		varchar(100),
    @ArtDescripcion1		varchar(255),
    @ArtDescripcion2		varchar(255),
    @ArtTipoEmpaque		varchar(50),
    @TipoEmpaqueClave		varchar(20),
    @TipoEmpaqueTipo		varchar(20),

    @Precio			money,
    @PrecioLinea		money,
    @PrecioSinDescuentos	money,
    @SubTotalLinea		money,
    @TotalLinea			money,

    @SerieLote			varchar(50),
    @Pedimento			varchar(20), 
    @PedimentoFecha		datetime, 
    @Aduana			varchar(50),
    @AduanaGLN			varchar(50),
    @AduanaCiudad		varchar(50),
    @agenteAduanal 		varchar(10),
    @Impuesto1			float,

    @Impuesto1Linea		money,
    @Impuesto1SubTotal		money,
    @Impuesto1Total		money,

    @Impuesto1Promedio		float,
    @Impuesto2			float,
    @Impuesto2Linea		money,
    @Impuesto2SubTotal		money,
    @Impuesto2Total		money,

    @Impuesto2Promedio		float,
    @PctDescuentoLinea		float,

    @DescuentoLinea		money,
    @DescuentoGlobalLinea	money,

    @EmisorID 			varchar(20), 
    @ReceptorID 		varchar(20), 
    @ProveedorID 		varchar(20), 
    @ProveedorIDDeptoEnviarA	varchar(20),
    @TipoAddenda 		varchar(50),
    @ImporteDescuentoGlobal	money,
    @DescuentoGlobal		float,
    @OrdenCompra 		varchar(50),
    @FechaOrdenCompra		datetime,
    @Departamento		int,
    @ZonaImpuesto		varchar(30),
	@Moneda			char(10),	
    @MonedaClave		char(3),
    @Embarque 			varchar(50),
    @EmbarqueFecha 		datetime, 
    @Recibo 			varchar(50), 
    @ReciboFecha 		datetime,
    @TipoCambio			float,
    @FechaRequerida		datetime,
    @Observaciones		varchar(100),
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @AnticiposFacturados	money,
    @AnticiposImpuestos		money,
    @EntregaMercancia 		varchar(20),
    @ImporteEnLetra		varchar(255),
    @AddendaVersion 		varchar(10),
    @InformacionCompra 		varchar(20),
    @EnviarAClave		varchar(20),
	@CantidadBultos		float,
	@SorianaSubtotal	float,
	@PorcentajeIEPS		float,
	@PorcentajeIVA		float

  IF @Modulo = 'VTAS'
  BEGIN
    SELECT @Estatus = Estatus, @Empresa = Empresa, @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @FormaEnvio = FormaEnvio, @Condicion = Condicion, @Vencimiento = Vencimiento, @Cliente = Cliente, @EnviarA = EnviarA, @Descuento = Descuento, @DescuentoGlobal = DescuentoGlobal,
           @OrdenCompra = OrdenCompra, @FechaOrdenCompra = FechaOrdenCompra, @Departamento = Departamento, @ZonaImpuesto = ZonaImpuesto, @Moneda = Moneda, @TipoCambio = TipoCambio, @FechaRequerida = FechaRequerida, @Observaciones = Observaciones,
           @Referencia = Referencia, @FechaEmision = FechaEmision, @Origen = Origen, @OrigenID = OrigenID,
           @AnticiposFacturados = AnticiposFacturados, @Anticiposimpuestos = AnticiposImpuestos
      FROM Venta 
     WHERE ID = @ID


      SELECT @CantidadTotal = SUM(Cantidad), @Importe = SUM(Importe*TipoCambio), @DescuentosTotales = SUM(DescuentosTotales*TipoCambio), --@Total = SUM(ImporteTotal*TipoCambio), 
             @Impuesto1Total = SUM(Impuesto1Total*TipoCambio), @Impuesto2Total = SUM(Impuesto2Total*TipoCambio), @ImpuestosTotal = SUM(Impuestos*TipoCambio),
             @ImporteDescuentoGlobal = SUM(ImporteDescuentoGlobal*TipoCambio)
        FROM VentaTCalc 
       WHERE ID = @ID


    SELECT @Embarque = Embarque, @EmbarqueFecha = EmbarqueFecha, @Recibo = Recibo, @ReciboFecha = ReciboFecha, @EntregaMercancia = EntregaMercancia
      FROM VentaEntrega
     WHERE ID = @ID

  EXEC spMovIDEnSerieConsecutivo @MovID, @Serie OUTPUT, @Folio OUTPUT
  SELECT @Fecha = Fecha FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID


  SELECT @SubTotal = Round(@Importe - @ImporteDescuentoGlobal - ISNULL(@AnticiposFacturados,0) + ISNULL(@AnticiposImpuestos,0),2)
  SELECT @ImpuestosTotal = ROUND(@ImpuestosTotal - ISNULL(@AnticiposImpuestos,0),2)
  SELECT @Total = @SubTotal + @ImpuestosTotal
  SELECT @ImporteEnLetra = dbo.fnNumeroEnEspanol(@Total, @Moneda)

  SELECT @Impuesto1Total = ROUND(@Impuesto1Total - ISNULL(@AnticiposImpuestos,0),2)

  SELECT @ReceptorID = ReceptorID, @TipoAddenda = TipoAddenda, 
         @AddendaVersion = CASE WHEN VersionFecha < @Fecha OR VersionFecha IS NULL THEN Version ELSE VersionAnterior END
    FROM CteCFD
   WHERE Cliente = @Cliente
 
  SELECT @EmisorID = EmisorID, @ProveedorID = ProveedorID, @InformacionCompra = InformacionCompra
    FROM CteEmpresaCFD
   WHERE Cliente = @Cliente AND Empresa = @Empresa

  SELECT @ProveedorIDDeptoEnviarA = ProveedorID 
    FROM CteDeptoEnviarA 
   WHERE Cliente = @Cliente AND Departamento = @Departamento AND Empresa = @Empresa AND EnviarA = @EnviarA

  SELECT @EnviarAClave = ISNULL(NULLIF(RTRIM(Clave), ''), CONVERT(varchar(20), ID))
    FROM CteEnviarA
   WHERE Cliente = @Cliente AND ID = @EnviarA

  SELECT @EmisorID = EmisorID, @ProveedorID = ProveedorID, @InformacionCompra = InformacionCompra
    FROM CteEmpresaCFD
   WHERE Cliente = @Cliente AND Empresa = @Empresa

  IF @Layout = 'CONSOLIDADO SORIANA'
  BEGIN

   SELECT @CantidadBultos = Count(NumeroCajaTarima)  FROM SorianaCajasTarimas
    WHERE ID = @ID

   SELECT @SorianaSubtotal = SUM(CantidadUnidadCompra * CostoNetoUnidadCompra) FROM SorianaArticulos 
    WHERE ID = @ID

   SELECT @PorcentajeIEPS = PorcentajeIEPS, @PorcentajeIEPS = PorcentajeIVA FROM SorianaArticulos WHERE ID = @ID
  SELECT @MonedaClave = Clave FROM Mon WHERE Moneda = @Moneda


    SELECT '<cfdi:Addenda>'

  IF NOT EXISTS (SELECT ID FROM SorianaArticulos WHERE ID = @ID) AND NOT EXISTS (SELECT ID FROM SorianaCajasTarimas WHERE ID = @ID) AND NOT EXISTS (SELECT ID FROM SorianaArtCajaTarima WHERE ID = @ID)
     SELECT '<ERROR>FALTA CARGAR DATOS DE LA REMISION</ERROR>'
  ELSE
  IF ABS(ISNULL(@SorianaSubtotal,0.0)- ISNULL(@SubTotal,0.0)) > 0.05
     SELECT '<ERROR>EL TOTAL DE LA FACTURA NO COINCIDE CON EL TOTAL DE LOS ARTICULOS CARGADOS EN EXCELL</ERROR>'
  ELSE 
  BEGIN
      SELECT '<DSCargaRemisionProv>'
   
      SELECT 1												as Tag,
             NULL											as Parent,   
             'Remision'+Convert(varchar,row_number() Over(order by Proveedor, Remision)) 
															as [Remision!1!ID],
             --row_number() Over(order by Proveedor, Remision) as [Remision!1!RowOrder],
			 '0'											as [Remision!1!RowOrder],
             Proveedor										as [Remision!1!Proveedor!ELEMENT],
             Remision										as [Remision!1!Remision!ELEMENT],
             Consecutivo									as [Remision!1!Consecutivo!ELEMENT],
             convert(datetime,FechaRemision)				as [Remision!1!FechaRemision!ELEMENT],
             Tienda											as [Remision!1!Tienda!ELEMENT],
             TipoMoneda										as [Remision!1!TipoMoneda!ELEMENT],
             TipoBulto										as [Remision!1!TipoBulto!ELEMENT],
             EntregaMercancia								as [Remision!1!EntregaMercancia!ELEMENT],
             CumpleReqFiscales								as [Remision!1!CumpleReqFiscales!ELEMENT],
             convert(decimal (20,2),CantidadBultos)			as [Remision!1!CantidadBultos!ELEMENT],
             ROUND(convert(money,Subtotal),2)				as [Remision!1!Subtotal!ELEMENT],
             ROUND(convert(money,Descuentos),2)				as [Remision!1!Descuentos!ELEMENT],
             ROUND(convert(money,IEPS),2)					as [Remision!1!IEPS!ELEMENT],
             ROUND(convert(money,IVA),2)					as [Remision!1!IVA!ELEMENT],
             ROUND(convert(money,OtrosImpuestos),2)			as [Remision!1!OtrosImpuestos!ELEMENT],
             ROUND(convert(money,Total),2)					as [Remision!1!Total!ELEMENT],
             CantidadPedidos								as [Remision!1!CantidadPedidos!ELEMENT],
             convert(datetime,FechaEntregaMercancia)		as [Remision!1!FechaEntregaMercancia!ELEMENT],
             EmpaqueEnCajas									as [Remision!1!EmpaqueEnCajas!ELEMENT],
             EmpaqueEnTarimas								as [Remision!1!EmpaqueEnTarimas!ELEMENT],
             convert(decimal (20,0),CantidadCajasTarimas)	as [Remision!1!CantidadCajasTarimas!ELEMENT]
        FROM SorianaRemision Remision 
       WHERE ID = @ID
         FOR XML EXPLICIT

  SELECT 1						as Tag,
         NULL					as Parent,
         'Pedidos'+Convert(varchar,row_number() Over(order by Proveedor, Remision, FolioPedido, Tienda)) 
								as [Pedidos!1!ID],
         row_number() Over(order by Proveedor, Remision, FolioPedido, Tienda) 
								as [Pedidos!1!RowOrder],
         Proveedor				as [Pedidos!1!Proveedor!ELEMENT],
         Remision				as [Pedidos!1!Remision!ELEMENT],
         FolioPedido			as [Pedidos!1!FolioPedido!ELEMENT],
         Tienda					as [Pedidos!1!Tienda!ELEMENT],
         count(distinct Codigo) as [Pedidos!1!CantidadArticulos!ELEMENT]
    FROM SorianaArticulos Pedidos 
   WHERE ID = @ID
   GROUP BY Proveedor, Remision, FolioPedido, Tienda
     FOR XML EXPLICIT

  SELECT 1					as Tag,
         NULL				as Parent,
         'Pedimento'+Convert(varchar,row_number() Over(order by ID, Proveedor, Remision, Pedimento)) 
							as [Pedimento!1!ID],
         row_number() Over(order by ID, Proveedor, Remision, Pedimento) 
							as [Pedimento!1!RowOrder],
         Proveedor			as [Pedimento!1!Proveedor!ELEMENT],
         Remision			as [Pedimento!1!Remision!ELEMENT],
         Pedimento			as [Pedimento!1!Pedimento!ELEMENT],
         Aduana				as [Pedimento!1!Aduana!ELEMENT],
         AgenteAduanal		as [Pedimento!1!AgenteAduanal!ELEMENT],
         TipoPedimento		as [Pedimento!1!TipoPedimento!ELEMENT],
         FechaPedimento		as [Pedimento!1!FechaPedimento!ELEMENT],
         FechaReciboLaredo  as [Pedimento!1!FechaReciboLaredo!ELEMENT],
         FechaBillOfLading  as [Pedimento!1!FechaBillOfLading!ELEMENT]
    FROM SorianaPedimento Pedimento
   WHERE ID = @ID
     FOR XML EXPLICIT



  SELECT 1												as Tag,
         NULL											as Parent,
         'Articulos'+Convert(varchar,row_number() Over(order by Id))	
														as [Articulos!1!ID],
         row_number() Over(order by Id)					as [Articulos!1!RowOrder],
         Proveedor										as [Articulos!1!Proveedor!ELEMENT],
         Remision										as [Articulos!1!Remision!ELEMENT],
         FolioPedido									as [Articulos!1!FolioPedido!ELEMENT], 
         Tienda											as [Articulos!1!Tienda!ELEMENT], 
         Codigo											as [Articulos!1!Codigo!ELEMENT],
         convert(decimal (20,0),CantidadUnidadCompra)	as [Articulos!1!CantidadUnidadCompra!ELEMENT],
         convert(money,CostoNetoUnidadCompra)			as [Articulos!1!CostoNetoUnidadCompra!ELEMENT],
         convert(decimal (20,2),PorcentajeIEPS)			as [Articulos!1!PorcentajeIEPS!ELEMENT],
         convert(decimal (20,2),PorcentajeIVA)			as [Articulos!1!PorcentajeIVA!ELEMENT]
    FROM SorianaArticulos 
   WHERE ID = @ID
     FOR XML EXPLICIT

 SELECT 1    as Tag,
        NULL as Parent,
        'CajasTarimas'+Convert(varchar,row_number() Over(order by Id)) as [CajasTarimas!1!ID],
        row_number() Over(order by Id) as [CajasTarimas!1!RowOrder],
        Proveedor  as [CajasTarimas!1!Proveedor!ELEMENT],
        Remision as [CajasTarimas!1!Remision!ELEMENT],
        NumeroCajaTarima  as [CajasTarimas!1!NumeroCajaTarima!ELEMENT],
        CodigoBarraCajaTarima as [CajasTarimas!1!CodigoBarraCajaTarima!ELEMENT],
        SucursalDistribuir as [CajasTarimas!1!SucursalDistribuir!ELEMENT],
        CONVERT(Decimal(20,0), CantidadArticulos)  as [CajasTarimas!1!CantidadArticulos!ELEMENT]
   FROM SorianaCajasTarimas CajasTarimas 
   WHERE ID = @ID
   FOR XML EXPLICIT

   SELECT 'Consecutivo'=row_number() Over(order by NumeroCajaTarima, Codigo), NumeroCajaTarima, Codigo
    INTO #SorianaArtCajaTarima
    FROM SorianaArtCajaTarima
   WHERE ID = @ID
   GROUP BY NumeroCajaTarima, Codigo
   ORDER BY  NumeroCajaTarima, Codigo

 SELECT 1    as Tag,
        NULL as Parent,
        'ArticulosPorCajaTarima'+Convert(varchar,Consecutivo) as [ArticulosPorCajaTarima!1!ID],
        Consecutivo as [ArticulosPorCajaTarima!1!RowOrder],
        ArticulosPorCajaTarima.Proveedor as [ArticulosPorCajaTarima!1!Proveedor!ELEMENT],
        ArticulosPorCajaTarima.Remision as [ArticulosPorCajaTarima!1!Remision!ELEMENT],
        ArticulosPorCajaTarima.FolioPedido as [ArticulosPorCajaTarima!1!FolioPedido!ELEMENT],
        ArticulosPorCajaTarima.NumeroCajaTarima as [ArticulosPorCajaTarima!1!NumeroCajaTarima!ELEMENT],
        ArticulosPorCajaTarima.SucursalDistribuir as [ArticulosPorCajaTarima!1!SucursalDistribuir!ELEMENT],
        ArticulosPorCajaTarima.Codigo as [ArticulosPorCajaTarima!1!Codigo!ELEMENT],
        CONVERT(Decimal(20,0), CantidadUnidadCompra)  as [ArticulosPorCajaTarima!1!CantidadUnidadCompra!ELEMENT]
   FROM SorianaArtCajaTarima ArticulosPorCajaTarima 
   JOIN #SorianaArtCajaTarima a 
     ON ArticulosPorCajaTarima.NumeroCajaTarima = a.NumeroCajaTarima AND  ArticulosPorCajaTarima.Codigo=a.Codigo
  WHERE ID = @ID
  ORDER BY a.NumeroCajaTarima, a.Codigo
   FOR XML EXPLICIT

    SELECT '</DSCargaRemisionProv>'

    END
  SELECT '</cfdi:Addenda>'
  END

END--Fin de IF @Modulo = VTAS

END
GO