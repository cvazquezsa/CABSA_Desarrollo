SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
SET ANSI_DEFAULTS OFF
SET NOCOUNT ON
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
if not substring(@@version, 1, 25) in ('Microsoft SQL Server 2012','Microsoft SQL Server 2014','Microsoft SQL Server 2016')
EXEC sp_configure N'SQL Mail XPs', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO


EXEC spALTER_TABLE 'FormaPago', 'ClaveSAT', 'varchar(10) NULL'
GO

/**************** spDROP_CONSTRAINT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_CONSTRAINT') and type = 'P') drop procedure dbo.spDROP_CONSTRAINT
GO
CREATE PROCEDURE spDROP_CONSTRAINT
		   @Tabla 	varchar(100),
		   @Campo	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Constraint	sysname,
    @SQL	varchar(max)

  IF EXISTS (SELECT * FROM SysObjects, SysColumns, SysConstraints WHERE SysObjects.ID = SysColumns.ID AND SysObjects.ID = SysConstraints.ID AND SysColumns.ColID = SysConstraints.ColID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo)
  BEGIN
    SELECT @Constraint = OBJECT_NAME(ConstID) FROM SysObjects, SysColumns, SysConstraints WHERE SysObjects.ID = SysColumns.ID AND SysObjects.ID = SysConstraints.ID AND SysColumns.ColID = SysConstraints.ColID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo
    SELECT @SQL = 'ALTER TABLE ' + @Tabla + ' DROP CONSTRAINT ' + RTRIM(@Constraint)
    IF @SQL IS NOT NULL
      EXEC(@SQL)
  END
END
GO

--BUG22133
/********************* spDROP_COLUMN *****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_COLUMN') and type = 'p') drop procedure dbo.spDROP_COLUMN
GO
CREATE PROCEDURE spDROP_COLUMN
        @Tabla          sysname,
        @Campo          sysname,
        @Otros          sysname = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(max)

  IF EXISTS (SELECT * FROM SysObjects, SysColumns WHERE SysObjects.ID = SysColumns.ID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo)
  BEGIN
    EXEC spDROP_CONSTRAINT @Tabla, @Campo
    SELECT @SQL = 'ALTER TABLE ' + @Tabla + ' DROP COLUMN ' + RTRIM(@Campo)
    IF @SQL IS NOT NULL
      EXEC(@SQL)
  END

  RETURN
END
GO

/**************** spALTER_COLUMN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spALTER_COLUMN') and type = 'P') drop procedure dbo.spALTER_COLUMN
GO
CREATE PROCEDURE spALTER_COLUMN
		   @Tabla 	varchar(100),
		   @Campo	varchar(100),
		   @Extras	varchar(max),
		   @Default	varchar(max) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nombre	varchar(100)

  EXEC spDROP_CONSTRAINT @Tabla, @Campo
  EXEC('ALTER TABLE '+@Tabla+' ALTER COLUMN '+@Campo+' '+@Extras)

  IF NULLIF(RTRIM(@Default), '') IS NOT NULL
  BEGIN
    SELECT @Nombre = 'DF_'+@Tabla+'_'+@Campo+'_'+CONVERT(varchar, ColID) FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT '+@Nombre+' DEFAULT '+@Default+' FOR '+@Campo)
  END
END
GO

IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'Empresa' AND Campo='EsGuatemala')
BEGIN
  EXEC("ALTER TABLE Empresa ADD EsGuatemala AS CONVERT(bit,CASE RTRIM(Pais) WHEN 'Guatemala' THEN 1 ELSE 0 END)")
END
GO
EXEC spALTER_TABLE 'Empresa', 'FiscalRegimen', 'varchar(30) NULL' 
EXEC spALTER_TABLE 'EmpresaGral', 'CFDFlex', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD' , 'CFDIClaveRiesgo', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD' , 'NominaAlmacenarRuta', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD' , 'NominaNombre', 'varchar(100)	NULL DEFAULT ''<Personal> <Movimiento> <Serie><Folio>'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaTimbrarCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaIntelisisCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'TimeOutTimbrado', 'int NOT NULL DEFAULT 15000 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'TercerosTimbrar', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'NominaTimbrar', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'NominaEditarFechaPago', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Nomina', 'CFDTimbrado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaPersonal', 'RegistroPatronal', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Departamento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Puesto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'TipoContrato', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Jornada', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'SDIEstaNomina', 'money NULL'

EXEC spALTER_TABLE 'EmpresaCFD', 'RutaANSIToUTF', 'varchar(255) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIServidor', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIUsuario', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'TimbrarCFDIPassword', 'varchar(100) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaCertificado', 'varchar(255) NULL' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaGenerarQRCode', 'varchar(255) NULL' --Pestaña Jasper Reports
EXEC spALTER_TABLE 'EmpresaCFD', 'ContrasenaLlave', 'varchar(100) NULL'
GO

EXEC spALTER_TABLE 'CFD', 'SelloCancelacionSAT', 'varchar(max) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'RutaTimbrarCFDI', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'TimeOutTimbrado', 'int NOT NULL DEFAULT 15000 WITH VALUES'
EXEC spALTER_TABLE 'Empresa', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'CFD', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO
--BUG25925
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'noCertificado', 'varchar(20) NULL'
GO
--REQ21490
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIUsuario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIPassword', 'varchar(100) NULL'
GO
--
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarNomina', 'bit NULL	DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarXMLNomina', 'bit	NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarPDFNomina', 'bit	NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarAsuntoNomina', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'EnviarMensajeNomina', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'NominaEditarFechaPago', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--
EXEC spALTER_TABLE 'EmpresaCFD', 'UsarTimbrarNomina', 'bit	NULL DEFAULT 0'
EXEC spALTER_COLUMN 'CFD', 'SelloCancelacionSAT', 'varchar(max) NULL'
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
    CancelarCFDICuenta              varchar(100) NULL   

	CONSTRAINT priEmpresaCFDNomina PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'EmpresaCFDNomina', 'DireccionCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'ContrasenaCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'SmtpCorreo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'PuertoCorreo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCFDNomina', 'MedioEnvio', 'varchar(25) NULL'

/************************************************** Tablas **************************************************/
/****** CFDINominaVersion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaVersion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaVersion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaVersion') and type = 'U') 
CREATE TABLE dbo.CFDINominaVersion(
	Version				int,
	Fecha				datetime	NULL,
    FechaInstalacion	datetime	NULL	DEFAULT GETDATE(),
    
    CONSTRAINT priCFDINominaVersion PRIMARY KEY CLUSTERED(Version)
)
GO

/****** CFDINominaConceptoLista ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaConceptoLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaConceptoLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaConceptoLista') and type = 'U') 
CREATE TABLE dbo.CFDINominaConceptoLista(
	ID             int			IDENTITY (1,1),
	NominaConcepto varchar(50)	NULL,
	Concepto       varchar(50)	NULL,
	Empresa        varchar(5)	NULL,
	CONSTRAINT priCFDINominaConceptoLista PRIMARY KEY CLUSTERED(ID)
)
GO

/****** CFDINominaXMLPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaXMLPlantilla')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaXMLPlantilla','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaXMLPlantilla') and type = 'U') 
CREATE TABLE dbo.CFDINominaXMLPlantilla(
	Version			varchar(5)		NOT NULL,
	Plantilla		varchar(max)	NOT NULL,
	Vista			varchar(100)	NOT NULL,
	CONSTRAINT priCFDINominaXMLPlantilla PRIMARY KEY CLUSTERED(Version)
)
GO

EXEC spALTER_TABLE 'CFDINominaXMLPlantilla', 'VersionComprobante', 'varchar(5) NOT NULL DEFAULT ''3.2'' WITH VALUES'
GO

/****** CFDINominaXMLXSD ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaXMLXSD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaXMLXSD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaXMLXSD') and type = 'U') 
CREATE TABLE dbo.CFDINominaXMLXSD(
	Version			varchar(5)		NOT NULL,
	XSD				varchar(max)	NOT NULL,
	CONSTRAINT priCFDINominaXMLXSD PRIMARY KEY CLUSTERED(Version)
)
GO

/****** CFDINominaXMLCampo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaXMLCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaXMLCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaXMLCampo') and type = 'U') 
CREATE TABLE dbo.CFDINominaXMLCampo(
	Version			varchar(5)		NOT NULL,
	CampoXML		varchar(100)	NOT NULL,
	CampoVista		varchar(100)	NOT NULL,
	CONSTRAINT priCFDINominaXMLCampo PRIMARY KEY CLUSTERED(Version, CampoXML)
)
GO

/****** CFDINominaSATInstitucionFin ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaSATInstitucionFin')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaSATInstitucionFin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaSATInstitucionFin') and type = 'U') 
CREATE TABLE dbo.CFDINominaSATInstitucionFin (
	Clave			int,
	Nombre			varchar(100)
	CONSTRAINT priCFDINominaSATInstitucionFin PRIMARY KEY CLUSTERED(Clave)
)
GO

--BUG21416
/****** CFDINominaSATTipoRegimen ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaSATTipoRegimen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaSATTipoRegimen','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaSATTipoRegimen') and type = 'U') 
CREATE TABLE dbo.CFDINominaSATTipoRegimen(
	Clave			int,
	Nombre			varchar(255)
	CONSTRAINT priCFDINominaSATTipoRegimen PRIMARY KEY CLUSTERED(Clave)
)
GO

/****** CFDINominaInstitucionFin ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaInstitucionFin')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaInstitucionFin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaInstitucionFin') and type = 'U') 
CREATE TABLE dbo.CFDINominaInstitucionFin(
	Institucion		varchar(20)		NOT NULL,
	ClaveSAT		varchar(5)		NULL,
	CONSTRAINT priCFDINominaInstitucionFin PRIMARY KEY CLUSTERED(Institucion)
)
GO

EXEC spALTER_COLUMN 'CFDINominaInstitucionFin', 'ClaveSAT', 'int NULL'

--BUG21457
EXEC spALTER_COLUMN 'CFDINominaInstitucionFin', 'Institucion', 'varchar(50) NOT NULL'
GO

/****** CFDNomina ******/
if not exists(select * from SysTabla where SysTabla = 'CFDNomina')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDNomina','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDNomina') and type = 'U') 
CREATE TABLE CFDNomina(
	Modulo				char(5)				NOT NULL,
	ModuloID			int					NOT NULL,
	Personal			varchar(10)			NOT NULL,
	Fecha				datetime			NOT NULL,
	Ejercicio			int					NULL,
	Periodo				int					NULL,
	Empresa				char(5)				NULL,
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
	TipoCambio			float				NULL,  	
	SelloSAT			varchar(max)		NULL,
    TFDVersion			varchar(10)			NULL,
    noCertificadoSAT	varchar(20)			NULL,
	TFDCadenaOriginal	varchar(max)		NULL,	
	VersionCFD			varchar(5)			NULL,
	CONSTRAINT priCFDNomina PRIMARY KEY  CLUSTERED (ModuloID, Modulo, Personal)
)
GO

EXEC spALTER_TABLE 'CFDNomina', 'SelloCancelacionSAT', 'varchar(max) NULL'
EXEC spALTER_TABLE 'CFDNomina', 'Moneda', 'varchar(10) NULL'
EXEC spDROP_COLUMN 'CFDNomina', 'Serie'
EXEC spDROP_COLUMN 'CFDNomina', 'Folio'
EXEC spDROP_COLUMN 'CFDNomina', 'Aprobacion'
EXEC spDROP_COLUMN 'CFDNomina', 'Impuesto1'
EXEC spDROP_COLUMN 'CFDNomina', 'Impuesto2'
EXEC spDROP_COLUMN 'CFDNomina', 'Retencion1'
EXEC spDROP_COLUMN 'CFDNomina', 'Retencion2'
EXEC spDROP_COLUMN 'CFDNomina', 'GenerarPDF'
EXEC spALTER_TABLE 'CFDNomina', 'Cancelado', 'bit NULL'
EXEC spALTER_TABLE 'CFDNomina', 'AcuseCancelado', 'varchar(max) NULL'
EXEC spALTER_TABLE 'CFDNomina', 'RutaAcuse', 'varchar(200) NULL'

--BUG21377
EXEC spALTER_TABLE 'CFDNomina', 'NoTimbrado', 'int NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_COLUMN 'CFDNomina', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO
--BUG8490
EXEC spALTER_COLUMN 'CFDNomina', 'SelloSAT', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFDNomina', 'Sello', 'varchar(max) NULL'
GO

/****** CFDNominaCancelado ******/
if not exists(select * from SysTabla where SysTabla = 'CFDNominaCancelado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDNominaCancelado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDNominaCancelado') and type = 'U') 
CREATE TABLE CFDNominaCancelado(
    RID					int					IDENTITY,
	Modulo				char(5)				NOT NULL,
	ModuloID			int					NOT NULL,
	Personal			varchar(10)			NOT NULL,
	Fecha				datetime			NOT NULL,
	Ejercicio			int					NULL,
	Periodo				int					NULL,
	Empresa				char(5)				NULL,
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
	TipoCambio			float				NULL,  	
	SelloSAT			varchar(max)		NULL,
    TFDVersion			varchar(10)			NULL,
    noCertificadoSAT	varchar(20)			NULL,
	TFDCadenaOriginal	varchar(max)		NULL,	
	VersionCFD			varchar(5)			NULL,
	CONSTRAINT priCFDNominaCancelado PRIMARY KEY  CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'CFDNominaCancelado', 'SelloCancelacionSAT', 'varchar(max) NULL'
EXEC spALTER_TABLE 'CFDNominaCancelado', 'Moneda', 'varchar(10) NULL'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Serie'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Folio'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Aprobacion'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Impuesto1'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Impuesto2'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Retencion1'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'Retencion2'
EXEC spDROP_COLUMN 'CFDNominaCancelado', 'GenerarPDF'
EXEC spALTER_TABLE 'CFDNominaCancelado', 'Cancelado', 'bit NULL'
EXEC spALTER_TABLE 'CFDNominaCancelado', 'AcuseCancelado', 'varchar(max) NULL'
EXEC spALTER_TABLE 'CFDNominaCancelado', 'RutaAcuse', 'varchar(200) NULL'
EXEC spALTER_TABLE 'CFDNominaCancelado', 'FechaCancelacion', 'datetime NULL'
EXEC spALTER_COLUMN 'CFDNominaCancelado', 'SelloCancelacionSAT', 'varchar(max) NULL'
GO

--BUG21377
EXEC spALTER_TABLE 'CFDNominaCancelado', 'NoTimbrado', 'int NULL DEFAULT 1 WITH VALUES'
GO
--BUG8490
EXEC spALTER_COLUMN 'CFDNominaCancelado', 'SelloSAT', 'varchar(max) NULL'
EXEC spALTER_COLUMN 'CFDNominaCancelado', 'Sello', 'varchar(max) NULL'
GO

/****** CFDINominaRecibo ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaRecibo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaRecibo','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaRecibo') and type = 'U') 
CREATE TABLE dbo.CFDINominaRecibo(
    RID								int					IDENTITY,
	ID								int					NOT NULL,
	Personal						varchar(20)			NOT NULL,
	FolioSAT						uniqueidentifier	NULL,
	Version							varchar(5)			NULL,
	RegistroPatronal				varchar(20)			NULL,
	CURP							varchar(30)			NULL,
	TipoComprobante					varchar(20)			NULL,
	tipoRegimen						int					NULL,
	NumSeguridadSocial				varchar(30)			NULL,
	FechaPago						datetime			NULL,
	FechaInicialPago				datetime			NULL,
	FechaFinalPago					datetime			NULL,
	NumDiasPagados					int					NULL,
	Departamento					varchar(50)			NULL,
	CLABE							varchar(18)			NULL,
	Banco							varchar(5)			NULL,
	FechainicioRelLaboral			datetime			NULL,
	Antiguedad						int					NULL,
	Puesto							varchar(50)			NULL,
	TipoContrato					varchar(50)			NULL,
	TipoJornada						varchar(20)			NULL,
	PeriodicidadPago				varchar(20)			NULL,
	SalarioBaseCotApor				varchar(20)			NULL,
	RiesgoPuesto					varchar(20)			NULL,
	SalarioDiarioIntegrado			float				NULL,
	TotalPercepciones				float				NULL,			
	PercepcionesTotalGravado		float				NULL,
	PercepcionesTotalExcento		float				NULL,
	TotalDeducciones				float				NULL,	
	DeduccionesTotalGravado			float				NULL,
	DeduccionesTotalExcento			float				NULL,
	TotalDescuento					float				NULL,
	Timbrado						varchar(15)			NOT NULL DEFAULT 'No Timbrado',
	Documento						varchar(max)		NULL,		
	Ok								int					NULL,
	OkRef							varchar(255)		NULL,
    CONSTRAINT priCFDINominaRecibo PRIMARY KEY CLUSTERED(RID)
)
GO

EXEC spALTER_TABLE 'CFDINominaRecibo', 'RFCEmisor', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'RFC', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'Moneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'ArchivoPDF', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'ArchivoXML', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'ArchivoQRCode', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'PDFGenerado', 'varchar(15) NOT NULL DEFAULT ''No Generado'''
EXEC spALTER_TABLE 'CFDINominaRecibo', 'Importe', 'float NULL'
EXEC spDROP_COLUMN 'CFDINominaRecibo', 'FolioSAT'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'OkCancela', 'int NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'OkRefCancela', 'varchar(255) NULL'

--BUG21333
EXEC spALTER_TABLE 'CFDINominaRecibo', 'TotalDeduccionesSinISR', 'float NULL'
GO

--BUG22059
EXEC spALTER_TABLE 'CFDINominaRecibo', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'FormaPagoVales', 'varchar(10) NULL'
GO

--BUG22367
EXEC spALTER_COLUMN 'CFDINominaRecibo', 'NumDiasPagados', 'float NULL'
GO
--22871
EXEC spALTER_TABLE 'CFDINominaRecibo', 'EnviarMailSql', 'varchar(15) NOT NULL DEFAULT ''unset'''
EXEC spALTER_TABLE 'CFDINominaRecibo', 'EnviarMail', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaRecibo', 'mailitem_id', 'int NULL'
GO
/****** CFDINominaPercepcionDeduccion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaPercepcionDeduccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaPercepcionDeduccion','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaPercepcionDeduccion') and type = 'U') 
CREATE TABLE CFDINominaPercepcionDeduccion(
    RID						int			IDENTITY,
	ID						int			NOT NULL,
	Personal				varchar(20)	NOT NULL,
	Movimiento				varchar(20)	NULL,
	TipoSAT					varchar(15)	NULL,
	ClaveSAT				varchar(15)	NULL,
	Concepto				varchar(50)	NULL,
	ImporteGravado			float		NOT NULL DEFAULT 0.0,
	ImporteExcento			float		NOT NULL DEFAULT 0.0,
	CONSTRAINT priCFDINominaPercepcionDeduccion PRIMARY KEY CLUSTERED(RID)
)
GO

EXEC spALTER_COLUMN 'CFDINominaPercepcionDeduccion', 'TipoSAT', 'varchar(3)	NULL'
EXEC spALTER_COLUMN 'CFDINominaPercepcionDeduccion', 'ImporteGravado', 'float NULL', '0'
EXEC spALTER_COLUMN 'CFDINominaPercepcionDeduccion', 'ImporteExcento', 'float NULL', '0'
GO

/****** CFDINominaHoraExtra ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaHoraExtra')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaHoraExtra','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaHoraExtra') and type = 'U') 
CREATE TABLE CFDINominaHoraExtra(
    RID						int			IDENTITY,
	ID						int			NOT NULL,
	Personal				varchar(20)	NOT NULL,
	Dias					int			NULL,
	TipoHoras				varchar(10)	NULL,
	HorasExtra				float		NULL		DEFAULT 0.0,
	ImportePagado			float		NOT NULL	DEFAULT 0.0,
	CONSTRAINT priCFDINominaHoraExtra PRIMARY KEY CLUSTERED(RID)
)
GO

EXEC spALTER_COLUMN 'CFDINominaHoraExtra', 'ImportePagado', 'float NULL', '0'
GO

/****** CFDINominaIncapacidad ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaIncapacidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaIncapacidad','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaIncapacidad') and type = 'U') 
CREATE TABLE CFDINominaIncapacidad(
    RID						int			IDENTITY,
	ID						int			NOT NULL,
	Personal				varchar(20)	NOT NULL,
	Dias					int			NULL,
	TipoIncapacidad			int			NULL,
	Descuento				float		NOT NULL	DEFAULT 0.0,
	CONSTRAINT priCFDINominaIncapacidad PRIMARY KEY CLUSTERED(RID)
)
GO

EXEC spALTER_COLUMN 'CFDINominaIncapacidad', 'Descuento', 'float NULL', '0'
GO

/****** CFDINominaRetencion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaRetencion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaRetencion','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaRetencion') and type = 'U') 
CREATE TABLE CFDINominaRetencion(
    RID						int			IDENTITY,
	ID						int			NOT NULL,
	Personal				varchar(20)	NOT NULL,
	Concepto				varchar(50)	NOT NULL,
	Importe					float		NOT NULL	DEFAULT 0.0,
	CONSTRAINT priCFDINominaRetencion PRIMARY KEY CLUSTERED(RID)
)
GO

EXEC spALTER_COLUMN 'CFDINominaRetencion', 'Importe', 'float NULL', '0'
GO

/****** CFDINominaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaConcepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaConcepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaConcepto') and type = 'U') 
  CREATE TABLE CFDINominaConcepto(
    Concepto			varchar(50),
    ClaveSAT			varchar(15)		NULL,
    ConceptoSAT			varchar(50)		NULL,
    CONSTRAINT priCFDINominaConcepto PRIMARY KEY CLUSTERED (Concepto)
)
GO

EXEC spALTER_TABLE 'CFDINominaConcepto', 'CampoTotalizar', 'varchar(10) NOT NULL DEFAULT ''Importe'' WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDiasPagados', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgPercepcionesGravadas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgPercepcionesExcentas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDeduccionesGravadas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDeduccionesExcentas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgIncapacidad', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgHoraExtra', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgTipoHoraExtra', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgTipoIncapacidad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDescuento', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'TipoSAT', 'varchar(15)	NULL'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'TipoDeduccionSAT', 'varchar(15)	NULL'
EXEC spDROP_COLUMN 'CFDINominaConcepto', 'ConceptoSAT'
EXEC spALTER_COLUMN 'CFDINominaConcepto', 'TipoSAT', 'varchar(3)	NULL'
EXEC spALTER_COLUMN 'CFDINominaConcepto', 'TipoDeduccionSAT', 'varchar(3)	NULL'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgSDI', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDiasHorasDobles', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'CfgDiasHorasTriples', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaConcepto', 'EsValesDespensa', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDIToken', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaCFD', 'CancelarCFDICuenta', 'varchar(100) NULL'
GO

/****** CFDINominaMov ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaMov') and type = 'U') 
  CREATE TABLE CFDINominaMov(
    Mov					varchar(20),
    Version				varchar(5),
    tipoRegimen			varchar(20)		NULL,
    CONSTRAINT priCFDINominaMov PRIMARY KEY CLUSTERED (Mov)
)
GO

EXEC spALTER_TABLE 'CFDINominaMov', 'TipoComprobante', 'varchar(20) NOT NULL DEFAULT ''egreso'' WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaMov', 'Modulo', 'varchar(5) NOT NULL DEFAULT ''NOM'' WITH VALUES'
EXEC spALTER_TABLE 'CFDINominaMov', 'Reporte', 'varchar(100) NOT NULL DEFAULT ''CFDINominaRecibo'' WITH VALUES'

--BUG21498
EXEC spALTER_TABLE 'CFDINominaMov', 'ReporteMov', 'varchar(100) NOT NULL DEFAULT ''CFDINominaMovRecibo'' WITH VALUES'
GO

--BUG21416
EXEC spALTER_COLUMN 'CFDINominaMov', 'tipoRegimen', 'varchar(255) NULL'
GO

/****** CFDINominaRiesgoPuesto ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaRiesgoPuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaRiesgoPuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaRiesgoPuesto') and type = 'U') 
CREATE TABLE CFDINominaRiesgoPuesto(
  Clave				varchar(10),
  Descripcion		varchar(255)		NULL,
  CONSTRAINT priCFDINominaRiesgoPuesto PRIMARY KEY CLUSTERED (Clave)
)
GO

/****** CFDINominaTipoPercepcion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaTipoPercepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaTipoPercepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaTipoPercepcion') and type = 'U') 
CREATE TABLE CFDINominaTipoPercepcion(
  Clave				int,
  Descripcion		varchar(255)		NULL,
  CONSTRAINT priCFDINominaTipoPercepcion PRIMARY KEY CLUSTERED (Clave)
)
GO

/****** CFDINominaTipoDeduccion ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaTipoDeduccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaTipoDeduccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaTipoDeduccion') and type = 'U') 
CREATE TABLE CFDINominaTipoDeduccion(
  Clave				int,
  Descripcion		varchar(255)		NULL,
  CONSTRAINT priCFDINominaTipoDeduccion PRIMARY KEY CLUSTERED (Clave)
)
GO

--DROP Table CFDINominaDatosMov
/****** CFDINominaDatosMov ******/
if not exists(select * from SysTabla where SysTabla = 'CFDINominaDatosMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDINominaDatosMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CFDINominaDatosMov') and type = 'U') 
CREATE TABLE CFDINominaDatosMov(
	Estacion				int			NOT NULL,
	ID						int			NOT NULL,
	FechaPago				datetime	NULL, 
	CONSTRAINT priCFDINominaDatosMov PRIMARY KEY CLUSTERED(Estacion, ID)
)
GO
/************************************************** Vistas **************************************************/
/*** CFDINomina ***/
if exists (select * from sysobjects where id = object_id('dbo.CFDINomina') and type = 'V') drop view dbo.CFDINomina
GO
CREATE VIEW CFDINomina
--//WITH ENCRYPTION
AS
SELECT n.ID,
       d.Personal,
       pl.VersionComprobante					'version',
       --BUG22510
	   CONVERT(varchar(19),DATEADD(mi, -1, GETDATE()), 126) 'fecha', 
	   ISNULL(m.TipoComprobante, '')			'tipoDeComprobante',
	   'Pago en una sola exhibicion'			'formaDePago',
	   'CONTADO'								'condicionesDePago', 
	   --BUG22059
	   fp.ClaveSAT + CASE WHEN d.FormaPagoVales	IS NOT NULL THEN ','+d.FormaPagoVales ELSE '' END  'metodoDePago', 
	   CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalPercepciones, 0))) 'subTotal',
	   --BUG21333
       CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalDeduccionesSinISR, 0))) 'descuento', 
       'Deducciones nomina'						'motivoDescuento', 
       ISNULL(n.TipoCambio, 1)					'TipoCambio', 
       ISNULL(mon.Clave, 'MXN')					'Moneda', 
       --BUG21333
       CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalPercepciones, 0) - ISNULL(d.TotalDeduccionesSinISR, 0) - ISNULL(d.TotalDescuento, 0))) 'total', 
       ISNULL(s.Poblacion, '')					'LugarExpedicion',
       ISNULL(e.RFC, '')						'EmisorRFC',
       ISNULL(REPLACE(e.Nombre, '"', ''), '')	'EmisorNombre',
       ISNULL(e.Direccion, '')					'DomFiscalCalle',
       ISNULL(e.DireccionNumero, '0')			'DomFiscalNoExterior',
       ISNULL(e.DireccionNumeroInt, '0')		'DomFiscalNoInterior',
       ISNULL(e.Colonia, '')					'DomFiscalColonia',
       ISNULL(e.Poblacion, '')					'DomFiscalLocalidad',
       ISNULL(e.Delegacion, '')					'DomFiscalMunicipio',
       ISNULL(e.Estado, '')						'DomFiscalEstado',
       ISNULL(e.Pais, '')						'DomFiscalPais',
       ISNULL(e.CodigoPostal, '00000')			'DomFiscalCP',
       ISNULL(e.FiscalRegimen, '')				'RegimenFiscal',
       ISNULL(s.Direccion, '')					'ExpedidoEnCalle',
       ISNULL(s.DireccionNumero, '0')			'ExpedidoEnNoExterior',
       ISNULL(s.DireccionNumeroInt, '0')		'ExpedidoEnNoInterior',       
       ISNULL(s.Colonia, '')					'ExpedidoEnColonia',
       ISNULL(s.Poblacion, '')					'ExpedidoEnLocalidad',
       ISNULL(s.Delegacion, '')					'ExpedidoEnMunicipio',
       ISNULL(s.Estado, '')						'ExpedidoEnEstado',
       ISNULL(s.Pais, '')						'ExpedidoEnPais',
       ISNULL(s.CodigoPostal, '00000')			'ExpedidoEnCP',
       ISNULL(p.Registro2, '')					'ReceptorRFC',
       ISNULL(p.Nombre, '')+' '+ISNULL(p.ApellidoPaterno, '')+' '+ISNULL(p.ApellidoMaterno, '') 'ReceptorNombre',
       ISNULL(p.Direccion, '')					'ReceptorCalle',
       ISNULL(p.DireccionNumero, '0')			'ReceptorNoExterior',
       ISNULL(p.DireccionNumeroInt, '0')		'ReceptorNoInterior',              
       ISNULL(p.Colonia, '')					'ReceptorColonia',
       ISNULL(p.Poblacion, '')					'ReceptorLocalidad',
       ISNULL(p.Delegacion, '')					'ReceptorMunicipio',
       ISNULL(p.Estado, '')						'ReceptorEstado',
       ISNULL(p.Pais, '')						'ReceptorPais',
       ISNULL(p.CodigoPostal, '00000')			'ReceptorCP',
       1.0										'ConceptoCantidad',
       'SERVICIO'								'ConceptoUnidad',
       ''										'ConceptonoIdentificacion',
       'PAGO DE NOMINA'							'ConceptoDescripcion',
       CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalPercepciones, 0))) 'ConceptovalorUnitario',
       CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalPercepciones, 0))) 'Conceptoimporte',
       CONVERT(varchar(max), CONVERT(money, ISNULL(d.TotalDescuento, 0))) 'ImpuestoTotalRetenido',
       0.0										'ImpuestoTotalTrasladado',
	   CASE WHEN usarTimbrarnomina = 1 THEN ISNULL(ecfdn.noCertificado, '')	 ELSE ISNULL(ecfd.noCertificado, '')  END 'noCertificado',
	   ISNULL(ct.CLABE, '')                     'NumCtaPago'
  FROM Nomina n
  JOIN CFDINominaRecibo d ON n.ID = d.ID
  JOIN Empresa e ON n.Empresa = e.Empresa
  JOIN Sucursal s ON n.Sucursal = s.Sucursal  
  JOIN CFDINominaMov m ON n.Mov = m.Mov  
  LEFT OUTER JOIN EmpresaCFD ecfd ON e.Empresa = ecfd.Empresa
  LEFT OUTER JOIN EmpresaCFDNomina ecfdn ON e.Empresa = ecfdn.Empresa
  LEFT OUTER JOIN CFDINominaXMLPlantilla pl ON m.Version = pl.Version
  JOIN Personal p ON d.Personal = p.Personal
  LEFT OUTER JOIN CtaDinero ct ON p.CtaDinero = ct.CtaDinero
  JOIN Mon ON n.Moneda = Mon.Moneda
  LEFT OUTER JOIN FormaPago fp ON fp.FormaPago = d.FormaPago
