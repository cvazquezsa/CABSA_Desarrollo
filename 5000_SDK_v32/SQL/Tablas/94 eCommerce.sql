SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 

/**************** fnWebArtVariacionTieneWebArt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebArtVariacionTieneWebArt')
BEGIN
	EXEC spDROP_COLUMN 'WebArtVariacion', 'TieneWebArt'
	DROP FUNCTION fnWebArtVariacionTieneWebArt
END
GO
CREATE FUNCTION fnWebArtVariacionTieneWebArt 
	(@ID   int)
RETURNS bit
AS BEGIN
DECLARE @Return bit
IF EXISTS(SELECT TOP 1 ID FROM WebArt WHERE VariacionID = @ID)
	SELECT @Return = 1
ELSE
	SELECT @Return = 0
RETURN @Return
END
GO

/****** ContactoDireccion  ******/
if not exists(select * from SysTabla where SysTabla = 'ContactoDireccion')
INSERT INTO SysTabla (SysTabla) VALUES ('ContactoDireccion')
if exists (select * from sysobjects where id = object_id('dbo.ContactoDireccion') and type = 'U') 
DROP TABLE dbo.ContactoDireccion
CREATE TABLE dbo.ContactoDireccion (
     Estacion		int				NULL,
	 ID				int				NULL,
	 ContactoTipo	varchar(20)		NULL,
	 Contacto		varchar(10)		NULL,		
	 Direccion		varchar(255)	NULL	 
)
GO


/*************************** eCommerceDirDetalle **************************/
if not exists (select * from SysTabla where SysTabla = 'eCommerceDirDetalle') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eCommerceDirDetalle','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eCommerceDirDetalle') and type = 'U')
CREATE TABLE eCommerceDirDetalle
        (
          RowNum           int IDENTITY(1,1),
          Nombre           varchar(128) , 
          Path             varchar(128) , 
          Tipo             varchar(100),
          Estacion         int,
		
	CONSTRAINT prieCommerceDirDetalle PRIMARY KEY CLUSTERED (RowNum,Estacion)
	)
GO



/*************************** eCommerceDirDetalle2 **************************/
if not exists (select * from SysTabla where SysTabla = 'eCommerceDirDetalle2') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eCommerceDirDetalle2','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eCommerceDirDetalle2') and type = 'U')
CREATE TABLE eCommerceDirDetalle2
        (
          RowNum           int IDENTITY(1,1),
          Nombre           varchar(128) , 
          Path             varchar(128) , 
          Tipo             varchar(100),
          Estacion         int,
          Nivel            int,
		
	CONSTRAINT prieCommerceDirDetalle2 PRIMARY KEY CLUSTERED (RowNum,Estacion)
	)
GO

/****** ContactoDireccionHorizontal  ******/
if not exists(select * from SysTabla where SysTabla = 'ContactoDireccionHorizontal')
INSERT INTO SysTabla (SysTabla) VALUES ('ContactoDireccionHorizontal')
if exists (select * from sysobjects where id = object_id('dbo.ContactoDireccionHorizontal') and type = 'U') 
DROP TABLE dbo.ContactoDireccionHorizontal
CREATE TABLE dbo.ContactoDireccionHorizontal (
     Estacion		int				NULL,
     ContactoTipo	varchar(20)		NULL,
	 Contacto		varchar(10)		NULL,
	 Direccion1		varchar(255)	NULL,
	 Direccion2		varchar(255)	NULL,		
	 Direccion3		varchar(255)	NULL,
	 Direccion4		varchar(255)	NULL,		
	 Direccion5		varchar(255)	NULL,
	 Direccion6		varchar(255)	NULL,
	 Direccion7		varchar(255)	NULL,
	 Direccion8		varchar(255)	NULL																							 
)
GO

 --Directorio.Verificar( <Directorio> [, <crear si no existe> ] )  
/****** WebTextoXML ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebTextoXML')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebTextoXML', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebTextoXML') AND type = 'U') 
  CREATE TABLE dbo.WebTextoXML (
        ID              int  IDENTITY,
        Texto           text NULL
  )
GO

/****** WebArtDescripcion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtDescripcion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtDescripcion', 'N/A')
IF  NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtDescripcion') AND type = 'U')
  CREATE TABLE dbo.WebArtDescripcion (
        ID              int NOT NULL,
        DescripcionHTML text NULL,      

  CONSTRAINT priWebArtDescripcion PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** WebArtCamposConfigurablesCat ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesCat')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesCat', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesCat') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesCat (
        Tipo            varchar(50)  NOT NULL,
  CONSTRAINT priWebArtCamposConfigurablesCat PRIMARY KEY CLUSTERED (Tipo)
  )
GO

/****** WebVersion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebVersion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebVersion', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebVersion') AND type = 'U') 
  CREATE TABLE dbo.WebVersion (
        version                      int NOT NULL,
		DropBox                      varchar(255)   NULL,
        DirSFTP                      varchar(255)   NULL,
        WebArtDirectorio             varchar(255)   NULL,
        WebUsuario                   varchar(10)	NULL,
        WebArtDescripcion            varchar(MAX)	NULL,
		Ftpuser						 varchar(50)	NULL,
		Ftppassword					 varchar(50)	NULL,
		Ftphostr					 varchar(50)	NULL,
		Ftprutawinscp				 varchar(255)	NULL,
		FtpDirImg					 varchar(255)	NULL,
  CONSTRAINT priWebVersion PRIMARY KEY CLUSTERED (version)
  )
GO

EXEC spAlter_Table 'WebVersion','DirSFTP',	'varchar(255) NULL'
EXEC spAlter_Table 'WebVersion','Ftpuser',		'varchar(50) NULL'
EXEC spAlter_Table 'WebVersion','Ftppassword',	'varchar(50) NULL'
EXEC spAlter_Table 'WebVersion','Ftphostr',		'varchar(50) NULL'
EXEC spAlter_Table 'WebVersion','Ftprutawinscp','varchar(255) NULL'
EXEC spAlter_Table 'WebVersion','FtpDirImg',	'varchar(255) NULL'

/*IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'WebVersion' AND column_name = 'DropBox') AND NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'WebVersion' AND column_name = 'DirSFTP')
	EXEC sp_RENAME 'WebVersion.DropBox', 'DirSFTP', 'COLUMN'
GO*/


