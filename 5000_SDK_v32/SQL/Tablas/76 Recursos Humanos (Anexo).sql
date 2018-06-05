SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/****** PersonalTitulo ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalTitulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalTitulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalTitulo') and type = 'U')
CREATE TABLE dbo.PersonalTitulo (
Titulo			char(50)
CONSTRAINT priPersonalTitulo PRIMARY KEY(Titulo))
GO

/****** PersonalDatosAcademicos ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalDatosAcademicos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalDatosAcademicos','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalDatosAcademicos') and type = 'U')
CREATE TABLE dbo.PersonalDatosAcademicos (
	Personal		char(10),
	ID			int		IDENTITY,
	Nivel			varchar(20)	NULL,
	Titulo			varchar(50)	NULL,
	Area			varchar(50)	NULL,
	Inicio			int		NULL,
	Fin			int		NULL,
	Titulado		bit		NULL,
	Certificado		varchar(20)	NULL,
	IdiomaEscrito		int		NULL,
	IdiomaHablado		int		NULL
	CONSTRAINT priPersonalDatosAcademicos PRIMARY KEY(Personal, ID))
GO

/****** PersonalDatosLaborales ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalDatosLaborales')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalDatosLaborales','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalDatosLaborales') and type = 'U')
CREATE TABLE dbo.PersonalDatosLaborales (
	Personal		char(10),
	ID			int		IDENTITY,
	Empresa			char(50)	NULL,
	Direccion		char(100)	NULL,
	Telefonos		char(50)	NULL,
	Puesto			char(50)	NULL,
	Departamento		char(50)	NULL,
	SueldoInicial		money		NULL,
	SueldoFinal		money		NULL,
	Actividades		varchar(200)	NULL,
	JefeInmediato		char(50)	NULL,
	JefePuesto		char(50)	NULL,
	JefeTelefonos		char(50)	NULL,
	FechaAlta		datetime	NULL,
	FechaBaja		datetime	NULL,
	MotivoBaja		char(50)	NULL
	CONSTRAINT priPersonalDatosLaborales PRIMARY KEY(Personal, ID))
GO

EXEC spALTER_TABLE 'Puesto', 'SueldoDef', 'money NULL'
EXEC spALTER_TABLE 'Puesto', 'Descripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Puesto', 'Titulado', 'bit NULL'
EXEC spALTER_TABLE 'Puesto', 'RequiereExperiencia', 'bit NULL'
EXEC spALTER_TABLE 'Puesto', 'TiempoExperienciaRequerido', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'TiempoExperienciaPuesto', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'TiempoExperienciaArea', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'GradoEstudio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'Conocimientos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Puesto', 'Idioma1', 'char(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeHablado1', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeLectura1', 'int	NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeEscrito1', 'int	NULL'
EXEC spALTER_TABLE 'Puesto', 'Idioma2', 'char(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeHablado2', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeLectura2', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'PorcentajeEscrito2', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'RequiereViajar', 'bit NULL'
EXEC spALTER_TABLE 'Puesto', 'RequiereAutomovil', 'bit NULL'
EXEC spALTER_TABLE 'Puesto', 'RequiereCambioResidencia', 'bit NULL'
EXEC spALTER_TABLE 'Puesto', 'Actividades', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Puesto', 'EdadMinima', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'EdadMaxima', 'int NULL'
EXEC spALTER_TABLE 'Puesto', 'EstadoCivil', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Puesto', 'Sexo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Puesto', 'SueldoRangoMinimo', 'money NULL'
EXEC spALTER_TABLE 'Puesto', 'SueldoRangoMaximo', 'money NULL'
EXEC spALTER_TABLE 'Puesto', 'PuestoReporta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'PuestoSustituye', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'Area', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'Departamento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Puesto', 'Objetivo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Puesto', 'Alcance', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Puesto', 'Funciones', 'varchar(500) NULL'
EXEC spALTER_TABLE 'Puesto', 'Responsabilidades', 'varchar(500) NULL'
EXEC spALTER_TABLE 'Puesto', 'Autoridad', 'varchar(500) NULL'
GO
EXEC spALTER_COLUMN 'Puesto', 'Objetivo', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Alcance', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Conocimientos', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Actividades', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Funciones', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Responsabilidades', 'text NULL'
EXEC spALTER_COLUMN 'Puesto', 'Autoridad', 'text NULL'
GO

if not exists (select * from sysobjects where id = object_id('dbo.PuestoTitulo') and type = 'U') 
CREATE TABLE dbo.PuestoTitulo (
	Puesto		varchar(50)	NOT NULL,
	Titulo		varchar(50)	NOT NULL
	CONSTRAINT priPuestoTitulo PRIMARY KEY CLUSTERED (Puesto, Titulo))
GO

/****** PuestoRelacion ******/
if not exists(select * from SysTabla where SysTabla = 'PuestoRelacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PuestoRelacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PuestoRelacion') and type = 'U') 
CREATE TABLE dbo.PuestoRelacion (
	Puesto		varchar(50) 	NOT NULL,
	PuestoRelacion	varchar(50) 	NOT NULL,
	Tipo		varchar(10)	NULL, -- Interna, Externa
	Motivo		varchar(100) 	NULL,

	CONSTRAINT priPuestoRelacion PRIMARY KEY CLUSTERED (PuestoRelacion)
)
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.Competencia') and type = 'U') -- drop table competencia
CREATE TABLE dbo.Competencia (
	Clave		int,
	Competencia	varchar(100)	NULL,
	NombreCorto	varchar(20)	NULL,
	Descripcion	text		NULL,
	Tipo		varchar(20)	NULL,

	CONSTRAINT priCompetencia PRIMARY KEY CLUSTERED (Clave))*/
GO
EXEC spRENAME_TABLE 'Competencia', 'Competencia_OLD', 3492
GO
EXEC spDROP_CONSTRAINT 'Competencia_OLD', 'pkCompetencia'
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.Nivel') and type = 'U') 
CREATE TABLE dbo.Nivel (
	Nivel		varchar(50)	NOT NULL,
	CONSTRAINT priNivel PRIMARY KEY CLUSTERED (Nivel))*/
GO
EXEC spRENAME_TABLE 'Nivel', 'Nivel_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.CompetenciaNivel') and type = 'U') -- drop table competencianivel
CREATE TABLE dbo.CompetenciaNivel (
	Clave		int,
	Nivel		varchar(50),
--	Grado		float
	CONSTRAINT priCompetenciaNivel PRIMARY KEY CLUSTERED (Clave, Nivel))*/
GO
EXEC spRENAME_TABLE 'CompetenciaNivel', 'CompetenciaNivel_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.CompetenciaCuestionario') and type = 'U') -- drop table CompetenciaCuestionario
CREATE TABLE dbo.CompetenciaCuestionario (
	Clave		int,
	Numero		int,
	Pregunta	text		NULL,
	Nivel		varchar(50)	NULL
	CONSTRAINT priCompetenciaCuestionario PRIMARY KEY CLUSTERED (Clave, Numero))*/
