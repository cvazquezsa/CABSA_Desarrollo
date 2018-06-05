EXEC spDROP_TABLE 'FormaTitulo', 2881
EXEC spDROP_TABLE 'FormaTipo', 2881
EXEC spDROP_TABLE 'IntelisisCGI', 2899
EXEC spDROP_TABLE 'FormaValor', 3100
EXEC spDROP_TABLE 'FormaVisible', 3100
EXEC spDROP_TABLE 'FormaCampo', 3100
EXEC spDROP_TABLE 'FormaCampoFijo', 3100
EXEC spDROP_TABLE 'FormaCampoAyudaLista', 3100
EXEC spDROP_TABLE 'FormaGrupo', 3100
EXEC spDROP_TABLE 'Forma', 3100
EXEC spDROP_TABLE 'FormaD', 3100
EXEC spDROP_TABLE 'FormaC', 3100
GO

-- drop table FormaExtraValor
/****** FormaExtraValor ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraValor') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraValor', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraValor') and type = 'U') 
  CREATE TABLE dbo.FormaExtraValor (
	FormaTipo	varchar(20)	NOT NULL,	
	Aplica		varchar(50)	NOT NULL,
	AplicaClave	varchar(50)	NOT NULL,
	Campo		varchar(50)	NOT NULL,

	Valor		varchar(255)	NULL,
	Tiempo		datetime	NULL,

	Eliminado	bit		NULL	DEFAULT 0,

	CONSTRAINT priFormaExtraValor PRIMARY KEY CLUSTERED (AplicaClave, FormaTipo, Campo, Aplica)
  )
GO
EXEC spADD_INDEX 'FormaExtraValor', 'FormaTipo', 'FormaTipo, Campo'
GO

EXEC spFK2 'FormaExtraValor','FormaTipo','Campo','FormaExtraCampo','FormaTipo','Campo'
EXEC spFK 'FormaExtraValor','FormaTipo','FormaTipo','FormaTipo'
GO

-- spFormaExtraCampo 'FormaFicha', 59
-- update FormaExtraCampo set ayudaexpresion = null

-- drop table FormaExtraVisible
/****** FormaExtraVisible ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraVisible') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraVisible', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraVisible') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FormaExtraVisible (
	FormaTipo	varchar(20)	NOT NULL,
	ID		int		NOT NULL	IDENTITY(1,1),

	Aplica		varchar(50)	NULL,		-- Prospecto, Cliente, Proveedor, Personal, Agente, Articulo, Espacio, Almacen

	Modulo		varchar(5)	NULL,
	Movimiento	varchar(20)	NULL,
	Categoria	varchar(50)	NULL,
	Grupo		varchar(50)	NULL,
	Familia		varchar(50)	NULL,
	Departamento	varchar(50)	NULL,
	Puesto		varchar(50)	NULL,
	SIC		varchar(10)	NULL,
	Uso		varchar(50)	NULL,
	TipoInmueble	varchar(50)	NULL,

	CONSTRAINT priFormaExtraVisible PRIMARY KEY CLUSTERED (FormaTipo, ID)
  )
  EXEC spSincroSemilla 'FormaExtraVisible'
END
GO
EXEC spADD_INDEX 'FormaExtraVisible', 'Cta', 'Aplica, Categoria, Grupo, Familia, Departamento, Puesto, SIC'
GO

EXEC spALTER_TABLE 'FormaExtraVisible', 'Uso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'FormaExtraVisible', 'TipoInmueble', 'varchar(50) NULL'
GO

EXEC spFK 'FormaExtraVisible','SIC','SIC','SIC'
GO

-- drop table FormaExtraCampo
/****** FormaExtraCampo ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraCampo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraCampo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraCampo') and type = 'U') 
  CREATE TABLE dbo.FormaExtraCampo (
	FormaTipo		varchar(20)	NOT NULL,
	Campo			varchar(50)	NOT NULL,

	Etiqueta		varchar(100)	NULL,
	Grupo			varchar(50)	NULL,
	TipoDato		varchar(20)	NULL,	-- Texto, Numerico, Flotante, Monetario, Logico, Fecha, Fecha/Hora, Hora
        EsContrasena    	bit		NULL	DEFAULT 0,
        EsMayusculas    	bit		NULL	DEFAULT 0,
        LongitudMaxima  	int             NULL,
	Orden			int		NULL,

	AyudaTipo		varchar(50)	NULL,	-- Ninguna, Calendario, Calculadora, Lista, Lista Opcional, Forma, Expresion, Expresion Opcional
	AyudaReferencia		varchar(50)	NULL,
	AyudaExpresion		text		NULL,
	AyudaRefrescar		bit		NULL	DEFAULT 0,
	AyudaComentario		varchar(255)	NULL,
	ValidacionTipo		varchar(50)	NULL,
	ValidacionTabla		varchar(50)	NULL,
	ValidacionCampo		varchar(50)	NULL,
	ValidacionReferencia	varchar(50)	NULL,
	ValidacionExpresion	text		NULL,
	DespliegueTipo		varchar(20)	NULL,	-- Valor, Expresion
	DespliegueReferencia	varchar(50)	NULL,
	DespliegueExpresion	text		NULL,
	Mascara			varchar(50)	NULL,

	FondoColor		int		NULL,

	PosX			int		NULL,
	PosY			int		NULL,
	Ancho			int		NULL,

	FuenteEspecial		bit		NULL	DEFAULT 0,
	FuenteNombre		varchar(50)	NULL,
	FuenteEstilo		varchar(50)	NULL,
	FuenteTamano		int		NULL,
	FuenteColor		int		NULL,
	FuenteSubrayado		bit		NULL	DEFAULT 0,

	OpcionTipo			varchar(20)	NULL,	-- Lista, Renglon, Columna, Calendario
	CalendarioVista			varchar(20)	NULL,	-- Mes, Semana, Dia, Hora
	CalendarioVistaSemana		varchar(20)	NULL,	-- Vertical, Horizontal
	CalendarioVistaMinutos		int		NULL,
	CalendarioPeriodosVisibles	int		NULL	DEFAULT 3,	-- 1..5
	CalendarioBloquearAnteriores	bit		NULL	DEFAULT 0,
	CalendarioRangoHoras		varchar(20)	NULL,	-- 09:00 - 18:00

	CONSTRAINT priFormaExtraCampo PRIMARY KEY CLUSTERED (FormaTipo, Campo)
  )
GO
EXEC spALTER_TABLE 'FormaExtraCampo', 'OpcionTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioVista', 'varchar(20) NULL'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioVistaSemana', 'varchar(20) NULL'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioVistaMinutos', 'int NULL'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioPeriodosVisibles', 'int NULL DEFAULT 3 WITH VALUES'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioBloquearAnteriores', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaExtraCampo', 'CalendarioRangoHoras', 'varchar(20) NULL'
GO

EXEC spFK2 'FormaExtraCampo','FormaTipo','Grupo','FormaExtraGrupo','FormaTipo','Grupo'
EXEC spFK 'FormaExtraCampo','FormaTipo','FormaTipo','FormaTipo'
GO

/****** FormaExtraCampoFijo ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraCampoFijo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraCampoFijo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraCampoFijo') and type = 'U') 
  CREATE TABLE dbo.FormaExtraCampoFijo (
	Campo			varchar(50)	NOT NULL,
	Etiqueta		varchar(100)	NULL,

	CONSTRAINT priFormaExtraCampoFijo PRIMARY KEY CLUSTERED (Campo)
  )
GO

/****** FormaExtraCampoAyudaLista ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraCampoAyudaLista') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraCampoAyudaLista', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraCampoAyudaLista') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FormaExtraCampoAyudaLista (
	FormaTipo	varchar(20)	NOT NULL,
	Campo		varchar(50)	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Orden		int		NULL,
	Opcion		varchar(255)	NULL,

	CONSTRAINT priFormaExtraCampoAyudaLista PRIMARY KEY CLUSTERED (FormaTipo, Campo, ID)
  )
  EXEC spSincroSemilla 'FormaExtraCampoAyudaLista'
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaExtraCampoB') and sysstat & 0xf = 8) drop trigger dbo.tgFormaExtraCampoB
GO
-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgFormaExtraCampoB ON FormaExtraCampo
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @FormaTipoA		varchar(20),
    @CampoA		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FormaTipoA = FormaTipo, @CampoA = Campo FROM Deleted

  UPDATE FormaExtraValor SET Eliminado = 1 WHERE FormaTipo = @FormaTipoA AND Campo = @CampoA AND Eliminado = 0
END
GO

/* tempFormaCaptura */
if exists (select * from sysobjects where id = object_id('dbo.tempFormaCaptura') and sysstat & 0xf = 3) drop table dbo.tempFormaCaptura
go
CREATE TABLE dbo.tempFormaCaptura (
	Estacion		int		NOT NULL,
	FormaTipo		varchar(20)	NOT NULL,
	Campo			varchar(50)	NOT NULL,

	ValorTexto		varchar(255)	NULL,
	ValorNumerico		int		NULL,
	ValorFlotante		float		NULL,
	ValorMonetario		money		NULL,
	ValorLogico		bit		NULL,
	ValorFechaHora		datetime	NULL,
	Tiempo			datetime	NULL,

	CONSTRAINT pritempFormaCaptura PRIMARY KEY CLUSTERED (Estacion, FormaTipo, Campo)
)
go

