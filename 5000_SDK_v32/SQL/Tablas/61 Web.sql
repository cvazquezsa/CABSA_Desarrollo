

/*** WebPaginaCat ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaCat') and type = 'U') 
CREATE TABLE dbo.WebPaginaCat (
	Categoria	varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebPaginaCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/*** WebPaginaGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaGrupo') and type = 'U') 
CREATE TABLE dbo.WebPaginaGrupo (
	Grupo		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebPaginaGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/*** WebPaginaFam ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaFam') and type = 'U') 
CREATE TABLE dbo.WebPaginaFam (
	Familia		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebPaginaFam PRIMARY KEY  CLUSTERED (Familia)
)
GO

-- drop table WebSitioDocCat
/*** WebSitioDocCat ***/
if not exists(select * from SysTabla where SysTabla = 'WebSitioDocCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitioDocCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitioDocCat') and type = 'U') 
CREATE TABLE dbo.WebSitioDocCat (
	Categoria	varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebSitioDocCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

-- drop table WebSitioDocGrupo
/*** WebSitioDocGrupo ***/
if not exists(select * from SysTabla where SysTabla = 'WebSitioDocGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitioDocGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitioDocGrupo') and type = 'U') 
CREATE TABLE dbo.WebSitioDocGrupo (
	Grupo		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebSitioDocGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

-- drop table WebSitioDocFam
/*** WebSitioDocFam ***/
if not exists(select * from SysTabla where SysTabla = 'WebSitioDocFam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitioDocFam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitioDocFam') and type = 'U') 
CREATE TABLE dbo.WebSitioDocFam (
	Familia		varchar(50)	NOT NULL,
	Icono		int		NULL,

	CONSTRAINT priWebSitioDocFam PRIMARY KEY  CLUSTERED (Familia)
)
GO

EXEC spDROP_TABLE 'WebSitio', 3040
GO
-- drop table WebSitio
-- select * from webpagina
/****** WebSitio ******/
if not exists(select * from SysTabla where SysTabla = 'WebSitio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitio','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitio') and type = 'U') 
CREATE TABLE dbo.WebSitio (
	Sitio	 		varchar(20)  	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,

	Estatus 		varchar(15) 	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
        NivelAcceso		varchar(50)	NULL,
	Usuario			varchar(10)	NULL,

	Estilo			varchar(50)	NULL,
	PaginaInicio		varchar(20)	NULL,

	PuedeBuscar		bit		NULL	DEFAULT 0,

	EncabezadoHTML		text		NULL,
	PieHTML			text		NULL,

	MenuPosicion		varchar(20)	NULL,	-- Titulo, Cuerpo, Pie
	MenuPosicionNivelDetalle bit		NULL	DEFAULT 0,	
	MenuFondoColor		varchar(50)	NULL,

	URL_Sitio		varchar(255)	NULL,
	URL_Documentos		varchar(255)	NULL,
	RutaDocumentos		varchar(255)	NULL,
	BotonAcceso		bit		NULL	DEFAULT 0,	
	LeyendaAcceso		varchar(50)	NULL,

	VerExplorador		bit		NULL	DEFAULT 0,	
	VerCalendario		bit		NULL	DEFAULT 0,	
	PaginaCalendario	varchar(20)	NULL,

	CONSTRAINT priWebSitio PRIMARY KEY  CLUSTERED (Sitio)
)
go
EXEC spADD_INDEX 'WebSitio', 'Nombre', 'Nombre'
GO
EXEC spALTER_TABLE 'WebSitio', 'MenuFondoColor', 'varchar(50) NULL'
EXEC spDROP_COLUMN 'WebSitio', 'URL_Imagenes'
GO
EXEC spALTER_TABLE 'WebSitio', 'URL_Documentos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'WebSitio', 'RutaDocumentos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'WebSitio', 'BotonAcceso', 'bit NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'LeyendaAcceso', 'varchar(50) NULL DEFAULT "Ingresar" WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'VerExplorador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'VerCalendario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'PaginaCalendario', 'varchar(20)	NULL'
GO
EXEC spALTER_TABLE 'WebSitio', 'VerBotonPerfil', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'WebSitio', 'LeyendaBotonPerfil',  'varchar(40) NULL'
EXEC spALTER_TABLE 'WebSitio', 'IniciaPaginaPerfil', 'bit NULL DEFAULT 0'
GO

EXEC spALTER_TABLE 'WebSitio', 'OlvidoClave', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'PaginaOlvidoClave', 'varchar(20) NULL'
GO

EXEC spDROP_TABLE 'WebSitioD', 3025
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		17-Abr-2008
EXEC spALTER_TABLE 'WebSitio', 'AnchoMenuEncabezado', 'smallint null default 0'
EXEC spALTER_TABLE 'WebSitio', 'AnchoMenuCuerpo', 'smallint null default 0'
EXEC spALTER_TABLE 'WebSitio', 'AnchoMenuPie', 'smallint null default 0'
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		27-May-2009
EXEC spALTER_TABLE 'WebSitio', 'VerBienvenida',' bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'LeyendaBienvenida',' varchar(50) NULL' 

EXEC spALTER_TABLE 'WebSitio', 'VerSPinformacion',' bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'SPinformacion',' varchar(50) NULL' 

EXEC spALTER_TABLE 'WebSitio', 'spOrigen',' bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'spPagina',' bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'WebSitio', 'spSesion',' bit not null Default 0 WITH VALUES'
GO

/****** WebSitioD ******/
if not exists(select * from SysTabla where SysTabla = 'WebSitioD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitioD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitioD') and type = 'U') 
CREATE TABLE dbo.WebSitioD (
	Sitio	 		varchar(20)  	NOT NULL,
	Referencia		varchar(50)	NOT NULL,
	EsGrupo			bit		NULL	DEFAULT 0,
	MenuPosicion		varchar(20)	NULL,		-- Titulo, Cuerpo, Pie

	Orden			varchar(255)	NULL,
	Pagina			varchar(20)	NULL,
	Nombre			varchar(100)	NULL,

	CONSTRAINT priWebSitioD PRIMARY KEY  CLUSTERED (Sitio, Referencia)
)
go
-- drop table WebSitioDoc
/****** WebSitioDoc ******/
if not exists(select * from SysTabla where SysTabla = 'WebSitioDoc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSitioDoc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebSitioDoc') and type = 'U') 
CREATE TABLE dbo.WebSitioDoc (
	Sitio			varchar(20)	NOT NULL,
	Documento		varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Categoria		varchar(50)	NULL,
	Grupo			varchar(50)	NULL,
	Familia			varchar(50)	NULL,
	Alta			datetime	NULL,
	UltimoCambio		datetime	NULL,
	Archivo			varchar(255)	NULL,

	CONSTRAINT priWebSitioDoc PRIMARY KEY  CLUSTERED (Sitio, Documento)
)
go
EXEC spADD_INDEX 'WebSitioDoc', 'Nombre', 'Nombre'
GO

--EXEC spDrop_Constraint 'WebUsuario','PuntosAcumulados'
--GO

--ALTER TABLE WebSitioDoc ALTER COLUMN Sitio varchar(50) NOT NULL 
--GO
--ALTER TABLE WebSitioDoc ALTER COLUMN Sitio varchar(20) NOT NULL 
--GO

ALTER TABLE WebSitioDoc ALTER COLUMN Documento varchar(50) NOT NULL 
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebSitioBC') and sysstat & 0xf = 8) drop trigger dbo.tgWebSitioBC
GO
CREATE TRIGGER tgWebSitioBC ON WebSitio
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @SitioA	varchar(20),
    @SitioN	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @SitioA = Sitio FROM Deleted
  SELECT @SitioN = Sitio FROM Inserted

  IF @SitioA = @SitioN RETURN
  
  IF @SitioN IS NULL
  BEGIN
    DELETE WebSitioD   WHERE Sitio = @SitioA
    DELETE WebSitioDoc WHERE Sitio = @SitioA
  END ELSE
  BEGIN
    UPDATE WebSitioD   SET Sitio = @SitioN WHERE Sitio = @SitioA
    UPDATE WebSitioDoc SET Sitio = @SitioN WHERE Sitio = @SitioA
    UPDATE WebPagina   SET Sitio = @SitioN WHERE Sitio = @SitioA
  END
END
GO

EXEC spDROP_TABLE 'WebPagina', 3042
GO


-- drop table WebPagina
/****** WebPagina ******/
if not exists(select * from SysTabla where SysTabla = 'WebPagina')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPagina','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.WebPagina') and type = 'U') 
CREATE TABLE dbo.WebPagina (
	Pagina				varchar(20)	NOT NULL,

	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	Tipo				varchar(20)	NULL,		-- HTML, URL, Sitio, Reporte
	Categoria			varchar(50)	NULL,
	Grupo				varchar(50)	NULL,
	Familia				varchar(50)	NULL,
	HTML				text		NULL,
	URL				varchar(255)	NULL,
	Sitio				varchar(20)	NULL,

	Estatus 			varchar(15) 	NULL,
	UltimoCambio 			datetime  	NULL,
	Alta				datetime	NULL,
        NivelAcceso			varchar(50)	NULL,
	Usuario				varchar(10)	NULL,

	RequiereAcceso			bit		NULL	DEFAULT 0,	-- no se ejecuta si no esta logeado
	ControlAcceso			bit		NULL	DEFAULT 0,	-- ni siquiera aparece en el menu
	TieneParametros			bit		NULL	DEFAULT 0,
	TipoParametros			varchar(20)	NULL,			-- Forma Previa, Dinamicos

	BlogPermiteCalificar		bit		NULL	DEFAULT 0,
	BlogCalificacionTipo		varchar(50)	NULL,
	
	PermiteBuscar			bit		NULL	DEFAULT 0,
	PermiteFiltrar			bit		NULL	DEFAULT 0,
	PermiteOrdenar			bit		NULL	DEFAULT 0,
	PermiteSeleccionar		bit		NULL	DEFAULT 0,
	PermiteSeleccionarMultiple	bit		NULL	DEFAULT 0,
	PermiteAgrupar			bit		NULL	DEFAULT 0,
	RegistrosPagina			int		NULL,
	EnviarPDF			bit		NULL	DEFAULT 0,
	EnviarXLS			bit		NULL	DEFAULT 0,
	EnviarRTF			bit		NULL	DEFAULT 0,

	sp				varchar(100)	NULL,
	spSesionID			bit		NULL	DEFAULT 0,
	spOrigen			bit		NULL	DEFAULT 0,
	spPagina			bit		NULL	DEFAULT 0,

	PermiteInsertar			bit		NULL	DEFAULT 0,
	PermiteEliminar			bit		NULL	DEFAULT 0,
	PermiteActualizar		bit		NULL	DEFAULT 0,
	BotonProcesar			bit		NULL	DEFAULT 0,

	CampoNombre			varchar(100)	NULL,
	CampoValor			varchar(100)	NULL,
	MostrarValores			bit		NULL	DEFAULT 0,
	CampoLatitud			varchar(100)	NULL,
	CampoLongitud			varchar(100)	NULL,
	CampoDescripcion		varchar(100)	NULL,

	TieneDetalle			bit		NULL	DEFAULT 0,
	PaginaDetalle			varchar(20)	NULL,
	CampoLlave			varchar(100)	NULL,
	LlaveVisible			bit		NULL	DEFAULT 0,

	GraficaTipo			varchar(50)	NULL,
	CampoSerie			varchar(100)	NULL,

	CampanaTipo			varchar(50)	NULL,

	Vistas				bit		NULL	DEFAULT 0,
	TablaVista			varchar(100)	NULL,

	BuscarNombres			bit		NULL	DEFAULT 0,
	BuscarDescripciones		bit		NULL	DEFAULT 0,
	BuscarHTML			bit		NULL	DEFAULT 0,
	BuscarOtrosSitios		bit		NULL	DEFAULT 0,

	Cubo				varchar(100)	NULL,

	CapturaIrA			varchar(20)	NULL,
	ModoVentana			bit		NULL	DEFAULT 0,

	PermiteCrearVistas		bit		NULL	DEFAULT 0,
	PermiteEliminarVistas		bit		NULL	DEFAULT 0,

	Servidor			varchar(100)	NULL,
	BaseDatos			varchar(100)	NULL,
	
	CONSTRAINT priWebPagina PRIMARY KEY  CLUSTERED (Pagina)
)
go
EXEC spALTER_TABLE 'WebPagina', 'RequiereAcceso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'TieneParametros', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteBuscar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteFiltrar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteOrdenar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteSeleccionar', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteSeleccionarMultiple', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteAgrupar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'RegistrosPagina', 'int NULL'
EXEC spALTER_TABLE 'WebPagina', 'sp', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'spSesionID', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spPagina', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'EnviarPDF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'EnviarXLS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'EnviarRTF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteInsertar', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteEliminar', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteActualizar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'BotonProcesar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'TipoParametros', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'TieneDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PaginaDetalle', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoLlave', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'LlaveVisible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CampoNombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoValor', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'MostrarValores', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CampoLatitud', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoLongitud', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoDescripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'GraficaTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampanaTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoSerie', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'Vistas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'TablaVista', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'BuscarNombres', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'BuscarDescripciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'BuscarHTML', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'BuscarOtrosSitios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'Cubo', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CapturaIrA', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ModoVentana', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteCrearVistas', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteEliminarVistas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'Servidor', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'BaseDatos', 'varchar(100) NULL'
GO

EXEC spALTER_TABLE 'WebPagina', 'AdminPagina', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'UsuarioAdminPagina', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'RequiereAutorizacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CreaArticulo', 'char(14) NULL' -- La nomenclatura seria: A(Anonimo),M(Administrador o Manager),T(Todos),N (Ninguno)
EXEC spALTER_TABLE 'WebPagina', 'MostrarTituloArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'MostrarDescripArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirSubArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CreaSubArticulo', 'char(14) NULL' -- La nomenclatura seria: A(Anonimo),M(Administrador o Manager),T(Todos),N (Ninguno)
EXEC spALTER_TABLE 'WebPagina', 'MostrarTituloSubArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'MostrarDescripcionSubArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirComentario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CreaComentario',  'char(14) NULL'
EXEC spALTER_TABLE 'WebPagina', 'MostrarTituloComentario',  'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'MostrarDescripcionComentario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'CobrarComentario',   'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermiteHistorico',  'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'ValorMinimoPorCobrar', 'varchar(10) NULL'
GO

EXEC spALTER_TABLE 'WebPagina', 'CampoAsunto', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoUbicacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoComienzo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoFin', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoTodoElDia', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoTipoEvento', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CampoComentario', 'varchar(30) NULL'
GO

EXEC spALTER_TABLE 'WebPagina', 'spValorXOmision', 'varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'spSesionIDValorXOmision', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spOrigenValorXOmision', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spPaginaValorXOmision', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'WebPagina', 'CampoID', 'varchar(30) NULL'
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		22-Dic-2008
EXEC spALTER_TABLE 'WebPagina', 'VerBuscar', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'WebPagina', 'VerSuscripcion', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'WebPagina', 'VerEnviarCorreo', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'WebPagina', 'VerNubeInformacion', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'WebPagina', 'VerPostRecientes', 'bit NULL DEFAULT 0'
GO
/******************************************/

EXEC spADD_INDEX 'WebPagina', 'Nombre', 'Nombre'
GO

EXEC spALTER_TABLE 'WebPagina', 'VerCodigoSeguridad', 'bit NULL DEFAULT 0'
GO

