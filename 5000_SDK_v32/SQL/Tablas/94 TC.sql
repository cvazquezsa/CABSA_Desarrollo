--REQ13163
/***************** TCCfg *****************/
if not exists (select * from SysTabla where SysTabla = 'TCCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCCfg','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCCfg' AND Type = 'u')
  CREATE TABLE TCCfg(
    Empresa						varchar(5)	NOT NULL, 
    ProcesadorTrans				varchar(15) NULL,
    InstitucionAdquiriente		varchar(20) NULL,
    InstitucionAdquirienteAMEX	varchar(20) NULL,
	ConexionExplicita			bit			NOT NULL DEFAULT 0,

	CONSTRAINT priTCCfg PRIMARY KEY CLUSTERED(Empresa)
  )
GO

--REQ13163
EXEC spALTER_TABLE 'TCCfg', 'NivelCfg', 'varchar(20) NOT NULL DEFAULT ''Empresa'' WITH VALUES'
EXEC spALTER_TABLE 'TCCfg', 'Servidor', 'varchar(255) NULL'
EXEC spALTER_TABLE 'TCCfg', 'BaseDatos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'TCCfg', 'Usuario', 'varchar(255) NULL'
EXEC spALTER_TABLE 'TCCfg', 'Contrasena', 'varchar(255) NULL'
EXEC spALTER_TABLE 'TCCfg', 'Ubicacion', 'varchar(255) NULL'
GO
EXEC spALTER_TABLE 'TCCfg', 'RutaArchivosXML', 'varchar(255) NULL'
GO
EXEC spDROP_COLUMN 'TCCfg', 'Servidor', 'varchar(255) NULL'
EXEC spDROP_COLUMN 'TCCfg', 'BaseDatos', 'varchar(255) NULL'
EXEC spDROP_COLUMN 'TCCfg', 'Usuario', 'varchar(255) NULL'
EXEC spDROP_COLUMN 'TCCfg', 'Contrasena', 'varchar(255) NULL'
GO

EXEC spALTER_TABLE 'TCCfg', 'CxcMovAnticipo', 'varchar(20) NOT NULL DEFAULT ''Cobro Tarjeta'' WITH VALUES'
GO
EXEC spALTER_TABLE 'TCCfg', 'CxcMovDevolucion', 'varchar(20) NOT NULL DEFAULT ''Devolucion Tarjeta'' WITH VALUES'
GO
EXEC spALTER_TABLE 'TCCfg', 'NivelCfgPinPad', 'varchar(10) NOT NULL DEFAULT ''Usuario'' WITH VALUES'
GO

--REQ13163
/***************** TCTerminalCfg *****************/
if not exists (select * from SysTabla where SysTabla = 'TCTerminalCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCTerminalCfg','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCTerminalCfg' AND Type = 'u')
  CREATE TABLE TCTerminalCfg(
    Empresa				varchar(5)	NOT NULL,
    Sucursal			int			NOT NULL,  
    Estacion			int			NOT NULL,
    TerminalEquiv		varchar(20) NULL,
    Pinpad				varchar(3)	NOT NULL,
    Puerto				varchar(5)	NOT NULL,
    Estatus				varchar(10) NOT NULL DEFAULT 'ALTA'
    CONSTRAINT priTCTerminalCfg PRIMARY KEY CLUSTERED(Empresa, Sucursal, Estacion)
    )
GO

EXEC spDROP_PK 'TCTerminalCfg'
GO
EXEC spDROP_COLUMN 'TCTerminalCfg', 'Estacion'
GO
EXEC spALTER_TABLE 'TCTerminalCfg', 'CtaDinero', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'TCTerminalCfg', 'Agente', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'TCTerminalCfg', 'RID', 'int IDENTITY'
GO
EXEC spADD_PK 'TCTerminalCfg', 'RID'
GO
EXEC spDROP_COLUMN 'TCTerminalCfg', 'Estatus'
GO


