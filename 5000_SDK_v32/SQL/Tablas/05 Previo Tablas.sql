SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO
/**************** xpConfigSQL ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpConfigSQL') and type = 'P') drop procedure dbo.xpConfigSQL
GO
CREATE PROCEDURE xpConfigSQL
AS BEGIN
  SET DATEFIRST 7
  SET ANSI_NULLS OFF
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  SET LOCK_TIMEOUT -1
  SET QUOTED_IDENTIFIER OFF
  RETURN
END
GO

/**************** xpInicioMantenimiento ****************/
if not exists (select * from sysobjects where id = object_id('dbo.xpInicioMantenimiento') and type = 'P') 
BEGIN
  Declare @SQL varchar(255)
  SELECT @SQL= N'CREATE PROCEDURE xpInicioMantenimiento as BEGIN RETURN END'
  EXEC(@SQL)
END
GO

EXEC xpInicioMantenimiento
GO

/**************** spEliminarTriggerSincro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarTriggerSincro') and type = 'P') DROP PROCEDURE spEliminarTriggerSincro
GO
CREATE PROCEDURE spEliminarTriggerSincro
--/WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON 
  DECLARE
    @Trigger 	varchar(255)

  DECLARE crTabla CURSOR FOR
   SELECT name FROM sysobjects AS s WHERE NAME LIKE '%sincro%' AND s.[type] = 'TR'
   
  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @Trigger
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN    
      EXEC("if exists (select * from sysobjects where id = object_id('"+@Trigger+"') and sysstat & 0xf = 8) drop trigger "+@Trigger)
      
    END
    FETCH NEXT FROM crTabla INTO @Trigger
  END
  CLOSE crTabla
  DEALLOCATE crTabla
END 
GO

EXEC spEliminarTriggerSincro
GO

/**************** fnFechaSinHora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaSinHora' AND type = 'FN') DROP FUNCTION fnFechaSinHora
GO
CREATE FUNCTION fnFechaSinHora (@Fecha	datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  RETURN (DATEADD(ms, -DATEPART(ms, @Fecha), DATEADD(ss, -DATEPART(ss, @Fecha), DATEADD(mi, -DATEPART(mi, @Fecha), DATEADD(hh, -DATEPART(hh, @Fecha), @Fecha)))))
END
GO

/*** SysCampo ***/
if exists (select * from sysobjects where id = object_id('dbo.SysCampo') and type = 'V') drop view dbo.SysCampo
GO
CREATE VIEW SysCampo
--//WITH ENCRYPTION
AS
SELECT "Tabla" = t.name, "Campo" = c.name , "ColID" = c.ColID, "EsCalculado" = c.IsComputed
  FROM sysobjects t, syscolumns c
 WHERE t.id = c.id AND t.type = 'U'
GO

-- select * from SysCampoExt where tabla = 'ventaTcalc' order by orden
/*** SysCampoExt ***/
if exists (select * from sysobjects where id = object_id('dbo.SysCampoExt') and type = 'V') drop view dbo.SysCampoExt
GO
CREATE VIEW SysCampoExt
--//WITH ENCRYPTION
AS
SELECT 'Tabla' = tablas.name, 
       'Campo' = columnas.name,
       'Orden' = columnas.ColID,
       'TipoDatos' = tipos.name,       
       'Ancho' = columnas.length,
       'Precision' = columnas.prec,
       'Escala' = columnas.scale,
       'AceptaNulos' = isnullable,
       'EsIdentity' = convert(bit, CASE WHEN columnas.status = 128 THEN 1 ELSE 0 END),
       'EsCalculado' = columnas.iscomputed,
       'Collation' = columnas.Collation,
       'Tipo' = tablas.type
  FROM syscolumns columnas
  JOIN systypes tipos ON tipos.xtype = columnas.xtype
  JOIN sysobjects tablas ON columnas.ID = tablas.ID
GO

-- select * from SysTipoDatos where tabla = 'mov'
/*** SysTipoDatos ***/
if exists (select * from sysobjects where id = object_id('dbo.SysTipoDatos') and type = 'V') drop view dbo.SysTipoDatos
GO
CREATE VIEW SysTipoDatos
--//WITH ENCRYPTION
AS
SELECT "Tabla" = t.Name, "Campo" = c.Name, "TipoDatos" = y.Name, "Tamano" = c.Length, "Nulos" = c.IsNullable
  FROM sysobjects t, syscolumns c, systypes y
 WHERE t.id = c.id AND t.type = 'U' AND c.xusertype = y.xusertype
GO


/*** SysVistaCampo ***/
if exists (select * from sysobjects where id = object_id('dbo.SysVistaCampo') and type = 'V') drop view dbo.SysVistaCampo
GO
CREATE VIEW SysVistaCampo
--//WITH ENCRYPTION
AS
SELECT "Vista" = t.name, "Campo" = c.name 
  FROM sysobjects t, syscolumns c
 WHERE t.id = c.id AND t.type = 'V'
GO

-- select dbo.fnTablaExiste('Art')
/**************** fnTablaExiste ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTablaExiste') DROP FUNCTION fnTablaExiste
GO
CREATE FUNCTION fnTablaExiste(@Tabla varchar(255))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  SELECT @Resultado = 0
  IF EXISTS(SELECT * FROM sysobjects WHERE type = 'U' AND name = @Tabla)
    SELECT @Resultado = 1 

  RETURN (@Resultado)
END
GO

/**************** fnCampoExiste ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCampoExiste') DROP FUNCTION fnCampoExiste
GO
CREATE FUNCTION fnCampoExiste(@Tabla varchar(255), @Campo varchar(255))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  SELECT @Resultado = 0
  IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo)
    SELECT @Resultado = 1 

  RETURN (@Resultado)
END
GO

-- spDROP_CONSTRAINT 'Prueba', 'Hoy'
/**************** spDROP_CONSTRAINT ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_CONSTRAINT') and type = 'P') drop procedure dbo.spDROP_CONSTRAINT
GO
CREATE PROCEDURE spDROP_CONSTRAINT
		   @Tabla 	varchar(100),
		   @Campo	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Constraint	sysname,
    @SQL	varchar(max)

  IF EXISTS (SELECT * FROM SysObjects, SysColumns, SysConstraints WHERE SysObjects.ID = SysColumns.ID AND SysObjects.ID = SysConstraints.ID AND SysColumns.ColID = SysConstraints.ColID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo)
  BEGIN
    SELECT @Constraint = OBJECT_NAME(ConstID) FROM SysObjects, SysColumns, SysConstraints WHERE SysObjects.ID = SysColumns.ID AND SysObjects.ID = SysConstraints.ID AND SysColumns.ColID = SysConstraints.ColID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo
    SELECT @SQL = 'ALTER TABLE ' + @Tabla + ' DROP CONSTRAINT ' + RTRIM(@Constraint)
    IF @SQL IS NOT NULL
      EXEC(@SQL)
  END
END
GO

/**************** spALTER_TABLE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spALTER_TABLE') and type = 'P') drop procedure dbo.spALTER_TABLE
GO
CREATE PROCEDURE spALTER_TABLE
		   @Tabla 	varchar(100),
		   @Campo	varchar(100),
		   @Extras	varchar(max),
		   @Default	varchar(max) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(max)

  --TASK2512
  if not exists (select * from sysobjects where id = object_id(@Tabla) and type='U')
   Return

  if not exists(select * from syscampo where tabla = @Tabla and campo = @Campo)
  BEGIN
    SELECT @SQL = 'ALTER TABLE '+@Tabla+' ADD '+@Campo+' '+@Extras
    IF NULLIF(RTRIM(@Default), '') IS NOT NULL
      SELECT @SQL = @SQL + ' DEFAULT '+@Default
    EXEC(@SQL)
  END
END
GO

/**************** spALTER_COLUMN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spALTER_COLUMN') and type = 'P') drop procedure dbo.spALTER_COLUMN
GO
CREATE PROCEDURE spALTER_COLUMN
		   @Tabla 	varchar(100),
		   @Campo	varchar(100),
		   @Extras	varchar(max),
		   @Default	varchar(max) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nombre	varchar(100)

  --TASK2512
  if not exists (select * from sysobjects where id = object_id(@Tabla) and type='U')
   Return

  EXEC spDROP_CONSTRAINT @Tabla, @Campo
  EXEC('ALTER TABLE '+@Tabla+' ALTER COLUMN '+@Campo+' '+@Extras)

  IF NULLIF(RTRIM(@Default), '') IS NOT NULL
  BEGIN
    SELECT @Nombre = 'DF_'+@Tabla+'_'+@Campo+'_'+CONVERT(varchar, ColID) FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT '+@Nombre+' DEFAULT '+@Default+' FOR '+@Campo)
  END
END
GO

/**************** spDROP_TABLE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_TABLE') and type = 'P') drop procedure dbo.spDROP_TABLE
GO
CREATE PROCEDURE spDROP_TABLE
		   @Tabla 	varchar(100),
		   @Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN

  if exists (select * from sysobjects where id = object_id(@Tabla) and type = 'U')
    EXEC('DROP TABLE '+@Tabla)

  DELETE SysTabla WHERE SysTabla = @Tabla
END
GO

/**************** spDROP_VIEW ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_VIEW') and type = 'P') drop procedure dbo.spDROP_VIEW
GO
CREATE PROCEDURE spDROP_VIEW
		   @Vista 	varchar(100),
		   @Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN

  if exists (select * from sysobjects where id = object_id(@Vista) and sysstat & 0xf = 2) 
    EXEC('DROP VIEW '+@Vista)
END
GO

/**************** spDROP_PROCEDURE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_PROCEDURE') and type = 'P') drop procedure dbo.spDROP_PROCEDURE
GO
CREATE PROCEDURE spDROP_PROCEDURE
		   @sp	 	varchar(50),
		   @Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN

  if exists (select * from sysobjects where id = object_id(@sp) and type = 'P') 
    EXEC('DROP PROCEDURE '+@sp)
END
GO

/********************* spDROP_COLUMN *****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_COLUMN') and type = 'p') drop procedure dbo.spDROP_COLUMN
GO
CREATE PROCEDURE spDROP_COLUMN
        @Tabla          sysname,
        @Campo          sysname,
        @Otros          sysname = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(max)

  IF EXISTS (SELECT * FROM SysObjects, SysColumns WHERE SysObjects.ID = SysColumns.ID AND SysObjects.Name = @Tabla AND SysColumns.Name = @Campo)
  BEGIN
    EXEC spDROP_CONSTRAINT @Tabla, @Campo
    SELECT @SQL = 'ALTER TABLE ' + @Tabla + ' DROP COLUMN ' + RTRIM(@Campo)
    IF @SQL IS NOT NULL
      EXEC(@SQL)
  END

  RETURN
END
GO

/**************** spRENAME_TABLE ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRENAME_TABLE') and type = 'P') drop procedure dbo.spRENAME_TABLE
GO
CREATE PROCEDURE spRENAME_TABLE
		   @Anterior	varchar(100),
		   @Nuevo	varchar(100),
		   @Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN
  
  if exists (select * from sysobjects where id = object_id(@Anterior) and type = 'U')
  AND NOT exists (select * from sysobjects where id = object_id(@Nuevo) and type = 'U')
    EXEC("sp_rename '"+@Anterior+"', '"+@Nuevo+"'")
END
GO

/********************* spDROP_TRIGGER *****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_TRIGGER') and type = 'p') drop procedure dbo.spDROP_TRIGGER
GO
CREATE PROCEDURE spDROP_TRIGGER
			@Trigger	sysname,
		   	@Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(255)

  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN
  IF EXISTS(select * from sysobjects where id = object_id(@Trigger) and sysstat & 0xf = 8)
  BEGIN
    SELECT @SQL = 'DROP TRIGGER '+@Trigger
    EXEC(@SQL)
  END
  RETURN
END
GO

/**************** spRENAME_COLUMN ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRENAME_COLUMN') and type = 'P') drop procedure dbo.spRENAME_COLUMN
GO
CREATE PROCEDURE spRENAME_COLUMN
		   @Tabla 	varchar(100),
		   @Anterior	varchar(100),
		   @Nuevo	varchar(200)
--//WITH ENCRYPTION
AS BEGIN
  if exists(select * from syscampo where tabla = @Tabla and campo = @Anterior) and
     not exists(select * from syscampo where tabla = @Tabla and campo = @Nuevo)
    EXEC("sp_rename '"+@Tabla+"."+@Anterior+"', '"+@Nuevo+"', 'COLUMN'")
END
GO

--REQ16092
/**************** spADD_UNIQUEINDEX ****************/
if exists (select * from sysobjects where id = object_id('dbo.spADD_UNIQUEINDEX') and type = 'P') drop procedure dbo.spADD_UNIQUEINDEX
GO
CREATE PROCEDURE spADD_UNIQUEINDEX
		   @Tabla 	varchar(100),
		   @Indice	varchar(100),
		   @Campos	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = @Tabla AND sysindexes.name = @Indice AND sysobjects.id = sysindexes.id)
    EXEC('CREATE UNIQUE INDEX '+@Indice+' ON '+@Tabla+' ('+@Campos+')')
