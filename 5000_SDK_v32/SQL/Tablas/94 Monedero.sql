SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************************************** AuxiliarPMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.AuxiliarPMon') and type = 'U') 
CREATE TABLE dbo.AuxiliarPMon 
        (
          ID                    int         NOT NULL IDENTITY(1,1),
          Empresa               varchar( 5) NULL,
          Rama                  varchar( 5) NULL,
          Mov                   varchar(20) NULL,
          MovID                 varchar(20) NULL,
          Modulo                varchar( 5) NULL,
          ModuloID              int         NULL,
          Moneda                varchar(10) NULL,
          TipoCambio            float       NULL,
          Grupo                 varchar(10) NULL,
          Cuenta                varchar(20) NULL,
          SubCuenta             varchar(50) NULL,
          Ejercicio             int         NULL,
          Periodo               int         NULL,
          Fecha                 datetime    NULL,
          Cargo                 money       NULL,
          Abono                 money       NULL,
          Aplica                varchar(20) NULL,
          AplicaID              varchar(20)	NULL,
          Acumulado             bit         NOT NULL DEFAULT 0,
          Conciliado            bit         NOT NULL DEFAULT 0,
          EsCancelacion         bit         NOT NULL DEFAULT 0,
          FechaConciliacion     datetime    NULL,
          Sucursal              int         NOT NULL DEFAULT 0,
          Renglon               float       NULL,
          RenglonSub            int         NULL
          
		--  CONSTRAINT AuxiliarPMon PRIMARY KEY CLUSTERED (ID) 
        )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarPMon' AND sysindexes.name = 'Cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cuenta ON dbo.AuxiliarPMon (Cuenta, SubCuenta, Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarPMon' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.AuxiliarPMon (Grupo, Rama, Moneda, Ejercicio, Periodo, Fecha, Sucursal, Empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarPMon' AND sysindexes.name = 'Fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fecha ON dbo.AuxiliarPMon (Fecha, Cuenta, SubCuenta, Grupo, Moneda)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AuxiliarPMon' AND sysindexes.name = 'ModuloID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ModuloID ON dbo.AuxiliarPMon (ModuloID, Modulo)
GO


/**************************************** SaldoPMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.SaldoPMon') and type = 'U') 
CREATE TABLE dbo.SaldoPMon
        (
          Sucursal        int         NOT NULL DEFAULT 0,
          Empresa         varchar( 5) NOT NULL,
          Rama            varchar( 5) NOT NULL,
          Moneda          varchar(10) NOT NULL,
          Grupo           varchar(10) NOT NULL,
          Cuenta          varchar(20) NOT NULL,
          SubCuenta       varchar(50)	NOT NULL,
          Saldo           money           NULL,
          PorConciliar    money           NULL,
          UltimoCambio    datetime        NULL,
          SubCuenta2      varchar(50)	NOT NULL DEFAULT '',
          SubCuenta3      varchar(50)	NOT NULL DEFAULT '',
          Proyecto        varchar(50)	NOT NULL DEFAULT '',
          UEN             int         NULL DEFAULT 0,	
          CONSTRAINT priSaldoPMon PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, /*UEN,*/ Rama, Moneda, Sucursal, Empresa)
        )
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SaldoPMon' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.SaldoPMon (Grupo, Rama, Moneda, Sucursal, Empresa)
go


/**************************************** AcumPMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.AcumPMon') and type = 'U') 
CREATE TABLE dbo.AcumPMon
        (
          Sucursal           int          NOT NULL DEFAULT 0,
          Empresa            varchar( 5)  NOT NULL,
          Rama               varchar( 5)  NOT NULL,
          Ejercicio          int          NOT NULL,
          Periodo            int          NOT NULL,
          Moneda             varchar(10)  NOT NULL,
          Grupo              varchar(10)  NOT NULL,
          Cuenta             varchar(20)  NOT NULL,
          SubCuenta          varchar(50)  NOT NULL,
          Cargos             money            NULL,
          Abonos             money            NULL,	
          UltimoCambio       datetime         NULL,
          SubCuenta2         varchar(50)  NOT NULL DEFAULT '',
          SubCuenta3         varchar(50)  NOT NULL DEFAULT '',
          Proyecto           varchar(50)  NOT NULL DEFAULT '',
          UEN                int          NULL DEFAULT 0,
          CONSTRAINT priAcumPMon PRIMARY KEY CLUSTERED (Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto /*, UEN*/, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
        )
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AcumPMon' AND sysindexes.name = 'Grupo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Grupo ON dbo.AcumPMon (Grupo, Rama, Moneda, Ejercicio, Periodo, Sucursal, Empresa)
go


