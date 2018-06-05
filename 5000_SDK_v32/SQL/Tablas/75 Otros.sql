/*  OTROS */

if (select version from version) <= 2237 and exists (select * from sysobjects where id = object_id('dbo.FordReclamos') and type = 'U') 
  drop table FordReclamos
GO

/****** FordPagos ******/
if not exists (select * from SysTabla where SysTabla = 'FordPagos') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FordPagos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FordPagos') and type = 'U') 
CREATE TABLE dbo.FordPagos (
	Numero		char(10)	NOT NULL,

	Tipo		char(2)		NULL,
	Estado		char(2)		NULL,
	Importe		money		NULL,
	Calificador	char(1)		NULL,
	FechaEmision	datetime	NULL,
	Partes		money		NULL,
	ManoObra	money		NULL,
	Varios		money		NULL,
	IVA		money		NULL,
	Reporte		int		NULL,

	Estatus		char(15)	NULL,
	Referencia	varchar(50)	NULL,

	CONSTRAINT priFordPagos PRIMARY KEY  CLUSTERED (Numero)
)
GO


/****** FordReclamos ******/
if not exists (select * from SysTabla where SysTabla = 'FordReclamos') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FordReclamos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FordReclamos') and type = 'U') 
CREATE TABLE dbo.FordReclamos (
	ID		int		NOT NULL IDENTITY(1, 1),
	Fecha		datetime	NULL	DEFAULT GETDATE(),

	Numero		char(10)	NULL,
	VIN		char(20)	NULL,
	FechaEmision	datetime	NULL,
	Importe		money		NULL,
	IVA		float		NULL,
	Observaciones	varchar(255)	NULL,

	Estatus		char(15)	NULL,		-- REVISION, RETENIDO, PAGADO, RECHAZADO

	CONSTRAINT priFordReclamos PRIMARY KEY  CLUSTERED (ID)
)
GO


/****** FordIncentivos ******/
if not exists (select * from SysTabla where SysTabla = 'FordIncentivos') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FordIncentivos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FordIncentivos') and type = 'U') 
CREATE TABLE dbo.FordIncentivos (
	ID		int		NOT NULL IDENTITY(1, 1),

	Modelo		char(4)		NULL,
	VigenciaDesde	datetime	NULL,
	VigenciaHasta	datetime	NULL,
	Zona		varchar(30)	NULL,
	Articulo	char(20)	NULL,
	Precio		money		NULL,
	Incentivo	money		NULL,
	TipoPago	varchar(20)	NULL,				-- Credito/Contado
	Condicion	varchar(50)	NULL,
	Concepto	varchar(50)	NULL,
	Estatus		char(15)	NULL	DEFAULT 'ALTA',		-- ALTA, BLOQUEADO, BAJA

	CONSTRAINT priFordIncentivos PRIMARY KEY  CLUSTERED (ID)
)
GO
if not exists(select * from syscampo where tabla='FordIncentivos' and campo='TipoPago')
  exec sp_rename 'FordIncentivos.TipoCondicion', 'TipoPago', 'COLUMN'
go
EXEC spALTER_TABLE 'FordIncentivos', 'Condicion', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'FordIncentivos', 'Modelo', 'char(4) NULL'
EXEC spALTER_TABLE 'FordIncentivos', 'Concepto', 'varchar(50) NULL'
go

/****** FordParticipaciones ******/
if not exists (select * from SysTabla where SysTabla = 'FordParticipaciones') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FordParticipaciones','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FordParticipaciones') and type = 'U') 
CREATE TABLE dbo.FordParticipaciones (
	ID		int		NOT NULL IDENTITY(1, 1),

	Modelo		char(4)		NULL,
	VigenciaDesde	datetime	NULL,
	VigenciaHasta	datetime	NULL,
	Zona		varchar(30)	NULL,
	Articulo	char(20)	NULL,
	Precio		money		NULL,
	Participacion	money		NULL,
	TipoPago	varchar(20)	NULL,				-- Credito/Contado
	Condicion	varchar(50)	NULL,
	Concepto	varchar(50)	NULL,
	Acreedor	char(10)	NULL,
	Estatus		char(15)	NULL	DEFAULT 'ALTA',		-- ALTA, BLOQUEADO, BAJA

	CONSTRAINT priFordParticipaciones PRIMARY KEY  CLUSTERED (ID)
)
go
EXEC spALTER_TABLE 'FordParticipaciones', 'Modelo', 'char(4) NULL'
go


