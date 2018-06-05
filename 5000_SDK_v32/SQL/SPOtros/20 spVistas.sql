/* SP VISTAS     */
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

-- spVerCosto 0, 'DEMO', 'P1', 'A1', '', 'Docena', 'Ultimo', 'Dolar', 10
/**************** spVerCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCosto') and sysstat & 0xf = 4) drop procedure dbo.spVerCosto
GO             
CREATE PROCEDURE spVerCosto
			@Sucursal	int,
                        @Empresa	char(5),
			@Proveedor	char(10),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@MovUnidad	varchar(50),
			@Cual		char(20),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
                        @MovCosto 	money   = NULL OUTPUT,
			@ConReturn      bit     = 1,
			@Precio		money	= NULL,
			@Modulo		char(5)	= NULL,
			@ModuloID	int	= NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CostoNivelOpcion		bit,
    @CfgMultiUnidadesNivel	char(20),
    @UltCostoProv		bit,
    @ArtMoneda			char(10),
    @ArtTipo			varchar(20),
    @UltCosto			money,
    @Costo			money,
    @Ultimo			money,
    @UltimoSinGastos		money,
    @Estandar			money,
    @Reposicion			money,
    @Promedio			money,
    @ArtFactor			float,
    @ArtTipoCambio		float,
    @UnidadFactor		float,
    @Margen			float,
    @Decimales			int,
    @Ok				int,
    @CostoOk			bit,
    @Mensaje			varchar(255),
    @UltimoCosto		money,
    @FechaUltimaCompra		datetime,
    @UltimaCotizacion		money,
    @FechaCotizacion		datetime,
    @SugerirCostoArtServicio	varchar(20),
    @Impuesto1			float,
    @Impuesto2			float,
    @Impuesto3			float,
    @JuntarImpuestos		float,
    @CfgImpInc			bit,	
    @CfgPrecioMoneda		bit,
    @RedondeoMonetarios		int,
    @Impuesto2Info		bit,
    @Impuesto3Info		bit

  SELECT @RedondeoMonetarios = RedondeoMonetarios, @Impuesto2Info = ISNULL(Impuesto2Info, 0), @Impuesto3Info = ISNULL(Impuesto3Info, 0) FROM Version
  
  SELECT @UltCosto = @MovCosto, 
         @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), ''), '0'), 
         @UltCostoProv = 0, 
         @Proveedor = NULLIF(NULLIF(RTRIM(@Proveedor), ''), '0'), 
         @MovUnidad = NULLIF(NULLIF(RTRIM(@MovUnidad), ''), '0'), 
         @CostoOk = 0 

  EXEC xpVerCosto @Empresa, @Proveedor, @Articulo,  @MovUnidad, @Cual, @MovMoneda, @MovTipoCambio, @MovCosto OUTPUT
  IF @MovCosto = @UltCosto
  BEGIN
    -- Inicializar Variables
    SELECT @ArtFactor = 1.0, @UnidadFactor = 1.0, @Costo = NULL, @MovCosto = NULL, @Cual = NULLIF(UPPER(RTRIM(@Cual)), '')
    SELECT @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD'), 
           @UltCostoProv = ISNULL(CompraSugerirUltimoCostoProv, 0)
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa 

    SELECT @CostoNivelOpcion        = CosteoNivelSubCuenta, 
           @SugerirCostoArtServicio = ISNULL(NULLIF(RTRIM(UPPER(SugerirCostoArtServicio)), ''), 'NO'),
           @CfgImpInc		    = VentaPreciosImpuestoIncluido,
           @CfgPrecioMoneda	    = VentaPrecioMoneda
      FROM EmpresaCfg 
     WHERE Empresa = @Empresa 
    IF @SugerirCostoArtServicio <> 'NO'
    BEGIN
      SELECT @ArtTipo = UPPER(Tipo) FROM Art WHERE Articulo = @Articulo
      IF @ArtTipo IN ('SERVICIO', 'JUEGO') 
        SELECT @Cual = @SugerirCostoArtServicio
    END
    IF @Proveedor IS NOT NULL AND @UltCostoProv = 1
    BEGIN     
      SELECT @MovCosto = NULL
      IF @MovUnidad IS NOT NULL
        SELECT @MovCosto = NULLIF(UltimoCosto, 0)
          FROM ArtProvUnidad
         WHERE Articulo = @Articulo AND ISNULL(RTRIM(SubCuenta), '') = ISNULL(@SubCuenta, '') AND Proveedor = @Proveedor AND Unidad = @MovUnidad
      ELSE
      BEGIN
        SELECT @UltimoCosto = UltimoCosto,
               @FechaUltimaCompra = UltimaCompra,
               @UltimaCotizacion = UltimaCotizacion,
               @FechaCotizacion = FechaCotizacion
          FROM ArtProv 
         WHERE Articulo = @Articulo AND ISNULL(RTRIM(SubCuenta), '') = ISNULL(@SubCuenta, '') AND Proveedor = @Proveedor
        IF @FechaCotizacion > @FechaUltimaCompra 
          SELECT @MovCosto = @UltimaCotizacion
        ELSE
          SELECT @MovCosto = @UltimoCosto
      END

      IF @MovCosto IS NOT NULL 
      BEGIN
        SELECT @ArtMoneda = MonedaCosto FROM Art WHERE Articulo = @Articulo

        IF @MovMoneda<>@ArtMoneda
          EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT, @Modulo, @ModuloID

        SELECT @MovCosto = ISNULL(@MovCosto*@ArtFactor, 0.0)

        SELECT @CostoOk = 1
      END
    END

    IF @CostoOk = 0
    BEGIN
      IF @Cual NOT IN (NULL, 'NO')
      BEGIN
        IF @Cual IN ('ESTANDAR', 'REPOSICION') AND @SubCuenta IS NOT NULL
        BEGIN
           SELECT @Estandar   = CostoEstandar,
                  @Reposicion = CostoReposicion
             FROM ArtSub
            WHERE Articulo = @Articulo
              AND SubCuenta = @SubCuenta

           IF @@ROWCOUNT = 0 AND NOT EXISTS(SELECT * FROM ArtSub WHERE Articulo = @Articulo)
             SELECT @Estandar   = CostoEstandar,
                    @Reposicion = CostoReposicion
               FROM Art
              WHERE Articulo = @Articulo
        END ELSE
        BEGIN
          IF @CostoNivelOpcion  = 1 AND @SubCuenta IS NOT NULL
            SELECT @ArtMoneda 	= MonedaCosto, 
                   @Ultimo    	= UltimoCosto,
                   @UltimoSinGastos = UltimoCostoSinGastos,
                   @Estandar  	= Art.CostoEstandar,
                   @Reposicion	= Art.CostoReposicion,
                   @Promedio  	= CostoPromedio,
                   @Precio	= ISNULL(@Precio, PrecioLista),
                   @Margen	= Margen,
                   @Impuesto1   = Art.Impuesto1
              FROM Art
              LEFT OUTER JOIN ArtSubCosto ON Art.Articulo = ArtSubCosto.Articulo AND ArtSubCosto.Sucursal = @Sucursal AND ArtSubCosto.Empresa = @Empresa AND ArtSubCosto.SubCuenta = @SubCuenta
             WHERE Art.Articulo = @Articulo
          ELSE
            SELECT @ArtMoneda 	= MonedaCosto, 
                   @Ultimo    	= UltimoCosto,
                   @UltimoSinGastos = UltimoCostoSinGastos,
                   @Estandar  	= Art.CostoEstandar,
                   @Reposicion	= Art.CostoReposicion,
                   @Promedio  	= CostoPromedio,
                   @Precio	= ISNULL(@Precio, PrecioLista),
                   @Margen      = Margen,
                   @Impuesto1   = ISNULL(Art.Impuesto1, 0),
                   @Impuesto2   = ISNULL(Art.Impuesto2, 0),
                   @Impuesto3   = ISNULL(Art.Impuesto3, 0)
              FROM Art
              LEFT OUTER JOIN ArtCosto ON Art.Articulo = ArtCosto.Articulo AND ArtCosto.Sucursal = @Sucursal AND ArtCosto.Empresa = @Empresa 
             WHERE Art.Articulo = @Articulo
        END
        IF @Impuesto2Info = 1 SELECT @Impuesto2 = 0.0
        IF @Impuesto3Info = 1 SELECT @Impuesto3 = 0.0

        IF @CfgImpInc = 1
        BEGIN
          SELECT @JuntarImpuestos = ((100+@Impuesto2)*(1+((@Impuesto1)/100))-100)
          SELECT @Precio = (@Precio-@Impuesto3)/(1+(@JuntarImpuestos/100))		
        END

        IF @Cual = 'PROMEDIO'     SELECT @Costo = @Promedio   ELSE
        IF @Cual = 'ESTANDAR'     SELECT @Costo = @Estandar   ELSE
        IF @Cual = 'REPOSICION'   SELECT @Costo = @Reposicion ELSE
        IF @Cual = 'PRECIO LISTA' SELECT @Costo = @Precio     ELSE
        IF @Cual = 'MARGEN'       SELECT @Costo = (@Precio*(100-@Margen))/100 ELSE
--      IF @Cual = 'ULTIMO' 	SELECT @Costo = @Ultimo     ELSE
        IF @Cual = 'ULTIMO (AUTOTRANS)'       SELECT @Costo = @Ultimo/(1+(@Impuesto1/100)) ELSE
        IF @Cual = 'ULTIMO COSTO S/GASTO'  SELECT @Costo = @UltimoSinGastos 
        ELSE SELECT @Costo = @Ultimo

        IF @MovMoneda<>@ArtMoneda
          EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT, @Modulo, @ModuloID

        SELECT @MovCosto = ISNULL(@Costo*@ArtFactor, 0.0)
        IF @CfgMultiUnidadesNivel = 'ARTICULO'
          EXEC xpArtUnidadFactor @Articulo, NULL, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT, @Ok OUTPUT
        ELSE
          EXEC xpUnidadFactor @Articulo, NULL, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT

        SELECT @MovCosto = @MovCosto*@UnidadFactor
      END
    END
  END
  SELECT @MovCosto = ROUND(@MovCosto, @RedondeoMonetarios)

  IF @ConReturn = 1 SELECT "Costo" = @MovCosto
END
GO

-- spVerCosto 0, 'DEMO', 'P3', 'FLETE', NULL, NULL, NULL, 'Pesos', 1
-- spVerCosto 0, 'DEMO', 'MLISTONES', 'CINTAS BORDADAS', NULL, 'Rollo', 'Ultimo', 'Dolares', 10
-- spVerCosto 0, 'DEMO', 'MLISTONES', 'CINTAS BORDADAS', NULL, 'mts', 'Ultimo', 'Dolares', 10

-- spVerCostoPoliticaPrecios 'DEMO', 'A1', NULL, NULL
/**************** spVerCostoPoliticaPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCostoPoliticaPrecios') and sysstat & 0xf = 4) drop procedure dbo.spVerCostoPoliticaPrecios
GO             
CREATE PROCEDURE spVerCostoPoliticaPrecios
			@Empresa	    char(5),
			@Articulo	    char(20),
			@SubCuenta	    varchar(50),
			@Sucursal	    int	 	= 0,
			@Descripcion	varchar(100) 	= NULL,
			@MovUnidad		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Costo	money,
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @UnidadFactor			float,
    @Decimales				float

  SELECT @CfgMultiUnidades         = MultiUnidades,
     	 @CfgMultiUnidadesNivel    = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  SELECT @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), ''), '0'), @Costo = NULL
  IF @SubCuenta IS NOT NULL
     SELECT @Costo = c.UltimoCosto 
       FROM ArtSubCosto c
      WHERE c.Empresa = @Empresa AND c.Articulo = @Articulo AND c.SubCuenta = @SubCuenta 
        AND c.Sucursal = @Sucursal

  IF @Costo IS NULL
    SELECT @Costo = c.UltimoCosto 
      FROM ArtCosto c
     WHERE c.Empresa = @Empresa AND c.Articulo = @Articulo 
       AND c.Sucursal = @Sucursal

  IF (SELECT VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa) = 1
  BEGIN
    SELECT @Costo = dbo.fnPrecioConImpuestos(@Empresa, @Articulo, @Costo)
  END
   
  IF @CfgMultiUnidades = 1
  BEGIN
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT, NULL
    ELSE
      EXEC xpUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @UnidadFactor OUTPUT, @Decimales OUTPUT
  END
  IF NULLIF(@UnidadFactor,0) IS NULL SELECT @UnidadFactor = 1
  SELECT @Costo = @Costo*@UnidadFactor

  SELECT "Costo" = @Costo
END
GO

/**************** spVerArtAlmExistencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerArtAlmExistencia') and type = 'P') drop procedure dbo.spVerArtAlmExistencia
GO             
CREATE PROCEDURE spVerArtAlmExistencia
		    @Sucursal		int,
            @Empresa		char(5),
	        @Articulo		char(20),
		    @ArtTipo		char(20),
            @Almacen		char(10),
            @Descripcion	varchar(255) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @AlmacenTipo		varchar(20),
    @Tipo				varchar(20),
    @TipoOpcion			varchar(20),
    @Localizacion		varchar(50),
    @Pasillo			varchar(50),
    @Anaquel			varchar(50),
    @Estante			varchar(50),
    @Disponible	 		float,
    @Reservado   		float,
    @PorProcesar 		float,
    @Remisionado		float,
    @ExistenciaAlterna	float,
    @SeVende			bit,
    @SeCompra			bit,
    @SeProduce			bit,
    @TieneSustitutos	bit,
    @Espacios			bit,
    @Apartado			float

  SELECT @PorProcesar = NULL, @ExistenciaAlterna = NULL, @Localizacion = NULL, @Disponible = NULL, @Reservado = NULL, @Remisionado = NULL
  SELECT @Tipo = Tipo, @TipoOpcion = TipoOpcion, @TieneSustitutos = Sustitutos, @SeVende = SeVende, @SeCompra = SeCompra, @SeProduce = SeProduce, @Espacios = Espacios FROM Art WHERE Articulo = @Articulo
  SELECT @Localizacion = MIN(Localizacion)
    FROM ArtAlm WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
  SELECT @AlmacenTipo = UPPER(Tipo) FROM Alm WHERE Almacen = @Almacen
 
  SELECT @Pasillo = Pasillo, @Anaquel = Anaquel, @Estante = Estante
    FROM ArtAlm WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen AND Localizacion = @Localizacion

  IF @AlmacenTipo = 'ACTIVOS FIJOS'
    SELECT @Disponible 	= SUM(SaldoU) FROM SaldoU WHERE Rama = 'AF' AND Empresa = @Empresa AND Cuenta = @Articulo AND Grupo = @Almacen
  ELSE BEGIN
    SELECT @Disponible 	= Convert(float, Disponible)   FROM ArtDisponible    WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
    SELECT @Reservado  	= Convert(float, Reservado)    FROM ArtReservado     WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
    SELECT @Remisionado = SUM(Remisionado)             FROM ArtRemisionado   WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
    SELECT @Apartado    = SUM(Apartado)                FROM ArtApartadoTarima WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen
    SELECT @Disponible = @Disponible - ISNULL(@Apartado,0)
  END

/*  IF EXISTS(SELECT * FROM ArtVtasMostrador WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Almacen)
    SELECT @PorProcesar = SUM(-Cantidad) 
      FROM Venta f, VentaD d
     WHERE f.ID = d.ID
       AND f.Empresa = @Empresa 
       AND d.Almacen = @Almacen
       AND f.Estatus = 'PROCESAR'
       AND d.Articulo = @Articulo 
       AND d.Cantidad < 0
*/
  IF UPPER(@ArtTipo) = 'PARTIDA'
  BEGIN
    SELECT @ExistenciaAlterna = SUM(ExistenciaAlterna)
      FROM SerieLote 
     WHERE Empresa = @Empresa
       AND Articulo = @Articulo
       AND Almacen = @Almacen
       AND Sucursal = @Sucursal
  END

  SELECT "Empresa" = @Empresa, "Articulo" = @Articulo, "Almacen" = @Almacen, "Disponible" = @Disponible, "Reservado" = @Reservado, "Remisionado" = @Remisionado, "PorProcesar" = @PorProcesar, "ExistenciaAlterna" = @ExistenciaAlterna, "Descripcion" = @Descripcion, "Localizacion" = @Localizacion, "SeVende" = @SeVende, "SeCompra" = @SeCompra, "SeProduce" = @SeProduce, "TieneSustitutos" = @TieneSustitutos, "Tipo" = @Tipo, "TipoOpcion" = @TipoOpcion, "Espacios" = @Espacios, "Pasillo" = @Pasillo, "Anaquel" = @Anaquel, "Estante" = @Estante, "Apartado" = @Apartado
END
GO

/**************** spVerEfectivoPorAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerEfectivoPorAplicar') and type = 'P') drop procedure dbo.spVerEfectivoPorAplicar
GO             
CREATE PROCEDURE spVerEfectivoPorAplicar
                    @Empresa		char(5),
		    @Modulo		char(5),
		    @Moneda		char(10),
                    @ClienteProv	char(10)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Efectivo 	money,
    @Pendiente	money,
    @Importe	money

  SELECT @Efectivo = 0.0, @Pendiente = 0.0, @Importe = 0.0
  IF @Modulo = 'CXC' SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
  IF @Modulo = 'CXP' SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxpEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv 
  IF @Efectivo < 0.0
  BEGIN
    IF @Modulo = 'CXC' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
    IF @Modulo = 'CXP' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv
    IF @Efectivo < -@Pendiente SELECT @Importe = @Pendiente ELSE SELECT @Importe = -@Efectivo
  END

  SELECT "Importe" = @Importe
  RETURN
END
GO

/**************** spVerEfectivoSobrante ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerEfectivoSobrante') and type = 'P') drop procedure dbo.spVerEfectivoSobrante
GO             
CREATE PROCEDURE spVerEfectivoSobrante
                    @Empresa		char(5),
		    @Modulo		char(5),
		    @Moneda		char(10),
                    @ClienteProv	char(10),
		    @Referencia		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Efectivo 	money,
    @Pendiente	money,
    @Importe	money

  SELECT @Efectivo = 0.0, @Pendiente = 0.0, @Importe = 0.0
  IF @Modulo = 'CXC' SELECT @Efectivo = ISNULL(-Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
  IF @Modulo = 'CXP' SELECT @Efectivo = ISNULL(-Saldo, 0.0) FROM CxpEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv

  IF @Efectivo > 0.0
  BEGIN
    IF @Modulo = 'CXC' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
    IF @Modulo = 'CXP' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv
    IF @Efectivo > @Pendiente SELECT @Importe = @Efectivo - @Pendiente
  END

  SELECT "Importe" = @Importe
  RETURN
END
GO

/**************** spVerEfectivoPorAplicar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerEfectivoPorAplicar') and type = 'P') drop procedure dbo.spVerEfectivoPorAplicar
GO             
CREATE PROCEDURE spVerEfectivoPorAplicar
                    @Empresa		char(5),
		    @Modulo		char(5),
		    @Moneda		char(10),
                    @ClienteProv	char(10),
		    @Referencia		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Efectivo	money,
    @Pendiente	money,
    @Importe	money

  SELECT @Efectivo = 0.0, @Pendiente = 0.0, @Importe = 0.0
  IF @Modulo = 'CXC' SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxcEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
  IF @Modulo = 'CXP' SELECT @Efectivo = ISNULL(Saldo, 0.0) FROM CxpEfectivo WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv 
  IF @Efectivo < 0.0
  BEGIN
    IF @Modulo = 'CXC' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxcPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Cliente   = @ClienteProv ELSE
    IF @Modulo = 'CXP' SELECT @Pendiente = ISNULL(Sum(Saldo), 0.0) FROM CxpPendiente WHERE Empresa = @Empresa AND Moneda = @Moneda AND Proveedor = @ClienteProv
    IF @Efectivo < -@Pendiente SELECT @Importe = @Pendiente ELSE SELECT @Importe = -@Efectivo
  END

  SELECT "Importe" = @Importe
  RETURN
END
GO



/**************** spVerMoratorios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMoratorios') and type = 'P') drop procedure dbo.spVerMoratorios
GO             
CREATE PROCEDURE spVerMoratorios
		    @Empresa		char(5),
                    @Tasa		float,
		    @Moneda		char(10),
                    @Cliente     	char(10)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  SELECT "Importe" = ISNULL(SUM(ISNULL(Saldo, 0.0) * ISNULL(DiasMoratorios, 0.0) * (@Tasa/100)), 0.0) 
    FROM CxcPendiente 
   WHERE Empresa = @Empresa
     AND Moneda  = @Moneda
     AND Cliente = @Cliente
     AND ISNULL(DiasMoratorios, 0) > 0
  RETURN
END
GO

-- spBuscarContrato 'DEMO', 'CIVIC', '123456'
/**************** spBuscarContrato ****************/
if exists (select * from sysobjects where id = object_id('dbo.spBuscarContrato') and type = 'P') drop procedure dbo.spBuscarContrato
GO             
CREATE PROCEDURE spBuscarContrato
		    @Empresa		char(5),
                    @Articulo		char(20),
		    @Serie		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Mov		char(20),
    @MovID		varchar(20),
    @Tipo		varchar(50),
    @Garantia		bit,
    @Cliente		char(10),
    @Placas		varchar(20),
    @NumeroEconomico	varchar(20),
    @Aseguradora	varchar(10)

  SELECT @Articulo = NULLIF(NULLIF(RTRIM(@Articulo), ''), '0')
  SELECT @Mov = NULL, @MovID = NULL, @Tipo = NULL, @Garantia = NULL, @Cliente = NULL, @Placas = NULL, @NumeroEconomico = NULL, @Aseguradora = NULL
  SELECT @Articulo = ISNULL(Articulo, @Articulo), @Cliente = Cliente, @Placas = Placas, @NumeroEconomico = NumeroEconomico FROM VIN WHERE VIN = @Serie
  IF @Articulo IS NULL
    SELECT @Articulo = MIN(Articulo) FROM SerieLote WHERE Empresa = @Empresa AND SerieLote = @Serie

  IF @Articulo IS NOT NULL
    SELECT @Mov   	= v.Mov, 
           @MovID 	= v.MovID,
           @Tipo  	= v.ServicioContratoTipo,
           @Garantia	= v.ServicioGarantia,
           @Cliente	= v.Cliente
      FROM Venta v, SerieLoteMov s
     WHERE s.Modulo = 'VTAS'
       AND v.ID = s.ID
       AND v.Empresa = @Empresa
       AND v.Estatus = 'VIGENTE'
       AND s.Empresa = @Empresa
       AND s.Articulo = @Articulo
       AND s.SerieLote = @Serie

  IF @Mov = NULL SELECT @Tipo = DefServicioTipo FROM EmpresaGral WHERE Empresa = @Empresa
  IF @Cliente IS NOT NULL
    SELECT @Aseguradora = Aseguradora FROM Cte WHERE Cliente = @Cliente
  SELECT "Mov"=@Mov, "MovID"=@MovID, "Tipo"=@Tipo, "Garantia"=@Garantia, "Cliente"=@Cliente, "Articulo" = @Articulo, "Placas" = @Placas, "NumeroEconomico" = @NumeroEconomico, "Aseguradora" = @Aseguradora
  RETURN
END
GO