GO
EXEC spRENAME_TABLE 'CompetenciaCuestionario', 'CompetenciaCuestionario_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.CompetenciaFormato') and type = 'U') -- drop table CompetenciaFormato
CREATE TABLE dbo.CompetenciaFormato (
	ID		int		IDENTITY,
	Punto		varchar(100) NOT NULL,
	Descripcion	text		NULL,
	Clave		int		NULL,  -- Clave de la Competencia
	Nivel		varchar(50)	NULL,  -- Nivel de la Competencia
	Respuesta	varchar(20)	NULL,
	Peso		float		NULL,
	Orden		int		NULL, 
	CONSTRAINT priCompetenciaFormato PRIMARY KEY CLUSTERED (ID))*/
GO
--EXEC spFK 'CompetenciaFormato','Clave','Competencia','Clave'
GO
EXEC spRENAME_TABLE 'CompetenciaFormato', 'CompetenciaFormato_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.CompetenciaFormatoCalificacion') and type = 'U') -- drop table CompetenciaFormatoCalificacion
CREATE TABLE dbo.CompetenciaFormatoCalificacion (
	Personal		char(10),
	EvaluaPersonal		char(10),
	Fecha			datetime,
	Punto			varchar(100) NOT NULL,
	Respuesta		varchar(50), 
	Calificacion		float
	CONSTRAINT priCompetenciaFormatoCalificacion PRIMARY KEY CLUSTERED (Personal, EvaluaPersonal, Fecha, Punto))*/
GO
EXEC spRENAME_TABLE 'CompetenciaFormatoCalificacion', 'CompetenciaFormatoCalificacion_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.PuestoCompetencia') and type = 'U') -- drop table PuestoCompetencia
CREATE TABLE dbo.PuestoCompetencia (
	Puesto		varchar(50)	NOT NULL,
	Clave		Int		NOT NULL,
	Nivel		varchar(50)	NOT NULL,
	Grado		float		NULL
	CONSTRAINT priPuestoCompetencia PRIMARY KEY CLUSTERED (Puesto, Clave, Nivel))*/
GO

--EXEC spFK 'PuestoCompetencia','Clave','Competencia','Clave'
GO
EXEC spRENAME_TABLE 'PuestoCompetencia', 'PuestoCompetencia_OLD', 3492
GO
EXEC spDROP_CONSTRAINT 'PuestoCompetencia_Old', 'pkPuestoCompetencia'
GO


/*if not exists (select * from sysobjects where id = object_id('dbo.Curso') and type = 'U') -- drop table Curso
CREATE TABLE dbo.Curso (
	Curso		varchar(20)	NOT NULL,
	Nombre		varchar(100)	NULL,
	CriterioExito	Text		NULL,
	Duracion	money		NULL,
--	DuracionUnidad	char(20)	NULL,
	NumeroMaximo	int		NULL,
	Temario		Text		NULL
	CONSTRAINT priCurso PRIMARY KEY CLUSTERED (Curso))*/
GO
EXEC spRENAME_TABLE 'Curso', 'Curso_OLD', 3492
GO

/*if not exists (select * from sysobjects where id = object_id('dbo.CursoCompetencia') and type = 'U') -- drop table CursoCompetencia
CREATE TABLE dbo.CursoCompetencia (
	ID		int		IDENTITY,
	Curso		varchar(20)	NOT NULL,
	Clave		int		NOT NULL,
	Nivel		varchar(50)	NULL
	CONSTRAINT priCursoCompetencia PRIMARY KEY CLUSTERED (ID))*/
GO
--EXEC spFK 'CursoCompetencia','Clave','Competencia','Clave'
GO
EXEC spRENAME_TABLE 'CursoCompetencia', 'CursoCompetencia_OLD', 3492
GO

/****** InfoHumanSide ******/
if not exists(select * from SysTabla where SysTabla = 'InfoHumanSide')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InfoHumanSide','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.InfoHumanSide') and type = 'U') -- drop table InfoHumanSide
CREATE TABLE dbo.InfoHumanSide(
	Clave			varchar(20),
	Observaciones		Text
	CONSTRAINT priInfoHumanSide PRIMARY KEY CLUSTERED (Clave))
GO

if not exists(SELECT * FROM InfoHumanSide)
BEGIN
	INSERT INTO InfoHumanSide(Clave, Observaciones) VALUES ('Spranger', 'Indica tus preferencias personales en cada uno de los 10 grupos de valores enlistados a continuación: 6 el que escogerías primero, 5 el que escogerías en segundo lugar y así hasta que pongas el número 1 a la que escogerías en último lugar. Debes de colocar un número a todos los factores y no es válido poner empates.')
	INSERT INTO InfoHumanSide(Clave, Observaciones) VALUES ('Herman', 'Cuestionario Diseñado para conocer preferencias en el estilo de pensamiento, aprendizaje y comunicación. No es una prueba de inteligencia. No hay respuestas buenas o malas. Contesta utilizando la siguiente escala: 5 me gusta mucho o me describe muy bien, 4 me gusta o me describe relativamente bien, 3 me gusta o me describe en forma regular, 2 me disgusta o no me describe, 1 me disgusta o no se aplica a mí. Pueden repetirse valores.')
	INSERT INTO InfoHumanSide(Clave, Observaciones) VALUES ('Cleaver', 'Las palabras descriptivas siguientes se encuentran agrupadas en series de cuatro; habilite el campo de la izquierda de la palabra que se identifica con usted y el campo de la derecha de la palabra con el que menos se identifique.')
END
Go

/*
if not exists(SELECT * FROM Competencia)
BEGIN
	INSERT INTO Competencia(Clave, Competencia) VALUES (1, 'Capacidad de Análisis')
	INSERT INTO Competencia(Clave, Competencia) VALUES (2, 'Comunicación')
	INSERT INTO Competencia(Clave, Competencia) VALUES (3, 'Coordinación de Grupos')
	INSERT INTO Competencia(Clave, Competencia) VALUES (4, 'Creatividad')
	INSERT INTO Competencia(Clave, Competencia) VALUES (5, 'Empuje')
	INSERT INTO Competencia(Clave, Competencia) VALUES (6, 'Liderazgo')
	INSERT INTO Competencia(Clave, Competencia) VALUES (7, 'Negociación')
	INSERT INTO Competencia(Clave, Competencia) VALUES (8, 'Orientación a Resultados')
	INSERT INTO Competencia(Clave, Competencia) VALUES (9, 'Proactividad')
	INSERT INTO Competencia(Clave, Competencia) VALUES (10, 'Relaciones Interpersonales')
	INSERT INTO Competencia(Clave, Competencia) VALUES (11, 'Trabajo en Equipo')
	INSERT INTO Competencia(Clave, Competencia) VALUES (12, 'Actitud de Servicio')
	INSERT INTO Competencia(Clave, Competencia) VALUES (13, 'Artes Gráficas / Dibujo')
	INSERT INTO Competencia(Clave, Competencia) VALUES (14, 'Coordinación de Personal')
	INSERT INTO Competencia(Clave, Competencia) VALUES (15, 'Manejo del Tiempo')
	INSERT INTO Competencia(Clave, Competencia) VALUES (16, 'Espíritu Emprendedor')
	INSERT INTO Competencia(Clave, Competencia) VALUES (17, 'Persuasión')
	INSERT INTO Competencia(Clave, Competencia) VALUES (18, 'Tenacidad')
	INSERT INTO Competencia(Clave, Competencia) VALUES (19, 'Hablar en Público')
	INSERT INTO Competencia(Clave, Competencia) VALUES (20, 'Investigación')
	INSERT INTO Competencia(Clave, Competencia) VALUES (21, 'Visión de Negocio')
	INSERT INTO Competencia(Clave, Competencia) VALUES (22, 'Toma de Decisiones')
	INSERT INTO Competencia(Clave, Competencia) VALUES (23, 'Trabajo bajo Presión')
	INSERT INTO Competencia(Clave, Competencia) VALUES (24, 'Flexibilidad')
END
GO*/

