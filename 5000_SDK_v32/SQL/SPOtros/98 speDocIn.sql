
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET ANSI_WARNINGS OFF
GO
EXEC sp_configure 'show advanced option', '1'  
GO
RECONFIGURE WITH OVERRIDE 
GO
EXEC sp_configure 'Ole Automation Procedures', '1'  
GO
RECONFIGURE WITH OVERRIDE   
GO
EXEC sp_configure 'xp_cmdshell', '1'  
GO
RECONFIGURE WITH OVERRIDE   
GO
EXEC sp_configure N'Database Mail XPs', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2012', 'Microsoft SQL Server 2014' , 'Microsoft SQL Server 2016')
EXEC sp_configure N'SQL Mail XPs', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO




/**************** fneDocInXmlns ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInXmlns') DROP FUNCTION fneDocInXmlns
GO
CREATE FUNCTION fneDocInXmlns 
	(
	@XML				varchar(max),
	@ConNodo			bit = 0
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado			int,
    @EstadoAnterior		int,
    @Prefijo			varchar(max),
    @Nombre			varchar(max)
    
  SET @Resultado = ''
      
  IF NULLIF(@XML,'') IS NULL RETURN @Resultado
  
  DECLARE @xmlns TABLE
  (
   Prefijo					varchar(max) COLLATE DATABASE_DEFAULT NULL,
   Nombre					varchar(max) COLLATE DATABASE_DEFAULT NULL
  )  
  
  SET @Longitud = LEN(@XML)
  SET @Contador = 1
  SET @Estado = 0
  SET @Prefijo = ''
  SET @Nombre  = ''
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = 'X'			  SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('M')	  SET @Estado = 0 ELSE        
    IF @Estado = 1 AND @Caracter = 'M'			  SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter NOT IN ('L')	  SET @Estado = 0 ELSE            
    IF @Estado = 2 AND @Caracter = 'L'			  SET @Estado = 3 ELSE    
    IF @Estado = 3 AND @Caracter NOT IN ('N')	  SET @Estado = 0 ELSE            
    IF @Estado = 3 AND @Caracter = 'N'			  SET @Estado = 4 ELSE        
    IF @Estado = 4 AND @Caracter NOT IN ('S')	  SET @Estado = 0 ELSE                
    IF @Estado = 4 AND @Caracter = 'S'			  SET @Estado = 5 ELSE
    IF @Estado = 5 AND @Caracter NOT IN (char(58),'=') SET @Estado = 0 ELSE                
    IF @Estado = 5 AND @Caracter = char(58)	  SET @Estado = 6 ELSE
    IF @Estado = 5 AND @Caracter = '='			  SET @Estado = 7 ELSE
    IF @Estado = 6 AND @Caracter = '='     	      SET @Estado = 7 ELSE
    IF @Estado = 7 AND @Caracter NOT IN ('"')	  SET @Estado = 0 ELSE                        
    IF @Estado = 7 AND @Caracter = '"'     	      SET @Estado = 8 ELSE            
    IF @Estado = 8 AND @Caracter = '"'     	      SET @Estado = 9
    
    IF @Estado = 6 AND @EstadoAnterior = 6
    BEGIN
      SET @Prefijo = @Prefijo + @Caracter
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8
    BEGIN
      SET @Nombre = @Nombre + @Caracter
    END ELSE IF @Estado = 9
    BEGIN
      IF NULLIF(@Nombre,'') IS NOT NULL
      BEGIN
        INSERT @xmlns (Prefijo, Nombre) VALUES (NULLIF(@Prefijo,''), NULLIF(@Nombre,''))
      END
      SET @Prefijo = ''
      SET @Nombre = ''
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END  

  IF @ConNodo = 1 AND EXISTS(SELECT 1 FROM @xmlns)
  BEGIN
    SET @Resultado = '<ns '
  END
  
  DECLARE crXMLNS CURSOR FOR
   SELECT Prefijo, Nombre
     FROM @xmlns
    ORDER BY Prefijo
    
  OPEN crXMLNS
  FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Prefijo IS NULL
    BEGIN
      IF @ConNodo = 0
      BEGIN
        SET @Resultado = @Resultado + 'declare default element namespace ' + CHAR(34) + RTRIM(ISNULL(@Nombre,'')) + CHAR(34) + '; '
      END ELSE IF @ConNodo = 1
      BEGIN
        SET @Resultado = @Resultado + 'xmlns=' + CHAR(34) + RTRIM(ISNULL(@Nombre,'')) + CHAR(34) + ' '
      END
    END ELSE IF @Prefijo IS NOT NULL
    BEGIN
      IF @ConNodo = 0
      BEGIN
        SET @Resultado = @Resultado + 'declare namespace ' + RTRIM(ISNULL(@Prefijo,'')) + '=' + CHAR(34) + RTRIM(ISNULL(@Nombre,'')) + CHAR(34) + '; '
      END ELSE IF @ConNodo = 1
      BEGIN
        SET @Resultado = @Resultado + 'xmlns' + CHAR(58) + RTRIM(ISNULL(@Prefijo,'')) + '=' + CHAR(34) + RTRIM(ISNULL(@Nombre,'')) + CHAR(34) + ' '
      END
        
    END

    FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  END
  CLOSE crXMLNS
  DEALLOCATE crXMLNS

  IF @ConNodo = 1 AND EXISTS(SELECT 1 FROM @xmlns)
  BEGIN
    SET @Resultado = @Resultado + '/>'
  END
    
  
  RETURN @Resultado
END
GO



/**************** fneDocInBorrarXmlnsOmision ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInBorrarXmlnsOmision') DROP FUNCTION fneDocInBorrarXmlnsOmision
GO
CREATE FUNCTION fneDocInBorrarXmlnsOmision 
	(
	@XML				varchar(max)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @xmlns				varchar(max)
    
  SET @Resultado = ''
      
  IF NULLIF(@XML,'') IS NULL RETURN @Resultado
  
  SET @Longitud = LEN(@XML)
  SET @Contador = 1
  SET @Estado = 0
  SET @xmlns = ''
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = 'X'			  SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('M')	  SET @Estado = 0 ELSE        
    IF @Estado = 1 AND @Caracter = 'M'			  SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter NOT IN ('L')	  SET @Estado = 0 ELSE            
    IF @Estado = 2 AND @Caracter = 'L'			  SET @Estado = 3 ELSE    
    IF @Estado = 3 AND @Caracter NOT IN ('N')	  SET @Estado = 0 ELSE            
    IF @Estado = 3 AND @Caracter = 'N'			  SET @Estado = 4 ELSE        
    IF @Estado = 4 AND @Caracter NOT IN ('S')	  SET @Estado = 0 ELSE                
    IF @Estado = 4 AND @Caracter = 'S'			  SET @Estado = 5 ELSE
    IF @Estado = 5 AND @Caracter NOT IN ('=')     SET @Estado = 0 ELSE                
    IF @Estado = 5 AND @Caracter = '='			  SET @Estado = 7 ELSE
    IF @Estado = 7 AND @Caracter NOT IN ('"')	  SET @Estado = 0 ELSE                        
    IF @Estado = 7 AND @Caracter = '"'     	      SET @Estado = 8 ELSE            
    IF @Estado = 8 AND @Caracter = '"'     	      SET @Estado = 9
    
    IF @Estado = 0
    BEGIN
      SET @Xmlns = ''
    END ELSE IF @Estado > 0 AND @Estado < 9 
    BEGIN
      SET @Xmlns = @Xmlns + @Caracter
    END ELSE IF @Estado = 9
    BEGIN
      SET @Xmlns = @Xmlns + @Caracter
      SET @XML = REPLACE(@XML,@Xmlns,'');
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END  

  SET @Resultado = @XML    
  
  RETURN @Resultado
END
GO


/******************************* speDocInInsertarConsecutivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInInsertarConsecutivo') and type = 'P') drop procedure dbo.speDocInInsertarConsecutivo
GO             
CREATE PROCEDURE speDocInInsertarConsecutivo
		@XML				xml OUTPUT,
		@Path				varchar(max),
		@ConsecutivoNombre		varchar(255),
		@ConsecutivoInicial		int,
		@ConsecutivoIncremento	        int,
		@Ok				int = NULL OUTPUT,
		@OkRef				varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @CantidadElementos		int,
    @SQL					nvarchar(max),
    @Path2					varchar(max),
    @UltimoCaracter			char(1),
    @Contador				int,
    @Error					int,
    @ErrorRef				varchar(255),
    @XMLNS					nvarchar(max)

  SELECT @Error = NULL, @ErrorRef = NULL    
  
  SET @UltimoCaracter = SUBSTRING(@Path,LEN(@Path),1)  
  IF  @UltimoCaracter = '/'  
  BEGIN
    SET @Path2 = SUBSTRING(@Path,1,LEN(@Path)-1)
  END  
  ELSE IF @UltimoCaracter <> '/'
  BEGIN
    SET @Path2 = @Path
    SET @Path = @Path + '/'     
  END        

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +             
             N'BEGIN TRY ' +              
             N'  SET @CantidadElementos = @xml.query(' + CHAR(39) + @XMLNS + '  count(' + ISNULL(@Path,'') + '/.)' + CHAR(39) + ').value(' + CHAR(39) + '.' + CHAR(39) + ',' + CHAR(39) + 'int' + CHAR(39) + ') ' + 
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @ErrorRef = ' + CHAR(39) + N'Error '+ CHAR(39) + N' + CONVERT(varchar,@Error) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @ErrorRef ' +
             N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH ' 

  EXEC sp_executesql @SQL, N'@XML xml, @CantidadElementos int OUTPUT, @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT', @XML = @XML, @CantidadElementos = @CantidadElementos OUTPUT, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT

  IF @Error IS NOT NULL SELECT @Ok = 72310, @OkRef = 'Error al insertar consecutivo '+@Path+' '+CONVERT(varchar,@Error) + '. ' + SUBSTRING(ISNULL(@ErrorRef,''),1,200)    
  
  IF @Ok IS NULL AND @CantidadElementos > 0
  BEGIN
    SET @SQL = N'SET ANSI_NULLS ON ' +
               N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +
               N'BEGIN TRY '                
    SET @Contador = 1
    WHILE @Contador <= @CantidadElementos
    BEGIN
      SET @SQL = @SQL + N'SET @XML.modify(' + CHAR(39) + @XMLNS + ' insert attribute ' + ISNULL(@ConsecutivoNombre,'') + ' {' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@ConsecutivoInicial,1)))) + '} into (' + ISNULL(@Path2,'') + ')[' + RTRIM(LTRIM(CONVERT(varchar,@Contador))) + ']' + CHAR(39) + ') '  
      SET @ConsecutivoInicial = @ConsecutivoInicial + @ConsecutivoIncremento
      SET @Contador = @Contador + 1    
    END
    
    SET @SQL = @SQL + 
               N'END TRY ' + 
               N'BEGIN CATCH ' +
               N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
               N'  IF XACT_STATE() = -1 ' +
               N'  BEGIN ' +
               N'    ROLLBACK TRAN ' +
               N'    SET @ErrorRef = ' + CHAR(39) + N'Error  ' +CHAR(39) + N' + CONVERT(varchar,@Error) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @ErrorRef ' +
               N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
               N'  END ' + 
               N'END CATCH ' 

    EXEC sp_executesql @SQL, N'@XML xml OUTPUT, @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT', @XML = @XML OUTPUT, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT
    IF @Error IS NOT NULL SELECT @Ok = 72310, @OkRef = 'Error al insertar consecutivo '+@Path+' '+CONVERT(varchar,@Error) + '. ' + SUBSTRING(ISNULL(@ErrorRef,''),1,200)    
  END
END
GO



/******************************* speDocInInsertarConsecutivos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInInsertarConsecutivos') and type = 'P') drop procedure dbo.speDocInInsertarConsecutivos
GO             
CREATE PROCEDURE speDocInInsertarConsecutivos
		@eDocIn					varchar(50),
		@Ruta					varchar(50),
		@XML					xml = NULL OUTPUT,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Tabla						varchar(50),
  @ConsecutivoNombre			varchar(100),
  @ConsecutivoInicial			int,
  @ConsecutivoIncremento		int,
  @CampoXMLRuta					varchar(max),
  @CampoXMLAtributo				varchar(255)			  

  SELECT @XML = CONVERT(xml,ISNULL(NULLIF(CONVERT(varchar(max),@XML),''),Documento)) FROM eDocIn WHERE eDocIn = @eDocIn
  
  IF NULLIF(CONVERT(varchar(max),@XML),'') IS NULL SELECT @Ok = 72230, @OkRef = '(' + @eDocIn + ')'
  
  DECLARE creDocInRutaTablaD CURSOR FOR
   SELECT RTRIM(ISNULL(ConsecutivoNombre,'')), ConsecutivoInicial, ConsecutivoIncremento, RTRIM(ISNULL(CampoXMLRuta,'')), RTRIM(ISNULL(CampoXMLAtributo,'')), RTRIM(ISNULL(Tablas,''))
     FROM eDocInRutaTablaD
    WHERE ISNULL(EsConsecutivo,0) = 1
      AND Ruta = @Ruta
      AND eDocIn = @eDocIn

  OPEN creDocInRutaTablaD
  FETCH NEXT FROM creDocInRutaTablaD INTO @ConsecutivoNombre, @ConsecutivoInicial, @ConsecutivoIncremento, @CampoXMLRuta, @CampoXMLAtributo, @Tabla
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    
    IF NULLIF(@Tabla,'') IS NULL OR NOT EXISTS(SELECT 1 FROM SysTabla WHERE RTRIM(SysTabla) = @Tabla) SELECT @Ok = 72300, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ')' ELSE
    IF NULLIF(@ConsecutivoNombre,'') IS NULL SELECT @Ok = 72250, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ', ' + @ConsecutivoNombre + ')' ELSE
    IF NULLIF(@ConsecutivoInicial,'') IS NULL SELECT @Ok = 72260, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ', ' + @ConsecutivoNombre + ')' ELSE    
    IF NULLIF(@ConsecutivoIncremento,'') IS NULL SELECT @Ok = 72270, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ', ' + @ConsecutivoNombre + ')' ELSE        
    IF NULLIF(@CampoXMLRuta,'') IS NULL SELECT @Ok = 72280, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ', ' + @ConsecutivoNombre + ')' ELSE            
    IF NULLIF(@CampoXMLAtributo,'') IS NULL SELECT @Ok = 72290, @OkRef = '(' + @eDocIn + ', ' + @Ruta + ', ' + @Tabla + ', ' + @ConsecutivoNombre + ')'    

    EXEC speDocInInsertarConsecutivo @XML OUTPUT, @CampoXMLRuta, @ConsecutivoNombre, @ConsecutivoInicial, @ConsecutivoIncremento, @Ok OUTPUT, @OkRef OUTPUT
    
    FETCH NEXT FROM creDocInRutaTablaD INTO @ConsecutivoNombre, @ConsecutivoInicial, @ConsecutivoIncremento, @CampoXMLRuta, @CampoXMLAtributo, @Tabla
  END
  CLOSE creDocInRutaTablaD
  DEALLOCATE creDocInRutaTablaD

END
GO



/******************************* fneDocInTraducir *************************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInTraducir')
DROP FUNCTION fneDocInTraducir
GO
CREATE FUNCTION fneDocInTraducir
  (
  @TablaST			varchar(50),
  @ValorOriginal	varchar(50)			
  )
RETURNS varchar(100)
AS

BEGIN
  DECLARE	
    @Resultado		varchar(100)
  
  SELECT @Resultado = Valor
    FROM TablaStD 
   WHERE TablaSt = @TablaSt
     AND Nombre = @ValorOriginal

  SET @Resultado = ISNULL(@Resultado,@ValorOriginal)
    
  RETURN RTRIM(LTRIM(@Resultado))	
END
GO

/**************** fneDocInExpresionParsear ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInExpresionParsear') DROP FUNCTION fneDocInExpresionParsear
GO
CREATE FUNCTION fneDocInExpresionParsear 
	(
	@Expresion				varchar(max)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Valor				varchar(max),
    @Tipo				varchar(50)
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = '{'            SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('{','}') SET @Estado = 2 ELSE
    IF @Estado IN (1,2) AND @Caracter = '}'       SET @Estado = 3
    
    IF @Estado = 0
    BEGIN
      SET @Resultado = @Resultado + @Caracter
    END ELSE IF @Estado = 1
    BEGIN
      SET @Variable = ''
    END ELSE IF @Estado = 2
    BEGIN
      SET @Variable = @Variable + @Caracter
    END ELSE IF @Estado = 3
    BEGIN
      SELECT @Valor = RTRIM(ISNULL(Valor,'')), @Tipo = RTRIM(ISNULL(Tipo,'TEXTO')) FROM eDocInVariableTemp WHERE Estacion = @@SPID AND UPPER(LTRIM(RTRIM(Variable))) = UPPER(RTRIM(LTRIM(@Variable)))          
      IF @Tipo NOT IN ('TEXTO','NUMERICO','FECHA','LOGICO')
      BEGIN
        SET @Resultado = ''
        RETURN @Resultado
      END
      IF @Tipo IN ('TEXTO','FECHA')
      BEGIN
        SET @Resultado = @Resultado + CHAR(39) + @Valor + CHAR(39)
      END ELSE IF @Tipo IN ('NUMERICO')
      BEGIN
        SET @Resultado = @Resultado + @Valor
      END
      SET @Estado = 0      
    END
    
    SET @Contador = @Contador + 1
  END  

  RETURN (@Resultado)
END
GO



/**************** fneDocInGenerarInsertTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInGenerarInsertTabla') DROP FUNCTION fneDocInGenerarInsertTabla
GO
CREATE FUNCTION fneDocInGenerarInsertTabla 
	(
	@eDocIn				varchar(50), 
	@Ruta				varchar(50),
	@Tabla				varchar(50)
	)
RETURNS nvarchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				nvarchar(max),
    @CampoXML				nvarchar(max),
    @ExpresionXML			nvarchar(max),    
    @CampoTabla				nvarchar(max),    
    @CampoTablaTipo			nvarchar(100),
    @CampoXMLRuta			nvarchar(max),
    @CampoXMLAtributo		        nvarchar(255),
    @CampoXMLTipo			nvarchar(50),
    @CampoXMLTipoXML		        nvarchar(50),
    @EsIndependiente		        bit,
    @Traducir				bit,
    @TablaST				varchar(50),
    @DeclareVariables		        nvarchar(max),
    @DeclareTabla			nvarchar(max),
    @DeclareTablaPostfijo	        nvarchar(max),
    @PrepareDocument		        nvarchar(max),
    @Insert				nvarchar(max),    
    @ListaSeleccion			nvarchar(max),
    @With				nvarchar(max),
    @RemoveDocument			nvarchar(max),
    @InsertModulo			nvarchar(max),
    @ListaSeleccionModulo	        nvarchar(max),
    @IDTabla             	        nvarchar(max),
    @eDocInRutaTablaNodo	        nvarchar(max),
    @eDocInRutaTablaNodoN	        nvarchar(max),    
    @eDocInRutaTabla		        nvarchar(50),    
    @TablaVirtual			nvarchar(50),
    @Ok					int,
    @TablaPrincipal			bit,
    @Modulo				varchar(5),
    @XMLNS				varchar(max),
    @ListaSeleccionEspecial	        bit
    
    DECLARE @TablaWith table(Campo varchar(max))

  SET @Ok = NULL
  SET @eDocIn = RTRIM(NULLIF(@eDocIn,''))
  SET @Ruta = RTRIM(NULLIF(@Ruta,''))  
  SET @Tabla = RTRIM(NULLIF(@Tabla,''))  
  
  SELECT
    @Modulo = ISNULL(Modulo,'')
    FROM eDocInRuta
   WHERE RTRIM(eDocIn) = @eDocIn
     AND RTRIM(Ruta) = @Ruta
      
  SELECT @TablaPrincipal = CASE WHEN @Tabla = dbo.fnMovTabla(@Modulo) THEN 1 ELSE 0 END
      
  SELECT
    @eDocInRutaTablaNodo = ISNULL(Nodo,''),
    @eDocInRutaTabla = ISNULL(Tablas,''),
    @TablaVirtual = '@' + ISNULL(Tablas,'') + LTRIM(RTRIM(CONVERT(varchar,@@SPID)))
    FROM eDocInRutaTabla
   WHERE RTRIM(eDocIn) = @eDocIn
     AND RTRIM(Ruta) = @Ruta
     AND RTRIM(Tablas) = @Tabla 

  IF SUBSTRING(@eDocInRutaTablaNodo,LEN(@eDocInRutaTablaNodo),1) = '/' SET @eDocInRutaTablaNodoN = SUBSTRING(@eDocInRutaTablaNodo,1,LEN(@eDocInRutaTablaNodo)-1)  

  IF @eDocIn IS NULL RETURN '' ELSE
  IF @Ruta  IS NULL RETURN '' ELSE
  IF @Tabla  IS NULL RETURN ''   

  SET @Resultado = N''
  SET @DeclareTabla = N''
  SET @Insert = N''
  SET @ListaSeleccion = N''
  SET @With = N''
  SET @InsertModulo = N''
  SET @ListaSeleccionModulo = N''
  SET @IDTabla = N''
  
  IF @TablaPrincipal = 1 
    SELECT @IDTabla = N' SELECT @ID =  SCOPE_IDENTITY()'
     
  DECLARE creDocInRutaTablaD CURSOR FOR
   SELECT REPLACE(NULLIF(CampoXML,''),':','_'), NULLIF(CampoTabla,''), ISNULL(CampoXMLRuta,''), NULLIF(CampoXMLAtributo,''), NULLIF(CampoXMLTipo,''), NULLIF(CampoXMLTipoXML,''), dbo.fneDocInExpresionParsear(NULLIF(ISNULL(REPLACE(NULLIF(ExpresionXML,''),':','_'),REPLACE(NULLIF(CampoXML,''),':','_')),'')), ISNULL(EsIndependiente,0), ISNULL(Traducir,0), NULLIF(TablaST,'')
     FROM eDocInRutaTablaD
    WHERE eDocIn = @eDocIn
      AND Ruta = @Ruta
      AND Tablas = @Tabla 

  OPEN creDocInRutaTablaD
  FETCH NEXT FROM creDocInRutaTablaD INTO @CampoXML, @CampoTabla, @CampoXMLRuta, @CampoXMLAtributo, @CampoXMLTipo, @CampoXMLTipoXML, @ExpresionXML, @EsIndependiente, @Traducir, @TablaST
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    --IF @CampoXMLTipo = 'FECHA'
    --  SELECT @CampoXML = REPLACE(@CampoXML,'_',':'), @ExpresionXML =REPLACE(@ExpresionXML,'_',':')
      
    SET @ListaSeleccionEspecial = 0
    IF ISNULL(@CampoXMLRuta,'') = @eDocInRutaTablaNodo
    BEGIN
      SET @CampoXMLRuta = ''
    END ELSE
    BEGIN
      IF RTRIM(ISNULL(@CampoXMLTipoXML,'ATRIBUTO')) = 'ATRIBUTO'
      BEGIN
        SET @CampoXMLRuta = ' ' + CHAR(39) + ISNULL(@CampoXMLRuta,'') + '@' + RTRIM(ISNULL(@CampoXMLAtributo,'')) + CHAR(39)
      END ELSE IF RTRIM(ISNULL(@CampoXMLTipoXML,'ATRIBUTO')) = 'NODO'
      BEGIN
        SET @CampoXMLRuta = ' ' + CHAR(39) + ISNULL(@CampoXMLRuta,'') + RTRIM(ISNULL(@CampoXMLAtributo,'')) + CHAR(39)
      END  
      SET @ListaSeleccionEspecial = 1
    END  

    IF @CampoXMLTipo IS NULL      SET @CampoTablaTipo = N'varchar(max)' ELSE      
    IF @CampoXMLTipo = 'TEXTO'    SET @CampoTablaTipo = N'varchar(max)' ELSE
    IF @CampoXMLTipo = 'NUMERICO' SET @CampoTablaTipo = N'float'        ELSE    
    IF @CampoXMLTipo = 'FECHA'    SET @CampoTablaTipo = N'datetime'     ELSE
    IF @CampoXMLTipo = 'LOGICO'   SET @CampoTablaTipo = N'bit'
    

      

    IF @CampoTablaTipo = N'varchar(max)'
    BEGIN
      SET @DeclareTablaPostfijo = N' COLLATE DATABASE_DEFAULT NULL'
    END  
    ELSE IF @CampoTablaTipo IN ('float','datetime','bit')
    BEGIN
      SET @DeclareTablaPostfijo = N' NULL'    
    END 
    IF @DeclareTabla = N'' 
      SET @DeclareTabla = @DeclareTabla + @CampoXML + N' ' + @CampoTablaTipo + @DeclareTablaPostFijo
    ELSE
      SET @DeclareTabla = @DeclareTabla + N', ' + @CampoXML + N' ' + @CampoTablaTipo + @DeclareTablaPostFijo

    IF @Insert = N'' 
      SET @Insert = @Insert + @CampoXML
    ELSE
      SET @Insert = @Insert + N', ' + @CampoXML
  
    IF @ListaSeleccion = N'' 
    BEGIN
      IF @EsIndependiente = 0
      BEGIN
        IF @ListaSeleccionEspecial = 0
        BEGIN
          SET @ListaSeleccion = @ListaSeleccion + @CampoXMLAtributo + N' AS ' + @CampoXML
        END ELSE
        BEGIN
          SET @ListaSeleccion = @ListaSeleccion + @CampoXML + N' AS ' + @CampoXML
        END  
      END  
      ELSE IF @EsIndependiente = 1
        SET @ListaSeleccion = @ListaSeleccion + @ExpresionXML + N' AS ' + @CampoXML  
    END  
    ELSE
    BEGIN
      IF @EsIndependiente = 0
      BEGIN
        IF @ListaSeleccionEspecial = 0
        BEGIN
          SET @ListaSeleccion = @ListaSeleccion + N', ' + @CampoXMLAtributo + N' AS ' + @CampoXML
        END ELSE
        BEGIN
          SET @ListaSeleccion = @ListaSeleccion + N', ' + @CampoXML + N' AS ' + @CampoXML
        END
      END  
      ELSE IF @EsIndependiente = 1
      BEGIN
        SET @ListaSeleccion = @ListaSeleccion + N', ' + @ExpresionXML + N' AS ' + @CampoXML          
      END  
    END

    IF @EsIndependiente = 0
    BEGIN    
      IF @With = N'' 
      BEGIN
        IF @ListaSeleccionEspecial = 0
        BEGIN
          IF NOT EXISTS(SELECT * FROM @TablaWith WHERE Campo = @CampoXMLAtributo)
          SET @With = @With + @CampoXMLAtributo + N' ' + @CampoTablaTipo + @CampoXMLRuta
        END ELSE
        BEGIN
          IF NOT EXISTS(SELECT * FROM @TablaWith WHERE Campo = @CampoXML)
          SET @With = @With + @CampoXML + N' ' + @CampoTablaTipo + @CampoXMLRuta
        END
      END  
      ELSE
      BEGIN
        IF @ListaSeleccionEspecial = 0
        BEGIN
         IF NOT EXISTS(SELECT * FROM @TablaWith WHERE Campo = @CampoXMLAtributo)
          SET @With = @With + N', ' + @CampoXMLAtributo + N' ' + @CampoTablaTipo + @CampoXMLRuta
        END ELSE
        BEGIN
          IF NOT EXISTS(SELECT * FROM @TablaWith WHERE Campo = @CampoXML)
          SET @With = @With + N', ' + @CampoXML + N' ' + @CampoTablaTipo + @CampoXMLRuta        
        END  
      END  
      INSERT @TablaWith(campo)SELECT @CampoXMLAtributo
      INSERT @TablaWith(campo)SELECT @CampoXML
    END

    IF @InsertModulo = N'' 
      SET @InsertModulo = @InsertModulo + @CampoTabla
    ELSE
      SET @InsertModulo = @InsertModulo + N', ' + @CampoTabla

    IF @CampoXMLTipo = 'TEXTO' AND @Traducir = 1 AND @TablaST IS NOT NULL
    BEGIN
      SET @ExpresionXML = 'dbo.fneDocInTraducir(' + CHAR(39) + RTRIM(@TablaST) + CHAR(39) + ',' + @ExpresionXML + ')'
    END
    
    IF @ListaSeleccionModulo = N'' 
      SET @ListaSeleccionModulo = @ListaSeleccionModulo + @ExpresionXML
    ELSE
      SET @ListaSeleccionModulo = @ListaSeleccionModulo + N', ' + @ExpresionXML
             
    FETCH NEXT FROM creDocInRutaTablaD INTO @CampoXML, @CampoTabla, @CampoXMLRuta, @CampoXMLAtributo, @CampoXMLTipo, @CampoXMLTipoXML, @ExpresionXML, @EsIndependiente, @Traducir, @TablaST
  END
  CLOSE creDocInRutaTablaD
  DEALLOCATE creDocInRutaTablaD
  
  IF @With = N'' 
     SET @With =@With+ N'A_A varchar(10)'

  IF @InsertModulo IS NOT NULL AND @DeclareTabla IS NOT NULL AND @Insert IS NOT NULL AND @ListaSeleccion IS NOT NULL AND @With IS NOT NULL
  BEGIN
    SET @DeclareVariables = N'DECLARE @ixml int, @XMLNS		varchar(max) '
    SET @DeclareTabla = N'DECLARE ' + @TablaVirtual + N' TABLE (' + @DeclareTabla + N') '   
    SET @XMLNS =   N'SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),1) SELECT  @XMLNS = NULLIF(@XMLNS,'+CHAR(39)+CHAR(39)+') '
    SET @PrepareDocument = N' EXEC sp_xml_preparedocument @iXML OUTPUT, @xml, @XMLNS '
    SET @Insert = N' INSERT ' + @TablaVirtual + N' (' + @Insert + N') ' 
    SET @ListaSeleccion = N' SELECT ' + @ListaSeleccion + N' FROM OPENXML (@iXML,' + CHAR(39) + @eDocInRutaTablaNodoN + CHAR(39) + N') '
    SET @With = N' WITH (' + @With + N')'
    SET @RemoveDocument = N' EXEC sp_xml_removedocument @iXML '    
    SET @InsertModulo = N' INSERT ' + @eDocInRutaTabla + N' (' + @InsertModulo + N') ' 
    SET @ListaSeleccionModulo = N' SELECT ' + @ListaSeleccionModulo + N' FROM ' + @TablaVirtual + N' ' 
      
    SET @Resultado = @DeclareVariables + 
        N' BEGIN TRY ' + 
        @DeclareTabla + 
        @XMLNS +         
        @PrepareDocument + 
        @Insert + 
        @ListaSeleccion + 
        @With + 
        @RemoveDocument +
        @InsertModulo + 
        @ListaSeleccionModulo + 
        @IDTabla +
        N' END TRY ' + 
        N' BEGIN CATCH ' +
        N'   SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
        N'   IF XACT_STATE() = -1 ' +
        N'   BEGIN ' +
        N'      ROLLBACK TRAN ' +
        N'      SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
        N'      RAISERROR(@OkRef,20,1) WITH LOG ' +
        N'   END ' + 
        N' END CATCH ' 
            
  END  

  RETURN (@Resultado)
END
GO

--select dbo.fneDocInGenerarInsertTabla('CFD','CFD','VENTAD')


/**************** fneDocInRutaRelativaArbol ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInRutaRelativaArbol') DROP FUNCTION fneDocInRutaRelativaArbol
GO
CREATE FUNCTION fneDocInRutaRelativaArbol 
	(
	@Ruta						varchar(max),
	@RelativaA					varchar(max) 	
	)
RETURNS @Nodos TABLE
(
  ID				int identity(1,1) NOT NULL,  
  Nodo				varchar(255) COLLATE DATABASE_DEFAULT NULL,
  NodoPadre			varchar(255) COLLATE DATABASE_DEFAULT NULL,
  Tipo				varchar(50) COLLATE DATABASE_DEFAULT NULL  
)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado					varchar(max),
    @Estado						int,
    @EstadoAnterior				int,
    @Contador					bigint,
    @Longitud					bigint,
    @Caracter					char(1),
    @Nodo						varchar(255),
    @NodoPadre					varchar(255)    

  SET @Ruta = NULLIF(@Ruta,'')
  SET @RelativaA = NULLIF(@RelativaA,'')
  
  IF @Ruta IS NULL OR @RelativaA IS NULL RETURN
    
  SELECT @Resultado = '', @Caracter = '', @Contador = 1, @Estado = 0, @EstadoAnterior = 0, @Nodo = '', @NodoPadre = ''  
  SET @Longitud = LEN(@RelativaA)
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@RelativaA,@Contador,1)  
    IF @Caracter = '/'  SET @Estado = 1 ELSE
    IF @Caracter <> '/' SET @Estado = 2 
    
    IF @Estado = 1
    BEGIN
      IF NULLIF(@Nodo,'') IS NOT NULL
      BEGIN
        INSERT @Nodos (Nodo, NodoPadre) VALUES (@Nodo, @NodoPadre)
      END              
      SET @NodoPadre = @Nodo
      SET @Nodo = ''
    END ELSE
    IF @Estado = 2
    BEGIN
      SET @Nodo = @Nodo + @Caracter
    END
    
    SET @Contador = @Contador + 1
  END

  UPDATE @Nodos SET Tipo = 'Origen' WHERE Nodo = @NodoPadre
  
  SELECT @Resultado = '', @Caracter = '', @Contador = 1, @Estado = 0, @EstadoAnterior = 0, @Nodo = '', @NodoPadre = '' 
  SET @Longitud = LEN(@Ruta)
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Ruta,@Contador,1)  
    IF @Caracter = '/'  SET @Estado = 1 ELSE
    IF @Caracter <> '/' SET @Estado = 2 
    
    IF @Estado = 1
    BEGIN
      IF NULLIF(@Nodo,'') IS NOT NULL
      BEGIN
        IF NOT EXISTS(SELECT 1 FROM @Nodos WHERE Nodo = @Nodo AND NodoPadre = @NodoPadre)
        BEGIN
          INSERT @Nodos (Nodo, NodoPadre) VALUES (@Nodo, @NodoPadre)
        END  
        SET @NodoPadre = @Nodo
        SET @Nodo = ''                  
      END      
    END ELSE
    IF @Estado = 2
    BEGIN
      SET @Nodo = @Nodo + @Caracter
    END
    
    SET @Contador = @Contador + 1
  END
  
  IF NULLIF(@NodoPadre,'') IS NOT NULL
    UPDATE @Nodos SET Tipo = 'Destino' WHERE Nodo = @NodoPadre
  
  RETURN
END
GO

--SELECT * FROM dbo.fneDocInRutaRelativaArbol('/doc/c/x/','/doc/bes/b/')
--SELECT * FROM dbo.fneDocInRutaRelativaArbol('/doc/f/f1/f2/','/doc/f/f1/f2/f3/')

/**************** fneDocInRutaRelativa ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInRutaRelativa') DROP FUNCTION fneDocInRutaRelativa
GO
CREATE FUNCTION fneDocInRutaRelativa 
	(
	@Ruta					varchar(max), 
	@RelativaA				varchar(max)
	)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				varchar(max),
    @Nodo					varchar(255),    
    @NodoPadre				varchar(255),        
    @NodoAnterior			varchar(255),            
    @Tipo					varchar(50),
    @Salir					bit,
    @RutaRelativa			varchar(max),
    @Estatus				varchar(50),
    @NodoPrincipal                      varchar(255)

  SET @Resultado = ''
  
  IF @Ruta = @RelativaA 
  BEGIN
    RETURN @Resultado
  END  
  
  DECLARE @Nodos TABLE
  (
  Nodo				varchar(255) COLLATE DATABASE_DEFAULT NULL,
  NodoPadre			varchar(255) COLLATE DATABASE_DEFAULT NULL,
  Tipo				varchar(50) COLLATE DATABASE_DEFAULT NULL  
  )
  
  INSERT @Nodos (Nodo, NodoPadre, Tipo)
  SELECT 
    Nodo,
    NodoPadre,
    Tipo 
    FROM dbo.fneDocInRutaRelativaArbol(@Ruta,@RelativaA)

  SELECT @NodoPrincipal = Nodo FROM @Nodos WHERE NULLIF(NodoPadre,'') IS NULL
  
  SET @RutaRelativa = ''
  SET @Salir = 0
  SET @Estatus = 'Retroceder'
  SELECT @Nodo = Nodo, @NodoPadre = NodoPadre FROM @Nodos WHERE Tipo = 'Origen'    
  IF @Nodo IS NULL RETURN @Resultado
  WHILE @Salir = 0
  BEGIN
    IF @Estatus = 'Retroceder'
    BEGIN
      SET @RutaRelativa = @RutaRelativa + '../'
      SET @NodoAnterior = @Nodo    
      SELECT @Nodo = Nodo, @NodoPadre = NodoPadre, @Tipo = Tipo FROM @Nodos WHERE Nodo = @NodoPadre 
    END ELSE
    IF @Estatus = 'Avanzar'
    BEGIN
      SELECT @NodoAnterior = ISNULL(@Nodo,'')
      SELECT @Nodo = Nodo, @NodoPadre = NodoPadre, @Tipo = Tipo FROM @Nodos WHERE NodoPadre = @Nodo   
      IF @Nodo IS NOT NULL
      BEGIN
        SET @RutaRelativa = @RutaRelativa + ISNULL(@Nodo,'') + '/'
      END  
      IF @Tipo = 'Destino' SET @Salir = 1
    END
    
    IF @Estatus = 'Retroceder' AND @Tipo = 'Destino' SET @Salir = 1 ELSE        
    IF @Estatus = 'Retroceder' AND EXISTS(SELECT 1 FROM @Nodos WHERE NodoPadre = @Nodo AND Nodo <> @NodoAnterior) SET @Estatus = 'Avanzar' ELSE
    IF @Estatus = 'Retroceder' AND EXISTS(SELECT 1 FROM @Nodos WHERE Nodo = @Nodo AND NULLIF(NodoPadre,'') IS NULL) SET @Estatus = 'Avanzar'
  END

  IF REPLACE(@RelativaA,'/','') = @NodoPrincipal AND SUBSTRING(@RutaRelativa,1,3) = '../' SET @RutaRelativa = STUFF(@RutaRelativa,1,1,'')
    
  SET @Resultado = @RutaRelativa
  
  RETURN (@Resultado)
END
GO

--SELECT dbo.fneDocInRutaRelativa('/doc/c/x/','/doc/bes/b/')
--SELECT dbo.fneDocInRutaRelativa('/doc/bes/c/x/','/doc/bes/b/')
--SELECT dbo.fneDocInRutaRelativa('/doc/f/f1/f2/','/doc/f/f1/f2/f3/')
--SELECT dbo.fneDocInRutaRelativa('/doc/bes/b/','/doc/bes/b/')


/******************************* speDocInListarNodosXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarNodosXML') and type = 'P') drop procedure dbo.speDocInListarNodosXML
GO             
CREATE PROCEDURE speDocInListarNodosXML
		@Estacion	int,
		@XML		xml,
		@Path		varchar(max),
		@Nodo		varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @Contador			int, 
    @CantidadElementos		int,
    @SQL					nvarchar(max),
    @XMLNS					nvarchar(max)

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +             
             N'DECLARE @Contador			int, ' + 
             N'        @CantidadElementos	int, ' +
             N'        @NuevoPath			varchar(max),  ' +                          
             N'        @NuevoNodo			varchar(max),  ' +                                       
             N'        @PathElemento		varchar(max),  ' +                                       
             N'        @PathAtributo		varchar(max)   ' + 
             N'IF NOT EXISTS(SELECT 1 FROM eDocInNodoTemp WHERE Estacion = @Estacion AND ISNULL(Nodo,'''') = ISNULL(@Path,'''')) INSERT eDocInNodoTemp (Estacion, Nodo, NodoNombre) VALUES (@Estacion, @Path, @Nodo) ' +                                                                 
             N'SET @CantidadElementos = @xml.query(' + CHAR(39) + @XMLNS + 'count(' + ISNULL(@Path,'') + '*)' + CHAR(39) + ').value(' + CHAR(39) + '.' + CHAR(39) + ',' + CHAR(39) + 'int' + CHAR(39) + ') ' + 
             N'SELECT @Contador = @CantidadElementos ' +             
             N'WHILE @Contador > 0 ' + 
             N'BEGIN ' +
             N'  SELECT  @PathElemento = @xml.value(' + CHAR(39) + @XMLNS + 'local-name((' + ISNULL(@Path,'') + '*[sql'+CHAR(58)+'variable("@Contador")])[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ') ' +              
             N'  SELECT  @NuevoPath = @Path + @PathElemento + ''/'' ' + 
             N'  SELECT  @NuevoNodo = @Nodo + CASE WHEN @Nodo = '''' THEN '''' ELSE ''_'' END + @PathElemento ' +              
             N'  IF RTRIM(ISNULL(@PathElemento,'''')) <> '''' ' +
             N'    EXEC speDocInListarNodosXML @Estacion, @XML, @NuevoPath, @NuevoNodo ' +                           
             N'  SET @Contador = @Contador - 1 ' +             
             N'END ' 
     
  EXEC sp_executesql @SQL, N'@Estacion int, @Path varchar(max), @XML xml, @Nodo varchar(255)', @Estacion = @Estacion, @Path = @Path, @XML = @XML, @Nodo = @Nodo
END
GO




/******************************* speDocInListarNodosXml2 *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarNodosXml2') and type = 'P') drop procedure dbo.speDocInListarNodosXml2
GO             
CREATE PROCEDURE speDocInListarNodosXml2
		@Estacion	int,
		@eDocIn         varchar(50)

--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Xml varchar(max)
  
  SET ANSI_NULLS ON   
  SET ANSI_WARNINGS ON    
  SET QUOTED_IDENTIFIER ON
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON
  -- SET nocount ON
  DELETE FROM eDocInNodoTemp WHERE Estacion = @Estacion
  
  SELECT @Xml = Documento FROM eDocIn WHERE eDocIn = @eDocIn
  EXEC spDocInXmlNSListarNodo @xml ,@Estacion
  

  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF   
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF    
END
GO



  SET ANSI_NULLS ON   
  SET ANSI_WARNINGS ON    
  SET QUOTED_IDENTIFIER ON
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON

/******************************* spDocInXmlNSListarNodo  *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spDocInXmlNSListarNodo') AND TYPE = 'P')
DROP PROCEDURE spDocInXmlNSListarNodo
GO

CREATE PROCEDURE spDocInXmlNSListarNodo
	(
	@XML2			varchar(max),
	@estacion               int

	)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    
    @Prefijo			varchar(max),
    @Nombre			varchar(max),
    @Path			varchar(max),
    @XMLNS			varchar(max),
    @NodoPrincipalXML    	varchar(max),
    @SQL			nvarchar(max),
    @Resultado			varchar(max),
    @xml                        xml,
    @Valor                      varchar(36)
    
  SELECT @Valor=NEWID()
  

    

  DELETE eDocInNodoTemp WHERE Estacion = @estacion
  EXEC speDocInPrefijo @xml2,@Estacion
  
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  DECLARE crXMLNS CURSOR FOR
   SELECT ISNULL(Prefijo,''), Nombre
     FROM eDocInNSPrefijo
    WHERE Estacion = @Estacion 
    ORDER BY ID
    
  OPEN crXMLNS
  FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  WHILE @@FETCH_STATUS = 0 
  BEGIN
      SELECT @XML2 = REPLACE(@xml2,@prefijo,REPLACE(@Prefijo,CHAR(58),@Valor))

    FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  END
  CLOSE crXMLNS
  DEALLOCATE crXMLNS
  

  
  SELECT @xml = CONVERT(xml,@xml2);
  
  
  WITH Xml_CTE AS
  (SELECT CAST('/' + node.value('local-name(.)','varchar(max)') AS varchar(max)) AS name,
          node.query('*') AS children
     FROM @xml.nodes('/*') AS roots(node)
   UNION ALL
   SELECT CAST(x.name + '/' + node.value('local-name(.)', 'varchar(max)') AS varchar(max)),
          node.query('*') AS children
     FROM Xml_CTE x
    CROSS APPLY x.children.nodes('*') AS child(node))


  INSERT eDocInNodoTemp(Estacion,Nodo,NodoNombre)
  SELECT DISTINCT @estacion, REPLACE(name,@Valor,CHAR(58))+'/',REPLACE(stuff(REPLACE(name,@Valor,CHAR(58)),1,1,'' ),'/','_')
    FROM Xml_CTE
  OPTION (MAXRECURSION 1000)

 
END
GO

  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF 
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF  


/******************************* speDocInListarAtributosXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarAtributosXML') and type = 'P') drop procedure dbo.speDocInListarAtributosXML
GO             
CREATE PROCEDURE speDocInListarAtributosXML
		@Estacion	int,
		@XML		xml,
		@Path		varchar(max),
		@Nodo		varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @Contador				int, 
    @CantidadElementos		int,
    @SQL					nvarchar(max),
    @XMLNS					nvarchar(max)

  IF @Path = '/' RETURN  

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
    
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +             
             N'DECLARE @Contador			int, ' + 
             N'        @CantidadAtributos	int, ' +
             N'        @PathAtributo		varchar(max),  ' +                          
             N'        @Nombre				varchar(max)   ' +                                       
             N'SET @CantidadAtributos = @xml.query(' + CHAR(39) + @XMLNS + 'count(' + ISNULL(@Path,'') + '@*)' + CHAR(39) + ').value(' + CHAR(39) + '.' + CHAR(39) + ',' + CHAR(39) + 'int' + CHAR(39) + ') ' + 
             N'SELECT @Contador = @CantidadAtributos ' +             
             N'WHILE @Contador > 0 ' + 
             N'BEGIN ' +
             N'  SELECT  @PathAtributo = @xml.value(' + CHAR(39) + @XMLNS + 'local-name((' + ISNULL(@Path,'') + '@*[sql'+CHAR(58)+'variable("@Contador")])[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ') ' +                           
             N'  SELECT  @Nombre = @Nodo + ''_'' + @PathAtributo ' + 
             N'IF RTRIM(ISNULL(@PathAtributo,'''')) <> '''' AND NOT EXISTS(SELECT 1 FROM eDocInAtributoTemp WHERE Estacion = @Estacion AND ISNULL(AtributoRuta,'''') = ISNULL(@Path,'''') AND ISNULL(AtributoNombre,'''') = ISNULL(@PathAtributo,'''')) INSERT eDocInAtributoTemp (Estacion, AtributoRuta, AtributoNombre, Campo, Nodo) VALUES (@Estacion, @Path, @PathAtributo, @Nombre, @Nodo) ' +                                                                              
             N'  SET @Contador = @Contador - 1 ' +             
             N'END ' 
             
  EXEC sp_executesql @SQL, N'@Estacion int, @Path varchar(max), @XML xml, @Nodo varchar(255)', @Estacion = @Estacion, @Path = @Path, @XML = @XML, @Nodo = @Nodo

END
GO




/******************************* speDocInListaCompletaAtributos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListaCompletaAtributos') and type = 'P') drop procedure dbo.speDocInListaCompletaAtributos
GO             
CREATE PROCEDURE speDocInListaCompletaAtributos
		@Estacion		int,
		@XML			xml

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Nodo			varchar(255),
  @NodoNombre		varchar(255),
  @Xml2                 varchar(max)
  
  SET ANSI_NULLS ON 
  SET ANSI_WARNINGS ON 
  SET QUOTED_IDENTIFIER ON  

  DELETE FROM eDocInNodoTemp WHERE Estacion = @Estacion
  DELETE FROM eDocInAtributoTemp WHERE Estacion = @Estacion  
  SELECT @Xml2 = CONVERT(varchar(max),@Xml)
  EXEC spDocInXmlNSListarNodo  @XML2,@Estacion  
  
  DECLARE crNodo CURSOR FOR
   SELECT Nodo, NodoNombre
     FROM eDocInNodoTemp
    WHERE Estacion = @Estacion

  OPEN crNodo
  FETCH NEXT FROM crNodo INTO @Nodo, @NodoNombre
  WHILE @@FETCH_STATUS = 0
  BEGIN
    
    EXEC speDocInListarAtributosXML @Estacion, @XML, @Nodo, @NodoNombre
        
    FETCH NEXT FROM crNodo INTO @Nodo, @NodoNombre
  END
  CLOSE crNodo
  DEALLOCATE crNodo
  
  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF  

  
  
END
GO



/******************************* speDocInNodoExiste *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInNodoExiste') and type = 'P') drop procedure dbo.speDocInNodoExiste
GO             
CREATE PROCEDURE speDocInNodoExiste
		@XML		varchar(max),
		@Path		varchar(max),
		@Existe         bit =0 OUTPUT,
		@Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 

    @SQL					nvarchar(max),
    @XMLNS					nvarchar(max)
 
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Path),'') IS NULL SELECT @Ok = 72350
  
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'SET @Existe = @xml.exist(' + CHAR(39) + @XMLNS + ISNULL(@Path,'') +CHAR(39)+ ') ' + 
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH ' 
  BEGIN TRY                      
    EXEC sp_executesql @SQL, N' @Path varchar(max), @XML xml, @Existe bit OUTPUT, @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @Path = @Path, @Existe = @Existe OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error no existe el Nodo (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@Path+')'
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH 
  IF @Ok IS NOT NULL
    SET @OkRef = ' Error no existe el Nodo (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@Path+')'   
    
END
GO



/******************************* speDocInNodoPrincipal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInNodoPrincipal') and type = 'P') drop procedure dbo.speDocInNodoPrincipal
GO             
CREATE PROCEDURE speDocInNodoPrincipal
		@XML		    varchar(max),
		@NodoPrincipal      varchar(max),
		@Existe             bit = 0 OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @NodoPrincipalXML   varchar(100),
    @SQL	       	nvarchar(max),
    @XMLNS		nvarchar(max)
    
    SELECT @NodoPrincipal = REPLACE(@NodoPrincipal,'/','')
  
  SET @Existe = 0
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@NodoPrincipal),'') IS NULL SELECT @Ok = 72350
 
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'  SELECT  @NodoPrincipalXML = @xml.value(' + CHAR(39) + @XMLNS + 'local-name((/*)[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ')'+
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '
  BEGIN TRY 
    EXEC sp_executesql @SQL, N'@XML xml, @NodoPrincipalXML varchar(255)  OUTPUT, @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @NodoPrincipalXML = @NodoPrincipalXML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  al verificar el nodo principal (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@NodoPrincipal+')'
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH  
  IF @OK IS NOT NULL
    SET @OkRef = ' Error  al verificar el nodo principal (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@NodoPrincipal+')'
  
  IF @NodoPrincipal = @NodoPrincipalXML
    SET @Existe = 1
  ELSE
    SET @Existe = 0  
    
END
GO
   



/******************************* speDocInAtributoExiste *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInAtributoExiste') and type = 'P') drop procedure dbo.speDocInAtributoExiste
GO             
CREATE PROCEDURE speDocInAtributoExiste
		@XML		varchar(max),
		@Path		varchar(max),
		@Existe         bit = 0 OUTPUT,
		@Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    
    @SQL					nvarchar(max),
    @XMLNS					nvarchar(max)
    
  SET @Existe = 0
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Path),'') IS NULL SELECT @Ok = 72350
 
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)

  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'SET @Existe = @xml.exist(' + CHAR(39) + @XMLNS + ISNULL(@Path,'') +CHAR(39)+ ') ' + 
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '      
             BEGIN TRY                  
               EXEC sp_executesql @SQL, N' @Path varchar(max), @XML xml, @Existe bit OUTPUT, @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @Path = @Path, @Existe = @Existe OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
             END TRY   
             BEGIN CATCH
               SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
               IF XACT_STATE() = -1   
               BEGIN
                 ROLLBACK TRAN
                 SET @OkRef = ' Error  al verificar si exite atributo' + CONVERT(varchar,@Ok) + @OkRef+'('+@Path+')'
                 RAISERROR(@OkRef,20,1) WITH LOG 
               END
             END CATCH
             IF @OK IS NOT NULL
               SET @OkRef = ' Error  al verificar si exite atributo (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@Path+')'

  
END
GO


/******************************* speDocInXMLNSValido *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInXMLNSValido') and type = 'P') drop procedure dbo.speDocInXMLNSValido
GO             
CREATE PROCEDURE speDocInXMLNSValido
		@XML		varchar(max),
		@NameSpace      varchar(max),
		@EsValido       bit  = 0  OUTPUT,
		@Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT
		
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado			int,
    @EstadoAnterior		int,
    @Prefijo			varchar(max),
    @Nombre			varchar(max)  

  DECLARE @xmlns TABLE
  (
   Prefijo					varchar(max) COLLATE DATABASE_DEFAULT NULL,
   Nombre					varchar(max) COLLATE DATABASE_DEFAULT NULL
  )  
  
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@NameSpace),'') IS NULL SELECT @Ok = 72350
 
  SET @Longitud = LEN(@XML)
  SET @Contador = 1
  SET @Estado = 0
  SET @Prefijo = ''
  SET @Nombre  = ''
  SET @EsValido = 0
  
  WHILE @Contador <= @Longitud AND @Ok IS NULL
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = 'X'			  SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('M')	  SET @Estado = 0 ELSE        
    IF @Estado = 1 AND @Caracter = 'M'			  SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter NOT IN ('L')	  SET @Estado = 0 ELSE            
    IF @Estado = 2 AND @Caracter = 'L'			  SET @Estado = 3 ELSE    
    IF @Estado = 3 AND @Caracter NOT IN ('N')	  SET @Estado = 0 ELSE            
    IF @Estado = 3 AND @Caracter = 'N'			  SET @Estado = 4 ELSE        
    IF @Estado = 4 AND @Caracter NOT IN ('S')	  SET @Estado = 0 ELSE                
    IF @Estado = 4 AND @Caracter = 'S'			  SET @Estado = 5 ELSE
    IF @Estado = 5 AND @Caracter NOT IN (CHAR(58),'=') SET @Estado = 0 ELSE                
    IF @Estado = 5 AND @Caracter = CHAR(58)			  SET @Estado = 6 ELSE
    IF @Estado = 5 AND @Caracter = '='			  SET @Estado = 7 ELSE
    IF @Estado = 6 AND @Caracter = '='     	      SET @Estado = 7 ELSE
    IF @Estado = 7 AND @Caracter NOT IN ('"')	  SET @Estado = 0 ELSE                        
    IF @Estado = 7 AND @Caracter = '"'     	      SET @Estado = 8 ELSE            
    IF @Estado = 8 AND @Caracter = '"'     	      SET @Estado = 9
    
    IF @Estado = 6 AND @EstadoAnterior = 6
    BEGIN
      SET @Prefijo = @Prefijo + @Caracter
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8
    BEGIN
      SET @Nombre = @Nombre + @Caracter
    END ELSE IF @Estado = 9
    BEGIN
      IF NULLIF(@Nombre,'') IS NOT NULL
      BEGIN
        INSERT @xmlns (Prefijo, Nombre) VALUES (NULLIF(@Prefijo,''), NULLIF(@Nombre,''))
      END
      SET @Prefijo = ''
      SET @Nombre = ''
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END  
  
  IF EXISTS(SELECT Nombre FROM @xmlns WHERE Nombre = @NameSpace)
  SET @EsValido = 1
    
END
GO




/******************************* speDocInXMLNSOmisionValido *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInXMLNSOmisionValido') and type = 'P') drop procedure dbo.speDocInXMLNSOmisionValido
GO             
CREATE PROCEDURE speDocInXMLNSOmisionValido
		@XML		varchar(max),
		@NameSpace      varchar(max),
		@Omision        bit  = 0  OUTPUT,
		@Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT		
		
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Prefijo			varchar(max),
    @Nombre				varchar(max)  

  DECLARE @xmlns TABLE
  (
   Prefijo					varchar(max) COLLATE DATABASE_DEFAULT NULL,
   Nombre					varchar(max) COLLATE DATABASE_DEFAULT NULL
  )  
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@NameSpace),'') IS NULL SELECT @Ok = 72350
  SET @Longitud = LEN(@XML)
  SET @Contador = 1
  SET @Estado = 0
  SET @Prefijo = ''
  SET @Nombre  = ''
  SET @Omision = 0
  
  WHILE @Contador <= @Longitud AND @Ok IS NULL
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = 'X'		  SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('M')	  SET @Estado = 0 ELSE        
    IF @Estado = 1 AND @Caracter = 'M'		  SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter NOT IN ('L')	  SET @Estado = 0 ELSE            
    IF @Estado = 2 AND @Caracter = 'L'		  SET @Estado = 3 ELSE    
    IF @Estado = 3 AND @Caracter NOT IN ('N')	  SET @Estado = 0 ELSE            
    IF @Estado = 3 AND @Caracter = 'N'		  SET @Estado = 4 ELSE        
    IF @Estado = 4 AND @Caracter NOT IN ('S')	  SET @Estado = 0 ELSE                
    IF @Estado = 4 AND @Caracter = 'S'		  SET @Estado = 5 ELSE
    IF @Estado = 5 AND @Caracter NOT IN (CHAR(58),'=') SET @Estado = 0 ELSE                
    IF @Estado = 5 AND @Caracter = CHAR(58)		  SET @Estado = 6 ELSE
    IF @Estado = 5 AND @Caracter = '='		  SET @Estado = 7 ELSE
    IF @Estado = 6 AND @Caracter = '='     	  SET @Estado = 7 ELSE
    IF @Estado = 7 AND @Caracter NOT IN ('"')	  SET @Estado = 0 ELSE                        
    IF @Estado = 7 AND @Caracter = '"'     	  SET @Estado = 8 ELSE            
    IF @Estado = 8 AND @Caracter = '"'     	  SET @Estado = 9
    
    IF @Estado = 6 AND @EstadoAnterior = 6
    BEGIN
      SET @Prefijo = @Prefijo + @Caracter
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8
    BEGIN
      SET @Nombre = @Nombre + @Caracter
    END ELSE IF @Estado = 9
    BEGIN
      IF NULLIF(@Nombre,'') IS NOT NULL
      BEGIN
        INSERT @xmlns (Prefijo, Nombre) VALUES (NULLIF(@Prefijo,''), NULLIF(@Nombre,''))
      END
      SET @Prefijo = ''
      SET @Nombre = ''
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END  
  
  IF EXISTS(SELECT Nombre FROM @xmlns WHERE Nombre = @NameSpace AND Prefijo IS  NULL)
    SET @Omision = 1
  ELSE  
    SET @Omision = 0
        
END
GO


/******************************* speDocInTextoVerificar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInTextoVerificar') and type = 'P') drop procedure dbo.speDocInTextoVerificar
GO             
CREATE PROCEDURE speDocInTextoVerificar
		@XML		varchar(max),
		@Texto          varchar(max),
		@Existe         bit = 0 OUTPUT,
	        @Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT	
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Texto),'') IS NULL SELECT @Ok = 72350

  SET @Texto = '%'+@Texto+'%'    
  SET @Existe = 0
  
  IF (SELECT PATINDEX(@Texto,@xml))  <> 0 AND @Ok IS NULL
    SET @Existe = 1
  ELSE 
    SET @Existe = 0
  
END
GO



/******************************* speDocInAtributoValorVerificar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInAtributoValorVerificar') and type = 'P') drop procedure dbo.speDocInAtributoValorVerificar
GO             
CREATE PROCEDURE speDocInAtributoValorVerificar
		@XML		varchar(max),
		@Path           varchar(max),
		@Valor          varchar(255),
		@Operador       varchar(50),
		@Existe         bit = 0 OUTPUT,
	        @Ok             int = NULL OUTPUT,
		@OkRef          varchar(255) = NULL OUTPUT	
		

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @ValorXML                      		varchar(255),
    @SQL					nvarchar(max),
    @SQL2					nvarchar(max),
    @XMLNS					nvarchar(max),
    @Operador2                                  varchar(10)
    
  SET @Existe = 0

  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Path),'') IS NULL SELECT @Ok = 72350 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Valor),'') IS NULL SELECT @Ok = 72330

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  
  SELECT @Operador2 = CASE WHEN @Operador = 'IGUAL QUE' THEN ' = '
                           WHEN @Operador = 'DIFERENTE QUE' THEN ' <> '
                           WHEN @Operador = 'MAYOR QUE' THEN ' > '
                           WHEN @Operador = 'MENOR QUE' THEN ' < '
                           WHEN @Operador = 'MAYOR O IGUAL QUE' THEN ' >= '
                           WHEN @Operador = 'MENOR O IGUAL QUE' THEN ' <= '
                      END     
   
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'  SELECT  @ValorXML = @xml.value(' + CHAR(39) + @XMLNS +'('+ @Path +')[1]'  + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ')' + 
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '   
             
  BEGIN TRY                  
    EXEC sp_executesql @SQL, N' @Path varchar(max), @XML xml,  @ValorXML  Varchar(255) OUTPUT, @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @Path = @Path,  @ValorXML = @ValorXML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error al verificar valor ' + CONVERT(varchar,@Ok) + @OkRef+'('+@Operador+')'
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH                         
  IF @OK IS NOT NULL
    SET @OkRef = ' Error al verificar valor (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@Operador+')'              
      
  

  SET @SQL2 = N'IF ' + CHAR(39) +@Valor  + CHAR(39) +@Operador2  + CHAR(39) +@ValorXML + CHAR(39) +' SET @Existe = 1 ELSE SET @Existe = 0'
  EXEC sp_executesql @SQL2, N' @Existe bit OUTPUT', @Existe = @Existe OUTPUT
  
  IF @Ok IS NULL
  BEGIN TRY  
    EXEC sp_executesql @SQL2, N' @Existe bit OUTPUT', @Existe = @Existe OUTPUT
    
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  al verificar valor' + CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH       
  IF @OK IS NOT NULL
    SET @OkRef = ' Error  al verificar valor(' + CONVERT(varchar,@Ok) +') ' + @OkRef

END
GO




 /******************************* speDocInDentroTabla *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInDentroTabla') and type = 'P') drop procedure dbo.speDocInDentroTabla
GO             
CREATE PROCEDURE speDocInDentroTabla
		@XML		    varchar(max),
		@Path               varchar(max),
		@Tabla              varchar(255),
		@Existe             bit = 0 OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @Valor              varchar(255),
    @SQL	       	nvarchar(max),
    @SQL2	       	nvarchar(max),
    @XMLNS		nvarchar(max)
  
  SET @Existe = 0
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@XML),'') IS NULL SELECT @Ok = 72340 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Path),'') IS NULL SELECT @Ok = 72350 ELSE
  IF NULLIF(@OK,0) IS NULL AND NULLIF(CONVERT(varchar,@Tabla),'') IS NULL SELECT @Ok = 72330 
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  
  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'  SELECT  @Valor = @xml.value(' + CHAR(39) + @XMLNS +'('+ @Path +')[1]'  + CHAR(39)+ ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ')' + 
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '   
                                   
  BEGIN TRY                  
    EXEC sp_executesql @SQL, N'@XML xml, @Valor  varchar(255)  OUTPUT, @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT',@XML = @XML, @Valor  = @Valor  OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  al verificar la tabla TablaValorD' + CONVERT(varchar,@Ok) + @OkRef+'('+@Tabla+')'
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH     
                      
  IF @OK IS NOT NULL
    SET @OkRef = ' Error  al verificar la tabla TablaValorD (' + CONVERT(varchar,@Ok) +') '+@OkRef+'('+@Tabla+')'

  SET @SQL2 = N'IF EXISTS(SELECT  * FROM TablaValorD WHERE TablaValor = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND Valor = ' + CHAR(39) + ISNULL(@Valor,'') + CHAR(39) + ')
               SELECT @Existe = 1 ELSE  SELECT @Existe = 0'
               
               

  IF @Ok IS NULL
  BEGIN TRY  
    EXEC sp_executesql @SQL2, N'@Existe  bit  OUTPUT', @Existe  = @Existe  OUTPUT
    
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  al verificar la tabla TablaValorD' + CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH     
    IF @OK IS NOT NULL
    SET @OkRef = ' Error  al verificar la tabla TablaValorD(' + CONVERT(varchar,@Ok) +') ' + @OkRef+'('+@Tabla+')'

END
GO




/******************************* speDocInCFDValido  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInCFDValido') and type = 'P') drop procedure dbo.speDocInCFDValido
GO             
CREATE PROCEDURE speDocInCFDValido

		
		@XML                                    xml,	
		@Operando1                              varchar(max), 
		@Origen                                 varchar(max), 
		@Empresa				varchar(5),
		@Valido                                 bit  OUTPUT,
		@Ok					int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @RutaFirmaSAT			varchar(255),
    @RutaCertificado		        varchar(255),
    @Shell				varchar(8000)  
    
  DECLARE @Datos			TABLE
  (
  Datos				varchar(255)
  )  

  SET @Valido = 0
  
  SELECT @RutaFirmaSAT = RutaFirmaSAT, @RutaCertificado = RutaCertificado FROM EmpresaCFD WHERE Empresa = @Empresa  

  SET @Shell = CHAR(34) + CHAR(34) + @RutaFirmaSAT + CHAR(34) + ' VERIFYSIG ' + CHAR(34) + @Origen + CHAR(34)+ CHAR(34)

  INSERT @Datos
  EXEC xp_cmdshell @Shell
  IF @@ERROR <> 0 SET @Ok = 1
  
  IF EXISTS(SELECT * FROM @Datos WHERE Datos = 'OK') AND @Ok IS NULL
  SELECT @Valido = 1

END
GO

/**************** xpeDocINXMLValido ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpeDocINXMLValido') and type = 'P') drop procedure dbo.xpeDocINXMLValido
GO
CREATE PROCEDURE xpeDocINXMLValido
                @XML		    varchar(max),
		@Existe             bit = 0 OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT
AS BEGIN
  SELECT @Existe = 1
  
  RETURN
END
GO

/******************************* speDocInNSOmision  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInNSOmision') and type = 'P') drop procedure dbo.speDocInNSOmision
GO  
CREATE PROCEDURE speDocInNSOmision  
  @XML  varchar(max),    
  @NameSpace      varchar(max),    
  @Omision        bit  = 0  OUTPUT  ,    
  @Ok             int  = NULL OUTPUT  ,  
  @OkRef          varchar(255)  = NULL OUTPUT     
      
    
--//WITH ENCRYPTION    
AS BEGIN    
  -- SET nocount ON    
 DECLARE    
    @Resultado   varchar(max),    
    @Longitud   bigint,    
    @Contador   bigint,    
    @Caracter   char(1),    
    @Estado    int,    
    @EstadoAnterior  int,    
    @Prefijo   varchar(max),    
    @Nombre    varchar(max)      
    
  DECLARE @xmlns TABLE    
  (    
   Prefijo     varchar(max) COLLATE DATABASE_DEFAULT NULL,    
   Nombre     varchar(max) COLLATE DATABASE_DEFAULT NULL    
  )      
      
  SET @Longitud = LEN(@XML)    
  SET @Contador = 1    
  SET @Estado = 0    
  SET @Prefijo = ''    
  SET @Nombre  = ''    
  SET @Omision = 0    
     
  WHILE @Contador <= @Longitud    
  BEGIN    
    SET @EstadoAnterior = @Estado    
    SET @Caracter = SUBSTRING(@XML,@Contador,1)    
        
    IF @Estado = 0 AND @Caracter = 'X'     SET @Estado = 1 ELSE    
    IF @Estado = 1 AND @Caracter NOT IN ('M')   SET @Estado = 0 ELSE            
    IF @Estado = 1 AND @Caracter = 'M'     SET @Estado = 2 ELSE    
    IF @Estado = 2 AND @Caracter NOT IN ('L')   SET @Estado = 0 ELSE                
    IF @Estado = 2 AND @Caracter = 'L'     SET @Estado = 3 ELSE        
    IF @Estado = 3 AND @Caracter NOT IN ('N')   SET @Estado = 0 ELSE                
    IF @Estado = 3 AND @Caracter = 'N'     SET @Estado = 4 ELSE            
    IF @Estado = 4 AND @Caracter NOT IN ('S')   SET @Estado = 0 ELSE                    
    IF @Estado = 4 AND @Caracter = 'S'     SET @Estado = 5 ELSE    
    IF @Estado = 5 AND @Caracter NOT IN (':','=') SET @Estado = 0 ELSE                    
    IF @Estado = 5 AND @Caracter = ':'     SET @Estado = 6 ELSE    
    IF @Estado = 5 AND @Caracter = '='     SET @Estado = 7 ELSE    
    IF @Estado = 6 AND @Caracter = '='            SET @Estado = 7 ELSE    
    IF @Estado = 7 AND @Caracter NOT IN ('"')   SET @Estado = 0 ELSE                            
    IF @Estado = 7 AND @Caracter = '"'            SET @Estado = 8 ELSE                
    IF @Estado = 8 AND @Caracter = '"'            SET @Estado = 9    
        
    IF @Estado = 6 AND @EstadoAnterior = 6    
    BEGIN    
      SET @Prefijo = @Prefijo + @Caracter    
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8    
    BEGIN    
      SET @Nombre = @Nombre + @Caracter    
    END ELSE IF @Estado = 9    
    BEGIN    
      IF NULLIF(@Nombre,'') IS NOT NULL    
      BEGIN    
        INSERT @xmlns (Prefijo, Nombre) VALUES (NULLIF(@Prefijo,''), NULLIF(@Nombre,''))    
      END    
      SET @Prefijo = ''    
      SET @Nombre = ''    
      SET @Estado = 0    
    END    
        
    SET @Contador = @Contador + 1    
  END      
     
  IF EXISTS(SELECT Nombre FROM @xmlns WHERE Nombre = @NameSpace AND Prefijo IS  NULL)    
  SET @Omision = 1 
     
      
END  

GO

/******************************* speDocInNSValido  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInNSValido') and type = 'P') drop procedure dbo.speDocInNSValido
GO             
CREATE PROCEDURE speDocInNSValido
  @XML  varchar(max),  
  @NameSpace      varchar(max),  
  @EsValido       bit  = 0  OUTPUT,  
  @Ok             int  = NULL OUTPUT  ,
  @OkRef          varchar(255)  = NULL OUTPUT  
    
    
  
--//WITH ENCRYPTION  
AS BEGIN  
  -- SET nocount ON  
 DECLARE  
    @Resultado   varchar(max),  
    @Longitud   bigint,  
    @Contador   bigint,  
    @Caracter   char(1),  
    @Estado    int,  
    @EstadoAnterior  int,  
    @Prefijo   varchar(max),  
    @Nombre    varchar(max)    
  
  DECLARE @xmlns TABLE  
  (  
   Prefijo     varchar(max) COLLATE DATABASE_DEFAULT NULL,  
   Nombre     varchar(max) COLLATE DATABASE_DEFAULT NULL  
  )    
    
  SET @Longitud = LEN(@XML)  
  SET @Contador = 1  
  SET @Estado = 0  
  SET @Prefijo = ''  
  SET @Nombre  = ''  
  SET @EsValido = 0  
    
  WHILE @Contador <= @Longitud  
  BEGIN  
    SET @EstadoAnterior = @Estado  
    SET @Caracter = SUBSTRING(@XML,@Contador,1)  
      
    IF @Estado = 0 AND @Caracter = 'X'     SET @Estado = 1 ELSE  
    IF @Estado = 1 AND @Caracter NOT IN ('M')   SET @Estado = 0 ELSE          
    IF @Estado = 1 AND @Caracter = 'M'     SET @Estado = 2 ELSE  
    IF @Estado = 2 AND @Caracter NOT IN ('L')   SET @Estado = 0 ELSE              
    IF @Estado = 2 AND @Caracter = 'L'     SET @Estado = 3 ELSE      
    IF @Estado = 3 AND @Caracter NOT IN ('N')   SET @Estado = 0 ELSE              
    IF @Estado = 3 AND @Caracter = 'N'     SET @Estado = 4 ELSE          
    IF @Estado = 4 AND @Caracter NOT IN ('S')   SET @Estado = 0 ELSE                  
    IF @Estado = 4 AND @Caracter = 'S'     SET @Estado = 5 ELSE  
    IF @Estado = 5 AND @Caracter NOT IN (':','=') SET @Estado = 0 ELSE                  
    IF @Estado = 5 AND @Caracter = ':'     SET @Estado = 6 ELSE  
    IF @Estado = 5 AND @Caracter = '='     SET @Estado = 7 ELSE  
    IF @Estado = 6 AND @Caracter = '='            SET @Estado = 7 ELSE  
    IF @Estado = 7 AND @Caracter NOT IN ('"')   SET @Estado = 0 ELSE                          
    IF @Estado = 7 AND @Caracter = '"'            SET @Estado = 8 ELSE              
    IF @Estado = 8 AND @Caracter = '"'            SET @Estado = 9  
      
    IF @Estado = 6 AND @EstadoAnterior = 6  
    BEGIN  
      SET @Prefijo = @Prefijo + @Caracter  
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8  
    BEGIN  
      SET @Nombre = @Nombre + @Caracter  
    END ELSE IF @Estado = 9  
    BEGIN  
      IF NULLIF(@Nombre,'') IS NOT NULL  
      BEGIN  
        INSERT @xmlns (Prefijo, Nombre) VALUES (NULLIF(@Prefijo,''), NULLIF(@Nombre,''))  
      END  
      SET @Prefijo = ''  
      SET @Nombre = ''  
      SET @Estado = 0  
    END  
      
    SET @Contador = @Contador + 1  
  END    
    
  IF EXISTS(SELECT Nombre FROM @xmlns WHERE Nombre = @NameSpace)  
  SET @EsValido = 1  
END
GO



/******************************* speDocINXMLValido *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocINXMLValido') and type = 'P') drop procedure dbo.speDocINXMLValido
GO             
CREATE PROCEDURE speDocINXMLValido
		@XML		    varchar(max),
		@Existe             bit = 0 OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  EXEC xpeDocINXMLValido @XML, @Existe OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT
 
 RETURN
END
GO


/******************************* speDocInRutaCondicion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaCondicion') and type = 'P') drop procedure dbo.speDocInRutaCondicion
GO             
CREATE PROCEDURE speDocInRutaCondicion
                @XML                    varchar(max),
                @Operando1              varchar(max), 
                @Operador               varchar(50), 
                @Operando2              varchar(max),
                @Origen                 varchar(max),
                @Empresa                varchar(5),
                @Existe                 bit = NULL OUTPUT,
                @Ok                     int = NULL OUTPUT,
		@OkRef                  varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  

  IF @Operador = 'ES EL NODO PRINCIPAL'
  BEGIN
       EXEC speDocInNodoPrincipal @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @Operador = 'SI EXISTE'
  BEGIN
    EXEC speDocInAtributoExiste @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END      
  IF @Operador = 'ES IGUAL A'
  BEGIN
    EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'IGUAL QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END  
  IF @Operador = 'ES MAYOR QUE'
  BEGIN
    EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'MAYOR QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @Operador = 'ES MENOR QUE'
  BEGIN
    EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'MENOR QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END  
  IF @Operador = 'ES MAYOR O IGUAL QUE'
  BEGIN
   EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'MAYOR O IGUAL QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END      
  IF @Operador = 'ES DIFERENTE QUE'
  BEGIN
    EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'DIFERENTE QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END  
  IF @Operador = 'ES MENOR O IGUAL QUE'
  BEGIN
    EXEC speDocInAtributoValorVerificar @XML,@Operando1,@Operando2,'MENOR O IGUAL QUE',@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END        
  IF @Operador = 'CONTIENE EL TEXTO'
  BEGIN
    EXEC speDocInTextoVerificar @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END      
  IF @Operador = 'ES EL NAME SPACE POR OMISION'
  BEGIN
    EXEC speDocInNSOmision @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END      
  IF @Operador = 'ES UN NAMESPACE VALIDO'
  BEGIN
    EXEC speDocInNSValido @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END      
  
  IF @Operador = 'DENTRO DE LA TABLA'
  BEGIN
    EXEC speDocInDentroTabla @XML,@Operando1,@Operando2, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END   

  IF @Operador = 'CFD VALIDO'
  BEGIN
    EXEC speDocInCFDValido @XML,@Operando1, @Origen, @Empresa, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    IF @Existe = 0
      SELECT @Ok = 72362, @OkRef =  '('+@Origen+') '-- +@OkRef 
  END 
  
  IF @Operador = 'XML VALIDO'
  BEGIN
    EXEC speDocINXMLValido  @XML,@Operando1,@Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
   
   IF @Ok IS NOT NULL SET @OkRef =  '('+@Operador+') ' +@OkRef 
    
END
GO




/******************************* speDocInRutaCondiciones *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaCondiciones') and type = 'P') drop procedure dbo.speDocInRutaCondiciones
GO             
CREATE PROCEDURE speDocInRutaCondiciones
		@eDocIn					varchar(50),
		@Ruta					varchar(50),
		@XML                                    varchar(max),
		@Tipo                                   varchar(50),
		@Origen                                 varchar(max),
		@Empresa                                varchar(5),
		@Valido                                 bit =NULL OUTPUT,
		@Ok					int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @GUID                 varchar(36), 
  @Cadena               varchar(max),
  @OperadorLogico       varchar(1),
  @Caracter             varchar(1),
  @Contador             int,
  @Operando1            varchar(max), 
  @Operador             varchar(50), 
  @Operando2            varchar(max),
  @Existe               bit,
  @SQL                  nvarchar(max),
  @TipoError            varchar(50),   
  @TotalCondicion       int
  
 IF @Tipo = 'Condicion' SET @TipoError = 'Condiciones'
 IF @Tipo = 'Validar' SET @TipoError = 'Validaciones'

  
  SET @Cadena = ''
  
  IF NOT EXISTS( SELECT * FROM eDocInRutaD  WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tipo = @Tipo)
    SELECT @Cadena = '(1)'
  ELSE  
  BEGIN 
    DECLARE crRutaDGrupo CURSOR FOR 
     SELECT GUID, OperadorLogico
       FROM eDocInRutaD 
      WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tipo = @Tipo
           
    SET @Contador = 1  
    OPEN crRutaDGrupo
    FETCH NEXT FROM crRutaDGrupo INTO @GUID, @OperadorLogico
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      IF @Contador = 1
        SET @Cadena = '('
      ELSE 
        SET @Cadena = @Cadena + ' & (' 
        
      SELECT @TotalCondicion = Count(*)
        FROM eDocInRutaDCondicion
       WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND GUID = @GUID



      IF @TotalCondicion = 0 OR NOT EXISTS(SELECT * FROM eDocInRutaDCondicion WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND GUID = @GUID)
        SET @Cadena =@Cadena+ '1'
      ELSE 
      BEGIN  
        DECLARE crRutaDCondicion CURSOR FOR 
         SELECT ISNULL(Operando1,''), ISNULL(Operador,''), ISNULL(Operando2,'')
           FROM eDocInRutaDCondicion
          WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND GUID = @GUID
         ORDER BY RID 
        OPEN crRutaDCondicion
        FETCH NEXT FROM crRutaDCondicion INTO @Operando1, @Operador, @Operando2
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
        
    
          SELECT @Caracter = CASE WHEN @OperadorLogico = 'Y' THEN '&' WHEN @OperadorLogico = 'O' THEN '|' END
        
          EXEC speDocInRutaCondicion @XML, @Operando1, @Operador, @Operando2, @Origen, @Empresa, @Existe  OUTPUT,  @Ok  OUTPUT,  @OkRef  OUTPUT  
         
          
          IF @Ok IS NOT NULL SET @OkRef =  '('+@Ruta+') ' +@OkRef 
             
          SET @Cadena = @Cadena+CONVERT(varchar,@Existe) 
          
          
          SET @TotalCondicion = @TotalCondicion -1      
          IF @TotalCondicion > 0
          SET @Cadena = @Cadena + @Caracter
          

          FETCH NEXT FROM crRutaDCondicion INTO @Operando1, @Operador, @Operando2
        END
        CLOSE crRutaDCondicion
        DEALLOCATE crRutaDCondicion 
      END          
      

      SET @Cadena = @Cadena + ')' 
      SET @Contador = @Contador + 1
      
     
      
      FETCH NEXT FROM crRutaDGrupo INTO @GUID, @OperadorLogico
    END
    CLOSE crRutaDGrupo
    DEALLOCATE crRutaDGrupo  
  END  

  SET @SQL =N'IF '+@Cadena+' = 1 SET @Valido = 1 ELSE SET @Valido = 0'

  IF @Ok IS NULL
  BEGIN TRY       
    EXEC sp_executesql @SQL, N' @Valido  bit OUTPUT', @Valido = @Valido OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  al verificar '+@TipoError + CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH   
  IF @Ok IS NOT NULL
    SET @OkRef = ' Error  al verificar '+@TipoError+'(' + CONVERT(varchar,@Ok) +') ' + @OkRef
   
END
GO




/******************************* speDocINValidarXML *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocINValidarXML') AND TYPE = 'P')
DROP PROCEDURE speDocINValidarXML
GO
CREATE PROCEDURE speDocINValidarXML
  (
  @XML                  varchar(max),
  @Ok			int = NULL OUTPUT,
  @OkRef		varchar(255) = NULL OUTPUT
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @x          xml


  BEGIN TRY   
    SET @x = CONVERT(xml,@Xml)
  END TRY 
  
  BEGIN CATCH   
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE()   
    IF XACT_STATE() = -1  
    BEGIN     
      ROLLBACK TRAN     
      SET @OkRef = 'Error  al validar el xml' + CONVERT(varchar,@Ok) + ', ' + @OkRef     
      RAISERROR(@OkRef,20,1) WITH LOG   
    END 
  END CATCH 
  IF @OK IS NOT NULL
    SET @OkRef = 'Error  al validar el xml(' + CONVERT(varchar,@Ok) +') ' + ', ' + @OkRef 
END 
GO         


/******************************* speDocINValidarXMLTyped *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocINValidarXMLTyped') AND TYPE = 'P')
DROP PROCEDURE speDocINValidarXMLTyped
GO
CREATE PROCEDURE speDocINValidarXMLTyped
  (
  @eDocIn       	varchar(50),
  @Ruta                 varchar(50),
  @XMLValidar	        varchar(MAX),
  @Ok			int OUTPUT,
  @OkRef		varchar(255) OUTPUT
  ) 
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @IDSQL			varchar(100),
    @Validacion			nvarchar(MAX),
    @Parametros			nvarchar(MAX),
    @Error				int,
    @ErrorRef			varchar(255),
    @Clave				varchar(50)

  SELECT @Clave = XSD 
    FROM eDocInRuta 
   WHERE  eDocIn = @eDocIn AND Ruta = @Ruta

 SET @IDSQL = @Clave
 
  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN  
    SET @Validacion = N'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 
                      N'BEGIN TRY ' + 
                      N'  SET @x = ' + CHAR(39) + RTRIM(@XMLValidar) + CHAR(39) + ' ' + 
                      N'END TRY ' + 
                      N'BEGIN CATCH ' +
                      N'  SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() ' +
                      N'  IF XACT_STATE() = -1 ' +
                      N'  BEGIN ' +
                      N'    ROLLBACK TRAN ' +
                      N'    SET @ErrorRef = ' + CHAR(39) + 'Error  ' + CHAR(39) + ' + CONVERT(varchar,@Error) + ' + CHAR(39) + ', ' + CHAR(39) + ' + @ErrorRef ' +
                      N'    RAISERROR(@ErrorRef,20,1) WITH LOG ' +
                      N'  END ' + 
                      N'END CATCH ' 


    SET @Parametros = N'@Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
    BEGIN TRY
      EXECUTE sp_executesql @Validacion, @Parametros, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT
      IF @Error IS NOT NULL SELECT @Ok = @Error, @OkRef = 'Error al validar el xml'+ @ErrorRef
    END TRY   
    BEGIN CATCH
      SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
      IF XACT_STATE() = -1   
      BEGIN
        ROLLBACK TRAN
        SET @OkRef = ' Error  ' + CONVERT(varchar,@Ok) + @OkRef
        RAISERROR(@OkRef,20,1) WITH LOG 
      END
    END CATCH     
    IF @OK IS NOT NULL
      SET @OkRef = 'Error  al validar el xml(' + CONVERT(varchar,@Ok) +') '+ ', ' + @OkRef 

  END
END 
GO

/******************************* speDocInRuta *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRuta') and type = 'P') drop procedure dbo.speDocInRuta
GO             
CREATE PROCEDURE speDocInRuta
		@XML                                    varchar(max),
		@Empresa                                varchar(5), 
		@Usuario                                varchar(10), 
		@Sucursal                               int,
		@Origen                                 varchar(max),
		@Estacion                               int,
		@Ok					int = NULL OUTPUT,
		@OkRef	 				varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @eDocIn                varchar(50),
  @Ruta                  varchar(50),
  @XSD                   varchar(50),
  @Valido                bit,
  @Verificado            bit,
  @Fecha                 datetime
  
  
  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
  
  SET @Valido = 0
  SET @Verificado = 0
  
  
  
  DECLARE creDocINRuta CURSOR FOR 
   SELECT eDocIn, Ruta, NULLIF(XSD,'')
     FROM eDocInRuta 
    WHERE @Fecha BETWEEN ISNULL(VigenciaDe,@Fecha) AND ISNULL(VigenciaA,@Fecha)
  GROUP BY eDocIn, Ruta, XSD

  OPEN creDocINRuta
  FETCH NEXT FROM creDocINRuta INTO @eDocIn, @Ruta, @XSD
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    
    IF @Ok IS NULL
    BEGIN

      EXEC speDocInRutaCondiciones  @eDocIn, @Ruta, @XML,'Condicion', @Origen, @Empresa, @Valido  OUTPUT, @Ok   OUTPUT, @OkRef  OUTPUT

      IF @Ok IS NULL AND @XSD IS NOT NULL
        EXEC speDocINValidarXMLTyped  @eDocIn, @Ruta, @XML, @Ok   OUTPUT, @OkRef  OUTPUT
      
      IF @Ok IS NULL AND @XSD IS  NULL
        EXEC speDocINValidarXML @XML, @Ok   OUTPUT, @OkRef  OUTPUT
          
      IF @Ok IS NULL
        EXEC speDocInRutaCondiciones  @eDocIn, @Ruta, @XML,'Validar', @Origen, @Empresa, @Verificado  OUTPUT, @Ok   OUTPUT, @OkRef  OUTPUT  
        
      IF EXISTS(SELECT * FROM eDocInRutaD WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tipo = 'Validar') AND @Verificado = 0 AND @Ok IS NULL
        SELECT  @Ok = 72363 ,@OkRef = '('+@eDocIn+','+ @Ruta+')'
             

      IF @Valido = 1 AND @Verificado = 1 AND @Ok IS NULL
      EXEC speDocInXML   @eDocIn, @Ruta, @XML, @Empresa, @Usuario, @Sucursal, @Origen, @Ok  OUTPUT, @OkRef  OUTPUT
    END  

    FETCH NEXT FROM creDocINRuta INTO @eDocIn, @Ruta, @XSD
  END
  CLOSE creDocINRuta
  DEALLOCATE creDocINRuta  
  
  IF @Ok IS NOT NULL --AND @OkRef IS NULL
    SELECT @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok

END
GO





  /**************** fnExtencionArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtencionArchivo') DROP FUNCTION fnExtencionArchivo
GO
CREATE FUNCTION dbo.fnExtencionArchivo
(@Archivo varchar(255)) 
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Extension varchar(255),
  @Posicion  int
  
SELECT @Posicion = CASE (CHARINDEX('.', @Archivo))
		   WHEN 0 THEN -1
		   ELSE LEN(@Archivo) - CHARINDEX('.', REVERSE(@Archivo)) +1
		   END
SET	@Extension = SUBSTRING(@Archivo, @Posicion, LEN(@Archivo))
  
                 
  RETURN (@Extension)
 END

GO

--select dbo.fnExtencionArchivo('000102 CCC34Jasper.XML')

/******************************* speDocInListarDirectorio *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarDirectorio') and type = 'P') drop procedure dbo.speDocInListarDirectorio
GO             
CREATE PROCEDURE speDocInListarDirectorio
		@PathDir            varchar(8000),
                @Estacion           int
--//WITH ENCRYPTION
AS BEGIN
DECLARE
 @Contador         int,
 @NombreI          varchar(8000) ,
 @DirectorioCount  int,
 @IsFile           bit,
 @ObjFile          int,
 @ObjFileSystem    int,
 @Nombre           varchar(8000),
 @Path             varchar(8000),
 @Tipo             varchar(8000),
 -- 9562
 @Date			   datetime
  
DECLARE @Directorio table
(RowNum int IDENTITY(1,1),
 Nombre varchar(256) PRIMARY KEY CLUSTERED, 
 Depth  bit, 
 IsFile bit)

  DELETE eDocInDirDetalle WHERE Estacion = @Estacion
--SET NOCOUNT ON
 SELECT @PathDir = @PathDir+'\'
  WHERE RIGHT(@PathDir,1)<>'\'
  
  INSERT INTO @Directorio (Nombre, Depth, IsFile)
  EXEC Master.dbo.xp_DirTree @PathDir,1,1
   
   
  SET @DirectorioCount = @@ROWCOUNT

  UPDATE @Directorio
     SET Nombre = @PathDir + Nombre
  EXEC dbo.sp_OACreate 'Scripting.FileSystemObject', @ObjFileSystem OUT


 SET @Contador = 1
 WHILE @Contador <= @DirectorioCount
 BEGIN

   SELECT @NombreI= Nombre, @IsFile = IsFile
     FROM @Directorio 
    WHERE RowNum = @Contador
       
    -- 9562
    IF @IsFile = 1 AND @NombreI LIKE '%%'
    BEGIN
      EXEC dbo.sp_OAMethod @ObjFileSystem,'GetFile',		@ObjFile	OUT, @NombreI
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Path',           @Path       OUT
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Name',           @Nombre     OUT
      EXEC dbo.sp_OAGetProperty @ObjFile, 'DateCreated',	@Date       OUT

      INSERT INTO eDocInDirDetalle(Path,  Nombre,  Tipo, Estacion, FechaCreacion)
      SELECT @Path,@Nombre,dbo.fnExtencionArchivo(@Nombre), @Estacion, @Date    
    END
        

    SELECT @Contador = @Contador + 1
  END

 EXEC sp_OADestroy @ObjFileSystem
 EXEC sp_OADestroy @ObjFile

END
GO







  /**************** fneDocInLeerArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInLeerArchivo') DROP FUNCTION fneDocInLeerArchivo
GO
CREATE FUNCTION dbo.fneDocInLeerArchivo
(@Path   varchar(255), @Nombre  varchar(255)) 
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @Resultado            varchar(max),
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @ManejadorTexto       int,
  @Ok                   int,
  @OkRef                varchar(255),
  @Ruta                 varchar(255),
  @Cadena               varchar(8000),
  @SiONo                int,
  @Origen               varchar(255),
  @Descripcion          varchar(255),
  @Archivo              varchar(255),
  @ID                   int

  SELECT @Resultado=''
  SELECT @OkRef='opening the File System Object'
  EXEC @ResultadoOLE = sp_OACreate  'Scripting.FileSystemObject' , @ManejadorObjeto OUT
  IF @ResultadoOLE=0 
    SELECT @Ok=@ManejadorObjeto, @OkRef='Opening file "'+@path+'\'+@Nombre+'"',@Ruta=@path+'\'+@Nombre

  IF @ResultadoOLE=0 
    EXEC @ResultadoOLE = sp_OAMethod   @ManejadorObjeto  , 'OpenTextFile', @ManejadorTexto OUT, @Ruta,1,false,0--for reading, FormatASCII

  WHILE @ResultadoOLE=0
  BEGIN
    IF @ResultadoOLE=0 
      SELECT @Ok=@ManejadorTexto, @OkRef='finding out IF there is more to read in "'+@Nombre+'"'
    IF @ResultadoOLE=0 
      EXEC @ResultadoOLE = sp_OAGetProperty @ManejadorTexto, 'AtENDOfStream', @SiONo OUTPUT

    IF @SiONo<>0  BREAK

    IF @ResultadoOLE=0 
      SELECT @Ok=@ManejadorTexto, @OkRef='reading from the OUTPUT file "'+@Nombre+'"'
    IF @ResultadoOLE=0 
      EXEC @ResultadoOLE = sp_OAMethod  @ManejadorTexto, 'Read', @Cadena OUTPUT,4000
    SELECT @Resultado=@Resultado+@Cadena
  END
  IF @ResultadoOLE=0 SELECT @Ok=@ManejadorTexto, @OkRef='closing the OUTPUT file "'+@Nombre+'"'
  IF @ResultadoOLE=0 EXEC @ResultadoOLE = sp_OAMethod  @ManejadorTexto, 'Close'


  IF @ResultadoOLE<>0
  BEGIN
    EXEC sp_OAGetErrorInfo  @Ok, @Origen OUTPUT,@Descripcion OUTPUT,@Archivo OUTPUT,@ID OUTPUT
    SELECT @OkRef='Error whilst ' + COALESCE(@OkRef,'doing something')+ ', '+COALESCE(@Descripcion,'')
    SELECT @Resultado=@OkRef
  END
  EXEC  sp_OADestroy @ManejadorTexto-- Fill the table variable with the rows for your result set

  RETURN @Resultado
END
go



  
/******************************* spMoverArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spMoverArchivo') AND TYPE = 'P')
DROP PROCEDURE spMoverArchivo
GO
CREATE PROCEDURE spMoverArchivo    
	(    
	@Origen 			varchar(255),    
	@Destino			varchar(255),    
 	@Ok				int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE				int,
  @ManejadorObjeto			int
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Origen  

  --Mueve el archivo
  EXECUTE @ResultadoOLE =sp_oamethod @ManejadorObjeto, 'moveFile',null,@Origen, @Destino

  IF @ManejadorObjeto IS NOT NULL
  BEGIN
    EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
    IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Origen
  END
  

    
END
GO    

/*
exec spMoverArchivo 'C:\Salida\1.xml','C:\Entrada\1.xml'
*/