/****** FordZona ******/
if not exists (select * from SysTabla where SysTabla = 'FordZona') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FordZona','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FordZona') and type = 'U') 
CREATE TABLE dbo.FordZona (
	Zona		varchar(30)	NOT NULL,

	CONSTRAINT priFordZona PRIMARY KEY  CLUSTERED (Zona)
)
GO





/********************************************************/ 
/************************ CHRYSLER **********************/ 
/********************************************************/ 

/****** ChryslerTBADLPP (Tabla Bonificacion Adicional Dias Libres Plan Piso)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTBADLPP') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTBADLPP','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTBADLPP') and type = 'U') 
CREATE TABLE dbo.ChryslerTBADLPP (
	Clave	                char(20)	NOT NULL,
        Modelo                  char(4)         NOT NULL,
        DiasLibres              int             NOT NULL,
        
        Importe                 money           NULL,

	CONSTRAINT priChryslerTBADLPP PRIMARY KEY  CLUSTERED (Clave, Modelo, DiasLibres)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTBADLPP'")
  EXEC("ALTER TABLE ChryslerTBADLPP ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTBADLPP ADD CONSTRAINT priChryslerTBADLPP PRIMARY KEY  CLUSTERED (Clave, Modelo, DiasLibres)")
END
GO

/****** ChryslerTBC (Tabla Bonificacion Contratos)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTBC') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTBC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTBC') and type = 'U') 
CREATE TABLE dbo.ChryslerTBC (
	Contrato	        varchar(20)	NOT NULL,

        Unidades                int             NULL,
        ImporteTotal            money           NULL,

	CONSTRAINT priChryslerTBC PRIMARY KEY  CLUSTERED (Contrato)
)
GO

/****** ChryslerTBPF (Tabla Bonificacion Precios Flotilla)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTBPF') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTBPF','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTBPF') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTBPF' and Campo='Modelo')
  drop table ChryslerTBPF
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTBPF') and type = 'U') 
CREATE TABLE dbo.ChryslerTBPF(
	Modelo			char(4)		NOT NULL,
	Clave	                char(20)	NOT NULL,
        
        Importe                 money           NULL,

	CONSTRAINT priChryslerTBPF PRIMARY KEY  CLUSTERED (Modelo, Clave)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTBPF'")
  EXEC("ALTER TABLE ChryslerTBPF ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTBPF ADD CONSTRAINT priChryslerTBPF PRIMARY KEY  CLUSTERED (Modelo, Clave)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTBPF' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTBPF (Clave)
GO

/****** ChryslerTCPPC (Tabla Cuota Plan Piso Complementario)   ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTCPPC') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTCPPC','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTCPPC') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTCPPC' and Campo='Modelo')
  drop table ChryslerTCPPC
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTCPPC') and type = 'U') 
CREATE TABLE dbo.ChryslerTCPPC (
	Modelo			char(4)		NOT NULL,
	Clave	                char(20)	NOT NULL,
        
        ImportePPC              money           NULL,
        ImporteSPDC             money           NULL,

	CONSTRAINT priChryslerTCPPC PRIMARY KEY  CLUSTERED (Modelo, Clave)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTCPPC'")
  EXEC("ALTER TABLE ChryslerTCPPC ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTCPPC ADD CONSTRAINT priChryslerTCPPC PRIMARY KEY  CLUSTERED (Modelo, Clave)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTCPPC' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTCPPC (Clave)
GO


/****** ChryslerTCS (Tabla Cupones de Servicio)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTCS') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTCS','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTCS') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTCS' and Campo='Modelo')
  drop table ChryslerTCS
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTCS') and type = 'U') 
CREATE TABLE dbo.ChryslerTCS (
	Modelo			char(4)		NOT NULL,
	Clave	                char(20)	NOT NULL,
	ServicioTipo		varchar(50)	NOT NULL,
        
        Importe                 money           NULL,

	CONSTRAINT priChryslerTCS PRIMARY KEY  CLUSTERED (Modelo, Clave, ServicioTipo)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTCS'")
  EXEC("ALTER TABLE ChryslerTCS ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTCS ADD CONSTRAINT priChryslerTCS PRIMARY KEY  CLUSTERED (Modelo, Clave, ServicioTipo)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTCS' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTCS (Clave)
GO


/****** ChryslerTDOC (Tabla Descuentos para Operaciones de Contado)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTDOC') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTDOC','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTDOC') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTDOC' and Campo='Modelo')
  drop table ChryslerTDOC
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTDOC') and type = 'U') 
CREATE TABLE dbo.ChryslerTDOC (
	Modelo			      char(4)		NOT NULL,
	Clave	                      char(20)	      NOT NULL,
        ConceptoVenta                 varchar(50)     NOT NULL,
        
        ParticipacionPlanta           money           NULL,
        ParticipacionDistribuidor     money           NULL,

	CONSTRAINT priChryslerTDOC PRIMARY KEY  CLUSTERED (Modelo, Clave, ConceptoVenta)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTDOC'")
  EXEC("ALTER TABLE ChryslerTDOC ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTDOC ADD CONSTRAINT priChryslerTDOC PRIMARY KEY  CLUSTERED (Modelo, Clave, ConceptoVenta)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTDOC' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTDOC (Clave)
GO


/****** ChryslerTEDVD (Tabla Entretenimiento DVD)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTEDVD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTEDVD','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTEDVD') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTEDVD' and Campo='Modelo')
  drop table ChryslerTEDVD
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTEDVD') and type = 'U') 
CREATE TABLE dbo.ChryslerTEDVD (
	Modelo			char(4)		NOT NULL,
	Clave	                char(20)	NOT NULL,
        
        Importe                 money           NULL,

	CONSTRAINT priChryslerTEDVD PRIMARY KEY  CLUSTERED (Modelo, Clave)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTEDVD'")
  EXEC("ALTER TABLE ChryslerTEDVD ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTEDVD ADD CONSTRAINT priChryslerTEDVD PRIMARY KEY  CLUSTERED (Modelo, Clave)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTEDVD' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTEDVD (Clave)
GO


/****** ChryslerTL (Tabla Lealtad)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTL') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTL','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTL') and type = 'U') and not exists(select * from SysCampo where Tabla = 'ChryslerTL' and Campo='Modelo')
  drop table ChryslerTL
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTL') and type = 'U') 
CREATE TABLE dbo.ChryslerTL (
	Modelo			char(4)		NOT NULL,
	Clave	                char(20)        NOT NULL,
        
        Importe                 money           NULL,

	CONSTRAINT priChryslerTL PRIMARY KEY  CLUSTERED (Modelo, Clave)
)
GO
if (select version from version)<=2663
BEGIN
  EXEC("spEliminarPK 'ChryslerTL'")
  EXEC("ALTER TABLE ChryslerTL ALTER COLUMN Clave char(20) NOT NULL")
  EXEC("ALTER TABLE ChryslerTL ADD CONSTRAINT priChryslerTL PRIMARY KEY  CLUSTERED (Modelo, Clave)")
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ChryslerTL' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave on ChryslerTL (Clave)
GO

/****** ChryslerTOV (Tabla Objetivos Venta)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTOV') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTOV','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.ChryslerTOV') and type = 'U')  and exists(select * from syscampo where tabla='ChryslerTOV' and campo='Empresa')
  drop table ChryslerTOV
go
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTOV') and type = 'U') 
CREATE TABLE dbo.ChryslerTOV (
        Ejercicio               int             NOT NULL,
        Periodo                 int             NOT NULL,

        ObjetivoFlotilla        int             NULL,
        ObjetivoMenudeo         int             NULL,
        VentasFlotilla          int             NULL,
        VentasMenudeo           int             NULL,

	CONSTRAINT priChryslerTOV PRIMARY KEY  CLUSTERED (Ejercicio, Periodo)
)
GO


/****** ChryslerTPC (Tabla Porcentaje Cumplimiento)  ******/
if not exists (select * from SysTabla where SysTabla = 'ChryslerTPC') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ChryslerTPC','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ChryslerTPC') and type = 'U') 
CREATE TABLE dbo.ChryslerTPC (
	CumplimientoD           float           NOT NULL,
	CumplimientoA           float           NOT NULL,
        
        Bonificacion            float           NULL,

	CONSTRAINT priChryslerTPC PRIMARY KEY  CLUSTERED (CumplimientoD, CumplimientoA)
)
GO




