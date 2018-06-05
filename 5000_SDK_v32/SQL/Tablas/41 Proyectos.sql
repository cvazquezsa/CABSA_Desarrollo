/*******************************************************************************************/
/*                                            Proyectos                                    */
/*******************************************************************************************/

EXEC spDROP_PROCEDURE 'spActVerificar', 2846
EXEC spDROP_PROCEDURE 'spActAfectar', 2846
EXEC spDROP_PROCEDURE 'spAct', 2846
EXEC spDROP_TABLE 'Act', 2846
EXEC spDROP_TABLE 'ActC', 2846
EXEC spDROP_VIEW  'cActD', 2846
EXEC spDROP_TABLE 'ActD', 2846
EXEC spDROP_TABLE 'ActAnterior', 2846

EXEC spDROP_TABLE 'ProyectoC', 2929
EXEC spDROP_TABLE 'Proyecto', 2933
EXEC spDROP_TABLE 'ProyectoD', 2933
EXEC spDROP_TABLE 'ProyectoRecurso', 2933
EXEC spDROP_TABLE 'ProyectoDRecurso', 2933
EXEC spDROP_TABLE 'ProyectoIntegra', 2806
EXEC spDROP_TABLE 'ProyectoIntegrante', 2806
EXEC spDROP_TABLE 'ProyectoTarea', 2806
EXEC spDROP_TABLE 'ProyectoActividad', 2806
EXEC spDROP_TABLE 'ProyectoAcuerdo', 2806
--EXEC spDROP_TABLE 'Gestion', 2846
--EXEC spDROP_TABLE 'GestionC', 2846
--EXEC spDROP_TABLE 'GestionD', 2846
--EXEC spDROP_TABLE 'GestionAcuerdo', 2846
--EXEC spDROP_TABLE 'GestionFase', 2846
--EXEC spDROP_TABLE 'GestionActividad', 2846
--EXEC spDROP_TABLE 'GestionIntegrante', 2846
--EXEC spDROP_TABLE 'GestionAcuerdo', 2846
--EXEC spDROP_TABLE 'GestionPlan', 2846
--EXEC spDROP_TABLE 'GestionActividadPlantilla', 2846
--EXEC spDROP_TABLE 'GestionActividadPlantillaD', 2846
EXEC spDROP_TABLE 'ProyectoFase', 2853
EXEC spDROP_TABLE 'ProyectoLineaBase', 2856
EXEC spDROP_TABLE 'ActPeriodo', 2857
EXEC spDROP_TABLE 'ProyectoPlantilla', 2933
EXEC spDROP_TABLE 'ProyectoPlantillaFase', 2933
EXEC spDROP_TABLE 'ProyectoPlantillaAct', 2933
EXEC spDROP_TABLE 'ProyectoFaseLineaBase', 2857
EXEC spDROP_TABLE 'ProyectoRecursoGasto', 2858
EXEC spDROP_TABLE 'ProyectoRecursoAF', 2858
EXEC spDROP_TABLE 'ActRecurso', 2858
EXEC spDROP_TABLE 'ActMaterial', 2858
EXEC spDROP_TABLE 'ActGasto', 2858
EXEC spDROP_TABLE 'ProyectoInhabil', 2924

EXEC spDROP_TABLE 'ProyectoRecursoGasto', 2928
EXEC spDROP_TABLE 'ProyectoRecursoAF', 2928
EXEC spDROP_TABLE 'ActMaterial', 2928
EXEC spDROP_TABLE 'ActGasto', 2928

EXEC spDROP_TABLE 'ProyectoTrabajo', 2929
EXEC spDROP_TABLE 'ProyectoTrabajoAct', 2929

EXEC spDROP_TABLE 'Act', 2933
EXEC spDROP_TABLE 'ActRecurso', 2933
EXEC spDROP_TABLE 'ActLineaBase', 2933
EXEC spDROP_TABLE 'FaseCat', 2929
EXEC spDROP_TABLE 'FaseGrupo', 2929
EXEC spDROP_TABLE 'FaseFam', 2929
EXEC spDROP_TABLE 'Fase ', 2929
EXEC spDROP_TABLE 'FaseLineaBase', 2929
EXEC spDROP_TABLE 'PlantillaProyecto', 2939
EXEC spDROP_TABLE 'PlantillaProyectoD', 2939

EXEC spDROP_TABLE 'PlantillaProyecto', 2946
EXEC spDROP_TABLE 'PlantillaProyectoD', 2946
EXEC spDROP_TABLE 'ProyectoRecurso', 2946
EXEC spDROP_TABLE 'ProyectoLineaBase', 2946

EXEC spDROP_TABLE 'ProyectoDesarrollo', 2947
EXEC spDROP_TABLE 'ActividadPorOmision', 2965
GO

DECLARE
  @SQL varchar(255)
SELECT @SQL = 'alter database '+RTRIM(DB_NAME())+' set recursive_triggers off'
IF (select version from version)<=2960
  EXEC(@SQL)
GO

/** CAMPOS CALCULADOS **/
EXEC spDROP_COLUMN 'Proyecto', 'ActividadActual'
EXEC spDROP_COLUMN 'Proyecto', 'Indicador0'
EXEC spDROP_COLUMN 'Proyecto', 'Indicador1'
EXEC spDROP_COLUMN 'Proyecto', 'Indicador2'
EXEC spDROP_COLUMN 'Proyecto', 'Indicador3'
EXEC spDROP_COLUMN 'ProyectoD', 'RecursosAsignados'
EXEC spDROP_COLUMN 'ProyectoD', 'Indicador'
GO


/*** ProyectoRol ***/
if not exists(select * from SysTabla where SysTabla = 'ProyectoRol')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoRol','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoRol') and type = 'U') 
CREATE TABLE dbo.ProyectoRol (
	Rol			varchar(50)		NOT NULL,
	Icono		int				NULL,
	PrecioHora	money			NULL,

	CONSTRAINT priProyectoRol PRIMARY KEY  CLUSTERED (Rol)
)
GO

EXEC spALTER_TABLE 'ProyectoRol', 'PrecioHora', 'money NULL'
GO

/*** RecursoGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'RecursoGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RecursoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RecursoGrupo') and type = 'U') 
CREATE TABLE dbo.RecursoGrupo (
	Grupo		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priRecursoGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO
EXEC spALTER_TABLE 'RecursoGrupo', 'Icono', 'int NULL'
GO

/****** Recurso ******/
if not exists(select * from SysTabla where SysTabla = 'Recurso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Recurso','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Recurso') and type = 'U') 
CREATE TABLE dbo.Recurso (
	Recurso			varchar(10)  	NOT NULL,

	Nombre			varchar(100)	NULL,
	eMail			varchar(100)	NULL,
	NombreExchange		varchar(100)	NULL,
	Prospecto		varchar(10)	NULL,
	Cliente			varchar(10)	NULL,
	Proveedor		varchar(10)	NULL,
	Personal		varchar(10)	NULL,
	Agente			varchar(10)	NULL,
	Usuario			varchar(10)	NULL,
	AFArticulo		varchar(20)	NULL,
	AFSerie			varchar(50)	NULL,

	Estatus			varchar(15)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	Grupo			varchar(50)	NULL,

	Rol			varchar(50)	NULL,
	HorasDia		float		NULL,
	PrecioHora		money		NULL,
	CostoHora		money		NULL,

	CONSTRAINT priRecurso PRIMARY KEY  CLUSTERED (Recurso)
)
go
EXEC spRENAME_COLUMN 'Recurso', 'OutlookNombre', 'NombreExchange'
EXEC spRENAME_COLUMN 'Recurso', 'Contacto', 'Prospecto'
GO
EXEC spALTER_TABLE 'Recurso', 'NombreExchange', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Recurso', 'Prospecto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Recurso', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Recurso', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Recurso', 'AFArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Recurso', 'AFSerie', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Recurso', 'Rol', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Recurso', 'HorasDia', 'float NULL'
EXEC spALTER_TABLE 'Recurso', 'PrecioHora', 'money NULL'
EXEC spALTER_TABLE 'Recurso', 'CostoHora', 'money NULL'
GO
EXEC spADD_INDEX 'Recurso', 'Nombre', 'Nombre'
EXEC spADD_INDEX 'Recurso', 'Grupo', 'Grupo'
GO

EXEC spFK 'Recurso','Personal','Personal','Personal'
EXEC spFK 'Recurso','Agente','Agente','Agente'
EXEC spFK 'Recurso','Prospecto','Prospecto','Prospecto'
EXEC spFK 'Recurso','Cliente','Cte','Cliente'
EXEC spFK 'Recurso','Proveedor','Prov','Proveedor'
EXEC spFK 'Recurso','AFArticulo','Art','Articulo'
GO

