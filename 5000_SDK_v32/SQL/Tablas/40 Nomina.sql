
/*******************************************************************************************/
/*                                             NOMINA                                      */
/*******************************************************************************************/


/****** Consecutivos (Nomina) ******/
if not exists (select * from SysTabla where SysTabla = 'NominaC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priNominaC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NominaC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'NominaC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE NominaC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE NominaC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Nomina ******/
if not exists (select * from SysTabla where SysTabla = 'Nomina') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Nomina','Movimiento','NOM')
if not exists (select * from sysobjects where id = object_id('dbo.Nomina') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Nomina (
	ID			int 	    	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov 			varchar(20)        NOT NULL,	
	MovID			varchar(20)    	NULL,
	FechaEmision 		datetime    	NULL,
	UltimoCambio 		datetime    	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Concepto		varchar(50)	NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
	Usuario 		varchar(10)   	NULL,
	Autorizacion		varchar(10)	NULL,
	DocFuente		int		NULL,
	Observaciones 		varchar(100) 	NULL,
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

	Condicion		varchar(50)	NULL,
	PeriodoTipo		varchar(20)	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	Percepciones		money		NULL,
	Deducciones		money		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	FechaOrigen		datetime	NULL,
	FechaRegistroNomXD	datetime	NULL,  
	FechaRegistroNomXA	datetime	NULL,  

	RamaID			int		NULL,
	NOI			bit		NOT NULL DEFAULT 0,
	

	CONSTRAINT priNomina PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Nomina'
END
go

EXEC spSincroNivelRegistro @Tabla = 'Nomina'
go

EXEC spALTER_TABLE 'Nomina', 'NOI ', 'bit NULL DEFAULT 0 WITH VALUES' 
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Nomina.Consecutivo
  ALTER TABLE Nomina ALTER COLUMN MovID varchar(20)
  ALTER TABLE Nomina ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Nomina ALTER COLUMN PolizaID varchar(20)
END
GO

-- Nomina
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Nomina (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Nomina (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Nomina (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Nomina (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Nomina (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Nomina (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Nomina.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Nomina.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Nomina.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Nomina.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Nomina.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Nomina (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Nomina (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Nomina (OrigenID,Origen,Empresa)
go


if exists (select * from sysobjects where id = object_id('dbo.tgNominaA') and sysstat & 0xf = 8) drop trigger dbo.tgNominaA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgNominaC') and sysstat & 0xf = 8) drop trigger dbo.tgNominaC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgNominaB') and sysstat & 0xf = 8) drop trigger dbo.tgNominaB
GO
EXEC spModificarPK_Mov 'Nomina'
GO
EXEC spSincroNivelRegistroCampos 'Nomina'
GO
EXEC spALTER_TABLE 'Nomina', 'Percepciones', 'money NULL'
EXEC spALTER_TABLE 'Nomina', 'Deducciones', 'money NULL'
EXEC spALTER_TABLE 'Nomina', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Nomina', 'FechaOrigen', 'datetime NULL'
EXEC spALTER_TABLE 'Nomina', 'FechaRegistroNomXD', 'datetime NULL'
EXEC spALTER_TABLE 'Nomina', 'FechaRegistroNomXA', 'datetime NULL'
EXEC spALTER_TABLE 'Nomina', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Nomina', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Nomina', 'RamaID ', 'int NULL'
GO
EXEC spADD_INDEX 'Nomina', 'Consulta', 'Estatus, Empresa, ID, Mov, Concepto'
EXEC spADD_INDEX 'Nomina', 'CorrespondeLote', 'Mov, Estatus, ID, Concepto, Moneda, Empresa, FechaEmision'
EXEC spADD_INDEX 'Nomina', 'CorrespondeLote2', 'Estatus, Empresa, Mov, Moneda, ID, Concepto, Condicion'
GO

EXEC spFK 'Nomina','UEN','UEN','UEN'
GO

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgNominaC ON Nomina
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
  
  SELECT @Modulo = 'NOM'
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
    UPDATE Nomina SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgNominaB ON Nomina
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
    EXEC spMovAlEliminar 'NOM', @ID
END
GO

/****** NominaD (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'NominaD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NominaD','Movimiento','NOM')
if not exists (select * from sysobjects where id = object_id('dbo.NominaD') and type = 'U') 
CREATE TABLE dbo.NominaD (
	ID 					int       	NOT NULL,
 	Renglon				float	  	NOT NULL,

	Modulo				varchar(5)		NULL DEFAULT 'NOM',
	Plaza				varchar(20)		NULL,
	Personal			varchar(10)		NULL,
	Cuenta				varchar(10)		NULL,
	Importe				money			NULL,
	Horas				varchar(5)		NULL,
	Cantidad			money			NULL,
	Concepto			varchar(50)		NULL,
	Referencia 			varchar(50) 	NULL,
	Beneficiario		varchar(100) 	NULL,
	FormaPago 			varchar(50) 	NULL,
	Porcentaje			float			NULL,
	Monto				money			NULL,
	FechaD				datetime		NULL,
	FechaA				datetime		NULL,
	Movimiento			varchar(20)		NULL,	-- Percepcion, Deduccion, Importe, Cheque, Cheque Electronico
	ContUso				varchar(20)		NULL,
	CuentaContable		varchar(20)		NULL,
	UEN					int				NULL,
	NominaConcepto		varchar(10)		NULL,
	IncidenciaID		int				NULL,
	ObligacionFiscal	varchar(50)		NULL,

	Saldo				money			NULL,
	CantidadPendiente	money			NULL,
	Activo				bit			NOT NULL DEFAULT 1,
	Sucursal			int			NOT NULL DEFAULT 0,

	Logico1				bit			NOT NULL DEFAULT 0,
	Logico2				bit			NOT NULL DEFAULT 0,
	Logico3				bit			NOT NULL DEFAULT 0,
	Logico4				bit			NOT NULL DEFAULT 0,
	Logico5				bit			NOT NULL DEFAULT 0,
	ClavePresupuestal	varchar(50)		NULL, --REQ 13451

	CONSTRAINT priNominaD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO
IF (SELECT version FROM Version)<=2800 AND exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'IDPersonal' AND sysobjects.id = sysindexes.id)
  DROP INDEX NominaD.IDPersonal
IF (SELECT version FROM Version)<=2800 AND exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  DROP INDEX NominaD.Personal
IF (SELECT version FROM Version)<=2800 AND exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'Concepto' AND sysobjects.id = sysindexes.id)
  DROP INDEX NominaD.Concepto
GO
/*if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.NominaD (Personal, Concepto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'Concepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Concepto ON dbo.NominaD (Concepto, Personal)*/
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'IDPersonal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX IDPersonal ON dbo.NominaD (ID, Personal, Concepto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'Personal2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal2 ON dbo.NominaD (ID, Concepto, Personal, Importe, Cantidad)
go

EXEC spModificarPK_Sucursal 'NominaD', '(ID, Renglon)'
EXEC spALTER_TABLE 'NominaD', 'Beneficiario', 'varchar(100) NULL'
EXEC spALTER_TABLE 'NominaD', 'Horas' ,'varchar(5) NULL'
EXEC spALTER_TABLE 'NominaD', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaD', 'CuentaContable', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaD', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'NominaD', 'NominaConcepto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'NominaD', 'IncidenciaID', 'int NULL'
EXEC spALTER_TABLE 'NominaD', 'Plaza', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaD', 'ObligacionFiscal', 'varchar(50) NULL'
GO
EXEC spADD_INDEX 'NominaD', 'Activo2', 'ID, Personal, Activo, FechaD'
EXEC spADD_INDEX 'NominaD', 'CorrespondeLote', 'ID, Personal, Activo, Importe, Saldo, FechaD, CantidadPendiente'
GO
EXEC spALTER_TABLE 'NominaD', 'CuentaContable2', ' varchar(20) null'
GO
EXEC spALTER_TABLE 'NominaD', 'ClavePresupuestal', 'varchar(50) NULL' --REQ 13451
GO
EXEC spFK 'NominaD','Personal','Personal','Personal'
EXEC spFK 'NominaD','Cuenta','CtaDinero','CtaDinero'
EXEC spFK 'NominaD','Cuenta','Prov','Proveedor'
EXEC spFK 'NominaD','Plaza','Plaza','Plaza'
GO

if (select version from version)<=2686
  alter table NominaD alter column Porcentaje float NULL
GO

if exists (select * from sysobjects where id = object_id('dbo.cNominaD') and sysstat & 0xf = 2) drop view dbo.cNominaD
GO
CREATE VIEW cNominaD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Modulo,
  Plaza,
  Personal,
  Cuenta,
  Importe,
  Horas,
  Cantidad,
  Concepto,
  Referencia,
  FormaPago,
  Porcentaje,
  Monto,
  FechaD,
  FechaA,
  Movimiento,
  ContUso,
  CuentaContable,
  CuentaContable2,
  UEN,
  NominaConcepto,
  IncidenciaID,
  ObligacionFiscal,

  Saldo,
  CantidadPendiente,
--  Activo,
  Sucursal,
  SucursalOrigen,

  Logico1,
  Logico2,
  Logico3,
  Logico4,
  Logico5

FROM
  NominaD
GO

if exists (select * from sysobjects where id = object_id('dbo.tgNominaDC') and sysstat & 0xf = 8) drop trigger dbo.tgNominaDC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgNominaDC ON NominaD
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @ID		int,
    @ActivoI	bit,
    @ActivoD	bit

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ActivoI = Activo, @ID = ID FROM Inserted
  SELECT @ActivoD = Activo FROM Deleted
  IF @ActivoI <> @ActivoD
  BEGIN
    IF EXISTS(SELECT * FROM NominaD WHERE ID = @ID AND Activo = 1) 
      UPDATE Nomina SET Estatus = 'VIGENTE' WHERE ID = @ID AND Estatus = 'CONCLUIDO'
    ELSE 
      UPDATE Nomina SET Estatus = 'CONCLUIDO' WHERE ID = @ID AND Estatus NOT IN ('SINAFECTAR', 'CONCLUIDO', 'CANCELADO')
  END
END
GO

/****** NominaPersonal ******/
if not exists (select * from SysTabla where SysTabla = 'NominaPersonal') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NominaPersonal','Movimiento','NOM')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPersonal') and type = 'U') 
CREATE TABLE dbo.NominaPersonal (
	ID 			int       	NOT NULL,
 	Personal		varchar(10) 	NOT NULL,

	SucursalTrabajo		int		NULL,
	CentroCostos		varchar(20)	NULL,
	Actividad		varchar(50)	NULL,
	UEN			int		NULL,
	Sucursal		int		NULL DEFAULT 0,
	Puesto			varchar(50)	NULL,
	FormaPago		varchar(50)	NULL,
	Proyecto		varchar(50)	NULL,
	UltimoPago		datetime	NULL,
	CONSTRAINT priNominaPersonal PRIMARY KEY CLUSTERED (ID, Personal)
)
GO
EXEC spModificarPK_Mov 'NominaPersonal'
GO
EXEC spALTER_TABLE 'NominaPersonal', 'Puesto',           'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'FormaPago',        'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Proyecto',         'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'UltimoPago',       'datetime NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'SueldoDiario',     'money NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'SDIEstaNomina',    'money NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Departamento',     'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Categoria',        'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Grupo',            'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Jornada',          'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'TipoContrato',     'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'TipoSueldo',       'varchar(10) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'RegistroPatronal', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'ZonaEconomica',    'varchar(30) NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'FechaAntiguedad',  'datetime    NULL'
EXEC spALTER_TABLE 'NominaPersonal', 'Estado',           'varchar(30) null'    
GO

/****** NominaPersonalFecha ******/
if not exists (select * from SysTabla where SysTabla = 'NominaPersonalFecha') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NominaPersonalFecha','Movimiento','NOM')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPersonalFecha') and type = 'U') 
CREATE TABLE dbo.NominaPersonalFecha (
	ID 			int       	NOT NULL,
 	Personal		varchar(10) 	NOT NULL,

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,

	CONSTRAINT priNominaPersonalFecha PRIMARY KEY CLUSTERED (ID, Personal)
)
GO
EXEC spModificarPK_Mov 'NominaPersonalFecha'
GO


/****** NominaPersonalProy ******/
if not exists (select * from SysTabla where SysTabla = 'NominaPersonalProy') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('NominaPersonalProy','Movimiento','NOM')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPersonalProy') and type = 'U') 
CREATE TABLE dbo.NominaPersonalProy (
	ID 			int       	NOT NULL,
 	Personal		varchar(10) 	NOT NULL,
	Proyecto		varchar(50)	NOT NULL,
	Sucursal		int		NULL DEFAULT 0,

	CONSTRAINT priNominaPersonalProy PRIMARY KEY CLUSTERED (ID, Personal, Proyecto)
)
GO
EXEC spModificarPK_Mov 'NominaPersonalProy'
GO


/****** NominaLog (Log Cancelacion) ******/
if not exists (select * from SysTabla where SysTabla = 'NominaLog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NominaLog','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaLog') and type = 'U') 
CREATE TABLE dbo.NominaLog (
	Personal		varchar(10)	NOT NULL,
	ID 			int       	NOT NULL,
	DID			int       	NOT NULL,
 	DRenglon		float	  	NOT NULL,

	Importe			money		NULL,
	Cantidad		money		NULL,
	Procesar		bit		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	Referencia		bit		NULL	 DEFAULT 0,

	CONSTRAINT priNominaLog PRIMARY KEY CLUSTERED (Personal, ID, DID, DRenglon)
)
GO
EXEC spModificarPK_SucursalSinOrigen 'NominaLog', '(Personal, ID, DID, DRenglon)'
GO
EXEC spALTER_TABLE 'NominaLog', 'Referencia', 'bit NULL	DEFAULT 0 WITH VALUES'
GO

/****** Nomina Validar Fecha ******/
if not exists (select * from SysTabla where SysTabla = 'NominaValidarFecha') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaValidarFecha', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaValidarFecha') and type = 'U') 
  CREATE TABLE dbo.NominaValidarFecha (
	Mov 		        varchar(20) 	NOT NULL,

	CONSTRAINT priNominaValidarFecha PRIMARY KEY  CLUSTERED (Mov)
  )
GO
IF NOT EXISTS(SELECT * FROM NominaValidarFecha)
BEGIN
  INSERT NominaValidarFecha (Mov) VALUES ('Faltas')
  INSERT NominaValidarFecha (Mov) VALUES ('Incapacidades')
END
GO

/****** Nomina (en Hoja) ******/
if not exists (select * from SysTabla where SysTabla = 'NominaH') 
INSERT INTO SysTabla (SysTabla) VALUES ('NominaH')
if not exists (select * from sysobjects where id = object_id('dbo.NominaH') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaH (
	Estacion		int		NOT NULL,
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	FechaEmision		datetime	NULL,
	Personal		varchar(10)	NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Horas			varchar(5)	NULL,

	CONSTRAINT priNominaH PRIMARY KEY  CLUSTERED (Estacion, ID)
  )
  EXEC spSincroSemilla 'NominaH'
END
GO
EXEC spALTER_TABLE 'NominaH', 'Horas', 'varchar(5) NULL'
EXEC spALTER_TABLE 'NominaH', 'FechaD', 'datetime NULL'
EXEC spALTER_TABLE 'NominaH', 'FechaA', 'datetime NULL'
GO

EXEC spFK 'NominaH','Personal','Personal','Personal'
GO

/************ NominaPremio ************/
if not exists(select * from SysTabla where SysTabla = 'NominaPremio')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaPremio', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPremio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaPremio (
        ID			int		NOT NULL IDENTITY (1,1),

	Nombre			varchar(100)	NULL,
	Nivel			varchar(20)	NULL,	-- Agente/Supervisor
	Estatus			varchar(15)	NULL,
	PersonalGrupo		varchar(50)	NULL,

	Articulo		varchar(20)	NULL,
	Linea			varchar(50)	NULL,
	Meta			money		NULL,
	MetaCantidad		float		NULL,
	MetaPorcentaje		float		NULL,
	TablaImpuestos		varchar(50)	NULL,
	PenalizacionPorcentaje	float		NULL,
	PenalizacionCuota	money		NULL,

	CONSTRAINT priNominaPremio PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NominaPremio'
END
GO
EXEC spALTER_TABLE 'NominaPremio', 'Articulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaPremio', 'Linea', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPremio', 'Meta', 'money NULL'
EXEC spALTER_TABLE 'NominaPremio', 'MetaCantidad', 'float NULL'
EXEC spALTER_TABLE 'NominaPremio', 'MetaPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'NominaPremio', 'TablaImpuestos', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPremio', 'PersonalGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaPremio', 'PenalizacionPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'NominaPremio', 'PenalizacionCuota', 'money NULL'
GO

EXEC spFK 'NominaPremio','Articulo','Art','Articulo'
GO

/************ NominaPremioAgente ************/
if not exists(select * from SysTabla where SysTabla = 'NominaPremioAgente')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaPremioAgente', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPremioAgente') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaPremioAgente (
        ID			int		NOT NULL,
	RenglonID		int		NOT NULL IDENTITY (1,1),

	Articulo		varchar(20)	NULL,
	Linea			varchar(50)	NULL,
	Premio			money		NULL,

	CONSTRAINT priNominaPremioAgente PRIMARY KEY  CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'NominaPremioAgente'
END
GO

EXEC spFK 'NominaPremioAgente','Articulo','Art','Articulo'
GO

/************ NominaPremioSuc ************/
if not exists(select * from SysTabla where SysTabla = 'NominaPremioSuc')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaPremioSuc', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPremioSuc') and type = 'U') 
  CREATE TABLE dbo.NominaPremioSuc (
        ID			int		NOT NULL,
	Sucursal		int		NOT NULL,

	Meta			money		NULL,
	MetaCantidad		float		NULL,

	CONSTRAINT priNominaPremioSuc PRIMARY KEY  CLUSTERED (ID, Sucursal)
  )
GO
EXEC spALTER_TABLE 'NominaPremioSuc', 'MetaCantidad', 'float NULL'
GO

EXEC spFK 'NominaPremioSuc','Sucursal','Sucursal','Sucursal'
GO

/************ NominaPremioSucAlcance ******/
if not exists(select * from SysTabla where SysTabla = 'NominaPremioSucAlcance')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaPremioSucAlcance', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPremioSucAlcance') and type = 'U') 
  CREATE TABLE dbo.NominaPremioSucAlcance (
        ID			int		NOT NULL,
	Sucursal		int		NOT NULL,
	PorcentajeD		float		NOT NULL,
	PorcentajeA		float		NOT NULL,

	Premio			money		NULL,

	CONSTRAINT priNominaPremioSucAlcance PRIMARY KEY  CLUSTERED (ID, Sucursal, PorcentajeD)
  )
