SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO


/********************************** spArtPrecio ************************************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spArtPrecio') AND type = 'P') DROP PROCEDURE dbo.spArtPrecio
GO             
CREATE PROCEDURE spArtPrecio
          @Articulo          varchar(20),
          @Cantidad          float,
          @UnidadVenta	    varchar(50),
          @Precio            float       OUTPUT,
          @Descuento         float       OUTPUT,

          @VentaID           int         = NULL,
          @SubCuenta         varchar(50) = NULL,
          @FechaEmision      Datetime    = NULL,
          @Agente            varchar(10) = NULL,
          @Moneda            varchar(10) = NULL, 
          @TipoCambio        float       = NULL,
          @Condicion         varchar(50) = NULL,
          @Almacen           varchar(10) = NULL,
          @Proyecto          varchar(50) = NULL,
          @FormaEnvio        varchar(50) = NULL,
          @Mov               varchar(20) = NULL,
          @ServicioTipo      varchar(50) = NULL,
          @ContratoTipo      varchar(50) = NULL,
          @Empresa           varchar(50) = NULL,
          @Region            varchar(50) = NULL,
          @Sucursal          int         = NULL,
          @ListaPreciosEsp   varchar(20) = NULL,
          @Cliente           varchar(10) = NULL,                
          @PrecioConDescuento bit       = 0,
          @GetListaPreciosCliente	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @EnviarA	int,
  	  @Politica		varchar(MAX),
	  @DescuentoMonto		float,
	  @DescuentoMontoPorcentaje	float	,
          @OFER                 	bit 
	  
	  
    SELECT @OFER = ISNULL(OFER,0)
      FROM EmpresaGral
     WHERE Empresa = @Empresa
  	  
	  
  
  IF @GetListaPreciosCliente = 1
  BEGIN
    SELECT @Cliente = Cliente,
	   @EnviarA = EnviarA
      FROM Venta 
     WHERE ID = @VentaID
     
    SELECT @ListaPreciosEsp = ISNULL(ISNULL(cea.ListaPreciosEsp, c.ListaPreciosEsp), '(Precio Lista)')
      FROM Cte c
      INNER JOIN CteEnviarA cea ON c.Cliente = cea.Cliente
				AND cea.ID = @EnviarA 
  END
  IF @OFER = 0
  BEGIN    
    IF @VentaID IS NOT NULL
      EXEC spPoliticaPrecios @VentaID, @Articulo, @Subcuenta, @Cantidad, @UnidadVenta, @Precio OUTPUT, @Descuento OUTPUT, @DescuentoMonto OUTPUT
    ELSE    
      EXEC spPoliticaPreciosCalc @FechaEmision, @Agente, @Moneda, @TipoCambio, @Condicion, @Almacen, @Proyecto, @FormaEnvio, @Mov, @ServicioTipo,@ContratoTipo, @Empresa, @Region, @Sucursal, @ListaPreciosEsp, @Cliente, @Articulo, @Subcuenta, @Cantidad, @UnidadVenta, @Precio OUTPUT, @Descuento OUTPUT, @Politica OUTPUT, @DescuentoMonto OUTPUT
  END  

  IF NULLIF(@Precio,0) IS NULL
    EXEC spPCGet @Sucursal, @Empresa,@Articulo, @SubCuenta, @UnidadVenta, @Moneda, @TipoCambio, @ListaPreciosEsp, @Precio OUTPUT--, @VerResultado, @PrecioOriginal, @Proveedor, @SucursalEsp      

  --Aqui calcula el descuento en monto para que se convierta en porcentaje
  IF ISNULL(@DescuentoMonto,0) > 0 AND ISNULL(@Precio,0) > 0
  BEGIN
    SELECT @DescuentoMontoPorcentaje = (@DescuentoMonto / (@Precio * @Cantidad)) * 100
    SELECT @Descuento = ISNULL(@Descuento,0) + ISNULL(@DescuentoMontoPorcentaje,0)
  END
  
  IF ISNULL(@PrecioConDescuento, 0) = 1
  BEGIN
    SELECT @Precio = @Precio - (@Precio * (ISNULL(@Descuento,0)/100))
    SELECT @Descuento = NULL
  END
END
GO
/********************************** spPoliticaPrecios ************************************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spPoliticaPrecios') AND type = 'P') DROP PROCEDURE dbo.spPoliticaPrecios
GO             
CREATE PROCEDURE spPoliticaPrecios
		     @ID		int,
		     @Articulo		varchar(20),
		     @Subcuenta		varchar(50),
		     @Cantidad		float,
		     @UnidadVenta	varchar(50),
		     @Precio		float		OUTPUT,
		     @Descuento		float		OUTPUT,
		     @DescuentoMonto	float		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @FechaEmision		DateTime,
	  @Cliente		varchar(10),
	  @Agente		varchar(10),
	  @Moneda		varchar(10),
	  @TipoCambio		float,
	  @Condicion		varchar(50),
	  @Almacen		varchar(10),
	  @Proyecto		varchar(50),
	  @FormaEnvio		varchar(50),
	  @Mov			varchar(20),
	  @ServicioTipo		varchar(50),
	  @ContratoTipo		varchar(50),
	  @Empresa		varchar(50),
	  @Region		varchar(50),
	  @Sucursal		int,
	  @ListaPreciosEsp	varchar(20),
	  @Politica		varchar(MAX)

  SELECT @FechaEmision = v.FechaEmision,
 	 @Cliente	   = v.Cliente,
	 @Agente	   = v.Agente,
	 @Moneda	   = v.Moneda,
	 @TipoCambio	   = v.TipoCambio,
	 @Condicion	   = v.Condicion,
	 @Almacen	   = v.Almacen,
	 @Proyecto	   = v.Proyecto,
	 @FormaEnvio	   = v.FormaEnvio,
	 @Mov		   = v.Mov,
	 @ServicioTipo     = v.ServicioTipo,
	 @ContratoTipo     = v.ContratoTipo,
	 @Empresa	   = v.Empresa,
	 @Region	   = s.Region,
	 @Sucursal	   = v.Sucursal,
	 @ListaPreciosEsp  = v.ListaPreciosEsp
    FROM Venta v
   INNER JOIN Sucursal s ON v.Sucursal = s.Sucursal
   WHERE v.ID = @ID
    
    EXEC spPoliticaPreciosCalc @FechaEmision, @Agente, @Moneda, @TipoCambio, @Condicion, @Almacen, @Proyecto, @FormaEnvio, @Mov, @ServicioTipo, @ContratoTipo, @Empresa,
			       @Region, @Sucursal, @ListaPreciosEsp, @Cliente, @Articulo, @Subcuenta, @Cantidad, @UnidadVenta, @Precio OUTPUT, @Descuento OUTPUT, @Politica OUTPUT, @DescuentoMonto OUTPUT
END
GO
/********************************** spPoliticaPreciosCalc ************************************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spPoliticaPreciosCalc') AND type = 'P') DROP PROCEDURE dbo.spPoliticaPreciosCalc
GO             
CREATE PROCEDURE spPoliticaPreciosCalc
		     @FechaEmision	DateTime,
		     @Agente		varchar(10),
	             @Moneda		varchar(10), 
	             @TipoCambio	float,
	             @Condicion		varchar(50),
		     @Almacen		varchar(10),
		     @Proyecto		varchar(50),
		     @FormaEnvio	varchar(50),
		     @Mov		varchar(20),
		     @ServicioTipo	varchar(50),
		     @ContratoTipo	varchar(50),
		     @Empresa		varchar(50),
		     @Region		varchar(50),
		     @Sucursal		int,
		     @ListaPreciosEsp	varchar(20),
	             @Cliente		varchar(10),
		     
		     @Articulo		varchar(20),
		     @Subcuenta		varchar(50),
		     @Cantidad		float,
		     @UnidadVenta	varchar(50),
		     @Precio		float		OUTPUT,
		     @Descuento		float		OUTPUT,
		     @Politica		varchar(MAX)	= NULL	OUTPUT,
		     @DescuentoMonto	float		= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @ArtCat		varchar(50),
	  @ArtGrupo		varchar(50),
	  @ArtFam		varchar(50),
	  @ArtAbc		varchar(1),
	  @Fabricante		varchar(50),
	  @ArtLinea		varchar(50),
	  @ArtRama		varchar(20),
  	
	  @CteGrupo		varchar(50),
	  @CteCat		varchar(50),
	  @CteFam		varchar(50),
	  @CteZona		varchar(30),
	  
	  @Tipo			varchar(50),
	  @Nivel		varchar(50),
	  @NivelPolitica	varchar(50),
	  @Costo		money,
	  @TipoCosteo		varchar(20),
	  @PrecioLista		money, 
	  @Precio2		money,
	  @Precio3		money,
	  @Precio4		money,
	  @Precio5		money,
	  @Precio6		money,
	  @Precio7		money,
	  @Precio8		money,
	  @Precio9		money,
	  @Precio10		money,
	  
  	  @DescuentoAcum				float,
      @Ponderado					float,
      @CalcDescuento				float,
      
      @PrecioAcum					float,
      @PrecioTemp					float,
  	  @Descripcion					varchar(50),
  	  @ConVigencia					bit,
  	  @FechaD						datetime,
  	  @FechaA						datetime,
  	  @PromocionExclusiva			bit,    --PROMOCIONEXCLUSIVA      
      @CalcDescuentoExclusivo		float,  --PROMOCIONEXCLUSIVA      
      @DescuentoExclusivo			float,  --PROMOCIONEXCLUSIVA      
      @PonderadoExclusivo			float,  --PROMOCIONEXCLUSIVA      
  	  @PromocionPromocion			bit,    --PROMOCIONPROMOCION      
      @CalcDescuentoPromocion		float,  --PROMOCIONPROMOCION      
      @DescuentoPromocion			float,  --PROMOCIONPROMOCION      
      @PonderadoPromocion			float,  --PROMOCIONPROMOCION      
  	  @PromocionParticular			bit,    --PROMOCIONPARTICULAR      
      @CalcDescuentoParticular		float,  --PROMOCIONPARTICULAR      
      @DescuentoParticular			float,  --PROMOCIONPARTICULAR      
      @PonderadoParticular			float,   --PROMOCIONPARTICULAR      
      @PromocionExclusivaAplicada	bit,    --APLICARSOLOUNAPROMOCION
      @PromocionPromocionAplicada	bit,    --APLICARSOLOUNAPROMOCION
      @PromocionParticularAplicada	bit     --APLICARSOLOUNAPROMOCION
      

  SET @PromocionExclusiva  = 0  --PROMOCIONEXCLUSIVA      
  SET @PromocionPromocion  = 0  --PROMOCIONPROMOCION
  SET @PromocionParticular = 0  --PROMOCIONPARTICULAR

  SET @PromocionExclusivaAplicada = 0   --APLICARSOLOUNAPROMOCION
  SET @PromocionPromocionAplicada = 0   --APLICARSOLOUNAPROMOCION
  SET @PromocionParticularAplicada = 0  --APLICARSOLOUNAPROMOCION
       
  --Obtiene la información del articulo	    	  
  SELECT @ArtCat  = a.Categoria,
	 @ArtGrupo = a.Grupo,
	 @ArtFam = a.Familia,
	 @ArtAbc = a.ABC,
	 @Fabricante = a.Fabricante,
	 @ArtLinea = a.Linea,
	 @ArtRama = a.Rama,
	 @PrecioLista = a.PrecioLista,
	 @Precio2 = a.Precio2,
	 @Precio3 = a.Precio3,
	 @Precio4 = a.Precio4,
	 @Precio5 = a.Precio5,
	 @Precio6 = a.Precio6,
	 @Precio7 = a.Precio7,
	 @Precio8 = a.Precio8,
	 @Precio9 = a.Precio9,
	 @Precio10 = a.Precio10
    FROM Art a 
   WHERE a.Articulo = @Articulo
   
   --Obtiene los agrupadores del cliente
   SELECT @CteGrupo = c.Grupo,
	  @CteCat   = c.Categoria,
	  @CteFam   = c.Familia,
	  @CteZona  = c.Zona
     FROM Cte c
    WHERE c.Cliente = @Cliente
    
   --Obtiene el tipo de costeo
   SELECT @TipoCosteo = TipoCosteo 
     FROM EmpresaCfg ec 
    WHERE ec.Empresa = @Empresa
   
  --Obtiene el precio del articulo utilizando el PCGET
  EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @UnidadVenta, @Moneda, @TipoCambio, @ListaPreciosEsp, @PrecioTemp OUTPUT
  
   -- Calcular Descuento en Monto
    SELECT @DescuentoMonto = SUM(pd.Monto)
      FROM Precio p
     INNER JOIN PrecioD pd ON p.ID = pd.ID AND @Cantidad >= pd.Cantidad                                                    
     WHERE ((ISNULL(p.ConVigencia,0) = 0) OR (@FechaEmision BETWEEN p.FechaD AND p.FechaA)) --Verifica la vigencia
       --Condiciones de Propiedades de Articulo 
       AND ((ISNULL(p.NivelArticulo,0) = 0) OR (p.Articulo = @Articulo)) --Verifica que la politica sea para el articulo
       AND ((ISNULL(p.NivelSubCuenta,0) = 0) OR (p.SubCuenta = @Subcuenta)) --Verifica que la politica sea para la opcion determinada
       AND ((ISNULL(p.NivelUnidadVenta,0) = 0) OR (p.UnidadVenta = @UnidadVenta)) --Verifica que la politica sea para la unidad de venta especifica 
       AND ((ISNULL(p.NivelArtCat,0) = 0) OR (p.ArtCat = @ArtCat)) --Verifica que la politica sea para la categoria de articulo especifica
       AND ((ISNULL(p.NivelArtGrupo,0) = 0) OR (p.ArtGrupo = @ArtGrupo)) --Verifica que la politica sea para el grupo de articulo especifico
       AND ((ISNULL(p.NivelArtFam,0) = 0) OR (p.ArtFam = @ArtFam)) --Verifica que la politica sea para la familia de articulo especifica
       AND ((ISNULL(p.NivelArtABC,0) = 0) OR (p.ArtAbc = @ArtAbc)) --Verifica que la politica sea para el nivel de ABC de articulo especifico
       AND ((ISNULL(p.NivelFabricante,0) = 0) OR (p.Fabricante = @Fabricante)) --Verifica que la politica sea para el fabricante especifico
       AND ((ISNULL(p.NivelArtLinea,0) = 0) OR (p.ArtLinea = @ArtLinea)) --Verifica que la politica sea para la linea de articulo especifica 
       AND ((ISNULL(p.NivelArtRama,0) = 0) OR (p.ArtRama = @ArtRama)) --Verifica que la politica sea para la rama especifica
       --Condiciones de Propiedades de Clientes
       AND ((ISNULL(p.NivelCliente,0) = 0) OR (p.Cliente = @Cliente)) --Verifica el cliente   
       AND ((ISNULL(p.NivelCteGrupo,0) = 0) OR (p.CteGrupo = @CteGrupo))  --Verifica el grupo del cliente   
       AND ((ISNULL(p.NivelCteCat,0) = 0) OR (p.CteCat = @CteCat)) --Verifica la categoria del cliente   
       AND ((ISNULL(p.NivelCteFam,0) = 0) OR (p.CteFam = @CteFam)) --Verifica la familia del cliente   
       AND ((ISNULL(p.NivelCteZona,0) = 0) OR (p.CteZona = @CteZona)) --Verifica la zona del cliente   
        --Condiciones de Propiedades de la Factura
       AND ((ISNULL(p.NivelAgente,0) = 0) OR (p.Agente = @Agente)) --Verifica el agente   
       AND ((ISNULL(p.NivelMoneda,0) = 0) OR (p.Moneda = @Moneda)) --Verifica la moneda
       AND ((ISNULL(p.NivelCondicion,0) = 0) OR (p.Condicion = @Condicion)) --Verifica la condicion de pago
       AND ((ISNULL(p.NivelAlmacen,0) = 0) OR (p.Almacen = @Almacen)) --Verifica el almacen
       AND ((ISNULL(p.NivelProyecto,0) = 0) OR (p.Proyecto = @Proyecto)) --Verifica el proyecto
       AND ((ISNULL(p.NivelFormaEnvio,0) = 0) OR (p.FormaEnvio = @FormaEnvio)) --Verifica la forma de envio
       AND ((ISNULL(p.NivelMov,0) = 0) OR (p.Mov = @Mov)) --Verifica el movimiento
       AND ((ISNULL(p.NivelServicioTipo,0) = 0) OR (p.ServicioTipo = @ServicioTipo)) --Verifica el servicio
       AND ((ISNULL(p.NivelContratoTipo,0) = 0) OR (p.ContratoTipo = @ContratoTipo)) --Verifica el contrato
       AND ((ISNULL(p.NivelEmpresa,0) = 0) OR (p.Empresa = @Empresa)) --Verifica la empresa
       AND ((ISNULL(p.NivelRegion,0) = 0) OR (p.Region = @Region)) --Verifica el renglon
       AND ((ISNULL(p.NivelSucursal,0) = 0) OR (p.Sucursal = @Sucursal)) --Verifica la sucursal          
       AND ((ISNULL(p.ListaPrecios,'Todas') = 'Todas') OR (p.ListaPrecios = @ListaPreciosEsp)) --Verifica las listas de precios
       AND p.Tipo LIKE '$ Descuento%' --Valida que las politicas se expresen en monto
       AND p.Estatus = 'ACTIVA' --Valida que la politica este activa
       AND pd.Cantidad = (SELECT MAX(Cantidad) 
                            FROM PrecioD pd2 
                           WHERE p.ID = pd2.ID
                             AND @Cantidad >= pd2.Cantidad) --Solo obtiene las partidas de la politica donde la cantidad sea menor o igual a la cantidad vendida

   -- Calcular Descuento en Porcentaje
   DECLARE crDescto CURSOR LOCAL FOR 
   
    SELECT pd.Monto,
	   p.Nivel,
	   p.Descripcion,
	   p.FechaD,
	   p.FechaA,
	   p.ConVigencia
      FROM Precio p
     INNER JOIN PrecioD pd ON p.ID = pd.ID
                          AND @Cantidad >= pd.Cantidad                          
     WHERE ((ISNULL(p.ConVigencia,0) = 0) OR (@FechaEmision BETWEEN p.FechaD AND p.FechaA))
       --Condiciones de Propiedades de Articulo 
       AND ((ISNULL(p.NivelArticulo,0) = 0) OR (p.Articulo = @Articulo)) 
       AND ((ISNULL(p.NivelSubCuenta,0) = 0) OR (p.SubCuenta = @Subcuenta)) 
       AND ((ISNULL(p.NivelUnidadVenta,0) = 0) OR (p.UnidadVenta = @UnidadVenta)) 
       AND ((ISNULL(p.NivelArtCat,0) = 0) OR (p.ArtCat = @ArtCat))
       AND ((ISNULL(p.NivelArtGrupo,0) = 0) OR (p.ArtGrupo = @ArtGrupo)) 
       AND ((ISNULL(p.NivelArtFam,0) = 0) OR (p.ArtFam = @ArtFam))
       AND ((ISNULL(p.NivelArtABC,0) = 0) OR (p.ArtAbc = @ArtAbc))  
       AND ((ISNULL(p.NivelFabricante,0) = 0) OR (p.Fabricante = @Fabricante))
       AND ((ISNULL(p.NivelArtLinea,0) = 0) OR (p.ArtLinea = @ArtLinea)) 
       AND ((ISNULL(p.NivelArtRama,0) = 0) OR (p.ArtRama = @ArtRama))
       --Condiciones de Propiedades de Clientes
       AND ((ISNULL(p.NivelCliente,0) = 0) OR (p.Cliente = @Cliente))
       AND ((ISNULL(p.NivelCteGrupo,0) = 0) OR (p.CteGrupo = @CteGrupo))
       AND ((ISNULL(p.NivelCteCat,0) = 0) OR (p.CteCat = @CteCat))
       AND ((ISNULL(p.NivelCteFam,0) = 0) OR (p.CteFam = @CteFam))
       AND ((ISNULL(p.NivelCteZona,0) = 0) OR (p.CteZona = @CteZona))
        --Condiciones de Propiedades de la Factura
       AND ((ISNULL(p.NivelAgente,0) = 0) OR (p.Agente = @Agente))
       AND ((ISNULL(p.NivelMoneda,0) = 0) OR (p.Moneda = @Moneda))
       AND ((ISNULL(p.NivelCondicion,0) = 0) OR (p.Condicion = @Condicion))
       AND ((ISNULL(p.NivelAlmacen,0) = 0) OR (p.Almacen = @Almacen))
       AND ((ISNULL(p.NivelProyecto,0) = 0) OR (p.Proyecto = @Proyecto))
       AND ((ISNULL(p.NivelFormaEnvio,0) = 0) OR (p.FormaEnvio = @FormaEnvio))
       AND ((ISNULL(p.NivelMov,0) = 0) OR (p.Mov = @Mov))
       AND ((ISNULL(p.NivelServicioTipo,0) = 0) OR (p.ServicioTipo = @ServicioTipo))
       AND ((ISNULL(p.NivelContratoTipo,0) = 0) OR (p.ContratoTipo = @ContratoTipo))
       AND ((ISNULL(p.NivelEmpresa,0) = 0) OR (p.Empresa = @Empresa)) 
       AND ((ISNULL(p.NivelRegion,0) = 0) OR (p.Region = @Region))
       AND ((ISNULL(p.NivelSucursal,0) = 0) OR (p.Sucursal = @Sucursal))          
       AND ((ISNULL(p.ListaPrecios,'Todas') = 'Todas') OR (p.ListaPrecios = @ListaPreciosEsp))
       AND p.Tipo = '% Descuento'
       AND p.Estatus = 'ACTIVA'
       AND pd.Cantidad = (SELECT MAX(Cantidad) 
                            FROM PrecioD pd2 
                           WHERE p.ID = pd2.ID
                             AND @Cantidad >= pd2.Cantidad)
  OPEN crDescto
  FETCH NEXT FROM CrDescto INTO @DescuentoAcum, @Nivel, @Descripcion, @FechaD, @FechaA, @ConVigencia	      
  
    
    --Si es promocion, particulo o Exclusiva regresa el primer descuento pero segun yo debería de estar ordenado de alguna forma
    --SET @PromocionExclusiva = 0 --PROMOCIONEXCLUSIVA
    IF @Nivel IN ('Exclusiva') --PROMOCION Se quito la tipo promoción de aqui.
    BEGIN
      SET @PromocionExclusivaAplicada = 1
      SET @PromocionExclusiva = 1 --PROMOCIONEXCLUSIVA
    END ELSE
    IF @Nivel IN ('Promocion') --PROMOCIONPROMOXION
    BEGIN
      SET @PromocionPromocionAplicada = 1
      SET @PromocionPromocion = 1 --PROMOCIONPROMOCION
    END ELSE
    IF @Nivel IN ('Particular') --PROMOCIONPARTICULAR
    BEGIN
      SET @PromocionParticularAplicada = 1
      SET @PromocionParticular = 1 --PROMOCIONPARTICULAR
    END  
     

  
    --Calcula el descuento y el complemento
    SELECT @Ponderado = 100
    SELECT @CalcDescuento = (@DescuentoAcum /100) * @Ponderado
    SELECT @Descuento = @CalcDescuento
    SELECT @Ponderado = @Ponderado - @CalcDescuento
    --SELECT @DescuentoAcum, @CalcDescuento, @Descuento

    --Calcula el descuento exclusivo y el complemento
    SELECT @PonderadoExclusivo = 100 --PROMOCIONEXCLUSIVA
    SELECT @CalcDescuentoExclusivo = (@DescuentoAcum /100) * @PonderadoExclusivo --PROMOCIONEXCLUSIVA
    SELECT @DescuentoExclusivo = @CalcDescuentoExclusivo --PROMOCIONEXCLUSIVA
    SELECT @PonderadoExclusivo = @PonderadoExclusivo - @CalcDescuentoExclusivo --PROMOCIONEXCLUSIVA

    --Calcula el descuento promocion y el complemento
    SELECT @PonderadoPromocion = 100 --PROMOCIONPROMOCION
    SELECT @CalcDescuentoPromocion = (@DescuentoAcum /100) * @PonderadoPromocion --PROMOCIONPROMOCION
    SELECT @DescuentoPromocion = @CalcDescuentoPromocion --PROMOCIONPROMOCION
    SELECT @PonderadoPromocion = @PonderadoPromocion - @CalcDescuentoPromocion --PROMOCIONPROMOCION

    --Calcula el descuento particular y el complemento
    SELECT @PonderadoParticular = 100 --PROMOCIONPARTICULAR
    SELECT @CalcDescuentoParticular = (@DescuentoAcum /100) * @PonderadoParticular --PROMOCIONPARTICULAR
    SELECT @DescuentoParticular = @CalcDescuentoParticular --PROMOCIONPARTICULAR
    SELECT @PonderadoParticular = @PonderadoParticular - @CalcDescuentoParticular --PROMOCIONPARTICULAR

  WHILE @@FETCH_STATUS = 0 
  BEGIN
    FETCH NEXT FROM CrDescto INTO @DescuentoAcum, @Nivel, @Descripcion, @FechaD, @FechaA, @ConVigencia
      IF @@FETCH_STATUS = 0
      BEGIN
        --IF @PromocionExclusiva = 0 OR @Nivel IN ('Siempre') --PROMOCIONEXCLUSIVA
        --BEGIN --PROMOCIONEXCLUSIVA 
          IF @Nivel IN ('Exclusiva') --PROMOCION Se quito la tipo promoción de aqui.
          BEGIN
            -- SELECT @Descuento = @DescuentoAcum --PROMOCIONEXCLUSIVA
            SET @PromocionExclusiva = 1 --PROMOCIONEXCLUSIVA
          END ELSE 
          IF @Nivel IN ('Promocion') --PROMOCIONPROMOCION
          BEGIN
            -- SELECT @Descuento = @DescuentoAcum --PROMOCIONEXCLUSIVA
            SET @PromocionPromocion = 1 --PROMOCIONPROMOCION
          END ELSE 
          IF @Nivel IN ('Particular') --PROMOCIONPARTICULAR
          BEGIN
            -- SELECT @Descuento = @DescuentoAcum --PROMOCIONPARTICULAR
            SET @PromocionParticular = 1 --PROMOCIONPARTICULAR
          END  

          --Suma los descuentos para que se puedan aplicar varias politicas al mismo tiempo.
          SELECT @CalcDescuento = (@DescuentoAcum /100) * @Ponderado    
          SELECT @Descuento = @Descuento + @CalcDescuento
          SELECT @Ponderado = @Ponderado - @CalcDescuento
          --Si es promocion, particulo o Exclusiva regresa el primer descuento pero segun yo debería de estar ordenado de alguna forma      

          --Calcula los descuentos exclusivos
          IF (@Nivel IN ('Siempre')) OR (@Nivel IN ('Exclusiva') AND @PromocionExclusivaAplicada = 0) --PROMOCIONEXCLUSIVA
          BEGIN
            SELECT @CalcDescuentoExclusivo = (@DescuentoAcum /100) * @PonderadoExclusivo --PROMOCIONEXCLUSIVA    
            SELECT @DescuentoExclusivo = @DescuentoExclusivo + @CalcDescuentoExclusivo --PROMOCIONEXCLUSIVA
            SELECT @PonderadoExclusivo = @PonderadoExclusivo - @CalcDescuentoExclusivo --PROMOCIONEXCLUSIVA
            IF @Nivel IN ('Exclusiva') SET @PromocionExclusivaAplicada = 1
          END ELSE
          IF (@Nivel IN ('Siempre')) OR (@Nivel IN ('Promocion') AND @PromocionPromocionAplicada = 0) --PROMOCIONPROMOCION
          BEGIN
            SELECT @CalcDescuentoPromocion = (@DescuentoAcum /100) * @PonderadoPromocion --PROMOCIONPROMOCION    
            SELECT @DescuentoPromocion = @DescuentoPromocion + @CalcDescuentoPromocion --PROMOCIONPROMOCION
            SELECT @PonderadoPromocion = @PonderadoPromocion - @CalcDescuentoPromocion --PROMOCIONPROMOCION
            IF @Nivel IN ('Promocion') SET @PromocionPromocionAplicada = 1
          END ELSE
          IF (@Nivel IN ('Siempre')) OR (@Nivel IN ('Particular') AND @PromocionParticularAplicada = 0)  --PROMOCIONPARTICULAR
          BEGIN
            SELECT @CalcDescuentoParticular = (@DescuentoAcum /100) * @PonderadoParticular --PROMOCIONPARTICULAR   
            SELECT @DescuentoParticular = @DescuentoParticular + @CalcDescuentoParticular --PROMOCIONPARTICULAR
            SELECT @PonderadoParticular = @PonderadoParticular - @CalcDescuentoParticular --PROMOCIONPARTICULAR
            IF @Nivel IN ('Particular') SET @PromocionParticularAplicada = 1            
          END
          
        --END --PROMOCIONEXCLUSIVA
      END
  END       
  
  CLOSE crDescto
  DEALLOCATE crDescto

  IF @PromocionPromocion = 1                                                          SET @Descuento = @DescuentoPromocion  ELSE
  IF @PromocionPromocion = 0 AND @PromocionParticular = 1                             SET @Descuento = @DescuentoParticular ELSE
  IF @PromocionPromocion = 0 AND @PromocionParticular = 0 AND @PromocionExclusiva = 1 SET @Descuento = @DescuentoExclusivo
  
  --Obtiene el costo del articulo
  EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, @Subcuenta, @UnidadVenta, @TipoCosteo, @Moneda, @TipoCambio, @MovCosto = @Costo OUTPUT, @ConReturn = 0

    --Cuando es por precio, calcula el precio minimo segun el tipo especifico y pone todo esto en una tabla temporal
    SELECT Precio = CASE WHEN p.Tipo = 'Precio' THEN MIN(ISNULL(pd.Monto,0))
			 WHEN p.Tipo = 'Precio=Costo+[%]' THEN MIN(@Costo + (@Costo * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Costo+[$]' THEN MIN(@Costo + ISNULL(pd.Monto,0))
			 WHEN p.Tipo = 'Precio=Costo+[% margen]' THEN MIN(@Costo / (1 - (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Costo*[Factor]' THEN MIN(@Costo * pd.Monto)
			 WHEN p.Tipo = 'Precio=Precio+[%]' THEN MIN(@PrecioTemp + (@PrecioTemp * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio Lista+[%]' THEN MIN(@PrecioLista + (@PrecioLista * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 2+[%]' THEN MIN(@Precio2 + (@Precio2 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 3+[%]' THEN MIN(@Precio3 + (@Precio3 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 4+[%]' THEN MIN(@Precio4 + (@Precio4 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 5+[%]' THEN MIN(@Precio5 + (@Precio5 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 6+[%]' THEN MIN(@Precio6 + (@Precio6 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 7+[%]' THEN MIN(@Precio7 + (@Precio7 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 8+[%]' THEN MIN(@Precio8 + (@Precio8 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 9+[%]' THEN MIN(@Precio9 + (@Precio9 * (ISNULL(pd.Monto,0) / 100.00)))
			 WHEN p.Tipo = 'Precio=Precio 10+[%]' THEN MIN(@Precio10 + (@Precio10 * (ISNULL(pd.Monto,0) / 100.00)))
	            END,
	   Orden = CASE WHEN p.Tipo = 'Precio' THEN 1
			WHEN p.Tipo = 'Precio=Costo+[%]' THEN 2
			WHEN p.Tipo = 'Precio=Costo+[$]' THEN 3
			WHEN p.Tipo = 'Precio=Costo+[% margen]' THEN 4
			WHEN p.Tipo = 'Precio=Costo*[Factor]' THEN 5
			WHEN p.Tipo = 'Precio=Precio+[%]' THEN 6
			WHEN p.Tipo = 'Precio=Precio Lista+[%]' THEN 7
			WHEN p.Tipo = 'Precio=Precio 2+[%]' THEN 8
			WHEN p.Tipo = 'Precio=Precio 3+[%]' THEN 9
			WHEN p.Tipo = 'Precio=Precio 4+[%]' THEN 10
			WHEN p.Tipo = 'Precio=Precio 5+[%]' THEN 11
			WHEN p.Tipo = 'Precio=Precio 6+[%]' THEN 12
			WHEN p.Tipo = 'Precio=Precio 7+[%]' THEN 13
			WHEN p.Tipo = 'Precio=Precio 8+[%]' THEN 14
			WHEN p.Tipo = 'Precio=Precio 9+[%]' THEN 15
			WHEN p.Tipo = 'Precio=Precio 10+[%]' THEN 16
		    ELSE 99999999
		    END,
		    p.Tipo,
		    p.Nivel
      INTO #PrecioTemp
      FROM Precio p
     INNER JOIN PrecioD pd ON p.ID = pd.ID
                          AND @Cantidad >= pd.Cantidad                          
     WHERE ((ISNULL(p.ConVigencia,0) = 0) OR (@FechaEmision BETWEEN p.FechaD AND p.FechaA))
       --Condiciones de Propiedades de Articulo 
       AND ((ISNULL(p.NivelArticulo,0) = 0) OR (p.Articulo = @Articulo)) 
       AND ((ISNULL(p.NivelSubCuenta,0) = 0) OR (p.SubCuenta = @Subcuenta)) 
       AND ((ISNULL(p.NivelUnidadVenta,0) = 0) OR (p.UnidadVenta = @UnidadVenta)) 
       AND ((ISNULL(p.NivelArtCat,0) = 0) OR (p.ArtCat = @ArtCat))
       AND ((ISNULL(p.NivelArtGrupo,0) = 0) OR (p.ArtGrupo = @ArtGrupo)) 
       AND ((ISNULL(p.NivelArtFam,0) = 0) OR (p.ArtFam = @ArtFam))
       AND ((ISNULL(p.NivelArtABC,0) = 0) OR (p.ArtAbc = @ArtAbc))  
       AND ((ISNULL(p.NivelFabricante,0) = 0) OR (p.Fabricante = @Fabricante))
       AND ((ISNULL(p.NivelArtLinea,0) = 0) OR (p.ArtLinea = @ArtLinea)) 
       AND ((ISNULL(p.NivelArtRama,0) = 0) OR (p.ArtRama = @ArtRama))
       --Condiciones de Propiedades de Clientes
       AND ((ISNULL(p.NivelCliente,0) = 0) OR (p.Cliente = @Cliente))
       AND ((ISNULL(p.NivelCteGrupo,0) = 0) OR (p.CteGrupo = @CteGrupo))
       AND ((ISNULL(p.NivelCteCat,0) = 0) OR (p.CteCat = @CteCat))
       AND ((ISNULL(p.NivelCteFam,0) = 0) OR (p.CteFam = @CteFam))
       AND ((ISNULL(p.NivelCteZona,0) = 0) OR (p.CteZona = @CteZona))
        --Condiciones de Propiedades de la Factura
       AND ((ISNULL(p.NivelAgente,0) = 0) OR (p.Agente = @Agente))
       AND ((ISNULL(p.NivelMoneda,0) = 0) OR (p.Moneda = @Moneda))
       AND ((ISNULL(p.NivelCondicion,0) = 0) OR (p.Condicion = @Condicion))
       AND ((ISNULL(p.NivelAlmacen,0) = 0) OR (p.Almacen = @Almacen))
       AND ((ISNULL(p.NivelProyecto,0) = 0) OR (p.Proyecto = @Proyecto))
       AND ((ISNULL(p.NivelFormaEnvio,0) = 0) OR (p.FormaEnvio = @FormaEnvio))
       AND ((ISNULL(p.NivelMov,0) = 0) OR (p.Mov = @Mov))
       AND ((ISNULL(p.NivelServicioTipo,0) = 0) OR (p.ServicioTipo = @ServicioTipo))
       AND ((ISNULL(p.NivelContratoTipo,0) = 0) OR (p.ContratoTipo = @ContratoTipo))
       AND ((ISNULL(p.NivelEmpresa,0) = 0) OR (p.Empresa = @Empresa)) 
       AND ((ISNULL(p.NivelRegion,0) = 0) OR (p.Region = @Region))
       AND ((ISNULL(p.NivelSucursal,0) = 0) OR (p.Sucursal = @Sucursal))          
       AND ((ISNULL(p.ListaPrecios,'Todas') = 'Todas') OR (p.ListaPrecios = @ListaPreciosEsp))
       AND p.Tipo LIKE ('Precio%')
       AND p.Estatus = 'ACTIVA'
       AND pd.Cantidad = (SELECT MAX(Cantidad) 
                            FROM PrecioD pd2 
                           WHERE p.ID = pd2.ID
                             AND @Cantidad >= pd2.Cantidad)
   GROUP BY p.Tipo,
	    p.Nivel
   ORDER BY Orden

   SELECT TOP 1 @Precio = Precio,
		@NivelPolitica = Nivel
     FROM #PrecioTemp
   ORDER BY Orden
   
   IF @NivelPolitica = 'Exclusiva'
     SELECT @Descuento = 0
   
END    

GO