/******************* ProyClavePresupuestalRegla ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ProyClavePresupuestalRegla') --MEJORA4722
INSERT INTO SysTabla (SysTabla) VALUES ('ProyClavePresupuestalRegla')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.ProyClavePresupuestalRegla') AND Type = 'U') 
BEGIN
  CREATE TABLE ProyClavePresupuestalRegla (
  	RID		int IDENTITY	NOT NULL,
	
	Orden		int		NULL,
	Proyecto	varchar(50)	NULL,
	Descripcion	varchar(50) NULL,
	Mascara		varchar(50)	NULL,
	Tipo		varchar(20)	NULL,
	Estatus		varchar(15)	NULL,
	
  CONSTRAINT priProyClavePresupuestalRegla PRIMARY KEY CLUSTERED (RID)
  )
END
GO  

EXEC spAlter_Table 'ProyClavePresupuestalRegla', 'Descripcion', 'varchar(50) NULL'
GO


/******************* ProyClavePresupuestalReglaVig ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ProyClavePresupuestalReglaVig') --MEJORA4722
INSERT INTO SysTabla (SysTabla) VALUES ('ProyClavePresupuestalReglaVig')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.ProyClavePresupuestalReglaVig') AND Type = 'U') 
BEGIN
  CREATE TABLE ProyClavePresupuestalReglaVig (
  	ID				int		NOT NULL,
  	RID				int identity(1,1) NOT NULL,
	
	FechaD			DateTime	NULL,
	FechaA			DateTime	NULL,
	MascaraFecha	varchar(10)	NULL
	
  CONSTRAINT priProyClavePresupuestalReglaVig PRIMARY KEY CLUSTERED (ID, RID)
  )
END
GO  

/****** Consecutivos (Proyecto) ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProyectoC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProyectoC (
        ID		int		NOT NULL IDENTITY (1,1),

	Empresa		char(5)         NULL,
	Mov 		char(20) 	NULL,
	Serie		varchar(20)	NULL,
	Periodo		int		NULL,
	Ejercicio	int		NULL,

	Consecutivo 	int		NOT NULL DEFAULT 0,
	Sucursal	int		NOT NULL DEFAULT 0,

	CONSTRAINT priProyectoC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ProyectoC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ProyectoC', '(ID)'
GO

-- drop table proyecto delete SysTabla where SysTabla = 'Proyecto'
/****** Proyecto ******/
if not exists(select * from SysTabla where SysTabla = 'Proyecto')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Proyecto','Movimiento','PROY')
GO
if not exists (select * from sysobjects where id = object_id('dbo.Proyecto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Proyecto (
	ID			int 	    	NOT NULL        IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,

	Proyecto		varchar(50)	NULL,
        ProyectoReestructurar   varchar(50)     NULL,
        Reestructurar           bit             NULL            DEFAULT 0,
	FechaRevision		datetime	NULL,

	ContactoTipo		varchar(20)	NULL,	-- Prospecto, Cliente, Proveedor, Personal, Agente
	Prospecto		varchar(10)   	NULL,
	Cliente			varchar(10)   	NULL,
	Proveedor		varchar(10)   	NULL,
	Personal		varchar(10)   	NULL,
	Agente			varchar(10)   	NULL,
        Riesgo                  varchar(10)     NULL,
        ProyectoRama            varchar(50)     NULL,
	UEN			int		NULL,
	Concepto		varchar(50)	NULL,
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
	Moneda			varchar(10)	NULL,
	TipoCambio		Float		NULL,

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL, 
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,

	Comienzo		datetime	NULL,	
	Fin			datetime	NULL,
        ConsiderarAvanceActual  bit             NULL            DEFAULT 0,
	CalculoInverso		bit		NULL		DEFAULT 0,

	Sucursal		int		NOT NULL        DEFAULT 0,
	Prioridad		varchar(10)	NULL,
	Supervisor		varchar(10)	NULL,
	DiasHabiles		varchar(20)	NULL,	
	HorasDia		float		NULL,

	MontoEstimado		money		NULL,
	FechaEstimada		datetime	NULL,
	Probabilidad		float		NULL,
	Avance			float		NULL,

	Comentarios		text		NULL,
	FechaRequerida		datetime	NULL,
	Descripcion		varchar(100)	NULL,

	CONSTRAINT priProyecto PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Proyecto'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Proyecto'
EXEC spModificarPK_Mov 'Proyecto'
go
EXEC spALTER_TABLE 'Proyecto', 'Avance', 'float NULL'
EXEC spALTER_TABLE 'Proyecto', 'ProyectoReestructurar', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Proyecto', 'ConsiderarAvanceActual', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Proyecto', 'CalculoInverso', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'Proyecto', 'Reestructurar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Proyecto', 'Riesgo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'ProyectoRama', 'varchar(50) NULL'
GO
EXEC spDROP_COLUMN 'Proyecto', 'CteContacto' 
EXEC spDROP_COLUMN 'Proyecto', 'CteContactoEMail'
EXEC spDROP_COLUMN 'Proyecto', 'CteContactoTelefonos'
GO
EXEC spALTER_COLUMN 'Proyecto', 'Riesgo', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'Proyecto', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Proyecto', 'FechaRequerida', 'datetime NULL'
EXEC spALTER_TABLE 'Proyecto', 'FechaRevision', 'datetime NULL'
EXEC spALTER_TABLE 'Proyecto', 'Descripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Moneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'TipoCambio', 'Float NULL'
EXEC spALTER_TABLE 'Proyecto', 'ContactoTipo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Proyecto', 'Prospecto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Personal', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Agente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proyecto', 'Propuesta', 'varchar(50) NULL'
GO

EXEC spFK 'Proyecto','UEN','UEN','UEN'
EXEC spFK 'Proyecto','Cliente','Cte','Cliente'
EXEC spFK 'Proyecto','Proveedor','Prov','Proveedor'
EXEC spFK 'Proyecto','Personal','Personal','Personal'
EXEC spFK 'Proyecto','Agente','Agente','Agente'
EXEC spFK 'Proyecto','Prospecto','Prospecto','Prospecto'
EXEC spFK 'Proyecto','Supervisor','Recurso','Recurso'
EXEC spFK 'Proyecto','Proyecto','Proy','Proyecto'
EXEC spFK 'Proyecto','Riesgo','aroRiesgo','Riesgo'
GO

-- Proyecto
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Proyecto (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Proyecto (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Proyecto (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Proyecto (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Proyecto (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion   ON dbo.Proyecto (Descripcion)
GO
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Proyecto.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Proyecto.Situacion2
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Proyecto (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Proyecto (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Proyecto' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Proyecto (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgProyectoA') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoC') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoB') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoB
GO
EXEC spSincroNivelRegistroCampos 'Proyecto'
GO
EXEC spModificarPK_Mov 'Proyecto'
GO
-- Aqui va el Matenimiento a la tabla
GO

CREATE TRIGGER tgProyectoC ON Proyecto
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 			char(5),
    @Mov			char(20),
    @Sucursal			int,
    @ID				int,
    @FechaInicio		datetime,
    @Ahora 			datetime,
    @FechaAnterior		datetime,
    @EstatusNuevo 		char(15),
    @EstatusAnterior 		char(15),
    @SituacionNueva 		varchar(50),
    @SituacionAnterior 		varchar(50),
    @Usuario			char(10),
    @Mensaje			char(255),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'PROY'
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
  /*IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Proyecto SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
*/
END
GO

CREATE TRIGGER tgProyectoB ON Proyecto
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
    EXEC spMovAlEliminar 'PROY', @ID
END
GO

/****** ProyectoRecurso ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoRecurso')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyectoRecurso','Movimiento','PROY')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoRecurso') and type = 'U') 
CREATE TABLE dbo.ProyectoRecurso (
	ID			int		NOT NULL,
	Recurso			varchar(10)	NOT NULL,

        Estatus                 varchar(15)     NOT NULL,
        TieneMovimientos        bit             NULL            DEFAULT 0,

	Comienzo		datetime	NULL,
	Fin			datetime	NULL,

	Rol			varchar(50)	NULL,
	HorasDia		float		NULL,
	PrecioHora		money		NULL,
	CostoHora		money		NULL,
	ComienzoProgramado	datetime	NULL,
	FinProgramado		datetime	NULL,

	CONSTRAINT priProyectoRecurso PRIMARY KEY CLUSTERED (ID, Recurso)
)
go
EXEC spModificarPK_Mov 'ProyectoRecurso'
GO
EXEC spALTER_TABLE 'ProyectoRecurso', 'ComienzoProgramado', 'datetime NULL'
EXEC spALTER_TABLE 'ProyectoRecurso', 'FinProgramado', 'datetime NULL'
GO
-- drop table ProyResultado
/****** ProyResultado ******/
if not exists(select * from SysTabla where SysTabla = 'ProyResultado')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyResultado','Movimiento','PROY')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyResultado','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProyResultado') and type = 'U') 
CREATE TABLE dbo.ProyResultado (
	Proyecto		varchar(50)	NOT NULL,
	ID			int 	    	NOT NULL        IDENTITY(1,1),

	Empresa			varchar(5)	NULL,
	Modulo			varchar(5)	NULL,
	ModuloID		int		NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
	FechaEmision		datetime	NULL,
	Actividad		varchar(50)	NULL,
	Tipo			varchar(20)	NULL,

	Costo			money		NULL,
	Gasto			money		NULL,
	Venta			money		NULL,
	Ingresos		money		NULL,
	Egresos			money		NULL,
	
	CONSTRAINT priProyResultado PRIMARY KEY CLUSTERED (Proyecto, ID)
)
go
EXEC spALTER_COLUMN 'ProyResultado', 'Actividad', 'varchar(50) NULL'
GO

/***************** tgProyectoRecursoA *************/
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoRecursoA') and type = 'tr') drop trigger tgProyectoRecursoA
GO
CREATE TRIGGER tgProyectoRecursoA ON ProyectoRecurso
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE 
    @Estatus            varchar(15),
    @ID                 int,
    @Recurso            varchar(10),
    @Mensaje            varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Mensaje = NULL

  SELECT @ID = ID, @Estatus = Estatus, @Recurso = Recurso FROM Inserted

  IF @Estatus = 'BAJA' AND @ID IS NOT NULL
    IF EXISTS (SELECT * FROM ProyectoD d JOIN ProyectoDRecurso r ON d.ID = r.ID AND d.Actividad = r.Actividad WHERE d.ID = @ID AND r.Recurso = @Recurso AND UPPER(d.Estado) NOT IN ('ELIMINADA', 'COMPLETADA', 'CANCELADA'))
      SELECT @Mensaje = 'El Recurso ' + RTRIM(@Recurso) + ' Tiene Actividades Pendientes Asignadas'

  IF @Mensaje IS NOT NULL
    RAISERROR(@Mensaje, 16, 1)

  RETURN
END
GO

/******************* ProyPuntoCritico ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ProyPuntoCritico')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProyPuntoCritico', 'Cuenta')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.ProyPuntoCritico') AND Type = 'U') 
BEGIN
  CREATE TABLE ProyPuntoCritico (
  	Proyecto		varchar(50)	NOT NULL,
  	PuntoCritico		varchar(50)	NOT NULL,
  	
  	Descripcion		varchar(100)	NULL,
  	Estado			varchar(50)	NULL,
  	Avance			float		NULL,
	Vencimiento		datetime	NULL,
	
  
  CONSTRAINT priProyPuntoCritico PRIMARY KEY  CLUSTERED (Proyecto, PuntoCritico)
  )
END
GO

EXEC spALTER_TABLE 'ProyPuntoCritico', 'Vencimiento', 'datetime NULL'
GO

EXEC spFK 'ProyPuntoCritico', 'Proyecto', 'Proy', 'Proyecto'
GO

-- drop table ProyectoDia
/****** ProyectoDia ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDia')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyectoDia','Movimiento','PROY')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDia') and type = 'U') 
CREATE TABLE dbo.ProyectoDia (
	ID			int		NOT NULL,
	Fecha			datetime	NOT NULL,

	HorasDia		float		NULL,
	Concepto		varchar(50)	NULL,

	CONSTRAINT priProyectoDia PRIMARY KEY CLUSTERED (ID, Fecha)
)
go
EXEC spModificarPK_Mov 'ProyectoDia'
GO

/*** ActClave ***/
if not exists(select * from SysTabla where SysTabla = 'ActClave')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActClave','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActClave') and type = 'U') 
CREATE TABLE dbo.ActClave (
	Clave		varchar(20)	NOT NULL,

	Asunto		varchar(100)	NULL,

	CONSTRAINT priActClave PRIMARY KEY  CLUSTERED (Clave)
)
GO

/*** ActCat ***/
if not exists(select * from SysTabla where SysTabla = 'ActCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActCat') and type = 'U') 
CREATE TABLE dbo.ActCat (
	Categoria	varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priActCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/*** ActGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'ActGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActGrupo') and type = 'U') 
CREATE TABLE dbo.ActGrupo (
	Grupo		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priActGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/*** ActFam ***/
if not exists(select * from SysTabla where SysTabla = 'ActFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActFam') and type = 'U') 
CREATE TABLE dbo.ActFam (
	Familia		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priActFam PRIMARY KEY  CLUSTERED (Familia)
)
GO

-- drop table ActividadPorOmision
/********************** ActividadPorOmision *******************/
/*if not exists(select * from SysTabla where SysTabla = 'ActividadPorOmision')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActividadPorOmision','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActividadPorOmision') and type = 'U') 
  CREATE TABLE dbo.ActividadPorOmision (
	Asunto			varchar(100)	NOT NULL,

	CONSTRAINT priActividadPorOmision PRIMARY KEY CLUSTERED (Asunto)
  )*/
go

/************** ProyectoDRecurso **********/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDRecurso')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyectoDRecurso','Movimiento','PROY')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDRecurso') and type = 'U') 
  CREATE TABLE dbo.ProyectoDRecurso (
	ID			int		NOT NULL,
	Actividad		varchar(50)	NOT NULL,
	Recurso			varchar(10)	NOT NULL,

	Comienzo		datetime	NULL,
	Fin			datetime	NULL,

	CONSTRAINT priProyectoDRecurso PRIMARY KEY CLUSTERED (ID, Actividad, Recurso)
  )
go
EXEC spModificarPK_Mov 'ProyectoDRecurso'
GO

EXEC spFK 'ProyectoDRecurso','Recurso','Recurso','Recurso'
GO

if exists(select * from syscampoext where Tabla = 'ProyectoDRecurso' and campo='Actividad' and ancho=20)
BEGIN
  EXEC ("spDROP_PK 'ProyectoDRecurso'")
  EXEC ("spALTER_COLUMN 'ProyectoDRecurso', 'Actividad', 'varchar(50) NOT NULL'")
  EXEC ("spADD_PK 'ProyectoDRecurso', 'ID, Actividad, Recurso'")
END
GO

/****** ProyectoDArtMaterial ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDArtMaterial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDArtMaterial','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDArtMaterial') and type = 'U') 
CREATE TABLE dbo.ProyectoDArtMaterial (
	ID			int		NOT NULL,
	Actividad		varchar(50)	NOT NULL,
	RID			int		identity(1,1),
	Material		varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	Cantidad		float		NULL,
	Unidad			varchar(50)	NULL,
	Almacen			varchar(10)	NULL,

	CONSTRAINT priProyectoDArtMaterial PRIMARY KEY CLUSTERED (ID, Actividad, RID)
)
GO

-- select * from ProyectoD
/********************** ProyectoD *******************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyectoD','Movimiento','PROY')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProyectoD (
	ID			int		NOT NULL,
	Actividad		varchar(50)	NOT NULL,

	Predecesora		varchar(50)	NULL,
	Orden			varchar(255)	NULL,
	EsFase			bit		NULL	DEFAULT 0,
	Clave			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	Tipo			varchar(20)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Duracion		float		NULL,
	DuracionUnidad		varchar(10)	NULL,
	DuracionDias		float		NULL,
	Comentarios		text		NULL,
	Usuario			varchar(10)	NULL,
	UltimoCambio		datetime	NULL,

	Comienzo		datetime	NULL,
	Fin			datetime	NULL,
	Estado			varchar(30)	NULL,
	Avance			float		NULL,
	Prioridad		varchar(10)	NULL,

	ComienzoEsp		datetime	NULL,

	Sincronizando		bit		NULL	DEFAULT 0,
	Proyecto		varchar(50)	NULL,
	EstaLiberado		bit		NULL	DEFAULT 0,
	FechaLiberacion		datetime	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
        EsNuevo                 bit             NULL    DEFAULT 1,
	FechaInicio		datetime	NULL,
	FechaConclusion		datetime	NULL,

	CONSTRAINT priProyectoD PRIMARY KEY CLUSTERED (ID, Actividad)
  )
  EXEC spSincroSemilla 'ProyectoD'
END
go
EXEC spModificarPK_Mov 'ProyectoD'
GO
EXEC spALTER_TABLE 'ProyectoD', 'TieneMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ProyectoD', 'EsNuevo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'ProyectoD', 'Clave', 'varchar(20) NULL'
GO
EXEC spADD_INDEX 'ProyectoD', 'Orden', 'ID, Orden'
EXEC spADD_INDEX 'ProyectoD', 'Predecesora', 'ID, Predecesora'
EXEC spADD_INDEX 'ProyectoD', 'Proyecto', 'Proyecto, Actividad'
EXEC spADD_INDEX 'ProyectoD', 'Asunto', 'Asunto'
GO
EXEC spALTER_COLUMN 'ProyectoD', 'Estado', 'varchar(30) NULL'
GO
EXEC spALTER_TABLE 'ProyectoD', 'ComienzoEsp', 'datetime NULL'
EXEC spALTER_TABLE 'ProyectoD', 'FechaInicio', 'datetime NULL'
EXEC spALTER_TABLE 'ProyectoD', 'FechaConclusion', 'datetime NULL'
GO
EXEC spALTER_TABLE 'ProyectoD', 'Esfuerzo', 'float NULL'
GO
if exists(select * from syscampoext where Tabla = 'ProyectoD' and campo='Actividad' and ancho=20)
BEGIN
  EXEC ("spDROP_PK 'ProyectoD'")
  EXEC ("spALTER_COLUMN 'ProyectoD', 'Actividad', 'varchar(50) NOT NULL'")
  EXEC ("spADD_PK 'ProyectoD', 'ID, Actividad'")
END
GO
EXEC spALTER_COLUMN 'ProyectoD', 'Predecesora', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProyectoD', 'Orden', 'varchar(255) NULL'
GO

EXEC spFK 'ProyectoD','Clave','ActClave','Clave'
EXEC spFK 'ProyectoD','ID','Proyecto','ID'
GO

-- tarea
-- select * from cproyectod
if exists (select * from sysobjects where id = object_id('dbo.cProyectoD') and type = 'v') drop view cProyectoD
GO
CREATE VIEW cProyectoD
--//WITH ENCRYPTION
AS
  SELECT
    ID, 
    Actividad, 
    Predecesora, 
    Orden, 
    EsFase, 
    Clave,
    Asunto, 
    Tipo, 
    Categoria, 
    Grupo, 
    Familia, 
    Duracion, 
    DuracionUnidad, 
    DuracionDias, 
    Comentarios, 
    Usuario, 
    UltimoCambio, 
    Comienzo, 
    Fin, 
    Estado, 
    Avance, 
    Prioridad, 
    ComienzoEsp,
    Proyecto, 
    EstaLiberado, 
    FechaLiberacion, 
    TieneMovimientos,
    Sucursal,
    SucursalOrigen,
    FechaInicio,
    FechaConclusion 
  FROM
    ProyectoD
GO


/**************** spProyectoDLiberar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spProyectoDLiberar') and type = 'P') drop procedure dbo.spProyectoDLiberar
GO
CREATE PROCEDURE spProyectoDLiberar
			@ID		int,
			@Predecesora	varchar(50)     = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
     @Actividad         varchar(50),
     @Rama              varchar(50),
     @EstaLiberadoN     bit,
     @EstaLiberadoA     bit

  SELECT @Predecesora = NULLIF(RTRIM(@Predecesora), '')

  DECLARE crPredecesora CURSOR LOCAL FOR
    SELECT Actividad, dbo.fnActRama(Actividad), EstaLiberado
      FROM ProyectoD
     WHERE ID = @ID
       AND NULLIF(RTRIM(Predecesora), '') = @Predecesora

  OPEN crPredecesora 
  FETCH NEXT FROM crPredecesora INTO @Actividad, @Rama, @EstaLiberadoA
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN

      SELECT @EstaLiberadoN = 0

      IF @Rama IS NULL AND @Predecesora IS NULL
        SELECT @EstaLiberadoN = 1
      
      IF @Rama IS NULL AND @Predecesora IS NOT NULL
        IF (SELECT Estado FROM ProyectoD WHERE ID = @ID AND Actividad = @Predecesora) IN ('COMPLETADA', 'CANCELADA', 'ELIMINADA')
          SELECT @EstaLiberadoN = 1

      IF @Rama IS NOT NULL AND @Predecesora IS NULL
        IF (SELECT EstaLiberado FROM ProyectoD WHERE ID = @ID AND Actividad = @Rama) = 1
          SELECT @EstaLiberadoN = 1

      IF @Rama IS NOT NULL AND @Predecesora IS NOT NULL
        IF (SELECT EstaLiberado FROM ProyectoD WHERE ID = @ID AND Actividad = @Rama) = 1
          IF (SELECT Estado FROM ProyectoD WHERE ID = @ID AND Actividad = @Predecesora) IN ('COMPLETADA', 'CANCELADA', 'ELIMINADA')
            SELECT @EstaLiberadoN = 1

      IF @EstaLiberadoN <> @EstaLiberadoA
        UPDATE ProyectoD 
           SET EstaLiberado = @EstaLiberadoN, FechaLiberacion = GETDATE()
         WHERE ID = @ID AND Actividad = @Actividad
    END
    FETCH NEXT FROM crPredecesora INTO @Actividad, @Rama, @EstaLiberadoA
  END
  CLOSE crPredecesora
  DEALLOCATE crPredecesora

  RETURN
END
GO

-- update proyectod set avance = 60 where id = 87 and actividad = '1.1.1'

/************************* tgProyectoDC **********************/
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDC') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoDC
GO
CREATE TRIGGER tgProyectoDC ON ProyectoD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @OutlookID			int,
    @SincroOutlook		bit,
    @IDN			int,
    @IDA			int,
    @EstaLiberadoN		bit,
    @EstaLiberadoA		bit,
    @DeN			varchar(100),
    @DeA			varchar(100),
    @ParaN			varchar(100),
    @ParaA			varchar(100),
    @ComienzoN			datetime, 
    @ComienzoA			datetime, 
    @FinN			datetime,    
    @FinA			datetime,    
    @AsuntoN			varchar(100), 
    @AsuntoA			varchar(100), 
    @EstadoN			varchar(30), 
    @EstadoA			varchar(30), 
    @AvanceN			float,     
    @AvanceA			float,     
    @PrioridadN			varchar(10),
    @PrioridadA			varchar(10),
    @ActividadN			varchar(50),
    @ActividadA			varchar(50),
    @EsFaseN                    bit,
    @EsFaseA                    bit

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Sincronizando) RETURN

  SELECT @SincroOutlook = ISNULL(OutlookActividadesSincronizar, 0) FROM Version

  SELECT @IDN = ID, @ActividadN = Actividad, @ComienzoN = Comienzo, @FinN = Fin, @AsuntoN = Asunto, @EstadoN = Estado, @AvanceN = Avance, @PrioridadN = Prioridad, @EstaLiberadoN = EstaLiberado, @EsFaseN = EsFase FROM Inserted  
  SELECT @IDA = ID, @ActividadA = Actividad, @ComienzoA = Comienzo, @FinA = Fin, @AsuntoA = Asunto, @EstadoA = Estado, @AvanceA = Avance, @PrioridadA = Prioridad, @EstaLiberadoA = EstaLiberado, @EsFaseA = EsFase FROM Deleted

  IF @ActividadN <> @ActividadA 
    UPDATE ProyectoDRecurso SET Actividad = @ActividadN WHERE ID = @IDA AND Actividad = @ActividadA

  IF @SincroOutlook = 1 
  BEGIN
    IF @IDN IS NOT NULL SELECT @DeN = r.NombreExchange /*r.Nombre+' ['+r.eMail+']'*/ FROM Recurso r JOIN Proyecto p ON p.Supervisor = r.Recurso WHERE p.ID = @IDN
    IF @IDA IS NOT NULL SELECT @DeA = r.NombreExchange /*r.Nombre+' ['+r.eMail+']'*/ FROM Recurso r JOIN Proyecto p ON p.Supervisor = r.Recurso WHERE p.ID = @IDA
  END

  -- Sincronizar con Outlook
  IF @SincroOutlook = 1 AND @EstaLiberadoN = 1 
  BEGIN
    -- Agregar Outlook
    IF @EstaLiberadoA = 0 AND @EstaLiberadoN = 1 
    BEGIN
      INSERT OutlookProcesar (
             Tipo,        De,   Fecha,           Asunto,                             Mensaje,     FechaD,   FechaA, Estado, Completado, Prioridad, Accion,    Modulo,  ModuloID)
      SELECT 'Actividad', @DeN, FechaLiberacion, Actividad+' - '+ISNULL(Asunto, ''), Comentarios, Comienzo, Fin,    Estado, Avance,     Prioridad, 'Agregar', 'ACT',   ID
        FROM ProyectoD
       WHERE ID = @IDN AND Actividad = @ActividadN
      SELECT @OutlookID = SCOPE_IDENTITY()

      INSERT OutlookProcesarPara (ID, Para) 
      SELECT @OutlookID, r.NombreExchange 
        FROM ProyectoDRecurso dr 
        JOIN Recurso r ON r.Recurso = dr.Recurso 
       WHERE dr.ID = @IDN AND dr.Actividad = @ActividadN
    END 
 
    -- Modificar
    IF @EstaLiberadoA = 1 AND @EstaLiberadoN = 1 
    BEGIN
      IF UPDATE(Comentarios) OR @ParaN <> @ParaA OR @ComienzoN <> @ComienzoA OR @FinN <> @FinA OR @AsuntoN <> @AsuntoA OR @EstadoN <> @EstadoA OR @AvanceN <> @AvanceA OR @PrioridadN <> @PrioridadA
      BEGIN
        INSERT OutlookProcesar (
               Tipo,        De,   Fecha,           Asunto,                             Mensaje,     FechaD,   FechaA, Estado, Completado, Prioridad, Accion,       Modulo, ModuloID)
        SELECT 'Actividad', @DeN, FechaLiberacion, Actividad+' - '+ISNULL(Asunto, ''), Comentarios, Comienzo, Fin,    Estado, Avance,     Prioridad, 'Modificar', 'ACT',   ID
        FROM ProyectoD
       WHERE ID = @IDN AND Actividad = @ActividadN
        SELECT @OutlookID = SCOPE_IDENTITY()

        INSERT OutlookProcesarPara (ID, Para) 
        SELECT @OutlookID, r.NombreExchange 
          FROM ProyectoDRecurso dr 
          JOIN Recurso r ON r.Recurso = dr.Recurso 
         WHERE dr.ID = @IDN AND dr.Actividad = @ActividadN
      END
    END
  END

  EXEC spProyectoDLiberar @IDN, @ActividadN
--  EXEC spProyectoRecalcularAvance @IDN, @ActividadN
END
GO

/************************* tgProyectoDB **********************/
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDB') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoDB
GO
CREATE TRIGGER tgProyectoDB ON ProyectoD
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
DECLARE
    @ID		int,
    @Actividad	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Actividad = Actividad FROM Deleted
  DELETE ProyectoDRecurso
   WHERE ID = @ID AND Actividad = @Actividad
END
GO

/****** PlantillaProyecto ******/
if not exists(select * from SysTabla where SysTabla = 'PlantillaProyecto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantillaProyecto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantillaProyecto') and type = 'U') 
CREATE TABLE dbo.PlantillaProyecto (
	Plantilla		varchar(50)  	NOT NULL,

	Descripcion		varchar(255)	NULL,
	Estatus			varchar(15)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
        Riesgo                  varchar(20)     NULL,
        Version                 float           NULL,

	CONSTRAINT priPlantillaProyecto PRIMARY KEY  CLUSTERED (Plantilla)
)
go

-- Campos Nuevos
EXEC spALTER_TABLE 'PlantillaProyecto', 'Riesgo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'PlantillaProyecto', 'Version', 'float NULL'
GO

/****** PlantillaProyectoD ******/
if not exists(select * from SysTabla where SysTabla = 'PlantillaProyectoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantillaProyectoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantillaProyectoD') and type = 'U') 
  CREATE TABLE dbo.PlantillaProyectoD (
	Plantilla		varchar(50)  	NOT NULL,
	Actividad		varchar(50)	NOT NULL,

	Predecesora		varchar(50)	NULL,
	Orden			varchar(255)	NULL,
	EsFase			bit		NULL	DEFAULT 0,
	Clave			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	Tipo			varchar(20)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Duracion		float		NULL,
	DuracionUnidad		varchar(10)	NULL,
	SubPlantilla		varchar(50)	NULL,
	Comentarios		text		NULL,
	RecursoOmision		varchar(10)	NULL,

	CONSTRAINT priPlantillaProyectoD PRIMARY KEY  CLUSTERED (Plantilla, Actividad)
  )