if not exists(SELECT * FROM TablaEvaluacion WHERE TablaEvaluacion = 'E/F/O/N')
BEGIN
	INSERT INTO TablaEvaluacion(TablaEvaluacion) VALUES('E/F/O/N')
	INSERT INTO TablaEvaluacionD(TablaEvaluacion, Nombre, Valor, Orden) VALUES('E/F/O/N', 'Ejemplar', 10.0, 1)
	INSERT INTO TablaEvaluacionD(TablaEvaluacion, Nombre, Valor, Orden) VALUES('E/F/O/N', 'Frecuente', 6.0, 2)
	INSERT INTO TablaEvaluacionD(TablaEvaluacion, Nombre, Valor, Orden) VALUES('E/F/O/N', 'Ocasional', 3.0, 3)
	INSERT INTO TablaEvaluacionD(TablaEvaluacion, Nombre, Valor, Orden) VALUES('E/F/O/N', 'Nunca', 0.0, 4)
END
Go

/****** PersonalHerman ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalHerman')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalHerman','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalHerman') and type = 'U') 
CREATE TABLE dbo.PersonalHerman (
	Personal		char(10)	NOT NULL,
	Artisticos		int		NOT NULL,
	Sociales		int		NOT NULL,
	Cientificos		int		NOT NULL,
	Deportivos		int		NOT NULL,
	Matematicas		int		NOT NULL,
	Musica			int		NOT NULL,
	Filosofia		int		NOT NULL,
	Idiomas			int		NOT NULL,
	Alegres			int		NOT NULL,
	Organizadores		int		NOT NULL,
	Soñadores		int		NOT NULL,
	Practicas		int		NOT NULL,
	Formulas		int		NOT NULL,
	Procedimientos		int		NOT NULL,
	Imagenes		int		NOT NULL,
	Sentimientos		int		NOT NULL,
	Imaginativos		int		NOT NULL,
	Inspiradores		int		NOT NULL,
	Cuestionadores		int		NOT NULL,
	Disciplinados		int		NOT NULL,
	Creativo		int		NOT NULL,
	Emocional		int		NOT NULL,
	Tecnico			int		NOT NULL,
	Comunicativo		int		NOT NULL,
	Organizado		int		NOT NULL,
	Conservador		int		NOT NULL,
	Controlado		int		NOT NULL,
	Cuantitativo		int		NOT NULL,
	Analitico		int		NOT NULL,
	Intuitivo		int		NOT NULL,
	Cientifico		int		NOT NULL,
	Visionario		int		NOT NULL,
	Musical			int		NOT NULL,
	Detallista		int		NOT NULL,
	Racional		int		NOT NULL,
	Comprensivo		int		NOT NULL,
	Matematico		int		NOT NULL,
	Original		int		NOT NULL,
	Conceptual		int		NOT NULL,
	Afectuoso		int		NOT NULL,
	JuzgarHechos		int		NOT NULL,
	Filosofar		int		NOT NULL,
	Confiable		int		NOT NULL,
	BienOriganizado		int		NOT NULL,
	PensarGrande		int		NOT NULL,
	Adaptarme		int		NOT NULL,
	EvaluarSituaciones	int		NOT NULL,
	SeguirMetodos		int		NOT NULL,
	UsarDiagramas		int		NOT NULL,
	DesarrollarEnfoques	int		NOT NULL,
	TrabajoEnEquipo		int		NOT NULL,
	ExplorarTeorias		int		NOT NULL,
	Ordenar			int		NOT NULL,
	CompartirSentimientos	int		NOT NULL,
	DiseñarProductos	int		NOT NULL,
	ResolverEsquemas	int		NOT NULL,
	AnalizarResultados	int		NOT NULL,
	Divertirme		int		NOT NULL,
	IntegradoConIdeas	int		NOT NULL,
	PlanearTrabajo		int		NOT NULL,
CONSTRAINT priPersonalHerman PRIMARY KEY CLUSTERED (Personal))
GO

/****** PersonalSpranger ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalSpranger')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalSpranger','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalSpranger') and type = 'U') 
CREATE TABLE dbo.PersonalSpranger (
	Personal				char(10)	NOT NULL,
	Liderazgo				int		NOT NULL,
	Justicia				int		NOT NULL,
	Cultura					int		NOT NULL,
	Dinero					int		NOT NULL,
	Servicio				int		NOT NULL,
	Conocimientos				int		NOT NULL,
	DirigirPersonas				int		NOT NULL,
	ContinuarEstudiando			int		NOT NULL,
	CristalizarSueños			int		NOT NULL,
	AyudarOtros				int		NOT NULL,
	IncrementarRiquezas			int		NOT NULL,
	ParticiparArte				int		NOT NULL,
	Caritativos				int		NOT NULL,
	Estudios				int		NOT NULL,
	Politica				int		NOT NULL,
	Inversiones				int		NOT NULL,
	Museos					int		NOT NULL,
	Meditacion				int		NOT NULL,
	Artisticas				int		NOT NULL,
	Cientificas				int		NOT NULL,
	Empresariales				int		NOT NULL,
	PoliticaStatus				int		NOT NULL,
	Justicia2				int		NOT NULL,
	Servicio2				int		NOT NULL,
	CrecimientoEspiritual 			int		NOT NULL,
	RelacionesInterpersonales		int		NOT NULL,
	HabilidadesLiderazgo			int		NOT NULL,
	FinanzasPersonales			int		NOT NULL,
	ContinuacionEstudios			int		NOT NULL,
	DesarrolloArtistico			int		NOT NULL,
	CienciasFisicas				int		NOT NULL,
	CienciasPoliticas			int		NOT NULL,
	Teologia				int		NOT NULL,
	Artes					int		NOT NULL,
	Finanzas				int		NOT NULL,
	Sociologia				int		NOT NULL,
	Poderoso				int		NOT NULL,
	Bondadoso				int		NOT NULL,
	Capitalista				int		NOT NULL,
	Mediador				int		NOT NULL,
	Artista					int		NOT NULL,
	Intelectual				int		NOT NULL,
	Filantropo				int		NOT NULL,
	Empresario				int		NOT NULL,
	LiderPolitico				int		NOT NULL,
	PatrocinadorArte			int		NOT NULL,
	LiderIntelectual			int		NOT NULL,
	ConsejeroEspiritual			int		NOT NULL,
	Humanitarias				int		NOT NULL,
	Economicas				int		NOT NULL,
	Cientificas2				int		NOT NULL,
	SerLider				int		NOT NULL,
	SerErudito				int		NOT NULL,
	ReformadorSocial			int		NOT NULL,
	Enseñanza				int		NOT NULL,
	Drama					int		NOT NULL,
	TrabajoSocial				int		NOT NULL,
	Negocios				int		NOT NULL,
	Deportes				int		NOT NULL,
	Religion				int		NOT NULL,
CONSTRAINT priPersonalSpranger PRIMARY KEY CLUSTERED (Personal))
GO

if exists (select * from sysobjects where id = object_id('dbo.tgPersonalSpranger') and type = 'TR') 
DROP TRIGGER tgPersonalSpranger
GO

CREATE TRIGGER tgPersonalSpranger
ON PersonalSpranger
FOR INSERT, UPDATE


AS
BEGIN
	DECLARE
	@Grupo		char(30),
	@Mensaje	char(255)

    IF dbo.fnEstaSincronizando() = 1 RETURN
  
	CREATE TABLE #PersonalSpranger(
	Concepto		char(30)	COLLATE Database_Default,
	Grupo			char(30)	COLLATE Database_Default,
	Valor			int)

	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Liderazgo', 'Intereses Personales', Liderazgo FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Justicia', 'Intereses Personales', Justicia FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Cultura', 'Intereses Personales', Cultura FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Dinero', 'Intereses Personales', Dinero FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Servicio', 'Intereses Personales', Servicio FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Conocimientos', 'Intereses Personales', Conocimientos FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'DirigirPersonas', 'Motivadores Personales', DirigirPersonas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'ContinuarEstudiando', 'Motivadores Personales', ContinuarEstudiando FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'CristalizarSueños', 'Motivadores Personales', CristalizarSueños FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'AyudarOtros', 'Motivadores Personales', AyudarOtros FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'IncrementarRiquezas', 'Motivadores Personales', IncrementarRiquezas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'ParticiparArte', 'Motivadores Personales', ParticiparArte FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Caritativos', 'Pasatiempos Favoritos', Caritativos FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Estudios', 'Pasatiempos Favoritos', Estudios FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Politica', 'Pasatiempos Favoritos', Politica FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Inversiones', 'Pasatiempos Favoritos', Inversiones FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Museos', 'Pasatiempos Favoritos', Museos FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Meditacion', 'Pasatiempos Favoritos', Meditacion FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Artisticas', 'Metas Profesionales', Artisticas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Cientificas', 'Metas Profesionales', Cientificas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Empresariales', 'Metas Profesionales', Empresariales FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'PoliticaStatus', 'Metas Profesionales', PoliticaStatus FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Justicia2', 'Metas Profesionales', Justicia2 FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Servicio2', 'Metas Profesionales', Servicio2 FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'CrecimientoEspiritual', 'Autodesarrollo', CrecimientoEspiritual FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'RelacionesInterpersonales', 'Autodesarrollo', RelacionesInterpersonales FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'HabilidadesLiderazgo', 'Autodesarrollo', HabilidadesLiderazgo FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'FinanzasPersonales', 'Autodesarrollo', FinanzasPersonales FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'ContinuacionEstudios', 'Autodesarrollo', ContinuacionEstudios FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'DesarrolloArtistico', 'Autodesarrollo', DesarrolloArtistico FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'CienciasFisicas', 'Intereses Educacionales', CienciasFisicas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'CienciasPoliticas', 'Intereses Educacionales', CienciasPoliticas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Teologia', 'Intereses Educacionales', Teologia FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Artes', 'Intereses Educacionales', Artes FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Finanzas', 'Intereses Educacionales', Finanzas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Sociologia', 'Intereses Educacionales', Sociologia FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Poderoso', 'Reputacion Deseada', Poderoso FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Bondadoso', 'Reputacion Deseada', Bondadoso FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Capitalista', 'Reputacion Deseada', Capitalista FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Mediador', 'Reputacion Deseada', Mediador FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Artista', 'Reputacion Deseada', Artista FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Intelectual', 'Reputacion Deseada', Intelectual FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Filantropo', 'Papel En la Sociedad', Filantropo FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Empresario', 'Papel En la Sociedad', Empresario FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'LiderPolitico', 'Papel En la Sociedad', LiderPolitico FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'PatrocinadorArte', 'Papel En la Sociedad', PatrocinadorArte FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'LiderIntelectual', 'Papel En la Sociedad', LiderIntelectual FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'ConsejeroEspiritual', 'Papel En la Sociedad', ConsejeroEspiritual FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Humanitarias', 'Metas Personales', Humanitarias FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Economicas', 'Metas Personales', Economicas FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Cientificas2', 'Metas Personales', Cientificas2 FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'SerLider', 'Metas Personales', SerLider FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'SerErudito', 'Metas Personales', SerErudito FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'ReformadorSocial', 'Metas Personales', ReformadorSocial FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Enseñanza', 'Vocacion', Enseñanza FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Drama', 'Vocacion', Drama FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'TrabajoSocial', 'Vocacion', TrabajoSocial FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Negocios', 'Vocacion', Negocios FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Deportes', 'Vocacion', Deportes FROM Inserted
	INSERT INTO #PersonalSpranger(Concepto, Grupo, Valor) SELECT 'Religion', 'Vocacion', Religion FROM Inserted

	IF EXISTS(SELECT Grupo FROM #PersonalSpranger GROUP BY Grupo, Valor Having Count(Valor) > 1)
		BEGIN
			SELECT @Grupo = Grupo FROM #PersonalSpranger GROUP BY Grupo, Valor Having Count(Valor) > 1
			SELECT @Mensaje = 'Existen valores repetidos en el Grupo ' + RTRIM(@Grupo)
			RAISERROR (@Mensaje,16,-1) 
		END

RETURN
END
GO

/****** PersonalCleaver ******/
if not exists(select * from SysTabla where SysTabla = 'PersonalCleaver')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PersonalCleaver','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.PersonalCleaver') and type = 'U') -- drop table PersonalCleaver
CREATE TABLE dbo.PersonalCleaver (
	Personal		char(10),
	PersuasivoM		bit	NOT NULL,
	PersuasivoL		bit	NOT NULL,
	GentilM			bit	NOT NULL,
	GentilL			bit	NOT NULL,
	HumildeM		bit	NOT NULL,
	HumildeL		bit	NOT NULL,
	OriginalM		bit	NOT NULL,
	OriginalL		bit	NOT NULL,
	AgresivoM		bit	NOT NULL,
	AgresivoL		bit	NOT NULL,
	AlmaFiestaM		bit	NOT NULL,
	AlmaFiestaL		bit	NOT NULL,
	ComodinoM		bit	NOT NULL,
	ComodinoL		bit	NOT NULL,
	TemerosoM		bit	NOT NULL,
	TemerosoL		bit	NOT NULL,
	AgradableM		bit	NOT NULL,
	AgradableL		bit	NOT NULL,
	TemerosoDiosM		bit	NOT NULL,
	TemerosoDiosL		bit	NOT NULL,
	TenazM			bit	NOT NULL,
	TenazL			bit	NOT NULL,
	AtractivoM		bit	NOT NULL,
	AtractivoL		bit	NOT NULL,
	CautelosoM		bit	NOT NULL,
	CautelosoL		bit	NOT NULL,
	DeterminadoM		bit	NOT NULL,
	DeterminadoL		bit	NOT NULL,
	ConvincenteM		bit	NOT NULL,
	ConvincenteL		bit	NOT NULL,
	BonachonM		bit	NOT NULL,
	BonachonL		bit	NOT NULL,
	DocilM			bit	NOT NULL,
	DocilL			bit	NOT NULL,
	AtrevidoM		bit	NOT NULL,
	AtrevidoL		bit	NOT NULL,
	LealM			bit	NOT NULL,
	LealL			bit	NOT NULL,
	EncantadorM		bit	NOT NULL,
	EncantadorL		bit	NOT NULL,
	DispuestoM		bit	NOT NULL,
	DispuestoL		bit	NOT NULL,
	DeseosoM		bit	NOT NULL,
	DeseosoL		bit	NOT NULL,
	ConsecuenteM		bit	NOT NULL,
	ConsecuenteL		bit	NOT NULL,
	EntusiastaM		bit	NOT NULL,
	EntusiastaL		bit	NOT NULL,
	FuerzaVoluntadM		bit	NOT NULL,
	FuerzaVoluntadL		bit	NOT NULL,
	MenteAbiertaM		bit	NOT NULL,
	MenteAbiertaL		bit	NOT NULL,
	ComplacienteM		bit	NOT NULL,
	ComplacienteL		bit	NOT NULL,
	AnimosoM		bit	NOT NULL,
	AnimosoL		bit	NOT NULL,
	ConfiadoM		bit	NOT NULL,
	ConfiadoL		bit	NOT NULL,
	SimpatizadorM		bit	NOT NULL,
	SimpatizadorL		bit	NOT NULL,
	ToleranteM		bit	NOT NULL,
	ToleranteL		bit	NOT NULL,
	AfirmativoM		bit	NOT NULL,
	AfirmativoL		bit	NOT NULL,
	EcuanimeM		bit	NOT NULL,
	EcuanimeL		bit	NOT NULL,
	PrecisoM		bit	NOT NULL,
	PrecisoL		bit	NOT NULL,
	NerviosoM		bit	NOT NULL,
	NerviosoL		bit	NOT NULL,
	JovialM			bit	NOT NULL,
	JovialL			bit	NOT NULL,
	DisciplinadoM		bit	NOT NULL,
	DisciplinadoL		bit	NOT NULL,
	GenerosoM		bit	NOT NULL,
	GenerosoL		bit	NOT NULL,
	Animoso2M		bit	NOT NULL,
	Animoso2L		bit	NOT NULL,
	PersistenteM		bit	NOT NULL,
	PersistenteL		bit	NOT NULL,
	CompetitivoM		bit	NOT NULL,
	CompetitivoL		bit	NOT NULL,
	AlegreM			bit	NOT NULL,
	AlegreL			bit	NOT NULL,
	ConsideradoM		bit	NOT NULL,
	ConsideradoL		bit	NOT NULL,
	ArmoniosoM		bit	NOT NULL,
	ArmoniosoL		bit	NOT NULL,
	AdmirableM		bit	NOT NULL,
	AdmirableL		bit	NOT NULL,
	BondadosoM		bit	NOT NULL,
	BondadosoL		bit	NOT NULL,
	ResignadoM		bit	NOT NULL,
	ResignadoL		bit	NOT NULL,
	CaracterM		bit	NOT NULL,
	CaracterL		bit	NOT NULL,
	ObedienteM		bit	NOT NULL,
	ObedienteL		bit	NOT NULL,
	QuisquillosoM		bit	NOT NULL,
	QuisquillosoL		bit	NOT NULL,
	InconquistableM		bit	NOT NULL,
	InconquistableL		bit	NOT NULL,
	JuguetonM		bit	NOT NULL,
	JuguetonL		bit	NOT NULL,
	RespetuosoM		bit	NOT NULL,
	RespetuosoL		bit	NOT NULL,
	EmprendedorM		bit	NOT NULL,
	EmprendedorL		bit	NOT NULL,
	OptimistaM		bit	NOT NULL,
	OptimistaL		bit	NOT NULL,
	ServicialM		bit	NOT NULL,
	ServicialL		bit	NOT NULL,
	ValienteM		bit	NOT NULL,
	ValienteL		bit	NOT NULL,
	InspiradorM		bit	NOT NULL,
	InspiradorL		bit	NOT NULL,
	SumisoM			bit	NOT NULL,
	SumisoL			bit	NOT NULL,
	TimidoM			bit	NOT NULL,
	TimidoL			bit	NOT NULL,
	AdaptableM		bit	NOT NULL,
	AdaptableL		bit	NOT NULL,
	DisputadorM		bit	NOT NULL,
	DisputadorL		bit	NOT NULL,
	IndiferenteM		bit	NOT NULL,
	IndiferenteL		bit	NOT NULL,
	SangreLivianaM		bit	NOT NULL,
	SangreLivianaL		bit	NOT NULL,
	AmigueroM		bit	NOT NULL,
	AmigueroL		bit	NOT NULL,
	PacienteM		bit	NOT NULL,
	PacienteL		bit	NOT NULL,
	ConfianzaMismoM		bit	NOT NULL,
	ConfianzaMismoL		bit	NOT NULL,
	MesuradoHablarM		bit	NOT NULL,
	MesuradoHablarL		bit	NOT NULL,
	ConformeM		bit	NOT NULL,
	ConformeL		bit	NOT NULL,
	ConfiableM		bit	NOT NULL,
	ConfiableL		bit	NOT NULL,
	PacificoM		bit	NOT NULL,
	PacificoL		bit	NOT NULL,
	PositivoM		bit	NOT NULL,
	PositivoL		bit	NOT NULL,
	AventureroM		bit	NOT NULL,
	AventureroL		bit	NOT NULL,
	ReceptivoM		bit	NOT NULL,
	ReceptivoL		bit	NOT NULL,
	CordialM		bit	NOT NULL,
	CordialL		bit	NOT NULL,
	ModeradoM		bit	NOT NULL,
	ModeradoL		bit	NOT NULL,
	IndulgenteM		bit	NOT NULL,
	IndulgenteL		bit	NOT NULL,
	EstetaM			bit	NOT NULL,
	EstetaL			bit	NOT NULL,
	VigorosoM		bit	NOT NULL,
	VigorosoL		bit	NOT NULL,
	SociableM		bit	NOT NULL,
	SociableL		bit	NOT NULL,
	ParlanchinM		bit	NOT NULL,
	ParlanchinL		bit	NOT NULL,
	ControladoM		bit	NOT NULL,
	ControladoL		bit	NOT NULL,
	ConvencionalM		bit	NOT NULL,
	ConvencionalL		bit	NOT NULL,
	DecisivoM		bit	NOT NULL,
	DecisivoL		bit	NOT NULL,
	CohibidoM		bit	NOT NULL,
	CohibidoL		bit	NOT NULL,
	ExactoM			bit	NOT NULL,
	ExactoL			bit	NOT NULL,
	FrancoM			bit	NOT NULL,
	FrancoL			bit	NOT NULL,
	BuenCompañeroM		bit	NOT NULL,
	BuenCompañeroL		bit	NOT NULL,
	DiplomaticoM		bit	NOT NULL,
	DiplomaticoL		bit	NOT NULL,
	AudazM			bit	NOT NULL,
	AudazL			bit	NOT NULL,
	RefinadoM		bit	NOT NULL,
	RefinadoL		bit	NOT NULL,
	SatisfechoM		bit	NOT NULL,
	SatisfechoL		bit	NOT NULL,
	InquietoM		bit	NOT NULL,
	InquietoL		bit	NOT NULL,
	PopularM		bit	NOT NULL,
	PopularL		bit	NOT NULL,
	BuenVecinoM		bit	NOT NULL,
	BuenVecinoL		bit	NOT NULL,
	DevotoM			bit	NOT NULL,
	DevotoL			bit	NOT NULL
CONSTRAINT priPersonalCleaver PRIMARY KEY CLUSTERED (Personal))
GO

