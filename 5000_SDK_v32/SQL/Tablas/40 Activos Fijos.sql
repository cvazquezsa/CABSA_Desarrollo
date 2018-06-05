
/*******************************************************************************************/
/*                                        ACTIVOS FIJOS                                    */
/*******************************************************************************************/

/****** ActivoFijoC ******/
if not exists (select * from SysTabla where SysTabla = 'ActivoFijoC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ActivoFijoC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijoC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ActivoFijoC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoFijoC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ActivoFijoC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ActivoFijoC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE ActivoFijoC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE ActivoFijoC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** ActivoFijo ******/
if not exists (select * from SysTabla where SysTabla = 'ActivoFijo') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ActivoFijo','Movimiento','AF')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ActivoFijo (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov			char(20)        NOT NULL,        
	MovID			varchar(20)    	NULL,	     
	FechaEmision 		datetime    	NULL,	     
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Concepto		varchar(50)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,

	Condicion		varchar(50)	NULL,
	Vencimiento		datetime	NULL,

	Proveedor		char(10)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,

	FormaPago		varchar(50)	NULL,
	CtaDinero		char(10)        NULL,       

	Todo			bit		NOT NULL DEFAULT 0,
	Revaluar		bit		NOT NULL DEFAULT 0,
	ValorMercado		bit		NOT NULL DEFAULT 0,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Personal		varchar(10)	NULL,
	Espacio			varchar(10)	NULL,
	ContUso			varchar(20)	NULL,


	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoFijo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ActivoFijo'
END
go
EXEC spSincroNivelRegistro @Tabla = 'ActivoFijo'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX ActivoFijo.Consecutivo
  ALTER TABLE ActivoFijo ALTER COLUMN MovID varchar(20)
  ALTER TABLE ActivoFijo ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE ActivoFijo ALTER COLUMN PolizaID varchar(20)
END
EXEC spModificarPK_Mov 'ActivoFijo'
GO
EXEC spALTER_TABLE 'ActivoFijo', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'Personal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'SituacionNota', 'varchar(100)	NULL'

-- 9036
EXEC spALTER_TABLE 'ActivoFijo', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ActivoFijo', 'ContUso3', 'varchar(20) NULL'
GO

EXEC spFK 'ActivoFijo','Moneda','Mon','Moneda'
EXEC spFK 'ActivoFijo','UEN','UEN','UEN'
EXEC spFK 'ActivoFijo','Personal','Personal','Personal'
EXEC spFK 'ActivoFijo','ContUso','CentroCostos','CentroCostos'
GO

-- ActivoFijo
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2 ON dbo.ActivoFijo (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2       ON dbo.ActivoFijo (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision ON dbo.ActivoFijo (FechaEmision, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario      ON dbo.ActivoFijo (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3   ON dbo.ActivoFijo (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	    ON dbo.ActivoFijo (ContID)
go

-- Eliminar Indices
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX ActivoFijo.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX ActivoFijo.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX ActivoFijo.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX ActivoFijo.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX ActivoFijo.Abrir
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON ActivoFijo (MovID,Mov,Empresa)	
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON ActivoFijo (OrigenID,Origen,Mov)	
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActivoFijo' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON ActivoFijo (OrigenID,Origen,Empresa)
GO

/****** ActivoFijoD ******/
if not exists (select * from SysTabla where SysTabla = 'ActivoFijoD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ActivoFijoD','Movimiento','AF')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijoD') and type = 'U') 
CREATE TABLE dbo.ActivoFijoD (
	ID 				int       	NOT NULL,
 	Renglon				float	  	NOT NULL,
	RenglonSub			int		NOT NULL   DEFAULT 0,

	Articulo			char(20)	NULL,
	Serie				varchar(20)	NULL,
	Importe				money		NULL,
	Impuestos			money		NULL,
	Horas				float		NULL,
	MesesDepreciados		int		NULL,
	Depreciacion			money		NULL,
	DepreciacionPorcentaje		float		NULL,
	NuevoValor			money		NULL,
	Inflacion			float		NULL,
	ActualizacionCapital		money		NULL,
	ActualizacionGastos		money		NULL,
        ActualizacionDepreciacion	money		NULL,
	Observaciones			varchar(100)	NULL,

	ValorAnterior			money		NULL,
	DepreciacionAnterior		datetime	NULL,
	RevaluacionAnterior		datetime	NULL,
	ReparacionAnterior		datetime	NULL,
	MantenimientoAnterior		datetime	NULL,
	MantenimientoSiguienteAnterior	datetime	NULL,
	PolizaMantenimientoAnterior	datetime	NULL,
	PolizaSeguroAnterior		datetime	NULL,
	Sucursal			int		NOT NULL DEFAULT 0,

	CONSTRAINT priActivoFijoD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
)
GO
EXEC spModificarPK_Sucursal 'ActivoFijoD', '(ID, Renglon, RenglonSub)'
GO
if (select version from version)<=2333
 alter table ActivoFijoD alter column DepreciacionPorcentaje float NULL
go

EXEC spALTER_COLUMN 'ActivoFijoD', 'Serie', 'varchar(50) NULL'  --BUG12333
GO

if exists (select * from sysobjects where id = object_id('dbo.cActivoFijoD') and sysstat & 0xf = 2) drop view dbo.cActivoFijoD
GO
CREATE VIEW cActivoFijoD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Articulo,
  Serie,
  Importe,
  Impuestos,
  Horas,
  MesesDepreciados,
  Depreciacion,
  DepreciacionPorcentaje,
  NuevoValor,
  Inflacion,
  ActualizacionCapital,
  ActualizacionGastos,
  ActualizacionDepreciacion,
  Observaciones,

  ValorAnterior,
  DepreciacionAnterior,
  RevaluacionAnterior,
  ReparacionAnterior,
  MantenimientoAnterior,
  MantenimientoSiguienteAnterior,
  PolizaMantenimientoAnterior,
  PolizaSeguroAnterior,

  Sucursal,
  SucursalOrigen

FROM
  ActivoFijoD
GO

/****** ActivoFijoSugerir ******/
if not exists (select * from SysTabla where SysTabla = 'ActivoFijoSugerir') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ActivoFijoSugerir','Movimiento','AF')
if not exists (select * from sysobjects where id = object_id('dbo.ActivoFijoSugerir') and type = 'U') 
CREATE TABLE dbo.ActivoFijoSugerir (
  Estacion			int,
  ID				int			IDENTITY,
  Categoria			varchar(50)	NULL,
  Sugerir			bit			NULL
  )
GO

/****** AuxiliarActivoFijo ******/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'AuxiliarActivoFijo') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('AuxiliarActivoFijo','Movimiento','AF')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.AuxiliarActivoFijo') AND TYPE = 'U') 
 CREATE TABLE dbo.AuxiliarActivoFijo (                                               
										ID	                    Int				NOT NULL,       
										IDMov                   Int             NOT NULL,       
										Renglon	                Float			NOT NULL,    
										Empresa	                Varchar(5)		NOT NULL,
										Modulo	                Varchar(5)		NOT NULL,
										Articulo	            Varchar(20)		NOT NULL,
										Serie	                Varchar(50)		NOT NULL,
										Cantidad	            Float			NOT NULL,
										ValorAdquisicion        Money			NOT NULL,
										ImporteMov	            Money			NOT NULL,
										FactorCalculo	        Money			NULL, 
										Total	                Money			NOT NULL,
										FechaEmision	        Datetime		NOT NULL,
										FechaInicioDepreciacion	Datetime		NOT NULL,
										Aplicar	                Bit Default 0   NOT NULL, 
										Icono	                Int             NULL 

										CONSTRAINT priAuxiliarActivoFijo PRIMARY KEY CLUSTERED (ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie)
								     )
GO