/**************** spVerEjercicio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerEjercicio') and type = 'P') drop procedure dbo.spVerEjercicio
GO             
CREATE PROCEDURE spVerEjercicio
		    @Empresa		char(5),
		    @Estacion		int,
		    @Rama		char(5),
		    @GrupoBase  	char(10)  = NULL,
		    @CuentaBase		char(20)  = NULL,
		    @Ejercicio		int       = NULL,
        	    @VerGrupo		bit	  = 0,	        
        	    @VerCuenta		bit	  = 0	        
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @EsMonetario	bit,
     @EsUnidades	bit,
     @EsResultados	bit,
     @UltGrupo		char(10),
     @Grupo		char(10),
     @Cuenta		char(20),
     @Moneda		char(10),
     @UltMoneda		char(10),
     @TipoCambio	float,
     @Periodo		int,

     @Neto		money,
     @NetoU		float

  -- Inicializar Parametros
  SELECT @Rama = NULLIF(UPPER(RTRIM(@Rama)), ''), @CuentaBase = NULLIF(RTRIM(@CuentaBase), ''),
         @GrupoBase = NULLIF(RTRIM(@GrupoBase), ''), @Ejercicio = NULLIF(@Ejercicio, 0)
  IF @GrupoBase = '0' SELECT @GrupoBase = NULL
  IF @CuentaBase = '0' SELECT @CuentaBase = NULL

  SELECT @EsMonetario  = EsMonetario,
	 @EsUnidades   = EsUnidades,
	 @EsResultados = EsResultados
    FROM Rama 
   WHERE Rama = @Rama

  DELETE VerEjercicio WHERE Estacion = @Estacion

  IF @EsUnidades = 0
    IF @EsResultados = 0
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Cuenta, Moneda, Ejercicio, Periodo, ISNULL(Sum(Cargos), 0.0) - ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos))
                FROM Acum
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
               GROUP BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
    ELSE
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Cuenta, Moneda, Ejercicio, Periodo, ISNULL(Sum(Cargos), 0.0) - ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos))
                FROM AcumR
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
               GROUP BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
  ELSE
    IF @EsResultados = 0
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Cuenta, Moneda, Ejercicio, Periodo, ISNULL(Sum(Cargos), 0.0) - ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0) - ISNULL(Sum(AbonosU), 0.0)
                FROM AcumU
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
               GROUP BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Cuenta, Moneda, Ejercicio, Periodo
    ELSE
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Cuenta, Moneda, Ejercicio, Periodo, ISNULL(Sum(Cargos), 0.0) - ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0) - ISNULL(Sum(AbonosU), 0.0)
                FROM AcumRU
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
               GROUP BY Grupo, Cuenta,  Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Cuenta,  Moneda, Ejercicio, Periodo
  OPEN crAcum
  FETCH NEXT FROM crAcum INTO @Grupo, @Cuenta, @Moneda, @Ejercicio, @Periodo, @Neto, @NetoU
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @EsUnidades = 0 SELECT @NetoU = 0.0
      IF UPPER(@GrupoBase) = NULL AND @VerGrupo = 0 SELECT @Grupo = NULL
      IF UPPER(@CuentaBase) = NULL AND @VerCuenta = 0 SELECT @Cuenta = NULL
      IF @Grupo = NULL SELECT @Grupo = ''
      IF @Cuenta = NULL SELECT @Cuenta = ''

      IF NOT EXISTS (SELECT * FROM VerEjercicio WHERE Estacion = @Estacion AND Grupo = @Grupo AND Cuenta = @Cuenta AND Moneda = @Moneda AND Ejercicio = @Ejercicio)
        INSERT VerEjercicio (Estacion,  Grupo,  Cuenta, Moneda,  Ejercicio) VALUES (@Estacion, @Grupo, @Cuenta, @Moneda, @Ejercicio)

      UPDATE VerEjercicio
         SET Periodo0   = CASE @Periodo WHEN 0  THEN Periodo0  + @Neto  ELSE Periodo0   END,
             Periodo1   = CASE @Periodo WHEN 1  THEN Periodo1  + @Neto  ELSE Periodo1   END,
             Periodo2   = CASE @Periodo WHEN 2  THEN Periodo2  + @Neto  ELSE Periodo2   END,
             Periodo3   = CASE @Periodo WHEN 3  THEN Periodo3  + @Neto  ELSE Periodo3   END,
             Periodo4   = CASE @Periodo WHEN 4  THEN Periodo4  + @Neto  ELSE Periodo4   END,
             Periodo5   = CASE @Periodo WHEN 5  THEN Periodo5  + @Neto  ELSE Periodo5   END,
             Periodo6   = CASE @Periodo WHEN 6  THEN Periodo6  + @Neto  ELSE Periodo6   END,
             Periodo7   = CASE @Periodo WHEN 7  THEN Periodo7  + @Neto  ELSE Periodo7   END,
             Periodo8   = CASE @Periodo WHEN 8  THEN Periodo8  + @Neto  ELSE Periodo8   END,
             Periodo9   = CASE @Periodo WHEN 9  THEN Periodo9  + @Neto  ELSE Periodo9   END,
             Periodo10  = CASE @Periodo WHEN 10 THEN Periodo10 + @Neto  ELSE Periodo10  END,
             Periodo11  = CASE @Periodo WHEN 11 THEN Periodo11 + @Neto  ELSE Periodo11  END,
             Periodo12  = CASE @Periodo WHEN 12 THEN Periodo12 + @Neto  ELSE Periodo12  END,
             Periodo13  = CASE @Periodo WHEN 13 THEN Periodo13 + @Neto  ELSE Periodo13  END,
             PeriodoU0  = CASE @Periodo WHEN 0  THEN PeriodoU0 + @NetoU ELSE PeriodoU0  END,
             PeriodoU1  = CASE @Periodo WHEN 1  THEN PeriodoU1 + @NetoU ELSE PeriodoU1  END,
             PeriodoU2  = CASE @Periodo WHEN 2  THEN PeriodoU2 + @NetoU ELSE PeriodoU2  END,
             PeriodoU3  = CASE @Periodo WHEN 3  THEN PeriodoU3 + @NetoU ELSE PeriodoU3  END,
             PeriodoU4  = CASE @Periodo WHEN 4  THEN PeriodoU4 + @NetoU ELSE PeriodoU4  END,
             PeriodoU5  = CASE @Periodo WHEN 5  THEN PeriodoU5 + @NetoU ELSE PeriodoU5  END,
             PeriodoU6  = CASE @Periodo WHEN 6  THEN PeriodoU6 + @NetoU ELSE PeriodoU6  END,
             PeriodoU7  = CASE @Periodo WHEN 7  THEN PeriodoU7 + @NetoU ELSE PeriodoU7  END,
             PeriodoU8  = CASE @Periodo WHEN 8  THEN PeriodoU8 + @NetoU ELSE PeriodoU8  END,
             PeriodoU9  = CASE @Periodo WHEN 9  THEN PeriodoU9 + @NetoU ELSE PeriodoU9  END,
             PeriodoU10 = CASE @Periodo WHEN 10 THEN PeriodoU10+ @NetoU ELSE PeriodoU10 END,
             PeriodoU11 = CASE @Periodo WHEN 11 THEN PeriodoU11+ @NetoU ELSE PeriodoU11 END,
             PeriodoU12 = CASE @Periodo WHEN 12 THEN PeriodoU12+ @NetoU ELSE PeriodoU12 END,
             PeriodoU13 = CASE @Periodo WHEN 13 THEN PeriodoU13+ @NetoU ELSE PeriodoU13 END
       WHERE Estacion = @Estacion 
         AND Grupo = @Grupo
         AND Cuenta = @Cuenta
         AND Moneda = @Moneda 
         AND Ejercicio = @Ejercicio 

    END 
    FETCH NEXT FROM crAcum INTO @Grupo, @Cuenta, @Moneda, @Ejercicio, @Periodo, @Neto, @NetoU
  END 
  CLOSE crAcum
  DEALLOCATE crAcum

  -- Inicializar Variables
  SELECT @UltMoneda = NULL

  SELECT "Grupo"=NULLIF(Grupo,''), "Cuenta"=NULLIF(Cuenta, ''), Moneda, Ejercicio, 
         "P0" =NULLIF(Periodo0, 0.0),  "P1" =NULLIF(Periodo1, 0.0),  "P2" =NULLIF(Periodo2, 0.0),  "P3" =NULLIF(Periodo3, 0.0),  "P4" =NULLIF(Periodo4, 0.0),  "P5" =NULLIF(Periodo5, 0.0),  "P6" =NULLIF(Periodo6, 0.0),  "P7" =NULLIF(Periodo7, 0.0),  "P8" =NULLIF(Periodo8, 0.0),  "P9" =NULLIF(Periodo9, 0.0),  "P10" =NULLIF(Periodo10, 0.0),  "P11" =NULLIF(Periodo11, 0.0),  "P12" =NULLIF(Periodo12, 0.0),  "P13" =NULLIF(Periodo13, 0.0),
         "PU0"=NULLIF(PeriodoU0, 0.0), "PU1"=NULLIF(PeriodoU1, 0.0), "PU2"=NULLIF(PeriodoU2, 0.0), "PU3"=NULLIF(PeriodoU3, 0.0), "PU4"=NULLIF(PeriodoU4, 0.0), "PU5"=NULLIF(PeriodoU5, 0.0), "PU6"=NULLIF(PeriodoU6, 0.0), "PU7"=NULLIF(PeriodoU7, 0.0), "PU8"=NULLIF(PeriodoU8, 0.0), "PU9"=NULLIF(PeriodoU9, 0.0), "PU10"=NULLIF(PeriodoU10, 0.0), "PU11"=NULLIF(PeriodoU11, 0.0), "PU12"=NULLIF(PeriodoU12, 0.0), "PU13"=NULLIF(PeriodoU13, 0.0)
    FROM VerEjercicio
   WHERE Estacion = @Estacion

  RETURN
END
GO

/**************** spVerRamaDesglose ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerRamaDesglose') and type = 'P') drop procedure dbo.spVerRamaDesglose
GO             
CREATE PROCEDURE spVerRamaDesglose
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @Cuenta		char(20),
		    @SubCuenta		varchar(50),
		    @Moneda		char(10),
                    @Comparar		char(20),
		    @Ejercicio		int,
		    @PeriodoDe		int,
		    @PeriodoA		int,
                    @SaldoActual	bit,
 	            @Acumulado		bit,
		    @EsUnidades		bit, 
		    @EsResultados	bit, 
                    @Vista		char(20),		

		    @Inicio		money	OUTPUT,
		    @Cargos		money	OUTPUT,
		    @Abonos		money	OUTPUT,
		    @Final		money	OUTPUT,
		    @InicioU		float	OUTPUT,
		    @CargosU		float	OUTPUT,
		    @AbonosU		float	OUTPUT,
		    @FinalU		float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DelP0	int,
    @DelP	int,
    @AlP	int,
    @DelE	int,
    @AlE	int,
    @Meses	int,
    @Periodo	int,
    @Cargo	money,
    @Abono	money,
    @CargoU	float,
    @AbonoU	float

  SELECT @DelP0 = 0
  SELECT @Inicio  = 0.0, @Cargos  = 0.0, @Abonos  = 0.0, @Final  = 0.0,
         @InicioU = 0.0, @CargosU = 0.0, @AbonosU = 0.0, @FinalU = 0.0
  IF @SaldoActual = 1 AND @Comparar IS NULL
  BEGIN
    IF @EsUnidades = 1
    BEGIN
      IF @EsResultados = 1 
        IF @Vista = 'NORMAL' SELECT @Final = ISNULL(Sum(Saldo), 0.0), @FinalU = ISNULL(Sum(SaldoU), 0.0) FROM SaldoRU WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND Moneda = @Moneda
        ELSE                 SELECT @Final = ISNULL(Sum(Saldo), 0.0), @FinalU = ISNULL(Sum(SaldoU), 0.0) FROM SaldoRU WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Moneda = @Moneda
      ELSE
        IF @Vista = 'NORMAL' SELECT @Final = ISNULL(Sum(Saldo), 0.0), @FinalU = ISNULL(Sum(SaldoU), 0.0) FROM SaldoU  WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND Moneda = @Moneda
        ELSE                 SELECT @Final = ISNULL(Sum(Saldo), 0.0), @FinalU = ISNULL(Sum(SaldoU), 0.0) FROM SaldoU  WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Moneda = @Moneda
    END ELSE
    BEGIN
      IF @EsResultados = 1
        IF @Vista = 'NORMAL' SELECT @Final = ISNULL(Sum(Saldo), 0.0) FROM SaldoR WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND Moneda = @Moneda
        ELSE                 SELECT @Final = ISNULL(Sum(Saldo), 0.0) FROM SaldoR WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Moneda = @Moneda
      ELSE
        IF @Vista = 'NORMAL' SELECT @Final = ISNULL(Sum(Saldo), 0.0) FROM Saldo  WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND Moneda = @Moneda
        ELSE                 SELECT @Final = ISNULL(Sum(Saldo), 0.0) FROM Saldo  WHERE Empresa = @Empresa AND Rama = @Modulo AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Moneda = @Moneda
    END
  END ELSE
  BEGIN
    SELECT @DelP = @PeriodoDe, @AlP = @PeriodoA, @DelE = @Ejercicio, @AlE = @Ejercicio
    IF @Acumulado = 1 OR @SaldoActual = 1 
    BEGIN
      SELECT @DelP = 0
      IF @Comparar = 'ANTERIOR' 
        SELECT @DelE = @DelE - 1, @AlE = @AlE - 1
    END ELSE
      IF @Comparar = 'ANTERIOR'
      BEGIN
        SELECT @Meses = @AlP - @DelP + 1
        SELECT @DelP = @DelP - @Meses, @AlP = @AlP - @Meses
        IF @DelP < 1 SELECT @DelE = @DelE - 1, @DelP = @DelP + 12
        IF @AlP  < 1 SELECT @AlE  = @AlE  - 1, @AlP  = @AlP  + 12      
      END

    IF @EsUnidades = 1
    BEGIN
      IF @EsResultados = 1
        IF @Vista = 'NORMAL' DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0), ISNULL(Sum(AbonosU), 0.0) FROM AcumRU WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
        ELSE                 DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0), ISNULL(Sum(AbonosU), 0.0) FROM AcumRU WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
      ELSE
        IF @Vista = 'NORMAL' DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0), ISNULL(Sum(AbonosU), 0.0) FROM AcumU  WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
        ELSE                 DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), ISNULL(Sum(CargosU), 0.0), ISNULL(Sum(AbonosU), 0.0) FROM AcumU  WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
    END ELSE
    BEGIN
      IF @EsResultados = 1
        IF @Vista = 'NORMAL' DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos)) FROM AcumR WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
        ELSE                 DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos)) FROM AcumR WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
      ELSE
        IF @Vista = 'NORMAL' DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos)) FROM Acum  WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
        ELSE                 DECLARE crRamaDesglose CURSOR FOR SELECT Periodo, ISNULL(Sum(Cargos), 0.0), ISNULL(Sum(Abonos), 0.0), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos)) FROM Acum  WHERE Empresa = @Empresa AND Rama = @Modulo AND Moneda = @Moneda AND Cuenta = @Cuenta AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Ejercicio BETWEEN @DelE AND @AlE AND Periodo BETWEEN @DelP0 AND @AlP GROUP BY Periodo ORDER BY Periodo
    END

    OPEN crRamaDesglose
    FETCH NEXT FROM crRamaDesglose INTO @Periodo, @Cargo, @Abono, @CargoU, @AbonoU
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        IF @Periodo < @DelP
          SELECT @Inicio  = @Inicio  + @Cargo  - @Abono,
                 @InicioU = @InicioU + @CargoU - @AbonoU
        ELSE
          SELECT @Cargos  = @Cargos  + @Cargo,  @Abonos  = @Abonos  + @Abono,
                 @CargosU = @CargosU + @CargoU, @AbonosU = @AbonosU + @AbonoU
      END
      FETCH NEXT FROM crRamaDesglose INTO @Periodo, @Cargo, @Abono, @CargoU, @AbonoU
    END
    CLOSE crRamaDesglose
    DEALLOCATE crRamaDesglose

    SELECT @Final  = @Inicio  + @Cargos  - @Abonos,
           @FinalU = @InicioU + @CargosU - @AbonosU
  END
  RETURN
END
GO

/**************** spVerPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPresupuesto') and type = 'P') drop procedure dbo.spVerPresupuesto
GO             
CREATE PROCEDURE spVerPresupuesto
		    @Empresa		char(5),
		    @Rama		char(5),
		    @Cuenta		char(20),
		    @SubCuenta		varchar(50),
		    @Moneda		char(10),
		    @Ejercicio		int,
		    @Periodo		int,
		    @PeriodoDe		int,
		    @PeriodoA		int,
                    @SaldoActual	bit,
		    @Acumulado		bit,

		    @Presupuesto	money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Del	int,
    @Al		int

  SELECT @Presupuesto = 0.0
  IF @SaldoActual = 1 
    SELECT @Del = 1, @Al = @Periodo
  ELSE 
  BEGIN
    SELECT @Al = @PeriodoA
    IF @Acumulado = 1 SELECT @Del = 1 ELSE SELECT @Del = @PeriodoDe 
  END

  IF @SubCuenta IS NULL
    SELECT @Presupuesto = ISNULL(SUM(Presupuesto), 0.0) 
      FROM Presupuesto
     WHERE Empresa   = @Empresa
       AND Rama      = @Rama
       AND Cuenta    = @Cuenta
       AND Ejercicio = @Ejercicio
       AND Periodo BETWEEN @Del AND @Al AND Moneda = @Moneda
  ELSE
    SELECT @Presupuesto = ISNULL(SUM(Presupuesto), 0.0) 
      FROM Presupuesto
     WHERE Empresa   = @Empresa
       AND Rama      = @Rama
       AND Cuenta    = @Cuenta
       AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') 
       AND Ejercicio = @Ejercicio
       AND Periodo BETWEEN @Del AND @Al AND Moneda = @Moneda

  RETURN
END
GO

/**************** spVerRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerRama') and type = 'P') drop procedure dbo.spVerRama
GO             
CREATE PROCEDURE spVerRama
		    @Empresa		char(5),
		    @Estacion		int,
		    @Modulo		char(5),
		    @Rama		char(60),
		    @Ejercicio		int,
                    @Periodo		int,
                    @PeriodoDe		int,
		    @PeriodoA		int,
		    @SaldoActual	bit,
		    @Acumulado		bit,
		    @Todo		bit,
                    @Vista		char(20)  = 'NORMAL',  -- Resumen, Detalles,
                    @Comparar		char(20)  = NULL,
		    @MonedaEspecifica	char(10)  = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @UltCuenta		char(20),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @Grupo		char(50),
    @UltGrupo		char(50),
    @SubGrupo		char(50),
    @UltSubGrupo	char(50),
    @Descripcion	varchar(100),
    @Moneda		char(10),
    @Signo		char(1),
    @EsAcreedora	bit,
    @UltEsAcreedora	bit,
    @EsAcumulativa	bit,
    @Tipo		char(15),
    @EsLista		bit,
    @EsMonetario	bit,
    @EsUnidades		bit,
    @EsResultados	bit,
    @Inicio		money,
    @Cargos		money,
    @Abonos		money,
    @SumaFinal		money,
    @SumaFinalAcreedor	money,
    @SumaCargos		money,
    @SumaAbonos		money,
    @GrupoCargos	money,
    @GrupoAbonos	money,
    @GrupoFinal		money,
    @SubGrupoCargos	money,
    @SubGrupoAbonos	money,
    @SubGrupoFinal	money,
    @Final		money,
    @Comparacion	money,
    @InicioU		float,
    @CargosU		float,
    @AbonosU		float,
    @SumaFinalU		float,
    @SumaCargosU	float,
    @SumaAbonosU	float,
    @GrupoCargosU	float,
    @GrupoAbonosU	float,
    @GrupoFinalU	float,
    @SubGrupoCargosU	float,
    @SubGrupoAbonosU	float,
    @SubGrupoFinalU	float,
    @FinalU		float

  -- Inicializar Parametros
  SELECT @Rama = NULLIF(UPPER(RTRIM(@Rama)), ''), @Vista = ISNULL(NULLIF(UPPER(RTRIM(@Vista)), ''), 'NORMAL'), @Comparar = NULLIF(UPPER(RTRIM(@Comparar)), ''),
         @MonedaEspecifica = NULLIF(NULLIF(RTRIM(@MonedaEspecifica), ''), '0')
  SELECT @UltCuenta = NULL, @Orden = 0
  SELECT @EsAcreedora = 0, @UltEsAcreedora = 0, @EsAcumulativa = 0, @EsLista = 0, @Comparacion = NULL
  IF SUBSTRING(@Rama, 1, 6) = 'LISTA=' SELECT @EsLista = 1, @Rama = RTRIM(SUBSTRING(@Rama, 7, 60))

  DELETE VerRama WHERE Estacion = @Estacion

  SELECT @EsMonetario  = EsMonetario,
	 @EsUnidades   = EsUnidades,
	 @EsResultados = EsResultados
    FROM Rama 
   WHERE Rama = @Modulo

  IF @EsLista = 1 
  BEGIN
    IF @Vista = 'NORMAL' 
      DECLARE crRama CURSOR FOR 
       SELECT Cta.Cuenta, Cta.Cuenta, Cta.Descripcion, s.Moneda, NULLIF(RTRIM(ListaD.Grupo), ''), NULLIF(RTRIM(ListaD.SubGrupo), ''), ListaD.Signo
         FROM Cta
         LEFT OUTER JOIN Saldo s ON Cta.Cuenta = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
         JOIN ListaD ON Cta.Cuenta = ListaD.Cuenta 
         LEFT OUTER JOIN ListaGrupo lg ON ListaD.Grupo = lg.Grupo 
         LEFT OUTER JOIN ListaGrupo lsg ON ListaD.SubGrupo = lsg.Grupo 
        WHERE ListaD.Lista = @Rama
        GROUP BY lg.Orden, lsg.Orden, ListaD.Grupo, ListaD.SubGrupo, Cta.Cuenta, ListaD.Signo, Cta.Descripcion, s.Moneda
        ORDER BY lg.Orden, lsg.Orden, ListaD.Grupo, ListaD.SubGrupo, Cta.Cuenta, ListaD.Signo, Cta.Descripcion, s.Moneda
    ELSE
      DECLARE crRama CURSOR FOR 
       SELECT Cta.Cuenta, s.SubCuenta, Cta.Descripcion, s.Moneda, NULLIF(RTRIM(ListaD.Grupo), ''), NULLIF(RTRIM(ListaD.SubGrupo), ''), ListaD.Signo
         FROM Cta
         LEFT OUTER JOIN Saldo s ON Cta.Cuenta = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
         JOIN ListaD ON Cta.Cuenta = ListaD.Cuenta 
         LEFT OUTER JOIN ListaGrupo lg ON ListaD.Grupo = lg.Grupo 
         LEFT OUTER JOIN ListaGrupo lsg ON ListaD.SubGrupo = lsg.Grupo 
        WHERE ListaD.Lista = @Rama 
        GROUP BY lg.Orden, lsg.Orden, ListaD.Grupo, ListaD.SubGrupo, Cta.Cuenta, s.SubCuenta, ListaD.Signo, Cta.Descripcion, s.Moneda 
        ORDER BY lg.Orden, lsg.Orden, ListaD.Grupo, ListaD.SubGrupo, Cta.Cuenta, s.SubCuenta, ListaD.Signo, Cta.Descripcion, s.Moneda 
  END ELSE
  BEGIN
    IF @Modulo = 'CONT'
    BEGIN
      IF @Vista = 'NORMAL' 
        DECLARE crRama CURSOR FOR 
         SELECT Cta.Cuenta, Cta.Cuenta, Descripcion, s.Moneda, Cta.Cuenta, Cta.Cuenta, '+' 
           FROM Cta
           LEFT OUTER JOIN Saldo s ON Cta.Cuenta = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
          WHERE Cta.Rama = @Rama 
          GROUP BY Cta.Cuenta, Descripcion, s.Moneda 
          ORDER BY Cta.Cuenta, Descripcion, s.Moneda 
      ELSE                 
        DECLARE crRama CURSOR FOR 
         SELECT Cta.Cuenta, NULLIF(RTRIM(s.SubCuenta), ''), Descripcion, s.Moneda, Cta.Cuenta, Cta.Cuenta, '+' 
           FROM Cta
           LEFT OUTER JOIN Saldo s ON Cta.Cuenta = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
          WHERE Cta.Rama = @Rama 
          GROUP BY Cta.Cuenta, s.SubCuenta, Descripcion, s.Moneda
          ORDER BY Cta.Cuenta, s.SubCuenta, Descripcion, s.Moneda
    END ELSE
    IF @Modulo = 'CC'
    BEGIN
      DECLARE crRama CURSOR FOR 
       SELECT cc.CentroCostos, cc.CentroCostos, cc.Descripcion, s.Moneda, cc.CentroCostos, cc.CentroCostos, '+' 
         FROM CentroCostos cc
         LEFT OUTER JOIN Saldo s ON cc.CentroCostos = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
        WHERE cc.Rama = @Rama 
        GROUP BY cc.CentroCostos, cc.Descripcion, s.Moneda 
        ORDER BY cc.CentroCostos, cc.Descripcion, s.Moneda 
    END    
    IF @Modulo = 'CC2'
    BEGIN
      DECLARE crRama CURSOR FOR 
       SELECT cc.CentroCostos2, cc.CentroCostos2, cc.Descripcion, s.Moneda, cc.CentroCostos2, cc.CentroCostos2, '+' 
         FROM CentroCostos2 cc
         LEFT OUTER JOIN Saldo s ON cc.CentroCostos2 = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
        WHERE cc.Rama = @Rama 
        GROUP BY cc.CentroCostos2, cc.Descripcion, s.Moneda 
        ORDER BY cc.CentroCostos2, cc.Descripcion, s.Moneda 
    END    
    IF @Modulo = 'CC3'
    BEGIN
      DECLARE crRama CURSOR FOR 
       SELECT cc.CentroCostos3, cc.CentroCostos3, cc.Descripcion, s.Moneda, cc.CentroCostos3, cc.CentroCostos3, '+' 
         FROM CentroCostos3 cc
         LEFT OUTER JOIN Saldo s ON cc.CentroCostos3 = s.Cuenta AND s.Rama = @Modulo AND s.Empresa = @Empresa AND s.Moneda = ISNULL(@MonedaEspecifica, s.Moneda)
        WHERE cc.Rama = @Rama 
        GROUP BY cc.CentroCostos3, cc.Descripcion, s.Moneda 
        ORDER BY cc.CentroCostos3, cc.Descripcion, s.Moneda 
    END    

  END

  SELECT @UltGrupo        = NULL, @UltSubGrupo     = NULL
  SELECT @SumaCargos      = 0.0,  @SumaAbonos      = 0.0, @SumaFinal      = 0.0, @SumaFinalAcreedor  = 0.0,
	 @SumaCargosU     = 0.0,  @SumaAbonosU     = 0.0, @SumaFinalU     = 0.0,
         @GrupoCargos     = 0.0,  @GrupoAbonos     = 0.0, @GrupoFinal     = 0.0,
         @GrupoCargosU    = 0.0,  @GrupoAbonosU    = 0.0, @GrupoFinalU    = 0.0,
         @SubGrupoCargos  = 0.0,  @SubGrupoAbonos  = 0.0, @SubGrupoFinal  = 0.0,
         @SubGrupoCargosU = 0.0,  @SubGrupoAbonosU = 0.0, @SubGrupoFinalU = 0.0

  OPEN crRama
  FETCH NEXT FROM crRama INTO @Cuenta, @SubCuenta, @Descripcion, @Moneda, @Grupo, @SubGrupo, @Signo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN 
      IF @Vista = 'NORMAL' SELECT @SubCuenta = NULL

      EXEC spVerRamaDesglose @Empresa, @Modulo, @Cuenta, @SubCuenta, @Moneda, NULL,
                             @Ejercicio, @PeriodoDe, @PeriodoA, @SaldoActual, @Acumulado, @EsUnidades, @EsResultados, @Vista,	     
		    	     @Inicio  OUTPUT, @Cargos  OUTPUT, @Abonos  OUTPUT, @Final  OUTPUT,
		    	     @InicioU OUTPUT, @CargosU OUTPUT, @AbonosU OUTPUT, @FinalU OUTPUT
      IF @Modulo = 'CONT'
        IF @Cuenta <> @UltCuenta 
        BEGIN
          SELECT @EsAcreedora = EsAcreedora, @Tipo = Tipo
            FROM Cta
           WHERE Cuenta = @Cuenta
        END

      SELECT @EsAcumulativa = 0

      IF @Comparar = 'PRESUPUESTO'
          EXEC spVerPresupuesto @Empresa, @Modulo, @Cuenta, @SubCuenta, @Moneda, 
                              @Ejercicio, @Periodo, @PeriodoDe, @PeriodoA, @SaldoActual, @Acumulado, 
	  	    	      @Comparacion OUTPUT
      ELSE 
      IF @Comparar = 'ANTERIOR' 
        EXEC spVerRamaDesglose @Empresa, @Modulo, @Cuenta, @SubCuenta, @Moneda, @Comparar, 
                               @Ejercicio, @PeriodoDe, @PeriodoA, @SaldoActual, @Acumulado, @EsUnidades, @EsResultados, @Vista, 			       
	  	    	       @Inicio, @Cargos, @Abonos, @Comparacion OUTPUT,
		    	       @InicioU, @CargosU, @AbonosU, @FinalU      
      IF @EsLista = 1
      BEGIN
        IF (@UltCuenta IS NOT NULL) AND (@Grupo <> @UltGrupo OR @SubGrupo <> @UltSubGrupo)
        BEGIN
          IF @Grupo <> @UltGrupo OR @SubGrupo <> @UltSubGrupo 
          BEGIN
            IF @UltSubGrupo IS NOT NULL
            BEGIN
              SELECT @Orden = @Orden + 1
              INSERT VerRama (Estacion,  Orden,  Rama,  Descripcion,  EsAcumulativa, EsAcreedora, Cargos,  Abonos,  Final, CargosU,  AbonosU, FinalU) 
                      VALUES (@Estacion, @Orden, @Rama, @UltSubGrupo, 1, @UltEsAcreedora, @SubGrupoCargos, @SubGrupoAbonos, @SubGrupoFinal, @SubGrupoCargosU, @SubGrupoAbonosU, @SubGrupoFinalU)
            END
            SELECT @UltSubGrupo = NULL
            SELECT @SubGrupoCargos  = 0.0,  @SubGrupoAbonos  = 0.0, @SubGrupoFinal  = 0.0,
                   @SubGrupoCargosU = 0.0,  @SubGrupoAbonosU = 0.0, @SubGrupoFinalU = 0.0
          END
          IF @Grupo <> @UltGrupo
          BEGIN
            IF @UltGrupo IS NOT NULL
            BEGIN
              SELECT @Orden = @Orden + 1
              INSERT VerRama (Estacion,  Orden,  Rama,  Descripcion,  EsAcumulativa,  EsAcreedora, Cargos,  Abonos,  Final, CargosU,  AbonosU, FinalU) 
                      VALUES (@Estacion, @Orden, @Rama, @UltGrupo, 1, @UltEsAcreedora, @GrupoCargos, @GrupoAbonos, @GrupoFinal, @GrupoCargosU, @GrupoAbonosU, @GrupoFinalU)
            END
            SELECT @UltGrupo = NULL
            SELECT @GrupoCargos  = 0.0,  @GrupoAbonos  = 0.0, @GrupoFinal  = 0.0,
                   @GrupoCargosU = 0.0,  @GrupoAbonosU = 0.0, @GrupoFinalU = 0.0
          END
        END
        SELECT @UltCuenta = @Cuenta, @UltEsAcreedora = @EsAcreedora, @UltGrupo = @Grupo, @UltSubGrupo = @SubGrupo
        IF @Signo = '-'
        BEGIN
          IF @EsAcreedora = 1 SELECT @SumaFinalAcreedor = @SumaFinalAcreedor + @Final ELSE SELECT @SumaFinal = @SumaFinal - @Final
          SELECT @SumaCargos      = @SumaCargos      - @Cargos,  @SumaAbonos      = @SumaAbonos      - @Abonos,  
                 @SumaCargosU     = @SumaCargosU     - @CargosU, @SumaAbonosU     = @SumaAbonosU     - @AbonosU, @SumaFinalU     = @SumaFinalU     - @FinalU,
                 @GrupoCargos     = @GrupoCargos     - @Cargos,  @GrupoAbonos     = @GrupoAbonos     - @Abonos,  @GrupoFinal     = @GrupoFinal     - @Final,
                 @GrupoCargosU    = @GrupoCargosU    - @CargosU, @GrupoAbonosU    = @GrupoAbonosU    - @AbonosU, @GrupoFinalU    = @GrupoFinalU    - @FinalU,
                 @SubGrupoCargos  = @SubGrupoCargos  - @Cargos,  @SubGrupoAbonos  = @SubGrupoAbonos  - @Abonos,  @SubGrupoFinal  = @SubGrupoFinal  - @Final,
                 @SubGrupoCargosU = @SubGrupoCargosU - @CargosU, @SubGrupoAbonosU = @SubGrupoAbonosU - @AbonosU, @SubGrupoFinalU = @SubGrupoFinalU - @FinalU
        END ELSE
        BEGIN
          IF @EsAcreedora = 1 SELECT @SumaFinalAcreedor = @SumaFinalAcreedor - @Final ELSE SELECT @SumaFinal = @SumaFinal + @Final
          SELECT @SumaCargos      = @SumaCargos      + @Cargos,  @SumaAbonos      = @SumaAbonos      + @Abonos,  
                 @SumaCargosU     = @SumaCargosU     + @CargosU, @SumaAbonosU     = @SumaAbonosU     + @AbonosU, @SumaFinalU     = @SumaFinalU     + @FinalU,
                 @GrupoCargos     = @GrupoCargos     + @Cargos,  @GrupoAbonos     = @GrupoAbonos     + @Abonos,  @GrupoFinal     = @GrupoFinal     + @Final,
                 @GrupoCargosU    = @GrupoCargosU    + @CargosU, @GrupoAbonosU    = @GrupoAbonosU    + @AbonosU, @GrupoFinalU    = @GrupoFinalU    + @FinalU,
                 @SubGrupoCargos  = @SubGrupoCargos  + @Cargos,  @SubGrupoAbonos  = @SubGrupoAbonos  + @Abonos,  @SubGrupoFinal  = @SubGrupoFinal  + @Final,
                 @SubGrupoCargosU = @SubGrupoCargosU + @CargosU, @SubGrupoAbonosU = @SubGrupoAbonosU + @AbonosU, @SubGrupoFinalU = @SubGrupoFinalU + @FinalU
        END
      END ELSE
        IF @EsAcreedora = 1 SELECT @SumaFinalAcreedor = @SumaFinalAcreedor - @Final ELSE SELECT @SumaFinal = @SumaFinal + @Final

      SELECT @Orden = @Orden + 1
      INSERT VerRama (Estacion,  Orden,  Cuenta,  SubCuenta,  Rama,  Descripcion,  EsAcreedora,  EsAcumulativa,  Tipo,  Inicio,  Cargos,  Abonos,  Final,  Comparacion,  InicioU,  CargosU,  AbonosU,  FinalU) 
              VALUES (@Estacion, @Orden, @Cuenta, @SubCuenta, @Rama, @Descripcion, @EsAcreedora, @EsAcumulativa, @Tipo, @Inicio, @Cargos, @Abonos, @Final, @Comparacion, @InicioU, @CargosU, @AbonosU, @FinalU)
    END
    FETCH NEXT FROM crRama INTO @Cuenta, @SubCuenta, @Descripcion, @Moneda, @Grupo, @SubGrupo, @Signo
  END
  IF @EsLista = 1 
  BEGIN
    IF @UltSubGrupo IS NOT NULL
    BEGIN
      SELECT @Orden = @Orden + 1
      INSERT VerRama (Estacion,  Orden,  Rama,  Descripcion,  EsAcumulativa, EsAcreedora, Cargos,  Abonos,  Final, CargosU,  AbonosU, FinalU) 
              VALUES (@Estacion, @Orden, @Rama, @SubGrupo, 1, @UltEsAcreedora, @SubGrupoCargos, @SubGrupoAbonos, @SubGrupoFinal, @SubGrupoCargosU, @SubGrupoAbonosU, @SubGrupoFinalU)
    END
    IF @UltGrupo IS NOT NULL
    BEGIN
      SELECT @Orden = @Orden + 1
      INSERT VerRama (Estacion,  Orden,  Rama,  Descripcion, EsAcumulativa, EsAcreedora, Cargos,  Abonos,  Final, CargosU,  AbonosU, FinalU) 
              VALUES (@Estacion, @Orden, @Rama, @Grupo, 1, @UltEsAcreedora, @GrupoCargos, @GrupoAbonos, @GrupoFinal, @GrupoCargosU, @GrupoAbonosU, @GrupoFinalU)
    END
  END
  CLOSE crRama
  DEALLOCATE crRama

  -- Agregar Totales
--  IF @SaldoActual = 1 AND @Comparar IS NULL
--  BEGIN
    SELECT @Orden = @Orden + 1
    INSERT VerRama (Estacion,  Orden,  Rama,  Descripcion, Periodo, Cargos,  Abonos) 
            VALUES (@Estacion, @Orden, @Rama, 'Totales', 999, @SumaFinal, @SumaFinalAcreedor)
--  END
  

  IF @Todo = 1
    SELECT Cuenta, SubCuenta, Rama, Descripcion, EsAcreedora, EsAcumulativa, Tipo, 
           "Inicio"  = NULLIF(Inicio, 0.0),  "Cargos"  = NULLIF(Cargos, 0.0),  "Abonos"  = NULLIF(Abonos, 0.0),  "Final"  = NULLIF(Final, 0.0), "Comparacion" = NULLIF(Comparacion, 0.0),
           "InicioU" = NULLIF(InicioU, 0.0), "CargosU" = NULLIF(CargosU, 0.0), "AbonosU" = NULLIF(AbonosU, 0.0), "FinalU" = NULLIF(FinalU, 0.0),
           Periodo
      FROM VerRama
     WHERE Estacion = @Estacion
  ELSE
    SELECT Cuenta, SubCuenta, Rama, Descripcion, EsAcreedora, EsAcumulativa, Tipo, 
           "Inicio"  = NULLIF(Inicio, 0.0),  "Cargos"  = NULLIF(Cargos, 0.0),  "Abonos"  = NULLIF(Abonos, 0.0),  "Final"  = NULLIF(Final, 0.0), "Comparacion" = NULLIF(Comparacion, 0.0),
           "InicioU" = NULLIF(InicioU, 0.0), "CargosU" = NULLIF(CargosU, 0.0), "AbonosU" = NULLIF(AbonosU, 0.0), "FinalU" = NULLIF(FinalU, 0.0),
           Periodo
      FROM VerRama
     WHERE Estacion = @Estacion
       AND (Inicio  <> 0.0 OR Cargos  <> 0.0 OR Abonos  <> 0.0 OR Final <> 0.0 OR
            InicioU <> 0.0 OR CargosU <> 0.0 OR AbonosU <> 0.0 OR FinalU <> 0.0)
  RETURN
END
GO

/**************** spVerAcumulados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAcumulados') and type = 'P') drop procedure dbo.spVerAcumulados
GO             
CREATE PROCEDURE spVerAcumulados
		    @Empresa		char(5),
		    @Estacion		int,
		    @Rama		char(5),
		    @GrupoBase  	char(10)  = NULL,
		    @CuentaBase		char(20)  = NULL,
		    @Ejercicio		int       = NULL,
        	    @VerGrupo		bit	  = 0,	        -- Grupo, Cuenta
        	    @Totalizar		bit	  = 0,  	-- Grupos, Totales
		    @MonedaEspecifica	char(10)  = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @EsMonetario	bit,
     @EsUnidades	bit,
     @EsResultados	bit,
     @UltGrupo		char(10),
     @Grupo		char(10),
     @Moneda		char(10),
     @UltMoneda		char(10),
     @TipoCambio	float,
     @Periodo		int,

     @Inicio		money,
     @Cargos		money,
     @SumaCargos	money,
     @Abonos		money,
     @SumaAbonos	money,
     @Final		money,

     @InicioU		float,
     @CargosU		float,
     @SumaCargosU	float,
     @AbonosU		float,
     @SumaAbonosU	float,
     @FinalU		float

  -- Inicializar Parametros
  SELECT @Rama = NULLIF(UPPER(RTRIM(@Rama)), ''), 
         @CuentaBase = NULLIF(RTRIM(@CuentaBase), ''),
         @GrupoBase = NULLIF(RTRIM(@GrupoBase), ''), 
         @Ejercicio = NULLIF(@Ejercicio, 0), 
         @VerGrupo = ISNULL(@VerGrupo, 0),
         @MonedaEspecifica = NULLIF(NULLIF(RTRIM(@MonedaEspecifica), ''), '0')

  -- Inicializar Variables
  SELECT @UltMoneda = NULL

  SELECT @EsMonetario  = EsMonetario,
	 @EsUnidades   = EsUnidades,
	 @EsResultados = EsResultados
    FROM Rama 
   WHERE Rama = @Rama

  DELETE VerAcum WHERE Estacion = @Estacion

-- En el caso de CXC y CXP se hace la suma restando el Efectivo utilizando el mayor de la rama, en INV no aplica !!.
  IF @EsUnidades = 0
    IF @EsResultados = 0

      -- Si no es una rama de mayor
      IF @Rama IN ('CEFE','PEFE', 'CVALE', 'CRND', 'PRND', 'CNO')
        DECLARE crAcum CURSOR 
            FOR SELECT Grupo, Moneda, Ejercicio, Periodo, Convert(Money, ISNULL(Sum(Cargos), 0.0)), Convert(Money, ISNULL(Sum(Abonos), 0.0)), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos))
                  FROM Acum
                 WHERE Rama       = @Rama
                   AND Empresa    = @Empresa 
                   AND Grupo      = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                   AND Cuenta     = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                   AND Ejercicio  = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
                   AND Moneda     = ISNULL(@MonedaEspecifica, Moneda)
                 GROUP BY Grupo, Moneda, Ejercicio, Periodo
                 ORDER BY Grupo, Moneda, Ejercicio, Periodo
      ELSE
        DECLARE crAcum CURSOR 
            FOR SELECT Grupo, Moneda, Ejercicio, Periodo, Convert(Money, ISNULL(Sum(Cargos), 0.0)), Convert(Money, ISNULL(Sum(Abonos), 0.0)), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos))
                  FROM Acum, Rama
                 WHERE Acum.Rama  = Rama.Rama 
                   AND Rama.Mayor = @Rama
                   AND Empresa    = @Empresa 
                   AND Grupo      = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                   AND Cuenta     = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                   AND Ejercicio  = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
                   AND Moneda     = ISNULL(@MonedaEspecifica, Moneda)
                 GROUP BY Grupo, Moneda, Ejercicio, Periodo
                 ORDER BY Grupo, Moneda, Ejercicio, Periodo
    ELSE
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Moneda, Ejercicio, Periodo, Convert(Money, ISNULL(Sum(Cargos), 0.0)), Convert(Money, ISNULL(Sum(Abonos), 0.0)), Convert(float, Sum(Cargos)), Convert(float, Sum(Abonos))
                FROM AcumR
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
                 AND Moneda    = ISNULL(@MonedaEspecifica, Moneda)
               GROUP BY Grupo, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Moneda, Ejercicio, Periodo
  ELSE
    IF @EsResultados = 0
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Moneda, Ejercicio, Periodo, Convert(Money, ISNULL(Sum(Cargos), 0.0)), Convert(Money, ISNULL(Sum(Abonos), 0.0)), Convert(float, ISNULL(Sum(CargosU), 0.0)), Convert(float, ISNULL(Sum(AbonosU), 0.0))
                FROM AcumU
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
                 AND Moneda    = ISNULL(@MonedaEspecifica, Moneda)
               GROUP BY Grupo, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Moneda, Ejercicio, Periodo
    ELSE
      DECLARE crAcum CURSOR 
          FOR SELECT Grupo, Moneda, Ejercicio, Periodo, Convert(Money, ISNULL(Sum(Cargos), 0.0)), Convert(Money, ISNULL(Sum(Abonos), 0.0)), Convert(float, ISNULL(Sum(CargosU), 0.0)), Convert(float, ISNULL(Sum(AbonosU), 0.0))
                FROM AcumRU
               WHERE Rama      = @Rama 
                 AND Empresa   = @Empresa 
                 AND Grupo     = CASE @GrupoBase  WHEN NULL THEN Grupo     ELSE @GrupoBase  END
                 AND Cuenta    = CASE @CuentaBase WHEN NULL THEN Cuenta    ELSE @CuentaBase END
                 AND Ejercicio = CASE @Ejercicio  WHEN NULL THEN Ejercicio ELSE @Ejercicio  END
                 AND Moneda    = ISNULL(@MonedaEspecifica, Moneda)
               GROUP BY Grupo, Moneda, Ejercicio, Periodo
               ORDER BY Grupo, Moneda, Ejercicio, Periodo
  OPEN crAcum
  FETCH NEXT FROM crAcum INTO @Grupo, @Moneda, @Ejercicio, @Periodo, @Cargos, @Abonos, @CargosU, @AbonosU
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @EsUnidades = 0 SELECT @CargosU = 0.0, @AbonosU = 0.0
      IF UPPER(@GrupoBase) = NULL AND @VerGrupo = 0 SELECT @Grupo = NULL
      IF @Grupo = NULL SELECT @Grupo = ''

      UPDATE VerAcum 
         SET Cargos  = Cargos  + @Cargos,  Abonos  = Abonos  + @Abonos,
             CargosU = CargosU + @CargosU, AbonosU = AbonosU + @AbonosU
       WHERE Estacion = @Estacion 
         AND Grupo = @Grupo 
         AND Moneda = @Moneda 
         AND Ejercicio = @Ejercicio 
         AND Periodo = @Periodo

      IF @@ROWCOUNT = 0
        INSERT VerAcum (Estacion,  Grupo,  Moneda,  Ejercicio,  Periodo,  Cargos,  Abonos,   CargosU,  AbonosU) 
                VALUES (@Estacion, @Grupo, @Moneda, @Ejercicio, @Periodo, @Cargos, @Abonos, @CargosU, @AbonosU)
      SELECT @UltMoneda = @Moneda
    END 
    FETCH NEXT FROM crAcum INTO @Grupo, @Moneda, @Ejercicio, @Periodo, @Cargos, @Abonos, @CargosU, @AbonosU
  END 
  CLOSE crAcum
  DEALLOCATE crAcum

  -- Inicializar Variables
  SELECT @UltMoneda = NULL

  DECLARE crAcum CURSOR FOR 
   SELECT Grupo, Moneda, Cargos, Abonos, CargosU, AbonosU 
     FROM VerAcum
    WHERE Estacion = @Estacion

  OPEN crAcum
  FETCH NEXT FROM crAcum INTO @Grupo, @Moneda, @Cargos, @Abonos, @CargosU, @AbonosU
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Grupo <> @UltGrupo OR @Moneda <> @UltMoneda
        SELECT @UltGrupo = @Grupo, @UltMoneda = @Moneda,
               @Inicio  = 0.0, @SumaCargos  = 0.0, @SumaAbonos  = 0.0, @Final  = 0.0, 
               @InicioU = 0.0, @SumaCargosU = 0.0, @SumaAbonosU = 0.0, @FinalU = 0.0

      SELECT @Final  = @Final  + @Cargos  - @Abonos, 
             @FinalU = @FinalU + @CargosU - @AbonosU
      UPDATE VerAcum 
         SET Inicio  = @Inicio,  Final  = @Final,
             InicioU = @InicioU, FinalU = @FinalU
       WHERE CURRENT OF crAcum
      SELECT @SumaCargos  = @SumaCargos  + @Cargos,  @SumaAbonos  = @SumaAbonos  + @Abonos,  @Inicio  = @Final,
             @SumaCargosU = @SumaCargosU + @CargosU, @SumaAbonosU = @SumaAbonosU + @AbonosU, @InicioU = @FinalU
    END
    FETCH NEXT FROM crAcum INTO @Grupo, @Moneda, @Cargos, @Abonos, @CargosU, @AbonosU
    IF @Totalizar = 1 AND (@@FETCH_STATUS = -1 OR @Grupo <> @UltGrupo OR @Moneda <> @UltMoneda)
      INSERT VerAcum ( Estacion, Grupo,     Moneda,     Ejercicio, Periodo, Cargos,      Abonos,      Final,  CargosU,      AbonosU,      FinalU)
              VALUES (@Estacion, @UltGrupo, @UltMoneda, 9999,      999,     @SumaCargos, @SumaAbonos, @Final, @SumaCargosU, @SumaAbonosU, @FinalU)
  END
  CLOSE crAcum
  DEALLOCATE crAcum

  SELECT "Grupo"=NULLIF(Grupo,''), Moneda, Ejercicio, Periodo, 
         Inicio, "Cargos"=NULLIF(Cargos, 0.0), "Abonos"=NULLIF(Abonos, 0.0), Final,
	 InicioU, "CargosU"=NULLIF(CargosU, 0.0), "AbonosU"=NULLIF(AbonosU, 0.0), FinalU
    FROM VerAcum
   WHERE Estacion = @Estacion

  RETURN
END
GO


-- spVerAcumulados 'DEMO', 10,'CONT', '', 'B', 2001, 0, 1


/**************** spVerPendientesInit ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPendientesInit') and type = 'P') drop procedure dbo.spVerPendientesInit
GO             
CREATE PROCEDURE spVerPendientesInit
                    	@Nivel			char(20),  	-- Movimiento, Dia, DiaSemana, Semana, Cuenta
                    	@Vista			char(20),  	-- Vigente, Vencido
			@VerGrupo		bit,
                    	@Base			char(20),  	-- Vencimiento, Emision
		    	@Dias			int,	   	-- Dias de Intervalos
			@Hoy			datetime,
			@FechaEmision		datetime,
			@FechaVencimiento	datetime,
			@CuentaBase		char(20), 
                        @Saldo			money,

			@Fecha			varchar(20)	OUTPUT,
			@Cuenta			char(20)	OUTPUT,
          		@ID			int		OUTPUT,
			@Mov			char(20)	OUTPUT,
			@MovID			varchar(20)	OUTPUT,

			@Vigente		money		OUTPUT,
			@Vencido		money		OUTPUT,
			@C1			money		OUTPUT,
			@C2			money		OUTPUT,
			@C3			money		OUTPUT,
			@C4			money		OUTPUT,
			@C5			money		OUTPUT
			
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
    @MovFecha	datetime,
    @Dia   	int,
    @Mes   	int,
    @Ano   	char(2),
    @MesSt 	char(20)

  IF @Base = 'EMISION' SELECT @MovFecha = @FechaEmision ELSE SELECT @MovFecha = @FechaVencimiento
  EXEC spExtraerFecha @MovFecha OUTPUT

  SELECT @Dia = DATEPART(day, @MovFecha), @Mes = DATEPART(month, @MovFecha), @Ano = SUBSTRING(CONVERT(char, DATEPART(year, @MovFecha)), 3,2)

  IF @Nivel = 'CUENTA' SELECT @Fecha = NULL ELSE
  IF @Nivel = 'SEMANA' SELECT @Fecha = 'Semana '+CONVERT(char, DATEPART(week, @MovFecha))+ ' '+@Ano  ELSE
  IF @Nivel = 'DIASEMANA' 
  BEGIN
    SELECT @Dia = DATEPART(weekday, @MovFecha)
    EXEC spDiaSemana @Dia, @Fecha OUTPUT
  END ELSE 
  BEGIN
    EXEC spMesNombre @Mes, @MesSt OUTPUT
    SELECT @Fecha = CONVERT(char, @Dia) 
    SELECT @Fecha = @Fecha + '/' + SUBSTRING(@MesSt,1,3) + '/' + @Ano
  END 
 
  IF @CuentaBase IS NULL AND @VerGrupo = 1 SELECT @Cuenta = NULL
  IF @Nivel <> 'MOVIMIENTO' SELECT @ID = NULL, @Mov = NULL, @MovID = NULL

  SELECT @Vigente = 0.0, @Vencido = 0.0, @C1 = 0.0, @C2 = 0.0, @C3 = 0.0, @C4 = 0.0, @C5 = 0.0

  IF @Vista = 'VIGENTE'
  BEGIN
    IF @MovFecha <= @Hoy                         SELECT @Vencido = @Saldo ELSE
    IF @MovFecha <= DATEADD(dd, @Dias, @Hoy)     SELECT @C1 = @Saldo ELSE
    IF @MovFecha <= DATEADD(dd, @Dias * 2, @Hoy) SELECT @C2 = @Saldo ELSE
    IF @MovFecha <= DATEADD(dd, @Dias * 3, @Hoy) SELECT @C3 = @Saldo ELSE
    IF @MovFecha <= DATEADD(dd, @Dias * 4, @Hoy) SELECT @C4 = @Saldo 
    ELSE SELECT @C5 = @Saldo 
  END ELSE
  BEGIN
    IF @MovFecha >= @Hoy                          SELECT @Vigente = @Saldo ELSE
    IF @MovFecha >= DATEADD(dd, -@Dias, @Hoy)     SELECT @C1 = @Saldo ELSE
    IF @MovFecha >= DATEADD(dd, -@Dias * 2, @Hoy) SELECT @C2 = @Saldo ELSE
    IF @MovFecha >= DATEADD(dd, -@Dias * 3, @Hoy) SELECT @C3 = @Saldo ELSE
    IF @MovFecha >= DATEADD(dd, -@Dias * 4, @Hoy) SELECT @C4 = @Saldo 
    ELSE SELECT @C5 = @Saldo 
  END

  RETURN
END
GO

-- REQ13894
/**************** spEmidaVerRecargaTelefonica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEmidaVerRecargaTelefonica') and type = 'P') drop procedure dbo.spEmidaVerRecargaTelefonica
GO             
CREATE PROCEDURE spEmidaVerRecargaTelefonica
            @Empresa		char(5),
			@ID				int,
			@Articulo		char(20),
			@RenglonID		int,
			@Campos			varchar(15)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF @Campos = 'Generales'
    SELECT 'Número Telefónico: ' + ISNULL(v.RecargaTelefono, ''),
		   '   Fecha Recarga: ' + dbo.fnFormatoFecha(v.EmidaTransactionDateTime, 'dd/MM/aaaa hh:nn:ss'), 
		   '   Importe: ' + ISNULL(e.Amount, ''), 
		   '   Proveedor: ' + ISNULL(c.Description, ''), 
		   '   Número de Control: ' + ISNULL(v.EmidaCarrierControlNo, '')
      FROM Venta v
      JOIN VentaD d ON v.ID = d.ID
      JOIN EmidaProductCfg e ON d.Articulo = e.Articulo
      JOIN EmidaCarrierCfg c ON e.CarrierId = c.CarrierId
     WHERE v.Empresa = @Empresa 
       AND v.ID = @ID 
       AND d.Articulo = @Articulo 
       AND d.RenglonID = @RenglonID
  ELSE IF @Campos = 'Mensaje'
    SELECT CONVERT(text, v.EmidaResponseMessage)
      FROM Venta v
     WHERE v.Empresa = @Empresa 
       AND v.ID = @ID 
  RETURN
END
GO

/**************** spVerSerieLoteMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerSerieLoteMov') and type = 'P') drop procedure dbo.spVerSerieLoteMov
GO             
CREATE PROCEDURE spVerSerieLoteMov
                        @Empresa	char(5),
			@Modulo		char(5),
			@ID		int,
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@RenglonID	int,
			@ConPropiedades bit = 0

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF @SubCuenta = '0' SELECT @SubCuenta = NULL
  IF @ConPropiedades = 0
    SELECT SerieLote 
      FROM SerieLoteMov 
     WHERE Empresa = @Empresa 
       AND Modulo = @Modulo
       AND ID = @ID 
       AND Articulo = @Articulo 
       AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND RenglonID = @RenglonID
  ELSE
    SELECT m.Cantidad, m.SerieLote, p.Extra1, p.Extra2, p.Extra3, p.Fecha1
      FROM SerieLoteMov m
      JOIN SerieLotePropiedades s ON s.Empresa = m.Empresa AND s.Articulo = m.Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(m.SubCuenta, '') AND s.SerieLote = m.SerieLote
      LEFT OUTER JOIN SerieLoteProp p ON s.Propiedades = p.Propiedades
     WHERE m.Empresa = @Empresa 
       AND m.Modulo = @Modulo
       AND m.ID = @ID 
       AND m.Articulo = @Articulo 
       AND ISNULL(m.SubCuenta, '') = ISNULL(@SubCuenta, '')
       AND m.RenglonID = @RenglonID
     GROUP BY m.Cantidad, m.SerieLote, p.Extra1, p.Extra2, p.Extra3, p.Fecha1
     ORDER BY m.Cantidad, m.SerieLote, p.Extra1, p.Extra2, p.Extra3, p.Fecha1

  RETURN
END
GO

/**************** spVerSerieLoteMovAplica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerSerieLoteMovAplica') and type = 'P') drop procedure dbo.spVerSerieLoteMovAplica
GO             
CREATE PROCEDURE spVerSerieLoteMovAplica
			@Modulo		char(5),
			@ID		int,
			@Articulo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT SerieLote 
    FROM SerieLoteMov 
   WHERE Articulo = @Articulo AND Modulo = @Modulo AND ID IN 
        (SELECT r.id 
           FROM ventad d, venta f, venta r 
          WHERE d.id = @ID AND d.Articulo=@Articulo
            AND d.id=f.id AND f.Empresa=r.Empresa AND r.Mov=d.Aplica AND r.MovID=d.AplicaID AND r.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
          GROUP BY r.id)

  UNION 
    SELECT SerieLote 
      FROM SerieLoteMov 
     WHERE Modulo = @Modulo AND Articulo = @Articulo AND ID=@ID

  RETURN
END
GO


/**************** spVerContOARecursos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContOARecursos') and type = 'P') drop procedure dbo.spVerContOARecursos
GO

CREATE PROCEDURE spVerContOARecursos
	@Empresa		char(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@CtaResultados		char(20),
	@Moneda			char(10) = NULL,
	@Controladora		char(5)  = NULL
--//WITH ENCRYPTION
AS BEGIN

SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')

IF @Moneda IS NULL
SELECT DISTINCT @Moneda = ContMoneda FROM EmpresaCfg a WHERE Empresa = @Empresa

SELECT c.Cuenta,
       c.Descripcion,
       "CambioNeto" = Sum(a.Cargos) - Sum(a.Abonos)
  FROM Cta c, Cta Rama, Acum a 
 WHERE c.Rama = Rama.Cuenta
   AND a.Cuenta = c.Cuenta
   AND UPPER(c.Tipo) = 'MAYOR'
   AND (c.Rama <> @CtaResultados AND Rama.Rama <> @CtaResultados)
   AND a.Rama = 'CONT'
   AND a.Ejercicio = @Ejercicio
   AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
   AND a.Moneda = @Moneda
   AND a.Empresa = @Empresa
 GROUP BY c.Cuenta, c.Descripcion
 UNION
SELECT c.Cuenta,
       c.Descripcion,
       "CambioNeto" = Sum(a.Cargos) - Sum(a.Abonos)
  FROM Cta c, Acum a
 WHERE a.Cuenta = c.Cuenta 
   AND c.Cuenta = @CtaResultados
   AND a.Rama = 'CONT'
   AND a.Ejercicio = @Ejercicio
   AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
   AND a.Moneda = @Moneda
   AND a.Empresa = @Empresa
 GROUP BY c.Cuenta, c.Descripcion
 ORDER BY Sum(a.Cargos) - Sum(a.Abonos)
END
GO

/**************** spVerMovSituacionFlujo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovSituacionFlujo') and type = 'P') drop procedure dbo.spVerMovSituacionFlujo
GO             
CREATE PROCEDURE spVerMovSituacionFlujo
		    @Modulo		char(5),
		    @Mov		char(20),
		    @Estatus		char(15),
		    @Situacion		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
     @Flujo 	char(20),
     @ID	int

  SELECT @Situacion = NULLIF(RTRIM(@Situacion), ''), @Flujo = NULL, @ID = NULL
  SELECT @ID = ID, @Flujo = NULLIF(UPPER(RTRIM(Flujo)), '') FROM MovSituacion WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND Situacion = @Situacion
  IF @Flujo = 'FINAL'
    SELECT @Situacion
  ELSE BEGIN
    IF @Situacion IS NOT NULL AND EXISTS(SELECT Flujo FROM MovSituacionD WHERE ID=@ID)
      SELECT Flujo
        FROM MovSituacionD 
       WHERE ID = @ID
       ORDER BY Orden
    ELSE
      SELECT Situacion 
        FROM MovSituacion 
       WHERE Modulo	= @Modulo 
         AND Mov	= @Mov 
         AND Estatus	= @Estatus
       ORDER BY Orden
  END
END
GO

/**************** spVerSerieLoteMovAplica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerSerieLoteMovAplica') and type = 'P') drop procedure dbo.spVerSerieLoteMovAplica
GO             
CREATE PROCEDURE spVerSerieLoteMovAplica
			@Modulo		char(5),
			@ID		int,
			@Articulo	char(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT SerieLote 
    FROM SerieLoteMov 
   WHERE Articulo = @Articulo AND Modulo = @Modulo AND ID IN 
        (SELECT r.id 
           FROM ventad d, venta f, venta r 
          WHERE d.id = @ID AND d.Articulo=@Articulo
            AND d.id=f.id AND f.Empresa=r.Empresa AND r.Mov=d.Aplica AND r.MovID=d.AplicaID AND r.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
          GROUP BY r.id)

  UNION 
    SELECT SerieLote 
      FROM SerieLoteMov 
     WHERE Modulo = @Modulo AND Articulo = @Articulo AND ID=@ID

  RETURN
END
GO

/**************** spContCalcSPD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContCalcSPD') and type = 'P') drop procedure dbo.spContCalcSPD
GO             
CREATE PROCEDURE spContCalcSPD
		    @Empresa	char(5),
		    @Cuenta	char(20),
		    @Ejercicio	int,
		    @Periodo	int,
		    @SPD	money OUTPUT,
		    @SMM	money OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE  
    @UltDia		int,
    @Dia		int,
    @Diferencia		int,
    @Mes		int,
    @DiasMes		int,
    @Fecha   		datetime,
    @FechaAnterior	datetime,
    @SaldoInicial	money,
    @SaldoFinal		money,
    @CargoInicial	money,
    @AbonoInicial	money,
    @CargoFinal		money,
    @AbonoFinal		money,
    @Cargos  		money,
    @Abonos  		money,
    @Suma		money,
    @Ok			int

  CREATE TABLE #SPD (
     Fecha 	datetime NOT NULL,
     Inicio     money    NULL,
     Cargos	money    NULL,
     Abonos	money	 NULL,

     CONSTRAINT priTempSPD PRIMARY KEY CLUSTERED (Fecha)
  )

  INSERT #SPD
  SELECT d.FechaContable, 0, ISNULL(SUM(Debe), 0), ISNULL(SUM(Haber), 0)
    FROM ContD d, Cont e
   WHERE e.ID = d.ID
     AND e.Estatus = 'CONCLUIDO'
     AND d.Ejercicio = @Ejercicio
     AND d.Periodo = @Periodo
     AND d.Cuenta = @Cuenta
   GROUP BY d.FechaContable
   ORDER BY d.FechaContable

  SELECT @UltDia = 0, @Ok = NULL
  EXEC spSaldoInicialCont @Empresa, @Cuenta, @Ejercicio, @Periodo, NULL, @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @Ok OUTPUT
  SELECT @SaldoInicial = ISNULL(@CargoInicial, 0) - ISNULL(@AbonoInicial, 0)

  EXEC spSaldoFinalCont @Empresa, @Cuenta, @Ejercicio, @Periodo, @CargoFinal OUTPUT, @AbonoFinal OUTPUT, @Ok OUTPUT
  SELECT @SaldoFinal = ISNULL(@CargoFinal, 0) - ISNULL(@AbonoFinal, 0)
  SELECT @SMM = (@SaldoInicial + @SaldoFinal) / 2 

  DECLARE crSPD CURSOR FOR
   SELECT Fecha, Cargos, Abonos
     FROM #SPD 
  OPEN crSPD
  FETCH NEXT FROM crSPD INTO @Fecha, @Cargos, @Abonos
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN 
      IF @UltDia = 0 SELECT @Mes = DATEPART(mm, @Fecha)
      SELECT @Dia = DATEPART(dd, @Fecha)
      SELECT @Diferencia = @Dia - @UltDia
      WHILE @Diferencia > 1
      BEGIN
        SELECT @FechaAnterior = DATEADD(dd, -@Diferencia + 1, @Fecha)
        INSERT #SPD VALUES (@FechaAnterior, @SaldoInicial, 0, 0)
        SELECT @Diferencia = @Diferencia - 1     
      END
      UPDATE #SPD SET Inicio = @SaldoInicial WHERE CURRENT OF crSPD
      SELECT @SaldoInicial = @SaldoInicial + @Cargos - @Abonos
      SELECT @UltDia = @Dia
    END
    FETCH NEXT FROM crSPD INTO @Fecha, @Cargos, @Abonos
  END
  CLOSE crSPD
  DEALLOCATE crSPD
  IF @Fecha IS NOT NULL
  BEGIN
    SELECT @Fecha = DATEADD(dd, 1, @Fecha)
    WHILE DATEPART(mm, @Fecha) = @Mes 
    BEGIN
      INSERT #SPD VALUES (@Fecha, @SaldoInicial, 0, 0)
      SELECT @Fecha = DATEADD(dd, 1, @Fecha)
    END
    SELECT @Suma = SUM(Inicio + Cargos - Abonos), @DiasMes = COUNT(*)
      FROM #SPD
  END ELSE SELECT @SPD = NULL, @SMM = NULL
  SELECT @SPD = @Suma / @DiasMes
  RETURN
END
GO


/**************** spGenerarContSPD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarContSPD') and type = 'P') drop procedure dbo.spGenerarContSPD
GO             
CREATE PROCEDURE spGenerarContSPD
		@Estacion		int,
		@Empresa		char(5),
		@Ejercicio		int,
		@Periodo		int,
		@CuentaD		char(20) = NULL,
		@CuentaA		char(20) = NULL,
		@Controladora		char(5)  = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Cuenta		char(20),
    @SPD		money,
    @SMM		money
/*  @CuentaRangoD	char(20),
    @CuentaRangoA	char(20)*/

