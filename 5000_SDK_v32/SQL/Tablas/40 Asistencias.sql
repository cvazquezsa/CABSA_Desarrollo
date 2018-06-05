

/*******************************************************************************************/
/*                                      ASISTENCIAS                                        */
/*******************************************************************************************/

/******************* AsisteEmailEnviado ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'AsisteEmailEnviado')
INSERT INTO SysTabla (SysTabla) VALUES ('AsisteEmailEnviado')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.AsisteEmailEnviado') AND Type = 'U') 
BEGIN
  CREATE TABLE AsisteEmailEnviado (
  	Estacion		int		NOT NULL,
  	Empresa			varchar(5)	NOT NULL,
  	Personal		varchar(20)	NOT NULL,
  	
  	FechaEnvio		DateTime	NULL,
	Email			varchar(100)	NULL,
	Titulo			varchar(100)	NULL,
	Mensaje			varchar(8000)	NULL,
	Estatus			varchar(50)	NULL
	
  
  CONSTRAINT priAsisteEmailEnviado PRIMARY KEY  CLUSTERED (Estacion, Empresa, Personal)
  )
END
GO

/****** Consecutivos (Asiste) ******/
if not exists (select * from SysTabla where SysTabla = 'AsisteC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AsisteC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AsisteC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AsisteC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priAsisteC PRIMARY KEY  CLUSTERED ( ID)
  )
  EXEC spSincroSemilla 'AsisteC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'AsisteC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE AsisteC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE AsisteC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** Asiste ******/
