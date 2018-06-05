SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF

--REQ16092
/****** OportunidadPlantilla ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantilla') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantilla', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantilla') and type = 'U') 
  CREATE TABLE OportunidadPlantilla(
    ID				int				IDENTITY(1,1),

    Plantilla			varchar(20)     NULL,
    FechaEmision		datetime        NULL,
    UltimoCambio		datetime        NULL,
    Usuario				varchar(10)     NULL,
    Estatus				varchar(15)     NULL,
    Comentarios			varchar(max)    NULL,
    GenerarMov			bit				NULL,
    Mov					varchar(20)		NULL,
    MovOportunidad		varchar(20)		NOT NULL DEFAULT 'Prop. Oportunidad',
    Categoria			varchar(50)     NULL,
    Grupo				varchar(50)     NULL,
    Familia				varchar(50)     NULL,        
    TieneMovimientos	bit				NULL,
    NivelAcceso			varchar(50)		NULL,
    RenglonID			int				NULL,
    
    CONSTRAINT priOportunidadPlantilla PRIMARY KEY CLUSTERED (ID)
  )
GO

EXEC spALTER_TABLE 'OportunidadPlantilla', 'MovOportunidad', 'varchar(20) NOT NULL DEFAULT ''OPORT'' WITH VALUES'
GO

EXEC spADD_UNIQUEINDEX 'OportunidadPlantilla', 'Plantila', 'Plantilla'
GO

EXEC spALTER_TABLE 'OportunidadPlantilla', 'PlantillaeMail', 'varchar(20) NULL DEFAULT ''GENERICA'' WITH VALUES'
GO

--REQ16092
/****** OportunidadPlantillaD ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaD') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaD', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaD') and type = 'U') 
  CREATE TABLE OportunidadPlantillaD(
    ID					int				NOT NULL,
    Renglon				float			NOT NULL,
    RenglonSub			int				NOT NULL,
    RenglonID			int				NOT NULL,

    Tipo				varchar(10)		NULL,
    Clave				varchar(50)		NOT NULL,
    Descripcion			varchar(100)	NULL,
    PorcentajeCierre	float			NULL,

    CONSTRAINT priOportunidadPlantillaD PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
    )
GO

EXEC spALTER_TABLE 'OportunidadPlantillaD', 'RenglonTipo', 'varchar(1) NULL'
EXEC spADD_UNIQUEINDEX 'OportunidadPlantillaD', 'Etapa', 'ID, Clave'
EXEC spALTER_TABLE 'OportunidadPlantillaD', 'RecursoOmision', 'varchar(10) NULL'

EXEC spRENAME_COLUMN 'OportunidadPlantillaD', 'PorcentajeCierre', 'PorcentajePonderado'
GO

--REQ16092
/****** OportunidadPlantillaDActividad ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaDActividad') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaDActividad', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaDActividad') and type = 'U') 
  CREATE TABLE OportunidadPlantillaDActividad(
    RID				int				IDENTITY(1,1), 
    
    ID				int				NOT NULL,  
    Etapa			varchar(50)		NOT NULL,
    Actividad		varchar(50)		NOT NULL,
  
    Titulo			varchar(100)    NULL,
    Recurso			varchar(10)     NULL,
    Email			varchar(50)     NULL,
    FechaEmision	datetime        NULL
  
    CONSTRAINT priOportunidadPlantillaDActividad PRIMARY KEY  CLUSTERED(RID)
    )
GO

EXEC spADD_UNIQUEINDEX 'OportunidadPlantillaDActividad', 'Actividad', 'ID, Etapa, Actividad'
GO

--REQ16092
/****** OportunidadPlantillaeMail ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaeMail') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaeMail', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaeMail') and type = 'U') 
  CREATE TABLE OportunidadPlantillaeMail(
    ID				int				IDENTITY(1,1),

    Plantilla			varchar(20)     NULL,
    FechaEmision		datetime        NULL,
    UltimoCambio		datetime        NULL,
    Usuario				varchar(10)     NULL,
    Estatus				varchar(15)     NULL,
    Comentarios			varchar(max)    NULL,
    Categoria			varchar(50)     NULL,
    Grupo				varchar(50)     NULL,
    Familia				varchar(50)     NULL,
    NivelAcceso			varchar(50)		NULL,
    
    CONSTRAINT priOportunidadPlantillaeMail PRIMARY KEY CLUSTERED (ID)
  )
GO

EXEC spADD_UNIQUEINDEX 'OportunidadPlantillaeMail', 'Plantila', 'Plantilla'
GO

EXEC spALTER_TABLE 'OportunidadPlantillaeMail', 'Asunto', 'varchar(max) NULL'
GO

--REQ16092
/****** OportunidadPlantillaeMailMensaje ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaeMailMensaje') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaeMailMensaje', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaeMailMensaje') and type = 'U') 
  CREATE TABLE OportunidadPlantillaeMailMensaje(
    ID					int				NOT NULL,

    Mensaje				varchar(max)	NULL,

    CONSTRAINT priOportunidadPlantillaeMailMensaje PRIMARY KEY  CLUSTERED (ID)
  )
GO

--REQ16092
/****** OportunidadTagAyuda ******/
if not exists (select * from SysTabla where SysTabla = 'OportunidadTagAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OportunidadTagAyuda','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadTagAyuda') and type = 'U') 
CREATE TABLE dbo.OportunidadTagAyuda (
	Tag					varchar(100) NOT NULL,
	
	Asunto				bit NULL,
	Mensaje				bit	NULL,
	Consulta			bit NULL,
	Condicion			bit NULL,
	Descripcion			varchar(255) NULL,
			
	CONSTRAINT priCRMTagAyuda PRIMARY KEY  CLUSTERED (Tag)
)
GO

