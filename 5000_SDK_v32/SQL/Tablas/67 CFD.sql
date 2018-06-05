/*************************** CFDILog **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDILog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDILog','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDILog') and type = 'U') 
CREATE TABLE CFDILog
    (
    RID					int				identity(1,1),
	Proceso				varchar(100)	NULL,
	Empresa				varchar(5)		NULL,    
	Modulo				varchar(5)		NULL,
	ID					int				NULL,	
    Mov					varchar(20)     NULL,
	MovID				varchar(20)     NULL,
	Documento			varchar(max)	NULL,
	Timbrado			bit				NOT NULL DEFAULT 0, 
	FechaLog			datetime		NULL,
	NoError				int				NULL,
	Mensaje				varchar(800)	NULL,
	Texto				varchar(max)	NULL,
	CONSTRAINT priCFDILog PRIMARY KEY  CLUSTERED (RID)	
	)
GO
EXEC spALTER_COLUMN 'CFDiLog', 'Mensaje', 'varchar(800) NULL'
GO

/****** EmpresaCFD ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCFD') and type = 'U') 
CREATE TABLE dbo.EmpresaCFD (
	Empresa 		char(5) 	NOT NULL,

	noCertificado		varchar(20)	NULL,
	version			varchar(10)	NULL,
	versionFecha		datetime	NULL,
	versionAnterior		varchar(10)	NULL,
	EAN13			varchar(20)	NULL,
	DUN14			varchar(20)	NULL,
	SKU			varchar(20)	NULL,
	SKUEmpresa		varchar(20)	NULL,
	SKUCodigoInterno	bit		NULL		DEFAULT 0,
	Llave			varchar(255)	NULL,
	Certificado		varchar(255)	NULL,
	ContrasenaSello		varchar(100)	NULL,
	ModoPruebas		bit		NULL		DEFAULT 0,
	SAT_MN			bit		NULL		DEFAULT 1,

	Nombre			varchar(100)	NULL,		-- Movimiento / Folio
	Reporte			varchar(100)	NULL,

	XSL			varchar(255)	NULL,
	XSLAnterior		varchar(255)	NULL,
	Validar			bit		NULL		DEFAULT 0,
	ValidarSchema		varchar(255)	NULL,
	ValidarSchemaAnterior	varchar(255)	NULL,

	Almacenar		bit		NULL		DEFAULT 0,
	AlmacenarXML		bit		NULL		DEFAULT 0,
	AlmacenarPDF		bit		NULL		DEFAULT 0,
	AlmacenarRuta		varchar(255)	NULL,

	Enviar			bit		NULL		DEFAULT 0,
	EnviarXML		bit		NULL		DEFAULT 0,
	EnviarPDF		bit		NULL		DEFAULT 0,
	EnviarMedio		varchar(20)	NULL,		-- FTP / SMTP
	EnviarDireccion		varchar(255)	NULL,		-- FTP / SMTP
	EnviarRuta		varchar(255)	NULL,		-- FTP	
	EnviarUsuario		varchar(100)	NULL,		-- FTP anonymous
	EnviarContrasena	varchar(100)	NULL,		-- FTP anonymous
	EnviarDe		varchar(100)	NULL,		-- SMTP (Usuario)
	EnviarAsunto		varchar(255)	NULL,		-- SMTP
	EnviarMensaje		varchar(255)	NULL,		-- SMTP
	EnviarAlAfectar		bit		NULL		DEFAULT 0,

	CertificadoBase64	text		NULL,
	PaqueteEsCantidad	bit 		NOT NULL 		DEFAULT 0,
    AgruparDetalle		bit			NOT NULL		DEFAULT 0,
    
	RutaFirmaSAT		varchar(255)	NULL, --MEJORA2104
	RutaCertificado		varchar(255)	NULL, --MEJORA2104
	RutaTemporal		varchar(255)	NULL, --MEJORA2104
	RutaANSIToUTF		varchar(255)	NULL, --MEJORA2104
	RutaTimbrarCFDI		varchar(255)	NULL, --MEJORA2104
	
	TimbrarCFDIServidor	varchar(100)	NULL,
	TimbrarCFDIUusario	varchar(100)	NULL,
	TimbrarCFDIPassword	varchar(100)	NULL,

	Jasper				bit				NULL		DEFAULT 0,
	Nailgun				bit				NULL		DEFAULT 0,--REQ 14790
	RutaGenerarQRCode	varchar(255)	NULL,
	RutaJasper			varchar(255)	NULL,
	JasperFueraLinea	bit				NULL		DEFAULT 0,--Fuera de Linea

	MostrarAnexoPDF		bit				NULL		DEFAULT 0,
	NoValidarOrigenDocumento	bit		NULL		DEFAULT 0,

	ToleranciaCalculo			float	NULL		DEFAULT 0.05,

	ContatoFirmadoAspel				varchar(max)	NULL,
	RutaFirmarContratoAspel			varchar(255)	NULL,
	GenerarPdfAfectar				bit	NOT NULL	DEFAULT 1,
	RegistrarLog					bit NOT NULL	DEFAULT 0,
    CancelarCFDIUsuario				varchar(100) NULL,
    CancelarCFDIPassword            varchar(100) NULL,
    ContrasenakeyCSD                varchar(100) NULL,
    CancelarCFDIToken               varchar(100) NULL,
    CancelarCFDICuenta              varchar(100) NULL,
    TimeOutTimbrado                 int NOT NULL DEFAULT 15000,
	UsarIntelisisCFDI				bit NOT NULL	DEFAULT 1,
	UsarTimbrarNomina				bit NOT NULL	DEFAULT 0,
	EnviarSmtp					varchar(50) NULL,--Mejora envio correo
	EnviarPuerto					varchar(50) NULL,--Mejora envio correo
	BackSQL							bit NOT NULL	DEFAULT 0,
	UsarFirmaSAT					bit NOT NULL	DEFAULT 0,
	CONSTRAINT priEmpresaCFD PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'Nombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'Reporte', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarDireccion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarRuta', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarContrasena', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarDe', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarAsunto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarMensaje', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarAlAfectar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'ModoPruebas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'SAT_MN', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'SKUEmpresa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CertificadoBase64', 'text NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'XSL', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'XSLAnterior', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'ValidarSchemaAnterior', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'PaqueteEsCantidad', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'AgruparDetalle', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'CadenaOriginal8000', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spAlter_Table 'EmpresaCFD', 'RutaFirmaSAT', 'varchar(255) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'RutaCertificado', 'varchar(255) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'RutaTemporal', 'varchar(255) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'RutaANSIToUTF', 'varchar(255) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'RutaTimbrarCFDI', 'varchar(255) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'TimbrarCFDIServidor', 'varchar(100) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'TimbrarCFDIUsuario', 'varchar(100) NULL' --MEJORA2104
EXEC spAlter_Table 'EmpresaCFD', 'TimbrarCFDIPassword', 'varchar(100) NULL' --MEJORA2104
GO
EXEC spAlter_Table 'EmpresaCFD', 'Decimales', 'int NULL'
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'Jasper', 'bit NULL DEFAULT 0 WITH VALUES' -- Utilizar Jasper Reports
EXEC spALTER_TABLE 'EmpresaCFD', 'Nailgun', 'bit NULL DEFAULT 0 WITH VALUES' -- Utilizar Jasper Reports --REQ 14790
EXEC spAlter_Table 'EmpresaCFD', 'RutaGenerarQRCode', 'varchar(255) NULL' --Pestaña Jasper Reports
EXEC spAlter_Table 'EmpresaCFD', 'RutaJasper', 'varchar(255) NULL' --Pestaña Jasper Reports
EXEC spALTER_TABLE 'EmpresaCFD', 'JasperFueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' -- Utilizar Jasper Reports
EXEC spALTER_TABLE 'EmpresaCFD', 'MostrarAnexoPDF', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'NoValidarOrigenDocumento', 'bit NULL DEFAULT 0 WITH VALUES' -- No Validar Origen del Documento
EXEC spALTER_TABLE 'EmpresaCFD', 'ToleranciaCalculo', 'float NULL DEFAULT 0.05 WITH VALUES'
GO
EXEC spAlter_Table 'EmpresaCFD','ContatoFirmadoAspel','varchar(max)	NULL'
EXEC spAlter_Table 'EmpresaCFD','RutaFirmarContratoAspel','varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'GenerarPdfAfectar', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'ReportBuilder', 'bit NULL'--Utilizar Report Builder REQ 16770
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaReportBuilder', 'varchar(256) NULL'--Utilizar Report Builder REQ 16770
EXEC spALTER_TABLE 'MovTipo', 'CFDReportBuilder', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'Reporteador', 'varchar(30) NULL'
EXEC spALTER_TABLE 'MovTipo', 'CFDReporteIntelisis', 'varchar(50) NULL'
EXEC spAlter_Table 'EmpresaCFD','RegistrarLog', 'bit NULL DEFAULT 0 WITH VALUES'
GO


EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIPassword', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'ContrasenakeyCSD', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIToken', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDICuenta', 'varchar(100) NULL'
GO
EXEC spAlter_Table 'EmpresaCFD', 'TimeOutTimbrado', 'int NOT NULL DEFAULT 15000 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'UsarIntelisisCFDI', 'BIT NOT NULL DEFAULT 1'
GO
--
EXEC spALTER_TABLE 'EmpresaCFD', 'UsarTimbrarNomina', 'bit	NULL DEFAULT 0'
GO

EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarSmtp', 'varchar(50) NULL'--Mejora envio correo
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarPuerto', 'varchar(50) NULL'--Mejora envio correo
GO	
EXEC spALTER_TABLE 'EmpresaCFD', 'BackSQL', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'UsarFirmaSAT', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

if not exists(select * from SysPK where Tabla = 'EmpresaCFD')
  EXEC fixEmpresaCFD
GO
/****** EmpresaCFDNomina ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDNomina')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDNomina','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCFDNomina') and type = 'U') 
CREATE TABLE dbo.EmpresaCFDNomina (
	Empresa 		char(5) 	NOT NULL,
	
	Llave			varchar(255)	NULL,
	Certificado		varchar(255)	NULL,
	ContrasenaLlave		varchar(100)	NULL,
	ModoPruebas		bit		NULL		DEFAULT 0,
	
	TimbrarCFDIServidor	varchar(100)	NULL,
	TimbrarCFDIUsuario	varchar(100)	NULL,
	TimbrarCFDIPassword	varchar(100)	NULL,
	CancelarCFDIUsuario				varchar(100) NULL,
    CancelarCFDIPassword            varchar(100) NULL,    
    CancelarCFDIToken               varchar(100) NULL,
    CancelarCFDICuenta              varchar(100) NULL,   
    noCertificado					varchar(20)  NULL
	CONSTRAINT priEmpresaCFDNomina PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'EmpresaCFDNomina', 'DireccionCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'ContrasenaCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'SmtpCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'PuertoCorreo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'MedioEnvio', 'varchar(25) NULL'
--BUG25925
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'noCertificado', 'varchar(20) NULL'
GO
/*** CFD_QR_Code ***/
if not exists(select * from SysTabla where SysTabla = 'CFD_QR_Code')--Utilizar Report Builder REQ 16770
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFD_QR_Code','N/A')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CFD_QR_Code' and type ='U')
CREATE TABLE CFD_QR_Code(
	ID int IDENTITY(1,1) NOT NULL,
	UUID uniqueidentifier NULL,
	QR_Code image NULL,
CONSTRAINT PK__CFD_QR_C__3214EC274D3958F2 PRIMARY KEY CLUSTERED(ID))
GO
/*** CFDReportBuilderLog ***/
if not exists(select * from SysTabla where SysTabla = 'CFDReportBuilderLog')--Utilizar Report Builder REQ 16770
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDReportBuilderLog','N/A')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='CFDReportBuilderLog' and type ='U')
CREATE TABLE CFDReportBuilderLog(
	ID      int IDENTITY(1,1) NOT NULL,
	Modulo  varchar(20) NULL,
	ModuloID int NULL,
	Mensaje varchar(256) NULL,
CONSTRAINT PK_CFDReportBuilderLog PRIMARY KEY CLUSTERED(ID))
GO
/*** EmpresaCFDBuilder ***/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDBuilder')--Utilizar Report Builder REQ 16770
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDBuilder','N/A')
GO 
IF NOT EXISTS(SELECT * FROM sysobjects where name ='EmpresaCFDBuilder' and type ='U')
CREATE TABLE EmpresaCFDBuilder(
	Empresa	char(5) NOT NULL,
	Reporte  varchar(50) NOT NULL,
	Modulo   varchar(20) NOT NULL,
	Descripcion varchar(100) NULL,
CONSTRAINT PK_EmpresaCFDBuilder PRIMARY KEY CLUSTERED(Reporte,Modulo,Empresa))
GO