--REQ13163
/***************** TCSucursalCfg *****************/
if not exists (select * from SysTabla where SysTabla = 'TCSucursalCfg') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCSucursalCfg','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCSucursalCfg' AND Type = 'u')
  CREATE TABLE TCSucursalCfg(
    Empresa					varchar(5)	NOT NULL,
    Sucursal				int			NOT NULL,
    ProcesadorTrans			varchar(15)	NULL,	
    InstitucionAdquiriente	varchar(10)	NULL,
    Afiliacion				varchar(15)	NOT NULL,
    Estatus					varchar(10) NOT NULL DEFAULT 'ALTA'

    CONSTRAINT priTCSucursalCfg PRIMARY KEY CLUSTERED(Empresa, Sucursal)
    )
GO

--REQ13163
EXEC spALTER_TABLE 'TCSucursalCfg', 'InstitucionAdquirienteAMEX', 'varchar(20) NULL'
GO
--REQ13163
EXEC spALTER_TABLE 'TCSucursalCfg', 'Usuario', 'varchar(10) NULL'
GO
--REQ13163
EXEC spALTER_TABLE 'TCSucursalCfg', 'Contrasena', 'varchar(32) NULL'
GO
--REQ13163
EXEC spALTER_TABLE 'TCSucursalCfg', 'ModoOperacion', 'varchar(30) NULL'
GO

--REQ13163
/***************** TCProcesadorTrans *****************/
if not exists (select * from SysTabla where SysTabla = 'TCProcesadorTrans') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCProcesadorTrans','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCProcesadorTrans' AND Type = 'u')
  CREATE TABLE TCProcesadorTrans(
    ProcesadorTrans			varchar(15),
    CONSTRAINT priTCProcesadorTrans PRIMARY KEY CLUSTERED(ProcesadorTrans)
  )
GO

--REQ13163
EXEC spALTER_TABLE 'TCProcesadorTrans', 'TerminalEquiv', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--REQ13163
/***************** TCPinPad *****************/
if not exists (select * from SysTabla where SysTabla = 'TCPinPad') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCPinPad','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCPinPad' AND Type = 'u')
  CREATE TABLE TCPinPad(
    Pinpad				varchar(3)	NOT NULL,
    Modelo				varchar(15) NOT NULL,
    Fabricante			varchar(50) NULL,
    Velocidad			int			NOT NULL DEFAULT 19200,
    BitsDatos			int			NOT NULL DEFAULT 8,
    Paridad				varchar(7)	NOT NULL DEFAULT 'N',
    BitsParada			int			NOT NULL DEFAULT 1,
    CtrlFlujo			int			NOT NULL DEFAULT 0,
    Estatus				varchar(10) NOT NULL DEFAULT 'ALTA'
    CONSTRAINT priPinPad PRIMARY KEY CLUSTERED(Pinpad)
  )
GO

--REQ13163
/***************** TCHashTableDefinicion *****************/
if not exists (select * from SysTabla where SysTabla = 'TCHashTableDefinicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCHashTableDefinicion','Maestro')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCHashTableDefinicion' AND Type = 'u')
  CREATE TABLE TCHashTableDefinicion(
    ProcesadorTrans			varchar(15),
    Campo					varchar(50),
    Columna					varchar(50),
    CONSTRAINT priTCHashTableDefinicion PRIMARY KEY CLUSTERED(ProcesadorTrans, Campo)
    )
GO

--REQ13163
/***************** TCHashTableTransaccion *****************/
if not exists (select * from SysTabla where SysTabla = 'TCHashTableTransaccion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCHashTableTransaccion','Movimiento')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCHashTableTransaccion' AND Type = 'u')
  CREATE TABLE TCHashTableTransaccion(
	RID				int				IDENTITY,
    Estacion		int,
    Modulo			varchar(5),
    ModuloID		int,
    FormaPago		varchar(50),
    Importe			float,
    Columna			varchar(50)		NULL,
    Valor			varchar(255)	NULL,
    CONSTRAINT priTCHashTableTransaccion PRIMARY KEY CLUSTERED(RID)
	)
