
/*******************************************************************************************/
/*                                         ISL                      	           */
/*******************************************************************************************/

/****** Consecutivos ISL ******/
if not exists(select * from SysTabla where SysTabla = 'ISLC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ISLC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ISLC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ISLC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priISLC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ISLC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ISLC', '(ID)'
GO

-- drop table ISL
/****** ISL (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'ISL')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ISL','Movimiento','ISL')
if not exists (select * from sysobjects where id = object_id('dbo.ISL') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ISL (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
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
	Estatus 		char(15)   	NULL,
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
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,

	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	
	-- Aqui van los campos del modulo

	CONSTRAINT priISL PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ISL'
END
go
EXEC spSincroNivelRegistro @Tabla = 'ISL'
go
EXEC spADD_INDEX 'ISL', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'ISL', 'Consecutivo', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'ISL', 'FechaEmision', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'ISL', 'Abrir', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'ISL', 'Situacion', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'ISL', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'ISL', 'ContID', 'ContID'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgISLA') and sysstat & 0xf = 8) drop trigger dbo.tgISLA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgISLC') and sysstat & 0xf = 8) drop trigger dbo.tgISLC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgISLB') and sysstat & 0xf = 8) drop trigger dbo.tgISLB
GO
EXEC spModificarPK_Mov 'ISL'
GO
EXEC spSincroNivelRegistroCampos 'ISL'
GO
EXEC spALTER_TABLE 'ISL', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'ISL', 'Mantenimiento', 'datetime NULL'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ISL' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON ISL (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ISL' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON ISL (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ISL' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON ISL (OrigenID,Origen,Empresa)
go

-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgISLC ON ISL
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
  
  SELECT @Modulo = 'ISL'
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
    UPDATE ISL SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgISLB ON ISL
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
    EXEC spMovAlEliminar 'ISL', @ID
END
GO

/****** ISLD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ISLD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ISLD','Movimiento','ISL')
if not exists (select * from sysobjects where id = object_id('dbo.ISLD') and type = 'U') 
CREATE TABLE dbo.ISLD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Licencia		varchar(50)	NULL,
	Vencimiento		datetime	NULL,
	VencimientoA		datetime	NULL,
	Mantenimiento		datetime	NULL,
	MantenimientoA		datetime	NULL,
	Licenciamiento		varchar(50)	NULL,
	Cantidad		int		NULL,
	CantidadA		int		NULL,

	CONSTRAINT priISLD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'ISLD', '(ID, Renglon)'
GO
EXEC spALTER_TABLE 'ISLD', 'VencimientoA', 'datetime NULL'
EXEC spALTER_TABLE 'ISLD', 'MantenimientoA', 'datetime NULL'
EXEC spALTER_TABLE 'ISLD', 'CantidadA', 'int NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.cISLD') and sysstat & 0xf = 2) drop view dbo.cISLD
GO
CREATE VIEW cISLD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Sucursal,
  SucursalOrigen,

  Licencia,
  Vencimiento,
  Mantenimiento,
  Licenciamiento,
  Cantidad

FROM
  ISLD
GO