if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDFlex')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDFlex','Maestro')
GO 

/****** EmpresaCFDReporte ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDReporte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDReporte','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCFDReporte') and type = 'U') 
CREATE TABLE dbo.EmpresaCFDReporte (
	Empresa 		varchar(5) 	NOT NULL,
	Modulo			varchar(5)  NOT NULL,
	Mov				varchar(20) NOT NULL,
	
	Reporte			varchar(100) NULL,
    ReporteJasper	varchar(50)	 NULL,
    	
	CONSTRAINT priEmpresaCFDReporte PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO
EXEC spALTER_TABLE 'EmpresaCFDReporte', 'ReporteJasper', 'varchar(50) NULL'
GO

/****** CFDFlexPerfilDBMail ******/
if not exists(select * from SysTabla where SysTabla = 'CFDFlexPerfilDBMail')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexPerfilDBMail','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDFlexPerfilDBMail') and type = 'U') 
CREATE TABLE dbo.CFDFlexPerfilDBMail (
    NombrePerfil			varchar(50) NOT NULL,
    
    NombreCuenta			varchar(50) NULL,    
    Descripcion				varchar(100) NULL,
    CorreoElectronico		varchar(100) NULL,
    Usuario					varchar(100) NULL,
    Contrasena				varchar(50) NULL,
    Servidor				varchar(100) NULL,
    Puerto					int NOT NULL DEFAULT 25,
    ActivarSSL				bit NOT NULL DEFAULT 0,
    	
	CONSTRAINT priCFDFlexPerfilDBMail PRIMARY KEY  CLUSTERED (NombrePerfil)
)
GO

