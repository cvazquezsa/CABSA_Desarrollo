/** CUENTAS            */

/*******************************************************************************************/
/*                                    CUENTAS CONTABLES                                    */
/*******************************************************************************************/

/****** CtaTiempo ******/
if not exists (select * from SysTabla where SysTabla = 'CtaTiempo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaTiempo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtaTiempo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CtaTiempo (
	Rama			varchar(5)         NOT NULL,
	Cuenta			varchar(20)	NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	FechaComenzo		datetime	NULL,
	FechaTermino		datetime	NULL,
	FechaInicio    		datetime	NULL,
	Estatus			varchar(15)	NULL,
	Situacion		varchar(50)	NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priCtaTiempo PRIMARY KEY CLUSTERED (Cuenta, Rama, RID)
  )
  EXEC spSincroSemilla 'CtaTiempo'
END
GO

/****** Centros de Costos (Empresa) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostosEmpresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostosEmpresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostosEmpresa') and type = 'U') 
CREATE TABLE dbo.CentroCostosEmpresa (
	CentroCostos		varchar(20) 	NOT NULL,
	Empresa			varchar(5)		NOT NULL,

	CONSTRAINT priCentroCostosEmpresa PRIMARY KEY  CLUSTERED (CentroCostos, Empresa)
)
GO

/****** Centros de Costos (Sucursal) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostosSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostosSucursal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostosSucursal') and type = 'U') 
CREATE TABLE dbo.CentroCostosSucursal (
	CentroCostos		varchar(20) 	NOT NULL,
	Sucursal		int		NOT NULL,

	CONSTRAINT priCentroCostosSucursal PRIMARY KEY  CLUSTERED (CentroCostos, Sucursal)
)
GO

EXEC spFK 'CentroCostosSucursal','Sucursal','Sucursal','Sucursal' --(No procesado)
GO

/****** Centros de Costos (Usuario) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostosUsuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostosUsuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostosUsuario') and type = 'U') 
CREATE TABLE dbo.CentroCostosUsuario (
	CentroCostos		varchar(20) 	NOT NULL,
	Usuario			varchar(10)	NOT NULL,

	CONSTRAINT priCentroCostosUsuario PRIMARY KEY  CLUSTERED (CentroCostos, Usuario)
)
GO

/****** Centros de Costos  ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos') and type = 'U') 
CREATE TABLE dbo.CentroCostos (
	CentroCostos		varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion		varchar(100)    NULL,
	EsAcumulativo		bit		NOT NULL DEFAULT 0,
	TieneMovimientos	bit		NOT NULL DEFAULT 0,
	Grupo			varchar(50) 	NULL,
	SubGrupo		varchar(50) 	NULL,
	SubSubGrupo		varchar(50) 	NULL,
	SubSubSubGrupo		varchar(50) 	NULL,
        NivelAcceso		varchar(50)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priCentroCostos PRIMARY KEY  CLUSTERED (CentroCostos)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCentroCostosBC') and sysstat & 0xf = 8) drop trigger dbo.tgCentroCostosBC
GO
EXEC spALTER_TABLE 'CentroCostos', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos', 'SubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos', 'SubSubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos', 'Estatus', 'varchar(15) NULL	DEFAULT "ALTA" WITH VALUES'
GO
CREATE TRIGGER tgCentroCostosBC ON CentroCostos
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CentroCostosN  	varchar(20),
    @CentroCostosA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CentroCostosN = CentroCostos FROM Inserted
  SELECT @CentroCostosA = CentroCostos FROM Deleted
  IF @CentroCostosN = @CentroCostosA RETURN

  IF @CentroCostosN IS NULL 
  BEGIN
    DELETE CentroCostosEmpresa  WHERE CentroCostos = @CentroCostosA
    DELETE CentroCostosSucursal WHERE CentroCostos = @CentroCostosA
    DELETE CentroCostosUsuario  WHERE CentroCostos = @CentroCostosA
  END ELSE
  IF @CentroCostosA IS NOT NULL 
  BEGIN
    UPDATE CentroCostosEmpresa  SET CentroCostos = @CentroCostosN WHERE CentroCostos = @CentroCostosA
    UPDATE CentroCostosSucursal SET CentroCostos = @CentroCostosN WHERE CentroCostos = @CentroCostosA
    UPDATE CentroCostosUsuario  SET CentroCostos = @CentroCostosN WHERE CentroCostos = @CentroCostosA
  END
END
GO
EXEC spReplicaTema 'CentroCostos', 'CentroCostos', 'CentroCostos', @Principal = 1
GO

/****** Centros de Costos 2 (Empresa) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos2Empresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos2Empresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos2Empresa') and type = 'U') 
CREATE TABLE dbo.CentroCostos2Empresa (
	CentroCostos2		varchar(20) 	NOT NULL,
	Empresa			varchar(5)		NOT NULL,

	CONSTRAINT priCentroCostos2Empresa PRIMARY KEY  CLUSTERED (CentroCostos2, Empresa)
)
GO

/****** Centros de Costos 2 (Sucursal) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos2Sucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos2Sucursal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos2Sucursal') and type = 'U') 
CREATE TABLE dbo.CentroCostos2Sucursal (
	CentroCostos2		varchar(20) 	NOT NULL,
	Sucursal		int		NOT NULL,

	CONSTRAINT priCentroCostos2Sucursal PRIMARY KEY  CLUSTERED (CentroCostos2, Sucursal)
)
GO

/****** Centros de Costos 2 (Usuario) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos2Usuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos2Usuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos2Usuario') and type = 'U') 
CREATE TABLE dbo.CentroCostos2Usuario (
	CentroCostos2		varchar(20) 	NOT NULL,
	Usuario			varchar(10)	NOT NULL,

	CONSTRAINT priCentroCostos2Usuario PRIMARY KEY  CLUSTERED (CentroCostos2, Usuario)
)
GO

/****** Centros de Costos 2 ******/
IF (SELECT Version FROM Version)<=3247
  UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'CentroCostos2'
GO 
if not exists(select * from SysTabla where SysTabla = 'CentroCostos2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos2','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos2') and type = 'U') 
CREATE TABLE dbo.CentroCostos2 (
	CentroCostos2		varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion		varchar(100)    NULL,
	EsAcumulativo		bit		NOT NULL DEFAULT 0,
	TieneMovimientos	bit		NOT NULL DEFAULT 0,
	Grupo			varchar(50) 	NULL,
	SubGrupo		varchar(50) 	NULL,
	SubSubGrupo		varchar(50) 	NULL,
	SubSubSubGrupo		varchar(50) 	NULL,
        NivelAcceso		varchar(50)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priCentroCostos2 PRIMARY KEY  CLUSTERED (CentroCostos2)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCentroCostos2BC') and sysstat & 0xf = 8) drop trigger dbo.tgCentroCostos2BC
GO
EXEC spALTER_TABLE 'CentroCostos2', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos2', 'SubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos2', 'SubSubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos2', 'Estatus', 'varchar(15) NULL	DEFAULT "ALTA" WITH VALUES'
GO
CREATE TRIGGER tgCentroCostos2BC ON CentroCostos2
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CentroCostos2N  	varchar(20),
    @CentroCostos2A	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CentroCostos2N = CentroCostos2 FROM Inserted
  SELECT @CentroCostos2A = CentroCostos2 FROM Deleted
  IF @CentroCostos2N = @CentroCostos2A RETURN

  IF @CentroCostos2N IS NULL 
  BEGIN
    DELETE CentroCostos2Empresa  WHERE CentroCostos2 = @CentroCostos2A
    DELETE CentroCostos2Sucursal WHERE CentroCostos2 = @CentroCostos2A
    DELETE CentroCostos2Usuario  WHERE CentroCostos2 = @CentroCostos2A
  END ELSE
  IF @CentroCostos2A IS NOT NULL 
  BEGIN
    UPDATE CentroCostos2Empresa  SET CentroCostos2 = @CentroCostos2N WHERE CentroCostos2 = @CentroCostos2A
    UPDATE CentroCostos2Sucursal SET CentroCostos2 = @CentroCostos2N WHERE CentroCostos2 = @CentroCostos2A
    UPDATE CentroCostos2Usuario  SET CentroCostos2 = @CentroCostos2N WHERE CentroCostos2 = @CentroCostos2A
  END
END
GO
EXEC spReplicaTema 'CentroCostos2', 'CentroCostos2', 'CentroCostos2', @Principal = 1
GO

/****** Centros de Costos 3 (Empresa) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos3Empresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos3Empresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos3Empresa') and type = 'U') 
CREATE TABLE dbo.CentroCostos3Empresa (
	CentroCostos3		varchar(20) 	NOT NULL,
	Empresa			varchar(5)		NOT NULL,

	CONSTRAINT priCentroCostos3Empresa PRIMARY KEY  CLUSTERED (CentroCostos3, Empresa)
)
GO

/****** Centros de Costos 3 (Sucursal) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos3Sucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos3Sucursal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos3Sucursal') and type = 'U') 
CREATE TABLE dbo.CentroCostos3Sucursal (
	CentroCostos3		varchar(20) 	NOT NULL,
	Sucursal		int		NOT NULL,

	CONSTRAINT priCentroCostos3Sucursal PRIMARY KEY  CLUSTERED (CentroCostos3, Sucursal)
)
GO

/****** Centros de Costos 3 (Usuario) ******/
if not exists(select * from SysTabla where SysTabla = 'CentroCostos3Usuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos3Usuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos3Usuario') and type = 'U') 
CREATE TABLE dbo.CentroCostos3Usuario (
	CentroCostos3		varchar(20) 	NOT NULL,
	Usuario			varchar(10)	NOT NULL,

	CONSTRAINT priCentroCostos3Usuario PRIMARY KEY  CLUSTERED (CentroCostos3, Usuario)
)
GO

/****** Centros de Costos 3 ******/
IF (SELECT Version FROM Version)<=3247
  UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'CentroCostos3'
GO 
if not exists(select * from SysTabla where SysTabla = 'CentroCostos3')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroCostos3','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CentroCostos3') and type = 'U') 
CREATE TABLE dbo.CentroCostos3 (
	CentroCostos3		varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion		varchar(100)    NULL,
	EsAcumulativo		bit		NOT NULL DEFAULT 0,
	TieneMovimientos	bit		NOT NULL DEFAULT 0,
	Grupo			varchar(50) 	NULL,
	SubGrupo		varchar(50) 	NULL,
	SubSubGrupo		varchar(50) 	NULL,
	SubSubSubGrupo		varchar(50) 	NULL,
        NivelAcceso		varchar(50)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priCentroCostos3 PRIMARY KEY  CLUSTERED (CentroCostos3)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCentroCostos3BC') and sysstat & 0xf = 8) drop trigger dbo.tgCentroCostos3BC
GO
EXEC spALTER_TABLE 'CentroCostos3', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos3', 'SubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos3', 'SubSubSubGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CentroCostos3', 'Estatus', 'varchar(15) NULL	DEFAULT "ALTA" WITH VALUES'
GO
CREATE TRIGGER tgCentroCostos3BC ON CentroCostos3
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CentroCostos3N  	varchar(20),
    @CentroCostos3A	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CentroCostos3N = CentroCostos3 FROM Inserted
  SELECT @CentroCostos3A = CentroCostos3 FROM Deleted
  IF @CentroCostos3N = @CentroCostos3A RETURN

  IF @CentroCostos3N IS NULL 
  BEGIN
    DELETE CentroCostos3Empresa  WHERE CentroCostos3 = @CentroCostos3A
    DELETE CentroCostos3Sucursal WHERE CentroCostos3 = @CentroCostos3A
    DELETE CentroCostos3Usuario  WHERE CentroCostos3 = @CentroCostos3A
  END ELSE
  IF @CentroCostos3A IS NOT NULL 
  BEGIN
    UPDATE CentroCostos3Empresa  SET CentroCostos3 = @CentroCostos3N WHERE CentroCostos3 = @CentroCostos3A
    UPDATE CentroCostos3Sucursal SET CentroCostos3 = @CentroCostos3N WHERE CentroCostos3 = @CentroCostos3A
    UPDATE CentroCostos3Usuario  SET CentroCostos3 = @CentroCostos3N WHERE CentroCostos3 = @CentroCostos3A
  END
END
GO
EXEC spReplicaTema 'CentroCostos3', 'CentroCostos3', 'CentroCostos3', @Principal = 1
GO

/****** Grupos de Cuentas  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaGrupo') and type = 'U') 
CREATE TABLE dbo.CtaGrupo (
	Grupo	 		varchar(50) NOT NULL,

	CONSTRAINT priCtaGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/****** Familias de Cuentas  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaFam') and type = 'U') 
CREATE TABLE dbo.CtaFam (
	Familia 		varchar(50) 	NOT NULL ,

	FamiliaMaestra	 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCtaFam PRIMARY KEY  CLUSTERED (Familia)
)

/****** Categorias de Cuentas ******/
if not exists(select * from SysTabla where SysTabla = 'CtaCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaCat') and type = 'U') 
CREATE TABLE dbo.CtaCat (
	Categoria 		varchar(50) 	NOT NULL,

	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCtaCat PRIMARY KEY  CLUSTERED (Categoria)
)

/****** SubCuentas  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaSub')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaSub','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaSub') and type = 'U') 
CREATE TABLE dbo.CtaSub (
	Cuenta			varchar(20) 	NOT NULL,
	SubCuenta		varchar(50) 	NOT NULL,

	CONSTRAINT priCtaSub PRIMARY KEY CLUSTERED (Cuenta, SubCuenta)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'CtaSub' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'CtaSub'
  EXEC spALTER_COLUMN 'CtaSub', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE CtaSub ADD CONSTRAINT priCtaSub PRIMARY KEY CLUSTERED (Cuenta, SubCuenta)')
END
GO

/****** SubCuentas2  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaSub2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaSub2','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaSub2') and type = 'U') 
CREATE TABLE dbo.CtaSub2 (
	Cuenta			varchar(20) 	NOT NULL,
	SubCuenta2		varchar(50) 	NOT NULL,

	CONSTRAINT priCtaSub2 PRIMARY KEY CLUSTERED (Cuenta, SubCuenta2)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'CtaSub2' AND Campo = 'SubCuenta2' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'CtaSub2'
  EXEC spALTER_COLUMN 'CtaSub2', 'SubCuenta2', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE CtaSub2 ADD CONSTRAINT priCtaSub2 PRIMARY KEY CLUSTERED (Cuenta, SubCuenta2)')
END
GO

/****** SubCuentas3  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaSub3')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaSub3','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaSub3') and type = 'U') 
CREATE TABLE dbo.CtaSub3 (
	Cuenta			varchar(20) 	NOT NULL,
	SubCuenta3		varchar(50) 	NOT NULL,

	CONSTRAINT priCtaSub3 PRIMARY KEY CLUSTERED (Cuenta, SubCuenta3)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'CtaSub3' AND Campo = 'SubCuenta3' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'CtaSub3'
  EXEC spALTER_COLUMN 'CtaSub3', 'SubCuenta3', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE CtaSub3 ADD CONSTRAINT priCtaSub3 PRIMARY KEY CLUSTERED (Cuenta, SubCuenta3)')
END
GO

/****** CtaMov ******/
if not exists(select * from SysTabla where SysTabla = 'CtaMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaMov') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CtaMov (
	Cuenta			varchar(20) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Modulo			varchar(5)		NULL,
	Mov			varchar(20)	NULL,
	Concepto		varchar(50)	NULL,
	Clase			varchar(50)	NULL,
	SubClase		varchar(50)	NULL,
	ContactoTipo		varchar(20)	NULL,
	ContactoSubTipo		varchar(20)	NULL,
	ContactoNivel		varchar(20)	NULL,		-- Todos, Sub Tipo, Rama, Clave
	ContactoClave		varchar(20)	NULL,
	Debe			varchar(20)	NULL,		-- Importe, Impuestos, Retenciones, Importe Total
	Haber			varchar(20)	NULL,		-- Importe, Impuestos, Retenciones, Importe Total

	CONSTRAINT priCtaMov PRIMARY KEY CLUSTERED (Cuenta, ID)
  )
  EXEC spSincroSemilla 'CtaMov'
END
GO
EXEC spALTER_TABLE 'CtaMov', 'Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaMov', 'Clase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaMov', 'SubClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaMov', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CtaMov', 'ContactoSubTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CtaMov', 'ContactoNivel', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CtaMov', 'ContactoClave', 'varchar(20) NULL'
GO

/* SentinelHist */
if not exists(select * from SysTabla where SysTabla = 'SentinelHist')
INSERT INTO SysTabla (SysTabla) VALUES ('SentinelHist')
if not exists (select * from sysobjects where id = object_id('dbo.SentinelHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SentinelHist (
	Serie			int		NOT NULL,
	Fecha			datetime	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

    	Cliente        		varchar(10)     	NOT NULL,
	Nombre			varchar(100)	NULL,
	Usuarios		int		NULL,
	Fabricacion		datetime	NULL,
	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	Usuario			varchar(10)	NULL,

    	CONSTRAINT priSentinelHist PRIMARY KEY  CLUSTERED (Serie, Fecha, ID)
  )
  EXEC spSincroSemilla 'SentinelHist'
END
GO

/* Sentinel */
if not exists(select * from SysTabla where SysTabla = 'Sentinel')
INSERT INTO SysTabla (SysTabla) VALUES ('Sentinel')
if not exists (select * from sysobjects where id = object_id('dbo.Sentinel') and type = 'U') 
CREATE TABLE dbo.Sentinel (
	Serie			int		NOT NULL,

    	Cliente        		varchar(10)     	NOT NULL,
	Nombre			varchar(100)	NULL,
	Usuarios		int		NULL,
	Fabricacion		datetime	NULL,
	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	Usuario			varchar(10)	NULL,

    	CONSTRAINT priSentinel PRIMARY KEY  CLUSTERED (Serie)
)
GO
EXEC spALTER_TABLE 'Sentinel', 'Usuario', 'char(10) NULL'
go
if exists (select * from sysobjects where id = object_id('dbo.tgSentinelAC') and sysstat & 0xf = 8) drop trigger dbo.tgSentinelAC
GO

/****** GRP_AP ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_AP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_AP','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_AP') and type = 'U') 
CREATE TABLE dbo.GRP_AP (
	AP		varchar(4)		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_AP PRIMARY KEY CLUSTERED (AP)
)
GO



/****** GRP_GF ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_GF')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_GF','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_GF') and type = 'U') 
CREATE TABLE dbo.GRP_GF (
	GF		varchar(3)		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_GF PRIMARY KEY CLUSTERED (GF)
)
GO

/****** GRP_Funcion ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_Funcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_Funcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_Funcion') and type = 'U') 
CREATE TABLE dbo.GRP_Funcion (
	Funcion		int		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_Funcion PRIMARY KEY CLUSTERED (Funcion)
)
GO

/****** GRP_SubFuncion ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_SubFuncion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_SubFuncion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_SubFuncion') and type = 'U') 
CREATE TABLE dbo.GRP_SubFuncion (
	SubFuncion		int		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_SubFuncion PRIMARY KEY CLUSTERED (SubFuncion)
)
GO

/****** GRP_Programa ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_Programa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_Programa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_Programa') and type = 'U') 
CREATE TABLE dbo.GRP_Programa (
	Programa	int		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_Programa PRIMARY KEY CLUSTERED (Programa)
)
GO

/****** GRP_AI ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_AI')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_AI','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_AI') and type = 'U') 
CREATE TABLE dbo.GRP_AI (
	AI		char(2)		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_AI PRIMARY KEY CLUSTERED (AI)
)
GO

/****** GRP_Proyecto ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_Proyecto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_Proyecto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_Proyecto') and type = 'U') 
CREATE TABLE dbo.GRP_Proyecto (
	Proyecto	char(4)		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_Proyecto PRIMARY KEY CLUSTERED (Proyecto)
)
GO

/****** GRP_TG ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_TG')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_TG','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_TG') and type = 'U') 
CREATE TABLE dbo.GRP_TG (
	TG		int		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_TG PRIMARY KEY CLUSTERED (TG)
)
GO

/****** GRP_FF ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_FF')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_FF','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_FF') and type = 'U') 
CREATE TABLE dbo.GRP_FF (
	FF		char(2)		NOT NULL,

	Descripcion	varchar(100)	NULL,

	CONSTRAINT priGRP_FF PRIMARY KEY CLUSTERED (FF)
)
GO

if exists(select * from syscampo where tabla = 'GRP_Presupuesto' and (campo = 'Anteproyecto' or campo = 'Reduccion'))
  drop table GRP_Presupuesto
GO

/****** GRP_Presupuesto ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_Presupuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_Presupuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_Presupuesto') and type = 'U') 
CREATE TABLE dbo.GRP_Presupuesto (
	ID			int		NOT NULL	IDENTITY(1,1),

	Ejercicio		int		NULL,
	Partida			varchar(20) 	NULL,
	AP			varchar(4)		NULL,
	GF			varchar(3)		NULL,
	Funcion			int		NULL,
	SubFuncion		int		NULL,
	Programa		int		NULL,
	AI			varchar(2)		NULL,
	Proyecto		varchar(4)		NULL,
	TG			int		NULL,
	FF			varchar(2)		NULL,
	Importe			money		NULL,
	Neto			money		NULL,
	Observaciones		varchar(255)	NULL,

	CONSTRAINT priGRP_Presupuesto PRIMARY KEY CLUSTERED (ID)
)
GO

EXEC spFK 'GRP_Presupuesto','Partida','Cta','Cuenta'
GO

/****** GRP_PresupuestoD ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_PresupuestoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_PresupuestoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_PresupuestoD') and type = 'U') 
CREATE TABLE dbo.GRP_PresupuestoD (
	ID			int		NOT NULL,
	Periodo			int		NOT NULL,

	Importe			money		NULL,
	Reduccion		money		NULL,
	Ampliacion		money		NULL,

	CONSTRAINT priGRP_PresupuestoD PRIMARY KEY CLUSTERED (ID, Periodo)
)
GO

/****** GRP_PresupuestoCta ******/
if not exists(select * from SysTabla where SysTabla = 'GRP_PresupuestoCta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GRP_PresupuestoCta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GRP_PresupuestoCta') and type = 'U') 
CREATE TABLE dbo.GRP_PresupuestoCta (
	ID			int		NOT NULL,
	Periodo			int		NOT NULL,
	Cuenta			varchar(20)	NOT NULL,

	Importe			money		NULL,

	CONSTRAINT priGRP_PresupuestoCta PRIMARY KEY CLUSTERED (ID, Periodo, Cuenta)
)
GO

EXEC spFK 'GRP_PresupuestoCta','Cuenta','Cta','Cuenta'
GO

/****** Cuentas Contables  ******/
if not exists(select * from SysTabla where SysTabla = 'Cta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Cta','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Cta') and type = 'U') 
CREATE TABLE dbo.Cta (
	Cuenta	 		varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion		varchar(100)    NULL,
	Tipo			varchar(15)	NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	EsAcreedora		bit		NOT NULL	DEFAULT 0,
	EsAcumulativa		bit		NOT NULL	DEFAULT 0,
	TieneMovimientos	bit		NOT NULL	DEFAULT 0,
	Conciliar		bit		NOT NULL	DEFAULT 0,

	Directa			bit		NOT NULL	DEFAULT 0,
	CentrosCostos		bit		NOT NULL	DEFAULT 0,
	CentroCostosRequerido   bit		NOT NULL	DEFAULT 0,
	CentroCostosOmision	varchar(50)	NULL,

	CentroCostos2		bit		NOT NULL	DEFAULT 0,
	CentroCostosRequerido2   bit		NOT NULL	DEFAULT 0,
	CentroCostosOmision2	varchar(20)	NULL,

	CentroCostos3		bit		NOT NULL	DEFAULT 0,
	CentroCostosRequerido3   bit		NOT NULL	DEFAULT 0,
	CentroCostosOmision3	varchar(20)	NULL,

	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,
        NivelAcceso		varchar(50)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Logico4			bit		NOT NULL	DEFAULT 0,

	AjusteInflacionario	bit		NULL		DEFAULT 0,
	Bucket			int		NULL,
	BucketSt		varchar(10)	NULL,
	CuadreContable		bit		NULL		DEFAULT 0,
	PresupuestoNivelUEN	bit		NULL		DEFAULT 0,
	CuentaDistribucion	varchar(20)	NULL,
	PresupuestoOtrosPeriodos bit NULL	DEFAULT 0,
	DetalleTipo		varchar(50)	NULL,

	CONSTRAINT priCta PRIMARY KEY  CLUSTERED (Cuenta)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cta' AND sysindexes.name = 'Rama' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Rama ON dbo.Cta (Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cta' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.Cta (Descripcion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cta' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria   ON dbo.Cta (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cta' AND sysindexes.name = 'Tipo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tipo        ON dbo.Cta (Tipo)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCtaABC') and sysstat & 0xf = 8) drop trigger dbo.tgCtaABC
GO
EXEC spSincroNivelRegistroCampos 'Cta'
GO
EXEC spALTER_TABLE 'Cta', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cta', 'AjusteInflacionario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'Bucket', 'int NULL'
EXEC spALTER_TABLE 'Cta', 'BucketSt' ,'varchar(10) NULL'
EXEC spALTER_TABLE 'Cta', 'CuadreContable', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'PresupuestoNivelUEN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'CuentaDistribucion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cta', 'PresupuestoOtrosPeriodos', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'DetalleTipo', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'Cta', 'CentroCostos2', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'CentroCostosRequerido2', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'CentroCostosOmision2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cta', 'CentroCostos3', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'CentroCostosRequerido3', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'CentroCostosOmision3', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'Cta', 'ContSATCFD', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cta', 'ContSATDin', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_Table 'Cta', 'ClaveSAT', 'VARCHAR(40)'
EXEC spALTER_Table 'Cta', 'TipoComprobacion', 'VARCHAR(50)'
GO
CREATE TRIGGER tgCtaABC ON Cta
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(20),
    @RamaNueva		varchar(20),
    @ClaveAnterior	varchar(20),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Cuenta, @RamaNueva = NULLIF(RTRIM(Rama), '') FROM Inserted
  SELECT @ClaveAnterior = Cuenta FROM Deleted

  IF @ClaveNueva = @ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    -- Al Eliminar
    IF EXISTS (SELECT * FROM Cta WHERE Rama = @ClaveAnterior)
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30160
      RAISERROR (@Mensaje,16,-1) 
    END ELSE
    BEGIN
      DELETE CtaSub      WHERE Cuenta = @ClaveAnterior
      DELETE CtaMov      WHERE Cuenta = @ClaveAnterior
      DELETE CtaIVA	 WHERE Cuenta = @ClaveAnterior
      DELETE Prop        WHERE Cuenta = @ClaveAnterior AND Rama='CONT'
      DELETE ListaD      WHERE Cuenta = @ClaveAnterior AND Rama='CONT'
      DELETE AnexoCta    WHERE Cuenta = @ClaveAnterior AND Rama='CONT'
      DELETE Presupuesto WHERE Cuenta = @ClaveAnterior AND Rama='CONT'
    END
  END ELSE
  BEGIN
    IF @ClaveNueva NOT IN ('A', 'X') AND @RamaNueva IS NULL
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveNueva))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 20920
      RAISERROR (@Mensaje,16,-1) 
    END
  END

  IF @ClaveAnterior IS NOT NULL AND @ClaveNueva IS NOT NULL
  BEGIN
    -- Al Modificar
    UPDATE CtaSub      SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior
    UPDATE CtaMov      SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior
    UPDATE CtaIVA      SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior

    UPDATE Prop        SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='CONT' 
    UPDATE ListaD      SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='CONT' 
    UPDATE AnexoCta    SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='CONT' 
    UPDATE Presupuesto SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='CONT' 
  END

  IF @ClaveNueva IS NOT NULL AND UPDATE(Rama) 
  BEGIN
    IF (SELECT Sincro FROM Version) = 1
      EXEC sp_executesql N'UPDATE Cta SET Rama = NULL, SincroC = SincroC WHERE Cuenta = @ClaveNueva AND Rama = ""', N'@ClaveNueva varchar(20)', @ClaveNueva = @ClaveNueva
    ELSE
      UPDATE Cta SET Rama = NULL WHERE Cuenta = @ClaveNueva AND Rama = ''
  END
END
GO

/****** Cuentas de IVA ******/
if not exists(select * from SysTabla where SysTabla = 'CtaIVA')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaIVA','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaIVA') and type = 'U') 
CREATE TABLE dbo.CtaIVA (
	Cuenta			varchar(20) 	NOT NULL,
	Tipo			varchar(20)	NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priCtaIVA PRIMARY KEY CLUSTERED (Cuenta)
)
GO

EXEC spFK 'CtaIVA','Cuenta','Cta','Cuenta'
GO

EXEC spReplicaTema 'CuentasContables', 'Cta',		'Cuenta', @Principal = 1
EXEC spReplicaTema 'CuentasContables', 'CtaSub',	'Cuenta'
EXEC spReplicaTema 'CuentasContables', 'CtaMov',	'Cuenta'
EXEC spReplicaTema 'CuentasContables', 'CtaIVA',	'Cuenta'
EXEC spReplicaTema 'CuentasContables', 'Prop',		'Cuenta', 'Rama', '"CONT"'
EXEC spReplicaTema 'CuentasContables', 'ListaD',	'Cuenta', 'Rama', '"CONT"'
EXEC spReplicaTema 'CuentasContables', 'AnexoCta',	'Cuenta', 'Rama', '"CONT"'
EXEC spReplicaTema 'CuentasContables', 'Presupuesto',	'Cuenta', 'Rama', '"CONT"'
GO

/****** ContUso  ******/
if not exists(select * from SysTabla where SysTabla = 'ContUso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContUso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContUso') and type = 'U') 
CREATE TABLE dbo.ContUso (
	ContUso			varchar(20) 	NOT NULL,
	Descripcion		varchar(100)    NULL,

	Cuenta			varchar(20)	NULL,
	CentroCostos		varchar(20)	NULL,
	Grupo			varchar(50)	NULL,

	CONSTRAINT priContUso PRIMARY KEY  CLUSTERED (ContUso)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContUso' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.ContUso (Descripcion)
GO

/*******************************************************************************************/
/*                                      CUENTAS BANCARIAS                                  */
/*******************************************************************************************/

/****** Instituciones Financieras ******/
if not exists(select * from SysTabla where SysTabla = 'InstitucionFin')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InstitucionFin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.InstitucionFin') and type = 'U') 
CREATE TABLE dbo.InstitucionFin (
	Institucion		varchar(20) 	NOT NULL,
	Nombre			varchar(50)	NULL,
	Ciudad			varchar(40)	NULL,
	Estado			varchar(40)	NULL,
	Pais			varchar(3)		NULL,
	Aba			varchar(10)	NULL,
	Swift			varchar(15)	NULL,
	Chips			varchar(15)	NULL,
	Bofa			varchar(15)	NULL,
	Banxico			int		NULL,
	SwitchAbaOnline		bit		NOT NULL DEFAULT 0,
	SwitchActivo		bit		NOT NULL DEFAULT 0,
	Estatus			varchar(15)	NOT NULL,
	UltimoCambio		datetime	NULL,

	Logico1			bit	     	NOT NULL DEFAULT 0,
	ParaisoFiscal		bit	     	NOT NULL DEFAULT 0,
	CiudadRiesgo		bit	     	NOT NULL DEFAULT 0,
	ConcliarNivelCheque	bit	     	NOT NULL DEFAULT 0,
	ConcliarIVAIntegrado	bit	     	NOT NULL DEFAULT 0,
	Layout			varchar(20)	NULL,
	
	EmidaBankCode		varchar(20) NULL,	-- REQ12336

	CONSTRAINT priInstitucionFin PRIMARY KEY  CLUSTERED (Institucion)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InstitucionFin' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.InstitucionFin (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InstitucionFin' AND sysindexes.name = 'Pais' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Pais   ON dbo.InstitucionFin (Pais)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InstitucionFin' AND sysindexes.name = 'Estado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Estado ON dbo.InstitucionFin (Pais, Estado)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'InstitucionFin' AND sysindexes.name = 'Cuidad' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuidad ON dbo.InstitucionFin (Pais, Estado, Ciudad)
go
EXEC spRENAME_COLUMN 'InstitucionFin', 'Logico3', 'CiudadRiesgo'
EXEC spRENAME_COLUMN 'InstitucionFin', 'Logico2', 'ParaisoFiscal'
GO
EXEC spALTER_TABLE 'InstitucionFin', 'ConcliarNivelCheque', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'InstitucionFin', 'ConcliarIVAIntegrado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'InstitucionFin', 'Layout', 'varchar(20) NULL'
GO

-- REQ12336
EXEC spALTER_TABLE 'InstitucionFin', 'EmidaBankCode', 'varchar(20) NULL'
GO

/****** Bancos ******/
if not exists(select * from SysTabla where SysTabla = 'BancoSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('BancoSucursal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.BancoSucursal') and type = 'U') 
CREATE TABLE dbo.BancoSucursal (
	BancoSucursal		varchar(50)  	NOT NULL,

	Banco 			varchar(100)  	NULL,
	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais 			varchar(30)    	NULL,
	CodigoPostal 		varchar(15)  	NULL,
	Telefonos 		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit		NOT NULL 	DEFAULT 0,
	Gerente 		varchar(50)  	NULL,
	Contacto1 		varchar(50)  	NULL,
	Contacto2 		varchar(50)  	NULL,
        ExtencionGerente        varchar(10)     NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMailGerente		varchar(50)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,

	UltimoCambio 		datetime      	NULL,
	Alta			datetime	NULL,

	CONSTRAINT priBancoSucursal PRIMARY KEY CLUSTERED (BancoSucursal)
)
go

/****** Acceso Cuentas Dinero ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroAcceso') and type = 'U') 
CREATE TABLE dbo.CtaDineroAcceso (
	CtaDinero		varchar(10) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priCtaDineroAcceso PRIMARY KEY  CLUSTERED (CtaDinero, Usuario)
)
go

/****** CtaDineroHist  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CtaDineroHist (
	CtaDinero	varchar(10)  	NOT NULL,
	Fecha		datetime	NOT NULL,
	RenglonID	int		NOT NULL IDENTITY(1,1),

	Descripcion	varchar(100)	NULL,
	Tipo		varchar(20)	NULL,
	NumeroCta	varchar(100)    NULL,
	CuentaHabiente	varchar(100) 	NULL,
	Moneda 		varchar(10)  	NULL,
	Estatus 	varchar(15) 	NULL,
	Sucursal	int		NULL,

	CONSTRAINT priCtaDineroHist PRIMARY KEY CLUSTERED (CtaDinero, Fecha, RenglonID)
  )
  EXEC spSincroSemilla 'CtaDineroHist'
END
GO

/****** Categorias de CtaDinero  ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroCat') and type = 'U') 
CREATE TABLE dbo.CtaDineroCat (
	Categoria 		varchar(50) 	NOT NULL,

	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCtaDineroCat PRIMARY KEY  CLUSTERED (Categoria)
)
go

/****** Grupos de CtaDinero ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroGrupo') and type = 'U') 
CREATE TABLE dbo.CtaDineroGrupo (
	Grupo	 		varchar(50) NOT NULL,

	CONSTRAINT priCtaDineroGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
go

/****** Familias de CtaDinero ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroFam') and type = 'U') 
CREATE TABLE dbo.CtaDineroFam (
	Familia 		varchar(50) 	NOT NULL ,

	FamiliaMaestra	 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCtaDineroFam PRIMARY KEY  CLUSTERED (Familia)
)
go

/****** Tipos de CtaDinero ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDineroTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDineroTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDineroTipo') and type = 'U') 
CREATE TABLE dbo.CtaDineroTipo (
	Tipo	 		varchar(50) NOT NULL,

	CONSTRAINT priCtaDineroTipo PRIMARY KEY  CLUSTERED (Tipo)
)
go

/****** Cuentas Dinero ******/
if not exists(select * from SysTabla where SysTabla = 'CtaDinero')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtaDinero','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtaDinero') and type = 'U') 
CREATE TABLE dbo.CtaDinero (
	CtaDinero		varchar(10)  	NOT NULL,
	Rama			varchar(10)	NULL,
	Descripcion		varchar(100)	NULL,
	Tipo			varchar(20)	NULL,

	BancoSucursal 		varchar(100)  	NULL,
	NumeroCta		varchar(100)    NULL,
	CuentaHabiente		varchar(100) 	NULL,
	Moneda 			varchar(10)  	NULL,

	Empresa			varchar(5)		NULL,
	Sucursal		int		NOT NULL 	DEFAULT 0,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	UltimoCorte 		datetime  	NULL,
	Beneficiario		int		NULL,
	Institucion		varchar(20)	NULL,
	Uso			varchar(20)	NULL,	-- Operacion/Inversion
	TieneMovimientos	bit		NULL		DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,

	Alerta			bit		NULL  DEFAULT 0,
	AlertaLimiteInferior	money		NULL,
	AlertaLimiteSuperior	money		NULL,
	FondoFijo		money		NULL,
	FondoFijoFormaPago	varchar(50)	NULL,
	Cuenta			varchar(20)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CorteAutoCerrarDia	bit		NULL 		DEFAULT 1,
	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	CLABE			varchar(18)	NULL,
	Acreedor		varchar(10)	NULL,

	CONSTRAINT priCtaDinero PRIMARY KEY  CLUSTERED (CtaDinero)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCtaDineroBC') and sysstat & 0xf = 8) drop trigger dbo.tgCtaDineroBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCtaDineroABC') and sysstat & 0xf = 8) drop trigger dbo.tgCtaDineroABC
GO
if not exists(select * from syscampo where tabla = 'CtaDinero' and campo = 'BancoSucursal') and exists (select * from syscampo where tabla = 'CtaDinero' and campo = 'Sucursal')
  EXEC sp_rename 'CtaDinero.Sucursal', 'BancoSucursal', 'COLUMN'
GO
if not exists(select * from syscampo where tabla = 'CtaDinero' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE CtaDinero ADD TieneMovimientos bit NULL DEFAULT 0 WITH VALUES")
  EXEC("UPDATE CtaDinero SET TieneMovimientos = 1")
END
GO
EXEC spALTER_TABLE 'CtaDinero', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CtaDinero', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Alerta', 'bit NULL  DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CtaDinero', 'AlertaLimiteInferior', 'money NULL'
EXEC spALTER_TABLE 'CtaDinero', 'AlertaLimiteSuperior', 'money NULL'
EXEC spALTER_TABLE 'CtaDinero', 'FondoFijo', 'money NULL'
EXEC spALTER_TABLE 'CtaDinero', 'FondoFijoFormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'CorteAutoCerrarDia', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'CtaDinero', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Familia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Rama', 'char(10) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'CLABE', 'varchar(18) NULL'
EXEC spALTER_TABLE 'CtaDinero', 'Acreedor', 'varchar(10) NULL'
GO

--REQ 13393 POS
 EXEC spALTER_TABLE 'CtaDinero', 'EsConcentradora', 'bit NULL DEFAULT 0 WITH VALUES'
 EXEC spALTER_TABLE 'CtaDinero', 'ClaveLDI', 'int NULL'
 EXEC spALTER_TABLE 'CtaDinero', 'MovOmision', 'varchar(20) NULL'
 EXEC spALTER_TABLE 'CtaDinero', 'RID', 'int IDENTITY'
  EXEC spALTER_TABLE 'CtaDinero', 'HOST', 'varchar(20)  NULL'
GO


EXEC spFK 'CtaDinero','Institucion','InstitucionFin','Institucion'
EXEC spFK 'CtaDinero','Sucursal','Sucursal','Sucursal'
EXEC spFK 'CtaDinero','Cuenta','Cta','Cuenta'
EXEC spFK 'CtaDinero','Beneficiario','Beneficiario','Beneficiario'
GO

--BUG2404 Preconfig
EXEC spALTER_TABLE 'CtaDinero', 'SaldoInicial', 'money NULL'
GO

CREATE TRIGGER tgCtaDineroABC ON CtaDinero
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS BEGIN
  IF UPDATE(Descripcion) OR UPDATE(Tipo) OR UPDATE(NumeroCta) OR UPDATE(CuentaHabiente) OR UPDATE(Moneda) OR UPDATE(Estatus) OR UPDATE(Sucursal)
    INSERT CtaDineroHist (CtaDinero, Fecha, Descripcion, Tipo, NumeroCta, CuentaHabiente, Moneda, Estatus, Sucursal)
                   SELECT CtaDinero, GETDATE(), Descripcion, Tipo, NumeroCta, CuentaHabiente, Moneda, Estatus, Sucursal
                     FROM Inserted

  DECLARE
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = CtaDinero FROM Inserted
  SELECT @ClaveAnterior = CtaDinero FROM Deleted

  IF @ClaveNueva=@ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    DELETE CtaDineroAcceso WHERE CtaDinero = @ClaveAnterior 
    DELETE CtaDineroHist   WHERE CtaDinero = @ClaveAnterior 

    DELETE Prop            WHERE Cuenta    = @ClaveAnterior AND Rama = 'DIN'
    DELETE ListaD          WHERE Cuenta    = @ClaveAnterior AND Rama = 'DIN'
    DELETE AnexoCta        WHERE Cuenta    = @ClaveAnterior AND Rama = 'DIN'
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior AND @ClaveAnterior IS NOT NULL
  BEGIN
    UPDATE CtaDineroAcceso SET CtaDinero = @ClaveNueva WHERE CtaDinero = @ClaveAnterior
    UPDATE CtaDineroHist   SET CtaDinero = @ClaveNueva WHERE CtaDinero = @ClaveAnterior

    UPDATE Prop            SET Cuenta    = @ClaveNueva WHERE Cuenta    = @ClaveAnterior AND Rama='DIN'
    UPDATE ListaD          SET Cuenta    = @ClaveNueva WHERE Cuenta    = @ClaveAnterior AND Rama='DIN'
    UPDATE AnexoCta        SET Cuenta    = @ClaveNueva WHERE Cuenta    = @ClaveAnterior AND Rama='DIN'
  END

END
GO

EXEC spReplicaTema 'CuentasDinero', 'CtaDinero',	'CtaDinero', @Principal = 1
EXEC spReplicaTema 'CuentasDinero', 'CtaDineroAcceso',	'CtaDinero'
EXEC spReplicaTema 'CuentasDinero', 'Prop'	,	'Cuenta', 'Rama', '"DIN"'
EXEC spReplicaTema 'CuentasDinero', 'ListaD',		'Cuenta', 'Rama', '"DIN"'
EXEC spReplicaTema 'CuentasDinero', 'AnexoCta',		'Cuenta', 'Rama', '"DIN"'
GO


/*******************************************************************************************/
/*                                        CLIENTES                                         */
/*******************************************************************************************/

/****** Limites de Credito  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCredito')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCredito','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCredito') and type = 'U') 
CREATE TABLE dbo.CteCredito (
	Empresa			varchar(5)		NOT NULL,
	Credito			varchar(50) 	NOT NULL,

	ConCredito	        bit		NOT NULL DEFAULT 0,
	ConLimiteCredito	bit		NOT NULL DEFAULT 0,
	LimiteCredito		money		NULL,
	ConLimitePedidos	bit		NULL 	 DEFAULT 0,
	LimitePedidos		money		NULL,
	MonedaCredito		varchar(10)  	NULL,
	ConDias			bit		NOT NULL DEFAULT 0,
	Dias			int		NULL,
        ConCondiciones		bit		NOT NULL DEFAULT 0,
	Condiciones     	varchar(255)	NULL,

	CONSTRAINT priCteCredito PRIMARY KEY  CLUSTERED (Empresa, Credito)
)
go

/****** Otros Datos Enviar a  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarAOtrosDatos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEnviarAOtrosDatos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarAOtrosDatos') and type = 'U') 
CREATE TABLE dbo.CteEnviarAOtrosDatos (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL,

	Descripcion1		varchar(50)	NULL,
	Descripcion2		varchar(50)	NULL,
	Descripcion3		varchar(50)	NULL,
	Descripcion4		varchar(50)	NULL,
	Descripcion5		varchar(50)	NULL,
	Descripcion6		varchar(50)	NULL,
	Descripcion7		varchar(50)	NULL,
	Descripcion8		varchar(50)	NULL,
	Descripcion9		varchar(50)	NULL,
	Descripcion10		varchar(50)	NULL,
	Descripcion11		varchar(50)	NULL,
	Descripcion12		varchar(50)	NULL,
	Descripcion13		varchar(50)	NULL,
	Descripcion14		varchar(50)	NULL,
	Descripcion15		varchar(50)	NULL,
	Descripcion16		varchar(50)	NULL,
	Descripcion17		varchar(50)	NULL,
	Descripcion18		varchar(50)	NULL,
	Descripcion19		varchar(50)	NULL,
	Descripcion20		varchar(50)	NULL,

	Fecha1			datetime	NULL,
	Fecha2			datetime	NULL,
	Fecha3			datetime	NULL,
	Fecha4			datetime	NULL,
	Fecha5			datetime	NULL,
	Numerico1		int		NULL,
	Numerico2		int		NULL,
	Numerico3		int		NULL,
	Numerico4		int		NULL,
	Numerico5		int		NULL,
	bit1			bit		NULL DEFAULT 0,		
	bit2			bit		NULL DEFAULT 0,		
	bit3			bit		NULL DEFAULT 0,		
	bit4			bit		NULL DEFAULT 0,		
	bit5			bit		NULL DEFAULT 0,		

	CONSTRAINT priCteEnviarAOtrosDatos PRIMARY KEY  CLUSTERED (Cliente, ID)
)
go
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Fecha1', 'datetime NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Fecha2', 'datetime NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Fecha3', 'datetime NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Fecha4', 'datetime NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Fecha5', 'datetime NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Numerico1', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Numerico2', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Numerico3', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Numerico4', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'Numerico5', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'bit1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'bit2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'bit3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'bit4', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteEnviarAOtrosDatos', 'bit5', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** Hitorico de Enviar a ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarAHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEnviarAHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarAHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteEnviarAHist (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL,
	Fecha			datetime	NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	Nombre 			varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(30) 	NULL,
	Delegacion		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	Ruta			varchar(50) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,

	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	eMailAuto		bit		NULL 		DEFAULT 0,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	Agente       		varchar(10)        NULL,

	Clase			varchar(15)	NULL,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,

	FormaEnvio		varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	Proyecto		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,
	ModificarVencimiento	varchar(10)	NULL,

	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	Contrasena		varchar(20) 	NULL,
	Clave			varchar(10)	NULL,
	SucursalEmpresa		int		NULL,
	PersonalCobrador	varchar(10)	NULL,
	Almacen			varchar(10)	NULL,
	AlmacenVtasConsignacion	varchar(10)	NULL,
	wMovVentas		varchar(20)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	TipoEmpaque		varchar(50)	NULL,
        Unidad                  varchar(50)	NULL,
	Cadena			varchar(50)	NULL,

	CONSTRAINT priCteEnviarAHist PRIMARY KEY  CLUSTERED (Cliente, ID, Fecha, RID)
  )
  EXEC spSincroSemilla 'CteEnviarAHist'
END
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE CteEnviarAHist ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE CteEnviarAHist ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE CteEnviarAHist ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
if (select version from version)<=2655
BEGIN
  EXEC("ALTER TABLE CteEnviarAHist ALTER COLUMN Estado varchar(30) NULL")
END
GO

EXEC spFK 'CteEnviarAHist','SucursalEmpresa','Sucursal','Sucursal'
EXEC spFK 'CteEnviarAHist','PersonalCobrador','Personal','Personal'
EXEC spFK 'CteEnviarAHist','Cliente','Cte','Cliente'
GO

/****** Enviar a  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarA')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEnviarA','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarA') and type = 'U') 
CREATE TABLE dbo.CteEnviarA (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL DEFAULT 0,
	Nombre 			varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(30) 	NULL,
	Delegacion		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	Ruta			varchar(50) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	eMailAuto		bit		NULL 		DEFAULT 0,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	Agente       		varchar(10)        NULL,
	Clase			varchar(15)	NULL,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,
	FormaEnvio		varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	Proyecto		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,
	ModificarVencimiento	varchar(10)	NULL,
	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,
	TieneMovimientos	bit		NULL		DEFAULT 0,
	Contrasena		varchar(20) 	NULL,
	Clave			varchar(10)	NULL,
	SucursalEmpresa		int		NULL,
	PersonalCobrador	varchar(10)	NULL,
	Almacen			varchar(10)	NULL,
	AlmacenVtasConsignacion	varchar(10)	NULL,
	wMovVentas		varchar(20)	NULL,
	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	TipoEmpaque		varchar(50)	NULL,
        Unidad                  varchar(50)	NULL,
	Cadena			varchar(50)	NULL,
	Encargado		varchar(100)	NULL,
	GLN			varchar(50)	NULL,
	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
    MapaUbicacion       varchar(100) NULL,
	FiscalRegimen		varchar(30)	NULL,
	FiscalZona			varchar(30)	NULL, --MEJORA4769	
	FueraLinea		bit		NULL	DEFAULT 0,
	GUID                    varchar(50)     NOT NULL DEFAULT NEWID(),

	CONSTRAINT priCteEnviarA PRIMARY KEY  CLUSTERED (Cliente,ID)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCteEnviarABC') and sysstat & 0xf = 8) drop trigger dbo.tgCteEnviarABC
if exists (select * from sysobjects where id = object_id('dbo.tgCteEnviarBC') and sysstat & 0xf = 8) drop trigger dbo.tgCteEnviarBC
GO
if not exists(select * from syscampo where tabla = 'CteEnviarA' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE CteEnviarA ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE CteEnviarA SET TieneMovimientos = 1")
END
GO
EXEC spALTER_TABLE 'CteEnviarA', 'Delegacion', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'Ruta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Contrasena', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Clave', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'SucursalEmpresa', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'PersonalCobrador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Almacen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'AlmacenVtasConsignacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteEnviarA', 'wMovVentas', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'TipoEmpaque', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Unidad', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Cadena', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'InstitucionFin', 'varchar(20) NULL'
GO
if (select version from version)<=2212 ALTER TABLE CteEnviarA ALTER COLUMN Contrasena varchar(20) NULL
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE CteEnviarA ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE CteEnviarA ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE CteEnviarA ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
if (select version from version)<=2655
BEGIN
  EXEC("ALTER TABLE CteEnviarA ALTER COLUMN Estado varchar(30) NULL")
END
GO
EXEC spALTER_TABLE 'CteEnviarA', 'Encargado', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'GLN', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'MapaUbicacion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'FiscalRegimen', 'varchar(30) NULL' 
GO
EXEC spALTER_TABLE 'CteEnviarA', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
EXEC spALTER_TABLE 'CteEnviarA', 'FiscalZona', 'varchar(30) NULL' --MEJORA4769
GO
-- REQ13987
Exec spAlter_Table 'CteEnviarA','GUID','varchar(50) NOT NULL DEFAULT NEWID() WITH VALUES'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'SeccionCobranzaMAVI', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'FormaPago', 'varchar(50)'
EXEC spALTER_TABLE 'CteEnviarA', 'Cuenta', 'varchar(20)'
GO

UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'CteEnviarA'
GO

EXEC spFK 'CteEnviarA','SucursalEmpresa','Sucursal','Sucursal'
EXEC spFK 'CteEnviarA','PersonalCobrador','Personal','Personal'
EXEC spFK 'CteEnviarA','Cliente','Cte','Cliente'
GO
EXEC spADD_INDEX 'CteEnviarA', 'FueraLinea', 'FueraLinea'
GO

--Integración CRM
EXEC spAlter_Table 'CteEnviarA', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CteEnviarA', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
Go

/*IF EXISTS (select * from syscampo where tabla = 'CteEnviarA') AND (SELECT Version FROM Version)<=1293
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.Temporal') and sysstat & 0xf = 3) DROP TABLE Temporal")
  EXEC("sp_rename CteEnviarA, Temporal")
  EXEC("CREATE TABLE dbo.CteEnviarA (
	Cliente 		varchar(10) 	NOT NULL,
	ID			varchar(10)	NOT NULL,

	Nombre 			varchar(100) 	NULL,
	Direccion 		varchar(100) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(30) 	NULL,
	Delegacion		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	Ruta			varchar(50) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	Agente       		char(10)        NULL,

	Clase			char(15)	NULL,
	Estatus 		char(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,

	FormaEnvio		varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	Proyecto		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,
	ModificarVencimiento	varchar(10)	NULL,

	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	Contrasena		char(10) 	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT pCteEnviarA PRIMARY KEY  CLUSTERED (Cliente,ID)
  )")
  EXEC("INSERT CteEnviarA (Cliente, ID, Nombre, Direccion, EntreCalles, Plano, Observaciones, Colonia, Delegacion, Poblacion, Estado, Pais,
                           Zona, Ruta, CodigoPostal, Telefonos, Fax, PedirTono, Contacto1, Contacto2, Extencion1, Extencion2, eMail1, eMail2,
                           ZonaImpuesto, Agente, Clase, Estatus, UltimoCambio,
                           Alta, Mensaje, FormaEnvio, ListaPreciosEsp, Proyecto, Condicion, Descuento, ModificarVencimiento, Categoria, Grupo, Familia, TieneMovimientos, Contrasena)
                    SELECT Cliente, ID, Nombre, Direccion, EntreCalles, Plano, Observaciones, Colonia, Delegacion, Poblacion, Estado, Pais,
			   Zona, Ruta, CodigoPostal, Telefonos, Fax, PedirTono, Contacto1, Contacto2, Extencion1, Extencion2, eMail1, eMail2,
			   ZonaImpuesto, Agente, Clase, Estatus, UltimoCambio,
			   Alta, Mensaje, FormaEnvio, ListaPreciosEsp, Proyecto, Condicion, Descuento, ModificarVencimiento, Categoria, Grupo, Familia, TieneMovimientos, Contrasena
                      FROM Temporal")
  EXEC("DROP TABLE Temporal")
END
*/
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CteEnviarA' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.CteEnviarA (Nombre)
GO

CREATE TRIGGER tgCteEnviarABC ON CteEnviarA
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClienteN  	varchar(10),
    @ClienteA	varchar(10),
    @IDN	int,
    @IDA	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClienteN = Cliente, @IDN = ID FROM Inserted
  SELECT @ClienteA = Cliente, @IDA = ID FROM Deleted
  
  IF @ClienteN IS NOT NULL
    INSERT CteEnviarAHist (
           Cliente, ID, Fecha,     Nombre, Direccion, EntreCalles, Plano, Observaciones, Colonia, Delegacion, Poblacion, Estado, Pais, Zona, Ruta, CodigoPostal, Telefonos, Fax, PedirTono, Contacto1, Contacto2, Extencion1, Extencion2, eMail1, eMail2, eMailAuto, ZonaImpuesto, Agente, Clase, Estatus, UltimoCambio, Alta, Mensaje, FormaEnvio, ListaPreciosEsp, Proyecto, Condicion, Descuento, ModificarVencimiento, Categoria, Grupo, Familia, TieneMovimientos, Contrasena, Clave, SucursalEmpresa, PersonalCobrador, Almacen, AlmacenVtasConsignacion, wMovVentas, Logico1, Logico2, Logico3, TipoEmpaque, Unidad, Cadena)
    SELECT Cliente, ID, GETDATE(), Nombre, Direccion, EntreCalles, Plano, Observaciones, Colonia, Delegacion, Poblacion, Estado, Pais, Zona, Ruta, CodigoPostal, Telefonos, Fax, PedirTono, Contacto1, Contacto2, Extencion1, Extencion2, eMail1, eMail2, eMailAuto, ZonaImpuesto, Agente, Clase, Estatus, UltimoCambio, Alta, Mensaje, FormaEnvio, ListaPreciosEsp, Proyecto, Condicion, Descuento, ModificarVencimiento, Categoria, Grupo, Familia, TieneMovimientos, Contrasena, Clave, SucursalEmpresa, PersonalCobrador, Almacen, AlmacenVtasConsignacion, wMovVentas, Logico1, Logico2, Logico3, TipoEmpaque, Unidad, Cadena
      FROM Inserted

  IF @ClienteA IS NOT NULL
  BEGIN
    UPDATE EmbarqueMov
       SET Ruta		= i.Ruta,
	   Nombre	= i.Nombre, 
  	   NombreEnvio  = i.Nombre, 
	   Direccion 	= i.Direccion,
	   EntreCalles	= i.EntreCalles,
	   Plano	= i.Plano,
	   Observaciones= i.Observaciones,
	   Colonia 	= i.Colonia,
	   Poblacion 	= i.Poblacion,
	   Estado 	= i.Estado,
	   Pais 	= i.Pais,
	   CodigoPostal = i.CodigoPostal,
	   Telefonos	= i.Telefonos,
	   Contacto1 	= i.Contacto1,
	   Contacto2 	= i.Contacto2,
           Extencion1 	= i.Extencion1,
           Extencion2 	= i.Extencion2
      FROM Inserted i, EmbarqueMov e
     WHERE e.Cliente = i.Cliente AND e.Cliente = @ClienteN AND e.ClienteEnviarA = @IDN AND e.Concluido = 0

    IF @ClienteN <> @ClienteA OR @IDN <> @IDA
    BEGIN
      IF @ClienteN IS NULL
        DELETE CteEnviarAOtrosDatos WHERE Cliente = @ClienteA AND ID = @IDA
      ELSE
        UPDATE CteEnviarAOtrosDatos SET Cliente = @ClienteN, ID = @IDN WHERE Cliente = @ClienteA AND ID = @IDA
    END
  END
END
GO

--Integración CRM
IF OBJECT_ID ('tr_CteEnviarA', 'TR') IS NOT NULL DROP TRIGGER tr_CteEnviarA 
GO						
/*CREATE TRIGGER tr_CteEnviarA ON CteEnviarA 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) and not UPDATE(ID) BEGIN
		update CteEnviarA  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Cliente= CteEnviarA.Cliente and i.ID=CteEnviarA.ID
	END
END
GO*/

IF OBJECT_ID ('tr_CteEnviarA_ID', 'TR') IS NOT NULL DROP TRIGGER tr_CteEnviarA_ID 
GO
/*CREATE TRIGGER tr_CteEnviarA_ID ON  CteEnviarA
--//WITH ENCRYPTION	
AFTER INSERT AS BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @id AS INT
	SET @id=1

	select @id=Max(CteEnviarA.ID)+1 from CteEnviarA where CteEnviarA.Cliente=(select Cliente from inserted)
	group by Cliente

	UPDATE CteEnviarA set ID=@id
	FROM INSERTED i
	Where i.Cliente=CteEnviarA.Cliente and i.nombre=CteEnviarA.nombre
	-- Insert statements for trigger here

END
GO*/

/****** Limite Venta (Enviar a)  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEnviarALimite')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEnviarALimite','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteEnviarALimite') and type = 'U') 
CREATE TABLE dbo.CteEnviarALimite (
	Cliente 		varchar(10) 	NOT NULL,
	EnviarA			int		NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Limite			money		NULL,
	Moneda			varchar(10)	NULL,
	Desde			datetime	NULL,
	Hasta			datetime	NULL,
	CONSTRAINT priCteEnviarALimite PRIMARY KEY  CLUSTERED (Cliente, EnviarA, ID)
)
go


/****** Categorias de Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCat')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCat') and type = 'U') 
CREATE TABLE dbo.CteCat (
	Categoria 		varchar(50) 	NOT NULL,
	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCteCat PRIMARY KEY  CLUSTERED (Categoria)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCteCatC') and sysstat & 0xf = 8) drop trigger dbo.tgCteCatC
GO

--Integración CRM
EXEC spAlter_Table 'CteCat', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CteCat', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_CteCat', 'TR') IS NOT NULL DROP TRIGGER tr_CteCat
GO									
/*CREATE TRIGGER tr_CteCat ON CteCat 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update CteCat  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Categoria= CteCat.Categoria
	END
END
GO*/

/****** Grupos de Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteGrupo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteGrupo') and type = 'U') 
CREATE TABLE dbo.CteGrupo (
	Grupo	 		varchar(50) NOT NULL,
	ACPorcentajeResidual	float		NULL,

	CONSTRAINT priCteGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCteGrupoC') and sysstat & 0xf = 8) drop trigger dbo.tgCteGrupoC
GO
EXEC spALTER_TABLE 'CteGrupo', 'ACPorcentajeResidual', 'float NULL'
GO

--Integración CRM
EXEC spAlter_Table 'CteGrupo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CteGrupo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_CteGrupo', 'TR') IS NOT NULL DROP TRIGGER tr_CteGrupo
GO									
/*CREATE TRIGGER tr_CteGrupo ON CteGrupo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update CteGrupo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Grupo= CteGrupo.Grupo
	END
END
GO*/

/****** Familias de Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteFam')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteFam') and type = 'U') 
CREATE TABLE dbo.CteFam (

	Familia 		varchar(50) 	NOT NULL ,
	FamiliaMaestra	 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priCteFam PRIMARY KEY  CLUSTERED (Familia)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCteFamC') and sysstat & 0xf = 8) drop trigger dbo.tgCteFamC
GO

--Integración CRM
EXEC spAlter_Table 'CteFam', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CteFam', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_CteFam', 'TR') IS NOT NULL DROP TRIGGER tr_CteFam 
GO									
/*CREATE TRIGGER tr_CteFam ON CteFam 
--//WITH ENCRYPTION
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update CteFam  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Familia= CteFam.Familia
	END
END
GO*/

/****** Expedientes Familiares  ******/
if not exists(select * from SysTabla where SysTabla = 'ExpedienteFamiliar')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ExpedienteFamiliar','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ExpedienteFamiliar') and type = 'U') 
CREATE TABLE dbo.ExpedienteFamiliar (
	ExpedienteFamiliar	varchar(20) 	NOT NULL ,

	Nombre			varchar(100)	NULL,

	Estatus			varchar(15)	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	CONSTRAINT priExpedienteFamiliar PRIMARY KEY  CLUSTERED (ExpedienteFamiliar)
)
go
EXEC spADD_INDEX 'ExpedienteFamiliar', 'Nombre', 'Nombre'
GO
/****** Titulos Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteTit')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteTit','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteTit') and type = 'U') 
CREATE TABLE dbo.CteTit (
	Titulo	 		varchar(20) 	NOT NULL,

	Clave			varchar(10)	NULL,

	CONSTRAINT priCteTit PRIMARY KEY  CLUSTERED (Titulo)
)
go

/****** CteRelacion  ******/
if not exists(select * from SysTabla where SysTabla = 'CteRelacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteRelacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteRelacion') and type = 'U') 
CREATE TABLE dbo.CteRelacion (
	Cliente 	varchar(10) 	NOT NULL,
	Relacion	varchar(10) 	NOT NULL,	

	CONSTRAINT priCteRelacion PRIMARY KEY  CLUSTERED (Cliente, Relacion)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CteRelacion' AND sysindexes.name = 'Relacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Relacion  ON dbo.CteRelacion (Relacion, Cliente)
go

EXEC spFK 'CteRelacion','Cliente','Cte','Cliente'
GO

/****** CteArtBloqueo  ******/
if not exists(select * from SysTabla where SysTabla = 'CteArtBloqueo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteArtBloqueo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteArtBloqueo') and type = 'U') 
CREATE TABLE dbo.CteArtBloqueo (
	Cliente 	varchar(10) 	NOT NULL,
	Agrupador	varchar(20)	NOT NULL,  -- Categoria, Grupo, Familia, Fabricante
	Nombre		varchar(50) 	NOT NULL,  -- HP

	CONSTRAINT priCteArtBloqueo PRIMARY KEY  CLUSTERED (Cliente, Agrupador, Nombre)
)
go

EXEC spFK 'CteArtBloqueo','Cliente','Cte','Cliente'
GO

/****** CteBonificacion  ******/
if not exists(select * from SysTabla where SysTabla = 'CteBonificacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteBonificacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteBonificacion') and type = 'U') 
CREATE TABLE dbo.CteBonificacion (
	Cliente 	varchar(10) 	NOT NULL,
	Concepto	varchar(50)	NOT NULL,

	Porcentaje	float	 	NULL,  
	FechaD		datetime	NULL,
	FechaA		datetime	NULL,

	CONSTRAINT priCteBonificacion PRIMARY KEY  CLUSTERED (Cliente, Concepto)
)
go
EXEC spALTER_TABLE 'CteBonificacion', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'CteBonificacion', 'FechaA', 'datetime NULL'
go


/****** Parentesco  ******/
if not exists(select * from SysTabla where SysTabla = 'Parentesco')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Parentesco','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Parentesco') and type = 'U') 
CREATE TABLE dbo.Parentesco (
	Parentesco		varchar(50) 	NOT NULL,

	CONSTRAINT priParentesco PRIMARY KEY  CLUSTERED (Parentesco)
)
go

if (select version from version)<2157 and exists (select * from sysobjects where id = object_id('dbo.CteHist') and type = 'U') 
  drop table CteHist
GO
  
/****** Hitorico de Clientes ******/
if not exists(select * from SysTabla where SysTabla = 'CteHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteHist (
	Cliente 		varchar(10) 	NOT NULL,
	Fecha			datetime	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Nombre 			varchar(100)    NULL,
	NombreCorto		varchar(20)	NULL,
	Direccion 		varchar(100) 	NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	RFC 			varchar(15)     NULL,
	CURP			varchar(30)     NULL,
	IEPS			varchar(20)     NULL,
	PITEX			varchar(20)     NULL,

	Tipo			varchar(15)	NULL,
	Situacion		varchar(50)	NULL,

	Credito			varchar(50)	NULL,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	Descuento 		varchar(30)  	NULL,
	Agente       		varchar(10)        NULL,
	AgenteServicio		varchar(10)	NULL,
	EnviarA			int		NULL,
	Proyecto		varchar(50)	NULL,
	FormaEnvio		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Ruta			varchar(50)	NULL,
	ListaPrecios		int		NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	DefMoneda		varchar(10)	NULL,
	Usuario			varchar(10)	NULL,

	NivelAcceso		varchar(50)	NULL,
	Estatus 		varchar(15) 	NULL,

	CONSTRAINT priCteHist PRIMARY KEY  CLUSTERED (Cliente, Fecha, ID)
  )
  EXEC spSincroSemilla 'CteHist'
END
go
EXEC spALTER_TABLE 'CteHist', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteHist', 'IEPS', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteHist', 'PITEX', 'varchar(20) NULL'
GO
if (select version from version)<=2473 ALTER TABLE CteHist ALTER COLUMN IEPS varchar(20) NULL
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE CteHist ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE CteHist ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE CteHist ALTER COLUMN Poblacion varchar(100) NULL")
END
GO

EXEC spFK2 'CteHist','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'CteHist','Agente','Agente','Agente'
EXEC spFK 'CteHist','Zona','Zona','Zona'
GO

/****** CteCtoGrupo  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoGrupo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoGrupo') and type = 'U') 
CREATE TABLE dbo.CteCtoGrupo (
	Grupo			varchar(50)	NOT NULL,

 	CONSTRAINT priCteCtoGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

--Integración CRM
EXEC spAlter_Table 'ctectogrupo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'ctectogrupo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

IF OBJECT_ID ('tr_ctectogrupo', 'TR') IS NOT NULL DROP TRIGGER tr_ctectogrupo 
GO									
/*CREATE TRIGGER tr_ctectogrupo ON ctectogrupo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update ctectogrupo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Grupo= ctectogrupo.Grupo
	END
END
GO*/

/****** CteCtoComites  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoComites')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoComites','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoComites') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteCtoComites (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int 		NOT NULL,
	IDR			int		NOT NULL IDENTITY(1,1),

	Comite			varchar(50)	NULL,
	SubComite		varchar(50)	NULL,
	Cargo			varchar(50)	NULL,

 	CONSTRAINT priCteCtoComites PRIMARY KEY  CLUSTERED (Cliente, ID, IDR)
  )
  EXEC spSincroSemilla 'CteCtoComites'
END
GO

if exists (select * from sysobjects where id = object_id('dbo.CteCtoComite') and type = 'U') 
BEGIN
  EXEC("INSERT CteCtoComites (Cliente, ID, Comite, Cargo) SELECT Cliente, ID, Comite, Cargo FROM CteCtoComite")
  EXEC("DROP TABLE CteCtoComite")
  EXEC("DELETE SysTabla WHERE SysTabla = 'CteCtoComite'")
END
GO

/****** CteCtoActividad  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoActividad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoActividad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoActividad') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteCtoActividad (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int 		NOT NULL,
	IDR			int		NOT NULL IDENTITY(1,1),

	Actividad		varchar(50)	NULL,

 	CONSTRAINT priCteCtoActividad PRIMARY KEY  CLUSTERED (Cliente, ID, IDR)
  )
  EXEC spSincroSemilla 'CteCtoActividad'
END
GO

/****** CteCtoDireccion  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoDireccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoDireccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoDireccion') and type = 'U') 
CREATE TABLE dbo.CteCtoDireccion (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int 		NOT NULL,
	Tipo			varchar(20)	NOT NULL,	-- Trabajo, Particular, Fiscal, Otra

	Direccion 		varchar(100) 	NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,

 	CONSTRAINT priCteCtoDireccion PRIMARY KEY  CLUSTERED (Cliente, ID, Tipo)
)
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE CteCtoDireccion ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE CteCtoDireccion ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE CteCtoDireccion ALTER COLUMN Poblacion varchar(100) NULL")
END
GO

/****** Hitorico de Contactos ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteCtoHist (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL,
	Fecha			datetime	NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	Nombre			varchar(100)	NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Atencion		varchar(50)	NULL,
	Tratamiento		varchar(20)	NULL,
	Cargo			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	FechaNacimiento		datetime	NULL,
	Telefonos		varchar(100)	NULL,
	Extencion		varchar(20)	NULL,
	eMail			varchar(100)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NULL DEFAULT 0,
	EnviarA			int		NULL,
	Tipo			varchar(20)	NULL,
	Sexo			varchar(20)	NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priCteCtoHist PRIMARY KEY  CLUSTERED (Cliente, ID, Fecha, RID)
  )
  EXEC spSincroSemilla 'CteCtoHist'
END
go

EXEC spFK2 'CteCtoHist','Cliente','EnviarA','CteEnviarA','Cliente','ID'
GO

/****** Otros Contactos del Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCto')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteCto') and type = 'U') 
CREATE TABLE dbo.CteCto (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int 		NOT NULL IDENTITY(1,1),
	Nombre			varchar(100)	NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Atencion		varchar(50)	NULL,
	Tratamiento		varchar(20)	NULL,
	Cargo			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	FechaNacimiento		datetime	NULL,
	Telefonos		varchar(100)	NULL,
	Extencion		varchar(20)	NULL,
	eMail			varchar(100)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NULL DEFAULT 0,
	EnviarA			int		NULL,
	Tipo			varchar(20)	NULL,
	Sexo			varchar(20)	NULL,
	Usuario			varchar(10)	NULL,
	CFD_Enviar		bit		NULL	DEFAULT 0,
	FueraLinea		bit		NULL	DEFAULT 0,
	--REQ 13389
	PrimaryContactId	varchar(36) NULL,

	CONSTRAINT priCteCto PRIMARY KEY  CLUSTERED (Cliente, ID)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCteCtoAC') and sysstat & 0xf = 8) drop trigger dbo.tgCteCtoAC
GO
-- Mantenimiento
EXEC spALTER_TABLE 'CteCto', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCto', 'Atencion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCto', 'Tratamiento','varchar(20)	NULL'
EXEC spALTER_TABLE 'CteCto', 'ID','int NOT NULL IDENTITY(1,1)'
EXEC spALTER_TABLE 'CteCto', 'Fax', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCto', 'PedirTono', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteCto', 'EnviarA', 'int NULL'
GO

if (select version from version) <= 2325
BEGIN
  EXEC spEliminarPK 'CteCto'
  ALTER TABLE CteCto ADD CONSTRAINT priCteCto PRIMARY KEY CLUSTERED (Cliente, ID)
END
go

EXEC spALTER_TABLE 'CteCto', 'ApellidoPaterno', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CteCto', 'ApellidoMaterno', 'varchar(30) NULL'
EXEC spALTER_TABLE 'CteCto', 'Tipo','varchar(20) NULL'
EXEC spALTER_TABLE 'CteCto', 'Sexo','varchar(20) NULL'
EXEC spALTER_TABLE 'CteCto', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteCto', 'CFD_Enviar', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ16092
EXEC spALTER_TABLE 'CteCto', 'OPORTEnviar', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ 13389
EXEC spALTER_TABLE 'CteCto', 'PrimaryContactId', 'varchar(36) NULL'
GO

EXEC spALTER_TABLE 'CteCto', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'CteCto'
GO

EXEC spADD_INDEX 'CteCto', 'FueraLinea', 'FueraLinea'
GO
EXEC spFK2 'CteCto','Cliente','EnviarA','CteEnviarA','Cliente','ID'
GO

--Integración CRM
EXEC spAlter_Table 'ctecto', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'ctecto', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

CREATE TRIGGER tgCteCtoAC ON CteCto
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  INSERT CteCtoHist (
         Cliente, ID, Fecha,     Nombre, ApellidoPaterno, ApellidoMaterno, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, EnviarA, Tipo, Sexo, Usuario)
  SELECT Cliente, ID, GETDATE(), Nombre, ApellidoPaterno, ApellidoMaterno, Atencion, Tratamiento, Cargo, Grupo, FechaNacimiento, Telefonos, Extencion, eMail, Fax, PedirTono, EnviarA, Tipo, Sexo, Usuario
    FROM Inserted
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CteCto' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.CteCto (Cliente, Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CteCto' AND sysindexes.name = 'Nombre2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre2 ON dbo.CteCto (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CteCto' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.CteCto (ID)
GO

--Integración CRM
IF OBJECT_ID ('tr_ctecto', 'TR') IS NOT NULL DROP TRIGGER tr_ctecto 
GO									
/*CREATE TRIGGER tr_ctecto ON ctecto 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update ctecto  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Cliente= ctecto.Cliente and i.ID=ctecto.ID
	END
END
GO*/


/****** Acceso Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteAcceso')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteAcceso') and type = 'U') 
CREATE TABLE dbo.CteAcceso (
	Cliente 		varchar(10) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priCteAcceso PRIMARY KEY  CLUSTERED (Cliente, Usuario)
)
go

/****** CtePedidoDef  ******/
if not exists(select * from SysTabla where SysTabla = 'CtePedidoDef')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtePedidoDef','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtePedidoDef') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CtePedidoDef (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,

	CONSTRAINT priCtePedidoDef PRIMARY KEY  CLUSTERED (Cliente, ID)
  )
  EXEC spSincroSemilla 'CtePedidoDef'
END
GO
EXEC spALTER_COLUMN 'CtePedidoDef', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'CtePedidoDef','Articulo','Art','Articulo'
GO

/****** Otros Datos Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteOtrosDatos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteOtrosDatos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteOtrosDatos') and type = 'U') 
CREATE TABLE dbo.CteOtrosDatos (
	Cliente 		varchar(10) 	NOT NULL,

	Descripcion21		varchar(50)	NULL,
	Descripcion22		varchar(50)	NULL,
	Descripcion23		varchar(50)	NULL,
	Descripcion24		varchar(50)	NULL,
	Descripcion25		varchar(50)	NULL,
	Descripcion26		varchar(50)	NULL,
	Descripcion27		varchar(50)	NULL,
	Descripcion28		varchar(50)	NULL,
	Descripcion29		varchar(50)	NULL,
	Descripcion30		varchar(50)	NULL,
	Descripcion31		varchar(50)	NULL,
	Descripcion32		varchar(50)	NULL,
	Descripcion33		varchar(50)	NULL,
	Descripcion34		varchar(50)	NULL,
	Descripcion35		varchar(50)	NULL,
	Descripcion36		varchar(50)	NULL,
	Descripcion37		varchar(50)	NULL,
	Descripcion38		varchar(50)	NULL,
	Descripcion39		varchar(50)	NULL,
	Descripcion40		varchar(50)	NULL,

	Fecha1			datetime	NULL,
	Fecha2			datetime	NULL,
	Fecha3			datetime	NULL,
	Fecha4			datetime	NULL,
	Fecha5			datetime	NULL,
	bit1			bit		NULL DEFAULT 0,		
	bit2			bit		NULL DEFAULT 0,		
	bit3			bit		NULL DEFAULT 0,		
	bit4			bit		NULL DEFAULT 0,		
	bit5			bit		NULL DEFAULT 0,		

	CONSTRAINT priCteOtrosDatos PRIMARY KEY  CLUSTERED (Cliente)
)
go
EXEC spALTER_TABLE 'CteOtrosDatos', 'Fecha1', 'datetime NULL'
EXEC spALTER_TABLE 'CteOtrosDatos', 'Fecha2', 'datetime NULL'
EXEC spALTER_TABLE 'CteOtrosDatos', 'Fecha3', 'datetime NULL'
EXEC spALTER_TABLE 'CteOtrosDatos', 'Fecha4', 'datetime NULL'
EXEC spALTER_TABLE 'CteOtrosDatos', 'Fecha5', 'datetime NULL'
EXEC spALTER_TABLE 'CteOtrosDatos', 'bit1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteOtrosDatos', 'bit2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteOtrosDatos', 'bit3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteOtrosDatos', 'bit4', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteOtrosDatos', 'bit5', 'bit NULL DEFAULT 0 WITH VALUES'
go

EXEC spFK 'CteOtrosDatos','Cliente','Cte','Cliente'
GO

/****** Eventos Clientes  ******/
if (select version from version)<=2419 and exists (select * from sysobjects where id = object_id('dbo.CteEvento') and type = 'U') 
  drop table CteEvento
GO
if not exists(select * from SysTabla where SysTabla = 'CteEvento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEvento','Cuenta')
GO
if (select version from version)<=2451 UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'CteEvento'
GO
if not exists (select * from sysobjects where id = object_id('dbo.CteEvento') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteEvento (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	EventoD			int		NULL,
	Espacio			varchar(10)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priCteEvento PRIMARY KEY  CLUSTERED (Cliente, ID)
  )
  EXEC spSincroSemilla 'CteEvento'
END
go
EXEC spALTER_TABLE 'CteEvento', 'Estatus', 'varchar(15) NULL DEFAULT "ALTA" WITH VALUES'
GO

EXEC spFK 'CteEvento','EventoD','EventoD','ID'
GO

/****** Eventos Contactos de Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCtoEvento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCtoEvento','Cuenta')
GO
if (select version from version)<=2451 UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'CteCtoEvento'
GO
if not exists (select * from sysobjects where id = object_id('dbo.CteCtoEvento') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteCtoEvento (
	Cliente 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	EventoD			int		NULL,
	Espacio			varchar(10)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priCteCtoEvento PRIMARY KEY  CLUSTERED (Cliente, ID, RID)
  )
  EXEC spSincroSemilla 'CteCtoEvento'
END
go

EXEC spFK 'CteCtoEvento','EventoD','EventoD','ID'
GO

/*** CteTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.CteTipo') and type = 'V') drop view dbo.CteTipo
GO
if not exists(select * from SysTabla where SysTabla = 'CteTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteTipo') and type = 'U') 
CREATE TABLE dbo.CteTipo (
	Tipo			varchar(20)	NOT NULL,
	Orden			int		NULL,
	INFORDescripcion	varchar(255)	NULL,
--REQ12534 Factory 	
	ReferenciaIntelisisService	varchar(50)	NULL,
	
	CONSTRAINT priCteTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

EXEC spALTER_TABLE 'CteTipo', 'INFORDescripcion',' varchar(255)  NULL'
GO

--REQ12534 Factory 
Exec spAlter_Table 'CteTipo', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--Integración CRM
EXEC spAlter_Table 'CteTipo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CteTipo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_CteTipo', 'TR') IS NOT NULL DROP TRIGGER tr_CteTipo 
GO									
/*CREATE TRIGGER tr_CteTipo ON CteTipo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update CteTipo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Tipo= CteTipo.Tipo
	END
END
GO*/

-- BUG 14106
/*** ArtTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.ArtTipo') and type = 'V') drop view dbo.ArtTipo
GO
if not exists(select * from SysTabla where SysTabla = 'ArtTipo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtTipo') and type = 'U') 
CREATE TABLE dbo.ArtTipo (
	Tipo			varchar(20)	NOT NULL,
	Orden			int		NULL,
	INFORDescripcion	varchar(255)	NULL

	CONSTRAINT priArtTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

EXEC spALTER_TABLE 'ArtTipo', 'INFORDescripcion',' varchar(255)  NULL'
GO

--Integración CRM
EXEC spAlter_Table 'arttipo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'arttipo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

IF OBJECT_ID ('tr_arttipo', 'TR') IS NOT NULL DROP TRIGGER tr_arttipo
GO									
/*CREATE TRIGGER tr_arttipo ON arttipo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update arttipo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Tipo= arttipo.Tipo
	END
END
GO*/

--REQ12534 Factory 
if exists (select * from sysobjects where id = object_id('dbo.tgInforCteTipoABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforCteTipoABC
GO
--CREATE TRIGGER tgInforCteTipoABC ON CteTipo
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Tipo    							varchar (10),
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Datos2								varchar (max),
--   @Resultado							varchar(max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @ReferenciaIntelisisService			varchar(50)	,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa
--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0 AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Tipo,ReferenciaIntelisisService
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Tipo,ReferenciaIntelisisService
--	    FROM Deleted     
--      END 
--      IF @Estatus IS NOT NULL         
--      BEGIN
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @Tipo ,@ReferenciaIntelisisService
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
--          EXEC spInforGenerarSolicitudCteTipo  @Tipo,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @Tipo,@ReferenciaIntelisisService
--		  END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END  
      
--  END
--END
--GO


/****** Telefonos Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteTel')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteTel','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteTel') and type = 'U') 
CREATE TABLE dbo.CteTel (
	Cliente 		varchar(10) 	NOT NULL,

	Telefono		varchar(15) 	NOT NULL,
	Tipo			varchar(20)	NULL,	-- Asistente, Trabajo, Trabajo 2,Fax Trabajo, Automovil, Organizacion, Particular, Particular 2, Fax Particular, Movil, Radio, Otro, Otro Fax, Localizador, Telex, Teletipo
	Lada			varchar(10)	NULL,
	Extencion		varchar(10)	NULL,
	PedirTono		bit		NULL DEFAULT 0,
	DePreferencia		bit		NULL DEFAULT 0,

	CONSTRAINT priCteTel PRIMARY KEY  CLUSTERED (Cliente, Telefono)
)
go
EXEC spALTER_TABLE 'CteTel', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CteTel', 'Extencion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteTel', 'Lada', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteTel', 'PedirTono', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CteTel', 'DePreferencia', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** UEN Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteUEN')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteUEN','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteUEN') and type = 'U') 
CREATE TABLE dbo.CteUEN (
	Cliente 		varchar(10) 	NOT NULL,
	UEN			int	 	NOT NULL,

	CreditoLimite		money		NULL,
	Condicion		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,

	CONSTRAINT priCteUEN PRIMARY KEY  CLUSTERED (Cliente, UEN)
)
go
EXEC spALTER_TABLE 'CteUEN', 'Condicion','varchar(50) NULL'
EXEC spALTER_TABLE 'CteUEN', 'Descuento','varchar(30) NULL'
go

EXEC spFK 'CteUEN','UEN','UEN','UEN'
GO

/****** Pensiones Alimenticias Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'CtePension')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtePension','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtePension') and type = 'U') 
CREATE TABLE dbo.CtePension (
	Cliente 		varchar(10) 	NOT NULL,
	Acreedor		varchar(10) 	NOT NULL,

	Porcentaje		float		NULL,

	CONSTRAINT priCtePension PRIMARY KEY  CLUSTERED (Cliente, Acreedor)
)
go

/****** CteCapacidadPago  ******/
if not exists(select * from SysTabla where SysTabla = 'CteCapacidadPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteCapacidadPago','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteCapacidadPago') and type = 'U') 
CREATE TABLE dbo.CteCapacidadPago (
	Cliente 		varchar(10) 	NOT NULL,
	Concepto		varchar(50) 	NOT NULL,

	Ingreso			money		NULL,
	Egreso			money		NULL,

	CONSTRAINT priCteCapacidadPago PRIMARY KEY  CLUSTERED (Cliente, Concepto)
)
go

/****** Presupuesto del Cliente  ******/
if not exists(select * from SysTabla where SysTabla = 'CtePresupuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CtePresupuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtePresupuesto') and type = 'U') 
CREATE TABLE dbo.CtePresupuesto (
	Cliente 		varchar(10) 	NOT NULL,
        Ejercicio               int             NOT NULL,
        Periodo                 int             NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

        EnviarA                 int             NULL,
        Familia                 varchar(50)     NULL,
	Cantidad		float		NULL,
        Importe                 money           NULL,
	ImporteAjustado		money		NULL,

	CONSTRAINT priCtePresupuesto PRIMARY KEY CLUSTERED (Cliente, Ejercicio, Periodo, ID)
)
go
EXEC spALTER_TABLE 'CtePresupuesto', 'ImporteAjustado', 'money NULL'
go

EXEC spFK2 'CtePresupuesto','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'CtePresupuesto','Cliente','Cte','Cliente'
GO

/****** Valores por Omision de Reportes  ******/
if not exists(select * from SysTabla where SysTabla = 'CteRep')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteRep','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteRep') and type = 'U') 
CREATE TABLE dbo.CteRep (
	Cliente 	varchar(10) 	NOT NULL,

	EnviarA		int	   	NULL,
	Proveedor	varchar(10)	NULL,
	Personal	varchar(10)	NULL,
	Agente  	varchar(10)   	NULL,
	VIN		varchar(20)	NULL,
	Proyecto	varchar(50)	NULL,
	UEN		int	 	NULL,
	Empresa		varchar(5)		NULL,
	Sucursal	int		NULL,
	Responsable	varchar(10)	NULL,

	CONSTRAINT priCteRep PRIMARY KEY CLUSTERED (Cliente)
)
go

EXEC spFK2 'CteRep','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'CteRep','Cliente','Cte','Cliente'
EXEC spFK 'CteRep','Proveedor','Prov','Proveedor'
EXEC spFK 'CteRep','Personal','Personal','Personal'
EXEC spFK 'CteRep','Agente','Agente','Agente'
EXEC spFK 'CteRep','VIN','VIN','VIN'
EXEC spFK 'CteRep','Proyecto','Proy','Proyecto'
EXEC spFK 'CteRep','UEN','UEN','UEN'
EXEC spFK 'CteRep','Sucursal','Sucursal','Sucursal'
GO


/****** CteDepto  ******/
if not exists(select * from SysTabla where SysTabla = 'CteDepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteDepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteDepto') and type = 'U') 
CREATE TABLE dbo.CteDepto (
	Cliente 		varchar(10) 	NOT NULL,
	Departamento		int		NOT NULL,

	Clave			varchar(20)	NULL,
	Nombre			varchar(100)	NULL,
	Contacto		varchar(100)	NULL,

	CONSTRAINT priCteDepto PRIMARY KEY  CLUSTERED (Cliente, Departamento)
)
go

EXEC spDROP_TABLE 'PersonalFamilia'
GO
/****** PersonalFamilia  ******/
/*if not exists(select * from SysTabla where SysTabla = 'PersonalFamilia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalFamilia','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalFamilia') and type = 'U') 
CREATE TABLE dbo.PersonalFamilia (
	Familia			varchar(10) 	NOT NULL,

	Nombre			varchar(100)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priPersonalFamilia PRIMARY KEY  CLUSTERED (Familia)
)*/
go
--EXEC spADD_INDEX 'PersonalFamilia', 'Nombre', 'Nombre'
GO
/****** CteMapeoMov  ******/
if not exists(select * from SysTabla where SysTabla = 'CteMapeoMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteMapeoMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteMapeoMov') and type = 'U') 
CREATE TABLE dbo.CteMapeoMov (
	Cliente 		varchar(10) 	NOT NULL,
	MovOrigen		varchar(20)	NOT NULL,

	MovDestino		varchar(20)	NULL,

	CONSTRAINT priCteMapeoMov PRIMARY KEY  CLUSTERED (Cliente, MovOrigen)
)
go

/****** CteDeptoEnviarA  ******/
if exists (select * from sysobjects where id = object_id('dbo.CteDeptoEnviarA') and type = 'U') 
  if not exists(select * from syscampo where tabla = 'CteDeptoEnviarA' and campo = 'Empresa')
    drop table CteDeptoEnviarA 
go

if not exists(select * from SysTabla where SysTabla = 'CteDeptoEnviarA')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteDeptoEnviarA','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteDeptoEnviarA') and type = 'U') 
CREATE TABLE dbo.CteDeptoEnviarA (
	Cliente 		varchar(10) 	NOT NULL,
	Departamento		int		NOT NULL,
	Empresa			varchar(5)		NOT NULL,
	EnviarA			int		NOT NULL,
	
	ProveedorID		varchar(20)	NULL,

	CONSTRAINT priCteDeptoEnviarA PRIMARY KEY  CLUSTERED (Cliente, Departamento, Empresa, EnviarA)
)
go

EXEC spFK2 'CteDeptoEnviarA','Cliente','EnviarA','CteEnviarA','Cliente','ID'
GO

/****** CteEntregaMercancia ******/
if not exists (select * from SysTabla where SysTabla = 'CteEntregaMercancia') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEntregaMercancia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteEntregaMercancia') and type = 'U') 

CREATE TABLE dbo.CteEntregaMercancia (
	Cliente 		char(10) 	NOT NULL,
	EntregaMercancia	varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,


	CONSTRAINT priCteEntregaMercancia PRIMARY KEY  CLUSTERED (Cliente, EntregaMercancia)
)
GO

/****** Hasp ******/
if not exists(select * from SysTabla where SysTabla = 'Hasp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Hasp','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Hasp') and type = 'U') 
CREATE TABLE dbo.Hasp (
	ID			int		NOT NULL,

	Tipo			varchar(20)	NULL,
	Cliente 		varchar(10) 	NULL,

	Fabricacion		datetime	NULL,
	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	Licencias1		int		NULL,
	Licencias2		int		NULL,
	Estatus			varchar(15)	NULL,
	Observaciones		varchar(255)	NULL,
	Datos			text		NULL,
	
	ClienteN 		varchar(10) 	NULL,
	FabricacionN		datetime	NULL,
	VencimientoN		datetime	NULL,
	MantenimientoN		datetime	NULL,
	Licencias1N 		int		NULL,
	Licencias2N		int		NULL,
	EstatusN		varchar(15)	NULL,
	ObservacionesN		varchar(255)	NULL,
	UltimoCambio		datetime	NULL,
	UsuarioCambio		varchar(10)	NULL,

	Situacion		varchar(50)	NULL,
	SituacionNota		varchar(100)	NULL,
	FechaAutorizacion	datetime	NULL,
	UsuarioAutorizacion	varchar(10)	NULL,

	CONSTRAINT priHasp PRIMARY KEY  CLUSTERED (ID)
)
go
EXEC spALTER_TABLE 'Hasp', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Hasp', 'ClienteN', 'varchar(10) NULL'
go
EXEC spADD_INDEX 'Hasp', 'Cliente', 'Cliente'
GO

EXEC spFK 'Hasp','Cliente','Cte','Cliente'
GO

/****** Zonas ******/
if not exists(select * from SysTabla where SysTabla = 'Zona')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Zona','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Zona') and type = 'U') 
CREATE TABLE dbo.Zona (
	Zona 			varchar(30) 	NOT NULL,

	Ruta			varchar(50)	NULL,
	Tipo  			varchar(50)	NULL,
	OrdenEmbarque 		int 		NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priZona PRIMARY KEY  CLUSTERED (Zona)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgZonaBC') and sysstat & 0xf = 8) drop trigger dbo.tgZonaBC
GO
EXEC spALTER_TABLE 'Zona', 'Porcentaje', 'float	NULL'
GO
CREATE TRIGGER tgZonaBC ON Zona
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ZonaN  	varchar(50),
    @ZonaA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ZonaN = Zona FROM Inserted
  SELECT @ZonaA = Zona FROM Deleted
  IF @ZonaN = @ZonaA RETURN

  IF @ZonaN IS NULL AND 
    EXISTS(SELECT * FROM Cte WHERE Zona = @ZonaA) OR 
    EXISTS(SELECT * FROM CteEnviarA WHERE Zona = @ZonaA) OR
    EXISTS(SELECT * FROM Ruta WHERE Zona = @ZonaA)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(@ZonaA))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30155
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
  IF @ZonaA IS NOT NULL 
  BEGIN
    UPDATE Cte SET Zona = @ZonaN WHERE Zona = @ZonaA
    UPDATE CteEnviarA SET Zona = @ZonaN WHERE Zona = @ZonaA
    UPDATE Ruta SET Zona = @ZonaN WHERE Zona = @ZonaA
  END
END
GO

/****** CteEstadoFinancieroMayor  ******/
if not exists(select * from SysTabla where SysTabla = 'CteEstadoFinancieroMayor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEstadoFinancieroMayor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteEstadoFinancieroMayor') and type = 'U') 
  CREATE TABLE dbo.CteEstadoFinancieroMayor (
	Mayor		int		NOT NULL,

	Grupo		varchar(100)	NULL,
	SubGrupo	varchar(100)	NULL,

	CONSTRAINT priCteEstadoFinancieroMayor PRIMARY KEY  CLUSTERED (Mayor)
)
go
if not exists(select * from CteEstadoFinancieroMayor)
BEGIN
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (0, NULL, NULL)

  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (11, 'Activo', 'Circulante')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (12, 'Activo', 'Fijo')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (13, 'Activo', 'Diferido')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (21, 'Pasivo', 'Circulante')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (22, 'Pasivo', 'Largo Plazo')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (31, 'Capital', 'Capital')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (32, 'Capital', 'Ejercicios Anteriores')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (40, 'Resultado', NULL)
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (41, 'Resultado', 'Ingresos')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (42, 'Resultado', 'Costos')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (43, 'Resultado', 'Gastos')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (44, 'Resultado', 'Gastos Financieros')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (45, 'Resultado', 'Otros Productos')
  insert CteEstadoFinancieroMayor (Mayor, Grupo, SubGrupo) VALUES (46, 'Resultado', 'Impuestos')
END
GO
-- delete CteEstadoFinancieroMayor
-- select * from CteEstadoFinancieroMayor

/****** CteEstadoFinanciero  ******/
if exists (select * from sysobjects where id = object_id('dbo.CteEstadoFinanciero') and type = 'U') and (select version from version)<=1456 
 drop table dbo.CteEstadoFinanciero
GO
if not exists(select * from SysTabla where SysTabla = 'CteEstadoFinanciero')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteEstadoFinanciero','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CteEstadoFinanciero') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CteEstadoFinanciero (
	Cliente 	varchar(10) 	NOT NULL,
	Ejercicio	int		NOT NULL,	
	ID		int		NOT NULL	IDENTITY(1,1),

	Reporte		varchar(100)	NULL,
	Mayor		int		NULL,
	Cuenta		varchar(100)	NULL,
	SaldoDeudor	money		NULL,
	SaldoAcreedor	money		NULL,
	Importe		money		NULL,
	Razones		float		NULL,

	CONSTRAINT priCteEstadoFinanciero PRIMARY KEY  CLUSTERED (Cliente, Ejercicio, ID)
  )
  EXEC spSincroSemilla 'CteEstadoFinanciero'
END
go

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
	
	CONSTRAINT priCteCFD PRIMARY KEY  CLUSTERED (Cliente)
)
go
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
GO
EXEC spDROP_COLUMN 'CteCFD', 'QuitarNamespace'
go

IF EXISTS(SELECT * FROM sysTabla WHERE SysTabla = 'CFD') AND NOT EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'CFD' AND Campo = 'Fecha')
  DROP TABLE dbo.CFD
GO


/****** UsoServicio ******/
if not exists(select * from SysTabla where SysTabla = 'UsoServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsoServicio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsoServicio') and type = 'U') 
CREATE TABLE dbo.UsoServicio (
	Servicio		varchar(100)	NOT NULL,

	CONSTRAINT priUsoServicio PRIMARY KEY  CLUSTERED (Servicio)
)
go


/****** CteUsoServicio ******/
if not exists(select * from SysTabla where SysTabla = 'CteUsoServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CteUsoServicio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CteUsoServicio') and type = 'U') 
CREATE TABLE dbo.CteUsoServicio (
	Cliente 		varchar(10) 	NOT NULL,
	Servicio		varchar(100)	NOT NULL,

	Fecha			datetime	NULL,
	Porcentaje		float		NULL,
	Evaluacion		varchar(50) 	NULL,
	Observaciones		varchar(255)	NULL,

	CONSTRAINT priCteUsoServicio PRIMARY KEY  CLUSTERED (Cliente, Servicio)
)
go


/****** Clientes  ******/
if not exists(select * from SysTabla where SysTabla = 'Cte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Cte','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Cte') and type = 'U') 
CREATE TABLE dbo.Cte (
	Cliente 		varchar(10) 	NOT NULL,
	Rama			varchar(10)	NULL,

	Nombre 			varchar(100)    NULL,
	NombreCorto		varchar(20)	NULL,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	RFC 			varchar(15)     NULL,
	IEPS			varchar(20)     NULL,
	PITEX			varchar(20)     NULL,
	CURP			varchar(30)     NULL,
	Telefonos		varchar(100) 	NULL,
	TelefonosLada		varchar(6)	NULL,
	Fax 			varchar(50) 	NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
	Extencion1	        varchar(10)     NULL,
	Extencion2		varchar(10) 	NULL,
	eMail1			varchar(50)     NULL,
	eMail2			varchar(50) 	NULL,
	DirInternet		varchar(50) 	NULL,
	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,
	Credito			varchar(50)	NULL,
	DiaRevision1 		varchar(10)  	NULL,
	DiaRevision2 		varchar(10)  	NULL,
	HorarioRevision		varchar(50) 	NULL,
	DiaPago1 		varchar(10)  	NULL,
	DiaPago2 		varchar(10)  	NULL,
	HorarioPago		varchar(50) 	NULL,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	PedidosParciales	bit		NOT NULL DEFAULT 1,
	Tipo			varchar(15)	NULL     DEFAULT 'Cliente',
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Descuento 		varchar(30)  	NULL,
	Agente       		varchar(10)        NULL,
	AgenteServicio		varchar(10)	NULL,
	Agente3			varchar(10)	NULL,
	Agente4			varchar(10)	NULL,
	EnviarA			int		NULL,
	Proyecto		varchar(50)	NULL,
	FormaEnvio		varchar(50)	NULL,
	Condicion		varchar(50)	NULL,
	Ruta			varchar(50)	NULL,
	RutaOrden		int		NULL,
	ListaPrecios		int		NULL	 DEFAULT 1,
	ListaPreciosEsp		varchar(20)	NULL,
	DefMoneda		varchar(10)	NULL,

	VtasConsignacion	bit		NOT NULL DEFAULT 0,
	AlmacenVtasConsignacion	varchar(10)	NULL,

	Clase			varchar(15)	NULL,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	Numero			int		NULL,

	Contrasena		varchar(20) 	NULL,
	Contrasena2		varchar(20) 	NULL,
	wVerDisponible		bit		NULL		DEFAULT 0,
	wVerArtListaPreciosEsp	bit		NULL		DEFAULT 0,

	ChecarCredito		varchar(20)	NULL		DEFAULT '(Empresa)',
	BloquearMorosos		varchar(20)	NULL		DEFAULT '(Empresa)',
	ModificarVencimiento	varchar(10)	NULL 		DEFAULT '(Empresa)',

	CreditoEspecial         bit		NOT NULL 	DEFAULT 0,
	CreditoConLimite	bit		NOT NULL 	DEFAULT 0,
	CreditoLimite		money		NULL,
	CreditoConLimitePedidos	bit		NULL 		DEFAULT 0,
	CreditoLimitePedidos	money		NULL,
	CreditoMoneda		varchar(10)  	NULL,
	CreditoConDias		bit		NOT NULL 	DEFAULT 0,
	CreditoDias		int		NULL,
        CreditoConCondiciones	bit		NOT NULL 	DEFAULT 0,
	CreditoCondiciones     	varchar(50)	NULL,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	Cobrador 		varchar(50)   	NULL,
	PersonalCobrador	varchar(10)	NULL,
	DescuentoRecargos	bit		NULL		DEFAULT 0,
	RecorrerVencimiento	varchar(20) 	NULL 		DEFAULT 'No',
	AlmacenDef		varchar(10)	NULL,

	SucursalEmpresa		int		NULL,
	NivelAcceso		varchar(50)	NULL,
	Idioma			varchar(50)	NULL,
	BonificacionTipo	varchar(20)	NULL		DEFAULT 'No',
	Bonificacion		float		NULL,
	VigenciaDesde		datetime	NULL,
	VigenciaHasta		datetime	NULL,
	
	Descripcion1		varchar(50)	NULL,
	Descripcion2		varchar(50)	NULL,
	Descripcion3		varchar(50)	NULL,
	Descripcion4		varchar(50)	NULL,
	Descripcion5		varchar(50)	NULL,
	Descripcion6		varchar(50)	NULL,
	Descripcion7		varchar(50)	NULL,
	Descripcion8		varchar(50)	NULL,
	Descripcion9		varchar(50)	NULL,
	Descripcion10		varchar(50)	NULL,
	Descripcion11		varchar(50)	NULL,
	Descripcion12		varchar(50)	NULL,
	Descripcion13		varchar(50)	NULL,
	Descripcion14		varchar(50)	NULL,
	Descripcion15		varchar(50)	NULL,
	Descripcion16		varchar(50)	NULL,
	Descripcion17		varchar(50)	NULL,
	Descripcion18		varchar(50)	NULL,
	Descripcion19		varchar(50)	NULL,
	Descripcion20		varchar(50)	NULL,

	FormasPagoRestringidas	bit		NULL		DEFAULT 0,
	PreciosInferioresMinimo	bit		NULL		DEFAULT 0,
	CBDir			varchar(255)	NULL,

	PersonalNombres		varchar(50)	NULL,
	PersonalApellidoPaterno	varchar(50)	NULL,
	PersonalApellidoMaterno	varchar(50)	NULL,
	PersonalDireccion 	varchar(100) 	NULL,
	PersonalEntreCalles	varchar(100) 	NULL,
	PersonalPlano		varchar(15)     NULL,
	PersonalDelegacion	varchar(100) 	NULL,
	PersonalColonia 	varchar(100) 	NULL,
	PersonalPoblacion 	varchar(100) 	NULL,
	PersonalEstado 		varchar(30) 	NULL,
	PersonalPais 		varchar(30)     NULL,
	PersonalZona 		varchar(30) 	NULL,
	PersonalCodigoPostal 	varchar(15) 	NULL,
	PersonalTelefonos	varchar(100)	NULL,
	PersonalTelefonosLada	varchar(6)	NULL,
	PersonalTelefonoMovil	varchar(30)	NULL,
	PersonalSMS		bit		NULL		DEFAULT 0,
	FechaNacimiento 	datetime	NULL,
	Titulo			varchar(20)	NULL,
        EstadoCivil		varchar(20)	NULL,
	FechaMatrimonio 	datetime	NULL,
	Conyuge			varchar(100)	NULL,
	Sexo			varchar(20)	NULL,
	Fuma			bit		NULL		DEFAULT 0,
	Profesion		varchar(100)	NULL,
	Puesto			varchar(100)	NULL,
	NumeroHijos		int		NULL,
	Alergias		varchar(255)	NULL,
	Religion		varchar(50)	NULL,
	Responsable		varchar(100)	NULL,
	Parentesco		varchar(50)	NULL,
	FacturarCte		varchar(10)	NULL,
	FacturarCteEnviarA	int		NULL,

	Aseguradora		varchar(10)	NULL,
	NombreAsegurado		varchar(100)	NULL,
	PolizaTipo		varchar(50)	NULL,
	PolizaNumero		varchar(20)	NULL,
	PolizaReferencia	varchar(50)	NULL,
	PolizaImporte		money		NULL,
	Deducible		money		NULL,
	DeducibleMoneda		varchar(10)	NULL,
	Coaseguro		float		NULL,

	Espacio			varchar(10)	NULL,
	OtrosCargos		varchar(50)	NULL,
	Flotilla		bit		NULL	DEFAULT 0,
	FordDistribuidor	varchar(10)	NULL,
	FordZona		varchar(30)	NULL,
	ExcentoISAN        	bit		NULL	DEFAULT 0,

	CRMImporte		money		NULL,
	CRMCantidad		float		NULL,
	CRMEtapa		varchar(20)	NULL,
	CRMCierreProbabilidad	float		NULL,
	CRMCierreFechaAprox	datetime	NULL,
	CRMPresupuestoAsignado	money		NULL,
	CRMCompetencia		varchar(50)	NULL,
	CRMInfluencia		varchar(50)	NULL,
	CRMFuente		varchar(50)	NULL,

	Fecha1			datetime	NULL,
	Fecha2			datetime	NULL,
	Fecha3			datetime	NULL,
	Fecha4			datetime	NULL,
	Fecha5			datetime	NULL,

	EsProveedor		bit		NULL	DEFAULT 0,
	EsPersonal		bit		NULL	DEFAULT 0,
	EsAgente		bit		NULL	DEFAULT 0,
	EsAlmacen		bit		NULL	DEFAULT 0,
	EsEspacio		bit		NULL	DEFAULT 0,
	EsCentroCostos		bit		NULL	DEFAULT 0,
	EsProyecto		bit		NULL	DEFAULT 0,
	EsCentroTrabajo		bit		NULL	DEFAULT 0,
	EsEstacionTrabajo	bit		NULL	DEFAULT 0,
	Usuario			varchar(10)	NULL,

	Licencias		int		NULL,
	LicenciasTipo		varchar(20)	NULL,
	LicenciasLlave		varchar(50)	NULL,

	Cuenta			varchar(20)	NULL,
	CuentaRetencion		varchar(20)	NULL,
	FiscalRegimen		varchar(30)	NULL,
	FiscalZona			varchar(30)	NULL, --MEJORA4769	
	PedidoDef		bit		NULL	DEFAULT 0,
	eMailAuto		bit		NULL 	DEFAULT 0,
	wMovVentas		varchar(20)	NULL,
	Intercompania		bit		NULL	DEFAULT 0,
	Publico			bit		NULL	DEFAULT 0,
	CRMovVenta		varchar(20)	NULL	DEFAULT '(Empresa)',
	Extranjero		bit		NULL	DEFAULT 0,
	DocumentacionCompleta	bit		NULL	DEFAULT 0,
	OperacionLimite		money		NULL,

	ImportadorRegimen	varchar(30)	NULL,
	ImportadorRegistro	varchar(30)	NULL,

	LocalidadCNBV		varchar(10)	NULL,
	ActividadEconomicaCNBV	varchar(10)	NULL,
	Grado			varchar(10)	NULL,
	GLN			varchar(50)	NULL,
	InterfacturaRI		varchar(10)	NULL,
	EDIIdentificador	varchar(10)	NULL,
	EDICalificador		varchar(10)	NULL,
	ProveedorClave		varchar(20)	NULL,
	ProveedorInfo		varchar(50)	NULL,

	RPU			varchar(12)	NULL,
	SIRAC			varchar(10)	NULL,

	IFE			varchar(15)	NULL,
	Pasaporte		varchar(15)	NULL,
	GrupoSanguineo		varchar(2)	NULL,
	GrupoSanguineoRH	varchar(10)	NULL,	
	Peso			float		NULL,
	Estatura		float		NULL,
	Comentarios		text		NULL,
--	PersonalFamilia		varchar(10)	NULL,

	PolizaFechaEmision	datetime	NULL,
	PolizaVencimiento	datetime	NULL,
	NotificarA		varchar(100)	NULL,
	NoriticarATelefonos	varchar(100)	NULL,
	ExpedienteFamiliar	varchar(20)	NULL,
	SIC			varchar(10)	NULL,
	ReferenciaBancaria	varchar(50)	NULL,

	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
    MapaUbicacion       varchar(100)NULL,
	
	FueraLinea		bit		NULL	DEFAULT 0,

	TipoRegistro		varchar(20)	NULL,
	
	FiscalGenerar		bit			NULL DEFAULT 1,

	ContactoTipo		varchar(20) NULL DEFAULT 'Cliente',
 --REQ12534 Factory  	
    ReferenciaIntelisisService	varchar(50)	NULL,
	
	--REQ12615 WMS
	DefPosicionRecibo	varchar(10)	NULL,
	DefPosicionSurtido	varchar(10)	NULL,
	TarimasChep			bit			NULL DEFAULT 0,

	--REQ 13389
	CRMID				varchar(36) NULL,
	SincronizarCRM		bit			NULL DEFAULT 0,
	PrimaryContactId	varchar(36) NULL,
	TemaCRM				varchar(30) NULL,

	CONSTRAINT priCte PRIMARY KEY  CLUSTERED (Cliente)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgCteAC') and sysstat & 0xf = 8) drop trigger dbo.tgCteAC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCteBC') and sysstat & 0xf = 8) drop trigger dbo.tgCteBC
GO
if not exists(select * from syscampo where tabla = 'Cte' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Cte ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Cte SET TieneMovimientos = 1")
END
GO
if not exists(select * from syscampo where tabla = 'Cte' and Campo='Cobrador')
  ALTER TABLE Cte ADD Cobrador varchar(50) NULL
GO
EXEC spALTER_TABLE 'Cte', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'DescuentoRecargos', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=1233
BEGIN
  EXEC("ALTER TABLE Cte ALTER COLUMN HorarioRevision  varchar(50) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN HorarioPago      varchar(50) NULL")
END
if exists(select * from syscampo where tabla = 'Cte' and Campo='Registro2') and not exists(select * from syscampo where tabla = 'Cte' and Campo='CURP')
  EXEC sp_rename 'Cte.Registro2', 'CURP', 'COLUMN'  
GO
EXEC spSincroNivelRegistroCampos 'Cte'
GO
EXEC spALTER_TABLE 'Cte', 'RecorrerVencimiento','varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'SucursalEmpresa', 'int NULL'
EXEC spALTER_TABLE 'Cte', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'wVerDisponible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'Idioma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Bonificacion', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'VigenciaDesde', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'VigenciaHasta', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion4', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion5', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion6', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion7', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion8', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion9', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion10', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion11', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion12', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion13', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion14', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion15', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion16', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion17', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion18', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion19', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Descripcion20', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'BonificacionTipo', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'AlmacenDef', 'char(10) NULL'
EXEC spALTER_TABLE 'Cte', 'CBDir', 'varchar(255) NULL'

EXEC spALTER_TABLE 'Cte', 'PersonalNombres', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalApellidoPaterno', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalApellidoMaterno', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalDireccion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalEntreCalles', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalPlano', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalDelegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalColonia', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalPoblacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalEstado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalPais', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalZona', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalCodigoPostal', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalTelefonos', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalTelefonoMovil', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'FechaNacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Titulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'EstadoCivil', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'FechaMatrimonio', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Conyuge', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'Sexo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'Fuma', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'Profesion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'Puesto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'NumeroHijos', 'int NULL'
EXEC spALTER_TABLE 'Cte', 'Alergias', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Cte', 'Religion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Responsable', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'Parentesco', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'FacturarCte', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'FacturarCteEnviarA', 'int NULL'

EXEC spALTER_TABLE 'Cte', 'Aseguradora', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'NombreAsegurado', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'PolizaTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PolizaNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'PolizaReferencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PolizaImporte', 'money NULL'
EXEC spALTER_TABLE 'Cte', 'Deducible', 'money NULL'
EXEC spALTER_TABLE 'Cte', 'DeducibleMoneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Coaseguro', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'OtrosCargos', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'wVerArtListaPreciosEsp', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--REQ 13389
EXEC spALTER_TABLE 'Cte', 'CRMID', 'varchar(36) NULL'
EXEC spALTER_TABLE 'Cte', 'SincronizarCRM', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'PrimaryContactId', 'varchar(36) NULL'
EXEC spALTER_TABLE 'Cte', 'TemaCRM', 'varchar(30) NULL'
GO
EXEC spEliminarPK 'Cte'
ALTER TABLE Cte ADD CONSTRAINT priCte PRIMARY KEY CLUSTERED (Cliente)
GO
if (select version from version)<=1382
  update Cte SET BonificacionTipo = 'Directa' WHERE NULLIF(Bonificacion, 0) IS NOT NULL
GO
EXEC spALTER_TABLE 'Cte', 'FormasPagoRestringidas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'PersonalCobrador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'CRMImporte', 'money NULL'
EXEC spALTER_TABLE 'Cte', 'CRMCantidad', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'CRMEtapa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'CRMCierreProbabilidad', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'CRMCierreFechaAprox', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'CRMPresupuestoAsignado', 'money NULL'
EXEC spALTER_TABLE 'Cte', 'CRMCompetencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'CRMInfluencia', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Cte', 'CRMFuente', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Contrasena2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'Flotilla', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'FordDistribuidor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'ExcentoISAN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'Fecha1', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Fecha2', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Fecha3', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Fecha4', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'Fecha5', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'EsProveedor', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsAgente', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsAlmacen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsEspacio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsCentroCostos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsProyecto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsCentroTrabajo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'EsEstacionTrabajo','bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'Usuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Licencias', 'int NULL'
EXEC spALTER_TABLE 'Cte', 'LicenciasTipo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Cte', 'LicenciasLlave', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'CuentaRetencion', 'varchar(20) NULL'
GO
if (select version from version)<=2212
BEGIN
  ALTER TABLE Cte ALTER COLUMN Contrasena  varchar(20) NULL
  ALTER TABLE Cte ALTER COLUMN Contrasena2 varchar(20) NULL
END
GO
EXEC spALTER_TABLE 'Cte', 'PreciosInferioresMinimo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'FiscalRegimen', 'varchar(30)	NULL'
EXEC spALTER_TABLE 'Cte', 'FordZona', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'PedidoDef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'RutaOrden', 'int NULL'
EXEC spALTER_TABLE 'Cte', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'TelefonosLada', 'varchar(6) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalTelefonosLada', 'varchar(6) NULL'
EXEC spALTER_TABLE 'Cte', 'IEPS', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'PITEX', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'wMovVentas', 'varchar(20) NULL'
GO
if exists(select * from syscampo where tabla = 'Cte' and campo ='eCollaboration') EXEC sp_rename 'Cte.eCollaboration', 'Intercompania', 'COLUMN'
GO
if (select version from version)<=2473 ALTER TABLE Cte ALTER COLUMN IEPS varchar(20) NULL
if (select version from version)<=2507 ALTER TABLE Cte ALTER COLUMN FordZona varchar(30) NULL
GO
EXEC spALTER_TABLE 'Cte', 'Intercompania', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'Agente3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Agente4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Publico', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Cte ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN Poblacion varchar(100) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN PersonalColonia varchar(100) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN PersonalDelegacion varchar(100) NULL")
  EXEC("ALTER TABLE Cte ALTER COLUMN PersonalPoblacion varchar(100) NULL")
END
GO
if (select version from version)<=2677
  EXEC("ALTER TABLE Cte ALTER COLUMN FiscalRegimen varchar(30) NULL")
GO
EXEC spALTER_TABLE 'Cte', 'Extranjero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'DocumentacionCompleta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'OperacionLimite','money NULL'
EXEC spALTER_TABLE 'Cte', 'CRMovVenta', 'varchar(20) NULL DEFAULT "(Empresa)" WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'ImportadorRegimen', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'ImportadorRegistro', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Cte', 'LocalidadCNBV', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Cte', 'ActividadEconomicaCNBV', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Grado', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Cte', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'GLN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'PersonalSMS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cte', 'InterfacturaRI', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'EDIIdentificador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'EDICalificador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'ProveedorClave', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'ProveedorInfo', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Cte', 'RPU', 'varchar(12) NULL'
EXEC spALTER_TABLE 'Cte', 'SIRAC', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Cte', 'IFE', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Cte', 'Pasaporte', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Cte', 'GrupoSanguineo', 'varchar(2)	NULL'
EXEC spALTER_TABLE 'Cte', 'GrupoSanguineoRH', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'Peso', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'Estatura', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'Comentarios', 'text NULL'
GO
EXEC spDROP_COLUMN 'Cte', 'PersonalFamilia'
GO
EXEC spALTER_TABLE 'Cte', 'PolizaFechaEmision', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'PolizaVencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'NotificarA', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'NoriticarATelefonos', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cte', 'ExpedienteFamiliar', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cte', 'SIC', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cte', 'ReferenciaBancaria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Cte', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'Cte', 'MapaUbicacion', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'Cte', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'Cte'
GO
EXEC spALTER_TABLE 'Cte', 'TipoRegistro', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'Cte', 'FiscalGenerar', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'Cte', 'FiscalZona', 'varchar(30) NULL' --MEJORA4769
GO
EXEC spALTER_TABLE 'Cte', 'ContactoTipo', 'varchar(20) NULL DEFAULT "Cliente" WITH VALUES'
GO
 --REQ12534 Factory  
Exec spAlter_Table 'Cte', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Cte','DefPosicionRecibo','varchar(10) NULL'
EXEC spALTER_TABLE 'Cte','DefPosicionSurtido ','varchar(10) NULL'
EXEC spALTER_TABLE 'Cte','TarimasChep', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Rama' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Rama      ON dbo.Cte (Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre    ON dbo.Cte (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'NombreCorto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NombreCorto ON dbo.Cte (NombreCorto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Tipo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tipo      ON dbo.Cte (Tipo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria ON dbo.Cte (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'RFC' AND sysobjects.id = sysindexes.id)
  CREATE INDEX RFC       ON dbo.Cte (RFC)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Numero' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Numero    ON dbo.Cte (Numero)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente ON dbo.Cte (Agente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Contacto1' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Contacto1 ON dbo.Cte (Contacto1)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Contacto2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Contacto2 ON dbo.Cte (Contacto2)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'DescuentoRecargos' AND sysobjects.id = sysindexes.id)--Bug 21604
  CREATE INDEX DescuentoRecargos ON Cte(Cliente)INCLUDE(DescuentoRecargos)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cte' AND sysindexes.name = 'Nombre2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre2 ON Cte(Cliente)INCLUDE(Nombre)
go

EXEC spADD_INDEX 'Cte', 'ReferenciaBancaria', 'ReferenciaBancaria'
EXEC spADD_INDEX 'Cte', 'FueraLinea', 'FueraLinea'
GO

EXEC spFK 'Cte','Zona','Zona','Zona' 
EXEC spFK 'Cte','SucursalEmpresa','Sucursal','Sucursal'
EXEC spFK 'Cte','Cuenta','Cta','Cuenta' 
EXEC spFK 'Cte','LocalidadCNBV','LocalidadCNBV','LocalidadCNBV'
EXEC spFK 'Cte','ActividadEconomicaCNBV','ActividadEconomicaCNBV','ActividadEconomicaCNBV'
EXEC spFK 'Cte','ExpedienteFamiliar','ExpedienteFamiliar','ExpedienteFamiliar'
EXEC spFK 'Cte','Agente','Agente','Agente'
EXEC spFK 'Cte','PersonalCobrador','Personal','Personal'
GO

--Integración MES
--EXEC spALTER_TABLE 'Cte', 'MES', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--EXEC spDROP_COLUMN 'Cte', 'MES'
--GO

--Integración CRM
EXEC spAlter_Table 'Cte', 'CRMObjectId', 'uniqueidentifier NULL'
GO

CREATE TRIGGER tgCteAC ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
DECLARE 
    @RFCNuevo		varchar(20),
    @RegistroDup	varchar(50),
    @ClaveNueva  	varchar(10),
    @ClienteDup  	varchar(10),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN

  SELECT @RFCNuevo = RFC, @ClaveNueva = Cliente FROM Inserted


  IF UPDATE(Nombre) OR UPDATE(NombreCorto) OR UPDATE(Direccion) OR UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(Poblacion) OR
     UPDATE(Estado) OR UPDATE(Pais) OR UPDATE(Zona) OR UPDATE(CodigoPostal) OR UPDATE(RFC) OR UPDATE(CURP) OR UPDATE(IEPS) OR UPDATE(PITEX) OR UPDATE(Tipo) OR
     UPDATE(Situacion) OR UPDATE(Credito) OR UPDATE(ZonaImpuesto) OR UPDATE(Descuento) OR UPDATE(Agente) OR UPDATE(AgenteServicio) OR UPDATE(EnviarA) OR UPDATE(Proyecto) OR
     UPDATE(FormaEnvio) OR UPDATE(Condicion) OR UPDATE(Ruta) OR UPDATE(ListaPrecios) OR UPDATE(ListaPreciosEsp) OR 
     UPDATE(DefMoneda) OR UPDATE(NivelAcceso) OR UPDATE(Estatus) 
  INSERT CteHist (Cliente, Fecha,  Nombre, NombreCorto, Direccion, Delegacion, Colonia,
                  Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, IEPS, PITEX, Tipo, Situacion, Credito, ZonaImpuesto, Descuento, Agente, AgenteServicio,
                  EnviarA, Proyecto, FormaEnvio, Condicion, Ruta, ListaPrecios, ListaPreciosEsp, DefMoneda, NivelAcceso, Estatus, Usuario)
           SELECT Cliente, GETDATE(), Nombre, NombreCorto, Direccion, Delegacion, Colonia,
                  Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, IEPS, PITEX, Tipo, Situacion, Credito, ZonaImpuesto, Descuento, Agente, AgenteServicio,
                  EnviarA, Proyecto, FormaEnvio, Condicion, Ruta, ListaPrecios, ListaPreciosEsp, DefMoneda, NivelAcceso, Estatus, Usuario
             FROM Inserted


-- Valida RFC Duplicados
  SELECT @ClienteDup = NULL
  IF NULLIF(@RFCNuevo, '') IS NOT NULL AND @RFCNuevo NOT IN ('XAXX010101000', 'XEXX010101000') --JGD 06Junio2011 Ticket 4857
  BEGIN
    SELECT @ClienteDup = MIN(Cliente) FROM CTE WHERE RFC = @RFCNuevo AND Cliente <> @ClaveNueva 
    IF @ClienteDup IS NOT NULL SELECT @RegistroDup = 'RFC - ' + @RFCNuevo
  END

  IF @ClienteDup IS NOT NULL 
  BEGIN
    SELECT @Mensaje = 'Error al Actualizar a "'+RTRIM(@ClaveNueva)+'", la clave del "'+@RegistroDup+'", ya Existe en la Persona "'+LTRIM(RTRIM(@ClienteDup))+ '".' 
    RAISERROR (@Mensaje,16,-1) 
  END

END
GO



CREATE TRIGGER tgCteBC ON Cte
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE   
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @TipoNuevo		varchar(15),
    @TipoAnterior	varchar(15),
    @NombreNuevo	varchar(100),
    @NombreAnterior	varchar(100),
    @RFCNuevo		varchar(20),
    @RFCAnterior	varchar(20),
    @CURPNuevo		varchar(30),
    @CURPAnterior	varchar(30),
    @Mensaje 		varchar(255),
    @RutaA		varchar(100),
    @RutaN		varchar(100),
    @NombreA	      	varchar(100),
    @NombreN	      	varchar(100),
    @DireccionA 	varchar(100),
    @DireccionN 	varchar(100),
    @EntreCallesA	varchar(100),
    @EntreCallesN	varchar(100),
    @PlanoA		varchar(100),
    @PlanoN		varchar(100),
    @ObservacionesA	varchar(100),
    @ObservacionesN	varchar(100),
    @ColoniaA 		varchar(100),
    @ColoniaN 		varchar(100),
    @PoblacionA		varchar(100),
    @PoblacionN		varchar(100),
    @EstadoA 		varchar(100),
    @EstadoN 		varchar(100),
    @PaisA 		varchar(100),
    @PaisN 		varchar(100),
    @CodigoPostalA 	varchar(100),
    @CodigoPostalN 	varchar(100),
    @TelefonosA		varchar(100),
    @TelefonosN		varchar(100),
    @Contacto1A		varchar(100),
    @Contacto1N		varchar(100),
    @Contacto2A		varchar(100),
    @Contacto2N		varchar(100),
    @Extencion1A 	varchar(100),
    @Extencion1N 	varchar(100),
    @Extencion2A 	varchar(100),
    @Extencion2N 	varchar(100),
    @ClienteDup  	varchar(10),
    @RegistroDup	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva = Cliente, @TipoNuevo = Tipo, @NombreNuevo = Nombre, @RFCNuevo = RFC, @CURPNuevo = CURP, 
         @RutaN = Ruta, @NombreN = Nombre, @DireccionN = Direccion, @EntreCallesN = EntreCalles, @PlanoN = Plano, @ObservacionesN = Observaciones,
         @ColoniaN = Colonia, @PoblacionN = Poblacion, @EstadoN = Estado, @PaisN = Pais, @CodigoPostalN = CodigoPostal, @TelefonosN = Telefonos,
         @Contacto1N = Contacto1, @Contacto2N = Contacto2, @Extencion1N = Extencion1, @Extencion2N = Extencion2
    FROM Inserted
  SELECT @ClaveAnterior = Cliente, @TipoAnterior = Tipo, @NombreAnterior = Nombre, @RFCAnterior = RFC, @CURPAnterior = CURP ,
         @RutaA = Ruta, @NombreA = Nombre, @DireccionA = Direccion, @EntreCallesA = EntreCalles, @PlanoA = Plano, @ObservacionesA = Observaciones,
         @ColoniaA = Colonia, @PoblacionA = Poblacion, @EstadoA = Estado, @PaisA = Pais, @CodigoPostalA = CodigoPostal, @TelefonosA = Telefonos,
         @Contacto1A = Contacto1, @Contacto2A = Contacto2, @Extencion1A = Extencion1, @Extencion2A = Extencion2
    FROM Deleted

-- Valida RFC Duplicados
  SELECT @ClienteDup = NULL
  IF NULLIF (@RFCNuevo,'') IS NOT NULL AND @RFCNuevo NOT IN ('XAXX010101000', 'XEXX010101000') --JGD 06Junio2011 Ticket 4857
  BEGIN
    SELECT @ClienteDup = MIN(Cliente) FROM CTE WHERE RFC = @RFCNuevo AND Cliente <> @ClaveNueva 
    IF @ClienteDup IS NOT NULL SELECT @RegistroDup = 'RFC - ' + @RFCNuevo
  END

  IF @ClienteDup IS NOT NULL 
  BEGIN
    SELECT @Mensaje = 'Error al Actualizar a "'+RTRIM(@ClaveNueva)+'", la clave del "'+@RegistroDup+'", ya Existe en la Persona "'+LTRIM(RTRIM(@ClienteDup))+ '".' 
    RAISERROR (@Mensaje,16,-1) 
  END

  /*IF @NombreNuevo <> @NombreAnterior OR @RFCNuevo <> @RFCAnterior OR @CURPNuevo <> @CURPAnterior*/

  IF ISNULL(@RutaA, '') <> ISNULL(@RutaN, '') OR ISNULL(@NombreA, '') <> ISNULL(@NombreN, '') OR ISNULL(@DireccionA, '') <> ISNULL(@DireccionN, '') OR ISNULL(@EntreCallesA, '') <> ISNULL(@EntreCallesN, '') OR ISNULL(@PlanoA, '') <> ISNULL(@PlanoN, '') OR
     ISNULL(@ObservacionesA, '') <> ISNULL(@ObservacionesN, '') OR ISNULL(@ColoniaA, '') <> ISNULL(@ColoniaN, '') OR ISNULL(@PoblacionA, '') <> ISNULL(@PoblacionN, '') OR  ISNULL(@EstadoA, '') <> ISNULL(@EstadoN, '') OR ISNULL(@PaisA, '') <> ISNULL(@PaisN, '') OR
     ISNULL(@CodigoPostalA, '') <> ISNULL(@CodigoPostalN, '') OR ISNULL(@TelefonosA, '') <> ISNULL(@TelefonosN, '') OR ISNULL(@Contacto1A, '') <> ISNULL(@Contacto1N, '') OR ISNULL(@Contacto2A, '') <> ISNULL(@Contacto2N, '') OR 
     ISNULL(@Extencion1A, '') <> ISNULL(@Extencion1N, '') OR ISNULL(@Extencion2A, '') <> ISNULL(@Extencion2N, '')
  UPDATE EmbarqueMov
    WITH (ROWLOCK) 
     SET Ruta		= i.Ruta,
	 Nombre	      	= i.Nombre, 
	 NombreEnvio  	= i.Nombre, 
	 Direccion 	= i.Direccion,
	 EntreCalles	= i.EntreCalles,
	 Plano		= i.Plano,
	 Observaciones	= i.Observaciones,
	 Colonia 	= i.Colonia,
	 Poblacion 	= i.Poblacion,
	 Estado 	= i.Estado,
	 Pais 		= i.Pais,
	 CodigoPostal 	= i.CodigoPostal,
	 Telefonos	= i.Telefonos,
	 Contacto1 	= i.Contacto1,
	 Contacto2 	= i.Contacto2,
         Extencion1 	= i.Extencion1,
         Extencion2 	= i.Extencion2
    FROM Inserted i, EmbarqueMov e
   WHERE e.Cliente = i.Cliente AND e.Cliente = @ClaveNueva AND NULLIF(e.ClienteEnviarA, 0) IS NULL AND e.Concluido = 0
  
  IF @ClaveNueva=@ClaveAnterior AND @TipoNuevo=@TipoAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    IF EXISTS (SELECT * FROM Cte WHERE Rama = @ClaveAnterior)
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30165
      RAISERROR (@Mensaje,16,-1) 
    END ELSE
    BEGIN
      DELETE CteEnviarA  	  WHERE Cliente = @ClaveAnterior
      DELETE CteEnviarAOtrosDatos WHERE Cliente = @ClaveAnterior
      DELETE CteRep	  	  WHERE Cliente = @ClaveAnterior
      DELETE CteBonificacion  	  WHERE Cliente = @ClaveAnterior
      DELETE CteCto	  	  WHERE Cliente = @ClaveAnterior
      DELETE CteAcceso	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteTel	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteUEN	 	  WHERE Cliente = @ClaveAnterior
      DELETE CteOtrosDatos 	  WHERE Cliente = @ClaveAnterior
      DELETE CteCapacidadPago 	  WHERE Cliente = @ClaveAnterior
      DELETE Sentinel  		  WHERE Cliente = @ClaveAnterior
      DELETE CteCFD  		  WHERE Cliente = @ClaveAnterior
      DELETE CteEmpresaCFD	  WHERE Cliente = @ClaveAnterior
      DELETE CteDepto  		  WHERE Cliente = @ClaveAnterior
      DELETE CteEntregaMercancia  WHERE Cliente = @ClaveAnterior
      DELETE CteEstadoFinanciero  WHERE Cliente = @ClaveAnterior
      DELETE Prop        	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE ListaD	 	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE AnexoCta    	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
      DELETE CuentaTarea 	  WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
	  DELETE CtoCampoExtra    WHERE Tipo   = 'Cliente' AND Clave = @ClaveAnterior
	  DELETE FormaExtraValor  WHERE Aplica = 'Cliente' AND AplicaClave = @ClaveAnterior
	  DELETE FormaExtraD      WHERE Aplica = 'Cliente' AND AplicaClave = @ClaveAnterior
    END
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
     IF (SELECT Sincro FROM Version) = 1
       EXEC sp_executesql N'UPDATE Cte SET Rama = @ClaveNueva, SincroC = SincroC WHERE Rama = @ClaveAnterior', N'@ClaveNueva varchar(20), @ClaveAnterior varchar(20)', @ClaveNueva = @ClaveNueva, @ClaveAnterior = @ClaveAnterior
     ELSE
       UPDATE Cte SET Rama = @ClaveNueva WHERE Rama = @ClaveAnterior

    UPDATE CteEnviarA  		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEnviarAOtrosDatos SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteRep  		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteBonificacion  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCto	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteAcceso	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteTel	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteUEN	  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteOtrosDatos  	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCapacidadPago 	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE Sentinel		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteCFD		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEmpresaCFD	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteDepto		SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEntregaMercancia	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE CteEstadoFinanciero	SET Cliente = @ClaveNueva WHERE Cliente = @ClaveAnterior
    UPDATE Prop        		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE ListaD      		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE AnexoCta    		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
    UPDATE CuentaTarea 		SET Cuenta  = @ClaveNueva WHERE Cuenta  = @ClaveAnterior AND Rama='CXC'
	UPDATE CtoCampoExtra	SET Clave   = @ClaveNueva WHERE Clave   = @ClaveAnterior AND Tipo='Cliente'
	UPDATE FormaExtraValor	SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Cliente'
	UPDATE FormaExtraD	    SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Cliente'
  END
END
GO
EXEC spReplicaTema 'Clientes', 'Cte',			'Cliente', @Principal = 1
EXEC spReplicaTema 'Clientes', 'CteEnviarA',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteEnviarAOtrosDatos',	'Cliente'
EXEC spReplicaTema 'Clientes', 'CteRep',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteBonificacion',	'Cliente'
EXEC spReplicaTema 'Clientes', 'CteCto',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteAcceso',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteTel',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteUEN',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteOtrosDatos',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteCapacidadPago',	'Cliente'
EXEC spReplicaTema 'Clientes', 'Sentinel',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteCFD',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteEmpresaCFD',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteDepto',		'Cliente'
EXEC spReplicaTema 'Clientes', 'CteEntregaMercancia',	'Cliente'
EXEC spReplicaTema 'Clientes', 'CteEstadoFinanciero',	'Cliente'
EXEC spReplicaTema 'Clientes', 'Prop'	,		'Cuenta', 'Rama', '"CXC"'
EXEC spReplicaTema 'Clientes', 'ListaD',		'Cuenta', 'Rama', '"CXC"'
EXEC spReplicaTema 'Clientes', 'AnexoCta',		'Cuenta', 'Rama', '"CXC"'
EXEC spReplicaTema 'Clientes', 'CuentaTarea',		'Cuenta', 'Rama', '"CXC"'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCtePerfil') and sysstat & 0xf = 8) drop trigger dbo.tgCtePerfil
GO
CREATE TRIGGER tgCtePerfil ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveN		varchar(10),
    @ClaveA		varchar(10),
    @EsProveedor	bit,
    @EsPersonal		bit,
    @EsAgente		bit,
    @EsAlmacen		bit,
    @EsEspacio		bit,
    @EsCentroCostos	bit,
    @EsProyecto		bit,
    @EsCentroTrabajo	bit,
    @EsEstacionTrabajo	bit

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Cliente) OR UPDATE(Nombre) OR UPDATE(Direccion) OR UPDATE(EntreCalles) OR UPDATE(Plano)
  OR UPDATE(Delegacion) OR UPDATE(Colonia) OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais) OR UPDATE(Zona) 
  OR UPDATE(CodigoPostal) OR UPDATE(RFC) OR UPDATE(CURP) OR UPDATE(Telefonos) OR UPDATE(Fax)
  OR UPDATE(EsProveedor) OR UPDATE(EsPersonal) OR UPDATE(EsAgente) OR UPDATE(EsAlmacen) OR UPDATE(EsEspacio)
  OR UPDATE(EsCentroCostos) OR UPDATE(EsProyecto) OR UPDATE(EsCentroTrabajo) OR UPDATE(EsEstacionTrabajo)
  OR UPDATE(PersonalNombres) OR UPDATE(PersonalApellidoPaterno) OR UPDATE(PersonalApellidoMaterno)
  BEGIN
    SELECT @ClaveN = Cliente, @EsProveedor = EsProveedor, @EsPersonal = EsPersonal, @EsAgente = EsAgente, @EsAlmacen = EsAlmacen, @EsEspacio = EsEspacio, @EsCentroCostos = EsCentroCostos, @EsProyecto = EsProyecto, @EsCentroTrabajo = EsCentroTrabajo, @EsEstacionTrabajo = EsEstacionTrabajo FROM Inserted
    SELECT @ClaveA = Cliente FROM Deleted

    IF @ClaveN IS NULL
    BEGIN
      SELECT @EsProveedor = EsProveedor, @EsPersonal = EsPersonal, @EsAgente = EsAgente, @EsAlmacen = EsAlmacen, @EsEspacio = EsEspacio, @EsCentroCostos = EsCentroCostos, @EsProyecto = EsProyecto, @EsCentroTrabajo = EsCentroTrabajo, @EsEstacionTrabajo = EsEstacionTrabajo FROM Deleted
      IF @EsProveedor       = 1 DELETE Prov         WHERE Proveedor    = @ClaveA
      IF @EsPersonal        = 1 DELETE Personal     WHERE Personal     = @ClaveA
      IF @EsAgente          = 1 DELETE Agente       WHERE Agente       = @ClaveA
      IF @EsAlmacen         = 1 DELETE Alm          WHERE Almacen      = @ClaveA
      IF @EsEspacio         = 1 DELETE Espacio      WHERE Espacio      = @ClaveA
      IF @EsCentroCostos    = 1 DELETE CentroCostos WHERE CentroCostos = @ClaveA
      IF @EsProyecto        = 1 DELETE Proy         WHERE Proyecto     = @ClaveA
      IF @EsCentroTrabajo   = 1 DELETE Centro       WHERE Centro       = @ClaveA
      IF @EsEstacionTrabajo = 1 DELETE EstacionT    WHERE Estacion     = @ClaveA
    END ELSE
    BEGIN   
      IF @EsProveedor = 1
      BEGIN
        UPDATE Prov 
           SET Nombre = i.Nombre, Direccion = i.Direccion, EntreCalles = i.EntreCalles, Plano = i.Plano, Delegacion = i.Delegacion, Colonia = i.Colonia, Poblacion = i.Poblacion, Estado = i.Estado, Pais = i.Pais, Zona = i.Zona, CodigoPostal = i.CodigoPostal, RFC = i.RFC, CURP = i.CURP, Telefonos = i.Telefonos, Fax = i.Fax
          FROM Prov p, Inserted i
         WHERE p.Proveedor = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Prov (Proveedor, Nombre, BeneficiarioNombre, Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Fax, DefMoneda, Tipo,         Estatus, Alta)
                SELECT Cliente,   Nombre, Nombre,             Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Fax, DefMoneda, 'Proveedor', 'ALTA',   GETDATE() FROM Inserted

      END
      IF @EsPersonal = 1
      BEGIN
        UPDATE Personal
           SET Nombre = i.PersonalNombres, ApellidoPaterno = i.PersonalApellidoPaterno, ApellidoMaterno = i.PersonalApellidoMaterno, 
               Direccion = i.Direccion, Delegacion = i.Delegacion, Colonia = i.Colonia, Poblacion = i.Poblacion, Estado = i.Estado, Pais = i.Pais, CodigoPostal = i.CodigoPostal, Registro2 = i.RFC, Registro = i.CURP, Telefono = i.Telefonos
          FROM Personal p, Inserted i
         WHERE p.Personal = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Personal (Personal, Nombre,                          ApellidoPaterno,         ApellidoMaterno,         Direccion, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Registro2, Registro, Telefono,  Moneda,     Tipo,      Estatus,     FechaAlta)
                    SELECT Cliente,  ISNULL(PersonalNombres, Nombre), PersonalApellidoPaterno, PersonalApellidoMaterno, Direccion, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, RFC,       CURP,     Telefonos, DefMoneda, 'Empleado', 'ASPIRANTE', GETDATE() FROM Inserted

      END
      IF @EsAgente = 1
      BEGIN
        UPDATE Agente
           SET Nombre = i.Nombre, Direccion = i.Direccion, Colonia = i.Colonia, Poblacion = i.Poblacion, Estado = i.Estado, Pais = i.Pais, Zona = i.Zona, CodigoPostal = i.CodigoPostal, RFC = i.RFC, CURP = i.CURP, Telefonos = i.Telefonos
          FROM Agente a, Inserted i
         WHERE a.Agente = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Agente (Agente,  Nombre, BeneficiarioNombre, Direccion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, Tipo,      Estatus, Alta)
                  SELECT Cliente, Nombre, Nombre,             Direccion, Colonia, Poblacion, Estado, Pais, Zona, CodigoPostal, RFC, CURP, Telefonos, 'Agente', 'ALTA',   GETDATE() FROM Inserted

      END
      IF @EsAlmacen = 1
      BEGIN
        UPDATE Alm
           SET Nombre = i.Nombre, Direccion = i.Direccion, EntreCalles = i.EntreCalles, Plano = i.Plano, Delegacion = i.Delegacion, Colonia = i.Colonia, Poblacion = i.Poblacion, Estado = i.Estado, Pais = i.Pais, CodigoPostal = i.CodigoPostal, Telefonos = i.Telefonos 
          FROM Alm a, Inserted i
         WHERE a.Almacen = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Alm (Almacen, Nombre, Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Telefonos, Tipo,     Estatus, Alta,      Sucursal)
               SELECT Cliente, Nombre, Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Telefonos, 'Normal', 'ALTA',  GETDATE(), ISNULL(SucursalEmpresa, 0) FROM Inserted

      END
      IF @EsEspacio = 1
      BEGIN
        UPDATE Espacio
           SET Nombre = i.Nombre
          FROM Espacio e, Inserted i
         WHERE e.Espacio = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Espacio (Espacio, Nombre, Estatus, Alta)
                   SELECT Cliente, Nombre, 'ALTA', GETDATE() FROM Inserted
      END
      IF @EsCentroCostos = 1
      BEGIN
        UPDATE CentroCostos
           SET Descripcion = i.Nombre
          FROM CentroCostos c, Inserted i
         WHERE c.CentroCostos = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT CentroCostos (CentroCostos, Descripcion)
                        SELECT Cliente,      Nombre       FROM Inserted
      END
      IF @EsProyecto = 1
      BEGIN
        UPDATE Proy
           SET Descripcion = i.Nombre, Direccion = i.Direccion, EntreCalles = i.EntreCalles, Plano = i.Plano, Delegacion = i.Delegacion, Colonia = i.Colonia, Poblacion = i.Poblacion, Estado = i.Estado, Pais = i.Pais, CodigoPostal = i.CodigoPostal
          FROM Proy p, Inserted i
         WHERE p.Proyecto = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Proy (Proyecto, Descripcion, Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, Estatus)
                SELECT Cliente,  Nombre,      Direccion, EntreCalles, Plano, Delegacion, Colonia, Poblacion, Estado, Pais, CodigoPostal, 'ALTA' FROM Inserted

      END
      IF @EsCentroTrabajo = 1
      BEGIN
        UPDATE Centro
           SET Descripcion = i.Nombre
          FROM Centro c, Inserted i
         WHERE c.Centro = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT Centro (Centro,  Descripcion, Estatus, CostoMoneda)
                  SELECT Cliente, Nombre,      'ALTA',  DefMoneda  FROM Inserted
      END
      IF @EsEstacionTrabajo = 1
      BEGIN
        UPDATE EstacionT
           SET Descripcion = i.Nombre
          FROM EstacionT e, Inserted i
         WHERE e.Estacion = @ClaveN
        IF @@ROWCOUNT = 0 
          INSERT EstacionT (Estacion, Descripcion, Estatus)
                     SELECT Cliente,  Nombre,      'ALTA'  FROM Inserted
      END
    END
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgInforCteABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforCteABC
GO
CREATE TRIGGER tgInforCteABC ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Cliente    							varchar (10),
   @Estatus							    varchar (10),
   @Datos								varchar (max),
   @Ok									int,
   @OkRef								varchar(255),
   @Id									int,
   @Cinserted		                	int,
   @Cdeleted			                int,
   @Empresa								varchar(20),
   @ReferenciaIntelisisService			varchar(50)

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  

    
  IF @ProdInterfazINFOR = 1
  BEGIN
    IF @Cinserted <> 0           AND @Cdeleted = 0 
    BEGIN
      SET @Estatus = 'ALTA' 
    END
    IF @Cinserted <> 0           AND @Cdeleted<> 0 
    BEGIN
      SET @Estatus = 'CAMBIO'
    END
    IF @Cinserted = 0           AND @Cdeleted <> 0 
    BEGIN 
      SET @Estatus = 'BAJA'
    END
    IF  @Estatus IN( 'ALTA','CAMBIO')
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Cliente,ReferenciaIntelisisService
         FROM Inserted
    END
    ELSE
    IF @Estatus = 'BAJA'
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Cliente,ReferenciaIntelisisService
         FROM Deleted     
    END 
    IF @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
    BEGIN         
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @Cliente ,@ReferenciaIntelisisService
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        EXEC spInforGenerarSolicitudCte  @Cliente,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
        FETCH NEXT FROM crActualizar INTO @Cliente,@ReferenciaIntelisisService
	  END
      CLOSE crActualizar
      DEALLOCATE crActualizar
    END  
  END
END
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgCteABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgCteABC_CRM
GO
CREATE TRIGGER tgCteABC_CRM ON Cte
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClienteI  			varchar(10),
    @ClienteD			varchar(10),
    @CRMII				varchar(36),
    @CRMID				varchar(36),
    @Datos				varchar(max),
    @Usuario			varchar(10),
    @Contrasena			varchar(32),
    @Ok					int,
    @OkRef				varchar(255),
    @IDIS				int,
    
    @Accion				varchar(20),
    @SincronizarCRMI	bit,
    @EstatusI			varchar(15),
    @EstatusD			varchar(15),
    @SincronizarCRMD	bit
    
  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
   SELECT
     @Usuario    = Usuario,
     @Contrasena = Contrasena
   FROM CfgCRM
  
  SELECT @ClienteI = Cliente, @CRMII = CRMID, @SincronizarCRMI = SincronizarCRM, @EstatusI = Estatus FROM Inserted
  SELECT @ClienteD = Cliente, @CRMID = CRMID, @SincronizarCRMD = SincronizarCRM, @EstatusD = Estatus FROM Deleted  
  
  IF (@CRMII IS NULL AND @CRMID IS NULL) OR (@SincronizarCRMI = 0 AND @EstatusI = 'ALTA')
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'

  IF @ClienteD IS NULL OR @ClienteD = @ClienteI
    SELECT @Datos = @Datos + (SELECT ActividadEconomicaCNBV, Agente, Agente3, Agente4, AgenteServicio, Alergias, AlmacenDef, AlmacenVtasConsignacion, Alta, Aseguradora, BloquearMorosos, Bonificacion, BonificacionTipo, Categoria, CBDir, ChecarCredito, Clase, Cliente, Coaseguro, Cobrador, CodigoPostal, Colonia, Conciliar, Condicion, Contacto1, Contacto2, Contrasena, Contrasena2, Conyuge, Credito, CreditoConCondiciones, CreditoConDias, CreditoCondiciones, CreditoConLimite, CreditoConLimitePedidos, CreditoDias, CreditoEspecial, CreditoLimite, CreditoLimitePedidos, CreditoMoneda, CRMCantidad, CRMCierreFechaAprox, CRMCierreProbabilidad, CRMCompetencia, CRMEtapa, CRMFuente, CRMID, CRMImporte, CRMInfluencia, CRMovVenta, CRMPresupuestoAsignado, Cuenta, CuentaRetencion, CURP, Deducible, DeducibleMoneda, DefMoneda, Delegacion, Descripcion1, Descripcion10, Descripcion11, Descripcion12, Descripcion13, Descripcion14, Descripcion15, Descripcion16, Descripcion17, Descripcion18, Descripcion19, Descripcion2, Descripcion20, Descripcion3, Descripcion4, Descripcion5, Descripcion6, Descripcion7, Descripcion8, Descripcion9, Descuento, DescuentoRecargos, DiaPago1, DiaPago2, DiaRevision1, DiaRevision2, Direccion, DireccionNumero, DireccionNumeroInt, DirInternet, DocumentacionCompleta, EDICalificador, EDIIdentificador, eMail1, eMail2, eMailAuto, EntreCalles, EnviarA, EsAgente, EsAlmacen, EsCentroCostos, EsCentroTrabajo, EsEspacio, EsEstacionTrabajo, Espacio, EsPersonal, EsProveedor, EsProyecto, Estado, EstadoCivil, Estatura, Estatus, ExcentoISAN, ExpedienteFamiliar, Extencion1, Extencion2, Extranjero, FacturarCte, FacturarCteEnviarA, Familia, Fax, Fecha1, Fecha2, Fecha3, Fecha4, Fecha5, FechaMatrimonio, FechaNacimiento, FiscalRegimen, Flotilla, FordDistribuidor, FordZona, FormaEnvio, FormasPagoRestringidas, FueraLinea, Fuma, GLN, Grado, Grupo, GrupoSanguineo, GrupoSanguineoRH, HorarioPago, HorarioRevision, Idioma, IEPS, IFE, ImportadorRegimen, ImportadorRegistro, Intercompania, InterfacturaRI, Licencias, LicenciasLlave, LicenciasTipo, ListaPrecios, ListaPreciosEsp, LocalidadCNBV, MapaLatitud, MapaLongitud, MapaPrecision, Mensaje, ModificarVencimiento, NivelAcceso, Nombre, NombreAsegurado, NombreCorto, NoriticarATelefonos, NotificarA, Numero, NumeroHijos, Observaciones, OperacionLimite, OtrosCargos, Pais, Parentesco, Pasaporte, PedidoDef, PedidosParciales, PedirTono, PersonalApellidoMaterno, PersonalApellidoPaterno, PersonalCobrador, PersonalCodigoPostal, PersonalColonia, PersonalDelegacion, PersonalDireccion, PersonalEntreCalles, PersonalEstado, PersonalNombres, PersonalPais, PersonalPlano, PersonalPoblacion, PersonalSMS, PersonalTelefonoMovil, PersonalTelefonos, PersonalTelefonosLada, PersonalZona, Peso, PITEX, Plano, Poblacion, PolizaFechaEmision, PolizaImporte, PolizaNumero, PolizaReferencia, PolizaTipo, PolizaVencimiento, PreciosInferioresMinimo, PrimaryContactId, Profesion, ProveedorClave, ProveedorInfo, Proyecto, Publico, Puesto, Rama, RecorrerVencimiento, ReferenciaBancaria, Religion, Responsable, RFC, RPU, Ruta, RutaOrden, Sexo, SIC, 
SincroC, SincroID, SIRAC, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, SucursalEmpresa, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, TipoRegistro, Titulo, UltimoCambio, Usuario, VigenciaDesde, VigenciaHasta, VtasConsignacion, wMovVentas, wVerArtListaPreciosEsp, wVerDisponible, Zona, ZonaImpuesto FROM Inserted Cuenta FOR XML AUTO)
  ELSE
  IF @SincronizarCRMD = 1
    SELECT @Datos = @Datos + (SELECT ActividadEconomicaCNBV, Agente, Agente3, Agente4, AgenteServicio, Alergias, AlmacenDef, AlmacenVtasConsignacion, Alta, Aseguradora, BloquearMorosos, Bonificacion, BonificacionTipo, Categoria, CBDir, ChecarCredito, Clase, Cliente, Coaseguro, Cobrador, CodigoPostal, Colonia, Conciliar, Condicion, Contacto1, Contacto2, Contrasena, Contrasena2, Conyuge, Credito, CreditoConCondiciones, CreditoConDias, CreditoCondiciones, CreditoConLimite, CreditoConLimitePedidos, CreditoDias, CreditoEspecial, CreditoLimite, CreditoLimitePedidos, CreditoMoneda, CRMCantidad, CRMCierreFechaAprox, CRMCierreProbabilidad, CRMCompetencia, CRMEtapa, CRMFuente, CRMID, CRMImporte, CRMInfluencia, CRMovVenta, CRMPresupuestoAsignado, Cuenta, CuentaRetencion, CURP, Deducible, DeducibleMoneda, DefMoneda, Delegacion, Descripcion1, Descripcion10, Descripcion11, Descripcion12, Descripcion13, Descripcion14, Descripcion15, Descripcion16, Descripcion17, Descripcion18, Descripcion19, Descripcion2, Descripcion20, Descripcion3, Descripcion4, Descripcion5, Descripcion6, Descripcion7, Descripcion8, Descripcion9, Descuento, DescuentoRecargos, DiaPago1, DiaPago2, DiaRevision1, DiaRevision2, Direccion, DireccionNumero, DireccionNumeroInt, DirInternet, DocumentacionCompleta, EDICalificador, EDIIdentificador, eMail1, eMail2, eMailAuto, EntreCalles, EnviarA, EsAgente, EsAlmacen, EsCentroCostos, EsCentroTrabajo, EsEspacio, EsEstacionTrabajo, Espacio, EsPersonal, EsProveedor, EsProyecto, Estado, EstadoCivil, Estatura, Estatus, ExcentoISAN, ExpedienteFamiliar, Extencion1, Extencion2, Extranjero, FacturarCte, FacturarCteEnviarA, Familia, Fax, Fecha1, Fecha2, Fecha3, Fecha4, Fecha5, FechaMatrimonio, FechaNacimiento, FiscalRegimen, Flotilla, FordDistribuidor, FordZona, FormaEnvio, FormasPagoRestringidas, FueraLinea, Fuma, GLN, Grado, Grupo, GrupoSanguineo, GrupoSanguineoRH, HorarioPago, HorarioRevision, Idioma, IEPS, IFE, ImportadorRegimen, ImportadorRegistro, Intercompania, InterfacturaRI, Licencias, LicenciasLlave, LicenciasTipo, ListaPrecios, ListaPreciosEsp, LocalidadCNBV, MapaLatitud, MapaLongitud, MapaPrecision, Mensaje, ModificarVencimiento, NivelAcceso, Nombre, NombreAsegurado, NombreCorto, NoriticarATelefonos, NotificarA, Numero, NumeroHijos, Observaciones, OperacionLimite, OtrosCargos, Pais, Parentesco, Pasaporte, PedidoDef, PedidosParciales, PedirTono, PersonalApellidoMaterno, PersonalApellidoPaterno, PersonalCobrador, PersonalCodigoPostal, PersonalColonia, PersonalDelegacion, PersonalDireccion, PersonalEntreCalles, PersonalEstado, PersonalNombres, PersonalPais, PersonalPlano, PersonalPoblacion, PersonalSMS, PersonalTelefonoMovil, PersonalTelefonos, PersonalTelefonosLada, PersonalZona, Peso, PITEX, Plano, Poblacion, PolizaFechaEmision, PolizaImporte, PolizaNumero, PolizaReferencia, PolizaTipo, PolizaVencimiento, PreciosInferioresMinimo, PrimaryContactId, Profesion, ProveedorClave, ProveedorInfo, Proyecto, Publico, Puesto, Rama, RecorrerVencimiento, ReferenciaBancaria, Religion, Responsable, RFC, RPU, Ruta, RutaOrden, Sexo, SIC, 
SincroC, SincroID, SIRAC, Situacion, SituacionFecha, SituacionNota, SituacionUsuario, SucursalEmpresa, Telefonos, TelefonosLada, TemaCRM, TieneMovimientos, Tipo, TipoRegistro, Titulo, UltimoCambio, Usuario, VigenciaDesde, VigenciaHasta, VtasConsignacion, wMovVentas, wVerArtListaPreciosEsp, wVerDisponible, Zona, ZonaImpuesto FROM Deleted Cuenta FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT   
  RETURN
END
GO


/****** CuboCteEstadoFinanciero  ******/
if exists (select * from sysobjects where id = object_id('dbo.CuboCteEstadoFinanciero') and type = 'V') drop view dbo.CuboCteEstadoFinanciero
GO
CREATE VIEW CuboCteEstadoFinanciero
--//WITH ENCRYPTION
AS
SELECT 	ef.ID,
	ef.Cliente,
	ef.Ejercicio,
        ef.Reporte,
	ef.Mayor,
	ef.Cuenta,
	ef.SaldoDeudor,
	ef.SaldoAcreedor,
        "Saldo" = ISNULL(ef.SaldoDeudor, 0) - ISNULL(ef.SaldoAcreedor, 0),
        ef.Importe,
        ef.Razones,
        m.Grupo,
        m.SubGrupo,
        "Cliente Nombre"    = cte.Nombre,
        "Cliente Categoria" = cte.Categoria,
        "Cliente Grupo"     = cte.Grupo,
        "Cliente Familia"   = cte.Familia
  FROM CteEstadoFinanciero ef, CteEstadoFinancieroMayor m, Cte 
 WHERE ef.Mayor = m.Mayor AND ef.Cliente = Cte.Cliente
GO     

/*******************************************************************************************/
/*                                        ALMACENES                                        */
/*******************************************************************************************/

/****** Grupos de Almacenes  ******/
if not exists(select * from SysTabla where SysTabla = 'AlmGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AlmGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmGrupo') and type = 'U') 
CREATE TABLE dbo.AlmGrupo (
	Grupo			varchar(50) 	NOT NULL,

	CONSTRAINT priAlmGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** Tipos de Almacen ******/
if not exists(select * from SysTabla where SysTabla = 'AlmTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AlmTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmTipo') and type = 'U') 
CREATE TABLE dbo.AlmTipo (
	Tipo	 		varchar(50) NOT NULL,

	CONSTRAINT priAlmTipo PRIMARY KEY  CLUSTERED (Tipo)
)
go

/****** AlmABC ******/
if not exists(select * from SysTabla where SysTabla = 'AlmABC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AlmABC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmABC') and type = 'U') 
CREATE TABLE dbo.AlmABC (
	Almacen			varchar(10) 	NOT NULL,
	ABC			char(1) 	NOT NULL,
	Frecuencia		int		NULL,

	CONSTRAINT priAlmABC PRIMARY KEY  CLUSTERED (Almacen, ABC)
)
GO

/****** PosicionZona ******/
if not exists(select * from SysTabla where SysTabla = 'PosicionZona')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PosicionZona', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PosicionZona') and type = 'U') 
  CREATE TABLE dbo.PosicionZona (
	Zona			varchar(50)	NOT NULL,

	CONSTRAINT priPosicionZona PRIMARY KEY  CLUSTERED (Zona)
  )
GO

/****** AlmPos ******/
if not exists(select * from SysTabla where SysTabla = 'AlmPos')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmPos', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmPos') and type = 'U') 
  CREATE TABLE dbo.AlmPos (
	Almacen			varchar(10)	NOT NULL,
	Posicion		varchar(10)	NOT NULL,

	Tipo			varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	Pasillo			int		NULL,
	Fila			int		NULL,
	Nivel			int		NULL,
	Zona			varchar(50)	NULL,
	Capacidad		int		NULL	DEFAULT 1,
	Estatus			varchar(15)	NULL,
	ArticuloEsp		varchar(20)	NULL,
	
	--REQ12615 WMS
	Alto			float		NULL,
	Largo			float		NULL,
	Ancho			float		NULL,
	Volumen			float		NULL,
	PesoMaximo		float		NULL,
	Orden			int			NULL,
	TipoRotacion	varchar(10)	NULL,

	--TASK25160
	CambioDomicilios bit NULL,

	CONSTRAINT priAlmPos PRIMARY KEY  CLUSTERED (Almacen, Posicion)
  )
GO
if exists(select * from syscampo where tabla = 'AlmPos' and campo = 'Articulo')
  EXEC sp_rename 'AlmPos.Articulo', 'ArticuloEsp', 'COLUMN'
go
EXEC spDROP_INDEX 'AlmPos', 'Tarima'
EXEC spDROP_COLUMN 'AlmPos', 'Tarima'
GO
EXEC spALTER_TABLE 'AlmPos', 'Capacidad', 'int NULL DEFAULT 1 WITH VALUES'
GO
if exists(select * from syscampoExt where tabla = 'AlmPos' and campo='Pasillo' and tipoDatos ='varchar')
  EXEC spDROP_COLUMN 'AlmPos', 'Pasillo'
GO
EXEC spALTER_TABLE 'AlmPos', 'Pasillo', 'int NULL'
EXEC spALTER_TABLE 'AlmPos', 'Fila', 'int NULL'
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'AlmPos','Alto','float NULL'
EXEC spALTER_TABLE 'AlmPos','Largo','float NULL'
EXEC spALTER_TABLE 'AlmPos','Ancho','float NULL'
EXEC spALTER_TABLE 'AlmPos','Volumen','float NULL'
EXEC spALTER_TABLE 'AlmPos','PesoMaximo','float NULL'
EXEC spALTER_TABLE 'AlmPos','Orden','int NULL'
EXEC spAlter_Table 'AlmPos','TipoRotacion','varchar(10) NULL'
GO
--TASK25160
--BUG25090
EXEC spALTER_TABLE 'AlmPos', 'CambioDomicilios', 'bit NULL'
GO
--BUG2761
EXEC spALTER_TABLE 'AlmPos', 'TipoTarimaEsp', 'varchar(20) NULL'
GO
--TASK2429PGC
EXEC spALTER_TABLE 'AlmPos', 'SubCuenta', 'varchar(50) NULL'
GO

/****** AlmOrdenEntarimadoMov ******/
if not exists(select * from SysTabla where SysTabla = 'AlmOrdenEntarimadoMov')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmOrdenEntarimadoMov', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmOrdenEntarimadoMov') and type = 'U') 
  CREATE TABLE dbo.AlmOrdenEntarimadoMov (
	Almacen			varchar(10)	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	Mov			varchar(20)	NOT NULL,

	CONSTRAINT priAlmOrdenEntarimadoMov PRIMARY KEY  CLUSTERED (Almacen, Modulo, Mov)
  )
GO

/****** AlmOrdenAcomodoReciboMov ******/
if not exists(select * from SysTabla where SysTabla = 'AlmOrdenAcomodoReciboMov')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmOrdenAcomodoReciboMov', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmOrdenAcomodoReciboMov') and type = 'U') 
  CREATE TABLE dbo.AlmOrdenAcomodoReciboMov (
	Almacen			varchar(10)	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	Mov			varchar(20)	NOT NULL,

	CONSTRAINT priAlmOrdenAcomodoReciboMov PRIMARY KEY  CLUSTERED (Almacen, Modulo, Mov)
  )
GO

/****** AlmOrdenAcomodoSurtidoMov ******/
if not exists(select * from SysTabla where SysTabla = 'AlmOrdenAcomodoSurtidoMov')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmOrdenAcomodoSurtidoMov', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmOrdenAcomodoSurtidoMov') and type = 'U') 
  CREATE TABLE dbo.AlmOrdenAcomodoSurtidoMov (
	Almacen			varchar(10)	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	Mov			varchar(20)	NOT NULL,

	CONSTRAINT priAlmOrdenAcomodoSurtidoMov PRIMARY KEY  CLUSTERED (Almacen, Modulo, Mov)
  )
GO

/****** AlmSugerirSurtidoTarima ******/
if not exists(select * from SysTabla where SysTabla = 'AlmSugerirSurtidoTarima')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmSugerirSurtidoTarima', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AlmSugerirSurtidoTarima') and type = 'U') 
  CREATE TABLE dbo.AlmSugerirSurtidoTarima (
	Almacen			varchar(10)	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	Mov				varchar(20)	NOT NULL,

    --REQ12615 WMS	
	Estatus			varchar(15)		NULL,
	ModuloDestino	varchar(5)		NULL,
	MovDestino		varchar(20)		NULL,

	CONSTRAINT priAlmSugerirSurtidoTarima PRIMARY KEY  CLUSTERED (Almacen, Modulo, Mov)
  )
GO

--REQ12615 WMS
EXEC spAlter_Table 'AlmSugerirSurtidoTarima','Estatus',		'varchar(15) NULL'
EXEC spAlter_Table 'AlmSugerirSurtidoTarima','ModuloDestino',	'varchar(5) NULL'
EXEC spAlter_Table 'AlmSugerirSurtidoTarima','MovDestino',	'varchar(20) NULL'
GO


/****** Almacenes ******/
if not exists(select * from SysTabla where SysTabla = 'Alm')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Alm','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Alm') and type = 'U') 
CREATE TABLE dbo.Alm (
	Almacen 		varchar(10)  	NOT NULL,
	Rama			varchar(20)	NULL,

	Nombre	 		varchar(100)  	NOT NULL,
	Direccion 		varchar(100) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(100)  	NULL,
	Delegacion		varchar(100)	NULL,
	Poblacion 		varchar(100)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)  	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Encargado 		varchar(50)  	NULL,
	Telefonos 		varchar(100)  	NULL,

	Grupo			varchar(50)	NULL,
	Categoria		varchar(50)	NULL,
	Zona			varchar(30)	NULL,
	Ruta			varchar(50)	NULL,
	Tipo			varchar(15)	NULL	 DEFAULT 'Normal',

	Sucursal		int		NOT NULL	DEFAULT 0,

	Exclusivo		varchar(20)	NULL,
	Orden			int		NULL,
	Estatus			varchar(15)  	NOT NULL,
	UltimoCambio		datetime      	NULL,
	Alta			datetime	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	FacturasPendientes	bit		NOT NULL 	DEFAULT 0,
	wMostrar		bit		NULL 		DEFAULT 1,
	wUnicamenteDisponibles	bit		NULL 		DEFAULT 0,

	TieneMovimientos	bit		NULL		DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,
	Idioma			varchar(50)	NULL,
	ExcluirPlaneacion	bit		NULL	 	DEFAULT 0,
	CBDir			varchar(255)	NULL,
	Cuenta			varchar(20)	NULL,
	Segundas		bit		NULL	 	DEFAULT 0,
	Compartido		bit		NULL	 	DEFAULT 0,
	SucursalRef		int		NULL,
	WMS			bit		NULL	 	DEFAULT 0,

	DireccionNumero			varchar(20)	NULL,
	DireccionNumeroInt		varchar(20)	NULL,
	MapaLatitud			float		NULL,
	MapaLongitud			float		NULL,
	MapaPrecision			int		NULL,
    MapaUbicacion           varchar(100) NULL,

	PermiteRechazos			AS CONVERT(bit,NULL), 
	PermiteUbicaciones		AS CONVERT(bit,NULL),
	EsAlmacenDeDeposito		AS CONVERT(bit,NULL),
	EsAlmacenMaterialesExteriores	AS CONVERT(bit,NULL),
	NoDisponibleConsumos		AS CONVERT(bit,NULL),
 --REQ12534 Factory  
	ContactoTipo		        varchar(20)     NULL DEFAULT 'Almacen',
    INFORClavePlanta            varchar(8)      NULL,
    ReferenciaIntelisisService  varchar(50)     NULL,
        EsFactory               bit  NULL	 	DEFAULT 0,
	
	--REQ12615 WMS
	DefPosicionRecibo			varchar(10)		NULL,
	DefPosicionSurtido			varchar(10)		NULL,
	eCommerceSincroniza                     bit  NULL	 	DEFAULT 1,-- REQ13987
	Ubicaciones                             bit  NULL	 	DEFAULT 0,

	CONSTRAINT priAlm PRIMARY KEY CLUSTERED (Almacen)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgAlmBC') and sysstat & 0xf = 8) drop trigger dbo.tgAlmBC
GO

if not exists(select * from syscampo where tabla = 'Alm' and Campo = 'Sucursal')
  ALTER TABLE Alm ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES
GO
if not exists(select * from syscampo where tabla = 'Alm' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Alm ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Alm SET TieneMovimientos = 1")
END
IF (SELECT Version FROM Version) <= 1120
BEGIN
  UPDATE Alm SET Almacen = UPPER(Almacen)
  UPDATE Usuario SET DefAlmacen = UPPER(DefAlmacen)
END
GO
EXEC spALTER_TABLE 'Alm', 'wUnicamenteDisponibles', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Alm', 'Ruta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Alm', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Alm', 'Idioma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Alm', 'ExcluirPlaneacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'CBDir', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Alm', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Alm', 'Segundas', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'Compartido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'SucursalRef', 'int NULL'
EXEC spALTER_TABLE 'Alm', 'Rama', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Alm', 'WMS', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Alm ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Alm ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Alm ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
EXEC spALTER_TABLE 'Alm', 'GenerarOrdenEntarimado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'GenerarSolAcomodoRecibo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'GenerarOrdenAcomodoRecibo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'GenerarSolAcomodoSurtido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'GenerarOrdenAcomodoSurtido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'SugerirSurtidoTarima', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Alm', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Alm', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Alm', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Alm', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'Alm', 'MapaUbicacion', 'varchar(100) NULL'
GO

EXEC spALTER_TABLE 'Alm', 'PermiteRechazos', 'AS CONVERT(bit,NULL)'
EXEC spALTER_TABLE 'Alm', 'PermiteUbicaciones', 'AS CONVERT(bit,NULL)'
EXEC spALTER_TABLE 'Alm', 'EsAlmacenDeDeposito', 'AS CONVERT(bit,NULL)'
EXEC spALTER_TABLE 'Alm', 'EsAlmacenMaterialesExteriores', 'AS CONVERT(bit,NULL)'
EXEC spALTER_TABLE 'Alm', 'NoDisponibleConsumos', 'AS CONVERT(bit,NULL)'
GO
EXEC spALTER_TABLE 'Alm', 'ContactoTipo', 'varchar(20) NULL DEFAULT "Almacen" WITH VALUES'
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Alm', 'DefPosicionRecibo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Alm', 'DefPosicionSurtido', 'varchar(10) NULL'
GO

-- REQ13987
Exec spAlter_Table 'Alm', 'eCommerceSincroniza',' bit NULL DEFAULT 1 WITH VALUES'
Go

--8. Desarrollo de proceso Cross Docking
EXEC spALTER_TABLE 'Alm', 'Defposicioncrossdocking', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Alm', 'Escrossdocking', 'varchar(2) NULL'
GO

EXEC spFK 'Alm','Sucursal','Sucursal','Sucursal'
EXEC spFK 'Alm','Cuenta','Cta','Cuenta'
GO

EXEC spReplicaTema 'Almacenes', 'Alm',			'Almacen', @Principal = 1
EXEC spReplicaTema 'Almacenes', 'AlmABC',		'Almacen'
EXEC spReplicaTema 'Almacenes', 'AlmPos',		'Almacen'
EXEC spReplicaTema 'Almacenes', 'Prop'	,		'Cuenta', 'Rama', '"ALM"'
EXEC spReplicaTema 'Almacenes', 'AnexoCta',		'Cuenta', 'Rama', '"ALM"'
GO

--REQ12534 Factory  
Exec spAlter_Table 'Alm', 'INFORClavePlanta',' varchar(8) NULL '
Exec spAlter_Table 'Alm', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Alm', 'EsFactory',' bit NULL  DEFAULT 0'
EXEC spALTER_TABLE 'Alm', 'Ubicaciones', 'bit  NOT NULL DEFAULT 0 '
GO

--Integración MES
EXEC spALTER_TABLE 'Alm', 'MES', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--Integración CRM
EXEC spAlter_Table 'alm', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'alm', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

/********************* tgAlmABC **********************/
IF OBJECT_ID(N'dbo.tgAlmABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgAlmABC
GO
CREATE TRIGGER tgAlmABC ON Alm
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @Mensaje 		varchar(255)
    
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Almacen FROM Inserted
  SELECT @ClaveAnterior = Almacen FROM Deleted

  IF @ClaveNueva=@ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    DELETE Prop     WHERE Cuenta  = @ClaveAnterior AND Rama='ALM'
    DELETE AnexoCta WHERE Cuenta  = @ClaveAnterior AND Rama='ALM'
    DELETE AlmABC   WHERE Almacen = @ClaveAnterior
    DELETE AlmPos   WHERE Almacen = @ClaveAnterior
    DELETE AlmOrdenEntarimadoMov     WHERE Almacen = @ClaveAnterior
    DELETE AlmOrdenAcomodoReciboMov  WHERE Almacen = @ClaveAnterior
    DELETE AlmOrdenAcomodoSurtidoMov WHERE Almacen = @ClaveAnterior
    DELETE AlmSugerirSurtidoTarima   WHERE Almacen = @ClaveAnterior
  END ELSE 
  IF @ClaveNueva <> @ClaveAnterior AND @ClaveAnterior IS NOT NULL
  BEGIN
    UPDATE Prop     SET Cuenta  = @ClaveNueva  WHERE Cuenta  = @ClaveAnterior AND Rama='ALM'
    UPDATE AnexoCta SET Cuenta  = @ClaveNueva  WHERE Cuenta  = @ClaveAnterior AND Rama='ALM'
    UPDATE AlmABC   SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
    UPDATE AlmPos   SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
    UPDATE AlmOrdenEntarimadoMov     SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
    UPDATE AlmOrdenAcomodoReciboMov  SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
    UPDATE AlmOrdenAcomodoSurtidoMov SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
    UPDATE AlmSugerirSurtidoTarima   SET Almacen = @ClaveNueva  WHERE Almacen = @ClaveAnterior
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgInforAlmABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforAlmABC
GO
--CREATE TRIGGER tgInforAlmABC ON Alm
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR				bit,
--   @Almacen					varchar (10),
--   @Estatus					varchar (10),
--   @Datos					varchar (max),
--   @Datos2					varchar (max),
--   @Resultado					varchar(max),
--   @Ok						int,
--   @OkRef					varchar(255),
--   @Id						int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Alm						varchar(10),
--   @Empresa					varchar(20),
--   @ReferenciaIntelisisService			varchar(50)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--    IF @Cinserted <> 0 AND @Cdeleted = 0 
--    BEGIN
--      SET @Estatus = 'ALTA' 
--    END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--    BEGIN
--      SET @Estatus = 'CAMBIO'
--    END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--    BEGIN 
--      SET @Estatus = 'BAJA'
--    END
    
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--    BEGIN
--      DECLARE crActualizar CURSOR FOR
--       SELECT Almacen,ReferenciaIntelisisService
--	 FROM Inserted
--    END
--    ELSE
--    IF @Estatus = 'BAJA'
--    BEGIN
--      DECLARE crActualizar CURSOR local FOR
--       SELECT Almacen,ReferenciaIntelisisService
--	 FROM Deleted     
--    END  
--    IF @Estatus IS NOT NULL         
--    BEGIN         
--      OPEN crActualizar
--      FETCH NEXT FROM crActualizar INTO @Almacen ,@ReferenciaIntelisisService
--      WHILE @@FETCH_STATUS = 0 
--      BEGIN
--        EXEC spInforGenerarSolicitudAlmacen  @Almacen,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--        FETCH NEXT FROM crActualizar INTO @Almacen,@ReferenciaIntelisisService
--      END
--      CLOSE crActualizar
--      DEALLOCATE crActualizar
--    END  
      
--  END
--END
--GO

--Integración CRM
IF OBJECT_ID ('tr_alm', 'TR') IS NOT NULL DROP TRIGGER tr_alm
GO									
/*CREATE TRIGGER tr_alm ON alm 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update alm  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Almacen= alm.Almacen
	END
END
GO*/

/*******************************************************************************************/
/*                                        ARTICULOS                                        */
/*******************************************************************************************/

/****** ArtColumna ******/
if not exists(select * from SysTabla where SysTabla = 'ArtColumna')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtColumna','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtColumna') and type = 'U') 
CREATE TABLE dbo.ArtColumna (
	Columna			varchar(50) 	NOT NULL,

	CONSTRAINT priArtColumna PRIMARY KEY CLUSTERED (Columna)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtColumnaBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtColumnaBC
GO
CREATE TRIGGER tgArtColumnaBC ON ArtColumna
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ColumnaN  	varchar(50),
    @ColumnaA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ColumnaN = Columna FROM Inserted
  SELECT @ColumnaA = Columna FROM Deleted
  IF @ColumnaN = @ColumnaA RETURN

  IF @ColumnaN IS NULL AND 
    EXISTS(SELECT * FROM ArtMatriz WHERE Columna = @ColumnaA)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(@ColumnaA))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30155
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
  IF @ColumnaA IS NOT NULL 
    UPDATE ArtMatriz SET Columna = @ColumnaN WHERE Columna = @ColumnaA
END
GO

/****** ArtRenglon ******/
if not exists(select * from SysTabla where SysTabla = 'ArtRenglon')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtRenglon','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtRenglon') and type = 'U') 
CREATE TABLE dbo.ArtRenglon (
	Renglon			varchar(50) NOT NULL,
	Descripcion		varchar(100)	NULL,

	CONSTRAINT priArtRenglon PRIMARY KEY CLUSTERED (Renglon)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtRenglonBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtRenglonBC
GO
CREATE TRIGGER tgArtRenglonBC ON ArtRenglon
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RenglonN  	varchar(50),
    @RenglonA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @RenglonN = Renglon FROM Inserted
  SELECT @RenglonA = Renglon FROM Deleted
  IF @RenglonN = @RenglonA RETURN

  IF @RenglonN IS NULL AND 
    EXISTS(SELECT * FROM ArtMatriz WHERE Renglon = @RenglonA)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(@RenglonA))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30155
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
  IF @RenglonA IS NOT NULL 
    UPDATE ArtMatriz SET Renglon = @RenglonN WHERE Renglon = @RenglonA
END
GO

/****** Matriz  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtMatriz')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtMatriz','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtMatriz') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtMatriz (
	ID			int 		NOT NULL IDENTITY(1,1),

	Articulo 		varchar(20) 	NOT NULL,
	Renglon			varchar(50)	NULL,
	Columna			varchar(50)	NULL,

	CONSTRAINT priArtMatriz PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ArtMatriz'
END
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ArtMatriz' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.ArtMatriz (Articulo)
go

EXEC spFK 'ArtMatriz','Renglon','ArtRenglon','Renglon'
EXEC spFK 'ArtMatriz','Columna','ArtColumna','Columna'
GO

/****** Tipo Empaques ******/
if not exists(select * from SysTabla where SysTabla = 'TipoEmpaque')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoEmpaque','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoEmpaque') and type = 'U') 
CREATE TABLE dbo.TipoEmpaque (
	TipoEmpaque		varchar(50) 	NOT NULL,

	Clave			varchar(20) 	NULL,
	Tipo			varchar(20)	NULL,

	CONSTRAINT priTipoEmpaque PRIMARY KEY CLUSTERED (TipoEmpaque)
)
GO
EXEC spALTER_TABLE 'TipoEmpaque', 'Clave', 'varchar(20) NULL'
EXEC spALTER_TABLE 'TipoEmpaque', 'Tipo', 'varchar(20) NULL'
GO

/****** Categorias de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCatABC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCatABC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCatABC') and type = 'U') 
CREATE TABLE dbo.ArtCatABC (
	Categoria 		varchar(50) 	NOT NULL,
	ABC			varchar(1)	NOT NULL,

	Minimo			float		NULL,
	CantidadOrdenar		float		NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priArtCatABC PRIMARY KEY CLUSTERED (Categoria, ABC)
)
GO

/****** Categorias de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCat')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCat') and type = 'U') 
CREATE TABLE dbo.ArtCat
(
	Categoria 		varchar(50) 	NOT NULL ,
	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,
	ValidarPresupuestoCompra varchar(20)	NULL		DEFAULT 'No',
	Imagen	varchar(255) NULL,

	CONSTRAINT priArtCat PRIMARY KEY CLUSTERED (Categoria)
)
GO
EXEC spALTER_TABLE 'ArtCat', 'ValidarPresupuestoCompra', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
GO

--User Story 12668
EXEC spALTER_TABLE 'ArtCat', 'Imagen', 'varchar(255) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'artcat', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'artcat', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgArtCatBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtCatBC
GO
CREATE TRIGGER tgArtCatBC ON ArtCat
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CategoriaA  	varchar(50),
    @CategoriaN		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CategoriaN = Categoria FROM Inserted
  SELECT @CategoriaA = Categoria FROM Deleted
  IF @CategoriaN=@CategoriaA RETURN

  IF @CategoriaN IS NULL
  BEGIN
    DELETE ArtCatABC   WHERE Categoria = @CategoriaA
  END ELSE
  BEGIN
    UPDATE ArtCatABC   SET Categoria = @CategoriaN WHERE Categoria = @CategoriaA
  END
END
GO

--Integración CRM
IF OBJECT_ID ('tr_artcat', 'TR') IS NOT NULL DROP TRIGGER tr_artcat
GO									
/*CREATE TRIGGER tr_artcat ON artcat 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update artcat  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Categoria= artcat.Categoria
	END
END
GO*/

/****** Temporadas de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtTemporada')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtTemporada','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtTemporada') and type = 'U') 
CREATE TABLE dbo.ArtTemporada (
	Temporada 		varchar(50) 	NOT NULL ,

	CONSTRAINT priArtTemporada PRIMARY KEY CLUSTERED (Temporada)
)
GO

/****** Modelos de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtModelo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtModelo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtModelo') and type = 'U') 
CREATE TABLE dbo.ArtModelo (
	Modelo 		varchar(50) 	NOT NULL,

	CONSTRAINT priArtModelo PRIMARY KEY CLUSTERED (Modelo)
)
GO


/****** Versiones de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtVersion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtVersion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtVersion') and type = 'U') 
CREATE TABLE dbo.ArtVersion (
	Version 	varchar(50) 	NOT NULL,

	CONSTRAINT priArtVersion PRIMARY KEY CLUSTERED (Version)
)
GO


/****** Categorias de Produccion  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCatProd')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCatProd','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCatProd') and type = 'U') 
CREATE TABLE dbo.ArtCatProd (
	Categoria 		varchar(50) 	NOT NULL ,

	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priArtCatProd PRIMARY KEY CLUSTERED (Categoria)
)
GO

/****** Grupos de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtGrupo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtGrupo') and type = 'U') 
CREATE TABLE dbo.ArtGrupo (
	Grupo	 		varchar(50) 	NOT NULL,
	Descripcion		varchar(50)	NULL,
	Descuento		money		NULL,

	Flotante1		float		NULL,
	Puntos			float		NULL,
	TablaComision		varchar(50)	NULL,
	Clave			varchar(20)	NULL,
	InflacionPresupuesto	float		NULL,

	CONSTRAINT priArtGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO
EXEC spALTER_TABLE 'ArtGrupo', 'Puntos', 'float	NULL'
EXEC spALTER_TABLE 'ArtGrupo', 'TablaComision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtGrupo', 'Clave', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ArtGrupo' ,'InflacionPresupuesto', 'float NULL'
GO

--Integración MES
EXEC spALTER_TABLE 'ArtGrupo', 'ClaveMES', 'int IDENTITY NOT NULL '
GO

--Integración CRM
EXEC spAlter_Table 'artgrupo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'artgrupo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_artgrupo', 'TR') IS NOT NULL DROP TRIGGER tr_artgrupo 
GO									
/*CREATE TRIGGER tr_artgrupo ON artgrupo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update artgrupo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Grupo= artgrupo.Grupo
	END
END
GO*/

/****** Familias de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtFamPresupuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtFamPresupuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtFamPresupuesto') and type = 'U') 
CREATE TABLE dbo.ArtFamPresupuesto (
	Familia 		varchar(50) 	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	Cantidad		float		NULL,

	CONSTRAINT priArtFamPresupuesto PRIMARY KEY CLUSTERED (Familia, Ejercicio, Periodo)
)
GO

/****** Familias de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtFam')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtFam') and type = 'U') 
CREATE TABLE dbo.ArtFam (
	Familia 		varchar(50) 	NOT NULL ,
	FamiliaMaestra 		varchar(50) 	NULL,
	Icono			int	  	NULL,
	Precios			bit		NULL	DEFAULT 0,
	PrecioLista		money		NULL,
	Precio2			money		NULL,
	Precio3			money		NULL,
	Precio4			money		NULL,
	CostoReposicion		float		NULL,
	BasePresupuesto		varchar(20)	NULL,
	UltimoQuiebre		datetime	NULL,
	QuiebreFechaD		datetime	NULL,
	QuiebreFechaA		datetime	NULL,
	Impuesto1 		float	  	NULL,
	Impuesto2 		float	  	NULL,
	Impuesto3		float	  	NULL,
	Clave			varchar(20)	NULL,
 --REQ12534 Factory  	
	INFORDescripcion        varchar(30)	NULL,
	ReferenciaIntelisisService  varchar(50)	NULL,

	CONSTRAINT priArtFam PRIMARY KEY CLUSTERED (Familia)
)
GO
EXEC spALTER_TABLE 'ArtFam', 'Precios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtFam', 'PrecioLista', 'money NULL'
EXEC spALTER_TABLE 'ArtFam', 'Precio2', 'money NULL'
EXEC spALTER_TABLE 'ArtFam', 'Precio3', 'money NULL'
EXEC spALTER_TABLE 'ArtFam', 'Precio4', 'money NULL'
EXEC spALTER_TABLE 'ArtFam', 'CostoReposicion', 'money NULL'
EXEC spALTER_TABLE 'ArtFam', 'BasePresupuesto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ArtFam', 'UltimoQuiebre', 'datetime	NULL'
EXEC spALTER_TABLE 'ArtFam', 'QuiebreFechaD', 'datetime	NULL'
EXEC spALTER_TABLE 'ArtFam', 'QuiebreFechaA', 'datetime	NULL'
EXEC spALTER_TABLE 'ArtFam', 'Clave', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ArtFam', 'Impuesto1', 'float NULL'
EXEC spALTER_TABLE 'ArtFam', 'Impuesto2', 'float NULL'
EXEC spALTER_TABLE 'ArtFam', 'Impuesto3', 'float NULL'
GO
EXEC spALTER_COLUMN 'ArtFam', 'Impuesto3', 'float NULL'
EXEC spALTER_COLUMN 'ArtFam', 'CostoReposicion', 'float NULL'
GO
 --REQ12534 Factory  
Exec spAlter_Table 'ArtFam','INFORDescripcion','varchar(30) Null'
Exec spAlter_Table 'ArtFam', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--Integración MES
EXEC spALTER_TABLE 'ArtFam', 'ClaveMES', 'int IDENTITY NOT NULL'
GO

--Integración CRM
EXEC spAlter_Table 'artfam', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'artfam', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgArtFamBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtFamBC
GO
CREATE TRIGGER tgArtFamBC ON ArtFam
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @FamiliaA  	varchar(50),
    @FamiliaN		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FamiliaN = Familia FROM Inserted
  SELECT @FamiliaA = Familia FROM Deleted
  IF @FamiliaN=@FamiliaA RETURN

  IF @FamiliaN IS NULL
  BEGIN
    DELETE ArtFamPresupuesto   WHERE Familia = @FamiliaA
  END ELSE
  BEGIN
    UPDATE ArtFamPresupuesto   SET Familia = @FamiliaN WHERE Familia = @FamiliaA
  END
END
GO

--Integración CRM
IF OBJECT_ID ('tr_artfam', 'TR') IS NOT NULL DROP TRIGGER tr_artfam
GO									
/*CREATE TRIGGER tr_artfam ON artfam 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update artfam  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Familia= artfam.Familia
	END
END
GO */
 
 --REQ12534 Factory   

/**************** tgInforArtFamABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforArtFamABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforArtFamABC
GO
--CREATE TRIGGER tgInforArtFamABC ON ArtFam
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Familia    							varchar (50),
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--	@ReferenciaIntelisisService			varchar(50)	,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0 AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Familia,ReferenciaIntelisisService
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--    BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Familia,ReferenciaIntelisisService
--	    FROM Deleted     
--    END
--    IF @Estatus IS NOT NULL         
--    BEGIN                
--      OPEN crActualizar
--      FETCH NEXT FROM crActualizar INTO @Familia,@ReferenciaIntelisisService
--      WHILE @@FETCH_STATUS = 0 
--      BEGIN
--        EXEC spInforGenerarSolicitudArtFam  @Familia,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--        FETCH NEXT FROM crActualizar INTO @Familia,@ReferenciaIntelisisService
--	  END
--      CLOSE crActualizar
--      DEALLOCATE crActualizar
--    END  
      
--  END
--END
--GO

/****** Lineas de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtLinea')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtLinea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtLinea') and type = 'U') 
CREATE TABLE dbo.ArtLinea (
	Linea	 		varchar(50) 	NOT NULL ,

	LineaMaestra 		varchar(50) 	NULL,
	Icono			int	  	NULL,
	Clave			varchar(20)	NULL,

	CONSTRAINT priArtLinea PRIMARY KEY CLUSTERED (Linea)
)
GO
EXEC spALTER_TABLE 'ArtLinea', 'Clave', 'varchar(20) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'artlinea', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'artlinea', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_artlinea', 'TR') IS NOT NULL DROP TRIGGER tr_artlinea 
GO									
/*CREATE TRIGGER tr_artlinea ON artlinea 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update artlinea  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Linea= artlinea.Linea
	END
END
GO */
 
 --REQ12534 Factory  
 
if exists (select * from sysobjects where id = object_id('dbo.tgInforArtLineaABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforArtLineaABC
GO
--CREATE TRIGGER tgInforArtLineaABC ON ArtLinea
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Linea    							varchar (50),
--   @Estatus							    varchar (10),
--   @Datos								varchar(max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa								varchar(20)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa
--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted

--  IF @ProdInterfazINFOR = 1
--  BEGIN
--	IF @Cinserted <> 0           AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0           AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0           AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Linea
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--    BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Linea
--	    FROM Deleted     
--    END  
--    IF @Estatus IS NOT NULL         
--    BEGIN              
--      OPEN crActualizar
--      FETCH NEXT FROM crActualizar INTO @Linea
--      WHILE @@FETCH_STATUS = 0 
--      BEGIN
--        EXEC spInforGenerarSolicitudArtLinea @Linea,@Estatus,@Datos OUTPUT
--        FETCH NEXT FROM crActualizar INTO @Linea
--	  END
--      CLOSE crActualizar
--      DEALLOCATE crActualizar
--    END  
      
--  END
--END
--GO
 



/****** Departamento Detallista de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'DepartamentoDetallista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DepartamentoDetallista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DepartamentoDetallista') and type = 'U') 
CREATE TABLE dbo.DepartamentoDetallista (
	Departamento		int		NOT NULL,

	Nombre			varchar(100)	NULL,
	Merma			float		NULL,

	CONSTRAINT priDepartamentoDetallista PRIMARY KEY CLUSTERED (Departamento)
)
GO

/****** Factores Costo ******/
if not exists(select * from SysTabla where SysTabla = 'ArtFactor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtFactor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtFactor') and type = 'U') 
CREATE TABLE dbo.ArtFactor (
	Factor 			varchar(50)     NOT NULL ,

	Importe 		float           NULL,

	CONSTRAINT priArtFactor PRIMARY KEY CLUSTERED (Factor)
)

/****** Utilidad  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtUtil')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtUtil','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtUtil') and type = 'U') 
CREATE TABLE dbo.ArtUtil (
	Utilidad		varchar(50) 	NOT NULL ,

	Margen	 		float     	NULL,
	Incremento		float	  	NULL,
	UltimoCambio		datetime	NULL,

	CONSTRAINT priArtUtil PRIMARY KEY CLUSTERED (Utilidad)
)

/****** ArtComisionHist  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtComisionHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtComisionHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtComisionHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtComisionHist (
	Comision	varchar(50) 	NOT NULL,
	Fecha		datetime	NOT NULL,
	RenglonID	int		NOT NULL IDENTITY(1,1),

	Tipo		varchar(20)	NULL,
	Porcentaje	float		NULL,
	Importe		money		NULL,

	CONSTRAINT priArtComisionHist PRIMARY KEY CLUSTERED (Comision, Fecha, RenglonID)
  )
  EXEC spSincroSemilla 'ArtComisionHist'
END
GO


/****** ArtComision  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtComision')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtComision','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtComision') and type = 'U') 
CREATE TABLE dbo.ArtComision (
	Comision	varchar(50) 	NOT NULL,
	Tipo		varchar(20)	NULL,
	Porcentaje	float		NULL,
	Importe		money		NULL,

	CONSTRAINT priArtComision PRIMARY KEY CLUSTERED (Comision)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtComisionBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtComisionBC
GO
CREATE TRIGGER tgArtComisionBC ON ArtComision
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF UPDATE(Tipo) OR UPDATE(Porcentaje) OR UPDATE(Importe)
    INSERT ArtComisionHist (Comision, Fecha, Tipo, Porcentaje, Importe)
                     SELECT Comision, GETDATE(), Tipo, Porcentaje, Importe FROM Deleted
END
GO

/****** ArtArancelTratadoComercial  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtArancelTratadoComercial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtArancelTratadoComercial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtArancelTratadoComercial') and type = 'U') 
CREATE TABLE dbo.ArtArancelTratadoComercial (
	Arancel			varchar(50) 	NOT NULL,
        TratadoComercial 	varchar(50) 	NOT NULL,

	Porcentaje		float		NULL,

	CONSTRAINT priArtArancelTratadoComercial PRIMARY KEY CLUSTERED (Arancel, TratadoComercial)
)
GO

/****** ArtArancelProgramaSectorial  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtArancelProgramaSectorial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtArancelProgramaSectorial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtArancelProgramaSectorial') and type = 'U') 
CREATE TABLE dbo.ArtArancelProgramaSectorial (
	Arancel			varchar(50) 	NOT NULL,
        ProgramaSectorial	varchar(50) 	NOT NULL,

	Porcentaje		float		NULL,

	CONSTRAINT priArtArancelProgramaSectorial PRIMARY KEY CLUSTERED (Arancel, ProgramaSectorial)
)
GO

/****** ArtArancel  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtArancel')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtArancel','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtArancel') and type = 'U') 
CREATE TABLE dbo.ArtArancel (
	Arancel		varchar(50) 	NOT NULL,
	Unidad		varchar(50)	NULL,
	UnidadVenta	varchar(50)	NULL,
	UnidadCompra	varchar(50)	NULL,
	Cuota		float		NULL,
	Porcentaje	float		NULL,
	Porcentaje2	float		NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priArtArancel PRIMARY KEY CLUSTERED (Arancel)
)
GO
EXEC spALTER_TABLE 'ArtArancel', 'Cuota', 'float NULL'
EXEC spALTER_TABLE 'ArtArancel', 'Porcentaje2', 'float NULL'
EXEC spALTER_TABLE 'ArtArancel', 'Unidad', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'ArtArancel', 'UnidadVenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtArancel', 'UnidadCompra', 'varchar(50) NULL'
GO


/****** ListaPreciosBase ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosBase')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosBase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosBase') and type = 'U') 
CREATE TABLE dbo.ListaPreciosBase (
	Lista		varchar(20)	NOT NULL,
	NivelAcceso	varchar(50)	NULL,
	Orden		int		NULL,

	CONSTRAINT priListaPreciosBase PRIMARY KEY CLUSTERED (Lista)
)
GO

/****** ListaPrecios ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPrecios')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPrecios','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPrecios') and type = 'U') 
CREATE TABLE dbo.ListaPrecios (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,

	PreciosNetos	bit		NOT NULL DEFAULT 0,
	Grupo		varchar(50)	NULL,
	Zona		varchar(50)	NULL,
	NivelAcceso	varchar(50)	NULL,
	Descripcion	varchar(100)	NULL,
	Region		varchar(50)	NULL,

	CONSTRAINT priListaPrecios PRIMARY KEY CLUSTERED (Lista, Moneda)
)
GO
EXEC spALTER_TABLE 'ListaPrecios', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ListaPrecios', 'Zona', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ListaPrecios', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ListaPrecios', 'Descripcion', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'ListaPrecios', 'Region', 'varchar(50) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'Listaprecios', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'Listaprecios', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_Listaprecios', 'TR') IS NOT NULL DROP TRIGGER tr_Listaprecios
GO									
/*CREATE TRIGGER tr_Listaprecios ON Listaprecios 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update Listaprecios  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Lista= Listaprecios.Lista
	END
END
GO*/

/****** Historico de Precios ******/
--Bug 21608
--if not exists(select * from SysTabla where SysTabla = 'ListaPreciosHist')B
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosHist','Cuenta')
--if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosHist') and type = 'U') 
--BEGIN
--  EXEC("CREATE TABLE dbo.ListaPreciosHist (
--	Lista			varchar(20)	NOT NULL,
--	Moneda			varchar(10)	NOT NULL,
--	Articulo		varchar(20)	NOT NULL,
--	Fecha                   datetime   	NOT NULL	DEFAULT GETDATE(),
--	RID			int		NOT NULL	IDENTITY(1,1),

--	SubCuenta		varchar(50)	NULL,	
--	Unidad			varchar(50)	NULL,
--	Region			varchar(50)	NULL,

--	PrecioAnterior		money		NULL,
--	PrecioActual		money		NULL,

--	CONSTRAINT priListaPreciosHist PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, Fecha, RID)
--  )")
--  EXEC spSincroSemilla 'ListaPreciosHist'
--END
--GO
--EXEC spALTER_COLUMN 'ListaPreciosHist', 'SubCuenta', 'varchar(50) NULL'
--GO

/****** ListaPreciosD ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosD')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosD','Maestro')
if exists (select * from sysobjects where id = object_id('dbo.Temporal') and type = 'U') DROP TABLE Temporal
if exists (select * from sysCampo WHERE tabla = 'ListaPreciosD' AND campo = 'ID')
  EXEC sp_rename 'ListaPreciosD', 'Temporal'
GO
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosD') and type = 'U') 
CREATE TABLE dbo.ListaPreciosD (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	Precio		money		NULL,
	CodigoCliente	varchar(20)	NULL,
	Margen		float		NULL,
	Region		varchar(50)	NULL,

	CONSTRAINT pListaPreciosD PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.Temporal') and type = 'U')
BEGIN
  INSERT ListaPreciosD (Lista, Moneda, Articulo, Precio) SELECT Lista, Moneda, Articulo, MAX(Precio) FROM Temporal GROUP BY Lista, Moneda, Articulo
  DROP TABLE Temporal
END
GO
EXEC spALTER_TABLE 'ListaPreciosD', 'CodigoCliente', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ListaPreciosD', 'Margen', 'float NULL'
EXEC spALTER_TABLE 'ListaPreciosD', 'Region', 'varchar(50) NULL'
GO

EXEC spFK2 'ListaPreciosD','Lista','Moneda','ListaPrecios','Lista','Moneda'
GO

--Integración CRM
EXEC spAlter_Table 'Listapreciosd', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'Listapreciosd', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

--Optimización Bug 18308
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ListaPreciosD' AND sysindexes.name = 'SecListaPreciosD' AND sysobjects.id = sysindexes.id)
CREATE INDEX SecListaPreciosD ON ListaPreciosD(Articulo, Lista, Moneda)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosDA') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosDA
GO
CREATE TRIGGER tgListaPreciosDA ON ListaPreciosD
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Lista	varchar(20),
    @Moneda	varchar(10),
    @Articulo	varchar(20),
    @Region	varchar(50)
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Lista = Lista, @Moneda = Moneda, @Articulo = Articulo FROM Inserted
  SELECT @Region = Region FROM ListaPrecios WHERE Lista = @Lista AND Moneda = @Moneda
  UPDATE ListaPreciosD SET Region = @Region WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo
END
GO

--Bug 21608
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosDC') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosDC
GO
--CREATE TRIGGER tgListaPreciosDC ON ListaPreciosD
--WITH ENCRYPTION
--FOR UPDATE
--AS BEGIN
  
--  IF dbo.fnEstaSincronizando() = 1 RETURN
  
--  IF UPDATE(Precio)
--    INSERT ListaPreciosHist (
--           Lista,   Moneda,   Articulo,   Region,   PrecioActual, PrecioAnterior)
--    SELECT i.Lista, i.Moneda, i.Articulo, i.Region, i.Precio, d.Precio
--      FROM inserted i
--      JOIN deleted d ON d.Lista = i.Lista AND d.Moneda = i.Moneda AND d.Articulo = i.Articulo
--END
--GO

--Integración CRM
IF OBJECT_ID ('tr_Listapreciosd', 'TR') IS NOT NULL DROP TRIGGER tr_Listapreciosd
GO									
/*CREATE TRIGGER tr_Listapreciosd ON Listapreciosd 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update Listapreciosd  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Lista= Listapreciosd.Lista And i.Articulo=Listapreciosd.Articulo
	END
END
GO*/

/****** ListaPreciosDUnidad ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosDUnidad')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosDUnidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosDUnidad') and type = 'U') 
CREATE TABLE dbo.ListaPreciosDUnidad (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	Unidad		varchar(50)	NOT NULL,

	Precio		money		NULL,
	Region		varchar(50)	NULL,

	CONSTRAINT pListaPreciosDUnidad PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, Unidad)
)
GO
EXEC spALTER_TABLE 'ListaPreciosDUnidad', 'Region', 'varchar(50) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosDUnidadA') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosDUnidadA
GO
CREATE TRIGGER tgListaPreciosDUnidadA ON ListaPreciosDUnidad
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Lista	varchar(20),
    @Moneda	varchar(10),
    @Articulo	varchar(20),
    @Unidad	varchar(50),
    @Region	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Lista = Lista, @Moneda = Moneda, @Articulo = Articulo, @Unidad = Unidad FROM Inserted
  SELECT @Region = Region FROM ListaPrecios WHERE Lista = @Lista AND Moneda = @Moneda
  UPDATE ListaPreciosDUnidad SET Region = @Region WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND Unidad = @Unidad
END
GO
--Bug 21608
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosDUnidadC') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosDUnidadC
GO
--CREATE TRIGGER tgListaPreciosDUnidadC ON ListaPreciosDUnidad
----WITH ENCRYPTION
--FOR UPDATE
--AS BEGIN
--  IF dbo.fnEstaSincronizando() = 1 RETURN
--  IF UPDATE(Precio)
--    INSERT ListaPreciosHist (
--           Lista,   Moneda,   Articulo,   Unidad,   Region,   PrecioActual, PrecioAnterior)
--    SELECT i.Lista, i.Moneda, i.Articulo, i.Unidad, i.Region, i.Precio, d.Precio
--      FROM inserted i
--      JOIN deleted d ON d.Lista = i.Lista AND d.Moneda = i.Moneda AND d.Articulo = i.Articulo AND d.Unidad = i.Unidad
--END
--GO


/****** ListaPreciosSub ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosSub')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosSub','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosSub') and type = 'U') 
CREATE TABLE dbo.ListaPreciosSub (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL,	

	Precio		money		NULL,
	Region		varchar(50)	NULL,

	CONSTRAINT priListaPreciosSub PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, SubCuenta)
)
GO
EXEC spALTER_TABLE 'ListaPreciosSub', 'Region', 'varchar(50) NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ListaPreciosSub' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ListaPreciosSub'
  EXEC spALTER_COLUMN 'ListaPreciosSub', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE ListaPreciosSub ADD CONSTRAINT priListaPreciosSub PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, SubCuenta)')
END
GO

EXEC spFK2 'ListaPreciosSub','Lista','Moneda','ListaPrecios','Lista','Moneda'
EXEC spFK2 'ListaPreciosSub','Articulo','SubCuenta','ArtSub','Articulo','SubCuenta'
EXEC spFK 'ListaPreciosSub','Articulo','Art','Articulo'
GO
--Optimización Bug 18308
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ListaPreciosSub' AND sysindexes.name = 'SecListaPreciosSub' AND sysobjects.id = sysindexes.id)
  CREATE INDEX SecListaPreciosSub ON ListaPreciosSub(Articulo, SubCuenta, Lista, Moneda)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosSubA') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosSubA
GO
CREATE TRIGGER tgListaPreciosSubA ON ListaPreciosSub
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Lista	varchar(20),
    @Moneda	varchar(10),
    @Articulo	varchar(20),
    @SubCuenta	varchar(50),
    @Region	varchar(50)
    
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Lista = Lista, @Moneda = Moneda, @Articulo = Articulo, @SubCuenta = SubCuenta FROM Inserted
  SELECT @Region = Region FROM ListaPrecios WHERE Lista = @Lista AND Moneda = @Moneda
  UPDATE ListaPreciosSub SET Region = @Region WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta
END
GO
--Bug 21608
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosSubC') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosSubC
GO
--CREATE TRIGGER tgListaPreciosSubC ON ListaPreciosSub
----WITH ENCRYPTION
--FOR UPDATE
--AS BEGIN
--  IF dbo.fnEstaSincronizando() = 1 RETURN
--  IF UPDATE(Precio)
--    INSERT ListaPreciosHist (
--           Lista,   Moneda,   Articulo,   SubCuenta,   Region,   PrecioActual, PrecioAnterior)
--    SELECT i.Lista, i.Moneda, i.Articulo, i.SubCuenta, i.Region, i.Precio, d.Precio
--      FROM inserted i
--      JOIN deleted d ON d.Lista = i.Lista AND d.Moneda = i.Moneda AND d.Articulo = i.Articulo AND d.SubCuenta = i.SubCuenta
--END
--GO

/****** ListaPreciosSubUnidad ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosSubUnidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosSubUnidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosSubUnidad') and type = 'U') 
CREATE TABLE dbo.ListaPreciosSubUnidad (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	SubCuenta	varchar(50)	NOT NULL,	
	Unidad		varchar(50)	NOT NULL,

	Precio		money		NULL,
	Region		varchar(50)	NULL,

	CONSTRAINT priListaPreciosSubUnidad PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, SubCuenta, Unidad)
)
GO
EXEC spALTER_TABLE 'ListaPreciosSubUnidad', 'Region', 'varchar(50) NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ListaPreciosSubUnidad' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ListaPreciosSubUnidad'
  EXEC spALTER_COLUMN 'ListaPreciosSubUnidad', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE ListaPreciosSubUnidad ADD CONSTRAINT priListaPreciosSubUnidad PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, SubCuenta, Unidad)')
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosSubUnidadA') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosSubUnidadA
GO
CREATE TRIGGER tgListaPreciosSubUnidadA ON ListaPreciosSubUnidad
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Lista	varchar(20),
    @Moneda	varchar(10),
    @Articulo	varchar(20),
    @SubCuenta	varchar(50),
    @Unidad	varchar(50),
    @Region	varchar(50)
  IF dbo.fnEstaSincronizando() = 1 RETURN
  SELECT @Lista = Lista, @Moneda = Moneda, @Articulo = Articulo, @SubCuenta = SubCuenta, @Unidad = Unidad FROM Inserted
  SELECT @Region = Region FROM ListaPrecios WHERE Lista = @Lista AND Moneda = @Moneda
  UPDATE ListaPreciosSubUnidad SET Region = @Region WHERE Lista = @Lista AND Moneda = @Moneda AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Unidad = @Unidad
END
GO
--Bug 21608
if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosSubUnidadC') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosSubUnidadC
GO
--CREATE TRIGGER tgListaPreciosSubUnidadC ON ListaPreciosSubUnidad
----WITH ENCRYPTION
--FOR UPDATE
--AS BEGIN
--  IF dbo.fnEstaSincronizando() = 1 RETURN
--  IF UPDATE(Precio)
--    INSERT ListaPreciosHist (
--           Lista,   Moneda,   Articulo,   SubCuenta,   Unidad,   Region,   PrecioActual, PrecioAnterior)
--    SELECT i.Lista, i.Moneda, i.Articulo, i.SubCuenta, i.Unidad, i.Region, i.Precio,     d.Precio
--      FROM inserted i
--      JOIN deleted d ON d.Lista = i.Lista AND d.Moneda = i.Moneda AND d.Articulo = i.Articulo AND d.SubCuenta = i.SubCuenta AND d.Unidad = i.Unidad
--END
--GO

/****** ListaPreciosGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosGrupo') and type = 'U') 
CREATE TABLE dbo.ListaPreciosGrupo (
	Grupo		varchar(50)	NOT NULL,

	CONSTRAINT priListaPreciosGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

-- drop table ListaPrecios_H1
/****** ListaPrecios_H1 ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPrecios_H1')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPrecios_H1','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPrecios_H1') and type = 'U') 
  CREATE TABLE dbo.ListaPrecios_H1 (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,

	Desc1		bit		NULL	DEFAULT 0,
	Desc2		bit		NULL	DEFAULT 0,
	Desc3		bit		NULL	DEFAULT 0,
	Desc4		bit		NULL	DEFAULT 0,
	Desc5		bit		NULL	DEFAULT 0,
	Desc6		bit		NULL	DEFAULT 0,
	Desc7		bit		NULL	DEFAULT 0,
	Desc8		bit		NULL	DEFAULT 0,
	Desc9		bit		NULL	DEFAULT 0,
	Desc10		bit		NULL	DEFAULT 0,
	Desc11		bit		NULL	DEFAULT 0,
	Desc12		bit		NULL	DEFAULT 0,
	Desc13		bit		NULL	DEFAULT 0,
	Desc14		bit		NULL	DEFAULT 0,
	Desc15		bit		NULL	DEFAULT 0,

	ListaPrecio1	varchar(20)	NULL,
	ListaPrecio2	varchar(20)	NULL,

	CONSTRAINT priListaPrecios_H1 PRIMARY KEY CLUSTERED (Lista, Moneda)
  )
GO

-- drop table ListaPreciosD_H1
/****** ListaPrecios_H1 ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPreciosD_H1')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPreciosD_H1','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPreciosD_H1') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ListaPreciosD_H1 (
	Lista		varchar(20)	NOT NULL,
	Moneda		varchar(10)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,
	RID		int		NOT NULL	IDENTITY(1,1),

	SubCuenta	varchar(50)	NULL,
	Unidad		varchar(50)	NULL,
	PrecioLista	float		NULL,
	Desc1		float		NULL,
	Desc2		float		NULL,
	Desc3		float		NULL,
	Desc4		float		NULL,
	Desc5		float		NULL,
	Desc6		float		NULL,
	Desc7		float		NULL,
	Desc8		float		NULL,
	Desc9		float		NULL,
	Desc10		float		NULL,
	Desc11		float		NULL,
	Desc12		float		NULL,
	Desc13		float		NULL,
	Desc14		float		NULL,
	Desc15		float		NULL,

	DescAlterno	float		NULL,
	GastosMaximo	float		NULL,
	GastosMinimo	float		NULL,
	GastosPromedio	float		NULL,
	Gastos		float		NULL,

	CONSTRAINT priListaPreciosD_H1 PRIMARY KEY CLUSTERED (Lista, Moneda, Articulo, RID)
  )
  EXEC spSincroSemilla 'ListaPreciosD_H1'
END
GO

EXEC spFK 'ListaPreciosD_H1','Articulo','Art','Articulo'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgListaPreciosBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaPreciosBC
GO
CREATE TRIGGER tgListaPreciosBC ON ListaPrecios
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ListaA  	varchar(20),
    @ListaN	varchar(20),
    @MonedaA	varchar(10),
    @MonedaN	varchar(10),
    @RegionA	varchar(50),
    @RegionN	varchar(50)
  IF dbo.fnEstaSincronizando() = 1 RETURN
  SELECT @ListaN = Lista, @MonedaN = Moneda, @RegionN = Region FROM Inserted
  SELECT @ListaA = Lista, @MonedaA = Moneda, @RegionA = Region FROM Deleted
  IF @ListaN=@ListaA AND @MonedaN=@MonedaA AND @RegionN=@RegionA RETURN

  IF @ListaN IS NULL
  BEGIN
    DELETE ListaPreciosD   		WHERE Lista = @ListaA AND Moneda = @MonedaA
    DELETE ListaPreciosDUnidad  	WHERE Lista = @ListaA AND Moneda = @MonedaA
    DELETE ListaPreciosSub 		WHERE Lista = @ListaA AND Moneda = @MonedaA
    DELETE ListaPreciosSubUnidad  	WHERE Lista = @ListaA AND Moneda = @MonedaA
    DELETE ListaPrecios_H1	 	WHERE Lista = @ListaA AND Moneda = @MonedaA
    DELETE ListaPreciosD_H1	 	WHERE Lista = @ListaA AND Moneda = @MonedaA
  END ELSE
  BEGIN
    UPDATE ListaPreciosD   		SET Lista = @ListaN, Moneda = @MonedaN, Region = @RegionN WHERE Lista = @ListaA AND Moneda = @MonedaA
    UPDATE ListaPreciosDUnidad   	SET Lista = @ListaN, Moneda = @MonedaN, Region = @RegionN WHERE Lista = @ListaA AND Moneda = @MonedaA
    UPDATE ListaPreciosSub 		SET Lista = @ListaN, Moneda = @MonedaN, Region = @RegionN WHERE Lista = @ListaA AND Moneda = @MonedaA
    UPDATE ListaPreciosSubUnidad	SET Lista = @ListaN, Moneda = @MonedaN, Region = @RegionN WHERE Lista = @ListaA AND Moneda = @MonedaA
    --UPDATE ListaPreciosHist		SET Lista = @ListaN, Moneda = @MonedaN, Region = @RegionN WHERE Lista = @ListaA AND Moneda = @MonedaA --Bug 21608
    UPDATE ListaPrecios_H1		SET Lista = @ListaN, Moneda = @MonedaN WHERE Lista = @ListaA AND Moneda = @MonedaA
    UPDATE ListaPreciosD_H1		SET Lista = @ListaN, Moneda = @MonedaN WHERE Lista = @ListaA AND Moneda = @MonedaA
    UPDATE Cte SET ListaPreciosEsp = @ListaN WHERE ListaPreciosEsp = @ListaA
  END
END
GO

/****** Historico de Situaciones ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSituacionHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSituacionHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSituacionHist') and type = 'U') 
CREATE TABLE dbo.ArtSituacionHist (
	Articulo		varchar(20)	NOT NULL,
	Fecha                   datetime   	NOT NULL,

	SituacionAnterior	varchar(50)	NULL,
	SituacionActual		varchar(50)	NULL,

	CONSTRAINT priArtSituacionHist PRIMARY KEY CLUSTERED (Articulo, Fecha)
)
GO

/****** Articulos por Proveedor Unidad ******/
if not exists(select * from SysTabla where SysTabla = 'ArtProvUnidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtProvUnidad','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtProvUnidad') and type = 'U') 
CREATE TABLE dbo.ArtProvUnidad (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Proveedor 		varchar(10)  	NOT NULL,
	Unidad			varchar(50)	NOT NULL,

        UltimoCosto	        float       	NULL,
	UltimaCompra		datetime	NULL,

	CONSTRAINT priArtProvUnidad PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, Unidad)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtProvUnidad' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtProvUnidad'
  EXEC spALTER_COLUMN 'ArtProvUnidad', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtProvUnidad ADD CONSTRAINT priArtProvUnidad PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, Unidad)')
END
GO
EXEC spALTER_COLUMN 'ArtProvUnidad', 'UltimoCosto', 'float NULL'
GO

/****** ArtVINAccesorio ******/
if not exists(select * from SysTabla where SysTabla = 'ArtVINAccesorio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtVINAccesorio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtVINAccesorio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtVINAccesorio (
	Articulo		varchar(20)   	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

    	Modelo			varchar(4)		NULL,
	Tipo			varchar(20)	NULL,
	Accesorio 		varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	PrecioDistribuidor	money		NULL,
	PrecioPublico		money		NULL,
	PrecioContado		money		NULL,

	CONSTRAINT priArtVINAccesorio PRIMARY KEY CLUSTERED (Articulo, ID)
  )
  EXEC spSincroSemilla 'ArtVINAccesorio'
END
GO
EXEC spALTER_TABLE 'ArtVINAccesorio', 'Modelo', 'varchar(4) NULL'
EXEC spALTER_TABLE 'ArtVINAccesorio', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ArtVINAccesorio', 'PrecioContado', 'money NULL'
GO

/****** VINHist ******/
if not exists(select * from SysTabla where SysTabla = 'VINHist')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.VINHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VINHist (
	VIN	 			varchar(20)   	NOT NULL,
	Fecha				datetime	NOT NULL,
	ID				int		NOT NULL 	IDENTITY(1,1),

	Placas				varchar(20)	NULL,
	Cliente				varchar(10)	NULL,
	Conductor			varchar(10)	NULL,
	Estatus				varchar(15)	NULL,
	Situacion			varchar(50)	NULL,
	SituacionFecha			datetime	NULL,
	SituacionUsuario		varchar(10)	NULL,
	SituacionNota			varchar(100)	NULL,

	CONSTRAINT priVINHist PRIMARY KEY CLUSTERED (VIN, Fecha, ID)
  )
  EXEC spSincroSemilla 'VINHist'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'VINHist', '(VIN, Fecha, ID)'
GO
EXEC spALTER_TABLE 'VINHist', 'Estatus', 'varchar(15) NULL'
EXEC spALTER_TABLE 'VINHist', 'Situacion', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'VINHist', 'SituacionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'VINHist', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VINHist', 'SituacionNota', 'varchar(100) NULL'
GO

EXEC spFK 'VINHist','Cliente','Cte','Cliente'
GO

/****** VINColor ******/
if not exists(select * from SysTabla where SysTabla = 'VINColor')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINColor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.VINColor') and type = 'U') 
  CREATE TABLE dbo.VINColor (
	Color			varchar(10)   	NOT NULL,

	Descripcion		varchar(50)	NULL,

	CONSTRAINT priVINColor PRIMARY KEY CLUSTERED (Color)
  )
GO

/****** FITipoFinanciamiento ******/
if not exists(select * from SysTabla where SysTabla = 'FITipoFinanciamiento')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FITipoFinanciamiento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FITipoFinanciamiento') and type = 'U') 
  CREATE TABLE dbo.FITipoFinanciamiento (
	TipoFinanciamiento	varchar(50)	NOT NULL,

	CONSTRAINT priFITipoFinanciamiento PRIMARY KEY CLUSTERED (TipoFinanciamiento)
  )
GO

/****** VINCostoExtra ******/
if not exists(select * from SysTabla where SysTabla = 'VINCostoExtra')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINCostoExtra','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.VINCostoExtra') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VINCostoExtra (
	VIN	 		varchar(20)   	NOT NULL,
	Empresa			varchar(5)		NOT NULL,
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,
	CostoExtra		float		NULL,

	SalidaID		int		NULL,

	CONSTRAINT priVINCostoExtra PRIMARY KEY CLUSTERED (VIN, Empresa, Sucursal, ID)
  )
  EXEC spSincroSemilla 'VINCostoExtra'
END
GO
EXEC spALTER_TABLE 'VINCostoExtra', 'SalidaID', 'int NULL'
GO
EXEC spALTER_COLUMN 'VINCostoExtra', 'CostoExtra', 'float NULL'
GO
/****** PolizaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'PolizaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PolizaTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PolizaTipo') and type = 'U') 
CREATE TABLE dbo.PolizaTipo (
	PolizaTipo		varchar(50)   	NOT NULL,

	CONSTRAINT priPolizaTipo PRIMARY KEY CLUSTERED (PolizaTipo)
)
GO

/****** PolizaPlan ******/
if not exists(select * from SysTabla where SysTabla = 'PolizaPlan')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PolizaPlan','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PolizaPlan') and type = 'U') 
CREATE TABLE dbo.PolizaPlan (
	PolizaPlan		varchar(50)   	NOT NULL,

	CONSTRAINT priPolizaPlan PRIMARY KEY CLUSTERED (PolizaPlan)
)
GO

/****** PolizaEstado ******/
if not exists(select * from SysTabla where SysTabla = 'PolizaEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PolizaEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PolizaEstado') and type = 'U') 
CREATE TABLE dbo.PolizaEstado (
	PolizaEstado		varchar(50)   	NOT NULL,

	CONSTRAINT priPolizaEstado PRIMARY KEY CLUSTERED (PolizaEstado)
)
GO

/****** VINSeguro ******/
if not exists(select * from SysTabla where SysTabla = 'VINSeguro')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINSeguro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.VINSeguro') and type = 'U') 
BEGIN
  CREATE TABLE dbo.VINSeguro (
	VIN	 		varchar(20)   	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	CteAseguradora		varchar(10)	NULL,
	Aseguradora		varchar(50)	NULL,
	Poliza			varchar(20)	NULL,
	PolizaTipo		varchar(50)	NULL,
	PolizaEmision		datetime	NULL,
	PolizaVencimiento	datetime	NULL,
	PolizaPlan		varchar(50)	NULL,
	PolizaEstado		varchar(50)	NULL,
	PrimaNeta		money		NULL,
	TipoDeducible		varchar(255)	NULL,
	Observaciones		varchar(255)	NULL,

	CONSTRAINT priVINSeguro PRIMARY KEY CLUSTERED (VIN, ID)
  )
  EXEC spSincroSemilla 'VINSeguro'
END
GO
EXEC spALTER_TABLE 'VINSeguro', 'CteAseguradora', 'varchar(10) NULL'
GO

EXEC spFK 'VINSeguro','CteAseguradora','Cte','Cliente'
GO

/****** VIN ******/
if not exists(select * from SysTabla where SysTabla = 'VIN')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VIN','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.VIN') and type = 'U') 
CREATE TABLE dbo.VIN (
	VIN	 			varchar(20)   	NOT NULL,

	Articulo 			varchar(20)   	NULL,
	Pedimento			varchar(20)	NULL,
	ClaveVehicular			varchar(20)	NULL,
	TipoUnidad			varchar(20)	NULL,	-- Nuevo / Usuado

	Km				int		NULL,
	KmSalida			int		NULL,
	Motor				varchar(20)	NULL,
	Llave				varchar(20)	NULL,
	Aduana				varchar(20)	NULL,
	Fecha				datetime	NULL,
	Aseguradora			varchar(50)	NULL,
	Cliente				varchar(10)	NULL,
	Conductor			varchar(10)	NULL,
	TieneMovimientos		bit		NOT NULL 	DEFAULT 0,
	Alta				datetime	NULL,
	Empresa				varchar(5)		NULL,

	Placas				varchar(20)	NULL,
	Poliza				varchar(20)	NULL,
	PolizaTipo			varchar(20)	NULL,
	PolizaVencimiento		datetime	NULL,

	GarantiaVencimiento		datetime	NULL,

	CodigoRadio			varchar(20)	NULL,
	CodigoTransmision		varchar(20)	NULL,
	CodigoColor			varchar(20)	NULL,
	CodigoLlanta1			varchar(20)	NULL,
	CodigoLlanta2			varchar(20)	NULL,
	CodigoLlanta3			varchar(20)	NULL,
	CodigoLlanta4			varchar(20)	NULL,
	CodigoLlanta5			varchar(20)	NULL,
	
	Registro			varchar(20)	NULL,
	FechaCartaCredito		datetime	NULL,
	FechaFactura 			datetime	NULL,
	FechaUltimoServicio 		datetime	NULL,
	FechaSiguienteServicio		datetime	NULL,
	PolizaImporte			money		NULL,
	Costo				float		NULL,
	CostoConGastos			float		NULL,
	Tasa				float		NULL,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	Logico4				bit		NOT NULL 	DEFAULT 0,
	Logico5				bit		NOT NULL 	DEFAULT 0,

	CambioVIN			varchar(20)	NULL,
	CambioKm			int		NULL,

    	Modelo				varchar(4)		NULL,
	ClaveFinanciera			varchar(3)		NULL,
	NumeroOrden			varchar(6)		NULL,
	TipoCompra			varchar(1)		NULL,
	FolioFacturaCompra		varchar(6)		NULL,
	FechaFacturaCompra		datetime	NULL,
	Mercado				varchar(2)		NULL,
	ClaveDistribuidor		varchar(3)		NULL,
	Descripcion1			varchar(38)	NULL,
	Descripcion2			varchar(38)	NULL,
	PrecioBasicoDistribuidor	money		NULL,
	PrecioBasicoPublico		money		NULL,
	AjusteBasicoDistribuidor	money		NULL,
	TotalAccesoriosDistribuidor	money		NULL,
	TotalAccesoriosPublico		money		NULL,
	TotalDescuentoAccesoriosMemo	money		NULL,
	TotalDescuentoDistribuidorMemo	money		NULL,
	TotalDescuentoPepPublico	money		NULL,
	Descuento1Descripcion		varchar(30)	NULL,
	Descuento1Distribuidor		money		NULL,
	Descuento1Publico		money		NULL,
	Descuento2Descripcion		varchar(30)	NULL,
	Descuento2Distribuidor		money		NULL,
	Descuento2Publico		money		NULL,
	Descuento3Descripcion		varchar(30)	NULL,
	Descuento3Distribuidor		money		NULL,
	Descuento3Publico		money		NULL,
	SeguroProvincial		money		NULL,
	GastosTraslado			money		NULL,
	SeguroAsociacion		money		NULL,
	Bonificacion15DiasSinIntereses	money		NULL,
	ReembolsoTransportacion		money		NULL,
	Bonificacion			money		NULL,
	BonificacionEnPrecio		money		NULL,
	GarantiaServicio		money		NULL,
	Miscelaneos			money		NULL,
	SubTotalFacturaCompra		money		NULL,
	IVAFacturaCompra		money		NULL,
	CoutaPublicidad			money		NULL,
	TotalFacturaCompra		money		NULL,
	NivelPrecios			varchar(3)		NULL,
--	ClaveVehicular			char(7)		NULL,
	ColorExterior			varchar(10)	NULL,
	ColorExteriorDescripcion	varchar(50)	NULL,
	ColorInterior			varchar(10)	NULL,
	ColorInteriorDescripcion	varchar(50)	NULL,
	ClaveAduana			varchar(4)		NULL,
--	Pedimento			char(7)		NULL,
	PedimentoFecha			datetime	NULL,
	CoutaFondoCivico		money		NULL,
	CoutaFordStar			money		NULL,
--	Articulo			varchar(4)		NULL,
	OtrasOpciones			varchar(22)	NULL,

	FechaEntrada			datetime	NULL,
	FechaSalida			datetime	NULL,
	FechaPago			datetime	NULL,
	VentaID				int		NULL,
	CompraID			int		NULL,
	NumeroEconomico			varchar(20)	NULL,
	Holograma			varchar(50)	NULL,
	FechaMRS			datetime	NULL,
	FechaSalidaMRS			datetime	NULL,
	Interfase			bit		NULL	DEFAULT 0,
	DiasLibresIntereses		int		NULL,
	DiasLibresAdicionales		int		NULL,
	UltimoPagoCostoPiso		datetime	NULL,
	IntercambioDirecto		bit		NULL	DEFAULT 0,
	FechaImportacion		datetime	NULL,

	Estatus				varchar(15)	NULL	DEFAULT 'ALTA',
	Situacion			varchar(50)	NULL,
	SituacionFecha			datetime	NULL,
	SituacionUsuario		varchar(10)	NULL,
	SituacionNota			varchar(100)	NULL,
	Agente				varchar(10)	NULL,

	PrecioDistribuidor		money		NULL,
	PrecioPublico			money		NULL,
	PrecioContado			money		NULL,
	ISANPublico			money 		NULL,
	ISANContado			money 		NULL,
	IVAPublico			money 		NULL,
	IVAContado			money 		NULL,

        FechaBaja                       datetime        NULL,
        BonoLealtad                     bit             NULL        DEFAULT 0,
        OtrasBonificaciones1            money           NULL,
        OtrasBonificaciones1F       	datetime        NULL,
        OtrasBonificaciones2            money           NULL,
        OtrasBonificaciones2F       	datetime        NULL,
        OtrasBonificaciones3            money           NULL,
        OtrasBonificaciones3F       	datetime        NULL,
        BonificacionContratoServicio    money           NULL,
        BonificacionContratoServicioF   datetime        NULL,

        TipoVenta                       varchar(1)         NULL,
        ImporteVenta                    money           NULL,
        Contrato                        varchar(20)     NULL,

	FIFSCAR				varchar(20)     NULL,
	FIFechaFactura			datetime	NULL,
	FIMontoFinanciar		money		NULL,
	FIFechaPagare			datetime	NULL,
	FINumeroContrato		varchar(20)     NULL,
	FIFechaCompra			datetime	NULL,
	FITipoFinanciamiento		varchar(50)	NULL,

	UltimaLlamada			datetime	NULL,
	SiguienteLlamada		datetime	NULL,
	CantidadLlamadas		int		NULL,
	NoLlamar			bit		NULL	DEFAULT 0,
	ValidarVIN			bit		NULL	DEFAULT 0,
	Blindado			bit		NULL	DEFAULT 0,
	
	CONSTRAINT priVIN PRIMARY KEY CLUSTERED (VIN)
)
GO
if (select version from version)<=2134 and exists(select * from syscampo where tabla = 'VIN' and campo = 'Pedimiento')
  EXEC sp_Rename 'VIN.Pedimiento', 'Pedimento', 'COLUMN'
go
EXEC spALTER_TABLE 'VIN', 'FechaSiguienteServicio', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'Empresa', 'varchar(5) NULL'
EXEC spALTER_TABLE 'VIN', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'Conductor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VIN', 'Km', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'CambioVIN', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VIN', 'CambioKm', 'int NULL'

EXEC spALTER_TABLE 'VIN', 'Modelo', 'varchar(4) NULL'
EXEC spALTER_TABLE 'VIN', 'ClaveFinanciera', 'char(3) NULL'
EXEC spALTER_TABLE 'VIN', 'NumeroOrden', 'char(6) NULL'
EXEC spALTER_TABLE 'VIN', 'TipoCompra', 'varchar(1) NULL'
EXEC spALTER_TABLE 'VIN', 'FolioFacturaCompra', 'char(6) NULL'
EXEC spALTER_TABLE 'VIN', 'FechaFacturaCompra', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'Mercado', 'char(2) NULL'
EXEC spALTER_TABLE 'VIN', 'ClaveDistribuidor', 'char(3) NULL'
EXEC spALTER_TABLE 'VIN', 'Descripcion1', 'char(38)	NULL'
EXEC spALTER_TABLE 'VIN', 'Descripcion2', 'char(38)	NULL'
EXEC spALTER_TABLE 'VIN', 'PrecioBasicoDistribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'PrecioBasicoPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'AjusteBasicoDistribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'TotalAccesoriosDistribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'TotalAccesoriosPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'TotalDescuentoAccesoriosMemo', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'TotalDescuentoDistribuidorMemo', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'TotalDescuentoPepPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento1Descripcion', 'char(30) NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento1Distribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento1Publico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento2Descripcion', 'char(30) NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento2Distribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento2Publico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento3Descripcion', 'char(30) NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento3Distribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Descuento3Publico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'SeguroProvincial', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'GastosTraslado', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'SeguroAsociacion', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Bonificacion15DiasSinIntereses', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'ReembolsoTransportacion', 'money	NULL'
EXEC spALTER_TABLE 'VIN', 'Bonificacion', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'BonificacionEnPrecio', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'GarantiaServicio', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Miscelaneos', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'SubTotalFacturaCompra', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'IVAFacturaCompra', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'CoutaPublicidad', 'money	NULL'
EXEC spALTER_TABLE 'VIN', 'TotalFacturaCompra', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'NivelPrecios', 'char(3) NULL'
EXEC spALTER_TABLE 'VIN', 'ColorExterior', 'char(3)NULL'
EXEC spALTER_TABLE 'VIN', 'ColorExteriorDescripcion', 'char(20) NULL'
EXEC spALTER_TABLE 'VIN', 'ColorInterior', 'char(3) NULL'
EXEC spALTER_TABLE 'VIN', 'ColorInteriorDescripcion', 'char(20) NULL'
EXEC spALTER_TABLE 'VIN', 'ClaveAduana', 'char(4) NULL'
EXEC spALTER_TABLE 'VIN', 'PedimentoFecha', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'CoutaFondoCivico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'CoutaFordStar', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasOpciones', 'char(22) NULL'
EXEC spALTER_TABLE 'VIN', 'FechaEntrada', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'FechaSalida', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'VentaID', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'CompraID', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'NumeroEconomico', 'varchar(20) NULL'
GO
if (select version from version)<=2318
  ALTER TABLE VIN ALTER COLUMN NumeroEconomico varchar(20) NULL
GO
EXEC spALTER_TABLE 'VIN', 'TipoUnidad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VIN', 'Holograma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VIN', 'FechaMRS', 'datetime	NULL'
EXEC spALTER_TABLE 'VIN', 'Interfase', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'DiasLibresIntereses', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'UltimoPagoCostoPiso', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'GarantiaVencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'IntercambioDirecto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'FechaImportacion', 'datetime	NULL'
GO
if (select version from version)<=2319
  UPDATE VIN SET Interfase = 1 WHERE FechaFacturaCompra IS NOT NULL
GO
EXEC spALTER_TABLE 'VIN', 'Estatus', 'varchar(15) NULL DEFAULT "ALTA" WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'Situacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VIN', 'SituacionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'PrecioDistribuidor', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'PrecioPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'PrecioContado', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'ISANPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'ISANContado', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'IVAPublico', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'IVAContado', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Agente', 'char(10) NULL'
EXEC spALTER_TABLE 'VIN', 'FechaBaja', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'DiasLibresAdicionales', 'int	NULL'
EXEC spALTER_TABLE 'VIN', 'BonoLealtad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones1', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones1F', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones2', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones2F', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones3', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'OtrasBonificaciones3F', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'BonificacionContratoServicio', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'BonificacionContratoServicioF', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'TipoVenta', 'varchar(1) NULL'
EXEC spALTER_TABLE 'VIN', 'ImporteVenta', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'Contrato', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VIN', 'ValidarVIN', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if (select version from version)<=2500
BEGIN
  EXEC("ALTER TABLE VIN ALTER COLUMN ColorExterior varchar(10) NULL")
  EXEC("ALTER TABLE VIN ALTER COLUMN ColorExteriorDescripcion varchar(50) NULL")
  EXEC("ALTER TABLE VIN ALTER COLUMN ColorInterior varchar(10) NULL")
  EXEC("ALTER TABLE VIN ALTER COLUMN ColorInteriorDescripcion varchar(50) NULL")
END
GO
EXEC spALTER_TABLE 'VIN', 'KmSalida', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'FIFSCAR', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VIN', 'FIFechaFactura', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'FIMontoFinanciar', 'money NULL'
EXEC spALTER_TABLE 'VIN', 'FIFechaPagare', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'FINumeroContrato', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VIN', 'FIFechaCompra', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'FITipoFinanciamiento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VIN', 'FechaPago', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'UltimaLlamada', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'SiguienteLlamada', 'datetime	NULL'
EXEC spALTER_TABLE 'VIN', 'NoLlamar', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'CantidadLlamadas', 'int NULL'
EXEC spALTER_TABLE 'VIN', 'FechaSalidaMRS', 'datetime NULL'
EXEC spALTER_TABLE 'VIN', 'Blindado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VIN', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'VIN', 'SituacionNota', 'varchar(100) NULL'
GO
if (select version from version)<=3192
BEGIN
  EXEC("spALTER_COLUMN 'VIN' ,'TipoVenta', 'varchar(1) NULL'")
  EXEC("spALTER_COLUMN 'VIN' ,'TipoCompra', 'varchar(1) NULL'")
END
GO
EXEC spALTER_COLUMN 'VIN', 'Costo', 'float NULL'
EXEC spALTER_COLUMN 'VIN', 'CostoConGastos', 'float NULL'
GO

EXEC spFK 'VIN','Articulo','Art','Articulo'
EXEC spFK 'VIN','Cliente','Cte','Cliente'
EXEC spFK 'VIN','ColorExterior','VINColor','Color'
EXEC spFK 'VIN','Agente','Agente','Agente'
EXEC spFK 'VIN','CompraID','Compra','ID'
EXEC spFK 'VIN','VentaID','Venta','ID'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VIN' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.VIN (Articulo, VIN)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VIN' AND sysindexes.name = 'Placas' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Placas ON dbo.VIN (Placas)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VIN' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.VIN (Cliente)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VIN' AND sysindexes.name = 'NumeroEconomico' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NumeroEconomico ON dbo.VIN (NumeroEconomico)
go

/****** VINAccesorio ******/
if not exists(select * from SysTabla where SysTabla = 'VINAccesorio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINAccesorio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.VINAccesorio') and type = 'U') 
CREATE TABLE dbo.VINAccesorio (
	VIN	 		varchar(20)   	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Tipo			varchar(50)	NULL,
	Accesorio 		varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	PrecioDistribuidor	money		NULL,
	PrecioPublico		money		NULL,
	PrecioContado		money		NULL,
        Bonificacion            money           NULL,
        Estadistica             money           NULL,
	Estatus			varchar(15)	NULL		DEFAULT 'ALTA',
	Usuario			varchar(10)	NULL,
	FechaAlta		datetime	NULL,
	UltimoCambio		datetime	NULL,
	VINDestino		varchar(20)	NULL,

	CONSTRAINT priVINAccesorio PRIMARY KEY CLUSTERED (VIN, ID)
)
GO
if (select version from version)<=2400
BEGIN
  ALTER TABLE VINAccesorio ALTER COLUMN Accesorio varchar(20) NULL
  ALTER TABLE VINAccesorio ALTER COLUMN Descripcion varchar(100) NULL
END
GO
EXEC spALTER_TABLE 'VINAccesorio', 'Tipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'PrecioContado', 'money NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'Estatus', 'char(15)	NULL DEFAULT "ALTA" WITH VALUES'
EXEC spALTER_TABLE 'VINAccesorio', 'Usuario', 'char(10)	NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'FechaAlta', 'datetime NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'VINDestino', 'varchar(20) NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'Bonificacion', 'money NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'Estadistica', 'money NULL'
EXEC spALTER_TABLE 'VINAccesorio', 'UltimoCambio', 'datetime NULL'
GO
if (select version from version)<=2600
  ALTER TABLE VINAccesorio ALTER COLUMN Tipo varchar(50) NULL
GO

EXEC spFK 'VINAccesorio','VIN','VIN','VIN'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgVINAccesorioABC') and sysstat & 0xf = 8) drop trigger dbo.tgVINAccesorioABC
GO
CREATE TRIGGER tgVINAccesorioABC ON VINAccesorio
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @VIN		varchar(20),
    @TipoUnidad		varchar(20),
    @Empresa		varchar(5),
    @Articulo		varchar(20),
    @Tabla		varchar(50),
    @TablaISAN		varchar(50),
    @TablaISANLujo	varchar(50),
    @ImporteISANLujo	float,
    @ArtImpuesto1	float, 
    @ArtImpuesto2	float, 
    @PrecioDistribuidor	money,
    @PrecioPublico	money,
    @PrecioContado	money,
    @ISANPublico	money,
    @ISANContado	money,
    @IVAPublico		money,
    @IVAContado		money,
    @ISANLujo		money

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ISANPublico = NULL, @ISANContado = NULL,
         @IVAPublico  = NULL, @IVAContado  = NULL

  SELECT @VIN = MIN(VIN) FROM Inserted
  IF @VIN IS NULL
    SELECT @VIN = MIN(VIN) FROM Deleted

  SELECT @Empresa = Empresa,
         @Articulo = Articulo,
         @TipoUnidad = UPPER(TipoUnidad)
    FROM VIN 
   WHERE VIN = @VIN

  SELECT @TablaISAN = TablaISAN, @TablaISANLujo = TablaISANLujo, @ImporteISANLujo = ImporteISANLujo FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @ArtImpuesto1 = Impuesto1, @ArtImpuesto2 = NULLIF(Impuesto2, 0) FROM Art WHERE Articulo = @Articulo

  SELECT @PrecioDistribuidor = SUM(PrecioDistribuidor),
         @PrecioPublico      = SUM(PrecioPublico),
         @PrecioContado      = SUM(PrecioContado)
    FROM VINAccesorio 
   WHERE VIN = @VIN AND Estatus = 'ALTA'

  IF @TipoUnidad = 'NUEVO'
  BEGIN
    -- ISAN Precio Publico
    IF @ArtImpuesto2 IS NOT NULL
      SELECT @ISANPublico =  @PrecioPublico * (@ArtImpuesto2/100.0)
    ELSE
      EXEC spTablaImpuesto @TablaISAN, NULL, '(Sin Periodo)', @PrecioPublico, @ISANPublico OUTPUT   

    IF @PrecioPublico >= @ImporteISANLujo 
    BEGIN
      EXEC spTablaImpuesto @TablaISANLujo, NULL, '(Sin Periodo)', @PrecioPublico, @ISANLujo OUTPUT   
      SELECT @ISANPublico = @ISANPublico - ISNULL(@ISANLujo, 0.0)
    END

    -- ISAN Precio Contado
    IF @ArtImpuesto2 IS NOT NULL
      SELECT @ISANContado =  @PrecioContado * (@ArtImpuesto2/100.0)
    ELSE
      EXEC spTablaImpuesto @TablaISAN, NULL, '(Sin Periodo)', @PrecioContado, @ISANContado OUTPUT   

    IF @PrecioContado >= @ImporteISANLujo 
    BEGIN
      EXEC spTablaImpuesto @TablaISANLujo, NULL, '(Sin Periodo)', @PrecioContado, @ISANLujo OUTPUT   
      SELECT @ISANContado = @ISANContado - ISNULL(@ISANLujo, 0.0)
    END
  END

  -- IVA
  SELECT @IVAPublico = (@PrecioPublico + ISNULL(@ISANPublico, 0)) * (@ArtImpuesto1/100)
  SELECT @IVAContado = (@PrecioContado + ISNULL(@ISANContado, 0)) * (@ArtImpuesto1/100)

  UPDATE VIN 
     SET PrecioDistribuidor = @PrecioDistribuidor,
         PrecioPublico      = @PrecioPublico,
         PrecioContado      = @PrecioContado,
         ISANPublico	    = @ISANPublico,
         ISANContado	    = @ISANContado,
         IVAPublico	    = @IVAPublico,
         IVAContado	    = @IVAContado
   WHERE VIN = @VIN

  IF (SELECT VINCostoSumaAccesorios FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
    UPDATE SerieLote SET CostoPromedio = @PrecioDistribuidor WHERE Empresa = @Empresa AND SerieLote = @VIN AND Existencia > 0
END
GO

-- triggers
if exists (select * from sysobjects where id = object_id('dbo.tgVINBC') and sysstat & 0xf = 8) drop trigger dbo.tgVINBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgVINABC') and sysstat & 0xf = 8) drop trigger dbo.tgVINABC
GO
CREATE TRIGGER tgVINABC ON VIN
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @VIN	varchar(20),
    @Modelo	varchar(4),
    @Hoy	datetime,
    @Empresa	varchar(5),
    @Km		int,
    @Articulo	varchar(20),
    @SigKms	int,
    @KmsxDia	int,
    @Dias	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Hoy = GETDATE()
  EXEC spExtraerFecha @Hoy OUTPUT
  IF EXISTS(SELECT VIN FROM Inserted)
  BEGIN
    IF UPDATE(Km)
    BEGIN
      SELECT @VIN = VIN, @Modelo = Modelo, @Empresa = Empresa, @Articulo = Articulo, @Km = Km FROM Inserted
      SELECT @KmsxDia = KmsxMes / 30 FROM EmpresaCfg WHERE Empresa = @Empresa
      SELECT @SigKms = MIN(Kms) FROM ArtKms WHERE Articulo = @Articulo AND Kms>@Km   
      SELECT @Dias = (@SigKms - @Km) / @KmsxDia
      IF ISNULL(@Dias, 0)>=0 
        UPDATE VIN SET FechaSiguienteServicio = DATEADD(day, @Dias, @Hoy) WHERE VIN = @VIN
    END
    IF (SELECT ISNULL(Interfase, 0) FROM Inserted) = 0 AND @Articulo IS NOT NULL
    BEGIN
      IF NOT EXISTS(SELECT * FROM VINAccesorio WHERE VIN = @VIN)
        IF (SELECT VINAccesorioArt FROM EmpresaCfg2 WHERE Empresa = @Empresa) = 1
          INSERT VINAccesorio (VIN, Tipo, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado, FechaAlta, Estatus)
                       SELECT @VIN, av.Tipo, av.Accesorio, a.Descripcion1, a.CostoEstandar, a.PrecioLista, a.Precio2, @Hoy, 'ALTA'
                         FROM ArtVINAccesorio av, Art a
                        WHERE av.Articulo = @Articulo AND a.Articulo = av.Accesorio
        ELSE
          INSERT VINAccesorio (VIN, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado, FechaAlta, Estatus)
                       SELECT @VIN, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado, @Hoy, 'ALTA'
                         FROM ArtVINAccesorio
                        WHERE Articulo = @Articulo AND Modelo = @Modelo
    END
  END 

  IF UPDATE(Placas) OR UPDATE(Cliente) OR UPDATE(Conductor) OR UPDATE(Estatus) OR UPDATE(Situacion)
    INSERT VINHist (VIN, Fecha, Placas, Cliente, Conductor, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota)
    SELECT VIN, GETDATE(), Placas, Cliente, Conductor, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota 
     FROM Inserted

  IF NOT EXISTS(SELECT VIN FROM Inserted) AND EXISTS(SELECT VIN FROM Deleted) 
    DELETE VINAccesorio WHERE VIN IN (SELECT VIN FROM Deleted) 
END
GO


EXEC spReplicaTema 'VIN', 'VIN',		'VIN', @Principal = 1
EXEC spReplicaTema 'VIN', 'VINAccesorio',	'VIN'
EXEC spReplicaTema 'VIN', 'VINSeguro',		'VIN'
EXEC spReplicaTema 'VIN', 'VINCostoExtra',	'VIN'
GO


/****** VINTipoAccesorio ******/
if not exists(select * from SysTabla where SysTabla = 'VINTipoAccesorio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VINTipoAccesorio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.VINTipoAccesorio') and type = 'U') 
CREATE TABLE dbo.VINTipoAccesorio (
	Tipo			varchar(20)	NOT NULL,

	CONSTRAINT priVINTipoAccesorio PRIMARY KEY CLUSTERED (Tipo)
)
GO

/****** OpcionListaD ******/
if not exists(select * from SysTabla where SysTabla = 'OpcionListaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OpcionListaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OpcionListaD') and type = 'U') 
CREATE TABLE dbo.OpcionListaD (
	Opcion		char(1) 	NOT NULL,
	Lista		varchar(50)	NOT NULL,
	Numero		int		NOT NULL,

	CONSTRAINT priOpcionListaD PRIMARY KEY CLUSTERED (Opcion, Lista, Numero)
)
GO

EXEC spFK2 'OpcionListaD','Opcion','Numero','OpcionD','Opcion','Numero'
GO

/****** OpcionLista ******/
if not exists(select * from SysTabla where SysTabla = 'OpcionLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OpcionLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OpcionLista') and type = 'U') 
CREATE TABLE dbo.OpcionLista (
	Opcion		char(1) 	NOT NULL,
	Lista		varchar(50)	NOT NULL,

	CONSTRAINT priOpcionLista PRIMARY KEY CLUSTERED (Opcion, Lista)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOpcionListaBC') and sysstat & 0xf = 8) drop trigger dbo.tgOpcionListaBC
GO
CREATE TRIGGER tgOpcionListaBC ON OpcionLista
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @OpcionN 	char(1),
    @OpcionA	char(1),
    @ListaN	varchar(50),
    @ListaA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @OpcionN = Opcion, @ListaN = Lista FROM Inserted
  SELECT @OpcionA = Opcion, @ListaA = Lista  FROM Deleted

  IF @OpcionN = @OpcionA AND @ListaN = @ListaA RETURN

  IF @OpcionN IS NULL
  BEGIN
    DELETE OpcionListaD    WHERE Opcion = @OpcionA AND Lista = @ListaA
  END ELSE
  BEGIN
    UPDATE OpcionListaD SET Opcion = @OpcionN, Lista = @ListaN WHERE Opcion = @OpcionA AND Lista = @ListaA
  END
END
GO

/****** OpcionD ******/
if not exists(select * from SysTabla where SysTabla = 'OpcionD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OpcionD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OpcionD') and type = 'U') 
CREATE TABLE dbo.OpcionD (
	Opcion			char(1) 	NOT NULL,
	Numero			int		NOT NULL,

	Nombre			varchar(100)	NULL,
	
	InformacionAdicional	varchar(100)	NULL, --MEJORA1394
	Imagen					varchar(255)	NULL, --MEJORA1394
	
	TieneMovimientos	bit		NULL	DEFAULT 0,
	
	Descontinuado		bit		NULL	DEFAULT 0, --MEJORA5547

	CONSTRAINT priOpcionD PRIMARY KEY CLUSTERED (Opcion, Numero)
)
GO
if not exists(select * from syscampo where tabla = 'OpcionD' and campo = 'TieneMovimientos')
  ALTER TABLE OpcionD ADD TieneMovimientos bit NULL DEFAULT 0 WITH VALUES
GO

EXEC spALTER_TABLE 'OpcionD', 'InformacionAdicional', 'varchar(100)	NULL' --MEJORA1394
EXEC spALTER_TABLE 'OpcionD', 'Imagen', 'varchar(255)	NULL' --MEJORA1394
EXEC spALTER_TABLE 'OpcionD', 'Descontinuado', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA5547
GO

/****** Opcion ******/
if not exists(select * from SysTabla where SysTabla = 'Opcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Opcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Opcion') and type = 'U') 
CREATE TABLE dbo.Opcion (
	Opcion			char(1) 	NOT NULL,

	Descripcion		varchar(100)	NULL,
	TieneDetalle		bit		NOT NULL DEFAULT 0,
	OrdenDetalle		varchar(20)	NULL,
	AyudaCaptura	 	varchar(50)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
	TipoDetalle		varchar(20)	NULL	DEFAULT 'Numero',
	Vista			varchar(20)	NULL,
	Rango			varchar(20)	NULL,
	Periodos		int		NULL,
	BloquearAnteriores	bit		NULL	DEFAULT 0,
	DescripcionCorta	varchar(20)	NULL,

	CONSTRAINT priOpcion PRIMARY KEY CLUSTERED (Opcion)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgOpcionBC') and sysstat & 0xf = 8) drop trigger dbo.tgOpcionBC
GO
if not exists(select * from syscampo where tabla = 'Opcion' and campo = 'TieneMovimientos')
  ALTER TABLE Opcion ADD TieneMovimientos bit NULL DEFAULT 0 WITH VALUES
GO
if not exists(select * from syscampo where tabla = 'Opcion' and campo = 'AyudaCaptura')
BEGIN
  EXEC("ALTER TABLE Opcion ADD AyudaCaptura varchar(50) NULL")
  EXEC("UPDATE Opcion SET AyudaCaptura = 'Nombre'")
END
GO
EXEC spALTER_TABLE 'Opcion', 'TipoDetalle', 'varchar(20) NULL DEFAULT "Numero" WITH VALUES'
EXEC spALTER_TABLE 'Opcion', 'Vista', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Opcion', 'Rango', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Opcion', 'Periodos', 'int NULL'
EXEC spALTER_TABLE 'Opcion', 'BloquearAnteriores', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Opcion', 'DescripcionCorta', 'varchar(20) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'opcion', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'opcion', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

CREATE TRIGGER tgOpcionBC ON Opcion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @OpcionN 	char(1),
    @OpcionA	char(1),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @OpcionN = Opcion FROM Inserted
  SELECT @OpcionA = Opcion FROM Deleted

  IF @OpcionN = @OpcionA RETURN

  IF @OpcionN IS NULL
  BEGIN
    DELETE OpcionD     WHERE Opcion = @OpcionA
    DELETE OpcionLista WHERE Opcion = @OpcionA
    DELETE ArtOpcion   WHERE Opcion = @OpcionA
    DELETE ArtOpcionD  WHERE Opcion = @OpcionA
  END ELSE
  BEGIN
    UPDATE OpcionD     SET Opcion = @OpcionN WHERE Opcion = @OpcionA
    UPDATE OpcionLista SET Opcion = @OpcionN WHERE Opcion = @OpcionA
    UPDATE ArtOpcion   SET Opcion = @OpcionN WHERE Opcion = @OpcionA
    UPDATE ArtOpcionD  SET Opcion = @OpcionN WHERE Opcion = @OpcionA
  END
END
GO

--Intregación CRM
IF OBJECT_ID ('tr_Opcion', 'TR') IS NOT NULL  DROP TRIGGER tr_Opcion 
GO									
CREATE TRIGGER tr_Opcion ON Opcion 
--//WITH ENCRYPTION
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update Opcion  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Opcion= Opcion.Opcion
	END
END
GO

/****** OpcionPrecio ******/
if not exists(select * from SysTabla where SysTabla = 'OpcionPrecio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OpcionPrecio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OpcionPrecio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OpcionPrecio (
	ID		int  		NOT NULL IDENTITY(1,1),
	Opcion		varchar(20) 	NULL,
	Articulo	varchar(20)	NULL,
	Precio		money		NULL,
	Porcentaje	float		NULL,
	Moneda		varchar(10)	NULL,
	Sucursal	int		NOT NULL DEFAULT 0,

	CONSTRAINT priOpcionPrecio PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'OpcionPrecio'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'OpcionPrecio', '(ID)'
GO
EXEC spALTER_TABLE 'OpcionPrecio', 'Porcentaje', 'float	NULL'
GO

EXEC spFK 'OpcionPrecio','Articulo','Art','Articulo'
GO

/****** ArtExistenciaGlobal ******/
if exists(select * from SysTabla where SysTabla = 'ArtExistenciaGlobal')
DELETE SysTabla WHERE SysTabla = 'ArtExistenciaGlobal'
if exists (select * from sysobjects where id = object_id('dbo.ArtExistenciaGlobal') and type = 'U') 
DROP TABLE dbo.ArtExistenciaGlobal
GO

/****** ArtIdioma ******/
if not exists(select * from SysTabla where SysTabla = 'ArtIdioma')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtIdioma','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtIdioma') and type = 'U') 
CREATE TABLE dbo.ArtIdioma (
	Articulo	varchar(20)	NOT NULL,
	Idioma		varchar(50)	NOT NULL,

	Codigo		varchar(20)	NULL,
	Descripcion	varchar(255)	NULL,

	CONSTRAINT priArtIdioma PRIMARY KEY  CLUSTERED (Articulo, Idioma)
)
GO

/****** ArtUlt ******/
if not exists(select * from SysTabla where SysTabla = 'ArtUlt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtUlt','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtUlt') and type = 'U') 
CREATE TABLE dbo.ArtUlt (
	Articulo	varchar(20)	NOT NULL,

	UltimaVenta	datetime	NULL,
	UltimaCompra	datetime	NULL,	

	CONSTRAINT priArtUlt PRIMARY KEY  CLUSTERED (Articulo)
)
GO

/****** ArtCompraProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCompraProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCompraProrrateo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCompraProrrateo') and type = 'U') 
CREATE TABLE dbo.ArtCompraProrrateo (
	Articulo	varchar(20)	NOT NULL,
	Grupo		varchar(50)	NOT NULL,

	Porcentaje	float		NULL,	
	Cantidad	float		NULL,	

	CONSTRAINT priArtCompraProrrateo PRIMARY KEY CLUSTERED (Articulo, Grupo)
)
GO
EXEC spALTER_TABLE 'ArtCompraProrrateo', 'Cantidad', 'float NULL'
GO

/****** EmpresaCompraProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCompraProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCompraProrrateo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCompraProrrateo') and type = 'U') 
CREATE TABLE dbo.EmpresaCompraProrrateo (
	Empresa		varchar(20)	NOT NULL,
	Grupo		varchar(50)	NOT NULL,

	Porcentaje	float		NULL,	

	CONSTRAINT priEmpresaCompraProrrateo PRIMARY KEY CLUSTERED (Empresa, Grupo)
)
GO



/****** ArtKms ******/
if not exists(select * from SysTabla where SysTabla = 'ArtKms')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtKms','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtKms') and type = 'U') 
CREATE TABLE dbo.ArtKms (
	Articulo	varchar(20)	NOT NULL,
	Kms		int		NOT NULL,

	CONSTRAINT priArtKms PRIMARY KEY  CLUSTERED (Articulo, Kms)
)
GO

/****** Acceso Articulos ******/
if not exists(select * from SysTabla where SysTabla = 'ArtAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAcceso') and type = 'U') 
CREATE TABLE dbo.ArtAcceso (
	Articulo		varchar(20) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priArtAcceso PRIMARY KEY  CLUSTERED (Articulo, Usuario)
)
go
if (select version from version)<=2323
BEGIN
  EXEC("spEliminarPK 'ArtAcceso'")
  EXEC("ALTER TABLE ArtAcceso ALTER COLUMN Articulo varchar(20) NOT NULL")
  EXEC("ALTER TABLE ArtAcceso ADD CONSTRAINT priArtAcceso PRIMARY KEY  CLUSTERED (Articulo, Usuario)")
END
GO

/****** LoteFijo ******/
if not exists(select * from SysTabla where SysTabla = 'LoteFijo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LoteFijo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LoteFijo') and type = 'U') 
CREATE TABLE dbo.LoteFijo (
	Lote			varchar(20) 	NOT NULL,

	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,

	Cuenta1			varchar(20)	NULL,
	Cuenta2			varchar(20)	NULL,
	Cuenta3			varchar(20)	NULL,
	Cuenta5			varchar(20)	NULL,

	CONSTRAINT priLoteFijo PRIMARY KEY  CLUSTERED (Lote)
)
go
EXEC spALTER_TABLE 'LoteFijo', 'Cuenta1', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LoteFijo', 'Cuenta2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LoteFijo', 'Cuenta3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LoteFijo', 'Cuenta5', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LoteFijo', 'Impuesto5', 'float NULL'
go

EXEC spFK 'LoteFijo','Cuenta1','Cta','Cuenta'
GO

/****** Metodo ******/
if not exists(select * from SysTabla where SysTabla = 'Metodo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Metodo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Metodo') and type = 'U') 
CREATE TABLE dbo.Metodo (
	Metodo			varchar(50) 	NOT NULL,
	Nombre			varchar(100)	NULL,

	Descripcion		text		NULL,

	CONSTRAINT priMetodo PRIMARY KEY  CLUSTERED (Metodo)
)
go
EXEC spALTER_TABLE 'Metodo', 'Nombre', 'varchar(100) NULL'
go

/****** ArtLoteFijo ******/
if not exists(select * from SysTabla where SysTabla = 'ArtLoteFijo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtLoteFijo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtLoteFijo') and type = 'U') 
CREATE TABLE dbo.ArtLoteFijo (
	Articulo		varchar(20) 	NOT NULL,
	Lote			varchar(20) 	NOT NULL,

	CONSTRAINT priArtLoteFijo PRIMARY KEY  CLUSTERED (Articulo, Lote)
)
go

/****** ArtCalidad ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCalidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCalidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCalidad') and type = 'U') 
CREATE TABLE dbo.ArtCalidad (
	Articulo		varchar(20) 	NOT NULL,
	Evaluacion		varchar(50) 	NOT NULL,

	Minimo			float		NULL,
	Maximo			float		NULL,
	Unidad			varchar(50)	NULL,
	Metodo			varchar(50)	NULL,

	CONSTRAINT priArtCalidad PRIMARY KEY  CLUSTERED (Articulo, Evaluacion)
)
go
EXEC spALTER_TABLE 'ArtCalidad', 'Unidad', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'ArtCalidad', 'Metodo', 'varchar(50)	NULL'
go

EXEC spFK 'ArtCalidad','Metodo','Metodo','Metodo'
GO

/****** ArtInfoAdicional ******/
if not exists(select * from SysTabla where SysTabla = 'ArtInfoAdicional')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtInfoAdicional','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtInfoAdicional') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtInfoAdicional (
	Articulo		varchar(20) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Datos			varchar(255)	NULL,
	Orden			int		NULL,

	CONSTRAINT priArtInfoAdicional PRIMARY KEY  CLUSTERED (Articulo, ID)
  )
  EXEC spSincroSemilla 'ArtInfoAdicional'
END
go

/****** ArtDescuentoCompra ******/
if not exists(select * from SysTabla where SysTabla = 'ArtDescuentoCompra')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtDescuentoCompra','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtDescuentoCompra') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtDescuentoCompra (
	Articulo		varchar(20) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Porcentaje		float		NULL,
	Concepto		varchar(50)	NULL,

	CONSTRAINT priArtDescuentoCompra PRIMARY KEY  CLUSTERED (Articulo, ID)
  )
  EXEC spSincroSemilla 'ArtDescuentoCompra'
END
go

/****** ArtACCupon ******/
if not exists(select * from SysTabla where SysTabla = 'ArtACCupon')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtACCupon','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtACCupon') and type = 'U') 
CREATE TABLE dbo.ArtACCupon (
	Articulo	varchar(20)	NOT NULL,
	Cupon		int		NOT NULL,

	Derecho		varchar(100)	NULL,
	Porcentaje	float		NULL,
	Importe		money		NULL,
	PagoDividendos	bit		NULL	DEFAULT 0,

	CONSTRAINT priArtACCupon PRIMARY KEY  CLUSTERED (Articulo, Cupon)
  )
go

/****** ArtOperacion ******/
if not exists(select * from SysTabla where SysTabla = 'ArtOperacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtOperacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtOperacion') and type = 'U') 
CREATE TABLE dbo.ArtOperacion (
	Operacion		varchar(100)	NOT NULL,

	CONSTRAINT priOperacion PRIMARY KEY  CLUSTERED (Operacion)
)
GO

/****** ArtProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'ArtProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtProrrateo','Cuenta')
ELSE UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'ArtProrrateo'
GO
if not exists (select * from sysobjects where id = object_id('dbo.ArtProrrateo') and type = 'U') 
CREATE TABLE dbo.ArtProrrateo(
	Art			varchar(20)		NOT NULL,
	RenglonID		int IDENTITY(1,1)	NOT NULL,
	EmpresaProrrateo	varchar(7)		NULL DEFAULT ('(Todas)'),
	SucursalProrrateo	int			NULL,
	CCProrrateo		varchar(20)		NULL,
	CC2Prorrateo		varchar(20)		NULL,
	CC3Prorrateo		varchar(20)		NULL,
	EspacioProrrateo	varchar(10)		NULL,
	VINProrrateo		varchar(20)		NULL,
	ProyectoProrrateo	varchar(50)		NULL,
	UENProrrateo		int			NULL,
	ActividadProrrateo	varchar(100)		NULL,
	Porcentaje		float			NULL,

	CONSTRAINT priArtProrrateo PRIMARY KEY  CLUSTERED (Art, RenglonID)
)
GO

EXEC spFK 'ArtProrrateo','Art','Art','Articulo'
GO

/**************** spArtValidarProrrateo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArtValidarProrrateo') and type = 'P') drop procedure dbo.spArtValidarProrrateo
GO             
CREATE PROCEDURE spArtValidarProrrateo
		
		@Articulo		varchar(20)

--//WITH ENCRYPTION
AS BEGIN
 
  IF (SELECT SUM(Porcentaje) FROM ArtProrrateo WHERE Art = @Articulo) = 100 
    SELECT 1
  ELSE	
    SELECT 0  
   
END
GO

/****** Articulos ******/
if not exists(select * from SysTabla where SysTabla = 'Art')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Art','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Art') and type = 'U') 
CREATE TABLE dbo.Art (
	Articulo 		varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion1 		varchar(100) 	NULL,
	Descripcion2 		varchar(255) 	NULL,
	NombreCorto		varchar(20)	NULL,
        Grupo			varchar(50)	NULL,
	Categoria 		varchar(50) 	NULL,
	CategoriaActivoFijo	varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	Linea			varchar(50) 	NULL,
	Fabricante 		varchar(50)  	NULL,
	ClaveFabricante		varchar(50)	NULL,
	Impuesto1 		float	  	NOT NULL,
	Impuesto2 		float	  	NULL,
	Impuesto3		float		NULL,
	Factor			varchar(50)  	NULL,
	Unidad       		varchar(50)  	NULL,
	UnidadCompra  		varchar(50)  	NULL,
	UnidadTraspaso		varchar(50)  	NULL,
	UnidadCantidad		float		NULL,
	TipoCosteo		varchar(10)  	NULL,
	Peso			float		NULL,
	Tara			float	    	NULL,
	Volumen			float		NULL,
	Tipo			varchar(20)	NOT NULL DEFAULT 'Normal',
	TipoOpcion		varchar(20)	NOT NULL DEFAULT 'No',
	Accesorios		bit		NOT NULL DEFAULT 0,
	Refacciones		bit       	NOT NULL DEFAULT 0,
	Sustitutos		bit		NOT NULL DEFAULT 0,
	Servicios		bit       	NULL 	 DEFAULT 0,
	Consumibles		bit		NULL 	 DEFAULT 0,

	MonedaCosto 		varchar(10)  	NOT NULL,
	MonedaPrecio 		varchar(10)  	NOT NULL,
	MargenMinimo		money     	NULL,  
	PrecioLista		money     	NULL,
	PrecioMinimo		money		NULL,
        FactorAlterno		float		NULL,
	PrecioAnterior		money		NULL,
	Utilidad		varchar(50)	NULL,
	DescuentoCompra		float		NULL,

	Clase			varchar(15)	NULL,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	Comision		varchar(50)	NULL,
	Arancel			varchar(50)	NULL,
	ArancelDesperdicio	varchar(50)	NULL,
	ABC				varchar(1)		NULL,
	Usuario			varchar(10)	NULL,

	Precio2			money		NULL,
	Precio3			money		NULL,
	Precio4			money		NULL,
	Precio5			money		NULL,
	Precio6			money		NULL,
	Precio7			money		NULL,
	Precio8			money		NULL,
	Precio9			money		NULL,
	Precio10		money		NULL,

	Refrigeracion		bit		NOT NULL 	DEFAULT 0,
	TieneCaducidad		bit		NOT NULL 	DEFAULT 0,
	BasculaPesar		bit		NULL 		DEFAULT 0,
	SeProduce		bit		NOT NULL 	DEFAULT 0,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,
	EstatusPrecio		varchar(15) 	NULL		DEFAULT 'NUEVO',

	wMostrar		bit		NULL 		DEFAULT 1,
	Merma			float		NULL,
	Desperdicio		float		NULL,

	SeCompra		bit		NULL		DEFAULT 0,
	SeVende			bit		NULL		DEFAULT 0,
	EsFormula		bit		NULL		DEFAULT 0,

	TiempoEntrega		int		NULL,
	TiempoEntregaUnidad	varchar(10) 	NULL,
	TiempoEntregaSeg	int		NULL,
	TiempoEntregaSegUnidad	varchar(10) 	NULL,

	LoteOrdenar		varchar(30)	NULL,
	CantidadOrdenar		float		NULL,           -- Antes ProdTamanoLote
	MultiplosOrdenar	float		NULL,
	InvSeguridad		float		NULL,
	ProdRuta		varchar(20)	NULL,
	AlmacenROP		varchar(10)	NULL,

	CategoriaProd		varchar(50) 	NULL,
	ProdCantidad		float		NULL		DEFAULT 1,
	ProdUsuario		varchar(10)	NULL  		DEFAULT '(Mismo)',
	ProdPasoTotal		int		NULL  		DEFAULT 1,
	ProdMovGrupo		varchar(50)	NULL,
	ProdEstacion		varchar(10)	NULL,
	ProdOpciones		bit		NOT NULL 	DEFAULT 0,
	ProdVerConcentracion 	bit		NULL 		DEFAULT 0,
	ProdVerCostoAcumulado	bit		NULL 		DEFAULT 0,
	ProdVerMerma		bit		NULL 		DEFAULT 0,
	ProdVerDesperdicio	bit		NULL 		DEFAULT 0,
	ProdVerPorcentaje	bit		NULL 		DEFAULT 0,

	RevisionUltima		datetime	NULL,
	RevisionUsuario		varchar(10)	NULL,
	RevisionFrecuencia	int		NULL,
	RevisionFrecuenciaUnidad varchar(10)	NULL,
	RevisionSiguiente	datetime	NULL,

	ProdMov			varchar(20)	NULL		DEFAULT '(por omision)', -- Disponible
	TipoCompra		varchar(20)	NULL,		-- Local, Centralizada, etc.

	TieneMovimientos	bit		NULL		DEFAULT 0,
	Registro1		varchar(20)	NULL,
	Registro1Vencimiento	datetime	NULL,
	AlmacenEspecificoVenta	varchar(10)	NULL,
	AlmacenEspecificoVentaMov varchar(20)	NULL,
	RutaDistribucion	varchar(50)	NULL,

	CostoEstandar		float	  	NULL,
	CostoReposicion		float		NULL,
	EstatusCosto		varchar(15) 	NULL		DEFAULT 'SINCAMBIO',
	Margen			money     	NULL,  
	Proveedor		varchar(10)	NULL,
        NivelAcceso		varchar(50)	NULL,
	Temporada		varchar(50)	NULL,
	SolicitarPrecios	bit		NULL		DEFAULT 0,
	AutoRecaudacion		varchar(30)	NULL,
	Concepto		varchar(50)	NULL,
	Cuenta			varchar(20)	NULL,
	Retencion1		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,

	Espacios		bit		NULL		DEFAULT 0,
	EspaciosEspecificos	bit		NULL		DEFAULT 0,

	EspaciosSobreventa	float		NULL,
	EspaciosNivel		varchar(50)	NULL		DEFAULT 'Dia',
	EspaciosMinutos		int		NULL		DEFAULT 60,
	EspaciosBloquearAnteriores bit		NULL		DEFAULT 1,
	EspaciosHoraD		varchar(5)	NULL,
	EspaciosHoraA		varchar(5)	NULL,

	SerieLoteInfo		bit		NULL		DEFAULT 0,
	CantidadMinimaVenta	float		NULL,
	CantidadMaximaVenta	float		NULL,
	EstimuloFiscal		float		NULL,

	OrigenPais		varchar(50)	NULL,
	OrigenLocalidad		varchar(50)	NULL,
	Incentivo		money		NULL,
	FactorCompra		float		NULL		DEFAULT 1.0,
	Horas			float		NULL,
	ISAN			bit		NULL		DEFAULT 0,
	ExcluirDescFormaPago	bit		NULL		DEFAULT 0,
	EsDeducible		bit		NULL		DEFAULT 0,
	Peaje			money		NULL,
	CodigoAlterno		varchar(50)	NULL,
	TipoCatalogo		varchar(20)	NULL		DEFAULT 'Resurtible',
	AnexosAlFacturar	bit		NULL		DEFAULT 0,
	CaducidadMinima		int		NULL,
	Actividades		bit		NULL		DEFAULT 0,
	ValidarPresupuestoCompra varchar(20)	NULL		DEFAULT 'No',
	SeriesLotesAutoOrden	varchar(20)	NULL		DEFAULT '(Empresa)',
	LotesFijos		bit		NULL		DEFAULT 0,
	LotesAuto		bit		NULL		DEFAULT 0,
	Consecutivo		int		NULL,
	TipoEmpaque		varchar(50)	NULL,

	Modelo			varchar(4)		NULL,
	Version			varchar(50)	NULL,

        TieneDireccion          bit		NULL		DEFAULT 0,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(100)  	NULL,
	Delegacion		varchar(100) 	NULL,
	Poblacion 		varchar(100)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)  	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Ruta        		varchar(50) 	NULL,

        Codigo                  varchar(50)     NULL,
	ClaveVehicular		varchar(20)	NULL,
        TipoVehiculo            varchar(20)     NULL,        -- Automovil / Camion / Motocicleta
	DiasLibresIntereses	int		NULL,
        PrecioLiberado          bit             NULL  DEFAULT 0,
	ValidarCodigo		bit             NULL  DEFAULT 0,
	Presentacion		varchar(50)	NULL,
	GarantiaPlazo		int		NULL,
	CostoIdentificado	bit             NULL  DEFAULT 0,

	CantidadTarima		float		NULL,
	UnidadTarima		varchar(50)	NULL,
	MinimoTarima		float		NULL,
	--PermiteMezclarTarima	bit             NULL  DEFAULT 0,

	DepartamentoDetallista	int		NULL,
	TratadoComercial	varchar(50)	NULL,
	CuentaPresupuesto	varchar(20)	NULL,
	ProgramaSectorial	varchar(50)	NULL,
	PedimentoClave		varchar(5)		NULL,
	PedimentoRegimen	varchar(5)		NULL,
	Permiso			varchar(20)	NULL,
	PermisoRenglon 		varchar(20)	NULL,
	Cuenta2			varchar(20)	NULL,
	Cuenta3			varchar(20)	NULL,
	Impuesto1Excento		bit			NULL	DEFAULT 0,
	CalcularPresupuesto		bit			NULL	DEFAULT 0,
	InflacionPresupuesto	float		NULL,
	Excento2				bit			NULL	DEFAULT 0,
	Excento3				bit			NULL	DEFAULT 0,
	ContUso					varchar(20)	NULL,
	ContUso2				varchar(20)	NULL,		
	ContUso3				varchar(20)	NULL,
	NivelToleranciaCosto	varchar(10) NULL	DEFAULT '(Empresa)',
	ToleranciaCosto			money		NULL,
	ToleranciaCostoInferior		money		NULL,
	ObjetoGasto			varchar(10)	NULL,
	ObjetoGastoRef			varchar(10)	NULL,
	ClavePresupuestalImpuesto1	varchar(50)	NULL,
	ClavePresupuestalRetencion1	varchar(50)	NULL, --BUG15710
	ISBN					varchar(50) NULL,
	Estructura				varchar(50)	NULL,
	
	TipoImpuesto1			varchar(10) 	NULL,
	TipoImpuesto2			varchar(10) 	NULL,
	TipoImpuesto3			varchar(10) 	NULL,
	TipoImpuesto4			varchar(10) 	NULL,
	TipoImpuesto5			varchar(10) 	NULL,	
	TipoRetencion1			varchar(10) 	NULL, 
	TipoRetencion2			varchar(10) 	NULL, 
	TipoRetencion3			varchar(10) 	NULL, 
	
	SAUX					bit			NULL	DEFAULT 0,
 --REQ12534 Factory  	
    INFORClavePrincipal             varchar(20)     NULL,	
    INFORStockMinimo                float           NULL,
    INFORStockMaximo                float           NULL,
    INFORPrefijo                    varchar(20)     NULL,
    INFORSufijo                     varchar(20)     NULL,	
    CodigoEstructura                varchar(20)     NULL,	
    TipoVariante                    varchar(5)      NULL,	
    INFORTipo                       varchar(50)     NULL,
    INFORCuarentena                 int             NULL,
    INFORClavePlanta                varchar(8)      NULL,
    INFORTrazabilidad               bit             NULL,
    INFORLotificacionPropia         bit             NULL,
    INFORUltimoNumeroLote           int             NULL,
    INFORUnidadesMaximaLote         int             NULL,
    INFORTieneNoSerie               bit             NULL,
    INFORSMR                        float           NULL,
    INFORTipoDeAsignacion           varchar(20)     NULL,	
    INFORNoSerie                    varchar(20)     NULL,	
    INFORFormato                    varchar(20)     NULL,
    INFORAlmacenProd                varchar(20)     NULL, 
    ReferenciaIntelisisService      varchar(50)     NULL,
	
	--REQ12615 WMS
	AltoTarima				float		NULL,
	LargoTarima				float		NULL,
	AnchoTarima				float		NULL,
	TaraTarima				float		NULL,
	VolumenTarima			float		NULL,
	PesoTarima				float		NULL,
	CantidadCamaTarima		int			NULL,
	CamasTarima				int			NULL,
	EstibaMaxima			int			NULL	DEFAULT 1,
	ControlArticulo			varchar(20)	NULL,
	DiasControlCaducidad	int			NULL,
	EstibaMismaFecha		bit			NULL	DEFAULT 0,
	TipoRotacion			varchar(10)	NULL,
	PermiteEstibar			bit			NULL	DEFAULT 0, --REQ 14412
	
	EmidaRecargaTelefonica	bit			NULL	DEFAULT 0, -- REQ12336
        EmidaTiempoAire			bit			NULL	DEFAULT 0, -- REQ12336,
        ArticuloWeb                     varchar(255)	NULL,-- REQ13987
        POSForma                        varchar(50)     NULL,--REQ 13393 POS
        EsFactory                       bit             NULL	DEFAULT 0,        

	CONSTRAINT priArt PRIMARY KEY CLUSTERED (Articulo)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Rama' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Rama            ON dbo.Art (Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Descripcion1' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion1    ON dbo.Art (Descripcion1)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria       ON dbo.Art (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo           ON dbo.Art (Grupo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Familia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Familia         ON dbo.Art (Familia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Fabricante' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fabricante      ON dbo.Art (Fabricante)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Proveedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proveedor       ON dbo.Art (Proveedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Temporada' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Temporada       ON dbo.Art (Temporada)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Linea' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Linea           ON dbo.Art (Linea)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'CategoriaActivoFijo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CategoriaActivoFijo ON dbo.Art (CategoriaActivoFijo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'ClaveFabricante' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ClaveFabricante ON dbo.Art (ClaveFabricante)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Estatus' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Estatus         ON dbo.Art (Estatus)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtBC
GO

-- Cambios a la Tabla
if not exists(select * from syscampo where tabla = 'Art' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Art ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Art SET TieneMovimientos = 1")
END
GO
EXEC spSincroNivelRegistroCampos 'Art'
GO
EXEC spALTER_TABLE 'Art', 'AlmacenROP', 'varchar(10) NULL'
GO
EXEC spEliminarPK 'Art'
ALTER TABLE Art ADD CONSTRAINT priArt PRIMARY KEY CLUSTERED (Articulo)
GO
if not exists(select * from syscampo where tabla = 'Art' and campo = 'CostoEstandar')
BEGIN
  EXEC("ALTER TABLE Art ADD CostoEstandar money NULL")
  EXEC("UPDATE Art SET CostoEstandar = (SELECT MIN(c.CostoEstandar) FROM ArtCosto c WHERE c.Articulo = a.Articulo) FROM Art a")
END
if not exists(select * from syscampo where tabla = 'Art' and campo = 'CostoReposicion')
BEGIN
  EXEC("ALTER TABLE Art ADD CostoReposicion money NULL")
  EXEC("UPDATE Art SET CostoReposicion = (SELECT MIN(c.CostoReposicion) FROM ArtCosto c WHERE c.Articulo = a.Articulo) FROM Art a")
END
GO
EXEC spALTER_TABLE 'Art', 'EstatusCosto', 'varchar(15) NULL DEFAULT "SINCAMBIO" WITH VALUES'
GO
EXEC spALTER_TABLE 'Art', 'Margen', 'money NULL'
GO
if not exists(select * from syscampo where tabla = 'Art' and Campo='Registro1')
  ALTER TABLE Art ADD Registro1	varchar(20) NULL
if not exists(select * from syscampo where tabla = 'Art' and Campo='Registro1Vencimiento')
  ALTER TABLE Art ADD Registro1Vencimiento datetime NULL
if not exists(select * from syscampo where tabla = 'Art' and Campo='AlmacenEspecificoVenta')
  ALTER TABLE Art ADD AlmacenEspecificoVenta char(10) NULL
GO
EXEC spALTER_TABLE 'Art', 'AlmacenEspecificoVentaMov', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'Art', 'RutaDistribucion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'Proveedor', 'char(10) NULL'
EXEC spALTER_TABLE 'Art', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'ProdVerPorcentaje', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Temporada', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'SolicitarPrecios', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'AutoRecaudacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'Retencion1', 'float NULL'
EXEC spALTER_TABLE 'Art', 'Retencion2', 'float NULL'
EXEC spALTER_TABLE 'Art', 'Espacios', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EspaciosEspecificos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EspaciosSobreventa', 'float NULL'
EXEC spALTER_TABLE 'Art', 'EspaciosNivel', 'varchar(50)	NULL DEFAULT "Dia" WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EspaciosMinutos', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EspaciosBloquearAnteriores', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EspaciosHoraD', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Art', 'EspaciosHoraA', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Art', 'BasculaPesar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'SerieLoteInfo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'CantidadMinimaVenta', 'float	NULL'
EXEC spALTER_TABLE 'Art', 'CantidadMaximaVenta', 'float	NULL'
EXEC spALTER_TABLE 'Art', 'EstimuloFiscal', 'float NULL'
EXEC spALTER_TABLE 'Art', 'OrigenPais', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'OrigenLocalidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'Incentivo', 'money NULL'
EXEC spALTER_TABLE 'Art', 'FactorCompra', 'float NULL DEFAULT 1.0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Horas', 'float NULL'
EXEC spALTER_TABLE 'Art', 'ISAN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'ExcluirDescFormaPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'EsDeducible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Peaje', 'money NULL'
EXEC spALTER_TABLE 'Art', 'CodigoAlterno', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Art', 'TipoCatalogo', 'varchar(20) NULL DEFAULT "Resurtible" WITH VALUES'
EXEC spALTER_TABLE 'Art', 'AnexosAlFacturar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'CaducidadMinima', 'int NULL'
EXEC spALTER_TABLE 'Art', 'LotesFijos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Actividades', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'ValidarPresupuestoCompra', 'varchar(20) NULL	DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Art', 'SeriesLotesAutoOrden', 'varchar(20) NULL DEFAULT "(Empresa)" WITH VALUES'
EXEC spALTER_TABLE 'Art', 'UnidadTraspaso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'LotesAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Consecutivo', 'int NULL'
EXEC spALTER_TABLE 'Art', 'TipoEmpaque', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'Modelo', 'char(4) NULL'
EXEC spALTER_TABLE 'Art', 'Version', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'TieneDireccion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Direccion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Art', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'EntreCalles', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Art', 'Plano', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Art', 'Observaciones', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Art', 'Colonia', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'Poblacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'Pais', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'CodigoPostal', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Art', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Art', 'Ruta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'Codigo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'ClaveVehicular', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'TipoVehiculo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'DiasLibresIntereses', 'int NULL'
EXEC spALTER_TABLE 'Art', 'Cuenta2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'Cuenta3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'ISBN', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'Art' ,'ABC', 'varchar(1) NULL'
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Art ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Art ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Art ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
if (select version from version) <=1487
  ALTER TABLE Art ALTER COLUMN AutoRecaudacion varchar(30) NULL
GO
/*if (select version from version) <=1263
  UPDATE Art 
     SET Proveedor = ap.Proveedor
    FROM Art a, ArtProv ap
   WHERE a.Articulo = ap.Articulo AND ProveedorOmision = 1
GO*/
if (select version from version) <=2431
  UPDATE Art SET UnidadTraspaso = UnidadCompra
GO
EXEC spALTER_TABLE 'Art', 'PrecioLiberado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Retencion3', 'float NULL'
GO
-- Nuevos Indices
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Art' AND sysindexes.name = 'Codigo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Codigo    ON dbo.Art (Codigo)
GO
EXEC spALTER_TABLE 'Art', 'ValidarCodigo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'Presentacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'GarantiaPlazo', 'int NULL'
EXEC spALTER_TABLE 'Art', 'CostoIdentificado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'CantidadTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'UnidadTarima', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'Art', 'TratadoComercial', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'CuentaPresupuesto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'ProgramaSectorial', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'ArancelDesperdicio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'PedimentoClave', 'char(5) NULL'
EXEC spALTER_TABLE 'Art', 'PedimentoRegimen', 'char(5) NULL'
EXEC spALTER_TABLE 'Art', 'Permiso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'PermisoRenglon', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'MinimoTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Art', 'Impuesto1Excento', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'CalcularPresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art' ,'InflacionPresupuesto', 'float NULL'
EXEC spALTER_TABLE 'Art' ,'Excento2', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art' ,'Excento3', 'bit NULL	DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_COLUMN 'Art', 'Impuesto3', 'float NULL'
GO
EXEC spALTER_TABLE 'Art', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Art', 'NivelToleranciaCosto', 'varchar(10) NULL DEFAULT "(Empresa)" WITH VALUES' -- Empresa/Articulo
EXEC spALTER_TABLE 'Art', 'ToleranciaCosto', 'money NULL'
EXEC spALTER_TABLE 'Art', 'ToleranciaCostoInferior', 'money NULL'
EXEC spALTER_TABLE 'Art', 'ObjetoGasto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'ObjetoGastoRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'ClavePresupuestalImpuesto1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'ClavePresupuestalRetencion1', 'varchar(50) NULL' --BUG15710
EXEC spALTER_TABLE 'Art', 'Estructura', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Art', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'TipoImpuesto4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art', 'TipoRetencion1', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Art', 'TipoRetencion2', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Art', 'TipoRetencion3', 'varchar(10) NULL' 
GO
EXEC spALTER_TABLE 'Art', 'SAUX', 'bit NULL DEFAULT 0'
GO

EXEC spFK 'Art','Categoria','ArtCat','Categoria'
EXEC spFK 'Art','Familia','ArtFam','Familia'
EXEC spFK 'Art','Factor','ArtFactor','Factor'
EXEC spFK 'Art','Utilidad','ArtUtil','Utilidad'
EXEC spFK 'Art','Comision','ArtComision','Comision'
EXEC spFK 'Art','Cuenta','Cta','Cuenta'
EXEC spFK 'Art','DepartamentoDetallista','DepartamentoDetallista','Departamento'
EXEC spFK 'Art','Arancel','ArtArancel','Arancel'
EXEC spFK 'Art','Proveedor','Prov','Proveedor'
GO

EXEC spAlter_Table 'Art', 'MaterialPeligroso', 'Bit Null Default 0 WITH VALUES'
GO

if (select version from version) < 3000
BEGIN
  EXEC("spEliminarPK 'Art'")	
  EXEC("spALTER_COLUMN 'Art' ,'Articulo', 'varchar(20) NOT NULL'")  
  EXEC("ALTER TABLE Art ADD CONSTRAINT priArt PRIMARY KEY CLUSTERED (Articulo)")
END
GO
EXEC spALTER_COLUMN 'Art', 'CostoEstandar', 'float NULL'
EXEC spALTER_COLUMN 'Art', 'CostoReposicion', 'float NULL'
GO

 --REQ12534 Factory  
Exec spAlter_Table 'Art','INFORClavePrincipal','varchar(20) Null'	
Exec spAlter_Table 'Art', 'INFORStockMinimo',' float  Null'
Exec spAlter_Table 'Art', 'INFORStockMaximo',' float  Null'
Exec spAlter_Table 'Art','INFORPrefijo','varchar(20) Null'
Exec spAlter_Table 'Art','INFORSufijo','varchar(20) Null'	
Exec spAlter_Table 'Art','CodigoEstructura','varchar(20) Null'	
Exec spAlter_Table 'Art','TipoVariante','varchar(5) Null'	
Exec spAlter_Table 'Art','INFORTipo','varchar(50) Null'
Exec spAlter_Table 'Art','INFORCuarentena','int Null'
Exec spAlter_Table 'Art', 'INFORClavePlanta',' varchar(8) NULL '
Exec spAlter_Table 'Art','INFORTrazabilidad','bit Null'
Exec spAlter_Table 'Art','INFORLotificacionPropia','bit Null'
Exec spAlter_Table 'Art','INFORUltimoNumeroLote','int Null'
Exec spAlter_Table 'Art','INFORUnidadesMaximaLote','int Null'
Exec spAlter_Table 'Art','INFORTieneNoSerie','bit Null'
Exec spAlter_Table 'Art','INFORSMR','float Null'
Exec spAlter_Table 'Art','INFORTipoDeAsignacion','varchar(20) Null'	
Exec spAlter_Table 'Art','INFORNoSerie','varchar(20) Null'	
Exec spAlter_Table 'Art','INFORFormato','varchar(20) Null'
Exec spAlter_Table 'Art', 'INFORAlmacenProd',' varchar(20) NULL '
Exec spAlter_Table 'Art', 'ReferenciaIntelisisService',' varchar(50) NULL '
EXEC spALTER_TABLE 'Art',  'EsFactory', 'bit NULL DEFAULT 0 WITH VALUES'

GO
EXEC spALTER_COLUMN 'Art', 'CostoEstandar', 'float NULL'
EXEC spALTER_COLUMN 'Art', 'CostoReposicion', 'float NULL'
GO

Exec spAlter_Table 'Alm', 'INFORClavePlanta',' varchar(8) NULL '
Exec spAlter_Table 'Usuario', 'INFORPerfil',' varchar(30)NULL '
Exec spAlter_Table 'Usuario', 'INFORSupervisor',' bit NOT NULL DEFAULT 0'
Exec spAlter_Table 'ArtFam','INFORDescripcion','varchar(30) Null'
Exec spAlter_Table 'Version', 'PlantaSucEmpresa',' varchar(10) NULL'
Exec spAlter_Table 'Version', 'RutaIntelisisMES',' varchar(40) NULL'
Exec spALTER_COLUMN 'Version', 'RutaIntelisisMES',' varchar(255) NULL'
Exec spAlter_Table 'Version', 'ParamAccDirIntelisisMES',' varchar(255) NULL'
Exec spAlter_Table 'Compra', 'MovIntelisisMES','  varchar(10)NULL'
Exec spAlter_Table 'Inv', 'MovMES','  bit NULL'
Exec spAlter_Table 'InvD', 'INFORCostoConsumoMat','  float NULL'
Exec spAlter_Table 'InvD', 'INFORCostoManoObra','  float NULL'
Exec spAlter_Table 'InvD', 'INFORCostoIndirecto','  float NULL'
Exec spAlter_Table 'Unidad','INFORDescripcion','varchar(30) Null'
Exec spAlter_Table 'Alm', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Empresa', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Cte', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Unidad', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'CteTipo', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Mon', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Usuario', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'ArtFam', 'ReferenciaIntelisisService',' varchar(50) NULL '
Exec spAlter_Table 'Sucursal', 'ReferenciaIntelisisService',' varchar(50) NULL '
EXEC spALTER_TABLE 'Inv', 'Motivo', 'varchar(8) NULL'
EXEC spALTER_TABLE 'Compra', 'ReferenciaMES', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Inv', 'ReferenciaMES', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Inv', 'PedidoMES ', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'PedidoMES ', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Inv', 'Serie', 'varchar(3) NULL'
EXEC spALTER_TABLE 'Inv', 'IDMES', 'int NULL'
EXEC spALTER_TABLE 'Inv', 'IDMarcaje', 'int NULL'
EXEC spALTER_TABLE 'MovTipo', 'SerieMES', 'varchar(3) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'AjustesAutomaticosMES', 'bit NULL'       
EXEC spALTER_TABLE 'Version', 'ServidorWEB', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'MESISDBMailPerfil', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'MESISDBMailAsunto', 'varchar(MAX) null DEFAULT "Notificacion Intelisis MES IS (ID/IntelisisServiceID/)"'
EXEC spALTER_TABLE 'Version', 'MESISDBMailMensaje', 'varchar(MAX) null DEFAULT "Tipo Solicitud /SubReferencia/<BR> Estatus /Estatus/<BR>Error /IntelisisServiceOk/<BR>Referencia /IntelisisServiceOkRef/<BR>Fecha /FechaEstatus/<BR>Conversación /Conversacion/<BR>"'
EXEC spALTER_TABLE 'Usuario', 'ISMESNotificarError', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ProdInterfazINFOR', 'bit NULL DEFAULT 0 WITH VALUES'

--REQ12615 WMS
EXEC spALTER_TABLE 'Art', 'AltoTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'LargoTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'AnchoTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'TaraTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'VolumenTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'PesoTarima', 'float NULL'
EXEC spALTER_TABLE 'Art', 'CantidadCamaTarima', 'int NULL'
EXEC spALTER_TABLE 'Art', 'CamasTarima', 'int NULL'
EXEC spALTER_TABLE 'Art', 'EstibaMaxima', 'int NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'ControlArticulo', 'varchar(20)','NULL'
EXEC spALTER_TABLE 'Art', 'DiasControlCaducidad', 'int','NULL'
EXEC spALTER_TABLE 'Art', 'EstibaMismaFecha', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'Art', 'TipoRotacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Art','PermiteEstibar','bit NULL DEFAULT 0 WITH VALUES' --REQ 14412
GO
-- REQ12336
EXEC spALTER_TABLE 'Art', 'EmidaRecargaTelefonica', 'bit NULL DEFAULT 0 WITH VALUES'
GO
-- REQ12336
EXEC spALTER_TABLE 'Art', 'EmidaTiempoAire', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ13386
EXEC spALTER_TABLE 'Art', 'LDI','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Art', 'LDIServicio','  varchar(20) NULL'
GO
--REQ 13393 POS
EXEC spALTER_TABLE 'Art', 'POSForma','  varchar(50) NULL'
GO
-- REQ13987
Exec spAlter_Table 'Art','ArticuloWeb','varchar(255) Null'
Go
--REQ 19255 WMS
EXEC spALTER_TABLE 'Art', 'TarimasReacomodar','  int NULL'
GO
--REQ23456
EXEC spALTER_TABLE 'Art', 'CantidadPresentacion', 'float NULL'
GO
--BUG2821
EXEC spALTER_COLUMN 'Art', 'CantidadCamaTarima', 'float NULL'
EXEC spALTER_COLUMN 'Art', 'CamasTarima', 'float NULL'
GO

--Integracion DEVOLUCION POS con Articulos tipo Serie
EXEC spALTER_TABLE 'Art', 'POSAgenteDetalle', 'varchar(20) NULL'

EXEC spALTER_TABLE 'Cte', 'MovimientoUltimoCobro', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cte', 'FechaUltimoCobro', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'FechaUltimoCobroAux', 'datetime NULL'
EXEC spALTER_TABLE 'Cte', 'MovimientoUltimoCobroAux', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'Cte', 'CalculoMoratorioMAVI', 'bit DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'ArtCat', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtGrupo', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtFam', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtLinea', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--Integración MES
EXEC spALTER_TABLE 'Art',        'TipoArticulo',          'INT',          '0'
EXEC spALTER_TABLE 'Art',        'AlmMesComs',          'VARCHAR(10) NULL'
EXEC spALTER_TABLE 'Art', 'MinimoCompra', 'float NULL'
EXEC spALTER_TABLE 'Art', 'StockMinimo', 'float NULL'
EXEC spALTER_TABLE 'Art', 'StockMaximo', 'float NULL'
EXEC spALTER_TABLE 'Art', 'TipoArticulo', 'int NULL'
EXEC spALTER_TABLE 'Art', 'SMR', 'int NULL'
--EXEC spALTER_TABLE 'Art', 'MES', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--EXEC spDROP_COLUMN 'Art', 'MES'
GO

--Integración CRM
EXEC spAlter_Table 'art', 'CRMObjectId', 'uniqueidentifier NULL'
GO

/********************* tgArtABC **********************/
IF OBJECT_ID(N'dbo.tgArtABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgArtABC
GO
CREATE TRIGGER tgArtABC ON Art
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @ClaveNueva  	char(20),
    @ClaveAnterior	char(20),
    @SituacionNueva	varchar(50),
    @SituacionAnterior	varchar(50),
    @TipoNuevo		char(20),
    @TipoAnterior	char(20),
    @MonedaNueva	char(10),
    @MonedaAnterior	char(10),
    @Precio1A		money,
    @Precio1N		money,
    @Precio2A		money,
    @Precio2N		money,
    @Precio3A		money,
    @Precio3N		money,
    @Precio4A		money,
    @Precio4N		money,
    @Precio5A		money,
    @Precio5N		money,
    @Precio6A		money,
    @Precio6N		money,
    @Precio7A		money,
    @Precio7N		money,
    @Precio8A		money,
    @Precio8N		money,
    @Precio9A		money,
    @Precio9N		money,
    @Precio10A		money,
    @Precio10N		money,
    @ValidarCodigoN	bit, 
    @ValidarCodigoA	bit,
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Fecha = GETDATE()
  SELECT @ClaveNueva    = Articulo, @TipoNuevo    = Tipo, @MonedaNueva    = MonedaCosto, @SituacionNueva = Situacion, @ValidarCodigoN = ISNULL(ValidarCodigo, 0),
         @Precio1N = PrecioLista, @Precio2N = Precio2, @Precio3N = Precio3, @Precio4N = Precio4, @Precio5N = Precio5, @Precio6N = Precio6, @Precio7N = Precio7, @Precio8N = Precio8, @Precio9N = Precio9, @Precio10N = Precio10
    FROM Inserted
  SELECT @ClaveAnterior = Articulo, @TipoAnterior = Tipo, @MonedaAnterior = MonedaCosto, @SituacionAnterior = Situacion, @ValidarCodigoA = ISNULL(ValidarCodigo, 0),
         @Precio1A = PrecioLista, @Precio2A = Precio2, @Precio3A = Precio3, @Precio4A = Precio4, @Precio5A = Precio5, @Precio6A = Precio6, @Precio7A = Precio7, @Precio8A = Precio8, @Precio9A = Precio9, @Precio10A = Precio10
    FROM Deleted

  IF @ClaveNueva <> @ClaveAnterior OR @ValidarCodigoN <> @ValidarCodigoA
  BEGIN
    IF @ValidarCodigoN = 1 AND (SELECT dbo.fnUPCValidar(@ClaveNueva)) = 0 
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 10440
      RAISERROR (@Mensaje,16,-1) 
    END
  END 

  IF @ClaveNueva=@ClaveAnterior AND @TipoNuevo=@TipoAnterior AND @MonedaNueva=@MonedaAnterior AND @SituacionNueva=@SituacionAnterior AND
     @Precio1N=@Precio1A AND @Precio2N=@Precio2A AND @Precio3N=@Precio3A AND @Precio4N=@Precio4A AND @Precio5N=@Precio5A AND
     @Precio6N=@Precio6A AND @Precio7N=@Precio7A AND @Precio8N=@Precio8A AND @Precio9N=@Precio9A AND @Precio10N=@Precio10A RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    IF EXISTS (SELECT * FROM Art WHERE Rama = @ClaveAnterior) OR 
       EXISTS (SELECT * FROM ArtMaterial WHERE Material = @ClaveAnterior) OR
       EXISTS (SELECT * FROM CompraD WHERE Articulo = @ClaveAnterior) 
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30167
      RAISERROR (@Mensaje,16,-1) 
    END ELSE
    BEGIN
      DELETE ArtSub             WHERE Articulo = @ClaveAnterior
      DELETE ArtAcceso          WHERE Articulo = @ClaveAnterior
      DELETE ArtAnexo           WHERE Articulo = @ClaveAnterior
      DELETE ArtLoteFijo	WHERE Articulo = @ClaveAnterior
      DELETE ArtActividad	WHERE Articulo = @ClaveAnterior
      DELETE ArtPresenta        WHERE Articulo = @ClaveAnterior
      DELETE ArtMatriz          WHERE Articulo = @ClaveAnterior
      DELETE ArtJuego           WHERE Articulo = @ClaveAnterior
      DELETE ArtProv            WHERE Articulo = @ClaveAnterior
      DELETE ArtProvSucursal    WHERE Articulo = @ClaveAnterior
      DELETE ArtPrecioHist      WHERE Articulo = @ClaveAnterior
      DELETE ArtSituacionHist   WHERE Articulo = @ClaveAnterior
      DELETE ArtCostoHist       WHERE Articulo = @ClaveAnterior
      DELETE ArtSubCostoHist    WHERE Articulo = @ClaveAnterior
      DELETE ListaPreciosD      WHERE Articulo = @ClaveAnterior
      DELETE ArtIdioma          WHERE Articulo = @ClaveAnterior 
      DELETE ArtFecha	        WHERE Articulo = @ClaveAnterior 
      DELETE ArtMaterial        WHERE Articulo = @ClaveAnterior 
      DELETE ArtMaterial        WHERE Material = @ClaveAnterior 
      DELETE ArtSucursal        WHERE Articulo = @ClaveAnterior 
      DELETE ArtPlanEx		WHERE Articulo = @ClaveAnterior 
      DELETE ArtKms	        WHERE Articulo = @ClaveAnterior 
      DELETE ArtCompraProrrateo WHERE Articulo = @ClaveAnterior 
      DELETE ArtUnidad		WHERE Articulo = @ClaveAnterior 
      DELETE ArtAccesorio	WHERE Articulo = @ClaveAnterior 
      DELETE ArtRefaccion	WHERE Articulo = @ClaveAnterior 
      DELETE ArtServicio	WHERE Articulo = @ClaveAnterior 
      DELETE ArtConsumible	WHERE Articulo = @ClaveAnterior 
      DELETE ArtVINAccesorio	WHERE Articulo = @ClaveAnterior 
      DELETE ArtInfoAdicional	WHERE Articulo = @ClaveAnterior 
      DELETE ArtDescuentoCompra	WHERE Articulo = @ClaveAnterior 
      DELETE ArtCalidad		WHERE Articulo = @ClaveAnterior 
      DELETE ArtACCupon		WHERE Articulo = @ClaveAnterior 
      DELETE ListaD	        WHERE Cuenta = @ClaveAnterior AND Rama='INV'
      DELETE Prop               WHERE Cuenta = @ClaveAnterior AND Rama='INV'
      DELETE AnexoCta           WHERE Cuenta = @ClaveAnterior AND Rama='INV'
    END
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior AND @ClaveAnterior IS NOT NULL 
  BEGIN
    IF (SELECT Sincro FROM Version) = 1
      EXEC sp_executesql N'UPDATE Art SET Rama = @ClaveNueva, SincroC = SincroC WHERE Rama = @ClaveAnterior', N'@ClaveNueva varchar(20), @ClaveAnterior varchar(20)', @ClaveNueva = @ClaveNueva, @ClaveAnterior = @ClaveAnterior
    ELSE
      UPDATE Art SET Rama = @ClaveNueva WHERE Rama = @ClaveAnterior

    UPDATE ArtSub             SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtAcceso          SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtAnexo           SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtLoteFijo        SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtActividad       SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtPresenta        SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtMatriz          SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtJuego           SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtProv            SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtProvSucursal    SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtPrecioHist      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtSituacionHist   SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtCostoHist       SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtSubCostoHist    SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ListaPreciosD      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtIdioma          SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtFecha           SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtMaterial        SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtMaterial        SET Material = @ClaveNueva WHERE Material = @ClaveAnterior
    UPDATE ArtPlanEx	      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtSucursal        SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtKms	      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtCompraProrrateo SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtUnidad	      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtAccesorio	      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtRefaccion	      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtServicio        SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtConsumible      SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtVINAccesorio    SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtInfoAdicional   SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtDescuentoCompra SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtCalidad         SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ArtACCupon         SET Articulo = @ClaveNueva WHERE Articulo = @ClaveAnterior
    UPDATE ListaD 	      SET Cuenta   = @ClaveNueva WHERE Cuenta   = @ClaveAnterior AND Rama='INV'
    UPDATE Prop               SET Cuenta   = @ClaveNueva WHERE Cuenta   = @ClaveAnterior AND Rama='INV'
    UPDATE AnexoCta           SET Cuenta   = @ClaveNueva WHERE Cuenta   = @ClaveAnterior AND Rama='INV'
  END

  IF @ClaveNueva IS NOT NULL
  BEGIN
    IF @Precio1N  <> @Precio1A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 1, @Fecha, @Precio1N, @Precio1A)
    IF @Precio2N  <> @Precio2A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 2, @Fecha, @Precio2N, @Precio2A)
    IF @Precio3N  <> @Precio3A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 3, @Fecha, @Precio3N, @Precio3A)
    IF @Precio4N  <> @Precio4A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 4, @Fecha, @Precio4N, @Precio4A)
    IF @Precio5N  <> @Precio5A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 5, @Fecha, @Precio5N, @Precio5A)
    IF @Precio6N  <> @Precio6A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 6, @Fecha, @Precio6N, @Precio6A)
    IF @Precio7N  <> @Precio7A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 7, @Fecha, @Precio7N, @Precio7A)
    IF @Precio8N  <> @Precio8A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 8, @Fecha, @Precio8N, @Precio8A)
    IF @Precio9N  <> @Precio9A  INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 9, @Fecha, @Precio9N, @Precio9A)
    IF @Precio10N <> @Precio10A INSERT ArtPrecioHist (Articulo, Numero, Fecha, PrecioActual, PrecioAnterior) VALUES (@ClaveNueva, 10, @Fecha, @Precio10N, @Precio10A)

    IF @SituacionNueva <> @SituacionAnterior
      INSERT ArtSituacionHist (Articulo, Fecha, SituacionActual, SituacionAnterior) VALUES (@ClaveNueva, @Fecha, @SituacionNueva, @SituacionAnterior)
  END
END
GO

/**************** tgInforArtABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforArtABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforArtABC
GO
CREATE TRIGGER tgInforArtABC ON Art
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Articulo							varchar (20),
   @Estatus							    varchar (10),
   @Datos								varchar (max),
   @Ok									int,
   @OkRef								varchar(255),
   @Id									int,
   @Cinserted		                	int,
   @Cdeleted			                int,
   @ReferenciaIntelisisService			varchar(50)	,
   @Empresa					varchar(20),
   @EsFactory                                   bit,
   @EsFactoryIN                                 bit,
   @EsFactoryDel                                bit,
   @Existencia                                  float,
   @Mensaje                                     varchar(255),
   @Sucursal                                    int,
   @Usuario                                     varchar(10)

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa, @Usuario = Usuario, @Sucursal = Sucursal FROM Acceso WHERE ID = @ID
  
  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @ProdInterfazINFOR = 1
  BEGIN
    IF @Cinserted <> 0 AND @Cdeleted = 0 
    BEGIN
      SET @Estatus = 'ALTA' 
    END
    IF @Cinserted <> 0 AND @Cdeleted<> 0 
    BEGIN
      SET @Estatus = 'CAMBIO'
    END
    IF @Cinserted = 0 AND @Cdeleted <> 0 
    BEGIN 
      SET @Estatus = 'BAJA'
    END
    IF  @Estatus IN( 'ALTA','CAMBIO')
    BEGIN       
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR	
       SELECT Articulo,ReferenciaIntelisisService, ISNULL(EsFactory,0)	  
         FROM Inserted	  
    END
    ELSE IF @Estatus = 'BAJA'
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Articulo,ReferenciaIntelisisService, ISNULL(EsFactory,0)
	FROM Deleted     
    END  
    IF  @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
    BEGIN       
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @Articulo,@ReferenciaIntelisisService, @EsFactory
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        SELECT @EsFactoryIN = ISNULL(EsFactory,0) FROM Inserted where Articulo = @Articulo
        SELECT @EsFactoryDel = ISNULL(EsFactory,0) FROM Deleted where Articulo = @Articulo
        SELECT @Mensaje = 'El Articulo tiene existencia no se puede dejar de sincronizar con factory  '
        SELECT @Existencia = ISNULL(SUM(ISNULL(Disponible,0)+ISNULL(Reservado,0)),0) FROM ArtDisponibleReservado WHERE Empresa = @Empresa AND Articulo = @Articulo
        IF @EsFactoryDel = 1 AND @EsFactoryIN = 0  AND @Existencia <> 0
          RAISERROR (@Mensaje,16,-1) 
        IF @EsFactoryDel = 0 AND @EsFactoryIN = 1 AND @Existencia <> 0
          EXEC spInforArticuloSaldoInicial @Articulo, @Usuario, @Empresa, @Sucursal
        
        IF  @EsFactory = 1
        BEGIN
          EXEC spInforGenerarSolicitudArticulo  @Articulo,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
          EXEC spInforGenerarSolicitudArtContadorLotes  @Articulo,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
        END  
        FETCH NEXT FROM crActualizar INTO @Articulo,@ReferenciaIntelisisService, @EsFactory
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar
    END
  END
END
GO





/**************** tgInforArtContadorLotesABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforArtContadorLotesABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforArtContadorLotesABC
GO




/****** ArtAccesorio ******/
if not exists(select * from SysTabla where SysTabla = 'ArtAccesorio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtAccesorio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAccesorio') and type = 'U') 
CREATE TABLE dbo.ArtAccesorio (
	Articulo 		varchar(20) 	NOT NULL,
	Accesorio		varchar(20) 	NOT NULL,

	CONSTRAINT priArtAccesorio PRIMARY KEY CLUSTERED (Articulo, Accesorio)
)
go

EXEC spFK 'ArtAccesorio','Accesorio','Art','Articulo' 
GO

/****** ArtActividad ******/
if not exists(select * from SysTabla where SysTabla = 'ArtActividad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtActividad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtActividad') and type = 'U') 
CREATE TABLE dbo.ArtActividad (
	Articulo		varchar(20) 	NOT NULL,
	Actividad		varchar(100) 	NOT NULL,

	Cantidad		float		NULL,
	Orden			int		NULL,

	CONSTRAINT priArtActividad PRIMARY KEY  CLUSTERED (Articulo, Actividad)
)
go

EXEC spFK 'ArtActividad','Actividad','Actividad','Actividad'
GO

/****** Anexos Articulos ******/
if exists(select * from SysTabla where SysTabla = 'ArtAnexo') and (select version from version)<=2325
  drop table ArtAnexo
go
if not exists(select * from SysTabla where SysTabla = 'ArtAnexo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtAnexo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAnexo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtAnexo (
	Articulo		varchar(20) 	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Anexo			varchar(20) 	NULL,
	SubCuenta		varchar(50)	NULL,
	TipoCantidad		varchar(20)	NULL,		-- Multiplos/Especifica/%
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	TipoPrecio		varchar(20)	NULL,		-- No/Corresponda/Especifico/%
	Precio			float		NULL,
	UnidadEspecifica	varchar(50)	NULL,

	CONSTRAINT priArtAnexo PRIMARY KEY  CLUSTERED (Articulo, ID)
  )
  EXEC spSincroSemilla 'ArtAnexo'
END
go
EXEC spALTER_TABLE 'ArtAnexo', 'TipoCantidad', 'varchar(20) NULL DEFAULT "Multiplos" WITH VALUES'
EXEC spALTER_TABLE 'ArtAnexo', 'TipoPrecio', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'ArtAnexo', 'Precio', 'float NULL'
EXEC spALTER_TABLE 'ArtAnexo', 'UnidadEspecifica', 'varchar(50)	NULL'
GO
EXEC spALTER_COLUMN 'ArtAnexo', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'ArtAnexo','Anexo','Art','Articulo'
GO

/****** ArtCosto ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCosto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCosto','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCosto') and type = 'U') 
CREATE TABLE dbo.ArtCosto (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)		NOT NULL,
	Articulo 		varchar(20) 	NOT NULL,

	UltimoCosto		float     	NULL,
	CostoPromedio		float     	NULL,
	CostoEstandar		float	  	NULL,
	CostoReposicion		float		NULL,
	UltimoCostoSinGastos	float	  	NULL,

	CONSTRAINT priArtCosto PRIMARY KEY CLUSTERED (Articulo, Sucursal, Empresa)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtCostoBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtCostoBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtCostoAC') and sysstat & 0xf = 8) drop trigger dbo.tgArtCostoAC
GO
EXEC spModificarPK_AcumSaldo 'ArtCosto', '(Sucursal, Empresa, Articulo)'
GO
EXEC spALTER_COLUMN 'ArtCosto', 'UltimoCosto', 'float NULL'
EXEC spALTER_COLUMN 'ArtCosto', 'CostoPromedio', 'float NULL'
EXEC spALTER_COLUMN 'ArtCosto', 'CostoEstandar', 'float NULL'
EXEC spALTER_COLUMN 'ArtCosto', 'CostoReposicion', 'float NULL'
EXEC spALTER_COLUMN 'ArtCosto', 'UltimoCostoSinGastos', 'float NULL'
GO

CREATE TRIGGER tgArtCostoAC ON ArtCosto
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @Sucursal		int,
    @Empresa		varchar(5),
    @Articulo  		varchar(20),
    @UltimoCostoN	float,
    @UltimoCostoA	float,
    @CostoPromedioN	float,
    @CostoPromedioA	float

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Fecha = GETDATE()
  SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Articulo = Articulo, 
         @UltimoCostoN = UltimoCosto, @CostoPromedioN = CostoPromedio
    FROM Inserted
  SELECT @UltimoCostoA = UltimoCosto, @CostoPromedioA = CostoPromedio
    FROM Deleted

  IF @UltimoCostoN <> @UltimoCostoA OR @CostoPromedioN <> @CostoPromedioA 
    INSERT ArtCostoHist (Sucursal, Empresa,  Articulo,  Fecha, UltimoCostoActual, UltimoCostoAnterior, CostoPromedio) 
                 VALUES (@Sucursal, @Empresa, @Articulo, @Fecha, @UltimoCostoN, @UltimoCostoA, @CostoPromedioN) 
END
GO





 --REQ12534 Factory  
/**************** tgInforArtCostoABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforArtCostoABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforArtCostoABC
GO
CREATE TRIGGER tgInforArtCostoABC ON ArtCosto
--//WITH ENCRYPTION
FOR  UPDATE 
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Articulo							varchar (20),
   @Estatus							    varchar (10),
   @Datos								varchar (max),
   @UltimoCostoD						float,
   @CostoPromedioD						float,
   @CostoEstandarD						float,
   @UltimoCostoI						float,
   @CostoPromedioI 						float,
   @CostoEstandarI 						float,
   @ID									int,
   @ReferenciaIntelisisService			varchar(50)	,
   @Empresa								varchar(20)

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  SELECT @Articulo = Articulo FROM Inserted
  
  SELECT  @Estatus = 'CAMBIO'
  SELECT  @UltimoCostoI = UltimoCosto,
          @CostoPromedioI = CostoPromedio,
          @CostoEstandarI = CostoEstandar 
    FROM  Inserted

  SELECT  @UltimoCostoD = UltimoCosto,
          @CostoPromedioD = CostoPromedio , 
          @CostoEstandarD = CostoEstandar
    FROM Deleted

  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa
  
  IF @ProdInterfazINFOR = 1
  BEGIN 
    IF ISNULL(@UltimoCostoI,0) <> ISNULL(@UltimoCostoD,0) OR ISNULL(@CostoPromedioI,0) <> ISNULL(@CostoPromedioD,0) OR ISNULL(@CostoEstandarI,0) <> ISNULL(@CostoEstandarD,0)
    BEGIN
      EXEC spInforGenerarSolicitudArticulo  @Articulo,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
    END
  END
END
GO


EXEC spFK 'ArtCosto','Articulo','Art','Articulo'
EXEC spFK 'ArtCosto','Sucursal','Sucursal','Sucursal'
GO

/****** ArtSubCosto ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSubCosto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSubCosto','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSubCosto') and type = 'U') 
CREATE TABLE dbo.ArtSubCosto (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)		NOT NULL,
	Articulo 		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',

	UltimoCosto		float     	NULL,
	CostoPromedio		float     	NULL,
	CostoEstandar		float	  	NULL,
	CostoReposicion		float		NULL,
	UltimoCostoSinGastos	float	  	NULL,

	CONSTRAINT priArtSubCosto PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Sucursal, Empresa)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtSubCosto' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtSubCosto'
  EXEC spALTER_COLUMN 'ArtSubCosto', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtSubCosto ADD CONSTRAINT priArtSubCosto PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Sucursal, Empresa)')
END
GO
EXEC spALTER_COLUMN 'ArtSubCosto', 'UltimoCosto', 'float NULL'
EXEC spALTER_COLUMN 'ArtSubCosto', 'CostoPromedio', 'float NULL'
EXEC spALTER_COLUMN 'ArtSubCosto', 'CostoEstandar', 'float NULL'
EXEC spALTER_COLUMN 'ArtSubCosto', 'CostoReposicion', 'float NULL'
EXEC spALTER_COLUMN 'ArtSubCosto', 'UltimoCostoSinGastos', 'float NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgArtSubCostoBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtSubCostoBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtSubCostoAC') and sysstat & 0xf = 8) drop trigger dbo.tgArtSubCostoAC
GO
EXEC spModificarPK_AcumSaldo 'ArtSubCosto', '(Sucursal, Empresa, Articulo, SubCuenta)'
GO
CREATE TRIGGER tgArtSubCostoAC ON ArtSubCosto
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @Sucursal		int,
    @Empresa		varchar(5),
    @Articulo  		varchar(20),
    @SubCuenta		varchar(50),
    @UltimoCostoN	float,
    @UltimoCostoA	float,
    @CostoPromedioN	float,
    @CostoPromedioA	float

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Fecha = GETDATE()
  SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Articulo = Articulo, @SubCuenta = SubCuenta, 
         @UltimoCostoN = UltimoCosto, @CostoPromedioN = CostoPromedio
    FROM Inserted
  SELECT @UltimoCostoA = UltimoCosto, @CostoPromedioA = CostoPromedio
    FROM Deleted

  IF @UltimoCostoN <> @UltimoCostoA OR @CostoPromedioN <> @CostoPromedioA 
    INSERT ArtSubCostoHist (Sucursal,  Empresa,  Articulo,  SubCuenta, Fecha, UltimoCostoActual, UltimoCostoAnterior, CostoPromedio) 
                    VALUES (@Sucursal, @Empresa, @Articulo, @SubCuenta, @Fecha, @UltimoCostoN, @UltimoCostoA, @CostoPromedioN) 
END
GO

EXEC spFK 'ArtSubCosto','Articulo','Art','Articulo'
GO

/****** Articulos del Cliente ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCte','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCte') and type = 'U') 
CREATE TABLE dbo.ArtCte (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Cliente 		varchar(10)  	NOT NULL,

	Estatus			varchar(15)	NULL		DEFAULT 'ACTIVO',
	Presentacion		varchar(50)	NULL,
	Tamano			float		NULL,
	Comentarios		text		NULL,
	Cantidad		float		NULL,

        UltimoPrecio	        money       	NULL,
	UltimaVenta		datetime	NULL,
	Codigo			varchar(30)	NULL,

	CONSTRAINT priArtCte PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Cliente)
)
GO
EXEC spALTER_TABLE 'ArtCte', 'Estatus', 'varchar(15) NULL DEFAULT "ACTIVO" WITH VALUES'
EXEC spALTER_TABLE 'ArtCte', 'Presentacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtCte', 'Tamano', 'float NULL'
EXEC spALTER_TABLE 'ArtCte', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'ArtCte', 'Cantidad', 'float NULL'
EXEC spALTER_TABLE 'ArtCte', 'Codigo', 'varchar(30) NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtCte' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtCte'
  EXEC spALTER_COLUMN 'ArtCte', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtCte ADD CONSTRAINT priArtCte PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Cliente)')
END
GO

EXEC spFK 'ArtCte','Articulo','Art','Articulo'
EXEC spFK 'ArtCte','Cliente','Cte','Cliente'
GO

/****** Articulos del Cliente (Competencias) ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCteCompetencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCteCompetencia','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCteCompetencia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtCteCompetencia (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Cliente 		varchar(10)  	NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	Fecha			datetime	NULL,
	Cantidad		float		NULL,
	Precio			money		NULL,
	Competencia		varchar(100)	NULL,
	Comentarios		varchar(100)	NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priArtCteCompetencia PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Cliente, RID)
  )
  EXEC spSincroSemilla 'ArtCteCompetencia'
END
GO
EXEC spALTER_TABLE 'ArtCteCompetencia', 'Comentarios', 'varchar(100) NULL'
EXEC spALTER_TABLE 'ArtCteCompetencia', 'Porcentaje', 'float NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtCteCompetencia' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtCteCompetencia'
  EXEC spALTER_COLUMN 'ArtCteCompetencia', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtCteCompetencia ADD CONSTRAINT priArtCteCompetencia PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Cliente, RID)')
END
GO

/****** ArtConsumible ******/
if not exists(select * from SysTabla where SysTabla = 'ArtConsumible')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtConsumible','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtConsumible') and type = 'U') 
CREATE TABLE dbo.ArtConsumible (
	Articulo 		varchar(20) 	NOT NULL,
	Consumible		varchar(20) 	NOT NULL,
	Cantidad		int		NULL,

	CONSTRAINT priArtConsumible PRIMARY KEY CLUSTERED (Articulo, Consumible)
)
GO

EXEC spFK 'ArtConsumible','Consumible','Art','Articulo'
GO

/****** Juegos Codigos Barras ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCBJuego')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCBJuego','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCBJuego') and type = 'U') 
CREATE TABLE dbo.ArtCBJuego (
	ID			int		NOT NULL IDENTITY(1,1),

	Codigo        		varchar(30)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Precio			float		NULL,

	CONSTRAINT priArtCBJuego PRIMARY KEY CLUSTERED (ID)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ArtCBJuego' AND sysindexes.name = 'Codigo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Codigo ON dbo.ArtCBJuego (Codigo)
go

EXEC spFK 'ArtCBJuego','Articulo','Art','Articulo'
GO

/****** Juegos Detalle ******/
if not exists(select * from SysTabla where SysTabla = 'ArtJuegoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtJuegoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtJuegoD') and type = 'U') 
CREATE TABLE dbo.ArtJuegoD (
	Articulo 		varchar(20) 	NOT NULL,
	Juego			varchar(10) 	NOT NULL,
	Renglon			float		NOT NULL,
	Opcion			varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NULL,

	CONSTRAINT priArtJuegoD PRIMARY KEY CLUSTERED (Articulo, Juego, Renglon)
)
GO
EXEC spALTER_TABLE 'ArtJuegoD', 'SubCuenta', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'ArtJuegoD', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'ArtJuegoD','Opcion','Art','Articulo'
GO

/****** Juegos ******/
if not exists(select * from SysTabla where SysTabla = 'ArtJuego')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtJuego','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtJuego') and type = 'U') 
CREATE TABLE dbo.ArtJuego (
	Articulo 		varchar(20) 	NOT NULL,
	Juego			varchar(10)	NOT NULL,

	Descripcion		varchar(100)	NULL,
	Cantidad		float		NULL,
	CantidadVariable	bit		NOT NULL 	DEFAULT 0,
	PrecioIndependiente	bit		NOT NULL 	DEFAULT 0,
	Opcional		bit		NOT NULL 	DEFAULT 0,
	SinOpcionOmision	bit		NOT NULL 	DEFAULT 0,
	ListaPreciosEsp		varchar(20)	NULL,
	HeredarOpcion		bit		NULL 		DEFAULT 0,

	CONSTRAINT priArtJuego PRIMARY KEY CLUSTERED (Articulo, Juego)
)
GO
EXEC spALTER_TABLE 'ArtJuego', 'ListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ArtJuego', 'HeredarOpcion', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtJuegoBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtJuegoBC
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgArtJuegoBC ON ArtJuego
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ArticuloN  varchar(20),
    @ArticuloA  varchar(20),
    @JuegoN	varchar(10),
    @JuegoA	varchar(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ArticuloN = Articulo, @JuegoN = Juego FROM Inserted
  SELECT @ArticuloA = Articulo, @JuegoA = Juego FROM Deleted
  IF @ArticuloN <> @ArticuloA OR @JuegoN <> @JuegoA
  BEGIN
    IF @ArticuloN IS NULL
      DELETE ArtJuegoD WHERE Articulo = @ArticuloA AND Juego = @JuegoA
    ELSE
      UPDATE ArtJuegoD SET Articulo = @ArticuloN, Juego = @JuegoN WHERE Articulo = @ArticuloA AND Juego = @JuegoA
  END
END
GO

/****** ArtMaterial ******/
if (select version from version)<=1239 
DELETE SysTabla WHERE SysTabla = 'ArtMaterial'
if not exists(select * from SysTabla where SysTabla = 'ArtMaterial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtMaterial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtMaterial') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtMaterial (
	Articulo	varchar(20) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL IDENTITY(1,1),

	SiOpcion	varchar(100)	NULL,
	Material	varchar(20)	NULL,
	SubCuenta	varchar(50)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Merma		float		NULL,		-- % 
	Desperdicio	float		NULL,
	Almacen		varchar(10)	NULL,
	CentroTipo	varchar(20)	NULL,
    Centro		varchar(10) NULL,
	CostoAcumulado	float		NULL,
	Orden		int		NULL,
	Porcentaje	float		NULL,
	Volumen		float		NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	
	LugarConsumo	varchar(20)	NULL,

 	CONSTRAINT priArtMaterial PRIMARY KEY  CLUSTERED (Articulo, OrdenID)
  )
  EXEC spSincroSemilla 'ArtMaterial'
END
GO
EXEC spALTER_TABLE 'ArtMaterial', 'Porcentaje', 'float NULL'
EXEC spALTER_TABLE 'ArtMaterial', 'Volumen', 'float NULL'
GO
EXEC spALTER_COLUMN 'ArtMaterial', 'SubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'ArtMaterial', 'CostoAcumulado', 'float NULL'
GO
EXEC spFK 'ArtMaterial','Material','Art','Articulo'
GO
EXEC spALTER_TABLE 'ArtMaterial', 'Centro', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'ArtMaterial', 'LugarConsumo', 'varchar(20) NULL'
GO

/****** ArtMaterialHist ******/
if not exists(select * from SysTabla where SysTabla = 'ArtMaterialHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtMaterialHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtMaterialHist') and type = 'U') 
  CREATE TABLE dbo.ArtMaterialHist (
	ID		int		NOT NULL IDENTITY(1,1),

	Articulo	varchar(20) 	NULL,
	FechaD		datetime	NULL,
	FechaA		datetime	NULL,

 	CONSTRAINT priArtMaterialHist PRIMARY KEY  CLUSTERED (ID)
  )
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ArtMaterialHist' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.ArtMaterialHist (Articulo)
GO

/****** ArtMaterialHistD ******/
if not exists(select * from SysTabla where SysTabla = 'ArtMaterialHistD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtMaterialHistD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtMaterialHistD') and type = 'U') 
  CREATE TABLE dbo.ArtMaterialHistD (
	ID		int		NOT NULL,
	Articulo	varchar(20) 	NOT NULL,
 	OrdenID		int 	    	NOT NULL,

	SiOpcion	varchar(100)	NULL,
	Material	varchar(20)	NULL,
	SubCuenta	varchar(50)	NULL,
	Cantidad	float		NULL,
	Unidad		varchar(50)	NULL,
	Merma		float		NULL,		-- % 
	Desperdicio	float		NULL,
	Almacen		varchar(10)	NULL,
	CentroTipo	varchar(20)	NULL,
	CostoAcumulado	float		NULL,
	Orden		int		NULL,
	Porcentaje	float		NULL,
	Volumen		float		NULL,

 	CONSTRAINT priArtMaterialHistD PRIMARY KEY  CLUSTERED (ID, Articulo, OrdenID)
  )
GO
EXEC spALTER_COLUMN 'ArtMaterialHistD', 'SubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'ArtMaterialHistD', 'SubCuenta', 'varchar(50) NULL'
GO
EXEC spALTER_COLUMN 'ArtMaterialHistD', 'CostoAcumulado', 'float NULL'
GO

EXEC spFK 'ArtMaterialHistD','Material','Art','Articulo'
EXEC spFK 'ArtMaterialHistD','ID','ArtMaterialHist','ID'
GO

/****** ArtOpcion  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtOpcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtOpcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtOpcion') and type = 'U') 
CREATE TABLE dbo.ArtOpcion (
	Articulo 		varchar(20)   	NOT NULL,
	Opcion	 		char(1)  	NOT NULL,
	
	Orden			int		NULL,
	ListaEspecifica		varchar(50)	NULL,
	Requerido		bit		NOT NULL	DEFAULT 0,
	ValorOmision		int		NULL,
	Asistente		varchar(20)	NULL,
	TieneMovimientos	bit		NULL		DEFAULT 0,

	CONSTRAINT priArtOpcion PRIMARY KEY CLUSTERED (Articulo, Opcion)
)
GO
EXEC spALTER_TABLE 'ArtOpcion', 'TieneMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK 'ArtOpcion','Opcion','Opcion','Opcion'
EXEC spFK 'ArtOpcion','Articulo','Art','Articulo'
GO

/****** ArtOpcionD ******/
if not exists(select * from SysTabla where SysTabla = 'ArtOpcionD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtOpcionD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtOpcionD') and type = 'U') 
CREATE TABLE dbo.ArtOpcionD (
	Articulo		varchar(20)	NOT NULL,
	Opcion			char(1) 	NOT NULL,	
	Numero			int		NOT NULL,
	
	InformacionAdicional	varchar(100)	NULL, --MEJORA1394
	Imagen					varchar(255)	NULL, --MEJORA1394
	
	TieneMovimientos	bit		NULL	DEFAULT 0,

	CONSTRAINT priArtOpcionD PRIMARY KEY CLUSTERED (Articulo, Opcion, Numero)
)
GO
EXEC spALTER_TABLE 'ArtOpcionD', 'TieneMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK2 'ArtOpcionD','Articulo','Opcion','ArtOpcion','Articulo','Opcion'
GO

EXEC spALTER_TABLE 'ArtOpcionD', 'InformacionAdicional', 'varchar(100)	NULL' --MEJORA1394
EXEC spALTER_TABLE 'ArtOpcionD', 'Imagen', 'varchar(255)	NULL' --MEJORA1394
GO

/****** ArtPlanEx ******/
if not exists(select * from SysTabla where SysTabla = 'ArtPlanEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtPlanEx','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtPlanEx') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtPlanEx (
	Articulo		varchar(20)	NOT NULL,
	ID			int		IDENTITY(1,1) NOT NULL,

	SiOpcion		varchar(100)	NULL,
	SiAlmacen		varchar(10)	NULL,

	TiempoEntrega		int		NULL,
	TiempoEntregaUnidad	varchar(10) 	NULL,
	TiempoEntregaSeg	int		NULL,
	TiempoEntregaSegUnidad	varchar(10) 	NULL,
	InvSeguridad		float		NULL,

	LoteOrdenar		varchar(30)	NULL,
	CantidadOrdenar		float		NULL,
	MultiplosOrdenar	float		NULL,
	CantidadOrdenarTiempo	float		NULL,

	ProdRuta		varchar(20)	NULL,
	AlmacenROP		varchar(10)	NULL,
	Proveedor		varchar(10)	NULL,
	RutaDistribucion	varchar(50)	NULL,

	CONSTRAINT priArtPlanEx PRIMARY KEY CLUSTERED (Articulo, ID)
  )
  EXEC spSincroSemilla 'ArtPlanEx'
END
GO
EXEC spALTER_TABLE 'ArtPlanEx', 'RutaDistribucion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtPlanEx', 'CantidadOrdenarTiempo', 'float NULL'
GO

EXEC spFK 'ArtPlanEx','Articulo','Art','Articulo'
EXEC spFK 'ArtPlanEx','Proveedor','Prov','Proveedor'
GO

/****** Historico de Precios ******/
if not exists(select * from SysTabla where SysTabla = 'ArtPrecioHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtPrecioHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtPrecioHist') and type = 'U') 
BEGIN
  EXEC("CREATE TABLE dbo.ArtPrecioHist (
	Articulo		varchar(20)	NOT NULL,
	Numero			int		NOT NULL,
	Fecha                   datetime   	NOT NULL,
	RenglonID		int		NOT NULL	IDENTITY(1,1),

	PrecioAnterior		money		NULL,
	PrecioActual		money		NULL,

	CONSTRAINT priArtPrecioHist PRIMARY KEY CLUSTERED (Articulo, Numero, Fecha, RenglonID)
  )")
  EXEC spSincroSemilla 'ArtPrecioHist'
END
GO
if not exists(select * from syscampo where tabla = 'ArtPrecioHist' AND Campo = 'RenglonID')
BEGIN
  EXEC("spALTER_TABLE 'ArtPrecioHist', 'RenglonID', 'int IDENTITY(1,1) NOT NULL'")
  EXEC("spEliminarPK 'ArtPrecioHist'")
  EXEC("ALTER TABLE ArtPrecioHist ADD CONSTRAINT priArtPrecioHist PRIMARY KEY CLUSTERED (Articulo, Numero, Fecha, RenglonID)")
END
GO

EXEC spFK 'ArtPrecioHist','Articulo','Art','Articulo'
GO

/****** Historico de Costos ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCostoHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCostoHist','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCostoHist') and type = 'U') 
BEGIN
  EXEC("CREATE TABLE dbo.ArtCostoHist (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)		NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	Fecha                   datetime   	NOT NULL,
	RenglonID		int		NOT NULL	IDENTITY(1,1),

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CostoPromedio		money		NULL,

	CONSTRAINT priArtCostoHist PRIMARY KEY CLUSTERED (Articulo, Fecha, RenglonID, Sucursal, Empresa)
  )")
  EXEC spSincroSemilla 'ArtCostoHist'
END
GO
EXEC spModificarPK_AcumSaldo 'ArtCostoHist', '(Articulo, Fecha, RenglonID, Sucursal, Empresa)'
GO
if not exists(select * from syscampo where tabla = 'ArtCostoHist' AND Campo = 'RenglonID')
BEGIN
  EXEC("spALTER_TABLE 'ArtCostoHist', 'RenglonID', 'int IDENTITY(1,1) NOT NULL'")
  EXEC("spEliminarPK 'ArtCostoHist'")
  EXEC("ALTER TABLE ArtCostoHist ADD CONSTRAINT priArtCostoHist PRIMARY KEY CLUSTERED (Articulo, Fecha, RenglonID, Sucursal, Empresa)")
END
GO
EXEC spALTER_TABLE 'ArtCostoHist', 'CostoPromedio', 'money NULL'
GO

/****** Historico de Costos ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSubCostoHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSubCostoHist','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSubCostoHist') and type = 'U') 
BEGIN
  EXEC("CREATE TABLE dbo.ArtSubCostoHist (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)	NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',
	Fecha                   datetime   	NOT NULL,
	RenglonID		int		NOT NULL	IDENTITY(1,1),

	UltimoCostoAnterior	money		NULL,
	UltimoCostoActual	money		NULL,

	CostoPromedio		money		NULL,

	CONSTRAINT priArtSubCostoHist PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Sucursal, Empresa, Fecha, RenglonID)
  )")
  EXEC spSincroSemilla 'ArtSubCostoHist'
END
GO
EXEC spModificarPK_AcumSaldo 'ArtSubCostoHist', '(Articulo, SubCuenta, Sucursal, Empresa, Fecha, RenglonID)'
GO
if not exists(select * from syscampo where tabla = 'ArtSubCostoHist' AND Campo = 'RenglonID')
BEGIN
  EXEC("spALTER_TABLE 'ArtSubCostoHist', 'RenglonID', 'int IDENTITY(1,1) NOT NULL'")
  EXEC("spEliminarPK 'ArtSubCostoHist'")
  EXEC("ALTER TABLE ArtSubCostoHist ADD CONSTRAINT priArtSubCostoHist PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Sucursal, Empresa, Fecha, RenglonID)")
END
GO
EXEC spALTER_TABLE 'ArtSubCostoHist', 'CostoPromedio', 'money NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtSubCostoHist' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtSubCostoHist'
  EXEC spALTER_COLUMN 'ArtSubCostoHist', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtSubCostoHist ADD CONSTRAINT priArtSubCostoHist PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Sucursal, Empresa, Fecha, RenglonID)')
END
GO

/****** Presentaciones  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtPresenta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtPresenta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtPresenta') and type = 'U') 
CREATE TABLE dbo.ArtPresenta (
	Articulo		varchar(20)	NOT NULL,
	Presentacion		varchar(20) 	NOT NULL,

	Descripcion		varchar(50) 	NULL,
	Factor	 		float     	NULL,

	CONSTRAINT priArtPresenta PRIMARY KEY CLUSTERED (Articulo, Presentacion)
)
GO

EXEC spFK 'ArtPresenta','Presentacion','Art','Articulo'
GO

/****** Articulos por Proveedor ******/
if not exists(select * from SysTabla where SysTabla = 'ArtProv')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtProv','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtProv') and type = 'U') 
CREATE TABLE dbo.ArtProv (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Proveedor 		varchar(10)  	NOT NULL,

	Clave	 		varchar(20)   	NULL,
	Unidad			varchar(50)	NULL,
        CostoAutorizado	        float       	NULL,
        UltimoCosto	        float       	NULL,
	UltimaCompra		datetime	NULL,
	CompraMinimaCantidad	float		NULL,
	CompraMinimaImporte	money		NULL,
	Multiplos		int		NULL		DEFAULT 1,
	DiasRespuesta		int         	NULL,  

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	ProveedorOmision	bit		NOT NULL 	DEFAULT 0,

        UltimaCotizacion     	money       	NULL,
	FechaCotizacion		datetime	NULL,

	CONSTRAINT priArtProv PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgArtProvBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtProvBC
GO
EXEC spALTER_TABLE 'ArtProv', 'SubCuenta', 'varchar(50) NOT NULL DEFAULT "" WITH VALUES'
GO
if (select version from version) <= 1496
BEGIN
  EXEC spEliminarPK 'ArtProv'
  ALTER TABLE ArtProv ADD CONSTRAINT priArtProv PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor)
END
GO
EXEC spALTER_TABLE 'ArtProv', 'UltimaCotizacion', 'money NULL'
EXEC spALTER_TABLE 'ArtProv', 'FechaCotizacion', 'datetime NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtProv' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtProv'
  EXEC spALTER_COLUMN 'ArtProv', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtProv ADD CONSTRAINT priArtProv PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor)')
END
GO
EXEC spALTER_COLUMN 'ArtProv', 'UltimoCosto', 'float NULL'
EXEC spALTER_COLUMN 'ArtProv', 'CostoAutorizado', 'float NULL'
GO
EXEC spFK 'ArtProv','Articulo','Art','Articulo'
EXEC spFK 'ArtProv','Proveedor','Prov','Proveedor'
GO

/****** ArtProvHist ******/
if (select version from version)<=2109 delete SysTabla where SysTabla = 'ArtProvHist'
GO
if not exists(select * from SysTabla where SysTabla = 'ArtProvHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtProvHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtProvHist') and type = 'U') 
BEGIN
  EXEC("CREATE TABLE dbo.ArtProvHist (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Proveedor 		varchar(10)  	NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

        Cotizacion     		money       	NULL,
	FechaCotizacion		datetime	NULL,

	CONSTRAINT priArtProvHist PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, RID)
  )")
  EXEC spSincroSemilla 'ArtProvHist'
END
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtProvHist' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtProvHist'
  EXEC spALTER_COLUMN 'ArtProvHist', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtProvHist ADD CONSTRAINT priArtProvHist PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, RID)')
END
GO

CREATE TRIGGER tgArtProvBC ON ArtProv
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  IF UPDATE(UltimaCotizacion) OR UPDATE(FechaCotizacion)
    INSERT ArtProvHist (Articulo, SubCuenta, Proveedor, Cotizacion,       FechaCotizacion)
                 SELECT Articulo, SubCuenta, Proveedor, UltimaCotizacion, FechaCotizacion
                   FROM Inserted
                  WHERE ISNULL(UltimaCotizacion, 0) <> 0
END
GO

--- drop table ArtProvSucursal
/****** Articulos por Proveedor a Nivel Sucursal de Compra ******/
if not exists(select * from SysTabla where SysTabla = 'ArtProvSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtProvSucursal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtProvSucursal') and type = 'U') 
CREATE TABLE dbo.ArtProvSucursal (
	Articulo 		varchar(20)   	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL 	DEFAULT '',
	Proveedor 		varchar(10)  	NOT NULL,
	Sucursal		int		NOT NULL,

        CostoAutorizado	        float       	NULL,
        UltimoCosto	        float       	NULL,
	UltimaCompra		datetime	NULL,
	CompraMinimaCantidad	float		NULL,
	CompraMinimaImporte	money		NULL,
	Multiplos		int		NULL		DEFAULT 1,
	DiasRespuesta		int         	NULL,  

        UltimaCotizacion     	money       	NULL,
	FechaCotizacion		datetime	NULL,

	CONSTRAINT priArtProvSucursal PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, Sucursal)
)
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtProvSucursal' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtProvSucursal'
  EXEC spALTER_COLUMN 'ArtProvSucursal', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtProvSucursal ADD CONSTRAINT priArtProvSucursal PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Proveedor, Sucursal)')
END
GO
EXEC spALTER_COLUMN 'ArtProvSucursal', 'UltimoCosto', 'float NULL'
EXEC spALTER_COLUMN 'ArtProvSucursal', 'CostoAutorizado', 'float NULL'
GO
EXEC spFK 'ArtProvSucursal','Articulo','Art','Articulo'
EXEC spFK 'ArtProvSucursal','Sucursal','Sucursal','Sucursal'
EXEC spFK 'ArtProvSucursal','Proveedor','Prov','Proveedor'
GO

/****** Refacciones ******/
if not exists(select * from SysTabla where SysTabla = 'ArtRefaccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtRefaccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtRefaccion') and type = 'U') 
CREATE TABLE dbo.ArtRefaccion (
	Articulo 		varchar(20) 	NOT NULL,
	Refaccion		varchar(20) 	NOT NULL,
	Cantidad		int		NULL,

	CONSTRAINT priArtRefaccion PRIMARY KEY CLUSTERED (Articulo, Refaccion)
)

EXEC spFK 'ArtRefaccion','Refaccion','Art','Articulo'
GO

/****** ArtServicio ******/
if not exists(select * from SysTabla where SysTabla = 'ArtServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtServicio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtServicio') and type = 'U') 
CREATE TABLE dbo.ArtServicio (
	Articulo 		varchar(20) 	NOT NULL,
	Servicio		varchar(20) 	NOT NULL,
	Cantidad		float		NULL,
	CantidadExpress		float		NULL,
	Unidad			varchar(50)	NULL,	

	CONSTRAINT priArtServicio PRIMARY KEY CLUSTERED (Articulo, Servicio)
)
GO
IF (SELECT Version FROM Version)<=2422
  ALTER TABLE ArtServicio ALTER COLUMN Cantidad float NULL
GO
EXEC spALTER_TABLE 'ArtServicio', 'CantidadExpress', 'float NULL'
EXEC spALTER_TABLE 'ArtServicio', 'Unidad', 'varchar(50) NULL'
GO

EXEC spFK 'ArtServicio','Servicio','Art','Articulo'
GO

/****** Fechas ******/
if not exists(select * from SysTabla where SysTabla = 'ArtFecha')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtFecha','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtFecha') and type = 'U') 
CREATE TABLE dbo.ArtFecha (
	Articulo 		varchar(20) 	NOT NULL,
	FechaD			datetime 	NOT NULL,
	FechaA			datetime 	NULL,

	CONSTRAINT priArtFecha PRIMARY KEY CLUSTERED (Articulo, FechaD)
)
GO

/****** ArtSub ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSub')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSub','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSub') and type = 'U') 
CREATE TABLE dbo.ArtSub (
	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL,

	CostoEstandar		float	  	NULL,
	CostoReposicion		float		NULL,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	
	Fabricante 		varchar(50)  	NULL,
	ClaveFabricante		varchar(50)	NULL,
	Horas			int		NULL,
	Minutos			int		NULL,

	CONSTRAINT priArtSub PRIMARY KEY  CLUSTERED (Articulo, SubCuenta)
)
GO
EXEC spALTER_TABLE 'ArtSub', 'Fabricante', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtSub', 'ClaveFabricante', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtSub', 'Horas', 'int NULL'
if (select version from version)<=2124
  EXEC("ALTER TABLE ArtSub ALTER COLUMN Horas int NULL")
GO
EXEC spALTER_TABLE 'ArtSub', 'Minutos', 'int NULL'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtSub' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtSub'
  EXEC spALTER_COLUMN 'ArtSub', 'SubCuenta', 'varchar(50) NOT NULL'
  EXEC('ALTER TABLE ArtSub ADD CONSTRAINT priArtSub PRIMARY KEY  CLUSTERED (Articulo, SubCuenta)')
END
GO
EXEC spALTER_COLUMN 'ArtSub', 'CostoEstandar', 'float NULL'
EXEC spALTER_COLUMN 'ArtSub', 'CostoReposicion', 'float NULL'
GO
EXEC spFK 'ArtSub','Articulo','Art','Articulo'
GO

/****** ArtSucursal ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSucursal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSucursal') and type = 'U') 
CREATE TABLE dbo.ArtSucursal (
	Articulo	varchar(20)	NOT NULL,
	Sucursal	int		NOT NULL,

	PrecioMinimo	money		NULL,

	CONSTRAINT priArtSucursal PRIMARY KEY  CLUSTERED (Articulo, Sucursal)
)
GO

EXEC spFK 'ArtSucursal','Sucursal','Sucursal','Sucursal'
EXEC spFK 'ArtSucursal','Articulo','Art','Articulo'
GO

/****** Sustitutos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtSustituto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtSustituto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtSustituto') and type = 'U') 
CREATE TABLE dbo.ArtSustituto (
	Articulo		varchar(20)	NOT NULL,
	Sustituto		varchar(20) 	NOT NULL,	

	Orden			int		NULL,
	Comentarios		varchar(100)	NULL,
	Factor			float		NULL	DEFAULT 1.0,

	CONSTRAINT priArtSustituto PRIMARY KEY CLUSTERED (Articulo, Sustituto)
)
GO
EXEC spALTER_TABLE 'ArtSustituto', 'Factor', 'float NULL DEFAULT 1.0 WITH VALUES'
GO

EXEC spFK 'ArtSustituto','Articulo','Art','Articulo'
EXEC spFK 'ArtSustituto','Sustituto','Art','Articulo'
GO

/****** ArtUnidad ******/
if not exists(select * from SysTabla where SysTabla = 'ArtUnidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtUnidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtUnidad') and type = 'U') 
CREATE TABLE dbo.ArtUnidad (
	Articulo				varchar(20)	NOT NULL,
	Unidad	 				varchar(50)	NOT NULL,
	Factor					float			NULL,
	Peso					float			NULL,
	Volumen					float			NULL,
	
	--REQ12615 WMS
	AltoTarima				float			NULL,
	LargoTarima				float			NULL,
	AnchoTarima				float			NULL,
	CantidadUnidadTarima	int				NULL,
	CantidadCamaTarima		int				NULL,

	CONSTRAINT priArtUnidad PRIMARY KEY CLUSTERED (Articulo, Unidad)
)
GO
--REQ12615 WMS
EXEC spAlter_Table 'ArtUnidad', 'AltoTarima', 'float NULL'
EXEC spAlter_Table 'ArtUnidad', 'LargoTarima', 'float NULL'
EXEC spAlter_Table 'ArtUnidad', 'AnchoTarima', 'float NULL'
EXEC spAlter_Table 'ArtUnidad', 'CantidadUnidadTarima', 'int NULL'
EXEC spAlter_Table 'ArtUnidad', 'CantidadCamaTarima', 'int NULL'
GO

EXEC spFK 'ArtUnidad','Articulo','Art','Articulo'
EXEC spFK 'ArtUnidad','Unidad','Unidad','Unidad'
GO
--BUG2821
EXEC spALTER_COLUMN 'ArtUnidad', 'CantidadUnidadTarima', 'float NULL'
EXEC spALTER_COLUMN 'ArtUnidad', 'CantidadCamaTarima', 'float NULL'
GO

EXEC spReplicaTema 'Articulos', 'Art',			'Articulo', @Principal = 1
EXEC spReplicaTema 'Articulos', 'ArtSub',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtAcceso',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtAnexo',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtLoteFijo',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtActividad',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtPresenta',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtMatriz',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtJuego',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtProv',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtProvSucursal',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtPrecioHist',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtSituacionHist',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtCostoHist',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtSubCostoHist',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ListaPreciosD',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtIdioma',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtFecha',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtMaterial',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtPlanEx',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtSucursal',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtKms',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtCompraProrrateo',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtUnidad',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtAccesorio',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtRefaccion',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtServicio',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtConsumible',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtVINAccesorio',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtInfoAdicional',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtDescuentoCompra',	'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtCalidad',		'Articulo'
EXEC spReplicaTema 'Articulos', 'ArtACCupon',		'Articulo'
EXEC spReplicaTema 'Articulos', 'Prop'	,		'Cuenta', 'Rama', '"INV"'
EXEC spReplicaTema 'Articulos', 'ListaD',		'Cuenta', 'Rama', '"INV"'
EXEC spReplicaTema 'Articulos', 'AnexoCta',		'Cuenta', 'Rama', '"INV"'
GO

/*******************************************************************************************/
/*                                       PROVEEDORES                                       */
/*******************************************************************************************/

/****** Categorias de Proveedores  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvCat') and type = 'U') 
CREATE TABLE dbo.ProvCat (
	Categoria 		varchar(50) 	NOT NULL,

	CategoriaMaestra 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priProvCat PRIMARY KEY  CLUSTERED (Categoria)
)


/****** Familias de Proveedores  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvFam') and type = 'U') 
CREATE TABLE dbo.ProvFam (
	Familia 		varchar(50) 	NOT NULL ,

	FamiliaMaestra	 	varchar(50) 	NULL,
	Icono			int	  	NULL,

	CONSTRAINT priProvFam PRIMARY KEY  CLUSTERED (Familia)
)

/****** Compradores ******/
if not exists(select * from SysTabla where SysTabla = 'Comprador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Comprador','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Comprador') and type = 'U') 
CREATE TABLE dbo.Comprador (
	Comprador 		varchar(50)  	NOT NULL,

	CONSTRAINT priComprador PRIMARY KEY CLUSTERED (Comprador)
)
GO

/****** Acceso Proveedores ******/
if not exists(select * from SysTabla where SysTabla = 'ProvAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvAcceso') and type = 'U') 
CREATE TABLE dbo.ProvAcceso (
	Proveedor		varchar(10) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priProvAcceso PRIMARY KEY  CLUSTERED (Proveedor, Usuario)
)
go

/****** Acceso Proveedores ******/
if not exists(select * from SysTabla where SysTabla = 'ProvAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvAcceso') and type = 'U') 
CREATE TABLE dbo.ProvAcceso (
	Proveedor		varchar(10) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priProvAcceso PRIMARY KEY  CLUSTERED (Proveedor, Usuario)
)
go


/****** ProvAutoCargos  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvAutoCargos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvAutoCargos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvAutoCargos') and type = 'U') 
CREATE TABLE dbo.ProvAutoCargos (
	Proveedor 	varchar(10) 	NOT NULL,
	Concepto	varchar(50)	NOT NULL,

	Porcentaje	float	 	NULL,  
	FechaD		datetime	NULL,
	FechaA		datetime	NULL,

	CONSTRAINT priProvAutoCargos PRIMARY KEY  CLUSTERED (Proveedor, Concepto)
)
go
EXEC spALTER_TABLE 'ProvAutoCargos', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'ProvAutoCargos', 'FechaA', 'datetime NULL'
go

/*** ProvTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.ProvTipo') and type = 'V') drop view dbo.ProvTipo
GO
if not exists(select * from SysTabla where SysTabla = 'ProvTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvTipo') and type = 'U') 
CREATE TABLE dbo.ProvTipo (
	Tipo		varchar(20)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priProvTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** Cuotas Proveedores (Desc) ******/
if not exists(select * from SysTabla where SysTabla = 'ProvCuotaDesc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvCuotaDesc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvCuotaDesc') and type = 'U') 
CREATE TABLE dbo.ProvCuotaDesc (
	Proveedor		varchar(10) 	NOT NULL,
	Familia			varchar(50) 	NOT NULL,
	FechaD			datetime	NOT NULL,
	FechaA			datetime	NOT NULL,
	Porcentaje		float		NOT NULL,

	Descuento		float		NULL,

	CONSTRAINT priProvCuotaDesc PRIMARY KEY  CLUSTERED (Proveedor, Familia, FechaD, FechaA, Porcentaje)
)
go

/****** Cuotas Proveedores ******/
if not exists(select * from SysTabla where SysTabla = 'ProvCuota')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvCuota','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvCuota') and type = 'U') 
CREATE TABLE dbo.ProvCuota (
	Proveedor		varchar(10) 	NOT NULL,
	Familia			varchar(50) 	NOT NULL,
	FechaD			datetime	NOT NULL,
	FechaA			datetime	NOT NULL,

	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	BaseDescuento		varchar(20)	NULL,

	CONSTRAINT priProvCuota PRIMARY KEY  CLUSTERED (Proveedor, Familia, FechaD, FechaA)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgProvCuotaBC') and sysstat & 0xf = 8) drop trigger dbo.tgProvCuotaBC
GO
CREATE TRIGGER tgProvCuotaBC ON ProvCuota
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProveedorN  	varchar(10),
    @ProveedorA  	varchar(10),
    @FamiliaN  		varchar(50),
    @FamiliaA  		varchar(50),
    @FechaDN  		datetime,
    @FechaDA  		datetime,
    @FechaAN  		datetime,
    @FechaAA  		datetime
    
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ProveedorN = Proveedor, @FamiliaN = Familia, @FechaDN = FechaD, @FechaAN = FechaA  FROM Inserted
  SELECT @ProveedorA = Proveedor, @FamiliaA = Familia, @FechaDA = FechaD, @FechaAA = FechaA  FROM Deleted

  IF @ProveedorN = @ProveedorA AND @FamiliaN = @FamiliaA AND @FechaDN = @FechaDA AND @FechaAN = @FechaAA RETURN

  IF @ProveedorN IS NULL
  BEGIN
    DELETE ProvCuotaDesc 
     WHERE Proveedor = @ProveedorA AND Familia = @FamiliaA AND FechaD = @FechaDA AND FechaA = @FechaAA
  END ELSE
  BEGIN
    UPDATE ProvCuotaDesc 
       SET Proveedor = @ProveedorN, 
	   Familia = @FamiliaN, 
           FechaD = @FechaDN, 
           FechaA = @FechaAN 
     WHERE Proveedor = @ProveedorA AND Familia = @FamiliaA AND FechaD = @FechaDA AND FechaA = @FechaAA
  END
END
GO

/****** Cuotas Articulos (Desc)******/
if not exists(select * from SysTabla where SysTabla = 'ArtCuotaDesc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCuotaDesc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCuotaDesc') and type = 'U') 
CREATE TABLE dbo.ArtCuotaDesc (
	Articulo		varchar(10) 	NOT NULL,
	Proveedor		varchar(10)	NOT NULL,
	FechaD			datetime	NOT NULL,
	FechaA			datetime	NOT NULL,
	Porcentaje		float		NOT NULL,
	Descuento		float		NULL,
	PorcentajeIncremento	float		NULL,
	Factor			float		NULL

	CONSTRAINT priArtCuotaDesc PRIMARY KEY  CLUSTERED (Articulo, Proveedor, FechaD, FechaA, Porcentaje)
)
go

/****** Cuotas Articulos ******/
if not exists(select * from SysTabla where SysTabla = 'ArtCuota')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCuota','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtCuota') and type = 'U') 
CREATE TABLE dbo.ArtCuota (
	Articulo		varchar(10) 	NOT NULL,
	Proveedor		varchar(10)	NOT NULL,
	FechaD			datetime	NOT NULL,
	FechaA			datetime	NOT NULL,

	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	BaseDescuento		varchar(20)	NULL,

	CONSTRAINT priArtCuota PRIMARY KEY  CLUSTERED (Articulo, Proveedor, FechaD, FechaA)
)
go

--EXEC spFK 'ArtCuota','Proveedor','Prov','Proveedor'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgArtCuotaBC') and sysstat & 0xf = 8) drop trigger dbo.tgArtCuotaBC
GO
CREATE TRIGGER tgArtCuotaBC ON ArtCuota
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ArticuloN 		varchar(50),
    @ArticuloA 		varchar(50),
    @ProveedorN  	varchar(10),
    @ProveedorA  	varchar(10),
    @FechaDN  		datetime,
    @FechaDA  		datetime,
    @FechaAN  		datetime,
    @FechaAA  		datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ArticuloN = Articulo, @ProveedorN = Proveedor, @FechaDN = FechaD, @FechaAN = FechaA  FROM Inserted
  SELECT @ArticuloA = Articulo, @ProveedorA = Proveedor, @FechaDA = FechaD, @FechaAA = FechaA  FROM Deleted

  IF @ProveedorN = @ProveedorA AND @ArticuloN = @ArticuloA AND @FechaDN = @FechaDA AND @FechaAN = @FechaAA RETURN

  IF @ArticuloN IS NULL
  BEGIN
    DELETE ArtCuotaDesc 
     WHERE Articulo = @ArticuloA AND Proveedor = @ProveedorA AND FechaD = @FechaDA AND FechaA = @FechaAA
  END ELSE
  BEGIN
    UPDATE ArtCuotaDesc 
       SET Articulo = @ArticuloN, 
	   Proveedor = @ProveedorN, 
           FechaD = @FechaDN, 
           FechaA = @FechaAN 
     WHERE Articulo = @ArticuloA AND Proveedor = @ProveedorA AND FechaD = @FechaDA AND FechaA = @FechaAA
  END
END
GO

/****** ProvSucursal  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvSucursal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProvSucursal') and type = 'U') 
CREATE TABLE dbo.ProvSucursal (
	Proveedor 		varchar(10) 	NOT NULL,
	ID			int		NOT NULL DEFAULT 0,

	Nombre 			varchar(100) 	NULL,

	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Colonia 		varchar(30) 	NULL,
	Delegacion		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	Ruta			varchar(50) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,

	Telefonos		varchar(100) 	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit           	NOT NULL DEFAULT 0,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	eMailAuto		bit		NULL 		DEFAULT 0,
	ZonaImpuesto		varchar(30)  	NULL,    -- ExcentoIVA ??
	Agente       		varchar(10)        NULL,

	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Mensaje			varchar(50)	NULL,

	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	Contrasena		varchar(20) 	NULL,
	Clave			varchar(10)	NULL,
	Encargado		varchar(100)	NULL,
	GLN			varchar(50)	NULL,

	CONSTRAINT priProvSucursal PRIMARY KEY  CLUSTERED (Proveedor, ID)
)
go

EXEC spFK 'ProvSucursal','Proveedor','Prov','Proveedor'
GO

/****** Credito de Proveedores  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvCredito')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvCredito','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvCredito') and type = 'U') 
CREATE TABLE dbo.ProvCredito (
	Proveedor 		varchar(10)  	NOT NULL,
	Empresa			varchar(5)	NOT NULL,

	LineaCredito	 	money		NULL,
	Moneda			varchar(10)	NULL,

	CONSTRAINT priProvCredito PRIMARY KEY  CLUSTERED (Proveedor, Empresa)
)
GO

/****** ProvRelacion  ******/
if not exists(select * from SysTabla where SysTabla = 'ProvRelacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvRelacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvRelacion') and type = 'U') 
CREATE TABLE dbo.ProvRelacion (
	Proveedor 	varchar(10) 	NOT NULL,
	Relacion	varchar(10) 	NOT NULL,	

	CONSTRAINT priProvRelacion PRIMARY KEY  CLUSTERED (Proveedor, Relacion)
)
go

EXEC spFK 'ProvRelacion','Proveedor','Prov','Proveedor'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ProvRelacion' AND sysindexes.name = 'Relacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Relacion  ON dbo.ProvRelacion (Relacion, Proveedor)
go

/****** Codigos Barras del Proveedor *****/
if not exists(select * from SysTabla where SysTabla = 'ProvCB')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProvCB','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProvCB') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProvCB (
	Proveedor		varchar(10)	NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	FechaSolicitud		datetime	NULL	DEFAULT GETDATE(),

	SugerenciaCodigo	varchar(20)	NULL,
	SugerenciaArticulo 	varchar(20) 	NULL,
	SugerenciaSubCuenta	varchar(50)	NULL,
	SugerenciaUnidad	varchar(50)	NULL,
	Comentarios		varchar(255)	NULL,

	Estatus			varchar(15)	NULL	DEFAULT 'PENDIENTE',	-- Aceptado / Rechazado

	Codigo        		varchar(20)	NULL,
	Articulo 		varchar(20) 	NULL,
	SubCuenta		varchar(20)	NULL,
	Unidad			varchar(50)	NULL,
	FechaConclusion		datetime	NULL,
	Causa			varchar(100)	NULL,

	CONSTRAINT priProvCB PRIMARY KEY CLUSTERED (Proveedor, ID)
  )
  EXEC spSincroSemilla 'ProvCB'
END
go
EXEC spALTER_COLUMN 'ProvCB', 'SugerenciaSubCuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProvCB', 'SubCuenta', 'varchar(50) NULL'
GO

/****** Proveedores  ******/
if not exists(select * from SysTabla where SysTabla = 'Prov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Prov','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Prov') and type = 'U') 
CREATE TABLE dbo.Prov (
	Proveedor 		varchar(10) 	NOT NULL,

	Rama			varchar(10)	NULL,
	Nombre 			varchar(100)    NULL,
	NombreCorto		varchar(20)	NULL,
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20) 	NULL,
	DireccionNumeroInt	varchar(20) 	NULL,
	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	Delegacion		varchar(100) 	NULL,
	Colonia 		varchar(100) 	NULL,
	Poblacion 		varchar(100) 	NULL,
	Estado 			varchar(30) 	NULL,
	Zona			varchar(30)	NULL,
	Ruta			varchar(50)	NULL,
	Pais 			varchar(30)     NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Telefonos		varchar(100)	NULL,
	Fax 			varchar(50)     NULL,
	PedirTono		bit   		NOT NULL DEFAULT 0,
	DirInternet		varchar(50) 	NULL,
	Contacto1 		varchar(50) 	NULL,
	Contacto2 		varchar(50) 	NULL,
        Extencion1              varchar(10)     NULL,
        Extencion2              varchar(10)     NULL,
	eMail1			varchar(50) 	NULL,
	eMail2			varchar(50) 	NULL,
	RFC 			varchar(15)     NULL,
	CURP			varchar(30)	NULL,
	Categoria 		varchar(50) 	NULL,
	Familia 		varchar(50) 	NULL,
	ZonaImpuesto		varchar(30)  	NULL,  -- ExcentoIVA ??
	FormaEnvio		varchar(50)	NULL,
	Descuento 		varchar(30)  	NULL,
	Comprador		varchar(50)     NULL,
	Proyecto		varchar(50)     NULL,
	Condicion		varchar(50)     NULL,
	CtaDinero		varchar(10)  	NULL,
	Almacen			varchar(10)     	NULL,
	DiaRevision1 		varchar(10)  	NULL,
	DiaRevision2 		varchar(10)  	NULL,
	HorarioRevision		varchar(50) 	NULL,
	DiaPago1 		varchar(10)  	NULL,
	DiaPago2 		varchar(10)  	NULL,
	HorarioPago		varchar(50) 	NULL,
	Beneficiario		int		NULL,
	BeneficiarioNombre	varchar(100)	NULL,
	LeyendaCheque		varchar(100)	NULL,
	Agente			varchar(10)	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Clase			varchar(15)	NULL,
	Estatus 		varchar(15) 	NOT NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	Tipo			varchar(15)	NULL		DEFAULT 'Proveedor',
	ProntoPago		bit       	NOT NULL 	DEFAULT 0,
	DefMoneda		varchar(10)	NULL,

	ProvBancoSucursal 	varchar(50)	NULL,
	ProvCuenta		varchar(20)	NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	TieneMovimientos	bit		NULL		DEFAULT 0,
	DescuentoRecargos	bit		NULL		DEFAULT 0,
	CompraAutoCargosTipo	varchar(20)	NULL		DEFAULT 'No',
	CompraAutoCargos	float		NULL,
	Pagares			bit		NULL		DEFAULT 0,
	Aforo			float		NULL,
	MaximoAplicacionPagos	float		NULL		DEFAULT 100,

        NivelAcceso		varchar(50)	NULL,
	Idioma			varchar(50)	NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	Contrasena		varchar(20) 	NULL,
	AutoEndoso		varchar(10)	NULL,
	Cuenta			varchar(20)	NULL,
	CuentaRetencion		varchar(20)	NULL,
	FormaPago		varchar(50)	NULL,
	wGastoSolicitud		bit		NULL		DEFAULT 0,
	ConLimiteAnticipos	bit		NULL		DEFAULT 0,
	LimiteAnticiposMN	money		NULL,
	ChecarLimite		varchar(20)	NULL		DEFAULT 'Anticipo',
	eMailAuto		bit		NULL 		DEFAULT 0,
	FiscalRegimen		varchar(30)	NULL,
	FiscalZona			varchar(30)	NULL, --MEJORA4769	
	Intercompania		bit 		NULL 		DEFAULT 0,
	GarantiaCostos		bit 		NULL 		DEFAULT 0,
	GarantiaCostosPlazo	int		NULL,

	ImportadorRegimen	varchar(30)	NULL,
	ImportadorRegistro	varchar(30)	NULL,

	Comision		float		NULL,
	Importe1		float		NULL,
	Importe2		float		NULL,

	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
	MapaUbicacion       varchar(100) NULL,

	TipoRegistro		varchar(20)	NULL,
	AutorizacionSRI		varchar(50)	NULL,
	VigenciaSRI			datetime		NULL,
	
	FiscalGenerar		bit			NULL DEFAULT 1,
	ContactoTipo		varchar(20) NULL DEFAULT 'Proveedor',
--REQ12534 Factory  
	INFORTallerExterior	bit			NULL DEFAULT 0,
	INFORProveedorNal	bit			NULL DEFAULT 0,
	ReferenciaIntelisisService varchar(50)	NULL,
	
	--REQ12615 WMS
	DefPosicionRecibo	varchar(10)	NULL,
	DefPosicionSurtido	varchar(10)	NULL,
	TarimasChep			bit			NULL DEFAULT 0,

	CONSTRAINT priProv PRIMARY KEY  CLUSTERED (Proveedor)
)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'Rama' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Rama   ON dbo.Prov (Rama)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.Prov (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'Tipo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tipo   ON dbo.Prov (Tipo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'NombreCorto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NombreCorto ON dbo.Prov (NombreCorto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'RFC' AND sysobjects.id = sysindexes.id)
  CREATE INDEX RFC ON dbo.Prov (RFC)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente ON dbo.Prov (Agente)
go
if exists (select * from sysobjects where id = object_id('dbo.tgProvBC') and sysstat & 0xf = 8) drop trigger dbo.tgProvBC
GO
if not exists(select * from syscampo where tabla = 'Prov' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Prov ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Prov SET TieneMovimientos = 1")
END
GO
EXEC spSincroNivelRegistroCampos 'Prov'
GO
EXEC spALTER_TABLE 'Prov', 'Delegacion', 'varchar(30) NULL'
GO
EXEC spALTER_TABLE 'Prov', 'Ruta', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Prov', 'DescuentoRecargos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'CURP', 'varchar(30)	NULL'
EXEC spALTER_TABLE 'Prov', 'CompraAutoCargos', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'Pagares', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'Aforo','float NULL'
EXEC spALTER_TABLE 'Prov', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'Idioma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'MaximoAplicacionPagos', 'float NULL	DEFAULT 100 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'ListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'LeyendaCheque', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prov', 'Contrasena', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'AutoEndoso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prov', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'CuentaRetencion', 'varchar(20) NULL'
GO
if (select version from version)<=1233
BEGIN
  EXEC("ALTER TABLE Prov ALTER COLUMN HorarioRevision  varchar(50) NULL")
  EXEC("ALTER TABLE Prov ALTER COLUMN HorarioPago      varchar(50) NULL")
END
GO
if (select version from version)<=2237 
  ALTER TABLE Prov ALTER COLUMN Contrasena varchar(20) NULL
GO
EXEC spALTER_TABLE 'Prov', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'CompraAutoCargosTipo', 'varchar(20)	NULL DEFAULT "No" WITH VALUES'
GO
if (select version from version)<=2316
  update Prov SET CompraAutoCargosTipo = 'Directa' WHERE NULLIF(CompraAutoCargos, 0) IS NOT NULL
GO
EXEC spALTER_TABLE 'Prov', 'wGastoSolicitud', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'ConLimiteAnticipos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'LimiteAnticiposMN', 'money NULL'
EXEC spALTER_TABLE 'Prov', 'ChecarLimite', 'varchar(20)	NULL DEFAULT "Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'FiscalRegimen', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Prov', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'DireccionNumeroInt', 'varchar(20) NULL'
GO
if exists(select * from syscampo where tabla = 'Prov' and campo ='eCollaboration') EXEC sp_rename 'Prov.eCollaboration', 'Intercompania', 'COLUMN'
GO
EXEC spALTER_TABLE 'Prov', 'Intercompania', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Prov ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Prov ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Prov ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
if (select version from version)<=2677
  EXEC("ALTER TABLE Prov ALTER COLUMN FiscalRegimen varchar(30) NULL")
GO
EXEC spALTER_TABLE 'Prov', 'GarantiaCostos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Prov', 'GarantiaCostosPlazo', 'int NULL'
EXEC spALTER_TABLE 'Prov', 'ImportadorRegimen', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Prov', 'ImportadorRegistro', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Prov', 'Comision', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prov', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prov', 'Origen', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'OrigenID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'Importe1', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'Importe2', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Prov', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'Prov', 'MapaUbicacion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Prov', 'TipoRegistro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Prov', 'AutorizacionSRI', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'VigenciaSRI', 'datetime NULL'
GO
EXEC spALTER_TABLE 'Prov', 'FiscalGenerar', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'Prov', 'FiscalZona', 'varchar(30) NULL' --MEJORA4769
GO
EXEC spALTER_TABLE 'Prov', 'ContactoTipo', 'varchar(20) NULL DEFAULT "Proveedor" WITH VALUES'
GO
 --REQ12534 Factory  
Exec spAlter_Table 'Prov','INFORTallerExterior','bit Null'
Exec spAlter_Table 'Prov','INFORProveedorNal','bit Null'
Exec spAlter_Table 'Prov', 'ReferenciaIntelisisService',' varchar(50) NULL '     
GO        

--REQ12615 WMS
EXEC spALTER_TABLE 'Prov', 'DefPosicionRecibo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prov', 'DefPosicionSurtido ', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Prov', 'TarimasChep', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Prov' AND sysindexes.name = 'Nombre2' AND sysobjects.id = sysindexes.id)--Bug 21604
CREATE INDEX Nombre2 ON Prov(Proveedor)INCLUDE(Nombre)
go
EXEC spFK 'Prov','Beneficiario','Beneficiario','Beneficiario'
EXEC spFK 'Prov','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Prov','Agente','Agente','Agente'
EXEC spFK 'Prov','Cuenta','Cta','Cuenta'
GO

--User Story 12624
EXEC spALTER_TABLE 'Prov', 'CentroCostos', 'varchar(20) NULL'
GO

--Integración MES
--EXEC spALTER_TABLE 'Prov', 'MES', 'bit NOT NULL DEFAULT 0 WITH VALUES'
--EXEC spDROP_COLUMN 'Prov', 'MES'
--GO

CREATE TRIGGER tgProvBC ON Prov
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @TipoNuevo		varchar(15),
    @TipoAnterior	varchar(15),
    @NombreNuevo	varchar(100),
    @NombreAnterior	varchar(100),
    @RFCNuevo		varchar(20),
    @RFCAnterior	varchar(20),
    @CURPNuevo		varchar(30),
    @CURPAnterior	varchar(30),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Proveedor, @TipoNuevo    = Tipo, @NombreNuevo    = Nombre, @RFCNuevo    = RFC, @CURPNuevo    = CURP  FROM Inserted
  SELECT @ClaveAnterior = Proveedor, @TipoAnterior = Tipo, @NombreAnterior = Nombre, @RFCAnterior = RFC, @CURPAnterior = CURP  FROM Deleted

  /*IF @NombreNuevo <> @NombreAnterior OR @RFCNuevo <> @RFCAnterior OR @CURPNuevo <> @CURPAnterior*/

  IF @ClaveNueva=@ClaveAnterior AND @TipoNuevo=@TipoAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    IF EXISTS (SELECT * FROM Prov WHERE Rama = @ClaveAnterior)
    BEGIN
      SELECT @Mensaje = '"'+LTRIM(RTRIM(@ClaveAnterior))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30165
      RAISERROR (@Mensaje,16,-1) 
    END ELSE
    BEGIN
      DELETE ProvAcceso  	WHERE Proveedor = @ClaveAnterior
      DELETE ProvCredito 	WHERE Proveedor = @ClaveAnterior
      DELETE ProvCuota   	WHERE Proveedor = @ClaveAnterior
      DELETE ProvCuotaDesc 	WHERE Proveedor = @ClaveAnterior
      DELETE ProvAutoCargos 	WHERE Proveedor = @ClaveAnterior
      DELETE ProvSucursal	WHERE Proveedor = @ClaveAnterior
      DELETE ProvRelacion	WHERE Proveedor = @ClaveAnterior
      DELETE ProvCB		WHERE Proveedor = @ClaveAnterior

      DELETE Prop        	WHERE Cuenta = @ClaveAnterior AND Rama='CXP'
      DELETE AnexoCta    	WHERE Cuenta = @ClaveAnterior AND Rama='CXP'
      DELETE CuentaTarea 	WHERE Cuenta = @ClaveAnterior AND Rama='CXP'
	  DELETE CtoCampoExtra   WHERE Tipo = 'Proveedor' AND Clave = @ClaveAnterior
	  DELETE FormaExtraValor WHERE Aplica = 'Proveedor' AND AplicaClave = @ClaveAnterior
	  DELETE FormaExtraD     WHERE Aplica = 'Proveedor' AND AplicaClave = @ClaveAnterior
    END
  END ELSE
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
    IF (SELECT Sincro FROM Version) = 1
      EXEC sp_executesql N'UPDATE Prov SET Rama = @ClaveNueva, SincroC = SincroC WHERE Rama = @ClaveAnterior', N'@ClaveNueva varchar(20), @ClaveAnterior varchar(20)', @ClaveNueva = @ClaveNueva, @ClaveAnterior = @ClaveAnterior
    ELSE
      UPDATE Prov SET Rama = @ClaveNueva WHERE Rama = @ClaveAnterior

    UPDATE Prop        SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'CXP'
    UPDATE AnexoCta    SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'CXP'
    UPDATE CuentaTarea SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'CXP'
    UPDATE Auxiliar    SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama IN ('CXP', 'PEFE', 'PRND')
    UPDATE Acum        SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama IN ('CXP', 'PEFE', 'PRND')
    UPDATE Saldo       SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama IN ('CXP', 'PEFE', 'PRND')
    UPDATE AuxiliarRU  SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'COMS'
    UPDATE AcumRU      SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'COMS'
    UPDATE SaldoRU     SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama = 'COMS'

    UPDATE ProvAcceso    SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvCuota	 SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvCuotaDesc SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvCB	 SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ActivoFijo    SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Embarque      SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE EmbarqueMov   SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Anuncio       SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE PlanArtOP     SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE PlanBitacora  SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Art           SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Cxp           SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Compra        SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvCredito   SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvRelacion  SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Vehiculo      SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProyD         SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ArtPlanEx     SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ArtProv       SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ArtProvSucursal    SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Centro             SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE Soporte            SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE SugerirCostoArtCat SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvAutoCargos     SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior
    UPDATE ProvSucursal       SET Proveedor = @ClaveNueva WHERE Proveedor = @ClaveAnterior

    UPDATE InvGastoDiverso   	SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
    UPDATE InvGastoDiversoD  	SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
    UPDATE CompraGastoDiverso   SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
    UPDATE CompraGastoDiversoD  SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
    UPDATE Gasto		SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
    UPDATE Tramite		SET Acreedor = @ClaveNueva WHERE Acreedor = @ClaveAnterior
	UPDATE CtoCampoExtra	SET Clave   = @ClaveNueva WHERE Clave   = @ClaveAnterior AND Tipo='Proveedor'
	UPDATE FormaExtraValor	SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Proveedor'
	UPDATE FormaExtraD		SET AplicaClave   = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Proveedor'
  END
END
GO

EXEC spReplicaTema 'Proveedores', 'Prov',		'Proveedor', @Principal = 1
EXEC spReplicaTema 'Proveedores', 'ProvAcceso',		'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvCredito',	'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvCuota',		'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvCuotaDesc',	'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvAutoCargos',	'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvSucursal',	'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvRelacion',	'Proveedor'
EXEC spReplicaTema 'Proveedores', 'ProvCB',		'Proveedor'
EXEC spReplicaTema 'Proveedores', 'Prop',		'Cuenta', 'Rama', '"CXP"'
EXEC spReplicaTema 'Proveedores', 'AnexoCta',		'Cuenta', 'Rama', '"CXP"'
EXEC spReplicaTema 'Proveedores', 'CuentaTarea',	'Cuenta', 'Rama', '"CXP"'
GO



if exists (select * from sysobjects where id = object_id('dbo.tgInforProvABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforProvABC
GO
CREATE TRIGGER tgInforProvABC ON Prov
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Proveedor						varchar (10),
   @Estatus						varchar (10),
   @Datos						varchar (max),
   @Datos2						varchar (max),
   @Resultado						varchar(max),
   @Ok							int,
   @OkRef						varchar(255),
   @Id							int,
   @Cinserted		                		int,
   @Cdeleted						int,
   @Empresa						varchar(20),
   @ReferenciaIntelisisService			varchar(50)

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @ProdInterfazINFOR = 1
  BEGIN
    IF @Cinserted <> 0 AND @Cdeleted = 0 
    BEGIN
      SET @Estatus = 'ALTA' 
    END
    IF @Cinserted <> 0 AND @Cdeleted<> 0 
    BEGIN
      SET @Estatus = 'CAMBIO'
    END
    IF @Cinserted = 0 AND @Cdeleted <> 0 
    BEGIN 
      SET @Estatus = 'BAJA'
    END
    IF  @Estatus IN( 'ALTA','CAMBIO')
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Proveedor,ReferenciaIntelisisService
	 FROM Inserted
    END
    ELSE
    IF @Estatus = 'BAJA'
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Proveedor,ReferenciaIntelisisService
         FROM Deleted     
    END          
    IF @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
    BEGIN
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @Proveedor ,@ReferenciaIntelisisService
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        EXEC spInforGenerarSolicitudProveedor  @Proveedor,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
        FETCH NEXT FROM crActualizar INTO @Proveedor,@ReferenciaIntelisisService
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar
    END        
  END
END
GO






/*******************************************************************************************/
/*                                         CODIGOS BARRAS                                  */
/*******************************************************************************************/

/****** Codigos Barras ******/
if not exists(select * from SysTabla where SysTabla = 'CB')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CB','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CB','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CB') and type = 'U') 
CREATE TABLE dbo.CB (
	Codigo        		varchar(30)	NOT NULL,

        TipoCuenta		varchar(20)	NULL,    -- Cliente, Articulo, Almacen, Agente, etc..
	Cuenta	 		varchar(20) 	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Reglas			varchar(20)	NULL,
	SerieLote		varchar(50)	NULL,
	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,
	Observaciones		varchar(100)	NULL,
	Referencia		varchar(50)	NULL,
	Fecha			datetime	NULL	DEFAULT GETDATE(),
	Expresion		varchar(255)	NULL,--REQ 13393 POS
	Accion  		varchar(50)	NULL,--REQ 13393 POS
	FormaPago		varchar(50)	NULL,--REQ 13393 POS
	

	CONSTRAINT priCB PRIMARY KEY CLUSTERED (Codigo)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CB' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.CB (Cuenta)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CB' AND sysindexes.name = 'SerieLote' AND sysobjects.id = sysindexes.id)
  CREATE INDEX SerieLote ON dbo.CB (SerieLote, Cuenta, ModuloID, Modulo)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CB' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.CB (ModuloID, Modulo)
go
EXEC spALTER_TABLE 'CB', 'SerieLote', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CB', 'Modulo', 'char(5) NULL'
EXEC spALTER_TABLE 'CB', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'CB', 'Observaciones', 'varchar(100)	NULL'
go
if (select version from version)<=2452
BEGIN
  EXEC spEliminarPK 'CB'
  EXEC("alter table CB alter column Codigo varchar(30) NOT NULL")
  EXEC("ALTER TABLE CB ADD CONSTRAINT priCB PRIMARY KEY CLUSTERED (Codigo)")
END
go
EXEC spALTER_TABLE 'CB', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CB', 'Fecha', 'datetime NULL DEFAULT GETDATE() WITH VALUES'
EXEC spALTER_COLUMN 'CB', 'SerieLote', 'varchar(50) NULL'
go
EXEC spALTER_COLUMN 'CB', 'SubCuenta', 'varchar(50) NULL'
GO

--REQ 13393 POS
EXEC spALTER_TABLE 'CB', 'Expresion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'CB', 'Accion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CB', 'FormaPago', 'varchar(50) NULL'
GO



/*******************************************************************************************/
/*                                        EMBARQUES                                        */
/*******************************************************************************************/


/* Vehiculos */
if not exists(select * from SysTabla where SysTabla = 'Vehiculo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Vehiculo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Vehiculo') and type = 'U') 
CREATE TABLE dbo.Vehiculo (
	Vehiculo 		varchar(10)  	NOT NULL,

	Descripcion		varchar(100)	NULL,
	Placas			varchar(10)	NULL,

	Volumen			float		NULL,
	Peso			float		NULL,

	Agente 			varchar(10)  	NULL,
	Ruta			varchar(50)	NULL,
	Estatus			varchar(15)	NOT NULL,

	Cxp			bit		NOT NULL 	DEFAULT 0,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,
	Logico4			bit		NOT NULL 	DEFAULT 0,

	TieneMovimientos 	bit		NULL		DEFAULT 0,

	Proveedor		varchar(10)	NULL,
	Condicion		varchar(50)	NULL,
	Concepto		varchar(50)	NULL,

	GenerarGasto		bit		NULL		DEFAULT 0,
     	Clase			varchar(50)	NULL,  
    	Subclase		varchar(50)	NULL,  
	Impuestos		float		NULL,
	Retencion		float		NULL,
	Retencion2		float		NULL,
	Retencion3		float		NULL,

	Articulo		varchar(20)	NULL,
	Serie			varchar(20)	NULL,

	RendimientoCombustible	float		NULL,
	RendimientoTermo	float		NULL,
	Agente2			varchar(10)	NULL,
	Agente3			varchar(10)	NULL,
	Descripcion1		varchar(50)	NULL,
	Descripcion2		varchar(50)	NULL,
	Descripcion3		varchar(50)	NULL,
	Descripcion4		varchar(50)	NULL,
	Descripcion5		varchar(50)	NULL,

	CONSTRAINT priVehiculo PRIMARY KEY CLUSTERED (Vehiculo)
)
GO
if not exists(select * from syscampo where tabla = 'Vehiculo' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Vehiculo ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Vehiculo SET TieneMovimientos = 1")
END
GO
EXEC spALTER_TABLE 'Vehiculo', 'GenerarGasto','bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Vehiculo', 'Clase', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'Vehiculo', 'Subclase', 'varchar(50)	NULL'
GO
EXEC spALTER_TABLE 'Vehiculo', 'Impuestos', 'float NULL'
GO
EXEC spALTER_TABLE 'Vehiculo', 'Retencion', 'float NULL'
GO
EXEC spALTER_TABLE 'Vehiculo', 'Retencion2', 'float NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Articulo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Serie', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'RendimientoCombustible', 'float NULL'
EXEC spALTER_TABLE 'Vehiculo', 'RendimientoTermo', 'float NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Agente2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Agente3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Descripcion1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Descripcion2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Descripcion3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Descripcion4', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Descripcion5', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vehiculo', 'Retencion3', 'float NULL'
GO

EXEC spFK 'Vehiculo','Agente','Agente','Agente'
EXEC spFK 'Vehiculo','Proveedor','Prov','Proveedor'
EXEC spFK 'Vehiculo','Articulo','Art','Articulo'
GO

EXEC spALTER_COLUMN 'Vehiculo', 'Serie', 'varchar(50) NULL'  --BUG12333
GO

/* EmbarqueAcciones */
if not exists(select * from SysTabla where SysTabla = 'EmbarqueAccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmbarqueAccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueAccion') and type = 'U') 
CREATE TABLE dbo.EmbarqueAccion (
	Accion	 	varchar(50)  	NOT NULL,

	Orden		int		NULL,	

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	Logico4		bit		NOT NULL 	DEFAULT 0,
	Logico5		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priEmbarqueAccion PRIMARY KEY CLUSTERED (Accion)
)
GO

/* EmbarqueEstado */
if not exists(select * from SysTabla where SysTabla = 'EmbarqueEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmbarqueEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmbarqueEstado') and type = 'U') 
CREATE TABLE dbo.EmbarqueEstado (
	Estado	 	varchar(50)  	NOT NULL,
	Orden		int		NULL,
	Tipo		varchar(20)	NULL,

	Logico1		bit		NOT NULL 	DEFAULT 0,
	Logico2		bit		NOT NULL 	DEFAULT 0,
	Logico3		bit		NOT NULL 	DEFAULT 0,
	Logico4		bit		NOT NULL 	DEFAULT 0,
	Logico5		bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priEmbarqueEstado PRIMARY KEY CLUSTERED (Estado)
)
GO

/****** PersonalGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalGrupo') and type = 'U') 
CREATE TABLE dbo.PersonalGrupo (
	Grupo		varchar(50) 	NOT NULL,
	Descripcion	varchar(100) 	NULL,
	
	CONSTRAINT priPersonalGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO
EXEC spALTER_TABLE 'PersonalGrupo', 'Descripcion', 'varchar(100) NULL'
GO

/****** PersonalValuacion ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalValuacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalValuacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalValuacion') and type = 'U') 
CREATE TABLE dbo.PersonalValuacion (
	Valuacion	varchar(50) 	NOT NULL,

	CONSTRAINT priPersonalValuacion PRIMARY KEY  CLUSTERED (Valuacion)
)
GO

/****** NivelAcademico ******/
if not exists(select * from SysTabla where SysTabla = 'NivelAcademico')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NivelAcademico','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NivelAcademico') and type = 'U') 
CREATE TABLE dbo.NivelAcademico (
	NivelAcademico	varchar(50) 	NOT NULL,

	CONSTRAINT priNivelAcademico PRIMARY KEY  CLUSTERED (NivelAcademico)
)
GO

/****** PersonalTarjeta ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalTarjeta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalTarjeta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalTarjeta') and type = 'U') 
CREATE TABLE dbo.PersonalTarjeta (
	Tarjeta		varchar(10) 	NOT NULL,
	Personal	varchar(10)	NOT NULL,

	CONSTRAINT priPersonalTarjeta PRIMARY KEY  CLUSTERED (Tarjeta)
)
GO

EXEC spFK 'PersonalTarjeta','Personal','Personal','Personal'
GO

/****** PersonalUltimoPago ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalUltimoPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalUltimoPago','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalUltimoPago') and type = 'U') 
CREATE TABLE dbo.PersonalUltimoPago (
	Personal	varchar(10)	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	Empresa		varchar(5)		NOT NULL	DEFAULT '',

	UltimoPago	datetime	NULL,

	CONSTRAINT priPersonalUltimoPago PRIMARY KEY  CLUSTERED (Personal, Mov, Empresa)
)
GO
EXEC spALTER_TABLE 'PersonalUltimoPago', 'Empresa', 'varchar(5) NOT NULL DEFAULT "" WITH VALUES'
GO
if (select version from version)<=2262
begin
  EXEC("spEliminarPK 'PersonalUltimoPago'")
  EXEC("ALTER TABLE PersonalUltimoPago ADD CONSTRAINT priPersonalUltimoPago PRIMARY KEY  CLUSTERED (Personal, Mov, Empresa)")
end
go

/****** PersonalSuc ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalSuc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalSuc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalSuc') and type = 'U') 
CREATE TABLE dbo.PersonalSuc (
	Personal	varchar(10)	NOT NULL,
	Sucursal	int		NOT NULL,

	CONSTRAINT priPersonalSuc PRIMARY KEY  CLUSTERED (Personal, Sucursal)
)
GO

EXEC spFK 'PersonalSuc','Sucursal','Sucursal','Sucursal'
GO

/****** Acceso Personal ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalAcceso') and type = 'U') 
CREATE TABLE dbo.PersonalAcceso (
	Personal		varchar(10) 	NOT NULL,
	Usuario			varchar(10) 	NOT NULL,

	CONSTRAINT priPersonalAcceso PRIMARY KEY  CLUSTERED (Personal, Usuario)
)
go


/****** CfgPersonal ******/
if not exists(select * from SysTabla where SysTabla = 'CfgPersonal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgPersonal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CfgPersonal') and type = 'U') 
CREATE TABLE dbo.CfgPersonal (
	Configuracion			varchar(50)	NOT NULL,

	Sueldo				varchar(30)	NULL,		-- Dias Periodo/Dias Habiles Promedio/Dias Naturales

	Faltas				varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	RetardosFalta			int		NULL,
	Incapacidades			varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	HorasExtras			varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI

	DescansosLaborados		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	DescansosLaboradosFactor	float		NULL,

	DomingosEnJornada		varchar(30)	NULL,		-- Domingos Periodo/Domingos Promedio
	DomingosLaborados		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	DomingosLaboradosFactor		float		NULL,
	DomingosPrima			float		NULL,

	FestivosLaborados		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	FestivosLaboradosFactor		float		NULL,

	Vales				varchar(30)	NULL, 		-- Siempre/sin Faltas/sin Faltas ni Retardos/Nunca
	ValesPorcentaje			float		NULL,
	ValesBase			varchar(30)	NULL, 		-- Sueldo/Sueldo menos Faltas/Sueldo menos Ausentismo

	PremioAsistencia		varchar(30)	NULL, 		-- Siempre/sin Faltas/sin Faltas ni Retardos/Nunca
	PremioAsistenciaPorcentaje	float		NULL,
	PremioAsistenciaBase		varchar(30)	NULL, 		-- Sueldo/Sueldo menos Faltas/Sueldo menos Ausentismo

	PremioPuntualidad		varchar(30)	NULL, 		-- Siempre/sin Faltas/sin Faltas ni Retardos/Nunca
	PremioPuntualidadPorcentaje	float		NULL,
	PremioPuntualidadBase		varchar(30)	NULL, 		-- Sueldo/Sueldo menos Faltas/Sueldo menos Ausentismo

	VacacionesDisfrutadas		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	VacacionesPagadas		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	VacacionesAniversario		varchar(30)	NULL,		-- No/Dias Periodo/Dias Habiles Promedio/Dias Naturales/SDI
	VacacionesPagoPrima		varchar(30)	NULL,		-- Aniversario/Vacaciones Disfrutadas
	VacacionesPrima			float		NULL,

	DiasAguinaldo			int		NULL,
	
	CONSTRAINT priCfgPersonal PRIMARY KEY  CLUSTERED (Configuracion)
)
GO

-- drop table CfgPersonal

/****** PersonalCfg ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalCfg','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalCfg') and type = 'U') 
CREATE TABLE dbo.PersonalCfg (
	Personal		char(10) 	NOT NULL,

	Infonavit		bit		NULL	DEFAULT 0,
	InfonavitBase		varchar(20)	NULL,
	InfonavitCantidad	float		NULL,
	InfonavitPorcentaje	float		NULL,
	PA1			bit		NULL	DEFAULT 0,
	PA1Base			varchar(20)	NULL,
	PA1Porcentaje		float		NULL,
	PA1Acreedor		varchar(10)	NULL,
	PA2			bit		NULL	DEFAULT 0,
	PA2Base			varchar(20)	NULL,
	PA2Porcentaje		float		NULL,
	PA2Acreedor		varchar(10)	NULL,
	PA3			bit		NULL	DEFAULT 0,
	PA3Base			varchar(20)	NULL,
	PA3Porcentaje		float		NULL,
	PA3Acreedor		varchar(10)	NULL,

	CajaAhorro		bit		NULL	DEFAULT 0,
	CajaAhorroImporte	money		NULL,
	FondoAhorro		bit		NULL	DEFAULT 0,
	FondoAhorroImporte	money		NULL,

	CONSTRAINT priPersonalCfg PRIMARY KEY  CLUSTERED (Personal)
)
GO

/*** PersonalTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.PersonalTipo') and type = 'V') drop view dbo.PersonalTipo
GO
if not exists(select * from SysTabla where SysTabla = 'PersonalTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalTipo') and type = 'U') 
CREATE TABLE dbo.PersonalTipo (
	Tipo		varchar(20)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priPersonalTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** PersonalEntrada ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalEntrada')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalEntrada','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalEntrada') and type = 'U') 
CREATE TABLE dbo.PersonalEntrada (
	Personal		varchar(10) 	NOT NULL,
	Fecha			datetime	NOT NULL,

	Hora			varchar(5)	NULL,

	CONSTRAINT priPersonalEntrada PRIMARY KEY  CLUSTERED (Personal, Fecha)
)
go
EXEC spADD_INDEX 'PersonalEntrada', 'Fecha', 'Fecha'
GO

/****** PersonalEntradaH ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalEntradaH')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalEntradaH','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalEntradaH') and type = 'U') 
CREATE TABLE dbo.PersonalEntradaH (
	Personal		varchar(10) 	NOT NULL,
	Sucursal		int		NULL,

	Domingo			varchar(5)	NULL,
	Lunes			varchar(5)	NULL,
	Martes			varchar(5)	NULL,
	Miercoles		varchar(5)	NULL,
	Jueves			varchar(5)	NULL,
	Viernes			varchar(5)	NULL,
	Sabado			varchar(5)	NULL,
	CONSTRAINT priPersonalEntradaH PRIMARY KEY  CLUSTERED (Personal)
)
go

EXEC spALTER_TABLE 'PersonalEntradaH', 'Sucursal', 'int NULL'
go

EXEC spFK 'PersonalEntradaH','Personal','Personal','Personal'
GO

/****** Personal ******/
if not exists(select * from SysTabla where SysTabla = 'Personal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Personal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Personal') and type = 'U') 
CREATE TABLE dbo.Personal (
	Personal		varchar(10) 	NOT NULL,
	ApellidoPaterno		varchar(30)	NULL,
	ApellidoMaterno		varchar(30)	NULL,
	Nombre			varchar(30)	NULL,
	
	Tipo			varchar(20)	NULL, -- Empleado, Trabajador, Obrero, Accionista, Consejero, Funcionario
	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	Colonia 		varchar(100)  	NULL,
	Delegacion		varchar(100) 	NULL,
	Poblacion 		varchar(100)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	Telefono 		varchar(50)  	NULL,
	eMail			varchar(50) 	NULL,
	eMailAuto		bit		NULL 		DEFAULT 0,
	ZonaEconomica		varchar(30)	NULL,

	Registro		varchar(30)	NULL,
	Registro2		varchar(30)	NULL,
	Registro3		varchar(30)	NULL,
	Registro4		varchar(30)	NULL,

	FormaPago		varchar(50)	NULL,
	CtaDinero		varchar(10)	NULL,
	Afore			varchar(10)	NULL,

	PersonalSucursal 	varchar(50)	NULL,
	PersonalCuenta		varchar(20)	NULL,

	FechaNacimiento		datetime	NULL,
	LugarNacimiento		varchar(50)	NULL,
	Nacionalidad		varchar(30)	NULL,
	Pasaporte		varchar(30)	NULL,
	Cartilla		varchar(30)	NULL,
	Permiso			varchar(30)	NULL,
	NivelAcademico		varchar(50)	NULL,
	Sexo			varchar(10)	NULL,
	EstadoCivil		varchar(20)	NULL,
	Hijos			int		NULL,
	Dependientes		int		NULL,
	Beneficiario		varchar(50)	NULL,
	BeneficiarioNacimiento	datetime	NULL,
	Parentesco		varchar(20)	NULL,
        Porcentaje		float		NULL,
	Beneficiario2		varchar(50)	NULL,
	Beneficiario2Nacimiento	datetime	NULL,
	Parentesco2		varchar(20)	NULL,
        Porcentaje2		float		NULL,
	Beneficiario3		varchar(50)	NULL,
	Beneficiario3Nacimiento	datetime	NULL,
	Parentesco3		varchar(20)	NULL,
        Porcentaje3		float		NULL,
	Beneficiario4		varchar(50)	NULL,
	Beneficiario4Nacimiento	datetime	NULL,
	Parentesco4		varchar(20)	NULL,
        Porcentaje4		float		NULL,
	Beneficiario5		varchar(50)	NULL,
	Beneficiario5Nacimiento	datetime	NULL,
	Parentesco5		varchar(20)	NULL,
        Porcentaje5		float		NULL,
	Beneficiario6		varchar(50)	NULL,
	Beneficiario6Nacimiento	datetime	NULL,
	Parentesco6		varchar(20)	NULL,
        Porcentaje6		float		NULL,
	Beneficiario7		varchar(50)	NULL,
	Beneficiario7Nacimiento	datetime	NULL,
	Parentesco7		varchar(20)	NULL,
        Porcentaje7		float		NULL,
	Beneficiario8		varchar(50)	NULL,
	Beneficiario8Nacimiento	datetime	NULL,
	Parentesco8		varchar(20)	NULL,
        Porcentaje8		float		NULL,

	Valuacion		varchar(50)	NULL,
	Padre			varchar(50)	NULL,
	Madre			varchar(50)	NULL,
	UnidadMedica		int		NULL,
	CentroCostos		varchar(20)	NULL,

	ReportaA		varchar(10)	NULL,
	
	AspiraSueldo		varchar(50)	NULL,
	AspiraCategoria		varchar(50)	NULL,
	AspiraDepartamento	varchar(50)	NULL,
	AspiraGrupo		varchar(50)	NULL,
	AspiraPuesto		varchar(50)	NULL,
	AspiraFecha		datetime	NULL,

	Categoria		varchar(50)	NULL,
	Departamento		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Puesto			varchar(50)	NULL,
	TipoContrato		varchar(50)	NULL,
	PeriodoTipo		varchar(20)	NULL,
	Jornada			varchar(20)	NULL,
	TipoSueldo		varchar(10)	NULL,
	Moneda			varchar(10)	NULL,
	DiasPeriodo		varchar(20)	NULL,	-- Dias Periodo / Dias Naturales / Dias Jornada 

	SueldoDiario		money		NULL,
	SDI			money		NULL,
	SDIBimestral		money		NULL,
	SDIAnterior		money		NULL,
	SueldoDiarioComplemento	money		NULL,

	FechaAlta		datetime	NULL,
	FechaBaja		datetime	NULL,
	ConceptoBaja		varchar(50)	NULL,
	FechaAntiguedad		datetime	NULL,
	UltimaModificacion	datetime	NULL,
	UltimoPago		datetime	NULL,
	VencimientoContrato	datetime	NULL,

	Estatus			varchar(15)	NOT NULL,
	UltimoCambio		datetime	NULL,

	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,

	EstaPresente		bit		NOT NULL DEFAULT 0,

	TieneMovimientos	bit		NULL	 DEFAULT 0,
	SucursalTrabajo		int		NOT NULL DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,
	MinimoProfesional	int		NULL,
	Sindicato		varchar(50)	NULL,
	Vehiculo 		varchar(10)  	NULL,

	TablaCobranza		varchar(50)	NULL,
	TablaCobranzaBono	varchar(50)	NULL,
	TablaCobranzaCascada	varchar(50)	NULL,
	TablaCobranzaBonoCascada varchar(50)	NULL,
	TablaVentaCascada	varchar(50)	NULL,

	UEN			int		NULL,
	Actividad		varchar(100)	NULL,

	Area			varchar(50)	NULL,
	Fuente			varchar(50)	NULL,
	Reclutador		varchar(10)	NULL,
	RecomendadoPor		varchar(10)	NULL,

	Cuenta			varchar(20)	NULL,
	CuentaRetencion		varchar(20)	NULL,
	MovNomina		varchar(20)	NULL,
	Contrasena		varchar(100)	NULL,
	Configuracion		varchar(50)	NULL,

	Referencia		varchar(50)	NULL,
	ReferenciaDireccion	varchar(50)	NULL,
	ReferenciaTelefono	varchar(20)	NULL,
	Referencia2		varchar(50)	NULL,
	Referencia2Direccion	varchar(50)	NULL,
	Referencia2Telefono	varchar(20)	NULL,
	Referencia3		varchar(50)	NULL,
	Referencia3Direccion	varchar(50)	NULL,
	Referencia3Telefono	varchar(20)	NULL,

	Licencia		varchar(20)	NULL,
	LicenciaVencimiento	datetime	NULL,
	Cliente			varchar(10)	NULL,
	Incremento		float		NULL,
	EsSocio			bit		NULL	DEFAULT 0,
	IndemnizacionPct	float		NULL,	
	Proyecto		varchar(50)	NULL,
	Plaza			varchar(20)	NULL,
	Empresa			varchar(5)	NULL,
	SueldoMensual		money 		NULL,
	ISRFijoPeriodo		money  		NULL,
	RataHora		money  		NULL,
	DeclaraRenta		bit 		NULL DEFAULT 0,
	EsRecurso		bit		NULL	DEFAULT 0,
	EsAgente		bit		NULL	DEFAULT 0,
	EsUsuarioWeb		bit		NULL	DEFAULT 0,

	EntreCalles		varchar(100) 	NULL,
	Plano			varchar(15)     NULL,
	Observaciones		varchar(100)    NULL,
	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
	MapaUbicacion       varchar(100) NULL,
	ActividadMedicion	varchar(50)	NULL,
	SueldoDiarioAsimilable	money		NULL,

	ContactoTipo		varchar(20) NULL DEFAULT 'Personal',
 --REQ12534 Factory  	
	ReferenciaIntelisisService varchar(50)     NULL,
	
	

	CONSTRAINT priPersonal PRIMARY KEY CLUSTERED (Personal)
)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre          ON dbo.Personal (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'ApellidoPaterno' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ApellidoPaterno ON dbo.Personal (ApellidoPaterno)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria       ON dbo.Personal (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Departamento' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Departamento    ON dbo.Personal (Departamento)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo	       ON dbo.Personal (Grupo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Puesto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Puesto	       ON dbo.Personal (Puesto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Registro' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Registro	       ON dbo.Personal (Registro)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Registro2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Registro2       ON dbo.Personal (Registro2)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Personal' AND sysindexes.name = 'Registro3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Registro3       ON dbo.Personal (Registro3)
go
if exists (select * from sysobjects where id = object_id('dbo.tgPersonalABC') and sysstat & 0xf = 8) drop trigger dbo.tgPersonalABC
GO
if not exists(select * from syscampo where tabla = 'Personal' and Campo = 'Registro4')
  ALTER TABLE Personal ADD Registro4 varchar(30) NULL
GO
if not exists(select * from syscampo where tabla = 'Personal' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Personal ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Personal SET TieneMovimientos = 1")
END
GO
EXEC spRENAME_COLUMN 'Personal', 'Sucursal', 'SucursalTrabajo'
GO
EXEC spALTER_TABLE 'Personal', 'SucursalTrabajo', 'int	NOT NULL DEFAULT 0 WITH VALUES'
GO
EXEC spRENAME_COLUMN 'Personal', 'SueldoFijo', 'SueldoDiario'
EXEC spRENAME_COLUMN 'Personal', 'SueldoVariable', 'SDI'
EXEC spALTER_TABLE 'Personal', 'SDIBimestral', 'money NULL'
EXEC spALTER_TABLE 'Personal', 'Dependientes', 'int NULL'
EXEC spALTER_TABLE 'Personal', 'LugarNacimiento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Personal', 'AspiraSueldo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'AspiraFecha', 'datetime	NULL'
EXEC spALTER_TABLE 'Personal', 'ConceptoBaja', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Padre', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Madre','varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'UnidadMedica', 'int NULL'
EXEC spALTER_TABLE 'Personal', 'CentroCostos', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'MinimoProfesional', 'int NULL'
EXEC spALTER_TABLE 'Personal', 'Sindicato', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'SDIAnterior', 'money NULL'
EXEC spALTER_TABLE 'Personal', 'Vehiculo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Personal', 'TablaCobranza', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'TablaCobranzaBono', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'TablaCobranzaCascada', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'TablaCobranzaBonoCascada', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'TablaVentaCascada', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje2', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje3', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario4', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco4', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje4', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario5', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco5', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje5', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario6', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco6', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje6', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario7', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco7', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje7', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario8', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Parentesco8', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Porcentaje8', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Personal', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Personal', 'Area', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Fuente', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Reclutador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Personal', 'RecomendadoPor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Personal', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'CuentaRetencion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'MovNomina', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Contrasena', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Personal', 'Configuracion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'BeneficiarioNacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario2Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario3Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario4Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario5Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario6Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario7Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Beneficiario8Nacimiento', 'datetime NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'ReferenciaDireccion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'ReferenciaTelefono', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia2Direccion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia2Telefono', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia3Direccion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'Referencia3Telefono', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'Licencia', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Personal', 'LicenciaVencimiento', 'datetime	NULL'
EXEC spALTER_TABLE 'Personal', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Personal', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'Proyecto', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Personal', 'Plaza', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'ActividadMedicion','varchar(50) NULL'
EXEC spALTER_TABLE 'Personal', 'SueldoDiarioAsimilable','money NULL'
EXEC spALTER_TABLE 'Personal', 'NominaProrrateo','varchar(50) NULL'
GO

if (select version from version) <= 1258
  UPDATE personal SET SDI = NULL
GO
if (select version from version) <= 2230
  UPDATE personal set sueldodiario = round(sueldodiario, 2), SDI = round(SDI, 2)
GO
if (select version from version) <= 2331
  ALTER TABLE Personal ALTER COLUMN Actividad varchar(100) NULL
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Personal ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Personal ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Personal ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
EXEC spALTER_TABLE 'Personal', 'Incremento', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'EsSocio', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version) <= 2791
  UPDATE Personal set EsSocio = 1 WHERE Tipo = 'Asociado'
GO
EXEC spALTER_TABLE 'Personal', 'DiasPeriodo', 'varchar(20) NULL'
GO
if (select version from version) <= 2796
  UPDATE Personal SET DiasPeriodo = CASE WHEN NULLIF(MinimoProfesional, 0) IS NULL THEN 'Dias Periodo' ELSE 'Dias Naturales' END
GO
EXEC spALTER_TABLE 'Personal', 'IndemnizacionPct', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'SituacionUsuario', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Personal', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Personal', 'SueldoDiarioComplemento', 'money NULL'
EXEC spALTER_TABLE 'Personal', 'Empresa', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Personal', 'SueldoMensual',  'money NULL'
EXEC spALTER_TABLE 'Personal', 'ISRFijoPeriodo', 'money  NULL'
EXEC spALTER_TABLE 'Personal', 'RataHora',       'money  NULL'
EXEC spALTER_TABLE 'Personal', 'DeclaraRenta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Personal', 'EsRecurso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'EsAgente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'EsUsuarioWeb', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'FechaInicioContrato', 'datetime null'
EXEC spALTER_TABLE 'Personal', 'DuracionContrato', 'INT null'
EXEC spALTER_TABLE 'Personal', 'Confidencial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Personal', 'EntreCalles', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Personal', 'Plano', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Personal', 'Observaciones', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Personal', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Personal', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'Personal', 'MapaUbicacion', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'Personal', 'ContactoTipo', 'varchar(20) NULL DEFAULT "Personal" WITH VALUES'
GO

 --REQ12534 Factory  
Exec spAlter_Table 'Personal', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO
EXEC spALTER_TABLE 'Personal', 'SubContratacionRfcLabora', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Personal', 'SubContratacionPorcentajeTiem', 'float NULL' 

EXEC spALTER_TABLE 'Personal', 'SubContratacionRfcLabora2', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Personal', 'SubContratacionPorcentajeTiem2', 'float NULL' 

EXEC spALTER_TABLE 'Personal', 'SubContratacionRfcLabora3', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Personal', 'SubContratacionPorcentajeTiem3', 'float NULL' 
GO

EXEC spFK 'Personal','Jornada','Jornada','Jornada'
EXEC spFK 'Personal','PeriodoTipo','PeriodoTipo','PeriodoTipo'
EXEC spFK 'Personal','ZonaEconomica','ZonaEconomica','Zona'
EXEC spFK 'Personal','Afore','Prov','Proveedor'
EXEC spFK 'Personal','FormaPago','FormaPago','FormaPago'
EXEC spFK 'Personal','SucursalTrabajo','Sucursal','Sucursal'
EXEC spFK 'Personal','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'Personal','MinimoProfesional','MinimosProfesionales','Numero'
EXEC spFK 'Personal','Vehiculo','Vehiculo','Vehiculo'
EXEC spFK 'Personal','Puesto','Puesto','Puesto'
EXEC spFK 'Personal','Departamento','Departamento','Departamento'
EXEC spFK 'Personal','Categoria','PersonalCat','Categoria'
EXEC spFK 'Personal','Grupo','PersonalGrupo','Grupo'
EXEC spFK 'Personal','UEN','UEN','UEN'
EXEC spFK 'Personal','Cuenta','Cta','Cuenta'
EXEC spFK 'Personal','Configuracion','CfgPersonal','Configuracion'
EXEC spFK 'Personal','Cliente','Cte','Cliente'
EXEC spFK 'Personal','Plaza','Plaza','Plaza'
GO

--Integración MES
EXEC spALTER_TABLE 'Personal', 'MES', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

CREATE TRIGGER tgPersonalABC ON Personal
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @PersonalDup	varchar(10),
    @PersonalI 		varchar(10),	
    @PersonalD 		varchar(10),
    @NombreNuevo	varchar(100),
    @NombreAnterior	varchar(100),
    @RFCNuevo		varchar(20),
    @RFCAnterior	varchar(20),
    @CURPNuevo		varchar(30),
    @CURPAnterior	varchar(30),
    @Mensaje   		varchar(255),
    @Registro  		varchar(30),
    @Registro2 		varchar(50),
    @Registro3 		varchar(50),
    @RegistroDup	varchar(50),
    @SDINuevo		money,
    @SDIAnterior	money,
    @EmpresaNuevo	varchar(5),
    @EmpresaAnterior	varchar(5),
    @PaisNuevo		varchar(50),
    @PaisAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PersonalI = Personal, @NombreNuevo    = ISNULL(RTRIM(ApellidoPaterno), '')+' '+ISNULL(RTRIM(ApellidoMaterno), '')+' '+ISNULL(RTRIM(Nombre), ''), @RFCNuevo = Registro2,    @CURPNuevo = Registro,    @SDINuevo = SDI,    @Registro = NULLIF(NULLIF(RTRIM(Registro), ''), '0'), @Registro2 = NULLIF(NULLIF(RTRIM(Registro2), ''), '0'), @Registro3 = NULLIF(NULLIF(RTRIM(Registro3), ''), '0'), @EmpresaNuevo = Empresa  FROM Inserted
  SELECT @PersonalD = Personal, @NombreAnterior = ISNULL(RTRIM(ApellidoPaterno), '')+' '+ISNULL(RTRIM(ApellidoMaterno), '')+' '+ISNULL(RTRIM(Nombre), ''), @RFCAnterior = Registro2, @CURPAnterior = Registro, @SDIAnterior = SDI, @EmpresaAnterior = Empresa   FROM Deleted

  /*IF @NombreNuevo <> @NombreAnterior OR @RFCNuevo <> @RFCAnterior OR @CURPNuevo <> @CURPAnterior*/

  SELECT @PaisNuevo    = Pais FROM Empresa WHERE Empresa = @EmpresaNuevo
  SELECT @PaisAnterior = Pais FROM Empresa WHERE Empresa = @EmpresaAnterior

IF @PaisNuevo = 'México' SELECT @PaisNuevo ='Mexico'
IF @PaisAnterior = 'México' SELECT @PaisAnterior ='Mexico'
IF EXISTS (SELECT Pais FROM PersonalPropPais WHERE Pais = 'México')
    UPDATE PersonalPropPais SET Pais = 'Mexico'
IF EXISTS (SELECT Pais FROM Empresa WHERE Pais = 'México')
    UPDATE Empresa SET Pais = 'Mexico'
 
IF EXISTS (SELECT Pais FROM Sucursal WHERE Pais = 'México')
    UPDATE Sucursal SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Personal WHERE Pais = 'México')
   UPDATE Personal SET Pais = 'Mexico'


  IF @SDINuevo<>@SDIAnterior AND @SDIAnterior IS NOT NULL AND @PersonalI IS NOT NULL
    UPDATE Personal SET SDIAnterior = @SDIAnterior WHERE Personal = @PersonalI

  IF @PersonalI IS NOT NULL AND exists(select * from empresa where Empresa=@EmpresaNuevo AND Pais='Mexico')
  BEGIN
    SELECT @PersonalDup = NULL
    IF @Registro  IS NOT NULL
    BEGIN
      SELECT @PersonalDup = MIN(Personal) FROM Personal WHERE Registro  = @Registro  AND Personal <> @PersonalI 
      IF @PersonalDup IS NOT NULL SELECT @RegistroDup = 'CURP - '+@Registro
    END
    IF @Registro2 IS NOT NULL 
    BEGIN
      SELECT @PersonalDup = MIN(Personal) FROM Personal WHERE Registro2 = @Registro2 AND Personal <> @PersonalI 
      IF @PersonalDup IS NOT NULL SELECT @RegistroDup = 'RFC - '+@Registro2
    END
    IF @Registro3 IS NOT NULL 
    BEGIN
      SELECT @PersonalDup = MIN(Personal) FROM Personal WHERE Registro3 = @Registro3 AND Personal <> @PersonalI 
      IF @PersonalDup IS NOT NULL SELECT @RegistroDup = 'IMSS - '+@Registro3
    END

    IF @PersonalDup IS NOT NULL 
    BEGIN
      SELECT @Mensaje = 'Error al Actualizar a "'+@PersonalI+'", la clave del "'+@RegistroDup+'", ya Existe en la Persona "'+LTRIM(RTRIM(@PersonalDup))+ '".' 
      RAISERROR (@Mensaje,16,-1) 
    END
  END

  IF @PersonalI = @PersonalD AND @PaisNuevo <> @PaisAnterior
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'PER' AND Cuenta = @PersonalI
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta) SELECT p.Propiedad, 'PER', @PersonalI FROM PersonalProp p JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisNuevo WHERE p.NivelPersonal = 1
  END

  IF @PersonalI = @PersonalD RETURN

  -- Si Inserto
  IF @PersonalD IS NULL
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'PER' AND Cuenta = @PersonalI
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) SELECT p.Propiedad, 'PER', @PersonalI, p.PorOmision FROM PersonalProp p JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisNuevo WHERE p.NivelPersonal = 1
    INSERT PersonalCfg (Personal) VALUES (@PersonalI)
  END ELSE
  
  -- Si Elimino 
  IF @PersonalI IS NULL 
  BEGIN
    DELETE PersonalPropValor  WHERE Rama = 'PER' AND Cuenta = @PersonalD
    DELETE PersonalTarjeta    WHERE Personal = @PersonalD
    DELETE PersonalUltimoPago WHERE Personal = @PersonalD
    DELETE PersonalSuc 	      WHERE Personal = @PersonalD
    DELETE PersonalAcceso     WHERE Personal = @PersonalD
    DELETE PersonalCfg        WHERE Personal = @PersonalD
	DELETE CtoCampoExtra      WHERE Tipo     = 'Personal' AND Clave = @PersonalD
	DELETE FormaExtraValor    WHERE Aplica   = 'Personal' AND AplicaClave = @PersonalD
	DELETE FormaExtraD        WHERE Aplica   = 'Personal' AND AplicaClave = @PersonalD
  END ELSE

  -- Si Modifico 
  IF @PersonalI <> @PersonalD AND @PersonalI IS NOT NULL 
  BEGIN
    UPDATE PersonalPropValor  SET Cuenta   = @PersonalI WHERE Rama = 'PER' AND Cuenta = @PersonalD
    UPDATE PersonalTarjeta    SET Personal = @PersonalI WHERE Personal = @PersonalD
    UPDATE PersonalUltimoPago SET Personal = @PersonalI WHERE Personal = @PersonalD
    UPDATE PersonalSuc 	      SET Personal = @PersonalI WHERE Personal = @PersonalD
    UPDATE PersonalAcceso     SET Personal = @PersonalI WHERE Personal = @PersonalD
    UPDATE PersonalCfg        SET Personal = @PersonalI WHERE Personal = @PersonalD
	UPDATE CtoCampoExtra	  SET Clave   = @PersonalI WHERE Clave   = @PersonalD AND Tipo='Personal'
	UPDATE FormaExtraValor	  SET AplicaClave   = @PersonalI WHERE AplicaClave   = @PersonalD AND Aplica='Personal'
	UPDATE FormaExtraD	      SET AplicaClave   = @PersonalI WHERE AplicaClave   = @PersonalD AND Aplica='Personal'
  END ELSE RETURN
END
GO



--REQ12534 Factory 
if exists (select * from sysobjects where id = object_id('dbo.tgInforPersonalABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforPersonalABC
GO
CREATE TRIGGER tgInforPersonalABC ON Personal
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Personal   							varchar (10),
   @Estatus							    varchar (10),
   @Datos								varchar (max),
   @Ok									int,
   @OkRef								varchar(255),
   @Id									int,
   @Cinserted		                	int,
   @Cdeleted			                int,
   @Empresa								varchar(20),
   @ReferenciaIntelisisService			varchar(50),
   @Personal2                           varchar (10), 
   @Personal3                           varchar (10), 
   @ApellidoPaterno                     varchar (30),
   @ApellidoPaterno2                    varchar (30),
   @ApellidoMaterno                     varchar (30),
   @ApellidoMaterno2                    varchar (30),
   @Nombre                              varchar (30), 
   @Nombre2                             varchar (30), 
   @Direccion                           varchar (100), 
   @Direccion2                          varchar (100), 
   @Poblacion                           varchar (100),
   @Poblacion2                          varchar (100),
   @CodigoPostal                        varchar (15), 
   @CodigoPostal2                       varchar (15), 
   @Telefono                            varchar (50), 
   @Telefono2                           varchar (50), 
   @LugarNacimiento                     varchar (50), 
   @LugarNacimiento2                    varchar (50), 
   @EstadoCivil                         varchar (20),
   @EstadoCivil2                        varchar (20),
   @TipoContrato                        varchar (50),  
   @TipoContrato2                       varchar (50),  
   @Estatus2                             varchar (15) ,  
   @Estatus3                            varchar (15)   
    

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Personal2= Personal, @ApellidoPaterno = ApellidoPaterno ,@ApellidoMaterno = ApellidoMaterno,@Nombre = Nombre, @Direccion = Direccion, @Poblacion = Poblacion,@CodigoPostal=CodigoPostal, @Telefono=Telefono, @LugarNacimiento = LugarNacimiento, @EstadoCivil= EstadoCivil,@TipoContrato = TipoContrato,  @Estatus2= Estatus FROM DELETED
  SELECT @Personal3= Personal, @ApellidoPaterno2 = ApellidoPaterno ,@ApellidoMaterno2 = ApellidoMaterno,@Nombre2 = Nombre, @Direccion2 = Direccion, @Poblacion2 = Poblacion,@CodigoPostal2=CodigoPostal, @Telefono2=Telefono, @LugarNacimiento2 = LugarNacimiento, @EstadoCivil2= EstadoCivil,@TipoContrato2 = TipoContrato,  @Estatus3= Estatus FROM INSERTED
 
 
  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
  IF @ProdInterfazINFOR = 1
  BEGIN
    IF @Personal2 <> @Personal3 OR @ApellidoPaterno <> @ApellidoPaterno2 OR @ApellidoMaterno <> @ApellidoMaterno2 OR @Nombre <> @Nombre2 OR @Direccion <> @Direccion2 OR @Poblacion <> @Poblacion OR @CodigoPostal <> @CodigoPostal2 OR  @Telefono <> @Telefono2 OR  @LugarNacimiento <> @LugarNacimiento2 OR  @EstadoCivil <> @EstadoCivil2 OR @TipoContrato <> @TipoContrato2 OR  @Estatus2 <> @Estatus3
    BEGIN
      IF @Cinserted <> 0           AND @Cdeleted = 0 
      BEGIN
        SET @Estatus = 'ALTA' 
      END
      IF @Cinserted <> 0           AND @Cdeleted<> 0 
      BEGIN
        SET @Estatus = 'CAMBIO'
      END
      IF @Cinserted = 0           AND @Cdeleted <> 0 
      BEGIN 
        SET @Estatus = 'BAJA'
      END
      IF  @Estatus IN( 'ALTA','CAMBIO')
      BEGIN
        DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
         SELECT Personal,ReferenciaIntelisisService
           FROM Inserted
      END
      ELSE
      IF @Estatus = 'BAJA'
      BEGIN
        DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
         SELECT Personal,ReferenciaIntelisisService
           FROM Deleted     
      END
      IF @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
      BEGIN                 
        OPEN crActualizar
        FETCH NEXT FROM crActualizar INTO @Personal ,@ReferenciaIntelisisService
        WHILE @@FETCH_STATUS = 0 
        BEGIN
          EXEC spInforGenerarSolicitudPersonal @Personal,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
          FETCH NEXT FROM crActualizar INTO @Personal,@ReferenciaIntelisisService
        END
        CLOSE crActualizar
        DEALLOCATE crActualizar
      END
    END 
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgPersonalPropABC') and sysstat & 0xf = 8) drop trigger dbo.tgPersonalPropABC
GO
CREATE TRIGGER tgPersonalPropABC ON PersonalProp
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @PropiedadI  	varchar(50),
    @NivelEmpresaI	bit,
    @NivelSucursalI	bit,
    @NivelPuestoI	bit,
    @NivelCategoriaI	bit,
    @NivelPersonalI	bit,
    @PropiedadD		varchar(50),
    @porOmision		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PropiedadI = Propiedad, 
         @NivelEmpresaI = ISNULL(NivelEmpresa, 0), 
	 @NivelSucursalI = ISNULL(NivelSucursal, 0), 
	 @NivelPuestoI = ISNULL(NivelPuesto, 0), 
	 @NivelCategoriaI = ISNULL(NivelCategoria, 0), 
	 @NivelPersonalI = ISNULL(NivelPersonal, 0), 
	 @porOmision = NULLIF(RTRIM(porOmision), '') FROM Inserted
  SELECT @PropiedadD = Propiedad FROM Deleted

IF EXISTS (SELECT Pais FROM PersonalPropPais WHERE Pais = 'México')
    UPDATE PersonalPropPais SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Empresa WHERE Pais = 'México')
    UPDATE Empresa SET Pais = 'Mexico'
 
IF EXISTS (SELECT Pais FROM Sucursal WHERE Pais = 'México')
    UPDATE Sucursal SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Personal WHERE Pais = 'México')
   UPDATE Personal SET Pais = 'Mexico'

  -- Si Elimino
  IF @PropiedadI IS NULL  
  BEGIN
    DELETE PersonalPropValor WHERE Propiedad = @PropiedadD
    DELETE PersonalPropPais  WHERE Propiedad = @PropiedadD
  END ELSE BEGIN
    -- Si Modifico
    IF @PropiedadD IS NULL 
      INSERT PersonalPropPais (Propiedad, Pais) VALUES (@PropiedadI, 'Mexico')
    ELSE
      UPDATE PersonalPropPais SET Propiedad = @PropiedadI WHERE Propiedad = @PropiedadD

    IF @PropiedadD IS NOT NULL AND @PropiedadI <> @PropiedadD
      UPDATE PersonalPropValor SET Propiedad = @PropiedadI WHERE Propiedad = @PropiedadD

    IF @NivelEmpresaI = 0 
      DELETE PersonalPropValor WHERE Propiedad = @PropiedadI AND Rama = 'EMP'
    ELSE
      INSERT PersonalPropValor (
             Propiedad, Valor, Rama, Cuenta) 
      SELECT @PropiedadI, @porOmision, 'EMP', e.Empresa 
        FROM Empresa e
        JOIN PersonalPropPais pp ON pp.Propiedad = @PropiedadI AND pp.Pais = e.Pais
       WHERE e.Empresa NOT IN (SELECT v.Cuenta FROM PersonalPropValor v WHERE v.Rama = 'EMP' AND v.Propiedad = @PropiedadI)

    IF @NivelSucursalI = 0 
      DELETE PersonalPropValor WHERE Propiedad = @PropiedadI AND Rama = 'SUC'
    ELSE
      INSERT PersonalPropValor (Propiedad, Valor, Rama, Cuenta) 
      SELECT @PropiedadI, @porOmision, 'SUC', s.Sucursal 
        FROM Sucursal s
        JOIN PersonalPropPais pp ON pp.Propiedad = @PropiedadI AND pp.Pais = s.Pais
       WHERE s.Sucursal NOT IN (SELECT CONVERT(int, v.Cuenta) FROM PersonalPropValor v WHERE v.Rama = 'SUC' AND v.Propiedad = @PropiedadI)

    IF @NivelPuestoI = 0 
      DELETE PersonalPropValor WHERE Propiedad = @PropiedadI AND Rama = 'PUE'
    ELSE
      INSERT PersonalPropValor (Propiedad, Valor, Rama, Cuenta) SELECT @PropiedadI, @porOmision, 'PUE', Puesto FROM Puesto WHERE Puesto NOT IN (SELECT Cuenta FROM PersonalPropValor WHERE Rama = 'PUE' AND Propiedad = @PropiedadI)

    IF @NivelCategoriaI = 0 
      DELETE PersonalPropValor WHERE Propiedad = @PropiedadI AND Rama = 'CAT'
    ELSE
      INSERT PersonalPropValor (Propiedad, Valor, Rama, Cuenta) SELECT @PropiedadI, @porOmision, 'CAT', Categoria FROM PersonalCat WHERE Categoria NOT IN (SELECT Cuenta FROM PersonalPropValor WHERE Rama = 'CAT' AND Propiedad = @PropiedadI)

    IF @NivelPersonalI = 0 
      DELETE PersonalPropValor WHERE Propiedad = @PropiedadI AND Rama = 'PER'
    ELSE
      INSERT PersonalPropValor (
             Propiedad,  Valor,        Rama,  Cuenta) 
      SELECT @PropiedadI, @porOmision, 'PER', p.Personal 
        FROM Personal p
        JOIN Empresa e ON e.Empresa = p.Empresa
        JOIN PersonalPropPais pp ON pp.Propiedad = @PropiedadI AND pp.Pais = e.Pais
       WHERE p.Personal NOT IN (SELECT v.Cuenta FROM PersonalPropValor v WHERE v.Rama = 'PER' AND v.Propiedad = @PropiedadI)
  END
END
GO


IF NOT EXISTS(SELECT * FROM PersonalPropPais)
  INSERT PersonalPropPais (Propiedad, Pais) SELECT Propiedad, 'Mexico' FROM PersonalProp
GO

/****** tgPersonalPerfil ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'dbo.tgPersonalPerfil'))
DROP TRIGGER dbo.tgPersonalPerfil
GO

CREATE TRIGGER tgPersonalPerfil ON dbo.Personal
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS 
BEGIN
	DECLARE
	@ClaveN		varchar(10),
	@ClaveA		varchar(10),
	@EsAgente		bit,
	@EsRecurso		bit,
	@EsWeb			bit,
    @Mensaje		varchar(255)

    IF dbo.fnEstaSincronizando() = 1 RETURN
  
	IF UPDATE(Personal) OR UPDATE(Nombre) OR UPDATE(Direccion) OR UPDATE(Delegacion) OR UPDATE(Colonia) 
	OR UPDATE(ApellidoPaterno) OR UPDATE(ApellidoMaterno) 
	OR UPDATE(Poblacion) OR UPDATE(Estado) OR UPDATE(Pais) OR UPDATE(ZonaEconomica) OR UPDATE(CodigoPostal) 
	OR UPDATE(Telefono) OR UPDATE(EsRecurso) OR UPDATE(EsAgente) OR UPDATE(eMail) OR UPDATE(EsUsuarioWeb)

	BEGIN
		SELECT @ClaveN = Personal, @EsRecurso = EsRecurso, @EsAgente = EsAgente, @EsWeb = EsUsuarioWeb FROM Inserted
		SELECT @ClaveA = Personal FROM Deleted

		IF @ClaveN IS NULL
		BEGIN
			SELECT @EsRecurso = EsRecurso, @EsAgente = EsAgente FROM Deleted
			IF @EsRecurso = 1 DELETE Recurso WHERE Recurso = @ClaveA
			IF @EsAgente = 1 DELETE Agente WHERE Agente = @ClaveA
			IF @EsWeb = 1 DELETE WebUsuario WHERE UsuarioWeb = @ClaveA
		END 
		ELSE
		BEGIN   
			IF @EsAgente = 1
			BEGIN
--JGD 26Abril2011 Ticket 4443. Si ya existe un Agente con la misma Clave del Empleado, manda Mensaje de Error y no efectua el cambio
                IF EXISTS (SELECT * FROM Agente WHERE Agente = @ClaveN)
                BEGIN
                    SELECT @Mensaje = 'El Personal Indicado: ' + @ClaveN + ' ya Esta Disponible como un Agente'
                    RAISERROR(@Mensaje, 16, -1)
                    RETURN
                END
/*
JGD 26Abril2011 Ticket 4443. Se comentan estas lineas, ya que no es correcto el Susutituir la información de un Agente
				UPDATE Agente
				SET Nombre = i.Nombre + ' ' + i.ApellidoPaterno + ' ' + i.ApellidoMaterno, 
				Direccion = i.Direccion, Colonia = i.Colonia, Poblacion = i.Poblacion, 
				Estado = i.Estado, Pais = i.Pais, Zona = i.ZonaEconomica, CodigoPostal = i.CodigoPostal, 
				Telefonos = i.Telefono, email = i.eMail
				FROM Agente a, Inserted i
				WHERE a.Agente = @ClaveN

				IF @@ROWCOUNT = 0 
*/
				INSERT Agente (Agente, Nombre, BeneficiarioNombre, Direccion, Colonia, Poblacion, Estado, Pais, 
				Zona, CodigoPostal, Telefonos, Tipo, Estatus, Alta, eMail)
				SELECT Personal, Nombre + ' ' + ApellidoPaterno + ' ' + ApellidoMaterno, Nombre, Direccion, 
				Colonia, Poblacion, Estado, Pais, ZonaEconomica, 
				CodigoPostal, Telefono, 'Agente', 'ALTA', GETDATE(), eMail FROM Inserted
			END
/*
JGD 26Abril2011 Ticket 4443. Se comentan estas lineas, ya que no es correcto el Eliminar la información de un Agente
			ELSE
			BEGIN
				DELETE FROM Agente 
				WHERE Agente = @ClaveN
			END
*/

			IF @EsRecurso = 1
			BEGIN
				UPDATE Recurso
				SET Nombre = i.Nombre + ' ' + i.ApellidoPaterno + ' ' + i.ApellidoMaterno, 
				Personal = i.Personal, email= i.eMail
				FROM Recurso r, Inserted i
				WHERE r.Recurso = @ClaveN

				IF @@ROWCOUNT = 0 
				INSERT Recurso (Recurso, Nombre, eMail, Estatus, Personal)
				SELECT Personal, Nombre + ' ' + ApellidoPaterno + ' ' + ApellidoMaterno, eMail, 
				'ALTA', Personal 
				FROM Inserted
			END
			ELSE
			BEGIN
				DELETE FROM Recurso 
				WHERE Recurso = @ClaveN
			END

			IF @EsWeb = 1
			BEGIN
				UPDATE WebUsuario
				SET Nombre = i.Nombre + ' ' + i.ApellidoPaterno + ' ' + i.ApellidoMaterno, 
				email = i.eMail
				FROM WebUsuario w, Inserted i
				WHERE w.UsuarioWeb = @ClaveN

				IF @@ROWCOUNT = 0 
				INSERT WebUsuario (UsuarioWeb, Nombre, eMail, Contrasena, Estatus, Empresa, Sucursal, Personal, 
				Agente, Recurso, UEN)
				SELECT Personal, Nombre + ' ' + ApellidoPaterno + ' ' + ApellidoMaterno, eMail, 'iportal', 
				'ALTA', Empresa, SucursalTrabajo, Personal, Personal, Personal, UEN FROM Inserted
			END
			ELSE
			BEGIN
				DELETE FROM WebUsuario 
				WHERE UsuarioWeb = @ClaveN
			END
		END
	END
END
GO

EXEC spReplicaTema 'Personal', 'Personal',		'Personal', @Principal = 1
EXEC spReplicaTema 'Personal', 'PersonalTarjeta',	'Personal'
EXEC spReplicaTema 'Personal', 'PersonalUltimoPago',	'Personal'
EXEC spReplicaTema 'Personal', 'PersonalSuc',		'Personal'
EXEC spReplicaTema 'Personal', 'PersonalAcceso',	'Personal'
EXEC spReplicaTema 'Personal', 'PersonalCfg',		'Personal'
EXEC spReplicaTema 'Personal', 'PersonalPropValor',	'Cuenta', 'Rama', '"PER"'
GO

/*******************************************************************************************/
/*                                         AGENTES                                         */
/*******************************************************************************************/

/****** Categorias de Agentes  ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteCat')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteCat') and type = 'U') 
CREATE TABLE dbo.AgenteCat (
	Categoria 		varchar(50) 	NOT NULL,
	CategoriaMaestra	varchar(50)	NULL,
	Icono			int	  	NULL,


	CONSTRAINT priAgenteCat PRIMARY KEY CLUSTERED (Categoria)
)

--Integración CRM
EXEC spAlter_Table 'agentecat', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'agentecat', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_agentecat', 'TR') IS NOT NULL DROP TRIGGER tr_agentecat 
GO									
/*CREATE TRIGGER tr_agentecat ON agentecat 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update agentecat  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Categoria= agentecat.Categoria
	END
END
GO*/

/****** Grupos ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteGrupo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteGrupo') and type = 'U') 
CREATE TABLE dbo.AgenteGrupo (
	Grupo	 		varchar(50) 	NOT NULL,

	CONSTRAINT priAgenteGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

--Integración CRM
EXEC spAlter_Table 'agenteGrupo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'agenteGrupo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_agentegrupo', 'TR') IS NOT NULL  DROP TRIGGER tr_agentegrupo
GO									
/*CREATE TRIGGER tr_agentegrupo ON agentegrupo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update agentegrupo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Grupo= agentegrupo.Grupo
	END
END
GO*/

/****** Familias ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteFam')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteFam') and type = 'U') 
CREATE TABLE dbo.AgenteFam (
	Familia	 		varchar(50) 	NOT NULL,

	CONSTRAINT priAgenteFam PRIMARY KEY CLUSTERED (Familia)
)
GO

--Integración CRM
EXEC spAlter_Table 'agenteFam', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'agenteFam', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_agentefam', 'TR') IS NOT NULL DROP TRIGGER tr_agentefam 
GO									
/*CREATE TRIGGER tr_agentefam ON agentefam 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update agentefam  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Familia= agentefam.Familia
	END
END
GO*/

/****** Agentes ******/
if not exists(select * from SysTabla where SysTabla = 'Agente')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Agente','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Agente') and type = 'U') 
CREATE TABLE dbo.Agente (
	Agente	 		varchar(10)  	NOT NULL,

	Nombre 			varchar(100) 	NULL,
	Tipo			varchar(15)	NULL     DEFAULT 'Agente',
	Moneda			varchar(10) 	NULL,
	Telefonos 		varchar(100) 	NULL,
	Extencion		varchar(10) 	NULL,
        Categoria		varchar(50) 	NULL,
	Familia			varchar(50) 	NULL,
	Zona			varchar(30)     NULL,
        Grupo       		varchar(50) 	NULL,

	Estatus			varchar(15) 	NOT NULL,
	UltimoCambio		datetime  	NULL,
	Clase			varchar(15)	NULL,
	Alta			datetime	NULL,
	Baja			datetime	NULL,
	Conciliar		bit		NOT NULL	DEFAULT 0,
	Mensaje			varchar(50)	NULL,
	BeneficiarioNombre	varchar(100)	NULL,
	CostoHora		float		NULL,

	TipoComision		varchar(20)	NULL,		-- No/Factura/Articulo/Ambas
	Porcentaje		float		NULL,
	Nomina			bit		NOT NULL 	DEFAULT 0,
	Personal		varchar(10)	NULL,
	NominaMov		varchar(20)	NULL,
	NominaConcepto		varchar(50)	NULL,

	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	RFC			varchar(20)	NULL,
	CURP			varchar(30)	NULL,
	TieneMovimientos	bit		NULL		DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,
	SucursalEmpresa		int		NULL,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,

	Equipo			bit		NOT NULL 	DEFAULT 0,
	Cuota			money		NULL,
	ArticuloDef		varchar(20)	NULL,
	AlmacenDef		varchar(10)	NULL,
	Acreedor		varchar(10)	NULL,
	eMail			varchar(50) 	NULL,
	eMailAuto		bit		NULL 		DEFAULT 0,
	VentasCasa		bit		NULL 		DEFAULT 0,

	ReportaA		varchar(10)	NULL,
	Jornada			varchar(20)	NULL,

	DireccionNumero		varchar(20)	NULL,
	DireccionNumeroInt	varchar(20)	NULL,
	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		int		NULL,
	MapaUbicacion   varchar(100) NULL,
	FueraLinea		bit		NULL	DEFAULT 0,

	ContactoTipo		varchar(20) NULL DEFAULT 'Agente',
	
	ClerkID				varchar(20) NULL,		-- REQ12336
	--REQ 13389
	CRMID				uniqueidentifier NULL,
	DomainName			varchar(100) NULL,
	
    TMAPrefijo          varchar(5) NULL, -- TASK25101

	CONSTRAINT priAgente PRIMARY KEY  CLUSTERED (Agente)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agente' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.Agente (Nombre)
go
if exists (select * from sysobjects where id = object_id('dbo.tgAgenteBC') and sysstat & 0xf = 8) drop trigger dbo.tgAgenteBC
GO
if not exists(select * from syscampo where tabla = 'Agente' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Agente ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Agente SET TieneMovimientos = 1")
END
GO
EXEC spALTER_TABLE 'Agente', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Agente', 'CURP', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Agente', 'Tipo', 'varchar(15) NULL DEFAULT "Agente" WITH VALUES'
EXEC spALTER_TABLE 'Agente', 'SucursalEmpresa', 'int NULL'
EXEC spALTER_TABLE 'Agente', 'NominaConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Agente', 'Equipo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Agente', 'Cuota', 'money NULL'
EXEC spALTER_TABLE 'Agente', 'ArticuloDef','varchar(20)	NULL'
EXEC spALTER_TABLE 'Agente', 'Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Agente', 'eMail', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Agente', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Agente', 'VentasCasa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Agente', 'Familia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Agente', 'Baja', 'datetime NULL'
EXEC spALTER_TABLE 'Agente', 'ReportaA', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Agente', 'AlmacenDef', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Agente', 'Jornada', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Agente', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Agente', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Agente', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Agente', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Agente', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'Agente', 'MapaUbicacion', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'Agente', 'ContactoTipo', 'varchar(20) NULL DEFAULT "Agente" WITH VALUES'
GO
--REQ 13389
EXEC spALTER_TABLE 'Agente', 'CRMID', 'uniqueidentifier NULL'
EXEC spALTER_TABLE 'Agente', 'DomainName', 'varchar(100) NULL'
GO
EXEC spALTER_COLUMN 'Agente', 'CostoHora', 'float NULL'
GO
EXEC spALTER_TABLE 'Agente', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'Agente'
GO
EXEC spADD_INDEX 'Agente', 'FueraLinea', 'FueraLinea'
GO
EXEC spFK 'Agente','Personal','Personal','Personal'
EXEC spFK 'Agente','SucursalEmpresa','Sucursal','Sucursal'
EXEC spFK 'Agente','ArticuloDef','Art','Articulo'
GO

-- REQ12336
EXEC spALTER_TABLE 'Agente', 'ClerkID', 'varchar(20) NULL'
GO
-- TASK25101
EXEC spALTER_TABLE 'Agente', 'TMAPrefijo', 'varchar(5) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'agente', 'CRMObjectId', 'uniqueidentifier NULL'
GO

CREATE TRIGGER tgAgenteBC ON Agente
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(10),
    @ClaveAnterior	varchar(10),
    @NombreNuevo	varchar(100),
    @NombreAnterior	varchar(100),
    @RFCNuevo		varchar(20),
    @RFCAnterior	varchar(20),
    @CURPNuevo		varchar(30),
    @CURPAnterior	varchar(30),
    @Mensaje 		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Agente, @NombreNuevo    = Nombre, @RFCNuevo    = RFC, @CURPNuevo    = CURP FROM Inserted
  SELECT @ClaveAnterior = Agente, @NombreAnterior = Nombre, @RFCAnterior = RFC, @CURPAnterior = CURP FROM Deleted

  /*IF @NombreNuevo <> @NombreAnterior OR @RFCNuevo <> @RFCAnterior OR @CURPNuevo <> @CURPAnterior*/

  IF @ClaveNueva=@ClaveAnterior RETURN

  IF @ClaveNueva IS NULL 
  BEGIN
    DELETE AgenteActividad WHERE Agente = @ClaveAnterior
    DELETE AgenteCte       WHERE Agente = @ClaveAnterior
    DELETE AgentePersonal  WHERE Agente = @ClaveAnterior
    DELETE AgenteAgenda    WHERE Agente = @ClaveAnterior
    DELETE EquipoAgente    WHERE Equipo = @ClaveAnterior OR Agente = @ClaveAnterior
    DELETE AgenteComisionTipoFactura WHERE Agente = @ClaveAnterior

    DELETE Prop            WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    DELETE ListaD	   WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    DELETE AnexoCta        WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    DELETE CuentaTarea     WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
	DELETE CtoCampoExtra WHERE Tipo = 'Agente' AND Clave = @ClaveAnterior
	DELETE FormaExtraValor WHERE Aplica = 'Agente' AND AplicaClave = @ClaveAnterior
	DELETE FormaExtraD WHERE Aplica = 'Agente' AND AplicaClave = @ClaveAnterior
  END ELSE 
  IF @ClaveNueva <> @ClaveAnterior
  BEGIN
    UPDATE AgenteActividad SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior
    UPDATE AgenteCte       SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior
    UPDATE AgentePersonal  SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior
    UPDATE AgenteAgenda    SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior
    UPDATE EquipoAgente    SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior
    UPDATE EquipoAgente    SET Equipo = @ClaveNueva WHERE Equipo = @ClaveAnterior
    UPDATE AgenteComisionTipoFactura SET Agente = @ClaveNueva WHERE Agente = @ClaveAnterior

    UPDATE Prop            SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    UPDATE ListaD          SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    UPDATE AnexoCta        SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
    UPDATE CuentaTarea     SET Cuenta = @ClaveNueva WHERE Cuenta = @ClaveAnterior AND Rama='AGENT'
	UPDATE CtoCampoExtra   SET Clave		= @ClaveNueva WHERE Clave   = @ClaveAnterior AND Tipo='Agente'
	UPDATE FormaExtraValor SET AplicaClave  = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Agente'
	UPDATE FormaExtraD	   SET AplicaClave  = @ClaveNueva WHERE AplicaClave   = @ClaveAnterior AND Aplica='Agente'
  END
END
GO

--REQ 13389
if exists (select * from sysobjects where id = object_id('dbo.tgAgenteABC_CRM') and sysstat & 0xf = 8) drop trigger dbo.tgAgenteABC_CRM
GO
CREATE TRIGGER tgAgenteABC_CRM ON Agente
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @AgenteI  		varchar(10),
    @AgenteD		varchar(10),
    @CRMII			varchar(36),
    @CRMID			varchar(36),
    @Datos			varchar(max),
    @Usuario		varchar(10),
    @Contrasena		varchar(32),
    @Ok				int,
    @OkRef			varchar(255),
    @IDIS			int,
    
    @Accion			varchar(20)

  IF dbo.fnEstaSincronizandoCRM() = 1
    RETURN
     
   SELECT
     @Usuario    = Usuario,
     @Contrasena = Contrasena
   FROM CfgCRM
  
  SELECT @AgenteI = Agente, @CRMII = CRMID FROM Inserted
  SELECT @AgenteD = Agente, @CRMID = CRMID FROM Deleted  
  
  IF @CRMII IS NULL AND @CRMID IS NULL
    RETURN

  IF @CRMII IS NOT NULL AND @CRMID IS NULL
    SELECT @Accion = 'INSERT'
  ELSE  
  IF @CRMII IS NOT NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'UPDATE'
  ELSE  
  IF @CRMII IS NULL AND @CRMID IS NOT NULL
    SELECT @Accion = 'DELETE'
  ELSE
    RETURN
    
  SELECT @Datos = '<Intelisis Sistema="IntelisisCRM" Contenido="Solicitud" Referencia="IntelisisCRM.CRM" SubReferencia="" Version="1.0">' + '<Solicitud>' + '<' + @Accion + '>'
  
  IF @CRMID IS NULL
  BEGIN
    SELECT @CRMID = NEWID()
    UPDATE Agente 
       SET CRMID = ISNULL(CRMID,@CRMID)
     WHERE Agente = ISNULL(@AgenteI, @AgenteD)
  END
   
  IF @AgenteD IS NULL OR @AgenteD = @AgenteI
    SELECT @Datos = @Datos + (SELECT Acreedor, Agente, AlmacenDef, Alta, ArticuloDef, Baja, BeneficiarioNombre, Categoria, Clase, CodigoPostal, Colonia, Conciliar, CostoHora, @CRMID As CRMID, Cuota, CURP, Direccion, DireccionNumero, DireccionNumeroInt, DomainName, eMail, eMailAuto, Equipo, Estado, Estatus, Extencion, Familia, FueraLinea, Grupo, Jornada, Logico1, Logico2, MapaLatitud, MapaLongitud, MapaPrecision, Mensaje, Moneda, NivelAcceso, Nombre, Nomina, NominaConcepto, NominaMov, Pais, Personal, Poblacion, Porcentaje, ReportaA, RFC, SucursalEmpresa, Telefonos, TieneMovimientos, Tipo, TipoComision, UltimoCambio, VentasCasa, Zona FROM Inserted Agente FOR XML AUTO)
  ELSE
    SELECT @Datos = @Datos + (SELECT Acreedor, Agente, AlmacenDef, Alta, ArticuloDef, Baja, BeneficiarioNombre, Categoria, Clase, CodigoPostal, Colonia, Conciliar, CostoHora, CRMID, Cuota, CURP, Direccion, DireccionNumero, DireccionNumeroInt, DomainName, eMail, eMailAuto, Equipo, Estado, Estatus, Extencion, Familia, FueraLinea, Grupo, Jornada, Logico1, Logico2, MapaLatitud, MapaLongitud, MapaPrecision, Mensaje, Moneda, NivelAcceso, Nombre, Nomina, NominaConcepto, NominaMov, Pais, Personal, Poblacion, Porcentaje, ReportaA, RFC, SucursalEmpresa, Telefonos, TieneMovimientos, Tipo, TipoComision, UltimoCambio, VentasCasa, Zona FROM Deleted Agente FOR XML AUTO)
     
  SELECT @Datos = @Datos + '</' + @Accion + '></Solicitud></Intelisis>'
         
  EXEC spIntelisisService @Usuario, @Contrasena, @Datos, NULL, @Ok OUTPUT, @OkRef OUTPUT, 1, 0, @IDIS OUTPUT
   
  RETURN
END
GO

/****** AgenteCte ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteCte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteCte','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteCte') and type = 'U') 
CREATE TABLE dbo.AgenteCte (
	Agente 		varchar(10) NOT NULL,
	Cliente		varchar(10) NOT NULL,

	Comision	float		NULL,
	Empresa		varchar(5)	NULL,
	FueraLinea	bit		NULL	DEFAULT 0,

	CONSTRAINT priAgenteCte PRIMARY KEY CLUSTERED (Agente, Cliente)
)
GO
EXEC spALTER_TABLE 'AgenteCte', 'Empresa', 'varchar(5) NULL'
GO
EXEC spALTER_TABLE 'AgenteCte', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES' 
UPDATE SysTabla SET FueraLinea = 1 WHERE SysTabla = 'AgenteCte'
GO
EXEC spADD_INDEX 'AgenteCte', 'FueraLinea', 'FueraLinea'
GO

EXEC spFK 'AgenteCte','Agente','Agente','Agente'
EXEC spFK 'AgenteCte','Cliente','Cte','Cliente'
GO

/****** AgendaHora ******/
if not exists(select * from SysTabla where SysTabla = 'AgendaHora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgendaHora','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgendaHora') and type = 'U') 
CREATE TABLE dbo.AgendaHora (
	Hora			varchar(5)		NOT NULL,

	CONSTRAINT priAgendaHora PRIMARY KEY CLUSTERED (Hora)
)
GO

/****** AgenteAgenda ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteAgenda')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteAgenda','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteAgenda','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteAgenda') and type = 'U') 
CREATE TABLE dbo.AgenteAgenda (
	Agente			varchar(10)	NOT NULL,
	Fecha			datetime	NOT NULL,
	Hora			varchar(5)		NOT NULL,

	Modulo			varchar(5)		NULL,
	ID 			int       	NULL,

	CONSTRAINT priAgenteAgenda PRIMARY KEY CLUSTERED (Agente, Fecha, Hora)
)
GO

EXEC spFK 'AgenteAgenda','Agente','Agente','Agente'
GO

/****** AgentePersonal ******/
if not exists(select * from SysTabla where SysTabla = 'AgentePersonal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgentePersonal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgentePersonal') and type = 'U') 
CREATE TABLE dbo.AgentePersonal (
	Agente 		varchar(10) NOT NULL,
	Personal	varchar(10) NOT NULL,

	CONSTRAINT priAgentePersonal PRIMARY KEY CLUSTERED (Agente, Personal)
)
GO

EXEC spFK 'AgentePersonal','Personal','Personal','Personal'
GO

/****** AgenteComisionTipoFactura ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteComisionTipoFactura')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteComisionTipoFactura','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteComisionTipoFactura') and type = 'U') 
CREATE TABLE dbo.AgenteComisionTipoFactura (
	Agente 		varchar(10) 	NOT NULL,
	Mov		varchar(20) 	NOT NULL,

	Porcentaje	float		NULL,
	Importe		money		NULL,

	CONSTRAINT priAgenteComisionTipoFactura PRIMARY KEY CLUSTERED (Agente, Mov)
)
GO


/****** EquipoAgente ******/
if not exists(select * from SysTabla where SysTabla = 'EquipoAgente')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EquipoAgente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EquipoAgente') and type = 'U') 
CREATE TABLE dbo.EquipoAgente (
	Equipo		varchar(10) 	NOT NULL,
	Agente 		varchar(10) 	NOT NULL,

	Porcentaje	float		NULL,

	CONSTRAINT priEquipoAgente PRIMARY KEY CLUSTERED (Equipo, Agente)
)
GO

EXEC spFK 'EquipoAgente','Agente','Agente','Agente'
GO

/*** AgenteTipo ***/
if exists (select * from sysobjects where id = object_id('dbo.AgenteTipo') and type = 'V') drop view dbo.AgenteTipo
GO
if not exists(select * from SysTabla where SysTabla = 'AgenteTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteTipo') and type = 'U') 
CREATE TABLE dbo.AgenteTipo (
	Tipo		varchar(20)	NOT NULL,
	Orden		int		NULL,

	CONSTRAINT priAgenteTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO


/****** AgenteActividad ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteActividad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteActividad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteActividad') and type = 'U') 
CREATE TABLE dbo.AgenteActividad (
	Agente			varchar(10) 	NOT NULL,
	Actividad		varchar(100) 	NOT NULL,

	CONSTRAINT priAgenteActividad PRIMARY KEY  CLUSTERED (Agente, Actividad)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AgenteActividad' AND sysindexes.name = 'Actividad' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Actividad ON dbo.AgenteActividad (Actividad)
GO

EXEC spReplicaTema 'Agentes', 'Agente',				'Agente', @Principal = 1
EXEC spReplicaTema 'Agentes', 'AgenteActividad',		'Agente'
EXEC spReplicaTema 'Agentes', 'AgenteCte',			'Agente'
EXEC spReplicaTema 'Agentes', 'AgentePersonal',			'Agente'
EXEC spReplicaTema 'Agentes', 'AgenteAgenda',			'Agente'
EXEC spReplicaTema 'Agentes', 'EquipoAgente',			'Agente'
EXEC spReplicaTema 'Agentes', 'AgenteComisionTipoFactura',	'Agente'
EXEC spReplicaTema 'Agentes', 'Prop',				'Cuenta', 'Rama', '"AGENT"'
EXEC spReplicaTema 'Agentes', 'ListaD',				'Cuenta', 'Rama', '"AGENT"'
EXEC spReplicaTema 'Agentes', 'AnexoCta',			'Cuenta', 'Rama', '"AGENT"'
EXEC spReplicaTema 'Agentes', 'CuentaTarea',			'Cuenta', 'Rama', '"AGENT"'
GO



/*******************************************************************************************/
/*                                        ACTIVOS FIJOS                                    */
/*******************************************************************************************/

/****** ActivoFTipo ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFTipo') and type = 'U') 
CREATE TABLE dbo.ActivoFTipo (
	Tipo			varchar(50)	NOT NULL,

	CONSTRAINT priActivoFTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO

/****** ActivoFReferencia ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFReferencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFReferencia','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFReferencia') and type = 'U') 
CREATE TABLE dbo.ActivoFReferencia (
	ActivoFID		int		NOT NULL,
	RID			int		identity(1,1),

	Referencia		varchar(50)	NULL,


	CONSTRAINT priActivoFReferencia PRIMARY KEY CLUSTERED (ActivoFID, RID)
)
GO

/****** ActivoFTipoIndicador ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFTipoIndicador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFTipoIndicador','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFTipoIndicador') and type = 'U') 
CREATE TABLE dbo.ActivoFTipoIndicador (
	Tipo			varchar(50)	NOT NULL,
	Indicador		varchar(50)	NOT NULL,

	TipoDato		varchar(20)	NULL,
	Formato			varchar(20)	NULL,
	ValidarEnLista		bit		NULL,

	CONSTRAINT priActivoFTipoIndicador PRIMARY KEY CLUSTERED (Tipo, Indicador)
)
GO

/****** ActivoFTipoIndicadorLista ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFTipoIndicadorLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFTipoIndicadorLista','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFTipoIndicadorLista') and type = 'U') 
CREATE TABLE dbo.ActivoFTipoIndicadorLista (
	Tipo			varchar(50)	NOT NULL,
	Indicador		varchar(50)	NOT NULL,
	Valor			varchar(100)	NOT NULL,

	Orden			int		NULL,

	CONSTRAINT priActivoFTipoIndicadorLista PRIMARY KEY CLUSTERED (Tipo, Indicador, Valor)
)
GO

/****** ActivoFIndicador ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFIndicador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFIndicador','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFIndicador') and type = 'U') 
CREATE TABLE dbo.ActivoFIndicador (
	ActivoFID		int		NOT NULL,
	RID			int		identity(1,1),

	Indicador		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Lectura			varchar(100)	NULL,

	CONSTRAINT priActivoFIndicador PRIMARY KEY CLUSTERED (ActivoFID, RID)
)
GO

/****** ActivoFTipoServicio ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFTipoServicio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFTipoServicio','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFTipoServicio') and type = 'U') 
CREATE TABLE dbo.ActivoFTipoServicio (
	Tipo			varchar(50)	NOT NULL,
	Servicio		varchar(50)	NOT NULL,

	Descripcion		varchar(255)	NULL,
	Unico			bit		NULL DEFAULT 0,
	Inspeccion		int		NULL,
	InspeccionUnidad	varchar(20)	NULL,
	InspeccionUsuarioEsp	varchar(10)	NULL,
	ServicioTallerEsp	varchar(10)	NULL,
	ServicioUsuarioEsp	varchar(10)	NULL,
	ServicioMovEsp		varchar(20)	NULL,
	ServicioConceptoEsp	varchar(50)	NULL,
	ServicioClienteEsp	varchar(10)	NULL,

	CONSTRAINT priActivoFTipoServicio PRIMARY KEY CLUSTERED (Tipo, Servicio)
)
GO

/****** ActivoFTipoServicioCondicion ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFTipoServicioCondicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFTipoServicioCondicion','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFTipoServicioCondicion') and type = 'U') 
CREATE TABLE dbo.ActivoFTipoServicioCondicion (
	Tipo			varchar(50)	NOT NULL,
	Servicio		varchar(50)	NOT NULL,
	Orden			int		NOT NULL,

	Operador		varchar(1)	NULL,
	Indicador		varchar(50)	NULL,
	Condicion		varchar(20)	NULL,
	Valor			varchar(100)	NULL,
	Valor2			varchar(100)	NULL,


	CONSTRAINT priActivoFTipoServicioCondicion PRIMARY KEY CLUSTERED (Tipo, Servicio, Orden)
)
GO

/****** Categorias de Activos Fijos ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFCat') and type = 'U') 
CREATE TABLE dbo.ActivoFCat (
	Categoria 			varchar(50) 	NOT NULL ,

	DepreciacionAnual		float		NULL,
	VidaUtil			int		NULL,
	CategoriaMaestra 		varchar(50) 	NULL,
	MantenimientoPeriodicidad 	varchar(20)	NULL,
	Cuenta				varchar(20)	NULL,
	CuentaFiscal			varchar(20)	NULL,
	Icono				int	  	NULL,
	InicioDepreciacion		varchar(20)	NULL 	DEFAULT 'Siguiente Mes',
	MetodoDepreciacion		varchar(50)	NULL	DEFAULT 'Linea Recta',
	Formula				varchar(255)	NULL,
	Propietario			varchar(20)	NULL	DEFAULT 'Empresa',
	ValorDesecho			money		NULL,
	DepreciacionAnualAjustada	bit		NULL 	DEFAULT 0,
	
	DepreciacionAnualF		float		NULL,
	VidaUtilF			int		NULL,
	InicioDepreciacionF		varchar(20)	NULL 	DEFAULT 'Siguiente Mes',
	MetodoDepreciacionF		varchar(50)	NULL	DEFAULT 'Linea Recta',
	ValorDesechoF			money		NULL,
	DepreciacionAnualAjustadaF	bit		NULL 	DEFAULT 0,

	DepreciacionAnualF2		float		NULL,
	VidaUtilF2			int		NULL,
	InicioDepreciacionF2		varchar(20)	NULL 	DEFAULT 'Siguiente Mes',
	MetodoDepreciacionF2		varchar(50)	NULL	DEFAULT 'Linea Recta',
	ValorDesechoF2			money		NULL,
	DepreciacionAnualAjustadaF2 	bit		NULL 	DEFAULT 0,
	PorcentajeDeducible		float		NULL,


	CONSTRAINT priActivoFCat PRIMARY KEY CLUSTERED (Categoria)
)
GO
EXEC spALTER_TABLE 'ActivoFCat', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'InicioDepreciacion', 'varchar(20) NULL DEFAULT "Siguiente Mes" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'MetodoDepreciacion', 'varchar(50) NULL DEFAULT "Linea Recta" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'Formula', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'CuentaFiscal', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'Propietario', 'varchar(20) NULL DEFAULT "Empresa" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnual', 'float NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'ValorDesecho', 'money NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnualAjustada', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnualF', 'float NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'VidaUtilF', 'int NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'InicioDepreciacionF', 'varchar(20) NULL DEFAULT "Siguiente Mes" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'MetodoDepreciacionF', 'varchar(50) NULL DEFAULT "Linea Recta" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'ValorDesechoF', 'money NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnualAjustadaF', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnualF2', 'float NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'VidaUtilF2', 'int NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'InicioDepreciacionF2', 'varchar(20) NULL DEFAULT "Siguiente Mes" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'MetodoDepreciacionF2', 'varchar(50) NULL DEFAULT "Linea Recta" WITH VALUES'
EXEC spALTER_TABLE 'ActivoFCat', 'ValorDesechoF2', 'money NULL'
EXEC spALTER_TABLE 'ActivoFCat', 'DepreciacionAnualAjustadaF2', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'ActivoFCat', 'PorcentajeDeducible', 'float NULL'

-- 9036
EXEC spALTER_TABLE 'ActivoFCat', 'ConceptoDepreciacion', 'varchar(50) NULL'
GO
-- 9036
EXEC spALTER_TABLE 'ActivoFCat', 'CuentaDepreciacion', 'varchar(20) NULL'
GO
-- 11042
EXEC spDROP_COLUMN 'ActivoFCat', 'ConceptoDepreciacion'
GO

EXEC spFK 'ActivoFCat','Cuenta','Cta','Cuenta'
GO

/****** Lecturas Activos Fijos ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoFLectura')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoFLectura','Cuenta')
go
if (select version from version)<=2300
  update SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'ActivoFLectura'
GO
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFLectura') and type = 'U') 
  CREATE TABLE dbo.ActivoFLectura (
	Empresa		varchar(5)		NOT NULL,
	Articulo 	varchar(20)  	NOT NULL,
	Serie		varchar(20)	NOT NULL,
	Concepto	varchar(50)	NOT NULL,

	Lectura		int		NULL,
	Fecha		datetime	NULL,

	CONSTRAINT priActivoFLectura PRIMARY KEY CLUSTERED (Empresa, Articulo, Serie, Concepto)
)
GO
EXEC spALTER_TABLE 'ActivoFLectura', 'Fecha', 'datetime NULL'
GO

EXEC spDROP_PK 'ActivoFLectura'  --BUG12333
EXEC spALTER_COLUMN 'ActivoFLectura', 'Serie', 'varchar(50) NOT NULL'  --BUG12333
EXEC spADD_PK 'ActivoFLectura', 'Empresa, Articulo, Serie, Concepto'  --BUG12333
GO

/****** Activos Fijos ******/
if not exists(select * from SysTabla where SysTabla = 'ActivoF')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActivoF','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoF') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ActivoF (
	ID				int		NOT NULL IDENTITY(1,1),

	Empresa				varchar(5)		NOT NULL,
	Articulo 			varchar(20)  	NOT NULL,
	Serie				varchar(20)	NULL,

	Moneda				varchar(10)   	NULL,
	Almacen 			varchar(10)   	NULL,
	Categoria 			varchar(50) 	NULL,
	Localizacion			varchar(50) 	NULL,
	UltimoCambio 			datetime  	NULL,
	AdquisicionValor		money		NULL,
	AdquisicionFecha		datetime	NULL,
	GarantiaVence			datetime	NULL,
	DepreciacionAnual		float		NULL,
	VidaUtil			int		NULL,
	Utilizacion			float		NULL,

	DepreciacionInicio		datetime	NULL,
	DepreciacionMeses		int		NULL,
	DepreciacionAcum		money		NULL,
	DepreciacionUltima		datetime	NULL,

	ValorRevaluado			money		NULL,
	RevaluacionUltima		datetime	NULL,

	Mantenimientos     		int  		NULL,
	MantenimientoUltimo		datetime	NULL,
	MantenimientoSiguiente		datetime	NULL,
	MantenimientoCantidad		float		NULL,
	MantenimientoUnidad		varchar(50)	NULL,
	MantenimientoVence		datetime	NULL,
	MantenimientoAcum		money		NULL,
	MantenimientoHoras		float		NULL,
	MantenimientoPeriodicidad 	varchar(20)	NULL,

	Reparaciones			int		NULL,
	ReparacionAcum			money		NULL,
	ReparacionHoras			float		NULL,
	ReparacionUltima		datetime	NULL,
	
	SeguroVence			datetime	NULL,
	SeguroAcum			money		NULL,

	Observaciones			varchar(100)	NULL,

	Estatus				varchar(15)	NOT NULL,
	Sucursal			int		NOT NULL DEFAULT 0,
	TieneMovimientos 		bit		NULL	 DEFAULT 1,
	Cliente				varchar(10)	NULL,
	CentroCostos			varchar(20)	NULL,
	Responsable			varchar(10)	NULL,
	Espacio				varchar(10)	NULL,

	Logico1				bit		NOT NULL DEFAULT 0,
	Logico2				bit		NOT NULL DEFAULT 0,
	Logico3				bit		NOT NULL DEFAULT 0,
	Logico4				bit		NOT NULL DEFAULT 0,
	Logico5				bit		NOT NULL DEFAULT 0,

	Referencia			varchar(50)	NULL,

	Departamento			varchar(50)	NULL,
	Licencia			varchar(50)	NULL,
	Garantia			varchar(50)	NULL,
	Aseguradora			varchar(10)	NULL,
	SeguroInicio			datetime	NULL,
	SeguroTipoPoliza		varchar(50)	NULL,
	SeguroMonto			money		NULL,
	Arrendadora			varchar(10)	NULL,
	UEN				int		NULL,
	Proyecto			varchar(50)	NULL,
	Actividad			varchar(100)	NULL,
	ValorDesecho			money		NULL,
	
	-- Fiscal
	AdquisicionValorF		money		NULL,
	AdquisicionFechaF		datetime	NULL,
	DepreciacionAnualF		float		NULL,
	VidaUtilF			int		NULL,
	UtilizacionF			float		NULL,
	DepreciacionInicioF		datetime	NULL,
	DepreciacionMesesF		int		NULL,
	DepreciacionAcumF		money		NULL,
	DepreciacionUltimaF		datetime	NULL,
	ValorRevaluadoF			money		NULL,
	RevaluacionUltimaF		datetime	NULL,
	ValorDesechoF			money		NULL,

	-- Fiscal2
	AdquisicionValorF2		money		NULL,
	AdquisicionFechaF2		datetime	NULL,
	DepreciacionAnualF2		float		NULL,
	VidaUtilF2			int		NULL,
	UtilizacionF2			float		NULL,
	DepreciacionInicioF2		datetime	NULL,
	DepreciacionMesesF2		int		NULL,
	DepreciacionAcumF2		money		NULL,
	DepreciacionUltimaF2		datetime	NULL,
	ValorRevaluadoF2		money		NULL,
	RevaluacionUltimaF2		datetime	NULL,
	ValorDesechoF2			money		NULL,
	
	PorcentajeDeducible		float		NULL,
	
	UltimaInspeccion	datetime	NULL,
	SiguienteInspeccion	datetime	NULL,
	Tipo			varchar(50)	NULL,
	Inspeccion		int		NULL,
	InspeccionUnidad	varchar(20)	NULL,
	InspeccionUsuario	varchar(10)	NULL,
		
	CONSTRAINT priActivoF PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ActivoF'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ActivoF', '(ID)'
GO
EXEC spALTER_TABLE 'ActivoF', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoF', 'CentroCostos', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'ActivoF', 'Responsable', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoF', 'MantenimientoCantidad', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'MantenimientoUnidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Espacio', 'varchar(10) NULL'
if not exists(select * from syscampo where tabla = 'ActivoF' and campo = 'DepreciacionInicio')
begin
  EXEC("spALTER_TABLE 'ActivoF', 'DepreciacionInicio', 'datetime NULL'")
  EXEC("UPDATE ActivoF SET DepreciacionInicio = DATEADD(day, -DATEPART(day, AdquisicionFecha)+1, DATEADD(month, 1, AdquisicionFecha))")
end
GO
EXEC spALTER_TABLE 'ActivoF', 'Departamento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Licencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Garantia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Aseguradora', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoF', 'SeguroInicio', 'datetime	NULL'
EXEC spALTER_TABLE 'ActivoF', 'SeguroTipoPoliza', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'SeguroMonto', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'Arrendadora', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoF', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'ActivoF', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionAnual', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'ValorDesecho', 'money NULL'
GO

-- Fiscal
EXEC spALTER_TABLE 'ActivoF', 'AdquisicionValorF', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'AdquisicionFechaF', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionAnualF', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'VidaUtilF', 'int	NULL'
EXEC spALTER_TABLE 'ActivoF', 'UtilizacionF', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionInicioF', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionMesesF', 'int NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionAcumF', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionUltimaF', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'ValorRevaluadoF', 'money	NULL'
EXEC spALTER_TABLE 'ActivoF', 'RevaluacionUltimaF', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'ValorDesechoF', 'money NULL'
GO
-- Fiscal2
EXEC spALTER_TABLE 'ActivoF', 'AdquisicionValorF2', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'AdquisicionFechaF2', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionAnualF2', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'VidaUtilF2', 'int NULL'
EXEC spALTER_TABLE 'ActivoF', 'UtilizacionF2', 'float NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionInicioF2', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionMesesF2', 'int NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionAcumF2', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'DepreciacionUltimaF2', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'ValorRevaluadoF2', 'money NULL'
EXEC spALTER_TABLE 'ActivoF', 'RevaluacionUltimaF2', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'ValorDesechoF2', 'money NULL'
GO
EXEC spALTER_TABLE 'ActivoF', 'PorcentajeDeducible', 'float NULL'
GO
EXEC spALTER_TABLE 'ActivoF', 'UltimaInspeccion', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'SiguienteInspeccion', 'datetime NULL'
EXEC spALTER_TABLE 'ActivoF', 'Tipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Inspeccion', 'int NULL'
EXEC spALTER_TABLE 'ActivoF', 'InspeccionUnidad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoF', 'InspeccionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoF', 'Serie', 'varchar(50)'
GO

-- 9036
-- Centros de Costos
EXEC spALTER_TABLE 'ActivoF', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoF', 'ContUso3', 'varchar(20) NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoF' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo  ON dbo.ActivoF (Empresa, Articulo, Serie)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoF' AND sysindexes.name = 'Serie' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Serie     ON dbo.ActivoF (Serie)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoF' AND sysindexes.name = 'Categoria' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Categoria ON dbo.ActivoF (Categoria)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoF' AND sysindexes.name = 'Almacen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Almacen ON dbo.ActivoF (Almacen)
go
if not exists(select * from syscampo where tabla = 'ActivoF' and Campo='TieneMovimientos')
  ALTER TABLE ActivoF ADD TieneMovimientos bit NULL DEFAULT 1 WITH VALUES
GO

EXEC spFK 'ActivoF','Articulo','Art','Articulo'
EXEC spFK 'ActivoF','Categoria','ActivoFCat','Categoria'
EXEC spFK 'ActivoF','Cliente','Cte','Cliente'
EXEC spFK 'ActivoF','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'ActivoF','Responsable','Personal','Personal'
EXEC spFK 'ActivoF','UEN','UEN','UEN'
EXEC spFK 'ActivoF','Almacen','Alm','Almacen'
GO

EXEC spDROP_INDEX 'ActivoF', 'Articulo' -- BUG13958
EXEC spDROP_INDEX 'ActivoF', 'Serie'	-- BUG13958
GO

EXEC spALTER_COLUMN 'ActivoF', 'Serie', 'varchar(50) NULL'  --BUG12333
GO

EXEC spADD_INDEX 'ActivoF', 'Articulo', 'Empresa, Articulo, Serie' -- BUG13958
EXEC spADD_INDEX 'ActivoF', 'Serie', 'Serie'	-- BUG13958
GO

/*******************************************************************************************/
/*                                             NOMINA                                      */
/*******************************************************************************************/

/****** EvaluacionFormato ******/
if (select version from version)<=2165 and exists (select * from sysobjects where id = object_id('dbo.EvaluacionFormato') and type = 'U') 
  DROP TABLE EvaluacionFormato
GO
if not exists(select * from SysTabla where SysTabla = 'EvaluacionFormato')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionFormato','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EvaluacionFormato') and type = 'U') 
  CREATE TABLE dbo.EvaluacionFormato (
	Evaluacion	varchar(50)	NOT NULL,	-- Desempeño	
	Punto		varchar(100)	NOT NULL,	
	
	Descripcion	text		NULL,
	Seccion		varchar(50)	NULL,
	Respuesta	varchar(20)	NULL		DEFAULT '0..10',
	Peso		float		NULL,
	Orden		int		NULL,
	Referencia	varchar(50)	NULL,
	ID		int		NOT NULL	IDENTITY(1,1),

	CONSTRAINT priEvaluacionFormato PRIMARY KEY CLUSTERED (Evaluacion, Punto)
)
GO
EXEC spALTER_TABLE 'EvaluacionFormato', 'Respuesta', 'varchar(20) NULL DEFAULT "0..10" WITH VALUES'
EXEC spALTER_TABLE 'EvaluacionFormato', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EvaluacionFormato', 'ID', 'int NOT NULL IDENTITY(1,1)'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EvaluacionFormato' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON EvaluacionFormato (ID)
GO

EXEC spFK 'EvaluacionFormato','Referencia','Evaluacion','Evaluacion'
GO

/****** EvaluacionCtoHist ******/
if not exists(select * from SysTabla where SysTabla = 'EvaluacionCtoHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionCtoHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EvaluacionCtoHist') and type = 'U') 
  CREATE TABLE dbo.EvaluacionCtoHist (
	Evaluacion	varchar(50)	NOT NULL,	-- Desempeño	
	Punto		varchar(100)	NOT NULL,	
	Contacto	varchar(20)	NOT NULL,
	Fecha		datetime	NOT NULL	DEFAULT GETDATE(),
	ID		int		NOT NULL	IDENTITY(1,1),
	
	Calificacion	float		NULL,

	CONSTRAINT priEvaluacionCtoHist PRIMARY KEY CLUSTERED (Evaluacion, Punto, Contacto, Fecha, ID)
  )
GO
if (select version from version)<=2239
BEGIN
  EXEC("ALTER TABLE EvaluacionCtoHist DROP CONSTRAINT priEvaluacionCtoHist")
  EXEC("ALTER TABLE EvaluacionCtoHist ALTER COLUMN Contacto varchar(20) NOT NULL")
  EXEC("ALTER TABLE EvaluacionCtoHist ADD CONSTRAINT priEvaluacionCtoHist PRIMARY KEY CLUSTERED (Evaluacion, Punto, Contacto, Fecha, ID)")
END
GO
if (select version from version)<=2426
  ALTER TABLE EvaluacionCtoHist ALTER COLUMN Calificacion float	NULL
GO

/****** EvaluacionCto ******/
if not exists(select * from SysTabla where SysTabla = 'EvaluacionCto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionCto','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionCto','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EvaluacionCto') and type = 'U') 
  CREATE TABLE dbo.EvaluacionCto (
	Evaluacion	varchar(50)	NOT NULL,	-- Desempeño	
	Fecha		datetime	NOT NULL,
	Punto		varchar(100)	NOT NULL,	
	Contacto	varchar(20)	NOT NULL,
	
	Calificacion	float		NULL,
	Respuesta	varchar(50)	NULL,

	Modulo		varchar(5)		NULL,
	ModuloID	int		NULL,

	CONSTRAINT priEvaluacionCto PRIMARY KEY CLUSTERED (Evaluacion, Fecha, Punto, Contacto)
  )
GO
if (select version from version)<=2500 and not exists(select * from syscampo where tabla = 'EvaluacionCto' and Campo='Fecha')
BEGIN
  EXEC("ALTER TABLE EvaluacionCto DROP CONSTRAINT priEvaluacionCto")
  EXEC("ALTER TABLE EvaluacionCto ADD Fecha datetime NOT NULL DEFAULT 0 WITH VALUES")
  EXEC("ALTER TABLE EvaluacionCto ALTER COLUMN Contacto	varchar(20) NOT NULL")
  EXEC("ALTER TABLE EvaluacionCto ADD CONSTRAINT priEvaluacionCto PRIMARY KEY CLUSTERED (Evaluacion, Fecha, Punto, Contacto)")
END
GO
if not exists(select * from syscampo where tabla = 'EvaluacionCto' and campo = 'Respuesta')
begin
  EXEC("spALTER_TABLE 'EvaluacionCto', 'Respuesta', 'varchar(50) NULL'")
  EXEC("UPDATE EvaluacionCto SET Respuesta = CONVERT(varchar, Calificacion)")
end
GO
if (select version from version)<=2426
  ALTER TABLE EvaluacionCto ALTER COLUMN Calificacion float NULL
GO
EXEC spALTER_TABLE 'EvaluacionCto', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'EvaluacionCto', 'ModuloID', 'int NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EvaluacionCto' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON EvaluacionCto (ModuloID, Modulo)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgEvaluacionCtoAB') and sysstat & 0xf = 8) drop trigger dbo.tgEvaluacionCtoAB
GO
CREATE TRIGGER tgEvaluacionCtoAB ON EvaluacionCto
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Evaluacion	varchar(50),
    @Fecha	datetime,
    @Punto	varchar(100),
    @Contacto	varchar(20),
    @Modulo 	varchar(5),
    @ModuloID	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Calificacion)
    INSERT EvaluacionCtoHist (Evaluacion, Punto, Contacto, Fecha, Calificacion)
                       SELECT Evaluacion, Punto, Contacto, Fecha, Calificacion FROM Inserted WHERE Calificacion IS NOT NULL

  IF UPDATE(Contacto) 
  BEGIN
    SELECT @Evaluacion = Evaluacion, @Fecha = Fecha, @Punto = Punto, @Contacto = Contacto FROM Inserted
    SELECT @Modulo   = dbo.fnExtraerClaveModulo(@Contacto)
    SELECT @ModuloID = dbo.fnExtraerClaveID(@Contacto)
    IF EXISTS(SELECT * FROM Modulo WHERE Modulo = @Modulo) AND @ModuloID IS NOT NULL
      UPDATE EvaluacionCto SET Modulo = @Modulo, ModuloID = @ModuloID WHERE Evaluacion = @Evaluacion AND Fecha = @Fecha AND /*Punto = @Punto AND */Contacto = @Contacto
  END
END
GO

EXEC spFK2 'EvaluacionCto','Evaluacion','Punto','EvaluacionFormato','Evaluacion','Punto'
GO

/****** EvaluacionComentarios ******/
if not exists(select * from SysTabla where SysTabla = 'EvaluacionComentarios')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionComentarios','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EvaluacionComentarios') and type = 'U') 
  CREATE TABLE dbo.EvaluacionComentarios (
	Evaluacion	varchar(50)	NOT NULL,	
	Fecha		datetime	NOT NULL,
	Contacto	varchar(20)	NOT NULL,
	
	Comentarios	text		NULL,

	CONSTRAINT priEvaluacionComentarios PRIMARY KEY CLUSTERED (Evaluacion, Fecha, Contacto)
  )
GO
if (select version from version)<=2500 and not exists(select * from syscampo where tabla = 'EvaluacionComentarios' and Campo='Fecha')
BEGIN
  EXEC("ALTER TABLE EvaluacionComentarios DROP CONSTRAINT priEvaluacionComentarios")
  EXEC("ALTER TABLE EvaluacionComentarios ADD Fecha datetime NOT NULL DEFAULT 0 WITH VALUES")
  EXEC("ALTER TABLE EvaluacionComentarios ALTER COLUMN Contacto varchar(20) NOT NULL")
  EXEC("ALTER TABLE EvaluacionComentarios ADD CONSTRAINT priEvaluacionComentarios PRIMARY KEY CLUSTERED (Evaluacion, Fecha, Contacto)")
END
GO

/****** EvaluacionGrupo  ******/
if not exists(select * from SysTabla where SysTabla = 'EvaluacionGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EvaluacionGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EvaluacionGrupo') and type = 'U') 
CREATE TABLE dbo.EvaluacionGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priEvaluacionGrupo PRIMARY KEY CLUSTERED (Grupo)
  )
GO

/****** Evaluacion  ******/
if not exists(select * from SysTabla where SysTabla = 'Evaluacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Evaluacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Evaluacion') and type = 'U') 
CREATE TABLE dbo.Evaluacion (
	Evaluacion		varchar(50) 	NOT NULL,
	Tipo			varchar(20)	NULL,				-- Curso, Capacitacion, Induccion, etc.
	Aplica			varchar(20)	NULL	DEFAULT 'Personal',	-- Personal, Clientes, Proveedores, Agentes
	Modulo			varchar(5)		NULL,
	Mov			varchar(20)	NULL,
	Descripcion		varchar(255)	NULL,
	Duracion		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Orden			int		NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priEvaluacion PRIMARY KEY CLUSTERED (Evaluacion)
)
GO
EXEC spALTER_TABLE 'Evaluacion', 'Aplica', 'varchar(20)	NULL DEFAULT "Personal" WITH VALUES'
EXEC spALTER_TABLE 'Evaluacion', 'Modulo', 'char(5) NULL'
EXEC spALTER_TABLE 'Evaluacion', 'Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Evaluacion', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'Evaluacion', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Evaluacion', 'Estatus', 'varchar(15) NULL DEFAULT "ALTA" WITH VALUES'
GO


if exists (select * from sysobjects where id = object_id('dbo.tgEvaluacionBC') and sysstat & 0xf = 8) drop trigger dbo.tgEvaluacionBC
GO
CREATE TRIGGER tgEvaluacionBC ON Evaluacion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @EvaluacionN	varchar(50),
    @EvaluacionA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EvaluacionN = Evaluacion FROM Inserted
  SELECT @EvaluacionA = Evaluacion FROM Deleted

  IF @EvaluacionN = @EvaluacionA RETURN

  IF @EvaluacionN IS NULL
  BEGIN
    DELETE EvaluacionFormato     WHERE Evaluacion = @EvaluacionA
    DELETE EvaluacionCto         WHERE Evaluacion = @EvaluacionA
    DELETE EvaluacionCtoHist     WHERE Evaluacion = @EvaluacionA
    DELETE EvaluacionComentarios WHERE Evaluacion = @EvaluacionA
  END ELSE
  BEGIN
    UPDATE EvaluacionFormato     SET Evaluacion = @EvaluacionN WHERE Evaluacion = @EvaluacionA
    UPDATE EvaluacionCto         SET Evaluacion = @EvaluacionN WHERE Evaluacion = @EvaluacionA
    UPDATE EvaluacionCtoHist     SET Evaluacion = @EvaluacionN WHERE Evaluacion = @EvaluacionA
    UPDATE EvaluacionComentarios SET Evaluacion = @EvaluacionN WHERE Evaluacion = @EvaluacionA
  END
END
GO


/****** TablaNumD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaNumD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaNumD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaNumD') and type = 'U') 
CREATE TABLE dbo.TablaNumD (
	TablaNum	varchar(50) 	NOT NULL,
	Numero		money 		NOT NULL,
	Valor		money		NULL,

	CONSTRAINT priTablaNumD PRIMARY KEY CLUSTERED (TablaNum, Numero)
)
GO

/****** TablaNum ******/
if not exists(select * from SysTabla where SysTabla = 'TablaNum')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaNum','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaNum') and type = 'U') 
CREATE TABLE dbo.TablaNum (
	TablaNum varchar(50) 	NOT NULL,

	CONSTRAINT priTablaNum PRIMARY KEY CLUSTERED (TablaNum)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaNumBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaNumBC
GO
CREATE TRIGGER tgTablaNumBC ON TablaNum
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaNum FROM Inserted
  SELECT @ClaveAnterior = TablaNum FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaNumD WHERE TablaNum = @ClaveAnterior
  ELSE
    UPDATE TablaNumD SET TablaNum = @ClaveNueva WHERE TablaNum = @ClaveAnterior 
END
GO


/****** TablaRangoD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaRangoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaRangoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaRangoD') and type = 'U') 
CREATE TABLE dbo.TablaRangoD (
	TablaRango	varchar(50) 	NOT NULL,
	NumeroD		money 		NOT NULL,
	NumeroA		money 		NOT NULL,
	Valor		money		NULL,

	CONSTRAINT priTablaRangoD PRIMARY KEY CLUSTERED (TablaRango, NumeroD, NumeroA)
)
GO

/****** TablaRango ******/
if not exists(select * from SysTabla where SysTabla = 'TablaRango')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaRango','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaRango') and type = 'U') 
CREATE TABLE dbo.TablaRango (
	TablaRango varchar(50) 	NOT NULL,

	CONSTRAINT priTablaRango PRIMARY KEY CLUSTERED (TablaRango)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaRangoBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaRangoBC
GO
CREATE TRIGGER tgTablaRangoBC ON TablaRango
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaRango FROM Inserted
  SELECT @ClaveAnterior = TablaRango FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaRangoD WHERE TablaRango = @ClaveAnterior
  ELSE
    UPDATE TablaRangoD SET TablaRango = @ClaveNueva WHERE TablaRango = @ClaveAnterior 
END
GO




/****** TablaRangoStD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaRangoStD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaRangoStD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaRangoStD') and type = 'U') 
CREATE TABLE dbo.TablaRangoStD (
	TablaRangoSt	varchar(50) 	NOT NULL,
	NumeroD		float 		NOT NULL,
	NumeroA		float 		NOT NULL,
	Nombre		varchar(50)	NULL,

	CONSTRAINT priTablaRangoStD PRIMARY KEY CLUSTERED (TablaRangoSt, NumeroD, NumeroA)
)
GO

/****** TablaRangoSt ******/
if not exists(select * from SysTabla where SysTabla = 'TablaRangoSt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaRangoSt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaRangoSt') and type = 'U') 
CREATE TABLE dbo.TablaRangoSt (
	TablaRangoSt varchar(50) 	NOT NULL,

	CONSTRAINT priTablaRangoSt PRIMARY KEY CLUSTERED (TablaRangoSt)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaRangoStBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaRangoStBC
GO
CREATE TRIGGER tgTablaRangoStBC ON TablaRangoSt
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaRangoSt FROM Inserted
  SELECT @ClaveAnterior = TablaRangoSt FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaRangoStD WHERE TablaRangoSt = @ClaveAnterior
  ELSE
    UPDATE TablaRangoStD SET TablaRangoSt = @ClaveNueva WHERE TablaRangoSt = @ClaveAnterior 
END
GO

/****** TablaImpuestoHist ******/
if not exists(select * from SysTabla where SysTabla = 'TablaImpuestoHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaImpuestoHist','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaImpuestoHist') and type = 'U') 
CREATE TABLE dbo.TablaImpuestoHist (
	TablaImpuesto	varchar(50) 	NOT NULL,
	PeriodoTipo	varchar(20)	NOT NULL,
	Fecha		datetime	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	LimiteInferior	money		NULL,
	LimiteSuperior	money		NULL,
	Cuota		money		NULL,
	Porcentaje	money		NULL,

	CONSTRAINT priTablaImpuestoHist PRIMARY KEY CLUSTERED (TablaImpuesto, PeriodoTipo, Fecha, ID)
)
GO


/****** TablaImpuestoD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaImpuestoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaImpuestoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaImpuestoD') and type = 'U') 
CREATE TABLE dbo.TablaImpuestoD (
	TablaImpuesto	varchar(50) 	NOT NULL,
	PeriodoTipo	varchar(20)	NOT NULL,  -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Anual

	LimiteInferior	money		NOT NULL,
	LimiteSuperior	money		NOT NULL,
	Cuota		money		NULL,
	Porcentaje	float		NULL,
	Descuento	float		NULL,

	CONSTRAINT priTablaImpuestoD PRIMARY KEY CLUSTERED (TablaImpuesto, PeriodoTipo, LimiteInferior)
)
GO
EXEC spALTER_TABLE 'TablaImpuestoD', 'Descuento', 'float NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaImpuestoDAC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaImpuestoDAC
GO
if (select version from version)<=2237
  ALTER TABLE TablaImpuestoD ALTER COLUMN Porcentaje float NULL
GO

CREATE TRIGGER tgTablaImpuestoDAC ON TablaImpuestoD
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(LimiteInferior) OR UPDATE(LimiteSuperior) OR UPDATE(Cuota) OR UPDATE(Porcentaje)
    INSERT TablaImpuestoHist (Fecha,     TablaImpuesto, PeriodoTipo, LimiteInferior, LimiteSuperior, Cuota, Porcentaje)
                       SELECT GETDATE(), TablaImpuesto, PeriodoTipo, LimiteInferior, LimiteSuperior, Cuota, Porcentaje
                         FROM Inserted
END
GO

/****** TablaImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'TablaImpuesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaImpuesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaImpuesto') and type = 'U') 
CREATE TABLE dbo.TablaImpuesto (
	TablaImpuesto	varchar(50) 	NOT NULL,
	PeriodoTipo	varchar(20)	NOT NULL,  -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Anual

	CONSTRAINT priTablaImpuesto PRIMARY KEY CLUSTERED (TablaImpuesto, PeriodoTipo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaImpuestoBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaImpuestoBC
GO
CREATE TRIGGER tgTablaImpuestoBC ON TablaImpuesto
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50),
    @PeriodoNuevo	varchar(20),
    @PeriodoAnterior	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaImpuesto, @PeriodoNuevo = PeriodoTipo FROM Inserted
  SELECT @ClaveAnterior = TablaImpuesto, @PeriodoAnterior = PeriodoTipo FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaImpuestoD WHERE TablaImpuesto = @ClaveAnterior AND PeriodoTipo = @PeriodoAnterior
  ELSE
    UPDATE TablaImpuestoD SET TablaImpuesto = @ClaveNueva, PeriodoTipo = @PeriodoNuevo WHERE TablaImpuesto = @ClaveAnterior AND PeriodoTipo = @PeriodoAnterior
END
GO

/****** TablaComisionEspD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaComisionEspD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaComisionEspD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaComisionEspD') and type = 'U') 
CREATE TABLE dbo.TablaComisionEspD (
	TablaComisionEsp	varchar(50) 	NOT NULL,
	Desde			float		NOT NULL,		-- % Eficiencia
	Hasta			float		NOT NULL,		-- % Eficiencia

	Porcentaje		float		NULL,
	Importe			money		NULL,
	Importe2		money		NULL,

	CONSTRAINT priTablaComisionEspD PRIMARY KEY CLUSTERED (TablaComisionEsp, Desde, Hasta)
)
GO
EXEC spALTER_TABLE 'TablaComisionEspD', 'Importe2', 'money NULL'
GO

/****** TablaComisionEsp ******/
if not exists(select * from SysTabla where SysTabla = 'TablaComisionEsp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaComisionEsp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaComisionEsp') and type = 'U') 
CREATE TABLE dbo.TablaComisionEsp (
	TablaComisionEsp varchar(50) 	NOT NULL,

	Tipo		      varchar(20)	NULL,

	CONSTRAINT priTablaComisionEsp PRIMARY KEY CLUSTERED (TablaComisionEsp)
)
GO
EXEC spALTER_TABLE 'TablaComisionEsp', 'Tipo', 'varchar(20) NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaComisionEspBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaComisionEspBC
GO
CREATE TRIGGER tgTablaComisionEspBC ON TablaComisionEsp
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaComisionEsp FROM Inserted
  SELECT @ClaveAnterior = TablaComisionEsp FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaComisionEspD WHERE TablaComisionEsp = @ClaveAnterior
  ELSE
    UPDATE TablaComisionEspD SET TablaComisionEsp = @ClaveNueva WHERE TablaComisionEsp = @ClaveAnterior 
END
GO


/****** TablaEvaluacionD ******/
if not exists(select * from SysTabla where SysTabla = 'TablaEvaluacionD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaEvaluacionD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaEvaluacionD') and type = 'U') 
CREATE TABLE dbo.TablaEvaluacionD (
	TablaEvaluacion	varchar(20) 	NOT NULL,
	Nombre		varchar(50) 	NOT NULL,
	Valor		float		NULL,
	Orden		int		NULL,

	CONSTRAINT priTablaEvaluacionD PRIMARY KEY CLUSTERED (TablaEvaluacion, Nombre)
)
GO

/****** TablaEvaluacion ******/
if not exists(select * from SysTabla where SysTabla = 'TablaEvaluacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaEvaluacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TablaEvaluacion') and type = 'U') 
CREATE TABLE dbo.TablaEvaluacion (
	TablaEvaluacion varchar(20) 	NOT NULL,

	CONSTRAINT priTablaEvaluacion PRIMARY KEY CLUSTERED (TablaEvaluacion)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTablaEvaluacionBC') and sysstat & 0xf = 8) drop trigger dbo.tgTablaEvaluacionBC
GO
CREATE TRIGGER tgTablaEvaluacionBC ON TablaEvaluacion
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(20),
    @ClaveAnterior	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = TablaEvaluacion FROM Inserted
  SELECT @ClaveAnterior = TablaEvaluacion FROM Deleted
  IF @ClaveNueva IS NULL
    DELETE TablaEvaluacionD WHERE TablaEvaluacion = @ClaveAnterior
  ELSE
    UPDATE TablaEvaluacionD SET TablaEvaluacion = @ClaveNueva WHERE TablaEvaluacion = @ClaveAnterior 
END
GO


/****** MinimosProfesionales ******/
if not exists(select * from SysTabla where SysTabla = 'MinimosProfesionales')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MinimosProfesionales','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MinimosProfesionales') and type = 'U') 
CREATE TABLE dbo.MinimosProfesionales (
	Numero		int		NOT NULL,

	Descripcion	varchar(100)	NULL,
	ZonaA		money		NULL,
	ZonaB		money		NULL,
	ZonaC		money		NULL,

	CONSTRAINT priMinimosProfesionales PRIMARY KEY CLUSTERED (Numero)
)
GO

/****** PeriodoTipoD  ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoTipoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PeriodoTipoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipoD') and type = 'U') 
CREATE TABLE dbo.PeriodoTipoD (
	PeriodoTipo	varchar(20) 	NOT NULL, 

	Ejercicio	int		NOT NULL,
	Periodo		int		NOT NULL,
	FechaInicio	datetime	NULL,
	FechaFinal	datetime	NULL,

	CONSTRAINT priPeriodoTipoD PRIMARY KEY  CLUSTERED (PeriodoTipo, Ejercicio, Periodo)
)
GO

/****** PeriodoTipoMov  ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoTipoMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PeriodoTipoMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipoMov') and type = 'U') 
CREATE TABLE dbo.PeriodoTipoMov (
	PeriodoTipo	varchar(20) 	NOT NULL, 
	Mov		varchar(20)	NOT NULL,

	UltimoDiaPagado	datetime	NULL,

	CONSTRAINT priPeriodoTipoMov PRIMARY KEY  CLUSTERED (PeriodoTipo, Mov)
)
GO

/****** PeriodoTipoMovEmpresa  ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoTipoMovEmpresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PeriodoTipoMovEmpresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipoMovEmpresa') and type = 'U') 
CREATE TABLE dbo.PeriodoTipoMovEmpresa (
	PeriodoTipo	varchar(20) 	NOT NULL, 
	Mov		varchar(20)	NOT NULL,
	Empresa		varchar(5)		NOT NULL,

	UltimoDiaPagado	datetime	NULL,

	CONSTRAINT priPeriodoTipoMovEmpresa PRIMARY KEY  CLUSTERED (PeriodoTipo, Mov, Empresa)
)
GO

/************ PeriodoTipoCalendario ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoTipoCalendario')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PeriodoTipoCalendario', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipoCalendario') and type = 'U') 
  CREATE TABLE dbo.PeriodoTipoCalendario (
        PeriodoTipo		varchar(20) 	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	FechaNomina		datetime	NULL,
	SemanasPeriodo		int		NULL,
	Abierto			bit		NULL	DEFAULT 0,

	CONSTRAINT priNominaPeriodo PRIMARY KEY  CLUSTERED (PeriodoTipo, Ejercicio, Periodo)
  )
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PeriodoTipoCalendario' AND sysindexes.name = 'FechaNomina' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaNomina ON PeriodoTipoCalendario (FechaNomina)
GO

/****** PeriodoTipo ******/
if not exists(select * from SysTabla where SysTabla = 'PeriodoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PeriodoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PeriodoTipo') and type = 'U') 
CREATE TABLE dbo.PeriodoTipo (
	PeriodoTipo	varchar(20) 	NOT NULL, -- Semanal, Decenal, Catorcenal, Quincenal, Mensual, Especial
	DiasPeriodo	float		NULL,
	DiasHabiles	float		NULL,
	UltimoDiaPagado	datetime	NULL,

	CONSTRAINT priPeriodoTipo PRIMARY KEY  CLUSTERED (PeriodoTipo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPeriodoTipoBC') and sysstat & 0xf = 8) drop trigger dbo.tgPeriodoTipoBC
GO
CREATE TRIGGER tgPeriodoTipoBC ON PeriodoTipo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(50),
    @ClaveAnterior	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = PeriodoTipo FROM Inserted
  SELECT @ClaveAnterior = PeriodoTipo FROM Deleted
  IF @ClaveNueva IS NULL
  BEGIN
    DELETE PeriodoTipoD          WHERE PeriodoTipo = @ClaveAnterior
    DELETE PeriodoTipoMov        WHERE PeriodoTipo = @ClaveAnterior
    DELETE PeriodoTipoCalendario WHERE PeriodoTipo = @ClaveAnterior
  END ELSE
  BEGIN
    UPDATE PeriodoTipoD          SET PeriodoTipo = @ClaveNueva WHERE PeriodoTipo = @ClaveAnterior
    UPDATE PeriodoTipoMov        SET PeriodoTipo = @ClaveNueva WHERE PeriodoTipo = @ClaveAnterior
    UPDATE PeriodoTipoCalendario SET PeriodoTipo = @ClaveNueva WHERE PeriodoTipo = @ClaveAnterior
  END
END
GO

/****** JornadaD ******/
if not exists(select * from SysTabla where SysTabla = 'JornadaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('JornadaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.JornadaD') and type = 'U') 
CREATE TABLE dbo.JornadaD (
	Jornada			varchar(20) 	NOT NULL,
	Dia			int		NOT NULL,
	Entrada			varchar(5)		NOT NULL,
	Salida			varchar(5)		NOT NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priJornadaD PRIMARY KEY  CLUSTERED (Jornada, Dia, Entrada)
)
GO

EXEC spFK 'JornadaD','Jornada','Jornada','Jornada'
GO

/****** JornadaTiempo ******/
if not exists(select * from SysTabla where SysTabla = 'JornadaTiempo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('JornadaTiempo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.JornadaTiempo') and type = 'U') 
CREATE TABLE dbo.JornadaTiempo (
	Jornada		varchar(20) 	NOT NULL,
	Entrada		datetime	NOT NULL,
	Salida		datetime	NOT NULL,
	Fecha		datetime	NULL,

	CONSTRAINT priJornadaTiempo PRIMARY KEY  CLUSTERED (Jornada, Entrada)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'JornadaTiempo' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.JornadaTiempo (Fecha)
go
if exists (select * from sysobjects where id = object_id('dbo.tgJornadaTiempoAC') and sysstat & 0xf = 8) drop trigger dbo.tgJornadaTiempoAC
GO
CREATE TRIGGER tgJornadaTiempoAC ON JornadaTiempo
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @JornadaI  	varchar(50),
    @JornadaD  	varchar(50),
    @EntradaI	datetime,
    @EntradaD	datetime,
    @Fecha	datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @JornadaI = Jornada, @EntradaI = Entrada FROM Inserted
  SELECT @JornadaD = Jornada, @EntradaD = Entrada FROM Deleted
  IF @JornadaI IS NOT NULL AND (@JornadaI <> @JornadaD OR @EntradaI <> @EntradaD)
  BEGIN
    SELECT @Fecha = @EntradaI
    EXEC spExtraerFecha @Fecha OUTPUT
    UPDATE JornadaTiempo SET Fecha = @Fecha WHERE Jornada = @JornadaI AND Entrada = @EntradaI
  END
END
GO


/****** JornadaDiaFestivo  ******/
if not exists(select * from SysTabla where SysTabla = 'JornadaDiaFestivo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('JornadaDiaFestivo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.JornadaDiaFestivo') and type = 'U') 
CREATE TABLE dbo.JornadaDiaFestivo (
	Jornada			varchar(20) 	NOT NULL,
	Fecha			datetime 	NOT NULL,

	Concepto		varchar(50)	NULL,
        EsLaborable		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priJornadaDiaFestivo PRIMARY KEY  CLUSTERED (Jornada, Fecha)
)
GO

/****** Jornada ******/
if not exists(select * from SysTabla where SysTabla = 'Jornada')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Jornada','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Jornada') and type = 'U') 
CREATE TABLE dbo.Jornada (
	Jornada			varchar(20) 	NOT NULL,
	Tipo			varchar(20)	NULL 	 DEFAULT 'Sin Control',	-- Sin Control/Control Asistencias/por Horas

	Domingo			bit		NOT NULL DEFAULT 1,
	Lunes			bit		NOT NULL DEFAULT 0,
	Martes			bit		NOT NULL DEFAULT 0,
	Miercoles		bit		NOT NULL DEFAULT 0,
	Jueves			bit		NOT NULL DEFAULT 0,
	Viernes			bit		NOT NULL DEFAULT 0,
	Sabado			bit		NOT NULL DEFAULT 1,
	DescansoRompeRutina	bit		NOT NULL DEFAULT 1,

	DescansaFestivos	bit		NOT NULL DEFAULT 1,
	FestivoRompeRutina	bit		NOT NULL DEFAULT 0,

	HorasPromedio		float		NULL,
	HorasSemana		float		NULL,
	HorasComida		float		NULL,
	FactorAusentismo	float		NULL	 DEFAULT 1.4,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	JornadaReducida		bit		NULL 	 DEFAULT 0,

	CONSTRAINT priJornada PRIMARY KEY  CLUSTERED (Jornada)
)
GO
EXEC spALTER_TABLE 'Jornada', 'FactorAusentismo', 'float NULL DEFAULT 1.4 WITH VALUES'
EXEC spALTER_TABLE 'Jornada', 'JornadaReducida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Jornada', 'HorasSemana', 'float NULL'
EXEC spALTER_TABLE 'Jornada', 'HorasComida', 'float NULL'
EXEC spALTER_TABLE 'Jornada', 'JornadaNocturna', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'Jornada', 'TipoJornada', 'varchar(2) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgJornadaBC') and sysstat & 0xf = 8) drop trigger dbo.tgJornadaBC
GO
CREATE TRIGGER tgJornadaBC ON Jornada
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @JornadaD  	varchar(50),
    @JornadaI	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @JornadaI = Jornada FROM Inserted
  SELECT @JornadaD = Jornada FROM Deleted
  IF @JornadaI IS NULL
  BEGIN
    DELETE JornadaD          WHERE Jornada = @JornadaD
    DELETE JornadaTiempo     WHERE Jornada = @JornadaD
    DELETE JornadaDiaFestivo WHERE Jornada = @JornadaD
  END ELSE
  BEGIN
    UPDATE JornadaD          SET Jornada = @JornadaI WHERE Jornada = @JornadaD
    UPDATE JornadaTiempo     SET Jornada = @JornadaI WHERE Jornada = @JornadaD
    UPDATE JornadaDiaFestivo SET Jornada = @JornadaI WHERE Jornada = @JornadaD
  END
END
GO

/****** ZonaEconomica ******/
if not exists(select * from SysTabla where SysTabla = 'ZonaEconomica')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ZonaEconomica','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ZonaEconomica') and type = 'U') 
CREATE TABLE dbo.ZonaEconomica (
	Zona		varchar(30) 	NOT NULL,
	SueldoMinimo	money		NULL,

	CONSTRAINT priZonaEconomica PRIMARY KEY  CLUSTERED (Zona)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgZonaEconomicaABC') and sysstat & 0xf = 8) drop trigger dbo.tgZonaEconomicaABC
GO

/****** ZonaEconomicaHist  ******/
if not exists(select * from SysTabla where SysTabla = 'ZonaEconomicaHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ZonaEconomicaHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ZonaEconomicaHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ZonaEconomicaHist (
	Zona		varchar(30)  	NOT NULL,
	Fecha		datetime	NOT NULL,
	RenglonID	int		NOT NULL IDENTITY(1,1),

	SueldoMinimo	money		NULL,
	CONSTRAINT priZonaEconomicaHist PRIMARY KEY CLUSTERED (Zona, Fecha, RenglonID)
  )
  EXEC spSincroSemilla 'ZonaEconomicaHist'
END
GO

CREATE TRIGGER tgZonaEconomicaABC ON ZonaEconomica
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE 
AS BEGIN

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Zona) OR UPDATE(SueldoMinimo) 
    INSERT ZonaEconomicaHist 
          (Zona, Fecha,     SueldoMinimo)
    SELECT Zona, GETDATE(), SueldoMinimo
      FROM Inserted
END
GO


/****** PersonalCat ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalCat') and type = 'U') 
CREATE TABLE dbo.PersonalCat (
	Categoria	varchar(50) 	NOT NULL,

	Descripcion	varchar(100)	NULL,
	SueldoMaximo	money		NULL,
	SueldoMedio	money		NULL,
	SueldoMinimo	money		NULL,
	FactorCANAPAT	float		NULL,

	CONSTRAINT priPersonalCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPersonalCatABC') and sysstat & 0xf = 8) drop trigger dbo.tgPersonalCatABC
GO
EXEC spALTER_TABLE 'PersonalCat', 'Descripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'PersonalCat', 'SueldoMedio', 'money	NULL'
EXEC spALTER_TABLE 'PersonalCat', 'FactorCANAPAT', 'float NULL'
GO

CREATE TRIGGER tgPersonalCatABC ON PersonalCat
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @CategoriaI  varchar(50),
    @CategoriaD  varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CategoriaI = Categoria FROM Inserted
  SELECT @CategoriaD = Categoria FROM Deleted

  -- Si Inserto
  IF @CategoriaD IS NULL
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'CAT' AND Cuenta = @CategoriaI
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) SELECT Propiedad, 'CAT', @CategoriaI, porOmision FROM PersonalProp WHERE NivelCategoria = 1
  END ELSE

  -- Si Elimino o Inserto
  IF @CategoriaI IS NULL 
    DELETE PersonalPropValor WHERE Rama = 'CAT' AND Cuenta = @CategoriaD
  ELSE

  -- Si Modifico 
  IF @CategoriaI <> @CategoriaD
    UPDATE PersonalPropValor SET Cuenta = @CategoriaI WHERE Rama = 'CAT' AND Cuenta = @CategoriaD
END
GO

/****** Departamento ******/
if not exists(select * from SysTabla where SysTabla = 'Departamento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Departamento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Departamento') and type = 'U') 
CREATE TABLE dbo.Departamento (
	Departamento	varchar(50) 	NOT NULL,

	Descripcion	varchar(100) 	NULL,
	Localidad	varchar(50) 	NULL,
	CtaDinero	varchar(10)	NULL,
	Sucursal	int		NULL,
        ReferenciaIntelisisService	varchar(50)	NULL,	

	CONSTRAINT priDepartamento PRIMARY KEY CLUSTERED (Departamento)
)
GO
EXEC spALTER_TABLE 'Departamento', 'Descripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Departamento', 'Sucursal', 'int NULL'
GO
 --REQ12534 Factory  
Exec spAlter_Table 'Departamento', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

EXEC spFK 'Departamento','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Departamento','Sucursal','Sucursal','Sucursal'
GO


/****** Sindicato ******/
if not exists(select * from SysTabla where SysTabla = 'Sindicato')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Sindicato','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Sindicato') and type = 'U') 
CREATE TABLE dbo.Sindicato (
	Sindicato	varchar(50) 	NOT NULL,

	CONSTRAINT priSindicato PRIMARY KEY CLUSTERED (Sindicato)
)
GO

/****** Plaza ******/
if not exists(select * from SysTabla where SysTabla = 'Plaza')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Plaza','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Plaza') and type = 'U') 
CREATE TABLE dbo.Plaza (
	Plaza			varchar(20) 	NOT NULL,
	Rama			varchar(20)	NULL,

	Descripcion		varchar(100)	NULL,
	Tipo			varchar(20)	NULL,	-- Provisional, Definitiva
	Departamento		varchar(50)	NULL,
	Puesto			varchar(50)	NULL,
	VigenciaD		datetime	NULL,
	VigenciaA		datetime	NULL,
	Sueldo			money		NULL,
	EsJefe			bit		NULL	DEFAULT 0,

	Estatus			varchar(15)	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,

	Personal		varchar(10)	NULL,

	TieneMovimientos	bit		NULL	DEFAULT 0,
	Empresa			varchar(5)		NULL,
	Sucursal		int		NULL,
	APartirDe		datetime	NULL,
	CentroCostos		varchar(20)	NULL,
	UEN			int		NULL,
	Area			varchar(50)	NULL

	CONSTRAINT priPlaza PRIMARY KEY  CLUSTERED (Plaza)
)
GO

EXEC spALTER_TABLE 'Plaza', 'EsJefe', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Plaza', 'Personal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Plaza', 'TieneMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Plaza', 'Empresa', 'char(5)	NULL'
EXEC spALTER_TABLE 'Plaza', 'Sucursal', 'int NULL'
EXEC spALTER_TABLE 'Plaza', 'APartirDe', 'datetime NULL'
EXEC spALTER_TABLE 'Plaza', 'CentroCostos', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Plaza', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Plaza', 'Area', 'varchar(50) NULL'

GO

EXEC spFK 'Plaza','Personal','Personal','Personal'
EXEC spFK 'Plaza','Sucursal','Sucursal','Sucursal'
EXEC spFK 'Plaza','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'Plaza','UEN','UEN','UEN'
GO

/********************* tgPlazaA *******************/
if exists (select * from sysobjects where id = object_id('dbo.tgPlazaA') and type = 'tr') drop trigger tgPlazaA
GO
CREATE TRIGGER tgPlazaA ON Plaza
FOR UPDATE, INSERT
AS BEGIN
  DECLARE
	@PlazaN			varchar(20),
	@PlazaA			varchar(20),
	@Estatus		varchar(15),
	@Rama			varchar(20),
	@Personal		varchar(10),
	@Mensaje		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PlazaN = RTRIM(Plaza), @Estatus = RTRIM(Estatus), @Rama = RTRIM(Rama), @Personal = NULLIF(RTRIM(Personal), '')
    FROM Inserted

  SELECT @PlazaA = RTRIM(Plaza)
    FROM Deleted

  -- Inserta
  IF @PlazaN is not NULL AND @PlazaA is null
    BEGIN
      IF @Rama = ''
        UPDATE Plaza SET Rama = NULL WHERE Plaza = @PlazaN
    END

  -- Modifica
  IF @PlazaN is not NULL AND @PlazaA is not null AND @Estatus = 'BAJA' AND @Personal is not null
    BEGIN
      SELECT @Mensaje = 'No se puede dar de Baja la Plaza ' + RTRIM(@PlazaN) + '. Tiene Asignada una Persona'
      RAISERROR (@Mensaje, 16, -1) 
    END

  RETURN
END
GO

/****** Area ******/
if not exists(select * from SysTabla where SysTabla = 'Area')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Area','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Area') and type = 'U') 
CREATE TABLE dbo.Area (
	Area		varchar(50) 	NOT NULL,

	CONSTRAINT priArea PRIMARY KEY  CLUSTERED (Area)
)
GO

/****** Fuente ******/
if not exists(select * from SysTabla where SysTabla = 'Fuente')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Fuente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Fuente') and type = 'U') 
CREATE TABLE dbo.Fuente (
	Fuente		varchar(50) 	NOT NULL,

	CONSTRAINT priFuente PRIMARY KEY  CLUSTERED (Fuente)
)
GO


/*******************************************************************************************/
/*                                             CAMBIOS                                     */
/*******************************************************************************************/

/****** Instrumentos  ******/
if not exists(select * from SysTabla where SysTabla = 'Instrumento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Instrumento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Instrumento') and type = 'U') 
CREATE TABLE dbo.Instrumento (
        Instrumento		varchar(10)	NOT NULL,

	Descripcion		varchar(50)	NULL,
	Moneda			varchar(10)	NOT NULL,
	Uso			varchar(20)	NULL,
	CtaDineroVenta 		varchar(10) 	NULL,
	CtaDineroCompra		varchar(10) 	NULL,
	FormaPagoVenta		varchar(50)	NULL,
	FormaPagoCompra		varchar(50)	NULL,
	RequiereBeneficiario	bit		NOT NULL DEFAULT 0,
	UnidadMinima		float		NULL	 DEFAULT 0.01,
	FormulaCobertura	text		NULL,
	Tipo			varchar(20)	NULL,
	Cobertura		bit		NULL	DEFAULT 1,
	MargenCompra		float		NULL,
	MargenVenta		float		NULL,
	Mostrar			bit		NULL	DEFAULT 0,
	Ventanilla		bit		NULL	DEFAULT 0,

	CONSTRAINT priInstrumento PRIMARY KEY  CLUSTERED (Instrumento)
)
GO
EXEC spALTER_TABLE 'Instrumento', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Instrumento', 'Cobertura', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Instrumento', 'MargenCompra', 'float NULL'
EXEC spALTER_TABLE 'Instrumento', 'MargenVenta', 'float	NULL'
EXEC spALTER_TABLE 'Instrumento', 'Mostrar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Instrumento', 'Ventanilla', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** InstrumentoD  ******/
if not exists(select * from SysTabla where SysTabla = 'InstrumentoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InstrumentoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.InstrumentoD') and type = 'U') 
CREATE TABLE dbo.InstrumentoD (
        Instrumento		varchar(10)	NOT NULL,
	Denominacion		money		NOT NULL,

	CONSTRAINT priInstrumentoD PRIMARY KEY  CLUSTERED (Instrumento, Denominacion)
)
GO

-- drop table InstitucionConcepto
/****** InstitucionFinConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'InstitucionFinConcepto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InstitucionFinConcepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.InstitucionFinConcepto') and type = 'U') 
CREATE TABLE dbo.InstitucionFinConcepto  (
	Institucion			varchar(20)	NOT NULL,
	ConceptoBanco			varchar(50)	NOT NULL,

	TipoMovimiento			varchar(20)	NULL,
	ConceptoGasto			varchar(50)	NULL,
	Acreedor			varchar(10)	NULL,
	PermiteAbonoNoIdentificado	bit		NULL	DEFAULT 0,
    PermiteCargoNoIdentificado	bit		NULL	DEFAULT 0,
	ObligacionFiscal		varchar(50)	NULL,
	ObligacionFiscal2		varchar(50)	NULL,
	Tasa				float		NULL,
	TipoImporte			varchar(20)	NULL,	-- Base/Obligacion Fiscal

	CONSTRAINT priInstitucionFinConcepto PRIMARY KEY  CLUSTERED (Institucion, ConceptoBanco)
)
GO
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'Tasa', 'float NULL'
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'TipoImporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'ObligacionFiscal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'ObligacionFiscal2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'InstitucionFinConcepto', 'PermiteCargoNoIdentificado', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgInstitucionFinC') and sysstat & 0xf = 8) drop trigger dbo.tgInstitucionFinC
GO
CREATE TRIGGER tgInstitucionFinC ON InstitucionFin
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @InstitucionN	varchar(20),
    @InstitucionA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @InstitucionN = Institucion FROM Inserted
  SELECT @InstitucionA = Institucion FROM Deleted

  IF @InstitucionN <> @InstitucionA 
  BEGIN
    UPDATE MensajeInstitucion     SET Institucion = @InstitucionN WHERE Institucion = @InstitucionA
    UPDATE InstitucionFinConcepto SET Institucion = @InstitucionN WHERE Institucion = @InstitucionA
  END
END
GO

/****** Beneficiarios ******/
if not exists(select * from SysTabla where SysTabla = 'Beneficiario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Beneficiario','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Beneficiario') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Beneficiario (
	Beneficiario		int 	    	NOT NULL IDENTITY(1,1),

	Cliente			varchar(10) 	NULL,
	Instrumento		varchar(10)	NULL,
	Nombre			varchar(100)	NULL,
	Info1			varchar(50)	NULL,
	Info2            	varchar(50)	NULL,
	Info3             	varchar(50)	NULL,
	Info4            	varchar(50)	NULL,
	InfoAd1			varchar(50)	NULL,
	InfoAd2			varchar(50)	NULL,
	InfoAd3			varchar(50)	NULL,
	InfoAd4			varchar(50)	NULL,
	InfoAd5			varchar(50)	NULL,
	InfoAd6			varchar(50)	NULL,
	InfoAd7			varchar(50)	NULL,
	InfoAd8			varchar(50)	NULL,
	Institucion		varchar(20)	NULL,
	InstitucionUsar		varchar(10)	NULL,
	Intermediario		varchar(20)	NULL,
	IntermediarioUsar	varchar(10)	NULL,
	Estatus			varchar(15)	NOT NULL,

	CONSTRAINT priBeneficiario PRIMARY KEY  CLUSTERED (Beneficiario)
  )  
  EXEC spSincroSemilla 'Beneficiario'
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Beneficiario' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre      ON dbo.Beneficiario (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Beneficiario' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente     ON dbo.Beneficiario (Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Beneficiario' AND sysindexes.name = 'Instrumento' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Instrumento ON dbo.Beneficiario (Instrumento)
go

EXEC spFK 'Beneficiario','Cliente','Cte','Cliente'
EXEC spFK 'Beneficiario','Instrumento','Instrumento','Instrumento'
GO

/****** Sugerir Costos por Categoria de Articulo ******/
if not exists(select * from SysTabla where SysTabla = 'SugerirCostoArtCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SugerirCostoArtCat','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.SugerirCostoArtCat') and type = 'U') 
CREATE TABLE dbo.SugerirCostoArtCat (
	Empresa			varchar(5)		NOT NULL,
	Categoria		varchar(20)	NOT NULL,
	Proveedor		varchar(10)	NOT NULL,
	Costo			float		NULL,

	CONSTRAINT priSugerirCostoArtCat PRIMARY KEY CLUSTERED (Empresa, Categoria, Proveedor)
)
GO
EXEC spALTER_COLUMN 'SugerirCostoArtCat', 'Costo', 'float NULL'
GO

EXEC spFK 'SugerirCostoArtCat','Proveedor','Prov','Proveedor'
GO

/****** CentroTipo ******/
if not exists(select * from SysTabla where SysTabla = 'CentroTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroTipo') and type = 'U') 
CREATE TABLE dbo.CentroTipo (
	Tipo		varchar(20)	NOT NULL,

	CONSTRAINT priCentroTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** EstacionTCat ******/
if not exists(select * from SysTabla where SysTabla = 'EstacionTCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EstacionTCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EstacionTCat') and type = 'U') 
CREATE TABLE dbo.EstacionTCat (
	Categoria		varchar(50) 	NOT NULL,

	CONSTRAINT priEstacionTCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** EstacionT ******/
if not exists(select * from SysTabla where SysTabla = 'EstacionT')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EstacionT','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EstacionT') and type = 'U') 
CREATE TABLE dbo.EstacionT (
	Estacion		varchar(10) 	NOT NULL,

	Centro			varchar(10) 	NULL,
	Categoria		varchar(50) 	NULL,

	Descripcion		varchar(100)	NULL,
	DiasSemana		int		NULL,
	TurnosDiarios		int		NULL,
	HorasTurno		float		NULL,
	Eficiencia		float		NULL		DEFAULT 100,
	Utilizacion		float		NULL		DEFAULT 100,
	DiasFestivos		bit		NOT NULL 	DEFAULT 0,

	CostoManoObra		float		NULL,
	CostoIndirectos		float		NULL,
	CostoMoneda		varchar(10)	NULL,
	ContUso			varchar(20)	NULL,

	Estatus			varchar(15) 	NOT NULL,
	TieneMovimientos	bit		NULL	 DEFAULT 0,


	CONSTRAINT priEstacionT PRIMARY KEY  CLUSTERED (Estacion)
)
GO
if not exists(select * from syscampo where tabla = 'EstacionT' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE EstacionT ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE EstacionT SET TieneMovimientos = 1")
END
GO
EXEC spALTER_TABLE 'EstacionT', 'ContUso', 'varchar(20)	NULL'
GO
EXEC spALTER_COLUMN 'EstacionT', 'CostoManoObra', 'float NULL'
EXEC spALTER_COLUMN 'EstacionT', 'CostoIndirectos', 'float NULL'
GO
EXEC spFK 'EstacionT','Centro','Centro','Centro'
EXEC spFK 'EstacionT','ContUso','CentroCostos','CentroCostos'
GO

/****** Centro ******/
if not exists(select * from SysTabla where SysTabla = 'Centro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Centro','Cuenta')
IF EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'Centro' AND Campo = 'TiempoEntrada') AND EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'Centro' AND Campo = 'TiempoCola')
  DROP TABLE dbo.Centro
GO
if not exists (select * from sysobjects where id = object_id('dbo.Centro') and type = 'U') 
CREATE TABLE dbo.Centro (
	Centro			varchar(10) 	NOT NULL,
	Tipo			varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,

	Estatus			varchar(15) 	NOT NULL,
	Almacen			varchar(10)	NULL,
	Orden			int		NULL,
	Autorizar		bit		NOT NULL 	DEFAULT 0,
	Cxp			bit		NOT NULL 	DEFAULT 0,
	Proveedor		varchar(10)	NULL,
	Impuesto1		float		NULL,
	Condicion		varchar(50)	NULL,
	CxpMov			varchar(20)	NULL,
	Concepto		varchar(50)	NULL,

	TiempoCola		float		NULL,
	TiempoEspera		float		NULL,

	CostoManoObra		float		NULL,
	CostoIndirectos		float		NULL,
	CostoMoneda		varchar(10)	NULL,
	ContUso			varchar(20)	NULL,

	DiasSemana		int		NULL,
	TurnosDiarios		int		NULL,
	HorasTurno		float		NULL,
	Eficiencia		float		NULL		DEFAULT 100,
	Utilizacion		float		NULL		DEFAULT 100,
	DiasFestivos		bit		NOT NULL 	DEFAULT 0,

	TieneMovimientos	bit		NULL	 	DEFAULT 0,

	Logico1			bit		NOT NULL 	DEFAULT 0,
	Logico2			bit		NOT NULL 	DEFAULT 0,
	Logico3			bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priCentro PRIMARY KEY  CLUSTERED (Centro)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCentroBC') and sysstat & 0xf = 8) drop trigger dbo.tgCentroBC
GO
if not exists(select * from syscampo where tabla = 'Centro' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Centro ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Centro SET TieneMovimientos = 1")
END
IF EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'Centro' AND Campo = 'TiempoEntrada') 
BEGIN
  EXEC("sp_rename 'Centro.TiempoEntrada', 'TiempoCola', 'COLUMN'")
  EXEC("ALTER TABLE Centro ALTER COLUMN TiempoCola float NULL")
END
IF EXISTS(SELECT * FROM sysCampo WHERE Tabla = 'Centro' AND Campo = 'TiempoSalida')
BEGIN
  EXEC("sp_rename 'Centro.TiempoSalida', 'TiempoEspera', 'COLUMN'")
  EXEC("ALTER TABLE Centro ALTER COLUMN TiempoEspera float NULL")
END
GO

EXEC spALTER_TABLE 'Centro', 'CxpMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Centro', 'ContUso', 'varchar(20)	NULL'
GO
EXEC spALTER_COLUMN 'Centro', 'CostoManoObra', 'float NULL'
EXEC spALTER_COLUMN 'Centro', 'CostoIndirectos', 'float NULL'
GO
EXEC spFK 'Centro','Proveedor','Prov','Proveedor'
EXEC spFK 'Centro','ContUso','CentroCostos','CentroCostos'
GO

CREATE TRIGGER tgCentroBC ON Centro
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ClaveNueva  	varchar(20),
    @ClaveAnterior	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaveNueva    = Centro FROM Inserted
  SELECT @ClaveAnterior = Centro FROM Deleted
  IF @ClaveNueva = @ClaveAnterior RETURN

  IF @ClaveNueva IS NULL
  BEGIN
    UPDATE EstacionT        SET Centro = NULL WHERE Centro = @ClaveAnterior
    DELETE CentroTarifa     WHERE Centro = @ClaveAnterior
    DELETE CentroMovimiento WHERE Centro = @ClaveAnterior OR CentroDestino = @ClaveAnterior
  END ELSE
  BEGIN
    UPDATE EstacionT SET Centro = @ClaveNueva WHERE Centro = @ClaveAnterior
    UPDATE CentroTarifa     SET Centro = @ClaveNueva WHERE Centro = @ClaveAnterior
    UPDATE CentroMovimiento SET Centro = @ClaveNueva WHERE Centro = @ClaveAnterior
    UPDATE CentroMovimiento SET CentroDestino = @ClaveNueva WHERE CentroDestino = @ClaveAnterior
  END
END
GO

/****** CentroMovimiento ******/
if not exists(select * from SysTabla where SysTabla = 'CentroMovimiento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroMovimiento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroMovimiento') and type = 'U') 
CREATE TABLE dbo.CentroMovimiento (
	Centro			varchar(10) 	NOT NULL,
	CentroDestino		varchar(10) 	NOT NULL,

	Tiempo			float		NULL,

	CONSTRAINT priCentroMovimiento PRIMARY KEY  CLUSTERED (Centro, CentroDestino)
)
GO

EXEC spFK 'CentroMovimiento','CentroDestino','Centro','Centro'
GO

/****** CentroTarifa ******/
if not exists(select * from SysTabla where SysTabla = 'CentroTarifa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CentroTarifa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CentroTarifa') and type = 'U') 
CREATE TABLE dbo.CentroTarifa (
	Centro			varchar(10) 	NOT NULL,
	Articulo		varchar(20) 	NOT NULL,
	SubCuenta		varchar(50)	NOT NULL DEFAULT '',

	Costo			float		NULL,

	CONSTRAINT priCentroTarifa PRIMARY KEY  CLUSTERED (Centro, Articulo, SubCuenta)
)
GO
if (select version from version)<=2424
BEGIN
  EXEC("spEliminarPK 'CentroTarifa'")
  EXEC("ALTER TABLE CentroTarifa ALTER COLUMN Articulo varchar(20) NOT NULL")
  EXEC("ALTER TABLE CentroTarifa ADD CONSTRAINT priCentroTarifa PRIMARY KEY  CLUSTERED (Centro, Articulo, SubCuenta)")
END
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'CentroTarifa' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'CentroTarifa'
  EXEC spALTER_COLUMN 'CentroTarifa', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE CentroTarifa ADD CONSTRAINT priCentroTarifa PRIMARY KEY  CLUSTERED (Centro, Articulo, SubCuenta)')
END
GO
EXEC spALTER_COLUMN 'CentroTarifa', 'Costo', 'float NULL'
GO
EXEC spFK 'CentroTarifa','Articulo','Art','Articulo'
EXEC spFK 'CentroTarifa','Centro','Centro','Centro'
GO

/****** ArtAlm ******/
if exists (select * from sysobjects where id = object_id('dbo.ArtAlm') and type = 'U') and not exists(select * from syscampo where tabla = 'ArtAlm' and Campo = 'Empresa')
  DROP TABLE ArtAlm
GO
if exists (select * from sysobjects where id = object_id('dbo.ArtAlm') and type = 'U') and 
   (select version from version) between 1100 and 1107
begin
  EXEC spLimpiarArtR
  DROP TABLE ArtAlm
end
GO

-- 60 Cuentas.sql
--EXEC spFK 'ArtAlm','Articulo','Art','Articulo'
--EXEC spFK 'ArtAlm','Almacen','Alm','Almacen'
--GO

if not exists(select * from SysTabla where SysTabla = 'ArtAlm')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtAlm','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAlm') and type = 'U') 
BEGIN
  EXEC("CREATE TABLE dbo.ArtAlm (
	Empresa		  varchar(5)	NOT NULL,
	Articulo	  varchar(20)	NOT NULL,
	SubCuenta	  varchar(50)	NOT NULL  DEFAULT '',
	Almacen		  varchar(10)	NOT NULL,

	Localizacion	  varchar(50) 	NULL,
        Pasillo		  varchar(50) 	NULL,
        Anaquel		  varchar(50) 	NULL,
        Estante		  varchar(50) 	NULL,
	Minimo 		  float 	NULL,
	Maximo 		  float 	NULL,
	PuntoOrden	  float 	NULL,
	PuntoOrdenOrdenar float 	NULL,

	LoteOrdenar	  	varchar(30)	NULL,
	CantidadOrdenar	  	float		NULL,
	MultiplosOrdenar  	float		NULL,
	CantidadOrdenarTiempo  	float		NULL,

	UltimoCambio 	  	datetime  	NULL,
	UltimoMovimiento  	datetime  	NULL,
	TieneMovimientos  	bit		NULL 	DEFAULT 0,
	AbastecimientoDirecto	bit		NULL 	DEFAULT 0,
	MinimoTarima		float		NULL,

	CONSTRAINT priArtAlm PRIMARY KEY  CLUSTERED (Articulo, SubCuenta, Almacen, Empresa)

  )")
  EXEC("IF exists(select * from sysobjects where id = object_id('dbo.ArtR') and type = 'U') INSERT ArtAlm (Empresa, Articulo, SubCuenta, Almacen, Localizacion, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar) SELECT Empresa, Articulo, SubCuenta, Almacen, Localizacion, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar FROM ArtR")
END
GO
EXEC spALTER_TABLE 'ArtAlm', 'Pasillo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtAlm', 'Anaquel', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtAlm', 'Estante', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtAlm', 'TieneMovimientos','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtAlm', 'LoteOrdenar', 'varchar(30) NULL'
EXEC spALTER_TABLE 'ArtAlm', 'CantidadOrdenar', 'float NULL'
EXEC spALTER_TABLE 'ArtAlm', 'MultiplosOrdenar', 'float	NULL'
EXEC spALTER_TABLE 'ArtAlm', 'UltimoMovimiento', 'datetime NULL'
EXEC spALTER_TABLE 'ArtAlm', 'CantidadOrdenarTiempo', 'float NULL'
EXEC spALTER_TABLE 'ArtAlm', 'AbastecimientoDirecto', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if exists(select * from SysTipoDatos WHERE Tabla = 'ArtAlm' AND Campo = 'SubCuenta' and Tamano=20)
BEGIN
  EXEC spEliminarPK 'ArtAlm'
  EXEC spALTER_COLUMN 'ArtAlm', 'SubCuenta', 'varchar(50) NOT NULL', '""'
  EXEC('ALTER TABLE ArtAlm ADD CONSTRAINT priArtAlm PRIMARY KEY  CLUSTERED (Articulo, SubCuenta, Almacen, Empresa)')
END
GO
EXEC spALTER_TABLE 'ArtAlm', 'MinimoTarima', 'float NULL'
GO

/* ArtAlmABCHist */
if not exists(select * from SysTabla where SysTabla = 'ArtAlmABCHist')
INSERT INTO SysTabla (SysTabla) VALUES ('ArtAlmABCHist')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAlmABCHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ArtAlmABCHist (
	Articulo		varchar(20)	NOT NULL,
	Almacen			varchar(10)	NOT NULL,
	Fecha			datetime	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	UltimoConteo		datetime	NULL,
	SiguienteConteo		datetime	NULL,

    	CONSTRAINT priArtAlmABCHist PRIMARY KEY  CLUSTERED (Articulo, Almacen, Fecha, ID)
  )
  EXEC spSincroSemilla 'ArtAlmABCHist'
END
GO

/****** ArtAlmABC ******/
if not exists(select * from SysTabla where SysTabla = 'ArtAlmABC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtAlmABC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtAlmABC') and type = 'U') 
CREATE TABLE dbo.ArtAlmABC (
	Articulo		varchar(20)	NOT NULL,
	Almacen			varchar(10)	NOT NULL,

	UltimoConteo		datetime	NULL,
	SiguienteConteo		datetime	NULL,

	CONSTRAINT priArtAlmABC PRIMARY KEY  CLUSTERED (Articulo, Almacen)
)
GO

EXEC spFK 'ArtAlmABC','Almacen','Alm','Almacen'
EXEC spFK 'ArtAlmABC','Articulo','Art','Articulo'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgArtAlmABCAC') and sysstat & 0xf = 8) drop trigger dbo.tgArtAlmABCAC
GO
CREATE TRIGGER tgArtAlmABCAC ON ArtAlmABC
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(UltimoConteo) OR UPDATE(SiguienteConteo)
  INSERT ArtAlmABCHist (Articulo, Almacen, Fecha,  UltimoConteo, SiguienteConteo)
           SELECT Articulo, Almacen, GETDATE(), UltimoConteo, SiguienteConteo
             FROM Inserted
END
GO

/****** Ruta  ******/
if not exists(select * from SysTabla where SysTabla = 'Ruta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Ruta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Ruta') and type = 'U') 
CREATE TABLE dbo.Ruta (
	Ruta			varchar(50)	NOT NULL,
	Zona			varchar(30)	NULL,

	TiempoEntrega		int		NULL,
	TiempoEntregaUnidad	varchar(10) 	NULL,

	Kms			float		NULL,
	Costo			float		NULL,
	SucursalD		int		NULL,
	SucursalA		int		NULL,

	CONSTRAINT priRuta PRIMARY KEY  CLUSTERED (Ruta)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRutaBC') and sysstat & 0xf = 8) drop trigger dbo.tgRutaBC
GO
EXEC spALTER_TABLE 'Ruta', 'Zona', 'varchar(30)	NULL'
EXEC spALTER_TABLE 'Ruta', 'TiempoEntrega', 'int NULL'
EXEC spALTER_TABLE 'Ruta', 'TiempoEntregaUnidad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Ruta', 'Kms', 'float NULL'
EXEC spALTER_TABLE 'Ruta', 'Costo', 'money NULL'
EXEC spDROP_COLUMN 'Ruta', 'AlmacenD'
EXEC spDROP_COLUMN 'Ruta', 'AlmacenA'
EXEC spALTER_TABLE 'Ruta', 'SucursalD', 'int NULL'
EXEC spALTER_TABLE 'Ruta', 'SucursalA', 'int NULL'
GO
EXEC spALTER_COLUMN 'Ruta', 'Costo', 'float NULL'
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgRutaBC ON Ruta
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RutaN  	varchar(50),
    @RutaA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @RutaN = Ruta FROM Inserted
  SELECT @RutaA = Ruta FROM Deleted
  IF @RutaN = @RutaA RETURN

  IF @RutaN IS NULL AND 
    EXISTS(SELECT * FROM Cte WHERE Ruta = @RutaA) OR EXISTS(SELECT * FROM CteEnviarA WHERE Ruta = @RutaA)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(@RutaA))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30155
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
  IF @RutaA IS NOT NULL 
  BEGIN
    UPDATE Cte SET Ruta = @RutaN WHERE Ruta = @RutaA
    UPDATE CteEnviarA SET Ruta = @RutaN WHERE Ruta = @RutaA
    UPDATE CodigoPostal SET Ruta = @RutaN WHERE Ruta = @RutaA
  END 
END
GO

/****** Tipos de Reportes ******/
if not exists(select * from SysTabla where SysTabla = 'RepTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RepTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RepTipo') and type = 'U') 
CREATE TABLE dbo.RepTipo (
	Tipo 		varchar(50) 	NOT NULL,

	Responsable	varchar(10)	NULL,

	CONSTRAINT priRepTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO
EXEC spALTER_TABLE 'RepTipo', 'Responsable','char(10) NULL'
GO

/****** Categorias de Reportes ******/
if not exists(select * from SysTabla where SysTabla = 'RepCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RepCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RepCat') and type = 'U') 
CREATE TABLE dbo.RepCat (
	Categoria 		varchar(50) 	NOT NULL,

	CONSTRAINT priRepCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** Grupos de Reportes ******/
if not exists(select * from SysTabla where SysTabla = 'RepGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RepGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RepGrupo') and type = 'U') 
CREATE TABLE dbo.RepGrupo (
	Grupo 		varchar(50) 	NOT NULL,

	CONSTRAINT priRepGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/****** Familias de Reportes ******/
if not exists(select * from SysTabla where SysTabla = 'RepFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RepFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RepFam') and type = 'U') 
CREATE TABLE dbo.RepFam (
	Familia		varchar(50) 	NOT NULL,

	CONSTRAINT priRepFam PRIMARY KEY  CLUSTERED (Familia)
)
GO

/****** Reportes  ******/
if not exists(select * from SysTabla where SysTabla = 'Rep')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Rep','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Rep') and type = 'U') 
CREATE TABLE dbo.Rep (
	Reporte	 		varchar(20) 	NOT NULL,

	Asunto			varchar(255)    NULL,
	Tipo			varchar(25)	NULL,
	Categoria 		varchar(50) 	NULL,
	Grupo	 		varchar(50)	NULL,
	Familia 		varchar(50) 	NULL,

	Estatus 		varchar(15) 	NULL,
	Alta			datetime	NULL,
        NivelAcceso		varchar(50)	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Problema		text		NULL,
	Solucion		text		NULL,
	Comentarios		text		NULL,

	Cliente			varchar(10)	NULL,
	EnviarA			int	   	NULL,
	Proveedor		varchar(10)	NULL,
	Personal		varchar(10)	NULL,
	Agente  		varchar(10)   	NULL,
	VIN			varchar(20)	NULL,
	Proyecto		varchar(50)	NULL,
	UEN			int	 	NULL,
	Empresa			varchar(5)		NULL,
	Sucursal		int		NULL,

	Responsable		varchar(10)	NULL,
	Desarrollador		varchar(10)	NULL,
	UltimoCambio 		datetime  	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	FechaEmision		datetime	NULL,
	FechaRequerida		datetime	NULL,
	FechaBaja		datetime	NULL,
	FechaAutorizacion	datetime	NULL,
	FechaEstimada		datetime	NULL,
	FechaEntrega		datetime	NULL,

	EsperandoRespuesta	bit		NULL	DEFAULT 0,

	CONSTRAINT priRep PRIMARY KEY  CLUSTERED (Reporte)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgRepABC') and sysstat & 0xf = 8) drop trigger dbo.tgRepABC
GO
EXEC spALTER_TABLE 'Rep', 'TieneMovimientos', 'bit NULL	DEFAULT 0 WITH VALUES'
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Rep' AND sysindexes.name = 'Asunto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Asunto ON dbo.Rep (Asunto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Rep' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.Rep (Cliente)
go
EXEC spALTER_TABLE 'Rep', 'FechaEmision', 'datetime NULL'
EXEC spALTER_TABLE 'Rep', 'FechaRequerida', 'datetime NULL'
EXEC spALTER_TABLE 'Rep', 'FechaBaja', 'datetime NULL'
go
if (select version from version)<=2682 and exists(select * from syscampo where tabla ='Rep' and campo = 'Usuario')
  exec sp_rename 'Rep.Usuario', 'Responsable', 'COLUMN'
go
EXEC spALTER_TABLE 'Rep', 'EsperandoRespuesta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Rep', 'FechaAutorizacion', 'datetime NULL'
EXEC spALTER_TABLE 'Rep', 'FechaEstimada', 'datetime NULL'
EXEC spALTER_TABLE 'Rep', 'FechaEntrega', 'datetime NULL'
EXEC spALTER_TABLE 'Rep', 'Desarrollador','varchar(10) NULL'
EXEC spALTER_TABLE 'Rep', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Rep', 'SituacionNota', 'varchar(100) NULL'
go

EXEC spFK2 'Rep','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'Rep','Cliente','Cte','Cliente'
EXEC spFK 'Rep','Proveedor','Prov','Proveedor'
EXEC spFK 'Rep','Personal','Personal','Personal'
EXEC spFK 'Rep','Agente','Agente','Agente'
EXEC spFK 'Rep','VIN','VIN','VIN'
EXEC spFK 'Rep','Proyecto','Proy','Proyecto'
EXEC spFK 'Rep','UEN','UEN','UEN'
EXEC spFK 'Rep','Sucursal','Sucursal','Sucursal'
GO

CREATE TRIGGER tgRepABC ON Rep
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Reporte		varchar(20),
    @EstatusA		varchar(15),
    @EstatusN		varchar(15),
    @SituacionA		varchar(50),
    @SituacionN		varchar(50),
    @Responsable	varchar(10),
    @Ahora 		datetime,
    @FechaInicio	datetime,
    @FechaAnterior	datetime
 
  IF dbo.fnEstaSincronizando() = 1 RETURN
   
  SELECT @EstatusA = Estatus, @SituacionA = Situacion FROM Deleted
  SELECT @EstatusN = Estatus, @SituacionN = Situacion, @Reporte = Reporte, @Responsable = Responsable FROM Inserted
  IF ISNULL(@EstatusA, '') <> ISNULL(@EstatusN, '') OR ISNULL(@SituacionA, '') <> ISNULL(@SituacionN, '')
  BEGIN
    SELECT @Ahora = GETDATE(), @FechaInicio = NULL
    SELECT @FechaInicio = MIN(FechaInicio), @FechaAnterior = MAX(FechaComenzo) FROM CtaTiempo WHERE Rama = 'REP' AND Cuenta = @Reporte
    IF @FechaAnterior IS NOT NULL
      UPDATE CtaTiempo SET FechaTermino = @Ahora WHERE Rama = 'REP' AND Cuenta = @Reporte AND FechaComenzo = @FechaAnterior

    INSERT INTO CtaTiempo (Rama,  Cuenta,   Usuario,      FechaInicio,  FechaComenzo, Estatus,   Situacion) 
                   VALUES ('REP', @Reporte, @Responsable, @FechaInicio, @Ahora,       @EstatusN, @SituacionN)
  END
END
GO
-- select * from ctatiempo

/****** Conversacion ******/
if not exists(select * from SysTabla where SysTabla = 'RepConversacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RepConversacion','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.RepConversacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RepConversacion (
	Reporte	 		varchar(20) 	NOT NULL,
	ID			int		NOT NULL	 IDENTITY(1,1),

	FechaHora		datetime	NULL	DEFAULT GETDATE(),
	Contacto		varchar(50)	NULL,
	Mensaje			text		NULL,
	EsperandoRespuesta	bit		NULL	DEFAULT 0,
	
	CONSTRAINT priRepConversacion PRIMARY KEY  CLUSTERED (Reporte, ID)
  )
  EXEC spSincroSemilla 'RepConversacion'
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRepConversacionA') and sysstat & 0xf = 8) drop trigger dbo.tgRepConversacionA
GO
EXEC spALTER_TABLE 'RepConversacion', 'EsperandoRespuesta', 'bit NULL DEFAULT 0 WITH VALUES'
GO
CREATE TRIGGER tgRepConversacionA ON RepConversacion
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  DECLARE
    @Reporte		varchar(20),
    @EsperandoRespuesta bit

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Reporte = Reporte, @EsperandoRespuesta = EsperandoRespuesta FROM Inserted
  UPDATE Rep SET EsperandoRespuesta = @EsperandoRespuesta WHERE Reporte = @Reporte
END
GO


/****** Categorias ******/
if not exists(select * from SysTabla where SysTabla = 'SocioCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SocioCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SocioCat') and type = 'U') 
CREATE TABLE dbo.SocioCat (
	Categoria 		varchar(50) 	NOT NULL,

	CategoriaMaestra	varchar(50)	NULL,
	Icono			int	  	NULL,


	CONSTRAINT priSocioCat PRIMARY KEY CLUSTERED (Categoria)
)

/****** Grupos ******/
if not exists(select * from SysTabla where SysTabla = 'SocioGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SocioGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SocioGrupo') and type = 'U') 
CREATE TABLE dbo.SocioGrupo (
	Grupo	 		varchar(50) 	NOT NULL,

	CONSTRAINT priSocioGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** Familias ******/
if not exists(select * from SysTabla where SysTabla = 'SocioFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SocioFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SocioFam') and type = 'U') 
CREATE TABLE dbo.SocioFam (
	Familia	 		varchar(50) 	NOT NULL,

	CONSTRAINT priSocioFam PRIMARY KEY CLUSTERED (Familia)
)
GO


/****** Socios ******/
if exists (select * from sysobjects where id = object_id('dbo.Socio') and type = 'V') drop view dbo.Socio
GO
if not exists(select * from SysTabla where SysTabla = 'Socio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Socio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Socio') and type = 'U') 
CREATE TABLE dbo.Socio (
	Socio	 		varchar(10)  	NOT NULL,

	Nombre 			varchar(100) 	NULL,
	Telefonos 		varchar(100) 	NULL,
	Extencion		varchar(10) 	NULL,
        Categoria		varchar(50) 	NULL,
        Grupo       		varchar(50) 	NULL,
	Familia			varchar(50) 	NULL,
	Zona			varchar(30)     NULL,

	Estatus			varchar(15) 	NOT NULL,
	UltimoCambio		datetime  	NULL,
	Clase			varchar(15)	NULL,
	Alta			datetime	NULL,
	Baja			datetime	NULL,

	Direccion 		varchar(100) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	RFC			varchar(20)	NULL,
	CURP			varchar(30)	NULL,
	TieneMovimientos	bit		NULL		DEFAULT 0,
        NivelAcceso		varchar(50)	NULL,

	Cliente			varchar(10)	NULL,
	Acreedor		varchar(10)	NULL,
	eMail			varchar(50) 	NULL,

	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision		float		NULL,
    MapaUbicacion       varchar(100)NULL,


	CONSTRAINT priSocio PRIMARY KEY  CLUSTERED (Socio)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Socio' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.Socio (Nombre)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Socio' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.Socio (Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Socio' AND sysindexes.name = 'Acreedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Acreedor ON dbo.Socio (Acreedor)
go

EXEC spAlter_Table 'Socio','MapaLatitud','float NULL'
EXEC spAlter_Table 'Socio','MapaLongitud','float NULL'
EXEC spAlter_Table 'Socio','MapaPrecision','float NULL'
EXEC spAlter_Table 'Socio','MapaUbicacion','varchar(100) NULL'
GO

EXEC spFK 'Socio','Cliente','Cte','Cliente'
GO

/****** TituloTipo ******/
if not exists(select * from SysTabla where SysTabla = 'TituloTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TituloTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TituloTipo') and type = 'U') 
CREATE TABLE dbo.TituloTipo (
	Tipo		varchar(20) 	NOT NULL,

	CONSTRAINT priTituloTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO


/****** TituloHist ******/
if not exists(select * from SysTabla where SysTabla = 'TituloHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TituloHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.TituloHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.TituloHist (
	Titulo	 		varchar(10)  	NOT NULL,
        ID                      int        	NOT NULL IDENTITY(1,1),

	Fecha                   datetime   	NULL,
	Valor			float     	NULL,

	CONSTRAINT priTituloHist PRIMARY KEY CLUSTERED (Titulo, ID)
  )
  EXEC spSincroSemilla 'TituloHist'
END
GO
EXEC spADD_INDEX 'TituloHist', 'Fecha', 'Titulo, Fecha'
GO

EXEC spDROP_TABLE 'Titulo', 2883
GO

/****** Titulo ******/
if not exists(select * from SysTabla where SysTabla = 'Titulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Titulo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Titulo') and type = 'U') 
CREATE TABLE dbo.Titulo (
	Titulo	 		varchar(10)  	NOT NULL,

	Nombre 			varchar(100) 	NULL,
	Serie			varchar(10)	NULL,
	Tipo			varchar(20)	NULL,
	Valor			float		NULL,

	Estatus			varchar(15) 	NOT NULL,	
	Fecha			datetime	NULL,

	CONSTRAINT priTitulo PRIMARY KEY  CLUSTERED (Titulo)
)
go

EXEC spALTER_TABLE 'Titulo', 'Fecha', 'datetime NULL'
GO
-- Aqui va el Matenimiento a la tabla

if exists (select * from sysobjects where id = object_id('dbo.tgTituloAC') and sysstat & 0xf = 8) drop trigger dbo.tgTituloAC
GO
CREATE TRIGGER tgTituloAC ON Titulo
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @TituloN	varchar(10),
    @FechaN	datetime,
    @ValorN	float,
    @ValorA	float

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ValorA = Valor FROM Deleted
  SELECT @TituloN = Titulo, @FechaN = Fecha, @ValorN = Valor FROM Inserted

  IF UPDATE(Valor) AND ISNULL(@ValorN, 0.0) <> ISNULL(@ValorA, 0.0)
    INSERT INTO TituloHist (Titulo, Valor, Fecha) VALUES (@TituloN, @ValorN, @FechaN)
END
GO

-- drop table Layout
/****** Layout ******/
if not exists(select * from SysTabla where SysTabla = 'Layout')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Layout','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Layout') and type = 'U') 
CREATE TABLE dbo.Layout (
	Layout	 		varchar(50)  	NOT NULL,

	Nombre			varchar(100)	NULL,
	Formato			varchar(20)	NULL,	-- Ancho Fijo / Separador
	IDLista			varchar(20)	NULL,	-- N/A, Cada Registro / Comienzo - Fin
	Separador		varchar(10)	NULL,
	TextosEntreComillas	bit		NULL	DEFAULT 0,
	VerTipoDatos		bit		NULL	DEFAULT 0,
	Codificacion		varchar(20)	NULL,	-- UTF-8, ANSI, etc.
	InsertarVacios		bit		NULL	DEFAULT 0,
	TieneEstructura		bit		NULL	DEFAULT 0,

	CONSTRAINT priLayout PRIMARY KEY  CLUSTERED (Layout)
)
go
EXEC spALTER_TABLE 'Layout', 'Nombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Layout', 'VerTipoDatos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Layout', 'Codificacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Layout', 'IDLista', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Layout', 'InsertarVacios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Layout', 'TieneEstructura', 'bit NULL DEFAULT 0 WITH VALUES'
go

-- drop table LayoutLista
-- proyectod
/****** LayoutLista ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutLista') and type = 'U') 
CREATE TABLE dbo.LayoutLista (
	Layout	 		varchar(50)  	NOT NULL,
	Lista			varchar(50)  	NOT NULL,

	Nombre			varchar(100)	NULL,
	IDRegistro		varchar(100)	NULL,
	IDRegistroPosicion	int		NULL,
	IDRegistro2		varchar(100)	NULL,
	IDRegistro2Posicion	int		NULL,
	IDComienzo		varchar(100)	NULL,
	IDComienzoPosicion	int		NULL,
	IDFin			varchar(100)	NULL,
	IDFinPosicion		int		NULL,
	
	Orden			int		NULL,

	CONSTRAINT priLayoutLista PRIMARY KEY  CLUSTERED (Layout, Lista)
)
go
EXEC spALTER_TABLE 'LayoutLista', 'IDRegistro2', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'LayoutLista', 'IDRegistro2Posicion', 'int NULL'
go

-- drop table LayoutCampo
/****** LayoutCampo ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutCampo') and type = 'U') 
CREATE TABLE dbo.LayoutCampo (
	Layout	 		varchar(50)  	NOT NULL,
	Lista			varchar(50)  	NOT NULL,
	Campo			varchar(50)  	NOT NULL,

	Orden			int		NULL,
	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Posicion		varchar(20)	NULL,
	Tamano			varchar(20)	NULL,	-- 1, 2, 3.. n, 'Leyenda', <Tab>, <CR>, (Fin Linea), (Linea Vacia), (Fin Archivo)
	TipoDatos		varchar(20)	NULL,
	Mayusculas		bit		NULL	DEFAULT 0,
	Minusculas		bit		NULL	DEFAULT 0,
	DividirEntre100		bit		NULL	DEFAULT 0,
	CDATA			bit		NULL	DEFAULT 0,
	TieneSubCampos		bit		NULL	DEFAULT 0,

	CONSTRAINT priLayoutCampo PRIMARY KEY  CLUSTERED (Layout, Lista, Campo)
)
go
EXEC spALTER_TABLE 'LayoutCampo', 'Mayusculas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LayoutCampo', 'Minusculas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LayoutCampo', 'DividirEntre100' ,'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LayoutCampo', 'TieneSubCampos', 'bit NULL DEFAULT 0 WITH VALUES'
go
ALTER TABLE LayoutCampo ALTER COLUMN Posicion varchar(20) NULL
GO
-- select * from layoutcampo
/****** LayoutCampoValor ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutCampoValor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutCampoValor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutCampoValor') and type = 'U') 
CREATE TABLE dbo.LayoutCampoValor (
	Layout	 		varchar(50)  	NOT NULL,
	Lista			varchar(50)  	NOT NULL,
	Campo			varchar(50)  	NOT NULL,
	Valor			varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priLayoutCampoValor PRIMARY KEY  CLUSTERED (Layout, Lista, Campo, Valor)
)
go

/****** LayoutSubCampo ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutSubCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutSubCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutSubCampo') and type = 'U') 
CREATE TABLE dbo.LayoutSubCampo (
	Layout	 		varchar(50)  	NOT NULL,
	Lista			varchar(50)  	NOT NULL,
	Campo			varchar(50)  	NOT NULL,
	SubCampo		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Posicion		varchar(20)	NULL,
	Tamano			varchar(20)	NULL,	-- 1, 2, 3.. n, 'Leyenda', <Tab>, <CR>, (Fin Linea), (Linea Vacia), (Fin Archivo)
	TipoDatos		varchar(20)	NULL,
	Mayusculas		bit		NULL	DEFAULT 0,
	Minusculas		bit		NULL	DEFAULT 0,
	DividirEntre100		bit		NULL	DEFAULT 0,
	CDATA			bit		NULL	DEFAULT 0,

	CONSTRAINT priLayoutSubCampo PRIMARY KEY  CLUSTERED (Layout, Lista, Campo, SubCampo)
)
go
ALTER TABLE LayoutSubCampo ALTER COLUMN Posicion varchar(20) NULL
GO

/****** LayoutSubCampoValor ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutSubCampoValor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutSubCampoValor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutSubCampoValor') and type = 'U') 
CREATE TABLE dbo.LayoutSubCampoValor (
	Layout	 		varchar(50)  	NOT NULL,
	Lista			varchar(50)  	NOT NULL,
	Campo			varchar(50)  	NOT NULL,
	SubCampo		varchar(50)  	NOT NULL,
	Valor			varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priLayoutSubCampoValor PRIMARY KEY  CLUSTERED (Layout, Lista, Campo, SubCampo, Valor)
)
go

if exists (select * from sysobjects where id = object_id('dbo.tgLayoutSubCampoBC') and sysstat & 0xf = 8) drop trigger dbo.tgLayoutSubCampoBC
GO
CREATE TRIGGER tgLayoutSubCampoBC ON LayoutSubCampo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @LayoutA	varchar(50),
    @LayoutN	varchar(50),
    @ListaA	varchar(50),
    @ListaN	varchar(50),
    @CampoA	varchar(50),
    @CampoN	varchar(50),
    @SubCampoA	varchar(50),
    @SubCampoN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @LayoutA = Layout, @ListaA = Lista, @CampoA = Campo, @SubCampoA = SubCampo FROM Deleted
  SELECT @LayoutN = Layout, @ListaN = Lista, @CampoN = Campo, @SubCampoN = SubCampo FROM Inserted

  IF @SubCampoA = @SubCampoN RETURN
  
  IF @SubCampoN IS NULL
  BEGIN
    DELETE LayoutSubCampoValor WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA AND SubCampo = @SubCampoA
  END ELSE
  BEGIN
    UPDATE LayoutSubCampoValor SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA AND SubCampo = @SubCampoA
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgLayoutCampoBC') and sysstat & 0xf = 8) drop trigger dbo.tgLayoutCampoBC
GO
CREATE TRIGGER tgLayoutCampoBC ON LayoutCampo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @LayoutA	varchar(50),
    @LayoutN	varchar(50),
    @ListaA	varchar(50),
    @ListaN	varchar(50),
    @CampoA	varchar(50),
    @CampoN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @LayoutA = Layout, @ListaA = Lista, @CampoA = Campo FROM Deleted
  SELECT @LayoutN = Layout, @ListaN = Lista, @CampoN = Campo FROM Inserted

  IF @CampoA = @CampoN RETURN
  
  IF @CampoN IS NULL
  BEGIN
    DELETE LayoutCampoValor    WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
    DELETE LayoutSubCampo      WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
    DELETE LayoutSubCampoValor WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
  END ELSE
  BEGIN
    UPDATE LayoutCampoValor    SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
    UPDATE LayoutSubCampo      SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
    UPDATE LayoutSubCampoValor SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA AND Campo = @CampoA
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgLayoutListaBC') and sysstat & 0xf = 8) drop trigger dbo.tgLayoutListaBC
GO
CREATE TRIGGER tgLayoutListaBC ON LayoutLista
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @LayoutA	varchar(50),
    @LayoutN	varchar(50),
    @ListaA	varchar(50),
    @ListaN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @LayoutA = Layout, @ListaA = Lista FROM Deleted
  SELECT @LayoutN = Layout, @ListaN = Lista FROM Inserted

  IF @ListaA = @ListaN RETURN
  
  IF @ListaN IS NULL
  BEGIN
    DELETE LayoutCampo         WHERE Layout = @LayoutA AND Lista = @ListaA
    DELETE LayoutCampoValor    WHERE Layout = @LayoutA AND Lista = @ListaA
    DELETE LayoutSubCampo      WHERE Layout = @LayoutA AND Lista = @ListaA
    DELETE LayoutSubCampoValor WHERE Layout = @LayoutA AND Lista = @ListaA
  END ELSE
  BEGIN
    UPDATE LayoutCampo         SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA
    UPDATE LayoutCampoValor    SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA
    UPDATE LayoutSubCampo      SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA
    UPDATE LayoutSubCampoValor SET Lista = @ListaN WHERE Layout = @LayoutA AND Lista = @ListaA
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgLayoutBC') and sysstat & 0xf = 8) drop trigger dbo.tgLayoutBC
GO
CREATE TRIGGER tgLayoutBC ON Layout
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @LayoutA	varchar(50),
    @LayoutN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @LayoutA = Layout FROM Deleted
  SELECT @LayoutN = Layout FROM Inserted

  IF @LayoutA = @LayoutN RETURN
  
  IF @LayoutN IS NULL
  BEGIN
    DELETE LayoutLista         WHERE Layout = @LayoutA
    DELETE LayoutCampo         WHERE Layout = @LayoutA
    DELETE LayoutCampoValor    WHERE Layout = @LayoutA
    DELETE LayoutSubCampo      WHERE Layout = @LayoutA
    DELETE LayoutSubCampoValor WHERE Layout = @LayoutA
  END ELSE
  BEGIN
    UPDATE LayoutLista         SET Layout = @LayoutN WHERE Layout = @LayoutA
    UPDATE LayoutCampo         SET Layout = @LayoutN WHERE Layout = @LayoutA
    UPDATE LayoutCampoValor    SET Layout = @LayoutN WHERE Layout = @LayoutA
    UPDATE LayoutSubCampo      SET Layout = @LayoutN WHERE Layout = @LayoutA
    UPDATE LayoutSubCampoValor SET Layout = @LayoutN WHERE Layout = @LayoutA
  END
END
GO

-- select * from LayoutDatos
-- drop table LayoutDatos
if exists (select * from sysobjects where id = object_id('dbo.LayoutDatos') and type = 'U') and not exists(select * from syscampo where tabla = 'LayoutDatos' and campo='SubCampo')
  drop table LayoutDatos
go
/****** LayoutDatos ******/
if not exists(select * from SysTabla where SysTabla = 'LayoutDatos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LayoutDatos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LayoutDatos') and type = 'U') 
CREATE TABLE dbo.LayoutDatos (
	ArchivoID		int		NOT NULL,
	RID			int		NOT NULL  IDENTITY(1,1),

	Layout	 		varchar(50)  	NULL,
	Lista			varchar(255)  	NULL,	-- 255 por la posible estructura
	Registro		int		NULL,
	Campo			varchar(50)  	NULL,
	SubCampo		varchar(50)  	NULL,

	Valor			varchar(7500)	NULL,

	CONSTRAINT priLayoutDatos PRIMARY KEY  CLUSTERED (ArchivoID, RID)
)
GO
EXEC spADD_INDEX 'LayoutDatos', 'Orden', 'Registro, ArchivoID'
GO


/*** CalificacionTipo ***/
if not exists(select * from SysTabla where SysTabla = 'CalificacionTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CalificacionTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CalificacionTipo') and type = 'U') 
CREATE TABLE dbo.CalificacionTipo (
	Tipo		varchar(50)	NOT NULL,

	CONSTRAINT priCalificacionTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

-- drop table CalificacionTipoD
/*** CalificacionTipoD ***/
if not exists(select * from SysTabla where SysTabla = 'CalificacionTipoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CalificacionTipoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CalificacionTipoD') and type = 'U') 
CREATE TABLE dbo.CalificacionTipoD (
	Tipo		varchar(50)	NOT NULL,
	Calificacion	varchar(50)	NOT NULL,

	Valor		float		NULL,
	Orden		int		NULL,

	CONSTRAINT priCalificacionTipoD PRIMARY KEY  CLUSTERED (Tipo, Calificacion)
)
GO

EXEC spDROP_TABLE 'Libro', 3023
EXEC spDROP_TABLE 'LibroD', 3023
EXEC spDROP_TABLE 'TemaCat', 3023
EXEC spDROP_TABLE 'TemaGrupo', 3023
EXEC spDROP_TABLE 'TemaFam', 3023
GO


EXEC spDROP_TABLE 'Cat', 3039
EXEC spDROP_TABLE 'CatD', 3039
EXEC spDROP_TABLE 'CatDExtra', 3039
GO

/****** Cat ******/
if not exists(select * from SysTabla where SysTabla = 'Cat')
  INSERT INTO SysTabla (SysTabla) VALUES ('Cat')
if exists (select * from sysobjects where id = object_id('dbo.Cat') and type = 'U')
  DROP TABLE dbo.Cat
GO
CREATE TABLE dbo.Cat (
      Catalogo                varchar(50)       NOT NULL,

      Titulo                  varchar(100)      NULL,
      Estatus                 varchar(15)       NULL,
      UltimoCambio            datetime          NULL,
      Alta                    datetime          NULL,
      Usuario                 varchar(10)       NULL,

      AutoRetrocederInicio    bit               NULL  DEFAULT 0,
      RutaImagenes            varchar(255)      NULL,
      CarritoSiempreVisible   bit               NULL  DEFAULT 0,
      ConfirmarAlEnviar       bit               NULL  DEFAULT 0,

      Renglones               int               NULL,
      Columnas                int               NULL,
      CapturaCodigo           bit               NULL  DEFAULT 0,
      EtiquetaCodigo          varchar(100)      NULL,
      CapturaSubCodigo        bit               NULL  DEFAULT 0,
      EtiquetaSubCodigo       varchar(100)      NULL,
      CapturaCantidad         bit               NULL  DEFAULT 0,
      EtiquetaCantidad        varchar(100)      NULL,

      ActualizarFrecuencia    float             NULL,
      FrecuenciaUnidad        varchar(20)       NULL,

      BotonAnchoAlto          int               NULL  DEFAULT 65,
      Inicio                  varchar(20)       NULL,
      TamanoEsp               bit               NULL  DEFAULT 0,

      CONSTRAINT priCat PRIMARY KEY CLUSTERED (Catalogo)
  )
GO

/****** CatD ******/
if not exists(select * from SysTabla where SysTabla = 'CatD')
  INSERT INTO SysTabla (SysTabla) VALUES ('CatD')
if exists (select * from sysobjects where id = object_id('dbo.CatD') and type = 'U')
  DROP TABLE dbo.CatD
GO
CREATE TABLE dbo.CatD (
      Catalogo                varchar(50)       NOT NULL,
      Pagina                  varchar(20)       NOT NULL,

      Orden                   varchar(100)      NULL,
      Nombre                  varchar(100)      NULL,

      CONSTRAINT priCatD PRIMARY KEY CLUSTERED (Catalogo, Pagina)
  )
GO

/****** CatDBoton ******/
if not exists(select * from SysTabla where SysTabla = 'CatDBoton')
  INSERT INTO SysTabla (SysTabla) VALUES ('CatDBoton')
if exists (select * from sysobjects where id = object_id('dbo.CatDBoton') and type = 'U')
  DROP TABLE dbo.CatDBoton
GO
CREATE TABLE dbo.CatDBoton (
      Catalogo                varchar(50)       NOT NULL,
      Pagina                  varchar(20)       NOT NULL,
      Boton                   varchar(5)        NOT NULL,

      Ancho                   int               NULL  DEFAULT 1,
      Alto                    int               NULL  DEFAULT 1,

      Etiqueta                varchar(100)      NULL,
      EtiquetaCantidad        float             NULL,
      EtiquetaImporte         money             NULL,
      Descripcion             varchar(255)      NULL,
      Liga                    varchar(20)       NULL,
      AutoRetroceder          bit               NULL  DEFAULT 0,

      Color                   varchar(50)       NULL,
      Negritas                bit               NULL  DEFAULT 0,
      Italicas                bit               NULL  DEFAULT 0,
      Tachado                 bit               NULL  DEFAULT 0,

      Bloqueado               bit               NULL  DEFAULT 0,
      Imagen                  varchar(100)      NULL,

      Tipo                    varchar(20)       NULL,
      Codigo                  varchar(100)      NULL,
      SubCodigo               varchar(100)      NULL,
      Cantidad                float             NULL,
      Importe                 money             NULL,
      Fecha                   datetime          NULL,
      Referencia              varchar(50)       NULL,
      Concepto                varchar(50)       NULL,

      CONSTRAINT priCatDBoton PRIMARY KEY CLUSTERED (Catalogo, Pagina, Boton)
  )
GO

/****** CatDBotonExtra ******/
if not exists(select * from SysTabla where SysTabla = 'CatDBotonExtra')
  INSERT INTO SysTabla (SysTabla) VALUES ('CatDBotonExtra')
if exists (select * from sysobjects where id = object_id('dbo.CatDBotonExtra') and type = 'U')
  DROP TABLE dbo.CatDBotonExtra
GO
CREATE TABLE dbo.CatDBotonExtra (
      Catalogo                varchar(50)       NOT NULL,
      Pagina                  varchar(20)       NOT NULL,
      Boton                   varchar(5)        NOT NULL,
      Campo                   varchar(100)      NOT NULL,

      Nombre                  varchar(100)      NULL,
      Tipo                    varchar(20)       NULL,
      Orden                   int               NULL,

      CONSTRAINT priCatDBotonExtra PRIMARY KEY CLUSTERED (Catalogo, Pagina, Boton, Campo)
  )
GO

if not exists (select * from sysobjects where id = object_id('dbo.CteArtEmpaque ') and type = 'U') --drop table CteArtEmpaque
  CREATE TABLE dbo.CteArtEmpaque (
	Cliente					varchar(10),
	Articulo				varchar(20),
	Empaque					varchar(20) NULL,
	Corrugado				varchar(20) NOT NULL,
	MedidaCorrugadoLargo	float		NULL,
	MedidaCorrugadoAncho	float		NULL,
	MedidaCorrugadoAlto		float		NULL,
	PzasCorrugado			int			NULL,
	Cama					int			NULL,
	CamasNumero				int			NULL,
	CodigoBarras			varchar(30) NULL
CONSTRAINT priCteArtEmpaque PRIMARY KEY CLUSTERED (Cliente,Articulo)
  )

if exists (select * from sysobjects where id = object_id('dbo.tgCatBC') and sysstat & 0xf = 8)
  drop trigger dbo.tgCatBC
GO
CREATE TRIGGER tgCatBC ON Cat
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CatalogoN  varchar(50),
    @CatalogoA    varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CatalogoN  = Catalogo FROM Inserted
  SELECT @CatalogoA  = Catalogo FROM Deleted

  IF @CatalogoA = @CatalogoN RETURN

  IF @CatalogoN IS NULL
  BEGIN
    DELETE CatD           WHERE Catalogo = @CatalogoA
    DELETE CatDBoton      WHERE Catalogo = @CatalogoA
    DELETE CatDBotonExtra WHERE Catalogo = @CatalogoA
  END ELSE
  BEGIN
    UPDATE CatD           SET Catalogo = @CatalogoN WHERE Catalogo = @CatalogoA
    UPDATE CatDBoton      SET Catalogo = @CatalogoN WHERE Catalogo = @CatalogoA
    UPDATE CatDBotonExtra SET Catalogo = @CatalogoN WHERE Catalogo = @CatalogoA
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCatDBC') and sysstat & 0xf = 8)
  drop trigger dbo.tgCatDBC
GO
CREATE TRIGGER tgCatDBC ON CatD
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CatalogoN  varchar(20),
    @CatalogoA    varchar(20),
    @PaginaN      varchar(20),
    @PaginaA      varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CatalogoN  = Catalogo, @PaginaN = Pagina FROM Inserted
  SELECT @CatalogoA  = Catalogo, @PaginaA = Pagina FROM Deleted

  IF @CatalogoA = @CatalogoN AND @PaginaA = @PaginaN RETURN

  IF @PaginaN IS NULL
  BEGIN
    DELETE CatDBoton      WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA
    DELETE CatDBotonExtra WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA
  END ELSE
  BEGIN
    UPDATE CatDBoton      SET Catalogo = @CatalogoN, Pagina = @PaginaN WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA
    UPDATE CatDBotonExtra SET Catalogo = @CatalogoN, Pagina = @PaginaN WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCatDBotonBC') and sysstat & 0xf = 8)
  drop trigger dbo.tgCatDBotonBC
GO
CREATE TRIGGER tgCatDBotonBC ON CatDBoton
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CatalogoN  varchar(20),
    @CatalogoA    varchar(20),
    @PaginaN      varchar(20),
    @PaginaA      varchar(20),
    @BotonN varchar(5),
    @BotonA varchar(5)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CatalogoN  = Catalogo, @PaginaN = Pagina, @BotonN = Boton FROM Inserted
  SELECT @CatalogoA  = Catalogo, @PaginaA = Pagina, @BotonA = Boton FROM Deleted

  IF @CatalogoA = @CatalogoN AND @PaginaA = @PaginaN AND @BotonA = @BotonN RETURN

  IF @BotonN IS NULL
  BEGIN
    DELETE CatDBotonExtra WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA AND Boton = @BotonA
  END ELSE
  BEGIN
    UPDATE CatDBotonExtra SET Catalogo = @CatalogoN, Pagina = @PaginaN, Boton = @BotonN WHERE Catalogo = @CatalogoA AND Pagina = @PaginaA AND Boton = @BotonA
  END
END
GO

/**************** spCatInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCatInfo') and sysstat & 0xf = 4) 
  drop procedure dbo.spCatInfo
GO
CREATE PROCEDURE spCatInfo
                  @Catalogo   varchar(50)
--//WITH ENCRYPTION
AS
BEGIN
  SELECT Titulo,
         AutoRetrocederInicio,
         RutaImagenes,
         CarritoSiempreVisible,
         ConfirmarAlEnviar,
         Renglones,
         Columnas,
         CapturaCodigo,
         EtiquetaCodigo,
         CapturaSubCodigo,
         EtiquetaSubCodigo,
         CapturaCantidad,
         EtiquetaCantidad,
         ActualizarFrecuencia,
         FrecuenciaUnidad,
         BotonAnchoAlto,
         Inicio
    FROM Cat
   WHERE Catalogo = @Catalogo
  RETURN
END
GO
-- EXEC spCatInfo @Catalogo='CatGral'

/**************** spCatDInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCatDInfo') and sysstat & 0xf = 4)
  drop procedure dbo.spCatDInfo
GO
CREATE PROCEDURE spCatDInfo
                  @Catalogo   varchar(50)
--//WITH ENCRYPTION
AS
BEGIN
  SELECT Pagina, Nombre
    FROM CatD
   WHERE Catalogo = @Catalogo
   ORDER BY Orden
  RETURN
END
GO

-- spCatDBotonInfo 'CatGral', '3'
-- select * from cat 
/**************** spCatDBotonInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCatDBotonInfo') and sysstat & 0xf = 4)
  drop procedure dbo.spCatDBotonInfo
GO
CREATE PROCEDURE spCatDBotonInfo
                  @Catalogo   varchar(50),
                  @Pagina     varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  SELECT b.Boton,
         'Ancho'   = CASE WHEN cat.TamanoEsp = 1 THEN b.Ancho ELSE 1 END,
         'Alto'    = CASE WHEN cat.TamanoEsp = 1 THEN b.Alto  ELSE 1 END,
         b.Etiqueta,
         b.EtiquetaCantidad,
         b.EtiquetaImporte,
         b.Descripcion,
         b.Liga,
         b.AutoRetroceder,
         'Color'=CONVERT(varchar(50), c.Numero),
         b.Negritas,
         b.Italicas,
         b.Tachado,
         b.Bloqueado,
         b.Imagen
         /*b.Tipo,
         b.Codigo,
         b.SubCodigo,
         b.Cantidad,
         b.Importe,
         b.Fecha,
         b.Referencia,
         b.Concepto*/
    FROM CatDBoton b
    JOIN Cat ON Cat.Catalogo = b.Catalogo
    LEFT OUTER JOIN Color c ON c.Color = b.Color
   WHERE b.Catalogo = @Catalogo AND b.Pagina = @Pagina
   ORDER BY b.Boton

  RETURN
END
GO

-- EXEC spCatDBotonInfo @Catalogo='CatGral', @Pagina=4



/**************** spCatDBotonExtraInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCatDBotonExtraInfo') and sysstat & 0xf = 4)
  drop procedure dbo.spCatDBotonExtraInfo
GO
CREATE PROCEDURE spCatDBotonExtraInfo
                  @Catalogo   varchar(50),
                  @Pagina           varchar(20)
--//WITH ENCRYPTION
AS
BEGIN
  SELECT Boton, Campo, Nombre, Tipo
    FROM CatDBotonExtra
   WHERE Catalogo = @Catalogo AND Pagina = @Pagina
   ORDER BY Orden
  RETURN
END
GO

-- spCatEnviar '<Catalogo  Catalogo="Venta" Forma="VentaTouchScreen" Modulo="VTAS" ModuloID="122" Cantidad="1"><Botones><Boton Boton="A1" Pagina="1"/></Botones></Catalogo>'
/**************** spCatEnviar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCatEnviar') and sysstat & 0xf = 4)
  drop procedure dbo.spCatEnviar
GO
CREATE PROCEDURE spCatEnviar
                  @XML  varchar(8000)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @Mensaje		varchar(255),
    @iXML		int,
    @Catalogo		varchar(50),
    @Forma		varchar(100),
    @Modulo		varchar(5),
    @ID			int,
    @Cantidad		float,
    @Pagina		varchar(20),
    @Boton		varchar(5),
    @Codigo		varchar(50),
    @Renglon		float,
    @RenglonID		int,
    @RenglonTipo	varchar(1),
    @Sucursal		int,
    @ZonaImpuesto	varchar(30),
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		float,
    @ArtTipo		varchar(20),
    @SubCuenta		varchar(50),
    @Precio		float,
    @Empresa            varchar(5),  
    @Unidad             varchar(50),
    @Factor             float

  SELECT @Mensaje = NULL
--<Catalogo  Catalogo="Venta" Forma="VentaTouchScreen" Modulo="VTAS" ModuloID="122" Cantidad="1"><Botones><Boton Boton="A1" Pagina="1"/></Botones></Catalogo>
  EXEC sp_xml_preparedocument @iXML OUTPUT, @XML

  SELECT @Catalogo = Catalogo, @Forma = Forma, @Modulo = Modulo, @ID = ModuloID, @Cantidad = Cantidad
    FROM OPENXML (@iXML, '/Catalogo', 1) 
    WITH (Catalogo varchar(50), Forma varchar(100), Modulo varchar(5), ModuloID int, Cantidad float)

  SELECT @Boton = MIN(Boton), @Pagina = MIN(Pagina)
    FROM OPENXML (@iXML, '/Catalogo/Botones/Boton', 1) 
    WITH (Boton varchar(5), Pagina varchar(20))

  SELECT @Codigo = Codigo 
    FROM CatDBoton
   WHERE Catalogo = @Catalogo AND Pagina = @Pagina AND Boton = @Boton

  EXEC sp_xml_removedocument @iXML

  IF @Forma='VentaTouchScreen'
  BEGIN
    UPDATE VentaD
       SET Cantidad = ISNULL(Cantidad, 0) + @Cantidad
     WHERE ID = @ID AND Articulo = @Codigo
    IF @@ROWCOUNT = 0
    BEGIN
      SELECT @Empresa = Empresa ,@Sucursal = Sucursal, @ZonaImpuesto = ZonaImpuesto FROM Venta WHERE ID = @ID
      SELECT @Renglon = MAX(Renglon), @RenglonID = MAX(RenglonID) FROM VentaD WHERE ID = @ID
      SELECT @Renglon = ISNULL(@Renglon, 0) + 2048.0, @RenglonID = ISNULL(@RenglonID, 0) + 1
      SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3, @ArtTipo = Tipo, @Precio = PrecioLista,
             @Unidad = Unidad
        FROM Art
       WHERE Articulo = @Codigo

      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto2 OUTPUT
      EXEC spZonaImp @ZonaImpuesto, @Impuesto3 OUTPUT
      EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
      SELECT @Factor =  dbo.fnArtUnidadFactor(@Empresa, @Codigo,@Unidad) 
      INSERT VentaD (
              ID,  Renglon,  RenglonID,  RenglonTipo,  Articulo, Cantidad,  Precio, Unidad,   Impuesto1,  Impuesto2,  Impuesto3)
      VALUES (@ID, @Renglon, @RenglonID, @RenglonTipo, @Codigo,  @Cantidad, @Precio, @Unidad, @Impuesto1, @Impuesto2, @Impuesto3*@Factor)
    END
  END
  SELECT 'Mensaje' = @Mensaje
  RETURN
END
GO

/****** AgendaEstacion ******/
if exists (select * from sysobjects where id = object_id('dbo.AgendaEstacion') and type = 'U')
  drop table AgendaEstacion
GO
CREATE TABLE dbo.AgendaEstacion (
	EstacionTrabajo	int		NOT NULL,
	ID		int		NOT NULL 	IDENTITY (1,1),
	Tipo		varchar(20)	NULL,
	Asunto		varchar(255)	NULL,
	Ubicacion	varchar(255)	NULL,
	ColorEtiqueta	int		NULL,
	FechaD		datetime	NULL,
	FechaA		datetime	NULL,
	DiaCompleto	bit 		NULL	DEFAULT (0),
	Recordar	bit		NULL,
	RecordarMinutos	int		NULL,
	RecordarFecha	datetime	NULL,
	Estado		varchar(100)	NULL,
	Mensaje		text		NULL,

  CONSTRAINT priAgendaEstacion PRIMARY KEY CLUSTERED (EstacionTrabajo, ID)
)
GO

--REQ12615 WMS
/****** ArtZona  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtZona')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtZona','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtZona') and type = 'U') 
CREATE TABLE dbo.ArtZona (
    Zona        varchar(30) NOT NULL,
    Articulo    varchar(20) NOT NULL,
    Orden       int         NULL
    CONSTRAINT priArtZona PRIMARY KEY (Zona, Articulo)
)
GO

--REQ12615 WMS
/****** AgenteZona  ******/
if not exists(select * from SysTabla where SysTabla = 'AgenteZona')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AgenteZona','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AgenteZona') and type = 'U') 
CREATE TABLE dbo.AgenteZona (
    Zona		varchar(30) NOT NULL,
	Agente		varchar(10) NOT NULL,
	Tipo		varchar(50) NOT NULL
    CONSTRAINT priAgenteZona PRIMARY KEY (Zona, Agente, Tipo)
)
GO

--REQ12615 WMS
/****** Rotacion de Articulos  ******/
if not exists(select * from SysTabla where SysTabla = 'ArtRotacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtRotacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ArtRotacion') and type = 'U') 
CREATE TABLE dbo.ArtRotacion (
	Rotacion 		varchar(10) 	NOT NULL ,

	CONSTRAINT priArtRotacion PRIMARY KEY CLUSTERED (Rotacion)
)
GO

--REQ12615 WMS
/****** Montacarga  ******/
if not exists(select * from SysTabla where SysTabla = 'Montacarga')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Montacarga','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Montacarga') and type = 'U') 
CREATE TABLE dbo.Montacarga (
    Montacarga		varchar(10) NOT NULL,
	Descripcion		varchar(50) NULL,
	Tipo			varchar(20) NULL,
	PesoMaximo		float       NULL,
	Articulo		varchar(20) NULL,
	Serie			varchar(20) NULL,
	Agente1			varchar(10) NULL,
	Agente2			varchar(10) NULL,
	Agente3			varchar(10) NULL,
	Estatus			varchar(15) NULL,
    
	CONSTRAINT priMontacarga PRIMARY KEY (MontaCarga)
)
GO
--DSG
EXEC spADD_INDEX 'Personal', 'Empresa', 'Empresa) INCLUDE (Personal'
GO