if exists (select * from sysobjects where id = object_id('dbo.tgPersonalCleaver') and type = 'TR') 
DROP TRIGGER tgPersonalCleaver
GO

CREATE TRIGGER tgPersonalCleaver
ON PersonalCleaver
FOR INSERT, UPDATE

AS
BEGIN
 DECLARE 
	@Concepto	char(30),
	@GrupoM		char(2),
	@GrupoL		char(2),
	@Clave		char(1),
	@Seccion	char(1),
	@Mensaje	char(255)

    IF dbo.fnEstaSincronizando() = 1 RETURN
  
	CREATE TABLE #PersonalCleaver(
	Concepto		char(30)	COLLATE Database_Default,
	Grupo			char(30)	COLLATE Database_Default,
	ValorM			bit		NULL,
	ValorL			bit		NULL)

	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PersuasivoM', 'A1', PersuasivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PersuasivoL', 'A1', PersuasivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'GentilM', 'A1', GentilM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'GentilL', 'A1', GentilL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'HumildeM', 'A1', HumildeM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'HumildeL', 'A1', HumildeL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'OriginalM', 'A1', OriginalM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'OriginalL', 'A1', OriginalL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AgresivoM', 'A2', AgresivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AgresivoL', 'A2', AgresivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AlmaFiestaM', 'A2', AlmaFiestaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AlmaFiestaL', 'A2', AlmaFiestaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ComodinoM', 'A2', ComodinoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ComodinoL', 'A2', ComodinoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'TemerosoM', 'A2', TemerosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'TemerosoL', 'A2', TemerosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AgradableM', 'A3', AgradableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AgradableL', 'A3', AgradableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'TemerosoDiosM', 'A3', TemerosoDiosM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'TemerosoDiosL', 'A3', TemerosoDiosL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'TenazM', 'A3', TenazM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'TenazL', 'A3', TenazL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AtractivoM', 'A3', AtractivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AtractivoL', 'A3', AtractivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'CautelosoM', 'A4', CautelosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'CautelosoL', 'A4', CautelosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DeterminadoM', 'A4', DeterminadoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DeterminadoL', 'A4', DeterminadoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConvincenteM', 'A4', ConvincenteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConvincenteL', 'A4', ConvincenteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'BonachonM', 'A4', BonachonM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'BonachonL', 'A4', BonachonL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DocilM', 'A5', DocilM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DocilL', 'A5', DocilL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AtrevidoM', 'A5', AtrevidoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AtrevidoL', 'A5', AtrevidoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'LealM', 'A5', LealM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'LealL', 'A5', LealL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'EncantadorM', 'A5', EncantadorM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'EncantadorL', 'A5', EncantadorL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DispuestoM', 'A6', DispuestoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DispuestoL', 'A6', DispuestoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DeseosoM', 'A6', DeseosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DeseosoL', 'A6', DeseosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConsecuenteM', 'A6', ConsecuenteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConsecuenteL', 'A6', ConsecuenteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'EntusiastaM', 'A6', EntusiastaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'EntusiastaL', 'A6', EntusiastaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'FuerzaVoluntadM', 'B1', FuerzaVoluntadM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'FuerzaVoluntadL', 'B1', FuerzaVoluntadL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'MenteAbiertaM', 'B1', MenteAbiertaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'MenteAbiertaL', 'B1', MenteAbiertaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ComplacienteM', 'B1', ComplacienteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ComplacienteL', 'B1', ComplacienteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AnimosoM', 'B1', AnimosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AnimosoL', 'B1', AnimosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConfiadoM', 'B2', ConfiadoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConfiadoL', 'B2', ConfiadoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'SimpatizadorM', 'B2', SimpatizadorM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'SimpatizadorL', 'B2', SimpatizadorL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ToleranteM', 'B2', ToleranteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ToleranteL', 'B2', ToleranteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AfirmativoM', 'B2', AfirmativoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AfirmativoL', 'B2', AfirmativoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'EcuanimeM', 'B3', EcuanimeM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'EcuanimeL', 'B3', EcuanimeL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PrecisoM', 'B3', PrecisoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PrecisoL', 'B3', PrecisoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'NerviosoM', 'B3', NerviosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'NerviosoL', 'B3', NerviosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'JovialM', 'B3', JovialM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'JovialL', 'B3', JovialL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DisciplinadoM', 'B4', DisciplinadoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DisciplinadoL', 'B4', DisciplinadoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'GenerosoM', 'B4', GenerosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'GenerosoL', 'B4', GenerosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'Animoso2M', 'B4', Animoso2M FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'Animoso2L', 'B4', Animoso2L FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PersistenteM', 'B4', PersistenteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PersistenteL', 'B4', PersistenteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'CompetitivoM', 'B5', CompetitivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'CompetitivoL', 'B5', CompetitivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AlegreM', 'B5', AlegreM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AlegreL', 'B5', AlegreL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConsideradoM', 'B5', ConsideradoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConsideradoL', 'B5', ConsideradoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ArmoniosoM', 'B5', ArmoniosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ArmoniosoL', 'B5', ArmoniosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AdmirableM', 'B6', AdmirableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AdmirableL', 'B6', AdmirableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'BondadosoM', 'B6', BondadosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'BondadosoL', 'B6', BondadosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ResignadoM', 'B6', ResignadoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ResignadoL', 'B6', ResignadoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'CaracterM', 'B6', CaracterM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'CaracterL', 'B6', CaracterL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ObedienteM', 'C1', ObedienteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ObedienteL', 'C1', ObedienteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'QuisquillosoM', 'C1', QuisquillosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'QuisquillosoL', 'C1', QuisquillosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'InconquistableM', 'C1', InconquistableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'InconquistableL', 'C1', InconquistableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'JuguetonM', 'C1', JuguetonM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'JuguetonL', 'C1', JuguetonL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'RespetuosoM', 'C2', RespetuosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'RespetuosoL', 'C2', RespetuosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'EmprendedorM', 'C2', EmprendedorM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'EmprendedorL', 'C2', EmprendedorL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'OptimistaM', 'C2', OptimistaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'OptimistaL', 'C2', OptimistaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ServicialM', 'C2', ServicialM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ServicialL', 'C', ServicialL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ValienteM', 'C3', ValienteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ValienteL', 'C3', ValienteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'InspiradorM', 'C3', InspiradorM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'InspiradorL', 'C3', InspiradorL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'SumisoM', 'C3', SumisoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'SumisoL', 'C3', SumisoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'TimidoM', 'C3', TimidoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'TimidoL', 'C3', TimidoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AdaptableM', 'C4', AdaptableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AdaptableL', 'C4', AdaptableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DisputadorM', 'C4', DisputadorM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DisputadorL', 'C4', DisputadorL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'IndiferenteM', 'C4', IndiferenteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'IndiferenteL', 'C4', IndiferenteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'SangreLivianaM', 'C4', SangreLivianaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'SangreLivianaL', 'C4', SangreLivianaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AmigueroM', 'C5', AmigueroM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AmigueroL', 'C5', AmigueroL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PacienteM', 'C5', PacienteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PacienteL', 'C5', PacienteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConfianzaMismoM', 'C5', ConfianzaMismoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConfianzaMismoL', 'C5', ConfianzaMismoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'MesuradoHablarM', 'C5', MesuradoHablarM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'MesuradoHablarL', 'C5', MesuradoHablarL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConformeM', 'C6', ConformeM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConformeL', 'C6', ConformeL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConfiableM', 'C6', ConfiableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConfiableL', 'C6', ConfiableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PacificoM', 'C6', PacificoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PacificoL', 'C6', PacificoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PositivoM', 'C6', PositivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PositivoL', 'C6', PositivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AventureroM', 'D1', AventureroM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AventureroL', 'D1', AventureroL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ReceptivoM', 'D1', ReceptivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ReceptivoL', 'D1', ReceptivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'CordialM', 'D1', CordialM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'CordialL', 'D1', CordialL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ModeradoM', 'D1', ModeradoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ModeradoL', 'D1', ModeradoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'IndulgenteM', 'D2', IndulgenteM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'IndulgenteL', 'D2', IndulgenteL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'EstetaM', 'D2', EstetaM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'EstetaL', 'D2', EstetaL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'VigorosoM', 'D2', VigorosoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'VigorosoL', 'D2', VigorosoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'SociableM', 'D2', SociableM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'SociableL', 'D2', SociableL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ParlanchinM', 'D3', ParlanchinM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ParlanchinL', 'D3', ParlanchinL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ControladoM', 'D3', ControladoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ControladoL', 'D3', ControladoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ConvencionalM', 'D3', ConvencionalM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ConvencionalL', 'D3', ConvencionalL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DecisivoM', 'D3', DecisivoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DecisivoL', 'D3', DecisivoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'CohibidoM', 'D4', CohibidoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'CohibidoL', 'D4', CohibidoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'ExactoM', 'D4', ExactoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'ExactoL', 'D4', ExactoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'FrancoM', 'D4', FrancoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'FrancoL', 'D4', FrancoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'BuenCompañeroM', 'D4', BuenCompañeroM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'BuenCompañeroL', 'D4', BuenCompañeroL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DiplomaticoM', 'D5', DiplomaticoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DiplomaticoL', 'D5', DiplomaticoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'AudazM', 'D5', AudazM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'AudazL', 'D5', AudazL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'RefinadoM', 'D5', RefinadoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'RefinadoL', 'D5', RefinadoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'SatisfechoM', 'D5', SatisfechoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'SatisfechoL', 'D5', SatisfechoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'InquietoM', 'D6', InquietoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'InquietoL', 'D6', InquietoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'PopularM', 'D6', PopularM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'PopularL', 'D6', PopularL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'BuenVecinoM', 'D6', BuenVecinoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'BuenVecinoL', 'D6', BuenVecinoL FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorM) SELECT 'DevotoM', 'D6', DevotoM FROM Inserted
	INSERT INTO #PersonalCleaver(Concepto, Grupo, ValorL) SELECT 'DevotoL', 'D6', DevotoL FROM Inserted