go
EXEC spALTER_TABLE 'PlantillaProyectoD', 'Clave', 'varchar(20) NULL'
EXEC spALTER_TABLE 'PlantillaProyectoD', 'RecursoOmision', 'varchar(10)	NULL'
go
if exists(select * from syscampoext where Tabla = 'PlantillaProyectoD' and campo='Actividad' and ancho=20)
BEGIN
  EXEC ("spDROP_PK 'PlantillaProyectoD'")
  EXEC ("spALTER_COLUMN 'PlantillaProyectoD', 'Actividad', 'varchar(50) NOT NULL'")
  EXEC ("spADD_PK 'PlantillaProyectoD', 'Plantilla, Actividad'")
END
GO
EXEC spALTER_COLUMN 'PlantillaProyectoD', 'Predecesora', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'PlantillaProyectoD', 'Orden', 'varchar(255) NULL'
GO

EXEC spFK 'PlantillaProyectoD','Clave','ActClave','Clave'
EXEC spFK 'PlantillaProyectoD','RecursoOmision','Recurso','Recurso'
GO

EXEC spADD_INDEX 'PlantillaProyectoD', 'Orden', 'Plantilla, Orden'
go

/****** PlantillaProyectoDRecurso ******/
if not exists(select * from SysTabla where SysTabla = 'PlantillaProyectoDRecurso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PlantillaProyectoDRecurso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PlantillaProyectoDRecurso') and type = 'U') 
  CREATE TABLE dbo.PlantillaProyectoDRecurso (
	Plantilla		varchar(50)  	NOT NULL,
	Actividad		varchar(50)	NOT NULL,
	Recurso			varchar(10)	NOT NULL,

	CONSTRAINT priPlantillaProyectoDRecurso PRIMARY KEY  CLUSTERED (Plantilla, Actividad, Recurso)
  )