/****** WebSucursalImagen ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebSucursalImagen')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebSucursalImagen', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebSucursalImagen') AND type = 'U') 
  CREATE TABLE dbo.WebSucursalImagen (
        Sucursal        int          NOT NULL,
        ArchivoImagen   varchar(255) NULL,
        Orden           int          NULL,
        Nombre          varchar(50)  NOT NULL,
        Descripcion     text NULL,
        TipoArchivo     varchar(10)  NULL,
        Liga            varchar(255) NULL,
  CONSTRAINT priWebSucursalImagen PRIMARY KEY CLUSTERED (Sucursal,Nombre)
  )
GO
Exec spAlter_Table 'WebSucursalImagen','Liga','varchar(255) Null'

/****** WebArtCamposConfigurablesCatD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesCatD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesCatD', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesCatD') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesCatD (
        Tipo            varchar(50)  NOT NULL,
        Nombre          varchar(255) NOT NULL,
        TipoCampo       varchar(255) NULL,
  CONSTRAINT priWebArtCamposConfigurablesCatD PRIMARY KEY CLUSTERED (Tipo,Nombre)
  )
GO

/****** WebArtCamposConfigurablesCatDD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesCatDD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesCatDD', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesCatDD') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesCatDD (
        Tipo            varchar(50)  NOT NULL,
        Nombre          varchar(255) NOT NULL,
        Valor           varchar(255)   NOT NULL
  CONSTRAINT priWebArtCamposConfigurablesCatDD PRIMARY KEY CLUSTERED (Tipo,Nombre,Valor)
  )
GO

/****** WebArtAtributosCat  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtAtributosCat')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtAtributosCat', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtAtributosCat') AND type = 'U') 
  CREATE TABLE dbo.WebArtAtributosCat (
        Tipo            varchar(50)  NOT NULL,
  CONSTRAINT priWebArtAtributosCat PRIMARY KEY CLUSTERED (Tipo)
  )
GO

/****** WebArtAtributosCatD  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtAtributosCatD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtAtributosCatD', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtAtributosCatD') AND type = 'U') 
  CREATE TABLE dbo.WebArtAtributosCatD (
        Tipo            varchar(50)  NOT NULL,
        Nombre          varchar(255) NOT NULL,
        Valor           varchar(255) NOT NULL,
  CONSTRAINT priWebArtAtributosCatD PRIMARY KEY CLUSTERED (Tipo,Nombre,Valor)
  )
GO

/****** WebArtAtributosCatTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtAtributosCatTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtAtributosCatTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtAtributosCatTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtAtributosCatTemp (
        Estacion        int          NOT NULL,
        Tipo            varchar(50)  NOT NULL,
  CONSTRAINT priWebArtAtributosCatTemp PRIMARY KEY CLUSTERED (Estacion,Tipo)
  )
GO

/****** WebArtCamposConfigurablesCatTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesCatTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesCatTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesCatTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesCatTemp (
        Estacion        int          NOT NULL,
        Tipo            varchar(50)  NOT NULL,
  CONSTRAINT priWebArtCamposConfigurablesCatTemp PRIMARY KEY CLUSTERED (Estacion,Tipo)
  )
GO


/****** WebArtCamposConfigurablesCatDTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesCatDTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesCatDTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesCatDTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesCatDTemp (
        ID              int IDENTITY(1,1),
        Estacion        int          NOT NULL,
        Tipo            varchar(50)  NOT NULL,
        Nombre          varchar(255) NOT NULL,
        TipoCampo       varchar(255) NULL,
  CONSTRAINT priWebArtCamposConfigurablesCatDTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO


/****** WebArtAtributosCatDTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtAtributosCatDTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtAtributosCatDTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtAtributosCatDTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtAtributosCatDTemp (
        ID              int IDENTITY(1,1),
        Estacion        int          NOT NULL,
        Tipo            varchar(50)  NOT NULL,
        Nombre          varchar(255) NOT NULL,
        Valor           varchar(255) NOT NULL,
  CONSTRAINT priWebArtAtributosCatDTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO



/****** WebArt ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArt')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArt', 'N/A')
IF  NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArt') AND type = 'U')
  CREATE TABLE dbo.WebArt (
        ID              int IDENTITY,
        Orden           int          NULL,
        Nombre          varchar(255) NULL,
        EsDigital       bit  NOT NULL DEFAULT 0,
        Archivo         varchar(255) NULL,
        SKU             varchar(255) NULL,
        PalabrasBusqueda varchar(MAX)        NULL,
        Disponibilidad   varchar(255)NULL,
        Precio          decimal(20,4)NULL,
        Precio2         decimal(20,4)NULL,
        Precio3         decimal(20,4)NULL,
        Precio4         decimal(20,4)NULL,
        Precio5         decimal(20,4)NULL,
        Precio6         decimal(20,4)NULL,
        Precio7         decimal(20,4)NULL,
        Precio8         decimal(20,4)NULL,
        Precio9         decimal(20,4)NULL,
        Precio10        decimal(20,4)NULL,
        Costo           decimal(20,4)NULL,
        PrecioMenudeo   decimal(20,4)NULL,
        PrecioOferta    decimal(20,4)NULL,
        PrecioCImpuesto decimal(20,4)NULL,
        Visible         bit  NOT NULL DEFAULT 1,								
        Destacado       bit  NOT NULL DEFAULT 0,								
        DestacadoProv   bit  NOT NULL DEFAULT 0,
        ArtRelacionados varchar(255) NULL,	
        OpcionesReq     bit  NOT NULL DEFAULT 0, 
        Garantia        varchar(MAX) NULL,
        Peso            decimal(20,4)NULL, 							
        Ancho           decimal(20,4)NULL, 							
        Alto            decimal(20,4)NULL, 	
        Largo           decimal(20,4)NULL, 
        CostoEnvioFijo  decimal(20,4)NULL,  	
        EnvioGratis     bit  NOT NULL DEFAULT 0, 	
        FechaAlta       datetime NULL,
        MarcaID         int   NULL,
        TituloPagina    varchar(255) NULL,
        MetaKeyWords    varchar(MAX)  NULL,
        Metadesc        varchar(MAX)  NULL,
        Layout          varchar(50) NULL,--Omision product.html
        VariacionID     int   NULL,
        PermiteCompra   bit  NOT NULL DEFAULT 1, 
        OcultarPrecio   bit  NOT NULL DEFAULT 0, 
        TelefonoPrecios varchar(200) NULL,
        CategoriaIDS    varchar(MAX)     NULL,
        UltimoCambio    datetime NULL,
        FechaLanzamiento datetime NULL,
        UPC              varchar(32) NULL,
        DesHabilitarGoogle bit  NOT NULL DEFAULT 0,
        Articulo        varchar(20) NULL,
        SubCuenta       varchar(50) NULL,
        Categoria1      int         NULL,
        Unidad          varchar(50) NULL,
        SerieLote       varchar(20) NULL,
        Cantidad        float       NULL,
        DescripcionHTML varchar(max) NULL,
        OpcionesEnvoltura varchar(20) Null,      

  CONSTRAINT priWebArt PRIMARY KEY CLUSTERED (ID)
  )
GO


Exec spAlter_Table 'WebArt','Precio2','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio3','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio4','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio5','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio6','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio7','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio8','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio9','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','Precio10','decimal(20,4) Null'
Exec spAlter_Table 'WebArt','OpcionesEnvoltura','varchar(20) Null'




if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebArt' AND sysindexes.name = 'WebArtNombre' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE NONCLUSTERED INDEX  WebArtNombre ON dbo.WebArt (Nombre) ON [PRIMARY]
GO



/****** WebCatArt ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebCatArt')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebCatArt', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebCatArt') AND type = 'U') 
  CREATE TABLE dbo.WebCatArt (
        ID              int IDENTITY,
        Rama            int         NULL,
        Orden           int         NULL,
        Nombre          varchar(50) NULL,
        Descripcion     varchar(MAX)        NULL,
        Titulo          varchar(255)NULL,
        MetaKeyWords    varchar(MAX)        NULL,
        Metadesc        varchar(MAX)        NULL,
        LayOut          varchar(50) NULL,
        ArchivoImagen   varchar(255)NULL,
        Visible         bit  NOT NULL DEFAULT 0,
        PalabrasBusqueda varchar(255) NULL,
        HabilitarOptimizacion bit  NOT NULL DEFAULT 0,
        SetIzquierda    int        NULL,
        SetDerecha      int        NULL,
        Cache           varchar(MAX)       NULL,       

  CONSTRAINT priWebCatArt PRIMARY KEY CLUSTERED (ID)
  )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebCatArt' AND sysindexes.name = 'WebCatArtNombre' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE NONCLUSTERED INDEX  WebCatArtNombre  ON dbo.WebCatArt (Nombre) ON [PRIMARY]
GO


/****** WebCatArtTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebCatArtTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebCatArtTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebCatArtTemp') AND type = 'U') 
  CREATE TABLE dbo.WebCatArtTemp (
        Estacion        int         NOT NULL,
        ID              int         NOT NULL,
        IDArt           int         NOT NULL,
        Nombre          varchar(50) NULL,

  CONSTRAINT priWebCatArtTemp PRIMARY KEY CLUSTERED (Estacion,ID,IDArt)
  )
GO
/****** WebCatArt_Art ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebCatArt_Art')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebCatArt_Art', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebCatArt_Art') AND type = 'U') 
  CREATE TABLE dbo.WebCatArt_Art (
        ID              int IDENTITY,
        IDWebArt        int     NOT  NULL,
        IDWebCatArt     int     NOT  NULL,
        Nombre          varchar(50) NULL,
  CONSTRAINT priWebCatArt_Art PRIMARY KEY CLUSTERED (IDWebArt,IDWebCatArt)
  )
GO
Exec spAlter_Table 'WebCatArt_Art','Orden','int Null'

/****** WebArtImagen  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtImagen')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtImagen', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtImagen') AND type = 'U') 
  CREATE TABLE dbo.WebArtImagen (
        ID              int IDENTITY,
        IDArt           int NOT NULL,
        Orden           int NULL,
        ArchivoImagen   varchar(255)NULL,
        Nombre          varchar(50)NULL,
        Descripcion     varchar(MAX) NULL,
        FechaAlta       datetime NULL,
        TipoArchivo     varchar(10) NULL,
      

  CONSTRAINT priWebArtImagen PRIMARY KEY CLUSTERED (ID)
  )
GO

Exec spAlter_Table 'WebArtImagen','TipoArchivo','varchar(100) Null'

/****** WebArtImagenTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtImagenTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtImagenTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtImagenTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtImagenTemp (
        Estacion        int NOT NULL,
        IDArt           int NOT NULL,
        Archivo         varchar(255)NULL      

  CONSTRAINT priWebArtImagenTemp PRIMARY KEY CLUSTERED (Estacion,IDArt)
  )
GO

/****** WebSucursalImagenTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebSucursalImagenTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebSucursalImagenTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebSucursalImagenTemp') AND type = 'U') 
  CREATE TABLE dbo.WebSucursalImagenTemp (
        Estacion        int NOT NULL,
        Sucursal        int NOT NULL,
        Archivo         varchar(255)NULL      

  CONSTRAINT priWebSucursalImagenTemp PRIMARY KEY CLUSTERED (Estacion,Sucursal)
  )
GO
/****** WebArtCombinacionImagenTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCombinacionImagenTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCombinacionImagenTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCombinacionImagenTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtCombinacionImagenTemp (
        Estacion        int NOT NULL,
        IDCombinacion   int NOT NULL,
        IDVariacion     int NOT NULL,        
        IDArt           int NOT NULL,
        Archivo         varchar(255)NULL      

  CONSTRAINT priWebArtCombinacionImagenTemp PRIMARY KEY CLUSTERED (Estacion, IDCombinacion,IDArt, IDVariacion)
  )
GO

/****** WebArtMarca ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtMarca')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtMarca', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtMarca') AND type = 'U') 
  CREATE TABLE dbo.WebArtMarca (
        ID              int IDENTITY,
        Nombre          varchar(255)  NULL,
        Titulo          varchar(255)  NULL,
        Archivo         varchar(255)  NULL,
        Orden           int NULL,
        MetaKeyWords    varchar(MAX)        NULL,
        Metadesc        varchar(MAX)        NULL,
        PalbrasBusquedea varchar(MAX)        NULL,

      

  CONSTRAINT priWebArtMarca PRIMARY KEY CLUSTERED (ID)
  )
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebArtMarca' AND sysindexes.name = 'WebArtMarcaNombre' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE NONCLUSTERED INDEX  WebArtMarcaNombre  ON dbo.WebArtMarca (Nombre) ON [PRIMARY]
GO


/****** WebArtVideo  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtVideo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtVideo', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtVideo') AND type = 'U') 
  CREATE TABLE dbo.WebArtVideo (
        Ubicacion       varchar(255)NOT NULL,
        ID              varchar(36) NOT NULL,
        IDArt           int NOT NULL,
        Orden           int NULL,
        Titulo          varchar(255) NULL,
        Descripcion     varchar(MAX) NULL,
        Duracion        varchar(10) NULL,         
      

  CONSTRAINT priWebArtVideo PRIMARY KEY CLUSTERED (ID,IDArt)
  )
GO

/****** WebCertificadosRegalo  ******/
if not exists(select * from SysTabla where SysTabla = 'WebCertificadosRegalo')
INSERT INTO SysTabla (SysTabla) VALUES ('WebCertificadosRegalo')
if not exists (select * from sysobjects where id = object_id('dbo.WebCertificadosRegalo') and type = 'U') 
CREATE TABLE dbo.WebCertificadosRegalo (
	IDCertificado int NOT NULL IDENTITY(1,1),
	Sucursal int NOT NULL,
	Monto float NOT NULL,
	Articulo varchar(20) NULL,
	SubCuenta varchar(50) NULL,
	
	CONSTRAINT priWebCertificadosRegalo PRIMARY KEY CLUSTERED (IDCertificado)
)
GO

