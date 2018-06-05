

/****** CPObjetoGasto  ******/
if not exists(select * from SysTabla where SysTabla = 'CPObjetoGasto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CPObjetoGasto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CPObjetoGasto') and type = 'U') 
CREATE TABLE dbo.CPObjetoGasto (
	ObjetoGasto		varchar(10) 	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priCPObjetoGasto PRIMARY KEY  CLUSTERED (ObjetoGasto)
)
go

/******************* ClavePresupuestalCatalogoTipo ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ClavePresupuestalCatalogoTipo') --MEJORA4722
INSERT INTO SysTabla (SysTabla) VALUES ('ClavePresupuestalCatalogoTipo')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.ClavePresupuestalCatalogoTipo') AND Type = 'U') 
BEGIN
  CREATE TABLE ClavePresupuestalCatalogoTipo (
	Proyecto			varchar(50) NOT NULL,
	Tipo				varchar(50) NOT NULL,
	 
	RID					int	    IDENTITY NOT NULL,
	Categoria			varchar(1)  NULL,
	Digitos				int	    NULL,
	Rama				varchar(50) NULL,
	TechoPresupuesto	bit	    NULL,
	EsAcumulativa		bit	    NULL DEFAULT 0,
	Validacion			varchar(50) NULL		
  
  CONSTRAINT priClavePresupuestalCatalogoTipo PRIMARY KEY CLUSTERED (Proyecto, Tipo)
  )
END
GO

/******************* ClavePresupuestalCatalogo ****************/ 
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'ClavePresupuestalCatalogo') --MEJORA4722
INSERT INTO SysTabla (SysTabla) VALUES ('ClavePresupuestalCatalogo')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE Id = OBJECT_ID('dbo.ClavePresupuestalCatalogo') AND Type = 'U') 
BEGIN
  CREATE TABLE ClavePresupuestalCatalogo (
  	RID					int	     IDENTITY	NOT NULL,
	Proyecto			varchar(50)  NOT NULL,
	Clave				varchar(20)  NOT NULL,
	Tipo				varchar(50)  NOT NULL,
	Rama				varchar(20)  NOT NULL DEFAULT '',
	 
	Nombre				varchar(50)  NULL,
	TechoPresupuesto	money	     NULL,
	Descripcion			varchar(255) NULL,
	Observaciones		varchar(255) NULL,
	Categoria			varchar(1)   NULL,
	RamaTipo			varchar(50)  NOT NULL,
	RamaCategoria		varchar(20)  NULL,
	EsAcumulativa		AS CONVERT(bit,1),
	RamaNumerica		AS CONVERT(int,NULLIF(Rama,'')),

  CONSTRAINT priClavePresupuestalCatalogo PRIMARY KEY CLUSTERED (RID)
  )
END	 
GO

EXEC spAlter_Table 'ClavePresupuestalCatalogo', 'EsAcumulativa', 'AS CONVERT(bit,1)'
EXEC spAlter_Table 'ClavePresupuestalCatalogo', 'RamaNumerica', 'AS CONVERT(int,NULLIF(Rama,""))'
GO


