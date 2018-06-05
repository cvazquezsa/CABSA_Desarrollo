SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/*************************  fnRedondeaMaxMin  ************************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'fnRedondeaMaxMin' AND TYPE='FN')	DROP FUNCTION fnRedondeaMaxMin
GO
CREATE FUNCTION fnRedondeaMaxMin(@Valor float)
	RETURNS float
AS BEGIN
	DECLARE @Entero              int,
			@Decimal             float,
			@Redondeo            float

	SET @Entero = 0
	SET @Decimal = 0
	SET @Redondeo = 0

	SET @Entero = CONVERT(int, @Valor)
	SET @Decimal = ROUND((@Valor - @Entero), 2)

	IF @Decimal > 0.5
		SET @Redondeo = @Entero + 1

	IF @Decimal <= 0.5
		SET @Redondeo = @Entero

	RETURN @Redondeo
END
GO

/*************************  fnMaximo  ************************/
IF EXISTS (SELECT * FROM SYSOBJECTS WHERE NAME = 'fnMaximo' AND TYPE='FN' ) DROP FUNCTION fnMaximo
GO
CREATE FUNCTION fnMaximo(
  @Actual                    float,			
  @Anterior                  float,			
  @AnteriorMAD               float,			
  @Crecimiento               float,			
  @DiasMes                   float,			
  @Factor                    float,			
  @TiempoEntregaB            float,			
  @TiempoUnidad              varchar(10),	
  @TiempoEntregaSegB         float,			
  @TiempoSegUnidad           varchar(10),	
  @DiasInventario            float)			
RETURNS float
AS
BEGIN
	DECLARE  @Maximo              float,
			 @DifAP               float,
			 @DifAP_Prc           float,
			 @Prc_VentaA          Float,
			 @VentaSI             float,
			 @VentaCI             float,
			 @Total               float,
			 @VentaProm           float,
			 @TiempoEntrega       float,
			 @TiempoEntregaSeg    float,
			 @Dias                float

	SET @Maximo = 0
	SET @DifAP = 0
	SET @TiempoEntrega = 0

	IF @Anterior > 0 SET @DifAP = ISNULL((((@AnteriorMAD / @Anterior) - 1) * 100),0)
	IF @Anterior = 0 SET @DifAP_Prc = -1
	SET @DifAP_Prc = (@DifAP / 100)
	SET @Prc_VentaA = (@Actual * @DifAP_Prc)

	IF @TiempoUnidad      = 'Dias'    SET @TiempoEntrega    = @TiempoEntregaB * 1
	ELSE IF @TiempoUnidad = 'Semanas' SET @TiempoEntrega    = @TiempoEntregaB * 7
	ELSE IF @TiempoUnidad = 'Meses'   SET @TiempoEntrega    = @TiempoEntregaB * 30

	IF @TiempoSegUnidad      = 'Dias'    SET @TiempoEntregaSeg = @TiempoEntregaSegB * 1
	ELSE IF @TiempoSegUnidad = 'Semanas' SET @TiempoEntregaSeg = @TiempoEntregaSegB * 7
	ELSE IF @TiempoSegUnidad = 'Meses'   SET @TiempoEntregaSeg = @TiempoEntregaSegB * 30

	IF @DiasInventario > 0 SET @Dias = @DiasInventario + ISNULL(@TiempoEntrega,0) + ISNULL(@TiempoEntregaSeg,0)

	IF ISNULL(@DiasInventario,0) <= 0 SET @Dias = 0

	IF @DifAP <= 0
	BEGIN
		SET @VentaSI = @Actual
		SET @VentaCI = (@VentaSI * (@Crecimiento / 100))
		SET @Total = @VentaSI + @VentaCI
		SET @VentaProm = (@Total / @DiasMes)
	END
	ELSE
	BEGIN
		SET @VentaSI = @Actual + @Prc_VentaA
		SET @VentaCI = (@VentaSI * (@Crecimiento / 100))
		SET @Total = @VentaSI + @VentaCI
		SET @VentaProm = (@Total / @DiasMes)
	END

	SET @Maximo = @VentaProm * @Dias

	RETURN @Maximo
END
GO


/*************************  fnClasificaABC  ************************/
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'fnClasificaABC' AND TYPE = 'FN' ) DROP FUNCTION fnClasificaABC
GO
CREATE FUNCTION fnClasificaABC (@Valor float)
RETURNS char
AS
BEGIN
	DECLARE @ABC char(1)

	SELECT @ABC = ABC
	  FROM ABC
	 WHERE @Valor BETWEEN Desde AND Hasta

	RETURN @ABC
END
GO

/************************** spOrdenarPlanRutaDistribucion *************************/
IF EXISTS(SELECT * FROM sysobjects WHERE  NAME = 'spOrdenarPlanRutaDistribucion' AND TYPE = 'P') DROP PROCEDURE spOrdenarPlanRutaDistribucion
GO
CREATE PROCEDURE [dbo].[spOrdenarPlanRutaDistribucion]
	@Estacion	int,
	@Almacen	varchar(10)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@Orden			int,
		@AlmacenOrigen	varchar(10)

	DECLARE CrAlmacen CURSOR FOR
		SELECT A.AlmacenOrigen 
		  FROM RutaDistribucionMaxMin A
		  JOIN ListaSt B ON A.AlmacenOrigen = B.Clave
		 WHERE A.AlmacenDestino = @Almacen
		   AND B.Estacion = @Estacion
	  ORDER BY B.ID
	
	OPEN CrAlmacen
	FETCH NEXT FROM CrAlmacen INTO @AlmacenOrigen
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		SET @Orden = ISNULL(@Orden,0) + 1
		UPDATE RutaDistribucionMaxMin SET Orden = @Orden WHERE AlmacenOrigen = @AlmacenOrigen AND AlmacenDestino = @Almacen
			
		FETCH NEXT FROM CrAlmacen INTO @AlmacenOrigen
	END
	
	CLOSE CrAlmacen
	DEALLOCATE CrAlmacen

END
GO