/*
  SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
  IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
  IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
*/
  DELETE VerContSPD WHERE Estacion = @Estacion
  DECLARE crLista CURSOR FOR 
   SELECT Cuenta 
     FROM Cta 
    WHERE Cta.Cuenta BETWEEN @CuentaD AND @CuentaA
      AND EsAcumulativa = 0

  OPEN crLista
  FETCH NEXT FROM crLista INTO @Cuenta
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spContCalcSPD @Empresa, @Cuenta, @Ejercicio, @Periodo, @SPD OUTPUT, @SMM OUTPUT
      INSERT VerContSPD (Estacion, Cuenta, SPD, SMM) VALUES (@Estacion, @Cuenta, @SPD, @SMM)
    END
    FETCH NEXT FROM crLista INTO @Cuenta
  END
  CLOSE crLista
  DEALLOCATE crLista
  RETURN
END
GO

/**************** spGenerarContAI ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarContAI') and type = 'P') drop procedure dbo.spGenerarContAI
GO             
CREATE PROCEDURE spGenerarContAI
                            @Empresa		char(5),
                            @Ejercicio		int,
                            @PeriodoD		int,
                            @PeriodoA		int,
                            @Controladora	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Moneda                 char(10),
    @Cuenta                 char(20),
    @SMA                    money, 
    @CargoInicial           money,
    @AbonoInicial           money,
    @CargoFinal             money,
    @AbonoFinal             money,
    @SaldoInicial           money,
    @SaldoFinal             money, 
    @Ok                     int
 
  SELECT @Moneda = ContMoneda FROM EmpresaCfg a WHERE a.Empresa = @Empresa
  SELECT Cuenta, Descripcion, EsAcreedora, "SMA" = CONVERT(money, NULL)
    INTO #AI
    FROM Cta
   WHERE AjusteInflacionario = 1
 
  DECLARE crAI CURSOR FOR 
   SELECT Cuenta 
     FROM #AI
 
  OPEN crAI
  FETCH NEXT FROM crAI INTO @Cuenta
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spSaldoInicialCont @Empresa, @Cuenta, @Ejercicio, @PeriodoD, NULL, @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @Ok OUTPUT, @Moneda = @Moneda
      SELECT @SaldoInicial = ISNULL(@CargoInicial, 0) - ISNULL(@AbonoInicial, 0)
 
      EXEC spSaldoFinalCont @Empresa, @Cuenta, @Ejercicio, @PeriodoA, @CargoFinal OUTPUT, @AbonoFinal OUTPUT, @Ok OUTPUT, @Moneda = @Moneda
      SELECT @SaldoFinal = ISNULL(@CargoFinal, 0) - ISNULL(@AbonoFinal, 0)
      SELECT @SMA = (@SaldoInicial + @SaldoFinal) / 2 
 
      UPDATE #AI SET SMA = @SMA WHERE CURRENT OF crAI
    END
    FETCH NEXT FROM crAI INTO @Cuenta
  END
  CLOSE crAI
  DEALLOCATE crAI
  SELECT * FROM #AI
  RETURN
END
GO


/**************** spVerCtaSub ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCtaSub') and type = 'P') drop procedure dbo.spVerCtaSub
GO             
CREATE PROCEDURE spVerCtaSub
                        @Cuenta		char(20),
			@Empresa	varchar(50)	= NULL,
			@Usuario	varchar(50)	= NULL,
			@GrupoTrabajo	varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Empresa      IS NOT NULL SELECT @Empresa = '('+RTRIM(@Empresa)+')'
  IF @GrupoTrabajo IS NOT NULL SELECT @GrupoTrabajo = '('+RTRIM(@GrupoTrabajo)+')'
  IF NOT EXISTS (SELECT * FROM CtaSub WHERE Cuenta = @Cuenta)
    SELECT CentroCostos 
      FROM CentroCostos 
     WHERE EsAcumulativo = 0
       AND NULLIF(RTRIM(NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo, @Empresa)

  ELSE
    SELECT SubCuenta FROM CtaSub WHERE Cuenta = @Cuenta
  RETURN
END
GO

/**************** spVerCtaSub2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCtaSub2') and type = 'P') drop procedure dbo.spVerCtaSub2
GO             
CREATE PROCEDURE spVerCtaSub2
                        @Cuenta		char(20),
			@Empresa	varchar(50)	= NULL,
			@Usuario	varchar(50)	= NULL,
			@GrupoTrabajo	varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Empresa      IS NOT NULL SELECT @Empresa = '('+RTRIM(@Empresa)+')'
  IF @GrupoTrabajo IS NOT NULL SELECT @GrupoTrabajo = '('+RTRIM(@GrupoTrabajo)+')'
  IF NOT EXISTS (SELECT * FROM CtaSub2 WHERE Cuenta = @Cuenta)
    SELECT CentroCostos2 
      FROM CentroCostos2 
     WHERE EsAcumulativo = 0
       AND NULLIF(RTRIM(NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo, @Empresa)

  ELSE
    SELECT SubCuenta2 FROM CtaSub2 WHERE Cuenta = @Cuenta
  RETURN
END
GO

/**************** spVerCtaSub3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCtaSub3') and type = 'P') drop procedure dbo.spVerCtaSub3
GO             
CREATE PROCEDURE spVerCtaSub3
                        @Cuenta		char(20),
			@Empresa	varchar(50)	= NULL,
			@Usuario	varchar(50)	= NULL,
			@GrupoTrabajo	varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Empresa      IS NOT NULL SELECT @Empresa = '('+RTRIM(@Empresa)+')'
  IF @GrupoTrabajo IS NOT NULL SELECT @GrupoTrabajo = '('+RTRIM(@GrupoTrabajo)+')'
  IF NOT EXISTS (SELECT * FROM CtaSub3 WHERE Cuenta = @Cuenta)
    SELECT CentroCostos3 
      FROM CentroCostos3 
     WHERE EsAcumulativo = 0
       AND NULLIF(RTRIM(NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo, @Empresa)

  ELSE
    SELECT SubCuenta3 FROM CtaSub3 WHERE Cuenta = @Cuenta
  RETURN
END
GO

/**************** spVerPedidoPos ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spVerPedidoPos') and type = 'P') drop procedure dbo.spVerPedidoPos
GO             					
CREATE PROCEDURE spVerPedidoPos
		    @Estacion		int,
		    @Empresa		char(5),
		    @ID			int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @RenglonSub		int,
    @MovTipo		char(20),
    @Mov		char(20),
    @MovID		varchar(20),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Instruccion	varchar(50),
    @Unidad		varchar(50),
    @CantidadPendiente	 float,
    @CantidadRemisionada float,
    @CantidadFacturada	 float

  DELETE VerPedidoPos WHERE Estacion = @Estacion
  DECLARE crPedidoD CURSOR FOR
   SELECT v.Mov, v.MovID, d.Renglon, d.RenglonSub, d.Articulo, d.SubCuenta, d.Instruccion, d.Unidad
     FROM Venta v, VentaD d
    WHERE v.ID = @ID AND d.ID = v.ID

  OPEN crPedidoD
  FETCH NEXT FROM crPedidoD INTO @Mov, @MovID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Instruccion, @Unidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @CantidadPendiente = 0.0, @CantidadRemisionada = 0.0, @CantidadFacturada = 0.0

      SELECT @CantidadPendiente = ISNULL(SUM(d.CantidadPendiente), 0.0) + ISNULL(SUM(d.CantidadReservada), 0.0)
        FROM Venta v, VentaD d, MovTipo mt
       WHERE d.Aplica = @Mov AND d.AplicaID = @MovID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND d.Instruccion = @Instruccion
         AND v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         AND v.Mov = mt.Mov AND mt.Clave IN ('VTAS.P', 'VTAS.S')

      SELECT @CantidadFacturada = ISNULL(SUM(d.Cantidad+ISNULL(d.CantidadPendiente, 0.0)), 0.0)
        FROM Venta v, VentaD d, MovTipo mt
       WHERE d.Aplica = @Mov AND d.AplicaID = @MovID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND d.Instruccion = @Instruccion
         AND v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         AND v.Mov = mt.Mov AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB')

      SELECT @CantidadRemisionada = ISNULL(SUM(d.CantidadPendiente), 0.0)
        FROM Venta v, VentaD d, MovTipo mt
       WHERE d.Aplica = @Mov AND d.AplicaID = @MovID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND d.Instruccion = @Instruccion
         AND v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         AND v.Mov = mt.Mov AND mt.Clave IN ('VTAS.R', 'VTAS.VCR')
 
      SELECT @CantidadFacturada = @CantidadFacturada + ISNULL(SUM(d.Cantidad+ISNULL(d.CantidadPendiente, 0.0)), 0.0)
        FROM Venta r, VentaD rd, MovTipo rmt, Venta v, VentaD d, MovTipo mt
       WHERE rd.Aplica = @Mov AND rd.AplicaID = @MovID AND rd.Articulo = @Articulo AND ISNULL(rd.SubCuenta, '') = ISNULL(@SubCuenta, '') AND rd.Unidad = @Unidad AND rd.Instruccion = @Instruccion
         AND r.ID = rd.ID AND r.Empresa = @Empresa AND r.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         AND r.Mov = rmt.Mov AND rmt.Clave IN ('VTAS.R', 'VTAS.VCR')
         AND d.Aplica = r.Mov AND d.AplicaID = r.MovID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = @Unidad AND d.Instruccion = @Instruccion
         AND v.ID = d.ID AND v.Empresa = @Empresa AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
         AND v.Mov = mt.Mov AND mt.Clave IN ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.FB')

      INSERT VerPedidoPos (Estacion,  ID,  Renglon,  RenglonSub,  CantidadPendiente,  CantidadRemisionada, CantidadFacturada) 
                   VALUES (@Estacion, @ID, @Renglon, @RenglonSub, @CantidadPendiente, @CantidadRemisionada, @CantidadFacturada) 
    END
    FETCH NEXT FROM crPedidoD INTO @Mov, @MovID, @Renglon, @RenglonSub, @Articulo, @SubCuenta, @Instruccion, @Unidad
  END
  CLOSE crPedidoD
  DEALLOCATE crPedidoD
  RETURN
END
GO

-- spGenerarEstadoCuenta 10, 'DEMO', 'CXC', '1/1/1', NULL, NULL, NULL
-- select * from EstadoCuenta
--spGenerarEstadoCuenta 112, 'DEMO', 'CXC', '02/01/2007 00:00:00', '0', -1, '0'
/**************** spGenerarEstadoCuenta ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spGenerarEstadoCuenta') and type = 'P') drop procedure dbo.spGenerarEstadoCuenta
GO
CREATE PROCEDURE spGenerarEstadoCuenta
		    @Estacion		int,
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @FechaD		datetime,
		    @Cuenta		char(10),
		    @Sucursal		int,
		    @EstatusEspecifico	char(15) = NULL,
		    @FechaA		datetime = NULL 
--//WITH ENCRYPTION
AS BEGIN
  EXEC spExtraerFecha @FechaD OUTPUT
  IF @Cuenta = '0' SELECT @Cuenta = NULL
  IF @Sucursal = -1 SELECT @Sucursal = NULL
  SELECT @EstatusEspecifico = NULLIF(RTRIM(@EstatusEspecifico), '')
  IF @EstatusEspecifico = '0' SELECT @EstatusEspecifico = NULL

  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Modulo = @Modulo
  IF @Modulo = 'CXC' 
  BEGIN
    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Efectivo, Consumos, Vales, Redondeo, Moneda) 
    SELECT @Estacion, @Modulo, c.Cliente, SUM(Efectivo), SUM(Consumos), SUM(Vales), SUM(Redondeo), c.Moneda
      FROM CxcCuentaCorriente c, Cte
     WHERE c.Empresa = @Empresa 
       AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
       AND cte.Cliente = c.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
     GROUP BY c.Cliente, c.Moneda

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxc c, Cxc ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXC'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
--       AND c.Cliente = ISNULL(@Cuenta, c.Cliente)
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND c.Cliente = cte.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
	   --OR (mt.Clave IN ('CXC.SD', 'CXC.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Cte
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = cte.Cliente
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID     
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Efectivo, Vales, Redondeo, Moneda) 
    SELECT @Estacion, @Modulo, Proveedor, SUM(Efectivo), SUM(Vales), SUM(Redondeo), Moneda
      FROM CxpCuentaCorriente
     WHERE Empresa = @Empresa AND Proveedor = CASE WHEN @Cuenta IS NULL THEN Proveedor ELSE @Cuenta END
     GROUP BY Proveedor, Moneda

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Cxp c, Cxp ca, MovTipo mt
     WHERE a.Empresa  = @Empresa AND Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'CXP'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND ca.Empresa = c.Empresa
       AND ca.Proveedor = CASE WHEN @Cuenta IS NULL THEN ca.Proveedor ELSE @Cuenta END
       AND ca.Mov = mt.Mov AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH') 
	   --OR (mt.Clave IN ('CXP.SD', 'CXP.SCH') AND ca.Estatus = 'PENDIENTE')
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Estacion, Modulo, Cuenta, Moneda, AuxiliarID, ModuloID) 
    SELECT @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID, a.ModuloID
      FROM Auxiliar a, Dinero c, Dinero ca, MovTipo mt, Prov
     WHERE a.Empresa  = @Empresa AND a.Rama = @Modulo
       AND a.Aplica   = ca.Mov
       AND a.AplicaID = ca.MovID
       AND a.ModuloID = c.ID AND a.Modulo = 'DIN'
       AND c.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
       AND c.Empresa  = a.Empresa
       AND a.Cuenta = ISNULL(@Cuenta, a.Cuenta)
       AND a.Cuenta = Prov.Proveedor
       --AND ISNULL(cte.SucursalEmpresa, -1) = ISNULL(ISNULL(@Sucursal, cte.SucursalEmpresa), -1)
       AND ca.Empresa = c.Empresa
       AND ca.Mov = mt.Mov AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
       AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD  AND ca.FechaConclusion <= ISNULL(@FechaA,ca.FechaConclusion)))
       AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
     ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID     
   END
END
GO

/*
CREATE PROCEDURE spGenerarEstadoCuenta
		    @Estacion		int,
		    @Empresa		char(5),
		    @Modulo		char(5),
		    @FechaD		datetime,
		    @CuentaD		char(10),
		    @CuentaA		char(10)
--//WITH ENCRYPTION
AS BEGIN
  EXEC spExtraerFecha @FechaD OUTPUT

  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Empresa = @Empresa AND Modulo = @Modulo
  INSERT EstadoCuenta (Estacion, Empresa, Modulo, ModuloID, Renglon, RenglonSub, Aplica, AplicaID, Seccion, FechaEmision, Mov, MovID, Cuenta, Estatus, FechaConclusion, Cargo, Abono, Saldo, Moneda, TipoCambio, MovTipo)
  SELECT "Estacion"	   = @Estacion,
         "Empresa"         = c.Empresa,
	 "Modulo"	   = @Modulo,
         "ModuloID"	   = c.ID,
         "Renglon"	   = NULL,
         "RenglonSub"	   = NULL,
         "Aplica"          = c.Mov, 
         "AplicaID"        = c.MovID, 
         "Seccion"	   = 'A',
         "FechaEmision"    = c.FechaEmision,
         "Mov"             = c.Mov, 
         "MovID"           = c.MovID, 
	 "Cuenta"	   = c.Cliente,
         "Estatus"         = c.Estatus,
         "FechaConclusion" = c.FechaConclusion,
         "Cargo"           = CASE WHEN mt.Clave NOT IN ('CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP') THEN (ISNULL(c.Importe, 0.0)+ISNULL(c.Impuestos, 0.0)) ELSE NULL END,
         "Abono"           = CASE WHEN mt.Clave     IN ('CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP') THEN (ISNULL(c.Importe, 0.0)+ISNULL(c.Impuestos, 0.0)) ELSE NULL END,
         "Saldo"	   = c.Saldo,
         "Moneda"	   = c.Moneda,
         "TipoCambio"	   = c.TipoCambio,
         "MovTipo"         = mt.Clave 
   FROM Cxc c, MovTipo mt 
  WHERE mt.Mov = c.Mov AND mt.Modulo = 'CXC' AND mt.Clave IN ('CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.CD', 'CXC.RM', 'CXC.IM')
    AND (c.Estatus = 'PENDIENTE' OR (c.Estatus = 'CONCLUIDO' AND c.FechaConclusion >= @FechaD))
    AND c.Cliente BETWEEN @CuentaD AND @CuentaA
    AND c.Empresa = @Empresa

  UNION

  SELECT "Estacion"	   = @Estacion,
	 "Empresa"         = c.Empresa,
	 "Modulo"	   = @Modulo,
         "ModuloID"	   = d.ID,
         "Renglon"	   = d.Renglon,
         "RenglonSub"	   = d.RenglonSub,
         "Aplica"          = d.Aplica, 
         "AplicaID" 	   = d.AplicaID, 
         "Seccion"	   = 'B',
         "FechaEmision"    = c.FechaEmision,
         "Mov"             = c.Mov, 
         "MovID"           = c.MovID, 
	 "Cuenta"	   = c.Cliente,
         "Estatus"         = c.Estatus,
         "FechaConclusion" = c.FechaConclusion,
         "Cargo"           = CASE WHEN d.Importe<0 THEN -d.Importe ELSE NULL END,
         "Abono"           = CASE WHEN d.Importe>0 THEN  d.Importe ELSE NULL END,
         "Saldo"           = CONVERT(money, NULL),
         "Moneda"	   = c.Moneda,
         "TipoCambio"	   = c.TipoCambio,
         "MovTipo"         = mt.Clave 
   FROM Cxc c, CxcD d, MovTipo mt 
  WHERE mt.Mov = c.Mov AND mt.Modulo = 'CXC' AND d.ID = c.ID 
    AND d.Aplica   IN (SELECT DISTINCT Cxc.Mov   FROM Cxc, MovTipo WHERE Cxc.Empresa = @Empresa AND c.Cliente BETWEEN @CuentaD AND @CuentaA AND Cxc.Mov = MovTipo.Mov AND MovTipo.Clave IN ('CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.CD', 'CXC.RM', 'CXC.IM') AND (Cxc.Estatus = 'PENDIENTE' OR (Cxc.Estatus = 'CONCLUIDO' AND Cxc.FechaConclusion >= @FechaD)))
    AND d.AplicaID IN (SELECT DISTINCT Cxc.MovID FROM Cxc, MovTipo WHERE Cxc.Empresa = @Empresa AND c.Cliente BETWEEN @CuentaD AND @CuentaA AND Cxc.Mov = MovTipo.Mov AND MovTipo.Clave IN ('CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.CD', 'CXC.RM', 'CXC.IM') AND (Cxc.Estatus = 'PENDIENTE' OR (Cxc.Estatus = 'CONCLUIDO' AND Cxc.FechaConclusion >= @FechaD)))
    AND c.Empresa = @Empresa

  UNION

  SELECT "Estacion"	   = @Estacion,
	 "Empresa"         = c.Empresa,
	 "Modulo"	   = @Modulo,
         "ModuloID"	   = c.ID,
         "Renglon"	   = NULL,
         "RenglonSub"	   = NULL,
         "Aplica"          = c.Origen, 
         "AplicaID"        = c.OrigenID, 
         "Seccion"	   = 'B',
         "FechaEmision"    = c.FechaEmision,
         "Mov"             = c.Mov, 
         "MovID"           = c.MovID, 
	 "Cuenta"	   = c.Cliente,
         "Estatus"         = c.Estatus,
         "FechaConclusion" = c.FechaConclusion,
         "Cargo"	   = c.Importe,
         "Abono"           = CONVERT(money, NULL),
         "Saldo"	   = CONVERT(money, NULL),
         "Moneda"	   = c.Moneda,
         "TipoCambio"	   = c.TipoCambio,
         "MovTipo"         = mt.Clave 
   FROM Cxc c, MovTipo mt 
  WHERE c.OrigenTipo = 'CXC'
    AND mt.Mov = c.Mov AND mt.Modulo = 'CXC'
    AND c.Origen   IN (SELECT DISTINCT Cxc.Mov   FROM Cxc, MovTipo WHERE Cxc.Empresa = @Empresa AND c.Cliente BETWEEN @CuentaD AND @CuentaA AND Cxc.Mov = MovTipo.Mov AND MovTipo.Clave IN ('CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.CD', 'CXC.RM', 'CXC.IM') AND (Cxc.Estatus = 'PENDIENTE' OR (Cxc.Estatus = 'CONCLUIDO' AND Cxc.FechaConclusion >= @FechaD)))
    AND c.OrigenID IN (SELECT DISTINCT Cxc.MovID FROM Cxc, MovTipo WHERE Cxc.Empresa = @Empresa AND c.Cliente BETWEEN @CuentaD AND @CuentaA AND Cxc.Mov = MovTipo.Mov AND MovTipo.Clave IN ('CXC.F', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF','CXC.DV','CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP', 'CXC.CD', 'CXC.RM', 'CXC.IM') AND (Cxc.Estatus = 'PENDIENTE' OR (Cxc.Estatus = 'CONCLUIDO' AND Cxc.FechaConclusion >= @FechaD)))
    AND c.Empresa = @Empresa

  ORDER BY
    Empresa, Cuenta, Aplica, AplicaID, Seccion, FechaEmision
END*/
GO