go
if exists(select * from syscampoext where Tabla = 'PlantillaProyectoDRecurso' and campo='Actividad' and ancho=20)
BEGIN
  EXEC ("spDROP_PK 'PlantillaProyectoDRecurso'")
  EXEC ("spALTER_COLUMN 'PlantillaProyectoDRecurso', 'Actividad', 'varchar(50) NOT NULL'")
  EXEC ("spADD_PK 'PlantillaProyectoDRecurso', 'Plantilla, Actividad, Recurso'")
END
GO

EXEC spFK 'PlantillaProyectoDRecurso','Recurso','Recurso','Recurso'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgPlantillaProyectoBC') and sysstat & 0xf = 8) drop trigger dbo.tgPlantillaProyectoBC
GO
-- Aqui va el Matenimiento a la tabla
CREATE TRIGGER tgPlantillaProyectoBC ON PlantillaProyecto
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @PlantillaN varchar(50),
    @PlantillaA varchar(50)
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PlantillaN = Plantilla FROM Inserted
  SELECT @PlantillaA = Plantilla FROM Deleted
  IF @PlantillaN = @PlantillaA  RETURN

  IF @PlantillaN IS NULL 
  BEGIN
    DELETE PlantillaProyectoD WHERE Plantilla = @PlantillaA 
    DELETE PlantillaProyectoDRecurso WHERE Plantilla = @PlantillaA 
  END ELSE BEGIN
    UPDATE PlantillaProyectoD SET Plantilla = @PlantillaN WHERE Plantilla = @PlantillaA 
    UPDATE PlantillaProyectoDRecurso SET Plantilla = @PlantillaN WHERE Plantilla = @PlantillaA 
  END