EXEC spALTER_TABLE 'WebPagina', 'PermiteCalificar', 'bit NULL DEFAULT 0'
GO

ALTER TABLE WebPagina ALTER COLUMN AdminPagina varchar(50) NULL 
GO
/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		17-Abr-2008

EXEC spALTER_TABLE 'WebPagina', 'Icono', 'varchar(50) null '
GO
ALTER TABLE webpagina ALTER COLUMN Icono VARCHAR(250)
GO
EXEC spALTER_TABLE 'Webpagina', 'TipoAyudaCategoriaArticulo', 'varchar(10) Default "Manual" WITH VALUES'
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		7-May-2009
EXEC spALTER_TABLE 'Webpagina', 'CatalogoRama', 'bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'Webpagina', 'CatalogoClasificacion', 'bit not null Default 0 WITH VALUES'
EXEC spALTER_TABLE 'Webpagina', 'TipoClasificacion', 'varchar(50) null'
EXEC spALTER_TABLE 'Webpagina', 'CatalogoSP', 'bit not null Default 0 WITH VALUES'
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		26-May-2009
EXEC spALTER_TABLE 'Webpagina', 'Banco', 'varchar(20) null'
GO
/******************************************/
if not exists (select * from sysobjects where id = object_id('WebPaginaComunidadCat') and type = 'U') 
CREATE TABLE WebPaginaComunidadCat(
	[ComunidadCatID] [smallint] IDENTITY(1,1) NOT NULL,
	[Categoria] [varchar](50) NULL,
	Pagina [varchar](20) NULL
 CONSTRAINT [PK_WebPaginaComunidadCat] PRIMARY KEY CLUSTERED 
(
	[ComunidadCatID] ASC
))
GO

if exists (select * from sysobjects where id = object_id('dbo.SPWebPaginaComunidadCargarCategorias') and type = 'P') 
	drop procedure dbo.SPWebPaginaComunidadCargarCategorias
GO
CREATE PROCEDURE SPWebPaginaComunidadCargarCategorias
	--@SesionID     Uniqueidentifier = null,
	@Origen       varchar(255) = null,
	@Pagina       Varchar(20) = null
--//WITH ENCRYPTION   
AS BEGIN  
 IF UPPER(@Origen)='MANUAL'
	SELECT DISTINCT Categoria FROM WebArticulo WHERE     (Categoria IS NOT NULL) AND (Categoria <> '')
 IF UPPER(@Origen)='LISTA'
    SELECT DISTINCT Categoria FROM WebPaginaComunidadCat WHERE pagina=@Pagina
end
GO
/******************************************/

/**************** xpWebPaginaParcear ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpWebPaginaParcear') and sysstat & 0xf = 4) drop procedure dbo.xpWebPaginaParcear
GO
CREATE PROCEDURE xpWebPaginaParcear
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),

			@Nombre		varchar(255)	OUTPUT,
			@Descripcion	varchar(255)	OUTPUT,
			@HTML		varchar(max)	OUTPUT,
			@URL		varchar(255)	OUTPUT,

			@CampanaID	int,
			@CampanaRID	int,		

			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO


/**************** spWebPaginaParcear ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaParcear') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaParcear
GO
CREATE PROCEDURE spWebPaginaParcear
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),

			@Nombre		varchar(255)	OUTPUT,
			@Descripcion	varchar(255)	OUTPUT,
			@HTML		varchar(max)	OUTPUT,
			@URL		varchar(255)	OUTPUT,

			@CampanaID	int,
			@CampanaRID	int,		

			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  EXEC xpWebPaginaParcear @SesionID, @Origen, @Pagina, @Nombre, @Descripcion, @HTML, @URL, @CampanaID, @CampanaRID, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO


/**************** spWebPagina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPagina') and sysstat & 0xf = 4) drop procedure dbo.spWebPagina
GO
CREATE PROCEDURE spWebPagina
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nombre	 varchar(100),
    @Descripcion varchar(255),
    @HTML	 varchar(max),
    @URL	 varchar(255),
    @Ok		 int,
    @OkRef	 varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL, @Mensaje = NULL
  SELECT @Nombre = Nombre, @Descripcion = Descripcion, @HTML = CONVERT(varchar(max), HTML), @URL = URL
    FROM WebPagina
   WHERE Pagina = @Pagina

  EXEC spWebPaginaParcear @SesionID, @Origen, @Pagina, @Nombre OUTPUT, @Descripcion OUTPUT, @HTML OUTPUT, @URL OUTPUT, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
  SELECT 'Nombre' = @Nombre, 'Descripcion' = @Descripcion, 'HTML' = @HTML, 'URL' = @URL
  RETURN
END
GO


-- drop table WebPaginaParamGrupo
/****** WebPaginaParamGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaParamGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaParamGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaParamGrupo') and type = 'U') 
CREATE TABLE dbo.WebPaginaParamGrupo (
	Pagina			varchar(20)	NOT NULL,
	Grupo			varchar(50)	NOT NULL,

	Orden			int		NULL,

	CONSTRAINT priWebPaginaParamGrupo PRIMARY KEY  CLUSTERED (Pagina, Grupo)
)
go


-- drop table WebPaginaParam
/****** WebPaginaParam ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaParam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaParam','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaParam') and type = 'U') 
CREATE TABLE dbo.WebPaginaParam (
	Pagina			varchar(20)	NOT NULL,
	Parametro		varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,
	TipoDatos		varchar(20)	NULL,
	Tamano			int		NULL,
	EsContrasena		bit		NULL	DEFAULT 0,
	EsMayusculas		bit		NULL	DEFAULT 0,
	EsRequerido		bit		NULL	DEFAULT 0,
	ValorPorOmision		varchar(255)	NULL,
	TipoAyuda		varchar(20)	NULL,	-- No, Tabla, Lista
	AyudaTabla		varchar(100)	NULL,
	AyudaValor		varchar(100)	NULL,
	AyudaNombre		varchar(100)	NULL,
	AyudaCondicion		varchar(255)	NULL,
	AyudaOrden		varchar(255)	NULL,
	Orden			int		NULL,
	EspacioPrevio		bit		NULL	DEFAULT 0,
	Grupo			varchar(50)	NULL,

	CONSTRAINT priWebPaginaParam PRIMARY KEY  CLUSTERED (Pagina, Parametro)
)
go

EXEC spALTER_TABLE 'WebPaginaParam', 'EsSoloLectura', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPaginaParam', 'EsOculto', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'Webpaginaparam', 'ColorEtiqueta', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Webpaginaparam', 'FondoEtiqueta', 'varchar(10) NULL'
GO


/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		26-May-2009
EXEC spALTER_TABLE 'WebPaginaParam', 'GrupoRepeticion', 'varchar(50) null '
EXEC spALTER_TABLE 'WebPaginaParam', 'RepeticionLlave', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPaginaParam', 'Refrescar', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPaginaParam', 'DependeDe', 'varchar(50) null '
GO
/**************** spWebPaginaParam ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaParam') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaParam
GO
CREATE PROCEDURE spWebPaginaParam
			@SesionID	uniqueidentifier,
			@Pagina		varchar(20),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  SELECT p.*
    FROM WebPaginaParam p
    LEFT OUTER JOIN WebPaginaParamGrupo g ON g.Pagina = p.Pagina AND g.Grupo = p.Grupo
   WHERE p.Pagina = @Pagina
   ORDER BY g.Orden, p.Orden
  RETURN
END
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		26-May-2009
if not exists (select * from sysobjects where id = object_id('WebPaginaParamRepeticion') and type = 'U') 
CREATE TABLE WebPaginaParamRepeticion(
	Pagina [varchar](20) NOT NULL,
	Nombre [varchar](50) NOT NULL,
	Repeticiones SMALLINT NULL DEFAULT 1,
	PermiteAgregar BIT NULL,
	SP [varchar](50) NULL
 CONSTRAINT [PK_WebPaginaParamRepeticion] PRIMARY KEY CLUSTERED 
(
	Pagina,Nombre ASC
))
GO

-- drop table WebPaginaParamLista
/****** WebPaginaParamLista ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaParamLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaParamLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaParamLista') and type = 'U') 
CREATE TABLE dbo.WebPaginaParamLista (
	Pagina			varchar(20)	NOT NULL,
	Parametro		varchar(50)	NOT NULL,
	Valor			varchar(255)	NOT NULL,

	Nombre			varchar(255)	NULL,
	Orden			int		NULL,

	CONSTRAINT priWebPaginaParamLista PRIMARY KEY  CLUSTERED (Pagina, Parametro, Valor)
)
go

-- exec spWebPaginaParamAyuda '2B238B50-DEC9-4B4F-A858-10053B4D2307' ,'91','Empleado'
-- select  * from WebPaginaParam
-- select * from webpagina
/**************** spWebPaginaParamAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaParamAyuda') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaParamAyuda
GO
CREATE PROCEDURE spWebPaginaParamAyuda
			@SesionID	uniqueidentifier,
			@Pagina		varchar(20),
			@Parametro	varchar(50),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoAyuda		varchar(20),
    @AyudaTabla		varchar(100),
    @AyudaValor		varchar(100),
    @AyudaNombre	varchar(100),
    @AyudaCondicion	varchar(255),
    @AyudaOrden		varchar(255),
    @SQL		varchar(4000)
  
  SELECT @Mensaje = NULL

  SELECT @TipoAyuda = UPPER(TipoAyuda), @AyudaTabla = AyudaTabla, @AyudaValor = NULLIF(RTRIM(AyudaValor), ''), @AyudaNombre = NULLIF(RTRIM(AyudaNombre), ''), @AyudaCondicion = NULLIF(RTRIM(AyudaCondicion), ''), @AyudaOrden = NULLIF(RTRIM(AyudaOrden), '')
    FROM WebPaginaParam
   WHERE Pagina = @Pagina AND Parametro = @Parametro

  IF @TipoAyuda = 'Lista'
    SELECT Valor, 'Nombre' = ISNULL(NULLIF(RTRIM(Nombre), ''), Valor)
      FROM WebPaginaParamLista
     WHERE Pagina = @Pagina AND Parametro = @Parametro
     ORDER BY Orden, Nombre, Valor
  ELSE
  IF @TipoAyuda = 'Tabla'
  BEGIN
    SELECT @SQL = 'SELECT '+ISNULL(@AyudaValor, @AyudaNombre)+' AS Valor, '+ISNULL(@AyudaNombre, @AyudaValor)+' AS Nombre FROM '+@AyudaTabla
    IF @AyudaCondicion IS NOT NULL SELECT @SQL = @SQL +' WHERE '+@AyudaCondicion
    IF @AyudaOrden IS NOT NULL SELECT @SQL = @SQL +' ORDER BY '+@AyudaOrden
    EXEC (@SQL)
  END

  RETURN
END
GO


if exists (select * from sysobjects where id = object_id('dbo.tgWebPaginaParamBC') and sysstat & 0xf = 8) drop trigger dbo.tgWebPaginaParamBC
GO
CREATE TRIGGER tgWebPaginaParamBC ON WebPaginaParam
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @PaginaA	varchar(20),
    @PaginaN	varchar(20),
    @ParametroA	varchar(50),
    @ParametroN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PaginaA = Pagina, @ParametroA = Parametro FROM Deleted
  SELECT @PaginaN = Pagina, @ParametroN = Parametro FROM Inserted

  IF @ParametroA = @ParametroN RETURN
  
  IF @PaginaN IS NULL
  BEGIN
    DELETE WebPaginaParamLista WHERE Pagina = @PaginaA AND Parametro = @ParametroA
  END ELSE
  BEGIN
    UPDATE WebPaginaParamLista SET Parametro = @ParametroN WHERE Pagina = @PaginaA AND Parametro = @ParametroA
  END
END
GO

/****** WebPaginaBlog ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaBlog')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaBlog','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaBlog') and type = 'U') 
CREATE TABLE dbo.WebPaginaBlog (
	Pagina			varchar(20)	NOT NULL,
	RID			int		NOT NULL  IDENTITY(1,1),

	Fecha			datetime	NULL	DEFAULT GETDATE(),
	Comentarios		text		NULL,
	URL			varchar(255)	NULL,
	Calificacion		varchar(20)	NULL,

	UsuarioWeb		varchar(50)	NULL,	

	CONSTRAINT priWebPaginaBlog PRIMARY KEY  CLUSTERED (Pagina, RID)
)
go
EXEC spALTER_TABLE 'WebPaginaBlog', 'Calificacion', 'varchar(20) NULL'
GO

/**************** spWebPaginaBlogEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaBlogEliminar') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaBlogEliminar
GO
CREATE PROCEDURE spWebPaginaBlogEliminar
			@Pagina		varchar(20),
			@RID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE WebPaginaBlog WHERE Pagina = @Pagina AND RID = @RID
  RETURN
END
GO

--select * from WebPaginaTipoEvento
/****** WebPaginaTipoEvento ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaTipoEvento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaTipoEvento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaTipoEvento') and type = 'U') 
CREATE TABLE dbo.WebPaginaTipoEvento (
	Tipo			varchar(50)	NOT NULL,
	Numero			int		NOT NULL,

	Color			varchar(50)	NULL,

	CONSTRAINT priWebPaginaTipoEvento PRIMARY KEY  CLUSTERED (Numero)
)
go

--select * from WebPaginaCalendario
/****** WebPaginaCalendario ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaCalendario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaCalendario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaCalendario') and type = 'U') 
CREATE TABLE dbo.WebPaginaCalendario (
	Pagina			varchar(20)	NOT NULL,
	RID			int		NOT NULL  IDENTITY(1,1),

	Asunto			varchar(100)	NULL,
	Ubicacion		varchar(100)	NULL,
	Comienzo		datetime	NULL,
	Fin			datetime	NULL,
	TodoElDia		bit		NULL	DEFAULT 0,

	Comentarios		text		NULL,
	URL			varchar(255)	NULL,
	TipoEvento		varchar(50)	NULL,

	CONSTRAINT priWebPaginaCalendario PRIMARY KEY  CLUSTERED (Pagina, RID)
)
go
EXEC spALTER_TABLE 'WebPaginaCalendario', 'TipoEvento', 'varchar(50) NULL'
GO
/****** WebPaginaTarea ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaTarea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaTarea') and type = 'U') 
CREATE TABLE dbo.WebPaginaTarea (
	Pagina			varchar(20)	NOT NULL,
	RID			int		NOT NULL  IDENTITY(1,1),

	Asunto			varchar(100)	NULL,
	Comienzo		datetime	NULL,
	Fin			datetime	NULL,
	Estado			varchar(30)	NULL,
	Prioridad		varchar(20)	NULL,
	Avance			float		NULL,
	Responsable		varchar(100)	NULL,

	Comentarios		text		NULL,

	CONSTRAINT priWebPaginaTarea PRIMARY KEY  CLUSTERED (Pagina, RID)
)
go

EXEC spDROP_TABLE 'WebPaginaDoc', 3099
GO
-- drop table WebPaginaDoc
/****** WebPaginaDoc ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaDoc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaDoc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaDoc') and type = 'U') 
CREATE TABLE dbo.WebPaginaDoc (	
	Pagina			varchar(20)	NOT NULL,
	Sitio			varchar(20)	NOT NULL,
	Documento		varchar(20)	NOT NULL,

	Orden			int		NULL,

	CONSTRAINT priWebPaginaDoc PRIMARY KEY  CLUSTERED (Pagina, Sitio, Documento)
)
go


/****** WebPaginaAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaAcceso') and type = 'U') 
CREATE TABLE dbo.WebPaginaAcceso (
	Pagina			varchar(20)	NOT NULL,
	Rol			varchar(50)	NOT NULL,
	
	PermiteEditarContenido	bit		NULL	DEFAULT 0,

	CONSTRAINT priWebPaginaAcceso PRIMARY KEY  CLUSTERED (Pagina, Rol)
)
go
EXEC spALTER_TABLE 'WebPaginaAcceso', 'PermiteEditarContenido', 'bit NULL DEFAULT 0 WITH VALUES'
GO

-- drop table WebPaginaVista
/****** WebPaginaVista ******/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaVista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaVista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaVista') and type = 'U') 
CREATE TABLE dbo.WebPaginaVista (
	Pagina			varchar(20)	NOT NULL,
	Vista			varchar(50)	NOT NULL,

	Datos			text		NULL,

	CONSTRAINT priWebPaginaVista PRIMARY KEY  CLUSTERED (Pagina, Vista)
)
go

