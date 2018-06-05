/*************************** MovExportacionDatos **************************/
if not exists (select * from SysTabla where SysTabla = 'MovExportacionDatos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovExportacionDatos','Movimiento') 
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovExportacionDatos','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovExportacionDatos') and type = 'U') 
CREATE TABLE MovExportacionDatos
    (
	Estacion			int				NOT NULL,
	Modulo				varchar(5)		NOT NULL,
	ModuloID			int				NOT NULL,
	RID					int				identity(1,1),
	OrdenExportacion	varchar(255)	NULL,
	Documento			text			NULL,
	
	CONSTRAINT priMovExportacionDatos PRIMARY KEY  CLUSTERED (Estacion, Modulo, ModuloID, RID)
	)
GO

/*************************** MovXML **************************/
if not exists (select * from SysTabla where SysTabla = 'MovXML')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovXML','Movimiento') 
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovXML','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovXML') and type = 'U')
CREATE TABLE MovXML
    (
	Modulo				varchar(5)		NOT NULL,
	ModuloID			int			NOT NULL,
	DocumentoTexto		text				NOT NULL,
	DocumentoXML		xml				NULL,
	DocumentoXSD		varchar(MAX)			NULL,
	DocumentoXSL		varchar(MAX)			NULL,
	
	CONSTRAINT priMovXML PRIMARY KEY  CLUSTERED (Modulo, ModuloID)
	)
GO


/*************************** MovExportacion **************************/
if not exists (select * from SysTabla where SysTabla = 'MovExportacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovExportacion','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovExportacion') and type = 'U')
CREATE TABLE MovExportacion
        (
	Modulo		varchar(5)   NOT NULL,
	Mov		varchar(20)  NOT NULL,
        Exportacion	varchar(50)  NOT NULL,

	Documento	varchar(MAX) NULL,
	Codificacion	varchar(20)  NULL,
	DocumentoXSD	varchar(MAX) NULL,
	DocumentoXSL	varchar(MAX) NULL,

	CONSTRAINT priMovExportacion PRIMARY KEY CLUSTERED (Modulo, Mov, Exportacion)
	)
GO

EXEC spALTER_TABLE 'MovExportacion', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'MovExportacion', 'Mov', 'varchar(20) NULL'
GO

/*************************** MovExportacionD **************************/
if not exists (select * from SysTabla where SysTabla = 'MovExportacionD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovExportacionD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovExportacionD') and type = 'U')
CREATE TABLE MovExportacionD
        (
	Modulo				varchar(5) NOT NULL,
	Mov				varchar(20) NOT NULL,
        Exportacion			varchar(50)  NOT NULL,
	RID				int IDENTITY(1,1) NOT NULL,

	Orden				int NULL,
	Seccion				varchar(50) NULL,
	SubSeccionDe			varchar(50) NULL,
	Vista				varchar(100) NULL,
	ExpresionFinal			varchar(MAX) NULL,
	Cierre				bit NULL,
	
	CONSTRAINT priMovExportacionD PRIMARY KEY  CLUSTERED (Modulo, Mov, Exportacion, RID)
	)
GO

EXEC spALTER_TABLE 'MovExportacionD', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'MovExportacionD', 'Mov', 'varchar(20) NULL'
GO

--exec spFK 'MovExportacionD','Exportacion','MovExportacion','Exportacion'
--GO


/*************************** TablaParseoD **************************/
if not exists (select * from SysTabla where SysTabla = 'TablaParseoD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaParseoD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.TablaParseoD') and type = 'U')
CREATE TABLE TablaParseoD
        (
	Modulo			varchar(5) NOT NULL,
	Mov			varchar(20) NOT NULL,
        Exportacion		varchar(50)  NOT NULL,
	IDSeccion		int NOT NULL,
	RID			int IDENTITY(1,1) NOT NULL,

	CampoXML		varchar(100) NOT NULL,
	CampoIntelisis		varchar(100) NULL,
	Formato			varchar(50)  NULL,
	Traducir		bit			 DEFAULT 0,
	Opcional		bit			 DEFAULT 0	NULL,	
	TagLimpiar		varchar(MAX) NULL,

	CONSTRAINT priTablaParseoD PRIMARY KEY  CLUSTERED (Modulo, Mov, Exportacion, IDSeccion, RID)
	)
GO

EXEC spALTER_TABLE 'TablaParseoD', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'TablaParseoD', 'Mov', 'varchar(20) NULL'
GO

--EXEC spFK2 'TablaParseoD','Exportacion','IDSeccion','MovExportacionD','Exportacion','RID'
--GO

/*************************** DiccionarioParseoD **************************/
if not exists (select * from SysTabla where SysTabla = 'DiccionarioParseoD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DiccionarioParseoD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.DiccionarioParseoD') and type = 'U')
CREATE TABLE DiccionarioParseoD
        (
	Modulo				varchar(5) NOT NULL,
	Mov				varchar(20) NOT NULL,
	Exportacion		varchar(50)  NOT NULL,
	IDSeccion		int NOT NULL,
	RID			int IDENTITY(1,1) NOT NULL,

	ValorOriginal		varchar(100) NOT NULL,
	ValorDestino		varchar(100) NULL,

	CONSTRAINT priDiccionarioParseoD PRIMARY KEY  CLUSTERED (Modulo, Mov, Exportacion, IDSeccion, RID)
	)
GO

EXEC spALTER_TABLE 'DiccionarioParseoD', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'DiccionarioParseoD', 'Mov', 'varchar(20) NULL'
GO

--exec spFK2 'DiccionarioParseoD','Exportacion','IDSeccion','MovExportacionD','Exportacion','RID'
--GO