-- Valida que no tenga en una sección mas de un concepto de la columna izquierda y derecha
	SELECT @GrupoM = NULL, @GrupoL = NULL
	SELECT @GrupoM = Grupo FROM #PersonalCleaver WHERE ISNULL(ValorM,0) = 1 GROUP BY Grupo HAVING Count(Grupo) > 1
	SELECT @GrupoL = Grupo FROM #PersonalCleaver WHERE ISNULL(ValorL,0) = 1 GROUP BY Grupo HAVING Count(Grupo) > 1

	IF @GrupoM is not null
		BEGIN
			SELECT @Clave = SUBSTRING(@GrupoM, 1, 1), @Seccion = SUBSTRING(@GrupoM, 2, 2)
			SELECT @Mensaje = 'Existe mas de una valor en la columna de la izquierda del grupo ' + @Clave + ' Sección ' + @Seccion
			RAISERROR(@Mensaje, 16, 1)
			RETURN
		END
	ELSE
	IF @GrupoL is not null
		BEGIN
			SELECT @Clave = SUBSTRING(@GrupoL, 1, 1), @Seccion = SUBSTRING(@GrupoL, 2, 2)
			SELECT @Mensaje = 'Existe mas de una valor en la columna de la derecha del grupo ' + @Clave + ' Sección ' + @Seccion
			RAISERROR(@Mensaje, 16, 1)
			RETURN
		END
	ELSE
	BEGIN
