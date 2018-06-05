EXEC sp_configure 'show advanced option', '1'  
GO
RECONFIGURE WITH OVERRIDE 
GO
EXEC sp_configure 'Ole Automation Procedures', '1'  
GO
RECONFIGURE WITH OVERRIDE   
GO
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 

/**************** spIntelisisServiceProcesareCommerce ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesareCommerce') and type = 'P') drop procedure dbo.spIntelisisServiceProcesareCommerce
GO
CREATE PROCEDURE spIntelisisServiceProcesareCommerce
                   @Sistema       varchar(100),
    		   @ID		  int,
		   @iSolicitud	  int,
		   @Solicitud     varchar(max),
		   @Version	  float,
		   @Referencia    varchar(100),
		   @SubReferencia varchar(100),
		   @Resultado     varchar(max)    OUTPUT,
		   @Ok		  int		OUTPUT,
		   @OkRef	  varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN


        IF @Referencia = 'Intelisis.eCommerce.Pedido' EXEC speCommercePedido @ID, @iSolicitud,@Solicitud, @Version,  @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.Cte' EXEC spISeCommerceCte @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.Art' EXEC spISeCommerceArt @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.ArtCosto' EXEC spISeCommerceArtCosto @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        --IF @Referencia = 'Intelisis.eCommerce.ArtOpcion' EXEC spISeCommerceArtOpcion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        --IF @Referencia = 'Intelisis.eCommerce.ArtOpcionD' EXEC spISeCommerceArtOpcionD @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.Precio' EXEC spISeCommercePrecio @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.PrecioD' EXEC spISeCommercePrecioD @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        --IF @Referencia = 'Intelisis.eCommerce.Venta' EXEC spISeCommerceVenta @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
        IF @Referencia = 'Intelisis.eCommerce.WebArt' EXEC spISeCommerceWebArt @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebCatArt' EXEC spISeCommerceWebCatArt @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtImagen' EXEC spISeCommerceWebArtImagen @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtAtributos' EXEC spISeCommerceWebArtAtributos @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtVariacion' EXEC spISeCommerceWebArtVariacion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtVideo' EXEC spISeCommerceWebArtVideo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtVariacionCombinacion' EXEC spISeCommerceWebArtVariacionCombinacion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtOpcion' EXEC spISeCommerceWebArtOpcion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtOpcionValor' EXEC spISeCommerceWebArtOpcionValor @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtCamposConfigurables' EXEC spISeCommerceWebArtCamposConfigurables @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtMarca' EXEC spISeCommerceWebArtMarca @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtExistencia' EXEC spISeCommerceWebArtExistencia @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebArtExistenciaGlobal' EXEC spISeCommerceWebArtExistenciaGlobal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.ExistenciaSucursal' EXEC spISeCommerceWebArtExistenciaSucursal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE           
        IF @Referencia = 'Intelisis.eCommerce.WebMovSituacion' EXEC spISeCommerceWebMovSituacion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebSituacion' EXEC spISeCommerceWebSituacion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebSucursalImagen' EXEC spISeCommerceWebSucursalImagen @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebUsuario' EXEC spISeCommerceWebUsuario @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebUsuarioEnviarA' EXEC spISeCommerceWebUsuarioDireccion @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebPais' EXEC spISeCommerceWebPais @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
        IF @Referencia = 'Intelisis.eCommerce.WebPaisEstado' EXEC spISeCommerceWebPaisEstado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'eCommerce.Intelisis.WebUsuario' EXEC speCommerceWebUsuarioCliente  @ID, @iSolicitud,@Solicitud, @Version,  @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'eCommerce.Intelisis.WebUsuarioEnviarA' EXEC speCommerceWebUsuarioClienteEnviarA  @ID, @iSolicitud,@Solicitud, @Version,  @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE   
        IF @Referencia = 'Intelisis.eCommerce.WebCteEnviarA' EXEC spISeCommerceWebCteEnviarA  @ID, @iSolicitud, @Version,  @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE           
        IF @Referencia = 'Intelisis.eCommerce.eCommerceMetodoEnvioCfg' EXEC spISeCommerceMetodoEnvioCfg  @ID, @iSolicitud, @Version,  @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE           
        IF @Referencia = 'Intelisis.eCommerce.Sucursal' EXEC spISeCommerceSucursal @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
        IF @Referencia = 'Intelisis.eCommerce.WebEnvolturaRegalo' EXEC spISeCommerceWebEnvolturaRegalo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 
        IF @Referencia = 'Intelisis.eCommerce.WebEstatusExistencia' EXEC spISeCommerceWebEstatusExistencia @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
        IF @Referencia = 'Intelisis.eCommerce.DiaFestivo' EXEC spISeCommerceDiaFestivo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
        IF @Referencia = 'Intelisis.eCommerce.WebCertificadosRegalo' EXEC spISeCommerceWebCertificadosRegalo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        IF @Referencia = 'Intelisis.eCommerce.ListaPreciosSub' EXEC spISeCommerceListaPreciosSub @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        --IF @Referencia = 'eCommerce.Intelisis.PrePedido' EXEC spISeCommercePrePedido @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT 

  RETURN
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

/******************************* speCommerceListarDirectorio *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceListarDirectorio') and type = 'P') drop procedure dbo.speCommerceListarDirectorio
GO             
CREATE PROCEDURE speCommerceListarDirectorio
		@PathDir            varchar(8000),
                @Estacion           int,
			@Salida			bit = 0		

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
 @PatronBusqueda	varchar(10)


DECLARE @Directorio table
(RowNum int IDENTITY(1,1),
 Nombre varchar(256) PRIMARY KEY CLUSTERED, 
 Depth  bit, 
 IsFile bit)

  DELETE eCommerceDirDetalle WHERE Estacion = @Estacion
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
       
   IF @Salida = 1 SELECT @PatronBusqueda = '%IE_%'
   ELSE SELECT @PatronBusqueda = '%EI_%'

    IF @IsFile = 1 AND @NombreI LIKE @PatronBusqueda
    BEGIN
      EXEC dbo.sp_OAMethod @ObjFileSystem,'GetFile', @ObjFile OUT, @NombreI
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Path',             @Path             OUT
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Name',             @Nombre             OUT

        
      INSERT INTO eCommerceDirDetalle(Path,  Nombre,  Tipo, Estacion)
      SELECT @Path,@Nombre,dbo.fnExtencionArchivo(@Nombre), @Estacion      
    END
        

    SELECT @Contador = @Contador + 1
  END

 EXEC sp_OADestroy @ObjFileSystem
 EXEC sp_OADestroy @ObjFile

END
GO

 --exec speCommerceListarDirectorio 'C:\Entrada',1
 --select * from eCommerceDirDetalle
 
 
 
 
 /******************************* speCommerceListarDirectorio2 *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceListarDirectorio2') and type = 'P') drop procedure dbo.speCommerceListarDirectorio2
GO             
CREATE PROCEDURE speCommerceListarDirectorio2
		@PathDir            varchar(8000),
                @Estacion           int,
                @Nivel              int
			
		

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
 @Tipo             varchar(8000)
 
 


DECLARE @Directorio table
(RowNum int IDENTITY(1,1),
 Nombre varchar(256) PRIMARY KEY CLUSTERED, 
 Depth  bit, 
 IsFile bit)

  SELECT @Nivel = ISNULL(@Nivel,1)
  
 
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
       

    IF @IsFile = 1 
    BEGIN
      EXEC dbo.sp_OAMethod @ObjFileSystem,'GetFile', @ObjFile OUT, @NombreI
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Path',             @Path             OUT
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Name',             @Nombre             OUT

        
      INSERT INTO eCommerceDirDetalle2(Path,  Nombre,  Tipo, Estacion, Nivel)
      SELECT @Path,@Nombre,dbo.fnExtencionArchivo(@Nombre), @Estacion, @Nivel      
    END
    
    IF @IsFile = 0
    BEGIN
      EXEC dbo.sp_OAMethod @ObjFileSystem,'GetFOLDER', @ObjFile OUT, @NombreI
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Path',      @Path    OUT
      EXEC dbo.sp_OAGetProperty @ObjFile, 'Name',      @Nombre  OUT
      INSERT INTO eCommerceDirDetalle2(Path,  Nombre,  Tipo, Estacion, Nivel)
      SELECT @Path,@Nombre,'Folder', @Estacion   ,@Nivel   
    END
        

    SELECT @Contador = @Contador + 1
  END

 EXEC sp_OADestroy @ObjFileSystem
 EXEC sp_OADestroy @ObjFile

END
GO





/******************************* spCrearArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearArchivo') AND TYPE = 'P')
DROP PROCEDURE spCrearArchivo
GO
CREATE PROCEDURE spCrearArchivo    
	(    
	@Archivo			varchar(255),    
	@ManejadorObjeto   int OUTPUT,    
	@IDArchivo			int OUTPUT,
 	@Ok				int = NULL OUTPUT,
	@OkRef			varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS BEGIN    
  DECLARE  @ResultadoOLE   int    
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  --IF @ResultadoOLE <> 0 RAISERROR('No es posible abrir el objeto OLE %s.',10,1,'Scripting.FileSystemObject')    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   
  
  --Crea un archivo de texto    
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateTextFile', @IDArchivo OUT, @Archivo, 8, 0    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo       
      
END
go



/******************************* spCerrarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCerrarArchivo') AND TYPE = 'P')
DROP PROCEDURE spCerrarArchivo
GO  
CREATE PROCEDURE spCerrarArchivo  
    (  
    @IDArchivo			int,
    @ManejadorObjeto	int,    
	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT     
    )  
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE  @ResultadoOLE  int    
  
  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Close'
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540
  
  EXECUTE @ResultadoOLE = sp_OADestroy @IDArchivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = 'Close'
    
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = 'Close'
  
END  
GO

/******************************* spCrearFolder *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearFolder') AND TYPE = 'P')
DROP PROCEDURE spCrearFolder
GO
CREATE PROCEDURE spCrearFolder    
	(    
	@NuevoFolder			varchar(255),    
 	@Ok				int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @Existe			int          
    
  SET @Existe = 0
    
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @NuevoFolder 

  --Verifica si existe el folder  
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FolderExists', @Existe OUT, @NuevoFolder
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @NuevoFolder      
  -- Si No existe Lo crea
  IF @Existe = 0
  BEGIN
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateFolder', @Existe OUT, @NuevoFolder
    IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @NuevoFolder       
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @NuevoFolder 
    
END
go

/******************************* spEliminarFolder *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spEliminarFolder') AND TYPE = 'P')
DROP PROCEDURE spEliminarFolder
GO
CREATE PROCEDURE spEliminarFolder    
                (    
                @Archivo     varchar(255),    
                @Ok          int = NULL OUTPUT,
                @OkRef       varchar(255) = NULL OUTPUT                     
                )    
--//WITH ENCRYPTION
AS BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @Existe		int          
    
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   

  --Verifica si existe un archivo   
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FolderExists', @Existe OUT, @Archivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
    
  --Elimina un archivo de texto    
  IF @Existe = 1
  BEGIN
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'DeleteFolder', NULL, @Archivo
    IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo  
    
END
go

/******************************* spEliminarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spEliminarArchivo') AND TYPE = 'P')
DROP PROCEDURE spEliminarArchivo
GO
CREATE PROCEDURE spEliminarArchivo    
	(    
	@Archivo			varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @Existe			int          
    
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   

  --Verifica si existe un archivo   
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FileExists', @Existe OUT, @Archivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
    
  --Elimina un archivo de texto    
  IF @Existe = 1
  BEGIN
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'DeleteFile', NULL, @Archivo
    IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo  
    
END
go

--exec spCopiarArchivo 'C:\Team\POS2_0\3500\Dibujos\Imagenes\Embarques.bmp','C:\Users\David\Desktop\Correo\Embarques.bmp'
/******************************* spCopiarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCopiarArchivo') AND TYPE = 'P')
DROP PROCEDURE spCopiarArchivo
GO
CREATE PROCEDURE   spCopiarArchivo  
	(    
	@ArchivoOrigen			varchar(255),    
	@ArchivoDestino			varchar(255),    
 	@Ok				int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int,
  @Existe			int          
    
  SET @Existe = 0
    
  EXEC spEliminarArchivo  @ArchivoDestino, @Ok OUTPUT, @OkRef OUTPUT  
    
  --Contacta al objeto que nos ayudará a crear el archivo  
  IF @Ok IS NULL
  BEGIN  
    EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
    IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @ArchivoOrigen   
  END
  IF @Ok IS NULL
  BEGIN
    EXEC @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CopyFile', NULL, @ArchivoOrigen, @ArchivoDestino  
    IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @ArchivoOrigen
  END  
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @ArchivoOrigen  


END
go

/******************************* spInsertaEnArchivo2 *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaEnArchivo2') AND TYPE = 'P')
DROP PROCEDURE spInsertaEnArchivo2
GO  
CREATE PROCEDURE spInsertaEnArchivo2  
    (  
    @IDArchivo		int,  
    @Cadena		varchar(MAX),
    @Ok				int = NULL OUTPUT,
    @OkRef			varchar(255) = NULL OUTPUT            
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE
    @ResultadoOLE	int
  

  
  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Write', NULL, @Cadena    
  IF @ResultadoOLE <> 0 SET @Ok = 710520  
END  
GO

/**************** spRegenerarArchivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRegenerarArchivo') and type = 'P') drop procedure dbo.spRegenerarArchivo
GO             
CREATE PROCEDURE spRegenerarArchivo
		@Archivo		varchar(255),	
		@XML			varchar(max),
		@Ok			int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @Shell						varchar(max)

  DECLARE @Datos TABLE
  (
  Datos		varchar(255)
  )

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
  

  IF @Ok IS NULL      
    EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo2 @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  

 
END

GO

  /**************** fneDocInLeerArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneDocInLeerArchivo') DROP FUNCTION fneDocInLeerArchivo
GO
CREATE FUNCTION dbo.fneDocInLeerArchivo
(@Path   varchar(255), @Nombre  varchar(255)) 
RETURNS varchar(8000)
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




/**************** spISeCommerceWebArtOpcionValor ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtOpcionValor') and type = 'P') drop procedure dbo.spISeCommerceWebArtOpcionValor
GO             
CREATE PROCEDURE spISeCommerceWebArtOpcionValor
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDOpcion		int,
  @IDValor		int,
  @VariacionID		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  
  
  



  SELECT @Empresa = Empresa,
         @IDOpcion = IDOpcion,
         @IDValor = IDValor,
         @VariacionID = VariacionID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtOpcionValor')
    WITH (Empresa varchar(5), VariacionID int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDOpcion int, IDValor int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT * FROM WebArtOpciones WHERE ID = @IDValor  FOR XML Auto)
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtOpcionValor" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' ID=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDOpcion,'')) + CHAR(34) +' VariacionID=' + CHAR(34) + CONVERT(varchar,ISNULL(@VariacionID,'')) + CHAR(34) +' ValorID=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDValor,'')) + CHAR(34) +' OpcionID=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDOpcion,'')) + CHAR(34) +' >' +ISNULL(@Tabla,'')+ '</Resultado></Intelisis>'  
    


END
GO

/******************************* speCommerceSolicitudISWebArtOpcionValor *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtOpcionValor') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtOpcionValor
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtOpcionValor
                @IDValor                int,
		@IDOpcion               int,
		@VariacionID            int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtOpcionValor" SubReferencia="WebArtOpcionValor" Version="1.0"><Solicitud> <WebArtOpcionValor IDOpcion="'+ISNULL(CONVERT(varchar,@IDOpcion),'')+'" IDValor="'+ISNULL(CONVERT(varchar,@IDValor),'')+'" VariacionID="'+ISNULL(CONVERT(varchar,@VariacionID),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO




if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtOpcionValorABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtOpcionValorABC
GO
CREATE TRIGGER tgeCommerceWebArtOpcionValorABC ON WebArtOpcionValor
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ID                  int,
   @IDOpcion            int,
   @VariacionID         int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, VariacionID, OpcionID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, VariacionID, OpcionID
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @ID, @VariacionID, @IDOpcion
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtOpcionValor @ID, @IDOpcion, @VariacionID, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @ID, @VariacionID, @IDOpcion
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END

GO

/**************** spISeCommerceWebArtOpcion ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtOpcion') and type = 'P') drop procedure dbo.spISeCommerceWebArtOpcion
GO             
CREATE PROCEDURE spISeCommerceWebArtOpcion
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDOpcion		int,
  @VariacionID		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max) 
  
  
  



  SELECT @Empresa = Empresa,
         @IDOpcion = IDOpcion,
         @VariacionID = VariacionID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtOpcion')
    WITH (Empresa varchar(5), VariacionID int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDOpcion int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
    SELECT @Tabla = (SELECT *   FROM WebArtOpciones WHERE OpcionID = @IDOpcion For XML AUTO) 
      ELSE   SELECT @Tabla = ''
          
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtOpcion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' OpcionID=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDOpcion,'')) + CHAR(34) +' VariacionID=' + CHAR(34) + CONVERT(varchar,ISNULL(@VariacionID,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebArtOpcion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtOpcion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtOpcion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtOpcion
		@IDOpcion               int,
		@VariacionID             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtOpcion" SubReferencia="WebArtOpcion" Version="1.0"><Solicitud> <WebArtOpcion IDOpcion="'+ISNULL(CONVERT(varchar,@IDOpcion),'')+'" VariacionID="'+ISNULL(CONVERT(varchar,@VariacionID),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtOpcionBC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtOpcionBC
GO
CREATE TRIGGER tgeCommerceWebArtOpcionBC ON WebArtOpcion
--//WITH ENCRYPTION
FOR  UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDOpcion            int,
   @VariacionID         int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, VariacionID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, VariacionID
       FROM Deleted   
      
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDOpcion, @VariacionID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      AND EXISTS (SELECT * FROM WebArtOpcionValor WHERE VariacionID = @VariacionID AND OpcionID = @IDOpcion)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtOpcion @IDOpcion, @VariacionID, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDOpcion, @VariacionID
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO
/**************** fnWebArtEstausExistencia ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArtEstausExistencia') DROP FUNCTION fnWebArtEstausExistencia
GO
CREATE FUNCTION dbo.fnWebArtEstausExistencia
	(
	@SKU					varchar(255),
	@Sucursal				int
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
		@WebEstatusExistencia varchar(20),
		@Inventario			  float
	
	 SELECT @Inventario = SUM(wes.Inventario)
		FROM WebArtExistenciaSucursal wes
		JOIN Alm a ON (wes.Almacen=a.Almacen)
		WHERE wes.SKU = @SKU AND a.eCommerceSincroniza=1
		--AND Sucursal = @Sucursal
		--GROUP BY Sucursal
		
	IF ISNULL(@Inventario, '') = '' SELECT @Inventario = 0
	
	SELECT TOP 1 @WebEstatusExistencia = WebEstatusExistencia
		FROM WebArtEstatusExistencia
		WHERE Sucursal = @Sucursal
		AND SKU = @SKU
		AND @Inventario <= ExistenciaMenorOIgual
		ORDER BY ExistenciaMenorOIgual ASC
		
	RETURN @WebEstatusExistencia
END
GO
/**************** spISeCommerceWebArt ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArt') and type = 'P') drop procedure dbo.spISeCommerceWebArt 
GO             
CREATE PROCEDURE spISeCommerceWebArt
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDArticulo		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) ,
  @Resultado2		varchar(max) ,
  @ListaPrecios         varchar(20),
  @CfgImpuestoIncluido	float,
  @Articulo             varchar(20),
  @Precio               float,
  @Usuario              varchar(10),
  @SKU					varchar(255),
  @EnvolturaIDS			varchar(max),
  @Impuestos			float
  

  SELECT @Usuario = WebUsuario
    FROM WebVersion

  SELECT @Empresa = Empresa,
         @IDArticulo = IDArticulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArt')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    
    SELECT @ListaPrecios = ISNULL(eCommerceListaPrecios,'(Precio Lista)'), @CfgImpuestoIncluido = ISNULL(eCommerceImpuestoIncluido, 1)
      FROM Sucursal WHERE Sucursal = @Sucursal
      
    SELECT @Articulo  = Articulo 
      FROM  WebArt
     WHERE ID  = @IDArticulo
     
    SELECT @Precio  = CASE WHEN @ListaPrecios = '(Precio Lista)' THEN PrecioLista
                           WHEN @ListaPrecios = '(Precio 2)' THEN ISNULL(Precio2,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 3)' THEN ISNULL(Precio3,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 4)' THEN ISNULL(Precio4,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 5)' THEN ISNULL(Precio5,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 6)' THEN ISNULL(Precio6,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 7)' THEN ISNULL(Precio7,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 8)' THEN ISNULL(Precio8,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 9)' THEN ISNULL(Precio9,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 10)' THEN ISNULL(Precio10,PrecioLista) END 
      FROM Art 
     WHERE Articulo = @Articulo     
     
     SELECT @SKU = ISNULL(NULLIF(SKU,''),'ID#'+CONVERT(varchar(10),ID)) FROM WebArt WHERE ID = @IDArticulo 

    EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, @Precio OUTPUT, NULL, NULL, NULL, NULL, NULL, NULL, @Impuestos OUTPUT
    
    IF(@CfgImpuestoIncluido = 1)
		SELECT @Impuestos = 0.00

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
     EXEC spWebArtEnvolturas @IDArticulo, @Sucursal, @EnvolturaIDS OUTPUT
     
    IF @Estatus IN ('ALTA','CAMBIO') 
        SELECT @Tabla = (SELECT  ISNULL(CONVERT(varchar,ID),'')ID,ISNULL(CONVERT(varchar,ISNULL(Orden,0)),'')Orden,ISNULL(Nombre,'')Nombre,ISNULL(CONVERT(varchar,ISNULL(EsDigital,0)),'')EsDigital,ISNULL(Archivo,'')Archivo,+@SKU SKU, ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(4000),DescripcionHTML)),'')DescripcionHTML,ISNULL(PalabrasBusqueda,'')PalabrasBusqueda,ISNULL(Disponibilidad,'')Disponibilidad,ISNULL(CONVERT(varchar,ISNULL(@Precio,0.0)),'')Precio,ISNULL(CONVERT(varchar,ISNULL(Costo,0.0)),'')Costo,ISNULL(CONVERT(varchar,ISNULL(PrecioMenudeo,0.0)),'')PrecioMenudeo,ISNULL(CONVERT(varchar,ISNULL(PrecioOferta,0.0)),'')PrecioOferta,ISNULL(CONVERT(varchar,PrecioCImpuesto),'')PrecioCImpuesto,ISNULL(CONVERT(varchar,Visible),'')Visible,ISNULL(CONVERT(varchar,Destacado),'')Destacado, ISNULL(CONVERT(varchar,DestacadoProv),'')DestacadoProv,ISNULL(ArtRelacionados,'')ArtRelacionados,ISNULL(CONVERT(varchar,OpcionesReq),'')OpcionesReq,ISNULL(Garantia,'')Garantia,ISNULL(CONVERT(varchar,Peso),'')Peso,ISNULL(CONVERT(varchar,Ancho),'')Ancho,ISNULL(CONVERT(varchar,Alto),'')Alto,ISNULL(CONVERT(varchar,Largo),'')Largo,ISNULL(CONVERT(varchar,CostoEnvioFijo),'')CostoEnvioFijo, ISNULL(CONVERT(varchar,EnvioGratis),'')EnvioGratis,ISNULL(CONVERT(varchar,FechaAlta),'')FechaAlta,ISNULL(CONVERT(varchar,MarcaID),'')MarcaID,ISNULL(TituloPagina,'')TituloPagina,ISNULL(MetaKeyWords,'')MetaKeyWords,ISNULL(Metadesc,'')Metadesc,ISNULL(Layout,'')Layout,ISNULL(CONVERT(varchar,VariacionID),'')VariacionID,ISNULL(CONVERT(varchar,PermiteCompra),'')PermiteCompra,ISNULL(CONVERT(varchar,OcultarPrecio),'')OcultarPrecio,ISNULL(TelefonoPrecios,'')TelefonoPrecios,ISNULL(CategoriaIDS,'')CategoriaIDS,ISNULL(CONVERT(varchar,UltimoCambio),'')UltimoCambio,ISNULL(CONVERT(varchar,FechaLanzamiento),'')FechaLanzamiento,ISNULL(UPC,'')UPC,ISNULL(CONVERT(varchar,DesHabilitarGoogle),'')DesHabilitarGoogle,ISNULL(Articulo,'')Articulo,ISNULL(SubCuenta,'')SubCuenta,ISNULL(CONVERT(varchar,Categoria1),'')Categoria1,ISNULL(Unidad,'')Unidad,ISNULL(SerieLote,'')SerieLote,ISNULL(CONVERT(varchar,Cantidad),'')Cantidad,ISNULL(dbo.fnWebArtEstausExistencia(@SKU,@Sucursal),'')Situacion,ISNULL(CONVERT(varchar,@EnvolturaIDS),'')EnvolturaIDS,ISNULL(CONVERT(varchar,@Impuestos),'')Impuestos FROM WebArt  WHERE ID = @IDArticulo FOR XML AUTO)
    ELSE   SELECT @Tabla = ''
  
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArt" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArticulo,'')) + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO



/******************************* speCommerceSolicitudISWebArt  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArt') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArt
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArt
		@IDArticulo             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArt" SubReferencia="WebArt" Version="1.0"><Solicitud> <WebArt IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'
 
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtABC
GO
CREATE TRIGGER tgeCommerceWebArtABC ON WebArt
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDArticulo          int,
   @Articulo			varchar(20),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, Articulo
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, Articulo
       FROM Deleted     
  END     
  IF @Estatus IS NOT NULL
  BEGIN     
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDArticulo, @Articulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArt @IDArticulo,@Sucursal, @eCommerceSucursal, @Estatus
          EXEC speCommerceSolicitudISArt @Articulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDArticulo, @Articulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END   

END
GO

/**************** spISeCommerceWebCatArt ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebCatArt') and type = 'P') drop procedure dbo.spISeCommerceWebCatArt 
GO             
CREATE PROCEDURE spISeCommerceWebCatArt
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDCategoria		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max) 
  
  



  SELECT @Empresa = Empresa,
         @IDCategoria = IDCategoria,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebCatArt')
    WITH (Empresa varchar(5), IDCategoria int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla =(SELECT *   FROM WebCatArt WHERE ID = @IDCategoria FOR XML AUTO)
    ELSE   SELECT @Tabla = ''
    
 
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebCatArt" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDCategoria=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDCategoria,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO



/******************************* speCommerceSolicitudISWebCatArt  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebCatArt') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebCatArt
GO             
CREATE PROCEDURE speCommerceSolicitudISWebCatArt
		@IDCategoria             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebCatArt" SubReferencia="WebCatArt" Version="1.0"><Solicitud> <WebCatArt IDCategoria="'+ISNULL(CONVERT(varchar,@IDCategoria),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebCatArtABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebCatArtABC
GO
CREATE TRIGGER tgeCommerceWebCatArtABC ON WebCatArt
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDCategoria          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDCategoria
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebCatArt @IDCategoria,@Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDCategoria
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceWebArtImagen****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtImagen') and type = 'P') drop procedure dbo.spISeCommerceWebArtImagen
GO             
CREATE PROCEDURE spISeCommerceWebArtImagen
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDImagen		int,
  @IDArt		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  



  SELECT @Empresa = Empresa,
         @IDImagen = IDImagen,
         @IDArt = IDArticulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtImagen')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDImagen int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
     SELECT @Tabla = (SELECT *  FROM WebArtImagen WHERE ID = @IDImagen FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtImagen" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDImagen=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDImagen,'')) + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebArtImagen *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtImagen') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtImagen
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtImagen
		@IDImagen               int,
		@IDArticulo             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtImagen" SubReferencia="WebArtImagen" Version="1.0"><Solicitud> <WebArtImagen IDImagen="'+ISNULL(CONVERT(varchar,@IDImagen),'')+'" IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtImagenABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtImagenABC
GO
CREATE TRIGGER tgeCommerceWebArtImagenABC ON WebArtImagen
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDImagen            int,
   @IDArticulo          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDImagen, @IDArticulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtImagen @IDImagen, @IDArticulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDImagen, @IDArticulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommerceWebArtAtributos****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtAtributos') and type = 'P') drop procedure dbo.spISeCommerceWebArtAtributos
GO             
CREATE PROCEDURE spISeCommerceWebArtAtributos
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDAtributo		int,
  @IDArt		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  
  



  SELECT @Empresa = Empresa,
         @IDAtributo = IDAtributo,
         @IDArt = IDArticulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtAtributos')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDAtributo int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT *  FROM WebArtAtributos WHERE ID = @IDAtributo FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtAtributos" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDAtributo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDAtributo,'')) + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebArtAtributos *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtAtributos') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtAtributos
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtAtributos
		@IDAtributo               int,
		@IDArticulo             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtAtributos" SubReferencia="WebArtAtributos" Version="1.0"><Solicitud> <WebArtAtributos IDAtributo="'+ISNULL(CONVERT(varchar,@IDAtributo),'')+'" IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtAtributosABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtAtributosABC
GO
CREATE TRIGGER tgeCommerceWebArtAtributosABC ON WebArtAtributos
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDAtributo            int,
   @IDArticulo          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtAtributos @IDAtributo, @IDArticulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommerceWebArtCamposConfigurables****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtCamposConfigurables') and type = 'P') drop procedure dbo.spISeCommerceWebArtCamposConfigurables
GO             
CREATE PROCEDURE spISeCommerceWebArtCamposConfigurables
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDAtributo		int,
  @IDArt		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Valor                varchar(max),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  
  
  



  SELECT @Empresa = Empresa,
         @IDAtributo = IDAtributo,
         @IDArt = IDArticulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtCamposConfigurables')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDAtributo int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF EXISTS(SELECT * FROM WebArtCamposConfigurablesD  WHERE ID = @IDAtributo )
        SELECT @Valor = ISNULL(@Valor,'') + ',' + Valor 
          FROM  WebArtCamposConfigurablesD
         WHERE ID = @IDAtributo
         ORDER by Orden
    SELECT @Valor = STUFF(@Valor,1,1,'' )     
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT   ISNULL(CONVERT(varchar,ID),'')ID,ISNULL(CONVERT(varchar,IDArt),'')IDArt, ISNULL(CONVERT(varchar,Nombre),'')Nombre,ISNULL(CONVERT(varchar,TipoCampo),'')TipoCampo ,ISNULL(CONVERT(varchar,Requerido),'')Requerido, ISNULL(CONVERT(varchar,Orden),'')Orden, ISNULL(@Valor,'')ValorSelect FROM WebArtCamposConfigurables  WHERE ID = @IDAtributo FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtCamposConfigurables" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDAtributo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDAtributo,'')) + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO


/******************************* speCommerceSolicitudISWebArtCamposConfigurables *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtCamposConfigurables') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtCamposConfigurables
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtCamposConfigurables
		@IDAtributo               int,
		@IDArticulo             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtCamposConfigurables" SubReferencia="WebArtCamposConfigurables" Version="1.0"><Solicitud> <WebArtCamposConfigurables IDAtributo="'+ISNULL(CONVERT(varchar,@IDAtributo),'')+'" IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtCamposConfigurablesABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtCamposConfigurablesABC
GO
CREATE TRIGGER tgeCommerceWebArtCamposConfigurablesABC ON WebArtCamposConfigurables
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDAtributo            int,
   @IDArticulo          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtCamposConfigurables @IDAtributo, @IDArticulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO




if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtCamposConfigurablesDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtCamposConfigurablesDABC
GO
CREATE TRIGGER tgeCommerceWebArtCamposConfigurablesDABC ON WebArtCamposConfigurablesD
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDAtributo            int,
   @IDArticulo          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'CAMBIO' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT d.ID, c.IDArt
       FROM Inserted d JOIN WebArtCamposConfigurables c ON d.ID = c.ID
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT  d.ID, c.IDArt
       FROM Deleted   d JOIN WebArtCamposConfigurables c ON d.ID = c.ID  
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SET @Estatus = 'CAMBIO'
      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtCamposConfigurables @IDAtributo, @IDArticulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDAtributo, @IDArticulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceWebArtVideo****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtVideo') and type = 'P') drop procedure dbo.spISeCommerceWebArtVideo
GO             
CREATE PROCEDURE spISeCommerceWebArtVideo
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDVideo		varchar(36),
  @IDArt		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  
  
  



  SELECT @Empresa = Empresa,
         @IDVideo = IDVideo,
         @IDArt = IDArticulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtVideo')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDVideo varchar(36))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT  * FROM WebArtVideo WHERE ID = @IDVideo FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtVideo" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDVideo=' + CHAR(34) + ISNULL(@IDVideo,'') + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO
/******************************* speCommerceSolicitudISWebArtVideo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtVideo') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtVideo
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtVideo
		@IDVideo               varchar(36),
		@IDArticulo             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtVideo" SubReferencia="WebArtVideo" Version="1.0"><Solicitud> <WebArtVideo IDVideo="'+ISNULL(@IDVideo,'')+'" IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtVideoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtVideoABC
GO
CREATE TRIGGER tgeCommerceWebArtVideoABC ON WebArtVideo
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDVideo            varchar(36),
   @IDArticulo          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDVideo, @IDArticulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtVideo @IDVideo, @IDArticulo, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDVideo, @IDArticulo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO



/**************** spISeCommerceWebArtVariacion ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtVariacion') and type = 'P') drop procedure dbo.spISeCommerceWebArtVariacion 
GO             
CREATE PROCEDURE spISeCommerceWebArtVariacion
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @VariacionID		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)

  SELECT @Tabla  = NULL
  SELECT @Resultado2 = NULL 
  



  SELECT @Empresa = Empresa,
         @VariacionID = VariacionID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtVariacion')
    WITH (Empresa varchar(5), VariacionID int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
    SELECT @Tabla = (SELECT  *   FROM WebArtVariacion WHERE ID = @VariacionID FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtVariacion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' VariacionID=' + CHAR(34) + CONVERT(varchar,ISNULL(@VariacionID,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO



/******************************* speCommerceSolicitudISWebArtVariacion  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtVariacion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtVariacion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtVariacion
		@VariacionID             int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtVariacion" SubReferencia="WebArtVariacion" Version="1.0"><Solicitud> <WebArtVariacion VariacionID="'+ISNULL(CONVERT(varchar,@VariacionID),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtVariacionABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtVariacionABC
GO
CREATE TRIGGER tgeCommerceWebArtVariacionABC ON WebArtVariacion
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @VariacionID          int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END        
  IF @Estatus IS NOT NULL
  BEGIN  
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @VariacionID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtVariacion @VariacionID,@Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @VariacionID
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceWebArtVariacionCombinacion****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtVariacionCombinacion') and type = 'P') drop procedure dbo.spISeCommerceWebArtVariacionCombinacion
GO             
CREATE PROCEDURE spISeCommerceWebArtVariacionCombinacion
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDCombinacion		int,
  @IDArt		int,
  @Estatus		varchar(255),
  @IDOpciones		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max),
  @ListaPrecios         varchar(20),
  @Articulo             varchar(20),
  @Usuario              varchar(10),
  @Precio               float,
  @SKU					varchar(255),
  @EnvolturaIDS			varchar(max),
  @Impuestos			float,
  @CfgImpuestoIncluido	float,
  @ImpuestosString		varchar(20),
  @Impuesto1Excento		varchar(20),
  @SubCuenta			varchar(50),
  @PrecioVariacion		float
  
  
  
  SELECT @Usuario = WebUsuario
    FROM WebVersion
  
  SELECT @Empresa = Empresa,
         @IDCombinacion = IDCombinacion,
         @IDArt = IDArticulo,
         @IDOpciones = IDOpciones,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtVariacionCombinacion')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDCombinacion int, IDOpciones varchar(255))
    
    /*SELECT @ListaPrecios = ISNULL(eCommerceListaPrecios,'(Precio Lista)') 
      FROM Sucursal WHERE Sucursal = @Sucursal*/
      
    SELECT @ListaPrecios = ISNULL(eCommerceListaPrecios,'(Precio Lista)'), @CfgImpuestoIncluido = ISNULL(eCommerceImpuestoIncluido, 1)
      FROM Sucursal WHERE Sucursal = @Sucursal
      
    SELECT @Articulo  = Articulo 
      FROM  WebArtVariacionCombinacion 
     WHERE ID  = @IDCombinacion
     
    SELECT @Precio  = CASE WHEN @ListaPrecios = '(Precio Lista)' THEN PrecioLista
                           WHEN @ListaPrecios = '(Precio 2)' THEN ISNULL(Precio2,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 3)' THEN ISNULL(Precio3,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 4)' THEN ISNULL(Precio4,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 5)' THEN ISNULL(Precio5,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 6)' THEN ISNULL(Precio6,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 7)' THEN ISNULL(Precio7,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 8)' THEN ISNULL(Precio8,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 9)' THEN ISNULL(Precio9,PrecioLista)
                           WHEN @ListaPrecios = '(Precio 10)' THEN ISNULL(Precio10,PrecioLista) END 
      FROM Art
     WHERE Articulo =  @Articulo
     
     
    -- Se consulta la tabla de ListaPreciosSub para obtener el precio de una variacion
    SET @PrecioVariacion = ''
    SELECT @SubCuenta = SubCuenta FROM WebArtVariacionCombinacion WHERE ID = @IDCombinacion
    SELECT @PrecioVariacion = Precio FROM ListaPreciosSub WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta
    
    -- Si el precio de la variacion es diferente de nulo sustituye el valor de la variable @Precio 
    if @PrecioVariacion <> ''
		SET @Precio = @PrecioVariacion
    
    SELECT @SKU = ISNULL(NULLIF(SKU,''),'IDCO#'+CONVERT(varchar(10),ID)) FROM WebArtVariacionCombinacion WHERE ID = @IDCombinacion 

    
       --EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, @Precio OUTPUT--, @Cliente, @Modulo, @Mov, @Impuesto1, @Impuesto2, @Impuesto3    
    EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, @Precio OUTPUT, NULL, NULL, NULL, NULL, NULL, NULL, @Impuestos OUTPUT
    
    
    SELECT @ImpuestosString = Impuesto1 FROM Art WHERE Articulo = @Articulo
    
    IF(@CfgImpuestoIncluido = 1)
		SELECT @Impuestos = 0.00
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT   ISNULL(CONVERT(varchar,ID),'')ID,ISNULL(CONVERT(varchar,Orden),'')Orden, ISNULL(CONVERT(varchar,IDArt),'')IDArt, ISNULL(CONVERT(varchar,IDVariacion),'')IDVariacion, ISNULL(CONVERT(varchar,Activa),'')Activa, ISNULL(CONVERT(varchar,IDOpciones),'')IDOpciones, ISNULL(CONVERT(varchar,Opciones),'')Opciones, @SKU SKU, ISNULL(CONVERT(varchar,Imagen),'')Imagen, ISNULL(CONVERT(varchar,UltimoCambio),'')UltimoCambio, ISNULL(CONVERT(varchar,OperacionPrecio),'')OperacionPrecio, ISNULL(CONVERT(varchar,OperacionPeso),'')OperacionPeso, ISNULL(CONVERT(varchar,@Precio),'')Precio, ISNULL(CONVERT(varchar,ISNULL(Peso,0.0)),'')Peso, ISNULL(CONVERT(varchar,SubCuenta),'')SubCuenta, ISNULL(CONVERT(varchar,Unidad),'')Unidad, ISNULL(CONVERT(varchar,Articulo),'')Articulo, ISNULL(CONVERT(varchar,Cantidad),'')Cantidad, ISNULL(CONVERT(varchar,TipoArchivo),'')TipoArchivo, ISNULL(CONVERT(varchar,NombreImagen),'')NombreImagen,ISNULL(dbo.fnWebArtEstausExistencia(@SKU,@Sucursal),'')Situacion FROM WebArtVariacionCombinacion WHERE ID = @IDCombinacion FOR XML AUTO )
    ELSE   SELECT @Tabla = ''    
    
    
    SELECT @Impuestos = Impuesto1, @Impuesto1Excento = Impuesto1Excento FROM Art WHERE Articulo = @Articulo
    SET @ImpuestosString =   CONVERT (VARCHAR(20), @Impuestos ,128)
        
    --SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtVariacionCombinacion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDCombinacion=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDCombinacion,'')) + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) ++' IDOpciones=' + CHAR(34) + ISNULL(@IDOpciones,'') + CHAR(34) +' >' 
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtVariacionCombinacion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDCombinacion=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDCombinacion,'')) + CHAR(34) +' IDArticulo=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDArt,'')) + CHAR(34) ++' IDOpciones=' + CHAR(34) + ISNULL(@IDOpciones,'') + CHAR(34) + ' Impuestos=' + CHAR(34) + ISNULL(@ImpuestosString,'') + CHAR(34) + ' Impuesto1Excento=' + CHAR(34) + ISNULL(@Impuesto1Excento,'') + CHAR(34) +' >' 


    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>'