--REQ16092
/* OportunidadAnexo */
if not exists(select * from SysTabla where SysTabla = 'OportunidadAnexo')
INSERT INTO SysTabla (SysTabla) VALUES ('OportunidadAnexo')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadAnexo') and type = 'U') 
CREATE TABLE dbo.OportunidadAnexo (
  Plantilla			varchar(20)		NOT NULL,
  RID				int				IDENTITY,
  Tipo				varchar(50)		NOT NULL DEFAULT 'Especifico',
  Ruta				varchar(255)	NULL,
  Nombre			varchar(255)	NULL,
  CONSTRAINT priOportunidadAnexo PRIMARY KEY CLUSTERED(Plantilla, RID)
  )
GO

--REQ16092
/****** OportunidadeMailEnviar ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadeMailEnviar') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadeMailEnviar', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadeMailEnviar') and type = 'U') 
  CREATE TABLE OportunidadeMailEnviar(
	RID					int			IDENTITY,
	Cliente				varchar(10),
	ID					int,
    EstacionTrabajo		int,
    Enviar				bit,
    CONSTRAINT priOportunidadeMailEnviar PRIMARY KEY CLUSTERED(RID)
    )
GO

EXEC spALTER_TABLE 'OportunidadeMailEnviar', 'ContactoTipo', 'varchar(20) NULL'
GO

--REQ16092
/****** OportunidadeMailHist ******/
if not exists (select * from SysTabla where SysTabla = 'OportunidadeMailHist') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OportunidadeMailHist','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadeMailHist') and type = 'U') 
CREATE TABLE dbo.OportunidadeMailHist (
	ID						int identity(1,1) NOT NULL,
	
	Fecha					datetime NULL,
	IntelisisServiceID		int NULL,
	
	Empresa					varchar(5) NULL,	
	ModuloID				varchar(20) NULL,
	Asunto					varchar(255) NULL,	
	Mensaje					varchar(max) NULL,
	Para					varchar(max) NULL,
	Anexos					varchar(max) NULL,
	
	CONSTRAINT priOportunidadeMailHist PRIMARY KEY  CLUSTERED (ID)
)
GO

EXEC spALTER_TABLE 'OportunidadeMailHist', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'OportunidadeMailHist', 'Contacto', 'varchar(10) NULL'
GO