if exists (select * from sysobjects where id = object_id('dbo.WebPaginaCampo') and type = 'U') and
   exists (select * from syscampoExt where tabla = 'WebPaginaCampo' and campo = 'Campo' and ancho = 100)
  DROP TABLE WebPaginaCampo
GO
/*** WebPaginaCampo ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaCampo') and type = 'U') 
CREATE TABLE dbo.WebPaginaCampo (
	Pagina		varchar(20)	NOT NULL,
	Campo		varchar(255)	NOT NULL,

	Etiqueta	varchar(255)	NULL,
	Tipo		varchar(20)	NULL,	-- Texto, Numerico, Monetario
	Formato		varchar(50)	NULL,	

	CONSTRAINT priWebPaginaCampo PRIMARY KEY  CLUSTERED (Pagina, Campo)
)
GO

/**************** spWebPaginaCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaCampo') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaCampo
GO
CREATE PROCEDURE spWebPaginaCampo
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Campo		varchar(255),
			@Etiqueta	varchar(255),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  SELECT Etiqueta, Tipo, Formato
    FROM WebPaginaCampo
   WHERE Pagina = @Pagina AND Campo = @Campo
  IF @@ROWCOUNT = 0
    INSERT WebPaginaCampo (Pagina, Campo, Etiqueta) VALUES (@Pagina, @Campo, @Etiqueta)
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgWebPaginaBC') and sysstat & 0xf = 8) drop trigger dbo.tgWebPaginaBC
GO
CREATE TRIGGER tgWebPaginaBC ON WebPagina
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @PaginaA	varchar(20),
    @PaginaN	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PaginaA = Pagina FROM Deleted
  SELECT @PaginaN = Pagina FROM Inserted

  IF @PaginaA = @PaginaN RETURN
  
  IF @PaginaN IS NULL
  BEGIN
    DELETE WebPaginaParam      WHERE Pagina = @PaginaA
    DELETE WebPaginaParamGrupo WHERE Pagina = @PaginaA
    DELETE WebPaginaParamLista WHERE Pagina = @PaginaA

    DELETE WebPaginaAcceso     WHERE Pagina = @PaginaA
    DELETE WebPaginaBlog       WHERE Pagina = @PaginaA
    DELETE WebPaginaCalendario WHERE Pagina = @PaginaA
    DELETE WebPaginaTarea      WHERE Pagina = @PaginaA
    DELETE WebPaginaVista      WHERE Pagina = @PaginaA
    DELETE WebPaginaCampo      WHERE Pagina = @PaginaA
    DELETE WebPaginaDoc	       WHERE Pagina = @PaginaA
  END ELSE
  BEGIN
    UPDATE WebPaginaParam      SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaParamGrupo SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaParamLista SET Pagina = @PaginaN WHERE Pagina = @PaginaA

    UPDATE WebPaginaAcceso     SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaBlog       SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaCalendario SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaTarea      SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaVista      SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaCampo      SET Pagina = @PaginaN WHERE Pagina = @PaginaA
    UPDATE WebPaginaDoc        SET Pagina = @PaginaN WHERE Pagina = @PaginaA
  END
END
GO

/****** WebRol ******/
if not exists(select * from SysTabla where SysTabla = 'WebRol')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebRol','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebRol') and type = 'U') 
CREATE TABLE dbo.WebRol (
	Rol			varchar(50)	NOT NULL,

	CONSTRAINT priWebRol PRIMARY KEY  CLUSTERED (Rol)
)
go

-- drop table WebUsuario
EXEC spDROP_TABLE 'WebUsuario', 3025
GO
/****** WebUsuario ******/
if not exists(select * from SysTabla where SysTabla = 'WebUsuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebUsuario','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.WebUsuario') and type = 'U') 
CREATE TABLE dbo.WebUsuario (
	UsuarioWeb		varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	eMail			varchar(50)	NULL,
	Contrasena		varchar(20)	NULL,
	Rol			varchar(50)	NULL,

	Estatus 		varchar(15) 	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,

	Empresa			varchar(5)	NULL,
	Sucursal		int		NULL,
	Usuario			varchar(10)	NULL,
	Cliente			varchar(10)	NULL,
	Proveedor		varchar(10)	NULL,
	Personal		varchar(10)	NULL,
	Agente			varchar(10)	NULL,
	Recurso			varchar(10)	NULL,
	Proyecto		varchar(50)	NULL,
	Actividad		varchar(20)	NULL,
	UEN			int		NULL,

	CONSTRAINT priWebUsuario PRIMARY KEY  CLUSTERED (UsuarioWeb)
)
go
EXEC spADD_INDEX 'WebUsuario', 'Nombre', 'Nombre'
GO

EXEC spALTER_TABLE 'WebUsuario', 'eMail', 'varchar(50) NULL'
GO

EXEC spDROP_TABLE 'WebSesion', 3060
GO

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Sexo')
    alter table WebUsuario add Sexo char(1) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='FechaNacimiento')
    alter table WebUsuario add FechaNacimiento varchar(10) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Nacionalidad')
    alter table WebUsuario add Nacionalidad varchar(40) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='CiudadNatal')
    alter table WebUsuario add CiudadNatal varchar(40) null

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Cargo')
    alter table WebUsuario add Cargo varchar(50) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Telefono')
    alter table WebUsuario add Telefono varchar(30) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Extension')
    alter table WebUsuario add Extension varchar(5) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Movil')
    alter table WebUsuario add Movil varchar(15) null

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Domicilio')
    alter table WebUsuario add Domicilio varchar(100) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='CiudadResidencia')
    alter table WebUsuario add CiudadResidencia varchar(40) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='CodigoPostal')
    alter table WebUsuario add CodigoPostal varchar(6) null
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Blog')
    alter table WebUsuario add Blog varchar(100) null

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='PerfilRegistrado')
    alter table WebUsuario add PerfilRegistrado bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='Foto')
    alter table WebUsuario add Foto varchar(100) null

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerSexo')
    alter table WebUsuario add VerSexo bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerFechaNacimiento')
    alter table WebUsuario add VerFechaNacimiento bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerNacionalidad')
    alter table WebUsuario add VerNacionalidad bit DEFAULT ('True')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerCiudadNatal')
    alter table WebUsuario add VerCiudadNatal bit DEFAULT ('True')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerCargo')
    alter table WebUsuario add VerCargo bit DEFAULT ('True')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerTelefono')
    alter table WebUsuario add VerTelefono bit DEFAULT ('True')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerDomicilio')
    alter table WebUsuario add VerDomicilio bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerBlog')
    alter table WebUsuario add VerBlog bit DEFAULT ('True')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerMovil')
    alter table WebUsuario add VerMovil bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerCiudadResidencia')
    alter table WebUsuario add VerCiudadResidencia bit DEFAULT ('False')

if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerMail')
    alter table WebUsuario add VerMail bit DEFAULT ('True')
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='VerCodigoPostal')
    alter table WebUsuario add VerCodigoPostal bit DEFAULT ('True')
if not exists (select * from syscolumns where id=object_id('WebUsuario') and name='PuntosAcumulados')
    alter table WebUsuario add PuntosAcumulados varchar(10) DEFAULT ('0')

ALTER TABLE WebUsuario ALTER COLUMN Sexo char(10) NULL

EXEC spALTER_TABLE 'WebUsuario', 'TelefonoLada', 'varchar(6) NULL'
EXEC spALTER_TABLE 'WebUsuario', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebUsuario', 'Colonia', 'varchar(40) NULL'
EXEC spALTER_TABLE 'WebUsuario', 'NivelEstudios', 'varchar(40) NULL'
EXEC spALTER_TABLE 'WebUsuario', 'EstadoCivil', 'varchar(20) NULL'
GO

EXEC spALTER_TABLE 'WebUsuario', 'VerNivelEstudios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebUsuario', 'VerTelefonoLada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebUsuario', 'VerEstado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebUsuario', 'VerColonia', 'bit NULL DEFAULT 0 WITH VALUES'
GO

ALTER TABLE webusuario ALTER COLUMN contrasena VARCHAR(32)
GO

EXEC spDrop_Constraint 'WebUsuario','PuntosAcumulados'
GO

ALTER TABLE WebUsuario ALTER COLUMN PuntosAcumulados INT 
GO
/****** WebSesion ******/
if not exists(select * from SysTabla where SysTabla = 'WebSesion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSesion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.WebSesion') and type = 'U') 
CREATE TABLE dbo.WebSesion (
	SesionID		uniqueidentifier	NOT NULL,

	Sitio			varchar(20)		NULL,
	UsuarioWeb		varchar(20)		NULL,
	FechaTrabajo		datetime		NULL,

	CONSTRAINT priWebSesion PRIMARY KEY  CLUSTERED (SesionID)
)
go

/**************** spWebSesion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebSesion') and sysstat & 0xf = 4) drop procedure dbo.spWebSesion
GO
CREATE PROCEDURE spWebSesion
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Sitio		varchar(20)	= NULL,
			@UsuarioWeb	varchar(20)	= NULL,
			@FechaTrabajo	datetime   	= NULL,

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  UPDATE WebSesion 
     SET Sitio = @Sitio, UsuarioWeb = @UsuarioWeb, FechaTrabajo = @FechaTrabajo
   WHERE SesionID = @SesionID

  IF @@ROWCOUNT = 0
    INSERT WebSesion 
	   (SesionID,  Sitio,  UsuarioWeb,  FechaTrabajo)
    VALUES (@SesionID, @Sitio, @UsuarioWeb, @FechaTrabajo)

  RETURN
END
GO

-- drop table WebSesionPaginaParam
EXEC spDROP_TABLE 'WebSesionPaginaParam', 3100
GO
/****** WebSesionPaginaParam ******/
if not exists(select * from SysTabla where SysTabla = 'WebSesionPaginaParam')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebSesionPaginaParam','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.WebSesionPaginaParam') and type = 'U') 
CREATE TABLE dbo.WebSesionPaginaParam (
	SesionID		uniqueidentifier	NOT NULL,
	Pagina			varchar(20)		NOT NULL,
	Parametro		varchar(50)		NOT NULL,
	RID			int			IDENTITY(1,1) NOT NULL,
	Valor			varchar(255)		NULL,

	CONSTRAINT priWebSesionPaginaParam PRIMARY KEY  CLUSTERED (SesionID, Pagina, Parametro, RID)
)
go

ALTER TABLE WebSesionPaginaParam ALTER COLUMN Valor varchar(7000)
GO

/**************** spWebSesionPaginaParam ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebSesionPaginaParam') and sysstat & 0xf = 4) drop procedure dbo.spWebSesionPaginaParam
GO
CREATE PROCEDURE spWebSesionPaginaParam
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Parametro	varchar(50),
			@Valor		varchar(7000),
			--@Valor		varchar(255),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  DELETE WebSesionPaginaParam 
   WHERE SesionID = @SesionID AND Pagina = @Pagina AND Parametro = @Parametro

  INSERT WebSesionPaginaParam (
          SesionID,  Pagina,  Parametro,  Valor)
  VALUES (@SesionID, @Pagina, @Parametro, @Valor)

  RETURN
END
GO

/**************** fnWebPaginaParamValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWebPaginaParamValor') DROP FUNCTION fnWebPaginaParamValor
GO
CREATE FUNCTION fnWebPaginaParamValor (@SesionID uniqueidentifier, @Pagina varchar(20), @Parametro varchar(50))
RETURNS varchar(7000)
--RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Valor FROM WebSesionPaginaParam WHERE SesionID=@SesionID AND Pagina=@Pagina AND Parametro=@Parametro)
END
GO

/**************** spWebPaginaCaptura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaCaptura') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaCaptura
GO
CREATE PROCEDURE spWebPaginaCaptura
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.Campana') and type = 'U')
  EXEC spALTER_TABLE 'Campana', 'CampanaTipo', 'varchar(50)	NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.CampanaD') and type = 'U')
BEGIN
  EXEC spALTER_TABLE 'CampanaD', 'Calificacion', 'float	NULL'
  EXEC spALTER_TABLE 'CampanaD', 'Situacion', 'varchar(50)	NULL'
END
GO

/**************** spWebPaginaEncuesta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaEncuesta') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaEncuesta
GO
CREATE PROCEDURE spWebPaginaEncuesta
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		varchar(5),
    @ID			int,
    @RID		int,
    @Dato		varchar(255),
    @Sucursal		int,
    @CampanaTipo	varchar(50),
    @Calificacion	float,
    @Situacion		varchar(50)

  SELECT @Mensaje = NULL

  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @Modulo = @Dato
  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @ID = CONVERT(int, @Dato)
  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @RID = CONVERT(int, @Dato)

  IF @Modulo = 'CMP'
  BEGIN
    SELECT @Sucursal = Sucursal, @CampanaTipo = CampanaTipo
      FROM Campana
     WHERE ID = @ID
    DELETE CampanaEncuesta
     WHERE ID = @ID AND RID = @RID

    INSERT CampanaEncuesta (ID, RID, Sucursal, Campo, Respuesta)
    SELECT @ID, @RID, @Sucursal, Parametro, Valor
      FROM WebSesionPaginaParam
     WHERE SesionID = @SesionID AND Pagina = @Pagina
       AND Parametro IN (SELECT Campo FROM CampanaTipoEncuesta WHERE CampanaTipo = @CampanaTipo)

    -- Aceptar la Campana
    EXEC spCampanaEncuestaAceptar @ID, @RID, @Calificacion OUTPUT, @Situacion OUTPUT
    UPDATE CampanaD 
       SET Calificacion = @Calificacion,
           Situacion = @Situacion
     WHERE ID = @ID AND RID = @RID
  END


  RETURN
END
GO

/**************** spWebPaginaCancelarSuscripcion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaCancelarSuscripcion') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaCancelarSuscripcion
GO
CREATE PROCEDURE spWebPaginaCancelarSuscripcion
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Modulo		varchar(5),
    @ID			int,
    @RID		int,
    @Dato		varchar(255),
    @Sucursal		int,
    @CampanaTipo	varchar(50),
    @Calificacion	float,
    @Situacion		varchar(50)

  SELECT @Mensaje = NULL

  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @Modulo = @Dato
  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @ID = CONVERT(int, @Dato)
  EXEC spExtraerDato @Origen OUTPUT, @Dato OUTPUT, '|' SELECT @RID = CONVERT(int, @Dato)

  IF @Modulo = 'CMP'
  BEGIN
    SELECT @CampanaTipo = CampanaTipo
      FROM Campana
     WHERE ID = @ID

    SELECT @Situacion = CancelarSuscripcionSituacion
      FROM CampanaTipo
     WHERE CampanaTipo = @CampanaTipo

    INSERT CampanaEvento (ID, RID, Tipo, Situacion) VALUES (@ID, @RID, 'Cancelar Suscripcion', @Situacion)
  END
  RETURN
END
GO


/**************** spWebPaginaConsulta ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaConsulta') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaConsulta
GO
/*CREATE PROCEDURE spWebPaginaConsulta
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  RETURN
END*/
GO



