/************* CR **************/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ANSI_PADDING OFF
GO
/*******************************************************************************************/
/*                                            CR                                           */
/*******************************************************************************************/

/****** Consecutivos (CR) ******/
if not exists(select * from SysTabla where SysTabla = 'CRC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CRC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CRC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CRC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCRC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CRC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CRC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CRC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE CRC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** CR ******/
if not exists(select * from SysTabla where SysTabla = 'CR')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CR','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CR') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CR (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov 			varchar(20)        NOT NULL,	
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Caja	 		varchar(10)   	NULL,
	Cajero 			varchar(10)   	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	CajaFolio		int		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priCR PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CR'
END
go
EXEC spSincroNivelRegistro @Tabla = 'CR'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo  ON dbo.CR (Mov, MovID, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario      ON dbo.CR (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion    ON dbo.CR (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	    ON dbo.CR (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.CR (Referencia)
go

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON CR (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON CR (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CR' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON CR (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgCRA') and sysstat & 0xf = 8) drop trigger dbo.tgCRA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCRC') and sysstat & 0xf = 8) drop trigger dbo.tgCRC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCRB') and sysstat & 0xf = 8) drop trigger dbo.tgCRB
GO
EXEC spSincroNivelRegistroCampos 'CR'
GO
EXEC spModificarPK_Mov 'CR'
GO
EXEC spALTER_TABLE 'CR', 'CajaFolio', 'int NULL'
EXEC spALTER_TABLE 'CR', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CR', 'SituacionNota', 'varchar(100)	NULL'
GO
-- Aqui va el Matenimiento a la tabla

EXEC spFK 'CR','Moneda','Mon','Moneda'
EXEC spFK 'CR','Cajero','Agente','Agente'
EXEC spFK 'CR','Caja','CtaDinero','CtaDinero'
EXEC spFK 'CR','UEN','UEN','UEN'
GO

GO
CREATE TRIGGER tgCRC ON CR
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		varchar(10),
    @Mensaje		varchar(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'CR'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END 
  ELSE BEGIN
    IF @EstatusNuevo NOT IN (NULL, 'AFECTANDO') AND (@EstatusAnterior <> @EstatusNuevo OR @SituacionAnterior <> @SituacionNueva)
    BEGIN
      IF @EstatusAnterior <> @EstatusNuevo AND (@EstatusAnterior <> 'AFECTANDO' OR @SituacionAnterior IS NULL OR @SituacionNueva IS NULL)
      BEGIN
        EXEC spMovSituacionNueva @Modulo, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva OUTPUT, @ID = @ID
      END
      SELECT @Ahora = GETDATE(), @FechaInicio = NULL
      SELECT @FechaInicio = MIN(FechaInicio), @FechaAnterior = MAX(FechaComenzo) FROM MovTiempo WHERE Modulo = @Modulo AND ID = @ID
      IF @FechaInicio IS NOT NULL AND @FechaAnterior IS NOT NULL
        UPDATE MovTiempo SET FechaTermino = @Ahora WHERE Modulo = @Modulo AND ID = @ID AND FechaComenzo = @FechaAnterior
      IF @FechaInicio IS NULL SELECT @FechaInicio = @Ahora

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,                              FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @Usuario), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior

  -- Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE CR SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgCRB ON CR
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'CR', @ID
END
GO


/****** CRCaja ******/
if not exists(select * from SysTabla where SysTabla = 'CRCaja')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRCaja','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRCaja') and type = 'U') 
CREATE TABLE dbo.CRCaja (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Movimiento		varchar(20)	NULL,		-- Apertura/Recoleccion/Corte
	CtaDinero		varchar(10)	NULL,
	FormaPago		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	FechaEmision		datetime	NULL,
	Concepto		varchar(50)	NULL,

	CONSTRAINT priCRCaja PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CRCaja', '(ID, Renglon)'
GO
EXEC spSincroNivelRegistro @Tabla = 'CRCaja'
GO
EXEC spALTER_TABLE 'CRCaja', 'Moneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CRCaja', 'TipoCambio', 'float NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'CRCaja', 'FechaEmision', 'datetime NULL'
EXEC spALTER_TABLE 'CRCaja', 'Concepto', 'varchar(50) NULL'
GO
IF (SELECT Version FROM Version)<=3085
  ALTER TABLE CRCaja ALTER COLUMN FormaPago varchar(50) NULL
GO
if exists (select * from sysobjects where id = object_id('dbo.cCRCaja') and sysstat & 0xf = 2) drop view dbo.cCRCaja
GO
CREATE VIEW cCRCaja
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Movimiento,
  CtaDinero,
  FormaPago,
  Referencia,
  Importe,
  Moneda,
  TipoCambio,
  FechaEmision,
  Concepto

FROM
  CRCaja
GO

/****** CRCFD ******/
if not exists(select * from SysTabla where SysTabla = 'CRCFD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRCFD','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRCFD') and type = 'U') 
CREATE TABLE dbo.CRCFD (

		Empresa			varchar(5) NOT NULL,
		Sucursal		int NOT NULL,
		CFDSerie		varchar(20) NOT NULL,
		CFDFolio		varchar(20) NOT NULL,
		
		FechaTrabajo	datetime NULL,
		ID				int NULL,
		CFDID			int NULL,
		Registro		nvarchar(max) NULL,
		CadenaOriginal	varchar(max) NULL,
				
		ModuloID		int NULL,
		MovID			varchar(20) NULL,
		
		Estatus			varchar(15) NULL DEFAULT 'PENDIENTE',
		
	CONSTRAINT priCRCFD PRIMARY KEY CLUSTERED (CFDFolio, CFDSerie, Sucursal, Empresa)
)
go

/****** CRVenta ******/
if not exists(select * from SysTabla where SysTabla = 'CRVenta')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRVenta','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRVenta') and type = 'U') 
CREATE TABLE dbo.CRVenta (
	ID 			int       	NOT NULL,
	Cxc			bit		NOT NULL	DEFAULT 0,
	Renglon			float		NOT NULL,

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Precio			float		NULL,
        DescuentoLinea		float		NULL,
	Importe			money		NULL,
	Operaciones		int		NULL,
	Cliente			varchar(10)	NULL,
	ClienteEnviarA		int		NULL,
	Almacen			varchar(10)	NULL,
	Posicion		varchar(10)	NULL,
	DescripcionExtra	varchar(100) 	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
    CFDSerie		varchar(20) NULL, --MEJORA3051
    CFDFolio		varchar(20) NULL, --MEJORA3051

	CONSTRAINT priCRVenta PRIMARY KEY CLUSTERED (ID, Cxc, Renglon)
)
go
EXEC spSincroNivelRegistro @Tabla = 'CRVenta'
GO
EXEC spALTER_TABLE 'CRVenta', 'SubCuenta', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'CRVenta', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CRVenta', 'Cxc', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CRVenta', 'Almacen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CRVenta', 'Precio', 'float NULL'
EXEC spALTER_TABLE 'CRVenta', 'DescuentoLinea', 'float NULL'
EXEC spALTER_TABLE 'CRVenta', 'DescripcionExtra', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CRVenta', 'Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CRVenta', 'MovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CRVenta', 'CFDSerie', 'varchar(20) NULL' --MEJORA3051
EXEC spALTER_TABLE 'CRVenta', 'CFDFolio', 'varchar(20) NULL' --MEJORA3051
GO
if not exists(select * from syscampo where tabla = 'CRVenta' AND Campo = 'Cxc')
BEGIN
  EXEC("ALTER TABLE CRVenta ALTER COLUMN Cxc bit NOT NULL DEFAULT 0 WITH VALUES")
  EXEC("spEliminarPK 'CRVenta'")
  EXEC("ALTER TABLE CRVenta ADD CONSTRAINT priCRVenta PRIMARY KEY CLUSTERED (ID, Cxc, Renglon)")
END
GO
EXEC spModificarPK_Sucursal 'CRVenta', '(ID, Cxc, Renglon)'
go

EXEC spALTER_TABLE 'CRVenta', 'ClienteEnviarA', 'int NULL'
EXEC spALTER_TABLE 'CRVenta', 'Posicion', 'varchar(10) NULL'
go

EXEC spFK2 'CRVenta','Cliente','ClienteEnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'CRVenta','Articulo','Art','Articulo'
EXEC spFK 'CRVenta','Cliente','Cte','Cliente'
EXEC spFK 'CRVenta','Almacen','Alm','Almacen'
GO

if exists (select * from sysobjects where id = object_id('dbo.CRVentaCxc') and sysstat & 0xf = 2) drop view dbo.CRVentaCxc
GO
CREATE VIEW CRVentaCxc
--//WITH ENCRYPTION
AS
SELECT * FROM CRVenta
GO

if exists (select * from sysobjects where id = object_id('dbo.cCRVenta') and sysstat & 0xf = 2) drop view dbo.cCRVenta
GO
CREATE VIEW cCRVenta
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Cxc,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Articulo,
  SubCuenta,
  Cantidad,
  Precio,
  DescuentoLinea,
  Importe,
  Operaciones,
  Almacen,
  Posicion,
  Cliente,
  ClienteEnviarA,
  DescripcionExtra ,
  Mov,
  MovID

FROM
  CRVenta
GO

/****** CRAgente ******/
if not exists(select * from SysTabla where SysTabla = 'CRAgente')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRAgente','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRAgente') and type = 'U') 
CREATE TABLE dbo.CRAgente (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Agente			varchar(10)	NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,
	Operaciones		int		NULL,

	CONSTRAINT priCRAgente PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CRAgente', '(ID, Renglon)'
GO
EXEC spSincroNivelRegistro @Tabla = 'CRAgente'
GO

if exists (select * from sysobjects where id = object_id('dbo.cCRAgente') and sysstat & 0xf = 2) drop view dbo.cCRAgente
GO
CREATE VIEW cCRAgente
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Agente,
  Cantidad,
  Importe,
  Operaciones

FROM
  CRAgente
GO


/****** CRCobro ******/
if not exists(select * from SysTabla where SysTabla = 'CRCobro')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRCobro','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRCobro') and type = 'U') 
CREATE TABLE dbo.CRCobro (
	ID 			int       	NOT NULL,
	Cxc			bit		NOT NULL	DEFAULT 0,
	Renglon			float		NOT NULL,

	FormaPago		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Importe			money		NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Cliente			varchar(10)	NULL,
	ClienteEnviarA		int		NULL,
	Vencimiento		datetime	NULL,
	
    CFDSerie		varchar(20) NULL, --MEJORA3051
    CFDFolio        varchar(20) NULL, --MEJORA3051
	
	CONSTRAINT priCRCobro PRIMARY KEY CLUSTERED (ID, Cxc, Renglon)
)
go
EXEC spSincroNivelRegistro @Tabla = 'CRCobro'
GO
EXEC spALTER_TABLE 'CRCobro', 'Moneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CRCobro', 'TipoCambio', 'float NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'CRCobro', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CRCobro', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'CRCobro', 'Cxc', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CRCobro', 'CFDSerie', 'varchar(20) NULL' --MEJORA3051
EXEC spALTER_TABLE 'CRCobro', 'CFDFolio', 'varchar(20) NULL' --MEJORA3051
GO
if (select version from version)<=2688
BEGIN
  EXEC("ALTER TABLE CRCobro ALTER COLUMN Cxc bit NOT NULL")
  EXEC("spEliminarPK 'CRCobro'")
  EXEC("ALTER TABLE CRCobro ADD CONSTRAINT priCRCobro PRIMARY KEY CLUSTERED (ID, Cxc, Renglon)")
END
GO
EXEC spModificarPK_Sucursal 'CRCobro', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'CRCobro', 'ClienteEnviarA', 'int NULL'
GO
IF (SELECT Version FROM Version)<=3085
  ALTER TABLE CRCobro ALTER COLUMN FormaPago varchar(50) NULL
GO

EXEC spFK2 'CRCobro','Cliente','ClienteEnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'CRCobro','Cliente','Cte','Cliente'
GO

if exists (select * from sysobjects where id = object_id('dbo.CRCobroCxc') and sysstat & 0xf = 2) drop view dbo.CRCobroCxc
GO
CREATE VIEW CRCobroCxc
--//WITH ENCRYPTION
AS
SELECT * FROM CRCobro
GO

if exists (select * from sysobjects where id = object_id('dbo.cCRCobro') and sysstat & 0xf = 2) drop view dbo.cCRCobro
GO
CREATE VIEW cCRCobro
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Cxc,
  Renglon,

  Sucursal,
  SucursalOrigen,

  FormaPago,
  Referencia,
  Importe,
  Moneda,
  TipoCambio,
  Cliente,
  ClienteEnviarA,
  Vencimiento

FROM
  CRCobro
GO

/****** CRSoporte ******/
if not exists(select * from SysTabla where SysTabla = 'CRSoporte')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRSoporte','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRSoporte') and type = 'U') 
CREATE TABLE dbo.CRSoporte (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Mov			varchar(20)	NULL,
	Cliente			varchar(10)	NULL,
	Contacto		varchar(50)	NULL,
	Telefono		varchar(30)	NULL,
	Titulo			varchar(100)	NULL,
	Problema		text		NULL,

	CONSTRAINT priCRSoporte PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CRSoporte', '(ID, Renglon)'
GO
EXEC spSincroNivelRegistro @Tabla = 'CRSoporte'
GO
EXEC spALTER_TABLE 'CRSoporte', 'Contacto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CRSoporte', 'Telefono', 'varchar(30) NULL'
GO

EXEC spFK 'CRSoporte','Cliente','Cte','Cliente'
GO

if exists (select * from sysobjects where id = object_id('dbo.cCRSoporte') and sysstat & 0xf = 2) drop view dbo.cCRSoporte
GO
CREATE VIEW cCRSoporte
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Mov,
  Cliente,
  Contacto, 
  Telefono,
  Titulo,
  Problema

FROM
  CRSoporte
GO


/****** CRInvFisico ******/
if (select version from version)<=2669 delete SysTabla where SysTabla = 'CRInvFisico'
go
if not exists(select * from SysTabla where SysTabla = 'CRInvFisico')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRInvFisico','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRInvFisico') and type = 'U') 
CREATE TABLE dbo.CRInvFisico (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Posicion		varchar(10)	NULL,

	CONSTRAINT priCRInvFisico PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CRInvFisico', '(ID, Renglon)'
GO
EXEC spSincroNivelRegistro @Tabla = 'CRInvFisico'
GO
EXEC spALTER_TABLE 'CRInvFisico', 'Posicion', 'varchar(10) NULL'
GO

EXEC spFK 'CRInvFisico','Articulo','Art','Articulo'
GO

-- select * from crinvfisico
if exists (select * from sysobjects where id = object_id('dbo.cCRInvFisico') and sysstat & 0xf = 2) drop view dbo.cCRInvFisico
GO
CREATE VIEW cCRInvFisico
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Articulo,
  SubCuenta,
  Cantidad,
  Unidad,
  Posicion

FROM
  CRInvFisico
GO


/****** CRTrans ******/
if (select version from version)<=2669 delete SysTabla where SysTabla = 'CRTrans'
go
if not exists(select * from SysTabla where SysTabla = 'CRTrans')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CRTrans','Movimiento','CR')
if not exists (select * from sysobjects where id = object_id('dbo.CRTrans') and type = 'U') 
CREATE TABLE dbo.CRTrans (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	AlmacenOrigen		varchar(10)	NULL,
	AlmacenDestino		varchar(10)	NULL,
	Posicion		varchar(10)	NULL,

	CONSTRAINT priCRTrans PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CRTrans', '(ID, Renglon)'
GO
EXEC spSincroNivelRegistro @Tabla = 'CRTrans'
GO
EXEC spALTER_TABLE 'CRTrans', 'Posicion', 'varchar(10) NULL'
GO

EXEC spFK 'CRTrans','Articulo','Art','Articulo'
EXEC spFK 'CRTrans','AlmacenOrigen','Alm','Almacen'
GO

-- select * from CRTrans
if exists (select * from sysobjects where id = object_id('dbo.cCRTrans') and sysstat & 0xf = 2) drop view dbo.cCRTrans
GO
CREATE VIEW cCRTrans
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Sucursal,
  SucursalOrigen,

  Articulo,
  SubCuenta,
  Cantidad,
  Unidad,
  AlmacenOrigen,
  AlmacenDestino,
  Posicion

FROM
  CRTrans
GO

/******* CRD *****/  
if exists (select * from sysobjects where id = object_id('dbo.CRD') and sysstat & 0xf = 2) drop view dbo.CRD
GO
CREATE VIEW CRD
--//WITH ENCRYPTION
AS
SELECT
  Orden = 1,
  SubOrden = 1,
  Tipo = CONVERT(varchar(20), 'Ventas'),
  ID,
  Renglon,
  Sucursal,
  Importe,
  "ImporteNeto" = CASE WHEN Cxc = 0 THEN Importe ELSE CONVERT(money, NULL) END,
  Articulo,
  SubCuenta,
  Agente     = CONVERT(varchar(10), NULL),
  Cantidad,
  Operaciones,
  FormaPago    = CONVERT(varchar(50), NULL),
  Movimiento   = CONVERT(varchar(20), NULL),
  CtaDinero    = CONVERT(varchar(10), NULL),
  Referencia   = CONVERT(varchar(50), NULL),
  Concepto     = CONVERT(varchar(50), NULL),
  FechaEmision = CONVERT(datetime, NULL),
  Almacen,
  Posicion,
  Cliente,
  Cxc,
  Vencimiento = CONVERT(datetime, NULL),
  DescripcionExtra 

FROM
  CRVenta

UNION

SELECT
  Orden = 2,
  SubOrden = 1,
  Tipo = CONVERT(varchar(20), 'Vendedores'),
  ID,
  Renglon,
  Sucursal,
  Importe,
  "ImporteNeto" = CONVERT(money, NULL),
  Articulo   = CONVERT(varchar(20), NULL),
  SubCuenta  = CONVERT(varchar(50), NULL),
  Agente,
  Cantidad,
  Operaciones,
  FormaPago    = CONVERT(varchar(50), NULL),
  Movimiento   = CONVERT(varchar(20), NULL),
  CtaDinero    = CONVERT(varchar(10), NULL),
  Referencia   = CONVERT(varchar(50), NULL),
  Concepto     = CONVERT(varchar(50), NULL),
  FechaEmision = CONVERT(datetime, NULL),
  Almacen      = CONVERT(varchar(10), NULL),
  Posicion     = CONVERT(varchar(10), NULL),
  Cliente      = CONVERT(varchar(10), NULL),
  Cxc          = CONVERT(bit, 0),
  Vencimiento  = CONVERT(datetime, NULL),
  DescripcionExtra = CONVERT(varchar(100), NULL)

FROM
  CRAgente

UNION

SELECT
  Orden = 3,
  SubOrden = 1,
  Tipo = CONVERT(varchar(20), 'Cobros'),
  ID,
  Renglon,
  Sucursal,
  "Importe" = Importe*TipoCambio,
  "ImporteNeto" = CASE WHEN Cxc = 0 THEN Importe*TipoCambio ELSE CONVERT(money, NULL) END,
  Articulo    = CONVERT(varchar(20), NULL),
  SubCuenta   = CONVERT(varchar(50), NULL),
  Agente      = CONVERT(varchar(10), NULL),
  Cantidad    = CONVERT(float, NULL),
  Operaciones = CONVERT(int, NULL),
  FormaPago,
  Movimiento  = CONVERT(varchar(20), NULL),
  CtaDinero   = CONVERT(varchar(10), NULL),
  Referencia,
  Concepto     = CONVERT(varchar(50), NULL),
  FechaEmision = CONVERT(datetime, NULL),
  Almacen      = CONVERT(varchar(10), NULL),
  Posicion     = CONVERT(varchar(10), NULL),
  Cliente,
  Cxc,
  Vencimiento,
  DescripcionExtra = CONVERT(varchar(100), NULL)

FROM
  CRCobro

UNION

SELECT
  Orden = 3,
  SubOrden = 2,
  Tipo = CONVERT(varchar(20), 'Caja'),
  ID,
  Renglon,
  Sucursal,
  "Importe" = Importe*TipoCambio,
  "ImporteNeto" = CASE WHEN UPPER(Movimiento) IN ('INGRESO ANTICIPO', 'EGRESO ANTICIPO') THEN NULL WHEN UPPER(Movimiento) IN ('RECOLECCION', 'DEPOSITO', 'FALTANTE', 'ANTICIPO GASTO', 'PRESTAMO', 'GASTO', 'VENTA CREDITO') THEN -Importe ELSE Importe END*TipoCambio,
  Articulo    = CONVERT(varchar(20), NULL),
  SubCuenta   = CONVERT(varchar(50), NULL),
  Agente      = CONVERT(varchar(10), NULL),
  Cantidad    = CONVERT(float, NULL),
  Operaciones = CONVERT(int, NULL),
  FormaPago,
  Movimiento,
  CtaDinero,
  Referencia,
  Concepto,
  FechaEmision,
  Almacen      = CONVERT(varchar(10), NULL),
  Posicion     = CONVERT(varchar(10), NULL),
  Cliente      = CONVERT(varchar(10), NULL),
  Cxc          = CONVERT(bit, 0),
  Vencimiento  = CONVERT(datetime, NULL),
  DescripcionExtra = CONVERT(varchar(100), NULL)

FROM
  CRCaja
GO
-- select * from crd