GO

/************************************************** Registros **************************************************/
--BUG21416
IF NOT EXISTS(SELECT * FROM CFDINominaSATTipoRegimen)
BEGIN
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '2', 'Sueldos y salarios'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '3', 'Jubilados'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '4', 'Pensionados'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '5', 'Asimilados a salarios, Miembros de las Sociedades Cooperativas de Producción.'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '6', 'Asimilados a salarios, Integrantes de Sociedades y Asociaciones Civiles'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '7', 'Asimilados a salarios, Miembros de consejos directivos, de vigilancia, consultivos, honorarios a administradores, comisarios y gerentes generales.'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '8', 'Asimilados a salarios, Actividad empresarial (comisionistas)'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '9', 'Asimilados a salarios, Honorarios asimilados a salarios'
  INSERT INTO CFDINominaSATTipoRegimen(Clave, Nombre) SELECT '10', 'Asimilados a salarios, Ingresos acciones o títulos valor'
END
GO

IF NOT EXISTS(SELECT * FROM CFDINominaSATInstitucionFin)
BEGIN
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '002', 'BANAMEX'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '006', 'BANCOMEXT'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '009', 'BANOBRAS'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '012', 'BBVA BANCOMER'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '014', 'SANTANDER'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '019', 'BANJERCITO'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '021', 'HSBC'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '030', 'BAJIO'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '032', 'IXE'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '036', 'INBURSA'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '037', 'INTERACCIONES'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '042', 'MIFEL'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '044', 'SCOTIABANK'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '058', 'BANREGIO'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '059', 'INVEX'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '060', 'BANSI'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '062', 'AFIRME' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '072', 'BANORTE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '102', 'THE ROYAL BANK' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '103', 'AMERICAN EXPRESS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '106', 'BAMSA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '108', 'TOKYO' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '110', 'JP MORGAN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '112', 'BMONEX' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '113', 'VE POR MAS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '116', 'ING' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '124', 'DEUTSCHE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '126', 'CREDIT SUISSE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '127', 'AZTECA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '128', 'AUTOFIN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '129', 'BARCLAYS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '130', 'COMPARTAMOS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '131', 'BANCO FAMSA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '132', 'BMULTIVA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '133', 'ACTINVER' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '134', 'WAL-MART' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '135', 'NAFIN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '136', 'INTERBANCO' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '137', 'BANCOPPEL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '138', 'ABC CAPITAL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '139', 'UBS BANK' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '140', 'CONSUBANCO' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '141', 'VOLKSWAGEN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '143', 'CIBANCO' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '145', 'BBASE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '166', 'BANSEFI' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '168', 'HIPOTECARIA FEDERAL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '600', 'MONEXCB' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '601', 'GBM' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '602', 'MASARI' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '605', 'VALUE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '606', 'ESTRUCTURADORES' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '607', 'TIBER' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '608', 'VECTOR' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '610', 'B&B' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '614', 'ACCIVAL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '615', 'MERRILL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '616', 'FINAMEX' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '617', 'VALMEX' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '618', 'UNICA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '619', 'MAPFRE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '620', 'PROFUTURO' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '621', 'CB ACTINVER' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '622', 'OACTIN OPERADORA ACTINVER, S.A. DE C.V.' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '623', 'SKANDIA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '626', 'CBDEUTSCHE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '627', 'ZURICH' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '628', 'ZURICHVI' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '629', 'SU CASITA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '630', 'CB INTERCAM' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '631', 'CI BOLSA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '632', 'BULLTICK CB' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '633', 'STERLING' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '634', 'FINCOMUN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '636', 'HDI' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '637', 'ORDER' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '638', 'AKALA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '640', 'CB JPMORGAN' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '642', 'REFORMA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '646', 'STP Sistema de Transferencias y Pagos STP'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '647', 'TELECOMM' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '648', 'EVERCORE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '649', 'SKANDIA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '651', 'SEGMTY Seguros Monterrey New York Life'
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '652', 'ASEA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '653', 'KUSPIT' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '655', 'SOFIEXPRESS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '656', 'UNAGRA' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '659', 'OPCIONES EMPRESARIALES DEL NOROESTE' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '901', 'CLS' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '902', 'INDEVAL' 
  INSERT INTO CFDINominaSATInstitucionFin(Clave, Nombre) SELECT '670', 'LIBERTAD'
END
GO

DELETE CFDINominaXMLPlantilla WHERE Version = '1.1'
GO
IF NOT EXISTS(SELECT * FROM CFDINominaXMLPlantilla)
  INSERT INTO CFDINominaXMLPlantilla(Version, Vista, Plantilla) SELECT '1.1', 'CFDINomina', '<cfdi:Comprobante xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:nomina="http://www.sat.gob.mx/nomina" version="@Version" fecha="@Fecha" sello="" formaDePago="@FormaPago" noCertificado="@NoCertificado" certificado="" subTotal="@SubTotal" Moneda="@Moneda" total="@Total" descuento="@Descuento" tipoDeComprobante="@TipoComprobante" metodoDePago="@MetodoPago" LugarExpedicion="@LugarExpedicion" xsi:schemaLocation="http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/nomina http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina11.xsd" xmlns:cfdi="http://www.sat.gob.mx/cfd/3">
  <cfdi:Emisor rfc="@EmisorRFC" nombre="@EmisorNombre">
    <cfdi:DomicilioFiscal calle="@DomFiscalCalle" noExterior="@DomFiscalNoExterior" noInterior="@DomFiscalNoInterior" colonia="@DomFiscalColonia" localidad="@DomFiscalLocalidad" municipio="@DomFiscalMunicipio" estado="@DomFiscalEstado" pais="@DomFiscalPais" codigoPostal="@DomFiscalCP" />
    <cfdi:ExpedidoEn calle="@ExpedidoEnCalle" noExterior="@ExpedidoEnNoExterior" noInterior="@ExpedidoEnNoInterior" colonia="@ExpedidoEnColonia" localidad="@ExpedidoEnLocalidad" municipio="@ExpedidoEnMunicipio" estado="@ExpedidoEnEstado" pais="@ExpedidoEnPais" codigoPostal="@ExpedidoEnCodigoPostal" />
    <cfdi:RegimenFiscal Regimen="@RegimenFiscal" />
  </cfdi:Emisor>
  <cfdi:Receptor rfc="@ReceptorRFC" nombre="@ReceptorNombre">
    <cfdi:Domicilio calle="@ReceptorCalle" noExterior="@ReceptorNoExterior" noInterior="@ReceptorNoInterior" localidad="@ReceptorLocalidad" municipio="@ReceptorMunicipio" estado="@ReceptorEstado" pais="@ReceptorPais" codigoPostal="@ReceptorCodigoPostal" />
  </cfdi:Receptor>
  <cfdi:Conceptos>
    <cfdi:Concepto cantidad="@ConceptoCantidad" unidad="@ConceptoUnidad" descripcion="@ConceptoDescripcion" valorUnitario="@ConceptoValorUnitario" importe="@ConceptoImporte" />
  </cfdi:Conceptos>
  <cfdi:Impuestos totalImpuestosRetenidos="@ImpuestoTotalRetenido" >
    <cfdi:Retenciones>
      @Retenciones
    </cfdi:Retenciones>
  </cfdi:Impuestos>
  <cfdi:Complemento>
    @Complemento
  </cfdi:Complemento>
</cfdi:Comprobante>'
GO
--IF NOT EXISTS(SELECT * FROM CFDINominaXMLPlantilla)
--  INSERT INTO CFDINominaXMLPlantilla(Version, Vista, Plantilla) SELECT '1.1', 'CFDINomina', '<cfdi:Comprobante xmlns:nomina="http://www.sat.gob.mx/nomina" xmlns:cfdi="http://www.sat.gob.mx/cfd/3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sat.gob.mx/cfd/nomina/nomina11.xsd http://www.sat.gob.mx/sitio_internet/cfd/3/cfdv32.xsd http://www.sat.gob.mx/cfd/3 http://www.sat.gob.mx/nomina" version="@Version" fecha="@Fecha" tipoDeComprobante="@TipoComprobante" formaDePago="@FormaPago" condicionesDePago="@CondicionesPago" metodoDePago="@MetodoPago" noCertificado="@NoCertificado" subTotal="@SubTotal" descuento="@Descuento" motivoDescuento="@MotivoDescuento" TipoCambio="@TipoCambio" Moneda="@Moneda" total="@Total" LugarExpedicion="@LugarExpedicion" sello="" certificado="" >
--  <cfdi:Emisor rfc="@EmisorRFC" nombre="@EmisorNombre">
--    <cfdi:DomicilioFiscal calle="@DomFiscalCalle" noExterior="@DomFiscalNoExterior" colonia="@DomFiscalColonia" localidad="@DomFiscalLocalidad" municipio="@DomFiscalMunicipio" estado="@DomFiscalEstado" pais="@DomFiscalPais" codigoPostal="@DomFiscalCP" />
--    <cfdi:ExpedidoEn calle="@ExpedidoEnCalle" noExterior="@ExpedidoEnNoExterior" colonia="@ExpedidoEnColonia" localidad="@ExpedidoEnLocalidad" municipio="@ExpedidoEnMunicipio" estado="@ExpedidoEnEstado" pais="@ExpedidoEnPais" codigoPostal="@ExpedidoEnCodigoPostal" />
--    <cfdi:RegimenFiscal Regimen="@RegimenFiscal" />
--  </cfdi:Emisor>
--  <cfdi:Receptor rfc="@ReceptorRFC" nombre="@ReceptorNombre">
--    <cfdi:Domicilio calle="@ReceptorCalle" noExterior="@ReceptorNoExterior" localidad="@ReceptorLocalidad" municipio="@ReceptorMunicipio" estado="@ReceptorEstado" pais="@ReceptorPais" codigoPostal="@ReceptorCodigoPostal" />
--  </cfdi:Receptor>
--  <cfdi:Conceptos>
--    <cfdi:Concepto cantidad="@ConceptoCantidad" unidad="@ConceptoUnidad" descripcion="@ConceptoDescripcion" valorUnitario="@ConceptoValorUnitario" importe="@ConceptoImporte" />
--  </cfdi:Conceptos>
--  <cfdi:Impuestos totalImpuestosRetenidos="@ImpuestoTotalRetenido" >
--    <cfdi:Retenciones>
--      @Retenciones
--    </cfdi:Retenciones>
--  </cfdi:Impuestos>
--  <cfdi:Complemento>
--    @Complemento
--  </cfdi:Complemento>
--</cfdi:Comprobante>'
--GO

DELETE CFDINominaXMLXSD WHERE Version = '1.1'
GO
IF NOT EXISTS(SELECT * FROM CFDINominaXMLXSD)
BEGIN
  INSERT INTO CFDINominaXMLXSD(Version, XSD) SELECT '1.1', '<xs:schema xmlns:nomina="http://www.sat.gob.mx/nomina" xmlns:xs="http://www.w3.org/2001/XMLSchema" targetNamespace="http://www.sat.gob.mx/nomina" elementFormDefault="qualified" attributeFormDefault="unqualified">
	<xs:element name="Nomina">
		<xs:annotation>
			<xs:documentation>Complemento al Comprobante Fiscal Digital a través de Internet (CFDI) para el manejo de datos de Nómina.</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="Percepciones" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las percepciones aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Percepcion" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo para expresar la información detallada de una percepción</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="TipoPercepcion" use="required">
										<xs:annotation>
											<xs:documentation>Clave agrupadora. Clasifica la percepción conforme al catálogo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:int">
												<xs:minInclusive value="1"/>
												<xs:pattern value="[0-9]{3}"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Clave" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa la clave de percepción de nómina propia de la contabilidad de cada patrón, puede conformarse desde 3 hasta 15 caracteres</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="3"/>
												<xs:maxLength value="15"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Concepto" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la descripción del concepto de percepción</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="100"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ImporteGravado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe gravado de un concepto de percepción</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImporteExento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe exento de un concepto de percepción</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="TotalGravado" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de percepciones gravadas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="TotalExento" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de percepciones exentas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Deducciones" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las deducciones aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Deduccion" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo para expresar la información detallada de una deducción</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="TipoDeduccion" use="required">
										<xs:annotation>
											<xs:documentation>Clave agrupadora. Clasifica la deducción conforme al catálogo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:int">
												<xs:minInclusive value="1"/>
												<xs:pattern value="[0-9]{3}"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Clave" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la clave de deducción de nómina propia de la contabilidad de cada patrón, puede conformarse desde 3 hasta 15 caracteres</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="3"/>
												<xs:maxLength value="15"/>
												<xs:whiteSpace value="collapse"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="Concepto" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido para la descripción del concepto de deducción</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:minLength value="1"/>
												<xs:maxLength value="100"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="ImporteGravado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe gravado de un concepto de deducción</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImporteExento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Atributo requerido, representa el importe exento de un concepto de deducción</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
						<xs:attribute name="TotalGravado" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de deducciones gravadas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
						<xs:attribute name="TotalExento" type="nomina:t_Importe" use="required">
							<xs:annotation>
								<xs:documentation>Atributo requerido para expresar el total de deducciones exentas que se relacionan en el comprobante</xs:documentation>
							</xs:annotation>
						</xs:attribute>
					</xs:complexType>
				</xs:element>
				<xs:element name="Incapacidades" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las incapacidades aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Incapacidad" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo opcional para expresar información de las incapacidades</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="DiasIncapacidad" use="required">
										<xs:annotation>
											<xs:documentation>Número de días que el trabajador se incapacitó en el periodo</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:decimal">
												<xs:fractionDigits value="6"/>
												<xs:minInclusive value="1"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="TipoIncapacidad" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>Razón de la incapacidad: Catálogo publicado en el portal del SAT en internet</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="Descuento" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Monto del descuento por la incapacidad</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="HorasExtras" minOccurs="0">
					<xs:annotation>
						<xs:documentation>Nodo opcional para expresar las horas extras aplicables</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="HorasExtra" maxOccurs="unbounded">
								<xs:annotation>
									<xs:documentation>Nodo opcional para expresar información de las horas extras</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:attribute name="Dias" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>Número de días en que el trabajador realizó horas extra en el periodo</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="TipoHoras" use="required">
										<xs:annotation>
											<xs:documentation>Tipo de pago de las horas extra: dobles o triples</xs:documentation>
										</xs:annotation>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xs:whiteSpace value="collapse"/>
												<xs:enumeration value="Dobles"/>
												<xs:enumeration value="Triples"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
									<xs:attribute name="HorasExtra" type="xs:int" use="required">
										<xs:annotation>
											<xs:documentation>Número de horas extra trabajadas en el periodo</xs:documentation>
										</xs:annotation>
									</xs:attribute>
									<xs:attribute name="ImportePagado" type="nomina:t_Importe" use="required">
										<xs:annotation>
											<xs:documentation>Importe pagado por las horas extra</xs:documentation>
										</xs:annotation>
									</xs:attribute>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
			<xs:attribute name="Version" type="xs:string" use="required" fixed="1.1">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la versión del complemento</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="RegistroPatronal" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para expresar el registro patronal a 20 posiciones máximo</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="20"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="NumEmpleado" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para expresar el número de empleado de 1 a 15 posiciones</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="15"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="CURP" type="nomina:t_CURP" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la CURP del trabajador</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoRegimen" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la clave del régimen por el cual se tiene contratado al trabajador, conforme al catálogo publicado en el portal del SAT en internet</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="NumSeguridadSocial" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresión del número de seguridad social aplicable al trabajador</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="15"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FechaPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la fecha efectiva de erogación del gasto. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificación ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="FechaInicialPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la fecha inicial del pago. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificación ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="FechaFinalPago" type="xs:date" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión de la fecha final del pago. Se expresa en la forma aaaa-mm-dd, de acuerdo con la especificación ISO 8601.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="NumDiasPagados" use="required">
				<xs:annotation>
					<xs:documentation>Atributo requerido para la expresión del número de días pagados</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:decimal">
						<xs:fractionDigits value="6"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="Departamento">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresión del departamento o área a la que pertenece el trabajador</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="100"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="CLABE" type="nomina:t_Clabe">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresión de la CLABE </xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Banco">
				<xs:annotation>
					<xs:documentation>Atributo opcional para la expresión del Banco conforme al catálogo, donde se realiza un depósito de nómina</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
						<xs:pattern value="[0-9]{3}"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="FechaInicioRelLaboral" type="xs:date" use="optional">
				<xs:annotation>
					<xs:documentation>Atributo opcional para expresar la fecha de inicio de la relación laboral entre el empleador y el empleado</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Antiguedad" type="xs:int" use="optional">
				<xs:annotation>
					<xs:documentation>Número de semanas que el empleado ha mantenido relación laboral con el empleador</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="Puesto" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Puesto asignado al empleado o actividad que realiza</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoContrato" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Tipo de contrato que tiene el trabajador: Base, Eventual, Confianza, Sindicalizado, a prueba, etc.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="TipoJornada" type="xs:string" use="optional">
				<xs:annotation>
					<xs:documentation>Tipo de jornada que cubre el trabajador: Diurna, nocturna, mixta, por hora, reducida, continuada, partida, por turnos, etc.</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="PeriodicidadPago" use="required">
				<xs:annotation>
					<xs:documentation>Forma en que se establece el pago del salario: diario, semanal, quincenal, catorcenal mensual, bimestral, unidad de obra, comisión, precio alzado, etc.</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:string">
						<xs:minLength value="1"/>
						<xs:maxLength value="100"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="SalarioBaseCotApor" type="nomina:t_Importe" use="optional">
				<xs:annotation>
					<xs:documentation>Retribución otorgada al trabajador, que se integra por los pagos hechos en efectivo por cuota diaria, gratificaciones, percepciones, alimentación, habitación, primas, comisiones, prestaciones en especie y cualquiera otra cantidad o prestación que se entregue al trabajador por su trabajo</xs:documentation>
				</xs:annotation>
			</xs:attribute>
			<xs:attribute name="RiesgoPuesto" use="optional">
				<xs:annotation>
					<xs:documentation>Clave conforme a la Clase en que deben inscribirse los patrones, de acuerdo a las actividades que desempeñan sus trabajadores, según lo previsto en el artículo 196 del Reglamento en Materia de Afiliación Clasificación de Empresas, Recaudación y Fiscalización. Catálogo publicado en el portal del SAT en internet</xs:documentation>
				</xs:annotation>
				<xs:simpleType>
					<xs:restriction base="xs:int">
						<xs:minInclusive value="1"/>
					</xs:restriction>
				</xs:simpleType>
			</xs:attribute>
			<xs:attribute name="SalarioDiarioIntegrado" type="nomina:t_Importe" use="optional">
				<xs:annotation>
					<xs:documentation>Salario diario integrado</xs:documentation>
				</xs:annotation>
			</xs:attribute>
		</xs:complexType>
	</xs:element>
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
	<xs:simpleType name="t_Importe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar importes numéricos con fracción hasta seis decimales</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:decimal">
			<xs:fractionDigits value="6"/>
			<xs:whiteSpace value="collapse"/>
		</xs:restriction>
	</xs:simpleType>
	<xs:simpleType name="t_Clabe">
		<xs:annotation>
			<xs:documentation>Tipo definido para expresar la CLABE interbancaria</xs:documentation>
		</xs:annotation>
		<xs:restriction base="xs:integer">
			<xs:pattern value="[0-9]{18}"/>
		</xs:restriction>
	</xs:simpleType>
