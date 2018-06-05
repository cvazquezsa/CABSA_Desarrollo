EXEC spDROP_TABLE 'RSSArtFuente', 2916
EXEC spDROP_TABLE 'RSSCanal', 2916
EXEC spDROP_TABLE 'RSS', 2916
GO

-- spRSSCanal @Canal (XML del RSS, UPDATE RSSCanal SET Actualizar = 0
-- spRSSCanalLista  (SELECT Canal, Archivo FROM RSSCanal WHERE Estatus = 'ALTA' AND Actualizar = 1)
-- drop table RSSCanalCat

/****** Categorias de Canal RSS ******/
if not exists(select * from SysTabla where SysTabla = 'RSSCanalCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RSSCanalCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RSSCanalCat') and type = 'U') 
CREATE TABLE dbo.RSSCanalCat (
	Categoria 		varchar(50) 	NOT NULL ,

	Imagen			bit		NULL	DEFAULT 0,
	ImagenTitulo		varchar(100)	NULL,
	ImagenURL		varchar(100)	NULL,
	ImagenHipervinculo	varchar(100)	NULL,
	ImagenAlto		int		NULL,
	ImagenAncho		int		NULL,

	CONSTRAINT priRSSCanalCat PRIMARY KEY CLUSTERED (Categoria)
)
GO

-- drop table RSSCanalTipo
/****** RSSCanalTipo ******/
if not exists (select * from SysTabla where SysTabla = 'RSSCanalTipo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RSSCanalTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RSSCanalTipo') and type = 'U') 
  CREATE TABLE dbo.RSSCanalTipo (
	Tipo			varchar(20)	NOT NULL,

	Lenguaje		varchar(20)	NULL,
	Copyright		varchar(100)	NULL,
	RutaXML			varchar(255)	NULL,
	ResponsableContenido	varchar(100)	NULL,
	WebMaster		varchar(100)	NULL,
	TTL			int		NULL,

	Codificacion		varchar(20)	NULL,
	CDATA			bit		NULL	DEFAULT 0,	-- character data
	Publicar		varchar(20)	NULL,
	PublicarUnidad		varchar(20)	NULL,
	GUID			varchar(255)	NULL,
	ZonaHoraria		varchar(20)	NULL,

	CONSTRAINT priRSSCanalTipo PRIMARY KEY CLUSTERED (Tipo)
  )
GO

-- drop table RSSCanal
/****** RSSCanal ******/
if not exists (select * from SysTabla where SysTabla = 'RSSCanal') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RSSCanal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.RSSCanal') and type = 'U') 
  CREATE TABLE dbo.RSSCanal (
	Canal			varchar(50)	NOT NULL,

	Titulo			varchar(100)	NULL,
	Hipervinculo		varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	ArchivoXML		varchar(255)	NULL,
	UltimoCambio		datetime	NULL,
	Categoria		varchar(50)	NULL,
	Tipo			varchar(20)	NULL,

	Actualizar		bit		NULL	DEFAULT 0,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	Estatus			varchar(15)	NULL,
	Usuario			varchar(10)	NULL,

	CONSTRAINT priRSSCanal PRIMARY KEY CLUSTERED (Canal)
  )
GO

EXEC spFK 'RSSCanal','Tipo','RSSCanalTipo','Tipo'
GO

/****** Categorias de Articulos RSS ******/
if not exists(select * from SysTabla where SysTabla = 'RSSArtCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RSSArtCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RSSArtCat') and type = 'U') 
CREATE TABLE dbo.RSSArtCat (
	Categoria 		varchar(50) 	NOT NULL ,

	CONSTRAINT priRSSArtCat PRIMARY KEY CLUSTERED (Categoria)
)
GO


/****** Origenes Articulos RSS ******/
if not exists(select * from SysTabla where SysTabla = 'RSSArtOrigen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RSSArtOrigen','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RSSArtOrigen') and type = 'U') 
CREATE TABLE dbo.RSSArtOrigen (
	ArtOrigen	varchar(50) 	NOT NULL ,

	Hipervinculo	varchar(255)	NULL,

	CONSTRAINT priRSSArtOrigen PRIMARY KEY CLUSTERED (ArtOrigen)
)
GO


/****** Consecutivos RSS ******/
if not exists(select * from SysTabla where SysTabla = 'RSSC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RSSC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.RSSC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RSSC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priRSSC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'RSSC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'RSSC', '(ID)'
GO

-- drop table RSS
/****** RSS (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'RSS')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('RSS','Movimiento','RSS')
if not exists (select * from sysobjects where id = object_id('dbo.RSS') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RSS (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	FechaPublicacion	datetime	NULL,
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		char(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Canal			varchar(50)	NULL,
	Titulo			varchar(255)	NULL,
	Hipervinculo		varchar(255)	NULL,
	Descripcion		text		NULL,
	Comentarios		text		NULL,
	Autor			varchar(10)	NULL,
	Categoria		varchar(50)	NULL,
	ArtOrigen		varchar(50)	NULL,

	Adjunto			bit		NULL	DEFAULT 0,
	AdjuntoURL		varchar(255)	NULL,
	AdjuntoTamano		int		NULL,
	AdjuntoTipo		varchar(50)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priRSS PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'RSS'
END
go
EXEC spSincroNivelRegistro @Tabla = 'RSS'
go
EXEC spALTER_TABLE 'RSS', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'RSS', 'SituacionNota', 'varchar(100) NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.RSS (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.RSS (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.RSS (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.RSS (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.RSS (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.RSS (Usuario)
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX RSS.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX RSS.Situacion2
GO

EXEC spADD_INDEX 'RSS', 'Titulo', 'Titulo'
EXEC spADD_INDEX 'RSS', 'Canal', 'Canal'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgRSSA') and sysstat & 0xf = 8) drop trigger dbo.tgRSSA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRSSC') and sysstat & 0xf = 8) drop trigger dbo.tgRSSC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRSSB') and sysstat & 0xf = 8) drop trigger dbo.tgRSSB
GO
EXEC spModificarPK_Mov 'RSS'
GO
EXEC spSincroNivelRegistroCampos 'RSS'
GO
-- Aqui va el Matenimiento a la tabla

EXEC spFK 'RSS','UEN','UEN','UEN'
EXEC spFK 'RSS','Proyecto','Proy','Proyecto'
EXEC spFK 'RSS','Autor','Agente','Agente'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON RSS (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON RSS (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RSS' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON RSS (OrigenID,Origen,Empresa)
go


GO
CREATE TRIGGER tgRSSC ON RSS
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
  
  SELECT @Modulo = 'RSS'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'ALTAPRIORIDAD', 'PRIORIDADBAJA', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
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
/*  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE RSS SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO
CREATE TRIGGER tgRSSB ON RSS
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
    EXEC spMovAlEliminar 'RSS', @ID
END
GO