END
GO

/**************** spADD_INDEX ****************/
if exists (select * from sysobjects where id = object_id('dbo.spADD_INDEX') and type = 'P') drop procedure dbo.spADD_INDEX
GO
CREATE PROCEDURE spADD_INDEX
		   @Tabla 	varchar(100),
		   @Indice	varchar(100),
		   @Campos	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = @Tabla AND sysindexes.name = @Indice AND sysobjects.id = sysindexes.id)
    EXEC('CREATE INDEX '+@Indice+' ON '+@Tabla+' ('+@Campos+')')
END
GO

/**************** spDROP_INDEX ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_INDEX') and type = 'P') drop procedure dbo.spDROP_INDEX
GO
CREATE PROCEDURE spDROP_INDEX
		   @Tabla 	varchar(100),
		   @Indice	varchar(100),
		   @Version	int = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (SELECT Version FROM Version) > @Version RETURN

  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = @Tabla AND sysindexes.name = @Indice AND sysobjects.id = sysindexes.id)
    EXEC('DROP INDEX '+@Tabla+'.'+@Indice)
END
GO

-- Convierte una columna fisica en una columna calculada
/**************** spCOLUMN_RO ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCOLUMN_RO') and type = 'P') drop procedure dbo.spCOLUMN_RO
GO
CREATE PROCEDURE spCOLUMN_RO
		   @Tabla 	varchar(100),
		   @Campo	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoDatos	varchar(50)

  IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo AND EsCalculado = 0)
  BEGIN
    SELECT @TipoDatos = TipoDatos FROM SysTipoDatos WHERE Tabla = @Tabla AND Campo = @Campo 
    EXEC('ALTER TABLE '+@Tabla+' DROP COLUMN '+@Campo)
    EXEC('ALTER TABLE '+@Tabla+' ADD '+@Campo+' AS CONVERT('+@TipoDatos+', NULL)')
  END
END
GO

-- Convierte una columna calculada en una columna fisica 
/**************** spCOLUMN_NORMAL ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCOLUMN_NORMAL') and type = 'P') drop procedure dbo.spCOLUMN_NORMAL
GO
CREATE PROCEDURE spCOLUMN_NORMAL
		   @Tabla 	varchar(100),
		   @Campo	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoDatos	varchar(50)

  IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo AND EsCalculado = 1)
  BEGIN
    SELECT @TipoDatos = TipoDatos FROM SysTipoDatos WHERE Tabla = @Tabla AND Campo = @Campo 
    EXEC('ALTER TABLE '+@Tabla+' DROP COLUMN '+@Campo)
    EXEC('ALTER TABLE '+@Tabla+' ADD '+@Campo+' '+@TipoDatos+' NULL')
  END
END
GO

-- select * from syspk where tabla = 'mov'
-- SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'Mov' AND CONSTRAINT_NAME = 'priMov'
/*** SysPK ***/
if exists (select * from sysobjects where id = object_id('dbo.SysPK') and type = 'V') drop view dbo.SysPK
GO
CREATE VIEW SysPK
--//WITH ENCRYPTION
AS
  SELECT "Tabla" = u.name, "PK" = pk.name 
    FROM sysobjects u, sysobjects pk
   WHERE u.type = 'U' and pk.xtype = 'PK' and pk.parent_obj = u.id
GO

-- select * from SysIndice where tabla = 'mov'
/*** SysIndice ***/
if exists (select * from sysobjects where id = object_id('dbo.SysIndice') and type = 'V') drop view dbo.SysIndice
GO
CREATE VIEW SysIndice
--//WITH ENCRYPTION
AS
SELECT "Tabla" = t.name, "Indice" = i.name 
  FROM sysobjects t, sysindexes i
 WHERE t.id = i.id AND t.type = 'U'
GO

/****** VersionLog  ******/
if not exists (select * from sysobjects where id = object_id('dbo.VersionLog') and type = 'U') 
CREATE TABLE dbo.VersionLog (
	Version			int  		NOT NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priVersionLog PRIMARY KEY CLUSTERED (Version)

)
GO

/****** Version  ******/
if not exists (select * from sysobjects where id = object_id('dbo.Version') and type = 'U') 
CREATE TABLE dbo.Version (
	Version			int  		NOT NULL,
	Fecha			datetime	NULL,
	ID			int  		NOT NULL	DEFAULT 0,
	Sucursal		int  		NOT NULL	DEFAULT 0,
	ArtR			datetime	NULL,
	CteR			datetime	NULL		DEFAULT GETDATE(),
	UltimaCorrida		datetime	NULL,
	UltimaEstacion		int		NULL		DEFAULT 0,
	Sincronizando		bit		NULL		DEFAULT 0,
	PlanReferencia		varchar(50)	NULL,
	PlanReferenciaModulo	varchar(5)	NULL,

	MantenimientoInicio	datetime	NULL,
	MantenimientoFin	datetime	NULL,
	UltimoResumenMov	datetime	NULL,
	UltimoResumenMovProyecto datetime	NULL,
	UltimoResumenSaldo	datetime	NULL,

	IRP			bit		NULL		DEFAULT 0,

	MaxRespaldos		int		NULL		DEFAULT 7,
	TiempoUltimoRespaldo	int		NULL,
	AutoEjercicio		int		NULL,
	AutoPeriodo		int		NULL,

	RedondeoMonetarios	int		NULL		DEFAULT 4,
	ValidarSincroSemilla	bit		NULL		DEFAULT 1,
	SincroContabilidadMatriz bit		NULL		DEFAULT 1,
	Peru			bit		NULL		DEFAULT 0,
	NomLimiteInferior2	bit		NULL		DEFAULT 0,
	Sincro			bit		NULL		DEFAULT 0,
	SincroXMLManual		bit		NULL		DEFAULT 0,
	OutlookEstatusNuevo 	bit		NULL		DEFAULT 1,
	NombreCorreoEnLote	varchar(100)	NULL		DEFAULT 'Sistema',

	ContrasenaTamanoMinimo		int		NULL,
	ContrasenaRequiereAlfa		bit		NULL		DEFAULT 0,
	ContrasenaRequiereNumeros	bit		NULL		DEFAULT 0,
	ContrasenaEncriptada		bit		NULL		DEFAULT 0,

	OutlookMensajes			bit		NULL		DEFAULT 0,
	OutlookCitas			bit		NULL		DEFAULT 0,
	OutlookTareas			bit		NULL		DEFAULT 0,
	OutlookTareasSincronizar	bit		NULL		DEFAULT 0,
	OutlookActividadesSincronizar	bit		NULL		DEFAULT 0,

	MovMover			bit		NULL		DEFAULT 0,
	SituacionFinalAlRegresar	bit		NULL		DEFAULT 0,
	DeshabilitarAyuda		bit		NULL		DEFAULT 0,
	MaximizarVentanas		bit		NULL		DEFAULT 0,
	SR				bit		NULL		DEFAULT 0,

	SinAfectarComoPendiente		bit		NULL		DEFAULT 1,

	ModuloCentral			bit		 NULL		DEFAULT 0,
	ModuloCentralURL		varchar(255)	 NULL,
	Base				varchar(5)	 NULL,

	Desconectar			varchar(20)	 NULL		DEFAULT 'No',			-- No/Manual/Automatico
	Reconectar			varchar(20)	 NULL		DEFAULT 'Manual',		-- Manual/Automatico	
	EstaDesconectado		bit		 NULL		DEFAULT 0,
	FechaDesconexion		datetime	 NULL,	
	ReconexionFrecuencia		int		 NULL		DEFAULT 10,	-- minutos
	ReconexionUltimoIntento		datetime	 NULL,
	ConservarColaProcesada		int		 NULL		DEFAULT 24,	-- horas
	TamanoLoteProcesarCola		int		 NULL		DEFAULT 10,
	Replica				bit		 NULL		DEFAULT 0,
	ConservarReplicaProcesada	int		 NULL		DEFAULT 24,	-- horas
	TamanoLoteProcesarReplica	int		 NULL		DEFAULT 10,
	SincroSSB			bit		 NULL		DEFAULT 0,
	SincroSSBMismaInstancia		bit		 NULL		DEFAULT 0,
	SincroSBBOkConservar		int		 NULL		DEFAULT 7,	-- Dias
	SincroSSBReciboManual		bit		 NULL		DEFAULT 0,
	UsuarioWindows			varchar(100)	 NULL,		-- Dominio\Usuario
	PuertoSSB			int		 NULL		DEFAULT 4022,
	SincroSSBRecibirRespaldoMatriz  bit		 NULL		DEFAULT 0,
	TRCL				bit		 NULL		DEFAULT 0,

	IPDinamica			bit		 NULL		DEFAULT 0,
	IPDinamicaURL			varchar(255)	 NULL,
	IPDinamicaPrefijo		varchar(255)	 NULL,
	IPDinamicaSufijo		varchar(255)	 NULL,

	EncriptarContrasenas		bit		 NULL		DEFAULT 0,
	RegHist				bit		 NULL		DEFAULT 0,
	
	Impuesto2Info			bit		 NULL		DEFAULT 0,
	Impuesto3Info			bit		 NULL		DEFAULT 0,
	Impuesto2BaseImpuesto1		bit		 NULL		DEFAULT 1,
	Retencion2BaseImpuesto1		bit		 NULL		DEFAULT 0,
	
	FK				bit		 NULL		DEFAULT 1,
	FueraLinea			bit		 NULL		DEFAULT 0,
	
	SincroIS							bit				NULL		DEFAULT 0,
	SincroISRecibirRespaldoMatriz		bit				NULL		DEFAULT 0,
	ISDiasResguardoSolicitud			int				NULL		DEFAULT 60,
	
	SincroISDBMailPerfil				varchar(50)		NULL,		
	SincroISDBMailAsunto				varchar(MAX)	NULL		DEFAULT 'Notificacion Intelisis Sincro IS (ID#IntelisisServiceID#)',
	SincroISDBMailMensaje				varchar(MAX)   NULL		DEFAULT 'Tipo Solicitud #SubReferencia#<BR> Estatus #Estatus#<BR>Error #IntelisisServiceOk#<BR>Referencia #IntelisisServiceOkRef#<BR>Fecha #FechaEstatus#<BR>Conversación #Conversacion#<BR>Identificador Registro #SincroGUID#<BR>Sucursal Origen #SucursalOrigen#<BR>Sucursal Destino #SucursalDestino#',

    RecibirCorreoRuta					varchar(255) NULL, --AUTORIZACIONREMOTA
    RecibirCorreoPerfil					varchar(50) NULL, --AUTORIZACIONREMOTA
    RecibirCorreoRutaComponentePOP		varchar(255) NULL, --AUTORIZACIONREMOTA

    InvVerificarEnConexion				bit		NOT NULL DEFAULT 1,  --11077
 --REQ12534 Factory      
    PlantaSucEmpresa					varchar(10) NULL, 
    RutaIntelisisMES					varchar(40) NULL, 
    MESISDBMailPerfil					varchar(50) NULL, 
    ServidorWEB 					varchar(50) NULL, 
        MESISDBMailAsunto				varchar(MAX)	NULL		DEFAULT 'Notificacion Intelisis Factory IS (ID/IntelisisServiceID/)',
	MESISDBMailMensaje				varchar(MAX)   NULL		DEFAULT 'Tipo Solicitud /SubReferencia/<BR> Estatus /Estatus/<BR>Error /IntelisisServiceOk/<BR>Referencia /IntelisisServiceOkRef/<BR>Fecha /FechaEstatus/<BR>Conversación /Conversacion/<BR>',    
    SubVersion							varchar(20) NULL,
    VersionCFDFlex						datetime	NULL,
	-- TASK1964
	WMSAuxiliar                         bit NULL,
    
	CONSTRAINT priVersion PRIMARY KEY CLUSTERED (Version)
)
GO





IF NOT EXISTS (SELECT * FROM Version)
  INSERT Version (Version, ID) VALUES (3000, 0)
GO
EXEC spDROP_TRIGGER 'tgVersion'
GO
IF NOT EXISTS(select * from syscampo where tabla = 'Version' and Campo = 'Sucursal')
  ALTER TABLE Version ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES
IF NOT EXISTS(select * from syscampo where tabla = 'Version' and Campo = 'ArtR')
  ALTER TABLE Version ADD ArtR datetime NULL
IF NOT EXISTS(select * from syscampo where tabla = 'Version' and Campo = 'UltimaCorrida')
  ALTER TABLE Version ADD UltimaCorrida datetime NULL
IF NOT EXISTS(select * from syscampo where tabla = 'Version' and Campo = 'UltimaEstacion')
  ALTER TABLE Version ADD UltimaEstacion int NULL DEFAULT 0 WITH VALUES