-- spVerNominaAcum 'DEMO', '1/1/1', '1/1/3', 'LG'
/**************** spVerNominaAcum ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerNominaAcum') and type = 'P') drop procedure dbo.spVerNominaAcum
GO             
CREATE PROCEDURE spVerNominaAcum
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
		        @Personal	char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Personal = NULLIF(NULLIF(RTRIM(@Personal), ''), '0')

  SELECT d.Concepto, d.Personal, "Importe" = SUM(d.Importe), "Cantidad"=SUM(d.Cantidad)
    FROM Nomina e, NominaD d, MovTipo mt
   WHERE e.ID = d.ID 
     AND e.Empresa = @Empresa 
     AND e.Estatus = 'CONCLUIDO' 
     AND e.FechaD BETWEEN @FechaD AND @FechaA
     AND mt.Mov = e.Mov 
     AND mt.Modulo = 'NOM'
     AND mt.Clave IN ('NOM.N', 'NOM.NE', 'NOM.NA')
     AND d.Personal = ISNULL(@Personal, d.Personal)
   GROUP BY d.Concepto, d.Personal
   ORDER BY d.Concepto, d.Personal
END
GO

/**************** spVerMovFlujoExplotar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovFlujoExplotar') and type = 'P') drop procedure dbo.spVerMovFlujoExplotar
GO             
CREATE PROCEDURE spVerMovFlujoExplotar
			@Estacion	int,
			@Empresa	char(5),
			@BaseModulo	char(5),
			@BaseID		int,
                        @Nivel		int,
                        @Tipo		char(10)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Modulo  char(5),
  @ID	   int,
  @Mov	   char(20),
  @MovID   varchar(20)

  SELECT @Nivel = @Nivel + 1
  IF @Tipo = 'Origen'
  BEGIN
    DECLARE crMovFlujo CURSOR LOCAL FOR
     SELECT OModulo, OID, OMov, OMovID
       FROM MovFlujo
      WHERE Cancelado = 0 AND DModulo = @BaseModulo AND DID = @BaseID

    OPEN crMovFlujo
    FETCH NEXT FROM crMovFlujo INTO @Modulo, @ID, @Mov, @MovID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        INSERT VerMovFlujo (Estacion, Tipo, Nivel, Empresa, Modulo, ModuloID, Mov, MovID)
                    VALUES (@Estacion, @Tipo, @Nivel, @Empresa, @Modulo, @ID, @Mov, @MovID)
        EXEC spVerMovFlujoExplotar @Estacion, @Empresa, @Modulo, @ID, @Nivel, @Tipo
      END
      FETCH NEXT FROM crMovFlujo INTO @Modulo, @ID, @Mov, @MovID
    END
    CLOSE crMovFlujo
    DEALLOCATE crMovFlujo
  END ELSE
  IF @Tipo = 'Destino'
  BEGIN
    DECLARE crMovFlujo CURSOR LOCAL FOR
     SELECT DModulo, DID, DMov, DMovID
       FROM MovFlujo
      WHERE Cancelado = 0 AND OModulo = @BaseModulo AND OID = @BaseID

    OPEN crMovFlujo
    FETCH NEXT FROM crMovFlujo INTO @Modulo, @ID, @Mov, @MovID
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        INSERT VerMovFlujo (Estacion, Tipo, Nivel, Empresa, Modulo, ModuloID, Mov, MovID)
                    VALUES (@Estacion, @Tipo, @Nivel, @Empresa, @Modulo, @ID, @Mov, @MovID)
        EXEC spVerMovFlujoExplotar @Estacion, @Empresa, @Modulo, @ID, @Nivel, @Tipo
      END
      FETCH NEXT FROM crMovFlujo INTO @Modulo, @ID, @Mov, @MovID
    END
    CLOSE crMovFlujo
    DEALLOCATE crMovFlujo
  END   
  RETURN
END
GO

/**************** spVerMovFlujo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovFlujo') and type = 'P') drop procedure dbo.spVerMovFlujo
GO             
CREATE PROCEDURE spVerMovFlujo
			@Estacion	int,
			@Empresa	char(5),
			@Modulo		char(5),
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE VerMovFlujo WHERE Estacion = @Estacion
  EXEC spVerMovFlujoExplotar @Estacion, @Empresa, @Modulo, @ID, 0, 'Origen'
  EXEC spVerMovFlujoExplotar @Estacion, @Empresa, @Modulo, @ID, 0, 'Destino'
  RETURN
END
GO

/**************** spVerAuxCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAuxCorte') and type = 'P') drop procedure dbo.spVerAuxCorte
GO             
CREATE PROCEDURE spVerAuxCorte
			@Estacion	int,
			@Empresa	char(5),
			@Modulo		char(5),
			@FechaD		datetime,
			@FechaA		datetime,
                        @CuentaD	char(10),
                        @CuentaA	char(10)
--//WITH ENCRYPTION
AS BEGIN

  DECLARE @RedondeoMonetarios int --BUG 20588

  SELECT @RedondeoMonetarios = ISNULL(RedondeoMonetarios,0) --BUG 20588
  FROM Version

  DELETE VerAuxCorte WHERE Estacion = @Estacion

  INSERT VerAuxCorte (Estacion, Empresa, Modulo, Moneda, Cuenta, Mov, MovID, Saldo)
  SELECT @Estacion, a.Empresa, @Modulo, a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, "Saldo" = (ISNULL(SUM(a.Cargo), 0)-ISNULL(SUM(a.Abono), 0))
    FROM Auxiliar a, Rama r
   WHERE a.Rama = r.Rama
     AND r.Mayor = @Modulo
     AND a.Empresa = @Empresa
     AND a.Fecha BETWEEN @FechaD AND @FechaA
     AND a.Cuenta BETWEEN @CuentaD AND @CuentaA
   GROUP BY a.Empresa, a.Moneda, a.Cuenta, a.Aplica, a.AplicaID
  HAVING ROUND(ISNULL(SUM(Cargo), 0)-ISNULL(SUM(Abono), 0), @RedondeoMonetarios) <> 0 --BUG 20588
   ORDER BY a.Empresa, a.Moneda, a.Cuenta, a.Aplica, a.AplicaID

  IF @Modulo = 'CXC'
    UPDATE VerAuxCorte 
       SET ModuloID    = e.ID
      FROM VerAuxCorte ac, Cxc e
     WHERE ac.Estacion = @Estacion AND ac.MovID IS NOT NULL
       AND e.Empresa = ac.Empresa AND e.Mov = ac.Mov AND e.MovID = ac.MovID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO')
  ELSE 
  IF @Modulo = 'CXP'
    UPDATE VerAuxCorte 
       SET ModuloID    = e.ID
      FROM VerAuxCorte ac, Cxp e
     WHERE ac.Estacion = @Estacion AND ac.MovID IS NOT NULL
       AND e.Empresa = ac.Empresa AND e.Mov = ac.Mov AND e.MovID = ac.MovID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO')
END
GO
-- spVerAuxCorte  1, 'DEMO', 'CXC', '1/30/2000', 'A', 'Z'
-- SELECT * FROM VerAuxCorte where modulo = 'cxc'


/**************** spVerOpcionIdioma ****************/ --MEJORA1394
if exists (select * from sysobjects where id = object_id('dbo.spVerOpcionIdioma') and type = 'P') drop procedure dbo.spVerOpcionIdioma
GO             
CREATE PROCEDURE spVerOpcionIdioma
		@Modulo		varchar(5),
		@ID			int,
		@Articulo	varchar(20)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Idioma				varchar(50),
    @Opcion				char(1), 
    @ListaEspecifica	varchar(50)
    

  DECLARE @Traduccion TABLE
  (
  TextoOriginal			varchar(255),
  Traduccion			varchar(255)			
  )  
      
  IF @Modulo IN ('COMS','VTAS')
  BEGIN

    IF @Modulo = 'VTAS' SELECT @Idioma = c.Idioma FROM Cte c JOIN Venta v   ON v.Cliente = c.Cliente     WHERE v.ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @Idioma = p.Idioma FROM Prov p JOIN Compra c ON c.Proveedor = p.Proveedor WHERE c.ID = @ID     

    DECLARE crArtOpcion CURSOR FOR
     SELECT ao.Opcion, NULLIF(RTRIM(ao.ListaEspecifica), '')
       FROM ArtOpcion ao, Opcion o
      WHERE o.Opcion = ao.Opcion AND ao.Articulo = @Articulo AND o.TieneDetalle = 1

    OPEN crArtOpcion
    FETCH NEXT FROM crArtOpcion INTO @Opcion, @ListaEspecifica
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN    

        IF UPPER(@ListaEspecifica) IN (NULL, '(TODAS)')
          INSERT @Traduccion (TextoOriginal, Traduccion) 
          SELECT d.Nombre, ie.Nombre
            FROM OpcionD d JOIN IdiomaEtiqueta ie
              ON ie.Etiqueta = d.Nombre
           WHERE d.Opcion = @Opcion
             AND ie.Idioma = @Idioma
        ELSE
        IF UPPER(@ListaEspecifica) = '(ESPECIAL)'
          INSERT @Traduccion (TextoOriginal, Traduccion)       
          SELECT d.Nombre, ie.Nombre
            FROM ArtOpcionD l JOIN OpcionD d
              ON d.Opcion = l.Opcion AND d.Numero = l.Numero JOIN IdiomaEtiqueta ie
              ON ie.Etiqueta = d.Nombre
           WHERE l.Opcion = @Opcion 
             AND l.Articulo = @Articulo
             AND ie.Idioma = @Idioma         
        ELSE
          INSERT @Traduccion (TextoOriginal, Traduccion)               
          SELECT d.Nombre, ie.Nombre 
            FROM OpcionLista l JOIN OpcionListaD ld
              ON ld.Opcion = l.Opcion AND ld.Lista = l.Lista JOIN OpcionD d
              ON d.Opcion = l.Opcion AND d.Numero = ld.Numero JOIN IdiomaEtiqueta ie
              ON ie.Etiqueta = d.Nombre
           WHERE l.Opcion = @Opcion 
             AND l.Lista = @ListaEspecifica
             AND ie.Idioma = @Idioma           

      END     
      FETCH NEXT FROM crArtOpcion INTO @Opcion, @ListaEspecifica
    END
    CLOSE crArtOpcion
    DEALLOCATE crArtOpcion
  
  END
  
  SELECT * FROM @Traduccion    