</xs:schema>
'  
END
GO

IF NOT EXISTS(SELECT * FROM CFDINominaMov)
  INSERT INTO CFDINominaMov(Mov, Version) SELECT Mov, '1.1' FROM MovTipo WHERE Modulo = 'NOM' AND Clave IN('NOM.N', 'NOM.NE')
GO

DELETE CFDINominaRiesgoPuesto
GO
IF NOT EXISTS(SELECT * FROM CFDINominaRiesgoPuesto)
BEGIN
  INSERT INTO CFDINominaRiesgoPuesto(Clave, Descripcion) SELECT '1', 'Clase I'
  INSERT INTO CFDINominaRiesgoPuesto(Clave, Descripcion) SELECT '2', 'Clase II'
  INSERT INTO CFDINominaRiesgoPuesto(Clave, Descripcion) SELECT '3', 'Clase III'
  INSERT INTO CFDINominaRiesgoPuesto(Clave, Descripcion) SELECT '4', 'Clase IV'
  INSERT INTO CFDINominaRiesgoPuesto(Clave, Descripcion) SELECT '5', 'Clase V'
END
GO

--BUG21293
DELETE CFDINominaTipoPercepcion
GO
IF NOT EXISTS(SELECT * FROM CFDINominaTipoPercepcion)
BEGIN
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '001', 'Sueldos, Salarios Rayas y Jornales'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '002', 'Gratificación Anual (Aguinaldo)'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '003', 'Participación de los Trabajadores en las Utilidades PTU'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '004', 'Reembolso de Gastos Médicos Dentales y Hospitalarios'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '005', 'Fondo de Ahorro'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '006', 'Caja de ahorro'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '009', 'Contribuciones a Cargo del Trabajador Pagadas por el Patrón'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '010', 'Premios por puntualidad'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '011', 'Prima de Seguro de vida'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '012', 'Seguro de Gastos Médicos Mayores'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '013', 'Cuotas Sindicales Pagadas por el Patrón'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '014', 'Subsidios por incapacidad'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '015', 'Becas para trabajadores y/o hijos'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '016', 'Otros'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '017', 'Subsidio para el empleo'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '019', 'Horas extra'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '020', 'Prima dominical'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '021', 'Prima vacacional'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '022', 'Prima por antigüedad'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '023', 'Pagos por separación'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '024', 'Seguro de retiro'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '025', 'Indemnizaciones'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '026', 'Reembolso por funeral'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '027', 'Cuotas de seguridad social pagadas por el patrón'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '028', 'Comisiones'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '029', 'Vales de despensa'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '030', 'Vales de restaurante'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '031', 'Vales de gasolina'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '032', 'Vales de ropa'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '033', 'Ayuda para renta'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '034', 'Ayuda para artículos escolares'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '035', 'Ayuda para anteojos'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '036', 'Ayuda para transporte'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '037', 'Ayuda para gastos de funeral'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '038', 'Otros ingresos por salarios'
  INSERT INTO CFDINominaTipoPercepcion(Clave, Descripcion) SELECT '039', 'Jubilaciones, pensiones o haberes de retiro'
END
GO

--BUG21293
DELETE CFDINominaTipoDeduccion
GO
IF NOT EXISTS(SELECT * FROM CFDINominaTipoDeduccion)
BEGIN
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '001', 'Seguridad social'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '002', 'ISR'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '003', 'Aportaciones a retiro, cesantía en edad avanzada y vejez.'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '004', 'Otros'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '005', 'Aportaciones a Fondo de vivienda'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '006', 'Descuento por incapacidad'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '007', 'Pensión alimenticia'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '008', 'Renta'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '009', 'Préstamos provenientes del Fondo Nacional de la Vivienda para los Trabajadores'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '010', 'Pago por crédito de vivienda'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '011', 'Pago de abonos INFONACOT'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '012', 'Anticipo de salarios'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '013', 'Pagos hechos con exceso al trabajador'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '014', 'Errores'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '015', 'Pérdidas'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '016', 'Averías'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '017', 'Adquisición de artículos producidos por la empresa o establecimiento'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '018', 'Cuotas para la constitución y fomento de sociedades cooperativas y de cajas de ahorro'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '019', 'Cuotas sindicales'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '020', 'Ausencia (Ausentismo)'
  INSERT INTO CFDINominaTipoDeduccion(Clave, Descripcion) SELECT '021', 'Cuotas obrero patronales'
END
GO

DELETE CFDINominaXMLCampo WHERE Version = '1.1'
GO
IF NOT EXISTS(SELECT * FROM CFDINominaXMLCampo)
BEGIN
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoCantidad', 'ConceptoCantidad'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoDescripcion', 'ConceptoDescripcion'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoImporte', 'Conceptoimporte'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoNoIdentificacion', 'ConceptonoIdentificacion'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoUnidad', 'ConceptoUnidad'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ConceptoValorUnitario', 'ConceptovalorUnitario'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@CondicionesPago', 'condicionesDePago'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@Descuento', 'descuento'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalCalle', 'DomFiscalCalle'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalColonia', 'DomFiscalColonia'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalCP', 'DomFiscalCP'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalEstado', 'DomFiscalEstado'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalLocalidad', 'DomFiscalLocalidad'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalMunicipio', 'DomFiscalMunicipio'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalNoExterior', 'DomFiscalNoExterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalNoInterior', 'DomFiscalNoInterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@DomFiscalPais', 'DomFiscalPais'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@EmisorNombre', 'EmisorNombre'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@EmisorRFC', 'EmisorRFC'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnCalle', 'ExpedidoEnCalle'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnCodigoPostal', 'ExpedidoEnCP'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnColonia', 'ExpedidoEnColonia'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnEstado', 'ExpedidoEnEstado'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnLocalidad', 'ExpedidoEnLocalidad'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnMunicipio', 'ExpedidoEnMunicipio'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnNoExterior', 'ExpedidoEnNoExterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnNoInterior', 'ExpedidoEnNoInterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ExpedidoEnPais', 'ExpedidoEnPais'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@Fecha', 'fecha'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@FormaPago', 'formaDePago'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ImpuestoTotalRetenido', 'ImpuestoTotalRetenido'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ImpuestoTotalTrasladado', 'ImpuestoTotalTrasladado'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@LugarExpedicion', 'LugarExpedicion'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@MetodoPago', 'metodoDePago'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@Moneda', 'Moneda'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@MotivoDescuento', 'motivoDescuento'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@noCertificado', 'noCertificado'  
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@NumCtaPago', 'NumCtaPago'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorCalle', 'ReceptorCalle'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorCodigoPostal', 'ReceptorCP'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorEstado', 'ReceptorEstado'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorLocalidad', 'ReceptorLocalidad'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorMunicipio', 'ReceptorMunicipio'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorNoExterior', 'ReceptorNoExterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorNoInterior', 'ReceptorNoInterior'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorNombre', 'ReceptorNombre'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorPais', 'ReceptorPais'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@ReceptorRFC', 'ReceptorRFC'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@RegimenFiscal', 'RegimenFiscal'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@SubTotal', 'subTotal'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@TipoCambio', 'TipoCambio'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@TipoComprobante', 'tipoDeComprobante'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@Total', 'total'
  INSERT INTO CFDINominaXMLCampo(Version, CampoXML, CampoVista) SELECT '1.1', '@Version', 'version'
END
GO

/************************************************** Procedimientos **************************************************/
--BUG22307
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

/**************** fnQuitarDoblesEspacios ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnQuitarDoblesEspacios') DROP FUNCTION fnQuitarDoblesEspacios
GO
CREATE FUNCTION fnQuitarDoblesEspacios (@Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltValor varchar(8000)

  SELECT @Valor = LTRIM(RTRIM(@Valor)), @UltValor = NULL
  WHILE @Valor <> @UltValor
  BEGIN
    SELECT @UltValor = @Valor
    SELECT @Valor = REPLACE(@Valor, '  ', ' ')
  END
  RETURN (@Valor)
END
GO

/**************** fnXMLValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLValor') DROP FUNCTION fnXMLValor
GO
CREATE FUNCTION fnXMLValor (@Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
/*
  SELECT @Valor = REPLACE(@Valor,'€', 'euros')
  SELECT @Valor = REPLACE(@Valor,'‚',',')
  SELECT @Valor = REPLACE(@Valor,'ƒ','')
  SELECT @Valor = REPLACE(@Valor,'„',',,')
  SELECT @Valor = REPLACE(@Valor,'…','...')
  SELECT @Valor = REPLACE(@Valor,'†','')
  SELECT @Valor = REPLACE(@Valor,'‡','')
  SELECT @Valor = REPLACE(@Valor,'ˆ','')
  SELECT @Valor = REPLACE(@Valor,'‰','0/00')
  SELECT @Valor = REPLACE(@Valor,'Š','')
  SELECT @Valor = REPLACE(@Valor,'‹','<')
  SELECT @Valor = REPLACE(@Valor,'Œ','OE')
  SELECT @Valor = REPLACE(@Valor,'‘',CHAR(39))
  SELECT @Valor = REPLACE(@Valor,'’',CHAR(39))
  SELECT @Valor = REPLACE(@Valor,'“',CHAR(34))
  SELECT @Valor = REPLACE(@Valor,'”',CHAR(34))
  SELECT @Valor = REPLACE(@Valor,'•','-')
  SELECT @Valor = REPLACE(@Valor,'–','-')
  SELECT @Valor = REPLACE(@Valor,'—','-')
  SELECT @Valor = REPLACE(@Valor,'˜','')
  SELECT @Valor = REPLACE(@Valor,'™','Trade Mark')
  SELECT @Valor = REPLACE(@Valor,'š','')
  SELECT @Valor = REPLACE(@Valor,'›','>')
  SELECT @Valor = REPLACE(@Valor,'œ','OE')
  SELECT @Valor = REPLACE(@Valor,'Ÿ','')
  SELECT @Valor = REPLACE(@Valor,'Ž','')
  SELECT @Valor = REPLACE(@Valor,'ž','')
  */
  
  SELECT @Valor = dbo.fnQuitarDoblesEspacios(@Valor)
  SELECT @Valor = NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Valor, '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), '"', '&quot;'), '''', '&#39;'))),'')
   
  RETURN (@Valor)
END
GO

/**************** fnRellenarConCaracter ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarConCaracter') DROP FUNCTION fnRellenarConCaracter
GO
CREATE FUNCTION fnRellenarConCaracter 
	(
	@Texto				varchar(100), 
	@Longitud				int,
	@Direccion				varchar(1),
	@Caracter				varchar(1)
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)
 IF @Direccion IN ('I','i') SELECT @Resultado = RIGHT(REPLICATE(@Caracter,(CASE WHEN @Longitud -LEN (@Texto) > 0 THEN @Longitud -LEN(@Texto) ELSE 0 END))+@Texto,@Longitud) ELSE
 IF @Direccion IN ('D','d') SELECT @Resultado = RIGHT(@Texto + REPLICATE(@Caracter,(@Longitud -LEN (@Texto))),@Longitud)
 
 RETURN (@Resultado)
  
END
GO

/**************** fnRellenarEspaciosDerecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarEspaciosDerecha ') DROP FUNCTION fnRellenarEspaciosDerecha 
GO
CREATE FUNCTION fnRellenarEspaciosDerecha 
	(
	@Numero				varchar(100), 
	@Longitud				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)

  SET @Numero =RTRIM(LTRIM(@Numero)) 
  SELECT  @Resultado =  dbo.fnRellenarConCaracter (@Numero,@Longitud,'d',' ')
RETURN (@Resultado)
END
GO

/**************** spOk_RAISERROR **************/
if exists (select * from sysobjects where id = object_id('dbo.spOk_RAISERROR') and type = 'P') drop procedure dbo.spOk_RAISERROR
GO
CREATE PROCEDURE spOk_RAISERROR
			@Ok	int,
			@OkRef	varchar(255)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Mensaje	varchar(255)

  IF @Ok NOT IN (NULL, 80030)
  BEGIN
    SELECT @Mensaje = RTRIM(ISNULL(Descripcion, ''))+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END
END
GO

