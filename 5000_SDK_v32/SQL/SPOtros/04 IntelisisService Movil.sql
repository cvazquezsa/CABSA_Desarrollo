SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO
 

/****** AgenteArt ******/

if not exists(select * from SysTabla where SysTabla = 'AgenteArt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteArt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteArt') and type = 'U') 
CREATE TABLE dbo.AgenteArt (
	Agente 		varchar(10) NOT NULL,
	Articulo	varchar(20) NOT NULL,

	CONSTRAINT priAgenteArt PRIMARY KEY CLUSTERED (Agente, Articulo)
)
GO



 
 
/**************** spISIntelisisConfigUsuarioVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisConfigUsuarioVerificar') and type = 'P') drop procedure dbo.spISIntelisisConfigUsuarioVerificar
GO
CREATE PROCEDURE spISIntelisisConfigUsuarioVerificar
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @Referencia			varchar(100),
  @SubReferencia		varchar(100),
  @Texto				varchar(max),
  @Usuario				varchar(10),
  @Contrasena			varchar(32)
    
  SELECT
    @Referencia    = Referencia,
    @SubReferencia = SubReferencia
    FROM OPENXML (@iSolicitud,'/Intelisis')
    WITH (Referencia varchar(100), SubReferencia varchar(100))

  SELECT
    @Usuario    = Usuario,
    @Contrasena = Contrasena
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Usuario varchar(10), Contrasena varchar(32))

  IF NOT EXISTS (SELECT Usuario FROM Usuario WHERE Usuario = @Usuario)
    SELECT @Ok = 71020, @OkRef = (SELECT Descripcion + ' ' + @Usuario FROM MensajeLista WHERE Mensaje = 71020)
  ELSE
  IF (SELECT Contrasena FROM Usuario WHERE Usuario = @Usuario) <> @Contrasena
    SELECT @Ok = 60230, @OkRef = (SELECT dbo.fneDocXmlAUtf8(Descripcion,0,0) + ' ' + @Usuario FROM MensajeLista WHERE Mensaje = 60230)
  
  IF @Ok IS NULL
    SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
  ELSE
  BEGIN
    SET @OkRef = (SELECT dbo.fneDocXmlAUtf8(Descripcion,0,1) + ' ' + @Usuario FROM MensajeLista WHERE Mensaje = @Ok)
    SET @Resultado = '<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@Referencia,'') + CHAR(34) + ' SubReferencia=' + CHAR(34) + ISNULL(@SubReferencia,'') + CHAR(34) + ' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'') + CHAR(34) + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34) + '>' + CONVERT(varchar(max),ISNULL(@Texto,'')) + '</Resultado></Intelisis>'
  END
    
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Config.Usuario.Verificar" SubReferencia="" Version="1.0">
--  <Solicitud>
--   <Parametro Usuario="Demo" Contrasena="0633971b5e442cd51b8e0a972d74f05h"/>
--  </Solicitud>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="" SubReferencia="" Version="1">
--  <Resultado IntelisisServiceID="1602" Ok="" OkRef="" />
--</Intelisis>


/**************** spISCuentaArtCat ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISCuentaArtCat') and type = 'P') drop procedure dbo.spISCuentaArtCat
GO             
CREATE PROCEDURE spISCuentaArtCat
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
  @ReferenciaIS         varchar(100),
  @SubReferenciaIS      varchar(100),
  @Tabla                varchar(max)

 SELECT @ReferenciaIS = Referencia ,@SubReferenciaIS = SubReferencia
   FROM IntelisisService
  WHERE ID = @ID
     
     
  SELECT @Tabla = (SELECT * FROM ArtCat FOR XML AUTO)
       
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.ArtCat" SubReferencia="" Version="1.0">
--  <Solicitud/>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Cuenta.ArtCat" SubReferencia="" Version="1">
--  <Resultado IntelisisServiceID="9577" Ok="" OkRef="">
--    <ArtCat Categoria="ACTIVOS FIJOS" ValidarPresupuestoCompra="No" />
--    <ArtCat Categoria="ARRENDAMIENTOS" ValidarPresupuestoCompra="No" />
--    <ArtCat Categoria="SERVICIOS" ValidarPresupuestoCompra="No" />
--    <ArtCat Categoria="VARIOS" ValidarPresupuestoCompra="No" />
--  </Resultado>
--</Intelisis>


/**************** spISCuentaArtFam ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISCuentaArtFam') and type = 'P') drop procedure dbo.spISCuentaArtFam
GO             
CREATE PROCEDURE spISCuentaArtFam
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
  @ReferenciaIS         varchar(100),
  @SubReferenciaIS      varchar(100),
  @Tabla                varchar(max)

 SELECT @ReferenciaIS = Referencia ,@SubReferenciaIS = SubReferencia
   FROM IntelisisService
  WHERE ID = @ID
     
     
  SELECT @Tabla = (SELECT * FROM ArtFam FOR XML AUTO)
       
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

--declare @datos		varchar(max),
--		@idatos		int, 
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.ArtFam" SubReferencia="" Version="1.0">
--  <Solicitud/>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<?xml version="1.0" encoding="Windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Cuenta.ArtFam" SubReferencia="" Version="1">
--        <Resultado IntelisisServiceID="9578" Ok="" OkRef="">
--                <ArtFam Familia="BODEGA" Precios="0"/>
--                <ArtFam Familia="CASA" Precios="0"/>
--                <ArtFam Familia="LOCAL" Precios="0"/>
--                <ArtFam Familia="MATERIALES DE CONSTRUCCION" Precios="0"/>
--                <ArtFam Familia="TERRENO" Precios="0"/>
--        </Resultado>
--</Intelisis>

/**************** spISCuentaArtGrupo ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISCuentaArtGrupo') and type = 'P') drop procedure dbo.spISCuentaArtGrupo
GO             
CREATE PROCEDURE spISCuentaArtGrupo
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
  @ReferenciaIS         varchar(100),
  @SubReferenciaIS      varchar(100),
  @Tabla                varchar(max)

 SELECT @ReferenciaIS = Referencia ,@SubReferenciaIS = SubReferencia
   FROM IntelisisService
  WHERE ID = @ID
     
     
  SELECT @Tabla = (SELECT * FROM ArtGrupo FOR XML AUTO)
       
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.ArtGrupo" SubReferencia="" Version="1.0">
--  <Solicitud/>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Cuenta.ArtGrupo" SubReferencia="" Version="1">
--        <Resultado IntelisisServiceID="9579" Ok="" OkRef="">
--                <ArtGrupo Grupo="ACTIVOS VARIOS"/>
--                <ArtGrupo Grupo="CANCELACION SALDOS PROVEEDOR"/>
--                <ArtGrupo Grupo="EQUIPO DE COMPUTACION"/>
--                <ArtGrupo Grupo="EQUIPO DE TRANSPORTE"/>
--                <ArtGrupo Grupo="MAQUINARIA Y EQUIPO"/>
--                <ArtGrupo Grupo="MOBILIARIO Y EQUIPO DE OFICINA"/>
--        </Resultado>
--</Intelisis>


/**************** spISCuentaArtLinea ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISCuentaArtLinea') and type = 'P') drop procedure dbo.spISCuentaArtLinea
GO             
CREATE PROCEDURE spISCuentaArtLinea
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
  @ReferenciaIS         varchar(100),
  @SubReferenciaIS      varchar(100),
  @Tabla                varchar(max)

 SELECT @ReferenciaIS = Referencia ,@SubReferenciaIS = SubReferencia
   FROM IntelisisService
  WHERE ID = @ID
     
     
  SELECT @Tabla = (SELECT * FROM ArtLinea FOR XML AUTO)
       
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.ArtLinea" SubReferencia="" Version="1.0">
--  <Solicitud/>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Cuenta.ArtLinea" SubReferencia="" Version="1">
--        <Resultado IntelisisServiceID="9580" Ok="" OkRef="">
--                <ArtLinea Linea="ACABADOS"/>
--                <ArtLinea Linea="AGLOMERANTES"/>
--                <ArtLinea Linea="AGREGADOS"/>
--                <ArtLinea Linea="AISLANTES"/>
--                <ArtLinea Linea="ARTEFACTOS SANITARIOS"/>
--                <ArtLinea Linea="AZULEJOS"/>
--                <ArtLinea Linea="CONCRETO"/>
--        </Resultado>
--</Intelisis>


/**************** spISCuentaUnidad ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spISCuentaUnidad') and type = 'P') drop procedure dbo.spISCuentaUnidad
GO             
CREATE PROCEDURE spISCuentaUnidad
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
  @ReferenciaIS         varchar(100),
  @SubReferenciaIS      varchar(100),
  @Tabla                varchar(max)

 SELECT @ReferenciaIS = Referencia ,@SubReferenciaIS = SubReferencia
   FROM IntelisisService
  WHERE ID = @ID
     
     
  SELECT @Tabla = (SELECT * FROM Unidad FOR XML AUTO)
       
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

END
GO


--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Cuenta.Unidad" SubReferencia="" Version="1.0">
--  <Solicitud/>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Cuenta.Unidad" SubReferencia="" Version="1">
--        <Resultado IntelisisServiceID="9581" Ok="" OkRef="">
--                <Unidad Unidad="kg" Factor="1.000000000000000e+000" Multiplo="1.000000000000000e+000" Decimales="2" Orden="2"/>
--                <Unidad Unidad="pza" Factor="1.000000000000000e+000" Multiplo="1.000000000000000e+000" Decimales="0" Orden="1"/>
--                <Unidad Unidad="ton" Factor="1.000000000000000e-003" Multiplo="1.000000000000000e+000" Decimales="2" Orden="3"/>
--        </Resultado>
--</Intelisis>

 


/**************** spISIntelisisCatalogoAgenteArtListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisCatalogoAgenteArtListado') and type = 'P') drop procedure dbo.spISIntelisisCatalogoAgenteArtListado
GO
CREATE PROCEDURE spISIntelisisCatalogoAgenteArtListado
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @ReferenciaIS			varchar(100),
  @SubReferenciaIS		varchar(100),
  @Tabla			varchar(max),
  @Agente			varchar(10)
    
  SELECT
    @ReferenciaIS    = Referencia,
    @SubReferenciaIS = SubReferencia
    FROM OPENXML (@iSolicitud,'/Intelisis')
    WITH (Referencia varchar(100), SubReferencia varchar(100))

  SELECT
    @Agente    = Agente
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Agente varchar(10))
    
  IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente)
    SELECT @Ok = 26090  
  IF @Ok IS NOT NULL
    SET @OkRef = ISNULL(@OkRef,'')+(SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok)  

  SELECT @Tabla = ( SELECT Art.Articulo, Art.Descripcion1, Art.Descripcion2, Art.Grupo, Art.Categoria, Art.Familia, Art.Linea, CONVERT(Decimal(20,6),Art.Impuesto1)Impuesto1,  CONVERT(Decimal(20,6),Art.Impuesto2)Impuesto2,  CONVERT(Decimal(20,6),Art.Impuesto3)Impuesto3, Art.Unidad, Art.Tipo, Art.MonedaPrecio, Art.Estatus, Art.Situacion,  CONVERT(Decimal(20,6),Art.Retencion1)Retencion1,  CONVERT(Decimal(20,6),Art.Retencion2)Retencion2,ArtUnidad.*
                      FROM Art Art JOIN Agenteart aa ON Art.Articulo = aa.Articulo
                      LEFT JOIN ArtUnidad ArtUnidad ON Art.Articulo = ArtUnidad.Articulo
                     WHERE aa.Agente = @Agente FOR XML AUTO)       
    
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

    
END
GO

--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Catalogo.AgenteArt.Listado" SubReferencia="" Version="1.0">
--  <Solicitud>
--   <Parametro Agente="Demo" />
--  </Solicitud>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Catalogo.AgenteArt.Listado" SubReferencia="" Version="1">
--  <Resultado IntelisisServiceID="9767" Ok="" OkRef="">
--    <Art Articulo="12123" Descripcion1="aretes" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="1234" Descripcion1="etcetera accesorios" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="212343" Descripcion1="pulseras" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="23212ER" Descripcion1="Libro Cocina" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="33423" Descripcion1="collar" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="3456DE" Descripcion1="Libro Novela" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="8789HU" Descripcion1="Libro Arquitectura" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="BOB23" Descripcion1="Bob esponja" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--  </Resultado>
--</Intelisis>


/**************** spISIntelisisCatalogoAgenteCteListado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISIntelisisCatalogoAgenteCteListado') and type = 'P') drop procedure dbo.spISIntelisisCatalogoAgenteCteListado
GO
CREATE PROCEDURE spISIntelisisCatalogoAgenteCteListado
		@ID				int,
		@iSolicitud		int,
		@Version		float,
		@Resultado		varchar(max) = NULL OUTPUT,
		@Ok				int = NULL OUTPUT,    
		@OkRef			varchar(255) = NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE 
  @ReferenciaIS			varchar(100),
  @SubReferenciaIS		varchar(100),
  @Tabla			varchar(max),
  @Agente			varchar(10)
    
  SELECT
    @ReferenciaIS    = Referencia,
    @SubReferenciaIS = SubReferencia
    FROM OPENXML (@iSolicitud,'/Intelisis')
    WITH (Referencia varchar(100), SubReferencia varchar(100))

  SELECT
    @Agente    = Agente
    FROM OPENXML (@iSolicitud,'/Intelisis/Solicitud/Parametro')
    WITH (Agente varchar(10))

  SELECT @Tabla = (SELECT Cliente, Nombre, Direccion, DireccionNumero, DireccionNumeroInt, EntreCalles, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, RFC, Telefonos, Contacto1, eMail1, Situacion, Agente, Condicion, Ruta, ListaPrecios, Estatus, CreditoLimite, CreditoLimitePedidos, CreditoDias, AlmacenDef
                     FROM Cte
                    WHERE Agente = @Agente
                     FOR XML AUTO  )       
  IF NOT EXISTS(SELECT * FROM Agente WHERE Agente = @Agente)
    SELECT @Ok = 26090  
  IF @Ok IS NOT NULL
    SET @OkRef = ISNULL(@OkRef,'')+(SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) 
        
  SELECT @Resultado = '<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia=' + CHAR(34) + ISNULL(@ReferenciaIS,'') + CHAR(34) + ' SubReferencia='+ CHAR(34) + ISNULL(@SubReferenciaIS,'') + CHAR(34) +' Version=' + CHAR(34) + ISNULL(CONVERT(varchar ,@Version),'') + CHAR(34) + '><Resultado IntelisisServiceID=' + CHAR(34) + ISNULL(CONVERT(varchar,@ID),'')  + CHAR(34)  + ' Ok=' + CHAR(34) + ISNULL(CONVERT(varchar,@Ok),'') + CHAR(34) + ' OkRef=' + CHAR(34) + ISNULL(@OkRef,'') + CHAR(34)+ '>'+ISNULL(@Tabla,'')+'</Resultado></Intelisis>' 

    
END
GO



--declare @datos		varchar(max),
--		@idatos		int,
--		@Resultado  varchar(max),
--		@Ok			int,
--		@OkRef		varchar(255),
--		@Id			int
		  
--set @Ok = null
--set @OkRef = null
--set @datos='<?xml version="1.0" encoding="windows-1252"?>
--<Intelisis Sistema="Intelisis" Contenido="Solicitud" Referencia="Intelisis.Catalogo.AgenteCte.Listado" SubReferencia="" Version="1.0">
--  <Solicitud>
--   <Parametro Agente="Demo" />
--  </Solicitud>
--</Intelisis>'
--EXEC spIntelisisService 'DEMO','0633971b5e442cd51b8e0a972d74f054',@Datos,@Resultado Output,@Ok Output,@OkRef Output,1,0,@Id Output
--select CONVERT(XML,@Resultado),@Resultado,@Ok,@OkRef
--GO

--<Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Catalogo.AgenteArt.Listado" SubReferencia="" Version="1">
--  <Resultado IntelisisServiceID="9767" Ok="" OkRef="">
--    <Art Articulo="12123" Descripcion1="aretes" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="1234" Descripcion1="etcetera accesorios" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="212343" Descripcion1="pulseras" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="23212ER" Descripcion1="Libro Cocina" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="33423" Descripcion1="collar" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="3456DE" Descripcion1="Libro Novela" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="8789HU" Descripcion1="Libro Arquitectura" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--    <Art Articulo="BOB23" Descripcion1="Bob esponja" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" Tipo="Normal" MonedaPrecio="Pesos" Estatus="ALTA">
--      <ArtUnidad />
--    </Art>
--  </Resultado>
--</Intelisis>

 
 


/**************** spIntelisisServiceProcesarMovil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisServiceProcesarMovil') and type = 'P') drop procedure dbo.spIntelisisServiceProcesarMovil
GO
CREATE PROCEDURE spIntelisisServiceProcesarMovil
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
  IF @Referencia = 'Intelisis.Config.Usuario.Verificar' EXEC spISIntelisisConfigUsuarioVerificar  @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE  
  IF @Referencia = 'Intelisis.Cuenta.ArtCat' EXEC spISCuentaArtCat @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @Referencia = 'Intelisis.Cuenta.ArtFam' EXEC spISCuentaArtFam @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @Referencia = 'Intelisis.Cuenta.ArtGrupo' EXEC spISCuentaArtGrupo @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @Referencia = 'Intelisis.Cuenta.ArtLinea' EXEC spISCuentaArtLinea @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @Referencia = 'Intelisis.Cuenta.Unidad' EXEC spISCuentaUnidad @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE 
  IF @Referencia = 'Intelisis.Catalogo.AgenteCte.Listado' EXEC spISIntelisisCatalogoAgenteCteListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE    
  IF @Referencia = 'Intelisis.Catalogo.AgenteArt.Listado' EXEC spISIntelisisCatalogoAgenteArtListado @ID, @iSolicitud, @Version, @Resultado OUTPUT, @Ok OUTPUT, @OkRef OUTPUT     
  
  RETURN
END
GO

--select convert(xml,'<?xml version="1.0" encoding="windows-1252"?><Intelisis Sistema="Intelisis" Contenido="Resultado" Referencia="Intelisis.Catalogo.AgenteArt.Listado" SubReferencia="" Version="1"><Resultado IntelisisServiceID="9757" Ok="" OkRef=""><Art Articulo="12123" Descripcion1="aretes" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" PrecioLista="45.0000" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-05T11:12:07" Alta="2012-12-05T10:39:33" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY3k=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="1234" Descripcion1="etcetera accesorios" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-04T19:18:10" Alta="2012-12-04T19:16:48" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4Y=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="212343" Descripcion1="pulseras" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-05T10:39:26" Alta="2012-12-05T10:39:15" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4c=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="23212ER" Descripcion1="Libro Cocina" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-10T11:05:35" Alta="2012-12-10T11:05:12" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4g=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="33423" Descripcion1="collar" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-05T10:38:58" Alta="2012-12-05T10:38:29" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4k=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="3456DE" Descripcion1="Libro Novela" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-10T10:05:23" Alta="2012-12-10T10:04:53" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4o=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="8789HU" Descripcion1="Libro Arquitectura" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-10T11:06:11" Alta="2012-12-10T11:05:48" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4s=" SincroC="1" Calificacion="0"><ArtUnidad/></Art><Art Articulo="BOB23" Descripcion1="Bob esponja" Categoria="VARIOS" Impuesto1="1.500000000000000e+001" Unidad="Piezas" UnidadCompra="Piezas" UnidadCantidad="1.000000000000000e+000" TipoCosteo="Promedio" Tipo="Normal" TipoOpcion="No" Accesorios="0" Refacciones="0" Sustitutos="0" Servicios="0" Consumibles="0" MonedaCosto="Pesos" MonedaPrecio="Pesos" FactorAlterno="1.000000000000000e+000" Estatus="ALTA" UltimoCambio="2012-12-10T11:06:40" Alta="2012-12-10T11:06:24" Conciliar="0" Usuario="DEMO" Refrigeracion="0" TieneCaducidad="0" BasculaPesar="0" SeProduce="0" EstatusPrecio="NUEVO" wMostrar="1" SeCompra="1" SeVende="1" EsFormula="0" MultiplosOrdenar="1.000000000000000e+000" ProdCantidad="1.000000000000000e+000" ProdUsuario="(Mismo)" ProdPasoTotal="1" ProdOpciones="0" ProdVerConcentracion="0" ProdVerCostoAcumulado="0" ProdVerMerma="0" ProdVerDesperdicio="0" ProdVerPorcentaje="0" RevisionUsuario="DEMO" ProdMov="(por omision)" TieneMovimientos="1" EstatusCosto="SINCAMBIO" SolicitarPrecios="0" Espacios="0" EspaciosEspecificos="0" EspaciosNivel="Dia" EspaciosMinutos="60" EspaciosBloquearAnteriores="1" SerieLoteInfo="0" FactorCompra="1.000000000000000e+000" ISAN="0" ExcluirDescFormaPago="0" EsDeducible="0" TipoCatalogo="Resurtible" AnexosAlFacturar="0" Actividades="0" ValidarPresupuestoCompra="No" SeriesLotesAutoOrden="(Empresa)" LotesFijos="0" LotesAuto="0" TieneDireccion="0" PrecioLiberado="0" ValidarCodigo="0" CostoIdentificado="0" Impuesto1Excento="0" CalcularPresupuesto="0" Excento2="0" Excento3="0" NivelToleranciaCosto="(Empresa)" SincroID="AAAAAAABY4A=" SincroC="1" Calificacion="0"><ArtUnidad/></Art></Resultado></Intelisis>')