END
GO

/**************** spVerOpcionD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerOpcionD') and type = 'P') drop procedure dbo.spVerOpcionD
GO             
CREATE PROCEDURE spVerOpcionD
			@Articulo		char(20),
			@OpcionEspecifica	char(1) 	= NULL,
			@Buscar			varchar(100) 	= NULL,
			@Generar		bit		= 0,
			@Estacion		int		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Opcion		char(1), 
    @ListaEspecifica	varchar(50)


  IF @Buscar IS NOT NULL
    SELECT @Buscar = REPLACE(@Buscar,'*','%')

  IF @Generar = 1
    DECLARE crArtOpcion CURSOR FOR
     SELECT ao.Opcion, NULLIF(RTRIM(ao.ListaEspecifica), '')
       FROM ArtOpcion ao, Opcion o
      WHERE o.Opcion = ao.Opcion AND ao.Articulo = @Articulo AND o.TieneDetalle = 1
        AND o.Opcion IN (SELECT Opcion FROM ArtOpcionWizard w WHERE w.Estacion = @Estacion AND w.Generar = 1)
  ELSE
  BEGIN
    CREATE TABLE #OpcionD (Opcion	char(1) COLLATE Database_Default NOT NULL, Numero int NULL, Nombre varchar(100) COLLATE Database_Default NULL, InformacionAdicional varchar(100) COLLATE Database_Default NULL, Imagen varchar(255) COLLATE Database_Default NULL) --MEJORA1394
    DECLARE crArtOpcion CURSOR FOR
     SELECT ao.Opcion, NULLIF(RTRIM(ao.ListaEspecifica), '')
       FROM ArtOpcion ao, Opcion o
      WHERE o.Opcion = ao.Opcion AND ao.Articulo = @Articulo AND o.TieneDetalle = 1
        AND o.Opcion = ISNULL(@OpcionEspecifica, o.Opcion)
  END

  OPEN crArtOpcion
  FETCH NEXT FROM crArtOpcion INTO @Opcion, @ListaEspecifica
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN    
      IF @OpcionEspecifica IS NULL 
        IF EXISTS(SELECT * FROM Opcion WHERE Opcion = @Opcion AND UPPER(AyudaCaptura) = 'BUSCAR') 
        BEGIN
          FETCH NEXT FROM crArtOpcion INTO @Opcion, @ListaEspecifica
          CONTINUE
        END

      IF @Buscar IS NULL
      BEGIN
        IF UPPER(@ListaEspecifica) IN (NULL, '(TODAS)')
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT Opcion, Numero, Nombre, InformacionAdicional, Imagen --MEJORA1394
            FROM OpcionD 
           WHERE Opcion = @Opcion
             AND ISNULL(Descontinuado,0) = 0
        ELSE
        IF UPPER(@ListaEspecifica) = '(ESPECIAL)'
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT l.Opcion, l.Numero, d.Nombre, ISNULL(NULLIF(l.InformacionAdicional,''),d.InformacionAdicional), ISNULL(NULLIF(l.Imagen,''),d.Imagen) --MEJORA1394
            FROM ArtOpcionD l, OpcionD d
           WHERE l.Opcion = @Opcion AND l.Articulo = @Articulo
             AND d.Opcion = l.Opcion AND d.Numero = l.Numero 
             AND ISNULL(d.Descontinuado,0) = 0 --MEJORA5547             
        ELSE
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT ld.Opcion, ld.Numero, d.Nombre, d.InformacionAdicional, d.Imagen --MEJORA1394
            FROM OpcionLista l, OpcionListaD ld, OpcionD d
           WHERE l.Opcion = @Opcion AND l.Lista = @ListaEspecifica
             AND ld.Opcion = l.Opcion AND ld.Lista = l.Lista
             AND d.Opcion = l.Opcion AND d.Numero = ld.Numero
             AND ISNULL(d.Descontinuado,0) = 0 --MEJORA5547                          
      END ELSE
      BEGIN
        IF UPPER(@ListaEspecifica) IN (NULL, '(TODAS)')
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT Opcion, Numero, Nombre, InformacionAdicional, Imagen --MEJORA1394
            FROM OpcionD 
           WHERE Opcion = @Opcion 
             AND Nombre LIKE @Buscar
             AND ISNULL(Descontinuado,0) = 0 --MEJORA5547                          
        IF UPPER(@ListaEspecifica) = '(ESPECIAL)'
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT l.Opcion, l.Numero, d.Nombre, ISNULL(NULLIF(l.InformacionAdicional,''),d.InformacionAdicional), ISNULL(NULLIF(l.Imagen,''),d.Imagen) --MEJORA1394
            FROM ArtOpcionD l, OpcionD d
           WHERE l.Opcion = @Opcion AND l.Articulo = @Articulo
             AND d.Opcion = l.Opcion AND d.Numero = l.Numero
             AND d.Nombre LIKE @Buscar
             AND ISNULL(d.Descontinuado,0) = 0 --MEJORA5547             
        ELSE
          INSERT #OpcionD (Opcion, Numero, Nombre, InformacionAdicional, Imagen) --MEJORA1394
          SELECT ld.Opcion, ld.Numero, d.Nombre, d.InformacionAdicional, d.Imagen --MEJORA1394
            FROM OpcionLista l, OpcionListaD ld, OpcionD d
           WHERE l.Opcion = @Opcion AND l.Lista = @ListaEspecifica
             AND ld.Opcion = l.Opcion AND ld.Lista = l.Lista
             AND d.Opcion = l.Opcion AND d.Numero = ld.Numero
             AND d.Nombre LIKE @Buscar
             AND ISNULL(Descontinuado,0) = 0 --MEJORA5547                          
      END
    END
    FETCH NEXT FROM crArtOpcion INTO @Opcion, @ListaEspecifica
  END
  CLOSE crArtOpcion
  DEALLOCATE crArtOpcion

  IF @Generar = 0
  BEGIN
    IF @OpcionEspecifica IS NULL
      SELECT * FROM #OpcionD
    ELSE
      SELECT Numero, Nombre FROM #OpcionD
  END
  RETURN
END
GO

-- spVerOpcionD 'C920', 'C'
-- spVerAplicaDifMov 'CXC', -1
/**************** spVerAplicaDifMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerAplicaDifMov') and type = 'P') drop procedure dbo.spVerAplicaDifMov
GO             
CREATE PROCEDURE spVerAplicaDifMov
			@Modulo	char(5),
			@Saldo	money
--//WITH ENCRYPTION
AS BEGIN
  IF @Modulo = 'CXC'
  BEGIN
    IF @Saldo < 0.0
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('CXC.NC', 'CXC.DAC', 'CXC.NCD', 'CXC.NCF')
      UNION
      SELECT "Saldo a Favor"
    ELSE
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('CXC.CA', 'CXC.CAD')
  END ELSE
  BEGIN
    IF @Saldo < 0.0
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('CXP.NC', 'CXP.DAC', 'CXP.NCD', 'CXP.NCF')
      UNION
      SELECT "Saldo a Favor"
    ELSE
      SELECT Mov FROM MovTipo WHERE Modulo = @Modulo AND Clave IN ('CXP.CA', 'CXP.CAD')
  END
  RETURN
END
GO

/**************** spVerArtPrecioDescuento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerArtPrecioDescuento') and type = 'P') drop procedure dbo.spVerArtPrecioDescuento
GO             
CREATE PROCEDURE spVerArtPrecioDescuento
		    @Articulo	char(20),
		    @SubCuenta	varchar(50),
		    @Lista	char(20),
		    @Moneda	char(5),
		    @TipoCambio	float,
		    @EnSilencio bit = 0,
    		    @Precio 	money = NULL OUTPUT,
    		    @Descuento	float = NULL OUTPUT
             
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ArtMoneda	char(10)
    

  SELECT @Precio = NULL, 
         @Articulo = NULLIF(RTRIM(@Articulo), ''),  
         @SubCuenta = NULLIF(RTRIM(@SubCuenta), ''),  
         @Lista = NULLIF(RTRIM(@Lista), ''), 
         @Moneda = NULLIF(RTRIM(@Moneda), ''), 
         @TipoCambio = NULLIF(@TipoCambio, 0)

  IF @Lista IS NOT NULL
  BEGIN
    IF @SubCuenta IS NOT NULL
    BEGIN
      SELECT @Precio = NULLIF(Precio, 0) FROM ListaPreciosSub WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Lista = @Lista AND Moneda = @Moneda
      IF @Precio IS NOT NULL
        SELECT @Precio = MIN(lp.Precio)/@TipoCambio FROM ListaPreciosSub lp, Mon m WHERE lp.Articulo = @Articulo AND SubCuenta = @SubCuenta AND lp.Lista = @Lista AND lp.Moneda = m.Moneda AND m.TipoCambio = 1
    END
    IF @Precio IS NULL 
    BEGIN
      SELECT @Precio = NULLIF(Precio, 0) FROM ListaPreciosD WHERE Articulo = @Articulo AND Lista = @Lista AND Moneda = @Moneda
      IF @Precio IS NOT NULL
        SELECT @Precio = MIN(lp.Precio)/@TipoCambio FROM ListaPreciosD lp, Mon m WHERE lp.Articulo = @Articulo AND lp.Lista = @Lista AND lp.Moneda = m.Moneda AND m.TipoCambio = 1
    END
  END
  IF @Precio IS NULL
  BEGIN
    SELECT @Precio = PrecioLista, @ArtMoneda = ISNULL(MonedaPrecio, @Moneda) FROM Art WHERE Articulo = @Articulo
    IF @ArtMoneda <> @Moneda
      SELECT @Precio = @Precio * m.TipoCambio / @TipoCambio FROM Mon m WHERE Moneda = @ArtMoneda
  END

  IF @EnSilencio = 0
    SELECT "Precio" = @Precio, "Descuento" = NULL
  RETURN
END
GO

/*

declare
  @precio	money
EXEC spVerArtPrecioDescuento 'BLUSA', 'C1T1', '(Precio Lista)', 'Pesos', 1.0, 1, @Precio OUTPUT
select @precio

*/

