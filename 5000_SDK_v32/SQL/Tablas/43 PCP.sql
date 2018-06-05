/****** Consecutivos (PCP) ******/
if not exists(select * from SysTabla where SysTabla = 'PCPC')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PCPC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.PCPC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PCPC (
    ID		int		NOT NULL IDENTITY (1,1),
	
    Empresa	varchar(5)      NULL,
    Mov 	varchar(20) 	NULL,
    Serie	varchar(20)		NULL,
    Periodo	int				NULL,
    Ejercicio	int			NULL,
		
    Consecutivo int			NOT NULL DEFAULT 0,
    Sucursal	int			NOT NULL DEFAULT 0,

    CONSTRAINT priPCPC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PCPC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'PCPC', '(ID)'
GO

/****** PCP ******/
if not exists(select * from SysTabla where SysTabla = 'PCP')
	INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCP','Movimiento','PCP')
GO
if not exists (select * from sysobjects where id = object_id('dbo.PCP') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PCP (
    ID									int		NOT NULL        IDENTITY(1,1),
		
    Empresa								varchar(5)	NOT NULL,
    Sucursal							int		NOT NULL	DEFAULT 0,
    Mov 								varchar(20)	NOT NULL,	
    MovID								varchar(20)	NULL,
    FechaEmision 						datetime	NULL,
    UltimoCambio 						datetime		NULL,
		
    UEN									int				NULL,
    Concepto							varchar(50)		NULL,
    Proyecto  							varchar(50)		NULL,
    Usuario 							varchar(10)		NULL,
    Autorizacion						varchar(10)		NULL,
    DocFuente							int				NULL,
    Observaciones 						varchar(100)	NULL,
    Referencia 							varchar(50)		NULL,
    Estatus 							varchar(15)		NULL,
    Situacion							varchar(50)		NULL,
    SituacionFecha						datetime		NULL,
    SituacionUsuario					varchar(10)		NULL,
    SituacionNota						varchar(100)	NULL,
    Moneda								varchar(10)		NULL,
    TipoCambio							float			NULL,
		
    OrigenTipo							varchar(10)		NULL,
    Origen								varchar(20)		NULL,
    OrigenID							varchar(20)		NULL,
		
    Poliza								varchar(20)     NULL,
    PolizaID							varchar(20)		NULL,
    GenerarPoliza						bit	    	NOT NULL DEFAULT 0,
    ContID								int				NULL,

    Ejercicio							int				NULL,
    Periodo								int				NULL,
    FechaRegistro						datetime		NULL, 
    FechaConclusion						datetime		NULL,
    FechaCancelacion					datetime		NULL,
		
    Agente								varchar(10)		NULL,
    Personal							varchar(10)		NULL,
    Comentarios							text			NULL,
	
	FechaInicio							datetime		NULL,
	FechaFin							datetime		NULL,
	Categoria							varchar(1)		NULL,
	Tipo								varchar(15)		NULL,
	ClavePresupuestalMascara			varchar(50)		NULL,
	ProyectoDescripcion					varchar(100)	NULL,
	PresupuestoID						int				NULL,
		
	CategoriaPredominante				varchar(1)		NULL,
	
    CONSTRAINT priPCP PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PCP'
END
go
EXEC spSincroNivelRegistro @Tabla = 'PCP'
go

EXEC spAlter_Table 'PCP', 'ProyectoDescripcion', 'varchar(100) NULL'
EXEC spAlter_Table 'PCP', 'PresupuestoID', 'int NULL'
EXEC spAlter_Table 'PCP', 'CategoriaPredominante', 'varchar(1) NULL'
GO

EXEC spModificarPK_Mov 'PCP'
go

--CP
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Consecutivo2  ON dbo.PCP (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX FechaEmision2 ON dbo.PCP (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Abrir2        ON dbo.PCP (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Situacion3    ON dbo.PCP (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
	CREATE INDEX Usuario       ON dbo.PCP (Usuario)
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
	DROP INDEX PCP.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
	DROP INDEX PCP.Situacion2
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON PCP (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON PCP (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PCP' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON PCP (OrigenID,Origen,Empresa)
go


if exists (select * from sysobjects where id = object_id('dbo.tgPCPA') and sysstat & 0xf = 8) drop trigger dbo.tgPCPA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPCPC') and sysstat & 0xf = 8) drop trigger dbo.tgPCPC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgPCPB') and sysstat & 0xf = 8) drop trigger dbo.tgPCPB
GO
EXEC spSincroNivelRegistroCampos 'PCP'
GO
EXEC spModificarPK_Mov 'PCP'
GO
-- Aqui va el Matenimiento a la tabla
GO

CREATE TRIGGER tgPCPC ON PCP
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
  
  SELECT @Modulo = 'PCP'
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

CREATE TRIGGER tgPCPB ON PCP
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
    EXEC spMovAlEliminar 'PCP', @ID
END
GO

/****** PCPD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'PCPD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCPD','Movimiento','PCP')
if not exists (select * from sysobjects where id = object_id('dbo.PCPD') and type = 'U') 
  CREATE TABLE dbo.PCPD (
	ID								int					NOT NULL,
	Renglon							float				NOT NULL,

	CatalogoTipoTipo					varchar(50)			NULL,
	CatalogoTipoRama					varchar(50)			NULL,
	CatalogoTipoDigitos					int					NULL,
	CatalogoTipoEsAcumulativa			bit					NULL,
	CatalogoTipoValidacion				varchar(50)			NULL,
	CatalogoTipoTechoPresupuesto		bit					NULL,
									
	ClavePresupuestal					varchar(50)			NULL,
	ClavePresupuestalNombre				varchar(100)		NULL,
	ClavePresupuestalDescripcion		varchar(255)		NULL,
	ClavePresupuestalArticulosEsp		bit					NULL,
	ClavePresupuestalNombreA			varchar(100)		NULL,
	ClavePresupuestalDescripcionA		varchar(255)		NULL,
	ClavePresupuestalArticulosEspA		bit					NULL,	
	ClavePresupuestalCat1				varchar(20)			NULL,
	ClavePresupuestalCat2				varchar(20)			NULL,
	ClavePresupuestalCat3				varchar(20)			NULL,
	ClavePresupuestalCat4				varchar(20)			NULL,
	ClavePresupuestalCat5				varchar(20)			NULL,
	ClavePresupuestalCat6				varchar(20)			NULL,
	ClavePresupuestalCat7				varchar(20)			NULL,
	ClavePresupuestalCat8				varchar(20)			NULL,
	ClavePresupuestalCat9				varchar(20)			NULL,
	ClavePresupuestalCatA				varchar(20)			NULL,
	ClavePresupuestalCatB				varchar(20)			NULL,
	ClavePresupuestalCatC				varchar(20)			NULL,	
	
	CatalogoClave					varchar(20)			NULL,
	CatalogoRama					varchar(20)			NULL,
	CatalogoTipo					varchar(50)			NULL,
	CatalogoRamaTipo				varchar(50)			NULL,
	CatalogoNombre					varchar(50)			NULL,
	CatalogoTechoPresupuesto		money				NULL,
	CatalogoDescripcion				varchar(255)		NULL,
	CatalogoObservaciones			varchar(255)		NULL,
	CatalogoNombreAnterior			varchar(50)			NULL,
	CatalogoDescripcionAnterior		varchar(255)		NULL,
	CatalogoObservacionesAnterior	varchar(255)		NULL,
	CatalogoTechoPresupuestoAnt		money				NULL,
	CatalogoRID						int					NULL,
	
	ReglaOrden						int					NULL,
	ReglaMascara					varchar(50)			NULL,
	ReglaTipo						varchar(20)			NULL,
	ReglaDescripcion				varchar(50)			NULL,
	ReglaID							int					NULL,

	ReglaOrdenAnt					int					NULL,
	ReglaMascaraAnt					varchar(50)			NULL,
	ReglaTipoAnt					varchar(20)			NULL,
	ReglaDescripcionAnt				varchar(50)			NULL,
	
	Sucursal						int					NULL,
	SucursalOrigen					int					NULL,
	
	Estatus							varchar(15)			NULL DEFAULT 'PENDIENTE',
	Aplica							varchar(20)			NULL,
	AplicaID						varchar(20)			NULL,
	
	Observaciones					varchar(100)		NULL,

	ObjetoGasto						varchar(10)			NULL, --BUG17946
	ObjetoGastoAnt						varchar(10)		NULL, --BUG17946
		
	CONSTRAINT priPCPD PRIMARY KEY CLUSTERED (ID, Renglon)
  )
go
EXEC spModificarPK_Sucursal 'PCPD', '(ID, Renglon)'
GO

EXEC spAlter_Table 'PCPD', 'Estatus', 'varchar(15) NULL'
EXEC spAlter_Table 'PCPD', 'Aplica', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'AplicaID', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'CatalogoTechoPresupuestoAnt', 'money NULL'
EXEC spAlter_Table 'PCPD', 'CatalogoRama', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'Estatus', 'varchar(15) NULL DEFAULT "PENDIENTE"'
EXEC spAlter_Table 'PCPD', 'Observaciones', 'varchar(100) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat1', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat2', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat3', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat4', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat5', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat6', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat7', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat8', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCat9', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCatA', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCatB', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalCatC', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalNombreA', 'varchar(100) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalDescripcionA', 'varchar(255) NULL'
EXEC spAlter_Table 'PCPD', 'ClavePresupuestalArticulosEspA', 'bit NULL'	
EXEC spAlter_Table 'PCPD', 'ReglaDescripcion', 'varchar(50) NULL'	
EXEC spAlter_Table 'PCPD', 'ReglaOrdenAnt', 'int NULL'
EXEC spAlter_Table 'PCPD', 'ReglaMascaraAnt', 'varchar(50) NULL'
EXEC spAlter_Table 'PCPD', 'ReglaTipoAnt', 'varchar(20) NULL'
EXEC spAlter_Table 'PCPD', 'ReglaDescripcionAnt', 'varchar(50) NULL'
GO
EXEC spAlter_Table 'PCPD', 'ObjetoGasto', 'varchar(10) NULL' --BUG17946
EXEC spAlter_Table 'PCPD', 'ObjetoGastoAnt', 'varchar(10) NULL' --BUG17946
GO

if exists (select * from sysobjects where id = object_id('dbo.cPCPD') and sysstat & 0xf = 2) drop view dbo.cPCPD
GO
CREATE VIEW cPCPD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  CatalogoTipoTipo,
  CatalogoTipoRama,
  CatalogoTipoDigitos,
  CatalogoTipoEsAcumulativa,
  CatalogoTipoValidacion,
  CatalogoTipoTechoPresupuesto,

  ClavePresupuestal,
  ClavePresupuestalNombre,
  ClavePresupuestalDescripcion,
  ClavePresupuestalArticulosEsp,
  ClavePresupuestalNombreA,		
  ClavePresupuestalDescripcionA,	
  ClavePresupuestalArticulosEspA,	  
  ClavePresupuestalCat1,
  ClavePresupuestalCat2,
  ClavePresupuestalCat3,
  ClavePresupuestalCat4,
  ClavePresupuestalCat5,
  ClavePresupuestalCat6,
  ClavePresupuestalCat7,
  ClavePresupuestalCat8,
  ClavePresupuestalCat9,
  ClavePresupuestalCatA,
  ClavePresupuestalCatB,
  ClavePresupuestalCatC,
    
  CatalogoClave,
  CatalogoTipo,
  CatalogoRamaTipo,
  CatalogoNombre,
  CatalogoTechoPresupuesto,
  CatalogoDescripcion,
  CatalogoObservaciones,
  CatalogoNombreAnterior,
  CatalogoDescripcionAnterior,
  CatalogoObservacionesAnterior,
  CatalogoRID,

  ReglaOrden,
  ReglaMascara,
  ReglaTipo,
  ReglaID,
  ReglaDescripcion,
  ReglaOrdenAnt,
  ReglaMascaraAnt,
  ReglaTipoAnt,					
  ReglaDescripcionAnt,				
  
  Sucursal,
  SucursalOrigen,
  Aplica,
  AplicaID,
  CatalogoTechoPresupuestoAnt,
  CatalogoRama,
  Observaciones,
  ObjetoGasto, --BUG17946
  ObjetoGastoAnt --BUG17946
FROM
  PCPD
GO

/****** PCPDRegla ******/
if not exists(select * from SysTabla where SysTabla = 'PCPDRegla')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCPDRegla','Movimiento','PCP')
if not exists (select * from sysobjects where id = object_id('dbo.PCPDRegla') and type = 'U') 
  CREATE TABLE dbo.PCPDRegla (
	ID								int					NOT NULL,
	Renglon							float				NOT NULL,
	RID								int identity(1,1)	NOT NULL,

	FechaD							datetime			NULL,
	FechaA							datetime			NULL,
	MascaraFecha					varchar(10)			NULL, 
		
	CONSTRAINT priPCPDRegla PRIMARY KEY CLUSTERED (ID, Renglon, RID)
  )
GO

if exists (select * from sysobjects where id = object_id('dbo.cPCPDRegla') and sysstat & 0xf = 2) drop view dbo.cPCPDRegla
GO
CREATE VIEW cPCPDRegla
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  FechaD,
  FechaA,
  MascaraFecha
FROM
  PCPDRegla
GO

/****** PCPDReglaVig ******/
/*
if not exists(select * from SysTabla where SysTabla = 'PCPDReglaVig')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCPDReglaVig','Movimiento','PCP')
if not exists (select * from sysobjects where id = object_id('dbo.PCPDReglaVig') and type = 'U') 
  CREATE TABLE dbo.PCPDReglaVig (
	ID								int					NOT NULL,
	Renglon							float				NOT NULL,
	ReglaID							int					NOT NULL,
	RID								int identity(1,1)	NOT NULL,

	FechaD							datetime			NULL,
	FechaA							datetime			NULL,
	MascaraFecha					varchar(10)			NULL, 
		
	CONSTRAINT priPCPDReglaVig PRIMARY KEY CLUSTERED (ID, Renglon, ReglaID, RID)
  )
*/

/****** PCPDTemporalRama ******/
if not exists(select * from SysTabla where SysTabla = 'PCPDTemporalRama')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCPDTemporalRama','Movimiento','PCP')
if not exists (select * from sysobjects where id = object_id('dbo.PCPDTemporalRama') and type = 'U') 
  CREATE TABLE dbo.PCPDTemporalRama (
    Estacion						int					NOT NULL,
	RID								int identity(1,1)	NOT NULL,

	CatalogoRamaTipo				varchar(50)			NULL,
	Categoria						varchar(1)			NULL,
			
	CONSTRAINT priPCPDTemporalRama PRIMARY KEY CLUSTERED (Estacion, RID)
  )
GO

EXEC spAlter_Table 'PCPDTemporalRama', 'Categoria', 'varchar(1) NULL'
GO

/****** PCPDTemporalCatalogoRama ******/
if not exists(select * from SysTabla where SysTabla = 'PCPDTemporalCatalogoRama')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('PCPDTemporalCatalogoRama','Movimiento','PCP')
if not exists (select * from sysobjects where id = object_id('dbo.PCPDTemporalCatalogoRama') and type = 'U') 
  CREATE TABLE dbo.PCPDTemporalCatalogoRama (
    Estacion						int					NOT NULL,
	RID								int identity(1,1)	NOT NULL,

	CatalogoTipo					varchar(50)			NULL,
	Catalogo						varchar(20)			NULL,
	Nombre							varchar(50)			NULL,
	Categoria						varchar(1)			NULL,
			
	CONSTRAINT priPCPDTemporalCatalogoRama PRIMARY KEY CLUSTERED (Estacion, RID)
  )
GO

EXEC spAlter_Table 'PCPDTemporalCatalogoRama', 'Categoria', 'varchar(1) NULL'
GO