/********************************************************/ 
/************************ SERVICIO **********************/ 
/********************************************************/ 

/****** ServicioVehiculo  ******/
if not exists (select * from SysTabla where SysTabla = 'ServicioVehiculo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioVehiculo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioVehiculo') and type = 'U') 
CREATE TABLE dbo.ServicioVehiculo (
	Vehiculo	        varchar(50)     NOT NULL,

	CONSTRAINT priServicioVehiculo PRIMARY KEY CLUSTERED (Vehiculo)
)
GO

/****** ServicioModelo  ******/
if not exists (select * from SysTabla where SysTabla = 'ServicioModelo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioModelo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioModelo') and type = 'U') 
CREATE TABLE dbo.ServicioModelo (
	Modelo	        int     NOT NULL,

	CONSTRAINT priServicioModelo PRIMARY KEY CLUSTERED (Modelo)
)
GO

/****** ServicioMotor  ******/
if (select version from version) <= 2684 and exists (select * from sysobjects where id = object_id('dbo.ServicioMotor') and type = 'U') 
  drop table ServicioMotor
GO
if not exists (select * from SysTabla where SysTabla = 'ServicioMotor') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioMotor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioMotor') and type = 'U') 
CREATE TABLE dbo.ServicioMotor (
	Motor	        varchar(20)     NOT NULL,

	CONSTRAINT priServicioMotor PRIMARY KEY CLUSTERED (Motor)
)
GO