/**************** spWebPaginaEvento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaEvento') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaEvento
GO
CREATE PROCEDURE spWebPaginaEvento
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Evento		varchar(50),	-- CARGAR PARAMETROS, CARGAR PAGINA, SALIR PAGINA, PROCESAR

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  RETURN
END
GO

/**************** spWebPaginaTareaResponsable ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaTareaResponsable') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaTareaResponsable
GO
CREATE PROCEDURE spWebPaginaTareaResponsable
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  SELECT 'Valor' = CONVERT(varchar(100), NULL), 'Nombre' = CONVERT(varchar(100), NULL)
  RETURN
END
GO


/**************** spWebPaginaTareaEstado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaTareaEstado') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaTareaEstado
GO
CREATE PROCEDURE spWebPaginaTareaEstado
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  SELECT 'Valor' = Estado, 'Nombre' = Estado FROM TareaEstado ORDER BY Orden
  RETURN
END
GO


/**************** spWebPaginaTareaPrioridad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaTareaPrioridad') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaTareaPrioridad
GO
CREATE PROCEDURE spWebPaginaTareaPrioridad
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Mensaje = NULL

  SELECT 'Valor' = 'Alta', 'Nombre' = 'Alta'
  UNION ALL
  SELECT 'Valor' = 'Normal', 'Nombre' = 'Normal'
  UNION ALL
  SELECT 'Valor' = 'Baja', 'Nombre' = 'Baja'
  RETURN
END
GO


/**************** spWebPaginaParamCampana ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaParamCampana') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaParamCampana
GO
CREATE PROCEDURE spWebPaginaParamCampana
				@Pagina	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CampanaTipo	varchar(50),
    @Campo		varchar(50),
    @Nombre		varchar(100),
    @Orden		int,
    @Tipo		varchar(20),
    @TablaEvaluacion	varchar(20)

  SELECT @CampanaTipo = CampanaTipo FROM WebPagina WHERE Pagina = @Pagina
  DELETE WebPaginaParam WHERE Pagina = @Pagina
  DELETE WebPaginaParamLista WHERE Pagina = @Pagina

  DECLARE crCampanaTipoEncuesta CURSOR FOR 
   SELECT Campo, Nombre, Orden, Tipo, TablaEvaluacion
     FROM CampanaTipoEncuesta
    WHERE CampanaTipo = @CampanaTipo
  OPEN crCampanaTipoEncuesta
  FETCH NEXT FROM crCampanaTipoEncuesta INTO @Campo, @Nombre, @Orden, @Tipo, @TablaEvaluacion
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT WebPaginaParam (
              Pagina,  Parametro, Nombre,  TipoDatos, Tamano, Orden,  TipoAyuda)
      VALUES (@Pagina, @Campo,    @Nombre, 'Texto',   50,     @Orden, 'Lista')

      IF UPPER(@Tipo) = 'DATOS'
        INSERT WebPaginaParamLista (
               Pagina,  Parametro, Valor, Orden)
        SELECT @Pagina, @Campo,    Valor, Orden
          FROM CampanaTipoEncuestaLista
         WHERE CampanaTipo = @CampanaTipo AND Campo = @Campo
      ELSE
      IF UPPER(@Tipo) = 'EVALUACION'
        INSERT WebPaginaParamLista (
               Pagina,  Parametro, Valor,  Orden)
        SELECT @Pagina, @Campo,    Nombre, Orden
          FROM TablaEvaluacionD
         WHERE TablaEvaluacion = @TablaEvaluacion
    END
    FETCH NEXT FROM crCampanaTipoEncuesta INTO @Campo, @Nombre, @Orden, @Tipo, @TablaEvaluacion
  END
  CLOSE crCampanaTipoEncuesta
  DEALLOCATE crCampanaTipoEncuesta
  RETURN
END
GO

/**************** spWebPaginaBusqueda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaBusqueda') and sysstat & 0xf = 4) drop procedure dbo.spWebPaginaBusqueda
GO
CREATE PROCEDURE spWebPaginaBusqueda
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Texto		varchar(255),

			@Mensaje	varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @BuscarNombres		bit,
    @BuscarDescripciones	bit,
    @BuscarHTML			bit,
    @BuscarOtrosSitios		bit,
    @Sitio			varchar(20)

  SELECT @Mensaje = NULL

  SELECT @Sitio = Sitio
    FROM WebSesion
   WHERE SesionID = @SesionID
  SELECT @BuscarNombres = BuscarNombres, @BuscarDescripciones = BuscarDescripciones, @BuscarHTML = BuscarHTML, @BuscarOtrosSitios = BuscarOtrosSitios
    FROM WebPagina
   WHERE Pagina = @Pagina

  CREATE TABLE #Resultado (
	ID		int		NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	Nombre		varchar(100)	NULL, 
	Descripcion	varchar(255)	NULL, 
	Pagina		varchar(20)	NULL, 
	URL		varchar(255)	NULL)
  
  INSERT #Resultado (Nombre, Descripcion, Pagina, URL)
  SELECT Nombre, Descripcion, Pagina, URL
    FROM WebPagina
   WHERE Nombre LIKE '%'+@Texto+'%' OR Descripcion LIKE '%'+@Texto+'%' 
   
  EXEC xpWebPaginaBusqueda @SesionID, @Origen, @Pagina, @Texto, @Mensaje OUTPUT
  SELECT * FROM #Resultado ORDER BY ID
  RETURN
END
GO

/**************** WebPaginaEstadistica ****************/
-- Author:			Yessenia Villacis
-- Create date:		10-Jun-2008

if not exists(select * from SysTabla where SysTabla = 'WebPaginaEstadistica')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaEstadistica','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaEstadistica') and type = 'U') 
	CREATE TABLE WebPaginaEstadistica(
		  [ID] [int] IDENTITY(1,1) NOT NULL,
		  [SesionID] [Uniqueidentifier] NULL,
		  [Sitio] [varchar](20) NULL,
		  [Pagina] [varchar](20) NULL,
		  [Fecha] [smalldatetime] NULL CONSTRAINT [DF_WebPaginaEstadistica_Fecha]  DEFAULT (getdate()),
		  [Dia] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Dia]  DEFAULT (day(getdate())),
		  [Mes] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Mes]  DEFAULT (MONTH(getdate())),
		  [Ano] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Ano]  DEFAULT (year(getdate())),

		  [Hora] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Hora]  DEFAULT (DATEPART ( hh , getdate() )),
		  [Minuto] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Minuto]  DEFAULT (DATEPART ( mi , getdate() )),
		  [Segundo] [int] NULL CONSTRAINT [DF_WebPaginaEstadistica_Segundo]  DEFAULT (DATEPART ( ss , getdate() )),

		  [IpUsuario] [varchar](20) NULL,
		  [Navegador] [varchar](50) NULL,
		  [PaginaAnterior] [varchar](250) NULL,
		  [Usuario] [varchar](20) NULL,
          [Documento] [varchar](255) NULL
	 CONSTRAINT [PK_WebPaginaEstadistica] PRIMARY KEY CLUSTERED 
	(
		  [ID] ASC
	))

GO

/**************** spWebPaginaEstadistica ****************/
-- Author:			David Ongay
-- Create date:		14-May-2008
EXEC spALTER_TABLE 'WebPaginaEstadistica', 'Documento',  'varchar(255) NULL'
GO

/**************** spWebPaginaEstadistica ****************/
-- Author:			Yessenia Villacis
-- Create date:		10-Jun-2008
if exists (select * from sysobjects where id = object_id('dbo.SPWebPaginaEstadistica') and type = 'P') drop procedure dbo.SPWebPaginaEstadistica
GO
CREATE PROCEDURE [SPWebPaginaEstadistica]
      @Pagina varchar(20),
      @Sitio varchar(20),
      @SesionID Uniqueidentifier,
      @Navegador varchar(50),
      @PaginaAnterior varchar(250),
      @Usuario varchar(20),
      @IpUsuario varchar(20),
      @Documento varchar(255) 
--//WITH ENCRYPTION
AS BEGIN
	IF NOT EXISTS(SELECT Sitio 
					FROM WebPaginaEstadistica 
				   WHERE Sitio = @Sitio AND 
						 SesionID = @SesionID AND 
						 Pagina= @Pagina AND 
						 IpUsuario = @IpUsuario AND 
						 Navegador = @Navegador AND 
						 PaginaAnterior = @PaginaAnterior AND 
						 Usuario=@Usuario AND Documento=@Documento )
	BEGIN
		  insert into WebPaginaEstadistica
				(Sitio ,Pagina ,SesionID, IpUsuario  ,Navegador ,PaginaAnterior ,Usuario,Documento)
		  values
				(@Sitio,@Pagina,@SesionID, @IpUsuario,@Navegador,@PaginaAnterior,@Usuario,@Documento)
	END
END
GO

/**************** WebPaginaMultiPagina ****************/
-- Author:			Yessenia Villacis
-- Create date:		08-Dic-2008

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebPaginaMultiPagina]') AND type in (N'U'))
CREATE TABLE WebPaginaMultiPagina(
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[Pagina] [varchar](20) NULL,
	[Fila] [tinyint] NULL,
	[Columna] [tinyint] NULL,
	[WebPagina] [varchar](20) NULL,
	[WebPaginaAlto] [smallint] NULL,
	[WebPaginaAncho] [smallint] NULL,
	[WebPaginaAnchoPorcentaje] [smallint] NULL,
	[VerScroll] [bit] NULL CONSTRAINT [DF_WebPaginaMultiPagina_VerScroll]  DEFAULT ('True'),
	[PonerBorde] [bit] NULL CONSTRAINT [DF_WebPaginaMultiPagina_PonerBorde]  DEFAULT ('True'),
 CONSTRAINT [PK_WebPaginaMultiPagina] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
))

GO

/**************** spWebPaginaPerfilActualizarInformacionBasica ****************/
-- Author:			Yessenia Villacis
-- Create date:		08-Dic-2008

if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaPerfilActualizarInformacionBasica') and type = 'P') 
	drop procedure dbo.spWebPaginaPerfilActualizarInformacionBasica
GO
CREATE PROCEDURE spWebPaginaPerfilActualizarInformacionBasica
	@Usuario as VARCHAR(20),
	@TipoActualizacion as varchar(50),
	@valor1 as  VARCHAR(100),
	@valor2 as varchar(100),
	@valor3 as varchar(100),
	@valor4 as varchar(100),
	@valor5 as varchar(100),
	@valor6 as varchar(100),
	@valor7 as varchar(100),
    @valor8 as varchar(100),
    @valor9 as varchar(100)
--//WITH ENCRYPTION	
AS BEGIN 
IF UPPER(@TipoActualizacion)='INFORMACION_BASICA'
	BEGIN
		UPDATE WebUsuario SET
			   Nombre=@valor1,Sexo=@valor6 ,FechaNacimiento=@valor2 ,
			   Nacionalidad=@valor3 ,NivelEstudios=@valor4,Cargo=@valor5,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END
  
IF UPPER(@TipoActualizacion)='CONTACTO'
	BEGIN
		UPDATE WebUsuario SET
			   email=@valor1,Telefono=@valor2 ,Extension=@valor3 ,Movil=@valor4,Domicilio=@valor5,
			   Estado=@valor6 ,CodigoPostal=@valor7,Colonia=@valor8,TelefonoLada=@valor9,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END
 IF UPPER(@TipoActualizacion)='FOTO'
	BEGIN
		UPDATE WebUsuario SET
			   Foto=@valor1,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END
IF UPPER(@TipoActualizacion)='CONTRASENA'
	BEGIN
		UPDATE WebUsuario SET
			   Contrasena=@valor1,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END
IF UPPER(@TipoActualizacion)='PERMITIR_INFORMACION_BASICA'
	BEGIN
		UPDATE  WebUsuario SET
				VerSexo=@valor1,
				VerFechaNacimiento=@valor2,
				VerNacionalidad=@valor3,
				VerNivelEstudios=@valor4,
				Vercargo=@valor5,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END

IF UPPER(@TipoActualizacion)='PERMITIR_INFORMACION_CONTACTO'
	BEGIN
		UPDATE  WebUsuario SET
			    VerMail=@valor1,
				VerTelefono=@valor2,
				VerMovil=@valor3,
				VerDomicilio=@valor4,
				VerEstado=@valor5,
				VerCodigoPostal=@valor6,
				VerColonia=@valor7,
				VerTelefonoLada=@valor9,
			   UltimoCambio=getdate()
		WHERE upper(ltrim(rtrim(UsuarioWeb)))=upper(ltrim(rtrim(@Usuario)))
	END


END 

GO



/**************** WebPaginaSuscripcion ****************/
-- Author:			Yessenia Villacis
-- Create date:		09-Dic-2008

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebPaginaSuscripcion]') AND type in (N'U'))
CREATE TABLE WebPaginaSuscripcion(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Pagina] [varchar](20) NOT NULL,
	[Usuario] [varchar](20) NOT NULL,
	[eMail] [varchar](50) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Estatus] [varchar](15) NOT NULL,
 CONSTRAINT [PK_WebPaginaSuscripcion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
))
GO


/**************** spWebPaginaSuscripcion ****************/
-- Author:			Yessenia Villacis
-- Create date:		09-Dic-2008
if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaSuscripcion') and type = 'P') 
	drop procedure dbo.spWebPaginaSuscripcion
GO

CREATE PROCEDURE spWebPaginaSuscripcion
	@Accion			VARCHAR(20)	 = '',
	@Pagina			VARCHAR(20) = '',
	@Usuario		VARCHAR(100) = '',
	@Correo			VARCHAR(100) = '',
	@URL			VARCHAR(300) = '',
	@Sitio			VARCHAR(250) = ''
--//WITH ENCRYPTION
AS BEGIN 
Declare
	@Mensaje		VARCHAR(Max),
	@Propietario	VARCHAR(100)


IF @ACCION ='AGREGAR'
BEGIN
	IF NOT EXISTS(SELECT ID FROM WebPaginaSuscripcion WHERE Pagina = @Pagina  AND Usuario = @Usuario AND eMail = @Correo AND Estatus='ALTA')
	  BEGIN
		INSERT INTO WebPaginaSuscripcion
		(Pagina,  Usuario,  eMail,   Fecha,	  Estatus) VALUES
		(@Pagina, @Usuario, @Correo, Getdate(), 'ALTA')
		SELECT '0000' -- INDICA QUE EL REGISTRO SE REGISTRO CON EXITO
	  END
	ELSE
	  BEGIN
		SELECT '1111' -- INDICA QUE EL REGISTRO YA EXISTE
	  END
END

--EXEC spWebPaginaSuscripcion 'CANCELAR','25','jesus','dongay@intelisis.com',''
IF @ACCION ='CANCELAR'
BEGIN
	IF EXISTS(SELECT ID FROM WebPaginaSuscripcion WHERE Pagina = @Pagina  AND Usuario = @Usuario AND eMail = @Correo AND Estatus='ALTA')
		BEGIN
			UPDATE WebPaginaSuscripcion SET Estatus = 'BAJA' WHERE Pagina = @Pagina  AND Usuario = @Usuario AND eMail = @Correo
			SELECT '0000' -- INDICA QUE EL REGISTRO SE CANCELO CON EXITO
		END
	ELSE
		SELECT '2222' -- INDICA QUE EL REGISTRO NO EXISTE