/*************************************** Monedero *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.Monedero') and type = 'U')
CREATE TABLE dbo.Monedero
         (
          ID                int          IDENTITY(1,1),
          Empresa           varchar( 5)  NOT NULL,
          Mov               varchar(20)  NOT NULL,
          MovID             varchar(20)      NULL,
          FechaEmision      datetime         NULL,
          UltimoCambio      datetime         NULL,
          UEN               int              NULL,
          Usuario           varchar(10)      NULL,
          Observaciones     varchar(100)     NULL,
          Referencia        varchar(50)      NULL,
          Estatus           varchar(15)      NULL,
          Ejercicio         int              NULL,
          Periodo           int              NULL,
          FechaRegistro     datetime         NULL,
          FechaConclusion   datetime         NULL,
          FechaCancelacion  datetime         NULL,
          Importe           float            NULL,
          Sucursal          int         DEFAULT 0,
          SucursalOrigen    int         DEFAULT 0,
          SucursalDestino   int              NULL,
          CONSTRAINT priMonedero PRIMARY KEY CLUSTERED (ID)
         )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Monedero' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir ON dbo.Monedero (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Monedero' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo ON dbo.Monedero (MovID, Mov, Estatus, Sucursal, Empresa)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Monedero' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision ON dbo.Monedero (FechaEmision, Estatus, Empresa)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Monedero' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario ON dbo.Monedero (Usuario)
go


/*************************************** MonederoD *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.MonederoD') and type = 'U')
CREATE TABLE dbo.MonederoD
         (
          ID                int         NOT NULL,
          Renglon           float       NOT NULL,
          RenglonSub        int         NOT NULL,
          Serie             varchar(20) NOT NULL,
          SerieDestino      varchar(20)     NULL,
          Importe           money           NULL,
          Sucursal          int         DEFAULT 0,
          SucursalOrigen    int         DEFAULT 0,
          CONSTRAINT priMonederoD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)
         )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MonederoD' AND sysindexes.name = 'Serie' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Serie ON dbo.MonederoD (Serie)
go

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MonederoD' AND sysindexes.name = 'SerieDestino' AND sysobjects.id = sysindexes.id)
  CREATE INDEX SerieDestino ON dbo.MonederoD (SerieDestino)
go


/*************************************** MonederoCfg *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.MonederoCfg') and type = 'U')
CREATE TABLE dbo.MonederoCfg
         (
          Empresa            varchar(5),
          CobroAutomatico	 bit         
         )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MonederoCfg' AND sysindexes.name = 'Empresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Empresa ON dbo.MonederoCfg (Empresa)
GO



/**************************************** MonederoC ***************************************/
if not exists(select * from sysobjects where id = object_id('dbo.MonederoC') and type = 'U')
CREATE TABLE dbo.MonederoC
          (
            ID              int         IDENTITY(1,1),
            Empresa         varchar( 5)     NULL,
            Mov             varchar(20)     NULL,
            Serie           varchar(20)     NULL,
            Periodo         int             NULL,
            Ejercicio       int             NULL,
            Consecutivo     int         DEFAULT 0,
            Sucursal        int         DEFAULT 0,
            CONSTRAINT priMonederoC PRIMARY KEY CLUSTERED (ID)
          )
GO