--REQ16092
/****** OportunidadeMailUsuario ******/
if not exists (select * from SysTabla where SysTabla = 'OportunidadeMailUsuario') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OportunidadeMailUsuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadeMailUsuario') and type = 'U') 
CREATE TABLE dbo.OportunidadeMailUsuario (
    Usuario					varchar(10) NOT NULL,
	RID						int identity(1,1) NOT NULL,
	
	IntelisisServiceID		int NULL,	
	Empresa					varchar(5) NULL,	
	ModuloID				varchar(20) NULL,
	Fecha					datetime NULL,
	Asunto					varchar(255) NULL,	
	Mensaje					varchar(max) NULL,
	Para					varchar(max) NULL,
	Anexos					varchar(max) NULL,
	
	CONSTRAINT priOportunidadeMailUsuario PRIMARY KEY  CLUSTERED (Usuario, RID)
)
GO

EXEC spALTER_TABLE 'OportunidadeMailUsuario', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'OportunidadeMailUsuario', 'Contacto', 'varchar(10) NULL'
GO

--REQ16092
/****** OportunidadC ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadC') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadC') and type = 'U') 
  CREATE TABLE OportunidadC(
    ID				int			NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)	NULL,
	Mov 		    varchar(20) NULL,
	Serie			varchar(20)	NULL,
	Periodo			int			NULL,
	Ejercicio		int			NULL,

	Consecutivo 	int			NOT NULL DEFAULT 0,
	Sucursal		int			NOT NULL DEFAULT 0,

	CONSTRAINT priOportundidadC PRIMARY KEY  CLUSTERED (ID)
	)
GO

--BUG18836
DELETE SysTabla where SysTabla = 'OPORT'
GO
--REQ16092
/****** Oportunidad ******/
if not exists(select * from SysTabla where SysTabla = 'Oportunidad') 
  INSERT INTO SysTabla (SysTabla, Tipo, Modulo) VALUES ('Oportunidad', 'Movimiento', 'OPORT')
if not exists (select * from sysobjects where id = object_id('dbo.Oportunidad') and type = 'U') 
  CREATE TABLE Oportunidad (
    ID					int				IDENTITY(1,1),

    Empresa				varchar(5)		NOT NULL,
    Mov					varchar(20)     NOT NULL,
    MovID				varchar(20)     NULL,
    FechaEmision		datetime		NULL,
    UltimoCambio		datetime		NULL,

    Concepto			varchar(50)     NULL,
  
    Proyecto			varchar(50)     NULL,
    UEN					int             NULL,
    Moneda				varchar(10)		NULL,
    TipoCambio			float           NULL, 
    Usuario				varchar(10)		NULL,
    Autorizacion		varchar(10)     NULL,
    Referencia			varchar(50)     NULL,
    Observaciones		varchar(100)    NULL,
    Estatus				varchar(15)		NULL,
    Situacion			varchar(50)		NULL,
    SituacionFecha		datetime		NULL,
    SituacionUsuario	varchar(10)		NULL,
    SituacionNota		varchar(100)	NULL,
    OrigenTipo			varchar(10)		NULL,
    Origen				varchar(20)		NULL,
    OrigenID			varchar(20)		NULL,
    Poliza				varchar(20)		NULL,
    PolizaID			varchar(20)		NULL,
    GenerarPoliza		bit				NULL,
    ContID				int				NULL,
    Ejercicio			int             NULL, 
    Periodo				int             NULL,
    FechaRegistro		datetime		NULL,
    FechaConclusion		datetime		NULL,
    FechaCancelacion	datetime		NULL,
    Sucursal			int				NULL,
    SucursalOrigen		int				NULL,        
    SucursalDestino		int				NULL,    
    Agente				varchar(10)     NULL,
    SincroID			timestamp		NULL,
    SincroC				int				NULL,

    NivelInteres		varchar(50)		NULL,
    Plantilla			varchar(20)     NULL,
    ContactoTipo		varchar(20)     NULL,
    Contacto			varchar(10)     NULL,
    Comentarios			varchar(max)	NULL,
    ImporteAproximado	float			NULL,
    PorcentajeCierre	float			NULL,
    ImportePonderado	float			NULL,
    ProbCierre			float			NULL,
    Competidor			varchar(50)		NULL,
    Motivo				varchar(100)	NULL,
    Propuesta			int				NULL,

    Intermediario		varchar(10)     NULL,

    CONSTRAINT priOportunidad PRIMARY KEY  CLUSTERED (ID)
  )
GO