END

--EXEC spWebPaginaSuscripcion 'ENVIAR','25','0','0','http://davidongay/Iportal/Principal.aspx'
IF @ACCION ='ENVIAR'
BEGIN
    -- declaramos las variables
  declare @CorreoEnviar as VARCHAR(100)
    -- declaramos un cursor llamado "CURSORITO". El select debe contener sólo los campos a utilizar.
        declare CURSORITO cursor for
  select eMail FROM WebPaginaSuscripcion WHERE Pagina = @Pagina AND Estatus = 'ALTA'
    open CURSORITO
        -- Avanzamos un registro y cargamos en las variables los valores encontrados en el primer registro
  fetch next from CURSORITO
  into @CorreoEnviar
      while @@fetch_status = 0
    begin
		declare @WebServer as varchar(255)
		select @WebServer =URL_Sitio from WebSitio where Sitio= @Sitio     
		
		SELECT @Mensaje = '<html>
		<head>
		<meta http-equiv="Content-Language" content="es-mx">
		<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<title>Tienes un nuevo Comentario</title>
		</head>
		 <body>
			<div style=" width' + CHAR(58) + '100%; border-style' + CHAR(58) + ' none; border-width' + CHAR(58) + ' 0px; padding-left' + CHAR(58) + ' 4px; padding-right' + CHAR(58) + ' 4px; padding-top' + CHAR(58) + ' 1px; padding-bottom' + CHAR(58) + ' 1px" >
			
				<table border="0" width="100%" height="287" >
					<tr>
						<td  height="23" bgcolor="#C0C0C0" width="100%>
							<p style="margin-left' + CHAR(58) + ' 10px"><b>
							<font face="Arial Unicode MS" color="#0A78BE">&nbsp;</font></b>
						</td>
					</tr>
					<tr>
						<td>
							<br/>
							<br/>
							<br/>
								Existe una participacion en el Foro ' + CONVERT(VARCHAR(300),@URL) + '
							<br/>
							<br/>
							<br/>
						</td>
					</tr>
					<tr>
						<td height="23" bgcolor="#0A78BE" >
							<p align="center" style=" width' + CHAR(58) + '100%"><font color="#FFFFFF" face="Arial Unicode MS" size="2"><b>By Power 
							I-Portal</b></font></p>
						
						</td>
					</tr>
					<tr>
							<td  height="23" bgcolor="#C0C0C0"  align="center">
								<p style="text-align' + CHAR(58) + 'center;width' + CHAR(58) + '100%">
										<a style="color' + CHAR(58) + ' blue; text-decoration' + CHAR(58) + ' underline; text-underline' + CHAR(58) + ' single" href="' + @WebServer + 'Administracion.aspx?Pagina=' + @Pagina + '&Origen=' +  @Usuario + '|' + @Correo + 'CS">
											<font face="Arial Unicode MS" color="#0A78BE" size="2">Para cancelar su suscripcion haga click aqui</font> 
										</a>
									
								</p>
							</td>
					   </tr>
					<tr>
							<td    align="center">
								<p style="text-align' + CHAR(58) + 'center;width' + CHAR(58) + '100%">
									<font face="Arial Unicode MS" size="2">Base de datos de suscriptores registrada en Intelisis S.A </font> <br/>
									<font face="Arial Unicode MS" size="2">Copyright ©2008. Todos los derechos reservados.</font>
									
								</p>
							</td>
					   </tr>
				</table>
				
			</div>
		 </body>
		</html>'


		EXEC msdb.dbo.sp_send_dbmail  
			  @profile_name ='Desarrollo',
			  @recipients=@CorreoEnviar,
			  @subject = 'Nuevo Comentario...',
			  @body = @Mensaje,
			  @body_format = 'HTML';	

    -- Avanzamos otro registro
    fetch next from CURSORITO
    into @CorreoEnviar
    end
    -- cerramos el cursor
        close CURSORITO
  deallocate CURSORITO

END

RETURN
END

GO

/**************** WebArticulo ****************/
-- Author:			Yessenia Villacis
-- Create date:		09-Dic-2008

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebArticulo]') AND type in (N'U'))
CREATE TABLE [dbo].[WebArticulo](
	[Pagina] [varchar](20) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RamaID] [int] NULL,
	[HistoricoID] [int] NULL,
	[FechaHora] [datetime] NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[CorreoElectronico] [varchar](100) NULL,
	[Tipo] [varchar](20) NOT NULL,
	[Descripcion] [varchar](2000) NULL,
	[HTML] [varchar](max) NULL,
	[Autorizado] [bit] NOT NULL CONSTRAINT [DF_WebArticulo_Autorizado]  DEFAULT ((0)),
	[Categoria] [varchar](50) NULL,
	[Comentarios] [int] NULL,
	[CostoArticulo] [varchar](10) NULL,
	[Pagado] [bit] NULL CONSTRAINT [DF_WebArticulo_CostoPagado]  DEFAULT ('False'),
	[ItemPagado] [bit] NULL CONSTRAINT [DF_WebArticulo_ItemPagado]  DEFAULT ('0'),
 CONSTRAINT [PK_WebArticulo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
))

GO

EXEC spALTER_TABLE 'WebArticulo', 'Calificacion', 'money null Default 0'

/**************** SPWebPaginaComunidad ****************/
-- Author:			Yessenia Villacis
-- Fecha de Moficacion:	24-Feb-2009
if exists (select * from sysobjects where id = object_id('dbo.SPWebPaginaComunidad') and type = 'P') 
	drop procedure dbo.SPWebPaginaComunidad
GO

CREATE PROCEDURE [SPWebPaginaComunidad]
   @Accion			VARCHAR(25)= null,  
   @Pagina			VARCHAR(20) = null,  
   @ID				VARCHAR(255) = null,  
   @RamaID			VARCHAR(255) = null,  
   @Usuario			VARCHAR(255) = null,  
   @Correo			VARCHAR(100) = null,  
   @Tipo			VARCHAR(20) = null,  
   @Descripcion		VARCHAR(2000)= null,  
   @HTML			VARCHAR(Max) = null,  
   @URL				VARCHAR(300)= null,  
   @Sitio			VARCHAR(250) = null ,
   @Categoria		VARCHAR(250) = null ,
   @valor			VARCHAR(10)= null ,
   @TipoDoc			VARCHAR(15)= null ,
   @HistoricoID		VARCHAR(255) = null ,
   @Nivel			int = 1   
 --//WITH ENCRYPTION
AS BEGIN    
Declare   
	@Propietario				Varchar(100),  
	@Autorizado					Bit,  
	@Notificar					BIT,
    @TituloComentario			VARCHAR(20),
    @VerHistoria				BIT,
	@TemValor					NUMERIC,
	@TemValor2					NUMERIC,
	@TemValor3					NUMERIC	,
	@ArticuloID					int
--EXEC SPWebPaginaComunidad 'CONSULTA1','274','','','dongay@intelisis.com','','Articulo','',''    
--EXEC SPWebPaginaComunidad 'CONSULTA1','10','','','','','Articulo','',''  

IF @Accion = 'CONSULTA1'  
BEGIN  
	PRINT @TipoDoc
 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
   IF UPPER(@TipoDoc)='WIKI'
 		BEGIN
            SELECT dbo.WebArticulo.*,CONVERT(int, Calificacion) AS 'Calificacion1', CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 'No. Discuciones:' AS 'lblTituloComentario', 1 AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto 
            FROM   dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
            WHERE  (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID IS NULL) AND (dbo.WebArticulo.Tipo = @Tipo) AND (dbo.WebArticulo.HistoricoID IS NOT NULL) AND (dbo.WebArticulo.ID IN
                   (SELECT     MAX(ID) AS Expr1 FROM dbo.WebArticulo AS WebArticulo_1 GROUP BY HistoricoID))
            ORDER BY dbo.WebArticulo.FechaHora DESC 			
	    END
   ELSE
   BEGIN
        SELECT WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1',CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 'No. Comentarios:' AS 'lblTituloComentario', 0 AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
        FROM  dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
        WHERE (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID IS NULL) AND (dbo.WebArticulo.Tipo = @Tipo)
        ORDER BY dbo.WebArticulo.FechaHora DESC
   END
 ELSE  
 	IF UPPER(@TipoDoc)='WIKI'
 		BEGIN
			SELECT dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1',CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 'No. Discuciones:' AS 'lblTituloComentario', 1 AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
			FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
			WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID IS NULL) AND (dbo.WebArticulo.Tipo = @Tipo) AND (dbo.WebArticulo.Autorizado = 1) AND (dbo.WebArticulo.HistoricoID IS NOT NULL) AND (dbo.WebArticulo.ID IN (SELECT     MAX(ID) AS Expr1 FROM          dbo.WebArticulo AS WebArticulo_1 GROUP BY HistoricoID))
			ORDER BY dbo.WebArticulo.FechaHora DESC

	    END
 	ELSE
 	BEGIN
 		--EXEC SPWebPaginaComunidad 'CONSULTA1','8','','','','','Articulo','','','','','','','Foro'
		SELECT dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1',CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 'No. Comentarios:' AS 'lblTituloComentario', 0 AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
		FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
		WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID IS NULL) AND (dbo.WebArticulo.Tipo = @Tipo) AND (dbo.WebArticulo.Autorizado = 1)
		ORDER BY dbo.WebArticulo.FechaHora DESC 		
	 end
END  
--EXEC SPWebPaginaComunidad 'CONSULTA2','11','16','','dongay@intelisis.com','','Articulo','',''
--EXEC SPWebPaginaComunidad 'CONSULTA1','271','143','','','','Articulo','',''  
IF @Accion = 'CONSULTA2'  
BEGIN 
  IF UPPER(@TipoDoc)='WIKI'
    begin
		SET @TituloComentario= 'No. Discuciones:'
		SET @VerHistoria=1
	end
  ELSE
  	begin	
		SET @TituloComentario= 'No. Comentarios:' 
		SET @VerHistoria=0
	end
	
 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
		SELECT dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto, 0 AS 'ArticuloPagado'
		FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
		WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.Tipo = @Tipo) AND (dbo.WebArticulo.ID = @ID )
		ORDER BY dbo.WebArticulo.FechaHora ASC
 ELSE 

	SELECT dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto, 0 AS 'ArticuloPagado'
	FROM dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
	WHERE (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.Tipo = @Tipo) AND (dbo.WebArticulo.ID = @ID) AND (dbo.WebArticulo.Autorizado = 1)
	ORDER BY dbo.WebArticulo.FechaHora ASC 
END  
  
--EXEC SPWebPaginaComunidad 'CONSULTA3','271','143','','','','','',''  
--EXEC SPWebPaginaComunidad 'CONSULTA3','11','16','','dongay@intelisis.com','','','',''
IF @Accion = 'CONSULTA3'  
BEGIN  
  IF UPPER(@TipoDoc)='WIKI'
	 begin
		SET @TituloComentario= 'No. Discuciones:'
		SET @VerHistoria=1
	end
  ELSE
  	begin	
		SET @TituloComentario= 'No. Comentarios:' 
		SET @VerHistoria=0
	end

IF UPPER(@TipoDoc)='EXPERTS'
	IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
		SELECT  1 AS 'uno',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, CASE Pagado WHEN 1 THEN 0 ELSE 1 END AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
		FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
		WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID)
		ORDER BY dbo.WebArticulo.FechaHora DESC 
	ELSE 
		SELECT  2 AS 'dos',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, CASE Pagado WHEN 1 THEN 0 ELSE 1 END AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
		FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
		WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID) AND (Autorizado = 1 )
		ORDER BY dbo.WebArticulo.FechaHora DESC  
ELSE
	IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
		begin
		IF UPPER(@TipoDoc)='FORO' AND @Nivel=2
	 		begin
	 		SELECT  1 AS 'uno',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
			FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
			WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID)
			ORDER BY dbo.WebArticulo.FechaHora DESC 
			end
		ELSE
			SELECT  1 AS 'uno',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
			FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
			WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID)
			ORDER BY dbo.WebArticulo.FechaHora ASC 
			end
	ELSE
		IF UPPER(@TipoDoc)='FORO' AND @Nivel=2
			begin
			SELECT  1 AS 'uno',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
			FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
			WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID)
			ORDER BY dbo.WebArticulo.FechaHora DESC 
			end
		ELSE
			SELECT  2 AS 'dos',dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CASE Tipo WHEN 'Comentario' THEN 0 WHEN 'Discucion' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
			FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
			WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.RamaID = @ID) AND (Autorizado = 1 )
			ORDER BY dbo.WebArticulo.FechaHora ASC  
END  

  
  IF @Accion = 'CONSULTA4'  
	BEGIN  
	  IF UPPER(@TipoDoc)='WIKI'
		 begin
			SET @TituloComentario= 'No. Discuciones:'
			SET @VerHistoria=1
		end
	  ELSE
  		begin	
			SET @TituloComentario= 'No. Comentarios:' 
			SET @VerHistoria=0
		end
	 SELECT @HistoricoID=HistoricoID FROM WebArticulo WHERE ID=@ID
	 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
				SELECT dbo.WebArticulo.*,CONVERT(int, Calificacion) AS 'Calificacion1', 0 AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
				FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
				WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.HistoricoID = @HistoricoID)
				ORDER BY dbo.WebArticulo.FechaHora DESC	 
	 ELSE  
	 			SELECT dbo.WebArticulo.*, CONVERT(int, Calificacion) AS 'Calificacion1', CONVERT(int, Calificacion) AS 'Calificacion1', 0 AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados, 0 AS 'ArticuloPagado', dbo.WebArticulo.ItemPagado AS Expr1, @TituloComentario AS 'lblTituloComentario', @VerHistoria AS 'VerHistoria', CASE Autorizado WHEN 1 THEN 'App_Themes/FORO/AUTORIZAR-BN.gif' ELSE 'App_Themes/FORO/AUTORIZAR2.gif' END AS 'ImagenAutorizado', dbo.WebUsuario.Foto
				FROM         dbo.WebArticulo LEFT OUTER JOIN dbo.WebUsuario ON dbo.WebArticulo.Usuario = dbo.WebUsuario.UsuarioWeb
				WHERE     (dbo.WebArticulo.Pagina = @Pagina) AND (dbo.WebArticulo.HistoricoID = @HistoricoID) AND (Autorizado = 1)
				ORDER BY dbo.WebArticulo.FechaHora DESC	 
	END  
	
--EXEC SPWebPaginaComunidad 'CONSULTAID','271','39','','JESUS','','','',''  
IF @Accion = 'EDITAID'  
BEGIN  
 SELECT * FROM WebArticulo WHERE ID = @ID  
END  
  
--EXEC SPWebPaginaComunidad 'ELIMINA','271','185','','JESUS','','','',''  
--EXEC SPWebPaginaComunidad 'ELIMINA','271','210','185','JESUS','','','',''
IF @Accion = 'ELIMINA'  
BEGIN  
	DELETE WebArticulo WHERE ID =  @ID  
	UPDATE WebArticulo SET Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID  And Autorizado = 1) WHERE ID = @RamaID  
END  
  