GO



/************ NominaBase ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaBase')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaBase', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaBase') and type = 'U') 
  CREATE TABLE dbo.NominaBase (
	Base			varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Comentarios		varchar(255)	NULL,

	CONSTRAINT priNominaBase PRIMARY KEY  CLUSTERED (Base)
  )*/
GO

/************ NominaCondicion ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaCondicion')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaCondicion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaCondicion') and type = 'U') 
  CREATE TABLE dbo.NominaCondicion (
	Condicion		varchar(50)	NOT NULL,

	Tipo			varchar(20)	NULL,
	Cantidad		int		NULL,
	Porcentaje		float		NULL,
	Base			varchar(20)	NULL,

	CONSTRAINT priNominaCondicion PRIMARY KEY  CLUSTERED (Condicion)
  )*/
GO

/************ NominaConceptoGrupo ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaConceptoGrupo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaConceptoGrupo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaConceptoGrupo') and type = 'U') 
  CREATE TABLE dbo.NominaConceptoGrupo (
	Grupo		varchar(50)	NOT NULL,

	CONSTRAINT priNominaConceptoGrupo PRIMARY KEY  CLUSTERED (Grupo)
  )*/
GO


/************ NominaConcepto ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaConcepto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaConcepto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaConcepto') and type = 'U') 
  CREATE TABLE dbo.NominaConcepto (
        Concepto		varchar(50)	NOT NULL,

	Estatus			char(15)	NULL,
	Orden			int		NULL,

	Tipo			varchar(20)	NULL,	-- General/Falta/Prestamo
	Uso			varchar(20)	NULL,	-- Manual/Automatico
	TipoMonto		varchar(20)	NULL,	-- Importe/Cantidad/Porcentaje/Dias/Horas
	TipoFalta		varchar(20)	NULL,	-- Justificada/Injustificada/Incapacidad
	GoceSueldo		bit		NULL	DEFAULT 0,
	Factor			float		NULL	DEFAULT 1,
	Base			varchar(20)	NULL,	
	Grupo			varchar(50)	NULL,	
	Condicion		varchar(50)	NULL,	-- = Personal o <> Personal, = Depto o <> Depto/Especial

	Resultado		varchar(20)	NULL,	-- Percepcion/Deduccion/Estadistica
	TipoDeduccion		varchar(20)	NULL,	-- Personal/Empresa
	TipoRetencion		varchar(20)	NULL,	-- No/Acreedor/Conyuge/Beneficiario
	Acreedor		char(10)	NULL,

	ISR			bit		NULL 	DEFAULT 0,
	ISRPorcentaje		float		NULL,
	ISRExencion		varchar(20)	NULL,
	ISRCantidad		float		NULL,

	IMSS			bit		NULL 	DEFAULT 0,
	IMSSPorcentaje		float		NULL,
	IMSSExencion		varchar(20)	NULL,
	IMSSCantidad		float		NULL,

	Estatal			bit		NULL 	DEFAULT 0,
	EstatalPorcentaje	float		NULL,
	EstatalExencion		varchar(20)	NULL,
	EstatalCantidad		float		NULL,

	CONSTRAINT priNominaConcepto PRIMARY KEY  CLUSTERED (Concepto)
  )*/