/************************** spPlanArtMaxMinFiltros *************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMinFiltros' AND Type = 'P')
  DROP PROCEDURE spPlanArtMaxMinFiltros
GO
CREATE PROCEDURE spPlanArtMaxMinFiltros
  @Empresa         varchar(5),
  @Sucursal        int,
  @Usuario         varchar(10),
  @Estacion        int
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal          = ISNULL(@Sucursal,0)
SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
SET @Estacion          = ISNULL(@Estacion,0)

DECLARE @Filtro         varchar(20)
DECLARE @Valor          varchar(100)

SET @Valor = 'Seleccionar'

DECLARE @TablaRet table(
 IDR               int IDENTITY(1,1),
 Filtro            varchar(20) NULL,
 Valor             varchar(100) NULL
)

SET @Filtro = 'Categoria'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Categoria,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Categoria
ORDER BY 2

SET @Filtro = 'Grupo'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Grupo,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Grupo
ORDER BY 2

SET @Filtro = 'Familia'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Familia,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Familia
ORDER BY 2

SET @Filtro = 'Linea'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Linea,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Linea
ORDER BY 2

SET @Filtro = 'Fabricante'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Fabricante,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Fabricante
ORDER BY 2

SET @Filtro = 'Proveedor'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Proveedor,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Proveedor
ORDER BY 2

SET @Filtro = 'Almacen'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Almacen,''))
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Almacen
ORDER BY 2


SET @Valor = 'No especificado'
UPDATE @TablaRet SET Valor = @Valor WHERE LTRIM(RTRIM(ISNULL(Valor,''))) = ''

SET @Filtro = 'Categoria'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Grupo'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Familia'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Linea'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Fabricante'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Proveedor'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Almacen'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET NOCOUNT OFF
END
GO

/************************** spPlanArtMaxMinArbol *************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMinArbol' AND Type = 'P')
  DROP PROCEDURE spPlanArtMaxMinArbol
GO
CREATE PROCEDURE spPlanArtMaxMinArbol
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

DECLARE @NodoRaiz       varchar(20)
DECLARE @NoEspecificado char(15)

DECLARE @TablaRet table(
  IDR                   int IDENTITY(1,1),
  NodoNombre            varchar(50)  NULL,
  NodoPadre             varchar(50)  NULL
)

SET @Empresa  = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal = ISNULL(@Sucursal,0)
SET @Usuario  = LTRIM(RTRIM(ISNULL(@Usuario,'')))
SET @Estacion = ISNULL(@Estacion,0)

SET @NodoRaiz = '(Todo)'
SET @NoEspecificado = 'NO ESPECIFICADO'

INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Categoria',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Grupo',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Familia',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Linea',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Fabricante',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Proveedor',@NodoRaiz)
INSERT INTO @TablaRet (NodoNombre,NodoPadre) VALUES ('Almacen',@NodoRaiz)

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Categoria,'')))), 'Categoria' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Categoria
ORDER BY Categoria

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Grupo,'')))), 'Grupo' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Grupo
ORDER BY Grupo

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Familia,'')))), 'Familia' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Familia
ORDER BY Familia

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Linea,'')))), 'Linea' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Linea
ORDER BY Linea

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Fabricante,'')))), 'Fabricante' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Fabricante
ORDER BY Fabricante

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Proveedor,'')))), 'Proveedor' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Proveedor
ORDER BY Proveedor

INSERT INTO @TablaRet
SELECT UPPER(LTRIM(RTRIM(ISNULL(Almacen,'')))), 'Almacen' FROM PlanArtMaxMin
WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion
GROUP BY Almacen
ORDER BY Almacen

UPDATE @TablaRet SET NodoNombre = @NoEspecificado
WHERE LTRIM(RTRIM(ISNULL(NodoNombre,''))) = ''

-->
SELECT NodoNombre,NodoPadre FROM @TablaRet ORDER BY IDR

SET NOCOUNT OFF
END
GO

/************************** spPlanArtMaxMinAnexo *************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMinAnexo' AND Type = 'P')
  DROP PROCEDURE spPlanArtMaxMinAnexo
GO
CREATE PROCEDURE spPlanArtMaxMinAnexo
  @Empresa         varchar(5),
  @Sucursal        int,
  @Usuario         varchar(10),
  @Estacion        int
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

DECLARE @Rama           varchar(5)
DECLARE @Nombre         varchar(255)
DECLARE @Tipo           varchar(10)

DECLARE @TablaTmp table(
  Articulo              varchar(20)   NULL
)

SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal          = ISNULL(@Sucursal,0)
SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
SET @Estacion          = ISNULL(@Estacion,0)

SET @Rama     = 'INV'
SET @Nombre   = 'FOTO'
SET @Tipo     = 'IMAGEN'

INSERT INTO @TablaTmp (Articulo)
SELECT Articulo
  FROM PlanArtMaxMin
 WHERE Empresa = @Empresa
   AND Usuario = @Usuario
GROUP BY Articulo
ORDER BY Articulo

SELECT t.Articulo,a.Direccion
  FROM @TablaTmp t
  JOIN AnexoCta a ON (t.Articulo = a.Cuenta)
 WHERE a.Rama = @Rama
   AND a.Nombre = @Nombre
   AND a.Tipo = @Tipo
ORDER BY a.Cuenta

SET NOCOUNT OFF
END
GO

/************************** spActualizarMaxMin *************************/
IF EXISTS(SELECT * FROM sysobjects WHERE  NAME = 'spActualizarMaxMin' AND TYPE = 'P') DROP PROCEDURE spActualizarMaxMin
GO
CREATE PROCEDURE spActualizarMaxMin
		@Empresa                   char(5)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE 
	@Tipo                				varchar(50),
	@Hoy                 				datetime,
	@DiasVenta           				float,
	@DiasInventario      				float,
	@FactorCrecimiento   				float,
	@HoyMesAnterior      				datetime,
	@HoyAnioAtras        				datetime,
	@HoyMesAnioAtras     				datetime,
	@HoyAnioAtrasA						datetime,
	@HoyMesSiguienteAnioAtras			datetime,
	@Articulo            				varchar(20),
	@SubCuenta           				varchar(20),
	@Almacen             				varchar(10),
	@Maximo              				float,
	@Minimo              				float,
	@PuntoOrden          				float,
	@AOrdenar            				float,
	@ABC                 				char(1),
	@Porcentaje          				float,
	@PeriodoA			 				bit,
	@PeriodoB			 				bit,
	@PeriodoC			 				bit,
	@MesesPeriodoA		 				int,
	@MesesPeriodoB		 				int,
	@MesesPeriodoC		 				int,
	@PrimerDiaMesActual					datetime,
	@UltimoDiaMesAnterior				datetime,
	@Semanas							int,
	@UltimoDiaSemanaPasada				datetime,
	@ComienzoSemanaCerrada				datetime,
	@ComienzoDiasNaturales				datetime
	
	--Esta linea determina la fecha, para que calcule con la fecha actual dejar solo la segunda linea GETDATE()
	SET @Hoy	=	DATEADD(d,-0,dbo.fnFechaSinHora(GETDATE()))
	--SET @Hoy	=	'10/10/2013'  --Temporal
	
	--SELECT @Hoy HoyModificado 
	
	SELECT @Tipo				 = Tipo,
	       @DiasVenta            = DiasVenta,
	       @Semanas				 = Semanas,
		   @DiasInventario       = ISNULL(DiasInventario,0),
		   @FactorCrecimiento    = ISNULL(FactorCrecimiento,0),		   
		   @PeriodoA			 = ISNULL(PeriodoA,0),
		   @MesesPeriodoA		 = ISNULL(MesesPeriodoA,0),
		   @PeriodoB			 = ISNULL(PeriodoB,0),
		   @MesesPeriodoB		 = ISNULL(MesesPeriodoB,0),
		   @PeriodoC			 = ISNULL(PeriodoC,0),
		   @MesesPeriodoC		 = ISNULL(MesesPeriodoC,0)		   		  
	  FROM PlanArtMaxMinCfg
	 WHERE Empresa = @Empresa
 
	CREATE TABLE #VentaAVGGeneral(
	  Empresa                    char(5),
	  Articulo                   varchar(20),
	  SubCuenta                  varchar(20)  NULL,
	  Almacen                    varchar(10),
	  Cantidad                   float,
	  Factor                     float,
	  IncrementoPRC              float,
	  TiempoEntrega              int,
	  TiempoEntregaUnidad        varchar(10),
	  TiempoEntregaSeg           float        NULL,
	  TiempoEntregaSegUnidad     varchar(10)  NULL,
	  DiasInventario             float        NULL,
	  UnidadTraspaso             varchar(50)  NULL,
	  UnidadCompra               varchar(50)  NULL
	)
	CREATE NONCLUSTERED INDEX Temp3 ON #VentaAVGGeneral(Empresa,Articulo,SubCuenta,Almacen)
	
	CREATE TABLE #ArtAlm(
	  Empresa                    char(5),
	  Articulo                   varchar(20),
	  SubCuenta                  varchar(20),
	  Almacen                    varchar(10),
	  Maximo                     float,
	  Minimo                     float NULL,
	  ABC						 varchar(50) NULL,
	  VentaPromedio				 float
	)
	CREATE NONCLUSTERED INDEX Temp ON #ArtAlm (Articulo, SubCuenta, Almacen, Empresa)	

	--Se inicializan Maximo y Minimo
	UPDATE ArtAlm SET Maximo=0,Minimo=0,PuntoOrden=0,PuntoOrdenOrdenar=0,ABC='',VentaPromedio=0
	WHERE Almacen NOT IN(SELECT Almacen FROM alm WHERE ExcluirPlaneacion=1)
	
	-- CONTROL POR TIPO DE METODO
	IF @Tipo = 'DIAS NATURALES' AND @DiasVenta > 0
	BEGIN
			-- Obtenemos rango de dias en validacion de dias naturales.
			SET @ComienzoDiasNaturales = DATEADD(DAY, -(@DiasVenta), @Hoy)
			--SELECT 'RANGO FECHA: '+CONVERT(varchar(50),@ComienzoDiasNaturales,101)+' ENTRE '+CONVERT(varchar(50),@Hoy,101)
			
			-- Venta Promedio Dias Naturales
			INSERT #VentaAVGGeneral(
				   Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
				   IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
				   UnidadTraspaso, UnidadCompra, DiasInventario)
			SELECT v.Empresa, d.Articulo, ISNULL(d.SubCuenta,''), d.Almacen, CASE WHEN t.Clave IN ('VTAS.D', 'VTAS.VP') THEN ISNULL(SUM(d.Cantidad*d.Factor),0)*-1 ELSE ISNULL(SUM(d.Cantidad*d.Factor),0) END, ISNULL(0,0),
				   0.00, ISNULL(a.TiempoEntrega,1), ISNULL(a.TiempoEntregaUnidad,'Dias'), ISNULL(a.TiempoEntregaSeg,1),ISNULL(a.TiempoEntregaSegUnidad,'Dias'), 
				   a.UnidadTraspaso, a.UnidadCompra, @DiasInventario
			FROM Venta v
			JOIN VentaD d ON v.ID = d.ID
			JOIN MovTipo t ON v.Mov = t.Mov AND t.Modulo = 'VTAS'
			JOIN Art a ON d.Articulo = a.Articulo
			JOIN Alm l ON d.Almacen = l.Almacen
			LEFT JOIN ArtFam f ON a.Familia = f.Familia
			LEFT JOIN ArtCat c ON a.Categoria = c.Categoria
			WHERE t.Clave IN ('VTAS.F', 'VTAS.D','VTAS.VP')
			  AND v.Estatus IN ('CONCLUIDO')
			  AND UPPER(a.Tipo) <> 'SERVICIO'
			  AND v.FechaEmision BETWEEN @ComienzoDiasNaturales AND @Hoy
			  AND v.Empresa = @Empresa
			  AND ISNULL(l.ExcluirPlaneacion,0) = 0	
			  AND a.Tipo <> 'JUEGO'
			GROUP BY v.Empresa, d.Articulo, d.SubCuenta, d.Almacen, t.Clave, a.TiempoEntrega, a.TiempoEntregaUnidad,
			  a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.UnidadTraspaso, a.UnidadCompra

	END	--FINALIZA METODO TIPO DIAS NATURALES
	
	IF @Tipo = 'SEMANAS CERRADAS' AND @Semanas > 0 
		BEGIN					
			-- Obtenemos último día de la semana pasada
			SET @UltimoDiaSemanaPasada = DATEADD(WK,DATEDIFF(WK,7,@Hoy),6) --Último día de la semana pasada
			SET @ComienzoSemanaCerrada = DATEADD(WK, -@Semanas, @UltimoDiaSemanaPasada)
			SET @ComienzoSemanaCerrada = DATEADD(DAY,+1,@ComienzoSemanaCerrada)
			--SELECT 'RANGO FECHA: '+CONVERT(varchar(50),@ComienzoSemanaCerrada,101)+' ENTRE '+CONVERT(varchar(50),@UltimoDiaSemanaPasada,101)		
			
			-- Venta Promedio Semanas Cerradas
			INSERT #VentaAVGGeneral(
				   Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
				   IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
				   UnidadTraspaso, UnidadCompra, DiasInventario)
			SELECT v.Empresa, d.Articulo, ISNULL(d.SubCuenta,''), d.Almacen, CASE WHEN t.Clave IN ('VTAS.D', 'VTAS.VP') THEN ISNULL(SUM(d.Cantidad*d.Factor),0)*-1 ELSE ISNULL(SUM(d.Cantidad*d.Factor),0) END, ISNULL(0,0),
				   0.00, ISNULL(a.TiempoEntrega,1), ISNULL(a.TiempoEntregaUnidad,'Dias'), ISNULL(a.TiempoEntregaSeg,1),ISNULL(a.TiempoEntregaSegUnidad,'Dias'), 
				   a.UnidadTraspaso, a.UnidadCompra, @DiasInventario
			FROM Venta v
			JOIN VentaD d ON v.ID = d.ID
			JOIN MovTipo t ON v.Mov = t.Mov AND t.Modulo = 'VTAS'
			JOIN Art a ON d.Articulo = a.Articulo
			JOIN ArtFam f ON a.Familia = f.Familia
			JOIN ArtCat c ON a.Categoria = c.Categoria
			JOIN Alm l ON d.Almacen = l.Almacen
			WHERE t.Clave IN ('VTAS.F', 'VTAS.D','VTAS.VP')
			  AND v.Estatus IN ('CONCLUIDO')
			  AND UPPER(a.Tipo) <> 'SERVICIO'
			  AND v.FechaEmision BETWEEN @ComienzoSemanaCerrada AND @UltimoDiaSemanaPasada
			  AND v.Empresa = @Empresa
			  AND ISNULL(l.ExcluirPlaneacion,0) = 0	
			GROUP BY v.Empresa, d.Articulo, d.SubCuenta, d.Almacen, t.Clave, a.TiempoEntrega, a.TiempoEntregaUnidad,
			  a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.UnidadTraspaso, a.UnidadCompra		
					
			--Se Calculan dias de Venta
			SET @DiasVenta = DATEDIFF(day, @ComienzoSemanaCerrada, @UltimoDiaSemanaPasada)
			
		END --FINALIZA METODO TIPO SEMANAS CERRADAS
	
	IF @Tipo = 'MESES CERRADOS'
		BEGIN	
			CREATE TABLE #VentaAVGPeriodoA(
				  Empresa                    char(5),
				  Articulo                   varchar(20),
				  SubCuenta                  varchar(20)  NULL,
				  Almacen                    varchar(10),
				  Cantidad                   float,
				  Factor                     float,
				  IncrementoPRC              float,
				  TiempoEntrega              int,
				  TiempoEntregaUnidad        varchar(10),
				  TiempoEntregaSeg           float        NULL,
				  TiempoEntregaSegUnidad     varchar(10)  NULL,
				  DiasInventario             float        NULL,
				  UnidadTraspaso             varchar(50)  NULL,
				  UnidadCompra               varchar(50)  NULL
				)
				CREATE NONCLUSTERED INDEX VentaAVGPA ON #VentaAVGPeriodoA(Empresa,Articulo,SubCuenta,Almacen)
		
				CREATE TABLE #VentaAVGPeriodoB(
				  Empresa                    char(5),
				  Articulo                   varchar(20),
				  SubCuenta                  varchar(20)  NULL,
				  Almacen                    varchar(10),
				  Cantidad                   float,
				  Factor                     float,
				  IncrementoPRC              float,
				  TiempoEntrega              int,
				  TiempoEntregaUnidad        varchar(10),
				  TiempoEntregaSeg           float        NULL,
				  TiempoEntregaSegUnidad     varchar(10)  NULL,
				  DiasInventario             float        NULL,
				  UnidadTraspaso             varchar(50)  NULL,
				  UnidadCompra               varchar(50)  NULL
				)
				CREATE NONCLUSTERED INDEX VentaAVGPB ON #VentaAVGPeriodoB(Empresa,Articulo,SubCuenta,Almacen)
				
				CREATE TABLE #VentaAVGPeriodoC(
				  Empresa                    char(5),
				  Articulo                   varchar(20),
				  SubCuenta                  varchar(20)  NULL,
				  Almacen                    varchar(10),
				  Cantidad                   float,
				  Factor                     float,
				  IncrementoPRC              float,
				  TiempoEntrega              int,
				  TiempoEntregaUnidad        varchar(10),
				  TiempoEntregaSeg           float        NULL,
				  TiempoEntregaSegUnidad     varchar(10)  NULL,
				  DiasInventario             float        NULL,
				  UnidadTraspaso             varchar(50)  NULL,
				  UnidadCompra               varchar(50)  NULL
				)
				CREATE NONCLUSTERED INDEX VentaAVGPC ON #VentaAVGPeriodoC(Empresa,Articulo,SubCuenta,Almacen)
			
			IF @PeriodoA = 1 AND @MesesPeriodoA > 0 
				BEGIN					
					-- Obtenemos el primer dia del mes actual
					SET @PrimerDiaMesActual = DATEADD(MONTH, DATEDIFF(MONTH, 0, @Hoy), 0)
					SET @HoyMesAnterior = DATEADD(MONTH,-(@MesesPeriodoA) ,@PrimerDiaMesActual)
					SET @UltimoDiaMesAnterior = DATEADD(MONTH,+1,@HoyMesAnterior)
					SET @UltimoDiaMesAnterior = DATEADD(DAY,-1,@UltimoDiaMesAnterior)
					--SELECT 'RANGO FECHA: '+CONVERT(varchar(50),@HoyMesAnterior,101)+' ENTRE '+CONVERT(varchar(50),@UltimoDiaMesAnterior,101)										
					
					
					-- Venta Promedio Periodo A
					INSERT #VentaAVGPeriodoA(
						   Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
						   IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
						   UnidadTraspaso, UnidadCompra, DiasInventario)
					SELECT v.Empresa, d.Articulo, ISNULL(d.SubCuenta,''), d.Almacen, CASE WHEN t.Clave IN ('VTAS.D', 'VTAS.VP') THEN ISNULL(SUM(d.Cantidad*d.Factor),0)*-1 ELSE ISNULL(SUM(d.Cantidad*d.Factor),0) END, ISNULL(0,0),
						   0.00, ISNULL(a.TiempoEntrega,1), ISNULL(a.TiempoEntregaUnidad,'Dias'), ISNULL(a.TiempoEntregaSeg,1),ISNULL(a.TiempoEntregaSegUnidad,'Dias'), 
						   a.UnidadTraspaso, a.UnidadCompra, @DiasInventario
					FROM Venta v
					JOIN VentaD d ON v.ID = d.ID
					JOIN MovTipo t ON v.Mov = t.Mov AND t.Modulo = 'VTAS'
					JOIN Art a ON d.Articulo = a.Articulo
					JOIN ArtFam f ON a.Familia = f.Familia
					JOIN ArtCat c ON a.Categoria = c.Categoria
					JOIN Alm l ON d.Almacen = l.Almacen
					WHERE t.Clave IN ('VTAS.F', 'VTAS.D','VTAS.VP')
					  AND v.Estatus IN ('CONCLUIDO')
					  AND UPPER(a.Tipo) <> 'SERVICIO'
					  AND v.FechaEmision BETWEEN @HoyMesAnterior AND @UltimoDiaMesAnterior
					  AND v.Empresa = @Empresa
					  AND ISNULL(l.ExcluirPlaneacion,0) = 0
					GROUP BY v.Empresa, d.Articulo, d.SubCuenta, d.Almacen, t.Clave, a.TiempoEntrega, a.TiempoEntregaUnidad,
					a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.UnidadTraspaso, a.UnidadCompra					
					
					--Se establece los dias de venta
					SET @DiasVenta += DATEDIFF(day, @HoyMesAnterior, @UltimoDiaMesAnterior)
																																									
				END --FINAL IF PERIODO A
				
			IF @PeriodoB = 1 AND @MesesPeriodoB > 0  
				BEGIN					
					SET @PrimerDiaMesActual = DATEADD(MONTH, DATEDIFF(MONTH, 0, @Hoy), 0)
					SET @HoyMesAnterior = DATEADD(MONTH,-(@MesesPeriodoB) ,@PrimerDiaMesActual)
					SET @UltimoDiaMesAnterior = DATEADD(MONTH,+1,@HoyMesAnterior)
					SET @UltimoDiaMesAnterior = DATEADD(DAY,-1,@UltimoDiaMesAnterior)
											
					-- Venta Promedio Periodo B
					INSERT #VentaAVGPeriodoB(
						   Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
						   IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
						   UnidadTraspaso, UnidadCompra, DiasInventario)
					SELECT v.Empresa, d.Articulo, ISNULL(d.SubCuenta,''), d.Almacen, CASE WHEN t.Clave IN ('VTAS.D', 'VTAS.VP') THEN ISNULL(SUM(d.Cantidad*d.Factor),0)*-1 ELSE ISNULL(SUM(d.Cantidad*d.Factor),0) END, ISNULL(0,0),
						   0.00, ISNULL(a.TiempoEntrega,1), ISNULL(a.TiempoEntregaUnidad,'Dias'), ISNULL(a.TiempoEntregaSeg,1),ISNULL(a.TiempoEntregaSegUnidad,'Dias'), 
						   a.UnidadTraspaso, a.UnidadCompra, @DiasInventario
					FROM Venta v
					JOIN VentaD d ON v.ID = d.ID
					JOIN MovTipo t ON v.Mov = t.Mov AND t.Modulo = 'VTAS'
					JOIN Art a ON d.Articulo = a.Articulo
					JOIN ArtFam f ON a.Familia = f.Familia
					JOIN ArtCat c ON a.Categoria = c.Categoria
					JOIN Alm l ON d.Almacen = l.Almacen
					WHERE t.Clave IN ('VTAS.F', 'VTAS.D','VTAS.VP')
					  AND v.Estatus IN ('CONCLUIDO')
					  AND UPPER(a.Tipo) <> 'SERVICIO'
					  AND v.FechaEmision BETWEEN @HoyMesAnterior AND @UltimoDiaMesAnterior
					  AND v.Empresa = @Empresa
					  AND ISNULL(l.ExcluirPlaneacion,0) = 0
					GROUP BY v.Empresa, d.Articulo, d.SubCuenta, d.Almacen, t.Clave, a.TiempoEntrega, a.TiempoEntregaUnidad,
					a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.UnidadTraspaso, a.UnidadCompra					 					
					
					--Se establece los dias de venta
					SET @DiasVenta += DATEDIFF(day, @HoyMesAnterior, @UltimoDiaMesAnterior)
					
				END --FINAL PERIODO B
			
			IF @PeriodoC = 1 AND @MesesPeriodoC > 0 
				BEGIN
					SET @PrimerDiaMesActual = DATEADD(MONTH, DATEDIFF(MONTH, 0, @Hoy), 0)
					SET @HoyMesAnterior = DATEADD(MONTH,-(@MesesPeriodoC) ,@PrimerDiaMesActual)
					SET @UltimoDiaMesAnterior = DATEADD(MONTH,+1,@HoyMesAnterior)
					SET @UltimoDiaMesAnterior = DATEADD(DAY,-1,@UltimoDiaMesAnterior)
					-- Venta Promedio Periodo C
					INSERT #VentaAVGPeriodoC(
						   Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
						   IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
						   UnidadTraspaso, UnidadCompra, DiasInventario)
					SELECT v.Empresa, d.Articulo, ISNULL(d.SubCuenta,''), d.Almacen, CASE WHEN t.Clave IN ('VTAS.D', 'VTAS.VP') THEN ISNULL(SUM(d.Cantidad*d.Factor),0)*-1 ELSE ISNULL(SUM(d.Cantidad*d.Factor),0) END, ISNULL(0,0),
						   0.00, ISNULL(a.TiempoEntrega,1), ISNULL(a.TiempoEntregaUnidad,'Dias'), ISNULL(a.TiempoEntregaSeg,1),ISNULL(a.TiempoEntregaSegUnidad,'Dias'), 
						   a.UnidadTraspaso, a.UnidadCompra, @DiasInventario
					FROM Venta v
					JOIN VentaD d ON v.ID = d.ID
					JOIN MovTipo t ON v.Mov = t.Mov AND t.Modulo = 'VTAS'
					JOIN Art a ON d.Articulo = a.Articulo
					JOIN ArtFam f ON a.Familia = f.Familia
					JOIN ArtCat c ON a.Categoria = c.Categoria
					JOIN Alm l ON d.Almacen = l.Almacen
					WHERE t.Clave IN ('VTAS.F', 'VTAS.D','VTAS.VP')
					  AND v.Estatus IN ('CONCLUIDO')
					  AND UPPER(a.Tipo) <> 'SERVICIO'
					  AND v.FechaEmision BETWEEN @HoyMesAnterior AND @UltimoDiaMesAnterior
					  AND v.Empresa = @Empresa
					  AND ISNULL(l.ExcluirPlaneacion,0) = 0
					GROUP BY v.Empresa, d.Articulo, d.SubCuenta, d.Almacen, t.Clave, a.TiempoEntrega, a.TiempoEntregaUnidad,
					a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.UnidadTraspaso, a.UnidadCompra					 
					
					--Se establece los dias de venta
					SET @DiasVenta += DATEDIFF(day, @HoyMesAnterior, @UltimoDiaMesAnterior)
				
				END --FINAL PERIODO C	
				
				-- SUMARIZACION DE PERIODOS							
				INSERT #VentaAVGGeneral(
						Empresa, Articulo, SubCuenta, Almacen, Cantidad, Factor,
						IncrementoPRC, TiempoEntrega, TiempoEntregaUnidad, TiempoEntregaSeg, TiempoEntregaSegUnidad,
						UnidadTraspaso, UnidadCompra, DiasInventario)
				SELECT a.Empresa, a.Articulo, a.SubCuenta, a.Almacen, SUM(ISNULL(a.Cantidad,0.0) + ISNULL(b.Cantidad,0.0) + ISNULL(c.Cantidad,0.0)), a.Factor,
					   a.IncrementoPRC, a.TiempoEntrega, a.TiempoEntregaUnidad, a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad,
					   a.UnidadTraspaso, a.UnidadCompra, a.DiasInventario					
				FROM #VentaAVGPeriodoA a
					LEFT JOIN #VentaAVGPeriodoB b ON b.Empresa = a.Empresa AND b.Articulo = a.Articulo 
						AND b.SubCuenta = a.SubCuenta AND b.Almacen = a.Almacen
					LEFT JOIN #VentaAVGPeriodoC c ON c.Empresa = b.Empresa AND c.Articulo = b.Articulo 
						AND c.SubCuenta = b.SubCuenta AND c.Almacen = b.Almacen
				GROUP BY a.Empresa, a.Articulo, a.SubCuenta, a.Almacen, a.Factor,
					   a.IncrementoPRC, a.TiempoEntrega, a.TiempoEntregaUnidad, a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad,
					   a.UnidadTraspaso,a.UnidadCompra, a.DiasInventario	
				ORDER BY a.Articulo, a.SubCuenta, a.Almacen, a.Empresa DESC

		END --FIN MESES CERRADOS

	INSERT #ArtAlm (Empresa, Articulo, SubCuenta, Almacen, Maximo, VentaPromedio)
	SELECT a.Empresa, a.Articulo, ISNULL(a.SubCuenta,''), a.Almacen,
		   Maximo = ISNULL(dbo.fnMaximo(a.Cantidad , 0, 0 , a.IncrementoPRC, @DiasVenta, 1, a.TiempoEntrega, a.TiempoEntregaUnidad, a.TiempoEntregaSeg, a.TiempoEntregaSegUnidad, a.DiasInventario),0),
		   VentaPromedio = (a.Cantidad)/@DiasVenta 
	FROM #VentaAVGGeneral a
	WHERE (a.Cantidad/@DiasVenta) > .5

	UPDATE #ArtAlm 
	   SET Maximo = dbo.fnRedondeaMaxMin(Maximo), 
	       Minimo = dbo.fnRedondeaMaxMin(Maximo/2), 
	       VentaPromedio = dbo.fnRedondeaMaxMin(VentaPromedio),
	       ABC = ISNULL(dbo.fnClasificaABC(dbo.fnRedondeaMaxMin(VentaPromedio)),'')	
	
	-- Actualiza e Inserta Valores en ArtAlm
	--****************************************************************************************		
	UPDATE ArtAlm SET Minimo = ISNULL(b.Minimo,0), Maximo = ISNULL(b.Maximo,0), ABC = ISNULL(b.ABC,''), VentaPromedio = ISNULL(b.VentaPromedio,0)
	FROM ArtAlm a
	JOIN (SELECT Empresa, Almacen, Articulo, SubCuenta, SUM(Minimo)As Minimo, Sum(Maximo) AS Maximo, ABC, VentaPromedio
	FROM #ArtAlm GROUP BY Empresa, Almacen, Articulo, SubCuenta, ABC, VentaPromedio) b 
	  ON (a.Empresa = b.Empresa AND A.Almacen = B.Almacen AND a.Articulo = b.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(b.SubCuenta,''))

	INSERT INTO ArtAlm (Empresa, Articulo, SubCuenta, Almacen, Minimo, Maximo, ABC, VentaPromedio)
	SELECT a.Empresa, a.Articulo, a.SubCuenta, a.Almacen, a.Minimo, a.Maximo, a.ABC, a.VentaPromedio
	FROM #ArtAlm a
	LEFT JOIN ArtAlm b ON(a.Empresa = b.Empresa AND a.Articulo = b.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(b.Subcuenta,'') AND a.Almacen = b.Almacen)
	WHERE b.Empresa IS NULL OR b.Articulo IS NULL	

	--INSERT INTO ArtAlm(Empresa, Articulo, SubCuenta, Almacen, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar, UltimoMovimiento, TieneMovimientos, AbastecimientoDirecto, ABC, VentaPromedio)
	--SELECT a.Empresa, a.Articulo, a.SubCuenta, m.Almacen, 0, 0, 0, 0, dbo.fnFechasinhora(GETDATE()), 1, 0, a.ABC, a.VentaPromedio
	--FROM ArtAlm a
	--LEFT JOIN ArtAlm l ON(l.Almacen IN(SELECT Almacen FROM Alm WHERE CEDIS = 1) AND a.Articulo = l.Articulo AND a.Subcuenta = a.Subcuenta)
	--JOIN Alm m ON(m.CEDIS = 1)
	--WHERE ISNULL(l.Almacen,'') = '' AND a.Empresa = @Empresa
	--GROUP BY a.Empresa, a.Articulo, a.SubCuenta, m.Almacen, a.ABC, a.VentaPromedio
			
END
GO

/*************************  spPlanArtMaxMinFiltrosEspecificar  ************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMinFiltrosEspecificar' AND Type = 'P')
  DROP PROCEDURE spPlanArtMaxMinFiltrosEspecificar
GO
CREATE PROCEDURE spPlanArtMaxMinFiltrosEspecificar
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

SET @Empresa          = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal         = ISNULL(@Sucursal,0)
SET @Usuario          = LTRIM(RTRIM(ISNULL(@Usuario,'')))
SET @Estacion         = ISNULL(@Estacion,0)

DECLARE @Filtro         varchar(20)
DECLARE @Valor          varchar(100)

SET @Valor = '(TODOS)'

DECLARE @TablaRet table(
 IDR                    int IDENTITY(1,1),
 Filtro                 varchar(100)  NULL,
 Valor                  varchar(MAX) NULL
)

SET @Filtro = 'Categoria'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Categoria,''))
  FROM ArtCat
 GROUP BY Categoria
 ORDER BY 2

SET @Filtro = 'Grupo'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Grupo,''))
  FROM ArtGrupo
 GROUP BY Grupo
 ORDER BY 2

SET @Filtro = 'Familia'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Familia,''))
  FROM ArtFam
 GROUP BY Familia
 ORDER BY 2

SET @Filtro = 'Linea'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Linea,''))
  FROM ArtLinea
 GROUP BY Linea
 ORDER BY 2

SET @Filtro = 'Fabricante'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Fabricante,''))
  FROM Fabricante
GROUP BY Fabricante
ORDER BY 2

SET @Filtro = 'Proveedor'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(LTRIM(RTRIM(ISNULL(Proveedor,'')))) + ' - ' + UPPER(LTRIM(RTRIM(ISNULL(Nombre,''))))
  FROM Prov
 WHERE Estatus = 'ALTA'
 GROUP BY UPPER(LTRIM(RTRIM(ISNULL(Proveedor,'')))) + ' - ' + UPPER(LTRIM(RTRIM(ISNULL(Nombre,'')))) --Proveedor
 ORDER BY 2

SET @Filtro = 'Almacen'
INSERT INTO @TablaRet (Filtro,Valor) VALUES (@Filtro,@Valor)
INSERT INTO @TablaRet
SELECT @Filtro, UPPER(ISNULL(Almacen,''))
  FROM Alm
 WHERE Estatus = 'ALTA'
   AND LTRIM(RTRIM(ISNULL(Rama,''))) = ''
 GROUP BY Almacen
 ORDER BY 2

-- SOlO VITROHOGAR (VHA) -------------------------------------------------------
--DELETE @TablaRet 
-- WHERE Filtro = 'Proveedor' 
--   AND Valor NOT like 'P000%' 
--   AND NOT Valor = @Valor
--------------------------------------------------------------------------------

SET @Filtro = 'Categoria'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Grupo'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Familia'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Linea'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Fabricante'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Proveedor'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET @Filtro = 'Almacen'
SELECT IDR AS Clave, Valor FROM @TablaRet WHERE Filtro = @Filtro ORDER BY IDR

SET NOCOUNT OFF
END
GO

/*************************  spPlaneacionMaxMin  ************************/
IF EXISTS(SELECT * FROM   sysobjects WHERE  NAME = 'spPlaneacionMaxMin' AND TYPE = 'P')  DROP PROCEDURE spPlaneacionMaxMin
GO
CREATE PROCEDURE spPlaneacionMaxMin(
    @Empresa     char(5),
    @Usuario     varchar(10),
    @Estacion    int,
    @Categoria   varchar(50),
    @Grupo       varchar(50),
    @Familia     varchar(50),
    @Fabricante  varchar(50),
    @Linea       varchar(50),
    @Almacen     varchar(10),
    @Proveedor   varchar(10)
)
--//WITH ENCRYPTION
AS BEGIN

DECLARE
	@Ok					int,
	@OkRef				varchar(256),
	@cID				int,
	@cArticulo			varchar(20),
	@cSubcuenta			varchar(20),
	@cAlmacen			varchar(10),
	@MovTraspaso		varchar(20),
	@MovTraspaso1		varchar(20),
	@MovTraspaso2		varchar(20),
	@MovCompra			varchar(20),
	--------------------------------
	@Existencia			float,
	@EnCompra			float,
	@PorRecibir			float,
	@PorEntregar		float,
	--------------------------------
	@cOrigenID			int, 
	@cOrigenArticulo	varchar(20), 
	@cOrigenSubcuenta	varchar(20), 
	@cOrigenAlmacen		varchar(10), 
	@cOrigenMaximo		float, 
	@cOrigenMinimo		float, 
	@cOrigenExistencia	float, 
	@cOrigenSolicitar	float,
	--------------------------------
	@cDestinoID			int, 
	@cDestinoArticulo	varchar(20), 
	@cDestinoSubcuenta	varchar(20), 
	@cDestinoAlmacen	varchar(10), 
	@cDestinoMaximo		float, 
	@cDestinoMinimo		float, 
	@cDestinoExistencia	float, 
	@cDestinoSolicitar	float,
	--------------------------------
	@cArtEnCompra		float,
	@cArtPorRecibir		float,
	@cArtPorEntregar	float
	
	SET @Ok = NULL
	SET @OkRef = NULL

---------------------------------------------------------------------------------------------------

	DELETE PlanArtMaxMin WHERE Empresa = @Empresa AND Usuario = @Usuario
	SELECT @MovTraspaso1 = MovInv, 
		   @MovTraspaso2 = MovInv2, 
	       @MovCompra = MovComs
	  FROM PlanArtMaxMinCfg WHERE Empresa = @Empresa

---------------------------------------------------------------------------------------------------
		IF ISNULL(@Categoria, '') = '' OR @Categoria = '' OR @Categoria = '(Todos)' OR @Categoria = '0' 
			SET @Categoria = NULL

		IF ISNULL(@Grupo, '') = '' OR @Grupo = '' OR @Grupo = '(Todos)' OR @Grupo = '0' 
			SET @Grupo = NULL

		IF ISNULL(@Familia, '') = '' OR @Familia = '' OR @Familia = '(Todos)' OR @Familia = '0'
			SET @Familia = NULL

		IF ISNULL(@Fabricante, '') = '' OR @Fabricante = '' OR @Fabricante = '(Todos)' OR @Fabricante = '0'
			SET @Fabricante = NULL

		IF ISNULL(@Linea, '') = '' OR @Linea = '' OR @Linea = '(Todos)' OR @Linea = '0'
			SET @Linea = NULL

		IF ISNULL(@Almacen, '') = '' OR @Almacen = '' OR @Almacen = '(Todos)' OR @Almacen = '0'
			SET @Almacen = NULL

		IF ISNULL(@Proveedor, '') = '' OR @Proveedor = '' OR @Proveedor = '(Todos)' OR @Proveedor = '0'
			SET @Proveedor = NULL

---------------------------------------------------------------------------------------------------
	
	DECLARE @Articulos TABLE(ID					int identity(1,1),
							 Sucursal			int				NOT NULL,
							 Articulo			varchar(20)		NOT NULL,
							 SubCuenta			varchar(20)		NOT NULL,
							 Descripcion1		varchar(100)	NULL,
							 Descripcion2		varchar(255)	NULL,
							 NombreCorto		varchar(20)		NULL,
							 Proveedor			varchar(10)		NOT NULL,
							 Nombre				varchar(100)	NOT NULL,
							 Almacen			varchar(10)		NOT NULL,
							 AlmacenNombre		varchar(100)	NOT NULL,
							 Grupo				varchar(50)		NOT NULL,
							 Categoria			varchar(50)		NOT NULL,
							 Familia			varchar(50)		NOT NULL,
							 Linea				varchar(50)		NULL,
							 Fabricante			varchar(50)		NULL,
							 ABC				varchar(1)		NULL,
							 UnidadCompra		varchar(50)		NULL,
							 UnidadTraspaso		varchar(50)		NULL,
							 VentaPromedio		float			NULL,
							 Maximo				float			NULL,
							 Minimo				float			NULL,
							 ----------------------------------------------
							 Existencia			float			NULL,
							 EnCompra			float			NULL,
							 PorRecibir			float			NULL,
							 PorEntregar		float			NULL,
							 Solicitar			float			NULL,
							 CompraDirecta		bit				NULL,
							 CEDIS				bit				NULL,
							 ExisCEDIS			float			NULL
							 ----------------------------------------------
							 )

	--------------------------------------------------------							 
	DECLARE @AlmacenOrigen TABLE(ID				int,
								 Articulo		varchar(20),
								 Subcuenta		varchar(20),
								 Almacen		varchar(10),
								 Maximo			float,
								 Minimo			float,
								 Existencia		float,
								 Solicitar		float
								 )							 
	
   DECLARE @AlmOrigenCursor TABLE(ID			int,
								  Articulo		varchar(20),
								  Subcuenta		varchar(20),
								  Almacen		varchar(10),
								  Maximo		float,
								  Minimo		float,
								  Existencia	float,
								  Solicitar		float
								  )	
	--------------------------------------------------------
	DECLARE @AlmacenDestino TABLE(ID			int,
								  Articulo		varchar(20),
								  Subcuenta		varchar(20),
								  Almacen		varchar(10),
								  Maximo		float,
								  Minimo		float,
								  Existencia	float,
								  Solicitar		float
								  )	
								  
	DECLARE @AlmDestinoCursor TABLE(ID			int,
									Articulo	varchar(20),
									Subcuenta	varchar(20),
									Almacen		varchar(10),
									Maximo		float,
									Minimo		float,
									Existencia	float,
									Solicitar	float
									)							  
	--------------------------------------------------------
									  
	CREATE TABLE #PlanArtMaxMin (ID              int identity(1, 1)	NOT NULL,
								 Empresa         char(5)			NOT NULL,
								 Sucursal        int				NOT NULL,
								 Usuario         varchar(10)		NOT NULL,
								 Estacion        int				NOT NULL,
								 Grupo           varchar(50)		NULL,
								 Categoria       varchar(50)		NULL,
								 Familia         varchar(50)		NULL,
								 Linea           varchar(50)		NULL,
								 Fabricante      varchar(50)		NULL,
								 Proveedor       varchar(10)		NULL,
								 Nombre          varchar(100)		NULL,
								 Almacen         varchar(10)		NOT NULL,
								 AlmacenNombre   varchar(100)		NULL,
								 Articulo        varchar(20)		NOT NULL,
								 SubCuenta       varchar(20)		NOT NULL DEFAULT '',
								 Descripcion1    varchar(100)		NULL,
								 Descripcion2    varchar(255)		NULL,
								 NombreCorto     varchar(20)		NULL,
								 Unidad          varchar(50)		NULL,
								 ABC             varchar(50)		NULL,
								 Maximo          float				NULL,
								 Minimo          float				NULL,
								 VentaPromedio   float				NULL,
								 Precio          float				NULL,
								 ImporteTotal    float				NULL,
								 Existencia      float				NULL,
								 EnCompra        float				NULL,
								 PorRecibir      float				NULL,
								 PorEntregar     float				NULL,
								 Disponible      float				NULL,
								 DiasInvInicio   float				NULL,
								 AlmacenD        varchar(10)		NOT NULL,
								 AlmacenNombreD  varchar(100)		NULL,
								 MaximoD         float				NULL,
								 MinimoD         float				NULL,
								 VentaPromedioD  float				NULL,
								 ExistenciaD     float				NULL,
								 EnCompraD       float				NULL,
								 PorRecibirD     float				NULL,
								 PorEntregarD    float				NULL,
								 DisponibleD     float				NULL,
								 DiasInvD        float				NULL,
								 Solicitar       float				NULL,
								 Cantidad        float				NULL,
								 CantidadA       float				NULL,
								 DiasInvFin      float				NULL,
								 Tipo            varchar(20)		NULL,
								 Movimiento      varchar(20)		NULL,
								 Aplicar         bit				NULL
								CONSTRAINT priPlanArtMaxMin PRIMARY KEY CLUSTERED(ID)
								)
	CREATE NONCLUSTERED INDEX tmpMaxMin ON #PlanArtMaxMin(Articulo, SubCuenta, Almacen, AlmacenD, Sucursal, Empresa)								  					
	
	BEGIN TRY
		INSERT INTO @Articulos(Sucursal, Articulo, SubCuenta, Proveedor, Nombre, Almacen, AlmacenNombre,
							   Grupo, Categoria, Familia, Linea, Fabricante, ABC,
							   UnidadCompra, UnidadTraspaso, VentaPromedio, Maximo, Minimo, CompraDirecta, CEDIS,
							   Descripcion1, Descripcion2, NombreCorto)
						SELECT E.Sucursal, A.Articulo, ISNULL(C.Subcuenta,'') Subcuenta, A.Proveedor, B.Nombre, D.Almacen, D.Nombre,
							   ISNULL(A.Grupo,'') Grupo, ISNULL(A.Categoria,'') Categoria, ISNULL(A.Familia,'') Familia, ISNULL(A.Linea,'') Linea, ISNULL(A.Fabricante, '') Fabricante, ISNULL(C.ABC,'') ABC,
							   ISNULL(A.UnidadCompra, '') UnidadCompra, ISNULL(A.UnidadTraspaso, '') UnidadTraspaso, ISNULL(ROUND(C.VentaPromedio,2),0) VentaPromedio, ISNULL(dbo.fnRedondeaMaxMin(C.Maximo), 0.00) Maximo, ISNULL(dbo.fnRedondeaMaxMin(C.Minimo), 0.00) Minimo, ISNULL(D.CompraDirecta, 0) CompraDirecta, ISNULL(D.CEDIS,0) CEDIS,
							   A.Descripcion1, A.Descripcion2, A.NombreCorto
						  FROM Art A
						  JOIN Prov B ON A.Proveedor = B.Proveedor
						  JOIN ArtAlm C ON A.Articulo = C.Articulo
						  JOIN Alm D ON C.Almacen = D.Almacen
						  JOIN Sucursal E ON D.Sucursal = E.Sucursal
						 WHERE C.Empresa = @Empresa
						   AND A.Estatus = 'Alta'
						   AND (D.Cedis = 1 OR C.Maximo > 0.00)
						   -----------------------------------------
						   AND ISNULL(A.Categoria,'') = ISNULL(@Categoria, ISNULL(A.Categoria,''))
						   AND ISNULL(A.Grupo,'') = ISNULL(@Grupo, ISNULL(A.Grupo,''))
						   AND ISNULL(A.Familia,'') = ISNULL(@Familia, ISNULL(A.Familia,''))
						   AND ISNULL(A.Fabricante,'') = ISNULL(@Fabricante, ISNULL(A.Fabricante,''))
						   AND ISNULL(A.Linea,'') = ISNULL(@Linea, ISNULL(A.Linea,''))
						   AND ISNULL(C.Almacen,'') = ISNULL(@Almacen, ISNULL(C.Almacen,''))
						   AND ISNULL(A.Proveedor,'') = ISNULL(@Proveedor, ISNULL(A.Proveedor,''))
						   
		DECLARE cArticulo CURSOR FOR
		 SELECT ID, Articulo, SubCuenta, Almacen
		   FROM @Articulos
		
		OPEN cArticulo
		FETCH NEXT FROM cArticulo INTO @cID, @cArticulo, @cSubcuenta, @cAlmacen
		WHILE @@FETCH_STATUS = 0
			BEGIN
				SET @Existencia  = 0.00
				SET @EnCompra    = 0.00
				SET @PorRecibir  = 0.00
				SET @PorEntregar = 0.00
				
				------ EXISTENCIA ------
				/*
				SELECT @Existencia = SUM(ISNULL(dbo.fnRedondeaMaxMin(SaldoU), 0.00))
				  FROM SaldoU 
				 WHERE Cuenta = @cArticulo 
				   AND ISNULL(Subcuenta,'') = ISNULL(@cSubcuenta,ISNULL(Subcuenta,''))
				   AND Grupo = @cAlmacen
				   AND Rama <> 'RESV'
				*/
				SELECT @Existencia = Sum(s.SaldoU*r.Factor)
				  FROM SaldoU s
				  JOIN Rama r ON s.Rama=r.Rama 
				 WHERE r.Mayor='INV'
				   AND s.Cuenta = @cArticulo
				   AND ISNULL(s.Subcuenta,'') = ISNULL(@cSubcuenta,ISNULL(Subcuenta,''))
				   AND s.Grupo = @cAlmacen
			  GROUP BY s.Empresa, s.Cuenta, s.Grupo
				
				------ EN COMPRA ------				
				SELECT @EnCompra = ISNULL(SUM(ROUND(d.CantidadPendiente, 0, -1)), 0.00)
				  FROM Compra c
				  JOIN CompraD d ON c.ID = d.ID
				  JOIN MovTipo t ON c.Mov = t.Mov AND t.Modulo = 'COMS'
				  JOIN Art a ON d.Articulo = a.Articulo
				 WHERE c.Empresa = @Empresa
				   AND c.Estatus IN ('PENDIENTE', 'SINAFECTAR')
				   AND t.Clave IN ('COMS.O', 'COMS.R')
				   AND d.CantidadPendiente > 0
				   AND ISNULL(a.Categoria, '') = ISNULL(@Categoria, ISNULL(a.Categoria, ''))
				   AND ISNULL(a.Proveedor, '') = ISNULL(@Proveedor, ISNULL(a.Proveedor, ''))
				   AND d.Articulo = @cArticulo
				   AND ISNULL(d.Subcuenta,'') = ISNULL(@cSubcuenta,ISNULL(d.Subcuenta,''))
				   AND d.Almacen = @cAlmacen
			  GROUP BY d.Almacen, d.Articulo, d.Subcuenta
			  
				------ POR RECIBIR ------				
				SELECT @PorRecibir = ISNULL(SUM(ROUND(d.CantidadPendiente, 0, -1)), 0.00)
				  FROM Inv c
				  JOIN InvD d ON c.ID = d.ID
				  JOIN MovTipo t ON c.Mov = t.Mov AND t.Modulo = 'INV'
				  JOIN Art a ON d.Articulo = a.Articulo
				 WHERE c.Empresa = @Empresa
				   AND c.Estatus = 'PENDIENTE'
				   AND t.Clave IN ('INV.TI', 'INV.OI', 'INV.OT')
				   AND d.CantidadPendiente > 0
				   AND ISNULL(a.Categoria, '') = ISNULL(@Categoria, ISNULL(a.Categoria, ''))
				   AND ISNULL(a.Proveedor, '') = ISNULL(@Proveedor, ISNULL(a.Proveedor, ''))
				   AND ISNULL(c.AlmacenDestino, '') <> ''
				   AND d.Articulo = @cArticulo
				   AND ISNULL(d.Subcuenta,'') = ISNULL(@cSubcuenta,ISNULL(d.Subcuenta,''))
				   AND c.AlmacenDestino = @cAlmacen
			  GROUP BY c.AlmacenDestino, d.Articulo, d.Subcuenta				
				 
				------ POR ENTREGAR ------								 
				SELECT @PorEntregar = ISNULL(SUM(ROUND(d.CantidadPendiente, 0, -1)), 0.00)
				  FROM Inv c
				  JOIN InvD d ON c.ID = d.ID
				  JOIN MovTipo t ON c.Mov = t.Mov AND t.Modulo = 'INV'
				  JOIN Art a ON d.Articulo = a.Articulo
				 WHERE c.Empresa = @Empresa
				   AND c.Estatus = 'PENDIENTE'
				   AND t.Clave IN ('INV.TI', 'INV.OI', 'INV.OT')
				   AND d.CantidadPendiente > 0
				   AND ISNULL(a.Categoria, '') = ISNULL(@Categoria, ISNULL(a.Categoria, ''))
				   AND ISNULL(a.Proveedor, '') = ISNULL(@Proveedor, ISNULL(a.Proveedor, ''))
				   AND ISNULL(c.AlmacenDestino, '') <> ''
				   AND d.Articulo = @cArticulo
				   AND ISNULL(d.Subcuenta,'') = ISNULL(@cSubcuenta,ISNULL(d.Subcuenta,''))
				   AND c.Almacen = @cAlmacen
			  GROUP BY c.Almacen, d.Articulo, d.Subcuenta
				
				UPDATE @Articulos SET Existencia = @Existencia,
									  EnCompra = @EnCompra,
									  PorRecibir = @PorRecibir,
									  PorEntregar = @PorEntregar,
									  ExisCEDIS = CASE WHEN CEDIS = 1 THEN @Existencia ELSE 0.00 END 
				 WHERE ID = @cID
				
				UPDATE @Articulos SET Solicitar = CASE WHEN Maximo > 0 
													   THEN CASE WHEN Maximo-(Existencia+EnCompra+PorRecibir-PorEntregar) <= 0 
															THEN 0 
															ELSE Maximo-(Existencia+EnCompra+PorRecibir-PorEntregar)
														END
													   ELSE 0
												   END
				 WHERE ID = @cID	
				 
				INSERT @AlmacenOrigen(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
							   SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, (A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar, A.Solicitar
							     FROM @Articulos A
							     JOIN RutaDistribucionMaxMin B ON A.Almacen = B.AlmacenOrigen
							    WHERE A.ID = @cID
							      AND A.Existencia > 0
								  AND isnull(A.CompraDirecta,0) = 0
							    UNION
							   SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, (A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar, A.Solicitar
							     FROM @Articulos A
							    WHERE A.ID = @cID
							      AND isnull(A.CompraDirecta,0) = 1
							   EXCEPT
							   SELECT ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar
							     FROM @AlmacenOrigen
							    WHERE Articulo = @cArticulo
							      AND Subcuenta = @cSubcuenta
							      AND Almacen = @cAlmacen
				
				INSERT @AlmacenDestino(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
							    SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, (A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar, A.Solicitar
							      FROM @Articulos A
							      JOIN RutaDistribucionMaxMin B ON A.Almacen = B.AlmacenDestino
							     WHERE A.ID = @cID
							       AND A.Solicitar > 0
							    EXCEPT
							    SELECT ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar
							      FROM @AlmacenDestino
							     WHERE Articulo = @cArticulo
							       AND Subcuenta = @cSubcuenta
							       AND Almacen = @cAlmacen
				
				FETCH NEXT FROM cArticulo INTO @cID, @cArticulo, @cSubcuenta, @cAlmacen
			END
		
		CLOSE cArticulo
		DEALLOCATE cArticulo
	
	------     DISTRIBUCIONES      -----
		DECLARE cDistribucion CURSOR FOR
		 SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen,
				B.ID, B.Articulo, B.Subcuenta, B.Almacen,
				D.EnCompra, D.PorRecibir, D.PorEntregar
		   FROM @AlmacenDestino A
		   JOIN RutaDistribucionMaxMin C ON A.Almacen = C.AlmacenDestino
		   JOIN @AlmacenOrigen B ON B.Almacen = C.AlmacenOrigen 
		    AND A.Articulo = B.Articulo 
		    AND ISNULL(A.Subcuenta,'') = ISNULL(B.Subcuenta,'')
		   JOIN @Articulos D ON A.ID = D.ID
		  WHERE A.Solicitar > 0
		    AND B.Existencia > 0
	   ORDER BY C.Orden
		
		--------------------------------------------------------------------------------------------------------------------
		INSERT @AlmOrigenCursor(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
						 SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, A.Existencia, A.Solicitar
						   FROM @AlmacenOrigen A
						   
		INSERT @AlmDestinoCursor(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
						  SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, A.Existencia, A.Solicitar
							FROM @AlmacenDestino A
		--------------------------------------------------------------------------------------------------------------------
		  
		OPEN cDistribucion
		FETCH NEXT FROM cDistribucion INTO @cDestinoID, @cDestinoArticulo, @cDestinoSubcuenta, @cDestinoAlmacen,
										   @cOrigenID,	@cOrigenArticulo, @cOrigenSubcuenta, @cOrigenAlmacen,
										   @cArtEnCompra, @cArtPorRecibir, @cArtPorEntregar
		
		WHILE @@FETCH_STATUS = 0
			BEGIN
				IF EXISTS(SELECT * FROM Alm A JOIN Alm B ON A.Sucursal = B.Sucursal WHERE A.Almacen = @cDestinoAlmacen AND B.Almacen = @cOrigenAlmacen)
					SET @MovTraspaso = ISNULL(@MovTraspaso2,@MovTraspaso1)
				
				IF NOT EXISTS(SELECT * FROM Alm A JOIN Alm B ON A.Sucursal = B.Sucursal WHERE A.Almacen = @cDestinoAlmacen AND B.Almacen = @cOrigenAlmacen)
					SET @MovTraspaso = @MovTraspaso1
				
				SELECT @cDestinoSolicitar = 0
				SELECT @cOrigenExistencia = 0
				
				SELECT @cDestinoSolicitar = Solicitar FROM @AlmDestinoCursor WHERE ID = @cDestinoID
				SELECT @cOrigenExistencia = Existencia FROM @AlmOrigenCursor WHERE ID = @cOrigenID
				
				IF @cDestinoSolicitar <= @cOrigenExistencia AND @cDestinoSolicitar > 0
					BEGIN
						INSERT #PlanArtMaxMin(Empresa, Sucursal, Usuario, Estacion, Grupo, Categoria, Familia, Linea, 
											  Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo, SubCuenta, Descripcion1,
											  Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio,
											  ImporteTotal, Existencia, EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD,
											  AlmacenNombreD, MaximoD, MinimoD, VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD,
											  DisponibleD, DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento)
								       SELECT @Empresa, A.Sucursal, @Usuario, @Estacion, A.Grupo, A.Categoria, A.Familia, A.Linea,
											  A.Fabricante, A.Proveedor, A.Nombre, A.Almacen, A.AlmacenNombre, A.Articulo, ISNULL(A.SubCuenta,''), A.Descripcion1,
											  A.Descripcion2, A.NombreCorto, A.UnidadTraspaso, A.ABC, A.Maximo, A.Minimo, A.VentaPromedio, 0.00,
											  0.00, (A.Existencia+A.PorEntregar), A.EnCompra, A.PorRecibir, A.PorEntregar, ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar), 
											  CASE WHEN ISNULL(A.VentaPromedio,0.00) > 0 THEN ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar) / ISNULL(A.VentaPromedio,0.00) ELSE 0.00 END, C.Almacen,
											  C.AlmacenNombre, C.Maximo, C.Minimo, C.VentaPromedio, C.Existencia, C.EnCompra, C.PorRecibir, C.PorEntregar,
											  ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar), 
											  CASE WHEN ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar) > 0 AND C.VentaPromedio > 0 THEN ISNULL(((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar),0.00)/ISNULL(C.VentaPromedio,0.00) ELSE 0 END,
											  @cDestinoSolicitar, C.Solicitar, @cDestinoSolicitar, 
											  CASE WHEN C.VentaPromedio > 0 THEN (ISNULL(C.Existencia,0.00)+ISNULL(@cDestinoSolicitar,0.00))/ISNULL(C.VentaPromedio,0.00) ELSE 0 END, 'Distribuir', @MovTraspaso
								         FROM @Articulos A
								         JOIN @AlmacenOrigen B ON A.ID = B.ID
								         JOIN @Articulos C ON A.Articulo = C.Articulo AND ISNULL(A.Subcuenta,'') = ISNULL(C.Subcuenta,'')
								         JOIN @AlmacenDestino D ON C.ID = D.ID
										WHERE A.ID = @cOrigenID
										  AND C.ID = @cDestinoID
													
						UPDATE @AlmOrigenCursor SET Existencia = Existencia - @cDestinoSolicitar WHERE ID = @cOrigenID
						UPDATE @AlmacenOrigen SET Existencia = Existencia - @cDestinoSolicitar WHERE ID = @cOrigenID
						
						UPDATE @AlmDestinoCursor SET Solicitar = Solicitar - @cDestinoSolicitar WHERE ID = @cDestinoID
						UPDATE @AlmacenDestino SET Solicitar = Solicitar - @cDestinoSolicitar WHERE ID = @cDestinoID

						FETCH NEXT FROM cDistribucion INTO @cDestinoID, @cDestinoArticulo, @cDestinoSubcuenta, @cDestinoAlmacen,-- @cDestinoMaximo, @cDestinoMinimo, @cDestinoExistencia, @cDestinoSolicitar,
														   @cOrigenID,	@cOrigenArticulo, @cOrigenSubcuenta, @cOrigenAlmacen,-- @cOrigenMaximo, @cOrigenMinimo, @cOrigenExistencia, @cOrigenSolicitar,
														   @cArtEnCompra, @cArtPorRecibir, @cArtPorEntregar						
						
					END
				
				IF @cDestinoSolicitar > @cOrigenExistencia AND @cDestinoSolicitar > 0
					BEGIN
						INSERT #PlanArtMaxMin(Empresa, Sucursal, Usuario, Estacion, Grupo, Categoria, Familia, Linea, 
											  Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo, SubCuenta, Descripcion1,
											  Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio,
											  ImporteTotal, Existencia, EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD,
											  AlmacenNombreD, MaximoD, MinimoD, VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD,
											  DisponibleD, DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento)
								       SELECT @Empresa, A.Sucursal, @Usuario, @Estacion, A.Grupo, A.Categoria, A.Familia, A.Linea,
											  A.Fabricante, A.Proveedor, A.Nombre, A.Almacen, A.AlmacenNombre, A.Articulo, ISNULL(A.SubCuenta,''), A.Descripcion1,
											  A.Descripcion2, A.NombreCorto, A.UnidadTraspaso, A.ABC, A.Maximo, A.Minimo, A.VentaPromedio, 0.00,
											  0.00, (A.Existencia+A.PorEntregar), A.EnCompra, A.PorRecibir, A.PorEntregar, CASE WHEN ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar) < 0 THEN 0 ELSE ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar) END,
											  CASE WHEN ISNULL(A.VentaPromedio,0.00) > 0 THEN ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar) / ISNULL(A.VentaPromedio,0.00) ELSE 0.00 END, C.Almacen,
											  C.AlmacenNombre, C.Maximo, C.Minimo, C.VentaPromedio, C.Existencia, C.EnCompra, C.PorRecibir, C.PorEntregar,
											  ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar),
											  CASE WHEN ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar) > 0 AND C.VentaPromedio > 0 THEN ISNULL(((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar),0.00)/ISNULL(C.VentaPromedio,0.00) ELSE 0 END, 
											  @cOrigenExistencia, C.Solicitar, @cOrigenExistencia,
											  CASE WHEN C.VentaPromedio > 0 THEN (((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar)+ISNULL(@cOrigenExistencia,0.00))/ISNULL(C.VentaPromedio,0.00) ELSE 0 END, 
											  'Distribuir', @MovTraspaso
								         FROM @Articulos A
								         JOIN @AlmacenOrigen B ON A.ID = B.ID
								         JOIN @Articulos C ON A.Articulo = C.Articulo AND ISNULL(A.Subcuenta,'') = ISNULL(C.Subcuenta,'')
								         JOIN @AlmacenDestino D ON C.ID = D.ID
										WHERE A.ID = @cOrigenID
										  AND C.ID = @cDestinoID
						
						UPDATE @AlmOrigenCursor SET Existencia = Existencia - @cOrigenExistencia WHERE ID = @cOrigenID
						UPDATE @AlmacenOrigen SET Existencia = Existencia - @cOrigenExistencia WHERE ID = @cOrigenID
						
						UPDATE @AlmDestinoCursor SET Solicitar = Solicitar - @cOrigenExistencia WHERE ID = @cDestinoID
						UPDATE @AlmacenDestino SET Solicitar = Solicitar - @cOrigenExistencia WHERE ID = @cDestinoID

						FETCH NEXT FROM cDistribucion INTO @cDestinoID, @cDestinoArticulo, @cDestinoSubcuenta, @cDestinoAlmacen,-- @cDestinoMaximo, @cDestinoMinimo, @cDestinoExistencia, @cDestinoSolicitar,
														   @cOrigenID,	@cOrigenArticulo, @cOrigenSubcuenta, @cOrigenAlmacen,-- @cOrigenMaximo, @cOrigenMinimo, @cOrigenExistencia, @cOrigenSolicitar,
														   @cArtEnCompra, @cArtPorRecibir, @cArtPorEntregar
														   												
					END				
				
			END
		CLOSE cDistribucion
		DEALLOCATE cDistribucion

	------     COMPRAS      -----
		DECLARE cDistribucion CURSOR FOR
		 SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen,
				B.ID, B.Articulo, B.Subcuenta, B.Almacen,
				D.EnCompra, D.PorRecibir, D.PorEntregar
		   FROM @AlmacenDestino A
		   JOIN RutaDistribucionMaxMin C ON A.Almacen = C.AlmacenDestino
		   JOIN @AlmacenOrigen B ON B.Almacen = C.AlmacenOrigen 
		    AND A.Articulo = B.Articulo 
		    AND ISNULL(A.Subcuenta,'') = ISNULL(B.Subcuenta,'')
		   JOIN @Articulos D ON B.ID = D.ID
		  WHERE A.Solicitar > 0
		    AND B.Existencia <= 0
		    AND ISNULL(D.CompraDirecta,0) = 1
	   ORDER BY C.Orden
		
		--------------------------------------------------------------------------------------------------------------------
		DELETE FROM @AlmOrigenCursor
		INSERT @AlmOrigenCursor(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
						 SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, A.Existencia, A.Solicitar
						   FROM @AlmacenOrigen A
		
		DELETE FROM @AlmOrigenCursor				   
		INSERT @AlmDestinoCursor(ID, Articulo, Subcuenta, Almacen, Maximo, Minimo, Existencia, Solicitar)
						  SELECT A.ID, A.Articulo, A.Subcuenta, A.Almacen, A.Maximo, A.Minimo, A.Existencia, A.Solicitar
							FROM @AlmacenDestino A
		--------------------------------------------------------------------------------------------------------------------
		  
		OPEN cDistribucion
		FETCH NEXT FROM cDistribucion INTO @cDestinoID, @cDestinoArticulo, @cDestinoSubcuenta, @cDestinoAlmacen,
										   @cOrigenID,	@cOrigenArticulo, @cOrigenSubcuenta, @cOrigenAlmacen,
										   @cArtEnCompra, @cArtPorRecibir, @cArtPorEntregar
		
		WHILE @@FETCH_STATUS = 0
			BEGIN
			
				SELECT @cDestinoSolicitar = 0
				SELECT @cOrigenExistencia = 0
				
				SELECT @cDestinoSolicitar = Solicitar FROM @AlmDestinoCursor WHERE ID = @cDestinoID
				SELECT @cOrigenExistencia = Existencia FROM @AlmOrigenCursor WHERE ID = @cOrigenID
				
				--IF @cDestinoSolicitar <= @cOrigenExistencia AND @cDestinoSolicitar > 0
					BEGIN
						INSERT #PlanArtMaxMin(Empresa, Sucursal, Usuario, Estacion, Grupo, Categoria, Familia, Linea, 
											  Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo, SubCuenta, Descripcion1,
											  Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio,
											  ImporteTotal, Existencia, EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD,
											  AlmacenNombreD, MaximoD, MinimoD, VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD,
											  DisponibleD, DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento)
								       SELECT @Empresa, A.Sucursal, @Usuario, @Estacion, A.Grupo, A.Categoria, A.Familia, A.Linea,
											  A.Fabricante, A.Proveedor, A.Nombre, A.Almacen, A.AlmacenNombre, A.Articulo, ISNULL(A.SubCuenta,''), A.Descripcion1,
											  A.Descripcion2, A.NombreCorto, A.UnidadTraspaso, A.ABC, A.Maximo, A.Minimo, A.VentaPromedio, 0.00,
											  0.00, (A.Existencia+A.PorEntregar), A.EnCompra, A.PorRecibir, A.PorEntregar, ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar), 
											  CASE WHEN ISNULL(A.VentaPromedio,0.00) > 0 THEN ((A.Existencia+A.PorEntregar)+A.EnCompra+A.PorRecibir-A.PorEntregar) / ISNULL(A.VentaPromedio,0.00) ELSE 0.00 END, C.Almacen,
											  C.AlmacenNombre, C.Maximo, C.Minimo, C.VentaPromedio, C.Existencia, C.EnCompra, C.PorRecibir, C.PorEntregar,
											  ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar), 
											  CASE WHEN ((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar) > 0 AND C.VentaPromedio > 0 THEN ISNULL(((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar),0.00)/ISNULL(C.VentaPromedio,0.00) ELSE 0 END, 
											  @cDestinoSolicitar, C.Solicitar, @cDestinoSolicitar, 
											  CASE WHEN C.VentaPromedio > 0 THEN (((C.Existencia+C.PorEntregar)+C.EnCompra+C.PorRecibir-C.PorEntregar)+ISNULL(@cDestinoSolicitar,0.00))/ISNULL(C.VentaPromedio,0.00) ELSE 0 END,
											  'Comprar', @MovCompra
								         FROM @Articulos A
								         JOIN @AlmacenOrigen B ON A.ID = B.ID
								         JOIN @Articulos C ON A.Articulo = C.Articulo AND ISNULL(A.Subcuenta,'') = ISNULL(C.Subcuenta,'')
								         JOIN @AlmacenDestino D ON C.ID = D.ID
										WHERE A.ID = @cOrigenID
										  AND C.ID = @cDestinoID
													
						UPDATE @AlmOrigenCursor SET Existencia = Existencia - @cDestinoSolicitar WHERE ID = @cOrigenID
						UPDATE @AlmDestinoCursor SET Solicitar = Solicitar - @cDestinoSolicitar WHERE ID = @cOrigenID

						FETCH NEXT FROM cDistribucion INTO @cDestinoID, @cDestinoArticulo, @cDestinoSubcuenta, @cDestinoAlmacen,-- @cDestinoMaximo, @cDestinoMinimo, @cDestinoExistencia, @cDestinoSolicitar,
														   @cOrigenID,	@cOrigenArticulo, @cOrigenSubcuenta, @cOrigenAlmacen,-- @cOrigenMaximo, @cOrigenMinimo, @cOrigenExistencia, @cOrigenSolicitar,
														   @cArtEnCompra, @cArtPorRecibir, @cArtPorEntregar						
						
					END
				
			END
		CLOSE cDistribucion
		DEALLOCATE cDistribucion
		
		--------------------------------------------------------------------------------------------------------------------------
		
		INSERT INTO PlanArtMaxMin (Empresa, Sucursal, Usuario, Estacion, Grupo, Categoria, Familia, Linea, 
								   Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo, SubCuenta, Descripcion1,
								   Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio, ImporteTotal, Existencia, 
								   EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD, AlmacenNombreD, MaximoD, MinimoD, 
								   VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD, DisponibleD, 
								   DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento, Aplicar)
				            SELECT Empresa, Sucursal, Usuario, Estacion, Grupo, Categoria, Familia, Linea,
								   Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo, SubCuenta, Descripcion1,
								   Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio, ImporteTotal, Existencia,
								   EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD, AlmacenNombreD, MaximoD, MinimoD,
								   VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD, DisponibleD,
								   DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento, 0
							  FROM #PlanArtMaxMin
		
		
		SELECT @OkRef = 'Proceso Completado'
				
	END TRY
	
	BEGIN CATCH
		SET @OkRef = ERROR_MESSAGE()
	END CATCH
	
	SELECT @OkRef

END
GO

/*************************  spPlanArtInfo  ************************/
IF EXISTS(SELECT * FROM sysobjects WHERE name ='spPlanArtInfo' AND type = 'P')  DROP PROCEDURE spPlanArtInfo
GO
CREATE PROCEDURE spPlanArtInfo(
	  @Empresa      varchar(5),
	  @Articulo     varchar(20)
	)
--//WITH ENCRYPTION
AS BEGIN
		SET NOCOUNT ON

		DECLARE @Concepto               varchar(255),
				@Valor                  varchar(255),
				@CompraID               int,
				@CompraDevID            int,
				@VentaID                int,
				@VentaDevID             int,
				@CompraMov              varchar(20),
				@CompraMovID            varchar(20),
				@CompraDevMov           varchar(20),
				@CompraDevMovID         varchar(20),
				@VentaMov               varchar(20),
				@VentaMovID             varchar(20),
				@VentaDevMov            varchar(20),
				@VentaDevMovID          varchar(20),
				@Referencia             varchar(50),
				@FechaCompra            datetime,
				@FechaPrimerVenta       datetime,
				@FechaUltimaVenta       datetime,
				@Moneda                 varchar(20),
				@TipoCambio             float,
				@Proveedor              varchar(10),
				@AlmacenCompra          varchar(10),
				@Sucursal               int,
				@Cantidad               float,
				@Aplica                 varchar(20),
				@AplicaID               varchar(20),
				@Unidad                 varchar(50),
				@Factor                 float,
				@CostoPromedio          float,
				@PrecioCosto            float,
				@PrecioPublico          float,
				@Margen                 float,
				@AlmacenPrincipal       varchar(10),
				@InventarioBodegas      float,
				@InventarioTiendas      float,
				@Estatus                varchar(15)
				
		DECLARE	@Compra                 table (Clave varchar(20) NULL)
		DECLARE	@CompraDev              table (Clave varchar(20) NULL)
		DECLARE @Venta                  table (Clave varchar(20) NULL)
		DECLARE @VentaDev               table (Clave varchar(20) NULL)
		DECLARE @Tabla					table (ID		int IDENTITY (1, 1) NOT NULL, 
											   Concepto varchar(255) NULL,
											   Valor    varchar(255) NULL)

		-- Claves afectacion compras (Empresa = VHA)        -- Movimientos
		INSERT INTO @Compra(Clave)      VALUES ('COMS.F')   -- Compra ActivoFijo - Entrada Compra - Entrada Consignacion
		INSERT INTO @Compra(Clave)      VALUES ('COMS.CC')  -- Compra Consignacion
		INSERT INTO @Compra(Clave)      VALUES ('COMS.FL')  -- Compra Local
		INSERT INTO @Compra(Clave)      VALUES ('COMS.OP')  -- Compra Prorrateada
		INSERT INTO @CompraDev(Clave)   VALUES ('COMS.D')   -- Cancelacion Compra - Devolucion Compra

		-- Claves afectacion ventas (Empresa = VHA)         -- Movimientos
		INSERT INTO @Venta(Clave)       VALUES ('VTAS.F')   -- AsignaTarjeta - Factura - Factura Flexible - Factura Prorrateada - Nota Cargo
		INSERT INTO @Venta(Clave)       VALUES ('VTAS.FM')  -- Factura Mostrador
		INSERT INTO @Venta(Clave)       VALUES ('VTAS.FR')  -- Factura Recurrente
		INSERT INTO @Venta(Clave)       VALUES ('VTAS.VCR') -- Remision
		INSERT INTO @Venta(Clave)       VALUES ('VTAS.VC')  -- Venta Consignacion

		INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.D')   -- Cancelacion Factura - Devolucion Venta
		INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.DC')  -- Dev. Venta Consig.
		INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.DCR') -- Devolucion Remision

		SET @Estatus = 'CONCLUIDO'

		SELECT @CompraID = MAX(c.ID)
		  FROM Compra c
		  JOIN CompraD d ON c.ID = d.id 
		  JOIN MovTipo m ON c.Mov = m.Mov
		  JOIN @Compra t ON t.Clave = m.Clave
		 WHERE c.Empresa = @Empresa AND c.Estatus = @Estatus AND d.Articulo = @Articulo

		SELECT @CompraMov = c.Mov,
			   @CompraMovID = c.MovID,
			   @Referencia = c.Referencia,
			   @FechaCompra = FechaEmision,
			   @Moneda = c.Moneda,
			   @TipoCambio = ISNULL(c.TipoCambio,1),
			   @Proveedor     = c.Proveedor,
			   @AlmacenCompra = c.Almacen,
			   @Sucursal = c.Sucursal
		  FROM Compra c
		 WHERE c.ID = @CompraID

		SELECT @Aplica = Aplica, @AplicaID = AplicaID, @Unidad = Unidad, @Factor =  Factor
		  FROM CompraD
		 WHERE ID = @CompraID

		SELECT @VentaID = MIN(d.ID)
		  FROM VentaD d
		  JOIN Venta v ON d.ID = v.ID
		  JOIN MovTipo m ON v.Mov = m.Mov
		  JOIN @Venta mv ON m.Clave = mv.Clave
		 WHERE v.Empresa  = @Empresa AND v.Estatus  = @Estatus AND d.Articulo = @Articulo

		SELECT @FechaPrimerVenta = FechaEmision FROM Venta WHERE ID = @VentaID

		SELECT @VentaID = MAX(d.ID)
		  FROM VentaD d
		  JOIN Venta v ON (d.ID = v.ID)
		  JOIN MovTipo m ON(v.Mov = m.Mov)
		  JOIN @Venta mv ON(m.Clave = mv.Clave)
		 WHERE v.Empresa  = @Empresa
		   AND v.Estatus  = @Estatus
		   AND d.Articulo = @Articulo
		   --AND m.Clave IN (SELECT Clave FROM @Venta)

		SELECT @FechaUltimaVenta = FechaEmision FROM Venta WHERE ID = @VentaID

		SET @Concepto = 'Ultima compra'		
		SELECT @Valor =  @CompraMov + ' ' + @CompraMovID

		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Aplica'
		SET @Valor = ''
		SELECT @Valor = @Aplica + ' ' + @AplicaID
		SET @Valor = ISNULL(@Valor,'')
		
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Fecha'
		SELECT @Valor = CONVERT(varchar(255),@FechaCompra,103)
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Referencia'
		SELECT @Valor = @Referencia
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Proveedor'
		SET @Valor = ''
		SELECT @Valor = ISNULL(Proveedor,'') FROM Prov WHERE Proveedor = @Proveedor
		SET @Valor = ISNULL(@Valor,'')
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Nombre Proveedor'
		SET @Valor = ''
		SELECT @Valor = ISNULL(Nombre,'') FROM Prov WHERE Proveedor = @Proveedor
		SET @Valor = ISNULL(@Valor,'')
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Cantidad'
		SELECT @Cantidad = SUM(d.Cantidad)
		  FROM CompraD d
		  JOIN Compra c ON d.ID = c.ID
		  JOIN MovTipo m ON(c.Mov = m.Mov)
		 WHERE c.Empresa = @Empresa
		   AND d.Articulo = @Articulo
		   AND c.Estatus = @Estatus
		   AND m.Clave IN (SELECT Clave FROM @Compra)
		   AND d.ID = @CompraID

		SET @Cantidad = ISNULL(@Cantidad,0)
		SELECT @Valor = CAST(@Cantidad AS varchar(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Unidad'
		SET @Valor = ''
		SELECT @Valor = @Unidad
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Factor'
		SET @Valor = ''
		SELECT @Valor = @Factor
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Precio'
		SELECT @PrecioCosto = @TipoCambio * ISNULL(d.Costo,0)
		  FROM CompraD d
		  JOIN Compra c ON d.ID = c.ID
		 WHERE d.ID       = @CompraID
		   AND d.Articulo = @Articulo
		   AND c.Empresa  = @Empresa
		SET @Valor = CAST(@PrecioCosto AS varchar(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Costo promedio'
		SELECT @CostoPromedio = CostoPromedio FROM ArtCostoEmpresa WHERE Empresa = @Empresa AND Articulo = @Articulo
		SET @CostoPromedio = ISNULL (@CostoPromedio,0)
		SET @Valor = CAST(@CostoPromedio AS varchar(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Precio público'
		SELECT @PrecioPublico = ISNULL(PrecioLista,0) FROM Art WHERE Articulo = @Articulo
		SET @PrecioPublico = ISNULL(@PrecioPublico,0)
		SET @Valor = CAST(@PrecioPublico AS varchar(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Margen'
		IF @PrecioPublico > 0
		  SET @Margen = @CostoPromedio / @PrecioPublico
		ELSE
		  SET @Margen = 0
		SELECT @Valor = CAST(@Margen AS varchar(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Inventario bodegas'
		SELECT @InventarioBodegas = SUM(Disponible)
		  FROM ArtDisponible
		 WHERE Empresa = @Empresa
		   AND Articulo = @Articulo
		   AND Almacen IN (SELECT AlmacenOrigen
							 FROM RutaDistribucionMaxMin GROUP BY AlmacenOrigen)
		SELECT @Valor = CAST(@InventarioBodegas AS VARCHAR(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Inventario tiendas'
		SELECT @InventarioTiendas = SUM(disponible)
		  FROM ArtDisponible
		 WHERE Empresa = @Empresa
		   AND Articulo = @Articulo
		   AND Almacen IN (SELECT AlmacenDestino
							 FROM RutaDistribucionMaxMin GROUP BY AlmacenDestino)

		SELECT @Valor = ''
		SELECT @Valor = CAST(@InventarioTiendas AS VARCHAR(255))
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Primer venta tienda'
		SELECT @Valor = ''
		SELECT @Valor = CONVERT(varchar(255),@FechaPrimerVenta,103)
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SET @Concepto = 'Ultima venta tienda'
		SELECT @Valor = ''
		SELECT @Valor = CONVERT(varchar(255),@FechaUltimaVenta,103)
		INSERT INTO @Tabla(Concepto,Valor) VALUES (@Concepto,@Valor)

		SELECT Concepto,Valor FROM @Tabla ORDER BY ID
END
GO

/*************************  spPlanArtMaxMin  ************************/

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMin' AND Type = 'P')  DROP PROCEDURE spPlanArtMaxMin
GO
CREATE PROCEDURE spPlanArtMaxMin(
  @Empresa              varchar(5),
  @Sucursal             int,
  @Usuario              varchar(10),
  @Estacion             int,
  @Buscar               varchar(20),
  @Categoria            varchar(50),
  @Grupo                varchar(50),
  @Familia              varchar(50),
  @Linea                varchar(50),
  @Fabricante           varchar(50),
  @Proveedor            varchar(50),
  @Almacen              varchar(50)
  )
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

DECLARE @NoEspecificado char(15)
DECLARE @q              nvarchar(max)            -- consulta
DECLARE @a              char(1)                  -- asterisco
DECLARE @p              char(1)                  -- porciento
DECLARE @c              char(1)                  -- comilla
DECLARE @r              char(1)                  -- retorno

DECLARE @TablaRet table(
  [ID]                  int          NULL,
  [Empresa]             varchar(5)   NULL,
  [Sucursal]            int          NULL,
  [Usuario]             varchar(10)  NULL,
  [Estacion]            int          NULL,
  [Grupo]               varchar(50)  NULL,
  [Categoria]           varchar(50)  NULL,
  [Familia]             varchar(50)  NULL,
  [Linea]               varchar(50)  NULL,
  [Fabricante]          varchar(50)  NULL,
  [Proveedor]           varchar(10)  NULL,
  [Nombre]              varchar(100) NULL,
  [Almacen]             varchar(10)  NULL,
  [AlmacenNombre]       varchar(100) NULL,
  [Articulo]            varchar(20)  NULL,
  [SubCuenta]           varchar(50)  NULL,
  [Descripcion1]        varchar(100) NULL,
  [Descripcion2]        varchar(255) NULL,
  [NombreCorto]         varchar(20)  NULL,
  [Unidad]              varchar(50)  NULL,
  [ABC]                 varchar(5)   NULL,
  [Maximo]              float        NULL,
  [Minimo]              float        NULL,
  [VentaPromedio]       float        NULL,
  [Precio]              float        NULL,
  [ImporteTotal]        float        NULL,
  [Existencia]          float        NULL,
  [EnCompra]            float        NULL,
  [PorRecibir]          float        NULL,
  [PorEntregar]         float        NULL,
  [Disponible]          float        NULL,
  [DiasInvInicio]       float        NULL,
  [AlmacenD]            varchar(10)  NULL,
  [AlmacenNombreD]      varchar(100) NULL,
  [MaximoD]             float        NULL,
  [MinimoD]             float        NULL,
  [VentaPromedioD]      float        NULL,
  [ExistenciaD]         float        NULL,
  [EnCompraD]           float        NULL,
  [PorRecibirD]         float        NULL,
  [PorEntregarD]        float        NULL,
  [DisponibleD]         float        NULL,
  [DiasInvD]            float        NULL,
  [Solicitar]           float        NULL,
  [Cantidad]            float        NULL,
  [CantidadA]           float        NULL,
  [DiasInvFin]          float        NULL,
  [Tipo]                varchar(20)  NULL,
  [Movimiento]          varchar(20)  NULL,
  [Aplicar]             int          NULL        -- Se cambia de bit a int para poder enlazar a DataGridView
)

SET @Empresa           = LTRIM(RTRIM(ISNULL(@Empresa,'')))
SET @Sucursal          = ISNULL(@Sucursal,0)
SET @Usuario           = LTRIM(RTRIM(ISNULL(@Usuario,'')))
SET @Estacion          = ISNULL(@Estacion,0)
SET @Buscar            = LTRIM(RTRIM(ISNULL(@Buscar,'')))
SET @Categoria         = LTRIM(RTRIM(ISNULL(@Categoria,'')))
SET @Grupo             = LTRIM(RTRIM(ISNULL(@Grupo,'')))
SET @Familia           = LTRIM(RTRIM(ISNULL(@Familia,'')))
SET @Linea             = LTRIM(RTRIM(ISNULL(@Linea,'')))
SET @Fabricante        = LTRIM(RTRIM(ISNULL(@Fabricante,'')))
SET @Proveedor         = LTRIM(RTRIM(ISNULL(@Proveedor,'')))
SET @Almacen           = LTRIM(RTRIM(ISNULL(@Almacen,'')))
SET @NoEspecificado    = 'No especificado'

SET @a = CHAR(42)
SET @p = CHAR(37)
SET @c = CHAR(39)
SET @r = CHAR(13)

SET @q = N'
DECLARE @TablaTmp table(
  [ID]                  int          NULL,
  [Empresa]             varchar(5)   NULL,
  [Sucursal]            int          NULL,
  [Usuario]             varchar(10)  NULL,
  [Estacion]            int          NULL,
  [Grupo]               varchar(50)  NULL,
  [Categoria]           varchar(50)  NULL,
  [Familia]             varchar(50)  NULL,
  [Linea]               varchar(50)  NULL,
  [Fabricante]          varchar(50)  NULL,
  [Proveedor]           varchar(10)  NULL,
  [Nombre]              varchar(100) NULL,
  [Almacen]             varchar(10)  NULL,
  [AlmacenNombre]       varchar(100) NULL,
  [Articulo]            varchar(20)  NULL,
  [SubCuenta]           varchar(50)  NULL,
  [Descripcion1]        varchar(100) NULL,
  [Descripcion2]        varchar(255) NULL,
  [NombreCorto]         varchar(20)  NULL,
  [Unidad]              varchar(50)  NULL,
  [ABC]                 varchar(5)   NULL,
  [Maximo]              float        NULL,
  [Minimo]              float        NULL,
  [VentaPromedio]       float        NULL,
  [Precio]              float        NULL,
  [ImporteTotal]        float        NULL,
  [Existencia]          float        NULL,
  [EnCompra]            float        NULL,
  [PorRecibir]          float        NULL,
  [PorEntregar]         float        NULL,
  [Disponible]          float        NULL,
  [DiasInvInicio]       float        NULL,
  [AlmacenD]            varchar(10)  NULL,
  [AlmacenNombreD]      varchar(100) NULL,
  [MaximoD]             float        NULL,
  [MinimoD]             float        NULL,
  [VentaPromedioD]      float        NULL,
  [ExistenciaD]         float        NULL,
  [EnCompraD]           float        NULL,
  [PorRecibirD]         float        NULL,
  [PorEntregarD]        float        NULL,
  [DisponibleD]         float        NULL,
  [DiasInvD]            float        NULL,
  [Solicitar]           float        NULL,
  [Cantidad]            float        NULL,
  [CantidadA]           float        NULL,
  [DiasInvFin]          float        NULL,
  [Tipo]                varchar(20)  NULL,
  [Movimiento]          varchar(20)  NULL,
  [Aplicar]             bit          NULL
)
'
SET @q = @q + @r + 'INSERT INTO @TablaTmp('
SET @q = @q + @r + '  [ID], [Empresa], [Sucursal], [Estacion], [Usuario],'
SET @q = @q + @r + '  [Grupo], [Categoria], [Familia], [Linea], [Fabricante],'
SET @q = @q + @r + '  [Proveedor], [Nombre], [Almacen], [AlmacenNombre], [Articulo],'
SET @q = @q + @r + '  [SubCuenta], [Descripcion1], [Descripcion2], [NombreCorto], [Unidad],'
SET @q = @q + @r + '  [ABC], [Maximo], [Minimo], [VentaPromedio], [Precio],'
SET @q = @q + @r + '  [ImporteTotal], [Existencia], [EnCompra], [PorRecibir], [PorEntregar],'
SET @q = @q + @r + '  [Disponible], [DiasInvInicio], [AlmacenD], [AlmacenNombreD], [MaximoD],'
SET @q = @q + @r + '  [MinimoD], [VentaPromedioD], [ExistenciaD], [EnCompraD], [PorRecibirD],'
SET @q = @q + @r + '  [PorEntregarD], [DisponibleD], [DiasInvD], [Solicitar], [Cantidad],'
SET @q = @q + @r + '  [CantidadA], [DiasInvFin], [Tipo], [Movimiento], [Aplicar]'
SET @q = @q + @r + ')'
SET @q = @q + @r + 'SELECT'
SET @q = @q + @r + '  [ID], [Empresa], [Sucursal], [Estacion], [Usuario],'
SET @q = @q + @r + '  [Grupo], [Categoria], [Familia], [Linea], [Fabricante],'
SET @q = @q + @r + '  [Proveedor], [Nombre], [Almacen], [AlmacenNombre], [Articulo],'
SET @q = @q + @r + '  [SubCuenta], [Descripcion1], [Descripcion2], [NombreCorto], [Unidad],'
SET @q = @q + @r + '  [ABC], [Maximo], [Minimo], [VentaPromedio], [Precio],'
SET @q = @q + @r + '  [ImporteTotal], [Existencia], [EnCompra], [PorRecibir], [PorEntregar],'
SET @q = @q + @r + '  [Disponible], [DiasInvInicio], [AlmacenD], [AlmacenNombreD], [MaximoD],'
SET @q = @q + @r + '  [MinimoD], [VentaPromedioD], [ExistenciaD], [EnCompraD], [PorRecibirD],'
SET @q = @q + @r + '  [PorEntregarD], [DisponibleD], [DiasInvD], [Solicitar], [Cantidad],'
SET @q = @q + @r + '  [CantidadA], [DiasInvFin], [Tipo], [Movimiento], [Aplicar]'
SET @q = @q + @r + '  FROM PlanArtMaxMin WHERE Empresa = ' + @c + @Empresa + @c
SET @q = @q + @r + '   AND Usuario = ' + @c + @Usuario + @c
SET @q = @q + @r + '   AND Estacion = ' +  CAST(@Estacion AS varchar)

IF LEN(@Categoria) > 0
  BEGIN
    IF @Categoria = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Categoria,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Categoria = ' + @c + @Categoria + @c
  END

IF LEN(@Grupo) > 0
  BEGIN
    IF @Grupo = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Grupo,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Grupo = ' + @c + @Grupo + @c
  END

IF LEN(@Familia) > 0
  BEGIN
    IF @Familia = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Familia,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Familia = ' + @c + @Familia + @c
  END

IF LEN(@Linea) > 0
  BEGIN
    IF @Linea = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Linea,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Linea = ' + @c + @Linea + @c
  END

IF LEN(@Fabricante) > 0
  BEGIN
    IF @Fabricante = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Fabricante,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Fabricante = ' + @c + @Fabricante + @c
  END

IF LEN(@Proveedor) > 0
  BEGIN
    IF @Proveedor = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Proveedor,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Proveedor = ' + @c + @Proveedor + @c
  END

IF LEN(@Almacen) > 0
  BEGIN
    IF @Almacen = @NoEspecificado
      SET @q = @q + @r + 'AND LTRIM(RTRIM(ISNULL(Almacen,' + @c + @c +'))) = ' + @c + @c
    ELSE
      SET @q = @q + @r + 'AND Almacen = ' + @c + @Almacen + @c
  END

IF LEN(@Buscar) > 0
  BEGIN
    IF CHARINDEX(@a,@Buscar) = 0
      BEGIN
        SET @q = @q + @r + 'AND (Articulo      = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Descripcion1    = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Descripcion2    = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR NombreCorto     = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Grupo           = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Categoria       = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Familia         = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Linea           = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Fabricante      = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Proveedor       = ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Nombre          = ' + @c + @Buscar + @c + ')'
      END
    ELSE
      BEGIN
        SET @Buscar = REPLACE(@Buscar,@a,@p)
        SET @q = @q + @r + 'AND (Articulo   LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Descripcion1 LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Descripcion2 LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR NombreCorto  LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Grupo        LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Categoria    LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Familia      LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Linea        LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Fabricante   LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Proveedor    LIKE ' + @c + @Buscar + @c
        SET @q = @q + @r + 'OR Nombre       LIKE ' + @c + @Buscar + @c + ')'
      END
  END

SET @q = @q + @r + @r + 'SELECT * FROM @TablaTmp'

INSERT INTO @TablaRet EXEC sp_executesql @q

SELECT ID, Empresa, Sucursal, Usuario, Estacion,
       Grupo, Categoria, Familia, Linea, Fabricante,
       Proveedor, Nombre, Articulo, SubCuenta, Descripcion1,
       Descripcion2, NombreCorto, Unidad, ABC, Almacen,
       AlmacenNombre, Maximo, Minimo, VentaPromedio, Precio,
       ImporteTotal, Existencia, EnCompra, PorRecibir, PorEntregar,
       Disponible, DiasInvInicio, AlmacenD, AlmacenNombreD, MaximoD,
       MinimoD, VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD,
       PorEntregarD, DisponibleD, DiasInvD, Solicitar, Cantidad,
       CantidadA, DiasInvFin, Tipo, Movimiento, Aplicar
  FROM @TablaRet
ORDER BY Almacen, Articulo, SubCuenta, AlmacenD

SET NOCOUNT OFF
END
GO

/*************************  spPlanArtMaxMinProcesar  ************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtMaxMinProcesar' AND Type = 'P')  DROP PROCEDURE spPlanArtMaxMinProcesar
GO
CREATE PROCEDURE spPlanArtMaxMinProcesar(
	  @Empresa                   varchar(5),
	  @Sucursal                  int,
	  @Usuario                   varchar(10),
	  @Estacion                  int
)
--//WITH ENCRYPTION
AS BEGIN

DECLARE
	  @SPID                      varchar(20),
	  @FechaHoy                  datetime,
	  @Cuenta                    int,
	  @GeneradosDistribuir       int,
	  @GeneradosComprar          int,
	  @MovIdLog                  varchar(20),
	  @EstatusLog                varchar(15),
	  @TipoMovimiento            varchar(20),
	  @Movimiento                varchar(20),
	  @Observacion               varchar(4000),
	  @Mensaje                   varchar(4000),
	  @Almacen                   varchar(10),
	  @AlmacenDestino            varchar(10),
	  @ArtTipo                   varchar(20),
	  @AlmacenCr                 varchar(10),
	  @ProveedorCr               varchar(10),
	  @Corrida                   int,
	  @SucursalLog               int,
	  @idx                       int,
	  @MovEstatus                varchar(15),
	  @MovConsecutivo            bit,
	  @MovReservar               bit,
	  ---SpAfectar
	  @Modulo                    varchar(5),
	  @Accion                    varchar(20),
	  @Base                      varchar(20),
	  @GenerarMov                varchar(20),
	  @SincroFinal               bit,
	  @EnSilencio                bit,
	  @Conexion                  bit,
	  @Ok                        int,
	  @OkRef                     varchar(255),
	  @FechaRegistro             datetime,
	 ---INV
	  @ID                        int,
	  @Mov                       varchar(20),
	  @MovID                     varchar(20),
	  @FechaEmision              datetime,
	  @Proyecto                  varchar(50),
	  @Moneda                    varchar(10),
	  @TipoCambio                float,
	  @Concepto                  varchar(50),
	  @Referencia                varchar(50),
	  @DocFuente                 int,
	  @Observaciones             varchar(100),
	  @Estatus                   varchar(15),
	  @Situacion                 varchar(50),
	  @SituacionFecha            datetime,
	  @SituacionUsuario          varchar(10),
	  @SituacionNota             varchar(100),
	  @Directo                   bit,
	  @RenglonID                 int,
	  @AlmacenTransito           varchar(10),
	  @Largo                     bit,
	  @Condicion                 varchar(50),
	  @Vencimiento               datetime,
	  @FormaEnvio                varchar(50),
	  @Autorizacion              varchar(10),
	  @OrigenTipo                varchar(10),
	  @Origen                    varchar(20),
	  @OrigenID                  varchar(20),
	  @Poliza                    varchar(20),
	  @PolizaID                  varchar(20),
	  @FechaConclusion           datetime,
	  @FechaCancelacion          datetime,
	  @FechaOrigen               datetime,
	  @FechaRequerida            datetime,
	  @Peso                      float,
	  @Volumen                   float,
	  @SucursalOrigen            int,
	  @VerLote                   bit,
	  @UEN                       int,
	  @VerDestino                bit,
	  @Personal                  varchar(10),
	  @Conteo                    int,
	  @Agente                    varchar(10),
	  @ACRetencion               float,
	  @SubModulo                 varchar(5),
	  @Motivo                    varchar(8),
	  @ReferenciaMES             varchar(50),
	  @PedidoMES                 varchar(50),
	  @Serie                     varchar(3),
	  @IDMES                     int,
	  @IDMarcaje                 int,
	  @MovMES                    bit,
	  @Actividad                 varchar(100),
	  @PedimentoExtraccion       varchar(50),
	  @PosicionWMS               varchar(10),
	  @PosicionDWMS              varchar(10),
	  @SucursalDestino           int,
	  ---INVD
	  @Renglon                   float,
	  @RenglonSub                int,
	  @RenglonTipo               char(1),
	  @Cantidad                  float,
	  @Codigo                    varchar(30),
	  @Articulo                  varchar(20),
	  @ArticuloDestino           varchar(20),
	  @SubCuenta                 varchar(50),
	  @SubCuentaDestino          varchar(50),
	  @Costo                     money,
	  @CostoInv                  money,
	  @ContUso                   varchar(20),
	  @Espacio                   varchar(10),
	  @CantidadA                 float,
	  @Paquete                   int,
	  @Aplica                    varchar(20),
	  @AplicaID                  varchar(20),
	  @DestinoTipo               varchar(10),
	  @Destino                   varchar(20),
	  @DestinoID                 varchar(20),
	  @Cliente                   varchar(10),
	  @DefUnidad                 varchar(50),
	  @Unidad                    varchar(50),
	  @Factor                    float,
	  @CantidadInventario        float,
	  @ProdSerieLote             varchar(50),
	  @Merma                     float,
	  @Desperdicio               float,
	  @Producto                  varchar(20),
	  @SubProducto               varchar(20),
	  @Tipo                      varchar(20),
	  @Precio                    money,
	  @SegundoConteo             float,
	  @DescripcionExtra          varchar(100),
	  @Posicion                  varchar(10),
	  ---COMPRA
	  @UltimoCambio              datetime,
	  @Prioridad                 varchar(10),
	  @Proveedor                 varchar(10),
	  @FechaEntrega              datetime,
	  @Manejo                    money,
	  @Fletes                    money,
	  @Instruccion               varchar(50),
	  @Descuento                 varchar(30),
	  @DescuentoH                varchar(30),
	  @DescuentoGlobal           float,
	  @Importe                   money,
	  @Impuestos                 money,
	  @DescuentoLineal           money,
	  @Atencion                  varchar(50),
	  @Causa                     varchar(50),
	  @ZonaImpuesto              varchar(30),
	  @Idioma                    varchar(50),
	  @ListaPreciosEsp           varchar(20),
	  @FormaEntrega              varchar(50),
	  @CancelarPendiente         bit,
	  @LineaCredito              varchar(20),
	  @TipoAmortizacion          varchar(20),
	  @TipoTasa                  varchar(20),
	  @Comisiones                money,
	  @ComisionesIVA             money,
	  @VIN                       varchar(20),
	  @AutoCargos                float,
	  @TieneTasaEsp              bit,
	  @TasaEsp                   float,
	  ---COMPRAD
	  @FechaOrdenar              datetime,
	  @Impuesto1                 float,
	  @Impuesto2                 float,
	  @Impuesto3                 float,
	  @DescuentoTipo             char(1),
	  @DescuentoLinea            money,
	  @DescuentoImporte          money,
	  @ReferenciaExtra           varchar(50),
	  @ServicioArticulo          varchar(20),
	  @ServicioSerie             varchar(20),
	  @ImportacionProveedor      varchar(10),
	  @ImportacionReferencia     varchar(50),
	  @Retencion1                float,
	  @Retencion2                float,
	  @Retencion3                float,
	  @FechaCaducidad            datetime,
	  @ProveedorArt              varchar(10),
	  @ProveedorArtCosto         float,
	  @Pais                      varchar(50),
	  @TratadoComercial          varchar(50),
	  @ProgramaSectorial         varchar(50),
	  @ValorAduana               money,
	  @ID1                       char(2),
	  @ID2                       char(2),
	  @FormaPago                 varchar(50),
	  @ImportacionImpuesto1      float,
	  @ImportacionImpuesto2      float,
	  @EsEstadistica             bit,
	  @CfgCompraCostoSugerido    varchar(20),
	  @MultiUnidad               varchar(20)

	SET @Empresa  = UPPER(LTRIM(RTRIM(ISNULL(@Empresa,''))))
	SET @Sucursal = UPPER(LTRIM(RTRIM(ISNULL(@Sucursal,''))))
	SET @Usuario  = UPPER(LTRIM(RTRIM(ISNULL(@Usuario,''))))
	SET @Estacion = ISNULL(@Estacion,1)

	SET @SucursalLog = @Sucursal

	SELECT @CfgCompraCostoSugerido = CompraCostoSugerido FROM EmpresaCfg WHERE Empresa = @Empresa

	SET @FechaHoy = GETDATE()
	SET @GeneradosDistribuir = 0
	SET @GeneradosComprar = 0
	SET @MovEstatus = 'PENDIENTE'
	SET @MovConsecutivo = 0
	SET @MovReservar = 1

	SET @SPID = LTRIM(RTRIM(CAST(@@SPID AS varchar)))

	SELECT @Corrida = MAX(Corrida) FROM PlanArtMaxMinHist
	SET @Corrida = ISNULL(@Corrida,0) + 1

	SELECT @MultiUnidad = NivelFactorMultiUnidad FROM EmpresaCFG2 WHERE Empresa = @Empresa
	SELECT @Moneda = DefMoneda,@UEN = UEN FROM Usuario WHERE Usuario = @Usuario
	SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
	SELECT @DefUnidad = ISNULL(DefUnidad,'pza') FROM EmpresaGral WHERE Empresa = @Empresa

	SET @ID = NULL
	SET @MovID = NULL
	SET @FechaEmision = dbo.fnFechaSinHora(@FechaHoy)
	SET @UltimoCambio = @FechaHoy
	SET @Proyecto = NULL
	SET @Concepto = 'Traspaso entre sucursales'
	SET @Referencia = NULL
	SET @DocFuente = NULL
	SET @Observaciones = 'Para Surtir Almacen'
	SET @Estatus = 'SINAFECTAR'
	SET @Situacion = NULL
	SET @SituacionFecha = NULL
	SET @SituacionUsuario = NULL
	SET @SituacionNota = NULL
	SET @Directo = 1
	SET @RenglonID = NULL
	SET @AlmacenDestino = NULL
	SET @AlmacenTransito = '(TRANSITO)'
	SET @Largo = 0
	SET @Condicion = NULL
	SET @Vencimiento = @FechaEmision
	SET @FormaEnvio = NULL
	SET @Autorizacion = NULL
	SET @OrigenTipo = NULL
	SET @Origen = NULL
	SET @OrigenID = NULL
	SET @Poliza = NULL
	SET @PolizaID = NULL
	SET @FechaConclusion = NULL
	SET @FechaCancelacion = NULL
	SET @FechaOrigen = NULL
	SET @FechaRequerida = @FechaEmision
	SET @Peso = NULL
	SET @Volumen = NULL
	SET @VerLote = 0
	SET @VerDestino = 0
	SET @Personal = NULL
	SET @Conteo = NULL
	SET @Agente = @Usuario
	SET @ACRetencion = NULL
	SET @SubModulo = 'INV'
	SET @Motivo = NULL
	SET @ReferenciaMES = NULL
	SET @PedidoMES = NULL
	SET @Serie = NULL
	SET @IDMES = NULL
	SET @IDMarcaje = NULL
	SET @MovMES = NULL
	SET @Actividad = NULL
	SET @PedimentoExtraccion = NULL
	SET @PosicionWMS = 0
	SET @PosicionDWMS = NULL
	SET @RenglonSub = 0
	SET @RenglonTipo = NULL
	SET @Prioridad = 'Normal'
	SET @Modulo = 'INV'
	SET @Accion = 'AFECTAR'
	SET @Base = 'TODO'
	SET @GenerarMov = NULL
	SET @SincroFinal = 0
	SET @EnSilencio = 1
	SET @Conexion = 0
	SET @Observacion = ''
	SET @Mensaje = ''

	DECLARE @TablaDistribuir Table (
			  IDR                   int IDENTITY(1,1) NOT NULL,
			  ID                    int               NULL,
			  Almacen               varchar(10)       NULL,
			  AlmacenDestino        varchar(10)       NULL,
			  Articulo              varchar(20)       NULL,
			  SubCuenta             varchar(50)       NULL,
			  Cantidad              float             NULL,
			  Procesado             bit               NULL
			)

	DECLARE @TablaComprar Table (
			  IDR                   int IDENTITY(1,1) NOT NULL,
			  ID                    int               NULL,
			  Almacen               varchar(10)       NULL,
			  Proveedor             varchar(10)       NULL,
			  Articulo              varchar(20)       NULL,
			  SubCuenta             varchar(50)       NULL,
			  Cantidad              float             NULL,
			  Procesado             bit               NULL
			)

	DECLARE @TablaAfectar table(
			Ok                  int,
			OkDesc              varchar(255),
			OkTipo              varchar(50),
			OkRef               varchar(255),
			IDGenerar           int
		  )

	INSERT INTO @TablaDistribuir(ID,Almacen,AlmacenDestino,Articulo,SubCuenta,Cantidad,Procesado)
	SELECT ID,Almacen,AlmacenD,Articulo,SubCuenta,CantidadA,0
	  FROM PlanArtMaxMin
	 WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion 
	AND Tipo = 'Distribuir' AND Aplicar = 1 AND CantidadA > 0
	ORDER BY Almacen, AlmacenD, Articulo, SubCuenta
	
	SELECT TOP 1 @Mov = Movimiento FROM PlanArtMaxMin WHERE Tipo = 'Distribuir'

	----------------------------------------------------------------------------------------
	IF EXISTS(SELECT * FROM @TablaDistribuir)
	 IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'INV' AND Mov = @Mov AND Clave = 'INV.OT')
		IF EXISTS(SELECT * 
					FROM @TablaDistribuir A
					JOIN Alm B
					  ON A.Almacen = B.Almacen
					JOIN Alm C
					  ON A.AlmacenDestino = C.Almacen
				   WHERE B.Sucursal = C.Sucursal)
			BEGIN
				SELECT 'No se pueden realizar Transferencias entre Almacenes de la misma Sucursal.
						Revisar la configuración en: Configurar | Planeación | Máximos y Mínimos.'
				RETURN
			END		
	----------------------------------------------------------------------------------------

	INSERT INTO @TablaComprar (ID,Almacen,Proveedor,Articulo,SubCuenta,Cantidad,Procesado)
	SELECT ID,Almacen,Proveedor,Articulo,SubCuenta,CantidadA,0
	  FROM PlanArtMaxMin
	 WHERE Empresa = @Empresa AND Usuario = @Usuario AND Estacion = @Estacion 
	 AND Tipo = 'Comprar' AND Aplicar = 1 AND CantidadA > 0
	ORDER BY Almacen, AlmacenD, Proveedor, Articulo

	BEGIN TRY
	  -- Traspaso
	  SELECT @idx = MIN(IDR) FROM @TablaDistribuir WHERE  Procesado = 0
	  SET @idx = ISNULL (@idx,0)

	  WHILE @idx > 0
		BEGIN
		  SELECT @Almacen = Almacen,
				 @AlmacenDestino = AlmacenDestino
			FROM @TablaDistribuir
		   WHERE IDR = @idx

		  SELECT @RenglonID = COUNT(AlmacenDestino)
			FROM @TablaDistribuir
		   WHERE AlmacenDestino = @AlmacenDestino
			 AND Almacen = @Almacen

		  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
		  SELECT @SucursalOrigen = Sucursal FROM Alm WHERE ALmacen = @Almacen

		  SET @SucursalDestino = NULL

		  INSERT INTO Inv (
			  Empresa, Mov, MovID, FechaEmision, Proyecto, Moneda, TipoCambio, Concepto, Referencia, DocFuente,
			  Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Directo, 
			  RenglonID, Almacen, AlmacenDestino, AlmacenTransito, Largo, Condicion, Vencimiento, FormaEnvio,
			  Autorizacion, Usuario, OrigenTipo, Origen, OrigenID, Poliza, PolizaID, FechaConclusion, 
			  FechaCancelacion, FechaOrigen, FechaRequerida, Peso, Volumen, Sucursal, SucursalOrigen, VerLote, 
			  UEN, VerDestino, Personal, Conteo, Agente, ACRetencion, SubModulo, Actividad, PedimentoExtraccion, 
			  SucursalDestino
			)
		  VALUES
			(
			  @Empresa, @Mov, @MovID, @FechaEmision, @Proyecto, @Moneda, @TipoCambio, @Concepto, @Referencia, 
			  @DocFuente, @Observaciones, @Estatus, @Situacion, @SituacionFecha, @SituacionUsuario, @SituacionNota, 
			  @Directo, @RenglonID, @Almacen, @AlmacenDestino, @AlmacenTransito, @Largo, @Condicion, @Vencimiento, 
			  @FormaEnvio, @Autorizacion, @Usuario, @OrigenTipo, @Origen, @OrigenID, @Poliza, @PolizaID, @FechaConclusion, 
			  @FechaCancelacion, @FechaOrigen, @FechaRequerida, @Peso, @Volumen, @Sucursal, @SucursalOrigen, @VerLote, @UEN, 
			  @VerDestino, @Personal, @Conteo, @Agente, @ACRetencion, @SubModulo, @Actividad, @PedimentoExtraccion, @SucursalDestino
		  )

		  SET @ID = SCOPE_IDENTITY()
		  SET @RenglonID = 0

		  DECLARE crTablaDistribuir CURSOR FOR
			SELECT Articulo, SubCuenta, Cantidad FROM @TablaDistribuir
			WHERE Almacen = @Almacen AND AlmacenDestino = @AlmacenDestino

		  OPEN crTablaDistribuir
		  FETCH NEXT FROM crTablaDistribuir INTO @Articulo,@SubCuenta,@Cantidad
		  WHILE @@FETCH_STATUS = 0
			BEGIN
			  SET @RenglonID = @RenglonID + 1
			  SET @Renglon   = @RenglonID * 2048

			  SELECT @Unidad = UnidadTraspaso, @ArtTipo = Tipo FROM Art WITH(NOLOCK) WHERE Articulo = @Articulo
			  SET @Unidad = ISNULL(@Unidad, @DefUnidad)

			  IF @MultiUnidad = 'Articulo'
				SELECT @Factor = Factor FROM ArtUnidad WITH(NOLOCK) WHERE Unidad = @Unidad AND Articulo = @Articulo

			  IF @MultiUnidad = 'Unidad'
				SELECT @Factor = Factor FROM Unidad WITH(NOLOCK) WHERE Unidad = @Unidad

			  IF ISNULL(@MultiUnidad,'') = '' OR ISNULL(@Factor, '') = ''
				SELECT @Factor = 1

			  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo
			  IF NOT @RenglonTipo IN('N','S','L','V','J') SET @RenglonTipo = 'N'

			  EXEC spPrecioEsp '(Precio Lista)', @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
			  SET @CantidadInventario = ISNULL(@Cantidad * @Factor, 0)
			  SET @Cantidad = @Cantidad / @Factor
			  IF ISNULL(@SubCuenta,'') = '' SET @SubCuenta = NULL

			  INSERT INTO InvD (
				  ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, Codigo, Articulo, SubCuenta, ArticuloDestino,
				  SubCuentaDestino, Cantidad, Paquete, Costo, CantidadA, Aplica, AplicaID, ContUso, Unidad, Factor,
				  CantidadInventario, FechaRequerida, ProdSerieLote, Merma, Desperdicio, Producto, SubProducto, Tipo, 
				  Sucursal, SucursalOrigen, Precio, CostoInv, Espacio, DestinoTipo, Destino, DestinoID, Cliente, 
				  SegundoConteo, DescripcionExtra, Posicion
				)
			  VALUES
				(
				  @ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @Almacen, @Codigo, @Articulo, @SubCuenta, @ArticuloDestino,
				  @SubCuentaDestino, @Cantidad, @Paquete, @Costo, @Cantidad, @Aplica, @AplicaID, @ContUso, @Unidad, @Factor,
				  @CantidadInventario, @FechaRequerida, @ProdSerieLote, @Merma, @Desperdicio, @Producto, @SubProducto, @Tipo, 
				  @Sucursal, @SucursalOrigen, @Precio, @CostoInv, @Espacio, @DestinoTipo, @Destino, @DestinoID, @Cliente,
				  @SegundoConteo, @DescripcionExtra, @Posicion
				)

			  UPDATE @TablaDistribuir SET Procesado = 1 WHERE Almacen = @Almacen AND AlmacenDestino = @AlmacenDestino

			  FETCH NEXT FROM crTablaDistribuir INTO @Articulo, @SubCuenta, @Cantidad
		   END
		  CLOSE crTablaDistribuir
		  DEALLOCATE crTablaDistribuir

		  SET @Observacion = ''

		  IF @MovEstatus = 'SIN AFECTAR' AND @MovConsecutivo = 1
			BEGIN
			  SET @Accion = 'Consecutivo'
			  SET @Base = 'Todo'
			  EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion

			  IF ISNULL(@Ok,0) > 0
				BEGIN
				  SELECT @Observacion = LTRIM(RTRIM(ISNULL(Descripcion,''))) FROM MensajeLista WHERE Mensaje = @Ok
				  SET @Observacion = @Observacion + ' (' + LTRIM(RTRIM(ISNULL(@OkRef,''))) + ')' + ' '
				END

			  SET @Ok = NULL

			END

		  IF @MovEstatus = 'PENDIENTE'
			BEGIN
			  SET @Accion = 'Afectar'
			  SET @Base = 'Todo'
			  EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion

			  IF ISNULL(@Ok,0) > 0
				BEGIN
				  SELECT @Observacion = @Observacion + LTRIM(RTRIM(ISNULL(Descripcion,''))) FROM MensajeLista WHERE Mensaje = @Ok + ' '
				  SET @Observacion = @Observacion + ' (' + LTRIM(RTRIM(ISNULL(@OkRef,''))) + ')'
				END

			  SET @Ok = NULL

			END

		  IF @MovEstatus = 'PENDIENTE' AND @MovReservar = 1
			BEGIN
			  SET @Accion = 'Reservar'
			  SET @Base = 'Pendiente'
			  EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion

			  IF ISNULL(@Ok,0) > 0
				BEGIN
				  SELECT @Observacion = @Observacion + LTRIM(RTRIM(ISNULL(Descripcion,''))) FROM MensajeLista WHERE Mensaje = @Ok
				  SET @Observacion = @Observacion + ' (' + LTRIM(RTRIM(ISNULL(@OkRef,''))) + ')'
				END

			  SET @Ok = NULL
			END

		  SELECT @SucursalDestino = Sucursal FROM Alm WHERE ALmacen = @AlmacenDestino
		  UPDATE Inv SET SucursalDestino = @SucursalDestino WHERE ID = @ID
		  SET @SucursalDestino = NULL

		  SELECT @MovIdLog = MovID, @EstatusLog = Estatus FROM Inv WHERE ID = @ID

		  INSERT INTO PlanArtMaxMinLog (Empresa, Sucursal, Usuario, Estacion, Corrida, Almacen, AlmacenDestino, Reservar, InvID, InvMov, InvMovId, Estatus, FechaLog, Observacion)
		  VALUES (@Empresa, @SucursalLog, @Usuario, @Estacion, @Corrida, @Almacen, @AlmacenDestino, @MovReservar, @ID, @Mov, @MovIdLog, @EstatusLog, GETDATE(), @Observacion)

		  SET @Observacion = ''

		  SET @GeneradosDistribuir = @GeneradosDistribuir + 1

		  SELECT @idx = MIN(IDR) FROM @TablaDistribuir WHERE Procesado = 0
		  SET @idx = ISNULL (@idx,0)

		END

		  INSERT INTO PlanArtMaxMinHist (
					 ID, Empresa, Sucursal, Usuario, Estacion, Corrida, Grupo, Categoria, Familia, Linea, Fabricante, Proveedor, Nombre, Almacen, 
					 AlmacenNombre, Articulo, SubCuenta, Descripcion1, Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio,
					 ImporteTotal, Existencia, EnCompra, PorRecibir, PorEntregar, Disponible, DiasInvInicio, AlmacenD, AlmacenNombreD, MaximoD, MinimoD, 
					 VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD, DisponibleD, DiasInvD, Solicitar, Cantidad, CantidadA, 
					 DiasInvFin, Tipo, Movimiento, Aplicar
					 )
			SELECT	a.ID, a.Empresa, a.Sucursal, a.Usuario, a.Estacion, @Corrida, a.Grupo, a.Categoria, a.Familia, a.Linea, a.Fabricante, a.Proveedor, a.Nombre, a.Almacen, 
					a.AlmacenNombre, a.Articulo, a.SubCuenta, a.Descripcion1, a.Descripcion2, a.NombreCorto, a.Unidad, a.ABC, a.Maximo, a.Minimo, a.VentaPromedio, a.Precio, 
					a.ImporteTotal, a.Existencia, a.EnCompra, a.PorRecibir, a.PorEntregar, a.Disponible, a.DiasInvInicio, a.AlmacenD, a.AlmacenNombreD, a.MaximoD, a.MinimoD,
					a.VentaPromedioD, a.ExistenciaD, a.EnCompraD, a.PorRecibirD, a.PorEntregarD, a.DisponibleD, a.DiasInvD, a.Solicitar, a.Cantidad, a.CantidadA, 
					a.DiasInvFin, a.Tipo, a.Movimiento, a.Aplicar
			  FROM PlanArtMaxMin a
			  JOIN @TablaDistribuir b ON a.ID = b.ID
			 WHERE b.Procesado = 1

		  DELETE a FROM PlanArtMaxMin AS a INNER JOIN @TablaDistribuir b ON (a.ID = b.ID) WHERE b.Procesado = 1

		  -- Orden Compra
		  SELECT TOP 1 @Mov = Movimiento FROM PlanArtMaxMin WHERE Tipo = 'Comprar'

	      SELECT @idx = MIN(IDR) FROM @TablaComprar WHERE Procesado = 0
	      SET @idx = ISNULL (@idx,0)

		  WHILE @idx > 0
			BEGIN
			  SELECT TOP 1 @Mov = Movimiento FROM PlanArtMaxMin WHERE Tipo = 'Comprar'
			  SET @MovID = NULL

			  SET @Concepto = 'STOCK'
			  SET @Estatus = 'SINAFECTAR'
			  SET @FechaEntrega = @FechaHoy
			  SET @FechaRequerida = @FechaHoy
			  SET @Manejo = NULL
			  SET @Fletes = NULL
			  SET @Instruccion = NULL
			  SET @DescuentoGlobal = NULL
			  SET @Importe = NULL
			  SET @Impuestos = NULL
			  SET @DescuentoLineal = NULL
			  SET @Origen = 'INT'
			  SET @Origen = NULL
			  SET @Poliza = NULL
			  SET @PolizaID = NULL
			  SET @Peso = 0
			  SET @Atencion = NULL
			  SET @Causa = NULL
			  SET @SucursalOrigen = 0
			  SET @Idioma = NULL
			  SET @ListaPreciosEsp = NULL
			  SET @UEN = NULL
			  SET @Mensaje = NULL
			  SET @FormaEntrega = NULL
			  SET @CancelarPendiente = 0
			  SET @LineaCredito = NULL
			  SET @TipoAmortizacion = NULL
			  SET @TipoTasa = NULL
			  SET @Comisiones = NULL
			  SET @ComisionesIVA = 0
			  SET @VIN = NULL
			  SET @SubModulo = 'COMS'
			  SET @AutoCargos = NULL
			  SET @TieneTasaEsp = 0
			  SET @TasaEsp = NULL
			  SET @Cliente = NULL
			  SET @Renglon = 0
			  SET @RenglonID = NULL

			  SELECT @Almacen = Almacen, @Proveedor = Proveedor FROM @TablaComprar WHERE IDR = @idx
			  SELECT @Condicion = Condicion, @ZonaImpuesto = ZonaImpuesto, @DescuentoH = Descuento, @Agente = Agente FROM Prov WHERE Proveedor = @Proveedor
			  SELECT @Descuento = Porcentaje FROM Descuento WHERE Descuento = @DescuentoH
			  SELECT @Vencimiento = DATEADD(d,DiasVencimiento,GETDATE()) FROM Condicion WHERE Condicion = @Condicion
			  SELECT @Impuesto1 = Porcentaje FROM ZonaImp WHERE Zona = @ZonaImpuesto
			  SELECT @Sucursal = Sucursal FROM Alm WHERE Almacen = @Almacen
			  SELECT @Agente = DefAgente FROM Usuario WHERE Usuario = @Usuario

			  SET @Agente = ISNULL(@Agente,'')
			  SET @SucursalOrigen = @SucursalLog

			  INSERT INTO Compra (
				  Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, Referencia, DocFuente, Observaciones, Estatus,
				  Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Directo, VerDestino, Prioridad, RenglonID, Proveedor, FormaEnvio, FechaEntrega, FechaRequerida, 
				  Almacen, Condicion, Vencimiento, Manejo, Fletes, Instruccion, Agente, Descuento, DescuentoGlobal, Importe, Impuestos, DescuentoLineal, OrigenTipo, Origen,
				  OrigenID, Poliza, PolizaID, Peso, Volumen, Atencion, Causa, Sucursal, SucursalOrigen, ZonaImpuesto, Idioma, ListaPreciosEsp, UEN, Mensaje, FormaEntrega,
				  CancelarPendiente, LineaCredito, TipoAmortizacion, TipoTasa, Comisiones, ComisionesIVA, VIN, SubModulo, AutoCargos, TieneTasaEsp, TasaEsp, Cliente
				)
			  VALUES
				(
				  @Empresa, @Mov, @MovID, @FechaEmision, @UltimoCambio, @Concepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, @Estatus,
				  @Situacion, @SituacionFecha, @SituacionUsuario, @SituacionNota, @Directo, @VerDestino, @Prioridad, @RenglonID, @Proveedor, @FormaEnvio, @FechaEntrega, @FechaRequerida,
				  @Almacen, @Condicion, @Vencimiento, @Manejo, @Fletes, @Instruccion, @Agente, @DescuentoH, @DescuentoGlobal, @Importe, @Impuestos, @DescuentoLineal, @OrigenTipo, @Origen,
				  @OrigenID, @Poliza, @PolizaID, @Peso, @Volumen, @Atencion, @Causa, @Sucursal, @SucursalOrigen, @ZonaImpuesto, @Idioma, @ListaPreciosEsp, @UEN, @Mensaje, @FormaEntrega,
				  @CancelarPendiente, @LineaCredito, @TipoAmortizacion, @TipoTasa, @Comisiones, @ComisionesIVA, @VIN, @SubModulo, @AutoCargos, @TieneTasaEsp, @TasaEsp, @Cliente
				)
			  SET @ID = SCOPE_IDENTITY()
			  SET @RenglonID = 0

			  DECLARE crTablaComprarTMP CURSOR FOR
				SELECT Almacen,Proveedor,Articulo,SubCuenta,SUM(Cantidad) AS Cantidad FROM @TablaComprar
				WHERE Almacen = @Almacen AND Proveedor = @Proveedor
			   GROUP BY Almacen,Proveedor,Articulo,SubCuenta

			  OPEN crTablaComprarTMP
			  FETCH NEXT FROM crTablaComprarTMP INTO @AlmacenCr, @ProveedorCr, @Articulo, @SubCuenta, @Cantidad
			  WHILE @@FETCH_STATUS = 0
				BEGIN
				  SET @RenglonID = @RenglonID + 1
				  SET @Renglon   = @RenglonID * 2048

				  IF ISNULL(@SubCuenta,'') = '' SET @SubCuenta = NULL

				  SELECT @Sucursal = Sucursal FROM alm WHERE Almacen = @AlmacenCr
				  SELECT @Unidad = UnidadCompra FROM Art WHERE Articulo = @Articulo

				  SELECT @Factor = Factor FROM Unidad WHERE Unidad = @Unidad
				  SET @Factor = ISNULL(@Factor,1)

				  EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, NULL, @CfgCompraCostoSugerido, @Moneda, @TipoCambio, @Costo OUTPUT, 0
				  SELECT @Impuesto1 = Impuesto1 FROM Art WHERE Articulo = @Articulo

				  SET @Costo = ISNULL(@Costo,0)
				  SET @FechaRequerida = @FechaHoy
				  SET @FechaOrdenar = NULL
				  SET @FechaEntrega = @FechaHoy
				  SET @Codigo = NULL
				  SET @CostoInv = NULL
				  SET @Impuesto2 = 0.0
				  SET @Impuesto3 = 0.0
				  SET @DescuentoTipo = NULL
				  SET @DescuentoLinea = @Descuento
				  SET @DescuentoImporte = NULL
				  SET @DescripcionExtra = NULL
				  SET @ReferenciaExtra = NULL
				  SET @DestinoTipo = NULL
				  SET @Destino = NULL
				  SET @DestinoID = NULL
				  SET @Cliente = NULL
				  SET @Aplica = NULL
				  SET @AplicaID = NULL
				  SET @CantidadInventario = @Cantidad * @Factor
				  SET @CantidadA = NULL
				  SET @ContUso = NULL
				  SET @ServicioArticulo = NULL
				  SET @ServicioSerie = NULL
				  SET @Sucursal = 0
				  SET @SucursalOrigen = 0
				  SET @Paquete = NULL
				  SET @ImportacionProveedor = NULL
				  SET @ImportacionReferencia = NULL
				  SET @Retencion1 = NULL
				  SET @Retencion2 = NULL
				  SET @Retencion3 = NULL
				  SET @FechaCaducidad = NULL
				  SET @ProveedorArt = NULL
				  SET @ProveedorArtCosto = NULL
				  SET @Posicion = NULL
				  SET @Pais = NULL
				  SET @TratadoComercial = NULL
				  SET @ProgramaSectorial = NULL
				  SET @ValorAduana = NULL
				  SET @ID1 = NULL
				  SET @ID2 = NULL
				  SET @FormaPago = NULL
				  SET @ImportacionImpuesto1 = NULL
				  SET @ImportacionImpuesto2 = NULL
				  SET @EsEstadistica = 0

				  INSERT INTO CompraD (
					  ID, Renglon, RenglonSub, RenglonID, RenglonTipo, Almacen, FechaRequerida, FechaOrdenar, FechaEntrega, Codigo, Articulo, SubCuenta, Cantidad, 
					  Costo, CostoInv, Impuesto1, Impuesto2, Impuesto3, Descuento, DescuentoTipo, DescuentoLinea, DescuentoImporte, DescripcionExtra, ReferenciaExtra,
					  DestinoTipo, Destino, DestinoID, Cliente, Aplica, AplicaID, CantidadInventario, CantidadA, ContUso, Unidad, Factor, ServicioArticulo, ServicioSerie,
					  Sucursal, SucursalOrigen, Paquete, ImportacionProveedor, ImportacionReferencia, Retencion1, Retencion2, Retencion3, FechaCaducidad, ProveedorArt, 
					  ProveedorArtCosto, Posicion, Pais, TratadoComercial, ProgramaSectorial, ValorAduana, ID1, ID2, FormaPago, ImportacionImpuesto1, ImportacionImpuesto2, EsEstadistica
					)
				  VALUES (
					  @ID, @Renglon, @RenglonSub, @RenglonID, @RenglonTipo, @AlmacenCr, @FechaRequerida, @FechaOrdenar, @FechaEntrega, @Codigo, @Articulo, @SubCuenta, @Cantidad,
					  @Costo, @CostoInv, @Impuesto1, @Impuesto2, @Impuesto3, @DescuentoH, @DescuentoTipo, @DescuentoLinea, @DescuentoImporte, @DescripcionExtra, @ReferenciaExtra,
					  @DestinoTipo, @Destino, @DestinoID, @Cliente, @Aplica, @AplicaID, @CantidadInventario, @CantidadA, @ContUso, @Unidad, @Factor, @ServicioArticulo, @ServicioSerie,
					  @Sucursal, @SucursalOrigen, @Paquete, @ImportacionProveedor, @ImportacionReferencia, @Retencion1, @Retencion2, @Retencion3, @FechaCaducidad, @ProveedorArt,
					  @ProveedorArtCosto, @Posicion, @Pais, @TratadoComercial, @ProgramaSectorial, @ValorAduana, @ID1, @ID2, @FormaPago, @ImportacionImpuesto1, @ImportacionImpuesto2, @EsEstadistica
					)

				  UPDATE @TablaComprar SET Procesado = 1
				  WHERE Almacen = @AlmacenCr AND Proveedor = @ProveedorCr

				  FETCH NEXT FROM crTablaComprarTMP INTO @AlmacenCr, @ProveedorCr, @Articulo, @SubCuenta, @Cantidad
				END

			    CLOSE crTablaComprarTMP
			    DEALLOCATE crTablaComprarTMP

			    SET @Modulo = 'COMS'
			    SET @Accion = 'AFECTAR'
			    SET @Base = 'Todo'
			    SET @Observacion = ''

			    EXECUTE spAfectar @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT, @FechaRegistro, @Conexion, @Estacion

			    IF ISNULL(@Ok,0) > 0
				BEGIN
				  SELECT @Observacion = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
				  SET @Observacion = @Observacion + ' (' + LTRIM(RTRIM(ISNULL(@OkRef,''))) + ')'
				END

				SET @Ok = NULL

				INSERT INTO PlanArtMaxMinLog (
					Empresa, Sucursal, Usuario, Estacion, Corrida, Almacen, AlmacenDestino, Reservar, InvID, InvMov, InvMovId, Estatus, FechaLog, Observacion)
				VALUES (
					@Empresa, @SucursalLog, @Usuario, @Estacion, @Corrida, @Almacen, @AlmacenDestino, @MovReservar, @ID, @Mov, @MovIdLog, @EstatusLog, GETDATE(), @Observacion)

			  SET @GeneradosComprar = @GeneradosComprar + 1

			  SELECT @idx = MIN(IDR) FROM @TablaComprar WHERE Procesado = 0
			  SET @idx = ISNULL (@idx,0)
			END

			INSERT INTO PlanArtMaxMinHist (
				 ID, Empresa, Sucursal, Usuario, Estacion, Corrida, Grupo, Categoria, Familia, Linea, Fabricante, Proveedor, Nombre, Almacen, AlmacenNombre, Articulo,
				 SubCuenta, Descripcion1, Descripcion2, NombreCorto, Unidad, ABC, Maximo, Minimo, VentaPromedio, Precio, ImporteTotal, Existencia, EnCompra, PorRecibir,
				 PorEntregar, Disponible, DiasInvInicio, AlmacenD, AlmacenNombreD, MaximoD, MinimoD, VentaPromedioD, ExistenciaD, EnCompraD, PorRecibirD, PorEntregarD,
				 DisponibleD, DiasInvD, Solicitar, Cantidad, CantidadA, DiasInvFin, Tipo, Movimiento, Aplicar
			     )
			SELECT
				 a.ID, a.Empresa, a.Sucursal, a.Usuario, a.Estacion, @Corrida, a.Grupo, a.Categoria, a.Familia, a.Linea, a.Fabricante, a.Proveedor, a.Nombre, a.Almacen, a.AlmacenNombre, a.Articulo,
				 a.SubCuenta, a.Descripcion1, a.Descripcion2, a.NombreCorto, a.Unidad, a.ABC, a.Maximo, a.Minimo, a.VentaPromedio, a.Precio, a.ImporteTotal, a.Existencia, a.EnCompra, a.PorRecibir,
				 a.PorEntregar, a.Disponible, a.DiasInvInicio, a.AlmacenD, a.AlmacenNombreD, a.MaximoD, a.MinimoD, a.VentaPromedioD, a.ExistenciaD, a.EnCompraD, a.PorRecibirD, a.PorEntregarD,
				 a.DisponibleD, a.DiasInvD, a.Solicitar, a.Cantidad, a.CantidadA, a.DiasInvFin, a.Tipo, a.Movimiento, a.Aplicar
		    FROM PlanArtMaxMin a
		    JOIN @TablaComprar b ON a.ID = b.ID
		    WHERE b.Procesado = 1

			DELETE a FROM PlanArtMaxMin AS a INNER JOIN @TablaComprar b ON (a.ID = b.ID)

			SET @Mensaje = CAST((@GeneradosDistribuir + @GeneradosComprar) AS varchar) + ' movimientos generados'

	END TRY
	BEGIN CATCH
	  SET @Mensaje = ERROR_MESSAGE()
	END CATCH

	SELECT @Mensaje AS Mensaje

END
GO

/*************************  spPlanArtMaxMinActualizar  ************************/
IF EXISTS(SELECT * FROM sysobjects WHERE name ='spPlanArtMaxMinActualizar' AND type = 'P')  DROP PROCEDURE spPlanArtMaxMinActualizar
GO
CREATE PROCEDURE spPlanArtMaxMinActualizar(
	  @Empresa              char(5),
	  @Usuario              varchar(10),
	  @Estacion             int
	)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @Filas		int,
			@Mensaje	varchar(255)

	SET @Filas = 0
	SET @Mensaje = ''

	BEGIN TRY
	  UPDATE PlanArtMaxMin
		 SET DiasInvD  = b.DiasInvD,
			 CantidadA  = b.CantidadA,
			 DiasInvFin = b.DiasInvFin,
			 Aplicar    = b.Aplicar
		FROM PlanArtMaxMin a
	   INNER JOIN PlanArtMaxMinTemp b ON a.ID = b.ID

	  SELECT @Filas = COUNT(ID)
		FROM PlanArtMaxMinTemp
	   WHERE Empresa  = @Empresa
		 AND Usuario  = @Usuario
		 AND Estacion = @Estacion

	  DELETE PlanArtMaxMinTemp
	   WHERE Empresa  = @Empresa
		 AND Usuario  = @Usuario
		 AND Estacion = @Estacion
	END TRY
	BEGIN CATCH
	  SET @Filas = 0
	  SET @Mensaje = ERROR_MESSAGE()
	END CATCH

	SELECT @Filas AS Filas, @Mensaje AS Mensaje
END
GO

/************************************************     spMaxMinCrearJob     ************************************************************/
IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.spMaxMinCrearJob') AND TYPE = 'P') DROP PROCEDURE dbo.spMaxMinCrearJob
GO             
CREATE PROCEDURE spMaxMinCrearJob
  @Nombre           varchar(100),
  @BaseDatos        varchar(30),
  @Empresa			varchar(5),
  @Cadena           nvarchar(100) = 'spActualizarMaxMin'
  
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID               binary (16),
  @ReturnCode              int,
  @Activo                  bit,
  @Trabajo                 char(20),

  @Servidor                varchar(30),   
  @FrecuenciaD             tinyint,
  @ValorD                  tinyint,
  @Valor                   tinyint,
  @Dia                     tinyint,
  @Fecha2                  int, 
  @Estatus                 bit,
  @Fecha                   datetime,
  @NombreOriginal          varchar(100),
  @Procesar                varchar(30)
 
  BEGIN TRANSACTION
	
	SET @Cadena = @Cadena +' '+@Empresa
  
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
    SELECT @Fecha = GETDATE()
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = @Empresa+'.'+ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Históricos '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0)-- AND EXISTS(SELECT * FROM NotificacionTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job 
      @job_id = @TrabajoID OUTPUT , 
      @job_name = @Nombre, 
      @owner_login_name = N'sa', 
      @description =  @Nombre, 
      @category_name = '[Uncategorized (Local)]', 
      @enabled = 1, 
      @notify_level_email = 0, 
      @notify_level_page = 0, 
      @notify_level_netsend = 0, 
      @notify_level_eventlog = 2, 
      @delete_level= 0
 
     SELECT @Fecha2 =CONVERT(int, CONVERT(varchar,DATEPART(YEAR,@Fecha)) +  dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,@Fecha)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,@Fecha)),2))
     
     SELECT @Trabajo = Trabajo, 
       @FrecuenciaD= CASE Frecuencia WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , 
       @Valor = Valor, 
       @Activo =Activo 
       FROM MaxMinTrabajo


	   IF(ISNULL(@Cadena, '') = '') SELECT @Cadena = 'spActualizarMaxMin'+' '+@Empresa
       SET @Cadena     = N''+@Cadena



       EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep 
         @job_id = @TrabajoID, 
         @step_id = 1, 
         @step_name = @Trabajo, 
         @command = @Cadena, 
         @database_name = @BaseDatos, 
         @server = '', 
         @database_user_name = '', 
         @subsystem = 'TSQL', 
         @cmdexec_success_code = 0, 
         @flags = 0, 
         @retry_attempts = 0, 
         @retry_interval = 1, 
         @output_file_name = '', 
         @on_success_step_id = 0, 
         @on_success_action = 1, 
         @on_fail_step_id = 0, 
         @on_fail_action = 2

    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job 
         @job_id = @TrabajoID, 
         @start_step_id = 1, 
         @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
         @job_id = @TrabajoID, 
         @name = @Nombre, 
         @enabled = @Activo, 
         @freq_type = 4, 
         @active_start_date = @Fecha2, 
         @active_start_time = 0, 
         @freq_interval = 1, 
         @freq_subday_type = @FrecuenciaD , 
         @freq_subday_interval = @Valor, 
         @freq_relative_interval = 0, 
         @freq_recurrence_factor = 0, 
         @active_end_date = 99991231, 
         @active_end_time = 235959
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
 

  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'
 
  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0
 
  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
  
END  
GO


/*************************  spPlanArtVenta  ************************/
IF EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'spPlanArtVenta' AND Type = 'P')  DROP PROCEDURE spPlanArtVenta
GO
CREATE PROCEDURE spPlanArtVenta
  @Empresa                   varchar(5),
  @Almacen                   varchar(10),
  @Articulo                  varchar(20),
  @FechaDe                   datetime
--//WITH ENCRYPTION
AS
BEGIN
SET NOCOUNT ON

DECLARE @FechaA              datetime
DECLARE @Estatus             varchar(15)
DECLARE @Periodos            int
DECLARE @PrimerID            int
DECLARE @PrimerFecha         datetime
DECLARE @FechaT              datetime
DECLARE @Anio                int
DECLARE @Semana              int
DECLARE @AnioTmp             int
DECLARE @SemanaTmp           int
DECLARE @PrimerAnio          int
DECLARE @PrimerSemana        int
DECLARE @Cantidad            float
DECLARE @Importe             float
DECLARE @MaxID               int
DECLARE @idx                 int
DECLARE @b                   bit

DECLARE @Venta               table (Clave varchar(20) NULL)
DECLARE @VentaDev            table (Clave varchar(20) NULL)

DECLARE @TablaVenta table (
  ID                         int IDENTITY (1, 1) NOT NULL,
  VentaID                    int NULL,
  Fecha                      datetime NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Periodo                    varchar(10) NULL,
  Consecutivo                int NULL,
  DiaSemana                  int NULL,
  Semana                     int NULL,
  Mes                        int NULL,
  Anio                       int NULL,
  DiaAnio                    int NULL
)

DECLARE @TablaDevolucion table (
  ID                         int IDENTITY (1, 1) NOT NULL,
  VentaID                    int NULL,
  Fecha                      datetime NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Semana                     int NULL,
  Mes                        int NULL,
  Anio                       int NULL
)

DECLARE @TablaResumen table (
  ID                         int IDENTITY (1, 1) NOT NULL,
  Consecutivo                int NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Anio                       int NULL,
  Semana                     int NULL,
  Mes                        int NULL
)

DECLARE @TablaResultado table (
  Consecutivo                int IDENTITY (1, 1) NOT NULL,
  Cantidad                   float NULL,
  Importe                    float NULL,
  Anio                       int NULL,
  Semana                     int NULL
)

SET @FechaA = dbo.fnFechaSinHora(GETDATE())

IF @FechaDe > @FechaA
  BEGIN
    SET @FechaT  = @FechaDe
    SET @FechaDe = @FechaA
    SET @FechaA  = @FechaT
  END

SET @FechaDe = DATEADD(second,-1,@FechaDe)
SET @FechaA  = DATEADD(second,-1,@FechaA)
SET @FechaA  = DATEADD(day,1,@FechaA)

SET @Estatus = 'CONCLUIDO'
SET @b = 0

-- Claves afectacion ventas (Empresa = VHA)                -- Movimientos
INSERT INTO @Venta(Clave)       VALUES ('VTAS.F')          -- AsignaTarjeta - Factura - Factura Flexible - Factura Prorrateada - Nota Cargo
INSERT INTO @Venta(Clave)       VALUES ('VTAS.FM')         -- Factura Mostrador
INSERT INTO @Venta(Clave)       VALUES ('VTAS.FR')         -- Factura Recurrente
INSERT INTO @Venta(Clave)       VALUES ('VTAS.VCR')        -- Remision
INSERT INTO @Venta(Clave)       VALUES ('VTAS.VC')         -- Venta Consignacion
INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.D')          -- Cancelacion Factura - Devolucion Venta
INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.DC')         -- Dev. Venta Consig.
INSERT INTO @VentaDev(Clave)    VALUES ('VTAS.DCR')        -- Devolucion Remision

INSERT INTO @TablaVenta (VentaID,Fecha,Cantidad,Importe,DiaSemana,Semana,Mes,Anio,DiaAnio)
SELECT v.ID,v.FechaEmision,ISNULL(d.Cantidad,0),ISNULL(d.Cantidad,0) * ISNULL(d.Precio,0),
       datepart(weekday,v.FechaEmision),
       datepart(week,v.FechaEmision),
       datepart(month,v.FechaEmision),
       datepart(year,v.FechaEmision),
       datepart(dayofyear,v.FechaEmision)
  FROM Venta v
  JOIN VentaD d ON(v.ID = d.ID)
  JOIN MovTipo m ON(v.Mov = m.Mov)
  JOIN @Venta mv ON(m.Clave = mv.Clave)
 WHERE v.Empresa      = @Empresa
   AND d.Almacen      = @Almacen
   AND d.Articulo     = @Articulo
   AND v.Estatus      = @Estatus
   AND v.FechaEmision BETWEEN @FechaDe AND @FechaA
ORDER BY v.FechaEmision

DELETE @TablaVenta WHERE Importe = 0

SELECT @PrimerID = Min(ID) FROM @TablaVenta
SET @PrimerID = ISNULL(@PrimerID,0)
SELECT TOP 1 @PrimerAnio = Anio FROM @TablaVenta WHERE ID = @PrimerID
SELECT TOP 1 @PrimerFecha = Fecha FROM @TablaVenta WHERE ID = @PrimerID
SELECT TOP 1 @PrimerSemana = Semana FROM @TablaVenta WHERE ID = @PrimerID
SET @Periodos = (ABS(DATEDIFF(DAY,@PrimerFecha,@FechaA)) / 7) + 2

UPDATE @TablaVenta SET Consecutivo = (Semana - @PrimerSemana + 1) + ((Anio - @PrimerAnio) * 52)

INSERT INTO @TablaResumen (Consecutivo,Anio,Semana,Cantidad,Importe)
SELECT Consecutivo,Anio,Semana,SUM(Cantidad) ,SUM(Importe)
  FROM @TablaVenta
GROUP BY Consecutivo,Semana,Anio

SET @idx = 1
WHILE @idx < @Periodos
  BEGIN
    INSERT INTO @TablaResultado (Cantidad,Importe) VALUES (0,0)
    SET @idx = @idx + 1
  END

UPDATE @TablaResultado
   SET Anio = b.Anio, Semana = b.Semana , Cantidad = b.cAntidad, Importe = b.Importe
  FROM @TablaResultado a
 INNER JOIN @TablaResumen b ON a.Consecutivo = b.Consecutivo

SELECT @idx = (MAX(Consecutivo) + 1) FROM @TablaResultado
SET @b = 0

WHILE @b = 0
  BEGIN
    SET @idx = @idx - 1
    IF EXISTS(SELECT TOP 1 Importe FROM @TablaResultado WHERE Importe = 0 AND Consecutivo = @idx)
      BEGIN
        DELETE @TablaResultado WHERE Consecutivo = @idx
      END
    ELSE
      BEGIN
        SET @b = 1
      END
  END

SELECT @Anio = Anio FROM @TablaResultado WHERE Consecutivo = 1
SELECT @Semana = Semana FROM @TablaResultado WHERE Consecutivo = 1
SELECT @MaxID = MAX(Consecutivo) FROM @TablaResultado

SET @idx = 2
WHILE @idx < @MaxID
  BEGIN
    SELECT @AnioTmp = Anio FROM @TablaResultado WHERE Consecutivo = @idx
    SELECT @SemanaTmp = Semana FROM @TablaResultado WHERE Consecutivo = @idx

    SET @AnioTmp = ISNULL(@AnioTmp,0)
    SET @SemanaTmp = ISNULL(@SemanaTmp,0)

    IF @SemanaTmp = 0
      BEGIN
        SET @Semana = @Semana + 1
        IF @Semana > 52
          BEGIN
            SET @Semana = 1
            SET @Anio = @Anio + 1
          END
        UPDATE @TablaResultado SET Anio = @Anio, Semana = @Semana WHERE Consecutivo = @idx
      END
    ELSE
      BEGIN
        SELECT @Anio = Anio FROM @TablaResultado WHERE Consecutivo = @idx
        SELECT @Semana = Semana FROM @TablaResultado WHERE Consecutivo = @idx
      END

    SET @idx  = @idx + 1
  END

INSERT INTO @TablaDevolucion (VentaID,Fecha,Cantidad,Importe,Semana,Mes,Anio)
 SELECT v.ID,v.FechaEmision,
        ISNULL(d.Cantidad,0),
        ISNULL(d.Cantidad,0) * ISNULL(d.Precio,0),
        datepart(week,v.FechaEmision),
        datepart(month,v.FechaEmision),
        datepart(year,v.FechaEmision)
   FROM Venta v
   JOIN VentaD d ON(v.ID = d.ID)
   JOIN MovTipo m ON(v.Mov = m.Mov)
   JOIN @VentaDev mv ON(m.Clave = mv.Clave)
  WHERE v.Empresa      = @Empresa
    AND d.Articulo     = @Articulo
    AND v.Estatus      = @Estatus
    AND v.FechaEmision BETWEEN @FechaDe AND @FechaA
 ORDER BY v.FechaEmision

DECLARE spPlanArtVenta_cursor CURSOR FOR
  SELECT Anio,Semana,SUM(Cantidad),SUM(Importe)
    FROM @TablaDevolucion
  GROUP BY Anio,Semana

OPEN spPlanArtVenta_cursor
FETCH NEXT FROM spPlanArtVenta_cursor INTO @Anio,@Semana,@Cantidad,@Importe
WHILE @@FETCH_STATUS = 0
  BEGIN
    UPDATE @TablaResultado
       SET Cantidad = ISNULL(Cantidad,0) - ISNULL(@Cantidad,0),
           Importe = ISNULL(Importe,0) - ISNULL(@Importe,0)
    WHERE Anio = @Anio AND Semana = @Semana
    FETCH NEXT FROM spPlanArtVenta_cursor INTO @Anio,@Semana,@Cantidad,@Importe
  END
CLOSE spPlanArtVenta_cursor
DEALLOCATE spPlanArtVenta_cursor

SELECT Consecutivo,Anio,Semana,Cantidad,Importe FROM @TablaResultado ORDER BY Consecutivo
END
GO