-- drop table IntelisisCGI
/* IntelisisCGI */
if not exists (select * from SysTabla where SysTabla = 'IntelisisCGI') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IntelisisCGI', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisCGI') and type = 'U') 
  CREATE TABLE dbo.IntelisisCGI (
	GUID			uniqueidentifier	NOT NULL,
	Campo			varchar(50)		NOT NULL,
	Valor			text			NULL,

	CONSTRAINT priIntelisisCGI PRIMARY KEY CLUSTERED (GUID, Campo)
  )
go

/****** FormaExtraGrupo ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraGrupo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraGrupo', 'Maestro')
-- drop table FormaExtraGrupo
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraGrupo') and type = 'U') 
  CREATE TABLE dbo.FormaExtraGrupo (
	FormaTipo	varchar(20)	NOT NULL,
	Grupo		varchar(50)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priFormaExtraGrupo PRIMARY KEY CLUSTERED (FormaTipo, Grupo)
  )
GO

EXEC spFK 'FormaExtraGrupo','FormaTipo','FormaTipo','FormaTipo'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaExtraGrupoC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaExtraGrupoC
GO
-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgFormaExtraGrupoC ON FormaExtraGrupo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @FormaTipoA	varchar(20),
    @FormaTipoN	varchar(20),
    @GrupoA	varchar(50),
    @GrupoN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FormaTipoN = FormaTipo, @GrupoN = Grupo FROM Inserted
  SELECT @FormaTipoA = FormaTipo, @GrupoA = Grupo FROM Deleted

  IF @FormaTipoN = @FormaTipoA AND @GrupoN = @GrupoA RETURN

  UPDATE FormaExtraCampo SET FormaTipo = @FormaTipoN, Grupo = @GrupoN WHERE FormaTipo = @FormaTipoA AND Grupo = @GrupoA
END
GO

/****** Categorias de FormaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'FormaTipoCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaTipoCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaTipoCat') and type = 'U') 
CREATE TABLE dbo.FormaTipoCat (
	Categoria 		varchar(50) 	NOT NULL ,

	CONSTRAINT priFormaTipoCat PRIMARY KEY CLUSTERED (Categoria)
)
GO

-- drop table FormaTipo
/****** FormaTipo ******/
if not exists (select * from SysTabla where SysTabla = 'FormaTipo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaTipo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaTipo') and type = 'U') 
  CREATE TABLE dbo.FormaTipo (
	FormaTipo		varchar(20)	NOT NULL,

	NombreCorto		varchar(50)	NULL,
	Titulo			varchar(100)	NULL,
	Encabezado		varchar(255)	NULL,		-- Mostrar en un panel Especial (Top), sobre todo se usa en Wizards
	Icono			int		NULL,
	Tipo			varchar(20)	NULL,		-- Ficha, Wizard, Formulario
	Uso			varchar(20)	NULL,		-- Caracteristicas, Movimientos
	PuedeRetroceder		bit		NULL	DEFAULT 1,
	PuedeCancelar		bit		NULL	DEFAULT 1,
	OrdenEspecial		bit		NULL	DEFAULT 0,
	VerGrupoEnResumen	bit		NULL	DEFAULT 0,
	VerNombreCortoEnResumen	bit		NULL	DEFAULT 0,
	Estatus			varchar(15)	NULL,
	TieneMovimientos	bit		NULL,

	FondoImagen		varchar(255)	NULL,
	FondoColor		int		NULL,

	FuenteEspecial		bit		NULL	DEFAULT 0,
	FuenteNombre		varchar(50)	NULL,
	FuenteEstilo		varchar(50)	NULL,
	FuenteTamano		int		NULL,
	FuenteColor		int		NULL,
	FuenteSubrayado		bit		NULL	DEFAULT 0,

	Categoria		varchar(50)	NULL,

	Asunto			varchar(255)	NULL,
	ArchivoAdjunto		varchar(100)	NULL,
	MensajeHTML		text		NULL,
	CapturaHTML		text		NULL,
	InfoHTML		text		NULL,

	CONSTRAINT priFormaTipo PRIMARY KEY CLUSTERED (FormaTipo)
  )
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFormaTipoBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaTipoBC
GO
EXEC spALTER_TABLE 'FormaTipo', 'NombreCorto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'FormaTipo', 'VerNombreCortoEnResumen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaTipo', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'FormaTipo', 'CapturaHTML', 'text NULL'
EXEC spALTER_TABLE 'FormaTipo', 'InfoHTML', 'text NULL'
EXEC spALTER_TABLE 'FormaTipo', 'Asunto', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'FormaTipo', 'ArchivoAdjunto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'FormaTipo', 'MensajeHTML', 'text NULL'
GO

-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgFormaTipoBC ON FormaTipo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @FormaTipoA	varchar(20),
    @FormaTipoN	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FormaTipoN = FormaTipo FROM Inserted
  SELECT @FormaTipoA = FormaTipo FROM Deleted

  IF @FormaTipoN =  @FormaTipoA RETURN
  IF @FormaTipoN IS NULL
  BEGIN
    DELETE FormaExtraCampo WHERE FormaTipo = @FormaTipoA
    DELETE FormaExtraGrupo WHERE FormaTipo = @FormaTipoA
  END ELSE
  BEGIN
    UPDATE FormaExtraCampo SET FormaTipo = @FormaTipoN WHERE FormaTipo = @FormaTipoA
    UPDATE FormaExtraGrupo SET FormaTipo = @FormaTipoN WHERE FormaTipo = @FormaTipoA
  END