EXEC spDROP_TABLE 'ClavePresupuestal', 3273
GO
/****** ClavePresupuestal  ******/
if not exists(select * from SysTabla where SysTabla = 'ClavePresupuestal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ClavePresupuestal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ClavePresupuestal') and type = 'U') 
CREATE TABLE dbo.ClavePresupuestal (
	ClavePresupuestal	varchar(50) 	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,

	Estatus			varchar(15)	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	UsuarioCambio		varchar(10)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
	TieneArticulosEsp	bit		NULL	DEFAULT 0,
	ObjetoGasto		varchar(10) 	NULL,

	Proyecto		varchar(50)	NULL, --MEJORA4722
	Categoria1		varchar(50)	NULL, --MEJORA4722
	Categoria2		varchar(50)	NULL, --MEJORA4722
	Categoria3		varchar(50)	NULL, --MEJORA4722
	Categoria4		varchar(50)	NULL, --MEJORA4722
	Categoria5		varchar(50)	NULL, --MEJORA4722
	Categoria6		varchar(50)	NULL, --MEJORA4722
	Categoria7		varchar(50)	NULL, --MEJORA4722
	Categoria8		varchar(50)	NULL, --MEJORA4722
	Categoria9		varchar(50)	NULL, --MEJORA4722
	CategoriaA		varchar(50)	NULL, --MEJORA4722
	CategoriaB		varchar(50)	NULL, --MEJORA4722
	CategoriaC		varchar(50)	NULL, --MEJORA4722
	
	CONSTRAINT priClavePresupuestal PRIMARY KEY  CLUSTERED (ClavePresupuestal)
)
go
EXEC spALTER_TABLE 'ClavePresupuestal', 'TieneArticulosEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ClavePresupuestal', 'ObjetoGasto', 'varchar(10) NULL'
GO
EXEC spADD_INDEX 'ClavePresupuestal', 'Nombre', 'Nombre'
GO
EXEC spALTER_TABLE 'ClavePresupuestal', 'Proyecto', 'varchar(50) NULL'   --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria1', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria2', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria3', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria4', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria5', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria6', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria7', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria8', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'Categoria9', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'CategoriaA', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'CategoriaB', 'varchar(50) NULL' --MEJORA4722
EXEC spALTER_TABLE 'ClavePresupuestal', 'CategoriaC', 'varchar(50) NULL' --MEJORA4722
GO


