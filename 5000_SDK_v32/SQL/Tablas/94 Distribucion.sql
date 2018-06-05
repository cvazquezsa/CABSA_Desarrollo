SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****** AlmDist ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'AlmDist' AND Type = 'U')
CREATE TABLE AlmDist(
  Empresa               varchar(5)   NOT NULL,
  Almacen               varchar(10)  NOT NULL,
  Nombre                varchar(20)  NOT NULL,
  Porcentaje            float        NULL,
  Distribuir            bit          NULL,
  EsOrigen              bit          NULL,
  EsDestino             bit          NULL,
  CONSTRAINT PriAlmDist PRIMARY KEY (Empresa,Almacen)
)
GO

EXEC spALTER_TABLE 'AlmDist', 'EsOrigen', 'bit NULL'
EXEC spALTER_TABLE 'AlmDist', 'EsDestino', 'bit NULL'
GO

/****** DistribucionCfg ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistribucionCfg' AND Type = 'U')
CREATE TABLE DistribucionCfg(
  Empresa                varchar(5)  NOT NULL,
  Estatus                varchar(15) NOT NULL,
  Consecutivo            bit         NOT NULL DEFAULT 0,
  Reservar               bit         NOT NULL DEFAULT 0,
  CONSTRAINT PriDistribucionCfg PRIMARY KEY (Empresa)
)
GO

/****** Distribucion ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'Distribucion' AND Type = 'U')
CREATE TABLE Distribucion(
  Empresa               varchar(5)   NOT NULL,
  Sucursal              int          NOT NULL,
  Usuario               varchar(10)  NOT NULL,
  Estacion              int          NOT NULL,
  Corrida               int          NOT NULL,
  Almacen               varchar(10)  NOT NULL,
  AlmacenDestino        varchar(10)  NOT NULL,
  Articulo              varchar(20)  NOT NULL,
  SubCuenta             varchar(50)  NOT NULL,
  Cantidad              float        NOT NULL,
  FechaRegistro         datetime     NULL DEFAULT GETDATE(),
  FechaProcesado        datetime     NULL,
  Procesado             bit          NULL DEFAULT 0,
  CONSTRAINT PriDistribucion PRIMARY KEY (Empresa,Corrida,Almacen,AlmacenDestino,Articulo,SubCuenta)
)
GO

/****** DistribucionHist ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistribucionHist' AND Type = 'U')
CREATE TABLE DistribucionHist(
  Empresa               varchar(5)   NULL,
  Sucursal              int          NULL,
  Usuario               varchar(10)  NULL,
  Estacion              int          NULL,
  Corrida               int          NULL,
  Almacen               varchar(10)  NULL,
  AlmacenDestino        varchar(10)  NULL,
  Articulo              varchar(20)  NULL,
  SubCuenta             varchar(50)  NULL,
  Cantidad              float        NULL,
  FechaRegistro         datetime     NULL,
  FechaProcesado        datetime     NULL,
  Procesado             bit          NULL
)
GO

/****** DistribucionT ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistribucionT' AND Type = 'U')
CREATE TABLE DistribucionT(
  Empresa               varchar(5)   NULL,
  Sucursal              int          NULL,
  Usuario               varchar(10)  NULL,
  Estacion              int          NULL,
  Corrida               int          NULL,
  Almacen               varchar(10)  NULL,
  AlmacenDestino        varchar(10)  NULL,
  Articulo              varchar(20)  NULL,
  SubCuenta             varchar(50)  NULL,
  Cantidad              float        NULL,
  FechaRegistro         datetime     NULL DEFAULT GETDATE(),
  FechaProcesado        datetime     NULL,
  Procesado             bit          NULL DEFAULT 0
)
GO

/****** DistCorrida ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistCorrida' AND Type = 'U')
CREATE TABLE DistCorrida(
  Empresa               varchar(5)   NOT NULL,
  Corrida               int          NOT NULL
)
GO

/****** DistInvLog ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistInvLog' AND Type = 'U')
CREATE TABLE DistInvLog(
  Empresa               varchar(5)    NOT NULL,
  Sucursal              int           NULL,
  Usuario               varchar(10)   NULL,
  Estacion              int           NULL,
  Corrida               int           NOT NULL,
  Almacen               varchar(10)   NULL,
  AlmacenDestino        varchar(10)   NULL,
  Reservar              bit           NULL,
  InvID                 int           NOT NULL,
  InvMov                varchar(20)   NULL,
  InvMovId              varchar(20)   NULL,
  Estatus               varchar(15)   NULL,
  FechaLog              datetime      NULL,
  Observacion           varchar(4000) NULL
)
GO

/****** DistArtUnidad ******/
IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE Name = 'DistArtUnidad' AND Type = 'U')
CREATE TABLE DistArtUnidad(
  Empresa               varchar(5)  NOT NULL,
  Articulo              varchar(20) NOT NULL,
  SubCuenta             varchar(50) NOT NULL DEFAULT '',
  Unidad                varchar(50) NULL,
  Factor                float       NOT NULL DEFAULT 1,
  Peso                  float       NULL,
  Volumen               float       NULL,
  CONSTRAINT PriDistArtUnidad PRIMARY KEY (Empresa,Articulo,SubCuenta)
)
GO