END
GO
/******************************* speCommerceSolicitudISWebArtVariacionCombinacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtVariacionCombinacion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtVariacionCombinacion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtVariacionCombinacion
		@IDCombinacion               int,
		@IDArticulo             int,
		@IDOpciones             varchar(255),
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtVariacionCombinacion" SubReferencia="WebArtVariacionCombinacion" Version="1.0"><Solicitud> <WebArtVariacionCombinacion IDCombinacion="'+ISNULL(CONVERT(varchar,@IDCombinacion),'')+'" IDArticulo="'+ISNULL(CONVERT(varchar,@IDArticulo),'')+'" IDOpciones="'+ISNULL(@IDOpciones,'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtVariacionCombinacionABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtVariacionCombinacionABC
GO
CREATE TRIGGER tgeCommerceWebArtVariacionCombinacionABC ON WebArtVariacionCombinacion
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDCombinacion       int,
   @IDArticulo          int,
   @IDOpciones          varchar(255),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt,IDOpciones
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDArt, IDOpciones
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDCombinacion, @IDArticulo,@IDOpciones
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtVariacionCombinacion @IDCombinacion, @IDArticulo, @IDOpciones, @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDCombinacion, @IDArticulo,@IDOpciones
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO





/**************** spISeCommerceWebArtMarca****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtMarca') and type = 'P') drop procedure dbo.spISeCommerceWebArtMarca
GO             
CREATE PROCEDURE spISeCommerceWebArtMarca
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDMarca		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                  varchar(max),
  @Resultado2		varchar(max) 
  
  
  



  SELECT @Empresa = Empresa,
         @IDMarca = IDMarca,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtMarca')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDMarca int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT   *   FROM WebArtMarca WHERE ID = @IDMarca FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtMarca" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDMarca=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDMarca,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebArtMarca *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebArtMarca') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebArtMarca
GO             
CREATE PROCEDURE speCommerceSolicitudISWebArtMarca
		@IDMarca               int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtMarca" SubReferencia="WebArtMarca" Version="1.0"><Solicitud> <WebArtMarca IDMarca="'+ISNULL(CONVERT(varchar,@IDMarca),'')+'"'+' Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebArtMarcaABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebArtMarcaABC
GO
CREATE TRIGGER tgeCommerceWebArtMarcaABC ON WebArtMarca
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDMarca            int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDMarca
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebArtMarca @IDMarca,  @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDMarca
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommerceWebArtExistencia ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtExistencia') and type = 'P') drop procedure dbo.spISeCommerceWebArtExistencia
GO             
CREATE PROCEDURE spISeCommerceWebArtExistencia
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET NOCOUNT ON
  DECLARE 

  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @SKU                  varchar(255),
  @ReferenciaIS         varchar(100),
  @Articulo             varchar(20),
  @SubCuenta            varchar(50),
  @Tipo                 varchar(50),
  @Estacion             int,

  @Tabla                varchar(max) 


  SELECT @Estacion = @@SPID
     
  SELECT @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @SKU = SKU
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebArtExistencia')
    WITH (Sucursal int, eCommerceSucursal  varchar(10), SKU varchar(255))
    
    IF @SKU LIKE 'IDCO#%'
      SELECT   @Tipo = 'Combinacion'
    IF @SKU LIKE 'ID#%'
      SELECT   @Tipo = 'WebArt'  
      
    IF @Tipo = 'Combinacion'
      SELECT @Articulo = Articulo, @SubCuenta = ISNULL(SubCuenta,'')
        FROM WebArtVariacionCombinacion WHERE ID = dbo.fnWebArtSKU (@SKU)
      
    IF @Tipo = 'WebArt'
      SELECT @Articulo = Articulo, @SubCuenta = ISNULL(SubCuenta,'')
        FROM WebArt WHERE ID = dbo.fnWebArtSKU (@SKU)      
      
    IF @Tipo IS NULL
      SELECT @Articulo = Cuenta, @SubCuenta = ISNULL(SubCuenta,'') 
        FROM CB WHERE Codigo= @SKU  
            







      SELECT @Tabla = ISNULL(@Tabla,'') + (SELECT '<WebArtExistencia  '+ 'Articulo='+CHAR(34)+RTRIM(LTRIM(Articulo))+CHAR(34)+' SKU='+CHAR(34)+@SKU+CHAR(34)+' Cantidad='+CHAR(34)+CONVERT(varchar,ISNULL(SUM(Inventario),0.0))+CHAR(34)++' Sucursal='+CHAR(34)+CONVERT(varchar,Sucursal)+CHAR(34)+' />'
        FROM ArtSubExistenciaInv  
       WHERE Articulo = @Articulo AND ISNULL(SubCuenta,'') = ISNULL(@SubCuenta,'') GROUP BY Sucursal,Articulo,SubCuenta  )





      
    EXEC spContactoDireccionHorizontal @Estacion,'Sucursal',@Sucursal,@Sucursal,0,0,0,0

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID
 
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtExistencia" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+' >' +ISNULL(@Tabla ,'')+'</Resultado></Intelisis>' 

END
GO

/**************** spISeCommerceWebArtExistenciaGlobal ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtExistenciaGlobal') and type = 'P') drop procedure dbo.spISeCommerceWebArtExistenciaGlobal
GO             
CREATE PROCEDURE spISeCommerceWebArtExistenciaGlobal
                               @ID                     int,
                               @iSolicitud             int,
                               @Version                float,
                               @Resultado              varchar(MAX) = NULL OUTPUT,
                               @Ok                     int = NULL OUTPUT,    
                               @OkRef                  varchar(max) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET NOCOUNT ON
  DECLARE 

  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @SKU                  varchar(255),
  @ReferenciaIS         varchar(100),
  @Articulo             varchar(20),
  @SubCuenta            varchar(50),
  @Tipo                 varchar(50),
  @Estacion             int,
  @Tabla2               varchar(max),
  @Tabla                varchar(max),
  @Resultado2           varchar(max)
  
  
    SELECT @Estacion = @@SPID


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID
     
        
      
  SELECT @Tabla = ISNULL(@Tabla,'') +'<WebArtExistenciaGlobal  '+ 'Articulo='+CHAR(34)+RTRIM(LTRIM(Articulo))+CHAR(34)+' SKU='+CHAR(34)+RTRIM(LTRIM(SKU))+CHAR(34)+' Cantidad='+CHAR(34)+CONVERT(varchar,ISNULL(Inventario,0.0))+CHAR(34)+' SubCuenta='+CHAR(34)+ISNULL(SubCuenta,'')+CHAR(34)+' />' 
    FROM WebArtExistenciaGlobal
       
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtExistencia" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+' >' 
   
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+ISNULL(@Tabla2,'')+'</Resultado></Intelisis>' 

END
GO



/**************** spISeCommerceWebMovSituacion****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebMovSituacion') and type = 'P') drop procedure dbo.spISeCommerceWebMovSituacion
GO             
CREATE PROCEDURE spISeCommerceWebMovSituacion
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDMarca		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Mov                  varchar(20),
  @MovID                varchar(20),
  @OrigenMov            varchar(20),
  @OrigenMovID          varchar(20),
  @Modulo               varchar(20),
  @Situacion            varchar(50),
  @SituacioneCommerce   varchar(50),
  @IDOrigen             int,
  @IDSituacion          int,
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 

  SELECT @Empresa = Empresa,
         @IDOrigen = IDOrigen,
         @OrigenMov = OrigenMov,
         @OrigenMovID = OrigenMovID,
         @Modulo = Modulo,
         @Mov = Mov,
         @MovID = MovID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus,
         @Situacion = Situacion,
         @SituacioneCommerce = SituacioneCommerce,
         @IDSituacion = SituacionID
       
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebMovSituacion')
    WITH (Empresa varchar(5), SituacioneCommerce  varchar(50),SituacionID int, IDOrigen int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), OrigenMov varchar(20), OrigenMovID varchar(20), Modulo varchar(5), Mov varchar(20), MovID varchar(20), Situacion varchar(50))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID

    SELECT @Tabla = '<WebMovSituacion IDOrigen="'+ISNULL(CONVERT(varchar,@IDOrigen),'')+'" OrigenMov="'+ISNULL(@OrigenMov,'')+'" OrigenMovID="'+ISNULL(@OrigenMovID,'')+'" Modulo="'+ISNULL(@Modulo,'')+'" Mov="'+ISNULL(@Mov,'')+'" MovID="'+ISNULL(@MovID,'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Situacion="'+ISNULL(@Situacion,'')+'"  SituacionID="'+ISNULL(CONVERT(varchar,@IDSituacion),'') +'" SituacioneCommerce="'+ISNULL(@SituacioneCommerce,'')+' " Empresa="'+ISNULL(@Empresa,'')+'" />'    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebMovSituacion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34) +' Estatus = "CAMBIO" >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO       


/******************************* speCommerceSolicitudISWebMovSituacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebMovSituacion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebMovSituacion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebMovSituacion
                @OrigenID               int,
		@Modulo                 varchar(5),
		@ModuloID               int,
		@Estatus                varchar(15),
		@Sucursal               int, 
		@eCommerceSucursal      varchar(20),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Mov         varchar(20),
  @MovID       varchar(20),
  @OrigenMov   varchar(20),
  @OrigenMovID varchar(20),
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @Situacion   varchar(50),
  @SituacioneCcommerce    varchar(50),
  @IDSituacioneCcommerce  int,
  @xml                    varchar(max),
  @xml2                   varchar(max),
  @Resultado              varchar(max),
  @Solicitud              varchar(max),
  @Archivo                varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal  
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  SELECT @OrigenMov = Mov, @OrigenMovID = MovID, @Empresa = Empresa FROM Venta WHERE ID = @OrigenID
  
  EXEC spMovInfo2  @ModuloID, @Modulo, @Sucursal OUTPUT, @Mov OUTPUT, @MovID OUTPUT, @Situacion OUTPUT
  
  SELECT @IDSituacioneCcommerce  = se.SituacionEcomerce ,@SituacioneCcommerce = s.Nombre
    FROM WebSituacionEstatus se LEFT JOIN WebSituacion s ON se.SituacionEcomerce = s.ID
   WHERE Modulo = @Modulo AND Mov = @Mov AND Estatus = @Estatus AND Situacion = ISNULL(@Situacion,'')
  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebMovSituacion" SubReferencia="WebMovSituacion" Version="1.0"><Solicitud><WebMovSituacion IDOrigen="'+ISNULL(CONVERT(varchar,@OrigenID),'')+'" OrigenMov="'+ISNULL(@OrigenMov,'')+'" OrigenMovID="'+ISNULL(@OrigenMovID,'')+'" Modulo="'+ISNULL(@Modulo,'')+'" Mov="'+ISNULL(@Mov,'')+'" MovID="'+ISNULL(@MovID,'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Situacion="'+ISNULL(@Situacion,'')+'" SituacionID="'+ISNULL(CONVERT(varchar,@IDSituacioneCcommerce),'') +'" SituacioneCommerce="'+ISNULL(@SituacioneCcommerce,'')+'"  Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO        

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceMovEstatusLogAC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceMovEstatusLogAC
Go


/************** xpCambiarSituacion *************/
if exists (select * from sysobjects where id = object_id('dbo.xpCambiarSituacion') and type = 'P') drop procedure dbo.xpCambiarSituacion
GO
CREATE PROCEDURE xpCambiarSituacion
                   @Modulo              char(5),
                   @ID                  int,
                   @Situacion           char(50),
                   @SituacionFecha      datetime,
                   @Usuario             char(10),
                   @SituacionUsuario    varchar(10),
                   @SituacionNota       varchar(100)