/****** WebArtVariacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtVariacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtVariacion', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtVariacion') AND type = 'U') 
  CREATE TABLE dbo.WebArtVariacion (
        ID              int IDENTITY,
        Orden           int    NULL,
        Nombre          varchar(100) NULL,
        NumeroOpciones  int          NULL,	
        ProveedorID     int          NULL,
        GUID            varchar(50) NULL,
        TieneWebArt	AS dbo.fnWebArtVariacionTieneWebArt(ID)
  CONSTRAINT priWebArtVariacion PRIMARY KEY CLUSTERED (ID)
  )
GO

Exec spAlter_Table 'WebArtVariacion','GUID','varchar(50) Null'
Exec spAlter_Table 'WebArtVariacion','TieneWebArt','AS dbo.fnWebArtVariacionTieneWebArt(ID)'

/****** WebArtOpcion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtOpcion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtOpcion', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtOpcion') AND type = 'U') 
  CREATE TABLE dbo.WebArtOpcion (
        ID              int IDENTITY,
        VariacionID     int    NOT NULL,
        Orden           int    NULL,
        Nombre          varchar(100) NULL,
        OpcionIntelisis varchar(1) NULL,
        GUID            varchar(50) NULL,
        

  CONSTRAINT priWebArtOpcion PRIMARY KEY CLUSTERED (ID)
  )
GO


Exec spAlter_Table 'WebArtOpcion','GUID','varchar(50) Null'


/****** WebArtOpcionValor ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtOpcionValor')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtOpcionValor', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtOpcionValor') AND type = 'U') 
  CREATE TABLE dbo.WebArtOpcionValor (
        ID              int IDENTITY,
        VariacionID     int    NOT NULL,
        OpcionID        int    NOT NULL,
        Orden           int    NULL,
        NumeroIntelisis int    NULL,
        Valor           varchar(100) NOT NULL
     
  CONSTRAINT priWebArtOpcionValor PRIMARY KEY CLUSTERED (VariacionID,OpcionID,Valor)
  )
GO


/****** WebArtVariacionCombinacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtVariacionCombinacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtVariacionCombinacion', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtVariacionCombinacion') AND type = 'U') 
  CREATE TABLE dbo.WebArtVariacionCombinacion (
        ID              int IDENTITY,
        Orden           int    NULL,
        IDArt           int    NULL,
        IDVariacion     int    NULL,
        Activa          bit  NOT NULL DEFAULT 1, 
        IDOpciones      varchar(255) NULL,
        Opciones        varchar(500) NULL,
        SKU             varchar(50)  NULL,
        Imagen          varchar(255) NULL,
        UltimoCambio    datetime     NULL,
        OperacionPrecio varchar(50)  NULL,--(Sumar, Restar o Fijar),
        OperacionPeso   varchar(50)  NULL,--(Sumar, Restar o Fijar),
        Precio          decimal(20,4)NULL,
        Precio2         decimal(20,4)NULL,
        Precio3         decimal(20,4)NULL,
        Precio4         decimal(20,4)NULL,
        Precio5         decimal(20,4)NULL,
        Precio6         decimal(20,4)NULL,
        Precio7         decimal(20,4)NULL,
        Precio8         decimal(20,4)NULL,
        Precio9         decimal(20,4)NULL,
        Precio10        decimal(20,4)NULL,        
        Peso            decimal(20,4)NULL,
        SubCuenta       varchar(50)  NULL,
        Unidad          varchar(50)  NULL,
        Articulo        varchar(20)  NULL,
        Cantidad        float        NULL,   
        TipoArchivo     varchar(100) NULL,
        NombreImagen    varchar(100) NULL,
        
        
        
  CONSTRAINT priWebArtVariacionCombinacion PRIMARY KEY CLUSTERED (ID)
  )
GO
Exec spAlter_Table 'WebArtVariacionCombinacion','TipoArchivo','varchar(100) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','NombreImagen','varchar(100) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio2','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio3','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio4','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio5','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio6','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio7','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio8','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio9','decimal(20,4) Null'
Exec spAlter_Table 'WebArtVariacionCombinacion','Precio10','decimal(20,4) Null'



/****** WebArtVariacionCombinacionD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtVariacionCombinacionD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtVariacionCombinacionD', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtVariacionCombinacionD') AND type = 'U') 
  CREATE TABLE dbo.WebArtVariacionCombinacionD (
        ID              int    NOT NULL,
        IDArt           int    NOT NULL,
        IDVariacion     int    NOT NULL,
        IDOpcion        int    NOT NULL,
        IDValor         int    NOT NULL,


        
  CONSTRAINT priWebArtVariacionCombinacionD PRIMARY KEY CLUSTERED (ID,IDArt,IDVariacion,IDOpcion,IDValor)
  )
GO

/****** WebArtAtributos  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtAtributos')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtAtributos', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtAtributos') AND type = 'U') 
  CREATE TABLE dbo.WebArtAtributos (
        ID              int IDENTITY,
        IDArt           int NOT NULL,
        Nombre          varchar(255) NULL,
        Valor           varchar(255) NULL,
  CONSTRAINT priWebArtAtributos PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** WebArtCamposConfigurables ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurables')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurables', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurables') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurables (
        ID              int IDENTITY,
        IDArt           int NOT NULL,
        Nombre          varchar(255) NULL,
        TipoCampo       varchar(255) NULL,
        Requerido       bit  NOT NULL DEFAULT 0,
        Orden           int  NULL,
        OpcionIntelisis varchar(50) NULL,
  CONSTRAINT priWebArtCamposConfigurables PRIMARY KEY CLUSTERED (ID)
  )
GO

Exec spAlter_Table 'WebArtCamposConfigurables','OpcionIntelisis',' varchar(50) NULL'




/****** WebArtCamposConfigurablesD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtCamposConfigurablesD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtCamposConfigurablesD', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtCamposConfigurablesD') AND type = 'U') 
  CREATE TABLE dbo.WebArtCamposConfigurablesD (
        ID            int NOT NULL,
        Valor         varchar(255) NOT NULL,
        Orden         int NULL,
        OpcionIntelisis varchar(50) NULL,

  CONSTRAINT priWebArtCamposConfigurablesD PRIMARY KEY CLUSTERED (ID,Valor)
  )
GO

Exec spAlter_Table 'WebArtCamposConfigurablesD','Orden','int Null'
Exec spAlter_Table 'WebArtCamposConfigurablesD','OpcionIntelisis','varchar(50) NULL'

GO
/****** WebSituacionEstatus  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebSituacionEstatus')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebSituacionEstatus', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebSituacionEstatus') AND type = 'U') 
  CREATE TABLE dbo.WebSituacionEstatus (
        Modulo          varchar(5)  NOT NULL,
        Mov             varchar(20) NOT NULL,
        Estatus         varchar(15) NOT NULL,
        Situacion       varchar(50) NOT NULL,
        SituacionEcomerce      int NULL,
  CONSTRAINT priWebSituacionEstatus PRIMARY KEY CLUSTERED (Modulo,Mov,Estatus,Situacion)
  )
GO


Exec spDROP_COLUMN 'WebSituacionEstatus', 'EnviarCorreo'



/****** WebSituacion  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebSituacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebSituacion', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebSituacion') AND type = 'U') 
  CREATE TABLE dbo.WebSituacion (
        ID              int IDENTITY(1,1),
        Nombre          varchar(50) NOT NULL,
        EnviarCorreo    bit        NULL,
        EsCompleto		bit			NULL,
  CONSTRAINT priWebSituacion PRIMARY KEY CLUSTERED (ID)
  )
GO
Exec spAlter_Table 'WebSituacion', 'EnviarCorreo',' bit NULL DEFAULT 0'
Exec spAlter_Table 'WebSituacion', 'EsCompleto',' bit NULL DEFAULT 0'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebSituacionAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebSituacionAC
GO
CREATE TRIGGER tgWebSituacionAC ON WebSituacion
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
DECLARE @NombreN varchar(255)

DECLARE crNombre CURSOR local FOR
SELECT Nombre FROM INSERTED
  
OPEN crNombre
FETCH NEXT FROM crNombre INTO @NombreN
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(ISNULL(@NombreN, '') = '')
	BEGIN
		RAISERROR('El campo Nombre no puede estar vacio', 16, -1)
	END
FETCH NEXT FROM crNombre INTO @NombreN
END
CLOSE crNombre
DEALLOCATE crNombre
END
GO

/****** WebUsuarios ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebUsuarios')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebUsuarios', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebUsuarios') AND type = 'U') 
  CREATE TABLE dbo.WebUsuarios (
        ID              int IDENTITY,
        Salt            varchar(16)  NULL,
        Contrasena      varchar(50)  NULL,
        ContrasenaConfirmacion  varchar(50)  NULL,
        Nombre          varchar(100) NULL,
        Apellido        varchar(100) NULL,
        eMail           varchar(250) NULL,
        eMail2          varchar(250) NULL,
        Telefono        varchar(50)  NULL,
        FechaAlta       datetime     NULL,
        UltimoCambio    datetime     NULL,
        Empresa         varchar(5)   NULL,
        Sucursal        int          NULL,
        Cliente         varchar(10)  NULL,
        GUID            varchar(50)  NOT NULL DEFAULT NEWID()    
  CONSTRAINT priWebUsuarios PRIMARY KEY CLUSTERED (ID)
  )
GO

Exec spAlter_Table 'WebUsuarios','GUID','varchar(50) NOT NULL DEFAULT NEWID() WITH VALUES'

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebUsuarios' AND sysindexes.name = 'WebUsuarioeMail' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE NONCLUSTERED INDEX  WebUsuarioeMail ON dbo.WebUsuarios (eMail) ON [PRIMARY]
GO


/****** WebUsuarioTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebUsuarioTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebUsuarioTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebUsuarioTemp') AND type = 'U') 
  CREATE TABLE dbo.WebUsuarioTemp (
        Estacion        int          NOT NULL,
        Salt            varchar(16)  NULL,
        Contrasena      varchar(50)  NULL,
        ContrasenaConfirmacion  varchar(50)  NULL,
        Nombre          varchar(100) NULL,
        Apellido        varchar(100) NULL,
        eMail           varchar(250) NULL,
        eMail2          varchar(250) NULL,
        Telefono        varchar(50)  NULL,
        FechaAlta       datetime     NULL,
        UltimoCambio    datetime     NULL,
        Empresa         varchar(5)   NULL,
        Sucursal        int          NULL,
        Cliente         varchar(10)  NOT NULL,    
  CONSTRAINT priWebUsuarioTemp PRIMARY KEY CLUSTERED (Estacion,Cliente)
  )
GO


/****** WebPais ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebPais')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebPais', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebPais') AND type = 'U') 
  CREATE TABLE dbo.WebPais (
        ID              int IDENTITY,
        Nombre          varchar(255) NOT NULL,
        Clave2          varchar(2)   NULL,   
        Clave3          varchar(3)   NULL,
        Region          int          NULL,   
  CONSTRAINT priWebPais PRIMARY KEY CLUSTERED (ID)
  )
GO

Exec spAlter_Table 'WebPais','Region','int Null'

--if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebPais' AND sysindexes.name = 'WebPaisNombre' AND sysobjects.id = sysindexes.id)
--  CREATE UNIQUE NONCLUSTERED INDEX  WebPaisNombre ON dbo.WebPais (Nombre) ON [PRIMARY]
--GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebPaisAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebPaisAC
GO
CREATE TRIGGER tgWebPaisAC ON WebPais
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
DECLARE @NombreN varchar(255)

DECLARE crNombre CURSOR local FOR
SELECT Nombre FROM INSERTED
  
OPEN crNombre
FETCH NEXT FROM crNombre INTO @NombreN
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(ISNULL(@NombreN, '') = '')
	BEGIN
		RAISERROR('El campo Nombre no puede estar vacio', 16, -1)
	END
FETCH NEXT FROM crNombre INTO @NombreN
END
CLOSE crNombre
DEALLOCATE crNombre
END
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebPais' AND sysindexes.name = 'WebPaisNombre' AND sysobjects.id = sysindexes.id)
  DROP INDEX WebPaisNombre ON dbo.WebPais
GO

/****** WebPaisEstado ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebPaisEstado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebPaisEstado', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebPaisEstado') AND type = 'U') 
  CREATE TABLE dbo.WebPaisEstado (
        ID              int IDENTITY,
        IDPais          int NOT NULL,
        Nombre          varchar(255) NULL,
        Clave           varchar(5)   NULL,   

  CONSTRAINT priWebPaisEstado PRIMARY KEY CLUSTERED (ID,IDPais)
  )
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebPaisEstadoAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebPaisEstadoAC
GO
CREATE TRIGGER tgWebPaisEstadoAC ON WebPaisEstado
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
DECLARE @NombreN varchar(255)

DECLARE crNombre CURSOR local FOR
SELECT Nombre FROM INSERTED
  
OPEN crNombre
FETCH NEXT FROM crNombre INTO @NombreN
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(ISNULL(@NombreN, '') = '')
	BEGIN
		RAISERROR('El campo Nombre no puede estar vacio', 16, -1)
	END
FETCH NEXT FROM crNombre INTO @NombreN
END
CLOSE crNombre
DEALLOCATE crNombre
END
GO

--if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebPaisEstado' AND sysindexes.name = 'WebPaisEstadoNombre' AND sysobjects.id = sysindexes.id)
--  CREATE UNIQUE NONCLUSTERED INDEX  WebPaisEstadoNombre ON dbo.WebPaisEstado (IDPais,Nombre) ON [PRIMARY]
--GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebPaisEstado' AND sysindexes.name = 'WebPaisEstadoNombre' AND sysobjects.id = sysindexes.id)
  DROP INDEX  WebPaisEstadoNombre ON dbo.WebPaisEstado
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebPaisEstadoAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebPaisEstadoAC
GO
CREATE TRIGGER tgWebPaisEstadoAC ON WebPaisEstado
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
DECLARE @NombreN varchar(255)

DECLARE crNombre CURSOR local FOR
SELECT Nombre FROM INSERTED
  
OPEN crNombre
FETCH NEXT FROM crNombre INTO @NombreN
WHILE @@FETCH_STATUS = 0
BEGIN
	IF(ISNULL(@NombreN, '') = '')
	BEGIN
		RAISERROR('El campo Nombre no puede estar vacio', 16, -1)
	END
FETCH NEXT FROM crNombre INTO @NombreN
END
CLOSE crNombre
DEALLOCATE crNombre
END
GO

/****** WebFormaPago ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebFormaPago')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebFormaPago', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebFormaPago') AND type = 'U') 
  CREATE TABLE dbo.WebFormaPago (
        Sucursal        int         NOT NULL,
        FormaPagoWeb    varchar(50) NOT NULL,
        FormaPago       varchar(50) NOT NULL,
        CtaDinero       varchar(10) NULL,  

  CONSTRAINT priWebFormaPago PRIMARY KEY CLUSTERED (Sucursal,FormaPagoWeb,FormaPago)
  )
GO


/****** WebFormaPagoOmision ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebFormaPagoOmision')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebFormaPagoOmision', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebFormaPagoOmision') AND type = 'U') 
  CREATE TABLE dbo.WebFormaPagoOmision (
        IDForma         varchar(50) NOT NULL,
        Nombre          varchar(50) NOT NULL,
        Prepagado       bit  NOT NULL DEFAULT 0,  
  CONSTRAINT priWebFormaPagoOmision PRIMARY KEY CLUSTERED (IDForma)
  )
GO


/****** eCommerceSaldoU ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'eCommerceSaldoU')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('eCommerceSaldoU', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.eCommerceSaldoU') AND type = 'U') 
  CREATE TABLE dbo.eCommerceSaldoU (
        Articulo        varchar(20) NOT NULL,
        SubCuenta       varchar(50) NOT NULL,
  CONSTRAINT prieCommerceSaldoU PRIMARY KEY CLUSTERED (Articulo,SubCuenta)
  )
GO

/****** eCommerceTrabajo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'eCommerceTrabajo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('eCommerceTrabajo', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.eCommerceTrabajo') AND type = 'U') 
  CREATE TABLE dbo.eCommerceTrabajo (
        Trabajo         varchar(255) NOT NULL,
        Frecuencia      varchar(50)  NULL,
        Valor           int          NULL,
        Activo          bit          NOT NULL DEFAULT 0,
  CONSTRAINT prieCommerceTrabajo PRIMARY KEY CLUSTERED (Trabajo)
  )
GO
Exec spAlter_Table 'eCommerceTrabajo','Tipo','varchar(20) Null'
GO
UPDATE eCommerceTrabajo SET Tipo = ISNULL(Tipo,'Archivos')
GO

/****** eCommerceExistenciaSucursal ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'eCommerceExistenciaSucursal')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('eCommerceExistenciaSucursal', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.eCommerceExistenciaSucursal') AND type = 'U') 
  CREATE TABLE dbo.eCommerceExistenciaSucursal (
        ID              int IDENTITY,
        Articulo        varchar(20) NOT NULL,
        SubCuenta       varchar(50) NULL,
        Inventario	float       NULL,
        SKU	        varchar(255)NULL,
        Situacion	varchar(50) NULL,
        Sucursal	int         NULL,
  CONSTRAINT prieeCommerceExistenciaSucursal PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** WebArtTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebArtTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebArtTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebArtTemp') AND type = 'U') 
  CREATE TABLE dbo.WebArtTemp (
        Estacion        int          NOT NULL,
        Articulo        varchar(20)  NOT NULL,
        Nombre          varchar(255) NULL,
        MarcaID         int          NULL,
        Unidad          varchar(50)  NULL,
        Cantidad        float        NULL,
        DescripcionHTML varchar(8000) NULL, 
        PermiteCompra   bit          NOT NULL DEFAULT 0, 
        OcultarPrecio   bit          NOT NULL DEFAULT 1, 
        Visible         bit          NOT NULL DEFAULT 1,  
        Categoria1      varchar(50)  NULL, 
        Categoria2      varchar(50)  NULL, 
        Categoria3      varchar(50)  NULL, 
        Categoria4      varchar(50)  NULL, 
   
  CONSTRAINT priWebArtTemp PRIMARY KEY CLUSTERED (Estacion,Articulo)
  )
GO

/*************************** eCommerceMetodoEnvioCfg **************************/
if not exists (select * from SysTabla where SysTabla = 'eCommerceMetodoEnvioCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eCommerceMetodoEnvioCfg','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eCommerceMetodoEnvioCfg') and type = 'U')
CREATE TABLE eCommerceMetodoEnvioCfg
        ( SucursaleCommerce             varchar(10) NOT NULL,--Info.Clave  
          MetodoEnvio                   varchar(50) NOT NULL,--Info.Motivo   
          Nombre                        varchar(100)NOT NULL,--Info.Nombre2  
          Precio1                       float       NULL,	
          Precio2                       float       NULL,	
          Precio3                       float       NULL,	
          Precio4                       float       NULL,	
          Precio5                       float       NULL,	
          Estatus                       varchar(10) NULL,	
	CONSTRAINT prieCommerceMetodoEnvioCfg PRIMARY KEY CLUSTERED (SucursaleCommerce,MetodoEnvio, Nombre)
	)