/******************************* speDocInRutaNodos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaNodos') and type = 'P') drop procedure dbo.speDocInRutaNodos
GO             
CREATE PROCEDURE speDocInRutaNodos
		@XML		    xml,
		@Ruta               varchar(max)= NULL OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @NodoPrincipalXML   varchar(100),
    @SQL	       	nvarchar(max),
    @XMLNS		nvarchar(max)
  
  SET @Ruta = ''
  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)



  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'  SELECT  @NodoPrincipalXML = @xml.value(' + CHAR(39) + @XMLNS + 'local-name((/*/*/*)[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ')' +
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '               

  BEGIN TRY
    EXEC sp_executesql @SQL, N'@XML xml, @NodoPrincipalXML varchar(255)  OUTPUT,  @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @NodoPrincipalXML = @NodoPrincipalXML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error Nodo ' + @NodoPrincipalXML+' '+ CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH   
  IF @OK IS NOT NULL
    SET @OkRef = ' Error Nodo ' + @NodoPrincipalXML+' (' + CONVERT(varchar,@Ok) +') '+@OkRef    
  
  SELECT @Ruta = ''+@NodoPrincipalXML
END
GO

/******************************* speDocInRutaRemoverNodos*************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaRemoverNodos') and type = 'P') drop procedure dbo.speDocInRutaRemoverNodos
GO             
CREATE PROCEDURE speDocInRutaRemoverNodos
		@XML		    xml,
		@Ruta               varchar(500),
		@Resultado          xml = NULL OUTPUT,
		@Ok                 int = NULL OUTPUT,
		@OkRef              varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DECLARE 
    @NodoPrincipalXML   varchar(100),
    @SQL	       	nvarchar(max),
    @XMLNS		nvarchar(max)
  

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)

  SET @SQL = N'SET ANSI_NULLS ON ' +
             N'SET ANSI_WARNINGS ON ' +
             N'SET QUOTED_IDENTIFIER ON ' +
             N'BEGIN TRY ' +
             N'  SELECT  @Resultado = @xml.query(' + CHAR(39) + @XMLNS + '(//'+@Ruta +')'+ CHAR(39) + ')' +
             N'END TRY ' + 
             N'BEGIN CATCH ' +
             N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
             N'  IF XACT_STATE() = -1 ' +
             N'  BEGIN ' +
             N'    ROLLBACK TRAN ' +
             N'    SET @OkRef = ' + CHAR(39) + N'Error  ' + CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
             N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
             N'  END ' + 
             N'END CATCH '               
  BEGIN TRY
    EXEC sp_executesql @SQL, N'@XML xml, @Resultado xml  OUTPUT,  @Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @XML = @XML, @Resultado = @Resultado OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error al remover nodos ' + CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH   
  IF @OK IS NOT NULL
    SET @OkRef = ' Error al remover nodos (' + CONVERT(varchar,@Ok) +') '+ @OkRef                        
              
  
END
GO

/**************** speDocInAntesAfectar  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInAntesAfectar') and type = 'P') drop procedure dbo.speDocInAntesAfectar
GO             
CREATE PROCEDURE speDocInAntesAfectar
                        @AntesAfectar     varchar(50),
                        @eDocIn		  varchar(50),
		        @Ruta		  varchar(50),
                        @ID               int,
                        @Modulo           varchar(5),
                        @Ok               int           OUTPUT,
                        @OkRef            varchar(255)  OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @SQL            nvarchar(max),
  @SQL2           varchar(max),
  @SP             varchar(100),
  @Param1         bit,
  @Param2         bit
  --@iSolicitud   int
  
  
  SELECT @SP = SP, @Param1 = Param1, @Param2 =Param2   
    FROM eDocInRutaExpresion
   WHERE  eDocIn = @eDocIn AND Ruta = @Ruta
  IF @AntesAfectar = 'Stored Procedure'
  BEGIN
    
    SELECT @SQL2 = @SP+' '+ CASE WHEN @Param1 = 1 THEN ISNULL(CONVERT(varchar,@ID),'') ELSE '' END+ CASE WHEN @Param2 = 1 AND @Param1 =1 THEN ' ,'+CHAR(39)+ISNULL(@Modulo,'')+CHAR(39) ELSE '' END
  
    SET @SQL = N'SET ANSI_NULLS ON ' +
               N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +
               N'BEGIN TRY ' +
               N'  EXEC  ' + @SQL2  
               +N'  END TRY ' + 
               N'BEGIN CATCH ' +
               N'  SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() ' +
               N'  IF XACT_STATE() = -1 ' +
               N'  BEGIN ' +
               N'    ROLLBACK TRAN ' +
               N'    SET @OkRef = ' + CHAR(39) + N'Error  ' +@SP+' '+ CHAR(39) + N' + CONVERT(varchar,@Ok) + ' + CHAR(39) + N', ' + CHAR(39) + N' + @OkRef ' +
               N'    RAISERROR(@OkRef,20,1) WITH LOG ' +
               N'  END ' + 
               N'END CATCH '   
            
                 
      EXEC sp_executesql @SQL, N'@Ok   int OUTPUT, @OkRef varchar(255) OUTPUT', @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @OK IS NOT NULL
        SET @OkRef = ' Error al ejecutar el Stored Procedure ' +@SP+' (' + CONVERT(varchar,@Ok) +') '+@OkRef

   END
   IF @AntesAfectar = 'ReCalcular Gasto'
     EXEC spGastoRecalcularDetalle @ID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT
   RETURN
END
GO


/******************************* speDocInXML *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInXML') and type = 'P') drop procedure dbo.speDocInXML
GO             
CREATE PROCEDURE speDocInXML
		@eDocIn					varchar(50),
		@Ruta					varchar(50),
		@Documento                              varchar(max),
		@Empresa                                varchar(5),
		@Usuario				varchar(10),
		@Sucursal				int,
		@Origen                                 varchar(max),
		@Ok					int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Hoy				datetime,
  @HoyTexto			varchar(50),
  @Movimiento		        varchar(20),
  @Modulo			varchar(5),
  @UsuarioMoneda                varchar(10),
  @EmpresaMoneda                varchar(10),
  @Almacen                      varchar(10),
  @Tabla                        varchar(50),
  @Parametros                   nvarchar(max),
  @ID                           int,
  @IDGenerar                    int,
  @Afectar                      bit,
  @SQL                          nvarchar(max),
  @SQL2                         varchar(max),
  @SQL3                         nvarchar(max),
  @XML                          xml,
  @TipoCambio                   float,
  @Estacion                     int,
  @Estatus                      varchar(20),
  @Mov                          varchar(20),
  @MovID                        varchar(20),
  @AntesAfectar                 varchar(50)
  
  SELECT @Estacion = @@SPID
  DELETE FROM eDocInVariableTemp WHERE Estacion = @@SPID

  SET @eDocIn = RTRIM(ISNULL(@eDocIn,''))
  SET @Ruta = RTRIM(ISNULL(@Ruta,''))  
  SET @Sucursal = ISNULL(@Sucursal,0)  
  SELECT @Movimiento = RTRIM(ISNULL(Mov,'')), @Modulo = RTRIM(ISNULL(Modulo,'')), @Afectar = ISNULL(Afectar,0), @AntesAfectar = NULLIF(AntesAfectar,'') FROM eDocINRuta WHERE eDocIn = @eDocIN AND Ruta = @Ruta
  SELECT @Documento = dbo.fneDocInBorrarXmlnsOmision(@Documento)
  SELECT @Xml = CONVERT(xml,@Documento)
  SELECT @UsuarioMoneda = DefMoneda, @Almacen = DefAlmacen FROM Usuario WHERE Usuario = @Usuario
  SELECT @EmpresaMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @TipoCambio = m.TipoCambio FROM Mon m WHERE m.Moneda = ISNULL(@UsuarioMoneda,@EmpresaMoneda)
  
  IF NULLIF(@eDocIn,'') IS NULL OR NOT EXISTS(SELECT 1 FROM eDocIn WHERE eDocIn = @eDocIn) SELECT @Ok = 72200, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ')' ELSE
  IF NULLIF(@Ruta,'') IS NULL OR NOT EXISTS(SELECT 1 FROM eDocInRuta WHERE eDocIn = @eDocIn AND Ruta = @Ruta) SELECT @Ok = 72210, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ')'   ELSE  
  IF NULLIF(@Modulo,'') IS NULL OR NOT EXISTS(SELECT 1 FROM Modulo WHERE Modulo = @Modulo) SELECT @Ok = 70020, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ', ' + @Modulo + ')'   ELSE    
  IF NULLIF(@Movimiento,'') IS NULL OR NOT EXISTS(SELECT 1 FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Movimiento) SELECT @Ok = 70025, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ', ' + @Modulo + ', ' + @Movimiento + ')'   ELSE      
  IF NULLIF(@Usuario,'') IS NULL SELECT @Ok = 71010, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ')' ELSE
  IF NULLIF(@Almacen,'') IS NULL AND EXISTS (SELECT * FROM eDocInRutaTablaD WHERE CampoTabla LIKE 'Almacen%' AND EsIndependiente = 1 AND ExpresionXML = '{Almacen}' AND eDocIn = @eDocIn AND Ruta = @Ruta )  SELECT @Ok = 10576, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ')' ELSE
  IF NOT EXISTS(SELECT 1 FROM Sucursal WHERE Sucursal = @Sucursal) SELECT @Ok = 72060, @OkRef = '(' + RTRIM(@eDocIn) + ', ' + @Ruta + ')'  
  
  
  SET @Hoy = dbo.fnFechaSinHora(GETDATE())
  SET @HoyTexto = RTRIM(CONVERT(varchar,@Hoy,126))
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Hoy', @HoyTexto, 'FECHA')
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Usuario', @Usuario, 'TEXTO')    
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Sucursal', @Sucursal, 'NUMERICO')  
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Movimiento', @Movimiento, 'TEXTO')    
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Modulo', @Modulo, 'TEXTO')      
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Moneda', ISNULL(NULLIF(@UsuarioMoneda,''),@EmpresaMoneda), 'TEXTO')      
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'Almacen', @Almacen, 'TEXTO')      
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'EstatusSinAfectar', 'SINAFECTAR', 'TEXTO')    
  INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'TipoCambio', @TipoCambio, 'NUMERICO')  
    

  IF @Ok IS  NULL
  EXEC speDocInInsertarConsecutivos @eDocIn, @Ruta, @Xml OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    DECLARE crGeneraInsertTabla CURSOR FOR
     SELECT Tablas
       FROM eDocInRutaTabla 
      WHERE eDocIn = @eDocIn AND  Ruta = @Ruta 
     GROUP BY Tablas  
        
    OPEN crGeneraInsertTabla
    FETCH NEXT FROM crGeneraInsertTabla INTO @Tabla
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      
      SELECT @SQL = dbo.fneDocInGenerarInsertTabla(@eDocIn,@Ruta,@Tabla)

      SET @Parametros = N'@XML xml, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT,@ID int OUTPUT'
      BEGIN TRY
        EXECUTE sp_executesql @SQL, @Parametros, @XML = @XML, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT,@ID = @ID OUTPUT
      END TRY   
      BEGIN CATCH
        SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
        IF XACT_STATE() = -1   
        BEGIN
          ROLLBACK TRAN
          SET @OkRef = ' Error al insertar la tabla '+@Tabla+' '+ + CONVERT(varchar,@Ok) + @OkRef+'('+@Tabla+')'
          RAISERROR(@OkRef,20,1) WITH LOG 
        END
      END CATCH   
      IF @Ok IS NOT NULL
        SET @OkRef = ' Error al insertar la tabla '+@Tabla+' (' + CONVERT(varchar,@Ok) +') '+ @OkRef+'('+@Tabla+')'                      
          

      IF @ID IS NOT NULL
      BEGIN
        INSERT eDocInVariableTemp (Estacion, Variable, Valor, Tipo) VALUES (@@SPID, 'ID', @ID, 'NUMERICO')  
        IF @@ERROR <> 0 SELECT @Ok = 72320 , @OkRef = @OkRef +'('+@Tabla+')'
        SELECT @IDGenerar = @ID
      END
      SET @ID = NULL  
       
      FETCH NEXT FROM crGeneraInsertTabla INTO @Tabla
    END
    CLOSE crGeneraInsertTabla
    DEALLOCATE crGeneraInsertTabla
  END  

  IF @Ok IS NULL 
  BEGIN
    SELECT @Tabla = dbo.fnMovTabla(@Modulo)
    
    IF @AntesAfectar IS NOT NULL AND @IDGenerar IS NOT NULL 
      EXEC speDocInAntesAfectar @AntesAfectar, @eDocIn, @Ruta, @IDGenerar, @Modulo, @Ok OUTPUT, @OkRef OUTPUT
    
    IF @IDGenerar IS NOT NULL AND @Afectar = 1 AND @Ok IS NULL
       EXEC spAfectar @Modulo, @IDGenerar, 'AFECTAR','TODO', NULL ,@Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT, @Conexion = 1
     
    ELSE
    IF @IDGenerar IS NOT NULL AND @Afectar = 0  AND @Ok IS NULL
    SELECT @SQL2 = 'UPDATE '+ @Tabla+' SET Estatus = '+CHAR(39)+'BORRADOR'+CHAR(39)+' WHERE ID = '+CONVERT(varchar,@IDGenerar)
    EXEC (@SQL2)

    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NULL
    BEGIN 
      SET @SQL3 = N'  SELECT  @Mov = Mov , @MovID = MovID, @Estatus = Estatus FROM  '+@Tabla+'  WHERE ID = '+CONVERT(varchar,@IDGenerar)
      EXEC sp_executesql @SQL3, N'@Mov varchar(20)  OUTPUT,@MovID   varchar(20)  OUTPUT, @Estatus  varchar(20)  OUTPUT', @Mov = @Mov  OUTPUT, @MovID = @MovID OUTPUT, @Estatus = @Estatus OUTPUT
    END
    
    IF @Ok IS NULL AND @IDGenerar IS NOT NULL
    INSERT eDocInRutaTemp( eDocIn,  Ruta,  Modulo,  ID,         Estacion,  Mov,                 Estatus, Origen)
    SELECT                 @eDocIn, @Ruta, @Modulo, @IDGenerar, @Estacion, @Mov + ' ' + ISNULL(@MovID,''), @Estatus, @Origen
    IF @@ERROR <> 0 SET @Ok = 1

  END  

END
GO




/******************************* speDocInInsertarIS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInInsertarIS') and type = 'P') drop procedure dbo.speDocInInsertarIS
GO             
CREATE PROCEDURE speDocInInsertarIS
		@Origen                                 varchar(255),
		@Destino                                varchar(255),
		@Extencion                              varchar(255),
		@Empresa                                varchar(5), 
		@Usuario                                varchar(10), 
		@Sucursal                               int,
		@Ok					int = NULL OUTPUT,
		@OkRef	 				varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @xml         varchar(max),
  @xml2        xml,
  @xml3        xml,
  @Resultado   varchar(max),
  @Nombre      varchar(255),
  @ID          int,
  @Estacion    int,
  @Origen2     varchar(255),
  @Destino2    varchar(255),
  @Contrasena  varchar(32),
  @Existe      int,
  @Contador    int
  

   SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
   SELECT @Estacion = @@SPID
   EXEC speDocInListarDirectorio @Origen, @Estacion
   
 
   DECLARE creDocInDir CURSOR FOR 
    SELECT Nombre 
      FROM eDocInDirDetalle 
     WHERE  Estacion = @Estacion AND Tipo = @Extencion 
   ORDER BY RowNum
 
   OPEN creDocInDir
   FETCH NEXT FROM creDocInDir INTO @Nombre
   WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
   BEGIN
     SELECT @Origen2 =NULL , @Destino2 = NULL
     SELECT @Xml =  dbo.fneDocInLeerArchivo(@Origen,@Nombre)
  
     IF @Ok IS NULL   
     BEGIN TRY       
       SELECT @xml2 = CONVERT(xml,@xml)
     END TRY   
     BEGIN CATCH
       SELECT @Ok = @@ERROR,  @OkRef = ' Error  xml Invalido ' +ERROR_MESSAGE() 
       IF XACT_STATE() = -1   
       BEGIN
         ROLLBACK TRAN
         SET @OkRef = ' Error  xml Invalido (' + CONVERT(varchar,@Ok) +') ' + @OkRef
         RAISERROR(@OkRef,20,1) WITH LOG 
       END
     END CATCH    
  
       SELECT @Xml = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eDocInProcesar" SubReferencia="" Version="1.0"><Solicitud  Empresa ="'+@Empresa+'" Sucursal="'+CONVERT(varchar,@Sucursal)+'" Usuario ="'+@Usuario+'" Origen ="'+@Origen+'\'+@Nombre+'" >'+CONVERT(varchar(max),@xml2)+'</Solicitud></Intelisis>'
 
       BEGIN TRY       
         SELECT @xml3 = CONVERT(xml,@xml)
       END TRY   
       BEGIN CATCH
         SELECT @Ok = @@ERROR,  @OkRef =' Error  xml Invalido ' +ERROR_MESSAGE() 
        
         IF XACT_STATE() = -1   
         BEGIN
           ROLLBACK TRAN
           SET @OkRef = ' Error  xml Invalido(' + CONVERT(varchar,@Ok) +') '+ @OkRef
           RAISERROR(@OkRef,20,1) WITH LOG 
         END
       END CATCH 
       IF @Ok IS NOT NULL
       BEGIN
         SELECT @Xml = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eDocInProcesar" SubReferencia="XML.Invalido" Version="1.0"><Solicitud  Empresa ="'+@Empresa+'" Sucursal="'+CONVERT(varchar,@Sucursal)+'" Usuario ="'+@Usuario+'" Origen ="'+@Origen+'\'+@Nombre+'" Ok ="'+CONVERT(varchar,@OK)+'" OkRef ="'+@OkRef+'">'+'<![CDATA['+ISNULL(@xml,'')+']]>'+'</Solicitud></Intelisis>'
         SELECT @Ok = NULL, @OkRef = NULL
       END    
       EXEC spIntelisisService @Usuario,@Contrasena,@xml,@Resultado,@Ok OUTPUT,@OkRef OUTPUT,1,0,@ID OUTPUT
       IF @ID IS NOT NULL 
       UPDATE IntelisisService SET eDocInArchivo = @Nombre
        WHERE ID = @ID
   
       SELECT @Origen2 = @Origen+'\'+@Nombre, @Destino2 = @Destino+'\'+@Nombre   
       
       IF @Ok IS NULL
       BEGIN
         EXEC spEliminarArchivo  @Destino2 , @Ok OUTPUT, @OkRef OUTPUT
       
         IF @Ok IS NULL
         EXEC spMoverArchivo  @Origen2, @Destino2, @Ok OUTPUT, @OkRef OUTPUT
       END
 
 
     FETCH NEXT FROM creDocInDir INTO @Nombre
   END
   CLOSE creDocInDir
   DEALLOCATE creDocInDir   

END
GO



/******************************* speDocInPrefijo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.speDocInPrefijo') AND TYPE = 'P')
DROP PROCEDURE speDocInPrefijo
GO

CREATE PROCEDURE speDocInPrefijo
  (
  @XML				varchar(max),
  @Estacion                     int,
  @Ok				int = NULL OUTPUT,
  @OkRef			varchar(255) = NULL OUTPUT
  ) 		

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(max),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado			int,
    @EstadoAnterior		int,
    @Prefijo			varchar(max),
    @Nombre			varchar(max)
    
  SET @Resultado = ''
      
  IF NULLIF(@XML,'') IS NULL RETURN @Resultado
  
  IF EXISTS (SELECT * FROM eDocInNSPrefijo WHERE Estacion = @Estacion)
  DELETE eDocInNSPrefijo WHERE Estacion = @Estacion
  
  SET @Longitud = LEN(@XML)
  SET @Contador = 1
  SET @Estado = 0
  SET @Prefijo = ''
  SET @Nombre  = ''
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@XML,@Contador,1)
    
    IF @Estado = 0 AND @Caracter = 'X'			  SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter NOT IN ('M')	  SET @Estado = 0 ELSE        
    IF @Estado = 1 AND @Caracter = 'M'			  SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter NOT IN ('L')	  SET @Estado = 0 ELSE            
    IF @Estado = 2 AND @Caracter = 'L'			  SET @Estado = 3 ELSE    
    IF @Estado = 3 AND @Caracter NOT IN ('N')	  SET @Estado = 0 ELSE            
    IF @Estado = 3 AND @Caracter = 'N'			  SET @Estado = 4 ELSE        
    IF @Estado = 4 AND @Caracter NOT IN ('S')	  SET @Estado = 0 ELSE                
    IF @Estado = 4 AND @Caracter = 'S'			  SET @Estado = 5 ELSE
    IF @Estado = 5 AND @Caracter NOT IN (CHAR(58),'=') SET @Estado = 0 ELSE                
    IF @Estado = 5 AND @Caracter = CHAR(58)	  SET @Estado = 6 ELSE
    IF @Estado = 5 AND @Caracter = '='			  SET @Estado = 7 ELSE
    IF @Estado = 6 AND @Caracter = '='     	      SET @Estado = 7 ELSE
    IF @Estado = 7 AND @Caracter NOT IN ('"')	  SET @Estado = 0 ELSE                        
    IF @Estado = 7 AND @Caracter = '"'     	      SET @Estado = 8 ELSE            
    IF @Estado = 8 AND @Caracter = '"'     	      SET @Estado = 9
    
    IF @Estado = 6 AND @EstadoAnterior = 6
    BEGIN
      SET @Prefijo = @Prefijo + @Caracter
    END ELSE IF @Estado = 8 AND @EstadoAnterior = 8
    BEGIN
      SET @Nombre = @Nombre + @Caracter
    END ELSE IF @Estado = 9
    BEGIN
      IF NULLIF(@Nombre,'') IS NOT NULL
      BEGIN
        INSERT eDocInNSPrefijo (Estacion, Prefijo, Nombre) VALUES (@Estacion, NULLIF(@Prefijo,''), NULLIF(@Nombre,''))
      END
      SET @Prefijo = ''
      SET @Nombre = ''
      SET @Estado = 0
    END
    
    SET @Contador = @Contador + 1
  END  

  UPDATE eDocInNSPrefijo SET Prefijo = Prefijo +CHAR(58) WHERE Prefijo IS NOT NULL AND Estacion = @Estacion
  
 
END
GO


/******************************* spDocInXmlNSListarNodo2  *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spDocInXmlNSListarNodo2') AND TYPE = 'P')
DROP PROCEDURE spDocInXmlNSListarNodo2
GO

CREATE PROCEDURE spDocInXmlNSListarNodo2
	(
	@XML				 varchar(max),
	@Nodo                           varchar(max),
	@Estacion                       int,
	@Resultado2			varchar(max) OUTPUT
	)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    
    @Prefijo			varchar(max),
    @Nombre			varchar(max),
    @Path			varchar(max),
    @XMLNS			varchar(max),
    @NodoPrincipalXML    	varchar(max),
    @SQL			nvarchar(max),
    @Resultado			varchar(max)
    
  SET @Resultado2 = ''
      
  IF @Nodo = '/' RETURN
  IF @Nodo = '' RETURN

  SET @XMLNS = dbo.fneDocInXmlns(CONVERT(varchar(max),@XML),0)
  DECLARE crXMLNS CURSOR FOR
   SELECT Prefijo, Nombre
     FROM eDocInNSPrefijo
    WHERE Estacion = @Estacion 
    ORDER BY ID
    
  OPEN crXMLNS
  FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  WHILE @@FETCH_STATUS = 0 AND NULLIF(@Resultado,'') IS  NULL
  BEGIN
    IF @Nodo <> '/'
    SET @Path = @Nodo
    

    SET @SQL = N'SET ANSI_NULLS ON ' +
               N'SET ANSI_WARNINGS ON ' +
               N'SET QUOTED_IDENTIFIER ON ' +
               N'  SELECT  @Resultado = @xml.value(' + CHAR(39) + @XMLNS + 'local-name((//'+ISNULL(@Prefijo,'')+@Path+'/*)[1])' + CHAR(39) + ',' + CHAR(39) + 'varchar(max)' + CHAR(39) + ')' 
       

    EXEC sp_executesql @SQL, N'@XML xml, @Resultado varchar(max)  OUTPUT', @XML = @XML, @Resultado = @Resultado OUTPUT 
    
    IF NULLIF(@Resultado,'') IS NOT NULL
     SELECT @Resultado2 = ISNULL(@Prefijo,'')+@Nodo

    FETCH NEXT FROM crXMLNS INTO @Prefijo, @Nombre
  END
  CLOSE crXMLNS
  DEALLOCATE crXMLNS


END
GO



/**************** spISeDocIN ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeDocIN') and type = 'P') drop procedure dbo.spISeDocIN 
GO             
CREATE PROCEDURE spISeDocIN
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Empresa				varchar(5),
  @Usuario                              varchar(10),
  @Sucursal                             int,
  @XML2                                 xml,
  @Ruta                                 varchar(max),
  @Texto                                varchar(max),
  @XMLTexto                             varchar(max),
  @XML3                                 varchar(max),
  @XML                                  xml,
  @ReferenciaIS		                varchar(100),
  @Estacion                             int,
  @Nodo                                 varchar(max),
  @Origen                               varchar(max),
  @ErrorRef			        varchar(255)
  BEGIN TRANSACTION
  
  SELECT @Estacion = @@SPID
  SELECT 
    @Empresa = Empresa,
    @Usuario = Usuario,
    @Sucursal = Sucursal ,
    @Origen = Origen           
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud')
    WITH (Empresa varchar(5), Usuario varchar(10), Sucursal int, Origen  varchar(max))
    
    
  DELETE eDocInRutaTemp WHERE Estacion = @Estacion 
  SELECT @XML3  = Solicitud FROM IntelisisService WHERE ID = @ID
  SELECT @XML2 = CONVERT(xml,@XML3)
  IF @Ok IS NULL 
    EXEC speDocInPrefijo @xml3,@Estacion

  IF @Ok IS NULL
    EXEC speDocInRutaNodos @XML2, @Ruta OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT

  IF @Ok IS NULL    
    EXEC spDocInXmlNSListarNodo2 @XML3,@Ruta,@Estacion,@Nodo OUTPUT
    
  SELECT @Nodo = ISNULL(NULLIF(@Nodo,''),@Ruta)
  
  IF @Ok IS NULL
    EXEC speDocInRutaRemoverNodos @XML2, @Nodo, @XML OUTPUT, @Ok OUTPUT, @OkRef  OUTPUT


  SELECT @XMLTexto = CONVERT(varchar(max),@XML)
  IF @Ok IS NULL

     EXEC speDocInRuta @XMLTexto, @Empresa , @Usuario, @Sucursal, @Origen, @Estacion, @Ok  OUTPUT, @OkRef   OUTPUT

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
    BEGIN
      ROLLBACK TRANSACTION
      SELECT @ErrorRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @OkRef = ISNULL(@ErrorRef,'')+' '+ISNULL(@OkRef,'')
      
    END  

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    SELECT @Texto =(SELECT * FROM eDocInRutaTemp WHERE Estacion = @Estacion FOR XML AUTO)
    SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  
    
END
GO












/**************** speDocInCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInCopiar') and type = 'P') drop procedure dbo.speDocInCopiar
GO             
CREATE PROCEDURE speDocInCopiar
		@Estacion		int,
                @eDocInO                varchar(50),
		@eDocInD                varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok			int,
	@OkRef			varchar(255),
	@Ruta                   varchar(50), 
	@OperadorLogico         varchar(1), 
	@Tipo                   varchar(50), 
	@GUID                   varchar(36),
	@NuevoGUID              varchar(36)
	


  SET @Transaccion = 'speDocInCopiar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion
    EXEC sp_msforeachtable "ALTER TABLE ? DISABLE TRIGGER  all"
    IF @Ok IS NULL
      INSERT eDocIn(eDocIn,    Descripcion, Tipo, Documento)
      SELECT        @eDocInD , Descripcion, Tipo, Documento 
        FROM eDocIn 
       WHERE eDocIn = @eDocInO 
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NULL
      INSERT eDocInRuta(eDocIn,   Ruta,   Descripcion, XSD, Modulo, Mov, Afectar, VigenciaDe, VigenciaA, AntesAfectar)
      SELECT            @eDocInD, Ruta, Descripcion, XSD, Modulo, Mov, Afectar, VigenciaDe, VigenciaA, AntesAfectar
        FROM eDocInRuta 
       WHERE eDocIn = @eDocInO   
    IF @@ERROR <> 0 SET @Ok = 1

    IF @Ok IS NULL
    BEGIN    
      DECLARE creDocInRutaD CURSOR FOR
       SELECT Ruta,   OperadorLogico, Tipo, GUID
         FROM eDocInRutaD
        WHERE eDocIn =  @eDocInO
  
      OPEN creDocInRutaD
      FETCH NEXT FROM creDocInRutaD INTO @Ruta, @OperadorLogico, @Tipo, @GUID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        SELECT @NuevoGUID = NEWID()
        INSERT eDocInRutaD(eDocIn,   Ruta,   OperadorLogico,  Tipo,  GUID)
        SELECT             @eDocInD, @Ruta,  @OperadorLogico, @Tipo, @NuevoGUID
        IF @@ERROR <> 0 SET @Ok = 1   
           
        IF @Ok IS NULL
          INSERT eDocInRutaDCondicion(eDocIn,   Ruta,   GUID,       Operando1, Operador, Operando2)
          SELECT                      @eDocInD, @Ruta,  @NuevoGUID, Operando1, Operador, Operando2
            FROM eDocInRutaDCondicion 
           WHERE eDocIn = @eDocInO AND GUID = @GUID
        IF @@ERROR <> 0 SET @Ok = 1          
      

  
        FETCH NEXT FROM creDocInRutaD INTO @Ruta, @OperadorLogico, @Tipo, @GUID
      END
      CLOSE creDocInRutaD
      DEALLOCATE creDocInRutaD  
    END    
 
    IF @Ok IS NULL
      INSERT eDocInRutaTabla(eDocIn,   Ruta,  Tablas, DetalleDe, Nodo, NodoNombre)  
      SELECT                 @eDocInD, Ruta, Tablas, DetalleDe, Nodo, NodoNombre
        FROM eDocInRutaTabla
       WHERE  eDocIn = @eDocInO 
   
    IF @Ok IS NULL
      INSERT eDocInRutaTablaD(eDocIn,   Ruta, Tablas, CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaSt)  
      SELECT                  @eDocInD, Ruta, Tablas, CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaSt
        FROM eDocInRutaTablaD
       WHERE  eDocIn = @eDocInO 
       
       
    EXEC sp_msforeachtable "ALTER TABLE ? ENABLE TRIGGER all"
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso'     
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR  ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO


--speDocInCopiar 1,'CFD_2.0','YYY_2.0'



/**************** speDocInEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInEliminar') and type = 'P') drop procedure dbo.speDocInEliminar
GO             
CREATE PROCEDURE speDocInEliminar
		@Estacion		int,
		@eDocIn			varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok					int,
	@OkRef				varchar(255)

  SET @Transaccion = 'speDocInEliminar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion

  DELETE FROM eDocIn WHERE eDocIn = @eDocIn
  
  IF @Ok IS NULL
    DELETE FROM eDocInRuta WHERE eDocIn = @eDocIn
  IF @@ERROR <> 0 SET @Ok = 1     
  IF @Ok IS NULL
    DELETE FROM eDocInRutaD WHERE eDocIn = @eDocIn
  IF @@ERROR <> 0 SET @Ok = 1   
  IF @Ok IS NULL
    DELETE FROM eDocInRutaTabla WHERE eDocIn = @eDocIn
  IF @@ERROR <> 0 SET @Ok = 1 
  IF @Ok IS NULL
    DELETE FROM eDocInRutaTablaD WHERE eDocIn = @eDocIn
  IF @@ERROR <> 0 SET @Ok = 1 
  IF @Ok IS NULL
    DELETE FROM eDocInRutaDCondicion WHERE eDocIn = @eDocIn 
  
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso' 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR  ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO

--speDocInEliminar 'YYY_2.0'

/**************** fneDocInTipoCampo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInTipoCampo') DROP FUNCTION fneDocInTipoCampo
GO
CREATE FUNCTION fneDocInTipoCampo (@Campo varchar(50))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado varchar(50)

  SELECT @Resultado = CASE WHEN @Campo IN ('numeric', 'int', 'money', 'decimal', 'float', 'bigint', 'smallint', 'tinyint') THEN 'NUMERICO'
                           WHEN @Campo IN ('bit') THEN 'LOGICO'
                           WHEN @Campo IN ('smalldatetime', 'datetime') THEN 'FECHA'
                           WHEN @Campo IN ('char', 'nchar', 'nvarchar', 'binary', 'uniqueidentifier', 'varbinary', 'varchar', 'xml', 'timestamp', 'text') THEN 'TEXTO'
                           ELSE 'TEXTO'
                      END     



  RETURN (@Resultado)
END
GO

--select dbo.fneDocInTipoCampo('numeric')



/**************** fneDocInCamposTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInCamposTabla' AND type = 'TF') DROP FUNCTION fneDocInCamposTabla
GO
CREATE FUNCTION fneDocInCamposTabla (@Tabla varchar(50))
RETURNS @Resultado TABLE (Campo  varchar(100), TipoDatos varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  
  
  INSERT @Resultado(Campo, TipoDatos)
  SELECT           Campo, dbo.fneDocInTipoCampo(TipoDatos)
    FROM SysCampoExt 
   WHERE  Tabla = @Tabla AND EsIdentity = 0 AND EsCalculado = 0 AND AceptaNulos = 0 
     AND Campo NOT IN (SELECT name FROM syscolumns WHERE id = object_id(@Tabla) AND cdefault > 0)
  ORDER BY Orden

  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'Estatus') AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'Estatus' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'Estatus', 'TEXTO'
  
  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'Usuario') AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'Usuario' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'Usuario', 'TEXTO'  
  
  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'FechaEmision')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'FechaEmision' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'FechaEmision', 'FECHA'    

  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'Almacen')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'Almacen' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'Almacen', 'TEXTO'  
  
  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'TipoCambio')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'TipoCambio' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'TipoCambio', 'NUMERICO'    
  
  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'TipoCambio')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'TipoCambio' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'TipoCambio', 'NUMERICO'      

  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'RenglonID')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'RenglonID' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'RenglonID', 'NUMERICO'  
  
  IF NOT EXISTS(SELECT Campo FROM @Resultado WHERE Campo = 'RenglonSub')AND EXISTS(SELECT  Campo   FROM SysCampoExt WHERE Campo = 'RenglonSub' AND Tabla = @Tabla)
  INSERT @Resultado(Campo, TipoDatos)
  SELECT            'RenglonSub', 'NUMERICO'    

  RETURN 
END
GO


--SELECT * FROM dbo.fneDocInCamposTabla('seriElotemov')
/**************** speDocINInsertarRutaTablaD ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.speDocINInsertarRutaTablaD') and type = 'P') drop procedure dbo.speDocINInsertarRutaTablaD 
GO             
CREATE PROCEDURE speDocINInsertarRutaTablaD
             @eDocIn          varchar(50),
             @Ruta            varchar(50),
             @Tablas          varchar(50),
             @Campo           varchar(50),
             @TipoDatos       varchar(50),
             @DetalleDe       varchar(50), 
             @Nodo            varchar(8000), 
             @NodoNombre      varchar(8000),
             @Modulo          varchar(20), 
             @Ok              int OUTPUT,
             @OkRef           varchar(255) OUTPUT


--//WITH ENCRYPTION
AS BEGIN
DECLARE 
  @TablaPrincipal       bit,
  @SubDetalleDe         varchar(50) 
  

  SELECT @TablaPrincipal = CASE WHEN @Tablas = dbo.fnMovTabla(@Modulo) THEN 1 ELSE 0 END
  SELECT @TablaPrincipal = ISNULL(@TablaPrincipal,0)
  
  
  IF @DetalleDe IS NOT NULL
  BEGIN 
    SELECT @SubDetalleDe = @DetalleDe
    WHILE EXISTS(SELECT * FROM  SysCampoExt  WHERE  Tabla = @SubDetalleDe AND Campo = @Campo)
    BEGIN
      SELECT @NodoNombre = NodoNombre, @SubDetalleDe = DetalleDe FROM eDocInRutaTabla WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tablas = @SubDetalleDe 
    
    END
  END 
  
  

  IF @Campo = 'ID'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'ID',     '{ID}',       'ID',       @TipoDatos,    NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)   
  IF @@ERROR <> 0 SET @Ok = 1

  IF @Campo = 'Renglon' AND @TablaPrincipal = 0
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,               ExpresionXML,           CampoTabla, CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, @NodoNombre+'_renglon', @NodoNombre+'_renglon', 'Renglon',  @TipoDatos,    @Nodo,        'Renglon',        'ATRIBUTO',      0,               1,             'Renglon',         2048.0,             2048.0,                0,        NULL)
  IF @@ERROR <> 0 SET @Ok = 1
  
  IF @Campo = 'RenglonID' AND @TablaPrincipal = 0
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,                 ExpresionXML,             CampoTabla,  CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo,   CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, @NodoNombre+'_renglonId', @NodoNombre+'_renglonid', 'RenglonID', @TipoDatos,    @Nodo,        'RenglonID',        'ATRIBUTO',      0,               1,             'RenglonID',       1,                  1,                     0,        NULL)
  IF @@ERROR <> 0 SET @Ok = 1  
  
  IF @Campo = 'RenglonSub' AND @TablaPrincipal = 0
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,     ExpresionXML, CampoTabla,    CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo,   CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'RenglonSub', '0',          'RenglonSub',  @TipoDatos,    @Nodo,        NULL,               NULL,            1,               0,             NULL,               NULL,              NULL,                     0,        NULL)
  IF @@ERROR <> 0 SET @Ok = 1  

  IF @Campo = 'Sucursal'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,   ExpresionXML, CampoTabla, CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Sucursal', '{Sucursal}', 'Sucursal', @TipoDatos,    NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)   
  IF @@ERROR <> 0 SET @Ok = 1   
  
  IF @Campo = 'SucursalOrigen'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,         ExpresionXML, CampoTabla,       CampoXMLTipo,  CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'SucursalOrigen', '{Sucursal}', 'SucursalOrigen', @TipoDatos,    NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)   
  IF @@ERROR <> 0 SET @Ok = 1   
  
  IF @Campo = 'Mov'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,     ExpresionXML,   CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Movimiento', '{Movimiento}', 'Mov',      @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
    
  IF @Campo = 'Modulo'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,     ExpresionXML,   CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Modulo', '{Modulo}', 'Modulo',      @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
        
    
  IF @Campo = 'Moneda'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML, ExpresionXML,   CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Moneda', '{Moneda}',     'Moneda',   @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
  
  IF @Campo = 'Usuario'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,  ExpresionXML,   CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Usuario', '{Usuario}',    'Usuario',  @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
 
  IF @Campo = 'Estatus'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,   ExpresionXML,          CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Estatus', '{EstatusSinAfectar}',  'Estatus',  @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)      
    
  IF @Campo = 'FechaEmision'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,       ExpresionXML, CampoTabla,     CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'FechaEmision', '{Hoy}',      'FechaEmision', @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
    
  IF @Campo = 'Almacen'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,  ExpresionXML,   CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'Almacen', '{Almacen}',    'Almacen',  @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
    
  IF @Campo = 'TipoCambio'
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,     ExpresionXML,   CampoTabla,    CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'TipoCambio', '{TipoCambio}', 'TipoCambio',  @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
    
  IF @Campo = 'RenglonTipo' AND @TablaPrincipal = 0
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML,      ExpresionXML, CampoTabla,     CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    VALUES (                 @eDocIn,  @Ruta, @Tablas, 'RenglonTipo', '''N''',      'RenglonTipo',  @TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL)  
        
 IF @Campo NOT IN('ID','Renglon', 'RenglonID', 'RenglonSub', 'Sucursal', 'SucursalOrigen', 'Mov', 'Moneda', 'Usuario', 'Estatus', 'FechaEmision', 'Almacen', 'TipoCambio', 'RenglonTipo', 'Modulo')
 INSERT   eDocInRutaTablaD(eDocIn,   Ruta,  Tablas,  CampoTabla) 
 VALUES (                  @eDocIn,  @Ruta, @Tablas, @Campo)

END
GO 
    
    
    
/**************** speDocINRutaTablaD ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.speDocINRutaTablaD') and type = 'P') drop procedure dbo.speDocINRutaTablaD 
GO             
CREATE PROCEDURE speDocINRutaTablaD
             @eDocIn          varchar(50),
             @Ruta            varchar(50),
             @Tablas          varchar(50),
             @Ok              int = NULL,
             @OkRef           varchar(255)= NULL


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
   @Campo      varchar(50),
   @TipoDatos  varchar(50),
   @DetalleDe  varchar(50), 
   @Nodo       varchar(8000), 
   @NodoNombre varchar(8000),
   @Modulo     varchar(20) 

  
  DECLARE @Tabla table(Campo  varchar(50),TipoDatos  varchar(50))
  

  SELECT  @DetalleDe = t.DetalleDe, @Nodo =  t.Nodo, @NodoNombre = t.NodoNombre, @Modulo = r.Modulo
    FROM eDocInRutaTabla t JOIN eDocInRuta r ON t.eDocIn = r.eDocIn AND t.Ruta = r.Ruta
   WHERE t.eDocIn =  @eDocIn AND t.Ruta = @Ruta AND t.Tablas = @Tablas
   
  IF NOT EXISTS(SELECT * FROM eDocInRutaTablaD WHERE eDocIn =  @eDocIn AND Ruta = @Ruta AND Tablas = @Tablas)
  BEGIN  
    INSERT @Tabla (Campo, TipoDatos)
    SELECT * FROM dbo.fneDocInCamposTabla(@Tablas)
    IF @@ERROR <> 0 SET @Ok = 1
    
    IF @Ok IS NULL
    BEGIN    
      DECLARE crTablaD CURSOR FOR
       SELECT Campo, TipoDatos
         FROM @Tabla
  
      OPEN crTablaD
      FETCH NEXT FROM crTablaD INTO @Campo, @TipoDatos
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
      
        EXEC speDocINInsertarRutaTablaD    @eDocIn, @Ruta, @Tablas, @Campo, @TipoDatos,@DetalleDe, @Nodo, @NodoNombre, @Modulo, @Ok OUTPUT, @OkRef OUTPUT 
  
        FETCH NEXT FROM crTablaD INTO @Campo, @TipoDatos
      END
      CLOSE crTablaD
      DEALLOCATE crTablaD  
    END 
  END  
  IF @Ok IS NULL
    EXEC speDocINInsertarRutaTablaDOmision @eDocIn, @Ruta, @Tablas,  @Modulo, @Ok OUTPUT, @OkRef OUTPUT 
    
END

GO

/**************** speDocInListarNodosAtributos  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarNodosAtributos') and type = 'P') drop procedure dbo.speDocInListarNodosAtributos
GO             
CREATE PROCEDURE speDocInListarNodosAtributos
		@Estacion		int,
		@eDocIn			varchar(50),
		@Path                   varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Xml        varchar(max),
    @Xml2       xml
    
  SET ANSI_NULLS ON 
  SET ANSI_WARNINGS ON 
  SET QUOTED_IDENTIFIER ON  
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON    
  
  SELECT @Xml = Documento FROM eDocIn WHERE eDocIn = @eDocIn
  SELECT @Xml2 = CONVERT(varchar(max),@Xml)
  
  DELETE eDocInNodoAtributoTemp WHERE Estacion = @Estacion
  
  EXEC spDocInXmlNSListarNodo @xml ,@Estacion
  
  INSERT eDocInNodoAtributoTemp(Estacion,  Nodo, NodoNombre, Ruta, CampoTipoxml, Atributo)
  SELECT                        @Estacion, Nodo, NodoNombre, Nodo, 'NODO',       NULL
    FROM eDocInNodoTemp WHERE Estacion = @Estacion AND Nodo = @Path
    

  EXEC speDocInListaCompletaAtributos @Estacion, @XML2
  INSERT eDocInNodoAtributoTemp(Estacion,  Nodo,         NodoNombre, Ruta,         CampoTipoxml, Atributo)
  SELECT                        @Estacion, AtributoRuta, Campo,      AtributoRuta, 'ATRIBUTO',   AtributoNombre
    FROM eDocInAtributoTemp WHERE Estacion = @Estacion AND AtributoRuta = @Path
    
  INSERT eDocInNodoAtributoTemp(Estacion,  Nodo, NodoNombre, Ruta,   CampoTipoxml, Atributo)
  SELECT                        @Estacion, '_______', '_______','_______', '_______',   '_______'    
  
  
  
  INSERT eDocInNodoAtributoTemp(Estacion,  Nodo, NodoNombre, Ruta,                                CampoTipoxml, Atributo)
  SELECT                        @Estacion, Nodo, NodoNombre, dbo.fneDocInRutaRelativa(Nodo,@Path), 'NODO',   NULL
    FROM eDocInNodoTemp WHERE Estacion = @Estacion AND Nodo <> @Path

  EXEC speDocInListaCompletaAtributos @Estacion, @XML2
  INSERT eDocInNodoAtributoTemp(Estacion,  Nodo,         NodoNombre, Ruta,                                          CampoTipoxml, Atributo)
  SELECT                        @Estacion, AtributoRuta, Campo,       dbo.fneDocInRutaRelativa(AtributoRuta,@Path), 'ATRIBUTO',   AtributoNombre
    FROM eDocInAtributoTemp WHERE Estacion = @Estacion  AND AtributoRuta <> @Path
    
  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF   
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF  

END
GO

--speDocInListarNodosAtributos 1, 'CFD_2.2', '/Comprobante/'

--EXEC speDocInListarNodosAtributos 1, 'CFD_2.0' ,'/Comprobante/Conceptos/Concepto/'
--select * from eDocInNodoAtributoTemp ORDER BY ID

/**************** speDocInInsertarRutaTabla  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInInsertarRutaTabla') and type = 'P') drop procedure dbo.speDocInInsertarRutaTabla
GO             
CREATE PROCEDURE speDocInInsertarRutaTabla
		@eDocIn			varchar(50),
		@Ruta			varchar(50),
		@Modulo			varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  IF NOT EXISTS(SELECT * FROM eDocInRutaTabla WHERE eDocIn = @eDocIn AND Ruta = @Ruta)
  BEGIN
    INSERT eDocInRutaTabla(eDocIn,  Ruta,  Tablas, DetalleDe)
    SELECT @eDocIn, @Ruta, Tablas,  DetalleDe
      FROM eDocInModuloOmision 
     WHERE Modulo = @Modulo
    ORDER BY Orden  
  END

END
GO



/**************** speDocInInsertarRutaD ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.speDocInInsertarRutaD') and type = 'P') drop procedure dbo.speDocInInsertarRutaD 
GO             
CREATE PROCEDURE speDocInInsertarRutaD
             @eDocIn          varchar(50),
             @Ruta            varchar(50),
             @Tipo            varchar(50),
             @Operador        varchar(1)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

    INSERT eDocInRutaD(eDocIn,  Ruta,  OperadorLogico, Tipo)
    SELECT             @eDocIn, @Ruta, @Operador, @Tipo
   
END
GO







/**************** speDocInListarNodosAtributos2  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInListarNodosAtributos2') and type = 'P') drop procedure dbo.speDocInListarNodosAtributos2
GO             
CREATE PROCEDURE speDocInListarNodosAtributos2
		@Estacion		int,
		@eDocIn			varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Xml        varchar(max),
    @Xml2       xml
    
  SET ANSI_NULLS ON 
  SET ANSI_WARNINGS ON 
  SET QUOTED_IDENTIFIER ON  
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON    
  
  SELECT @Xml = Documento FROM eDocIn WHERE eDocIn = @eDocIn
  SELECT @Xml2 = CONVERT(varchar(max),@Xml)
  
  DELETE eDocInNodoAtributoTemp2 WHERE Estacion = @Estacion
  
  EXEC spDocInXmlNSListarNodo @xml ,@Estacion
  
  INSERT eDocInNodoAtributoTemp2(Estacion,  Nodo, NodoNombre, Ruta, CampoTipoxml, Atributo)
  SELECT                        @Estacion, Nodo, NodoNombre, Nodo, 'NODO',       NULL
    FROM eDocInNodoTemp WHERE Estacion = @Estacion 
    

  EXEC speDocInListaCompletaAtributos @Estacion, @XML2
  INSERT eDocInNodoAtributoTemp2(Estacion,  Nodo,         NodoNombre, Ruta,         CampoTipoxml, Atributo)
  SELECT                        @Estacion, AtributoRuta, Campo,      AtributoRuta+'@'+AtributoNombre, 'ATRIBUTO',   AtributoNombre
    FROM eDocInAtributoTemp WHERE Estacion = @Estacion 
    

    
  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF   
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF  

END
GO


--EXEC speDocInListarNodosAtributos2 1, 'CFD_2.0' 
--select * from eDocInNodoAtributoTemp2 ORDER BY ID

/******************************* speDocInGenerarInsercionesPlantilla *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInGenerarInsercionesPlantilla') and type = 'P') drop procedure dbo.speDocInGenerarInsercionesPlantilla
GO             
CREATE PROCEDURE speDocInGenerarInsercionesPlantilla
		@eDocIn		varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @InsercioneDoc		varchar(max)
  
  DECLARE @Insercion TABLE
          (
          RID			int identity(1,1),
          Datos			varchar(max)
          )

  INSERT @Insercion (Datos)
  SELECT '/********************************* ' + ISNULL(@eDocIn,'') + '-eDocIn' + ' *********************************/'
  
  INSERT @Insercion (Datos) 
  SELECT ' EXEC sp_msforeachtable "ALTER TABLE ? DISABLE TRIGGER  all" '   

  SELECT @InsercioneDoc = 'IF NOT EXISTS(SELECT * FROM eDocIn WHERE eDocIn = ' + dbo.fneDocComillas(eDocIn) + ') ' + 
         'INSERT INTO eDocIn (eDocIn, Descripcion, Tipo, Documento) ' +
         'SELECT ' + dbo.fneDocComillas(eDocIn) + ', ' + dbo.fneDocComillas(Descripcion)+ ', ' + dbo.fneDocComillas(Tipo) + ',' +  dbo.fneDocComillas(RTRIM(Documento)) 
    FROM eDocIn 
   WHERE eDocIn = @eDocIn

   
  INSERT @Insercion (Datos)       
  SELECT RTRIM(LTRIM(REPLACE(REPLACE(@InsercioneDoc,CHAR(10),''),CHAR(13),'')))
  
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)

  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@eDocIn,'') + '-eDocInRuta*/' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocInRuta WHERE  eDocIn = ' + dbo.fneDocComillas(@eDocIn)+' )  BEGIN Print 1 '
  
  INSERT @Insercion (Datos)
  SELECT 'INSERT INTO eDocInRuta (eDocIn, Ruta, Descripcion, XSD, Modulo, Mov, Afectar, VigenciaDe, VigenciaA, AntesAfectar)
          SELECT ' + dbo.fneDocComillas(eDocIn) + ', ' + dbo.fneDocComillas(Ruta) + ', '+ dbo.fneDocComillas(Descripcion) + ','+ CONVERT(varchar(max),ISNULL(XSD,0)) + ','  + dbo.fneDocComillas(Modulo) + ',' + dbo.fneDocComillas(Mov) + ',' + CONVERT(varchar,ISNULL(Afectar,0)) + ',' + dbo.fneDocComillas(CONVERT(varchar,VigenciaDe)) + ',' + dbo.fneDocComillas(CONVERT(varchar,VigenciaA))+','+ dbo.fneDocComillas(CONVERT(varchar,AntesAfectar))
    FROM eDocInRuta
   WHERE eDocIn = @eDocIn
  INSERT @Insercion (Datos)
  SELECT 'END'   

  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)

  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@eDocIn,'') + '-eDocInRutaD*/' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocInRutaD WHERE  eDocIn = ' + dbo.fneDocComillas(@eDocIn)+') BEGIN  Print 1 '
  
  INSERT @Insercion (Datos)
  SELECT' INSERT eDocInRutaD (eDocIn, Ruta, OperadorLogico, Tipo) 
          SELECT ' + dbo.fneDocComillas(eDocIn) + ', ' + dbo.fneDocComillas(Ruta) + ','+ dbo.fneDocComillas(OperadorLogico) +','+ dbo.fneDocComillas(Tipo)
    FROM eDocInRutaD
   WHERE eDocIn = @eDocIn
  INSERT @Insercion (Datos)
  SELECT 'END'  
   
   
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)
  
  
  
  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@eDocIn,'') + '-eDocInRutaDCondicion*/' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocInRutaDCondicion WHERE  eDocIn = ' + dbo.fneDocComillas(@eDocIn) + ')  BEGIN  Print 1 '
  INSERT @Insercion (Datos)
  SELECT 'INSERT eDocInRutaDCondicion (eDocIn, Ruta, GUID, Operando1, Operador, Operando2 ) 
          SELECT ' + dbo.fneDocComillas(c.eDocIn) + ', ' + dbo.fneDocComillas(c.Ruta) + ','+'(SELECT GUID FROM eDocInRutaD WHERE eDocIn ='+ dbo.fneDocComillas(@eDocIn) +' AND Ruta = '+dbo.fneDocComillas(c.Ruta)+' AND OperadorLogico = '+CHAR(39)+'Y'+CHAR(39)+'),'+ dbo.fneDocComillas(Operando1)+ ','+ dbo.fneDocComillas(Operador) + ','+ dbo.fneDocComillas(Operando2) 
    FROM eDocInRutaDCondicion c JOIN eDocInRutaD d ON c.eDocIn = d.eDocIn AND c.Ruta = d.Ruta AND c.GUID = d.GUID
   WHERE c.eDocIn = @eDocIn AND d.OperadorLogico = 'Y'
  UNION ALL 
  SELECT 'INSERT eDocInRutaDCondicion (eDocIn, Ruta, GUID, Operando1, Operador, Operando2 ) 
          SELECT ' + dbo.fneDocComillas(c.eDocIn) + ', ' + dbo.fneDocComillas(c.Ruta) + ','+'(SELECT GUID FROM eDocInRutaD WHERE eDocIn ='+dbo.fneDocComillas(@eDocIn)+' AND Ruta = '+dbo.fneDocComillas(c.Ruta)+' AND OperadorLogico = '+CHAR(39)+'O'+CHAR(39)+'),'+ dbo.fneDocComillas(Operando1)+ ','+ dbo.fneDocComillas(Operador) + ','+ dbo.fneDocComillas(Operando2)
    FROM eDocInRutaDCondicion c JOIN eDocInRutaD d ON c.eDocIn = d.eDocIn AND c.Ruta = d.Ruta AND c.GUID = d.GUID
   WHERE c.eDocIn = @eDocIn AND d.OperadorLogico = 'O'  
   
  INSERT @Insercion (Datos)
  SELECT 'END'   
     
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)
  
  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@eDocIn,'') + '-eDocInRutaTabla */' 

  INSERT @Insercion (Datos)
  SELECT 'IF NOT EXISTS(SELECT * FROM eDocInRutaTabla WHERE  eDocIn = ' + dbo.fneDocComillas(@eDocIn)+') BEGIN  Print 1 '
  INSERT @Insercion (Datos)
  SELECT 'INSERT eDocInRutaTabla (eDocIn, Ruta, Tablas, DetalleDe, Nodo, NodoNombre) 
          SELECT ' + dbo.fneDocComillas(eDocIn) + ', ' + dbo.fneDocComillas(Ruta) + ','+ dbo.fneDocComillas(Tablas) + ','+ dbo.fneDocComillas(DetalleDe) + ','+ dbo.fneDocComillas(Nodo) + ','+ dbo.fneDocComillas(NodoNombre)
    FROM eDocInRutaTabla
   WHERE eDocIn = @eDocIn
  
  INSERT @Insercion (Datos)
  SELECT 'END'  
   
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)  
  
  INSERT @Insercion (Datos)
  SELECT '/* ' + ISNULL(@eDocIn,'') + '-eDocInRutaTablaD */' 

  INSERT @Insercion (Datos)
  SELECT DISTINCT 'IF NOT EXISTS(SELECT * FROM eDocInRutaTablaD WHERE  eDocIn = ' + dbo.fneDocComillas(@eDocIn) +')  BEGIN  Print 1 '
  INSERT @Insercion (Datos)




  SELECT 'INSERT eDocInRutaTablaD (eDocIn, Ruta, Tablas, CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta,CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaSt) 
          SELECT ' + dbo.fneDocComillas(eDocIn) + ', ' + dbo.fneDocComillas(Ruta) + ','+ dbo.fneDocComillas(Tablas) + ','+ dbo.fneDocComillas(CampoXML) + ','+ dbo.fneDocComillas(ExpresionXML) + ','+ dbo.fneDocComillas(CampoTabla) + ','+ dbo.fneDocComillas(CampoXMLTipo) + ','+ dbo.fneDocComillas(CampoXMLRuta)+', '+ dbo.fneDocComillas(CampoXMLAtributo) + ', ' + dbo.fneDocComillas(CampoXMLTipoXML)+', ' + dbo.fneDocComillas(EsIndependiente)+', ' + dbo.fneDocComillas(EsConsecutivo)+', ' + dbo.fneDocComillas(ConsecutivoNombre)+', ' + dbo.fneDocComillas(ConsecutivoInicial)+', ' + dbo.fneDocComillas(ConsecutivoIncremento)+', ' + dbo.fneDocComillas(Traducir)+', ' + dbo.fneDocComillas(TablaSt)
    FROM eDocInRutaTablaD
   WHERE eDocIn = @eDocIn
  INSERT @Insercion (Datos)
  SELECT 'END '
  INSERT @Insercion (Datos)
  SELECT 'GO'   
  INSERT @Insercion (Datos) 
  SELECT 'EXEC sp_msforeachtable "ALTER TABLE ? ENABLE TRIGGER all" ' 
   
  INSERT @Insercion (Datos)
  SELECT CHAR(71) + CHAR(79)

  INSERT @Insercion (Datos)
  SELECT CHAR(32)   
         
  SELECT * FROM @Insercion ORDER BY RID
