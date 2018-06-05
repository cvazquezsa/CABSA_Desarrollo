
/*******************************************************************************************/
/*                                         Incidencia                         	           */
/*******************************************************************************************/

/****** Consecutivos Incidencia ******/
if not exists(select * from SysTabla where SysTabla = 'IncidenciaC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IncidenciaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.IncidenciaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IncidenciaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priIncidenciaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'IncidenciaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'IncidenciaC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE IncidenciaC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE IncidenciaC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

-- drop table Incidenciad
if exists (select * from sysobjects where id = object_id('dbo.Incidencia') and type = 'U') 
  and not exists(select * from syscampo where tabla = 'Incidencia' and campo = 'ID')
  drop table incidencia
go
/****** Incidencia (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Incidencia')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Incidencia','Movimiento','INC')
if not exists (select * from sysobjects where id = object_id('dbo.Incidencia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Incidencia (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov  			varchar(20)        NOT NULL,
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

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,  
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,

	FechaAplicacion		datetime	NULL,		-- Default FechaD y se usa para inicio de la aplicacion en incidencias
	Personal		varchar(10)	NULL,
	NominaConcepto		varchar(10)	NULL,		-- Validar Tipo Falta o Incapacidad
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Cantidad		float		NULL,
	Valor			float		NULL,
	Porcentaje		float		NULL	DEFAULT 100.0,
	Acreedor		varchar(10)	NULL,
	Vencimiento		datetime	NULL,

	Repetir			bit		NULL	DEFAULT 0,
	Prorratear		bit		NULL	DEFAULT 0,
	Frecuencia		varchar(20)	NULL,		-- Cada Nomina/Inicio Mes/Fin Mes
	Veces			float		NULL,
	ImporteUnitario		money		NULL,

	PersonalSucursal	int		NULL,

	CONSTRAINT priIncidencia PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Incidencia'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Incidencia'
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Incidencia (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Incidencia (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Incidencia (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Incidencia (Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Incidencia (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Incidencia (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Incidencia (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal      ON dbo.Incidencia (Personal)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'NominaConcepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NominaConcepto ON dbo.Incidencia (NominaConcepto)
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Incidencia.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Incidencia.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgIncidenciaA') and sysstat & 0xf = 8) drop trigger dbo.tgIncidenciaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgIncidenciaC') and sysstat & 0xf = 8) drop trigger dbo.tgIncidenciaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgIncidenciaB') and sysstat & 0xf = 8) drop trigger dbo.tgIncidenciaB
GO
EXEC spModificarPK_Mov 'Incidencia'
GO
EXEC spSincroNivelRegistroCampos 'Incidencia'
GO
EXEC spALTER_TABLE 'Incidencia', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Incidencia', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Incidencia', 'PersonalSucursal', 'int NULL'
EXEC spALTER_TABLE 'Incidencia', 'ImporteUnitario', 'money NULL'
GO

EXEC spFK 'Incidencia','UEN','UEN','UEN'
EXEC spFK 'Incidencia','Proyecto','Proy','Proyecto'
EXEC spFK 'Incidencia','Personal','Personal','Personal'
EXEC spFK 'Incidencia','NominaConcepto','NominaConcepto','NominaConcepto'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Incidencia (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Incidencia (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Incidencia' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Incidencia (OrigenID,Origen,Empresa)
go


-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgIncidenciaC ON Incidencia
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
    @SPID		      int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'INC'
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
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Incidencia SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgIncidenciaB ON Incidencia
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
    EXEC spMovAlEliminar 'INC', @ID
END
GO

/****** IncidenciaD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'IncidenciaD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('IncidenciaD','Movimiento','INC')
if not exists (select * from sysobjects where id = object_id('dbo.IncidenciaD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IncidenciaD (
	RID			int		NOT NULL IDENTITY(1,1),

	ID 			int       	NULL,
	Numero			int		NULL,
	FechaAplicacion		datetime	NULL,
	NominaConcepto		varchar(10)	NULL,	
	Cantidad		float		NULL,
	Importe			money		NULL,

	CantidadPendiente	float		NULL,
	Saldo			money		NULL,

	CONSTRAINT priIncidenciaD PRIMARY KEY CLUSTERED (RID)
  )
  EXEC spSincroSemilla 'IncidenciaD'
END
go
EXEC spModificarPK_Sucursal 'IncidenciaD', '(RID)'
GO
EXEC spALTER_TABLE 'IncidenciaD', 'CantidadPendiente', 'float NULL'
GO

EXEC spFK 'IncidenciaD','ID','Incidencia','ID'
EXEC spFK 'IncidenciaD','NominaConcepto','NominaConcepto','NominaConcepto'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'IncidenciaD' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.IncidenciaD (ID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'IncidenciaD' AND sysindexes.name = 'NominaConcepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NominaConcepto ON dbo.IncidenciaD (NominaConcepto)
GO

/****** Incidencia (en Hoja) ******/
if not exists (select * from SysTabla where SysTabla = 'IncidenciaH') 
INSERT INTO SysTabla (SysTabla) VALUES ('IncidenciaH')
if not exists (select * from sysobjects where id = object_id('dbo.IncidenciaH') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IncidenciaH (
	Usuario			varchar(10)	NOT NULL,
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	NominaConcepto		varchar(10)	NULL,
	Referencia		varchar(50)	NULL,
	FechaEmision		datetime	NULL,
	Personal		varchar(10)	NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Horas			varchar(5)	NULL,

	CONSTRAINT priIncidenciaH PRIMARY KEY  CLUSTERED (Usuario, ID)
  )
  EXEC spSincroSemilla 'IncidenciaH'
END
GO

EXEC spFK 'IncidenciaH','Personal','Personal','Personal'
EXEC spFK 'IncidenciaH','NominaConcepto','NominaConcepto','NominaConcepto'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'IncidenciaH' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.IncidenciaH (Personal, NominaConcepto, FechaEmision, Mov, Empresa)
GO