IF NOT EXISTS(select * from syscampo where tabla = 'Version' and Campo = 'Sincronizando')
  ALTER TABLE Version ADD Sincronizando bit NULL DEFAULT 0 WITH VALUES
GO
IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'Version' AND Campo = 'SincroContablidadMatriz') AND NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'Version' AND Campo = 'SincroContabilidadMatriz')
  EXEC ("sp_Rename 'Version.SincroContablidadMatriz', 'SincroContabilidadMatriz', 'COLUMN'")
GO
EXEC spALTER_TABLE 'Version', 'MantenimientoInicio', 'datetime NULL'
EXEC spALTER_TABLE 'Version', 'MantenimientoFin', 'datetime NULL'
EXEC spALTER_TABLE 'Version', 'UltimoResumenMov','datetime NULL'
EXEC spALTER_TABLE 'Version', 'UltimoResumenMovProyecto','datetime NULL'
EXEC spALTER_TABLE 'Version', 'UltimoResumenSaldo', 'datetime NULL'
EXEC spALTER_TABLE 'Version', 'IRP', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'MaxRespaldos', 'int NULL DEFAULT 7 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'TiempoUltimoRespaldo', 'int NULL'
EXEC spALTER_TABLE 'Version', 'CteR', 'datetime	NULL DEFAULT GETDATE() WITH VALUES'
EXEC spALTER_TABLE 'Version', 'AutoEjercicio', 'int NULL'
EXEC spALTER_TABLE 'Version', 'AutoPeriodo', 'int NULL'
EXEC spALTER_TABLE 'Version', 'PlanReferencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'PlanReferenciaModulo', 'varchar(5) NULL DEFAULT "VTAS" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'RedondeoMonetarios', 'int NULL DEFAULT 4 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ValidarSincroSemilla', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroContabilidadMatriz', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Peru', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'NomLimiteInferior2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Sincro', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookEstatusNuevo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'NombreCorreoEnLote', 'varchar(100) NULL DEFAULT "Sistema" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ContrasenaTamanoMinimo', 'int NULL'
EXEC spALTER_TABLE 'Version', 'ContrasenaRequiereAlfa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ContrasenaRequiereNumeros', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookMensajes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookCitas', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookTareas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookTareasSincronizar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'MovMover', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SituacionFinalAlRegresar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroXMLManual', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'DeshabilitarAyuda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'MaximizarVentanas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'OutlookActividadesSincronizar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SinAfectarComoPendiente', 'bit NULL DEFAULT 1 WITH VALUES'
GO

EXEC spRENAME_COLUMN 'Version', 'IntelisisVista', 'Logico1'
GO
UPDATE Version SET MantenimientoInicio = GETDATE()
GO
EXEC spALTER_TABLE 'Version', 'ContrasenaEncriptada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ModuloCentral', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ModuloCentralURL', 'varchar(255)	NULL'
GO
EXEC spRENAME_COLUMN 'Version', 'BaseDatos', 'Base'
GO
EXEC spALTER_TABLE 'Version', 'Base', 'varchar(5) NULL'
GO
EXEC ('ALTER TABLE Version ALTER COLUMN Base varchar(5) NULL')
GO
EXEC spALTER_TABLE 'Version', 'Desconectar', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Reconectar', 'varchar(20) NULL DEFAULT "Manual" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'EstaDesconectado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'FechaDesconexion', 'datetime NULL'
EXEC spALTER_TABLE 'Version', 'ReconexionFrecuencia', 'int NULL'
EXEC spALTER_TABLE 'Version', 'ReconexionUltimoIntento', 'datetime NULL'
EXEC spALTER_TABLE 'Version', 'ConservarColaProcesada', 'int NULL DEFAULT 24 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'TamanoLoteProcesarCola', 'int NULL DEFAULT 10 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Replica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'ConservarReplicaProcesada', 'int	NULL DEFAULT 24 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'TamanoLoteProcesarReplica', 'int	NULL DEFAULT 10 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroSSB', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroSSBMismaInstancia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroSBBOkConservar', 'int NULL DEFAULT 7 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroSSBModoManual', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'UsuarioWindows', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Version', 'PuertoSSB', 'int	NULL DEFAULT 4022 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroSSBRecibirRespaldoMatriz', 'bit NULL DEFAULT 0 WITH VALUES'
GO
DECLARE
  @Extras	varchar(255)

SELECT @Extras = 'varchar(100) NULL DEFAULT "C'+CHAR(58)+'\Intelisis\Certificados" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'RutaCertificados', @Extras
EXEC spALTER_TABLE 'Version', 'TRCL', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'IPDinamica', 'bit NULL DEFAULT 0 WITH VALUES'

SELECT @Extras = 'varchar(255) NULL DEFAULT "http'+CHAR(58)+'//www.whatismyip.org/" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'IPDinamicaURL', @Extras
EXEC spALTER_TABLE 'Version', 'IPDinamicaPrefijo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'IPDinamicaSufijo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'EncriptarContrasenas', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Version', 'RegHist', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'BloquearUsuariosInactivos', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'BloquearUsuariosInactivosDias', 'int NULL'
EXEC spALTER_TABLE 'Version', 'Impuesto2Info', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Impuesto3Info', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Impuesto2BaseImpuesto1', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'Retencion2BaseImpuesto1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'FK', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'FueraLinea', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'Version', 'SincroIS', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroISRecibirRespaldoMatriz', 'bit	NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Version', 'ISDiasResguardoSolicitud', 'int NULL DEFAULT 60 WITH VALUES'
GO
EXEC spALTER_TABLE 'Version', 'SincroISDBMailPerfil', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'SincroISDBMailAsunto', 'varchar(MAX) null DEFAULT "Notificacion Intelisis Sincro IS (ID/IntelisisServiceID/)"'
EXEC spALTER_TABLE 'Version', 'SincroISDBMailMensaje', 'varchar(MAX) null DEFAULT "Tipo Solicitud /SubReferencia/<BR> Estatus /Estatus/<BR>Error /IntelisisServiceOk/<BR>Referencia /IntelisisServiceOkRef/<BR>Fecha /FechaEstatus/<BR>Conversación /Conversacion/<BR>Identificador Registro /SincroGUID/<BR>Sucursal Origen /SucursalOrigen/<BR>Sucursal Destino /SucursalDestino/"'
GO

EXEC spAlter_Table 'Version', 'RecibirCorreoRuta', 'varchar(255) NULL' --AUTORIZACIONREMOTA
EXEC spAlter_Table 'Version', 'RecibirCorreoPerfil', 'varchar(50) NULL' --AUTORIZACIONREMOTA
EXEC spAlter_Table 'Version', 'RecibirCorreoRutaComponentePOP', 'varchar(255) NULL' --AUTORIZACIONREMOTA
GO

-- 9562
EXEC spALTER_TABLE 'Version', 'SincroISDropBox', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroISDropBoxRuta', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'DirectorioEmpaquetadorArchivos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'ISDropBoxDiasResguardoArchivos', 'int NULL DEFAULT 60 WITH VALUES'
GO

-- 11077
EXEC spALTER_TABLE 'Version', 'InvVerificarEnConexion', 'bit DEFAULT 0 WITH VALUES'
GO

 --REQ12534 Factory  
EXEC spAlter_Table 'Version', 'PlantaSucEmpresa',' varchar(10) NULL'
EXEC spAlter_Table 'Version', 'RutaIntelisisMES',' varchar(40) NULL'
EXEC spALTER_TABLE 'Version', 'MESISDBMailPerfil', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'MESISDBMailAsunto', 'varchar(MAX) null DEFAULT "Notificacion Intelisis Factory IS (ID/IntelisisServiceID/)"'
EXEC spALTER_TABLE 'Version', 'MESISDBMailMensaje', 'varchar(MAX) null DEFAULT "Tipo Solicitud /SubReferencia/<BR> Estatus /Estatus/<BR>Error /IntelisisServiceOk/<BR>Referencia /IntelisisServiceOkRef/<BR>Fecha /FechaEstatus/<BR>Conversación /Conversacion/<BR>"'
EXEC spALTER_TABLE 'Version', 'ServidorWEB', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Version', 'SubVersion', 'varchar(20) NULL'
GO
--18214
EXEC spALTER_TABLE 'Version', 'VersionCFDFlex','datetime NULL'
GO
--20444
EXEC spALTER_COLUMN 'Version', 'subversion', 'varchar(30) NULL'
GO

--REQ25014
EXEC spALTER_TABLE 'Version', 'ContabilidadParalela', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'CPCentralizadora', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'CPBaseLocal', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'CPBaseDatos', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'CPURL', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Version', 'CPUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Version', 'CPContrasena', 'varchar(32) NULL'
EXEC spALTER_TABLE 'Version', 'WMSAuxiliar', 'bit NULL DEFAULT 1' -- TASK1964
GO
UPDATE Version SET WMSAuxiliar = 1
GO
EXEC spALTER_TABLE 'Version', 'Preconfigurado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'Version', 'Sector', 'varchar(100) NULL' 
EXEC spALTER_TABLE 'Version', 'EsDemo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'PreConfAplicada', 'bit NULL DEFAULT 0 WITH VALUES'
GO
-- select * from version
IF (SELECT version from version) <=2200
  UPDATE Version SET CteR = DATEADD(ms, -DATEPART(ms, CteR), CteR)
GO
IF (SELECT version from version) <=2666
  UPDATE Version SET SincroContabilidadMatriz = 1
GO
--Campo para modificar la fecha de versión del CFDFlex 
DECLARE 
	@VersionCFDFlex datetime

	SET @VersionCFDFlex='04-09-2013' --BUG20116, BUG20204

UPDATE Version SET VersionCFDFlex = @VersionCFDFlex
GO

CREATE TRIGGER tgVersion ON Version
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Version	int,
    @Fecha	datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Version = Version, @Fecha = Fecha FROM Inserted
  IF NOT EXISTS(SELECT * FROM VersionLog WHERE Version = @Version)
    INSERT VersionLog (Version, Fecha) VALUES (@Version, @Fecha)
END
GO
/****** VersionLista  ******/
if not exists (select * from sysobjects where id = object_id('dbo.VersionLista') and type = 'U') 
CREATE TABLE dbo.VersionLista (
	Nombre			varchar(50) NOT NULL,
	Valor			varchar(255) NULL,
    Visible         bit NULL,
CONSTRAINT priVersionLista PRIMARY KEY CLUSTERED (Nombre)
)
GO
if not exists (select * from VersionLista where Nombre = 'ExportarExcelSegundoPlano') 
INSERT INTO VersionLista (Nombre, Valor, Visible) VALUES ('ExportarExcelSegundoPlano', 'Si', 1)
GO
/****** SysTabla ******/
IF exists (select * from sysobjects where id = object_id('dbo.SysTabla') and type = 'U') AND 
  (select version from version) <= 1256
  DROP TABLE dbo.SysTabla
GO
if not exists (select * from sysobjects where id = object_id('dbo.SysTabla') and type = 'U') 
CREATE TABLE dbo.SysTabla (
	SysTabla		varchar(50) 	NOT NULL,
	Descripcion		varchar(100)	NULL,
	Tipo			varchar(20)	NULL		DEFAULT 'N/A',	-- Cuenta, Maestro, Movimiento, N/A
	Modulo			varchar(5)	NULL,
	SincroActivo		bit		NOT NULL	DEFAULT 1,
	SincroOrden		int		NULL,
	UltimoCambio		datetime	NULL,
	SincroID		timestamp	NULL,

	Registros		int		NULL,
	RegistrosFecha		datetime	NULL,

	Hist			bit		NULL		DEFAULT 0,
	FueraLinea		bit		NULL		DEFAULT 0,

	CONSTRAINT priSysTabla PRIMARY KEY CLUSTERED (SysTabla)
)
GO
if not exists (select * from SysTabla where SysTabla = 'SysTabla') 
INSERT INTO SysTabla (SysTabla) VALUES ('SysTabla')
GO
IF NOT EXISTS(select * from syscampo where tabla = 'SysTabla' and Campo = 'Modulo')
  ALTER TABLE SysTabla ADD Modulo varchar(5) NULL
GO
EXEC spDROP_INDEX 'SysTabla', 'Sincro'
GO	
/*EXEC spDROP_INDEX 'SysTabla', 'TID'
EXEC spDROP_COLUMN 'SysTabla', 'TID'*/
GO	
EXEC spALTER_TABLE 'SysTabla', 'Registros', 'int NULL'
EXEC spALTER_TABLE 'SysTabla', 'RegistrosFecha', 'datetime NULL'
EXEC spALTER_TABLE 'SysTabla', 'Hist', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'SysTabla', 'SincroID', 'timestamp NULL'
EXEC spALTER_TABLE 'SysTabla', 'FueraLinea','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'SysTabla', 'CampoID', 'VARCHAR(50) NULL'
EXEC spALTER_TABLE 'SysTabla', 'Orden', 'INT NULL'
GO
EXEC spADD_INDEX 'SysTabla', 'Sincro', 'SincroID'
EXEC spADD_INDEX 'SysTabla', 'FueraLinea', 'FueraLinea'
GO	