if not exists (select * from SysTabla where SysTabla = 'Asiste') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Asiste','Movimiento','ASIS')
if not exists (select * from sysobjects where id = object_id('dbo.Asiste') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Asiste (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	-- Autorizacion, Entradas, Salidas, Asistencias
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	FechaAplicacion		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		char(10)   	NULL,
	TipoCambio		float		NULL,
	Usuario 		char(10)   	NULL,
	Autorizacion		char(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
	Referencia 		varchar(50) 	NULL,
	Estatus 		char(15)   	NULL,
	Tipo			char(20)	NULL,		--Ausencia/Extras
	Situacion		varchar(50)   	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Localidad		varchar(50)   	NULL,
  	FechaD			datetime	NULL,
  	FechaA			datetime	NULL,

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

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAsiste PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Asiste'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Asiste'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Asiste.Consecutivo
  ALTER TABLE Asiste ALTER COLUMN MovID varchar(20)
  ALTER TABLE Asiste ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Asiste ALTER COLUMN PolizaID varchar(20)
END
GO
EXEC spALTER_TABLE 'Asiste', 'FechaAplicacion', 'datetime NULL'
GO

-- Asiste
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Asiste (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Asiste (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Asiste (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Asiste (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario      ON dbo.Asiste (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	    ON dbo.Asiste (ContID)
go

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Asiste.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Asiste.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Asiste.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Asiste.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Asiste.Abrir
go

--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Asiste (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Asiste (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Asiste' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Asiste (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgAsisteA') and sysstat & 0xf = 8) drop trigger dbo.tgAsisteA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAsisteC') and sysstat & 0xf = 8) drop trigger dbo.tgAsisteC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAsisteB') and sysstat & 0xf = 8) drop trigger dbo.tgAsisteB
GO
EXEC spModificarPK_Mov 'Asiste'
EXEC spSincroNivelRegistroCampos 'Asiste'
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'Asiste', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Asiste', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Asiste', 'SituacionNota', 'varchar(100) NULL'
GO

EXEC spFK 'Asiste','UEN','UEN','UEN'
GO

CREATE TRIGGER tgAsisteC ON Asiste
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
  
  SELECT @Modulo = 'ASIS'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '')  FROM Deleted
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
    UPDATE Asiste SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgAsisteB ON Asiste
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
    EXEC spMovAlEliminar 'ASIS', @ID
END
GO

/****** AsisteD (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'AsisteD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('AsisteD','Movimiento','ASIS')
if not exists (select * from sysobjects where id = object_id('dbo.AsisteD') and type = 'U') 
CREATE TABLE dbo.AsisteD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Recurso			varchar(10)	NULL,
	Personal		varchar(10)	NULL,
	Registro		varchar(10)	NULL,	
	HoraRegistro		varchar(5)	NULL,
	HoraD			varchar(5)	NULL,
	HoraA			varchar(5)	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Concepto		varchar(50)	NULL,
	Cantidad		float		NULL,
	Tipo			varchar(20)	NULL,  -- Dias Extras/Dias Ausencia/Minutos Extras/Minutos Ausencia
	Observaciones		varchar(100)	NULL,  
	Sucursal		int		NOT NULL DEFAULT 0,
	Fecha			datetime	NULL,
	Proyecto		varchar(50)   	NULL,
	Actividad		varchar(100)   	NULL,
	Costo			money		NULL,
	Retardo			int		NULL,
	ActividadEstado		varchar(20)	NULL,
	ActividadAvance		float		NULL,
	MovimientoRef		varchar(50)	NULL,

	Extra			bit		NULL,
	GestionRef		varchar(50)	NULL,
	ActividadABCRef		varchar(50)	NULL,
	MapaLatitud     float		NULL,
	MapaLongitud    float		NULL,
	MapaPrecision	int		NULL,
    MapaUbicacion   varchar(100) NULL,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAsisteD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AsisteD' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.AsisteD (Personal, Fecha)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'AsisteD' AND sysindexes.name = 'Fechas' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fechas   ON dbo.AsisteD (FechaD, FechaA)
go
EXEC spModificarPK_Sucursal 'AsisteD', '(ID, Renglon)'
GO
if exists(select * from systipodatos where tabla = 'AsisteD' and Campo='Observaciones' and tamano=50)
  alter table AsisteD alter column Observaciones varchar(100) NULL
go
EXEC spALTER_TABLE 'AsisteD', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AsisteD', 'Actividad', 'varchar(100) NULL'
EXEC spALTER_TABLE 'AsisteD', 'Costo', 'money NULL'
EXEC spALTER_TABLE 'AsisteD', 'Retardo', 'int NULL'
EXEC spALTER_TABLE 'AsisteD', 'ActividadEstado', ' varchar(20) NULL'
EXEC spALTER_TABLE 'AsisteD', 'ActividadAvance', 'float NULL'
go

if (select version from version)<=2855
  alter table AsisteD alter column cantidad float null
go
EXEC spALTER_TABLE 'AsisteD', 'Recurso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'AsisteD', 'MovimientoRef', 'varchar(50) NULL'
GO

EXEC spALTER_TABLE 'AsisteD', 'Extra', 'bit NULL'
EXEC spALTER_TABLE 'AsisteD', 'GestionRef', 'varchar(50) NULL'
EXEC spALTER_TABLE 'AsisteD', 'ActividadABCRef', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'AsisteD', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'AsisteD', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'AsisteD', 'MapaPrecision', 'int NULL'
EXEC spALTER_TABLE 'AsisteD', 'MapaUbicacion', 'varchar(100) NULL'
GO
EXEC spADD_INDEX 'AsisteD', 'MovimientoRef', 'MovimientoRef'
GO
EXEC spFK 'AsisteD','Personal','Personal','Personal'
EXEC spFK 'AsisteD','Proyecto','Proy','Proyecto'
EXEC spFK 'AsisteD','Recurso','Recurso','Recurso'
GO

if exists (select * from sysobjects where id = object_id('dbo.cAsisteD') and sysstat & 0xf = 2) drop view dbo.cAsisteD
GO
CREATE VIEW cAsisteD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Personal,
  Registro,
  HoraRegistro,
  HoraD,
  HoraA,
  FechaD,
  FechaA,
  Concepto,
  Fecha,
  Cantidad,
  Tipo,
  Observaciones,
  Sucursal,
  SucursalOrigen,
  Proyecto,
  Actividad,
  ActividadEstado,
  ActividadAvance,
  Costo,
  MovimientoRef,

  Logico1,
  Logico2,
  Logico3,
  Logico4,
  Logico5

FROM
  AsisteD
GO