GO


/*************************** eCommerceMetodoEnvioCfgD **************************/
if not exists (select * from SysTabla where SysTabla = 'eCommerceMetodoEnvioCfgD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eCommerceMetodoEnvioCfgD','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eCommerceMetodoEnvioCfgD') and type = 'U')
CREATE TABLE eCommerceMetodoEnvioCfgD
        ( SucursaleCommerce             varchar(10) NOT NULL,
          MetodoEnvio                   varchar(50) NOT NULL,
          Nombre                        varchar(100)NOT NULL,
          NumeroD                       float       NOT NULL,
          NumeroA                       float       NOT NULL,                   
          Precio                        float       NULL,
	CONSTRAINT prieCommerceMetodoEnvioCfgD PRIMARY KEY CLUSTERED (SucursaleCommerce,MetodoEnvio,Nombre,NumeroD,NumeroA)
	)
GO
/*************************** VentaDWeb **************************/
if not exists (select * from SysTabla where SysTabla = 'VentaDWeb') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VentaDWeb','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaDWeb') and type = 'U')
CREATE TABLE VentaDWeb
        (
		  ID			int NOT NULL,
		  Renglon		float NOT NULL,
		  RenglonSub	int NOT NULL,
		  RID			int IDENTITY(1,1),
		  
		  Campo			varchar(255),
		  Valor			varchar(max),
		
	CONSTRAINT priWebVentaD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub, RID)
	)