--EXEC SPWebPaginaComunidad 'ACTUALIZA','271','214','','JESUS','','','',''  
--EXEC SPWebPaginaComunidad 'ACTUALIZA','271','214','185','JESUS','','','','','http://localhost/Iportal/Comunidad.aspx?Pagina=271&Origen=185','PRINCIPAL'
IF @Accion = 'ACTUALIZA'  
BEGIN  
	UPDATE WebArticulo SET Autorizado = 1 WHERE ID = @ID  
	UPDATE WebArticulo SET Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID  And Autorizado = 1) WHERE ID = @RamaID  
	EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    
END  

--EXEC SPWebPaginaComunidad 'AUTORIZA_PAGO','11','17','16','admin','','','',''
IF @Accion = 'AUTORIZA_PAGO'  
BEGIN  
	
	SELECT @Propietario=Usuario,@RamaID=RamaID FROM WebArticulo  WHERE id=@ID
	UPDATE WebArticulo SET Pagado = 1 WHERE RamaID = @RamaID  OR id=@RamaID
	UPDATE WebArticulo SET ItemPagado = 1 WHERE id=@ID
	SELECT @valor=CostoArticulo FROM WebArticulo WHERE id=@RamaID
	UPDATE WebUsuario SET  PuntosAcumulados=PuntosAcumulados + CONVERT(INT,@valor) WHERE UsuarioWeb=@Propietario
	UPDATE WebUsuario SET  PuntosAcumulados=PuntosAcumulados - CONVERT(INT,@valor) WHERE UsuarioWeb=@Usuario
   
END  


--EXEC SPWebPaginaComunidad 'GRABAARTICULO','271','','','JESUS','dongay@intelisis.com','Articulo','Super Blog 2','Super Blog 2'  
IF @Accion = 'GRABAARTICULO'  
BEGIN  
 SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
 INSERT INTO WEBARTICULO (Pagina,   FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML,  Autorizado,  Categoria, CostoArticulo,HistoricoID)
      VALUES             (@Pagina,  getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML, @Autorizado, @Categoria,@valor,@HistoricoID)   
	SET @ArticuloID=SCOPE_IDENTITY()

    IF (ISNULL(@HistoricoID,0)=0  OR @HistoricoID='') AND UPPER(@TipoDoc)='WIKI'
		UPDATE webarticulo SET HistoricoID=@ArticuloID WHERE ID=@ArticuloID
		
	IF (@Autorizado = 1) 
		EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    


END  
  
--EXEC SPWebPaginaComunidad 'GRABACOMENTARIO','271','','185','JESUS','dongay@intelisis.com','Comentario','dos dos dos dos dos','&nbsp;dos dos','http://localhost/Iportal/Comunidad.aspx?Pagina=271&Origen=185','PRINCIPAL','Sin Categoria'    
--EXEC SPWebPaginaComunidad 'GRABACOMENTARIO','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'GRABACOMENTARIO'  
BEGIN  
 SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
 INSERT INTO WEBARTICULO (Pagina,   RamaID,  FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML  ,Autorizado,  Categoria,CostoArticulo)
      VALUES             (@Pagina,  @RamaID, getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML ,@Autorizado, @Categoria,@valor)   
	IF @Autorizado = 1 
		BEGIN
			UPDATE WebArticulo set Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID And Autorizado = 1	) WHERE pagina = @Pagina AND id = @RamaID
			EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    
		END
END  
  
 
--EXEC SPWebPaginaComunidad 'ACTUALIZAREGISTRO','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'ACTUALIZAREGISTRO'  
BEGIN  
 UPDATE WEBARTICULO set Descripcion = @Descripcion, HTML = @HTML  , Categoria = @Categoria
     WHERE ID = @ID  
    
     
END  

--EXEC SPWebPaginaComunidad 'ACTUALIZAWIKI','5','15','','ADMIN','dongay@intelisis.com','Articulo','INTELISIS','&nbsp;Intelisis es un ERP..... <br />Es<br />','','','Sin Categoria'
IF @Accion = 'ACTUALIZAWIKI'  
BEGIN  
	SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
     UPDATE WEBARTICULO set HistoricoID=@HistoricoID  
     WHERE ID = @HistoricoID  
	INSERT INTO WEBARTICULO (Pagina,   HistoricoID,  FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML  ,Autorizado,  Categoria) VALUES
                            (@Pagina,  @HistoricoID,          getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML ,@Autorizado, @Categoria)   

	
END 

  
--EXEC SPWebPaginaComunidad 'BUSCAR','8','','','','','','Intelisis',''  
--EXEC SPWebPaginaComunidad 'BUSCAR','8','','','','','','Sin Categoria','' 
--EXEC SPWebPaginaComunidad 'BUSCAR','8','','','','','','Web','','','','Categoria'  
IF @Accion = 'BUSCAR'  
BEGIN  
	IF (@Categoria='Categoria')
	SELECT 'Comunidad.aspx?Pagina=' + Pagina + '&Origen=' + CONVERT(VARCHAR,id) as 'URL', Pagina, ID,  Descripcion, Usuario,  FechaHora , Categoria, Comentarios
		  FROM webarticulo  
		 WHERE (Categoria = @Descripcion)  
			   AND Autorizado = 1  And Tipo = 'Articulo'
ELSE
	SELECT 'Comunidad.aspx?Pagina=' + Pagina + '&Origen=' + CONVERT(VARCHAR,id) as 'URL', Pagina, ID,  Descripcion, Usuario,  FechaHora,  Categoria, Comentarios, Tipo
		  FROM webarticulo  
		 WHERE (Descripcion Like '%' + @Descripcion + '%' OR  
			   HTML Like '%' + @Descripcion + '%' OR  
			   Tipo Like '%' + @Descripcion + '%' OR Categoria = @Descripcion)  
			   AND Autorizado = 1  And Tipo = 'Articulo'
END  

--EXEC SPWebPaginaComunidad 'CUENTACATEGORIAS','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'CUENTACATEGORIAS'  
BEGIN  
	SELECT  TOP (100) COUNT(Categoria) AS Cantidad, Categoria 
      FROM  WebArticulo 
  GROUP BY Categoria, Autorizado, Tipo, Pagina
    HAVING  (Categoria IS NOT NULL) AND (Autorizado = 1) AND (Tipo = 'Articulo') AND (Pagina = @Pagina)
END  

--EXEC SPWebPaginaComunidad 'POSTRECIENTES','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'POSTRECIENTES'  
BEGIN  
	SELECT TOP 10 SUBSTRING(Descripcion,1,20) + '...' AS Descripcion, Pagina, ID, RamaID 
	  FROM WebArticulo 
	 WHERE Tipo = 'Articulo' AND
           Autorizado = 1 AND
           Pagina = @Pagina
	ORDER BY FechaHora desc
END  


--EXEC SPWebPaginaComunidad 'PORAUTORIZAR','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'PORAUTORIZAR'  
BEGIN  
	SELECT     TOP (100) COUNT(Categoria) AS Cantidad, Categoria,  Pagina,  Tipo
	FROM         dbo.WebArticulo
	WHERE     (Pagina = @Pagina)
	GROUP BY Categoria, Autorizado,  Tipo, Pagina
	HAVING      (Categoria IS NOT NULL) AND (Autorizado = 0)
END  

--EXEC SPWebPaginaComunidad 'CALIFICAPOST','10','95','','JESUS','dongay@intelisis.com','Articulo','','','','','','1','',''
IF @Accion = 'CALIFICAPOST'  
BEGIN  
	SELECT @TemValor2 = CONVERT(NUMERIC, @valor) 
	SELECT @TemValor = CASE  WHEN Calificacion IS NULL THEN 0 ELSE Calificacion END FROM WebArticulo WHERE id = @ID
	IF (@TemValor = 0)
		SELECT @TemValor3 =  @TemValor2
	ELSE
		SELECT @TemValor3 = (@TemValor + @TemValor2)/ 2
	UPDATE WebArticulo SET	Calificacion =  @TemValor3 WHERE id = @ID
END  

RETURN  
END  

GO


/*CREATE PROCEDURE SPWebPaginaComunidad
   @Accion			VARCHAR(25)= null,  
   @Pagina			VARCHAR(20) = null,  
   @ID				VARCHAR(255) = null,  
   @RamaID			VARCHAR(255) = null,  
   @Usuario			VARCHAR(255) = null,  
   @Correo			VARCHAR(100) = null,  
   @Tipo			VARCHAR(20) = null,  
   @Descripcion		VARCHAR(2000)= null,  
   @HTML			VARCHAR(Max) = null,  
   @URL				VARCHAR(300)= null,  
   @Sitio			VARCHAR(250) = null ,
   @Categoria		VARCHAR(250) = null ,
   @valor			VARCHAR(10)= null 
  
AS BEGIN  
  
Declare   
	@Propietario				Varchar(100),  
	@Autorizado					Bit,  
	@Notificar					Bit,
    @HistoricoID				int
						

--EXEC SPWebPaginaComunidad 'CONSULTA1','274','','','dongay@intelisis.com','','Articulo','',''    
--EXEC SPWebPaginaComunidad 'CONSULTA1','274','','','','','Articulo','',''  
IF @Accion = 'CONSULTA1'  
BEGIN  
 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
	  SELECT *, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados
		FROM WebArticulo   
	   WHERE PAGINA = @Pagina AND   
		  RAMAID  IS NULL AND   
		  Tipo = @Tipo  --'Articulo'  
	   ORDER BY FechaHora DESC
 ELSE  
	  SELECT *, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados  
		FROM WebArticulo   
	   WHERE PAGINA = @Pagina AND   
		  RAMAID  IS NULL AND   
		  Tipo = @Tipo AND --'Articulo'  
		  Autorizado = 1  
	   ORDER BY FechaHora DESC
END  
--EXEC SPWebPaginaComunidad 'CONSULTA2','11','16','','dongay@intelisis.com','','Articulo','',''
--EXEC SPWebPaginaComunidad 'CONSULTA1','271','143','','','','Articulo','',''  
IF @Accion = 'CONSULTA2'  
BEGIN  
 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
  SELECT *,CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados
    FROM WebArticulo   
   WHERE PAGINA = @Pagina AND   
      Tipo = @Tipo  and --'Articulo'  
      ID = @ID  
   ORDER BY FechaHora DESC
 ELSE  
  SELECT *,CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados
    FROM WebArticulo   
   WHERE PAGINA = @Pagina AND   
      Tipo = @Tipo  and --'Articulo'  
      ID = @ID AND  
	  Autorizado = 1  
   ORDER BY FechaHora DESC
END  
  
--EXEC SPWebPaginaComunidad 'CONSULTA3','271','143','','','','','',''  
--EXEC SPWebPaginaComunidad 'CONSULTA3','11','16','','dongay@intelisis.com','','','',''
IF @Accion = 'CONSULTA3'  
BEGIN  
 IF EXISTS(SELECT AdminPagina FROM WebPagina WHERE Pagina = @Pagina AND AdminPagina = @Usuario)  
  SELECT *, CASE Tipo WHEN 'Comentario' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados,CASE Pagado WHEN 1 THEN 0 ELSE 1 END AS 'ArticuloPagado',ItemPagado   
    FROM WebArticulo   
   WHERE PAGINA = @Pagina AND   
      RAMAID = @ID  
   ORDER BY FechaHora DESC
 ELSE  
  SELECT *, CASE Tipo WHEN 'Comentario' THEN 0 ELSE 1 END AS VisibleArticulo, CASE Autorizado WHEN 1 THEN 0 ELSE 1 END AS VerAutorizados,CASE Pagado WHEN 1 THEN 0 ELSE 1 END AS 'ArticuloPagado' ,ItemPagado   
    FROM WebArticulo   
   WHERE PAGINA = @Pagina AND   
      RAMAID = @ID AND  
               Autorizado = 1  
   ORDER BY FechaHora DESC
END  
  
--EXEC SPWebPaginaComunidad 'CONSULTAID','271','39','','JESUS','','','',''  
IF @Accion = 'EDITAID'  
BEGIN  
 SELECT * FROM WebArticulo WHERE ID = @ID  
END  
  
--EXEC SPWebPaginaComunidad 'ELIMINA','271','185','','JESUS','','','',''  
--EXEC SPWebPaginaComunidad 'ELIMINA','271','210','185','JESUS','','','',''
IF @Accion = 'ELIMINA'  
BEGIN  
	DELETE WebArticulo WHERE ID =  @ID  
	UPDATE WebArticulo SET Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID  And Autorizado = 1) WHERE ID = @RamaID  
END  
  
--EXEC SPWebPaginaComunidad 'ACTUALIZA','271','214','','JESUS','','','',''  
--EXEC SPWebPaginaComunidad 'ACTUALIZA','271','214','185','JESUS','','','','','http://localhost/Iportal/Comunidad.aspx?Pagina=271&Origen=185','PRINCIPAL'
IF @Accion = 'ACTUALIZA'  
BEGIN  
	UPDATE WebArticulo SET Autorizado = 1 WHERE ID = @ID  
	UPDATE WebArticulo SET Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID  And Autorizado = 1) WHERE ID = @RamaID  
	EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    
END  
--EXEC SPWebPaginaComunidad 'AUTORIZA_PAGO','11','17','16','admin','','','',''
IF @Accion = 'AUTORIZA_PAGO'  
BEGIN  
	
	SELECT @Propietario=Usuario,@RamaID=RamaID FROM WebArticulo  WHERE id=@ID
	UPDATE WebArticulo SET Pagado = 1 WHERE RamaID = @RamaID  OR id=@RamaID
	SELECT @valor=CostoArticulo FROM WebArticulo WHERE id=@RamaID
	UPDATE WebUsuario SET  PuntosAcumulados=PuntosAcumulados + CONVERT(INT,@valor) WHERE UsuarioWeb=@Propietario
	UPDATE WebUsuario SET  PuntosAcumulados=PuntosAcumulados - CONVERT(INT,@valor) WHERE UsuarioWeb=@Usuario
   
END  


--EXEC SPWebPaginaComunidad 'GRABAARTICULO','271','','','JESUS','dongay@intelisis.com','Articulo','Super Blog 2','Super Blog 2'  
IF @Accion = 'GRABAARTICULO'  
BEGIN  
 SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
 INSERT INTO WEBARTICULO (Pagina,   FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML,  Autorizado,  Categoria, CostoArticulo)
      VALUES             (@Pagina,  getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML, @Autorizado, @Categoria,@valor)   
	IF (@Autorizado = 1) 
		EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    


END  
  
--EXEC SPWebPaginaComunidad 'GRABACOMENTARIO','271','','185','JESUS','dongay@intelisis.com','Comentario','dos dos dos dos dos','&nbsp;dos dos','http://localhost/Iportal/Comunidad.aspx?Pagina=271&Origen=185','PRINCIPAL','Sin Categoria'    
--EXEC SPWebPaginaComunidad 'GRABACOMENTARIO','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'GRABACOMENTARIO'  
BEGIN  
 SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
 INSERT INTO WEBARTICULO (Pagina,   RamaID,  FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML  ,Autorizado,  Categoria,CostoArticulo)
      VALUES             (@Pagina,  @RamaID, getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML ,@Autorizado, @Categoria,@valor)   
	IF @Autorizado = 1 
		BEGIN
			UPDATE WebArticulo set Comentarios = (SELECT COUNT(RAMAID) FROM  WebArticulo WHERE pagina = @Pagina AND Ramaid = @RamaID And Autorizado = 1	) WHERE pagina = @Pagina AND id = @RamaID
			EXEC spWebPaginaSuscripcion 'ENVIAR',@Pagina,'','',@URL,@Sitio  -- Envia un mail con el comentario realizadoa todas las personas inscritas    
		END
END  
  
 
--EXEC SPWebPaginaComunidad 'ACTUALIZAREGISTRO','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'ACTUALIZAREGISTRO'  
BEGIN  
 UPDATE WEBARTICULO set Descripcion = @Descripcion, HTML = @HTML  , Categoria = @Categoria
     WHERE ID = @ID  
END  

--EXEC SPWebPaginaComunidad 'ACTUALIZAWIKI','5','15','','ADMIN','dongay@intelisis.com','Articulo','INTELISIS','&nbsp;Intelisis es un ERP..... <br />Es<br />','','','Sin Categoria'
IF @Accion = 'ACTUALIZAWIKI'  
BEGIN  
	SELECT @Autorizado = CASE RequiereAutorizacion WHEN 1 THEN 0 ELSE 1 END FROM WEBPAGINA WHERE Pagina = @Pagina  
	
	Select @HistoricoID= Count(HistoricoID) FROM WEBARTICULO WHERE RamaID = '15'
	if (@HistoricoID = 0 ) SELECT @HistoricoID = 1

	UPDATE WEBARTICULO set Comentarios = @HistoricoID WHERE ID = @ID   

	INSERT INTO WEBARTICULO (Pagina,   HistoricoID,  FechaHora, Usuario,  CorreoElectronico,  Tipo,  Descripcion,  HTML  ,Autorizado,  Categoria) VALUES
                            (@Pagina,  @ID,          getdate(), @Usuario, @Correo,            @Tipo, @Descripcion, @HTML ,@Autorizado, @Categoria)   

END 

  
--EXEC SPWebPaginaComunidad 'BUSCAR','271','','','','','','Intelisis',''  
--EXEC SPWebPaginaComunidad 'BUSCAR','271','','','','','','Sin Categoria','' 
IF @Accion = 'BUSCAR'  
BEGIN  
	IF (@Categoria='Categoria')
	SELECT 'Comunidad.aspx?Pagina=' + Pagina + '&Origen=' + CONVERT(VARCHAR,id) as 'URL', Pagina, ID,  Descripcion, Usuario,  FechaHora , Categoria, Comentarios
		  FROM webarticulo  
		 WHERE (Categoria = @Descripcion)  
			   AND Autorizado = 1  And Tipo = 'Articulo'
ELSE

	SELECT 'Comunidad.aspx?Pagina=' + Pagina + '&Origen=' + CONVERT(VARCHAR,id) as 'URL', Pagina, ID,  Descripcion, Usuario,  FechaHora,  Categoria, Comentarios
		  FROM webarticulo  
		 WHERE (Descripcion Like '%' + @Descripcion + '%' OR  
			   HTML Like '%' + @Descripcion + '%' OR  
			   Tipo Like '%' + @Descripcion + '%' OR Categoria = @Descripcion)  
			   AND Autorizado = 1  And Tipo = 'Articulo'
END  

--EXEC SPWebPaginaComunidad 'CUENTACATEGORIAS','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'CUENTACATEGORIAS'  
BEGIN  
	SELECT  TOP (100) COUNT(Categoria) AS Cantidad, Categoria 
      FROM  WebArticulo 
  GROUP BY Categoria, Autorizado, Tipo, Pagina
    HAVING  (Categoria IS NOT NULL) AND (Autorizado = 1) AND (Tipo = 'Articulo') AND (Pagina = @Pagina)
END  

--EXEC SPWebPaginaComunidad 'POSTRECIENTES','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'POSTRECIENTES'  
BEGIN  
	SELECT TOP 10 SUBSTRING(Descripcion,1,20) + '...' AS Descripcion, Pagina, ID, RamaID 
	  FROM WebArticulo 
	 WHERE Tipo = 'Articulo' AND
           Autorizado = 1 AND
           Pagina = @Pagina
	ORDER BY FechaHora desc
END  


--EXEC SPWebPaginaComunidad 'PORAUTORIZAR','271','','39','JESUS','dongay@intelisis.com','Comentario','segundo comentario','segundo comentario'  
IF @Accion = 'PORAUTORIZAR'  
BEGIN  
	SELECT     TOP (100) COUNT(Categoria) AS Cantidad, Categoria,  Pagina,  Tipo
	FROM         dbo.WebArticulo
	WHERE     (Pagina = @Pagina)
	GROUP BY Categoria, Autorizado,  Tipo, Pagina
	HAVING      (Categoria IS NOT NULL) AND (Autorizado = 0)
END  

RETURN  
END  
*/