/* Si se agrega una tabla nueva que tenga IDENTITY ha que correr el spSincroSemilla */


/****** FK ******/
if not exists (select * from SysTabla where SysTabla = 'FK') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FK','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.FK') and type = 'U') 
BEGIN
  CREATE TABLE dbo.FK (
	RID			int		identity(1,1)	NOT NULL,
	TablaOrigen		varchar(100)    NOT NULL,
	CampoOrigen		varchar(100)    NOT NULL,
	CampoOrigen2		varchar(100)    NOT NULL	DEFAULT '',		
	CampoOrigen3		varchar(100)    NOT NULL	DEFAULT '',			
	CampoOrigen4		varchar(100)    NOT NULL	DEFAULT '',				
	CampoOrigen5		varchar(100)    NOT NULL	DEFAULT '',						
	TablaDestino		varchar(100)    NOT NULL,
	CampoDestino		varchar(100)	NOT NULL,
	CampoDestino2		varchar(100)	NOT NULL	DEFAULT '',
	CampoDestino3		varchar(100)	NOT NULL	DEFAULT '',
	CampoDestino4		varchar(100)	NOT NULL	DEFAULT '',		
	CampoDestino5		varchar(100)	NOT NULL	DEFAULT '',		
	Eliminar		bit		NOT NULL	DEFAULT 0,
	
	CONSTRAINT priFK PRIMARY KEY CLUSTERED (RID) 
  )
END
GO

/**************** spFKInsertarRegistro ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFKInsertarRegistro') and type = 'P') drop procedure dbo.spFKInsertarRegistro
GO
CREATE PROCEDURE spFKInsertarRegistro
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @CampoOrigen4	varchar(100),
		   @CampoOrigen5	varchar(100),		   		   		   		   
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100),
		   @CampoDestino4	varchar(100),
		   @CampoDestino5	varchar(100),
		   @Eliminar		bit
WITH ENCRYPTION	  
AS BEGIN   
  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM FK WHERE TablaOrigen = @TablaOrigen AND CampoOrigen = ISNULL(@CampoOrigen,'') AND CampoOrigen2 = ISNULL(@CampoOrigen2,'') AND CampoOrigen3 = ISNULL(@CampoOrigen3,'') AND CampoOrigen4 = ISNULL(@CampoOrigen4,'') AND CampoOrigen5 = ISNULL(@CampoOrigen5,'') AND TablaDestino = @TablaDestino AND CampoDestino = ISNULL(@CampoDestino,'') AND CampoDestino2 = ISNULL(@CampoDestino2,'') AND CampoDestino3 = ISNULL(@CampoDestino3,'') AND CampoDestino4 = ISNULL(@CampoDestino4,'') AND CampoDestino5 = ISNULL(@CampoDestino5,'') AND Eliminar = @Eliminar) 	
    INSERT FK (TablaOrigen,  CampoOrigen,  CampoOrigen2,             CampoOrigen3,             CampoOrigen4,             CampoOrigen5,             TablaDestino,  CampoDestino,  CampoDestino2,             CampoDestino3,             CampoDestino4,             CampoDestino5,             Eliminar)
       VALUES (@TablaOrigen, @CampoOrigen, ISNULL(@CampoOrigen2,''), ISNULL(@CampoOrigen3,''), ISNULL(@CampoOrigen4,''), ISNULL(@CampoOrigen5,''), @TablaDestino, @CampoDestino, ISNULL(@CampoDestino2,''), ISNULL(@CampoDestino3,''), ISNULL(@CampoDestino4,''), ISNULL(@CampoDestino5,''), @Eliminar)	
   
END
GO

/**************** spFK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFK') and type = 'P') drop procedure dbo.spFK
GO
CREATE PROCEDURE spFK
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, NULL, NULL, NULL, NULL, @TablaDestino, @CampoDestino, NULL, NULL, NULL, NULL, 0
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen
    if not exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+') NOT FOR REPLICATION')
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spFK2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFK2') and type = 'P') drop procedure dbo.spFK2
GO
CREATE PROCEDURE spFK2
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, NULL, NULL, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, NULL, NULL, NULL, 0
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2
    if not exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+') NOT FOR REPLICATION')
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spFK3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFK3') and type = 'P') drop procedure dbo.spFK3
GO
CREATE PROCEDURE spFK3
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)
  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, NULL, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, NULL, NULL, 0
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3
    if not exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+') NOT FOR REPLICATION')
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spFK4 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFK4') and type = 'P') drop procedure dbo.spFK4
GO
CREATE PROCEDURE spFK4
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @CampoOrigen4	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100),
		   @CampoDestino4	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN
  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, NULL, 0
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4
    if not exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+', '+@CampoOrigen4+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+', '+@CampoDestino4+') NOT FOR REPLICATION')
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spFK5 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFK5') and type = 'P') drop procedure dbo.spFK5
GO
CREATE PROCEDURE spFK5
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @CampoOrigen4	varchar(100),
		   @CampoOrigen5	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100),
		   @CampoDestino4	varchar(100),
		   @CampoDestino5	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN
  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, @CampoOrigen5, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, @CampoDestino5, 0
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4+'_'+@CampoOrigen5
    if not exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+', '+@CampoOrigen4+', '+@CampoOrigen5+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+', '+@CampoDestino4+', '+@CampoDestino5+') NOT FOR REPLICATION')
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spDROP_FK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_FK') and type = 'P') drop procedure dbo.spDROP_FK
GO
CREATE PROCEDURE spDROP_FK
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, NULL, NULL, NULL, NULL, @TablaDestino, @CampoDestino, NULL, NULL, NULL, NULL, 1
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen
    if exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spDROP_FK2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_FK2') and type = 'P') drop procedure dbo.spDROP_FK2
GO
CREATE PROCEDURE spDROP_FK2
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, NULL, NULL, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, NULL, NULL, NULL, 1
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2
    if exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spDROP_FK3 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_FK3') and type = 'P') drop procedure dbo.spDROP_FK3
GO
CREATE PROCEDURE spDROP_FK3
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)
  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN


  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, NULL, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, NULL, NULL, 1
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3
    if exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spDROP_FK4 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_FK4') and type = 'P') drop procedure dbo.spDROP_FK4
GO
CREATE PROCEDURE spDROP_FK4
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @CampoOrigen4	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100),
		   @CampoDestino4	varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)
  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN


  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, NULL, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, NULL, 1
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4
    if exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spDROP_FK5 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_FK5') and type = 'P') drop procedure dbo.spDROP_FK5
GO
CREATE PROCEDURE spDROP_FK5
		   @TablaOrigen		varchar(100),
		   @CampoOrigen		varchar(100),
		   @CampoOrigen2	varchar(100),
		   @CampoOrigen3	varchar(100),
		   @CampoOrigen4	varchar(100),
		   @CampoOrigen5	varchar(100),
		   @TablaDestino	varchar(100),
		   @CampoDestino	varchar(100),
		   @CampoDestino2	varchar(100),
		   @CampoDestino3	varchar(100),
		   @CampoDestino4	varchar(100),
		   @CampoDestino5	varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FK	varchar(100)

  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  IF NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') OR NOT EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U')
    EXEC spFKInsertarRegistro @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, @CampoOrigen5, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, @CampoDestino5, 1
  ELSE
  BEGIN
    SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4+'_'+@CampoOrigen5
    if exists(select * from sysobjects where name = @FK and type = 'F')
    BEGIN
      EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
    END
  END
END
GO

/**************** spFKFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFKFinal') and type = 'P') drop procedure dbo.spFKFinal
GO
CREATE PROCEDURE spFKFinal
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TablaOrigen	varchar(100),
    @CampoOrigen	varchar(100),
    @CampoOrigen2	varchar(100),
    @CampoOrigen3	varchar(100),
    @CampoOrigen4	varchar(100),
    @CampoOrigen5	varchar(100),	
    @TablaDestino	varchar(100),
    @CampoDestino	varchar(100),
    @CampoDestino2	varchar(100),
    @CampoDestino3	varchar(100),
    @CampoDestino4	varchar(100),
    @CampoDestino5	varchar(100),
    @Eliminar		bit,
    @FK			varchar(100),
    @CantidadCampos	int
  
  IF (SELECT ISNULL(FK, 0) FROM Version) = 0 RETURN

  DECLARE crFK CURSOR FOR
   SELECT TablaOrigen, CampoOrigen, NULLIF(CampoOrigen2,''), NULLIF(CampoOrigen3,''), NULLIF(CampoOrigen4,''), NULLIF(CampoOrigen5,''), TablaDestino, NULLIF(CampoDestino,''), NULLIF(CampoDestino2,''), NULLIF(CampoDestino3,''), NULLIF(CampoDestino4,''), NULLIF(CampoDestino5,''), ISNULL(Eliminar,0)
     FROM FK

  OPEN crFK
  FETCH NEXT FROM crFK INTO @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, @CampoOrigen5, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, @CampoDestino5, @Eliminar
  WHILE @@FETCH_STATUS = 0 
  BEGIN

    IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') AND EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U') AND @Eliminar = 0
    BEGIN

      SET @CantidadCampos = CASE ISNULL(@CampoOrigen,'')  WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen2,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen3,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen4,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen5,'') WHEN '' THEN 0 ELSE 1 END

      IF @CantidadCampos = 1
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen
        if not exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+') NOT FOR REPLICATION')
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 2
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2
        if not exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+') NOT FOR REPLICATION')
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 3
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3
        if not exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+') NOT FOR REPLICATION')
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 4
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4
        if not exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+', '+@CampoOrigen4+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+', '+@CampoDestino4+') NOT FOR REPLICATION')
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 5
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4+'_'+@CampoOrigen5
        if not exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' WITH NOCHECK ADD CONSTRAINT '+@FK+' FOREIGN KEY ('+@CampoOrigen+', '+@CampoOrigen2+', '+@CampoOrigen3+', '+@CampoOrigen4+', '+@CampoOrigen5+') REFERENCES dbo.'+@TablaDestino+' ('+@CampoDestino+', '+@CampoDestino2+', '+@CampoDestino3+', '+@CampoDestino4+', '+@CampoDestino5+') NOT FOR REPLICATION')
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' NOCHECK CONSTRAINT '+@FK)
        END
      END
    END ELSE
    IF EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaOrigen))) and TYPE = 'U') AND EXISTS(SELECT * FROM sysobjects WHERE id = object_id('dbo.' + RTRIM(LTRIM(@TablaDestino))) and TYPE = 'U') AND @Eliminar = 1
    BEGIN

      SET @CantidadCampos = CASE ISNULL(@CampoOrigen,'')  WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen2,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen3,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen4,'') WHEN '' THEN 0 ELSE 1 END + CASE ISNULL(@CampoOrigen5,'') WHEN '' THEN 0 ELSE 1 END

      IF @CantidadCampos = 1
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen
        if exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 2
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2
        if exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 3
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3
        if exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 4
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4
        if exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
        END
      END ELSE
      IF @CantidadCampos = 5
      BEGIN
        SELECT @FK = 'FK_'+@TablaOrigen+'_'+@CampoOrigen+'_'+@CampoOrigen2+'_'+@CampoOrigen3+'_'+@CampoOrigen4+'_'+@CampoOrigen5
        if exists(select * from sysobjects where name = @FK and type = 'F')
        BEGIN
          EXEC('ALTER TABLE dbo.'+@TablaOrigen+' DROP CONSTRAINT '+@FK)
        END
      END
    END

    FETCH NEXT FROM crFK INTO @TablaOrigen, @CampoOrigen, @CampoOrigen2, @CampoOrigen3, @CampoOrigen4, @CampoOrigen5, @TablaDestino, @CampoDestino, @CampoDestino2, @CampoDestino3, @CampoDestino4, @CampoDestino5, @Eliminar
  END
  CLOSE crFK
  DEALLOCATE crFK 

  DELETE FROM FK

END
GO


-- drop table CfgModuloCentralAccion
/****** CfgModuloCentralAccion  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CfgModuloCentralAccion') and type = 'U') 
CREATE TABLE dbo.CfgModuloCentralAccion (
	Accion			varchar(50)		NOT NULL,

	Cache			varchar(20)		NULL,	-- No/Desconectado/por Omision
	Cola			varchar(20)		NULL,	-- No/Desconectado/por Omision
	
	CONSTRAINT priCfgModuloCentralAccion PRIMARY KEY CLUSTERED (Accion)
)
GO

-- drop table CfgModuloCentralReplica
/****** CfgModuloCentralReplica  ******/
if not exists (select * from sysobjects where id = object_id('dbo.CfgModuloCentralReplica') and type = 'U') 
CREATE TABLE dbo.CfgModuloCentralReplica (
	Tema			varchar(50)		NOT NULL,	-- Clientes, Proveedores, Personal, Agentes, Almacenes, Articulos, Precios, Configuracion

	Estatus			varchar(15)		NULL,
	Frecuencia		int			NULL,	-- minutos
	UltimaReplica		datetime		NULL,
		
	CONSTRAINT priCfgModuloCentralReplica PRIMARY KEY CLUSTERED (Tema)
)
GO
EXEC spALTER_TABLE 'CfgModuloCentralReplica', 'Estatus', 'varchar(15) NULL'
GO
-- drop table CfgModuloCentralReplicaTabla
/****** CfgModuloCentralReplicaTabla ******/
if not exists (select * from sysobjects where id = object_id('dbo.CfgModuloCentralReplicaTabla') and type = 'U') 
CREATE TABLE dbo.CfgModuloCentralReplicaTabla (
	Tema			varchar(50)		NOT NULL,
	Tabla			varchar(100)		NOT NULL,

	Campo			varchar(100)		NULL,
	Campo2			varchar(100)		NULL,
	Valor2			varchar(100)		NULL,
	Campo3			varchar(100)		NULL,
	Valor3			varchar(100)		NULL,
	Campo4			varchar(100)		NULL,
	Valor4			varchar(100)		NULL,
	Campo5			varchar(100)		NULL,
	Valor5			varchar(100)		NULL,
	Principal		bit			NULL	DEFAULT 0,

	CONSTRAINT priCfgModuloCentralReplicaTabla PRIMARY KEY CLUSTERED (Tema, Tabla)
)
GO