/****** CteEmpresaCFD  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEmpresaCFD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEmpresaCFD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEmpresaCFD') and type = 'U') 
CREATE TABLE dbo.CteEmpresaCFD (
	Cliente 		char(10) 	NOT NULL,
	Empresa			char(5)		NOT NULL,

	EmisorID		varchar(20)	NULL,
	ProveedorID		varchar(20)	NULL,
	InformacionCompra	varchar(10) 	NULL,

	CONSTRAINT priCteEmpresaCFD PRIMARY KEY  CLUSTERED (Cliente, Empresa)
)
go
EXEC spALTER_TABLE 'CteEmpresaCFD', 'InformacionCompra', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEmpresaCFD', 'InfoPago' ,'varchar(100) NULL'
EXEC spALTER_TABLE 'CteEmpresaCFD', 'InfoFormaPago' ,'varchar(50) NULL'
GO

/****** CteCFDFormaPago  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCFDFormaPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCFDFormaPago','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCFDFormaPago') and type = 'U') 
  CREATE TABLE dbo.CteCFDFormaPago (
    Empresa			varchar(5) NOT NULL,
	Cliente			varchar(10)	NOT NULL,
	FormaPago		varchar(50)NOT NULL,
	CuentaPago		varchar(20)NOT NULL,
	
	CONSTRAINT priCteCFDFormaPago PRIMARY KEY  CLUSTERED (Empresa, Cliente, FormaPago, CuentaPago)
)
GO

/****** CteCFD  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCFD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCFD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteCFD') and type = 'U') 
CREATE TABLE dbo.CteCFD (
	Cliente 		char(10) 	NOT NULL,

	EmisorID		varchar(20)	NULL,
	ReceptorID		varchar(20)	NULL,
	ProveedorID		varchar(20)	NULL,

	TipoAddenda		varchar(50)	NULL,	-- N/A, CHEDRAUI, EDIFACT, AMECE, LIVERPOOL
	Version			varchar(10)	NULL,
	VersionFecha		datetime	NULL,
	VersionAnterior		varchar(10)	NULL,
/** AR se agrego el campo XSL*/
	XSL			varchar(255)	NULL,
	Nombre			varchar(100)	NULL,		-- Movimiento / Folio
	Reporte			varchar(100)	NULL,

	Validar			bit		NULL		DEFAULT 0,
	ValidarTipo		varchar(20)	NULL,
	ValidarSchema		varchar(255)	NULL,

	Almacenar		bit		NULL		DEFAULT 0,
	AlmacenarTipo		varchar(20)	NULL,
	AlmacenarXML		bit		NULL		DEFAULT 0,
	AlmacenarPDF		bit		NULL		DEFAULT 0,
	AlmacenarRuta		varchar(255)	NULL,

	Enviar			bit		NULL		DEFAULT 0,
	EnviarTipo		varchar(20)	NULL,
	EnviarXML		bit		NULL		DEFAULT 0,
	EnviarPDF		bit		NULL		DEFAULT 0,
	EnviarMedio		varchar(20)	NULL,		-- FTP / SMTP
	EnviarDireccion		varchar(255)	NULL,		-- FTP / SMTP
	EnviarRuta		varchar(255)	NULL,		-- FTP	
	EnviarUsuario		varchar(100)	NULL,		-- FTP anonymous
	EnviarContrasena	varchar(100)	NULL,		-- FTP anonymous
	EnviarDe		varchar(100)	NULL,		-- SMTP (Usuario)
	EnviarAsunto		varchar(255)	NULL,		-- SMTP
	EnviarMensaje		varchar(255)	NULL,		-- SMTP

    CFDFlexEnviar		bit				NULL DEFAULT 0,	
	CFDFlexEnviarTipo	varchar(20)		NULL,
	Cta					varchar(20)		NULL,

	InfoPago			varchar(100)	NULL,
	InfoFormaPago		varchar(50)		NULL,

	CONSTRAINT priCteCFD PRIMARY KEY  CLUSTERED (Cliente)
)
GO
EXEC spALTER_TABLE 'CteCFD', 'Validar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'ValidarTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'ValidarSchema', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Almacenar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'AlmacenarTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'AlmacenarXML', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'AlmacenarPDF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'AlmacenarRuta', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Enviar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'EnviarTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarXML', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'EnviarPDF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCFD', 'EnviarMedio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Nombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Reporte', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarDireccion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarRuta', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarContrasena', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarDe', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarAsunto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EnviarMensaje', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'XSL', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CteCFD', 'CFDFlexEnviar', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'CteCFD', 'CFDFlexEnviarTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Cta' ,'varchar(20) NULL'
EXEC spALTER_TABLE 'CteCFD', 'InfoPago' ,'varchar(100) NULL'
EXEC spALTER_TABLE 'CteCFD', 'InfoFormaPago' ,'varchar(50) NULL'
GO

