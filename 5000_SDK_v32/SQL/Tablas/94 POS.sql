SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

IF NOT EXISTS(SELECT  Modulo FROM Modulo WHERE Modulo ='POS')
INSERT  Modulo (Modulo, Nombre) VALUES ('POS',  'POS')
GO

/****** FormaPagoPos  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='FormaPagoPos' AND xtype='U')
CREATE TABLE   FormaPagoPos (ID varchar(50), Articulo varchar(35), FormaPago varchar(45))
GO

/****** POSCancelarPartida  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='POSCancelarPartida' AND xtype='U')
CREATE TABLE POSCancelarPartida (
    ID				varchar(36)	NOT NULL, 
	EliminaRenglon  bit default 0 )
GO


/****** POSDevolucionTotal  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='POSDevolucionTotal' AND xtype='U')
CREATE TABLE POSDevolucionTotal (
    ID				varchar(36)	NOT NULL, 
	Ofertados		bit default 0 )
GO

/****** POSCFD ******/
	IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCFD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCFD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCFD') AND type = 'U') 
  CREATE TABLE dbo.POSCFD (
	   Empresa			varchar(5)	NOT NULL,
	   Cliente			varchar(10)	NOT NULL,
	   
	   GenerarPDF			bit		DEFAULT 0	NULL,
	   NombreReportePDF		varchar(50)	NULL,
	   GuardarRutaPDF		varchar(255)	NULL,
	   GuardarArchivoPDF		varchar(255)	NULL,

	   GenerarXML			bit		DEFAULT 0	NULL,
	   GuardarRutaXML		varchar(255)	NULL,
	   GuardarArchivoXML		varchar(255)	NULL,
	   
	   EnviarMail			bit		DEFAULT 0	NULL,
	   EnviarAsunto			varchar(255)	NULL,
	   EnviarMensaje		varchar(255)	NULL,
	   EnviarGuardarArchivo		varchar(255)	NULL,
		
	   CONSTRAINT priPOSCFD PRIMARY KEY CLUSTERED (Empresa, Cliente)   
	   )
GO

