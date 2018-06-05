/**************** fnPCPValidarMascara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarMascara') DROP FUNCTION fnPCPValidarMascara
GO
CREATE FUNCTION fnPCPValidarMascara 
	(
	@ClavePresupuestal				varchar(50),
	@ClavePresupuestalMascara		varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @LongitudMascara	int,
    @Contador			int,
    @Salir				bit,
    @CaracterMascara	char(1),
    @CaracterClave		char(1)    

  SET @Salir = 0
  SET @Resultado = 1      
  SET @LongitudMascara = LEN(@ClavePresupuestalMascara)  

  IF LEN(@ClavePresupuestalMascara) <> @LongitudMascara SET @Salir = 1
  
  SET @Contador = 1
  WHILE @Contador <= @LongitudMascara AND @Salir = 0
  BEGIN
    SET @CaracterClave = SUBSTRING(@ClavePresupuestal,@Contador,1)    
    SET @CaracterMascara = SUBSTRING(@ClavePresupuestalMascara,@Contador,1)
    
    IF (@CaracterClave <> @CaracterMascara) AND @CaracterMascara <> '?' SELECT @Resultado = 0, @Salir = 1
    SET @Contador = @Contador + 1
  END
     
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarMascaraFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarMascaraFecha') DROP FUNCTION fnPCPValidarMascaraFecha
GO
CREATE FUNCTION fnPCPValidarMascaraFecha 
	(
	@Fecha							varchar(10),
	@Mascara						varchar(10) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @LongitudMascara	int,
    @Contador			int,
    @Salir				bit,
    @CaracterMascara	char(1),
    @CaracterFecha		char(1)    

  SET @Salir = 0
  SET @Resultado = 1      
  SET @LongitudMascara = LEN(@Mascara)  

  IF LEN(@Fecha) <> @LongitudMascara SELECT @Salir = 1, @Resultado = 0
  
  SET @Contador = 1
  WHILE @Contador <= @LongitudMascara AND @Salir = 0
  BEGIN
    SET @CaracterFecha = SUBSTRING(@Fecha,@Contador,1)    
    SET @CaracterMascara = SUBSTRING(@Mascara,@Contador,1)
    
    IF (@CaracterFecha <> @CaracterMascara) AND @CaracterMascara <> '?' SELECT @Resultado = 0, @Salir = 1
    SET @Contador = @Contador + 1
  END
     
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarReglaVigencia ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarReglaVigencia') DROP FUNCTION fnPCPValidarReglaVigencia
GO
CREATE FUNCTION fnPCPValidarReglaVigencia 
	(
	@ReglaID						int,
	@Fecha							datetime
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado					bit,
    @FechaD						datetime,
    @FechaA						datetime,
    @MascaraFecha				varchar(10),
    @ConRegistros				bit,
    @Salir						bit,						
    @FechaTexto					varchar(10),
    @Dia						varchar(2),
    @Mes						varchar(2),
    @Anio						varchar(4)
  
  SELECT @Resultado = 0, @ConRegistros = 0, @Salir = 0
  
  SET @Dia  = CONVERT(varchar,DATEPART(dd,@Fecha))
  SET @Mes  = CONVERT(varchar,DATEPART(mm,@Fecha))
  SET @Anio = CONVERT(varchar,DATEPART(yyyy,@Fecha))
  SELECT @FechaTexto = REPLICATE('0',2-LEN(@Dia)) + @Dia + '/' + REPLICATE('0',2-LEN(@Mes)) + @Mes + '/' + @Anio
  
  DECLARE crVigencia CURSOR FOR
   SELECT FechaD, FechaA, MascaraFecha
     FROM ProyClavePresupuestalReglaVig
    WHERE ID = @ReglaID

  OPEN crVigencia
  FETCH NEXT FROM crVigencia INTO @FechaD, @FechaA, @MascaraFecha
  WHILE @@FETCH_STATUS = 0 AND @Salir = 0
  BEGIN
    SET @ConRegistros = 1
    IF @FechaD IS NOT NULL AND @FechaA IS NOT NULL
    BEGIN
      IF @Fecha BETWEEN @FechaD AND @FechaA SELECT @Resultado = 1, @Salir = 1
    END
    
    IF @MascaraFecha IS NOT NULL
    BEGIN
      IF dbo.fnPCPValidarMascaraFecha(@FechaTexto,@MascaraFecha) = 1 SELECT @Resultado = 1, @Salir = 1   
    END
      
    FETCH NEXT FROM crVigencia INTO @FechaD, @FechaA, @MascaraFecha
  END
  CLOSE crVigencia
  DEALLOCATE crVigencia


  IF @ConRegistros = 0 SET @Resultado = 1
       
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarRegla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarRegla') DROP FUNCTION fnPCPValidarRegla
GO
CREATE FUNCTION fnPCPValidarRegla 
	(
	@ReglaID				int,
	@FechaEmision			datetime,
	@ClavePresupuestal		varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado					bit,
    @Mascara					varchar(50),
    @Tipo						varchar(20),
    @Estatus					varchar(15),
    @MascaraConcordante			bit,
    @FechaConcordante			bit

  SET @Resultado = 1
  
  SELECT @Mascara = Mascara, @Tipo = Tipo, @Estatus = Estatus FROM ProyClavePresupuestalRegla WHERE RID = @ReglaID
  
  IF @Estatus = 'Activo'
  BEGIN
    SELECT @MascaraConcordante = dbo.fnPCPValidarMascara(@ClavePresupuestal,@Mascara)
    SELECT @FechaConcordante = dbo.fnPCPValidarReglaVigencia(@ReglaID,@FechaEmision) 

    IF @MascaraConcordante = 1 
    BEGIN
      IF @Tipo = 'Incluyente' AND @FechaConcordante = 0 SELECT @Resultado = 0 ELSE
      IF @Tipo = 'Excluyente' AND @FechaConcordante = 1 SELECT @Resultado = 0
    END  
  END
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarReglas ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarReglas') DROP FUNCTION fnPCPValidarReglas
GO
CREATE FUNCTION fnPCPValidarReglas 
	(
	@Proyecto				varchar(50),
	@FechaEmision			datetime,
	@ClavePresupuestal		varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado					bit,
    @Salir						bit,
    @ReglaID					int

  SELECT @Resultado = 1, @Salir = 0
  
  DECLARE crRegla CURSOR FOR
   SELECT RID
     FROM ProyClavePresupuestalRegla
    WHERE Proyecto = @Proyecto

  OPEN crRegla
  FETCH NEXT FROM crRegla INTO @ReglaID
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF dbo.fnPCPValidarRegla(@ReglaID,@FechaEmision,@ClavePresupuestal) = 0 SELECT @Resultado = 0, @Salir = 1    
    FETCH NEXT FROM crRegla INTO @ReglaID
  END
  CLOSE crRegla
  DEALLOCATE crRegla

  RETURN (@Resultado)
END
GO

--SELECT dbo.fnPCPValidarReglas('FEDERICO', @Fecha, '1111-2000-3000') 

/**************** fnPCPCatalogoTipoTieneCatalogo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTipoTieneCatalogo') DROP FUNCTION fnPCPCatalogoTipoTieneCatalogo
GO
CREATE FUNCTION fnPCPCatalogoTipoTieneCatalogo 
	(
	@CatalogoTipo			varchar(50),
	@Proyecto				varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestalCatalogo WHERE Proyecto = @Proyecto AND Tipo = @CatalogoTipo) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTieneSubCatalogo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTieneSubCatalogo') DROP FUNCTION fnPCPCatalogoTieneSubCatalogo
GO
CREATE FUNCTION fnPCPCatalogoTieneSubCatalogo 
	(
	@Catalogo				varchar(20),
	@Proyecto				varchar(50),
	@Categoria				varchar(1) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestalCatalogo cpc JOIN ClavePresupuestalCatalogo cpc1 ON ISNULL(cpc1.Rama,'') = CONVERT(varchar,cpc.RID) WHERE cpc.Proyecto = @Proyecto AND cpc.Clave = @Catalogo AND cpc.Categoria = @Categoria) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTipoExistente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTipoExistente') DROP FUNCTION fnPCPCatalogoTipoExistente
GO
CREATE FUNCTION fnPCPCatalogoTipoExistente 
	(
	@CatalogoTipo			varchar(50),
	@Proyecto				varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestalCatalogoTipo WHERE Proyecto = @Proyecto AND Tipo = @CatalogoTipo) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoExistente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoExistente') DROP FUNCTION fnPCPCatalogoExistente
GO
CREATE FUNCTION fnPCPCatalogoExistente 
	(
	@CatalogoClave			varchar(20),
	@Proyecto				varchar(50),
	@Categoria				varchar(1) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestalCatalogo WHERE Proyecto = @Proyecto AND Clave = @CatalogoClave AND Categoria = @Categoria) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPClavePresupuestalExistente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPClavePresupuestalExistente') DROP FUNCTION fnPCPClavePresupuestalExistente
GO
CREATE FUNCTION fnPCPClavePresupuestalExistente 
	(
	@ClavePresupuestal		varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestal WHERE ClavePresupuestal = @ClavePresupuestal) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoExistenteEnCategoria ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoExistenteEnCategoria') DROP FUNCTION fnPCPCatalogoExistenteEnCategoria
GO
CREATE FUNCTION fnPCPCatalogoExistenteEnCategoria 
	(
	@CatalogoClave			varchar(20),
	@Categoria				varchar(1),
	@Proyecto				varchar(50) 
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF EXISTS(SELECT * FROM ClavePresupuestalCatalogo WHERE Proyecto = @Proyecto AND Clave = @CatalogoClave AND Categoria = @Categoria) SELECT @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTipoCategoria ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTipoCategoria') DROP FUNCTION fnPCPCatalogoTipoCategoria
GO
CREATE FUNCTION fnPCPCatalogoTipoCategoria 
	(
	@CatalogoTipo			varchar(50),
	@Proyecto				varchar(50) 
	)
RETURNS varchar(1)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(1)

  SELECT @Resultado = ''
  
  SELECT @Resultado = Categoria FROM ClavePresupuestalCatalogoTipo WHERE Tipo = @CatalogoTipo AND Proyecto = @Proyecto
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPEnsamblarClavePresupuestal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPEnsamblarClavePresupuestal') DROP FUNCTION fnPCPEnsamblarClavePresupuestal
GO
CREATE FUNCTION fnPCPEnsamblarClavePresupuestal 
	(
	@ClavePresupuestalCat1			varchar(20),
	@ClavePresupuestalCat2			varchar(20),
	@ClavePresupuestalCat3			varchar(20),	
	@ClavePresupuestalCat4			varchar(20),	
	@ClavePresupuestalCat5			varchar(20),			
	@ClavePresupuestalCat6			varchar(20),
	@ClavePresupuestalCat7			varchar(20),
	@ClavePresupuestalCat8			varchar(20),	
	@ClavePresupuestalCat9			varchar(20),	
	@ClavePresupuestalCatA			varchar(20),			
	@ClavePresupuestalCatB			varchar(20),	
	@ClavePresupuestalCatC			varchar(20),				
	@Mascara						varchar(50) 
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Longitud1			int,
    @Longitud2			int,
    @Longitud3			int,
    @Longitud4			int,
    @Longitud5			int,
    @Longitud6			int,
    @Longitud7			int,
    @Longitud8			int,
    @Longitud9			int,
    @LongitudA			int,
    @LongitudB			int,
    @LongitudC			int,                
    @Contador			int,
    @LongitudMascara	int,
    @Caracter			varchar(1),
    @Resultado			varchar(50)

  SELECT 
    @Resultado = '',
    @Longitud1 = 0,
    @Longitud2 = 0,
    @Longitud3 = 0,
    @Longitud4 = 0,
    @Longitud5 = 0,
    @Longitud6 = 0,
    @Longitud7 = 0,
    @Longitud8 = 0,
    @Longitud9 = 0,
    @LongitudA = 0,
    @LongitudB = 0,
    @LongitudC = 0,
    @LongitudMascara = LEN(@Mascara),
    @Contador = 1
    
  WHILE @Contador <= @LongitudMascara
  BEGIN
    SET @Caracter = SUBSTRING(@Mascara,@Contador,1)
    IF @Caracter = '1' SET @Longitud1 = @Longitud1 + 1 ELSE
    IF @Caracter = '2' SET @Longitud2 = @Longitud2 + 1 ELSE
    IF @Caracter = '3' SET @Longitud3 = @Longitud3 + 1 ELSE
    IF @Caracter = '4' SET @Longitud4 = @Longitud4 + 1 ELSE    
    IF @Caracter = '5' SET @Longitud5 = @Longitud5 + 1 ELSE    
    IF @Caracter = '6' SET @Longitud6 = @Longitud6 + 1 ELSE
    IF @Caracter = '7' SET @Longitud7 = @Longitud7 + 1 ELSE
    IF @Caracter = '8' SET @Longitud8 = @Longitud8 + 1 ELSE
    IF @Caracter = '9' SET @Longitud9 = @Longitud9 + 1 ELSE    
    IF @Caracter = 'A' SET @LongitudA = @LongitudA + 1 ELSE    
    IF @Caracter = 'B' SET @LongitudB = @LongitudB + 1 ELSE    
    IF @Caracter = 'C' SET @LongitudC = @LongitudC + 1         
    
    SET @Contador = @Contador + 1
  END  

  SET @Mascara = REPLACE(@Mascara,REPLICATE('1',@Longitud1),ISNULL(@ClavePresupuestalCat1,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('2',@Longitud2),ISNULL(@ClavePresupuestalCat2,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('3',@Longitud3),ISNULL(@ClavePresupuestalCat3,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('4',@Longitud4),ISNULL(@ClavePresupuestalCat4,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('5',@Longitud5),ISNULL(@ClavePresupuestalCat5,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('6',@Longitud6),ISNULL(@ClavePresupuestalCat6,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('7',@Longitud7),ISNULL(@ClavePresupuestalCat7,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('8',@Longitud8),ISNULL(@ClavePresupuestalCat8,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('9',@Longitud9),ISNULL(@ClavePresupuestalCat9,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('A',@LongitudA),ISNULL(@ClavePresupuestalCatA,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('B',@LongitudB),ISNULL(@ClavePresupuestalCatB,''))               
  SET @Mascara = REPLACE(@Mascara,REPLICATE('C',@LongitudC),ISNULL(@ClavePresupuestalCatC,''))                 
  
  SET @Resultado = @Mascara
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarClaveCatalogo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarClaveCatalogo') DROP FUNCTION fnPCPValidarClaveCatalogo
GO
CREATE FUNCTION fnPCPValidarClaveCatalogo 
	(
	@Clave					varchar(20), 
	@CatalogoTipo			varchar(50),
	@Proyecto				varchar(50)
	)
	
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @Digitos			int

  SET @Resultado = 0
  SELECT @Digitos = Digitos FROM ClavePresupuestalCatalogoTipo WHERE Tipo = @CatalogoTipo AND Proyecto = @Proyecto
  IF LEN(@Clave) = @Digitos SET @Resultado = 1
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarClaveEnMascara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarClaveEnMascara') DROP FUNCTION fnPCPValidarClaveEnMascara
GO
CREATE FUNCTION fnPCPValidarClaveEnMascara 
	(
	@Clave					varchar(20), 
	@Categoria				varchar(1),
	@Mascara				varchar(50)
	)
	
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @Digitos			int,
    @Contador			int,
    @LongitudMascara	int,
    @LongitudCategoria	int,
    @Caracter			varchar(1)
    
    
  SET @Contador = 1
  SET @LongitudMascara = LEN(@Mascara)
  SET @LongitudCategoria = 0
  
  WHILE @Contador <= @LongitudMascara
  BEGIN
    SET @Caracter = SUBSTRING(@Mascara,@Contador,1)
    IF @Caracter = @Categoria SET @LongitudCategoria = @LongitudCategoria + 1  
    SET @Contador = @Contador + 1
  END
    
  SET @Resultado = 0
  
  IF LEN(@Clave) = @LongitudCategoria SET @Resultado = 1
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarDigitosCatalogoEnMascara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarDigitosCatalogoEnMascara') DROP FUNCTION fnPCPValidarDigitosCatalogoEnMascara
GO
CREATE FUNCTION fnPCPValidarDigitosCatalogoEnMascara 
	(
	@Categoria				varchar(1), 
	@Digitos				int,
	@Mascara				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit

  SELECT @Resultado = 0
  
  IF PATINDEX('%' + REPLICATE(@Categoria,@Digitos) + '%',@Mascara) > 0 AND @Digitos > 0 SET @Resultado = 1
   
  RETURN (@Resultado)
END
GO

/**************** fnPCPCategoriaEnMascara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCategoriaEnMascara') DROP FUNCTION fnPCPCategoriaEnMascara
GO
CREATE FUNCTION fnPCPCategoriaEnMascara 
	(
	@Categoria				varchar(1), 
	@Mascara				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit
  
  SET @Resultado = 0
  IF PATINDEX('%' + @Categoria + '%', @Mascara) > 0 SELECT @Resultado = 1
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTipoRama ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTipoRama') DROP FUNCTION fnPCPCatalogoTipoRama
GO
CREATE FUNCTION fnPCPCatalogoTipoRama 
	(
	@Proyecto				varchar(50), 
	@CatalogoTipo			varchar(50)
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)
  
  SELECT @Resultado = ISNULL(Rama,'') FROM ClavePresupuestalCatalogoTipo WHERE RTRIM(Proyecto) = RTRIM(@Proyecto) AND Tipo = RTRIM(@CatalogoTipo)
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTipo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTipo') DROP FUNCTION fnPCPCatalogoTipo
GO
CREATE FUNCTION fnPCPCatalogoTipo 
	(
	@Proyecto				varchar(50), 
	@Catalogo				varchar(20)
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)
  
  SELECT @Resultado = ISNULL(Tipo,'') FROM ClavePresupuestalCatalogo WHERE RTRIM(Proyecto) = RTRIM(@Proyecto) AND Clave = RTRIM(@Catalogo)
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoClave ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoClave') DROP FUNCTION fnPCPCatalogoClave
GO
CREATE FUNCTION fnPCPCatalogoClave 
	(
	@RID					int 
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)
  
  SELECT @Resultado = ISNULL(Clave,'') FROM ClavePresupuestalCatalogo WHERE RID = @RID
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoNombre ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoNombre') DROP FUNCTION fnPCPCatalogoNombre
GO
CREATE FUNCTION fnPCPCatalogoNombre 
	(
	@Proyecto				varchar(50),
	@Clave					varchar(20)
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)
  
  SELECT @Resultado = ISNULL(Nombre,'') FROM ClavePresupuestalCatalogo WHERE Clave = @Clave AND Proyecto = @Proyecto
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoTechoPresupuesto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoTechoPresupuesto') DROP FUNCTION fnPCPCatalogoTechoPresupuesto
GO
CREATE FUNCTION fnPCPCatalogoTechoPresupuesto 
	(
	@Proyecto				varchar(50),	
	@Clave					varchar(20)
	)
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	money
  
  SELECT @Resultado = ISNULL(TechoPresupuesto,0.0) FROM ClavePresupuestalCatalogo WHERE Clave = @Clave AND Proyecto = @Proyecto
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoDescripcion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoDescripcion') DROP FUNCTION fnPCPCatalogoDescripcion
GO
CREATE FUNCTION fnPCPCatalogoDescripcion 
	(
	@Proyecto				varchar(50),	
	@Clave					varchar(20)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)
  
  SELECT @Resultado = ISNULL(Descripcion,'') FROM ClavePresupuestalCatalogo WHERE Clave = @Clave AND Proyecto = @Proyecto
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPCatalogoObservaciones ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPCatalogoObservaciones') DROP FUNCTION fnPCPCatalogoObservaciones
GO
CREATE FUNCTION fnPCPCatalogoObservaciones 
	(
	@Proyecto				varchar(50),	
	@Clave					varchar(20)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)
  
  SELECT @Resultado = ISNULL(Descripcion,'') FROM ClavePresupuestalCatalogo WHERE Clave = @Clave AND Proyecto = @Proyecto
  
  RETURN (@Resultado)
END
GO

--SQL('SELECT dbo.fnPCPValidarClaveEnMascara(:tClave,:tCategoria,:tMascara)',PCPD:PCPD.ClavePresupuestalCat1,'1',PCP:PCP.ClavePresupuestalMascara) Y (SQL('SELECT dbo.fnPCPCatalogoExistenteEnCategoria(:tClave,:tCategoria,:tProyecto)',PCPD:PCPD.ClavePresupuestalCat1,'1',PCP:PCP.Proyecto))

/**************** fnPCPClavePresupuestalExtraerCategoria ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPClavePresupuestalExtraerCategoria') DROP FUNCTION fnPCPClavePresupuestalExtraerCategoria
GO
CREATE FUNCTION fnPCPClavePresupuestalExtraerCategoria 
	(
	@Categoria				varchar(1),
	@Mascara				varchar(50),
	@ClavePresupuestal		varchar(50)	
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				varchar(20),
    @PosicionInicial		int,
    @PosicionFinal			int,
    @Longitud				int
    
  SELECT @Resultado = ''
  
  SELECT @PosicionInicial = CHARINDEX(@Categoria,@Mascara)
  
  IF @PosicionInicial <> 0
  BEGIN
    SELECT @PosicionFinal = LEN(@Mascara) - CHARINDEX(@Categoria,REVERSE(@Mascara))
  
    SET @Longitud = @PosicionFinal - @PosicionInicial + 2
  
    SET @Resultado = SUBSTRING(@ClavePresupuestal,@PosicionInicial,@Longitud)
  END   
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarClavePresupuestal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarClavePresupuestal') DROP FUNCTION fnPCPValidarClavePresupuestal
GO
CREATE FUNCTION fnPCPValidarClavePresupuestal 
	(
	@Proyecto				varchar(50),	
	@Mascara				varchar(50),
	@ClavePresupuestal		varchar(50)	
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit,
    @Contador			int,
    @Categoria			varchar(1),
    @Catalogo			varchar(20),
    @Salir				bit,
    @Tipo				varchar(50),
    @Validacion			varchar(50),
    @Contador2			int,
    @Caracter			varchar(1)
  
  SELECT @Resultado = 1, @Salir = 0
  
  SELECT @Contador = 1
  
  IF LEN(@Mascara) <> LEN(@ClavePresupuestal) SELECT @Salir = 1, @Resultado = 0
  
  WHILE @Contador <= 12 AND @Salir = 0
  BEGIN
    IF @Contador < 10
      SET @Categoria = CONVERT(varchar,@Contador)
    ELSE
    BEGIN
      IF @Contador = 10 SET @Categoria = 'A' ELSE
      IF @Contador = 11 SET @Categoria = 'B' ELSE
      IF @Contador = 12 SET @Categoria = 'C'
    END
      
    IF dbo.fnPCPCategoriaEnMascara(@Categoria,@Mascara) = 1 
    BEGIN
      SELECT @Catalogo = dbo.fnPCPClavePresupuestalExtraerCategoria(@Categoria,@Mascara,@ClavePresupuestal)
      
      SELECT @Validacion = NULL, @Tipo = NULL
      SELECT 
        @Tipo = cpc.Tipo,
        @Validacion = cpct.Validacion 
        FROM ClavePresupuestalCatalogo cpc JOIN ClavePresupuestalCatalogoTipo cpct
          ON cpc.Tipo = cpct.Tipo AND cpc.Proyecto = cpct.Proyecto
       WHERE cpc.Clave = @Catalogo 
         AND cpc.Proyecto = @Proyecto 
         AND cpc.Categoria = @Categoria
      
      IF @Tipo IS NULL SELECT @Resultado = 0, @Salir = 1
            
      IF @Salir = 0
      BEGIN
        SET @Contador2 = 1
        WHILE @Contador2 <= LEN(@Catalogo) AND @Salir = 0
        BEGIN
          SET @Caracter = SUBSTRING(@Catalogo,@Contador2,1)
          IF @Validacion = 'Numerico' AND @Caracter NOT IN ('1','2','3','4','5','6','7','8','9','0') SELECT @Salir = 1, @Resultado = 0 ELSE
          IF @Validacion = 'Alfabetico' AND @Caracter NOT IN ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','Ñ','O','P','Q','R','S','T','U','V','W','X','Y','Z') SELECT @Salir = 1, @Resultado = 0 ELSE
          IF @Validacion = 'Alfanumerico' AND @Caracter NOT IN ('1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','Ñ','O','P','Q','R','S','T','U','V','W','X','Y','Z') SELECT @Salir = 1, @Resultado = 0
          
          SET @Contador2 = @Contador2 + 1
        END

      END
    END 
    
    SET @Contador = @Contador + 1
  END  
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPValidarMascaraRegla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPValidarMascaraRegla') DROP FUNCTION fnPCPValidarMascaraRegla
GO
CREATE FUNCTION fnPCPValidarMascaraRegla 
	(
	@Proyecto				varchar(50),	
	@Mascara				varchar(50),
	@MascaraRegla			varchar(50)	
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			bit
  
  SELECT @Resultado = 1
  
  IF LEN(RTRIM(@Mascara)) <> LEN(RTRIM(@MascaraRegla)) SELECT @Resultado = 0
  
  RETURN (@Resultado)
END
GO

/**************** fnPCPMascaraReglaCaptura ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPCPMascaraReglaCaptura') DROP FUNCTION fnPCPMascaraReglaCaptura
GO
CREATE FUNCTION fnPCPMascaraReglaCaptura 
	(
	@Mascara				varchar(50)
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Contador			int,
    @Caracter			char(1),
    @NuevaMascara		varchar(50)
    
    
  DECLARE @Caracteres	TABLE
  (
   Caracter				char(1)
  )
    
  SELECT @Mascara = REPLACE(@Mascara,'1','C')
  SELECT @Mascara = REPLACE(@Mascara,'2','C')
  SELECT @Mascara = REPLACE(@Mascara,'3','C')
  SELECT @Mascara = REPLACE(@Mascara,'4','C')
  SELECT @Mascara = REPLACE(@Mascara,'5','C')
  SELECT @Mascara = REPLACE(@Mascara,'6','C')
  SELECT @Mascara = REPLACE(@Mascara,'7','C')
  SELECT @Mascara = REPLACE(@Mascara,'8','C')
  SELECT @Mascara = REPLACE(@Mascara,'9','C')
  SELECT @Mascara = REPLACE(@Mascara,'A','C')
  SELECT @Mascara = REPLACE(@Mascara,'B','C')
  SELECT @Mascara = REPLACE(@Mascara,'C','C')
  
  SELECT @NuevaMascara = @Mascara
  SET @Contador = 1
  WHILE @Contador <= LEN(@Mascara)
  BEGIN
    SET @Caracter = SUBSTRING(@Mascara,@Contador,1)
    
    IF @Caracter <> 'C' AND @Caracter NOT IN (SELECT Caracter FROM @Caracteres) 
    BEGIN
      SELECT @NuevaMascara = REPLACE(@NuevaMascara,@Caracter,'\' + @Caracter)
      INSERT @Caracteres (Caracter) VALUES (@Caracter)
    END
     
    SET @Contador = @Contador + 1
  END
  
  SELECT @NuevaMascara = '>' + @NuevaMascara
  RETURN (@NuevaMascara)
END
GO

/**************** spPCPCatalogoLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPCatalogoLista') and type = 'P') drop procedure dbo.spPCPCatalogoLista
GO             
CREATE PROCEDURE spPCPCatalogoLista
		@Estacion				int,
		@CatalogoRamaTipo		varchar(50),
		@Proyecto				varchar(50),
		@Categoria				varchar(1)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  SELECT 
    Clave, 
    Nombre
    FROM ClavePresupuestalCatalogo 
   WHERE Proyecto = @Proyecto
     AND Tipo = @CatalogoRamaTipo
     AND Categoria = @Categoria
  UNION 
  SELECT 
    Catalogo,
    Nombre
    FROM PCPDTemporalCatalogoRama    
   WHERE CatalogoTipo = @CatalogoRamaTipo
     AND Estacion = @Estacion 
     AND Categoria = @Categoria
END
GO

/**************** spPCPInsertarTemporalRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPInsertarTemporalRama') and type = 'P') drop procedure dbo.spPCPInsertarTemporalRama
GO             
CREATE PROCEDURE spPCPInsertarTemporalRama
		@Estacion				int,
		@CatalogoRamaTipo		varchar(50),
		@Categoria				varchar(1)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  IF NOT EXISTS(SELECT * FROM PCPDTemporalRama WHERE CatalogoRamaTipo = @CatalogoRamaTipo AND Estacion = @Estacion AND Categoria = @Categoria) 
    INSERT PCPDTemporalRama (Estacion, CatalogoRamaTipo, Categoria) VALUES (@Estacion, @CatalogoRamaTipo, @Categoria)

END
GO

/**************** spPCPInicializarTemporalRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPInicializarTemporalRama') and type = 'P') drop procedure dbo.spPCPInicializarTemporalRama
GO             
CREATE PROCEDURE spPCPInicializarTemporalRama
		@Estacion				int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DELETE FROM PCPDTemporalRama WHERE Estacion = @Estacion 
END
GO


/**************** spPCPInsertarTemporalCatalogoRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPInsertarTemporalCatalogoRama') and type = 'P') drop procedure dbo.spPCPInsertarTemporalCatalogoRama
GO             
CREATE PROCEDURE spPCPInsertarTemporalCatalogoRama
		@Estacion				int,
		@CatalogoTipo			varchar(50),
		@Catalogo				varchar(20),
		@Nombre					varchar(50),
		@Categoria				varchar(1)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @RID				int
  
  IF NOT EXISTS(SELECT * FROM PCPDTemporalCatalogoRama WHERE CatalogoTipo = @CatalogoTipo AND Catalogo = @Catalogo AND Estacion = @Estacion /*AND Nombre = @Nombre*/ AND @Categoria = @Categoria)  
    INSERT PCPDTemporalCatalogoRama (Estacion, CatalogoTipo, Catalogo, Nombre, Categoria) VALUES (@Estacion, @CatalogoTipo, @Catalogo, @Nombre, @Categoria)
  ELSE
  BEGIN
    SELECT @RID = RID FROM PCPDTemporalCatalogoRama WHERE CatalogoTipo = @CatalogoTipo AND Catalogo = @Catalogo AND Estacion = @Estacion /*AND Nombre = @Nombre*/ AND @Categoria = @Categoria
    UPDATE PCPDTemporalCatalogoRama
       SET Nombre = @Nombre
     WHERE RID = @RID  
  END
    

