SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 
/**************** spOrdenarWeb ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOrdenarWeb') and type = 'P') drop procedure dbo.spOrdenarWeb
GO             
CREATE PROCEDURE spOrdenarWeb
                    @Estacion	int,
		    @Tabla	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int

  SELECT @Tabla = UPPER(@Tabla)
--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        IF @Tabla = 'WebArt'             UPDATE WebArt SET Orden = @Orden WHERE ID  = @Clave ELSE
        IF @Tabla = 'WebCatArt'          UPDATE WebCatArt SET Orden = @Orden WHERE ID  = @Clave ELSE
        IF @Tabla = 'WebArtVariacion'    UPDATE WebArtVariacion SET Orden = @Orden WHERE ID  = @Clave ELSE
        IF @Tabla = 'WebArtMarca'        UPDATE WebArtMarca SET Orden = @Orden WHERE ID  = @Clave ELSE
        IF @Tabla = 'WebArtImagen'       UPDATE WebArtImagen SET Orden = @Orden WHERE ID  = @Clave ELSE
        IF @Tabla = 'WebArtOpcion'       UPDATE WebArtOpcion SET Orden = @Orden WHERE ID  = @Clave  ELSE
        IF @Tabla = 'WebArtCamposConfigurables' UPDATE WebArtCamposConfigurables SET Orden = @Orden WHERE ID  = @Clave

      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO

--/**************** spWebArtInsertarDescripcion  ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarDescripcion') and type = 'P') drop procedure dbo.spWebArtInsertarDescripcion
--GO             
--CREATE PROCEDURE spWebArtInsertarDescripcion
--                    @IDArt 	int,
--		    @Descripcion varchar(3000)
----//WITH ENCRYPTION
--AS BEGIN
--  -- SET nocount ON
--  IF NULLIF(@Descripcion,'') IS NULL  OR @IDArt IS NULL RETURN
--  UPDATE WebArt SET DescripcionHTML = @Descripcion WHERE ID = @IDArt


--  RETURN
--END
--GO



/**************** spOrdenarWebArtOpcionValor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOrdenarWebArtOpcionValor') and type = 'P') drop procedure dbo.spOrdenarWebArtOpcionValor
GO             
CREATE PROCEDURE spOrdenarWebArtOpcionValor
                    @Estacion	        int,
		    @Tabla	        varchar(50),               
                    @VariacionID	int,
                    @OpcionID    	int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int

  SELECT @Tabla = UPPER(@Tabla)
--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        IF @Tabla = 'WebArtOpcionValor'  UPDATE WebArtOpcionValor SET Orden = @Orden WHERE Valor  = @Clave   AND  VariacionID = @VariacionID AND OpcionID  = @OpcionID 

      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO


/**************** spOrdenarWebArtVideo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spOrdenarWebArtVideo') and type = 'P') drop procedure dbo.spOrdenarWebArtVideo
GO             
CREATE PROCEDURE spOrdenarWebArtVideo
                    @Estacion	        int,
		    @Tabla	        varchar(50),               
                    @IDArt          	int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Orden		int,
    @Clave		varchar(255),
    @Actividad		varchar(10),
    @ActividadID	int

  SELECT @Tabla = UPPER(@Tabla)
--  CREATE TABLE #Log (ID int NULL)
  BEGIN TRANSACTION
    SELECT @Orden = 0
    DECLARE crListaSt CURSOR FOR SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID 
    OPEN crListaSt
    FETCH NEXT FROM crListaSt INTO @Clave
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Orden = @Orden + 1
        IF @Tabla = 'WebArtVideo' UPDATE WebArtVideo SET Orden = @Orden WHERE ID = @Clave  AND IDArt = @IDArt ELSE
        IF @Tabla = 'WebArtCamposConfigurablesD' UPDATE WebArtCamposConfigurablesD SET Orden = @Orden WHERE Valor = @Clave  AND ID = @IDArt ELSE
        IF @Tabla = 'WebSucursalImagen' UPDATE WebSucursalImagen SET Orden = @Orden WHERE Nombre = @Clave  AND Sucursal= @IDArt 
        
        

      END
      FETCH NEXT FROM crListaSt INTO @Clave
    END -- While
    CLOSE crListaSt
    DEALLOCATE crListaSt

   -- DELETE ListaSt WHERE Estacion = @Estacion
  COMMIT TRANSACTION
--ROLLBACK TRAN
  RETURN
END
GO



/**************** spWebArtCategoias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtCategoias') and type = 'P') drop procedure dbo.spWebArtCategoias
GO             
CREATE PROCEDURE spWebArtCategoias
		    @ID         int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CategoriaID     int,
    @Columns         varchar(255),
    @Categoria1      int
    
  SELECT TOP 1 @Categoria1 =   IDWebCatArt
    FROM  WebCatArt_Art
   WHERE IDWebArt = @ID
   ORDER by IDWebCatArt
    
    
  SELECT @columns = ISNULL(@columns,'') + ',' + Convert(varchar,IDWebCatArt)  
    FROM  WebCatArt_Art
   WHERE IDWebArt = @ID
   ORDER by IDWebCatArt

  UPDATE WebArt SET CategoriaIDS =  stuff(@columns,1,1,'' ), Categoria1 = @Categoria1
   WHERE ID = @ID
END
GO



/**************** spWebArtBorrarImagenTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtBorrarImagenTemp') and type = 'P') drop procedure dbo.spWebArtBorrarImagenTemp
GO             
CREATE PROCEDURE spWebArtBorrarImagenTemp
		    @Estacion        int
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DELETE WebArtImagenTemp WHERE Estacion = @Estacion
END
GO

/**************** spWebArtBorrarCombImagenTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtBorrarCombImagenTemp') and type = 'P') drop procedure dbo.spWebArtBorrarCombImagenTemp
GO             
CREATE PROCEDURE spWebArtBorrarCombImagenTemp
		    @Estacion        int
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  DELETE WebArtCombinacionImagenTemp WHERE Estacion = @Estacion
END
GO





/**************** spWebArtInsertarImagen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarImagen') and type = 'P') drop procedure dbo.spWebArtInsertarImagen
GO             
CREATE PROCEDURE spWebArtInsertarImagen
		    @IDArt           int,
		    @Directorio      varchar(255),
		    @Nombre          varchar(255)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE 
 @Orden int
 --@CantidadImagenes  int,
 
 
 SELECT @Orden = ISNULL(MAX(orden),0)+1 FROM  WebArtImagen WHERE IDArt = @IDArt

 
  
  IF NULLIF(@Directorio,'') IS NULL OR @IDArt IS NULL RETURN
  
  INSERT WebArtImagen(IDArt,ArchivoImagen,Orden,Nombre,TipoArchivo)
  SELECT              @IDArt,@Directorio,@Orden, dbo.fnWebQuitarTipoArchivo(@Nombre),dbo.fnWebTipoArchivo(@Nombre)
  
END

GO

/**************** spWebSucursalInsertarImagen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebSucursalInsertarImagen') and type = 'P') drop procedure dbo.spWebSucursalInsertarImagen
GO             
CREATE PROCEDURE spWebSucursalInsertarImagen
		    @Sucursal         int,
		    @Directorio      varchar(255),
		    @Nombre          varchar(255)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE 
 @Orden int
 --@CantidadImagenes  int,
 
 
 SELECT @Orden = ISNULL(MAX(orden),0)+1 FROM  WebSucursalImagen WHERE Sucursal = @Sucursal

 
  
  IF NULLIF(@Directorio,'') IS NULL OR @Sucursal IS NULL RETURN
  
  INSERT WebSucursalImagen(Sucursal,ArchivoImagen,Orden,Nombre,TipoArchivo)
  SELECT                  @Sucursal,@Directorio,@Orden, dbo.fnWebQuitarTipoArchivo(@Nombre),dbo.fnWebTipoArchivo(@Nombre)
  
END

GO
/**************** spWebArtInsertarImagenCombinacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarImagenCombinacion') and type = 'P') drop procedure dbo.spWebArtInsertarImagenCombinacion
GO             
CREATE PROCEDURE spWebArtInsertarImagenCombinacion
                    @IDCombinacion   int,
		    @Directorio      varchar(255),
		    @Nombre          varchar(255)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE 
 @Orden int
 --@CantidadImagenes  int,

  IF NULLIF(@Directorio,'') IS NULL OR @IDCombinacion IS NULL RETURN
  UPDATE WebArtVariacionCombinacion SET Imagen = @Directorio, TipoArchivo = dbo.fnWebTipoArchivo(@Directorio), NombreImagen = @Nombre
   WHERE ID = @IDCombinacion
  
  
END
GO

/**************** spWebArtEliminarImagenCombinacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtEliminarImagenCombinacion') and type = 'P') drop procedure dbo.spWebArtEliminarImagenCombinacion
GO             
CREATE PROCEDURE spWebArtEliminarImagenCombinacion
                    @IDCombinacion   int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 
 

  UPDATE WebArtVariacionCombinacion SET Imagen =NULL, TipoArchivo = NULL, NombreImagen = NULL
   WHERE ID = @IDCombinacion
  
END
GO
/**************** spWebArtEnvolturas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtEnvolturas') and type = 'P') drop procedure dbo.spWebArtEnvolturas
GO             
CREATE PROCEDURE spWebArtEnvolturas
		    @ID         int,
		    @Sucursal	int,
		    @EnvolturaIDS	varchar(max) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @IDEnvoltura     int,
    @Columns         varchar(255),
    @Tipo			varchar(20),
    @SucursaleCommerce	varchar(10)
    
  SELECT @Tipo = OpcionesEnvoltura FROM WebArt WHERE ID = @ID
  SELECT @SucursaleCommerce = eCommerceSucursal FROM Sucursal WHERE Sucursal = @Sucursal
  
  IF(@Tipo = 'Ninguna')
	SET @Columns = ''
  ELSE IF (@Tipo = 'Seleccion')
  BEGIN
	  SELECT @Columns = ISNULL(@Columns,'') + ',' + Convert(varchar,wae.IDEnvoltura)  
		FROM  WebArtEnvoltura wae
		JOIN WebEnvolturaRegalo wer ON (wae.IDEnvoltura=wer.ID)
	   WHERE wae.IDArt = @ID AND wer.SucursaleCommerce = @SucursaleCommerce
	   ORDER by wae.IDEnvoltura
  END
  ELSE IF (@Tipo = 'Omision')
  BEGIN
	SELECT @Columns = ISNULL(@Columns,'') + ',' + Convert(varchar,eCommerceEnvolturaOmision)
		FROM Sucursal
		WHERE Sucursal = @Sucursal
  END
  ELSE IF(@Tipo = 'Todas')
  BEGIN
	SELECT @Columns = ISNULL(@Columns,'') + ',' + Convert(varchar,ID)
		FROM WebEnvolturaRegalo
		WHERE SucursaleCommerce = @SucursaleCommerce
  END

  SELECT @EnvolturaIDS =  stuff(@Columns,1,1,'' )
END
GO
/**************** spWebEnvolturaInsertarImagen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebEnvolturaInsertarImagen') and type = 'P') drop procedure dbo.spWebEnvolturaInsertarImagen
GO             
CREATE PROCEDURE spWebEnvolturaInsertarImagen
		    @IDEnvoltura	int,
		    @Nombre          varchar(255)
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
 DECLARE 
 @Orden int
 --@CantidadImagenes  int,
 
  IF NULLIF(@IDEnvoltura,'') IS NULL OR NULLIF(@Nombre,'') IS NULL RETURN
  
  UPDATE WebEnvolturaRegalo SET Imagen = @Nombre WHERE ID = @IDEnvoltura
  
END
GO

/**************** spWebEnvolturaBorrarImagen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebEnvolturaBorrarImagen') and type = 'P') drop procedure dbo.spWebEnvolturaBorrarImagen
GO             
CREATE PROCEDURE spWebEnvolturaBorrarImagen
		    @ID int
		
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

  UPDATE WebEnvolturaRegalo SET Imagen = NULL WHERE ID = @ID
END
GO
/**************** fnWebIDVideo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebIDVideo') DROP FUNCTION fnWebIDVideo
GO
CREATE FUNCTION fnWebIDVideo 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(MAX)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  
  SET @Expresion = REPLACE(@Expresion, 'http://', '')
  SET @Expresion = REPLACE(@Expresion, 'https://', '')
  
  -- NES - Bug 14632: Agrego esto por si la direccion viene con URL shortener
  SET @Expresion = REPLACE(@Expresion, 'www.youtu.be/', 'youtube.com/?v=')
  SET @Expresion = REPLACE(@Expresion, 'youtu.be/', 'youtube.com/?v=')
  
  SET @Longitud = LEN(@Expresion)
  SELECT @Posicion = CHARINDEX('v=',@Expresion)
  SELECT @Expresion = SUBSTRING(@Expresion,@Posicion,@Longitud)
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    --select @Caracter,@Estado
    IF @Estado = 0 AND @Caracter = 'v'   SET @Estado = 1 ELSE
    IF @Estado = 1 AND @Caracter = ('=') SET @Estado = 2 ELSE
    IF @Estado = 2 AND @Caracter = '&' OR  @Contador = @Longitud+1      SET @Estado = 3
    
    IF @Estado = 2
    BEGIN
      SET @Variable = @Variable + @Caracter
    END     
    SET @Contador = @Contador + 1
  END  
  SELECT @Variable=stuff(@Variable,1,1,'' )
  RETURN (@Variable)
END
GO

--SELECT dbo.fnWebIDVideo('http://www.youtube.com/watch?v=u3oxvqekCM4')

 /**************** fnWebConsecutivoImagen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebConsecutivoImagen') DROP FUNCTION fnWebConsecutivoImagen
GO
CREATE FUNCTION fnWebConsecutivoImagen 
	(
	@IDArt           int,
	@Archivo         varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
 @Orden int,
 @CantidadImagenes  int,
 @Nombre varchar(50),
 @Extencion          varchar(10)
 
  SELECT @CantidadImagenes = ISNULL(COUNT(*),0)+1 FROM  WebArtImagen WHERE IDArt = @IDArt
  SELECT @Nombre = CONVERT(varchar,@IDArt)+'_Imagen'+CONVERT(varchar,@CantidadImagenes) 
  WHILE EXISTS(SELECT Nombre FROM  WebArtImagen WHERE Nombre = @Nombre AND IDArt = @IDArt)
  BEGIN
    
    SELECT @Nombre = CONVERT(varchar,@IDArt)+'_Imagen'+CONVERT(varchar,@CantidadImagenes) 
    SELECT @CantidadImagenes = @CantidadImagenes +1
  END  
 
 SELECT @Orden = ISNULL(MAX(orden),0)+1 FROM  WebArtImagen WHERE IDArt = @IDArt
 
 SELECT @Nombre = @Nombre + ISNULL(dbo.fnWebTipoArchivo(@Archivo),'')  
  

   
  RETURN (@Nombre)
END
GO

--SELECT dbo.fnWebConsecutivoImagen(6)

 /**************** fnWebConsecutivoImagen2 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebConsecutivoImagen2') DROP FUNCTION fnWebConsecutivoImagen2
GO
CREATE FUNCTION fnWebConsecutivoImagen2 
	(
	@IDCombinacion   int,
	@IDArt           int,
	@Archivo         varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
 @Orden int,
 @CantidadImagenes  int,
 @Nombre varchar(50),
 @Extencion          varchar(10)
 


 SELECT @Nombre = CONVERT(varchar,@IDArt)+'_'+CONVERT(varchar,@IDCombinacion)+'_Imagen1'+ISNULL(dbo.fnWebTipoArchivo(@Archivo),'')  
  

   
  RETURN (@Nombre)
END
GO

 /**************** fnWebConsecutivoImagenSucursal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebConsecutivoImagenSucursal') DROP FUNCTION fnWebConsecutivoImagenSucursal
GO
CREATE FUNCTION fnWebConsecutivoImagenSucursal 
	(
	@Sucursal          int,
	@Archivo         varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
 @Orden int,
 @CantidadImagenes  int,
 @Nombre varchar(50),
 @Extencion          varchar(10)
 
  SELECT @CantidadImagenes = ISNULL(COUNT(*),0)+1 FROM  WebSucursalImagen WHERE Sucursal = @Sucursal
  SELECT @Nombre = CONVERT(varchar,@Sucursal)+'_Imagen'+CONVERT(varchar,@CantidadImagenes) 
  WHILE EXISTS(SELECT Nombre FROM  WebSucursalImagen WHERE Nombre = @Nombre AND Sucursal = @Sucursal)
  BEGIN
    
    SELECT @Nombre = CONVERT(varchar,@Sucursal)+'_Imagen'+CONVERT(varchar,@CantidadImagenes) 
    SELECT @CantidadImagenes = @CantidadImagenes +1
  END  
 
 SELECT @Orden = ISNULL(MAX(orden),0)+1 FROM  WebSucursalImagen WHERE Sucursal = @Sucursal
 
 SELECT @Nombre = @Nombre + ISNULL(dbo.fnWebTipoArchivo(@Archivo),'')  
  

   
  RETURN (@Nombre)
END
GO

 /**************** fnWebQuitarTipoArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebQuitarTipoArchivo') DROP FUNCTION fnWebQuitarTipoArchivo
GO
CREATE FUNCTION fnWebQuitarTipoArchivo 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255),
    @Posicion                   int
    

  SELECT @Posicion = CHARINDEX('.',@Expresion)
  SELECT @Resultado = SUBSTRING(@Expresion,1,@Posicion-1)

   
  RETURN (@Resultado)
END
GO

--select dbo.fnWebQuitarTipoArchivo('lplplplplq.bmp')


 /**************** fnWebTipoArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebTipoArchivo') DROP FUNCTION fnWebTipoArchivo
GO
CREATE FUNCTION fnWebTipoArchivo 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255),
    @Posicion                   int
    
  SELECT @Expresion = REVERSE(@Expresion)
  SELECT @Posicion = CHARINDEX('.',@Expresion)
  SELECT @Resultado = REVERSE(SUBSTRING(@Expresion,1,@Posicion))

   
  RETURN (@Resultado)
END
GO

--select dbo.fnWebTipoArchivo('lplplplpl.bmp')
 
  /**************** fnWebSepararContacto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebSepararContacto') DROP FUNCTION fnWebSepararContacto
GO
CREATE FUNCTION fnWebSepararContacto 
	(
	@Expresion				varchar(255),
	@Tipo                                   int
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255),
    @Posicion                   int,
    @Len                        int
    
  SELECT @Len = LEN(@Expresion)
  SELECT @Posicion = CHARINDEX(' ',@Expresion)
  IF(@Posicion = 0) RETURN @Expresion
  IF @Tipo = 1
    SELECT @Resultado = SUBSTRING(@Expresion,1,@Posicion-1)
  IF @Tipo = 2
    SELECT @Resultado = SUBSTRING(@Expresion,@Posicion,@Len)    

  SELECT @Resultado = LTRIM(RTRIM(@Resultado))   
  RETURN (@Resultado)
END
GO


--select dbo.fnWebSepararContacto('Juan Gonzalez Camarena',1)
--select dbo.fnWebSepararContacto('Juan Gonzalez Camarena',2)


 /**************** fnWebNombreImagen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebNombreImagen') DROP FUNCTION fnWebNombreImagen
GO
CREATE FUNCTION fnWebNombreImagen 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(MAX)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  SELECT @Expresion = REVERSE(@Expresion)
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)

    IF @Estado = 0 AND @Caracter = '\'   SET @Estado = 1 
    
    IF @Estado = 0
    BEGIN
      SET @Variable = @Variable + @Caracter
    END     
    SET @Contador = @Contador + 1
  END  
  SELECT @Variable = REVERSE(@Variable)
   
  RETURN (@Variable)
END
GO

--SELECT dbo.fnWebNombreImagen('C:\Team\POS2_0\3500\Dibujos\Imagenes\Embarques.bmp')


 /**************** fnWebSepararCombinaciones ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebSepararCombinaciones') DROP FUNCTION fnWebSepararCombinaciones
GO
CREATE FUNCTION fnWebSepararCombinaciones 
	(
	@ID                                     int,
	@VariacionID                            int,
	@Expresion				varchar(255)
	)
RETURNS @Tabla TABLE (ID int,IDOpcion  int,NombreOpcion varchar(100), IDCombinacion int, Valor varchar(100))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int,
    @IDOpcion                   int
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN 

  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    IF @Estado = 0 AND @Caracter =','   SET @Estado =1
    IF @Estado = 0 AND @Contador = @Longitud SET @Estado =3

    IF @Estado IN( 0,3) AND ISNUMERIC(@Caracter)=1
    SELECT @Variable = @Variable + @Caracter
    
    IF  @Estado IN( 1,3)
    BEGIN
      IF ISNUMERIC(@Variable)=1
      INSERT @Tabla(ID,IDOpcion  , IDCombinacion,NombreOpcion,Valor )
      SELECT       @ID, v.OpcionID,  v. ID, o.Nombre, v.Valor
        FROM WebArtOpcionValor v JOIN WebArtOpcion o ON v.VariacionID = o.VariacionID AND o.ID = v.OpcionID
       WHERE v.ID =  @Variable AND v.VariacionID = @VariacionID
      SET @Estado = 0
      SELECT @Variable = ''
    END     
    SET @Contador = @Contador + 1
  END 
      
  RETURN 
END
GO


--SELECT * FROM dbo.fnWebSepararCombinaciones(1,1,'9,1,6')  





 
 /**************** fnWebOrdenarCombinacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebOrdenarCombinacion') DROP FUNCTION fnWebOrdenarCombinacion
GO
CREATE FUNCTION fnWebOrdenarCombinacion 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(MAX)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Variable2			varchar(255),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int
    
    DECLARE @Tabla table(ID int)
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  --SELECT @Expresion = REVERSE(@Expresion)
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    IF @Estado = 0 AND @Caracter =','   SET @Estado =1
    IF @Estado = 0 AND @Contador = @Longitud SET @Estado =3

    IF @Estado IN( 0,3) 
    SELECT @Variable = @Variable + @Caracter
    IF  @Estado IN( 1,3)
    BEGIN
      IF ISNUMERIC(@Variable)=1
      INSERT @Tabla(ID)
      SELECT @Variable
      SET @Estado = 0
      SELECT @Variable = ''
    END     
    SET @Contador = @Contador + 1
  END 
  SELECT @Variable2 = ISNULL(@Variable2,'') + ',' + Convert(varchar,ID)  
    FROM  @Tabla
   ORDER by ID
   SELECT @Variable2 = STUFF(@Variable2,1,1,'' )
  RETURN (@Variable2)
END
GO

----SELECT  dbo.fnWebOrdenarCombinacion('92,12,6')  

/**************** fnWebOrdenarSubCuenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebOrdenarSubCuenta') DROP FUNCTION fnWebOrdenarSubCuenta
GO
CREATE FUNCTION fnWebOrdenarSubCuenta 
	(
	@Expresion				varchar(255)
	)
RETURNS varchar(MAX)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(255),
    @Variable2			varchar(255),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int
    
    DECLARE @Tabla table(ID varchar(10))
    
  SET @Resultado = ''
    
  IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  --SELECT @Expresion = REVERSE(@Expresion)
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 0
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN
    SET @EstadoAnterior = @Estado
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    IF @Estado = 0 AND @Caracter =','   SET @Estado =1
    IF @Estado = 0 AND @Contador = @Longitud SET @Estado =3

    IF @Estado IN( 0,3) 
    SELECT @Variable = @Variable + @Caracter
    IF  @Estado IN( 1,3)
    BEGIN
      INSERT @Tabla(ID)
      SELECT @Variable
      SET @Estado = 0
      SELECT @Variable = ''
    END     
    SET @Contador = @Contador + 1
  END 
  SELECT @Variable2 = ISNULL(@Variable2,'') + Convert(varchar,ID)  
    FROM  @Tabla
   ORDER by ID

  RETURN (@Variable2)
END
GO

----SELECT  dbo.fnWebOrdenarSubCuenta('B2,A1,C4')  






/**************** spWebArtGenerarCombinaciones ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spWebArtGenerarCombinaciones') and type = 'P') drop procedure dbo.spWebArtGenerarCombinaciones
GO  
CREATE PROCEDURE spWebArtGenerarCombinaciones		
			@IDArt        int,
			@IDVariacion  int,
			@Ok           int = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE

  @SELECT       varchar(MAX),
  @SELECT2      varchar(MAX),
  @SELECT3      varchar(MAX),
  @SELECT4      varchar(MAX),
  @WHERE        varchar(MAX),
  @FROM         varchar(MAX),
  @Contador     int,
  @Nombre       varchar(100), 
  @ID           int, 
  @Alias        varchar(50), 
  @Valor        varchar(100),
  @SQL          varchar(MAX),
  @SQL2         varchar(MAX),
  @IDTabla      int,
  @IDTemp       int,
  @IDTemp2      int,
  @IDValor      varchar(100),
  @Orden        int,
  @Opciones     varchar(1000),
  @SubCuenta    varchar(50),
  @Articulo     varchar(20),
  @TipoOpcion   varchar(20)
  
  
  DECLARE @Tabla TABLE (ID int,IDOpcion  int,NombreOpcion varchar(100), IDCombinacion int, Valor varchar(100))
    IF @IDArt IS NULL OR @IDVariacion IS NULL SET @Ok = 1
    IF NOT EXISTS(SELECT * FROM WebArtVariacion WHERE ID = @IDVariacion) SET @Ok = 1
    IF NOT EXISTS(SELECT * FROM WebArtOpcion WHERE VariacionID = @IDVariacion) SET @Ok = 1
    IF NOT EXISTS(SELECT * FROM WebArtOpcionValor WHERE VariacionID = @IDVariacion) SET @Ok = 1

    IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCobinacionTemp')) AND @Ok IS NULL
      DROP TABLE WebArtCobinacionTemp
      

  BEGIN TRANSACTION
  IF @Ok IS NULL
    BEGIN
    SELECT @Articulo = Articulo FROM WebArt WHERE ID = @IDArt
    SELECT @TipoOpcion = TipoOpcion FROM Art WHERE Articulo = @Articulo
    
    SELECT @SELECT = '', @FROM = '', @SELECT2 = '', @SELECT3 = '', @SELECT4= '', @WHERE = '', @Contador = 1  ,@SQL2 =''
    IF EXISTS(SELECT * FROM WebArtOpcion WHERE VariacionID = @IDVariacion) AND @Ok IS NULL
    BEGIN
      DECLARE crVariacion CURSOR FAST_FORWARD FOR 
       SELECT o.Nombre, o.ID
         FROM WebArtOpcion o 
        WHERE o.VariacionID = @IDVariacion
      ORDER BY o.Orden
      
      OPEN  crVariacion
      FETCH NEXT FROM  crVariacion INTO @Nombre, @ID--, @Valor
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        SELECT @Alias = CONVERT(varchar,@Contador)
        
        
        IF @Contador = 1
          SELECT @SELECT = @SELECT + ' SELECT NULL ID, v'+ @Alias +'.Valor As ['+ISNULL(@Nombre,'')+'] '
        ELSE  
          SELECT @SELECT = @SELECT + ' , v'+ @Alias +'.Valor As ['+ISNULL(@Nombre,'')+'] '
          
        IF @Contador = 1
          SELECT @SELECT2 = @SELECT2 + ',CONVERT(varchar,v'+ @Alias +'.ID)+'+CHAR(39)+','+CHAR(39)
        ELSE  
          SELECT @SELECT2 = @SELECT2 + '+CONVERT(varchar,v'+ @Alias +'.ID)+'+CHAR(39)+','+CHAR(39)    
          
        IF @Contador = 1
          SELECT @SELECT3 = @SELECT3 + ',o'+@Alias+'.Nombre+'+CHAR(39)+': '+CHAR(39) +'+ v'+ @Alias +'.Valor +'+CHAR(39)+','+CHAR(39)
        ELSE  
          SELECT @SELECT3 = @SELECT3 + '+ o'+@Alias+'.Nombre+'+CHAR(39)+': '+CHAR(39) +'+v'+ @Alias +'.Valor +'+CHAR(39)+','+CHAR(39)
          
        IF @Contador = 1
          SELECT @SELECT4 = @SELECT4 + ',ISNULL(o'+ @Alias +'.OpcionIntelisis,'+CHAR(39)+CHAR(39)+')+ISNULL(CONVERT(varchar,v'+@Alias+'.NumeroIntelisis),'+CHAR(39)+CHAR(39)+')+'+CHAR(39)+','+CHAR(39)
        ELSE  
          SELECT @SELECT4 = @SELECT4 + '+ISNULL(o'+ @Alias +'.OpcionIntelisis,'+CHAR(39)+CHAR(39)+')+ISNULL(CONVERT(varchar,v'+@Alias+'.NumeroIntelisis),'+CHAR(39)+CHAR(39)+')+'+CHAR(39)+','+CHAR(39)

        IF @Contador = 1
          SELECT @FROM = @FROM + ' INTO WebArtCobinacionTemp FROM WebArtOpcion o' + @Alias + ' JOIN WebArtOpcionValor v' + @Alias + ' ON o' + @Alias + '.VariacionID = v' + @Alias + '.VariacionID AND o' + @Alias + '.ID = v' + @Alias +'.OpcionID '
        ELSE
          SELECT @FROM = @FROM + 'LEFT JOIN WebArtOpcion o' + @Alias + ' ON 1 = 1 JOIN WebArtOpcionValor v' + @Alias + ' ON o' + @Alias + '.VariacionID = v' + @Alias + '.VariacionID AND o' + @Alias + '.ID = v' + @Alias +'.OpcionID '  
        
        IF @Contador = 1
          SELECT @WHERE = @WHERE + ' WHERE o' + @Alias + '.VariacionID = ' + CONVERT(varchar,@IDVariacion) + ' AND o' + @Alias + '.ID = '+ CONVERT(varchar,@ID) + '  '
        ELSE  
          SELECT @WHERE = @WHERE + ' AND o' + @Alias + '.VariacionID = ' + CONVERT(varchar,@IDVariacion) + ' AND o' + @Alias + '.ID = '+ CONVERT(varchar,@ID) + '  '

        SET @Contador = @Contador + 1    
        
        

       FETCH NEXT FROM  crVariacion INTO  @Nombre, @ID--, @Valor
      END
      CLOSE  crVariacion
      DEALLOCATE  crVariacion 
    END  
    
    SELECT @SELECT2 = REVERSE(STUFF(REVERSE(@SELECT2),1,4,''))        
    SELECT @SELECT3 = REVERSE(STUFF(REVERSE(@SELECT3),1,4,''))        
    SELECT @SELECT4 = REVERSE(STUFF(REVERSE(@SELECT4),1,4,''))        
        
    SELECT @SQL = @SELECT + @SELECT2 + ' IDValor '+@SELECT3 +'Opciones '+@SELECT4 +' SubCuenta '+ @FROM + @WHERE  
    --SELECT @SQL 
    EXEC (@SQL)
    IF @@ERROR <> 0 SET @Ok = 1
    
    SET @Contador = 1
    SET @IDTemp2 = 0
    IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCobinacionTemp'))
    UPDATE WebArtCobinacionTemp
       SET @IDTemp2 = ID = @IDTemp2 + 1
    IF @@ERROR <> 0 SET @Ok = 1   
    


    IF @Ok IS NULL AND  EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCobinacionTemp'))
    BEGIN
      DECLARE crVariacion2 CURSOR FAST_FORWARD FOR 
       SELECT IDValor, ID
         FROM WebArtCobinacionTemp
      
      OPEN  crVariacion2
      FETCH NEXT FROM  crVariacion2 INTO  @Valor, @Contador
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        INSERT @Tabla
        SELECT * FROM dbo.fnWebSepararCombinaciones(@Contador,@IDVariacion,@Valor)  
        IF @@ERROR <> 0 SET @Ok = 1  

       FETCH NEXT FROM  crVariacion2 INTO @Valor, @Contador
      END
      CLOSE  crVariacion2
      DEALLOCATE  crVariacion2 
    END  
    IF @Ok IS NULL-- AND NOT EXISTS(SELECT * FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones) IN(SELECT  dbo.fnWebOrdenarCombinacion(IDValor) FROM WebArtCobinacionTemp))
    AND  EXISTS(SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCobinacionTemp'))
    BEGIN
      DECLARE crInsertar CURSOR FAST_FORWARD FOR 
       SELECT IDValor, ID, Opciones, SubCuenta
         FROM WebArtCobinacionTemp
      
      OPEN  crInsertar
      FETCH NEXT FROM  crInsertar INTO  @IDValor, @IDTemp, @Opciones, @SubCuenta
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL  
      BEGIN
        IF NOT EXISTS(SELECT * FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones)= dbo.fnWebOrdenarCombinacion(@IDValor) )
        BEGIN
          SET @IDTabla  = NULL
          
          SELECT @Orden = ISNULL(MAX(Orden),0) FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion
          SELECT @Orden = @Orden +1
          INSERT WebArtVariacionCombinacion(IDArt, IDVariacion,  Activa, IDOpciones, Orden, Opciones, Cantidad, SubCuenta, Articulo)
          SELECT                            @IDArt, @IDVariacion,1,      @IDValor,   @Orden, @Opciones, 1.0, CASE WHEN @TipoOpcion = 'Si' THEN dbo.fnWebOrdenarSubCuenta(@SubCuenta)ELSE NULL END ,CASE WHEN @TipoOpcion = 'Si' THEN @Articulo ELSE NULL END
          IF @@ERROR <> 0 SET @Ok = 1  
          
          SELECT @IDTabla = SCOPE_IDENTITY()
          
          IF @IDTabla IS NOT NULL    AND @Ok IS NULL  
            INSERT WebArtVariacionCombinacionD(ID,      IDArt,  IDVariacion,  IDOpcion, IDValor)
            SELECT                             @IDTabla,@IDArt, @IDVariacion, IDOpcion, IDCombinacion
              FROM @Tabla
             WHERE ID = @IDTemp 
            GROUP BY IDOpcion, IDCombinacion 
          IF @@ERROR <> 0 SET @Ok = 1    

                    
        END
        IF EXISTS(SELECT * FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones)= dbo.fnWebOrdenarCombinacion(@IDValor) ) AND @Ok IS NULL 
          UPDATE WebArtVariacionCombinacion SET IDOpciones = @IDValor WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones)= dbo.fnWebOrdenarCombinacion(@IDValor) 
        IF @@ERROR <> 0 SET @Ok = 1
       FETCH NEXT FROM  crInsertar INTO @IDValor, @IDTemp, @Opciones, @SubCuenta
      END
      CLOSE  crInsertar
      DEALLOCATE  crInsertar   
    END  
    
    IF EXISTS(SELECT * FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones) NOT IN(SELECT  dbo.fnWebOrdenarCombinacion(IDValor) FROM WebArtCobinacionTemp))AND @Ok IS NULL 
      DELETE WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion AND dbo.fnWebOrdenarCombinacion(IDOpciones) NOT IN(SELECT  dbo.fnWebOrdenarCombinacion(IDValor) FROM WebArtCobinacionTemp)
    IF @@ERROR <> 0 SET @Ok = 1
    IF @Ok IS NULL
      DELETE WebArtVariacionCombinacionD WHERE ID NOT IN (SELECT ID FROM WebArtVariacionCombinacion WHERE IDArt = @IDArt AND IDVariacion = @IDVariacion)
    IF @@ERROR <> 0 SET @Ok = 1 
  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Proceso Concluido con Exito'   
  END   
  ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'No Se Pudieron generar Las Combinaciones'
  END  
    
    
  RETURN

END

GO
--spWebArtGenerarCombinaciones  1,3

--select * from WebArtVariacionCombinaciond
--truncate table WebArtVariacionCombinaciond


 /**************** fnWebArtDescripcion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArtDescripcion') DROP FUNCTION fnWebArtDescripcion
GO
CREATE FUNCTION fnWebArtDescripcion 
	(
	@Expresion				varchar(MAX)
	)
RETURNS varchar(MAX)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(MAX),
    @Longitud			bigint,
    @Contador			bigint,
    @Caracter			char(1),
    @Estado				int,
    @EstadoAnterior		int,
    @Variable			varchar(MAX),
    @Valor				varchar(MAX),
    @Tipo				varchar(50),
    @Posicion                   int
    
  SET @Resultado = ''
  SELECT @Expresion = LOWER(@Expresion)    
  --IF NULLIF(@Expresion,'') IS NULL RETURN @Resultado
  --SELECT @Expresion = REVERSE(@Expresion)
  SET @Longitud = LEN(@Expresion)
  SET @Contador = 1
  SET @Estado = 3
  SET @Variable = ''
  
  
  WHILE @Contador <= @Longitud 
  BEGIN

    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)

    IF @Estado IN(0,3) AND @Caracter IN('',' ')   SET @Estado = 1 

    IF @Estado = 0
    BEGIN
      SET @Variable = @Variable + @Caracter
    END     
    IF @Estado = 3
    BEGIN
      SET @Variable = @Variable + UPPER(@Caracter)
      SET @Estado = 0
    END      
    IF @Estado = 1
    BEGIN
      SET @Variable = @Variable + @Caracter
      SET @Estado = 3
    END      
     
    
    SET @Contador = @Contador + 1
  END  

   
  RETURN (@Variable)
END
GO


/**************** fnWebArtQuitarTags ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArtQuitarTags') DROP FUNCTION fnWebArtQuitarTags
GO
CREATE FUNCTION fnWebArtQuitarTags 
	(@Texto    varchar(MAX),@Tag  varchar(255))
RETURNS varchar(MAX)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  varchar(MAX),
  @Resultado2  varchar(MAX),
  @Longitud   int,
  @Desde      int,
  @Hasta      int,
  @Ntag       int,
  @Tag2       varchar(255)

  IF @Texto IS NULL OR @Tag IS NULL RETURN @Resultado
  IF CHARINDEX(@Tag,@Texto)=0 RETURN @Texto
  SELECT @Ntag = LEN(@Tag)-1
  SELECT @Desde = CHARINDEX(@Tag,@Texto)
  SELECT @Resultado= REPLACE(@Texto,SUBSTRING(@Texto,1,@Desde+@Ntag),'')
  SELECT @Tag2 = REPLACE(@Tag,'<','</')
  SELECT @Hasta = CHARINDEX(@Tag2,@Resultado)
  SELECT @Longitud = LEN(@Resultado)
  SELECT @Resultado2 =REPLACE(@Resultado,SUBSTRING(@Resultado,@Hasta,@Longitud),'')
     
  RETURN(@Resultado2)
END
GO



--SELECT dbo.fnWebArtDescripcion('descripcion articulo web sin opciones')
/**************** fneWebDescripcionHTML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebDescripcionHTML') DROP FUNCTION fneWebDescripcionHTML
GO
CREATE FUNCTION fneWebDescripcionHTML 
	(
	@Descripcion				varchar(MAX)
	)
RETURNS varchar(MAX)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Seccion			varchar(MAX),
  @Estado			int,
  @EstadoAnterior	        int,
  @Expresion			varchar(MAX)

  
  IF NULLIF(@Descripcion,'') IS NULL RETURN (@Seccion)
  
  SELECT @Expresion = WebArtDescripcion FROM WebVersion
  SELECT @Expresion= ISNULL(@Expresion,' ')
  SELECT @Longitud = LEN(@Expresion), @Contador = 1, @Caracter = NULL, @Seccion = '', @Estado = 0
  SELECT @Descripcion = ISNULL(dbo.fnWebArtDescripcion(LTRIM(RTRIM(@Descripcion))),'')
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Expresion,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '{'         THEN 1
      WHEN @Estado = 2 AND @Caracter = '}'         THEN 0
      --WHEN @Estado = 2 AND @Caracter = '}'         THEN 0
      ELSE @Estado
    END


    IF @Estado = 1
    BEGIN
      SET @Seccion = @Seccion + @Caracter
      SET @Estado = 2
    END
    IF @Estado = 0
    BEGIN
      SET @Seccion = @Seccion + @Caracter
    END

    SET @Contador = @Contador + 1
  END
  SELECT @Seccion = REPLACE(@Seccion,'{}',@Descripcion)
  
  SELECT @Seccion = dbo.fnWebArtQuitarTags(@Seccion,'<BODY>')

  SELECT @Seccion = LTRIM(RTRIM(@Seccion))     
  RETURN(@Seccion)
END
GO


/**************** spWebArtsugerirDescripcionHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtsugerirDescripcionHTML') and type = 'P') drop procedure dbo.spWebArtsugerirDescripcionHTML
GO             
CREATE PROCEDURE spWebArtsugerirDescripcionHTML
		    @Articulo            varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Descripcion varchar(MAX),
    @Temp1     varchar(255),
    @Temp2     varchar(255),
    @Temp3     varchar(255),
    @Temp4     varchar(255),
    @Temp5     varchar(255),
    @Temp6     varchar(255),
    @Temp7     varchar(255),
    @Temp8     varchar(255),
    @Temp9     varchar(255),
    @Temp10    varchar(255),
    @Inicio    int,
    @Fin       int
    

  SELECT @Descripcion = Comentario FROM AnexoCta WHERE Rama = 'INV' AND Cuenta = @Articulo
  
  IF @Descripcion IS NULL
    SELECT @Descripcion = Descripcion1 FROM Art WHERE Articulo = @Articulo 
    
  SELECT @Descripcion = ISNULL(@Descripcion,'')
  
  SELECT @Descripcion = dbo.fneWebDescripcionHTML(SUBSTRING(@Descripcion,1,2559))
  
  SELECT @Temp1 = SUBSTRING(@Descripcion,1,255)
  SELECT @Temp2 = SUBSTRING(@Descripcion,256,511)
  SELECT @Temp3 = SUBSTRING(@Descripcion,512,767)
  SELECT @Temp4 = SUBSTRING(@Descripcion,768,1023)
  SELECT @Temp5 = SUBSTRING(@Descripcion,1024,1279)
  SELECT @Temp6 = SUBSTRING(@Descripcion,1280,1535) 
  SELECT @Temp7 = SUBSTRING(@Descripcion,1536,1791)  
  SELECT @Temp8 = SUBSTRING(@Descripcion,1792,2047)  
  SELECT @Temp9 = SUBSTRING(@Descripcion,2048,2303)  
  SELECT @Temp10 = SUBSTRING(@Descripcion,2304,2559)
 
 SELECT RTRIM(ISNULL(@Temp1,'')),LTRIM(RTRIM(ISNULL(@Temp2,''))), LTRIM(RTRIM(ISNULL(@Temp3,''))), LTRIM(RTRIM(ISNULL(@Temp4,''))), LTRIM(RTRIM(ISNULL(@Temp5,''))),LTRIM(RTRIM(ISNULL(@Temp6,''))), LTRIM(RTRIM(ISNULL(@Temp7,'')))  , LTRIM(RTRIM(ISNULL(@Temp8,''))), LTRIM(RTRIM(ISNULL(@Temp9,'')))  ,LTRIM(RTRIM(ISNULL(@Temp10,'')))      
END
GO


/**************** spWebArtInsertarWebCatArt_Art ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarWebCatArt_Art') and type = 'P') drop procedure dbo.spWebArtInsertarWebCatArt_Art
GO             
CREATE PROCEDURE spWebArtInsertarWebCatArt_Art
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CategoriaID     int,
    @Columns         varchar(255),
    @Categoria1      int
    
 INSERT WebCatArt_Art(IDWebArt, IDWebCatArt, Orden, Nombre) 
 SELECT               @IDArt,   ID         ,0,      Nombre
   FROM WebCatArt WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)    
    

END
GO


/**************** spWebArtInsertarWebCatArt_Art2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarWebCatArt_Art2') and type = 'P') drop procedure dbo.spWebArtInsertarWebCatArt_Art2
GO             
CREATE PROCEDURE spWebArtInsertarWebCatArt_Art2
		    @Estacion        int,
		    @IDArt           int,
		    @IDCat           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CategoriaID     int,
    @Columns         varchar(255),
    @Categoria1      int
    
 IF NOT EXISTS(SELECT * FROM WebCatArtTemp WHERE Estacion = @Estacion AND ID = @IDCat   AND IDArt = @IDArt)
 INSERT WebCatArtTemp(Estacion, ID,IDArt,Nombre) 
 SELECT              @Estacion,@IDCat, @IDArt,Nombre
   FROM WebCatArt WHERE ID =@IDCat  
    

END
GO


/**************** spWebArtInsertarWebCatArt_Art3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtInsertarWebCatArt_Art3') and type = 'P') drop procedure dbo.spWebArtInsertarWebCatArt_Art3
GO             
CREATE PROCEDURE spWebArtInsertarWebCatArt_Art3
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CategoriaID     int,
    @Columns         varchar(255),
    @Categoria1      int

INSERT WebCatArt_Art(IDWebArt, IDWebCatArt, Orden, Nombre) 
 SELECT               IDArt,   ID         ,0,      Nombre
   FROM WebCatArtTemp
  WHERE Estacion = @Estacion   
    AND ID NOT IN (SELECT IDWebCatArt FROM WebCatArt_Art  WHERE IDWebArt = @IDArt)
    

END
GO



/**************** spWebArtBorrarWebCatArtTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtBorrarWebCatArtTemp') and type = 'P') drop procedure dbo.spWebArtBorrarWebCatArtTemp
GO             
CREATE PROCEDURE spWebArtBorrarWebCatArtTemp
		    @Estacion        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @CategoriaID     int
    
  DELETE WebCatArtTemp
   WHERE Estacion = @Estacion
    

END
GO



/**************** fneWebVerificarOpcion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebVerificarOpcion') DROP FUNCTION fneWebVerificarOpcion
GO
CREATE FUNCTION fneWebVerificarOpcion 
	()
RETURNS bit

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  bit

  SET @Resultado = 0
  IF EXISTS(SELECT * FROM Opcion)SET @Resultado = 1

     
  RETURN(@Resultado)
END
GO
--SELECT dbo.fneWebVerificarOpcion()


/**************** fneWebVerificarWebCatArt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebVerificarWebCatArt') DROP FUNCTION fneWebVerificarWebCatArt
GO
CREATE FUNCTION fneWebVerificarWebCatArt 
	(@ID   int)
RETURNS varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  varchar(255)

  SET @Resultado = NULL
  IF EXISTS(SELECT * FROM WebCatArt WHERE ID = @ID AND ID IN(SELECT Rama FROM WebCatArt))SET @Resultado = 'Tiene Descendientes, No se Puede Eliminar'
  IF EXISTS(SELECT * FROM WebCatArt_Art WHERE IDWebCatArt = @ID )SET @Resultado = 'Tiene Articulos Asociados, No se Puede Eliminar'

     
  RETURN(@Resultado)
END
GO
--SELECT dbo.fneWebVerificarWebCatArt(11)

/**************** fneWebVerificarWebArtVariacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebVerificarWebArtVariacion') DROP FUNCTION fneWebVerificarWebArtVariacion
GO
CREATE FUNCTION fneWebVerificarWebArtVariacion 
	(@ID   int)
RETURNS varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  varchar(255)

  SET @Resultado = NULL
  IF EXISTS(SELECT * FROM WebArt WHERE VariacionID = @ID )SET @Resultado = 'Tiene Articulos Asociados, No se Puede Eliminar'

     
  RETURN(@Resultado)
END
GO
--SELECT dbo.fneWebVerificarWebArtVariacion(1)

/**************** fneWebVerificarWebArtMarca ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebVerificarWebArtMarca') DROP FUNCTION fneWebVerificarWebArtMarca
GO
CREATE FUNCTION fneWebVerificarWebArtMarca 
	(@ID   int)
RETURNS varchar(255)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  varchar(255)

  SET @Resultado = NULL
  IF EXISTS(SELECT * FROM WebArt WHERE MarcaID = @ID )SET @Resultado = 'Tiene Articulos Asociados, No se Puede Eliminar'

     
  RETURN(@Resultado)
END
GO
--SELECT dbo.fneWebVerificarWebArtMarca(1)



/**************** spWebSucursalDescripcionHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebSucursalDescripcionHTML') and type = 'P') drop procedure dbo.spWebSucursalDescripcionHTML
GO             
CREATE PROCEDURE spWebSucursalDescripcionHTML
                    @Sucursal           int,
                    @NombreImagen       varchar(255),
		    @Path               varchar(255),
		    @Nombre             varchar(255)
		    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  
 UPDATE WebSucursalImagen SET Descripcion = CONVERT(text,dbo.fnWebArtQuitarTags(dbo.fneDocInLeerArchivo(@Path,@Nombre),'<BODY>')) 
  WHERE Nombre = @NombreImagen AND  Sucursal = @Sucursal
END
GO


--spWebSucursalDescripcionHTML 0.0,'0_Imagen1','C:\Entrada','1_0_Imagen1.HTML'


/**************** spWebArtActualizarHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtActualizarHTML') and type = 'P') drop procedure dbo.spWebArtActualizarHTML
GO             
CREATE PROCEDURE spWebArtActualizarHTML
		    @ID        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  UPDATE WebArt SET DescripcionHTML = dbo.fnWebArtQuitarTags(DescripcionHTML,'<BODY>')
  WHERE ID = @ID

END
GO

/**************** spWebSucActualizarHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebSucActualizarHTML') and type = 'P') drop procedure dbo.spWebSucActualizarHTML
GO             
CREATE PROCEDURE spWebSucActualizarHTML
		    @Sucursal       int,
		    @Nombre         varchar(50)
--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  UPDATE WebSucursalImagen SET Descripcion = dbo.fnWebArtQuitarTags(Descripcion,'<BODY>')
  WHERE Sucursal= @Sucursal AND Nombre = @Nombre
END
GO



/**************** spWebArtReGenerarCombinaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtReGenerarCombinaciones') and type = 'P') drop procedure dbo.spWebArtReGenerarCombinaciones
GO             
CREATE PROCEDURE spWebArtReGenerarCombinaciones
		    @ID        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE 
  @IDArt          int,
  @Ok             int
  
  BEGIN TRANSACTION  
  
  IF EXISTS(SELECT * FROM WebArt WHERE VariacionID = @ID)
  BEGIN  
    DECLARE crArticulo CURSOR FAST_FORWARD FOR 
     SELECT VariacionID
       FROM WebArt
      WHERE  VariacionID = @ID
        
    OPEN  crArticulo
    FETCH NEXT FROM  crArticulo INTO  @IDArt
    WHILE @@FETCH_STATUS = 0 
    BEGIN
      EXEC spWebArtGenerarCombinaciones @IDArt, @ID, @Ok OUTPUT
      
     FETCH NEXT FROM  crArticulo INTO @IDArt
    END
    CLOSE  crArticulo
    DEALLOCATE  crArticulo  
  END  
    
  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Proceso Concluido con Exito'   
  END   
  ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'No Se Pudieron generar Las Combinaciones'
  END  

  RETURN

END
GO

/**************** spWebArtBorrarAtributosTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtBorrarAtributosTemp') and type = 'P') drop procedure dbo.spWebArtBorrarAtributosTemp
GO             
CREATE PROCEDURE spWebArtBorrarAtributosTemp
		    @Estacion        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DELETE WebArtAtributosCatTemp WHERE Estacion = @Estacion
    

END
GO

/**************** spWebArtBorrarCamposConfigurablesTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtBorrarCamposConfigurablesTemp') and type = 'P') drop procedure dbo.spWebArtBorrarCamposConfigurablesTemp
GO             
CREATE PROCEDURE spWebArtBorrarCamposConfigurablesTemp
		    @Estacion        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DELETE WebArtCamposConfigurablesCatTemp WHERE Estacion = @Estacion
    

END
GO




/**************** spWebArtImportarCamposConfigurablesTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtImportarCamposConfigurablesTemp') and type = 'P') drop procedure dbo.spWebArtImportarCamposConfigurablesTemp
GO             
CREATE PROCEDURE spWebArtImportarCamposConfigurablesTemp
		    @Estacion        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Tipo   varchar(50),
  @Ok     int
  
  SELECT @Tipo = Tipo FROM WebArtCamposConfigurablesCatTemp WHERE Estacion = @Estacion
  
  DELETE WebArtCamposConfigurablesCatDTemp WHERE Estacion = @Estacion
  INSERT WebArtCamposConfigurablesCatDTemp(Estacion,Tipo,Nombre,TipoCampo)
  SELECT                                  @Estacion,@Tipo,Nombre, TipoCampo
    FROM WebArtCamposConfigurablesCatD
   WHERE Tipo = @Tipo

END
GO


 --spWebArtImportarCamposConfigurablesTemp 1
/**************** spWebArtImportarAtributosTemp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtImportarAtributosTemp') and type = 'P') drop procedure dbo.spWebArtImportarAtributosTemp
GO             
CREATE PROCEDURE spWebArtImportarAtributosTemp
		    @Estacion        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Tipo   varchar(50),
  @Ok     int
  
  SELECT @Tipo = Tipo FROM WebArtAtributosCatTemp WHERE Estacion = @Estacion
  
  DELETE WebArtAtributosCatDTemp WHERE Estacion = @Estacion
  INSERT WebArtAtributosCatDTemp(Estacion,  Tipo,  Nombre, Valor)
  SELECT                         @Estacion, @Tipo, Nombre, Valor
    FROM WebArtAtributosCatD
   WHERE Tipo = @Tipo

END
GO

/**************** spWebArtImportarAtributos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtImportarAtributos') and type = 'P') drop procedure dbo.spWebArtImportarAtributos
GO             
CREATE PROCEDURE spWebArtImportarAtributos
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
   @Nombre           varchar(255),
   @Valor            varchar(255),
   @Ok               int
  
  DELETE WebArtAtributos WHERE IDArt = @IDArt
  DECLARE crArt CURSOR FOR
   SELECT Nombre,  Valor
     FROM WebArtAtributosCatDTemp
    WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  OPEN crArt 
  FETCH NEXT FROM crArt INTO @Nombre,  @Valor
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM WebArtAtributos WHERE IDArt = @IDArt AND Valor = @Valor AND Nombre = @Nombre)
      INSERT WebArtAtributos(IDArt,  Nombre,  Valor)
      SELECT                 @IDArt, @Nombre, @Valor
    
    IF @@ERROR <> 0 SET @Ok = 1  
    FETCH NEXT FROM crArt INTO @Nombre,  @Valor
  END
  CLOSE crArt
  DEALLOCATE crArt  

END
GO


/**************** spWebArtAgregarAtributos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtAgregarAtributos') and type = 'P') drop procedure dbo.spWebArtAgregarAtributos
GO             
CREATE PROCEDURE spWebArtAgregarAtributos
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
   @Nombre           varchar(255),
   @Valor            varchar(255),
   @Ok               int
  
  DECLARE crArt CURSOR FOR
   SELECT Nombre,  Valor
     FROM WebArtAtributosCatDTemp
    WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  OPEN crArt 
  FETCH NEXT FROM crArt INTO @Nombre,  @Valor
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM WebArtAtributos WHERE IDArt = @IDArt AND Valor = @Valor AND Nombre = @Nombre)
      INSERT WebArtAtributos(IDArt,  Nombre,  Valor)
      SELECT                 @IDArt, @Nombre, @Valor
    
    IF @@ERROR <> 0 SET @Ok = 1  
    FETCH NEXT FROM crArt INTO @Nombre,  @Valor
  END
  CLOSE crArt
  DEALLOCATE crArt  

END
GO


/**************** spWebArtImportarCamposConfigurables ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtImportarCamposConfigurables') and type = 'P') drop procedure dbo.spWebArtImportarCamposConfigurables
GO             
CREATE PROCEDURE spWebArtImportarCamposConfigurables
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Tipo   varchar(50),
  @Nombre varchar(255),  
  @TipoCampo varchar(255),
  @ID     int,
  @Ok     int
  
 DELETE WebArtCamposConfigurables WHERE ID = @IDArt
 
  
  DECLARE crArt CURSOR FOR
   SELECT Nombre,  TipoCampo, Tipo
     FROM WebArtCamposConfigurablesCatDTemp
    WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  OPEN crArt 
  FETCH NEXT FROM crArt INTO @Nombre,  @TipoCampo, @Tipo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM WebArtCamposConfigurables WHERE IDArt = @IDArt AND TipoCampo = @TipoCampo AND Nombre = @Nombre)  
    INSERT WebArtCamposConfigurables(IDArt, Nombre, TipoCampo, Requerido, Orden)
    SELECT                          @IDArt,@Nombre,  @TipoCampo, 0,0
    IF @@ERROR <> 0 SET @Ok = 1
    SELECT @ID = SCOPE_IDENTITY()

    IF @TipoCampo =  'Menú de selección' AND @ID IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM WebArtCamposConfigurablesD WHERE ID = @ID)
      INSERT WebArtCamposConfigurablesD (ID, Valor, Orden)
      SELECT                             @ID,Valor,0
        FROM WebArtCamposConfigurablesCatDD 
       WHERE   Tipo = @Tipo AND Nombre = @Nombre
    END  
    IF @@ERROR <> 0 SET @Ok = 1  
    FETCH NEXT FROM crArt INTO @Nombre,  @TipoCampo, @Tipo
  END
  CLOSE crArt
  DEALLOCATE crArt
 

END
GO


/**************** spWebArtAgregarCamposConfigurables ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebArtAgregarCamposConfigurables') and type = 'P') drop procedure dbo.spWebArtAgregarCamposConfigurables
GO             
CREATE PROCEDURE spWebArtAgregarCamposConfigurables
		    @Estacion        int,
		    @IDArt           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Tipo   varchar(50),
  @Nombre varchar(255),  
  @TipoCampo varchar(255),
  @ID     int,
  @Ok     int
  
 
  DECLARE crArt CURSOR FOR
   SELECT Nombre,  TipoCampo, Tipo
     FROM WebArtCamposConfigurablesCatDTemp
    WHERE ID IN (SELECT ID FROM ListaID WHERE Estacion = @Estacion)
  OPEN crArt 
  FETCH NEXT FROM crArt INTO @Nombre,  @TipoCampo, @Tipo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM WebArtCamposConfigurables WHERE IDArt = @IDArt AND TipoCampo = @TipoCampo AND Nombre = @Nombre)  
    INSERT WebArtCamposConfigurables(IDArt, Nombre, TipoCampo, Requerido, Orden)
    SELECT                          @IDArt,@Nombre,  @TipoCampo, 0,0
    IF @@ERROR <> 0 SET @Ok = 1
    SELECT @ID = SCOPE_IDENTITY()

    IF @TipoCampo =  'Menú de selección' AND @ID IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM WebArtCamposConfigurablesD WHERE ID = @ID)
      INSERT WebArtCamposConfigurablesD (ID, Valor, Orden)
      SELECT                             @ID,Valor,0
        FROM WebArtCamposConfigurablesCatDD 
       WHERE   Tipo = @Tipo AND Nombre = @Nombre
    END  
    IF @@ERROR <> 0 SET @Ok = 1  
    FETCH NEXT FROM crArt INTO @Nombre,  @TipoCampo, @Tipo
  END
  CLOSE crArt
  DEALLOCATE crArt
 

END
GO

/**************** fneWebConvertirDescripcionHTML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebConvertirDescripcionHTML') DROP FUNCTION fneWebConvertirDescripcionHTML
GO
CREATE FUNCTION fneWebConvertirDescripcionHTML 
	(@Texto   varchar(MAX))
RETURNS varchar(MAX)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  varchar(MAX)

  SELECT @Resultado = REPLACE(LTRIM(RTRIM(@Texto)),'&','&#038;')
  SELECT @Resultado = REPLACE(REPLACE(REPLACE(REPLACE(@Resultado,'<','&#060;'),'>','&#062;'),CHAR(34),'&#034;'),'=','&#061;')

     
  RETURN(@Resultado)
END
GO



--SELECT dbo.fneWebConvertirDescripcionHTML('  <P><FONT color=#ff0000><STRONG><U>S</U></STRONG>illon</FONT> Piel   Negro</P>')


/**************** fnFechaSinHora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaSinHora' AND type = 'FN') DROP FUNCTION fnFechaSinHora
GO
CREATE FUNCTION fnFechaSinHora (@Fecha	datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  RETURN (DATEADD(ms, -DATEPART(ms, @Fecha), DATEADD(ss, -DATEPART(ss, @Fecha), DATEADD(mi, -DATEPART(mi, @Fecha), DATEADD(hh, -DATEPART(hh, @Fecha), @Fecha)))))
END
GO



/**************** fnWebArtSKU ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArtSKU') DROP FUNCTION  dbo.fnWebArtSKU 
GO
CREATE FUNCTION dbo.fnWebArtSKU 
	(
	@SKU        varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud    int,
  @Posicion    int,
  @Resultado   varchar(255)
  
  SELECT @Longitud = LEN(@SKU)
  SELECT @Posicion = CHARINDEX('#',@SKU,1)
  
  IF   @Posicion > 0
    SELECT @Resultado = SUBSTRING(@SKU,@Posicion +1,@Longitud)
  ELSE   
    SELECT @Resultado = @SKU
  RETURN (@Resultado)
END
GO

/**************** fnWebSKUArticuloSubCuenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebSKUArticuloSubCuenta') DROP FUNCTION  dbo.fnWebSKUArticuloSubCuenta 
GO
CREATE FUNCTION dbo.fnWebSKUArticuloSubCuenta 
	(
	@SKU        varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado   varchar(255),
  @Tipo        varchar(50)
  
      IF @SKU LIKE 'IDCO#%'
      SELECT   @Tipo = 'Combinacion'
    IF @SKU LIKE 'ID#%'
      SELECT   @Tipo = 'WebArt'  
      
    IF @Tipo = 'Combinacion'
      SELECT @Resultado =  ISNULL(SubCuenta,'')
        FROM WebArtVariacionCombinacion WHERE ID = dbo.fnWebArtSKU (@SKU)
      
    IF @Tipo = 'WebArt'
      SELECT @Resultado = ISNULL(SubCuenta,'')
        FROM WebArt WHERE ID = dbo.fnWebArtSKU (@SKU)      
      
    IF @Tipo IS NULL
      SELECT @Resultado = ISNULL(SubCuenta,'') 
        FROM CB WHERE Codigo= @SKU 
  
    IF ISNULL(@Resultado, '') = ''
		SELECT @Resultado = SubCuenta
			FROM WebArt WHERE SKU = @SKU

    IF ISNULL(@Resultado, '') = ''
		SELECT @Resultado = SubCuenta
			FROM WebArtVariacionCombinacion WHERE SKU = @SKU
			
  RETURN (@Resultado)
END
GO

/**************** fnWebSKUArticulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebSKUArticulo') DROP FUNCTION  dbo.fnWebSKUArticulo 
GO
CREATE FUNCTION dbo.fnWebSKUArticulo 
	(
	@SKU        varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado   varchar(255),
  @Tipo        varchar(50)
  
      IF @SKU LIKE 'IDCO#%'
      SELECT   @Tipo = 'Combinacion'
    IF @SKU LIKE 'ID#%'
      SELECT   @Tipo = 'WebArt'  
      
    IF @Tipo = 'Combinacion'
      SELECT @Resultado = Articulo
        FROM WebArtVariacionCombinacion WHERE ID = dbo.fnWebArtSKU (@SKU)
      
    IF @Tipo = 'WebArt'
      SELECT @Resultado = Articulo
        FROM WebArt WHERE ID = dbo.fnWebArtSKU (@SKU)      
      
    IF @Tipo IS NULL
      SELECT @Resultado = Cuenta
        FROM CB WHERE Codigo= @SKU 
        
    IF ISNULL(@Resultado, '') = ''
		SELECT @Resultado = Articulo
			FROM WebArt WHERE SKU = @SKU

    IF ISNULL(@Resultado, '') = ''
		SELECT @Resultado = Articulo
			FROM WebArtVariacionCombinacion WHERE SKU = @SKU  

  RETURN (@Resultado)
END
GO
/**************** fnWebArticuloCR ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArticuloCR') DROP FUNCTION  dbo.fnWebArticuloCR 
GO
CREATE FUNCTION dbo.fnWebArticuloCR 
	(
	@Sucursal	int,
	@Monto	float
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado	varchar(255),
  @Modo			varchar(20)
  
  SELECT @Modo = eCommerceCRModo FROM Sucursal WHERE Sucursal = @Sucursal
  
  IF (@Modo = 'No')
	SELECT @Resultado = ''
  ELSE IF (@Modo = 'Lista')
	SELECT @Resultado = ISNULL(Articulo, '') FROM WebCertificadosRegalo
		WHERE Monto = @Monto
  ELSE IF (@Modo = 'Personalizable')
	SELECT @Resultado = eCommerceCRArticulo FROM Sucursal WHERE Sucursal = @Sucursal
  ELSE 
	SELECT @Resultado = ''

  RETURN (@Resultado)
END
GO

/**************** fnWebSubCuentaCR ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebSubCuentaCR') DROP FUNCTION  dbo.fnWebSubCuentaCR 
GO
CREATE FUNCTION dbo.fnWebSubCuentaCR 
	(
	@Sucursal	int,
	@Monto	float
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado	varchar(255),
  @Modo			varchar(20)
  
  SELECT @Modo = eCommerceCRModo FROM Sucursal WHERE Sucursal = @Sucursal
  
  IF (@Modo = 'No')
	SELECT @Resultado = ''
  ELSE IF (@Modo = 'Lista')
	SELECT @Resultado = ISNULL(SubCuenta, '') FROM WebCertificadosRegalo
		WHERE Monto = @Monto
  ELSE 
	SELECT @Resultado = ''

  RETURN (@Resultado)
END
GO

/**************** fneCommerceOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneCommerceOrigen') DROP FUNCTION fneCommerceOrigen
GO
CREATE FUNCTION dbo.fneCommerceOrigen(@Modulo  varchar(5), @ID  int, @Nivel  int) 
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado   bit,
    @OModulo     varchar(5), 
    @OID         int ,
    @Tipo        varchar(20)
    

  SET @Resultado = 0  
 
    
  
    SELECT @OModulo = mf.OModulo, @OID = mf.OID
      FROM MovFLujo mf
     WHERE DModulo = @Modulo AND DID = @ID
     
    IF @Modulo = 'VTAS'
      IF EXISTS(SELECT * FROM Venta WHERE ID = @OID AND OrigenTipo = 'eCommerce')
        SELECT @Resultado = 1 
     
     IF ISNULL(@Resultado,0) = 0 AND @Nivel < 15
     BEGIN
       SET @Nivel = @Nivel + 1
       SELECT @Resultado = dbo.fneCommerceOrigen(@OModulo, @OID,@Nivel)     
       
     END
     
    IF @Modulo = 'VTAS' 
      IF EXISTS(SELECT * FROM Venta WHERE ID = @ID AND OrigenTipo = 'eCommerce')  
        SELECT @Resultado = 1       
         
                          
  RETURN (@Resultado)
 END

GO

--SELECT dbo.fneCommerceOrigen('DIN',8,1)



/**************** fneCommerceIDOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneCommerceIDOrigen') DROP FUNCTION fneCommerceIDOrigen
GO
CREATE FUNCTION dbo.fneCommerceIDOrigen(@Modulo  varchar(5), @ID  int, @Nivel  int) 
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado   int,
    @OModulo     varchar(5), 
    @OID         int ,
    @Tipo        varchar(20)
    

  SET @Resultado = NULL  
 
    
  
    SELECT @OModulo = mf.OModulo, @OID = mf.OID
      FROM MovFLujo mf
     WHERE DModulo = @Modulo AND DID = @ID
     
    IF @Modulo = 'VTAS'
      IF EXISTS(SELECT * FROM Venta WHERE ID = @OID AND OrigenTipo = 'eCommerce')
        SELECT @Resultado = @OID
        
    IF @Modulo = 'VTAS' 
      IF EXISTS(SELECT * FROM Venta WHERE ID = @ID AND OrigenTipo = 'eCommerce')  
        SELECT @Resultado = @ID         
     
     IF @Resultado IS NULL AND @Nivel <15
     BEGIN
       SET @Nivel = @Nivel + 1
       SELECT @Resultado = dbo.fneCommerceIDOrigen(@OModulo, @OID,@Nivel)     
       
     END
                   
  RETURN (@Resultado)
 END

GO

--SELECT dbo.fneCommerceIDOrigen('DIN',8,1)

/************** xpeCommerceCambiarSituacion *************/
if exists (select * from sysobjects where id = object_id('dbo.xpeCommerceCambiarSituacion') and type = 'P') drop procedure dbo.xpeCommerceCambiarSituacion
GO
CREATE PROCEDURE xpeCommerceCambiarSituacion
                   @Modulo              char(5),
                   @ID                  int,
                   @Situacion           char(50),
                   @SituacionFecha      datetime,
                   @Usuario             char(10),
                   @SituacionUsuario    varchar(10) = NULL,
                   @SituacionNota       varchar(100) = NULL