/****** POSiSync ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSiSync')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSiSync', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSiSync') AND type = 'U') 
  CREATE TABLE dbo.POSiSync (
	   Host					varchar(20)	NOT NULL,	   
	   Cluster				varchar(20)	NULL,
	   EsOrigen				bit			NULL DEFAULT 0,
	   SincronizaArtSuc		bit			NULL DEFAULT 0,
	   Sucursal				int			NULL,
	   
	   CONSTRAINT priPOSiSync PRIMARY KEY CLUSTERED (Host)   
	   )
GO

EXEC spALTER_TABLE 'POSiSync', 'EsOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'POSiSync', 'SincronizaArtSuc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSiSync', 'Sucursal', 'int NULL'
GO


/*******************  tgPOSiSyncAC  *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSiSyncAC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSiSyncAC
GO
CREATE TRIGGER tgPOSiSyncAC ON POSiSync
--//WITH ENCRYPTION
FOR INSERT,UPDATE
AS BEGIN
  DECLARE
  @EsOrigenA            bit,
  @EsOrigenB            bit,
  @SincronizaArtSucA    bit,
  @SincronizaArtSucB    bit  
  
  SELECT @EsOrigenA = ISNULL(EsOrigen,0), @SincronizaArtSucA =  ISNULL(SincronizaArtSuc,0)  FROM INSERTED
  SELECT @EsOrigenB = ISNULL(EsOrigen,0), @SincronizaArtSucB =  ISNULL(SincronizaArtSuc,0)   FROM DELETED
  
  IF @EsOrigenA = 1 AND @SincronizaArtSucA = 1
  BEGIN
    EXEC sxActivarPOSArtSucursal 1
  END
  IF @EsOrigenA = 1 AND @SincronizaArtSucA = 0
  BEGIN
   EXEC sxActivarPOSArtSucursal 0
  END  
  IF @EsOrigenA = 0 AND @SincronizaArtSucA = 0
  BEGIN
    EXEC sxActivarPOSArtSucursal 0
  END    
  IF @EsOrigenA = 0 AND @SincronizaArtSucA = 1
  BEGIN
    EXEC sxActivarPOSArtSucursal 0
  END    
END
GO



/****** POSUsuarioAccion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSUsuarioAccion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSUsuarioAccion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSUsuarioAccion') AND type = 'U') 
  CREATE TABLE dbo.POSUsuarioAccion (
	Usuario		varchar(10)	NOT NULL,
	Accion		varchar(50)	NOT NULL
	   
	CONSTRAINT priPOSUsuarioAccion PRIMARY KEY CLUSTERED (Usuario, Accion)   
	)
GO

/****** POSUsuarioAccionTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSUsuarioAccionTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSUsuarioAccionTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSUsuarioAccionTemp') AND type = 'U') 
  CREATE TABLE dbo.POSUsuarioAccionTemp (
	ID          int IDENTITY(1,1),
    Estacion    int         NOT NULL,
	Usuario		varchar(10)	NOT NULL,
	Accion		varchar(50)	NOT NULL
	   
	CONSTRAINT priPOSUsuarioAccionTemp PRIMARY KEY CLUSTERED (ID,Estacion)   
	)
GO

/****** POSLDIIDTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIIDTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIIDTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIIDTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDIIDTemp (
	ID          int	NOT NULL,
    Estacion	int NOT NULL,
  
	CONSTRAINT priPOSLDIIDTemp PRIMARY KEY CLUSTERED (ID,Estacion)   
	)
GO


/****** LDIIDTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'LDIIDTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LDIIDTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.LDIIDTemp') AND type = 'U') 
  CREATE TABLE dbo.LDIIDTemp (
	ID          int         NOT NULL,
    Modulo      varchar(5)	NOT NULL,
    Estacion	int         NOT NULL,	   
  
	CONSTRAINT priLDIIDTemp PRIMARY KEY CLUSTERED (ID,Estacion,Modulo)   
	)
GO

/****** POSUsuarioMov ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSUsuarioMov')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSUsuarioMov', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSUsuarioMov') AND type = 'U') 
  CREATE TABLE dbo.POSUsuarioMov (
	Mov				varchar(20)	NOT NULL,
	Usuario			varchar(10)	NOT NULL,
	PuedeAutorizar	bit			NULL DEFAULT 1,
	
	CONSTRAINT priPOSUsuarioMov PRIMARY KEY CLUSTERED (Mov, Usuario)   
	)
ELSE IF (SELECT Fecha FROM Version) < CONVERT(DATETIME, '28-11-2016', 103)
BEGIN	
	EXEC spDROP_COLUMN 'POSUsuarioMov', 'PuedeAutorizar'
	EXEC spALTER_TABLE 'POSUsuarioMov', 'PuedeAutorizar', 'bit NULL DEFAULT 1 WITH VALUES'
END
GO

/****** POSUsuarioMovTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSUsuarioMovTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSUsuarioMovTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSUsuarioMovTemp') AND type = 'U') 
  CREATE TABLE dbo.POSUsuarioMovTemp (
	ID          int IDENTITY(1,1),
    Estacion	int         NOT NULL,
	Mov			varchar(20)	NOT NULL,
	Usuario		varchar(10)	NOT NULL,
	   
	CONSTRAINT priPOSUsuarioMovTemp PRIMARY KEY CLUSTERED (ID, Estacion)   
	)
GO
/****** POSUsuarioEstacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSUsuarioEstacion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSUsuarioEstacion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSUsuarioEstacion') AND type = 'U') 
  CREATE TABLE dbo.POSUsuarioEstacion (
    Empresa     char(5)     NOT NULL,
    Sucursal    int         NOT NULL,
    Estacion	int         NOT NULL,
	Usuario		varchar(10)	NOT NULL,
    Directorio  varchar(255)NULL	   
	CONSTRAINT priPOSUsuarioEstacion PRIMARY KEY CLUSTERED (Estacion, Usuario, Sucursal, Empresa)   
	)
GO
/****** POSHost ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHost')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHost', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHost') AND type = 'U') 
  CREATE TABLE dbo.POSHost (
	Host	varchar(20)	NOT NULL,
	Caja	varchar(10)	NULL,
	Cajero	varchar(10)	NULL,
	   
	CONSTRAINT priPOSHost PRIMARY KEY CLUSTERED (Host)   
	)	   
GO

/****** POSEstatusCaja ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSEstatusCaja')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSEstatusCaja', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSEstatusCaja') AND type = 'U') 
  CREATE TABLE dbo.POSEstatusCaja (
	Caja		varchar(10)	NOT NULL,	   
	Host		varchar(20)	NULL,	   
	Cajero		varchar(10)	NULL,
	Abierto		bit			DEFAULT 0 NULL,
	Bloqueado	bit			DEFAULT 0 NULL,
	Usuario		varchar(10)	NULL
	   
	CONSTRAINT priPOSEstatusCaja PRIMARY KEY CLUSTERED (Caja)   
	)	   
GO
EXEC spALTER_TABLE 'POSEstatusCaja', 'Bloqueado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSEstatusCaja', 'Usuario', 'varchar(10)	NULL'
GO


/****** POSDebug ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSDebug')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSDebug', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSDebug') AND type = 'U') 
  CREATE TABLE dbo.POSDebug (
  	Error	varchar(8000)	NULL)
GO	


/****** POSCfg ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCfg')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCfg', 'Maestro')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCfg') AND type = 'U') 
  CREATE TABLE dbo.POSCfg (
  	Empresa							varchar(5)	NOT NULL,
  	ImagenNombreAnexo				varchar(255)	NULL,
  	AgruparArticulos				bit				NULL,
	CantidadNotasEnProceso			int				NULL DEFAULT 1, 
	EnLineaSucursal					bit				NULL DEFAULT 1,
	EnLineaMatriz					bit				NULL DEFAULT 1,
	InsertarModuloVentas			bit				NULL DEFAULT 1,
	DefFormaPagoCambio				varchar(50)		NULL,
	FormaPagoSaldoAFavor			varchar(50)		NULL,
	RedondeoVenta					bit				NULL DEFAULT 0,
	RedondeoVentaModificar			bit				NULL DEFAULT 0,
	RedondeoVentaCodigo				varchar(30)		NULL,
	CodigoExtendido					bit				NULL DEFAULT 0,
	CodigoExtendidoMascara			varchar(30)		NULL,
	CodigoExtendidoLetraCodigo		varchar(1)		NULL,
	CodigoExtendidoLetraPeso		varchar(1)		NULL,
	CodigoExtendidoDecimalesPeso	int				NULL,
	MovFactura  					varchar(20)		NULL,
	MovSustitutos  					varchar(20)		NULL,	
	RedondeosMonetarios				int				NULL,
	TipoMonedero					varchar(50)		NULL,
	JuegoComponentes				bit				NULL DEFAULT 1,
	JuegoComponentesCB				bit				NULL DEFAULT 0,
	TieneTorreta					bit				NULL DEFAULT 0,
	MonederoLDI						bit				NULL DEFAULT 0,
	ImpuestoIncluido				bit				NULL DEFAULT 0,
	CajaOmision						bit				NULL DEFAULT 1,
	PuertoTorreta					varchar(20)		NULL,
	MovEmision						varchar(20)		NULL,
	MovCancelacion					varchar(20)		NULL,
	Publicidad						varchar(255)	NULL,
	Logo							varchar(255)	NULL,
	ArtOfertaFP 					varchar(20)		NULL,
	ConsecutivoMonedero				varchar(20)		NULL,
	ArtOfertaImporte				varchar(20)		NULL,
	WebService						bit				NULL DEFAULT 0,	
	WSServidorSQL					varchar(100)	NULL,	
	WSUsuarioSQL					varchar(100)	NULL,	
	WSContrasenaSQL					varchar(100)	NULL,	
	WSBaseDatos						varchar(100)	NULL,	
	WSUbicacion						varchar(255)	NULL,	
	WSPuertoSQL						int				NULL,
	DesgloseCC						bit				NULL DEFAULT 0,		
	MovDuplicados					bit				NULL DEFAULT 0,		
	POSInv							bit				NULL DEFAULT 0,		
	RefPedidoSinWS					bit				NULL DEFAULT 0,	
	CfgCierreDia					bit				NULL DEFAULT 0,
	ValidarCajasCerradas			bit				NULL DEFAULT 0,	
	SugerirFechaCierre				bit				NULL DEFAULT 0,	
	CondicionPedidoContado			varchar(50)		NULL,
	MovTraspasoVale					varchar(20)		NULL,
	CierreiSyncNivel				varchar(20)		NULL,
	HoraCierreDia					varchar(5)		NULL,
	DiasHabiles						varchar(20)		NULL,
	DiasDepuracion					int				NULL,
	ActivaBascula					bit				NULL DEFAULT 0,
	PanelAMostrar					VARCHAR(20)		NULL,
	CodigoArtComision				VARCHAR(20)		NULL,
	MensajeLimiteCajaT				VARCHAR(100)	NULL,
  CONSTRAINT priPOSCfg PRIMARY KEY CLUSTERED (Empresa)
  	)
GO	

EXEC spALTER_TABLE 'POSCFG', 'CantidadNotasEnProceso', 'int NULL DEFAULT 1'
EXEC spALTER_TABLE 'POSCFG', 'EnLineaSucursal', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'EnLineaMatriz', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'ImpuestoIncluido', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'InsertarModuloVentas', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'DefFormaPagoCambio', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'POSCFG', 'FormaPagoSaldoAFavor', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVenta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaModificar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaCodigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'POSCFG', 'ValidarDevolucion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'CodigoExtendido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'CodigoExtendidoMascara', 'varchar(30) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovFactura', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovSustitutos', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'CodigoExtendidoLetraCodigo', 'varchar(1) NULL'
EXEC spALTER_TABLE 'POSCFG', 'CodigoExtendidoLetraPeso', 'varchar(1) NULL'
EXEC spALTER_TABLE 'POSCFG', 'CodigoExtendidoDecimalesPeso', 'int NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeosMonetarios', 'int NULL'
EXEC spALTER_TABLE 'POSCFG', 'TipoMonedero', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'JuegoComponentes', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'JuegoComponentesCB', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'CajaOmision', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'TieneTorreta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'MonederoLDI', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'PuertoTorreta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovEmision', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovActivacionLDI', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovAbonoLDI', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MovCancelacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'Publicidad', 'varchar(255) NULL'
EXEC spALTER_TABLE 'POSCFG', 'Logo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'POSCFG', 'ArtOfertaFP', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'ConsecutivoMonedero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MatrizOpciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'WebService', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'ArtOfertaImporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSServidorSQL', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSPuertoSQL', 'int NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSUsuarioSQL', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSContrasenaSQL', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSCFG', 'CondicionPedidoContado', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSUbicacion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'POSCFG', 'WSBaseDatos', 'varchar(100) NULL'
EXEC spdrop_column 'POSCFG', 'MensajeLimiteCaja'
EXEC spdrop_column 'POSCFG', 'LimiteCaja'
EXEC spALTER_TABLE 'POSCFG', 'DesgloseCC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'MovDuplicados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSInv', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'CxcLocal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'RefPedidoSinWS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'MovTraspasoVale', 'varchar(20) NULL'

EXEC spALTER_TABLE 'POSCFG', 'CfgCierreDia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCfg', 'ValidarCajasCerradas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCfg', 'CierreiSyncNivel', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCfg', 'HoraCierreDia', 'varchar(5) NULL'
EXEC spALTER_TABLE 'POSCfg', 'SugerirFechaCierre', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCfg', 'DiasHabiles', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCfg', 'DiasDepuracion', 'int NULL' 

EXEC spALTER_TABLE 'POSCFG', 'ValidaFormaEnvio','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'RequiereConceptoDIN','bit NULL DEFAULT 0 WITH VALUES'	
EXEC spALTER_TABLE 'POSCFG', 'POSMonedero','bit NULL DEFAULT 0 WITH VALUES'	
EXEC spALTER_TABLE 'POSCFG', 'POSDefMonedero', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSDiasDev', 'int NULL'

EXEC spALTER_TABLE 'POSCFG', 'POSMonedero','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSDefMonedero', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSDiasDev', 'int NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSDefMovServ', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSDefMovDev', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSMonedaAct', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSDutyFree', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'AutoAjuste', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'VenderSinExistencia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'AutoAjusteUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'POSCFG', 'AutoAjusteConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'ActivaBascula', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'PanelAMostrar', 'VARCHAR(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'CodigoArtComision', 'VARCHAR(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MensajeLimiteCajaT', 'VARCHAR(100) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSAgenteDetMaestro', 'VARCHAR(15) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaProv', 'VARCHAR(10) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaConcepto', 'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaMov', 'VARCHAR(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaCtaDinero', 'VARCHAR(10) NULL'
EXEC spALTER_TABLE 'POSCFG', 'RedondeoVentaCondicion', 'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCFG', 'MultiMoneda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSSeriesLotesAutoOrden', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'Monedero', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'POSCFG', 'POSUsuarioAutoriza',            'VARCHAR(10) NULL'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarEditarEncabezado',  'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarEditarDetalle',     'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarReferenciaOrigen',  'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCancelarPartida',   'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarEliminarCaptura',   'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarListaMov',          'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarReversarPago',      'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarConsultaInv',       'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarFacturaAnticipo',   'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarFacturaCredito',    'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCobroCredito',      'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarDevolucion',        'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarDevolucionParcial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarFormaEnvio',        'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarLlamarPedidos',     'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarLlamarAnticipo',    'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarDatosCliente',      'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarAgregarCliente',    'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarVerValores',        'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarAperturaCaja',      'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarAumentoCaja',       'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCorteParcial',      'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCorteCaja',         'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarEgreso',            'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarIngreso',           'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarAperturaCajaMM',    'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCorteParcialMM',    'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarCorteCajaMM',       'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarRecoleccionMM',     'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'SinAutorizarRecoleccionMM',     'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'GenerarEmbarques',              'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSCFG', 'POSDefMovEmbarque',             'varchar(20) NULL'
EXEC spALTER_TABLE 'POSCFG', 'POSToleranciaVta',              'money NULL'
GO
EXEC spALTER_TABLE 'Cte',    'Ubicacion',                     'varchar(1000) NULL'
GO
IF NOT EXISTS (select * from MovClave WHERE Clave = 'VTAS.EMBARQUE')
  INSERT MovClave (Modulo, Clave, NombreOmision, SubClaveDe) values ('VTAS', 'VTAS.EMBARQUE', 'Embarque Estadistico', 'VTAS.EST')    
GO
IF NOT EXISTS(SELECT * FROM MovTipo WHERE modulo = 'VTAS' and Mov = 'Estadistica Embarque')
  INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) VALUES ('VTAS', 751, 'Estadistica Embarque', 'VTAS.EST', 'VTAS.EMBARQUE', 'VTAS', 'Estadistica Embarque')
GO


/****** POSLVentaEmbarques ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLVentaEmbarques')
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLVentaEmbarques', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLVentaEmbarques') AND type = 'U') -- drop table POSLVentaEmbarques
  CREATE TABLE dbo.POSLVentaEmbarques (
    ID            varchar(36)   NOT NULL,
    Renglon       float         NOT NULL,
    RenglonID     int           NOT NULL,
    Articulo      varchar(20)   NOT NULL,
    Cantidad      float         NOT NULL,
    TipoDireccion varchar(50)   NOT NULL,
    Ubicacion     varchar(1000) NOT NULL,
    MapaLatitud   float         NULL,
    MapaLongitud  float         NULL,    
  CONSTRAINT priPOSLVentaEmbarques PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonID, Ubicacion))
GO

/****** VentaDEmbarques ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'VentaDEmbarques')
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaDEmbarques', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.VentaDEmbarques') AND type = 'U') -- drop table VentaDEmbarques
  CREATE TABLE dbo.VentaDEmbarques (
    ID            INT           NOT NULL,
    Renglon       float         NOT NULL,
    RenglonID     int           NOT NULL,
    Articulo      varchar(20)   NOT NULL,
    Cantidad      float         NOT NULL,
    TipoDireccion varchar(50)   NOT NULL,
    Ubicacion     varchar(1000) NOT NULL,
    MapaLatitud   float         NULL,
    MapaLongitud  float         NULL,    
  CONSTRAINT priVentaDEmbarques PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonID, Ubicacion))
GO

/****** POSLDIEmpresa ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIEmpresa')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIEmpresa', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIEmpresa') AND type = 'U') 
  CREATE TABLE dbo.POSLDIEmpresa (
	Empresa			varchar(5)	NOT NULL,	
	EmpresaLDI		varchar(20)	NULL,	
  CONSTRAINT priPOSLDIEmpresa PRIMARY KEY CLUSTERED (Empresa))
GO


/****** POSLDISucursal ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDISucursal')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDISucursal', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDISucursal') AND type = 'U') 
  CREATE TABLE dbo.POSLDISucursal (
	Empresa			varchar(5)	NOT NULL,
	Sucursal		int		NOT NULL,	
	SucursalLDI		varchar(20)	NULL,	
  CONSTRAINT priPOSLDISucursal PRIMARY KEY CLUSTERED (Empresa, Sucursal))
GO		


/****** POSLDIServicio ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIServicio')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIServicio', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIServicio') AND type = 'U') 
  CREATE TABLE dbo.POSLDIServicio (
	Servicio		varchar(20)	NOT NULL,	
	DireccionIP		varchar(15)	NULL,
	Puerto			varchar(10)	NULL,
	TrxType			varchar(10)	NULL,
	TrxSubType		varchar(10)	NULL,
	EntryMode		varchar(10)	NULL,
	GeneraVoucher	varchar(10)	NULL,
	AnchoVoucher	int			NULL,
	Tipo			varchar(20)	NULL,	
  CONSTRAINT priPOSLDIServicio PRIMARY KEY CLUSTERED (Servicio))
GO	


/****** POSLDIFormaPago ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIFormaPago')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIFormaPago', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIFormaPago') AND type = 'U') 
  CREATE TABLE dbo.POSLDIFormaPago (
	FormaPago			varchar(50)	NOT NULL,	
	Servicio			varchar(20)	NULL,
	ServicioInverso		varchar(20)	NULL,
	Forma				varchar(50)	NULL,		
  CONSTRAINT priPOSLDIFormaPago PRIMARY KEY CLUSTERED (FormaPago))
GO
EXEC spALTER_TABLE 'POSLDIFormaPago', 'ServicioInverso',  'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'POSLDIFormaPago', 'AplicaMeses',  'varchar(10)'
GO
EXEC spALTER_TABLE 'POSLDIFormaPago', 'ApartirDe',  'money default 0'
GO


/****** POSLDIFormaPagoDMeses ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIFormaPagoDMeses')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIFormaPagoDMeses', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIFormaPagoDMeses') AND type = 'U') 
  CREATE TABLE dbo.POSLDIFormaPagoDMeses (
	FormaPago		varchar(50)	NOT NULL,	
	Meses			float)
GO


/****** POSLDIArtRecargaTel ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIArtRecargaTel')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIArtRecargaTel', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIArtRecargaTel') AND type = 'U') 
  CREATE TABLE dbo.POSLDIArtRecargaTel (
	Articulo		varchar(20)	NOT NULL,	
	Servicio		varchar(20)	NULL,
	Forma			varchar(50)	NULL,		

	CONSTRAINT priPOSLDIArtRecargaTel PRIMARY KEY CLUSTERED (Articulo)
  )
GO


/****** POSMovCondicion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSMovCondicion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSMovCondicion', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSMovCondicion') AND type = 'U') 
  CREATE TABLE dbo.POSMovCondicion (
	Mov			varchar(20)		NOT NULL,
	Condicion	varchar(50)		NOT NULL
	
	CONSTRAINT priPOSMovCondicion PRIMARY KEY CLUSTERED (Mov, Condicion)
	)
GO  
	

/****** POSC ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSC', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSC') AND type = 'U') 
  CREATE TABLE dbo.POSC (
	ID					Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,
	Empresa				varchar(5)			NULL,
	Sucursal			int					NULL,
	Host				varchar(20)			NULL,
	Mov					varchar(20)			NULL,	
	Prefijo				varchar(5)			NULL,
	FolioD				int					NULL,
	FolioA				int					NULL,
	Consecutivo			int					NULL,
	noAprobacion		int					NULL,
	fechaAprobacion		datetime			NULL,
	
	CONSTRAINT priPOSC PRIMARY KEY CLUSTERED (ID)
	)
GO
EXEC spDROP_PK 'POSC'
GO
EXEC spDROP_COLUMN 'POSC', 'Estacion'
EXEC spDROP_COLUMN 'POSC', 'Caja'
GO
EXEC spALTER_TABLE 'POSC', 'ID'	,	'uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL'
GO
EXEC spALTER_TABLE 'POSC', 'Empresa',     'varchar(20) NULL'
EXEC spALTER_TABLE 'POSC', 'Sucursal',	  'varchar(20) NULL'
EXEC spALTER_TABLE 'POSC', 'Host',	  'varchar(20) NULL'
EXEC spALTER_TABLE 'POSC', 'Mov',	  'varchar(20) NULL'
EXEC spALTER_TABLE 'POSC', 'FolioD',	  'int NULL'
EXEC spALTER_TABLE 'POSC', 'FolioA',	  'int NULL'
EXEC spALTER_TABLE 'POSC', 'noAprobacion',  'int NULL'
EXEC spALTER_TABLE 'POSC', 'fechaAprobacion', 'datetime NULL'
GO
EXEC spADD_PK 'POSC', 'ID'
GO


IF NOT EXISTS(SELECT Mov, Sucursal FROM POSC GROUP BY Mov, Sucursal HAVING COUNT(*) > 1)
BEGIN
  IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'POSC' AND sysindexes.name = 'POSCMovSucursal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX  POSCMovSucursal ON dbo.POSC (Mov, Sucursal,Host) ON [PRIMARY]
END
ELSE
BEGIN
  UPDATE POSCfg SET MovDuplicados = 1 WHERE Empresa IN (SELECT Empresa FROM POSC GROUP BY Mov, Sucursal,Empresa HAVING COUNT(*) > 1)
END
GO


/****** POSL ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSL')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSL', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSL') AND type = 'U') 
  CREATE TABLE dbo.POSL (
    ID							varchar(36)		NOT NULL, 
    Host						varchar(20)		NULL,
	Empresa						varchar(5)      NULL,	
	Modulo						varchar(5)		NULL,
	Mov 						varchar(20) 	NULL,
	MovID						varchar(20)		NULL,
	FechaEmision				datetime		NULL,
	FechaRegistro				datetime		NULL,
	Concepto					varchar(50)		NULL,
	Proyecto					varchar(50)		NULL,
	UEN							int				NULL,
	Moneda						varchar(10)		NULL,
	TipoCambio					float			NULL,
	Usuario						varchar(10)		NULL,
	Referencia					varchar(50)		NULL,
	Observaciones				varchar(200)	NULL,
	Estatus						varchar(15)		NULL,
	Cliente						varchar(10)		NULL,
	Nombre						varchar(100)	NULL,
	Direccion					varchar(100)	NULL,
	DireccionNumero				varchar(20)		NULL,
	DireccionNumeroInt			varchar(20)		NULL,
	EntreCalles					varchar(100)	NULL,
	Delegacion					varchar(100)	NULL,
	Colonia						varchar(100)	NULL,
	Poblacion					varchar(100)	NULL,
	Estado						varchar(30)		NULL,
	Pais						varchar(30)		NULL,
	Zona						varchar(30)		NULL,
	CodigoPostal				varchar(15)		NULL,
	RFC							varchar(15)		NULL,
	CURP						varchar(30)		NULL,
	EnviarA						int				NULL,
	Almacen						varchar(10)		NULL,
	Agente						varchar(10)		NULL,
	Cajero						varchar(10)		NULL,
	FormaEnvio					varchar(50)		NULL,
	Condicion					varchar(50)		NULL,
	Vencimiento					datetime		NULL,
	CtaDinero					varchar(10)		NULL,
	CtaDineroDestino			varchar(10)		NULL,
	Descuento					varchar(30)		NULL,
	DescuentoGlobal				float			NULL,
	Importe						money			NULL,
	Impuestos					money			NULL,
	Causa						varchar(50)		NULL,
	Atencion					varchar(50)		NULL,
	AtencionTelefono			varchar(50)		NULL,
	ListaPreciosEsp				varchar(20)		NULL,
	ZonaImpuesto				varchar(30)		NULL,
	Sucursal					int				NULL,
	OrigenTipo					varchar(10)		NULL,
	Origen						varchar(20)		NULL,
	OrigenID					varchar(20)		NULL,
	Tasa						varchar(50)		NULL,
	Prefijo						varchar(5)		NULL,
	Consecutivo					int				NULL,
	noAprobacion				int				NULL,
	fechaAprobacion				datetime		NULL,
	CadenaOriginal				text			NULL,
	Sello						varchar(255)	NULL,
	Certificado					varchar(20)		NULL,
	DocumentoXML				text			NULL,
	FechaCancelacion			datetime		NULL,
	FechaEntrega				datetime		NULL,
	FechaSello					datetime		NULL,
	UsuarioAutoriza				varchar(10)		NULL,
	IDR      					varchar(36)		NULL,
	Monedero					varchar(20)     NULL,
	Cluster						varchar(20)     NULL,
	BeneficiarioNombre			varchar(100)    NULL,
	Directo						bit             NULL DEFAULT 1,
	XmlJasper					varchar(max)    NULL,
	NombreArchivo				varchar(255)    NULL,
	UUID						varchar(50)     NULL,
    FechaTimbrado				datetime        NULL,
    SelloSat					varchar(255)    NULL,
    TFDVersion					varchar(10)     NULL,
    Caja						varchar(10)     NULL,
    NoCertificadoSAT			varchar(20)     NULL,
    TFDCadenaOriginal			varchar(max)    NULL,
    AlmacenDestino				varchar(10)		NULL,
    AfectadoLocal				bit             NULL DEFAULT 0,
    PedidoReferencia			varchar(50)     NULL,
    PedidoReferenciaID			int             NULL,
    Facturado					bit             NULL DEFAULT 0,
    CXCSaldoTotal				float           NULL,
    FechaInicio					datetime        NULL,
    CFDGenerado					bit             NULL DEFAULT 0,
    FechaNacimiento				datetime        NULL,
    EstadoCivil					varchar(20)     NULL,
    Conyuge						varchar(100)    NULL,	
    Sexo						varchar(20)     NULL,	
    Fuma						bit				NULL DEFAULT 0,
    Profesion					varchar(100)    NULL,	
    Puesto						varchar(100)    NULL,
    NumeroHijos					int             NULL,
    Religion					varchar(50)     NULL,	       
    CteCategoria				varchar(50)     NULL,	       
    CteGrupo					varchar(50)     NULL,	       
    CteFamilia					varchar(50)     NULL,
    RecargaTelefono				varchar(10)     NULL,
    EmidaControlNo				varchar(20)     NULL,
    EmidaTransactionId			varchar(20)     NULL,
    EmidaResponseMessage		varchar(500)    NULL,
    EmidaTransactionDateTime	datetime		NULL,
    EmidaResponseCode			varchar(2)      NULL,
    EmidaCarrierControlNo		varchar(20)     NULL,
    ResultadoIS					varchar(max)    NULL,    
	AfectadoEnLinea				bit             NULL DEFAULT 0,
            
	CONSTRAINT priPOSL PRIMARY KEY CLUSTERED (ID))
GO


EXEC spDROP_PK 'POSL'
GO
EXEC spALTER_TABLE 'POSL', 'Host',				'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSL', 'CtaDineroDestino',  'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSL', 'Nombre',			'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'Direccion',			'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'DireccionNumero',	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSL', 'DireccionNumeroInt','varchar(20)	NULL' 
EXEC spALTER_TABLE 'POSL', 'EntreCalles',	'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'Delegacion'	,	'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'Colonia'	,	'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'Poblacion'	,	'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'Estado'	,	'varchar(30)	NULL'
EXEC spALTER_TABLE 'POSL', 'Pais'	,	'varchar(30)	NULL'
EXEC spALTER_TABLE 'POSL', 'Zona'	,	'varchar(30)	NULL'
EXEC spALTER_TABLE 'POSL', 'CodigoPostal',	'varchar(15)	NULL'
EXEC spALTER_TABLE 'POSL', 'RFC'	,	'varchar(15)	NULL'
EXEC spALTER_TABLE 'POSL', 'CURP'	,	'varchar(30)	NULL'
EXEC spALTER_TABLE 'POSL', 'Tasa'	,	'varchar(15)	NULL'
EXEC spALTER_TABLE 'POSL', 'Prefijo'	,	'varchar(5)	NULL'
EXEC spALTER_TABLE 'POSL', 'Consecutivo'	,	'int	NULL'
EXEC spALTER_TABLE 'POSL', 'noAprobacion'	,	'int	NULL'
EXEC spALTER_TABLE 'POSL', 'fechaAprobacion'	,	'datetime	NULL'
EXEC spALTER_TABLE 'POSL', 'CadenaOriginal'	,	'Text	NULL'
EXEC spALTER_TABLE 'POSL', 'Sello'		,	'varchar(255)	NULL'
EXEC spALTER_TABLE 'POSL', 'Certificado'		,	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSL', 'DocumentoXML'		,	'Text	NULL'
EXEC spALTER_TABLE 'POSL', 'FechaCancelacion'	,	'datetime	NULL'
EXEC spALTER_TABLE 'POSL', 'FechaEntrega'	,	'datetime	NULL'
EXEC spALTER_TABLE 'POSL', 'FechaSello'	,	'datetime	NULL'
EXEC spALTER_TABLE 'POSL', 'UsuarioAutoriza',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSL', 'IDR',	'varchar(36)	NULL'
EXEC spALTER_TABLE 'POSL', 'Monedero'	,	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSL', 'Cluster'	,	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSL', 'BeneficiarioNombre'	,	'varchar(100)	NULL'
EXEC spALTER_TABLE 'POSL', 'AnticipoFacturadoTipoServicio','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'Directo','bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'IDDevolucion'	,'varchar(36)	NULL'
EXEC spALTER_TABLE 'POSL', 'IDDevolucionP'	,'varchar(36)	NULL'
EXEC spALTER_TABLE 'POSL', 'Devolucion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'DevolucionP', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'Orden', 'int IDENTITY'
EXEC spALTER_TABLE 'POSL', 'XmlJasper'	,'varchar(max)	NULL'
EXEC spALTER_TABLE 'POSL', 'NombreArchivo','varchar(255) NULL' 
EXEC spALTER_TABLE 'POSL', 'UUID','varchar(50) NULL' 
EXEC spALTER_TABLE 'POSL', 'FechaTimbrado','datetime NULL' 
EXEC spALTER_TABLE 'POSL', 'SelloSat','varchar(255) NULL' 
EXEC spALTER_TABLE 'POSL', 'TFDVersion','varchar(10) NULL' 
EXEC spALTER_TABLE 'POSL', 'NoCertificadoSAT','varchar(20) NULL' 
EXEC spALTER_TABLE 'POSL', 'TFDCadenaOriginal','varchar(max) NULL' 
EXEC spALTER_TABLE 'POSL', 'Caja','varchar(10)	NULL'
--REQ 13383
EXEC spALTER_TABLE 'POSL', 'RecargaTelefono', 'varchar(10) NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaControlNo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaTransactionId', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaResponseMessage', 'varchar(500) NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaTransactionDateTime', 'datetime NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaResponseCode', 'varchar(2) NULL'
EXEC spALTER_TABLE 'POSL', 'EmidaCarrierControlNo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'ResultadoIS', 'varchar(max) NULL'
EXEC spALTER_TABLE 'POSL', 'AfectadoEnLinea','bit NULL DEFAULT 0 WITH VALUES'	
EXEC spALTER_TABLE 'POSL', 'AlmacenDestino','varchar(10) NULL'
EXEC spALTER_TABLE 'POSL', 'AfectadoLocal','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'PedidoReferencia'	,'varchar(50)	NULL'
EXEC spALTER_TABLE 'POSL', 'PedidoReferenciaID','int	NULL'	
EXEC spALTER_TABLE 'POSL', 'CXCSaldoTotal','float	NULL'	
EXEC spALTER_TABLE 'POSL', 'Facturado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'CFDGenerado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'FechaNacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'POSL', 'EstadoCivil', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'Conyuge', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSL', 'Profesion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSL', 'Puesto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'POSL', 'Sexo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'Religion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSL', 'CteCategoria', 'varchar(50) NULL' 
EXEC spALTER_TABLE 'POSL', 'CteGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSL', 'CteFamilia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSL', 'NumeroHijos', 'int NULL'
EXEC spALTER_TABLE 'POSL', 'Fuma','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSL', 'NombreDF','varchar(30) NULL'
EXEC spALTER_TABLE 'POSL', 'ApellidosDF','varchar(60) NULL'
EXEC spALTER_TABLE 'POSL', 'PasaporteDF','varchar(30) NULL'
EXEC spALTER_TABLE 'POSL', 'NacionalidadDF','varchar(30) NULL'
EXEC spALTER_TABLE 'POSL', 'NoVueloDF','varchar(20) NULL'
EXEC spALTER_TABLE 'POSL', 'AerolineaDF','varchar(50) NULL'
EXEC spALTER_TABLE 'POSL', 'OrigenDF','varchar(100) NULL'
EXEC spALTER_TABLE 'POSL', 'DestinoDF','varchar(100) NULL'

EXEC spALTER_TABLE 'POSL', 'FechaInicio','datetime NULL' 
--REQ 13383
GO
EXEC spDROP_COLUMN 'POSL', 'Estacion'
GO
EXEC spALTER_COLUMN 'POSL', 'ID', 'varchar(36)		NOT NULL'
GO
EXEC spADD_PK 'POSL', 'ID'

GO

/****** POSVentaCobro ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaCobro')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaCobro', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaCobro') AND type = 'U') 
  CREATE TABLE dbo.POSVentaCobro (
	ID                      varchar(36)  NOT NULL,
    Importe1                money        NULL, 
    Importe2                money        NULL, 
    Importe3                money        NULL, 
    Importe4                money        NULL, 
    Importe5                money        NULL, 
    FormaCobro1             varchar(50)  NULL, 
    FormaCobro2             varchar(50)  NULL, 
    FormaCobro3             varchar(50)  NULL, 
    FormaCobro4             varchar(50)  NULL, 
    FormaCobro5             varchar(50)  NULL, 
    Referencia1             varchar(50)  NULL, 
    Referencia2             varchar(50)  NULL, 
    Referencia3             varchar(50)  NULL,  
    Referencia4             varchar(50)  NULL,  
    Referencia5             varchar(50)  NULL,  
    Observaciones1          varchar(100) NULL,  
    Observaciones2          varchar(100) NULL,  
    Observaciones3          varchar(100) NULL,  
    Observaciones4          varchar(100) NULL,  
    Observaciones5          varchar(100) NULL,  
    Cambio                  money        NULL,  
    Redondeo                money        NULL,  
    DelEfectivo             money        NULL,  
    Sucursal                int          NULL,  
    CtaDinero               varchar(10)  NULL,  
    Cajero                  varchar(10)  NULL,  
    Condicion               varchar(50)  NULL,  
    Vencimiento             datetime     NULL, 
    Actualizado             bit          NULL, 
    TotalCobrado            money        NULL,  
    SucursalOrigen          int          NULL,  
    POSTipoCambio1          float        NULL,  
    POSTipoCambio2          float        NULL,  
    POSTipoCambio3          float        NULL,  
    POSTipoCambio4          float        NULL,  
    POSTipoCambio5          float        NULL, 
          
	CONSTRAINT priPOSVentaCobro PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** POSTarjetaSerieMov ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSTarjetaSerieMov')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSTarjetaSerieMov', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSTarjetaSerieMov') AND type = 'U') 
  CREATE TABLE dbo.POSTarjetaSerieMov (
	IDR                     int IDENTITY,
    ID                      varchar(36)  NOT NULL,
    Empresa                 char(5)      NULL, 
    Modulo                  char(5)      NULL, 
    Serie                   varchar(20)  NULL, 
    Importe                 money        NULL, 
    Sucursal                int          NULL, 
    TipoCambioTarjeta       float        NULL, 
    ImporteTarjeta          float        NULL,
          
	CONSTRAINT priPOSTarjetaSerieMov PRIMARY KEY CLUSTERED (ID,IDR)
  )
GO


/****** POSLSerieLote ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLSerieLote')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLSerieLote', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLSerieLote') AND type = 'U') 
  CREATE TABLE dbo.POSLSerieLote (
	IDL			Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,
	Orden		int		IDENTITY,	
    ID			varchar(36)	NULL,
    RenglonID	int			NULL,
    Articulo	varchar(20)	NULL,
    SubCuenta	varchar(50)	NULL,
    SerieLote	varchar(50)	NULL,
	OrdenDPRef	int			NULL,
        
	CONSTRAINT priPOSLSerieLote PRIMARY KEY CLUSTERED (IDl)
	)
GO	

EXEC spALTER_TABLE 'POSLSerieLote', 'OrdenDPRef','int	NULL'
GO

/****** POSLSerieLoteTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLSerieLoteTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLSerieLoteTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLSerieLoteTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLSerieLoteTemp (
	Estacion    int			NOT NULL,
    ID			varchar(36)	NOT NULL,
    RenglonID	int		NOT NULL,
    Articulo	varchar(20)	NULL,
    SubCuenta	varchar(50)	NULL,
    SerieLote	varchar(50)	NOT NULL,
    Cantidad    float       NULL
        
	CONSTRAINT priPOSLSerieLoteTemp PRIMARY KEY CLUSTERED (Estacion,ID,RenglonID,SerieLote)
	)
GO

	
/****** POSFormatoEtiqueta******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSFormatoEtiqueta')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSFormatoEtiqueta', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSFormatoEtiqueta') AND type = 'U') 
  CREATE TABLE dbo.POSFormatoEtiqueta (
	Nombre				varchar(50)		NOT NULL,
	Plantilla			varchar(max)	NULL,
	EspecificarCopias	bit             NULL,
	Tipo                varchar(20)     NULL,--(Existencias Especifica)

	CONSTRAINT priPOSFormatoEtiqueta PRIMARY KEY CLUSTERED (Nombre)   
	)
GO


/****** POSLDISaldoMonederoTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDISaldoMonederoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDISaldoMonederoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDISaldoMonederoTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDISaldoMonederoTemp (
	Estacion            int             NOT NULL,
    Monedero			varchar(30)		NOT NULL,
    Cliente 			varchar(10)		NULL,
    MonedaMonedero 		varchar(10)		NULL,
    MonedaSucursal 		varchar(10)		NULL,
    TipoCambio 			float   		NULL,
    Importe 			float   		NULL,
    ImporteMonedaSuc	float   		NULL,
  
	CONSTRAINT priPOSLDISaldoMonederoTemp PRIMARY KEY CLUSTERED (Estacion,Monedero)
	)
GO


/****** POSAuxiliarArtPrecio******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSAuxiliarArtPrecio')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSAuxiliarArtPrecio', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSAuxiliarArtPrecio') AND type = 'U') 
  CREATE TABLE dbo.POSAuxiliarArtPrecio (
	ID                  int IDENTITY(1,1),
	Articulo			varchar(20)		NOT NULL,
	SubCuenta			varchar(50)		NULL,
	Fecha               datetime        NULL,
	ListaPrecios        varchar(20)     NULL,
	PrecioAnterior		float           NULL, 
	Precio              float           NULL,
	Unidad              varchar(50)     NULL,	   
	
	CONSTRAINT priPOSAuxiliarArtPrecio PRIMARY KEY CLUSTERED (ID)   
	)
GO

EXEC spALTER_TABLE 'POSAuxiliarArtPrecio', 'Unidad','varchar(50)	NULL'
GO


/****** POSAuxiliarArtPrecioTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSAuxiliarArtPrecioTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSAuxiliarArtPrecioTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSAuxiliarArtPrecioTemp') AND type = 'U') 
  CREATE TABLE dbo.POSAuxiliarArtPrecioTemp (
	Estacion        int             NOT NULL,
	Articulo		varchar(20)		NOT NULL,
	Codigo			varchar(30)		NOT NULL,
	SubCuenta		varchar(50)		NOT NULL,
	Unidad			varchar(50)		NOT NULL,
	ListaPrecios    varchar(20)     NOT NULL,
	PrecioAnterior	float           NULL, 
	Precio          float           NULL,	   
	
	CONSTRAINT priPOSAuxiliarArtPrecioTemp PRIMARY KEY CLUSTERED (Estacion, Articulo, SubCuenta, Codigo,ListaPrecios)   
	)
GO		
EXEC spALTER_TABLE 'POSAuxiliarArtPrecioTemp', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSAuxiliarArtPrecioTemp', 'Codigo', 'varchar(30) NULL'	
GO


/****** POSRedondeoTemp	 ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSRedondeoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSRedondeoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSRedondeoTemp') AND type = 'U') 
  CREATE TABLE dbo.POSRedondeoTemp (
	 ID    			varchar(36)		NOT NULL,
	 Importe        float           NOT NULL,	   
	 CONSTRAINT priPOSRedondeoTemp PRIMARY KEY CLUSTERED (ID)   
	)
GO	

	
/****** POSTrabajo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSTrabajo')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSTrabajo', 'N/A')
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSTrabajo') AND type = 'U') 
  CREATE TABLE dbo.POSTrabajo (
    Trabajo         varchar(255) NOT NULL,
    Frecuencia      varchar(50)  NULL,
    Valor           int          NULL,
    Activo          bit          NOT NULL DEFAULT 0,
	CONSTRAINT priPOSTrabajo PRIMARY KEY CLUSTERED (Trabajo)
  )
GO		
	

/****** POSLVenta ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLVenta')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLVenta', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLVenta') AND type = 'U') 
  CREATE TABLE dbo.POSLVenta (
    ID					varchar(36)	NOT NULL,
    Renglon				float		NOT NULL,
    RenglonSub			int			NOT NULL DEFAULT 0,       
    RenglonID			int			NULL,
    RenglonTipo			varchar(1)	NULL,
    Aplica				varchar(20)	NULL,
    AplicaID			varchar(20)	NULL,
    Cantidad			float		NULL,
    Articulo			varchar(20)	NULL,
    SubCuenta			varchar(50)	NULL,
    Precio				float		NULL,
    PrecioImpuestoInc	float		NULL,
    PrecioSugerido		float		NULL,
    DescuentoLinea		float		NULL,
    DescuentoImporte	money		NULL,
    Impuesto1			float		NULL,
    Impuesto2			float		NULL,
    Impuesto3			float		NULL,
    Unidad				varchar(50)	NULL,
    Factor				float		NULL,
    CantidadInventario	float		NULL,
    Puntos				money		NULL,
    Comision			float		NULL,
    CantidadObsequio	float		NULL,
    OfertaID			int			NULL,
    SerieLote			varchar(50)	NULL,
	LDIServicio			varchar(20)	NULL,
	Juego    			varchar(10)	NULL,
	Almacen   			varchar(10)	NULL,
	Aplicado            bit         NULL DEFAULT 0,        
	AnticipoFacturado   bit         NULL DEFAULT 0, 
	AplicaDescGlobal    bit         NULL DEFAULT 0, 
	AnticipoRetencion   float       NULL,   
	Codigo              varchar(30)	NULL, 
	EsMonedero          bit	        NULL DEFAULT 0,   
	CONSTRAINT priPOSLVenta PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub))
GO
EXEC spDROP_PK 'POSLVenta'
GO


EXEC spALTER_TABLE 'POSLVenta', 'LDIServicio',	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'PrecioImpuestoInc','float	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Juego',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Almacen',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Codigo',	'varchar(30)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Aplicado','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSLVenta', 'AnticipoFacturado','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSLVenta', 'AplicaDescGlobal','bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSLVenta', 'AnticipoRetencion','float	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'EsMonedero','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSLVenta', 'CantidadM','float	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Observaciones', 'varchar(200)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDP1', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDP2', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDP3', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoP1', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoP2', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoP3', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDG1', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDG2', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OfertaIDG3', 'int NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoG1', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoG2', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoG3', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'CantidadSaldo', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'Agente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'POSLVenta', 'DiasMoratorios', 'int'
EXEC spALTER_TABLE 'POSLVenta', 'TasaMoratorios', 'float NULL'
EXEC spALTER_TABLE 'POSLVenta', 'ArtObservaciones', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'ImporteReal',	'money'
EXEC spALTER_TABLE 'POSLVenta', 'ImporteAPagar',	'money'
EXEC spALTER_TABLE 'POSLVenta', 'ImporteMoratorio',	'money'
EXEC spALTER_TABLE 'POSLVenta', 'MoratorioAPagar',	'money'
EXEC spALTER_TABLE 'POSLVenta', 'Origen',	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'OrigenID',	'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSLVenta', 'POSAgentePend', 'bit DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'POSLVenta', 'DescuentoAd', 'float NULL'
GO

EXEC spADD_PK 'POSLVenta', 'ID, Renglon, RenglonSub'
GO

IF NOT EXISTS(SELECT * FROM sysindexes i JOIN sysobjects t ON(i.ID = t.ID) WHERE i.name='POSLVentaID' AND t.name='POSLVenta')
CREATE INDEX POSLVentaID ON POSLVenta(ID)
GO

IF NOT EXISTS(SELECT * FROM sysindexes i JOIN sysobjects t ON(i.ID = t.ID) WHERE i.name='POSLVentaArt' AND t.name='POSLVenta')
CREATE INDEX POSLVentaArt ON POSLVenta(ID,Articulo)
GO


/****** POSLTipoCambioRef ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLTipoCambioRef')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLTipoCambioRef', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLTipoCambioRef') AND type = 'U') 
  CREATE TABLE dbo.POSLTipoCambioRef (
	Sucursal		int			NOT NULL,
	TipoCambio		float		NULL,
	Moneda          varchar(10)	NOT NULL,
	EsPrincipal     bit			NULL DEFAULT 0,
	
	CONSTRAINT priPOSLTipoCambioRef	PRIMARY KEY CLUSTERED (Sucursal,Moneda)
	)
GO
EXEC spALTER_TABLE 'POSLTipoCambioRef', 'EsPrincipal',	'bit NULL DEFAULT 0 WITH VALUES'
GO


/****** POSLRefBancaria ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLRefBancaria')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLRefBancaria', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLRefBancaria') AND type = 'U') 
  CREATE TABLE dbo.POSLRefBancaria (
	IDL			Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,	
    ID			varchar(36)			NULL,
    Voucher		varchar(MAX)		NULL,
    Banco		varchar(255)		NULL
	        		
    CONSTRAINT priPOSLRefBancaria PRIMARY KEY CLUSTERED (IDL)
  )
GO


/****** POSLCobro ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLCobro')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLCobro', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLCobro') AND type = 'U') 
  CREATE TABLE dbo.POSLCobro (
	IDL					Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,	
    ID					varchar(36)			NULL,
    FormaPago			varchar(50)			NULL,       
    Importe				float				NULL,
    Referencia			varchar(50)			NULL,
    Monedero			varchar(36)			NULL,
    CtaDinero			varchar(36)			NULL,
    CtaDineroDestino	varchar(36)			NULL,
    Fecha				datetime			NULL,
	Caja				varchar(10)			NULL,
	Cajero				varchar(10)			NULL,
	Host				varchar(20)			NULL,
	MonederoMoneda		varchar(10)			NULL,
	MonederoTipoCambio	float    			NULL,
	MonederoImporte  	float    			NULL,
	        		
    CONSTRAINT priPOSLCobro	PRIMARY KEY CLUSTERED (IDL)
  )
GO


EXEC spDROP_PK 'POSLCobro'
GO
EXEC spALTER_TABLE 'POSLCobro', 'IDL'	,	'uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL'
EXEC spALTER_TABLE 'POSLCobro', 'Monedero',	'varchar(36)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'CtaDinero',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'CtaDineroDestino',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Fecha',	'datetime	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Caja',		'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Cajero',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Host',		'varchar(20)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'ImporteRef',	'float		NULL'
EXEC spALTER_TABLE 'POSLCobro', 'TipoCambio',	'float		NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Voucher',	'varchar(MAX)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'Banco',	'varchar(255)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'MonedaRef',	'varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'MonederoMoneda','varchar(10)	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'MonederoImporte','float	NULL'
EXEC spALTER_TABLE 'POSLCobro', 'MonederoTipoCambio',	'float		NULL'
EXEC spALTER_TABLE 'POSLCobro', 'RID',	'int	IDENTITY(1,1)'
GO

EXEC spALTER_COLUMN 'POSLCobro', 'FormaPago', 'varchar(36)		NULL'
GO
EXEC spADD_PK 'POSLCobro', 'IDL'
GO

IF NOT EXISTS(SELECT * FROM sysindexes i JOIN sysobjects t ON(i.ID = t.ID) WHERE i.name='POSLCobroID' AND t.name='POSLCobro')
CREATE INDEX POSLCobroID ON POSLCobro(ID)
GO
IF NOT EXISTS(SELECT * FROM sysindexes i JOIN sysobjects t ON(i.ID = t.ID) WHERE i.name='POSLCobroIDFormaPago' AND t.name='POSLCobro')
CREATE INDEX POSLCobroIDFormaPago ON POSLCobro(ID,FormaPago)
GO
IF NOT EXISTS(SELECT * FROM sysindexes i JOIN sysobjects t ON(i.ID = t.ID) WHERE i.name='POSLCobroIDFormaPagoF' AND t.name='POSLCobro')
CREATE INDEX POSLCobroIDFormaPagoF ON POSLCobro(ID,FormaPago)INCLUDE(Fecha)
GO


/****** POSLAmortizacionPagos ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLAmortizacionPagos')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLAmortizacionPagos', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLAmortizacionPagos') AND type = 'U') 
  CREATE TABLE dbo.POSLAmortizacionPagos (
	IDL			Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,	
    ID			varchar(36)			NULL,
    Fecha		datetime			NULL,
    Importe		float				NULL,
    Interes		float				NULL,
        
    CONSTRAINT priPOSLAmortizacionPagos	PRIMARY KEY CLUSTERED (IDL)
  )
EXEC spALTER_TABLE 'POSLAmortizacionPagos', 'Interes', 'float		NULL'
GO
  

/****** POSLAuxiliar ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLAuxiliar')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLAuxiliar', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLAuxiliar') AND type = 'U') 
  CREATE TABLE dbo.POSLAuxiliar (
	IDL				varchar(36)	NOT NULL,        
    ID				varchar(36)	NULL,
    Rama			varchar(5)	NULL,
    FormaPago		varchar(50)	NULL,
    Importe			float		NULL,
    Referencia		varchar(50)	NULL,
	EsCancelacion	bit			DEFAULT 0 NULL,
	        		
    CONSTRAINT priPOSLAuxiliar	PRIMARY KEY CLUSTERED (IDL)
  )
GO
EXEC spDROP_PK 'POSLAuxiliar'
GO
EXEC spDROP_COLUMN 'POSLAuxiliar', 'IDM'
EXEC spALTER_TABLE 'POSLAuxiliar', 'IDL', 'varchar(36)		NOT NULL'
EXEC spALTER_COLUMN 'POSLAuxiliar', 'ID', 'varchar(36)		NULL'
GO
EXEC spADD_PK 'POSLAuxiliar', 'IDL'
GO
EXEC spDROP_TABLE 'POSLAccion'
GO


/****** POSLAccion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLAccion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLAccion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLAccion') AND type = 'U') 
  CREATE TABLE dbo.POSLAccion (
  	Host			varchar(20)	NOT NULL,
  	Caja			varchar(10)	NOT NULL,
    Accion			varchar(50)	NOT NULL,        
    FormaPago		varchar(50)	NULL,
    Referencia		varchar(50)	NULL,
        
    CONSTRAINT PriPOSLAccion PRIMARY KEY CLUSTERED (Host, Caja, Accion)
  )
GO          
EXEC spDROP_PK 'POSLAccion'
GO
EXEC spALTER_TABLE 'POSLAccion', 'Caja', 'varchar(10) NULL'
EXEC spALTER_TABLE 'POSLAccion', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSLAccion', 'Referencia', 'varchar(50) NULL'
GO
EXEC spADD_PK 'POSLAccion', 'Host, Caja, Accion'
GO


/****** POSLValidarDevolucion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLValidarDevolucion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLValidarDevolucion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLValidarDevolucion') AND type = 'U') 
  CREATE TABLE dbo.POSLValidarDevolucion (
  	ID			varchar(36)	NOT NULL,
    IDOrigen	varchar(36)	NOT NULL,
        
    CONSTRAINT priPOSLValidarDevolucion PRIMARY KEY CLUSTERED (ID, IDOrigen)
  )
GO          
EXEC spDROP_PK 'POSLValidarDevolucion'
GO
EXEC spALTER_COLUMN 'POSLValidarDevolucion', 'ID',	 'varchar(36)		NOT NULL'
EXEC spALTER_COLUMN 'POSLValidarDevolucion', 'IDOrigen', 'varchar(36)		NOT NULL'
GO
EXEC spADD_PK 'POSLValidarDevolucion', 'ID, IDOrigen'
GO


/****** POSLArtSeleccionado ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLArtSeleccionado')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLArtSeleccionado', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLArtSeleccionado') AND type = 'U') 
  CREATE TABLE dbo.POSLArtSeleccionado (	
	ID			varchar(36)		NOT NULL,        
    Articulo	varchar(20)		NULL,
    SubCuenta	varchar(50)		NULL,	
    Unidad	    varchar(50)		NULL,
	Codigo		varchar(30)		NULL,
    CONSTRAINT priPOSLArtSeleccionado	PRIMARY KEY CLUSTERED (ID)
  )
GO

EXEC spALTER_TABLE 'POSLArtSeleccionado', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSLArtSeleccionado', 'Codigo', 'varchar(30) NULL'
GO
EXEC spDROP_PK 'POSLArtSeleccionado'
GO
EXEC spALTER_COLUMN 'POSLArtSeleccionado', 'ID',	 'varchar(36)		NOT NULL'
GO
EXEC spADD_PK 'POSLArtSeleccionado', 'ID'
GO


/****** POSLDIVentaID ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIVentaID')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIVentaID', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIVentaID') AND type = 'U') 
  CREATE TABLE dbo.POSLDIVentaID (
  	ID				varchar(36)		NOT NULL,
    Referencia1		varchar(MAX)	NULL,
    Referencia2		varchar(MAX)	NULL,
    Referencia3		varchar(MAX)	NULL,        
	
	CONSTRAINT priPOSLDIVentaID PRIMARY KEY CLUSTERED (ID)
  )
GO  


/****** POSValeSerie ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSValeSerie')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSValeSerie', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSValeSerie') AND type = 'U') 
  CREATE TABLE dbo.POSValeSerie (
	Serie    	varchar(36)	NOT NULL,
	Sucursal	int			NULL,
	Estatus  	varchar(15)	NULL,
	Moneda		varchar(10)	NULL,
	Tipo		varchar(50)	NULL,	
	Cliente		varchar(10)	NULL,	
	
	CONSTRAINT priPOSValeSerie  PRIMARY KEY CLUSTERED (Serie)
	)
GO


IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDITemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDITemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDITemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDITemp	 (
	ID    				varchar(36)		NOT NULL,
	Servicio	        varchar(20)     NULL,	   
	Empresa				varchar(5)      NULL,	 
	Usuario				varchar(10)     NULL,
	Sucursal	        int             NULL,
	Monedero            varchar(36)     NULL,
	Importe             float           NULL,	
	EstacionTrabajoFija	int             NULL,     
	Estacion            int             NULL,
    Referencia          varchar(255)    NULL,
  
	CONSTRAINT priPOSLDITemp PRIMARY KEY CLUSTERED (ID)   
   )
GO  

EXEC spALTER_TABLE 'POSLDITemp', 'EstacionTrabajoFija','int NULL'
EXEC spALTER_TABLE 'POSLDITemp', 'Estacion','int NULL'
EXEC spALTER_TABLE 'POSLDITemp', 'Referencia',  'varchar(255) NULL'
GO


/****** LDIServicioEstacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'LDIServicioEstacion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LDIServicioEstacion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.LDIServicioEstacion') AND type = 'U') 
  CREATE TABLE dbo.LDIServicioEstacion (
	EstacionFija	int      		NOT NULL,	
	DireccionIP		varchar(15)		NOT NULL,
	Puerto			varchar(10)		NOT NULL,
	
	CONSTRAINT priLDIServicioEstacion PRIMARY KEY CLUSTERED (EstacionFija)
	)
GO


/****** POSLDIMonederoSaldoFavor ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIMonederoSaldoFavor')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIMonederoSaldoFavor', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIMonederoSaldoFavor') AND type = 'U') 
  CREATE TABLE dbo.POSLDIMonederoSaldoFavor (
	ID			varchar(36)		NOT NULL,
	Monedero	varchar(36)		NULL,

	CONSTRAINT priPOSLDIMonederoSaldoFavor PRIMARY KEY CLUSTERED (ID)
	)
GO


/****** POSLDIRespuestaTemp	 ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIRespuestaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIRespuestaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIRespuestaTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDIRespuestaTemp	 (
	ID    				varchar(36)		NOT NULL,
	Ok                  int             NULL,	   
	OkRef               varchar(255)    NULL,	 
	Mensaje             varchar(8000)   NULL,
	CadenaRespuesta     varchar(max)    NULL,
	Cadena              varchar(max)    NULL,
	IDLog               int             NULL,	     
  
	CONSTRAINT priPOSLDIRespuestaTemp PRIMARY KEY CLUSTERED (ID)   
	)
GO
EXEC spALTER_TABLE 'POSLDIRespuestaTemp', 'IDLog','int NULL'
GO

/****** POSLDIRecargaTemp******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIRecargaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIRecargaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIRecargaTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDIRecargaTemp	 (
	ID    		varchar(36)		NOT NULL,
	Servicio	varchar(20)     NULL,	   
	Empresa	    varchar(5)      NULL,	 
	Usuario	    varchar(10)     NULL,
	Sucursal	int             NULL,
	Importe     float           NULL,
    Telefono    varchar(10)     NULL,	     
  
	CONSTRAINT priPOSLDIRecargaTemp PRIMARY KEY CLUSTERED (ID)   
	)
GO


/****** POSLDIPagoServicioTemp******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIPagoServicioTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIPagoServicioTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIPagoServicioTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDIPagoServicioTemp	 (
	ID    		varchar(36)		NOT NULL,
	Servicio	varchar(20)     NULL,	   
	Empresa	    varchar(5)      NULL,	 
	Usuario	    varchar(10)     NULL,
	Sucursal	int             NULL,
	Importe     float           NULL,
    Codigo      varchar(50)     NULL,     	     
  
	CONSTRAINT priPOSLDIPagoServicioTemp PRIMARY KEY CLUSTERED (ID)   
   )
GO


/****** POSEmidaRecargaTemp******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSEmidaRecargaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSEmidaRecargaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSEmidaRecargaTemp') AND type = 'U') 
  CREATE TABLE dbo.POSEmidaRecargaTemp	 (
	ID    		varchar(36)		NOT NULL,
	Estacion	int             NULL,
	Empresa	    varchar(5)      NULL,	 
	Usuario	    varchar(10)     NULL,
	Sucursal	int             NULL,
	Telefono    varchar(10)     NULL,     
	
	CONSTRAINT priPOSEmidaRecargaTemp PRIMARY KEY CLUSTERED (ID)   
	)
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSLDIVenta') and sysstat & 0xf = 2) DROP VIEW dbo.POSLDIVenta
GO
CREATE VIEW POSLDIVenta
--//WITH ENCRYPTION
AS
SELECT i.ID,i.Referencia1,i.Referencia2,i.Referencia3,p.Mov,p.MovID,v.Articulo
  FROM POSLDIVentaID i 
  JOIN POSL p ON p.ID = i.ID
  JOIN POSLVenta v ON p.ID = v.ID AND v.LDIServicio IS NOT NULL
 WHERE p.Estatus = 'CONCLUIDO'  
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSCliente') and sysstat & 0xf = 2) DROP VIEW dbo.POSCliente
GO
CREATE VIEW POSCliente
--//WITH ENCRYPTION
AS
SELECT Cte.Cliente, Cte.Nombre, Cte.RFC, Cte.Estatus, Cte.Situacion, Cte.Categoria,Cte.Familia,Cte.Grupo,Cte.Agente,Cte.Tipo,Cte.Espacio,cb.Codigo
  FROM Cte Cte LEFT JOIN CB cb ON Cte.Cliente = cb.Cuenta AND cb.TipoCuenta = 'Clientes'  
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSSerieLoteTemp1') and sysstat & 0xf = 2) DROP VIEW dbo.POSSerieLoteTemp1
GO
CREATE VIEW POSSerieLoteTemp1
--//WITH ENCRYPTION
AS
 SELECT p.ID,  ISNULL(SUM(p.Cantidad),0.0) Cantidad,p.Articulo,p.SubCuenta,p.RenglonID
   FROM POSLVenta p 
   JOIN Art a ON p.Articulo = a.Articulo
  WHERE  a.Tipo IN('SERIE','LOTE')
 GROUP BY p.ID, p.Articulo,p.SubCuenta,p.RenglonID  
GO 


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSSerieLoteTemp2') and sysstat & 0xf = 2) DROP VIEW dbo.POSSerieLoteTemp2
GO
CREATE VIEW POSSerieLoteTemp2
--//WITH ENCRYPTION
AS
 SELECT s.ID,  ISNULL(COUNT(s.SerieLote),0.0) SerieLote ,s.Articulo,s.SubCuenta,s.RenglonID
   FROM POSLSerieLote s  
   JOIN Art a ON s.Articulo = a.Articulo
  WHERE  a.Tipo IN('SERIE','LOTE')
 GROUP BY s.ID  ,s.Articulo,s.SubCuenta,s.RenglonID  
GO 
 
 
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSSerieLoteTemp') and sysstat & 0xf = 2) DROP VIEW dbo.POSSerieLoteTemp
GO
CREATE VIEW POSSerieLoteTemp
--//WITH ENCRYPTION
AS
 SELECT p.ID,  ISNULL(SUM(p.Cantidad),0.0) Cantidad, ISNULL(SUM(s.SerieLote),0.0) SerieLote 
   FROM POSSerieLoteTemp1 p LEFT JOIN  POSSerieLoteTemp2 s  ON s.ID = p.ID AND p.Articulo = s.Articulo AND ISNULL(p.SubCuenta,'') = ISNULL(s.SubCuenta,'') AND p.RenglonID=s.RenglonID
 GROUP BY p.ID   
GO 


/****** POSHerrCteFrecuente ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrCteFrecuente')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrCteFrecuente', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrCteFrecuente') AND type = 'U') 
  CREATE TABLE dbo.POSHerrCteFrecuente (
	ID			int IDENTITY NOT NULL,
    Estacion	int          NOT NULL,
    Cliente     varchar(10)  NOT NULL,        
    Monedero	varchar(20)  NULL,
    Error       varchar(255) NULL,	        		
    
	CONSTRAINT priPOSHerrCteFrecuente PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** POSHerrCteFrecuenteD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrCteFrecuenteD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrCteFrecuenteD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrCteFrecuenteD') AND type = 'U') 
  CREATE TABLE dbo.POSHerrCteFrecuenteD (
	Cliente         varchar(10)  NOT NULL,        
    Monedero		varchar(20)  NOT NULL,
    FechaEmision	datetime     NULL,
    Mov             varchar(20)  NULL,	        		
    MovID           varchar(20)  NULL,	        		
    
	CONSTRAINT priPOSHerrCteFrecuenteD PRIMARY KEY CLUSTERED (Cliente,Monedero)
  )
GO

/****** POSHerrCteFrecuenteG ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrCteFrecuenteG')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrCteFrecuenteG', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrCteFrecuenteG') AND type = 'U') 
  CREATE TABLE dbo.POSHerrCteFrecuenteG (
	Estacion   int          NOT NULL,
    Moneda     varchar(10)  NULL,	        		
    Tipo       varchar(50)  NULL,       
    Categoria  varchar(50)  NULL,  
    Grupo      varchar(50)  NULL,  
    Familia    varchar(50)  NULL,  
    FechaD     datetime     NULL,     
    FechaA     datetime     NULL,     
  
	CONSTRAINT priPOSHerrCteFrecuenteG PRIMARY KEY CLUSTERED (Estacion)
  )
GO


EXEC spALTER_TABLE 'POSHerrCteFrecuenteG', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSHerrCteFrecuenteG', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSHerrCteFrecuenteG', 'Familia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'POSHerrCteFrecuenteG', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'POSHerrCteFrecuenteG', 'FechaA', 'datetime NULL'
GO


/****** POSHerrCancelacionVale ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrCancelacionVale')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrCancelacionVale', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrCancelacionVale') AND type = 'U') 
  CREATE TABLE dbo.POSHerrCancelacionVale (
	ID				int IDENTITY NOT NULL,
    Estacion		int          NOT NULL,
    Cliente         varchar(10)  NOT NULL,        
    Monedero		varchar(20)  NULL,
    FechaVigencia	datetime     NULL,
    Error           varchar(255) NULL,	        		
    
	CONSTRAINT priPOSHerrCancelacionVale PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** POSHerrCancelacionValeD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrCancelacionValeD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrCancelacionValeD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrCancelacionValeD') AND type = 'U') 
  CREATE TABLE dbo.POSHerrCancelacionValeD (
    Estacion   int          NOT NULL,
    Tipo       varchar(50)  NULL,       
    Fecha      datetime     NULL,     
  
	CONSTRAINT priPOSHerrCancelacionValeD PRIMARY KEY CLUSTERED (Estacion)
  )
GO

/****** POSHerrTraspasoVale ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHerrTraspasoVale')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHerrTraspasoVale', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHerrTraspasoVale') AND type = 'U') 
  CREATE TABLE dbo.POSHerrTraspasoVale (
	ID			int IDENTITY NOT NULL,
    Estacion	int          NOT NULL,
    MonederoD	varchar(20)  NULL,
    MonederoA	varchar(20)  NULL,
    Error       varchar(255) NULL,	        		
  
	CONSTRAINT priPOSHerrTraspasoVale PRIMARY KEY CLUSTERED (ID)
  )
GO


/****** POSLDITicket ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDITicket')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDITicket', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDITicket') AND type = 'U') 
  CREATE TABLE dbo.POSLDITicket (
	Estacion   int          NOT NULL,
    ID         int IDENTITY,
    RID        varchar(36)  NOT NULL,
    Campo      varchar(255) NULL      
  
	CONSTRAINT priPOSLDITicket PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO


/****** POSReporteTicket ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSReporteTicket')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSReporteTicket', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSReporteTicket') AND type = 'U') 
  CREATE TABLE dbo.POSReporteTicket (
	Estacion   int         NOT NULL,
    ID         int IDENTITY,
    RID        varchar(36)  NOT NULL,
    Campo      varchar(255) NULL,
    AbreCajon  bit          NULL
      
	CONSTRAINT priPOSReporteTicket PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO
EXEC spALTER_TABLE 'POSReporteTicket', 'AbreCajon','bit NULL DEFAULT 0 WITH VALUES'
GO


/****** POSCobroFormasPago ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCobroFormasPago')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCobroFormasPago', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCobroFormasPago') AND type = 'U') 
  CREATE TABLE dbo.POSCobroFormasPago (
	Empresa     varchar(5)	NOT NULL,
    Sucursal	int			NOT NULL,     
    F2          varchar(50)	NULL,
    F3          varchar(50)	NULL,
    F4          varchar(50)	NULL,
    F5          varchar(50)	NULL,
    F6          varchar(50)	NULL,
    F7          varchar(50)	NULL,
    F8          varchar(50)	NULL,      
  
	CONSTRAINT priPOSCobroFormasPago PRIMARY KEY CLUSTERED (Empresa,Sucursal)
  )
GO

EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA01',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA02',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA03',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA04',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA05',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA06',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA07',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoA08',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB01',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB02',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB03',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB04',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB05',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB06',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB07',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoB08',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC01',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC02',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC03',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC04',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC05',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC06',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC07',	'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'BancoC08',	'VARCHAR(50) NULL'
GO
/***** JLMR 25032013  ****/
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA01',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA02',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA03',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA04',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA05',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA06',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA07',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCA08',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB01',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB02',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB03',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB04',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB05',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB06',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB07',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCB08',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC01',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC02',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC03',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC04',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC05',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC06',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC07',	'VARCHAR(255) NULL'
EXEC spALTER_TABLE 'POSCobroFormasPago', 'TDCC08',	'VARCHAR(255) NULL'
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSArtComponente') and sysstat & 0xf = 2) DROP VIEW dbo.POSArtComponente
GO
CREATE VIEW POSArtComponente
--//WITH ENCRYPTION
AS
 SELECT j.Articulo ArticuloP, j.Descripcion Componente, j.Juego, d.Opcion Articulo, NULLIF(d.SubCuenta,'')SubCuenta,
 CASE WHEN NULLIF(d.SubCuenta,'') IS NOT NULL THEN d.Opcion+' ('+d.SubCuenta+')' ELSE d.Opcion END  ArtSubCuenta, j.Descripcion
   FROM ArtJuego j JOIN ArtJuegoD d ON j.Articulo = d.Articulo AND j.Juego = d.Juego  