/**************** WebPaginaIndicador ****************/
-- Author:			Yessenia Villacis
-- Create date:		09-Dic-2008
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebPaginaIndicador]') AND type in (N'U'))
CREATE TABLE [dbo].[WebPaginaIndicador](
	[IndicadorID] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](40) NULL,
	[SP] [varchar](40) NULL,
	[ValorMinimo] [int] NULL,
	[ValorMedio] [int] NULL,
	[ValorMaximo] [int] NULL,
 CONSTRAINT [PK_WebPaginaIndicador] PRIMARY KEY CLUSTERED 
(
	[IndicadorID] ASC
))

GO

EXEC spALTER_TABLE 'WebPaginaIndicador', 'CampoID', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPaginaIndicador', 'CampoNombre', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPaginaIndicador', 'CampoImporte', 'varchar(30) NULL'
EXEC spALTER_TABLE 'WebPaginaIndicador', 'Pagina', 'varchar(20) NULL'
GO

ALTER TABLE WebPaginaIndicador ALTER COLUMN ValorMinimo numeric(18,2)
ALTER TABLE WebPaginaIndicador ALTER COLUMN ValorMedio numeric(18,2)
ALTER TABLE WebPaginaIndicador ALTER COLUMN ValorMaximo numeric(18,2)
GO
/******************************************/
-- Author:			Yessenia Villacis
-- Create date:		03-Feb-2009

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[WebSitioAcceso]') AND type in (N'U'))

CREATE TABLE [WebSitioAcceso](
	[Sitio] [varchar](20) NOT NULL,
	[Usuario] [varchar](10) NOT NULL,
 CONSTRAINT [PK_WebSitioAcceso] PRIMARY KEY CLUSTERED 
(
	[Sitio] ASC,
	[Usuario] ASC
))

GO


/******************************************/

-- Author:			Yessenia Villacis
-- Create date:		24-Feb-2009

/*** WebUsuarioPaginas ***/
if not exists(select * from SysTabla where SysTabla = 'WebUsuarioPaginas')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebUsuarioPaginas','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebUsuarioPaginas') and type = 'U') 
	CREATE TABLE [dbo].[WebUsuarioPaginas](
		[ID] [int] NOT NULL,
		[UsuarioWeb] [varchar](20) NOT NULL,
		[Pagina] [varchar](20) NOT NULL,
		[Nombre] [varchar](100) NOT NULL,
		[Orden] [int] NOT NULL
	) ON [PRIMARY]
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Fecha de Moficacion:	31-May-2009

if exists (select * from sysobjects where id = object_id('dbo.SP_Plantilla_BanorteTarjeta') and type = 'P') drop procedure dbo.SP_Plantilla_BanorteTarjeta
GO
CREATE PROCEDURE SP_Plantilla_BanorteTarjeta
			@Pagina       Varchar(20) = null
--//WITH ENCRYPTION
AS BEGIN
	SET NOCOUNT ON
	
	IF NOT EXISTS(SELECT Pagina FROM WebPaginaParam WHERE Pagina = @Pagina)
		BEGIN
				DELETE WebPaginaParam WHERE Pagina = @Pagina

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'ClientId','ClientId','Texto',NULL,0,0,0,'19','No',NULL,NULL,NULL,NULL,NULL,1,0,NULL,0,1)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Expires','Fecha:','Texto',NULL,0,0,0,'10/10','No',NULL,NULL,NULL,NULL,NULL,7,1,'',1,0)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Mode','Mode','Texto',NULL,0,0,0,'R','No',NULL,NULL,NULL,NULL,NULL,5,1,NULL,0,1)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Name','Name','Texto',NULL,0,0,0,'tienda19','No',NULL,NULL,NULL,NULL,NULL,3,0,NULL,0,1)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Number','Tarjeta','Tarjeta',NULL,0,0,1,'4242424242424242','No',NULL,NULL,NULL,NULL,NULL,6,1,NULL,0,0)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Password','Password','Texto',NULL,0,0,0,'2006','No',NULL,NULL,NULL,NULL,NULL,2,0,NULL,0,1)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'Total','Total Compra:','Numerico',NULL,0,0,0,'10.25','No',NULL,NULL,NULL,NULL,NULL,8,1,'',1,0)

	INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
	(@Pagina,'TransType','TransType','Texto',NULL,0,0,0,'Auth','No',NULL,NULL,NULL,NULL,NULL,4,1,NULL,0,1) 		END
	RETURN
  END
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Fecha de Moficacion:	31-May-2009
if exists (select * from sysobjects where id = object_id('dbo.SP_Plantilla_PagosOnLine') and type = 'P') drop procedure dbo.SP_Plantilla_PagosOnLine
GO
CREATE PROCEDURE SP_Plantilla_PagosOnLine
			@Pagina       Varchar(20) = null
--//WITH ENCRYPTION
AS BEGIN
	SET NOCOUNT ON
	
	IF NOT EXISTS(SELECT Pagina FROM WebPaginaParam WHERE Pagina = @Pagina)
		BEGIN
				DELETE WebPaginaParam WHERE Pagina = @Pagina

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'baseDevolucionIva','Base Devolucion Iva:','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,6,1,NULL,1,0)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'descripcion','Descripcion:','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,3,1,NULL,1,0)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'extra1','Campo Usado para validar la respuesta','Texto',NULL,0,0,0,NULL,'No',NULL,NULL,NULL,NULL,NULL,10,1,NULL,0,1)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'firma','firma','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,7,1,NULL,0,1)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'iva','Iva:','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,5,1,NULL,1,0)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'PagOnvalor','Total aPagar:','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,4,1,NULL,1,0)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'prueba','prueba','Texto',NULL,0,0,0,'1','No',NULL,NULL,NULL,NULL,NULL,40,1,NULL,0,1)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'refVenta','Referencia Intelisis:','Texto',NULL,0,0,0,'','No',NULL,NULL,NULL,NULL,NULL,2,1,NULL,1,0)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'url_confirmacion','url_confirmacion','Texto',NULL,0,0,0,'http://desarrollo.intelisis.com','No',NULL,NULL,NULL,NULL,NULL,30,1,NULL,0,1)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'url_respuesta','url_respuesta','Texto',NULL,0,0,0,'http://davidongay/Iporta2/Pago.aspx','No',NULL,NULL,NULL,NULL,NULL,20,1,NULL,0,1)

			INSERT INTO WebPaginaParam (Pagina,Parametro,Nombre,TipoDatos,Tamano,EsContrasena,EsMayusculas,EsRequerido,ValorPorOmision,TipoAyuda,AyudaTabla,AyudaValor,AyudaNombre,AyudaCondicion,AyudaOrden,Orden,EspacioPrevio,Grupo,EsSoloLectura,EsOculto) Values 
			(@Pagina,'usuarioId','Usuario Sistema PagosOnline:','Texto',NULL,0,0,0,'2','No',NULL,NULL,NULL,NULL,NULL,1,1,NULL,0,1) 		END
	RETURN
  END
GO

/******************************************/
-- Author:			Yessenia Villacis
-- Fecha de Moficacion:	1-Jun-2009

if not exists (select * from sysobjects where id = object_id('WebSesionPaginaRepeticion') and type = 'U') 
 CREATE TABLE [dbo].[WebSesionPaginaRepeticion](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [SesionID] [uniqueidentifier] NULL,
    [Pagina] [varchar](20) ,
    [Parametro] [varchar](50) ,
    [NombrePanel] [varchar](50) ,
    [Tipo_Componete] [varchar](50) ,
    [Nombre] [varchar](100) ,
    [Id_Nombre] [varchar](50) ,
    [Tamano] [int] NULL,
    [EsContrasena] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EsContrasena]  DEFAULT ((0)),
    [EsMayusculas] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EsMayusculas]  DEFAULT ((0)),
    [EsRequerido] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EsRequerido]  DEFAULT ((0)),
    [ValorPorOmision] [varchar](255) ,
    [TipoAyuda] [varchar](20) ,
    [AyudaTabla] [varchar](100) ,
    [AyudaValor] [varchar](100) ,
    [AyudaNombre] [varchar](100) ,
    [AyudaCondicion] [varchar](255) ,
    [AyudaOrden] [varchar](255) ,
    [Orden] [int] NULL,
    [EspacioPrevio] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EspacioPrevio]  DEFAULT ((0)),
    [Grupo] [varchar](50) ,
    [EsSoloLectura] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EsSoloLectura]  DEFAULT ((0)),
    [EsOculto] [bit] NULL CONSTRAINT [DF_WebSesionPaginaRepeticion_EsOculto]  DEFAULT ((0)),
    [ColorEtiqueta] [varchar](10) ,
    [FondoEtiqueta] [varchar](10) ,
    [GrupoRepeticion] [varchar](50) ,
    [RepeticionLlave] [bit] NULL,
    [Refrescar] [bit] NULL,
    [DependeDe] [varchar](50) ,
 CONSTRAINT [PK_WebSesionPaginaRepeticion] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

/**************** Parametrizacion Pagina Catalogo ****************/
EXEC spALTER_TABLE 'Art','Calificacion','SMALLINT NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'anexocta','Direccion2','varchar(255) NULL'
EXEC spALTER_TABLE 'anexocta','Direccion3','varchar(255) NULL'

EXEC spALTER_TABLE 'WebPagina', 'ArticuloID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'NombreArticulo','varchar(30) NULL'
EXEC spALTER_TABLE 'WebPagina', 'DescripcionCorta','varchar(500) NULL'
EXEC spALTER_TABLE 'WebPagina', 'DescripcionLarga','varchar(1000) NULL'
EXEC spALTER_TABLE 'WebPagina', 'Precio','varchar(50) NULL'
EXEC spALTER_TABLE 'WebPagina', 'CalificacionArticulo','varchar(50) NULL'

EXEC spALTER_TABLE 'WebPagina', 'CalificacionArticuloD','varchar(50) NULL'

EXEC spALTER_TABLE 'WebPagina', 'ImagenPequena','varchar(250) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ImagenGrande','varchar(250) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ImagenCualidad','varchar(250) NULL'

EXEC spALTER_TABLE 'WebPagina', 'PermitirImagenCualidad','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'URL_ImagenCualidad','varchar(100) NULL'

EXEC spALTER_TABLE 'WebPagina', 'VerBotonComprar','BIT NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'LeyendaBotonComprar','varchar(20) NULL'

EXEC spALTER_TABLE 'WebPagina', 'VerBotonComprarD','BIT NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'LeyendaBotonComprarD','varchar(20) NULL'

EXEC spALTER_TABLE 'WebPagina', 'VerInventarioArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spInventarioArticulo','varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'spSesionInventario','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spOrigenInventario','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spPaginaInventario','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'VerCalificacionArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerCalificacionArticuloD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'SeleccionarArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'ComprarArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerSucursal','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'VerComentariosArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'ProcesarIrA','varchar(20) NULL'

EXEC spALTER_TABLE 'WebPagina', 'VerCaracteristicasArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'InformacionGeneral','text NULL'