EXEC spALTER_TABLE 'Oportunidad', 'Almacen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Oportunidad', 'RenglonID', 'int NULL'
EXEC spALTER_TABLE 'Oportunidad', 'ListaPreciosEsp', 'varchar(20) NULL'

EXEC spALTER_TABLE 'Oportunidad', 'ServicioTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Oportunidad', 'ServicioContratoTipo', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'Oportunidad', 'Propuesta', 'varchar(50) NULL'

EXEC spALTER_TABLE 'Oportunidad', 'PosfechadoHasta', 'datetime NULL'
EXEC spALTER_TABLE 'Oportunidad', 'IDVTAS', 'int NULL'
EXEC spALTER_TABLE 'Oportunidad', 'Mensaje', 'int NULL'
EXEC spALTER_TABLE 'Oportunidad', 'Autorizacion', 'varchar(10) NULL'

EXEC spDROP_COLUMN 'Oportunidad', 'ImporteAproximado'
EXEC spALTER_TABLE 'Oportunidad', 'ImporteOportunidad', 'float NULL'
GO

--REQ16092
/****** OportunidadD ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadD') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadD', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadD') and type = 'U') 
  CREATE TABLE OportunidadD(
    RID					int				IDENTITY,

    ID					int				NULL,
    Renglon				float			NOT NULL,
    RenglonSub			int				NOT NULL,
    RenglonID			int				NOT NULL,

    Tipo				varchar(10)		NULL,
    Clave				varchar(50)		NULL,
    PorcentajeAvance	float			NULL,
    IDGestion			int				NULL,
    Comentarios			varchar(max)	NULL,
    RenglonTipo			varchar(1)		NULL,
  
   CONSTRAINT priOportunidadD PRIMARY KEY  CLUSTERED(RID)
   )
GO

EXEC spADD_INDEX 'OportunidadD', 'IDGestion', 'IDGestion'
GO
EXEC spADD_INDEX 'OportunidadD', 'PK', 'ID, Renglon, RenglonSub'
GO
EXEC spALTER_TABLE 'OportunidadD', 'Contacto', 'varchar(10) NULL'
GO
EXEC spALTER_COLUMN 'OportunidadD', 'Tipo', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'OportunidadD', 'CantidadPendiente', 'int NULL'
EXEC spALTER_TABLE 'OportunidadD', 'CantidadA', 'int NULL'
EXEC spALTER_TABLE 'OportunidadD', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'OportunidadD', 'FechaA', 'datetime NULL'
GO
EXEC spALTER_TABLE 'OportunidadD', 'Recurso', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'OportunidadD', 'Usuario', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'OportunidadD', 'Estado', 'varchar(30) NULL DEFAULT ''No Comenzada'' WITH VALUES'
GO
EXEC spALTER_TABLE 'OportunidadD', 'MovGestion', 'varchar(50) NULL'
GO

--REQ16092
/****** OportunidadDBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadDBitacora') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadDBitacora', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadDBitacora') and type = 'U') 
  CREATE TABLE OportunidadDBitacora(
    RID					int				IDENTITY,

    ID					int				NULL,
    Renglon				float			NOT NULL,
    RenglonSub			int				NOT NULL,
    RenglonID			int				NOT NULL,

    Tipo				varchar(10)		NULL,
    Clave				varchar(50)		NULL,
    PorcentajeAvance	float			NULL,
    IDGestion			int				NULL,
    Comentarios			varchar(max)	NULL,
    RenglonTipo			varchar(1)		NULL,
  
   CONSTRAINT priOportunidadDBitacora PRIMARY KEY  CLUSTERED(RID)
   )
GO

EXEC spADD_INDEX 'OportunidadDBitacora', 'IDGestion', 'IDGestion'
GO
EXEC spADD_INDEX 'OportunidadDBitacora', 'PK', 'ID, Renglon, RenglonSub'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'Contacto', 'varchar(10) NULL'
GO
EXEC spALTER_COLUMN 'OportunidadDBitacora', 'Tipo', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'CantidadPendiente', 'int NULL'
EXEC spALTER_TABLE 'OportunidadDBitacora', 'CantidadA', 'int NULL'
EXEC spALTER_TABLE 'OportunidadDBitacora', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'OportunidadDBitacora', 'FechaA', 'datetime NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'Recurso', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'Usuario', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'FechaCambio', 'datetime NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'Estado', 'varchar(30) NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'IDGestion', 'int NULL'
GO
EXEC spALTER_TABLE 'OportunidadDBitacora', 'MovGestion', 'varchar(50) NULL'
GO

--REQ16092
/****** OportunidadCompetencia ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadCompetencia') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadCompetencia', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadCompetencia') and type = 'U') 
  CREATE TABLE OportunidadCompetencia(
    RID				int			IDENTITY(1,1),
    ID				int			NOT NULL,

    Competidor		varchar(50)	NULL,
    NivelInteres	varchar(50)	NULL,
    ValorPropuesta  float		NULL,
    Moneda			varchar(10)	NULL,
    Comentarios		varchar(200)NULL,

    CONSTRAINT priOportunidadCompetencia PRIMARY KEY  CLUSTERED (RID)
    )
GO

--REQ16092
/****** OportunidadCat ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadCat') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadCat', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadCat') and type = 'U') 
  CREATE TABLE OportunidadCat(
    Categoria				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadCat PRIMARY KEY  CLUSTERED (Categoria)
  )
GO

--REQ16092
/****** OportunidadGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadGrupo') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadGrupo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadGrupo') and type = 'U') 
  CREATE TABLE OportunidadGrupo(
    Grupo				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadGrupo PRIMARY KEY CLUSTERED(Grupo)
  )
GO

--REQ16092
/****** OportunidadFam ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadFam') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadFam', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadFam') and type = 'U') 
  CREATE TABLE OportunidadFam(
    Familia				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadFam PRIMARY KEY CLUSTERED(Familia)
  )
GO

--REQ16092
/****** OportunidadPlantillaCat ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaCat') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaCat', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaCat') and type = 'U') 
  CREATE TABLE OportunidadPlantillaCat(
    Categoria				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadPlantillaCat PRIMARY KEY  CLUSTERED (Categoria)
  )
GO

--REQ16092
/****** OportunidadPlantillaGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaGrupo') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaGrupo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaGrupo') and type = 'U') 
  CREATE TABLE OportunidadPlantillaGrupo(
    Grupo				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadPlantillaGrupo PRIMARY KEY CLUSTERED(Grupo)
  )
GO

--REQ16092
/****** OportunidadPlantillaFam ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadPlantillaFam') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadPlantillaFam', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadPlantillaFam') and type = 'U') 
  CREATE TABLE OportunidadPlantillaFam(
    Familia				varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadPlantillaFam PRIMARY KEY CLUSTERED(Familia)
  )
GO

--REQ16092
/****** OportunidadNivelInteres ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadNivelInteres') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadNivelInteres', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadNivelInteres') and type = 'U') 
  CREATE TABLE OportunidadNivelInteres(
    NivelInteres			varchar(50)     NOT NULL,
  
    CONSTRAINT priOportunidadNivelInteres PRIMARY KEY CLUSTERED(NivelInteres)
  )
GO

--REQ16092
/****** OportunidadCompetidor ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadCompetidor') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadCompetidor', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadCompetidor') and type = 'U') 
  CREATE TABLE OportunidadCompetidor(
    Competidor			varchar(50)     NOT NULL,

    CONSTRAINT priOportunidadCompetidor PRIMARY KEY CLUSTERED (Competidor)
  )
GO

--REQ16092
/****** OportunidadInteresadoEn ******/
if not exists(select * from SysTabla where SysTabla = 'OportunidadInteresadoEn') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadInteresadoEn', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.OportunidadInteresadoEn') and type = 'U')
  CREATE TABLE OportunidadInteresadoEn(
    ID			int			NOT NULL,
    Renglon		float			NOT NULL,
    RenglonSub		int			NOT NULL,
    RenglonTipo		varchar(1)		NULL,
    RenglonID		int			NULL,
    Articulo		varchar(20)		NULL,  -- Bug 25103 Cambia el tamaño de 10 a 20.
        
    CONSTRAINT priOportunidadInteresadoEn PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
    )