GO

/************ NominaIncidencia ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaIncidencia')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaIncidencia', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaIncidencia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaIncidencia (
        ID			int		NOT NULL IDENTITY (1,1),

	Sucursal		int		NULL,
	SucursalOrigen		int		NULL,
	
	Personal		char(10)	NULL,
	FechaEmision		datetime	NULL,
	FechaAplicacion		datetime	NULL,
	Concepto		varchar(50)	NULL,
	Monto			money		NULL,
	Estatus			char(15)	NULL,

	CONSTRAINT priNominaIncidencia PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NominaIncidencia'
END*/
GO

/************ NominaPrestamo ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaPrestamo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaPrestamo', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaPrestamo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaPrestamo (
        ID			int		NOT NULL IDENTITY (1,1),

	Sucursal		int		NULL,
	SucursalOrigen		int		NULL,
	
	Personal		char(10)	NULL,
	FechaEmision		datetime	NULL,
	Condicion		varchar(50)	NULL,
	Concepto		varchar(50)	NULL,
	Importe			money		NULL,
	Saldo			money		NULL,
	Estatus			char(15)	NULL,

	CONSTRAINT priNominaPrestamo PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NominaPrestamo'
END*/
GO


/************ NominaRecibo ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaRecibo')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaRecibo', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaRecibo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaRecibo (
        ID			int		NOT NULL IDENTITY (1,1),

	Sucursal		int		NULL,
	SucursalOrigen		int		NULL,

	Empresa			char(5)		NULL,	
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Personal		char(10)	NULL,
	Estatus			char(15)	NULL,

	CONSTRAINT priNominaRecibo PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NominaRecibo'
END*/
GO



