-- drop table CapturaCatalogo
/****** CapturaCatalogo ******/
if not exists(select * from SysTabla where SysTabla = 'CapturaCatalogo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CapturaCatalogo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CapturaCatalogo') and type = 'U') 
  CREATE TABLE dbo.CapturaCatalogo (
	Catalogo	        varchar(50) 	NOT NULL,

	Forma			varchar(100)	NULL,
	Modo			varchar(20)	NULL,	-- Automatico/Manual

	CONSTRAINT priCapturaCatalogo PRIMARY KEY  CLUSTERED (Catalogo)
  )
GO

/****** Consecutivos Captura ******/
if not exists(select * from SysTabla where SysTabla = 'CapturaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CapturaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CapturaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CapturaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCapturaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CapturaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CapturaC', '(ID)'
GO
-- drop table Captura
/****** Captura (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Captura')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Captura','Movimiento','CAPT')
if not exists (select * from sysobjects where id = object_id('dbo.Captura') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Captura (
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

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Catalogo		varchar(50)	NULL,
	Clave			varchar(50)	NULL,

	CONSTRAINT priCaptura PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Captura'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Captura'
go

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Captura.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Captura.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCapturaA') and sysstat & 0xf = 8) drop trigger dbo.tgCapturaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCapturaC') and sysstat & 0xf = 8) drop trigger dbo.tgCapturaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCapturaB') and sysstat & 0xf = 8) drop trigger dbo.tgCapturaB
GO
EXEC spModificarPK_Mov 'Captura'
GO
EXEC spSincroNivelRegistroCampos 'Captura'
GO
-- Aqui va el Matenimiento a la tabla
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Captura (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Captura (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Captura (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Captura (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Captura (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Captura (Usuario)
GO
EXEC spADD_INDEX 'Captura', 'Clave', 'Clave, Catalogo'
GO

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Captura (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Captura (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Captura' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Captura (OrigenID,Origen,Empresa)
go

CREATE TRIGGER tgCapturaC ON Captura
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
  
  SELECT @Modulo = 'CAPT'
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
    UPDATE Captura SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO
CREATE TRIGGER tgCapturaB ON Captura
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
    EXEC spMovAlEliminar 'CAPT', @ID
END
GO

EXEC spDROP_TABLE 'CapturaD', 3155
GO
/****** CapturaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CapturaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CapturaD','Movimiento','CAPT')
if not exists (select * from sysobjects where id = object_id('dbo.CapturaD') and type = 'U') 
  CREATE TABLE dbo.CapturaD (
	ID 			int       	NOT NULL,
	Campo			varchar(255)	NOT NULL,

	Valor			varchar(255)	NULL,
	ValorAnterior		varchar(255)	NULL,

	CONSTRAINT priCapturaD PRIMARY KEY CLUSTERED (ID, Campo)
  )
go
EXEC spModificarPK_Sucursal 'CapturaD', '(ID, Campo)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cCapturaD') and sysstat & 0xf = 2) drop view dbo.cCapturaD
GO
CREATE VIEW cCapturaD
--//WITH ENCRYPTION
AS
SELECT
  ID,

  Campo,
  Valor,
  Sucursal,
  SucursalOrigen

FROM
  CapturaD
GO