GO


/****** POSTempArtJuego ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSTempArtJuego')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSTempArtJuego', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSTempArtJuego') AND type = 'U') 
  CREATE TABLE dbo.POSTempArtJuego (
	Estacion    int             NOT NULL,
    ID          int             NULL,
    RID         varchar(36)     NOT NULL,
    RenglonID   int             NOT NULL,
    Articulo	varchar(20)     NOT NULL,
      
	CONSTRAINT priPOSTempArtJuego PRIMARY KEY CLUSTERED (Estacion,RID,RenglonID,Articulo)
  )
GO


/****** POSArtJuegoComponente ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtJuegoComponente')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtJuegoComponente', 'N/A')
IF  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtJuegoComponente') AND type = 'U') DROP TABLE POSArtJuegoComponente
  CREATE TABLE dbo.POSArtJuegoComponente (
    Estacion			int             NOT NULL,
    ID					int IDENTITY,
    RID					varchar(36)     NOT NULL,
    RenglonID			int             NOT NULL,
    Cantidad			float           NOT NULL,
    CantidadComponente	float           NOT NULL,
    Articulo			varchar(20)     NOT NULL,
    ArtSubCuenta		varchar(100)    NULL,
    Juego				varchar(10)     NOT NULL,
    Componente			varchar(100)	NOT NULL,
    Opcion				varchar(20)		NULL,
    Opcional			bit				NOT NULL,
    SubCuenta			varchar(50)		NULL,
    Recalcular			bit				NULL,
    EsDevolucion		int				NULL	DEFAULT 0,    
      
  CONSTRAINT priPOSArtJuegoComponente PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO

EXEC spALTER_TABLE 'POSArtJuegoComponente', 'EsDevolucion', 'bit NULL DEFAULT 0 WITH VALUES' 
EXEC spALTER_TABLE 'POSArtJuegoComponente', 'CantidadComponente', 'float NULL' 
GO


/****** POSLDILog ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDILog')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDILog', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDILog') AND type = 'U') 
  CREATE TABLE dbo.POSLDILog (
  	ID						int IDENTITY,
  	IDModulo                varchar(36)     NOT NULL,
  	Modulo                  varchar(5)      NOT NULL,
  	Servicio                varchar(50)     NULL,
    Fecha                   varchar(20)     NULL,
    TipoTransaccion         varchar(50)     NULL, 
    TipoSubservicio         varchar(50)     NULL,
    CodigoRespuesta         varchar(50)     NULL, 
    DescripcionRespuesta    varchar(255)    NULL, 
    OrigenRespuesta         varchar(50)     NULL, 
    InfoAdicional           varchar(50)     NULL, 
    IDTransaccion           varchar(50)     NULL,
    CodigoAutorizacion      varchar(50)     NULL,
    Importe                 float           NULL,
    Comprobante             varchar(Max)    NULL,
    Cadena                  varchar(Max)    NULL,
    CadenaRespuesta         varchar(Max)    NULL,
    RIDCobro                int             NULL,
    TotalRegistros          varchar(100)    NULL,
    ListaMontos             varchar(Max)    NULL,
    ListaReferencias        varchar(Max)    NULL,
    ListaFechas             varchar(Max)    NULL,
    ListaConceptos          varchar(Max)    NULL,
    ListaMovimientos        varchar(Max)    NULL,
        
	CONSTRAINT priPOSLDILog PRIMARY KEY CLUSTERED (ID,IDModulo,Modulo)
  	)
GO  
EXEC spALTER_TABLE 'POSLDILog', 'RIDCobro', 'int NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'TotalRegistros', 'varchar(100) NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'ListaMontos', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'ListaReferencias', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'ListaFechas', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'ListaConceptos', 'varchar(max) NULL' 
EXEC spALTER_TABLE 'POSLDILog', 'ListaMovimientos', 'varchar(max) NULL' 
GO


/****** POSVFALog ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVFALog')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVFALog', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVFALog') AND type = 'U') 
  CREATE TABLE dbo.POSVFALog (
  	ID						int   IDENTITY,
  	IDModulo                varchar(36)     NOT NULL,
  	Modulo                  varchar(5)      NOT NULL,
  	Referencia              varchar(50)     NULL,
  	Accion                  varchar(20)     NOT NULL,
  	CodigoAutorizacion      varchar(255)    NULL,
  	EstatusTransaccion      varchar(255)    NULL,
  	FechaTransaccion        datetime        NULL,
  	IDTransaccion           varchar(255)    NULL,
  	Monto                   float           NULL,
  	Moneda                  varchar(20)     NULL,
  	NumeroTarjeta           varchar(255)    NULL,
  	Tarjetahabiente         varchar(500)    NULL,
  	Error                   varchar(20)     NULL,
  	Mensaje                 varchar(max)    NULL,
  	TransaccionOriginal     varchar(255)    NULL,

  	CONSTRAINT priPOSVFALog PRIMARY KEY CLUSTERED (ID,IDModulo,Modulo)
  	)
GO


/****** POSVFAFormaPago ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVFAFormaPago')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVFAFormaPago', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVFAFormaPago') AND type = 'U') 
  CREATE TABLE dbo.POSVFAFormaPago (
	FormaPago		varchar(50)	NOT NULL,
	
	CONSTRAINT priPOSVFAFormaPago PRIMARY KEY CLUSTERED (FormaPago))
GO


/****** POSOfertaTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSOfertaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSOfertaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSOfertaTemp') AND type = 'U') 
  CREATE TABLE dbo.POSOfertaTemp (
	ID                  int IDENTITY(11,1)	NOT NULL,
    Estacion            int					NOT NULL,
    IDR                 varchar(36)			NULL,
    Articulo            varchar(20)			NULL,
    Renglon             float				NULL,	        		
    PrecioSugerido		float				NULL, 
    Precio              float				NULL, 
    Puntos              float				NULL,
    Cantidad            float				NULL,             
  
	CONSTRAINT priPOSOfertaTemp PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO


/****** POSOfertaTempD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSOfertaTempD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSOfertaTempD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSOfertaTempD') AND type = 'U') 
  CREATE TABLE dbo.POSOfertaTempD (
    ID              int          NOT NULL,
    Estacion        int          NOT NULL,
    IDR             varchar(36)  NULL,
    Articulo        varchar(20)  NULL,
    Renglon         float        NULL,	        		
    PrecioSugerido	float        NULL, 
    Precio          float        NULL, 
    Puntos          float        NULL,
    CantidadO       float        NULL,             
    CantidadM       float        NULL,             
  
	CONSTRAINT priPOSOfertaTempD PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO

/****** POSArtCBTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtCBTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtCBTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtCBTemp') AND type = 'U') 
  CREATE TABLE dbo.POSArtCBTemp (
    ID          int IDENTITY(1,1),
    Estacion    int         NOT NULL,
    Codigo      varchar(30)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	SubCuenta   varchar(50)	NULL,
	Cantidad    int     	NULL,
	   
	CONSTRAINT priPOSArtCBTemp PRIMARY KEY CLUSTERED (ID,Estacion, Codigo)   
	)
GO


/****** POSArtSucursal ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtSucursal')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtSucursal', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtSucursal') AND type = 'U') 
  CREATE TABLE dbo.POSArtSucursal (
	Articulo				varchar(20)		NOT NULL,	
	Host     				varchar(20)		NOT NULL,	
	Sucursal                int      		NOT NULL,
	Rama                    varchar(20)     NULL, 
    Descripcion1			varchar(100)    NULL, 
    Descripcion2            varchar(255)    NULL, 
    NombreCorto             varchar(20)     NULL, 
    Grupo                   varchar(50)     NULL, 
    Categoria               varchar(50)     NULL, 
    Familia                 varchar(50)     NULL, 
    Linea                   varchar(50)     NULL, 
    Fabricante              varchar(50)     NULL, 
    Impuesto1               float           NULL, 
    Impuesto2               float           NULL, 
    Impuesto3               float           NULL, 
    Factor                  varchar(50)     NULL, 
    Unidad                  varchar(50)     NULL, 
    UnidadCompra            varchar(50)     NULL, 
    UnidadTraspaso          varchar(50)     NULL, 
    Tipo                    varchar(20)     NULL, 
    TipoOpcion              varchar(20)     NULL, 
    Accesorios              bit             NULL, 
    Sustitutos              bit             NULL, 
    MonedaPrecio            varchar(10)     NULL, 
    PrecioLista             money           NULL, 
    PrecioMinimo            money           NULL, 
    Estatus                 varchar(15)     NULL, 
    Alta                    datetime        NULL, 
    Precio2                 money           NULL, 
    Precio3                 money           NULL, 
    Precio4                 money           NULL, 
    Precio5                 money           NULL, 
    Precio6                 money           NULL, 
    Precio7                 money           NULL, 
    Precio8                 money           NULL, 
    Precio9                 money           NULL, 
    Precio10                money           NULL, 
    BasculaPesar            bit             NULL, 
    TieneMovimientos        bit             NULL, 
    Retencion1              float           NULL, 
    Retencion2              float           NULL, 
    Retencion3              float           NULL, 
    MonedaCosto             varchar(10)     NULL, 
    TipoCosteo              varchar(10)     NULL, 
    Calificacion            int             NULL,	
    TipoImpuesto1           varchar(10)     NULL, 
    TipoImpuesto2           varchar(10)     NULL, 
    TipoImpuesto3           varchar(10)     NULL, 
    TipoImpuesto4           varchar(10)     NULL, 
    TipoImpuesto5           varchar(10)     NULL, 
    TipoRetencion1          varchar(10)     NULL, 
    TipoRetencion2          varchar(10)     NULL, 
    TipoRetencion3          varchar(10)     NULL, 
                
	CONSTRAINT priPOSArtSucursal PRIMARY KEY CLUSTERED (Articulo,Sucursal))
GO

EXEC spALTER_TABLE 'POSArtSucursal',  'Rama' , 'varchar(20)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal' , 'Descripcion1' , 'varchar(100)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Descripcion2' , 'varchar(255)  NULL' 
EXEC spALTER_TABLE 'POSArtSucursal','NombreCorto' , 'varchar(20)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Grupo' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Estatus' , 'varchar(15)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Categoria' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Familia' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal' ,'Linea' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal','Fabricante' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Impuesto1' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal' ,'Impuesto2' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Impuesto3' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal' ,'Factor' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Unidad' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal' ,'UnidadCompra' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'UnidadTraspaso' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Tipo' , 'varchar(20)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoOpcion' , 'varchar(20)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Accesorios' , 'bit  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Sustitutos' , 'bit  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'MonedaPrecio' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'MonedaCosto' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoCosteo' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'PrecioLista' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'PrecioMinimo' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Estatus' , 'varchar(15)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Alta' , 'datetime  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio2' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio3' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio4' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio5' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio6' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio7' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio8' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio9' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Precio10' , 'money  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'BasculaPesar' , 'bit  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TieneMovimientos' , 'bit  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Retencion1' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Retencion2' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Retencion3' , 'float  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'Calificacion' , 'smallint  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoImpuesto1' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoImpuesto2' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoImpuesto3' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoImpuesto4' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoImpuesto5' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoRetencion1' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoRetencion2' , 'varchar(10)  NULL'
EXEC spALTER_TABLE 'POSArtSucursal', 'TipoRetencion3' , 'varchar(10)  NULL'
GO


/****** POSArtCodigoSucursal ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtCodigoSucursal')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtCodigoSucursal', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtCodigoSucursal') AND type = 'U') 
  CREATE TABLE dbo.POSArtCodigoSucursal (	
	Sucursal    int      		NOT NULL,
 	Codigo      varchar(30)     NOT NULL, 
	Articulo	varchar(20)		NULL,
	SubCuenta	varchar(50)     NULL,
	Cantidad    float           NULL,
	Unidad      varchar(50)     NULL,		
	Host     	varchar(20)		NOT NULL,	

	CONSTRAINT priPOSArtCodigoSucursal PRIMARY KEY CLUSTERED (Codigo,Sucursal)
	)
GO


/****** POSArtSucursalTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtSucursalTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtSucursalTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtSucursalTemp') AND type = 'U') 
  CREATE TABLE dbo.POSArtSucursalTemp (
	Estacion	int		NOT NULL,
	Sucursal	int     NOT NULL,
	
	CONSTRAINT priPOSArtSucursalTemp PRIMARY KEY CLUSTERED (Estacion,Sucursal)
	)
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSArSucursal2') and sysstat & 0xf = 2) DROP VIEW dbo.POSArSucursal2
GO
CREATE VIEW POSArSucursal2
--//WITH ENCRYPTION
AS
	SELECT
		POSArtSucursal.Articulo,
		POSArtSucursal.Host,
		POSArtSucursal.Sucursal,
		Art.Rama,
		Art.Descripcion1,
		Art.Grupo,
		Art.Categoria,
		Art.Familia,
		Art.Fabricante,
		Art.Linea,
		CB.Codigo,
		CB.Cuenta
	FROM POSArtSucursal
	LEFT OUTER JOIN Art ON POSArtSucursal.Articulo=Art.Articulo
	LEFT OUTER JOIN CB ON POSArtSucursal.Articulo=CB.Cuenta AND CB.TipoCuenta = 'Articulos'
GO


/****** POSOfertaTempCancelacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSOfertaTempCancelacion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSOfertaTempCancelacion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSOfertaTempCancelacion') AND type = 'U') 
  CREATE TABLE dbo.POSOfertaTempCancelacion (
	ID              int IDENTITY(11,1)NOT NULL,
    Estacion        int          NOT NULL,
    IDR             varchar(36)  NULL,
    Articulo        varchar(20)  NULL,
    Renglon         float        NULL,	        		
    PrecioSugerido	float        NULL, 
    Precio          float        NULL, 
    Puntos          float        NULL,
    Cantidad        float        NULL,             
  
	CONSTRAINT priPOSOfertaTempCancelacion PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO


/****** POSLDenominacion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDenominacion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDenominacion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDenominacion') AND type = 'U') 
  CREATE TABLE dbo.POSLDenominacion (
	ID              varchar(36)  NOT NULL,
    Formapago       varchar(50)  NOT NULL,
    Nombre          varchar(50)  NULL,
    Denominacion	float        NOT NULL,    
    Cantidad        int          NULL,        
  
	CONSTRAINT priPOSLDenominacion PRIMARY KEY CLUSTERED (ID, Formapago,Denominacion)
  )
GO


/****** POSLDenominacionTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDenominacionTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDenominacionTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDenominacionTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLDenominacionTemp (
	Estacion        int          NOT NULL,
    ID              varchar(36)  NOT NULL,
    Formapago       varchar(50)  NOT NULL,
    Nombre          varchar(50)  NULL,
    Denominacion	float        NOT NULL,    
    Cantidad        int          NULL,        
  
	CONSTRAINT priPOSLDenominacionTemp PRIMARY KEY CLUSTERED (ID,Estacion, Formapago,Denominacion)
  )
GO


/****** POSLCBAccionTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLCBAccionTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLCBAccionTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLCBAccionTemp') AND type = 'U') 
  CREATE TABLE dbo.POSLCBAccionTemp (
	Estacion        int          NOT NULL,
	ID              int IDENTITY NOT NULL,
    Codigo          varchar(30)  NULL,
    CodigoAnterior	varchar(30)  NULL,
    Accion          varchar(50)  NOT NULL,

	CONSTRAINT priPOSLCBAccionTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO


/****** POSConceptoCXCTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSConceptoCXCTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSConceptoCXCTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSConceptoCXCTemp') AND type = 'U') 
  CREATE TABLE dbo.POSConceptoCXCTemp (
	Orden       int          NULL,
    Estacion    int          NOT NULL,
    Concepto	varchar(50)  NOT NULL,        
  
	CONSTRAINT priPOSConceptoCXCTemp PRIMARY KEY CLUSTERED (Estacion,Concepto)
  )
GO


/****** POSAlmTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSAlmTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSAlmTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSAlmTemp') AND type = 'U') 
  CREATE TABLE dbo.POSAlmTemp (
	Orden       int          NULL,
    Estacion	int          NOT NULL,
    Almacen     varchar(10)  NOT NULL,        
  
	CONSTRAINT priPOSAlmTemp PRIMARY KEY CLUSTERED (Estacion,Almacen)
  )
GO


/****** POSCxcAnticipoTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCxcAnticipoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCxcAnticipoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCxcAnticipoTemp') AND type = 'U') 
  CREATE TABLE dbo.POSCxcAnticipoTemp (
	Estacion                int          NOT NULL,
    ID                      int IDENTITY NOT NULL,
    RID                     int          NULL,
    Cliente                 varchar(10)  NULL,
    Mov                     varchar(20)  NULL,
    MovID                   varchar(20)  NULL,
    FechaEmision            datetime     NULL,
    Referencia              varchar(50)  NULL,
    Concepto                varchar(50)  NULL,
    AnticipoSaldo           float        NULL,
    Moneda                  varchar(10)  NULL,
    TipoCambio              float        NULL,
    Importe                 float        NULL,
    Impuestos               float        NULL,
    Retencion               float        NULL, 
    AnticipoAplicar         float        NULL,
    GUIDOrigen              varchar(50)  NULL,
    PedidoReferencia        varchar(50)  NULL,
    PedidoReferenciaID      int          NULL,
    DiasCredito             int          NULL,
    DiasMoratorios          int          NULL,
    Vencimiento             datetime     NULL,
    ImporteTotal            float        NULL,
    Saldo                   float        NULL,
    SaldoTotal              float        NULL,
  
	CONSTRAINT priPOSCxcAnticipoTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO

EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'GUIDOrigen' , 'varchar(50)  NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'PedidoReferencia'	,'varchar(50)	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'PedidoReferenciaID','int	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'DiasCredito','int	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'DiasMoratorios','int	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'ImporteTotal','float	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'Saldo','float	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'SaldoTotal','float	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'Vencimiento','datetime	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'InteresesMoratorios','float	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'SaldoInteresesMoratorios','float	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'Origen','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'OrigenID','varchar(20)	NULL'  
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'Estatus','varchar(15)	NULL'  
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'MovTipoCambio','float'  
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'SaldoInteresesOrdinarios','money'  
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'LineaCredito','varchar(20)	NULL' 
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'RamaID','int	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipoTemp', 'Empresa','varchar (5)'
GO


/****** POSCxcAnticipoTempD  (Detalle) ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCxcAnticipoTempD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCxcAnticipoTempD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCxcAnticipoTempD') AND type = 'U') 
	CREATE TABLE dbo.POSCxcAnticipoTempD (
		Estacion					int         NOT NULL,
		ID 							int         NOT NULL,
 		Renglon						float	    NOT NULL,
		RenglonSub					int			NOT NULL DEFAULT 0,
		Importe						money       NULL,
		Aplica 						varchar(20) NULL,
		AplicaID					varchar(20)	NULL,
		InteresesOrdinarios			money		NULL,
		InteresesOrdinariosQuita	float		NULL,
		InteresesMoratorios			money		NULL,
		InteresesMoratoriosQuita	float		NULL,
		ImpuestoAdicional			float		NULL,
		TasaMoratorios				float		NULL,
		Sucursal					int			NOT NULL DEFAULT 0,
	
	CONSTRAINT priPOSCxcAnticipoTempD PRIMARY KEY CLUSTERED (ID, Estacion, Renglon, RenglonSub)
)
GO

EXEC spALTER_TABLE 'POSCxcAnticipoTempD', 'Aplicado','bit'
GO

/****** POSCxcAnticipo ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCxcAnticipo')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCxcAnticipo', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCxcAnticipo') AND type = 'U') 
  CREATE TABLE dbo.POSCxcAnticipo (
	ID                      varchar(36)  NOT NULL,
    RID                     int          NOT NULL,
    Cliente                 varchar(10)  NULL,
    Mov                     varchar(20)  NULL,
    MovID                   varchar(20)  NULL,
    FechaEmision            datetime     NULL,
    Referencia              varchar(50)  NULL,
    Concepto                varchar(50)  NULL,
    AnticipoSaldo           float        NULL,
    Moneda                  varchar(10)  NULL,
    TipoCambio              float        NULL,
    Importe                 float        NULL,
    Impuestos               float        NULL,
    Retencion               float        NULL, 
    AnticipoAplicar         float        NULL,
    GUIDOrigen              varchar(50)  NULL,
    PedidoReferencia        varchar(50)  NULL,
    PedidoReferenciaID      int          NULL,  
  
	CONSTRAINT priPOSCxcAnticipo PRIMARY KEY CLUSTERED (ID, RID)
  )
GO

EXEC spALTER_TABLE 'POSCxcAnticipo', 'PedidoReferencia'	,'varchar(50)	NULL'
EXEC spALTER_TABLE 'POSCxcAnticipo', 'PedidoReferenciaID','int	NULL'
GO


/****** POSVentaPedidoTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaPedidoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaPedidoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaPedidoTemp') AND type = 'U') 
	CREATE TABLE dbo.POSVentaPedidoTemp (
		Estacion              int             NOT NULL,
		ID                    int             NOT NULL,   
		Empresa               varchar(5)      NULL, 
		Mov                   varchar(20)     NULL, 
		MovID                 varchar(20)     NULL, 
		FechaEmision          datetime        NULL, 
		Concepto              varchar(50)     NULL, 
		Proyecto              varchar(50)     NULL, 
		UEN                   int             NULL, 
		Moneda                varchar(10)     NULL, 
		TipoCambio            float           NULL, 
		Usuario               varchar(10)     NULL, 
		Referencia            varchar(50)     NULL, 
		Observaciones         varchar(100)    NULL, 
		Estatus               varchar(15)     NULL, 
		Cliente               varchar(10)     NULL, 
		EnviarA               int             NULL, 
		Almacen               varchar(10)     NULL, 
		Agente                varchar(10)     NULL, 
		AgenteServicio        varchar(10)     NULL, 
		AgenteComision        float           NULL, 
		FormaEnvio            varchar(50)     NULL, 
		Condicion             varchar(50)     NULL, 
		Vencimiento           datetime        NULL, 
		CtaDinero             varchar(10)     NULL, 
		Descuento             varchar(30)     NULL, 
		DescuentoGlobal       float           NULL, 
		Importe               money           NULL, 
		Impuestos             money           NULL, 
		Saldo                 money           NULL, 
		DescuentoLineal       money           NULL, 
		OrigenTipo            varchar(10)     NULL, 
		Origen                varchar(20)     NULL, 
		OrigenID              varchar(20)     NULL,
		FechaRegistro         datetime        NULL, 
		Causa                 varchar(50)     NULL, 
		Atencion              varchar(50)     NULL, 
		AtencionTelefono      varchar(50)     NULL, 
		ListaPreciosEsp       varchar(20)     NULL, 
		ZonaImpuesto          varchar(30)     NULL, 
		Sucursal              int             NULL, 
		SucursalOrigen        int             NULL,  
		Anticipos             float           NULL,
		Monedero              varchar(20)     NULL,
  
	CONSTRAINT priPOSVentaPedidoTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO

EXEC spALTER_TABLE 'POSVentaPedidoTemp ', 'Anticipos','float	NULL'
EXEC spALTER_TABLE 'POSVentaPedidoTemp ', 'Monedero','varchar(20)	NULL'
GO


/****** POSVentaPedidoDTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaPedidoDTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaPedidoDTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaPedidoDTemp') AND type = 'U') 
	CREATE TABLE dbo.POSVentaPedidoDTemp (
		Estacion              int             NOT NULL,
		ID                    int             NOT NULL,   
		Renglon               float           NOT NULL, 
		RenglonSub            int             NULL, 
		RenglonID             int             NULL, 
		RenglonTipo           char(1)         NULL,
		Cantidad              float           NULL, 
		Almacen               varchar(10)     NULL, 
		EnviarA               int             NULL, 
		Articulo              varchar(20)     NULL, 
		SubCuenta             varchar(50)     NULL, 
		Precio                float           NULL, 
		PrecioSugerido        float           NULL, 
		DescuentoLinea        money           NULL, 
		Impuesto1             float           NULL, 
		Impuesto2             float           NULL, 
		Impuesto3             float           NULL, 
		Aplica                varchar(20)     NULL, 
		AplicaID              varchar(20)     NULL, 
		CantidadPendiente     float           NULL, 
		CantidadReservada     float           NULL, 
		CantidadCancelada     float           NULL, 
		CantidadOrdenada      float           NULL, 
		CantidadA             float           NULL, 
		Unidad                varchar(50)     NULL, 
		Factor                float           NULL, 
		Puntos                money           NULL, 
		CantidadObsequio      float           NULL, 
		OfertaID              int             NULL, 
		Sucursal              int             NULL, 
		Codigo                varchar(30)     NULL,  
  
	CONSTRAINT priPOSVentaPedidoDTemp PRIMARY KEY CLUSTERED (ID,Estacion,Renglon)
  )
GO

EXEC spALTER_TABLE 'POSVentaPedidoDTemp ', 'Codigo','varchar(30)	NULL'
EXEC spALTER_TABLE 'POSVentaPedidoDTemp ', 'PrecioSugerido','float	NULL'
GO


/****** POSVentaPedidoDTemp2 ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaPedidoDTemp2')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaPedidoDTemp2', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaPedidoDTemp2') AND type = 'U') 
	CREATE TABLE dbo.POSVentaPedidoDTemp2 (
		Estacion              int             NOT NULL,
		ID                    int             NOT NULL,   
		Renglon               float           NOT NULL, 
		RenglonSub            int             NULL, 
		RenglonID             int             NULL, 
		RenglonTipo           char(1)         NULL,
		Cantidad              float           NULL, 
		Almacen               varchar(10)     NULL, 
		EnviarA               int             NULL, 
		Articulo              varchar(20)     NULL, 
		SubCuenta             varchar(50)     NULL, 
		Precio                float           NULL, 
		PrecioImpuestoInc     float           NULL, 
		PrecioSugerido        float           NULL, 
		DescuentoLinea        money           NULL, 
		Impuesto1             float           NULL, 
		Impuesto2             float           NULL, 
		Impuesto3             float           NULL, 
		Aplica                varchar(20)     NULL, 
		AplicaID              varchar(20)     NULL, 
		CantidadPendiente     float           NULL, 
		CantidadReservada     float           NULL, 
		CantidadCancelada     float           NULL, 
		CantidadOrdenada      float           NULL, 
		CantidadA             float           NULL, 
		Unidad                varchar(50)     NULL, 
		Factor                float           NULL, 
		Puntos                money           NULL, 
		CantidadObsequio      float           NULL, 
		OfertaID              int             NULL, 
		Sucursal              int             NULL, 
		Codigo                varchar(30)     NULL,
		Importe               float           NULL,
		CantidadAplicar       float           NULL,  
  
	CONSTRAINT priPOSVentaPedidoDTemp2 PRIMARY KEY CLUSTERED (ID,Estacion,Renglon)
  )
GO

EXEC spALTER_TABLE 'POSVentaPedidoDTemp2 ', 'PrecioImpuestoInc','float	NULL'
GO


/****** POSVentaPedidoSerieloteTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaPedidoSerieloteTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaPedidoSerieloteTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaPedidoSerieloteTemp') AND type = 'U') 
	CREATE TABLE dbo.POSVentaPedidoSerieloteTemp (
		Estacion              int             NOT NULL,
		ID                    int             NOT NULL,   
		RenglonID             int             NOT NULL, 
		Cantidad              float           NULL, 
		Articulo              varchar(20)     NOT NULL, 
		SubCuenta             varchar(50)     NOT NULL, 
		Serielote             varchar(50)     NOT NULL,
  
	CONSTRAINT priPOSVentaPedidoSerieloteTemp PRIMARY KEY CLUSTERED (ID,Estacion,RenglonID,Serielote,Articulo,SubCuenta)
  )
GO


/****** POSCteCreditoTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCteCreditoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCteCreditoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCteCreditoTemp') AND type = 'U') 
	CREATE TABLE dbo.POSCteCreditoTemp (
        Estacion                int             NOT NULL,
        Empresa                 varchar(5)      NOT NULL, 
        Credito                 varchar(50)     NOT NULL, 
        ConCredito              bit             NULL, 
        ConLimiteCredito        bit             NULL, 
        LimiteCredito           money           NULL, 
        ConLimitePedidos        bit             NULL, 
        LimitePedidos           money           NULL, 
        MonedaCredito           varchar(10)     NULL, 
        ConDias                 bit             NULL, 
        Dias                    int             NULL, 
        ConCondiciones          bit             NULL, 
        Condiciones             varchar(255)    NULL,
	
	CONSTRAINT priPOSCteCreditoTemp PRIMARY KEY CLUSTERED (Estacion, Empresa, Credito)
	)
GO


/****** POSCteInfoTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCteInfoTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCteInfoTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCteInfoTemp') AND type = 'U') 
	CREATE TABLE dbo.POSCteInfoTemp (
        Estacion                int             NOT NULL,
        RID                     int IDENTITY,
        ID                      int             NOT NULL, 
        Empresa                  varchar(5)      NULL, 
        Moneda                  varchar(10)     NULL, 
        TipoCambio              float           NULL, 
        Cliente                 varchar(10)     NULL, 
        ClienteEnviarA          int             NULL, 
        Mov                     varchar(20)     NULL, 
        MovID                   varchar(20)     NULL, 
        FechaEmision            datetime        NULL, 
        Vencimiento             datetime        NULL, 
        DiasMoratorios          int             NULL, 
        Saldo                   money           NULL, 
        Concepto                varchar(50)     NULL, 
        Referencia              varchar(50)     NULL, 
        Estatus                 varchar(15)     NULL, 
        Situacion               varchar(50)     NULL, 
        SituacionFecha          datetime        NULL, 
        SituacionUsuario        varchar(10)     NULL, 
        SituacionNota           varchar(100)    NULL, 
        Proyecto                varchar(50)     NULL, 
        UEN                     int             NULL,       
	CONSTRAINT priPOSCteInfoTemp PRIMARY KEY CLUSTERED (Estacion, ID,RID)
	)
GO


/****** POSCteInfoTempCalc  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCteInfoTempCalc')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCteInfoTempCalc', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCteInfoTempCalc') AND type = 'U') 
	CREATE TABLE dbo.POSCteInfoTempCalc (
        Estacion                int             NOT NULL,
        Cliente                 varchar(10)     NOT NULL,
        SaldoMN                 float           NULL,
        LimiteCreditoMN         float           NULL,        
	CONSTRAINT priPOSCteInfoTempCalc PRIMARY KEY CLUSTERED (Estacion,Cliente)
	)
GO


/****** POSVentaTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSVentaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSVentaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSVentaTemp') AND type = 'U') 
	CREATE TABLE dbo.POSVentaTemp (
        Estacion                int             NOT NULL,
        ID                      int             NOT NULL, 
        Empresa                 varchar(5)      NULL, 
        Moneda                  varchar(10)     NULL, 
        TipoCambio              float           NULL, 
        Cliente                 varchar(10)     NULL, 
        ClienteEnviarA          int             NULL, 
        Mov                     varchar(20)     NULL, 
        MovID                   varchar(20)     NULL, 
        FechaEmision            datetime        NULL, 
        Vencimiento             datetime        NULL, 
        FechaRequerida          datetime        NULL, 
        Saldo                   money           NULL, 
        Concepto                varchar(50)     NULL, 
        Referencia              varchar(50)     NULL, 
        Estatus                 varchar(15)     NULL, 
        Proyecto                varchar(50)     NULL, 
        UEN                     int             NULL, 
        Importe                 float           NULL,
        Impuestos               float           NULL,
	CONSTRAINT priPOSVentaTemp PRIMARY KEY CLUSTERED (Estacion, ID)
	)
GO


/****** POSArtDisponibleAlmTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtDisponibleAlmTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtDisponibleAlmTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtDisponibleAlmTemp') AND type = 'U') 
	CREATE TABLE dbo.POSArtDisponibleAlmTemp (
        Estacion                int             NOT NULL,
        Empresa                 varchar(5)      NOT NULL, 
        Articulo                varchar(20)     NOT NULL, 
        Almacen                 varchar(10)     NOT NULL, 
        Disponible              float           NULL, 
        Grupo                   varchar(50)     NULL,
        Tipo                    varchar(15)     NULL,        
	CONSTRAINT priPOSArtDisponibleAlmTemp PRIMARY KEY CLUSTERED (Estacion, Empresa, Articulo, Almacen)
	)
GO


/****** POSArtResevadoAlmTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSArtResevadoAlmTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSArtResevadoAlmTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSArtResevadoAlmTemp') AND type = 'U') 
	CREATE TABLE dbo.POSArtResevadoAlmTemp (
        Estacion                int             NOT NULL,
        Empresa                 varchar(5)      NOT NULL, 
        Articulo                varchar(20)     NOT NULL, 
        Almacen                 varchar(10)     NOT NULL, 
        Reservado               float           NULL, 
        Grupo                   varchar(50)     NULL,
        Tipo                    varchar(15)     NULL,        
	CONSTRAINT priPOSArtResevadoAlmTemp PRIMARY KEY CLUSTERED (Estacion, Empresa, Articulo, Almacen)
	)
GO


/****** POSAccion ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSAccion')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSAccion', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSAccion') AND type = 'U') 
	CREATE TABLE dbo.POSAccion (
	   Accion			varchar(50)	NOT NULL,
	   CONSTRAINT priPOSAccion PRIMARY KEY CLUSTERED (Accion)   
	)	   
GO


/****** POSLPorCobrar ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLPorCobrar')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLPorCobrar', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLPorCobrar') AND type = 'U') 
	CREATE TABLE dbo.POSLPorCobrar (
		ID						varchar(36)		NOT NULL, 
		Empresa					varchar(5)		NULL,	
		Modulo					varchar(5)		NULL,
		Mov 					varchar(20)		NULL,
		MovID					varchar(20)		NULL,
		FechaEmision			datetime		NULL,
		FechaRegistro			datetime		NULL,
		Concepto				varchar(50)		NULL,
		Proyecto				varchar(50)		NULL,
		UEN						int				NULL,
		Moneda					varchar(10)		NULL,
		TipoCambio				float			NULL,
		Referencia				varchar(50)		NULL,
		Observaciones			varchar(200)	NULL,
		Estatus					varchar(15)		NULL,
		Cliente					varchar(10)		NULL,
		Nombre					varchar(100)	NULL,
		Direccion				varchar(100)	NULL,
		DireccionNumero			varchar(20)		NULL,
		DireccionNumeroInt		varchar(20)		NULL,
		EntreCalles				varchar(100)	NULL,
		Delegacion				varchar(100)	NULL,
		Colonia					varchar(100)	NULL,
		Poblacion				varchar(100)	NULL,
		Estado					varchar(30)		NULL,
		Pais					varchar(30)		NULL,
		Zona					varchar(30)		NULL,
		CodigoPostal			varchar(15)		NULL,
		RFC						varchar(15)		NULL,
		CURP					varchar(30)		NULL,
		EnviarA					int				NULL,
		Almacen					varchar(10)		NULL,
		Agente					varchar(10)		NULL,
		FormaEnvio				varchar(50)		NULL,
		Condicion				varchar(50)		NULL,
		Vencimiento				datetime		NULL,
		CajaOrigen				varchar(10)     NULL,	
		CtaDinero				varchar(10)		NULL,
		Descuento				varchar(30)		NULL,
		DescuentoGlobal			float			NULL,
		Importe					money			NULL,
		Impuestos				money			NULL,
		Causa					varchar(50)		NULL,
		Atencion				varchar(50)		NULL,
		AtencionTelefono		varchar(50)		NULL,
		ListaPreciosEsp			varchar(20)		NULL,
		ZonaImpuesto			varchar(30)		NULL,
		Sucursal				int				NULL,
		OrigenTipo				varchar(10)		NULL,
		Origen					varchar(20)		NULL,
		OrigenID				varchar(20)		NULL,
		Tasa					varchar(50)		NULL,
		Prefijo					varchar(5)		NULL,
		Consecutivo				int				NULL,
		IDR      				varchar(36)		NULL,
		Monedero                varchar(20)     NULL,
		IDCB                    varchar(20)     NULL,
		BeneficiarioNombre      varchar(100)    NULL,
		Directo                 bit             NULL DEFAULT 1,
		ECheckSum               int             NULL,
		DCheckSum               bigint          NULL,
	
	CONSTRAINT priPOSLPorCobrar PRIMARY KEY CLUSTERED (ID)
	)
GO

EXEC spALTER_TABLE 'POSLPorCobrar', 'IDCB', 'varchar(20) NULL'
EXEC spALTER_TABLE 'POSLPorCobrar', 'Directo','bit NULL DEFAULT 1 WITH VALUES'
GO


/****** POSLPorCobrarD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLPorCobrarD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLPorCobrarD', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLPorCobrarD') AND type = 'U') 
	CREATE TABLE dbo.POSLPorCobrarD (
        ID						varchar(36)	NOT NULL,
        Renglon					float		NOT NULL,
        RenglonSub				int			NOT NULL	DEFAULT 0,       
        RenglonID				int			NULL,
        RenglonTipo				varchar(1)	NULL,
        Aplica					varchar(20)	NULL,
        AplicaID				varchar(20)	NULL,
        Cantidad				float		NULL,
        Articulo				varchar(20)	NULL,
        SubCuenta				varchar(50)	NULL,
        Precio					float		NULL,
        PrecioSugerido			float		NULL,
        DescuentoLinea			float		NULL,
        DescuentoImporte		money		NULL,
        Impuesto1				float		NULL,
        Impuesto2				float		NULL,
        Impuesto3				float		NULL,
        Unidad					varchar(50)	NULL,
        Factor					float		NULL,
        CantidadInventario		float		NULL,
        Puntos					money		NULL,
        Comision				float		NULL,
        CantidadObsequio		float		NULL,
        OfertaID				int			NULL,
        SerieLote				varchar(50)	NULL,
		LDIServicio				varchar(20)	NULL,
		Juego    				varchar(10)	NULL,
		Aplicado                bit         NULL,
		DCheckSum               bigint      NULL,
		PrecioImpuestoInc       float       NULL,
		AplicaDescGlobal        bit         NULL DEFAULT 0, 
		Codigo                  varchar(30) NULL,
		Almacen                 varchar(10) NULL,       
  
	CONSTRAINT priPOSLPorCobrarD PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
  )
GO

EXEC spALTER_TABLE 'POSLPorCobrarD', 'PrecioImpuestoInc','float	NULL'
EXEC spALTER_TABLE 'POSLPorCobrarD', 'AplicaDescGlobal','bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'POSLPorCobrarD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'POSLPorCobrarD', 'Almacen', 'varchar(10) NULL'
GO
 

/****** POSLPorCobrarSerieLote ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLPorCobrarSerieLote')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLPorCobrarSerieLote', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLPorCobrarSerieLote') AND type = 'U') 
	CREATE TABLE dbo.POSLPorCobrarSerieLote (
        IDL				Uniqueidentifier	NOT NULL DEFAULT NEWSEQUENTIALID() ROWGUIDCOL,
        ID				varchar(36)	NOT NULL,
        RenglonID		int		NOT NULL,
        Articulo		varchar(20)	NULL,
        SubCuenta		varchar(50)	NULL,
        SerieLote		varchar(50)	NULL,
        SCheckSum       bigint          NULL,        

	CONSTRAINT priPOSLPorCobrarSerieLote PRIMARY KEY CLUSTERED (IDL)
	)
GO


/****** POSOfertaFormaPago ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSOfertaFormaPago')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSOfertaFormaPago', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSOfertaFormaPago') AND type = 'U') 
	CREATE TABLE dbo.POSOfertaFormaPago (  
		ID                  int  IDENTITY   NOT NULL,
        Descripcion         varchar(255)    NULL,
		Empresa				varchar(5)		NOT NULL,
		Estatus				varchar(15)		NOT NULL,
		TodasSucursales		bit DEFAULT 1	NOT NULL,
		Sucursal            int				NULL,
		FormaPago			varchar(50)		NOT NULL,
		Descuento           float			NOT NULL,
		MontoMinimo         float			NOT NULL,
		FechaD              datetime		NULL,
		FechaA              datetime		NULL,
		HoraD				varchar(5)		NULL,
		HoraA				varchar(5)		NULL,
		UltimoCambio        datetime		NULL,
	   
		CONSTRAINT priPOSOfertaFormaPago PRIMARY KEY CLUSTERED (ID)   
	)
GO

IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='FORMA ENVIO')
	INSERT POSAccion (Accion) 
	SELECT  'FORMA ENVIO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MOVIMIENTO NUEVO')
	INSERT POSAccion (Accion) 
	SELECT  'MOVIMIENTO NUEVO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='CANCELAR PARTIDA')
	INSERT  POSAccion (Accion)  
	SELECT  'CANCELAR PARTIDA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='ELIMINAR MOVIMIENTO')
	INSERT  POSAccion (Accion)  
	SELECT  'ELIMINAR MOVIMIENTO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='CONCLUIR MOVIMIENTO')
	INSERT  POSAccion (Accion)  
	SELECT  'CONCLUIR MOVIMIENTO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='CAMBIAR MOVIMIENTO')
	INSERT  POSAccion (Accion)  
	SELECT  'CAMBIAR MOVIMIENTO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR CANTIDAD')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR CANTIDAD'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MULTIPLICAR CANTIDAD')
	INSERT  POSAccion (Accion)  
	SELECT  'MULTIPLICAR CANTIDAD'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR CONDICION')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR CONDICION'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR REFERENCIA')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR REFERENCIA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='BUSCAR ARTICULOS')
	INSERT  POSAccion (Accion)  
	SELECT  'BUSCAR ARTICULOS'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='INTRODUCIR CUENTA DINERO')
	INSERT  POSAccion (Accion)  
	SELECT  'INTRODUCIR CUENTA DINERO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='ORIGEN DEVOLUCION')
	INSERT  POSAccion (Accion)  
	SELECT  'ORIGEN DEVOLUCION'  
GO
IF  EXISTS(SELECT * FROM POSAccion WHERE Accion ='TRASPASAR POR COBRAR')
	DELETE POSAccion WHERE Accion ='TRASPASAR POR COBRAR'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='BUSCAR MOVIMIENTO')
	INSERT  POSAccion (Accion)  
	SELECT  'BUSCAR MOVIMIENTO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='CONSULTAR INV')
	INSERT  POSAccion (Accion)  
	SELECT  'CONSULTAR INV'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='VER CORTE CAJA')
	INSERT  POSAccion (Accion)  
	SELECT  'VER CORTE CAJA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='PESAR')
	INSERT  POSAccion (Accion)  
	SELECT  'PESAR'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR AGENTE')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR AGENTE'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='REGRESAR')
	INSERT  POSAccion (Accion)  
	SELECT  'REGRESAR'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR CAJA')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR CAJA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR CAJERO')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR CAJERO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='REVERSAR COBRO')
	INSERT  POSAccion (Accion)  
	SELECT  'REVERSAR COBRO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='VERIFICAR PRECIOS')
	INSERT  POSAccion (Accion)  
	SELECT  'VERIFICAR PRECIOS'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='DEVOLUCION TOTAL')
	INSERT  POSAccion (Accion)  
	SELECT  'DEVOLUCION TOTAL'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='DEVOLUCION PARCIAL')
	INSERT  POSAccion (Accion)  
	SELECT  'DEVOLUCION PARCIAL'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='CANCELACION DINERO')
	INSERT  POSAccion (Accion)  
	SELECT  'CANCELACION DINERO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MODIFICAR COMPONENTE')
	INSERT  POSAccion (Accion)  
	SELECT  'MODIFICAR COMPONENTE'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='ASIGNAR CAJA')
	INSERT  POSAccion (Accion)  
	SELECT  'ASIGNAR CAJA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='BENEFICIARIO')
	INSERT  POSAccion (Accion)  
	SELECT  'BENEFICIARIO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='BLOQUEAR CAJA')
	INSERT  POSAccion (Accion)  
	SELECT  'BLOQUEAR CAJA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='DESBLOQUEAR CAJA')
	INSERT  POSAccion (Accion)  
	SELECT  'DESBLOQUEAR CAJA'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='EDITAR ENCABEZADO')
	INSERT  POSAccion (Accion)  
	SELECT  'EDITAR ENCABEZADO'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='EDITAR DETALLE')
	INSERT  POSAccion (Accion)  
	SELECT  'EDITAR DETALLE'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='MATRIZ OPCIONES')
	INSERT  POSAccion (Accion)  
	SELECT  'MATRIZ OPCIONES'  
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='SUSTITUTOS ACCESORIOS')
	INSERT  POSAccion (Accion)  
	SELECT  'SUSTITUTOS ACCESORIOS' 
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='INTRODUCIR CONCEPTOCXC')
	INSERT  POSAccion (Accion)  
	SELECT  'INTRODUCIR CONCEPTOCXC'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='ALMACEN DESTINO')
	INSERT  POSAccion (Accion)  
	SELECT  'ALMACEN DESTINO'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='FACTURAR PEDIDO')
	INSERT  POSAccion (Accion)  
	SELECT  'FACTURAR PEDIDO'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='ANTICIPOS FACTURADOS')
	INSERT  POSAccion (Accion)  
	SELECT  'ANTICIPOS FACTURADOS'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='REFERENCIAR PEDIDO')
	INSERT  POSAccion (Accion)  
	SELECT  'REFERENCIAR PEDIDO'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='REFERENCIAR VENTA')
	INSERT  POSAccion (Accion)  
	SELECT  'REFERENCIAR VENTA'
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='REFERENCIAR COBRO' )
	INSERT  POSAccion (Accion)  
	SELECT  'REFERENCIAR COBRO' 
GO
IF NOT EXISTS(SELECT * FROM POSAccion WHERE Accion ='SELECCIONARCTE')
	INSERT  POSAccion (Accion)  
	SELECT  'SELECCIONARCTE'
GO
IF  EXISTS(SELECT * FROM POSAccion WHERE Accion ='COPIAR PEDIDO')
	DELETE  POSAccion WHERE Accion ='COPIAR PEDIDO'
GO


/************ EFAS Se ingresan claves para que se mantenga el código en los botones ************/
IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ASIGNAR CAJA')
BEGIN 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ASIGNAR CAJA' 
END
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ACAJA', 'Accion', 'ASIGNAR CAJA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'SUSTITUTOS ACCESORIOS') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'SUSTITUTOS ACCESORIOS' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ACCESORIOS', 'Accion', 'SUSTITUTOS ACCESORIOS')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ALMACEN DESTINO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ALMACEN DESTINO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ALM DESTINO', 'Accion', 'ALMACEN DESTINO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR ALM FOR') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR ALM FOR' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ALMACEN FOR', 'Accion', 'MODIFICAR ALM FOR')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR ALM SUC') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR ALM SUC' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ALMACEN LOC', 'Accion', 'MODIFICAR ALM SUC')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ANTICIPOS FACTURADOS') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ANTICIPOS FACTURADOS' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ANTICIPOS', 'Accion', 'ANTICIPOS FACTURADOS')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BUSCAR ARTICULOS') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BUSCAR ARTICULOS' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ART', 'Accion', 'BUSCAR ARTICULOS')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BENEFICIARIO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BENEFICIARIO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('BENEF', 'Accion', 'BENEFICIARIO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BLOQUEAR CAJA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BLOQUEAR CAJA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('BLOCK', 'Accion', 'BLOQUEAR CAJA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BUSCAR MOVIMIENTO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'BUSCAR MOVIMIENTO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('BMOV', 'Accion', 'BUSCAR MOVIMIENTO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CAJA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CAJA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CAJA', 'Accion', 'MODIFICAR CAJA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CAJERO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CAJERO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CAJERO', 'Accion', 'MODIFICAR CAJERO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CANTIDAD') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CANTIDAD' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CANT', 'Accion', 'MODIFICAR CANTIDAD')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CANCELACION DINERO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CANCELACION DINERO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CDINERO', 'Accion', 'CANCELACION DINERO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR COMPONENTE') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR COMPONENTE' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('COMPONENTE', 'Accion', 'MODIFICAR COMPONENTE')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CONCEPTODIN') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CONCEPTODIN' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CONCEPTO CAJA', 'Accion', 'INTRODUCIR CONCEPTODIN')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CONCEPTOCXC') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CONCEPTOCXC' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CONCEPTOCXC', 'Accion', 'INTRODUCIR CONCEPTOCXC')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CONDICION') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR CONDICION' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CONDICION', 'Accion', 'MODIFICAR CONDICION')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CANCELAR PARTIDA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CANCELAR PARTIDA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CPARTIDA', 'Accion', 'CANCELAR PARTIDA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CUENTA DINERO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'INTRODUCIR CUENTA DINERO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CTADINERO', 'Accion', 'INTRODUCIR CUENTA DINERO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'SELECCIONARCTE') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'SELECCIONARCTE' 
IF EXISTS (SELECT * FROM CB WHERE Codigo = 'CTE') 
	DELETE FROM CB WHERE Codigo = 'CTE'
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('CTE', 'Accion', 'SELECCIONARCTE')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DEVOLUCION TOTAL') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DEVOLUCION TOTAL' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('DEV', 'Accion', 'DEVOLUCION TOTAL')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DEVOLUCION PARCIAL') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DEVOLUCION PARCIAL' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('DEVP', 'Accion', 'DEVOLUCION PARCIAL') 

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'EDITAR DETALLE') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'EDITAR DETALLE' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('EDITDETA', 'Accion', 'EDITAR DETALLE')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'EDITAR ENCABEZADO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'EDITAR ENCABEZADO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('EDITENCA', 'Accion', 'EDITAR ENCABEZADO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ELIMINAR MOVIMIENTO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ELIMINAR MOVIMIENTO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ELIM', 'Accion', 'ELIMINAR MOVIMIENTO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'FORMA ENVIO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'FORMA ENVIO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ENVIO', 'Accion', 'FORMA ENVIO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CONCLUIR MOVIMIENTO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CONCLUIR MOVIMIENTO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('F12', 'Accion', 'CONCLUIR MOVIMIENTO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CONSULTAR INV') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CONSULTAR INV' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('INV', 'Accion', 'CONSULTAR INV')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CAMBIAR MOVIMIENTO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'CAMBIAR MOVIMIENTO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('MOV', 'Accion', 'CAMBIAR MOVIMIENTO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MOVIMIENTO NUEVO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MOVIMIENTO NUEVO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('NUEVO', 'Accion', 'MOVIMIENTO NUEVO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ORIGEN DEVOLUCION') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'ORIGEN DEVOLUCION' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('ODEV', 'Accion', 'ORIGEN DEVOLUCION')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MATRIZ OPCIONES') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MATRIZ OPCIONES' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('OPCIONES', 'Accion', 'MATRIZ OPCIONES')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'FACTURAR PEDIDO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'FACTURAR PEDIDO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('PEDIDO', 'Accion', 'FACTURAR PEDIDO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'PESAR') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'PESAR' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('PESAR', 'Accion', 'PESAR')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR AGENTE') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR AGENTE' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('AGENTE', 'Accion', 'MODIFICAR AGENTE')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'VERIFICAR PRECIOS') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'VERIFICAR PRECIOS' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('PRECIOS', 'Accion', 'VERIFICAR PRECIOS')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR REFERENCIA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'MODIFICAR REFERENCIA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('REF', 'Accion', 'MODIFICAR REFERENCIA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REFERENCIAR COBRO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REFERENCIAR COBRO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('REF COBRO', 'Accion', 'REFERENCIAR COBRO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REFERENCIAR PEDIDO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REFERENCIAR PEDIDO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('REF PEDIDO', 'Accion', 'REFERENCIAR PEDIDO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REGRESAR') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REGRESAR' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('REGRESAR', 'Accion', 'REGRESAR')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REVERSAR COBRO') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'REVERSAR COBRO' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('REVERSAR COBRO', 'Accion', 'REVERSAR COBRO')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DESBLOQUEAR CAJA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'DESBLOQUEAR CAJA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('UNBLOCK', 'Accion', 'DESBLOQUEAR CAJA')

IF EXISTS (SELECT * FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'VER CORTE CAJA') 
	DELETE FROM CB WHERE TipoCuenta = 'Accion' AND Accion = 'VER CORTE CAJA' 
INSERT INTO CB (Codigo, TipoCuenta, Accion) VALUES ('VER', 'Accion', 'VER CORTE CAJA')
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSLTipoCambioRefABC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSLTipoCambioRefABC
GO
CREATE TRIGGER tgPOSLTipoCambioRefABC ON POSLTipoCambioRef
--//WITH ENCRYPTION
FOR INSERT,UPDATE, DELETE
AS BEGIN
  DECLARE
	@SucursalA            int,
	@SucursalB            int,
	@Mensaje              varchar(255)
  
	SELECT @SucursalA = Sucursal FROM INSERTED
	SELECT @SucursalB = Sucursal FROM DELETED
  
  IF @SucursalA IS NOT NULL
	  BEGIN
		IF EXISTS(SELECT * FROM POSLTipoCambioRef WHERE Sucursal = @SucursalA AND EsPrincipal = 1 AND TipoCambio <> 1)
			BEGIN
			  SELECT @Mensaje = 'La moneda principal debe de tener tipo de cambio = 1.0'
			  RAISERROR (@Mensaje,16,-1) 
			END 

		IF NOT EXISTS(SELECT * FROM POSLTipoCambioRef WHERE Sucursal = @SucursalA AND EsPrincipal = 1) AND NOT EXISTS(SELECT * FROM POSLTipoCambioRef WHERE Sucursal = @SucursalA AND EsPrincipal = 1)
			BEGIN
			  SELECT @Mensaje = 'Es necesario asignar una moneda principal'
			  RAISERROR (@Mensaje,16,-1) 
			END  
		IF (SELECT COUNT(*) FROM POSLTipoCambioRef WHERE Sucursal = @SucursalA AND EsPrincipal = 1)>1
			BEGIN
			  SELECT @Mensaje = 'Solo una moneda puede ser principal'
			  RAISERROR (@Mensaje,16,-1) 
			END     
	  END 
END
GO


/*** ArtJuegoOmision ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.ArtJuegoOmision') and type = 'V') DROP VIEW dbo.ArtJuegoOmision
GO
CREATE VIEW ArtJuegoOmision
--//WITH ENCRYPTION
AS 
	SELECT j.Articulo, j.Cantidad, j.Juego, "PrecioIndependiente" = CONVERT(int, j.PrecioIndependiente), j.ListaPreciosEsp,
	"Opcion" = (SELECT Opcion FROM ArtJuegoD o WHERE o.Articulo = j.Articulo AND o.Juego = j.Juego AND o.Renglon = MIN(d.Renglon)),
	"SubCuenta" = (SELECT SubCuenta FROM ArtJuegoD o WHERE o.Articulo = j.Articulo AND o.Juego = j.Juego AND o.Renglon = MIN(d.Renglon))
	FROM ArtJuego j, ArtJuegoD d
	WHERE j.Articulo = d.Articulo AND j.Juego = d.Juego
	GROUP BY j.Articulo, j.Cantidad, j.Juego, CONVERT(int, j.PrecioIndependiente), j.ListaPreciosEsp
GO


/**************** fnPOSCBGenerar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPOSCBGenerar') DROP FUNCTION fnPOSCBGenerar
GO
CREATE FUNCTION dbo.fnPOSCBGenerar (
	@ID     varchar(36)
) 
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
		DECLARE
		@Resultado  varchar(20),
		@Host       varchar(20),
		@HostCadena varchar(20),
		@Sucursal   int,
		@SucCadena  varchar(20),
		@Caja       varchar(20),
		@IDCaja     int,
		@IDCajaCadena varchar(20),
		@RID         int,
		@RIDCadena   varchar(20)
  
		SELECT @HOST = HOST , @Sucursal = Sucursal, @Caja = CtaDinero, @RID = Orden
		FROM POSL WHERE ID = @ID
  
		SELECT @IDCaja = RID FROM CtaDinero WHERE CtaDinero =@Caja    
    
		IF (SELECT LEN(@HOST))>4
			SELECT  @HostCadena = REVERSE(SUBSTRING(REVERSE(@Host),1,4))
		ELSE
			SELECT  @HostCadena =@Host
      
		SELECT @SucCadena =  dbo.fnRellenarConCaracter(CONVERT(varchar,@Sucursal),3,'I','S')     
		SELECT @IDCajaCadena =  dbo.fnRellenarConCaracter(CONVERT(varchar,@IDCaja),3,'I','C')     
		SELECT @RIDCadena =  dbo.fnRellenarConCaracter(CONVERT(varchar,@RID),8,'I','K')     

		SELECT @Resultado = @HostCadena+@IDCajaCadena+@RIDCadena
		RETURN (@Resultado)
	END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSLCB') and sysstat & 0xf = 2) DROP VIEW dbo.POSLCB
GO
CREATE VIEW POSLCB
--//WITH ENCRYPTION
AS
	SELECT ID,dbo.fnPOSCBGenerar(ID) IDCB
	FROM POSL  
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSArtMatrizBC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSArtMatrizBC
GO
CREATE TRIGGER tgPOSArtMatrizBC ON Art
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
	DECLARE 
    @EsOrigen           bit,
    @SincronizaArtSuc   bit
    
	SELECT @EsOrigen = ISNULL(EsOrigen,0), @SincronizaArtSuc = ISNULL(SincronizaArtSuc,0) FROM POSiSync
  
	IF @EsOrigen = 0 RETURN
	IF @SincronizaArtSuc = 0 RETURN
  

	IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS(SELECT * FROM INSERTED)
		BEGIN
			DELETE POSArtSucursal 
			FROM POSArtSucursal a JOIN DELETED d ON a.Articulo = d.Articulo 
      
			DELETE POSArtCodigoSucursal 
			FROM POSArtCodigoSucursal a JOIN DELETED d ON a.Articulo = d.Articulo 
		END  

  IF EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED)
		UPDATE POSArtSucursal SET  Rama = i.Rama, Descripcion1 = i.Descripcion1, Descripcion2 = i.Descripcion2, NombreCorto = i.NombreCorto, Grupo = i.Grupo, Categoria = i.Categoria, Familia = i.Familia, Linea = i.Linea, Fabricante = i.Fabricante, Impuesto1 = i.Impuesto1, Impuesto2 = i.Impuesto2, Impuesto3 = i.Impuesto3, Factor = i.Factor, Unidad = i.Unidad, UnidadCompra = i.UnidadCompra, UnidadTraspaso = i.UnidadTraspaso, Tipo = i.Tipo, TipoOpcion = i.TipoOpcion, Accesorios = i.Accesorios, Sustitutos = i.Sustitutos, MonedaPrecio = i.MonedaPrecio, PrecioLista = i.PrecioLista, PrecioMinimo = i.PrecioMinimo, Estatus = i.Estatus, Alta = i.Alta, Precio2 = i.Precio2, Precio3 = i.Precio3, Precio4 = i.Precio4, Precio5 = i.Precio5, Precio6 = i.Precio6, Precio7 = i.Precio7, Precio8 = i.Precio8, Precio9 = i.Precio9, Precio10 = i.Precio10, BasculaPesar = i.BasculaPesar, TieneMovimientos = i.TieneMovimientos, Retencion1 = i.Retencion1, Retencion2 = i.Retencion2, Retencion3 = i.Retencion3, TipoImpuesto1 = i.TipoImpuesto1, TipoImpuesto2 = i.TipoImpuesto2, TipoImpuesto3 = i.TipoImpuesto3, TipoImpuesto4 = i.TipoImpuesto4, TipoImpuesto5 = i.TipoImpuesto5, TipoRetencion1 = i.TipoRetencion1, TipoRetencion2 = i.TipoRetencion2, TipoRetencion3 = i.TipoRetencion3
		FROM POSArtSucursal p JOIN INSERTED i ON i.Articulo = p.Articulo 

	RETURN     
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSArtCBMatrizBC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSArtCBMatrizBC
GO
CREATE TRIGGER tgPOSArtCBMatrizBC ON CB
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE 
    @EsOrigen           bit,
    @SincronizaArtSuc   bit
    
  SELECT @EsOrigen = ISNULL(EsOrigen,0), @SincronizaArtSuc = ISNULL(SincronizaArtSuc,0) FROM POSiSync
  
  IF @EsOrigen = 0 RETURN
  IF @SincronizaArtSuc = 0 RETURN

  IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS(SELECT * FROM INSERTED)
  
  DELETE POSArtCodigoSucursal 
    FROM POSArtCodigoSucursal a JOIN DELETED d ON a.Codigo = d.Codigo 

  IF EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED)
   UPDATE POSArtCodigoSucursal SET  Codigo = i.Codigo, Articulo = i.Cuenta, SubCuenta = i.SubCuenta, Cantidad = i.Cantidad, Unidad = i.Unidad
     FROM POSArtCodigoSucursal p JOIN INSERTED i ON i.Codigo = p.Codigo AND i.TipoCuenta = 'Articulos' 

	RETURN     
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSArtSucursalABC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSArtSucursalABC
GO
CREATE TRIGGER tgPOSArtSucursalABC ON POSArtSucursal
--//WITH ENCRYPTION
FOR UPDATE, DELETE,INSERT
AS BEGIN
	DECLARE 
    @EsOrigen           bit,
    @SincronizaArtSuc   bit
    
    SELECT @EsOrigen = ISNULL(EsOrigen,0), @SincronizaArtSuc = ISNULL(SincronizaArtSuc,0) FROM POSiSync
  
	IF @EsOrigen = 1 RETURN
	IF @SincronizaArtSuc = 0 RETURN

	IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS(SELECT * FROM INSERTED)
		BEGIN
			DELETE Art FROM Art a JOIN DELETED d ON a.Articulo = d.Articulo AND a.TieneMovimientos = 0
    
			UPDATE Art SET  Estatus = 'BAJA'
			FROM Art a JOIN DELETED d ON d.Articulo = a.Articulo AND a.TieneMovimientos = 1    
		END  

	IF EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED)
		UPDATE Art SET  Rama = i.Rama, Descripcion1 = i.Descripcion1, Descripcion2 = i.Descripcion2, NombreCorto = i.NombreCorto, Grupo = i.Grupo, Categoria = i.Categoria, Familia = i.Familia, Linea = i.Linea, Fabricante = i.Fabricante, Impuesto1 = i.Impuesto1, Impuesto2 = i.Impuesto2, Impuesto3 = i.Impuesto3, Factor = i.Factor, Unidad = i.Unidad, UnidadCompra = i.UnidadCompra, UnidadTraspaso = i.UnidadTraspaso, Tipo = i.Tipo, TipoOpcion = i.TipoOpcion, Accesorios = i.Accesorios, Sustitutos = i.Sustitutos, MonedaPrecio = i.MonedaPrecio, PrecioLista = i.PrecioLista, PrecioMinimo = i.PrecioMinimo, Estatus = i.Estatus, Alta = i.Alta, Precio2 = i.Precio2, Precio3 = i.Precio3, Precio4 = i.Precio4, Precio5 = i.Precio5, Precio6 = i.Precio6, Precio7 = i.Precio7, Precio8 = i.Precio8, Precio9 = i.Precio9, Precio10 = i.Precio10, BasculaPesar = i.BasculaPesar, TieneMovimientos = i.TieneMovimientos, Retencion1 = i.Retencion1, Retencion2 = i.Retencion2, Retencion3 = i.Retencion3, MonedaCosto = ISNULL(i.MonedaCosto,'Pesos'), TipoCosteo = i.TipoCosteo, Calificacion = ISNULL(i.Calificacion,0), TipoImpuesto1 = i.TipoImpuesto1, TipoImpuesto2 = i.TipoImpuesto2, TipoImpuesto3 = i.TipoImpuesto3, TipoImpuesto4 = i.TipoImpuesto4, TipoImpuesto5 = i.TipoImpuesto5, TipoRetencion1 = i.TipoRetencion1, TipoRetencion2 = i.TipoRetencion2, TipoRetencion3 = i.TipoRetencion3
		FROM Art a JOIN INSERTED i ON i.Articulo = a.Articulo
     
	IF NOT EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED) 
		BEGIN
			INSERT Art(Articulo,     Descripcion1,     Descripcion2,     NombreCorto,     Grupo,     Categoria,     Familia,     Linea,     Fabricante,     Impuesto1,     Impuesto2,     Impuesto3,     Factor,     Unidad,     UnidadCompra,     UnidadTraspaso,     Tipo,     TipoOpcion,     Accesorios,     Sustitutos,     MonedaPrecio,     PrecioLista,     PrecioMinimo,     Estatus,     Alta,     Precio2,     Precio3,     Precio4,     Precio5,     Precio6,     Precio7,     Precio8,     Precio9,     Precio10,     BasculaPesar,     TieneMovimientos,     Retencion1,     Retencion2,     Retencion3, MonedaCosto,TipoCosteo, Calificacion, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto4, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3)  
			SELECT     Articulo,     Descripcion1,     Descripcion2,     NombreCorto,     Grupo,     Categoria,     Familia,     Linea,     Fabricante,     Impuesto1,     Impuesto2,     Impuesto3,     Factor,     Unidad,     UnidadCompra,     UnidadTraspaso,     Tipo,     TipoOpcion,     Accesorios,     Sustitutos,     MonedaPrecio,     PrecioLista,     PrecioMinimo,     Estatus,     Alta,     Precio2,     Precio3,     Precio4,     Precio5,     Precio6,     Precio7,     Precio8,     Precio9,     Precio10,     BasculaPesar,     TieneMovimientos,     Retencion1,     Retencion2,     Retencion3, MonedaCosto,TipoCosteo, Calificacion, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto4, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3
			FROM Inserted
			WHERE Articulo NOT IN (SELECT Articulo FROM Art)
			GROUP BY Articulo,     Descripcion1,     Descripcion2,     NombreCorto,     Grupo,     Categoria,     Familia,     Linea,     Fabricante,     Impuesto1,     Impuesto2,     Impuesto3,     Factor,     Unidad,     UnidadCompra,     UnidadTraspaso,     Tipo,     TipoOpcion,     Accesorios,     Sustitutos,     MonedaPrecio,     PrecioLista,     PrecioMinimo,     Estatus,     Alta,     Precio2,     Precio3,     Precio4,     Precio5,     Precio6,     Precio7,     Precio8,     Precio9,     Precio10,     BasculaPesar,     TieneMovimientos,     Retencion1,     Retencion2,     Retencion3, MonedaCosto,TipoCosteo, Calificacion, TipoImpuesto1, TipoImpuesto2, TipoImpuesto3, TipoImpuesto4, TipoImpuesto5, TipoRetencion1, TipoRetencion2, TipoRetencion3
     
			UPDATE Art SET  Rama = i.Rama, Descripcion1 = i.Descripcion1, Descripcion2 = i.Descripcion2, NombreCorto = i.NombreCorto, Grupo = i.Grupo, Categoria = i.Categoria, Familia = i.Familia, Linea = i.Linea, Fabricante = i.Fabricante, Impuesto1 = i.Impuesto1, Impuesto2 = i.Impuesto2, Impuesto3 = i.Impuesto3, Factor = i.Factor, Unidad = i.Unidad, UnidadCompra = i.UnidadCompra, UnidadTraspaso = i.UnidadTraspaso, Tipo = i.Tipo, TipoOpcion = i.TipoOpcion, Accesorios = i.Accesorios, Sustitutos = i.Sustitutos, MonedaPrecio = i.MonedaPrecio, PrecioLista = i.PrecioLista, PrecioMinimo = i.PrecioMinimo, Estatus = i.Estatus, Alta = i.Alta, Precio2 = i.Precio2, Precio3 = i.Precio3, Precio4 = i.Precio4, Precio5 = i.Precio5, Precio6 = i.Precio6, Precio7 = i.Precio7, Precio8 = i.Precio8, Precio9 = i.Precio9, Precio10 = i.Precio10, BasculaPesar = i.BasculaPesar, TieneMovimientos = i.TieneMovimientos, Retencion1 = i.Retencion1, Retencion2 = i.Retencion2, Retencion3 = i.Retencion3, MonedaCosto = ISNULL(i.MonedaCosto,'Pesos'), TipoCosteo = i.TipoCosteo, Calificacion = ISNULL(i.Calificacion,0), TipoImpuesto1 = i.TipoImpuesto1, TipoImpuesto2 = i.TipoImpuesto2, TipoImpuesto3 = i.TipoImpuesto3, TipoImpuesto4 = i.TipoImpuesto4, TipoImpuesto5 = i.TipoImpuesto5, TipoRetencion1 = i.TipoRetencion1, TipoRetencion2 = i.TipoRetencion2, TipoRetencion3 = i.TipoRetencion3
			FROM Art a JOIN INSERTED i ON i.Articulo = a.Articulo         
		END

	RETURN     
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSArtCodigoSucursalABC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSArtCodigoSucursalABC
GO
CREATE TRIGGER tgPOSArtCodigoSucursalABC ON POSArtCodigoSucursal
--//WITH ENCRYPTION
FOR UPDATE, DELETE,INSERT
AS BEGIN
	DECLARE 
    @EsOrigen           bit,
    @SincronizaArtSuc   bit
    
    SELECT @EsOrigen = ISNULL(EsOrigen,0), @SincronizaArtSuc = ISNULL(SincronizaArtSuc,0) FROM POSiSync
  
	IF @EsOrigen = 1 RETURN
	IF @SincronizaArtSuc = 0 RETURN

	IF EXISTS(SELECT * FROM DELETED) AND NOT EXISTS(SELECT * FROM INSERTED)
		DELETE CB
		FROM CB c JOIN DELETED d ON c.Codigo = d.Codigo 

	IF EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED)
		UPDATE CB SET  Codigo = i.Codigo, Cuenta = i.Articulo, SubCuenta = i.SubCuenta, Cantidad = i.Cantidad, Unidad = i.Unidad
		FROM CB c JOIN INSERTED i ON c.Codigo = i.Codigo
     
	IF NOT EXISTS(SELECT * FROM DELETED) AND  EXISTS(SELECT * FROM INSERTED) 
		BEGIN
			INSERT CB(Codigo, TipoCuenta,  Cuenta, SubCuenta, Cantidad, Unidad)  
			SELECT    Codigo, 'Articulos', Articulo, SubCuenta, Cantidad, Unidad
			FROM Inserted
			WHERE Codigo NOT IN (SELECT Codigo FROM CB)
			GROUP BY  Codigo, Articulo, SubCuenta, Cantidad, Unidad
     
			UPDATE CB SET  Codigo = i.Codigo, Cuenta = i.Articulo, SubCuenta = i.SubCuenta, Cantidad = i.Cantidad, Unidad = i.Unidad
			FROM CB c JOIN INSERTED i ON c.Codigo = i.Codigo         
		END
	
	RETURN     
END
GO


  /****** VentaProcesarNotas  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'VentaProcesarNotas')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaProcesarNotas', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.VentaProcesarNotas') AND type = 'U') 
	CREATE TABLE dbo.VentaProcesarNotas (
		IDOrigen                int             NOT NULL,
		ID                      int             NOT NULL,
		Renglon                 float           NOT NULL, 
		RenglonSub              int             NOT NULL, 
		Almacen                 varchar(10)     NULL, 
		Posicion                varchar(10)     NULL,    
		Articulo                varchar(20)     NULL, 
		SubCuenta               varchar(50)     NULL, 
		RenglonTipo             char(1)         NULL, 
		Unidad                  varchar(50)     NULL, 
		Impuesto1               float           NULL, 
		Impuesto2               float           NULL, 
		Impuesto3               float           NULL, 
		Cantidad                float           NULL, 
		CantidadInventario      float           NULL, 
		DescuentoTipo           char(1)         NULL, 
		DescuentoLinea          money           NULL, 
		Precio                  float           NULL, 
		DescuentoGlobal         float           NULL, 
		SobrePrecio             float           NULL, 
		MonedaCosto             varchar(10)     NULL, 
		Tipo                    varchar(20)     NULL, 
		CostoIdentificado       bit             NULL, 
		PrecioMoneda            varchar(10)     NULL, 
		PrecioTipoCambio        float           NULL, 
		CantidadObsequio        float           NULL, 
		OfertaID                int             NULL, 
		PrecioSugerido          float           NULL, 
		DescuentoImporte        money           NULL, 
		Puntos                  money           NULL, 
		Comision                money           NULL,     
  
	CONSTRAINT priVentaProcesarNotas PRIMARY KEY CLUSTERED (IDOrigen,ID,Renglon,RenglonSub)   
	)
GO

EXEC spALTER_TABLE 'VentaProcesarNotas', 'Agente', 'char(10) NULL'
GO


/****** POSLInv ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLInv')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLInv', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLInv') AND type = 'U') 
	CREATE TABLE dbo.POSLInv (
        ID					varchar(36)		NOT NULL,
        Renglon				float			NOT NULL,
        RenglonSub			int				NOT NULL	DEFAULT 0,       
        RenglonID			int				NULL,
        RenglonTipo			varchar(1)		NULL,
        Aplica				varchar(20)		NULL,
        AplicaID			varchar(20)		NULL,
        Cantidad			float			NULL,
        Articulo			varchar(20)		NULL,
        SubCuenta			varchar(50)		NULL,
        Unidad				varchar(50)		NULL,
        Factor				float			NULL,
        CantidadInventario	float			NULL,
        Almacen  			varchar(20)		NULL,  
		Codigo              varchar(30)     NULL,   
		Precio              float           NULL, 
	CONSTRAINT priPOSLInv PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
	)
GO


/****** POSCobroCondicionTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCobroCondicionTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCobroCondicionTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCobroCondicionTemp') AND type = 'U') 
	CREATE TABLE dbo.POSCobroCondicionTemp (
		Estacion        int         NOT NULL,
        ID				varchar(36)	NOT NULL,
        Renglon			float		NOT NULL,
        Cantidad        float           NULL,
        Articulo        varchar(20)     NULL,
		FormaPago       varchar(50)     NULL,   
		Precio          float           NULL, 
		PrecioTotal		float           NULL, 
  
	CONSTRAINT priPOSCobroCondicionTemp PRIMARY KEY  CLUSTERED (Estacion, ID, Renglon)
  )
GO


/****** POSCancelacionArticulos ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCancelacionArticulos')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCancelacionArticulos', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCancelacionArticulos') AND type = 'U') 
	CREATE TABLE dbo.POSCancelacionArticulos (
        ID                      varchar(36)  NOT NULL,
        Empresa                 varchar(5)   NULL,
        Sucursal                int          NULL,
        Cajero                  varchar(10)  NULL,
        Caja                    varchar(10)  NULL,
        Articulo                varchar(20)  NULL,
        Precio                  float        NULL,
        Fecha                   datetime     NOT NULL, 
        Cantidad                float        NULL,           
	
	CONSTRAINT priPOSCancelacionArticulos PRIMARY KEY CLUSTERED (ID, Fecha)
  )
GO
EXEC spDROP_PK 'POSCancelacionArticulos'
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaPedidoAnticipoPendiente') and sysstat & 0xf = 2) DROP VIEW dbo.VentaPedidoAnticipoPendiente
GO
CREATE VIEW VentaPedidoAnticipoPendiente
--//WITH ENCRYPTION
AS
	SELECT v.ID, v.Empresa, v.Mov, v.MovID, v.FechaEmision, v.Concepto, v.Proyecto, v.UEN, v.Moneda, v.TipoCambio, v.Usuario, v.Referencia, v.Observaciones, v.Estatus, v.Cliente, v.EnviarA, v.Almacen, v.Agente, v.AgenteServicio, v.AgenteComision, v.FormaEnvio, v.Condicion, v.Vencimiento, v.CtaDinero, v.Descuento, v.DescuentoGlobal, v.Importe, v.Impuestos, v.Saldo, v.DescuentoLineal, v.OrigenTipo, v.Origen, v.OrigenID, v.FechaRegistro, v.Causa, v.Atencion, v.AtencionTelefono, v.ListaPreciosEsp, v.ZonaImpuesto, v.Sucursal, v.SucursalOrigen, v.FechaRequerida, RTRIM(LTRIM(v.Mov))+' '+RTRIM(LTRIM(v.MovID)) MovConsecutivo
    FROM Venta v JOIN MovTipo m ON v.Mov = m.Mov  AND m.Modulo = 'VTAS'
	WHERE m.Clave = 'VTAS.P'
    AND v.Estatus = 'PENDIENTE'   
GO 


/****** CxcAnticipoPendienteTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CxcAnticipoPendienteTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CxcAnticipoPendienteTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CxcAnticipoPendienteTemp') AND type = 'U') 
	CREATE TABLE dbo.CxcAnticipoPendienteTemp (
        Estacion                int          NOT NULL,
        ID                      int          NOT NULL,
        Empresa                 varchar(5)   NULL,
        Mov                     varchar(20)  NULL,
        MovID                   varchar(20)  NULL,
        FechaEmision            datetime     NULL,
        Referencia              varchar(50)  NULL,
        Cliente                 varchar(10)  NULL,
        Concepto                varchar(50)  NULL,
        AnticipoSaldo           float        NULL,
        Moneda                  varchar(10)  NULL,
        TipoCambio              float        NULL,
        Importe                 float        NULL,
        Impuestos               float        NULL,
        Retencion               float        NULL, 
        AnticipoAplicar         float        NULL,
  
	CONSTRAINT priCxcAnticipoPendienteTemp PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO


/****** CxcAnticipoPendienteTemp2 ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CxcAnticipoPendienteTemp2')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CxcAnticipoPendienteTemp2', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CxcAnticipoPendienteTemp2') AND type = 'U') 
	CREATE TABLE dbo.CxcAnticipoPendienteTemp2 (
        Estacion                int          NOT NULL,
        ID                      int          NOT NULL,
        Empresa                 varchar(5)   NULL,
        Mov                     varchar(20)  NULL,--Movimiento
        MovID                   varchar(20)  NULL,--Consecutivo
        FechaEmision            datetime     NULL,
        Referencia              varchar(50)  NULL,
        Cliente                 varchar(10)  NULL,
        Concepto                varchar(50)  NULL,
        AnticipoSaldo           float        NULL,--Saldo Anticipo
        Moneda                  varchar(10)  NULL,
        TipoCambio              float        NULL,
        Importe                 float        NULL,
        Impuestos               float        NULL,
        Retencion               float        NULL, 
        AnticipoAplicar         float        NULL,--Importe Aplicar
  
	CONSTRAINT priCxcAnticipoPendienteTemp2 PRIMARY KEY CLUSTERED (ID,Estacion)
  )
GO


/****** POSFacturarNotasTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSFacturarNotasTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSFacturarNotasTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSFacturarNotasTemp') AND type = 'U') 
	CREATE TABLE dbo.POSFacturarNotasTemp (
        Estacion        int          NOT NULL,
        MovFactura		varchar(20)  NULL,
        Cliente         varchar(10)  NULL,
  
	CONSTRAINT priPOSFacturarNotasTemp PRIMARY KEY CLUSTERED (Estacion)
  )
GO


/****** VentaRefacturarTemp  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'VentaRefacturarTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaRefacturarTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.VentaRefacturarTemp') AND type = 'U') 
	CREATE TABLE dbo.VentaRefacturarTemp (
           Estacion     int         NOT NULL,
           ID           int         NOT NULL,
           Empresa		varchar(5)  NULL,
           Mov          varchar(20) NOT NULL,	   
           MovID        varchar(20) NOT NULL,	
           Cliente      varchar(10) NULL,   

	CONSTRAINT priVentaRefacturarTemp PRIMARY KEY CLUSTERED (Estacion,ID)   
	)
GO


/****** POSLDIEdoCtaTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIEdoCtaTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIEdoCtaTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIEdoCtaTemp') AND type = 'U') 
	CREATE TABLE dbo.POSLDIEdoCtaTemp (
        ID              int IDENTITY(11,1)NOT NULL,
        Estacion		int          NOT NULL,
        Fecha           datetime     NULL, 
        Monto           float        NULL, 
        Mov             varchar(50)  NULL, 
        Concepto        varchar(50)  NULL,
        Referencia      varchar(50)  NULL,
             
	CONSTRAINT priPOSLDIEdoCtaTemp PRIMARY KEY CLUSTERED (Estacion,ID)
  )
GO

EXEC spALTER_COLUMN 'POSLDIEdoCtaTemp', 'Fecha',	 'datetime NULL'
EXEC spALTER_COLUMN 'POSLDIEdoCtaTemp', 'Monto',	 'float NULL'
EXEC spALTER_COLUMN 'POSLDIEdoCtaTemp', 'Mov',	 'varchar(50) NULL'
EXEC spALTER_COLUMN 'POSLDIEdoCtaTemp', 'Concepto',	 'varchar(50) NULL'
EXEC spALTER_COLUMN 'POSLDIEdoCtaTemp', 'Referencia',	 'varchar(50) NULL'
GO


/****** POSFechaCierre  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSFechaCierre')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSFechaCierre', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSFechaCierre') AND type = 'U') 
	CREATE TABLE dbo.POSFechaCierre (
           Sucursal         int         NOT NULL,
           Fecha            datetime    NOT NULL,    
	CONSTRAINT priPOSPOSFechaCierre PRIMARY KEY CLUSTERED (Sucursal,Fecha)   
	)
GO


/****** POSCierreSucursalTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCierreSucursalTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCierreSucursalTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCierreSucursalTemp') AND type = 'U') 
	CREATE TABLE dbo.POSCierreSucursalTemp (
           Estacion         int         NOT NULL,
           Fecha            datetime    NULL,
           Mov              varchar(20) NULL,
           CtaDineroDestino varchar(10) NULL,
    
	CONSTRAINT priPOSCierreSucursalTemp PRIMARY KEY CLUSTERED (Estacion)  
	)
GO


/****** POSDepurarTablasTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSDepurarTablasTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSDepurarTablasTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSDepurarTablasTemp') AND type = 'U') 
	CREATE TABLE dbo.POSDepurarTablasTemp (
           Estacion         int         NOT NULL,
           Fecha            datetime    NULL,
    
	CONSTRAINT priPOSDepurarTablasTemp PRIMARY KEY CLUSTERED (Estacion)   
	)
GO


/****** POSCierreSucursalD ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCierreSucursalD')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCierreSucursalD', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCierreSucursalD') AND type = 'U') 
	CREATE TABLE dbo.POSCierreSucursalD (
           Estacion         int         NOT NULL,
           Sucursal         int         NOT NULL,
           FormaPago        varchar(50) NOT NULL,
           Importe          float       NULL,
           Referencia       varchar(50) NULL,
           CtaDineroDestino varchar(10) NULL,
    
	CONSTRAINT priPOSCierreSucursalD PRIMARY KEY CLUSTERED (Sucursal,Estacion,FormaPago)   
	)
GO
EXEC spALTER_TABLE 'POSCierreSucursalD ', 'CtaDineroDestino','varchar(10) NULL'
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSFechaCierreA') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSFechaCierreA
GO
CREATE TRIGGER tgPOSFechaCierreA ON POSFechaCierre
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
	DECLARE
	@SucursalA           int,
	@FechaA              datetime
  
	SELECT @SucursalA = Sucursal, @FechaA = Fecha FROM INSERTED
  
	IF EXISTS (SELECT * FROM POSEstatusCajasCierre WHERE Sucursal = @SucursalA AND Fecha <> @FechaA)
	    UPDATE POSEstatusCajasCierre SET Fecha = @FechaA WHERE Sucursal = @SucursalA AND Fecha <> @FechaA
	END
GO


/****** POSEstatusCajasCierre ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSEstatusCajasCierre')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSEstatusCajasCierre', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSEstatusCajasCierre') AND type = 'U') 
	CREATE TABLE dbo.POSEstatusCajasCierre (
           Sucursal         int         NOT NULL,
           Caja             varchar(10) NOT NULL,
           Fecha            datetime    NOT NULL,    
	CONSTRAINT priPOSEstatusCajasCierre PRIMARY KEY CLUSTERED (Sucursal,Fecha, Caja)   
	)
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VentaRefacturar') and sysstat & 0xf = 2) DROP VIEW dbo.VentaRefacturar
GO
CREATE VIEW VentaRefacturar
--//WITH ENCRYPTION
AS
	SELECT v.ID, v.Empresa, v.Mov, v.MovID, v.Cliente, v.Importe, v.Impuestos, c.Nombre, v.Sucursal, v.Almacen, v.FechaEmision,		v.Estatus, v.Moneda, v.Usuario
	FROM Venta v JOIN MovTipo m ON v.Mov = m.Mov AND m.Modulo = 'VTAS'
	JOIN Cte c ON v.Cliente = c.Cliente
	WHERE v.Estatus NOT IN ('SINAFECTAR','CANCELADO') 
	AND m.Clave IN ('VTAS.N')
	AND v.Refacturado = 0
	AND v.Importe > 0.0	  
GO


/*** CFDFlexPendiente ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDFlexPendiente') and type = 'V') DROP VIEW dbo.CFDFlexPendiente
GO
CREATE VIEW CFDFlexPendiente
--//WITH ENCRYPTION
AS 
	SELECT 'VTAS' As Modulo, v.ID , v.Mov, v.MovID, v.FechaEmision, v.Estatus, v.CFDFlexEstatus, v.Importe, v.Impuestos, v.Cliente as	Cliente_Proveedor, v.Empresa, v.Sucursal  
	FROM Venta v JOIN MovTipo mt ON v.Mov = mt.Mov
	WHERE mt.CFDFlex = 1
	AND v.Estatus NOT IN ('SINAFECTAR','CANCELADO') 
	AND v.CFDFlexEstatus IN('ERROR','PROCESANDO')   
	UNION ALL      
	SELECT 'CXC' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Cliente, c.Empresa, c.Sucursal  
	FROM Cxc c JOIN MovTipo mt ON c.Mov = mt.Mov
	WHERE mt.CFDFlex = 1
	AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
	AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')    
	UNION ALL     
	SELECT 'CXP' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Proveedor, c.Empresa, c.Sucursal  
	FROM Cxp c JOIN MovTipo mt ON c.Mov = mt.Mov
	WHERE mt.CFDFlex = 1
	AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
	AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')     
	UNION ALL     
	SELECT 'COMS' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Proveedor,	c.Empresa, c.Sucursal  
	FROM Compra c JOIN MovTipo mt ON c.Mov = mt.Mov
	WHERE mt.CFDFlex = 1
	AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
	AND c.CFDFlexEstatus IN('ERROR','PROCESANDO')      
	UNION ALL     
	SELECT 'CORTE' As Modulo, c.ID, c.Mov, c.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, 0.0, NULL, c.Empresa, c.Sucursal  
	FROM Corte c JOIN MovTipo mt ON c.Mov = mt.Mov
	WHERE mt.CFDFlex = 1
	AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
	AND c.CFDFlexEstatus IN('ERROR','PROCESANDO') 
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSCFDFlexPendiente') and type = 'V') DROP VIEW dbo.POSCFDFlexPendiente
GO
CREATE VIEW POSCFDFlexPendiente
--//WITH ENCRYPTION
AS 
  SELECT c.Modulo, c.ID, p.Mov, p.MovID, c.FechaEmision, c.Estatus, c.CFDFlexEstatus, c.Importe, c.Impuestos, c.Cliente_Proveedor, c.Empresa, c.Sucursal, p.ID IDPOS, c.Mov MovVenta, c.MovID MovIDVenta
    FROM CFDFlexPendiente c     
    JOIN POSL p ON p.Empresa = c.Empresa AND p.Origen = c.Mov AND p.OrigenID = c.MovID AND c.Modulo = 'VTAS'
   WHERE p.Estatus = 'FACTURADO' 
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSListaPreciosSubUnidadC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSListaPreciosSubUnidadC
GO
CREATE TRIGGER tgPOSListaPreciosSubUnidadC ON ListaPreciosSubUnidad
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
	DECLARE
	@Articulo            varchar(20),
	@SubCuenta           varchar(50),
	@Unidad              varchar(50),
	@ListaPrecios        varchar(20),
	@PrecioAnterior      float,
	@Precio              float

	DECLARE crLista CURSOR local FOR
	SELECT i.Articulo, ISNULL(i.SubCuenta,''),  i.Lista,  i.Precio, d.Precio, i.Unidad
    FROM INSERTED i
    JOIN  DELETED d ON d.Lista= i.Lista AND  d.Moneda= i.Moneda AND d.Articulo = i.Articulo AND d.SubCuenta = i.SubCuenta AND d.Unidad = i.Unidad
    WHERE d.Precio <> i.Precio   
	OPEN crLista
	FETCH NEXT FROM crLista INTO @Articulo, @SubCuenta, @ListaPrecios, @Precio, @PrecioAnterior, @Unidad 
	WHILE @@FETCH_STATUS = 0  
	BEGIN
	    INSERT POSAuxiliarArtPrecio(Articulo,  SubCuenta,Fecha,      ListaPrecios, PrecioAnterior,  Precio, Unidad)
	    SELECT                      @Articulo, @SubCuenta,GETDATE(), @ListaPrecios, @PrecioAnterior ,@Precio, @Unidad    
		FETCH NEXT FROM crLista INTO @Articulo, @SubCuenta, @ListaPrecios, @Precio, @PrecioAnterior , @Unidad 
	END
	CLOSE crLista
	DEALLOCATE crLista 

	RETURN     
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSListaPreciosSubC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSListaPreciosSubC
GO
CREATE TRIGGER tgPOSListaPreciosSubC ON ListaPreciosSub
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
	DECLARE
	@Articulo            varchar(20),
	@SubCuenta           varchar(50),
	@ListaPrecios        varchar(20),
	@PrecioAnterior      float,
	@Precio              float,
	@Unidad              varchar(50) 

	DECLARE crLista CURSOR local FOR
	SELECT i.Articulo, ISNULL(i.SubCuenta,''),  i.Lista,  i.Precio, d.Precio
    FROM INSERTED i
    JOIN  DELETED d ON d.Lista= i.Lista AND  d.Moneda= i.Moneda AND d.Articulo = i.Articulo AND d.SubCuenta = i.SubCuenta
    WHERE d.Precio <> i.Precio   
	OPEN crLista
	FETCH NEXT FROM crLista INTO @Articulo, @SubCuenta, @ListaPrecios, @Precio, @PrecioAnterior 
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		INSERT POSAuxiliarArtPrecio(Articulo,  SubCuenta,Fecha,      ListaPrecios, PrecioAnterior,  Precio, Unidad)
		SELECT                      @Articulo, @SubCuenta,GETDATE(), @ListaPrecios, @PrecioAnterior ,@Precio, @Unidad    
		FETCH NEXT FROM crLista INTO @Articulo, @SubCuenta, @ListaPrecios, @Precio, @PrecioAnterior  
	END
	CLOSE crLista
	DEALLOCATE crLista 

	RETURN     
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSListaPreciosDUnidadC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSListaPreciosDUnidadC
GO
CREATE TRIGGER tgPOSListaPreciosDUnidadC ON ListaPreciosDUnidad
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
	DECLARE
	@Articulo            varchar(20),
	@SubCuenta           varchar(50),
	@ListaPrecios        varchar(20),
	@PrecioAnterior      float,
	@Precio              float,
	@Unidad              varchar(50) 

	DECLARE crLista CURSOR local FOR
	SELECT i.Articulo,  i.Lista,  i.Precio, d.Precio, i.Unidad
    FROM INSERTED i
    JOIN  DELETED d ON d.Lista= i.Lista AND  d.Moneda= i.Moneda AND d.Articulo = i.Articulo AND d.Unidad = i.Unidad
    WHERE d.Precio <> i.Precio   
	OPEN crLista
	FETCH NEXT FROM crLista INTO @Articulo,  @ListaPrecios, @Precio, @PrecioAnterior ,@Unidad
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		INSERT POSAuxiliarArtPrecio(Articulo,  SubCuenta,             Fecha,      ListaPrecios, PrecioAnterior,  Precio, Unidad)
		SELECT                      @Articulo, ISNULL(@SubCuenta,''), GETDATE(), @ListaPrecios, @PrecioAnterior ,@Precio, @Unidad
    
		FETCH NEXT FROM crLista INTO @Articulo,  @ListaPrecios, @Precio, @PrecioAnterior ,@Unidad 
	END
	CLOSE crLista
	DEALLOCATE crLista 

	RETURN       
END
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSCierreDia') and sysstat & 0xf = 2) DROP VIEW dbo.POSCierreDia
GO
CREATE VIEW POSCierreDia
--//WITH ENCRYPTION
AS
	SELECT ROW_NUMBER() OVER(ORDER BY Venta.FechaEmision )  ID,
		Venta.Empresa, Venta.FechaEmision, Venta.Moneda, Venta.Almacen, Venta.Sucursal
	FROM  Venta Venta JOIN MovTipo MovTipo ON MovTipo.Mov = Venta.Mov AND MovTipo.Modulo = 'VTAS'
	WHERE Venta.Estatus='PROCESAR' AND MovTipo.Clave IN ('VTAS.N', 'VTAS.NR')
	GROUP BY   Venta.FechaEmision,   Venta.Moneda,   Venta.Almacen,   Venta.Sucursal, Venta.Empresa  
GO 


/****** POSMovMenuSupervision  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='POSMovMenuSupervision' AND xtype='U')
CREATE TABLE dbo.POSMovMenuSupervision(
	Empresa				varchar(5) NOT NULL,
	AperturaCaja		varchar(20) NULL,
	AumentoCaja			varchar(20) NULL,
	CorteParcialCaja	varchar(20) NULL,
	CorteCaja			varchar(20) NULL,
	CancelacionACaja	varchar(20) NULL,
	CancelacionCCaja	varchar(20) NULL,
	Egreso				varchar(20) NULL,
	Ingreso				varchar(20) NULL,
	AperturaCajaM		varchar(20) NULL,
	AumentoCajaM		varchar(20) NULL,
	CorteParcialCajaM	varchar(20) NULL,
	CorteCajaM			varchar(20) NULL,
	CancelacionACajaM	varchar(20) NULL,
	CancelacionCCajaM	varchar(20) NULL,
	EgresoM				varchar(20) NULL,
	IngresoM			varchar(20) NULL,	
)
GO

EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'AperturaCajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'AumentoCajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'CorteParcialCajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'CorteCajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'CancelacionACajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'CancelacionCCajaM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'EgresoM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'IngresoM','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSMovMenuSupervision  ', 'Recoleccion','varchar(20)	NULL'
GO


/****** POSJobErrores  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='POSJobErrores' AND xtype='U')
CREATE TABLE POSJobErrores(
	ID			int IDENTITY(1,1) NOT NULL,
	Sucursal	int NOT NULL,
	IDPos		varchar(36) NOT NULL,
	Error		varchar(255) NULL,
	Atendido	bit DEFAULT (0)
) ON [PRIMARY]
GO


/****** HArticulos  ******/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME ='HArticulos' AND xtype='U')
CREATE TABLE HArticulos(
	ID					int IDENTITY(1,1) NOT NULL,
	Articulo			varchar(20) NOT NULL,
	Tipo				varchar(20) DEFAULT ('Normal') NOT NULL,
	Descripcion1		varchar(100) NULL,
	Unidad				varchar(50) NULL,
	UnidadCompra		varchar(50) NULL,
	UnidadTraspaso		varchar(50) NULL,
	TipoCosteo			varchar(10) NULL,
	Grupo				varchar(50) NULL,
	Familia				varchar(50) NULL,
	Linea				varchar(50) NULL,
	Categoria			varchar(50) NULL,
	Impuesto1			float NOT NULL,
	Impuesto2			float NULL,
	Impuesto3			float NULL,
	TipoCompra			varchar(20) NULL,
	SeVende				bit DEFAULT ((0))NULL,
	SeCompra			bit DEFAULT ((0))NULL,
	Cuenta				varchar(20) NULL,
	Cuenta2				varchar(20) NULL,
	Cuenta3				varchar(20) NULL,
	BasculaPesar		bit DEFAULT ((0))NULL,
	MonedaCosto			varchar(10) NOT NULL,
	MonedaPrecio		varchar(10) NOT NULL,
	Estatus				varchar(15) NOT NULL,
	CodigoCB			varchar(30) NULL,
	TipoCuentaCB		varchar(20) NULL,
	CuentaCB			varchar(20) NULL,
	CantidadCB			float NULL,
	UnidadCB			varchar(50) NULL,
	ListaModificarP		varchar(20) NULL,
	FechainicioP		datetime  NULL,
	FechaterminoP		datetime  NULL,
	Nuevo				money NULL,
	Anterior			money NULL,
	TipoOpcion			varchar(20) NULL,
	Proveedor			varchar(10) NULL,
	Usuario				varchar(10) NULL,
	EstatusRegistro		varchar(10) NULL,
	DestinoID			int  NULL,
 
	CONSTRAINT priHArticulos PRIMARY KEY CLUSTERED (Articulo)
	)
