IF (select version from version) <= 2637
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.PlanArt') and type = 'U') DROP TABLE PlanArt")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.PlanArtFlujo') and type = 'U') DROP TABLE PlanArtFlujo")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.PlanArtLeyenda') and type = 'U') DROP TABLE PlanArtLeyenda")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.PlanArtOP') and type = 'U') DROP TABLE PlanArtOP")
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.PlanArtOPHist') and type = 'U') DROP TABLE PlanArtOPHist")
END
GO


/****** PlanEstructura ******/
if not exists(select * from SysTabla where SysTabla = 'PlanEstructura')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlanEstructura','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlanEstructura') and type = 'U') 
CREATE TABLE dbo.PlanEstructura (
	TipoPlan	char(10)	NOT NULL,
	Orden 		int		NOT NULL,
	Acronimo	char(10)	NOT NULL,

	Visible		bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priPlanEstructura PRIMARY KEY CLUSTERED (TipoPlan, Orden, Acronimo)
)
GO


/****** PlanArt ******/
if not exists(select * from SysTabla where SysTabla = 'PlanArt')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanArt')
GO
if (select version from version) <= 2870 AND EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'PlanArt')
DROP TABLE PlanArt
GO
if not exists (select * from sysobjects where id = object_id('dbo.PlanArt') and type = 'U') 
CREATE TABLE dbo.PlanArt (
	Empresa		char(5)		NOT NULL,
	Almacen		char(10)	NOT NULL,
	AlmacenDestino	char(10)	NOT NULL	DEFAULT '',
	Articulo	char(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL	DEFAULT '',
	Acronimo	char(10)	NOT NULL,
	Periodo		int		NOT NULL,
	OrigenPlan	bit 		NOT NULL 	DEFAULT 0,

	Cantidad	money		NULL,
	
	CONSTRAINT priPlanArt PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Acronimo, Periodo, Almacen, AlmacenDestino, OrigenPlan, Empresa)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PlanArt' AND sysindexes.name = 'Destino' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Destino ON dbo.PlanArt (Articulo, SubCuenta, Acronimo, AlmacenDestino, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PlanArt' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.PlanArt (Articulo, Acronimo, Empresa)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'PlanArt' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'PlanArt'
  EXEC spALTER_COLUMN 'PlanArt', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE PlanArt ADD CONSTRAINT priPlanArt PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Acronimo, Periodo, Almacen, AlmacenDestino, OrigenPlan, Empresa)')
END
GO