AS BEGIN

DECLARE
 @eCommerce   bit,
 @OrigenID    int ,
 @Sucursal    int,
 @Mov         varchar(20),
 @MovID       varchar(20),
 @Estatus     varchar(15),
 @eCommerceSucursal varchar(20)
 
 
 
 SELECT @eCommerce = dbo.fneCommerceOrigen(@Modulo,@ID,1) 
 
 IF ISNULL(@eCommerce,0) = 1
 
 AND EXISTS (SELECT * FROM WebSituacionEstatus w WHERE w.Modulo = @Modulo AND -- w.SituacionEcomerce IS NOT NULL AND
   w.Mov = CASE   WHEN @Modulo = 'CONT' THEN (SELECT Mov FROM  Cont        WHERE ID = @ID) 
   WHEN @Modulo = 'VTAS' THEN (SELECT Mov FROM  Venta       WHERE ID = @ID) 
   WHEN @Modulo = 'PROD' THEN (SELECT Mov FROM  Prod        WHERE ID = @ID) 
   WHEN @Modulo = 'COMS' THEN (SELECT Mov FROM  Compra      WHERE ID = @ID) 
   WHEN @Modulo = 'INV'  THEN (SELECT Mov FROM  Inv         WHERE ID = @ID) 
   WHEN @Modulo = 'CXC'  THEN (SELECT Mov FROM  Cxc         WHERE ID = @ID) 
   WHEN @Modulo = 'CXP'  THEN (SELECT Mov FROM  Cxp         WHERE ID = @ID) 
   WHEN @Modulo = 'AGENT'THEN (SELECT Mov FROM  Agent       WHERE ID = @ID) 
   WHEN @Modulo = 'GAS'  THEN (SELECT Mov FROM  Gasto       WHERE ID = @ID) 
   WHEN @Modulo = 'DIN'  THEN (SELECT Mov FROM  Dinero      WHERE ID = @ID) 
   WHEN @Modulo = 'EMB'  THEN (SELECT Mov FROM  Embarque    WHERE ID = @ID) 
   WHEN @Modulo = 'NOM'  THEN (SELECT Mov FROM  Nomina      WHERE ID = @ID) 
   WHEN @Modulo = 'RH'   THEN (SELECT Mov FROM  RH          WHERE ID = @ID) 
   WHEN @Modulo = 'ASIS' THEN (SELECT Mov FROM  Asiste      WHERE ID = @ID) 
   WHEN @Modulo = 'AF'   THEN (SELECT Mov FROM  ActivoFijo  WHERE ID = @ID) 
   WHEN @Modulo = 'PC'   THEN (SELECT Mov FROM  PC          WHERE ID = @ID) 
   WHEN @Modulo = 'VALE' THEN (SELECT Mov FROM  Vale        WHERE ID = @ID) 
   WHEN @Modulo = 'ST'   THEN (SELECT Mov FROM  Soporte     WHERE ID = @ID) 
   WHEN @Modulo = 'CAM'  THEN (SELECT Mov FROM  Cambio      WHERE ID = @ID) END
   )
 BEGIN
   DECLARE crSucursal CURSOR local FOR
    SELECT Sucursal, eCommerceSucursal
      FROM Sucursal
     WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
   OPEN crSucursal
   FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
   WHILE @@FETCH_STATUS = 0 
   BEGIN
   
     SELECT @OrigenID = ISNULL(dbo.fneCommerceIDOrigen(@Modulo,@ID,1),@ID)
     EXEC spMovInfo @ID, @Modulo, @Mov = @Mov OUTPUT, @MovID = @MovID OUTPUT, @Estatus = @Estatus OUTPUT
         
     EXEC speCommerceSolicitudISWebMovSituacion @OrigenID,@Modulo,@ID, @Estatus, @Sucursal, @eCommerceSucursal
     
     FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
   END
   CLOSE crSucursal
   DEALLOCATE crSucursal  
 

 END

   RETURN