/**************** fnRellenarConCaracter ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarConCaracter') DROP FUNCTION fnRellenarConCaracter
GO
CREATE FUNCTION fnRellenarConCaracter 
	(
	@Texto				varchar(100), 
	@Longitud				int,
	@Direccion				varchar(1),
	@Caracter				varchar(1)
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)
 IF @Direccion IN ('I','i') SELECT @Resultado = RIGHT(REPLICATE(@Caracter,(CASE WHEN @Longitud -LEN (@Texto) > 0 THEN @Longitud -LEN(@Texto) ELSE 0 END))+@Texto,@Longitud) ELSE
 IF @Direccion IN ('D','d') SELECT @Resultado = RIGHT(@Texto + REPLICATE(@Caracter,(@Longitud -LEN (@Texto))),@Longitud)
 
 RETURN (@Resultado)
  
END
GO

/**************** fnRellenarCerosIzquierda ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarCerosIzquierda') DROP FUNCTION fnRellenarCerosIzquierda
GO
CREATE FUNCTION fnRellenarCerosIzquierda 
	(
	@Numero				varchar(100), 
	@Longitud				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)

  SET @Numero =RTRIM(LTRIM(@Numero)) 
  SELECT  @Resultado =  dbo.fnRellenarConCaracter (@Numero,@Longitud,'I','0')
RETURN (@Resultado)
END
GO

/**************** spCFDIPersonalPropValor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDIPersonalPropValor') and type = 'P') drop procedure dbo.spCFDIPersonalPropValor
GO             
CREATE PROCEDURE spCFDIPersonalPropValor
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		varchar(50) OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(255)

  SELECT @Valor = NULL

  IF @Personal IS NOT NULL
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'PER' AND Cuenta = @Personal AND Propiedad = @Propiedad
  IF @Categoria IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'CAT' AND Cuenta = @Categoria AND Propiedad = @Propiedad
  IF @Puesto IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'PUE' AND Cuenta = @Puesto AND Propiedad = @Propiedad
  IF @Sucursal IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'SUC' AND Cuenta = CONVERT(varchar, @Sucursal) AND Propiedad = @Propiedad
  IF @Empresa IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @Empresa AND Propiedad = @Propiedad

  --IF NOT EXISTS(SELECT * FROM PersonalProp WHERE Propiedad = @Propiedad) AND @SinError = 0
  --BEGIN
  --  SELECT @Mensaje = '"'+REPLACE(@Propiedad,'%','%%')+'" '+RTRIM(Descripcion) FROM MensajeLista WHERE Mensaje = 10460
  --  RAISERROR (@Mensaje, 16, -1) 
  --END
  RETURN
END
GO

/******************************* tgNominaPersonalCFDI *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgNominaPersonalCFDI') AND TYPE = 'tr') DROP TRIGGER tgNominaPersonalCFDI
GO
CREATE TRIGGER tgNominaPersonalCFDI ON Nomina
FOR UPDATE
AS
BEGIN
  DECLARE @ID				int,
		  @IDAnt			int,
		  @Ok				int,
		  @OkRef			varchar(255),
		  @Mov				varchar(20),
		  @MovID			varchar(20),
		  @Personal			varchar(10),
		  --BUG22047
		  @PersonalAnt		varchar(10),
		  @SucursalTrabajo	int,
		  @Categoria		varchar(50),
		  @Puesto			varchar(50),
		  @Empresa			varchar(5),
		  @Valor			varchar(50),
		  @Version			int

  --BUG22047
  --SELECT @Version = Version FROM Version

  --IF @Version < 3500
  --BEGIN
    SELECT @IDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @ID = MIN(i.ID)
        FROM Inserted i
        JOIN Deleted d ON i.ID = d.ID
        JOIN MovTipo ON i.Mov = MovTipo.Mov AND MovTipo.Modulo = 'NOM' AND MovTipo.Clave IN('NOM.N', 'NOM.NA', 'NOM.NE', 'NOM.NC')
       WHERE i.Estatus =  'CONCLUIDO'
         AND d.Estatus <> 'CONCLUIDO'
         AND i.ID > @IDAnt
  
      IF @ID IS NULL BREAK
    
      SELECT @IDAnt = @ID
      
      SELECT @Empresa = Empresa FROM Nomina WHERE ID = @ID

      --BUG22047
      SELECT @PersonalAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Personal = MIN(Personal) 
          FROM NominaD
         WHERE NominaD.ID =  @ID
           AND NominaD.Personal > @PersonalAnt

        IF @Personal IS NULL BREAK
        
        SELECT @PersonalAnt = @Personal
        
        SELECT @SucursalTrabajo = SucursalTrabajo, @Categoria = Categoria, @Puesto = Puesto
          FROM Personal
          JOIN NominaD ON NominaD.Personal=Personal.Personal
         WHERE NominaD.ID =  @ID    
           AND Personal.Personal = @Personal
    
        SELECT @Valor = NULL
        EXEC spCFDIPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'REGISTRO PATRONAL', @Valor OUTPUT

        UPDATE NominaPersonal
           SET RegistroPatronal = @Valor,
               Departamento  = p.Departamento,
               Puesto   = p.Puesto,
               TipoContrato  = p.TipoContrato,
               Jornada   = p.Jornada,
               SDIEstaNomina = p.SDI
          FROM NominaPersonal n
          JOIN Personal p ON n.Personal = p.Personal
         WHERE n.ID = @ID        
           AND n.Personal = @Personal
      END
    END
  --END
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

/**************** spCFDINominaAnexoMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaAnexoMov') and type = 'P') drop procedure dbo.spCFDINominaAnexoMov
GO
CREATE PROC spCFDINominaAnexoMov 
			@ID					int, 
			@Sucursal			int,
			@Personal			varchar(10),
			@Ruta				varchar(255), 
			@ArchivoQRCode		varchar(255), 
			@ArchivoXML			varchar(255), 
			@ArchivoPDF			varchar(255), 
			@EsPDF				bit,
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @NomArchivoQRCode		varchar(255), 
		  @NomArchivoXML		varchar(255), 
		  @NomArchivoPDF		varchar(255)

  SELECT @Ruta = @Ruta + '\'
			
  SELECT @NomArchivoQRCode = REPLACE(@ArchivoQRCode, @Ruta, ''),
		 @NomArchivoXML	   = REPLACE(@ArchivoXML, @Ruta, ''),
		 @NomArchivoPDF	   = REPLACE(@ArchivoPDF, @Ruta, '')
			
  IF @EsPDF = 1
    IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'NOM' AND ID = @ID AND CFD = 1 AND Nombre = @NomArchivoPDF)
      INSERT AnexoMov (Sucursal, Rama,  ID,   Nombre,         Direccion,   Tipo,     Icono, CFD) 
              VALUES (@Sucursal, 'NOM', @ID, @NomArchivoPDF, @ArchivoPDF, 'Archivo', 745,   1)          
  
  IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'NOM' AND ID = @ID AND CFD = 1 AND Nombre = @NomArchivoXML)
    INSERT AnexoMov (Sucursal,  Rama,  ID,  Nombre,         Direccion,  Tipo,      Icono, CFD) 
            VALUES (@Sucursal, 'NOM', @ID, @NomArchivoXML, @ArchivoXML, 'Archivo', 17,    1)
  RETURN
END
GO

/**************** spCFDINominaGeneroPDF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaGeneroPDF') and type = 'P') drop procedure dbo.spCFDINominaGeneroPDF
GO
CREATE PROC spCFDINominaGeneroPDF
			@ID			int,
			@Personal	varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Sucursal			int,
		  @Ruta				varchar(255),
		  @ArchivoQRCode	varchar(255),
		  @ArchivoXML		varchar(255),
		  @ArchivoPDF		varchar(255),
		  @Ok				int,
		  @OkRef			varchar(255)
		  
  UPDATE CFDINominaRecibo SET PDFGenerado = 'Generado' WHERE ID = @ID AND Personal = @Personal

  SELECT @Sucursal = Sucursal FROM Nomina WHERE ID = @ID
  
  SELECT @ArchivoQRCode = ArchivoQRCode,
		 @ArchivoXML    = ArchivoXML,
		 @ArchivoPDF	= ArchivoPDF
	FROM CFDINominaRecibo
   WHERE ID = @ID 
     AND Personal = @Personal

  SELECT @Ruta = dbo.fnCFDINominaObtenerRuta(@ArchivoPDF)

  EXEC spCFDINominaAnexoMov @ID, @Sucursal, @Personal, @Ruta, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, 1, @Ok OUTPUT, @OkRef OUTPUT

  RETURN 
END
GO

--BUG22062
/**************** spCFDINominaRegenerarXML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaRegenerarXML') and type = 'P') drop procedure dbo.spCFDINominaRegenerarXML
GO
CREATE PROC spCFDINominaRegenerarXML
			@ID			int,
			@Personal	varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @ArchivoXML		varchar(255),
		  @Ok				int,
		  @OkRef			varchar(255),
		  @Sucursal			int,
		  @DatosXML			varchar(max),
		  @Ruta				varchar(255),
		  @NombreArchivo	varchar(255)

  SELECT @Sucursal = Sucursal FROM Nomina WHERE ID = @ID

  SELECT @ArchivoXML = ArchivoXML FROM CFDINominaRecibo WHERE ID = @ID AND Personal = @Personal
  
  SELECT @DatosXML = Documento FROM CFDNomina WHERE Modulo = 'NOM' AND ModuloID = @ID AND Personal = @Personal

  --BUG21377
  SELECT @Ruta = dbo.fnCFDINominaObtenerRuta(@ArchivoXML)+ '\'
  
  SELECT @NombreArchivo = REPLACE(@ArchivoXML, @Ruta, '')
    
  IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'NOM' AND ID = @ID AND CFD = 1 AND Direccion = @ArchivoXML)
    INSERT AnexoMov ( Sucursal,  Rama,  ID,  Nombre,         Direccion,  Tipo,      Icono, CFD) 
             VALUES (@Sucursal, 'NOM', @ID, @NombreArchivo, @ArchivoXML, 'Archivo', 17,   1)

  --BUG22156        
  EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
                     
  EXEC spRegenerarArchivo @ArchivoXML, @DatosXML, @Ok OUTPUT, @OkRef OUTPUT
  
  -- Mostrar el Estatus de la Afectacion
  SELECT NULL, NULL, NULL, NULL, NULL  
    
  RETURN 
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

/**************** xpCFDNominaAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCFDNominaAlmacenar') and type = 'P') drop procedure dbo.xpCFDNominaAlmacenar
GO             
CREATE PROCEDURE xpCFDNominaAlmacenar
			@Modulo			char(5),
			@ID				int,
			@XML			bit OUTPUT, 
			@PDF			bit OUTPUT,
			@NomArch		varchar(255) OUTPUT,
			@Reporte		varchar(100) OUTPUT,
			@Ruta			varchar(255) OUTPUT,
		    @EnviarPara		varchar(255) OUTPUT,
			@EnviarAsunto	varchar(255) OUTPUT,
			@EnviarMensaje	varchar(255) OUTPUT,
			@Cliente		varchar(10)  OUTPUT,
			@Sucursal		int OUTPUT,
			@Enviar			bit          OUTPUT,
			@EnviarXML		bit			 OUTPUT,
			@EnviarPDF		bit			 OUTPUT			
AS BEGIN
  RETURN
END
GO

--BUG21498
/**************** spCFDINominaMovPDF ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaMovPDF') and type = 'P') drop procedure dbo.spCFDINominaMovPDF
GO
CREATE PROC spCFDINominaMovPDF
			@ID			int,
			@Archivo	varchar(255)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Sucursal			int,
		  @Ruta				varchar(255),
		  @NomArchivoPDF	varchar(255),
		  @Ok				int,
		  @OkRef			varchar(255),
		  @Existe			int

  EXEC spVerificarArchivo @Archivo, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  

  IF @Ok IS NULL AND @Existe = 1
  BEGIN
    SELECT @Sucursal = Sucursal FROM Nomina WHERE ID = @ID
  
    SELECT @Ruta = dbo.fnCFDINominaObtenerRuta(@Archivo)

    SELECT @Ruta = @Ruta + '\'
  
    SELECT @NomArchivoPDF	= REPLACE(@Archivo, @Ruta, '')
 		 
    IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'NOM' AND ID = @ID AND CFD = 1 AND Nombre = @NomArchivoPDF)
      INSERT AnexoMov (Sucursal, Rama,  ID,   Nombre,         Direccion, Tipo,      Icono, CFD) 
              VALUES (@Sucursal, 'NOM', @ID, @NomArchivoPDF, @Archivo,   'Archivo', 745,   1)          
  END
  RETURN 
END
GO

--  EXEC spCFDNominaAlmacenar @Modulo, @ID, @Usuario, 0, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @Archivo OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Personal OUTPUT, @Sucursal OUTPUT , @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0
/**************** spCFDNominaAlmacenar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDNominaAlmacenar') and type = 'P') drop procedure dbo.spCFDNominaAlmacenar
GO
CREATE PROCEDURE spCFDNominaAlmacenar
			@Modulo			char(5),
			@ID				int,
			@AlmacenarXML	bit OUTPUT, 
			@AlmacenarPDF	bit OUTPUT,
			@NomArch		varchar(255) OUTPUT,
			@Reporte		varchar(100) OUTPUT,
			@Ruta			varchar(255) OUTPUT,
		    @EnviarPara		varchar(255) OUTPUT,
			@EnviarAsunto	varchar(255) OUTPUT,
			@EnviarMensaje	varchar(255) OUTPUT,
			@Personal		varchar(10)  OUTPUT,
			@Sucursal		int			 OUTPUT,
			@Enviar			bit          OUTPUT,
			@EnviarXML		bit          OUTPUT,
			@EnviarPDF		bit          OUTPUT,
			@Cancelacion	bit = 0,
			@NoTimbrado		int = 0
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Agente			char(10),
    @Mov			varchar(20),
    @MovID			varchar(20),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,    
    @ArchivoXML		varchar(255),
    @ArchivoPDF		varchar(255),
    @Nombre			varchar(100),
    @eMail			varchar(100),
    @Serie			varchar(20),
    @Folio			bigint,
    @AlmacenarTipo  varchar(20),
    @EnviarTipo		varchar(20)

  SELECT @EnviarXML = 0, @EnviarPDF = 0, @NomArch = NULL
  IF @Modulo = 'NOM' SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Mov = RTRIM(Mov), @MovID = RTRIM(MovID), @FechaEmision = FechaEmision, @FechaRegistro = FechaRegistro FROM Nomina WHERE ID = @ID
  
  SELECT @Reporte = NULLIF(Reporte,'') FROM CFDINominaMov WHERE Mov = @Mov

  SELECT @AlmacenarXML = AlmacenarXML, @AlmacenarPDF = AlmacenarPDF, @Ruta = NominaAlmacenarRuta, @Nombre = NominaNombre, @Enviar = CASE WHEN EnviarXML = 1 OR EnviarPDF = 1 THEN 1 ELSE 0 END,
         @EnviarXML = EnviarXML, @EnviarPDF = EnviarPDF, @EnviarAsunto = EnviarAsunto, @EnviarMensaje = EnviarMensaje
    FROM EmpresaCFD 
   WHERE Empresa = @Empresa 

  IF NULLIF(@EnviarTipo,'') IS NULL SET @EnviarTipo = 'Cliente'
 
  EXEC spMovIDEnSerieConsecutivo @MovID, @Serie OUTPUT, @Folio OUTPUT
  SELECT @NomArch = @Nombre 
  SELECT @NomArch = REPLACE(@NomArch, '<Movimiento>', LTRIM(RTRIM(ISNULL(@Mov,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Serie>', LTRIM(RTRIM(ISNULL(@Serie,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Folio>', CONVERT(varchar, LTRIM(RTRIM(ISNULL(@Folio,'')))))
  --SELECT @NomArch = REPLACE(@NomArch, '<Cliente>', LTRIM(RTRIM(ISNULL(@Cliente,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Personal>', LTRIM(RTRIM(ISNULL(@Personal,''))))  
  SELECT @NomArch = REPLACE(@NomArch, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @NomArch = REPLACE(@NomArch, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))
  --SELECT @NomArch = 'NOM_'+@Personal+'_'+@NomArch

  --BUG21377
  SELECT @NomArch = @NomArch + '_' +  CONVERT(varchar, ISNULL(@NoTimbrado, 1))
  
  --BUG21466
  IF @Cancelacion = 1
    SELECT @Nomarch = @NomArch+'_CANCELACION'

  SELECT @Ruta = REPLACE(@Ruta, '<Personal>', LTRIM(RTRIM(ISNULL(@Personal,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Ejercicio>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, YEAR(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Periodo>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, MONTH(GETDATE())),''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Empresa>', LTRIM(RTRIM(ISNULL(@Empresa,''))))
  SELECT @Ruta = REPLACE(@Ruta, '<Sucursal>', LTRIM(RTRIM(ISNULL(CONVERT(varchar, @Sucursal),''))))

  EXEC xpCFDNominaAlmacenar @Modulo, @ID, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, @EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, @Personal  OUTPUT, @Sucursal OUTPUT, @Enviar	OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT  
  IF RIGHT(@Ruta, 1) = '\' SELECT @Ruta = SUBSTRING(@Ruta, 1, LEN(@Ruta)-1)

  SELECT @EnviarPara = '',
         @EnviarAsunto  = REPLACE(@EnviarAsunto, '<Nombre>', @NomArch),
         @EnviarMensaje = REPLACE(@EnviarMensaje, '<Nombre>', @NomArch)

  SELECT @EnviarPara = email FROM Personal WHERE Personal = @Personal

  RETURN
END
GO

/*************** spCFDINominaCancelarTimbre *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaCancelarTimbre') and type = 'P') drop procedure dbo.spCFDINominaCancelarTimbre
GO
CREATE PROC spCFDINominaCancelarTimbre
			@Modulo						varchar(10),
			@ID							int,
			@Personal					varchar(10),
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
		  --BUG21237
		  @ModoPruebas				bit,		  
		  @NoTimbrado				int,
		  @TokenCanPAC				varchar(max),
		  @CuentaCanPAC				varchar(max),
		  @UsuarioCanPAC			varchar(50),
		  @PaswordCanPAC			varchar(50),
		  @RutaProvPac				varchar(max),
		  @UsarTimbrarNomina		bit

  SELECT @Fechatimbrado = CONVERT(varchar(20),FechaTimbrado,127), 
		 @UUID = CONVERT(varchar(50), UUID), 
		 @Documento = Documento, 
		 @SelloCancelacionSAT = SelloCancelacionSAT,
		 --BUG21377
		 @NoTimbrado = ISNULL(NoTimbrado, 1)
    FROM CFDNomina 
   WHERE Modulo = @Modulo 
     AND ModuloID = @ID 
     AND Personal = @Personal
  
  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  

    
   /***/
   SELECT @UsarTimbrarNomina=ISNULL(UsarTimbrarNomina,0),@RutaIntelisisCFDI = RutaIntelisisCFDI FROM EmpresaCFD WHERE Empresa = @Empresa
IF @UsarTimbrarNomina =0
SELECT 
		 
         @ServidorPAC = TimbrarCFDIServidor, 
         @UsuarioPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIUsuario ELSE TimbrarCFDIUsuario END, 
         @PaswordPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIPassword ELSE TimbrarCFDIPassword END,           
         @RutaCer = ISNULL(Certificado, RutaCertificado),
         @RutaKey = Llave, 
         @passKey = ContrasenaLlave,
         @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado),         
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,'')
		 FROM EmpresaCFD WHERE Empresa = @Empresa		 
ELSE 
SELECT 
         @ServidorPAC = TimbrarCFDIServidor, 

         @UsuarioPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIUsuario ELSE TimbrarCFDIUsuario END, 
         @PaswordPAC = CASE TimbrarCFDIServidor WHEN 'EKOMERCIO' THEN CancelarCFDIPassword ELSE TimbrarCFDIPassword END,           
         @RutaCer = Certificado, 
         @RutaKey = Llave, 
         @passKey = ContrasenaLlave,                 
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,'')
		 FROM EmpresaCFDNomina WHERE Empresa = @Empresa
   /***/ 
  IF @SelloCancelacionSAT IS NOT NULL
    SELECT @Ok = 71680, @OkRef = 'El Movimiento Ya Tiene Sello de Cancelacion CFDI'
	 
  SELECT @AccionCFDI = 'CANCELAR', @PswPFX = 'Intelisis1234567', @Cancelacion = 1

  --BUG21377
  EXEC spCFDNominaAlmacenar 'NOM', @ID, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, 
                                   @Asunto OUTPUT, @Mensaje OUTPUT, @Personal OUTPUT, @Sucursal OUTPUT, @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 
                                   @Cancelacion, @NoTimbrado

  --BUG22156
  EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
  
  SELECT @AlmacenarRuta =   @Ruta + '\' + @NomArch +'.xml'
  
  --BUG21377
  EXEC spIntelisisCFDICancelar @Modulo, @ID, @Estatus, @Empresa, @Sucursal, @RutaIntelisisCFDI, @Fechatimbrado, @ServidorPAC, @UsuarioPAC, 
							   @PaswordPAC, @AccionCFDI, @RutaCer, @RutaKey, @passKey, @UUID, @RFC, @Documento, 
							   @ModoPruebas, @AlmacenarRuta,0, @FirmaCancelacionSAT = @FirmaCancelacionSAT OUTPUT, @DatosXMl = @DatosXMl OUTPUT,
							   @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
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

/**************** spCFDINominaReporteD ****************/
if exists (select * from sysobjects where id = object_id('spCFDINominaReporteD') and type = 'P') drop procedure spCFDINominaReporteD
GO             
CREATE PROC spCFDINominaReporteD
			@ID				int,
			@Personal		varchar(20),
		    @Movimiento		varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Cadena	varchar(max),
		  @RID		int,
		  @RIDAnt	int

  SELECT @Cadena = ''
  CREATE TABLE #Cadena(RID  int IDENTITY, Cadena varchar(max)	NULL)  
  
  --BUG22395
  IF @Movimiento IN('Percepcion')
  BEGIN
    INSERT INTO #Cadena(Cadena)
    SELECT dbo.fnRellenarEspaciosDerecha(TipoSAT, 6)+
	       dbo.fnRellenarEspaciosDerecha(SUBSTRING(Concepto, 1, 30), 30)+
	       '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(ImporteExcento, 0)), 1), 16)+
	       '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(ImporteGravado, 0)), 1), 16)
      FROM CFDINominaPercepcionDeduccion
     WHERE ID = @ID 
       AND Personal = @Personal       
       AND Movimiento = @Movimiento    
  END
  IF @Movimiento IN('Deduccion')
  BEGIN
    INSERT INTO #Cadena(Cadena)
    SELECT dbo.fnRellenarEspaciosDerecha(TipoSAT, 6)+
	       --dbo.fnRellenarEspaciosDerecha(ClaveSAT, 5)+
	       dbo.fnRellenarEspaciosDerecha(SUBSTRING(Concepto, 1, 30), 32)+
	       '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(ImporteExcento, 0)), 1), 19)+
	       '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(ImporteGravado, 0)), 1), 15)
      FROM CFDINominaPercepcionDeduccion
     WHERE ID = @ID 
       AND Personal = @Personal       
       AND Movimiento = @Movimiento    
  END  
  ELSE IF @Movimiento IN('HorasExtra')
  BEGIN       
    INSERT INTO #Cadena(Cadena)
    SELECT dbo.fnRellenarEspaciosDerecha(Dias, 6)+
           dbo.fnRellenarEspaciosDerecha(HorasExtra, 7)+
           dbo.fnRellenarEspaciosDerecha(SUBSTRING(TipoHoras, 1, 25), 34)+
	       '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(ImportePagado, 0)), 1), 14)
      FROM CFDINominaHoraExtra
     WHERE ID = @ID 
       AND Personal = @Personal
  END
  ELSE IF @Movimiento IN('Incapacidad')
  BEGIN
    INSERT INTO #Cadena(Cadena)
    SELECT dbo.fnRellenarEspaciosDerecha(TipoIncapacidad, 6)+
           dbo.fnRellenarEspaciosDerecha(Dias, 45)+
           '$' + dbo.fnRellenarEspaciosDerecha(CONVERT(varchar, CONVERT(money, ISNULL(Descuento, 0)), 1), 14)
      FROM CFDINominaIncapacidad
     WHERE ID = @ID 
       AND Personal = @Personal
  END    
  SELECT @RIDAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM #Cadena
     WHERE RID > @RIDAnt
    
    IF @RID IS NULL BREAK
      
    SELECT @RIDAnt = @RID
      
    SELECT @Cadena = @Cadena+ISNULL(Cadena, '') + CHAR(13) FROM #Cadena WHERE RID = @RID
  END    
  SELECT @Cadena
END
GO

/******************************* tgNominaCFDI *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgNominaCFDI') AND TYPE = 'tr') DROP TRIGGER tgNominaCFDI
GO
CREATE TRIGGER tgNominaCFDI ON Nomina
FOR UPDATE
AS
BEGIN
  DECLARE @ID				int,
		  @IDAnt			int,
		  @NominaTimbrar	varchar(5),
		  @Ok				int,
		  @OkRef			varchar(255),
		  @Mov				varchar(20),
		  @MovID			varchar(20)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(i.ID)
      FROM Inserted i
      JOIN Deleted d ON i.ID = d.ID
     WHERE i.Estatus =  'CANCELADO'
       AND d.Estatus <> 'CANCELADO'
       AND i.ID > @IDAnt
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @NominaTimbrar = ISNULL(NominaTimbrar, 0) FROM EmpresaCFD JOIN Nomina ON Nomina.Empresa = EmpresaCFD.Empresa WHERE Nomina.ID = @ID
    
    IF ISNULL(@NominaTimbrar, 0) = 1 AND EXISTS(SELECT * FROM CFDNomina WHERE Modulo = 'NOM' AND ModuloID = @ID AND ISNULL(Timbrado, 0) = 1 AND ISNULL(Cancelado, 0) = 0)
    BEGIN
      SELECT @Mov = Mov, @MovID = MovID FROM Inserted WHERE ID = @ID
      
      SELECT @Ok = 60050, @OkRef = 'CFDI - ' + RTRIM(@Mov)+' '+RTRIM(@MovID)

      --BUG21422
      BEGIN TRY
        EXEC spOk_RAISERROR @Ok, @OkRef
      END TRY      
      BEGIN CATCH
        EXEC spOk_RAISERROR @Ok, @OkRef
        ROLLBACK TRAN
      END CATCH
	  RETURN
    END
  END
  RETURN
END
GO

/******************************* spCFDINominaGenerarXMLSchema *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDINominaGenerarXMLSchema') AND TYPE = 'P') DROP PROCEDURE spCFDINominaGenerarXMLSchema
GO
CREATE PROC spCFDINominaGenerarXMLSchema
			@Version		varchar(5)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @IDSQL		varchar(100),
		  @XSD			nvarchar(max),
		  @XMLSchema	nvarchar(max)

  SELECT @XSD = REPLACE(REPLACE(LTRIM(RTRIM(XSD)),CHAR(13),''),CHAR(10),'')
    FROM CFDINominaXMLXSD 
   WHERE Version = @Version

  SET @IDSQL = @Version
  
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

--IF NOT EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = '1.1')
--  EXEC spCFDINominaGenerarXMLSchema '1.1'
--GO

/************ spCFDINominaConceptoLista ************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spCFDINominaConceptoLista') AND type = 'P') DROP PROCEDURE spCFDINominaConceptoLista
GO
CREATE PROC spCFDINominaConceptoLista
			@Empresa			varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @NomAuto bit
  
  SELECT @NomAuto = NomAuto FROM Empresagral WHERE Empresa = @Empresa

  DELETE CFDINominaConceptoLista WHERE	Empresa = @Empresa

  IF @NomAuto=1
  BEGIN
    INSERT CFDINominaConceptoLista(
			 Empresa, NominaConcepto, Concepto)
     SELECT @Empresa, NominaConcepto, Concepto 
       FROM NominaConcepto nc
      GROUP BY NominaConcepto, Concepto 
      ORDER BY nc.Concepto
  END
  ELSE 
  BEGIN
    INSERT CFDINominaConceptoLista(
			 Empresa, NominaConcepto, Concepto)
     SELECT @Empresa, Concepto,       Concepto 
       FROM NomXPersonal nx
      GROUP BY Concepto
      ORDER BY nx.Concepto
	END
END
GO

/**************** spCFDINominaReciboD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaReciboD') and type = 'P') drop procedure dbo.spCFDINominaReciboD
GO
CREATE PROC spCFDINominaReciboD
			@Estacion		int,
			@ID				int,
			@Personal		varchar(10),
			@Ok				int			OUTPUT,
			@OkRef			varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @DiasHorasDobles		float,
		  @DiasHorasTriples		float

  SELECT @DiasHorasDobles = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     AND ISNULL(CfgDiasHorasDobles, 0) = 1

  SELECT @DiasHorasTriples = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     AND ISNULL(CfgDiasHorasTriples, 0) = 1

  --Percepciones Gravadas
  INSERT INTO CFDINominaPercepcionDeduccion(
          ID,   Personal, Movimiento,   TipoSAT,                   ClaveSAT,   Concepto, ImporteGravado)
  SELECT @ID, p.Personal, 'Percepcion', CONVERT(int, c.TipoSAT), c.ClaveSAT, c.Concepto, ISNULL(CASE c.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     --AND d.Movimiento = 'Percepcion'
     AND ISNULL(CfgPercepcionesGravadas, 0) = 1

  --Percepciones Excentas
  INSERT INTO CFDINominaPercepcionDeduccion(
          ID,   Personal, Movimiento,   TipoSAT,                   ClaveSAT,   Concepto, ImporteExcento)
  SELECT @ID, p.Personal, 'Percepcion', CONVERT(int, c.TipoSAT), c.ClaveSAT, c.Concepto, ISNULL(CASE c.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     --AND d.Movimiento = 'Percepcion'
     AND ISNULL(CfgPercepcionesExcentas, 0) = 1

  --Deducciones Gravadas
  INSERT INTO CFDINominaPercepcionDeduccion(
          ID,   Personal, Movimiento,  TipoSAT,                            ClaveSAT,   Concepto, ImporteGravado)
  SELECT @ID, p.Personal, 'Deduccion', CONVERT(int, c.TipoDeduccionSAT), c.ClaveSAT, c.Concepto, ISNULL(CASE c.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     --AND d.Movimiento = 'Deduccion'
     AND ISNULL(CfgDeduccionesGravadas, 0) = 1

  --Deducciones Excentas
  INSERT INTO CFDINominaPercepcionDeduccion(
          ID,   Personal, Movimiento,  TipoSAT,                            ClaveSAT,   Concepto, ImporteExcento)
  SELECT @ID, p.Personal, 'Deduccion', CONVERT(int, c.TipoDeduccionSAT), c.ClaveSAT, c.Concepto, ISNULL(CASE c.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     --AND d.Movimiento = 'Deduccion'
     AND ISNULL(CfgDeduccionesExcentas, 0) = 1

  --BUG22061
  --Horas Extra
  INSERT INTO CFDINominaHoraExtra(
          ID,   Personal,   TipoHoras,        HorasExtra,                                       ImportePagado,           Dias)
  SELECT @ID, p.Personal, c.CfgTipoHoraExtra, CONVERT(int, ROUND(SUM(ISNULL(Cantidad, 0)), 0)), SUM(ISNULL(Importe, 0)), CASE c.CfgTipoHoraExtra WHEN 'Dobles' THEN CONVERT(int, ROUND(@DiasHorasDobles, 0)) WHEN 'Triples' THEN CONVERT(int, ROUND(@DiasHorasTriples, 0)) END
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     AND ISNULL(CfgHoraExtra, 0) = 1
     AND ISNULL(Cantidad, 0) <> 0
   GROUP BY p.Personal, c.CfgTipoHoraExtra

  --Incapacidad
  INSERT INTO CFDINominaIncapacidad(
          ID,   Personal, Dias,     TipoIncapacidad,                                                                                                         Descuento)
  SELECT @ID, p.Personal, Cantidad, CASE c.CfgTipoIncapacidad WHEN 'Enfermedad General' THEN 2 WHEN 'Maternidad' THEN 3 WHEN 'Riesgo de Trabajo' THEN 1 END, ISNULL(Importe, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     AND ISNULL(CfgIncapacidad, 0) = 1
     
 --Retenciones
  INSERT INTO CFDINominaRetencion(
          ID,   Personal, Concepto,             Importe)
  SELECT @ID, p.Personal, 'ISR',/*d.Concepto, */ISNULL(Importe, 0)
    FROM Personal p
    JOIN NominaD d ON p.Personal = d.Personal
    JOIN Nomina  n ON n.ID = d.ID
    JOIN CFDINominaConcepto c ON d.Concepto = c.Concepto
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     AND ISNULL(CfgDescuento, 0) = 1
  RETURN