GO
/****** eCommerceRegenerar  ******/
if not exists(select * from SysTabla where SysTabla = 'eCommerceRegenerar')
INSERT INTO SysTabla (SysTabla) VALUES ('eCommerceRegenerar')
if exists (select * from sysobjects where id = object_id('dbo.eCommerceRegenerar') and type = 'U') 
DROP TABLE dbo.eCommerceRegenerar
CREATE TABLE dbo.eCommerceRegenerar (
     Regenerando	bit				NULL
)
GO
/*************************** WebEstatusExistencia **************************/
if not exists (select * from SysTabla where SysTabla = 'WebEstatusExistencia') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebEstatusExistencia','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.WebEstatusExistencia') and type = 'U')
CREATE TABLE WebEstatusExistencia (
	WebEstatusExistencia	varchar(20) NOT NULL,
	Sucursal				int NOT NULL,
	Descripcion				varchar(100) NULL,
	EntregaDias				int NULL,
	VentaPermitir			bit NULL DEFAULT 1,
	PeriodoEntrega			varchar(20) NULL DEFAULT 'Lun-Dom',
CONSTRAINT priWebEstatusExistencia PRIMARY KEY CLUSTERED (WebEstatusExistencia,Sucursal)
)
GO
EXEC spALTER_TABLE 'WebEstatusExistencia', 'PeriodoEntrega', 'varchar(20) NULL DEFAULT ''Lun-Dom'''
EXEC spALTER_TABLE 'WebEstatusExistencia', 'EntregaDias', 'int NULL'

/*************************** WebArtEstatusExistencia **************************/
if not exists (select * from SysTabla where SysTabla = 'WebArtEstatusExistencia') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebArtEstatusExistencia','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.WebArtEstatusExistencia') and type = 'U')
CREATE TABLE WebArtEstatusExistencia (
	SKU						varchar(255) NOT NULL,
	Sucursal				int NOT NULL,
	ExistenciaMenorOIgual	float NOT NULL,
	WebEstatusExistencia	varchar(20) NOT NULL,
CONSTRAINT priWebArtEstatusExistencia PRIMARY KEY CLUSTERED (SKU,Sucursal,ExistenciaMenorOIgual)
)
GO
/****** eCommercePedido  ******/
if not exists (select * from SysTabla where SysTabla = 'eCommercePedido') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eCommercePedido','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eCommercePedido') and type = 'U')
CREATE TABLE eCommercePedido








        (
          IDVenta int NOT NULL,
          Sucursal int NOT NULL,
          IDPedido int NOT NULL







		
	CONSTRAINT prieCommercePedido PRIMARY KEY CLUSTERED (IDVenta, Sucursal, IDPedido)
	)
GO


/****** WebEnvolturaRegalo  ******/
if not exists(select * from SysTabla where SysTabla = 'WebEnvolturaRegalo')
INSERT INTO SysTabla (SysTabla) VALUES ('WebEnvolturaRegalo')
if not exists (select * from sysobjects where id = object_id('dbo.WebEnvolturaRegalo') and type = 'U') 
CREATE TABLE dbo.WebEnvolturaRegalo (
	ID int IDENTITY(1,1),
	SucursaleCommerce varchar(10) NOT NULL,
	Nombre	varchar(100) NOT NULL,
	Precio float NOT NULL,
	Visible bit NOT NULL DEFAULT 1,
	PermiteMensaje bit NOT NULL DEFAULT 0,
	Imagen varchar(255) NULL,
	Articulo varchar(20) NULL,
	SubCuenta varchar(50) NULL
	
	CONSTRAINT priWebEnvolturaRegalo PRIMARY KEY CLUSTERED (ID)
)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'WebEnvolturaRegalo' AND sysindexes.name = 'WebEnvolturaRegaloNombre' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE NONCLUSTERED INDEX WebEnvolturaRegaloNombre ON dbo.WebEnvolturaRegalo (Nombre) ON [PRIMARY]
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebEnvolturaRegaloABC') AND sysstat & 0xf = 8) drop trigger dbo.tgWebEnvolturaRegaloABC
GO
CREATE TRIGGER tgWebEnvolturaRegaloABC ON WebEnvolturaRegalo
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
DECLARE
	@ID int,
	@SucursaleCommerce varchar(10),
	@Imagen		varchar(255),
		@DropBox              varchar(50),
	@Ruta                 varchar(255),
	--@CarpetaImagenes      varchar(50),
	@WebArtDirectorio		varchar(255),
	@Archivo              varchar(255),
	@ArchivoDestino       varchar(255),
	@Ok                   int,
	@OkRef                varchar(255)

DECLARE crActualizar CURSOR local FOR
SELECT ID, SucursaleCommerce, Imagen FROM INSERTED

SELECT @DropBox = DirSFTP, @WebArtDirectorio = WebArtDirectorio FROM WebVersion
  
OPEN crActualizar
FETCH NEXT FROM crActualizar INTO @ID, @SucursaleCommerce, @Imagen
WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @Archivo = @WebArtDirectorio+'\Envoltura\'+@Imagen
  
	SELECT @Ruta = @DropBox + '\' + @SucursaleCommerce+'\Imagenes'--+@CarpetaImagenes
	 
	IF @Ruta IS NOT NULL
	BEGIN
	EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
	SELECT @Ruta =@Ruta+'\Envoltura\'
	IF @OK IS NULL
	  EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
	IF @Ok IS NULL
	BEGIN
	  SELECT @ArchivoDestino = @Ruta+@Imagen
	  EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
	END   
	END
	
	FETCH NEXT FROM crActualizar INTO @ID, @SucursaleCommerce, @Imagen
END
CLOSE crActualizar
DEALLOCATE crActualizar
  
END
GO
/****** WebEnvolturaImagenTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'WebEnvolturaImagenTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebEnvolturaImagenTemp', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.WebEnvolturaImagenTemp') AND type = 'U') 
  CREATE TABLE dbo.WebEnvolturaImagenTemp (
        Estacion        int NOT NULL,
        IDEnvoltura          int NOT NULL,
        Archivo         varchar(255)NULL      

  CONSTRAINT priWebEnvolturaImagenTemp PRIMARY KEY CLUSTERED (Estacion,IDEnvoltura)
  )
GO

/****** WebArtEnvoltura  ******/
if not exists(select * from SysTabla where SysTabla = 'WebArtEnvoltura')
INSERT INTO SysTabla (SysTabla) VALUES ('WebArtEnvoltura')
if not exists (select * from sysobjects where id = object_id('dbo.WebArtEnvoltura') and type = 'U') 
CREATE TABLE dbo.WebArtEnvoltura (
	IDArt int NOT NULL,
	IDEnvoltura int NOT NULL
	
	CONSTRAINT priWebArtEnvoltura PRIMARY KEY CLUSTERED (IDArt, IDEnvoltura)
)
GO
IF NOT EXISTS(SELECT * FROM sysindexes where name = 'tnMovFlujo')
CREATE INDEX tnMovFlujo ON MovFlujo(DModulo,DID)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebArtImagenAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebArtImagenAC
GO
CREATE TRIGGER tgWebArtImagenAC ON WebArtImagen
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
  DECLARE
  @ID                   int,
  @IDArt                int,
  --@CarpetaImagenes      varchar(50),
  @DropBox              varchar(50),
  @Sucursal             int, 
  @eCommerceSucursal    varchar(10),
  @Ruta                 varchar(255),
  @Archivo              varchar(255),
  @Ok                   int,
  @OkRef                varchar(255),
  @Imagen               varchar(255),
  @ArchivoDestino       varchar(255),
  @eCommerceOffLine     bit
  
  DECLARE crImagen CURSOR local FOR
  --SELECT @ID = ID , @IDArt = IDArt, @Archivo = ArchivoImagen FROM INSERTED
  SELECT ID , IDArt, ArchivoImagen FROM INSERTED
  
OPEN crImagen
FETCH NEXT FROM crImagen INTO @ID, @IDArt, @Archivo
WHILE @@FETCH_STATUS = 0
BEGIN
  
  SELECT @Imagen = dbo.fnWebNombreImagen(@Archivo)
  
  SELECT @DropBox = DirSFTP FROM WebVersion
  
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL)
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal, /*eCommerceImagenes, */ISNULL(eCommerceOffLine,0)
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal,/*@CarpetaImagenes,*/ @eCommerceOffLine
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      --IF @CarpetaImagenes IS NOT NULL
      SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\Imagenes'--+@CarpetaImagenes
      
      IF @eCommerceOffLine = 1
      BEGIN
        SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
        IF @Ok IS NULL
        SELECT @Ruta =@Ruta+'\Imagenes'--+@CarpetaImagenes
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
      END  
      
     
      /*IF @CarpetaImagenes IS NOT NULL AND @OK IS NULL
      BEGIN*/
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
        
            
      
        SELECT @Ruta =@Ruta+'\'+CONVERT(varchar,@IDArt)+'\'
        IF @OK IS NULL
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
        
        IF @Ok IS NULL
        BEGIN
          SELECT @ArchivoDestino = @Ruta+@Imagen
    
          EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
        END   
      --END        

      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal,/*@CarpetaImagenes, */@eCommerceOffLine
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END   
  
	FETCH NEXT FROM crImagen INTO @ID, @IDArt, @Archivo
END
CLOSE crImagen
DEALLOCATE crImagen 
  
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebSucursalImagenAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebSucursalImagenAC
GO
CREATE TRIGGER tgWebSucursalImagenAC ON WebSucursalImagen
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
  DECLARE
  @Sucursal             int,
  --@CarpetaImagenes      varchar(50),
  @DropBox              varchar(50),
  @eCommerceSucursal    varchar(10),
  @Ruta                 varchar(255),
  @Archivo              varchar(255),
  @Ok                   int,
  @OkRef                varchar(255),
  @Imagen               varchar(255),
  @ArchivoDestino       varchar(255),
  @eCommerceOffLine     bit

  SELECT @Sucursal = Sucursal ,  @Archivo = ArchivoImagen FROM INSERTED
  
  SELECT @Imagen = dbo.fnWebNombreImagen(@Archivo)
  
  SELECT @DropBox = DirSFTP FROM WebVersion
  
  SELECT @eCommerceSucursal = eCommerceSucursal, /*@CarpetaImagenes= eCommerceImagenes, */@eCommerceOffLine = ISNULL(eCommerceOffLine,0)
    FROM Sucursal
   WHERE Sucursal = @Sucursal 
  
  SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\Imagenes'--+@CarpetaImagenes
  
  IF @eCommerceOffLine = 1
  BEGIN
    SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\OffLine'
    EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
    IF @Ok IS NULL
    SELECT @Ruta =@Ruta+'\Imagenes'--+@CarpetaImagenes
    EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
  END
     
  /*IF @CarpetaImagenes IS NOT NULL AND @OK IS NULL
  BEGIN*/
    EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
    SELECT @Ruta =@Ruta+'\Sucursal\'
    IF @OK IS NULL
      EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
    IF @Ok IS NULL
    BEGIN
      SELECT @ArchivoDestino = @Ruta+@Imagen
      EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
    END   
  --END        
  
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebArtC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebArtC
GO
CREATE TRIGGER tgWebArtC ON WebArt
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
  @IDI          int,
  @IDVarI       int,
  @IDB          int,
  @IDVarB       int

 SELECT @IDI = ID,@IDVarI = VariacionID FROM INSERTED
 
 SELECT @IDB = ID,@IDVarB = VariacionID FROM DELETED

 IF   @IDVarI <>@IDVarB
   DELETE WebArtVariacionCombinacion
    WHERE IDArt = @IDI