GO


/****** VuelosDF  ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'VuelosDF')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VuelosDF', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.VuelosDF') AND type = 'U')
CREATE TABLE VuelosDF(
	NoVuelo			varchar(20) NOT NULL,
	Aerolinea		varchar(50) NOT NULL,
	Origen			varchar(100) NULL,
	Destino			varchar(100) NULL
) 
GO

/****** POSHistMoratorios ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSHistMoratorios')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSHistMoratorios', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSHistMoratorios') AND type = 'U') 
	CREATE TABLE dbo.POSHistMoratorios (
		FechaCobro			datetime,
		ID					varchar(36)	NOT NULL,
		POSMov				varchar(20) NULL,
		POSMovID			varchar(20) NULL,
		IDGenerado			int,
		CXCMov				varchar(20) NULL,
		CXCMovID			varchar(20) NULL,				
		Saldo				float,
		Moratorios			float,
		TasaMoratorios		float,
		DiasMoratorios		int,
		Moneda				varchar(10) NULL,
		Sucursal			int,
		Empresa				varchar(5)  NULL)
GO

EXEC spALTER_TABLE 'POSHistMoratorios  ', 'Aplica','varchar(20)	NULL'
EXEC spALTER_TABLE 'POSHistMoratorios  ', 'AplicaID','varchar(20)	NULL'
EXEC spDROP_COLUMN 'POSLVenta', 'Estatus'
EXEC spDROP_COLUMN 'POSLCobro', 'Estatus'
GO


/**************** fnPOSLEstatus ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPOSLEstatus') DROP FUNCTION fnPOSLEstatus
GO
CREATE FUNCTION dbo.fnPOSLEstatus (
	@ID			varchar(50)
	) 
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
	DECLARE 
    @Resultado  varchar(20)
	
	SELECT @Resultado = Estatus FROM POSL WHERE ID = @ID
	
	RETURN (@Resultado)
 END
GO

EXEC spALTER_TABLE 'POSLVenta',  'Estatus', 'AS dbo.fnPOSLEstatus(ID)'
GO

EXEC spALTER_TABLE 'POSLCobro',  'Estatus', 'AS dbo.fnPOSLEstatus(ID)'
GO


/****** CxcAnticipoPendienteTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'OfertaCascadaGrupo')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OfertaCascadaGrupo', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.OfertaCascadaGrupo') AND type = 'U') 
	CREATE TABLE dbo.OfertaCascadaGrupo (
        ID         int NOT NULL,
        Desde      float NOT NULL,
        Hasta      float NULL,
        Porcentaje float NULL,
	CONSTRAINT priOfertaCascadaGrupo PRIMARY KEY CLUSTERED (ID,Desde)
  )
GO


/*** POSSaldoCaja ***/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.POSSaldoCaja') and type = 'V') DROP VIEW dbo.POSSaldoCaja
GO
CREATE VIEW POSSaldoCaja
--//WITH ENCRYPTION
AS 
     SELECT plc.FormaPago, p.Caja,  SUM(plc.Importe * mt.Factor) Importe, SUM(plc.ImporteRef * mt.Factor) ImporteRef
     FROM POSLCobro plc
     INNER JOIN POSL p ON plc.ID = p.ID
     INNER JOIN MovTipo mt ON p.Mov = mt.Mov
   	 AND mt.Modulo = 'POS'      			   
     WHERE  p.Estatus IN('CONCLUIDO','TRASPASADO') 
     GROUP BY plc.FormaPago, p.Caja