END
GO

/**************** spCFDINominaEditarMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaEditarMov') and type = 'P') drop procedure dbo.spCFDINominaEditarMov
GO
CREATE PROC spCFDINominaEditarMov
			@Estacion		int,
			@Empresa	varchar(10),
			@Usuario	varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
 
  DELETE CFDINominaDatosMov WHERE Estacion = @Estacion

  IF EXISTS(SELECT l.ID FROM ListaModuloID l JOIN Nomina n ON l.ID = n.ID  JOIN CFDINominaMov m ON n.Mov = m.Mov WHERE l.Estacion = @Estacion)
  BEGIN
    IF NOT EXISTS( SELECT ID FROM CFDINominaDatosMov WHERE Estacion = @Estacion)
      INSERT CFDINominaDatosMov (ID, Estacion) 
      SELECT l.ID, l.Estacion 
	    FROM ListaModuloID l
        JOIN Nomina n ON l.ID = n.ID
        JOIN CFDINominaMov m ON n.Mov = m.Mov
       WHERE l.Estacion = @Estacion
  END

END    
GO


/**************** spCFDINominaRecibo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaRecibo') and type = 'P') drop procedure dbo.spCFDINominaRecibo
GO
CREATE PROC spCFDINominaRecibo
			@Estacion					int,
			@ID							int,
			@Personal					varchar(10),
			--BUG21598
			@Empresa					varchar(5),
		    @TotalPercepciones			float		OUTPUT,
		    @TotalDeducciones			float		OUTPUT,
		    @PercepcionesTotalGravado	float		OUTPUT,
		    @PercepcionesTotalExcento	float		OUTPUT,
		    @DeduccionesTotalGravado	float		OUTPUT,
		    @DeduccionesTotalExcento	float		OUTPUT,
            @TotalDescuento				float		OUTPUT,
            @Importe					float		OUTPUT,
            --BUG21333
            @TotalDeduccionesSinISR		float		OUTPUT,
            @Ok							int			OUTPUT,
            @OkRef						varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @NumDiasPagados			float,
		  @Hoy						datetime,
		  @SDI						float,
		  --BUG21598
		  @SucursalTrabajo			int, 
		  @Categoria				varchar(50), 
		  @Puesto					varchar(50),
		  @ClaveRiesgo				varchar(50),
		  @NominaEditarFechaPago	bit
 
SELECT @NominaEditarFechaPago = NominaEditarFechaPago FROM EmpresaCFD WHERE Empresa = @Empresa
  
  SELECT @SucursalTrabajo = SucursalTrabajo, @Categoria = Categoria, @Puesto = Puesto FROM Personal WHERE Personal = @Personal
  SELECT @Hoy = GETDATE()

  --BUG22367
  SELECT @NumDiasPagados = ROUND(ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0), 2)  
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     AND ISNULL(CfgDiasPagados, 0) = 1
     
  SELECT @SDI = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     AND ISNULL(CfgSDI, 0) = 1     

  SELECT @PercepcionesTotalGravado = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     --AND n.Movimiento = 'Percepcion'     
     AND ISNULL(CfgPercepcionesGravadas, 0) = 1
     
  SELECT @PercepcionesTotalExcento = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     --AND n.Movimiento = 'Percepcion'     
     AND ISNULL(CfgPercepcionesExcentas, 0) = 1
     
  SELECT @DeduccionesTotalGravado = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     --AND n.Movimiento = 'Deduccion'
     AND ISNULL(CfgDeduccionesGravadas, 0) = 1
     
  SELECT @DeduccionesTotalExcento = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     --AND n.Movimiento = 'Deduccion'
     AND ISNULL(CfgDeduccionesExcentas, 0) = 1          
   
  SELECT @TotalDescuento = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     AND ISNULL(CfgDescuento, 0) = 1
  
  --BUG21333
  SELECT @TotalDeduccionesSinISR = ISNULL(SUM(CASE co.CampoTotalizar WHEN 'Importe' THEN ISNULL(Importe, 0) WHEN 'Cantidad' THEN ISNULL(Cantidad, 0) END), 0)
    FROM NominaD n
    JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
   WHERE n.ID = @ID 
     AND n.Personal = @Personal
     --AND n.Movimiento = 'Deduccion'
     AND (ISNULL(CfgDeduccionesGravadas, 0) = 1 OR ISNULL(CfgDeduccionesExcentas, 0) = 1)
     AND ISNULL(CfgDescuento, 0) = 0

  SELECT @TotalDeducciones = ISNULL(@DeduccionesTotalExcento, 0)  + ISNULL(@DeduccionesTotalGravado, 0),
         @TotalPercepciones= ISNULL(@PercepcionesTotalExcento, 0) + ISNULL(@PercepcionesTotalGravado, 0)

  SELECT @Importe = @TotalPercepciones - @TotalDeducciones

  --BUG21598
  EXEC spCFDIPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'CLAVE RIESGO', @ClaveRiesgo OUTPUT

  --BUG21333 BUG21416 BUG21432 BUG21457 BUG21419 BUG21598 BUG22059
  INSERT INTO CFDINominaRecibo(
          ID,   Moneda,   Personal,   Version,    RegistroPatronal,   CURP,        RFCEmisor,   RFC,          tipoRegimen,   NumSeguridadSocial,   FechaPago,    FechaInicialPago,                                              FechaFinalPago,  NumDiasPagados,    Departamento, CLABE,                                              Banco,                                           FechainicioRelLaboral, Antiguedad,                                 Puesto,    TipoContrato,    TipoJornada,   PeriodicidadPago,  SalarioBaseCotApor, RiesgoPuesto,                               SalarioDiarioIntegrado,  TotalPercepciones,  PercepcionesTotalGravado,  PercepcionesTotalExcento,  TotalDeducciones,  DeduccionesTotalGravado,  DeduccionesTotalExcento,  TotalDescuento,   TipoComprobante,  Importe,  TotalDeduccionesSinISR,    FormaPago)
  SELECT @ID, n.Moneda, p.Personal, m.Version, np.RegistroPatronal, p.Registro, em.RFC,       p.Registro2, tr.Clave,       p.Registro3,          n.FechaEmision, CASE mt.Clave WHEN 'NOM.NA' THEN d.FechaD ELSE n.FechaD END, n.FechaA,         @NumDiasPagados, np.Departamento, dbo.fnRellenarCerosIzquierda(p.PersonalCuenta, 18), dbo.fnRellenarCerosIzquierda(ins.ClaveSAT, 3), p.FechaAntiguedad,       DATEDIFF(Week, p.FechaAntiguedad, @Hoy), np.Puesto, np.TipoContrato, np.Jornada,     p.PeriodoTipo,      @SDI,                ISNULL(@ClaveRiesgo, e.CFDIClaveRiesgo), np.SDIEstaNomina,          @TotalPercepciones, @PercepcionesTotalGravado, @PercepcionesTotalExcento, @TotalDeducciones, @DeduccionesTotalGravado, @DeduccionesTotalExcento, @TotalDescuento, m.TipoComprobante, @Importe, @TotalDeduccionesSinISR, np.FormaPago
    FROM Personal p
    JOIN NominaPersonal np ON p.Personal = np.Personal AND np.ID = @ID
    JOIN Nomina n ON np.ID = n.ID
    --BUG21432
    JOIN NominaD d ON n.ID = d.ID AND d.Personal = p.Personal AND d.Personal = np.Personal AND d.ID = @ID
    JOIN MovTipo mt ON n.Mov = mt.Mov AND mt.Modulo = 'NOM'
    JOIN Empresa em ON n.Empresa = em.Empresa
    LEFT OUTER JOIN EmpresaCFD e ON n.Empresa = e.Empresa
    JOIN CFDINominaMov m ON n.Mov = m.Mov
    --BUG21457
    --LEFT OUTER JOIN CtaDinero cta ON p.CtaDinero = cta.CtaDinero
    LEFT OUTER JOIN CFDINominaInstitucionFin ins ON p.PersonalSucursal = ins.Institucion
    LEFT OUTER JOIN CFDINominaSATTipoRegimen tr ON m.tipoRegimen = tr.Nombre
   WHERE P.Personal = @Personal
     AND n.ID = @ID
     --BUG21457 BUG21740
  GROUP BY n.Moneda, p.Personal, m.Version, np.RegistroPatronal, p.Registro, em.RFC, p.Registro2, tr.Clave, p.Registro3, n.FechaEmision, 
		   mt.Clave, d.FechaD, n.FechaD, n.FechaA, np.Departamento, p.PersonalCuenta, ins.ClaveSAT, p.FechaAntiguedad, np.Puesto, 
		   np.TipoContrato, np.Jornada, p.PeriodoTipo, e.CFDIClaveRiesgo, np.SDIEstaNomina, m.TipoComprobante, np.FormaPago


  IF EXISTS (SELECT n.ID FROM NominaD n JOIN CFDINominaConcepto co ON n.Concepto = co.Concepto 
  WHERE n.Personal = @Personal  AND n.ID = @ID AND co.EsValesDespensa = 1) 
    UPDATE CFDINominaRecibo SET FormaPagoVales = '08' WHERE  ID = @ID AND Personal = @Personal

  IF @NominaEditarFechaPago = 1
  BEGIN
    IF EXISTS(SELECT ID FROM CFDINominaDatosMov WHERE Estacion  = @Estacion AND ID = @ID AND NULLIF(FechaPago,'') IS NOT NULL)
      UPDATE CFDINominaREcibo SET FechaPago = m.FechaPago FROM CFDINominaREcibo r
        JOIN CFDINominaDatosMov m ON r.ID = m.ID 
       WHERE m.Estacion = @Estacion AND m.ID = @ID
  END


  RETURN
END
GO

/**************** spCFDINominaXMLComprobante ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaXMLComprobante') and type = 'P') drop procedure dbo.spCFDINominaXMLComprobante
GO
CREATE PROC spCFDINominaXMLComprobante
			@Estacion					int,
			@ID							int,
			@Personal					varchar(10),
			@Version					varchar(5),
			@Vista						varchar(100),
			@TotalPercepciones			float, 
			@TotalDeducciones			float, 
			@PercepcionesTotalGravado	float, 
			@PercepcionesTotalExcento	float, 
			@DeduccionesTotalGravado	float, 
			@DeduccionesTotalExcento	float,		
			@XMLComprobante				varchar(max) OUTPUT,
			@Ok							int			 OUTPUT, 
			@OkRef						varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CampoXML		varchar(100),
		  @CampoXMLAnt	varchar(100),
		  @CampoVista	varchar(100),
		  @SQL			nvarchar(max),
		  @Parametros	nvarchar(max)

  SELECT @Parametros = '@XMLComprobante	varchar(max)	OUTPUT,
						@ID				int,
						@Personal		varchar(10)'

  SELECT @CampoXMLAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @CampoXML = MIN(CampoXML)
      FROM CFDINominaXMLCampo 
     WHERE Version = @Version
       AND CampoXML > @CampoXMLAnt 
  
    IF @CampoXML IS NULL BREAK
    
    SELECT @CampoXMLAnt = @CampoXML
    
    SELECT @CampoVista = CampoVista FROM CFDINominaXMLCampo WHERE Version = @Version AND CampoXML = @CampoXML
    
    IF ISNULL(RTRIM(@CampoXML), '') <> '' AND ISNULL(RTRIM(@CampoVista), '') <> '' AND ISNULL(RTRIM(@Vista), '') <> ''
    BEGIN
      --SELECT @SQL = 'SELECT @XMLComprobante = REPLACE(@XMLComprobante, ''' + ISNULL(RTRIM(@CampoXML), '') + ''', ISNULL(' + ISNULL(RTRIM(@CampoVista), '') + ', '''')) FROM ' + ISNULL(RTRIM(@Vista), '') + ' WHERE ID = @ID AND Personal = @Personal'      
      --BUG21234
      SELECT @SQL = 'SELECT @XMLComprobante = REPLACE(@XMLComprobante, ''' + ISNULL(RTRIM(@CampoXML), '') + ''', ISNULL(dbo.fnXMLValor(' + ISNULL(RTRIM(@CampoVista), '') + '), '''')) FROM ' + ISNULL(RTRIM(@Vista), '') + ' WHERE ID = @ID AND Personal = @Personal'
      EXEC sp_executesql @SQL, @Parametros, @XMLComprobante OUTPUT, @ID, @Personal
    END
  END
  RETURN
END
GO

/**************** spCFDINominaXMLComplemento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaXMLComplemento') and type = 'P') drop procedure dbo.spCFDINominaXMLComplemento
GO
CREATE PROC spCFDINominaXMLComplemento
			@Estacion					int,
			@ID							int,
			@Personal					varchar(10),
			@TotalPercepciones			float, 
			@TotalDeducciones			float, 
			@PercepcionesTotalGravado	float, 
			@PercepcionesTotalExcento	float, 
			@DeduccionesTotalGravado	float, 
			@DeduccionesTotalExcento	float,
			@XMLComplemento				varchar(max) OUTPUT,
			@XML						varchar(max) OUTPUT,
			@Ok							int			 OUTPUT, 
			@OkRef						varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @XMLNomina			varchar(max),
	      @XMLPercepciones		varchar(max),
		  @XMLDeducciones		varchar(max),
		  @XMLIncapacidades		varchar(max),
		  @XMLHorasExtra		varchar(max),
		  @XMLRetenciones		varchar(max)

  -- ********** Nomina **********
  --BUG21473
  SELECT @XMLNomina = ( 
  SELECT --'http://www.sat.gob.mx/nomina' 'xmlns:nomina',
         --'http://www.w3.org/2001/XMLSchema-instance' 'xmlns:xsi',
         --'http://www.sat.gob.mx/nomina http://www.sat.gob.mx/sitio_internet/cfd/nomina/nomina11.xsd' 'xsi:schemaLocation',
         '1.1' 'Version',
         NULLIF(RTRIM(Nomina.RegistroPatronal), '') 'RegistroPatronal',
         Nomina.Personal 'NumEmpleado',
         NULLIF(RTRIM(Nomina.CURP), '') 'CURP',
         NULLIF(RTRIM(Nomina.TipoRegimen), '') 'TipoRegimen',
         NULLIF(RTRIM(Nomina.NumSeguridadSocial), '') 'NumSeguridadSocial',
         CONVERT(varchar(19), Nomina.FechaPago, 126) 'FechaPago',
         CONVERT(varchar(19), Nomina.FechaInicialPago, 126) 'FechaInicialPago',
         CONVERT(varchar(19), Nomina.FechaFinalPago, 126) 'FechaFinalPago',
         --BUG22367
         CONVERT(varchar(max), ISNULL(Nomina.NumDiasPagados, 0)) 'NumDiasPagados',
         NULLIF(RTRIM(Nomina.Departamento), '') 'Departamento',
         NULLIF(RTRIM(Nomina.CLABE), '') 'CLABE',
         --BUG21457
         CASE ISNULL(Nomina.Banco, 0) WHEN 0 THEN NULL ELSE dbo.fnRellenarCerosIzquierda(CONVERT(int, Nomina.Banco), 3) END 'Banco',
         CONVERT(varchar(19), Nomina.FechaInicioRelLaboral, 126) 'FechaInicioRelLaboral',
         Nomina.Antiguedad,
         NULLIF(RTRIM(Nomina.Puesto), '') 'Puesto',
         NULLIF(RTRIM(Nomina.TipoContrato), '') 'TipoContrato' ,
         NULLIF(RTRIM(Nomina.TipoJornada), '') 'TipoJornada',
         NULLIF(RTRIM(Nomina.PeriodicidadPago), '') 'PeriodicidadPago',
         --BUG22395
         CONVERT(varchar(max), CONVERT(money, ISNULL(ROUND(SalarioBaseCotApor,2), 0))) 'SalarioBaseCotApor',
         NULLIF(RTRIM(Nomina.RiesgoPuesto), '') 'RiesgoPuesto',
         --BUG22395
         CONVERT(varchar(max), CONVERT(money, ISNULL(SalarioDiarioIntegrado, 0))) 'SalarioDiarioIntegrado'
    FROM CFDINominaRecibo Nomina
   WHERE Nomina.ID = @ID
     AND Nomina.Personal = @Personal
    FOR XML RAW('Nomina')
  )
  SELECT @XMLNomina = REPLACE(REPLACE(@XMLNomina, '/>', '>'), '<Nomina', '<nomina:Nomina')

  -- ********** Percepciones **********  
  IF NOT EXISTS(SELECT * FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND Movimiento = 'Percepcion')
    SELECT @XMLPercepciones = ''
  ELSE
  BEGIN
    --BUG22395
    SELECT @XMLPercepciones = '<Percepciones TotalGravado="' + CONVERT(varchar(max), CONVERT(money, ISNULL(@PercepcionesTotalGravado, 0))) + '" TotalExento="' + CONVERT(varchar(max), CONVERT(money, ISNULL(@PercepcionesTotalExcento, 0))) + '">' 
    SELECT @XMLPercepciones = @XMLPercepciones + ( 
    SELECT dbo.fnRellenarCerosIzquierda(ISNULL(TipoSAT, ''), 3)  'TipoPercepcion', 
           ISNULL(ClaveSAT, '') 'Clave', 
           ISNULL(Concepto, '') 'Concepto', 
           --BUG22395
           CONVERT(varchar(max), CONVERT(money, ISNULL(ImporteGravado, 0))) 'ImporteGravado', 
           CONVERT(varchar(max), CONVERT(money, ISNULL(ImporteExcento, 0))) 'ImporteExento'
      FROM CFDINominaPercepcionDeduccion Percepcion
     WHERE ID = @ID
       AND Personal = @Personal
       AND Movimiento = 'Percepcion'
      FOR XML AUTO
    )
    SELECT @XMLPercepciones = REPLACE(REPLACE(@XMLPercepciones, '<Percepciones', '<nomina:Percepciones'), '<Percepcion', '<nomina:Percepcion') + '</nomina:Percepciones>'
  END

  -- ********** Deducciones **********
  IF NOT EXISTS(SELECT * FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND Movimiento = 'Deduccion')
    SELECT @XMLDeducciones = ''
  ELSE
  BEGIN    
    --BUG22395
    SELECT @XMLDeducciones = '<Deducciones TotalGravado="' + CONVERT(varchar(max), CONVERT(money, ISNULL(@DeduccionesTotalGravado, 0))) + '" TotalExento="' + CONVERT(varchar(max), CONVERT(money, ISNULL(@DeduccionesTotalExcento, 0))) + '">'
    SELECT @XMLDeducciones = @XMLDeducciones + (
    SELECT dbo.fnRellenarCerosIzquierda(ISNULL(TipoSAT, ''), 3) 'TipoDeduccion', 
           ISNULL(ClaveSAT, '') 'Clave', 
           ISNULL(Concepto, '') 'Concepto', 
           --BUG22395
           CONVERT(varchar(max), CONVERT(money, ISNULL(ImporteGravado, 0))) 'ImporteGravado', 
           CONVERT(varchar(max), CONVERT(money, ISNULL(ImporteExcento, 0))) 'ImporteExento'
      FROM CFDINominaPercepcionDeduccion Deduccion
     WHERE ID = @ID
       AND Personal = @Personal
       AND Movimiento = 'Deduccion'
      FOR XML AUTO
    )
    SELECT @XMLDeducciones = REPLACE(REPLACE(@XMLDeducciones, '<Deducciones', '<nomina:Deducciones'), '<Deduccion', '<nomina:Deduccion') + '</nomina:Deducciones>'
  END
  
  -- ********** Incapacidades **********  
  IF NOT EXISTS(SELECT * FROM CFDINominaIncapacidad WHERE ID = @ID AND Personal = @Personal)
    SELECT @XMLIncapacidades = ''
  ELSE
  BEGIN        
    SELECT @XMLIncapacidades = (
    --BUG22395
    SELECT Dias 'DiasIncapacidad', TipoIncapacidad, CONVERT(varchar(max), CONVERT(money, ISNULL(Descuento, 0))) 'Descuento'
      FROM CFDINominaIncapacidad Incapacidad
     WHERE ID = @ID
       AND Personal = @Personal
      FOR XML AUTO
    )
    SELECT @XMLIncapacidades = '<nomina:Incapacidades>' + REPLACE(@XMLIncapacidades, '<Incapacidad', '<nomina:Incapacidad') + '</nomina:Incapacidades>'
  END
    
  -- ********** Horas Extra **********  
  IF NOT EXISTS(SELECT * FROM CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal)
    SELECT @XMLHorasExtra = ''
  ELSE
  BEGIN          
    SELECT @XMLHorasExtra = (  
    --BUG22395
    SELECT Dias, TipoHoras, CONVERT(varchar(max), ISNULL(HorasExtra, 0)) 'HorasExtra', CONVERT(varchar(max), CONVERT(money, ISNULL(ImportePagado, 0))) 'ImportePagado'
      FROM CFDINominaHoraExtra HorasExtra
     WHERE ID = @ID
       AND Personal = @Personal
       FOR XML AUTO
    )
    --BUG20848
    SELECT @XMLHorasExtra = '<nomina:HorasExtras>' + REPLACE(@XMLHorasExtra, '<HorasExtra', '<nomina:HorasExtra') + '</nomina:HorasExtras>'
  END
  
  -- ********** Retenciones **********  
  IF NOT EXISTS(SELECT * FROM CFDINominaRetencion WHERE ID = @ID AND Personal = @Personal)
    SELECT @XMLRetenciones = ''
  ELSE
  BEGIN          
    SELECT @XMLRetenciones = (  
    --BUG22395
    SELECT Concepto 'impuesto', CONVERT(varchar(max), CONVERT(money, ISNULL(Importe, 0))) 'importe'
      FROM CFDINominaRetencion Retencion
     WHERE ID = @ID
       AND Personal = @Personal
      FOR XML AUTO
    )
    SELECT @XMLRetenciones = REPLACE(@XMLRetenciones, '<Retencion', '<cfdi:Retencion')
  END
  
  SELECT @XMLComplemento = ISNULL(@XMLNomina, '') + ISNULL(@XMLPercepciones, '') + ISNULL(@XMLDeducciones, '') + ISNULL(@XMLIncapacidades, '') + ISNULL(@XMLHorasExtra, '') + '</nomina:Nomina>'

  SELECT @XML = REPLACE(@XML, '@Complemento', ISNULL(@XMLComplemento, ''))
  SELECT @XML = REPLACE(@XML, '@Retenciones', ISNULL(@XMLRetenciones, ''))

  IF ISNULL(@XMLRetenciones, '') = ''
  BEGIN
    SELECT @XML = REPLACE(@XML, '<cfdi:Retenciones>', '')
    SELECT @XML = REPLACE(@XML, '</cfdi:Retenciones>', '')
  END
    
  RETURN
END
GO


/**************** spCFDINominaXMLValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaXMLValidar') and type = 'P') drop procedure dbo.spCFDINominaXMLValidar
GO
/**************** spCFDINominaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaVerificar') and type = 'P') drop procedure dbo.spCFDINominaVerificar
GO
CREATE PROC spCFDINominaVerificar
			@Estacion					int,
			@ID							int,
			@Empresa					varchar(5),
			@Mov						varchar(20),
			@MovID						varchar(20),
			@Version					varchar(5),
			@Personal					varchar(10),
			@XML						varchar(max),
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RegistroPatronal			varchar(20),
		  @CURP						varchar(30),
		  @TipoComprobante			varchar(20),
		  @tipoRegimen				int,
		  @NumSeguridadSocial		varchar(30),
		  @FechaPago				datetime,
		  @FechaInicialPago			datetime,
		  @FechaFinalPago			datetime,
		  --BUG22367
		  @NumDiasPagados			float,
		  @Departamento				varchar(50),
		  @CLABE					varchar(18),
		  @Banco					varchar(5),
		  @FechainicioRelLaboral	datetime,
		  @Antiguedad				int,
		  @Puesto					varchar(50),
		  @TipoContrato				varchar(50),
		  @TipoJornada				varchar(20),
		  @PeriodicidadPago			varchar(20),
		  @SalarioBaseCotApor		varchar(20),
		  @RiesgoPuesto				varchar(20),
		  @SalarioDiarioIntegrado	float
		  
  --DECLARE @IDSQL			varchar(100),
		--  @Validacion		nvarchar(max),
		--  @Parametros		nvarchar(max),
		--  @Error			int,
		--  @ErrorRef			varchar(255),
		--  @Clave			varchar(50)
		  
  --SET @IDSQL = @Version

  --IF EXISTS (SELECT * FROM sys.xml_schema_collections WHERE name = @IDSQL)
  --BEGIN  
  --  SET @Validacion = 'DECLARE @x XML (' + '[' + RTRIM(@IDSQL) + ']' + ') ' + 'BEGIN TRY SET @x = @XML END TRY BEGIN CATCH SELECT @Error = @@ERROR,  @ErrorRef = ERROR_MESSAGE() END CATCH'

  --  SET @Parametros = '@XML varchar(max), @Error int OUTPUT, @ErrorRef varchar(255) OUTPUT'
  --  EXECUTE sp_executesql @Validacion, @Parametros, @XML = @XML, @Error = @Error OUTPUT, @ErrorRef = @ErrorRef OUTPUT

  --  IF @Error IS NOT NULL 
  --    SELECT @Ok = @Error, @OkRef = REPLACE(@ErrorRef, 'Esto puede ser consecuencia del uso de facetas de patrón en tipos que no son string o restricciones de rango o enumeraciones en tipos de coma flotante. ', '')
  --END

  SELECT @RegistroPatronal			= RegistroPatronal,
		 @CURP						= CURP,
		 --@RFC						= 
		 @TipoComprobante			= TipoComprobante,
		 @tipoRegimen				= tipoRegimen,
		 @NumSeguridadSocial		= NumSeguridadSocial,
		 @FechaPago					= FechaPago,
		 @FechaInicialPago			= FechaInicialPago,
		 @FechaFinalPago			= FechaFinalPago,
		 @NumDiasPagados			= NumDiasPagados,
		 @Departamento				= Departamento,
		 @CLABE						= CLABE,
		 @Banco						= Banco,
		 @FechainicioRelLaboral		= FechainicioRelLaboral,
		 @Antiguedad				= Antiguedad,
		 @Puesto					= Puesto,
		 @TipoContrato				= TipoContrato,
		 @TipoJornada				= TipoJornada,
		 @PeriodicidadPago			= PeriodicidadPago,
		 @SalarioBaseCotApor		= SalarioBaseCotApor,
		 @RiesgoPuesto				= RiesgoPuesto,
		 @SalarioDiarioIntegrado	= SalarioDiarioIntegrado
	FROM CFDINominaRecibo
   WHERE ID = @ID 
     AND Personal = @Personal

  IF @Ok IS NULL AND @Version IS NULL
    SELECT @Ok = 10060, @OkRef = 'Version'
  --BUG
  --BUG21339
  --IF @Ok IS NULL AND @tipoRegimen = 2 AND @RegistroPatronal IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Registro Patronal'  
  IF @Ok IS NULL AND @Personal IS NULL
    SELECT @Ok = 10060, @OkRef = 'Personal'  
  IF @Ok IS NULL AND @CURP IS NULL
    SELECT @Ok = 10060, @OkRef = 'CURP'  
  --BUG21341
  IF @Ok IS NULL AND @TipoRegimen IS NULL
    SELECT @Ok = 10060, @OkRef = 'Tipo Régimen'  
  --BUG21339
  --IF @Ok IS NULL AND @tipoRegimen = 2 AND @NumSeguridadSocial IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'IMSS'  
  IF @Ok IS NULL AND @FechaPago IS NULL
    SELECT @Ok = 10060, @OkRef = 'Fecha Pago'  
  IF @Ok IS NULL AND @FechaInicialPago IS NULL
    SELECT @Ok = 10060, @OkRef = 'Fecha Inicial Pago'  
  IF @Ok IS NULL AND @FechaFinalPago IS NULL
    SELECT @Ok = 10060, @OkRef = 'Fecha Final Pago'  
  IF @Ok IS NULL AND @NumDiasPagados IS NULL
    SELECT @Ok = 10060, @OkRef = 'Número Días Pagados'  
  --IF @Ok IS NULL AND @FechaInicioRelLaboral IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Fecha Inicio Relación Laboral'  
  --IF @Ok IS NULL AND @Antiguedad IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Antigüedad'  
  --IF @Ok IS NULL AND @Puesto IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Puesto'  
  --IF @Ok IS NULL AND @TipoContrato IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Tipo de Contrato'  
  --IF @Ok IS NULL AND @TipoJornada IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Tipo de Jornada'  
  IF @Ok IS NULL AND @PeriodicidadPago IS NULL
    SELECT @Ok = 10060, @OkRef = 'Periodicidad de Pago'  
  --IF @Ok IS NULL AND @SalarioBaseCotApor IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Salario Base Cot. Apor.'  
  --IF @Ok IS NULL AND @RiesgoPuesto IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'Riesgo de Puesto'  
  --IF @Ok IS NULL AND @SalarioDiarioIntegrado IS NULL
  --  SELECT @Ok = 10060, @OkRef = 'SDI'  

  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND TipoSAT IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Tipo Percepción / Deducción '+Concepto FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND TipoSAT IS NULL
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND ClaveSAT IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Clave Percepción / Deducción '+Concepto FROM CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal AND ClaveSAT IS NULL
    
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaIncapacidad WHERE ID = @ID AND Personal = @Personal AND Dias IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Días Incapacidad'
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaIncapacidad WHERE ID = @ID AND Personal = @Personal AND TipoIncapacidad IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Tipo de Incapacidad'
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaIncapacidad WHERE ID = @ID AND Personal = @Personal AND Descuento IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Descuento Incapacidad'
            
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal AND Dias IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Días Hora Extra'
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal AND TipoHoras IS NULL)
    SELECT @Ok = 10060, @OkRef = 'Tipo de Hora Extra'
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal AND HorasExtra IS NULL)
     SELECT @Ok = 10060, @OkRef = 'Horas Extra'
  IF @Ok IS NULL AND EXISTS(SELECT RID FROM CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal AND ImportePagado IS NULL)
     SELECT @Ok = 10060, @OkRef = 'Importe Horas Extra'  

  RETURN
END
GO

/**************** spCFDINominaXMLGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaXMLGenerar') and type = 'P') drop procedure dbo.spCFDINominaXMLGenerar
GO
CREATE PROC spCFDINominaXMLGenerar
			@Estacion					int,
			@ID							int,
			@Empresa					varchar(5),
			@Mov						varchar(20),
			@MovID						varchar(20),
			@Version					varchar(5),
			@Personal					varchar(10),
			@TotalPercepciones			float, 
			@TotalDeducciones			float, 
			@PercepcionesTotalGravado	float, 
			@PercepcionesTotalExcento	float, 
			@DeduccionesTotalGravado	float,
			@DeduccionesTotalExcento	float,
			@XML						varchar(max)	OUTPUT,
			@XMLComprobante				varchar(max)	OUTPUT,
			@XMLComplemento				varchar(max)	OUTPUT,
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Vista			varchar(100)

  SELECT @XML = Plantilla, @Vista = Vista FROM CFDINominaXMLPlantilla WHERE Version = @Version

  EXEC spCFDINominaXMLComprobante @Estacion, @ID, @Personal, @Version, @Vista, @TotalPercepciones, @TotalDeducciones, @PercepcionesTotalGravado, @PercepcionesTotalExcento, @DeduccionesTotalGravado, @DeduccionesTotalExcento, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  
  EXEC spCFDINominaXMLComplemento @Estacion, @ID, @Personal, @TotalPercepciones, @TotalDeducciones, @PercepcionesTotalGravado, @PercepcionesTotalExcento, @DeduccionesTotalGravado, @DeduccionesTotalExcento, @XMLComplemento OUTPUT, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  SELECT @XML = REPLACE(ISNULL(@XML, ''), 'T00:00:00', ''),
		 @XMLComplemento = REPLACE(ISNULL(@XMLComplemento, ''), 'T00:00:00', ''),
		 @XMLComprobante = REPLACE(ISNULL(@XMLComprobante, ''), 'T00:00:00', '')

/*
  --BUG21679
  SELECT @XML            = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XML, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'),
	     @XMLComplemento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLComplemento, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'),
	     @XMLComprobante = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLComprobante, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U')
*/

  --SELECT @XML            = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XML, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'N'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),
	 --    @XMLComplemento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLComplemento, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'N'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),
	 --    @XMLComprobante = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@XMLComprobante, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'N'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N')	     

 --BUG22307
  SELECT @XML			 = dbo.fnCFDILimpiarXML(@XML, ' SELLO CERTIFICADO '),
		 @XMLComplemento = dbo.fnCFDILimpiarXML(@XMLComplemento, ' SELLO CERTIFICADO '),
	     @XMLComprobante = dbo.fnCFDILimpiarXML(@XMLComprobante, ' SELLO CERTIFICADO ')

  RETURN
