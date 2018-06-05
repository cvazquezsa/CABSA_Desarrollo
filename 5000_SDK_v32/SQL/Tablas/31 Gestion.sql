
/****** Indicadores Gestion ******/
if not exists(select * from SysTabla where SysTabla = 'GestionActivoFIndicador')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('GestionActivoFIndicador', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.GestionActivoFIndicador') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GestionActivoFIndicador (
        ID			int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),
	
	Tipo			varchar(50)	NULL,
	Indicador		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	LecturaAnterior		varchar(100)	NULL,
	Lectura			varchar(100)	NULL,
	
	CONSTRAINT priGestionActivoFIndicador PRIMARY KEY  CLUSTERED (ID, RID)
  )
END
GO

EXEC spDROP_TABLE 'GestionC', 3175
GO
/****** Consecutivos Gestion ******/
if not exists(select * from SysTabla where SysTabla = 'GestionC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('GestionC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.GestionC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.GestionC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)      NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priGestionC PRIMARY KEY  CLUSTERED (ID)
  )
END
GO

EXEC spSincroSemilla 'GestionC'
GO

EXEC spModificarPK_SucursalSinOrigen 'GestionC', '(ID)'
GO
-- drop table Gestion

EXEC spDROP_TABLE 'Gestion', 3175
GO
/****** Gestion (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Gestion')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Gestion','Movimiento','GES')
if not exists (select * from sysobjects where id = object_id('dbo.Gestion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Gestion (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Mov  			varchar(20)     NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	Referencia 		varchar(50) 	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	RamaID			int		NULL,
	IDOrigen		int		NULL,
	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,
	FechaAutorizacion	datetime    	NULL,
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Asunto			varchar(255)	NULL,
	Motivo			varchar(255)	NULL,
	Espacio			varchar(10)	NULL,
	Comentarios		text		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	TodoElDia		bit		NULL	DEFAULT 0,
	Duracion		float		NULL,
	Estado			varchar(30)	NULL,
	EstadoAnterior		varchar(30)	NULL,
	Avance			float		NULL,
	AvanceAnterior		float		NULL,
	Prioridad		varchar(10)	NULL,
	PuedeDevolver		bit		NULL	DEFAULT 0,

	Mensaje			int		NULL,
	Gastos			money		NULL,

	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(50)	NULL,

	CONSTRAINT priGestion PRIMARY KEY CLUSTERED (ID)
  )

END
go
EXEC spSincroSemilla 'Gestion'
go
EXEC spSincroNivelRegistro @Tabla = 'Gestion'
go
EXEC spALTER_TABLE 'Gestion' ,'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Gestion' ,'AFSerie', 'varchar(50) NULL'
go

--REQ16092
EXEC spALTER_TABLE 'Gestion' ,'OPORTID', 'int NULL'
go
--REQ PROYECTOS
EXEC spALTER_TABLE 'Gestion' ,'PROYID', 'int NULL'
go
EXEC spALTER_TABLE 'Gestion' ,'Esfuerzo', 'float NULL'
EXEC spALTER_TABLE 'Gestion' ,'EsfuerzoAnterior', 'float NULL'
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gestion.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Gestion.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgGestionA') and sysstat & 0xf = 8) drop trigger dbo.tgGestionA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGestionC') and sysstat & 0xf = 8) drop trigger dbo.tgGestionC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGestionB') and sysstat & 0xf = 8) drop trigger dbo.tgGestionB
GO
EXEC spModificarPK_Mov 'Gestion'
GO
EXEC spSincroNivelRegistroCampos 'Gestion'
GO
-- Aqui va el Matenimiento a la tabla

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Gestion (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Gestion (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Gestion (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Gestion (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Gestion (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Gestion (Usuario)
GO
EXEC spADD_INDEX 'Gestion', 'IDOrigen', 'IDOrigen'
EXEC spADD_INDEX 'Gestion', 'RamaID', 'RamaID'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Gestion (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Gestion (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Gestion' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Gestion (OrigenID,Origen,Empresa)
go

CREATE TRIGGER tgGestionC ON Gestion
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
  
  SELECT @Modulo = 'GES'
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
    UPDATE Gestion SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO
CREATE TRIGGER tgGestionB ON Gestion
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'EMAIL')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'GES', @ID
END
GO

EXEC spDROP_TABLE 'GestionPara', 3175
GO
/****** GestionPara (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'GestionPara')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GestionPara','Movimiento','GES')
if not exists (select * from sysobjects where id = object_id('dbo.GestionPara') and type = 'U') 
  CREATE TABLE dbo.GestionPara (
	ID 			int       	NOT NULL,
	Usuario			varchar(10)	NOT NULL,

	Participacion		varchar(20)	NULL, -- Requerido, Opcional
	RespuestaID		int		NULL,

	CONSTRAINT priGestionPara PRIMARY KEY CLUSTERED (ID, Usuario)
  )
go
EXEC spModificarPK_Sucursal 'GestionPara', '(ID, Usuario)'
GO
EXEC spALTER_TABLE 'GestionPara', 'RespuestaID', 'int NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.cGestionPara') and sysstat & 0xf = 2) drop view dbo.cGestionPara
GO
CREATE VIEW cGestionPara
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Usuario,
  Participacion,

  Sucursal,
  SucursalOrigen

FROM
  GestionPara
GO

EXEC spDROP_TABLE 'GestionRecurso', 3175
GO
/****** GestionRecurso ******/
if not exists(select * from SysTabla where SysTabla = 'GestionRecurso')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GestionRecurso','Movimiento','GES')
if not exists (select * from sysobjects where id = object_id('dbo.GestionRecurso') and type = 'U') 
  CREATE TABLE dbo.GestionRecurso (
	ID 			int       	NOT NULL,
	Recurso			varchar(10)	NOT NULL,

	Referencia		varchar(50)	NULL,
	Fecha			datetime	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	Cantidad		float		NULL,
	Costo			float		NULL,

	CONSTRAINT priGestionRecurso PRIMARY KEY CLUSTERED (ID, Recurso)
  )
go
EXEC spModificarPK_Sucursal 'GestionRecurso', '(ID, Recurso)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cGestionRecurso') and sysstat & 0xf = 2) drop view dbo.cGestionRecurso
GO
CREATE VIEW cGestionRecurso
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Recurso,
  Referencia,
  Fecha,
  HoraD,
  HoraA,
  Cantidad,
  Costo,

  Sucursal,
  SucursalOrigen

FROM
  GestionRecurso
GO



EXEC spDROP_TABLE 'GestionAgenda', 3175
GO
/****** GestionAgenda (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'GestionAgenda')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('GestionAgenda','Movimiento','GES')
if not exists (select * from sysobjects where id = object_id('dbo.GestionAgenda') and type = 'U') 
  CREATE TABLE dbo.GestionAgenda (
	ID 			int       	NOT NULL,
	Modulo			varchar(5)	NOT NULL,
	Mov			varchar(20)	NOT NULL,
	MovID			varchar(20)	NOT NULL,

	Orden			int		NULL,

	CONSTRAINT priGestionAgenda PRIMARY KEY CLUSTERED (ID, Modulo, Mov, MovID)
  )
go
EXEC spModificarPK_Sucursal 'GestionAgenda', '(ID, Modulo, Mov, MovID)'
GO


if exists (select * from sysobjects where id = object_id('dbo.cGestionAgenda') and sysstat & 0xf = 2) drop view dbo.cGestionAgenda
GO
CREATE VIEW cGestionAgenda
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Modulo,
  Mov,
  MovID,
  Orden,

  Sucursal,
  SucursalOrigen

FROM
  GestionAgenda
GO