/****** CteCFDInfoPago  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCFDInfoPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCFDInfoPago','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCFDInfoPago') and type = 'U') 
  CREATE TABLE dbo.CteCFDInfoPago (
	Cliente			varchar(10)	NOT NULL,
	InfoPago		varchar(100)NOT NULL,
	
	CONSTRAINT priCteCFDInfoPago PRIMARY KEY  CLUSTERED (Cliente, InfoPago)
)
GO

/****** CteCFDInfoPagoD  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCFDInfoPagoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCFDInfoPagoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCFDInfoPagoD') and type = 'U') 
  CREATE TABLE dbo.CteCFDInfoPagoD (
	Cliente			varchar(10)	NOT NULL,
	InfoPago		varchar(100)NOT NULL,
	FormaPago		varchar(50)NOT NULL,
	CuentaPago		varchar(20)NOT NULL,
	
	CONSTRAINT priCteCFDInfoPagoD PRIMARY KEY  CLUSTERED (Cliente, InfoPago, FormaPago, CuentaPago)
)
GO

IF EXISTS(SELECT * FROM sysTabla WHERE SysTabla = 'CFD') AND NOT EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'CFD' AND Campo = 'Fecha')
  DROP TABLE dbo.CFD
GO

/****** CFD ******/
if not exists(select * from SysTabla where SysTabla = 'CFD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFD','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFD') and type = 'U') 
CREATE TABLE dbo.CFD (
	Modulo			char(5)		NOT NULL,
	ModuloID		int		NOT NULL,

	Fecha			datetime	NOT NULL,
	Ejercicio		int		NULL,
	Periodo			int		NULL,
	Empresa			char(5)		NULL,
	MovID			varchar(20)	NULL,
	Serie			varchar(10)	NULL,
        Folio			int		NULL,
	RFC			varchar(15)	NULL,
	Aprobacion		varchar(15)	NULL,
	Importe			money		NULL,
	Impuesto1		money		NULL,
	Impuesto2		money		NULL,
	
	Retencion1		money		NULL,
	Retencion2		money		NULL,
	
	FechaCancelacion	datetime	NULL,

	noCertificado		varchar(20)	NULL,
	Sello			varchar(8000)	NULL,
	CadenaOriginal		text		NULL,
	Documento			text		NULL,
	
	GenerarPDF			bit			NULL DEFAULT 0,
	Timbrado			bit			NULL DEFAULT 0,
	UUID				uniqueidentifier		NULL,
	FechaTimbrado		datetime				NULL,
	TipoCambio			float					NULL,  	
	SelloSAT			varchar(max)			NULL,
    TFDVersion			varchar(10)				NULL,
    noCertificadoSAT	varchar(20)				NULL,
	TFDCadenaOriginal	varchar(MAX)			NULL,	

	OrigenUUID			uniqueidentifier		NULL,
	OrigenSerie			varchar(10)				NULL,
	OrigenFolio			int						NULL,
	ParcialidadNumero	int						NULL,

	CONSTRAINT priCFD PRIMARY KEY  CLUSTERED (ModuloID, Modulo)
)
go
EXEC spALTER_TABLE 'CFD', 'FechaCancelacion', 'datetime	NULL'
GO
EXEC spADD_INDEX 'CFD', 'Fecha', 'Fecha, Empresa'
GO
EXEC spAlter_Table 'CFD', 'GenerarPDF', 'bit NULL DEFAULT 0'
EXEC spAlter_Table 'CFD', 'Retencion1', 'money NULL'
EXEC spAlter_Table 'CFD', 'Retencion2', 'money NULL'
EXEC spAlter_Table 'CFD', 'Timbrado',   'bit NULL DEFAULT 0'
EXEC spAlter_Table 'CFD', 'UUID', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CFD', 'FechaTimbrado', 'datetime NULL'
EXEC spAlter_Table 'CFD', 'TipoCambio', 'float NULL'
EXEC spAlter_Table 'CFD', 'SelloSAT', 'varchar(max) NULL'
EXEC spAlter_Table 'CFD', 'TFDVersion', 'varchar(10) NULL'
EXEC spAlter_Table 'CFD', 'noCertificadoSAT', 'varchar(20) NULL'
EXEC spAlter_Table 'CFD', 'TFDCadenaOriginal', 'varchar(MAX) NULL'
GO