/************ NominaReciboD ******/
/*if not exists(select * from SysTabla where SysTabla = 'NominaReciboD')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaReciboD', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.NominaReciboD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NominaReciboD (
        ID			int		NOT NULL,
	RenglonID		int		NOT NULL IDENTITY (1,1),

	Sucursal		int		NULL,
	SucursalOrigen		int		NULL,
	
	Concepto		varchar(50)	NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,

	Percepcion		money		NULL,
	Deduccion		money		NULL,
	ISR			money		NULL,
	IMSS			money		NULL,
	Estatal			money		NULL,
	Acreedor		varchar(10)	NULL,

	CONSTRAINT priNominaReciboD PRIMARY KEY  CLUSTERED (ID, RenglonID)
  )
  EXEC spSincroSemilla 'NominaReciboD'
END*/
GO


/************ CfgNominaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'CfgNominaConcepto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CfgNominaConcepto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgNominaConcepto') and type = 'U') 
  CREATE TABLE dbo.CfgNominaConcepto (
	ClaveInterna		varchar(50)	NOT NULL,

	Descripcion		varchar(100)	NULL,
	NominaConcepto		varchar(10)	NULL,

	CONSTRAINT priCfgNominaConcepto PRIMARY KEY  CLUSTERED (ClaveInterna)
  )
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CfgNominaConcepto' AND sysindexes.name = 'NominaConcepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX NominaConcepto ON CfgNominaConcepto (NominaConcepto)
GO

if exists (select * from sysobjects where id = object_id('dbo.CfgNominaConceptoMov') and type = 'U') and not exists(select * from syscampo where tabla = 'CfgNominaConceptoMov' and campo = 'Concepto')
  drop table CfgNominaConceptoMov
GO
EXEC spALTER_TABLE 'CfgNominaConcepto', 'Pais',' varchar(30) null'
GO

EXEC spFK 'CfgNominaConcepto','NominaConcepto','NominaConcepto','NominaConcepto'
GO

/************ CfgNominaConceptoMov ******/
if not exists(select * from SysTabla where SysTabla = 'CfgNominaConceptoMov')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CfgNominaConceptoMov', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgNominaConceptoMov') and type = 'U') 
  CREATE TABLE dbo.CfgNominaConceptoMov (
	ClaveInterna		varchar(50)	NOT NULL,
	Mov			varchar(20)	NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	NominaConcepto		varchar(10)	NULL,

	CONSTRAINT priCfgNominaConceptoMov PRIMARY KEY  CLUSTERED (ClaveInterna, Mov, Concepto)
  )
GO

EXEC spFK 'CfgNominaConceptoMov','NominaConcepto','NominaConcepto','NominaConcepto'
GO

