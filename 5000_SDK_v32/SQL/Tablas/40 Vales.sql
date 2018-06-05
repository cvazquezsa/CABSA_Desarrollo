
/*******************************************************************************************/
/*                                            Vales                                        */
/*******************************************************************************************/

/****** Consecutivos (Vale) ******/
if not exists(select * from SysTabla where SysTabla = 'ValeC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ValeC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ValeC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ValeC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priValeC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ValeC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ValeC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE ValeC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE ValeC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** Vale ******/
if not exists(select * from SysTabla where SysTabla = 'Vale')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Vale','Movimiento','Vale')
if not exists (select * from sysobjects where id = object_id('dbo.Vale') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Vale (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		char(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		char(15)   	NULL,
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

	Cliente 		char(10)   	NULL,
	Agente 			char(10)   	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	Tipo			varchar(50)	NULL,
	Precio			money		NULL,
	Importe			money		NULL,
	Cantidad		int		NULL,
	FechaInicio		datetime	NULL,
	FechaTermino		datetime	NULL,
	Descuento		varchar(30)   	NULL,
	DescuentoGlobal 	float 	    	NULL,  -- % de descuento global
	CtaDinero		char(10)	NULL,
	FormaPago		varchar(50)	NULL,
	TarjetaDestino	varchar(20) NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priVale PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Vale'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Vale'
go

-- Vale
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Vale (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Vale (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Vale (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Vale (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Vale (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Vale (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Vale.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Vale.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Vale.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Vale.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Vale.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Vale (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Vale (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Vale' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Vale (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgValeA') and sysstat & 0xf = 8) drop trigger dbo.tgValeA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgValeC') and sysstat & 0xf = 8) drop trigger dbo.tgValeC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgValeB') and sysstat & 0xf = 8) drop trigger dbo.tgValeB
GO
EXEC spSincroNivelRegistroCampos 'Vale'
GO
EXEC spModificarPK_Mov 'Vale'
GO
EXEC spALTER_TABLE 'Vale', 'Precio', 'money NULL'
EXEC spALTER_TABLE 'Vale', 'CtaDinero', 'char(10) NULL'
EXEC spALTER_TABLE 'Vale', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Vale', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Vale', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Vale', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Vale', 'Articulo', 'varchar(20) NULL'	-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'Vale', 'Almacen', 'varchar(20) NULL'	-- ETO Tarjetas 9-Feb-2007
EXEC SPALTER_TABLE 'Vale', 'TarjetaDestino', 'varchar(20) NULL'
GO

EXEC spFK 'Vale','Moneda','Mon','Moneda'
EXEC spFK 'Vale','Tipo','ValeTipo','Tipo'
EXEC spFK 'Vale','Descuento','Descuento','Descuento'
EXEC spFK 'Vale','UEN','UEN','UEN'
EXEC spFK 'Vale','Articulo','Art','Articulo'
GO

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgValeC ON Vale
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		char(5),
    @Mov		char(20),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	char(15),
    @EstatusAnterior 	char(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @Usuario		char(10),
    @Mensaje		char(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'VALE'
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
    UPDATE Vale SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgValeB ON Vale
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	char(15),
    @Mensaje	char(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'VALE', @ID
END
GO

/****** ValeD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ValeD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ValeD','Movimiento','Vale')
if not exists (select * from sysobjects where id = object_id('dbo.ValeD') and type = 'U') 
CREATE TABLE dbo.ValeD (
	ID 			int       	NOT NULL,
	Serie			varchar(20)	NOT NULL,

	CONSTRAINT priValeD PRIMARY KEY CLUSTERED (ID, Serie)
)
go
EXEC spModificarPK_Sucursal 'ValeD', '(ID, Serie)'
GO

EXEC spALTER_TABLE 'ValeD', 'Importe', 'money NULL'	-- ETO Tarjetas 9-Feb-2007
GO

EXEC spFK 'ValeD','Serie','ValeSerie','Serie'
GO

if exists (select * from sysobjects where id = object_id('dbo.cValeD') and sysstat & 0xf = 2) drop view dbo.cValeD
GO
CREATE VIEW cValeD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Serie,

  Sucursal,
  SucursalOrigen

FROM
  ValeD
GO


/****** ValeTipo ******/
if not exists(select * from SysTabla where SysTabla = 'ValeTipo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ValeTipo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ValeTipo') and type = 'U') 
  CREATE TABLE dbo.ValeTipo (
	Tipo			varchar(50)	NOT NULL,
	Precio			money		NULL,
	Moneda			char(10)	NULL,
	TieneVigencia		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priValeTipo PRIMARY KEY  CLUSTERED (Tipo)
  )
GO


/****** ValeSerie ******/
if (select version from version)<=2279 
  delete SysTabla where SysTabla = 'ValeSerie'
go
if not exists(select * from SysTabla where SysTabla = 'ValeSerie')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ValeSerie', 'MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.ValeSerie') and type = 'U') 
  CREATE TABLE dbo.ValeSerie (
	Serie			varchar(20)	NOT NULL,

	Tipo			varchar(50)	NULL,
	Precio			money		NULL,
	Moneda			char(10)	NULL,

	FechaEmision		datetime	NULL,
	FechaInicio		datetime	NULL,
	FechaTermino		datetime	NULL,
	FechaVenta		datetime	NULL,
	FechaCobro		datetime	NULL,
	FechaBloqueo		datetime	NULL,
	FechaCancelacion	datetime	NULL,
	FechaAplicacion		datetime	NULL,
	ModuloCobro		char(5)		NULL,
	IDCobro			int		NULL,
	IDEmision		int		NULL,
	
	Cliente			char(10)	NULL,
	Estatus			char(15)	NULL,		-- DISPONIBLE, CIRCULACION, COBRADO, BLOQUEADO, CONCLUIDO, CANCELADO
	Empresa			varchar(5)	NULL

	CONSTRAINT priValeSerie PRIMARY KEY  CLUSTERED (Serie)
  )
GO
EXEC spALTER_TABLE 'ValeSerie', 'ModuloCobro', 'char(5)	NULL'
EXEC spALTER_TABLE 'ValeSerie', 'IDCobro', 'int	NULL'
EXEC spALTER_TABLE 'ValeSerie', 'TipoTarjeta', 'bit NOT NULL Default 0'  -- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'ValeSerie', 'Articulo', 'varchar(20) NULL'		-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'ValeSerie', 'IDEmision', 'int NULL'
EXEC SPALTER_TABLE 'ValeSerie', 'Empresa', 'varchar(5) NULL'
GO

IF (SELECT Version FROM Version)<=3252
	UPDATE ValeSerie SET Empresa = Vale.Empresa
	FROM Vale
	JOIN ValeD ON ValeD.ID = Vale.ID
	WHERE ValeSerie.IDEmision = Vale.ID AND ValeD.Serie = ValeSerie.Serie AND ValeSerie.Empresa IS null
GO	

/****** ValeSerieMov ******/
if not exists(select * from SysTabla where SysTabla = 'ValeSerieMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ValeSerieMov','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ValeSerieMov') and type = 'U') 
CREATE TABLE dbo.ValeSerieMov (
	Empresa			char(5)		NOT NULL,
	Modulo			char(5) 	NOT NULL,
	ID			int		NOT NULL,
	Serie			varchar(20)	NOT NULL,

	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priValeSerieMov PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, Serie)
)
GO
EXEC spModificarPK_SucursalSinOrigen 'ValeSerieMov', '(Empresa, Modulo, ID, Serie)'
GO

EXEC spFK 'ValeSerieMov','Serie','ValeSerie','Serie'
GO

/****** TarjetaSerieMov ******/		-- ETO Tarjetas 9-Feb-2007
if not exists(select * from SysTabla where SysTabla = 'TarjetaSerieMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TarjetaSerieMov','Movimiento')
GO
if not exists (select * from sysobjects where id = object_id('dbo.TarjetaSerieMov') and type = 'U')
CREATE TABLE TarjetaSerieMov(
	Empresa			char(5)		NOT NULL,
	Modulo			char(5) 	NOT NULL,
	ID			int		NOT NULL,
	Serie			varchar(20)	NOT NULL,
	Importe			money		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	TipoCambioTarjeta       float           NULL,--REQ 13393 POS
	ImporteTarjeta          float           NULL,--REQ 13393 POS
	CONSTRAINT priTarjetaSerieMov PRIMARY KEY CLUSTERED (Empresa, Modulo, ID, Serie)
)
GO

--REQ 13393 POS
 EXEC spALTER_TABLE 'TarjetaSerieMov', 'TipoCambioTarjeta', 'Float  NULL'
 EXEC spALTER_TABLE 'TarjetaSerieMov', 'ImporteTarjeta', 'Float  NULL'
EXEC spFK 'TarjetaSerieMov','Serie','ValeSerie','Serie'
GO

-- Tabla para Puntos de Tarjetas por categoría de Artículos
/****** ArtCatTarjetaPuntos ******/		-- ETO Tarjetas 9-Feb-2007
if not exists(select * from SysTabla where SysTabla = 'ArtCatTarjetaPuntos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ArtCatTarjetaPuntos','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.ArtCatTarjetaPuntos') and type = 'U')
CREATE TABLE ArtCatTarjetaPuntos(
	Categoria			varchar(50),
	Porcentaje		float		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL
	CONSTRAINT priArtCatTarjetaPuntos PRIMARY KEY CLUSTERED (Categoria)
)
GO