/*
Tipos de Tabla

N/A			No Viaja
Maestro			Unicamente se puede editar en la Matriz y Viajan a todas las sucursales nivel tabla (cambia un registro y viaja toda la tabla)
Cuenta			Permite Edicion en todos lados y se replica los cambios a nivel registro a todas la sucursales y la matriz
Movimiento		Es Editable o Cancelable en un solo lugar a la vez dependiendo del seguimiento Matriz, unicamente se replica Matriz-Sucursal captura a menos de que una sucursal asigne a otra sucursal, requiere campo sucursal, sucursalorigen y sucursaldestino
Saldo			Es parecido a la cuenta con la diferencia que incluye el campo sucursal y la sucursal unicamente envia los registros que se modificaron de la misma sucursal
MovimientoInfo		Es parecido al movimiento pero replica en todas las sucursales
SucursalInfoMatriz	Nunca sale de la matriz y siempre que cambia replica a la matriz
CuentaSucursal		Viaja de la Matriz a la Sucursal y unicamente la sucursal recibe lo que le corresponde
CuentaRegion		Viaja de la Matriz a la Region y unicamente la sucursal recibe lo que le corresponde
SaldoSucursal		Viaja de la Matriz a la Sucursal y unicamente la sucursal recibe lo que le corresponde
SaldoRegion		Viaja de la Matriz a la Region y unicamente la sucursal recibe lo que le corresponde
*/



/****** SysTablaReg ******/
if not exists (select * from sysobjects where id = object_id('dbo.SysTablaReg') and type = 'U') 
CREATE TABLE dbo.SysTablaReg (
	SysTabla		varchar(50) 	NOT NULL,

	Registros		int		NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priSysTablaReg PRIMARY KEY CLUSTERED (SysTabla)
)
GO

/**************** spCampoIdentity ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCampoIdentity') and type = 'P') drop procedure dbo.spCampoIdentity
GO             
CREATE PROCEDURE spCampoIdentity
			@Tabla		varchar(100),
			@Campo		varchar(100) OUTPUT
				
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Campo = NULL
  SELECT @Campo = Campo FROM SysCampo WHERE Tabla = @Tabla AND COLUMNPROPERTY(OBJECT_ID(@Tabla), campo, 'IsIdentity') = 1
END
GO

/**************** spSincroSemillaOk ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSemillaOk') and type = 'P') drop procedure dbo.spSincroSemillaOk
GO             
CREATE PROCEDURE spSincroSemillaOk
			@Modulo	varchar(5),
			@ID	int,
			@Mov	varchar(20),
			@Ok	int		OUTPUT,
			@OkRef	varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Del			int,
    @Al				int,
    @SucursalPrincipal		int, 
    @ValidarSincroSemilla	bit,
    @Seguimiento		varchar(20),
    @OrigenTipo			varchar(10)

  SELECT @ValidarSincroSemilla = ValidarSincroSemilla, @SucursalPrincipal = Sucursal FROM Version 
  IF @ValidarSincroSemilla = 1 
  BEGIN
    IF @SucursalPrincipal = 0 SELECT @Del = 0 ELSE SELECT @Del = 40000000 + (@SucursalPrincipal * 7000000)
    SELECT @Al = 40000000 + (( @SucursalPrincipal + 1) * 7000000)
    IF NOT (@ID BETWEEN @Del AND @Al-1)
    BEGIN
      EXEC spSucursalMovSeguimiento @SucursalPrincipal, @Modulo, @Mov, @Seguimiento OUTPUT
      IF NOT (@Seguimiento = 'MATRIZ' AND @SucursalPrincipal = 0)
      BEGIN
        EXEC spMovInfo @ID, @Modulo, @OrigenTipo = @OrigenTipo OUTPUT
        IF @OrigenTipo <> 'E/COLLAB'
          SELECT @Ok = 72070, @OkRef = CONVERT(varchar, @ID)
      END
    END
  END
END
GO

/**************** spSincroActualizarSemillaCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroActualizarSemillaCampo') and type = 'P') drop procedure dbo.spSincroActualizarSemillaCampo
GO             
CREATE PROCEDURE spSincroActualizarSemillaCampo
			@Tabla		varchar(100),
			@CampoID	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  EXEC("
  DECLARE 
    @ID 	int, 
    @Sucursal 	int, 
    @De 	int, 
    @A 		int

  -- Si Cambian estos valores hay que cambiar TApp.SincroSemillaOk en el SDK
  SELECT @Sucursal = Sucursal FROM Version
  IF @Sucursal = 0 SELECT @De = 1 ELSE SELECT @De = 40000000 + (@Sucursal * 7000000)
  SELECT @A  = (40000000 + ((@Sucursal + 1) * 7000000)) - 1
  SELECT @ID = MAX(" + @CampoID + ") FROM " + @Tabla + " WHERE " + @CampoID + " BETWEEN @De AND @A
  IF @ID IS NULL SELECT @ID = @De
  DBCC CHECKIDENT ('"+@Tabla+"', RESEED, @ID)")

  RETURN
END
GO


/**************** spSincroActualizarSemilla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroActualizarSemilla') and type = 'P') drop procedure dbo.spSincroActualizarSemilla
GO             
CREATE PROCEDURE spSincroActualizarSemilla
			@Tabla		varchar(100)
				
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Campo	varchar(50)
  EXEC spCampoIdentity @Tabla, @Campo OUTPUT

  IF @Campo IS NOT NULL
    EXEC spSincroActualizarSemillaCampo @Tabla, @Campo
  RETURN
END
GO

/**************** spSincroSemilla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroSemilla') and type = 'P') drop procedure dbo.spSincroSemilla
GO             
CREATE PROCEDURE spSincroSemilla
			@Tabla		varchar(100)	= NULL,
			@Sucursal	int		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Semilla	int

  IF @Sucursal IS NULL 
    SELECT @Sucursal = Sucursal 
      FROM Version

-- 2,147,483,648
-- 2,147,000,000
-- 7,000,000 x 300 = 2,100,000,000 + 47,000,000 

  IF @Sucursal > 300 RETURN
  IF @Sucursal > 0 
    SELECT @Semilla = 40000000 + (@Sucursal*7000000)
  ELSE SELECT @Semilla = 1

  IF @Tabla IS NOT NULL
  BEGIN  
    IF IDENT_INCR(@Tabla) IS NOT NULL AND @Semilla > 1
      DBCC CHECKIDENT (@Tabla, RESEED, @Semilla)
  END ELSE 
  BEGIN  
    DECLARE crTabla CURSOR FOR
     SELECT TABLE_NAME
       FROM INFORMATION_SCHEMA.TABLES
      WHERE IDENT_INCR(TABLE_NAME) IS NOT NULL AND TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME not like 'sys%' AND TABLE_NAME not in ('Sincro', 'dtproperties')
    OPEN crTabla
    FETCH NEXT FROM crTabla INTO @Tabla
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
        DBCC CHECKIDENT (@Tabla, RESEED, @Semilla)
      FETCH NEXT FROM crTabla INTO @Tabla
    END
    CLOSE crTabla
    DEALLOCATE crTabla

    UPDATE Version SET Sucursal = @Sucursal
  END
END 
GO

/**************** spSincroNivelTabla ****************/
-- Replicar en Version Abierta y SincroXML
if exists (select * from sysobjects where id = object_id('dbo.spSincroNivelTabla') and type = 'P') drop procedure dbo.spSincroNivelTabla
GO             
CREATE PROCEDURE spSincroNivelTabla
			@CrearTrigger	bit = 1,
			@TodasTablas	bit = 0
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON 
  DECLARE
    @Tabla		varchar(50)

  IF (SELECT SincroSSB FROM Version) = 1 RETURN
  IF @CrearTrigger = 1 SELECT @CrearTrigger = Sincro FROM Version
  DECLARE crTabla CURSOR FOR
   SELECT RTRIM(s.SysTabla)
     FROM SysTabla s
     JOIN INFORMATION_SCHEMA.TABLES t ON t.TABLE_TYPE = 'BASE TABLE' AND t.TABLE_NAME = s.SysTabla
    WHERE (@TodasTablas = 0 AND UPPER(s.Tipo) = 'MAESTRO') OR (@TodasTablas = 1 AND UPPER(s.Tipo) <> 'N/A')
  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN    
      EXEC("if exists (select * from sysobjects where id = object_id('sincro"+@Tabla+"') and sysstat & 0xf = 8) drop trigger sincro"+@Tabla)
      EXEC("if exists (select * from sysobjects where id = object_id('sincroT"+@Tabla+"') and sysstat & 0xf = 8) drop trigger sincroT"+@Tabla)
      IF @CrearTrigger = 1
        EXEC("CREATE TRIGGER sincroT"+@Tabla+" ON "+@Tabla+" WITH ENCRYPTION FOR INSERT, UPDATE, DELETE AS BEGIN   IF dbo.fnEstaSincronizando() = 1 RETURN  UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '"+@Tabla+"' END")
    END
    FETCH NEXT FROM crTabla INTO @Tabla
  END
  CLOSE crTabla
  DEALLOCATE crTabla
END 
GO

/**************** spSincroLlave ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroLlave') and type = 'P') drop procedure dbo.spSincroLlave
GO             
CREATE PROCEDURE spSincroLlave
			@Tabla		varchar(100),
			@Separador	varchar(10),
			@Llave		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo	varchar(50)

  SELECT @Llave = ''
  DECLARE crLlave CURSOR FOR
    SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = @Tabla AND CONSTRAINT_NAME LIKE 'p%'
  OPEN crLlave
  FETCH NEXT FROM crLlave INTO @Campo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Llave <> '' SELECT @Llave = @Llave +' '+RTRIM(@Separador)+' '
      SELECT @Llave = @Llave + 't.'+RTRIM(@Campo)+' = i.'+RTRIM(@Campo)
    END
    FETCH NEXT FROM crLlave INTO @Campo
  END
  CLOSE crLlave
  DEALLOCATE crLlave
  IF @Llave = '' 
  BEGIN
    IF @Tabla IN ('Empresa', 'EmpresaCfg', 'EmpresaCfg2', 'EmpresaCfgMov', 'EmpresaGral') SELECT @Llave = 't.Empresa = i.Empresa' ELSE
    IF @Tabla = 'UsuarioCfg2' 	SELECT @Llave = 't.Usuario = i.Usuario' ELSE
    IF @Tabla = 'Art' 		SELECT @Llave = 't.Articulo = i.Articulo' ELSE
    IF @Tabla = 'Inv'           SELECT @Llave = 't.ID = i.ID' ELSE
    IF @Tabla = 'InvD'          SELECT @Llave = 't.ID = i.ID AND t.Renglon = i.Renglon AND t.RenglonSub = i.RenglonSub' ELSE
    IF @Tabla = 'CRVenta'       SELECT @Llave = 't.ID = i.ID AND t.Renglon = i.Renglon' ELSE
    IF @Tabla = 'AnexoCta'      SELECT @Llave = 't.Rama = i.Rama AND t.Cuenta = i.Cuenta AND t.IDR = i.IDR'
  END
  RETURN
END 
GO

/* 
DECLARE @Llave varchar(255)
EXEC spSincroLlave 'Mov', 'AND', @Llave OUTPUT
SELECT @Llave

    SELECT COLUMN_NAME,* FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'Compra' and CONSTRAINT_NAME LIKE 'p%'

*/