EXEC spAlter_Table 'CFD', 'OrigenUUID', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CFD', 'OrigenSerie', 'varchar(10) NULL'
EXEC spAlter_Table 'CFD', 'OrigenFolio', 'int NULL'
EXEC spAlter_Table 'CFD', 'ParcialidadNumero', 'int NULL'
GO
--TASK 18994
EXEC spAlter_Table 'CFD', 'Cancelado',   'bit NULL DEFAULT 0'
EXEC spAlter_Table 'CFD', 'AcuseCancelado',   'text NULL'
EXEC spAlter_Table 'CFD', 'RutaAcuse',   'varchar(256) NULL'
EXEC spAlter_Table 'CFD', 'SelloCancelacionSAT', 'varchar(255) NULL'
EXEC spAlter_Table 'CFD', 'SelloCFD', 'varchar(255) NULL'
GO
EXEC spALTER_COLUMN 'CFD', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO
EXEC spADD_INDEX 'CFD', 'OrigenSerie', 'OrigenSerie, OrigenFolio, Modulo'
EXEC spADD_INDEX 'CFD', 'OrigenUUID', 'OrigenUUID'
GO
--BUG8490
EXEC spALTER_COLUMN 'CFD', 'SelloSAT', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFD', 'Sello', 'varchar(8000) NULL'
EXEC spALTER_COLUMN 'CFD', 'SelloCFD', 'varchar(max) NULL'
GO

--TASK 18994
/****** CFDFlex ******/
if exists(select * from sysobjects where id = object_id('dbo.CFDFlex') and type = 'V') 
  DROP VIEW CFDFlex
GO    
CREATE VIEW CFDFlex AS
SELECT
	CFD.Modulo,
	CFD.ModuloID,

	CFD.Fecha,
	CFD.Ejercicio,
	CFD.Periodo,
	CFD.Empresa,
	CFD.MovID,
	CFD.Serie,
    CFD.Folio,
	CFD.RFC,
	CFD.Aprobacion,
	CFD.Importe,
	CFD.Impuesto1,
	CFD.Impuesto2,
	CFD.FechaCancelacion,

	CFD.noCertificado,
	CFD.Sello,
	CFD.CadenaOriginal,
	CFD.Documento,
	Convert(varchar(50),CFD.UUID) UUIDTexto,
	Convert(varchar(50),CFD.OrigenUUID) OrigenUUIDTexto,
	CFD.GenerarPDF,
	CASE WHEN ISNULL(CFD.GenerarPDF,0) = 1 THEN 'CONCLUIDO' ELSE 'PENDIENTE' END Estatus,
	--CASE WHEN ISNULL(CFD.GenerarPDF,0) = 1 AND ISNULL(CFD.Cancelado,0) = 0 THEN 434 WHEN ISNULL(CFD.Cancelado,0) = 1 THEN 431 ELSE 435 END Icono,
	CASE WHEN ISNULL(CFD.Timbrado,0) = 1 AND ISNULL(CFD.Cancelado,0) = 0 THEN 434 WHEN ISNULL(CFD.Cancelado,0) = 1 THEN 431 ELSE 435 END Icono,
	CFD.Timbrado,
	CFD.UUID,
	CFD.FechaTimbrado,
	CASE CFD.Modulo
	  WHEN 'VTAS' THEN Venta.Estatus
	  WHEN 'COMS' THEN Compra.Estatus
	  WHEN 'CXC'  THEN Cxc.Estatus
	  WHEN 'CXP'  THEN Cxp.Estatus	  
	END EstatusMov,
	CFD.OrigenUUID,
	CFD.OrigenSerie,
	CFD.OrigenFolio,
	CFD.ParcialidadNumero,
	CFD.Cancelado,
	CFD.AcuseCancelado,
	CFD.RutaAcuse,
	CASE CFD.Modulo
	  WHEN 'VTAS' THEN Venta.Mov
	  WHEN 'COMS' THEN Compra.Mov
	  WHEN 'CXC'  THEN Cxc.Mov
	  WHEN 'CXP'  THEN Cxp.Mov	  
	END Mov,
	dbo.fnFechaSinHora(CFD.Fecha) FechaSinHora
