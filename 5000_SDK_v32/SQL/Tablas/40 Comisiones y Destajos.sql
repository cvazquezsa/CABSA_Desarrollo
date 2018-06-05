
/*******************************************************************************************/
/*                             COMISIONES Y DESTAJOS                             	   */
/*******************************************************************************************/

/****** Consecutivos ******/
if not exists (select * from SysTabla where SysTabla = 'AgentC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AgentC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.AgentC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AgentC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			char(5)         NULL,
	Mov 		        char(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priAgentC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AgentC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'AgentC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE AgentC ALTER COLUMN Empresa char(5)  NULL")
  EXEC("ALTER TABLE AgentC ALTER COLUMN Mov     char(20) NULL")
END
GO

/****** Agent (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'Agent') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Agent','Movimiento','AGENT')
if not exists (select * from sysobjects where id = object_id('dbo.Agent') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Agent (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			char(5)	        NOT NULL,
	Mov  			char(20)        NOT NULL,
	MovID			varchar(20)    	NULL,	 
	FechaEmision 		datetime    	NULL,	 
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda 			char(10)   	NOT NULL,
	TipoCambio		float		NULL,
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

	Agente  		char(10)   	NOT NULL,
	CtaDinero		char(10)        NULL,       
	FormaPago		varchar(50)	NULL,
	Importe   		money       	NULL,
	Retencion   		money       	NULL,
	RetencionPorcentaje	money       	NULL,
	Impuestos		money       	NULL,
	ImpuestosPorcentaje	money       	NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,

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

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	Logico7			bit		NOT NULL DEFAULT 0,
	Logico8			bit		NOT NULL DEFAULT 0,
	Logico9			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAgent PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Agent'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Agent'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Agent.Consecutivo
  ALTER TABLE Agent ALTER COLUMN MovID varchar(20)
  ALTER TABLE Agent ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Agent ALTER COLUMN PolizaID varchar(20)
END
GO
EXEC spModificarPK_Mov 'Agent'
GO

-- Agent
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente 	    ON dbo.Agent (Agente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Agent (Referencia)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Agent (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Agent (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Agent (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Agent (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Agent (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Agent (ContID)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Agent.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Agent.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Agent.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Agent.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Agent.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Agent (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Agent (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Agent' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenEmpresa ON Agent (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgAgentA') and sysstat & 0xf = 8) drop trigger dbo.tgAgentA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAgentC') and sysstat & 0xf = 8) drop trigger dbo.tgAgentC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAgentB') and sysstat & 0xf = 8) drop trigger dbo.tgAgentB
GO
EXEC spSincroNivelRegistroCampos 'Agent'
GO
EXEC spALTER_TABLE 'Agent', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Agent', 'SituacionNota', 'varchar(100) NULL'
GO

-- Aqui va el Matenimiento a la tabla

EXEC spALTER_TABLE 'Agent', 'UEN', 'int NULL'
GO

EXEC spFK 'Agent','Moneda','Mon','Moneda'
EXEC spFK 'Agent','UEN','UEN','UEN'
GO

CREATE TRIGGER tgAgentC ON Agent
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
  
  SELECT @Modulo = 'AGENT'
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
    UPDATE Agent SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgAgentB ON Agent
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
    EXEC spMovAlEliminar 'AGENT', @ID
END
GO

/****** Agent (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'AgentD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('AgentD','Movimiento','AGENT')
if not exists (select * from sysobjects where id = object_id('dbo.AgentD') and type = 'U') 
CREATE TABLE dbo.AgentD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL   DEFAULT 0,

        Importe                 money           NULL,
	Aplica   	        char(20)        NULL,
        AplicaID	        varchar(20)     NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAgentD PRIMARY KEY CLUSTERED (ID,Renglon,RenglonSub)

)
GO
if (select version from version) <= 1095
  ALTER TABLE AgentD ALTER COLUMN AplicaID varchar(20)
GO
EXEC spModificarPK_Sucursal 'AgentD', '(ID,Renglon,RenglonSub)'
GO

if exists (select * from sysobjects where id = object_id('dbo.cAgentD') and sysstat & 0xf = 2) drop view dbo.cAgentD
GO
CREATE VIEW cAgentD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Importe,
  Aplica,
  AplicaID,

  Sucursal,
  SucursalOrigen,

  Logico1,
  Logico2,
  Logico3

FROM
  AgentD
GO