/****** ServicioCilindros  ******/
if not exists (select * from SysTabla where SysTabla = 'ServicioCilindros') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioCilindros','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioCilindros') and type = 'U') 
CREATE TABLE dbo.ServicioCilindros (
	Cilindros	        int     NOT NULL,

	CONSTRAINT priServicioCilindros PRIMARY KEY CLUSTERED (Cilindros)
)
GO

/****** ServicioTransmision  ******/
if not exists (select * from SysTabla where SysTabla = 'ServicioTransmision') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTransmision','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTransmision') and type = 'U') 
CREATE TABLE dbo.ServicioTransmision (
	Transmision	        varchar(50)     NOT NULL,

	CONSTRAINT priServicioTransmision PRIMARY KEY CLUSTERED (Transmision)
)
GO

/****** ServicioTraccion  ******/
if not exists (select * from SysTabla where SysTabla = 'ServicioTraccion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioTraccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioTraccion') and type = 'U') 
CREATE TABLE dbo.ServicioTraccion (
	Traccion	        varchar(50)     NOT NULL,

	CONSTRAINT priServicioTraccion PRIMARY KEY CLUSTERED (Traccion)
)
GO

/****** ServicioMatrizBase  ******/
if (select version from version) <= 2684 and exists (select * from sysobjects where id = object_id('dbo.ServicioMatrizBase') and type = 'U') 
  drop table ServicioMatrizBase
GO
if not exists (select * from SysTabla where SysTabla = 'ServicioMatrizBase') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioMatrizBase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioMatrizBase') and type = 'U') 
  CREATE TABLE dbo.ServicioMatrizBase (
	Vehiculo	        varchar(50)     NOT NULL,
	Modelo	        	int	        NOT NULL,
	Motor	        	varchar(20)     NOT NULL,
	Cilindros	        int	        NOT NULL,
	Transmision	        varchar(50)     NOT NULL,
	Traccion	        varchar(50)     NOT NULL,

	CONSTRAINT priServicioMatrizBase PRIMARY KEY CLUSTERED (Vehiculo, Modelo, Motor, Cilindros, Transmision, Traccion)
)
GO

/****** ServicioMatriz  ******/
if (select version from version) <= 2684 and exists (select * from sysobjects where id = object_id('dbo.ServicioMatriz') and type = 'U') 
  drop table ServicioMatriz
GO
if not exists (select * from SysTabla where SysTabla = 'ServicioMatriz') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioMatriz','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioMatriz') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ServicioMatriz (
	ID			int		NOT NULL	IDENTITY(1,1),
	
	Vehiculo	        varchar(50)     NOT NULL,
	Modelo	        	int	        NOT NULL,
	Motor	        	varchar(20)     NOT NULL,
	Cilindros	        int	        NOT NULL,
	Transmision	        varchar(50)     NOT NULL,
	Traccion	        varchar(50)     NOT NULL,

	Articulo		varchar(20)	NOT NULL,
	SubCuenta		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	Cantidad		float		NULL,

	PrecioEsp		money		NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	VigenciaD		datetime	NULL,
	VigenciaA		datetime	NULL,

	Paquete			int		NULL,

	CONSTRAINT priServicioMatriz PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ServicioMatriz'
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ServicioMatriz' AND sysindexes.name = 'Base' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Base ON dbo.ServicioMatriz (Vehiculo, Modelo, Motor, Cilindros, Transmision, Traccion)
GO

