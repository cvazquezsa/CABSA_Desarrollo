
/*******************************************************************************************/
/*                                         Capital                           	           */
/*******************************************************************************************/

/****** Consecutivos Capital ******/
if not exists(select * from SysTabla where SysTabla = 'CapitalC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CapitalC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CapitalC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CapitalC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCapitalC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CapitalC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CapitalC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CapitalC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE CapitalC ALTER COLUMN Mov     char(20) NULL")
END
GO

-- drop table capital
/****** Capital (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'Capital')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Capital','Movimiento','CAP')
if not exists (select * from sysobjects where id = object_id('dbo.Capital') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Capital (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
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
	Agente			char(10)	NULL,
	Moneda			char(10)	NULL,
	TipoCambio		float		NULL,

	CONSTRAINT priCapital PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Capital'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Capital'
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.Capital (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Capital (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Capital (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Capital (Mov, Estatus, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Capital (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Capital (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Capital (ContID)
GO

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Capital.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Capital.Situacion2
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Capital (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Capital (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Capital' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Capital (OrigenID,Origen,Empresa)
go


if exists (select * from sysobjects where id = object_id('dbo.tgCapitalA') and sysstat & 0xf = 8) drop trigger dbo.tgCapitalA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCapitalC') and sysstat & 0xf = 8) drop trigger dbo.tgCapitalC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCapitalB') and sysstat & 0xf = 8) drop trigger dbo.tgCapitalB
GO
EXEC spModificarPK_Mov 'Capital'
GO
EXEC spSincroNivelRegistroCampos 'Capital'
GO
EXEC spALTER_TABLE 'Capital', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Capital', 'SituacionNota', 'varchar(100) NULL'
GO
-- Aqui va el Matenimiento a la tabla

EXEC spFK 'Capital','UEN','UEN','UEN'
EXEC spFK 'Capital','Proyecto','Proy','Proyecto'
EXEC spFK 'Capital','Moneda','Mon','Moneda'
GO

GO
CREATE TRIGGER tgCapitalC ON Capital
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
  
  SELECT @Modulo = 'CAP'
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
    UPDATE Capital SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgCapitalB ON Capital
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
    EXEC spMovAlEliminar 'CAP', @ID
END
GO

/****** CapitalD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CapitalD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CapitalD','Movimiento','CAP')
if not exists (select * from sysobjects where id = object_id('dbo.CapitalD') and type = 'U') 
CREATE TABLE dbo.CapitalD (
	ID 			int       	NOT NULL,
	Renglon			float		NOT NULL,

	Socio			char(10)	NULL,
	Titulo			varchar(20)	NULL,
	Cantidad		int		NULL,
	Precio			money		NULL,
	Costo			money		NULL,

	CONSTRAINT priCapitalD PRIMARY KEY CLUSTERED (ID, Renglon)
)
go
EXEC spModificarPK_Sucursal 'CapitalD', '(ID, Renglon)'
GO

EXEC spFK 'CapitalD','ID','Capital','ID'
GO

if exists (select * from sysobjects where id = object_id('dbo.cCapitalD') and sysstat & 0xf = 2) drop view dbo.cCapitalD
GO
CREATE VIEW cCapitalD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Socio,
  Titulo,
  Cantidad,
  Precio,
  Costo,

  Sucursal,
  SucursalOrigen

FROM
  CapitalD
GO