-- Valida que tenga en una sección por lo menos un valor de la izquierda y derecha
		SELECT @GrupoM = Grupo FROM #PersonalCleaver WHERE ValorM = 0 GROUP BY Grupo HAVING Count(Grupo) >= 4
		SELECT @GrupoL = Grupo FROM #PersonalCleaver WHERE ValorL = 0 GROUP BY Grupo HAVING Count(Grupo) >= 4

		IF @GrupoM is not null
			BEGIN
				SELECT @Clave = SUBSTRING(@GrupoM, 1, 1), @Seccion = SUBSTRING(@GrupoM, 2, 2)
				SELECT @Mensaje = 'No se seleccionó el campo de la izquierda para el Grupo ' + @Clave + ' Sección ' + @Seccion
				RAISERROR(@Mensaje, 16, 1)
				RETURN
			END
		ELSE
		IF @GrupoL is not null
			BEGIN
				SELECT @Clave = SUBSTRING(@GrupoL, 1, 1), @Seccion = SUBSTRING(@GrupoL, 2, 2)
				SELECT @Mensaje = 'No se seleccionó el campo de la derecha para el Grupo ' + @Clave + ' Sección ' + @Seccion
				RAISERROR(@Mensaje, 16, 1)
				RETURN
			END
		ELSE
		BEGIN
			SELECT @Concepto = NULL
			SELECT @Concepto = SUBSTRING(c1.Concepto, 1, Len(c1.Concepto)-1), @GrupoL = c1.Grupo
			  FROM #PersonalCleaver c1, #PersonalCleaver c2
			 WHERE c1.ValorM = 1 and c2.ValorL = 1 
			   AND SUBSTRING(c1.Concepto, 1, Len(c1.Concepto)-1) = SUBSTRING(c2.Concepto, 1, Len(c2.Concepto)-1) 
		
			IF @Concepto is not null
				BEGIN
					SELECT @Clave = SUBSTRING(@GrupoL, 1, 1), @Seccion = SUBSTRING(@GrupoL, 2, 2)
					SELECT @Mensaje = 'No debe de seleccionar ambos campos del Punto ' + RTRIM(@Concepto) + ', Grupo ' + @Clave + ' Sección' + @Seccion
					RAISERROR(@Mensaje, 16, 1)
					RETURN
				END
		END

	END

