SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET NOCOUNT ON
GO

/************************************************** Campos Nuevos *******************************************/
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenModulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'MovImpuesto', 'OrigenModuloID', 'int NULL'
	
EXEC spALTER_TABLE 'Prov', 'CFDIRetTipoContribuyente', 'varchar(2) NULL'

EXEC spALTER_TABLE 'Prov', 'CFDIRetBeneficiarioNombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prov', 'CFDIRetBeneficiarioCURP', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Prov', 'CFDIRetBeneficiarioRFC', 'varchar(15) NULL'
GO

EXEC spALTER_TABLE 'Art', 'CFDIRetClave', 'varchar(2) NULL'
EXEC spALTER_TABLE 'Art', 'CFDIRetIEPSImpuesto', 'varchar(10) NULL DEFAULT ''Impuesto 2'' WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'CFDIRetClave', 'varchar(2) NULL'
GO

EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarRetencion', 'bit NULL	DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'UsarTimbrarRetencion', 'bit	NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD' , 'RetencionAlmacenarRuta', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD' , 'RetencionNombre', 'varchar(100)	NULL DEFAULT ''<Proveedor><Ejercicio><Periodo><Concepto>'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarXMLRetencion', 'bit	NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarPDFRetencion', 'bit	NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarAsuntoRetencion', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarMensajeRetencion', 'varchar(255) NULL'

EXEC spALTER_COLUMN 'EmpresaCFD', 'EnviarMensajeRetencion', 'varchar(255) NULL'
GO

EXEC spALTER_TABLE 'Pais', 'CFDIRetClaveSat', 'varchar(2) NULL'

--BUG1067
EXEC spALTER_COLUMN 'Pais', 'CFDIRetClaveSat', 'varchar(3) NULL'

EXEC spALTER_TABLE 'PaisEstado', 'CFDIRetClaveSat', 'varchar(2) NULL'
GO

EXEC spALTER_TABLE 'Cxp',   'CFDRetencionTimbrado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Gasto', 'CFDRetencionTimbrado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Compra', 'CFDRetencionTimbrado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Dinero', 'CFDRetencionTimbrado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

EXEC spAlter_Table 'GastoD', 'Impuestos2', 'float NULL'
EXEC spAlter_Table 'GastoD', 'Impuesto1', 'float NULL'
EXEC spAlter_Table 'GastoD', 'Impuesto2', 'float NULL'
EXEC spAlter_Table 'GastoD', 'Timbrado', 'bit NULL' 
GO

EXEC spALTER_TABLE 'EmpresaCFD' , 'CFDIClaveRiesgo', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD' , 'NominaAlmacenarRuta', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD' , 'NominaNombre', 'varchar(100)	NULL DEFAULT ''<Personal> <Movimiento> <Serie><Folio>'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaTimbrarCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaIntelisisCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'TimeOutTimbrado', 'int NOT NULL DEFAULT 15000 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'TercerosTimbrar', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'NominaTimbrar', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaANSIToUTF', 'varchar(255) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIServidor', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIUsuario', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIPassword', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaCertificado', 'varchar(255) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaGenerarQRCode', 'varchar(255) NULL' --Pestaña Jasper Reports
EXEC spALTER_TABLE 'EmpresaCFD', 'ContrasenaLlave', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIToken', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDICuenta', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIPassword', 'varchar(100) NULL'
GO

EXEC SPALTER_TABLE 'EmpresaCfg2', 'GASRetencion3Independiente',' bit NULL DEFAULT 0 WITH VALUES'
GO

--BUG1169
EXEC spALTER_TABLE 'EmpresaGral', 'TipoImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion1', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion2', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion3', 'varchar(10) NULL'
GO

--BUG1183
EXEC spALTER_TABLE 'MovClave', 'SubClaveDe', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'MovTipo', 'SubClave', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'DBMailPerfil', 'varchar(50) NULL'
GO

--BUG1183
EXEC spAlter_Table 'AnexoMov', 'CFD', 'bit NOT NULL Default 0'
EXEC spALTER_TABLE 'Version', 'Retencion2BaseImpuesto1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Impuesto2BaseImpuesto1', 'bit NULL DEFAULT 1 WITH VALUES'

GO

/************************************************** Tablas **************************************************/

/****** CFDIRetGastoComplemento ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CFDIRetGastoComplemento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetGastoComplemento','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIRetGastoComplemento') AND type = 'U') 
  CREATE TABLE dbo.CFDIRetGastoComplemento (
	                                          ID					    int				  NOT NULL,
	                                          CveTipDivOUtil	varchar(2)	NULL,
                                            TipoSocDistrDiv varchar(25)	NULL,
                                            ProporcionRem		float			  NULL	
	CONSTRAINT priCFDIRetGastoComplemento PRIMARY KEY  CLUSTERED (ID)
)
GO
/******************* Nuevos Campos CFDIRetGastoComplemento **********************/
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'Gravado',                   'float NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'Exento',                    'float NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontISRAcredRetMexico',     'float  NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontISRAcredRetExtranjero', 'float  NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontRetExtDivExt',          'float  NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontISRAcredNal',           'float  NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontDivAcumNal',            'float  NULL'
EXEC spALTER_TABLE 'CFDIRetGastoComplemento', 'MontDivAcumExt',            'float  NULL'

GO

/****** CFDIRetencionCompXMLPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionCompXMLPlantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionCompXMLPlantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCompXMLPlantilla') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionCompXMLPlantilla(
	Complemento			varchar(20)		NOT NULL,
    Version				varchar(5)		NOT NULL,
	Plantilla			varchar(max)	NULL,
	Vista				varchar(100)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionCompXMLPlantilla PRIMARY KEY CLUSTERED(Complemento)
)
GO

/****** CFDIRetencionCompXMLXSD ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionCompXMLXSD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionCompXMLXSD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCompXMLXSD') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionCompXMLXSD(
	Complemento		varchar(20)		NOT NULL,
	XSD				varchar(max)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionCompXMLXSD PRIMARY KEY CLUSTERED(Complemento)
)
GO

/****** CFDIRetencionCompXMLCampo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionCompXMLCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionCompXMLCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCompXMLCampo') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionCompXMLCampo(
	Complemento		varchar(20)		NOT NULL,
	CampoXML		varchar(100)	NOT NULL,
	CampoVista		varchar(100)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionCompXMLCampo PRIMARY KEY CLUSTERED(Complemento, CampoXML)
)
GO

/****** CFDIRetencionProvPeriodo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionProvPeriodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionProvPeriodo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionProvPeriodo') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionProvPeriodo (
	RID 					int 			IDENTITY,
	
	ID						int				NOT NULL,
	Empresa					varchar(5)		NOT NULL,
	Proveedor				varchar(10)		NOT NULL,
	ConceptoSAT				varchar(50)		NOT NULL,
	Ejercicio				int				NOT NULL,
	Periodo					int				NOT NULL,

	CONSTRAINT priCFDIRetencionProvPeriodo PRIMARY KEY  CLUSTERED (RID)
)
GO

/****** EmpresaCFDRetencion ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDRetencion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDRetencion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCFDRetencion') and type = 'U') 
CREATE TABLE dbo.EmpresaCFDRetencion (
	Empresa 				char(5) 		NOT NULL,
	
	Llave					varchar(255)	NULL,
	Certificado				varchar(255)	NULL,
	ContrasenaLlave			varchar(100)	NULL,
	ModoPruebas				bit				NULL		DEFAULT 0,
	
	TimbrarCFDIServidor		varchar(100)	NULL,
	TimbrarCFDIUsuario		varchar(100)	NULL,
	TimbrarCFDIPassword		varchar(100)	NULL,
	CancelarCFDIUsuario		varchar(100)	NULL,
    CancelarCFDIPassword    varchar(100)	NULL,    
    CancelarCFDIToken       varchar(100)	NULL,
    CancelarCFDICuenta      varchar(100)	NULL,   
    noCertificado			varchar(20)     NULL
	CONSTRAINT priEmpresaCFDRetencion PRIMARY KEY  CLUSTERED (Empresa)
)
GO

--BUG1068
EXEC spALTER_TABLE 'EmpresaCFDRetencion', 'RutaIntelisisCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDRetencion', 'TimeOutTimbrado', 'int NOT NULL DEFAULT 15000 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaCFDRetencion', 'RutaANSIToUTF', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDRetencion', 'RutaGenerarQRCode', 'varchar(255) NULL'
GO
--BUG25925
EXEC spALTER_TABLE 'EmpresaCFDRetencion', 'noCertificado', 'varchar(20) NULL'
GO

/****** CFDIRetencionImpuestoTipo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionImpuestoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionImpuestoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionImpuestoTipo') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionImpuestoTipo(
	Retencion			varchar(10),
	ClaveSAT			varchar(2),
	
	CONSTRAINT priCFDIRetencionImpuestoTipo PRIMARY KEY CLUSTERED(Retencion)
)
GO

/****** CFDIRetencionXMLCampo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionXMLCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionXMLCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionXMLCampo') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionXMLCampo(
	Version			varchar(5)		NOT NULL,
	CampoXML		varchar(100)	NOT NULL,
	CampoVista		varchar(100)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionXMLCampo PRIMARY KEY CLUSTERED(Version, CampoXML)
)
GO

/****** CFDIRetencionXMLPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionXMLPlantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionXMLPlantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionXMLPlantilla') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionXMLPlantilla(
	Version				varchar(5)		NOT NULL,
	Plantilla			varchar(max)	NULL,
	Vista				varchar(100)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionXMLPlantilla PRIMARY KEY CLUSTERED(Version)
)
GO

/****** CFDIRetencionXMLXSD ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionXMLXSD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetencionXMLXSD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionXMLXSD') and type = 'U') 
CREATE TABLE dbo.CFDIRetencionXMLXSD(
	Version			varchar(5)		NOT NULL,
	XSD				varchar(max)	NOT NULL,
	
	CONSTRAINT priCFDIRetencionXMLXSD PRIMARY KEY CLUSTERED(Version)
)
GO

/****** CFDIRetPagoConciliado ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetPagoConciliado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetPagoConciliado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetPagoConciliado') and type = 'U') 
  CREATE TABLE dbo.CFDIRetPagoConciliado(
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priCFDIRetPagoConciliado PRIMARY KEY CLUSTERED (RID)
)
GO

/****** CFDIRetGastoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetGastoAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetGastoAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetGastoAdicion') and type = 'U') 
  CREATE TABLE dbo.CFDIRetGastoAdicion(
	Mov					varchar(20),
		
	CONSTRAINT priCFDIRetGastoAdicion PRIMARY KEY CLUSTERED (Mov)
)
GO

/****** CFDIRetPagoClave ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetPagoClave')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetPagoClave','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetPagoClave') and type = 'U')
CREATE TABLE CFDIRetPagoClave(
    Clave			varchar(20),
	CONSTRAINT priCFDIRetPagoClave PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDIRetPagoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetPagoExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetPagoExcepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetPagoExcepcion') and type = 'U') 
  CREATE TABLE dbo.CFDIRetPagoExcepcion (
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priCFDIRetPagoExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

/****** CFDIRetPagoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetPagoAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetPagoAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetPagoAdicion') and type = 'U') 
  CREATE TABLE dbo.CFDIRetPagoAdicion (
    RID					int identity(1,1) NOT NULL,
	Mov					varchar(20) NULL,
    Aplica				varchar(20) NULL,	
	
	CONSTRAINT priCFDIRetPagoAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

/****** CFDIRetSATRetencion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATRetencion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATRetencion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATRetencion') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATRetencion (
    Clave			varchar(2),
    Retencion		varchar(255),
    
    CONSTRAINT priCFDIRetSATRetencion PRIMARY KEY CLUSTERED(Clave)
)
GO

EXEC spALTER_TABLE 'CFDIRetSATRetencion', 'Complemento', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CFDIRetSATRetencion', 'RetmontoTotGrav', 'money NULL'
EXEC spALTER_TABLE 'CFDIRetSATRetencion', 'RetmontoTotExent', 'money NULL'
GO

/****** CFDIRetSATDividendo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATDividendo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATDividendo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATDividendo') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATDividendo (
    Clave			varchar(2),
    Dividendo		varchar(255),
    
    CONSTRAINT priCFDIRetSATDividendo PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDIRetSATTipoContribuyente ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATTipoContribuyente')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATTipoContribuyente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATTipoContribuyente') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATTipoContribuyente (
    Clave			varchar(2),
    Sujeto			varchar(255),
    
    CONSTRAINT priCFDIRetSATTipoContribuyente PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDIRetSATPais ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATPais')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATPais','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATPais') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATPais (
    Clave			varchar(2),
    Pais			varchar(255),
    
    CONSTRAINT priCFDIRetSATPais PRIMARY KEY CLUSTERED(Clave)
)
GO

--BUG1067
EXEC spALTER_COLUMN 'CFDIRetSATPais', 'Clave', 'varchar(3) NOT NULL'
GO

/****** CFDIRetSATEstado ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATEstado') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATEstado (
    Clave			varchar(2),
    Estado			varchar(255),
    
    CONSTRAINT priCFDIRetSATEstado PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDIRetSATTipoImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetSATTipoImpuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDIRetSATTipoImpuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetSATTipoImpuesto') and type = 'U') 
  CREATE TABLE dbo.CFDIRetSATTipoImpuesto (
    Clave			varchar(2),
    Impuesto		varchar(255),
    
    CONSTRAINT priCFDIRetSATTipoImpuesto PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDIRetencionD ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CFDIRetencionD', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionD') and type = 'U') 
  CREATE TABLE CFDIRetencionD(
    RID					int			IDENTITY,
    EstacionTrabajo		int			NULL,
    Modulo				varchar(5)	NULL,
    ModuloID			int			NULL,
    Sucursal			int			NULL,
    Empresa				varchar(5)	NULL,
    Mov					varchar(20)	NULL,
    MovID				varchar(20)	NULL,
    ModuloPago			varchar(5)	NULL,
    IDPago				int			NULL,    
    Pago				varchar(20)	NULL,
    PagoID				varchar(20)	NULL,
    ImportePago			float		NULL,
    Proveedor			varchar(10)	NULL,
    Tasa				float		NULL,
    FechaEmision		datetime	NULL,
    FechaPago			datetime	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    Importe				float		NULL,
    IVA					float		NULL,
    IEPS				float		NULL,
    Retencion1			float		NULL,    
    Retencion2			float		NULL,
    Factor				float		NULL,    
    ConceptoClave		varchar(50) NULL,
    ConceptoSAT			varchar(50) NULL,
    Concepto			varchar(100)NULL,
    Ejerc				int			NULL,
    MesIni				int			NULL,
    MesFin				int			NULL,
    FolioInt			varchar(50)	NULL,
    montoTotExent		float		NULL,
    montoTotGrav		float		NULL,
    montoTotOperacion	float		NULL,
    montoTotRet			float		NULL,
    
    Ok					int			NULL,
    OkRef				varchar(255)NULL,
    CONSTRAINT priCFDIRetencionD PRIMARY KEY CLUSTERED(RID)
 )
GO

/****** CFDIRetSATIntereses ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CFDIRetSATIntereses')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CFDIRetSATIntereses','Movimiento','GAS')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIRetSATIntereses') AND type = 'U') 
BEGIN
      CREATE TABLE [dbo].[CFDIRetSATIntereses](
	      [ID]                [int]         NOT NULL,
	      [Version]           [varchar](5)  NOT NULL,
	      [SistFinanciero]    [varchar](5)  NOT NULL,
	      [RetiroAORESRetInt] [varchar](5)  NOT NULL,
	      [OperFinancDerivad] [varchar](5)  NOT NULL,
	      [MontIntNominal]    [float]       NOT NULL,
	      [MontIntReal]       [float]       NOT NULL,
	      [Perdida]           [float]       NOT NULL,
        CONSTRAINT [priCFDIRetSATIntereses] PRIMARY KEY CLUSTERED 
        (
	        [ID] ASC
        )
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
      ) ON [PRIMARY]
END
GO
/******************* Nuevos Campos CFDIRetSATIntereses **********************/
EXEC spALTER_TABLE 'CFDIRetSATIntereses', 'Gravado', 'float NULL'
EXEC spALTER_TABLE 'CFDIRetSATIntereses', 'Exento', 'float NULL'
GO

/****** CFDIEnajenacionGastoComplemento ******/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CFDIEnajenacionGastoComplemento') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CFDIEnajenacionGastoComplemento','Movimiento','GAS')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIEnajenacionGastoComplemento') AND TYPE = 'U') 
BEGIN
  CREATE TABLE dbo.CFDIEnajenacionGastoComplemento (
	ID 			int          NOT NULL,
	Clave		varchar(2)	 NULL,
	VersionXSD	varchar(5)   NOT NULL,
	Descripcion	varchar(300) NOT NULL,
	Ganancia	float		 NOT NULL,
	Perdida		float		 NOT NULL,
	
	CONSTRAINT priEnajenacionGasto PRIMARY KEY CLUSTERED (ID)
  )
END
GO
/******************* Nuevos Campos CFDIEnajenacionGastoComplemento **********************/
EXEC spALTER_TABLE 'CFDIEnajenacionGastoComplemento', 'Gravado', 'float NULL'
EXEC spALTER_TABLE 'CFDIEnajenacionGastoComplemento', 'Exento', 'float NULL'
GO


EXEC spADD_INDEX 'CFDIRetencionD', 'Proveedor', 'EstacionTrabajo, Proveedor'
EXEC spADD_INDEX 'CFDIRetencionD', 'Importe', 'Proveedor, EstacionTrabajo)INCLUDE(Importe, IVA, Retencion2'
GO

EXEC spALTER_TABLE 'CFDIRetencionD', 'DineroMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CFDIRetencionD', 'DineroMovID', 'varchar(20) NULL'

EXEC spALTER_COLUMN 'CFDIRetencionD', 'Concepto', 'varchar(100)NULL'
GO

EXEC spALTER_TABLE 'CFDIRetencionD', 'TipoTercero', 'varchar(20) NULL'
GO

--BUG1161
EXEC spALTER_TABLE 'CFDIRetencionD', 'PorcentajeDeducible', 'float NULL'
GO

EXEC spALTER_TABLE 'CFDIRetencionD', 'EsComplemento', 'bit NULL'
EXEC spALTER_TABLE 'CFDIRetencionD', 'EsRetencion', 'bit NULL'
EXEC spALTER_TABLE 'CFDIRetencionD', 'EsIEPS', 'bit NULL'
GO

/****** CFDIRetencion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CFDIRetencion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencion') and type = 'U') 
  CREATE TABLE CFDIRetencion(
    RID					int			IDENTITY,
    EstacionTrabajo		int			NULL,
    Modulo				varchar(5)	NULL,
    ModuloID			int			NULL,
    Sucursal			int			NULL,
    Empresa				varchar(5)	NULL,
    Mov					varchar(20)	NULL,
    MovID				varchar(20)	NULL,
    Proveedor			varchar(10)	NULL,
    ConceptoSAT			varchar(50)	NULL,
    FechaEmision		datetime	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    Importe				float		NULL,
    IVA					float		NULL,
    IEPS				float		NULL,
    Retencion1			float		NULL,    
    Retencion2			float		NULL,
    Ok					int			NULL,
    OkRef				varchar(255)NULL,

    CONSTRAINT priCFDIRetencion PRIMARY KEY CLUSTERED(RID)
 )
GO

/****** CFDIRetencionCalcTmp ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionCalcTmp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CFDIRetencionCalcTmp', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCalcTmp') and type = 'U') 
  CREATE TABLE CFDIRetencionCalcTmp(
    RID					int			IDENTITY,
    EstacionTrabajo		int			NULL,
    Modulo				varchar(5)	NULL,
    ModuloID			int			NULL,
    Sucursal			int			NULL,
    Empresa				varchar(5)	NULL,
    Mov					varchar(20)	NULL,
    MovID				varchar(20)	NULL,
    Proveedor			varchar(10)	NULL,
    ConceptoSAT			varchar(50)	NULL,
    FechaEmision		datetime	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    PorcentajeDeducible	float		NULL,
    Importe				float		NULL,
    IVA					float		NULL,
    IEPS				float		NULL,
    Retencion1			float		NULL,    
    Retencion2			float		NULL,
    Ok					int			NULL,
    OkRef				varchar(255)NULL,

    CONSTRAINT priCFDIRetencionCalcTmp PRIMARY KEY CLUSTERED(RID)
 )
GO

/****** CFDIRetencionImpuestoD ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionImpuestoD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CFDIRetencionImpuestoD', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionImpuestoD') and type = 'U') 
  CREATE TABLE CFDIRetencionImpuestoD(
    RID				int			IDENTITY,
    Modulo			varchar(5)	NOT NULL,
    ModuloID		int			NOT NULL,
    BaseRet			float		NULL,
    Impuesto		varchar(2)	NULL,
    montoRet		float		NULL,
    TipoPagoRet		varchar(20) NULL,
    
    CONSTRAINT priCFDIRetencionImpuestoD PRIMARY KEY CLUSTERED(RID)
 )
GO

/****** CFDIRetencionCfg ******/
if not exists(select * from SysTabla where SysTabla = 'CFDIRetencionCfg')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CFDIRetencionCfg', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCfg') and type = 'U') 
  CREATE TABLE CFDIRetencionCfg(
    RID					int			IDENTITY,
    Version				varchar(5)	NOT NULL,
    MovTimbrado			varchar(20)	NOT NULL,
    Concepto			varchar(50) NULL,
    
    CONSTRAINT priCFDIRetencionCfg PRIMARY KEY CLUSTERED(RID)
 )
GO

EXEC spALTER_TABLE 'CFDIRetencionCfg', 'RepConstancia', 'varchar(50) NOT NULL DEFAULT ''CFDIRetencionConstancia'''
GO

EXEC spALTER_TABLE 'CFDIRetencionCfg', 'PeriodosEspecificos', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'CFDIRetencionCfg', 'Ejerc', 'int NULL'
GO

EXEC spALTER_TABLE 'CFDIRetencionCfg', 'MesIni', 'int NULL'
GO

EXEC spALTER_TABLE 'CFDIRetencionCfg', 'MesFin', 'int NULL'
GO

/****** CFDRetencion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDRetencion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDRetencion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDRetencion') and type = 'U') 
CREATE TABLE CFDRetencion(
	Modulo				char(5)				NOT NULL,
	ModuloID			int					NOT NULL,
	Proveedor			varchar(10)			NOT NULL,
	ConceptoSAT			varchar(5)			NOT NULL,
	Fecha				datetime			NOT NULL,
	Ejercicio			int					NULL,
	Periodo				int					NULL,
	Empresa				char(5)				NULL,
	Mov					varchar(20)			NULL,	
	MovID				varchar(20)			NULL,
	Serie				varchar(10)			NULL,
    Folio				int					NULL,
	RFCEmisor			varchar(15)			NULL,
	RFCReceptor			varchar(15)			NULL,
	Aprobacion			varchar(15)			NULL,
	Importe				money				NULL,
	Impuesto1			money				NULL,
	Impuesto2			money				NULL,
	Retencion1			money				NULL,
	Retencion2			money				NULL,
	noCertificado		varchar(20)			NULL,
	Sello				varchar(max)		NULL,
	CadenaOriginal		varchar(max)		NULL,
	Documento			varchar(max)		NULL,
	GenerarPDF			bit					NULL DEFAULT 0,
	Timbrado			bit					NULL DEFAULT 0,
	UUID				uniqueidentifier	NULL,
	FechaTimbrado		datetime			NULL,
	Moneda				varchar(10)			NULL,
	TipoCambio			float				NULL,
    EsPago				bit					NOT NULL DEFAULT 0,	  	
	SelloSAT			varchar(max)		NULL,
    TFDVersion			varchar(10)			NULL,
    noCertificadoSAT	varchar(20)			NULL,
	TFDCadenaOriginal	varchar(max)		NULL,	
	VersionCFD			varchar(5)			NULL,
	SelloCancelacionSAT	varchar(max)		NULL,
	Cancelado			bit					NULL,
	AcuseCancelado		varchar(max)		NULL,
	RutaAcuse			varchar(200)		NULL,

	montoTotExent		float				NULL,
	montoTotGrav		float				NULL,
	montoTotOperacion	float				NULL,
	montoTotRet			float				NULL,
	
	ArchivoQRCode		varchar(255)		NULL,
	ArchivoXML			varchar(255)		NULL,
	ArchivoPDF			varchar(255)		NULL,

    Ejerc				int					NULL,
    MesIni				int					NULL,
    MesFin				int					NULL,
    
	CONSTRAINT priCFDRetencion PRIMARY KEY  CLUSTERED (ModuloID, Modulo, Proveedor, ConceptoSAT)
)
GO

EXEC spALTER_TABLE 'CFDRetencion', 'TimbradoCxpID', 'int NULL'
GO
--BUG8490
EXEC spALTER_COLUMN 'CFDRetencion', 'Sello', 'varchar(max) NULL'

EXEC spALTER_TABLE 'CFDRetencion', 'SelloCFD', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFDRetencion', 'SelloCFD', 'varchar(max) NULL'

EXEC spALTER_COLUMN 'CFDRetencion', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO

/****** CFDRetencionCancelado ******/
if not exists(select * from SysTabla where SysTabla = 'CFDRetencionCancelado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDRetencionCancelado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDRetencionCancelado') and type = 'U') 
CREATE TABLE CFDRetencionCancelado(
    RID					int					IDENTITY,
	Modulo				char(5)				NOT NULL,
	ModuloID			int					NOT NULL,
	Proveedor			varchar(10)			NOT NULL,
	ConceptoSAT			varchar(5)			NOT NULL,
	Fecha				datetime			NOT NULL,
	Ejercicio			int					NULL,
	Periodo				int					NULL,
	Empresa				char(5)				NULL,
	Mov					varchar(20)			NULL,	
	MovID				varchar(20)			NULL,
	Serie				varchar(10)			NULL,
    Folio				int					NULL,
	RFCEmisor			varchar(15)			NULL,
	RFCReceptor			varchar(15)			NULL,
	Aprobacion			varchar(15)			NULL,
	Importe				money				NULL,
	Impuesto1			money				NULL,
	Impuesto2			money				NULL,
	Retencion1			money				NULL,
	Retencion2			money				NULL,
	noCertificado		varchar(20)			NULL,
	Sello				varchar(max)		NULL,
	CadenaOriginal		varchar(max)		NULL,
	Documento			varchar(max)		NULL,
	GenerarPDF			bit					NULL DEFAULT 0,
	Timbrado			bit					NULL DEFAULT 0,
	UUID				uniqueidentifier	NULL,
	FechaTimbrado		datetime			NULL,
	Moneda				varchar(10)			NULL,
	TipoCambio			float				NULL,
    EsPago				bit					NOT NULL DEFAULT 0,	  	
	SelloSAT			varchar(max)		NULL,
    TFDVersion			varchar(10)			NULL,
    noCertificadoSAT	varchar(20)			NULL,
	TFDCadenaOriginal	varchar(max)		NULL,	
	VersionCFD			varchar(5)			NULL,
	FechaCancelacion	datetime			NULL,
	SelloCancelacionSAT	varchar(max)		NULL,
	Cancelado			bit					NULL,
	AcuseCancelado		varchar(max)		NULL,
	RutaAcuse			varchar(200)		NULL,

	montoTotExent		float				NULL,
	montoTotGrav		float				NULL,
	montoTotOperacion	float				NULL,
	montoTotRet			float				NULL,

	CONSTRAINT priCFDRetencionCancelado PRIMARY KEY  CLUSTERED (RID)
)
GO
--BUG8490
EXEC spALTER_COLUMN 'CFDRetencionCancelado', 'Sello', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFDRetencionCancelado', 'SelloSAT', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFDRetencionCancelado', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO

/************************************************** Vistas **********************************************************/
/*** CFDIRetFiscalRegimen ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetFiscalRegimen') and type = 'V') drop view dbo.CFDIRetFiscalRegimen
GO
CREATE VIEW CFDIRetFiscalRegimen
AS
  SELECT FiscalRegimen, 
	     Nombre, 
	     Descripcion, 
	     Extranjero
	FROM FiscalRegimen
GO

/*** CFDIRetencionProv ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionProv') and type = 'V') drop view dbo.CFDIRetencionProv
GO
CREATE VIEW CFDIRetencionProv
AS
  SELECT Proveedor,
		 Nombre,
		 Pais,
		 CFDIRetTipoContribuyente,
		 CFDIRetBeneficiarioNombre,
		 CFDIRetBeneficiarioCURP,
		 CFDIRetBeneficiarioRFC,
		 FiscalRegimen,
		 eMail1
    FROM Prov
   WHERE Tipo <> 'Estructura'
GO

/*** CFDIRetencionArt ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionArt') and type = 'V') drop view dbo.CFDIRetencionArt
GO
CREATE VIEW CFDIRetencionArt
AS
  SELECT Articulo, 
		 Descripcion1 Descripcion,
         CFDIRetClave,
         CFDIRetIEPSImpuesto
    FROM Art
   WHERE Tipo NOT IN('Estructura')
GO

/*** CFDIRetencionConcepto ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionConcepto') and type = 'V') drop view dbo.CFDIRetencionConcepto
GO
CREATE VIEW CFDIRetencionConcepto
AS
  SELECT Modulo, 
		 Concepto, 
		 CFDIRetClave
    FROM Concepto WHERE Modulo IN('GAS', 'COMSG')
GO

/*** CFDIRetencionDividendoCalc ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIRetencionDividendoCalc') AND type = 'V') DROP VIEW dbo.CFDIRetencionDividendoCalc
GO
CREATE VIEW CFDIRetencionDividendoCalc
AS
  SELECT CFDIRetencionD.Modulo, 
         CFDIRetencionD.ModuloID, 
         CFDIRetencionD.RID									                'RID',
		     CFDIRetencionD.Empresa								              'Empresa',
         CFDIRetencionD.Proveedor							              'Proveedor',
         ISNULL(CFDIRetencionD.EstacionTrabajo, 0)			    'EstacionTrabajo',
         ISNULL(CFDIRetencionD.ConceptoSAT, '')				      'ConceptoSAT',
         ISNULL(CFDIRetSATRetencion.Complemento, '')        'Complemento',
         ISNULL(CFDIRetencionCompXMLPlantilla.Version, '')  'Version',
		     CFDIRetGastoComplemento.CveTipDivOUtil				      'CveTipDivOUtil',
		 --BUG2008
		     CASE CFDIRetencionD.TipoTercero
		       WHEN 'Nacional'   THEN CONVERT(varchar(max), CONVERT(money, ISNULL(Retencion1, 0)))
		       ELSE                   CONVERT(varchar(max), CONVERT(money, ISNULL(0, 0)))
		     END                                                  'MontISRAcredRetMexico',
		 --BUG2008
		     CASE CFDIRetencionD.TipoTercero 
		       WHEN 'Extranjero' THEN CONVERT(varchar(max), CONVERT(money, ISNULL(Retencion1, 0)))
		       ELSE                   CONVERT(varchar(max), CONVERT(money, ISNULL(0, 0)))
		     END                                                'MontISRAcredRetExtranjero',
         CFDIRetGastoComplemento.MontRetExtDivExt          'MontRetExtDivExt',
		     CFDIRetGastoComplemento.TipoSocDistrDiv            'TipoSocDistrDiv',
		     CFDIRetGastoComplemento.MontISRAcredNal  	        'MontISRAcredNal',
		     CFDIRetGastoComplemento.MontDivAcumNal			        'MontDivAcumNal',
		     CFDIRetGastoComplemento.MontDivAcumExt  		        'MontDivAcumExt',
		     CFDIRetGastoComplemento.ProporcionRem			        'ProporcionRem'
    FROM CFDIRetencionD
    JOIN Empresa                                  ON CFDIRetencionD.Empresa = Empresa.Empresa
    JOIN Prov                                     ON CFDIRetencionD.Proveedor = Prov.Proveedor
    LEFT OUTER JOIN Pais                          ON Prov.Pais = Pais.Pais
    LEFT OUTER JOIN CFDIRetSATPais                ON Pais.CFDIRetClaveSat = CFDIRetSATPais.Clave
    LEFT OUTER JOIN CFDIRetSATTipoContribuyente   ON CFDIRetSATTipoContribuyente.Clave = Prov.CFDIRetTipoContribuyente
    LEFT OUTER JOIN CFDIRetSATRetencion           ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
    LEFT OUTER JOIN CFDIRetencionCompXMLPlantilla ON CFDIRetencionCompXMLPlantilla.Complemento = CFDIRetSATRetencion.Complemento
    LEFT OUTER JOIN CFDIRetencionArt a            ON CFDIRetencionD.Concepto = a.Articulo AND CFDIRetencionD.Modulo = 'COMS'
    LEFT OUTER JOIN CFDIRetencionConcepto c       ON CFDIRetencionD.Concepto = c.Concepto AND CFDIRetencionD.Modulo <> 'COMS'
    LEFT OUTER JOIN CFDIRetGastoComplemento       ON CFDIRetencionD.ModuloID = CFDIRetGastoComplemento.ID
   WHERE CFDIRetSATRetencion.Complemento = 'Dividendos'
     AND CFDIRetencionD.Modulo = 'GAS'
GO

/*** CFDIRetencionExtranjeroCalc ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIRetencionExtranjeroCalc') AND type = 'V') DROP VIEW dbo.CFDIRetencionExtranjeroCalc
GO
CREATE VIEW CFDIRetencionExtranjeroCalc
AS
  SELECT CFDIRetencionD.RID									              'RID',
		     CFDIRetencionD.Empresa								            'Empresa',
         CFDIRetencionD.Proveedor							            'Proveedor',
         ISNULL(CFDIRetencionD.EstacionTrabajo, 0)			  'EstacionTrabajo',
         ISNULL(CFDIRetencionD.ConceptoSAT, '')				    'ConceptoSAT',
         ISNULL(CFDIRetSATRetencion.Complemento, '')      'Complemento',
         ISNULL(Prov.CFDIRetTipoContribuyente, '')			  'ConceptoPago', 
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN ''
           ELSE ISNULL(Prov.CFDIRetTipoContribuyente, '')		
         END												                       'BConceptoPago',
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN CONVERT(char(30), '')
           ELSE ISNULL(Prov.CFDIRetBeneficiarioCURP, '')
         END												                       'CURP',
         ISNULL(CFDIRetSATTipoContribuyente.Sujeto, '')		 'DescripcionConcepto', 
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN ''
           ELSE ISNULL(CFDIRetSATTipoContribuyente.Sujeto, '')		  
         END												                        'BDescripcionConcepto', 
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN 'SI'									
           ELSE 'NO'
         END												                        'EsBenefEfectDelCobro', 
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN ''
           ELSE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
         END												                        'NomDenRazSocB',
         ISNULL(CFDIRetSATPais.Clave, '')					          'PaisDeResidParaEfecFisc', 
         CASE ISNULL(Prov.CFDIRetBeneficiarioNombre, '')
           WHEN '' THEN ''
           ELSE ISNULL(NULLIF(RTRIM(Prov.CFDIRetBeneficiarioRFC), ''), '')
         END												                        'RFC',
         ISNULL(CFDIRetencionCompXMLPlantilla.Version, '')	'Version'
    FROM CFDIRetencionD
    JOIN Empresa ON CFDIRetencionD.Empresa = Empresa.Empresa
    JOIN Prov ON CFDIRetencionD.Proveedor = Prov.Proveedor
    LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
    LEFT OUTER JOIN CFDIRetSATPais ON Pais.CFDIRetClaveSat = CFDIRetSATPais.Clave
    LEFT OUTER JOIN CFDIRetSATTipoContribuyente ON CFDIRetSATTipoContribuyente.Clave = Prov.CFDIRetTipoContribuyente
    LEFT OUTER JOIN CFDIRetSATRetencion ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
    LEFT OUTER JOIN CFDIRetencionCompXMLPlantilla ON CFDIRetencionCompXMLPlantilla.Complemento = CFDIRetSATRetencion.Complemento
   WHERE CFDIRetSATRetencion.Complemento = 'Extranjeros'
GO

/*** CFDIRetencionInteresesCalc ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDIRetencionInteresesCalc') AND type = 'V') DROP VIEW dbo.CFDIRetencionInteresesCalc
GO
CREATE VIEW CFDIRetencionInteresesCalc
AS
  SELECT CFDIRetencionD.Modulo, 
         CFDIRetencionD.ModuloID, 
         CFDIRetencionD.RID									                'RID',
		     CFDIRetencionD.Empresa								              'Empresa',
         CFDIRetencionD.Proveedor							              'Proveedor',
         ISNULL(CFDIRetencionD.EstacionTrabajo, 0)			    'EstacionTrabajo',
         ISNULL(CFDIRetencionD.ConceptoSAT, '')				      'ConceptoSAT',
         ISNULL(CFDIRetSATRetencion.Complemento, '')        'Complemento',
         ISNULL(CFDIRetencionCompXMLPlantilla.Version, '')  'Version',
		     CFDIRetSATIntereses.SistFinanciero                 'SistFinanciero',
         CFDIRetSATIntereses.RetiroAORESRetInt              'RetiroAORESRetInt',
         CFDIRetSATIntereses.OperFinancDerivad              'OperFinancDerivad',
         CFDIRetSATIntereses.MontIntNominal                 'MontIntNominal',
         CFDIRetSATIntereses.MontIntReal                    'MontIntReal',
         CFDIRetSATIntereses.Perdida                        'Perdida'
    FROM CFDIRetencionD
    JOIN Empresa ON CFDIRetencionD.Empresa = Empresa.Empresa
    LEFT OUTER JOIN CFDIRetSATRetencion ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
    LEFT OUTER JOIN CFDIRetencionCompXMLPlantilla ON CFDIRetencionCompXMLPlantilla.Complemento = CFDIRetSATRetencion.Complemento
    LEFT OUTER JOIN CFDIRetSATIntereses ON CFDIRetencionD.ModuloID = CFDIRetSATIntereses.ID
   WHERE CFDIRetSATRetencion.Complemento = 'INTERESES'
     AND CFDIRetencionD.Modulo = 'GAS'
GO

/*** CFDIRetencionEnajenacionAccionesCalc ***/
IF EXISTS (SELECT * FROM sysobjects where id = object_id('dbo.CFDIRetencionEnajenacionAccionesCalc') AND type = 'V') DROP VIEW dbo.CFDIRetencionEnajenacionAccionesCalc
GO
CREATE VIEW [dbo].[CFDIRetencionEnajenacionAccionesCalc]
AS
  SELECT CFDIRetencionD.Modulo, 
         CFDIRetencionD.ModuloID, 
         CFDIRetencionD.RID									                'RID',
		     CFDIRetencionD.Empresa								              'Empresa',    
         CFDIRetencionD.Proveedor							              'Proveedor',
         ISNULL(CFDIRetencionD.EstacionTrabajo, 0)			    'EstacionTrabajo',
         ISNULL(CFDIRetencionD.ConceptoSAT, '')				      'ConceptoSAT',
         ISNULL(CFDIRetSATRetencion.Complemento, '')        'Complemento',
         ISNULL(CFDIRetencionCompXMLPlantilla.Version, '')  'Version',
		     CFDIEnajenacionGastoComplemento.VersionXSD			    'VersionEnajenacion',
		     CFDIEnajenacionGastoComplemento.Descripcion		    'Descripcion',
		     CFDIEnajenacionGastoComplemento.Ganancia			      'Ganancia',
		     CFDIEnajenacionGastoComplemento.Perdida			      'Perdida'
    FROM CFDIRetencionD
    JOIN Empresa ON CFDIRetencionD.Empresa = Empresa.Empresa
    LEFT OUTER JOIN CFDIRetSATRetencion ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
    LEFT OUTER JOIN CFDIRetencionCompXMLPlantilla ON CFDIRetencionCompXMLPlantilla.Complemento = CFDIRetSATRetencion.Complemento
    LEFT OUTER JOIN CFDIEnajenacionGastoComplemento ON CFDIRetencionD.ModuloID = CFDIEnajenacionGastoComplemento.ID
   WHERE CFDIRetSATRetencion.Complemento = 'ENAJENACIONACCIONES'
     AND CFDIRetencionD.Modulo = 'GAS'
GO

/*** CFDIRetencionMovClaveCXPP ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionMovClaveCXPP') and type = 'V') drop view dbo.CFDIRetencionMovClaveCXPP
GO
CREATE VIEW CFDIRetencionMovClaveCXPP
AS
  SELECT * FROM MovClave WHERE Modulo = 'CXP'
GO

/*** CFDIRetencionPais ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionPais') and type = 'V') drop view dbo.CFDIRetencionPais
GO
CREATE VIEW CFDIRetencionPais
AS
  SELECT Pais, Clave, CFDIRetClaveSat
    FROM Pais
GO

/*** CFDIRetencionPaisEstado ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionPaisEstado') and type = 'V') drop view dbo.CFDIRetencionPaisEstado
GO
CREATE VIEW CFDIRetencionPaisEstado
AS
  SELECT Pais, Estado, Clave, CFDIRetClaveSat
    FROM PaisEstado
GO

/*** CFDIRetencionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDIRetencionCalc') and type = 'V') drop view dbo.CFDIRetencionCalc
GO
CREATE VIEW CFDIRetencionCalc
AS
  SELECT CFDIRetencionD.RID									  'RID',
		 CFDIRetencionD.Empresa								  'Empresa',
         CFDIRetencionD.Proveedor							  'Proveedor',
         ISNULL(CFDIRetencionD.EstacionTrabajo, 0)			  'EstacionTrabajo',
         ISNULL(CFDIRetencionD.ConceptoSAT, '')				  'ConceptoSAT',
		 ''													  'CURPE',
		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN 'Nacional' ELSE 'Extranjero' END 'Nacionalidad',
		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN ISNULL(Prov.CURP, '') ELSE '' END 'CURPR',
		 ISNULL(CFDIRetencionD.ConceptoSAT, '')				  'CveRetenc',
		 ''													  'DescRetenc',
		 ISNULL(CFDIRetencionD.Ejerc, 0)					  'Ejerc',
		 CONVERT(varchar(19),DATEADD(mi, -1, GETDATE()), 126)+'-06:00' 'FechaExp',
		 --CONVERT(varchar(19),DATEADD(mi, -1, GETDATE()), 126) 'FechaExp', 
		 ISNULL(CFDIRetencionD.FolioInt, '')				  'FolioInt',
		 ISNULL(CFDIRetencionD.MesFin, 0)					  'MesFin',
		 ISNULL(CFDIRetencionD.MesIni, 0)					  'MesIni',
         CONVERT(varchar(max), CONVERT(money, ISNULL(CFDIRetencionD.montoTotExent, 0)))		'montoTotExent',
         CONVERT(varchar(max), CONVERT(money, ISNULL(CFDIRetencionD.montoTotGrav, 0)))		'montoTotGrav',
         CONVERT(varchar(max), CONVERT(money, ISNULL(CFDIRetencionD.montoTotOperacion, 0)))	'montoTotOperacion',
         CONVERT(varchar(max), CONVERT(money, ISNULL(CFDIRetencionD.montoTotRet, 0)))		'montoTotRet',
		 ISNULL(Empresa.Nombre, '')							  'NomDenRazSocE',
		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN ISNULL(Prov.Nombre, '') ELSE '' END 'NomDenRazSocR',
		 CASE WHEN UsarTimbrarRetencion = 1 THEN ISNULL(EmpresaCFD.noCertificado, '')	 ELSE ISNULL(EmpresaCFDRetencion.noCertificado, '')  END 'NumCert',		 
		 ISNULL(Empresa.RFC, '')							  'RFCEmisor',
		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN ISNULL(Prov.RFC, '') ELSE '' END 'RFCRecep',
		 ISNULL(CFDIRetencionCfg.Version, '')				  'Version',

		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN '' ELSE ISNULL(Prov.RFC, '')    END 'NumRegIdTrib',
		 CASE Pais.CFDIRetClaveSat WHEN 'MX' THEN '' ELSE ISNULL(Prov.Nombre, '') END 'ENomDenRazSocR'
    FROM CFDIRetencionD
    JOIN Empresa ON CFDIRetencionD.Empresa = Empresa.Empresa
    JOIN Prov ON CFDIRetencionD.Proveedor = Prov.Proveedor
    LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
    JOIN EmpresaCFD ON Empresa.Empresa = EmpresaCFD.Empresa
    JOIN EmpresaCFDRetencion  ON Empresa.Empresa = EmpresaCFDRetencion.Empresa
    JOIN CFDIRetSATRetencion ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
    JOIN CFDIRetencionCfg ON 1=1    
GO

/************************************************** Registros **************************************************/
UPDATE EmpresaCFD SET EnviarAsuntoRetencion = 'Constancia de Retenciones', EnviarMensajeRetencion = 'Constancia de Retenciones, por Concepto de:

Emisor: <EmpresaNombre> (<EmpresaRFC>)
Receptor: <Nombre> (<RFC>)

Ejercicio: <Ejercicio>
Periodo Inicial: <PeriodoIni>
Periodo Final: <PeriodoFin>
Concepto: <Concepto> - <Retencion>'
GO

IF NOT EXISTS(SELECT * FROM FiscalRegimen)
BEGIN
  INSERT FiscalRegimen (FiscalRegimen) VALUES ('Persona Fisica')
  INSERT FiscalRegimen (FiscalRegimen) VALUES ('Persona Moral')
  INSERT FiscalRegimen (FiscalRegimen) VALUES ('PECOS')
  INSERT FiscalRegimen (FiscalRegimen) VALUES ('Sociedad Civil')
  INSERT FiscalRegimen (FiscalRegimen) VALUES ('Extranjero')
END
GO

/************************ D I V I D E N D O **************************/
--IF NOT EXISTS(SELECT * FROM MovClave WHERE Clave = 'GAS.ESTRETSAT')
--  INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) VALUES ('GAS',	'Complemento Ret SAT','GAS.EST','GAS.ESTRETSAT')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'GAS' AND Mov = 'Complemento Ret SAT')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('GAS', 930, 'Complemento Ret SAT', 'GAS.EST', 'GAS.ESTRETSAT', 'GAS', 'Complemento Ret SAT')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'GAS' AND Mov = 'Dividendo')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('GAS', NULL, 'Dividendo', 'GAS.G', 'GAS.DIV', 'GAS', 'Dividendo')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'CXP' AND Mov = 'Dividendo')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXP', NULL, 'Dividendo', 'CXP.F', NULL, 'GAS', 'Dividendo')
--GO

DELETE CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Dividendos'
GO
INSERT INTO CFDIRetencionCompXMLPlantilla(Complemento, Version, Vista, Plantilla) 
SELECT 'Dividendos', '1.0', 'CFDIRetencionDividendoCalc', '<dividendos:Dividendos Version="@Version" xmlns:dividendos="http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos" xsi:schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos/dividendos.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dividendos:DividOUtil CveTipDivOUtil="@CveTipDivOUtil" MontISRAcredRetMexico="@MontISRAcredRetMexico" MontISRAcredRetExtranjero="@MontISRAcredRetExtranjero" MontRetExtDivExt="@MontRetExtDivExt" TipoSocDistrDiv="@TipoSocDistrDiv" MontISRAcredNal="@MontISRAcredNal" MontDivAcumNal="@MontDivAcumNal" MontDivAcumExt="@MontDivAcumExt" />
  <dividendos:Remanente ProporcionRem="@ProporcionRem" />
</dividendos:Dividendos>'
GO

/************************ I N T E R E S E S **************************/
--Movimiento COMPLEMENTO INTERESES RETENCIONES SAT
--IF NOT EXISTS(SELECT * FROM MovClave WHERE Clave = 'GAS.ESTRETSATINT')
--  INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) VALUES ('GAS',	'Compl Inter Ret Sat','GAS.EST','GAS.ESTRETSATINT')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'GAS' AND Mov = 'Compl Inter Ret Sat')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('GAS', NULL, 'Compl Inter Ret Sat', 'GAS.EST', 'GAS.ESTRETSATINT', 'GAS', 'Compl Inter Ret Sat')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'GAS' AND Mov = 'Intereses Comp. Ret.')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('GAS', NULL, 'Intereses Comp. Ret.', 'GAS.G', 'GAS.INT', 'GAS', 'Gasto')
--GO
-- IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'CXP' AND Mov = 'Intereses Comp. Ret.')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('CXP', NULL, 'Intereses Comp. Ret.', 'CXP.F', NULL, 'GAS', 'Intereses Comp. Ret.')
--GO

/************************ E N A J E N A C I O N E S **************************/
--MOVIMEINTO DE COMPLEJO DE ENAJENACIONES
--IF NOT EXISTS(select * from MovClave WHERE Clave = 'GAS.ESTRETSATENEJAC')
--  INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) VALUES ('GAS', 'ComplEnajAccRetSat', 'GAS.EST', 'GAS.ESTRETSATENEJAC')
--GO

--IF NOT EXISTS(SELECT * FROM movtipo WHERE modulo = 'GAS' AND Mov = 'ComplEnajAccRetSat')
--  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('GAS', 35, 'ComplEnajAccRetSat', 'GAS.EST', 'GAS.ESTRETSATENEJAC', 'GAS', 'ComplEnajAccRetSat') 

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'GAS' AND Mov = 'Enajenacion')
--  insert MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('GAS', NULL, 'Enajenacion', 'GAS.G', 'GAS.ENJ', 'GAS', 'Gasto')
--GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'CXP' AND Mov = 'Enajenacion')
--  insert MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('CXP', NULL, 'Enajenacion', 'CXP.F', NULL, 'GAS', 'Enajenacion')
--GO

DELETE CFDIRetencionCompXMLXSD WHERE Complemento = 'Dividendos'
GO
INSERT INTO CFDIRetencionCompXMLXSD(Complemento, XSD) 
SELECT 'Dividendos', '<xs:schema xmlns:dividendos="http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="Dividendos">
		<xs:annotation>
			<xs:documentation>Complemento para  expresar  el total de  ganancias  y utilidades generadas por rendimientos en base a inversiones en instrumentos de inversión</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence minOccurs="0">
				<xs:element name="DividOUtil" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional que expresa los dividendos o utilidades distribuidas del periodo o ejercicio</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="CveTipDivOUtil" type="dividendos:c_TipoDividendoOUtilidadDistribuida" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la clave del tipo de dividendo o utilidad distribuida de acuerdo al catálogo.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="MontISRAcredRetMexico" type="dividendos:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el importe o retención  del dividendo o  utilidad en territorio nacional</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="MontISRAcredRetExtranjero" type="dividendos:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el importe o retención  del dividendo o  utilidad en territorio extranjero</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="MontRetExtDivExt" type="dividendos:t_Importe" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para expresar el monto de la retención en el extranjero sobre dividendos del extranjero</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="TipoSocDistrDiv" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido  para expresar si el dividendo es distribuido por sociedades nacionales o extranjeras.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:enumeration value="Sociedad Nacional"/>
									<xs:enumeration value="Sociedad Extranjera"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="MontISRAcredNal" type="dividendos:t_Importe" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para expresar el monto del ISR acreditable nacional</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="MontDivAcumNal" type="dividendos:t_Importe" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para expresar el monto del dividendo acumulable nacional</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="MontDivAcumExt" type="dividendos:t_Importe" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para expresar el monto del dividendo acumulable extranjero</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Remanente" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional que expresa el resultado obtenido de la diferencia entre ingresos y egresos de las personas morales que distribuyan anticipos o rendimientos o sociedades de producción, sociedades y asociaciones civiles.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="ProporcionRem" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional que expresa el porcentaje de participación de sus integrantes o accionistas</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:decimal">
									<xs:fractionDigits value="6"/>
									<xs:maxInclusive value="9999999999"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" use="required" fixed="1.0">
				<xs:annotation>
					<xs:documentation>Atributo requerido con valor prefijado que indica la versión del complemento de dividendos y/o dividendos distribuidos</xs:documentation>
				</xs:annotation>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
	<xs:simpleType name="t_Importe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar importes numéricos con fracción hasta seis decimales</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:decimal">
			<xs:fractionDigits value="6"/>
			<xs:whiteSpace value="collapse"/>
		</xs:restriction>
	</xs:simpleType>


	<xs:simpleType name="c_Retenciones">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoDividendoOUtilidadDistribuida">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoContribuyenteSujetoRetencion">
		<xs:restriction base="xs:string">
			<xs:enumeration value="1"/>
			<xs:enumeration value="2"/>
			<xs:enumeration value="3"/>
			<xs:enumeration value="4"/>
			<xs:enumeration value="5"/>
			<xs:enumeration value="6"/>
			<xs:enumeration value="7"/>
			<xs:enumeration value="8"/>
			<xs:enumeration value="9"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_Pais">
		<xs:restriction base="xs:string">
			<xs:enumeration value="AF"/>
			<xs:enumeration value="AL"/>
			<xs:enumeration value="DE"/>
			<xs:enumeration value="AD"/>
			<xs:enumeration value="AO"/>
			<xs:enumeration value="AI"/>
			<xs:enumeration value="AQ"/>
			<xs:enumeration value="AG"/>
			<xs:enumeration value="AN"/>
			<xs:enumeration value="SA"/>
			<xs:enumeration value="DZ"/>
			<xs:enumeration value="AR"/>
			<xs:enumeration value="AM"/>
			<xs:enumeration value="AW"/>
			<xs:enumeration value="AU"/>
			<xs:enumeration value="AT"/>
			<xs:enumeration value="AZ"/>
			<xs:enumeration value="BS"/>
			<xs:enumeration value="BH"/>
			<xs:enumeration value="BD"/>
			<xs:enumeration value="BB"/>
			<xs:enumeration value="BE"/>
			<xs:enumeration value="BZ"/>
			<xs:enumeration value="BJ"/>
			<xs:enumeration value="BM"/>
			<xs:enumeration value="BY"/>
			<xs:enumeration value="BO"/>
			<xs:enumeration value="BA"/>
			<xs:enumeration value="BW"/>
			<xs:enumeration value="BR"/>
			<xs:enumeration value="BN"/>
			<xs:enumeration value="BG"/>
			<xs:enumeration value="BF"/>
			<xs:enumeration value="BI"/>
			<xs:enumeration value="BT"/>
			<xs:enumeration value="CV"/>
			<xs:enumeration value="TD"/>
			<xs:enumeration value="KY"/>
			<xs:enumeration value="KH"/>
			<xs:enumeration value="CM"/>
			<xs:enumeration value="CA"/>
			<xs:enumeration value="CL"/>
			<xs:enumeration value="CN"/>
			<xs:enumeration value="CY"/>
			<xs:enumeration value="VA"/>
			<xs:enumeration value="CC"/>
			<xs:enumeration value="CO"/>
			<xs:enumeration value="KM"/>
			<xs:enumeration value="CG"/>
			<xs:enumeration value="CK"/>
			<xs:enumeration value="KP"/>
			<xs:enumeration value="KR"/>
			<xs:enumeration value="CI"/>
			<xs:enumeration value="CR"/>
			<xs:enumeration value="HR"/>
			<xs:enumeration value="CU"/>
			<xs:enumeration value="DK"/>
			<xs:enumeration value="DJ"/>
			<xs:enumeration value="DM"/>
			<xs:enumeration value="EC"/>
			<xs:enumeration value="EG"/>
			<xs:enumeration value="SV"/>
			<xs:enumeration value="AE"/>
			<xs:enumeration value="ER"/>
			<xs:enumeration value="SI"/>
			<xs:enumeration value="ES"/>
			<xs:enumeration value="FM"/>
			<xs:enumeration value="US"/>
			<xs:enumeration value="EE"/>
			<xs:enumeration value="ET"/>
			<xs:enumeration value="FJ"/>
			<xs:enumeration value="PH"/>
			<xs:enumeration value="FI"/>
			<xs:enumeration value="FR"/>
			<xs:enumeration value="GA"/>
			<xs:enumeration value="GM"/>
			<xs:enumeration value="GE"/>
			<xs:enumeration value="GH"/>
			<xs:enumeration value="GI"/>
			<xs:enumeration value="GD"/>
			<xs:enumeration value="GR"/>
			<xs:enumeration value="GL"/>
			<xs:enumeration value="GP"/>
			<xs:enumeration value="GU"/>
			<xs:enumeration value="GT"/>
			<xs:enumeration value="GG"/>
			<xs:enumeration value="GW"/>
			<xs:enumeration value="GQ"/>
			<xs:enumeration value="GN"/>
			<xs:enumeration value="GF"/>
			<xs:enumeration value="GY"/>
			<xs:enumeration value="HT"/>
			<xs:enumeration value="HN"/>
			<xs:enumeration value="HK"/>
			<xs:enumeration value="HU"/>
			<xs:enumeration value="IN"/>
			<xs:enumeration value="ID"/>
			<xs:enumeration value="IQ"/>
			<xs:enumeration value="IR"/>
			<xs:enumeration value="IE"/>
			<xs:enumeration value="IS"/>
			<xs:enumeration value="BV"/>
			<xs:enumeration value="IM"/>
			<xs:enumeration value="AX"/>
			<xs:enumeration value="FO"/>
			<xs:enumeration value="GS"/>
			<xs:enumeration value="HM"/>
			<xs:enumeration value="FK"/>
			<xs:enumeration value="MP"/>
			<xs:enumeration value="MH"/>
			<xs:enumeration value="UM"/>
			<xs:enumeration value="SB"/>
			<xs:enumeration value="SJ"/>
			<xs:enumeration value="TK"/>
			<xs:enumeration value="WF"/>
			<xs:enumeration value="IL"/>
			<xs:enumeration value="IT"/>
			<xs:enumeration value="JM"/>
			<xs:enumeration value="JP"/>
			<xs:enumeration value="JE"/>
			<xs:enumeration value="JO"/>
			<xs:enumeration value="KZ"/>
			<xs:enumeration value="KE"/>
			<xs:enumeration value="KI"/>
			<xs:enumeration value="KW"/>
			<xs:enumeration value="KG"/>
			<xs:enumeration value="LS"/>
			<xs:enumeration value="LV"/>
			<xs:enumeration value="LB"/>
			<xs:enumeration value="LR"/>
			<xs:enumeration value="LY"/>
			<xs:enumeration value="LI"/>
			<xs:enumeration value="LT"/>
			<xs:enumeration value="LU"/>
			<xs:enumeration value="MO"/>
			<xs:enumeration value="MK"/>
			<xs:enumeration value="MG"/>
			<xs:enumeration value="MY"/>
			<xs:enumeration value="MW"/>
			<xs:enumeration value="MV"/>
			<xs:enumeration value="ML"/>
			<xs:enumeration value="MT"/>
			<xs:enumeration value="MA"/>
			<xs:enumeration value="MQ"/>
			<xs:enumeration value="MU"/>
			<xs:enumeration value="MR"/>
			<xs:enumeration value="YT"/>
			<xs:enumeration value="MX"/>
			<xs:enumeration value="MD"/>
			<xs:enumeration value="MC"/>
			<xs:enumeration value="MN"/>
			<xs:enumeration value="MS"/>
			<xs:enumeration value="ME"/>
			<xs:enumeration value="MZ"/>
			<xs:enumeration value="MM"/>
			<xs:enumeration value="NA"/>
			<xs:enumeration value="NR"/>
			<xs:enumeration value="CX"/>
			<xs:enumeration value="NP"/>
			<xs:enumeration value="NI"/>
			<xs:enumeration value="NE"/>
			<xs:enumeration value="NG"/>
			<xs:enumeration value="NU"/>
			<xs:enumeration value="NF"/>
			<xs:enumeration value="NO"/>
			<xs:enumeration value="NC"/>
			<xs:enumeration value="NZ"/>
			<xs:enumeration value="OM"/>
			<xs:enumeration value="PIK"/>
			<xs:enumeration value="NL"/>
			<xs:enumeration value="PK"/>
			<xs:enumeration value="PW"/>
			<xs:enumeration value="PS"/>
			<xs:enumeration value="PA"/>
			<xs:enumeration value="PG"/>
			<xs:enumeration value="PY"/>
			<xs:enumeration value="PE"/>
			<xs:enumeration value="PN"/>
			<xs:enumeration value="PF"/>
			<xs:enumeration value="PL"/>
			<xs:enumeration value="PT"/>
			<xs:enumeration value="PR"/>
			<xs:enumeration value="QA"/>
			<xs:enumeration value="GB"/>
			<xs:enumeration value="CZ"/>
			<xs:enumeration value="CF"/>
			<xs:enumeration value="LA"/>
			<xs:enumeration value="RS"/>
			<xs:enumeration value="DO"/>
			<xs:enumeration value="SK"/>
			<xs:enumeration value="CD"/>
			<xs:enumeration value="RW"/>
			<xs:enumeration value="RE"/>
			<xs:enumeration value="RO"/>
			<xs:enumeration value="RU"/>
			<xs:enumeration value="EH"/>
			<xs:enumeration value="WS"/>
			<xs:enumeration value="AS"/>
			<xs:enumeration value="BL"/>
			<xs:enumeration value="KN"/>
			<xs:enumeration value="SM"/>
			<xs:enumeration value="MF"/>
			<xs:enumeration value="PM"/>
			<xs:enumeration value="VC"/>
			<xs:enumeration value="SH"/>
			<xs:enumeration value="LC"/>
			<xs:enumeration value="ST"/>
			<xs:enumeration value="SN"/>
			<xs:enumeration value="SC"/>
			<xs:enumeration value="SL"/>
			<xs:enumeration value="SG"/>
			<xs:enumeration value="SY"/>
			<xs:enumeration value="SO"/>
			<xs:enumeration value="LK"/>
			<xs:enumeration value="ZA"/>
			<xs:enumeration value="SD"/>
			<xs:enumeration value="SE"/>
			<xs:enumeration value="CH"/>
			<xs:enumeration value="SR"/>
			<xs:enumeration value="SZ"/>
			<xs:enumeration value="TJ"/>
			<xs:enumeration value="TH"/>
			<xs:enumeration value="TW"/>
			<xs:enumeration value="TZ"/>
			<xs:enumeration value="IO"/>
			<xs:enumeration value="TF"/>
			<xs:enumeration value="TL"/>
			<xs:enumeration value="TG"/>
			<xs:enumeration value="TO"/>
			<xs:enumeration value="TT"/>
			<xs:enumeration value="TN"/>
			<xs:enumeration value="TC"/>
			<xs:enumeration value="TM"/>
			<xs:enumeration value="TR"/>
			<xs:enumeration value="TV"/>
			<xs:enumeration value="UA"/>
			<xs:enumeration value="UG"/>
			<xs:enumeration value="UY"/>
			<xs:enumeration value="UZ"/>
			<xs:enumeration value="VU"/>
			<xs:enumeration value="VE"/>
			<xs:enumeration value="VN"/>
			<xs:enumeration value="VG"/>
			<xs:enumeration value="VI"/>
			<xs:enumeration value="YE"/>
			<xs:enumeration value="ZM"/>
			<xs:enumeration value="ZW"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_EntidadesFederativas">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
			<xs:enumeration value="26"/>
			<xs:enumeration value="27"/>
			<xs:enumeration value="28"/>
			<xs:enumeration value="29"/>
			<xs:enumeration value="30"/>
			<xs:enumeration value="31"/>
			<xs:enumeration value="32"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoImpuesto">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
		</xs:restriction>
	</xs:simpleType>	
</xs:schema>
'
GO

DELETE CFDIRetencionCompXMLCampo WHERE Complemento = 'Dividendos'
GO
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@Version', 'Version'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@CveTipDivOUtil', 'CveTipDivOUtil'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontISRAcredRetMexico', 'MontISRAcredRetMexico'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontISRAcredRetExtranjero', 'MontISRAcredRetExtranjero'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontRetExtDivExt', 'MontRetExtDivExt'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@TipoSocDistrDiv', 'TipoSocDistrDiv'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontISRAcredNal', 'MontISRAcredNal'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontDivAcumNal', 'MontDivAcumNal'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@MontDivAcumExt', 'MontDivAcumExt'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Dividendos', '@ProporcionRem', 'ProporcionRem'
GO

DELETE CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Extranjeros'
GO
INSERT INTO CFDIRetencionCompXMLPlantilla(Complemento, Version, Vista, Plantilla) 
SELECT 'Extranjeros', '1.0', 'CFDIRetencionExtranjeroCalc', '<pagosaextranjeros:Pagosaextranjeros Version="@Version" EsBenefEfectDelCobro="@EsBenefEfectDelCobro" xmlns:pagosaextranjeros="http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros" xsi:schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros/pagosaextranjeros.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" >
  <pagosaextranjeros:NoBeneficiario PaisDeResidParaEfecFisc="@PaisDeResidParaEfecFisc" ConceptoPago="@ConceptoPago" DescripcionConcepto="@DescripcionConcepto" />
  <pagosaextranjeros:Beneficiario RFC="@RFC" CURP="@CURP" NomDenRazSocB="@NomDenRazSocB" ConceptoPago="@BConceptoPago" DescripcionConcepto="@BDescripcionConcepto" />
</pagosaextranjeros:Pagosaextranjeros>'
GO

DELETE CFDIRetencionCompXMLXSD WHERE Complemento = 'Extranjeros'
GO
INSERT INTO CFDIRetencionCompXMLXSD(Complemento, XSD) 
SELECT 'Extranjeros', '<xs:schema xmlns:pagosaextranjeros="http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="Pagosaextranjeros">
		<xs:annotation>
			<xs:documentation>Complemento para expresar los pagos que se realizan a residentes en el extranjero</xs:documentation>
		</xs:annotation>         
		<xs:complexType>
			<xs:sequence minOccurs="0">
				<xs:element name="NoBeneficiario" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar la información del residente extranjero efectivo del cobro</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="PaisDeResidParaEfecFisc" type="pagosaextranjeros:c_Pais" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la clave del país de residencia del extranjero, conforme al catálogo de países publicado en el Anexo 10 de la RMF. </xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="ConceptoPago" type="pagosaextranjeros:c_TipoContribuyenteSujetoRetencion" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar  el tipo contribuyente sujeto a la retención, conforme al catálogo.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="DescripcionConcepto" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la descripción de la definición del pago del residente en el extranjero</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="255"/>
									<xs:whiteSpace value="collapse"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Beneficiario" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para precisar la información del representante para efectos fiscales en México</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="RFC" type="pagosaextranjeros:t_RFC" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la clave del registro federal de contribuyentes del representante legal en México</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="CURP" type="pagosaextranjeros:t_CURP" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para la expresión de la CURP del representante legal</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="NomDenRazSocB" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el nombre, denominación o razón social del contribuyente en México</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="300"/>
									<xs:whiteSpace value="collapse"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="ConceptoPago" type="pagosaextranjeros:c_TipoContribuyenteSujetoRetencion" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el tipo de contribuyente sujeto a la retención, conforme al catálogo.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="DescripcionConcepto" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la descripción de la definición del pago del residente en el extranjero</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="255"/>
									<xs:whiteSpace value="collapse"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" use="required" fixed="1.0">
				<xs:annotation>
					<xs:documentation>Atributo requerido con valor prefijado que indica la versión del complemento de pagos realizados a residentes a residentes en el extranjero</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="EsBenefEfectDelCobro" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar si el beneficiario del pago es la misma persona que retiene</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:whiteSpace value="collapse"/>
						<xs:enumeration value="SI"/>
						<xs:enumeration value="NO"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
	<xs:simpleType name="t_RFC">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar claves del Registro Federal de Contribuyentes</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:minLength value="12"/>
			<xs:maxLength value="13"/>
			<xs:whiteSpace value="collapse"/>
			<xs:pattern value="[A-Z,Ñ,&amp;]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9][A-Z,0-9][0-9,A-Z]"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="t_CURP">
		<xs:annotation>
			<xs:documentation>Tipo definido para la expresión de una CURP</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:whiteSpace value="collapse"/>
			<xs:length value="18"/>
			<xs:pattern value="[A-Z][A,E,I,O,U,X][A-Z]{2}[0-9]{2}[0-1][0-9][0-3][0-9][M,H][A-Z]{2}[B,C,D,F,G,H,J,K,L,M,N,Ñ,P,Q,R,S,T,V,W,X,Y,Z]{3}[0-9,A-Z][0-9]"/>
		</xs:restriction>
	</xs:simpleType>
	
	<xs:simpleType name="Pagosaextranjeros">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoDividendoOUtilidadDistribuida">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoContribuyenteSujetoRetencion">
		<xs:restriction base="xs:string">
			<xs:enumeration value="1"/>
			<xs:enumeration value="2"/>
			<xs:enumeration value="3"/>
			<xs:enumeration value="4"/>
			<xs:enumeration value="5"/>
			<xs:enumeration value="6"/>
			<xs:enumeration value="7"/>
			<xs:enumeration value="8"/>
			<xs:enumeration value="9"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_Pais">
		<xs:restriction base="xs:string">
			<xs:enumeration value="AF"/>
			<xs:enumeration value="AL"/>
			<xs:enumeration value="DE"/>
			<xs:enumeration value="AD"/>
			<xs:enumeration value="AO"/>
			<xs:enumeration value="AI"/>
			<xs:enumeration value="AQ"/>
			<xs:enumeration value="AG"/>
			<xs:enumeration value="AN"/>
			<xs:enumeration value="SA"/>
			<xs:enumeration value="DZ"/>
			<xs:enumeration value="AR"/>
			<xs:enumeration value="AM"/>
			<xs:enumeration value="AW"/>
			<xs:enumeration value="AU"/>
			<xs:enumeration value="AT"/>
			<xs:enumeration value="AZ"/>
			<xs:enumeration value="BS"/>
			<xs:enumeration value="BH"/>
			<xs:enumeration value="BD"/>
			<xs:enumeration value="BB"/>
			<xs:enumeration value="BE"/>
			<xs:enumeration value="BZ"/>
			<xs:enumeration value="BJ"/>
			<xs:enumeration value="BM"/>
			<xs:enumeration value="BY"/>
			<xs:enumeration value="BO"/>
			<xs:enumeration value="BA"/>
			<xs:enumeration value="BW"/>
			<xs:enumeration value="BR"/>
			<xs:enumeration value="BN"/>
			<xs:enumeration value="BG"/>
			<xs:enumeration value="BF"/>
			<xs:enumeration value="BI"/>
			<xs:enumeration value="BT"/>
			<xs:enumeration value="CV"/>
			<xs:enumeration value="TD"/>
			<xs:enumeration value="KY"/>
			<xs:enumeration value="KH"/>
			<xs:enumeration value="CM"/>
			<xs:enumeration value="CA"/>
			<xs:enumeration value="CL"/>
			<xs:enumeration value="CN"/>
			<xs:enumeration value="CY"/>
			<xs:enumeration value="VA"/>
			<xs:enumeration value="CC"/>
			<xs:enumeration value="CO"/>
			<xs:enumeration value="KM"/>
			<xs:enumeration value="CG"/>
			<xs:enumeration value="CK"/>
			<xs:enumeration value="KP"/>
			<xs:enumeration value="KR"/>
			<xs:enumeration value="CI"/>
			<xs:enumeration value="CR"/>
			<xs:enumeration value="HR"/>
			<xs:enumeration value="CU"/>
			<xs:enumeration value="DK"/>
			<xs:enumeration value="DJ"/>
			<xs:enumeration value="DM"/>
			<xs:enumeration value="EC"/>
			<xs:enumeration value="EG"/>
			<xs:enumeration value="SV"/>
			<xs:enumeration value="AE"/>
			<xs:enumeration value="ER"/>
			<xs:enumeration value="SI"/>
			<xs:enumeration value="ES"/>
			<xs:enumeration value="FM"/>
			<xs:enumeration value="US"/>
			<xs:enumeration value="EE"/>
			<xs:enumeration value="ET"/>
			<xs:enumeration value="FJ"/>
			<xs:enumeration value="PH"/>
			<xs:enumeration value="FI"/>
			<xs:enumeration value="FR"/>
			<xs:enumeration value="GA"/>
			<xs:enumeration value="GM"/>
			<xs:enumeration value="GE"/>
			<xs:enumeration value="GH"/>
			<xs:enumeration value="GI"/>
			<xs:enumeration value="GD"/>
			<xs:enumeration value="GR"/>
			<xs:enumeration value="GL"/>
			<xs:enumeration value="GP"/>
			<xs:enumeration value="GU"/>
			<xs:enumeration value="GT"/>
			<xs:enumeration value="GG"/>
			<xs:enumeration value="GW"/>
			<xs:enumeration value="GQ"/>
			<xs:enumeration value="GN"/>
			<xs:enumeration value="GF"/>
			<xs:enumeration value="GY"/>
			<xs:enumeration value="HT"/>
			<xs:enumeration value="HN"/>
			<xs:enumeration value="HK"/>
			<xs:enumeration value="HU"/>
			<xs:enumeration value="IN"/>
			<xs:enumeration value="ID"/>
			<xs:enumeration value="IQ"/>
			<xs:enumeration value="IR"/>
			<xs:enumeration value="IE"/>
			<xs:enumeration value="IS"/>
			<xs:enumeration value="BV"/>
			<xs:enumeration value="IM"/>
			<xs:enumeration value="AX"/>
			<xs:enumeration value="FO"/>
			<xs:enumeration value="GS"/>
			<xs:enumeration value="HM"/>
			<xs:enumeration value="FK"/>
			<xs:enumeration value="MP"/>
			<xs:enumeration value="MH"/>
			<xs:enumeration value="UM"/>
			<xs:enumeration value="SB"/>
			<xs:enumeration value="SJ"/>
			<xs:enumeration value="TK"/>
			<xs:enumeration value="WF"/>
			<xs:enumeration value="IL"/>
			<xs:enumeration value="IT"/>
			<xs:enumeration value="JM"/>
			<xs:enumeration value="JP"/>
			<xs:enumeration value="JE"/>
			<xs:enumeration value="JO"/>
			<xs:enumeration value="KZ"/>
			<xs:enumeration value="KE"/>
			<xs:enumeration value="KI"/>
			<xs:enumeration value="KW"/>
			<xs:enumeration value="KG"/>
			<xs:enumeration value="LS"/>
			<xs:enumeration value="LV"/>
			<xs:enumeration value="LB"/>
			<xs:enumeration value="LR"/>
			<xs:enumeration value="LY"/>
			<xs:enumeration value="LI"/>
			<xs:enumeration value="LT"/>
			<xs:enumeration value="LU"/>
			<xs:enumeration value="MO"/>
			<xs:enumeration value="MK"/>
			<xs:enumeration value="MG"/>
			<xs:enumeration value="MY"/>
			<xs:enumeration value="MW"/>
			<xs:enumeration value="MV"/>
			<xs:enumeration value="ML"/>
			<xs:enumeration value="MT"/>
			<xs:enumeration value="MA"/>
			<xs:enumeration value="MQ"/>
			<xs:enumeration value="MU"/>
			<xs:enumeration value="MR"/>
			<xs:enumeration value="YT"/>
			<xs:enumeration value="MX"/>
			<xs:enumeration value="MD"/>
			<xs:enumeration value="MC"/>
			<xs:enumeration value="MN"/>
			<xs:enumeration value="MS"/>
			<xs:enumeration value="ME"/>
			<xs:enumeration value="MZ"/>
			<xs:enumeration value="MM"/>
			<xs:enumeration value="NA"/>
			<xs:enumeration value="NR"/>
			<xs:enumeration value="CX"/>
			<xs:enumeration value="NP"/>
			<xs:enumeration value="NI"/>
			<xs:enumeration value="NE"/>
			<xs:enumeration value="NG"/>
			<xs:enumeration value="NU"/>
			<xs:enumeration value="NF"/>
			<xs:enumeration value="NO"/>
			<xs:enumeration value="NC"/>
			<xs:enumeration value="NZ"/>
			<xs:enumeration value="OM"/>
			<xs:enumeration value="PIK"/>
			<xs:enumeration value="NL"/>
			<xs:enumeration value="PK"/>
			<xs:enumeration value="PW"/>
			<xs:enumeration value="PS"/>
			<xs:enumeration value="PA"/>
			<xs:enumeration value="PG"/>
			<xs:enumeration value="PY"/>
			<xs:enumeration value="PE"/>
			<xs:enumeration value="PN"/>
			<xs:enumeration value="PF"/>
			<xs:enumeration value="PL"/>
			<xs:enumeration value="PT"/>
			<xs:enumeration value="PR"/>
			<xs:enumeration value="QA"/>
			<xs:enumeration value="GB"/>
			<xs:enumeration value="CZ"/>
			<xs:enumeration value="CF"/>
			<xs:enumeration value="LA"/>
			<xs:enumeration value="RS"/>
			<xs:enumeration value="DO"/>
			<xs:enumeration value="SK"/>
			<xs:enumeration value="CD"/>
			<xs:enumeration value="RW"/>
			<xs:enumeration value="RE"/>
			<xs:enumeration value="RO"/>
			<xs:enumeration value="RU"/>
			<xs:enumeration value="EH"/>
			<xs:enumeration value="WS"/>
			<xs:enumeration value="AS"/>
			<xs:enumeration value="BL"/>
			<xs:enumeration value="KN"/>
			<xs:enumeration value="SM"/>
			<xs:enumeration value="MF"/>
			<xs:enumeration value="PM"/>
			<xs:enumeration value="VC"/>
			<xs:enumeration value="SH"/>
			<xs:enumeration value="LC"/>
			<xs:enumeration value="ST"/>
			<xs:enumeration value="SN"/>
			<xs:enumeration value="SC"/>
			<xs:enumeration value="SL"/>
			<xs:enumeration value="SG"/>
			<xs:enumeration value="SY"/>
			<xs:enumeration value="SO"/>
			<xs:enumeration value="LK"/>
			<xs:enumeration value="ZA"/>
			<xs:enumeration value="SD"/>
			<xs:enumeration value="SE"/>
			<xs:enumeration value="CH"/>
			<xs:enumeration value="SR"/>
			<xs:enumeration value="SZ"/>
			<xs:enumeration value="TJ"/>
			<xs:enumeration value="TH"/>
			<xs:enumeration value="TW"/>
			<xs:enumeration value="TZ"/>
			<xs:enumeration value="IO"/>
			<xs:enumeration value="TF"/>
			<xs:enumeration value="TL"/>
			<xs:enumeration value="TG"/>
			<xs:enumeration value="TO"/>
			<xs:enumeration value="TT"/>
			<xs:enumeration value="TN"/>
			<xs:enumeration value="TC"/>
			<xs:enumeration value="TM"/>
			<xs:enumeration value="TR"/>
			<xs:enumeration value="TV"/>
			<xs:enumeration value="UA"/>
			<xs:enumeration value="UG"/>
			<xs:enumeration value="UY"/>
			<xs:enumeration value="UZ"/>
			<xs:enumeration value="VU"/>
			<xs:enumeration value="VE"/>
			<xs:enumeration value="VN"/>
			<xs:enumeration value="VG"/>
			<xs:enumeration value="VI"/>
			<xs:enumeration value="YE"/>
			<xs:enumeration value="ZM"/>
			<xs:enumeration value="ZW"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_EntidadesFederativas">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
			<xs:enumeration value="26"/>
			<xs:enumeration value="27"/>
			<xs:enumeration value="28"/>
			<xs:enumeration value="29"/>
			<xs:enumeration value="30"/>
			<xs:enumeration value="31"/>
			<xs:enumeration value="32"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoImpuesto">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
		</xs:restriction>
	</xs:simpleType>
	
</xs:schema>'
GO

DELETE CFDIRetencionCompXMLCampo WHERE Complemento = 'Extranjeros'
GO
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@Version', 'Version'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@EsBenefEfectDelCobro', 'EsBenefEfectDelCobro'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@PaisDeResidParaEfecFisc', 'PaisDeResidParaEfecFisc'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@ConceptoPago', 'ConceptoPago'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@DescripcionConcepto', 'DescripcionConcepto'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@RFC', 'RFC'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@CURP', 'CURP'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@NomDenRazSocB', 'NomDenRazSocB'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@BConceptoPago', 'BConceptoPago'
INSERT INTO CFDIRetencionCompXMLCampo(Complemento, CampoXML, CampoVista) SELECT 'Extranjeros', '@BDescripcionConcepto', 'BDescripcionConcepto'
GO

--PLANTILLA COMPLEMENTOS INTERESES SAT
DELETE CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Intereses'
GO
INSERT INTO CFDIRetencionCompXMLPlantilla(Complemento, Version, Vista, Plantilla) 
SELECT 'Intereses', '1.0', 'CFDIRetencionInteresesCalc', '<intereses:Intereses xmlns:intereses="http://www.sat.gob.mx/esquemas/retencionpago/1/intereses" xsi:schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1/intereses http://www.sat.gob.mx/esquemas/retencionpago/1/intereses/intereses.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="@Version"  SistFinanciero="@SistFinanciero" RetiroAORESRetInt="@RetiroAORESRetInt" OperFinancDerivad="@OperFinancDerivad" MontIntNominal="@MontIntNominal" MontIntReal="@MontIntReal" Perdida="@Perdida" />'
GO

--PLANTILLA XSD - INTERESES SAT - CFDI RETENCIONES
DELETE CFDIRetencionCompXMLXSD WHERE Complemento = 'Intereses'
GO
INSERT INTO CFDIRetencionCompXMLXSD(Complemento, XSD) 
SELECT 'Intereses','<xs:schema xmlns:intereses="http://www.sat.gob.mx/esquemas/retencionpago/1/intereses" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/esquemas/retencionpago/1/intereses" elementFormDefault="qualified" attributeFormDefault="unqualified">
            <xs:element name="Intereses">
                <xs:annotation>
                    <xs:documentation>Complemento para expresar los intereses obtenidos por rendimiento en inversiones</xs:documentation>
                </xs:annotation>
                <xs:complexType>
					<xs:attribute name="Version" use="required" fixed="1.0">
						<xs:annotation>
							<xs:documentation>Atributo requerido con valor prefijado que indica la versión del complemento de intereses obtenidos en el periodo o ejercicio</xs:documentation>
						</xs:annotation>
					</xs:attribute>
					<xs:attribute name="SistFinanciero" use="required">
						<xs:annotation>
							<xs:documentation>Atributo requerido para expresar si los interés obtenidos en el periodo o ejercicio provienen del sistema financiero</xs:documentation>
						</xs:annotation>
						<xs:simpleType>
							<xs:restriction base="xs:string">
								<xs:whiteSpace value="collapse"/>
								<xs:enumeration value="SI"/>
								<xs:enumeration value="NO"/>
							</xs:restriction>
						</xs:simpleType>
					</xs:attribute>
					<xs:attribute name="RetiroAORESRetInt" use="required">
						<xs:annotation>
							<xs:documentation>Atributo requerido para expresar si los intereses obtenidos fueron retirados en el periodo o ejercicio</xs:documentation>
						</xs:annotation>
						<xs:simpleType>
							<xs:restriction base="xs:string">
								<xs:whiteSpace value="collapse"/>
								<xs:enumeration value="SI"/>
								<xs:enumeration value="NO"/>
							</xs:restriction>
						</xs:simpleType>
					</xs:attribute>
					<xs:attribute name="OperFinancDerivad" use="required">
						<xs:annotation>
							<xs:documentation>Atributo requerido para expresar si los intereses obtenidos corresponden a operaciones financieras derivadas.</xs:documentation>
						</xs:annotation>
						<xs:simpleType>
							<xs:restriction base="xs:string">
								<xs:whiteSpace value="collapse"/>
								<xs:enumeration value="SI"/>
								<xs:enumeration value="NO"/>
							</xs:restriction>
						</xs:simpleType>
					</xs:attribute>
					<xs:attribute name="MontIntNominal" type="intereses:t_Importe" use="required">
						<xs:annotation>
							<xs:documentation>Atributo requerido para expresar el importe del interés Nóminal obtenido en un periodo o ejercicio</xs:documentation>
						</xs:annotation>
					</xs:attribute>
					<xs:attribute name="MontIntReal" type="intereses:t_Importe" use="required">
						<xs:annotation>
							<xs:documentation>Atributo requerido para expresar el monto de los intereses reales (diferencia que se obtiene restando al tipo de interés nominal y la tasa de inflación del periodo o ejercicio )</xs:documentation>
						</xs:annotation>
					</xs:attribute>
					<xs:attribute name="Perdida" type="intereses:t_Importe" use="required">
					<xs:annotation>
						<xs:documentation>Atributo requerido para expresar la pérdida por los intereses obtenidos en el periodo o ejercicio</xs:documentation>
					</xs:annotation>
					</xs:attribute>
				</xs:complexType>
			</xs:element>
			<xs:simpleType name="t_Importe">
					<xs:annotation>
						<xs:documentation>Tipo definido para expresar importes numéricos con fracción hasta seis decimales</xs:documentation>
					</xs:annotation>
				<xs:restriction base="xs:decimal">
					<xs:fractionDigits value="6"/>
					<xs:whiteSpace value="collapse"/>
				</xs:restriction>
			</xs:simpleType>
</xs:schema>'
GO

--CAMPOS DE PLANTILLA XML - INTERESES - CFDI RETENCIONES
DELETE CFDIRetencionCompXMLCampo WHERE Complemento = 'Intereses'
GO
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@Version','Version')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@MontIntNominal','MontIntNominal')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@MontIntReal','MontIntReal')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@OperFinancDerivad','OperFinancDerivad')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@Perdida','Perdida')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@RetiroAORESRetInt','RetiroAORESRetInt')
INSERT INTO CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('Intereses','@SistFinanciero','SistFinanciero')
GO

--PLANTILLA COMPLEMENTOS ENAJENACION DE ACCIONES - CFDI RETENCIONES
DELETE CFDIRetencionCompXMLPlantilla WHERE Complemento = 'EnajenacionAcciones'
GO
INSERT CFDIRetencionCompXMLPlantilla (Complemento, Version, Plantilla, Vista) 
  VALUES ('EnajenacionAcciones', '1.0', '<enajenaciondeacciones:EnajenaciondeAcciones xmlns:enajenaciondeacciones="http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones" xsi:schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones/enajenaciondeacciones.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" Version="@Version" 
  ContratoIntermediacion="@Descripcion" Ganancia="@Ganancia" Perdida="@Perdida" />', 'CFDIRetencionEnajenacionAccionesCalc')  
GO

--PLANTILLA XSD - ENAJENACION DE ACCIONES - CFDI RETENCIONES
DELETE CFDIRetencionCompXMLXSD WHERE Complemento = 'EnajenacionAcciones'
GO
INSERT INTO CFDIRetencionCompXMLXSD (Complemento, XSD)
	SELECT 'EnajenacionAcciones','<xs:schema xmlns:enajenaciondeacciones="http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="EnajenaciondeAcciones">
		<xs:annotation>
			<xs:documentation>Complemento para expresar la enajenación de acciones u operaciones de valores (incluye ganancia o pérdida).</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:attribute name="Version" use="required" fixed="1.0">
				<xs:annotation>
					<xs:documentation>Atributo requerido con valor prefijado que indica la versión del complemento de la enajenación de acciones u operaciones de valores</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="ContratoIntermediacion" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar la descripción del contrato de intermediación</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="300"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Ganancia" type="enajenaciondeacciones:t_Importe" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar la ganancia obtenida por la enajenación de acciones u operación de valores</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Perdida" type="enajenaciondeacciones:t_Importe" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar la pérdida en el contrato de intermediación</xs:documentation>
				</xs:annotation>
			</xs:attribute>
		</xs:complexType>
		</xs:element>
		<xs:simpleType name="t_Importe">
			<xs:annotation>
				<xs:documentation>Tipo definido para expresar importes numéricos con fracción hasta seis decimales</xs:documentation>
			</xs:annotation>
		<xs:restriction base="xs:decimal">
			<xs:fractionDigits value="6"/>
			<xs:whiteSpace value="collapse"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>'
GO

--CAMPOS DE PLANTILLA XML - ENAJENACION DE ACCIONES - CFDI RETENCIONES
DELETE CFDIRetencionCompXMLCampo WHERE Complemento = 'EnajenacionAcciones'
GO
INSERT CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('EnajenacionAcciones','@Version','Version')
INSERT CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('EnajenacionAcciones','@Descripcion','Descripcion')
INSERT CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('EnajenacionAcciones','@Ganancia','Ganancia')
INSERT CFDIRetencionCompXMLCampo (Complemento, CampoXML, CampoVista) VALUES ('EnajenacionAcciones','@Perdida','Perdida')
GO

IF NOT EXISTS (SELECT Mensaje FROM MensajeLista WHERE Mensaje = 60451) 
  insert MensajeLista (Mensaje,Descripcion) VALUES (60451, 'Ya existe un Movimiento de declaración para este Ejercicio, Periodo, Proveedor y Concepto') 
GO

DELETE CFDIRetencionImpuestoTipo
GO
INSERT INTO CFDIRetencionImpuestoTipo(Retencion, ClaveSAT) SELECT 'ISR', '01'
INSERT INTO CFDIRetencionImpuestoTipo(Retencion, ClaveSAT) SELECT 'IVA', '02'
INSERT INTO CFDIRetencionImpuestoTipo(Retencion, ClaveSAT) SELECT 'IEPS', '03'
GO

DELETE CFDIRetSATRetencion
GO
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '01', 'Servicios profesionales'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '02', 'Regalías por derechos de autor'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '03', 'Autotransporte terrestre de carga'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '04', 'Servicios prestados por comisionistas'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '05', 'Arrendamiento'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion, Complemento)  SELECT '06','Enajenación de acciones.', 'EnajenacionAcciones'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '07', 'Enajenación de bienes objeto de la LIEPS, a través de mediadores, agentes, representantes, corredores, consignatarios o distribuidores'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '08', 'Enajenación de bienes inmuebles consignada en escritura pública'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '09', 'Enajenación de otros bienes, no consignada en escritura pública'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '10', 'Adquisición de desperdicios industriales'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '11', 'Adquisición de bienes consignada en escritura pública'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '12', 'Adquisición de otros bienes, no consignada en escritura pública'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '13', 'Otros retiros de AFORE.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion, Complemento)  SELECT '14', 'Dividendos o utilidades distribuidas.', 'Dividendos'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '15', 'Remanente distribuible.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion, Complemento)  SELECT '16','Intereses.', 'Intereses'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '17', 'Arrendamiento en fideicomiso.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion, Complemento)  SELECT '18', 'Pagos realizados a favor de residentes en el extranjero.', 'Extranjeros'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '19', 'Enajenación de acciones u operaciones en bolsa de valores.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '20', 'Obtención de premios.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '21', 'Fideicomisos que no realizan actividades empresariales.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '22', 'Planes personales de retiro.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '23', 'Intereses reales deducibles por créditos hipotecarios.'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '24', 'Operaciones Financieras Derivadas de Capital'
INSERT INTO CFDIRetSATRetencion(Clave, Retencion)               SELECT '25', 'Otro tipo de retenciones'
GO

DELETE CFDIRetSATDividendo
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '01', 'Proviene de CUFIN'
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '02', 'No proviene de CUFIN'
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '03', 'Reembolso o reducción de capital'
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '04', 'Liquidación de la persona moral'
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '05', 'CUFINRE'
INSERT INTO CFDIRetSATDividendo(Clave, Dividendo) SELECT '06', 'Proviene de CUFIN al 31 de diciembre 2013.'
GO

DELETE CFDIRetSATTipoContribuyente
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '1', 'Artistas, deportistas y espectaculos publicos'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '2', 'Otras personas fisicas'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '3', 'Persona moral'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '4', 'Fideicomiso'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '5', 'Asociacion en participacion'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '6', 'Organizaciones Internacionales o de gobierno'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '7', 'Organizaciones exentas'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '8', 'Agentes pagadores'
INSERT INTO CFDIRetSATTipoContribuyente(Clave, Sujeto) SELECT '9', 'Otros'
GO

DELETE CFDIRetSATPais
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AF', 'AFGANISTAN (EMIRATO ISLAMICO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AL', 'ALBANIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DE', 'ALEMANIA (REPUBLICA FEDERAL DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AD', 'ANDORRA (PRINCIPADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AO', 'ANGOLA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AI', 'ANGUILA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AQ', 'ANTARTIDA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AG', 'ANTIGUA Y BARBUDA (COMUNIDAD BRITANICA DE NACIONES)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AN', 'ANTILLAS NEERLANDESAS (TERRITORIO HOLANDES DE ULTRAMAR)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SA', 'ARABIA SAUDITA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DZ', 'ARGELIA (REPUBLICA DEMOCRATICA Y POPULAR DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AR', 'ARGENTINA (REPUBLICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AM', 'ARMENIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AW', 'ARUBA (TERRITORIO HOLANDES DE ULTRAMAR)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AU', 'AUSTRALIA (COMUNIDAD DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AT', 'AUSTRIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AZ', 'AZERBAIJAN (REPUBLICA AZERBAIJANI)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BS', 'BAHAMAS (COMUNIDAD DE LAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BH', 'BAHREIN (ESTADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BD', 'BANGLADESH (REPUBLICA POPULAR DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BB', 'BARBADOS (COMUNIDAD BRITANICA DE NACIONES)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BE', 'BELGICA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BZ', 'BELICE'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BJ', 'BENIN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BM', 'BERMUDAS'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BY', 'BIELORRUSIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BO', 'BOLIVIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BA', 'BOSNIA Y HERZEGOVINA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BW', 'BOTSWANA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BR', 'BRASIL (REPUBLICA FEDERATIVA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BN', 'BRUNEI (ESTADO DE) (RESIDENCIA DE PAZ)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BG', 'BULGARIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BF', 'BURKINA FASO'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BI', 'BURUNDI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BT', 'BUTAN (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CV', 'CABO VERDE (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TD', 'CHAD (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KY', 'CAIMAN (ISLAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KH', 'CAMBOYA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CM', 'CAMERUN (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CA', 'CANADA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CL', 'CHILE (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CN', 'CHINA (REPUBLICA POPULAR)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CY', 'CHIPRE (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VA', 'CIUDAD DEL VATICANO (ESTADO DE LA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CC', 'COCOS (KEELING, ISLAS AUSTRALIANAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CO', 'COLOMBIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KM', 'COMORAS (ISLAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CG', 'CONGO (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CK', 'COOK (ISLAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KP', 'COREA (REPUBLICA POPULAR DEMOCRATICA DE) (COREA DEL NORTE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KR', 'COREA (REPUBLICA DE) (COREA DEL SUR)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CI', 'COSTA DE MARFIL (REPUBLICA DE LA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CR', 'COSTA RICA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HR', 'CROACIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CU', 'CUBA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DK', 'DINAMARCA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DJ', 'DJIBOUTI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DM', 'DOMINICA (COMUNIDAD DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'EC', 'ECUADOR (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'EG', 'EGIPTO (REPUBLICA ARABE DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SV', 'EL SALVADOR (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AE', 'EMIRATOS ARABES UNIDOS'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ER', 'ERITREA (ESTADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SI', 'ESLOVENIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ES', 'ESPAÑA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FM', 'ESTADO FEDERADO DE MICRONESIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'US', 'ESTADOS UNIDOS DE AMERICA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'EE', 'ESTONIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ET', 'ETIOPIA (REPUBLICA DEMOCRATICA FEDERAL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FJ', 'FIDJI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PH', 'FILIPINAS (REPUBLICA DE LAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FI', 'FINLANDIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FR', 'FRANCIA (REPUBLICA FRANCESA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GA', 'GABONESA (REPUBLICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GM', 'GAMBIA (REPUBLICA DE LA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GE', 'GEORGIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GH', 'GHANA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GI', 'GIBRALTAR (R.U.)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GD', 'GRANADA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GR', 'GRECIA (REPUBLICA HELENICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GL', 'GROENLANDIA (DINAMARCA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GP', 'GUADALUPE (DEPARTAMENTO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GU', 'GUAM (E.U.A.)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GT', 'GUATEMALA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GG', 'GUERNSEY'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GW', 'GUINEA-BISSAU (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GQ', 'GUINEA ECUATORIAL (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GN', 'GUINEA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GF', 'GUYANA FRANCESA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GY', 'GUYANA (REPUBLICA COOPERATIVA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HT', 'HAITI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HN', 'HONDURAS (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HK', 'HONG KONG (REGION ADMINISTRATIVA ESPECIAL DE LA REPUBLICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HU', 'HUNGRIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IN', 'INDIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ID', 'INDONESIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IQ', 'IRAK (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IR', 'IRAN (REPUBLICA ISLAMICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IE', 'IRLANDA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IS', 'ISLANDIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BV', 'ISLA BOUVET'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IM', 'ISLA DE MAN'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AX', 'ISLAS ALAND'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FO', 'ISLAS FEROE'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GS', 'ISLAS GEORGIA Y SANDWICH DEL SUR'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'HM', 'ISLAS HEARD Y MCDONALD'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'FK', 'ISLAS MALVINAS (R.U.)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MP', 'ISLAS MARIANAS SEPTENTRIONALES'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MH', 'ISLAS MARSHALL'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'UM', 'ISLAS MENORES DE ULTRAMAR DE ESTADOS UNIDOS DE AMERICA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SB', 'ISLAS SALOMON (COMUNIDAD BRITANICA DE NACIONES)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SJ', 'ISLAS SVALBARD Y JAN MAYEN (NORUEGA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TK', 'ISLAS TOKELAU'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'WF', 'ISLAS WALLIS Y FUTUNA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IL', 'ISRAEL (ESTADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IT', 'ITALIA (REPUBLICA ITALIANA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'JM', 'JAMAICA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'JP', 'JAPON'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'JE', 'JERSEY'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'JO', 'JORDANIA (REINO HACHEMITA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KZ', 'KAZAKHSTAN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KE', 'KENYA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KI', 'KIRIBATI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KW', 'KUWAIT (ESTADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KG', 'KYRGYZSTAN (REPUBLICA KIRGYZIA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LS', 'LESOTHO (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LV', 'LETONIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LB', 'LIBANO (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LR', 'LIBERIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LY', 'LIBIA (JAMAHIRIYA LIBIA ARABE POPULAR SOCIALISTA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LI', 'LIECHTENSTEIN (PRINCIPADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LT', 'LITUANIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LU', 'LUXEMBURGO (GRAN DUCADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MO', 'MACAO'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MK', 'MACEDONIA (ANTIGUA REPUBLICA YUGOSLAVA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MG', 'MADAGASCAR (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MY', 'MALASIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MW', 'MALAWI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MV', 'MALDIVAS (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ML', 'MALI (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MT', 'MALTA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MA', 'MARRUECOS (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MQ', 'MARTINICA (DEPARTAMENTO DE) (FRANCIA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MU', 'MAURICIO (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MR', 'MAURITANIA (REPUBLICA ISLAMICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'YT', 'MAYOTTE'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MX', 'MEXICO (ESTADOS UNIDOS MEXICANOS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MD', 'MOLDAVIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MC', 'MONACO (PRINCIPADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MN', 'MONGOLIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MS', 'MONSERRAT (ISLA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ME', 'MONTENEGRO'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MZ', 'MOZAMBIQUE (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MM', 'MYANMAR (UNION DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NA', 'NAMIBIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NR', 'NAURU'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CX', 'NAVIDAD (CHRISTMAS) (ISLAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NP', 'NEPAL (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NI', 'NICARAGUA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NE', 'NIGER (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NG', 'NIGERIA (REPUBLICA FEDERAL DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NU', 'NIVE (ISLA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NF', 'NORFOLK (ISLA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NO', 'NORUEGA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NC', 'NUEVA CALEDONIA (TERRITORIO FRANCES DE ULTRAMAR)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NZ', 'NUEVA ZELANDIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'OM', 'OMAN (SULTANATO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PIK','PACIFICO, ISLAS DEL (ADMON. E.U.A.)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'NL', 'PAISES BAJOS (REINO DE LOS) (HOLANDA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PK', 'PAKISTAN (REPUBLICA ISLAMICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PW', 'PALAU (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PS', 'PALESTINA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PA', 'PANAMA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PG', 'PAPUA NUEVA GUINEA (ESTADO INDEPENDIENTE DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PY', 'PARAGUAY (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PE', 'PERU (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PN', 'PITCAIRNS (ISLAS DEPENDENCIA BRITANICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PF', 'POLINESIA FRANCESA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PL', 'POLONIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PT', 'PORTUGAL (REPUBLICA PORTUGUESA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PR', 'PUERTO RICO (ESTADO LIBRE ASOCIADO DE LA COMUNIDAD DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'QA', 'QATAR (ESTADO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'GB', 'REINO UNIDO DE LA GRAN BRETAÑA E IRLANDA DEL NORTE'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CZ', 'REPUBLICA CHECA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CF', 'REPUBLICA CENTROAFRICANA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LA', 'REPUBLICA DEMOCRATICA POPULAR LAOS'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'RS', 'REPUBLICA DE SERBIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'DO', 'REPUBLICA DOMINICANA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SK', 'REPUBLICA ESLOVACA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CD', 'REPUBLICA POPULAR DEL CONGO'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'RW', 'REPUBLICA RUANDESA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'RE', 'REUNION (DEPARTAMENTO DE LA) (FRANCIA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'RO', 'RUMANIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'RU', 'RUSIA (FEDERACION RUSA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'EH', 'SAHARA OCCIDENTAL (REPUBLICA ARABE SAHARAVI DEMOCRATICA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'WS', 'SAMOA (ESTADO INDEPENDIENTE DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'AS', 'SAMOA AMERICANA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'BL', 'SAN BARTOLOME'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'KN', 'SAN CRISTOBAL Y NIEVES (FEDERACION DE) (SAN KITTS-NEVIS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SM', 'SAN MARINO (SERENISIMA REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'MF', 'SAN MARTIN'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'PM', 'SAN PEDRO Y MIQUELON'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VC', 'SAN VICENTE Y LAS GRANADINAS'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SH', 'SANTA ELENA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LC', 'SANTA LUCIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ST', 'SANTO TOME Y PRINCIPE (REPUBLICA DEMOCRATICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SN', 'SENEGAL (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SC', 'SEYCHELLES (REPUBLICA DE LAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SL', 'SIERRA LEONA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SG', 'SINGAPUR (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SY', 'SIRIA (REPUBLICA ARABE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SO', 'SOMALIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'LK', 'SRI LANKA (REPUBLICA DEMOCRATICA SOCIALISTA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ZA', 'SUDAFRICA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SD', 'SUDAN (REPUBLICA DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SE', 'SUECIA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'CH', 'SUIZA (CONFEDERACION)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SR', 'SURINAME (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'SZ', 'SWAZILANDIA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TJ', 'TADJIKISTAN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TH', 'TAILANDIA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TW', 'TAIWAN (REPUBLICA DE CHINA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TZ', 'TANZANIA (REPUBLICA UNIDA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'IO', 'TERRITORIOS BRITANICOS DEL OCEANO INDICO'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TF', 'TERRITORIOS FRANCESES, AUSTRALES Y ANTARTICOS'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TL', 'TIMOR ORIENTAL'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TG', 'TOGO (REPUBLICA TOGOLESA)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TO', 'TONGA (REINO DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TT', 'TRINIDAD Y TOBAGO (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TN', 'TUNEZ (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TC', 'TURCAS Y CAICOS (ISLAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TM', 'TURKMENISTAN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TR', 'TURQUIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'TV', 'TUVALU (COMUNIDAD BRITANICA DE NACIONES)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'UA', 'UCRANIA'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'UG', 'UGANDA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'UY', 'URUGUAY (REPUBLICA ORIENTAL DEL)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'UZ', 'UZBEJISTAN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VU', 'VANUATU'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VE', 'VENEZUELA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VN', 'VIETNAM (REPUBLICA SOCIALISTA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VG', 'VIRGENES. ISLAS (BRITANICAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'VI', 'VIRGENES. ISLAS (NORTEAMERICANAS)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'YE', 'YEMEN (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ZM', 'ZAMBIA (REPUBLICA DE)'
INSERT INTO CFDIRetSATPais(Clave, Pais) SELECT 'ZW', 'ZIMBABWE (REPUBLICA DE)'
GO

DELETE CFDIRetSATEstado
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '01', 'AGUASCALIENTES'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '02', 'BAJA CALIFORNIA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '03', 'BAJA CALIFORNIA SUR'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '04', 'CAMPECHE'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '05', 'COAHUILA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '06', 'COLIMA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '07', 'CHIAPAS'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '08', 'CHIHUAHUA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '09', 'DISTRITO FEDERAL'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '10', 'DURANGO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '11', 'GUANAJUATO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '12', 'GUERRERO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '13', 'HIDALGO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '14', 'JALISCO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '15', 'MEXICO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '16', 'MICHOACAN'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '17', 'MORELOS'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '18', 'NAYARIT'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '19', 'NUEVO LEON'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '20', 'OAXACA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '21', 'PUEBLA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '22', 'QUERETARO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '23', 'QUINTANA ROO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '24', 'SAN LUIS POTOSI'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '25', 'SINALOA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '26', 'SONORA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '27', 'TABASCO'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '28', 'TAMAULIPAS'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '29', 'TLAXCALA'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '30', 'VERACRUZ'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '31', 'YUCATAN'
INSERT INTO CFDIRetSATEstado(Clave, Estado) SELECT '32', 'ZACATECAS'
GO

DELETE CFDIRetSATTipoImpuesto
INSERT INTO CFDIRetSATTipoImpuesto(Clave, Impuesto) SELECT '01', 'ISR'
INSERT INTO CFDIRetSATTipoImpuesto(Clave, Impuesto) SELECT '02', 'IVA'
INSERT INTO CFDIRetSATTipoImpuesto(Clave, Impuesto) SELECT '03', 'IEPS'
GO

--IF NOT EXISTS(SELECT * FROM CFDIRetPagoClave)
--BEGIN
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.DP'
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.NCP'
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.P'
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.NC'
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.NET'  
--  INSERT INTO CFDIRetPagoClave(Clave) SELECT 'CXP.ANC'    
--END
--GO

--IF NOT EXISTS(SELECT * FROM CFDIRetGastoAdicion)
--BEGIN
--  INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.CCH', 'GAS.C')
--END
--GO

INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.EST') AND SubClave IN('GAS.ESTRETSAT') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.EST') AND SubClave IN('GAS.ESTRETSATINT') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.EST') AND SubClave IN('GAS.ESTRETSATENEJAC') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

--flujo completo 
INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.G') AND SubClave IN('GAS.DIV') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.G') AND SubClave IN('GAS.INT') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

INSERT INTO CFDIRetGastoAdicion SELECT Mov FROM MovTipo WHERE Modulo = 'GAS' AND Clave IN('GAS.G') AND SubClave IN('GAS.ENJ') AND Mov NOT IN(SELECT Mov FROM CFDIRetGastoAdicion)
GO

--IF NOT EXISTS(SELECT * FROM MovTipo WHERE Modulo = 'CXP' AND Mov = 'Timbrado Retencion')
--  insert MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) values ('CXP', 4050, 'Timbrado Retencion', 'CXP.EST', 'CXP', 'Timbrado Retencion')
--GO

IF NOT EXISTS(SELECT * FROM CFDIRetencionCfg)
BEGIN
  INSERT INTO CFDIRetencionCfg(Version, MovTimbrado) SELECT '1.0', 'Timbrado Retencion'
END
GO

DELETE CFDIRetencionXMLPlantilla WHERE Version = '1.0'
GO
INSERT INTO CFDIRetencionXMLPlantilla(Version, Vista, Plantilla) 
SELECT '1.0', 'CFDIRetencionCalc', '<retenciones:Retenciones Version="@Version" FolioInt="@FolioInt" Sello="" NumCert="@NumCert" Cert="" FechaExp="@FechaExp" CveRetenc="@CveRetenc" DescRetenc="@DescRetenc" xmlns:retenciones="http://www.sat.gob.mx/esquemas/retencionpago/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arrendamientoenfideicomiso="http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso" xmlns:dividendos="http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos" xmlns:enajenaciondeacciones="http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones" xmlns:fideicomisonoempresarial="http://www.sat.gob.mx/esquemas/retencionpago/1/fideicomisonoempresarial" xmlns:intereses="http://www.sat.gob.mx/esquemas/retencionpago/1/intereses" xmlns:intereseshipotecarios="http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios" xmlns:operacionesconderivados="http://www.sat.gob.mx/esquemas/retencionpago/1/operacionesconderivados" xmlns:pagosaextranjeros="http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros" xmlns:planesderetiro="http://www.sat.gob.mx/esquemas/retencionpago/1/planesderetiro" xmlns:premios="http://www.sat.gob.mx/esquemas/retencionpago/1/premios" xmlns:sectorfinanciero="http://www.sat.gob.mx/esquemas/retencionpago/1/sectorfinanciero" xsi:schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1 http://www.sat.gob.mx/esquemas/retencionpago/1/retencionpagov1.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso http://www.sat.gob.mx/esquemas/retencionpago/1/arrendamientoenfideicomiso/arrendamientoenfideicomiso.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos http://www.sat.gob.mx/esquemas/retencionpago/1/dividendos/dividendos.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones http://www.sat.gob.mx/esquemas/retencionpago/1/enajenaciondeacciones/enajenaciondeacciones.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/fideicomisonoempresarial http://www.sat.gob.mx/esquemas/retencionpago/1/fideicomisonoempresarial/fideicomisonoempresarial.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/intereses http://www.sat.gob.mx/esquemas/retencionpago/1/intereses/intereses.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios http://www.sat.gob.mx/esquemas/retencionpago/1/intereseshipotecarios/intereseshipotecarios.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/operacionesconderivados http://www.sat.gob.mx/esquemas/retencionpago/1/operacionesconderivados/operacionesconderivados.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros http://www.sat.gob.mx/esquemas/retencionpago/1/pagosaextranjeros/pagosaextranjeros.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/planesderetiro http://www.sat.gob.mx/esquemas/retencionpago/1/planesderetiro/planesderetiro.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/premios http://www.sat.gob.mx/esquemas/retencionpago/1/premios/premios.xsd http://www.sat.gob.mx/esquemas/retencionpago/1/sectorfinanciero http://www.sat.gob.mx/esquemas/retencionpago/1/sectorfinanciero/sectorfinanciero.xsd">
  <retenciones:Emisor RFCEmisor="@RFCEmisor" NomDenRazSocE="@NomDenRazSocE" CURPE="@CURPE" />
  <retenciones:Receptor Nacionalidad="@Nacionalidad">
    <retenciones:Nacional RFCRecep="@RFCRecep" NomDenRazSocR="@NomDenRazSocR" CURPR="@CURPR" />
    <retenciones:Extranjero NumRegIdTrib="@NumRegIdTrib" NomDenRazSocR="@ENomDenRazSocR" />    
  </retenciones:Receptor>
  <retenciones:Periodo MesIni="@MesIni" MesFin="@MesFin" Ejerc="@Ejerc" />
  <retenciones:Totales montoTotOperacion="@montoTotOperacion" montoTotGrav="@montoTotGrav" montoTotExent="@montoTotExent" montoTotRet="@montoTotRet">
    @Detalle
  </retenciones:Totales>
  <retenciones:Complemento> @Complemento </retenciones:Complemento>
  <retenciones:Addenda> @Addenda </retenciones:Addenda>
</retenciones:Retenciones>'
GO

DELETE CFDIRetencionXMLXSD WHERE Version = '1.0'
GO
INSERT INTO CFDIRetencionXMLXSD(Version, XSD) 
SELECT '1.0', '<xs:schema xmlns:retenciones="http://www.sat.gob.mx/esquemas/retencionpago/1" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:c_retenciones="http://www.sat.gob.mx/esquemas/retencionpago/1/catalogos" targetNamespace="http://www.sat.gob.mx/esquemas/retencionpago/1" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:import namespace="http://www.sat.gob.mx/esquemas/retencionpago/1/catalogos" schemaLocation="http://www.sat.gob.mx/esquemas/retencionpago/1/catalogos/catRetenciones.xsd"/>
	<xs:element name="Retenciones">
		<xs:annotation>
			<xs:documentation>Estándar de Documento Electrónico Retenciones e Información de Pagos.</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="Emisor">
					<xs:annotation>
						<xs:documentation>Nodo requerido para expresar la información del contribuyente emisor del documento electrónico de retenciones e información de pagos.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="RFCEmisor" type="retenciones:t_RFC" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para incorporar la clave en el Registro Federal de Contribuyentes correspondiente al contribuyente emisor del documento de retención e información de pagos, sin guiones o espacios.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="NomDenRazSocE" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para el nombre, denominación o razón social del contribuyente emisor del documento de retención e información de pagos.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:minLength value="1"/>
									<xs:maxLength value="300"/>
									<xs:whiteSpace value="collapse"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="CURPE" type="retenciones:t_CURP" use="optional">
							<xs:annotation>
								<xs:documentation>Atributo opcional para la Clave Única del Registro Poblacional del contribuyente emisor del documento de retención e información de pagos.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Receptor">
					<xs:annotation>
						<xs:documentation>Nodo requerido para expresar la información del contribuyente receptor del documento electrónico de retenciones e información de pagos.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:choice>
							<xs:element name="Nacional">
								<xs:annotation>
									<xs:documentation>Nodo requerido para expresar la información del contribuyente receptor en caso de que sea de nacionalidad mexicana</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="RFCRecep" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la clave del Registro Federal de Contribuyentes correspondiente al contribuyente receptor del documento.</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="retenciones:t_RFC"/>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="NomDenRazSocR" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo opcional para el nombre, denominación o razón social del contribuyente receptor del documento.</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="300"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="CURPR" type="retenciones:t_CURP" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo opcional para la Clave Única del Registro Poblacional del contribuyente receptor del documento.</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
							<xs:element name="Extranjero">
								<xs:annotation>
									<xs:documentation>Nodo requerido para expresar la información del contribuyente receptor del documento cuando sea residente en el extranjero</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="NumRegIdTrib" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo opcional para expresar el número de registro de identificación fiscal del receptor del documento cuando sea residente en el extranjero</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="20"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="NomDenRazSocR" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo requerido para expresar el nombre, denominación o razón social del receptor del documento cuando sea residente en el extranjero</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="300"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:choice>
						<xs:attribute name="Nacionalidad" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar la nacionalidad del receptor del documento.</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:string">
									<xs:whiteSpace value="collapse"/>
									<xs:enumeration value="Nacional">
										<xs:annotation>
											<xs:documentation>Nacionalidad Mexicana</xs:documentation>
										</xs:annotation>
									</xs:enumeration>
									<xs:enumeration value="Extranjero">
										<xs:annotation>
											<xs:documentation>Procedente de otro pais</xs:documentation>
										</xs:annotation>
									</xs:enumeration>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Periodo">
					<xs:annotation>
						<xs:documentation>Nodo requerido para expresar el periodo que ampara el documento de retenciones e información de pagos</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:attribute name="MesIni" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para la expresión del mes inicial del periodo de la retención e información de pagos</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:int">
									<xs:minInclusive value="1"/>
									<xs:maxInclusive value="12"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="MesFin" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para la expresión del mes final del periodo de la retención e información de pagos</xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:int">
									<xs:minInclusive value="1"/>
									<xs:maxInclusive value="12"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
						<xs:attribute name="Ejerc" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para la expresión del ejercicio fiscal (año) </xs:documentation>
							</xs:annotation>
							<xs:simpleType>
								<xs:restriction base="xs:int">
									<xs:minInclusive value="2004"/>
									<xs:maxInclusive value="2024"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Totales">
					<xs:annotation>
						<xs:documentation>Nodo requerido para expresar el total de las retenciones e información de pagos efectuados en el período que ampara el documento.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="ImpRetenidos" minOccurs="0" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo opcional para expresar el total de los impuestos retenidos que se desprenden de los conceptos expresados en el documento de retenciones e información de pagos.</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="BaseRet" type="retenciones:t_Importe" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo opcional para expresar la  base del impuesto, que puede ser la diferencia entre los ingresos percibidos y las deducciones autorizadas</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="Impuesto" use="optional">
										<xs:annotation>
											<xs:documentation>Atributo opcional para señalar el tipo de impuesto retenido del periodo o ejercicio conforme al catálogo.</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="retenciones:c_TipoImpuesto"/>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="montoRet" type="retenciones:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para expresar el importe del impuesto retenido en el periodo o ejercicio</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="TipoPagoRet" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para precisar si el monto de la retención es considerado pago definitivo o pago provisional</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:whiteSpace value="collapse"/>
												<xs:enumeration value="Pago definitivo">
													<xs:annotation>
														<xs:documentation>Pago definitivo</xs:documentation>
													</xs:annotation>
												</xs:enumeration>
												<xs:enumeration value="Pago provisional">
													<xs:annotation>
														<xs:documentation>Pago provisional</xs:documentation>
													</xs:annotation>
												</xs:enumeration>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="montoTotOperacion" type="retenciones:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar  el total del monto de la operación  que se relaciona en el comprobante </xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="montoTotGrav" type="retenciones:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total del monto gravado de la operación  que se relaciona en el comprobante.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="montoTotExent" type="retenciones:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total del monto exento de la operación  que se relaciona en el comprobante.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="montoTotRet" type="retenciones:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el monto total de las retenciones. Sumatoria de los montos de retención del nodo ImpRetenidos.</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Complemento" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional donde se incluirá el complemento Timbre Fiscal Digital de manera obligatoria y los nodos complementarios determinados por el SAT, de acuerdo a las disposiciones particulares a un sector o actividad específica.</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:any minOccurs="0" maxOccurs="unbounded"/>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Addenda" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para recibir las extensiones al formato que sean de utilidad al contribuyente. Para las reglas de uso del mismo, referirse al formato de origen.

</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:any minOccurs="0" maxOccurs="unbounded"/>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" use="required" fixed="1.0">
				<xs:annotation>
					<xs:documentation>Atributo requerido con valor prefijado que indica la versión del estándar bajo el que se encuentra expresada la retención y/o comprobante de información de pagos.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FolioInt" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para control interno del contribuyente que expresa el folio del documento que ampara la retención e información de pagos. Permite números y/o letras.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="20"/>
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Sello" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para contener el sello digital del documento de retención e información de pagos. El sello deberá ser expresado como una cadena de texto en formato base 64.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="NumCert" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar el número de serie del certificado de sello digital con el que se selló digitalmente el documento de la retención e información de pagos.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:length value="20"/>
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Cert" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido que sirve para incorporar el certificado de sello digital que ampara el documento de retención e información de pagos como texto, en formato base 64.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>

            <xs:attribute name="FechaExp" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo para expresar la Fecha de Timbrado de la Retencion</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>				
			</xs:attribute>

			<xs:attribute name="CveRetenc" type="retenciones:c_Retenciones" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar la clave de la retención e información de pagos de acuerdo al catálogo publicado en internet por el SAT.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="DescRetenc" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional que expresa la descripción de la retención e información de pagos en caso de que en el atributo CveRetenc se haya elegido el valor para ''otro tipo de retenciones''</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="100"/>
						<xs:whiteSpace value="collapse"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
	<xs:simpleType name="t_RFC">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar claves del Registro Federal de Contribuyentes</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:minLength value="12"/>
			<xs:maxLength value="13"/>
			<xs:whiteSpace value="collapse"/>
			<xs:pattern value="[A-Z,Ñ,&amp;]{3,4}[0-9]{2}[0-1][0-9][0-3][0-9][A-Z,0-9][A-Z,0-9][0-9,A-Z]"/>
		</xs:restriction>
	</xs:simpleType>



	<xs:simpleType name="c_Retenciones">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
		</xs:restriction>
	</xs:simpleType>

	<xs:simpleType name="c_TipoDividendoOUtilidadDistribuida">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoContribuyenteSujetoRetencion">
		<xs:restriction base="xs:string">
			<xs:enumeration value="1"/>
			<xs:enumeration value="2"/>
			<xs:enumeration value="3"/>
			<xs:enumeration value="4"/>
			<xs:enumeration value="5"/>
			<xs:enumeration value="6"/>
			<xs:enumeration value="7"/>
			<xs:enumeration value="8"/>
			<xs:enumeration value="9"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_Pais">
		<xs:restriction base="xs:string">
			<xs:enumeration value="AF"/>
			<xs:enumeration value="AL"/>
			<xs:enumeration value="DE"/>
			<xs:enumeration value="AD"/>
			<xs:enumeration value="AO"/>
			<xs:enumeration value="AI"/>
			<xs:enumeration value="AQ"/>
			<xs:enumeration value="AG"/>
			<xs:enumeration value="AN"/>
			<xs:enumeration value="SA"/>
			<xs:enumeration value="DZ"/>
			<xs:enumeration value="AR"/>
			<xs:enumeration value="AM"/>
			<xs:enumeration value="AW"/>
			<xs:enumeration value="AU"/>
			<xs:enumeration value="AT"/>
			<xs:enumeration value="AZ"/>
			<xs:enumeration value="BS"/>
			<xs:enumeration value="BH"/>
			<xs:enumeration value="BD"/>
			<xs:enumeration value="BB"/>
			<xs:enumeration value="BE"/>
			<xs:enumeration value="BZ"/>
			<xs:enumeration value="BJ"/>
			<xs:enumeration value="BM"/>
			<xs:enumeration value="BY"/>
			<xs:enumeration value="BO"/>
			<xs:enumeration value="BA"/>
			<xs:enumeration value="BW"/>
			<xs:enumeration value="BR"/>
			<xs:enumeration value="BN"/>
			<xs:enumeration value="BG"/>
			<xs:enumeration value="BF"/>
			<xs:enumeration value="BI"/>
			<xs:enumeration value="BT"/>
			<xs:enumeration value="CV"/>
			<xs:enumeration value="TD"/>
			<xs:enumeration value="KY"/>
			<xs:enumeration value="KH"/>
			<xs:enumeration value="CM"/>
			<xs:enumeration value="CA"/>
			<xs:enumeration value="CL"/>
			<xs:enumeration value="CN"/>
			<xs:enumeration value="CY"/>
			<xs:enumeration value="VA"/>
			<xs:enumeration value="CC"/>
			<xs:enumeration value="CO"/>
			<xs:enumeration value="KM"/>
			<xs:enumeration value="CG"/>
			<xs:enumeration value="CK"/>
			<xs:enumeration value="KP"/>
			<xs:enumeration value="KR"/>
			<xs:enumeration value="CI"/>
			<xs:enumeration value="CR"/>
			<xs:enumeration value="HR"/>
			<xs:enumeration value="CU"/>
			<xs:enumeration value="DK"/>
			<xs:enumeration value="DJ"/>
			<xs:enumeration value="DM"/>
			<xs:enumeration value="EC"/>
			<xs:enumeration value="EG"/>
			<xs:enumeration value="SV"/>
			<xs:enumeration value="AE"/>
			<xs:enumeration value="ER"/>
			<xs:enumeration value="SI"/>
			<xs:enumeration value="ES"/>
			<xs:enumeration value="FM"/>
			<xs:enumeration value="US"/>
			<xs:enumeration value="EE"/>
			<xs:enumeration value="ET"/>
			<xs:enumeration value="FJ"/>
			<xs:enumeration value="PH"/>
			<xs:enumeration value="FI"/>
			<xs:enumeration value="FR"/>
			<xs:enumeration value="GA"/>
			<xs:enumeration value="GM"/>
			<xs:enumeration value="GE"/>
			<xs:enumeration value="GH"/>
			<xs:enumeration value="GI"/>
			<xs:enumeration value="GD"/>
			<xs:enumeration value="GR"/>
			<xs:enumeration value="GL"/>
			<xs:enumeration value="GP"/>
			<xs:enumeration value="GU"/>
			<xs:enumeration value="GT"/>
			<xs:enumeration value="GG"/>
			<xs:enumeration value="GW"/>
			<xs:enumeration value="GQ"/>
			<xs:enumeration value="GN"/>
			<xs:enumeration value="GF"/>
			<xs:enumeration value="GY"/>
			<xs:enumeration value="HT"/>
			<xs:enumeration value="HN"/>
			<xs:enumeration value="HK"/>
			<xs:enumeration value="HU"/>
			<xs:enumeration value="IN"/>
			<xs:enumeration value="ID"/>
			<xs:enumeration value="IQ"/>
			<xs:enumeration value="IR"/>
			<xs:enumeration value="IE"/>
			<xs:enumeration value="IS"/>
			<xs:enumeration value="BV"/>
			<xs:enumeration value="IM"/>
			<xs:enumeration value="AX"/>
			<xs:enumeration value="FO"/>
			<xs:enumeration value="GS"/>
			<xs:enumeration value="HM"/>
			<xs:enumeration value="FK"/>
			<xs:enumeration value="MP"/>
			<xs:enumeration value="MH"/>
			<xs:enumeration value="UM"/>
			<xs:enumeration value="SB"/>
			<xs:enumeration value="SJ"/>
			<xs:enumeration value="TK"/>
			<xs:enumeration value="WF"/>
			<xs:enumeration value="IL"/>
			<xs:enumeration value="IT"/>
			<xs:enumeration value="JM"/>
			<xs:enumeration value="JP"/>
			<xs:enumeration value="JE"/>
			<xs:enumeration value="JO"/>
			<xs:enumeration value="KZ"/>
			<xs:enumeration value="KE"/>
			<xs:enumeration value="KI"/>
			<xs:enumeration value="KW"/>
			<xs:enumeration value="KG"/>
			<xs:enumeration value="LS"/>
			<xs:enumeration value="LV"/>
			<xs:enumeration value="LB"/>
			<xs:enumeration value="LR"/>
			<xs:enumeration value="LY"/>
			<xs:enumeration value="LI"/>
			<xs:enumeration value="LT"/>
			<xs:enumeration value="LU"/>
			<xs:enumeration value="MO"/>
			<xs:enumeration value="MK"/>
			<xs:enumeration value="MG"/>
			<xs:enumeration value="MY"/>
			<xs:enumeration value="MW"/>
			<xs:enumeration value="MV"/>
			<xs:enumeration value="ML"/>
			<xs:enumeration value="MT"/>
			<xs:enumeration value="MA"/>
			<xs:enumeration value="MQ"/>
			<xs:enumeration value="MU"/>
			<xs:enumeration value="MR"/>
			<xs:enumeration value="YT"/>
			<xs:enumeration value="MX"/>
			<xs:enumeration value="MD"/>
			<xs:enumeration value="MC"/>
			<xs:enumeration value="MN"/>
			<xs:enumeration value="MS"/>
			<xs:enumeration value="ME"/>
			<xs:enumeration value="MZ"/>
			<xs:enumeration value="MM"/>
			<xs:enumeration value="NA"/>
			<xs:enumeration value="NR"/>
			<xs:enumeration value="CX"/>
			<xs:enumeration value="NP"/>
			<xs:enumeration value="NI"/>
			<xs:enumeration value="NE"/>
			<xs:enumeration value="NG"/>
			<xs:enumeration value="NU"/>
			<xs:enumeration value="NF"/>
			<xs:enumeration value="NO"/>
			<xs:enumeration value="NC"/>
			<xs:enumeration value="NZ"/>
			<xs:enumeration value="OM"/>
			<xs:enumeration value="PIK"/>
			<xs:enumeration value="NL"/>
			<xs:enumeration value="PK"/>
			<xs:enumeration value="PW"/>
			<xs:enumeration value="PS"/>
			<xs:enumeration value="PA"/>
			<xs:enumeration value="PG"/>
			<xs:enumeration value="PY"/>
			<xs:enumeration value="PE"/>
			<xs:enumeration value="PN"/>
			<xs:enumeration value="PF"/>
			<xs:enumeration value="PL"/>
			<xs:enumeration value="PT"/>
			<xs:enumeration value="PR"/>
			<xs:enumeration value="QA"/>
			<xs:enumeration value="GB"/>
			<xs:enumeration value="CZ"/>
			<xs:enumeration value="CF"/>
			<xs:enumeration value="LA"/>
			<xs:enumeration value="RS"/>
			<xs:enumeration value="DO"/>
			<xs:enumeration value="SK"/>
			<xs:enumeration value="CD"/>
			<xs:enumeration value="RW"/>
			<xs:enumeration value="RE"/>
			<xs:enumeration value="RO"/>
			<xs:enumeration value="RU"/>
			<xs:enumeration value="EH"/>
			<xs:enumeration value="WS"/>
			<xs:enumeration value="AS"/>
			<xs:enumeration value="BL"/>
			<xs:enumeration value="KN"/>
			<xs:enumeration value="SM"/>
			<xs:enumeration value="MF"/>
			<xs:enumeration value="PM"/>
			<xs:enumeration value="VC"/>
			<xs:enumeration value="SH"/>
			<xs:enumeration value="LC"/>
			<xs:enumeration value="ST"/>
			<xs:enumeration value="SN"/>
			<xs:enumeration value="SC"/>
			<xs:enumeration value="SL"/>
			<xs:enumeration value="SG"/>
			<xs:enumeration value="SY"/>
			<xs:enumeration value="SO"/>
			<xs:enumeration value="LK"/>
			<xs:enumeration value="ZA"/>
			<xs:enumeration value="SD"/>
			<xs:enumeration value="SE"/>
			<xs:enumeration value="CH"/>
			<xs:enumeration value="SR"/>
			<xs:enumeration value="SZ"/>
			<xs:enumeration value="TJ"/>
			<xs:enumeration value="TH"/>
			<xs:enumeration value="TW"/>
			<xs:enumeration value="TZ"/>
			<xs:enumeration value="IO"/>
			<xs:enumeration value="TF"/>
			<xs:enumeration value="TL"/>
			<xs:enumeration value="TG"/>
			<xs:enumeration value="TO"/>
			<xs:enumeration value="TT"/>
			<xs:enumeration value="TN"/>
			<xs:enumeration value="TC"/>
			<xs:enumeration value="TM"/>
			<xs:enumeration value="TR"/>
			<xs:enumeration value="TV"/>
			<xs:enumeration value="UA"/>
			<xs:enumeration value="UG"/>
			<xs:enumeration value="UY"/>
			<xs:enumeration value="UZ"/>
			<xs:enumeration value="VU"/>
			<xs:enumeration value="VE"/>
			<xs:enumeration value="VN"/>
			<xs:enumeration value="VG"/>
			<xs:enumeration value="VI"/>
			<xs:enumeration value="YE"/>
			<xs:enumeration value="ZM"/>
			<xs:enumeration value="ZW"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_EntidadesFederativas">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
			<xs:enumeration value="04"/>
			<xs:enumeration value="05"/>
			<xs:enumeration value="06"/>
			<xs:enumeration value="07"/>
			<xs:enumeration value="08"/>
			<xs:enumeration value="09"/>
			<xs:enumeration value="10"/>
			<xs:enumeration value="11"/>
			<xs:enumeration value="12"/>
			<xs:enumeration value="13"/>
			<xs:enumeration value="14"/>
			<xs:enumeration value="15"/>
			<xs:enumeration value="16"/>
			<xs:enumeration value="17"/>
			<xs:enumeration value="18"/>
			<xs:enumeration value="19"/>
			<xs:enumeration value="20"/>
			<xs:enumeration value="21"/>
			<xs:enumeration value="22"/>
			<xs:enumeration value="23"/>
			<xs:enumeration value="24"/>
			<xs:enumeration value="25"/>
			<xs:enumeration value="26"/>
			<xs:enumeration value="27"/>
			<xs:enumeration value="28"/>
			<xs:enumeration value="29"/>
			<xs:enumeration value="30"/>
			<xs:enumeration value="31"/>
			<xs:enumeration value="32"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="c_TipoImpuesto">
		<xs:restriction base="xs:string">
			<xs:enumeration value="01"/>
			<xs:enumeration value="02"/>
			<xs:enumeration value="03"/>
		</xs:restriction>
	</xs:simpleType>
	
	
	<xs:simpleType name="t_Importe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar importes numéricos con fracción hasta seis decimales</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:decimal">
			<xs:fractionDigits value="6"/>
			<xs:whiteSpace value="collapse"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="t_CURP">
		<xs:annotation>
			<xs:documentation>Tipo definido para la expresión de una CURP</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:string">
			<xs:whiteSpace value="collapse"/>
			<xs:length value="18"/>
			<xs:pattern value="[A-Z][A,E,I,O,U,X][A-Z]{2}[0-9]{2}[0-1][0-9][0-3][0-9][M,H][A-Z]{2}[B,C,D,F,G,H,J,K,L,M,N,Ñ,P,Q,R,S,T,V,W,X,Y,Z]{3}[0-9,A-Z][0-9]"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
'
go
DELETE CFDIRetencionXMLCampo WHERE Version = '1.0'
GO
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@Version', 'Version'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@FolioInt', 'FolioInt'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@NumCert', 'NumCert'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@FechaExp', 'FechaExp'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@CveRetenc', 'CveRetenc'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@DescRetenc', 'DescRetenc'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@RFCEmisor', 'RFCEmisor'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@NomDenRazSocE', 'NomDenRazSocE'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@CURPE', 'CURPE'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@Nacionalidad', 'Nacionalidad'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@RFCRecep', 'RFCRecep'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@NomDenRazSocR', 'NomDenRazSocR'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@CURPR', 'CURPR'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@MesIni', 'MesIni'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@MesFin', 'MesFin'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@Ejerc', 'Ejerc'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@montoTotOperacion', 'montoTotOperacion'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@montoTotGrav', 'montoTotGrav'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@montoTotExent', 'montoTotExent'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@montoTotRet', 'montoTotRet'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@NumRegIdTrib', 'NumRegIdTrib'
INSERT INTO CFDIRetencionXMLCampo(Version, CampoXML, CampoVista) SELECT '1.0', '@ENomDenRazSocR', 'ENomDenRazSocR'
GO

UPDATE CFDIRetencionPais SET CFDIRetClaveSat = 'CA' WHERE Pais = 'Canada'
UPDATE CFDIRetencionPais SET CFDIRetClaveSat = 'US' WHERE Pais = 'Estados Unidos'
UPDATE CFDIRetencionPais SET CFDIRetClaveSat = 'MX' WHERE Pais = 'Mexico'
UPDATE CFDIRetencionPais SET CFDIRetClaveSat = 'LK' WHERE Pais = 'Sri Lanka'
GO

UPDATE CFDIRetencionPaisEstado 
   SET CFDIRetClaveSat = CFDIRetSATEstado.Clave
  FROM CFDIRetencionPaisEstado JOIN CFDIRetSATEstado ON CFDIRetencionPaisEstado.Estado = CFDIRetSATEstado.Estado
 WHERE CFDIRetencionPaisEstado.Pais = 'Mexico'
 
UPDATE CFDIRetencionPaisEstado SET CFDIRetClaveSat = '02' WHERE Pais = 'Mexico' AND Estado = 'BAJA CALIFORNIA NORTE'
UPDATE CFDIRetencionPaisEstado SET CFDIRetClaveSat = '15' WHERE Pais = 'Mexico' AND Estado = 'ESTADO DE MEXICO'
GO

/************************************************** Procedimientos **************************************************/
/**************************************     fnBuscaMovs     *********************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnBuscaMovs') DROP FUNCTION dbo.fnBuscaMovs
GO
CREATE FUNCTION dbo.fnBuscaMovs(@Modulo varchar(20), @ID int, @Empresa varchar(5))    
RETURNS @MovsA TABLE(Num int IDENTITY(1,1), ID int, Modulo varchar(5), Mov varchar(20),MovID varchar(20),Tipo int)    
AS BEGIN     
    
DECLARE @Movs TABLE(Num int IDENTITY(1,1), ID int, Modulo varchar(5), Mov varchar(20),MovID varchar(20),Tipo int)    
    
 ------------------------------------------------------------------------------------------------------------     
 IF EXISTS (SELECT * FROM MovFlujo WHERE OID = @ID AND OModulo = @Modulo AND Empresa = @Empresa)    
  BEGIN    
       WITH Cte
		 AS (
			SELECT OID, OModulo, OMov, OMovID, DID, DModulo, DMov, DMovID,  0 AS NIVEL
			  FROM dbo.movflujo
			 WHERE OID = @ID AND OModulo = @Modulo AND Empresa = @Empresa
			 UNION ALL
			SELECT e.OID, e.OModulo, e.OMov, e.OMovID, e.DID, e.DModulo, e.DMov, e.DMovID, 1+Cte.Nivel
			  FROM dbo.movflujo AS e
			  JOIN cte ON e.OID = cte.DID AND e.OModulo = cte.DMODULO
			)
			INSERT @Movs( ID,  Modulo,  Mov,  MovID, Tipo)
			SELECT DISTINCT OID, OModulo, OMov, OMovID, 1
			  FROM Cte order by 1,5;
			
       WITH Cte
		 AS (
			SELECT OID, OModulo, OMov, OMovID, DID, DModulo, DMov, DMovID,  0 AS NIVEL
			  FROM dbo.movflujo
			 WHERE OID = @ID AND OModulo = @Modulo AND Empresa = @Empresa
			 UNION ALL
			SELECT e.OID, e.OModulo, e.OMov, e.OMovID, e.DID, e.DModulo, e.DMov, e.DMovID, 1+Cte.Nivel
			  FROM dbo.movflujo AS e
			  JOIN cte ON e.OID = cte.DID AND e.OModulo = cte.DMODULO
			)			
			INSERT @Movs( ID,  Modulo,  Mov,  MovID, Tipo)
			SELECT DISTINCT DID, DModulo, DMov, DMovID, 1
			  FROM Cte
			EXCEPT
			SELECT ID,  Modulo,  Mov,  MovID, Tipo
			  FROM @Movs
	END
	
 IF NOT EXISTS (SELECT * FROM @Movs)    
  BEGIN    
   IF @Modulo = 'NOM'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Nomina WHERE ID = @ID    
    
   IF @Modulo = 'CXP'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM CXP WHERE ID = @ID    
        
   IF @Modulo = 'VTAS'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Venta WHERE ID = @ID          
    
   IF @Modulo = 'CXC'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM CXC WHERE ID = @ID    
    
   IF @Modulo = 'GAS'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Gasto WHERE ID = @ID    
        
   IF @Modulo = 'COMS'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Compra WHERE ID = @ID    
        
   IF @Modulo = 'DIN'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Dinero WHERE ID = @ID    
    
   IF @Modulo = 'CONT'    
    INSERT INTO @Movs( ID,  Modulo,  Mov,  MovID, Tipo) SELECT ID, @Modulo, Mov, MovID, 2 FROM Cont WHERE ID = @ID    
    
  END    
 ------------------------------------------------------------------------------------------------------------         
INSERT INTO @MovsA(ID, Modulo,  Mov,  MovID, Tipo)    
   SELECT DISTINCT ID, Modulo,  Mov,  MovID, Tipo     
     FROM @Movs	

RETURN
END
GO

/**************** xpContSAT ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContSAT') and sysstat & 0xf = 4) drop procedure dbo.xpContSAT
GO
CREATE PROCEDURE xpContSAT
      @Empresa  char(5),    
      @Modulo  char(5),    
      @ID   int,    
      @ContID  int = NULL,    
      @Personal    varchar(10) = NULL    
    
AS BEGIN
RETURN
END
GO

/**************** fnCFDIRetencionPDFGenerado ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDIRetencionPDFGenerado') DROP FUNCTION fnCFDIRetencionPDFGenerado
GO
CREATE FUNCTION fnCFDIRetencionPDFGenerado(
				@ID			int
				)
RETURNS	varchar(20)
AS
BEGIN
  DECLARE @Valor varchar(20)
  
  IF EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'CXP' AND ID = @ID AND RIGHT(Direccion, 4) = '.pdf' AND CFD = 1)
    SELECT @Valor = 'Generado'
  ELSE
    SELECT @Valor = 'No Generado'
  
  RETURN @Valor
END
GO

/************** spCFDIRetencionAsunto *************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionAsunto') and type = 'P') DROP PROCEDURE dbo.spCFDIRetencionAsunto
GO
CREATE PROCEDURE spCFDIRetencionAsunto    
				 @Empresa		varchar(5),
				 @Proveedor		varchar(10),
                 @ID			int,
			     @Asunto		varchar(max) OUTPUT,
			     @Mensaje		varchar(max) OUTPUT
--//WITH ENCRYPTION	     
AS BEGIN  
  DECLARE @NombreProv		varchar(100),
		  @RFC				varchar(15),
		  @ConceptoSAT		varchar(50),
		  @Retencion		varchar(255),
		  @Ejercicio		int,
		  @PeriodoIni		int,
		  @PeriodoFin		int,
		  @EmpresaNombre	varchar(100),
		  @EmpresaRFC		varchar(20)

  SELECT @NombreProv = Nombre, @RFC = RFC FROM Prov WHERE Proveedor = @Proveedor
  SELECT @ConceptoSAT = ConceptoSAT, @Ejercicio = Ejerc, @PeriodoIni = MesIni, @PeriodoFin = MesFin FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID
  
  SELECT @EmpresaNombre = Nombre, @EmpresaRFC = RFC FROM Empresa WHERE Empresa = @Empresa
  SELECT @Retencion = Retencion FROM CFDIRetSATRetencion WHERE Clave = @ConceptoSAT
  
  --SELECT @Asunto = EnviarAsuntoRetencion FROM EmpresaCFD WHERE Empresa = @Empresa
  
  SELECT @Asunto = REPLACE(@Asunto, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa, ''))))
  SELECT @Asunto = REPLACE(@Asunto, '<EmpresaNombre>', LTRIM(RTRIM(ISNULL(@EmpresaNombre, ''))))
  SELECT @Asunto = REPLACE(@Asunto, '<EmpresaRFC>', LTRIM(RTRIM(ISNULL(@EmpresaRFC, ''))))    
  
  SELECT @Asunto = REPLACE(@Asunto, '<Proveedor>', LTRIM(RTRIM(ISNULL(@Proveedor, ''))))  
  SELECT @Asunto = REPLACE(@Asunto, '<Nombre>', LTRIM(RTRIM(ISNULL(@NombreProv,''))))    
  SELECT @Asunto = REPLACE(@Asunto, '<RFC>', LTRIM(RTRIM(ISNULL(@RFC,''))))          
  SELECT @Asunto = REPLACE(@Asunto, '<Concepto>', LTRIM(RTRIM(ISNULL(@ConceptoSAT, ''))))    
  SELECT @Asunto = REPLACE(@Asunto, '<Retencion>', LTRIM(RTRIM(ISNULL(@Retencion, ''))))      
  SELECT @Asunto = REPLACE(@Asunto, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Ejercicio),''))))
  SELECT @Asunto = REPLACE(@Asunto, '<PeriodoIni>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @PeriodoIni),''))))
  SELECT @Asunto = REPLACE(@Asunto, '<PeriodoFin>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @PeriodoFin),''))))
  
  
  SELECT @Mensaje = REPLACE(@Mensaje, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa, ''))))
  SELECT @Mensaje = REPLACE(@Mensaje, '<EmpresaNombre>', LTRIM(RTRIM(ISNULL(@EmpresaNombre, ''))))
  SELECT @Mensaje = REPLACE(@Mensaje, '<EmpresaRFC>', LTRIM(RTRIM(ISNULL(@EmpresaRFC, ''))))    
  
  SELECT @Mensaje = REPLACE(@Mensaje, '<Proveedor>', LTRIM(RTRIM(ISNULL(@Proveedor, ''))))  
  SELECT @Mensaje = REPLACE(@Mensaje, '<Nombre>', LTRIM(RTRIM(ISNULL(@NombreProv,''))))    
  SELECT @Mensaje = REPLACE(@Mensaje, '<RFC>', LTRIM(RTRIM(ISNULL(@RFC,''))))          
  SELECT @Mensaje = REPLACE(@Mensaje, '<Concepto>', LTRIM(RTRIM(ISNULL(@ConceptoSAT, ''))))    
  SELECT @Mensaje = REPLACE(@Mensaje, '<Retencion>', LTRIM(RTRIM(ISNULL(@Retencion, ''))))      
  SELECT @Mensaje = REPLACE(@Mensaje, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Ejercicio),''))))
  SELECT @Mensaje = REPLACE(@Mensaje, '<PeriodoIni>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @PeriodoIni),''))))
  SELECT @Mensaje = REPLACE(@Mensaje, '<PeriodoFin>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @PeriodoFin),''))))  

END  
GO

/************** spCFDIRetencionEnviar *************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionEnviar') and type = 'P') DROP PROCEDURE dbo.spCFDIRetencionEnviar
GO
CREATE PROCEDURE spCFDIRetencionEnviar
				 @Empresa		varchar(5),                            
                 @ID			int,
                 @Estacion		int
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE @Anexos				varchar(550),
		  @EnviarXML			bit,
		  @EnviarPDF			bit,
		  @Enviar				bit,      
		  @Fecha				datetime,
		  @NombreCorreoEnLote	varchar(100),
		  /****/
		  @Perfil				varchar(50),
		  @Para					varchar(8000),
		  @CC					varchar(8000),
		  @CCO					varchar(8000),
		  @Asunto				varchar(8000),
		  @Mensaje				varchar(max),
		  @Formato				varchar(50),
		  @Importancia			varchar(20),
		  @Sensitividad			varchar(20),
		  @Adjuntos				varchar(max),
		  @SQL					varchar(8000),
		  @SQLBase				varchar(50),
		  @SQLAnexar			bit,
		  @SQLAnexarNombre		varchar(255),
		  @SQLConEncabezados	bit,
		  @SQLAncho				int,
		  @SQLSeparador			char(1),
		  @mailitem_id			int,
		  @Estatus				varchar(50),
		  @Proveedor			varchar(10)

  SELECT @Anexos = NULL,
		 @EnviarXML = 0,
		 @EnviarPDF = 0,
		 @Enviar = 0,      
		 @Para = NULL,
		 @CC = NULL,
		 @CCO = NULL,
		 @Asunto = NULL,
		 @Mensaje = NULL,
		 @Formato = 'HTML',
		 @Importancia = 'Normal',
		 @Sensitividad = 'Normal',
		 @Adjuntos = NULL,
		 @SQL = NULL,
		 @SQLBase = NULL,
		 @SQLAnexar = 0,
		 @SQLAnexarNombre = NULL,
		 @SQLConEncabezados = 1,
		 @SQLAncho = NULL,
		 @SQLSeparador = ' '

  SELECT @Proveedor = Proveedor FROM Cxp WHERE ID = @ID
      
  SELECT @Asunto = EnviarAsuntoRetencion,
         @Mensaje = EnviarMensajeRetencion,
         @EnviarXML = EnviarXMLRetencion,
         @EnviarPDF = EnviarPDFRetencion,
         @Enviar=EnviarRetencion 
    FROM EmpresaCFD  
   WHERE Empresa = @Empresa 

  EXEC spCFDIRetencionAsunto @Empresa, @Proveedor, @ID, @Asunto = @Asunto OUTPUT, @Mensaje = @Mensaje OUTPUT
  
  SELECT @Para =ISNULL (eMail1,'' ) FROM Prov WHERE Proveedor = @Proveedor
    
  IF (@EnviarXML=1	AND @Enviar=1)
    SELECT @Anexos = ArchivoXML FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID
  IF (@EnviarPDF =1 AND @Enviar =1 )
  BEGIN
    IF LEN(@Anexos)>0
    SET @Anexos=@Anexos+';'	
    SELECT @Anexos=(ISNULL(@Anexos,'')+ArchivoPDF) FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID
  END  

  SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa
	
  SELECT @Para    = NULLIF(RTRIM(@Para), ''), 
         @Mensaje = NULLIF(RTRIM(@Mensaje), ''), 
         @Asunto  = NULLIF(RTRIM(@Asunto), ''),
         @Anexos  = NULLIF(RTRIM(@Anexos), ''),
         @SQL     = NULLIF(RTRIM(@SQL), ''),
         @Fecha   = GETDATE()

  IF SUBSTRING(@Anexos,LEN(@Anexos),1) = ';' SELECT @Anexos = STUFF(@Anexos,LEN(@Anexos),1,'')
  
  DELETE FROM ListaID WHERE ID = @ID AND Estacion =@Estacion 
  
  IF @Para IS NOT NULL 
  BEGIN
  IF ((SELECT dbo.fnSQL2005()) = 1) OR ((SELECT dbo.fnSQL2008()) = 1) OR ((SELECT dbo.fnSQL2012()) = 1) 
    EXEC msdb.dbo.sp_send_dbmail 
           @profile_name = @Perfil,
           @recipients = @Para,
           @copy_recipients = @CC,
           @blind_copy_recipients = @CCO,
           @subject = @Asunto,
           @body = @Mensaje,
           @body_format = @Formato,
           @importance = @Importancia,
           @sensitivity = @Sensitividad,
           @file_attachments = @Anexos,
           @query = @SQL,
           @execute_query_database = @SQLBase,
           @attach_query_result_as_file = @SQLAnexar,
           @query_attachment_filename = @SQLAnexarNombre,
           @query_result_header = @SQLConEncabezados,
           @query_result_width = @SQLAncho,
           @query_result_separator = @SQLSeparador,
		   @mailitem_id	=@mailitem_id OUTPUT
	 
	SELECT @NombreCorreoEnLote = NombreCorreoEnLote FROM Version
	
    EXEC spOutlook @NombreCorreoEnLote, @Fecha, @Asunto, @Mensaje, @Anexos, @EnSilencio = 1, @ID = @ID OUTPUT
    EXEC spOutlookPara @ID, @Para
  END
  SELECT ''
END 
GO

/**************** fnCFDIRetTipoTercero ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCFDIRetTipoTercero') drop function dbo.fnCFDIRetTipoTercero
GO
CREATE FUNCTION fnCFDIRetTipoTercero(
				@Proveedor				varchar(10)
				)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @Valor		varchar(20)
  
  SELECT @Valor = CASE 
                    WHEN ISNULL(FiscalRegimen.Extranjero,0) = 0 THEN 'Nacional'
                    WHEN ISNULL(FiscalRegimen.Extranjero,0) = 1 THEN 'Extranjero'
                  END
     FROM Prov
     JOIN FiscalRegimen ON Prov.FiscalRegimen = FiscalRegimen.FiscalRegimen 
    WHERE Prov.Proveedor = @Proveedor

  RETURN ISNULL(NULLIF(RTRIM(@Valor), ''), 'Nacional')
END
GO

/******************************* tgCFDIRetGastoD *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCFDIRetGastoD') AND TYPE = 'tr') DROP TRIGGER tgCFDIRetGastoD
GO
CREATE TRIGGER tgCFDIRetGastoD ON GastoD
FOR INSERT, UPDATE
AS
BEGIN
  DECLARE @ID							int,
		  @Renglon						float,
		  @RenglonSub					int,
		  @Importe						float,
		  @Impuestos					float,
		  @Empresa						varchar(5),
		  @Retencion1					float,
		  @Retencion2					float,
		  @Retencion3					float,
		  @Retencion1Total				float,
		  @Retencion2Total				float,
		  @Retencion3Total				float,
		  @Gasto3Retenciones			bit,
		  @GASRetencion3Independiente	bit,
		  @Retencion2BaseImpuesto1		bit
		  
  IF EXISTS(SELECT * 
              FROM Inserted i
              JOIN Gasto g ON i.ID = g.ID
              JOIN MovTipo mt ON g.Mov = mt.Mov AND mt.Modulo = 'GAS'
             WHERE ISNULL(mt.SubClave, '') = 'GAS.ESTRETSAT'
               AND g.Estatus IN('SINAFECTAR', 'BORRADOR', 'CONFIRMAR')
               )
               AND (UPDATE(Cantidad) OR UPDATE(Precio) OR UPDATE(Importe) OR UPDATE(Concepto))
  BEGIN
    SELECT @Empresa = Empresa, @ID = g.ID FROM Gasto g JOIN Inserted i ON g.ID = i.ID

    SELECT @Gasto3Retenciones			= ISNULL(Gasto3Retenciones, 0),
           @GASRetencion3Independiente	= ISNULL(GASRetencion3Independiente, 0)
      FROM EmpresaCfg2 
     WHERE Empresa = @Empresa

    SELECT @Retencion2BaseImpuesto1 = ISNULL(Retencion2BaseImpuesto1, 0) FROM Version
    
    SELECT @Retencion1	= dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', Concepto, 'Retencion1'),
		   @Retencion2	= dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', Concepto, 'Retencion2'),
		   @Retencion3	= dbo.fnConceptoImpuestoTasa(@Empresa, 'GAS', Concepto, 'Retencion3'),
		   @Importe		= Importe,
		   @Renglon		= Renglon,
		   @RenglonSub	= RenglonSub
      FROM Inserted

    SELECT @Impuestos = Impuestos FROM GastoT WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub

    --Retencion 3
    IF @Gasto3Retenciones = 1
      SELECT @Retencion3Total = @Importe*(@Retencion3/100.0)
    ELSE
      SELECT @Retencion3Total = 0

    --Retencion 2
    IF @GASRetencion3Independiente = 1
      IF @Retencion2BaseImpuesto1 = 1
        SELECT @Retencion2Total = @Impuestos*(@Retencion2/100.0)
      ELSE
        SELECT @Retencion2Total = @Importe*(@Retencion2/100.0)
    ELSE
      IF @Retencion2BaseImpuesto1 = 1
        SELECT @Retencion2Total = @Impuestos*(@Retencion2/100.0)
      ELSE
        SELECT @Retencion2Total = (@Importe-ISNULL(@Retencion3Total, 0))*(@Retencion2/100.0)

    --Retencion
    IF @GASRetencion3Independiente = 1
      SELECT @Retencion1Total = @Importe*(@Retencion1/100.0)
    ELSE
      SELECT @Retencion1Total = (@Importe-ISNULL(@Retencion3Total, 0))*(@Retencion1/100.0)

    UPDATE GastoD 
       SET Retencion3 = @Retencion3Total,
		   Retencion2 = @Retencion2Total,
		   Retencion  = @Retencion1Total
      FROM GastoD
     WHERE ID = @ID
       AND Renglon = @Renglon
       AND RenglonSub = @RenglonSub
  END

  RETURN

END
GO

/******************************* spCFDIRetencionCompGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDIRetencionCompGenerarXMLSchema') AND TYPE = 'P') DROP PROCEDURE spCFDIRetencionCompGenerarXMLSchema
GO
CREATE PROC spCFDIRetencionCompGenerarXMLSchema
			@Complemento		varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
		  @XSD			nvarchar(max),
		  @XMLSchema	nvarchar(max)

  SELECT @XSD		  = REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(XSD)),CHAR(13),''),CHAR(10),''), '''', '')
    FROM CFDIRetencionCompXMLXSD 
   WHERE Complemento = @Complemento

  SET @IDSQL = 'RetencionComp_' + @Complemento

  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN
    SET @XMLSchema = 'DROP XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']'
    EXECUTE sp_executesql @XMLSchema

    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      EXECUTE sp_executesql @XMLSchema
    END
  END
  ELSE
  BEGIN 
    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN    
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      
      EXECUTE sp_executesql @XMLSchema
    END
  END
END 
GO

EXEC spCFDIRetencionCompGenerarXMLSchema 'Extranjeros'
GO
EXEC spCFDIRetencionCompGenerarXMLSchema 'Dividendos'
GO
EXEC spCFDIRetencionCompGenerarXMLSchema 'Intereses'
GO
EXEC spCFDIRetencionCompGenerarXMLSchema 'EnajenacionAcciones'
GO

/******************************* spCrearDirectorio *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearDirectorio') AND TYPE = 'P')
DROP PROCEDURE spCrearDirectorio
GO
CREATE PROCEDURE spCrearDirectorio    
	(    
	@Directorio			varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)  
--//WITH ENCRYPTION  
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE					int,
  @ManejadorObjeto				int,
  @ManejadorDirectorio			int,  
  @Existe						int          
  
  SET @ManejadorDirectorio = NULL  
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Directorio   

  --Verifica si existe un directorio
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FolderExists', @Existe OUT, @Directorio
  IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio       
    
  --Elimina un archivo de texto    
  IF ISNULL(@Existe,0) = 0
  BEGIN
  --Crea el directorio
    EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'CreateFolder', @ManejadorDirectorio OUT, @Directorio
    IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio       
  END

  IF @ManejadorDirectorio IS NOT NULL
  BEGIN
    EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorDirectorio
    IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio
  END
  
  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71640, @OkRef = @Directorio
    
END
go

/******************************* spInsertaEnArchivo2 *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaEnArchivo2') AND TYPE = 'P') DROP PROCEDURE spInsertaEnArchivo2
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
AS    
BEGIN    
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

/******************************* spCrearArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearArchivo') AND TYPE = 'P') DROP PROCEDURE spCrearArchivo
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
AS    
BEGIN    
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

/******************************* spInsertaEnArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertaEnArchivo') AND TYPE = 'P') DROP PROCEDURE spInsertaEnArchivo
GO  
CREATE PROCEDURE spInsertaEnArchivo  
    (  
    @IDArchivo		int,  
    @Cadena		varchar(max),
 	@Ok				int = NULL OUTPUT,
	@OkRef			varchar(255) = NULL OUTPUT            
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
  DECLARE
    @ResultadoOLE	int,
    @CadenaXML		xml

  SELECT @CadenaXML = CONVERT(xml,@Cadena)
  SELECT @Cadena = '<?xml version="1.0" encoding="UTF-8"?>' + CONVERT(varchar(max),@CadenaXML)

  --Inserta una Linea al archivo  
  EXECUTE @ResultadoOLE = sp_OAMethod @IDArchivo, 'Write', NULL, @Cadena
  IF @ResultadoOLE <> 0 SET @Ok = 710520  
END  
GO

/******************************* spCerrarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCerrarArchivo') AND TYPE = 'P') DROP PROCEDURE spCerrarArchivo
GO  
CREATE PROCEDURE spCerrarArchivo  
    (  
    @IDArchivo			int,
    @ManejadorObjeto	int,    
	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT     
    )  
--//WITH ENCRYPTION
AS  
BEGIN  
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

/******************************* spVerificarArchivo *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVerificarArchivo') AND TYPE = 'P')
DROP PROCEDURE spVerificarArchivo
GO
CREATE PROCEDURE spVerificarArchivo    
	(    
	@Archivo			varchar(255),    
	@Existe				int = 0 OUTPUT,
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
  @ResultadoOLE		int,
  @ManejadorObjeto	int
    
  SET @Existe = 0
    
  --Contacta al objeto que nos ayudará a crear el archivo    
  EXECUTE @ResultadoOLE = sp_OACreate 'Scripting.FileSystemObject', @ManejadorObjeto OUT    
  IF @ResultadoOLE <> 0 SELECT @Ok = 71510, @OkRef = @Archivo   

  --Verifica si existe un archivo   
  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'FileExists', @Existe OUT, @Archivo
  IF @ResultadoOLE <> 0 SELECT @Ok = 71515, @OkRef = @Archivo       

  EXECUTE @ResultadoOLE = sp_OADestroy @ManejadorObjeto
  IF @ResultadoOLE <> 0 SELECT @Ok = 71530, @OkRef = @Archivo
    
  --IF @Existe = 1
  --BEGIN  
  --  EXECUTE @ResultadoOLE = sp_OAMethod @ManejadorObjeto, 'Close'
  --  IF @ResultadoOLE <> 0 SELECT @Ok = 71540, @OkRef = @Archivo       
  --END

END
GO

/**************** fnFragmentarRuta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFragmentarRuta') DROP FUNCTION fnFragmentarRuta
GO
CREATE FUNCTION fnFragmentarRuta 
	(
	@Ruta				varchar(255)
	)
RETURNS @Directorios TABLE
        (
		Directorio			varchar(255) COLLATE DATABASE_DEFAULT
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Longitud			bigint,
  @Contador			bigint,
  @Caracter			char(1),
  @Directorio		varchar(255),
  @Estado			int,
  @EstadoAnterior	int
  
  SELECT @Longitud = LEN(@Ruta), @Contador = 1, @Caracter = NULL, @Directorio = '', @Estado = 0
  
  WHILE @Contador <= @Longitud
  BEGIN
    SET @Caracter = SUBSTRING(@Ruta,@Contador,1)
    SET @EstadoAnterior = @Estado    
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter = '\'         THEN 1
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      SET @Directorio = @Directorio + @Caracter
    END
    IF @Estado = 1
    BEGIN
      INSERT @Directorios (Directorio) VALUES (@Directorio)    
      SET @Directorio = @Directorio + @Caracter
      SET @Estado = 0
    END

    
    SET @Contador = @Contador + 1
  END
  
  IF @Caracter <> '\'   
    INSERT @Directorios (Directorio) VALUES (@Directorio)    

  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') IS NULL
  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') = '\'
  DELETE FROM @Directorios WHERE NULLIF(Directorio,'') LIKE '\\%' AND CHARINDEX('\',SUBSTRING(Directorio,3,LEN(Directorio)-2)) = 0

  RETURN
END
GO

/******************************* spCrearRuta *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCrearRuta') AND TYPE = 'P') DROP PROCEDURE spCrearRuta
GO
CREATE PROCEDURE spCrearRuta
	(    
	@Ruta				varchar(255),    
 	@Ok					int = NULL OUTPUT,
	@OkRef				varchar(255) = NULL OUTPUT                     
	)    
--//WITH ENCRYPTION
AS    
BEGIN    
  DECLARE  
    @Directorio				varchar(255)
    
  DECLARE crDirectorios CURSOR FOR
   SELECT Directorio
     FROM dbo.fnFragmentarRuta(@Ruta)

  OPEN crDirectorios
  FETCH NEXT FROM crDirectorios INTO @Directorio
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    EXEC spCrearDirectorio @Directorio, @Ok OUTPUT, @OkRef OUTPUT
    FETCH NEXT FROM crDirectorios INTO @Directorio
  END
  CLOSE crDirectorios
  DEALLOCATE crDirectorios
        
END
go

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

/******************************* tgCFDIRetencionCxp *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCFDIRetencionCxp') AND TYPE = 'tr') DROP TRIGGER tgCFDIRetencionCxp
GO
CREATE TRIGGER tgCFDIRetencionCxp ON Cxp
FOR UPDATE
AS
BEGIN
  DECLARE @ID						int,
		  @IDAnt					int,
		  @Ok						int,
		  @OkRef					varchar(255),
		  @Mov						varchar(20),
		  @MovID					varchar(20)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(i.ID)
      FROM Inserted i
      JOIN Deleted d ON i.ID = d.ID
     WHERE i.Estatus =  'CANCELADO'
       AND d.Estatus <> 'CANCELADO'
       AND i.ID > @IDAnt
       AND ISNULL(d.CFDRetencionTimbrado, 0) = 1
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
        
    SELECT @Mov = Mov, @MovID = MovID FROM Inserted WHERE ID = @ID
      
    SELECT @Ok = 60050, @OkRef = 'CFDI - ' + RTRIM(@Mov)+' '+RTRIM(@MovID)

    BEGIN TRY
      EXEC spOk_RAISERROR @Ok, @OkRef
    END TRY      
    BEGIN CATCH
      EXEC spOk_RAISERROR @Ok, @OkRef
      ROLLBACK TRAN
    END CATCH	
  END
  RETURN
END
GO

/******************************* tgCFDIRetencionGasto *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCFDIRetencionGasto') AND TYPE = 'tr') DROP TRIGGER tgCFDIRetencionGasto
GO
CREATE TRIGGER tgCFDIRetencionGasto ON Gasto
FOR UPDATE
AS
BEGIN
  DECLARE @ID						int,
		  @IDAnt					int,
		  @Ok						int,
		  @OkRef					varchar(255),
		  @Mov						varchar(20),
		  @MovID					varchar(20)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(i.ID)
      FROM Inserted i
      JOIN Deleted d ON i.ID = d.ID
     WHERE i.Estatus =  'CANCELADO'
       AND d.Estatus <> 'CANCELADO'
       AND i.ID > @IDAnt
       AND ISNULL(d.CFDRetencionTimbrado, 0) = 1
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
        
    SELECT @Mov = Mov, @MovID = MovID FROM Inserted WHERE ID = @ID
      
    SELECT @Ok = 60050, @OkRef = 'CFDI - ' + RTRIM(@Mov)+' '+RTRIM(@MovID)

    BEGIN TRY
      EXEC spOk_RAISERROR @Ok, @OkRef
    END TRY      
    BEGIN CATCH
      EXEC spOk_RAISERROR @Ok, @OkRef
      ROLLBACK TRAN
    END CATCH	
  END
  RETURN
END
GO

/******************************* tgCFDIRetencionCompra *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCFDIRetencionCompra') AND TYPE = 'tr') DROP TRIGGER tgCFDIRetencionCompra
GO
CREATE TRIGGER tgCFDIRetencionCompra ON Compra
FOR UPDATE
AS
BEGIN
  DECLARE @ID						int,
		  @IDAnt					int,
		  @Ok						int,
		  @OkRef					varchar(255),
		  @Mov						varchar(20),
		  @MovID					varchar(20)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(i.ID)
      FROM Inserted i
      JOIN Deleted d ON i.ID = d.ID
     WHERE i.Estatus =  'CANCELADO'
       AND d.Estatus <> 'CANCELADO'
       AND i.ID > @IDAnt
       AND ISNULL(d.CFDRetencionTimbrado, 0) = 1
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
        
    SELECT @Mov = Mov, @MovID = MovID FROM Inserted WHERE ID = @ID
      
    SELECT @Ok = 60050, @OkRef = 'CFDI - ' + RTRIM(@Mov)+' '+RTRIM(@MovID)

    BEGIN TRY
      EXEC spOk_RAISERROR @Ok, @OkRef
    END TRY      
    BEGIN CATCH
      EXEC spOk_RAISERROR @Ok, @OkRef
      ROLLBACK TRAN
    END CATCH	
  END
  RETURN
END
GO

/******************************* tgCFDIRetencionDinero *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgCFDIRetencionDinero') AND TYPE = 'tr') DROP TRIGGER tgCFDIRetencionDinero
GO
CREATE TRIGGER tgCFDIRetencionDinero ON Dinero
FOR UPDATE
AS
BEGIN
  DECLARE @ID						int,
		  @IDAnt					int,
		  @Ok						int,
		  @OkRef					varchar(255),
		  @Mov						varchar(20),
		  @MovID					varchar(20)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(i.ID)
      FROM Inserted i
      JOIN Deleted d ON i.ID = d.ID
     WHERE i.Estatus =  'CANCELADO'
       AND d.Estatus <> 'CANCELADO'
       AND i.ID > @IDAnt
       AND ISNULL(d.CFDRetencionTimbrado, 0) = 1
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
        
    SELECT @Mov = Mov, @MovID = MovID FROM Inserted WHERE ID = @ID
      
    SELECT @Ok = 60050, @OkRef = 'CFDI - ' + RTRIM(@Mov)+' '+RTRIM(@MovID)

    BEGIN TRY
      EXEC spOk_RAISERROR @Ok, @OkRef
    END TRY      
    BEGIN CATCH
      EXEC spOk_RAISERROR @Ok, @OkRef
      ROLLBACK TRAN
    END CATCH	
  END
  RETURN
END
GO

/**************** fnCFDINominaObtenerRuta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDINominaObtenerRuta') DROP FUNCTION fnCFDINominaObtenerRuta
GO
CREATE FUNCTION fnCFDINominaObtenerRuta(
				@Archivo		varchar(255)
				)
RETURNS varchar(255)
AS
BEGIN
  DECLARE @Auxiliar		int,
          @AuxiliarAnt	int,
		  @Ruta			varchar(255)

  SELECT @AuxiliarAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @Auxiliar = CHARINDEX('\', @Archivo, @AuxiliarAnt)

    IF NULLIF(@Auxiliar, 0) IS NULL 
    BEGIN
      IF @AuxiliarAnt <> 0
        SELECT @Ruta = SUBSTRING(@Archivo, 1, @AuxiliarAnt-2)
      ELSE
        SELECT @Ruta = @Archivo
    
      BREAK
    END
    SELECT @AuxiliarAnt = @Auxiliar + 1
  END
  
  RETURN @Ruta
END
GO

/**************** fnCFDILimpiarXML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDILimpiarXML') DROP FUNCTION fnCFDILimpiarXML
GO
CREATE FUNCTION fnCFDILimpiarXML
	(
	@XML				varchar(max),
	@TagSostener		varchar(max)
	)
RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Seguir				bit,
    @AtributoVacio		varchar(255),
    @Posicion			bigint,
    @Caracter			char(1),
    @Contador			int,
    @Atributo			varchar(255)
    
  --Quita los espacios de todos los atributos del xml que no esten en la lista a respetar   
  SELECT @Seguir = 1, @AtributoVacio = '=""', @Posicion = 0  
  WHILE @Seguir = 1
  BEGIN
    SET @Posicion = ISNULL(PATINDEX('%=""%',@XML),0)      
    IF @Posicion > 0 
    BEGIN
      SET @Contador = @Posicion - 1
      SET @Caracter = SUBSTRING(@XML,@Contador,1)
      SET @AtributoVacio = '=""'
      WHILE @Caracter <> CHAR(32)
      BEGIN        
        SET @AtributoVacio = @Caracter + @AtributoVacio
        SET @Contador = @Contador - 1
        SET @Caracter = SUBSTRING(@XML,@Contador,1)
      END
	  SET @AtributoVacio = CHAR(32) + @AtributoVacio
      SELECT @Atributo = RTRIM(REPLACE(@AtributoVacio,'=""',''))
      IF ISNULL(PATINDEX('%' + @Atributo + '%',@TagSostener),0) = 0
        SET @XML = REPLACE(@XML,@AtributoVacio,'')
      ELSE
        SET @XML = REPLACE(@XML,@AtributoVacio,@Atributo + '="' + '_TAGRESPETAR_' + '"')
    END
     
    ELSE IF @Posicion = 0
      SET @Seguir = 0
  END   

  --Borra los valores de los tags que se van a respetar
  SET @Seguir = 1
  WHILE @Seguir = 1
  BEGIN
    SET @Posicion = ISNULL(PATINDEX('%="_TAGRESPETAR_"%',@XML),0)      
    IF @Posicion > 0 
    BEGIN
      SET @XML = REPLACE(@XML,'="_TAGRESPETAR_"','=""')
    END
    ELSE IF @Posicion = 0
      SET @Seguir = 0
  END   
  
  RETURN @XML
END
GO

/******************************* spCFDIRetencionGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDIRetencionGenerarXMLSchema') AND TYPE = 'P') DROP PROCEDURE spCFDIRetencionGenerarXMLSchema
GO
CREATE PROC spCFDIRetencionGenerarXMLSchema
			@Version		varchar(5)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
		  @XSD			nvarchar(max),
		  @XMLSchema	nvarchar(max)

  SELECT @XSD		  = REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(XSD)),CHAR(13),''),CHAR(10),''), '''', '')
    FROM CFDIRetencionXMLXSD 
   WHERE Version = @Version

  SET @IDSQL = 'Retencion_' + @Version

  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN
    SET @XMLSchema = 'DROP XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']'
    EXECUTE sp_executesql @XMLSchema

    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      EXECUTE sp_executesql @XMLSchema
    END
  END
  ELSE
  BEGIN 
    IF NULLIF(RTRIM(@XSD),'') IS NOT NULL
    BEGIN    
      SET @XMLSchema = 'CREATE XML SCHEMA COLLECTION ' + '[' + RTRIM(@IDSQL) + ']' + ' AS ' + CHAR(39) + RTRIM(@XSD) + CHAR(39)
      
      EXECUTE sp_executesql @XMLSchema
    END
  END
END 
GO

EXEC spCFDIRetencionGenerarXMLSchema '1.0'

/**************** fnCFDIRetencionIVAFiscal ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCFDIRetencionIVAFiscal') drop function dbo.fnCFDIRetencionIVAFiscal
GO
CREATE FUNCTION fnCFDIRetencionIVAFiscal (@Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    (ISNULL(@Impuestos,0.0)/NULLIF((ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)),0.0))
END
GO

/**************** fnCFDIRetencionIVATasa ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCFDIRetencionIVATasa') drop function dbo.fnCFDIRetencionIVATasa
GO
CREATE FUNCTION fnCFDIRetencionIVATasa (@Empresa varchar(5), @Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @IVAFiscal float,
  @Tasa		 float
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
  
  SET @IVAFiscal = dbo.fnCFDIRetencionIVAFiscal(@Importe,@Impuestos)
 
  IF @Importe = 0 AND @Impuestos <> 0
    SELECT @Tasa = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa  
  ELSE
    SELECT @Tasa = ROUND(((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)/NULLIF(@Importe,0.0),2)*100.0

  RETURN @Tasa
END
GO

/**************** fnCFDIRetencionIVA ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCFDIRetencionIVA') drop function dbo.fnCFDIRetencionIVA
GO
CREATE FUNCTION fnCFDIRetencionIVA(@Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @IVAFiscal float
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
   
  SET @IVAFiscal = dbo.fnCFDIRetencionIVAFiscal(@Importe,@Impuestos)
 
  RETURN ((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)
    
END
GO

/**************** spCFDIRetencionRecalcEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionRecalcEncabezado') and type = 'P') drop procedure dbo.spCFDIRetencionRecalcEncabezado
GO
CREATE PROC spCFDIRetencionRecalcEncabezado
			@Estacion		int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Modulo		varchar(5),
		  @ModuloAnt	varchar(5),
		  @ModuloID		int,
		  @ModuloIDAnt	int

  DELETE CFDIRetencion        WHERE EstacionTrabajo = @Estacion
  DELETE CFDIRetencionCalcTmp WHERE EstacionTrabajo = @Estacion  
  
  CREATE TABLE #CFDIRetencion(
    EstacionTrabajo		int			NULL,
    Modulo				varchar(5)	COLLATE DATABASE_DEFAULT NULL,
    ModuloID			int			NULL,
    Sucursal			int			NULL,
    Empresa				varchar(5)	COLLATE DATABASE_DEFAULT NULL,
    Proveedor			varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    ConceptoSAT			varchar(50)	COLLATE DATABASE_DEFAULT NULL,
    PorcentajeDeducible	float		NULL,
    FechaEmision		datetime	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    Importe				float		NULL,
    IVA					float		NULL,
    IEPS				float		NULL,
    Retencion1			float		NULL,    
    Retencion2			float		NULL,       
  )
         
  SELECT @ModuloAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Modulo = MIN(Modulo)
      FROM CFDIRetencionD 
     WHERE EstacionTrabajo = @Estacion
       AND Modulo > @ModuloAnt

    IF @Modulo IS NULL BREAK
    
    SELECT @ModuloAnt = @Modulo

    SELECT @ModuloIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @ModuloID = MIN(ModuloID)
        FROM CFDIRetencionD 
       WHERE EstacionTrabajo = @Estacion
         AND Modulo = @Modulo
         AND ModuloID > @ModuloIDAnt

      IF @ModuloID IS NULL BREAK
    
      SELECT @ModuloIDAnt = @ModuloID
      
      IF EXISTS(SELECT * 
                  FROM CFDIRetencionD 
                 WHERE EsRetencion = 1
                   AND EstacionTrabajo = @Estacion
                   AND Modulo = @Modulo
                   AND ModuloID = @ModuloID)
      BEGIN
        INSERT INTO #CFDIRetencion(
               EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS, Retencion1,      Retencion2)
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, 0.0,  SUM(Retencion1), SUM(Retencion2)
          FROM CFDIRetencionD
         WHERE EsRetencion = 1
           AND EstacionTrabajo = @Estacion
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS
         UNION ALL
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, SUM(Importe), SUM(IVA), SUM(IEPS), SUM(Retencion1), SUM(Retencion2)
          FROM CFDIRetencionD 
         WHERE EsComplemento = 1
           AND EstacionTrabajo = @Estacion   
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID           
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo
         UNION ALL
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, 0.0, 0.0, SUM(IEPS), 0.0, 0.0
          FROM CFDIRetencionD 
         WHERE EsIEPS = 1
           AND EstacionTrabajo = @Estacion   
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID           
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo      
      END
      ELSE
      BEGIN
        INSERT INTO #CFDIRetencion(
               EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS, Retencion1,      Retencion2)      
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, 0.0,  SUM(Retencion1), SUM(Retencion2)
          FROM CFDIRetencionD
         WHERE EsRetencion = 1
           AND EstacionTrabajo = @Estacion
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID           
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS
         UNION ALL
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, SUM(Importe), SUM(IVA), SUM(IEPS), SUM(Retencion1), SUM(Retencion2)
          FROM CFDIRetencionD 
         WHERE EsComplemento = 1
           AND EstacionTrabajo = @Estacion   
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID           
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo
        UNION ALL
        SELECT EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS, 0.0, 0.0
          FROM CFDIRetencionD 
         WHERE EsIEPS = 1
           AND EstacionTrabajo = @Estacion   
           AND Modulo = @Modulo
           AND ModuloID = @ModuloID           
         GROUP BY EstacionTrabajo, Modulo, ModuloID, Sucursal, Empresa, Proveedor, ConceptoSAT, PorcentajeDeducible, FechaEmision, Ejercicio, Periodo, Importe, IVA, IEPS
      END
    END    
  END
  
  INSERT INTO CFDIRetencion(
           EstacionTrabajo,   Modulo,   ModuloID,   Mov,   MovID,    Sucursal,   Empresa,   Proveedor,   ConceptoSAT,   FechaEmision,   Ejercicio,   Periodo, Importe,        IVA,        IEPS,        Retencion1,        Retencion2)
  SELECT c.EstacionTrabajo, c.Modulo, c.ModuloID, o.Mov, o.MovID,  c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.FechaEmision, c.Ejercicio, c.Periodo, SUM(c.Importe), SUM(c.IVA), SUM(c.IEPS), SUM(c.Retencion1), SUM(c.Retencion2)
    FROM #CFDIRetencion c
    JOIN Compra o ON c.Modulo = 'COMS' AND c.ModuloID = o.ID
   GROUP BY c.EstacionTrabajo, c.Modulo, c.ModuloID, c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.FechaEmision, c.Ejercicio, c.Periodo, o.Mov, o.MovID   
  UNION ALL
  SELECT c.EstacionTrabajo, c.Modulo, c.ModuloID, o.Mov, o.MovID,  c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.FechaEmision, c.Ejercicio, c.Periodo, SUM(c.Importe), SUM(c.IVA), SUM(c.IEPS), SUM(c.Retencion1), SUM(c.Retencion2)
    FROM #CFDIRetencion c
    JOIN Gasto o ON c.Modulo = 'GAS' AND c.ModuloID = o.ID
   GROUP BY c.EstacionTrabajo, c.Modulo, c.ModuloID, c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.FechaEmision, c.Ejercicio, c.Periodo, o.Mov, o.MovID

  INSERT INTO CFDIRetencionCalcTmp(
           EstacionTrabajo,   Modulo,   ModuloID,   Mov,   MovID,    Sucursal,   Empresa,   Proveedor,   ConceptoSAT,   PorcentajeDeducible,   FechaEmision,   Ejercicio,   Periodo, Importe,        IVA,        IEPS,        Retencion1,        Retencion2)
  SELECT c.EstacionTrabajo, c.Modulo, c.ModuloID, o.Mov, o.MovID,  c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.PorcentajeDeducible, c.FechaEmision, c.Ejercicio, c.Periodo, SUM(c.Importe), SUM(c.IVA), SUM(c.IEPS), SUM(c.Retencion1), SUM(c.Retencion2)
    FROM #CFDIRetencion c
    JOIN Compra o ON c.Modulo = 'COMS' AND c.ModuloID = o.ID
   GROUP BY c.EstacionTrabajo, c.Modulo, c.ModuloID, c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.PorcentajeDeducible, c.FechaEmision, c.Ejercicio, c.Periodo, o.Mov, o.MovID   
  UNION ALL
  SELECT c.EstacionTrabajo, c.Modulo, c.ModuloID, o.Mov, o.MovID,  c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.PorcentajeDeducible, c.FechaEmision, c.Ejercicio, c.Periodo, SUM(c.Importe), SUM(c.IVA), SUM(c.IEPS), SUM(c.Retencion1), SUM(c.Retencion2)
    FROM #CFDIRetencion c
    JOIN Gasto o ON c.Modulo = 'GAS' AND c.ModuloID = o.ID
   GROUP BY c.EstacionTrabajo, c.Modulo, c.ModuloID, c.Sucursal, c.Empresa, c.Proveedor, c.ConceptoSAT, c.PorcentajeDeducible, c.FechaEmision, c.Ejercicio, c.Periodo, o.Mov, o.MovID   
  RETURN
END
GO			

/**************** spCFDIRetencionProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionProcesar') and type = 'P') drop procedure dbo.spCFDIRetencionProcesar
GO
CREATE PROC spCFDIRetencionProcesar
			@Estacion		int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RID					int,
		  @RIDAnt				int,  
		  @ImportePago			float,
		  @Aplica				varchar(20),
		  @AplicaID				varchar(20),
		  @Importe				float,
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @Factor				float,
		  @FechaPago			datetime,
		  @Signo				int,
		  @Dinero				varchar(20),
		  @DineroID				varchar(20),
		  @IDPago				int,
		  @ModuloPago			varchar(5),
		  @EsRetencion			bit,
		  @EsIEPS				bit,
		  
		  --BUG1560
		  @Ejercicio			int,
		  @Periodo				int

  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM #Pagos
     WHERE RID > @RIDAnt
     
    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID
    
    SELECT @Aplica = NULL, @AplicaID = NULL, @Importe = NULL, @ImportePago = NULL, @Factor = NULL, @FechaPago = NULL, @Dinero =	NULL, @DineroID = NULL, @IDPago = NULL, @ModuloPago = NULL,
           --BUG1560
           @Ejercicio = NULL, @Periodo = NULL
    
    SELECT @Aplica = Aplica, 
		   @AplicaID = AplicaID, 
		   @ImportePago = ISNULL(Importe, 0), 
		   @Mov = Mov, 
		   @MovID = MovID, 
		   @FechaPago = FechaEmision,
		   @Dinero = Dinero, 
		   @DineroID = DineroID,
		   @IDPago = ID,
		   @ModuloPago = Modulo,
		   @EsRetencion = ISNULL(EsRetencion, 0),
		   @EsIEPS = ISNULL(EsIEPS, 0),
		   --BUG1560
		   @Ejercicio = Ejercicio,
		   @Periodo	= Periodo
      FROM #Pagos
     WHERE RID = @RID

    IF EXISTS(SELECT * FROM #Documentos WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Pago = @Mov AND PagoID = @MovID AND ISNULL(EsRetencion, 0) = 1)
    OR EXISTS(SELECT * FROM #Documentos WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Pago = @Mov AND PagoID = @MovID AND ISNULL(EsComplemento, 0) = 1)
    OR EXISTS(SELECT * FROM #Documentos WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Pago = @Mov AND PagoID = @MovID AND ISNULL(EsIEPS, 0) = 1)    
    BEGIN      
      IF @EsRetencion = 0
        SELECT @Importe = SUM(NULLIF(ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) + ISNULL(ISAN,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0), 0))
          FROM #Documentos 
         WHERE Empresa = @Empresa
           AND Mov = @Aplica 
           AND MovID = @AplicaID 
           AND Pago = @Mov 
           AND PagoID = @MovID
           AND ISNULL(EsRetencion, 0) = @EsRetencion
           AND ISNULL(EsIEPS, 0) = @EsIEPS
      ELSE
      BEGIN
        SELECT @ImportePago = SUM(ISNULL(Importe, 0))
          FROM #Pagos
         WHERE Modulo = @ModuloPago
           AND ID = @IDPago
        
        SELECT @Importe = SUM(NULLIF(ISNULL(Retencion1,0.0) + ISNULL(Retencion2,0.0), 0))
          FROM #Documentos 
         WHERE Empresa = @Empresa
           AND Pago = @Mov 
           AND PagoID = @MovID           
           AND ISNULL(EsRetencion, 0) = @EsRetencion
           AND ISNULL(EsIEPS, 0) = @EsIEPS           
      END
      
      SELECT @Factor = ROUND(@ImportePago / NULLIF(@Importe, 0), 3)

      INSERT INTO CFDIRetencionD(
    		     Modulo, 
    		     EstacionTrabajo, 
    		     Empresa, 
    		     Mov, 
    		     MovID, 
    		     Pago, 
    		     PagoID, 
    		     Proveedor, 
    		     Tasa, 
    		     FechaEmision,  
    		     FechaPago, 
    		     Ejercicio, 
    		     Periodo, 
    		     Concepto, 
    		     ConceptoClave, 
    		     ConceptoSAT, 
    		     Factor,
    		     Importe, 
    		     IVA, 
    		     IEPS,
    		     Retencion2, 
    		     Retencion1, 
    		     DineroMov, 
    		     DineroMovID, 
    		     ImportePago, 
    		     Sucursal, 
    		     ModuloID, 
    		     IDPago, 
    		     ModuloPago,
    		     TipoTercero,
    		     --BUG1161
    		     PorcentajeDeducible,
    		     EsComplemento,
    		     EsRetencion,
    		     EsIEPS)
		  SELECT Modulo, 
				 @Estacion, 
				 Empresa, 
				 Mov, 
				 MovID, 
				 Pago, 
				 PagoID, 
				 Proveedor, 
				 Tasa, 
				 FechaEmision, 
				 @FechaPago, 
				 --BUG1560
				 @Ejercicio, 
				 @Periodo, 
				 Concepto, 
				 ConceptoClave, 
				 ConceptoSAT, 
				 @Factor,
				 --BUG1161
                 --CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(Importe)*@Factor,0) ELSE ISNULL(Importe,0) END,--*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
		         --CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(IVA)*@Factor,0) ELSE ISNULL(IVA,0) END,--*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
		         --CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(IEPS)*@Factor,0) ELSE ISNULL(IEPS,0) END,--*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
                 --CASE @EsIEPS WHEN 1 THEN 0 ELSE ISNULL(SUM(Retencion2)*@Factor,0) END,--*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
                 --CASE @EsIEPS WHEN 1 THEN 0 ELSE ISNULL(SUM(Retencion1)*@Factor,0) END,--*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
                 CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(Importe),0) ELSE ISNULL(Importe,0) END,
                 CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(IVA),0) ELSE ISNULL(IVA,0) END,
                 CASE @EsRetencion WHEN 0 THEN ISNULL(SUM(IEPS),0) ELSE ISNULL(IEPS,0) END,
                 CASE @EsIEPS WHEN 1 THEN 0 ELSE ISNULL(SUM(Retencion2),0) END,
                 CASE @EsIEPS WHEN 1 THEN 0 ELSE ISNULL(SUM(Retencion1),0) END,
                 @Dinero, 
                 @DineroID, 
                 @ImportePago, 
                 Sucursal, 
                 ModuloID, 
                 @IDPago, 
                 @ModuloPago,
                 dbo.fnCFDIRetTipoTercero(Proveedor),
                 --BUG1161
    		     PorcentajeDeducible,
    		     ISNULL(EsComplemento, 0),
    		     ISNULL(EsRetencion, 0),
    		     ISNULL(EsIEPS, 0)
		    FROM #Documentos 
		   WHERE Empresa = @Empresa AND Mov = @Aplica AND MovID = @AplicaID AND Pago = @Mov AND PagoID = @MovID
		--     AND Concepto  <> (SELECT min(Concepto) FROM GastoD WHERE id = ID AND (Timbrado <> 1))
		   --BUG1560
		   GROUP BY Modulo, Empresa, Mov, MovID, Pago, PagoID, Proveedor, Tasa, FechaEmision, /*Ejercicio, Periodo, */Concepto, ConceptoClave, ConceptoSAT, Sucursal, ModuloID, PorcentajeDeducible, EsComplemento, EsRetencion, EsIEPS,
		            Importe, IVA, IEPS
    END

	IF (SELECT COUNT(Concepto) FROM GastoD WHERE id = (SELECT MAX(ModuloID) FROM CFDIRetencionD  WHERE EstacionTrabajo = @Estacion) AND Timbrado <> 1 ) > 0
	   DELETE FROM CFDIRetencionD WHERE ModuloID = (SELECT MAX(ModuloID) FROM CFDIRetencionD  WHERE EstacionTrabajo = @Estacion) AND Concepto IN
	   (SELECT Concepto FROM GastoD WHERE ID = (SELECT MAX(ModuloID) FROM CFDIRetencionD  WHERE EstacionTrabajo = @Estacion) AND Timbrado = 1) 
  END
  
  EXEC spCFDIRetencionRecalcEncabezado @Estacion
END
GO

/**************** spCFDIRetencionObtenerDocumentoIEPS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerDocumentoIEPS') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerDocumentoIEPS
GO
CREATE PROC spCFDIRetencionObtenerDocumentoIEPS
			@Estacion			int,
			@Empresa			varchar(5),
			@FechaD				datetime,
			@FechaA				datetime,
			@Proveedor			varchar(10)
--//WITH ENCRYPTION
AS
BEGIN  
  INSERT INTO #Documentos(
		   Modulo,    ID,   Empresa,   Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   ConceptoClave,   Concepto,     Importe,               IVA,                                         IEPS,                                                                                                                                                ISAN,    Retencion1,                       Retencion2,                       ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible, EsComplemento, EsRetencion, EsIEPS)
    SELECT 'COMS',  g.ID, g.Empresa, p.Mov, p.MovID, g.Mov, g.MovID, g.Ejercicio, g.Periodo, g.FechaEmision, g.Proveedor, d.Articulo,      d.Articulo, ctc.SubTotal*g.TipoCambio, ISNULL(ctc.Impuesto1Total,0.0)*g.TipoCambio, CASE Art.CFDIRetIEPSImpuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total,0.0)*g.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*g.TipoCambio END, 0.0, ctc.Retencion1Total*g.TipoCambio, ctc.Retencion2Total*g.TipoCambio, Art.CFDIRetClave, g.Sucursal, g.ID,       100,                 0,             0,           1
     FROM Compra g
     JOIN CompraD d ON g.ID = d.ID 
     JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID      
     JOIN #Pagos p ON g.ID = p.AplicaModuloID
     JOIN Version ver ON 1=1
     JOIN Art ON d.Articulo = Art.Articulo
    WHERE g.Empresa = @Empresa
      AND p.AplicaModulo = 'COMS'
      AND ISNULL(p.EsIEPS, 0) = 1      
      AND g.Proveedor = @Proveedor

  INSERT INTO #Documentos(
		    Modulo,	  ID,   Empresa,   Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   Importe,              BaseIVA,                                                                                                                                Tasa,                                                                     IVA,                                    ConceptoClave,   Concepto, IEPS,                                  ISAN,   Retencion1,               Retencion2,                       ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible,                EsComplemento, EsRetencion, EsIEPS)
	 SELECT 'GAS',  g.ID, g.Empresa, p.Mov, p.MovID, g.Mov, g.MovID, g.Ejercicio, g.Periodo, g.FechaEmision, g.Acreedor,  d.Importe*g.TipoCambio, (ISNULL(d.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(d.Impuestos2,0.0) ELSE 0.0 END)*g.TipoCambio, CASE WHEN NULLIF(d.Impuestos,0.0) IS NULL THEN NULL ELSE d.Impuesto1 END, ISNULL(d.Impuestos,0.0)*g.TipoCambio, d.Concepto,      d.Concepto, ISNULL(d.Impuestos2,0.0)*g.TipoCambio, 0.0,  d.Retencion*g.TipoCambio, d.Retencion2*g.TipoCambio, Concepto.CFDIRetClave, g.Sucursal, g.ID,       ISNULL(d.PorcentajeDeducible, 100), 0,             0,           1
     FROM Gasto g
     JOIN GastoD d ON g.ID = d.ID 
     JOIN #Pagos p ON g.ID = p.AplicaModuloID
     JOIN Version ver ON 1=1
     JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'     
     JOIN Prov pr ON g.Acreedor = pr.Proveedor
     LEFT OUTER JOIN Pais ON pr.Pais = Pais.Pais
    WHERE g.Empresa = @Empresa
      AND p.AplicaModulo = 'GAS'
      AND ISNULL(p.EsIEPS, 0) = 1      
      AND g.Acreedor = @Proveedor
  RETURN
END
GO

/**************** spCFDIRetencionObtenerDocumento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerDocumento') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerDocumento
GO
CREATE PROC spCFDIRetencionObtenerDocumento
			@Estacion			int,
			@Empresa			varchar(5),
			@FechaD				datetime,
			@FechaA				datetime,
			@Proveedor			varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RetencionAlPago		bit,
          @Concepto             varchar(50)
  
  CREATE TABLE #Retenciones(
    --BUG1357
    ID			int,
    Mov			varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    MovID		varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    OrigenTipo	varchar(5)	COLLATE DATABASE_DEFAULT NULL,
    Origen		varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    OrigenID	varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    Concepto	varchar(50)	COLLATE DATABASE_DEFAULT NULL
    )
  
  SELECT @RetencionAlPago = RetencionAlPago FROM EmpresaCfg2 WHERE Empresa = @Empresa

    SELECT @Concepto = Cxp.Concepto
      FROM #Pagos p
      JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID
      JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
      LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
      JOIN Version ver ON 1 = 1
     WHERE Cxp.Empresa = @Empresa
       AND ISNULL(Cxp.OrigenTipo, '') <> 'RETENCION'
       AND ISNULL(p.EsRetencion, 0) = 1
       AND Cxp.Concepto IS NOT NULL
  
  INSERT INTO #Retenciones(
		       ID,     Mov,     MovID,     OrigenTipo,     Origen,     OrigenID,     Concepto)
  	SELECT Cxp.ID, Cxp.Mov, Cxp.MovID, Cxp.OrigenTipo, Cxp.Origen, Cxp.OrigenID, CASE WHEN ISNULL(Cxp.Concepto,'') = '' THEN @Concepto ELSE Cxp.Concepto END
      FROM #Pagos p
      JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID --AND ISNULL(OrigenTipo, '') IN('', 'CXP')
      JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
      LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
      JOIN Version ver ON 1 = 1
     WHERE Cxp.Empresa = @Empresa
       AND ISNULL(Cxp.OrigenTipo, '') <> 'RETENCION'
       AND ISNULL(p.EsRetencion, 0) = 1

  INSERT INTO #Retenciones(
		       ID,     Mov,     MovID,    OrigenTipo,    Origen,    OrigenID,     Concepto)
  	SELECT Cxp.ID, Cxp.Mov, Cxp.MovID, oo.OrigenTipo, oo.Origen, oo.OrigenID, CASE WHEN ISNULL(Cxp.Concepto,'') = '' THEN @Concepto ELSE Cxp.Concepto END
      FROM #Pagos p
      JOIN Cxp ON p.Empresa = Cxp.Empresa AND p.Aplica = Cxp.Mov AND p.AplicaID = Cxp.MovID --AND ISNULL(OrigenTipo, '') IN('', 'CXP')
      LEFT OUTER JOIN Cxp O ON Cxp.Empresa = O.Empresa AND Cxp.Origen = O.Mov AND Cxp.OrigenID = O.MovID
      LEFT OUTER JOIN CxpD ON O.ID = CxpD.ID      
      LEFT OUTER JOIN Cxp oo ON O.Origen = oo.Mov AND O.OrigenID = oo.MovID
      JOIN Prov ON Cxp.Proveedor = Prov.Proveedor
      LEFT OUTER JOIN Pais ON Prov.Pais = Pais.Pais
      JOIN Version ver ON 1 = 1
     WHERE Cxp.Empresa = @Empresa
       AND ISNULL(Cxp.OrigenTipo, '') = 'RETENCION'
       AND ISNULL(p.EsRetencion, 0) = 1

   INSERT INTO #Documentos(
		   Modulo,   ID,   Empresa,   Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   ConceptoClave,   Concepto, Retencion1,                                                                           Retencion2,                                                                                     ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible,                EsComplemento, EsRetencion,   Importe,              IVA,                                  IEPS)
    SELECT 'GAS',  g.ID, g.Empresa, p.Mov, p.MovID, r.Mov, r.MovID, g.Ejercicio, g.Periodo, g.FechaEmision, g.Acreedor,  d.Concepto,      d.Concepto, /*CASE SUBSTRING(r.Concepto, 1, 3) WHEN 'ISR' THEN*/ d.Retencion*g.TipoCambio/* ELSE 0 END*/, /*CASE SUBSTRING(r.Concepto, 1, 3) WHEN 'IVA' THEN */d.Retencion2*g.TipoCambio /*ELSE 0 END*/, Concepto.CFDIRetClave, g.Sucursal, g.ID,       ISNULL(d.PorcentajeDeducible, 100), 0,             1,           d.Importe*g.TipoCambio, ISNULL(d.Impuestos,0.0)*g.TipoCambio, ISNULL(d.Impuestos2,0.0)*g.TipoCambio
     FROM Gasto g
     JOIN GastoD d ON g.ID = d.ID 
     JOIN #Retenciones r ON g.Mov = r.Origen AND g.MovID = r.OrigenID --AND d.Concepto = ISNULL(NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(r.Concepto, 'IVA', ''), 'ISR', ''))), ''), d.Concepto)
     JOIN #Pagos p ON p.Aplica = r.Mov AND p.AplicaID = r.MovID
     JOIN Version ver ON 1=1
     JOIN Concepto ON d.Concepto = Concepto.Concepto AND Concepto.Modulo IN('GAS', 'COMSG')
    WHERE g.Empresa = @Empresa
      AND r.OrigenTipo = 'GAS'
      AND ISNULL(p.EsRetencion, 0) = 1
      AND g.Acreedor = @Proveedor

  INSERT INTO #Documentos(
		   Modulo,    ID,   Empresa,   Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   ConceptoClave,   Concepto, Retencion1,                                                                                   Retencion2,                                                                                       ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible, EsComplemento, EsRetencion,    Importe,               IVA,                                         IEPS,                                                                                                                                                ISAN)
    SELECT 'COMS',  g.ID, g.Empresa, p.Mov, p.MovID, r.Mov, r.MovID, g.Ejercicio, g.Periodo, g.FechaEmision, g.Proveedor, d.Articulo,      d.Articulo, /*CASE SUBSTRING(r.Concepto, 1, 3) WHEN 'ISR' THEN */ctc.Retencion1Total*g.TipoCambio/* ELSE 0 END*/,/* CASE SUBSTRING(r.Concepto, 1, 3) WHEN 'IVA' THEN */ctc.Retencion2Total*g.TipoCambio/* ELSE 0 END*/, Art.CFDIRetClave, g.Sucursal, g.ID,       100,                 0,             1,          ctc.SubTotal*g.TipoCambio, ISNULL(ctc.Impuesto1Total,0.0)*g.TipoCambio, CASE Art.CFDIRetIEPSImpuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total,0.0)*g.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*g.TipoCambio END, 0.0
     FROM Compra g
     JOIN CompraD d ON g.ID = d.ID 
     JOIN CompraTCalc ctc ON ctc.RenglonSub = d.RenglonSub AND ctc.Renglon = d.Renglon AND ctc.ID = d.ID      
     JOIN #Retenciones r ON g.Mov = r.Origen AND g.MovID = r.OrigenID --AND d.Concepto = ISNULL(NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(r.Concepto, 'IVA', ''), 'ISR', ''))), ''), d.Concepto)
     JOIN #Pagos p ON p.Aplica = r.Mov AND p.AplicaID = r.MovID
     JOIN Version ver ON 1=1
     JOIN Art ON d.Articulo = Art.Articulo
    WHERE g.Empresa = @Empresa
      AND r.OrigenTipo = 'COMS'
      AND ISNULL(p.EsRetencion, 0) = 1      
      AND g.Proveedor = @Proveedor

  RETURN
END
GO

/**************** spCFDIRetencionObtenerGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerGasto') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerGasto
GO
CREATE PROC spCFDIRetencionObtenerGasto
			@Estacion   int,
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@Proveedor  varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @MovRetencion		varchar(20);

  WITH Cte
  AS (
 SELECT 0 [Orden], D.Empresa, M.DModulo [ModuloRaiz], M.DID [IDRaiz], M.DMov [MovRaiz], M.DMovID [MovIDRaiz], M.OModulo, M.OID, M.OMov, M.OMovID 
   FROM MovFlujo M
   JOIN Dinero D ON M.DID = D.ID 
    AND M.DModulo = 'DIN'
    AND D.Empresa = @Empresa
    AND D.FechaEmision >= @FechaD
    AND D.FechaEmision <= @FechaA
    AND D.Estatus = 'CONCLUIDO'
  UNION ALL   
 SELECT C.Orden+1, C.Empresa, C.ModuloRaiz, C.IDRaiz, C.MovRaiz, C.MovIDRaiz, M.OModulo, M.OID, M.OMov, M.OMovID
   FROM MovFlujo M
   JOIN Cte C ON M.DModulo = C.OModulo AND M.DID = C.OID
   )
 INSERT INTO #Movtos(Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, OModulo, OID, OMov, OMovID)
      SELECT Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, OModulo, OID, OMov, OMovID
        FROM Cte ORDER BY 4,1

 --- BUSCAR HACIA ADELANTE
 INSERT INTO #Movtos2(Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, OModulo, OID, OMov, OMovID)
 (
 SELECT D.Empresa, M.DModulo [ModuloRaiz], M.DID [IDRaiz], M.DMov [MovRaiz], M.DMovID [MovIDRaiz], M.OModulo, M.OID, M.OMov, M.OMovID
   FROM MovFlujo M
   JOIN Dinero D ON M.OID = D.ID 
    AND M.OModulo = 'DIN'
    AND D.Empresa = @Empresa
    AND D.FechaEmision >= @FechaD
    AND D.FechaEmision <= @FechaA
    AND D.Estatus = 'CONCLUIDO'
   );

 WITH Cte
  AS (
  SELECT 0 [Orden], D.Empresa, M.DModulo [ModuloRaiz], M.DID [IDRaiz], M.DMov [MovRaiz], M.DMovID [MovIDRaiz], M.OModulo, M.OID, M.OMov, M.OMovID 
    FROM MovFlujo M
    JOIN cxp D ON M.DID = D.ID 
     AND M.DModulo = 'CXP'
     AND D.Empresa = @Empresa
     AND D.FechaEmision >= @FechaD
     AND D.FechaEmision <= @FechaA
     AND D.Estatus = 'PENDIENTE'
   UNION ALL   
  SELECT C.Orden+1, C.Empresa, C.ModuloRaiz, C.IDRaiz, C.MovRaiz, C.MovIDRaiz, M.OModulo, M.OID, M.OMov, M.OMovID
    FROM MovFlujo M
    JOIN Cte C ON M.DModulo = C.OModulo AND M.DID = C.OID
   )
 INSERT INTO #Movtos3(Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, OModulo, OID, OMov, OMovID)
     SELECT Empresa, ModuloRaiz, IDRaiz, MovRaiz, MovIDRaiz, OModulo, OID, OMov, OMovID
       FROM Cte ORDER BY 4,1
                                                                            
  DELETE FROM #Movtos WHERE IDRaiz IN (SELECT OID FROM #Movtos2 WHERE MovRaiz = 'Cheque Devuelto')
  DELETE FROM #Movtos WHERE IDRaiz NOT IN (SELECT DISTINCT IDRaiz FROM #Movtos WHERE OMov = 'Retencion')
  DELETE FROM #Movtos WHERE OMovID IN (SELECT OMovID FROM #Movtos3 GROUP BY OMovID)
--//**
  
  SELECT @MovRetencion = CxpRetencion FROM EmpresaCfgMov WHERE Empresa = @Empresa
 
  INSERT INTO #Pagos(
		    Modulo,  ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Aplica,   AplicaID, Importe,                                                                                                                                           TipoCambio,   Dinero,   DineroID,   FechaConciliacion,       EsComprobante,   DineroMov,   DineroMovID)
	 --******************************************************************************************************************************--		    
	 --NUEVA CONDICION MOVIMIENTOS RETENCIONES EN #Pagos
	 --******************************************************************************************************************************--
	 SELECT 'GAS', c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov,    c.MovID,   SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio), c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion, 1,             c.Dinero,    c.DineroID
       FROM Gasto c
       LEFT OUTER JOIN #Movtos M ON M.OModulo = 'GAS' AND c.id = M.OID
       JOIN GastoD cd ON cd.ID = c.ID
       JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
       LEFT OUTER JOIN CFDIRetPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
       JOIN CFDIRetGastoAdicion ON c.Mov = CFDIRetGastoAdicion.Mov
       JOIN Prov ON c.Acreedor = Prov.Proveedor
      WHERE c.Estatus IN ('CONCLUIDO')
        ----AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)
        AND cd.Importe IS NOT NULL
        AND c.Empresa = @Empresa
        AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA
        AND Prov.Proveedor = ISNULL(@Proveedor, Prov.Proveedor)
        AND c.CFDRetencionTimbrado = 0
   GROUP BY c.ID, c.Empresa, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Mov, c.MovID, c.TipoCambio, c.Dinero, c.DineroID, c.DineroFechaConciliacion
 
  INSERT INTO #Documentos(
		    Modulo,	   ID,   Empresa,   Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   Importe,              BaseIVA,                                                                                                                                  Tasa,                                                                       IVA,                                      ConceptoClave,    Concepto, IEPS,                                   ISAN,   Retencion1,                Retencion2,                       ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible)
	 SELECT 'GAS',   c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Acreedor, cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END, ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,      cd.Concepto, ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, Concepto.CFDIRetClave, c.Sucursal, c.ID,       ISNULL(cd.PorcentajeDeducible, 100)
       FROM Gasto c
       JOIN #Movtos M ON M.OModulo = 'GAS' AND c.id = M.OID
       JOIN GastoD cd ON cd.ID = c.ID
       JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
       JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
       JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(RTRIM(cd.AcreedorRef), ''), c.Acreedor)
       LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
       LEFT OUTER JOIN CFDIRetPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
       JOIN Version ver ON 1=1
       JOIN CFDIRetGastoAdicion ON c.Mov = CFDIRetGastoAdicion.Mov
      WHERE c.Estatus IN ('CONCLUIDO')
        AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)        
        AND cd.Importe IS NOT NULL
        AND c.Empresa = @Empresa
        AND mt.Clave NOT IN('GAS.CCH', 'GAS.GTC', 'GAS.C', 'GAS.CP')
        AND p.Proveedor = ISNULL(@Proveedor, p.Proveedor)        
        AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA               
        AND (ISNULL(mt.SubClave, '') <> 'GAS.ESTRETSAT' OR ISNULL(mt.SubClave, '') <> 'GAS.ESTRETSATENEJAC' OR ISNULL(mt.SubClave, '') <> 'GAS.ESTRETSATINT') --AGREGANDO COMPLEMENTO DIVIDENDOS, ENAJENACION E INTERESES      
        AND (ISNULL(mt.SubClave, '') = 'GAS.INT' or ISNULL(mt.SubClave, '') = 'GAS.DIV' or ISNULL(mt.SubClave, '') = 'GAS.ENJ')  

        INSERT INTO #Documentos(
		     Modulo,  ID,   Empresa,  Pago,  PagoID,  Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,   Proveedor,   Importe,              BaseIVA,                                                                                                                                  Tasa,                                                                       IVA,                                      ConceptoClave,    Concepto, IEPS,                                   ISAN,   Retencion1,                Retencion2,                       ConceptoSAT,    Sucursal,   ModuloID, PorcentajeDeducible,                 EsComplemento)
	 --******************************************************************************************************************************--		    
	 --NUEVA CONDICION MOVIMIENTOS RETENCIONES EN #Documentos
	 --******************************************************************************************************************************--		    
	   SELECT 'GAS', c.ID, c.Empresa, c.Mov, c.MovID, c.Mov, c.MovID, c.Ejercicio, c.Periodo, c.FechaEmision, c.Acreedor, cd.Importe*c.TipoCambio, (ISNULL(cd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(cd.Impuestos2,0.0) ELSE 0.0 END)*c.TipoCambio, CASE WHEN NULLIF(cd.Impuestos,0.0) IS NULL THEN NULL ELSE cd.Impuesto1 END, ISNULL(cd.Impuestos,0.0)*c.TipoCambio, cd.Concepto,      cd.Concepto, ISNULL(cd.Impuestos2,0.0)*c.TipoCambio, 0.0, cd.Retencion*c.TipoCambio, cd.Retencion2*c.TipoCambio, Concepto.CFDIRetClave, c.Sucursal, c.ID,       ISNULL(cd.PorcentajeDeducible, 100), 1
       FROM Gasto c
       LEFT OUTER JOIN #Movtos M ON M.OModulo = 'GAS' AND c.id = M.OID
       JOIN GastoD cd ON cd.ID = c.ID
       JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
       JOIN Concepto ON cd.Concepto = Concepto.Concepto AND Concepto.Modulo = 'GAS'
       JOIN Prov p ON c.Acreedor = p.Proveedor
       LEFT OUTER JOIN Pais ON p.Pais = Pais.Pais
       LEFT OUTER JOIN CFDIRetPagoConciliado mtdc ON mtdc.Mov = c.Mov AND ISNULL(mtdc.Aplica, c.Mov) = c.Mov     
       JOIN Version ver ON 1=1
       JOIN CFDIRetGastoAdicion ON c.Mov = CFDIRetGastoAdicion.Mov
      WHERE c.Estatus IN ('CONCLUIDO')
        --AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXP') AND DMov <> @MovRetencion)      
        AND cd.Importe IS NOT NULL
        AND c.Empresa = @Empresa
        AND (ISNULL(mt.SubClave, '') = 'GAS.ESTRETSAT' OR ISNULL(mt.SubClave, '') = 'GAS.ESTRETSATENEJAC' OR ISNULL(mt.SubClave, '') = 'GAS.ESTRETSATINT' 
         OR ISNULL(mt.SubClave, '') = 'GAS.INT' OR ISNULL(mt.SubClave, '') = 'GAS.DIV' OR ISNULL(mt.SubClave, '') = 'GAS.ENJ'
         OR ISNULL(mt.SubClave, '') = 'GAS.EST') --AGREGANDO COMPLEMENTO DIVIDENDOS, ENAJENACION E INTERESES
        AND p.Proveedor = ISNULL(@Proveedor, p.Proveedor)        
        AND CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END BETWEEN @FechaD AND @FechaA  

        --DELETE FROM #Documentos WHERE ID IN (SELECT OID FROM #Movtos3 WHERE OModulo = 'GAS')      

END
GO

/**************** spCFDIRetencionObtenerPagoIEPS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerPagoIEPS') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerPagoIEPS
GO
CREATE PROC spCFDIRetencionObtenerPagoIEPS
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
            @Proveedor      varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @MovRetencion			varchar(20),
          @MovGastoDiverso  varchar(20),
		      @ID					      int,
		      @IDAnt				    int,
		      @Aplica				    varchar(20),
		      @AplicaAnt			  varchar(20),
		      @AplicaID				  varchar(20),
		      @AplicaIDAnt			varchar(20),
		      @IDAplica				  int,
		      @OrigenModulo			varchar(5),
		      @OrigenModuloID		int,
		      @OMov					    varchar(20),
		      @OMovID				    varchar(20),
		      @MovTipo				  varchar(20),
		      @Mov					    varchar(20),
		      @MovID				    varchar(20),
		      --REQ1747
		      @Directo          bit
		    
  SELECT @MovRetencion = CxpRetencion, @MovGastoDiverso = CxpGastoDiverso FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
  CREATE TABLE #Cheques(
	                      ID			int, 
	                      Empresa	varchar(5)  COLLATE DATABASE_DEFAULT, 
	                      Mov			varchar(20) COLLATE DATABASE_DEFAULT, 
                        MovID		varchar(20) COLLATE DATABASE_DEFAULT,
                        MovTipo	varchar(20) COLLATE DATABASE_DEFAULT,
	                      --REQ1747
	                      Directo bit NULL
    )

  CREATE TABLE #Aplica(
	                      ID				    int, 
	                      OID				    int, 
	                      AplicaModulo  varchar(20) COLLATE DATABASE_DEFAULT NULL, 
	                      Aplica			  varchar(20) COLLATE DATABASE_DEFAULT NULL, 
	                      AplicaID		  varchar(20) COLLATE DATABASE_DEFAULT NULL, 
	                      OMov			    varchar(20) COLLATE DATABASE_DEFAULT, 
	                      OMovID			  varchar(20) COLLATE DATABASE_DEFAULT,
    )

  INSERT INTO #Cheques(ID,   Empresa,   Mov,   MovID,    MovTipo, Directo) --REQ1747
                SELECT d.ID, d.Empresa, d.Mov, d.MovID, mt.Clave, d.Directo --REQ1747
                  FROM Dinero d
                  JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
                 WHERE d.Empresa =  @Empresa
                   AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
                   AND mt.Clave IN('DIN.CH', 'DIN.CHE', 'DIN.E')
                   AND d.FechaEmision BETWEEN @FechaD AND @FechaA
                   AND d.Contacto = @Proveedor AND d.ContactoTipo = 'Proveedor'
                   AND ISNULL(d.CFDRetencionTimbrado, 0) = 0
  
  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM #Cheques
     WHERE ID > @IDAnt

    IF @ID IS NULL BREAK
      
    SELECT @IDAnt = @ID

    SELECT @MovTipo = NULL, @Mov = NULL, @MovID = NULL, @Directo=NULL --REQ1747
    
	--REQ1747
    SELECT @MovTipo = MovTipo, @Mov = Mov, @MovID = MovID, @Directo=Directo FROM #Cheques WHERE ID = @IDAnt
    
	--REQ1747
    --IF @MovTipo IN('DIN.CH', 'DIN.CHE')
	IF @Directo=0
    BEGIN
      SELECT @AplicaAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Aplica = MIN(Aplica)
          FROM DineroD
         WHERE ID = @ID
           AND Aplica > @AplicaAnt
      
        IF @Aplica IS NULL BREAK
        
        SELECT @AplicaAnt = @Aplica

        SELECT @AplicaIDAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @AplicaID = MIN(AplicaID)
            FROM DineroD
           WHERE ID = @ID
             AND Aplica = @Aplica
             AND AplicaID > @AplicaIDAnt

          IF @AplicaID IS NULL BREAK
        
          SELECT @AplicaIDAnt = @AplicaID
          
          SELECT @IDAplica = NULL
          
          SELECT @IDAplica = OID FROM MovFlujo WHERE OModulo = 'DIN' AND DModulo = 'DIN' AND DID = @ID AND OMov = @Aplica AND OMovID = @AplicaID

          EXEC spMovPos @@SPID, 'DIN', @IDAplica

          IF NOT EXISTS(SELECT DMov FROM MovPos WHERE Estacion = @@SPID AND Tipo = 'ORIGEN' AND DModulo = 'CXP' AND DMov IN(@MovRetencion, @MovGastoDiverso))
          BEGIN
            SELECT @OrigenModulo = NULL, @OrigenModuloID = NULL
            SELECT @OrigenModulo = OrigenModulo, @OrigenModuloID = OrigenModuloID FROM MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @IDAplica

            IF @OrigenModulo IN('COMS', 'GAS')
            BEGIN
              IF @OrigenModulo = 'COMS'
              BEGIN
                IF EXISTS(
                SELECT d.Impuesto2Total
                  FROM CompraTCalc d
                  JOIN Art ON d.Articulo = Art.Articulo 
                 WHERE d.ID = @OrigenModuloID
                   AND Art.CFDIRetIEPSImpuesto = 'Impuesto 2'
                   AND NULLIF(Impuesto2Total, 0) IS NOT NULL
                UNION ALL
                SELECT d.Impuesto3Total
                  FROM CompraTCalc d
                  JOIN Art ON d.Articulo = Art.Articulo 
                 WHERE d.ID = @OrigenModuloID
                   AND Art.CFDIRetIEPSImpuesto = 'Impuesto 3'
                   AND NULLIF(Impuesto3Total, 0) IS NOT NULL               
                 )
                 BEGIN
                   SELECT @OMov = NULL, @OMovID = NULL               
                   SELECT @OMov = Mov, @OMovID = MovID FROM Compra WHERE ID = @OrigenModuloID
                
                   INSERT INTO #Aplica(
		                     ID,  OID,             OMov,  OMovID,  AplicaModulo,  Aplica,  AplicaID)
                     SELECT @ID, @OrigenModuloID, @OMov, @OMovID, @OrigenModulo, @Aplica, @AplicaID
                 END
                 ELSE
                   DELETE #Cheques WHERE ID = @ID
              END

              IF @OrigenModulo = 'GAS'
              BEGIN
                IF EXISTS(
                SELECT d.Impuestos2
                  FROM GastoD d
                 WHERE d.ID = @OrigenModuloID
                   AND NULLIF(Impuestos2, 0) IS NOT NULL
                 )
                 BEGIN
                   SELECT @OMov = NULL, @OMovID = NULL               
                   SELECT @OMov = Mov, @OMovID = MovID FROM Gasto WHERE ID = @OrigenModuloID
                 
                   INSERT INTO #Aplica(
		                     ID,  OID,             OMov,  OMovID,  AplicaModulo,  Aplica,  AplicaID)
                     SELECT @ID, @OrigenModuloID, @OMov, @OMovID, @OrigenModulo, @Aplica, @AplicaID
                 END
                 ELSE
                   DELETE #Cheques WHERE ID = @ID
              END
            END
          END
        END
      END
    END
    ELSE
    BEGIN
      EXEC spMovPos @@SPID, 'DIN', @ID

      IF NOT EXISTS(SELECT DMov FROM MovPos WHERE Estacion = @@SPID AND Tipo = 'ORIGEN' AND DModulo = 'CXP' AND DMov IN(@MovRetencion, @MovGastoDiverso))
      BEGIN
        SELECT @OrigenModulo = NULL, @OrigenModuloID = NULL
        SELECT @OrigenModulo = OrigenModulo, @OrigenModuloID = OrigenModuloID FROM MovImpuesto WHERE Modulo = 'DIN' AND ModuloID = @ID

        IF @OrigenModulo IN('COMS', 'GAS')
        BEGIN
          IF @OrigenModulo = 'COMS'
          BEGIN
            IF EXISTS(
            SELECT d.Impuesto2Total
              FROM CompraTCalc d
              JOIN Art ON d.Articulo = Art.Articulo 
             WHERE d.ID = @OrigenModuloID
               AND Art.CFDIRetIEPSImpuesto = 'Impuesto 2'
               AND NULLIF(Impuesto2Total, 0) IS NOT NULL
            UNION ALL
            SELECT d.Impuesto3Total
              FROM CompraTCalc d
              JOIN Art ON d.Articulo = Art.Articulo 
             WHERE d.ID = @OrigenModuloID
               AND Art.CFDIRetIEPSImpuesto = 'Impuesto 3'
               AND NULLIF(Impuesto3Total, 0) IS NOT NULL               
             )
             BEGIN
               SELECT @OMov = NULL, @OMovID = NULL               
               SELECT @OMov = Mov, @OMovID = MovID FROM Compra WHERE ID = @OrigenModuloID
                
               INSERT INTO #Aplica(
		                 ID,  OID,             OMov,  OMovID,  AplicaModulo,  Aplica,  AplicaID)
                 SELECT @ID, @OrigenModuloID, @OMov, @OMovID, @OrigenModulo, @Mov,    @MovID
             END
             ELSE
               DELETE #Cheques WHERE ID = @ID
          END

          IF @OrigenModulo = 'GAS'
          BEGIN
            IF EXISTS(
            SELECT d.Impuestos2
              FROM GastoD d
             WHERE d.ID = @OrigenModuloID
               AND NULLIF(Impuestos2, 0) IS NOT NULL
             )
             BEGIN
               SELECT @OMov = NULL, @OMovID = NULL               
               SELECT @OMov = Mov, @OMovID = MovID FROM Gasto WHERE ID = @OrigenModuloID
                 
               INSERT INTO #Aplica(
		                 ID,  OID,             OMov,  OMovID,  AplicaModulo,  Aplica,  AplicaID)
                 SELECT @ID, @OrigenModuloID, @OMov, @OMovID, @OrigenModulo, @Mov,    @MovID
             END
             ELSE
               DELETE #Cheques WHERE ID = @ID
          END
        END
      END              
    END
  END

  --Insertamos Los Pagos
  INSERT INTO #Pagos( 
			Modulo,  ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,    AplicaModulo,    AplicaModuloID,   Aplica,   AplicaID,     Importe,                TipoCambio,   Dinero,   DineroID,   FechaConciliacion,   DineroMov,   DineroMovID, EsIEPS)
    SELECT 'DIN',  d.ID, d.Empresa, d.Mov, d.MovID, d.Ejercicio, d.Periodo, d.FechaEmision, dd.AplicaModulo, dd.OID,           dd.OMov,  dd.OMovID,   did.Importe*d.TipoCambio, d.TipoCambio, d.Mov,    d.MovID,    d.FechaConciliacion, d.Mov,       d.MovID,       1
      FROM Dinero d
      JOIN DineroD did ON d.ID = did.ID
      JOIN #Cheques c ON d.ID = c.ID
      JOIN #Aplica dd ON d.ID = dd.id --AND did.Aplica = dd.Aplica AND did.AplicaID = dd.AplicaID --REQ1747
      JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
     WHERE d.Empresa =  @Empresa
       AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
       --AND mt.Clave IN('DIN.CH', 'DIN.CHE') --REQ1747
       AND ISNULL(did.Aplica,'1') = (CASE WHEN c.Directo=1 then '1' ELSE dd.Aplica END) --REQ1747
	   AND ISNULL(did.AplicaID,'1') = (CASE WHEN c.Directo=1 then '1' ELSE dd.AplicaID END) --REQ1747
       AND d.FechaEmision BETWEEN @FechaD AND @FechaA

  --REQ1747
  --Insertamos Los Pagos
--  INSERT INTO #Pagos( 
--			Modulo,  ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,    AplicaModulo,    AplicaModuloID,   Aplica,   AplicaID,   Importe,                TipoCambio,   Dinero,   DineroID,   FechaConciliacion,   DineroMov,   DineroMovID, EsIEPS)
--    SELECT 'DIN',  d.ID, d.Empresa, d.Mov, d.MovID, d.Ejercicio, d.Periodo, d.FechaEmision, dd.AplicaModulo, dd.OID,           dd.OMov,  dd.OMovID,   d.Importe*d.TipoCambio, d.TipoCambio, d.Mov,    d.MovID,    d.FechaConciliacion, d.Mov,       d.MovID,       1
--      FROM Dinero d
--      JOIN #Cheques c ON d.ID = c.ID
--      JOIN #Aplica dd ON d.ID = dd.id --AND d.Mov = dd.Aplica AND d.MovID = dd.AplicaID      
--      JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
--     WHERE d.Empresa =  @Empresa
--       AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
--       AND mt.Clave IN('DIN.E')
--       AND d.FechaEmision BETWEEN @FechaD AND @FechaA
       
  RETURN
END
GO

/**************** spCFDIRetencionObtenerPago ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerPago') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerPago
GO
CREATE PROC spCFDIRetencionObtenerPago
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
            @Proveedor      varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @MovRetencion			varchar(20),
		  @ID					int,
		  @IDAnt				int,
		  @Aplica				varchar(20),
		  @AplicaAnt			varchar(20),
		  @AplicaID				varchar(20),
		  @AplicaIDAnt			varchar(20),
		  @IDAplica				int,
		  @MovTipo				varchar(20),
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  --REQ1747
		  @Directo              bit
  
  SELECT @MovRetencion = CxpRetencion FROM EmpresaCfgMov WHERE Empresa = @Empresa
    
  CREATE TABLE #Cheques(
	ID			int, 
	Empresa		varchar(5)  COLLATE DATABASE_DEFAULT, 
	Mov			varchar(20) COLLATE DATABASE_DEFAULT, 
    MovID		varchar(20) COLLATE DATABASE_DEFAULT,
    MovTipo		varchar(20) COLLATE DATABASE_DEFAULT,
	--REQ1747
	Directo     bit
    )

  CREATE TABLE #Aplica(
	ID				int, 
	OID				int, 
	Aplica			varchar(20) COLLATE DATABASE_DEFAULT NULL, 
	AplicaID		varchar(20) COLLATE DATABASE_DEFAULT NULL, 
	OMov			varchar(20) COLLATE DATABASE_DEFAULT, 
	OMovID			varchar(20) COLLATE DATABASE_DEFAULT,
    )

  INSERT INTO #Cheques(
		   ID,   Empresa,   Mov,   MovID,    MovTipo, Directo) --REQ1747
  SELECT d.ID, d.Empresa, d.Mov, d.MovID, mt.Clave, d.Directo --REQ1747
    FROM Dinero d
    JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
   WHERE d.Empresa =  @Empresa
     AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
     AND mt.Clave IN('DIN.CH', 'DIN.CHE', 'DIN.E')
     AND d.FechaEmision BETWEEN @FechaD AND @FechaA
     AND d.Contacto = @Proveedor AND d.ContactoTipo = 'Proveedor'
     AND ISNULL(d.CFDRetencionTimbrado, 0) = 0
  
  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM #Cheques
     WHERE ID > @IDAnt

    IF @ID IS NULL BREAK
      
    SELECT @IDAnt = @ID
    
    SELECT @MovTipo = NULL, @Mov = NULL, @MovID = NULL, @Directo=NULL --REQ1747
    
	--REQ1747
    SELECT @MovTipo = MovTipo, @Mov = Mov, @MovID = MovID, @Directo=Directo FROM #Cheques WHERE ID = @IDAnt
    
    DELETE MovPos WHERE Estacion = @@SPID
      
    EXEC spMovPos @@SPID, 'DIN', @ID

	--REQ1747
    --IF @MovTipo IN('DIN.CH', 'DIN.CHE')
	IF @Directo=0
    BEGIN
      SELECT @AplicaAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Aplica = MIN(Aplica)
          FROM DineroD
         WHERE ID = @ID
           AND Aplica > @AplicaAnt
      
        IF @Aplica IS NULL BREAK
        
        SELECT @AplicaAnt = @Aplica
  
        SELECT @AplicaIDAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @AplicaID = MIN(AplicaID)
            FROM DineroD
           WHERE ID = @ID
             AND Aplica = @Aplica
             AND AplicaID > @AplicaIDAnt

          IF @AplicaID IS NULL BREAK
        
          SELECT @AplicaIDAnt = @AplicaID
          
          SELECT @IDAplica = NULL
          
          SELECT @IDAplica = OID FROM MovFlujo WHERE OModulo = 'DIN' AND DModulo = 'DIN' AND DID = @ID AND OMov = @Aplica AND OMovID = @AplicaID
          
          DELETE MovPos WHERE Estacion = @@SPID
      
          EXEC spMovPos @@SPID, 'DIN', @IDAplica

          IF EXISTS(SELECT * FROM MovPos WHERE Estacion = @@SPID AND Tipo = 'ORIGEN' AND OModulo = 'CXP' /*AND OMov = @MovRetencion*/)
            INSERT INTO #Aplica(
		              ID, OID, OMov, OMovID,  Aplica,  AplicaID)
              SELECT @ID, OID, OMov, OMovID, @Aplica, @AplicaID
                FROM MovPos 
               WHERE Estacion = @@SPID 
                 AND Tipo = 'ORIGEN' 
                 AND OModulo = 'CXP' 
                 /*AND OMov = @MovRetencion*/

          ELSE
            DELETE #Cheques WHERE ID = @ID
        END
      END
    END
    ELSE
    BEGIN      
      DELETE MovPos WHERE Estacion = @@SPID
      
	  EXEC spMovPos @@SPID, 'DIN', @ID
            
      IF EXISTS(SELECT * FROM MovPos WHERE Estacion = @@SPID AND Tipo = 'ORIGEN' AND OModulo = 'CXP' /*AND OMov = @MovRetencion*/)
        INSERT INTO #Aplica(
		            ID, OID, OMov, OMovID,  Aplica,  AplicaID)
            SELECT @ID, OID, OMov, OMovID, @Mov,    @MovID
              FROM MovPos
             WHERE Estacion = @@SPID 
               AND Tipo = 'ORIGEN' 
               AND oModulo = 'CXP'                
               /*AND OMov = @MovRetencion*/              

      ELSE
        DELETE #Cheques WHERE ID = @ID
    END
  END
  --Insertamos Los Pagos
  INSERT INTO #Pagos( 
			Modulo,  ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,    Aplica,   AplicaID,     Importe,                TipoCambio,   Dinero,   DineroID,   FechaConciliacion,   DineroMov,   DineroMovID, EsRetencion)
    SELECT 'DIN',  d.ID, d.Empresa, d.Mov, d.MovID, d.Ejercicio, d.Periodo, d.FechaEmision, dd.OMov,  dd.OMovID,   did.Importe*d.TipoCambio, d.TipoCambio, d.Mov,    d.MovID,    d.FechaConciliacion, d.Mov,       d.MovID,       1
      FROM Dinero d
      JOIN DineroD did ON d.ID = did.ID
      JOIN #Cheques c ON d.ID = c.ID
      JOIN #Aplica dd ON d.ID = dd.id --AND did.Aplica = dd.Aplica AND did.AplicaID = dd.AplicaID --REQ1747
      JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
     WHERE d.Empresa =  @Empresa
       AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
       --AND mt.Clave IN('DIN.CH', 'DIN.CHE') --REQ1747
       AND ISNULL(did.Aplica,'1') = (CASE WHEN c.Directo=1 then '1' ELSE dd.Aplica END) --REQ1747
	   AND ISNULL(did.AplicaID,'1') = (CASE WHEN c.Directo=1 then '1' ELSE dd.AplicaID END) --REQ1747
       AND d.FechaEmision BETWEEN @FechaD AND @FechaA

    --REQ1747
--  INSERT INTO #Pagos( 
--			Modulo,  ID,   Empresa,   Mov,   MovID,   Ejercicio,   Periodo,   FechaEmision,    Aplica,   AplicaID,   Importe,                TipoCambio,   Dinero,   DineroID,   FechaConciliacion,   DineroMov,   DineroMovID, EsRetencion)
--    SELECT 'DIN',  d.ID, d.Empresa, d.Mov, d.MovID, d.Ejercicio, d.Periodo, d.FechaEmision, dd.OMov,  dd.OMovID,   d.Importe*d.TipoCambio, d.TipoCambio, d.Mov,    d.MovID,    d.FechaConciliacion, d.Mov,       d.MovID,       1
--      FROM Dinero d
--      JOIN #Cheques c ON d.ID = c.ID
--      JOIN #Aplica dd ON d.ID = dd.id --AND d.Mov = dd.Aplica AND d.MovID = dd.AplicaID
--      JOIN MovTipo mt ON mt.Modulo = 'DIN' AND mt.Mov = d.Mov
--     WHERE d.Empresa =  @Empresa
--       AND d.Estatus IN('CONCLUIDO', 'CONCILIADO')
--       AND mt.Clave IN('DIN.E')
--       AND d.FechaEmision BETWEEN @FechaD AND @FechaA

  RETURN
END
GO

/**************** spCFDIRetencionCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionCalc') and type = 'P') drop procedure dbo.spCFDIRetencionCalc
GO
CREATE PROC spCFDIRetencionCalc
			                          @Estacion		int,
			                          @Empresa		varchar(5),
			                          @FechaD			datetime,
			                          @FechaA			datetime,
			                          @Proveedor	varchar(10)
--//WITH ENCRYPTION
AS
BEGIN  
  SET NOCOUNT ON
  
  SELECT @Proveedor = NULLIF(RTRIM(@Proveedor), '')
  
  DECLARE @Ok						           int,
		      @OkRef					         varchar(255),
		      @GastoRetencionConcepto	 varchar(50),
		      @GastoRetencion2Concepto varchar(50)

  CREATE TABLE #Pagos(
                      RID					      int			IDENTITY,
                      Modulo				    varchar(5)	COLLATE Database_Default	NULL,
                      ID					      int			  NULL,
                      Empresa				    varchar(5)	COLLATE Database_Default	NULL,
                      Mov					      varchar(20)	COLLATE Database_Default	NULL,
                      MovID				      varchar(20)	COLLATE Database_Default	NULL,
                      Ejercicio			    int			NULL,
                      Periodo				    int			NULL,
                      FechaEmision		  datetime	NULL,
                      AplicaModulo		  varchar(5)	COLLATE Database_Default	NULL,    
                      AplicaModuloID		int			NULL,
                      Aplica				    varchar(20)	COLLATE Database_Default	NULL,
                      AplicaID			    varchar(20)	COLLATE Database_Default	NULL,
                      Importe				    float		NULL,
                      TipoCambio			  float		NULL,
                      Dinero				    varchar(20)	COLLATE Database_Default	NULL,
                      DineroID			    varchar(20)	COLLATE Database_Default	NULL,
                      FechaConciliacion	datetime	NULL,
                      EsAnticipo			  bit			NULL DEFAULT 0,
                      EsComprobante		  bit			NULL DEFAULT 0,
                      EsRetencion			  bit			NULL DEFAULT 0,
                      EsIEPS				    bit			NULL DEFAULT 0,
                      DineroMov			    varchar(20) COLLATE DATABASE_DEFAULT	NULL,
	                    DineroMovID			  varchar(20) COLLATE DATABASE_DEFAULT	NULL
    )

  CREATE TABLE #Documentos(
    RID					        int			IDENTITY, 
    ID					        int			NULL,
    Modulo				      varchar(5)	COLLATE Database_Default	NULL,
    ModuloID			      int			NULL,
    Sucursal			      int			NULL,    
    Empresa				      varchar(5)	COLLATE Database_Default	NULL,
    Pago				        varchar(20)	COLLATE Database_Default	NULL,
    PagoID				      varchar(20)	COLLATE Database_Default	NULL,    
    Mov					        varchar(20)	COLLATE Database_Default	NULL,
    MovID				        varchar(20)	COLLATE Database_Default	NULL,
    Ejercicio			      int			NULL,
    Periodo				      int			NULL,
    FechaEmision		    datetime	NULL,
    Proveedor			      varchar(10)	COLLATE Database_Default	NULL,
    TipoTercero			    varchar(20) COLLATE Database_Default	NULL,
    Importe				      float		NULL,
    IVA					        float		NULL,
    IEPS				        float		NULL,
    ISAN				        float		NULL,
    Retencion1			    float		NULL,
    Retencion2			    float		NULL,
    BaseIVA				      float		NULL,
    Tasa				        float		NULL,
    ConceptoSAT			    varchar(2)  COLLATE Database_Default	NULL,    
    ConceptoClave		    varchar(50) COLLATE Database_Default	NULL,
    Concepto			      varchar(100)COLLATE Database_Default	NULL,
    EsComplemento		    bit			NOT NULL DEFAULT 0,
    EsRetencion			    bit			NOT NULL DEFAULT 0,
    EsIEPS				      bit			NOT NULL DEFAULT 0,    
    PorcentajeDeducible	float		NOT NULL DEFAULT 100
    )

     CREATE TABLE #Movtos (Empresa     varchar(5)  NULL,
                           ModuloRaiz  varchar(5)  NULL,
                           IDRaiz      int         NULL,
                           MovRaiz     varchar(20) NULL,
                           MovIDRaiz   varchar(20) NULL,
                           OModulo     varchar(5)  NULL,
                           OID         int         NULL,
                           OMov        varchar(20) NULL,
                           OMovID      varchar(20) NULL
                           )

  CREATE TABLE #Movtos2 (Empresa    varchar(5)  NULL,
                         ModuloRaiz varchar(5)  NULL,
                         IDRaiz     int         NULL,
                         MovRaiz    varchar(20) NULL,
                         MovIDRaiz  varchar(20) NULL,
                         OModulo    varchar(5)  NULL,
                         OID        int         NULL,
                         OMov       varchar(20) NULL,
                         OMovID     varchar(20) NULL
                        )


  CREATE TABLE #Movtos3 (Empresa    varchar(5)  NULL,
                         ModuloRaiz varchar(5)  NULL,
                         IDRaiz     int         NULL,
                         MovRaiz    varchar(20) NULL,
                         MovIDRaiz  varchar(20) NULL,
                         OModulo    varchar(5)  NULL,
                         OID        int         NULL,
                         OMov       varchar(20) NULL ,
                         OMovID     varchar(20) NULL
                        )
  
  CREATE INDEX Importe ON #Documentos(Mov, MovID, Pago, PagoID, Empresa) INCLUDE(Importe, IVA, IEPS, ISAN, Retencion1, Retencion2)

  DELETE CFDIRetencionD WHERE EstacionTrabajo = @Estacion
  
  SELECT @Ok = NULL, @OkRef = NULL

  SELECT @GastoRetencionConcepto = GastoRetencionConcepto, @GastoRetencion2Concepto = GastoRetencion2Concepto FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF YEAR(@FechaD)  = 1899 SELECT @FechaD = NULL
  IF YEAR(@FechaA) = 1899  SELECT @FechaA = NULL 

  IF @Proveedor IS NOT NULL AND NOT EXISTS(SELECT Proveedor FROM Prov WHERE Proveedor = @Proveedor)
    SELECT @Ok = 26050

  IF @Proveedor IS NULL
    SELECT @Ok = 40020

  IF @Ok IS NULL AND @FechaD IS NULL
    SELECT @Ok = 1, @OkRef = 'Favor de Especificar la Fecha Inicial'

  IF @Ok IS NULL AND @FechaA IS NULL
    SELECT @Ok = 1, @OkRef = 'Favor de Especificar la Fecha Final'
    
  IF @Ok IS NULL AND YEAR(@FechaD) <> YEAR(@FechaA)
    SELECT @Ok = 1, @OkRef = 'Solo se puede presentar la Información de un Ejercicio'    

  IF @Ok IS NULL AND @GastoRetencionConcepto NOT LIKE 'ISR%'
    SELECT @Ok = 1, @OkRef = 'El Concepto de Retención ISR debe ser "ISR - (Concepto Gasto)"<BR>Configuración de Módulos de la Empresa'

  IF @Ok IS NULL AND @GastoRetencion2Concepto NOT LIKE 'IVA%'
    SELECT @Ok = 1, @OkRef = 'El Concepto de Retención IVA debe ser "IVA - (Concepto Gasto)"<BR>Configuración de Módulos de la Empresa'

  IF @Ok IS NULL
  BEGIN

    EXEC spCFDIRetencionObtenerPago @Empresa, @FechaD, @FechaA, @Proveedor  
    EXEC spCFDIRetencionObtenerPagoIEPS @Empresa, @FechaD, @FechaA, @Proveedor   
    EXEC spCFDIRetencionObtenerDocumento @Estacion, @Empresa, @FechaD, @FechaA, @Proveedor
    EXEC spCFDIRetencionObtenerDocumentoIEPS @Estacion, @Empresa, @FechaD, @FechaA, @Proveedor
    EXEC spCFDIRetencionObtenerGasto @Estacion, @Empresa, @FechaD, @FechaA, @Proveedor
    EXEC spCFDIRetencionProcesar @Estacion, @Empresa, @FechaD, @FechaA

  END
  
  IF @Ok IS NULL 
    SELECT 'Proceso Concluido'
  ELSE
    IF @Ok = 1
      SELECT @OkRef
    ELSE
      SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok

END
GO

/**************** spCFDIRetencionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionGenerar') and type = 'P') drop procedure dbo.spCFDIRetencionGenerar
GO
CREATE PROC spCFDIRetencionGenerar
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@IDMov	            varchar(20),
			@MovTimbrado		varchar(20),
			@Concepto			varchar(50),
			@CxID				int				OUTPUT, 
		    @montoTotExent		float			OUTPUT,
		    @montoTotGrav		float			OUTPUT,
		    @montoTotOperacion	float			OUTPUT,
		    @montoTotRet		float			OUTPUT,
		    @Ejerc				int				OUTPUT,
		    @MesIni				int				OUTPUT,
		    @MesFin				int				OUTPUT,		    
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN  
  DECLARE @FechaEmision			datetime,
		  @Moneda				varchar(10),
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @Importe				float,

          @Modulo	            varchar(5),
          @ModuloID	            int,
          @RetencionISR         money,
          @RetencionIVA         money,
          @RetmontoTotGrav      money,
          @RetmontoTotExent     money,
          @ImporteGasto         money,
		  @AgruparConceptoSAT   bit
		  
  
  CREATE TABLE #CxpD(
    RID			int			IDENTITY,
    Importe		float		NULL,
    Aplica		varchar(20)	COLLATE Database_Default	NULL,
    AplicaID	varchar(20)	COLLATE Database_Default	NULL
    )

  SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @FechaEmision = GETDATE()
  
  EXEC spExtraerFecha @FechaEmision OUTPUT
  
  SELECT @AgruparConceptoSAT = ISNULL(AgruparConceptoSATRetenciones,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF @AgruparConceptoSAT  = 1
    BEGIN
	  INSERT INTO #CxpD(
			Importe,                                     Aplica, AplicaID)
	 SELECT SUM(Importe+IVA+IEPS-Retencion1-Retencion2), Mov,    MovID
	   FROM CFDIRetencion
      WHERE Proveedor = @Proveedor
        AND EstacionTrabajo = @Estacion
        AND ConceptoSAT = @ConceptoSAT
        AND Empresa = @Empresa
		AND MovID = @IDMov
      GROUP BY Mov, MovID
    SELECT @Importe = Importe FROM #CxpD WHERE AplicaID = @IDMov
	END
  ELSE
    BEGIN
	  INSERT INTO #CxpD(
			Importe,                                     Aplica, AplicaID)
	 SELECT SUM(Importe+IVA+IEPS-Retencion1-Retencion2), Mov,    MovID
	   FROM CFDIRetencion
      WHERE Proveedor = @Proveedor
        AND EstacionTrabajo = @Estacion
        AND ConceptoSAT = @ConceptoSAT
        AND Empresa = @Empresa
      GROUP BY Mov, MovID
    SELECT @Importe = SUM(Importe) FROM #CxpD

	END

  INSERT INTO Cxp(  
			Empresa,  Mov,          FechaEmision,  Moneda, TipoCambio,  Usuario, Estatus,       Proveedor, FormaPago, AplicaManual,  Sucursal,  ProveedorMoneda, ProveedorTipoCambio,  Concepto,  Importe)
	SELECT @Empresa, @MovTimbrado, @FechaEmision, @Moneda, 1,          @Usuario, 'SINAFECTAR', @Proveedor, NULL,      1,            @Sucursal, @Moneda,          1,                   @Concepto, @Importe
  
  SELECT @CxID = SCOPE_IDENTITY()
  
  INSERT INTO CxpD(
			ID,   Renglon,  Importe, Aplica, AplicaID)
	SELECT @CxID, RID*2048, Importe, Aplica, AplicaID
  	  FROM #CxpD

  IF @CxID IS NOT NULL
    EXEC spAfectar 'CXP', @CxID, 'AFECTAR', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    BEGIN TRAN
    SELECT @Mov = Mov, @MovID = MovID FROM Cxp WHERE ID = @CxID

    IF(SELECT ISNULL(PeriodosEspecificos, 0) FROM CFDIRetencionCfg) = 0
    BEGIN
      SELECT @Ejerc = YEAR(FechaEmision)
        FROM CFDIRetencionD    
       WHERE Proveedor = @Proveedor
         AND EstacionTrabajo = @Estacion
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa

	
	  IF @AgruparConceptoSAT  = 1
      SELECT @MesIni = MIN(Periodo),
		     @MesFin = MAX(Periodo),
		     @montoTotOperacion = SUM(NULLIF(ISNULL(Importe,0.0) /*+ ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0)*/, 0))
        FROM CFDIRetencionCalcTmp
       WHERE Proveedor = @Proveedor
         AND EstacionTrabajo = @Estacion
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa  
		 AND MovID = @IDMov

	  ELSE
      SELECT @MesIni = MIN(Periodo),
		     @MesFin = MAX(Periodo),
             /*@MesIni = MIN(MONTH(FechaEmision)),
		     @MesFin = MAX(MONTH(FechaEmision)),*/
		     --BUG1161
		     @montoTotOperacion = SUM(NULLIF(ISNULL(Importe,0.0) /*+ ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0)*/, 0))
        FROM CFDIRetencionCalcTmp
       WHERE Proveedor = @Proveedor
         AND EstacionTrabajo = @Estacion
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa       
    END
    ELSE
    BEGIN
      SELECT @Ejerc = Ejerc, @MesIni = MesIni, @MesFin = MesFin FROM CFDIRetencionCfg

	  IF @AgruparConceptoSAT  = 1
      SELECT @montoTotOperacion = NULLIF(ISNULL(Importe,0.0),0)/* + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) , 0)*/
        FROM CFDIRetencionCalcTmp
       WHERE Proveedor = @Proveedor
         AND EstacionTrabajo = @Estacion
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa  
		 AND MovID = @IDMov
	  ELSE
	  SELECT @montoTotOperacion = SUM(NULLIF(ISNULL(Importe,0.0) /*+ ISNULL(IVA,0.0) + ISNULL(IEPS,0.0) - ISNULL(Retencion1,0.0) - ISNULL(Retencion2,0.0)*/, 0))
        FROM CFDIRetencionCalcTmp
       WHERE Proveedor = @Proveedor
         AND EstacionTrabajo = @Estacion
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa               
    END
    --BUG1161
    --SELECT @montoTotExent = SUM((ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0))*((100-(ISNULL(PorcentajeDeducible, 0)))/100))
    --  FROM CFDIRetencionCalcTmp
    -- WHERE Proveedor = @Proveedor
    --   AND EstacionTrabajo = @Estacion
    --   AND ConceptoSAT = @ConceptoSAT
    --   AND Empresa = @Empresa

    --BUG1161
    --SELECT @montoTotGrav = SUM((ISNULL(Importe,0.0) + ISNULL(IVA,0.0) + ISNULL(IEPS,0.0))*(((ISNULL(PorcentajeDeducible, 0)))/100))
    --  FROM CFDIRetencionCalcTmp
    -- WHERE Proveedor = @Proveedor
    --   AND EstacionTrabajo = @Estacion
    --   AND ConceptoSAT = @ConceptoSAT
    --   AND Empresa = @Empresa       
     
     ---VERIFICAMOS QUE CONCEPTO SE UTILIZARA PARA OBTENER EL GRAVADO Y EXENTO INGRESADO
    IF EXISTS(SELECT * FROM CFDIRetSATRetencion WHERE Clave LIKE @ConceptoSAT AND COMPLEMENTO IS NOT NULL) AND @ConceptoSAT IN ('14', '18') --DIVIDENDO, EXTRANJERO
		---******************************************************************************
		---OBTENEMOS GRAVADO Y EXENTO DEL COMPLEMENTO DE GASTOS CFDIRetGastoComplemento
		SELECT DISTINCT @montoTotGrav = RG.Gravado, @montoTotExent = RG.Exento
		FROM CFDIRetGastoComplemento RG, CFDIRetencionD RD
		WHERE RG.ID = RD.ModuloID AND RD.Proveedor LIKE @Proveedor AND RD.EstacionTrabajo = @Estacion AND RD.ConceptoSAT LIKE @ConceptoSAT AND RD.Empresa LIKE @Empresa
		---******************************************************************************	
	ELSE 		
		IF EXISTS(SELECT COUNT(*) FROM CFDIRetSATRetencion WHERE Clave LIKE @ConceptoSAT AND COMPLEMENTO IS NOT NULL) AND @ConceptoSAT IN ('06','07','08','09','19') --ENAJENACION
			SELECT DISTINCT @montoTotGrav = EGC.Gravado, @montoTotExent = EGC.Exento
			FROM CFDIEnajenacionGastoComplemento EGC, CFDIRetencionD RD
			WHERE EGC.ID = RD.ModuloID AND RD.Proveedor LIKE @Proveedor AND RD.EstacionTrabajo = @Estacion AND RD.ConceptoSAT LIKE @ConceptoSAT AND RD.Empresa LIKE @Empresa
		ELSE
			IF EXISTS(SELECT * FROM CFDIRetSATRetencion WHERE Clave LIKE @ConceptoSAT AND COMPLEMENTO IS NOT NULL) AND @ConceptoSAT IN ('16') --INTERESES
			SELECT DISTINCT @montoTotGrav = RSI.Gravado, @montoTotExent = RSI.Exento
			FROM CFDIRetSATIntereses RSI, CFDIRetencionD RD
			WHERE RSI.ID = RD.ModuloID AND RD.Proveedor LIKE @Proveedor AND RD.EstacionTrabajo = @Estacion AND RD.ConceptoSAT LIKE @ConceptoSAT AND RD.Empresa LIKE @Empresa
        ELSE 
		    IF EXISTS(SELECT * FROM CFDIRetSATRetencion WHERE Clave LIKE @ConceptoSAT AND Complemento IS NULL)
		    SELECT DISTINCT @montoTotGrav = RG.Gravado, @montoTotExent = RG.Exento
		    FROM CFDIRetGastoComplemento RG, CFDIRetencionD RD
		    WHERE RG.ID = RD.ModuloID AND RD.Proveedor LIKE @Proveedor AND RD.EstacionTrabajo = @Estacion AND RD.ConceptoSAT LIKE @ConceptoSAT AND RD.Empresa LIKE @Empresa     

	IF @AgruparConceptoSAT  = 1
    SELECT @montoTotRet = SUM(NULLIF(ISNULL(IEPS,0.0) + ISNULL(Retencion1,0.0) + ISNULL(Retencion2,0.0), 0))
      FROM CFDIRetencionCalcTmp
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
       AND Empresa = @Empresa 
	   AND MovID = @IDMov
	ELSE       
    SELECT @montoTotRet = SUM(NULLIF(ISNULL(IEPS,0.0) + ISNULL(Retencion1,0.0) + ISNULL(Retencion2,0.0), 0))
      FROM CFDIRetencionCalcTmp
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
       AND Empresa = @Empresa 

    UPDATE CFDIRetencionD 
       SET --FolioInt = RTRIM(@Mov)+' '+RTRIM(@MovID),
           FolioInt          = RTRIM(@MovID),
           Ejerc	         = @Ejerc,
           MesIni	         = @MesIni,
           MesFin	         = @MesFin,
           montoTotOperacion = @montoTotOperacion,
           montoTotExent     = @montoTotExent,
           montoTotGrav      = @montoTotGrav,
           montoTotRet       = @montoTotRet
	  FROM CFDIRetencionD
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
       AND Empresa = @Empresa

 
    SELECT @montoTotRet = 0.0, @montoTotGrav = 0.0, @montoTotExent = 0.0, @montoTotOperacion = 0.0

	IF @AgruparConceptoSAT  = 1
	DECLARE crArtInv CURSOR FOR
     SELECT Modulo, ModuloID
      FROM CFDIRetencionCalcTmp
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
       AND Empresa = @Empresa 
	   AND MovID = @IDMov
	ELSE
	DECLARE crArtInv CURSOR FOR
     SELECT Modulo, ModuloID
      FROM CFDIRetencionCalcTmp
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
       AND Empresa = @Empresa 

	OPEN crArtInv
	FETCH NEXT FROM crArtInv INTO @Modulo, @ModuloID
	WHILE @@FETCH_STATUS = 0      
	BEGIN
		IF @Modulo = 'GAS' 
        BEGIN 
            IF (SELECT COUNT(Concepto) FROM GastoD WHERE ID = @ModuloID 
			AND Concepto IN(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)) > 2
                SELECT @Ok = 1
            IF @OK <> 1
            BEGIN


                SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                       @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
                  FROM CFDIRetSATRetencion 
                 WHERE CLAVE = @ConceptoSAT

	        IF @AgruparConceptoSAT  = 1
                SELECT @ImporteGasto = ISNULL(SUM(GD.Importe),0.00),
                       @RetencionISR = ISNULL(SUM(GD.Retencion),0.00), 
                       @RetencionIVA = ISNULL(SUM(GD.Retencion2),0.00)                       
                  FROM GastoD GD
                  JOIN Gasto G ON GD.ID = G.ID 
                 WHERE G.ID = @ModuloID
				   AND GD.Concepto in (Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
                -- GROUP BY GD.Concepto   
		    ELSE
                SELECT @ImporteGasto = ISNULL(SUM(GD.Importe),0.00),
                       @RetencionISR = ISNULL(SUM(GD.Retencion),0.00), 
                       @RetencionIVA = ISNULL(SUM(GD.Retencion2),0.00)                       
                  FROM GastoD GD
                  JOIN Gasto G ON GD.ID = G.ID 
                 WHERE G.ID = @ModuloID
				   AND GD.Concepto in (Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
                 GROUP BY GD.Concepto   

					
                SELECT @montoTotRet = @montoTotRet + @RetencionISR + @RetencionIVA

                SELECT @montoTotGrav = @montoTotGrav + (@ImporteGasto*@RetmontoTotGrav)/100
                SELECT @montoTotExent = @montoTotExent + (@ImporteGasto*@RetmontoTotExent)/100


                SELECT @montoTotOperacion = @montoTotOperacion + @ImporteGasto

                UPDATE CFDIRetencionD 
                   SET montoTotOperacion = @montoTotOperacion,
                       montoTotGrav      = @montoTotGrav,
                       montoTotExent     = @montoTotExent,
                       montoTotRet       = @montoTotRet
                 WHERE Proveedor       = @Proveedor
                   AND EstacionTrabajo = @Estacion
                   AND ConceptoSAT     = @ConceptoSAT
                   AND Empresa         = @Empresa

            END
        END
        SELECT @OK = NULL
		FETCH NEXT FROM crArtInv INTO @Modulo, @ModuloID       
	END
	CLOSE crArtInv
	DEALLOCATE crArtInv	

	--SELECT 'totales', @montoTotRet , @montoTotGrav ,@montoTotExent , @montoTotOperacion

    IF @Ok = 1
        ROLLBACK TRAN
    ELSE
        COMMIT TRAN
  END
  ELSE
    SELECT @CxID = NULL
END
GO

/**************** spCFDIRetencionXMLComprobante ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLComprobante') and type = 'P') drop procedure dbo.spCFDIRetencionXMLComprobante
GO
CREATE PROC spCFDIRetencionXMLComprobante 
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Version			varchar(5),
			@Vista				varchar(100),
			@XMLComprobante		varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CampoXML		varchar(100),
		  @CampoXMLAnt	varchar(100),
		  @CampoVista	varchar(100),
		  @SQL			nvarchar(max),
		  @Parametros	nvarchar(max)

  SELECT @Parametros = '@XMLComprobante	varchar(max)	OUTPUT,
						@Proveedor		varchar(10),
						@Estacion		int,
						@ConceptoSAT	varchar(2),
						@Empresa		varchar(5)
						'

  SELECT @CampoXMLAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @CampoXML = MIN(CampoXML)
      FROM CFDIRetencionXMLCampo 
     WHERE Version = @Version
       AND CampoXML > @CampoXMLAnt 
  
    IF @CampoXML IS NULL BREAK
    
    SELECT @CampoXMLAnt = @CampoXML
    
    SELECT @CampoVista = CampoVista FROM CFDIRetencionXMLCampo WHERE Version = @Version AND CampoXML = @CampoXML
    
    IF ISNULL(RTRIM(@CampoXML), '') <> '' AND ISNULL(RTRIM(@CampoVista), '') <> '' AND ISNULL(RTRIM(@Vista), '') <> ''
    BEGIN
      SELECT @SQL = 'SELECT @XMLComprobante = REPLACE(@XMLComprobante, ''' + ISNULL(RTRIM(@CampoXML), '') + ''', ISNULL(dbo.fnXMLValor(' + ISNULL(RTRIM(@CampoVista), '') + '), '''')) FROM ' + ISNULL(RTRIM(@Vista), '') + ' WHERE Proveedor = @Proveedor AND EstacionTrabajo = @Estacion AND ConceptoSAT = @ConceptoSAT AND Empresa = @Empresa'
      EXEC sp_executesql @SQL, @Parametros, @XMLComprobante OUTPUT, @Proveedor, @Estacion, @ConceptoSAT, @Empresa
    END
  END
  RETURN
END
GO

/**************** spCFDIRetencionXMLComplemento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLComplemento') and type = 'P') drop procedure dbo.spCFDIRetencionXMLComplemento
GO
CREATE PROC spCFDIRetencionXMLComplemento 
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Version			varchar(5),
			@Vista				varchar(100),
			@XML				varchar(max)	OUTPUT,
			@XMLComplemento		varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Complemento	varchar(20),
		  @CampoXML		varchar(100),
		  @CampoXMLAnt	varchar(100),
		  @CampoVista	varchar(100),
		  @SQL			nvarchar(max),
		  @Parametros	nvarchar(max)

  SELECT @Complemento = Complemento FROM CFDIRetSATRetencion WHERE Clave = @ConceptoSAT 
  
  IF ISNULL(RTRIM(@Complemento), '') = ''
    SELECT @XMLComplemento = ''
  ELSE
  BEGIN    
    SELECT @Vista = Vista, @XMLComplemento = Plantilla FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = @Complemento

    SELECT @Parametros = '@XMLComplemento	varchar(max)	OUTPUT,
						  @Proveedor		varchar(10),
						  @Estacion			int,
						  @ConceptoSAT		varchar(2),
						  @Empresa			varchar(5)
						  '

    SELECT @CampoXMLAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @CampoXML = MIN(CampoXML)
        FROM CFDIRetencionCompXMLCampo 
       WHERE Complemento = @Complemento
         AND CampoXML > @CampoXMLAnt 
  
      IF @CampoXML IS NULL BREAK
    
      SELECT @CampoXMLAnt = @CampoXML
    
      SELECT @CampoVista = CampoVista FROM CFDIRetencionCompXMLCampo WHERE Complemento = @Complemento AND CampoXML = @CampoXML
      
      IF ISNULL(RTRIM(@CampoXML), '') <> '' AND ISNULL(RTRIM(@CampoVista), '') <> '' AND ISNULL(RTRIM(@Vista), '') <> ''
      BEGIN
        SELECT @SQL = 'SELECT @XMLComplemento = REPLACE(@XMLComplemento, ''' + ISNULL(RTRIM(@CampoXML), '') + ''', ISNULL(dbo.fnXMLValor(' + ISNULL(RTRIM(@CampoVista), '') + '), '''')) FROM ' + ISNULL(RTRIM(@Vista), '') + ' WHERE Proveedor = @Proveedor AND EstacionTrabajo = @Estacion AND ConceptoSAT = @ConceptoSAT AND Empresa = @Empresa'
        EXEC sp_executesql @SQL, @Parametros, @XMLComplemento OUTPUT, @Proveedor, @Estacion, @ConceptoSAT, @Empresa
      END
    END
  END

  SELECT @XML = REPLACE(@XML, '@Complemento', ISNULL(@XMLComplemento, ''))

  RETURN
END
GO

/**************** spCFDIRetencionXMLAddenda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLAddenda') and type = 'P') drop procedure dbo.spCFDIRetencionXMLAddenda
GO
CREATE PROC spCFDIRetencionXMLAddenda 
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Version			varchar(5),
			@Vista				varchar(100),
			@XML				varchar(max)	OUTPUT,
			@XMLAddenda			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN

  SELECT @XML = REPLACE(@XML, '@Addenda', ISNULL(@XMLAddenda, ''))
  
  RETURN
END
GO

/**************** spCFDIRetencionXMLDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLDetalle') and type = 'P') drop procedure dbo.spCFDIRetencionXMLDetalle
GO
CREATE PROC spCFDIRetencionXMLDetalle 
			@ID					int,
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@IDMov	            varchar(20),
			@Version			varchar(5),
			@Vista				varchar(100),
			@XML				varchar(max)	OUTPUT,
			@XMLDetalle			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @AgruparConceptoSAT   bit
  CREATE TABLE #CFDIRetencionImpuestoD(
    Modulo			varchar(5)	COLLATE DATABASE_DEFAULT NOT NULL,
    ModuloID		int			NOT NULL,
    BaseRet			float		NULL,
    Impuesto		varchar(2)	COLLATE DATABASE_DEFAULT NULL,
    montoRet		float		NULL,
    TipoPagoRet		varchar(20) COLLATE DATABASE_DEFAULT NULL,
    )
 
  SELECT @AgruparConceptoSAT = ISNULL(AgruparConceptoSATRetenciones,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
 
  IF @AgruparConceptoSAT = 1
  BEGIN
  --Insertamos Retencion ISR
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                      TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion,0.0), 0)))), 'Pago definitivo'
	  FROM CFDIRetencion
	  JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'ISR'
	  JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	  JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
	   AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
       AND Empresa = @Empresa
       AND NULLIF(GastoD.Retencion, 0) IS NOT NULL
	   AND MovID = @IDMov
     GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav

  --Insertamos Retencion IVA
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                      TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion2,0.0), 0)))), 'Pago definitivo'
	FROM CFDIRetencion
	JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IVA'
	JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
	 AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
     AND Empresa = @Empresa
     AND NULLIF(GastoD.Retencion2, 0) IS NOT NULL  
	 AND MovID = @IDMov   
   GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav
  
  --Insertamos IEPS
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion3,0.0), 0)))), 'Pago definitivo'
	FROM CFDIRetencion
	JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IEPS'
	JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
	 AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
     AND Empresa = @Empresa
     AND NULLIF(GastoD.Retencion3, 0) IS NOT NULL
	 AND MovID = @IDMov
   GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav

  END
  ELSE
  BEGIN  
  --Insertamos Retencion ISR
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                      TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion,0.0), 0)))), 'Pago definitivo'
	  FROM CFDIRetencion
	  JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'ISR'
	  JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	  JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
     WHERE Proveedor = @Proveedor
       AND EstacionTrabajo = @Estacion
       AND ConceptoSAT = @ConceptoSAT
	   AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
       AND Empresa = @Empresa
       AND NULLIF(GastoD.Retencion, 0) IS NOT NULL
     GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav

  --Insertamos Retencion IVA
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                      TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion2,0.0), 0)))), 'Pago definitivo'
	FROM CFDIRetencion
	JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IVA'
	JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
	 AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
     AND Empresa = @Empresa
     AND NULLIF(GastoD.Retencion2, 0) IS NOT NULL     
   GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav
  
  --Insertamos IEPS
  INSERT INTO #CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet, Impuesto,                           montoRet,                                                                TipoPagoRet)
	SELECT 'CXP', @ID,        (SUM(GastoD.Importe) * (cfdiretsatretencion.RetmontoTotGrav/100)),       CFDIRetencionImpuestoTipo.ClaveSAT, CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(GastoD.Retencion3,0.0), 0)))), 'Pago definitivo'
	FROM CFDIRetencion
	JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IEPS'
	JOIN GastoD ON CFDIRetencion.ModuloID = GastoD.id
	JOIN cfdiretsatretencion ON CFDIRetencion.ConceptoSAT = cfdiretsatretencion.Clave
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
	 AND GastoD.Concepto in(Select Concepto From CFDIRetencionConcepto Where Modulo = 'GAS' AND CFDIRetClave = @ConceptoSAT)
     AND Empresa = @Empresa
     AND NULLIF(GastoD.Retencion3, 0) IS NOT NULL
   GROUP BY CFDIRetencionImpuestoTipo.ClaveSAT,CFDIRetencion.Importe, cfdiretsatretencion.RetmontoTotGrav
  END

  INSERT INTO CFDIRetencionImpuestoD(
		   Modulo, ModuloID, BaseRet,      Impuesto, montoRet,      TipoPagoRet)
	SELECT Modulo, ModuloID, SUM(BaseRet), Impuesto, SUM(montoRet), TipoPagoRet
	  FROM #CFDIRetencionImpuestoD
	 GROUP BY Modulo, ModuloID, Impuesto, TipoPagoRet

  SELECT @XMLDetalle = (SELECT ISNULL(CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(BaseRet,0.0), 0)))),0.00) 'BaseRet',
                               Impuesto,
                               ISNULL(CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(montoRet,0.0), 0)))),0.00) 'montoRet',
                               TipoPagoRet
                          FROM CFDIRetencionImpuestoD
                         WHERE ModuloID = @ID
                           AND Modulo = 'CXP'
                         GROUP BY Impuesto, TipoPagoRet
                           FOR XML RAW('ImpRetenidos'))

 -- SELECT @XMLISR = (
 -- SELECT CASE WHEN ROUND(Factor, 2) < 1 THEN 'Pago provisional' ELSE 'Pago definitivo' END TipoPagoRet,
 --        CFDIRetencionImpuestoTipo.ClaveSAT 'Impuesto',
 --        CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(Retencion1,0.0), 0)))) 'montoRet'
	--FROM CFDIRetencionD
	--JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'ISR'
 --  WHERE Proveedor = @Proveedor
 --    AND EstacionTrabajo = @Estacion
 --    AND ConceptoSAT = @ConceptoSAT
 --    AND Empresa = @Empresa
 --    AND NULLIF(CFDIRetencionD.Retencion1, 0) IS NOT NULL
 --  GROUP BY Factor, CFDIRetencionImpuestoTipo.ClaveSAT
 --  FOR XML RAW('ImpRetenidos')
 --  )   
   
 -- SELECT @XMLIVA = (
 -- SELECT CASE WHEN ROUND(Factor, 2) < 1 THEN 'Pago provisional' ELSE 'Pago definitivo' END TipoPagoRet,
 --        CFDIRetencionImpuestoTipo.ClaveSAT 'Impuesto',
 --        CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(Retencion2,0.0), 0)))) 'montoRet'
	--FROM CFDIRetencionD
	--JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IVA'
 --  WHERE Proveedor = @Proveedor
 --    AND EstacionTrabajo = @Estacion
 --    AND ConceptoSAT = @ConceptoSAT
 --    AND Empresa = @Empresa
 --    AND NULLIF(CFDIRetencionD.Retencion2, 0) IS NOT NULL     
 --  GROUP BY Factor, CFDIRetencionImpuestoTipo.ClaveSAT
 --  FOR XML RAW('ImpRetenidos')
 --  )   

 -- SELECT @XMLIEPS = (
 -- SELECT CASE WHEN ROUND(Factor, 2) < 1 THEN 'Pago provisional' ELSE 'Pago definitivo' END TipoPagoRet,
 --        CFDIRetencionImpuestoTipo.ClaveSAT 'Impuesto',
 --        CONVERT(varchar(max), CONVERT(money, SUM(NULLIF(ISNULL(IEPS,0.0), 0)))) 'montoRet'
	--FROM CFDIRetencionD
	--JOIN CFDIRetencionImpuestoTipo ON CFDIRetencionImpuestoTipo.Retencion = 'IEPS'
 --  WHERE Proveedor = @Proveedor
 --    AND EstacionTrabajo = @Estacion
 --    AND ConceptoSAT = @ConceptoSAT
 --    AND Empresa = @Empresa
 --    AND NULLIF(CFDIRetencionD.IEPS, 0) IS NOT NULL
 --  GROUP BY Factor, CFDIRetencionImpuestoTipo.ClaveSAT
 --  FOR XML RAW('ImpRetenidos')
 --  )
   
--  SELECT @XMLDetalle = ISNULL(@XMLISR, '') + CHAR(13) + CHAR(10) + ISNULL(@XMLIVA, '') + CHAR(13) + CHAR(10) + ISNULL(@XMLIEPS, '')

  SELECT @XMLDetalle = REPLACE(@XMLDetalle, '<ImpRetenidos', '<retenciones:ImpRetenidos')
  
  SELECT @XML = REPLACE(@XML, '@Detalle', ISNULL(@XMLDetalle, ''))

  RETURN
END
GO

/**************** spCFDIRetencionXMLVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLVerificar') and type = 'P') drop procedure dbo.spCFDIRetencionXMLVerificar
GO
CREATE PROC spCFDIRetencionXMLVerificar
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Version			varchar(5),
			@XML				varchar(max),
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL			varchar(100),
		  @Validacion		nvarchar(max),
		  @Parametros		nvarchar(max),
		  @Error			int,
		  @ErrorRef			varchar(255),
		  @Clave			varchar(50)
  
  SELECT @IDSQL = 'Retencion_' + @Version
  
  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN  
    SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = @XML END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'

    SET @Parametros = '@XML varchar(max), @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
    EXECUTE sp_executesql @Validacion, @Parametros, @XML = @XML, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT

    IF @Error IS NOT NULL 
      SELECT @Ok = @Error, @OkRef = REPLACE(@ErrorRef, 'Esto puede ser consecuencia del uso de facetas de patrón en tipos que no son string o restricciones de rango o enumeraciones en tipos de coma flotante. ', '')
  END
  
  RETURN
END
GO

/**************** spCFDIRetencionXMLCompVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLCompVerificar') and type = 'P') drop procedure dbo.spCFDIRetencionXMLCompVerificar
GO
CREATE PROC spCFDIRetencionXMLCompVerificar
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Version			varchar(5),
			@XML				varchar(max),
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL			varchar(100),
		  @Validacion		nvarchar(max),
		  @Parametros		nvarchar(max),
		  @Error			int,
		  @ErrorRef			varchar(255),
		  @Clave			varchar(50),
		  @Complemento		varchar(20)
  
  select @ConceptoSAT = '01'
  SELECT @Complemento = Complemento FROM CFDIRetSATRetencion WHERE Clave = @ConceptoSAT
  
  SELECT @IDSQL = 'RetencionComp_' + @Complemento
  
  IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  BEGIN  
    SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = @XML END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'

    SET @Parametros = '@XML varchar(max), @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
    EXECUTE sp_executesql @Validacion, @Parametros, @XML = @XML, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT

    IF @Error IS NOT NULL 
      SELECT @Ok = @Error, @OkRef = REPLACE(@ErrorRef, 'Esto puede ser consecuencia del uso de facetas de patrón en tipos que no son string o restricciones de rango o enumeraciones en tipos de coma flotante. ', '')
  END
  
  RETURN
END
GO

/**************** spCFDIRetencionActMonGravExce ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionActMonGravExce') and type = 'P') drop procedure dbo.spCFDIRetencionActMonGravExce
GO
CREATE PROC spCFDIRetencionActMonGravExce 			
			@Empresa			varchar(5),			
			@Proveedor			varchar(10),
            @Estacion			int,
			@ConceptoSAT		varchar(2)
--//WITH ENCRYPTION	
AS
BEGIN
DECLARE @RID                int,
        @Modulo             varchar(5),
        @ID                 int,
        @montoTotOperacion  money,
        @montoTotGrav       float,
        @montoTotExent      float,
        @Concepto           varchar(50),
		@ConceptoS          varchar(50),
		@ConceptoClave      varchar(50),
        @CFDIRetClave       varchar(2),
        @RetmontoTotGrav    money,
        @RetmontoTotExent   money  

    DECLARE CrCFDIRetencionCalc CURSOR FOR
			SELECT RID
			  FROM CFDIRetencionCalc 
             WHERE Empresa         = @Empresa		  
               AND Proveedor       = @Proveedor 
               AND EstacionTrabajo = @Estacion
			   AND ConceptoSAT     = @ConceptoSAT
				 
		OPEN CrCFDIRetencionCalc
		FETCH NEXT FROM CrCFDIRetencionCalc INTO @RID
		WHILE @@FETCH_STATUS = 0
		BEGIN
                SELECT @Modulo         = Modulo, 
                       @ID             = ModuloId,
					   @ConceptoS    = ConceptoClave
                  FROM CFDIRetencionD 
                 WHERE RID     = @RID
                   AND Empresa = @Empresa 

                IF @Modulo = 'GAS'
                BEGIN
                      SELECT @montoTotOperacion = ISNULL(SUM(GD.Importe),0.00)                    
                        FROM GastoD GD
                        JOIN Gasto G ON GD.ID = G.ID 
						JOIN CFDIRetencionD CR ON GD.ID = CR.ModuloID
                       WHERE G.ID = @ID
					    and GD.Concepto IN (@ConceptoS)
                    GROUP BY CR.ConceptoSAT 

                      SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID GROUP BY Concepto
					
					  SELECT @CFDIRetClave = CFDIRetClave FROM CFDIRetencionConcepto WHERE Concepto = @Concepto AND Modulo = @Modulo
					

                    SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                           @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
                      FROM CFDIRetSATRetencion 
                     WHERE CLAVE = @CFDIRetClave

                    SELECT @montoTotGrav = (@montoTotOperacion*@RetmontoTotGrav)/100
                    SELECT @montoTotExent = (@montoTotOperacion*@RetmontoTotExent)/100

                    UPDATE CFDIRetencionD 
                       SET montoTotGrav  = @montoTotGrav,
                           montoTotExent = @montoTotExent
                     WHERE RID     = @RID
                       AND Empresa = @Empresa 
                END                    			
				FETCH NEXT FROM CrCFDIRetencionCalc INTO @RID
		END                			
		CLOSE CrCFDIRetencionCalc
		DEALLOCATE CrCFDIRetencionCalc
END
GO

/**************** spCFDIRetencionXMLGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLGenerar') and type = 'P') drop procedure dbo.spCFDIRetencionXMLGenerar
GO
CREATE PROC spCFDIRetencionXMLGenerar
			@ID					int,
			@Estacion			int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@IDMov	            varchar(20),
			@Version			varchar(5),
			@XML				varchar(max)	OUTPUT,
			@XMLDetalle			varchar(max)	OUTPUT,
			@XMLComplemento		varchar(max)	OUTPUT,
			@XMLAddenda			varchar(max)	OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Vista			varchar(100),
		  @XMLVerifica		varchar(max)
		  
  SELECT @XML = Plantilla, @Vista = Vista FROM CFDIRetencionXMLPlantilla WHERE Version = @Version

  /* Actualiza los Montos Gravados y Excentos en la vista CFDIRetencionCalc para que aparescan en el XML
     de acuerdo a la tabla de configuración CFDIRetSATRetencion y su concepto (Clave cátalogo SAT) */
  --  EXEC spCFDIRetencionActMonGravExce @Empresa, @Proveedor, @Estacion, @ConceptoSAT  --

  EXEC spCFDIRetencionXMLComprobante @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @Vista, @XMLComprobante = @XML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  EXEC spCFDIRetencionXMLDetalle @ID, @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT,@IDMov, @Version, @Vista, @XML = @XML OUTPUT, @XMLDetalle = @XMLDetalle OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  SELECT @XMLVerifica = REPLACE(@XML, '@Complemento', '')
  SELECT @XMLVerifica = REPLACE(ISNULL(@XMLVerifica, ''), 'T00:00:00', '')
  SELECT @XMLVerifica = dbo.fnCFDILimpiarXML(@XMLVerifica, ' SELLO CERTIFICADO ')
  SELECT @XMLVerifica = REPLACE(@XMLVerifica, '@Addenda', '')
  
  SELECT @XMLVerifica = REPLACE(@XMLVerifica, '<retenciones:Nacional />', '')    
  SELECT @XMLVerifica = REPLACE(@XMLVerifica, '<retenciones:Extranjero />', '')
  
  IF @Ok IS NULL
    EXEC spCFDIRetencionXMLVerificar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @XMLVerifica, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT                  

  EXEC spCFDIRetencionXMLComplemento @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @Vista, @XML = @XML OUTPUT, @XMLComplemento = @XMLComplemento OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  

  SELECT @XMLComplemento = REPLACE(ISNULL(@XMLComplemento, ''), 'T00:00:00', '')
  SELECT @XMLComplemento = dbo.fnCFDILimpiarXML(@XMLComplemento, ' SELLO CERTIFICADO ')
  SELECT @XMLComplemento = REPLACE(@XMLComplemento, '<pagosaextranjeros:Beneficiario />', '')  

  IF @Ok IS NULL
    EXEC spCFDIRetencionXMLCompVerificar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @XMLComplemento, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT          

  IF @Ok IS NULL  
    EXEC spCFDIRetencionXMLAddenda @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @Vista, @XML = @XML OUTPUT, @XMLAddenda = @XMLAddenda OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  
  
  SELECT @XML = REPLACE(ISNULL(@XML, ''), 'T00:00:00', ''),
		 @XMLComplemento = REPLACE(ISNULL(@XMLComplemento, ''), 'T00:00:00', ''),
		 @XMLDetalle = REPLACE(ISNULL(@XMLDetalle, ''), 'T00:00:00', ''),
		 @XMLAddenda = REPLACE(ISNULL(@XMLAddenda, ''), 'T00:00:00', '')

  SELECT @XML			 = dbo.fnCFDILimpiarXML(@XML, ' SELLO CERTIFICADO '),
		 @XMLComplemento = dbo.fnCFDILimpiarXML(@XMLComplemento, ' SELLO CERTIFICADO '),
	     @XMLDetalle = dbo.fnCFDILimpiarXML(@XMLDetalle, ' SELLO CERTIFICADO '),
	     @XMLAddenda = dbo.fnCFDILimpiarXML(@XMLAddenda, ' SELLO CERTIFICADO ')

  SELECT @XML = REPLACE(@XML, '<retenciones:Nacional />', '')
  SELECT @XML = REPLACE(@XML, '<retenciones:Extranjero />', '')
  SELECT @XML = REPLACE(@XML , '<pagosaextranjeros:Beneficiario />', '') 

  SELECT @XML = '<?xml version="1.0" encoding="UTF-8"?>' + @XML
  
  RETURN
END
GO

/**************** xpCFDRetencionAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDRetencionAlmacenar') and type = 'P') drop procedure dbo.xpCFDRetencionAlmacenar
GO
CREATE PROCEDURE xpCFDRetencionAlmacenar
			@Empresa		varchar(5), 
			@Usuario		varchar(10), 
			@Proveedor		varchar(10), 
			@ConceptoSAT	varchar(2), 
			@Version		varchar(5),
			@AlmacenarXML	bit OUTPUT, 
			@AlmacenarPDF	bit OUTPUT,
			@NomArch		varchar(255) OUTPUT,
			@Reporte		varchar(100) OUTPUT,
			@Ruta			varchar(255) OUTPUT,
		    @EnviarPara		varchar(255) OUTPUT,
			@EnviarAsunto	varchar(255) OUTPUT,
			@EnviarMensaje	varchar(255) OUTPUT,			
			@Enviar			bit          OUTPUT,
			@EnviarXML		bit          OUTPUT,
			@EnviarPDF		bit          OUTPUT,
			@Cancelacion	bit			 = 0
AS
BEGIN
  RETURN
END
GO

/**************** spCFDIRetencionAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionAlmacenar') and type = 'P') drop procedure dbo.spCFDIRetencionAlmacenar
GO
CREATE PROCEDURE spCFDIRetencionAlmacenar
			@Empresa		varchar(5), 
			@Usuario		varchar(10), 
			@Proveedor		varchar(10), 
			@ConceptoSAT	varchar(2), 
			@Version		varchar(5),
			--BUG1560
			@Ejerc			int, 
			@MesIni			int, 
			@MesFin			int,
			@AlmacenarXML	bit			 OUTPUT, 
			@AlmacenarPDF	bit			 OUTPUT,
			@NomArch		varchar(255) OUTPUT,
			@Reporte		varchar(100) OUTPUT,
			@Ruta			varchar(255) OUTPUT,
		    @EnviarPara		varchar(255) OUTPUT,
			@EnviarAsunto	varchar(255) OUTPUT,
			@EnviarMensaje	varchar(255) OUTPUT,			
			@Enviar			bit          OUTPUT,
			@EnviarXML		bit          OUTPUT,
			@EnviarPDF		bit          OUTPUT,
			@Cancelacion	bit			 = 0,
			@RIDAnt         varchar(20)  = null 
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
    @FechaEmision		datetime,
    @FechaRegistro		datetime,    
    @ArchivoXML			varchar(255), 
    @ArchivoPDF			varchar(255),
    @Nombre				varchar(100),
    @eMail				varchar(100),
    @AlmacenarTipo		varchar(20),
    @EnviarTipo			varchar(20),
    @EnviarRetencion	bit

  SELECT @EnviarXML = 0, @EnviarPDF = 0, @NomArch = NULL
  
  SELECT @Reporte = NULLIF(RepConstancia,'') FROM CFDIRetencionCfg

  SELECT @AlmacenarXML = AlmacenarXML, @AlmacenarPDF = AlmacenarPDF, @Ruta = RetencionAlmacenarRuta, @Nombre = RetencionNombre, @Enviar = CASE WHEN EnviarXMLRetencion = 1 OR EnviarPDFRetencion = 1 THEN 1 ELSE 0 END,
         @EnviarXML = EnviarXMLRetencion, @EnviarPDF = EnviarPDFRetencion, @EnviarAsunto = EnviarAsuntoRetencion, @EnviarMensaje = EnviarMensajeRetencion, @EnviarRetencion = EnviarRetencion
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa 

  IF @EnviarRetencion = 0 SELECT @Enviar = 0, @EnviarPDF = 0, @EnviarXML = 0

  IF NULLIF(@EnviarTipo,'') IS NULL SET @EnviarTipo = 'Cliente'
 
  SELECT @NomArch = @Nombre 
  SELECT @NomArch = REPLACE(@NomArch, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Proveedor>', LTRIM(RTRIM(ISNULL(@Proveedor,''))))  
  SELECT @NomArch = REPLACE(@NomArch, '<Concepto>', LTRIM(RTRIM(ISNULL(@ConceptoSAT,''))))    
  SELECT @NomArch = REPLACE(@NomArch, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Ejerc),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @MesIni),''))))  
  IF @RIDAnt IS NOT NULL
    SELECT @NomArch = @NomArch+ '_'+CONVERT(VARCHAR,@RIDAnt)
  IF @Cancelacion = 1
    SELECT @Nomarch = @NomArch+'_CANCELACION'

  SELECT @Ruta = REPLACE(@Ruta, '<Proveedor>', LTRIM(RTRIM(ISNULL(@Proveedor,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Ejerc),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @MesIni),''))))  
  SELECT @Ruta = REPLACE(@Ruta, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Concepto>', LTRIM(RTRIM(ISNULL(@ConceptoSAT,''))))  

  EXEC xpCFDRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, @AlmacenarXML = @AlmacenarXML OUTPUT, @AlmacenarPDF = @AlmacenarPDF OUTPUT,@NomArch = @NomArch OUTPUT,@Reporte = @Reporte OUTPUT,@Ruta = @Ruta OUTPUT,@EnviarPara = @EnviarPara OUTPUT,@EnviarAsunto = @EnviarAsunto OUTPUT,@EnviarMensaje = @EnviarMensaje OUTPUT, @Enviar = @Enviar OUTPUT, @EnviarXML = @EnviarXML OUTPUT, @EnviarPDF = @EnviarPDF OUTPUT, @Cancelacion = @Cancelacion

  IF RIGHT(@Ruta, 1) = '\' SELECT @Ruta = SUBSTRING(@Ruta, 1, LEN(@Ruta)-1)

  SELECT @EnviarPara = '',
         @EnviarAsunto  = REPLACE(@EnviarAsunto, '<Nombre>', @NomArch),
         @EnviarMensaje = REPLACE(@EnviarMensaje, '<Nombre>', @NomArch)

  SELECT @EnviarPara = eMail1 FROM Prov WHERE Proveedor = @Proveedor

  RETURN
END
GO

/******************************* spCFDIRetencionGenerarArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionGenerarArchivo') and type = 'P') drop procedure dbo.spCFDIRetencionGenerarArchivo
GO             
CREATE PROCEDURE spCFDIRetencionGenerarArchivo
		@Empresa		varchar(5),
		@Archivo		varchar(255),	
		@XML			varchar(max),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @RutaANSIToUTF				varchar(255),
    @Shell						varchar(8000),
    @UsarTimbrarRetencion		bit

  DECLARE @Datos TABLE(Datos		varchar(255))

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
  
  SELECT @UsarTimbrarRetencion= UsarTimbrarRetencion FROM EmpresaCFD WHERE Empresa = @Empresa
  
  IF @UsarTimbrarRetencion = 0
    SELECT @RutaANSIToUTF = RutaANSIToUTF FROM EmpresaCFD WHERE Empresa = @Empresa  
  ELSE
    SELECT @RutaANSIToUTF = RutaANSIToUTF FROM EmpresaCFDRetencion WHERE Empresa = @Empresa  
    
  IF @Ok IS NULL      
    EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaEnArchivo2 @IDArchivo, @XML, @Ok
    --INSERT @Datos (Datos) OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  
	
  IF @Ok IS NULL
  BEGIN
    SET @Shell = CHAR(34) + CHAR(34) + RTRIM(LTRIM(@RutaANSIToUTF)) + CHAR(34) + ' A2U ' + CHAR(34) + LTRIM(RTRIM(@Archivo)) + CHAR(34) + CHAR(34) 

    --Cuando viene en nulo no se debe de insertar.
    EXEC xp_cmdshell @Shell, no_output
    
    IF EXISTS(SELECT Datos FROM @Datos WHERE RTRIM(LTRIM(Datos)) = '1' ) SELECT @Ok = 71610, @OkRef = ISNULL(@Archivo,'')
  END
END
GO

/************** spCFDIRetencionObtenerTimbre *************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionObtenerTimbre') and type = 'P') drop procedure dbo.spCFDIRetencionObtenerTimbre
GO
CREATE PROCEDURE spCFDIRetencionObtenerTimbre
		   @Empresa				varchar(5),
           @ID					int,
		   @Proveedor			varchar(10),
		   --BUG1143
		   @Documento			nvarchar(max),		   
		   @CadenaOriginal		varchar(max)	OUTPUT,
		   @SelloSAT			varchar(max)	OUTPUT,
		   @SelloCFD			varchar(max)    OUTPUT,
		   @FechaTimbrado		varchar(max)	OUTPUT,
		   @UUID				varchar(50)		OUTPUT,
		   @TFDVersion			varchar(max)	OUTPUT,
		   @noCertificadoSAT	varchar(max)	OUTPUT,
		   @TFDCadenaOriginal	varchar(max)	OUTPUT,
		   @Ok					int				OUTPUT,
		   @OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @versionCFD			varchar(10),
		  @iDatos				int,
		  @DocumentoXML			xml,
		  @PrefijoCFDI			varchar(255),
		  @RutaCFDI				varchar(255)

  SELECT @VersionCFD = Version FROM EmpresaCFD WHERE Empresa = @Empresa
  SELECT @OkRef = NULL

  --BUG1143
  --SELECT @Documento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Documento, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),'ñ','n')

  --BUG1143
  SELECT @Documento = REPLACE(@Documento, '<?xml version="1.0" encoding="UTF-8"?>', '')
  
  EXEC sp_xml_preparedocument @iDatos OUTPUT, @Documento
 
  SELECT @OkRef = MENSAJE FROM OPENXML (@iDatos, '/ERROR',2) WITH (MENSAJE  varchar(255))
  IF @OkRef IS NOT NULL SELECT @OK = 71650
  EXEC sp_xml_removedocument @iDatos  

  IF @OK IS NULL
  BEGIN
    SET @DocumentoXML = CONVERT(XML,@Documento)	
    
    SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 'retenciones="http' + CHAR(58) + '//www.sat.gob.mx/esquemas/retencionpago/1" xmlns' + CHAR(58) + 'tfd="http' + CHAR(58) + '//www.sat.gob.mx/TimbreFiscalDigital"/>'    

    EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML, @PrefijoCFDI
        
    SET @RutaCFDI = '/retenciones' + CHAR(58) + 'Retenciones/retenciones' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'

    SELECT  
	  @UUID = UUID
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (UUID uniqueidentifier)

    SELECT  
	  @SelloSAT = SelloSAT
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (selloSAT varchar(max))
      	  
    SELECT  
	  @SelloCFD = selloCFD
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (selloCFD varchar(max))
      
    SELECT  
	  @TFDVersion = version
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (version varchar(max))

    SELECT  
	  @FechaTimbrado = FechaTimbrado
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (FechaTimbrado varchar(max))
	  
    SELECT  
	  @noCertificadoSAT = noCertificadoSAT
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (noCertificadoSAT varchar(max))

    SELECT @TFDCadenaOriginal = '||'+@TFDVersion+'|'+@UUID+'|'+@FechaTimbrado+'|'+@SelloCFD+'|'+@noCertificadoSAT+'||'
    
    EXEC sp_xml_removedocument @iDatos  
  END

  RETURN
END
GO

/*************** spCFDITimbrarRetencion *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDITimbrarRetencion') and type = 'P') drop procedure dbo.spCFDITimbrarRetencion
GO             
CREATE PROC spCFDITimbrarRetencion
            @Estacion			int,
            @ID					int,
			@Proveedor			varchar(10),
			@ConceptoSAT		varchar(50),
			@RIDAnt             varchar(20),
			@Empresa			varchar(10),
			@CFDI				varchar(max),
			@Version			varchar(5),
			--BUG1560
			@Ejerc				int, 
			@MesIni				int, 
			@MesFin				int,
			@CFDITimbrado		varchar(max) OUTPUT,
		    @CadenaOriginal		varchar(max) OUTPUT,
		    @SelloSAT			varchar(max) OUTPUT,
			@SelloCFD			varchar(max) OUTPUT,
		    @FechaTimbrado		varchar(max) OUTPUT,
		    @UUID				varchar(50)	 OUTPUT,
		    @TFDVersion			varchar(max) OUTPUT,
		    @noCertificadoSAT	varchar(max) OUTPUT,
		    @TFDCadenaOriginal	varchar(max) OUTPUT,
			@Ok					int			 OUTPUT,
			@OkRef				varchar(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @ServidorPAC			varchar(100),
  		  @UsuarioPAC			varchar(100),
		  @PaswordPAC			varchar(100),
		  @AccionCFDI			varchar(50),
		  @RutaCer				varchar(200),
		  @RutaKey				varchar(200),
		  @passKey				varchar(100),
		  @RFC					varchar(20),
		  @AlmacenarRuta		varchar(200),
		  @Documento			varchar(max),
		  @RutaIntelisisCFDI	varchar(255),
		  @CadenaConexion		varchar(max),
		  @PswPFX				varchar(30),
		  @DatosXMl				varchar(max),
		  @RenglonDatos			varchar(255),
		  @Error				bit,
		  --@XML					xml,
		  @xml					varchar(max),
		  @RID					int,
		  @iDatos				int,
		  @DocumentoXML			xml,
		  @PrefijoCFDI			varchar(255),
		  @Shell				varchar(8000),
		  @r					varchar(max),
		  @FirmaCancelacionSAT  varchar(max),
		  @FechaCancelacionSAT  varchar(30),

		  @Mov					varchar(20),
		  @Usuario				varchar(10),
		  @Adicional			bit,
		  @AlmacenarXML			bit,
		  @AlmacenarPDF			bit,    
		  @EnviarXML			bit,
		  @EnviarPDF			bit,
		  @Archivo				varchar(255),
		  @NomArch				varchar(255),
		  @Ruta					varchar(255),
		  @PDFExiste			int,
		  @ArchivoPDF			varchar(255),
		  @Enviar				bit,
		  @Reporte				varchar(100),
		  @Contacto				varchar(10),
		  @eMail				varchar(255),
		  @Para					varchar(255),
		  @Asunto				varchar(max),
		  @Mensaje				varchar(max),
		  @Cancelacion			bit,
		  @TimeOutTimbrado		int,
		  @MensajeSF			varchar(max), 
		  @Dato1				varchar(max),
		  @SelloCancelacionSAT	varchar(max), 
		  @Timbrar				bit,
		  @EsCadenaOriginal		bit,
		  @ModoPruebas			bit,
		  @Existe				int,
		  
		  @NoTimbrado			int,
		  @TokenCanPAC			varchar(max),
		  @CuentaCanPAC			varchar(max),
		  @UsuarioCanPAC		varchar(50),
		  @PaswordCanPAC		varchar(50),
		  @RutaProvPac			varchar(max),
		  @UsarTimbrarRetencion bit,
		  @CFDflex					bit
	     
  DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(255))

  SELECT @FechaTimbrado = CONVERT(varchar(30),FechaTimbrado,127), @UUID = UUID, @Documento = Documento, @SelloCancelacionSAT = SelloCancelacionSAT FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID

  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  
  --BUG1068
  --SELECT @RutaIntelisisCFDI = RutaIntelisisCFDI,        
  --       @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado)    
  --  FROM EmpresaCFD WHERE Empresa = @Empresa

 --25788
  SELECT @CFDflex=CFDFlex FROM  EmpresaGral WHERE Empresa = @Empresa
  
  SELECT @UsarTimbrarRetencion= UsarTimbrarRetencion FROM EmpresaCFD WHERE Empresa = @Empresa

  IF @UsarTimbrarRetencion =0
    SELECT 
         @ServidorPAC = TimbrarCFDIServidor, 
         @UsuarioPAC = TimbrarCFDIUsuario, 
         @PaswordPAC = TimbrarCFDIPassword, 
         @RutaCer = Certificado, 
         @RutaKey = Llave, 
         @passKey = CASE WHEN @CFDflex=1 THEN ContrasenaSello ELSE ContrasenakeyCSD END,         
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,''),
		 --BUG1068
		 @RutaIntelisisCFDI = RutaIntelisisCFDI,        
         @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado)    
		 FROM EmpresaCFD WHERE Empresa = @Empresa		 
  ELSE 
    SELECT 
         @ServidorPAC = TimbrarCFDIServidor, 
         @UsuarioPAC = TimbrarCFDIUsuario, 
         @PaswordPAC = TimbrarCFDIPassword, 
         @RutaCer = Certificado, 
         @RutaKey = Llave, 
         @passKey = ContrasenaLlave,         
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,''),
		 --BUG1068
		 @RutaIntelisisCFDI = RutaIntelisisCFDI,        
         @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado)    
		 FROM EmpresaCFDRetencion WHERE Empresa = @Empresa		

  IF @UUID IS NOT NULL
    SELECT @Ok = 71680, @OkRef = 'El Movimiento Ya Fue Timbrado'

  SELECT @AccionCFDI = 'TIMBRAR', @PswPFX = 'Intelisis1234567', @Timbrar = 1
 
  --BUG1560
  EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, @Ejerc, @MesIni, @MesFin, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @Archivo OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0,@RIDAnt

  SELECT @AlmacenarRuta =   @Ruta + '\' + @Archivo +'.tmp'

  DECLARE @Hoy datetime
  SELECT @Hoy = GETDATE()
  SELECT @FechaTimbrado = CONVERT(varchar(30), @Hoy,127), @UUID = '0'
 
  IF @RutaIntelisisCFDI IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Intelisis CFDI no Puede Estar Vacio' ELSE
  IF @FechaTimbrado IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Fecha de Timbrado no Puede Estar Vacio' ELSE
  IF @ServidorPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Servidor PAC No puede Estar Vacio' ELSE    
  IF @RutaCer IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Certificado CSD No puede Estar Vacio' ELSE 
  IF @RutaKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Archivo Key No puede Estar Vacio' ELSE 
  IF @passKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Password Key No puede Estar Vacio' ELSE 
  IF @UUID IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Folio Fiscal UUID No puede Estar Vacio' ELSE 
  IF @RFC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato RFC Empresa No puede Estar Vacio' ELSE 
  IF @AlmacenarRuta IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Almacenar Ruta No puede Estar Vacio'

  IF @ServidorPAC='KONESH'
  BEGIN
	--SET @UsuarioPAC=@UsuarioCanPAC 
	--SET @PaswordPAC=@PaswordCanPAC
    IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokencanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  
  IF @UsuarioPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Usuario PAC No puede Estar Vacio' ELSE 
  IF @PaswordPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Pasword PAC No puede Estar Vacio' 
  
  IF @Ok IS NULL
    EXEC spCFDIRetencionGenerarArchivo @Empresa, @AlmacenarRuta, @CFDI, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+CONVERT(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+@FechaTimbrado+'</FECHA>'+
		                     '<SERVIDOR>'+@ServidorPAC+'</SERVIDOR>'+
						     '<USUARIO>'+@UsuarioPAC+'</USUARIO>'+
						     '<PASSWORD>'+@PaswordPAC+'</PASSWORD>'+
						     '<CUENTA>'+ISNULL(@CuentaCanPAC,'')+'</CUENTA>'+
						     '<TOKEN>'+ISNULL(@TokenCanPAC,'')+'</TOKEN>'+
						     '<ACCION>'+@AccionCFDI+'</ACCION>'+
						     '<RUTACER>'+@RutaCer+'</RUTACER>'+
						     '<RUTAKEY>'+@RutaKey+'</RUTAKEY>'+
						     '<PWDKEY>'+@passKey+'</PWDKEY>'+
						     '<PWDPFX>'+@PswPFX+'</PWDPFX>'+
						     '<UUID>'+@UUID+'</UUID>'+
						     '<RFC>'+@RFC+'</RFC>'+
			                  '<TIMEOUT>'+CONVERT(varchar(30),@TimeOutTimbrado)+'</TIMEOUT>'+
						     '<RUTAARCHIVO>'+@AlmacenarRuta+'</RUTAARCHIVO>'+
						     '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'+
						     '<USARFIRMASAT>0</USARFIRMASAT>'+
						     '</IntelisisCFDI>'

    SELECT @Shell = CHAR(34)+CHAR(34)+@RutaIntelisisCFDI+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
 
    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output   
    
    EXEC spVerificarArchivo @AlmacenarRuta, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @DatosXMl = '', @CadenaOriginal = '', @EsCadenaOriginal = 0
    DECLARE crResultadoXMl CURSOR FOR
      SELECT Id, Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
    OPEN crResultadoXMl
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN  
            IF @RID = 1 AND CHARINDEX('<IntelisisCFDI><Error>',@RenglonDatos) >= 1
            SELECT @Error = 1

            IF @RID = 1 AND CHARINDEX('<',@RenglonDatos) = 0
              SELECT @Error = 1

            SELECT @DatosXMl = @DatosXML + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl

    IF @Error = 1 SELECT @Ok = 71650,  @OkRef = @DatosXml
    IF @r <> 0
      SELECT @OK = 71650, @OkREf = 'Error al Ejecutar IntelisisCFDI.exe '+ISNULL(@DatosXml,'')
    IF NULLIF(@DatosXMl,'') IS NULL SELECT @Ok = 71650, @OkRef = 'Se Esperaba Respuesta de IntelisisCFDI.exe' 

    IF @Ok is NULL
    BEGIN
      IF CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) <> 0
      BEGIN
        SELECT @CadenaOriginal = SUBSTRING(@DatosXML, CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0), LEN(@DatosXML) - CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) + 1)
        SELECT @DatosXML = SUBSTRING(@DatosXML, 1, CHARINDEX('<CADENAORIGINAL>', @DatosXML, 0) - 1)
      END
      ELSE
        SELECT @CadenaOriginal = ''

	  SELECT @CadenaOriginal = REPLACE(REPLACE(@CadenaOriginal,'<CADENAORIGINAL>',''),'</CADENAORIGINAL>','')

      SELECT @XML = @DatosXml

      IF @OK IS NULL 
      BEGIN
	    EXEC spCFDIRetencionObtenerTimbre @Empresa, @ID, @Proveedor, @DatosXML, @CadenaOriginal OUTPUT, @SelloSAT OUTPUT, @SelloCFD OUTPUT, @FechaTimbrado OUTPUT, @UUID OUTPUT, @TFDVersion OUTPUT, @noCertificadoSAT OUTPUT, @TFDCadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

		SELECT @CFDITimbrado = @DatosXML
      END
    END
  END
  RETURN
END
GO

/**************** spCFDIRetencionActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionActualizar') and type = 'P') drop procedure dbo.spCFDIRetencionActualizar
GO
CREATE PROC spCFDIRetencionActualizar
			@Estacion				int,
			@ID						int, 
			@Proveedor				varchar(10), 
			@Empresa				varchar(5), 
			@Version				varchar(5), 
			@ConceptoSAT			varchar(50), 
			@Documento				varchar(max), 
			@CadenaOriginal			varchar(max), 
			@SelloSAT				varchar(max), 
			@SelloCFD				varchar(max), 
			@FechaTimbrado			datetime, 
			@UUID					varchar(50), 
			@TFDVersion				varchar(max), 
			@noCertificadoSAT		varchar(max), 
			@TFDCadenaOriginal		varchar(max),
			@RFCEmisor				varchar(20),
			@RFCReceptor			varchar(20),
			
			@montoTotExent			float,
			@montoTotGrav			float,
			@montoTotOperacion		float,
			@montoTotRet			float,
			
			@ArchivoQRCode			varchar(255),
			@Archivo				varchar(255),
			@ArchivoPDF				varchar(255),
			
			@Ejerc					int, 
			@MesIni					int, 
			@MesFin					int,
	
			@Ok						int				OUTPUT, 
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF @FechaTimbrado IS NULL SELECT @FechaTimbrado = GETDATE()
  
  DECLARE @ModuloPago		varchar(5),
		  @ModuloPagoAnt	varchar(5),
          @IDPago			int,
		  @IDPagoAnt		int,
		  @ModuloAux		varchar(5),
		  @ModuloAuxAnt		varchar(5),
		  @ModuloID			int,
		  @ModuloIDAnt		int,
		  
		  @Importe			float,
		  @Fecha			datetime,
		  @Ejercicio		int,
		  @Periodo			int,
		  @Mov				varchar(20),
		  @MovID			varchar(20),
		  @Moneda			varchar(10)

  SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  IF NULLIF(RTRIM(@UUID), '') IS NOT NULL
  BEGIN
    SELECT @Fecha = FechaEmision, @Ejercicio = Ejercicio, @Periodo = Periodo, @Mov = Mov, @MovID = MovID, @Importe = Importe
      FROM Cxp
     WHERE ID = @ID
             
    UPDATE CFDRetencion
       SET SelloSAT				= @SelloSAT,
    	   Sello				= @SelloCFD,
		   FechaTimbrado		= @FechaTimbrado,
		   UUID					= @UUID,
		   TFDVersion			= @TFDVersion,
		   noCertificadoSAT		= @noCertificadoSAT,
		   TFDCadenaOriginal	= @TFDCadenaOriginal,
		   Documento			= @Documento,
		   RFCEmisor			= @RFCEmisor,
		   RFCReceptor			= @RFCReceptor,
		   Importe				= @Importe,
		   CadenaOriginal		= @CadenaOriginal,
		   ConceptoSAT			= @ConceptoSAT,
		   Proveedor			= @Proveedor,
		   EsPago				= 0,
		   montoTotExent		= @montoTotExent,
		   montoTotGrav			= @montoTotGrav,
		   montoTotOperacion	= @montoTotOperacion,
		   montoTotRet			= @montoTotRet,
		   ArchivoQRCode		= @ArchivoQRCode,
		   ArchivoXML			= @Archivo,
		   ArchivoPDF			= @ArchivoPDF,
		   Ejerc				= @Ejerc,
		   MesIni				= @MesIni,
		   MesFin				= @MesFin,
		   TimbradoCxpID		= @ID
      FROM CFDRetencion
     WHERE Modulo = 'CXP'
       AND ModuloID = @ID
       AND Proveedor = @Proveedor
       AND ConceptoSAT = @ConceptoSAT
       
  IF @@ROWCOUNT = 0
    INSERT INTO CFDRetencion(
				Modulo, ModuloID,  Fecha,  Ejercicio,  Periodo,  Empresa,  Mov,  MovID,  RFCEmisor,  RFCReceptor,  Importe,  noCertificado,     Sello,     CadenaOriginal,  Documento, Timbrado,  UUID,  FechaTimbrado, TipoCambio,  SelloSAT,  TFDVersion,  noCertificadoSAT,  TFDCadenaOriginal,  VersionCFD, Moneda,  Proveedor,  ConceptoSAT, EsPago,  montoTotExent,  montoTotGrav,  montoTotOperacion,  montoTotRet,  ArchivoQRCode,  ArchivoXML,  ArchivoPDF,  Ejerc,  MesIni,  MesFin,  TimbradoCxpID)
		 SELECT 'CXP', @ID,       @Fecha, @Ejercicio, @Periodo, @Empresa, @Mov, @MovID, @RFCEmisor, @RFCReceptor, @Importe, @noCertificadoSAT, @SelloCFD, @CadenaOriginal, @Documento, 1,        @UUID, @FechaTimbrado, 1,          @SelloSAT, @TFDVersion, @noCertificadoSAT, @TFDCadenaOriginal, @Version,   @Moneda, @Proveedor, @ConceptoSAT, 0,      @montoTotExent, @montoTotGrav, @montoTotOperacion, @montoTotRet, @ArchivoQRCode, @Archivo,    @ArchivoPDF, @Ejerc, @MesIni, @MesFin, @ID

    SELECT @ModuloPagoAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @ModuloPago = MIN(ModuloPago)
        FROM CFDIRetencionD
       WHERE EstacionTrabajo = @Estacion
         AND Proveedor = @Proveedor
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa
         AND ModuloPago > @ModuloPagoAnt
      
      IF @ModuloPago IS NULL BREAK
      
      SELECT @ModuloPagoAnt = @ModuloPago
      
      SELECT @IDPagoAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @IDPago = MIN(IDPago)
          FROM CFDIRetencionD
         WHERE EstacionTrabajo = @Estacion
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT
           AND Empresa = @Empresa
           AND ModuloPago = @ModuloPago
           AND IDPago > @IDPagoAnt

        IF @IDPago IS NULL BREAK
      
        SELECT @IDPagoAnt = @IDPago
      
        SELECT @Fecha = NULL, @Ejercicio = NULL, @Periodo = NULL, @Mov = NULL, @MovID = NULL, @Importe = NULL
      
        SELECT @Fecha = FechaPago, @Ejercicio = YEAR(FechaPago), @Periodo = MONTH(FechaPago), @Mov = Pago, @MovID = PagoID, @Importe = ImportePago
          FROM CFDIRetencionD 
         WHERE EstacionTrabajo = @Estacion
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT
           AND Empresa = @Empresa
           AND ModuloPago = @ModuloPago
           AND IDPago = @IDPago
      
        UPDATE CFDRetencion
           SET SelloSAT				= @SelloSAT,
    	       Sello				= @SelloCFD,
		       FechaTimbrado		= @FechaTimbrado,
		       UUID					= @UUID,
		       TFDVersion			= @TFDVersion,
		       noCertificadoSAT		= @noCertificadoSAT,
		       TFDCadenaOriginal	= @TFDCadenaOriginal,
		       Documento			= @Documento,
		       RFCEmisor			= @RFCEmisor,
		       RFCReceptor			= @RFCReceptor,
		       Importe				= @Importe,
		       CadenaOriginal		= @CadenaOriginal,
		       ConceptoSAT			= @ConceptoSAT,
		       Proveedor			= @Proveedor,
		       EsPago				= 1,
		       montoTotExent		= @montoTotExent,
		       montoTotGrav			= @montoTotGrav,
		       montoTotOperacion	= @montoTotOperacion,
		       montoTotRet			= @montoTotRet,
			   ArchivoQRCode		= @ArchivoQRCode,
			   ArchivoXML			= @Archivo,
			   ArchivoPDF			= @ArchivoPDF,
		       Ejerc				= @Ejerc,
		       MesIni				= @MesIni,
		       MesFin				= @MesFin,
			   TimbradoCxpID		= @ID
          FROM CFDRetencion
         WHERE Modulo = @ModuloPago
           AND ModuloID = @IDPago
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT

        IF @@ROWCOUNT = 0
          INSERT INTO CFDRetencion(
				   Modulo,      ModuloID,  Fecha,  Ejercicio,  Periodo,  Empresa,  Mov,  MovID,  RFCEmisor,  RFCReceptor,  Importe,  noCertificado,     Sello,     CadenaOriginal,  Documento, Timbrado,  UUID,  FechaTimbrado, TipoCambio,  SelloSAT,  TFDVersion,  noCertificadoSAT,  TFDCadenaOriginal,  VersionCFD, Moneda,  Proveedor,  ConceptoSAT, EsPago,  montoTotExent,   montoTotGrav,   montoTotOperacion,   montoTotRet,  ArchivoQRCode,  ArchivoXML,  ArchivoPDF,  Ejerc,  MesIni,  MesFin,  TimbradoCxpID)
		   SELECT @ModuloPago, @IDPago,   @Fecha, @Ejercicio, @Periodo, @Empresa, @Mov, @MovID, @RFCEmisor, @RFCReceptor, @Importe, @noCertificadoSAT, @SelloCFD, @CadenaOriginal, @Documento, 1,        @UUID, @FechaTimbrado, 1,          @SelloSAT, @TFDVersion, @noCertificadoSAT, @TFDCadenaOriginal, @Version,   @Moneda, @Proveedor, @ConceptoSAT, 1,      @montoTotExent,  @montoTotGrav,  @montoTotOperacion,  @montoTotRet, @ArchivoQRCode, @Archivo,    @ArchivoPDF, @Ejerc, @MesIni, @MesFin, @ID

        SELECT @ModuloAuxAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @ModuloAux = MIN(Modulo)
            FROM CFDIRetencionD
           WHERE EstacionTrabajo = @Estacion
             AND Proveedor = @Proveedor
             AND ConceptoSAT = @ConceptoSAT
             AND Empresa = @Empresa
             AND ModuloPago = @ModuloPago
             AND IDPago = @IDPago
             AND Modulo > @ModuloAuxAnt
        
          IF @ModuloAux IS NULL BREAK
        
          SELECT @ModuloAuxAnt = @ModuloAux
        
          SELECT @ModuloIDAnt = 0
          WHILE(1=1)
          BEGIN
            SELECT @ModuloID = MIN(ModuloID)
              FROM CFDIRetencionD
             WHERE EstacionTrabajo = @Estacion
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT
               AND Empresa = @Empresa
               AND ModuloPago = @ModuloPago
               AND IDPago = @IDPago
               AND Modulo = @ModuloAux
               AND ModuloID > @ModuloIDAnt
        
            IF @ModuloID IS NULL BREAK
        
            SELECT @ModuloIDAnt = @ModuloID

            SELECT @Fecha = NULL, @Ejercicio = NULL, @Periodo = NULL, @Mov = NULL, @MovID = NULL, @Importe = NULL
      
            SELECT @Fecha = FechaEmision, @Ejercicio = Ejercicio, @Periodo = Periodo, @Mov = Mov, @MovID = MovID, @Importe = Importe
              FROM CFDIRetencionD 
             WHERE EstacionTrabajo = @Estacion
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT
               AND Empresa = @Empresa
               AND ModuloPago = @ModuloPago
               AND IDPago = @IDPago
               AND Modulo = @ModuloAux
               AND ModuloID = @ModuloID

            UPDATE CFDRetencion
               SET SelloSAT				= @SelloSAT,
       	           Sello				= @SelloCFD,
		           FechaTimbrado		= @FechaTimbrado,
		           UUID					= @UUID,
		           TFDVersion			= @TFDVersion,
		           noCertificadoSAT		= @noCertificadoSAT,
		           TFDCadenaOriginal	= @TFDCadenaOriginal,
		           Documento			= @Documento,
		           RFCEmisor			= @RFCEmisor,
		           RFCReceptor			= @RFCReceptor,
		           Importe				= @Importe,
		           CadenaOriginal		= @CadenaOriginal,
		           ConceptoSAT			= @ConceptoSAT,
		           Proveedor			= @Proveedor,
		           EsPago				= 0,
		           montoTotExent		= @montoTotExent,
		           montoTotGrav			= @montoTotGrav,
		           montoTotOperacion	= @montoTotOperacion,
		           montoTotRet			= @montoTotRet,
			       ArchivoQRCode		= @ArchivoQRCode,
			       ArchivoXML 			= @Archivo,
			       ArchivoPDF			= @ArchivoPDF,
		           Ejerc				= @Ejerc,
		           MesIni				= @MesIni,
		           MesFin				= @MesFin,
				   TimbradoCxpID		= @ID
              FROM CFDRetencion
             WHERE Modulo = @ModuloAux
               AND ModuloID = @ModuloID
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT               

            IF @@ROWCOUNT = 0
              INSERT INTO CFDRetencion(
				      Modulo, ModuloID, Fecha,        Ejercicio, Periodo, Empresa, Mov, MovID,  RFCEmisor,  RFCReceptor, Importe, Impuesto1, Impuesto2, Retencion1,      Retencion2,       noCertificado,     Sello,     CadenaOriginal,  Documento, Timbrado,  UUID,  FechaTimbrado, TipoCambio,  SelloSAT,  TFDVersion,  noCertificadoSAT,  TFDCadenaOriginal,  VersionCFD, Moneda,  Proveedor,  ConceptoSAT, EsPago,  montoTotExent,   montoTotGrav,   montoTotOperacion,   montoTotRet,  ArchivoQRCode,  ArchivoXML,  ArchivoPDF,  Ejerc,  MesIni,  MesFin,  TimbradoCxpID)				     
		       SELECT Modulo, ModuloID, FechaEmision, Ejercicio, Periodo, Empresa, Mov, MovID, @RFCEmisor, @RFCReceptor, SUM(Importe), SUM(IVA),  SUM(IEPS), SUM(Retencion1), SUM(Retencion2), @noCertificadoSAT, @SelloCFD, @CadenaOriginal, @Documento, 1,        @UUID, @FechaTimbrado, 1,          @SelloSAT, @TFDVersion, @noCertificadoSAT, @TFDCadenaOriginal, @Version,   @Moneda, @Proveedor, @ConceptoSAT, 0,      @montoTotExent,  @montoTotGrav,  @montoTotOperacion,  @montoTotRet, @ArchivoQRCode, @Archivo,    @ArchivoPDF, @Ejerc, @MesIni, @MesFin, @ID
                 FROM CFDIRetencion
                WHERE EstacionTrabajo = @Estacion
                  AND Proveedor = @Proveedor
                  AND ConceptoSAT = @ConceptoSAT
                  AND Empresa = @Empresa
                  AND Modulo = @ModuloAux
                  AND ModuloID = @ModuloID
                GROUP BY Modulo, ModuloID, FechaEmision, Ejercicio, Periodo, Empresa, Mov, MovID, Importe         
          END
        END
      END
    END
  END
  RETURN
END
GO

/**************** spCFDIRetencionTimbrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionTimbrar') and type = 'P') drop procedure dbo.spCFDIRetencionTimbrar
GO
CREATE PROC spCFDIRetencionTimbrar
			@Estacion						int,
			@ID								int,
			@Proveedor						varchar(10), 
			@ConceptoSAT					varchar(50), 
			@RIDAnt                         varchar(20),
			@Empresa						varchar(5),
			@Version						varchar(5),
			@Usuario						varchar(10),
			@RFCEmisor						varchar(20),
			@RFCReceptor					varchar(20),
			@ArchivoQRCode					varchar(255),
			@Archivo						varchar(255),
			@ArchivoPDF						varchar(255),
			@montoTotExent					float, 
			@montoTotGrav					float, 
			@montoTotOperacion				float, 
			@montoTotRet					float,
			@Ejerc							int, 
			@MesIni							int, 
			@MesFin							int,
			@UUID							varchar(50)     OUTPUT,
			@XML							varchar(max)	OUTPUT,			
			@Ok								int				OUTPUT,
			@OkRef							varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN		
  DECLARE @CFDITimbrado			varchar(max),
          @CadenaOriginal		varchar(max),
          @SelloSAT				varchar(max),
		  @SelloCFD				varchar(max),
          @FechaTimbrado		varchar(max),         
          @TFDVersion			varchar(max),
          @noCertificadoSAT		varchar(max),
          @TFDCadenaOriginal	varchar(max)

  IF @Ok IS NULL
    EXEC spCFDITimbrarRetencion @Estacion, @ID, @Proveedor, @ConceptoSAT, @RIDAnt, @Empresa, @XML, @Version, @Ejerc, @MesIni, @MesFin, @CFDITimbrado OUTPUT, @CadenaOriginal OUTPUT, @SelloSAT OUTPUT, @SelloCFD OUTPUT,  @FechaTimbrado OUTPUT, @UUID OUTPUT, @TFDVersion OUTPUT, @noCertificadoSAT OUTPUT, @TFDCadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Ok IS NULL
  BEGIN
    EXEC spCFDIRetencionActualizar @Estacion, @ID, @Proveedor, @Empresa, @Version, @ConceptoSAT, @Documento = @CFDITimbrado, @CadenaOriginal = @CadenaOriginal, 
								   @SelloSAT = @SelloSAT, @SelloCFD = @SelloCFD, @FechaTimbrado = @FechaTimbrado, @UUID = @UUID, @TFDVersion = @TFDVersion, @noCertificadoSAT = @noCertificadoSAT, 
                                   @TFDCadenaOriginal = @TFDCadenaOriginal, @RFCEmisor = @RFCEmisor, @RFCReceptor = @RFCReceptor, 
                                   @montoTotExent = @montoTotExent, @montoTotGrav = @montoTotGrav, @montoTotOperacion = @montoTotOperacion, @montoTotRet = @montoTotRet,
                                   @ArchivoQRCode = @ArchivoQRCode, @Archivo = @Archivo, @ArchivoPDF = @ArchivoPDF, @Ejerc = @Ejerc, @MesIni = @MesIni, @MesFin = @MesFin,
                                   @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
    SELECT @XML = @CFDITimbrado
  END
  RETURN
END
GO

/**************** fnCFDFlexFormatearImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCFDFlexFormatearImporte') DROP FUNCTION fnCFDFlexFormatearImporte
GO
CREATE FUNCTION fnCFDFlexFormatearImporte 
	(
	@Importe				float,
	@Entero					int,
	@Decimal				int
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(255),
    @NumeroEntero		int,
    @NumeroDecimal		float,
    @TextoEntero		varchar(100),
    @TextoDecimal		varchar(100),
    @PosicionInicial	int,
    @LongitudDecimal	int

  SET @NumeroEntero = FLOOR(@Importe)
  SET @NumeroDecimal = @Importe - @NumeroEntero
  
  SET @TextoEntero  = RTRIM(LTRIM(CONVERT(varchar,@NumeroEntero)))
  SET @TextoDecimal = RTRIM(LTRIM(CONVERT(varchar,@NumeroDecimal)))
  IF @TextoDecimal NOT IN ('0')
  BEGIN
    SET @PosicionInicial = CHARINDEX('.',@TextoDecimal) + 1
    SET @LongitudDecimal = LEN(@TextoDecimal) - 2
    SET @TextoDecimal = SUBSTRING(@TextoDecimal,@PosicionInicial,@LongitudDecimal)
  END  
  SET @TextoEntero = REPLICATE('0',10-LEN(@TextoEntero)) + @TextoEntero 
  SET @TextoDecimal = SUBSTRING(@TextoDecimal,1,6)
  SET @TextoDecimal = @TextoDecimal + REPLICATE('0',6-LEN(@TextoDecimal))
  SET @Resultado = RTRIM(@TextoEntero) + '.' + RTRIM(@TextoDecimal)
  RETURN (@Resultado)
END
GO

/**************** spCFDIRetencionQRCode ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionQRCode') and type = 'P') drop procedure dbo.spCFDIRetencionQRCode
GO
CREATE PROC spCFDIRetencionQRCode
			@Estacion			int,
			@Proveedor			varchar(10), 
			@ConceptoSAT		varchar(2), 
			@Empresa			varchar(5),
			@Sucursal			int,
			@Version			varchar(5),
			@XML				varchar(max),
			@Usuario			varchar(10),
			@ArchivoQRCode		varchar(255),
			@RFCEmisor			varchar(30),
		    @RFCReceptor		varchar(30),
		    @montoTotExent		float,
		    @montoTotGrav		float,
		    @montoTotOperacion	float,
		    @montoTotRet		float,
		    @UUID				varchar(50),
			@Ok					int			OUTPUT,
			@OkRef				varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Cadena				varchar(max),
		  @Shell				varchar(8000),
		  @RutaGenerarQRCode	varchar(max),
		  @UsarTimbrarRetencion	bit

  SELECT @UsarTimbrarRetencion = UsarTimbrarRetencion FROM EmpresaCFD WHERE Empresa = @Empresa
  
  IF @UsarTimbrarRetencion = 0
    SELECT @RutaGenerarQRCode = RTRIM(LTRIM(ISNULL(RutaGenerarQRCode,'')))
      FROM EmpresaCFD
     WHERE Empresa = @Empresa
  ELSE
    SELECT @RutaGenerarQRCode = RTRIM(LTRIM(ISNULL(RutaGenerarQRCode,'')))
      FROM EmpresaCFDRetencion
     WHERE Empresa = @Empresa
   
  SELECT @Cadena = '?re='+ISNULL(@RFCEmisor,'')+'&rr='+ISNULL(@RFCReceptor,'')+'&tt='+dbo.fnCFDFlexFormatearImporte(@montoTotRet,10,6)+'&id='+@UUID

  SELECT @Shell = CHAR(34) + CHAR(34) + @RutaGenerarQRCode + CHAR(34) + ' ' + CHAR(34) + @ArchivoQRCode + CHAR(34) + ' ' + CHAR(34) + @Cadena + CHAR(34) + CHAR(34)

  EXEC xp_cmdshell @Shell, no_output
  
  RETURN
END
GO

/**************** spCFDIRetencionActualizarMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionActualizarMov') and type = 'P') drop procedure dbo.spCFDIRetencionActualizarMov
GO
CREATE PROC spCFDIRetencionActualizarMov
			@Accion					varchar(20),
			@Estacion				int,
			@ID						int,
			@Proveedor				varchar(10), 
			@Empresa				varchar(5), 
			@Version				varchar(5), 
			@ConceptoSAT			varchar(50), 
			@RIDAnt                 varchar(20),
			@UUID					varchar(50), 
			@Ok						int				OUTPUT, 
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN  
  DECLARE @ModuloPago		varchar(5),
		  @ModuloPagoAnt	varchar(5),
		  @IDPago			int,
		  @IDPagoAnt		int,
		  @Modulo			varchar(5),
		  @ModuloAnt		varchar(5),
		  @ModuloID			int,
		  @ModuloIDAnt		int

  IF NULLIF(RTRIM(@UUID), '') IS NOT NULL
  BEGIN
    IF @Accion = 'AFECTAR'
      UPDATE Cxp SET CFDRetencionTimbrado = 1 WHERE ID = @ID
    ELSE IF @Accion = 'CANCELAR'
      UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @ID

    SELECT @ModuloPagoAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @ModuloPago = MIN(ModuloPago)
        FROM CFDIRetencionD
       WHERE EstacionTrabajo = @Estacion
         AND Proveedor = @Proveedor
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa
         AND ModuloPago > @ModuloPagoAnt
      
      IF @ModuloPago IS NULL BREAK
      
      SELECT @ModuloPagoAnt = @ModuloPago
  
      SELECT @IDPagoAnt = 0
      WHILE(1=1)
      BEGIN
        
		IF ((SELECT ISNULL(AgruparConceptoSATRetenciones,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1)
		SELECT @IDPago = MIN(IDPago)
          FROM CFDIRetencionD
         WHERE EstacionTrabajo = @Estacion
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT
           AND Empresa = @Empresa
           AND ModuloPago = @ModuloPago
		   and MovID = @RIDAnt
           AND IDPago > @IDPagoAnt
		ELSE
		SELECT @IDPago = MIN(IDPago)
          FROM CFDIRetencionD
         WHERE EstacionTrabajo = @Estacion
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT
           AND Empresa = @Empresa
           AND ModuloPago = @ModuloPago
           AND IDPago > @IDPagoAnt

        

        IF @IDPago IS NULL BREAK
      
        SELECT @IDPagoAnt = @IDPago

        IF @Accion = 'AFECTAR'
        BEGIN
          IF @ModuloPago = 'CXP'
            UPDATE Cxp SET CFDRetencionTimbrado = 1 WHERE ID = @IDPago
          ELSE IF @ModuloPago = 'GAS'
            UPDATE Gasto SET CFDRetencionTimbrado = 1 WHERE ID = @IDPago
          ELSE IF @ModuloPago = 'DIN'
            UPDATE Dinero SET CFDRetencionTimbrado = 1 WHERE ID = @IDPago            
        END
        ELSE IF @Accion = 'CANCELAR'
        BEGIN
          IF @ModuloPago = 'CXP'
            UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago
          ELSE IF @ModuloPago = 'GAS'
            UPDATE Gasto SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago 
			
          ELSE IF @ModuloPago = 'DIN'
            UPDATE Dinero SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago
        END
        SELECT @ModuloAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @Modulo = MIN(Modulo)
            FROM CFDIRetencionD
           WHERE EstacionTrabajo = @Estacion
             AND Proveedor = @Proveedor
             AND ConceptoSAT = @ConceptoSAT
             AND Empresa = @Empresa
             AND ModuloPago = @ModuloPago
             AND IDPago = @IDPago
             AND Modulo > @ModuloAnt

          IF @Modulo IS NULL BREAK
      
          SELECT @ModuloAnt = @Modulo

          SELECT @ModuloIDAnt = 0
          WHILE(1=1)
          BEGIN
            SELECT @ModuloID = MIN(ModuloID)
              FROM CFDIRetencionD
             WHERE EstacionTrabajo = @Estacion
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT
               AND Empresa = @Empresa
               AND ModuloPago = @ModuloPago
               AND IDPago = @IDPago
               AND Modulo = @Modulo
               AND ModuloID > @ModuloIDAnt

            IF @ModuloID IS NULL BREAK
      
            SELECT @ModuloIDAnt = @ModuloID

            IF @Accion = 'AFECTAR'
            BEGIN
              IF @Modulo = 'CXP'
                UPDATE Cxp SET CFDRetencionTimbrado = 1 WHERE ID = @ModuloID
              ELSE IF @Modulo = 'GAS'
			  BEGIN
                UPDATE Gasto SET CFDRetencionTimbrado = 1 WHERE ID = @ModuloID
				UPDATE GastoD SET Timbrado = 0 WHERE ID = @ModuloID AND Timbrado <> 1
				UPDATE GastoD SET Timbrado = 1 WHERE ID = @ModuloID and Concepto in (select Concepto from CFDIRetencionConcepto Where Modulo = 'GAS' and CFDIRetClave = @ConceptoSAT)
			  END
			  ELSE IF @Modulo = 'COMS'
                UPDATE Compra SET CFDRetencionTimbrado = 1 WHERE ID = @ModuloID
            END
            ELSE IF @Accion = 'CANCELAR'
            BEGIN
              IF @Modulo = 'CXP'
                UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
              ELSE IF @Modulo = 'GAS'
                UPDATE Gasto SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
              ELSE IF @Modulo = 'COMS'
                UPDATE Compra SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
            END            
          END          
        END

		IF @Accion = 'AFECTAR'
		   Begin
		   Declare  @vMovID varchar(20),@vID int,@conteo int
		   SELECT @vMovID = MovID FROM CFDIRetencionD WHERE IDPago = @IDPago and ConceptoSAT = @ConceptoSAT
		   SELECT @vID = ID FROM Gasto WHERE MovID = @vMovID
		   SELECT @conteo = COUNT(ID) FROM GastoD WHERE ID = @vID  and timbrado <> 1
		   IF @conteo > 0
		     BEGIN
			    IF @ModuloPago = 'CXP'
                   UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago
                ELSE IF @ModuloPago = 'GAS'
                   UPDATE Gasto SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago
                ELSE IF @ModuloPago = 'DIN'
                   UPDATE Dinero SET CFDRetencionTimbrado = 0 WHERE ID = @IDPago  
			 END
		   END
      END
    END
  END
  RETURN
END
GO

/**************** spCFDIRetencionAnexoMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionAnexoMov') and type = 'P') drop procedure dbo.spCFDIRetencionAnexoMov
GO
CREATE PROC spCFDIRetencionAnexoMov
			@Estacion				int,
			@ID						int, 
			@Proveedor				varchar(10), 
			@Empresa				varchar(5), 
			@Version				varchar(5), 
			@ConceptoSAT			varchar(50), 
			@RIDAnt                 varchar(20), 
			@UUID					varchar(50), 
			@Ruta					varchar(255), 
			@ArchivoQRCode			varchar(255), 
			@ArchivoXML				varchar(255), 
			@ArchivoPDF				varchar(255), 
			@EsPDF					bit,			
			@Ok						int				OUTPUT, 
			@OkRef					varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN  
  DECLARE @NomArchivoQRCode	varchar(255), 
		  @NomArchivoXML	varchar(255), 
		  @NomArchivoPDF	varchar(255),
		  @ModuloPago		varchar(5),
		  @ModuloPagoAnt	varchar(5),
		  @IDPago			int,
		  @IDPagoAnt		int,
		  @ModuloAux		varchar(5),
		  @ModuloAuxAnt		varchar(5),
		  @ModuloID			int,
		  @ModuloIDAnt		int,
		  @Sucursal			int


  SELECT @Ruta = @Ruta + '\'

  SELECT @NomArchivoQRCode = REPLACE(@ArchivoQRCode, @Ruta, ''),
		 @NomArchivoXML	   = REPLACE(@ArchivoXML, @Ruta, ''),
		 @NomArchivoPDF	   = REPLACE(@ArchivoPDF, @Ruta, '')
		 
  IF NULLIF(RTRIM(@UUID), '') IS NOT NULL
  BEGIN
    SELECT @Sucursal = Sucursal FROM Cxp WHERE ID = @ID
    
    IF @EsPDF = 1
      IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'CXP' AND ID = @ID AND CFD = 1 AND Nombre = @NomArchivoPDF)
        INSERT AnexoMov (Sucursal,  Rama,  ID,  Nombre,         Direccion,  Tipo,      Icono, CFD) 
                VALUES (@Sucursal, 'CXP', @ID, @NomArchivoPDF, @ArchivoPDF, 'Archivo', 745,   1)
  
    IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'CXP' AND ID = @ModuloID AND CFD = 1 AND Nombre = @NomArchivoXML)
      INSERT AnexoMov (Sucursal,  Rama,  ID,  Nombre,         Direccion,  Tipo,      Icono, CFD) 
              VALUES (@Sucursal, 'CXP', @ID, @NomArchivoXML, @ArchivoXML, 'Archivo', 17,    1)

			             
    SELECT @ModuloPagoAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @ModuloPago = MIN(ModuloPago)
        FROM CFDIRetencionD
       WHERE EstacionTrabajo = @Estacion
         AND Proveedor = @Proveedor
         AND ConceptoSAT = @ConceptoSAT
         AND Empresa = @Empresa
         AND ModuloPago > @ModuloPagoAnt
      
      IF @ModuloPago IS NULL BREAK
      
      SELECT @ModuloPagoAnt = @ModuloPago

      SELECT @IDPagoAnt = 0
      WHILE(1=1)
      BEGIN
	    IF(SELECT ISNULL(AgruparConceptoSATRetenciones,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
	        SELECT @IDPago = MIN(IDPago)
			  FROM CFDIRetencionD
			 WHERE EstacionTrabajo = @Estacion
			   AND Proveedor = @Proveedor
			   AND ConceptoSAT = @ConceptoSAT
			   AND Empresa = @Empresa
			   AND ModuloPago = @ModuloPago
			   AND MovID = @RIDAnt
			   AND IDPago > @IDPagoAnt
        ELSE
	        SELECT @IDPago = MIN(IDPago)
			  FROM CFDIRetencionD
			 WHERE EstacionTrabajo = @Estacion
			   AND Proveedor = @Proveedor
			   AND ConceptoSAT = @ConceptoSAT
			   AND Empresa = @Empresa
			   AND ModuloPago = @ModuloPago
			   AND IDPago > @IDPagoAnt

        IF @IDPago IS NULL BREAK
      
        SELECT @IDPagoAnt = @IDPago
        
        SELECT @Sucursal = Sucursal 
          FROM CFDIRetencionD
         WHERE EstacionTrabajo = @Estacion
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT
           AND Empresa = @Empresa
           AND ModuloPago = @ModuloPago
           AND IDPago = @IDPago

        IF @EsPDF = 1
          IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @ModuloPago AND ID = @IDPago AND CFD = 1 AND Nombre = @NomArchivoPDF)
            INSERT AnexoMov (Sucursal,  Rama,        ID,      Nombre,         Direccion,  Tipo,      Icono, CFD) 
                    VALUES (@Sucursal, @ModuloPago, @IDPago, @NomArchivoPDF, @ArchivoPDF, 'Archivo', 745,   1)
  
        IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @ModuloPago AND ID = @IDPago AND CFD = 1 AND Nombre = @NomArchivoXML)
          INSERT AnexoMov (Sucursal,  Rama,        ID,      Nombre,         Direccion,  Tipo,      Icono, CFD) 
                  VALUES (@Sucursal, @ModuloPago, @IDPago, @NomArchivoXML, @ArchivoXML, 'Archivo', 17,    1)

        SELECT @ModuloAuxAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @ModuloAux = MIN(Modulo)
            FROM CFDIRetencionD
           WHERE EstacionTrabajo = @Estacion
             AND Proveedor = @Proveedor
             AND ConceptoSAT = @ConceptoSAT
             AND Empresa = @Empresa
             AND ModuloPago = @ModuloPago
             AND IDPago = @IDPago
             AND Modulo > @ModuloAuxAnt
        
          IF @ModuloAux IS NULL BREAK
        
          SELECT @ModuloAuxAnt = @ModuloAux
        
          SELECT @ModuloIDAnt = 0
          WHILE(1=1)
          BEGIN
            SELECT @ModuloID = MIN(ModuloID)
              FROM CFDIRetencionD
             WHERE EstacionTrabajo = @Estacion
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT
               AND Empresa = @Empresa
               AND ModuloPago = @ModuloPago
               AND IDPago = @IDPago
               AND Modulo = @ModuloAux
               AND ModuloID > @ModuloIDAnt
        
            IF @ModuloID IS NULL BREAK
        
            SELECT @ModuloIDAnt = @ModuloID
          
            SELECT @Sucursal = Sucursal 
              FROM CFDIRetencionD
             WHERE EstacionTrabajo = @Estacion
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT
               AND Empresa = @Empresa
               AND ModuloPago = @ModuloPago
               AND IDPago = @IDPago
               AND Modulo = @ModuloAux
               AND ModuloID = @ModuloID
      
            IF @EsPDF = 1
              IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @ModuloAux AND ID = @ModuloID AND CFD = 1 AND Nombre = @NomArchivoPDF)
                INSERT AnexoMov (Sucursal,  Rama,       ID,        Nombre,         Direccion,  Tipo,      Icono, CFD) 
                        VALUES (@Sucursal, @ModuloAux, @ModuloID, @NomArchivoPDF, @ArchivoPDF, 'Archivo', 745,   1)
  
            IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @ModuloAux AND ID = @ModuloID AND CFD = 1 AND Nombre = @NomArchivoXML)
              INSERT AnexoMov (Sucursal,  Rama,       ID,        Nombre,         Direccion,  Tipo,      Icono, CFD) 
                      VALUES (@Sucursal, @ModuloAux, @ModuloID, @NomArchivoXML, @ArchivoXML, 'Archivo', 17,    1)
          END
        END
      END
    END
  END
  RETURN
END
GO

/**************** spCFDIRetencionAnexoPDF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionAnexoPDF') and type = 'P') drop procedure dbo.spCFDIRetencionAnexoPDF
GO
CREATE PROC spCFDIRetencionAnexoPDF
			@Empresa		varchar(5),
			@Usuario		varchar(10),
			@ID				int,
			@ArchivoPDF		varchar(255),
			@Estacion		int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Proveedor		varchar(10),
		  @ConceptoSAT		varchar(2),
		  @Version			varchar(5),
		  @AlmacenarXML		bit, 
		  @AlmacenarPDF		bit,
		  @NomArch			varchar(255),
		  @Reporte			varchar(100),
		  @Ruta				varchar(255),
		  @EnviarPara		varchar(255),
		  @EnviarAsunto		varchar(255),
		  @EnviarMensaje	varchar(255),
		  @Enviar			bit,
		  @EnviarXML		bit,
		  @EnviarPDF		bit,
		  @UUID				varchar(50),
		  @Ok				int,
		  @OkRef			varchar(255),
		  @ModuloAnt		varchar(5),
		  @Modulo			varchar(5),
		  @ModuloIDAnt		int,
		  @ModuloID			int,
		  @Sucursal			int,
		  --BUG1560
		  @Ejerc				int, 
		  @MesIni			int, 
		  @MesFin			int

  DELETE FROM ListaID WHERE ID = @ID AND Estacion =@Estacion 
  
  --BUG1560
  SELECT @Proveedor = Proveedor, @ConceptoSAT = ConceptoSAT, @UUID = UUID, @Ejerc = Ejercicio, @MesIni = Periodo, @MesFin = Periodo FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID
  
  SELECT @Sucursal = Sucursal FROM Cxp WHERE ID = @ID
  
  SELECT @Version = Version FROM CFDIRetencionCfg
  
  EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, 
                                --BUG1560
                                @Ejerc, @MesIni, @MesFin, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, 
								@NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, @EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, 
								@Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0

  EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT

  SELECT @NomArch = REPLACE(REPLACE(@ArchivoPDF, @Ruta, ''), '\', '')

  IF @Ok IS NULL
  BEGIN
    SELECT @ModuloAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Modulo = MIN(Modulo) 
        FROM CFDRetencion 
       WHERE UUID = @UUID
         AND Modulo > @ModuloAnt
    
      IF @Modulo IS NULL BREAK
      
      SELECT @ModuloAnt = @Modulo

      SELECT @ModuloIDAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @ModuloID = MIN(ModuloID) 
          FROM CFDRetencion 
         WHERE UUID = @UUID
           AND Modulo = @Modulo
           AND ModuloID > @ModuloIDAnt
    
        IF @ModuloID IS NULL BREAK
        
        SELECT @ModuloIDAnt = @ModuloID
    
        IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ModuloID AND CFD = 1 AND Nombre = @NomArch)
          INSERT AnexoMov (Sucursal,  Rama,    ID,        Nombre,   Direccion,  Tipo,      Icono, CFD) 
                  VALUES (@Sucursal, @Modulo, @ModuloID, @NomArch, @ArchivoPDF, 'Archivo', 745,    1)
                                  
      END
    END
  END
  SELECT 'Proceso Concluido'
  RETURN
END
GO

/**************** spCFDIRetencionBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionBorrar') and type = 'P') drop procedure dbo.spCFDIRetencionBorrar
GO
CREATE PROC spCFDIRetencionBorrar
			@Estacion			int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE CFDIRetencion         WHERE EstacionTrabajo = @Estacion
  DELETE CFDIRetencionCalcTmp  WHERE EstacionTrabajo = @Estacion  
  DELETE CFDIRetencionD        WHERE EstacionTrabajo = @Estacion
  
  RETURN
END
GO

/**************** spCFDIRetencionBorrarMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionBorrarMov') and type = 'P') drop procedure dbo.spCFDIRetencionBorrarMov
GO
CREATE PROC spCFDIRetencionBorrarMov
			@Estacion		int,
			@Modulo			varchar(5),
			@ModuloID		int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE CFDIRetencion        WHERE EstacionTrabajo = @Estacion AND Modulo = @Modulo AND ModuloID = @ModuloID
  DELETE CFDIRetencionCalcTmp WHERE EstacionTrabajo = @Estacion AND Modulo = @Modulo AND ModuloID = @ModuloID  
  DELETE CFDIRetencionD       WHERE EstacionTrabajo = @Estacion AND Modulo = @Modulo AND ModuloID = @ModuloID

  DELETE ListaModuloID WHERE Estacion = @Estacion AND Modulo = @Modulo AND ID = @ModuloID
  RETURN
END
GO

/**************** spCFDIRetencionDBorrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionDBorrar') and type = 'P') drop procedure dbo.spCFDIRetencionDBorrar
GO
CREATE PROC spCFDIRetencionDBorrar
			@Estacion		int,
			@RID			int
--//WITH ENCRYPTION
AS
BEGIN
  DELETE CFDIRetencionD WHERE EstacionTrabajo = @Estacion AND RID = @RID

  DELETE ListaID WHERE Estacion = @Estacion AND ID = @RID
  RETURN
END
GO

/**************** spCFDIRetencionXMLRegenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionXMLRegenerar') and type = 'P') drop procedure dbo.spCFDIRetencionXMLRegenerar
GO
CREATE PROC spCFDIRetencionXMLRegenerar
			@Estacion		int,
			@Empresa		varchar(5),
			@Usuario		varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @ID				int,
		  @IDAnt			int,
		  @UUID				varchar(50),
		  @Documento		varchar(max),
		  @Proveedor		varchar(10),
		  @Sucursal			int,
		  @ConceptoSAT		varchar(5),
		  @Version			varchar(5),
		  @Modulo			varchar(5),
		  @ModuloAnt		varchar(5),
		  @ModuloID			int,
		  @ModuloIDAnt		int,
		  
		  @AlmacenarXML		bit,
		  @AlmacenarPDF		bit,    
		  @Archivo			varchar(255),
		  @Reporte			varchar(100),
		  @Ruta				varchar(255),
		  @Para				varchar(255),
		  @Asunto			varchar(max),
		  @Mensaje			varchar(max),
		  @Enviar			bit,
		  @EnviarXML		bit,
		  @EnviarPDF		bit,
		  @ArchivoXML		varchar(255),
		  @NombreArchivo	varchar(255),
		  
		  @Ok				int,
		  @OkRef			varchar(255),
		  --BUG1560
		  @Ejerc			int, 
		  @MesIni			int, 
		  @MesFin			int

  SELECT @Version = Version FROM CFDIRetencionCfg

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM ListaID
     WHERE Estacion = @Estacion
       AND ID > @IDAnt

    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @UUID = NULL, @Documento = NULL, @Proveedor = NULL, @ConceptoSAT = NULL, @AlmacenarXML = NULL, @AlmacenarPDF = NULL, @Archivo = NULL, @Reporte = NULL, @Ruta = NULL, @Para = NULL, @Asunto = NULL, @Mensaje = NULL, @Enviar = NULL, @EnviarXML = NULL, @EnviarPDF = NULL, @ArchivoXML = NULL, @Sucursal = NULL, @NombreArchivo = NULL

    --BUG1560    
    SELECT @UUID = UUID, @Documento = Documento, @Proveedor = Proveedor, @ConceptoSAT = ConceptoSAT, @Ejerc = Ejercicio, @MesIni = Periodo, @MesFin = Periodo FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID
    
    SELECT @Sucursal = Sucursal FROM Cxp WHERE ID = @ID

    EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, 
    			                  --BUG1560
								  @Ejerc, @MesIni, @MesFin, 
								  @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @Archivo OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0

    SELECT @ArchivoXML = @Ruta + '\' + @Archivo + '.xml'
  
    EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
  
    IF @Ok IS NULL
      EXEC spRegenerarArchivo @ArchivoXML, @Documento, @Ok OUTPUT, @OkRef OUTPUT

    SELECT @NombreArchivo = REPLACE(REPLACE(@ArchivoXML, @Ruta, ''), '\', '')

    IF @Ok IS NULL
    BEGIN
      SELECT @ModuloAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Modulo = MIN(Modulo) 
          FROM CFDRetencion 
         WHERE UUID = @UUID
           AND Modulo > @ModuloAnt
    
        IF @Modulo IS NULL BREAK
      
        SELECT @ModuloAnt = @Modulo

        SELECT @ModuloIDAnt = 0
        WHILE(1=1)
        BEGIN
          SELECT @ModuloID = MIN(ModuloID) 
            FROM CFDRetencion 
           WHERE UUID = @UUID
             AND Modulo = @Modulo
             AND ModuloID > @ModuloIDAnt
    
          IF @ModuloID IS NULL BREAK
        
          SELECT @ModuloIDAnt = @ModuloID
    
          IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ModuloID AND CFD = 1 AND Nombre = @NombreArchivo)
            INSERT AnexoMov (Sucursal,  Rama,    ID,        Nombre,         Direccion,  Tipo,      Icono, CFD) 
                    VALUES (@Sucursal, @Modulo, @ModuloID, @NombreArchivo, @ArchivoXML, 'Archivo', 17,    1)
                       
        END      
      END
    END
  END
  
  SELECT 'Proceso Concluido'
  RETURN
END
GO

/*************** spCFDIRetencionCancelarTimbre *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionCancelarTimbre') and type = 'P') drop procedure dbo.spCFDIRetencionCancelarTimbre
GO
CREATE PROC spCFDIRetencionCancelarTimbre
			@Modulo						varchar(5),
			@ID							int,
			@Proveedor					varchar(10),
			@ConceptoSAT				varchar(5),
			@Estatus					varchar(20), 
			@Empresa					varchar(10),
			@Sucursal					int,
			@FirmaCancelacionSAT		varchar(max)	OUTPUT,
			@DatosXMl					varchar(max)	OUTPUT,
			@AlmacenarRuta				varchar(200)	OUTPUT,
			@Archivo					varchar(255)	OUTPUT,
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Fechatimbrado			varchar(20),
		  @ServidorPAC				varchar(100),
		  @UsuarioPAC				varchar(100),
		  @PaswordPAC				varchar(100),
		  @AccionCFDI				varchar(50),
		  @RutaCer					varchar(200),
		  @RutaKey					varchar(200),
		  @passKey					varchar(100),
		  @UUID						varchar(50),
		  @RFC						varchar(20),
		  @Documento				varchar(max),
		  @RutaIntelisisCFDI		varchar(255),
		  @CadenaConexion			varchar(max),
		  @PswPFX					varchar(30),
		  @RenglonDatos				varchar(255),
		  @Error					bit,
		  @xml						xml,
		  @RID						int,
		  @iDatos					int,
		  @DocumentoXML				xml,
		  @PrefijoCFDI				varchar(255),
		  @Shell					varchar(8000),
		  @r						varchar(max),
		  
		  @FechaCancelacionSAT		varchar(30),

		  @Mov						varchar(20),
		  @Usuario					varchar(10),
		  @Adicional				bit,
		  @AlmacenarXML				bit,
		  @AlmacenarPDF				bit,    
		  @EnviarXML				bit,
		  @EnviarPDF				bit,
		  @NomArch					varchar(255),
		  @Ruta						varchar(255),
		  @PDFExiste				int,
		  @ArchivoPDF				varchar(255),
		  @Enviar					bit,
		  @EnviarPara				varchar(255),
		  @EnviarAsunto				varchar(255),
		  @EnviarMensaje			varchar(255),		  
		  @Reporte					varchar(100),
		  @Contacto					varchar(10),
		  @eMail					varchar(255),
		  @Para						varchar(255),
		  @Asunto					varchar(max),
		  @Mensaje					varchar(max),
		  @Cancelacion				bit,
		  @TimeOutTimbrado			int,
		  @MensajeSF				varchar(max), 
		  @Dato1					varchar(max),
		  @SelloCancelacionSAT		varchar(max),
		  @EstatusCancelacion		varchar(10),
		  @ModoPruebas				bit,
		  
		  @NoTimbrado				int,
		  @Version					varchar(5),
		  
		  --BUG1142
		  @UsarTimbrarRetencion		bit,
		  --BUG1560
		  @Ejerc					int, 
		  @MesIni					int, 
		  @MesFin					int,
		  @CFDflex					bit,
		  @EsRetencion				bit

  SELECT @Version = Version FROM CFDIRetencionCfg

  SELECT @Fechatimbrado = CONVERT(varchar(30),FechaTimbrado,127), 
		 @UUID = CONVERT(varchar(50), UUID), 
		 @Documento = Documento, 
		 @SelloCancelacionSAT = SelloCancelacionSAT,
		 @Ejerc = Ejercicio, 
		 @MesIni = Periodo,
		 @MesFin = Periodo
    FROM CFDRetencion
   WHERE Modulo = @Modulo
     AND ModuloID = @ID 
     AND Proveedor = @Proveedor
     AND ConceptoSAT = @ConceptoSAT


  
  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  
  SELECT @UsarTimbrarRetencion= UsarTimbrarRetencion FROM EmpresaCFD WHERE Empresa = @Empresa
    --25788
  SELECT @CFDflex=CFDFlex FROM  EmpresaGral WHERE Empresa = @Empresa
  --BUG1142
  IF @UsarTimbrarRetencion =0
    SELECT @RutaIntelisisCFDI = RutaIntelisisCFDI, 
           @ServidorPAC = TimbrarCFDIServidor, 
           @UsuarioPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIUsuario ELSE TimbrarCFDIUsuario END, 
           @PaswordPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIPassword ELSE TimbrarCFDIPassword END, 
           @RutaCer = RutaCertificado, 
           @RutaKey = Llave, 
           @passKey = CASE WHEN @CFDflex=1 THEN ContrasenaSello ELSE ContrasenakeyCSD END, 
           @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado),
		   @ModoPruebas = ISNULL(ModoPruebas, 0)
      FROM EmpresaCFD WHERE Empresa = @Empresa
  ELSE 
    SELECT @RutaIntelisisCFDI = RutaIntelisisCFDI, 
           @ServidorPAC = TimbrarCFDIServidor, 
           @UsuarioPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIUsuario ELSE TimbrarCFDIUsuario END, 
           @PaswordPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIPassword ELSE TimbrarCFDIPassword END, 
           @RutaCer = Certificado, 
           @RutaKey = Llave, 
           @passKey = ContrasenaLlave, 
           @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado),
		   @ModoPruebas = ISNULL(ModoPruebas, 0)
      FROM EmpresaCFDRetencion WHERE Empresa = @Empresa
    
	

  IF @SelloCancelacionSAT IS NOT NULL
    SELECT @Ok = 71680, @OkRef = 'El Movimiento Ya Tiene Sello de Cancelacion CFDI'
	 
  SELECT @AccionCFDI = 'CANCELAR', @PswPFX = 'Intelisis1234567', @Cancelacion = 1

  EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, 
  			                    --BUG1560
  			                    @Ejerc, @MesIni, @MesFin, 
                                @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, 
							    @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, @EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, 
								@Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 1

  EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT

 
  
  SELECT @AlmacenarRuta =   @Ruta + '\' + @NomArch +'.xml'
  SELECT @EsRetencion=1 

  EXEC spIntelisisCFDICancelar @Modulo, @ID, @Estatus, @Empresa, @Sucursal, @RutaIntelisisCFDI, @Fechatimbrado, @ServidorPAC, @UsuarioPAC, 
							   @PaswordPAC, @AccionCFDI, @RutaCer, @RutaKey, @passKey, @UUID, @RFC, @Documento, 
							   @ModoPruebas, @AlmacenarRuta,@EsRetencion, @FirmaCancelacionSAT = @FirmaCancelacionSAT OUTPUT, @DatosXMl = @DatosXMl OUTPUT,
							   @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  RETURN 
END
GO

/*************** spCFDIRetencionCancelar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionCancelar') and type = 'P') drop procedure dbo.spCFDIRetencionCancelar
GO
CREATE PROC spCFDIRetencionCancelar
			@ID					int,
			--BUG1148
			@EstacionTrabajo	int
			--EXEC spCFDIRetencionCancelar 3486, 2
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Estatus				varchar(20), 
		  @Empresa				varchar(10),
		  @Sucursal				int,
		  @Ok					int,
		  @OkRef				varchar(255),
		  @FirmaCancelacionSAT	varchar(max),
		  @DatosXMl				varchar(max),
		  @AlmacenarRuta		varchar(200),
		  @Archivo				varchar(255),
		  @FechaCancelacion		datetime,
		  @Ruta					varchar(255),
		  @NombreArchivo		varchar(255),
		  @NoTimbrado			int,
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @Proveedor			varchar(10),
		  @ConceptoSAT			varchar(5),
		  @UUID					varchar(50),
		  
		  @Modulo				varchar(5),
		  @ModuloAnt			varchar(5),
		  @ModuloID				int,
		  @ModuloIDAnt			int,

		  @OkDesc           	varchar(255),
		  @OkTipo           	varchar(50)

  --BUG1148
  DELETE FROM ListaID WHERE ID = @ID AND Estacion = @EstacionTrabajo
    
  BEGIN TRAN
  
  SELECT @FechaCancelacion = GETDATE()

  SELECT @Estatus = Estatus, @Empresa = Empresa, @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID, @Proveedor = Proveedor FROM Cxp WHERE ID = @ID 

  SELECT @ConceptoSAT = ConceptoSAT, @UUID = UUID FROM CFDRetencion WHERE Modulo = 'CXP' AND ModuloID = @ID 
  
  
  EXEC spCFDIRetencionCancelarTimbre 'CXP', @ID, @Proveedor, @ConceptoSAT, @Estatus, @Empresa, @Sucursal, @FirmaCancelacionSAT OUTPUT, @DatosXML OUTPUT, @AlmacenarRuta OUTPUT, @Archivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  SELECT @Ruta = dbo.fnCFDINominaObtenerRuta(@AlmacenarRuta)+ '\'
  SELECT @NombreArchivo = REPLACE(@AlmacenarRuta, @Ruta, '')


  IF @Ok IS NULL
  BEGIN
    EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NULL
      EXEC spRegenerarArchivo @AlmacenarRuta, @DatosXML, @Ok OUTPUT, @OkRef OUTPUT
 
    IF @Ok IS NULL
    BEGIN
      DELETE CFDIRetencionProvPeriodo WHERE ID = @ID
      
      UPDATE CFDRetencion
         SET Cancelado		= 1, 
             AcuseCancelado	= @DatosXml, 
             RutaAcuse		= @AlmacenarRuta, 
             SelloCancelacionSAT = @FirmaCancelacionSAT 
       WHERE Modulo = 'CXP'
         AND ModuloID = @ID
         AND Proveedor = @Proveedor
         AND ConceptoSAT = @ConceptoSAT

      INSERT INTO CFDRetencionCancelado(
			   Modulo, ModuloID, Proveedor, ConceptoSAT, Fecha, Ejercicio, Periodo, Empresa, Mov, MovID, Serie, Folio, RFCEmisor, RFCReceptor, Aprobacion, Importe, Impuesto1, Impuesto2, Retencion1, Retencion2, noCertificado, Sello, CadenaOriginal, Documento, GenerarPDF, Timbrado, UUID, FechaTimbrado, Moneda, TipoCambio, EsPago, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Cancelado, AcuseCancelado, RutaAcuse, montoTotExent, montoTotGrav, montoTotOperacion, montoTotRet,  FechaCancelacion)
		SELECT Modulo, ModuloID, Proveedor, ConceptoSAT, Fecha, Ejercicio, Periodo, Empresa, Mov, MovID, Serie, Folio, RFCEmisor, RFCReceptor, Aprobacion, Importe, Impuesto1, Impuesto2, Retencion1, Retencion2, noCertificado, Sello, CadenaOriginal, Documento, GenerarPDF, Timbrado, UUID, FechaTimbrado, Moneda, TipoCambio, EsPago, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Cancelado, AcuseCancelado, RutaAcuse, montoTotExent, montoTotGrav, montoTotOperacion, montoTotRet, @FechaCancelacion
  	      FROM CFDRetencion 
         WHERE Modulo = 'CXP'
           AND ModuloID = @ID 
           AND Proveedor = @Proveedor
           AND ConceptoSAT = @ConceptoSAT

      DELETE CFDRetencion
       WHERE Modulo = 'CXP'
         AND ModuloID = @ID
         AND Proveedor = @Proveedor
         AND ConceptoSAT = @ConceptoSAT

      UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @ID
      
      IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'CXP' AND ID = @ID AND CFD = 1 AND Direccion = @AlmacenarRuta)
        INSERT AnexoMov ( Sucursal, Rama,   ID,  Nombre,         Direccion,     Tipo,      Icono, CFD) 
                 VALUES (@Sucursal, 'CXP', @ID, @NombreArchivo, @AlmacenarRuta, 'Archivo', 17,   1)
                         
      SELECT @ModuloAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Modulo = MIN(Modulo) 
          FROM CFDRetencion 
         WHERE UUID = @UUID
           AND Modulo > @ModuloAnt

        IF @Modulo IS NULL BREAK
      
        SELECT @ModuloAnt = @Modulo

        SELECT @ModuloIDAnt = 0
        WHILE(1=1)
        BEGIN
          SELECT @ModuloID = MIN(ModuloID) 
            FROM CFDRetencion 
           WHERE UUID = @UUID
             AND Modulo = @Modulo
             AND ModuloID > @ModuloIDAnt
    
          IF @ModuloID IS NULL BREAK
        
          SELECT @ModuloIDAnt = @ModuloID

          UPDATE CFDRetencion
             SET Cancelado		= 1, 
                 AcuseCancelado	= @DatosXml, 
                 RutaAcuse		= @AlmacenarRuta, 
                 SelloCancelacionSAT = @FirmaCancelacionSAT 
           WHERE Modulo = @Modulo
             AND ModuloID = @ModuloID
             AND Proveedor = @Proveedor
             AND ConceptoSAT = @ConceptoSAT
 
          INSERT INTO CFDRetencionCancelado(
			       Modulo, ModuloID, Proveedor, ConceptoSAT, Fecha, Ejercicio, Periodo, Empresa, Mov, MovID, Serie, Folio, RFCEmisor, RFCReceptor, Aprobacion, Importe, Impuesto1, Impuesto2, Retencion1, Retencion2, noCertificado, Sello, CadenaOriginal, Documento, GenerarPDF, Timbrado, UUID, FechaTimbrado, Moneda, TipoCambio, EsPago, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Cancelado, AcuseCancelado, RutaAcuse, montoTotExent, montoTotGrav, montoTotOperacion, montoTotRet,  FechaCancelacion)
		    SELECT Modulo, ModuloID, Proveedor, ConceptoSAT, Fecha, Ejercicio, Periodo, Empresa, Mov, MovID, Serie, Folio, RFCEmisor, RFCReceptor, Aprobacion, Importe, Impuesto1, Impuesto2, Retencion1, Retencion2, noCertificado, Sello, CadenaOriginal, Documento, GenerarPDF, Timbrado, UUID, FechaTimbrado, Moneda, TipoCambio, EsPago, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Cancelado, AcuseCancelado, RutaAcuse, montoTotExent, montoTotGrav, montoTotOperacion, montoTotRet, @FechaCancelacion
  	          FROM CFDRetencion 
             WHERE Modulo = @Modulo
               AND ModuloID = @ModuloID 
               AND Proveedor = @Proveedor
               AND ConceptoSAT = @ConceptoSAT

          DELETE CFDRetencion
           WHERE Modulo = @Modulo
             AND ModuloID = @ModuloID
             AND Proveedor = @Proveedor
             AND ConceptoSAT = @ConceptoSAT

          IF @Modulo = 'CXP'
            UPDATE Cxp SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
          ELSE IF @Modulo = 'GAS'
            UPDATE Gasto SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
          ELSE IF @Modulo = 'COMS'
            UPDATE Compra SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID
          ELSE IF @Modulo = 'DIN'
            UPDATE Dinero SET CFDRetencionTimbrado = 0 WHERE ID = @ModuloID

          IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = @Modulo AND ID = @ModuloID AND CFD = 1 AND Direccion = @AlmacenarRuta)
            INSERT AnexoMov ( Sucursal,  Rama,    ID,        Nombre,         Direccion,     Tipo,      Icono, CFD) 
                     VALUES (@Sucursal, @Modulo, @ModuloID, @NombreArchivo, @AlmacenarRuta, 'Archivo', 17,   1)
          
        END
      END
    END
  
  
  
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
    COMMIT TRAN
  END
  ELSE
  BEGIN
    ROLLBACK TRAN
	
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok      
  END
  
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL
END
GO

/**************** spCFDIRetencionProvPeriodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionProvPeriodo') and type = 'P') drop procedure dbo.spCFDIRetencionProvPeriodo
GO
CREATE PROC spCFDIRetencionProvPeriodo 
			@Estacion		int,
			@CxID			int, 
			@Empresa		varchar(5),
			@Proveedor		varchar(10),
			@ConceptoSAT	varchar(50),
			@Ok				int				OUTPUT, 
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Ejerc		int,
		  @MesIni		int,
		  @MesFin		int,
		  @MesAux		int

  --BUG1560
  SELECT @Ejerc = Ejercicio/*YEAR(FechaEmision)*/
    FROM CFDIRetencionD    
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
     AND Empresa = @Empresa

  --BUG1560
  SELECT @MesIni = MIN(Periodo)/*MIN(MONTH(FechaEmision))*/,
	     @MesFin = MAX(Periodo)/*MAX(MONTH(FechaEmision))*/,
	     @MesAux = MIN(Periodo)/*MIN(MONTH(FechaEmision))*/
    FROM CFDIRetencionD
   WHERE Proveedor = @Proveedor
     AND EstacionTrabajo = @Estacion
     AND ConceptoSAT = @ConceptoSAT
     AND Empresa = @Empresa		  
	 --CFDIRetencionProvPeriodo

 -- IF @ConceptoSAT IS NOT NULL
  WHILE(1=1)
  BEGIN

    IF @MesAux > @MesFin BREAK

    
    --SE ELIMINA VALIDACION DE RETENCIONES PROCESADAS
    --*****************************************************************************************
    --IF EXISTS(SELECT * FROM CFDIRetencionProvPeriodo WHERE Empresa = @Empresa AND Proveedor = @Proveedor AND ConceptoSAT = @ConceptoSAT AND Ejercicio = @Ejerc AND Periodo = @MesAux)
    --BEGIN
    --  SELECT @Ok = Mensaje, @OkRef = Descripcion FROM MensajeLista WHERE Mensaje = 60451
    --  BREAK
    --END
    --ELSE
    --BEGIN
    --  INSERT INTO CFDIRetencionProvPeriodo(ID, Empresa, Proveedor, ConceptoSAT, Ejercicio, Periodo) SELECT @CxID, @Empresa, @Proveedor, @ConceptoSAT, @Ejerc, @MesAux
    --END
    --*****************************************************************************************
 
    INSERT INTO CFDIRetencionProvPeriodo(ID, Empresa, Proveedor, ConceptoSAT, Ejercicio, Periodo) SELECT @CxID, @Empresa, @Proveedor, @ConceptoSAT, @Ejerc, @MesAux
    
    SELECT @MesAux = @MesAux + 1


  END
  
  RETURN
END
GO

/**************** spCFDIRetencionComplementoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionComplementoVerificar') and type = 'P') drop procedure dbo.spCFDIRetencionComplementoVerificar
GO
CREATE PROC spCFDIRetencionComplementoVerificar
			@Estacion		int, 
			@Empresa		varchar(5), 
			@Sucursal		int, 
			@Usuario		varchar(10), 
			@Proveedor		varchar(10), 
			@Ok				int				OUTPUT, 
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @ConceptoSAT		varchar(2),
		  @ConceptoSATAnt	varchar(2),
		  @Complemento		varchar(20),
		  @Version			varchar(5),
		  @Vista			varchar(100),
		  @XMLComplemento	varchar(max),
		  @Referencia		varchar(50)

  SELECT Modulo, ModuloID, Complemento, ConceptoSAT, RTRIM(Mov)+' '+RTRIM(MovID) 'Referencia'
    INTO #Valida
    FROM CFDIRetencionD 
    JOIN CFDIRetSATRetencion ON CFDIRetencionD.ConceptoSAT = CFDIRetSATRetencion.Clave
   WHERE EstacionTrabajo = @Estacion
     AND Empresa = @Empresa
     AND Proveedor = @Proveedor
     AND ISNULL(CFDIRetSATRetencion.Complemento, '') <> ''

  SELECT @ConceptoSATAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @ConceptoSAT = MIN(ConceptoSAT)
      FROM #Valida
     WHERE ConceptoSAT > @ConceptoSATAnt
     
    IF @ConceptoSAT IS NULL BREAK
    
    SELECT @ConceptoSATAnt = @ConceptoSAT
    
    SELECT @Version = NULL, @Vista = NULL, @Complemento = NULL
    
    SELECT @Complemento = Complemento, @Referencia = Referencia FROM #Valida WHERE ConceptoSAT = @ConceptoSAT
    
    SELECT @Version = Version, @Vista = Vista FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = @Complemento
    
    EXEC spCFDIRetencionXMLComplemento @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @Vista, NULL, @XMLComplemento = @XMLComplemento OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  

    SELECT @XMLComplemento = REPLACE(ISNULL(@XMLComplemento, ''), 'T00:00:00', '')
    SELECT @XMLComplemento = dbo.fnCFDILimpiarXML(@XMLComplemento, ' SELLO CERTIFICADO ')
      
    SELECT @XMLComplemento = REPLACE(@XMLComplemento, '<pagosaextranjeros:Beneficiario />', '')

    IF @Ok IS NULL
      EXEC spCFDIRetencionXMLCompVerificar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT, @Version, @XMLComplemento, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NOT NULL
    BEGIN
      SELECT @OkRef = '('+@Referencia+') ' + @OkRef
      
      UPDATE CFDIRetencionD 
         SET Ok = @Ok, 
             OkRef = @OkRef
        FROM CFDIRetencionD 
       WHERE EstacionTrabajo = @Estacion
         AND Empresa = @Empresa
         AND Proveedor = @Proveedor
    END
  END
  
  RETURN
END
GO

/**************** spCFDIRetencionAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIRetencionAfectar') and type = 'P') drop procedure dbo.spCFDIRetencionAfectar
GO
CREATE PROC spCFDIRetencionAfectar
			@Estacion		int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Proveedor		      varchar(10),
		      @ProveedorAnt		    varchar(10),
		      @ConceptoSAT		    varchar(2),
		      @ConceptoSATAnt	    varchar(2),
			  @RID                  int,
			  @RIDAnt				varchar(20),
		      @XML				        varchar(max),
		      @XMLComprobante	    varchar(max),
		      @XMLDetalle		      varchar(max),		  
		      @XMLComplemento	    varchar(max),
		      @XMLAddenda		      varchar(max),
		      @Ok				          int,
		      @OkRef			        varchar(255),
		      @MovTimbrado		    varchar(20),
		      @Concepto			      varchar(50),
		      @Version			      varchar(5),
		      @AlmacenarXML		    bit, 
		      @AlmacenarPDF		    bit,
		      @NomArch			      varchar(255),
		      @ArchivoQRCode	    varchar(255),
		      @ArchivoXML		      varchar(255),
		      @ArchivoPDF		      varchar(255),
		      @Reporte			      varchar(100),
		      @Ruta				        varchar(255),
		      @EnviarPara		      varchar(255),
		      @EnviarAsunto		    varchar(255),
		      @EnviarMensaje	    varchar(255),
		      @Enviar			        bit,
		      @EnviarXML		      bit,
		      @EnviarPDF		      bit,
		      @RFCEmisor		      varchar(20),
		      @RFCReceptor		    varchar(20),
		      @CxID				        int,	          	      
		      @montoTotExent	    float,
		      @montoTotGrav		    float,
		      @montoTotOperacion  float,
		      @montoTotRet		    float,		      
		      @UUID				        varchar(50),		      
		      @Ejerc			        int,
		      @MesIni			        int,
		      @MesFin			        int,
          @Modulo      varchar(20),
          ----- ID de Pólizas
          @cGasID             int,
          @cContID            int,
		  @AgruparConceptoSAT bit

     SET @Modulo = 'GAS'

  SELECT @MovTimbrado = MovTimbrado,
         @Concepto = Concepto,
         @Version = Version
    FROM CFDIRetencionCfg

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @AgruparConceptoSAT = ISNULL(AgruparConceptoSATRetenciones,0) FROM EmpresaCfg2 WHERE Empresa = @Empresa

  ---*****************************************************************************************************************---
  ---VERIFICAMOS SI EXISTEN LOS ID DE ListaModuloID EN CFDIRetencionD
  ---*****************************************************************************************************************---
  IF EXISTS(SELECT ID FROM ListaModuloID WHERE ID IN (SELECT MODULOID FROM CFDIRetencionD WHERE EstacionTrabajo = @Estacion ))    
  BEGIN

      IF @AgruparConceptoSAT = 1
	  DECLARE cMovimientos CURSOR FOR
	   SELECT ID,Modulo 
		 FROM ListaModuloID
		WHERE Estacion = @Estacion
	  ELSE
	  DECLARE cMovimientos CURSOR FOR
	   SELECT MIN(ID),Modulo 
		 FROM ListaModuloID
		WHERE Estacion = @Estacion
		GROUP BY Modulo

	  OPEN cMovimientos
	  FETCH NEXT FROM cMovimientos INTO @cGasID,@ConceptoSAT
	 
	  WHILE @@FETCH_STATUS = 0 
	  BEGIN
	  IF EXISTS(SELECT * FROM CFDIRetencionD WHERE EstacionTrabajo = @Estacion AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL AND Modulo = @Modulo AND ModuloID = @cGasID)
	  BEGIN
		SELECT @Ok = 1, @OkRef = 'El Concepto ' + Concepto + ' no se ha clasificado acorde el Catálogo del SAT'
		  FROM CFDIRetencionD 
		 WHERE EstacionTrabajo = @Estacion 
		   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL
		   AND Modulo = @Modulo AND ModuloID = @cGasID

		--BUG1156
		UPDATE CFDIRetencionD 
		   SET Ok = @Ok, 
			   OkRef = @OkRef 
		  FROM CFDIRetencionD
		 WHERE EstacionTrabajo = @Estacion 
		   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL
		   AND Modulo = @Modulo AND ModuloID = @cGasID
	       
		UPDATE CFDIRetencion
		   SET Ok = @Ok, 
			   OkRef = @OkRef 
		  FROM CFDIRetencion
		 WHERE EstacionTrabajo = @Estacion 
		   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL 
		   AND Modulo = @Modulo AND ModuloID = @cGasID             
	  END

	  IF NOT EXISTS(SELECT * FROM CFDIRetencionD WHERE EstacionTrabajo = @Estacion AND Modulo = @Modulo AND ModuloID = @cGasID)
	  BEGIN
		SELECT @Ok = 60010
	  END

	  IF @Ok IS NULL
	  BEGIN
	  
		SELECT @RFCEmisor = RFC FROM Empresa WHERE Empresa = @Empresa
	    
		SELECT @ProveedorAnt = ''
		WHILE(1=1)
		BEGIN
		  SELECT @Proveedor = MIN(Proveedor)
			FROM CFDIRetencionD
		   WHERE Proveedor > @ProveedorAnt
			 AND EstacionTrabajo = @Estacion
			 AND Empresa = @Empresa
			  AND Modulo = @Modulo AND ModuloID = @cGasID

		  IF @Proveedor IS NULL BREAK
	    
		  SELECT @ProveedorAnt = @Proveedor
	      
		  SELECT @RFCReceptor = NULL
		  SELECT @RFCReceptor = RFC FROM Prov WHERE Proveedor = @Proveedor

		  UPDATE CFDIRetencionD 
			 SET Ok = NULL, 
				 OkRef = NULL
			FROM CFDIRetencionD 
		   WHERE EstacionTrabajo = @Estacion
			 AND Empresa = @Empresa
			 AND Proveedor = @Proveedor
			  AND Modulo = @Modulo AND ModuloID = @cGasID

		  UPDATE CFDIRetencion
			 SET Ok = NULL, 
				 OkRef = NULL
			FROM CFDIRetencion
		   WHERE EstacionTrabajo = @Estacion
			 AND Empresa = @Empresa
			 AND Proveedor = @Proveedor         
			 AND Modulo = @Modulo AND ModuloID = @cGasID
	         
		  EXEC spCFDIRetencionComplementoVerificar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @Ok OUTPUT, @OkRef OUTPUT

		  IF @OK IS NULL
		  BEGIN
			IF @AgruparConceptoSAT = 1
			   SELECT @RID = MIN(RID)FROM CFDIRetencionD WHERE Proveedor = @Proveedor AND EstacionTrabajo = @Estacion AND Empresa = @Empresa AND ModuloID = @cGasID AND ConceptoSAT = @ConceptoSAT
            ELSE
			   SELECT @ConceptoSATAnt = ''

			WHILE(1=1)
			BEGIN

			  IF @AgruparConceptoSAT = 1
			  BEGIN

				   SELECT @ConceptoSAT = ConceptoSAT ,  @RIDAnt = isnull(MovID,0)
				   	 FROM CFDIRetencionD
				    WHERE Proveedor = @Proveedor
					  AND EstacionTrabajo = @Estacion
					  AND Empresa = @Empresa
					  AND Ok IS NULL
					  AND Modulo = @Modulo 
					  AND ModuloID = @cGasID
					  AND ConceptoSAT = @ConceptoSAT

			  IF @RID IS NULL BREAK
			  
			  END
			  ELSE
			  BEGIN
			  SELECT @ConceptoSAT = MIN(ConceptoSAT)
				FROM CFDIRetencionD
			   WHERE Proveedor = @Proveedor
				 AND EstacionTrabajo = @Estacion
				 AND Empresa = @Empresa
				 AND ConceptoSAT > @ConceptoSATAnt
				 AND Ok IS NULL
				 AND Modulo = @Modulo AND ModuloID = @cGasID
			  SELECT @RIDAnt = NULL

			  IF @ConceptoSAT IS NULL BREAK
	         
			  SELECT @ConceptoSATAnt = @ConceptoSAT
	         END

			  SELECT @Ok = NULL, @OkRef = NULL, @CxID = NULL, @UUID = NULL, @CxID = NULL, @montoTotExent = NULL, @montoTotGrav = NULL, @montoTotOperacion = NULL, 
		  				 @montoTotRet = NULL, @XML = NULL, @XMLDetalle = NULL, @XMLComplemento = NULL, @XMLAddenda = NULL, @AlmacenarXML = NULL, @AlmacenarPDF = NULL, 
						   @NomArch = NULL, @Reporte = NULL, @Ruta = NULL, @EnviarPara = NULL, @EnviarAsunto = NULL, @EnviarMensaje = NULL, @Enviar = NULL, 
						   @EnviarXML = NULL, @EnviarPDF = NULL

			  BEGIN TRAN

			  IF @Ok IS NULL
				EXEC spCFDIRetencionGenerar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT,@RIDAnt, @MovTimbrado, @Concepto, @CxID OUTPUT, @montoTotExent OUTPUT, @montoTotGrav OUTPUT, @montoTotOperacion OUTPUT, @montoTotRet OUTPUT, @Ejerc OUTPUT, @MesIni OUTPUT, @MesFin OUTPUT, @Ok OUTPUT, @OkRef OUTPUT          
			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionProvPeriodo @Estacion, @CxID, @Empresa, @Proveedor, @ConceptoSAT, @Ok OUTPUT, @OkRef OUTPUT                    
			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionXMLGenerar @CxID, @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT,@RIDAnt, @Version, @XML = @XML OUTPUT, @XMLDetalle = @XMLDetalle OUTPUT, @XMLComplemento = @XMLComplemento OUTPUT, @XMLAddenda = @XMLAddenda OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version,--BUG1560
											  @Ejerc, @MesIni, @MesFin, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, 
					    								  @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, 
										@EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, @Enviar OUTPUT, 
										@EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0,@RIDAnt

			  IF @CxID IS NOT NULL AND @Ok IS NULL
			  BEGIN
				SELECT @ArchivoQRCode = @Ruta + '\' + @NomArch + '.bmp',
						   @ArchivoXML	= @Ruta + '\' + @NomArch + '.xml',
						   @ArchivoPDF	= @Ruta + '\' + @NomArch + '.pdf'

				EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
			  END

			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionTimbrar @Estacion, @CxID, @Proveedor, @ConceptoSAT,@RIDAnt, @Empresa, @Version, @Usuario, @RFCEmisor, @RFCReceptor, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, @montoTotExent, @montoTotGrav, @montoTotOperacion, @montoTotRet, @Ejerc, @MesIni, @MesFin, @UUID OUTPUT, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionActualizarMov 'AFECTAR', @Estacion, @CxID, @Proveedor, @Empresa, @Version, @ConceptoSAT,@RIDAnt, @UUID, @Ok OUTPUT, @OkRef OUTPUT

			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionAnexoMov @Estacion, @CxID, @Proveedor, @Empresa, @Version, @ConceptoSAT, @RIDAnt, @UUID, @Ruta, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, 0, @Ok OUTPUT, @OkRef OUTPUT

			  IF @Ok IS NULL
				COMMIT TRAN
			  ELSE
				ROLLBACK TRAN  

			  IF @CxID IS NOT NULL AND @Ok IS NULL
				EXEC spCFDIRetencionQRCode @Estacion, @Proveedor, @ConceptoSAT, @Empresa, @Sucursal, @Version, @XML, @Usuario, @ArchivoQRCode, @RFCEmisor, @RFCReceptor, @montoTotExent, @montoTotGrav, @montoTotOperacion, @montoTotRet, @UUID, @Ok OUTPUT, @OkRef OUTPUT

	

			  IF @Ok IS NOT NULL
				  BEGIN
				    IF @AgruparConceptoSAT = 1
			        BEGIN
					UPDATE CFDIRetencionD 
					   SET Ok = @Ok, 
						   OkRef = @OkRef 
					  FROM CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND RID = @RIDAnt 
					   AND Modulo = @Modulo AND ModuloID = @cGasID
					UPDATE CFDIRetencion
					   SET Ok = @Ok, 
	    					 OkRef = @OkRef 
					  FROM CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					  AND ConceptoSAT = @ConceptoSAT    
					  AND RID = @RIDAnt  
					  AND Modulo = @Modulo AND ModuloID = @cGasID
					END
					ELSE
					BEGIN
					UPDATE CFDIRetencionD 
					   SET Ok = @Ok, 
						   OkRef = @OkRef 
					  FROM CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND Modulo = @Modulo AND ModuloID = @cGasID

					UPDATE CFDIRetencion
					   SET Ok = @Ok, 
	    					 OkRef = @OkRef 
					  FROM CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND Modulo = @Modulo AND ModuloID = @cGasID    
					END 
				  END
			  ELSE
				  BEGIN
				    IF @AgruparConceptoSAT = 1
			        BEGIN

					IF (SELECT Mov FROM CFDIRetencionD WHERE Proveedor = @Proveedor
						AND EstacionTrabajo = @Estacion AND Empresa = @Empresa
						AND Ok IS NULL AND Modulo = @Modulo  AND ModuloID = @cGasID
						AND ConceptoSAT = @ConceptoSAT	GROUP BY Mov) = 'Gasto'
						DELETE CFDIRetencionD
						 WHERE Proveedor = @Proveedor
						   AND EstacionTrabajo = @Estacion
						   AND Empresa = @Empresa
						   AND ConceptoSAT = @ConceptoSAT
						   AND Modulo = @Modulo AND ModuloID = @cGasID
					ELSE
						DELETE CFDIRetencionD
						 WHERE Proveedor = @Proveedor
						   AND EstacionTrabajo = @Estacion
						   AND Empresa = @Empresa
						   AND ConceptoSAT = @ConceptoSAT
						   AND RID = @RID
						   AND Modulo = @Modulo AND ModuloID = @cGasID

					DELETE CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   --AND MovID = @RIDAnt
					   AND Modulo = @Modulo AND ModuloID = @cGasID         

					DELETE CFDIRetencionCalcTmp
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					  -- AND MovID = @RIDAnt
					   AND Modulo = @Modulo AND ModuloID = @cGasID 
					   
					END
					ELSE
					BEGIN
					DELETE CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND Modulo = @Modulo 
					   AND ModuloID = @cGasID

					DELETE CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND Modulo = @Modulo   AND ModuloID = @cGasID         

					DELETE CFDIRetencionCalcTmp
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND Modulo = @Modulo AND ModuloID = @cGasID 
				    END            
				  END  
			  SELECT @RID =  MIN(RID)  
			    FROM CFDIRetencionD 
			   WHERE Proveedor =  @Proveedor
			     AND EstacionTrabajo = @Estacion
				 AND Empresa = @Empresa
				 AND RID > @RID
				 AND Ok IS NULL
				 AND ModuloID = @cGasID		
				 AND ConceptoSAT = @ConceptoSAT     
			END  --
		  END
			ELSE 
			  BEGIN
				 UPDATE CFDIRetencionD 
				   SET Ok = NULL, 
					   OkRef = NULL
				  FROM CFDIRetencionD 
				 WHERE EstacionTrabajo = @Estacion
				   AND Empresa = @Empresa
				   AND Proveedor = @Proveedor
				   AND Modulo = @Modulo AND ModuloID = @cGasID

				UPDATE CFDIRetencion
				   SET Ok = NULL, 
					   OkRef = NULL
				  FROM CFDIRetencion
				 WHERE EstacionTrabajo = @Estacion
				   AND Empresa = @Empresa
				   AND Proveedor = @Proveedor
				   AND Modulo = @Modulo AND ModuloID = @cGasID
			 END
		  END--	  
	   END --TERMINO WHILE
		
		/********************************************************************************/

		  DECLARE cPolizas CURSOR FOR
		  SELECT ID FROM dbo.fnBuscaMovs(@Modulo,@cGasID,@Empresa) WHERE Modulo = 'CONT'

		  OPEN cPolizas
		  FETCH NEXT FROM cPolizas INTO @cContID

		  WHILE @@FETCH_STATUS = 0
		  BEGIN
			EXEC xpContSAT @Empresa, @Modulo, @cGasID, @cContID, NULL    
			FETCH NEXT FROM cPolizas INTO @cContID
		  END

		  CLOSE cPolizas
		  DEALLOCATE cPolizas

		  /********************************************************************************/

		  FETCH NEXT FROM cMovimientos INTO @cGasID,@ConceptoSAT
		  END 

		  /********************************************************************************/

		CLOSE cMovimientos
		DEALLOCATE cMovimientos				
				
    END -- TERMINO DE IF EXISTS
    ---*****************************************************************************************************************---
  ELSE
	BEGIN
		IF EXISTS(SELECT * FROM CFDIRetencionD WHERE EstacionTrabajo = @Estacion AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL)
		  BEGIN
			SELECT @Ok = 1, @OkRef = 'El Concepto ' + Concepto + ' no se ha clasificado acorde el Catálogo del SAT'
			  FROM CFDIRetencionD 
			 WHERE EstacionTrabajo = @Estacion 
			   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL

			--BUG1156
			UPDATE CFDIRetencionD 
			   SET Ok = @Ok, 
				   OkRef = @OkRef 
			  FROM CFDIRetencionD
			 WHERE EstacionTrabajo = @Estacion 
			   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL
		       
			UPDATE CFDIRetencion
			   SET Ok = @Ok, 
				   OkRef = @OkRef 
			  FROM CFDIRetencion
			 WHERE EstacionTrabajo = @Estacion 
			   AND NULLIF(RTRIM(ConceptoSAT), '') IS NULL       
		  END

		  IF NOT EXISTS(SELECT * FROM CFDIRetencionD WHERE EstacionTrabajo = @Estacion)
		  BEGIN
			SELECT @Ok = 60010
		  END

		  IF @Ok IS NULL
		  BEGIN
			SELECT @RFCEmisor = RFC FROM Empresa WHERE Empresa = @Empresa
		    
			SELECT @ProveedorAnt = ''
			WHILE(1=1)
			BEGIN
			  SELECT @Proveedor = MIN(Proveedor)
				FROM CFDIRetencionD
			   WHERE Proveedor > @ProveedorAnt
				 AND EstacionTrabajo = @Estacion
				 AND Empresa = @Empresa

			  IF @Proveedor IS NULL BREAK
		    
			  SELECT @ProveedorAnt = @Proveedor
		      
			  SELECT @RFCReceptor = NULL
			  SELECT @RFCReceptor = RFC FROM Prov WHERE Proveedor = @Proveedor

			  UPDATE CFDIRetencionD 
				 SET Ok = NULL, 
					 OkRef = NULL
				FROM CFDIRetencionD 
			   WHERE EstacionTrabajo = @Estacion
				 AND Empresa = @Empresa
				 AND Proveedor = @Proveedor

			  UPDATE CFDIRetencion
				 SET Ok = NULL, 
					 OkRef = NULL
				FROM CFDIRetencion
			   WHERE EstacionTrabajo = @Estacion
				 AND Empresa = @Empresa
				 AND Proveedor = @Proveedor         
		         
			  EXEC spCFDIRetencionComplementoVerificar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @Ok OUTPUT, @OkRef OUTPUT

			  IF @OK IS NULL
			  BEGIN
			    IF @AgruparConceptoSAT = 1
				    SELECT @RID = MIN(RID) FROM CFDIRetencionD WHERE Proveedor = @Proveedor AND EstacionTrabajo = @Estacion AND Empresa = @Empresa
				ELSE
				    SELECT @ConceptoSATAnt = ''
				WHILE(1=1)
				BEGIN
				  IF @AgruparConceptoSAT = 1
				  BEGIN
				  SELECT @ConceptoSAT = ConceptoSAT ,  @RIDAnt = isnull(MovID,0)
					FROM CFDIRetencionD
				   WHERE Proveedor = @Proveedor
					 AND EstacionTrabajo = @Estacion
					 AND Empresa = @Empresa
					 AND RID = RID

				  IF @RID IS NULL BREAK

				  END
				  ELSE
				  BEGIN
				  SELECT @ConceptoSAT = MIN(ConceptoSAT)
					FROM CFDIRetencionD
				   WHERE Proveedor = @Proveedor
					 AND EstacionTrabajo = @Estacion
					 AND Empresa = @Empresa
					 AND ConceptoSAT > @ConceptoSATAnt
					 AND Ok IS NULL
				  SELECT @RIDAnt = NULL
				  IF @ConceptoSAT IS NULL BREAK
		    
				  SELECT @ConceptoSATAnt = @ConceptoSAT
				  END

				  SELECT @Ok = NULL, @OkRef = NULL, @CxID = NULL, @UUID = NULL, @CxID = NULL, @montoTotExent = NULL, @montoTotGrav = NULL, @montoTotOperacion = NULL, 
		  				 @montoTotRet = NULL, @XML = NULL, @XMLDetalle = NULL, @XMLComplemento = NULL, @XMLAddenda = NULL, @AlmacenarXML = NULL, @AlmacenarPDF = NULL, 
						 @NomArch = NULL, @Reporte = NULL, @Ruta = NULL, @EnviarPara = NULL, @EnviarAsunto = NULL, @EnviarMensaje = NULL, @Enviar = NULL, 
						 @EnviarXML = NULL, @EnviarPDF = NULL
		  
				  BEGIN TRAN

				  IF @Ok IS NULL
					EXEC spCFDIRetencionGenerar @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT,@RIDAnt, @MovTimbrado, @Concepto, @CxID OUTPUT, @montoTotExent OUTPUT, @montoTotGrav OUTPUT, @montoTotOperacion OUTPUT, @montoTotRet OUTPUT, @Ejerc OUTPUT, @MesIni OUTPUT, @MesFin OUTPUT, @Ok OUTPUT, @OkRef OUTPUT          

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionProvPeriodo @Estacion, @CxID, @Empresa, @Proveedor, @ConceptoSAT, @Ok OUTPUT, @OkRef OUTPUT                    
				
				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionXMLGenerar @CxID, @Estacion, @Empresa, @Sucursal, @Usuario, @Proveedor, @ConceptoSAT,@RIDAnt, @Version, @XML = @XML OUTPUT, @XMLDetalle = @XMLDetalle OUTPUT, @XMLComplemento = @XMLComplemento OUTPUT, @XMLAddenda = @XMLAddenda OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionAlmacenar @Empresa, @Usuario, @Proveedor, @ConceptoSAT, @Version, 			
												  --BUG1560
												  @Ejerc, @MesIni, @MesFin, 
												  @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, 
					    						  @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, @EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, 
												  @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0, @RIDAnt

				  IF @CxID IS NOT NULL AND @Ok IS NULL
				  BEGIN
					SELECT @ArchivoQRCode = @Ruta + '\' + @NomArch + '.bmp',
						   @ArchivoXML	= @Ruta + '\' + @NomArch + '.xml',
						   @ArchivoPDF	= @Ruta + '\' + @NomArch + '.pdf'

					EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
				  END

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionTimbrar @Estacion, @CxID, @Proveedor, @ConceptoSAT,@RIDAnt, @Empresa, @Version, @Usuario, @RFCEmisor, @RFCReceptor, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, @montoTotExent, @montoTotGrav, @montoTotOperacion, @montoTotRet, @Ejerc, @MesIni, @MesFin, @UUID OUTPUT, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionActualizarMov 'AFECTAR', @Estacion, @CxID, @Proveedor, @Empresa, @Version, @ConceptoSAT,@RIDAnt, @UUID, @Ok OUTPUT, @OkRef OUTPUT

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionAnexoMov @Estacion, @CxID, @Proveedor, @Empresa, @Version, @ConceptoSAT,@RIDAnt, @UUID, @Ruta, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, 0, @Ok OUTPUT, @OkRef OUTPUT

				  IF @Ok IS NULL
					COMMIT TRAN
				  ELSE
					ROLLBACK TRAN  

				  IF @CxID IS NOT NULL AND @Ok IS NULL
					EXEC spCFDIRetencionQRCode @Estacion, @Proveedor, @ConceptoSAT, @Empresa, @Sucursal, @Version, @XML, @Usuario, @ArchivoQRCode, @RFCEmisor, @RFCReceptor, @montoTotExent, @montoTotGrav, @montoTotOperacion, @montoTotRet, @UUID, @Ok OUTPUT, @OkRef OUTPUT

				  IF @Ok IS NOT NULL
				  BEGIN
				    IF @AgruparConceptoSAT = 1
					BEGIN
					UPDATE CFDIRetencionD 
					   SET Ok = @Ok, 
						   OkRef = @OkRef 
					  FROM CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND RID = @RID

					UPDATE CFDIRetencion
					   SET Ok = @Ok, 
	    					 OkRef = @OkRef 
					  FROM CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT 
					   AND RID = @RID 

					END
					ELSE
					BEGIN
					UPDATE CFDIRetencionD 
					   SET Ok = @Ok, 
						   OkRef = @OkRef 
					  FROM CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT

					UPDATE CFDIRetencion
					   SET Ok = @Ok, 
	    					 OkRef = @OkRef 
					  FROM CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					  AND ConceptoSAT = @ConceptoSAT  
				    END           
				  END
				  ELSE
				  BEGIN
				    IF @AgruparConceptoSAT = 1
					BEGIN
										 
					DELETE CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT
					   AND RID = @RID

					DELETE CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT 
					   AND MovID = @RIDAnt            

					DELETE CFDIRetencionCalcTmp
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT 
					   AND MovID = @RIDAnt  

					END
					ELSE
					BEGIN
					DELETE CFDIRetencionD
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT

					DELETE CFDIRetencion
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT             

					DELETE CFDIRetencionCalcTmp
					 WHERE Proveedor = @Proveedor
					   AND EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND ConceptoSAT = @ConceptoSAT   
					END                          
				  END   
				  
				  
				  SELECT @RID = MIN(RID) 
				      FROM CFDIRetencionD 
				     WHERE Proveedor =  @Proveedor
					   AND EstacionTrabajo = @Estacion
				  	   AND Empresa = @Empresa
				       AND RID > @RID
					   AND Ok IS NULL  
				END 
			  END 
			  ELSE 
				  BEGIN
					 UPDATE CFDIRetencionD 
					   SET Ok = NULL, 
						   OkRef = NULL
					  FROM CFDIRetencionD 
					 WHERE EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND Proveedor = @Proveedor

					UPDATE CFDIRetencion
					   SET Ok = NULL, 
						   OkRef = NULL
					  FROM CFDIRetencion
					 WHERE EstacionTrabajo = @Estacion
					   AND Empresa = @Empresa
					   AND Proveedor = @Proveedor         
			     
				  END
				  
			END
		  END
	END --TERMINA ELSE DE EXISTS

  DELETE FROM ListaModuloID

  IF @OkRef IS NOT NULL
    SELECT @OkREf
  ELSE 
    SELECT 'Proceso Concluido'


  RETURN
END
GO
/*********Se agrega funcion existente en ACTUALIZACIONES_DES para cancelacion de timbrado *********/
/*********** DESARROLLADOR: JOSE LUIS MENESES SANCHEZ  ******** FECHA: 11/12/2015 ****************/
/************************************************************************************************/
/*************** spIntelisisCFDICancelar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisCFDICancelar') and type = 'P') drop procedure dbo.spIntelisisCFDICancelar
GO
CREATE PROC spIntelisisCFDICancelar
            @Modulo					      varchar(10),
            @ID						        int,
            @Estatus				      varchar(20), 
            @Empresa				      varchar(10),
            @Sucursal				      int,
            @RutaTimbrarCFD			  varchar(255),
            @Fechatimbrado			  varchar(20),
            @ServidorPAC			    varchar(100),
            @UsuarioPAC				    varchar(100),
            @PaswordPAC				    varchar(100),
            @AccionCFDI				    varchar(50),
            @RutaCer				      varchar(200),
            @RutaKey				      varchar(200),
            @passKey				      varchar(100),
            @UUID					        varchar(50),
            @RFC					        varchar(20),
            @Documento				    varchar(max),
            @ModoPruebas			    bit,
            @AlmacenarRuta			  varchar(200),
            @EsRetencion			    bit,
            @FirmaCancelacionSAT  varchar(max)	OUTPUT,
            @DatosXMl				      varchar(max)	OUTPUT,
            @Ok						        int				OUTPUT,
            @OkRef					      varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE
          @CadenaConexion			  varchar(max),
	        @PswPFX					      varchar(30),
	        @RenglonDatos			    varchar(255),
	        @Error					      bit,
	        @xml					        xml,
	        @RID					        int,
	        @iDatos					      int,
	        @DocumentoXML			    xml,
	        @PrefijoCFDI			    varchar(255),
	        @Shell					      varchar(8000),
	        @r						        varchar(max),		  
	        @FechaCancelacionSAT  varchar(30),
	        @Cancelacion			    bit,
	        @TimeOutTimbrado		  int,
	        @MensajeSF				    varchar(max), 
	        @Dato1					      varchar(max),
	        @SelloCancelacionSAT	varchar(max),
	        @EstatusCancelacion		varchar(10),
	        --BUG21377
	        @LeeXML					      varchar(max),
	        @TokenCanPAC				  varchar(max),
	        @CuentaCanPAC				  varchar(max),
	        @RutaProvPac			    varchar(max),
	        @UsarTimbrarNomina    bit
 
  DECLARE @Datos TABLE (ID int identity(1,1), Datos varchar(255))

  --BUG21377
  SELECT @PswPFX = 'Intelisis1234567', @Cancelacion = 1

  IF @RutaTimbrarCFD IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta IntelisisCFDI.exe no Puede Estar Vacio' ELSE
  IF @Fechatimbrado IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Fecha de Timbrado no Puede Estar Vacio' ELSE
  IF @ServidorPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Servidor PAC No puede Estar Vacio' ELSE   
  IF @RutaCer IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Certificado CSD No puede Estar Vacio' ELSE 
  IF @RutaKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Archivo Key No puede Estar Vacio' ELSE 
  IF @passKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Password Key No puede Estar Vacio' ELSE 
  IF @UUID IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Folio Fiscal UUID No puede Estar Vacio' ELSE 
  IF @RFC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato RFC Empresa No puede Estar Vacio' ELSE 
  IF @AlmacenarRuta IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Almacenar Ruta No puede Estar Vacio'


  SELECT @UsarTimbrarNomina= UsarTimbrarNomina FROM EmpresaCFD WHERE Empresa = @Empresa
  IF @ServidorPAC='KONESH'
  BEGIN	
   IF @UsarTimbrarNomina=1 
    SELECT @UsuarioPAC=TimbrarCFDIUsuario,@PaswordPAC=TimbrarCFDIPassword,@CuentaCanPAC=CancelarCFDICuenta,@TokenCanPAC=CancelarCFDIToken  FROM EmpresaCFDNomina WHERE Empresa = @Empresa
   ELSE 
    SELECT @UsuarioPAC=CancelarCFDIUsuario,@PaswordPAC=CancelarCFDIPassword,@CuentaCanPAC=CancelarCFDICuenta,@TokenCanPAC=CancelarCFDIToken  FROM EmpresaCFD WHERE Empresa = @Empresa
    
    IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokenCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  
  IF @UsuarioPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Usuario PAC No puede Estar Vacio' ELSE 
  IF @PaswordPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Pasword PAC No puede Estar Vacio'  
  
  IF @Ok IS NULL
  BEGIN
    SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+@Fechatimbrado+'</FECHA>'+
		                         '<SERVIDOR>'+@ServidorPAC+'</SERVIDOR>'+
						                 '<USUARIO>'+@UsuarioPAC+'</USUARIO>'+
						                 '<PASSWORD>'+@PaswordPAC+'</PASSWORD>'+
						                 '<CUENTA>'+ISNULL(@CuentaCanPAC,'')+'</CUENTA>'+
						                 '<TOKEN>'+ISNULL(@TokenCanPAC,'')+'</TOKEN>'+
						                 '<ACCION>'+@AccionCFDI+'</ACCION>'+
						                 '<RUTACER>'+@RutaCer+'</RUTACER>'+
						                 '<RUTAKEY>'+@RutaKey+'</RUTAKEY>'+
						                 '<PWDKEY>'+@passKey+'</PWDKEY>'+
						                 '<PWDPFX>'+@PswPFX+'</PWDPFX>'+
						                 '<UUID>'+@UUID+'</UUID>'+
						                 '<RFC>'+@RFC+'</RFC>'+
						                 --BUG21377
			                       '<TIMEOUT>'+convert(varchar(30),ISNULL(@TimeOutTimbrado, 15000))+'</TIMEOUT>'+
						                 '<RUTAARCHIVO>'+@AlmacenarRuta+'</RUTAARCHIVO>'+
				                     '<MODOPRUEBAS>'+CONVERT(varchar(1),@ModoPruebas)+'</MODOPRUEBAS>'	
				         IF @EsRetencion=1 
				           SELECT  @CadenaConexion=@CadenaConexion+'<USARFIRMASAT>0</USARFIRMASAT></IntelisisCFDI>'
						     ELSE
						      SELECT  @CadenaConexion=@CadenaConexion+'</IntelisisCFDI>'

						     
    SELECT @Shell = CHAR(34)+CHAR(34)+@RutaTimbrarCFD+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)



    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @DatosXMl = ''
    DECLARE crResultadoXMl CURSOR FOR
      SELECT Id, Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
    OPEN crResultadoXMl
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      WHILE @@FETCH_STATUS <> -1
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN  
		IF @RID = 1 AND CHARINDEX('<IntelisisCFDI><Error>',@RenglonDatos) >= 1
		SELECT @Error = 1

	    IF @RID = 1 AND CHARINDEX('<',@RenglonDatos) = 0
		  SELECT @Error = 1
		
        SELECT @DatosXMl = @DatosXML + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
	END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl
 
    IF @Error = 1 SELECT @Ok = 71650,  @OkRef = @DatosXml
    IF @r <> 0
    BEGIN
      IF CHARINDEX('programa o archivo por lotes ejecutable.',@RenglonDatos) >= 1
	    SELECT @Ok = 71650, @OkRef = 'Falta configurar la ruta de IntelisisCFDI.exe'
	  ELSE
	    SELECT @OK = 71650, @OkREf = 'Error al Ejecutar IntelisisCFDI.exe '+ISNULL(@DatosXml,'')
    END
    IF NULLIF(@DatosXMl,'') IS NULL SELECT @Ok = 71650, @OkRef = 'Se Esperaba Respuesta de IntelisisCFDI.exe' 

    --BUG21377
	--IF @ServidorPAC = 'SOLUCIONFACTIBLE'  OR @ServidorPAC='FORMASDIGITALES' OR @ServidorPAC='INVOICEONE'
	  SELECT @DatosXMl = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DatosXMl, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),'''','''''')

    IF @Ok is NULL
    BEGIN
      BEGIN TRY
        SELECT @xml = CONVERT(XML,@DatosXml)
      END TRY
      BEGIN CATCH
        SELECT @Ok = 71600, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH

      IF @OK IS NULL 
      BEGIN
	    SET @PrefijoCFDI = '<ns xmlns'+CHAR(58)+'es="http'+ CHAR(58) +'//cancelacfd.sat.gob.mx"  xmlns'+CHAR(58)+'sg="http'+ CHAR(58) +'//www.w3.org/2000/09/xmldsig#"/>' 	

        --BUG21401
	    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML, @PrefijoCFDI
 
        IF @ServidorPAC ='MASTEREDI'
        BEGIN
          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, 'MasTimbrado') 
            WITH (Firma	varchar(max) 'Mensaje')

          IF @FirmaCancelacionSAT='El archivo se proceso con exito.'			
          SET @FirmaCancelacionSAT=@FirmaCancelacionSAT+'Para obtener el acuse consulte a su PAC'													
        END		
        ELSE  IF @ServidorPAC ='KONESH'
        BEGIN
          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, 'Cancelacion') 
            WITH (Firma	varchar(max) '.')         		
          SET @FirmaCancelacionSAT=@FirmaCancelacionSAT+'Para obtener el acuse consulte a su PAC'													
        END	 
	    ELSE IF @ServidorPAC = 'SOLUCIONFACTIBLE'
	    BEGIN
          SELECT @MensajeSF = mensaje
            FROM OPENXML (@idatos, '//EnviarSolicitudCancelacionResponse/CFDIResultadoCancelacion',2) 
            WITH (mensaje	varchar(max) 'mensaje')

          EXEC spExtraerDato @MensajeSF OUTPUT, @Dato1 OUTPUT, ':'
          EXEC spExtraerDato @MensajeSF OUTPUT, @FirmaCancelacionSAT OUTPUT, ';'
          SELECT @FirmaCancelacionSAT = RTRIM(LTRIM(@FirmaCancelacionSAT))           

          SELECT @EstatusCancelacion = EstatusUUID
          FROM   OPENXML (@idatos,'//EnviarSolicitudCancelacionResponse/CFDIResultadoCancelacion' ) 
          WITH (EstatusUUID       varchar(max) 'statusUUID') 
	    END  
        
        ELSE IF @ServidorPAC = 'FORMASDIGITALES'    
            BEGIN  
                SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 's="http' + CHAR(58) + '//schemas.xmlsoap.org/soap/envelope/" xmlns' + CHAR(58) + 'cr="http' + CHAR(58) + '//cancelacfd.sat.gob.mx" xmlns' + CHAR(58) + 'sg="http' + CHAR(58) + '//www.w3.org/2000/09/xmldsig'+CHAR(35)+'" />'                  
                    EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML, @PrefijoCFDI                     
           
                    SELECT @FechaCancelacionSAT = Fecha, @EstatusCancelacion = EstatusUUID    
                        FROM   OPENXML (@idatos, '//cr:CancelaCFDResponse/cr:CancelaCFDResult/cr:Folios',2)     
                                   WITH (Fecha    varchar(50)         '../@Fecha',    
                                    UUID    varchar(50) 'cr:UUID',     
                                    EstatusUUID  varchar(10) 'cr:EstatusUUID',    
                                            RFC    varchar(10) '../@RfcEmisor')    
          
                    SELECT @FirmaCancelacionSAT = Firma    
                        FROM   OPENXML (@idatos, '//cr:CancelaCFDResponse/cr:CancelaCFDResult/sg:Signature',2)     
                               WITH (Firma       varchar(max) 'sg:SignatureValue')    
          
                    EXEC sp_xml_removedocument @iDatos 
            END 

	    ELSE  IF @ServidorPAC ='G4S'
        BEGIN                         		
          SET @FirmaCancelacionSAT='Para obtener el acuse consulte a su PAC'													
        END
	    ----REQ21490 REQ21609
	    --ELSE IF @ServidorPAC IN('EKOMERCIO', 'FEL', 'ASPEL')
	    --BEGIN
	    --  SELECT @EstatusCancelacion = EstatusUUID
		   -- FROM OPENXML (@idatos,'//es:Folios' ) 
		   -- WITH (EstatusUUID       varchar(max) 'es:EstatusUUID')
			
		   --SELECT @FirmaCancelacionSAT = Firma
		   --  FROM OPENXML (@idatos, '//sg:Signature') 
		   --  WITH (Firma	 varchar(max) 'sg:SignatureValue')         	  
	    --END	    
	    ELSE	
        BEGIN
          SELECT @EstatusCancelacion = EstatusUUID
            FROM OPENXML (@idatos,'//es:Folios' ) 
            WITH (EstatusUUID       varchar(max) 'es:EstatusUUID')

          SELECT @FirmaCancelacionSAT = Firma
            FROM OPENXML (@idatos, '//sg:Signature') 
            WITH (Firma	 varchar(max) 'sg:SignatureValue')         
	    END
	  	  
	    EXEC sp_xml_removedocument @iDatos 

        --BUG21630
        IF @EstatusCancelacion IN('201', '202') SELECT @EstatusCancelacion = NULL
		
        IF @EstatusCancelacion IS NOT NULL
	    BEGIN
   	      SELECT @OK = 71651
		  SELECT @OkRef = Descripcion FROM MensajeCFDI WHERE Mensaje = @EstatusCancelacion
		  
		  --BUG21630
		  --IF @EstatusCancelacion IN ('201') AND @FirmaCancelacionSAT IS NULL
  		  --  SELECT @OK = NULL , @OkRef = NULL
        END
      END
    END
  END
END
GO

/*********************************     spRetencionesActulizarComplementos     ************************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spRetencionesActulizarComplementos') AND type = 'P') 
	DROP PROCEDURE spRetencionesActulizarComplementos
GO
CREATE PROCEDURE spRetencionesActulizarComplementos
                                                    @Modulo     varchar(5),
                                                    @ID         int,
                                                    @Bandera    int
--//WITH ENCRYPTION
AS
BEGIN
DECLARE @Concepto           varchar(50),
        @CFDIRetClave       varchar(2),
        @RetmontoTotGrav    money,
        @RetmontoTotExent   money,
        @montoTotOperacion  money,
        @RetencionISR       money,
        @RetencionIVA       money,
        @montoTotGrav       float,
        @montoTotExent      float,
        @Version            varchar(5),
        @importe            money,
        @Clave              varchar(2)

    IF @Bandera = 1
    BEGIN
	    IF @Modulo = 'GAS' 
        BEGIN 
            SELECT @montoTotOperacion = ISNULL(SUM(GD.Importe),0.00),
                   @RetencionISR      = ISNULL(SUM(GD.Retencion),0.00), 
                   @RetencionIVA      = ISNULL(SUM(GD.Retencion2),0.00)                       
              FROM GastoD GD
              JOIN Gasto G ON GD.ID = G.ID 
             WHERE G.ID = @ID
             GROUP BY GD.Concepto 

            IF (SELECT COUNT(Concepto) FROM GastoD WHERE ID = @ID GROUP BY Concepto) > 1
                RETURN

            SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID GROUP BY Concepto
            SELECT @CFDIRetClave = CFDIRetClave FROM CFDIRetencionConcepto WHERE Concepto = @Concepto

            SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                   @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
              FROM CFDIRetSATRetencion 
             WHERE CLAVE = @CFDIRetClave

            SELECT @montoTotGrav = (@montoTotOperacion*@RetmontoTotGrav)/100
            SELECT @montoTotExent = (@montoTotOperacion*@RetmontoTotExent)/100
            SELECT @Version = Version FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Intereses'

            IF NOT EXISTS (SELECT * FROM CFDIRetSATIntereses WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                INSERT CFDIRetSATIntereses (ID, Version, SistFinanciero, RetiroAORESRetInt, OperFinancDerivad, MontIntNominal,     MontIntReal,                                    Perdida, Gravado,       Exento) 
                                    SELECT @ID, @Version, 'SI',          'SI',              'SI',              @montoTotOperacion, @montoTotOperacion-@RetencionISR-@RetencionIVA, 0.00,    @montoTotGrav, @montoTotExent

            IF EXISTS (SELECT * FROM CFDIRetSATIntereses WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                UPDATE CFDIRetSATIntereses
                   SET MontIntNominal = @montoTotOperacion,
                       MontIntReal    = @montoTotOperacion-@RetencionISR-@RetencionIVA,
                       Gravado        = @montoTotGrav,
                       Exento         = @montoTotExent
                 WHERE ID = @ID            
        END
    END

    IF @Bandera = 2
    BEGIN
	    IF @Modulo = 'GAS' 
        BEGIN 
            SELECT @montoTotOperacion = ISNULL(SUM(GD.Importe),0.00),
                   @RetencionISR      = ISNULL(SUM(GD.Retencion),0.00), 
                   @RetencionIVA      = ISNULL(SUM(GD.Retencion2),0.00)                       
              FROM GastoD GD
              JOIN Gasto G ON GD.ID = G.ID 
             WHERE G.ID = @ID
             GROUP BY GD.Concepto 

            IF (SELECT COUNT(Concepto) FROM GastoD WHERE ID = @ID GROUP BY Concepto) > 1
                RETURN

            SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID GROUP BY Concepto
            SELECT @CFDIRetClave = CFDIRetClave FROM CFDIRetencionConcepto WHERE Concepto = @Concepto

            SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                   @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
              FROM CFDIRetSATRetencion 
             WHERE CLAVE = @CFDIRetClave

            SELECT @montoTotGrav = (@montoTotOperacion*@RetmontoTotGrav)/100
            SELECT @montoTotExent = (@montoTotOperacion*@RetmontoTotExent)/100
            SELECT @Version = Version FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = 'EnajenacionAcciones'
            
            IF NOT EXISTS (SELECT * FROM CFDIEnajenacionGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                INSERT CFDIEnajenacionGastoComplemento (ID, Clave,         VersionXSD, Descripcion, Ganancia, Perdida, Gravado,       Exento) 
                                                SELECT @ID, @CFDIRetClave, @Version,   '',          0.00,      0.00,   @montoTotGrav, @montoTotExent

            IF EXISTS (SELECT * FROM CFDIEnajenacionGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                UPDATE CFDIEnajenacionGastoComplemento
                   SET Gravado        = @montoTotGrav,
                       Exento         = @montoTotExent
                 WHERE ID = @ID            
        END
    END
    
    IF @Bandera = 3
    BEGIN
	    IF @Modulo = 'GAS' 
        BEGIN 
            SELECT @montoTotOperacion = ISNULL(SUM(GD.Importe),0.00),
                   @RetencionISR      = ISNULL(SUM(GD.Retencion),0.00), 
                   @RetencionIVA      = ISNULL(SUM(GD.Retencion2),0.00)                       
              FROM GastoD GD
              JOIN Gasto G ON GD.ID = G.ID 
             WHERE G.ID = @ID
             GROUP BY GD.Concepto 

            IF (SELECT COUNT(Concepto) FROM GastoD WHERE ID = @ID GROUP BY Concepto) > 1
                RETURN

            SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID GROUP BY Concepto
            SELECT @CFDIRetClave = CFDIRetClave FROM CFDIRetencionConcepto WHERE Concepto = @Concepto

            SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                   @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
              FROM CFDIRetSATRetencion 
             WHERE CLAVE = @CFDIRetClave

            SELECT @montoTotGrav = (@montoTotOperacion*@RetmontoTotGrav)/100
            SELECT @montoTotExent = (@montoTotOperacion*@RetmontoTotExent)/100
            SELECT @Version = Version FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Dividendos'

            SELECT @Clave = Clave FROM CFDIRetSATDividendo ORDER BY Clave DESC
            
            IF NOT EXISTS (SELECT * FROM CFDIRetGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                INSERT CFDIRetGastoComplemento (ID, CveTipDivOUtil, TipoSocDistrDiv, ProporcionRem, Gravado,       Exento) 
                                                SELECT @ID, @Clave, 'Sociedad Nacional',  0.00,     @montoTotGrav, @montoTotExent

            IF EXISTS (SELECT * FROM CFDIRetGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                UPDATE CFDIRetGastoComplemento
                   SET Gravado        = @montoTotGrav,
                       Exento         = @montoTotExent
                 WHERE ID = @ID
        END
    END

     IF @Bandera = 4
    BEGIN
	    IF @Modulo = 'GAS' 
        BEGIN 
            SELECT @montoTotOperacion = ISNULL(SUM(GD.Importe),0.00),
                   @RetencionISR      = ISNULL(SUM(GD.Retencion),0.00), 
                   @RetencionIVA      = ISNULL(SUM(GD.Retencion2),0.00)                       
              FROM GastoD GD
              JOIN Gasto G ON GD.ID = G.ID 
             WHERE G.ID = @ID
             GROUP BY GD.Concepto 

            IF (SELECT COUNT(Concepto) FROM GastoD WHERE ID = @ID GROUP BY Concepto) > 1
                RETURN

            SELECT @Concepto = Concepto FROM GastoD WHERE ID = @ID GROUP BY Concepto
            SELECT @CFDIRetClave = CFDIRetClave FROM CFDIRetencionConcepto WHERE Concepto = @Concepto

            SELECT @RetmontoTotGrav = ISNULL(RetmontoTotGrav,0.00),
                   @RetmontoTotExent = ISNULL(RetmontoTotExent,0.00) 
              FROM CFDIRetSATRetencion 
             WHERE CLAVE = @CFDIRetClave

            SELECT @montoTotGrav = (@montoTotOperacion*@RetmontoTotGrav)/100
            SELECT @montoTotExent = (@montoTotOperacion*@RetmontoTotExent)/100
            SELECT @Version = Version FROM CFDIRetencionCompXMLPlantilla WHERE Complemento = 'Dividendos'

            SELECT @Clave = Clave FROM CFDIRetSATDividendo ORDER BY Clave DESC
                       
            IF NOT EXISTS (SELECT * FROM CFDIRetGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                INSERT CFDIRetGastoComplemento (ID, CveTipDivOUtil, TipoSocDistrDiv, ProporcionRem, Gravado,       Exento,         MontISRAcredRetMexico, MontISRAcredRetExtranjero, MontRetExtDivExt, MontISRAcredNal, MontDivAcumNal, MontDivAcumExt) 
                                                SELECT @ID, @Clave, 'Sociedad Nacional',  0.00,     @montoTotGrav, @montoTotExent, 0.00,                  0.00,                      0.00,             0.00,            0.00,           0.00

            IF EXISTS (SELECT * FROM CFDIRetGastoComplemento WHERE ID = @ID) AND (SELECT Estatus FROM Gasto WHERE ID = @ID) NOT IN ('CONCLUIDO','CANCELADO')
                UPDATE CFDIRetGastoComplemento
                   SET Gravado        = @montoTotGrav,
                       Exento         = @montoTotExent
                 WHERE ID = @ID
        END
    END
    
END
GO

UPDATE CFDIRetSATRetencion SET RetmontoTotGrav = 100, RetmontoTotExent = 0
GO
/********* DESARROLLADOR: JOSE LUIS MENESES SANCHEZ  - FECHA: 11/12/2015 ********/
/*******************************************************************************/

--BEGIN TRAN
--  select * from CFDRetencion
--  EXEC spCFDIRetencionAfectar 2, 'DEMO', 0, 'DEMO'    
--  select * from CFDRetencion
----  SELECT * FROM CFDRetencion
----  select * from compra where CFDRetencionTimbrado = 1
----  select * from gasto where CFDRetencionTimbrado = 1
----  select * from cxp where CFDRetencionTimbrado = 1
--  EXEC spCFDIRetencionCalc 1, 'DEMO', '01/12/2014', '31/12/2014', NULL
----  SELECT * FROM ANEXOMOV
--ROLLBACK TRAN