-- drop table CPC
/****** Consecutivos (CP) ******/
if not exists(select * from SysTabla where SysTabla = 'CPC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CPC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CPC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CPC (
    ID		int		NOT NULL IDENTITY (1,1),
	
    Empresa	varchar(5)      NULL,
    Mov 	varchar(20) 	NULL,
    Serie	varchar(20)	NULL,
    Periodo	int		NULL,
    Ejercicio	int		NULL,
		
    Consecutivo int		NOT NULL DEFAULT 0,
    Sucursal	int		NOT NULL DEFAULT 0,

    CONSTRAINT priCPC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CPC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CPC', '(ID)'
GO

-- drop table CP
-- delete cp
EXEC spDROP_TABLE 'CP', 3273
GO
/****** CP ******/
if not exists(select * from SysTabla where SysTabla = 'CP')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CP','Movimiento','CP')
GO
if not exists (select * from sysobjects where id = object_id('dbo.CP') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CP (
    ID				int		NOT NULL        IDENTITY(1,1),
		
    Empresa			varchar(5)	NOT NULL,
    Sucursal			int		NOT NULL	DEFAULT 0,
    Mov 			varchar(20)	NOT NULL,	
    MovID			varchar(20)	NULL,
    FechaEmision 		datetime	NULL,
    UltimoCambio 		datetime	NULL,
		
    UEN				int		NULL,
    Concepto			varchar(50)	NULL,
    Proyecto  			varchar(50)	NULL,
    Usuario 			varchar(10)	NULL,
    Autorizacion		varchar(10)	NULL,
    DocFuente			int		NULL,
    Observaciones 		varchar(100)	NULL,
    Referencia 			varchar(50)	NULL,
    Estatus 			varchar(15)	NULL,
    Situacion			varchar(50)	NULL,
    SituacionFecha		datetime	NULL,
    SituacionUsuario		varchar(10)	NULL,
    SituacionNota		varchar(100)	NULL,
    Moneda			varchar(10)	NULL,
    TipoCambio			float		NULL,
		
    OrigenTipo			varchar(10)	NULL,
    Origen			varchar(20)	NULL,
    OrigenID			varchar(20)	NULL,
		
    Poliza			varchar(20)     NULL,
    PolizaID			varchar(20)	NULL,
    GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
    ContID			int		NULL,

    Ejercicio			int		NULL,
    Periodo			int		NULL,
    FechaRegistro		datetime	NULL, 
    FechaConclusion		datetime	NULL,
    FechaCancelacion		datetime	NULL,
		
    Agente			varchar(10)	NULL,
    Personal			varchar(10)	NULL,
    Comentarios			text		NULL,
		
    CONSTRAINT priCP PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CP'
END
go
EXEC spSincroNivelRegistro @Tabla = 'CP'
EXEC spModificarPK_Mov 'CP'
go
EXEC spALTER_TABLE 'CP', 'Personal', 'varchar(10) NULL'
GO

--CP
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Consecutivo2  ON dbo.CP (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX FechaEmision2 ON dbo.CP (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Abrir2        ON dbo.CP (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Situacion3    ON dbo.CP (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Usuario       ON dbo.CP (Usuario)
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
	DROP INDEX CP.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
	DROP INDEX CP.Situacion2
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON CP (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON CP (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CP' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON CP (OrigenID,Origen,Empresa)
go

if exists (select * from sysobjects where id = object_id('dbo.tgCPA') and sysstat & 0xf = 8) drop trigger dbo.tgCPA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCPC') and sysstat & 0xf = 8) drop trigger dbo.tgCPC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCPB') and sysstat & 0xf = 8) drop trigger dbo.tgCPB
GO
EXEC spSincroNivelRegistroCampos 'CP'
GO
EXEC spModificarPK_Mov 'CP'
GO
-- Aqui va el Matenimiento a la tabla
GO

CREATE TRIGGER tgCPC ON CP
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
  
  SELECT @Modulo = 'CP'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted
  IF @EstatusNuevo <> @EstatusAnterior AND 
    ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
    (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
    (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
  BEGIN
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

      INSERT INTO MovTiempo (
      	      Modulo,  Sucursal,  ID,  Usuario,  FechaInicio,  FechaComenzo, Estatus,       Situacion) 
      VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @Usuario), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END
  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior
END
GO

CREATE TRIGGER tgCPB ON CP
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
    EXEC spMovAlEliminar 'CP', @ID
END
GO

-- drop table CPD
EXEC spDROP_TABLE 'CPD', 3273
GO
/****** CPD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'CPD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CPD','Movimiento','CP')
if not exists (select * from sysobjects where id = object_id('dbo.CPD') and type = 'U') 
  CREATE TABLE dbo.CPD (
	ID			int		NOT NULL,
	ClavePresupuestal	varchar(50)	NOT NULL,
	Renglon			float		NOT NULL,

	Tipo			varchar(20)	NULL,		-- Ampliacion, Reduccion
	Importe			money		NULL,
	
	Presupuesto		money		NULL,
	Comprometido		money		NULL,
	Comprometido2		money		NULL,
	Devengado		money		NULL,
	Devengado2		money		NULL,
	Ejercido		money		NULL,
	EjercidoPagado		money		NULL,
	Sobrante		money		NULL,
	RemanenteDisponible	money		NULL,
	Anticipos		money		NULL,
	
	Aplica			varchar(20)	NULL,
	AplicaID		varchar(20)	NULL,

	CONSTRAINT priCPD PRIMARY KEY CLUSTERED (ID, ClavePresupuestal, Renglon)
  )
go
EXEC spModificarPK_Sucursal 'CPD', '(ID, ClavePresupuestal, Renglon)'
GO
EXEC spADD_INDEX 'CPD', 'ClavePresupuestal', 'ID, ClavePresupuestal'
GO
EXEC spALTER_TABLE 'CPD', 'RemanenteDisponible', 'money	NULL'
EXEC spALTER_TABLE 'CPD', 'Anticipos', 'money NULL'
GO
EXEC spDROP_COLUMN 'CPD', 'Disponible'
GO
EXEC spALTER_TABLE 'CPD',  'Disponible', 'AS ISNULL(Presupuesto, 0.0)-ISNULL(Comprometido, 0.0)-ISNULL(Comprometido2, 0.0)-ISNULL(Devengado, 0.0)-ISNULL(Devengado2, 0.0)-ISNULL(Ejercido, 0.0)-ISNULL(EjercidoPagado, 0.0)-ISNULL(Sobrante, 0.0)'
GO
-- select * from cpd

if exists (select * from sysobjects where id = object_id('dbo.cCPD') and sysstat & 0xf = 2) drop view dbo.cCPD
GO
CREATE VIEW cCPD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  ClavePresupuestal,
  Tipo,
  Importe,
  Presupuesto,
  Comprometido,
  Comprometido2,
  Devengado,
  Devengado2,
  Ejercido,
  EjercidoPagado,
  RemanenteDisponible,
  Anticipos,
  Sobrante,
  Sucursal,
  SucursalOrigen
  
FROM
  CPD
GO

if exists (select * from sysobjects where id = object_id('dbo.CPNeto') and sysstat & 0xf = 2) drop view dbo.CPNeto
GO
CREATE VIEW CPNeto
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto,
       d.ClavePresupuestal,
       'Presupuesto' = CONVERT(money,ISNULL(SUM(d.Presupuesto*e.TipoCambio), 0.0)),
       'Comprometido' = CONVERT(money,ISNULL(SUM(d.Comprometido*e.TipoCambio), 0.0)),
       'Comprometido2' = CONVERT(money,ISNULL(SUM(d.Comprometido2*e.TipoCambio), 0.0)),
       'Devengado' = CONVERT(money,ISNULL(SUM(d.Devengado*e.TipoCambio), 0.0)),
       'Devengado2' = CONVERT(money,ISNULL(SUM(d.Devengado2*e.TipoCambio), 0.0)),
       'Ejercido' = CONVERT(money,ISNULL(SUM(d.Ejercido*e.TipoCambio), 0.0)),
       'EjercidoPagado' = CONVERT(money,ISNULL(SUM(d.EjercidoPagado), 0.0)),
       'RemanenteDisponible' = CONVERT(money,ISNULL(SUM(d.RemanenteDisponible*e.TipoCambio), 0.0)),
       'Anticipos' = CONVERT(money,ISNULL(SUM(d.Anticipos*e.TipoCambio), 0.0)),
       'Sobrante' = CONVERT(money,ISNULL(SUM(d.Sobrante*e.TipoCambio), 0.0)),
       'Disponible' = CONVERT(money,ISNULL(SUM(d.Disponible), 0.0))
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.OP')
GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal
GO


if exists (select * from sysobjects where id = object_id('dbo.CPEjercicioPeriodoNeto') and sysstat & 0xf = 2) drop view dbo.CPEjercicioPeriodoNeto
GO
CREATE VIEW CPEjercicioPeriodoNeto
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto,
       e.Ejercicio,
       e.Periodo,
       d.ClavePresupuestal, 
       'Presupuesto' = ISNULL(SUM(d.Presupuesto*e.TipoCambio), 0.0),
       'Comprometido' = ISNULL(SUM(d.Comprometido*e.TipoCambio), 0.0),
       'Comprometido2' = ISNULL(SUM(d.Comprometido2*e.TipoCambio), 0.0),
       'Devengado' = ISNULL(SUM(d.Devengado*e.TipoCambio), 0.0),
       'Devengado2' = ISNULL(SUM(d.Devengado2*e.TipoCambio), 0.0),
       'Ejercido' = ISNULL(SUM(d.Ejercido*e.TipoCambio), 0.0),
       'EjercidoPagado' = ISNULL(SUM(d.EjercidoPagado*e.TipoCambio), 0.0),
       'RemanenteDisponible' = ISNULL(SUM(d.RemanenteDisponible*e.TipoCambio), 0.0),
       'Anticipos' = ISNULL(SUM(d.Anticipos*e.TipoCambio), 0.0),
       'Sobrante' = ISNULL(SUM(d.Sobrante*e.TipoCambio), 0.0),
       'Disponible' = ISNULL(SUM(d.Disponible*e.TipoCambio), 0.0)
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.OP')
 GROUP BY e.Empresa, e.Proyecto, e.Ejercicio, e.Periodo, d.ClavePresupuestal
GO

-- drop table CPCal
EXEC spDROP_VIEW 'cCPPeriodo', 3251
EXEC spDROP_TABLE 'CPPeriodo', 3251
EXEC spDROP_VIEW 'cCPCal', 3273
EXEC spDROP_TABLE 'CPCal', 3273
GO
-- delete CPCalMovPreAyuda 
/****** CPCalMovPreAyuda  ******/
if not exists(select * from SysTabla where SysTabla = 'CPCalMovPreAyuda')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CPCalMovPreAyuda','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.CPCalMovPreAyuda') and type = 'U') 
CREATE TABLE dbo.CPCalMovPreAyuda (
	Estacion		int		NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	ClavePresupuestal	varchar(50)	NULL,
	Importe			money		NULL,


	CONSTRAINT priCPCalMovPreAyuda PRIMARY KEY  CLUSTERED (Estacion, RID)
)
go

/* CPCalMovAyuda  */
if exists (select * from sysobjects where id = object_id('dbo.CPCalMovAyuda') and sysstat & 0xf = 2) drop view dbo.CPCalMovAyuda
GO
CREATE VIEW CPCalMovAyuda
--//WITH ENCRYPTION
AS
SELECT
  Estacion,
  ClavePresupuestal,
  'Importe' = SUM(Importe) 

FROM
  CPCalMovPreAyuda
  
GROUP BY
  Estacion,
  ClavePresupuestal
GO



-- select * from CPCalMov
/****** CPCalMov  ******/
if not exists(select * from SysTabla where SysTabla = 'CPCalMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CPCalMov','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CPCalMov') and type = 'U') 
CREATE TABLE dbo.CPCalMov (
	Modulo			varchar(50) 	NOT NULL,
	ModuloID		int		NOT NULL,
	ClavePresupuestal	varchar(50)	NOT NULL,
	Tipo			varchar(20)	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	Importe			money		NULL,


	CONSTRAINT priCPCalMov PRIMARY KEY  CLUSTERED (Modulo, ModuloID, ClavePresupuestal, Tipo, Ejercicio, Periodo)
)
go

/****** CPCal (Periodo) ******/
if not exists(select * from SysTabla where SysTabla = 'CPCal')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CPCal','Movimiento','CP')
if not exists (select * from sysobjects where id = object_id('dbo.CPCal') and type = 'U') 
  CREATE TABLE dbo.CPCal (
	ID			int		NOT NULL,
	ClavePresupuestal	varchar(50)	NOT NULL,
	Tipo			varchar(20)	NOT NULL,
	Ejercicio		int		NOT NULL,
	Periodo			int		NOT NULL,

	Importe			money		NULL,
	EnMov			bit		NULL,
	
	CONSTRAINT priCPCal PRIMARY KEY CLUSTERED (ID, ClavePresupuestal, Tipo, Ejercicio, Periodo)
  )
go
EXEC spModificarPK_Sucursal 'CPCal', '(ID, ClavePresupuestal, Periodo)'
GO
-- select * from cCPCal
if exists (select * from sysobjects where id = object_id('dbo.cCPCal') and sysstat & 0xf = 2) drop view dbo.cCPCal
GO
CREATE VIEW cCPCal
--//WITH ENCRYPTION
AS
SELECT
  ID,
  ClavePresupuestal,
  Tipo,
  Ejercicio,
  Periodo,
  Importe,
  Sucursal,
  SucursalOrigen
  
FROM
  CPCal
GO


if exists (select * from sysobjects where id = object_id('dbo.CPCalNeto') and sysstat & 0xf = 2) drop view dbo.CPCalNeto
GO
CREATE VIEW CPCalNeto
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto, 
       d.ClavePresupuestal, 
       cal.Ejercicio,
       cal.Periodo,
       'Presupuesto' = ISNULL(CONVERT(money, SUM((cal.Importe*e.TipoCambio)*CASE WHEN UPPER(d.Tipo) = 'REDUCCION' THEN -1.0 ELSE 1.0 END)), 0.0)/*,
       'EjercidoAcumulado' = (SELECT ISNULL(SUM(n.Ejercido), 0.0)+ISNULL(SUM(n.EjercidoPagado), 0.0) FROM CPEjercicioPeriodoNeto n WHERE n.Empresa = e.Empresa AND n.Proyecto = e.Proyecto AND n.ClavePresupuestal = d.ClavePresupuestal AND (dbo.fnEjercicioPeriodoEnValor(cal.Ejercicio, cal.Periodo) <= dbo.fnEjercicioPeriodoEnValor(n.Ejercicio, n.Periodo)))*/
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN CPCal cal ON cal.ID = e.ID AND cal.ClavePresupuestal = d.ClavePresupuestal AND cal.Tipo = d.Tipo
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR')
 GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal, cal.Ejercicio, cal.Periodo
GO

if exists (select * from sysobjects where id = object_id('dbo.CPCalReservado') and sysstat & 0xf = 2) drop view dbo.CPCalReservado
GO
CREATE VIEW CPCalReservado
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto, 
       d.ClavePresupuestal, 
       cal.Ejercicio,
       cal.Periodo,
       'Presupuesto' = ISNULL(CONVERT(money, SUM((cal.Importe*e.TipoCambio)*CASE WHEN UPPER(d.Tipo) = 'REDUCCION' THEN -1.0 ELSE 1.0 END)), 0.0)
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN CPCal cal ON cal.ID = e.ID AND cal.ClavePresupuestal = d.ClavePresupuestal AND cal.Tipo = d.Tipo
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave = 'CP.RF'
 GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal, cal.Ejercicio, cal.Periodo
GO

if exists (select * from sysobjects where id = object_id('dbo.CPCalDisponible') and sysstat & 0xf = 2) drop view dbo.CPCalDisponible
GO
CREATE VIEW CPCalDisponible
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto, 
       d.ClavePresupuestal, 
       cal.Ejercicio,
       cal.Periodo,
       'Presupuesto' = ISNULL(CONVERT(money, SUM((cal.Importe*e.TipoCambio)*CASE WHEN UPPER(d.Tipo) = 'REDUCCION' THEN -1.0 ELSE 1.0 END*CASE WHEN mt.Clave = 'CP.RF' THEN -1.0 ELSE 1.0 END)), 0.0)
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN CPCal cal ON cal.ID = e.ID AND cal.ClavePresupuestal = d.ClavePresupuestal AND cal.Tipo = d.Tipo
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR', 'CP.RF')
 GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal, cal.Ejercicio, cal.Periodo
GO


EXEC spDROP_VIEW 'cCPEsp', 3253
EXEC spDROP_TABLE 'CPEsp', 3253
EXEC spDROP_VIEW 'cCPArt', 3273
EXEC spDROP_TABLE 'CPArt', 3273
GO
/****** CPArt (Articulo) ******/
if not exists(select * from SysTabla where SysTabla = 'CPArt')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CPArt','Movimiento','CP')
if not exists (select * from sysobjects where id = object_id('dbo.CPArt') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CPArt (
	ID			int		NOT NULL,
	ClavePresupuestal	varchar(50)	NOT NULL,
	Tipo			varchar(20)	NOT NULL,
	Articulo		varchar(20)	NOT NULL,
	
	Cantidad		float		NULL,
	Precio			float		NULL,
	Referencia		varchar(50)	NULL,
	Observaciones		varchar(255)	NULL,
	EnMov			bit		NULL,
	
	CONSTRAINT priCPArt PRIMARY KEY CLUSTERED (ID, ClavePresupuestal, Tipo, Articulo)
  )
  EXEC spSincroSemilla 'CPArt'
END
go
EXEC spModificarPK_Sucursal 'CPArt', '(ID, ClavePresupuestal, Articulo)'
GO

/* cCPArt */
if exists (select * from sysobjects where id = object_id('dbo.cCPArt') and sysstat & 0xf = 2) drop view dbo.cCPArt
GO
CREATE VIEW cCPArt
--//WITH ENCRYPTION
AS
SELECT
  ID,
  ClavePresupuestal,
  Tipo,
  Articulo,
  Cantidad,
  Precio,
  Referencia,
  Observaciones,
  Sucursal,
  SucursalOrigen
  
FROM
  CPArt
GO

/* CPArtNeto */
if exists (select * from sysobjects where id = object_id('dbo.CPArtNeto') and sysstat & 0xf = 2) drop view dbo.CPArtNeto
GO
CREATE VIEW CPArtNeto
--//WITH ENCRYPTION
AS
SELECT e.Empresa,
       e.Proyecto, 
       d.ClavePresupuestal, 
       cpa.Articulo,
       'Cantidad' = SUM(cpa.Cantidad*CASE WHEN UPPER(d.Tipo) = 'REDUCCION' THEN -1.0 ELSE 1.0 END),
       'Importe' = CONVERT(money, SUM(cpa.Cantidad*cpa.Precio*CASE WHEN UPPER(d.Tipo) = 'REDUCCION' THEN -1.0 ELSE 1.0 END))
  FROM CPD d
  JOIN CP e ON e.ID = d.ID AND e.Estatus = 'CONCLUIDO'
  JOIN CPArt cpa ON cpa.ID = e.ID AND cpa.ClavePresupuestal = d.ClavePresupuestal AND cpa.Tipo = d.Tipo
  JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = e.Mov AND mt.Clave IN ('CP.AS', 'CP.TA', 'CP.TR')
 GROUP BY e.Empresa, e.Proyecto, d.ClavePresupuestal, cpa.Articulo
GO


--  spCPCal 847, 2009, 'A00 1803 001 O099 3300 1 1', 'Reduccion'

/**************** spCPCal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCPCal') and type = 'P') drop procedure dbo.spCPCal
GO
CREATE PROCEDURE spCPCal
    		    @ID			int,
    		    @Ejercicio		int,
    		    @ClavePresupuestal	varchar(50),
    		    @Tipo		varchar(20)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Empresa	varchar(5),
    @Sucursal	int,
    @Proyecto	varchar(50),
    @MovTipo	varchar(20)
    
  SELECT @MovTipo = mt.Clave
    FROM CP 
    JOIN MovTipo mt ON mt.Modulo = 'CP' AND mt.Mov = CP.Mov
   WHERE CP.ID = @ID

  IF @MovTipo = 'CP.TA'
  BEGIN
    IF NOT EXISTS(SELECT * FROM CPCal WHERE ID = @ID AND Ejercicio = @Ejercicio AND ClavePresupuestal = @ClavePresupuestal AND Tipo = @Tipo)
    BEGIN
      SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Proyecto = Proyecto
        FROM CP 
       WHERE ID = @ID
      INSERT CPCal (
             ID,  ClavePresupuestal,  Ejercicio,  Tipo,  Periodo, Importe,     Sucursal, SucursalOrigen)
      SELECT @ID, @ClavePresupuestal, @Ejercicio, @Tipo, Periodo, Presupuesto, @Sucursal, @Sucursal
        FROM CPCalDisponible
      WHERE Empresa = @Empresa AND Proyecto = @Proyecto AND ClavePresupuestal = @ClavePresupuestal AND Ejercicio = @Ejercicio 
    END
  END
  RETURN
END
GO

--BUG16047
/****** TempCPImportarPresupuesto ******/
if not exists(select * from SysTabla where SysTabla = 'TempCPImportarPresupuesto')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('TempCPImportarPresupuesto','Movimiento','CP')
if not exists (select * from sysobjects where id = object_id('dbo.TempCPImportarPresupuesto') and type = 'U') 
CREATE TABLE TempCPImportarPresupuesto(
  RID				int			IDENTITY,
  EstacionTrabajo	int			NOT NULL,
  Orden				int			NULL,
  C1				varchar(255)NULL,
  C2				varchar(255)NULL,
  C3				varchar(255)NULL,
  C4				varchar(255)NULL,
  C5				varchar(255)NULL,
  C6				varchar(255)NULL,
  C7				varchar(255)NULL,
  C8				varchar(255)NULL,
  C9				varchar(255)NULL,
  C10				varchar(255)NULL,
  C11				varchar(255)NULL,
  C12				varchar(255)NULL,
  C13				varchar(255)NULL,
  C14				varchar(255)NULL
  )
GO