/************ NominaSubConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'NominaSubConcepto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaSubConcepto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaSubConcepto') and type = 'U') 
  CREATE TABLE dbo.NominaSubConcepto (
	NominaConcepto		varchar(10)	NOT NULL,
	NominaSubConcepto	varchar(10)	NOT NULL,

	CONSTRAINT priNominaSubConcepto PRIMARY KEY  CLUSTERED (NominaConcepto, NominaSubConcepto)
  )
GO

EXEC spFK 'NominaSubConcepto','NominaSubConcepto','NominaConcepto','NominaConcepto'
GO

/************ NominaConceptoEstado ******/
if not exists(select * from SysTabla where SysTabla = 'NominaConceptoEstado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaConceptoEstado', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaConceptoEstado') and type = 'U') 
  CREATE TABLE dbo.NominaConceptoEstado (
	NominaConcepto		varchar(10)	NOT NULL,
	Estado			varchar(50)	NOT NULL,

	GravaImpuestoEstatal	varchar(50)	NULL	DEFAULT 'No',		-- Si/No

	CONSTRAINT priNominaConceptoEstado PRIMARY KEY  CLUSTERED (NominaConcepto, Estado)
  )
GO

/************ NominaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'NominaConcepto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('NominaConcepto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NominaConcepto') and type = 'U') 
  CREATE TABLE dbo.NominaConcepto (
	NominaConcepto		varchar(10)	NOT NULL,

	Concepto		varchar(50)	NULL,
	Movimiento		varchar(20)	NULL,		-- Percepcion/Deduccion/Estadistica

	CantidadBase		varchar(50)	NULL	DEFAULT 'Especifica',		-- Especifica/Propiedad/Dias Periodo
	CantidadPropiedad	varchar(50)	NULL,
	CantidadEditar		bit		NULL	DEFAULT 1,
	CantidadDef		float		NULL	DEFAULT 1,
	CantidadEsPorcentaje	bit		NULL	DEFAULT 0,

	PorcentajeBase		varchar(50)	NULL	DEFAULT 'N/A',			-- Especifico/Fijo/Propiedad/Factor Ausentismo
	PorcentajePropiedad	varchar(50)	NULL,
	PorcentajeEditar	bit		NULL	DEFAULT 0,
	PorcentajeDef		float		NULL	DEFAULT 100,

	ValorBase		varchar(50)	NULL	DEFAULT 'Especifico',		-- Especifico/Propiedad/Sueldo Diario/SDI/Sueldo Periodo/Sueldo Mensual/Sueldo Anual/Sueldo Hora/Salario Minimo Zona/Salario Minimo DF/Percepcion Neta/Percepcion Bruta
	ValorPropiedad		varchar(50)	NULL,
	ValorEditar		bit		NULL	DEFAULT 1,
	ValorDef		money		NULL,

	CantidadTopeBase	varchar(50)	NULL	DEFAULT 'N/A',			-- Especifico/Propiedad/Semanas Periodo
	CantidadTopePropiedad	varchar(50)	NULL,
	CantidadTopeEditar	bit		NULL	DEFAULT 0,
	CantidadTopeDef		float		NULL,

	ImporteTopeBase		varchar(50)	NULL	DEFAULT 'N/A',			-- Especifico/Propiedad
	ImporteTopePropiedad	varchar(50)	NULL,
	ImporteTopeEditar	bit		NULL	DEFAULT 0,
	ImporteTopeDef		float		NULL,

	AcreedorBase		varchar(20)	NULL	DEFAULT 'N/A',			-- Especifico/Fijo/Propiedad
	AcreedorPropiedad	varchar(50)	NULL,
	AcreedorEditar		bit		NULL	DEFAULT 0,
	AcreedorDef		varchar(10)	NULL,

	VencimientoBase		varchar(50)	NULL	DEFAULT 'N/A',			-- Especifico/Fecha Emision Incidencia/Fecha Aplicacion Incidencia/Fecha Emision Nomina/Fecha De Nomina/Fecha A Nomina/Dia Especifico
	VencimientoDia		int		NULL,
	VencimientoMes		varchar(50)	NULL,		-- Mes Emision Nomina/Siguiente Mes/Siguiente Bimestre
	VencimientoEditar	bit		NULL	DEFAULT 0,

	GravaISR		varchar(50)	NULL	DEFAULT 'No',		-- Si/No/Horas Extras Dobles/Prima Dominical/Prima Vacacional
	GravaIMSS		varchar(50)	NULL	DEFAULT 'No',		-- Si/No/Premio Puntualidad/Premio Asistencia/Vales Despensa
	GravaImpuestoEstatal	varchar(50)	NULL	DEFAULT 'No',		-- Si/No
	GravaCedular		varchar(50)	NULL	DEFAULT 'No',		-- Si/No/por Estado

	Modulo			varchar(5)		NULL,		-- NOM/CXP/CXC/GAS
	ModuloMov		varchar(20)	NULL,
	Especial		varchar(50)	NULL,		-- Horas Extras/Faltas/Incapacidades
	TieneSubConceptos	bit		NULL	DEFAULT 0,

	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',
	CuentaBase		varchar(50)	NULL	DEFAULT 'N/A',		-- Especifica/Personal/etc.
	CuentaGrupo		varchar(20)     NULL,
	Cuenta			varchar(20)     NULL,
	Cuenta2			varchar(20)     NULL,
	RequiereDiasTrabajados	bit		NULL	DEFAULT 0,
	SueldoVariable		bit		NULL	DEFAULT 0,
	GenerarEstadisticaCxp	bit		NULL	DEFAULT 0,

        NivelAcceso		varchar(50)	NULL,
	MovEspecificoNomina	varchar(20)	NULL,
	Sysmeca			varchar(30) 	NULL,
	GravaPrimaAntiguedad 	varchar(50)	NULL,
	GravaIndemnizacion	varchar(50)	NULL,
	AplicaPreelaborada	varchar(50)	NULL,
	GravaSeguroEducativo	varchar(50)	NULL,
	GravaVacaciones		varchar(50)	NULL,
	SituacionCambio		varchar(50) 	NULL,
	Pais			varchar(30)	NULL,
	ObligacionFiscal	varchar(50) 	NULL,
	Tasa			float		NULL,
	ConceptoNOI	        bit		NULL	DEFAULT 0,
	ConceptoNOIValidado	bit		NULL	DEFAULT 0,

	CONSTRAINT priNominaConcepto PRIMARY KEY  CLUSTERED (NominaConcepto)
  )
GO
EXEC spALTER_TABLE 'NominaConcepto', 'Cuenta', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'RequiereDiasTrabajados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'SueldoVariable', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'CuentaBase', 'varchar(50)	NULL DEFAULT "N/A" WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'CuentaGrupo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'Cuenta2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'ModuloMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'GenerarEstadisticaCxp', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'MovEspecificoNomina', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Nominaconcepto', 'Sysmeca','varchar(30) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'GravaPrimaAntiguedad ','varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'GravaIndemnizacion',   'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'AplicaPreelaborada',   'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'GravaSeguroEducativo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'GravaVacaciones',      'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'SituacionCambio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'Pais','varchar(30) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'ObligacionFiscal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'Tasa', 'float NULL'
EXEC spALTER_TABLE 'NominaConcepto', 'ConceptoNOI', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'ConceptoNOIValidado', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--DSG
EXEC spALTER_TABLE 'NominaConcepto', 'NomXID', 'INT NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaConcepto' AND sysindexes.name = 'Concepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Concepto ON NominaConcepto (Concepto)
GO
EXEC spALTER_TABLE 'NominaConcepto', 'TipoDescuentoPanama', ' varchar(30) null'
EXEC spALTER_TABLE 'NominaConcepto', 'CuentaBase2', ' varchar(50) null'
EXEC spALTER_TABLE 'NominaConcepto', 'GenerarEstadisticaGas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NominaConcepto', 'CuentaGrupo2', ' varchar(20) null'
GO

EXEC spFK 'NominaConcepto','Cuenta','Cta','Cuenta'
GO

/************ IncidenciaAuto ******/
/*if not exists(select * from SysTabla where SysTabla = 'IncidenciaAuto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IncidenciaAuto', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IncidenciaAuto') and type = 'U') 
  CREATE TABLE dbo.IncidenciaAuto (
	Empresa			char(5)		NOT NULL,
	Rama			char(5)		NOT NULL,
	Cuenta			varchar(20)	NOT NULL,
	NominaConcepto		varchar(10)	NOT NULL,	

	Referencia		varchar(50)	NULL,
	Cantidad		float		NULL,
	Valor			float		NULL,
	Porcentaje		float		NULL,

	Moneda			char(10)	NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	Frecuencia		varchar(20)	NULL,	-- Cada Nomina/Inicio Mes/Fin Mes
	ConVigencia		bit		NULL	DEFAULT 0,
	VigenciaDesde		datetime	NULL,
	VigenciaHasta		datetime	NULL,	

	CONSTRAINT priIncidenciaAuto PRIMARY KEY  CLUSTERED (Cuenta, NominaConcepto, Rama, Empresa)
  )*/
GO


IF NOT EXISTS(SELECT * FROM sysobjects WHERE Name='TipoLiquidacionPanama' AND type='U')
BEGIN
  CREATE TABLE TipoLiquidacionPanama (
      LiquidacionPanama varchar (50) NOT NULL,
      ContratoTipo      varchar (50) NOT NULL,
      PrimaAntiguedad   bit          NOT NULL,
      Indemnizacion     bit          NOT NULL
  )
END

GO
IF NOT EXISTS(SELECT * FROM sysobjects WHERE Name='TipoLiquidacionNominaPanama' AND type='U')
BEGIN
  CREATE TABLE TipoLiquidacionNominaPanama (
      LiquidacionPanama varchar (50) NOT NULL,
      Personal          varchar (10) NOT NULL,
      NominaID          int          NOT NULL
  )
END
GO


IF NOT EXISTS (SELECT name FROM sysobjects  WHERE name = 'OPCIONESLIQUIDACIONPANAMA') 
  CREATE TABLE OPCIONESLIQUIDACIONPANAMA(
    Preaviso                    bit,
    PAdicionalIndemni           bit,
    SinAvisar                   bit,
    LiquidacionPanama varchar (50) not NULL
--,
--    PorcentajePAdicionalIndemni money
)
GO
EXEC spALTER_TABLE 'OPCIONESLIQUIDACIONPANAMA',      'Compromisos',       ' varchar (50)'
EXEC spALTER_TABLE 'OPCIONESLIQUIDACIONPANAMA',      'SinAvisar',       ' bit'
GO

/************ MovEspecificoNomina ******/
if not exists (select * from SysTabla where SysTabla = 'MovEspecificoNomina') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovEspecificoNomina', 'Maestro')
IF NOT EXISTS(select * from sysobjects where id = object_id('dbo.MovEspecificoNomina ') and type = 'U')  
CREATE TABLE MovEspecificoNomina 
( 
  MovEspecificoNomina  varchar(20) COLLATE Database_Default,
  NominaConcepto       varchar(10) COLLATE Database_Default,
CONSTRAINT PK_MovEspecificoNomina  PRIMARY KEY  CLUSTERED (MovEspecificoNomina,NominaConcepto)
)
GO
/************ NominaImportar ******/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE ID = object_id('dbo.NominaImportar') AND Type = 'U')
  CREATE TABLE NominaImportar(ID             int, 
                              Renglon        float, 
                              Usuario        varchar(10), 
                              Personal       varchar(10), 
                              Cantidad       float, 
                              Importe        money, 
                              NominaConcepto varchar(10), 
                              Concepto       varchar(50),
                              Movimiento     varchar(20),  
                              Estatus        varchar(15), 
                 CONSTRAINT PK_NominaImportar  PRIMARY KEY  CLUSTERED (ID, Usuario, Personal, NominaConcepto) 
)
GO