END
GO

/**************** spCFDINominaActualizar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaActualizar') and type = 'P') drop procedure dbo.spCFDINominaActualizar
GO
CREATE PROC spCFDINominaActualizar
			@ID						int,
			@Personal				varchar(10), 
			@Empresa				varchar(5),
			@Mov					varchar(20),
			@MovID					varchar(20),
			@Version				varchar(5),
			@Fecha					datetime			= NULL,
			@Ejercicio				int					= NULL,
			@Periodo				int					= NULL,			
			@RFCEmisor				varchar(15)			= NULL,
			@RFCReceptor			varchar(15)			= NULL,
			@Moneda					varchar(15)			= NULL,
			@Importe				money				= NULL,
			@noCertificado			varchar(20)			= NULL,
			@Sello					varchar(max)		= NULL,
			@CadenaOriginal			varchar(max)		= NULL,
			@Documento				varchar(max)		= NULL,
			@Timbrado				bit					= NULL,
			@UUID					uniqueidentifier	= NULL,
			@FechaTimbrado			datetime			= NULL,
			@TipoCambio				float				= NULL,  	
			@SelloSAT				varchar(max)		= NULL,
			@SelloCFD				varchar(max)		= NULL,
			@TFDVersion				varchar(10)			= NULL,
			@noCertificadoSAT		varchar(20)			= NULL,
			@TFDCadenaOriginal		varchar(max)		= NULL,	
			@VersionCFD				varchar(5)			= NULL,
			--BUG21377
			@NoTimbrado				int					= NULL,
			@Ok						int					= NULL OUTPUT,
			@OkRef					varchar(255)		= NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF @FechaTimbrado IS NULL SELECT @FechaTimbrado = GETDATE()
  
  UPDATE CFDNomina
     SET SelloSAT				= @SelloSAT,
	     Sello					= @SelloCFD,
		 FechaTimbrado			= @FechaTimbrado,
		 UUID					= @UUID,
		 TFDVersion				= @TFDVersion,
		 noCertificadoSAT		= @noCertificadoSAT,
		 TFDCadenaOriginal		= @TFDCadenaOriginal,
		 Documento				= @Documento,
		 RFCEmisor				= @RFCEmisor,
		 RFCReceptor			= @RFCReceptor,
		 Importe				= @Importe,
		 --BUG21377
		 NoTimbrado				= @NoTimbrado,
		 CadenaOriginal			= @CadenaOriginal
    FROM CFDNomina
   WHERE Modulo = 'NOM'
     AND ModuloID = @ID
     AND Personal = @Personal

  IF @@ROWCOUNT =0
    --BUG21377
    INSERT INTO CFDNomina(
		   Modulo, ModuloID, Personal,  Fecha,  Ejercicio,  Periodo,  Empresa,  MovID,  RFCEmisor,  RFCReceptor,  Importe,  noCertificado,  Sello,  CadenaOriginal,  Documento,  Timbrado,  UUID,  FechaTimbrado,  TipoCambio,  SelloSAT,  TFDVersion,  noCertificadoSAT,  TFDCadenaOriginal,  VersionCFD, Moneda,  NoTimbrado)
	SELECT 'NOM', @ID,      @Personal, @Fecha, @Ejercicio, @Periodo, @Empresa, @MovID, @RFCEmisor, @RFCReceptor, @Importe, @noCertificado, @SelloCFD, @CadenaOriginal, @Documento, @Timbrado, @UUID, @FechaTimbrado, @TipoCambio, @SelloSAT, @TFDVersion, @noCertificadoSAT, @TFDCadenaOriginal, @Version,   @Moneda, @NoTimbrado
  RETURN
END
GO

/**************** spCFDINominaInsertar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaInsertar') and type = 'P') drop procedure dbo.spCFDINominaInsertar
GO
CREATE PROC spCFDINominaInsertar
			@ID				int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Mov			varchar(20),
			@MovID			varchar(20),
			@Version		varchar(5),
			@XML			varchar(max),
			@Usuario		varchar(10),
			@RFCEmisor		varchar(20),
			@Importe		float,
			@NoTimbrado		int,
			@Ok				int			OUTPUT,
			@OkRef			varchar(255)OUTPUT,
			@PersonalEsp	varchar(10) = NULL
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Personal			varchar(10),
		  @PersonalAnt		varchar(10),
		  @Fecha			datetime,
		  @Ejercicio		int,
		  @Periodo			int,
		  @Moneda			varchar(10),
		  @TipoCambio		float,
		  @RFCReceptor		varchar(20)

  SELECT @Fecha = FechaEmision, @Ejercicio = Ejercicio, @Periodo = Periodo, @Moneda = Moneda, @TipoCambio = TipoCambio FROM Nomina WHERE ID = @ID
  SELECT @RFCReceptor = Registro2 FROM Personal WHERE Personal = @Personal 
  
  IF ISNULL(@PersonalEsp, '') = ''
    IF EXISTS(SELECT * FROM CFDNomina WHERE Modulo = 'NOM' AND ModuloID = @ID) RETURN

  SELECT @PersonalAnt = ''
  WHILE(1=1)
  BEGIN
    IF ISNULL(@PersonalEsp, '') = ''
      SELECT @Personal = MIN(Personal)
        FROM NominaD
       WHERE ID = @ID
         AND Personal > @PersonalAnt
    ELSE
      SELECT @Personal = MIN(Personal)
        FROM NominaD
       WHERE ID = @ID
         AND Personal > @PersonalAnt
         AND Personal = @PersonalEsp
         
    IF @Personal IS NULL BREAK
    
    SELECT @PersonalAnt = @Personal

    EXEC spCFDINominaActualizar @ID, @Personal, @Empresa, @Mov, @MovID, @Version, @Fecha, @Ejercicio, @Periodo, @RFCEmisor = @RFCEmisor, 
							   	@RFCReceptor = @RFCReceptor, @Importe = @Importe, @Moneda =  @Moneda, @TipoCambio = @TipoCambio,
							   	--BUG21377
							   	@NoTimbrado = @NoTimbrado, 
							   	@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END
END
GO

/*************** spCFDINominaCancelar *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaCancelar') and type = 'P') drop procedure dbo.spCFDINominaCancelar
GO
CREATE PROC spCFDINominaCancelar
			@ID			int,
			@Personal	varchar(10)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Estatus				varchar(20), 
		  @Empresa				varchar(10),
		  @Sucursal				int,
		  @Timbrado				varchar(15),
		  @Ok					int,
		  @OkRef				varchar(255),
		  @FirmaCancelacionSAT	varchar(max),
		  @DatosXMl				varchar(max),
		  @AlmacenarRuta		varchar(200),
		  @Archivo				varchar(255),
		  --BUG21341
		  @FechaCancelacion		datetime,
		  --BUG21377
		  @Ruta					varchar(255),
		  @NombreArchivo		varchar(255),
		  @NoTimbrado			int,
		  @Mov					varchar(20),
		  @MovID				varchar(20),
		  @VersionCFD			varchar(5),
		  @RFCEmisor			varchar(20),
		  @Importe				float

  --BUG21341
  SELECT @FechaCancelacion = GETDATE()

  SELECT @Estatus = Estatus, @Empresa = Empresa, @Sucursal = Sucursal, @Mov = Mov, @MovID = MovID FROM Nomina WHERE ID = @ID 
  
  SELECT @Timbrado = ISNULL(Timbrado, 'No Timbrado') FROM CFDINominaRecibo WHERE ID = @ID AND Personal = @Personal

  IF ISNULL(@Timbrado, 'No Timbrado') = 'Timbrado'
  BEGIN  
    EXEC spCFDINominaCancelarTimbre 'NOM', @ID, @Personal, @Estatus, @Empresa, @Sucursal, @FirmaCancelacionSAT OUTPUT, @DatosXML OUTPUT, @AlmacenarRuta OUTPUT, @Archivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    --BUG21377
    SELECT @Ruta = dbo.fnCFDINominaObtenerRuta(@AlmacenarRuta)+ '\'
    SELECT @NombreArchivo = REPLACE(@AlmacenarRuta, @Ruta, '')

    IF @Ok IS NOT NULL
      UPDATE CFDINominaRecibo SET OkCancela = @Ok, OkRefCancela = @OkRef WHERE ID = @ID AND Personal = @Personal
    ELSE IF @Ok IS NULL
    BEGIN
      IF /*@FirmaCancelacionSAT IS NOT NULL AND */@Ok IS NULL
      BEGIN
        UPDATE CFDNomina 
           SET Cancelado		= 1, 
               AcuseCancelado	= @DatosXml, 
               RutaAcuse		= @AlmacenarRuta, 
               SelloCancelacionSAT = @FirmaCancelacionSAT 
         WHERE Modulo = 'NOM'
           AND ModuloID = @ID 
           AND Personal = @Personal

        --BUG21377
        IF NOT EXISTS(SELECT * FROM AnexoMov WHERE Rama = 'NOM' AND ID = @ID AND CFD = 1 AND Direccion = @AlmacenarRuta)
          INSERT AnexoMov ( Sucursal,  Rama,  ID,  Nombre,         Direccion,     Tipo,      Icono, CFD) 
                   VALUES (@Sucursal, 'NOM', @ID, @NombreArchivo, @AlmacenarRuta, 'Archivo', 17,   1)

        --BUG21341
        UPDATE CFDINominaRecibo SET Timbrado = 'No Timbrado', OkCancela = NULL, OkRefCancela = NULL WHERE ID = @ID AND Personal = @Personal
        
        --BUG21377
        INSERT INTO CFDNominaCancelado(
				 Modulo, ModuloID, Personal, Fecha, Ejercicio, Periodo, Empresa, MovID, RFCEmisor, RFCReceptor, Importe, noCertificado, Sello, CadenaOriginal, Documento, Timbrado, UUID, FechaTimbrado, TipoCambio, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Moneda, Cancelado, AcuseCancelado, RutaAcuse,  FechaCancelacion, NoTimbrado)
		  SELECT Modulo, ModuloID, Personal, Fecha, Ejercicio, Periodo, Empresa, MovID, RFCEmisor, RFCReceptor, Importe, noCertificado, Sello, CadenaOriginal, Documento, Timbrado, UUID, FechaTimbrado, TipoCambio, SelloSAT, TFDVersion, noCertificadoSAT, TFDCadenaOriginal, VersionCFD, SelloCancelacionSAT, Moneda, Cancelado, AcuseCancelado, RutaAcuse, @FechaCancelacion, NoTimbrado
		    FROM CFDNomina 
           WHERE Modulo = 'NOM'
             AND ModuloID = @ID 
             AND Personal = @Personal
      
        SELECT @VersionCFD = VersionCFD,
			   @RFCEmisor = RFCEmisor,
			   @Importe = Importe
          FROM CFDNomina 
         WHERE Modulo = 'NOM'
           AND ModuloID = @ID 
           AND Personal = @Personal

		--BUG22156        
        EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
        
        --BUG21923
        EXEC spRegenerarArchivo @AlmacenarRuta, @DatosXML, @Ok OUTPUT, @OkRef OUTPUT
        
        DELETE CFDNomina WHERE Modulo = 'NOM' AND ModuloID = @ID AND Personal = @Personal
        
        EXEC spCFDINominaInsertar @ID, @Empresa, @Sucursal, @Mov, @MovID, @VersionCFD, '', '', @RFCEmisor, @Importe, @NoTimbrado, @Ok OUTPUT, @OkRef OUTPUT, @PersonalEsp = @Personal
        
        UPDATE Nomina SET CFDTimbrado = 0 WHERE ID = @ID
      END
    END
  END
  
  --BUG21493
  -- Mostrar el Estatus de la Afectacion
  SELECT NULL, NULL, NULL, NULL, NULL  
END
GO

/******************************* spCFDNominaGenerarArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDNominaGenerarArchivo') and type = 'P') drop procedure dbo.spCFDNominaGenerarArchivo
GO             
CREATE PROCEDURE spCFDNominaGenerarArchivo
		@Empresa		varchar(5),
		@Archivo		varchar(255),	
		@XML			varchar(max),
		@ServidorPac	varchar(255),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @RutaANSIToUTF				varchar(255),
    @Shell						varchar(8000)

  DECLARE @Datos TABLE(Datos		varchar(255))

  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
  
  SELECT @RutaANSIToUTF = RutaANSIToUTF FROM EmpresaCFD WHERE Empresa = @Empresa  

  IF @Ok IS NULL      
    EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL 
  BEGIN 
  IF @ServidorPac = 'ASPEL'
   EXEC spInsertaEnArchivo2 @IDArchivo, @XML, @Ok
  ELSE 
   EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok
    --INSERT @Datos (Datos) OUTPUT, @OkRef OUTPUT  
  END
    
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

/************** spCFDINominaObtenerTimbre *************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaObtenerTimbre') and type = 'P') drop procedure dbo.spCFDINominaObtenerTimbre
GO
CREATE PROCEDURE spCFDINominaObtenerTimbre
           @Modulo				char(5),
           @ID					int,
		   @Personal			varchar(10),
		   @Documento			varchar(max),		   
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
		  @Empresa				varchar(10),
		  @iDatos				int,
		  @DocumentoXML			xml,
		  @PrefijoCFDI			varchar(255),
		  @RutaCFDI				varchar(255)

  EXEC spMovInfo @ID, @Modulo, @Empresa = @Empresa OUTPUT

  SELECT @VersionCFD = Version FROM EmpresaCFD WHERE Empresa = @Empresa
  SELECT @OkRef = NULL

  --BUG21679
  --SELECT @Documento = REPLACE(@Documento, 'Ñ', 'N')
  -- Solo aqui se permite este reemplazo porque no se esta guardando en tablas algun dato que contenga estos caracteres.
--  SELECT @Documento = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Documento, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N'),'ñ','n')	  
  SELECT @Documento = REPLACE(REPLACE(@Documento,'encoding="UTF-8"','encoding="Windows-1252"'),'?<?xml','<?xml')
  EXEC sp_xml_preparedocument @iDatos OUTPUT, @Documento
  SELECT @OkRef = MENSAJE FROM OPENXML (@iDatos, '/ERROR',2) WITH (MENSAJE  varchar(255))
  IF @OkRef IS NOT NULL SELECT @OK = 71650
  EXEC sp_xml_removedocument @iDatos  

  IF @OK IS NULL
  BEGIN
    SET @DocumentoXML = CONVERT(XML,@Documento)	

    SET @PrefijoCFDI = '<ns xmlns' + CHAR(58) + 'cfdi="http' + CHAR(58) + '//www.sat.gob.mx/cfd/3" xmlns' + CHAR(58) + 'tfd="http' + CHAR(58) + '//www.sat.gob.mx/TimbreFiscalDigital"/>'    
    EXEC sp_xml_preparedocument @iDatos OUTPUT, @DocumentoXML, @PrefijoCFDI
        
    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @UUID = UUID
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (UUID uniqueidentifier)
     
    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @SelloSAT = SelloSAT
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (selloSAT varchar(max))

    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @SelloCFD = selloCFD
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (selloCFD varchar(max))
      
    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @TFDVersion = version
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (version varchar(max))
   SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @FechaTimbrado = FechaTimbrado
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (FechaTimbrado varchar(max))
	  
    SET @RutaCFDI = '/cfdi' + CHAR(58) + 'Comprobante/cfdi' + CHAR(58) + 'Complemento/tfd' + CHAR(58) + 'TimbreFiscalDigital'
    SELECT  
	  @noCertificadoSAT = noCertificadoSAT
      FROM OPENXML (@iDatos, @RutaCFDI, 1) WITH (noCertificadoSAT varchar(max))

    SELECT @TFDCadenaOriginal = '||'+@TFDVersion+'|'+@UUID+'|'+@FechaTimbrado+'|'+@SelloCFD+'|'+@noCertificadoSAT+'||'
    
    EXEC sp_xml_removedocument @iDatos  
  END

  RETURN
END
GO

/*************** spCFDITimbrarNomina *******************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDITimbrarNomina') and type = 'P') drop procedure dbo.spCFDITimbrarNomina
GO             
CREATE PROC spCFDITimbrarNomina
			@Modulo				varchar(10),
			@ID					int,
			@Personal			varchar(10),
			@Estatus			varchar(20), 
			@Empresa			varchar(10),
			@Sucursal			int,
			@CFDI				varchar(max),
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
		  
		  --BUG21377
		  @NoTimbrado			int,
		  @TokenCanPAC			varchar(max),
		  @CuentaCanPAC			varchar(max),
		  @UsuarioCanPAC		varchar(50),
		  @PaswordCanPAC		varchar(50),
		  @RutaProvPac			varchar(max),
		  @UsarTimbrarNomina    bit,
		  @CFDflex				bit
	     
  DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(255))

  SELECT @FechaTimbrado = CONVERT(varchar(20),FechaTimbrado,127), @UUID = UUID, @Documento = Documento, @SelloCancelacionSAT = SelloCancelacionSAT FROM CFDNomina WHERE Modulo = @Modulo AND ModuloID = @ID AND Personal = @Personal 
  SELECT @RFC = RFC FROM Empresa WHERE Empresa = @Empresa
  SELECT @RutaIntelisisCFDI = RutaIntelisisCFDI,        
         @TimeOutTimbrado = CONVERT(varchar(30),TimeOutTimbrado)    
    FROM EmpresaCFD WHERE Empresa = @Empresa

  SELECT @CFDflex = CFDFlex FROM EmpresaGral WHERE Empresa = @Empresa

SELECT @UsarTimbrarNomina=ISNULL(UsarTimbrarNomina,0) FROM EmpresaCFD WHERE Empresa = @Empresa
IF @UsarTimbrarNomina =0
SELECT 
         @ServidorPAC = TimbrarCFDIServidor, 
         @UsuarioPAC = TimbrarCFDIUsuario, 
         @PaswordPAC = TimbrarCFDIPassword, 
         @RutaCer = ISNULL(Certificado,RutaCertificado), 
         @RutaKey = Llave, 
         @passKey = CASE WHEN @CFDflex = 1 THEN ContrasenaSello ELSE ContrasenakeyCSD END,         
         @ModoPruebas = ModoPruebas,         
         @TokenCanPAC	=ISNULL(CancelarCFDIToken,''),
		 @CuentaCanPAC=ISNULL(CancelarCFDICuenta,''),
		 @UsuarioCanPAC=ISNULL(CancelarCFDIUsuario ,''),
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,'')
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
		 @PaswordCanPAC=ISNULL(CancelarCFDIPassword  ,'')
		 FROM EmpresaCFDNomina WHERE Empresa = @Empresa		
  --BUG21754 BUG22355
  --IF @ServidorPAC = 'ASPEL'
  --  SELECT @CFDI = REPLACE(@CFDI, 'ñ', 'N')

  IF @UUID IS NOT NULL
    SELECT @Ok = 71680, @OkRef = 'El Movimiento Ya Fue Timbrado'

  IF @Estatus = 'CONCLUIDO'
    SELECT @AccionCFDI = 'TIMBRAR', @PswPFX = 'Intelisis1234567', @Timbrar = 1
  ELSE 
    SELECT @Ok = 30110, @OkREf = 'CFDI - El Movimiento no esta CONCLUIDO'

  --BUG21377
  SELECT @NoTimbrado = MAX(NoTimbrado) FROM CFDNominaCancelado WHERE Modulo = 'NOM' AND ModuloID = @ID AND Personal = @Personal
  SELECT @NoTimbrado = ISNULL(@NoTimbrado, 0) + 1
  
  EXEC spCFDNominaAlmacenar @Modulo, @ID, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @Archivo OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @Para OUTPUT, @Asunto OUTPUT, @Mensaje OUTPUT, @Personal OUTPUT, @Sucursal OUTPUT , @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 0, @NoTimbrado 

  SELECT @AlmacenarRuta =   @Ruta + '\' + @Archivo +'.tmp'

  DECLARE @Hoy datetime
  SELECT @Hoy = GETDATE()
  SELECT @FechaTimbrado = CONVERT(varchar(20), @Hoy,127), @UUID = '0'
 
  IF @RutaIntelisisCFDI IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Intelisis CFDI no Puede Estar Vacio' ELSE
  IF @FechaTimbrado IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Fecha de Timbrado no Puede Estar Vacio' ELSE
  IF @ServidorPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Servidor PAC No puede Estar Vacio' ELSE    
  IF @RutaCer IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Certificado CSD No puede Estar Vacio' ELSE 
  IF @RutaKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Ruta Archivo Key No puede Estar Vacio' ELSE 
  IF @passKey IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Password Key No puede Estar Vacio' ELSE 
  IF @UUID IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Folio Fiscal UUID No puede Estar Vacio' ELSE 
  IF @RFC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato RFC Empresa No puede Estar Vacio' ELSE 
  IF @AlmacenarRuta IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Almacenar Ruta No puede Estar Vacio'

  IF @ServidorPAC='KONESH' AND @UsarTimbrarNomina=1 
  BEGIN
	SET @UsuarioPAC=@UsuarioPAC 
	SET @PaswordPAC=@PaswordPAC
	IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokencanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  ELSE IF @ServidorPAC='KONESH' AND @UsarTimbrarNomina=0
  BEGIN
	SET @UsuarioPAC=@UsuarioCanPAC 
	SET @PaswordPAC=@PaswordCanPAC
	IF @CuentaCanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Cuenta PAC No puede Estar Vacio' ELSE 
    IF @TokencanPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Token PAC No puede Estar Vacio' 
  END
  
  IF @UsuarioPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Usuario PAC No puede Estar Vacio' ELSE 
  IF @PaswordPAC IS NULL SELECT @Ok = 10060, @OkRef = 'Dato Pasword PAC No puede Estar Vacio' 
  
  IF @Ok IS NULL
    EXEC spCFDNominaGenerarArchivo @Empresa, @AlmacenarRuta, @CFDI,@ServidorPAC, @Ok OUTPUT, @OkRef OUTPUT

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
						     '</IntelisisCFDI>'

    SELECT @Shell = CHAR(34)+CHAR(34)+@RutaIntelisisCFDI+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
 
    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output   
    
    EXEC spVerificarArchivo @AlmacenarRuta, @Existe OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  

    --IF @Existe = 1
    --  EXEC spEliminarArchivo @AlmacenarRuta, @Ok OUTPUT, @OkRef OUTPUT
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
            
            --IF CHARINDEX('<CADENAORIGINAL',@RenglonDatos) >= 1
            --  SELECT @EsCadenaOriginal = 1
            
            --IF @EsCadenaOriginal = 0
            --  SELECT @DatosXMl = @DatosXML + @RenglonDatos
            --ELSE 
            --  SELECT @CadenaOriginal = @CadenaOriginal + @RenglonDatos
      END
    FETCH NEXT FROM crResultadoXMl INTO @RID, @RenglonDatos
      END
    CLOSE crResultadoXMl
    DEALLOCATE crResultadoXMl

    IF @Error = 1 SELECT @Ok = 71650,  @OkRef = @DatosXml
    IF @r <> 0
      SELECT @OK = 71650, @OkREf = 'Error al Ejecutar IntelisisCFDI.exe '+ISNULL(@DatosXml,'')
    IF NULLIF(@DatosXMl,'') IS NULL SELECT @Ok = 71650, @OkRef = 'Se Esperaba Respuesta de IntelisisCFDI.exe' 

    --BUG21754
	--IF @ServidorPAC = 'SOLUCIONFACTIBLE' 
	--SELECT @DatosXMl = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@DatosXMl, 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u'), 'ü', 'u'), 'ñ', 'n'), 'Á', 'A'), 'É', 'E'), 'Í', 'I'), 'Ó', 'O'), 'Ú', 'U'), 'Ü', 'U'), 'Ñ', 'N')


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
/*
      BEGIN TRY
        SELECT @XML = CONVERT(xml,@DatosXml)
      END TRY
      BEGIN CATCH
        SELECT @Ok = 71600, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH
*/
      SELECT @XML = @DatosXml

      IF @OK IS NULL 
      BEGIN
	    EXEC spCFDINominaObtenerTimbre @Modulo, @Id, @Personal, @DatosXML, @CadenaOriginal OUTPUT, @SelloSAT OUTPUT, @SelloCFD OUTPUT, @FechaTimbrado OUTPUT, @UUID OUTPUT, @TFDVersion OUTPUT, @noCertificadoSAT OUTPUT, @TFDCadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

		SELECT @CFDITimbrado = @DatosXML
      END
    END
  END
END
GO

/**************** spCFDINominaTimbrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaTimbrar') and type = 'P') drop procedure dbo.spCFDINominaTimbrar
GO
CREATE PROC spCFDINominaTimbrar
			@Estacion						int,
			@ID								int,
			@Personal						varchar(10), 
			@Empresa						varchar(5),
			@Sucursal						int,
			@Mov							varchar(20),
			@MovID							varchar(20),
			@Version						varchar(5),
			@Usuario						varchar(10),
			@Estatus						varchar(15),
			@RFCEmisor						varchar(20),
			@RFCReceptor					varchar(20),
			@Importe						float,
			@Archivo						varchar(255),
			--BUG21377
			@NoTimbrado						int,
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
          @UUID					varchar(50),
          @TFDVersion			varchar(max),
          @noCertificadoSAT		varchar(max),
          @TFDCadenaOriginal	varchar(max)
  
  --BUG21377
  EXEC spCFDINominaInsertar @ID, @Empresa, @Sucursal, @Mov, @MovID, @Version, @XML, @Usuario, @RFCEmisor, @Importe, @NoTimbrado, @Ok OUTPUT, @OkRef OUTPUT

  
  IF @Ok IS NULL
     EXEC spCFDITimbrarNomina 'NOM', @ID, @Personal, @Estatus, @Empresa, @Sucursal, @XML, @CFDITimbrado OUTPUT, @CadenaOriginal OUTPUT, @SelloSAT OUTPUT, @SelloCFD OUTPUT,  @FechaTimbrado OUTPUT, @UUID OUTPUT, @TFDVersion OUTPUT, @noCertificadoSAT OUTPUT, @TFDCadenaOriginal OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  
  IF @Ok IS NULL
  BEGIN
    EXEC spCFDINominaActualizar @ID, @Personal, @Empresa, @Mov, @MovID, @Version, @Documento = @CFDITimbrado, @CadenaOriginal = @CadenaOriginal, 
								@SelloSAT = @SelloSAT, @SelloCFD = @SelloCFD, @FechaTimbrado = @FechaTimbrado, @UUID = @UUID, @TFDVersion = @TFDVersion, @noCertificadoSAT = @noCertificadoSAT, 
                                @TFDCadenaOriginal = @TFDCadenaOriginal, @RFCEmisor = @RFCEmisor, @RFCReceptor = @RFCReceptor, @Importe = @Importe,
                                --BUG21377
                                @NoTimbrado = @NoTimbrado,
                                @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
 
    
    SELECT @XML = @CFDITimbrado
  END
  RETURN
END
GO

/**************** spCFDINominaActualizaTimbrado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaActualizaTimbrado') and type = 'P') drop procedure dbo.spCFDINominaActualizaTimbrado
GO
CREATE PROC spCFDINominaActualizaTimbrado
			@Estacion		int,
			@ID				int,
			@Personal		varchar(10), 
			@Empresa		varchar(5),
			@Sucursal		int,
			@Mov			varchar(20),
			@MovID			varchar(20),
			@Version		varchar(5),
			@XML			varchar(max),
			@Usuario		varchar(10),
 		    @ArchivoQRCode	varchar(255),
		    @ArchivoXML		varchar(255),
		    @ArchivoPDF		varchar(255),
		    @NominaTimbrar	bit,
			@Ok				int			OUTPUT,
			@OkRef			varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  UPDATE CFDINominaRecibo
     SET ArchivoPDF = @ArchivoPDF, 
         ArchivoXML = @ArchivoXML, 
         ArchivoQRCode = @ArchivoQRCode,
         Timbrado = CASE @NominaTimbrar WHEN 1 THEN 'Timbrado' ELSE 'No Timbrado' END
   WHERE ID = @ID 
     AND Personal = @Personal
  
  UPDATE CFDNomina
     SET Timbrado = CASE @NominaTimbrar WHEN 1 THEN 1 ELSE 0 END
   WHERE Modulo = 'NOM'
     AND ModuloID = @ID 
     AND Personal = @Personal

  IF NOT EXISTS(SELECT * FROM CFDNomina WHERE Modulo = 'NOM' AND ModuloID = @ID AND ISNULL(Timbrado, 0) = 0)
    UPDATE Nomina SET CFDTimbrado = 1 WHERE ID = @ID
    
  RETURN
END
GO

/**************** spCFDINominaQRCode ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaQRCode') and type = 'P') drop procedure dbo.spCFDINominaQRCode
GO
CREATE PROC spCFDINominaQRCode
			@Estacion		int,
			@ID				int,
			@Personal		varchar(10), 
			@Empresa		varchar(5),
			@Sucursal		int,
			@Mov			varchar(20),
			@MovID			varchar(20),
			@Version		varchar(5),
			@XML			varchar(max),
			@Usuario		varchar(10),
			@ArchivoQRCode		varchar(255),
			@Ok				int			OUTPUT,
			@OkRef			varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RFCEmisor			varchar(30),
		  @RFCReceptor			varchar(30),
		  @Importe				float,
		  @UUID					varchar(50),
		  @Cadena				varchar(max),
		  @Shell				varchar(8000),
		  @RutaGenerarQRCode	varchar(max)

  SELECT @RutaGenerarQRCode = RTRIM(LTRIM(ISNULL(RutaGenerarQRCode,'')))
    FROM EmpresaCFD
   WHERE Empresa = @Empresa
  
  SELECT @RFCEmisor		= ISNULL(nr.RFCEmisor, ''),
		 @RFCReceptor	= ISNULL(nr.RFC, ''),
		 @Importe		= ISNULL(nr.TotalPercepciones, 0) - ISNULL(nr.TotalDeducciones, 0),
		 @UUID			= ISNULL(CONVERT(varchar(50), n.UUID), '')
    FROM CFDINominaRecibo nr
    JOIN CFDNomina n ON nr.ID = n.ModuloID AND n.Modulo = 'NOM' AND nr.Personal = n.Personal
   WHERE nr.ID = @ID
     AND nr.Personal = @Personal
   
  SELECT @Cadena = '?re='+ISNULL(@RFCEmisor,'')+'&rr='+ISNULL(@RFCReceptor,'')+'&tt='+dbo.fnCFDFlexFormatearImporte(@Importe,10,6)+'&id='+@UUID

  SELECT @Shell = CHAR(34) + CHAR(34) + @RutaGenerarQRCode + CHAR(34) + ' ' + CHAR(34) + @ArchivoQRCode + CHAR(34) + ' ' + CHAR(34) + @Cadena + CHAR(34) + CHAR(34)

  EXEC xp_cmdshell @Shell, no_output
  
  RETURN
END
GO

/**************** spCFDINominaReciboEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaReciboEliminar') and type = 'P') drop procedure dbo.spCFDINominaReciboEliminar
GO
CREATE PROC spCFDINominaReciboEliminar
			@Estacion		int,
			@ID				int,
			@Personal		varchar(10),
			@Timbrado		varchar(15),
			@Ok				int			OUTPUT,
			@OkRef			varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF ISNULL(@Timbrado, 'No Timbrado') = 'No Timbrado'
  BEGIN
    DELETE CFDINominaRecibo WHERE ID = @ID AND Personal = @Personal
    DELETE CFDINominaPercepcionDeduccion WHERE ID = @ID AND Personal = @Personal
    DELETE CFDINominaHoraExtra WHERE ID = @ID AND Personal = @Personal
    DELETE CFDINominaIncapacidad WHERE ID = @ID AND Personal = @Personal
    DELETE CFDINominaRetencion WHERE ID = @ID AND Personal = @Personal
  END   

  RETURN
END
GO

/**************** spCFDINominaDProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaDProcesar') and type = 'P') drop procedure dbo.spCFDINominaDProcesar
GO
CREATE PROC spCFDINominaDProcesar 
			@Estacion					int,
			@ID							int,
			@Empresa					varchar(5),
			@Sucursal					int,
			@Mov						varchar(20),
			@MovID						varchar(20),
			@Version					varchar(5),
			@Timbrar					bit,
			@Usuario					varchar(10),
			@PersonalEsp				varchar(10),
			@NominaTimbrar				bit,
			@Estatus					varchar(15),
			@RFCEmisor					varchar(20),
			@Ok							int			OUTPUT,
			@OkRef						varchar(255)OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Personal					varchar(10),
		  @PersonalAnt				varchar(10),
		  @XML						varchar(max),
		  @XMLComprobante			varchar(max),
		  @XMLComplemento			varchar(max),
		  @Importe					float,
          @TotalPercepciones		float,
		  @TotalDeducciones			float,
		  --BUG21333
		  @TotalDeduccionesSinISR	float,
		  @PercepcionesTotalGravado	float,
		  @PercepcionesTotalExcento	float,
		  @DeduccionesTotalGravado	float,
		  @DeduccionesTotalExcento	float,
		  @TotalDescuento			float,
		  @Timbrado					varchar(15),

		  @AlmacenarXML				bit, 
		  @AlmacenarPDF				bit,
		  @NomArch					varchar(255),
		  @ArchivoQRCode			varchar(255),
		  @ArchivoXML				varchar(255),
		  @ArchivoPDF				varchar(255),
		  @Reporte					varchar(100),
		  @Ruta						varchar(255),
		  @EnviarPara				varchar(255),
		  @EnviarAsunto				varchar(255),
		  @EnviarMensaje			varchar(255),
		  @Enviar					bit,
		  @EnviarXML				bit,
		  @EnviarPDF				bit,
		  @Cancelado				bit,
		  
		  @ManejadorObjeto			int,
		  @IDArchivo				int,
		  @RFCReceptor				varchar(20),
		  
		  --BUG21377
		  @NoTimbrado				int
          
  SELECT @PersonalAnt = ''
  WHILE(1=1)
  BEGIN
    IF @PersonalEsp IS NULL
      SELECT @Personal = MIN(Personal)
        FROM NominaD
       WHERE ID = @ID
         AND Personal > @PersonalAnt
    ELSE
      SELECT @Personal = MIN(Personal)
        FROM NominaD
       WHERE ID = @ID
         AND Personal > @PersonalAnt
         AND Personal = @PersonalEsp

    IF @Personal IS NULL BREAK
    
    SELECT @PersonalAnt = @Personal

    --BUG21404
    SELECT @Timbrado = NULL
    
    SELECT @Timbrado = Timbrado FROM CFDINominaRecibo WHERE ID = @ID AND Personal = @Personal

    --BUG21377
    SELECT @NoTimbrado = MAX(NoTimbrado) FROM CFDNominaCancelado WHERE Modulo = 'NOM' AND ModuloID = @ID AND Personal = @Personal
    SELECT @NoTimbrado = ISNULL(@NoTimbrado, 0) + 1
            
    SELECT @Ok = NULL, @OkRef = NULL, @RFCReceptor = NULL  
    SELECT @RFCReceptor = Registro2 FROM Personal WHERE Personal = @Personal

    IF ISNULL(@Timbrado, 'No Timbrado') = 'No Timbrado'
    BEGIN
      IF @Ok IS NULL
        EXEC spCFDINominaReciboEliminar @Estacion, @ID, @Personal, @Timbrado, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
        --BUG21333 BUG21598
        EXEC spCFDINominaRecibo @Estacion, @ID, @Personal, @Empresa, @TotalPercepciones OUTPUT, @TotalDeducciones OUTPUT, @PercepcionesTotalGravado OUTPUT, @PercepcionesTotalExcento OUTPUT, @DeduccionesTotalGravado OUTPUT, @DeduccionesTotalExcento OUTPUT, @TotalDescuento OUTPUT, @Importe OUTPUT, @TotalDeduccionesSinISR OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL    
        EXEC spCFDINominaReciboD @Estacion, @ID, @Personal, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
        EXEC spCFDINominaXMLGenerar @Estacion, @ID, @Empresa, @Mov, @MovID, @Version, @Personal, @TotalPercepciones, @TotalDeducciones, @PercepcionesTotalGravado, @PercepcionesTotalExcento, @DeduccionesTotalGravado, @DeduccionesTotalExcento, @XML OUTPUT, @XMLComprobante OUTPUT, @XMLComplemento OUTPUT, @Ok OUTPUT, @OkRef OUTPUT        
      IF @Ok IS NULL
        EXEC spCFDINominaVerificar @Estacion, @ID, @Empresa, @Mov, @MovID, @Version, @Personal, @XML, @Ok OUTPUT, @OkRef OUTPUT                               
      IF @Ok IS NULL
        UPDATE CFDINominaRecibo SET Documento = @XML WHERE ID = @ID AND Personal = @Personal

      IF @Ok IS NULL AND @Timbrar = 1
      BEGIN
        --BUG21377
        EXEC spCFDNominaAlmacenar 'NOM', @ID, @AlmacenarXML OUTPUT, @AlmacenarPDF OUTPUT, @NomArch OUTPUT, @Reporte OUTPUT, @Ruta OUTPUT, @EnviarPara OUTPUT, 
                                   @EnviarAsunto OUTPUT, @EnviarMensaje OUTPUT, @Personal OUTPUT, @Sucursal OUTPUT, @Enviar OUTPUT, @EnviarXML OUTPUT, @EnviarPDF OUTPUT, 
                                   0, @NoTimbrado

        SELECT @ArchivoQRCode = CASE @NominaTimbrar WHEN 0 THEN NULL ELSE @Ruta + '\' + @NomArch + '.bmp' END,
		       @ArchivoXML	  = @Ruta + '\' + @NomArch + '.xml',
		       @ArchivoPDF	  = CASE @NominaTimbrar WHEN 0 THEN NULL ELSE @Ruta + '\' + @NomArch + '.pdf' END

        EXEC spCrearRuta @Ruta, @Ok OUTPUT, @OkRef OUTPUT
  
  
        IF @Ok IS NULL AND @NominaTimbrar = 1
          --BUG21377
          EXEC spCFDINominaTimbrar @Estacion, @ID, @Personal, @Empresa, @Sucursal, @Mov, @MovID, @Version, @Usuario, @Estatus, @RFCEmisor, @RFCReceptor, @Importe, @ArchivoXML, @NoTimbrado, @XML OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NULL AND @NominaTimbrar = 1
          EXEC spCFDINominaQRCode @Estacion, @ID, @Personal, @Empresa, @Sucursal, @Mov, @MovID, @Version, @XML, @Usuario, @ArchivoQRCode, @Ok OUTPUT, @OkRef OUTPUT
  
        IF @Ok IS NULL
          EXEC spCFDINominaActualizaTimbrado @Estacion, @ID, @Personal, @Empresa, @Sucursal, @Mov, @MovID, @Version, @XML, @Usuario, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, @NominaTimbrar, @Ok OUTPUT, @OkRef OUTPUT
  
        IF @Ok IS NULL
          EXEC spCFDINominaAnexoMov @ID, @Sucursal, @Personal, @Ruta, @ArchivoQRCode, @ArchivoXML, @ArchivoPDF, 0, @Ok OUTPUT, @OkRef OUTPUT  
      
	    -- Adecuación para envíar Mail y aviso de recibo de nómina
        IF @Ok IS NULL OR @Ok = 71680
        BEGIN
			DECLARE @ParamPeriodoNomina varchar(25)
			SELECT @ParamPeriodoNomina = CONVERT(varchar(10), FechaInicialPago, 105) + ' al ' + convert(varchar(10), FechaFinalPago, 105)
			  FROM CFDINominaRecibo 
			 WHERE ID = @ID AND Personal = @Personal
        
			IF (NULLIF(@Personal, '') IS NOT NULL AND NULLIF(@ParamPeriodoNomina, '') IS NOT NULL)
			BEGIN
				EXEC spPNetEnviarCorreoPersonal @Personal, 'Generar Nómina', @ParamPeriodoNomina
			END
        END
	  END

      IF @Ok IS NOT NULL
        UPDATE CFDINominaRecibo
           SET Ok = @Ok, 
               OkRef = @OkRef 
         WHERE ID = @ID 
           AND Personal = @Personal          

      --BUG22363
      IF @Ok = 71680 AND @Timbrar = 1
      BEGIN
        UPDATE CFDINominaRecibo SET Timbrado = 'Timbrado', Ok = NULL, OkRef = NULL WHERE ID = @ID AND Personal = @Personal
        UPDATE CFDNomina SET Timbrado = 1 WHERE Modulo = 'NOM' AND ModuloID = @ID AND Personal = @Personal
      END
    END
  END
  RETURN
END
GO

/**************** spCFDINominaGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCFDINominaGenerar') and type = 'P') drop procedure dbo.spCFDINominaGenerar
GO
CREATE PROC spCFDINominaGenerar
			@Estacion		int,
			@Timbrar		bit,
			@Usuario		varchar(10),
			@Ok             int	 			= NULL OUTPUT,
			@OkRef          varchar(255)	= NULL OUTPUT,
			@IDEsp			int				= NULL,
			@PersonalEsp	varchar(10)		= NULL
--//WITH ENCRYPTION
AS
BEGIN
  SET NOCOUNT ON
  
  DECLARE @ID							int,
		  @IDAnt						int,
		  @Empresa						varchar(5),
		  @Mov							varchar(20),
		  @MovID						varchar(20),
		  @Version						varchar(5),
    	  @OkDesc						varchar(255),
    	  @OkTipo						varchar(50),
    	  @Sucursal						int,
    	  @NominaTimbrar				bit,
    	  @Estatus						varchar(15),
    	  @RFCEmisor					varchar(15)

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    IF @IDEsp IS NULL
      SELECT @ID = MIN(l.ID)
        FROM ListaModuloID l
        JOIN Nomina n ON l.ID = n.ID
        JOIN CFDINominaMov m ON n.Mov = m.Mov
       WHERE l.Estacion = @Estacion
         AND l.ID > @IDAnt
    ELSE IF @IDEsp IS NOT NULL
      SELECT @ID = MIN(n.ID)
        FROM Nomina n
        JOIN CFDINominaMov m ON n.Mov = m.Mov
       WHERE ID = @IDEsp
         AND ID > @IDAnt

    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID    
    
    SELECT @Empresa		= n.Empresa, 
           @Mov			= n.Mov, 
           @MovID		= n.MovID, 
           @Version		= m.Version,
           @Sucursal	= n.Sucursal,
           @Estatus		= n.Estatus,
           @RFCEmisor	= e.RFC
      FROM Nomina n
      JOIN CFDINominaMov m ON n.Mov = m.Mov
      JOIN Empresa e ON n.Empresa = e.Empresa
     WHERE n.ID = @ID
    
    SELECT @NominaTimbrar = ISNULL(NominaTimbrar, 0) FROM EmpresaCFD WHERE Empresa = @Empresa
    
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spCFDINominaDProcesar @Estacion, @ID, @Empresa, @Sucursal, @Mov, @MovID, @Version, @Timbrar, @Usuario, @PersonalEsp, @NominaTimbrar, @Estatus, @RFCEmisor, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Mostrar el Estatus de la Afectacion
  SELECT NULL, NULL, NULL, NULL, NULL

  RETURN
END
GO

/* Version */
DECLARE	@Version int,
		@Fecha   datetime

