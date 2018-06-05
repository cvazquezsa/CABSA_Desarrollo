/*******************************************************************************************/
/*                                          Series/Lotes                                   */
/*******************************************************************************************/
-- drop table SerieLote

/****** SerieLoteConsignacion ******/ --MEJORASLC
if not exists(select * from SysTabla where SysTabla = 'SerieLoteConsignacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteConsignacion','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteConsignacion') and type = 'U') 
CREATE TABLE dbo.SerieLoteConsignacion (
	Empresa			varchar(5)		NOT NULL,
	OModulo			varchar(5)		NOT NULL,
	OModuloID		int				NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)		NOT NULL DEFAULT '',
	SerieLote		varchar(50)		NOT NULL,
	
    Estatus			varchar(15)		NULL DEFAULT 'ALTA',
        
	CONSTRAINT priSerieLoteConsignacion PRIMARY KEY CLUSTERED (SerieLote, SubCuenta, Articulo, OModuloID, OModulo, Empresa)
)
GO

/****** SerieLoteConsignacionAux ******/ --MEJORASLC
if not exists(select * from SysTabla where SysTabla = 'SerieLoteConsignacionAux')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteConsignacionAux','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteConsignacionAux') and type = 'U') 
CREATE TABLE dbo.SerieLoteConsignacionAux (
	Empresa			varchar(5)				NOT NULL,
	OModulo			varchar(5)				NOT NULL,
	OModuloID		int						NOT NULL,
	Articulo		varchar(20) 			NOT NULL,
	SubCuenta		varchar(50)				NOT NULL DEFAULT '',
	SerieLote		varchar(50)				NOT NULL,
	RID				int identity(1,1)		NOT NULL,

	Modulo			varchar(20)				NULL,
	ModuloID		varchar(20)				NULL,
	Fecha			datetime				NULL,
	CargoU			float					NULL DEFAULT 0,
	AbonoU			float					NULL DEFAULT 0,
	
	CorteID			int						NULL,
	CorteIDAnterior	int						NULL,
    
	CONSTRAINT priSerieLoteConsignacionAux PRIMARY KEY CLUSTERED (RID, SerieLote, SubCuenta, Articulo, OModuloID, OModulo, Empresa)
)
GO

EXEC spADD_INDEX 'SerieLoteConsignacionAux', 'CorteID', 'CorteID'
GO

/****** SerieLoteConsignacionAuxTemp ******/ --MEJORASLC
if not exists(select * from SysTabla where SysTabla = 'SerieLoteConsignacionAuxTemp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteConsignacionAuxTemp','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteConsignacionAuxTemp') and type = 'U') 
CREATE TABLE dbo.SerieLoteConsignacionAuxTemp (
    Estacion		int						NOT NULL,
	Modulo			varchar(20)				NOT NULL,
	ModuloID		varchar(20)				NOT NULL,
	RID				int identity(1,1)		NOT NULL,
	
	Empresa			varchar(5)				NULL,
	OModulo			varchar(5)				NULL,
	OModuloID		int						NULL,
	Articulo		varchar(20) 			NULL,
	SubCuenta		varchar(50)				NULL DEFAULT '',
	SerieLote		varchar(50)				NULL,
	RIDOriginal		int						NULL,		


	MModulo			varchar(20)				NULL,
	MModuloID		varchar(20)				NULL,
	Fecha			datetime				NULL,
	CargoU			float					NULL DEFAULT 0,
	AbonoU			float					NULL DEFAULT 0,
	
	CorteID			int						NULL,
	CorteIDAnterior	int						NULL,
    
	CONSTRAINT priSerieLoteConsignacionAuxTemp PRIMARY KEY CLUSTERED (RID, Modulo, ModuloID, Estacion)
)
GO

EXEC spADD_INDEX 'SerieLoteConsignacionAuxTemp', 'CorteID', 'Estacion, CorteID'
GO