END
GO


if exists (select * from sysobjects where id = object_id('dbo.FormaTipoFormas') and sysstat & 0xf = 2) drop view dbo.FormaTipoFormas
GO
CREATE VIEW FormaTipoFormas
--//WITH ENCRYPTION
AS
SELECT
  *

FROM
  FormaTipo
WHERE 
  Uso = 'Formas'
GO



-- spFormaExtraCampo 'FormaFicha', 59
-- update FormaExtraCampo set ayudaexpresion = null
/**************** spFormaExtraCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCampo') and type = 'P') drop procedure dbo.spFormaExtraCampo
GO
CREATE PROCEDURE spFormaExtraCampo
		    @FormaTipo		varchar(20),
                    @Estacion		int
--//WITH ENCRYPTION
AS BEGIN
  SELECT @FormaTipo = NULLIF(NULLIF(RTRIM(@FormaTipo), ''), '0') 
  SELECT fc.Campo,
         fc.Etiqueta,
         fc.Grupo,
         fc.TipoDato,
         fc.EsContrasena,
         fc.EsMayusculas,
         fc.LongitudMaxima,
         fc.AyudaTipo,
         fc.AyudaReferencia,
         fc.AyudaExpresion,
         fc.AyudaRefrescar,
         fc.AyudaComentario,
         fc.DespliegueTipo,
         fc.DespliegueReferencia,
         fc.DespliegueExpresion,
         fc.ValidacionTipo,
         fc.ValidacionTabla,
         fc.ValidacionCampo,
         fc.ValidacionReferencia,
         fc.ValidacionExpresion,
         fc.Mascara,
         fc.FondoColor,
         fc.PosX,
         fc.PosY,
         fc.FuenteEspecial,
         fc.FuenteNombre,
         fc.FuenteEstilo,
         fc.FuenteTamano,
         fc.FuenteColor,
         fc.FuenteSubrayado,
         t.ValorTexto,
	 t.ValorNumerico,
	 t.ValorFlotante,
	 t.ValorMonetario,
         t.ValorLogico,
	 t.ValorFechaHora
    FROM FormaExtraCampo fc
    JOIN FormaExtraGrupo fg ON fg.FormaTipo = fc.FormaTipo and fg.Grupo = fc.Grupo
    LEFT OUTER JOIN tempFormaCaptura t ON t.FormaTipo = fc.FormaTipo AND t.Campo = fc.Campo AND t.Estacion = @Estacion
   WHERE fc.FormaTipo = @FormaTipo
   ORDER BY fg.Orden, fc.Orden
END
GO

-- spFormaTipoHTML 'DEMO', 'F7'
/**************** spFormaTipoHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaTipoHTML') and type = 'P') drop procedure dbo.spFormaTipoHTML
GO
CREATE PROCEDURE spFormaTipoHTML
  	 	    @Empresa		varchar(5),
		    @FormaTipo		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @URL_RecibirForma	varchar(255),
    @URL_Logo		varchar(255)

  SELECT @URL_RecibirForma = URL_RecibirForma, @URL_Logo = URL_Logo FROM EmpresaGral WHERE Empresa = @Empresa
  SELECT 'URL_RecibirForma' = @URL_RecibirForma, 'URL_Logo' = @URL_Logo, 'Nombre' = ISNULL(ISNULL(NULLIF(RTRIM(Encabezado), ''), NULLIF(RTRIM(Titulo), '')), NombreCorto)
    FROM FormaTipo
   WHERE FormaTipo = @FormaTipo
END
GO

-- spFormaExtraCampoHTML 'F7'
-- spFormaExtraCampoAyudaLista 'F7', 'Campo 1'
/**************** spFormaExtraCampoHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCampoHTML') and type = 'P') drop procedure dbo.spFormaExtraCampoHTML
GO
CREATE PROCEDURE spFormaExtraCampoHTML
		    @FormaTipo		varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT fc.Campo,
         fc.Etiqueta,
         fc.Grupo,
         fc.TipoDato,
         fc.EsContrasena,
         fc.EsMayusculas,
         fc.LongitudMaxima,
         fc.AyudaTipo
    FROM FormaExtraCampo fc
    JOIN FormaExtraGrupo fg ON fg.FormaTipo = fc.FormaTipo and fg.Grupo = fc.Grupo
   WHERE fc.FormaTipo = @FormaTipo
   ORDER BY fg.Orden, fc.Orden
END
GO

/**************** spFormaExtraCampoAyudaLista ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCampoAyudaLista') and type = 'P') drop procedure dbo.spFormaExtraCampoAyudaLista
GO
CREATE PROCEDURE spFormaExtraCampoAyudaLista
		    @FormaTipo		varchar(20),
		    @Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  SELECT Opcion 
   FROM FormaExtraCampoAyudaLista
  WHERE FormaTipo = @FormaTipo AND Campo = @Campo
  ORDER BY Orden
END
GO

--EXEC spFormaExtraCaptura 'Iniciar', 'DEMO', 0, 'DONGAY', 105, 'F1', 'Movimiento', 'VTAS2', '', '', -1, -1, -1, 0, NULL, NULL
--EXEC spFormaExtraCaptura 'Iniciar', 'DEMO', 0, 'DEMO', 101, 'F1', 'Movimiento', 'COMS6', '', '', -1, -1, -1, 0, NULL, NULL
/**************** spFormaExtraCaptura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCaptura') and type = 'P') drop procedure dbo.spFormaExtraCaptura
GO
CREATE PROCEDURE spFormaExtraCaptura
		    @Accion		varchar(20),	-- Iniciar, Enter, Siguiente, Anterior, Finalizar,
		    @Empresa		char(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Estacion		int,
		    @FormaTipo		varchar(20),
		    @Aplica		varchar(50),
		    @AplicaClave	varchar(50),
		    @Campo		varchar(50),
		    @ValorTexto		varchar(255)	= NULL,
		    @ValorNumerico	int		= NULL,
		    @ValorFlotante	float		= NULL,
		    @ValorMonetario	money		= NULL,
                    @ValorLogico	bit		= NULL,
		    @ValorFechaHora	datetime	= NULL,
		    @Tiempo		datetime	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Grupo		varchar(50),
    @Orden		int,
    @CampoSiguiente	varchar(50),
    @OrdenEspecial	bit,
    @TipoDato		varchar(20),
    @Valor		varchar(255),
    @AplicaID		int

  SELECT @Ok = NULL, @OkRef = NULL, @Accion = UPPER(@Accion), @CampoSiguiente = NULL
  --IF UPPER(@Aplica) = 'MOVIMIENTO' SELECT @AplicaID = CONVERT(int, @AplicaClave)

  IF @Accion = 'INICIAR'
  BEGIN
    DELETE tempFormaCaptura WHERE Estacion = @Estacion AND FormaTipo = @FormaTipo
    /*IF UPPER(@Aplica) = 'MOVIMIENTO'
      INSERT tempFormaCaptura (
             Estacion,  FormaTipo,    Campo,    
             ValorTexto,
             ValorNumerico,
             ValorFlotante, 
             ValorMonetario, 
             ValorLogico,
             ValorFechaHora)
      SELECT @Estacion, fc.FormaTipo, fc.Campo, 
             CASE WHEN fc.TipoDato = 'Texto'     THEN fv.Valor                 END, 
             CASE WHEN fc.TipoDato = 'Numerico'  THEN CONVERT(int, fv.Valor)   END,
             CASE WHEN fc.TipoDato = 'Flotante'  THEN CONVERT(float, fv.Valor) END,
             CASE WHEN fc.TipoDato = 'Monetario' THEN CONVERT(money, fv.Valor) END,
             CASE WHEN fc.TipoDato = 'Logico'    THEN CONVERT(bit, fv.Valor)   END,
             CASE WHEN fc.TipoDato IN ('Fecha', 'Hora', 'Fecha/Hora') THEN CONVERT(datetime, fv.Valor, 126) END
        FROM FormaExtraCampo fc
        LEFT OUTER JOIN FormaExtraD fv ON fv.FormaTipo = @FormaTipo AND fv.ID = @AplicaID AND fv.Campo = fc.Campo
       WHERE fc.FormaTipo = @FormaTipo
    ELSE*/
      INSERT tempFormaCaptura (
             Estacion,  FormaTipo,    Campo,    
             ValorTexto,
             ValorNumerico,
             ValorFlotante, 
             ValorMonetario, 
             ValorLogico,
             ValorFechaHora)
      SELECT @Estacion, fc.FormaTipo, fc.Campo, 
             CASE WHEN fc.TipoDato = 'Texto'     THEN fv.Valor                 END, 
             CASE WHEN fc.TipoDato = 'Numerico'  THEN CONVERT(int, fv.Valor)   END,
             CASE WHEN fc.TipoDato = 'Flotante'  THEN CONVERT(float, fv.Valor) END,
             CASE WHEN fc.TipoDato = 'Monetario' THEN CONVERT(money, fv.Valor) END,
             CASE WHEN fc.TipoDato = 'Logico'    THEN CONVERT(bit, fv.Valor)   END,
             CASE WHEN fc.TipoDato IN ('Fecha', 'Hora', 'Fecha/Hora') THEN CONVERT(datetime, fv.Valor, 126) END
        FROM FormaExtraCampo fc
        LEFT OUTER JOIN FormaExtraValor fv ON fv.FormaTipo = @FormaTipo AND fv.Aplica = @Aplica AND fv.AplicaClave = @AplicaClave AND fv.Campo = fc.Campo
       WHERE fc.FormaTipo = @FormaTipo
  END ELSE
  BEGIN
    IF @Campo IS NOT NULL
      UPDATE tempFormaCaptura 
         SET ValorTexto = @ValorTexto, ValorNumerico = @ValorNumerico, ValorFlotante = @ValorFlotante, ValorMonetario = @ValorMonetario, ValorLogico = @ValorLogico, ValorFechaHora = @ValorFechaHora, Tiempo = @Tiempo 
       WHERE Estacion = @Estacion AND FormaTipo = @FormaTipo AND Campo = @Campo

    IF @Accion = 'FINALIZAR'
    BEGIN
      DECLARE crFormaCaptura CURSOR LOCAL FOR
       SELECT Campo, ValorTexto, ValorNumerico, ValorFlotante, ValorMonetario, ValorLogico, ValorFechaHora, Tiempo
         FROM tempFormaCaptura
        WHERE Estacion = @Estacion AND FormaTipo = @FormaTipo
      OPEN crFormaCaptura
      FETCH NEXT FROM crFormaCaptura INTO @Campo, @ValorTexto, @ValorNumerico, @ValorFlotante, @ValorMonetario, @ValorLogico, @ValorFechaHora, @Tiempo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          SELECT @TipoDato = TipoDato FROM FormaExtraCampo WHERE FormaTipo = @FormaTipo AND Campo = @Campo
          SELECT @Valor = NULL
          IF @TipoDato = 'Texto'     SELECT @Valor = @ValorTexto                       ELSE
          IF @TipoDato = 'Numerico'  SELECT @Valor = CONVERT(varchar, @ValorNumerico)  ELSE
          IF @TipoDato = 'Flotante'  SELECT @Valor = CONVERT(varchar, @ValorFlotante)  ELSE
          IF @TipoDato = 'Monetario' SELECT @Valor = CONVERT(varchar, @ValorMonetario) ELSE
          IF @TipoDato = 'Logico'    SELECT @Valor = CONVERT(varchar, @ValorLogico)    ELSE
          IF @TipoDato IN ('Fecha', 'Hora', 'Fecha/Hora') SELECT @Valor = CONVERT(varchar, @ValorFechaHora, 126) 

          /*IF UPPER(@Aplica) = 'MOVIMIENTO'
          BEGIN
            UPDATE FormaExtraD
               SET Valor = NULLIF(RTRIM(@Valor), ''),
                   Tiempo = NULLIF(@Tiempo, 0)
             WHERE FormaTipo = @FormaTipo AND ID = @AplicaID AND Campo = @Campo
            IF @@ROWCOUNT = 0
              INSERT FormaExtraD (FormaTipo, ID, Campo, Valor, Tiempo) VALUES (@FormaTipo, @AplicaID, @Campo, @Valor, @Tiempo) 
          END ELSE
          BEGIN*/
            UPDATE FormaExtraValor
               SET Valor = NULLIF(RTRIM(@Valor), ''),
                   Tiempo = NULLIF(@Tiempo, 0),
                   Eliminado = 0
             WHERE FormaTipo = @FormaTipo AND Aplica = @Aplica AND AplicaClave = @AplicaClave AND Campo = @Campo
            IF @@ROWCOUNT = 0
              INSERT FormaExtraValor (FormaTipo, Aplica, AplicaClave, Campo, Valor, Tiempo) VALUES (@FormaTipo, @Aplica, @AplicaClave, @Campo, @Valor, @Tiempo) 
          --END
        END
        FETCH NEXT FROM crFormaCaptura INTO @Campo, @ValorTexto, @ValorNumerico, @ValorFlotante, @ValorMonetario, @ValorLogico, @ValorFechaHora, @Tiempo
      END
      CLOSE crFormaCaptura
      DEALLOCATE crFormaCaptura
    END ELSE
    BEGIN
      SELECT @OrdenEspecial = OrdenEspecial FROM FormaTipo WHERE FormaTipo = @FormaTipo
      IF @OrdenEspecial = 1
      BEGIN
        SELECT @Grupo = Grupo, @Orden = Orden FROM FormaExtraCampo WHERE FormaTipo = @FormaTipo AND Campo = @Campo
        IF @Accion = 'SIGUIENTE' SELECT @CampoSiguiente = MIN(Campo) FROM FormaExtraCampo WHERE FormaTipo = @FormaTipo AND Campo <> @Campo AND Orden >= @Orden
        IF @Accion = 'ANTERIOR'  SELECT @CampoSiguiente = MAX(Campo) FROM FormaExtraCampo WHERE FormaTipo = @FormaTipo AND Campo <> @Campo AND Orden <= @Orden
      END
    END
  END

  SELECT 'Ok' = @Ok, 'OkRef' = @OkRef, 'Campo' = @CampoSiguiente
  RETURN