END
GO



/**************** spMovInfo2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovInfo2') and type = 'P') drop procedure dbo.spMovInfo2
GO
CREATE PROCEDURE spMovInfo2
                        @ID		int,
			@Modulo		char(5),

			@Sucursal	int 		OUTPUT,
			@Mov		char(20) 	OUTPUT,
			@MovID		varchar(20) 	OUTPUT,
			@Situacion	varchar(50) 	OUTPUT
WITH ENCRYPTION
AS BEGIN
  SELECT @Sucursal = NULL, @Mov = NULL, @MovID = NULL, @Situacion = NULL

  IF @Modulo = 'CONT'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Cont       WHERE ID = @ID ELSE
  IF @Modulo = 'VTAS'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Venta      WHERE ID = @ID ELSE
  IF @Modulo = 'PROD'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Prod       WHERE ID = @ID ELSE
  IF @Modulo = 'INV'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Inv        WHERE ID = @ID ELSE
  IF @Modulo = 'COMS'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Compra     WHERE ID = @ID ELSE
  IF @Modulo = 'CXC'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Cxc        WHERE ID = @ID ELSE
  IF @Modulo = 'CXP'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Cxp        WHERE ID = @ID ELSE
  IF @Modulo = 'AGENT' SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Agent      WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Gasto      WHERE ID = @ID ELSE
  IF @Modulo = 'DIN'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Dinero     WHERE ID = @ID ELSE
  IF @Modulo = 'AF'    SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM ActivoFijo WHERE ID = @ID ELSE
  IF @Modulo = 'PC'    SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM PC         WHERE ID = @ID ELSE
  IF @Modulo = 'VALE'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Vale       WHERE ID = @ID ELSE
  IF @Modulo = 'NOM'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Nomina     WHERE ID = @ID ELSE
  IF @Modulo = 'RH'    SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM RH         WHERE ID = @ID ELSE
  IF @Modulo = 'ASIS'  SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion FROM Asiste     WHERE ID = @ID ELSE
  IF @Modulo = 'EMB'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion  FROM Embarque   WHERE ID = @ID ELSE
  IF @Modulo = 'ST'    SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion  FROM Soporte    WHERE ID = @ID ELSE
  IF @Modulo = 'CAM'   SELECT @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Situacion = Situacion  FROM Cambio     WHERE ID = @ID 
  RETURN
END
GO


/**************** speCommerceHerrWebUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceHerrWebUsuario') and type = 'P') drop procedure dbo.speCommerceHerrWebUsuario
GO             
CREATE PROCEDURE speCommerceHerrWebUsuario
                    @Estacion	        int,
                    @Empresa            varchar(5),
                    @Sucursal           int,
                    @Tipo               int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
DECLARE @Cliente varchar(10)

  DELETE WebUsuarioTemp WHERE Estacion = @Estacion
    
  INSERT WebUsuarioTemp(Estacion,  eMail,                                           Telefono,  FechaAlta, UltimoCambio,  Empresa,  Sucursal,  Cliente, Contrasena, ContrasenaConfirmacion, Nombre, Apellido)  
  SELECT                @Estacion, CASE WHEN @Tipo = 1 THEN eMail1 ELSE eMail2 END, Telefonos, GETDATE(), GETDATE(),    @Empresa, @Sucursal, Cliente, Contrasena, Contrasena ,CASE WHEN @Tipo = 1 THEN dbo.fnWebSepararContacto(Contacto1,1) WHEN @Tipo = 2 THEN dbo.fnWebSepararContacto(Contacto2,1) END, CASE WHEN @Tipo = 1 THEN dbo.fnWebSepararContacto(Contacto1,2) WHEN @Tipo = 2 THEN dbo.fnWebSepararContacto(Contacto2,2) END
    FROM  Cte
   WHERE Cliente IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) 

  --NES - Si los clientes no tienen Sucursales, agrego una basada en sus datos de facturacion
   DECLARE crClientes CURSOR LOCAL FOR
   SELECT Clave FROM ListaSt WHERE Estacion = @Estacion
   OPEN crClientes
	FETCH NEXT FROM crClientes INTO @Cliente
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ID FROM CteEnviarA WHERE Cliente = @Cliente)
		BEGIN
			INSERT CteEnviarA(ID, GUID, Cliente,  Nombre,	Direccion,          DireccionNumeroInt,                                          Pais,     Estado,   Poblacion, CodigoPostal, Estatus, Delegacion,  DireccionNumero, Colonia,   eMail1, Telefonos)
			SELECT 			  1, NEWID(), Cliente, ISNULL(NULLIF(Nombre, ''), 'N/A'), ISNULL(NULLIF(Direccion, ''), 'N/A'),          ISNULL(NULLIF(DireccionNumeroInt, ''), 'N/A'),                                          ISNULL(NULLIF(Pais, ''), 'N/A'),     ISNULL(NULLIF(Estado, ''), 'N/A'),   ISNULL(NULLIF(Poblacion, ''), 'N/A'), ISNULL(NULLIF(CodigoPostal, '00000'), 'N/A'), Estatus, ISNULL(NULLIF(Delegacion, ''), 'N/A'),  ISNULL(NULLIF(DireccionNumero, ''), 'N/A'), ISNULL(NULLIF(Colonia, ''), 'N/A'),   ISNULL(NULLIF(eMail1, ''), 'N/A'), ISNULL(NULLIF(Telefonos, ''), '00000')
				FROM Cte WHERE Cliente = @Cliente
		END

	  FETCH NEXT FROM crClientes INTO @Cliente
	END
	CLOSE crClientes
	DEALLOCATE crClientes    

  RETURN
END
GO

 /**************** fnWebValidarContacto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebValidarContacto') DROP FUNCTION fnWebValidarContacto
GO
CREATE FUNCTION fnWebValidarContacto 
	(
	@Estacion                                 int
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255)
    SET @Resultado = NULL
    
    IF EXISTS(SELECT * FROM WebUsuarioTemp WHERE NULLIF(Nombre,'') IS NULL AND Estacion = @Estacion)
      SELECT @Resultado = 'El Campo Nombre Es Requerido'
    
    IF EXISTS(SELECT * FROM WebUsuarioTemp WHERE NULLIF(eMail,'') IS NULL AND Estacion = @Estacion)
      SELECT @Resultado = 'El Campo Correo Electrónico Es Requerido'  
      
    IF EXISTS(SELECT * FROM WebUsuarioTemp WHERE NULLIF(Cliente,'') IS NULL AND Estacion = @Estacion)
      SELECT @Resultado = 'El Campo Cliente Es Requerido'      
      
    IF EXISTS(SELECT * FROM WebUsuarioTemp WHERE NULLIF(Contrasena,'') IS NULL AND Estacion = @Estacion)
      SELECT @Resultado = 'El Campo Contrasena Es Requerido'         
      
        

  RETURN (@Resultado)
END
GO

/******************************* speCommerceWebUsuarioNuevaDireccion  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceWebUsuarioNuevaDireccion') and type = 'P') drop procedure dbo.speCommerceWebUsuarioNuevaDireccion
GO             
CREATE PROCEDURE speCommerceWebUsuarioNuevaDireccion
	@Cliente varchar(10)
--//WITH ENCRYPTION
AS BEGIN
	IF NOT EXISTS(SELECT ID FROM CteEnviarA WHERE Cliente = @Cliente)
	BEGIN
		INSERT CteEnviarA(ID, GUID, Cliente,  Nombre,	Direccion,          DireccionNumeroInt,                                          Pais,     Estado,   Poblacion, CodigoPostal, Estatus, Delegacion,  DireccionNumero, Colonia,   eMail1, Telefonos)
		SELECT 			  1, NEWID(), Cliente, ISNULL(NULLIF(Nombre, ''), 'N/A'), ISNULL(NULLIF(Direccion, ''), 'N/A'),          ISNULL(NULLIF(DireccionNumeroInt, ''), 'N/A'),                                          ISNULL(NULLIF(Pais, ''), 'N/A'),     ISNULL(NULLIF(Estado, ''), 'N/A'),   ISNULL(NULLIF(Poblacion, ''), 'N/A'), ISNULL(NULLIF(CodigoPostal, '00000'), 'N/A'), Estatus, ISNULL(NULLIF(Delegacion, ''), 'N/A'),  ISNULL(NULLIF(DireccionNumero, ''), 'N/A'), ISNULL(NULLIF(Colonia, ''), 'N/A'),   ISNULL(NULLIF(eMail1, ''), 'N/A'), ISNULL(NULLIF(Telefonos, ''), '00000')
			FROM Cte WHERE Cliente = @Cliente
	END
END
GO

/**************** speCommerceInsertarWebUsuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceInsertarWebUsuario') and type = 'P') drop procedure dbo.speCommerceInsertarWebUsuario
GO             
CREATE PROCEDURE speCommerceInsertarWebUsuario
                    @Estacion	        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE @Cliente varchar(10)

  INSERT WebUsuarios(  eMail, eMail2,  Telefono,  FechaAlta, UltimoCambio,  Empresa,  Sucursal,  Cliente, Contrasena, ContrasenaConfirmacion,  Nombre, Apellido, GUID)  
  SELECT               eMail, eMail2,  Telefono, FechaAlta, UltimoCambio,  Empresa,  Sucursal,  Cliente, Contrasena, ContrasenaConfirmacion , Nombre, Apellido, NEWID()
    FROM  WebUsuarioTemp
   WHERE Estacion = @Estacion 
   
   DECLARE crClientes CURSOR LOCAL FOR
   SELECT Cliente FROM WebUsuarioTemp WHERE Estacion = @Estacion
	OPEN crClientes
	FETCH NEXT FROM crClientes INTO @Cliente
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  EXEC speCommerceWebUsuarioNuevaDireccion @Cliente
	  
	  FETCH NEXT FROM crClientes INTO @Cliente
	END
	CLOSE crClientes
	DEALLOCATE crClientes  
   
  DELETE  WebUsuarioTemp WHERE Estacion = @Estacion 

  SELECT 'Se Generaron los Registros'
  RETURN
END
GO





/**************** fnWebPrecioConImpuestos ***************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebPrecioConImpuestos') DROP FUNCTION fnWebPrecioConImpuestos
GO
CREATE FUNCTION dbo.fnWebPrecioConImpuestos
(			@Precio                         float,
                        @Impuesto1                      float,
                        @Impuesto2                      float,
                        @Impuesto3                      float)
 
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
DECLARE 
    @Resultado  float
    
  SET @Resultado = 0.0    
  SELECT  @Resultado = ISNULL(@Precio,0.0) + (((ISNULL(@Precio,0.0)*ISNULL(@Impuesto2,0.0))/100.00))
  SELECT @Resultado = @Resultado + ((@Resultado*ISNULL(@Impuesto1,0.0))/100.00)
  SELECT @Resultado = @Resultado + (ISNULL(@Impuesto3,0.0))


  RETURN (@Resultado)
 END

GO

/**************** spDesglosarPrecioCImpuestos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDesglosarPrecioCImpuestos') and type = 'P') drop procedure dbo.spDesglosarPrecioCImpuestos
GO             
CREATE PROCEDURE spDesglosarPrecioCImpuestos
                      @Articulo     varchar(20),
                      @Usuario      varchar(10),
                      @Empresa      varchar(5), 
                      @Sucursal     int,                      
                      @Importe      float  OUTPUT,
                      @Cliente      varchar(10)= NULL,
                      @Modulo       varchar(5)= NULL,
                      @Mov          varchar(20)= NULL,
                      @Impuesto1    float = NULL OUTPUT,    
                      @Impuesto2    float = NULL OUTPUT,  
                      @Impuesto3    float = NULL OUTPUT,
                      @Impuestos	float = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ZonaImpuestoUsuario   varchar(50),
    @ZonaImpuestoCliente   varchar(50),
    @ZonaImpuesto          varchar(50),
    @FechaEmision          datetime,
    @EnviarA               int,
    @Impuesto3Base         float,
    @Impuesto2Base         float,
    @Impuesto2BaseImpuesto1 float,
    @Impuesto2Info         bit,
    @Impuesto3Info         bit,
    @cfgImpuestoIncluido   bit,
    @eCommerceImpuestoIncluido bit
    
  
  
  SELECT @cfgImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @FechaEmision = dbo.fnFechaSinHora(GETDATE())
  SELECT @eCommerceImpuestoIncluido = ISNULL(eCommerceImpuestoIncluido,0) FROM Sucursal WHERE Sucursal = @Sucursal
  SELECT @ZonaImpuestoUsuario = u.DefZonaImpuesto 
    FROM Usuario u
   WHERE u.Usuario = @Usuario
   
   SELECT @ZonaImpuestoCliente = ZonaImpuesto
    FROM Cte WHERE Cliente = @Cliente 
    
   SELECT @ZonaImpuesto = ISNULL(NULLIF(@ZonaImpuestoCliente,''),NULLIF(@ZonaImpuestoUsuario,'') ) 
   
   SELECT @Impuesto1 = a.Impuesto1, @Impuesto2 = a.Impuesto2, @Impuesto3 = a.Impuesto3
     FROM Art a   
    WHERE a.Articulo = @Articulo 

    EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
    EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
    EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT    

    EXEC spTipoImpuesto @Modulo, 0, @Mov, @FechaEmision, @Empresa, @Sucursal, @Cliente, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT      
        
    SELECT @Impuesto2Info = Impuesto2Info,@Impuesto3Info = Impuesto3Info, @Impuesto2Info = Impuesto2Info
      FROM Version 
  
    SELECT @Impuesto2Base = CASE WHEN @Impuesto2Info=1 THEN 0.0 ELSE @Impuesto2 END,
           @Impuesto3Base = CASE WHEN @Impuesto3Info=1 THEN 0.0 ELSE @Impuesto3 END,
           @Impuesto2BaseImpuesto1 = CASE WHEN @Impuesto2Info=1 OR @Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE @Impuesto2 END


    IF (@cfgImpuestoIncluido = 1 AND @eCommerceImpuestoIncluido =1)
    BEGIN
	  SELECT @Impuestos = @Importe - (@Importe-ISNULL(@Impuesto3,0.0))/ (1.0 + (ISNULL(@Impuesto2, 0.0)/100) + ((ISNULL(@Impuesto1,0.0)/100) * (1+(ISNULL(@Impuesto2, 0.0)/100))))	
    END
    
    IF(@cfgImpuestoIncluido = 0 AND @eCommerceImpuestoIncluido =0 )
    BEGIN
	  SELECT @Impuestos = dbo.fnWebPrecioConImpuestos(@Importe,@Impuesto1,@Impuesto2,@Impuesto3) - @Importe 
    END

      
    IF @cfgImpuestoIncluido = 1 AND @eCommerceImpuestoIncluido =0
    BEGIN
	  SELECT @Impuestos = @Importe - (@Importe-ISNULL(@Impuesto3,0.0))/ (1.0 + (ISNULL(@Impuesto2, 0.0)/100) + ((ISNULL(@Impuesto1,0.0)/100) * (1+(ISNULL(@Impuesto2, 0.0)/100))))
      SELECT @Importe = (@Importe-ISNULL(@Impuesto3,0.0))/ (1.0 + (ISNULL(@Impuesto2, 0.0)/100) + ((ISNULL(@Impuesto1,0.0)/100) * (1+(ISNULL(@Impuesto2, 0.0)/100)))) 
    END
    
    IF @cfgImpuestoIncluido = 0 AND @eCommerceImpuestoIncluido =1  
    BEGIN
	  SELECT @Impuestos = dbo.fnWebPrecioConImpuestos(@Importe,@Impuesto1,@Impuesto2,@Impuesto3) - @Importe
      SELECT @Importe = dbo.fnWebPrecioConImpuestos(@Importe,@Impuesto1,@Impuesto2,@Impuesto3)      
    END
          
  
  RETURN
END
GO



/**************** spDesglosarPrecioCImpuestos2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDesglosarPrecioCImpuestos2') and type = 'P') drop procedure dbo.spDesglosarPrecioCImpuestos2
GO             
CREATE PROCEDURE spDesglosarPrecioCImpuestos2
                      @Articulo     varchar(20),
                      @Usuario      varchar(10),
                      @Empresa      varchar(5), 
                      @Sucursal     int,                      
                      @Importe      float  OUTPUT,
                      @Cliente      varchar(10)= NULL,
                      @Modulo       varchar(5)= NULL,
                      @Mov          varchar(20)= NULL,
                      @Impuesto1    float = NULL OUTPUT,    
                      @Impuesto2    float = NULL OUTPUT,  
                      @Impuesto3    float = NULL OUTPUT  

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ZonaImpuestoUsuario   varchar(50),
    @ZonaImpuestoCliente   varchar(50),
    @ZonaImpuesto          varchar(50),
    @FechaEmision          datetime,
    @EnviarA               int,
    @Impuesto3Base         float,
    @Impuesto2Base         float,
    @Impuesto2BaseImpuesto1 float,
    @Impuesto2Info         bit,
    @Impuesto3Info         bit,
    @cfgImpuestoIncluido   bit,
    @eCommerceImpuestoIncluido bit


    
  
  
  SELECT @cfgImpuestoIncluido = ISNULL(VentaPreciosImpuestoIncluido,0) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @FechaEmision = dbo.fnFechaSinHora(GETDATE())
  
  /*
	Cuando la tienda nos envia precios, SIEMPRE son con impuestos incluidos
	SELECT @eCommerceImpuestoIncluido = ISNULL(eCommerceImpuestoIncluido,0) FROM Sucursal WHERE Sucursal = @Sucursal
  */
  SET @eCommerceImpuestoIncluido = 1
  
  SELECT @ZonaImpuestoUsuario = u.DefZonaImpuesto 
    FROM Usuario u
   WHERE u.Usuario = @Usuario
   
   SELECT @ZonaImpuestoCliente = ZonaImpuesto
    FROM Cte WHERE Cliente = @Cliente 
    
   SELECT @ZonaImpuesto = ISNULL(NULLIF(@ZonaImpuestoCliente,''),NULLIF(@ZonaImpuestoUsuario,'') ) 
   
   SELECT @Impuesto1 = a.Impuesto1, @Impuesto2 = a.Impuesto2, @Impuesto3 = a.Impuesto3
     FROM Art a   
    WHERE a.Articulo = @Articulo 


    EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
    EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
    EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT    


    EXEC spTipoImpuesto @Modulo, 0, @Mov, @FechaEmision, @Empresa, @Sucursal, @Cliente, @EnviarA, @Articulo = @Articulo, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @Impuesto2 = @Impuesto2 OUTPUT, @Impuesto3 = @Impuesto3 OUTPUT      
        
    SELECT @Impuesto2Info = Impuesto2Info,@Impuesto3Info = Impuesto3Info, @Impuesto2Info = Impuesto2Info
      FROM Version 
  
    SELECT @Impuesto2Base = CASE WHEN @Impuesto2Info=1 THEN 0.0 ELSE @Impuesto2 END,
           @Impuesto3Base = CASE WHEN @Impuesto3Info=1 THEN 0.0 ELSE @Impuesto3 END,
           @Impuesto2BaseImpuesto1 = CASE WHEN @Impuesto2Info=1 OR @Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE @Impuesto2 END


    IF (@cfgImpuestoIncluido = 1 AND @eCommerceImpuestoIncluido =1) OR (@cfgImpuestoIncluido = 0 AND @eCommerceImpuestoIncluido =0 )
      SELECT @Importe = @Importe
      
    IF @cfgImpuestoIncluido = 0 AND @eCommerceImpuestoIncluido =1  
      SELECT @Importe = (@Importe-ISNULL(@Impuesto3,0.0))/ (1.0 + (ISNULL(@Impuesto2, 0.0)/100) + ((ISNULL(@Impuesto1,0.0)/100) * (1+(ISNULL(@Impuesto2, 0.0)/100)))) 
    
    IF @cfgImpuestoIncluido = 1 AND @eCommerceImpuestoIncluido =0
      SELECT @Importe = dbo.fnWebPrecioConImpuestos(@Importe,@Impuesto1,@Impuesto2,@Impuesto3)      
          
  
  RETURN