-- spVerConceptoClase 'VTAS', NULL, NULL, 'DEMO'
-- spVerConceptoClase 'GAS', 'Administrativos', '', 'DEMO', 'ADMINISTRACION', 'A1', 'Acreedor'
/**************** spVerConceptoClase ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerConceptoClase') and type = 'P') drop procedure dbo.spVerConceptoClase
GO             
CREATE PROCEDURE spVerConceptoClase
			@Modulo		char(5),
			@Clase		varchar(50) = NULL,
			@SubClase	varchar(50) = NULL,
			@Usuario	char(10)    = NULL,
 			@GrupoTrabajo	varchar(50) = NULL,
			@Acreedor	char(10)    = NULL,
			@Ayuda		varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Clase    	= NULLIF(NULLIF(RTRIM(@Clase), ''), '0'),
         @SubClase 	= NULLIF(NULLIF(RTRIM(@SubClase), ''), '0'),
         @Usuario 	= NULLIF(NULLIF(RTRIM(@Usuario), ''), '0'),
 	 @GrupoTrabajo	= NULLIF(NULLIF(RTRIM(@GrupoTrabajo), ''), '0'),
 	 @Acreedor	= NULLIF(NULLIF(RTRIM(@Acreedor), ''), '0'),
         @Ayuda		= UPPER(@Ayuda)

  IF @Ayuda = 'CLASIFICACION'
  BEGIN
    IF @GrupoTrabajo IS NOT NULL SELECT @GrupoTrabajo = '('+RTRIM(@GrupoTrabajo)+')'
    IF @Clase IS NOT NULL AND @SubClase IS NOT NULL
      SELECT Concepto 
        FROM Concepto 
       WHERE Modulo = @Modulo AND Clase = @Clase AND SubClase = @SubClase
         AND ((NULLIF(RTRIM(Concepto.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
          OR (Concepto.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = @Modulo AND ca.Concepto = Concepto.Concepto AND ca.Usuario = @Usuario)))
    ELSE
    IF @Clase IS NOT NULL 
      SELECT Concepto 
        FROM Concepto 
       WHERE Modulo = @Modulo AND Clase = @Clase
         AND ((NULLIF(RTRIM(Concepto.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
          OR (Concepto.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = @Modulo AND ca.Concepto = Concepto.Concepto AND ca.Usuario = @Usuario)))
    ELSE
      SELECT Concepto 
        FROM Concepto 
       WHERE Modulo = @Modulo 
         AND ((NULLIF(RTRIM(Concepto.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
          OR (Concepto.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = @Modulo AND ca.Concepto = Concepto.Concepto AND ca.Usuario = @Usuario)))
  END ELSE
  IF @Ayuda = 'ACREEDOR'
    SELECT ca.Concepto 
      FROM ConceptoAcreedor ca, Concepto
     WHERE ca.Modulo = @Modulo AND ca.Acreedor = @Acreedor
       AND Concepto.Concepto = ca.Concepto AND Concepto.Modulo = @Modulo
       AND ((NULLIF(RTRIM(Concepto.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
        OR (Concepto.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = @Modulo AND ca.Concepto = Concepto.Concepto AND ca.Usuario = @Usuario))) 
  ELSE
      SELECT Concepto 
        FROM Concepto 
       WHERE Modulo = @Modulo 
         AND ((NULLIF(RTRIM(Concepto.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
          OR (Concepto.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = @Modulo AND ca.Concepto = Concepto.Concepto AND ca.Usuario = @Usuario))) 
  RETURN
END
GO

-- spVerConceptos 'DEMO'
/**************** spVerConceptos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerConceptos') and type = 'P') drop procedure dbo.spVerConceptos
GO             
CREATE PROCEDURE spVerConceptos
			@Usuario	char(10)    = NULL,
 			@GrupoTrabajo	varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Usuario 	= NULLIF(NULLIF(RTRIM(@Usuario), ''), '0'),
 	 @GrupoTrabajo	= NULLIF(NULLIF(RTRIM(@GrupoTrabajo), ''), '0')

    SELECT c.Modulo, c.Concepto 
      FROM Concepto c
     WHERE ((NULLIF(RTRIM(c.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
        OR (c.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = c.Modulo AND ca.Concepto = c.Concepto AND ca.Usuario = @Usuario))) 
     ORDER BY c.Modulo, c.Orden
  RETURN
END
GO

-- spVerConceptosValidar 'DEMO'
/**************** spVerConceptosValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerConceptosValidar') and type = 'P') drop procedure dbo.spVerConceptosValidar
GO             
CREATE PROCEDURE spVerConceptosValidar
			@Empresa	char(5),
			@Usuario	char(10)    = NULL,
 			@GrupoTrabajo	varchar(50) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Usuario 	= NULLIF(NULLIF(RTRIM(@Usuario), ''), '0'),
 	 @GrupoTrabajo	= NULLIF(NULLIF(RTRIM(@GrupoTrabajo), ''), '0')

    SELECT cv.Empresa, cv.Modulo, cv.Mov, cv.Concepto 
      FROM Concepto c
      JOIN EmpresaConceptoValidar cv ON cv.Empresa = @Empresa AND cv.Modulo = c.Modulo AND cv.Concepto = c.Concepto
     WHERE ((NULLIF(RTRIM(c.NivelAcceso), '') IN (NULL, '(Todos)', @Usuario, @GrupoTrabajo)) 
        OR (c.NivelAcceso = '(Especifico)' AND EXISTS(SELECT * FROM ConceptoAcceso ca WHERE ca.Modulo = c.Modulo AND ca.Concepto = c.Concepto AND ca.Usuario = @Usuario))) 
     ORDER BY cv.Empresa, cv.Modulo, cv.Mov, cv.Concepto 
  RETURN
END
GO

/**************** spCuentaClase ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCuentaClase') and type = 'P') drop procedure dbo.spCuentaClase
GO             
CREATE PROCEDURE spCuentaClase
			@Modulo		char(5),
			@Clase		varchar(50),
			@SubClase	varchar(50),
			@Cuenta		char(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Cuenta   = NULL,
         @Clase    = NULLIF(NULLIF(RTRIM(@Clase), ''), '0'),
         @SubClase = NULLIF(NULLIF(RTRIM(@SubClase), ''), '0')

  IF @SubClase IS NOT NULL
    SELECT @Cuenta = NULLIF(RTRIM(Cuenta), '')
      FROM SubClase
     WHERE Modulo = @Modulo AND Clase = @Clase AND SubClase = @SubClase 

  IF @Cuenta IS NULL
    SELECT @Cuenta = Cuenta
      FROM Clase
     WHERE Modulo = @Modulo AND Clase = @Clase

  RETURN
END
GO

-- spVerCuentaClase 'GAS', 'Oficina', 'Impresora'
/**************** spVerCuentaClase ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCuentaClase') and type = 'P') drop procedure dbo.spVerCuentaClase
GO             
CREATE PROCEDURE spVerCuentaClase
			@Modulo		char(5),
			@Clase		varchar(50),
			@SubClase	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuenta char(20)

  EXEC spCuentaClase @Modulo, @Clase, @SubClase, @Cuenta OUTPUT

  SELECT "Cuenta" = @Cuenta
  RETURN
END
GO


-- spVerListaPrecios 'DEMO', 1, 'mex'
/**************** spVerListaPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerListaPrecios') and type = 'P') drop procedure dbo.spVerListaPrecios
GO             
CREATE PROCEDURE spVerListaPrecios
			@Usuario		char(10),
			@ControlListasPrecios	bit,
			@Cliente		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @ControlListasPrecios = 1 
    SELECT ListaPrecios FROM UsuarioPrecios WHERE Usuario = @Usuario
    UNION
    SELECT ListaPreciosEsp FROM Cte WHERE Cliente = @Cliente
  ELSE
    SELECT Lista FROM ListaPreciosEsp ORDER BY Orden
END
GO

/**************** spPrecioEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPrecioEsp') and type = 'P') drop procedure dbo.spPrecioEsp
GO             
CREATE PROCEDURE spPrecioEsp
			@Lista		varchar(20),
			@Moneda		char(10),
			@Articulo	varchar(20),
			@SubCuenta	varchar(50),
                        @Precio		money		OUTPUT,
			@Unidad		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Precio = NULL, 
         @Lista = ISNULL(NULLIF(NULLIF(RTRIM(@Lista), ''), '0'), '(Precio Lista)'), 
         @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), ''), '0')
  IF @SubCuenta = '0' SELECT @SubCuenta = NULL

  IF @Unidad IS NOT NULL
  BEGIN
    IF @SubCuenta IS NOT NULL
      SELECT @Precio = Precio FROM ListaPreciosSubUnidad WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad
    ELSE
      SELECT @Precio = Precio FROM ListaPreciosDUnidad WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND Unidad = @Unidad
  END
  IF @Precio IS NULL
  BEGIN
    IF @SubCuenta IS NOT NULL
      SELECT @Precio = Precio FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
    IF @Precio IS NULL
      SELECT @Precio = Precio FROM ListaPreciosD WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo 
    IF @Precio IS NULL
      SELECT @Precio = CASE @Lista 
                       WHEN '(Precio 2)'  THEN Precio2
                       WHEN '(Precio 3)'  THEN Precio3
                       WHEN '(Precio 4)'  THEN Precio4
                       WHEN '(Precio 5)'  THEN Precio5
                       WHEN '(Precio 6)'  THEN Precio6
                       WHEN '(Precio 7)'  THEN Precio7
                       WHEN '(Precio 8)'  THEN Precio8
                       WHEN '(Precio 9)'  THEN Precio9
                       WHEN '(Precio 10)' THEN Precio10
                       ELSE PrecioLista 
                     END
        FROM Art 
       WHERE Articulo = @Articulo
  END
END
GO


/**************** spVerPrecioEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPrecioEsp') and type = 'P') drop procedure dbo.spVerPrecioEsp
GO             
CREATE PROCEDURE spVerPrecioEsp
			@Lista		varchar(20),
			@Moneda		char(10),
			@Articulo	varchar(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Precio 	money

  EXEC spPrecioEsp @Lista, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT, @Unidad = @Unidad
  SELECT "Precio" = @Precio
END
GO
-- spVerPrecioEsp '(Precio Lista)', 'Pesos', 'A1', NULL

-- spWebArtRama 'DEMO', 'MEX', NULL, NULL
/**************** spWebArtRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtRama') and type = 'P') drop procedure dbo.spWebArtRama
GO             
CREATE PROCEDURE spWebArtRama
			@Empresa	char(5),
			@Cliente	char(10),
			@Rama		char(20),
			@Buscar		varchar(100) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
      @Lista		varchar(20),
      @Idioma		varchar(50),
      @Moneda		char(10),
      @TipoCambio	float,
      @Articulo		varchar(20),
      @Unidad		varchar(50),
      @Precio		money,
      @Codigo		char(20),
      @Descripcion1	varchar(100)

  SELECT @Cliente = NULLIF(RTRIM(@Cliente), ''), @Rama = NULLIF(RTRIM(@Rama), ''), @Buscar = NULLIF(RTRIM(@Buscar), '')
  SELECT @Lista = ISNULL(NULLIF(RTRIM(c.ListaPreciosEsp), ''), '(Precio Lista)'), 
         @Moneda = NULLIF(RTRIM(c.DefMoneda), ''), 
         @TipoCambio = m.TipoCambio,
         @Idioma = NULLIF(RTRIM(c.Idioma), '')
    FROM Cte c, Mon m
   WHERE c.Cliente = @Cliente AND m.Moneda = c.DefMoneda

  IF @Buscar IS NULL
  BEGIN
    SELECT "Articulo" = RTRIM(Art.Articulo), 
           "Rama" = RTRIM(Art.Rama),
           "Codigo" = RTRIM(Art.Articulo), 
           "Descripcion1" = RTRIM(Art.Descripcion1), 
           "Descripcion2" = RTRIM(Art.Descripcion2), 
           "Fabricante" = RTRIM(Fabricante), 
           "TipoArt" = RTRIM(Art.Tipo) , 
           "Precio" = CONVERT(money, NULL),
           "Moneda" = @Moneda,
           "Nombre" = RTRIM(AnexoCta.Nombre), 
           "TipoAnexoCta" = RTRIM(AnexoCta.Tipo), 
           "Direccion" = RTRIM(AnexoCta.Direccion), 
           "Unidad" = RTRIM(Art.Unidad)  
      INTO #WebLista
      FROM Art
      LEFT OUTER JOIN AnexoCta ON Art.Articulo = AnexoCta.Cuenta AND (AnexoCta.Nombre = 'Imagen' OR AnexoCta.Nombre IS NULL) AND (AnexoCta.Tipo = 'Imagen' OR AnexoCta.Tipo IS NULL) 
     WHERE Art.Rama = @Rama
       AND Art.Tipo <> 'Estructura' 
       AND wMostrar = 1 
     ORDER BY Art.Tipo, Art.Descripcion1, Art.Articulo, AnexoCta.Tipo

    DECLARE crWebLista CURSOR FOR
     SELECT Articulo, Unidad, Codigo, Descripcion1
       FROM #WebLista
  END ELSE
  BEGIN
    SELECT "Articulo" = RTRIM(Art.Articulo), 
           "Rama" = RTRIM(Art.Rama),
           "Codigo" = RTRIM(Art.Articulo), 
           "Descripcion1" = RTRIM(Art.Descripcion1), 
           "Descripcion2" = RTRIM(Art.Descripcion2), 
           "Fabricante" = RTRIM(Fabricante), 
           "TipoArt" = RTRIM(Art.Tipo) , 
           "Precio" = CONVERT(money, NULL),
           "Moneda" = @Moneda,
           "Nombre" = RTRIM(AnexoCta.Nombre), 
           "TipoAnexoCta" = RTRIM(AnexoCta.Tipo), 
           "Direccion" = RTRIM(AnexoCta.Direccion), 
           "Unidad" = RTRIM(Art.Unidad)  
      INTO #WebListaBuscar
      FROM Art
      LEFT OUTER JOIN AnexoCta ON Art.Articulo = AnexoCta.Cuenta AND (AnexoCta.Nombre = 'Imagen' OR AnexoCta.Nombre IS NULL) AND (AnexoCta.Tipo = 'Imagen' OR AnexoCta.Tipo IS NULL) 
     WHERE Art.Tipo <> 'Estructura' 
       AND (Descripcion1 LIKE @Buscar OR ClaveFabricante LIKE @Buscar OR Art.Articulo LIKE @Buscar) 
       AND wMostrar = 1 
     ORDER BY Art.Tipo, Art.Descripcion1, Art.Articulo, AnexoCta.Tipo

    DECLARE crWebLista CURSOR FOR
     SELECT Articulo, Unidad, Codigo, Descripcion1
       FROM #WebListaBuscar
  END

  OPEN crWebLista
  FETCH NEXT FROM crWebLista INTO @Articulo, @Unidad, @Codigo, @Descripcion1
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      EXEC spPCGet 0, @Empresa, @Articulo, NULL, @Unidad, @Moneda, @TipoCambio, @Lista, @Precio OUTPUT
      IF @Idioma IS NOT NULL
        SELECT @Codigo = ISNULL(Codigo, @Codigo), 
               @Descripcion1 = ISNULL(Descripcion, @Descripcion1)
          FROM ArtIdioma
         WHERE Articulo = @Articulo AND Idioma = @Idioma

      IF @Buscar IS NULL
        UPDATE #WebLista 
           SET Codigo = @Codigo, Descripcion1 = @Descripcion1, Precio = @Precio 
         WHERE CURRENT OF crWebLista
      ELSE
        UPDATE #WebListaBuscar
           SET Codigo = @Codigo, Descripcion1 = @Descripcion1, Precio = @Precio 
         WHERE CURRENT OF crWebLista
    END
    FETCH NEXT FROM crWebLista INTO @Articulo, @Unidad, @Codigo, @Descripcion1
  END
  CLOSE crWebLista
  DEALLOCATE crWebLista
  IF @Buscar IS NULL
    SELECT * FROM #WebLista ORDER BY Articulo
  ELSE
    SELECT * FROM #WebListaBuscar ORDER BY Articulo
END
GO

/************** spWebJuego *************/
if exists (select * from sysobjects where id = object_id('dbo.spWebJuego') and sysstat & 0xf = 4) drop procedure dbo.spWebJuego
GO
CREATE PROCEDURE spWebJuego
		   @Empresa	char(5),
                   @Articulo    char(20),
                   @ArtCantidad	float,
		   @Cliente	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda			char(10),
    @TipoCambio			float,
    @Idioma			varchar(50),
    @PrecioIndependiente	bit,
    @ListaPrecios		varchar(50),
    @Opcion			char(20),
    @Unidad			varchar(50),
    @Precio			money,
    @Codigo			char(20),
    @Descripcion1		varchar(100)

  SELECT @Cliente = NULLIF(RTRIM(@Cliente), '')
  SELECT @Moneda = NULLIF(RTRIM(c.DefMoneda), ''), 
         @TipoCambio = m.TipoCambio,
         @Idioma = NULLIF(RTRIM(c.Idioma), '')
    FROM Cte c, Mon m
   WHERE c.Cliente = @Cliente AND m.Moneda = c.DefMoneda

 SELECT RTrim(ArtJuegoD.Articulo) Articulo, 
        RTrim(ArtJuegoD.Juego) Juego, 
        RTrim(ArtJuego.Descripcion) DescJuego, 
        RTrim(ArtJuegoD.Opcion) Opcion, 
        RTrim(ArtJuegoD.Opcion) Codigo, 
        RTrim(Art.Descripcion1) DescArticulo, 
        ArtJuego.PrecioIndependiente, 
        RTrim(ListaPreciosEsp) ListaPreciosEsp, 
        RTrim(Art.Unidad) Unidad, 
        RTrim(Art.Fabricante) Fabricante, 
        RTrim(Art.Rama) Rama, 
        RTrim(AnexoCta.Nombre) Nombre, 
        RTrim(AnexoCta.Tipo) TipoAnexoCta, 
        RTrim(AnexoCta.Direccion) Direccion, 
        "Cantidad" = ArtJuego.Cantidad*@ArtCantidad, 
        ArtJuego.CantidadVariable, 
        ArtJuego.Opcional, 
        ArtJuego.SinOpcionOmision,
        "Precio" = CONVERT(money, NULL)
   INTO #Juego
   FROM Art
   LEFT OUTER JOIN AnexoCta ON Art.Articulo = AnexoCta.Cuenta AND (AnexoCta.Nombre = 'Imagen' OR AnexoCta.Nombre IS NULL) AND (AnexoCta.Tipo = 'Imagen' OR AnexoCta.Tipo IS NULL) 
   LEFT OUTER JOIN ArtIdioma ON Art.Articulo = ArtIdioma.Articulo 
   JOIN ArtJuegoD ON ArtJuegoD.Opcion = Art.Articulo 
   JOIN ArtJuego ON ArtJuego.Juego = ArtJuegoD.Juego AND ArtJuegoD.Articulo = ArtJuego.Articulo 
  WHERE ArtJuegoD.Articulo = @Articulo

  DECLARE crJuego CURSOR FOR
   SELECT PrecioIndependiente, ListaPreciosEsp, Opcion, Codigo, DescArticulo, Unidad
     FROM #Juego

  OPEN crJuego
  FETCH NEXT FROM crJuego INTO @PrecioIndependiente, @ListaPrecios, @Opcion, @Codigo, @Descripcion1, @Unidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @PrecioIndependiente = 1
      BEGIN
        SELECT @Precio = NULL
        EXEC spPCGet 0, @Empresa, @Opcion, NULL, @Unidad, @Moneda, @TipoCambio, @ListaPrecios, @Precio OUTPUT
        UPDATE #Juego SET Precio = @Precio WHERE CURRENT OF crJuego
      END
      IF @Idioma IS NOT NULL
      BEGIN
        SELECT @Codigo = ISNULL(Codigo, @Codigo), 
               @Descripcion1 = ISNULL(Descripcion, @Descripcion1)
          FROM ArtIdioma
         WHERE Articulo = @Opcion AND Idioma = @Idioma
        UPDATE #Juego SET Codigo = @Codigo, DescArticulo = @Descripcion1 WHERE CURRENT OF crJuego
      END
    END
    FETCH NEXT FROM crJuego INTO @PrecioIndependiente, @ListaPrecios, @Opcion, @Codigo, @Descripcion1, @Unidad
  END  -- While
  CLOSE crJuego
  DEALLOCATE crJuego

  SELECT * FROM #Juego ORDER BY Juego, Opcion
  RETURN
END
GO

-- spWebJuego 'TAURO', 'FABIANMX', 10, '26036'

-- spVerGastoEjercido 'DEMO', '11/1/3', '1/9/4', 'gasolina', 'Pesos', '0'