END
GO
--exec speDocInGenerarInsercionesPlantilla 'CFD_2.0'

/**************** speDocInBorrarHerrTablaSt  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInBorrarHerrTablaSt') and type = 'P') drop procedure dbo.speDocInBorrarHerrTablaSt
GO             
CREATE PROCEDURE speDocInBorrarHerrTablaSt
                        @Estacion         int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DELETE eDocInHerrTablaST WHERE Estacion = @Estacion
  DELETE eDocInHerrTablaSTD WHERE Estacion = @Estacion

END
GO




/**************** speDocInGenerarInsertTablaSt  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInGenerarInsertTablaSt') and type = 'P') drop procedure dbo.speDocInGenerarInsertTablaSt
GO             
CREATE PROCEDURE speDocInGenerarInsertTablaSt
                        @Estacion         int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @TablaSt        varchar(50),
    @Tablas         varchar(50),
    @CampoNombre    varchar(50),
    @CampoValor     varchar(50),
    @Ok             int,
    @OkRef          varchar(255),
    @SQL            nvarchar(max),
    @Operando1      varchar(8000),
    @Operando2      varchar(8000),
    @Operador       varchar(50)  

   SELECT @TablaSt = TablaSt, @Tablas = Tablas, @CampoNombre = CampoNombre, @CampoValor = CampoValor
     FROM eDocInHerrTablaST
    WHERE Estacion = @Estacion

   SELECT @SQL = N'IF NOT EXISTS (SELECT * FROM TablaSt WHERE TablaSt = '+CHAR(39)+@TablaSt+CHAR(39)+')
                   INSERT TablaSt(TablaSt)
                   SELECT  '+CHAR(39)+@TablaSt+CHAR(39)+ N'
                   IF @@ERROR <> 0 SET @Ok = 1
                   IF NOT EXISTS (SELECT * FROM TablaStD WHERE TablaSt = '+CHAR(39)+@TablaSt+CHAR(39)+N') AND @Ok IS NULL
                   INSERT TablaStD(TablaSt, Nombre, Valor)
                   SELECT  '+CHAR(39)+@TablaSt+CHAR(39)+N', '+@CampoNombre+N','+@CampoValor+N'
                     FROM  '+@Tablas +N'   WHERE '+@CampoNombre+N' IS NOT NULL  AND  '+@CampoValor+N' IS NOT NULL AND  '
                   
  IF EXISTS (SELECT * FROM eDocInHerrTablaSTD WHERE Estacion = @Estacion)
  BEGIN     

    DECLARE crTablaD CURSOR FOR
     SELECT Operando1, Operador, Operando2
       FROM eDocInHerrTablaSTD
      WHERE Estacion = @Estacion
      ORDER BY ID
  
    OPEN crTablaD
    FETCH NEXT FROM crTablaD INTO @Operando1, @Operador, @Operando2
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
    
       SELECT @SQL = @SQL +@Operando1+' '+ CASE WHEN @Operador = 'IGUAL QUE' THEN '='
                           WHEN @Operador = 'DIFERENTE QUE' THEN '<>'
                           WHEN @Operador = 'MAYOR QUE' THEN '>'
                           WHEN @Operador = 'MENOR QUE' THEN '<'
                           WHEN @Operador = 'MAYOR O IGUAL QUE' THEN '>='
                           WHEN @Operador = 'MENOR O IGUAL QUE' THEN '<='
                      END +' '+CHAR(39)+@Operando2+CHAR(39)+ '  AND  '
  
      FETCH NEXT FROM crTablaD INTO @Operando1, @Operador, @Operando2
    END
    CLOSE crTablaD
    DEALLOCATE crTablaD                     
  END                 
  SELECT @SQL = @SQL + N' 1 = 1' 
  
  BEGIN TRY
    EXEC sp_executesql @SQL, N'@Ok int  OUTPUT', @Ok= @Ok OUTPUT  
  END TRY   
  BEGIN CATCH
    SELECT @Ok = @@ERROR,  @OkRef = ERROR_MESSAGE() 
    IF XACT_STATE() = -1   
    BEGIN
      ROLLBACK TRAN
      SET @OkRef = ' Error  ' + CONVERT(varchar,@Ok) + @OkRef
      RAISERROR(@OkRef,20,1) WITH LOG 
    END
  END CATCH                      
 
 IF @Ok IS NULL 
   SELECT 'SE GENERO LA TABLA '+@TablaSt
 ELSE 
   SELECT @OkRef
 
END
GO
--speDocInGenerarInsertTablaSt 1
/**************** speDocInISDetalle  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInISDetalle') and type = 'P') drop procedure dbo.speDocInISDetalle
GO             
CREATE PROCEDURE speDocInISDetalle
                        @Estacion         int,
                        @ID               int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @XML          xml,
  @iSolicitud   int
  
  DELETE eDocInISDetalleTemp WHERE Estacion = @Estacion
  
  SELECT @XML = CONVERT(xml,Resultado) FROM IntelisisService WHERE ID = @ID
  
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @XML
  INSERT eDocInISDetalleTemp (RID, eDocIn, Ruta, Modulo, ID, Mov, Estatus, Estacion, Origen)
  SELECT 	                @ID, eDocIn, Ruta, Modulo, ID, Mov, Estatus, @Estacion, Origen
    FROM OPENXML (@iSolicitud, '/Intelisis/Resultado/eDocInRutaTemp',1)  
    WITH (eDocIn varchar(50), Ruta varchar(50),Modulo varchar(5),ID int,Mov varchar(50),Estatus varchar(20), Origen varchar(255))
  EXEC sp_xml_removedocument @iSolicitud
  


END
GO

/**************** speDocInArchivoTemp  ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInArchivoTemp') and type = 'P') drop procedure dbo.speDocInArchivoTemp
GO             
CREATE PROCEDURE speDocInArchivoTemp
                        @Estacion         int,
                        @ID               int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @XML          xml,
  @XML2         varchar(max),
  @Documento    xml,
  @Ruta         varchar(255),
  @Nodo         varchar(255)
  
  DELETE eDocInArchivoTemp WHERE Estacion = @Estacion
  
  
  SELECT @XML2 = Solicitud FROM IntelisisService WHERE ID = @ID
  SELECT @XML = CONVERT(xml,@XML2) 
  
  SET ANSI_NULLS ON   
  SET ANSI_WARNINGS ON    
  SET QUOTED_IDENTIFIER ON
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON
  EXEC speDocInRutaNodos @XML, @Ruta OUTPUT
  
  EXEC spDocInXmlNSListarNodo2 @XML2, @Ruta,@Estacion,@Nodo OUTPUT
    
  SELECT @Nodo = ISNULL(NULLIF(@Nodo,''),@Ruta)
 
  EXEC speDocInRutaRemoverNodos @XML2, @Nodo, @Documento OUTPUT
  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF   
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF   
  IF @ID IS NOT NULL AND @Documento IS NOT  NULL
  INSERT eDocInArchivoTemp (RID, Estacion,   Documento)
  SELECT                    @ID, @Estacion, CONVERT(varchar(max),@Documento)

  

END
GO


--speDocInArchivoTemp 1,191
--select * from eDocInArchivoTemp

/******************************* speDocInReprocesarIS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInReprocesarIS') and type = 'P') drop procedure dbo.speDocInReprocesarIS
GO             
CREATE PROCEDURE speDocInReprocesarIS
		@ID             int,
		@Usuario        varchar(10)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @xml         varchar(max),
  @xml2        xml,
  @Resultado   varchar(max),
  @Nombre      varchar(255),
  @Estacion    int,
  @Origen2     varchar(255),
  @Destino2    varchar(255),
  @Contrasena  varchar(32),
  @Ok          int,
  @OkRef       varchar(255)
  
  
 SELECT @Contrasena = Contrasena 
   FROM Usuario
  WHERE Usuario = @Usuario
    
  SELECT @xml = Solicitud, @Nombre = eDocInArchivo FROM IntelisisService WHERE ID = @ID
  SELECT @xml2 = CONVERT(xml,@xml)
  SET ANSI_NULLS ON   
  SET ANSI_WARNINGS ON    
  SET QUOTED_IDENTIFIER ON
  SET CONCAT_NULL_YIELDS_NULL ON
  SET ANSI_PADDING ON  
   
  EXEC spIntelisisService @Usuario,@Contrasena,@xml,@Resultado,@Ok OUTPUT,@OkRef OUTPUT,1,0,@ID OUTPUT

  IF @ID IS NOT NULL 
  UPDATE IntelisisService SET eDocInArchivo = @Nombre
   WHERE ID = @ID

  SET ANSI_NULLS OFF 
  SET ANSI_WARNINGS OFF 
  SET QUOTED_IDENTIFIER OFF   
  SET CONCAT_NULL_YIELDS_NULL OFF
  SET ANSI_PADDING OFF     

END
GO



/******************************* speDocInRutaDEliminar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaDEliminar') and type = 'P') drop procedure dbo.speDocInRutaDEliminar
GO             
CREATE PROCEDURE speDocInRutaDEliminar
		@GUID      varchar(36)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DELETE eDocInRutaD WHERE GUID = @GUID
  DELETE eDocInRutaDCondicion WHERE GUID = @GUID
  

END
GO

/******************************* speDocInRutaEliminar *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaEliminar') and type = 'P') drop procedure dbo.speDocInRutaEliminar
GO             
CREATE PROCEDURE speDocInRutaEliminar
		@eDocIn     varchar(50),
		@Ruta       varchar(50)


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DELETE eDocInRuta WHERE eDocIn = @eDocIn AND Ruta = @Ruta
  DELETE eDocInRutaD WHERE eDocIn = @eDocIn AND Ruta = @Ruta
  DELETE eDocInRutaDCondicion WHERE eDocIn = @eDocIn AND Ruta = @Ruta
  DELETE eDocInRutaTabla WHERE eDocIn = @eDocIn AND Ruta = @Ruta
  DELETE eDocInRutaTabla WHERE eDocIn = @eDocIn AND Ruta = @Ruta
  

END
GO


/**************** speDocInRutaCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocInRutaCopiar') and type = 'P') drop procedure dbo.speDocInRutaCopiar
GO             
CREATE PROCEDURE speDocInRutaCopiar
		@Estacion		int,
                @eDocIn                 varchar(50),
                @RutaO                  varchar(50),
		@RutaD                  varchar(50)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok			int,
	@OkRef			varchar(255),
	@Ruta                   varchar(50), 
	@OperadorLogico         varchar(1), 
	@Tipo                   varchar(50), 
	@GUID                   varchar(36),
	@NuevoGUID              varchar(36)
	


  SET @Transaccion = 'speDocInRutaCopiar' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))

  BEGIN TRANSACTION @Transaccion
    EXEC sp_msforeachtable "ALTER TABLE ? DISABLE TRIGGER  all"
    
    IF @Ok IS NULL
      INSERT eDocInRuta(eDocIn,   Ruta,   Descripcion, XSD, Modulo, Mov, Afectar, VigenciaDe, VigenciaA, AntesAfectar)
      SELECT            @eDocIn,  @RutaD, Descripcion, XSD, Modulo, Mov, Afectar, VigenciaDe, VigenciaA, AntesAfectar
        FROM eDocInRuta 
       WHERE eDocIn = @eDocIn AND Ruta = @RutaO   
    IF @@ERROR <> 0 SET @Ok = 1

    IF @Ok IS NULL
    BEGIN    
      DECLARE creDocInRutaD CURSOR FOR
       SELECT Ruta,   OperadorLogico, Tipo, GUID
         FROM eDocInRutaD
        WHERE eDocIn = @eDocIn AND Ruta = @RutaO   
  
      OPEN creDocInRutaD
      FETCH NEXT FROM creDocInRutaD INTO @Ruta, @OperadorLogico, @Tipo, @GUID
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        SELECT @NuevoGUID = NEWID()
        INSERT eDocInRutaD(eDocIn,   Ruta,   OperadorLogico,  Tipo,  GUID)
        SELECT             @eDocIn,  @RutaD, @OperadorLogico, @Tipo, @NuevoGUID
        IF @@ERROR <> 0 SET @Ok = 1   
           
        IF @Ok IS NULL
          INSERT eDocInRutaDCondicion(eDocIn,   Ruta,   GUID,       Operando1, Operador, Operando2)
          SELECT                      @eDocIn,  @RutaD,  @NuevoGUID, Operando1, Operador, Operando2
            FROM eDocInRutaDCondicion 
           WHERE eDocIn = @eDocIn AND GUID = @GUID
        IF @@ERROR <> 0 SET @Ok = 1          
      

  
        FETCH NEXT FROM creDocInRutaD INTO @Ruta, @OperadorLogico, @Tipo, @GUID
      END
      CLOSE creDocInRutaD
      DEALLOCATE creDocInRutaD  
    END    
 
    IF @Ok IS NULL
      INSERT eDocInRutaTabla(eDocIn,   Ruta,  Tablas, DetalleDe, Nodo, NodoNombre)  
      SELECT                 @eDocIn, @RutaD, Tablas, DetalleDe, Nodo, NodoNombre
        FROM eDocInRutaTabla
       WHERE  eDocIn = @eDocIn AND Ruta = @RutaO  
   
    IF @Ok IS NULL
      INSERT eDocInRutaTablaD(eDocIn,   Ruta,   Tablas, CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaSt)  
      SELECT                  @eDocIn,  @RutaD, Tablas, CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaSt
        FROM eDocInRutaTablaD
       WHERE  eDocIn = @eDocIn AND Ruta = @RutaO  
  EXEC sp_msforeachtable "ALTER TABLE ? ENABLE TRIGGER all"
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
    SELECT 'Proceso Exitoso'     
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR  ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO


/**************** speDocINCrearJobs ****************/
if exists (select * from sysobjects where id = object_id('dbo.speDocINCrearJobs') and type = 'P') drop procedure dbo.speDocINCrearJobs
GO             
CREATE PROCEDURE speDocINCrearJobs
  @Nombre   varchar(100),
  @BaseDatos        varchar(30),
  @UsuarioI         varchar(30)
 
 
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID        binary (16),
  @ReturnCode       int,
  @Usuario          varchar(30),
  @Contrasena       varchar(30),
  @Activo           bit,
  @Trabajo          char(20),
  @Cadena           varchar(100),
  @Servidor         varchar(30),   
  @HoraInicial      int,
  @HoraFinal        int,
  @Frecuencia       tinyint,
  @Valor            tinyint,
  @Recurrencia      tinyint, 
  @FrecuenciaD      tinyint,
  @ValorD           tinyint,
  @Domingo          bit,
  @Lunes            bit,
  @Martes           bit,
  @Miercoles        bit,
  @Jueves           bit,
  @Viernes          bit,
  @Sabado           bit,
  @Valor2           tinyint,
  @Tipo             tinyint,
  @Dia              tinyint,
  @Fecha2           int,
  @Estatus          bit,
  @spSucursal       int,
  @spEmpresa        varchar(5),
  @spUsuario        varchar(30),
  @spOrigen         varchar(255),
  @spDestino        varchar(255),
  @spExtencion      varchar(255),
  @spFecha          datetime,
  @NombreOriginal   varchar(100)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
 
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Notificacion '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM eDocInTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
 
       DECLARE crTrabajo SCROLL CURSOR FOR
       SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Dia' THEN 8 WHEN 'Dia de la semana' THEN 9 WHEN 'Dia del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2)), spSucursal, spEmpresa, spUsuario, GETDATE(), spOrigen, spDestino
         FROM eDocInTrabajo
       WHERE Trabajo = @NombreOriginal
      
       IF ISNULL(@Contrasena,'') = ''
             SELECT @Contrasena = 'NULL'
 
       OPEN crTrabajo
 
       FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @spOrigen, @spDestino
 
       WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
       BEGIN