RETURN
END
GO

/**************** spCompetenciaFormato ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompetenciaFormato') and type = 'P') drop procedure dbo.spCompetenciaFormato
GO
CREATE PROCEDURE spCompetenciaFormato
			@Personal	char(10),
			@Evalua		char(10),
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
/*
	DELETE CompetenciaFormatoCalificacion
	 WHERE Personal = @Personal AND EvaluaPersonal = @Evalua AND Fecha = @Fecha AND Punto NOT IN (SELECT Punto FROM CompetenciaFormato)

	IF Exists(SELECT * FROM Personal WHERE Personal = @Evalua)
	INSERT INTO CompetenciaFormatoCalificacion (Personal, EvaluaPersonal, Fecha, Punto)
		SELECT @Personal, @Evalua, @Fecha, Punto
		  FROM CompetenciaFormato
		 WHERE Punto NOT IN (SELECT Punto FROM CompetenciaFormatoCalificacion WHERE Personal = @Personal AND EvaluaPersonal = @Evalua AND Fecha = @Fecha)
		 */
  RETURN
END
GO

/**************** spCompetenciaFormatoCalificacionEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCompetenciaFormatoCalificacionEliminar') and type = 'P') drop procedure dbo.spCompetenciaFormatoCalificacionEliminar
GO             
CREATE PROCEDURE spCompetenciaFormatoCalificacionEliminar
			@Personal	char(10),
			@Evalua		char(10),
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
/*
  DELETE CompetenciaFormatoCalificacion
   WHERE Personal = @Personal AND EvaluaPersonal = @Evalua AND Fecha = @Fecha*/
  RETURN