GO


IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.tgPOSListaPreciosDC') and sysstat & 0xf = 8) DROP TRIGGER dbo.tgPOSListaPreciosDC
GO
CREATE TRIGGER tgPOSListaPreciosDC ON ListaPreciosD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
	DECLARE
	@Articulo            varchar(20),
	@SubCuenta           varchar(50),
	@ListaPrecios        varchar(20),
	@PrecioAnterior      float,
	@Precio              float,
	@Unidad              varchar(50) 

	DECLARE crLista CURSOR local FOR
	SELECT i.Articulo,   i.Lista,  i.Precio, d.Precio
    FROM INSERTED i
    JOIN  DELETED d ON d.Lista= i.Lista AND  d.Moneda= i.Moneda AND d.Articulo = i.Articulo
    WHERE d.Precio <> i.Precio   
	OPEN crLista
	FETCH NEXT FROM crLista INTO @Articulo, @ListaPrecios, @Precio, @PrecioAnterior 
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		INSERT POSAuxiliarArtPrecio(Articulo,  SubCuenta,             Fecha,      ListaPrecios, PrecioAnterior,  Precio, Unidad)
		SELECT                      @Articulo, ISNULL(@SubCuenta,''), GETDATE(), @ListaPrecios, @PrecioAnterior ,@Precio, @Unidad                  
		FETCH NEXT FROM crLista INTO @Articulo,  @ListaPrecios, @Precio, @PrecioAnterior  
	END
	CLOSE crLista
	DEALLOCATE crLista 

	RETURN