/****** PlanArtFlujo ******/
if not exists(select * from SysTabla where SysTabla = 'PlanArtFlujo')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanArtFlujo')
if (select version from version) <= 1207 AND exists (select * from sysobjects where id = object_id('dbo.PlanArtFlujo') and type = 'U') 
DROP TABLE dbo.PlanArtFlujo
GO
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtFlujo') and type = 'U') 
CREATE TABLE dbo.PlanArtFlujo (
	Empresa			char(5)		NOT NULL,

	Material		char(20)	NOT NULL,
	MaterialPeriodo		int		NOT NULL,
	MaterialSubCuenta	varchar(50)	NOT NULL	DEFAULT '',
	MaterialAlmacen		char(10)	NOT NULL,
	MaterialAcronimo	char(10)	NOT NULL,
	MaterialCantidad	money		NULL,

	Producto		char(20)	NOT NULL,
	ProductoPeriodo		int		NOT NULL,
	ProductoSubCuenta	varchar(50)	NOT NULL	DEFAULT '',
	ProductoAlmacen		char(10)	NOT NULL,
	ProductoAcronimo	char(10)	NOT NULL,
	ProductoCantidad	money		NULL,


	CONSTRAINT priPlanArtFlujo PRIMARY KEY CLUSTERED (Material, MaterialPeriodo, MaterialSubCuenta, MaterialAlmacen, MaterialAcronimo, Producto, ProductoPeriodo, ProductoSubCuenta, ProductoAlmacen, ProductoAcronimo, Empresa)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'PlanArtFlujo' AND Campo = 'MaterialSubCuenta' and Tamano=20) OR
   exists(select * from SysTipoDatos WHERE Tabla = 'PlanArtFlujo' AND Campo = 'ProductoSubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'PlanArtFlujo'
  EXEC spALTER_COLUMN 'PlanArtFlujo', 'MaterialSubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC spALTER_COLUMN 'PlanArtFlujo', 'ProductoSubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE PlanArtFlujo ADD CONSTRAINT priPlanArtFlujo PRIMARY KEY CLUSTERED (Material, MaterialPeriodo, MaterialSubCuenta, MaterialAlmacen, MaterialAcronimo, Producto, ProductoPeriodo, ProductoSubCuenta, ProductoAlmacen, ProductoAcronimo, Empresa)')
END
GO

/****** PlanArtLeyenda ******/
if not exists(select * from SysTabla where SysTabla = 'PlanArtLeyenda')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanArtLeyenda')
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtLeyenda') and type = 'U') 
CREATE TABLE dbo.PlanArtLeyenda (
	Empresa		char(5)		NOT NULL,
	Almacen		char(10)	NOT NULL,
	Articulo	char(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL	DEFAULT '',

	Leyenda		varchar(100)	NULL,
	
	CONSTRAINT priPlanArtLeyenda PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, Empresa)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'PlanArtLeyenda' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'PlanArtLeyenda'
  EXEC spALTER_COLUMN 'PlanArtLeyenda', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE PlanArtLeyenda ADD CONSTRAINT priPlanArtLeyenda PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, Empresa)')
END
GO

/****** PlanArtOP ******/
if not exists(select * from SysTabla where SysTabla = 'PlanArtOP')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanArtOP')
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtOP') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PlanArtOP (
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL	DEFAULT '',
	Almacen			char(10)	NOT NULL,
        ID			int		IDENTITY(1,1)	NOT NULL,

	Sucursal		int		NULL,
	AlmacenDestino		char(10)	NULL,
	FechaLiberacionOriginal	datetime	NULL,
	FechaEntregaOriginal	datetime	NULL,
	CantidadOriginal	float		NULL,
	RutaOriginal		varchar(20)	NULL,

	FechaLiberacion		datetime	NULL,
	FechaEntrega		datetime	NULL,
	Cantidad		float		NULL,
	Ruta			varchar(20)	NULL,

	Unidad			varchar(50)	NULL,
	Proveedor		char(10)	NULL,
	Accion			varchar(20)	NULL,
	Estado			varchar(20)	NULL,  -- Pendiente, En Firme, Liberada

	LiberacionModulo	char(5)		NULL,
	LiberacionID		int		NULL,
	LiberacionMov		varchar(20)	NULL,
	LiberacionMovID		varchar(20)	NULL,
	
	CONSTRAINT priPlanArtOP PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, Empresa, ID)
  )
  EXEC spSincroSemilla 'PlanArtOP'
END
GO
if (select version from version) <= 1095
  ALTER TABLE PlanArtOP ALTER COLUMN LiberacionMovID varchar(20)
GO
EXEC spALTER_TABLE 'PlanArtOP', 'AlmacenDestino', 'char(10) NULL'
GO
EXEC spALTER_TABLE 'PlanArtOP', 'Sucursal', 'int NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PlanArtOP' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.PlanArtOP (ID)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'PlanArtOP' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'PlanArtOP'
  EXEC spALTER_COLUMN 'PlanArtOP', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE PlanArtOP ADD CONSTRAINT priPlanArtOP PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, Empresa, ID)')
END
GO