EXEC spFK 'NominaImportar','ID','Nomina','ID'
EXEC spFK 'NominaImportar','Personal','Personal','Personal'
EXEC spFK 'NominaImportar','NominaConcepto','NominaConcepto','NominaConcepto'
EXEC spFK 'NominaImportar','Personal','PersonalA','Personal'
GO

/************ ImpuestoEstatalGastoOperacion ******/
if not exists (select * from SysTabla where SysTabla = 'ImpuestoEstatalGastoOperacion') 
INSERT INTO SysTabla (SysTabla, Tipo, Modulo) VALUES ('ImpuestoEstatalGastoOperacion', 'Movimiento','NOM')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE ID = object_id('dbo.ImpuestoEstatalGastoOperacion') AND Type = 'U')
CREATE TABLE ImpuestoEstatalGastoOperacion(
	ID int NULL,
	sucursal int NULL,
	GastoOperacion money NULL
) ON [PRIMARY]
GO


/************ NominaCorrespondeLote ******/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE ID = object_id('dbo.NominaCorrespondeLote') AND Type = 'U')
CREATE TABLE NominaCorrespondeLote (
  IDNomina  int NOT NULL,
  ID		int NOT NULL, 
  Comando	char(10)	COLLATE Database_Default NULL, 
  Mov		varchar(20) COLLATE Database_Default NULL, 
  Concepto	varchar(50) COLLATE Database_Default NULL, 
  Monto		float		NULL,
  CONSTRAINT pkNominaCorrespondeLote  PRIMARY KEY  CLUSTERED (IDNomina, ID)
)
GO

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'pkNominaCorrespondeLote')
  EXEC spEliminarPK 'NominaCorrespondeLote'
GO
--BUG22055
EXEC spALTER_TABLE 'NominaCorrespondeLote', 'Personal', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'NominaCorrespondeLote', 'DRenglon', 'float NULL'
GO
EXEC spADD_INDEX 'NominaCorrespondeLote', 'PersonalID','Personal, ID, IDNomina'
GO
EXEC spALTER_TABLE 'NominaCorrespondeLote', 'Utilizado', 'bit NULL'
GO