END
GO


/****** POSLDIMonedero ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSLDIMonedero')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSLDIMonedero', 'Movimiento')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSLDIMonedero') AND type = 'U') 
	CREATE TABLE dbo.POSLDIMonedero (
		Monedero		varchar(36)	NOT NULL,	
		Cliente			varchar(10)	NULL,	
	CONSTRAINT priPOSLDIMonedero PRIMARY KEY CLUSTERED (Monedero)
	)
GO


/****** ResumenGerencial ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ResumenGerencial')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ResumenGerencial', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.ResumenGerencial') AND type = 'U') 
	CREATE TABLE ResumenGerencial(
		Modulo				varchar(20) NULL,
		Mov					varchar(20) NULL,
		TotalMov			int NULL,
		ImportePesos		decimal(9,2) NULL,
		ImporteDolares		decimal(9,2) NULL,
		TotalVencido		int NULL,
		TotalPorVencer		int NULL,
		TotalEnTiempo		int NULL,
		MovTipo				char(20) NULL,
		Usuario				varchar(10) NULL
	)
GO


IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Cxc','Factura', 0, 0, 0, 0, 0, 0, 'CXC.F', 'NULL') 
GO	
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Cxc','Factura', 0, 0, 0, 0, 0, 0, 'CXC.F', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Cxc','Documento', 0, 0, 0, 0, 0, 0, 'CXC.D', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Venta','Cotizacion', 0, 0, 0, 0, 0, 0, 'VTAS.C', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Venta','Pedido', 0, 0, 0, 0, 0, 0, 'VTAS.P', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Cxp','Pagos', 0, 0, 0, 0, 0, 0, 'CXP.P', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Compra','Compras', 0, 0, 0, 0, 0, 0, 'COMS.FL', 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Soporte','Proyectos', 0, 0, 0, 0, 0, 0, NULL, 'NULL')
GO
IF NOT EXISTS(SELECT * FROM ResumenGerencial WHERE Mov ='Factura')
	INSERT ResumenGerencial VALUES('Venta','O. de Servicio', 0, 0, 0, 0, 0, 0, 'VTAS.S', 'NULL')
GO


/****** ResumenGerencialDetalle ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ResumenGerencialDetalle')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ResumenGerencialDetalle', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.ResumenGerencialDetalle') AND type = 'U') 
	CREATE  TABLE ResumenGerencialDetalle(
		Modulo				varchar(20)		NULL,
		ID					int,
		Mov					varchar(20)		NULL,
		MovID				varchar(20)		NULL,
		Cliente				char (10)		NULL,
		Nombre				varchar(100)	NULL,
		FechaEmision		DateTime		NULL,
		Concepto			varchar(50)		NULL,
		Proyecto			varchar(50)		NULL,
		Uen					int				NULL,
		TipoCambio			float,
		Usuario				char(10)		NULL,
		Autorizacion		char(10)		NULL,
		Referencia			varchar(50)		NULL,
		Observaciones		varchar(50)		NULL,
		CtaDinero			char(10)		NULL,
		Condicion			varchar(50)		NULL,
		FormaCobro			varchar(50)		NULL,
		Importe				money			NULL,
		Impuestos			money			NULL,
		Retencion			money			NULL,
		MovAplica			varchar(50)		NULL,
		MovAplicaID			varchar(50)		NULL,
		Origen				varchar(50)		NULL,
		OrigenID			varchar(50)		NULL,
		Vencimiento			DateTime		NULL,
		DiasMoratorios		int				NULL,
		Saldo				money			NULL,
		Estatus				varchar(20)		NULL,
		Moneda				char (10)		NULL
	)
GO


IF NOT EXISTS(SELECT * FROM POSLDIEmpresa WHERE Empresa = 'DEMO')
  INSERT POSLDIEmpresa (Empresa, EmpresaLDI) 
                VALUES ('DEMO',  '1') 
         
  -- Sucursal
IF NOT EXISTS(SELECT * FROM POSLDISucursal WHERE Empresa = 'DEMO' AND Sucursal = 0)
  INSERT POSLDISucursal (Empresa, Sucursal, SucursalLDI) 
                 VALUES ('DEMO',  '0',	    '31') 

--Registros Reales
-- De Santander
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'SANTANDERPP')
  INSERT POSLDIServicio (Servicio,      DireccionIP,       Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		         VALUES ('SANTANDERPP', '192.168.148.128', '3000', '401',   NULL,       NULL,      'S',           NULL,         0)   

--De Monedero
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON ALTA NUEVO')
  INSERT POSLDIServicio (Servicio,        DireccionIP,     Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA NUEVO', '200.94.104.94', '9899', '261',  0,          NULL,      'N',           NULL,         0)       

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON ALTA MODIFICA')
  INSERT POSLDIServicio (Servicio,            DireccionIP,     Puerto, TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA MODIFICA', '200.94.104.94', '9899', '261',   1,          NULL,      'N',           NULL,         0)   

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON ALTA REEMPLAZO')
  INSERT POSLDIServicio (Servicio,            DireccionIP,     Puerto,  TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ALTA REEMPLAZO', '200.94.104.94', '9899', '261',   2,          NULL,      'N',           NULL,         0)    

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON CONSULTA')
  INSERT POSLDIServicio (Servicio,            DireccionIP,     Puerto,  TrxType, TrxSubType, EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON CONSULTA', '200.94.104.94',      '9899', '265',    0,          NULL,      'S',           NULL,         0)       

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON CARGO')
  INSERT POSLDIServicio (Servicio,    DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON CARGO', '200.94.104.94', '9899', '263',    NULL,          NULL,      'N',           NULL,         0)           

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MON ABONO')
  INSERT POSLDIServicio (Servicio,    DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MON ABONO', '200.94.104.94', '9899', '262',    NULL,          NULL,      'N',           NULL,         0)            

--De Recarga de Telefonos
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'TELCEL')
  INSERT POSLDIServicio (Servicio, DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('TELCEL', '200.94.104.94', '9899',  '96',    NULL,          NULL,      'N',           NULL,         0)                       		 

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'IUSACELL')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('IUSACELL', '200.94.104.94', '9899',  '51',    NULL,          NULL,      'N',           NULL,         0)

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'UNEFON')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('UNEFON', '200.94.104.94', '9899',   '51',     '1',          NULL,      'N',           NULL,         0)

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MOVISTAR')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MOVISTAR', '200.94.104.94', '9899',   '71',   NULL,          NULL,      'N',           NULL,         0)

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'NEXTEL')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('NEXTEL', '200.94.104.94', '9899',   '611',    1,          NULL,      'N',           NULL,         0)
		 		 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'TELMEX')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('TELMEX', '200.94.104.94', '9899',   '611',    149,          NULL,      'N',           NULL,         0)	
		 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'CFE')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('CFE', '200.94.104.94', '9899',   '611',    100,          NULL,      'N',           NULL,         0)		 	 

IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'SKY')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('SKY', '200.94.104.94', '9899',   '611',    250,          NULL,      'N',           NULL,         0)			 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'INFONAVIT')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('INFONAVIT', '200.94.104.94', '9899',   '611',    1700,          NULL,      'N',           NULL,         0)			 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'MEGACABLE')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('MEGACABLE', '200.94.104.94', '9899',   '611',    300,          NULL,      'N',           NULL,         0)			 
		 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'GAS NAT DE MEXICO')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('GAS NAT DE MEXICO', '200.94.104.94', '9899',   '611',    1750,          NULL,      'N',           NULL,         0)			 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'CABLEMAS')
  INSERT POSLDIServicio (Servicio,   DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('CABLEMAS', '200.94.104.94', '9899',   '611',    800,          NULL,      'N',           NULL,         0)	
		 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'EDOCTAMES')
  INSERT POSLDIServicio (Servicio,     DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('EDOCTAMES', '200.94.104.94', '9899',   '267',    0,             NULL,      'N',           NULL,         0)	
		 
IF NOT EXISTS(SELECT * FROM POSLDIServicio WHERE Servicio = 'EDOCTAPERIODO')
  INSERT POSLDIServicio (Servicio,     DireccionIP,     Puerto,  TrxType, TrxSubType,    EntryMode, GeneraVoucher, AnchoVoucher, Tipo)
		 VALUES ('EDOCTAPERIODO', '200.94.104.94', '9899',   '267',    1,             NULL,      'N',           NULL,         0)
GO		


--POS/Mavi
/************ BonifSIMavi ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'BonifSIMavi')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('BonifSIMavi', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.BonifSIMavi') AND type = 'U') 
CREATE TABLE [dbo].[BonifSIMavi](
	[IDCxc] [int] NOT NULL,
	[Linea] [varchar](50) NOT NULL,
	[PrecioToTal] [money] NOT NULL,
	[SucursalVenta] [int] NOT NULL,
	[Articulo] [varchar](100) NULL,
	[MaviUltimoPago] [datetime] NULL,
	[Familia] [varchar](50) NULL,
 CONSTRAINT [priBonifSIMavi] PRIMARY KEY CLUSTERED 
(
	[IDCxc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ CalculoMoratoriosExMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CalculoMoratoriosExMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CalculoMoratoriosExMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CalculoMoratoriosExMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[CalculoMoratoriosExMAVI](
		[Mov] [varchar](20) NOT NULL,
		[Concepto] [varchar](50) NOT NULL,
	 CONSTRAINT [priCalculoMoratoriosExMAVI] PRIMARY KEY CLUSTERED 
(
	[Mov] ASC,
	[Concepto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ CobrosxPadre ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CobrosxPadre')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CobrosxPadre', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CobrosxPadre') AND type = 'U') 
CREATE TABLE [dbo].[CobrosxPadre](
	[IDPadre] [int] NOT NULL,
	[IDCobro] [int] NOT NULL,
	[FechaConclusion] [datetime] NOT NULL,
	[ImporteCobro] [float] NOT NULL,
	[Estatus] [varchar](10) NOT NULL,
	[Clave] [varchar](20) NULL
) ON [PRIMARY]

GO


/************ CobroXPoliticaHistMAVI ************/

IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CobroXPoliticaHistMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CobroXPoliticaHistMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CobroXPoliticaHistMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[CobroXPoliticaHistMAVI](
		[IdCobro] [int] NOT NULL,
		[FechaEmision] [datetime] NOT NULL,
		[EstatusCobro] [varchar](15) NULL,
		[ImporteCobro] [money] NULL,
		[Cliente] [varchar](10) NOT NULL,
		[Mov] [varchar](20) NULL,
		[MovID] [varchar](20) NULL,
		[SaldoIniciodelDia] [money] NULL,
		[TotalCobrosdelDia] [money] NULL,
		[PorcAbonoCapital] [float] NULL,
		[PorcMoratorioBonificar] [float] NULL,
		[TotalMoratorio] [money] NULL,
		[MoratorioBonificado] [money] NULL,
		[MoratorioXPagar] [money] NULL,
		[IdCargoMoratorioEst] [int] NULL,
		[EstatusCargoMorEst] [varchar](15) NULL,
		[IdCxcMasViejo] [int] NULL,
	 CONSTRAINT [priCobroXPoliticaHistMAVI] PRIMARY KEY CLUSTERED 
(
	[IdCobro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ CondonaMoratoriosMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CondonaMoratoriosMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CondonaMoratoriosMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CondonaMoratoriosMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[CondonaMoratoriosMAVI](
		[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
		[Usuario] [varchar](20) NOT NULL,
		[FechaAutorizacion] [datetime] NOT NULL,
		[IDMov] [int] NOT NULL,
		[RenglonMov] [int] NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovID] [varchar](20) NOT NULL,
		[MontoOriginal] [money] NOT NULL,
		[MontoCondonado] [money] NOT NULL,
		[TipoCondonacion] [varchar](25) NULL,
		[Estatus] [varchar](15) NULL,
		[IdCobro] [int] NULL,
		[AbonoRealM] [money] NULL,
		[Remanente] [money] NULL,
	 CONSTRAINT [priCondonaMoratoriosMAVI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ CondonaMorxSistMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CondonaMorxSistMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CondonaMorxSistMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CondonaMorxSistMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[CondonaMorxSistMAVI](
		[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
		[Usuario] [varchar](20) NOT NULL,
		[FechaAutorizacion] [datetime] NOT NULL,
		[IDMov] [int] NOT NULL,
		[RenglonMov] [int] NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovID] [varchar](20) NOT NULL,
		[MontoOriginal] [money] NOT NULL,
		[MontoCondonado] [money] NOT NULL,
		[TipoCondonacion] [varchar](25) NULL,
		[Estatus] [varchar](15) NULL,
		[IDCobro] [int] NULL,
	 CONSTRAINT [priCondonaMorxSistMAVI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = ON, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ CXCFacturaCteMavi ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CXCFacturaCteMavi')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CXCFacturaCteMavi', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CXCFacturaCteMavi') AND type = 'U') 
	CREATE TABLE [dbo].[CXCFacturaCteMavi](
		[Cliente] [char](10) NOT NULL,
		[Empresa] [char](5) NOT NULL,
		[IdCxC] [int] NOT NULL,
		[IdOrigen] [int] NULL,
		[IdCxCOrigen] [varchar](20) NULL,
		[IdCxCOrigenMov] [varchar](20) NULL,
		[Estacion] [int] NOT NULL
	--) ON [PRIMARY]
	CONSTRAINT [PriCXCFacturaCteMavi] PRIMARY KEY CLUSTERED 
(
	[Cliente] ASC,
	[Empresa] ASC,
	[Estacion] ASC,
	[IdCxC] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])

GO

EXEC spALTER_TABLE 'CXCFacturaCteMavi', 'Articulo', 'varchar(100) NULL'
GO

/************ CxcMavi ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CxcMavi')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CxcMavi', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CxcMavi') AND type = 'U') 
	CREATE TABLE [dbo].[CxcMavi](
		[ID] [int] NOT NULL,
		[MaxDiasVencidosMAVI] [float] NULL,
		[MopAnteriorMAVI] [int] NULL,
		[MopMavi] [int] NULL,
		[MaxDiasInactivosMAVI] [float] NULL,
		[DiasVencActMAVI] [float] NULL,
		[DiasInacActMAVI] [float] NULL,
		[MopActMAVI] [float] NULL,
		[Fecha1erIncumplimiento] [datetime] DEFAULT ('19000101'),--NULL,
		[FechaUltAbono] [datetime] NULL,
	 CONSTRAINT [priCxcMavi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ DetalleAfectacionMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'DetalleAfectacionMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('DetalleAfectacionMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.DetalleAfectacionMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[DetalleAfectacionMAVI](
		[IDCobro] [int] NOT NULL,
		[ID] [int] NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovID] [varchar](20) NULL,
		[ValorOK] [int] NULL,
		[ValorOKRef] [varchar](255) NULL,
	 CONSTRAINT [priDetalleAfectacionMAVI] PRIMARY KEY CLUSTERED 
(
	[IDCobro] ASC,
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ HistCobroMoratoriosMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'HistCobroMoratoriosMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('HistCobroMoratoriosMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.HistCobroMoratoriosMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[HistCobroMoratoriosMAVI](
		[IDCobro] [int] NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovID] [varchar](20) NOT NULL,
		[FEchaCobro] [datetime] NULL,
		[FechaOriginalAnt] [datetime] NULL,
		[InteresMoratoriosAnt] [money] NULL,
	 CONSTRAINT [priHistCobroMoratoriosMAVI] PRIMARY KEY CLUSTERED 
(
	[IDCobro] ASC,
	[Mov] ASC,
	[MovID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ NCargoCCxPadre ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'NCargoCCxPadre')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NCargoCCxPadre', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.NCargoCCxPadre') AND type = 'U') 
	CREATE TABLE [dbo].[NCargoCCxPadre](
		[IDPadre] [int] NOT NULL,
		[IDCobro] [int] NOT NULL,
		[IDNCargo] [int] NOT NULL,
		[FechaEmision] [datetime] NOT NULL,
		[ImporteNCargo] [float] NOT NULL,
		[EstatusNcargo] [varchar](10) NOT NULL
	) ON [PRIMARY]
GO


/************ NegociaMoratoriosMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'NegociaMoratoriosMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NegociaMoratoriosMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.NegociaMoratoriosMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[NegociaMoratoriosMAVI](
		[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
		[IDCobro] [int] NOT NULL,
		[Estacion] [int] NOT NULL,
		[Usuario] [varchar](20) NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovID] [varchar](20) NOT NULL,
		[ImporteReal] [money] NOT NULL,
		[ImporteAPagar] [money] NOT NULL,
		[ImporteMoratorio] [money] NOT NULL,
		[ImporteACondonar] [money] NOT NULL,
		[Condonado] [char](1) NULL,
		[UsuarioCondona] [varchar](10) NULL,
		[MoratorioAPagar] [money] NULL,
		[Origen] [varchar](20) NULL,
		[OrigenId] [varchar](20) NULL,
		[NotaCargoMorId] [int] NULL,
		[AbonoRealM] [money] NULL,
		[Remanente] [money] NULL,
		[Bonificacion] [money] NULL,
		[TotalAPagar] [money] NULL,
		[PagoPuntual] [money] NULL,
		[AdelantoPagos] [money] NULL,
		[NoAtraso] [money] NULL,
		[ContadoComercial] [money] NULL,
		[TipoPago] [char](1) NULL,
		[IDPagoPuntual] [int] NULL,
		[IDAdelantoPagos] [int] NULL,
		[IDNoAtraso] [int] NULL,
		[IDContadoComercial] [int] NULL,
		[NotaCredBonId] [int] NULL,
		[NotaCreditoxCanc] [CHAR] (1) NULL,
		[InteresPorPolitica] [money] DEFAULT 0,
		[InteresAPagarConPolitica] [money] DEFAULT 0,
	--) ON [PRIMARY]
	CONSTRAINT [priNegociaMoratoriosMAVI] PRIMARY KEY CLUSTERED 
(
	[IDCobro] ASC,
	[ID] ASC,
	[Estacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 
ON [PRIMARY])
GO


/************ RecuperacionCredilanasPPMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'RecuperacionCredilanasPPMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RecuperacionCredilanasPPMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.RecuperacionCredilanasPPMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[RecuperacionCredilanasPPMAVI](
		[Renglon] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
		[ID] [int] NOT NULL,
		[FechaEmision] [datetime] NULL,
		[Vencimiento] [datetime] NULL,
		[Periodo] [int] NOT NULL,
		[Ejercicio] [int] NOT NULL,
		[PorcentajeCapital] [float] NULL,
		[PorcentajeFinanciamiento] [float] NULL,
		[Cobros] [money] NULL,
		[PagoFinanciamiento] [money] NULL,
		[Exigible] [money] NULL,
		[Anterior] [money] NULL,
		[ExigiblePagado] [money] NULL,
		[Adelantado] [money] NULL,
		[Ordinario] [bit] NOT NULL,
		[Cobertura] [money] NULL,
		[Arrastre] [money] NULL,
		[Creditos] [money] NULL,
	 CONSTRAINT [priRecuperacionCredilanasPPMAVI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[Periodo] ASC,
	[Ejercicio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/************ TipoCobroMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'TipoCobroMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TipoCobroMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.TipoCobroMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[TipoCobroMAVI](
		[IdCobro] [int] NOT NULL,
		[TipoCobro] [int] NULL,
	 CONSTRAINT [priTipoCobroMAVI] PRIMARY KEY CLUSTERED 
(
	[IdCobro] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ MaviBonificacionTest ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MaviBonificacionTest')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MaviBonificacionTest', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.MaviBonificacionTest') AND type = 'U') 
	CREATE TABLE [dbo].[MaviBonificacionTest](
		[Docto] [int] NOT NULL,
		[IdBonificacion] [int] NOT NULL,
		[Bonificacion] [varchar](50) NOT NULL,
		[Estacion] [int] NOT NULL,
		[Mov] [varchar](20) NOT NULL,
		[MovId] [varchar](20) NOT NULL,
		[Origen] [varchar](20) NOT NULL,
		[OrigenId] [varchar](20) NOT NULL,
		[ImporteVenta] [float] NOT NULL,
		[ImporteDocto] [float] NOT NULL,
		[PorcBon1] [float] NOT NULL,
		[MontoBonif] [float] NOT NULL,
		[Financiamiento] [float] NOT NULL,
		[Factor] [float] NOT NULL,
		[PlazoEjeFin] [int] NOT NULL,
		[Documento1de] [int] NOT NULL,
		[DocumentoTotal] [int] NOT NULL,
		[Sucursal1] [int] NOT NULL,
		[TipoSucursal] [varchar](50) NOT NULL,
		[LineaVta] [varchar](50) NOT NULL,
		[DiasMenoresA] [int] NOT NULL,
		[DiasMayoresA] [int] NOT NULL,
		[IdVenta] [int] NOT NULL,
		[UEN] [int] NOT NULL,
		[Condicion] [varchar](50) NOT NULL,
		[Ok] [int] NOT NULL,
		[OkRef] [varchar](50) NOT NULL,
		[FechaEmision] [datetime] NOT NULL,
		[Vencimiento] [datetime] NOT NULL,
		[IdCobro] [int] NOT NULL,
		[LineaCelulares] [float] NOT NULL,
		[LineaCredilanas] [float] NOT NULL,
		[BaseParaAPlicar] [float] NOT NULL
	) ON [PRIMARY]
GO


/************ MaviBonificacionMoV ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MaviBonificacionMoV')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MaviBonificacionMoV', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.MaviBonificacionMoV') AND type = 'U') 
	CREATE TABLE [dbo].[MaviBonificacionMoV](
	 [IdBonificacion] [int] NOT NULL,
	 [Movimiento] [varchar](20) NOT NULL,
	 CONSTRAINT [priMaviBonificacionMoV] PRIMARY KEY CLUSTERED 
(
 [IdBonificacion] ASC,
 [Movimiento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ VentasCanalMAVI ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'VentasCanalMAVI')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentasCanalMAVI', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.VentasCanalMAVI') AND type = 'U') 
	CREATE TABLE [dbo].[VentasCanalMAVI](
	 [ID] [int] NOT NULL,
	 [Clave] [varchar](10) NOT NULL,
	 [Cadena] [varchar](50) NOT NULL,
	 [Categoria] [varchar](50) NOT NULL,
	 [UEN] [int] NULL,
	 [RecibeLayout] [bit] DEFAULT 0, -- WITH VALUES,
	 [PorRFCNomina] [varchar](1) NULL,
	 [GeneraCargoxMoratorio] [bit] DEFAULT 0, -- WITH VALUES,
	 [SeEnviaBuroCreditoMavi] [bit] NULL,
	 [MaviTipoControlInst] [varchar](15) NULL,
	 [MaviPeriodoInst] [varchar](15) NULL,
	 [MaviNomRep] [varchar](20) NULL,
	 [RutaCobUnicaja] [varchar](4) NULL,
	 [NombreMacro] [varchar](50) NULL
	CONSTRAINT [priVentasCanalMAVI] PRIMARY KEY CLUSTERED 
(
 [ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY])
GO


/************ MaviMovimientosFlujo ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MaviMovimientosFlujo')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MaviMovimientosFlujo', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.MaviMovimientosFlujo') AND type = 'U') 
	CREATE TABLE [dbo].[MaviMovimientosFlujo](
	 [ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	 [Padre] [int] NOT NULL,
	 [Mov] [varchar](20) NULL,
	 [Hijo] [int] NULL,
	 [Flujo] [varchar](50) NULL,
	 [UEN] [int] NULL,
	 CONSTRAINT [priMaviMovimientosFlujo] PRIMARY KEY CLUSTERED 
(
 [ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/************ MaviMovimientosFlujo ************/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'CXCDNC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CXCDNC', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.CXCDNC') AND type = 'U') 
	CREATE TABLE [dbo].[CXCDNC](
	 [ID] [int] NULL,
	 [Renglon] [int] NULL,
	 [Aplica] [varchar](20) NULL,
	 [AplicaID] [varchar](20) NULL
	) ON [PRIMARY]
GO


/************************ tgCXCFacturaCteMaviA ***************************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'tgCXCFacturaCteMaviA') DROP TRIGGER tgCXCFacturaCteMaviA
GO
CREATE TRIGGER dbo.tgCXCFacturaCteMaviA ON CXCFacturaCteMavi
FOR INSERT
AS
BEGIN
	DECLARE
	@Empresa                  varchar(5),
	@Cliente                  char(10),
	@Estacion	                int,
	@IDOrigen                 int,
	@IDCxc                    int,
	@IDBonifSI                int,
	@Modulo                   varchar(5),
	@Articulo                 varchar(100)
  
	SELECT @Estacion = Estacion, @Empresa = Empresa, @Cliente = Cliente, @IDOrigen = IdOrigen, @IDCxc = inserted.IdOrigen, @IDBonifSI = bs.IDCxc, @Modulo = 'CXC'
	FROM
		inserted
		LEFT OUTER JOIN BonifSIMavi bs ON bs.IdCxC = inserted.IdOrigen

	IF (SELECT ISNULL(POS,0) FROM EmpresaGral WHERE Empresa = @Empresa) = 1
		BEGIN  
		  IF @IDBonifSI IS NULL
		  BEGIN
  			EXEC spVerMovFlujo @Estacion, @Empresa, @Modulo, @IDOrigen
  	
  			SELECT @IDOrigen = vmf.ModuloID
				FROM 
					VerMovFlujo vmf 
					JOIN MovTipo mt ON mt.Modulo = vmf.Modulo AND mt.Mov = vmf.Mov
				WHERE vmf.Estacion = @Estacion AND 
					mt.Clave IN ('VTAS.F')
			
				SELECT TOP 1 @Articulo = a.Descripcion1
				FROM 
					Venta v
					JOIN VentaD vd ON vd.ID = v.ID
					LEFT OUTER JOIN Art a ON a.Articulo = vd.Articulo
				WHERE v.ID = @IDOrigen
				ORDER BY vd.Renglon
			
		  END
		  ELSE
  
			SELECT @Articulo = Articulo FROM BonifSIMavi bs WHERE bs.IDCxc = @IDCxc
  
		  UPDATE CXCFacturaCteMavi
			SET Articulo = @Articulo
			WHERE  Cliente = @Cliente AND
				Empresa = @Empresa
				AND IdOrigen = @IDCxc
				AND Estacion = @Estacion
		END
END
GO


/************************ tgDocumentoCxcMAVI ***************************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'tgDocumentoCxcMAVI') DROP TRIGGER tgDocumentoCxcMAVI
GO
CREATE TRIGGER tgDocumentoCxcMAVI ON Cxc
FOR INSERT      
AS BEGIN      
	DECLARE      
    @Proveedor      varchar(10),          
    @Mensaje        varchar(100),      
	@Mov   char(20),      
	@ID    int,      
	@RenglonID  int,      
	@FechaEmision  datetime,      
	@Clave   char(20),      
    @Origen   varchar(20),      
    @OrigenID  varchar(20),      
    @FechaOriginal datetime,      
    @Remanente  money,
    @Empresa	varchar(5)      
        
    SELECT @ID = ID      
    FROM Inserted      
          
    SELECT @Clave = MovTipo.Clave ,      
           @Mov = Cxc.Mov,      
           @FechaEmision = Cxc.Vencimiento,
           @Empresa = Cxc.Empresa       
    FROM Cxc      
    JOIN MovTipo ON MovTipo.Mov = Cxc.Mov 
	AND MovTipo.Modulo = 'CXC'      
    WHERE Cxc.ID = @ID      

	IF (SELECT ISNULL(POS,0) FROM EmpresaGral WHERE Empresa = @Empresa) = 1
		BEGIN
			IF @Clave in ( 'CXC.D','CXC.F','CXC.CA' ) -- select * from MovTipo Where Modulo = 'CXC'      
			  UPDATE CXC      
				 SET FechaOriginal = @FechaEmision,      
					 FechaOriginalAnt = @FechaEmision,      
					 ReferenciaMAVI = Referencia       
			   WHERE ID = @ID                
              
			IF @Mov like  '%Contra Recibo%'      
				BEGIN      
					SELECT @Origen = Origen, @OrigenID = Origenid FROM CXC WHERE ID = @ID      
					SELECT @FechaOriginal = FechaOriginal, @Remanente = InteresesMoratoriosMAVI FROM CXC WHERE Mov = @Origen AND MovId = @OrigenID      
      
					UPDATE CXC       
					SET FechaOriginal = @FechaOriginal,      
					InteresesMoratoriosMAVI = @Remanente      
					WHERE ID = @ID           
				END
		END         
	RETURN      
END    
GO


/************************ trCxcCteUltCobroMAVI ***************************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'trCxcCteUltCobroMAVI') DROP TRIGGER trCxcCteUltCobroMAVI
GO
CREATE TRIGGER trCxcCteUltCobroMAVI ON Cxc
FOR UPDATE
AS
BEGIN  -- 1
	DECLARE @ID						int,
		@Clave						varchar(20),
		@Mov						varchar(20),
        @MovID						varchar(20),
		@Cliente					varchar(10),	
		@FechaActual				datetime,
		@Empresa					varchar(5),
		@Estatus					varchar(15),
		@Usuario					varchar(10),
		@MovimientoUltimoCobroAux	varchar(50),
		@MovimientoUltimoCobro		varchar(50),	
		@FechaUltimoCobroAux		datetime
			    
    IF UPDATE(Estatus)
    BEGIN 
     
		SELECT @ID = ID,@Estatus = Estatus,@Mov = Mov,@MovID = MovID,@Usuario = Usuario,@Empresa = Empresa,@Cliente = Cliente
			FROM Inserted

		IF (SELECT ISNULL(POS,0) FROM EmpresaGral WHERE Empresa = @Empresa) = 1
			BEGIN

				SELECT @Clave = Clave FROM MovTipo WHERE Modulo = 'Cxc' AND Mov = @Mov	
				SET @FechaActual = dbo.fnFechaSinHora(GETDATE()) 

				IF @Clave in ('CXC.C','CXC.DC','CXC.NC') AND @Estatus = 'CONCLUIDO'
				BEGIN  
					SELECT @MovimientoUltimoCobro = ISNULL(MovimientoUltimoCobro,'')
						FROM Cte WHERE Cliente = @Cliente

					IF @MovimientoUltimoCobro <> ''
						BEGIN
							SELECT @MovimientoUltimoCobroAux = MovimientoUltimoCobro,
								   @FechaUltimoCobroAux = FechaUltimoCobro
								FROM Cte WHERE Cliente = @Cliente

							UPDATE Cte
								SET FechaUltimoCobro = @FechaActual,
									MovimientoUltimoCobro = @Mov + '-' + @MovID,
									FechaUltimoCobroAux = @FechaUltimoCobroAux,
									MovimientoUltimoCobroAux = @MovimientoUltimoCobroAux
							  WHERE Cliente = @Cliente								
						END
						ELSE
							UPDATE Cte
								SET FechaUltimoCobro = @FechaActual,
									MovimientoUltimoCobro = @Mov + '-' + @MovID,
									FechaUltimoCobroAux = @FechaActual,
									MovimientoUltimoCobroAux = @Mov + '-' + @MovID
							  WHERE Cliente = @Cliente				
						END 
		
					IF @Clave = 'CXC.C' AND @Estatus = 'CANCELADO'  
						BEGIN  
							SELECT @MovimientoUltimoCobroAux = MovimientoUltimoCobroAux,
								   @FechaUltimoCobroAux = FechaUltimoCobroAux
								FROM Cte WHERE Cliente = @Cliente

							UPDATE Cte
								SET FechaUltimoCobro = @FechaUltimoCobroAux,
									MovimientoUltimoCobro = @MovimientoUltimoCobroAux
							  WHERE Cliente = @Cliente

						END 
				END  
			END
END
GO


/*************************************** SerieTarjetaMov *****************************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.SerieTarjetaMov') and type = 'U')
	CREATE TABLE SerieTarjetaMov(
		Empresa				varchar(5) NOT NULL,
		Modulo				varchar(5) NOT NULL,
		ID					varchar(36) NOT NULL,
		Serie				varchar(20) NOT NULL,
		Importe				money NULL,
		Sucursal			int NOT NULL DEFAULT 0,
		Devolucion			bit NULL DEFAULT 0,
		DevolucionPuntos	bit NULL DEFAULT 0,
	CONSTRAINT priSerieTarjetaMov PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, Serie)
)
GO


/*************************** CxcAplica ***************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CxcAplica') and type = 'V') DROP VIEW dbo.CxcAplica
GO
CREATE VIEW CxcAplica
--//WITH ENCRYPTION
AS 
	SELECT 
	  Cxc.ID,
	  Cxc.Empresa, 
	  Cxc.Mov, 
	  Cxc.MovID, 
	  Cxc.Cliente,
	  Cxc.ClienteEnviarA,
	  "Moneda" = Cxc.ClienteMoneda,
	  "TipoCambio" = Cxc.ClienteTipoCambio,
	  Cxc.FechaEmision, 
	  Cxc.Vencimiento, 
	  "DiasCredito" = DATEDIFF(day, FechaEmision, Vencimiento),
	  Cxc.Importe,
	  Cxc.Impuestos,
	  "ImporteTotal" = ISNULL(Cxc.Importe, 0.0) + ISNULL(Cxc.Impuestos,0.0) - ISNULL(Cxc.Retencion, 0.0) - ISNULL(Cxc.Retencion2, 0.0) - ISNULL(Cxc.Retencion3, 0.0),
	  Cxc.Saldo,
	  Cxc.Referencia,
	  Cxc.Concepto,
	  Cxc.Estatus,
	  "DiasMoratorios"  = datediff(day, Cxc.Vencimiento, GETDATE()),
	  "FechaProntoPago" = Cxc.FechaProntoPago,
	  Cxc.DescuentoProntoPago,
	  "ProntoPago" = CASE WHEN Cte.DescuentoRecargos = 1 AND Cfg.CxcDescContado = 1 AND GETDATE()<DATEADD(day, cfg.CxcDescContadoDias, Cxc.FechaEmision) THEN Cxc.Saldo*cfg.CxcDescContadoPorcentaje/100 ELSE CONVERT(money, CASE WHEN GETDATE()<DATEADD(day, 1, Cxc.FechaProntoPago) THEN (ISNULL(Cxc.Importe, 0)+ISNULL(Cxc.Impuestos,0))*(Cxc.DescuentoProntoPago/100) END) END,
	  Cxc.IVAFiscal,
	  Cxc.IEPSFiscal,
	  Cxc.Retencion,
	  Cxc.Retencion2,
	  Cxc.Retencion3,      
	  Cxc.Situacion,
	  Cxc.SituacionFecha,
	  Cxc.SituacionUsuario,
	  Cxc.SituacionNota,
	  Cxc.Sucursal,
	  Cxc.OrigenTipo,
	  Cxc.Origen,
	  Cxc.OrigenID,
	  Cxc.Proyecto,
	  Cxc.UEN,
	  Cxc.LineaCredito,
	  Cxc.TipoAmortizacion,
	  Cxc.TipoTasa,
	  Cxc.TasaDiaria,
	  Cxc.Amortizaciones,
	  Cxc.InteresesOrdinarios,
	  Cxc.InteresesFijos,
	  Cxc.InteresesMoratorios,
	  Cxc.SaldoInteresesOrdinarios,
	  Cxc.SaldoInteresesOrdinariosIVA, --MEJORA10041  
	  Cxc.SaldoInteresesMoratorios,
	  Cxc.SaldoInteresesMoratoriosIVA, --MEJORA10041  
	  "SaldoTotal" = ISNULL(Saldo, 0.0)+ISNULL(SaldoInteresesOrdinarios, 0.0)+ISNULL(SaldoInteresesOrdinariosIVA, 0.0)+ISNULL(SaldoInteresesMoratorios, 0.0)+ISNULL(SaldoInteresesMoratoriosIVA, 0.0), --MEJORA10041
	  "MovMoneda" = Moneda,
	  "MovTipoCambio" = TipoCambio,
	  Cxc.RamaID,
	  Cxc.PadreMAVI, 
	  Cxc.PadreIDMAVI
	FROM Cxc
	JOIN Cte ON Cte.Cliente = Cxc.Cliente
	JOIN EmpresaCfg Cfg ON Cfg.Empresa = Cxc.Empresa
	WHERE  UPPER(Cxc.Estatus) NOT IN ('SINAFECTAR', 'CANCELADO')
GO


/**************************** CxcPendiente *****************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CxcPendiente') and type = 'V') DROP VIEW dbo.CxcPendiente
GO
CREATE VIEW CxcPendiente
--//WITH ENCRYPTION
AS 
	SELECT *
	FROM CxcAplica
	WHERE UPPER(Estatus) = 'PENDIENTE'
GO

/****** POSTipoComisiones ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSTipoComisiones')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSTipoComisiones', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSTipoComisiones') AND type = 'U') 
	CREATE TABLE POSTipoComisiones(
		IdTipoComision		INT	NOT NULL,
		TipoComision		VARCHAR(50) NOT NULL,
		CONSTRAINT priPOSTipoComision PRIMARY KEY CLUSTERED (IdTipoComision) 
	)

IF NOT EXISTS (SELECT * FROM POSTipoComisiones)
BEGIN
	INSERT POSTipoComisiones VALUES (1, 'Directa')
	INSERT POSTipoComisiones VALUES (2, 'Indirecta')
END
GO

/****** POSTipoCobroComisiones ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSTipoCobroComisiones')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSTipoCobroComisiones', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSTipoCobroComisiones') AND type = 'U') 
	CREATE TABLE POSTipoCobroComisiones(
		IdTipoCobroComision		INT			NOT NULL,
		TipoCobroComision		VARCHAR(50) NOT NULL, 
		CONSTRAINT priPOSTipoCobroComision PRIMARY KEY CLUSTERED (IdTipoCobroComision) 
	)

IF NOT EXISTS (SELECT * FROM POSTipoCobroComisiones)
BEGIN
	INSERT POSTipoCobroComisiones VALUES (1, 'Porcentaje sobre el pago')
	INSERT POSTipoCobroComisiones VALUES (2, 'Importe fijo')
END
GO

/****** POSComisiones ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSComisiones')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSComisiones', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSComisiones') AND type = 'U') 
	CREATE TABLE POSComisiones(
		IdComision				INT			IDENTITY(1,1),
		Servicio				VARCHAR(20)	NOT NULL,
		IdTipoComision			INT			NOT NULL,
		IdTipoCobroComision		INT			NOT NULL,
		Valor					FLOAT		NOT NULL,
		Genera					VARCHAR(5)	NOT NULL,
		Proveedor				VARCHAR(10)	NULL,
		Cliente					VARCHAR(10)	NULL,
		Concepto				VARCHAR(50)	NOT NULL,
		CONSTRAINT priPOSComisiones PRIMARY KEY CLUSTERED (IdComision)
	)
GO

/****** POSFormaEnvioTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSFormaEnvioTemp')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSFormaEnvioTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSFormaEnvioTemp') AND type = 'U') 
  CREATE TABLE dbo.POSFormaEnvioTemp (
        Orden                   int          NULL,
        Estacion                int          NOT NULL,
        FormaEnvio              varchar(50)  NOT NULL,        
  CONSTRAINT priPOSFormaEnvioTemp PRIMARY KEY CLUSTERED (Estacion,FormaEnvio)
  )
GO

/****** POSCteFacCred ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'POSCteFacCred')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('POSCteFacCred', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.POSCteFacCred') AND type = 'U') 
  CREATE TABLE dbo.POSCteFacCred (
        Cliente			varchar(10)	NOT NULL,        
  CONSTRAINT priPOSCteFacCred PRIMARY KEY CLUSTERED (Cliente)
  )
GO