END
GO

-- spVerCompetenciaFormatoCalificacion '001', '1/1/2006', '12/31/2006'
/**************** spVerCompetenciaFormatoCalificacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCompetenciaFormatoCalificacion') and type = 'P') drop procedure dbo.spVerCompetenciaFormatoCalificacion
GO
CREATE PROCEDURE spVerCompetenciaFormatoCalificacion
			@Personal	char(10),
			@FechaD		datetime,
			@FechaA		datetime
--//WITH ENCRYPTION
AS
BEGIN
/*
	DECLARE
		@Puesto		char(50),
		@Auto		int,
		@Externo	int,
		@Grupo		int

	SELECT @Auto = COUNT(DISTINCT Personal) 
	  FROM CompetenciaFormatoCalificacion 
	 WHERE Personal = @Personal AND Personal = EvaluaPersonal AND Fecha BETWEEN @FechaD AND @FechaA

	SELECT @Externo = COUNT(DISTINCT EvaluaPersonal) 
	  FROM CompetenciaFormatoCalificacion 
	 WHERE Personal = @Personal AND Personal <> EvaluaPersonal AND Fecha BETWEEN @FechaD AND @FechaA

	SELECT @Grupo = COUNT(DISTINCT EvaluaPersonal) 
	  FROM CompetenciaFormatoCalificacion 
	 WHERE Personal <> @Personal /*AND Personal <> EvaluaPersonal */AND Fecha BETWEEN @FechaD AND @FechaA

-- select @auto, @externo, @grupo

	SELECT @Puesto = Puesto FROM Personal WHERE Personal = @Personal

-- Autoevaluación
	SELECT 'Orden' = 1, 'Tipo' = 'AutoEvaluación', f.Clave, c.Competencia, f.Nivel, 'Calificacion' = SUM(p.Calificacion*(f.Peso/100))/@Auto
	  FROM CompetenciaFormatoCalificacion p, CompetenciaFormato f, Competencia c, PuestoCompetencia t
	 WHERE p.Punto = f.Punto
	   AND f.Clave = c.Clave
	   AND c.Clave = t.Clave AND f.Nivel = t.Nivel
	   AND p.Personal = @Personal
	   AND p.Personal = p.EvaluaPersonal
	   AND p.Fecha BETWEEN @FechaD AND @FechaA
	 GROUP BY f.Clave, c.Competencia, f.Nivel
	UNION
	SELECT 'Orden' = 2, 'Tipo' = 'Externo', f.Clave, c.Competencia, f.Nivel, 'Calificacion' = SUM(p.Calificacion*(f.Peso/100))/@Externo
	  FROM CompetenciaFormatoCalificacion p, CompetenciaFormato f, Competencia c, PuestoCompetencia t
	 WHERE p.Punto = f.Punto
	   AND f.Clave = c.Clave
	   AND c.Clave = t.Clave AND f.Nivel = t.Nivel
	   AND p.Personal = @Personal
	   AND p.Personal <> p.EvaluaPersonal
	   AND p.Fecha BETWEEN @FechaD AND @FechaA
	 GROUP BY f.Clave, c.Competencia, f.Nivel
	UNION
	SELECT 'Orden' = 3, 'Tipo' = 'Grupo', f.Clave, c.Competencia, f.Nivel, 'Calificacion' = SUM(p.Calificacion*(f.Peso/100))/@Grupo
	  FROM CompetenciaFormatoCalificacion p, CompetenciaFormato f, Competencia c, PuestoCompetencia t
	 WHERE p.Punto = f.Punto
	   AND f.Clave = c.Clave
	   AND c.Clave = t.Clave AND f.Nivel = t.Nivel
	   AND p.Personal <> @Personal
--	   AND Personal <> EvaluaPersonal 
	   AND p.Fecha BETWEEN @FechaD AND @FechaA
	 GROUP BY f.Clave, c.Competencia, f.Nivel
	UNION
	SELECT 'Orden' = 4, 'Tipo' = 'Puesto ' + p.Puesto, p.Clave, c.Competencia, 'Nivel' = ISNULL(p.Nivel,''), p.Grado
	  FROM PuestoCompetencia p, Competencia c
	 WHERE p.Clave = c.Clave 
	   AND p.Puesto = @Puesto
	ORDER BY Orden, f.Clave, f.Nivel
*/
RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.CompetenciaCalificacion') and type = 'V') drop view dbo.CompetenciaCalificacion
GO
/*CREATE VIEW dbo.CompetenciaCalificacion
AS
SELECT	Personal,
	EvaluaPersonal,
	Fecha,
       'Calificacion' = SUM(ec.Calificacion*(ef.Peso/100)),
       'Estatus' = (CASE (SELECT COUNT(*) FROM CompetenciaFormatoCalificacion e WHERE e.Personal=ec.Personal AND e.EvaluaPersonal=ec.EvaluaPersonal AND e.Fecha = ec.Fecha AND Calificacion IS NULL) WHEN 0 THEN "CONCLUIDO" ELSE "BORRADOR" END)
  FROM CompetenciaFormato ef, CompetenciaFormatoCalificacion ec 
 WHERE ef.Punto = ec.Punto 
 GROUP BY ec.Personal, ec.EvaluaPersonal, ec.Fecha*/
GO