/**************** spSincroNivelRegistroCampos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroNivelRegistroCampos') and type = 'P') drop procedure dbo.spSincroNivelRegistroCampos
GO             
CREATE PROCEDURE spSincroNivelRegistroCampos
		    @Tabla	varchar(50)
WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON 
  EXEC("IF not exists (select * from syscampo WHERE tabla = '"+@Tabla+"' AND campo = 'SincroID') ALTER TABLE "+@Tabla+" ADD SincroID timestamp NULL")
  EXEC("IF not exists (select * from syscampo WHERE tabla = '"+@Tabla+"' AND campo = 'SincroC')  ALTER TABLE "+@Tabla+" ADD SincroC  int NULL DEFAULT 1 WITH VALUES")
END 
GO


-- EXEC spSincroNivelRegistro @Tabla = 'Usuario', @VerTabla = 1
-- spSincroNivelRegistro @Tabla = 'SincroPaquete'
-- EXEC spDROP_COLUMN 'Cte', 'SincroID'
-- spSincroNivelRegistro @tabla='ActivoF'
-- SELECT ISNULL(Sincro, 0) FROM Version
-- spSincroNivelRegistro @VerTabla = 1
/**************** spSincroNivelRegistro ****************/
-- Replicar en Version Abierta y SincroXML
if exists (select * from sysobjects where id = object_id('dbo.spSincroNivelRegistro') and type = 'P') drop procedure dbo.spSincroNivelRegistro
GO             
CREATE PROCEDURE spSincroNivelRegistro
			@CrearTrigger	bit = 1,
			@VerTabla	bit = 0,
			@Tabla		varchar(50) = NULL
WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON 
  DECLARE
    @Llave 	varchar(255)

  IF (SELECT SincroSSB FROM Version) = 1 OR (SELECT ModuloCentral FROM Version) = 1 RETURN

  IF @CrearTrigger = 1 SELECT @CrearTrigger = Sincro FROM Version
  DECLARE crTabla CURSOR FOR
   SELECT RTRIM(s.SysTabla)
     FROM SysTabla s, INFORMATION_SCHEMA.TABLES t
    WHERE (UPPER(s.Tipo) LIKE 'CUENTA%' OR UPPER(s.Tipo) LIKE 'MOVIMIENTO%' OR UPPER(s.Tipo) LIKE 'SALDO%') 
      AND t.TABLE_TYPE = 'BASE TABLE' AND t.TABLE_NAME = s.SysTabla
      AND s.SysTabla = ISNULL(@Tabla, s.SysTabla)
  OPEN crTabla
  FETCH NEXT FROM crTabla INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN    
      EXEC spSincroNivelRegistroCampos @Tabla
      EXEC("if exists (select * from sysobjects where id = object_id('sincro"+@Tabla+"') and sysstat & 0xf = 8) drop trigger sincro"+@Tabla)
      EXEC("if exists (select * from sysobjects where id = object_id('sincroR"+@Tabla+"') and sysstat & 0xf = 8) drop trigger sincroR"+@Tabla)
      --IF @CrearTrigger = 1 
      --BEGIN
      --  EXEC spSincroLlave @Tabla, 'AND', @Llave OUTPUT
      --  IF @VerTabla = 1 SELECT @Tabla, @Llave
      --  IF NULLIF(RTRIM(@Llave), '') IS NOT NULL
      --    EXEC("CREATE TRIGGER sincroR"+@Tabla+" ON "+@Tabla+" WITH ENCRYPTION FOR INSERT, UPDATE AS BEGIN   IF dbo.fnEstaSincronizando() = 1 RETURN IF NOT UPDATE(SincroC) UPDATE "+@Tabla+" SET SincroC = 1 FROM "+@Tabla+" t, Inserted i WHERE ISNULL(t.SincroC, 0) <> 1 AND "+@Llave+" END")
      --END
      --IF @Tabla NOT LIKE 'EmpresaCfg%'
      --  EXEC spADD_INDEX @Tabla, 'Sincro', 'SincroID, SincroC'
    END
    FETCH NEXT FROM crTabla INTO @Tabla
  END
  CLOSE crTabla
  DEALLOCATE crTabla
END 
GO
-- --//WITH ENCRYPTION
-- IF (SELECT MovMover FROM Version) = 1 RETURN 
-- EXEC spSincroNivelRegistro 1, 1


/**************** spExtraerFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spExtraerFecha') and type = 'P') drop procedure dbo.spExtraerFecha
GO             
CREATE PROCEDURE spExtraerFecha @Fecha	datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  SELECT @Fecha = DATEADD(ms, -DATEPART(ms, @Fecha), DATEADD(ss, -DATEPART(ss, @Fecha), DATEADD(mi, -DATEPART(mi, @Fecha), DATEADD(hh, -DATEPART(hh, @Fecha), @Fecha))))
  RETURN
END
GO

/**************** spEliminarPK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEliminarPK') and type = 'P') drop procedure dbo.spEliminarPK
GO
CREATE PROCEDURE spEliminarPK
		   @Tabla 	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @pk varchar(256)

  SELECT @pk = pk FROM SysPK WHERE Tabla = @Tabla
  IF @pk IS NOT NULL
    EXEC('ALTER TABLE '+@Tabla+' DROP CONSTRAINT '+@pk)
END
GO

/**************** spDROP_PK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spDROP_PK') and type = 'P') drop procedure dbo.spDROP_PK
GO
CREATE PROCEDURE spDROP_PK
		   @Tabla 	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  EXEC spEliminarPK @Tabla
END
GO

/**************** spADD_PK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spADD_PK') and type = 'P') drop procedure dbo.spADD_PK
GO
CREATE PROCEDURE spADD_PK
		   @Tabla 	varchar(100),
		   @PK		varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT pri'+@Tabla+' PRIMARY KEY CLUSTERED ('+@PK+')')
END
GO

/**************** spALTER_PK ****************/
if exists (select * from sysobjects where id = object_id('dbo.spALTER_PK') and type = 'P') drop procedure dbo.spALTER_PK
GO
CREATE PROCEDURE spALTER_PK
		   @Tabla 	varchar(100),
		   @PK		varchar(255),
		   @Version	int	 = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF @Version IS NOT NULL
    IF (select version from version)>@Version 
      RETURN

  EXEC spDROP_PK @Tabla
  EXEC spADD_PK @Tabla, @PK
END
GO