END
GO


-- drop table ProyectoReestructurar
/*********************** ProyectoReestructurar *****************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoReestructurar')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoReestructurar','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoReestructurar') and type = 'u')
CREATE TABLE ProyectoReestructurar (
        Estacion                int             NOT NULL,
        IDInterno               int             NOT NULL        IDENTITY(1,1),

        ID                      int             NOT NULL,
        Actividad               varchar(50)     NOT NULL,
        
	Predecesora		varchar(50)	NULL,
	Orden			varchar(255)	NULL,
	EsFase			bit		NULL	DEFAULT 0,
	Clave			varchar(20)	NULL,
	Asunto			varchar(100)	NULL,
	Tipo			varchar(20)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Duracion		float		NULL,
	DuracionUnidad		varchar(10)	NULL,
	DuracionDias		float		NULL,
	Comentarios		text		NULL,
	Usuario			varchar(10)	NULL,
	UltimoCambio		datetime	NULL,

	Comienzo		datetime	NULL,
	Fin			datetime	NULL,
	Estado			varchar(30)	NULL,
	Avance			float		NULL,
	Prioridad		varchar(10)	NULL,

	Proyecto		varchar(50)	NULL,
	EstaLiberado		bit		NULL	DEFAULT 0,
	FechaLiberacion		datetime	NULL,

        Sucursal                int             NULL,
        SucursalOrigen          int             NULL,
        SucursalDestino         int             NULL,

        TieneMovimientos        bit             DEFAULT 0,
        SubPlantilla            varchar(50)     NULL,

        CONSTRAINT priProyectoReestructurar PRIMARY KEY CLUSTERED (Estacion, IDInterno)
)
GO
EXEC spALTER_COLUMN 'ProyectoReestructurar', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'ProyectoReestructurar', 'Clave', 'varchar(20) NULL'
GO
EXEC spALTER_COLUMN 'ProyectoReestructurar', 'Actividad', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProyectoReestructurar', 'Predecesora', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ProyectoReestructurar', 'Orden', 'varchar(255) NULL'
GO

/************** ProyectoDesarrolloCausa **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloCausa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloCausa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloCausa') and type = 'u')
CREATE TABLE ProyectoDesarrolloCausa (
        Causa                   varchar(100)    NOT NULL,
        
        CONSTRAINT priProyectoDesarrolloCausa PRIMARY KEY CLUSTERED (Causa)
)
GO

-- drop table ProyectoDesarrolloClase1
/************** ProyectoDesarrolloClase1 **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloClase1')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloClase1','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloClase1') and type = 'u')
CREATE TABLE ProyectoDesarrolloClase1 (
        Clase1                  varchar(50)     NOT NULL,
        Supervisor              varchar(20)     NULL,
	Orden			int		NULL,
        
        CONSTRAINT priProyectoDesarrolloClase1 PRIMARY KEY CLUSTERED (Clase1)
)
GO
EXEC spALTER_TABLE 'ProyectoDesarrolloClase1', 'Orden', 'int NULL'
GO
/************** ProyectoDesarrolloClase2 **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloClase2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloClase2','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloClase2') and type = 'u')
CREATE TABLE ProyectoDesarrolloClase2 (
        Clase1                  varchar(50)    NOT NULL,
        Clase2                  varchar(50)    NOT NULL,

        Supervisor              varchar(20)     NULL,
	Orden			int		NULL,
        
        CONSTRAINT priProyectoDesarrolloClase2 PRIMARY KEY CLUSTERED (Clase1, Clase2)
)
GO
EXEC spALTER_TABLE 'ProyectoDesarrolloClase2', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ProyectoDesarrolloClase2', 'Supervisor', 'varchar(20) NULL'
GO

/************** ProyectoDesarrolloClase3 **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloClase3')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloClase3','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloClase3') and type = 'u')
CREATE TABLE ProyectoDesarrolloClase3 (
        Clase1                  varchar(50)    NOT NULL,
        Clase2                  varchar(50)    NOT NULL,
        Clase3                  varchar(50)    NOT NULL,

        Supervisor              varchar(20)     NULL,
	Orden			int		NULL,
        
        CONSTRAINT priProyectoDesarrolloClase3 PRIMARY KEY CLUSTERED (Clase1, Clase2, Clase3)
)
GO
EXEC spALTER_TABLE 'ProyectoDesarrolloClase3', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ProyectoDesarrolloClase3', 'Supervisor', 'varchar(20) NULL'
GO

/************** ProyectoDesarrolloClase4 **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloClase4')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloClase4','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloClase4') and type = 'u')
CREATE TABLE ProyectoDesarrolloClase4 (
        Clase1                  varchar(50)    NOT NULL,
        Clase2                  varchar(50)    NOT NULL,
        Clase3                  varchar(50)    NOT NULL,
        Clase4                  varchar(50)    NOT NULL,

        Supervisor              varchar(20)     NULL,
	Orden			int		NULL,
        
        CONSTRAINT priProyectoDesarrolloClase4 PRIMARY KEY CLUSTERED (Clase1, Clase2, Clase3, Clase4)
)
GO
EXEC spALTER_TABLE 'ProyectoDesarrolloClase4', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ProyectoDesarrolloClase4', 'Supervisor', 'varchar(20) NULL'
GO

/************** ProyectoDesarrolloClase5 **************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrolloClase5')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyectoDesarrolloClase5','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrolloClase5') and type = 'u')
CREATE TABLE ProyectoDesarrolloClase5 (
        Clase1                  varchar(50)    NOT NULL,
        Clase2                  varchar(50)    NOT NULL,
        Clase3                  varchar(50)    NOT NULL,
        Clase4                  varchar(50)    NOT NULL,
        Clase5                  varchar(50)    NOT NULL,

        Supervisor              varchar(20)     NULL,
	Orden			int		NULL,

        CONSTRAINT priProyectoDesarrolloClase5 PRIMARY KEY CLUSTERED (Clase1, Clase2, Clase3, Clase4, Clase5)
)
GO
EXEC spALTER_TABLE 'ProyectoDesarrolloClase5', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ProyectoDesarrolloClase5', 'Supervisor', 'varchar(20) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDesarrolloClase1C') and type = 'tr') drop trigger tgProyectoDesarrolloClase1C
GO
CREATE TRIGGER tgProyectoDesarrolloClase1C ON ProyectoDesarrolloClase1
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Clase1N            varchar(50),
    @Clase1A            varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Clase1N = Clase1 FROM Inserted
  SELECT @Clase1A = Clase1 FROM Deleted

  IF @Clase1N <> @Clase1A
  BEGIN
    UPDATE ProyectoDesarrolloClase2 SET Clase1 = @Clase1N WHERE Clase1 = @Clase1A
    UPDATE ProyectoDesarrolloClase3 SET Clase1 = @Clase1N WHERE Clase1 = @Clase1A
    UPDATE ProyectoDesarrolloClase4 SET Clase1 = @Clase1N WHERE Clase1 = @Clase1A
    UPDATE ProyectoDesarrolloClase5 SET Clase1 = @Clase1N WHERE Clase1 = @Clase1A
  END

  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDesarrolloClase2C') and type = 'tr') drop trigger tgProyectoDesarrolloClase2C
GO
CREATE TRIGGER tgProyectoDesarrolloClase2C ON ProyectoDesarrolloClase2
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Clase2N            varchar(50),
    @Clase2A            varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Clase2N = Clase2 FROM Inserted
  SELECT @Clase2A = Clase2 FROM Deleted

  IF @Clase2N <> @Clase2A
  BEGIN
    UPDATE ProyectoDesarrolloClase3 SET Clase2 = @Clase2N WHERE Clase2 = @Clase2A
    UPDATE ProyectoDesarrolloClase4 SET Clase2 = @Clase2N WHERE Clase2 = @Clase2A
    UPDATE ProyectoDesarrolloClase5 SET Clase2 = @Clase2N WHERE Clase2 = @Clase2A
  END

  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDesarrolloClase3C') and type = 'tr') drop trigger tgProyectoDesarrolloClase3C
GO
CREATE TRIGGER tgProyectoDesarrolloClase3C ON ProyectoDesarrolloClase3
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Clase3N            varchar(50),
    @Clase3A            varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Clase3N = Clase3 FROM Inserted
  SELECT @Clase3A = Clase3 FROM Deleted

  IF @Clase3N <> @Clase3A
  BEGIN
    UPDATE ProyectoDesarrolloClase4 SET Clase3 = @Clase3N WHERE Clase3 = @Clase3A
    UPDATE ProyectoDesarrolloClase5 SET Clase3 = @Clase3N WHERE Clase3 = @Clase3A
  END

  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProyectoDesarrolloClase4C') and type = 'tr') drop trigger tgProyectoDesarrolloClase4C
GO
CREATE TRIGGER tgProyectoDesarrolloClase4C ON ProyectoDesarrolloClase4
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Clase4N            varchar(50),
    @Clase4A            varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Clase4N = Clase4 FROM Inserted
  SELECT @Clase4A = Clase4 FROM Deleted

  IF @Clase4N <> @Clase4A
    UPDATE ProyectoDesarrolloClase5 SET Clase4 = @Clase4N WHERE Clase4 = @Clase4A

  RETURN
END
GO

-- drop table proyectodesarrollo
/***************** ProyectoDesarrollo *****************/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDesarrollo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ProyectoDesarrollo','Movimiento','PROY')
GO
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDesarrollo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProyectoDesarrollo (
        ID                      int             NOT NULL,

        Tipo                    varchar(50)     NULL,
        VersionCliente          int             NULL,
        Causa                   varchar(100)    NULL,
        FechaRequerida          datetime        NULL,

        Importe                 money           NULL,
        Moneda                  varchar(10)     NULL,
        TipoCambio              float           NULL,

        Clase1                  varchar(50)     NULL,
        Clase2                  varchar(50)     NULL,
        Clase3                  varchar(50)     NULL,
        Clase4                  varchar(50)     NULL,
        Clase5                  varchar(50)     NULL,

        Problema                text            NULL,
        Solucion                text            NULL,

        CONSTRAINT priProyectoDesarrollo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ProyectoDesarrollo'
END
GO
EXEC spSincroNivelRegistro @Tabla = 'ProyectoDesarrollo'
GO


/** CAMPOS CALCULADOS **/
/**************** fnProyectoDRecursoEnLista ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnProyectoDRecursoEnLista') DROP FUNCTION dbo.fnProyectoDRecursoEnLista
GO
CREATE FUNCTION fnProyectoDRecursoEnLista (@ID int, @Actividad varchar(50))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Recurso	varchar(10),
    @Nombre	varchar(100),
    @Resultado 	varchar(255)

  SELECT @Resultado = ''

  DECLARE crProyectoDRecurso CURSOR LOCAL FOR
    SELECT NULLIF(RTRIM(d.Recurso), ''), NULLIF(RTRIM(r.Nombre), '')
      FROM ProyectoDRecurso d
      JOIN Recurso r ON r.Recurso = d.Recurso
     WHERE d.ID = @ID AND d.Actividad = @Actividad

  OPEN crProyectoDRecurso
  FETCH NEXT FROM crProyectoDRecurso INTO @Recurso, @Nombre
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Recurso IS NOT NULL
    BEGIN
      IF @Resultado <> '' SELECT @Resultado = @Resultado + ', '
      SELECT @Resultado = @Resultado + @Nombre
    END
    FETCH NEXT FROM crProyectoDRecurso INTO @Recurso, @Nombre
  END
  CLOSE crProyectoDRecurso
  DEALLOCATE crProyectoDRecurso
  
  RETURN(@Resultado)
END
GO

/**************** fnProyectoDIndicador ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnProyectoDIndicador') DROP FUNCTION dbo.fnProyectoDIndicador
GO
CREATE FUNCTION fnProyectoDIndicador (@ID int, @Actividad varchar(50), @Ahora datetime, @EstaLiberado bit, @Comienzo datetime, @Fin datetime, @Avance float)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE    
    @Resultado 		int,
    @Empresa		varchar(5),
    @FechaRevision	datetime,
    @ComienzoDias	int,
    @FinDias		int,
    @Duracion		int,
    @AvanceTeorico	float,
    @CfgFechaRevision	varchar(20),
    @CfgDiasIndicador1	int,
    @CfgDifIndicador1   bit 

  SELECT @Empresa = Empresa, @FechaRevision = @FechaRevision FROM Proyecto WHERE ID = @ID
  SELECT @CfgFechaRevision = UPPER(ProyFechaRevision), @CfgDiasIndicador1 = NULLIF(ProyDiasIndicador1, 0), @CfgDifIndicador1 = ISNULL(ProyIndicador1Liberados, 0) FROM EmpresaCfg WHERE Empresa = @Empresa

  IF @CfgFechaRevision = 'SERVIDOR' SELECT @FechaRevision = @Ahora
-- 0=Azul, 1=Verde, 2=Amarillo, 3=Rojo, 11=Liberado
  SELECT @ComienzoDias = DATEDIFF(day, @FechaRevision, @Comienzo),
         @FinDias      = DATEDIFF(day, @FechaRevision, @Fin),
         @Duracion     = DATEDIFF(day, @Comienzo, @Fin)
  SELECT @Resultado = 0
  IF @Avance = 100 SELECT @Resultado = 1
  ELSE
    IF @FinDias < 0 SELECT @Resultado = 3
    ELSE BEGIN
      IF @EstaLiberado = 1 OR (@CfgDiasIndicador1 IS NOT NULL AND @ComienzoDias <= @CfgDiasIndicador1) 
        SELECT @Resultado = CASE WHEN @CfgDifIndicador1 = 1 THEN 11 ELSE 1 END

      IF @ComienzoDias < 0 
      BEGIN
        SELECT @AvanceTeorico = 100.0*(-@ComienzoDias)/@Duracion
        IF @Avance < @AvanceTeorico SELECT @Resultado = 2
      END
    END
  RETURN(ISNULL(@Resultado, 0))
END
GO

/**************** fnProyectoActividadActual ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnProyectoActividadActual') DROP FUNCTION dbo.fnProyectoActividadActual
GO
CREATE FUNCTION fnProyectoActividadActual (@ID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Orden	varchar(100),
    @Resultado	varchar(50)
  SELECT @Orden = MIN(Orden) FROM ProyectoD WHERE ID = @ID AND EsFase = 0 AND UPPER(Estado) NOT IN ('ELIMINADA', 'COMPLETADA', 'CANCELADA')
  SELECT @Resultado = Actividad FROM ProyectoD WHERE ID = @ID AND Orden = @Orden
  RETURN(@Resultado)
END
GO



GO
EXEC spALTER_TABLE 'ProyectoD', 'RecursosAsignados', 'AS dbo.fnProyectoDRecursoEnLista(ID, Actividad)'
EXEC spALTER_TABLE 'ProyectoD', 'Indicador', 'AS dbo.fnProyectoDIndicador(ID, Actividad, GETDATE(), EstaLiberado, Comienzo, Fin, Avance)'
GO
-- REQ PROYECTOS
EXEC spALTER_TABLE 'ProyectoD', 'IDGestion', 'int NULL'
EXEC spALTER_TABLE 'ProyectoD', 'MovGestion', 'varchar(50) NULL'
GO

/**************** fnProyectoIndicadorConteo ****************/
IF exists (SELECT name FROM sysobjects WHERE name = 'fnProyectoIndicadorConteo') DROP FUNCTION dbo.fnProyectoIndicadorConteo
GO
CREATE FUNCTION fnProyectoIndicadorConteo (@ID int, @Indicador int, @Indicador2 int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado	int

  IF @Indicador2 IS NULL
    SELECT @Resultado = COUNT(*) FROM ProyectoD WHERE ID = @ID AND Indicador = @Indicador
  ELSE
    SELECT @Resultado = COUNT(*) FROM ProyectoD WHERE ID = @ID AND (Indicador = @Indicador OR Indicador = @Indicador2)

  RETURN(@Resultado)
END
GO

EXEC spALTER_TABLE 'Proyecto', 'ActividadActual', 'AS dbo.fnProyectoActividadActual(ID)'
EXEC spALTER_TABLE 'Proyecto', 'Indicador0', 'AS dbo.fnProyectoIndicadorConteo(ID, 0, NULL)'
EXEC spALTER_TABLE 'Proyecto', 'Indicador1', 'AS dbo.fnProyectoIndicadorConteo(ID, 1, 11)'
EXEC spALTER_TABLE 'Proyecto', 'Indicador2', 'AS dbo.fnProyectoIndicadorConteo(ID, 2, NULL)'
EXEC spALTER_TABLE 'Proyecto', 'Indicador3', 'AS dbo.fnProyectoIndicadorConteo(ID, 3, NULL)'
go
-- select dbo.fnProyectoIndicadorConteo(2, NULL)
-- select * from proyecto
-- select DATEDIFF (day , '1/1/1' , '2/1/1') 


--REQ PROYECTOS
/****** ProyectoDBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoDBitacora') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProyectoDBitacora', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoDBitacora') and type = 'U') 
  CREATE TABLE ProyectoDBitacora(
    ID					int				NOT NULL,
    Actividad           varchar(50)     NOT NULL,
    RID					int				IDENTITY (1,1),

	Asunto              varchar(100)    NULL,
    PorcentajeAvance	float			NULL,
    IDGestion			int				NULL,
	Comienzo            datetime        NULL,
	Fin                 datetime        NULL,
	RecursosAsignados   varchar(255)     NULL,   
	Usuario             varchar(10)     NULL,
	FechaCambio         datetime        NULL,
	Estado              varchar(30)     NULL,
	MovGestion          varchar(50)     NULL,

   CONSTRAINT priProyectoDBitacora PRIMARY KEY CLUSTERED(ID, Actividad, RID)
   )
GO

EXEC spADD_INDEX 'ProyectoDBitacora', 'IDGestion', 'IDGestion'
GO



--REQ PROYECTOS
/**************** tgProyectoD ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgProyectoD') and sysstat & 0xf = 8) drop trigger dbo.tgProyectoD
GO
CREATE TRIGGER tgProyectoD ON ProyectoD
--//WITH ENCRYPTION
FOR UPDATE
AS
BEGIN
  DECLARE @FechaCambio	datetime,
		  @ID			int,
		  @IDAnt		int,
		  @Actividad    varchar(50),
		  @ActividadAnt	varchar(50),
		  @RID			int,
		  @Usuario      varchar(10)
  
  SELECT @FechaCambio = GETDATE()
 
  EXEC spExtraerFecha @FechaCambio OUTPUT

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID) FROM Inserted WHERE ID > @IDAnt

    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @ActividadAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Actividad = MIN(Actividad) FROM Inserted WHERE ID = @ID AND Actividad > @ActividadAnt

      IF @Actividad IS NULL BREAK
    
      SELECT @ActividadAnt = @Actividad
      
      SELECT @RID = MAX(RID) FROM ProyectoDBitacora WHERE ID = @ID AND Actividad = @Actividad
	  
      SELECT @Usuario = Usuario FROM Proyecto WHERE ID = @ID

      IF @RID IS NOT NULL
        INSERT INTO ProyectoDBitacora(
		           ID,   Actividad,  Asunto,   PorcentajeAvance,   IDGestion,    Comienzo,     Fin,  RecursosAsignados,   Usuario,    FechaCambio,   Estado,  MovGestion)
	      SELECT i.ID, i.Actividad,  i.Asunto, i.Avance,         i.IDGestion,  i.Comienzo, i.Fin,  i.RecursosAsignados,  @Usuario, @FechaCambio, i.Estado, i.MovGestion
       	    FROM Inserted i 
   	        JOIN ProyectoDBitacora d ON i.ID = d.ID AND i.Actividad = d.Actividad
     	   WHERE d.RID = @RID
     	     AND i.ID = @ID
     	     AND d.Actividad = @Actividad
     	     AND ((ISNULL(i.Avance, 0) <> ISNULL(d.PorcentajeAvance, 0))
     	      OR (ISNULL(i.Comienzo, '') <> ISNULL(d.Comienzo, ''))
     	      OR (ISNULL(i.Fin, '') <> ISNULL(d.Fin, ''))     	      
     	      OR (ISNULL(i.RecursosAsignados, '') <> ISNULL(d.RecursosAsignados, ''))
     	      OR (ISNULL(i.Estado, '')  <> ISNULL(d.Estado, ''))
     	      OR (ISNULL(i.MovGestion, '')  <> ISNULL(d.MovGestion, '')))
     	      
      ELSE
        INSERT INTO ProyectoDBitacora(
		           ID,   Actividad,  Asunto,   PorcentajeAvance,   IDGestion,    Comienzo,     Fin,  RecursosAsignados,   Usuario,   FechaCambio,   Estado,  MovGestion)
	      SELECT i.ID, i.Actividad,  i.Asunto, i.Avance,         i.IDGestion,  i.Comienzo, i.Fin,  i.RecursosAsignados,   @Usuario, @FechaCambio, i.Estado, i.MovGestion
       	    FROM Inserted i 
     	   WHERE i.ID = @ID
     	     AND i.Actividad = @Actividad
    END
  END

  RETURN
END
GO
/**************** ConceptosRH ****************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.ConceptosRH') AND type in ('U'))
	DROP TABLE ConceptosRH
GO
CREATE TABLE ConceptosRH (
	ID				int identity(1,1) NOT NULL,
	ConceptoRH		varchar(255) NULL,
	ConceptoStaff	varchar(255) NULL
)
GO


/**************** ArrastreProy ****************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.ArrastreProy') AND type in ('U'))
	DROP TABLE ArrastreProy
GO
CREATE TABLE ArrastreProy (
	Sucursal		int		NOT NULL DEFAULT 0,
	Empresa			varchar(5)  NOT NULL,
	OModulo			varchar(5)	NOT NULL,
	OID				int			NOT NULL,
	OMov 			varchar(20)	NOT NULL,
	OMovID			varchar(20)	NOT NULL,
	DModulo			char(5)		NOT NULL,
    DID				int			NOT NULL,
	DMov 			varchar(20)	NOT NULL,
	DMovID			varchar(20) NOT NULL,
	AnteriorOID		int			NOT NULL,
	AnteriorOMov	varchar(20)	NOT NULL,
	AnteriorOMovID	varchar(20)	NOT NULL,
	FechaCambio		datetime	NOT NULL
)
GO

/**************** LineaBase ****************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.LineaBase') AND type in ('U'))
	DROP TABLE LineaBase
GO
CREATE TABLE LineaBase(
	ID int NOT NULL,
	FechaAltaLB datetime NOT NULL,
	Empresa char(5) NOT NULL,
	Mov char(20) NOT NULL,
	MovID varchar(20) NULL,
	FechaEmision datetime NULL,
	UltimoCambio datetime NULL,
	Proyecto varchar(50) NULL,
	ProyectoReestructurar varchar(50) NULL,
	Reestructurar bit NULL,
	FechaRevision datetime NULL,
	ContactoTipo varchar(20) NULL,
	Prospecto varchar(10) NULL,
	Cliente varchar(10) NULL,
	Proveedor varchar(10) NULL,
	Personal varchar(10) NULL,
	Agente varchar(10) NULL,
	Riesgo varchar(10) NULL,
	ProyectoRama varchar(50) NULL,
	UEN int NULL,
	Concepto varchar(50) NULL,
	Usuario char(10) NULL,
	Autorizacion char(10) NULL,
	DocFuente int NULL,
	Observaciones varchar(100) NULL,
	Referencia varchar(50) NULL,
	Estatus char(15) NULL,
	Situacion varchar(50) NULL,
	SituacionFecha datetime NULL,
	SituacionUsuario varchar(10) NULL,
	SituacionNota varchar(100) NULL,
	Moneda varchar(10) NULL,
	TipoCambio float NULL,
	OrigenTipo varchar(10) NULL,
	Origen varchar(20) NULL,
	OrigenID varchar(20) NULL,
	Ejercicio int NULL,
	Periodo int NULL,
	FechaRegistro datetime NULL,
	FechaConclusion datetime NULL,
	FechaCancelacion datetime NULL,
	Comienzo datetime NULL,
	Fin datetime NULL,
	ConsiderarAvanceActual bit NULL,
	CalculoInverso bit NULL,
	Sucursal int NOT NULL,
	Prioridad varchar(10) NULL,
	Supervisor varchar(10) NULL,
	DiasHabiles varchar(20) NULL,
	HorasDia float NULL,
	MontoEstimado money NULL,
	FechaEstimada datetime NULL,
	Probabilidad float NULL,
	Avance float NULL,
	Comentarios text NULL,
	FechaRequerida datetime NULL,
	Descripcion varchar(100) NULL,
	SucursalOrigen int NOT NULL,
	SucursalDestino int NULL	
	
	CONSTRAINT priLineaBase PRIMARY KEY CLUSTERED (ID)
)
GO

/**************** LineaBaseD ****************/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('dbo.LineaBaseD') AND type in ('U'))
	DROP TABLE LineaBaseD
GO
CREATE TABLE LineaBaseD(
	ID int NOT NULL,
	Actividad varchar(50) NOT NULL,
	Predecesora varchar(50) NULL,
	Orden varchar(255) NULL,
	EsFase bit NULL,
	Clave varchar(20) NULL,
	Asunto varchar(100) NULL,
	Tipo varchar(20) NULL,
	Categoria varchar(50) NULL,
	Grupo varchar(50) NULL,
	Familia varchar(50) NULL,
	Duracion float NULL,
	DuracionUnidad varchar(10) NULL,
	DuracionDias float NULL,
	Comentarios text NULL,
	Usuario varchar(10) NULL,
	UltimoCambio datetime NULL,
	Comienzo datetime NULL,
	Fin datetime NULL,
	Estado varchar(30) NULL,
	Avance float NULL,
	Prioridad varchar(10) NULL,
	ComienzoEsp datetime NULL,
	Sincronizando bit NULL,
	Proyecto varchar(50) NULL,
	EstaLiberado bit NULL,
	FechaLiberacion datetime NULL,
	TieneMovimientos bit NULL,
	EsNuevo bit NULL,
	FechaInicio datetime NULL,
	FechaConclusion datetime NULL,
	Sucursal int NOT NULL,
	SucursalOrigen int NOT NULL,
	SucursalDestino int NULL,
	IDGestion int NULL,
	MovGestion varchar(50) NULL,
	RecursosAsignados varchar(255) NULL,
	Indicador	int NULL,
	Esfuerzo float NULL		
)
GO