/****** SerieLote ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLote')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLote','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLote') and type = 'U') 
CREATE TABLE dbo.SerieLote (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)	NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,
	Almacen			varchar(10)	NOT NULL,
	Tarima			varchar(20)	NOT NULL DEFAULT '',

	Existencia		float		NULL,
	ExistenciaAlterna	float		NULL,
	ExistenciaActivoFijo	float		NULL,
	Propiedades		varchar(20)	NULL,
	UltimaEntrada		datetime	NULL,
	UltimaSalida		datetime	NULL,
	Cliente			varchar(10)	NULL,
	Localizacion		varchar(10)	NULL,

	Costo			money		NULL,
	CostoInv		money		NULL,
	CostoPromedio		money		NULL,

	CONSTRAINT priSerieLote PRIMARY KEY CLUSTERED (SerieLote, Articulo, SubCuenta, Almacen, Tarima, Sucursal, Empresa)
)
GO
EXEC spALTER_TABLE 'SerieLote', 'Costo', 'money NULL'
EXEC spALTER_TABLE 'SerieLote', 'CostoInv', 'money NULL'
EXEC spALTER_TABLE 'SerieLote', 'CostoPromedio', 'money NULL'
GO
if (select version from version)<=2776 and exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLote' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id) 
  DROP INDEX SerieLote.Articulo
if (select version from version)<=2776 and exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLote' AND sysindexes.name = 'SerieLote' AND sysobjects.id = sysindexes.id) 
  DROP INDEX SerieLote.SerieLote
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLote' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.SerieLote (Articulo, SubCuenta, Almacen, Empresa)
GO
IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla='SerieLote' AND Campo='Tarima')
BEGIN
  EXEC spALTER_TABLE 'SerieLote', 'Tarima', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
  EXEC spALTER_PK 'SerieLote', 'SerieLote, Articulo, SubCuenta, Almacen, Tarima, Sucursal, Empresa'
END
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SerieLote' AND Campo = 'SerieLote' and Tamano=20) OR 
   exists(select * from SysTipoDatos WHERE Tabla = 'SerieLote' AND Campo = 'SubCuenta' and Tamano=20) 
BEGIN
  EXEC spEliminarPK 'SerieLote'
  EXEC spALTER_COLUMN 'SerieLote', 'SerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'SerieLote', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE SerieLote ADD CONSTRAINT priSerieLote PRIMARY KEY CLUSTERED (SerieLote, Articulo, SubCuenta, Almacen, Tarima, Sucursal, Empresa)')
END
GO
EXEC spModificarPK_AcumSaldo 'SerieLote', '(SerieLote, Articulo, SubCuenta, Almacen, Sucursal, Empresa)'
GO

EXEC spFK 'SerieLote','Articulo','Art','Articulo'
EXEC spFK 'SerieLote','Propiedades','SerieLoteProp','Propiedades'
EXEC spFK 'SerieLote','Almacen','Alm','Almacen'
EXEC spFK 'SerieLote','Cliente','Cte','Cliente'
GO

/****** SerieLoteAutorizacion ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteAutorizacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteAutorizacion','Cuenta')
GO
if (select version from version)<=2510
  update Systabla set tipo = 'Cuenta' WHERE Systabla = 'SerieLoteAutorizacion'
GO
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteAutorizacion') and type = 'U') 
CREATE TABLE dbo.SerieLoteAutorizacion (
	Empresa			varchar(5)		NOT NULL,
	SerieLote		varchar(50)	NOT NULL,

	Autorizacion		varchar(10)	NULL,

	CONSTRAINT priSerieLoteAutorizacion PRIMARY KEY CLUSTERED (SerieLote, Empresa)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteAutorizacion' AND Campo = 'SerieLote' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SerieLoteAutorizacion'
  EXEC spALTER_COLUMN 'SerieLoteAutorizacion', 'SerieLote', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE SerieLoteAutorizacion ADD CONSTRAINT priSerieLoteAutorizacion PRIMARY KEY CLUSTERED (SerieLote, Empresa)')
END
GO

/****** SerieLoteD ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteD','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteD') and type = 'U') 
CREATE TABLE dbo.SerieLoteD (
	Empresa			varchar(5)	NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	ID			int		NOT NULL,
	RenglonID		int		NOT NULL,

	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priSerieLoteD PRIMARY KEY CLUSTERED (Articulo, SubCuenta, SerieLote, Modulo, ID, RenglonID, Empresa)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteD' AND Campo = 'SerieLote' and Tamano=20) OR
   exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteD' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SerieLoteD'
  EXEC spALTER_COLUMN 'SerieLoteD', 'SerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'SerieLoteD', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE SerieLoteD ADD CONSTRAINT priSerieLoteD PRIMARY KEY CLUSTERED (Articulo, SubCuenta, SerieLote, Modulo, ID, RenglonID, Empresa)')
END
GO
EXEC spModificarPK_SucursalSinOrigen 'SerieLoteD', '(Articulo, SubCuenta, SerieLote, Modulo, ID, RenglonID, Empresa)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLoteD' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.SerieLoteD (SerieLote, Articulo, ID, Modulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLoteD' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov ON dbo.SerieLoteD (ID, Modulo, SerieLote, Articulo)
GO

EXEC spFK 'SerieLoteD','Articulo','Art','Articulo'
GO

/****** SerieLoteMovArrastre ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteMovArrastre')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteMovArrastre','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteMovArrastre') and type = 'U') 
CREATE TABLE SerieLoteMovArrastre (
	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5) 	NOT NULL,
	ID			int		NOT NULL,
	RenglonID		int		NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,
	CentroOrigen		varchar(10)	NOT NULL,
	CentroDestino		varchar(10)	NOT NULL,

	Cantidad		float		NULL	 DEFAULT 1.0,

        CONSTRAINT prSerieLoteMovArrastre PRIMARY KEY  CLUSTERED (ID,RenglonID,Articulo,SubCuenta,SerieLote,CentroOrigen,CentroDestino,Modulo,Empresa)
)
GO


/****** SerieLoteMov ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteMov') and type = 'U') 
CREATE TABLE dbo.SerieLoteMov (
	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5) 	NOT NULL,
	ID			int		NOT NULL,
	RenglonID		int		NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,

	Cantidad		float		NULL	 DEFAULT 1.0,
	CantidadAlterna		float		NULL,
	Propiedades		varchar(20)	NULL,
	Ubicacion		int		NULL,
	Cliente			varchar(10)	NULL,
	Localizacion		varchar(10)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	ArtCostoInv		money		NULL,


	CONSTRAINT priSerieLoteMov PRIMARY KEY CLUSTERED (ID, RenglonID, Articulo, SubCuenta, SerieLote, Modulo, Empresa)
)
GO
EXEC spALTER_TABLE 'SerieLoteMov', 'ArtCostoInv', 'money NULL'
GO
--TASK25114
EXEC spALTER_TABLE 'SerieLoteMov', 'Tarima', 'varchar(20) NOT NULL DEFAULT ""'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSerieLoteMovC') and sysstat & 0xf = 8) drop trigger dbo.tgSerieLoteMovC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSerieLoteMovB') and sysstat & 0xf = 8) drop trigger dbo.tgSerieLoteMovB
GO
-- Aqui va el Matenimiento a la tabla
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SerieLoteMov' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.SerieLoteMov (ID, Modulo, Empresa)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteMov' AND Campo = 'SerieLote' and Tamano=20) OR
   exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteMov' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SerieLoteMov'
  EXEC spALTER_COLUMN 'SerieLoteMov', 'SerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'SerieLoteMov', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE SerieLoteMov ADD CONSTRAINT priSerieLoteMov PRIMARY KEY CLUSTERED (ID, RenglonID, Articulo, SubCuenta, SerieLote, Modulo, Empresa)')
END
GO
EXEC spModificarPK_SucursalSinOrigen 'SerieLoteMov', '(ID, RenglonID, Articulo, SubCuenta, SerieLote, Modulo, Empresa)'
GO

EXEC spFK 'SerieLoteMov','Propiedades','SerieLoteProp','Propiedades'
GO
EXEC spAlter_Table 'SerieLoteMov','AsignacionUbicacion','bit NOT NULL DEFAULT 0'
GO

/****** PedimentoRegimen ******/
if not exists(select * from SysTabla where SysTabla = 'PedimentoRegimen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PedimentoRegimen', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PedimentoRegimen') and type = 'U') 
CREATE TABLE dbo.PedimentoRegimen (
	PedimentoRegimen	varchar(5)		NOT NULL,

	Descripcion		varchar(100)	NULL,

	CONSTRAINT priPedimentoRegimen PRIMARY KEY CLUSTERED (PedimentoRegimen)
)
GO

/****** PedimentoClave ******/
if (select version from version)<2797 and exists (select * from sysobjects where id = object_id('dbo.PedimentoClave') and type = 'U') 
  drop table PedimentoClave
GO
if not exists(select * from SysTabla where SysTabla = 'PedimentoClave')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PedimentoClave', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PedimentoClave') and type = 'U') 
CREATE TABLE dbo.PedimentoClave (
	PedimentoClave		varchar(5)		NOT NULL,

	Descripcion		varchar(100)	NULL,
	Temporalidad		int		NULL,

	CONSTRAINT priPedimentoClave PRIMARY KEY CLUSTERED (PedimentoClave)
)
GO
EXEC spALTER_TABLE 'PedimentoClave', 'Temporalidad', 'int NULL'
GO