FROM CFD	
LEFT OUTER JOIN Venta  ON 'VTAS' = CFD.Modulo AND Venta.ID  = CFD.ModuloID
LEFT OUTER JOIN Compra ON 'COMS' = CFD.Modulo AND Compra.ID = CFD.ModuloID
LEFT OUTER JOIN Cxc    ON 'CXC'  = CFD.Modulo AND Cxc.ID    = CFD.ModuloID
LEFT OUTER JOIN Cxp    ON 'CXP'  = CFD.Modulo AND Cxp.ID    = CFD.ModuloID

GO




/****** CFDEnviar ******/
if not exists(select * from SysTabla where SysTabla = 'CFDEnviar')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDEnviar','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDEnviar','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.CFDEnviar') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CFDEnviar (
	ID			int		NOT NULL IDENTITY(1,1),

	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Estatus			varchar(15)	NULL,
	ArchivoXML		varchar(255)	NULL,
	ArchivoPDF		varchar(255)	NULL,
	Medio			varchar(20)	NULL,		
	Direccion		varchar(255)	NULL,		
	Ruta			varchar(255)	NULL,		
	Usuario			varchar(100)	NULL,		
	Contrasena		varchar(100)	NULL,		
	De			varchar(100)	NULL,
	Para			varchar(255)	NULL,
	CC			varchar(255)	NULL,
	CCO			varchar(255)	NULL,
	Asunto			varchar(255)	NULL,		
	Mensaje			varchar(255)	NULL,		
	
	CONSTRAINT priCFDEnviar PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CFDEnviar'
END
GO
EXEC spADD_INDEX 'CFDEnviar', 'Modulo', 'ModuloID, Modulo'
EXEC spADD_INDEX 'CFDEnviar', 'Estatus', 'Estatus'
GO

EXEC spALTER_TABLE 'CFD', 'CadenaOriginal1', 'text NULL'
EXEC spALTER_TABLE 'CFD', 'CadenaOriginal2', 'text NULL'
EXEC spALTER_TABLE 'CFD', 'CadenaOriginal3', 'text NULL'
EXEC spALTER_TABLE 'CFD', 'CadenaOriginal4', 'text NULL'
EXEC spALTER_TABLE 'CFD', 'CadenaOriginal5', 'text NULL'
GO

/****** CFDFolio ******/
if not exists(select * from SysTabla where SysTabla = 'CFDFolio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFolio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CFDFolio') and type = 'U') 
  CREATE TABLE dbo.CFDFolio (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Modulo		char(5)		NULL,
	Mov		varchar(20)	NULL,
	Empresa		char(5)		NULL,
	Nivel		varchar(20)	NULL,	
	Sucursal	int		NULL,

	Serie		varchar(10)	NULL,
	FolioD		int		NULL,
	FolioA		int		NULL,
	Folio		int		NULL,
	noAprobacion	int		NULL,
	fechaAprobacion	datetime	NULL,
	Estatus		varchar(15)	NULL,

	CONSTRAINT priCFDFolio PRIMARY KEY CLUSTERED (ID)
)
GO
EXEC spALTER_TABLE 'CFDFolio', 'Nivel', 'varchar(20) NULL'
GO
EXEC spADD_INDEX 'CFDFolio', 'Folio', 'Folio, Serie, Mov, Modulo, Estatus, Empresa'
GO

/******************************* EmpresaCFD ***************************************/
EXEC spAlter_Table 'EmpresaCFD', 'RutaFirmaSAT', 'varchar(255)'
EXEC spAlter_Table 'EmpresaCFD', 'RutaCertificado', 'varchar(255)'
EXEC spAlter_Table 'EmpresaCFD', 'RutaTemporal', 'varchar(255)'
EXEC spAlter_Table 'EmpresaCFD', 'RutaANSIToUTF', 'varchar(255)'
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'Jasper', 'bit NULL DEFAULT 0 WITH VALUES' -- Utilizar Jasper Reports
EXEC spAlter_Table 'EmpresaCFD', 'RutaGenerarQRCode', 'varchar(255) NULL' --Pestaña Jasper Reports
EXEC spAlter_Table 'EmpresaCFD', 'RutaJasper', 'varchar(255) NULL' --Pestaña Jasper Reports
GO
EXEC spALTER_TABLE 'EmpresaCFD', 'NoValidarOrigenDocumento', 'bit NULL DEFAULT 0 WITH VALUES' -- No Validar Origen del Documento
GO
/******************************* CFD ***************************************/
EXEC spAlter_Table 'CFD', 'GenerarPDF', 'bit NULL DEFAULT 0'
GO

/******************************* MovTipo ***************************************/
EXEC spALTER_TABLE 'MovTipo', 'CFDReporteJasper', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'SAT_MN', 'bit NULL'
EXEC spALTER_TABLE 'MovTipo', 'CFDEsParcialidad', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/******************************* EmpresaCFDReporte ***************************************/
EXEC spALTER_TABLE 'EmpresaCFDReporte', 'ReporteJasper', 'varchar(50) NULL'
GO