AS BEGIN
  DECLARE @Mov    varchar(20),
          @Sucursal int,
          @Ok       int,
          @OrigenID varchar(20),
          @eCommerceSucursal  varchar(10),
          @Estatus   varchar(15)
        
        
      
     
        

                                                                                                  
  SELECT @Estatus = CASE   WHEN @Modulo = 'CONT' THEN (SELECT Estatus FROM  Cont        WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'VTAS' THEN (SELECT Estatus FROM  Venta       WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'PROD' THEN (SELECT Estatus FROM  Prod        WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'COMS' THEN (SELECT Estatus FROM  Compra      WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'INV'  THEN (SELECT Estatus FROM  Inv         WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'CXC'  THEN (SELECT Estatus FROM  Cxc         WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'CXP'  THEN (SELECT Estatus FROM  Cxp         WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'AGENT'THEN (SELECT Estatus FROM  Agent       WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'GAS'  THEN (SELECT Estatus FROM  Gasto       WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'DIN'  THEN (SELECT Estatus FROM  Dinero      WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'EMB'  THEN (SELECT Estatus FROM  Embarque    WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'NOM'  THEN (SELECT Estatus FROM  Nomina      WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'RH'   THEN (SELECT Estatus FROM  RH          WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'ASIS' THEN (SELECT Estatus FROM  Asiste      WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'AF'   THEN (SELECT Estatus FROM  ActivoFijo  WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'PC'   THEN (SELECT Estatus FROM  PC          WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'VALE' THEN (SELECT Estatus FROM  Vale        WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'ST'   THEN (SELECT Estatus FROM  Soporte     WHERE ID = @ID) 
                                                                                            WHEN @Modulo = 'CAM'  THEN (SELECT Estatus FROM  Cambio      WHERE ID = @ID) END
                                                                                            
 

  IF  dbo.fneCommerceOrigen(@Modulo,@ID,1) = 1 AND EXISTS (SELECT * FROM WebSituacionEstatus w WHERE w.Modulo = @Modulo AND  w.Situacion = @Situacion AND
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
                        
     -- AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN

        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          SELECT @OrigenID = dbo.fneCommerceIDOrigen(@Modulo,@ID,1)
          
          EXEC speCommerceSolicitudISWebMovSituacion @OrigenID,@Modulo,@ID, @Estatus, @Sucursal, @eCommerceSucursal 
        
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
    RETURN
END
GO





/**************** spISeCommerceWebSituacion****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebSituacion') and type = 'P') drop procedure dbo.spISeCommerceWebSituacion
GO             
CREATE PROCEDURE spISeCommerceWebSituacion
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDSituacion		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max)   
  
  
 
  
  
  
  SELECT @Empresa = Empresa,
         @IDSituacion = IDSituacion,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebSituacion')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDSituacion int)
    
 
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT * FROM WebSituacion WHERE ID = @IDSituacion  FOR XML AUTO)
    ELSE   SELECT @Tabla = ''   
    
   
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebSituacion" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDSituacion=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDSituacion,'')) + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebSituacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebSituacion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebSituacion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebSituacion
		@IDSituacion               int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebSituacion" SubReferencia="WebSituacion" Version="1.0"><Solicitud> <WebSituacion IDSituacion="'+ISNULL(CONVERT(varchar,@IDSituacion),'')+'"'+' Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebSituacionABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebSituacionABC
GO
CREATE TRIGGER tgeCommerceWebSituacionABC ON WebSituacion
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDSituacion            int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDSituacion
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebSituacion @IDSituacion,  @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDSituacion
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommerceWebSucursalImagen ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebSucursalImagen') and type = 'P') drop procedure dbo.spISeCommerceWebSucursalImagen 
GO             
CREATE PROCEDURE spISeCommerceWebSucursalImagen
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 

  @Estatus		varchar(10),
  @Nombre		varchar(50),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) ,
  @Resultado2		varchar(max),
@TipoArchivo          varchar(10) 

  
  
  



  SELECT @Empresa = Empresa,
         @Sucursal = Sucursal,
         @Nombre = Nombre,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus,
         @TipoArchivo = TipoArchivo
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebSucursalImagen')
    WITH (Empresa varchar(5), Nombre varchar(50), Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), TipoArchivo varchar(10))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
    SELECT @Tabla = (SELECT  *   FROM WebSucursalImagen WHERE Sucursal = @Sucursal AND Nombre = @Nombre FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebSucursalImagen" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Nombre=' + CHAR(34) + ISNULL(@Nombre,'') + CHAR(34) +' TipoArchivo='+CHAR(34) + ISNULL(@TipoArchivo,'') + CHAR(34)+' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO



/******************************* speCommerceSolicitudISWebSucursalImagen  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebSucursalImagen') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebSucursalImagen
GO             
CREATE PROCEDURE speCommerceSolicitudISWebSucursalImagen
		@Sucursal               int, 
		@Nombre                 varchar(50), 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@TipoArchivo            varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebSucursalImagen" SubReferencia="WebSucursalImagen" Version="1.0"><Solicitud> <WebSucursalImagen  Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" Nombre="'+ISNULL(@Nombre,'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebSucursalImagenABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebSucursalImagenABC
GO
CREATE TRIGGER tgeCommerceWebSucursalImagenABC ON WebSucursalImagen
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @Estatus             varchar(10),
   @Nombre              varchar(50),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,
   @TipoArchivo         varchar(10),  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Sucursal, Nombre, TipoArchivo
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Sucursal, Nombre, TipoArchivo
       FROM Deleted     
  END        
  IF @Estatus IS NOT NULL
  BEGIN  
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Sucursal, @Nombre, @TipoArchivo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL AND Sucursal = @Sucursal)
      BEGIN
         SELECT @eCommerceSucursal = eCommerceSucursal FROM Sucursal WHERE Sucursal = @Sucursal
          EXEC speCommerceSolicitudISWebSucursalImagen @Sucursal, @Nombre, @eCommerceSucursal, @Estatus,  @TipoArchivo

      END
      FETCH NEXT FROM crActualizar INTO @Sucursal, @Nombre, @TipoArchivo
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO



--DECLARE @Solicitud varchar(8000),@Resultado varchar(8000),@ID int

--select CONVERT(xml,
--'<?xml version="1.0" encoding="windows-1252"?>
--  <Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebArtExistencia" SubReferencia="WebArtExistencia" Version="1.0">
--    <Solicitud>
--      <WebArtExistencia Sucursal="0" eCommerceSucursal="S21" SKU="ID#12" />
--    </Solicitud>
--  </Intelisis>')
  
-- EXEC spIntelisisService 'DEMO', 'DEMO', @Solicitud, @Resultado OUTPUT, NULL, NULL, 1, 0, @ID OUTPUT
 
-- select convert(xml,@Resultado)--,@ID

/**************** spISeCommerceWebUsuario ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebUsuario') and type = 'P') drop procedure dbo.spISeCommerceWebUsuario 
GO             
CREATE PROCEDURE spISeCommerceWebUsuario
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDUsuario		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 


  SELECT @Empresa = Empresa,
         @IDUsuario = IDUsuario,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebUsuario')
    WITH (Empresa varchar(5), IDUsuario int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
        SELECT @Tabla = (SELECT * FROM WebUsuarios WHERE ID = @IDUsuario FOR XML AUTO)
    ELSE   SELECT @Tabla = ''
  
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebUsuario" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDUsuario=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDUsuario,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO



/******************************* speCommerceSolicitudISWebUsuario  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebUsuario') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebUsuario
GO             
CREATE PROCEDURE speCommerceSolicitudISWebUsuario
		@IDUsuario              int,
		@Empresa                varchar(5),
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal  
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebUsuario" SubReferencia="WebUsuario" Version="1.0"><Solicitud> <WebUsuario IDUsuario="'+ISNULL(CONVERT(varchar,@IDUsuario),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'
 
  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO


/**************** spISeCommerceWebUsuarioDireccion ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebUsuarioDireccion') and type = 'P') drop procedure dbo.spISeCommerceWebUsuarioDireccion 
GO             
CREATE PROCEDURE spISeCommerceWebUsuarioDireccion
                               @ID                     int,
                               @iSolicitud             int,
                               @Version                float,
                               @Resultado              varchar(max) = NULL OUTPUT,
                               @Ok                     int = NULL OUTPUT,    
                               @OkRef                  varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDUsuario            int,
  @Cliente              varchar(10),
  @Estatus              varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2           varchar(max) 



  SELECT @Empresa = Empresa,
         @IDUsuario = IDUsuario,
         @Cliente = Cliente,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebUsuarioEnviarA')
    WITH (Empresa varchar(5), IDUsuario int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Cliente varchar(10))
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
        SELECT @Tabla = '<WebUsuarioEnviarA '+(SELECT  ' ID='+CHAR(34)+ISNULL(CONVERT(varchar,0),'')+CHAR(34)+ 
        ' Cliente='+CHAR(34)+ISNULL(Cliente,'')+CHAR(34)+
        ' Direccion='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(ISNULL(Direccion,'')),'') +CHAR(34)+ 
        ' NoExterior='+CHAR(34)+ISNULL(DireccionNumero,'')+CHAR(34)+ 
        ' Direccion2='+CHAR(34)+ISNULL(DireccionNumeroInt,'')+CHAR(34)+ 
        ' Pais='+CHAR(34)+ISNULL(Pais,'')+CHAR(34)+ 
        ' Estado='+CHAR(34)+ISNULL(Estado,'')+CHAR(34)+ 
        ' Ciudad='+CHAR(34)+ISNULL(Poblacion,'')+CHAR(34)+ 
        ' eMail='+CHAR(34)+ISNULL(eMail1,'')+CHAR(34)+ 
        ' Nombre='+CHAR(34)+ISNULL(Nombre,'')+CHAR(34)+ 
        ' Telefono='+CHAR(34)+ISNULL(Telefonos,'')+CHAR(34)+ 
        ' Delegacion='+CHAR(34)+ISNULL(Delegacion,'')+CHAR(34)+ 
        ' Colonia='+CHAR(34)+ISNULL(Colonia,'')+CHAR(34)+ 
        ' CP='+CHAR(34)+ISNULL(CodigoPostal,'')+CHAR(34)+ 
        ' UsuarioID='+CHAR(34)+ISNULL(CONVERT(varchar,@IDUsuario),'')+CHAR(34)
          FROM Cte WHERE Cliente = @Cliente)+' />' 
    ELSE   SELECT @Tabla = ''
  
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebUsuario" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDUsuario=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDUsuario,'')) + CHAR(34)+' Cliente=' + CHAR(34) + CONVERT(varchar,ISNULL(@Cliente,'')) + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    


END
GO



/******************************* speCommerceSolicitudISWebUsuarioDireccion  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebUsuarioDireccion') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebUsuarioDireccion
GO             
CREATE PROCEDURE speCommerceSolicitudISWebUsuarioDireccion
                @IDUsuario              int,
                @Cliente                varchar(10),
                @Empresa                varchar(5),
                @Sucursal               int, 
                @eCommerceSucursal      varchar(10), 
                @Estatus                varchar(10),
                @Ok                     int = NULL OUTPUT,
                @OkRef                  varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID
  IF EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente AND NULLIF(Direccion,'') IS NOT NULL AND NULLIF(Pais,'') IS NOT NULL AND NULLIF(Estado,'') IS NOT NULL)
  BEGIN
    SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebUsuarioEnviarA" SubReferencia="WebUsuarioEnviarA" Version="1.0"><Solicitud> <WebUsuarioEnviarA IDUsuario="'+ISNULL(CONVERT(varchar,@IDUsuario),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Cliente="'+ISNULL(@Cliente,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT

    IF @ID IS NOT NULL AND @Ok IS NULL
    BEGIN
      SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

      IF @Ok IS NULL
        EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
    END    
  END  
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebUsuarioABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebUsuarioABC
GO
CREATE TRIGGER tgeCommerceWebUsuarioABC ON WebUsuarios
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @Empresa             varchar(5),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,
   @Cliente             varchar(10),  
   @eCommerceEmpresa    bit,
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, Empresa, Sucursal, Cliente
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, Empresa, Sucursal, Cliente
       FROM Deleted     
  END     
  IF @Estatus IS NOT NULL
  BEGIN     
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDUsuario, @Empresa, @Sucursal, @Cliente
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          EXEC speCommerceSolicitudISWebUsuario @IDUsuario,@Empresa, @Sucursal, @eCommerceSucursal, @Estatus

          IF @Estatus IN( 'ALTA','CAMBIO')
          BEGIN
            IF @Ok IS NULL
              EXEC speCommerceSolicitudISWebUsuarioDireccion @IDUsuario, @Cliente, @Empresa, @Sucursal, @eCommerceSucursal, @Estatus, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok IS NULL AND EXISTS(SELECT * FROM CteEnviarA WHERE Cliente = @Cliente) AND @Estatus = 'ALTA'
              UPDATE CteEnviarA SET Nombre = Nombre WHERE Cliente = @Cliente
            
          END  
   
		  --NES - Si los clientes no tienen Sucursales, agrego una basada en sus datos de facturacion
			IF NOT EXISTS(SELECT ID FROM CteEnviarA WHERE Cliente = @Cliente)
			BEGIN
				INSERT CteEnviarA(ID, GUID, Cliente,  Nombre,	Direccion,          DireccionNumeroInt,                                          Pais,     Estado,   Poblacion, CodigoPostal, Estatus, Delegacion,  DireccionNumero, Colonia,   eMail1, Telefonos)
				SELECT 			  1, NEWID(), Cliente, ISNULL(NULLIF(Nombre, ''), 'N/A'), ISNULL(NULLIF(Direccion, ''), 'N/A'),          ISNULL(NULLIF(DireccionNumeroInt, ''), 'N/A'),                                          ISNULL(NULLIF(Pais, ''), 'N/A'),     ISNULL(NULLIF(Estado, ''), 'N/A'),   ISNULL(NULLIF(Poblacion, ''), 'N/A'), ISNULL(NULLIF(CodigoPostal, '00000'), 'N/A'), Estatus, ISNULL(NULLIF(Delegacion, ''), 'N/A'),  ISNULL(NULLIF(DireccionNumero, ''), 'N/A'), ISNULL(NULLIF(Colonia, ''), 'N/A'),   ISNULL(NULLIF(eMail1, ''), 'N/A'), ISNULL(NULLIF(Telefonos, ''), '00000')
					FROM Cte WHERE Cliente = @Cliente
			END
   
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDUsuario, @Empresa, @Sucursal, @Cliente
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END   

END
GO




/**************** spISeCommerceWebPais****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebPais') and type = 'P') drop procedure dbo.spISeCommerceWebPais
GO             
CREATE PROCEDURE spISeCommerceWebPais
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDPais		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  
  
  



  SELECT @Empresa = Empresa,
         @IDPais = IDPais,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebPais')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDPais int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT  *  FROM WebPais WHERE ID = @IDPais FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebPais" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDPais=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDPais,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebPais *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebPais') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebPais
GO             
CREATE PROCEDURE speCommerceSolicitudISWebPais
		@IDPais               int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal    
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebPais" SubReferencia="WebPais" Version="1.0"><Solicitud> <WebPais IDPais="'+ISNULL(CONVERT(varchar,@IDPais),'')+'"'+' Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebPaisABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebPaisABC
GO
CREATE TRIGGER tgeCommerceWebPaisABC ON WebPais
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDPais            int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDPais
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebPais @IDPais,  @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDPais
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceWebPaisEstado****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebPaisEstado') and type = 'P') drop procedure dbo.spISeCommerceWebPaisEstado
GO             
CREATE PROCEDURE spISeCommerceWebPaisEstado
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDEstado             int,
  @IDPais		int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  
  
  



  SELECT @Empresa = Empresa,
         @IDEstado = IDEstado,
         @IDPais = IDPais,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebPaisEstado')
    WITH (Empresa varchar(5), IDArticulo int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDPais int, IDEstado int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT *  FROM WebPaisEstado WHERE ID = @IDEstado AND IDPais = @IDPais FOR XML AUTO)
    ELSE   SELECT @Tabla = ''    
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebPaisEstado" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDPais=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDPais,'')) + CHAR(34) +' IDEstado=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDEstado,'')) + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISWebPaisEstado *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebPaisEstado') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebPaisEstado
GO             
CREATE PROCEDURE speCommerceSolicitudISWebPaisEstado

		@IDEstado               int,
		@IDPais                 int,
		@Sucursal               int, 
		@eCommerceSucursal      varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal      
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebPaisEstado" SubReferencia="WebPaisEstado" Version="1.0"><Solicitud> <WebPaisEstado IDEstado="'+ISNULL(CONVERT(varchar,@IDEstado),'')+'"'+' IDPais="'+ISNULL(CONVERT(varchar,@IDPais),'')+'"'+' Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO






if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebPaisEstadoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebPaisEstadoABC
GO
CREATE TRIGGER tgeCommerceWebPaisEstadoABC ON WebPaisEstado
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDEstado            int,
   @IDPais              int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDPais
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, IDPais
       FROM Deleted     
  END  
  IF @Estatus IS NOT NULL
  BEGIN        
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @IDEstado, @IDPais
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISWebPaisEstado @IDEstado, @IDPais,  @Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @IDEstado, @IDPais
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommerceArt ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArt') and type = 'P') drop procedure dbo.spISeCommerceArt 
GO             
CREATE PROCEDURE spISeCommerceArt
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
  @Articulo		varchar(20),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  
  

  



  SELECT @Empresa = Empresa,
         @Articulo = Articulo ,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Art')
    WITH (Empresa varchar(5), Articulo varchar(20), Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT * FROM Art WHERE Articulo = @Articulo FOR XML AUTO)
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="Art" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(@Articulo,'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
END
GO


/******************************* speCommerceSolicitudISArt  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArt') and type = 'P') drop procedure dbo.speCommerceSolicitudISArt
GO             
CREATE PROCEDURE speCommerceSolicitudISArt
		@Articulo               varchar(20),
		@Sucursal               int, 
		@eCommerceSucursal       varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal  
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Art" SubReferencia="Art" Version="1.0"><Solicitud> <Art Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(@Articulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtABC
GO
CREATE TRIGGER tgeCommerceArtABC ON Art
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @Articulo            varchar(20),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo
       FROM Deleted     
  END          
   
  IF @Estatus IS NOT NULL
  BEGIN        
  OPEN crActualizar
  FETCH NEXT FROM crActualizar INTO @Articulo
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN

    IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = @Articulo)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
    BEGIN
      DECLARE crSucursal CURSOR local FOR
       SELECT Sucursal, eCommerceSucursal
         FROM Sucursal
        WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
      OPEN crSucursal
      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN

        EXEC speCommerceSolicitudISArt @Articulo,@Sucursal, @eCommerceSucursal, @Estatus
        
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
      END
      CLOSE crSucursal
      DEALLOCATE crSucursal    
    END
    FETCH NEXT FROM crActualizar INTO @Articulo
  END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO


/**************** spISeCommerceArtCosto ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtCosto') and type = 'P') drop procedure dbo.spISeCommerceArtCosto 
GO             
CREATE PROCEDURE spISeCommerceArtCosto
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
  @Articulo		varchar(20),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max),
  @UltimoCosto float,
  @CostoPromedio float,
  @CostoEstandar float,
  @CostoReposicion float,
  @UltimoCostoSinGastos float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float
  
  SELECT @Usuario = WebUsuario
  	FROM WebVersion
  
  SELECT @Empresa = Empresa,
         @Articulo = Articulo ,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ArtCosto')
    WITH (Empresa varchar(5), Articulo varchar(10), Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    
	SELECT
		@UltimoCosto = UltimoCosto,
		@CostoPromedio = CostoPromedio,
		@CostoEstandar = CostoEstandar,
		@CostoReposicion = CostoReposicion,
		@UltimoCostoSinGastos = UltimoCostoSinGastos
	FROM ArtCosto WHERE Articulo = @Articulo AND Empresa = @Empresa AND Sucursal = @Sucursal
    
    IF(SELECT eCommerceImpuestoIncluido FROM Sucursal WHERE Sucursal = @Sucursal) = 1
    BEGIN
		EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, 0, NULL, NULL, NULL, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT

		SELECT @UltimoCosto = dbo.fnWebPrecioConImpuestos(@UltimoCosto,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoPromedio = dbo.fnWebPrecioConImpuestos(@CostoPromedio,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoEstandar = dbo.fnWebPrecioConImpuestos(@CostoEstandar,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoReposicion = dbo.fnWebPrecioConImpuestos(@CostoReposicion,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @UltimoCostoSinGastos = dbo.fnWebPrecioConImpuestos(@UltimoCostoSinGastos,@Impuesto1,@Impuesto2,@Impuesto3)
	END

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
	-- NES  - Aqui se esta perdiendo el cuarto decimal al convertir a varchar
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = (SELECT '<ArtCosto '+
		'Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), Sucursal)),'')+'" '+
		'Empresa="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), Empresa)),'')+'" '+
		'Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), Articulo)),'')+'" '+
		'UltimoCosto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), @UltimoCosto)),'')+'" '+
		'CostoPromedio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), @CostoPromedio)),'')+'" '+
		'CostoEstandar="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), @CostoEstandar)),'')+'" '+
		'CostoReposicion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), @CostoReposicion)),'')+'" '+
		'UltimoCostoSinGastos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000), @UltimoCostoSinGastos)),'')+'" '+
		'/>'
      FROM ArtCosto WHERE Articulo = @Articulo AND Empresa = @Empresa AND Sucursal = @Sucursal)
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ArtCosto" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(@Articulo,'') + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
 
END
GO



/******************************* speCommerceSolicitudISArtCosto  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtCosto') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtCosto
GO             
CREATE PROCEDURE speCommerceSolicitudISArtCosto
		@Articulo               varchar(20),
		@Sucursal               int, 
		@Empresa                varchar(5),
		@eCommerceSucursal       varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal  
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ArtCosto" SubReferencia="ArtCosto" Version="1.0"><Solicitud> <ArtCosto Articulo="'+ISNULL(@Articulo,'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtCostoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtCostoABC
GO
CREATE TRIGGER tgeCommerceArtCostoABC ON ArtCosto
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @Articulo            varchar(20),
   @Empresa             varchar(5),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, Empresa, Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, Empresa, Sucursal
       FROM Deleted     
  END   
  IF @Estatus IS NOT NULL
  BEGIN       
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Articulo, @Empresa, @Sucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo)) AND EXISTS(SELECT * FROM Sucursal WHERE Sucursal = @Sucursal AND eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        SELECT @eCommerceSucursal = eCommerceSucursal FROM Sucursal WHERE Sucursal = @Sucursal 
        EXEC speCommerceSolicitudISArtCosto @Articulo,@Sucursal, @Empresa, @eCommerceSucursal, @Estatus
      END
      FETCH NEXT FROM crActualizar INTO @Articulo, @Empresa, @Sucursal
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO


/**************** spISeCommercePrecio ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommercePrecio') and type = 'P') drop procedure dbo.spISeCommercePrecio 
GO             
CREATE PROCEDURE spISeCommercePrecio
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
  @PrecioID             int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  



  SELECT @Empresa = Empresa,
         @PrecioID= PrecioID ,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Precio')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  PrecioID int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<Precio '+(SELECT   ' ID="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.ID)),'')+'"'+  ' Descripcion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Descripcion),'')+'"'+  ' Estatus="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Estatus),'')+'"'+  ' UltimoCambio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.UltimoCambio)),'')+'"'+  ' NivelArticulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelArticulo)),'')+'"'+  ' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Articulo),'')+'"'+  ' NivelSubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelSubCuenta)),'')+'"'+  ' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.SubCuenta),'')+'"'+  ' NivelArtGrupo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelArtGrupo)),'')+'"'+  ' ArtGrupo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ArtGrupo),'')+'"'+  ' NivelArtCat="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelArtCat)),'')+'"'+  ' ArtCat="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ArtCat),'')+'"'+  ' NivelArtFam="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelArtFam)),'')+'"'+  ' ArtFam="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ArtFam),'')+'"'+  ' NivelArtABC="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelArtABC)),'')+'"'+  ' ArtABC="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ArtABC),'')+'"'+  ' NivelFabricante="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelFabricante)),'')+'"'+  ' Fabricante="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Fabricante),'')+'"'+  ' NivelCliente="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCliente)),'')+'"'+  ' Cliente="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Cliente),'')+'"'+  ' NivelCteGrupo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCteGrupo)),'')+'"'+  ' CteGrupo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.CteGrupo),'')+'"'+  ' NivelCteCat="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCteCat)),'')+'"'+  ' CteCat="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.CteCat),'')+'"'+  ' NivelCteFam="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCteFam)),'')+'"'+  ' CteFam="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.CteFam),'')+'"'+  ' NivelCteZona="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCteZona)),'')+'"'+  ' CteZona="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.CteZona),'')+'"'+  ' NivelMoneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelMoneda)),'')+'"'+  ' Moneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Moneda),'')+'"'+  ' NivelCondicion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelCondicion)),'')+'"'+  ' Condicion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Condicion),'')+'"'+  ' NivelAlmacen="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelAlmacen)),'')+'"'+  ' Almacen="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Almacen),'')+'"'+  ' NivelProyecto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelProyecto)),'')+'"'+  ' Proyecto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Proyecto),'')+'"'+  ' NivelAgente="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelAgente)),'')+'"'+  ' Agente="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Agente),'')+'"'+  ' NivelFormaEnvio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelFormaEnvio)),'')+'"'+  ' FormaEnvio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.FormaEnvio),'')+'"'+  ' NivelMov="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelMov)),'')+'"'+  ' Mov="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Mov),'')+'"'+  ' NivelServicioTipo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelServicioTipo)),'')+'"'+  ' ServicioTipo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ServicioTipo),'')+'"'+  ' NivelContratoTipo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelContratoTipo)),'')+'"'+  ' ContratoTipo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ContratoTipo),'')+'"'+  ' NivelUnidadVenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelUnidadVenta)),'')+'"'+  ' UnidadVenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.UnidadVenta),'')+'"'+  ' NivelEmpresa="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelEmpresa)),'')+'"'+  ' Empresa="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Empresa),'')+'"'+  ' NivelSucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.NivelSucursal)),'')+'"'+  ' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.Sucursal)),'')+'"'+  ' Tipo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Tipo),'')+'"'+  ' Nivel="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.Nivel),'')+'"'+  ' ListaPrecios="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ListaPrecios),'')+'"'+  ' ConVigencia="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.ConVigencia)),'')+'"'+  ' FechaD="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.FechaD)),'')+'"'+  ' FechaA="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.FechaA)),'')+'"'+  ' ArticuloObsequio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Precio.ArticuloObsequio),'')+'"'+  ' CantidadObsequio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.CantidadObsequio)),'')+'"'+  ' Logico1="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.Logico1)),'')+'"'+  ' Logico2="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Precio.Logico2)),'')+'" />' FROM Precio Precio WHERE Precio.ID = @PrecioID ) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="Precio" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' PrecioID=' + CHAR(34) + ISNULL(CONVERT(varchar,@PrecioID),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
END
GO


/******************************* speCommerceSolicitudISPrecio  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISPrecio') and type = 'P') drop procedure dbo.speCommerceSolicitudISPrecio
GO             
CREATE PROCEDURE speCommerceSolicitudISPrecio
                
		@Sucursal               int, 
		@PrecioID               int,
		@eCommerceSucursal       varchar(10), 
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max) ,
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal    
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Precio" SubReferencia="Precio" Version="1.0"><Solicitud> <Precio PrecioID="'+ISNULL(CONVERT(varchar,@PrecioID),'')+'" Sucursal="'+CONVERT(varchar,@Sucursal)+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeCommercePrecioABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommercePrecioABC
GO
CREATE TRIGGER tgeCommercePrecioABC ON Precio
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @PrecioID            int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR LOCAL FOR
     SELECT ID
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID
       FROM Deleted     
  END   
  IF @Estatus IS NOT NULL
  BEGIN       
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO  @PrecioID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISPrecio  @Sucursal, @PrecioID,  @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO  @PrecioID
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END 

END
GO

/**************** spISeCommercePrecioD ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommercePrecioD') and type = 'P') drop procedure dbo.spISeCommercePrecioD 
GO             
CREATE PROCEDURE spISeCommercePrecioD
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
  @PrecioID             int,
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) ,
  @GUID                 varchar(50),
  @CantidadI            float,
  @CantidadD            float,

  @Tipo					varchar(23),
  @Articulo				varchar(20),
  @NivelArticulo		bit,
  @Usuario				varchar(10),
  @Monto				money
  
	SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
         @PrecioID= PrecioID ,
         @CantidadI = CantidadI,
         @CantidadD = CantidadD,
         @GUID = GUID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/PrecioD')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  PrecioID int, CantidadI float, CantidadD float, GUID varchar(50))
    

	SELECT @Tipo = Tipo, @Articulo = Articulo FROM Precio WHERE ID = @PrecioID
	SELECT @Monto = Monto FROM PrecioD WHERE GUID = @GUID
	IF(@Tipo IN ('Precio', 'Precio=Costo+[$]', '$ Descuento', '$ Descuento (Variable)')
		AND ISNULL(@Articulo, '') != ''
		AND (SELECT VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa) = 0)
	BEGIN
		EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, @Monto OUTPUT
	END

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    --SELECT  
    IF @Estatus IN ('ALTA','CAMBIO') 
    BEGIN
      SELECT @Tabla =(SELECT '<PrecioD ID="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),PrecioD.ID)),'')+'" Cantidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),PrecioD.Cantidad)),'')+'"'+  ' Monto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@Monto)),'')+'"'+  ' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),PrecioD.Sucursal)),'')+'" />' FROM PrecioD PrecioD WHERE PrecioD.ID = @PrecioID AND PrecioD.Cantidad = @CantidadI AND GUID = @GUID) 
    END
    ELSE   SELECT @Tabla = ''
  
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="PrecioD" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDPrecio=' + CHAR(34) + ISNULL(CONVERT(varchar,@PrecioID),'') + CHAR(34)+' CantidadAnterior=' + CHAR(34) + ISNULL(CONVERT(varchar,@CantidadD),'') + CHAR(34)+' GUID=' + CHAR(34) + ISNULL(@GUID,'') + CHAR(34) +' >'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    

END
GO


/******************************* speCommerceSolicitudISPrecioD  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISPrecioD') and type = 'P') drop procedure dbo.speCommerceSolicitudISPrecioD
GO             
CREATE PROCEDURE speCommerceSolicitudISPrecioD
                
                @Sucursal               int, 
                @PrecioID               int,
                @CantidadI              float,
                @CantidadD              float,
                @GUID                   varchar(50),
                @eCommerceSucursal      varchar(10), 
                @Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
    SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.PrecioD" SubReferencia="PrecioD" Version="1.0"><Solicitud><PrecioD PrecioID="'+ISNULL(CONVERT(varchar,@PrecioID),'')+'" CantidadI="'+ISNULL(CONVERT(varchar,@CantidadI),'')+'" CantidadD="'+ISNULL(CONVERT(varchar,@CantidadD),'')+' " GUID="'+ISNULL(@GUID,'')+'" Sucursal="'+CONVERT(varchar,@Sucursal)+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO



if exists (select * from sysobjects where id = object_id('dbo.tgeCommercePrecioDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommercePrecioDABC
GO
CREATE TRIGGER tgeCommercePrecioDABC ON PrecioD
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @PrecioID            int,
   @CantidadI           float,
   @CantidadD           float,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @GUID                varchar(50),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR FOR
     SELECT i.ID, i.Cantidad, d.Cantidad, i.GUID
       FROM Inserted i  LEFT JOIN DELETED d ON i.ID = d.ID AND i.GUID = d.GUID
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, Cantidad, NULL, GUID
       FROM Deleted     
  END       
  IF @Estatus IS NOT NULL
  BEGIN   
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO  @PrecioID, @CantidadI, @CantidadD, @GUID
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISPrecioD  @Sucursal, @PrecioID, @CantidadI, @CantidadD, @GUID,  @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      
      FETCH NEXT FROM crActualizar INTO  @PrecioID, @CantidadI, @CantidadD, @GUID
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO
/**************** speCommercePedidoCamposConfigurablesSubCuenta ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommercePedidoCamposConfigurablesSubCuenta') and type = 'P') drop procedure dbo.speCommercePedidoCamposConfigurablesSubCuenta
GO             
CREATE PROCEDURE speCommercePedidoCamposConfigurablesSubCuenta
		@iSolicitud             int,
		@Solicitud              varchar(max),
		@IDPedidoD				int,
		@Articulo				varchar(20),
		@SubCuenta				varchar(50) OUTPUT,
		@Ok int OUTPUT,
		@OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	RETURN
END
GO

/**************** speCommercePedidoEnvolturasRegalo ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommercePedidoEnvolturasRegalo') and type = 'P') drop procedure dbo.speCommercePedidoEnvolturasRegalo
GO             
CREATE PROCEDURE speCommercePedidoEnvolturasRegalo
		@iSolicitud             int,
		@Solicitud              varchar(max),
		@IDGenerar				int,
		@Ok int OUTPUT,
		@OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN

DECLARE @IDEnvoltura	int,
		@Campo	varchar(255),
		@Valor	varchar(max),
		@Articulo varchar(10),
		@SubCuenta varchar(50),
		@Renglon float,
		@RenglonID int,
		@Precio float,
		@Impuesto1 float,
		@Impuesto2 float,
		@Impuesto3 float,
		@Sucursal int,
		@Almacen varchar(10),
		@Unidad varchar(50),
		@Usuario varchar(10),
		@Empresa varchar(5),
		@Mov varchar(20),
		@Cliente varchar(10),
		@GUIDUsuario varchar(50)

DECLARE @TablaVentaDWeb table (
		ID			int,
		IDCampo		int,
		Campo	varchar(255),
		Valor	text
)
    
EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud

INSERT INTO @TablaVentaDWeb (ID, IDCampo, Campo, Valor)
SELECT        ID, IDCampo, Campo, Valor    
  FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/PedidoD/CamposConfigurables/CampoConfigurable',1)  
  WITH (ID int '../../@ID', IDCampo int, Campo varchar(50), Valor varchar(max)) 

SELECT @Empresa = Empresa, @Sucursal = Sucursal
  FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Pedido')
  WITH (Empresa varchar(5), Sucursal int)
  
  SELECT @GUIDUsuario = GUID FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Pedido/Usuario')
    WITH (GUID varchar(50))   
  IF @@ERROR<>0 SET @Ok = 1  
	 
EXEC sp_xml_removedocument @iSolicitud

SELECT @Cliente = Cliente FROM WebUsuarios WHERE  GUID = @GUIDUsuario

SELECT @Almacen = eCommerceAlmacen
 FROM Sucursal WHERE Sucursal = @Sucursal
 
SELECT @Usuario = WebUsuario
  FROM WebVersion
  
SELECT @Mov = eCommercePedido
     FROM Sucursal WHERE Sucursal = @Sucursal


DECLARE crVentaDWeb CURSOR LOCAL FOR
SELECT Campo, Valor
	FROM @TablaVentaDWeb

OPEN crVentaDWeb
FETCH NEXT FROM crVentaDWeb INTO @Campo, @Valor
WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
BEGIN
	IF(SUBSTRING(@Campo, 1, 18) = 'Envoltura Regalo #')
	BEGIN
		SELECT @IDEnvoltura = SUBSTRING(@Campo, 19, LEN(@Campo))
		
		SELECT @Articulo = Articulo, @SubCuenta = SubCuenta, @Precio = Precio
			FROM WebEnvolturaRegalo
			WHERE ID = @IDEnvoltura
			
		SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
		
		EXEC spDesglosarPrecioCImpuestos2  @Articulo , @Usuario, @Empresa, @Sucursal, @Precio OUTPUT, @Cliente, 'VTAS', @Mov, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3  OUTPUT
			
		IF(ISNULL(@Articulo, '') != '')
		BEGIN
			SELECT @Renglon = MAX(Renglon)+2048.0, @RenglonID = MAX(RenglonID) +1 FROM VentaD WHERE ID = @IDGenerar
			INSERT VentaD(ID ,        Renglon,   RenglonID, Articulo,  SubCuenta,  Almacen,  Precio,  Cantidad, CantidadInventario,   Unidad, Impuesto1,  Impuesto2,  Impuesto3)
			SELECT        @IDGenerar, @Renglon, @RenglonID, @Articulo, @SubCuenta, @Almacen, @Precio, 1,     1,                   @Unidad, @Impuesto1, @Impuesto2, @Impuesto3
		END
	END

	FETCH NEXT FROM crVentaDWeb INTO @Campo, @Valor
END
CLOSE crVentaDWeb
DEALLOCATE crVentaDWeb 
END
GO

/**************** speCommercePedidoCertificadosRegalo ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommercePedidoCertificadosRegalo') and type = 'P') drop procedure dbo.speCommercePedidoCertificadosRegalo
GO             
CREATE PROCEDURE speCommercePedidoCertificadosRegalo
		@iSolicitud             int,
		@Solicitud              varchar(max),
		@IDGenerar				int,
		@Ok int OUTPUT,
		@OkRef varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
RETURN
END
GO
/**************** speCommercePedido ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommercePedido') and type = 'P') drop procedure dbo.speCommercePedido
GO             
CREATE PROCEDURE speCommercePedido
                               @ID                     int,
                               @iSolicitud             int,
                               @Solicitud              varchar(max),
                               @Version                float,
                               @Resultado              varchar(max) = NULL OUTPUT,
                               @Ok                     int = NULL OUTPUT,    
                               @OkRef                  varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

DECLARE 
                  @Empresa              varchar(5),
                  @Sucursal             int,
                  @Mov                  varchar(20),
                  @MovID                varchar(20),
                  @Mon                  varchar(10),
                  @Cliente              varchar(10),
                  @Almacen              varchar(10),
                  @Estatus              varchar(15),
                  @FechaEmision         datetime,
                  @TipoCambio           float,
                  @Renglon              float,
                  @Articulo             varchar(20),
                  @ArticuloFlete        varchar(20),
                  @Precio               float,
                  @IDGenerar            int,  
                  @RenglonID            int,
                  @ReferenciaIS         varchar(100),
                  @SubReferencia        varchar(100),
                  @EstatusGenerado      varchar(15),
                  @ListaPreciosCliente  varchar(20),
                  @ListaPrecios         varchar(20),
                  @ClienteCommerce      int,
                  @SubCuenta            varchar(50),
                  @Referencia           varchar(50),
                  @Observaciones        varchar(100),
                  @Cantidad             float, 
                  @Unidad               varchar(20),
                  @Impuesto1            float, 
                  @Impuesto2            float, 
                  @Impuesto3            float,
                  @DescuentoGlobal      float,
                  @EnviarA              int,
                  @Usuario              varchar(10) ,
                  @CostoFlete           float,
                  @DescuentoFlete       float,
                  @Tipo                 varchar(50),
                  @RFC                  varchar(15),
                  @eMail                varchar(255),
                  @IDUsuario            int,
                  @IDEnviar             int,
                  @IDFormaPago          varchar(50),
                  @FormaPago            varchar(50),
                  @ReferenciaFormaPago  varchar(50),
                  @Condicion            varchar(50),
                  @Prepagado            bit,
                  @CtaDinero            varchar(10),
                  @Importe              float,
                  @Cajero               varchar(10),
                  @Agente               varchar(10),
                  @GUIDUsuario          varchar(50),
                  @GUIDEnviarA          varchar(50),
                  @Categoria            varchar(50),
                  @RequiereFactura2     varchar(5),
                  @RequiereFactura3     varchar(5),
		  @RequiereFactura      bit,

		  @Error                int,
		  @DescuentoLinea       float,
		   @IDPedidoD			int,

		   @FechaEntrega datetime,
		   @PedidoID	int,
		   @RenglonIDSerieLote	int,
		   @CodigoCR			varchar(50),
		   @SKUVentaD			varchar(50),
		   @IDGenerarVale            int,
		   @MovVale                  varchar(20),
		   @TipoVale				varchar(50),
		   @ConceptoVale				varchar(50)

  DECLARE
                  @Tabla               table
                 (Empresa      varchar(5),
                  Sucursal     int,
                  Mov          varchar(20),
                  Mon          varchar(10),
                  Cliente      varchar(10),
                  Almacen      varchar(10),
                  Estatus      varchar(15),
                  Usuario      varchar(10),
                  FechaEmision datetime,
                  TipoCambio   float  ,
                  ListaPreciosEsp varchar(20) ,
                  EnviarA      int     
                 )

  DECLARE
                               @Tabla2 table
                               (Renglon       float,
                                RenglonID     int,
                                SKU           varchar(50),
                                SubCuenta     varchar(50),
                                Articulo      varchar(20),
                                Unidad        varchar(20),
                                Almacen       varchar(10),
                                Precio        float,
                                Cantidad      float,
                                DescuentoLinea float,

                                ID				int,
                                CodigoCR		varchar(50)
                                 )





                                 
DECLARE @TablaVentaDWeb table (
		ID		int,
		Campo	varchar(255),
		Valor	text
)

DECLARE @Tabla3 table(ID  int, Nombre varchar(100), Apellidos varchar(100),eMail varchar(250),Contrasena varchar(50),Telefono varchar(50),RFC varchar(20), Compania varchar(250) )
DECLARE @Direccion table(Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30), Delegacion varchar(50), Colonia    varchar(50),NoExterior varchar(50))
DECLARE @Direccion2 table(Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30), GUID varchar(50),Delegacion varchar(50), Colonia    varchar(50),NoExterior varchar(50),Nombre varchar(100), Apellido varchar(100),eMail varchar(250),Telefono varchar(50))

BEGIN TRANSACTION 
	
  IF @Ok IS NULL
  BEGIN
  
  SELECT @Usuario = WebUsuario
    FROM WebVersion
    
  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @ClienteCommerce = Cliente, @EnviarA = EnviarA,  @Observaciones =  Observaciones, @Referencia = Referencia, @DescuentoGlobal = DescuentoGlobal, @CostoFlete = CostoFlete, @DescuentoFlete = DescuentoFlete, @IDFormaPago = FormaPago, @ReferenciaFormaPago = ReferenciaFormaPago, @Importe = Importe, @RequiereFactura2 = RequiereFactura, @FechaEntrega = FechaEntrega, @PedidoID = PedidoID
    FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Pedido')
    WITH (Empresa varchar(5), Sucursal int, Cliente int, EnviarA int, Observaciones varchar(100), Referencia varchar(50),  DescuentoGlobal float, CostoFlete   float, DescuentoFlete float, FormaPago  varchar(50), ReferenciaFormaPago  varchar(50), Importe float, RequiereFactura varchar(5), FechaEntrega datetime, PedidoID int)
  SELECT  @ClienteCommerce = NULLIF(@ClienteCommerce,0)
  IF @@ERROR<>0 SET @Ok = 1
  
  SELECT @IDGenerar = IDPedido
	FROM eCommercePedido
	WHERE Sucursal = @Sucursal
	AND IDPedido = @PedidoID
	
  IF(ISNULL(@IDGenerar, '') != '')
  BEGIN

  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia 
    FROM IntelisisService 
   WHERE ID = @ID

  SELECT @EstatusGenerado = Estatus, @Mov = Mov, @MovID = MovID
    FROM Venta
   WHERE ID = @IDGenerar  
  
	COMMIT TRANSACTION 
	SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="Venta" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) + ' Consecutivo='+ CHAR(34) +ISNULL(@Mov,'')+' '+ISNULL(@MovID,'')+ CHAR(34) +' EstatusMov='+ CHAR(34) +ISNULL(@EstatusGenerado,'')+ CHAR(34) + ' IDUsuario=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDUsuario),'') + CHAR(34)+ ' IDEnviarA=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDEnviar),'') + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'  
	RETURN
  END

  SELECT @RequiereFactura = CASE WHEN @RequiereFactura2 = 'ON' THEN 1 ELSE 0 END
  SELECT  @FormaPago = w.FormaPago , @Prepagado = ISNULL(Prepagado,0), @CtaDinero = w.CtaDinero
    FROM WebFormaPago w JOIN WebFormaPagoOmision o ON o.Nombre = w.FormaPagoWeb
   WHERE o.IDForma = @IDFormaPago  AND w.Sucursal = @Sucursal
   
   SELECT @Agente = eCommerceAgente
     FROM Sucursal
    WHERE Sucursal = @Sucursal     
   
   IF @Prepagado = 1
   SELECT @Condicion = NULLIF(eCommerceCondicion,''), @Cajero = NULLIF(eCommerceCajero,'') FROM Sucursal WHERE Sucursal = @Sucursal
   
  IF @Ok IS NULL
  SELECT @GUIDEnviarA = GUID FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/DireccionEnvio',1)  
    WITH (GUID varchar(50))   
  IF @@ERROR<>0 SET @Ok = 1  


  


  IF @Ok IS NULL
  SELECT @RFC = RFC , @eMail = eMail, @GUIDUsuario = GUID, @RequiereFactura3 = RequiereFactura FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Pedido/Usuario')
    WITH (RFC varchar(15),eMail varchar(250), GUID varchar(50), RequiereFactura char(5))   
  IF @@ERROR<>0 SET @Ok = 1  
  
  IF NULLIF(@GUIDUsuario,'') IS NULL  
    SELECT @Ok = 71020   
    
  SELECT @RequiereFactura = CASE WHEN @RequiereFactura2 IN ('ON', 'Si') THEN 1 ELSE 0 END
  SELECT @RequiereFactura = CASE WHEN @RequiereFactura3 IN ('ON', 'Si') THEN 1 ELSE 0 END
    
  IF NULLIF(@RFC,'') IS NULL  AND @RequiereFactura = 1
    SELECT @Ok = 71020   
  
  IF @ClienteCommerce IS NULL
    SELECT @ClienteCommerce = ID FROM WebUsuarios WHERE GUID = @GUIDUsuario
  
 IF @Ok IS NULL
  BEGIN
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Tabla3(ID,              Nombre , Apellidos,   eMail, Contrasena , Telefono, RFC ,Compania )  
  SELECT        @ClienteCommerce, Nombre , Apellidos,   eMail, Contrasena , Telefono, RFC ,Compania     
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Pedido/Usuario')
    WITH (Nombre varchar(100), Apellidos varchar(100),eMail varchar(250),Contrasena varchar(50),Telefono varchar(50),RFC varchar(20), Compania varchar(250) ) 
  EXEC sp_xml_removedocument @iSolicitud
  IF @@ERROR<>0 SET @Ok = 1
  END



  IF @Ok IS NULL
  BEGIN
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Direccion(Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NoExterior  )  
  SELECT            Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NumeroExterior      
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/DireccionFactura',1)  
    WITH (Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30), Colonia varchar(50), Delegacion  varchar(50), NumeroExterior  varchar(50)) 
  EXEC sp_xml_removedocument @iSolicitud
  IF @@ERROR<>0 SET @Ok = 1  
  END
  
  IF @Ok IS NULL
  BEGIN
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Direccion2(Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NoExterior, Nombre, Apellido, eMail,Telefono )  
  SELECT             Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NumeroExterior,Nombre, Apellido, eMail,Telefono    
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/DireccionEnvio',1)  
    WITH (Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30), Colonia varchar(50), Delegacion  varchar(50), NumeroExterior  varchar(50), Nombre  varchar(100), Apellido varchar(100), eMail varchar(250),Telefono varchar(50) ) 
  EXEC sp_xml_removedocument @iSolicitud
  IF @@ERROR<>0 SET @Ok = 1   
  END


  IF @ClienteCommerce IS NULL
  BEGIN
    SELECT @Tipo = eCommerceTipoConsecutivo FROM Sucursal WHERE Sucursal = @Sucursal
    IF NULLIF(@Tipo,'') IS NULL SET @Ok = 53040
    
	IF(ISNULL(@Ok, '') = '' AND ISNULL(@RequiereFactura, 0) = 1)
	BEGIN
		SELECT @Tipo = eCommerceTipoConsecutivoFact FROM Sucursal WHERE Sucursal = @Sucursal
		IF NULLIF(@Tipo,'') IS NULL SET @Ok = 53040
	END
	
    EXEC spConsecutivo @Tipo, @Sucursal, @Cliente OUTPUT

    IF @Cliente IS NULL SET @Ok = 26060 
    
    IF ISNULL(@RFC, '') != '' AND EXISTS(SELECT RFC FROM Cte WHERE RFC = @RFC AND Cliente <> @Cliente)
      UPDATE @Tabla3 SET RFC =  'XAXX010101000'
    
    IF @Cliente IS NOT NULL AND @OK IS NULL
    BEGIN  
    
      INSERT Cte(Cliente,  Nombre,                             eMail1,   Telefonos,  Contacto1,                       RFC,   Direccion,             DireccionNumeroInt,         Pais,     Estado,   Poblacion, CodigoPostal, Estatus, Delegacion,  DireccionNumero, Colonia)
      SELECT     @Cliente,a.Nombre+' '+ISNULL(a.Apellidos,''), a.eMail,  a.Telefono, a.Nombre+' '+ISNULL(a.Apellidos,''), a.RFC, ISNULL(d.Direccion1,''),ISNULL(d.Direccion2,''),  d.Pais, d.Estado, d.Ciudad,  d.CP,         'ALTA',  d.Delegacion, d.NoExterior,   d.Colonia
        FROM @Tabla3 a JOIN @Direccion d ON 1=1


      IF @@ERROR<>0 SET @Ok = 1   
    END      
    IF EXISTS(SELECT * FROM WebUsuario WHERE eMail = @eMail)  
      SELECT @Ok = 3, @OkRef= 'Ya Existe Un Usuario Con EL Mismo Correo'
      
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM WebUsuario WHERE eMail = @eMail) AND @Ok IS NULL
    BEGIN
      INSERT WebUsuarios(eMail, eMail2,  Telefono,  FechaAlta, UltimoCambio,  Empresa,  Sucursal,  Cliente, Contrasena, ContrasenaConfirmacion, Nombre, Apellido, GUID  )
      SELECT            eMail1, eMail2, Telefonos, GETDATE(), GETDATE(),    @Empresa, @Sucursal, Cliente, Contrasena, Contrasena ,dbo.fnWebSepararContacto(Contacto1,1),  dbo.fnWebSepararContacto(Contacto1,2) , @GUIDUsuario
        FROM  Cte
       WHERE Cliente = @Cliente
       IF @@ERROR<>0 SET @Ok = 1  
     
      SELECT @IDUsuario = SCOPE_IDENTITY()    
      
      UPDATE @Tabla3 SET ID = @IDUsuario
    
    END   
   
        
  END
  ELSE
  BEGIN
    IF @ClienteCommerce IS NOT NULL AND EXISTS(SELECT * FROM WebUsuarios WHERE GUID = @GUIDUsuario)AND @Ok IS NULL
    BEGIN
      UPDATE WebUsuarios SET eMail = ISNULL(NULLIF(t.eMail,''),w.eMail), Telefono = ISNULL(NULLIF(t.Telefono,''),w.Telefono),  UltimoCambio = GETDATE(),   Contrasena = ISNULL(NULLIF(t.Contrasena,''),w.Contrasena), ContrasenaConfirmacion = ISNULL(NULLIF(t.Contrasena,''),w.Contrasena), Nombre = ISNULL(NULLIF(t.Nombre,''),w.Nombre) , Apellido = ISNULL(NULLIF(t.Apellidos,''),w.Apellido)
        FROM @Tabla3 t JOIN WebUsuarios w ON t.ID = w.ID
       WHERE w.ID = @ClienteCommerce
      IF @@ERROR<>0 SET @Ok = 1   
      SELECT @IDUsuario = @ClienteCommerce
    END 
    SELECT @Cliente = Cliente FROM WebUsuarios WHERE  GUID = @GUIDUsuario
    
    IF ISNULL(@RFC, '') != '' AND EXISTS(SELECT RFC FROM Cte WHERE RFC = @RFC AND Cliente <> @Cliente)
      UPDATE @Tabla3 SET RFC =  'XAXX010101000'
    
    IF @Cliente IS NOT NULL AND EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente )
    BEGIN
      UPDATE Cte SET Telefonos =a.Telefono, RFC = a.RFC,   Direccion = ISNULL(d.Direccion1,''), DireccionNumeroInt = ISNULL(d.Direccion2,''), Pais =  d.Pais,     Estado = d.Estado,   Poblacion = d.Ciudad, CodigoPostal = d.CP, Delegacion = d.Delegacion, DireccionNumero = d.NoExterior, Colonia = d.Colonia,
      		Contacto1 = CASE
				WHEN ISNULL(Contacto1, '') = '' THEN a.Nombre+' '+ISNULL(a.Apellidos,'') 
				ELSE Contacto1 END,
			eMail1 = CASE
				WHEN ISNULL(eMail1, '') = '' THEN a.eMail
				ELSE eMail1 END
        FROM Cte c JOIN @Tabla3 a ON c.Cliente = @Cliente
        JOIN @Direccion d ON 1=1


      IF @@ERROR<>0 SET @Ok = 1     
      IF @Ok IS NULL UPDATE WebUsuarios SET eMail = eMail    WHERE ID = @ClienteCommerce
    END  
  END  
  IF @Ok IS NULL AND EXISTS(SELECT * FROM @Direccion2) AND @Ok IS NULL
  BEGIN
    IF EXISTS(SELECT * FROM CteEnviarA  WHERE Cliente = @Cliente AND GUID= @GUIDEnviarA)
    BEGIN
      SELECT @EnviarA = ID FROM CteEnviarA WHERE Cliente = @Cliente AND GUID = @GUIDEnviarA
      
      UPDATE CteEnviarA SET Nombre = ISNULL(d.Nombre,'')+' '+ISNULL(d.Apellido,''), Direccion = ISNULL(d.Direccion1,''), DireccionNumeroInt = ISNULL(d.Direccion2,''), Pais = d.Pais, Estado = d.Estado, Poblacion= d.Ciudad, CodigoPostal=  d.CP, Delegacion = d.Delegacion, DireccionNumero = d.NoExterior, Colonia = d.Colonia, eMail1 = d.eMail, Telefonos = d.Telefono


        FROM @Direccion2 d 
        LEFT JOIN WebUsuarios c ON 1=1 AND  c.ID = @IDUsuario
        JOIN CteEnviarA a ON a.Cliente = @Cliente
       WHERE a.Cliente = @Cliente  AND a.ID = @EnviarA AND a.GUID = @GUIDEnviarA
      IF @@ERROR <> 0 SET @Ok = 1
      
      SELECT @IDEnviar = @EnviarA
       
    END
    ELSE
    BEGIN  
      SELECT @EnviarA =  MAX(ID) FROM CteEnviarA WHERE Cliente = @Cliente
      SELECT @IDEnviar = ISNULL(@EnviarA,0)+1
  
      
      IF @IDEnviar IS NOT NULL AND @Ok IS NULL
      INSERT CteEnviarA(ID,        Cliente,  Nombre,                                        Direccion,          DireccionNumeroInt,                                          Pais,     Estado,   Poblacion, CodigoPostal, Estatus, GUID,        Delegacion,  DireccionNumero, Colonia,   eMail1, Telefonos)
      SELECT            @IDEnviar, @Cliente,ISNULL(d.Nombre,'')+' '+ISNULL(d.Apellido,''), ISNULL(d.Direccion1,''),ISNULL(d.Direccion2,''), d.Pais, d.Estado, d.Ciudad,  d.CP,         'ALTA', @GUIDEnviarA, d.Delegacion, d.NoExterior,   d.Colonia, d.eMail, d.Telefono
        FROM @Direccion2 d /*JOIN WebPais p ON d.Pais = p.ID
        JOIN WebPaisEstado e ON  e.IDPais = p.ID AND e.ID = d.Estado */
        JOIN WebUsuarios c ON c.GUID= @GUIDUsuario
      IF @@ERROR<>0 SET @Ok = 1  
    END  
  
  END    

  SELECT @Cliente = Cliente FROM WebUsuarios WHERE  GUID = @GUIDUsuario
  
  SELECT @ListaPreciosCliente = ListaPreciosEsp FROM Cte WHERE Cliente = @Cliente
  SELECT @FechaEmision = dbo.fnFechaSinHora(GETDATE())
  
  SELECT @Mon = DefMoneda  FROM Usuario
   WHERE Usuario = @Usuario
   SELECT @Almacen = eCommerceAlmacen , @Mov = eCommercePedido, @ListaPrecios = eCommerceListaPrecios, @TipoVale = eCommerceCRTipo, @ConceptoVale = eCommerceCRConcepto
     FROM Sucursal WHERE Sucursal = @Sucursal
     
   SELECT TOP 1 @MovVale = Mov FROM MovTipo WHERE Modulo = 'VALE' AND Clave = 'VALE.ET' ORDER BY Orden ASC
   
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Mon 



  INSERT @Tabla(Empresa,  Mov,  Estatus,      FechaEmision,  Mon,  TipoCambio,  Cliente,  Usuario, Almacen, ListaPreciosEsp, Sucursal, EnviarA)
  SELECT        @Empresa, @Mov, 'SINAFECTAR', @FechaEmision, @Mon, @TipoCambio, @Cliente, @Usuario, @Almacen, ISNULL(@ListaPreciosCliente,@ListaPrecios), @Sucursal, @IDEnviar

     	
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
 
  INSERT @Tabla2(Renglon, RenglonID, SKU, Almacen , Precio, Cantidad,DescuentoLinea, ID, CodigoCR)  
  SELECT         NULL , NULL,        SKU, @Almacen , Precio, Cantidad ,DescuentoLinea, ID, CodigoCR
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/PedidoD',1)
    WITH (SKU varchar(50), Precio  float, Cantidad float, DescuentoLinea float, ID int, CodigoCR varchar(50))
  EXEC sp_xml_removedocument @iSolicitud
  
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud
  
	INSERT INTO @TablaVentaDWeb (ID, Campo, Valor)
    SELECT        ID, Campo, Valor    
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Pedido/PedidoD/CamposConfigurables/CampoConfigurable',1)  
    WITH (ID int '../../@ID', Campo varchar(50), Valor varchar(max)) 
    
  EXEC sp_xml_removedocument @iSolicitud
  
  SET @Renglon = 0.0
  SET @RenglonID = 0
  SET @RenglonIDSerieLote = 0
  UPDATE @Tabla2
     SET @Renglon = Renglon = @Renglon + 2048.0, @RenglonID = RenglonID = @RenglonID +1, Articulo = dbo.fnWebSKUArticulo(SKU), SubCuenta = dbo.fnWebSKUArticuloSubCuenta(SKU), Unidad = (SELECT  Unidad FROM Art WHERE Articulo = dbo.fnWebSKUArticulo(SKU))
    FROM @Tabla2

    
  UPDATE @Tabla2
     SET Articulo = dbo.fnWebArticuloCR(@Sucursal, Precio), SubCuenta = dbo.fnWebSubCuentaCR(@SubCuenta, Precio)
    FROM @Tabla2
    WHERE SKU = 'CR'
   
  IF @Ok IS NULL
  BEGIN
    INSERT Venta (Empresa, Mov, Estatus,  FechaEmision, Moneda, TipoCambio, Cliente, Usuario, Almacen, ListaPreciosEsp, Sucursal, SucursalOrigen, SucursalDestino, EnviarA, DescuentoGlobal,  Observaciones,  Referencia,  Condicion,      Agente,  OrigenTipo, FechaRequerida )
    SELECT        Empresa, Mov, Estatus,  FechaEmision, Mon,    TipoCambio, Cliente, Usuario, Almacen, ListaPreciosEsp, Sucursal, Sucursal,       Sucursal,        EnviarA, 0,				@Observaciones, @Referencia, @Condicion,@Agente, 'eCommerce',		@FechaEntrega
      FROM @Tabla   
    IF @@ERROR <> 0 SET @Ok = 1  
    SELECT @IDGenerar = SCOPE_IDENTITY()
    
    
    IF @Ok IS NULL AND @IDGenerar IS NOT NULL 
    BEGIN
      DECLARE crDetalle CURSOR FOR
       SELECT Renglon, RenglonID, Articulo, SubCuenta ,Almacen, Precio, Cantidad, Unidad, DescuentoLinea, ID, CodigoCR, SKU
         FROM @Tabla2
      OPEN crDetalle 
      FETCH NEXT FROM crDetalle INTO @Renglon, @RenglonID, @Articulo, @SubCuenta , @Almacen, @Precio, @Cantidad, @Unidad, @DescuentoLinea, @IDPedidoD, @CodigoCR, @SKUVentaD
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
      BEGIN
        IF NULLIF(@Articulo,'') IS NULL SELECT @Ok = 20400
        IF @Cantidad IS NULL SELECT @Ok = 20015
        EXEC spDesglosarPrecioCImpuestos2  @Articulo, @Usuario, @Empresa, @Sucursal, @Precio OUTPUT, @Cliente, 'VTAS', @Mov, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3  OUTPUT
    
		SELECT @DescuentoLinea = dbo.fneCommerceCalcDescuentosVenta(@DescuentoGlobal, @DescuentoLinea)
		
		-- Para ETC: Sacar subcuenta de campos configurables. En version siempre regresa la misma SubCuenta que se metio
		IF(ISNULL(@SubCuenta, '') = '')
			EXEC speCommercePedidoCamposConfigurablesSubCuenta @iSolicitud, @Solicitud, @IDPedidoD, @Articulo, @SubCuenta OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
        IF @Ok IS NULL
        INSERT VentaD(ID ,        Renglon,   RenglonID,  Articulo,  SubCuenta,  Almacen,  Precio, PrecioSugerido, Cantidad, CantidadInventario,  Unidad, Impuesto1,  Impuesto2,  Impuesto3, DescuentoLinea)
        SELECT        @IDGenerar, @Renglon, @RenglonID, @Articulo, @SubCuenta ,@Almacen, @Precio, @Precio,		  @Cantidad, @Cantidad,          @Unidad, @Impuesto1, @Impuesto2, @Impuesto3, @DescuentoLinea
  
        IF @@ERROR <> 0 SET @Ok = 1
        
        -- Si el articulo que se esta comprando es un certificado de Regalo, genero la Emision de Tarjetas en Vales
        -- Tambien ingreso la Serie/Lote del articulo para esta venta
        IF @OK IS NULL AND @SKUVentaD = 'CR'
        BEGIN
        	INSERT INTO Vale (Empresa, Mov,		 FechaEmision, Moneda, TipoCambio, Usuario, Estatus,	Sucursal, SucursalOrigen,	Concepto,		Tipo,	   Precio, Articulo, Almacen, FechaInicio, Vencimiento)
			SELECT			  Empresa, @MovVale, GETDATE(),	   Mon,	 TipoCambio, Usuario, 'SINAFECTAR', @Sucursal, @Sucursal, @ConceptoVale, @TipoVale, @Precio, @Articulo, @Almacen, GETDATE(), GETDATE()
				FROM @Tabla
			SELECT @IDGenerarVale = SCOPE_IDENTITY()

			IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'Al insertar Vale'
			
			INSERT INTO ValeD (ID, Serie, Sucursal, SucursalOrigen, Importe)
			SELECT				@IDGenerarVale, @CodigoCR, @Sucursal, @Sucursal, NULL
			
			IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = 'Al insertar Detalle de Vale'
			
		  IF @Ok IS NULL AND @IDGenerar IS NOT NULL
			EXEC spAfectar 'VALE', @IDGenerarVale, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1,  @Ok = @Error OUTPUT, @OkRef = @OkRef OUTPUT

			IF @Ok IS NULL
			BEGIN
				SET @RenglonIDSerieLote = @RenglonIDSerieLote + 1
				INSERT INTO SerieLoteMov (
					Empresa,
					Modulo,
					ID,
					RenglonID,
					Articulo,
					SubCuenta,
					SerieLote,
					Cantidad,
					CantidadAlterna,
					Propiedades,
					Ubicacion,
					Cliente,
					Localizacion,
					Sucursal,
					ArtCostoInv
					)
				SELECT
					Empresa,
					'VTAS',
					@IDGenerar,
					@RenglonIDSerieLote,
					@Articulo,
					@SubCuenta,
					@CodigoCR,
					@Cantidad,
					NULL,
					NULL,
					NULL,
					NULL,
					NULL,
					@Sucursal,
					NULL
				FROM @Tabla
			END
        END
        
		IF @@ERROR <> 0 SET @Ok = 1
        
        IF @Ok IS NULL
        BEGIN
			DELETE FROM VentaDWeb WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonSub = 0
			INSERT VentaDWeb (ID,		  Renglon,  RenglonSub, Campo, Valor)
			SELECT			  @IDGenerar, @Renglon, 0,			Campo, Valor
			FROM @TablaVentaDWeb
			WHERE ID = @IDPedidoD
        END

 
        FETCH NEXT FROM crDetalle INTO @Renglon, @RenglonID, @Articulo, @SubCuenta , @Almacen, @Precio, @Cantidad, @Unidad, @DescuentoLinea, @IDPedidoD, @CodigoCR, @SKUVentaD
      END
      CLOSE crDetalle
      DEALLOCATE crDetalle  

    END
    IF @Ok IS NULL AND NULLIF(@CostoFlete,'') IS NOT NULL AND ISNULL(NULLIF(@CostoFlete,''),0.0)>0.0
    BEGIN
      SELECT @ArticuloFlete = eCommerceArticuloFlete FROM Sucursal WHERE Sucursal = @Sucursal
      SELECT  @Unidad = Unidad FROM Art WHERE Articulo = @ArticuloFlete
      IF NULLIF(@ArticuloFlete,'') IS NOT NULL
      BEGIN
        SELECT @Renglon = MAX(Renglon)+2048.0, @RenglonID = MAX(RenglonID) +1 FROM VentaD WHERE ID = @IDGenerar
        EXEC spDesglosarPrecioCImpuestos2  @ArticuloFlete , @Usuario, @Empresa, @Sucursal, @CostoFlete OUTPUT, @Cliente, 'VTAS', @Mov, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3  OUTPUT
        INSERT VentaD(ID ,        Renglon,   RenglonID,  Articulo,      Almacen,  Precio, PrecioSugerido, Cantidad, CantidadInventario,   Unidad, Impuesto1,  Impuesto2,  Impuesto3)
        SELECT        @IDGenerar, @Renglon, @RenglonID, @ArticuloFlete, @Almacen, @CostoFlete, @CostoFlete,  1,     1,                   @Unidad, @Impuesto1, @Impuesto2, @Impuesto3
        
        IF(@DescuentoFlete > 0) UPDATE VentaD SET DescuentoTipo = '%', DescuentoLinea = @DescuentoFlete WHERE ID = @IDGenerar AND Renglon = @Renglon AND RenglonID = @RenglonID
      END
    
    END
 
  END
  
  IF @Ok IS NULL AND @IDGenerar IS NOT NULL 
    EXEC spInvReCalcEncabezadoSimple  @Empresa, @IDGenerar, 'VTAS'
    
  IF @Ok IS NULL AND @IDGenerar IS NOT NULL 
	EXEC speCommercePedidoEnvolturasRegalo @iSolicitud, @Solicitud, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
	
  IF @Ok IS NULL AND @IDGenerar IS NOT NULL 
	EXEC speCommercePedidoCertificadosRegalo @iSolicitud, @Solicitud, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
    
  SELECT @Importe = (Importe+Impuestos)-(Importe*ISNULL(DescuentoGlobal,0.0)/100) FROM Venta WHERE ID = @IDGenerar    

  IF @Prepagado = 1 AND NULLIF(@CtaDinero,'') IS NOT NULL AND @Ok IS NULL AND ISNULL(@Importe,0.0) >0.0 AND NULLIF(@Condicion,'') IS NOT NULL
  BEGIN
    INSERT VentaCobro(ID,         Importe1, FormaCobro1, Referencia1,          CtaDinero, Cajero)
    SELECT            @IDGenerar, @Importe, @FormaPago,  @ReferenciaFormaPago, @CtaDinero, @Cajero
  END
  
  IF @Ok IS NULL AND @IDGenerar IS NOT NULL
    EXEC spAfectar 'VTAS', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, @EnSilencio = 1, @Conexion = 1,  @Ok = @Error OUTPUT, @OkRef = @OkRef OUTPUT
    
 
  IF @Error IS NOT NULL AND @IDGenerar IS NOT NULL 
    UPDATE Venta SET Estatus = 'CONFIRMAR' WHERE ID = @IDGenerar     
      
  IF @Error IS NULL
    SELECT @MovID = MovID FROM Venta WHERE ID = @IDGenerar   
    
  IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia 
    FROM IntelisisService 
   WHERE ID = @ID


  IF @Ok IS NULL
  SELECT @EstatusGenerado = Estatus
    FROM Venta
   WHERE ID = @IDGenerar   
  
     

  IF @Ok IS NULL

  BEGIN
	INSERT INTO eCommercePedido (IDVenta, Sucursal, IDPedido) VALUES (@IDGenerar, @Sucursal, @PedidoID)
    COMMIT TRANSACTION 
  END ELSE
  BEGIN
  ROLLBACK TRANSACTION 
      SELECT @OkRef = 'ERROR: ' + CONVERT(varchar,@Ok) + ' '+ dbo.fneWebConvertirDescripcionHTML(ISNULL(@OkRef,'')) +'. '  +ISNULL((SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok),'') 
  END
  IF @Error IS NOT NULL
    SET @Ok = @Error
    SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Modulo="Venta" ModuloID =' + CHAR(34) + ISNULL(CONVERT(varchar,@IDGenerar),'') + CHAR(34) + ' Consecutivo='+ CHAR(34) +ISNULL(@Mov,'')+' '+ISNULL(@MovID,'')+ CHAR(34) +' EstatusMov='+ CHAR(34) +ISNULL(@EstatusGenerado,'')+ CHAR(34) + ' IDUsuario=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDUsuario),'') + CHAR(34)+ ' IDEnviarA=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDEnviar),'') + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'  
  END 
 END
GO

----declare @datos		  varchar(8000),
----		@iSolicitud	int,
----		@Resultado  varchar(8000),
----		@Ok			int,
----		@OkRef		varchar(255),
----		@Id			int
		    
----set @Ok = null
----set @OkRef = null
----set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Pedido" SubReferencia="" Version="1.0"><Solicitud>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Pedido" SubReferencia="" Version="1.0">
--        <Solicitud  Empresa ="DEMO" Sucursal="0" >
--                <Pedido Cliente="1" Moneda="Pesos" TipoCambio="1.000000000000000e+000"  Importe="0.0000" Impuestos="0.0000" Sucursal="0">
--                        <PedidoD Cantidad="3" SKU="2" Precio="7.000000000000000e+000" />
--                        <PedidoD Cantidad="1" SKU="3" Precio="9.000000000000000e+001" />
--                </Pedido>             
--        </Solicitud>
--</Intelisis>
----</Solicitud></Intelisis>'

----EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado OUTPUT,@Ok Output,@OkRef Output,1,0,@Id Output
----select @Resultado
----select * from IntelisisService order by id desc
/**************** speCommerceWebUsuarioCliente ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceWebUsuarioCliente') and type = 'P') drop procedure dbo.speCommerceWebUsuarioCliente
GO             
CREATE PROCEDURE speCommerceWebUsuarioCliente
                               @ID                     int,
                               @iSolicitud             int,
                               @Solicitud              varchar(max),
                               @Version                float,
                               @Resultado              varchar(max) = NULL OUTPUT,
                               @Ok                     int = NULL OUTPUT,    
                               @OkRef                  varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

DECLARE 
                  @Empresa       varchar(5),
                  @Sucursal      int,
                  @ReferenciaIS  varchar(100),
                  @SubReferencia varchar(100),
                  @Cliente       varchar(10),
                  @IDUsuario     int,
                  @Tipo          varchar(20),
                  @Usuario       varchar(10),
                  @RFC           varchar(15),
                  @eMail         varchar(250),
                  @GUID          varchar(50),
                  @Categoria     varchar(50),

                  @RequiereFactura	smallint

                                                                                                                             
DECLARE @Tabla table(Nombre varchar(100), Apellidos varchar(100),eMail varchar(250),Contrasena varchar(50),Telefono varchar(50),RFC varchar(20), Compania varchar(250), GUID          varchar(50) )
DECLARE @Direccion table(Direccion1 varchar(255), 
                         Direccion2 varchar(255),
                         Ciudad varchar(100),
                         Pais varchar(100),
                         Estado varchar(100),
                         CP varchar(30), 
                         Delegacion varchar(50),
                         Colonia    varchar(50),
                         NoExterior varchar(50))
BEGIN TRANSACTION 
                
  IF @Ok IS NULL
  BEGIN
  
  SELECT @Usuario = WebUsuario
    FROM WebVersion  

  SELECT @Empresa = Empresa, @Sucursal = Sucursal FROM openxml (@iSolicitud,'/Intelisis/Solicitud')
    WITH (Empresa varchar(5), Sucursal int)

  SELECT @RFC = RFC , @eMail = eMail, @RequiereFactura = RequiereFactura, @GUID = GUID FROM openxml (@iSolicitud,'/Intelisis/Solicitud/Usuario')
    WITH (RFC varchar(15),eMail varchar(250), RequiereFactura smallint, GUID varchar(50))



    
  IF NULLIF(@GUID,'') IS NULL  
    SELECT @Ok = 71020   

  IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia 
    FROM IntelisisService 
   WHERE ID = @ID
    
  SELECT @Categoria = NULLIF(eCommerceCteCat,'') FROM Sucursal WHERE Sucursal = @Sucursal  
  
  
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Tabla(Nombre , Apellidos,        eMail, Contrasena , Telefono, RFC ,Compania, GUID )  
  SELECT         Nombre , Apellidos,        eMail, Contrasena , Telefono, RFC ,Compania ,GUID    
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Usuario',1)  
    WITH (Nombre varchar(100), Apellidos varchar(100),eMail varchar(250),Contrasena varchar(50),Telefono varchar(50),RFC varchar(20), Compania varchar(250),GUID varchar(50) ) 
  EXEC sp_xml_removedocument @iSolicitud
  
  IF @@ERROR<>0 SET @Ok = 1
  
  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Direccion(Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NoExterior )  
  SELECT            Direccion1 , Direccion2, Ciudad, Pais , Estado, CP, Colonia, Delegacion, NumeroExterior
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Usuario/Direccion',1)  
    WITH (Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30), Colonia varchar(50), Delegacion varchar(50), NumeroExterior varchar(50)) 
  EXEC sp_xml_removedocument @iSolicitud
  IF @@ERROR<>0 SET @Ok = 1


  SELECT @Tipo = eCommerceTipoConsecutivo FROM Sucursal WHERE Sucursal = @Sucursal
  IF NULLIF(@Tipo,'') IS NULL SET @Ok = 53040
  
  IF(ISNULL(@Ok, '') = '' AND ISNULL(@RequiereFactura, 0) = 1)
  BEGIN
	SELECT @Tipo = eCommerceTipoConsecutivoFact FROM Sucursal WHERE Sucursal = @Sucursal
	IF NULLIF(@Tipo,'') IS NULL SET @Ok = 53040
  END

  IF @Ok IS NULL
	  IF NOT EXISTS(SELECT * FROM WebUsuarios WHERE GUID = @GUID)
	  BEGIN
	    IF EXISTS(SELECT * FROM WebUsuario WHERE eMail = @eMail)  

			SELECT @Ok = 3, @OkRef= 'Ya Existe Un Usuario Con EL Mismo Correo'
	  


		EXEC spConsecutivo @Tipo, @Sucursal, @Cliente OUTPUT
	    
		IF @Cliente IS NULL SET @Ok = 26060 
	    
		IF ISNULL(@RFC, '') != '' AND EXISTS(SELECT RFC FROM Cte WHERE RFC = @RFC AND Cliente <> @Cliente)
		  UPDATE @Tabla SET RFC =  'XAXX010101000'
	    
		IF @Cliente IS NOT NULL AND @Ok IS NULL AND EXISTS (SELECT * FROM @Direccion)
		INSERT Cte(Cliente,  Nombre,   eMail1,   Telefonos,  Contacto1,                           RFC,   Direccion, DireccionNumeroInt,                                        Pais,     Estado,   Poblacion, CodigoPostal, Estatus, Delegacion, DireccionNumero, Colonia, Categoria)
		SELECT     @Cliente, a.Nombre+' '+ISNULL(a.Apellidos,''), a.eMail,  a.Telefono, a.Nombre+' '+ISNULL(a.Apellidos,''), a.RFC, ISNULL(d.Direccion1,''),ISNULL(d.Direccion2,''),  d.Pais, d.Estado, d.Ciudad,  d.CP,         'ALTA',  d.Delegacion, d.NoExterior, d.Colonia, @Categoria
		  FROM @Tabla a JOIN @Direccion d ON 1=1
		  /*JOIN WebPais p ON d.Pais = p.ID
		  JOIN WebPaisEstado e ON  e.IDPais = p.ID AND e.ID = d.Estado*/
		ELSE IF @Cliente IS NOT NULL AND @Ok IS NULL AND NOT EXISTS (SELECT * FROM @Direccion)
		BEGIN
			INSERT Cte(Cliente,  Nombre,							  eMail1,   Telefonos,  Contacto1,                           RFC,   Estatus, Categoria)
			SELECT     @Cliente, a.Nombre+' '+ISNULL(a.Apellidos,''), a.eMail,  a.Telefono, a.Nombre+' '+ISNULL(a.Apellidos,''), a.RFC, 'ALTA', @Categoria
			  FROM @Tabla a
		END
		IF @@ERROR<>0 SET @Ok = 1  


	 
		IF @Ok IS NULL 
		BEGIN
		  INSERT WebUsuarios(eMail, eMail2,  Telefono,  FechaAlta, UltimoCambio,  Empresa,  Sucursal,  Cliente, Contrasena, ContrasenaConfirmacion, Nombre, Apellido, GUID)  
		  SELECT            eMail1, eMail2, Telefonos, GETDATE(), GETDATE(),    @Empresa, @Sucursal, Cliente, Contrasena, Contrasena ,dbo.fnWebSepararContacto(Contacto1,1),  dbo.fnWebSepararContacto(Contacto1,2),@GUID 
			FROM  Cte
		   WHERE Cliente = @Cliente
		  IF @@ERROR<>0 SET @Ok = 1  
	   
		  SELECT @IDUsuario = SCOPE_IDENTITY()    
		END
	    
		UPDATE Cte SET Nombre = Nombre WHERE Cliente = @Cliente
	  END 
	  ELSE 
	  IF @Ok IS NULL AND  EXISTS(SELECT * FROM WebUsuarios WHERE GUID = @GUID)
	  BEGIN
		SELECT @Cliente = Cliente,@IDUsuario = ID FROM WebUsuarios WHERE GUID = @GUID
	    
		IF ISNULL(@RFC, '') != '' AND EXISTS(SELECT * FROM Cte WHERE RFC = @RFC AND Cliente <> @Cliente)
		  UPDATE @Tabla SET RFC =  'XAXX010101000'
	   
		UPDATE Cte SET   Telefonos =ISNULL(a.Telefono,''), RFC = ISNULL(NULLIF(a.RFC,''),c.RFC),
    					Contacto1 = CASE
							WHEN ISNULL(Contacto1, '') = '' THEN a.Nombre+' '+ISNULL(a.Apellidos,'') 
							ELSE Contacto1 END,
						eMail1 = CASE
							WHEN ISNULL(eMail1, '') = '' THEN a.eMail
							ELSE eMail1 END
		  FROM Cte c JOIN @Tabla a ON c.Cliente = @Cliente
		 WHERE   c.Cliente = @Cliente
		IF @@ERROR <> 0 SET @Ok = 1 
	    
		IF @Ok IS NULL
		BEGIN
		  UPDATE WebUsuarios SET eMail = t.eMail, Telefono = t.Telefono,  UltimoCambio = GETDATE(),   Contrasena = t.Contrasena, ContrasenaConfirmacion = t.Contrasena, Nombre = t.Nombre , Apellido = t.Apellidos
			FROM @Tabla t JOIN WebUsuarios w ON t.GUID = w.GUID
		   WHERE w.GUID = @GUID 
		  IF @@ERROR <> 0 SET @Ok = 1    
		END    
	  END
  END
  
  IF @Ok IS NULL
  BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
    SELECT @OkRef = 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')  
  END
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '>    <Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Cliente=' + CHAR(34) + ISNULL(@Cliente,'') + CHAR(34) + ' WebUsuarioID='+ CHAR(34) +ISNULL(CONVERT(varchar,@IDUsuario),'')+ CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'  


 END
GO


--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="eCommerce.Intelisis.WebUsuario" SubReferencia="" Version="1.0">
--  <Solicitud Empresa="DEMO" Sucursal="0">
--    <Usuario Nombre="Juan" Apellidos="Jimenez" eMail="a@a.com" Contrasena="123456" Telefono="55555555" RFC="INT030120AA2" Compania="INTELIMED, S.A. DE C.V.">
--      <Direccion Direccion1="3" Direccion2="2" Ciudad="" Pais="" Estado="" CP="" />
--    </Usuario>
--  </Solicitud>
--</Intelisis>
/**************** speCommerceWebUsuarioClienteEnviarA ****************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceWebUsuarioClienteEnviarA') and type = 'P') drop procedure dbo.speCommerceWebUsuarioClienteEnviarA
GO             
CREATE PROCEDURE speCommerceWebUsuarioClienteEnviarA
                               @ID                    int,
                               @iSolicitud            int,
                               @Solicitud             varchar(max),
                               @Version               float,
                               @Resultado             varchar(max) = NULL OUTPUT,
                               @Ok                    int = NULL OUTPUT,    
                               @OkRef                 varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON

DECLARE 
                  @Empresa       varchar(5),
                  @Sucursal      int,
                  @ReferenciaIS  varchar(100),
                  @SubReferencia varchar(100),
                  @Cliente       varchar(10),
                  @IDEnviar      int,
                  @GUID          varchar(50),
                  @GUIDUsuario   varchar(50),
                  @UsuarioID     int,
                  @IDEnviarA     int


                                                                                                                             

DECLARE @Direccion table(Cliente    varchar(10),
                         Direccion1 varchar(255), 
                         Direccion2 varchar(255),
                         Ciudad     varchar(100),
                         Pais       varchar(100),
                         Estado     varchar(100),
                         ID         int,
                         CP         varchar(30),
                         GUID       varchar(50),
                         Delegacion varchar(50),
                         Colonia    varchar(50),
                         GUIDUsuario varchar(50),
                         NoExterior varchar(50),
                         IDEnviarA  int,
                         Nombre  varchar(100), 
                         Apellido varchar(100), 
                         eMail varchar(250),
                         Telefono varchar(50) )

BEGIN TRANSACTION 
                
  IF @Ok IS NULL
  BEGIN


  IF @Ok IS NULL
  SELECT @ReferenciaIS = Referencia, @SubReferencia = SubReferencia 
    FROM IntelisisService
   WHERE ID = @ID
   
  SELECT   @GUID = GUID, @UsuarioID = UsuarioID, @GUIDUsuario = GUIDUsuario, @IDEnviarA =ISNULL(NULLIF(ID,''),-1)
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Direccion',1)  
    WITH (GUID varchar(50),GUIDUsuario varchar(50), UsuarioID int, ID int)   

  EXEC sp_xml_preparedocument @iSolicitud OUTPUT, @Solicitud 
  INSERT @Direccion(Cliente,Direccion1, Direccion2, Ciudad, Pais , Estado, CP ,ID , GUID, Delegacion , NoExterior, Colonia ,GUIDUsuario, IDEnviarA, Nombre, Apellido, eMail, Telefono)  
  SELECT            Cliente,Direccion1 , Direccion2, Ciudad, Pais , Estado, CP,UsuarioID, GUID , Delegacion , NoExterior, Colonia , GUIDUsuario, ISNULL(NULLIF(ID,''),-1),Nombre, Apellido, eMail, Telefono  
    FROM OPENXML (@iSolicitud, '/Intelisis/Solicitud/Direccion',1)  
    WITH (Direccion1 varchar(255), Direccion2 varchar(255),Ciudad varchar(100),Pais varchar(100),Estado varchar(100),CP varchar(30),Cliente varchar(10),UsuarioID int, GUID varchar(50),Delegacion varchar(50), Colonia    varchar(50), NoExterior varchar(50),GUIDUsuario varchar(50), ID int,Nombre varchar(100), Apellido varchar(100), eMail varchar(250), Telefono  varchar(50)) 
  EXEC sp_xml_removedocument @iSolicitud
  IF @@ERROR<>0 SET @Ok = 1
  
  SELECT @Cliente = NULLIF(Cliente,'') FROM WebUsuarios WHERE GUID = @GUIDUsuario
  
  IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente) SET @Ok = 10040
 
  IF @IDEnviarA <> 0
  BEGIN
    IF @Ok IS NULL AND NOT EXISTS(SELECT * FROM CteEnviarA WHERE GUID = @GUID AND Cliente = @Cliente )
    BEGIN
      SELECT @IDEnviar =  MAX(ID) FROM CteEnviarA WHERE Cliente = @Cliente
      SELECT @IDEnviar = ISNULL(@IDEnviar,0)+1

      
      IF @IDEnviar IS NOT NULL
      INSERT CteEnviarA(ID,        Cliente,  Nombre,                                        Direccion,          DireccionNumeroInt,                                       Pais,     Estado,   Poblacion, CodigoPostal, Estatus, GUID, Delegacion, DireccionNumero, Colonia,eMail1, Telefonos)
      SELECT            @IDEnviar, @Cliente,ISNULL(d.Nombre,'')+' '+ISNULL(d.Apellido,''), ISNULL(d.Direccion1,''), ISNULL(d.Direccion2,''), d.Pais, d.Estado, d.Ciudad,  d.CP,         'ALTA', d.GUID, d.Delegacion, d.NoExterior, d.Colonia,d.eMail,d.Telefono
        FROM @Direccion d /*JOIN WebPais p ON d.Pais = p.ID
        JOIN WebPaisEstado e ON  e.IDPais = p.ID AND e.ID = d.Estado */
        JOIN WebUsuarios c ON d.GUIDUsuario = c.GUID
      

      IF @@ERROR<>0 SET @Ok = 1  
    END
    IF EXISTS(SELECT * FROM CteEnviarA WHERE Cliente = @Cliente AND GUID = @GUID)
    BEGIN
      SELECT @IDEnviar = ID FROM CteEnviarA WHERE Cliente = @Cliente AND GUID = @GUID
      UPDATE CteEnviarA SET Nombre = ISNULL(d.Nombre,'')+' '+ISNULL(d.Apellido,''), Direccion = ISNULL(d.Direccion1,''), DireccionNumeroInt = ISNULL(d.Direccion2,''), Pais = d.Pais, Estado = d.Estado, Poblacion= d.Ciudad, CodigoPostal=  d.CP, Delegacion = d.Delegacion , DireccionNumero = d.NoExterior , Colonia = d.Colonia, eMail1=d.eMail, Telefonos= d.Telefono
        FROM @Direccion d /*JOIN WebPais p ON d.Pais = p.ID
        JOIN WebPaisEstado e ON  e.IDPais = p.ID AND e.ID = d.Estado */
        LEFT JOIN WebUsuarios c ON 1=1 AND  c.ID = @UsuarioID
        JOIN CteEnviarA a ON a.Cliente = @Cliente
       WHERE a.Cliente = @Cliente  AND a.GUID = @GUID
    END
  END
  IF  @IDEnviarA = 0
  BEGIN
    UPDATE Cte SET  Direccion = ISNULL(d.Direccion1,''), DireccionNumeroInt = ISNULL(d.Direccion2,''), Pais = d.Pais, Estado = d.Estado, Poblacion= d.Ciudad, CodigoPostal=  d.CP, Delegacion = d.Delegacion , DireccionNumero = d.NoExterior , Colonia = d.Colonia, Telefonos = d.Telefono, eMail1 = d.eMail
      FROM @Direccion d /*JOIN WebPais p ON d.Pais = p.ID
      JOIN WebPaisEstado e ON  e.IDPais = p.ID AND e.ID = d.Estado */
      JOIN Cte a ON a.Cliente = @Cliente
      LEFT JOIN WebUsuarios c ON 1=1 AND  c.ID = @UsuarioID
     WHERE a.Cliente = @Cliente  
    UPDATE WebUsuarios SET  eMail = eMail WHERE Cliente = @Cliente
  END    
  IF @Ok IS NULL
  BEGIN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  COMMIT TRANSACTION 
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION 
    SELECT @OkRef = 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')  
  END
  SET @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '>    <Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Cliente=' + CHAR(34) + ISNULL(@Cliente,'') + CHAR(34) + ' EnviarAID='+ CHAR(34) +ISNULL(CONVERT(varchar,@IDEnviar),'')+ CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '/></Intelisis>'  
  END 
 END
GO


--'<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="eCommerce.Intelisis.WebUsuarioEnviarA" SubReferencia="" Version="1.0">
--  <Solicitud Empresa="DEMO" Sucursal="0">
--    <Direccion UsuarioID="2" Cliente="" Direccion1="3" Direccion2="2" Ciudad="" Pais="" Estado="" CP="" />
--  </Solicitud>
--</Intelisis>'

/**************** spISeCommerceCte ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceCte') and type = 'P') drop procedure dbo.spISeCommerceCte 
GO             
CREATE PROCEDURE spISeCommerceCte
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @Cliente                       varchar(10),
  @Estatus                       varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 

  SELECT @Empresa = Empresa,
         @Cliente = Cliente ,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Cte')
    WITH (Empresa varchar(5), Cliente varchar(10), Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
    SELECT @Tabla =(SELECT * FROM Cte WHERE Cliente = @Cliente FOR XML AUTO) 
      ELSE   SELECT @Tabla = ''
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="Cte" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Cliente=' + CHAR(34) + ISNULL(@Cliente,'') + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    

END
GO


/******************************* speCommerceSolicitudISCte  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISCte') and type = 'P') drop procedure dbo.speCommerceSolicitudISCte
GO             
CREATE PROCEDURE speCommerceSolicitudISCte
                @Cliente                varchar(10),
                @Sucursal               int, 
                @eCommerceSucursal      varchar(10), 
                @Estatus                varchar(10),
                @Ok                     int = NULL OUTPUT,
                @OkRef                  varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal  
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Cte" SubReferencia="Cte" Version="1.0"><Solicitud> <Cte Cliente="'+ISNULL(@Cliente,'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/**************** fneCommerceReemplazarAcentos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fneCommerceReemplazarAcentos') DROP FUNCTION fneCommerceReemplazarAcentos
GO
CREATE FUNCTION fneCommerceReemplazarAcentos
	(
	@Texto					varchar(255)
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
	SELECT @Texto = REPLACE(@Texto, 'à', 'a')
	SELECT @Texto = REPLACE(@Texto, 'è', 'e')
	SELECT @Texto = REPLACE(@Texto, 'ì', 'i')
	SELECT @Texto = REPLACE(@Texto, 'ò', 'o')
	SELECT @Texto = REPLACE(@Texto, 'ù', 'u')
	
	SELECT @Texto = REPLACE(@Texto, 'á', 'a')
	SELECT @Texto = REPLACE(@Texto, 'é', 'e')
	SELECT @Texto = REPLACE(@Texto, 'í', 'i')
	SELECT @Texto = REPLACE(@Texto, 'ó', 'o')
	SELECT @Texto = REPLACE(@Texto, 'ú', 'u')
	
	SELECT @Texto = REPLACE(@Texto, 'Á', 'A')
	SELECT @Texto = REPLACE(@Texto, 'É', 'E')
	SELECT @Texto = REPLACE(@Texto, 'Í', 'I')
	SELECT @Texto = REPLACE(@Texto, 'Ó', 'O')
	SELECT @Texto = REPLACE(@Texto, 'Ù', 'U')
	
	SELECT @Texto = REPLACE(@Texto, 'Ú', 'A')
	SELECT @Texto = REPLACE(@Texto, 'È', 'E')
	SELECT @Texto = REPLACE(@Texto, 'Ì', 'I')
	SELECT @Texto = REPLACE(@Texto, 'Ò', 'O')
	SELECT @Texto = REPLACE(@Texto, 'Ù', 'U')
	
	RETURN @Texto
END
GO

-- SELECT dbo.fneCommerceReemplazarAcentos('México')

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceCteABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceCteABC
GO
CREATE TRIGGER tgeCommerceCteABC ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @Cliente             varchar(10),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int,
   @Pais				varchar(30),
   @PaisID				int,
   @Estado				varchar(30)
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Cliente
       FROM Inserted
       
       -- NES BUG 14946 - Me aseguro de crear el WebPais y WebEstado si no existen, porque en la ayuda de captura
       -- de Cte y CteEnviarA se muestran todos los paises y estados posibles
	 SELECT @Pais = dbo.fneCommerceReemplazarAcentos(Pais), @Estado = dbo.fneCommerceReemplazarAcentos(Estado) FROM Inserted
	 --SELECT @Pais = Pais, @Estado = Estado FROM Inserted
	 IF(ISNULL(@Pais, '') != '')
	 BEGIN	 
		 IF NOT EXISTS (SELECT ID FROM WebPais WHERE UPPER(Nombre) = UPPER(@Pais))
			INSERT INTO WebPais (Nombre) VALUES (@Pais)
		 SELECT @PaisID = ID FROM WebPais WHERE Nombre = @Pais
	 END
	 
	 IF(ISNULL(@Estado, '') != '')
	 BEGIN
		 IF NOT EXISTS (SELECT ID FROM WebPaisEstado WHERE UPPER(Nombre) = UPPER(@Estado) AND IDPais = @PaisID)
			INSERT INTO WebPaisEstado (IDPais, Nombre) VALUES (@PaisID, @Estado)
	 END
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Cliente
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Cliente
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      AND EXISTS(SELECT * FROM WebUsuarios WHERE Cliente = @Cliente)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISCte @Cliente,@Sucursal, @eCommerceSucursal, @Estatus
          
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @Cliente
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceWebCteEnviarA ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebCteEnviarA') and type = 'P') drop procedure dbo.spISeCommerceWebCteEnviarA 
GO             
CREATE PROCEDURE spISeCommerceWebCteEnviarA
                               @ID                     int,
                               @iSolicitud             int,
                               @Version                float,
                               @Resultado              varchar(MAX) = NULL OUTPUT,
                               @Ok                     int = NULL OUTPUT,    
                               @OkRef                  varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @IDUsuario            int,
  @Cliente              varchar(10),
  @Estatus              varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @IDEnviarA            int,
  @Tabla                varchar(max),
  @Resultado2           varchar(max)


  SELECT @Empresa = Empresa,
         @IDUsuario = IDUsuario,
         @Cliente = Cliente,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus,
         @IDEnviarA = IDEnviarA
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebCteEnviarA')
    WITH (Empresa varchar(5), IDUsuario int, Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Cliente varchar(10), IDEnviarA  int)

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID

    IF @Estatus IN ('ALTA','CAMBIO') 
        SELECT @Tabla = '<WebCteEnviarA '+(SELECT  ' ID='+CHAR(34)+ISNULL(CONVERT(varchar,@IDEnviarA),'')+CHAR(34)+ 
        ' Cliente='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Cliente),'')+CHAR(34)+ 
        ' GUID='+CHAR(34)+ISNULL(GUID,'')+CHAR(34)+ 
        ' Nombre ='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Nombre),'')+CHAR(34)+  
        ' Telefono ='+CHAR(34)+ISNULL(Telefonos,'')+CHAR(34)+  
        ' email ='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(eMail1),'')+CHAR(34)+  
        ' Direccion='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(ISNULL(Direccion,'')),'') +CHAR(34)+ 
        ' Direccion2='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(ISNULL(DireccionNumeroInt,'')),'') +CHAR(34)+ 
        ' Pais='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Pais),'')+CHAR(34)+
        ' Estado='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Estado),'')+CHAR(34)+ 
        ' Ciudad='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Poblacion),'')+CHAR(34)+ 
        ' Delegacion='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Delegacion),'')+CHAR(34)+ 
        ' NoExterior='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(DireccionNumero),'')+CHAR(34)+ 
        ' Colonia='+CHAR(34)+ISNULL(dbo.fneWebConvertirDescripcionHTML(Colonia),'')+CHAR(34)+ 
        ' CP='+CHAR(34)+ISNULL(CodigoPostal,'')+CHAR(34)+ 
        ' ListaPreciosEsp='+CHAR(34)+ISNULL(ListaPreciosEsp,'')+CHAR(34)+ 
        ' UsuarioID='+CHAR(34)+ISNULL(CONVERT(varchar,@IDUsuario),'')+CHAR(34)
          FROM CteEnviarA WHERE Cliente = @Cliente AND ID = @IDEnviarA)+' />' 
    ELSE   SELECT @Tabla = ''
  
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebCteEnviarA" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' IDUsuario=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDUsuario,'')) + CHAR(34)+' IDEnviarA=' + CHAR(34) + CONVERT(varchar,ISNULL(@IDEnviarA,'')) + CHAR(34)+' Cliente=' + CHAR(34) + CONVERT(varchar,ISNULL(@Cliente,'')) + CHAR(34) +' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    


END
GO

--declare @datos		  varchar(8000),
--		@iSolicitud	int,
--		@Resultado  varchar(8000),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		    
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebCteEnviarA" SubReferencia="WebCteEnviarA" Version="1.0"><Solicitud> <WebCteEnviarA IDUsuario="25" Sucursal="0" eCommerceSucursal="s19" Cliente="CTE15" Estatus="ALTA" Empresa="" IDEnviarA="1" />  </Solicitud> </Intelisis>'

--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado OUTPUT,@Ok Output,@OkRef Output,1,0,@Id Output
--select @Resultado

/******************************* speCommerceSolicitudISWebCteEnviarA  *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebCteEnviarA') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebCteEnviarA
GO             
CREATE PROCEDURE speCommerceSolicitudISWebCteEnviarA
                @IDUsuario              int,
                @Cliente                varchar(10),
                @IDEnviarA              int,
                @Sucursal               int, 
                @eCommerceSucursal      varchar(10), 
                @Estatus                varchar(10),
                @Ok                     int = NULL OUTPUT,
                @OkRef                  varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @Empresa     varchar(5),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID
  
  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebCteEnviarA" SubReferencia="WebCteEnviarA" Version="1.0"><Solicitud> <WebCteEnviarA IDUsuario="'+ISNULL(CONVERT(varchar,@IDUsuario),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Cliente="'+ISNULL(@Cliente,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" IDEnviarA="'+ISNULL(CONVERT(varchar,@IDEnviarA),'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT

  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
  
END
GO    
    


if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceCteEnviarAABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceCteEnviarAABC
GO
CREATE TRIGGER tgeCommerceCteEnviarAABC ON CteEnviarA
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @IDEnviarA           int,
   @IDUsuario           int,
   @Cliente             varchar(10),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int,
   @Pais				varchar(30),
   @PaisID				int,
   @Estado				varchar(30)
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Cliente, ID
       FROM Inserted
       
       -- NES BUG 14946 - Me aseguro de crear el WebPais y WebEstado si no existen, porque en la ayuda de captura
       -- de Cte y CteEnviarA se muestran todos los paises y estados posibles
	 SELECT @Pais = dbo.fneCommerceReemplazarAcentos(Pais), @Estado = dbo.fneCommerceReemplazarAcentos(Estado) FROM Inserted
	 --SELECT @Pais = Pais, @Estado = Estado FROM Inserted
	 IF(ISNULL(@Pais, '') != '')
	 BEGIN	 
		 IF NOT EXISTS (SELECT ID FROM WebPais WHERE UPPER(Nombre) = UPPER(@Pais))
			INSERT INTO WebPais (Nombre) VALUES (@Pais)
		 SELECT @PaisID = ID FROM WebPais WHERE Nombre = @Pais
	 END
	 
	 IF(ISNULL(@Estado, '') != '')
	 BEGIN
		 IF NOT EXISTS (SELECT ID FROM WebPaisEstado WHERE UPPER(Nombre) = UPPER(@Estado) AND IDPais = @PaisID)
			INSERT INTO WebPaisEstado (IDPais, Nombre) VALUES (@PaisID, @Estado)
	 END
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Cliente, ID
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Cliente, @IDEnviarA
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          IF EXISTS(SELECT * FROM WebUsuarios WHERE Cliente = @Cliente)
          BEGIN
            DECLARE crUsuario CURSOR local FOR
             SELECT ID
               FROM WebUsuarios
              WHERE Cliente = @Cliente
            OPEN crUsuario
            FETCH NEXT FROM crUsuario INTO @IDUsuario
            WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
            BEGIN
              EXEC speCommerceSolicitudISWebCteEnviarA @IDUsuario, @Cliente,@IDEnviarA, @Sucursal, @eCommerceSucursal, @Estatus
              FETCH NEXT FROM crUsuario INTO @IDUsuario
            END
            CLOSE crUsuario
            DEALLOCATE crUsuario    
          END        
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @Cliente, @IDEnviarA
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO

/**************** spISeCommerceMetodoEnvioCfg ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceMetodoEnvioCfg') and type = 'P') drop procedure dbo.spISeCommerceMetodoEnvioCfg
GO             
CREATE PROCEDURE spISeCommerceMetodoEnvioCfg
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET nocount ON
  DECLARE 
  @eCommerceSucursal    varchar(10),
  @MetodoEnvio          varchar(50),
  @Nombre               varchar(100),
  @NombreAntes               varchar(100),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  



  SELECT @Empresa = Empresa,
         @MetodoEnvio= MetodoEnvio,
         @Nombre = Nombre,
         @NombreAntes = NombreAntes,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/eCommerceMetodoEnvioCfg')
    WITH (Empresa varchar(5), MetodoEnvio varchar(50), Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Nombre varchar(100), NombreAntes varchar(100))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
     
    IF @Estatus IN ('ALTA','CAMBIO') 
    BEGIN
      IF @MetodoEnvio IN('Porcentaje de Total','Por articulo' ,'Monto Fijo')
      SELECT @Tabla = (SELECT SucursaleCommerce, MetodoEnvio, Nombre,
                       CASE WHEN MetodoEnvio ='Porcentaje de Total' THEN Precio1  
                            WHEN MetodoEnvio ='Por articulo'    THEN Precio2
                            WHEN MetodoEnvio ='Monto Fijo'   THEN Precio3 END As Precio  ,Estatus EstatusMetodo   
        FROM eCommerceMetodoEnvioCfg WHERE SucursaleCommerce = @eCommerceSucursal AND  MetodoEnvio = @MetodoEnvio AND Nombre = @Nombre FOR XML AUTO)
      ELSE
        SELECT @Tabla = (SELECT eCommerceMetodoEnvioCfg.SucursaleCommerce, eCommerceMetodoEnvioCfg.MetodoEnvio, eCommerceMetodoEnvioCfg.Nombre,
                         CASE WHEN eCommerceMetodoEnvioCfg.MetodoEnvio ='Por Peso' THEN eCommerceMetodoEnvioCfg.Precio4
                              WHEN eCommerceMetodoEnvioCfg.MetodoEnvio ='Por Total de Pedido' THEN eCommerceMetodoEnvioCfg.Precio5  END As Precio   ,
                              eCommerceMetodoEnvioCfg.Estatus EstatusMetodo ,
                             eCommerceMetodoEnvioCfgD.NumeroD, eCommerceMetodoEnvioCfgD.NumeroA, eCommerceMetodoEnvioCfgD.Precio
                                
          FROM eCommerceMetodoEnvioCfg eCommerceMetodoEnvioCfg LEFT JOIN eCommerceMetodoEnvioCfgD eCommerceMetodoEnvioCfgD ON eCommerceMetodoEnvioCfg.SucursaleCommerce = eCommerceMetodoEnvioCfgD.SucursaleCommerce AND eCommerceMetodoEnvioCfg.MetodoEnvio = eCommerceMetodoEnvioCfgD.MetodoEnvio AND eCommerceMetodoEnvioCfg.Nombre = eCommerceMetodoEnvioCfgD.Nombre        
         WHERE eCommerceMetodoEnvioCfg.SucursaleCommerce = @eCommerceSucursal AND eCommerceMetodoEnvioCfg.MetodoEnvio = @MetodoEnvio AND eCommerceMetodoEnvioCfg.Nombre = @Nombre 
           FOR XML AUTO)   
    END   
    ELSE   SELECT @Tabla = ''    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="eCommerceMetodoEnvioCfg" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' MetodoEnvio=' + CHAR(34) + ISNULL(@MetodoEnvio,'') + CHAR(34) +' Nombre=' + CHAR(34) +ISNULL(@Nombre,'') + CHAR(34) +' NombreAntes=' + CHAR(34) +ISNULL(@NombreAntes,'') + CHAR(34) +' >' 
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

/******************************* speCommerceSolicitudISeCommerceMetodoEnvioCfg *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISeCommerceMetodoEnvioCfg') and type = 'P') drop procedure dbo.speCommerceSolicitudISeCommerceMetodoEnvioCfg
GO             
CREATE PROCEDURE speCommerceSolicitudISeCommerceMetodoEnvioCfg
		@eCommerceSucursal      varchar(10), 
                @MetodoEnvio            varchar(50),
                @Nombre                 varchar(100),
				@NombreAntes            varchar(100),
		@Sucursal               int, 		
		@Estatus                varchar(10),
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.eCommerceMetodoEnvioCfg" SubReferencia="eCommerceMetodoEnvioCfg" Version="1.0"><Solicitud> <eCommerceMetodoEnvioCfg MetodoEnvio="'+ISNULL(@MetodoEnvio,'')+'" Nombre="'+ISNULL(@Nombre,'')+'" NombreAntes="'+ISNULL(@NombreAntes, '')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" /></Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceMetodoEnvioCfgDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceMetodoEnvioCfgDABC
GO
CREATE TRIGGER tgeCommerceMetodoEnvioCfgDABC ON eCommerceMetodoEnvioCfgD
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   
   @eCommerceSucursal   varchar(10),
   @MetodoEnvio         varchar(50),
   @Nombre              varchar(100),
   @NombreAntes         varchar(100),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),   
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'
    
 IF @Estatus IN( 'ALTA' ,'CAMBIO')
   SELECT @eCommerceSucursal = SucursaleCommerce, @MetodoEnvio = MetodoEnvio , @Nombre = Nombre FROM INSERTED

 IF @Estatus IN( 'BAJA', 'CAMBIO')
   SELECT @NombreAntes = Nombre FROM DELETED
   
 IF @Estatus IN( 'BAJA')
   SELECT @eCommerceSucursal = SucursaleCommerce, @MetodoEnvio = MetodoEnvio , @Nombre = Nombre FROM DELETED
   
 SELECT @Sucursal = Sucursal FROM Sucursal WHERE    eCommerceSucursal = @eCommerceSucursal   

 IF NULLIF(@eCommerceSucursal,'') IS NOT NULL AND @Sucursal IS NOT NULL
  EXEC speCommerceSolicitudISeCommerceMetodoEnvioCfg @eCommerceSucursal, @MetodoEnvio, @Nombre, @NombreAntes, @Sucursal,  @Estatus 

END
GO



if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceMetodoEnvioCfgABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceMetodoEnvioCfgABC
GO
CREATE TRIGGER tgeCommerceMetodoEnvioCfgABC ON eCommerceMetodoEnvioCfg
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   
   @eCommerceSucursal   varchar(10),
   @MetodoEnvio         varchar(50),
   @Nombre              varchar(100),
   @NombreAntes         varchar(100),
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),   
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN


  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'
    
 IF @Estatus IN( 'ALTA' ,'CAMBIO')
   SELECT @eCommerceSucursal = SucursaleCommerce, @MetodoEnvio = MetodoEnvio , @Nombre = Nombre FROM INSERTED
   
 IF @Estatus IN( 'BAJA', 'CAMBIO')
   SELECT @NombreAntes = Nombre FROM DELETED
   
 IF @Estatus IN( 'BAJA')
   SELECT @eCommerceSucursal = SucursaleCommerce, @MetodoEnvio = MetodoEnvio , @Nombre = Nombre FROM DELETED
   
 SELECT @Sucursal = Sucursal FROM Sucursal WHERE    eCommerceSucursal = @eCommerceSucursal   

 IF NULLIF(@eCommerceSucursal,'') IS NOT NULL AND @Sucursal IS NOT NULL
  EXEC speCommerceSolicitudISeCommerceMetodoEnvioCfg @eCommerceSucursal, @MetodoEnvio, @Nombre, @NombreAntes, @Sucursal,  @Estatus 

END
GO

/**************** spISeCommerceSucursal ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceSucursal') and type = 'P') drop procedure dbo.spISeCommerceSucursal 
GO             
CREATE PROCEDURE spISeCommerceSucursal
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max)  = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Sucursal             varchar(10),
  @SucursalCambio       varchar(10),
  @Estatus              varchar(10),
  @eCommerceSucursal    varchar(10),  
  @ReferenciaIS         varchar(100),
  @Empresa              varchar(5),
  @Estacion             int,
  @Tabla                varchar(max),
  @Resultado2		varchar(max)
  
  
  SELECT @Estacion = @@SPID
  
  SELECT @Empresa = Empresa,
         @Sucursal = Sucursal,
         @SucursalCambio = SucursalCambio,
         @Estatus = Estatus,
         @eCommerceSucursal = eCommerceSucursal
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Sucursal')
    WITH (Empresa varchar(5),  Sucursal int, Estatus varchar(10), eCommerceSucursal varchar(10),SucursalCambio int)
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService
     WHERE ID = @ID
     
    EXEC spContactoDireccionHorizontal @Estacion,'Sucursal',@SucursalCambio,@SucursalCambio,0,0,0,0
    --SELECT @Tabla2 = '<Direccion '+(SELECT ' Direccion1='+CHAR(34)+ ISNULL(Direccion1,'')+CHAR(34)+' Direccion2='+CHAR(34)+ ISNULL(Direccion2,'')+CHAR(34)+' Direccion3='+CHAR(34)+ ISNULL(Direccion3,'')+CHAR(34)+' Direccion4='+CHAR(34)+ ISNULL(Direccion4,'')+CHAR(34)+' Direccion5='+CHAR(34)+ ISNULL(Direccion5,'')+CHAR(34)+' Direccion6='+CHAR(34)+ ISNULL(Direccion6,'')+CHAR(34)+' Direccion7='+CHAR(34)+ ISNULL(Direccion7,'')+CHAR(34)+' Direccion8='+CHAR(34)+ ISNULL(Direccion8,'')+CHAR(34)  FROM ContactoDireccionHorizontal WHERE Estacion = @Estacion AND ContactoTipo = 'Sucursal')+' />'       

     
     
    IF @Estatus IN ('ALTA','CAMBIO') 

      SELECT @Tabla = '<Sucursal'+(SELECT   ' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),Sucursal)),'')+'"'+  
      ' Nombre="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Nombre),'')+'"'+  
      ' Prefijo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Prefijo),'')+'"'+ 
      ' Telefonos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(Telefonos),'')+'"'+ 
      ' eCommerce="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerce)),'')+'"'+  
      ' eCommerceSucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(eCommerceSucursal),'')+'"'+  
      --' eCommerceImagenes="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(eCommerceImagenes),'')+'"'+  
      ' eCommerceAlmacen="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(eCommerceAlmacen),'')+'"'+  
      ' eCommerceListaPrecios="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceListaPrecios)),'')+'"'+  
      ' eCommercePedido="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(eCommercePedido),'')+'"'+  
      ' eCommerceEstrategiaDescuento="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceEstrategiaDescuento)),'')+'"'+  
      ' eCommerceArticuloFlete="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceArticuloFlete)),'')+'"'+  
      ' eCommerceImpuestoIncluido="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceImpuestoIncluido)),'')+'"'+  
      ' eCommerceTipoConsecutivo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceTipoConsecutivo)),'')+'"'+  
      ' eCommerceOffLine="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceOffLine)),'')+'"'+
      ' eCommerceSincroniza="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(eCommerceSincroniza,1))),'')+'"'+
      ' eCommerceConsultaExistencias="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),eCommerceConsultaExistencias)),'')+'"'+
      ' eCommerceURL="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(eCommerceURL,1))),'')+'"'+
      ' eCommerceCRModo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(eCommerceCRModo,1))),'')+'"'+
      ' eCommerceCRMinimo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(eCommerceCRMinimo,1))),'')+'"'+
      ' eCommerceCRMaximo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(eCommerceCRMaximo,1))),'')+'"'+
      ' Encargado="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ISNULL(Encargado,1))),'')+'"'  
		FROM Sucursal WHERE Sucursal =  @SucursalCambio )+
		ISNULL((SELECT ' Direccion1='+CHAR(34)+ ISNULL(Direccion1,'')+CHAR(34)+
		' Direccion2='+CHAR(34)+ ISNULL(Direccion2,'')+CHAR(34)+
		' Direccion3='+CHAR(34)+ ISNULL(Direccion3,'')+CHAR(34)+
		' Direccion4='+CHAR(34)+ ISNULL(Direccion4,'')+CHAR(34)+
		' Direccion5='+CHAR(34)+ ISNULL(Direccion5,'')+CHAR(34)+
		' Direccion6='+CHAR(34)+ ISNULL(Direccion6,'')+CHAR(34)+
		' Direccion7='+CHAR(34)+ ISNULL(Direccion7,'')+CHAR(34)+
		' Direccion8='+CHAR(34)+ ISNULL(Direccion8,'')+CHAR(34)
		FROM ContactoDireccionHorizontal
		WHERE Estacion = @Estacion AND ContactoTipo = 'Sucursal'),'')+'/>'
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="Sucursal" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@SucursalCambio),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' >'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>'  
    

    
END
GO

/******************************* speCommerceSolicitudISSucursal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISSucursal') and type = 'P') drop procedure dbo.speCommerceSolicitudISSucursal
GO             
CREATE PROCEDURE speCommerceSolicitudISSucursal
                @SucursalCambio         int,
                @Sucursal               int, 
                @eCommerceSucursal      varchar(10), 
                @Estatus                varchar(10),
                @Ok                     int = NULL OUTPUT,
                @OkRef                  varchar(255) = NULL OUTPUT



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.Sucursal" SubReferencia="Sucursal" Version="1.0"><Solicitud> <Sucursal SucursalCambio="'+ISNULL(CONVERT(varchar,@SucursalCambio),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
 
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceSucursalABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceSucursalABC
GO
CREATE TRIGGER tgeCommerceSucursalABC ON Sucursal
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal   varchar(10),
   @Sucursal            int,
   @SucursalCambio      int,
   @Cinserted           int,
   @Cdeleted            int,
   @eCommerceSincronizaD bit,
   @eCommerceSincronizaI bit,  
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @IDAcceso            int
   

  SELECT @IDAcceso = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @IDAcceso
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN

  SELECT @eCommerceSincronizaD = eCommerceSincroniza FROM DELETED
  SELECT @eCommerceSincronizaI = eCommerceSincroniza FROM INSERTED

  IF @eCommerceSincronizaD <> @eCommerceSincronizaI 
  BEGIN
    INSERT eCommerceSaldoU(Articulo, SubCuenta)
    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
      FROM WebArt a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL
    GROUP BY a.Articulo,a.SubCuenta
    
    INSERT eCommerceSaldoU(Articulo, SubCuenta)
    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
      FROM WebArtVariacionCombinacion a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL
     GROUP BY a.Articulo,a.SubCuenta   
   
  END

  
 
  
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR FOR
     SELECT Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Sucursal
       FROM Deleted     
  END          
  IF @Estatus IS NOT NULL
  BEGIN
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @SucursalCambio
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
          EXEC speCommerceSolicitudISSucursal  @SucursalCambio, @Sucursal, @eCommerceSucursal, @Estatus
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END    
      FETCH NEXT FROM crActualizar INTO @SucursalCambio
    END
    CLOSE crActualizar
    DEALLOCATE crActualizar
  END  

END
GO
UPDATE Sucursal SET eCommerceImpuestoIncluido = 1 WHERE eCommerceImpuestoIncluido = 0
GO
/**************** spISeCommerceWebArtExistenciaSucursal ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebArtExistenciaSucursal') and type = 'P') drop procedure dbo.spISeCommerceWebArtExistenciaSucursal
GO             
CREATE PROCEDURE spISeCommerceWebArtExistenciaSucursal
		@ID			int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok			int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
   SET NOCOUNT ON
  DECLARE 

  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max),   
  @Estacion             int
  
  
  



  SELECT @ReferenciaIS = Referencia 
    FROM IntelisisService
   WHERE ID = @ID
 
  SELECT @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ExistenciaSucursal')
    WITH ( Sucursal int, eCommerceSucursal varchar(20))
  
  SELECT @Tabla = (SELECT ID, Articulo, SubCuenta, Inventario Cantidad, SKU, Situacion, Sucursal FROM eCommerceExistenciaSucursal  WebArtExistenciaSucursal FOR XML AUTO)    

  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebArtExistencia" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+' >' +ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO
/******************************* speCommerceSolicitudISExistenciaSucursal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISExistenciaSucursal') and type = 'P') drop procedure dbo.speCommerceSolicitudISExistenciaSucursal
GO             
CREATE PROCEDURE speCommerceSolicitudISExistenciaSucursal
		@Inicial	bit = 0,
		@Ok			int = NULL OUTPUT,
		@OkRef	 		varchar(255) = NULL OUTPUT   


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE

  @Usuario     varchar(10),
  @ID          int,
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @Sucursal    int, 
  @eCommerceSucursal      varchar(10), 
  @eCommerceOffLine bit
  


  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  


  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID  
  
  IF(@Inicial = 1)
  BEGIN
    INSERT eCommerceSaldoU(Articulo, SubCuenta)
    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
      FROM WebArt a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL
    GROUP BY a.Articulo,a.SubCuenta
    
    INSERT eCommerceSaldoU(Articulo, SubCuenta)
    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
      FROM WebArtVariacionCombinacion a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL 
     GROUP BY a.Articulo,a.SubCuenta       
   
    
  END
  
  TRUNCATE TABLE eCommerceExistenciaSucursal
  
  INSERT eCommerceExistenciaSucursal(Articulo,   SubCuenta,   Inventario,   SKU,   Situacion,   Sucursal) 
  SELECT                             a.Articulo, a.SubCuenta, SUM(a.Inventario), a.SKU, dbo.fnWebArtEstausExistencia(SKU, Sucursal) Situacion, a.Sucursal
    FROM WebArtExistenciaSucursal a JOIN eCommerceSaldoU e ON a.Articulo = e.Articulo AND ISNULL(a.SubCuenta,'') = ISNULL(e.SubCuenta,'')
    GROUP BY a.Sucursal, a.Articulo, a.SubCuenta, a.SKU, Situacion
    
    
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN    
      SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0), @eCommerceSucursal = eCommerceSucursal FROM Sucursal WHERE Sucursal = @Sucursal
      
      SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
      IF @eCommerceOffLine = 1
        SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'        
    
      IF EXISTS(SELECT * FROM eCommerceExistenciaSucursal)
      BEGIN
         SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ExistenciaSucursal" SubReferencia="ExistenciaSucursal" Version="1.0"><Solicitud> <ExistenciaSucursal  Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" />  </Solicitud> </Intelisis>'
   
            EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  --SELECT convert(xml,@Resultado)
          IF @ID IS NOT NULL AND @Ok IS NULL
          BEGIN
            SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'
 
            IF @Ok IS NULL
            EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
          END      
        END
          
      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END    
  IF @Ok IS NULL
  DELETE   eCommerceSaldoU
  
   
END
GO

--speCommerceSolicitudISExistenciaSucursal  

/******************************* speCommerceCopiarDirectorio *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceCopiarDirectorio') and type = 'P') drop procedure dbo.speCommerceCopiarDirectorio
GO             
CREATE PROCEDURE speCommerceCopiarDirectorio
		@Ruta                   varchar(255),
		@Estacion               int, 
		@Nivel                  int,
		@DropBox                varchar(255),
		@ArchivoDestino         varchar(255),
                @eCommerceSucursal      varchar(10)     
 
				



--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Ok                   int,
  @OkRef                varchar(255),
  @Nombre               varchar(255),
  @Tipo                 varchar(50),
  @Archivo              varchar(255) 



  DECLARE creDocInDir CURSOR LOCAL FOR 
   SELECT Nombre, Tipo 
     FROM eCommerceDirDetalle2 
    WHERE  Estacion = @Estacion  AND Nivel = @Nivel
  ORDER BY RowNum
  
  OPEN creDocInDir
  FETCH NEXT FROM creDocInDir INTO @Nombre, @Tipo
  WHILE @@FETCH_STATUS = 0 
  BEGIN
    SET @Ok = NULL
    SELECT @Archivo = @Ruta+'\'+@Nombre
    SELECT @ArchivoDestino = REPLACE(@Archivo,'OffLine\','')

    IF @Tipo <>'Folder'
    BEGIN

      EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
      
      IF @Ok IS NULL
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT 
    END  

    IF @Tipo ='Folder'
    BEGIN
      EXEC spCrearFolder @ArchivoDestino, @Ok OUTPUT, @OkRef OUTPUT 
      SELECT @Nivel = ISNULL(@Nivel,1)+1
      
      EXEC speCommerceListarDirectorio2 @Archivo, @Estacion, @Nivel
      
      EXEC speCommerceCopiarDirectorio @Archivo, @Estacion, @Nivel, @DropBox,@ArchivoDestino, @eCommerceSucursal
    END
    
    
   IF @Ok IS NULL AND @Tipo <>'Folder'
     EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT 
  
  --IF @Ok IS NULL AND @Tipo ='Folder'
  --  EXEC spEliminarFolder @Archivo, @Ok OUTPUT, @OkRef OUTPUT 
    
    
    SELECT @Ok = NULL , @OkRef = NULL, @Archivo = NULL, @ArchivoDestino = NULL
    
    FETCH NEXT FROM creDocInDir INTO @Nombre, @Tipo
  END
  CLOSE creDocInDir
  DEALLOCATE creDocInDir   

END
GO


/******************************* speCommerceMoverArchivosOffline *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceMoverArchivosOffline') and type = 'P') drop procedure dbo.speCommerceMoverArchivosOffline
GO             
CREATE PROCEDURE speCommerceMoverArchivosOffline

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Solicitud   varchar(8000),
  @Resultado   varchar(8000),
  @Nombre      varchar(255),
  @Nombre2      varchar(255),
  @Nombre3      varchar(255),
  @ID          int,
  @Estacion    int,
  @Origen2     varchar(255),
  @Destino2    varchar(255),
  @Contrasena  varchar(32),
  @Existe      int,
  @Contador    int,
  @Archivo     varchar(255),
  @ArchivoDestino varchar(255),
  @Archivo2     varchar(255),
  @ArchivoDestino2 varchar(255),
  @Archivo3     varchar(255),
  @ArchivoDestino3 varchar(255),
  @Ruta        varchar(255),
  @RutaProc    varchar(255),
  @RutaError   varchar(255),
  @DropBox     varchar(255),
  @eCommerceSucursal  varchar(10),
  @Sucursal    int,
  @Usuario     varchar(10), 
  @Extencion   varchar(255),
  @Tipo        varchar(50),
  @Ok	       int,
  @Error       int,
  @OkRef       varchar(255)
  
  SELECT @DropBox = DirSFTP, @Usuario = WebUsuario  FROM WebVersion
  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario

  SELECT @Estacion = @@SPID
   
  DELETE eCommerceDirDetalle2 WHERE Estacion = @Estacion 
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  
      EXEC speCommerceListarDirectorio2 @Ruta, @Estacion, 1
      
      EXEC speCommerceCopiarDirectorio @Ruta, @Estacion, 1 , @DropBox, NULL, @eCommerceSucursal
        
      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END
END
GO

/******************************* speCommerceInsertarIS *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceInsertarIS') and type = 'P') drop procedure dbo.speCommerceInsertarIS
GO             
CREATE PROCEDURE speCommerceInsertarIS
	@MoverArchivos bit = 1,
	@NumeroProcesar int = 0
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Solicitud   varchar(MAX),
  @Resultado   varchar(MAX),
  @Nombre      varchar(255),
  @ID          int,
  @Estacion    int,
  @Origen2     varchar(255),
  @Destino2    varchar(255),
  @Contrasena  varchar(32),
  @Existe      int,
  @Contador    int,
  @Archivo     varchar(255),
  @ArchivoDestino varchar(255),
  @Ruta        varchar(255),
  @RutaProc    varchar(255),
  @RutaError   varchar(255),
  @DropBox     varchar(255),
  @eCommerceSucursal  varchar(10),
  @Sucursal    int,
  @Usuario     varchar(10), 
  @Extencion   varchar(255),
  @Ok	       int,
  @Error       int,
  @OkRef       varchar(255)
  
  SELECT @Extencion = '.xml'
  
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerceOffLine = 1)
    EXEC speCommerceMoverArchivosOffline  
  

  SELECT @DropBox = DirSFTP, @Usuario = WebUsuario  FROM WebVersion
  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
  
  
   
   SELECT @Estacion = @@SPID
   
   
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
      EXEC speCommerceListarDirectorio @Ruta, @Estacion

	  IF (ISNULL(@NumeroProcesar, 0) < 1)
	   SELECT @NumeroProcesar = COUNT(RowNum)
         FROM eCommerceDirDetalle 
        WHERE  Estacion = @Estacion AND Tipo = @Extencion 
      
      DECLARE creDocInDir CURSOR FOR 
       SELECT Nombre
         FROM eCommerceDirDetalle 
        WHERE  Estacion = @Estacion AND Tipo = @Extencion 
      ORDER BY RowNum

      
      OPEN creDocInDir
      FETCH NEXT FROM creDocInDir INTO @Nombre
      WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL AND @NumeroProcesar > 0
      BEGIN
        SELECT @Error = NULL, @Ok = NULL, @OkRef = NULL
        SELECT @Solicitud =  dbo.fneDocInLeerArchivo(@Ruta,@Nombre)


		EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
       
        IF @Ok IS NOT NULL 
          SELECT @Error = @Ok, @Ok = NULL , @OkRef = NULL
        IF @ID IS NOT NULL 
        BEGIN
          SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'
          EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT          
        END  
        SELECT @Archivo = @Ruta+'\'+@Nombre
        SELECT @RutaProc = @Ruta +'\Procesados'
        --IF @Error IS NULL
        --  EXEC spCrearFolder @RutaProc, @Ok OUTPUT,@OkRef OUTPUT
           
        IF @Error IS NULL
        BEGIN          
          SELECT @ArchivoDestino = @RutaProc+'\'+@Nombre
          IF @MoverArchivos = 1 EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
        END 
        ELSE
        IF @Error IS NOT NULL
        BEGIN
          SELECT @Ok = null
          SELECT @RutaError = @Ruta +'\Errores'
          --EXEC spCrearFolder @RutaError, @Ok OUTPUT,@OkRef OUTPUT
          
          SELECT @ArchivoDestino = @RutaError+'\'+@Nombre
          IF @MoverArchivos = 1 EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT

        END
        
        IF @MoverArchivos = 1 EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT 
        
        SELECT @Ok = NULL , @OkRef = NULL
        SET @NumeroProcesar = @NumeroProcesar - 1
        
        FETCH NEXT FROM creDocInDir INTO @Nombre
      END
      CLOSE creDocInDir
      DEALLOCATE creDocInDir          
  
        
      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END
END
GO

--speCommerceInsertarIS 'C:\Entrada','.xml','DEMO','DEMO',0

/******************************* speCommerceCopiarValores *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceCopiarValores') and type = 'P') drop procedure dbo.speCommerceCopiarValores
GO             
CREATE PROCEDURE speCommerceCopiarValores
	@OpcionID int,
	@OpcionIDOriginal int,
	@VariacionID int,
	@Ok int = NULL OUTPUT,
	@OkRef varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	INSERT INTO WebArtOpcionValor (VariacionID, OpcionID, Orden, NumeroIntelisis, Valor)
		SELECT @VariacionID, @OpcionID, Orden, NumeroIntelisis, Valor
		FROM WebArtOpcionValor
		WHERE OpcionID = @OpcionIDOriginal
END
GO

/******************************* speCommerceCopiarOpciones *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceCopiarOpciones') and type = 'P') drop procedure dbo.speCommerceCopiarOpciones
GO             
CREATE PROCEDURE speCommerceCopiarOpciones
	@VariacionID int,
	@VariacionIDOriginal int,
	@Ok int = NULL OUTPUT,
	@OkRef varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
	@OpcionID int,
	@Orden int,
	@Nombre varchar(100),
	@OpcionIntelisis varchar(1),
	@ID int

	DECLARE crOpciones CURSOR LOCAL FOR
		SELECT ID, Orden, Nombre, OpcionIntelisis
		FROM WebArtOpcion
		WHERE VariacionID = @VariacionIDOriginal
	OPEN crOpciones
	FETCH NEXT FROM crOpciones INTO @OpcionID, @Orden, @Nombre, @OpcionIntelisis
	WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
	BEGIN
		INSERT INTO WebArtOpcion (VariacionID,  Orden,  Nombre,  OpcionIntelisis,  GUID)
		VALUES					 (@VariacionID, @Orden, @Nombre, @OpcionIntelisis, NEWID())
		
		SELECT @ID = SCOPE_IDENTITY()
		
		EXEC speCommerceCopiarValores @ID, @OpcionID, @VariacionID, @Ok OUTPUT, @OkRef OUTPUT
		FETCH NEXT FROM crOpciones INTO @OpcionID, @Orden, @Nombre, @OpcionIntelisis
	END
	CLOSE crOpciones
	DEALLOCATE crOpciones    
END
GO

/******************************* speCommerceCopiarVariacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceCopiarVariacion') and type = 'P') drop procedure dbo.speCommerceCopiarVariacion
GO             
CREATE PROCEDURE speCommerceCopiarVariacion
	@ID int,
	@NombreNuevo varchar(100)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE
	@IDNuevo int,
	@Ok int,
	@OkRef varchar(255)
	
	INSERT INTO WebArtVariacion (Orden, Nombre,		  GUID)
						 VALUES (0,		@NombreNuevo, NEWID())
	
	SELECT @IDNuevo = SCOPE_IDENTITY()
	
	EXEC speCommerceCopiarOpciones @IDNuevo, @ID, @Ok OUTPUT, @OkRef OUTPUT
END
GO

/******************************* speCommerceRegistroWebArtOpcion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceRegistroWebArtOpcion') and type = 'P') drop procedure dbo.speCommerceRegistroWebArtOpcion
GO             
CREATE PROCEDURE speCommerceRegistroWebArtOpcion
	@Estacion int,
	@Accion char(4),
	@Nombre varchar(100),
	@IDVariacion int,
	@IDOpcion int = 0
--//WITH ENCRYPTION
AS BEGIN
	-- SET nocount ON
	DECLARE @OrdenSiguiente int,
			@Transaccion	varchar(50),
			@Ok				int,
			@OkRef			varchar(255) 
			
    SET @Ok = 0
    SET @OkRef = ''
	SET @Transaccion = 'speCommerceRegistroWebArtOpcion' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))
	BEGIN TRANSACTION @Transaccion






			
	IF(@Accion = 'ALTA')
	BEGIN
		SELECT @OrdenSiguiente = MAX(Orden) + 1 FROM WebArtOpcion WHERE VariacionID = @IDVariacion
		INSERT INTO WebArtOpcion (VariacionID,  Orden,			 Nombre, GUID)
		VALUES					 (@IDVariacion, @OrdenSiguiente, @Nombre,     NEWID())









		IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @IDVariacion





	END
	ELSE IF(@Accion = 'BAJA' AND @IDOpcion <> 0)
	BEGIN
		IF EXISTS(SELECT ID FROM WebArtOpcion WHERE ID = @IDOpcion)
			IF((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @IDVariacion) = 0)
				DELETE FROM WebArtOpcion WHERE ID = @IDOpcion
			ELSE
				SELECT @Ok = 1, @OkRef = @IDOpcion
		IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @IDOpcion
	END
	ELSE
	BEGIN
		SELECT @Ok = 1, @OkRef = @Accion
	END

	IF NULLIF(@Ok,0) IS NULL
	BEGIN
		COMMIT TRANSACTION @Transaccion
	END ELSE
	BEGIN
		ROLLBACK TRANSACTION @Transaccion
		SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
	END

END
GO

/******************************* speCommerceRegistroWebArtOpcionValor *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceRegistroWebArtOpcionValor') and type = 'P') drop procedure dbo.speCommerceRegistroWebArtOpcionValor
GO             
CREATE PROCEDURE speCommerceRegistroWebArtOpcionValor
	@Estacion int,
	@Accion char(4),
	@Valor varchar(100),
	@IDVariacion int,
	@IDOpcion int,
	@IDValor int = 0
--//WITH ENCRYPTION
AS BEGIN
	-- SET nocount ON
	DECLARE @OrdenSiguiente int,
			@Transaccion	varchar(50),
			@Ok				int,
			@OkRef			varchar(255)
    
    SET @Ok = 0
    SET @OkRef = ''
	SET @Transaccion = 'speCommerceRegistroWebArtOpcionValor' + RTRIM(LTRIM(CONVERT(varchar,@Estacion)))
	BEGIN TRANSACTION @Transaccion



			

	IF(@Accion = 'ALTA')
	BEGIN


		SELECT @OrdenSiguiente = MAX(Orden) + 1 FROM WebArtOpcionValor WHERE OpcionID = @IDOpcion
		INSERT INTO WebArtOpcionValor (VariacionID,  OpcionID,  Orden,			 Valor)
		VALUES						  (@IDVariacion, @IDOpcion, @OrdenSiguiente, @Valor)
		IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @IDOpcion
	END
	ELSE IF(@Accion = 'BAJA' AND @IDOpcion <> 0)
	BEGIN
		IF EXISTS(SELECT ID FROM WebArtOpcionValor WHERE ID = @IDValor)
			IF((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @IDVariacion) = 0)
				DELETE FROM WebArtOpcionValor WHERE ID = @IDValor
			ELSE
				SELECT @Ok = 1, @OkRef = @IDOpcion
		IF @@ERROR <> 0 SELECT @Ok = 1, @OkRef = @IDValor





	END
	ELSE
	BEGIN
		SELECT @Ok = 1, @OkRef = @Accion
	END

	IF NULLIF(@Ok,0) IS NULL
	BEGIN
		COMMIT TRANSACTION @Transaccion
	END ELSE
	BEGIN
		ROLLBACK TRANSACTION @Transaccion
		SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
	END

END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommercePCABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommercePCABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISPC') and type = 'P') drop procedure dbo.speCommerceSolicitudISPC
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommercePC') and type = 'P') drop procedure dbo.spISeCommercePC
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommercePCDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommercePCDABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISPCD') and type = 'P') drop procedure dbo.speCommerceSolicitudISPCD
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommercePCD') and type = 'P') drop procedure dbo.spISeCommercePCD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosDABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosD') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosD
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosD') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosD
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosDUnidadABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosDUnidadABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosDUnidad') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosDUnidad
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosDUnidad') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosDUnidad
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosSubABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosSubABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosSub') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosSub
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosSub') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosSub
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosSubUnidadABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosSubUnidadABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosSubUnidad') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosSubUnidad
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosSubUnidad') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosSubUnidad
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtProvABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtProvABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtProv') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtProv
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtProv') and type = 'P') drop procedure dbo.spISeCommerceArtProv
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtProvSucursalABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtProvSucursalABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtProvSucursal') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtProvSucursal
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtProvSucursal') and type = 'P') drop procedure dbo.spISeCommerceArtProvSucursal
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtSubCostoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtSubCostoABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtSubCosto') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtSubCosto
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtSubCosto') and type = 'P') drop procedure dbo.spISeCommerceArtSubCosto
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtSubABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtSubABC
GO
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtSub') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtSub
GO             
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtSub') and type = 'P') drop procedure dbo.spISeCommerceArtSub
GO             
if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosDABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosDABC
GO
CREATE TRIGGER tgeCommerceListaPreciosDABC ON ListaPreciosD
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Lista				varchar(20),
   @Moneda				varchar(10),
   @Articulo			varchar(20),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int
   
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISListaPreciosD @Lista, @Moneda, @Articulo, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISListaPreciosD *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosD') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosD
GO             
CREATE PROCEDURE speCommerceSolicitudISListaPreciosD
	@Lista				varchar(20),
	@Moneda				varchar(10),
	@Articulo			varchar(20),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ListaPreciosD" SubReferencia="ListaPreciosD" Version="1.0"><Solicitud> <ListaPreciosD Lista="'+ISNULL(CONVERT(varchar,@Lista),'')+'" Moneda="'+ISNULL(CONVERT(varchar,@Moneda),'')+'" Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceListaPreciosD *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosD') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosD
GO             
CREATE PROCEDURE spISeCommerceListaPreciosD
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
  @Lista				varchar(20),
  @Moneda				varchar(10),
  @Articulo			varchar(20),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  



  SELECT @Empresa = Empresa,
         @Lista = Lista,
         @Moneda = Moneda,
		 @Articulo = Articulo,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ListaPreciosD')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  Lista varchar(20), Moneda varchar(10), Articulo varchar(20))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ListaPreciosD '+(SELECT  
							' Lista="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Lista)),'')+'"'+ 
							' Moneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Moneda)),'')+'"'+ 
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Articulo)),'')+'"'+ 
							' Precio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Precio)),'')+'"'+ 
							' CodigoCliente="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.CodigoCliente)),'')+'"'+ 
							' Margen="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Margen)),'')+'"'+ 
							' Region="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosD.Region)),'')+'"'+ 
		' />' FROM ListaPreciosD ListaPreciosD WHERE  Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ListaPreciosD" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Lista=' + CHAR(34) + ISNULL(CONVERT(varchar,@Lista),'') + CHAR(34) +' Moneda=' + CHAR(34) + ISNULL(CONVERT(varchar,@Moneda),'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosDUnidadABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosDUnidadABC
GO
CREATE TRIGGER tgeCommerceListaPreciosDUnidadABC ON ListaPreciosDUnidad
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Lista				varchar(20),
   @Moneda				varchar(10),
   @Articulo			varchar(20),
   @Unidad				varchar(50),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int
   
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @Cinserted = 0 AND @Cdeleted = 0 RETURN

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, Unidad
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, Unidad
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @Unidad
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN
              EXEC speCommerceSolicitudISListaPreciosDUnidad @Lista, @Moneda, @Articulo, @Unidad, @Sucursal, @eCommerceSucursal, @Estatus, @Ok OUTPUT, @OkRef OUTPUT
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @Unidad
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISListaPreciosDUnidad *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosDUnidad') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosDUnidad
GO             
CREATE PROCEDURE speCommerceSolicitudISListaPreciosDUnidad
	@Lista				varchar(20),
	@Moneda				varchar(10),
	@Articulo			varchar(20),
	@Unidad				varchar(50),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ListaPreciosDUnidad" SubReferencia="ListaPreciosDUnidad" Version="1.0"><Solicitud> <ListaPreciosDUnidad Lista="'+ISNULL(CONVERT(varchar,@Lista),'')+'" Moneda="'+ISNULL(CONVERT(varchar,@Moneda),'')+'" Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" Unidad="'+ISNULL(CONVERT(varchar,@Unidad),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceListaPreciosDUnidad *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosDUnidad') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosDUnidad
GO             
CREATE PROCEDURE spISeCommerceListaPreciosDUnidad
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
  @Lista				varchar(20),
  @Moneda				varchar(10),
  @Articulo			varchar(20),
  @Unidad				varchar(50),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  



  SELECT @Empresa = Empresa,
         @Lista = Lista,
         @Moneda = Moneda,
		 @Articulo = Articulo,
		 @Unidad = Unidad,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ListaPreciosDUnidad')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  Lista varchar(20), Moneda varchar(10), Articulo varchar(20), Unidad varchar(50))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ListaPreciosDUnidad '+(SELECT  
							' Lista="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Lista)),'')+'"'+ 
							' Moneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Moneda)),'')+'"'+ 
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Articulo)),'')+'"'+ 
							' Unidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Unidad)),'')+'"'+ 
							' Precio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Precio)),'')+'"'+ 
							' Region="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosDUnidad.Region)),'')+'"'+ 
		' />' FROM ListaPreciosDUnidad ListaPreciosDUnidad WHERE  Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND Unidad = @Unidad) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ListaPreciosDUnidad" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Lista=' + CHAR(34) + ISNULL(CONVERT(varchar,@Lista),'') + CHAR(34) +' Moneda=' + CHAR(34) + ISNULL(CONVERT(varchar,@Moneda),'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' Unidad=' + CHAR(34) + ISNULL(CONVERT(varchar,@Unidad),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosSubABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosSubABC
GO
CREATE TRIGGER tgeCommerceListaPreciosSubABC ON ListaPreciosSub
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Lista				varchar(20),
   @Moneda				varchar(10),
   @Articulo			varchar(20),
   @SubCuenta				varchar(50),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, SubCuenta
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, SubCuenta
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @SubCuenta
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISListaPreciosSub @Lista, @Moneda, @Articulo, @SubCuenta, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END
      FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @SubCuenta
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISListaPreciosSub *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosSub') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosSub
GO             
CREATE PROCEDURE speCommerceSolicitudISListaPreciosSub
	@Lista				varchar(20),
	@Moneda				varchar(10),
	@Articulo			varchar(20),
	@SubCuenta				varchar(50),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ListaPreciosSub" SubReferencia="ListaPreciosSub" Version="1.0"><Solicitud> <ListaPreciosSub Lista="'+ISNULL(CONVERT(varchar,@Lista),'')+'" Moneda="'+ISNULL(CONVERT(varchar,@Moneda),'')+'" Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceListaPreciosSub *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosSub') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosSub
GO             
CREATE PROCEDURE spISeCommerceListaPreciosSub
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
  @Lista				varchar(20),
  @Moneda				varchar(10),
  @Articulo			varchar(20),
  @SubCuenta				varchar(50),
  @Estatus		varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal     varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2		varchar(max) 
  



  SELECT @Empresa = Empresa,
         @Lista = Lista,
         @Moneda = Moneda,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ListaPreciosSub')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  Lista varchar(20), Moneda varchar(10), Articulo varchar(20), SubCuenta varchar(50))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ListaPreciosSub '+(SELECT  
							' Lista="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.Lista)),'')+'"'+ 
							' Moneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.Moneda)),'')+'"'+ 
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.Articulo)),'')+'"'+ 
							' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.SubCuenta)),'')+'"'+ 
							' Precio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.Precio)),'')+'"'+ 
							' Region="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSub.Region)),'')+'"'+ 
		' />' FROM ListaPreciosSub ListaPreciosSub WHERE  Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ListaPreciosSub" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Lista=' + CHAR(34) + ISNULL(CONVERT(varchar,@Lista),'') + CHAR(34) +' Moneda=' + CHAR(34) + ISNULL(CONVERT(varchar,@Moneda),'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceListaPreciosSubUnidadABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceListaPreciosSubUnidadABC
GO
CREATE TRIGGER tgeCommerceListaPreciosSubUnidadABC ON ListaPreciosSubUnidad
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Lista				varchar(20),
   @Moneda				varchar(10),
   @Articulo			varchar(20),
   @SubCuenta			varchar(50),
   @Unidad				varchar(50),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, SubCuenta, Unidad
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Lista, Moneda, Articulo, SubCuenta, Unidad
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @SubCuenta, @Unidad
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISListaPreciosSubUnidad @Lista, @Moneda, @Articulo, @SubCuenta, @Unidad, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END  
      FETCH NEXT FROM crActualizar INTO @Lista, @Moneda, @Articulo, @SubCuenta, @Unidad
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISListaPreciosSubUnidad *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISListaPreciosSubUnidad') and type = 'P') drop procedure dbo.speCommerceSolicitudISListaPreciosSubUnidad
GO             
CREATE PROCEDURE speCommerceSolicitudISListaPreciosSubUnidad
	@Lista				varchar(20),
	@Moneda				varchar(10),
	@Articulo			varchar(20),
	@SubCuenta			varchar(50),
	@Unidad			varchar(50),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ListaPreciosSubUnidad" SubReferencia="ListaPreciosSubUnidad" Version="1.0"><Solicitud> <ListaPreciosSubUnidad Lista="'+ISNULL(CONVERT(varchar,@Lista),'')+'" Moneda="'+ISNULL(CONVERT(varchar,@Moneda),'')+'" Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" Unidad="'+ISNULL(CONVERT(varchar,@Unidad),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceListaPreciosSubUnidad *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceListaPreciosSubUnidad') and type = 'P') drop procedure dbo.spISeCommerceListaPreciosSubUnidad
GO             
CREATE PROCEDURE spISeCommerceListaPreciosSubUnidad
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
  @Lista				varchar(20),
  @Moneda				varchar(10),
  @Articulo				varchar(20),
  @SubCuenta			varchar(50),
  @Unidad			varchar(50),
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) 
  



  SELECT @Empresa = Empresa,
         @Lista = Lista,
         @Moneda = Moneda,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
		 @Unidad = Unidad,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ListaPreciosSubUnidad')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10),  Lista varchar(20), Moneda varchar(10), Articulo varchar(20), SubCuenta varchar(50), Unidad varchar(50))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ListaPreciosSubUnidad '+(SELECT  
							' Lista="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Lista)),'')+'"'+ 
							' Moneda="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Moneda)),'')+'"'+ 
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Articulo)),'')+'"'+ 
							' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.SubCuenta)),'')+'"'+ 
							' Unidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Unidad)),'')+'"'+ 
							' Precio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Precio)),'')+'"'+ 
							' Region="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ListaPreciosSubUnidad.Region)),'')+'"'+ 
		' />' FROM ListaPreciosSubUnidad ListaPreciosSubUnidad WHERE  Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ListaPreciosSubUnidad" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Lista=' + CHAR(34) + ISNULL(CONVERT(varchar,@Lista),'') + CHAR(34) +' Moneda=' + CHAR(34) + ISNULL(CONVERT(varchar,@Moneda),'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' Unidad=' + CHAR(34) + ISNULL(CONVERT(varchar,@Unidad),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtProvABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtProvABC
GO
CREATE TRIGGER tgeCommerceArtProvABC ON ArtProv
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Articulo			varchar(20),
   @SubCuenta			varchar(50),
   @Proveedor			varchar(10),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int
   
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Proveedor
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Proveedor
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @Proveedor
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISArtProv @Articulo, @SubCuenta, @Proveedor, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END  
      FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @Proveedor
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISArtProv *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtProv') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtProv
GO             
CREATE PROCEDURE speCommerceSolicitudISArtProv
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Proveedor			varchar(10),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ArtProv" SubReferencia="ArtProv" Version="1.0"><Solicitud> <ArtProv Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" Proveedor="'+ISNULL(CONVERT(varchar,@Proveedor),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceArtProv *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtProv') and type = 'P') drop procedure dbo.spISeCommerceArtProv
GO             
CREATE PROCEDURE spISeCommerceArtProv
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
  @Articulo			varchar(20),
  @SubCuenta			varchar(50),
  @Proveedor			varchar(10),
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) 
  



  SELECT @Empresa = Empresa,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
		 @Proveedor = Proveedor,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ArtProv')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Articulo varchar(20), SubCuenta varchar(50), Proveedor varchar(10))
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ArtProv '+(SELECT  
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Articulo)),'')+'"'+ 
							' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.SubCuenta)),'')+'"'+ 
							' Proveedor="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Proveedor)),'')+'"'+ 
							' Clave="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Clave)),'')+'"'+ 
							' Unidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Unidad)),'')+'"'+ 
							' CostoAutorizado="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.CostoAutorizado)),'')+'"'+ 
							' UltimoCosto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.UltimoCosto)),'')+'"'+ 
							' UltimaCompra="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.UltimaCompra)),'')+'"'+ 
							' CompraMinimaCantidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.CompraMinimaCantidad)),'')+'"'+ 
							' CompraMinimaImporte="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.CompraMinimaImporte)),'')+'"'+ 
							' Multiplos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Multiplos)),'')+'"'+ 
							' DiasRespuesta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.DiasRespuesta)),'')+'"'+ 
							' Logico1="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Logico1)),'')+'"'+ 
							' Logico2="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.Logico2)),'')+'"'+ 
							' ProveedorOmision="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.ProveedorOmision)),'')+'"'+ 
							' UltimaCotizacion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.UltimaCotizacion)),'')+'"'+ 
							' FechaCotizacion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProv.FechaCotizacion)),'')+'"'+ 
		' />' FROM ArtProv ArtProv WHERE  Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ArtProv" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' Proveedor=' + CHAR(34) + ISNULL(CONVERT(varchar,@Proveedor),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtProvSucursalABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtProvSucursalABC
GO
CREATE TRIGGER tgeCommerceArtProvSucursalABC ON ArtProvSucursal
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Articulo			varchar(20),
   @SubCuenta			varchar(50),
   @Proveedor			varchar(10),
   @SucursalDestino		int,
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Proveedor, Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Proveedor, Sucursal
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @Proveedor, @SucursalDestino
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISArtProvSucursal @Articulo, @SubCuenta, @Proveedor, @SucursalDestino, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END   
      FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @Proveedor, @SucursalDestino
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISArtProvSucursal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtProvSucursal') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtProvSucursal
GO             
CREATE PROCEDURE speCommerceSolicitudISArtProvSucursal
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Proveedor			varchar(10),
	@SucursalDestino	int,
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ArtProvSucursal" SubReferencia="ArtProvSucursal" Version="1.0"><Solicitud> <ArtProvSucursal Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" Proveedor="'+ISNULL(CONVERT(varchar,@Proveedor),'')+'" SucursalDestino="'+ISNULL(CONVERT(varchar,@SucursalDestino),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceArtProvSucursal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtProvSucursal') and type = 'P') drop procedure dbo.spISeCommerceArtProvSucursal
GO             
CREATE PROCEDURE spISeCommerceArtProvSucursal
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
  @Articulo			varchar(20),
  @SubCuenta			varchar(50),
  @Proveedor			varchar(10),
  @SucursalDestino		int,
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) 
  



  SELECT @Empresa = Empresa,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
		 @Proveedor = Proveedor,
		 @SucursalDestino = SucursalDestino,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ArtProvSucursal')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Articulo varchar(20), SubCuenta varchar(50), Proveedor varchar(10), SucursalDestino int)
    


    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ArtProvSucursal '+(SELECT  
							' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.Articulo)),'')+'"'+ 
							' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.SubCuenta)),'')+'"'+ 
							' Proveedor="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.Proveedor)),'')+'"'+ 
							' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.Sucursal)),'')+'"'+ 
							' CostoAutorizado="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.CostoAutorizado)),'')+'"'+ 
							' UltimoCosto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.UltimoCosto)),'')+'"'+ 
							' UltimaCompra="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.UltimaCompra)),'')+'"'+ 
							' CompraMinimaCantidad="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.CompraMinimaCantidad)),'')+'"'+ 
							' CompraMinimaImporte="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.CompraMinimaImporte)),'')+'"'+ 
							' Multiplos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.Multiplos)),'')+'"'+ 
							' DiasRespuesta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.DiasRespuesta)),'')+'"'+ 
							' UltimaCotizacion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.UltimaCotizacion)),'')+'"'+ 
							' FechaCotizacion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtProvSucursal.FechaCotizacion)),'')+'"'+ 
		' />' FROM ArtProvSucursal ArtProvSucursal WHERE  Articulo = @Articulo AND SubCuenta = @SubCuenta AND Proveedor = @Proveedor AND Sucursal = @SucursalDestino) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ArtProvSucursal" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' Proveedor=' + CHAR(34) + ISNULL(CONVERT(varchar,@Proveedor),'') + CHAR(34) +' SucursalDestino=' + CHAR(34) + ISNULL(CONVERT(varchar,@SucursalDestino),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtSubCostoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtSubCostoABC
GO
CREATE TRIGGER tgeCommerceArtSubCostoABC ON ArtSubCosto
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Articulo			varchar(20),
   @SubCuenta			varchar(50),
   @EmpresaDestino		varchar(5),
   @SucursalDestino		int,
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int
   
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Empresa, Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta, Empresa, Sucursal
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @EmpresaDestino, @SucursalDestino
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISArtSubCosto @Articulo, @SubCuenta, @EmpresaDestino, @SucursalDestino, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END   
      FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta, @EmpresaDestino, @SucursalDestino
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISArtSubCosto *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtSubCosto') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtSubCosto
GO             
CREATE PROCEDURE speCommerceSolicitudISArtSubCosto
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @EmpresaDestino		varchar(5),
	@SucursalDestino	int,
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ArtSubCosto" SubReferencia="ArtSubCosto" Version="1.0"><Solicitud> <ArtSubCosto Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" EmpresaDestino="'+ISNULL(CONVERT(varchar,@EmpresaDestino),'')+'" SucursalDestino="'+ISNULL(CONVERT(varchar,@SucursalDestino),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceArtSubCosto *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtSubCosto') and type = 'P') drop procedure dbo.spISeCommerceArtSubCosto
GO             
CREATE PROCEDURE spISeCommerceArtSubCosto
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
  @Articulo			varchar(20),
  @SubCuenta			varchar(50),
  @EmpresaDestino		varchar(5),
  @SucursalDestino		int,
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max),
  @UltimoCosto float,
  @CostoPromedio float,
  @CostoEstandar float,
  @CostoReposicion float,
  @UltimoCostoSinGastos float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float
  
	SELECT @Usuario = WebUsuario
	FROM WebVersion
  
  SELECT @Empresa = Empresa,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
		 @EmpresaDestino = EmpresaDestino,
		 @SucursalDestino = SucursalDestino,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ArtSubCosto')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Articulo varchar(20), SubCuenta varchar(50), EmpresaDestino varchar(5), SucursalDestino int)
    
	SELECT
		@UltimoCosto = UltimoCosto,
		@CostoPromedio = CostoPromedio,
		@CostoEstandar = CostoEstandar,
		@CostoReposicion = CostoReposicion,
		@UltimoCostoSinGastos = UltimoCostoSinGastos
	FROM ArtSubCosto WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Empresa = @EmpresaDestino AND Sucursal = @SucursalDestino
	
    IF(SELECT eCommerceImpuestoIncluido FROM Sucursal WHERE Sucursal = @Sucursal) = 1
    BEGIN
		EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, 0, NULL, NULL, NULL, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT

		SELECT @UltimoCosto = dbo.fnWebPrecioConImpuestos(@UltimoCosto,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoPromedio = dbo.fnWebPrecioConImpuestos(@CostoPromedio,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoEstandar = dbo.fnWebPrecioConImpuestos(@CostoEstandar,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoReposicion = dbo.fnWebPrecioConImpuestos(@CostoReposicion,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @UltimoCostoSinGastos = dbo.fnWebPrecioConImpuestos(@UltimoCostoSinGastos,@Impuesto1,@Impuesto2,@Impuesto3)
	END

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ArtSubCosto '+(SELECT  
						' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSubCosto.Sucursal)),'')+'"'+ 
						' Empresa="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSubCosto.Empresa)),'')+'"'+ 
						' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSubCosto.Articulo)),'')+'"'+ 
						' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSubCosto.SubCuenta)),'')+'"'+ 
						' UltimoCosto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@UltimoCosto)),'')+'"'+ 
						' CostoPromedio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@CostoPromedio)),'')+'"'+ 
						' CostoEstandar="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@CostoEstandar)),'')+'"'+ 
						' CostoReposicion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@CostoReposicion)),'')+'"'+ 
						' UltimoCostoSinGastos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@UltimoCostoSinGastos)),'')+'"'+ 
		' />' FROM ArtSubCosto ArtSubCosto WHERE  Articulo = @Articulo AND SubCuenta = @SubCuenta AND Empresa = @EmpresaDestino AND Sucursal = @SucursalDestino) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ArtSubCosto" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' EmpresaDestino=' + CHAR(34) + ISNULL(CONVERT(varchar,@EmpresaDestino),'') + CHAR(34) +' SucursalDestino=' + CHAR(34) + ISNULL(CONVERT(varchar,@SucursalDestino),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtSubABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtSubABC
GO
CREATE TRIGGER tgeCommerceArtSubABC ON ArtSub
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @Articulo			varchar(20),
   @SubCuenta			varchar(50),
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @eCommerceSucursal    varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Articulo, SubCuenta
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF (EXISTS(SELECT ID FROM WebArt WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta) OR EXISTS(SELECT ID FROM WebArtVariacionCombinacion WHERE Articulo = Articulo AND SubCuenta = @SubCuenta)) AND EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

              EXEC speCommerceSolicitudISArtSub @Articulo, @SubCuenta, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
              FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END  
      FETCH NEXT FROM crActualizar INTO @Articulo, @SubCuenta
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISArtSub *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISArtSub') and type = 'P') drop procedure dbo.speCommerceSolicitudISArtSub
GO             
CREATE PROCEDURE speCommerceSolicitudISArtSub
    @Articulo			varchar(20),
    @SubCuenta			varchar(50),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.ArtSub" SubReferencia="ArtSub" Version="1.0"><Solicitud> <ArtSub Articulo="'+ISNULL(CONVERT(varchar,@Articulo),'')+'" SubCuenta="'+ISNULL(CONVERT(varchar,@SubCuenta),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceArtSub *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceArtSub') and type = 'P') drop procedure dbo.spISeCommerceArtSub
GO             
CREATE PROCEDURE spISeCommerceArtSub
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
  @Articulo			varchar(20),
  @SubCuenta			varchar(50),
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) ,
  @CostoEstandar float,
  @CostoReposicion float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float

  SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
		 @Articulo = Articulo,
		 @SubCuenta = SubCuenta,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/ArtSub')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Articulo varchar(20), SubCuenta varchar(50))
    
	SELECT
		@CostoEstandar = CostoEstandar,
		@CostoReposicion = CostoReposicion
	FROM ArtSub WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta
	
    IF(SELECT eCommerceImpuestoIncluido FROM Sucursal WHERE Sucursal = @Sucursal) = 1
    BEGIN
		EXEC spDesglosarPrecioCImpuestos  @Articulo, @Usuario, @Empresa, @Sucursal, 0, NULL, NULL, NULL, @Impuesto1 OUTPUT, @Impuesto2 OUTPUT, @Impuesto3 OUTPUT
		
		SELECT @CostoEstandar = dbo.fnWebPrecioConImpuestos(@CostoEstandar,@Impuesto1,@Impuesto2,@Impuesto3)
		SELECT @CostoReposicion = dbo.fnWebPrecioConImpuestos(@CostoReposicion,@Impuesto1,@Impuesto2,@Impuesto3)
	END

    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<ArtSub '+(SELECT  
						' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.Articulo)),'')+'"'+ 
						' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.SubCuenta)),'')+'"'+ 
						' CostoEstandar="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@CostoEstandar)),'')+'"'+ 
						' CostoReposicion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),@CostoReposicion)),'')+'"'+ 
						' TieneMovimientos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.TieneMovimientos)),'')+'"'+ 
						' Fabricante="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.Fabricante)),'')+'"'+ 
						' ClaveFabricante="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.ClaveFabricante)),'')+'"'+ 
						' Horas="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.Horas)),'')+'"'+ 
						' Minutos="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),ArtSub.Minutos)),'')+'"'+ 
		' />' FROM ArtSub ArtSub WHERE  Articulo = @Articulo AND SubCuenta = @SubCuenta) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="ArtSub" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Articulo=' + CHAR(34) + ISNULL(CONVERT(varchar,@Articulo),'') + CHAR(34) +' SubCuenta=' + CHAR(34) + ISNULL(CONVERT(varchar,@SubCuenta),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebEstatusExistenciaABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebEstatusExistenciaABC
GO
CREATE TRIGGER tgeCommerceWebEstatusExistenciaABC ON WebEstatusExistencia
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
	@WebEstatusExistencia	varchar(20),
	@Estatus             varchar(10),
	@Ok                  int,
	@OkRef               varchar(255),
	@eCommerceSucursal    varchar(10),
	@Sucursal            int,
	@Cinserted           int,
	@Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT WebEstatusExistencia, Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT WebEstatusExistencia, Sucursal
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @WebEstatusExistencia, @Sucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
		SELECT @eCommerceSucursal = eCommerceSucursal FROM Sucursal WHERE Sucursal = @Sucursal
		EXEC speCommerceSolicitudISWebEstatusExistencia @WebEstatusExistencia, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
      END
      FETCH NEXT FROM crActualizar INTO @WebEstatusExistencia, @Sucursal
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISWebEstatusExistencia *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebEstatusExistencia') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebEstatusExistencia
GO             
CREATE PROCEDURE speCommerceSolicitudISWebEstatusExistencia
	@WebEstatusExistencia	varchar(20),
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebEstatusExistencia" SubReferencia="WebEstatusExistencia" Version="1.0"><Solicitud> <WebEstatusExistencia WebEstatusExistencia="'+ISNULL(CONVERT(varchar,@WebEstatusExistencia),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
  
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceWebEstatusExistencia *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebEstatusExistencia') and type = 'P') drop procedure dbo.spISeCommerceWebEstatusExistencia
GO             
CREATE PROCEDURE spISeCommerceWebEstatusExistencia
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
  @WebEstatusExistencia	varchar(20),
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) ,
  @CostoEstandar float,
  @CostoReposicion float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float

  SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
		 @WebEstatusExistencia = WebEstatusExistencia,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebEstatusExistencia')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), WebEstatusExistencia	varchar(20))
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
	SELECT @Tabla = '<WebEstatusExistencia '+(SELECT  
		' WebEstatusExistencia="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.WebEstatusExistencia)),'')+'"'+ 
		' Sucursal="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.Sucursal)),'')+'"'+ 
		' Descripcion="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.Descripcion)),'')+'"'+ 
		' EntregaDias="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.EntregaDias)),'')+'"'+ 
		' VentaPermitir="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.VentaPermitir)),'')+'"'+ 
		' PeriodoEntrega="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEstatusExistencia.PeriodoEntrega)),'')+'"'+ 
		' />' FROM WebEstatusExistencia WebEstatusExistencia WHERE  WebEstatusExistencia.WebEstatusExistencia = @WebEstatusExistencia AND WebEstatusExistencia.Sucursal = @Sucursal)
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebEstatusExistencia" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' WebEstatusExistencia=' + CHAR(34) + ISNULL(CONVERT(varchar,@WebEstatusExistencia),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceDiaFestivoABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceDiaFestivoABC
GO
CREATE TRIGGER tgeCommerceDiaFestivoABC ON DiaFestivo
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
	@Fecha				 datetime,
	@Estatus             varchar(10),
	@Ok                  int,
	@OkRef               varchar(255),
	@eCommerceSucursal    varchar(10),
	@Sucursal            int,
	@Cinserted           int,
	@Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

   IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Fecha
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Fecha
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Fecha
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

      IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
      BEGIN
        DECLARE crSucursal CURSOR local FOR
         SELECT Sucursal, eCommerceSucursal
           FROM Sucursal
          WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
        OPEN crSucursal
        FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
        BEGIN

          EXEC speCommerceSolicitudISDiaFestivo @Fecha, @Sucursal, @eCommerceSucursal, @Estatus, @Ok, @OkRef
          FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
        END        
        CLOSE crSucursal
        DEALLOCATE crSucursal    
      END  
      FETCH NEXT FROM crActualizar INTO @Fecha
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* speCommerceSolicitudISDiaFestivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISDiaFestivo') and type = 'P') drop procedure dbo.speCommerceSolicitudISDiaFestivo
GO             
CREATE PROCEDURE speCommerceSolicitudISDiaFestivo
	@Fecha			datetime,
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.DiaFestivo" SubReferencia="DiaFestivo" Version="1.0"><Solicitud> <DiaFestivo Fecha="'+ISNULL(CONVERT(varchar,@Fecha),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

/******************************* spISeCommerceDiaFestivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceDiaFestivo') and type = 'P') drop procedure dbo.spISeCommerceDiaFestivo
GO             
CREATE PROCEDURE spISeCommerceDiaFestivo
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
  @Fecha				datetime,
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) ,
  @CostoEstandar float,
  @CostoReposicion float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float

  SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
		 @Fecha = Fecha,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/DiaFestivo')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), Fecha	datetime)
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
	SELECT @Tabla = '<DiaFestivo '+(SELECT  
		' Fecha="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),dbo.fnWebDateToUnix(DiaFestivo.Fecha))),'')+'"'+ 
		' Concepto="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),DiaFestivo.Concepto)),'')+'"'+ 
		' EsLaborable="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),DiaFestivo.EsLaborable)),'')+'"'+ 
		' />' FROM DiaFestivo DiaFestivo WHERE  DiaFestivo.Fecha = @Fecha)
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="DiaFestivo" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' Fecha=' + CHAR(34) + ISNULL(CONVERT(varchar,dbo.fnWebDateToUnix(@Fecha)),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

/******************************* spISeCommerceWebEnvolturaRegalo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebEnvolturaRegalo') and type = 'P') drop procedure dbo.spISeCommerceWebEnvolturaRegalo
GO             
CREATE PROCEDURE spISeCommerceWebEnvolturaRegalo
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
  @IDEnvoltura			int,
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) ,
  @CostoEstandar float,
  @CostoReposicion float,
  @Usuario				varchar(10),
  @Impuesto1    float,
  @Impuesto2    float,
  @Impuesto3    float

  SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
		 @IDEnvoltura = ID,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebEnvolturaRegalo')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), ID int)
    
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID
    IF @Estatus IN ('ALTA','CAMBIO') 
      SELECT @Tabla = '<WebEnvolturaRegalo '+(SELECT  
						' ID="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.ID)),'')+'"'+ 
						' SucursaleCommerce="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.SucursaleCommerce)),'')+'"'+ 
						' Nombre="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.Nombre)),'')+'"'+ 
						' Precio="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.Precio)),'')+'"'+ 
						' Visible="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.Visible)),'')+'"'+ 
						' PermiteMensaje="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.PermiteMensaje)),'')+'"'+ 
						' Imagen="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.Imagen)),'')+'"'+ 
						' Articulo="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.Articulo)),'')+'"'+ 
						' SubCuenta="'+ISNULL(dbo.fneWebConvertirDescripcionHTML(CONVERT(varchar(1000),WebEnvolturaRegalo.SubCuenta)),'')+'"'+ 
		' />' FROM WebEnvolturaRegalo WebEnvolturaRegalo WHERE  ID = @IDEnvoltura) 
    ELSE   SELECT @Tabla = ''
    
    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebEnvolturaRegalo" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +' ID=' + CHAR(34) + ISNULL(CONVERT(varchar,@IDEnvoltura),'') + CHAR(34) +' >'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

/******************************* speCommerceSolicitudISWebEnvolturaRegalo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebEnvolturaRegalo') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebEnvolturaRegalo
GO             
CREATE PROCEDURE speCommerceSolicitudISWebEnvolturaRegalo
    @ID					int,
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal

  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebEnvolturaRegalo" SubReferencia="WebEnvolturaRegalo" Version="1.0"><Solicitud> <WebEnvolturaRegalo ID="'+ISNULL(CONVERT(varchar,@ID),'')+'" Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebEnvolturaRegaloABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebEnvolturaRegaloABC
GO
CREATE TRIGGER tgeCommerceWebEnvolturaRegaloABC ON WebEnvolturaRegalo
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @ID					int,
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @SucursaleCommerce   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN( 'ALTA','CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, SucursaleCommerce
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT ID, SucursaleCommerce
       FROM Deleted     
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @ID, @SucursaleCommerce
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

	  SELECT @Sucursal = Sucursal FROM Sucursal WHERE eCommerceSucursal = @SucursaleCommerce
	  EXEC speCommerceSolicitudISWebEnvolturaRegalo @ID, @Sucursal, @SucursaleCommerce, @Estatus, @Ok, @OkRef

      FETCH NEXT FROM crActualizar INTO @ID, @SucursaleCommerce
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO

/******************************* spISeCommerceWebCertificadosRegalo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spISeCommerceWebCertificadosRegalo') and type = 'P') drop procedure dbo.spISeCommerceWebCertificadosRegalo
GO             
CREATE PROCEDURE spISeCommerceWebCertificadosRegalo
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
  @Montos varchar(100),
  @Estatus				varchar(10),
  @Empresa              varchar(5),
  @Sucursal             int,
  @eCommerceSucursal    varchar(10),
  @ReferenciaIS         varchar(100),
  @Tabla                varchar(max) , 
  @Resultado2			varchar(max) ,
  @CostoEstandar float,
  @CostoReposicion float,
  @Usuario				varchar(10)

  SELECT @Usuario = WebUsuario
	FROM WebVersion

  SELECT @Empresa = Empresa,
         @Sucursal = Sucursal,
         @eCommerceSucursal = eCommerceSucursal,
         @Estatus = Estatus
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/WebCertificadosRegalo')
    WITH (Empresa varchar(5),  Sucursal int, eCommerceSucursal  varchar(10), Estatus varchar(10), IDCertificado int, IDCertificadoA int)
    
  SELECT @Montos = ISNULL(@Montos,'') + ',' + Convert(varchar,Monto)  
    FROM  WebCertificadosRegalo
   WHERE Sucursal = @Sucursal
   ORDER by Monto ASC
  
    SELECT @ReferenciaIS = Referencia 
      FROM IntelisisService 
     WHERE ID = @ID

      SELECT @Tabla = '<WebCertificadosRegalo Montos="'+ISNULL(STUFF(@Montos,1,1,''), '')+'" />'

    SELECT @Resultado2 = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia="WebCertificadosRegalo" Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) +' Empresa=' + CHAR(34) + ISNULL(@Empresa,'') + CHAR(34)+ ' Sucursal=' + CHAR(34) + ISNULL(CONVERT(varchar,@Sucursal),'') + CHAR(34)+' eCommerceSucursal=' + CHAR(34) + ISNULL(@eCommerceSucursal,'') + CHAR(34)+ ' Estatus=' + CHAR(34) + ISNULL(@Estatus,'') + CHAR(34) +'>'
    
    SELECT @Resultado = @Resultado2+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 
    
END
GO

/******************************* speCommerceSolicitudISWebCertificadosRegalo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.speCommerceSolicitudISWebCertificadosRegalo') and type = 'P') drop procedure dbo.speCommerceSolicitudISWebCertificadosRegalo
GO             
CREATE PROCEDURE speCommerceSolicitudISWebCertificadosRegalo
    @Sucursal           int,
    @eCommerceSucursal  varchar(10),
    @Estatus			varchar(10),
	@Ok			int = NULL OUTPUT,
	@OkRef	 		varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @ID		   int,
  @Usuario     varchar(10),
  @IDAcceso    int,
  @Estacion    int,
  @Contrasena  varchar(32),
  @DropBox     varchar(255),
  @Ruta        varchar(255),
  @Empresa     varchar(5),
  @xml         varchar(max),
  @xml2        varchar(max),
  @Resultado   varchar(max),
  @Solicitud   varchar(max),
  @Archivo     varchar(max),
  @eCommerceOffLine bit
  
  SELECT @eCommerceOffLine = ISNULL(eCommerceOffLine,0) FROM Sucursal WHERE Sucursal = @Sucursal
  
  SELECT @Usuario = WebUsuario, @DropBox = DirSFTP  FROM WebVersion

  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal
  
  IF @eCommerceOffLine = 1
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'  

  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
   
  SELECT @Estacion = @@SPID

  SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.eCommerce.WebCertificadosRegalo" SubReferencia="WebCertificadosRegalo" Version="1.0"><Solicitud> <WebCertificadosRegalo Sucursal="'+ISNULL(CONVERT(varchar,@Sucursal),'')+'" eCommerceSucursal="'+ISNULL(@eCommerceSucursal,'')+'" Estatus="'+ISNULL(@Estatus,'')+'" Empresa="'+ISNULL(@Empresa,'')+'" />  </Solicitud> </Intelisis>'

  EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @ID OUTPUT
  
  IF @ID IS NOT NULL AND @Ok IS NULL
  BEGIN
    SELECT @Archivo = @Ruta+'\IE_'+CONVERT(varchar,@ID)+'.xml'

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @Archivo, @Resultado, @Ok OUTPUT,@OkRef OUTPUT
  END    
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceWebCertificadosRegaloABC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceWebCertificadosRegaloABC
GO
CREATE TRIGGER tgeCommerceWebCertificadosRegaloABC ON WebCertificadosRegalo
FOR INSERT, UPDATE ,DELETE
AS BEGIN
-- SET nocount ON
  DECLARE
   @IDCertificado		int,
   @IDCertificadoA		int,
   @IDUsuario           int,
   @Estatus             varchar(10),
   @Ok                  int,
   @OkRef               varchar(255),
   @SucursaleCommerce   varchar(10),
   @Sucursal            int,
   @Cinserted           int,
   @Cdeleted            int

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted <> 0 AND @Cdeleted = 0 
    SET @Estatus = 'ALTA' 
  IF @Cinserted <> 0 AND @Cdeleted<> 0 
    SET @Estatus = 'CAMBIO'
  IF @Cinserted = 0 AND @Cdeleted <> 0 
    SET @Estatus = 'BAJA'

  IF  @Estatus IN ('ALTA', 'CAMBIO')
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Sucursal
       FROM Inserted
  END
  ELSE
  IF @Estatus = 'BAJA'
  BEGIN
    DECLARE crActualizar CURSOR local FOR
     SELECT Sucursal
       FROM Deleted
  END    
  IF @Estatus IS NOT NULL
  BEGIN      
    OPEN crActualizar
    FETCH NEXT FROM crActualizar INTO @Sucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN

	  SELECT @SucursaleCommerce = eCommerceSucursal FROM Sucursal WHERE @Sucursal = Sucursal
	  EXEC speCommerceSolicitudISWebCertificadosRegalo @Sucursal, @SucursaleCommerce, @Estatus, @Ok, @OkRef

      FETCH NEXT FROM crActualizar INTO @Sucursal
    END
  CLOSE crActualizar
  DEALLOCATE crActualizar
  END
END
GO