GO

--REQ13163
/***************** TCEstacionTransaccion *****************/
if not exists (select * from SysTabla where SysTabla = 'TCEstacionTransaccion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCEstacionTransaccion','Movimiento')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCEstacionTransaccion' AND Type = 'u')
  CREATE TABLE TCEstacionTransaccion(
    Empresa			varchar(5),
    Sucursal		int,
    Estacion		int,  
	RID				int		NULL,
	CONSTRAINT priTCEstacionTransaccion PRIMARY KEY CLUSTERED(Estacion, Sucursal, Empresa)
	)
GO

--REQ13163
/***************** TCDevolucion *****************/
if not exists (select * from SysTabla where SysTabla = 'TCDevolucion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCDevolucion','Movimiento')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCDevolucion' AND Type = 'u')
  CREATE TABLE TCDevolucion(
	RID					int			IDENTITY,
	Estacion			int,
    IDTransaccion		int			NOT NULL,
    Modulo				varchar(5)	NOT NULL,
    ModuloID			int			NOT NULL,
    IDOrden				varchar(255)NULL,
    Importe				float		NULL,
    CONSTRAINT priTCDevolucion PRIMARY KEY CLUSTERED(RID)
    )
GO

--REQ13163
/***************** TCTransaccion *****************/
if not exists (select * from SysTabla where SysTabla = 'TCTransaccion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TCTransaccion','Movimiento')
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Name='TCTransaccion' AND Type = 'u')
  CREATE TABLE TCTransaccion(
    RID					int			 IDENTITY,
    Modulo				varchar(5)	 NOT NULL,
    ModuloID			int			 NOT NULL,
    FormaPago			varchar(50)  NOT NULL,
    Campo				varchar(50)  NOT NULL,
    Importe				float		 NOT NULL,
    Accion				varchar(20)	 NOT NULL,
    ARQC				varchar(255) NULL,
    BancoEmisor			varchar(255) NULL,
    CodigoAutorizacion	varchar(255) NULL,
    CodigoError			varchar(255) NULL,
    CodigoProcesador	varchar(255) NULL,
    E1					varchar(255) NULL,
    E2					varchar(255) NULL,
    E3					varchar(255) NULL,
    Estatus				varchar(255) NULL,
    FechaExpiracion		varchar(5)	 NULL,
    FechaFin			datetime	 NULL,
    FechaInicio			datetime	 NULL,
    IDOrden				varchar(255) NULL,
    MensajeError		varchar(255) NULL,
    MensajeProcesador	varchar(255) NULL,
    NumeroTarjeta		varchar(255) NULL,
    SeveridadError		varchar(255) NULL,
    Tarjetahabiente		varchar(255) NULL,
    Texto				varchar(255) NULL,
    TipoOperacion		varchar(255) NULL,
    TipoTarjeta			varchar(255) NULL,
    TipoTransaccion		varchar(255) NULL,
    Total				float		 NULL,
    Track1				varchar(255) NULL,
    Track2				varchar(255) NULL,
    
    CONSTRAINT priTCTransaccion PRIMARY KEY CLUSTERED(RID)
    )
GO

--REQ13163
EXEC spADD_INDEX 'TCTransaccion', 'ModuloID', 'ModuloID, Modulo'
GO
--REQ13163
EXEC spALTER_TABLE 'TCTransaccion', 'Ok', 'int NULL'
EXEC spALTER_TABLE 'TCTransaccion', 'OkRef', 'varchar(255) NULL'
GO
--REQ13163
EXEC spALTER_TABLE 'TCTransaccion', 'TCTipoPlan', 'varchar(20) NULL'
EXEC spALTER_TABLE 'TCTransaccion', 'TCNoMeses', 'int NULL'
EXEC spALTER_TABLE 'TCTransaccion', 'TCDiferirMeses', 'int NULL'
EXEC spALTER_TABLE 'TCTransaccion', 'CxcID', 'int NULL'
GO