END
GO

/**************** spFormaExtraCampoAyuda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCampoAyuda') and type = 'P') drop procedure dbo.spFormaExtraCampoAyuda
GO
CREATE PROCEDURE spFormaExtraCampoAyuda
		    @Empresa		varchar(5),
		    @Sucursal		int,
		    @Usuario		varchar(10),
		    @Estacion		int,
		    @FormaTipo		varchar(20),
		    @Aplica		varchar(50),
		    @AplicaClave	varchar(50),
		    @Campo		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  /*IF @Campo = 'Pais'
    SELECT 'Ayuda' = CONVERT(varchar(255), Pais) FROM Pais
  ELSE 
    SELECT 'Ayuda' = CONVERT(varchar(255), NULL)*/
  RETURN
END
GO
-- select * from FormaExtraVisible
/**************** fnFormaExtraVisible ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisible') DROP FUNCTION fnFormaExtraVisible
GO
CREATE FUNCTION fnFormaExtraVisible (@Aplica	varchar(50), @Modulo varchar(5), @Movimiento varchar(20), @Categoria varchar(50), @Grupo varchar(50), @Familia varchar(50), @Departamento varchar(50), @Puesto varchar(50), @SIC varchar(10))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Aplica       = UPPER(@Aplica), 
         @Modulo       = ISNULL(NULLIF(RTRIM(@Modulo), '0'), ''),
         @Movimiento   = ISNULL(NULLIF(RTRIM(@Movimiento), '0'), ''),
         @Categoria    = ISNULL(NULLIF(RTRIM(@Categoria), '0'), ''),
         @Grupo        = ISNULL(NULLIF(RTRIM(@Grupo), '0'), ''),
         @Familia      = ISNULL(NULLIF(RTRIM(@Familia), '0'), ''),
         @Departamento = ISNULL(NULLIF(RTRIM(@Departamento), '0'), ''),
         @Puesto       = ISNULL(NULLIF(RTRIM(@Departamento), '0'), ''),
         @SIC          = ISNULL(NULLIF(RTRIM(@SIC), '0'), '')

  IF @Aplica = 'MOVIMIENTO' 
    INSERT @Resultado SELECT fv.FormaTipo FROM FormaExtraVisible fv JOIN FormaTipo ft ON ft.FormaTipo = fv.FormaTipo AND ft.Estatus = 'ALTA' AND ft.Uso = 'Caracteristicas' WHERE fv.Aplica = @Aplica AND ISNULL(RTRIM(fv.Modulo), '') IN ('', @Modulo) AND ISNULL(RTRIM(fv.Movimiento), '') IN ('', @Movimiento)
  ELSE IF @Aplica = 'PROSPECTO' 
    INSERT @Resultado SELECT fv.FormaTipo FROM FormaExtraVisible fv JOIN FormaTipo ft ON ft.FormaTipo = fv.FormaTipo AND ft.Estatus = 'ALTA' AND ft.Uso = 'Caracteristicas' WHERE fv.Aplica = @Aplica AND ISNULL(RTRIM(fv.Categoria), '') IN ('', @Categoria) AND ISNULL(RTRIM(fv.Grupo), '') IN ('', @Grupo) AND ISNULL(RTRIM(fv.Familia), '') IN ('', @Familia) AND ISNULL(RTRIM(fv.SIC), '') IN ('', @SIC)
  ELSE IF @Aplica = 'PERSONAL' 
    INSERT @Resultado SELECT fv.FormaTipo FROM FormaExtraVisible fv JOIN FormaTipo ft ON ft.FormaTipo = fv.FormaTipo AND ft.Estatus = 'ALTA' AND ft.Uso = 'Caracteristicas' WHERE fv.Aplica = @Aplica AND ISNULL(RTRIM(fv.Categoria), '') IN ('', @Categoria) AND ISNULL(RTRIM(fv.Grupo), '') IN ('', @Grupo) AND ISNULL(RTRIM(fv.Familia), '') IN ('', @Familia) AND ISNULL(RTRIM(fv.Departamento), '') IN ('', @Departamento) AND ISNULL(RTRIM(fv.Puesto), '') IN ('', @Puesto)
  ELSE
    INSERT @Resultado SELECT fv.FormaTipo FROM FormaExtraVisible fv JOIN FormaTipo ft ON ft.FormaTipo = fv.FormaTipo AND ft.Estatus = 'ALTA' AND ft.Uso = 'Caracteristicas' WHERE fv.Aplica = @Aplica AND ISNULL(RTRIM(fv.Categoria), '') IN ('', @Categoria) AND ISNULL(RTRIM(fv.Grupo), '') IN ('', @Grupo) AND ISNULL(RTRIM(fv.Familia), '') IN ('', @Familia)

  RETURN 
END
GO

-- spFormaExtraVisible 'Prospecto'
/**************** spFormaExtraVisible ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraVisible') and type = 'P') drop procedure dbo.spFormaExtraVisible
GO
CREATE PROCEDURE spFormaExtraVisible
			@Aplica		varchar(50), 
			@Modulo 	varchar(5)	= NULL, 
			@Movimiento 	varchar(20)	= NULL, 
			@Categoria 	varchar(50)	= NULL, 
			@Grupo 		varchar(50)	= NULL, 
			@Familia 	varchar(50)	= NULL, 
			@Departamento 	varchar(50)	= NULL, 
			@Puesto 	varchar(50)	= NULL, 
			@SIC 		varchar(10)	= NULL,
			@Uso		varchar(50)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT 'Conteo' = ISNULL(COUNT(*), 0), 'FormaTipo' = MIN(FormaTipo) FROM dbo.fnFormaExtraVisible(@Aplica, @Modulo, @Movimiento, @Categoria, @Grupo, @Familia, @Departamento, @Puesto, @SIC)

  IF @Uso IS NOT NULL OR @Aplica IN ('Inmuebles', 'Contratos')
    EXEC xpFormaExtraVisible @Aplica, @Modulo, @Movimiento, @Categoria, @Grupo, @Familia, @Departamento, @Puesto, @SIC, @USO
  RETURN 
END
GO

-- spFormaExtraCampos 'Prospecto'
/****************  spFormaExtraCampos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExtraCampos') and type = 'P') drop procedure dbo.spFormaExtraCampos
GO
CREATE PROCEDURE spFormaExtraCampos
			@Aplica		varchar(50), 
			@Modulo 	varchar(5)	= NULL, 
			@Movimiento 	varchar(20)	= NULL, 
			@Categoria 	varchar(50)	= NULL, 
			@Grupo 		varchar(50)	= NULL, 
			@Familia 	varchar(50)	= NULL, 
			@Departamento 	varchar(50)	= NULL, 
			@Puesto 	varchar(50)	= NULL, 
			@SIC 		varchar(10)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  SELECT DISTINCT Campo
    FROM FormaExtraCampo
   WHERE FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisible(@Aplica, @Modulo, @Movimiento, @Categoria, @Grupo, @Familia, @Departamento, @Puesto, @SIC))
   ORDER BY Campo
END
GO

/*
DECLARE @FormaTipo varchar(20)
EXEC spFormaTipoDelCampo 'Prospecto', 'Densidad', @FormaTipo OUTPUT
SELECT @FormaTipo
*/
/****************  spFormaTipoDelCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaTipoDelCampo') and type = 'P') drop procedure dbo.spFormaTipoDelCampo
GO
CREATE PROCEDURE spFormaTipoDelCampo
			@Aplica		varchar(50), 
			@Campo		varchar(50),
			@FormaTipo	varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @FormaTipo = NULL
  SELECT @FormaTipo = MIN(FormaTipo)
    FROM FormaExtraCampo
   WHERE FormaTipo IN (SELECT FormaTipo FROM dbo.fnFormaExtraVisible(@Aplica, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL))
     AND Campo = @Campo
  SELECT @FormaTipo = NULLIF(RTRIM(@FormaTipo), '')
END
GO


-- SELECT * FROM dbo.fnFormaExtraVisibleMovimiento('VTAS', 'Servicio')
/**************** fnFormaExtraVisibleMovimiento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleMovimientos') DROP FUNCTION fnFormaExtraVisibleMovimientos
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleMovimiento') DROP FUNCTION fnFormaExtraVisibleMovimiento
GO
CREATE FUNCTION fnFormaExtraVisibleMovimiento (@Modulo varchar(5), @Movimiento varchar(20))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Movimiento', @Modulo, @Movimiento, NULL, NULL, NULL, NULL, NULL, NULL)
  RETURN
END
GO

/**************** fnFormaExtraVisibleProspecto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleProspectos') DROP FUNCTION fnFormaExtraVisibleProspectos
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleProspecto') DROP FUNCTION fnFormaExtraVisibleProspecto
GO
CREATE FUNCTION fnFormaExtraVisibleProspecto (@Categoria varchar(50), @Grupo varchar(50), @Familia varchar(50), @SIC varchar(10))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Prospecto', NULL, NULL, @Categoria, @Grupo, @Familia, NULL, NULL, @SIC)
  RETURN
END
GO

-- SELECT * FROM dbo.fnFormaExtraVisibleCliente('A', 'Grupo 1', 'Fam 1')

/**************** fnFormaExtraVisibleCliente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleClientes') DROP FUNCTION fnFormaExtraVisibleClientes
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleCliente') DROP FUNCTION fnFormaExtraVisibleCliente
GO
CREATE FUNCTION fnFormaExtraVisibleCliente (@Categoria varchar(50), @Grupo varchar(50), @Familia varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Cliente', NULL, NULL, @Categoria, @Grupo, @Familia, NULL, NULL, NULL)
  RETURN
END
GO

/**************** fnFormaExtraVisibleProveedor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleProveedores') DROP FUNCTION fnFormaExtraVisibleProveedores
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleProveedor') DROP FUNCTION fnFormaExtraVisibleProveedor
GO
CREATE FUNCTION fnFormaExtraVisibleProveedor (@Categoria varchar(50), @Familia varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Proveedor', NULL, NULL, @Categoria, NULL, @Familia, NULL, NULL, NULL)
  RETURN
END
GO

/**************** fnFormaExtraVisiblePersonal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisiblePersonal') DROP FUNCTION fnFormaExtraVisiblePersonal
GO
CREATE FUNCTION fnFormaExtraVisiblePersonal (@Categoria varchar(50), @Grupo varchar(50), @Departamento varchar(50), @Puesto varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Personal', NULL, NULL, @Categoria, @Grupo, NULL, @Departamento, @Puesto, NULL)
  RETURN
END
GO

/**************** fnFormaExtraVisibleAgente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleAgentes') DROP FUNCTION fnFormaExtraVisibleAgentes
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleAgente') DROP FUNCTION fnFormaExtraVisibleAgente
GO
CREATE FUNCTION fnFormaExtraVisibleAgente (@Categoria varchar(50), @Grupo varchar(50), @Familia varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Agente', NULL, NULL, @Categoria, @Grupo, @Familia, NULL, NULL, NULL)
  RETURN
END
GO


/**************** fnFormaExtraVisibleArticulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleArticulos') DROP FUNCTION fnFormaExtraVisibleArticulos
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleArticulo') DROP FUNCTION fnFormaExtraVisibleArticulo
GO
CREATE FUNCTION fnFormaExtraVisibleArticulo (@Categoria varchar(50), @Grupo varchar(50), @Familia varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Articulo', NULL, NULL, @Categoria, @Grupo, @Familia, NULL, NULL, NULL)
  RETURN
END
GO

/**************** fnFormaExtraVisibleAlmacen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleAlmacenes') DROP FUNCTION fnFormaExtraVisibleAlmacenes
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormaExtraVisibleAlmacen') DROP FUNCTION fnFormaExtraVisibleAlmacen
GO
CREATE FUNCTION fnFormaExtraVisibleAlmacen (@Categoria varchar(50), @Grupo varchar(50))
RETURNS @Resultado TABLE (FormaTipo varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado SELECT FormaTipo FROM dbo.fnFormaExtraVisible('Almacen', NULL, NULL, @Categoria, @Grupo, NULL, NULL, NULL, NULL)
  RETURN 
END
GO


-- SELECT * FROM FormaTipo WHERE FormaTipo = 'Cliente'


/****** Consecutivos FormaExtra ******/
if not exists(select * from SysTabla where SysTabla = 'FormaExtraC')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaExtraC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FormaExtraC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priFormaExtraC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'FormaExtraC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'FormaExtraC', '(ID)'
GO