GO

EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Cantidad', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'CantidadInventario', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Precio', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'PrecioSugerido', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Sucursal', 'int NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'SucursalOrigen', 'int NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'DescuentoLinea', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'DescuentoImporte', 'int NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'FechaRequerida', 'datetime NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'HoraRequerida', 'varchar(5) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Espacio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Almacen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'PoliticaPrecios', 'varchar(255) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'PrecioMoneda', 'varchar(10) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'PrecioTipoCambio', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'DescuentoTipo', 'char(1) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'Factor', 'float NULL'
EXEC spALTER_TABLE 'OportunidadInteresadoEn', 'CompraRequerida', 'bit NULL'
GO


/****** ProyectoInteresadoEn ******/
if not exists(select * from SysTabla where SysTabla = 'ProyectoInteresadoEn') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProyectoInteresadoEn', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.ProyectoInteresadoEn') and type = 'U')
  CREATE TABLE ProyectoInteresadoEn(
    ID					int			 NOT NULL,
    Renglon				float		 NOT NULL,
    RenglonSub			int			 NOT NULL,
    RenglonTipo			varchar(1)	 NULL,
    RenglonID			int			 NULL,
    Articulo			varchar(20)	 NULL, 
	Cantidad			float		 NULL,
	CantidadInventario  float        NULL,
	SubCuenta			varchar(50)  NULL,
	Precio              float		 NULL,
	PrecioSugerido      float		 NULL,
	Sucursal            int          NULL,
	SucursalOrigen      int			 NULL,
	UEN                 int			 NULL,
	DescuentoLinea		float		 NULL,
	DescuentoImporte    int			 NULL,
	FechaRequerida      datetime	 NULL,
	HoraRequerida       varchar(5)	 NULL,
	Espacio				varchar(10)  NULL,
	Almacen				varchar(10)  NULL,
	PoliticaPrecios		varchar(255) NULL,
	PrecioMoneda		varchar(10)  NULL,
	PrecioTipoCambio	float        NULL,
	DescuentoTipo		char(1)		 NULL,
	Unidad				varchar(50)  NULL,
	Factor				float		 NULL,
	CompraRequerida		bit			 NULL
        
    CONSTRAINT priProyectoInteresadoEn PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
    )