/************ Optimización DIM ******/
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'ConceptoPersonal' AND sysobjects.id = sysindexes.id)
  CREATE NONCLUSTERED INDEX ConceptoPersonal ON NominaD(Concepto,ID,Personal)INCLUDE(Importe)
GO
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'NominaD' AND sysindexes.name = 'NominaConceptoPersonal' AND sysobjects.id = sysindexes.id)
  CREATE NONCLUSTERED INDEX NominaConceptoPersonal ON NominaD(NominaConcepto,ID,Personal)INCLUDE(Importe)
GO
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Nomina' AND sysindexes.name = 'EstatusFechaA' AND sysobjects.id = sysindexes.id)
  CREATE NONCLUSTERED INDEX EstatusFechaA ON Nomina(Empresa,Mov,Estatus,FechaA)INCLUDE(ID)
GO
/******************************* DimCfg *************************************************/
IF NOT EXISTS (SELECT * FROM Sys.Tables WHERE name='DimCfg') 
BEGIN
  IF NOT EXISTS (select * from SysTabla where SysTabla = 'DimCfg') 
    INSERT INTO SysTabla (SysTabla, Tipo,Modulo) VALUES ('DimCfg', 'Cuenta','NOM')
  
  CREATE TABLE dbo.DimCfg (
		ID              int	NOT	NULL   IDENTITY(1,1),
		Empresa         VARCHAR(5)     COLLATE database_DEFAULT		NULL,
		Columna         int										NOT	NULL,
		Titulo			VARCHAR(90)    COLLATE database_DEFAULT		NULL,
		Descripcion		VARCHAR(300)   COLLATE database_DEFAULT		NULL,
		Tipo			VARCHAR (20)   COLLATE database_DEFAULT		NULL,
		Obligatorio		bit            DEFAULT 0					NULL,
		Campo			VARCHAR(100)   COLLATE database_DEFAULT DEFAULT '' NULL,
		CONSTRAINT PkDimCfg PRIMARY KEY  CLUSTERED (ID))
END
GO
/******************************* DimCfgD *************************************************/
IF NOT EXISTS (SELECT * FROM Sys.Tables WHERE name='DimCfgD') 
BEGIN
  IF NOT EXISTS (select * from SysTabla where SysTabla = 'DimCfg') 
    INSERT INTO SysTabla (SysTabla, Tipo,Modulo) VALUES ('DimCfgD', 'Cuenta','NOM')
    
	CREATE TABLE dbo.DimCfgD(
		 ID             int										NOT	NULL,
		 Renglon		int										NOT	NULL,
		 NominaConcepto VARCHAR(50) COLLATE database_DEFAULT		NULL,
		 Concepto       VARCHAR(50) COLLATE database_DEFAULT		NULL,
		 CONSTRAINT PkDimCfgD PRIMARY KEY  CLUSTERED (ID,Renglon))
END
GO
EXEC spALTER_TABLE 'DimCfgD', 'Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'DimCfgD', 'MovConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'DimCfgD', 'Cantidad', 'money NULL'
GO
/******************************* DimPaso *************************************************/
IF NOT EXISTS (SELECT * FROM Sys.Tables WHERE name='DimPaso')
BEGIN
  IF NOT EXISTS (select * from SysTabla where SysTabla = 'DimPaso') 
    INSERT INTO SysTabla (SysTabla, Tipo,Modulo) VALUES ('DimPaso', 'N/A','NOM')
    
	CREATE TABLE dbo.DimPaso
	(
	id int,
	Estacion int NULL,
	Personal VARCHAR(30) COLLATE database_DEFAULT  NULL,
	Dim1 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim2 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim3 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim4 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim5 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim6 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim7 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim8 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim9 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim10 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim11 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim12 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim13 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim14 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim15 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim16 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim17 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim18 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim19 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim20 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim21 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim22 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim23 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim24 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim25 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim26 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim27 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim28 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim29 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim30 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim31 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim32 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim33 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim34 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim35 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim36 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim37 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim38 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim39 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim40 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim41 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim42 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim43 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim44 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim45 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim46 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim47 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim48 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim49 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim50 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim51 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim52 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim53 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim54 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim55 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim56 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim57 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim58 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim59 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim60 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim61 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim62 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim63 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim64 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim65 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim66 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim67 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim68 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim69 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim70 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim71 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim72 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim73 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim74 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim75 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim76 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim77 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim78 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim79 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim80 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim81 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim82 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim83 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim84 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim85 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim86 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim87 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim88 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim89 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim90 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim91 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim92 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim93 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim94 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim95 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim96 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim97 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim98 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim99 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim100 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim101 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim102 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim103 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim104 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim105 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim106 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim107 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim108 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim109 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim110 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim111 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim112 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim113 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim114 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim115 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim116 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim117 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim118 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim119 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim120 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim121 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim122 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim123 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim124 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim125 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim126 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim127 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim128 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim129 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim130 	VARCHAR(50)	COLLATE database_DEFAULT  NULL , 
	Dim131 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim132 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim133 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim134 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim135 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim136 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim137 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim138 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim139 	VARCHAR(50)	COLLATE database_DEFAULT  NULL ,
	Dim140 	VARCHAR(50)	COLLATE database_DEFAULT  NULL
	)