END
GO

/**************** spPCPInicializarTemporalCatalogoRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPInicializarTemporalCatalogoRama') and type = 'P') drop procedure dbo.spPCPInicializarTemporalCatalogoRama
GO             
CREATE PROCEDURE spPCPInicializarTemporalCatalogoRama
		@Estacion				int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DELETE FROM PCPDTemporalCatalogoRama WHERE Estacion = @Estacion 
END
GO


/**************** spClavePresupuestalEnMascara ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spClavePresupuestalEnMascara') AND Type = 'P') DROP PROCEDURE dbo.spClavePresupuestalEnMascara
GO             
-- Este sp divide la clave conforme la mascara para poder validar
CREATE PROCEDURE spClavePresupuestalEnMascara 
	     @Proyecto		varchar(50),
	     @ClavePresupuestal	varchar(50),
	     
	     @Cat1		varchar(50) OUTPUT,
	     @Cat2		varchar(50) OUTPUT,
	     @Cat3		varchar(50) OUTPUT,
	     @Cat4		varchar(50) OUTPUT,
	     @Cat5		varchar(50) OUTPUT,
	     @Cat6		varchar(50) OUTPUT,
	     @Cat7		varchar(50) OUTPUT,
	     @Cat8		varchar(50) OUTPUT,
	     @Cat9		varchar(50) OUTPUT,
	     @CatA		varchar(50) OUTPUT,
	     @CatB		varchar(50) OUTPUT,
	     @CatC		varchar(50) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Mascara		varchar(50),
	  @MascaraReves		varchar(50),
	  @MascaraLargo		int,
	  @Inicio1		int,
	  @Fin1			int,
	  @Inicio2		int,
	  @Fin2			int,
	  @Inicio3		int,
	  @Fin3			int,
	  @Inicio4		int,
	  @Fin4			int,
	  @Inicio5		int,
	  @Fin5			int,
	  @Inicio6		int,
	  @Fin6			int,
	  @Inicio7		int,
	  @Fin7			int,
	  @Inicio8		int,
	  @Fin8			int,
	  @Inicio9		int,
	  @Fin9			int,
	  @InicioA		int,
	  @FinA			int,
	  @InicioB		int,
	  @FinB			int,
	  @InicioC		int,
	  @FinC			int
	  
  SELECT @Mascara = p.ClavePresupuestalMascara,
	 @MascaraReves = REVERSE(p.ClavePresupuestalMascara),
	 @MascaraLargo = LEN(p.ClavePresupuestalMascara)
    FROM Proy p
   WHERE p.Proyecto = @Proyecto    
  
   SELECT @Inicio1 = CHARINDEX('1', @Mascara),
          @Fin1	   = ((@MascaraLargo - CHARINDEX('1', @MascaraReves)) +2) - @Inicio1,
          @Inicio2 = CHARINDEX('2', @Mascara),
          @Fin2	   = ((@MascaraLargo - CHARINDEX('2', @MascaraReves)) +2) - @Inicio2,
          @Inicio3 = CHARINDEX('3', @Mascara),
          @Fin3	   = ((@MascaraLargo - CHARINDEX('3', @MascaraReves)) +2) - @Inicio3,
          @Inicio4 = CHARINDEX('4', @Mascara),
          @Fin4	   = ((@MascaraLargo - CHARINDEX('4', @MascaraReves)) +2) - @Inicio4,
          @Inicio5 = CHARINDEX('5', @Mascara),
          @Fin5	   = ((@MascaraLargo - CHARINDEX('5', @MascaraReves)) +2) - @Inicio5,
          @Inicio6 = CHARINDEX('6', @Mascara),
          @Fin6	   = ((@MascaraLargo - CHARINDEX('6', @MascaraReves)) +2) - @Inicio6,
          @Inicio7 = CHARINDEX('7', @Mascara),
          @Fin7	   = ((@MascaraLargo - CHARINDEX('7', @MascaraReves)) +2) - @Inicio7,
          @Inicio8 = CHARINDEX('8', @Mascara),
          @Fin8	   = ((@MascaraLargo - CHARINDEX('8', @MascaraReves)) +2) - @Inicio8,
          @Inicio9 = CHARINDEX('9', @Mascara),
          @Fin9	   = ((@MascaraLargo - CHARINDEX('9', @MascaraReves)) +2) - @Inicio9,
          @InicioA = CHARINDEX('A', @Mascara),
          @FinA	   = ((@MascaraLargo - CHARINDEX('A', @MascaraReves)) +2) - @InicioA,
          @InicioB = CHARINDEX('B', @Mascara),
          @FinB	   = ((@MascaraLargo - CHARINDEX('B', @MascaraReves)) +2) - @InicioB,
          @InicioC = CHARINDEX('C', @Mascara),
          @FinC	   = ((@MascaraLargo - CHARINDEX('C', @MascaraReves)) +2) - @InicioC
   
   SELECT @Cat1 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio1,0), @Fin1),
	  @Cat2 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio2,0), @Fin2),
	  @Cat3 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio3,0), @Fin3),
	  @Cat4 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio4,0), @Fin4),
	  @Cat5 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio5,0), @Fin5),
	  @Cat6 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio6,0), @Fin6),
	  @Cat7 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio7,0), @Fin7),
	  @Cat8 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio8,0), @Fin8),
	  @Cat9 = SUBSTRING(@ClavePresupuestal, NULLIF(@Inicio9,0), @Fin9),
	  @CatA = SUBSTRING(@ClavePresupuestal, NULLIF(@InicioA,0), @FinA),
	  @CatB = SUBSTRING(@ClavePresupuestal, NULLIF(@InicioB,0), @FinB),
	  @CatC = SUBSTRING(@ClavePresupuestal, NULLIF(@InicioC,0), @FinC)
  RETURN  	 
END
GO


GO
/**************** spValidarClavePresupuestalCalc ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidarClavePresupuestalCalc') AND Type = 'P') DROP PROCEDURE dbo.spValidarClavePresupuestalCalc
GO             
--Este sp valida que cada categoria de la mascara corresponda con un tipo
CREATE PROCEDURE spValidarClavePresupuestalCalc
	    @Proyecto		varchar(50),
  	    @ClavePresupuestal	varchar(50),
  	    @Ok			int		OUTPUT,
	    @OkRef		varchar(255)	OUTPUT
WITH ENCRYPTION 
AS BEGIN
  DECLARE @Cat1			varchar(50),
	  @Cat2			varchar(50),
	  @Cat3			varchar(50),
	  @Cat4			varchar(50),
	  @Cat5			varchar(50),
	  @Cat6			varchar(50),
	  @Cat7			varchar(50),
	  @Cat8			varchar(50),
	  @Cat9			varchar(50),
	  @CatA			varchar(50),
	  @CatB			varchar(50),
	  @CatC			varchar(50),
	  
	  @CatGeneral		varchar(50),

	  @Largo		int,
	  @PosicionInicial	int,
	  @PosicionCategoria	int,
	  @Concatenacion	varchar(50),
	  
	  @Tipo			varchar(50),
	  @Digitos		int,
	  @Validacion		varchar(50),
	  @Caracter		varchar(1),
	  @Categoria		int	

  SELECT @Ok = NULL,
	 @OkRef = NULL,
	 @Concatenacion = NULL,
	 @Categoria = 0
	 	  
  EXEC spClavePresupuestalEnMascara @Proyecto, @ClavePresupuestal, @Cat1 OUTPUT, @Cat2 OUTPUT, @Cat3 OUTPUT, @Cat4 OUTPUT, @Cat5 OUTPUT, @Cat6 OUTPUT, @Cat7 OUTPUT, @Cat8 OUTPUT, @Cat9 OUTPUT, @CatA OUTPUT, @CatB OUTPUT, @CatC OUTPUT

  WHILE @Categoria <= 12 AND @Ok IS NULL
  BEGIN	
    SELECT @Categoria = @Categoria + 1    
    SELECT @CatGeneral = CASE WHEN @Categoria = 1 THEN @Cat1
			      WHEN @Categoria = 2 THEN @Cat2
			      WHEN @Categoria = 3 THEN @Cat3
			      WHEN @Categoria = 4 THEN @Cat4
			      WHEN @Categoria = 5 THEN @Cat5
			      WHEN @Categoria = 6 THEN @Cat6
			      WHEN @Categoria = 7 THEN @Cat7
			      WHEN @Categoria = 8 THEN @Cat8
			      WHEN @Categoria = 9 THEN @Cat9
			      WHEN @Categoria = 10 THEN @CatA
			      WHEN @Categoria = 11 THEN @CatB
			      WHEN @Categoria = 12 THEN @CatC
			  END 		

    DECLARE crTipos CURSOR LOCAL FOR
     SELECT cpct.Tipo,
  	    cpct.Digitos,
	    cpct.Validacion
       FROM ClavePresupuestalCatalogoTipo cpct
      WHERE cpct.Proyecto = @Proyecto
        AND cpct.Categoria = CASE WHEN @Categoria = 10 THEN 'A'
				     WHEN @Categoria = 11 THEN 'B'
				     WHEN @Categoria = 12 THEN 'C'
				     ELSE CONVERT(varchar, @Categoria)
			        END
      ORDER BY RID
      
    OPEN crTipos
    FETCH NEXT FROM crTipos INTO @Tipo, @Digitos, @Validacion
  	 
    SELECT @Largo = LEN(@CatGeneral),
  	   @PosicionInicial = 1  
  	   
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN		
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @PosicionInicial = 1 
        SELECT @PosicionCategoria = 1
        WHILE @PosicionCategoria <= @Digitos AND @Ok IS NULL
        BEGIN
          SELECT @Caracter = SUBSTRING(@CatGeneral, @PosicionInicial, 1), @PosicionInicial = @PosicionInicial + 1, @PosicionCategoria = @PosicionCategoria + 1
   	         
   	      SELECT @Concatenacion = CASE WHEN @Concatenacion IS NULL THEN CONVERT(varchar,@Caracter) ELSE CONVERT(varchar, @Concatenacion) + CONVERT(varchar,@Caracter) END
    	 
    	  --Validar que el tipo de datos sea correcto
    	  IF (@Validacion = 'Numerico' AND @Caracter NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9'))
    	     OR (@Validacion = 'Alfabetico' AND @Caracter NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'))
    	     OR (@Validacion = 'Alfanumerico' AND @Caracter NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'Ñ', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'))
    	    SELECT @Ok = 10060 
    	 
    	  --Validar que exista un valor de categoria en dicha posicion
    	  IF @PosicionCategoria = @Digitos + 1
    	  BEGIN
    	    IF NOT EXISTS(SELECT * 
    	                    FROM ClavePresupuestalCatalogo cpc
    	                   WHERE cpc.Clave = @Concatenacion 
    	                     AND cpc.Categoria = CASE WHEN @Categoria = 10 THEN 'A'
						      WHEN @Categoria = 11 THEN 'B'
						      WHEN @Categoria = 12 THEN 'C'
						 ELSE CONVERT(varchar, @Categoria)
						 END
			     AND cpc.Tipo = @Tipo)
      	      SELECT @Ok = 10260 
    	    SELECT @Concatenacion = NULL
    	  END  
        END
      END
      FETCH NEXT FROM crTipos INTO @Tipo, @Digitos, @Validacion
    END
    CLOSE crTipos
    DEALLOCATE crTipos
  END
  RETURN		
END
GO

/**************** spValidarClavePresupuestal ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.spValidarClavePresupuestal') AND Type = 'P') DROP PROCEDURE dbo.spValidarClavePresupuestal
GO             
--Este sp se valida que cada categoria de la mascara corresponda con un tipo
CREATE PROCEDURE spValidarClavePresupuestal
	    @Proyecto		varchar(50),
  	    @ClavePresupuestal	varchar(50)
WITH ENCRYPTION
AS BEGIN  	    
  DECLARE @Ok	 int,		
	  @OkRef varchar(255)
	  
  EXEC spValidarClavePresupuestalCalc @Proyecto, @ClavePresupuestal, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Ok IS NULL
    SELECT 1
  ELSE
    SELECT 0  
END	    
GO

/********************************** tgClavePresupuestalDesgloseCat ********************************/
-- Con este Trigger se separa la clave presupuestal y se inserta en la tabla ClavePresupuestal separado
IF EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.tgClavePresupuestalDesgloseCat') AND sysstat & 0xf = 8) DROP Trigger dbo.tgClavePresupuestalDesgloseCat
GO
CREATE TRIGGER tgClavePresupuestalDesgloseCat ON ClavePresupuestal 
FOR INSERT, UPDATE
AS
BEGIN
  
  UPDATE ClavePresupuestal
     SET 
       Categoria1 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('1',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria2 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('2',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria3 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('3',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria4 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('4',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria5 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('5',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),                            
       Categoria6 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('6',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria7 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('7',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria8 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('8',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       Categoria9 = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('9',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       CategoriaA = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('A',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),                            
       CategoriaB = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('B',p.ClavePresupuestalMascara,cp.ClavePresupuestal),''),
       CategoriaC = NULLIF(dbo.fnPCPClavePresupuestalExtraerCategoria('C',p.ClavePresupuestalMascara,cp.ClavePresupuestal),'')       
    FROM ClavePresupuestal cp JOIN Inserted i
      ON i.ClavePresupuestal = cp.ClavePresupuestal JOIN Proy p
      ON p.Proyecto = cp.Proyecto

END
GO

/**************** spPCPVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPVerificar') and type = 'P') drop procedure dbo.spPCPVerificar
GO
CREATE PROCEDURE spPCPVerificar
    		    @ID               			int,
				@Accion						char(20),
    		    @Empresa          			char(5),
				@Usuario					char(10),
    		    @Modulo	      				char(5),
    		    @Mov              			char(20),
	            @MovID						varchar(20),
    		    @MovTipo	      			char(20),
				@MovMoneda					char(10),
			    @MovTipoCambio				float,
			    @FechaEmision				datetime,
			    @Estatus					char(15),
				@EstatusNuevo				char(15),

				@Conexion					bit,
				@SincroFinal				bit,
				@Sucursal					int,
    		    @Ok               			int          OUTPUT,
    		    @OkRef            			varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Proyecto					varchar(50),
    @ClavePresupuestalMascara	varchar(50),
    @FechaInicio				datetime,
    @FechaFin					datetime,
    @Origen	                    varchar(20),
    @OrigenID                   varchar(20),
    @Categoria					varchar(1),
    @CategoriaPredominante		varchar(1),
    @SubMovTipo					varchar(20)					    					

  SELECT @SubMovTipo = SubClave FROM MovTipo WHERE Modulo = 'PCP' AND Mov = @Mov
  
  SELECT
    @Proyecto = Proyecto,
    @ClavePresupuestalMascara = ClavePresupuestalMascara,
    @FechaInicio = FechaInicio,
    @FechaFin = FechaFin,
    @Origen = Origen,
    @OrigenID = OrigenID,
    @Categoria = NULLIF(Categoria,''),
    @CategoriaPredominante = NULLIF(CategoriaPredominante,'')
    FROM PCP
   WHERE ID = @ID 
  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	    SELECT @Ok = 60070
	    
	IF @MovTipo IN ('PCP.E') AND @Estatus IN ('PENDIENTE') AND EXISTS(SELECT * FROM PCPD WHERE dbo.fnPCPCatalogoTipoTieneCatalogo(CatalogoTipoTipo,@Proyecto) = 1 AND ID = @ID) AND @Ok IS NULL SELECT @Ok = 73600, @OkRef = CatalogoTipoTipo FROM PCPD WHERE dbo.fnPCPCatalogoTipoTieneCatalogo(CatalogoTipoTipo,@Proyecto) = 1 AND ID = @ID   
    IF @MovTipo IN ('PCP.CAT') AND @Estatus IN ('CONCLUIDO') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTieneSubCatalogo(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73710, @OkRef = pd.CatalogoClave FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTieneSubCatalogo(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID            	
	IF @MovTipo IN ('PCP.PP') AND @Estatus IN ('PENDIENTE') AND EXISTS(SELECT * FROM MovFlujo WHERE OID = @ID AND OModulo = 'PCP' AND ISNULL(Cancelado,0) = 0) AND @Ok IS NULL SELECT @Ok = 73870, @OkRef = ISNULL(@Mov,'') + ' ' + ISNULL(@MovID,'') 
  END ELSE
  IF @Accion = 'AFECTAR'
  BEGIN
    IF @MovTipo IN ('PCP.PP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM Proy WHERE Proyecto = @Proyecto) SELECT @Ok = 26025, @OkRef = @Proyecto ELSE
    IF @MovTipo IN ('PCP.PP','PCP.E','PCP.EA','PCP.CAT','PCP.MC','PCP.EC','PCP.CP','PCP.ECP','PCP.P','PCP.PC','PCP.R','PCP.ER') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @Proyecto IS NULL AND @Ok IS NULL SELECT @Ok = 15010 ELSE
    IF @MovTipo IN ('PCP.PP','PCP.E','PCP.EA','PCP.CAT','PCP.MC','PCP.EC','PCP.CP','PCP.ECP','PCP.P','PCP.PC','PCP.R','PCP.ER') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @ClavePresupuestalMascara IS NULL AND @Ok IS NULL SELECT @Ok = 73500 ELSE
    IF @MovTipo IN ('PCP.E','PCP.EA','PCP.CAT','PCP.MC','PCP.EC','PCP.CP','PCP.P','PCP.R') AND @SubMovTipo NOT IN ('PCP.CPEX','PCP.REX') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND NOT EXISTS(SELECT * FROM PCP p JOIN MovTipo mt ON mt.Mov = p.Mov AND mt.Modulo = 'PCP' WHERE mt.Clave = 'PCP.PP' AND p.Estatus IN ('PENDIENTE') AND p.Proyecto = @Proyecto) AND @Ok IS NULL SELECT @Ok = 73830, @OkRef = @Proyecto ELSE    
    IF @MovTipo IN ('PCP.ECP','PCP.ER') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND NOT EXISTS(SELECT * FROM PCP p JOIN MovTipo mt ON mt.Mov = p.Mov AND mt.Modulo = 'PCP' WHERE ((mt.Clave = 'PCP.PP' AND p.Estatus IN ('PENDIENTE')) OR (mt.Clave = 'PCP.P' AND p.Estatus IN ('VIGENTE'))) AND p.Proyecto = @Proyecto) AND @Ok IS NULL SELECT @Ok = 73860, @OkRef = @Proyecto ELSE    
    IF ((@MovTipo IN ('PCP.CP') AND @SubMovTipo IN ('PCP.CPEX')) OR (@MovTipo IN ('PCP.R') AND @SubMovTipo IN ('PCP.REX')) OR @MovTipo IN ('PCP.PC'))AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND NOT EXISTS(SELECT * FROM PCP p JOIN MovTipo mt ON mt.Mov = p.Mov AND mt.Modulo = 'PCP' WHERE mt.Clave = 'PCP.P' AND p.Estatus IN ('VIGENTE') AND p.Proyecto = @Proyecto) AND @Ok IS NULL SELECT @Ok = 73850, @OkRef = @Proyecto ELSE    
    IF @MovTipo IN ('PCP.PP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @FechaInicio IS NULL AND @Ok IS NULL SELECT @Ok = 55240 ELSE
    IF @MovTipo IN ('PCP.PP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @FechaFin IS NULL AND @Ok IS NULL SELECT @Ok = 55240 ELSE
    IF @MovTipo IN ('PCP.PP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @FechaInicio > @FechaFin AND @Ok IS NULL SELECT @Ok = 55090 ELSE
    --IF @MovTipo IN ('PCP.E','PCP.CP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND NOT EXISTS(SELECT * FROM PCP p JOIN MovTipo mt ON mt.Mov = p.Mov AND mt.Modulo = 'PCP' WHERE p.Mov = @Origen AND p.MovID = @OrigenID AND p.Empresa = @Empresa AND p.Estatus = 'PENDIENTE') AND @Ok IS NULL SELECT @Ok = 20380 ELSE
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCP p JOIN MovTipo mt ON p.Mov = mt.Mov AND mt.Modulo = 'PCP' WHERE mt.Clave = 'PCP.E' AND p.Estatus IN ('PENDIENTE','CONCLUIDO') AND p.Origen = @Origen AND p.OrigenID = @OrigenID AND p.Categoria = @Categoria) AND @Ok IS NULL SELECT @Ok = 73510, @OkRef = @Categoria ELSE
    IF @MovTipo IN ('PCP.E','PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @Categoria IS NULL AND @Ok IS NULL SELECT @Ok = 73530
    IF @MovTipo IN ('PCP.E''PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND dbo.fnPCPCategoriaEnMascara(@Categoria,@ClavePresupuestalMascara) = 0 AND @Ok IS NULL SELECT @Ok = 73520, @OkRef = @Categoria ELSE   
    IF @MovTipo IN ('PCP.PP','PCP.CP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND @CategoriaPredominante IS NULL AND @Ok IS NULL SELECT @Ok = 73530        
    IF @MovTipo IN ('PCP.PP''PCP.CP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND dbo.fnPCPCategoriaEnMascara(@CategoriaPredominante,@ClavePresupuestalMascara) = 0 AND @Ok IS NULL SELECT @Ok = 73520, @OkRef = @Categoria ELSE   
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND CatalogoTipoTipo = CatalogoTipoRama) AND @Ok IS NULL SELECT @Ok = 73540, @OkRef = CatalogoTipoTipo FROM  PCPD WHERE ID = @ID AND CatalogoTipoTipo = CatalogoTipoRama ELSE       
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoDigitos,0) IS NULL) AND @Ok IS NULL SELECT @Ok = 73550, @OkRef = CatalogoTipoTipo FROM  PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoDigitos,0) IS NULL ELSE 
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoValidacion,'') IS NULL) AND @Ok IS NULL SELECT @Ok = 73560, @OkRef = CatalogoTipoTipo FROM  PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoValidacion,'') IS NULL ELSE     
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND CatalogoTipoValidacion NOT IN ('Numerico','Alfabetico','Alfanumerico','Abierto')) AND @Ok IS NULL SELECT @Ok = 73570, @OkRef = CatalogoTipoTipo FROM  PCPD WHERE ID = @ID AND CatalogoTipoValidacion NOT IN ('Numerico','Alfabetico','Alfanumerico','Abierto') ELSE
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND dbo.fnPCPValidarDigitosCatalogoEnMascara(@Categoria,CatalogoTipoDigitos,@ClavePresupuestalMascara) = 0) AND @Ok IS NULL SELECT @Ok = 73550, @OkRef = CatalogoTipoTipo FROM PCPD WHERE ID = @ID AND dbo.fnPCPValidarDigitosCatalogoEnMascara(@Categoria,CatalogoTipoDigitos,@ClavePresupuestalMascara) = 0 ELSE
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoExistente(pd.CatalogoTipoTipo,p.Proyecto) = 1 AND pd.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73580, @OkRef = pd.CatalogoTipoTipo FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoExistente(pd.CatalogoTipoTipo,p.Proyecto) = 1 AND pd.ID = @ID ELSE   
    IF @MovTipo IN ('PCP.E') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoRama,'') IS NOT NULL AND NULLIF(CatalogoTipoRama,'') NOT IN (SELECT CatalogoTipoTipo FROM PCPD WHERE ID = @ID)) AND @Ok IS NULL SELECT @Ok = 73590, @OkRef = CatalogoTipoTipo FROM PCPD WHERE ID = @ID AND NULLIF(CatalogoTipoRama,'') IS NOT NULL AND NULLIF(CatalogoTipoRama,'') NOT IN (SELECT CatalogoTipoTipo FROM PCPD WHERE ID = @ID) ELSE
    IF @MovTipo IN ('PCP.E','PCP.EA','PCP.CAT','PCP.MC','PCP.EC','PCP.CP','PCP.EC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND NOT EXISTS(SELECT * FROM PCPD WHERE ID = @ID) AND @Ok IS NULL SELECT @Ok = 73610 ELSE
    IF @MovTipo IN ('PCP.E','PCP.EA') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT TOP 1 COUNT(*) FROM PCPD WHERE ID = @ID GROUP BY CatalogoTipoTipo HAVING COUNT(*) > 1) AND @Ok IS NULL SELECT TOP 1 @Ok = 73620, @OkRef = CatalogoTipoTipo FROM PCPD WHERE ID = @ID GROUP BY CatalogoTipoTipo HAVING COUNT(*) > 1 ELSE
    IF @MovTipo IN ('PCP.CAT','PCP.MC','PCP.EC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ISNULL(NULLIF(CatalogoTipo,''),'') = '' AND ID = @ID) AND @Ok IS NULL SELECT @Ok = 73650, @OkRef = CatalogoClave FROM PCPD WHERE ISNULL(NULLIF(CatalogoTipo,''),'') = '' AND ID = @ID ELSE        
    IF @MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoExistente(pd.CatalogoTipo,p.Proyecto) = 0 AND p.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73630, @OkRef = pd.CatalogoTipo FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoExistente(pd.CatalogoTipo,p.Proyecto) = 0 AND p.ID = @ID
    IF @MovTipo IN ('PCP.CAT') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarClaveCatalogo(pd.CatalogoClave,pd.CatalogoTipo,p.Proyecto) = 0 AND p.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73550, @OkRef = pd.CatalogoTipo FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarClaveCatalogo(pd.CatalogoClave,pd.CatalogoTipo,p.Proyecto) = 0 AND p.ID = @ID ELSE
    IF @MovTipo IN ('PCP.CAT') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID LEFT OUTER JOIN PCPD pd2 ON NULLIF(pd.CatalogoRama,'') = pd2.CatalogoClave AND pd2.ID = pd.ID LEFT OUTER JOIN ClavePresupuestalCatalogo cpc ON cpc.Clave = pd.CatalogoRama and cpc.Proyecto = p.Proyecto WHERE NULLIF(pd.CatalogoRama,'') IS NOT NULL AND pd2.CatalogoClave IS NULL AND cpc.Clave IS NULL AND p.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73690, @OkRef = PD.CatalogoRama FROM PCPD pd JOIN PCP p ON p.ID = pd.ID LEFT OUTER JOIN PCPD pd2 ON NULLIF(pd.CatalogoRama,'') = pd2.CatalogoClave AND pd2.ID = pd.ID LEFT OUTER JOIN ClavePresupuestalCatalogo cpc ON cpc.Clave = pd.CatalogoRama and cpc.Proyecto = p.Proyecto WHERE NULLIF(pd.CatalogoRama,'') IS NOT NULL AND pd2.CatalogoClave IS NULL AND cpc.Clave IS NULL AND p.ID = @ID ELSE
    IF @MovTipo IN ('PCP.CAT','PCP.MC','PCP.EC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT TOP 1 COUNT(*) FROM PCPD WHERE ID = @ID GROUP BY CatalogoClave HAVING COUNT(*) > 1) AND @Ok IS NULL SELECT TOP 1 @Ok = 73640, @OkRef = CatalogoClave FROM PCPD WHERE ID = @ID GROUP BY CatalogoClave HAVING COUNT(*) > 1 ELSE
    IF @MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoCategoria(pd.Catalogotipo,p.Proyecto) <> p.Categoria AND p.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73520, @OkRef = p.Categoria FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTipoCategoria(pd.Catalogotipo,p.Proyecto) <> p.Categoria AND p.ID = @ID ELSE
    IF @MovTipo IN ('PCP.CAT') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ID = @ID AND CatalogoClave = CatalogoRama) AND @Ok IS NULL SELECT @Ok = 73670, @OkRef = CatalogoClave FROM  PCPD WHERE ID = @ID AND CatalogoClave = CatalogoRama ELSE
    IF @MovTipo IN ('PCP.CAT') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoExistente(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73680, @OkRef = pd.CatalogoClave FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoExistente(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID ELSE       
    IF @MovTipo IN ('PCP.EC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTieneSubCatalogo(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID) AND @Ok IS NULL SELECT @Ok = 73710, @OkRef = pd.CatalogoClave FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPCatalogoTieneSubCatalogo(pd.CatalogoClave,p.Proyecto,p.Categoria) = 1 AND pd.ID = @ID ELSE
    IF @MovTipo IN ('PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE pd.CatalogoTipo <> dbo.fnPCPCatalogoTipo(p.Proyecto,pd.CatalogoClave) AND p.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73720, @OkRef = pd.CatalogoClave FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE pd.CatalogoTipo <> dbo.fnPCPCatalogoTipo(p.Proyecto,pd.CatalogoClave) AND p.ID = @ID ELSE             
    IF @MovTipo IN ('PCP.CP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarClavePresupuestal(p.Proyecto,p.ClavePresupuestalMascara,pd.ClavePresupuestal) = 0 AND p.ID = @ID)  AND @Ok IS NULL SELECT @Ok = 73730, @OkRef = pd.ClavePresupuestal FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarClavePresupuestal(p.Proyecto,p.ClavePresupuestalMascara,pd.ClavePresupuestal) = 0 AND p.ID = @ID ELSE            
    IF @MovTipo IN ('PCP.CP','PCP.ECP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT TOP 1 COUNT(*) FROM PCPD WHERE ID = @ID GROUP BY ClavePresupuestal HAVING COUNT(*) > 1) AND @Ok IS NULL SELECT TOP 1 @Ok = 73740, @OkRef = ClavePresupuestal FROM PCPD WHERE ID = @ID GROUP BY ClavePresupuestal HAVING COUNT(*) > 1 ELSE
    IF @MovTipo IN ('PCP.ECP') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE dbo.fnPCPClavePresupuestalExistente(ClavePresupuestal) = 0 AND ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73760, @OkRef = ClavePresupuestal FROM PCPD WHERE dbo.fnPCPClavePresupuestalExistente(ClavePresupuestal) = 0 AND ID = @ID
    IF @MovTipo IN ('PCP.R') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT TOP 1 COUNT(*) FROM PCPD WHERE ID = @ID GROUP BY ReglaDescripcion HAVING COUNT(*) > 1) AND @Ok IS NULL SELECT TOP 1 @Ok = 73770, @OkRef = ReglaDescripcion FROM PCPD WHERE ID = @ID GROUP BY ReglaDescripcion HAVING COUNT(*) > 1 ELSE
    IF @MovTipo IN ('PCP.R') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarMascaraRegla(p.Proyecto,p.ClavePresupuestalMascara,pd.ReglaMascara) = 0 AND p.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73780, @OkRef = pd.ReglaMascara FROM PCPD pd JOIN PCP p ON p.ID = pd.ID WHERE dbo.fnPCPValidarMascaraRegla(p.Proyecto,p.ClavePresupuestalMascara,pd.ReglaMascara) = 0 AND p.ID = @ID ELSE
    IF @MovTipo IN ('PCP.R') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD WHERE ReglaTipo NOT IN ('Incluyente','Excluyente') AND ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73790, @OkRef = ReglaDescripcion FROM PCPD WHERE ReglaTipo NOT IN ('Incluyente','Excluyente') AND ID = @ID ELSE   
    IF @MovTipo IN ('PCP.R') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCPDRegla pdr ON pdr.ID = pd.ID AND pdr.Renglon = pd.Renglon WHERE ((pdr.FechaD IS NULL AND pdr.FechaA IS NOT NULL) OR (pdr.FechaD IS NOT NULL AND pdr.FechaA IS NULL)) AND pd.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73800, @OkRef = ReglaDescripcion FROM PCPD pd JOIN PCPDRegla pdr ON pdr.ID = pd.ID AND pdr.Renglon = pd.Renglon WHERE  ((pdr.FechaD IS NULL AND pdr.FechaA IS NOT NULL) OR (pdr.FechaD IS NOT NULL AND pdr.FechaA IS NULL)) AND pd.ID = @ID ELSE
    IF @MovTipo IN ('PCP.R') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCPDRegla pdr ON pdr.ID = pd.ID AND pdr.Renglon = pd.Renglon WHERE pdr.FechaD > pdr.FechaA AND pd.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73800, @OkRef = ReglaDescripcion FROM PCPD pd JOIN PCPDRegla pdr ON pdr.ID = pd.ID AND pdr.Renglon = pd.Renglon WHERE pdr.FechaD > pdr.FechaA AND pd.ID = @ID ELSE
    IF @MovTipo IN ('PCP.ER') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID LEFT OUTER JOIN ProyClavePresupuestalRegla pcpr ON pd.ReglaID = pcpr.RID AND p.Proyecto = pcpr.Proyecto WHERE pcpr.RID IS NULL AND pd.ID = @ID) AND @Ok IS NULL SELECT TOP 1 @Ok = 73810, @OkRef = ReglaID FROM PCPD pd JOIN PCP p ON p.ID = pd.ID LEFT OUTER JOIN ProyClavePresupuestalRegla pcpr ON pd.ReglaID = pcpr.RID AND p.Proyecto = pcpr.Proyecto WHERE pcpr.RID IS NULL AND pd.ID = @ID ELSE
    IF @MovTipo IN ('PCP.ER') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND EXISTS(SELECT TOP 1 COUNT(*) FROM PCPD WHERE ID = @ID GROUP BY ReglaID HAVING COUNT(*) > 1) AND @Ok IS NULL SELECT TOP 1 @Ok = 73820, @OkRef = ReglaID FROM PCPD WHERE ID = @ID GROUP BY ReglaID HAVING COUNT(*) > 1
 
    --Valida que la aplicacion de la estructura aprobada a la estructura sea correcta
    IF @MovTipo IN ('PCP.EA') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND 
       EXISTS(SELECT 
                 * 
                FROM PCPD pd JOIN PCP p 
                  ON p.ID = pd.ID LEFT OUTER JOIN PCP o 
                  ON o.Mov = pd.Aplica AND o.MovID = pd.AplicaID AND o.Empresa = p.Empresa AND o.Estatus = 'PENDIENTE' LEFT OUTER JOIN PCPD od 
                  ON od.CatalogoTipoTipo = pd.CatalogoTipoTipo AND od.ID = o.ID AND od.Estatus = 'PENDIENTE' LEFT OUTER JOIN MovTipo mt 
                  ON mt.Mov = o.Mov AND mt.Modulo = 'PCP' 
               WHERE mt.Clave = 'PCP.E' 
                 AND (od.CatalogoTipoTipo IS NULL OR (pd.Aplica <> ISNULL(p.Origen,pd.Aplica) OR pd.AplicaID <> ISNULL(p.OrigenID,pd.AplicaID)))
                 AND p.ID = @ID) AND 
       @Ok IS NULL 
       SELECT 
          TOP 1 @Ok = 20180, 
                @OkRef = pd.CatalogoTipoTipo 
                FROM PCPD pd JOIN PCP p 
                  ON p.ID = pd.ID LEFT OUTER JOIN PCP o 
                  ON o.Mov = pd.Aplica AND o.MovID = pd.AplicaID AND o.Empresa = p.Empresa AND o.Estatus = 'PENDIENTE' LEFT OUTER JOIN PCPD od 
                  ON od.CatalogoTipoTipo = pd.CatalogoTipoTipo AND od.ID = o.ID AND od.Estatus = 'PENDIENTE' LEFT OUTER JOIN MovTipo mt 
                  ON mt.Mov = o.Mov AND mt.Modulo = 'PCP' 
               WHERE mt.Clave = 'PCP.E' 
                 AND (od.CatalogoTipoTipo IS NULL OR (pd.Aplica <> ISNULL(p.Origen,pd.Aplica) OR pd.AplicaID <> ISNULL(p.OrigenID,pd.AplicaID)))
                 AND p.ID = @ID

    --Valida que la adicion, eliminacion o modificacion de los catalogos sea correcta de acuerdo a el estatus de los tipos de catalogos (Valida solo el encabezado).
    IF @MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND 
       NOT EXISTS(SELECT 
                 * 
                FROM PCPD pd JOIN PCP p 
                  ON p.ID = pd.ID LEFT OUTER JOIN PCP o
                  ON o.Proyecto = p.Proyecto AND o.Categoria = p.Categoria AND o.Empresa = p.Empresa AND o.Estatus = 'PENDIENTE' LEFT OUTER JOIN MovTipo mt 
                  ON mt.Mov = o.Mov AND mt.Modulo = 'PCP' 
               WHERE mt.Clave = 'PCP.E' 
                 AND p.ID = @ID) AND 
       @Ok IS NULL 
       SELECT @Ok = 73700
                                  
    --Valida que la adicion, eliminacion o modificacion de los catalogos sea correcta de acuerdo a el estatus de los tipos de catalogos (Valida a nivel detalle).
    IF @MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR') AND 
       EXISTS(SELECT 
                 * 
                FROM PCPD pd JOIN PCP p 
                  ON p.ID = pd.ID LEFT OUTER JOIN PCP o
                  ON o.Proyecto = p.Proyecto AND o.Categoria = p.Categoria AND o.Empresa = p.Empresa AND o.Estatus = 'PENDIENTE' LEFT OUTER JOIN PCPD od 
                  ON od.CatalogoTipoTipo = pd.CatalogoTipo AND od.ID = o.ID AND od.Estatus = 'PENDIENTE' LEFT OUTER JOIN MovTipo mt 
                  ON mt.Mov = o.Mov AND mt.Modulo = 'PCP' 
               WHERE mt.Clave = 'PCP.E' 
                 AND od.CatalogoTipoTipo IS NULL
                 AND p.ID = @ID) AND 
       @Ok IS NULL 
       SELECT 
          TOP 1 @Ok = 73700, 
                @OkRef = pd.CatalogoTipo 
                FROM PCPD pd JOIN PCP p 
                  ON p.ID = pd.ID LEFT OUTER JOIN PCP o
                  ON o.Proyecto = p.Proyecto AND o.Categoria = p.Categoria AND o.Empresa = p.Empresa AND o.Estatus = 'PENDIENTE' LEFT OUTER JOIN PCPD od 
                  ON od.CatalogoTipoTipo = pd.CatalogoTipo AND od.ID = o.ID AND od.Estatus = 'PENDIENTE' LEFT OUTER JOIN MovTipo mt 
                  ON mt.Mov = o.Mov AND mt.Modulo = 'PCP' 
               WHERE mt.Clave = 'PCP.E' 
                 AND od.CatalogoTipoTipo IS NULL
                 AND p.ID = @ID

                 
  END
  RETURN
END
GO

/**************** spPCPAfectarCatalogoTipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarCatalogoTipo') and type = 'P') drop procedure dbo.spPCPAfectarCatalogoTipo
GO             
CREATE PROCEDURE spPCPAfectarCatalogoTipo
		@Accion		varchar(20),
		@ID			int,
		@Proyecto	varchar(50),
		@Categoria	varchar(1),		
		@Ok			int = NULL OUTPUT,
		@OkRef		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ProcesoTerminado				bit,
    @CatalogoTipoTipo				varchar(50),
    @CatalogoTipoRama				varchar(50),
    @CatalogoTipoDigitos			int,
    @CatalogoTipoValidacion			varchar(50),
    @CatalogoTipoEsAcumulativa		bit,
    @CatalogoTipoTechoPresupuesto	bit,
    @Procesado						bit,
    @Orden							int
    
  -- SET nocount ON

  SELECT @ProcesoTerminado = 0
  
  IF @Accion IN ('AFECTAR')
  BEGIN

    DECLARE @PCPD TABLE
    (
     CatalogoTipoTipo				varchar(50),
     CatalogoTipoRama				varchar(50),
     CatalogoTipoDigitos			int,
     CatalogoTipoValidacion			varchar(50),
     CatalogoTipoEsAcumulativa		bit,
     CatalogoTipoTechoPresupuesto	bit,
     Procesado						bit,
     Orden							int identity(1,1)
    )
    
    INSERT @PCPD (CatalogoTipoTipo, CatalogoTipoRama, CatalogoTipoDigitos, CatalogoTipoValidacion, CatalogoTipoEsAcumulativa, CatalogoTipoTechoPresupuesto, Procesado)
          SELECT  CatalogoTipoTipo, CatalogoTipoRama, CatalogoTipoDigitos, CatalogoTipoValidacion, CatalogoTipoEsAcumulativa, CatalogoTipoTechoPresupuesto, 0
            FROM PCPD 
           WHERE ID = @ID 
         
    WHILE @ProcesoTerminado = 0 AND @Ok IS NULL
    BEGIN
      SET @CatalogoTipoTipo = NULL
      SELECT TOP 1 @CatalogoTipoTipo = CatalogoTipoTipo, @CatalogoTipoRama = NULLIF(CatalogoTipoRama,''), @CatalogoTipoDigitos = CatalogoTipoDigitos, @CatalogoTipoValidacion = CatalogoTipoValidacion, @CatalogoTipoEsAcumulativa = CatalogoTipoEsAcumulativa, @CatalogoTipoTechoPresupuesto = CatalogoTipoTechoPresupuesto, @Orden = Orden FROM @PCPD WHERE Procesado = 0 ORDER BY Orden
      IF @CatalogoTipoTipo IS NOT NULL
      BEGIN
        IF EXISTS(SELECT * FROM ClavePresupuestalCatalogoTipo WHERE  Proyecto = @Proyecto AND Tipo = @CatalogoTipoRama) OR @CatalogoTipoRama IS NULL
        BEGIN
        
          INSERT ClavePresupuestalCatalogoTipo (Proyecto,  Tipo,              Categoria,  Digitos,              Rama,              TechoPresupuesto,              EsAcumulativa,                                                                                      Validacion)
                                        SELECT  @Proyecto, @CatalogoTipoTipo, @Categoria, @CatalogoTipoDigitos, @CatalogoTipoRama, @CatalogoTipoTechoPresupuesto, CASE WHEN EXISTS(SELECT * FROM @PCPD WHERE CatalogoTipoRama = @CatalogoTipoTipo) THEN 1 ELSE 0 END, @CatalogoTipoValidacion
          IF @@ERROR <> 0 SET @Ok = 1                              
          
          IF @Ok IS NULL UPDATE @PCPD SET Procesado = 1 WHERE CatalogoTipoTipo = @CatalogoTipoTipo
          IF @@ERROR <> 0 SET @Ok = 1                              
        END ELSE
        BEGIN
          IF @Ok IS NULL
          BEGIN
            INSERT @PCPD (CatalogoTipoTipo,  CatalogoTipoRama,  CatalogoTipoDigitos,  CatalogoTipoValidacion,  CatalogoTipoEsAcumulativa,  CatalogoTipoTechoPresupuesto,  Procesado)        
            VALUES       (@CatalogoTipoTipo, @CatalogoTipoRama, @CatalogoTipoDigitos, @CatalogoTipoValidacion, @CatalogoTipoEsAcumulativa, @CatalogoTipoTechoPresupuesto, 0) 
            IF @@ERROR <> 0 SET @Ok = 1
            
            IF @Ok IS NULL
              DELETE FROM @PCPD WHERE Orden = @Orden        
          END
        END
      END ELSE
      IF @CatalogoTipoTipo IS NULL
        SELECT @ProcesoTerminado = 1
    END
  
  END ELSE
  IF @Accion IN ('CANCELAR')  
  BEGIN
  
  	IF EXISTS(SELECT * FROM PCPD WHERE dbo.fnPCPCatalogoTipoTieneCatalogo(CatalogoTipoTipo,@Proyecto) = 1 AND ID = @ID) AND @Ok IS NULL SELECT @Ok = 73600, @OkRef = CatalogoTipoTipo FROM PCPD WHERE dbo.fnPCPCatalogoTipoTieneCatalogo(CatalogoTipoTipo,@Proyecto) = 1 AND ID = @ID   
  	
  	IF @Ok IS NULL
      DELETE 
        FROM ClavePresupuestalCatalogoTipo 
        FROM PCPD pd JOIN PCP p
          ON p.ID = pd.ID JOIN ClavePresupuestalCatalogoTipo cpct 
          ON cpct.Tipo = pd.CatalogoTipoTipo AND cpct.Proyecto = p.Proyecto
       WHERE p.ID = @ID   
  END
END
GO

/**************** spPCPAfectarCatalogo****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarCatalogo') and type = 'P') drop procedure dbo.spPCPAfectarCatalogo
GO             
CREATE PROCEDURE spPCPAfectarCatalogo
		@Accion		varchar(20),
		@MovTipo	varchar(20),
		@ID			int,
		@Proyecto	varchar(50),
		@Categoria	varchar(1),		
		@Ok			int = NULL OUTPUT,
		@OkRef		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ProcesoTerminado				bit,
    @CatalogoClave					varchar(20),
    @CatalogoRama					varchar(20),
    @CatalogoTipo					varchar(50),
    @CatalogoRamaTipo				varchar(50),
    @CatalogoNombre					varchar(50),
    @CatalogoTechoPresupuesto		money,
    @CatalogoDescripcion			varchar(255),
    @CatalogoObservaciones			varchar(255),
    @CatalogoRID					int,
    @Procesado						bit,
    @RID							varchar(20),
    @Orden							int
    
  -- SET nocount ON
--pcpd
  SELECT @ProcesoTerminado = 0
  
  IF (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.CAT')) OR (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.EC'))
  BEGIN

    DECLARE @PCPD TABLE
    (
     CatalogoClave					varchar(20),
     CatalogoRama					varchar(20),
     CatalogoTipo					varchar(50),
     CatalogoRamaTipo				varchar(50),
     CatalogoNombre					varchar(50),
     CatalogoTechoPresupuesto		money,
     CatalogoDescripcion			varchar(255),
     CatalogoObservaciones			varchar(255),
     CatalogoRID					int,
     Procesado						bit,
     Orden							int identity(1,1)
    )
  
    IF @MovTipo IN ('PCP.CAT') AND @Accion IN ('AFECTAR')
    BEGIN    
      INSERT @PCPD (CatalogoClave, CatalogoRama, CatalogoTipo, CatalogoRamaTipo, CatalogoNombre, CatalogoTechoPresupuesto, CatalogoDescripcion, CatalogoObservaciones, CatalogoRID, Procesado)
            SELECT  CatalogoClave, CatalogoRama, CatalogoTipo, CatalogoRamaTipo, CatalogoNombre, CatalogoTechoPresupuesto, CatalogoDescripcion, CatalogoObservaciones, CatalogoRID, 0
              FROM PCPD 
             WHERE ID = @ID 
    END ELSE IF @MovTipo IN ('PCP.EC') AND @Accion IN ('CANCELAR') BEGIN
      INSERT @PCPD (CatalogoClave, CatalogoRama, CatalogoTipo, CatalogoRamaTipo, CatalogoNombre,         CatalogoTechoPresupuesto,    CatalogoDescripcion,         CatalogoObservaciones,         CatalogoRID, Procesado)
            SELECT  CatalogoClave, CatalogoRama, CatalogoTipo, CatalogoRamaTipo, CatalogoNombreAnterior, CatalogoTechoPresupuestoAnt, CatalogoDescripcionAnterior, CatalogoObservacionesAnterior, CatalogoRID, 0
              FROM PCPD 
             WHERE ID = @ID     
    END         
    
    WHILE @ProcesoTerminado = 0 AND @Ok IS NULL
    BEGIN
      SET @CatalogoClave = NULL
      SELECT TOP 1 @CatalogoClave = CatalogoClave, @CatalogoRama = NULLIF(CatalogoRama,''), @CatalogoTipo = CatalogoTipo, @CatalogoRamaTipo = CatalogoRamaTipo, @CatalogoNombre = CatalogoNombre, @CatalogoTechoPresupuesto = CatalogoTechoPresupuesto, @CatalogoDescripcion = CatalogoDescripcion, @CatalogoObservaciones = CatalogoObservaciones, @CatalogoRID = CatalogoRID, @Procesado = Procesado, @Orden = Orden FROM @PCPD WHERE Procesado = 0 ORDER BY Orden
      IF @CatalogoClave IS NOT NULL
      BEGIN
        IF EXISTS(SELECT * FROM ClavePresupuestalCatalogo WHERE  Proyecto = @Proyecto AND Clave = @CatalogoRama) OR @CatalogoRama IS NULL
        BEGIN
          SELECT @RID = CONVERT(varchar(20),RID) FROM ClavePresupuestalCatalogo WHERE Proyecto = @Proyecto AND Clave = @CatalogoRama
          INSERT ClavePresupuestalCatalogo (Proyecto,  Clave,          Tipo,          Rama,            Nombre,          TechoPresupuesto,          Descripcion,          Observaciones,          Categoria,  RamaTipo)
                                    VALUES (@Proyecto, @CatalogoClave, @CatalogoTipo, ISNULL(@RID,''), @CatalogoNombre, @CatalogoTechoPresupuesto, @CatalogoDescripcion, @CatalogoObservaciones, @Categoria, ISNULL(dbo.fnPCPCatalogoTipoRama(@Proyecto,@CatalogoTipo),''))  
          IF @@ERROR <> 0 SET @Ok = 1                              
          
          IF @Ok IS NULL UPDATE @PCPD SET Procesado = 1 WHERE CatalogoClave = @CatalogoClave
          IF @@ERROR <> 0 SET @Ok = 1                              
        END ELSE
        BEGIN
          IF @Ok IS NULL
          BEGIN
            INSERT @PCPD (CatalogoClave,  CatalogoRama,  CatalogoTipo,  CatalogoRamaTipo,  CatalogoNombre,  CatalogoTechoPresupuesto,  CatalogoDescripcion,  CatalogoObservaciones,  CatalogoRID,  Procesado)
            VALUES       (@CatalogoClave, @CatalogoRama, @CatalogoTipo, @CatalogoRamaTipo, @CatalogoNombre, @CatalogoTechoPresupuesto, @CatalogoDescripcion, @CatalogoObservaciones, @CatalogoRID, 0)            
            IF @@ERROR <> 0 SET @Ok = 1                                          
            
            IF @Ok IS NULL
              DELETE FROM @PCPD WHERE Orden = @Orden              

          END
        END
      END ELSE
      IF @CatalogoClave IS NULL
        SELECT @ProcesoTerminado = 1
    END
  
  END ELSE
  IF (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.CAT')) OR (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.EC'))
  BEGIN
	
  	IF @Ok IS NULL
  	BEGIN
  	  UPDATE PCPD 
  	     SET CatalogoNombreAnterior = cpc.Nombre,
  	         CatalogoDescripcionAnterior = cpc.Descripcion,
  	         CatalogoObservacionesAnterior = cpc.Observaciones,
  	         CatalogoTechoPresupuestoAnt = cpc.TechoPresupuesto,
  	         CatalogoRama = dbo.fnPCPCatalogoClave(cpc.Rama)
  	     FROM PCPD pd JOIN PCP p
  	       ON p.ID = pd.ID JOIN ClavePresupuestalCatalogo cpc
  	       ON cpc.Clave = pd.CatalogoClave AND cpc.Proyecto = p.Proyecto
  	    WHERE p.ID = @ID   
      IF @@ERROR <> 0 SET @Ok = 1
      
      IF @Ok IS NULL
      BEGIN
        DELETE 
          FROM ClavePresupuestalCatalogo
          FROM PCPD pd JOIN PCP p
            ON p.ID = pd.ID JOIN ClavePresupuestalCatalogo cpc 
            ON cpc.Clave = pd.CatalogoClave AND cpc.Proyecto = p.Proyecto
         WHERE p.ID = @ID   
      END   
    END     
  END ELSE
  IF @Accion IN ('AFECTAR','CANCELAR') AND @MovTipo IN ('PCP.MC')
  BEGIN
	
	IF @Accion IN ('AFECTAR')
	BEGIN
      IF @Ok IS NULL
      BEGIN
    	  UPDATE PCPD 
    	     SET CatalogoNombreAnterior = cpc.Nombre,
    	         CatalogoDescripcionAnterior = cpc.Descripcion,
    	         CatalogoObservacionesAnterior = cpc.Observaciones,
    	         CatalogoTechoPresupuestoAnt = cpc.TechoPresupuesto
    	     FROM PCPD pd JOIN PCP p
    	       ON p.ID = pd.ID JOIN ClavePresupuestalCatalogo cpc
    	       ON cpc.Clave = pd.CatalogoClave AND cpc.Proyecto = p.Proyecto
    	    WHERE p.ID = @ID   
        IF @@ERROR <> 0 SET @Ok = 1
        
        IF @Ok IS NULL
        BEGIN
          UPDATE ClavePresupuestalCatalogo
             SET Nombre = pd.CatalogoNombre,
                 TechoPresupuesto = pd.CatalogoTechoPresupuesto,
                 Descripcion = pd.CatalogoDescripcion,
                 Observaciones = pd.CatalogoObservaciones
            FROM PCPD pd JOIN PCP p
              ON p.ID = pd.ID JOIN ClavePresupuestalCatalogo cpc 
              ON cpc.Clave = pd.CatalogoClave AND cpc.Proyecto = p.Proyecto
           WHERE p.ID = @ID   
        END   
      END 
    END ELSE IF @Accion IN ('CANCELAR') BEGIN
      IF @Ok IS NULL
      BEGIN
        UPDATE ClavePresupuestalCatalogo
           SET Nombre = pd.CatalogoNombreAnterior,
               TechoPresupuesto = pd.CatalogoTechoPresupuestoAnt,
               Descripcion = pd.CatalogoDescripcionAnterior,
               Observaciones = pd.CatalogoObservacionesAnterior
          FROM PCPD pd JOIN PCP p
            ON p.ID = pd.ID JOIN ClavePresupuestalCatalogo cpc 
            ON cpc.Clave = pd.CatalogoClave AND cpc.Proyecto = p.Proyecto
         WHERE p.ID = @ID   
      END           
    END   
  END  
END
GO

/**************** spPCPAfectarClavePresupuestal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarClavePresupuestal') and type = 'P') drop procedure dbo.spPCPAfectarClavePresupuestal
GO             
CREATE PROCEDURE spPCPAfectarClavePresupuestal
		@Accion			varchar(20),
		@Usuario		varchar(10),
		@Fecha			datetime,
		@MovTipo		varchar(20),
		@ID				int,
		@Proyecto		varchar(50),
		@Categoria		varchar(1),		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN

  IF (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.CP')) OR (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.ECP'))
  BEGIN
    IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.CP')
    BEGIN
      INSERT ClavePresupuestal (ClavePresupuestal, Nombre,                  Descripcion,                  Estatus, Alta,   UltimoCambio, UsuarioCambio, Proyecto,  TieneArticulosEsp,             ObjetoGasto)  --BUG17946
                        SELECT  ClavePresupuestal, ClavePresupuestalNombre, ClavePresupuestalDescripcion, 'ALTA',  @Fecha, @Fecha,       @Usuario,      @Proyecto, ClavePresupuestalArticulosEsp, ObjetoGasto   --BUG17946
                          FROM  PCPD
                         WHERE ID = @ID 
      IF @@ERROR <> 0 SET @Ok = 1                   
    END ELSE IF @Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.ECP')
    BEGIN
      INSERT ClavePresupuestal (ClavePresupuestal, Nombre,                   Descripcion,                   Estatus, Alta,   UltimoCambio, UsuarioCambio, Proyecto,  TieneArticulosEsp,              ObjetoGasto) --BUG17946
                        SELECT  ClavePresupuestal, ClavePresupuestalNombreA, ClavePresupuestalDescripcionA, 'ALTA',  @Fecha, @Fecha,       @Usuario,      @Proyecto, ClavePresupuestalArticulosEspA, ObjetoGastoAnt --BUG17946
                          FROM  PCPD
                         WHERE ID = @ID 
      IF @@ERROR <> 0 SET @Ok = 1                       
    END
  END ELSE IF (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.CP')) OR (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.ECP'))
  BEGIN
    IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.ECP')
    BEGIN
      UPDATE PCPD
        SET ClavePresupuestalNombreA = cp.Nombre,
            ClavePresupuestalDescripcionA = cp.Descripcion,
            ClavePresupuestalArticulosEspA = cp.TieneArticulosEsp,
            ObjetoGastoAnt = cp.ObjetoGasto
        FROM ClavePresupuestal cp JOIN PCPD pd
          ON pd.ClavePresupuestal = cp.ClavePresupuestal
       WHERE pd.ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1                                   
    END
    
    DELETE
      FROM ClavePresupuestal
      FROM ClavePresupuestal cp JOIN PCPD pd
        ON pd.ClavePresupuestal = cp.ClavePresupuestal
     WHERE pd.ID = @ID
    IF @@ERROR <> 0 SET @Ok = 1                               
  END
END
GO

/**************** spPCPAfectarRegla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarRegla') and type = 'P') drop procedure dbo.spPCPAfectarRegla
GO             
CREATE PROCEDURE spPCPAfectarRegla
		@Accion			varchar(20),
		@Usuario		varchar(10),
		@Fecha			datetime,
		@MovTipo		varchar(20),
		@ID				int,
		@Proyecto		varchar(50),
		@Categoria		varchar(1),		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ReglaID				int,
    
	@ReglaOrden				int,
	@ReglaMascara			varchar(50),
	@ReglaTipo				varchar(20),
	@ReglaDescripcion		varchar(50),
	@ReglaOrdenAnt			int,
	@ReglaMascaraAnt		varchar(50),
	@ReglaTipoAnt			varchar(20),
	@ReglaDescripcionAnt	varchar(50),
	@Renglon				float    
	
  IF (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.R')) OR (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.ER'))
  BEGIN
  
    DECLARE crPCPD CURSOR FOR
     SELECT ReglaOrden, ReglaMascara, ReglaTipo, ReglaDescripcion, ReglaOrdenAnt, ReglaMascaraAnt, ReglaTipoAnt, ReglaDescripcionAnt, Renglon
       FROM PCPD
      WHERE ID = @ID

    OPEN crPCPD
    FETCH NEXT FROM crPCPD INTO @ReglaOrden, @ReglaMascara, @ReglaTipo, @ReglaDescripcion, @ReglaOrdenAnt, @ReglaMascaraAnt, @ReglaTipoAnt, @ReglaDescripcionAnt, @Renglon
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN    
      IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.R')
      BEGIN
        INSERT ProyClavePresupuestalRegla (Orden,       Proyecto,  Mascara,       Descripcion,       Tipo,       Estatus)
                                   VALUES (@ReglaOrden, @Proyecto, @ReglaMascara, @ReglaDescripcion, @ReglaTipo, 'Activo')
        IF @@ERROR <> 0 SET @Ok = 1          
        SET @ReglaID = SCOPE_IDENTITY()
               
        IF @Ok IS NULL
        BEGIN
          INSERT ProyClavePresupuestalReglaVig (ID,       FechaD, FechaA, MascaraFecha)
                                        SELECT  @ReglaID, FechaD, FechaA, MascaraFecha
                                          FROM  PCPDRegla
                                         WHERE  ID = @ID
                                           AND  Renglon = @Renglon 
          IF @@ERROR <> 0 SET @Ok = 1                                   
        END                                   
        
        IF @Ok IS NULL
        BEGIN
          UPDATE PCPD SET ReglaID = @ReglaID WHERE ID = @ID AND Renglon = @Renglon
          IF @@ERROR <> 0 SET @Ok = 1
        END  
                                                   
      END ELSE IF @Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.ER')
      BEGIN
      
        INSERT ProyClavePresupuestalRegla (Orden,          Proyecto,  Mascara,          Descripcion,          Tipo,          Estatus)
                                   VALUES (@ReglaOrdenAnt, @Proyecto, @ReglaMascaraAnt, @ReglaDescripcionAnt, @ReglaTipoAnt, 'Activo')
        IF @@ERROR <> 0 SET @Ok = 1          
        SET @ReglaID = SCOPE_IDENTITY()
               
        IF @Ok IS NULL
        BEGIN
          INSERT ProyClavePresupuestalReglaVig (ID,       FechaD, FechaA, MascaraFecha)
                                        SELECT  @ReglaID, FechaD, FechaA, MascaraFecha
                                          FROM  PCPDRegla
                                         WHERE  ID = @ID
                                           AND  Renglon = @Renglon 
          IF @@ERROR <> 0 SET @Ok = 1                                   
        END                                   

        IF @Ok IS NULL
        BEGIN
          UPDATE PCPD SET ReglaID = @ReglaID WHERE ID = @ID AND Renglon = @Renglon
          IF @@ERROR <> 0 SET @Ok = 1
        END  
      END
        
      FETCH NEXT FROM crPCPD INTO @ReglaOrden, @ReglaMascara, @ReglaTipo, @ReglaDescripcion, @ReglaOrdenAnt, @ReglaMascaraAnt, @ReglaTipoAnt, @ReglaDescripcionAnt, @Renglon 
    END
    CLOSE crPCPD
    DEALLOCATE crPCPD
    
  END ELSE IF (@Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.R')) OR (@Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.ER'))
  BEGIN
    IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.ER')
    BEGIN
      UPDATE PCPD
        SET ReglaOrdenAnt = pcpr.Orden,
            ReglaMascaraAnt = pcpr.Mascara,
            ReglaTipoAnt = pcpr.Tipo,
            ReglaDescripcionAnt = pcpr.Descripcion
        FROM ProyClavePresupuestalRegla pcpr JOIN PCPD pd
          ON pd.ReglaID = pcpr.RID
       WHERE pd.ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1                                   
    END

    IF @Ok IS NULL
    BEGIN
      DELETE
        FROM ProyClavePresupuestalReglaVig
        FROM ProyClavePresupuestalReglaVig pcprv JOIN PCPD pd
          ON pd.ReglaID = pcprv.ID
       WHERE pd.ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1 
    END
     
    IF @Ok IS NULL
    BEGIN 
      DELETE
        FROM ProyClavePresupuestalRegla
        FROM ProyClavePresupuestalRegla pcpr JOIN PCPD pd
          ON pd.ReglaID = pcpr.RID
       WHERE pd.ID = @ID
      IF @@ERROR <> 0 SET @Ok = 1                               
    END
    
  END
END
GO

/**************** spPCPAfectarConcluirPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarConcluirPresupuesto') and type = 'P') drop procedure dbo.spPCPAfectarConcluirPresupuesto
GO             
CREATE PROCEDURE spPCPAfectarConcluirPresupuesto
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@Accion			varchar(20),
		@Usuario		varchar(10),
		@Fecha			datetime,
		@MovTipo		varchar(20),
		@ID				int,
		@Proyecto		varchar(50),
		@Categoria		varchar(1),		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @IDAplica							int
    	
  IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.PC')
  BEGIN

    SELECT 
      @IDAplica = ID 
      FROM PCP p JOIN MovTipo mt 
        ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
     WHERE mt.Clave = 'PCP.P'
       AND p.Estatus = 'VIGENTE'
       AND p.Proyecto = @Proyecto
    
    IF @Ok IS NULL
      EXEC spMovEstatus 'PCP', 'CONCLUIDO', @IDAplica, 0, NULL, 0, @Ok OUTPUT
      
  END ELSE 
  IF @Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.PC')    
  BEGIN

    SELECT 
      @IDAplica = ID 
      FROM PCP p JOIN MovTipo mt 
        ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
     WHERE mt.Clave = 'PCP.P'
       AND p.Estatus = 'CONCLUIDO'
       AND p.Proyecto = @Proyecto
             
    IF @Ok IS NULL
      EXEC spMovEstatus 'PCP', 'VIGENTE', @IDAplica, 0, NULL, 0, @Ok OUTPUT
  
  END
END
GO

/**************** spPCPAfectarPresupuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectarPresupuesto') and type = 'P') drop procedure dbo.spPCPAfectarPresupuesto
GO             
CREATE PROCEDURE spPCPAfectarPresupuesto
		@Empresa		varchar(5),
		@Modulo			varchar(5),
		@Accion			varchar(20),
		@Usuario		varchar(10),
		@Fecha			datetime,
		@MovTipo		varchar(20),
		@ID				int,
		@Proyecto		varchar(50),
		@Categoria		varchar(1),		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @EstructuraID						int,
    @EstructuraAprobadaID				int,    
    @MovEstructuraAprobada				varchar(20),
    @IDGenerar							int,
    @IDAplica							int
    
    
	
  IF @Accion IN ('AFECTAR') AND @MovTipo IN ('PCP.P')
  BEGIN
  
    SELECT @MovEstructuraAprobada = PCPEstructuraAprobada FROM EmpresaCfgMovPCP WHERE Empresa = @Empresa
    SELECT 
      @IDAplica = ID 
      FROM PCP p JOIN MovTipo mt 
        ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
     WHERE mt.Clave = 'PCP.PP'
       AND p.Estatus = 'PENDIENTE'
       AND p.Proyecto = @Proyecto
           
    DECLARE crPCP CURSOR FOR
     SELECT ID
       FROM PCP p JOIN MovTipo mt
         ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
      WHERE mt.Clave = 'PCP.E' 
        AND p.Estatus IN ('PENDIENTE')
        AND p.Proyecto = @Proyecto

    OPEN crPCP
    FETCH NEXT FROM crPCP INTO @EstructuraID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN    
      EXEC @IDGenerar = spAfectar @Modulo, @EstructuraID, 'GENERAR', 'TODO', @MovEstructuraAprobada, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Fecha, 1          
              
      IF @IDGenerar IS NOT NULL AND @Ok IS NOT NULL
        EXEC spAfectar @Modulo, @IDGenerar, @Accion, 'TODO', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Fecha, 1 
      
      IF @IDGenerar IS NOT NULL AND @Ok IS NULL
        UPDATE PCP SET PresupuestoID = @ID WHERE ID = @IDGenerar
      IF @@ERROR <> 0 SET @Ok = 1  
        
      FETCH NEXT FROM crPCP INTO @EstructuraID
    END
    CLOSE crPCP
    DEALLOCATE crPCP
  
    IF @Ok IS NULL
      EXEC spMovEstatus 'PCP', 'CONCLUIDO', @IDAplica, 0, NULL, 0, @Ok OUTPUT
      
  END ELSE 
  IF @Accion IN ('CANCELAR') AND @MovTipo IN ('PCP.P')    
  BEGIN

    SELECT 
      @IDAplica = ID 
      FROM PCP p JOIN MovTipo mt 
        ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
     WHERE mt.Clave = 'PCP.PP'
       AND p.Estatus = 'CONCLUIDO'
       AND p.Proyecto = @Proyecto
           
    DECLARE crPCP CURSOR FOR
     SELECT 
       p.ID
       FROM PCP p JOIN MovTipo mt
         ON mt.Mov = p.Mov AND mt.Modulo = @Modulo
      WHERE mt.Clave = 'PCP.EA'
        AND p.Estatus = 'CONCLUIDO'
        AND p.PresupuestoID = @ID
          

    OPEN crPCP
    FETCH NEXT FROM crPCP INTO @EstructuraAprobadaID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN    

      EXEC spAfectar @Modulo, @EstructuraAprobadaID, @Accion, 'TODO', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Fecha, 1 
        
      FETCH NEXT FROM crPCP INTO @EstructuraAprobadaID
    END
    CLOSE crPCP
    DEALLOCATE crPCP
  
    IF @Ok IS NULL
      EXEC spMovEstatus 'PCP', 'PENDIENTE', @IDAplica, 0, NULL, 0, @Ok OUTPUT
  
  END
END
GO

/**************** spPCPAplicarEstructura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAplicarEstructura') and type = 'P') drop procedure dbo.spPCPAplicarEstructura
GO             
CREATE PROCEDURE spPCPAplicarEstructura
        @Empresa	varchar(5),
		@Accion		varchar(20),
		@ID			int,
		@Ok			int = NULL OUTPUT,
		@OkRef		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Aplica				varchar(20),
    @AplicaID			varchar(20),
    @CatalogoTipoTipo	varchar(50),
    @EstatusNuevo		varchar(15),
    @EstatusAnterior	varchar(15),
    @IDAplica			int
    
  SET @EstatusNuevo    = CASE WHEN @Accion = 'AFECTAR' THEN 'CONCLUIDO' ELSE 'PENDIENTE' END
  SET @EstatusAnterior = CASE WHEN @Accion = 'AFECTAR' THEN 'PENDIENTE' ELSE 'CONCLUIDO' END
     
  DECLARE crPCPD CURSOR FOR
   SELECT Aplica, AplicaID, CatalogoTipoTipo
     FROM PCPD
    WHERE ID = @ID
    ORDER BY Aplica, AplicaID, CatalogoTipoTipo

  OPEN crPCPD
  FETCH NEXT FROM crPCPD INTO @Aplica, @AplicaID, @CatalogoTipoTipo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    SELECT @IDAplica = ID FROM PCP WHERE Mov = @Aplica AND MovID = @AplicaID AND Empresa = @Empresa
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NULL
    BEGIN
      UPDATE PCPD SET Estatus = @EstatusNuevo WHERE ID = @IDAplica AND CatalogoTipoTipo = @CatalogoTipoTipo
      IF @@ERROR <> 0 SET @Ok = 1
    END
    
    IF @Ok IS NULL AND @Accion = 'AFECTAR' AND NOT EXISTS(SELECT * FROM PCPD JOIN PCP ON PCP.ID = PCPD.ID WHERE PCP.ID = @IDAplica AND PCPD.Estatus = @EstatusAnterior AND PCP.Estatus = @EstatusAnterior)
      EXEC spMovEstatus 'PCP', @EstatusNuevo, @IDAplica, 0, NULL, 0, @Ok OUTPUT

    IF @Ok IS NULL AND @Accion = 'CANCELAR' AND EXISTS(SELECT * FROM PCPD JOIN PCP ON PCP.ID = PCPD.ID WHERE PCP.ID = @IDAplica AND PCPD.Estatus = @EstatusNuevo AND PCP.Estatus = @EstatusAnterior)
      EXEC spMovEstatus 'PCP', @EstatusNuevo, @IDAplica, 0, NULL, 0, @Ok OUTPUT
     
    FETCH NEXT FROM crPCPD INTO @Aplica, @AplicaID, @CatalogoTipoTipo
  END
  CLOSE crPCPD
  DEALLOCATE crPCPD
  
END
GO

/**************** spPCPAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCPAfectar') and type = 'P') drop procedure dbo.spPCPAfectar
GO             
CREATE PROCEDURE spPCPAfectar
				@ID								int,
										
				@Accion							char(20),
				@Empresa						char(5),
				@Modulo							char(5),
				@Mov	  	      				char(20),
				@MovID             				varchar(20)	OUTPUT,
				@MovTipo						char(20),
				@MovMoneda						char(10),
				@MovTipoCambio					float,
				@FechaEmision      				datetime,
				@FechaAfectacion      	  	  	datetime,
				@FechaConclusion				datetime,
										
				@Proyecto	      				varchar(50),
				@Usuario	      				char(10),
				@Autorizacion      				char(10),
				@DocFuente	      				int,
				@Observaciones     				varchar(255),
				@Concepto     					varchar(50),
				@Referencia						varchar(50),
										
				@Estatus           				char(15),
				@EstatusNuevo	      	  	  	char(15),
				@FechaRegistro     				datetime,
				@Ejercicio	      				int,
				@Periodo	      				int,
				@MovUsuario						char(10),
										
				@Agente							varchar(10),
				@Personal						varchar(10),
				@Comentarios					text,	
				@FechaInicio					datetime,
				@FechaFin						datetime,
				@Categoria						varchar(1),
				@Tipo							varchar(15),
				@ClavePresupuestalMascara		varchar(50),
				@ProyectoDescripcion			varchar(100),

				@Conexion						bit,
				@SincroFinal					bit,
				@Sucursal						int,
				@SucursalDestino				int,
				@SucursalOrigen					int,
									
				@CfgContX						bit,
				@CfgContXGenerar				char(20),
				@GenerarPoliza					bit,
									
				@Generar						bit,
				@GenerarMov						char(20),
				@GenerarAfectado				bit,
				
				@OrigenTipo						varchar(10),
				@Origen							varchar(20),
				@OrigenID						varchar(20),
				@IDOrigen						int,
								
				@IDGenerar						int	     	OUTPUT,	
				@GenerarMovID					varchar(20)	OUTPUT,
									
				@Ok                				int          OUTPUT,
				@OkRef             				varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @FechaCancelacion	datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio	int

    
  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
    
    IF @MovTipo IN ('PCP.E') AND @GenerarMOvTipo IN ('PCP.EA') AND @Ok IS NULL
    BEGIN
      INSERT PCPD (ID,         Renglon,    CatalogoTipoTipo,    Aplica,   AplicaID)
           SELECT  @IDGenerar, pd.Renglon, pd.CatalogoTipoTipo, p.Mov,    p.MovID 
             FROM PCPD pd JOIN PCP p
               ON p.ID = pd.ID
            WHERE p.ID = @ID
              AND pd.Estatus = 'PENDIENTE'
      IF @@ERROR <> 0 SET @Ok = 1        
    END        
      
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN

      IF @Accion = 'AFECTAR' AND @MovTipo IN ('PCP.PP')
      BEGIN 
        INSERT Proy (Proyecto,  Estatus, Tipo,       ClavePresupuestalMascara,  FechaInicio,  FechaFin,  Descripcion)
             VALUES (@Proyecto, 'ALTA',  'Proyecto', @ClavePresupuestalMascara, @FechaInicio, @FechaFin, @ProyectoDescripcion)
        IF @@ERROR <> 0 SET @Ok = 1     
      END ELSE IF @Accion = 'CANCELAR' AND @MovTipo IN ('PCP.PP')
      BEGIN
        UPDATE PROY SET Estatus = 'BAJA' WHERE Proyecto = @Proyecto
        IF @@ERROR <> 0 SET @Ok = 1
      END

      IF @MovTipo IN ('PCP.E') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('PENDIENTE'))) AND @Ok IS NULL
        EXEC spPCPAfectarCatalogoTipo @Accion, @id, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT
        
      IF (@MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@MovTipo IN ('PCP.CAT','PCP.EC','PCP.MC') AND @Accion IN ('CANCELAR') AND @Estatus IN ('CONCLUIDO'))
        EXEC spPCPAfectarCatalogo @Accion, @MovTipo, @ID, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT
        
      IF @MovTipo IN ('PCP.EA') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('CONCLUIDO'))) AND @Ok IS NULL
        EXEC spPCPAplicarEstructura @Empresa, @Accion, @ID, @Ok OUTPUT, @OkRef OUTPUT

      IF @MovTipo IN ('PCP.CP','PCP.ECP') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('CONCLUIDO'))) AND @Ok IS NULL
        EXEC spPCPAfectarClavePresupuestal @Accion, @Usuario, @FechaRegistro, @MovTipo, @ID, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT

      IF @MovTipo IN ('PCP.R','PCP.ER') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('CONCLUIDO'))) AND @Ok IS NULL
        EXEC spPCPAfectarRegla @Accion, @Usuario, @FechaRegistro, @MovTipo, @ID, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT		

      IF @MovTipo IN ('PCP.P') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('VIGENTE'))) AND @Ok IS NULL
        EXEC spPCPAfectarPresupuesto @Empresa, @Modulo, @Accion, @Usuario, @FechaRegistro, @MovTipo, @ID, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT

      IF @MovTipo IN ('PCP.PC') AND ((@Accion IN ('AFECTAR') AND @Estatus IN ('SINAFECTAR','CONFIRMAR','BORRADOR')) OR (@Accion IN ('CANCELAR') AND @Estatus IN ('CONCLUIDO'))) AND @Ok IS NULL
        EXEC spPCPAfectarConcluirPresupuesto @Empresa, @Modulo, @Accion, @Usuario, @FechaRegistro, @MovTipo, @ID, @Proyecto, @Categoria, @Ok OUTPUT, @OkRef OUTPUT

      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030)
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR','VIGENTE','PENDIENTE') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR','VIGENTE','PENDIENTE') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE PCP
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Generar el Flujo
    IF @IDOrigen IS NOT NULL AND @Accion IN ('AFECTAR') AND @Ok IS NULL  
      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @OrigenTipo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, 0

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

/**************** spPCP ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPCP') and type = 'P') drop procedure dbo.spPCP
GO
CREATE PROCEDURE spPCP
					@ID						int,
					@Modulo					char(5),
					@Accion					char(20),
					@Base					char(20),
					@FechaRegistro			datetime,
					@GenerarMov				char(20),
					@Usuario				char(10),
					@Conexion				bit,
					@SincroFinal			bit,
					@Mov					char(20)	OUTPUT,
					@MovID					varchar(20)	OUTPUT,
					@IDGenerar				int		OUTPUT,

					@Ok						int		OUTPUT,
					@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar							bit,
    @GenerarAfectado					bit,
    @Sucursal							int,
    @SucursalDestino					int,
    @SucursalOrigen						int,
    @EnLinea							bit,
    @PuedeEditar						bit,
    @Empresa	      					char(5),
    @MovTipo   							char(20),
    @MovMoneda							char(10),
    @MovTipoCambio						float,
    @FechaEmision     					datetime,
    @FechaAfectacion					datetime,
    @FechaConclusion					datetime,
    @Proyecto	      					varchar(50),
    @MovUsuario	      					char(10),
    @Autorizacion     					char(10),
    @DocFuente	      					int,
    @Concepto    						varchar(50),
    @Referencia 						varchar(50),
    @Observaciones    					varchar(255),
    @Estatus          					char(15),
    @EstatusNuevo						char(15),
    @Ejercicio	      					int,
    @Periodo	      					int,
    @GenerarMovID						varchar(20),
    @GenerarPoliza						bit,
    @CfgContX							bit,
    @CfgContXGenerar					char(20),
    @Agente								varchar(10),
    @Personal							varchar(10),
    @Comentarios						varchar(MAX),	
	@FechaInicio						datetime,
	@FechaFin							datetime,
	@Categoria							varchar(1),
	@Tipo								varchar(15),
	@ClavePresupuestalMascara			varchar(50),
	@ProyectoDescripcion				varchar(100),
	@OrigenTipo							varchar(10),
	@Origen								varchar(20),
	@OrigenID							varchar(20),
	@IDOrigen							int
         
  -- Inicializar Variables
  SELECT @Generar	   = 0,
         @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, 
         @SucursalDestino = SucursalDestino, 
         @SucursalOrigen = SucursalOrigen, 
         @Empresa = Empresa, 
         @MovID = MovID, 
         @Mov = Mov, 
         @FechaEmision = FechaEmision, 
         @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, 
         @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, 
         @MovTipoCambio = TipoCambio,
         @DocFuente = DocFuente, 
         @Observaciones = Observaciones, 
         @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, 
         @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, 
         @Referencia = Referencia, 
         @Agente = Agente,         
         @Personal = Personal,
         @Comentarios = Comentarios,
         @FechaInicio = FechaInicio,
         @FechaFin = FechaFin,
         @Categoria = Categoria,
         @Tipo = Tipo,
         @ClavePresupuestalMascara = ClavePresupuestalMascara,
         @ProyectoDescripcion = ProyectoDescripcion,
         @OrigenTipo = OrigenTipo,
         @Origen = Origen,
         @OrigenID = OrigenID
    FROM PCP
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF @OrigenTipo = 'PCP' SELECT @IDOrigen = ID FROM PCP WHERE MovID = @OrigenID AND Mov = @Origen AND Empresa = @Empresa
  
  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1 
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE','VIGENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE','VIGENTE'))
  BEGIN
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
  
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF @MovTipo IN ('PCP.PP','PCP.E') SELECT @EstatusNuevo = 'PENDIENTE' ELSE
      IF @MovTipo IN ('PCP.P') SELECT @EstatusNuevo = 'VIGENTE' ELSE
      IF @MovTipo IN ('PCP.EA','PCP.C','PCP.MC','PCP.EC','PCP.R','PCP.ER','PCP.CP','PCP.ECP') SELECT @EstatusNuevo = 'CONCLUIDO'
    END      

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spPCPVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	             @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT
          	             
      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spPCPAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			   @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
				           @Agente, @Personal, @Comentarios, @FechaInicio, @FechaFin, @Categoria, @Tipo, @ClavePresupuestalMascara, @ProyectoDescripcion,
		           @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                           @Generar, @GenerarMov, @GenerarAfectado, @OrigenTipo, @Origen, @OrigenID, @IDOrigen, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
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

--/* DEMO */ spAfectar 'PCP', 40, 'GENERAR', 'Todo', 'Presupuesto', 'DEMO', @Estacion=3

--spAfectar 'PCP', 69, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=4

--SELECT * FROM EMPRESACFGMOVPCP
--/* DEMO */ spAfectar 'PCP', 74, 'GENERAR', 'Todo', 'Catalogo', 'DEMO', @Estacion=5


--spAfectar 'PCP', 400, 'CANCELAR', 'Todo', NULL, 'DEMO', @Estacion=2

--spAfectar 'PCP', 417, 'AFECTAR', 'Todo', NULL, 'DEMO', @Estacion=2
--SELECT * FROM PCPD pd JOIN PCP p ON p.ID = pd.ID LEFT OUTER JOIN PCPD pd2 ON NULLIF(pd.CatalogoRama,'') = pd2.CatalogoClave AND pd2.ID = pd.ID WHERE NULLIF(pd.CatalogoRama,'') IS NOT NULL AND pd2.CatalogoClave IS NULL AND p.ID = 415