END
GO
/**************** speCommerceCrearJob ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceCrearJob') and type = 'P') drop procedure dbo.speCommerceCrearJob
GO             
CREATE PROCEDURE speCommerceCrearJob
  @Nombre           varchar(100),
  @BaseDatos        varchar(30),
  @Cadena           nvarchar(100) = 'speCommerceInsertarIS'
 
 
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
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
    SELECT @Fecha = GETDATE()
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
            RAISERROR ('Unable to import job ''eCommerce '' since there is already a multi-server job with this name.', 16, 1)
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
       FROM eCommerceTrabajo


	   IF(ISNULL(@Cadena, '') = '') SELECT @Cadena = 'speCommerceInsertarIS'
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
--EXEC spNotificacionCrearJobs 'Notificacion_DEMO_ 0_DEMO', 'informes', 'DEMO'


/**************** fneWebValidarNombre ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneWebValidarNombre') DROP FUNCTION fneWebValidarNombre
GO
CREATE FUNCTION fneWebValidarNombre 
	(@Nombre   varchar(255))
RETURNS bit

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  bit
  
  SET @Resultado = 1
  IF NULLIF(@Nombre,'') IS NULL
  SET @Resultado = 0  
  
  RETURN(@Resultado)
END
GO
/**************** speCommerceHerrWebArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceHerrWebArt') and type = 'P') drop procedure dbo.speCommerceHerrWebArt
GO             
CREATE PROCEDURE speCommerceHerrWebArt
                    @Estacion	        int,
                    @Empresa            varchar(5),
                    @Sucursal           int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  
  DECLARE @Tabla table(
   Articulo     varchar(20),
   Comentario   varchar(2500))
   
   INSERT @Tabla (Articulo,Comentario)
   SELECT         Cuenta, SUBSTRING(CONVERT(varchar(2500),Comentario),1,2500)
     FROM AnexoCta 
    WHERE Cuenta  IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)
      AND Rama = 'INV'


  DELETE WebArtTemp WHERE Estacion = @Estacion
    
  INSERT WebArtTemp(Estacion,  Articulo,    Nombre,                     MarcaID, Unidad, Cantidad,             OcultarPrecio, PermiteCompra, Visible, DescripcionHTML)  
  SELECT         @Estacion, a.Articulo, ISNULL(a.Descripcion1,'')+' '+ a.Articulo, m.ID,   'Pieza', 1.0,       1,             0,              1,     dbo.fneWebDescripcionHTML(SUBSTRING(ISNULL((SELECT TOP 1 Comentario FROM @Tabla WHERE Articulo = a.Articulo ),a.Descripcion1),1,2559))
    FROM  Art a LEFT JOIN WebArtMarca m ON m.Nombre = a.Fabricante 
   WHERE Articulo IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion) 

  RETURN
END
GO



/**************** speCommerceHerrInsertarWebArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceHerrInsertarWebArt') and type = 'P') drop procedure dbo.speCommerceHerrInsertarWebArt
GO             
CREATE PROCEDURE speCommerceHerrInsertarWebArt
                    @Estacion	        int
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE   
        @Articulo        varchar(20),  
        @Nombre          varchar(255), 
        @MarcaID         int,          
        @Unidad          varchar(50),  
        @Cantidad        float,        
        @DescripcionHTML varchar(8000),
        @PermiteCompra   bit,          
        @OcultarPrecio   bit,          
        @Visible         bit ,         
        @Categoria1      varchar(50),  
        @Categoria2      varchar(50),  
        @Categoria3      varchar(50),  
        @Categoria4      varchar(50),
        @IDArt           int,  
        @IDCat1          int,  
        @IDCat2          int,  
        @IDCat3          int,  
        @IDCat4          int,
        @NombreCat1      varchar(50),
        @NombreCat2      varchar(50),
        @NombreCat3      varchar(50),
        @NombreCat4      varchar(50),       
        @Orden           int,
        @Ok              int  

  DECLARE crArt CURSOR local FOR
   SELECT Nombre, ISNULL(Visible,1),  ISNULL(OcultarPrecio,1), ISNULL(PermiteCompra,0), MarcaID, Articulo, ISNULL(NULLIF(Unidad,''),'Pieza'),ISNULL(Cantidad,1.0), DescripcionHTML, NULLIF(Categoria1,'') , NULLIF(Categoria2,''), NULLIF(Categoria3,''), NULLIF(Categoria4,'')  
     FROM WebArtTemp 
    WHERE Estacion = @Estacion AND Articulo IS NOT NULL                 
  OPEN crArt
  FETCH NEXT FROM crArt INTO @Nombre, @Visible, @OcultarPrecio, @PermiteCompra, @MarcaID, @Articulo, @Unidad, @Cantidad, @DescripcionHTML, @Categoria1 , @Categoria2, @Categoria3, @Categoria4 
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    SELECT @Orden = MAX(Orden) FROM WebArt
    
    SELECT @Orden = ISNULL(@Orden,0)+1
    INSERT WebArt (Orden,  Nombre, EsDigital, Visible, Destacado, DestacadoProv, OpcionesReq, EnvioGratis, FechaAlta,  MarcaID,  PermiteCompra,  OcultarPrecio, DesHabilitarGoogle, Articulo,  Unidad,  Cantidad,      DescripcionHTML)
    SELECT         @Orden, @Nombre, 0,        @Visible, 0,         0,             0,           0,           GETDATE(), @MarcaID, @PermiteCompra, @OcultarPrecio,             1,     @Articulo, @Unidad, @Cantidad,    @DescripcionHTML
    SELECT @IDArt = SCOPE_IDENTITY()
    
    SELECT @IDCat1 = ID, @NombreCat1 = Nombre FROM WebCatArt WHERE Nombre = @Categoria1
    SELECT @IDCat2 = ID, @NombreCat2 = Nombre FROM WebCatArt WHERE Nombre = @Categoria2
    SELECT @IDCat3 = ID, @NombreCat3 = Nombre FROM WebCatArt WHERE Nombre = @Categoria3
    SELECT @IDCat4 = ID, @NombreCat4 = Nombre FROM WebCatArt WHERE Nombre = @Categoria4
    
    IF @IDArt IS NOT NULL AND @IDCat1 IS NOT NULL 
    INSERT WebCatArt_Art(IDWebArt,IDWebCatArt, Nombre)
    SELECT               @IDArt,  @IDCat1, @NombreCat1
    IF @@ERROR <> 0 SET @Ok = 1
    IF @IDArt IS NOT NULL AND @IDCat2 IS NOT NULL 
    INSERT WebCatArt_Art(IDWebArt,IDWebCatArt, Nombre)
    SELECT               @IDArt,  @IDCat2, @NombreCat2
    IF @@ERROR <> 0 SET @Ok = 1
    IF @IDArt IS NOT NULL AND @IDCat3 IS NOT NULL 
    INSERT WebCatArt_Art(IDWebArt,IDWebCatArt, Nombre)
    SELECT               @IDArt,  @IDCat3,    @NombreCat3
    IF @@ERROR <> 0 SET @Ok = 1
    IF @IDArt IS NOT NULL AND @IDCat4 IS NOT NULL 
    INSERT WebCatArt_Art(IDWebArt,IDWebCatArt, Nombre)
    SELECT               @IDArt,  @IDCat4 , @NombreCat4                       
    IF @@ERROR <> 0 SET @Ok = 1
    
    EXEC spWebArtCategoias @IDArt
    
    FETCH NEXT FROM crArt INTO @Nombre, @Visible, @OcultarPrecio, @PermiteCompra, @MarcaID, @Articulo, @Unidad, @Cantidad, @DescripcionHTML, @Categoria1 , @Categoria2, @Categoria3, @Categoria4 
  END
  CLOSE crArt
  DEALLOCATE crArt  

  IF @Ok IS NULL
    DELETE WebArtTemp WHERE Estacion = @Estacion
    
  SELECT 'Artículos Importados Exitosamente'

  RETURN
END
GO

/**************** fneCommerceEstaSincronizando ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneCommerceEstaSincronizando') DROP FUNCTION fneCommerceEstaSincronizando
GO
CREATE FUNCTION fneCommerceEstaSincronizando()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado bit
    
  SELECT @Resultado = dbo.fnInformacionContexto('ECOMMERCE')    
  
  RETURN(@Resultado)
END
GO

 /**************** fneCommerceCalcDescuentosVenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneCommerceCalcDescuentosVenta') DROP FUNCTION fneCommerceCalcDescuentosVenta
GO
CREATE FUNCTION dbo.fneCommerceCalcDescuentosVenta
(			@DescuentoGlobal   float,
 			@DescuentoLineal   float)
 
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado  float

  SELECT  @Resultado =ROUND(100 - ((100-ISNULL(@DescuentoGlobal,0.0))/100 * (100-ISNULL(@DescuentoLineal,0.0))/100) * 100, 10)

  RETURN (@Resultado)
 END
 GO

/**************** speCommerceRegenerarTablas ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceRegenerarTablas') and type = 'P') drop procedure dbo.speCommerceRegenerarTablas
GO             
CREATE PROCEDURE speCommerceRegenerarTablas
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
  BEGIN  
    DELETE eCommerceRegenerar
    INSERT eCommerceRegenerar(Regenerando) VALUES(1)
    
	EXEC spSetInformacionContexto 'ECOMMERCE', 1
    IF EXISTS (SELECT * FROM WebArt)
      UPDATE WebArt SET Orden = Orden  
    IF EXISTS (SELECT * FROM WebArtAtributos)  
      UPDATE WebArtAtributos SET Nombre = Nombre
    IF EXISTS (SELECT * FROM WebArtAtributosCat)   
      UPDATE WebArtAtributosCat SET Tipo = Tipo
    IF EXISTS (SELECT * FROM WebArtAtributosCatD)  
      UPDATE  WebArtAtributosCatD SET  Tipo = Tipo
    IF EXISTS (SELECT * FROM WebArtAtributosCatDTemp)  
      UPDATE WebArtAtributosCatDTemp SET  Tipo = Tipo  
    IF EXISTS (SELECT * FROM WebArtAtributosCatTemp)  
      UPDATE WebArtAtributosCatTemp SET  Tipo = Tipo   
    IF EXISTS (SELECT * FROM WebArtCamposConfigurables)  
      UPDATE WebArtCamposConfigurables SET  Nombre = Nombre  
    IF EXISTS (SELECT * FROM WebArtCamposConfigurablesCat)  
      UPDATE WebArtCamposConfigurablesCat SET  Tipo = Tipo   
    IF EXISTS (SELECT * FROM WebArtCamposConfigurablesCatD)  
      UPDATE WebArtCamposConfigurablesCatD SET    Tipo = Tipo   
    IF EXISTS (SELECT * FROM WebArtCamposConfigurablesCatDD)  
      UPDATE WebArtCamposConfigurablesCatDD SET  Tipo = Tipo     
    IF EXISTS (SELECT * FROM WebArtCamposConfigurablesD)  
      UPDATE WebArtCamposConfigurablesD SET  Orden =  Orden
    IF EXISTS (SELECT * FROM WebArtDescripcion)  
      UPDATE WebArtDescripcion SET  DescripcionHTML = DescripcionHTML 
    IF EXISTS (SELECT * FROM WebArtMarca)  
      UPDATE WebArtMarca SET  Orden =  Orden  
    IF EXISTS (SELECT * FROM WebArtOpcion)  
      UPDATE WebArtOpcion SET  Orden =  Orden         
    IF EXISTS (SELECT * FROM WebArtOpcionValor)  
      UPDATE WebArtOpcionValor SET  Orden =  Orden   
    IF EXISTS (SELECT * FROM WebArtVariacion)  
      UPDATE WebArtVariacion SET   Orden =  Orden       
    IF EXISTS (SELECT * FROM WebArtVariacionCombinacion)  
      UPDATE WebArtVariacionCombinacion SET  Orden =  Orden       
    IF EXISTS (SELECT * FROM WebArtVariacionCombinacionD)  
      UPDATE WebArtVariacionCombinacionD SET IDValor = IDValor     
    IF EXISTS (SELECT * FROM WebArtVideo)  
      UPDATE WebArtVideo SET  Orden =  Orden       
    IF EXISTS (SELECT * FROM WebCatArt)  
      UPDATE WebCatArt  SET  Orden = Orden 
    IF EXISTS (SELECT * FROM WebCatArt_Art)  
      UPDATE WebCatArt_Art SET   Orden = Orden  
    IF EXISTS (SELECT * FROM WebPais)  
      UPDATE WebPais SET Nombre = Nombre 
    IF EXISTS (SELECT * FROM WebPaisEstado)  
      UPDATE WebPaisEstado SET  Nombre = Nombre   
    IF EXISTS (SELECT * FROM WebSituacion)  
      UPDATE WebSituacion SET  Nombre = Nombre    
    IF EXISTS (SELECT * FROM WebSituacionEstatus)  
      UPDATE WebSituacionEstatus SET  Modulo =  Modulo
    IF EXISTS (SELECT * FROM WebUsuarios)  
      UPDATE WebUsuarios SET  Cliente =  Cliente
    IF EXISTS (SELECT * FROM WebSucursalImagen)  
      UPDATE WebSucursalImagen SET  Orden = Orden   
    IF EXISTS (SELECT * FROM WebArtImagen)  
      UPDATE WebArtImagen SET  Orden =  Orden   
    IF EXISTS(SELECT * FROM Sucursal)
      UPDATE Sucursal SET  Nombre = Nombre     
    IF EXISTS(SELECT * FROM eCommerceMetodoEnvioCfg)
      UPDATE eCommerceMetodoEnvioCfg SET  Nombre = Nombre        
      
	EXEC spSetInformacionContexto 'ECOMMERCE', 0
	DELETE eCommerceRegenerar
    SELECT 'Se Regeneraron Las Tablas de eCommerce'    
  END
  ELSE
  SELECT  'No Esta Configurada Ninguna Sucursal eCommerce' 
  RETURN
END
GO 
/*************************** fnWebDateToUnix **************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebDateToUnix') DROP FUNCTION fnWebDateToUnix
GO
CREATE FUNCTION dbo.fnWebDateToUnix
	( @DAY datetime )
RETURNS  int
AS
BEGIN
DECLARE @wkdt datetime

-- Return null if outside of valid UNIX Time range
IF (@DAY > convert(datetime, '2038-01-19 03:14:07.497', 101)) or (@DAY < convert(datetime, '1901-12-13 20:45:51.500', 101)) return null

-- Round off datetime to nearest whole second
SELECT @wkdt = dateadd(ms,round(datepart(ms,@DAY),-3)-datepart(ms,@DAY),@DAY)

-- If date GE 1901-12-14
IF @wkdt >= 712	RETURN datediff(ss,25567,@wkdt) 

-- Handles time GE '1901-12-13 20:45:52.000 and LT 1901-12-14
RETURN -2147472000-datediff(ss,@wkdt,712)
END
GO

/*************************** fnWebUnixToDate **************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'funcWeb2UnixToDate') DROP FUNCTION funcWeb2UnixToDate
GO
CREATE FUNCTION dbo.funcWeb2UnixToDate
	( @UNIX_TIME int )
RETURNS  datetime
AS
BEGIN

RETURN  	dateadd(ss,@UNIX_TIME,25567)

END
GO
/**************** fnWebConsecutivoImagenEnvoltura ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebConsecutivoImagenEnvoltura') DROP FUNCTION fnWebConsecutivoImagenEnvoltura
GO
CREATE FUNCTION fnWebConsecutivoImagenEnvoltura 
	(
	@IDEnvoltura				int,
	@Archivo         varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
 @Orden int,
 @CantidadImagenes  int,
 @Nombre varchar(50),
 @SucursaleCommerce varchar(10),
 @Sucursal	int
 
	SELECT @SucursaleCommerce = SucursaleCommerce FROM WebEnvolturaRegalo WHERE ID = @IDEnvoltura
	SELECT @Sucursal = Sucursal FROM Sucursal WHERE eCommerceSucursal = @SucursaleCommerce
	SELECT @Nombre = CONVERT(varchar(50), @Sucursal)+'Imagen'+CONVERT(varchar,@IDEnvoltura) 
	SELECT @Nombre = @Nombre + ISNULL(dbo.fnWebTipoArchivo(@Archivo),'')  
  
	RETURN (@Nombre)
END
GO