GO

-- Bug 25103
/********************************/
DECLARE
  @LongEnTabla int

SELECT @LongEnTabla = sc.max_length 
  FROM sys.objects so 
       INNER JOIN sys.columns sc ON so.object_id = sc.object_id 
       INNER JOIN sys.types st ON st.system_type_id = sc.system_type_id AND st.name != 'sysname'
 WHERE so.type = 'U' 
   and so.name = 'OportunidadInteresadoEn'
   and sc.name = 'Articulo'

IF @LongEnTabla <> 20 
  ALTER TABLE OportunidadInteresadoEn ALTER COLUMN Articulo varchar(20)
GO
/********************************/

--REQ16092
/**************** OportunidadMotivo ****************/
if not exists(select * from SysTabla where SysTabla = 'OportunidadMotivo') 
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OportunidadMotivo', 'Maestro')
if not exists(select * from sysobjects where name = 'OportunidadMotivo' and type = 'u')
  CREATE TABLE OportunidadMotivo(
    Motivo		varchar(100),
    
    CONSTRAINT priOportunidadMotivo PRIMARY KEY CLUSTERED(Motivo)
    )
GO

if exists (select * from sysobjects where id = object_id('dbo.cOportunidadCompetencia') and sysstat & 0xf = 2) drop view dbo.cOportunidadCompetencia
GO
CREATE VIEW cOportunidadCompetencia
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Competidor,
  NivelInteres,
  ValorPropuesta,
  Moneda,
  Comentarios

FROM
  OportunidadCompetencia
GO

if exists (select * from sysobjects where id = object_id('dbo.cOportunidadInteresadoEn') and sysstat & 0xf = 2) drop view dbo.cOportunidadInteresadoEn
GO
CREATE VIEW cOportunidadInteresadoEn
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,
  RenglonTipo,
  RenglonID,
  Articulo,
  Cantidad,
  SubCuenta,
  Precio,
  Sucursal,
  SucursalOrigen,
  UEN,
  DescuentoLinea,
  DescuentoImporte,
  FechaRequerida,
  HoraRequerida,
  Espacio,
  Almacen,
  PrecioMoneda,
  PrecioTipoCambio,
  PoliticaPrecios,
  DescuentoTipo,
  PrecioSugerido,
  Unidad,
  Factor,
  CantidadInventario  

