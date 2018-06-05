SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO


/**************************************************     MaxMinTrabajo     *************************************************************/
IF NOT  EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.MaxMinTrabajo') AND type = 'U') 
  CREATE TABLE dbo.MaxMinTrabajo (
        Trabajo         varchar(255) NOT NULL,
        Frecuencia      varchar(50)  NULL,
        Valor           int          NULL,
        Activo          bit          NOT NULL DEFAULT 0
  CONSTRAINT priMaxMinTrabajo PRIMARY KEY CLUSTERED (Trabajo)
  )
GO
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MaxMinTrabajo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MaxMinTrabajo', 'N/A')


/************ PlanArtMaxMin ************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'PlanArtMaxMin' AND TYPE = 'U')
CREATE TABLE PlanArtMaxMin (
  ID                    int IDENTITY(1,1)   NOT NULL,
  Empresa               char(5)				NOT NULL,
  Sucursal              int                 NOT NULL,
  Usuario               varchar(10)			NOT NULL,
  Estacion              int                 NOT NULL,
  Grupo                 varchar(50)			NULL,
  Categoria             varchar(50)			NULL,
  Familia               varchar(50)			NULL,
  Linea                 varchar(50)			NULL,
  Fabricante            varchar(50)			NULL,
  Proveedor             varchar(10)			NULL,
  Nombre                varchar(100)		NULL,
  Almacen               varchar(10)			NOT NULL,
  AlmacenNombre         varchar(100)		NULL,
  Articulo              varchar(20)			NOT NULL,
  SubCuenta             varchar(20)			NOT NULL DEFAULT '',
  Descripcion1          varchar(100)		NULL,
  Descripcion2          varchar(255)		NULL,
  NombreCorto           varchar(20)			NULL,
  Unidad                varchar(50)			NULL,
  ABC                   varchar(50)			NULL,
  Maximo                float               NULL,
  Minimo                float               NULL,
  VentaPromedio         float               NULL,
  Precio                float               NULL,
  ImporteTotal          float               NULL,
  Existencia            float               NULL,
  EnCompra              float               NULL,
  PorRecibir            float               NULL,
  PorEntregar           float               NULL,
  Disponible            float               NULL,
  DiasInvInicio         float               NULL,
  AlmacenD              varchar(10)			NOT NULL,
  AlmacenNombreD        varchar(100)		NULL,
  MaximoD               float               NULL,
  MinimoD               float               NULL,
  VentaPromedioD        float               NULL,
  ExistenciaD           float               NULL,
  EnCompraD             float               NULL,
  PorRecibirD           float               NULL,
  PorEntregarD          float               NULL,
  DisponibleD           float               NULL,
  DiasInvD              float               NULL,
  Solicitar             float               NULL,
  Cantidad              float               NULL,
  CantidadA             float               NULL,
  DiasInvFin            float               NULL,
  Tipo                  varchar(20)         NULL,
  Movimiento            varchar(20)         NULL,
  Aplicar               bit                 NULL,
  CONSTRAINT priPlanArtMaxMin PRIMARY KEY CLUSTERED (ID)
 )
GO
EXEC spADD_INDEX PlanArtMaxMin, 'Principal', 'Articulo, SubCuenta, Almacen, Usuario, Estacion, Empresa'
EXEC spADD_INDEX PlanArtMaxMin, 'Articulo', 'Articulo, SubCuenta'
EXEC spADD_INDEX PlanArtMaxMin, 'Tipo', 'Tipo'
EXEC spADD_INDEX PlanArtMaxMin, 'Almacen', 'Almacen, AlmacenD'
GO

/********************  RutaDistribucionMaxMin ********************/
IF NOT EXISTS (SELECT * FROM SysTabla where SysTabla = 'RutaDistribucionMaxMin')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RutaDistribucionMaxMin', 'Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects where id = object_id('RutaDistribucionMaxMin') AND TYPE = 'U')
CREATE TABLE RutaDistribucionMaxMin (
  AlmacenOrigen         char(10) NOT NULL,
  AlmacenDestino        char(10) NOT NULL,
  Orden                 int      NULL
  CONSTRAINT priRutaDistribucionMaxMin PRIMARY KEY  CLUSTERED (AlmacenOrigen, AlmacenDestino)
)
GO