--select @Frecuencia = 32
         SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
       
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
       
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
       
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
        
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
       
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
       
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
     
        SELECT @Valor = @Valor2
      END
 
      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
        SET @spExtencion = '.xml'
 
        SET @cadena     = 'EXEC speDocInInsertarIS ' + '''' + RTRIM(@spOrigen) + '''' + ', ' + '''' + RTRIM(@spDestino) + '''' + ', ' + '''' + RTRIM(@spExtencion) + '''' + ', ' +    '''' + RTRIM(@spEmpresa) + '''' + ', ' + '''' + RTRIM(@spUsuario) + '''' + ', ' + '''' + RTRIM(@spSucursal) + '''' 
 
--       select @Cadena
 
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @OUTPUT_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
 
         UPDATE eDocInTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
        
         FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @spOrigen, @spDestino
       END
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
 
  CLOSE crTrabajo
  DEALLOCATE crTrabajo
--select @ReturnCode = 1
  END 
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
GO




/**************** spGastoRecalcularDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGastoRecalcularDetalle') and sysstat & 0xf = 4) drop procedure dbo.spGastoRecalcularDetalle
GO             
CREATE PROCEDURE spGastoRecalcularDetalle
                  @ID      int,
                  @Modulo  varchar(5),
                  @Ok      int OUTPUT,
                  @OkRef   varchar(255) OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Mov                  varchar(20),
  @Fecha                datetime,
  @Empresa              varchar(5),
  @Sucursal             int,
  @Acreedor             varchar(10),
  @Concepto             varchar(50),
  @Renglon              float,
  @Impuesto1		float,	
  @Impuesto2		float,	
  @Impuesto3		float,	
  @Retencion1		float,	
  @Retencion2		float,	
  @Retencion3		float,	
  @TipoImpuesto1	varchar(10),
  @TipoImpuesto2	varchar(10),
  @TipoImpuesto3	varchar(10),
  @TipoRetencion1	varchar(10),
  @TipoRetencion2	varchar(10),
  @TipoRetencion3	varchar(10),
  @TipoImpuesto4	varchar(10),
  @Impuesto5		float	,
  @TipoImpuesto5	varchar(10),
  @TipoImpuesto         bit,
  @SubTotal             float,
  @Impuesto2BaseImpuesto1 bit,
  @Impuesto2Info        bit,
  @Impuesto3Info        bit,
  @Impuestos            float,
  @Impuestos2           float,
  @Impuestos3           float,
  @MovClave             varchar(20),
  @GastoSolicitudAnticipoImpuesto  bit,
  @ZonaImpuestos        varchar(30),
  @ConceptoImpuestos    float,
  @Conceptoretencion2   float,
  @RetencionGasto1	float,	
  @RetencionGasto2	float,	
  @RetencionGasto3	float,
  @ConceptoRetencion    float,
  @Conceptoretencion3   float,
  @TieneRetencion       bit,
  @Retencion2BaseImpuesto1 bit,
  @Gasto2Retenciones 	  bit,
  @Gasto3Retenciones 	  bit,
  @Retenciones            float

  
  

  
  SELECT @Impuesto2BaseImpuesto1 = ISNULL(Impuesto2BaseImpuesto1,0), @Impuesto2Info = ISNULL(Impuesto2Info,0), @Impuesto3Info = ISNULL(Impuesto3Info,0),@Retencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1,0)
    FROM Version
  
  
  SELECT @Mov = Mov , @Fecha = FechaEmision , @Empresa = Empresa, @Sucursal = Sucursal, @Acreedor = Acreedor, @TieneRetencion = TieneRetencion
    FROM Gasto
   WHERE  ID = @ID
   
  SELECT @ZonaImpuestos = ZonaImpuesto FROM Prov WHERE Proveedor = @Acreedor
   
  SELECT @MovClave = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = 'GAS'
   
  SELECT @TipoImpuesto = ISNULL(TipoImpuesto,0) FROM EmpresaGral WHERE Empresa = @Empresa
  
  SELECT @GastoSolicitudAnticipoImpuesto =ISNULL(GastoSolicitudAnticipoImpuesto,0), @Gasto2Retenciones = ISNULL(Gasto2Retenciones,0), @Gasto3Retenciones = ISNULL(Gasto3Retenciones,0) FROM EmpresaCfg2  WHERE Empresa = @Empresa  
     
  DECLARE crGastoD CURSOR FOR
   SELECT Renglon, Concepto
     FROM GastoD
    WHERE ID = @ID

  OPEN crGastoD
  FETCH NEXT FROM crGastoD INTO @Renglon, @Concepto
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
  
    SELECT @ConceptoImpuestos = Impuestos, @ConceptoRetencion = Retencion, @Conceptoretencion2 = Retencion2, @Conceptoretencion3 = Retencion3 FROM Concepto WHERE Concepto = @Concepto AND Modulo = 'GAS'

  
    EXEC spTipoImpuesto @Modulo, @ID, @Mov, @Fecha, @Empresa, @Sucursal, @Acreedor, NULL, NULL, @Concepto, 1, 1, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT, @Retencion1 OUTPUT, @Retencion2 OUTPUT, @Retencion3 OUTPUT, @TipoImpuesto1 OUTPUT, @TipoImpuesto2 OUTPUT, @TipoImpuesto3 OUTPUT, @TipoRetencion1 OUTPUT, @TipoRetencion2 OUTPUT, @TipoRetencion3 OUTPUT, @TipoImpuesto4 OUTPUT, @Impuesto5 OUTPUT, @TipoImpuesto5 OUTPUT 
    
    UPDATE GastoD SET Impuesto1 = @Impuesto1, 
	   	      Impuesto2 = @Impuesto2, 
	   	      Impuesto3 = @Impuesto3, 
	   	      TipoImpuesto1 = @TipoImpuesto1, 
	   	      TipoImpuesto2 = @TipoImpuesto2, 
	   	      TipoImpuesto3 = @TipoImpuesto3, 
	   	      TipoRetencion1 =@TipoRetencion1, 
	   	      TipoRetencion2 =@TipoRetencion2, 
	   	      TipoRetencion3 =@TipoRetencion3,
	   	      TipoImpuesto4 = @TipoImpuesto4,
	   	      Impuesto5 = @Impuesto5, 
	   	      TipoImpuesto5 = @TipoImpuesto5
     WHERE ID = @ID 
       AND Renglon = @Renglon
     IF @@ERROR <> 0 SET @Ok = 1  
     
     SELECT @SubTotal = ISNULL(Importe,0.0)-ISNULL(Retencion3,0.0) FROM GastoD WHERE ID = @ID AND Renglon = @Renglon

     IF @TipoImpuesto = 1
     BEGIN
       SELECT @Impuestos = (@SubTotal*(1+CASE WHEN (@Impuesto2BaseImpuesto1 = 0)OR(@Impuesto2Info = 1) THEN 0 ELSE ((ISNULL(Impuesto2,0.0)/100))*(ISNULL(Impuesto1,0.0)/100)END)),
       @RetencionGasto1 = @SubTotal * @Retencion1/100
         FROM GastoD WHERE ID = @ID AND Renglon = @Renglon
       
       IF @Retencion2BaseImpuesto1 = 1
         SELECT  @RetencionGasto2 = @Impuestos * @Retencion2/100
       ELSE
         SELECT  @RetencionGasto2 = @SubTotal * @Retencion2/100
      
      SELECT @RetencionGasto3 = Importe*@Retencion3/100  FROM GastoD WHERE ID = @ID AND Renglon = @Renglon          
         
        
     END    
     ELSE
     BEGIN 
       IF @MovClave IN ('GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.C', 'GAS.CCH', 'GAS.DC', 'GAS.CP', 'GAS.DG', 'GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB')
       OR @GastoSolicitudAnticipoImpuesto = 1   
       BEGIN    
       
         EXEC spZonaImp @ZonaImpuestos, @ConceptoImpuestos OUTPUT
         
         SELECT @Impuestos = @SubTotal*ISNULL(@ConceptoImpuestos,0.0)/100
         
         IF @TieneRetencion = 1 
         BEGIN
           SELECT  @RetencionGasto1 = ROUND(@SubTotal*@ConceptoRetencion/100, 4)
          
           IF @Gasto2Retenciones = 1
           BEGIN
             IF @Retencion2BaseImpuesto1 =1
               SELECT @RetencionGasto2 =  ROUND(@Impuestos*@Conceptoretencion2/100,4)
             ELSE
               SELECT @RetencionGasto2 =  ROUND(@SubTotal*@Conceptoretencion2/100,4) 
           END  
           IF @Gasto3Retenciones = 1
             SELECT @RetencionGasto3 =  ROUND(Importe*@Conceptoretencion3/100,4) FROM GastoD WHERE ID = @ID AND Renglon = @Renglon    
         END  
       END 
       ELSE 
         SELECT @Impuestos = Impuestos,@RetencionGasto1 = Retencion, @RetencionGasto2 = Retencion2,@RetencionGasto3 = Retencion3   FROM GastoD WHERE ID = @ID AND Renglon = @Renglon
     END
 
     IF @TipoImpuesto = 1 AND @Impuesto2Info = 0
       SELECT @Impuestos2 = (@SubTotal*Impuesto2/100)
         FROM GastoD WHERE ID = @ID AND Renglon = @Renglon
         
     IF @TipoImpuesto = 1 AND @Impuesto3Info = 0
       SELECT   @Impuestos3 =   Cantidad*Impuesto3  FROM GastoD WHERE ID = @ID AND Renglon = @Renglon
         
        
	      
     UPDATE GastoD SET Impuestos = ISNULL(@Impuestos,0.0), Impuestos2 = ISNULL(@Impuestos2,0.0), Impuestos3 = ISNULL(@Impuestos3,0.0), Retencion = @RetencionGasto1, Retencion2 = @RetencionGasto2, Retencion3 = @RetencionGasto3
      WHERE ID = @ID AND Renglon = @Renglon
     IF @@ERROR <> 0 SET @Ok = 1        
    FETCH NEXT FROM crGastoD INTO @Renglon, @Concepto
  END
  CLOSE crGastoD
  DEALLOCATE crGastoD   
  
  
  SELECT @Impuestos = SUM(ISNULL(Impuestos,0.0)), @Retenciones = SUM(ISNULL(Retencion,0.0) + ISNULL(Retencion2,0.0) + ISNULL(Retencion3,0.0)) FROM GastoD WHERE ID = @ID

  UPDATE Gasto SET Impuestos = @Impuestos, Saldo = Importe + @Impuestos - @Retenciones WHERE ID = @ID      
  IF @@ERROR <> 0 SET @Ok = 1  


  RETURN
END
GO



--speDocInInsertarIS 'C:\Entrada','C:\Salida','.xml','DEMO','DEMO',0

/**************** spISeDocINError ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeDocINError') and type = 'P') drop procedure dbo.spISeDocINError 
GO             
CREATE PROCEDURE spISeDocINError
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Empresa				varchar(5),
  @Usuario                              varchar(10),
  @Sucursal                             int,
  @XML2                                 xml,
  @Ruta                                 varchar(max),
  @Texto                                varchar(max),
  @XMLTexto                             varchar(max),
  @XML3                                 varchar(max),
  @XML                                  xml,
  @ReferenciaIS		                varchar(100),
  @Estacion                             int,
  @Nodo                                 varchar(max),
  @Origen                               varchar(max),
  @ErrorRef			        varchar(255)
  BEGIN TRANSACTION
  
  SELECT @Estacion = @@SPID
  SELECT 
    @Empresa = Empresa,
    @Usuario = Usuario,
    @Sucursal = Sucursal ,
    @Origen = Origen ,
    @Ok = Ok    ,      
    @OkRef = OkRef          
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud')
    WITH (Empresa varchar(5), Usuario varchar(10), Sucursal int, Origen  varchar(max), Ok int, OkRef varchar(255))

    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
    BEGIN
      ROLLBACK TRANSACTION
      SELECT @ErrorRef = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
      SELECT @OkRef = ISNULL(@ErrorRef,'')+' '+ISNULL(@OkRef,'')
      
    END  

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    SELECT @Texto =(SELECT * FROM eDocInRutaTemp WHERE Estacion = @Estacion FOR XML AUTO)
    SELECT @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + ISNULL(CONVERT(varchar(max),@Texto),'') + '</Resultado></Intelisis>'
  
    
END
GO


/**************** speDocINInsertarRutaTablaDOmision ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.speDocINInsertarRutaTablaDOmision') and type = 'P') drop procedure dbo.speDocINInsertarRutaTablaDOmision 
GO             
CREATE PROCEDURE speDocINInsertarRutaTablaDOmision
             @eDocIn          varchar(50),
             @Ruta            varchar(50),
             @Tablas          varchar(50),
             @Modulo          varchar(20), 
             @Ok              int OUTPUT,
             @OkRef           varchar(255) OUTPUT


--//WITH ENCRYPTION
AS BEGIN

  IF EXISTS(SELECT * FROM   eDocInRutaTablaDOmision WHERE Modulo = @Modulo AND Tablas = @Tablas)
  BEGIN
    INSERT eDocInRutaTablaD (eDocIn,   Ruta,  Tablas,  CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST)
    SELECT                   @eDocIn,  @Ruta, @Tablas, Campo  , Expresion,    Campo,      TipoDatos,   NULL,         NULL,             NULL,            1,               0,             NULL,              NULL,               NULL,                  0,        NULL
      FROM eDocInRutaTablaDOmision 
     WHERE Modulo = @Modulo AND Tablas = @Tablas
    EXCEPT
    SELECT  eDocIn,   Ruta,  Tablas,  CampoXML, ExpresionXML, CampoTabla, CampoXMLTipo, CampoXMLRuta, CampoXMLAtributo, CampoXMLTipoXML, EsIndependiente, EsConsecutivo, ConsecutivoNombre, ConsecutivoInicial, ConsecutivoIncremento, Traducir, TablaST
      FROM eDocInRutaTablaD
     WHERE eDocIn = @eDocIn AND Ruta = @Ruta AND Tablas = @Tablas 
  
  END

END
GO 