/*************************************** TarjetaMonedero *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.TarjetaMonedero') and type = 'U')
CREATE TABLE dbo.TarjetaMonedero
         (
          Empresa           varchar( 5) NOT NULL,---
          Serie             varchar(20) NOT NULL,
          Estatus           varchar(15) NOT NULL,
          TieneMovimientos  bit         DEFAULT(0),
          Usuario           varchar(10) NOT NULL,
          FechaAlta         datetime        NULL,
          UsuarioActivacion varchar(10)     NULL,
          FechaActivacion   datetime        NULL,
          FechaBaja         datetime        NULL,
          CONSTRAINT priTarjetaMonedero PRIMARY KEY CLUSTERED (Empresa, Serie)
         )
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TarjetaMonedero' AND sysindexes.name = 'Estatus' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Estatus ON dbo.TarjetaMonedero (Serie, Estatus, Empresa)

go



/*************************************** SerieTarjetaMovM *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.SerieTarjetaMovM') and type = 'U')
CREATE TABLE dbo.SerieTarjetaMovM
         (
          Empresa      varchar( 5) NOT NULL,
          Modulo       varchar( 5) NOT NULL,
          ID           int         NOT NULL,
          Serie        varchar(20) NOT NULL,
          Importe      money           NULL,
          Sucursal     int         NOT NULL DEFAULT 0,
		  Posicion	   int         NOT NULL DEFAULT 0,
          CONSTRAINT priSerieTarjetaMovM PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, Serie, Posicion)
         )
GO

--DROP TABLE POSSerieTarjetaMovM
/*************************************** POSSerieTarjetaMovM *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.POSSerieTarjetaMovM') and type = 'U')
CREATE TABLE dbo.POSSerieTarjetaMovM
         (
          Empresa		varchar( 5) NOT NULL,
          Modulo		varchar( 5) NOT NULL,
          ID			varchar(36) NOT NULL,
          Serie			varchar(20) NOT NULL,
          Importe		money           NULL,
          Sucursal		int         NOT NULL DEFAULT 0,
		  Posicion		int         NOT NULL DEFAULT 0,
		  Mov			varchar(20)		NULL,	
		  MovID			varchar(20)		NULL,
		  Referencia	varchar(20)		NULL,
		  Moneda		varchar(10)		NULL,
		  TipoCambio	float			NULL,
		  FechaEmision  datetime		NULL,
		  Usuario		varchar(10)		NULL,
          CONSTRAINT priPOSSerieTarjetaMovM PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, Serie, Posicion)
         )
GO

--DROP TABLE POSSerieTarjetaMovMTemp
/*************************************** POSSerieTarjetaMovMTemp *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.POSSerieTarjetaMovMTemp') and type = 'U')
CREATE TABLE dbo.POSSerieTarjetaMovMTemp
         (
          Empresa		varchar( 5)		NULL,
          Modulo		varchar( 5)		NULL,
          ID			varchar(36)		NULL,
          Serie			varchar(20)		NULL,
          Importe		money           NULL,
          Sucursal		int				NULL,
		  Posicion		int				NULL,
		  Mov			varchar(20)		NULL,	
		  MovID			varchar(20)		NULL,
		  Referencia	varchar(20)		NULL,
		  Moneda		varchar(10)		NULL,
		  TipoCambio	float			NULL,
		  FechaEmision  datetime		NULL,
		  Usuario		varchar(10)		NULL,
		  Estacion		int				NULL,	
         )
GO

/**************************************** FormaCobroMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.FormaCobroMon') and type = 'U') 
CREATE TABLE dbo.FormaCobroMon 

  (
          Empresa      varchar( 5) NOT NULL,
		  FormaCobro   varchar(50) NULL,
		  Objeto	   varchar(50) NULL,
		  ObjetoPOS	   varchar(50) NULL
         )

GO

EXEC spALTER_TABLE 'FormaCobroMon', 'ObjetoPOS', 'varchar(50) NULL'
GO


/**************************************** POSSaldoPMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.POSSaldoPMon') and type = 'U') 
CREATE TABLE dbo.POSSaldoPMon
        ( 
          Empresa			varchar( 5)	NOT NULL,
          Moneda			varchar(10)	NOT NULL,
          Grupo				varchar(10)	NULL,
          Cuenta			varchar(20)	NOT NULL,
          SubCuenta			varchar(50)	NULL,
          Saldo				money       NULL,
		  Estacion			int			NULL
        )
GO

/**************************************** POSAuxiliarPMon ****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.POSAuxiliarPMon') and type = 'U') 
CREATE TABLE dbo.POSAuxiliarPMon
        (
          ID                    int         NOT NULL,
          Empresa               varchar( 5) NULL,
          Rama                  varchar( 5) NULL,
          Mov                   varchar(20) NULL,
          MovID                 varchar(20) NULL,
          Modulo                varchar( 5) NULL,
          ModuloID              int         NULL,
          Moneda                varchar(10) NULL,
          TipoCambio            float       NULL,
          Grupo                 varchar(10) NULL,
          Cuenta                varchar(20) NULL,
          SubCuenta             varchar(50) NULL,
          Ejercicio             int         NULL,
          Periodo               int         NULL,
          Fecha                 datetime    NULL,
          Cargo                 money       NULL,
          Abono                 money       NULL,
          Aplica                varchar(20) NULL,
          AplicaID              varchar(20)	NULL,
          Acumulado             bit         NULL,
          Conciliado            bit         NULL,
          EsCancelacion         bit         NULL,
          FechaConciliacion     datetime    NULL,
          Sucursal              int         NULL,
          Renglon               float       NULL,
          RenglonSub            int         NULL,
		  Estacion				int			NULL,
        )
GO


/*************************************** POSTarjetaMonedero *****************************************/
if not exists (select * from sysobjects where id = object_id('dbo.POSTarjetaMonedero') and type = 'U')
CREATE TABLE dbo.POSTarjetaMonedero
         (
          Empresa           varchar( 5) NOT NULL,---
          Serie             varchar(20) NOT NULL,
          Estatus           varchar(15)		NULL,
          TieneMovimientos  bit				NULL,
          Usuario           varchar(10)		NULL,
          FechaAlta         datetime        NULL,
          UsuarioActivacion varchar(10)     NULL,
          FechaActivacion   datetime        NULL,
          FechaBaja         datetime        NULL,
		  Estacion			int				NULL
         )
GO