EXEC spALTER_TABLE 'ServicioMatriz', 'PrecioEsp', 'money NULL'
EXEC spALTER_TABLE 'ServicioMatriz', 'ListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ServicioMatriz', 'VigenciaD', 'datetime NULL'
EXEC spALTER_TABLE 'ServicioMatriz', 'VigenciaA', 'datetime NULL'
EXEC spALTER_TABLE 'ServicioMatriz', 'Paquete', 'int NULL'
GO

if not exists (select * from sysobjects where id = object_id('dbo.VerBloqueo') and type = 'U') -- drop table VerBloqueo
	CREATE TABLE VerBloqueo(
	ID 		int IDENTITY,
	Spid 		int ,
	UsuarioNT	varchar(100),
	Comando		varchar(20),
	Fecha		datetime,
	Info		varchar(255),
	Actual		datetime
	CONSTRAINT priVerBloqueo PRIMARY KEY (ID))
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'VerBloqueo' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.VerBloqueo (Fecha)


/******************************* HUELLA DIGITAL ********************************/

if not exists (select * from sysobjects where id = object_id('dbo.Fingerprints') and type = 'U') 

  CREATE TABLE dbo.Fingerprints (
              ID             int         NOT NULL,
              Features       image            NULL,
              FingerID       nvarchar(10)   NULL, 
              VRecord         int            NULL,
              FechaCaptura    datetime       NULL,
              Tipo            char(15)        NULL,
              UsrAlta         varchar(15)    NULL,

  ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/* Actualizacion de Aplicacion de Huella
* Responsable Armando Becerril
* Fecha 31 marzo 2009
*/

EXEC spAlter_Table 'Fingerprints', 'VRecord','int NULL'
EXEC spAlter_Table 'Fingerprints', 'FechaCaptura','datetime NULL'
EXEC spAlter_Table 'Fingerprints', 'Tipo','char(15) NULL'
EXEC spAlter_Table 'Fingerprints','UsrAlta','varchar(15) NULL'
GO
if (select version from version)<=3292 
BEGIN
  EXEC("ALTER TABLE Fingerprints ALTER COLUMN VRecord  INT NULL")
END
GO
 
/**** CuboXML ****/
IF NOT EXISTS (SELECT name FROM sys.tables WHERE name LIKE 'CuboXML' AND type = 'U')
  CREATE TABLE dbo.CuboXML(
    Cubo		char(20),
    XML			xml,
    Orden		int,
    Activo		bit,
    Objeto      varchar(100)
)
GO

/********************************* HUELLA DIGITAL *********************************/

/*************************** VisorWebConfig **************************/
if not exists (select * from SysTabla where SysTabla = 'VisorWebConfig') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VisorWebConfig','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VisorWebConfig') and type = 'U') 
CREATE TABLE dbo.VisorWebConfig(
	Formato		varchar(50)	NOT NULL,
	Descripcion	varchar(100)	NULL,
	Editable	bit				NULL 		DEFAULT 1,

 CONSTRAINT priVisorWebConfig PRIMARY KEY CLUSTERED (Formato)
)
GO

/*************************** VisorWebConfigD **************************/
if not exists (select * from SysTabla where SysTabla = 'VisorWebConfigD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VisorWebConfigD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VisorWebConfigD') and type = 'U') 
CREATE TABLE dbo.VisorWebConfigD(
	Formato		varchar(50)	NOT NULL,
	RID			int IDENTITY(1,1) NOT NULL,
	Orden		int			NOT NULL,
	TabTitulo	varchar(100)	NULL,
	Zona		varchar(100)	NULL,
	ZonaTitulo	varchar(100)	NULL,
	URL			varchar(255)	NULL,
	Bloqueado	bit				NULL 		DEFAULT 0,

 CONSTRAINT priVisorWebConfigD PRIMARY KEY CLUSTERED (Formato, RID)
)
GO

/*************************** VisorWebConfigUsuario **************************/
if not exists (select * from SysTabla where SysTabla = 'VisorWebConfigUsuario') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('VisorWebConfigUsuario','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.VisorWebConfigUsuario') and type = 'U') 
CREATE TABLE dbo.VisorWebConfigUsuario(
	Formato		varchar(50)	NOT NULL,
	Usuario		varchar(20)	NOT NULL,

 CONSTRAINT priVisorWebConfigUsuario PRIMARY KEY CLUSTERED (Formato,Usuario)
)
GO