FROM
  OportunidadInteresadoEn
GO


if exists (select * from sysobjects where id = object_id('dbo.cOportunidadD') and sysstat & 0xf = 2) drop view dbo.cOportunidadD
GO
CREATE VIEW cOportunidadD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,
  RenglonID,
  Tipo,
  RenglonTipo,
  Contacto
  
FROM
  OportunidadD
GO

--REQ16092
/**************** tgOportunidadC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgOportunidadC') and sysstat & 0xf = 8) drop trigger dbo.tgOportunidadC
GO
CREATE TRIGGER tgOportunidadC ON Oportunidad
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Ok			int,
    @Modulo		varchar(5),
    @Mov		varchar(20),
    @MovIDN		varchar(20),
    @MovIDA		varchar(20),
    @Empresa		varchar(5),
    @Sucursal		int,
    @ID			int,
    @FechaInicio	datetime,
    @Ahora 		datetime,
    @FechaAnterior	datetime,
    @EstatusNuevo 	varchar(15),
    @EstatusAnterior 	varchar(15),
    @SituacionNueva 	varchar(50),
    @SituacionAnterior 	varchar(50),
    @UsuarioA		varchar(10),
    @UsuarioN		varchar(10),
    @Mensaje		varchar(255),
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Modulo = 'OPORT', @Ok = NULL  
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), ''), @UsuarioA = Usuario, @MovIDA = NULLIF(RTRIM(MovID), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @Empresa = Empresa, @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @MovIDN = NULLIF(RTRIM(MovID), ''), @UsuarioN = Usuario FROM Inserted

  IF @MovIDN IS NULL AND @MovIDA IS NOT NULL AND @UsuarioN <> @UsuarioA
    SELECT @Ok = 30015

  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PROCESAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PROCESAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PROCESAR', 'PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
    SELECT @Ok = 60090

  IF @Ok IS NOT NULL 
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    SELECT @Mensaje = RTRIM(@Mensaje) + ' '+RTRIM(@Mov)+' '+RTRIM(@MovIDN)
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

      INSERT INTO MovTiempo (Modulo,  Sucursal,  ID,  Usuario,                               FechaInicio,  FechaComenzo, Estatus,       Situacion) 
                     VALUES (@Modulo, @Sucursal, @ID, ISNULL(@AfectacionUsuario, @UsuarioN), @FechaInicio, @Ahora,       @EstatusNuevo, @SituacionNueva)
    END
  END

  EXEC spMovAlActualizar @Modulo, @ID, @Mov, @EstatusNuevo, @EstatusAnterior, @SituacionNueva, @SituacionAnterior
END
GO

--REQ16092
/**************** tgOportunidadD ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgOportunidadD') and sysstat & 0xf = 8) drop trigger dbo.tgOportunidadD
GO
CREATE TRIGGER tgOportunidadD ON OportunidadD
--//WITH ENCRYPTION
FOR UPDATE
AS
BEGIN
  DECLARE @FechaCambio	datetime,
		  @ID			int,
		  @IDAnt		int,
		  @Renglon		float,
		  @RenglonAnt	float,
		  @RID			int
  
  SELECT @FechaCambio = GETDATE()
  
  EXEC spExtraerFecha @FechaCambio OUTPUT

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM Inserted
     WHERE ID > @IDAnt

    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @RenglonAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @Renglon = MIN(Renglon)
        FROM Inserted
       WHERE ID = @ID
         AND Renglon > @RenglonAnt

      IF @Renglon IS NULL BREAK
    
      SELECT @RenglonAnt = @Renglon
      
      SELECT @RID = MAX(RID) FROM OportunidadDBitacora WHERE ID = @ID AND Renglon = @Renglon

      IF @RID IS NOT NULL
        INSERT INTO OportunidadDBitacora(
		           ID,   Renglon,   RenglonSub,   RenglonID,   Tipo,   Clave,   PorcentajeAvance,   IDGestion,   Comentarios,   RenglonTipo,   Contacto,   CantidadPendiente,   CantidadA,   Fecha,   Recurso,   Usuario,  FechaCambio,   Estado,  FechaA,    MovGestion)
	      SELECT i.ID, i.Renglon, i.RenglonSub, i.RenglonID, i.Tipo, i.Clave, i.PorcentajeAvance, i.IDGestion, i.Comentarios, i.RenglonTipo, i.Contacto, i.CantidadPendiente, i.CantidadA, i.Fecha, i.Recurso, i.Usuario, @FechaCambio, i.Estado, i.FechaA, i.MovGestion
       	    FROM Inserted i 
   	        JOIN OportunidadDBitacora d ON i.ID = d.ID AND i.Renglon = d.Renglon AND i.RenglonSub = d.RenglonSub
     	   WHERE d.RID = @RID
     	     AND i.ID = @ID
     	     AND d.Renglon = @Renglon
     	     AND ((ISNULL(i.PorcentajeAvance, 0) <> ISNULL(d.PorcentajeAvance, 0))
     	      OR (ISNULL(i.Comentarios, '') <> ISNULL(d.Comentarios, ''))
     	      OR (ISNULL(i.Fecha, '') <> ISNULL(d.Fecha, ''))
     	      OR (ISNULL(i.FechaA, '') <> ISNULL(d.FechaA, ''))     	      
     	      OR (ISNULL(i.Recurso, '') <> ISNULL(d.Recurso, ''))
     	      OR (ISNULL(i.Estado, '')  <> ISNULL(d.Estado, ''))
     	      OR (ISNULL(i.MovGestion, '')  <> ISNULL(d.MovGestion, '')))
     	      
      ELSE
        INSERT INTO OportunidadDBitacora(
		           ID,   Renglon,   RenglonSub,   RenglonID,   Tipo,   Clave,   PorcentajeAvance,   IDGestion,   Comentarios,   RenglonTipo,   Contacto,   CantidadPendiente,   CantidadA,   Fecha,   Recurso,   Usuario,  FechaCambio,   Estado,  FechaA,    MovGestion)
	      SELECT i.ID, i.Renglon, i.RenglonSub, i.RenglonID, i.Tipo, i.Clave, i.PorcentajeAvance, i.IDGestion, i.Comentarios, i.RenglonTipo, i.Contacto, i.CantidadPendiente, i.CantidadA, i.Fecha, i.Recurso, i.Usuario, @FechaCambio, i.Estado, i.FechaA, i.MovGestion
       	    FROM Inserted i 
     	   WHERE i.ID = @ID
     	     AND i.Renglon = @Renglon
    END
  END

  RETURN
END
GO

--REQ16092
/**************** fnOportunidadAvance ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnOportunidadAvance') DROP FUNCTION fnOportunidadAvance
GO
CREATE FUNCTION fnOportunidadAvance(
				@ID			int
				)
RETURNS float
AS
BEGIN
  DECLARE @Avance				float,
		  @PorcentajePonderado	float
  
  DECLARE @Actividades TABLE(
    Tipo				varchar(20) COLLATE DATABASE_DEFAULT NULL,
	Clave				varchar(50) COLLATE DATABASE_DEFAULT NULL,
    PorcentajePonderado	float		NULL,
    PorcentajeAvance	float		NULL,
    Avance				float		NULL
    )

  INSERT INTO @Actividades(
			  Tipo, Clave,   PorcentajePonderado,               PorcentajeAvance)
     SELECT d.Tipo, d.Clave, ISNULL(pd.PorcentajePonderado, 0), ISNULL(d.PorcentajeAvance, 0)
       FROM OportunidadD d
       JOIN Oportunidad c ON d.ID = c.ID
       JOIN OportunidadPlantilla p ON p.Plantilla = c.Plantilla
       JOIN OportunidadPlantillaD pd ON p.ID = pd.ID AND pd.Tipo = d.Tipo AND pd.Clave = d.Clave
      WHERE c.ID = @ID

  SELECT @PorcentajePonderado = SUM(PorcentajePonderado) FROM @Actividades
  
  SELECT @PorcentajePonderado = 100.0 - ISNULL(@PorcentajePonderado, 0)
  
  UPDATE @Actividades
     SET Avance = PorcentajeAvance*(PorcentajePonderado/100.0)

  SELECT @Avance = SUM(Avance) + ISNULL(@PorcentajePonderado, 0) FROM @Actividades

  RETURN @Avance
END
GO