/****** FormaExtra (Ficha) ******/
if not exists(select * from SysTabla where SysTabla = 'FormaExtra')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('FormaExtra','Movimiento','FRM')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtra') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FormaExtra (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NOT NULL,
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
	Estatus 		varchar(15)   	NULL,
	Situacion		varchar(50)	NULL,
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
	Sucursal		int		NOT NULL DEFAULT 0,

	FormaTipo		varchar(20)	NULL,
	Aplica			varchar(50)	NULL,
	AplicaClave		varchar(50)	NULL,

	eMail			varchar(50)	NULL,

	CONSTRAINT priFormaExtra PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'FormaExtra'
END
go
EXEC spSincroNivelRegistro @Tabla = 'FormaExtra'
go

if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX FormaExtra.Abrir
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX FormaExtra.Situacion2
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaExtraA') and sysstat & 0xf = 8) drop trigger dbo.tgFormaExtraA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFormaExtraC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaExtraC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFormaExtraB') and sysstat & 0xf = 8) drop trigger dbo.tgFormaExtraB
GO
EXEC spModificarPK_Mov 'FormaExtra'
GO
EXEC spSincroNivelRegistroCampos 'FormaExtra'
GO
-- Aqui va el Matenimiento a la tabla
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia    ON dbo.FormaExtra (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.FormaExtra (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.FormaExtra (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.FormaExtra (Mov, Estatus, Sucursal, Empresa, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.FormaExtra (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.FormaExtra (Usuario)
GO
EXEC spADD_INDEX 'FormaExtra', 'Aplica', 'AplicaClave, Aplica'
EXEC spADD_INDEX 'FormaExtra', 'eMail', 'eMail'
GO

EXEC spFK 'FormaExtra','UEN','UEN','UEN'
EXEC spFK 'FormaExtra','Proyecto','Proy','Proyecto'
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON FormaExtra (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON FormaExtra (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'FormaExtra' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON FormaExtra (OrigenID,Origen,Empresa)
go


CREATE TRIGGER tgFormaExtraC ON FormaExtra
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
  
  SELECT @Modulo = 'FRM'
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
/*  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE FormaExtra SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL */
END
GO
CREATE TRIGGER tgFormaExtraB ON FormaExtra
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'EMAIL')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'FRM', @ID
END
GO
-- drop table FormaExtraD

/****** FormaExtraD (Detalle) ******/
if not exists(select * from SysTabla where SysTabla = 'FormaExtraD')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('FormaExtraD','Movimiento','FRM')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FormaExtraD (
	ID 			int       	NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	FormaTipo		varchar(20)	NULL,
	Aplica			varchar(50)	NULL,
	AplicaClave		varchar(50)	NULL,
	Campo			varchar(50)	NULL,

	Valor			varchar(255)	NULL,
	ValorAnterior		varchar(255)	NULL,
	Tiempo			datetime	NULL,
	TiempoAnterior		datetime	NULL,

	CONSTRAINT priFormaExtraD PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'FormaExtraD'
END
go
EXEC spModificarPK_Sucursal 'FormaExtraD', '(ID, RID)'
GO

EXEC spFK2 'FormaExtraD','FormaTipo','Campo','FormaExtraCampo','FormaTipo','Campo'
EXEC spFK 'FormaExtraD','FormaTipo','FormaTipo','FormaTipo'
GO

if exists (select * from sysobjects where id = object_id('dbo.cFormaExtraD') and sysstat & 0xf = 2) drop view dbo.cFormaExtraD
GO
CREATE VIEW cFormaExtraD
--//WITH ENCRYPTION
AS
SELECT
  ID,

  Sucursal,
  SucursalOrigen,

  FormaTipo,
  Aplica,
  AplicaClave,
  Campo,
  Valor

FROM
  FormaExtraD
GO

if not exists(select * from SysTabla where SysTabla = 'FormaExtraCampoExpresion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaExtraCampoExpresion','Maestro')
GO

/**************** spFormaExpress ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaExpress') and type = 'P') drop procedure dbo.spFormaExpress
GO
CREATE PROCEDURE spFormaExpress	
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	varchar(10),
			@FechaEmision	datetime,
			@FormaTipo	varchar(20),
			@Aplica		varchar(50), 	-- Movimiento
			@AplicaClave	varchar(50)	-- VTAS123
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  SELECT @ID = NULL
  SELECT @ID = MAX(ID) FROM FormaExtra WHERE Aplica = @Aplica AND AplicaClave = @AplicaClave
  IF @ID IS NULL
  BEGIN
    INSERT FormaExtra (Mov, Empresa, Sucursal, Usuario, Estatus, FechaEmision, FormaTipo, Aplica, AplicaClave) 
               VALUES ('Evaluacion', @Empresa, @Sucursal, @Usuario, 'SINAFECTAR', @FechaEmision, @FormaTipo, @Aplica, @AplicaClave)
    SELECT @ID = SCOPE_IDENTITY()
  END
  SELECT 'ID' = @ID
  RETURN 
END
GO

/**************** spFormaCorregirHTMLSelect ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaCorregirHTMLSelect') and type = 'P') drop procedure dbo.spFormaCorregirHTMLSelect
GO
CREATE PROCEDURE spFormaCorregirHTMLSelect
		    @select	varchar(8000) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @idoc 	int,
    @ID		int,
    @a		int,
    @p		int,
    @p1		int,
    @p2		int,
    @value	varchar(255)

  CREATE TABLE #select (ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, value varchar(255) COLLATE Database_Default NULL)
  EXEC sp_xml_preparedocument @idoc OUTPUT, @select
  INSERT #select (value) 
  SELECT value
  FROM OPENXML (@idoc, '/select/option',1)
        WITH (value  varchar(255))
  WHERE NULLIF(RTRIM(value), '') IS NOT NULL
  EXEC sp_xml_removedocument @idoc

  SELECT @value = NULL
  SELECT @value = MIN(value) FROM #select GROUP BY value HAVING COUNT(*)>1
  IF @value IS NOT NULL
  BEGIN
    SELECT @ID = MAX(ID) FROM #select where value = @value
    IF @ID IS NOT NULL
    BEGIN
      SELECT @a = 0, @p = 1
      WHILE @a < @ID 
      BEGIN
        IF @p>1 SELECT @p = @p + 8
        SELECT @p = CHARINDEX('<option ', @select, @p)
        SELECT @a = @a + 1
      END
      SELECT @p1 = CHARINDEX('<option ', @select, @p)
      SELECT @p2 = CHARINDEX('</option>', @select, @p1)
      SELECT @select = STUFF(@select, @p1, @p2-@p1+9, '')
    END
  END
  RETURN 
END
GO

/**************** spFormaCorregirHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaCorregirHTML') and type = 'P') drop procedure dbo.spFormaCorregirHTML
GO
CREATE PROCEDURE spFormaCorregirHTML
		    @HTML	varchar(8000) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p1	int, 
    @p2	int,
    @s	varchar(8000)

  SELECT @p1 = CHARINDEX('<select ', @HTML)
  WHILE @p1 > 0 
  BEGIN
    SELECT @p2 = CHARINDEX('</select>', @HTML, @p1)
    SELECT @s = SUBSTRING(@HTML, @p1, @p2-@p1+9)
    EXEC spFormaCorregirHTMLSelect @s OUTPUT
    SELECT @HTML = STUFF(@HTML, @p1, @p2-@p1+9, @s)
    SELECT @p1 = CHARINDEX('<select ', @HTML, @p1+8)
  END
  RETURN 
END
GO

IF NOT EXISTS(SELECT * FROM FormaExtraCampoFijo)
BEGIN
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Tipo}', 		'Encabezado - Tipo Objeto')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_FormaTipo}', 		'Encabezado - Tipo Forma')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Titulo}', 		'Encabezado - Titulo')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Encabezado}', 	'Encabezado - Encabezado')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_NombreCorto}', 	'Encabezado - Nombre Corto')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Categoria}', 		'Encabezado - Categoria')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_ID}', 		'Encabezado - ID')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Ok}', 		'Encabezado - Mensaje Numero')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_OkRef}', 		'Encabezado - Mensaje Referencia')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_OkDesc}', 		'Encabezado - Mensaje Descripcion')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_OkTipo}', 		'Encabezado - Mensaje Tipo')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_Mov}', 		'Encabezado - Movimiento')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_MovID}', 		'Encabezado - Consecutivo')
  INSERT FormaExtraCampoFijo (Campo, Etiqueta) VALUES ('{_eMail}', 		'Encabezado - Correo eletronico')
END
GO

/**************** spFormaParcearHTML ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaParcearHTML') and type = 'P') drop procedure dbo.spFormaParcearHTML
GO
CREATE PROCEDURE spFormaParcearHTML
		    @ID		int,
		    @Ok		int,
		    @OkRef	varchar(255),
		    @HTML	varchar(8000) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FormaTipo		varchar(20),
    @Mov		varchar(20),
    @MovID		varchar(20),
    @OkDesc    		varchar(255),
    @OkTipo    		varchar(50),
    @Campo		varchar(50),
    @Valor		varchar(255),
    @eMail	 	varchar(50),
    @Titulo		varchar(100),
    @Encabezado		varchar(255),
    @NombreCorto	varchar(50),
    @Categoria		varchar(50)

  IF @Ok IS NOT NULL 
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok  

  SELECT @Mov = Mov, @MovID = MovID, @FormaTipo = FormaTipo, @eMail = eMail
    FROM FormaExtra 
   WHERE ID = @ID

  SELECT @Titulo = Titulo, @Encabezado = Encabezado, @NombreCorto = NombreCorto, @Categoria = Categoria
    FROM FormaTipo
   WHERE FormaTipo = @FormaTipo
  
  SELECT @HTML = REPLACE(@HTML, '{_Tipo}', 'FORMA')
  SELECT @HTML = REPLACE(@HTML, '{_FormaTipo}', ISNULL(@FormaTipo, ''))
  SELECT @HTML = REPLACE(@HTML, '{_Titulo}', ISNULL(@Titulo, ''))
  SELECT @HTML = REPLACE(@HTML, '{_Encabezado}', ISNULL(@Encabezado, ''))
  SELECT @HTML = REPLACE(@HTML, '{_NombreCorto}', ISNULL(@NombreCorto, ''))
  SELECT @HTML = REPLACE(@HTML, '{_Categoria}', ISNULL(@Categoria, ''))
  SELECT @HTML = REPLACE(@HTML, '{_ID}', ISNULL(CONVERT(varchar, @ID), ''))
  SELECT @HTML = REPLACE(@HTML, '{_Ok}', ISNULL(CONVERT(varchar, @Ok), ''))
  SELECT @HTML = REPLACE(@HTML, '{_OkRef}', ISNULL(@OkRef, ''))
  SELECT @HTML = REPLACE(@HTML, '{_OkDesc}', ISNULL(@OkDesc, ''))
  SELECT @HTML = REPLACE(@HTML, '{_OkTipo}', ISNULL(@OkTipo, ''))
  SELECT @HTML = REPLACE(@HTML, '{_Mov}', ISNULL(@Mov, ''))
  SELECT @HTML = REPLACE(@HTML, '{_MovID}', ISNULL(@MovID, ''))
  SELECT @HTML = REPLACE(@HTML, '{_eMail}', ISNULL(@eMail, ''))

  DECLARE crFormaExtraD CURSOR LOCAL FOR
   SELECT fc.Campo, d.Valor
     FROM FormaExtraCampo fc
     LEFT OUTER JOIN FormaExtraD d ON d.ID = @ID AND d.Campo = fc.Campo
    WHERE fc.FormaTipo = @FormaTipo
  OPEN crFormaExtraD
  FETCH NEXT FROM crFormaExtraD INTO @Campo, @Valor
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      SELECT @HTML = REPLACE(@HTML, '{'+@Campo+'}', ISNULL(@Valor, ''))
    END
    FETCH NEXT FROM crFormaExtraD INTO @Campo, @Valor
  END
  CLOSE crFormaExtraD
  DEALLOCATE crFormaExtraD
  EXEC spFormaCorregirHTML @HTML OUTPUT

  RETURN
END
GO

-- spIntelisisCGI 'PROCESAR', 'FORMA', 8
-- select * from FormaExtraD where id = 8
/**************** spIntelisisCGI ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisCGI') and type = 'P') drop procedure dbo.spIntelisisCGI
GO
CREATE PROCEDURE spIntelisisCGI 
			@Accion		varchar(20),	-- Agregar, Procesar
			@GUID		uniqueidentifier,

			@Campo		varchar(50)	= NULL,
			@Valor		text		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		char(5),
    @Sucursal		int,
    @FormaTipo		varchar(20),
    @Aplica		varchar(50),
    @AplicaClave	varchar(50),
    @Estatus		varchar(50),
    @HTML		varchar(8000),
    @Ok			int,
    @OkRef		varchar(255),
    @Tipo		varchar(20),	-- FORMA, SOLICITUD
    @ID			int,
    @eMail		varchar(50),
    @Mov		varchar(20)

  SELECT @Accion = UPPER(@Accion), @Tipo = UPPER(@Tipo), @Ok = NULL, @OkRef = NULL

  IF @Accion = 'AGREGAR' 
    INSERT IntelisisCGI (GUID, Campo, Valor) VALUES (@GUID, @Campo, @Valor)
  ELSE
  IF @Accion = 'PROCESAR' 
  BEGIN
    SELECT @Tipo = Valor FROM IntelisisCGI WHERE GUID = @GUID AND Campo = '_Tipo'
    SELECT @ID   = CONVERT(int, CONVERT(varchar, Valor)) FROM IntelisisCGI WHERE GUID = @GUID AND Campo = '_ID'

    IF @Tipo = 'FORMA'	-- Recibir Forma
    BEGIN
      SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Estatus = Estatus,
             @FormaTipo = FormaTipo, @Aplica = Aplica, @AplicaClave = AplicaClave
        FROM FormaExtra 
       WHERE ID = @ID
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'EMAIL')
      BEGIN
        DELETE FormaExtraD WHERE ID = @ID
        INSERT FormaExtraD (
               ID,  FormaTipo,  Aplica,  AplicaClave,  Campo, Valor)
        SELECT @ID, @FormaTipo, @Aplica, @AplicaClave, Campo, Valor
          FROM IntelisisCGI
         WHERE GUID = @GUID AND SUBSTRING(Campo, 1, 1) <> '_'

        EXEC spAfectar 'FRM', @ID, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        IF @Ok IS NULL
          SELECT @Ok = 80200, @OkRef = ISNULL(Mov, '')+' '+ISNULL(MovID, '') FROM FormaExtra WHERE ID = @ID
      END ELSE
        SELECT @Ok = 10015, @OkRef = @Estatus
    END ELSE
    IF @Tipo = 'SOLICITUD'
    BEGIN
      SELECT @Empresa = Valor FROM IntelisisCGI WHERE GUID = @GUID AND Campo = 'Empresa'
      SELECT @eMail   = Valor FROM IntelisisCGI WHERE GUID = @GUID AND Campo = 'eMail'
      SELECT @Mov     = Valor FROM IntelisisCGI WHERE GUID = @GUID AND Campo = 'Mov'
    END
  END

  IF @Accion = 'PROCESAR' 
  BEGIN
    DELETE IntelisisCGI WHERE GUID = @GUID

    SELECT @HTML = CONVERT(varchar(8000), RecibirFormaHTML) FROM EmpresaGral WHERE Empresa = @Empresa
    EXEC spFormaParcearHTML @ID, @Ok, @OkRef, @HTML OUTPUT
    SELECT 'HTML' = @HTML
  END
END
GO


/****************  spFormularioLista  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormularioLista') and type = 'P') 
  drop procedure dbo.spFormularioLista
GO
CREATE PROCEDURE spFormularioLista
--//WITH ENCRYPTION
AS BEGIN
  SELECT FormaTipo, NombreCorto, Titulo, Encabezado, PuedeCancelar, OrdenEspecial, FondoImagen, FondoColor, 
         FuenteEspecial, FuenteNombre, FuenteEstilo, FuenteTamano, FuenteColor, FuenteSubrayado
    FROM FormaTipo 
   WHERE Tipo = 'Formulario'
     AND Estatus = 'ALTA'
   ORDER BY Titulo
END
GO
-- EXEC spFormularioLista



/****************  spFormularioCampos  ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormularioCampos') and type = 'P') 
  drop procedure dbo.spFormularioCampos
GO
CREATE PROCEDURE spFormularioCampos
                     @Formulario  varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  SELECT Campo, Etiqueta, TipoDato, Orden, FondoColor, PosX, PosY, Ancho, FuenteEspecial, FuenteNombre, FuenteEstilo,
         FuenteTamano, FuenteColor, FuenteSubrayado
    FROM FormaExtraCampo
   WHERE FormaTipo = @Formulario
   ORDER BY Orden
END
GO


/*** SysCaracteristica ***/
if exists (select * from sysobjects where id = object_id('dbo.SysCaracteristica') and type = 'V') drop view dbo.SysCaracteristica
GO
CREATE VIEW SysCaracteristica
--//WITH ENCRYPTION
AS
SELECT 'Tabla' = Aplica, 'Campo' = '('+Campo+')'
  FROM FormaExtraValor
 WHERE Eliminado = 0 AND Campo IS NOT NULL
 GROUP BY Aplica, Campo
GO