/**************** spVerGastoEjercido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerGastoEjercido') and type = 'P') drop procedure dbo.spVerGastoEjercido
GO             
CREATE PROCEDURE spVerGastoEjercido
			@Empresa	char(5),
			@FechaEmision	datetime,
			@FechaRequerida	datetime,
			@Concepto	varchar(50),
			@MovMoneda	char(10),
			@ContUso 	char(20),
			@EnSilencio	bit	 = 0,
			@GastoEjercido	money	 = NULL	OUTPUT,
			@ContUso2 	char(20) = NULL,
			@ContUso3 	char(20) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @ContUso = NULLIF(NULLIF(RTRIM(@ContUso), '0'), ''),
         @ContUso2 = NULLIF(NULLIF(RTRIM(@ContUso2), '0'), ''),
         @ContUso3 = NULLIF(NULLIF(RTRIM(@ContUso3), '0'), ''),
         @FechaRequerida = ISNULL(@FechaRequerida, @FechaEmision),
         @GastoEjercido = NULL

  IF (SELECT GastoValidarPresupuestoFR FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
    SELECT @GastoEjercido = SUM((d.Importe-ISNULL(d.Provision, 0.0))*CASE WHEN mt.Clave='GAS.DG' THEN -1 ELSE 1 END) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND DATEPART(year, e.FechaRequerida) = DATEPART(year, @FechaRequerida) AND DATEPART(month, e.FechaRequerida) = DATEPART(month, @FechaRequerida)
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.DG', 'GAS.DPR', 'GAS.EST')
  ELSE
    SELECT @GastoEjercido = SUM((d.Importe-ISNULL(d.Provision, 0.0))*CASE WHEN mt.Clave='GAS.DG' THEN -1 ELSE 1 END) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.G', 'GAS.P', 'GAS.GTC', 'GAS.C', 'GAS.DG', 'GAS.DPR', 'GAS.EST')

  SELECT @GastoEjercido = ISNULL(@GastoEjercido, 0.0)
  IF @EnSilencio = 0
    SELECT 'GastoEjercido' = @GastoEjercido
  RETURN
END
GO

/**************** spVerGastoPendiente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerGastoPendiente') and type = 'P') drop procedure dbo.spVerGastoPendiente
GO             
CREATE PROCEDURE spVerGastoPendiente
			@Empresa	char(5),
			@FechaEmision	datetime,
			@FechaRequerida	datetime,
			@Concepto	varchar(50),
			@MovMoneda	char(10),
			@ContUso 	char(20),
			@EnSilencio	bit	 = 0,
			@GastoPendiente	money	 = NULL	OUTPUT,
			@ContUso2 	char(20) = NULL,
			@ContUso3 	char(20) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @ContUso = NULLIF(NULLIF(RTRIM(@ContUso), '0'), ''),
         @ContUso2 = NULLIF(NULLIF(RTRIM(@ContUso2), '0'), ''),
         @ContUso3 = NULLIF(NULLIF(RTRIM(@ContUso3), '0'), ''),
         @FechaRequerida = ISNULL(@FechaRequerida, @FechaEmision),
         @GastoPendiente = NULL

  IF (SELECT GastoValidarPresupuestoFR FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
    SELECT @GastoPendiente = SUM(d.Importe*mt.Factor) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaRequerida) = DATEPART(year, @FechaRequerida) AND DATEPART(month, e.FechaRequerida) = DATEPART(month, @FechaRequerida)
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')
   ELSE
    SELECT @GastoPendiente = SUM(d.Importe*mt.Factor) 
      FROM Gasto e, GastoD d, MovTipo mt 
     WHERE Empresa = @Empresa AND e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND d.Concepto = @Concepto AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'GAS' AND mt.Mov = e.Mov AND mt.Clave IN ('GAS.S', 'GAS.A')

  SELECT @GastoPendiente = ISNULL(@GastoPendiente, 0.0)
  IF @EnSilencio = 0
    SELECT 'GastoPendiente' = @GastoPendiente
END
GO

/**************** spVerPresupuestoCompraEjercido ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPresupuestoCompraEjercido') and type = 'P') drop procedure dbo.spVerPresupuestoCompraEjercido
GO             
CREATE PROCEDURE spVerPresupuestoCompraEjercido
			@Empresa	char(5),
			@FechaEmision	datetime,
			@FechaRequerida	datetime,
			@Articulo	varchar(20),
			@SubCuenta	varchar(50),
			@MovMoneda	varchar(10),
			@ContUso 	varchar(20),
			@Categoria	varchar(50),
			@ContUso2 	char(20) = NULL,
			@ContUso3 	char(20) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), '0'), ''),
         @ContUso = NULLIF(NULLIF(RTRIM(@ContUso), '0'), ''),
         @ContUso2 = NULLIF(NULLIF(RTRIM(@ContUso2), '0'), ''),
         @ContUso3 = NULLIF(NULLIF(RTRIM(@ContUso3), '0'), ''),
         @Categoria = NULLIF(NULLIF(RTRIM(@Categoria), '0'), ''),
         @FechaRequerida = ISNULL(@FechaRequerida, @FechaEmision)

  IF @Categoria IS NOT NULL
    SELECT SUM(d.SubTotal*CASE WHEN mt.Clave IN ('COMS.D', 'COMS.B') THEN -1 ELSE 1 END) 
      FROM Compra e, CompraTCalc d, MovTipo mt, Art a
     WHERE e.ID = d.ID AND e.Estatus = 'CONCLUIDO' AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND /*d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND */e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.CA', 'COMS.GX', 'GAS.EST', 'GAS.CI', 'COMS.D', 'COMS.B')
       AND a.Articulo = d.Articulo AND a.Categoria = @Categoria  AND d.Empresa = @Empresa     
  ELSE
    SELECT SUM(d.SubTotal*CASE WHEN mt.Clave IN ('COMS.D', 'COMS.B') THEN -1 ELSE 1 END) 
      FROM Compra e, CompraTCalc d, MovTipo mt 
     WHERE e.ID = d.ID AND e.Estatus = 'CONCLUIDO' AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI', 'COMS.CA', 'COMS.GX', 'GAS.EST', 'GAS.CI', 'COMS.D', 'COMS.B') AND d.Empresa = @Empresa
END
GO

/**************** spVerPresupuestoCompraPendiente ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPresupuestoCompraPendiente') and type = 'P') drop procedure dbo.spVerPresupuestoCompraPendiente
GO             
CREATE PROCEDURE spVerPresupuestoCompraPendiente
			@Empresa	char(5),
			@FechaEmision	datetime,
			@FechaRequerida	datetime,
			@Articulo	varchar(20),
			@SubCuenta	varchar(50),
			@MovMoneda	varchar(10),
			@ContUso 	varchar(20),
			@Categoria	varchar(50),
			@ContUso2 	char(20) = NULL,
			@ContUso3 	char(20) = NULL
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @SubCuenta = NULLIF(NULLIF(RTRIM(@SubCuenta), '0'), ''),
         @ContUso = NULLIF(NULLIF(RTRIM(@ContUso), '0'), ''),
         @ContUso2 = NULLIF(NULLIF(RTRIM(@ContUso2), '0'), ''),
         @ContUso3 = NULLIF(NULLIF(RTRIM(@ContUso3), '0'), ''),
         @Categoria = NULLIF(NULLIF(RTRIM(@Categoria), '0'), ''),
         @FechaRequerida = ISNULL(@FechaRequerida, @FechaEmision)

  IF @Categoria IS NOT NULL
    SELECT SUM(d.SubTotal) 
      FROM Compra e, CompraTCalc d, MovTipo mt, Art a
     WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND /*d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND */e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave IN ('COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OI')
       AND a.Articulo = d.Articulo AND a.Categoria = @Categoria AND d.Empresa = @Empresa
  ELSE
    SELECT SUM(d.SubTotal) 
      FROM Compra e, CompraTCalc d, MovTipo mt 
     WHERE e.ID = d.ID AND e.Estatus = 'PENDIENTE' AND DATEPART(year, e.FechaEmision) = DATEPART(year, @FechaEmision) AND DATEPART(month, e.FechaEmision) = DATEPART(month, @FechaEmision)
       AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND e.Moneda = @MovMoneda 
       AND ISNULL(d.ContUso, '')  = ISNULL(ISNULL(@ContUso, d.ContUso), '')
       AND ISNULL(d.ContUso2, '') = ISNULL(ISNULL(@ContUso2, d.ContUso2), '')
       AND ISNULL(d.ContUso3, '') = ISNULL(ISNULL(@ContUso3, d.ContUso3), '')
       AND mt.Modulo = 'COMS' AND mt.Mov = e.Mov AND mt.Clave IN ('COMS.O', 'COMS.OP', 'COMS.OG', 'COMS.OI') AND d.Empresa = @Empresa
END
GO

/**************** spGenerarInvCorte ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spGenerarInvCorte') and type = 'P') drop procedure dbo.spGenerarInvCorte
GO
CREATE PROCEDURE spGenerarInvCorte
		    @Estacion		int,
		    @Empresa		char(5),
		    @Almacen		char(10),
		    @Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Existencia		float,
    @CargoInicial 	money, 
    @AbonoInicial 	money, 
    @CargoInicialU 	float, 
    @AbonoInicialU 	float,
    @Ok 		int,
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Moneda		char(10),
    @hora		datetime

  SELECT @Almacen = NULLIF(NULLIF(RTRIM(@Almacen), ''), '0')
  IF @Almacen IS NULL OR @Fecha IS NULL OR YEAR(@Fecha) = 1899 RETURN
  SELECT @Fecha = DATEADD(day, 1, @Fecha)
  DELETE VerInvCorte WHERE Estacion = @Estacion
  SELECT @Ok = NULL

  DECLARE crInvCorte CURSOR FOR
   SELECT a.Articulo, a.MonedaCosto, s.SubCuenta
     FROM SaldoU s, Art a 
    WHERE s.Rama = 'INV' AND s.Cuenta = a.Articulo AND a.Estatus <> 'BAJA'
    GROUP BY a.Articulo, a.MonedaCosto, s.SubCuenta
    ORDER BY a.Articulo, a.MonedaCosto, s.SubCuenta

  OPEN crInvCorte
  FETCH NEXT FROM crInvCorte INTO @Articulo, @Moneda, @SubCuenta
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spSaldoInicial @Empresa, 'INV', @Moneda, @Almacen, @Articulo, @SubCuenta, @Fecha, 0, 1, 0, 
         		   @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT,
         	           @Ok OUTPUT 
      SELECT @Existencia = @CargoInicialU-@AbonoInicialU

      INSERT VerInvCorte (Estacion,  Empresa,  Almacen,  Articulo,  SubCuenta,  Existencia,             Fecha)
                  VALUES (@Estacion, @Empresa, @Almacen, @Articulo, @SubCuenta, NULLIF(@Existencia, 0), @Fecha)
    END
    FETCH NEXT FROM crInvCorte INTO @Articulo, @Moneda, @SubCuenta
  END
  CLOSE crInvCorte
  DEALLOCATE crInvCorte
END
GO

/*
set nocount on
EXEC spGenerarInvCorte 1, 'USI', 'SIA', '12/31/1'
SELECT * FROM VerInvCorte where estacion = 1
select * from alm

declare
  @CargoInicial		money,
  @AbonoInicial		money,
  @CargoInicialU	float,
  @AbonoInicialU	float,
  @Ok			int

      EXEC spSaldoInicial 'USI', 'INV', 'Pesos', 'SIA', '1-1-18', 'C1M5', '4/1/2', 0, 1, 0, 
         		   @CargoInicial OUTPUT, @AbonoInicial OUTPUT, @CargoInicialU OUTPUT, @AbonoInicialU OUTPUT,
         	           @Ok OUTPUT 
*/

/**************** spVerCobroRetencion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCobroRetencion') and sysstat & 0xf = 4) drop procedure dbo.spVerCobroRetencion
GO             
CREATE PROCEDURE spVerCobroRetencion
			@Empresa	char(5),
			@Mov		char(20),
			@MovID		char(20),
			@ImporteCobrado	money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Importe		money,
    @Impuestos		money,
    @Retencion		money,
    @ImporteTotal	money

  SELECT @Importe = ISNULL(Importe, 0), @Impuestos = ISNULL(Impuestos, 0), @Retencion = ISNULL(Retencion, 0)
    FROM Cxc
   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')

  SELECT @ImporteTotal = @Importe + @Impuestos - @Retencion
  SELECT "RetencionCobrada" = (@ImporteCobrado * @Retencion) / @ImporteTotal
END
GO


-- spVerContXMov 'VTAS'
/**************** spVerContXMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContXMov') and sysstat & 0xf = 4) drop procedure dbo.spVerContXMov
GO             
CREATE PROCEDURE spVerContXMov
			@Modulo	char(5)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @ID		int,
			@Movto	varchar(20)

	DECLARE @Mov TABLE (ID int identity(1,1), Mov varchar(20))

	DECLARE cMov1 CURSOR FOR
	SELECT x.ID,
		   mt.Mov 
      FROM ContX x, 
	       MovTipo mt 
	 WHERE x.Modulo = @Modulo 
	   AND x.Estatus = 'ACTIVO' 
	   AND mt.Modulo = x.Modulo 
	   AND x.Mov = '('+RTRIM(mt.Clave)+')'
  ORDER BY x.ID		

	OPEN cMov1
	FETCH NEXT FROM cMov1 INTO @ID, @Movto
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT Mov FROM @Mov WHERE Mov = @Movto) 
			INSERT INTO @Mov(Mov) VALUES(@Movto)

		FETCH NEXT FROM cMov1 INTO @ID, @Movto
	END
	CLOSE cMov1
	DEALLOCATE cMov1

	DECLARE cMov2 CURSOR FOR
	 SELECT x.ID, x.Mov 
       FROM ContX x 
	  WHERE x.Modulo = @Modulo 
	    AND x.Estatus = 'ACTIVO' 
		AND x.Mov NOT IN (SELECT '('+RTRIM(mt.Clave)+')' 
	   FROM MovTipo mt 
	  WHERE mt.Modulo = x.Modulo)
   ORDER BY x.ID		

	OPEN cMov2
	FETCH NEXT FROM cMov2 INTO @ID, @Movto
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT Mov FROM @Mov WHERE Mov = @Movto)  
			INSERT INTO @Mov(Mov) VALUES(@Movto)

		FETCH NEXT FROM cMov2 INTO @ID, @Movto
	END
	CLOSE cMov2
	DEALLOCATE cMov2
	
	SELECT Mov FROM @Mov ORDER BY ID

END	
GO

/**************** spCalcImpuestoSeminuevos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcImpuestoSeminuevos') and type = 'P') drop procedure dbo.spCalcImpuestoSeminuevos
GO              
CREATE PROCEDURE spCalcImpuestoSeminuevos
			@VIN		varchar(20),
    			@TipoUnidad	varchar(20),
			@ID 		int,
			@Costo		money,
			@Precio		money		OUTPUT,
			@Impuesto1	float 		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @IVAporOmision	float,
    @FiscalRegimen	varchar(20),
    @ZonaImpuesto	varchar(50),
    @Utilidad		money,
    @Porcentaje		float,
    @IVA		money,
    @ImporteTotal	money,
    @CompraID		int

  SELECT @IVAporOmision = 15.0
  
  SELECT @ZonaImpuesto = ZonaImpuesto
    FROM Venta
   WHERE ID = @ID 
  SELECT @CompraID = CompraID FROM VIN WHERE VIN = @VIN

  SELECT @Porcentaje = @IVAporOmision / 100
  SELECT @Porcentaje = ISNULL(NULLIF(Porcentaje, 0), @IVAporOmision)/100 FROM ZonaImp WHERE Zona = @ZonaImpuesto AND Impuesto = @IVAporOmision

  SELECT @FiscalRegimen = UPPER(p.FiscalRegimen)
    FROM Prov p, Compra c
   WHERE c.ID = @CompraID AND c.Proveedor = p.Proveedor

  IF @FiscalRegimen IN ('PERSONA FISICA', 'PECOS') AND @Costo > 0
  BEGIN
    SELECT @ImporteTotal = @Precio --ImporteTotal/NULLIF(@Cantidad, 0) FROM VentaTCalc WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
    SELECT @Utilidad = @ImporteTotal - @Costo    
    SELECT @IVA = @Utilidad-(@Utilidad/(1+@Porcentaje))
    -- Para que no manda impuestos Negativos
    IF ISNULL(@IVA, 0) < 0 SELECT @IVA = 0.0
    SELECT @Precio = @ImporteTotal - @IVA
    SELECT @Impuesto1 = (@IVA * 100) / CONVERT(float, @Precio)
  END ELSE
  BEGIN
    SELECT @Precio = @Precio/(1+@Porcentaje)
    SELECT @Impuesto1 = @Porcentaje * 100
  END

  RETURN
END
GO

/**************** spPrecioBlindado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPrecioBlindado') and type = 'P') drop procedure dbo.spPrecioBlindado
GO              
CREATE PROCEDURE spPrecioBlindado
			@Linea		varchar(50),
			@Modelo		char(5),
			@ListaPrecios	varchar(50),
			@Moneda		char(10),
			@TipoCambio	float,
			@PrecioMN	money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @MaxPrecioLista	money,
    @PrecioBlindado	money,
    @ArtBlindado	char(20)

  SELECT @MaxPrecioLista = 0.0, @ArtBlindado = NULL
  SELECT @MaxPrecioLista = ISNULL(MAX(PrecioLista), 0.0) FROM Art WHERE Linea = @Linea AND Modelo = @Modelo
  IF @MaxPrecioLista > 0.0 
    SELECT @ArtBlindado = MIN(Articulo) FROM Art WHERE Linea = @Linea AND Modelo = @Modelo AND PrecioLista = @MaxPrecioLista

  IF @ArtBlindado IS NOT NULL
    EXEC spPrecioEsp @ListaPrecios, @Moneda, @ArtBlindado, NULL, @PrecioBlindado OUTPUT
  SELECT @PrecioMN = @PrecioBlindado * @TipoCambio

  RETURN
END
GO


-- spVentaCalcISAN 198291, 234470
-- select 234470.0-importetotal, importetotal, precio,impuesto1,impuesto2,impuesto2total,impuesto1,* from ventatcalc where id = 198291
/**************** spVentaCalcISAN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVentaCalcISAN') and type = 'P') drop procedure dbo.spVentaCalcISAN
GO             
CREATE PROCEDURE spVentaCalcISAN
			@ID		int,
			@Total		float = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon			float,
    @RenglonID			int,
    @TipoCambio			float,
    @Almacen			char(10),
    @Articulo			char(20),
    @SubCuenta			varchar(20),
    @VIN			varchar(20),
    @TipoUnidad			varchar(20),
    @ISAN			bit,
    @ExcentoISAN		bit,
    @Empresa			char(5),
    @Costo			money,
    @Precio			float,
    @PrecioMN			float,
    @TotalAccesoriosMN		float,
    @TotalMN			float,
    @BlindadoTotalMN		float,
    @BlindadoSubTotalMN		float,
    @BlindadoImporteMN		float,
    @BlindadoImpuestoMN		float,
    @SubTotalMN			float,
    @Tabla			varchar(50),
    @TablaISAN			varchar(50),
    @TablaISANLujo		varchar(50),
    @ImporteISANLujo		float,
    @PeriodoTipo		char(20),
    @ArtImpuesto1		float,
    @ArtImpuesto2		float,
    @Impuesto2			float,
    @DesglosarImpuesto2		bit,
    @AccesoriosMN		float,
    @AccesoriosExcluidosMN	float,
    @ImporteMN 			float, 
    @ImporteMNLujo 		float, 
    @ImpuestoMN		        float,
    @ImpuestoMNLujo		float,
    @Dif			float,
    @JuntarImpuestos		float,
    @CfgVINAccesorioArt 	bit,
    @CfgVINCostoSumaAccesorios	bit,
    @Blindado			bit,
    @PrecioBlindadoMN		float,
    @ListaPrecios		varchar(50),
    @Moneda			char(10),
    @ArtLinea			varchar(50),
    @ArtModelo			char(4)

  SELECT @Articulo = NULL, @VIN = NULL, @TipoUnidad = 'NUEVO', @Impuesto2 = NULL, @Precio = NULL, @Total = NULLIF(@Total, 0)  
  SELECT @Articulo = MIN(d.Articulo) FROM VentaD d, Art a WHERE d.ID = @ID AND d.Articulo = a.Articulo AND a.Tipo='VIN'
  SELECT @PrecioBlindadoMN = 0.0

  IF @Articulo IS NOT NULL
  BEGIN
    SELECT @Almacen = Almacen, @Renglon = Renglon, @RenglonID = RenglonID, @SubCuenta = SubCuenta 
      FROM VentaD 
     WHERE ID = @ID AND Articulo = @Articulo

    SELECT @Empresa = Empresa, @Moneda = v.Moneda, @TipoCambio = v.TipoCambio, @ListaPrecios = v.ListaPreciosEsp, @ExcentoISAN = ISNULL(c.ExcentoISAN, 0), @DesglosarImpuesto2 = ISNULL(DesglosarImpuesto2, 0) 
      FROM Venta v, Cte c 
     WHERE v.ID = @ID AND v.Cliente = c.Cliente

    SELECT @TablaISAN = TablaISAN, @TablaISANLujo = TablaISANLujo, @ImporteISANLujo = ImporteISANLujo 
      FROM EmpresaCfg 
     WHERE Empresa = @Empresa

    SELECT @CfgVINAccesorioArt 		= VINAccesorioArt,
           @CfgVINCostoSumaAccesorios	= VINCostoSumaAccesorios
      FROM EmpresaCfg2
     WHERE Empresa = @Empresa 

    SELECT @ISAN = ISNULL(ISAN, 0), @ArtImpuesto1 = Impuesto1, @ArtImpuesto2 = NULLIF(Impuesto2, 0), @ArtLinea = Linea, @ArtModelo = Modelo
      FROM Art 
     WHERE Articulo = @Articulo

    SELECT @VIN = MIN(SerieLote)
      FROM SerieLoteMov
     WHERE Empresa = @Empresa AND Modulo = 'VTAS' AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo 

    IF @VIN IS NOT NULL
      SELECT @TipoUnidad = UPPER(TipoUnidad), @Blindado = ISNULL(Blindado, 0) FROM VIN WHERE VIN = @VIN

    IF @ISAN = 1 AND @TipoUnidad = 'NUEVO'
    BEGIN
      IF @Blindado = 1
        EXEC spPrecioBlindado @ArtLinea, @ArtModelo, @ListaPrecios, @Moneda, @TipoCambio, @PrecioBlindadoMN OUTPUT

      IF @ExcentoISAN = 0 AND @DesglosarImpuesto2 = 1
      BEGIN
        IF @Total IS NULL
        BEGIN
          SELECT @PrecioMN = SUM(SubTotal)*@TipoCambio FROM VentaTCalc WHERE ID = @ID AND Articulo = @Articulo
          SELECT @SubTotalMN = SUM(SubTotal)*@TipoCambio FROM VentaTCalc WHERE ID = @ID AND ExcluirISAN = 0
          IF @Blindado = 1 AND @PrecioBlindadoMN > 0.0
            SELECT @SubTotalMN = @SubTotalMN - @PrecioMN + @PrecioBlindadoMN

          IF @SubTotalMN >= @ImporteISANLujo SELECT @Tabla = @TablaISANLujo ELSE SELECT @Tabla = @TablaISAN

          IF @ArtImpuesto2 IS NOT NULL
          BEGIN
            SELECT @ImpuestoMN = @SubTotalMN * (@ArtImpuesto2/100)
            EXEC xpTablaImpuesto @Tabla, '(Sin Periodo)', @SubTotalMN, @ImpuestoMN OUTPUT
          END ELSE
            EXEC spTablaImpuesto @Tabla, NULL, '(Sin Periodo)', @SubTotalMN, @ImpuestoMN OUTPUT   

          SELECT @Impuesto2 = (CONVERT(float, @ImpuestoMN) / NULLIF(@PrecioMN, 0)) * 100
        END ELSE
        BEGIN
          SELECT @AccesoriosExcluidosMN = ISNULL(SUM(Subtotal*@TipoCambio), 0) FROM VentaTCalc WHERE ID = @ID AND Articulo <> @Articulo AND ExcluirISAN = 1
          SELECT @AccesoriosMN = ISNULL(SUM(Subtotal*@TipoCambio), 0) FROM VentaTCalc WHERE ID = @ID AND Articulo <> @Articulo AND ExcluirISAN = 0
          SELECT @TotalAccesoriosMN = ISNULL(SUM(ImporteTotal*@TipoCambio), 0) FROM VentaTCalc WHERE ID = @ID AND Articulo <> @Articulo 
          SELECT @TotalMN = (@Total * @TipoCambio) 

          SELECT @SubTotalMN = (@TotalMN-@TotalAccesoriosMN)/(1+(@ArtImpuesto1/100)) + @AccesoriosMN
          --SELECT @SubTotalMN = @TotalMN/(1+(@ArtImpuesto1/100)) - @AccesoriosExcluidosMN

          /*IF @ArtImpuesto2 IS NOT NULL
          BEGIN
            SELECT @ImporteMN = @SubTotalMN/(1+(@ArtImpuesto2/100))
            SELECT @ImpuestoMN = @SubTotalMN - @ImporteMN          
            --EXEC xpTablaImpuesto @TablaISAN, '(Sin Periodo)', @ImporteMN, @ImpuestoMN OUTPUT
          END ELSE*/
            EXEC spTablaImpuestoInversa @TablaISAN, NULL, '(Sin Periodo)', @SubTotalMN, @ImporteMN OUTPUT, @ImpuestoMN OUTPUT, @TablaLujo = @TablaISANLujo, @ImporteLujo = @ImporteISANLujo, @PorcentajeFijo = @ArtImpuesto2
 
          IF @Blindado = 1 AND @PrecioBlindadoMN > 0.0
          BEGIN
            SELECT @BlindadoTotalMN = @TotalAccesoriosMN + @PrecioBlindadoMN
            SELECT @BlindadoSubTotalMN = (@BlindadoTotalMN-@TotalAccesoriosMN)/(1+(@ArtImpuesto1/100)) + @AccesoriosMN
  
            /*IF @ArtImpuesto2 IS NOT NULL
            BEGIN
              SELECT @BlindadoImporteMN = @BlindadoSubTotalMN/(1+(@ArtImpuesto2/100))
              SELECT @BlindadoImpuestoMN = @BlindadoSubTotalMN - @BlindadoImporteMN          
              --EXEC xpTablaImpuesto @TablaISAN, '(Sin Periodo)', @BlindadoImporteMN, @BlindadoImpuestoMN OUTPUT
            END ELSE*/
              EXEC spTablaImpuestoInversa @TablaISAN, NULL, '(Sin Periodo)', @BlindadoSubTotalMN, @BlindadoImporteMN OUTPUT, @BlindadoImpuestoMN OUTPUT, @TablaLujo = @TablaISANLujo, @ImporteLujo = @ImporteISANLujo, @PorcentajeFijo = @ArtImpuesto2

            SELECT @ImporteMN = @ImporteMN - @BlindadoImpuestoMN + @ImpuestoMN
            SELECT @ImpuestoMN = @BlindadoImpuestoMN
          END

          SELECT @PrecioMN = @ImporteMN - @AccesoriosMN
          /* Ajuste x Redondeo */
          SELECT @ImpuestoMN = ROUND(@ImpuestoMN, 2)   
          /* Ajuste x Redondeo */ 

          SELECT @Impuesto2 = (CONVERT(float, @ImpuestoMN) / NULLIF(@PrecioMN, 0)) * 100
          SELECT @Precio = @PrecioMN / @TipoCambio
        END
      END ELSE
        IF @Total IS NOT NULL
          SELECT @Precio = @Total /(1+(@ArtImpuesto1/100))
    END

    IF @TipoUnidad = 'SEMINUEVO' AND @VIN IS NOT NULL
    BEGIN
      SELECT @Impuesto2 = NULL, @Precio = @Total
      IF @CfgVINAccesorioArt = 1 AND @CfgVINCostoSumaAccesorios = 1
        SELECT @Costo = SUM(PrecioDistribuidor) FROM VINAccesorio WHERE VIN = @VIN AND Estatus = 'ALTA'
      ELSE BEGIN
        SELECT @Costo = ISNULL(CostoPromedio, 0) FROM SerieLote WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND Almacen = @Almacen AND SerieLote = @VIN
