
/*******************************************************************************************/
/*                                     Recursos Humanos                                    */
/*******************************************************************************************/


/****** Consecutivos (RH) ******/
if not exists(select * from SysTabla where SysTabla = 'RHC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RHC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.RHC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RHC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priRHC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'RHC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'RHC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE RHC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE RHC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** RH ******/
if not exists(select * from SysTabla where SysTabla = 'RH')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('RH','Movimiento','RH')
if not exists (select * from sysobjects where id = object_id('dbo.RH') and type = 'U') 
BEGIN
  CREATE TABLE dbo.RH (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov 			char(20)        NOT NULL,	-- Altas, Modificaciones, Bajas, Evaluaciones, Cursos, etc.
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

	Evaluacion		varchar(50)	NULL,

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

	CONSTRAINT priRH PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'RH'
END
go
EXEC spSincroNivelRegistro @Tabla = 'RH'
go
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX RH.Consecutivo
  ALTER TABLE RH ALTER COLUMN MovID varchar(20)
  ALTER TABLE RH ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE RH ALTER COLUMN PolizaID varchar(20)
END
GO
EXEC spALTER_TABLE 'RH', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'RH', 'SituacionNota', 'varchar(100) NULL'
GO

EXEC spFK 'RH','Moneda','Mon','Moneda'
EXEC spFK 'RH','Evaluacion','Evaluacion','Evaluacion'
EXEC spFK 'RH','UEN','UEN','UEN'
GO

-- RH
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.RH (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.RH (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.RH (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.RH (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.RH (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.RH (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX RH.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX RH.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX RH.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX RH.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX RH.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON RH (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON RH (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RH' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON RH (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgRHA') and sysstat & 0xf = 8) drop trigger dbo.tgRHA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRHC') and sysstat & 0xf = 8) drop trigger dbo.tgRHC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgRHB') and sysstat & 0xf = 8) drop trigger dbo.tgRHB
GO
EXEC spModificarPK_Mov 'RH'
GO
EXEC spSincroNivelRegistroCampos 'RH'
GO
EXEC spALTER_TABLE 'RH', 'UEN', 'int NULL'
-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgRHC ON RH
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
  
  SELECT @Modulo = 'RH'
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
    UPDATE RH SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgRHB ON RH
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
    EXEC spMovAlEliminar 'RH', @ID
END
GO

/****** RHD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'RHD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('RHD','Movimiento','RH')
if not exists (select * from sysobjects where id = object_id('dbo.RHD') and type = 'U') 
CREATE TABLE dbo.RHD (
	ID 			int       	NOT NULL,
 	Renglon			float	  	NOT NULL,

	Personal		char(10)	NULL,
	SueldoDiario		money		NULL,
	SDI			money		NULL,
	TipoContrato		varchar(50)	NULL,
	PeriodoTipo		varchar(20)	NULL,
	Jornada			varchar(20)	NULL,
	TipoSueldo		varchar(10)	NULL,
	Categoria		varchar(50)	NULL,
	Departamento		varchar(50)	NULL,
	Puesto			varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Observaciones		varchar(50)	NULL,
	FechaAlta		datetime	NULL,
	FechaAntiguedad		datetime	NULL,
	VencimientoContrato	datetime	NULL,
	Calificacion		money		NULL,
	SucursalTrabajo		int		NULL,
	ReportaA		varchar(10)	NULL,
	CentroCostos		varchar(20)	NULL,
	Incremento		float		NULL,
	SueldoNuevo		money		NULL,
	Plaza			varchar(20)	NULL,
	SueldoDiarioComplemento	money		NULL,
	SueldoMensual		money 		NULL,
	RataHora		money 		NULL,

	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	
	IDSEConciliado  bit     NULL DEFAULT 0,
	IDSEMensaje     varchar(255)    NULL,

	CONSTRAINT priRHD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'RHD' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.RHD (Personal)
GO
EXEC spModificarPK_Sucursal 'RHD', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'RHD', 'SucursalTrabajo', 'int NULL'
EXEC spRENAME_COLUMN 'RHD', 'SueldoFijo', 'SueldoDiario'
EXEC spRENAME_COLUMN 'RHD', 'SueldoVariable', 'SDI'
GO
if (select version from version) <= 1258
  UPDATE RHD SET SDI = NULL
GO
EXEC spALTER_TABLE 'RHD', 'ReportaA', 'varchar(10) NULL'
EXEC spALTER_TABLE 'RHD', 'CentroCostos', 'varchar(20) NULL'
EXEC spALTER_TABLE 'RHD', 'Incremento', 'float NULL'
EXEC spALTER_TABLE 'RHD', 'Plaza', 'varchar(20) NULL'
EXEC spALTER_TABLE 'RHD', 'SueldoDiarioComplemento', 'money NULL'
EXEC spALTER_TABLE 'RHD', 'SueldoNuevo', 'money	NULL'
EXEC spALTER_TABLE 'RHD', 'SueldoMensual',  'money NULL'
EXEC spALTER_TABLE 'RHD', 'RataHora', 'money NULL'
EXEC spALTER_TABLE 'RHD', 'FechaInicioContrato', 'datetime null' 
EXEC spALTER_TABLE 'RHD', 'DuracionContrato', 'int null'
EXEC spALTER_TABLE 'RHD', 'IDSEConciliado', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'RHD', 'IDSEMensaje', 'varchar(255) NULL'
GO

EXEC spFK 'RHD','SucursalTrabajo','Sucursal','Sucursal'
EXEC spFK 'RHD','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'RHD','Plaza','Plaza','Plaza'
GO

if exists (select * from sysobjects where id = object_id('dbo.cRHD') and sysstat & 0xf = 2) drop view dbo.cRHD
GO
CREATE VIEW cRHD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Personal,
  SueldoDiario,
  SDI,
  TipoContrato,
  PeriodoTipo,
  Jornada,
  TipoSueldo,
  Categoria,
  Departamento,
  Puesto,
  Grupo,
  Observaciones,
  FechaAlta,
  FechaAntiguedad,
  SucursalTrabajo,
  Calificacion,
  Sucursal,
  SucursalOrigen,
  ReportaA,
  CentroCostos,
  Incremento,
  SueldoNuevo,
  Plaza,
  SueldoDiarioComplemento,
  SueldoMensual,
  RataHora,
  FechaInicioContrato,
  DuracionContrato,

  Logico1,
  Logico2,
  Logico3,
  Logico4,
  Logico5

FROM
  RHD
GO

/****** Registro Patronal (RH) ******/
if not exists(select * from SysTabla where SysTabla = 'RHRegistroPatronal')
INSERT INTO SysTabla (SysTabla,Tipo, Modulo) VALUES ('RHRegistroPatronal','Movimiento', 'RH')
if not exists (select * from sysobjects where id = object_id('dbo.RHRegistroPatronal') and type = 'U') 
CREATE TABLE dbo.RHRegistroPatronal (
    ID                      int             NOT NULL,
    RegistroPatronal        varchar(20)     NOT NULL,
    Folio                   varchar(20)     NULL,
    Estatus                 varchar(15)     NULL,
    AnexoEnvio              varchar(255)    NULL,
    AnexoRespuesta          varchar(255)    NULL,
    SecuencialNotaria       int             NULL

    CONSTRAINT priRHRegistroPatronal PRIMARY KEY  CLUSTERED (ID, RegistroPatronal)
)
GO


/****** Plazas (RH) ******/
if not exists(select * from SysTabla where SysTabla = 'RHPlaza')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RHPlaza','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RHPlaza') and type = 'U') 
CREATE TABLE dbo.RHPlaza (
	Empresa			char(5)         NOT NULL,
	Sucursal		int		NOT NULL	DEFAULT 0,

        Departamento		varchar(50)	NOT NULL,
        Puesto			varchar(50)	NOT NULL,
	Plazas			int		NULL,
	EnUso			int		NULL,

	CONSTRAINT priRHPlaza PRIMARY KEY  CLUSTERED (Empresa, Sucursal, Departamento, Puesto)
)
GO
EXEC spALTER_TABLE 'RHPlaza', 'Sucursal', 'int NOT NULL	DEFAULT 0 WITH VALUES'
GO
if (select version from version) < = 1258
begin
  EXEC("spEliminarPK 'RHPlaza'")
  EXEC("ALTER TABLE RHPlaza ADD CONSTRAINT priRHPlaza PRIMARY KEY  CLUSTERED (Empresa, Sucursal, Departamento, Puesto)")
end
GO

EXEC spFK 'RHPlaza','Sucursal','Sucursal','Sucursal'
GO

/****** Puesto ******/
if not exists(select * from SysTabla where SysTabla = 'Puesto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Puesto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Puesto') and type = 'U') 
CREATE TABLE dbo.Puesto (
	Puesto		varchar(50) 	NOT NULL,
	Descripcion	varchar(100) 	NULL,
	SueldoDef	money		NULL,

	CONSTRAINT priPuesto PRIMARY KEY  CLUSTERED (Puesto)
)
GO


/****** PuestoSucursal ******/
if not exists(select * from SysTabla where SysTabla = 'PuestoSucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PuestoSucursal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PuestoSucursal') and type = 'U') 
CREATE TABLE dbo.PuestoSucursal (
	Puesto		varchar(50)	NOT NULL,
	Sucursal	int		NOT NULL,

	SueldoDef	money		NULL,
	SueldoMensual	money		NULL,

	CONSTRAINT priPuestoSucursal PRIMARY KEY CLUSTERED (Puesto, Sucursal))
GO

EXEC spFK 'PuestoSucursal','Sucursal','Sucursal','Sucursal'
GO

/****** Registro Patronal ******/
if not exists(select * from SysTabla where SysTabla = 'RegistroPatronal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('RegistroPatronal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.RegistroPatronal') and type = 'U') 
CREATE TABLE dbo.RegistroPatronal (
    RegistroPatronal        varchar(20)     NOT NULL,
    AnexoCertificado        varchar(255)    NULL,
    Usuario                 varchar(20)     NULL,
    Contrasena              varchar(20)     NULL

    CONSTRAINT priRegistroPatronal PRIMARY KEY  CLUSTERED (RegistroPatronal)
)
GO

-- select empresa, AutoCANAPAT from EmpresaCfg2