/*************************** MovTipoCFDFlex **************************/
if not exists (select * from SysTabla where SysTabla = 'MovTipoCFDFlex') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoCFDFlex','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovTipoCFDFlex') and type = 'U') 
CREATE TABLE MovTipoCFDFlex
    (
	Modulo				varchar(5)		NOT NULL,
	Mov					varchar(20)		NOT NULL,
	Contacto				varchar(10)		NOT NULL,
	
	Comprobante			varchar(50)		NULL,
	Adenda				varchar(50)		NULL,
	Estatus				varchar(15)		NULL,
	XSD					varchar(50)		NULL,

	OrigenModulo		varchar(5)		NULL,
	OrigenMov			varchar(20)		NULL,
	
	CONSTRAINT priMovTipoCFDFlex PRIMARY KEY  CLUSTERED (Modulo, Mov, Contacto)
	)
GO

EXEC spAlter_Table 'MovTipoCFDFlex', 'Estatus', 'varchar(15)'
EXEC spAlter_Table 'MovTipoCFDFlex', 'OrigenModulo', 'varchar(5)'
EXEC spAlter_Table 'MovTipoCFDFlex', 'OrigenMov', 'varchar(20)'
GO

/*************************** MovTipoCFDFlexEstatus **************************/
if not exists (select * from SysTabla where SysTabla = 'MovTipoCFDFlexEstatus') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoCFDFlexEstatus','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovTipoCFDFlexEstatus') and type = 'U') 
CREATE TABLE MovTipoCFDFlexEstatus
    (
	Modulo				varchar(5)		NOT NULL,
	Mov					varchar(20)		NOT NULL,
	Contacto			varchar(10)		NOT NULL,
	Estatus				varchar(15)		NOT NULL,
	
	CONSTRAINT priMovTipoCFDFlexEstatus PRIMARY KEY CLUSTERED (Modulo, Mov, Contacto, Estatus)
	)
GO

EXEC spALTER_COLUMN 'MovTipoCFDFlexEstatus', 'Estatus', 'varchar(15) NOT NULL'
EXEC spALTER_PK 'MovTipoCFDFlexEstatus', 'Modulo, Mov, Contacto, Estatus'
GO