END
GO 
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'DimPaso' AND sysindexes.name = 'PersonalEstacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX PersonalEstacion ON DimPaso (Personal,Estacion)
GO
IF NOT EXISTS (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'DimPaso' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE CLUSTERED INDEX Personal ON DimPaso(Personal)
GO
/******************************* DimPasoPipe *************************************************/
IF NOT EXISTS (SELECT * FROM Sys.Tables WHERE name='DimPasoPipe')
BEGIN 
  IF NOT EXISTS (select * from SysTabla where SysTabla = 'DimPasoPipe') 
    INSERT INTO SysTabla (SysTabla, Tipo,Modulo) VALUES ('DimPasoPipe', 'N/A','NOM')
    
	CREATE TABLE dbo.DimPasoPipe 
	(
	Estacion int,
	Cadena01 text COLLATE database_DEFAULT NULL,
	Cadena02 text COLLATE database_DEFAULT NULL
	)
END
GO  
/******************************* ListaConcepto *************************************************/
IF NOT EXISTS (SELECT * FROM Sys.Tables WHERE name='DimListaConcepto') 
BEGIN
  IF NOT EXISTS (select * from SysTabla where SysTabla = 'DimListaConcepto') 
    INSERT INTO SysTabla (SysTabla, Tipo,Modulo) VALUES ('DimListaConcepto', 'N/A','NOM')
    
	CREATE TABLE dbo.DimListaConcepto 
	(
		ID             int IDENTITY (1,1),
		NominaConcepto VARCHAR(50) COLLATE database_DEFAULT NULL,
		Concepto       VARCHAR(50) COLLATE database_DEFAULT NULL,
		Empresa        VARCHAR(5)  COLLATE database_DEFAULT NULL
	)
END
GO
/******************************* dbo.AuxAsistenciaHE *************************************************/
IF NOT EXISTS (SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('dbo.AuxAsistenciaHE') and type = 'U') 
CREATE TABLE dbo.AuxAsistenciaHE (
							      Personal        varchar(10) NOT NULL,
								  Empresa         varchar(05) NOT NULL,
								  FechaD	      datetime    NULL,
								  FechaA	      datetime    NULL,
								  Generar         bit         NULL DEFAULT 1,								  
								  Semana1Dia1     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia2     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia3     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia4     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia5     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia6     varchar(5)  NULL DEFAULT 0,
								  Semana1Dia7     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia1     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia2     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia3     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia4     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia5     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia6     varchar(5)  NULL DEFAULT 0,
								  Semana2Dia7     varchar(5)  NULL DEFAULT 0,
								  Estatus         varchar(15) NULL DEFAULT 'SINAFECTAR',
								  CONSTRAINT priAuxAsistenciaHE PRIMARY KEY  CLUSTERED (Personal, Empresa)
							)
GO

EXEC spALTER_Table 'AuxAsistenciaHE', 'Estatus', 'varchar(15) NULL DEFAULT ''SINAFECTAR'''
DELETE FROM AuxAsistenciaHE
EXEC spALTER_Table 'AuxAsistenciaHE', 'ID', 'int NOT NULL'
EXEC spALTER_PK 'AuxAsistenciaHE', 'Empresa, ID, Personal'
GO

/*********************** NominaProrrateo **************************/
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.NominaProrrateo') and type = 'U') --DROP TABLE NominaProrrateo
CREATE TABLE NominaProrrateo (
       Prorrateo            varchar(50)     NOT NULL,
)
GO

/*********************** NominaProrrateoD **************************/
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.NominaProrrateoD') and type = 'U') --DROP TABLE NominaProrrateoD
CREATE TABLE NominaProrrateoD (
        Prorrateo           varchar(50)     NOT NULL,
        Empresa             varchar(5)      NOT NULL,
        CentroCostos        varchar(20)     NOT NULL,
        Sucursal            int             NOT NULL,
        Porcentaje          float           NULL,
)
GO

/*********************** NominaProrrateoConcepto **************************/
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.NominaProrrateoConcepto') and type = 'U') --DROP TABLE NominaProrrateoConcepto
CREATE TABLE NominaProrrateoConcepto (
       ConceptoGasto        varchar(50)     NOT NULL,
       Proveedor            varchar(20)     NULL
)
GO

/*********************** NominaProrrateoConceptoD **************************/
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.NominaProrrateoConceptoD') and type = 'U') --DROP TABLE NominaProrrateoConceptoD
CREATE TABLE NominaProrrateoConceptoD (
        ConceptoGasto       varchar(50)     NOT NULL,
        Concepto            varchar(50)     NOT NULL
)
GO

/******************** NominaProrrateoLog ************************/
IF NOT EXISTS (select * from sysobjects where id = object_id('dbo.NominaProrrateoLog') and type = 'U') --DROP TABLE NominaProrrateoLog
CREATE TABLE NominaProrrateoLog (
        ID                  int             NOT NULL,
        Concepto            varchar(50)     NULL,
        Personal            varchar(20)     NULL,
        Nombre              varchar(255)    NULL,
        Empresa             varchar(5)      NULL,
        Sucursal            int             NULL,
        CentroCostos        varchar(50)     NULL,
        Porcentaje          float           NULL,
        Importe             money           NULL,
        Proveedor           varchar(20)     NULL,
)
GO

/******************** NomTabCfg ************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'NomTabCfg' AND type ='U')  
CREATE TABLE NomTabCfg(  
	ID				INT IDENTITY(1,1),
    Concepto        VARCHAR(50) COLLATE DataBase_Default  NOT NULL,
    Tipo            VARCHAR(20) COLLATE DataBase_Default  NOT NULL,
    Columna         INT NULL
    CONSTRAINT PK_NomTabCfg PRIMARY KEY  CLUSTERED (ID)
)			
GO

/******************** NomTabFirmas ************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'NomTabFirmas' AND type ='U') 
CREATE TABLE NomTabFirmas (  
	ID				INT IDENTITY(1,1),
    ElaNombre       VARCHAR(100) COLLATE DataBase_Default  NOT NULL,
	ElaPuesto       VARCHAR(50)	 COLLATE DataBase_Default  NOT NULL,
    AutNombre       VARCHAR(100) COLLATE DataBase_Default  NOT NULL,
	AutPuesto       VARCHAR(50)  COLLATE DataBase_Default  NOT NULL,
    CONSTRAINT PK_NomTabFirmas PRIMARY KEY  CLUSTERED (ID)
)			
GO

/******************** NomTabPipe ************************/
IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'NomTabPipe' AND type ='U') 
CREATE TABLE NomTabPipe(  
	Estacion INT,
	Cadena01 TEXT COLLATE DataBase_Default  NULL,
	Cadena02 TEXT COLLATE DataBase_Default  NULL
)
GO

/******************** NomTabArchivo ************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.NomTabArchivo') and type = 'U') 
CREATE TABLE NomTabArchivo( 
	Empresa       VARCHAR(5) NULL,
    RutaArchivo   VARCHAR(255) NULL,
    RutaRespaldo  VARCHAR(255) NULL,
    NombreArchivo VARCHAR(50) NULL,
    BaseDatos     VARCHAR(100) NULL
)
GO

/************ NominaCorrespondeLoteFA ******/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE ID = object_id('dbo.NominaCorrespondeLoteFA') AND Type = 'U')

CREATE TABLE NominaCorrespondeLoteFA (
  ID            int	NOT	NULL   IDENTITY(1,1),
  IDNomina      int NOT NULL,
  FormulaAcum	varchar(100) NOT NULL,       
  Personal      varchar(10) NOT NULL,
  Mov		    varchar(20) COLLATE Database_Default NULL, 
  Concepto	    varchar(50) COLLATE Database_Default NULL, 
  Comando	    varchar(15), 
  Monto		    float NULL,
  Cantidad      float NULL,
  Utilizado     bit NULL  default 0
  CONSTRAINT pkNominaCorrespondeLoteFA  PRIMARY KEY CLUSTERED(ID, IDNomina, FormulaAcum, Personal)
)
GO

EXEC spALTER_Table 'NominaCorrespondeLoteFA', 'Exp', 'varchar(250) NULL'
GO