END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebArtVariacionCombinacionAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebArtVariacionCombinacionAC
GO
CREATE TRIGGER tgWebArtVariacionCombinacionAC ON WebArtVariacionCombinacion
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
  DECLARE
  @ID                   int,
  @IDArt                int,
  --@CarpetaImagenes      varchar(50),
  @DropBox              varchar(50),
  @Sucursal             int, 
  @eCommerceSucursal    varchar(10),
  @Ruta                 varchar(255),
  @Archivo              varchar(255),
  @Ok                   int,
  @OkRef                varchar(255),
  @Imagen               varchar(255),
  @ImagenD              varchar(255),
  @ArchivoDestino       varchar(255)

  
  SELECT @ID = ID , @IDArt = IDArt, @Archivo = Imagen FROM INSERTED
  SELECT  @ImagenD = Imagen FROM DELETED
  
  SELECT @Imagen = dbo.fnWebNombreImagen(@Archivo)
  
  SELECT @DropBox = DirSFTP FROM WebVersion
  
  IF EXISTS(SELECT * FROM Sucursal WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL) AND @Archivo <> @ImagenD
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal--, eCommerceImagenes
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal--,@CarpetaImagenes
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @Ruta = @DropBox + '\' + @eCommerceSucursal+'\Imagenes'--+@CarpetaImagenes
     
      /*IF @CarpetaImagenes IS NOT NULL AND @OK IS NULL
      BEGIN*/
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
        
             
      
        SELECT @Ruta =@Ruta+'\'+CONVERT(varchar,@IDArt)+'\'
        IF @OK IS NULL
        EXEC spCrearFolder @Ruta, @Ok OUTPUT,@OkRef OUTPUT
        
        IF @Ok IS NULL
        BEGIN
          SELECT @ArchivoDestino = @Ruta+@Imagen
    
          EXEC spCopiarArchivo @Archivo, @ArchivoDestino, @Ok OUTPUT,@OkRef OUTPUT
        END   
      --END        

      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal--,@CarpetaImagenes
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END   
  
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtVariacionAC')           AND sysstat & 0xf = 8) drop trigger dbo.tgWebArtVariacionAC
GO
CREATE TRIGGER tgWebArtVariacionAC ON WebArtVariacion
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
	DECLARE @Nombre varchar(100)

	DECLARE crActualizar CURSOR local FOR
	SELECT Nombre
	 FROM Inserted     
	OPEN crActualizar
	
  FETCH NEXT FROM crActualizar INTO  @Nombre
  WHILE @@FETCH_STATUS = 0
  BEGIN
	IF(ISNULL(@Nombre, '') = '')
		RAISERROR('El campo Nombre no puede estar vacio', 16, -1)
	FETCH NEXT FROM crActualizar INTO  @Nombre
  END
  CLOSE crActualizar
  DEALLOCATE crActualizar   
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtVariacionB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtVariacionB
GO
CREATE TRIGGER tgWebArtVariacionB ON WebArtVariacion
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
   @VariacionID          int,
   @Nombre				 varchar(100),
   @TieneWebArt			 bit,
   @Usuario				 varchar(10),
   @Msg					 varchar(255),
   @Ok					 int
   
   SELECT @Ok = 0
   SELECT @Usuario = Usuario FROM Acceso WHERE SPID = dbo.fnAccesoID(@@SPID)
   
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT ID, Nombre, TieneWebArt
         FROM Deleted     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO  @VariacionID, @Nombre, @TieneWebArt
      WHILE @@FETCH_STATUS = 0 AND @Ok = 0
      BEGIN
		IF (@TieneWebArt = 1) 
		BEGIN
			SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede eliminar la Variacion porque tiene Articulos Web asignados') + ('. ('+@Nombre+')')
			RAISERROR(@Msg, 16, -1)
			SELECT @Ok = 1
			ROLLBACK
		END
      
        IF @Ok = 0 AND EXISTS (SELECT * FROM WebArtOpcion WHERE VariacionID = @VariacionID)
          DELETE WebArtOpcion WHERE VariacionID = @VariacionID
       
        IF @Ok = 0 AND EXISTS (SELECT * FROM WebArtOpcionValor WHERE VariacionID = @VariacionID)
          DELETE WebArtOpcionValor WHERE VariacionID = @VariacionID     
  
        
        FETCH NEXT FROM crActualizar INTO  @VariacionID, @Nombre, @TieneWebArt
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END
  END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtOpcionB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtOpcionB
GO
CREATE TRIGGER tgWebArtOpcionB ON WebArtOpcion
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
   @ID                   int,
   @VariacionID          int,
   @Nombre				 varchar(100),
   @Usuario				 varchar(10),
   @Msg					 varchar(255),
   @Ok					 int,
   @Regenerando          bit
   

   SELECT @Ok = 0
   SELECT @Usuario = Usuario FROM Acceso WHERE SPID = dbo.fnAccesoID(@@SPID)

   SELECT @Regenerando = Regenerando 
     FROM eCommerceRegenerar

   SET @Regenerando = ISNULL(@Regenerando,0)
   
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT ID, VariacionID, Nombre
         FROM Deleted     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @ID, @VariacionID, @Nombre
      WHILE @@FETCH_STATUS = 0 AND @Ok = 0
      BEGIN
		IF ((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @VariacionID) = 1) AND @Regenerando = 0
		BEGIN
			SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede eliminar la Opcion porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Nombre+')')
			RAISERROR(@Msg, 16, -1)
			SELECT @Ok = 1
			ROLLBACK
		END
      
        IF @Ok = 0 AND EXISTS (SELECT * FROM WebArtOpcionValor WHERE VariacionID = @VariacionID AND OpcionID = @ID)
        DELETE WebArtOpcionValor WHERE VariacionID = @VariacionID  AND OpcionID = @ID            
        FETCH NEXT FROM crActualizar INTO   @ID, @VariacionID, @Nombre
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END   
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtOpcionAC') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtOpcionAC
GO
CREATE TRIGGER tgWebArtOpcionAC ON WebArtOpcion
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
   @VariacionID          int,
   @Nombre				 varchar(100),
   @Usuario				 varchar(10),
   @Msg					 varchar(255),
   @Ok					 int,
   @Regenerando          bit
   
   IF(dbo.fneCommerceEstaSincronizando() = 1) RETURN
   
   SELECT @Ok = 0
   SELECT @Usuario = Usuario FROM Acceso WHERE SPID = dbo.fnAccesoID(@@SPID)

   SELECT @Regenerando = Regenerando 
     FROM eCommerceRegenerar
   
   SET @Regenerando = ISNULL(@Regenerando,0)

    IF EXISTS(SELECT * FROM INSERTED) 
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT VariacionID, Nombre
         FROM INSERTED     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @VariacionID, @Nombre
      WHILE @@FETCH_STATUS = 0 AND @Ok = 0
      BEGIN
		IF ((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @VariacionID) = 1) AND UPDATE(VariacionID) AND @Regenerando = 0
		BEGIN
			SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede Crear la Opcion porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Nombre+')')
			RAISERROR(@Msg, 16, -1)
			SELECT @Ok = 1
			ROLLBACK
		END
       
        FETCH NEXT FROM crActualizar INTO @VariacionID, @Nombre
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END 
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtOpcionValorABC') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtOpcionValorABC
GO
CREATE TRIGGER tgWebArtOpcionValorABC ON WebArtOpcionValor
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
   @VariacionID			 int,
   @Valor				 varchar(100),
   @Usuario				 varchar(10),
   @Msg					 varchar(255),
   @Ok					 int,
   @Inserted			bit,
   @Deleted				bit,



   @Regenerando         bit
   
   IF(dbo.fneCommerceEstaSincronizando() = 1) RETURN
   
   SELECT @Ok = 0
   SELECT @Usuario = Usuario FROM Acceso WHERE SPID = dbo.fnAccesoID(@@SPID)









   SELECT @Regenerando = Regenerando 
     FROM eCommerceRegenerar
   
   SET @Regenerando = ISNULL(@Regenerando,0)
   



    IF EXISTS(SELECT * FROM INSERTED) SELECT @Inserted = 1
    IF EXISTS(SELECT * FROM DELETED) SELECT @Deleted = 1

	IF @Inserted = 1
      DECLARE crActualizar CURSOR local FOR
       SELECT VariacionID, Valor
       FROM INSERTED  
       
    IF @Deleted = 1 AND ISNULL(@Inserted, 0) = 0
      DECLARE crActualizar CURSOR local FOR
       SELECT VariacionID, Valor
       FROM DELETED     
      
      IF @Inserted = 1 OR @Deleted = 1
      BEGIN
		  OPEN crActualizar
		  FETCH NEXT FROM crActualizar INTO @VariacionID, @Valor
		  WHILE @@FETCH_STATUS = 0 AND @Ok = 0
		  BEGIN
			IF ((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @VariacionID) = 1)AND UPDATE(VariacionID) AND @Regenerando = 0
			BEGIN
				SELECT @Msg = 'No se puede'
				IF @Inserted = 1 AND ISNULL(@Deleted, 0) = 0 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede crear el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				IF @Inserted = 1 AND @Deleted = 1 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede editar el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				IF ISNULL(@Inserted, 0) = 0 AND @Deleted = 1 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede eliminar el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				RAISERROR(@Msg, 16, -1)
				SELECT @Ok = 1
				ROLLBACK
			END
	       
			FETCH NEXT FROM crActualizar INTO @VariacionID, @Valor
		  END
		  CLOSE crActualizar
		  DEALLOCATE crActualizar
      END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtOpcionValorABC') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtOpcionValorABC
GO
CREATE TRIGGER tgWebArtOpcionValorABC ON WebArtOpcionValor
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
   @VariacionID		int,
   @Valor		varchar(100),
   @Usuario		varchar(10),
   @Msg			varchar(255),
   @Ok			int,
   @Inserted		bit,
   @Deleted		bit,
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @ID                  int,
   @Regenerando         bit
   
   IF(dbo.fneCommerceEstaSincronizando() = 1) RETURN

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN

  SELECT @Regenerando = Regenerando 
     FROM eCommerceRegenerar
   
   SET @Regenerando = ISNULL(@Regenerando,0)
   
   SELECT @Ok = 0
   SELECT @Usuario = Usuario FROM Acceso WHERE SPID = dbo.fnAccesoID(@@SPID)
   
    IF EXISTS(SELECT * FROM INSERTED) SELECT @Inserted = 1
    IF EXISTS(SELECT * FROM DELETED) SELECT @Deleted = 1

	IF @Inserted = 1
      DECLARE crActualizar CURSOR local FOR
       SELECT VariacionID, Valor
       FROM INSERTED  
       
    IF @Deleted = 1 AND ISNULL(@Inserted, 0) = 0
      DECLARE crActualizar CURSOR local FOR
       SELECT VariacionID, Valor
       FROM DELETED     
      
      IF @Inserted = 1 OR @Deleted = 1
      BEGIN
		  OPEN crActualizar
		  FETCH NEXT FROM crActualizar INTO @VariacionID, @Valor
		  WHILE @@FETCH_STATUS = 0 AND @Ok = 0
		  BEGIN
			IF ((SELECT TieneWebArt FROM WebArtVariacion WHERE ID = @VariacionID) = 1) AND @Regenerando = 0
			BEGIN
				SELECT @Msg = 'No se puede'
				IF @Inserted = 1 AND ISNULL(@Deleted, 0) = 0 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede crear el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				IF @Inserted = 1 AND @Deleted = 1 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede editar el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				IF ISNULL(@Inserted, 0) = 0 AND @Deleted = 1 SELECT @Msg = dbo.fnIdiomaTraducir(@Usuario, 'No se puede eliminar el Valor porque la Variación a la que pertenece tiene Articulos Web asignados') + ('. ('+@Valor+')')
				RAISERROR(@Msg, 16, -1)
				SELECT @Ok = 1
				ROLLBACK
			END
	       
			FETCH NEXT FROM crActualizar INTO @VariacionID, @Valor
		  END
		  CLOSE crActualizar
		  DEALLOCATE crActualizar
      END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtB
GO
CREATE TRIGGER tgWebArtB ON WebArt
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @ID                   int,
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5)
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT ID
         FROM Deleted     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @ID
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        IF EXISTS (SELECT * FROM WebArtAtributos WHERE IDArt = @ID)
          DELETE WebArtAtributos WHERE IDArt = @ID
          
        IF EXISTS (SELECT * FROM WebArtCamposConfigurablesD d JOIN WebArtCamposConfigurables c ON c.ID = d.ID WHERE c.IDArt = @ID)
          DELETE  WebArtCamposConfigurablesD WHERE ID IN(SELECT ID FROM WebArtCamposConfigurables WHERE IDArt = @ID)            
          
        IF EXISTS (SELECT * FROM WebArtCamposConfigurables WHERE IDArt = @ID)
          DELETE WebArtCamposConfigurables WHERE IDArt = @ID     

        IF EXISTS (SELECT * FROM WebArtImagen WHERE IDArt = @ID)
          DELETE WebArtImagen WHERE IDArt = @ID                           
          
        IF EXISTS (SELECT * FROM WebArtVideo WHERE IDArt = @ID)
          DELETE WebArtVideo WHERE IDArt = @ID                     

        IF EXISTS (SELECT * FROM WebArtVariacionCombinacion WHERE IDArt = @ID)
          DELETE WebArtVariacionCombinacion WHERE IDArt = @ID       

        IF EXISTS (SELECT * FROM WebArtVariacionCombinacionD WHERE IDArt = @ID)
          DELETE WebArtVariacionCombinacionD WHERE IDArt = @ID    
          
        IF EXISTS (SELECT * FROM WebCatArt_Art WHERE IDWebArt = @ID)
          DELETE WebCatArt_Art WHERE IDWebArt = @ID               
                
        IF EXISTS (SELECT * FROM WebArtDescripcion WHERE ID = @ID)
          DELETE WebArtDescripcion WHERE ID = @ID    
          
        IF EXISTS (SELECT * FROM WebArtEnvoltura WHERE IDArt = @ID)
          DELETE WebArtEnvoltura WHERE IDArt = @ID             
        FETCH NEXT FROM crActualizar INTO   @ID
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END   
END
GO



if exists (select * from sysobjects where id = object_id('dbo.tgWebPaisB') and sysstat & 0xf = 8) drop trigger dbo.tgWebPaisB
GO
CREATE TRIGGER tgWebPaisB ON WebPais
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @ID                   int,
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5)
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT ID
         FROM Deleted     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @ID
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        IF EXISTS (SELECT * FROM WebPaisEstado WHERE IDPais = @ID)
        DELETE WebPaisEstado WHERE IDPais = @ID
        FETCH NEXT FROM crActualizar INTO   @ID
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END   
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceArtAC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceArtAC
GO
CREATE TRIGGER tgeCommerceArtAC ON Art
--//WITH ENCRYPTION
FOR INSERT, UPDATE 
AS BEGIN
  DECLARE
   @Articulo            varchar(20),
   @Estatus             varchar(10),
   @Precio              float ,
   @Precio2             float ,
   @Precio3             float ,
   @Precio4             float ,
   @Precio5             float ,
   @Precio6             float ,
   @Precio7             float ,
   @Precio8             float ,
   @Precio9             float ,
   @Precio10            float ,
   @PrecioD             float ,
   @PrecioD2            float ,
   @PrecioD3            float ,
   @PrecioD4            float ,
   @PrecioD5            float ,
   @PrecioD6            float ,
   @PrecioD7            float ,
   @PrecioD8            float ,
   @PrecioD9            float ,
   @PrecioD10           float ,
   @Peso				float,
   @PesoD				float,
   @Ok                  int ,
   @ListaPrecios        varchar(20),
   @eCommerceEmpresa    bit,
   @Empresa		varchar(5),
   @ID                  int
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN

    
    




  DECLARE crArt CURSOR FOR
   SELECT i.Articulo, i.PrecioLista, i.Precio2, i.Precio3, i.Precio4, i.Precio5, i.Precio6, i.Precio7, i.Precio8, i.Precio9, i.Precio10, i.Peso, d.PrecioLista, d.Precio2, d.Precio3, d.Precio4, d.Precio5, d.Precio6, d.Precio7, d.Precio8, d.Precio9, d.Precio10, d.Peso
     FROM Inserted i LEFT JOIN Deleted d ON i.Articulo = d.Articulo
    WHERE  (ISNULL(i.PrecioLista,0.0) <> ISNULL(d.PrecioLista,0.0)) OR
           (ISNULL(i.Precio2,0.0) <> ISNULL(d.Precio2,0.0)) OR
           (ISNULL(i.Precio3,0.0) <> ISNULL(d.Precio3,0.0)) OR
           (ISNULL(i.Precio4,0.0) <> ISNULL(d.Precio4,0.0)) OR
           (ISNULL(i.Precio5,0.0) <> ISNULL(d.Precio5,0.0)) OR
           (ISNULL(i.Precio6,0.0) <> ISNULL(d.Precio6,0.0)) OR
           (ISNULL(i.Precio7,0.0) <> ISNULL(d.Precio7,0.0)) OR
           (ISNULL(i.Precio8,0.0) <> ISNULL(d.Precio8,0.0)) OR
           (ISNULL(i.Precio9,0.0) <> ISNULL(d.Precio9,0.0)) OR
           (ISNULL(i.Precio10,0.0) <> ISNULL(d.Precio10,0.0)) OR
           (ISNULL(i.Peso,0.0) <> ISNULL(d.Peso,0.0)) 
        
  OPEN crArt 
  FETCH NEXT FROM crArt INTO @Articulo, @Precio, @Precio2,    @Precio3,    @Precio4,    @Precio5,    @Precio6,    @Precio7,    @Precio8,    @Precio9,    @Precio10, @Peso, @PrecioD, @PrecioD2,    @PrecioD3,    @PrecioD4,    @PrecioD5,    @PrecioD6,    @PrecioD7,    @PrecioD8,    @PrecioD9,    @PrecioD10, @PesoD
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
     
     IF EXISTS(SELECT * FROM WebArt WHERE Articulo = @Articulo AND 
     (ISNULL(@PrecioD,0.0) <> ISNULL(@Precio,0.0)) OR
     (ISNULL(@PrecioD2,0.0) <> ISNULL(@Precio2,0.0)) OR
     (ISNULL(@PrecioD3,0.0) <> ISNULL(@Precio3,0.0)) OR
     (ISNULL(@PrecioD4,0.0) <> ISNULL(@Precio4,0.0)) OR
     (ISNULL(@PrecioD5,0.0) <> ISNULL(@Precio5,0.0)) OR
     (ISNULL(@PrecioD6,0.0) <> ISNULL(@Precio6,0.0)) OR
     (ISNULL(@PrecioD7,0.0) <> ISNULL(@Precio7,0.0)) OR
     (ISNULL(@PrecioD8,0.0) <> ISNULL(@Precio8,0.0)) OR
     (ISNULL(@PrecioD9,0.0) <> ISNULL(@Precio9,0.0)) OR
     (ISNULL(@PrecioD10,0.0) <> ISNULL(@Precio10,0.0)) OR
     (ISNULL(@PesoD,0.0) <> ISNULL(@Peso,0.0))
     )
     
       UPDATE WebArt 
          SET Precio = @Precio, Precio2 = @Precio2, Precio3 = @Precio3, Precio4 = @Precio4, Precio5 = @Precio5, Precio6 = @Precio6, Precio7 = @Precio7, Precio8 = @Precio8, Precio9 = @Precio9, Precio10 = @Precio10, Peso = @Peso
        WHERE Articulo = @Articulo
     IF @@ERROR <> 0 SET  @Ok  = 0
       
     IF EXISTS(SELECT * FROM WebArtVariacionCombinacion WHERE Articulo = @Articulo AND 
     (ISNULL(@PrecioD,0.0) <> ISNULL(@Precio,0.0)) OR
     (ISNULL(@PrecioD2,0.0) <> ISNULL(@Precio2,0.0)) OR
     (ISNULL(@PrecioD3,0.0) <> ISNULL(@Precio3,0.0)) OR
     (ISNULL(@PrecioD4,0.0) <> ISNULL(@Precio4,0.0)) OR
     (ISNULL(@PrecioD5,0.0) <> ISNULL(@Precio5,0.0)) OR
     (ISNULL(@PrecioD6,0.0) <> ISNULL(@Precio6,0.0)) OR
     (ISNULL(@PrecioD7,0.0) <> ISNULL(@Precio7,0.0)) OR
     (ISNULL(@PrecioD8,0.0) <> ISNULL(@Precio8,0.0)) OR
     (ISNULL(@PrecioD9,0.0) <> ISNULL(@Precio9,0.0)) OR
     (ISNULL(@PrecioD10,0.0) <> ISNULL(@Precio10,0.0)))
       UPDATE WebArtVariacionCombinacion 
          SET Precio = @Precio, Precio2 = @Precio2, Precio3 = @Precio3, Precio4 = @Precio4, Precio5 = @Precio5, Precio6 = @Precio6, Precio7 = @Precio7, Precio8 = @Precio8, Precio9 = @Precio9, Precio10 = @Precio10  
        WHERE Articulo = @Articulo   
     IF @@ERROR <> 0 SET  @Ok  = 0      

    FETCH NEXT FROM crArt INTO @Articulo, @Precio, @Precio2,    @Precio3,    @Precio4,    @Precio5,    @Precio6,    @Precio7,    @Precio8,    @Precio9,    @Precio10, @Peso, @PrecioD, @PrecioD2,    @PrecioD3,    @PrecioD4,    @PrecioD5,    @PrecioD6,    @PrecioD7,    @PrecioD8,    @PrecioD9,    @PrecioD10, @PesoD
  END
  CLOSE crArt
  DEALLOCATE crArt

