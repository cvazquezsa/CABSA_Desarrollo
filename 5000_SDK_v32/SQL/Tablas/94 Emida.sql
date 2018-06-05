-- REQ12336
/****** EmidaActualizarCatalogos ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaActualizarCatalogos') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaActualizarCatalogos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaActualizarCatalogos') and type = 'U') 
CREATE TABLE EmidaActualizarCatalogos(
  RID				int				IDENTITY,
  Empresa			varchar(5)		NOT NULL,
  Estacion			int				NOT NULL,
  URL				varchar(255)	NOT NULL,
  Catalogo			varchar(15)		NOT NULL,
  Clave				varchar(255)	NOT NULL,
  Descripcion		varchar(255)	NOT NULL, 
  CONSTRAINT priEmidaActualizarCatalogos PRIMARY KEY CLUSTERED(RID)
  )
GO

-- REQ12336
/****** EmidaCompraD ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaCompraD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaCompraD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaCompraD') and type = 'U') 
CREATE TABLE EmidaCompraD(
  RID			int		IDENTITY,
  ID			int,
  IDVTAS		int,
  Estatus		varchar(15),
  Articulo		varchar(20),
  Cantidad		float,
  FechaEmision	datetime,
  CarrierId		varchar(255)NULL,
  URL			varchar(255)NULL,      
  Comision		float		NULL,
  Precio		float		NULL,
  Importe		float		NULL,
  CONSTRAINT priEmidaCompraD PRIMARY KEY CLUSTERED(RID)
  )      
GO

EXEC spADD_INDEX 'EmidaCompraD', 'IDVTAS', 'IDVTAS'
GO

-- REQ12336
/****** EmidaSubmitPayment ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaSubmitPayment') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaSubmitPayment','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaSubmitPayment') and type = 'U') 
CREATE TABLE dbo.EmidaSubmitPayment(
  Empresa			varchar(5)		NOT NULL,
  Estacion			int				NOT NULL,
  amount			float			NOT NULL,
  CarrierId			varchar(255)	NOT NULL,
  documentNumber	varchar(25)		NOT NULL, 
  documentDate		datetime		NOT NULL,
  Institucion		varchar(20)		NOT NULL,
  CONSTRAINT priEmidaSubmitPayment PRIMARY KEY CLUSTERED(Estacion)
  )
GO

-- REQ12336
/****** EmidaAccountBalance ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaAccountBalance') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaAccountBalance','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaAccountBalance') and type = 'U') 
CREATE TABLE dbo.EmidaAccountBalance(
  Empresa				varchar(5),
  URL					varchar(255),
  Sucursal				int,
  legalBusinessname		varchar(255)NULL,
  dba					varchar(255)NULL,
  availableBalance		varchar(20)	NULL,
  CONSTRAINT priEmidaAccountBalance PRIMARY KEY CLUSTERED(Empresa, URL, Sucursal)
  )
GO

-- REQ12336
/****** EmidaCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaCfg') and type = 'U') 
CREATE TABLE dbo.EmidaCfg(
  Empresa		varchar(5),
  Version		varchar(2),
  CONSTRAINT priEmidaCfg PRIMARY KEY CLUSTERED(Empresa)
  )
GO

EXEC spDROP_COLUMN 'EmidaCfg', 'ClerkID'
GO

EXEC spALTER_TABLE 'EmidaCfg', 'TimeOut', 'int NOT NULL DEFAULT 20 WITH VALUES'
GO

-- BUG13861
EXEC spALTER_TABLE 'EmidaCfg', 'TimeOutLookup', 'int NOT NULL DEFAULT 10 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmidaCfg', 'Reintentos', 'int NOT NULL DEFAULT 3 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmidaCfg', 'Proveedor', 'varchar(10) NULL'
GO

EXEC spALTER_TABLE 'EmidaCfg', 'MovOC', 'varchar(20) NOT NULL DEFAULT ''Orden Compra Emida'' WITH VALUES'
GO
-- REQ13868
EXEC spALTER_TABLE 'EmidaCfg', 'LogTransacciones', 'bit NOT NULL DEFAULT 1 WITH VALUES'
GO
-- REQ13868
EXEC spALTER_TABLE 'EmidaCfg', 'UbicacionLogTransacciones', 'varchar(255) NULL'
GO
--REQ14335
EXEC spALTER_TABLE 'EmidaCfg', 'NivelCfgSiteID', 'varchar(10) NOT NULL DEFAULT ''Usuario'' WITH VALUES'
GO

IF NOT EXISTS(SELECT * FROM EmidaCfg)
  INSERT INTO EmidaCfg(Empresa, Version) SELECT 'DEMO', '01'
GO

-- REQ12336
/****** EmidaURLCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaURLCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaURLCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaURLCfg') and type = 'U') 
CREATE TABLE dbo.EmidaURLCfg(
  Empresa		varchar(5),
  URL			varchar(255)	NOT NULL,
  CONSTRAINT priEmidaURLCfg PRIMARY KEY CLUSTERED(Empresa, URL)
  )
GO

EXEC spALTER_TABLE 'EmidaURLCfg', 'CtaDinero', 'varchar(10) NULL'
GO
  
-- REQ12336
/****** EmidaTerminalCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaTerminalCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaTerminalCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaTerminalCfg') and type = 'U') 
CREATE TABLE dbo.EmidaTerminalCfg(
  Empresa		varchar(5),
  Estacion		int,
  URL			varchar(255),
  Sucursal		int,
  SiteID		varchar(20)		NULL,
  CONSTRAINT priEmidaTerminalCfg PRIMARY KEY CLUSTERED(Empresa, Estacion, URL, Sucursal)
  )
GO

EXEC spALTER_TABLE 'EmidaTerminalCfg', 'ClerkID', 'varchar(20) NULL'
GO

EXEC spALTER_TABLE 'EmidaTerminalCfg', 'InvoiceNo', 'int NOT NULL DEFAULT 1 WITH VALUES'
GO

EXEC spDROP_COLUMN 'EmidaTerminalCfg', 'ClerkID'
GO

--REQ14335
EXEC spDROP_PK 'EmidaTerminalCfg'
GO
--REQ14335
EXEC spDROP_COLUMN 'EmidaTerminalCfg', 'Estacion'
GO
--REQ14335
EXEC spALTER_TABLE 'EmidaTerminalCfg', 'CtaDinero', 'varchar(10) NULL'
GO
--REQ14335
EXEC spALTER_TABLE 'EmidaTerminalCfg', 'Agente', 'varchar(10) NULL'
GO
--REQ14335
EXEC spALTER_TABLE 'EmidaTerminalCfg', 'RID', 'int IDENTITY'
GO
--REQ14335
EXEC spADD_PK 'EmidaTerminalCfg', 'RID'
GO

-- REQ12336
/****** EmidaCarrierCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaCarrierCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaCarrierCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaCarrierCfg') and type = 'U') 
CREATE TABLE dbo.EmidaCarrierCfg(
  Empresa		varchar(5),
  URL			varchar(255),
  CarrierId		varchar(255),
  Description	varchar(255)	NULL,
  ProductCount	varchar(10)		NULL,
  CONSTRAINT priEmidaCarrierCfg PRIMARY KEY CLUSTERED(Empresa, URL, CarrierId)
  )
GO

-- REQ12336
/****** EmidaProductCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaProductCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaProductCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaProductCfg') and type = 'U') 
CREATE TABLE dbo.EmidaProductCfg(
  Empresa			varchar(5),
  URL				varchar(255),  
  CarrierId			varchar(255),  
  ProductId			varchar(255),
  Description		varchar(255)	NULL,
  ShortDescription	varchar(255)	NULL,
  Amount			varchar(10)		NULL,
  CategoryId		varchar(255)	NULL,
  TransTypeId		varchar(255)	NULL,
  DiscountRate		varchar(10)		NULL,
  CurrencyCode		varchar(10)		NULL,
  CurrencySymbol	varchar(10)		NULL,

  Articulo			varchar(20)		NULL,

  CONSTRAINT priEmidaProductCfg PRIMARY KEY CLUSTERED(Empresa, URL, CarrierID, ProductID)
  )
GO

EXEC spALTER_TABLE 'EmidaProductCfg', 'Comision', 'float NULL'
go

-- REQ12336
/****** EmidaMerchantIDCfg ******/
if not exists (select * from SysTabla where SysTabla = 'EmidaMerchantIDCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmidaMerchantIDCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmidaMerchantIDCfg') and type = 'U') 
CREATE TABLE dbo.EmidaMerchantIDCfg(
  Empresa			varchar(5),
  URL				varchar(255),
  Sucursal			int,
  MerchantID		varchar(20),
  CONSTRAINT priEmidaMerchantIDCfg PRIMARY KEY CLUSTERED(Empresa, URL, Sucursal)
  )
GO

--REQ14335
EXEC spALTER_TABLE 'EmidaMerchantIDCfg', 'SiteID', 'varchar(20) NULL'
go
--REQ14335
EXEC spALTER_TABLE 'EmidaMerchantIDCfg', 'InvoiceNo', 'int NOT NULL DEFAULT 1 WITH VALUES'
go
--BUG16803
EXEC spDROP_COLUMN 'EmidaMerchantIDCfg', 'InvoiceNo'

GO