/****** PedimentoClaveRegimen ******/
if not exists(select * from SysTabla where SysTabla = 'PedimentoClaveRegimen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PedimentoClaveRegimen', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PedimentoClaveRegimen') and type = 'U') 
CREATE TABLE dbo.PedimentoClaveRegimen (
	PedimentoClave		varchar(5)		NOT NULL,
	PedimentoRegimen	varchar(5)		NOT NULL,

	CONSTRAINT priPedimentoClaveRegimen PRIMARY KEY CLUSTERED (PedimentoClave, PedimentoRegimen)
)
GO

/****** Propiedades de Series y Lotes ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteProp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteProp','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteProp') and type = 'U') 
CREATE TABLE dbo.SerieLoteProp (
	Propiedades		varchar(20)  	NOT NULL,

	Extra1			varchar(100) 	NULL,
	Extra2			varchar(100) 	NULL,
	Extra3			varchar(100) 	NULL,
	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Fecha1			datetime    	NULL,
	Fecha2			datetime    	NULL,
	Fecha3			datetime    	NULL,
	Factor1			float		NULL,
	Factor2			float		NULL,
	Factor3			float		NULL,

	PedimentoClave		varchar(5)		NULL,
	PedimentoRegimen	varchar(5)		NULL,
	PedimentoTipo		varchar(20)	NULL,
	Vencimiento		datetime 	NULL,
	ValorDolares		money		NULL,
	ValorAduana		money		NULL,
	ValorComercial		money		NULL,
	AgenteAduanal		varchar(10)	NULL,
	Aduana			varchar(50)	NULL,
	DTA			money		NULL,
	IVA			money		NULL,
	IGI			money		NULL,

	TieneRectificacion	bit 		NULL DEFAULT 0,
	PedimentoClave2		varchar(5)		NULL,
	PedimentoRegimen2	varchar(5)		NULL,
	PedimentoTipo2		varchar(20)	NULL,
	Vencimiento2		datetime 	NULL,
	ValorDolares2		money		NULL,
	ValorAduana2		money		NULL,
	ValorComercial2		money		NULL,
	AgenteAduanal2		varchar(10)	NULL,
	Aduana2			varchar(50)	NULL,
	DTA2			money		NULL,
	IVA2			money		NULL,
	IGI2			money		NULL,
	Clave2			varchar(20)	NULL,
	Observaciones		varchar(255)	NULL,
	--23081
	ContribOFP			money		NULL, 
	ContribEfectivo		money		NULL,
	ContribTotal		money		NULL,
	Contraprestacion	money		NULL,
	ImporteTotal		money		NULL,
	CONSTRAINT priSerieLoteProp PRIMARY KEY CLUSTERED (Propiedades)
)
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'Factor1', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Factor2', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Factor3', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoClave', 'varchar(5) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoRegimen', 'varchar(5) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorDolares', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorAduana', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorComercial', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'AgenteAduanal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Aduana', 'varchar(50) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'DTA', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'IVA', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'IGI', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'TieneRectificacion', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoClave2', 'varchar(5) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoRegimen2', 'varchar(5) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PedimentoTipo2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Vencimiento2', 'datetime NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorDolares2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorAduana2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ValorComercial2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'AgenteAduanal2', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Aduana2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'DTA2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'IVA2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'IGI2', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Clave2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Observaciones', 'varchar(255) NULL'
GO

EXEC spFK 'SerieLoteProp','AgenteAduanal','Prov','Proveedor'
EXEC spFK 'SerieLoteProp','PedimentoClave','PedimentoClave','PedimentoClave'
EXEC spFK 'SerieLoteProp','Aduana','Aduana','Aduana'
GO

--23081
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribOFP', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribEfectivo', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribTotal', 'money NULL'			
EXEC spALTER_TABLE 'SerieLoteProp', 'Contraprestacion', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ImporteTotal', 'money NULL'	
GO
/****** SerieLoteCalidad ******/
if not exists(select * from SysTabla where SysTabla = 'SerieLoteCalidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SerieLoteCalidad','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.SerieLoteCalidad') and type = 'U') 
CREATE TABLE dbo.SerieLoteCalidad (
	Empresa			varchar(5)		NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	SerieLote		varchar(50)	NOT NULL,
	Evaluacion		varchar(50)	NOT NULL,

	Valor			float		NULL,
	Fecha			datetime	NULL,
	Referencia		varchar(50)	NULL,

	CONSTRAINT priSerieLoteCalidad PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, SerieLote, Evaluacion)
)
GO
EXEC spALTER_TABLE 'SerieLoteCalidad', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'SerieLoteCalidad', 'Referencia', 'varchar(50) NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteCalidad' AND Campo = 'SerieLote' and Tamano=20) OR 
   exists(select * from SysTipoDatos WHERE Tabla = 'SerieLoteCalidad' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'SerieLoteCalidad'
  EXEC spALTER_COLUMN 'SerieLoteCalidad', 'SerieLote', 'varchar(50) NOT NULL'
  EXEC spALTER_COLUMN 'SerieLoteCalidad', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE SerieLoteCalidad ADD CONSTRAINT priSerieLoteCalidad PRIMARY KEY CLUSTERED (Empresa, Articulo, SubCuenta, SerieLote, Evaluacion)')
END
GO

EXEC spFK2 'SerieLoteCalidad','Articulo','Evaluacion','ArtCalidad','Articulo','Evaluacion'
GO

-- select * from serielote