END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtCamposConfigurablesB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtCamposConfigurablesB
GO
CREATE TRIGGER tgWebArtCamposConfigurablesB ON WebArtCamposConfigurables
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @ID                   int,
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5)
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
    IF EXISTS(SELECT * FROM DELETED)
    BEGIN
      DECLARE crActualizar CURSOR local FOR
       SELECT ID
         FROM Deleted     
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @ID
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        IF EXISTS (SELECT * FROM WebArtCamposConfigurablesD WHERE ID = @ID)
        DELETE WebArtCamposConfigurablesD WHERE ID = @ID
        FETCH NEXT FROM crActualizar INTO   @ID
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar   
    END   
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgWebArtAtributosCatB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtAtributosCatB
GO
CREATE TRIGGER tgWebArtAtributosCatB ON WebArtAtributosCat
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @Tipo Varchar(50),
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5),
   @ID                  int
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
   SELECT @Tipo = Tipo FROM DELETED
   
   DELETE WebArtAtributosCatD WHERE Tipo = @Tipo  
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgWebArtCamposConfigurablesCatB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtCamposConfigurablesCatB
GO
CREATE TRIGGER tgWebArtCamposConfigurablesCatB ON WebArtCamposConfigurablesCat
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @Tipo Varchar(50),
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5),
   @ID                  int
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
   SELECT @Tipo = Tipo FROM DELETED
   
   DELETE WebArtCamposConfigurablesCatD WHERE Tipo = @Tipo  
   DELETE WebArtCamposConfigurablesCatDD WHERE Tipo = @Tipo  
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebArtCamposConfigurablesCatDB') and sysstat & 0xf = 8) drop trigger dbo.tgWebArtCamposConfigurablesCatDB
GO
CREATE TRIGGER tgWebArtCamposConfigurablesCatDB ON WebArtCamposConfigurablesCatD
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
  @Tipo                 varchar(50),
  @Nombre               varchar(255),
  @eCommerceEmpresa     bit,
  @Empresa		varchar(5),
   @ID                  int
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN
   
   SELECT @Tipo = Tipo, @Nombre = Nombre FROM DELETED
   

   DELETE WebArtCamposConfigurablesCatDD WHERE Tipo = @Tipo  AND Nombre = @Nombre
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebUsuariosABC') and sysstat & 0xf = 8) drop trigger dbo.tgWebUsuariosABC
GO
CREATE TRIGGER tgWebUsuariosABC ON WebUsuarios
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @Ok				int,
    @IDI                        int,
    @IDD                        int,
    @ContrasenaI		varchar(32),
    @ContrasenaD		varchar(32),
    @ConfirmacionI		varchar(32),
    @ConfirmacionD		varchar(32),
    @Mensaje			varchar(255)


  
  SELECT @Ok = NULL


  SELECT @IDI = ID, @ContrasenaI = Contrasena, @ConfirmacionI = ContrasenaConfirmacion FROM Inserted
  SELECT @IDD = ID,  @ContrasenaD = Contrasena, @ConfirmacionD = ContrasenaConfirmacion FROM Deleted

  IF @IDI IS NOT NULL AND @ContrasenaD <> @ContrasenaI --OR @ConfirmacionD <> @ConfirmacionI
  BEGIN
    IF @ContrasenaI <> @ConfirmacionI    SELECT @Ok = 60230
    
  END

IF @ContrasenaI <> @ConfirmacionI    SELECT @Ok = 60230
  IF @Ok IS NOT NULL
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END
 

END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceVentaC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceVentaC
GO
CREATE TRIGGER tgeCommerceVentaC ON  Venta
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Ok			int,
    @Modulo		char(5),
    @Mov		char(20),
    @MovIDN		char(20),
    @MovIDA		char(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	char(15),
    @EstatusAnterior 	char(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @FechaRequeridaN	datetime,
    @FechaRequeridaA	datetime,
    @Tipo		varchar(50),
    @UsuarioA		char(10),
    @UsuarioN		char(10),
    @Mensaje		char(255),
    @eCommerceSucursal  varchar(20),
    @OrigenID           varchar(20),
    @eCommerceEmpresa   bit,
    @Empresa		varchar(5)
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN

  SELECT @Modulo = 'VTAS', @Ok = NULL
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), ''), @MovIDA = NULLIF(RTRIM(MovID), '')  FROM Deleted
  SELECT @ID = ID, @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Mov = NULLIF(RTRIM(Mov), ''), @MovIDN = NULLIF(RTRIM(MovID), ''),@Tipo = NULLIF(RTRIM(ServicioTipo), '') FROM Inserted

  IF   dbo.fneCommerceOrigen('VTAS',@ID,1) = 1  AND(@SituacionAnterior <> @SituacionNueva AND @SituacionNueva IS NOT NULL
    AND EXISTS (SELECT * FROM WebSituacionEstatus w WHERE w.Modulo = 'VTAS' AND  w.Situacion = @SituacionNueva AND w.Mov = @Mov AND w.Estatus = @EstatusNuevo
    AND @SituacionNueva IN (SELECT Situacion FROM MovSituacion WHERE Modulo = 'VTAS' AND Mov = @Mov AND Estatus = @EstatusNuevo AND Tipo = @Tipo AND UPPER(Flujo) IN ('INICIAL TODAS', 'INICIAL ESPECIAL'))))
     --OR (@EstatusAnterior <> @EstatusNuevo AND EXISTS (SELECT * FROM WebSituacionEstatus w WHERE w.Modulo = 'VTAS' AND  NULLIF(w.Situacion,'') IS NULL AND w.Mov = @Mov AND w.Estatus = @EstatusNuevo))
  BEGIN
    DECLARE crSucursal CURSOR local FOR
     SELECT Sucursal, eCommerceSucursal
       FROM Sucursal
      WHERE eCommerce = 1 AND NULLIF(eCommerceSucursal,'') IS NOT NULL     
    OPEN crSucursal
    FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN
      SELECT @OrigenID = ISNULL(dbo.fneCommerceIDOrigen(@Modulo,@ID,1),@ID)
      
      EXEC speCommerceSolicitudISWebMovSituacion @OrigenID,'VTAS',@ID, @EstatusNuevo, @Sucursal, @eCommerceSucursal 
    
      FETCH NEXT FROM crSucursal INTO @Sucursal, @eCommerceSucursal
    END
    CLOSE crSucursal
    DEALLOCATE crSucursal    
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgeCommerceAlmAC') and sysstat & 0xf = 8) drop trigger dbo.tgeCommerceAlmAC
GO
--/*
--CREATE TRIGGER tgeCommerceAlmAC ON Alm
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--  @eCommerceSincronizaD bit,
--  @eCommerceSincronizaI bit,
--  @eCommerceEmpresa     bit,
--  @Empresa		varchar(5),
--  @ID                   int
   

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @eCommerceEmpresa = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa
--  IF dbo.fnEstaSincronizando() = 1 RETURN
--  IF ISNULL(@eCommerceEmpresa,0) = 0 RETURN

--  SELECT @eCommerceSincronizaD = ISNULL(eCommerceSincroniza,0) FROM DELETED
--  SELECT @eCommerceSincronizaI = ISNULL(eCommerceSincroniza,0) FROM INSERTED

--  IF @eCommerceSincronizaD <> @eCommerceSincronizaI 
--  BEGIN
--    INSERT eCommerceSaldoU(Articulo, SubCuenta)
--    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
--      FROM WebArt a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
--     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL
--    GROUP BY a.Articulo,a.SubCuenta
    
--    INSERT eCommerceSaldoU(Articulo, SubCuenta)
--    SELECT a.Articulo,ISNULL(a.SubCuenta ,'')
--      FROM WebArtVariacionCombinacion a LEFT OUTER JOIN eCommerceSaldoU u ON a.Articulo = u.Articulo AND ISNULL(a.SubCuenta,'')=u.Subcuenta 
--     WHERE u.Articulo IS NULL AND a.Articulo IS NOT NULL 
--     GROUP BY a.Articulo,a.SubCuenta       
   
    
--  END
--END
--GO
--