/*************************** CFDFlexAyuda **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDFlexAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexAyuda','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDFlexAyuda') and type = 'U') 
CREATE TABLE CFDFlexAyuda
    (
    Tipo				varchar(20)			NOT NULL,
    RID					int identity(1,1)	NOT NULL,
    
    Orden				int					NULL,
    Campo				varchar(100)		NULL,
    Descripcion			varchar(255)		NULL,
	
	CONSTRAINT priCFDFlexAyuda PRIMARY KEY  CLUSTERED (Tipo, RID)
	)
GO

DELETE FROM CFDFlexAyuda
GO
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 10, '<Movimiento>', 'Tipo de Movimiento')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 20, '<Serie>', 'Serie del Movimiento')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 30, '<Folio>', 'Folio del Movimiento')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 40, '<Cliente>', 'Clave del cliente')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 50, '<Ejercicio>', 'Ejercicio del Movimiento')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 50, '<Periodo>', 'Periodo del Movimiento')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 60, '<Empresa>', 'Clave de la Empresa')
INSERT CFDFlexAyuda (Tipo, Orden, Campo, Descripcion) VALUES ('Correo', 70, '<Sucursal>', 'Clave de la Sucursal')
GO


/*************************** ArchivoTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'ArchivoTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArchivoTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ArchivoTemp') and type = 'U') -- Bug 12306
CREATE TABLE ArchivoTemp
    (
    Estacion			int				NOT NULL,
	Datos				varchar(max)	NULL,
		
	CONSTRAINT priArchivoTemp PRIMARY KEY  CLUSTERED (Estacion)
	)
GO

/****** EmpresaCFDJasperReports ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCFDJasperReports')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCFDJasperReports','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCFDJasperReports') and type = 'U') 
CREATE TABLE dbo.EmpresaCFDJasperReports (
	Empresa 		char(5) 	NOT NULL,
	Reporte			varchar(50)	NOT	NULL,
	
	Descripcion		varchar(100)	NULL,
	Ruta			varchar(255)	NULL,
	RutaLogo		varchar(255)	NULL,
	Comentario1		varchar(255)	NULL,
	Comentario2		varchar(255)	NULL,	
	Comentario3		varchar(255)	NULL,
	Comentario4		varchar(255)	NULL,
	Comentario5		varchar(255)	NULL,
	Modulo			char(5)			NULL,
	PlantillaJasper	varchar(255)	NULL,
    	
	CONSTRAINT priEmpresaCFDJasperReports PRIMARY KEY  CLUSTERED (Empresa, Reporte)
)
GO
EXEC spAlter_Table 'EmpresaCFDJasperReports', 'Modulo', 'char(5) NULL' 
EXEC spAlter_Table 'EmpresaCFDJasperReports', 'PlantillaJasper', 'varchar(255) NULL' 
EXEC spAlter_Table 'EmpresaCFDJasperReports', 'Ruta', 'varchar(255) NULL' 
EXEC spAlter_Table 'EmpresaCFDJasperReports', 'RutaLogo', 'varchar(255) NULL' 
GO

/****** JasperTrabajo ******/
if not exists(select * from SysTabla where SysTabla = 'JasperTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('JasperTrabajo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.JasperTrabajo') and type = 'U') 
CREATE TABLE dbo.JasperTrabajo (
    Trabajo        		varchar(30) NOT NULL,

	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	datetime		NULL	DEFAULT GETDATE(),
	Activo				bit				NULL	DEFAULT 1,

	Modificar			bit				NULL	DEFAULT 0,


	HoraInicial			varchar(6)		NULL	DEFAULT '00:00',
	HoraFinal			varchar(6)		NULL	DEFAULT '23:59',
	Frecuencia			varchar (20)	NULL	DEFAULT 'Diaria',
	Valor				tinyint			NULL	DEFAULT 1,
	Recurrencia			tinyint			NULL	DEFAULT 1,
	FrecuenciaD			varchar (20)	NULL	DEFAULT 'Minutos',
	ValorD				tinyint			NULL	DEFAULT 30,
	
	Usuario    			varchar(30)		NULL	DEFAULT 'sa',
  	Contrasena  		varchar(30)		NULL	DEFAULT '',
  	
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		datetime		NULL    DEFAULT	GETDATE()
  	



    	CONSTRAINT priJasperTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO

IF NOT EXISTS (SELECT * FROM JasperTrabajo WHERE Trabajo = 'Jasper')
INSERT JasperTrabajo (Trabajo,	Nombre,   Descripcion)
VALUES				   ('Jasper', 'Jasper Reports', 'Jasper Reports')

/*************************** EmpresaRegimenFiscales **************************/
if not exists (select * from SysTabla where SysTabla = 'EmpresaRegimenFiscales') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaRegimenFiscales','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.EmpresaRegimenFiscales') and type = 'U') 
CREATE TABLE EmpresaRegimenFiscales
    (
	Empresa				varchar(5)		NOT NULL,
	FiscalRegimen		varchar(30)		NOT NULL,
	
	CONSTRAINT priEmpresaRegimenFiscales PRIMARY KEY  CLUSTERED (Empresa, FiscalRegimen)
	)
GO

/*************************** CFDFlexConcepto **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDFlexConcepto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexConcepto','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDFlexConcepto') and type = 'U') 
CREATE TABLE CFDFlexConcepto
    (
	Empresa				varchar(5)		NOT NULL,
	Modulo				varchar(5)		NOT NULL,
	Concepto		    varchar(50)		NOT NULL,
	FiscalRegimen		varchar(30)		NULL,
	
	CONSTRAINT priCFDFlexConcepto PRIMARY KEY  CLUSTERED (Empresa, Modulo, Concepto)
	)
GO

/****** CFDFlexSesion  ******/
if not exists(select * from SysTabla where SysTabla = 'CFDFlexSesion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexSesion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDFlexSesion') and type = 'U') 
  CREATE TABLE dbo.CFDFlexSesion (
	Estacion			int		NOT NULL,
	Modulo				char(5)	NOT NULL,
	ID					int		NOT NULL
	
	CONSTRAINT priCFDFlexSesion PRIMARY KEY  CLUSTERED (Estacion, Modulo, ID)
)
GO

/*************************** CFDFLexContratoAspel **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDFLexContratoAspel') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFLexContratoAspel','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDFLexContratoAspel') and type = 'U') 
CREATE TABLE CFDFLexContratoAspel
    (
    Estacion			int					NOT NULL,
	Contrato			varchar(max)	    NOT NULL,
	Aceptar				bit 				DEFAULT 0 
	)
GO

/****** CteEnviarACFD  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarACFD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEnviarACFD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarACFD') and type = 'U') 
CREATE TABLE dbo.CteEnviarACFD (
	Cliente 		char(10)NOT NULL,
	EnviarA			int		NOT NULL,

	ReceptorID		varchar(20)	NULL,	
	Cta				varchar(20) NULL,
	InfoPago		varchar(100) NULL,
	InfoFormaPago	varchar(50) NULL,
	
	CONSTRAINT priCteEnviarACFD PRIMARY KEY  CLUSTERED (Cliente, EnviarA)
)
GO


--REQ 15739
/*************************** CFDFlexTemp **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDFlexTemp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexTemp','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDFlexTemp') and type = 'U')
CREATE TABLE CFDFlexTemp
        (
        Estacion                int NULL,
        Empresa                 varchar(5)NULL,
        Modulo                  varchar(5)NULL,
        ID                      int    NULL,                      
        Estatus                 varchar(15) NULL,
        EstatusAnterior		varchar(15)NULL,
        Mov			varchar(20)NULL,
        MovID			varchar(20)NULL
	)
GO
--TASK 18994
IF NOT EXISTS(SELECT * FROM sysobjects where name ='RutaAcuse' and type ='U')
CREATE TABLE RutaAcuse(
	Estacion int NOT NULL,
	Ruta     varchar(256) NOT NULL,
	Acuse   text NOT NULL,
	Descripcion varchar(100) NULL,
CONSTRAINT priRutaAcuse PRIMARY KEY CLUSTERED(Estacion))
GO

/*************************** ErrorCFDFlex **************************/
if not exists (select * from SysTabla where SysTabla = 'ErrorCFDFlex') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ErrorCFDFlex','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ErrorCFDFlex') and type = 'U')
CREATE TABLE ErrorCFDFlex(
    ID		int		NOT NULL IDENTITY(1,1),
    Accion	char(20),
    Modulo	char(5),
    ModuloID  int,
    Ok		int,
    OkRef		varchar(255)
	)
GO