/**********************  PlanArtMaxMinCfg  ***********************/
IF NOT EXISTS (SELECT * FROM SysTabla where SysTabla = 'PlanArtMaxMinCfg')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PlanArtMaxMinCfg', 'Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects where id = object_id('PlanArtMaxMinCfg') AND TYPE = 'U')
CREATE TABLE PlanArtMaxMinCfg (
  Empresa               char(5) NOT NULL,
  Tipo					varchar(50) NULL,
  DiasVenta             int     NOT NULL,
  Semanas				int		NULL,
  PeriodoA				bit     NULL,
  MesesPeriodoA			int     NULL,
  PeriodoB				bit     NULL,
  MesesPeriodoB			int     NULL,
  PeriodoC				bit     NULL,
  MesesPeriodoC			int     NULL,
  DiasInventario        int     NULL,
  FactorCrecimiento     int     NULL,
  CONSTRAINT priPlanArtMaxMinCfg PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'PlanArtMaxMinCfg', 'MovComs', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'PlanArtMaxMinCfg', 'MovInv',  'varchar(20) NULL'
EXEC spALTER_TABLE 'PlanArtMaxMinCfg', 'MovInv2', 'varchar(20) NULL'
GO

/************************  PlanArtMaxMinTemp  **************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'PlanArtMaxMinTemp' AND TYPE = 'U')
CREATE TABLE PlanArtMaxMinTemp (
  ID                    int          NOT NULL,
  Empresa               char(5)      NULL,
  Sucursal              int          NULL,
  Usuario               varchar(10)  NULL,
  Estacion              int          NULL,
  Grupo                 varchar(50)  NULL,
  Categoria             varchar(50)  NULL,
  Familia               varchar(50)  NULL,
  Linea                 varchar(50)  NULL,
  Fabricante            varchar(50)  NULL,
  Proveedor             varchar(10)  NULL,
  Nombre                varchar(100) NULL,
  Almacen               varchar(10)  NULL,
  AlmacenNombre         varchar(100) NULL,
  Articulo              varchar(20)  NULL,
  SubCuenta             varchar(20)  NULL,
  Descripcion1          varchar(100) NULL,
  Descripcion2          varchar(255) NULL,
  NombreCorto           varchar(20)  NULL,
  Unidad                varchar(50)  NULL,
  ABC                   varchar(50)  NULL,
  Maximo                float        NULL,
  Minimo                float        NULL,
  VentaPromedio         float        NULL,
  Precio                float        NULL,
  ImporteTotal          float        NULL,
  Existencia            float        NULL,
  EnCompra              float        NULL,
  PorRecibir            float        NULL,
  PorEntregar           float        NULL,
  Disponible            float        NULL,
  DiasInvInicio         float        NULL,
  AlmacenD              varchar(10)  NULL,
  AlmacenNombreD        varchar(100) NULL,
  MaximoD               float        NULL,
  MinimoD               float        NULL,
  VentaPromedioD        float        NULL,
  ExistenciaD           float        NULL,
  EnCompraD             float        NULL,
  PorRecibirD           float        NULL,
  PorEntregarD          float        NULL,
  DisponibleD           float        NULL,
  DiasInvD              float        NULL,
  Solicitar             float        NULL,
  Cantidad              float        NULL,
  CantidadA             float        NULL,
  DiasInvFin            float        NULL,
  Tipo                  varchar(20)  NULL,
  Movimiento            varchar(20)  NULL,
  Aplicar               bit          NULL,
  CONSTRAINT priPlanArtMaxMinTemp PRIMARY KEY CLUSTERED (ID)
 )
GO

/************************  PlanArtMaxMinHist  **********************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'PlanArtMaxMinHist' AND TYPE = 'U')
CREATE TABLE PlanArtMaxMinHist (
  ID                    int          NOT NULL,
  Empresa               char(5)      NOT NULL,
  Sucursal              int          NOT NULL,
  Usuario               varchar(10)  NOT NULL,
  Estacion              int          NOT NULL,
  Corrida               int          NULL,
  Grupo                 varchar(50)  NULL,
  Categoria             varchar(50)  NULL,
  Familia               varchar(50)  NULL,
  Linea                 varchar(50)  NULL,
  Fabricante            varchar(50)  NULL,
  Proveedor             varchar(10)  NULL,
  Nombre                varchar(100) NULL,
  Almacen               varchar(10)  NULL,
  AlmacenNombre         varchar(100) NULL,
  Articulo              varchar(20)  NULL,
  SubCuenta             varchar(20)  NULL,
  Descripcion1          varchar(100) NULL,
  Descripcion2          varchar(255) NULL,
  NombreCorto           varchar(20)  NULL,
  Unidad                varchar(50)  NULL,
  ABC                   varchar(50)  NULL,
  Maximo                float        NULL,
  Minimo                float        NULL,
  VentaPromedio         float        NULL,
  Precio                float        NULL,
  ImporteTotal          float        NULL,
  Existencia            float        NULL,
  EnCompra              float        NULL,
  PorRecibir            float        NULL,
  PorEntregar           float        NULL,
  Disponible            float        NULL,
  DiasInvInicio         float        NULL,
  AlmacenD              varchar(10)  NULL,
  AlmacenNombreD        varchar(100) NULL,
  MaximoD               float        NULL,
  MinimoD               float        NULL,
  VentaPromedioD        float        NULL,
  ExistenciaD           float        NULL,
  EnCompraD             float        NULL,
  PorRecibirD           float        NULL,
  PorEntregarD          float        NULL,
  DisponibleD           float        NULL,
  DiasInvD              float        NULL,
  Solicitar             float        NULL,
  Cantidad              float        NULL,
  CantidadA             float        NULL,
  DiasInvFin            float        NULL,
  Tipo                  varchar(20)  NULL,
  Movimiento            varchar(20)  NULL,
  Aplicar               bit          NULL,
  CONSTRAINT priPlanArtMaxMinHist PRIMARY KEY CLUSTERED (ID)
 )
GO
EXEC spADD_INDEX PlanArtMaxMinHist, 'Principal', 'Articulo, SubCuenta, Almacen, Usuario, Estacion, Empresa'
EXEC spADD_INDEX PlanArtMaxMinHist, 'Articulo', 'Articulo, SubCuenta'
EXEC spADD_INDEX PlanArtMaxMinHist, 'Tipo', 'Tipo'
EXEC spADD_INDEX PlanArtMaxMinHist, 'Almacen', 'Almacen, AlmacenD'
GO

/*************************** PlanArtMaxMinLog  *****************************************/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'PlanArtMaxMinLog' AND Type = 'U')
CREATE TABLE PlanArtMaxMinLog(
  Empresa               varchar(5)    NULL,
  Sucursal              int           NULL,
  Usuario               varchar(10)   NULL,
  Estacion              int           NULL,
  Corrida               int           NULL,
  Almacen               varchar(10)   NULL,
  AlmacenDestino        varchar(10)   NULL,
  Reservar              bit           NULL,
  InvID                 int           NULL,
  InvMov                varchar(20)   NULL,
  InvMovId              varchar(20)   NULL,
  Estatus               varchar(15)   NULL,
  FechaLog              datetime      NULL,
  Observacion           varchar(4000) NULL
)
GO


/********************************************************/
/******************* Configuracion **********************/
/********************************************************/
EXEC spALTER_TABLE 'Alm', 'CEDIS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Alm', 'CompraDirecta', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'ArtAlm', 'ABC', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtAlm', 'VentaPromedio', 'float NULL'
GO

EXEC spALTER_TABLE 'ABC', 'Desde', 'float NULL'
EXEC spALTER_TABLE 'ABC', 'Hasta', 'float NULL'
GO