/****** PlanArtOPHist ******/
if not exists(select * from SysTabla where SysTabla = 'PlanArtOPHist')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanArtOPHist')
if not exists (select * from sysobjects where id = object_id('dbo.PlanArtOPHist') and type = 'U') 
  CREATE TABLE dbo.PlanArtOPHist (
	Fecha			datetime	NOT NULL,
	Empresa			char(5)		NOT NULL,
	Articulo		char(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL	DEFAULT '',
	Almacen			char(10)	NOT NULL,
        ID			int		NOT NULL,

	Sucursal		int		NULL,
	AlmacenDestino		char(10)	NULL,
	FechaLiberacionOriginal	datetime	NULL,
	FechaEntregaOriginal	datetime	NULL,
	CantidadOriginal	float		NULL,
	RutaOriginal		varchar(20)	NULL,

	FechaLiberacion		datetime	NULL,
	FechaEntrega		datetime	NULL,
	Cantidad		float		NULL,
	Ruta			varchar(20)	NULL,

	Unidad			varchar(50)	NULL,
	Proveedor		char(10)	NULL,
	Accion			varchar(20)	NULL,
	Estado			varchar(20)	NULL,  -- Pendiente, En Firme, Liberada

	LiberacionModulo	char(5)		NULL,
	LiberacionID		int		NULL,
	LiberacionMov		varchar(20)	NULL,
	LiberacionMovID		varchar(20)	NULL,

	CONSTRAINT priPlanArtOPHist PRIMARY KEY CLUSTERED (Fecha, Articulo, SubCuenta, Almacen, Empresa, ID)
  )
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'PlanArtOPHist' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'PlanArtOPHist'
  EXEC spALTER_COLUMN 'PlanArtOPHist', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE PlanArtOPHist ADD CONSTRAINT priPlanArtOPHist PRIMARY KEY CLUSTERED (Fecha, Articulo, SubCuenta, Almacen, Empresa, ID)')
END
GO

/****** Plan10 ******/
if not exists(select * from SysTabla where SysTabla = 'Plan10')
INSERT INTO SysTabla (SysTabla) VALUES ('Plan10')
if not exists (select * from sysobjects where id = object_id('dbo.Plan10') and type = 'U') 
CREATE TABLE dbo.Plan10 (
	Periodo		int             NOT NULL,

	CONSTRAINT priPlan10 PRIMARY KEY CLUSTERED (Periodo)
)
GO

/****** PlanBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'PlanBitacora')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanBitacora')
if not exists (select * from sysobjects where id = object_id('dbo.PlanBitacora') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PlanBitacora (
        ID		int		IDENTITY(1,1)	NOT NULL,

	Empresa		char(5)		NULL,
	Categoria	varchar(50) 	NULL,
	Grupo		varchar(50) 	NULL,
	Familia	     	varchar(50) 	NULL,
	Fabricante	varchar(50) 	NULL,
	Linea		varchar(50) 	NULL,
	Temporada	varchar(50) 	NULL,
	Proveedor	char(10)    	NULL,
	Referencia	varchar(50) 	NULL,

	FechaInicio	datetime	NULL,
	FechaFin	datetime	NULL,
        Estatus		varchar(15)	NULL,
	Mensaje		varchar(255)	NULL,

	CONSTRAINT priPlanBitacora PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PlanBitacora'
END
GO
EXEC spALTER_TABLE 'PlanBitacora', 'Referencia', 'varchar(50) NULL'
GO

/****** PlanMensaje ******/
if not exists(select * from SysTabla where SysTabla = 'PlanMensaje')
INSERT INTO SysTabla (SysTabla) VALUES ('PlanMensaje')
if not exists (select * from sysobjects where id = object_id('dbo.PlanMensaje') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PlanMensaje (
        BitacoraID	int		NOT NULL,
        ID		int		IDENTITY(1,1)	NOT NULL,

	Mensaje		varchar(255)	NULL,
	CONSTRAINT priPlanMensaje PRIMARY KEY CLUSTERED (BitacoraID, ID)
  )
  EXEC spSincroSemilla 'PlanMensaje'
END
GO