EXEC spALTER_TABLE 'WebPagina', 'spDetalle','varchar(100) NULL'
EXEC spALTER_TABLE 'WebPagina', 'spSesionIDD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spOrigenD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'spPaginaD','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'PermitirOrdenar','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBuscar','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'PermitirImagenGrande','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'AltoImagenGrande', 'SMALLINT NULL'
EXEC spALTER_TABLE 'WebPagina', 'AnchoImagenGrande', 'smallint NULL'

EXEC spALTER_TABLE 'WebPagina', 'PermitirImagenPequeña','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'AltoImagenPequeña', 'smallint NULL'
EXEC spALTER_TABLE 'WebPagina', 'AnchoImagenPequeña', 'smallint NULL'

EXEC spALTER_TABLE 'WebPagina', 'PermitirNombreArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirPrecioArticulo','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirDescripcionCorta','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirDescripcionLarga','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'PermitirNombreArticuloD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirPrecioArticuloD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirDescripcionCortaD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirDescripcionLargaD','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'FilasPorPagina','smallint NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColumnasPorPagina','smallint NULL'

EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldPrecio','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldNombre','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldDescripcionCorta','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldDescripcionLarga','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldPrecioD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldNombreD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldDescripcionCortaD','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'PermitirBoldDescripcionLargaD','bit NOT NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'WebPagina', 'ColorPrecio','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorNombre','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorDescripcionCorta','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorDescripcionLarga','varchar(20) NULL'

EXEC spALTER_TABLE 'WebPagina', 'ColorPrecioD','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorNombreD','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorDescripcionCortaD','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'ColorDescripcionLargaD','varchar(20) NULL'

EXEC spALTER_TABLE 'WebPagina', 'URL_Imagenes','varchar(255) NULL'

EXEC spALTER_TABLE 'WebPagina', 'VerCantidad','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerTotal','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerIva','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerNeto','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'VerCuentaArticulos','bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'WebPagina', 'LeyendaBotonRegresar','varchar(20) NULL'
EXEC spALTER_TABLE 'WebPagina', 'LeyendaBotonCerrarComprar','varchar(20) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaArtAlm') and type = 'P') 
	drop procedure dbo.spWebPaginaArtAlm
GO
CREATE PROCEDURE spWebPaginaArtAlm
	@SesionID     Uniqueidentifier = null,
	@Origen       varchar(255) = null,
	@Pagina       Varchar(20) = NULL
--//WITH ENCRYPTION	
	AS BEGIN 
  SELECT DISTINCT(Alm.Nombre) AS Nombre, ASD.Almacen AS Almacen FROM ArtSubDisponible ASD  INNER JOIN Alm ON ASD.Almacen=Alm.Almacen
 WHERE Alm.Estatus='ALTA' AND ASD.Articulo=@Origen
END
GO

/*** WebPaginaArticulo ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaArticulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaArticulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaArticulo') and type = 'U') 
CREATE TABLE [dbo].[WebPaginaArticulo](
	[SesionID] [uniqueidentifier] NOT NULL,
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[Pagina] [varchar](20) NOT NULL,
	[Articulo] [varchar](20) NOT NULL,
	[SubCuenta] [varchar](50) NULL,
	[Almacen] [char](10) NULL,
	[Usuario] [varchar](20) NULL,
	[Cantidad] [smallint] NULL CONSTRAINT [DF_WebPaginaArticulo_Cantidad]  DEFAULT ((0)),
	[Precio] [money] NULL CONSTRAINT [DF_WebPaginaArticulo_Precio]  DEFAULT ((0)),
	[DescripCorta] [varchar](500) NULL,
	[DescripLarga] [varchar](1000) NULL
 CONSTRAINT [PK_WebPaginaArticulo] PRIMARY KEY CLUSTERED 
(
	[Pagina] ASC,
	[SesionID] ASC,
	[Articulo] ASC
))
if exists (select * from sysobjects where id = object_id('dbo.WebPaginaArticulo') and type = 'U') 
	EXEC spDROP_COLUMN 'WebPaginaArticulo', 'Almacen'
	
GO

EXEC spALTER_TABLE 'WebPaginaArticulo','DescripCorta','varchar(500) NULL' 
EXEC spALTER_TABLE 'WebPaginaArticulo','DescripLarga','varchar(1000) NULL' 
GO

if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaArticulo') and type = 'P') 
	drop procedure dbo.spWebPaginaArticulo
GO
create PROCEDURE spWebPaginaArticulo
	@SesionID     Uniqueidentifier = null,
	@Origen       varchar(255) = null,
	@Pagina       Varchar(20) = NULL,
	@SubCuenta    Varchar(20) = NULL,
	@Valor        smallint = 0,
	@Precio       money = 0,
	@Usuario       VARCHAR(20)=NULL,
	@DescripCorta  Varchar(500)=NULL,
	@DescripLarga  Varchar(1000)=null
--//WITH ENCRYPTION
AS BEGIN 
	IF EXISTS(SELECT * FROM WebPaginaArticulo WHERE pagina=@Pagina AND (Usuario=@usuario OR SesionID=@SesionID) AND articulo=@Origen ) -- Valido el usuario debido a que a pesar que cierre la sesion el usuario debe mantener su compra
		IF LEN(@SubCuenta)>0 
			UPDATE WebPaginaArticulo SET SubCuenta=@SubCuenta WHERE pagina=@Pagina AND SesionID=@SesionID AND articulo=@Origen
		ELSE
			IF upper(@Usuario) <> 'ANONIMOS'
			    UPDATE WebPaginaArticulo SET Cantidad=@Valor,Precio=@Precio WHERE pagina=@Pagina AND Usuario=@usuario AND articulo=@Origen
			ELSE
				BEGIN
				
					UPDATE WebPaginaArticulo SET Cantidad=@Valor,Precio=@Precio WHERE pagina=@Pagina AND SesionID=@SesionID AND articulo=@Origen
					IF @@ROWCOUNT=0
						INSERT INTO WebPaginaArticulo(Pagina,SesionID,articulo,SubCuenta,Usuario,Cantidad,Precio,DescripCorta,DescripLarga) VALUES (@Pagina,@SesionID,@Origen,@SubCuenta,@usuario,@Valor,@Precio,@DescripCorta,@DescripLarga) 
				END					
	ELSE
		INSERT INTO WebPaginaArticulo(Pagina,SesionID,articulo,SubCuenta,Usuario,Cantidad,Precio,DescripCorta,DescripLarga) VALUES (@Pagina,@SesionID,@Origen,@SubCuenta,@usuario,@Valor,@Precio,@DescripCorta,@DescripLarga) 
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaCatalogo') and type = 'P') 
	drop procedure dbo.spWebPaginaCatalogo
GO
CREATE PROCEDURE spWebPaginaCatalogo
	@SesionID     Uniqueidentifier = null,
	@Origen       varchar(255) = null,
	@Pagina       Varchar(20) = NULL,
	@Articulo     Varchar(20) = NULL,
	@Valor        smallint = NULL
--//WITH ENCRYPTION
AS BEGIN 
	DECLARE @vtipoFiltro AS BIT,@vFiltro AS VARCHAR(50),@vSP AS VARCHAR(50)
	
	IF UPPER(@Origen)='CALIFICAARTICULO'
	BEGIN
		UPDATE Art SET calificacion=@Valor WHERE articulo=@Articulo
	END 
	IF UPPER(@Origen)='OBTIENECALIFICACIONARTICULO'
	BEGIN
		SELECT Calificacion FROM Art WHERE articulo=@Articulo
	END
	IF UPPER(@Origen)='COMPRARAPIDA'
	BEGIN
		SELECT COUNT(articulo) FROM WebPaginaArticulo WHERE pagina=@Pagina AND SesionID=@SesionID
	END
	IF UPPER(@Origen)='RAMAS_CLASIFICACION'
	BEGIN
		
		SELECT @vtipoFiltro=CatalogoRama  from webpagina WHERE pagina=@Pagina
		IF @vtipoFiltro=1
			BEGIN
				PRINT 'rama'
				PRINT @Articulo
				SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
				WHERE   wMostrar=1 AND UPPER(art.Rama)=UPPER(@Articulo)
			END 
		ELSE
		    BEGIN
				SELECT @vtipoFiltro=CatalogoClasificacion,@vFiltro=TipoClasificacion from webpagina WHERE pagina=@Pagina
				IF @vtipoFiltro=1
				     BEGIN 
					   IF @vFiltro='Grupos'
							SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
							WHERE   wMostrar=1 AND (art.Grupo IS NOT NULL ) AND (art.Grupo <> '') AND UPPER(art.Grupo)=UPPER(@Articulo)
					   IF @vFiltro='Categorias'
							SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
							WHERE   wMostrar=1 AND (art.Categoria IS NOT NULL ) AND (art.Categoria <> '') AND UPPER(art.Categoria)=UPPER(@Articulo)
					   IF @vFiltro='Familias'
							SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
							WHERE   wMostrar=1 AND (art.Familia IS NOT NULL ) AND (art.Familia <> '') AND UPPER(art.Familia)=UPPER(@Articulo)
					   IF @vFiltro='Lineas'
							SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
							WHERE   wMostrar=1 AND (art.Linea IS NOT NULL ) AND (art.Linea <> '') AND UPPER(art.Linea)=UPPER(@Articulo)
					   IF @vFiltro='Fabricantes'
							SELECT * FROM art left JOIN Anexocta ON art.Articulo=Anexocta.cuenta 
							WHERE   wMostrar=1 AND (art.Fabricante IS NOT NULL ) AND (art.Fabricante <> '') AND UPPER(art.Fabricante)=UPPER(@Articulo)
					End
				ELSE
				    BEGIN
						SELECT @vtipoFiltro=CatalogoSP,@vSP=sp from webpagina WHERE pagina=@Pagina
						IF @vtipoFiltro=1 
							 EXEC @vSP @SesionID , @Articulo, @Pagina
					End
			END
	END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spWebPaginaArticuloLista') and type = 'P') 
	drop procedure dbo.spWebPaginaArticuloLista
GO
CREATE PROCEDURE spWebPaginaArticuloLista
--//WITH ENCRYPTION	
AS BEGIN 
	SELECT * FROM WebPaginaArticulolista
end
GO

/*** WebPaginaFiltro ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaFiltro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaFiltro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaFiltro') and type = 'U') 
CREATE TABLE [dbo].[WebPaginaFiltro](
	 Pagina [varchar](20) NOT NULL,
	 Filtro [varchar](50) NULL,
	 
)
GO

/*** WebPaginaArticuloLista ***/
if not exists(select * from SysTabla where SysTabla = 'WebPaginaArticuloLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('WebPaginaArticuloLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebPaginaArticuloLista') and type = 'U') 
CREATE TABLE [dbo].[WebPaginaArticuloLista](
	[Pagina] [varchar](20) NULL,
	[Titulo] [varchar](200) NULL,
	[sp] [varchar](50) NULL,
	[URL_Imagenes] [varchar](50) NULL,
	[TituloLink] [bit] NULL CONSTRAINT [DF_WebPaginaArticuloLista_TituloLink]  DEFAULT ((0)),
	[TituloURL] [varchar](20) NULL,
	[Imagen] [varchar](50) NULL,
	[Texto] [varchar](50) NULL,
	[Valor] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[TextoLink] [bit] NULL CONSTRAINT [DF_WebPaginaArticuloLista_TextoLink]  DEFAULT ((0)),
	[Borde] [bit] NULL CONSTRAINT [DF_WebPaginaArticuloLista_Borde]  DEFAULT ((0)),
	[AltoImagen] [smallint] NULL,
	[AnchoImagen] [smallint] NULL,
	[Etiqueta] [varchar](50) NULL,
	[EtiquetaURL] [varchar](20) NULL,
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[TituloColorTexto] [varchar](50) NULL,
	[TituloTamaño] [smallint] NULL,
	[TituloColorFondo] [varchar](50) NULL,
	[TituloNegrita] [bit] NULL CONSTRAINT [DF_WebPaginaArticuloLista_TituloNegrita]  DEFAULT ((0)),
	[Ubicacion] [varchar](50) NOT NULL CONSTRAINT [DF_WebPaginaArticuloLista_Ubicacion]  DEFAULT ('PRINCIPAL'),
	[Posicion] [varchar](50) NOT NULL CONSTRAINT [DF_WebPaginaArticuloLista_Posicion]  DEFAULT ('PIE'),
	[Orden] smallint NULL
 CONSTRAINT [PK_WebPaginaArticuloLista] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
))
GO

if exists (select * from sysobjects where id = object_id('dbo.spCargarCaracteristicasCatalogo') and type = 'P') 
	drop procedure dbo.spCargarCaracteristicasCatalogo
GO
CREATE PROCEDURE spCargarCaracteristicasCatalogo
	@SesionID     Uniqueidentifier = null,
	@Origen       varchar(255) = null,
	@Pagina       Varchar(20) = null
--//WITH ENCRYPTION  
AS BEGIN 
select	[Pagina]
      ,ArticuloID
      ,[NombreArticulo]
      ,[DescripcionCorta]
      ,[DescripcionLarga]
      ,[Precio]
      ,[CalificacionArticulo]
      ,[CalificacionArticuloD]
      ,[TieneDetalle] 
      ,[PermitirImagenCualidad]
      ,[URL_ImagenCualidad]
      ,[VerBotonComprar]
      ,[LeyendaBotonComprar]
      ,[VerInventarioArticulo]
      ,[spInventarioArticulo]
      ,[spSesionInventario]
      ,[spOrigenInventario]
      ,[spPaginaInventario]
      ,[VerCalificacionArticulo]
      ,[VerComentariosArticulo]
      ,[PermitirOrdenar]
      ,[PermitirBuscar]
      ,[PermitirImagenGrande]
      ,[AltoImagenGrande]
      ,[AnchoImagenGrande]
      ,[PermitirImagenPequeña]
      ,[AltoImagenPequeña]
      ,[AnchoImagenPequeña]
      ,[PermitirNombreArticulo]
      ,[PermitirPrecioArticulo]
      ,[PermitirDescripcionCorta]
      ,[PermitirDescripcionLarga]
      
      ,[PermitirNombreArticuloD]
      ,[PermitirPrecioArticuloD]
      ,[PermitirDescripcionCortaD]
      ,[PermitirDescripcionLargaD]
      
      ,[FilasPorPagina]
      ,[ColumnasPorPagina]
      ,[PermitirBoldPrecio]
      ,[PermitirBoldNombre]
      ,[PermitirBoldDescripcionCorta]
      ,[PermitirBoldDescripcionLarga]
      
      ,[PermitirBoldPrecioD]
      ,[PermitirBoldNombreD]
      ,[PermitirBoldDescripcionCortaD]
      ,[PermitirBoldDescripcionLargaD]
      
      ,[ColorPrecio]
      ,[ColorNombre]
      ,[ColorDescripcionCorta]
      ,[ColorDescripcionLarga]
      
      ,[ColorPrecioD]
      ,[ColorNombreD]
      ,[ColorDescripcionCortaD]
      ,[ColorDescripcionLargaD]
      
      ,ImagenPequena
      ,ImagenGrande
      ,ImagenCualidad
      ,URL_Imagenes
         ,[SeleccionarArticulo]
      ,[ComprarArticulo]
      ,VerBotonComprarD
      ,LeyendaBotonComprarD
      ,VerCalificacionArticuloD
      
  FROM [WebPagina] WHERE pagina=@Pagina

  
END
GO