/**************** spModificarPK_Mov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarPK_Mov') and type = 'P') drop procedure dbo.spModificarPK_Mov
GO
CREATE PROCEDURE spModificarPK_Mov
		   @Tabla 	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'Sucursal')
    EXEC('ALTER TABLE '+@Tabla+' ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES')
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'SucursalOrigen')
    EXEC('ALTER TABLE '+@Tabla+' ADD SucursalOrigen int NOT NULL DEFAULT 0 WITH VALUES')
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'SucursalDestino')
    EXEC('ALTER TABLE '+@Tabla+' ADD SucursalDestino int NULL')

  if (select version from version) BETWEEN 1100 AND 1107
  BEGIN
    EXEC spEliminarPK @Tabla
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT pri'+@Tabla+' PRIMARY KEY CLUSTERED (ID)')
  END
END
GO

/**************** spModificarPK_Sucursal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarPK_Sucursal') and type = 'P') drop procedure dbo.spModificarPK_Sucursal
GO
CREATE PROCEDURE spModificarPK_Sucursal
		   @Tabla 	varchar(100),
		   @Llave	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'Sucursal')
    EXEC('ALTER TABLE '+@Tabla+' ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES')
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'SucursalOrigen')
    EXEC('ALTER TABLE '+@Tabla+' ADD SucursalOrigen int NOT NULL DEFAULT 0 WITH VALUES')

  if (select version from version) BETWEEN 1100 AND 1107
  BEGIN
    EXEC spEliminarPK @Tabla
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT pri'+@Tabla+' PRIMARY KEY CLUSTERED '+@Llave)
  END
END
GO

/**************** spModificarPK_SucursalSinOrigen ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarPK_SucursalSinOrigen') and type = 'P') drop procedure dbo.spModificarPK_SucursalSinOrigen
GO
CREATE PROCEDURE spModificarPK_SucursalSinOrigen
		   @Tabla 	varchar(100),
		   @Llave	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'Sucursal')
    EXEC('ALTER TABLE '+@Tabla+' ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES')

  if (select version from version) BETWEEN 1100 AND 1107
  BEGIN
    EXEC spEliminarPK @Tabla
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT pri'+@Tabla+' PRIMARY KEY '+@Llave)
  END
END
GO


/**************** spModificarPK_AcumSaldo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spModificarPK_AcumSaldo') and type = 'P') drop procedure dbo.spModificarPK_AcumSaldo
GO
CREATE PROCEDURE spModificarPK_AcumSaldo
		   @Tabla 	varchar(100),
		   @Llave	varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT exists(select * from SysCampo WHERE Tabla = @Tabla AND Campo = 'Sucursal')
  BEGIN
    EXEC spEliminarPK @Tabla
    EXEC('ALTER TABLE '+@Tabla+' ADD Sucursal int NOT NULL DEFAULT 0 WITH VALUES')
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT pri'+@Tabla+' PRIMARY KEY '+@Llave)
  END
END
GO

/**************** fnRedondeoMonetarios ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRedondeoMonetarios' AND type = 'FN') DROP FUNCTION fnRedondeoMonetarios
GO
CREATE FUNCTION fnRedondeoMonetarios()
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SELECT MIN(RedondeoMonetarios) FROM Version)
END
GO

/************** spMovAlActualizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spMovAlActualizar') and type = 'P') drop procedure dbo.spMovAlActualizar
GO
CREATE PROCEDURE spMovAlActualizar
                   @Modulo		varchar(5),
		   @ID			int,
		   @Mov			varchar(20),
		   @EstatusNuevo	varchar(15),
		   @EstatusAnterior	varchar(15), 
		   @SituacionNueva	varchar(50), 
		   @SituacionAnterior	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  RETURN 
END
GO

/**************** spMovAlEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMovAlEliminar') and type = 'P') drop procedure dbo.spMovAlEliminar
GO             
CREATE PROCEDURE spMovAlEliminar
                    @Modulo	varchar(5),
		    @ID		int

--//WITH ENCRYPTION
AS BEGIN

  RETURN
END
GO

-- select * from CfgModuloCentralReplicaTabla
/************** spReplicaTema *************/
if exists (select * from sysobjects where id = object_id('dbo.spReplicaTema') and type = 'P') drop procedure dbo.spReplicaTema
GO
CREATE PROCEDURE spReplicaTema
			@Tema		varchar(50),
			@Tabla		varchar(100),
			@Campo		varchar(100),
			@Campo2		varchar(100) = NULL,
			@Valor2		varchar(100) = NULL,
			@Campo3		varchar(100) = NULL,
			@Valor3		varchar(100) = NULL,
			@Campo4		varchar(100) = NULL,
			@Valor4		varchar(100) = NULL,
			@Campo5		varchar(100) = NULL,
			@Valor5		varchar(100) = NULL,
			@Principal	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL	varchar(8000),
    @WHERE	varchar(8000),
    @Trigger	varchar(255)

  IF (SELECT ModuloCentral FROM Version) = 0 RETURN 
  SELECT @Campo2 = NULLIF(RTRIM(@Campo2), ''), @Valor2 = NULLIF(RTRIM(@Valor2), ''),
         @Campo3 = NULLIF(RTRIM(@Campo3), ''), @Valor3 = NULLIF(RTRIM(@Valor3), ''),
         @Campo4 = NULLIF(RTRIM(@Campo4), ''), @Valor4 = NULLIF(RTRIM(@Valor4), ''),
         @Campo5 = NULLIF(RTRIM(@Campo5), ''), @Valor5 = NULLIF(RTRIM(@Valor5), '')

  IF @Principal = 1 DELETE CfgModuloCentralReplicaTabla WHERE Tema = @Tema
  INSERT CfgModuloCentralReplicaTabla (
          Tema,  Tabla,  Principal,  Campo,  Campo2,  Valor2,  Campo3,  Valor3,  Campo4,  Valor4,  Campo5,  Valor5) 
  VALUES (@Tema, @Tabla, @Principal, @Campo, @Campo2, @Valor2, @Campo3, @Valor3, @Campo4, @Valor4, @Campo5, @Valor5)

  SELECT @Trigger = 'dbo.tg'+@Tabla+'Replica'+@Tema
  SELECT @WHERE = ''
  IF @Campo2 IS NOT NULL SELECT @WHERE = 'WHERE ' + @Campo2 + '=' + @Valor2
  IF @Campo3 IS NOT NULL SELECT @WHERE = @WHERE + ' AND ' + @Campo3 + '=' + @Valor3
  IF @Campo4 IS NOT NULL SELECT @WHERE = @WHERE + ' AND ' + @Campo4 + '=' + @Valor4
  IF @Campo5 IS NOT NULL SELECT @WHERE = @WHERE + ' AND ' + @Campo5 + '=' + @Valor5

  --BUG16479
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+''''
  EXEC (@SQL)

  SELECT @SQL = 
    'CREATE TRIGGER '+@Trigger+' ON '+@Tabla+'
    --//WITH ENCRYPTION
    FOR INSERT, UPDATE, DELETE
    AS BEGIN
      DECLARE
         @Llave varchar(255)
      
      IF dbo.fnEstaSincronizando() = 1 RETURN         
      
      IF (SELECT Replica FROM Version) = 1 AND EXISTS(SELECT * FROM CfgModuloCentralReplica WHERE Tema = "'+@Tema+'" AND Estatus="ACTIVO") 
      BEGIN
        SELECT @Llave = '+@Campo+' FROM INSERTED '+@WHERE+'
        IF @@ROWCOUNT = 0
          SELECT @Llave = '+@Campo+' FROM DELETED '+@WHERE+'

        IF NOT EXISTS(SELECT * FROM mcReplicaSalida WHERE Tema="'+@Tema+'" AND Llave=@Llave AND Estatus="SINPROCESAR")
        BEGIN
          INSERT mcReplicaSalida (Tema, Llave, Estatus,EstatusFecha) VALUES ("'+@Tema+'", @Llave, "SINPROCESAR", GETDATE())
        END
      END
    END'
  EXEC (@SQL)
  RETURN
END
GO

EXEC spDROP_TABLE 'Fiscal', 3069
EXEC spDROP_TABLE 'FiscalD', 3069
EXEC spDROP_TABLE 'FiscalC', 3069
GO

/**************** fnMD5 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMD5') DROP FUNCTION fnMD5
GO
/*CREATE FUNCTION dbo.fnMD5 (@data TEXT) 
RETURNS CHAR(32) AS
BEGIN
  DECLARE @hash CHAR(32)
  EXEC master.dbo.xp_md5 @data, -1, @hash OUTPUT
  RETURN @hash
END*/
GO

/**************** fnMD5x ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMD5x') DROP FUNCTION fnMD5x
GO
/*CREATE FUNCTION dbo.fnMD5x (@data IMAGE, @len INT = -1) 
RETURNS CHAR(32) AS
BEGIN
  DECLARE @hash CHAR(32)
  EXEC master.dbo.xp_md5 @data, @len, @hash OUTPUT
  RETURN @hash
END*/
GO

-- select Campo, Orden FROM dbo.fnTablaPK('Mov')
/**************** fnTablaPK ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTablaPK') DROP FUNCTION fnTablaPK
GO
CREATE FUNCTION fnTablaPK (@Tabla varchar(100))
RETURNS @Resultado TABLE (Campo varchar(100), Orden int)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @PK		varchar(256)

  SELECT @PK = PK FROM SysPK WHERE Tabla = @Tabla
  INSERT @Resultado (Campo, Orden) 
  SELECT COLUMN_NAME, ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
   WHERE TABLE_NAME = @Tabla AND CONSTRAINT_NAME = @PK
   ORDER BY ORDINAL_POSITION
  RETURN 
END
GO


-- select dbo.fnTablaPKSt('Acum')
/**************** fnTablaPKSt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTablaPKSt') DROP FUNCTION fnTablaPKSt
GO
CREATE FUNCTION fnTablaPKSt (@Tabla varchar(100))
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Campo	varchar(100), 
    @Resultado  varchar(255)

  SELECT @Resultado = ''

  DECLARE crTablaPK CURSOR LOCAL FOR 
   SELECT Campo
     FROM dbo.fnTablaPK(@Tabla)
    ORDER BY Orden
  OPEN crTablaPK
  FETCH NEXT FROM crTablaPK INTO @Campo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Campo IS NOT NULL
    BEGIN
      IF @Resultado <> '' SELECT @Resultado = @Resultado + ', '
      SELECT @Resultado = @Resultado + @Campo
    END
    FETCH NEXT FROM crTablaPK INTO @Campo
  END  -- While
  CLOSE crTablaPK
  DEALLOCATE crTablaPK

  RETURN(@Resultado)
END
GO

-- select dbo.fnConcatenar('', '2', ', ')
/**************************** fnConcatenar ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnConcatenar') and type in ('fn','tf')) drop function dbo.fnConcatenar
GO
CREATE FUNCTION fnConcatenar (@Valor varchar(max), @Agregar varchar(max), @Separador varchar(20))
RETURNS varchar(max)
AS BEGIN		
  DECLARE
    @Resultado	varchar(max)

  SELECT @Valor = ISNULL(@Valor, '')
  IF @Valor <> '' SELECT @Valor = @Valor + @Separador
  RETURN (@Valor + @Agregar)
END
GO


/**************** spEncriptarContrasenas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spEncriptarContrasenas') and type = 'P') drop procedure dbo.spEncriptarContrasenas
GO             
CREATE PROCEDURE spEncriptarContrasenas
			@Activo	bit
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Version SET EncriptarContrasenas = @Activo
END
GO

/*
DECLARE 
  @JOIN varchar(max)
EXEC spTablaEstructura 'VentaD', @JOIN = @JOIN OUTPUT, @JOIN_Tabla1 = 'VentaD', @JOIN_Tabla2 = 'Art', @PK = 1
SELECT @JOIN


select CONVERT(varchar(max), ID)+"|"+CONVERT(varchar(max), Renglon)+"|"+CONVERT(varchar(max), RenglonSub)
from VentaD

declare
  @select varchar(max)
EXEC spTablaEstructura 'Art',  @SELECT = @SELECT OUTPUT, @PK = 1
select @select
*/

--EXEC spSincroNivelTabla 0
GO
--EXEC spSincroNivelRegistro 0
GO



/****** MensajeLista ******/
if not exists (select * from SysTabla where SysTabla = 'MensajeLista') 
INSERT INTO SysTabla (SysTabla) VALUES ('MensajeLista')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeLista') and type = 'U') 
CREATE TABLE dbo.MensajeLista (
	Mensaje			int		NOT NULL,
	Descripcion		varchar(255)	NULL,
	Tipo			varchar(50)	NULL DEFAULT 'ERROR',

	IE			bit		NULL DEFAULT 0,

	CONSTRAINT priMensajeLista PRIMARY KEY  CLUSTERED (Mensaje)
)
GO
EXEC spALTER_TABLE 'MensajeLista', 'IE', 'bit NULL DEFAULT 0 WITH VALUES'
GO

-- spOk_RAISERROR 1, ''
/**************** spOk_RAISERROR **************/
if exists (select * from sysobjects where id = object_id('dbo.spOk_RAISERROR') and type = 'P') drop procedure dbo.spOk_RAISERROR
GO
CREATE PROCEDURE spOk_RAISERROR
			@Ok	int,
			@OkRef	varchar(255)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Mensaje	varchar(255)

  IF @Ok NOT IN (NULL, 80030)
  BEGIN
    SELECT @Mensaje = RTRIM(ISNULL(Descripcion, ''))+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END
END
GO


/**************** spBorra_Constraint ****************/
if exists (select * from sysobjects where id = object_id('spDrop_Constraint') and type = 'P') 
	drop procedure dbo.spDrop_Constraint
GO
CREATE PROCEDURE spDrop_Constraint
		   @Tabla 	varchar(50),
		   @Campo	varchar(50)
--//WITH ENCRYPTION	   
AS BEGIN
  DECLARE
        @ConstraintID           int,
        @ConstraintName         varchar(250)
  
  IF EXISTS(SELECT * FROM sys.columns 
              JOIN sys.objects ON sys.columns.object_id = sys.objects.object_id
             WHERE sys.objects.name = @Tabla
               AND sys.columns.name = @Campo
               AND default_object_id <> 0)
 
  BEGIN 
    SELECT @ConstraintID = default_Object_id 
      FROM sys.columns 
      JOIN sys.objects ON sys.columns.object_id = sys.objects.object_id
     WHERE sys.objects.name = @Tabla
       AND sys.columns.name = @Campo
 
    SELECT @ConstraintName = Name FROM sys.objects WHERE object_id = @ConstraintID

    EXEC('ALTER TABLE '+ @Tabla +' DROP CONSTRAINT '+ @ConstraintName)      
  END

  RETURN
END
GO

/****************************** spTablaEstructura ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaEstructura') and type = 'p') drop procedure dbo.spTablaEstructura
GO
CREATE PROCEDURE spTablaEstructura
			@Tabla			varchar(255),

			@SELECT				varchar(max)	= NULL OUTPUT,
			@TABLE				varchar(max)	= NULL OUTPUT,
			@DECALRE			varchar(max)	= NULL OUTPUT,
			@SET				varchar(max)	= NULL OUTPUT,
			@PARAMS				varchar(max)	= NULL OUTPUT,
			@WITH				varchar(max)	= NULL OUTPUT,
			@JOIN				varchar(max)	= NULL OUTPUT,
--			@PIPES				varchar(max)	= NULL OUTPUT,
			@VALUES				varchar(max)	= NULL OUTPUT,
			@CampoIdentity		varchar(100)	= NULL OUTPUT,
			@ExcluirTimeStamp	bit = 0,
			@ExcluirCalculados	bit = 0,
			@ExcluirBLOBs		bit = 0,
			@ExcluirImage		bit = 0,
			@ExcluirIdentity	bit = 0,
			@ASCampo			bit = 0,
			@PK					bit = 0,
			@Prefijo			varchar(100)	= NULL,
			@Sufijo				varchar(100)	= NULL,
			@JOIN_Tabla1		varchar(100)	= NULL,
			@JOIN_Tabla2		varchar(100)	= NULL,
			@ReemplazarCampo	varchar(100)	= NULL,
			@ReemplazarValor	varchar(100)	= NULL,
			@ReemplazarTipo		varchar(100)	= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo		varchar(265), 
    @TipoDatos		varchar(256), 
    @TipoDatosExt	varchar(256), 
    @AS			varchar(256), 
    @Valor		varchar(256),
    @Ancho		smallint, 
    @AceptaNulos	bit, 
    @EsIdentity		bit, 
    @EsCalculado	bit,
    @Continuar		bit

  SELECT @SELECT = NULL, @VALUES = NULL, @TABLE = NULL, @DECALRE = NULL, @SET = NULL, @PARAMS = NULL, @WITH = NULL, @JOIN = NULL, @CampoIdentity = NULL--, @PIPES = NULL
  SELECT @Prefijo = ISNULL(@Prefijo, ''), @Sufijo = ISNULL(@Sufijo, ''), @JOIN_Tabla1 = ISNULL(@JOIN_Tabla1, ''), @JOIN_Tabla2 = ISNULL(@JOIN_Tabla2, '')
  IF @JOIN_Tabla1 <> '' SELECT @JOIN_Tabla1 = @JOIN_Tabla1 + '.'
  IF @JOIN_Tabla2 <> '' SELECT @JOIN_Tabla2 = @JOIN_Tabla2 + '.'
  IF @PK = 1
    DECLARE crSysCampo CURSOR LOCAL FOR 
     SELECT Campo, TipoDatos, Ancho, AceptaNulos, EsIdentity, EsCalculado
       FROM SysCampoExt
      WHERE Tabla = @Tabla AND Campo IN (SELECT Campo FROM dbo.fnTablaPK(@Tabla))
      ORDER BY Orden
  ELSE
    DECLARE crSysCampo CURSOR LOCAL FOR 
     SELECT Campo, TipoDatos, Ancho, AceptaNulos, EsIdentity, EsCalculado
       FROM SysCampoExt
      WHERE Tabla = @Tabla
      ORDER BY Orden

  OPEN crSysCampo
  FETCH NEXT FROM crSysCampo INTO @Campo, @TipoDatos, @Ancho, @AceptaNulos, @EsIdentity, @EsCalculado
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Continuar = 1
      IF @EsIdentity = 1 SELECT @CampoIdentity = @Campo
      IF @EsIdentity = 1 AND @ExcluirIdentity = 1 SELECT @Continuar = 0
      IF @ExcluirTimeStamp = 1 AND LOWER(@TipoDatos) = 'timestamp' SELECT @Continuar = 0
      IF @ExcluirCalculados = 1 AND @EsCalculado = 1 SELECT @Continuar = 0
      IF @ExcluirBLOBs = 1 AND LOWER(@TipoDatos) IN ('text', 'ntext', 'image') SELECT @Continuar = 0
      IF @ExcluirImage = 1 AND LOWER(@TipoDatos) = 'image' SELECT @Continuar = 0

      IF @Continuar = 1
      BEGIN
        SELECT @TipoDatosExt = @TipoDatos

        IF LOWER(@TipoDatos) IN ('char', 'varchar', 'nchar', 'nvarchar', 'binary')
          SELECT @TipoDatosExt = @TipoDatosExt+'('+CASE WHEN @Ancho = -1 THEN 'max' ELSE CONVERT(varchar, @Ancho) END+')'

        IF ISNULL(@ReemplazarTipo, '') <> ''
          SELECT @TipoDatosExt = @ReemplazarTipo
        
        IF @ASCampo = 1 SELECT @AS = ' AS '+@Campo ELSE SELECT @AS = ''
        IF @Campo = @ReemplazarCampo SELECT @Valor = @ReemplazarValor ELSE SELECT @Valor = @Prefijo+@Campo+@Sufijo+@AS
        SELECT @SELECT = dbo.fnConcatenarMAX(@SELECT, @Prefijo+@Campo+@Sufijo+@AS, ', '),
               @VALUES = dbo.fnConcatenarMAX(@VALUES, @Valor, ', '),
               @TABLE  = dbo.fnConcatenarMAX(@TABLE, @Campo + ' ' + @TipoDatosExt, ', '),
               @WITH   = dbo.fnConcatenarMAX(@WITH, @Campo + ' ' + @TipoDatosExt, ', '),
               @JOIN   = dbo.fnConcatenarMAX(@JOIN, @JOIN_Tabla1+@Campo+'='+@JOIN_Tabla2+@Campo, ' AND '),
               @DECALRE= dbo.fnConcatenarMAX(@DECALRE, '@'+@Campo+' '+@TipoDatosExt, ', '),
               @SET    = dbo.fnConcatenarMAX(@SET, @Prefijo+@Campo+@Sufijo+'=@'+@Campo, ', '),
               @PARAMS = dbo.fnConcatenarMAX(@PARAMS, '@'+@Campo, ', ')/*,
               @PIPES  = dbo.fnConcatenarMAX(@PIPES, 'CONVERT(varchar(max), '+@Campo+')', '+"|"+')*/
             
        IF CHARINDEX('CHAR', UPPER(@TipoDatosExt)) > 0 
          SELECT @TABLE = @TABLE + ' COLLATE Database_Default NULL'
        ELSE
          SELECT @TABLE = @TABLE + ' NULL'
      
      END
    END
    FETCH NEXT FROM crSysCampo INTO @Campo, @TipoDatos, @Ancho, @AceptaNulos, @EsIdentity, @EsCalculado
  END 
  CLOSE crSysCampo
  DEALLOCATE crSysCampo
  RETURN
END
GO

/****************************** spTablaInsertarDesdeXML ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaInsertarDesdeXML') and type = 'p') drop procedure dbo.spTablaInsertarDesdeXML
GO
CREATE PROCEDURE spTablaInsertarDesdeXML
			@Tabla			varchar(255),
			@iDatos			int,
			@Ruta			varchar(255),
			@ReemplazarCampo	varchar(100)	= NULL,
			@ReemplazarValor	varchar(100)	= NULL
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @SQL		nvarchar(max),
  @SELECT	varchar(max),
  @WITH		varchar(max),
  @VALUES	varchar(max)
  
  EXEC spTablaEstructura @Tabla, @SELECT = @SELECT OUTPUT, @WITH = @WITH OUTPUT, @VALUES = @VALUES OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @ExcluirIdentity = 1, @ReemplazarCampo = @ReemplazarCampo, @ReemplazarValor = @ReemplazarValor
  
  SELECT @SQL = N'INSERT '+@Tabla+N' ('+@SELECT+N') '+
                N'SELECT '+@VALUES+N' FROM OPENXML (@iDatos, '''+@Ruta+''', 1) WITH ('+@WITH+N')'

  EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
END
GO

/**************** fnEsNumerico ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsNumerico') DROP FUNCTION dbo.fnEsNumerico
GO
CREATE FUNCTION dbo.fnEsNumerico (@num VARCHAR(64))
RETURNS BIT  
--//WITH ENCRYPTION
AS BEGIN
    IF LEFT(@num, 1) = '-'  
        SET @num = SUBSTRING(@num, 2, LEN(@num))  
 
    DECLARE @pos TINYINT  
 
    SET @pos = 1 + LEN(@num) - CHARINDEX('.', REVERSE(@num))  
 
    RETURN CASE  
    WHEN PATINDEX('%[^0-9.-]%', @num) = 0  
        AND @num NOT IN ('.', '-', '+', '^') 
        AND LEN(@num)>0  
        AND @num NOT LIKE '%-%' 
        AND  
        (  
            ((@pos = LEN(@num)+1)  
            OR @pos = CHARINDEX('.', @num))  
        )  
    THEN  
        1  
    ELSE  
    0  
    END  
END  
GO  
 
/**************** EsIntegro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'EsIntegro') DROP FUNCTION EsIntegro
GO
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsIntegro') DROP FUNCTION dbo.fnEsIntegro
GO
CREATE FUNCTION dbo.fnEsIntegro (@num VARCHAR(64))
RETURNS BIT  
--//WITH ENCRYPTION
AS BEGIN
    IF LEFT(@num, 1) = '-'  
        SET @num = SUBSTRING(@num, 2, LEN(@num))  
 
    RETURN CASE  
    WHEN PATINDEX('%[^0-9-]%', @num) = 0  
        AND CHARINDEX('-', @num) <= 1  
        AND @num NOT IN ('.', '-', '+', '^') 
        AND LEN(@num)>0  
        AND @num NOT LIKE '%-%' 
    THEN  
        1  
    ELSE  
        0  
    END  
END  
GO

IF NOT EXISTS (SELECT * FROM Version)
  INSERT Version (Version, ID) VALUES (3000, 0)
GO

/**************** fnDividirHora ****************/
/* Esta función se aumentó para usarse en una corrección de 'SQL\SPOtros\10 ProcesarAsiste' para manejar el daro de AsisteD.HoraRegistro, y sacar 
	individualmente el valor de la hora o el minuto de una hora data como varchar en formato HHMM. La hora a procesar se pasa en el parametro @Hora
	y la parte que se desea se regrese como un int en el parametro @Parte, ya sea 'H' para la hora o 'M' para el minuto */
--#region fnDividirHora
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDividirHora') DROP FUNCTION fnDividirHora
GO
CREATE FUNCTION fnDividirHora (@Hora varchar(5), @Parte char(1))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN

	IF UPPER(@Parte) = 'M' RETURN(CONVERT(int, SUBSTRING(@Hora, 4, 2)))
	ELSE IF UPPER(@Parte) = 'H' RETURN(CONVERT(int, SUBSTRING(@Hora, 1, 2)))
RETURN(-1)
END
GO
--#endregion

/********************* spCHANGE_COLUMN *****************/
if exists (select * from sysobjects where id = object_id('dbo.spCHANGE_COLUMN') and type = 'p') drop procedure dbo.spCHANGE_COLUMN
GO
CREATE PROCEDURE spCHANGE_COLUMN
        @Tabla				sysname,
        @Campo				sysname,
        @TipoAnterior		varchar(20),
        @LongitudAnterior	int,
        @TipoNuevo			varchar(20),
        @LongitudNueva		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo	varchar(255)

  SET @Tipo = ''

  IF @TipoNuevo = 'varchar'
    SELECT @Tipo = @TipoNuevo + '(' + ISNULL(CONVERT(varchar,@LongitudNueva),255) + ') NULL'
  ELSE
    SELECT @Tipo = @TipoNuevo + ' NULL'

  IF EXISTS (SELECT * FROM information_schema.columns WHERE TABLE_NAME = @Tabla AND COLUMN_NAME = @Campo AND DATA_TYPE = @TipoAnterior AND CHARACTER_MAXIMUM_LENGTH = @LongitudAnterior)
  BEGIN
    EXEC spDROP_COLUMN @Tabla, @Campo    
    EXEC spALTER_TABLE @Tabla, @Campo, @Tipo
  END

--select @Tabla, @Campo, @TipoAnterior, @LongitudAnterior, @TipoNuevo, @LongitudNueva, @Tipo    
--SELECT * FROM information_schema.columns WHERE TABLE_NAME = 'REPPARAM' AND COLUMN_NAME = 'InfoClienteEnviarA' --AND DATA_TYPE = @TipoAnterior AND CHARACTER_MAXIMUM_LENGTH = @LongitudAnterior

  RETURN
END
GO
--exec spCHANGE_COLUMN 'RepParam', 'InfoClienteEnviarA', 'varchar', 20, 'int', null

/****** InvArtUbicaciones ******/
if not exists(select * from SysTabla where SysTabla = 'InvArtUbicaciones')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('InvArtUbicaciones','Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.InvArtUbicaciones') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvArtUbicaciones (
	RID			int		NOT NULL IDENTITY(1,1),
	ID			int		NULL,
	Renglon	float NULL,
	RenglonSub	int  NULL,
	RenglonID	int  NULL,
	Articulo		char(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	SerieLote		varchar(50)	NULL,
	Unidad			varchar(50)	NULL,
	Existencia			float		NULL,
	Posicion		varchar(10)	NULL,
	CantidadA			float		NULL,
	PosicionDestino		varchar(10)	NULL,
	RenglonInvD			float      NULL,
	Almacen				varchar(10) NULL
	CONSTRAINT priInvArtUbicaciones PRIMARY KEY CLUSTERED (RID)
  )  
END
GO


/************  InvArtUbicacionD  **************/
if not exists (select * from sysobjects where id = object_id('dbo.InvArtUbicacionD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.InvArtUbicacionD (
	
	RID				int		NOT NULL ,			
	Posicion		varchar(10)	NOT NULL,
	Cantidad		float		NULL,
	RenglonInvD		float      NULL
	PRIMARY KEY    (RID,Posicion)
  )  
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tginvArtUbicaciones') and sysstat & 0xf = 8) drop trigger dbo.tginvArtUbicaciones
GO
CREATE TRIGGER tginvArtUbicaciones ON invArtUbicaciones
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Ok				int,
    @cantidadA		float ,
    @existencia		float,
    @Articulo		char(20),
    @Almacen		varchar(10),
	@Posicion		varchar(10),
	@Mensaje		varchar(80),
	@Subcuenta		varchar(50), 
	@SerieLote		varchar(50),
	@Unidad			varchar(50),
	@PosicionDestino varchar(10)
	

  SELECT @cantidadA=cantidadA,@Articulo = Articulo, @Almacen = Almacen, @Posicion = posicion, @Subcuenta = Subcuenta, @SerieLote = SerieLote, @Unidad = Unidad,@PosicionDestino=PosicionDestino FROM Inserted
  SELECT @existencia=existencia  FROM ExistenciaAlternaPosicionSerieLote WHERE  Articulo=@Articulo and Almacen =@Almacen and posicion =@Posicion AND ISNULL(Subcuenta,'') = ISNULL(@Subcuenta,'') AND SerieLote = @SerieLote AND Unidad = @Unidad
  
  IF UPDATE(CantidadA) 
 IF @cantidadA>@existencia
 BEGIN
  SELECT @Mensaje='La Cantidad a cambiar es mayor a la existencia '      
  RAISERROR (@Mensaje,16,-1) 
 END 
 
 IF UPDATE(PosicionDestino) AND @PosicionDestino IS NOT NULL 
 IF NOT EXISTS(SELECT Posicion FROM AlmPos WHERE Posicion = @PosicionDestino  AND Almacen =@Almacen )
   BEGIN
	SELECT @Mensaje='La Posición capturada no existe dentro del Almacén '      
    RAISERROR (@Mensaje,16,-1)
   END 
 END
GO


if exists (select * from sysobjects where id = object_id('dbo.tginvArtUbicaciond') and sysstat & 0xf = 8) drop trigger dbo.tginvArtUbicaciond
GO
CREATE TRIGGER tginvArtUbicaciond ON invArtUbicaciond
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE    
    @Almacen		varchar(10),
	@Posicion		varchar(10),
	@Mensaje		varchar(80)	,
	@RID			int

  
  SELECT  @Posicion = posicion,@RID=RID FROM Inserted
  SELECT @Almacen=Almacen  FROM invArtUbicaciones WHERE  RID=@RID
  
 IF UPDATE(Posicion)
 IF NOT EXISTS(SELECT Posicion FROM AlmPos WHERE Posicion = @Posicion  AND Almacen =@Almacen )
   BEGIN   
	SELECT @Mensaje='La Posición capturada no existe dentro del Almacén'      
    RAISERROR (@Mensaje,16,-1)
   END 

END
GO
/************  Correccion WMS y GRAL  **************/
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'AcumU' AND type = 'V')
DROP VIEW AcumU
GO
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'AuxiliarU' AND type = 'V')
DROP VIEW AuxiliarU
GO
IF EXISTS(SELECT * FROM SysObjects WHERE name = 'SaldoU' AND type = 'V')
DROP VIEW SaldoU
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'AcumUGral' AND type = 'U')
EXEC sp_rename 'AcumUGral','AcumU'
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'AuxiliarUGral' AND type = 'U')
EXEC sp_rename 'AuxiliarUGral','AuxiliarU'
GO
IF EXISTS(SELECT * FROM sysobjects WHERE name = 'SaldoUGral' AND type = 'U')
EXEC sp_rename 'SaldoUGral','SaldoU'
GO
/************  Fin Correccion  **************/
GO