SELECT @Version = 8,
       @Fecha	= CONVERT(datetime, '01/27/14', 1)  -- Mes / Dia / Año

UPDATE CFDINominaVersion
   SET Version			= @Version, 
       Fecha			= @Fecha,
       FechaInstalacion	= GETDATE()

IF @@ROWCOUNT = 0
  INSERT INTO CFDINominaVersion(Version, Fecha) VALUES (@Version, @Fecha)    
GO

/*
DELETE CFDNomina
DELETE CFDNominaCancelado
DELETE CFDINominaRecibo
DELETE CFDINominaPercepcionDeduccion
DELETE CFDINominaHoraExtra
DELETE CFDINominaIncapacidad
DELETE CFDINominaRetencion
DELETE AnexoMov
UPDATE Nomina SET CFDTimbrado = 0 
*/

/************** spEnviarReciboNomina *************/
if exists (select * from sysobjects where id = object_id('dbo.spEnviarReciboNomina') and type = 'P') DROP PROCEDURE dbo.spEnviarReciboNomina
GO
CREATE PROCEDURE spEnviarReciboNomina    
				 @Empresa     varchar(5),                            
                 @ID			int = NULL, 
			     @Personal		varchar(100),
			     @Estacion		varchar(5)
			     
     
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE    
    @Anexos				varchar(550),
    @EnviarXML			bit,
    @EnviarPDF			bit,
    @Enviar				bit,      
    @Fecha				datetime,
    @NombreCorreoEnLote	varchar(100),
    @Perfil				varchar(50),
	@Para				varchar(8000),
    @CC					varchar(8000),
    @CCO				varchar(8000),
	@Asunto				varchar(8000),
	@Mensaje			varchar(max),
	@Formato			varchar(50),
	@Importancia		varchar(20),
	@Sensitividad		varchar(20),
	@Adjuntos			varchar(max),
	@SQL				varchar(8000),
	@SQLBase			varchar(50),
	@SQLAnexar			bit,
	@SQLAnexarNombre	varchar(255),
    @SQLConEncabezados	bit,
	@SQLAncho			int,
	@SQLSeparador		char(1),
	@mailitem_id		int,
	@Estatus			varchar(50)

    SELECT @EnviarXML = 0, @EnviarPDF = 0, @Enviar = 0, @Formato = 'HTML', @Importancia = 'Normal', 
           @Sensitividad = 'Normal', @SQLAnexar = 0, @SQLConEncabezados = 1, @SQLSeparador = ' ', @Anexos = NULL

    EXEC spAsuntoNomina @Empresa,@ID,@Personal,@Asunto=@Asunto OUTPUT 
    
    SELECT @Mensaje = EnviarMensajeNomina,@EnviarXML=EnviarXMLNomina,@EnviarPDF=EnviarPDFNomina,@Enviar=EnviarNomina  FROM EmpresaCFD  WHERE Empresa = @Empresa 
      
    SELECT @Para =ISNULL (eMail,'' ) FROM Personal  WHERE Personal=@Personal
	IF (@EnviarXML=1	AND @Enviar=1)
     SELECT @Anexos=ArchivoXML FROM CFDINominaRecibo  WHERE RID= @ID    
	IF (@EnviarPDF =1 AND @Enviar =1 )
	BEGIN
	   IF LEN(@Anexos)>0
	   SET @Anexos=@Anexos+';'	
	   SELECT @Anexos=(ISNULL(@Anexos,'')+ArchivoPDF) FROM CFDINominaRecibo  WHERE RID= @ID 
	END  
	
	SELECT @Perfil = DBMailPerfil FROM EmpresaGral WHERE Empresa = @Empresa
	
	SELECT	 @Para    = NULLIF(RTRIM(@Para), ''), 
			 @Mensaje = NULLIF(RTRIM(@Mensaje), ''), 
			 @Asunto  = NULLIF(RTRIM(@Asunto), ''),
			 @Anexos  = NULLIF(RTRIM(@Anexos), ''),
			 @SQL     = NULLIF(RTRIM(@SQL), ''),
			 @Fecha   = GETDATE()

	IF SUBSTRING(@Anexos,LEN(@Anexos),1) = ';' SELECT @Anexos = STUFF(@Anexos,LEN(@Anexos),1,'')
  
  DELETE  FROM ListaModuloID WHERE ID=@ID AND Estacion =@Estacion 
  
  IF @Para IS NOT NULL 
  BEGIN
  ------
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
  
  ----------
       
    
    UPDATE CFDINominaRecibo SET EnviarMail=1 WHERE RID =@ID 
	SELECT @Estatus=sent_status FROM msdb.dbo.sysmail_allitems where mailitem_id=@mailitem_id
	UPDATE CFDINominaRecibo SET EnviarMailSql= CASE WHEN  @Estatus='sent' THEN 'Enviado' WHEN @Estatus='failed' THEN 'Error' ELSE 'Enviando' END, mailitem_id=@mailitem_id WHERE RID =@ID 
	 
	SELECT @NombreCorreoEnLote = NombreCorreoEnLote FROM Version
    EXEC spOutlook @NombreCorreoEnLote, @Fecha, @Asunto, @Mensaje, @Anexos, @EnSilencio = 1, @ID = @ID OUTPUT
    EXEC spOutlookPara @ID, @Para
  END
  SELECT ''
    --EXEC spEnviarCorreo   @Empresa, @Para	,@Asunto,  @Mensaje	,@Anexos    

END 
GO
/************** spAsuntoNomina *************/
if exists (select * from sysobjects where id = object_id('dbo.spAsuntoNomina') and type = 'P') DROP PROCEDURE dbo.spAsuntoNomina
GO
CREATE PROCEDURE spAsuntoNomina    
				 @Empresa   varchar(5),                            
                 @ID		int = NULL,             
                 @Personal  varchar(50),                    
			     @Asunto	varchar(max)=NULL OUTPUT
     
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE              
    @Curp				varchar(255),  
    @FechaPago			varchar(100),  
    @FechaInicialPago	varchar(100),  
    @FechaFinalPago		varchar(20),  
    @Departamento		varchar(20),  
    @Puesto				varchar(20),  
    @RfcEmisor			varchar(20),  
    @Rfc				varchar(20)
    
       
    SELECT  @Curp = Curp, @FechaPago = FechaPago, @FechaInicialPago = FechaInicialPago, @FechaFinalPago = FechaFinalPago, @Departamento = Departamento,@Puesto	=Puesto ,@RfcEmisor=RfcEmisor, @Rfc=RFC FROM CFDINominaRecibo WHERE RID = @ID  AND Personal =@Personal 
    
	SELECT @Asunto=EnviarAsuntoNomina from EmpresaCFD where Empresa =@Empresa 

   --SELECT @Nombre = REPLACE(@Nombre,' ','')  


   SELECT @Asunto = @Asunto 
   SELECT @Asunto = REPLACE(@Asunto, '<Personal>', LTRIM(RTRIM(ISNULL(@Personal,''))))  
  
   SELECT @Asunto = REPLACE(@Asunto, '<Curp>', LTRIM(RTRIM(ISNULL(@Curp,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<FechaPago>', LTRIM(RTRIM(ISNULL(@FechaPago,''))))
   SELECT @Asunto = REPLACE(@Asunto, '<FechaInicialPago>', LTRIM(RTRIM(ISNULL(@FechaInicialPago,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<FechaFinalPago>', LTRIM(RTRIM(ISNULL(@FechaFinalPago,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<Departamento>', LTRIM(RTRIM(ISNULL( @Departamento,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<Puesto>', LTRIM(RTRIM(ISNULL(@Puesto,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<RfcEmisor>', LTRIM(RTRIM(ISNULL(@RfcEmisor,''))))  
   SELECT @Asunto = REPLACE(@Asunto, '<Rfc>', LTRIM(RTRIM(ISNULL(@Rfc,''))))
   
END  
GO

/************** spActualizarCorreo *************/
if exists (select * from sysobjects where id = object_id('dbo.spActualizarCorreo') and type = 'P') DROP PROCEDURE dbo.spActualizarCorreo
GO
CREATE PROCEDURE spActualizarCorreo    			
     
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE 
    @RID                       AS INT, 
    @ESTATUS    AS VARCHAR(50),
    @mailitem_id as int 
    

	DECLARE ACTUALIZA_CURSOR CURSOR FOR
	SELECT mailitem_id FROM CFDINominaRecibo where enviarMailSQL NOT IN('Enviado') AND mailitem_id!=NULL
	OPEN ACTUALIZA_CURSOR
	FETCH NEXT FROM ACTUALIZA_CURSOR
	INTO @mailitem_id

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	 SELECT @Estatus=sent_status FROM msdb.dbo.sysmail_allitems where mailitem_id=@mailitem_id
	SELECT @Estatus,@mailitem_id
		IF ISNULL(@Estatus,'')<>''
		UPDATE CFDINominaRecibo SET EnviarMailSql= CASE WHEN @Estatus='unsent' THEN 'Enviando' WHEN @Estatus='sent' THEN 'Enviado' WHEN @Estatus='failed' THEN 'Error' Else 'Reintentando' END ,  EnviarMail= CASE WHEN @Estatus='sent' THEN 1 WHEN @Estatus<>'sent' THEN 0 END WHERE mailitem_id=@mailitem_id 
	    
		FETCH NEXT FROM ACTUALIZA_CURSOR
		INTO @mailitem_id
	END

	CLOSE ACTUALIZA_CURSOR
	DEALLOCATE ACTUALIZA_CURSOR
END  
GO

/************** spReenviarReciboNomina *************/
if exists (select * from sysobjects where id = object_id('dbo.spReenviarReciboNomina') and type = 'P') DROP PROCEDURE dbo.spReenviarReciboNomina
GO
CREATE PROCEDURE spReenviarReciboNomina    
				 @Empresa     varchar(5),                            
                 @ID			int = NULL,
                 @Estacion		varchar(5)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE    
    @Anexos				varchar(100),
    @EnviarXML			bit,
	@process_id			int,
	@mailitem_id		float,
	@RID				float,
	@Personal			varchar(100),
	@Shell				varchar(100)
	
	SET @Anexos = 0
	SET @EnviarXML = 0
	SET @Shell ='TASKKILL /F /IM DatabaseMail.exe'
	EXEC xp_cmdshell @Shell
	
    DECLARE crProcesos CURSOR FOR 
	SELECT   process_id FROM  CFDINominaRecibo cr INNER JOIN msdb.dbo.sysmail_event_log sl ON sl.mailitem_id= cr.mailitem_id
	WHERE id =@ID AND event_type IN ('error','information') GROUP BY   process_id	
    OPEN crProcesos
   
     FETCH NEXT FROM crProcesos INTO @process_id
	  WHILE @@FETCH_STATUS = 0 
	  BEGIN
	   --IF EXISTS (SELECT process_id FROM msdb.dbo.sysmail_event_log WHERE process_id= @process_id and description ='Se está cerrando el proceso DatabaseMail' )
	   --BEGIN
	    DECLARE crReenviarCorreo CURSOR FOR 
	    SELECT  DISTINCT RID,Personal FROM CFDINominaRecibo cr
	    INNER JOIN msdb.dbo.sysmail_event_log sl on sl.mailitem_id= cr.mailitem_id
	    WHERE process_id =@process_id and event_type ='error'
	    OPEN crReenviarCorreo
		FETCH NEXT FROM crReenviarCorreo INTO  @RID,@Personal
		 WHILE @@FETCH_STATUS = 0 
		  BEGIN
			
			EXEC spEnviarReciboNomina @Empresa,@RID,@Personal,@Estacion
			FETCH NEXT FROM crReenviarCorreo INTO  @RID,@Personal
		  END
		  CLOSE crReenviarCorreo
        DEALLOCATE crReenviarCorreo
       FETCH NEXT FROM crProcesos INTO @process_id
	  
	   
	  END
   CLOSE crProcesos
   DEALLOCATE crProcesos
   SELECT ''
   RETURN 
 END 
GO



/**************** fnSQL2008 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSQL2008') DROP FUNCTION fnSQL2008
GO
CREATE FUNCTION fnSQL2008 ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF substring(@@version, 1, 25)= 'Microsoft SQL Server 2008' 
    SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO

-- select dbo.fnSQL2012()
/**************** fnSQL2012 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSQL2012') DROP FUNCTION fnSQL2012
GO
CREATE FUNCTION fnSQL2012 ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF substring(@@version, 1, 25) IN ('Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016') 

    SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO

/************** spEnviarReciboNominaCFDI *************/
if exists (select * from sysobjects where id = object_id('dbo.spEnviarReciboNominaCFDI') and type = 'P') DROP PROCEDURE dbo.spEnviarReciboNominaCFDI
GO
CREATE PROCEDURE dbo.spEnviarReciboNominaCFDI    
				 @Empresa		varchar(5),                            
                 @ID			int = NULL, 
			     @Personal		varchar(100),
			     @Estacion		varchar(5)
			    
     
--//WITH ENCRYPTION  
AS BEGIN  
  DECLARE    
    @Anexos				varchar(100),
    @EnviarXML			bit,
    @EnviarPDF			bit,
    @Enviar				bit,      
    @Fecha				datetime,
    @NombreCorreoEnLote	varchar(100),
    /****/    
	@Para				varchar(8000),   
	@Asunto				varchar(8000),
	@Mensaje			varchar(max),	
	@Adjuntos			varchar(max),		
	@Estatus			varchar(50),
	@Smtp				varchar(50),
	@PuertoCorreo		varchar(50),
	@Usuario			varchar(50),
	@Pasword			varchar(50),
	@Cuenta				varchar(50),
	@RFC				varchar(50),
	@CadenaConexion		varchar(max),
	@AlmacenarRuta		varchar(200),
	@RutaIntelisisCFDI	varchar(255),
	@Shell				varchar(8000),
	@r					varchar(max)
	
	
	DECLARE @Datos TABLE (ID int IDENTITY(1,1), Datos varchar(255))
	
	
	SELECT @EnviarXML= 0, @EnviarPDF = 0, @Enviar = 0
    EXEC spAsuntoNomina @Empresa,@ID,@Personal,@Asunto=@Asunto OUTPUT 

    SELECT @Mensaje = EnviarMensajeNomina,@EnviarXML=EnviarXMLNomina,@EnviarPDF=EnviarPDFNomina,@Enviar=EnviarNomina,@RutaIntelisisCFDI = RutaIntelisisCFDI  FROM EmpresaCFD  WHERE Empresa = @Empresa 
    
      
    SELECT @Para =ISNULL (eMail,'' ) FROM Personal  WHERE Personal=@Personal

	IF (@EnviarXML=1	AND @Enviar=1)
     SELECT @Anexos=ArchivoXML FROM CFDINominaRecibo  WHERE RID= @ID  
          
	IF (@EnviarPDF =1 AND @Enviar =1 )
	BEGIN
	   IF LEN(@Anexos)>0
	   SET @Anexos=@Anexos+';'	
	   SELECT @Anexos=(ISNULL(@Anexos,'')+ArchivoPDF) FROM CFDINominaRecibo  WHERE RID= @ID 
	END  

	SELECT	 @Para    = NULLIF(RTRIM(@Para), ''), 
			 @Mensaje = NULLIF(RTRIM(@Mensaje), ''), 
			 @Asunto  = NULLIF(RTRIM(@Asunto), ''),
			 @Anexos  = NULLIF(RTRIM(@Anexos), ''),			
			 @Fecha   = GETDATE()

	IF SUBSTRING(@Anexos,LEN(@Anexos),1) = ';' SELECT @Anexos = STUFF(@Anexos,LEN(@Anexos),1,'')
	SELECT @RFC=RFC FROM EMPRESA WHERE EMPRESA=@Empresa
	SELECT @Usuario=DireccionCorreo, @Pasword= ContrasenaCorreo,@Smtp=SmtpCorreo,@PuertoCorreo=PuertoCorreo FROM EmpresaCFDNomina where Empresa=@Empresa 
    
    SELECT @CadenaConexion = '<IntelisisCFDI>'+
                             '<IDSESION>'+convert(varchar,@@SPID)+'</IDSESION>'+
                             '<FECHA>'+Convert (varchar,GETDATE())+'</FECHA>'+
		                     '<SERVIDOR>INTELISIS</SERVIDOR>'+
						     '<USUARIO>'+@Usuario+'</USUARIO>'+
						     '<PASSWORD>'+@Pasword+'</PASSWORD>'+
						     '<CUENTA>'+ISNULL(@Para,'')+'</CUENTA>'+						     
						     '<ACCION>ENVIARCORREO</ACCION>'+						     
						     '<RFC>'+@RFC+'</RFC>'+	
						     '<ASUNTO>'+@Asunto+'</ASUNTO>'+
						     '<SMTP>'+@Smtp+'</SMTP>'+		                 
						     '<PUERTO>'+@PuertoCorreo+'</PUERTO>'+
						     '<MENSAJE>'+@Mensaje+'</MENSAJE>'+		                 
						     '<RUTAARCHIVO>'+@Anexos+'</RUTAARCHIVO>'+				            
						     '</IntelisisCFDI>'


  SELECT @Shell = CHAR(34)+CHAR(34)+@RutaIntelisisCFDI+CHAR(34)+' '+CHAR(34)+@CadenaConexion+CHAR(34)+CHAR(34)
    INSERT @Datos
      EXEC @r =  xp_cmdshell @Shell--, no_output
  END
    SELECT @Estatus=Datos FROM @Datos WHERE Datos IS NOT NULL ORDER BY ID Asc
 
  DELETE  FROM ListaModuloID WHERE ID=@ID AND Estacion =@Estacion 
UPDATE CFDINominaRecibo SET EnviarMailSql= CASE WHEN  @Estatus='Envio Exitoso' THEN 'Enviado'   ELSE 'Error en el envio' END WHERE RID =@ID 
  SELECT ''
    

GO
IF NOT EXISTS(SELECT * FROM sysobjects o JOIN sysindexes i ON o.id = i.id WHERE o.name = 'CFDINominaPercepcionDeduccion' AND i.name='Movimiento')
  CREATE INDEX Movimiento ON CFDINominaPercepcionDeduccion(ID,Personal,Movimiento)
IF NOT EXISTS(SELECT * FROM sysobjects o JOIN sysindexes i ON o.id = i.id WHERE o.name = 'CFDINominaPercepcionDeduccion' AND i.name='Personal')
  CREATE INDEX Personal ON CFDINominaPercepcionDeduccion(ID,Personal)
IF NOT EXISTS(SELECT * FROM sysobjects o JOIN sysindexes i ON o.id = i.id WHERE o.name = 'CFDINominaRecibo' AND i.name='Personal')  
  CREATE INDEX Personal ON CFDINominaRecibo(ID,Personal)
IF NOT EXISTS(SELECT * FROM sysobjects o JOIN sysindexes i ON o.id = i.id WHERE o.name = 'CFDNominaCancelado' AND i.name='ModuloID')
  CREATE INDEX ModuloID ON CFDNominaCancelado(ModuloID,Modulo,Personal)
IF NOT EXISTS(SELECT * FROM sysobjects o JOIN sysindexes i ON o.id = i.id WHERE o.name = 'CFDINominaRetencion' AND i.name='Personal')
  CREATE INDEX Personal ON CFDINominaRetencion (ID,Personal)
GO