--      SELECT @Costo = @Costo + ISNULL(CostoExtra, 0) FROM VINCostoExtraEmpresa WHERE VIN = @VIN AND Empresa = @Empresa
      END

      EXEC spCalcImpuestoSeminuevos @VIN, @TipoUnidad, @ID, @Costo, @Precio OUTPUT, @ArtImpuesto1 OUTPUT
    END

    UPDATE VentaD SET Precio = ISNULL(@Precio, Precio), Impuesto1 = @ArtImpuesto1, Impuesto2 = @Impuesto2 WHERE ID = @ID AND Articulo = @Articulo


    /* Ajuste x Redondeo */ 
    SELECT @Dif = @Total - (SELECT SUM(ImporteTotal) FROM VentaTCalc WHERE ID = @ID)

    IF @Total IS NOT NULL AND @Dif <> 0.0 
    BEGIN
      SELECT @ImpuestoMN = @ImpuestoMN + @Dif 
      SELECT @Impuesto2 = (CONVERT(float, @ImpuestoMN) / NULLIF(@PrecioMN, 0)) * 100.0
      UPDATE VentaD SET Impuesto2 = @Impuesto2 WHERE ID = @ID AND Articulo = @Articulo
    END
    /* Ajuste x Redondeo */

  END
END
GO

-- spVerLimiteCreditoMN 'MEX', 'DEMO'
/**************** spVerLimiteCreditoMN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerLimiteCreditoMN') and type = 'P') drop procedure dbo.spVerLimiteCreditoMN
GO             
CREATE PROCEDURE spVerLimiteCreditoMN
			@Cliente	char(10),
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Credito		varchar(50),
    @CreditoEspecial	bit,
    @LimiteCredito	money,
    @MonedaCredito	char(10)
 
  SELECT @Credito 	    = Credito,
         @CreditoEspecial = CreditoEspecial,
         @LimiteCredito   = ISNULL(CreditoLimite, 0.0), 
         @MonedaCredito   = CreditoMoneda
    FROM Cte
   WHERE Cliente = @Cliente
  IF @CreditoEspecial = 0
  BEGIN
    SELECT @LimiteCredito = NULL
    SELECT @LimiteCredito = ISNULL(LimiteCredito, 0.0),
           @MonedaCredito = MonedaCredito
      FROM CteCredito
     WHERE Empresa = @Empresa AND Credito = @Credito
  END

  SELECT "LimiteCredito" = @LimiteCredito*TipoCambio FROM Mon WHERE Moneda = @MonedaCredito
END
GO
/****** spClienteInfoCredito *****/
if exists (select * from sysobjects where id = object_id('dbo.spClienteInfoCredito') and type = 'P') 
  drop procedure dbo.spClienteInfoCredito
GO

CREATE PROCEDURE spClienteInfoCredito
	@Cliente	char(10),
	@Empresa	varchar(5) = NULL,
	@Sucursal	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT 'Límite de Crédito' = CreditoLimite, 
         'Límite de Crédito (Pedidos)' = CreditoLimitePedidos, 
         'Crédito Moneda' = CreditoMoneda, 
         'Crédito Días' = CreditoDias, 
         'Crédito Condiciones' = CreditoCondiciones
    FROM Cte
   WHERE Cliente = @Cliente
     AND CreditoEspecial = 1
  RETURN
END
GO


/**************** spVerCostoPiso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCostoPiso') and type = 'P') drop procedure dbo.spVerCostoPiso
GO             
CREATE PROCEDURE spVerCostoPiso
			@Empresa	char(5),
			@VIN		varchar(20),
			@Total		bit	 = 0,
			@VerSaldo	bit   	 = 0,
			@SaldoA		datetime = NULL,
			@SaldoTotal	money	 = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Chrysler                   bit,
    @TipoUnidad                 varchar(20),
    @CostoVIN			money,
    @Importe			money,
    @Hoy			datetime,
    @FechaMRS			datetime,
    @DiasLibres         	int,
    @DiasLibresAdicionales     	int,
    @FechaInicioCostoPiso	datetime,
    @FechaSalida		datetime,
    @FechaBaja                  datetime,
    @FechaFinal			datetime,
    @FechaPago			datetime,
    @Fecha			datetime, 
    @UltimoPagoCostoPiso	datetime,
    @IntercambioDirecto		bit, 
    @Dias			int,
    @Plazo			int,
    @Plazo1			int,
    @Plazo2			int,
    @Plazo3			int,
    @Tasa1			float,
    @Tasa2			float,
    @Tasa3			float,
    @Saldo			money,
    @CompraID                   int,
    @Moneda                     char(10),
    @CfgFechaInicioCostoPiso    varchar(20),
    @CfgCostoPisoUsados         bit,
    @CfgCostoPisoUsadosTasa     float,
    @CfgCostoPisoUsadosDiasLibres int

  CREATE TABLE #CostoPiso (
     Fecha 	datetime NULL,
     Importe    money    NULL,
     Saldo      money    NULL,
     Plazo	int	 NULL)

  SELECT @Chrysler = Chrysler,
         @CfgFechaInicioCostoPiso = FechaInicioCostoPiso, 
         @Plazo1 = CostoPisoPlazo1, @Plazo2 = CostoPisoPlazo2, @Plazo3 = CostoPisoPlazo3 ,
         @CfgCostoPisoUsados = CostoPisoUsados,
         @CfgCostoPisoUsadosTasa = CostoPisoUsadosTasa,
         @CfgCostoPisoUsadosDiasLibres = CostoPisoUsadosDiasLibres
    FROM EmpresaGral 
   WHERE Empresa = @Empresa 

  SELECT @Hoy = GETDATE()
  SELECT @FechaInicioCostoPiso = CASE WHEN @CfgFechaInicioCostoPiso = 'Fecha Factura Compra' THEN ISNULL(FechaFacturaCompra, FechaEntrada) ELSE FechaEntrada END, 
         @FechaMRS = FechaMRS, 
         @DiasLibres = ISNULL(DiasLibresIntereses, 0),
         @DiasLibresAdicionales = ISNULL(DiasLibresAdicionales, 0), 
         @FechaSalida = FechaSalida, 
         @FechaBaja = FechaBaja, 
         @FechaPago = FechaPago,
         @CostoVIN = TotalFacturaCompra,
         @UltimoPagoCostoPiso = UltimoPagoCostoPiso,
         @IntercambioDirecto = ISNULL(IntercambioDirecto, 0),
         @CompraID = CompraID,
         @TipoUnidad = UPPER(TipoUnidad)
    FROM VIN WHERE VIN = @VIN
  SELECT @Moneda = Moneda FROM Compra WHERE ID = @CompraID

  IF @TipoUnidad = 'SEMINUEVO' AND @CfgCostoPisoUsados = 1
    SELECT @DiasLibres = ISNULL(@CfgCostoPisoUsadosDiasLibres, 0)

  EXEC spExtraerFecha @Hoy OUTPUT
  SELECT @FechaInicioCostoPiso = DATEADD(day, @DiasLibres+@DiasLibresAdicionales+1, @FechaInicioCostoPiso)

  IF @Chrysler = 1 SELECT @FechaInicioCostoPiso = DATEADD(day, -1, @FechaInicioCostoPiso)
  IF @Chrysler = 1 AND @FechaBaja IS NOT NULL AND @FechaInicioCostoPiso > @FechaBaja SELECT @FechaInicioCostoPiso = @FechaBaja

  IF @IntercambioDirecto = 0 AND @FechaInicioCostoPiso IS NOT NULL
  BEGIN
    IF @DiasLibres>0 AND @DiasLibresAdicionales=0 SELECT @Plazo1 = 0

    /*SELECT @FechaFinal = ISNULL(@FechaSalida, @Hoy)
    IF @Chrysler = 1 */SELECT @FechaFinal = ISNULL(@FechaPago, @Hoy)

    SELECT @Fecha = @FechaInicioCostoPiso
    WHILE @Fecha <= @FechaFinal
    BEGIN
      SELECT @Tasa1 = NULL, @Tasa2 = NULL, @Tasa3 = NULL, @Plazo = NULL

      IF UPPER(@Moneda) = 'DOLARES'
        SELECT @Tasa1 = Plazo1TasaDolar, @Tasa2 = Plazo2TasaDolar, @Tasa3 = Plazo3TasaDolar FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha = @Fecha
      ELSE
      IF UPPER(@Moneda) = 'EUROS'
        SELECT @Tasa1 = Plazo1TasaEuro, @Tasa2 = Plazo2TasaEuro, @Tasa3 = Plazo3TasaEuro FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha = @Fecha
      ELSE
        SELECT @Tasa1 = Plazo1Tasa, @Tasa2 = Plazo2Tasa, @Tasa3 = Plazo3Tasa FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha = @Fecha

      SELECT @Dias = DATEDIFF(day, @FechaInicioCostoPiso-1, @Fecha)

      IF @TipoUnidad = 'SEMINUEVO' AND @CfgCostoPisoUsados = 1
      BEGIN
        IF @Dias >= 0  SELECT @Plazo = 1, @Importe = @CostoVIN * (@CfgCostoPisoUsadosTasa/100) 
      END ELSE
      BEGIN
        IF @Dias >= 0      AND @Dias <= @Plazo1 SELECT @Plazo = 1, @Importe = @CostoVIN * (@Tasa1/100) ELSE
        IF @Dias > @Plazo1 AND @Dias <= @Plazo2 SELECT @Plazo = 2, @Importe = @CostoVIN * (@Tasa2/100) ELSE
        IF @Dias > @Plazo2 AND @Dias <= @Plazo3 SELECT @Plazo = 3, @Importe = @CostoVIN * (@Tasa3/100)
      END

      IF @FechaMRS IS NOT NULL AND @Fecha<=@FechaMRS SELECT @Importe = NULL
      IF NULLIF(@Importe, 0) IS NOT NULL
      BEGIN
        IF @UltimoPagoCostoPiso IS NULL OR @Fecha>@UltimoPagoCostoPiso SELECT @Saldo = @Importe ELSE SELECT @Saldo = NULL
        INSERT #CostoPiso (Fecha, Importe, Saldo, Plazo) VALUES (@Fecha, @Importe, @Saldo, @Plazo)
      END
      SELECT @Fecha = DATEADD(day, 1, @Fecha)
    END
  END
  IF @VerSaldo = 1
    SELECT @SaldoTotal = SUM(Saldo) FROM #CostoPiso WHERE Fecha <= @SaldoA
  ELSE BEGIN
    IF @Total = 1 
      SELECT "CostoPiso" = SUM(Importe) FROM #CostoPiso
    ELSE
      SELECT *, "Moneda" = @Moneda FROM #CostoPiso
  END
END
GO

-- spVerCostoPiso 'FOTAO', 'IKON008'


-- spVerMovIEPS 'VTAS', 1, 15, 25, 'COUTA LITRO'
/**************** spVerMovIEPS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMovIEPS') and sysstat & 0xf = 4) drop procedure dbo.spVerMovIEPS
GO             
CREATE PROCEDURE spVerMovIEPS
			@Modulo		char(5),
			@ID		int,
			@Impuesto1	float,
			@Impuesto2	float,
			@LoteFijo	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT SUM(Importe2) FROM MovImpuesto WHERE Modulo = @Modulo AND ModuloID = @ID AND Impuesto1 = @Impuesto1 AND Impuesto2 = @Impuesto2 AND LoteFijo = @LoteFijo
END
GO


/**************** spVerACCuentaArtDisposicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerACCuentaArtDisposicion') and sysstat & 0xf = 4) drop procedure dbo.spVerACCuentaArtDisposicion
GO             
CREATE PROCEDURE spVerACCuentaArtDisposicion
			@Empresa	char(5),
			@Modulo		char(5),
			@Amortizacion	char(20),
			@AmortizacionID	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuenta	varchar(20)

  IF @Modulo = 'CXC'
    SELECT @Cuenta = MIN(a.Cuenta)
      FROM Cxc c
      JOIN Cxc r ON r.ID = c.RamaID
      JOIN Venta v ON v.Empresa = @Empresa AND v.Mov = r.Origen AND v.MovID = r.OrigenID AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
      JOIN VentaD d ON d.ID = v.ID
      JOIN Art a ON a.Articulo = d.Articulo
     WHERE c.Empresa = @Empresa AND c.Mov = @Amortizacion AND c.MovID = @AmortizacionID AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO')
  IF @Modulo = 'CXP'
    SELECT @Cuenta = MIN(a.Cuenta)
      FROM Cxp c
      JOIN Cxp r ON r.ID = c.RamaID
      JOIN Compra v ON v.Empresa = @Empresa AND v.Mov = r.Origen AND v.MovID = r.OrigenID AND v.Estatus IN ('PENDIENTE', 'CONCLUIDO')
      JOIN CompraD d ON d.ID = v.ID
      JOIN Art a ON a.Articulo = d.Articulo
     WHERE c.Empresa = @Empresa AND c.Mov = @Amortizacion AND c.MovID = @AmortizacionID AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO')

  SELECT "Cuenta" = @Cuenta
END
GO


-- spExplorarVINAccesorios 'Fabricante 01  2004  Línea 2', 'Opciones'
/**************** spExplorarVINAccesorios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExplorarVINAccesorios') and sysstat & 0xf = 4) drop procedure dbo.spExplorarVINAccesorios
GO             
CREATE PROCEDURE spExplorarVINAccesorios
			@Estacion	int,
			@Filtro		varchar(255),
			@Tipo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TAB	char(2),
    @Fabricante	varchar(50),
    @Modelo	varchar(50),
    @Linea	varchar(50),
    @Version	varchar(50),
    @Articulo	varchar(50)

  SELECT @TAB = CHAR(9)
  EXEC spExtraerDato @Filtro OUTPUT, @Fabricante OUTPUT, @TAB	SELECT @Fabricante = NULLIF(@Fabricante, '')
  EXEC spExtraerDato @Filtro OUTPUT, @Modelo     OUTPUT, @TAB	SELECT @Modelo     = NULLIF(@Modelo, '')
  EXEC spExtraerDato @Filtro OUTPUT, @Linea      OUTPUT, @TAB	SELECT @Linea      = NULLIF(@Linea, '')
  EXEC spExtraerDato @Filtro OUTPUT, @Version    OUTPUT, @TAB	SELECT @Version    = NULLIF(@Version, '')
  EXEC spExtraerDato @Filtro OUTPUT, @Articulo   OUTPUT, @TAB	SELECT @Articulo   = NULLIF(@Articulo, '')

  DELETE ExplorarVINFiltro WHERE Estacion = @Estacion
  INSERT ExplorarVINFiltro 
         (Estacion,  Fabricante,  Modelo,  Linea,  Version,  Articulo)
  VALUES (@Estacion, @Fabricante, @Modelo, @Linea, @Version, @Articulo)

  SELECT va.Accesorio, va.Descripcion
    FROM Art a
    JOIN VIN v ON v.Articulo = a.Articulo
    JOIN VINAccesorio va ON va.VIN = v.VIN AND va.Tipo = @Tipo
   WHERE a.Fabricante = ISNULL(@Fabricante, a.Fabricante) 
     AND a.Modelo = ISNULL(@Modelo, a.Modelo)
     AND a.Linea = ISNULL(@Linea, a.Linea)
     AND a.Version = ISNULL(@Version, a.Version)
     AND a.Articulo = ISNULL(@Articulo, a.Articulo)
   GROUP BY va.Accesorio, va.Descripcion
END
GO

/**************** spUltCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spUltCB') and sysstat & 0xf = 4) drop procedure dbo.spUltCB
GO             
CREATE PROCEDURE spUltCB
			@TipoCuenta	varchar(20),
			@Cuenta		varchar(20),
			@Codigo		varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha	datetime
  
  SELECT @Fecha  = MAX(Fecha) FROM CB WHERE Cuenta = @Cuenta AND TipoCuenta = @TipoCuenta
  SELECT @Codigo = MAX(Codigo) FROM CB WHERE Cuenta = @Cuenta AND TipoCuenta = @TipoCuenta AND Fecha = @Fecha
  RETURN
END
GO

/**************** spVerUltCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerUltCB') and sysstat & 0xf = 4) drop procedure dbo.spVerUltCB
GO             
CREATE PROCEDURE spVerUltCB
			@Codigo	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCuenta	varchar(50),
    @Cuenta	char(50),
    @Fecha	datetime
  
  SELECT @Cuenta = Cuenta, @TipoCuenta = TipoCuenta FROM CB WHERE Codigo = @Codigo 
  SELECT @Fecha = MAX(Fecha) FROM CB WHERE Cuenta = @Cuenta AND TipoCuenta = @TipoCuenta
  SELECT "UltimoCodigo" =MAX(Codigo) FROM CB WHERE Cuenta = @Cuenta AND TipoCuenta = @TipoCuenta AND Fecha = @Fecha
  RETURN
END
GO


/****** spProvCuota *****/
if exists (select * from sysobjects where id = object_id('dbo.spProvCuota') and type = 'P') drop procedure dbo.spProvCuota
GO
CREATE PROCEDURE spProvCuota
			@Proveedor	char(10),
			@FechaD		Datetime,
			@FechaA		Datetime,
			@Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #ProvMeta
 (
  Familia		varchar(50)	COLLATE Database_Default NULL,
  Proveedor		char(10)	COLLATE Database_Default NULL,
  Unidad		varchar(50)	COLLATE Database_Default NULL,
  Moneda		varchar(10)	COLLATE Database_Default NULL,
  MetaCant		float(8)	NULL,
  MetaImp		money		NULL,
  BaseDescuento		varchar(20)	COLLATE Database_Default NULL,
  FechaD		Datetime	NULL,
  FechaA		Datetime	NULL,
  Importe		money		NULL,
  Cantidad		float(8)	NULL,
  Porcent		float(8)	NULL,
  PorcAdic		float(8)	NULL
)

  INSERT #ProvMeta (Familia, Proveedor, MetaCant, MetaImp, BaseDescuento, a.FechaD, a.FechaA, Unidad, Moneda)
  SELECT a.Familia, a.Proveedor, a.Cantidad, a.Importe, BaseDescuento, a.FechaD, a.FechaA, a.Unidad, a.Moneda
    FROM ProvCuota a
   WHERE a.FechaD BETWEEN @FechaD AND @FechaA
     AND a.FechaA BETWEEN @FechaD AND @FechaA
     AND a.Proveedor = @Proveedor

  SELECT Importe = SUM((b.Cantidad * b.Costo) - ISNULL(b.DescuentoImporte, 0)), Cantidad = SUM(b.Cantidad), a.Proveedor, c.Familia, a.FechaEmision
    INTO #ProvImporte
    FROM Compra a, CompraD b, Art c, MovTipo m
   WHERE a.ID = b.ID
     AND b.Articulo = c.Articulo
     AND a.Mov = m.Mov
     AND m.Modulo = 'COMS'
     AND m.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
     AND a.Estatus = 'CONCLUIDO'
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND a.Proveedor = @Proveedor
     AND a.Empresa = @Empresa
   GROUP BY a.Proveedor, c.Familia, a.FechaEmision

  UPDATE #ProvMeta SET Importe = b.Importe, Cantidad = b.Cantidad, Porcent = CASE WHEN a.BaseDescuento = 'Importe' THEN (b.Importe/a.MetaImp) * 100 ELSE (b.Cantidad/a.MetaCant) * 100 END
    FROM #ProvMeta a, #ProvImporte b
   WHERE a.Proveedor = b.Proveedor
     AND a.Familia = b.Familia
     AND b.FechaEmision <= a.FechaA
     AND b.FechaEmision >= a.FechaD

  SELECT a.Familia, a.Proveedor, a.MetaCant, a.MetaImp, a.BaseDescuento, a.FechaD, a.FechaA, a.Unidad, a.Moneda, a.Importe, a.Cantidad, a.Porcent, 
         PorcAdic = (SELECT MAX(b.Descuento) FROM ProvCuotaDesc b WHERE b.Familia = a.Familia AND b.Proveedor = a.Proveedor AND b.FechaD = a.FechaD AND b.FechaA = a.FechaA AND b.Porcentaje <= a.Porcent)
    FROM #ProvMeta a
END
GO

/****** spArtCuota *****/
if exists (select * from sysobjects where id = object_id('dbo.spArtCuota') and type = 'P') drop procedure dbo.spArtCuota
GO
CREATE PROCEDURE spArtCuota
			@Articulo	char(20),
			@FechaD		Datetime,
			@FechaA		Datetime,
			@Empresa	char(5)
		    
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #ArtMeta
 (
  Articulo		char(20)	COLLATE Database_Default NULL,
  Proveedor		char(10)	COLLATE Database_Default NULL,
  Unidad		varchar(50)	COLLATE Database_Default NULL,
  Moneda		varchar(10)	COLLATE Database_Default NULL,
  MetaCant		float(8)	NULL,
  MetaImp		money		NULL,
  BaseDescuento		varchar(20)	COLLATE Database_Default NULL,
  FechaD		Datetime	NULL,
  FechaA		Datetime	NULL,
  Importe		money		NULL,
  Cantidad		float(8)	NULL,
  Porcent		float(8)	NULL,
  PorcAdic		float(8)	NULL
)

  INSERT #ArtMeta (Articulo, Proveedor, MetaCant, MetaImp, BaseDescuento, a.FechaD, a.FechaA, Unidad, Moneda)
  SELECT a.Articulo, Proveedor, a.Cantidad, a.Importe, BaseDescuento, a.FechaD, a.FechaA, a.Unidad, a.Moneda
    FROM ArtCuota a
   WHERE a.FechaD BETWEEN @FechaD AND @FechaA
     AND a.FechaA BETWEEN @FechaD AND @FechaA
     AND a.Articulo = @Articulo

  SELECT Importe = SUM((b.Cantidad * b.Costo) - ISNULL(b.DescuentoImporte, 0)), Cantidad = SUM(b.Cantidad), b.Articulo, a.Proveedor, a.FechaEmision
    INTO #ArtImporte
    FROM Compra a, CompraD b, MovTipo m
   WHERE a.ID = b.ID
     AND a.Mov = m.Mov
     AND m.Modulo = 'COMS'
     AND m.Clave IN ('COMS.F', 'COMS.FL', 'COMS.EG', 'COMS.EI')
     AND a.Estatus = 'CONCLUIDO'
     AND a.FechaEmision BETWEEN @FechaD AND @FechaA
     AND b.Articulo = @Articulo
     AND a.Empresa = @Empresa
   GROUP BY b.Articulo, a.Proveedor, a.FechaEmision

  UPDATE #ArtMeta SET Importe = b.Importe, Cantidad = b.Cantidad, Porcent = CASE WHEN a.BaseDescuento = 'Importe' THEN (b.Importe/a.MetaImp) * 100 ELSE (b.Cantidad/a.MetaCant) * 100 END
    FROM #ArtMeta a, #ArtImporte b
   WHERE a.Articulo = b.Articulo
     AND a.Proveedor = b.Proveedor
     AND b.FechaEmision <= a.FechaA
     AND b.FechaEmision >= a.FechaD

  SELECT a.Articulo, a.Proveedor, a.MetaCant, a.MetaImp, a.BaseDescuento, a.FechaD, a.FechaA, a.Unidad, a.Moneda, a.Importe, a.Cantidad, a.Porcent, 
         PorcAdic = (SELECT MAX(b.Descuento) FROM ArtCuotaDesc b WHERE  b.Articulo = a.Articulo AND b.Proveedor = a.Proveedor AND b.FechaD = a.FechaD AND b.FechaA = a.FechaA AND b.Porcentaje <= a.Porcent)
    FROM #ArtMeta a
END
GO



PRINT "******************* SP VISTAS ******************"



