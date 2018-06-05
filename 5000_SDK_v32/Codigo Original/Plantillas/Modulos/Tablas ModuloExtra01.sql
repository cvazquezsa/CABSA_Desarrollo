
/*******************************************************************************************/
/*                                         ModuloExtra01                      	           */
/*******************************************************************************************/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/****** Consecutivos ModuloExtra01 ******/
if not exists(select * from SysTabla where SysTabla = 'ModuloExtra01C')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ModuloExtra01C', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ModuloExtra01C') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ModuloExtra01C (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priModuloExtra01C PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ModuloExtra01C'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'ModuloExtra01C', '(ID)'
GO

-- drop table ModuloExtra01
/****** ModuloExtra01 (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'ModuloExtra01')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ModuloExtra01','Movimiento','MEX01')
if not exists (select * from sysobjects where id = object_id('dbo.ModuloExtra01') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ModuloExtra01 (
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
	
	-- Aqui van los campos del modulo

	CONSTRAINT priModuloExtra01 PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ModuloExtra01'
END
go
EXEC spSincroNivelRegistro @Tabla = 'ModuloExtra01'
go
EXEC spADD_INDEX 'ModuloExtra01', 'Referencia', 'Referencia'
EXEC spADD_INDEX 'ModuloExtra01', 'Consecutivo', 'MovID, Mov, Estatus, Sucursal, Empresa'
EXEC spADD_INDEX 'ModuloExtra01', 'FechaEmision', 'FechaEmision, Estatus, Empresa'
EXEC spADD_INDEX 'ModuloExtra01', 'Abrir', 'Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion'
EXEC spADD_INDEX 'ModuloExtra01', 'Situacion', 'Estatus, Situacion, Empresa'
EXEC spADD_INDEX 'ModuloExtra01', 'Usuario', 'Usuario'
EXEC spADD_INDEX 'ModuloExtra01', 'ContID', 'ContID'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgModuloExtra01A') and sysstat & 0xf = 8) drop trigger dbo.tgModuloExtra01A
GO
if exists (select * from sysobjects where id = object_id('dbo.tgModuloExtra01C') and sysstat & 0xf = 8) drop trigger dbo.tgModuloExtra01C
GO
if exists (select * from sysobjects where id = object_id('dbo.tgModuloExtra01B') and sysstat & 0xf = 8) drop trigger dbo.tgModuloExtra01B
GO
EXEC spModificarPK_Mov 'ModuloExtra01'
GO
EXEC spSincroNivelRegistroCampos 'ModuloExtra01'
GO
-- Aqui va el Matenimiento a la tabla

GO
CREATE TRIGGER tgModuloExtra01C ON ModuloExtra01
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
    @Mensaje		char(255)

  SELECT @Modulo = 'MEX01'
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

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,  FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, @Usuario, @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior

  -- Para que cancele la poliza cuando Maneja SincroContabilidadMatriz
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE ModuloExtra01 SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgModuloExtra01B ON ModuloExtra01
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	char(15),
    @Mensaje	char(255)

  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'MEX01', @ID
END
GO

/****** ModuloExtra01D (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'ModuloExtra01D')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ModuloExtra01D','Movimiento','MEX01')
if not exists (select * from sysobjects where id = object_id('dbo.ModuloExtra01D') and type = 'U') 
CREATE TABLE dbo.ModuloExtra01D (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Articulo		varchar(20)	NULL,
	Cantidad		int		NULL,
	Precio			money		NULL,

	CONSTRAINT priModuloExtra01D PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'ModuloExtra01D', '(ID, Renglon)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cModuloExtra01D') and sysstat & 0xf = 2) drop view dbo.cModuloExtra01D
GO
CREATE VIEW cModuloExtra01D
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  Sucursal,
  SucursalOrigen,

  Articulo,
  Cantidad,
  Precio

FROM
  ModuloExtra01D
GO

