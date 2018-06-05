
/*******************************************************************************************/
/*                                             Riesgos                        	           */
/*******************************************************************************************/
EXEC spDROP_TABLE 'Riesgo', 2952
EXEC spDROP_TABLE 'RiesgoProc', 2952
EXEC spDROP_TABLE 'RiesgoProcedimiento', 2952
EXEC spDROP_TABLE 'RiesgoCostoPotencial', 2952
EXEC spDROP_TABLE 'RiesgoSeveridad', 2952
EXEC spDROP_TABLE 'RiesgoOcurrencia', 2952
EXEC spDROP_TABLE 'RiesgoDeteccion', 2952
EXEC spDROP_TABLE 'RiesgoProyecto', 2952
EXEC spDROP_TABLE 'RiesgoFactor', 2952
EXEC spDROP_TABLE 'RiesgoEvaluacion', 2952
EXEC spDROP_TABLE 'RiesgoValuacion', 2954
EXEC spDROP_TABLE 'RiesgoValuacionNivel', 2954


EXEC spDROP_TABLE 'RiesgoCat', 2961
EXEC spDROP_TABLE 'RiesgoGrupo', 2961
EXEC spDROP_TABLE 'RiesgoProceso', 2961
EXEC spDROP_TABLE 'RiesgoFam', 2961
EXEC spDROP_TABLE 'RiesgoLinea', 2961
EXEC spDROP_TABLE 'RiesgoSeveridad', 2961
EXEC spDROP_TABLE 'RiesgoSeveridadCuantitativa', 2961
EXEC spDROP_TABLE 'RiesgoOcurrencia', 2961
EXEC spDROP_TABLE 'RiesgoDeteccion', 2961
EXEC spDROP_TABLE 'RiesgoValuacion', 2961
EXEC spDROP_TABLE 'RiesgoProcedimiento', 2961
EXEC spDROP_TABLE 'RiesgoFactor', 2961
EXEC spDROP_TABLE 'RiesgoArt', 2961
EXEC spDROP_TABLE 'RiesgoEvaluacion', 2961
EXEC spDROP_TABLE 'RiesgoEvaluacionCostoPotencial', 2961
EXEC spDROP_TABLE 'Riesgo', 2961
EXEC spDROP_TABLE 'aroValuacion', 2962
EXEC spDROP_TABLE 'aroRiesgoEval', 2962
EXEC spDROP_TABLE 'aroRiesgoEvalEvento', 2962

EXEC spDROP_TABLE 'aroRiesgoEvaluacion', 2966
EXEC spDROP_TABLE 'aroRiesgoEvaluacionD', 2966
EXEC spDROP_TABLE 'aroEventoPerdida', 2966
EXEC spDROP_TABLE 'aroEventoPerdidaD', 2966
EXEC spDROP_TABLE 'aroEventoPerdidaDPoliza', 2966
EXEC spDROP_TABLE 'aroEventoPerdidaPoliza', 2966
EXEC spDROP_TABLE 'aroRiesgo', 2966
EXEC spDROP_TABLE 'aroRiesgoArt', 2966
EXEC spDROP_TABLE 'aroRiesgoControlInterno', 2966
go

-- drop table aroFactor
/****** aroFactor ******/
if not exists(select * from SysTabla where SysTabla = 'aroFactor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroFactor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroFactor') and type = 'U') 
  CREATE TABLE dbo.aroFactor (
	FactorRiesgo		varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	EsEstructura		bit		NULL	DEFAULT 0,
	Orden			varchar(100)	NULL,

	CONSTRAINT pk_aroFactor PRIMARY KEY CLUSTERED (FactorRiesgo)
)
GO
EXEC spADD_INDEX 'aroFactor', 'Orden', 'Orden'
GO

-- drop table aroEvento
/****** aroEvento ******/
if not exists(select * from SysTabla where SysTabla = 'aroEvento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroEvento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroEvento') and type = 'U') 
  CREATE TABLE dbo.aroEvento (
	EventoRiesgo		varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	EsEstructura		bit		NULL	DEFAULT 0,
	Orden			varchar(100)	NULL,

	CONSTRAINT pk_aroEvento PRIMARY KEY CLUSTERED (EventoRiesgo)
)
GO
EXEC spADD_INDEX 'aroEvento', 'Orden', 'Orden'
GO

-- drop table aroSeveridad
/****** aroSeveridad ******/
if not exists(select * from SysTabla where SysTabla = 'aroSeveridad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroSeveridad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroSeveridad') and type = 'U') 
CREATE TABLE dbo.aroSeveridad  (
	Severidad	char(1)		NOT NULL,

	Descripcion	varchar(255)	NULL,
	Tipo		varchar(20)	NULL,	-- Cuantitativa/Cualitativa
	Desde		money		NULL,
	Hasta		money		NULL,
	Valor		int		NULL,

	CONSTRAINT priRiesgoSeveridad PRIMARY KEY CLUSTERED (Severidad)
)
GO
EXEC spADD_INDEX 'aroSeveridad', 'Descripcion', 'Descripcion'
GO

/*** aroSeveridadCualitativa ***/
if exists (select * from sysobjects where id = object_id('dbo.aroSeveridadCualitativa') and type = 'V') drop view dbo.aroSeveridadCualitativa
GO
CREATE VIEW aroSeveridadCualitativa
--//WITH ENCRYPTION
AS 
SELECT Descripcion FROM aroSeveridad WHERE Tipo='Cualitativa'
GO

/*** aroSeveridadCuantitativa ***/
if exists (select * from sysobjects where id = object_id('dbo.aroSeveridadCuantitativa') and type = 'V') drop view dbo.aroSeveridadCuantitativa
GO
CREATE VIEW aroSeveridadCuantitativa
--//WITH ENCRYPTION
AS 
SELECT Descripcion FROM aroSeveridad WHERE Tipo='Cuantitativa'
GO


-- drop table aroOcurrencia
/****** aroOcurrencia ******/
if not exists(select * from SysTabla where SysTabla = 'aroOcurrencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroOcurrencia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroOcurrencia') and type = 'U') 
CREATE TABLE dbo.aroOcurrencia  (
	Ocurrencia	varchar(50)	NOT NULL,

	Descripcion	varchar(255)	NULL,
	Valor		int		NULL,

	CONSTRAINT pk_aroOcurrencia PRIMARY KEY CLUSTERED (Ocurrencia)
)
GO
EXEC spADD_INDEX 'aroOcurrencia', 'Descripcion', 'Descripcion'
GO

-- drop table aroDeteccion
/****** aroDeteccion ******/
if not exists(select * from SysTabla where SysTabla = 'aroDeteccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroDeteccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroDeteccion') and type = 'U') 
CREATE TABLE dbo.aroDeteccion  (
	Deteccion	varchar(50)	NOT NULL,

	Descripcion	varchar(255)	NULL,
	Valor		int		NULL,

	CONSTRAINT pk_aroDeteccion PRIMARY KEY CLUSTERED (Deteccion)
)
GO
EXEC spADD_INDEX 'aroDeteccion', 'Descripcion', 'Descripcion'
GO

/****** aroProceso ******/
if not exists(select * from SysTabla where SysTabla = 'aroProceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroProceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroProceso') and type = 'U') 
CREATE TABLE dbo.aroProceso  (
	Proceso		varchar(20)	NOT NULL,

	Nombre		varchar(100)	NULL,

	CONSTRAINT pk_aroProceso PRIMARY KEY CLUSTERED (Proceso)
)
GO

-- drop table aroLinea
/****** aroLinea ******/
if not exists(select * from SysTabla where SysTabla = 'aroLinea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroLinea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroLinea') and type = 'U') 
CREATE TABLE dbo.aroLinea  (
	LineaNegocios	varchar(20)	NOT NULL,

	Nombre		varchar(100)	NULL,

	CONSTRAINT pk_aroLinea PRIMARY KEY CLUSTERED (LineaNegocios)
)
GO

-- drop table aroUnidad
/****** aroUnidad ******/
if not exists(select * from SysTabla where SysTabla = 'aroUnidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroUnidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroUnidad') and type = 'U') 
CREATE TABLE dbo.aroUnidad  (
	UnidadOrganizacional	varchar(20)	NOT NULL,

	Nombre			varchar(100)	NULL,
	CentroCostos		varchar(20)	NULL,
	LineaNegocios		varchar(20)	NULL,
	EsEstructura		bit		NULL	DEFAULT 0,
	Orden			varchar(100)	NULL,

	CONSTRAINT pk_aroUnidad PRIMARY KEY CLUSTERED (UnidadOrganizacional)
)
GO
EXEC spADD_INDEX 'aroUnidad', 'Orden', 'Orden'
GO

EXEC spFK 'aroUnidad','LineaNegocios','aroLinea','LineaNegocios'
EXEC spFK 'aroUnidad','CentroCostos','CentroCostos','CentroCostos'
GO

/****** aroProcedimientoArt ******/
if not exists(select * from SysTabla where SysTabla = 'aroProcedimientoArt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroProcedimientoArt','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroProcedimientoArt') and type = 'U') 
CREATE TABLE dbo.aroProcedimientoArt  (
	Procedimiento	varchar(20)	NOT NULL,
	Articulo	varchar(20)	NOT NULL,

	CONSTRAINT pk_aroProcedimientoArt PRIMARY KEY CLUSTERED (Procedimiento, Articulo)
)
GO

EXEC spFK 'aroProcedimientoArt','Articulo','Art','Articulo'
GO


/****** aroProcedimientoUnidad ******/
if not exists(select * from SysTabla where SysTabla = 'aroProcedimientoUnidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroProcedimientoUnidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroProcedimientoUnidad') and type = 'U') 
CREATE TABLE dbo.aroProcedimientoUnidad  (
	Procedimiento		varchar(20)	NOT NULL,
	UnidadOrganizacional	varchar(20)	NOT NULL,

	CONSTRAINT pk_aroProcedimientoUnidad PRIMARY KEY CLUSTERED (Procedimiento, UnidadOrganizacional)
)
GO

EXEC spFK 'aroProcedimientoUnidad','UnidadOrganizacional','aroUnidad','UnidadOrganizacional'
EXEC spFK 'aroProcedimientoUnidad','Procedimiento','aroProcedimiento','Procedimiento'
GO

-- drop table aroProcedimiento
/****** aroProcedimiento ******/
if not exists(select * from SysTabla where SysTabla = 'aroProcedimiento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroProcedimiento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroProcedimiento') and type = 'U') 
CREATE TABLE dbo.aroProcedimiento  (
	Procedimiento		varchar(20)	NOT NULL,
	
	Nombre			varchar(100)	NULL,
	Proceso			varchar(20)	NULL,
	CentroCostos		varchar(20)	NULL,

	CONSTRAINT pk_aroProcedimiento PRIMARY KEY CLUSTERED (Procedimiento)
)
GO
EXEC spDROP_COLUMN 'aroProcedimiento', 'UnidadOrganizacional'
GO

EXEC spFK 'aroProcedimiento','Proceso','aroProceso','Proceso'
EXEC spFK 'aroProcedimiento','CentroCostos','CentroCostos','CentroCostos'
GO

if exists (select * from sysobjects where id = object_id('dbo.tg_aroProcedimientoBC') and sysstat & 0xf = 8) drop trigger dbo.tg_aroProcedimientoBC
GO
CREATE TRIGGER tg_aroProcedimientoBC ON aroProcedimiento
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProcedimientoN  	varchar(20),
    @ProcedimientoA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ProcedimientoN = Procedimiento FROM Inserted
  SELECT @ProcedimientoA = Procedimiento FROM Deleted
  IF @ProcedimientoN = @ProcedimientoA RETURN

  IF @ProcedimientoN IS NULL 
  BEGIN
    DELETE aroProcedimientoArt WHERE Procedimiento = @ProcedimientoA
  END ELSE
  IF @ProcedimientoA IS NOT NULL 
  BEGIN
    UPDATE aroProcedimientoArt SET Procedimiento = @ProcedimientoN WHERE Procedimiento = @ProcedimientoA
  END
END
GO
-- drop table aroNivel
/****** aroNivel ******/
if not exists(select * from SysTabla where SysTabla = 'aroNivel')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroNivel','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroNivel') and type = 'U') 
CREATE TABLE dbo.aroNivel (
	Nivel		int		NOT NULL,

	Nombre		varchar(100)	NULL,

	CONSTRAINT pk_aroNivel PRIMARY KEY CLUSTERED (Nivel)
)
GO


/****** aroValuacion ******/
if not exists(select * from SysTabla where SysTabla = 'aroValuacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroValuacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.aroValuacion') and type = 'U') 
CREATE TABLE dbo.aroValuacion (
	ValorSeveridad		int	NOT NULL,
	ValorOcurrencia		int	NOT NULL,
	ValorDeteccion		int	NOT NULL,
	
	CalificacionSeveridad	varchar(20)	NULL,
	CalificacionOcurrencia	varchar(20)	NULL,
        CalificacionDeteccion	varchar(20)	NULL,
	Nivel			int		NULL,
	Valor			int		NULL,

	CONSTRAINT pk_aroValuacion PRIMARY KEY CLUSTERED (ValorSeveridad, ValorOcurrencia, ValorDeteccion)
)
GO

EXEC spFK 'aroValuacion','Nivel','aroNivel','Nivel'
GO

-- sp_aroRiesgoEvaluacionAceptar 2
-- select * from arovaluacion
/************** sp_aroRiesgoEvaluacionAceptar *************/
if exists (select * from sysobjects where id = object_id('dbo.sp_aroRiesgoEvaluacionAceptar') and type = 'P') drop procedure dbo.sp_aroRiesgoEvaluacionAceptar
GO
CREATE PROCEDURE sp_aroRiesgoEvaluacionAceptar
		   @ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Severidad 			varchar(255), 
    @Ocurrencia 		varchar(255), 
    @Deteccion 			varchar(255),
    @ValorOcurrencia		int,
    @ValorDeteccion		int,
    @ValorSeveridad		int,
    @ValorSeveridadCuantitativa int,
    @Hasta			money,
    @Nivel			int,
    @Valor			int

  SELECT @Severidad = Severidad, @Ocurrencia = Ocurrencia, @Deteccion = Deteccion
    FROM aroRiesgoEvaluacion 
   WHERE ID = @ID

  SELECT @Hasta = SUM(Hasta) FROM aroRiesgoEvaluacionD WHERE ID = @ID
  SELECT @ValorOcurrencia            = MIN(Valor) FROM aroOcurrencia WHERE Descripcion = @Ocurrencia 
  SELECT @ValorDeteccion             = MIN(Valor) FROM aroDeteccion  WHERE Descripcion = @Deteccion  
  SELECT @ValorSeveridad             = MIN(Valor) FROM aroSeveridad  WHERE Tipo = 'Cualitativa'  AND Descripcion = @Severidad
  SELECT @ValorSeveridadCuantitativa = MIN(Valor) FROM aroSeveridad  WHERE Tipo = 'Cuantitativa' AND @Hasta BETWEEN Desde AND Hasta

  SELECT @Nivel = Nivel,
         @Valor = Valor 
    FROM aroValuacion  
   WHERE ValorSeveridad  = ISNULL(@ValorSeveridad, 0) + ISNULL(@ValorSeveridadCuantitativa, 0) 
     AND ValorOcurrencia = @ValorOcurrencia 
     AND ValorDeteccion  = @ValorDeteccion

  UPDATE aroRiesgoEvaluacion
     SET Nivel = @Nivel,
         ValorSeveridad = ISNULL(@ValorSeveridad, 0) + ISNULL(@ValorSeveridadCuantitativa, 0),
         ValorOcurrencia = @ValorOcurrencia, 
         ValorDeteccion  = @ValorDeteccion,
         Valor = @Valor
   WHERE ID = @ID
  RETURN 
END
GO

/**************** fn_aroEvaluacionNivel ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_aroEvaluacionNivel') DROP FUNCTION fn_aroEvaluacionNivel
GO
/**************** fn_aroEvaluacionValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_aroEvaluacionValor') DROP FUNCTION fn_aroEvaluacionValor
GO
/*CREATE FUNCTION fn_aroEvaluacionValor (@Riesgo varchar(10), @EvaluacionID int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Severidad 			varchar(255), 
    @Ocurrencia 		varchar(255), 
    @Deteccion 			varchar(255),
    @ValorOcurrencia		int,
    @ValorDeteccion		int,
    @ValorSeveridad		int,
    @ValorSeveridadCuantitativa int,
    @Hasta			money,
    @Valor			int

  SELECT @Severidad = Severidad, @Ocurrencia = Ocurrencia, @Deteccion = Deteccion
    FROM RiesgoEvaluacion 
   WHERE Riesgo = @Riesgo AND EvaluacionID = @EvaluacionID

  SELECT @Hasta = SUM(Hasta) FROM RiesgoEvaluacionCostoPotencial WHERE Riesgo = @Riesgo AND EvaluacionID = @EvaluacionID
  SELECT @ValorOcurrencia            = MIN(Valor) FROM RiesgoOcurrencia WHERE Ocurrencia  = @Ocurrencia 
  SELECT @ValorDeteccion             = MIN(Valor) FROM RiesgoDeteccion  WHERE Deteccion   = @Deteccion  
  SELECT @ValorSeveridad             = MIN(Valor) FROM RiesgoSeveridad  WHERE Descripcion = @Severidad
  SELECT @ValorSeveridadCuantitativa = MIN(Valor) FROM RiesgoSeveridadCuantitativa WHERE @Hasta BETWEEN Desde AND Hasta

  SELECT @Valor = Valor
    FROM RiesgoValuacion  
   WHERE ValorSeveridad  = ISNULL(@ValorSeveridad, 0) + ISNULL(@ValorSeveridadCuantitativa, 0) 
     AND ValorOcurrencia = @ValorOcurrencia 
     AND ValorDeteccion  = @ValorDeteccion
  RETURN (@Valor)
END*/
GO

-- drop table aroRiesgo
/****** aroRiesgo ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgo','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.aroRiesgo  (
	Riesgo			varchar(10)	NOT NULL,

	FechaRegistro		datetime	NULL,
	Nombre			varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Comentarios		text		NULL,
	Procedimiento		varchar(20)	NULL,
	Proceso			varchar(20)	NULL,
	CentroCostos		varchar(20)	NULL,
	UnidadOrganizacional	varchar(20)	NULL,
	LineaNegocios		varchar(20)	NULL,

	Supervisor		varchar(10)	NULL,
	Usuario			varchar(10)	NULL,
	Estatus 		varchar(15) 	NULL,
	UltimoCambio 		datetime  	NULL,
	Alta			datetime	NULL,
	Baja			datetime	NULL,
        NivelAcceso		varchar(50)	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,
	DetectadoPor		varchar(100)	NULL,
	DetectadoPorPuesto	varchar(100)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
	FechaAutorizacion	datetime	NULL,
	UsuarioAutorizacion	varchar(15)	NULL,
	FechaCancelacion	datetime	NULL,
	UsuarioCancelacion	varchar(15)	NULL,

	CONSTRAINT pk_aroRiesgo PRIMARY KEY CLUSTERED (Riesgo)
  )
  EXEC spSincroSemilla 'aroRiesgo'
END
GO
EXEC spALTER_TABLE 'aroRiesgo', 'TieneMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'aroRiesgo', 'FechaRegistro', 'datetime NULL'
EXEC spALTER_TABLE 'aroRiesgo', 'FechaAutorizacion', 'datetime NULL'
EXEC spALTER_TABLE 'aroRiesgo', 'UsuarioAutorizacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'aroRiesgo', 'FechaCancelacion', 'datetime NULL'
EXEC spALTER_TABLE 'aroRiesgo', 'UsuarioCancelacion', 'varchar(10) NULL'
GO
EXEC spADD_INDEX 'aroRiesgo', 'Nombre', 'Nombre'
GO

EXEC spFK 'aroRiesgo','Procedimiento','aroProcedimiento','Procedimiento'
EXEC spFK 'aroRiesgo','Proceso','aroProceso','Proceso'
EXEC spFK 'aroRiesgo','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'aroRiesgo','UnidadOrganizacional','aroUnidad','UnidadOrganizacional'
EXEC spFK 'aroRiesgo','LineaNegocios','aroLinea','LineaNegocios'
EXEC spFK 'aroRiesgo','Supervisor','Recurso','Recurso'
GO

-- drop table aroRiesgoArt
/****** aroRiesgoArt ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgoArt')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgoArt','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgoArt') and type = 'U') 
  CREATE TABLE dbo.aroRiesgoArt  (
	Riesgo			varchar(10)	NOT NULL,
	Articulo		varchar(20)	NOT NULL,

	CONSTRAINT pk_aroRiesgoArt PRIMARY KEY CLUSTERED (Riesgo, Articulo)
)
GO

EXEC spFK 'aroRiesgoArt','Articulo','Art','Articulo'
GO


-- drop table aroRiesgoFactor
/****** aroRiesgoFactor ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgoFactor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgoFactor','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgoFactor') and type = 'U') 
  CREATE TABLE dbo.aroRiesgoFactor  (
	Riesgo			varchar(10)	NOT NULL,
	FactorRiesgo		varchar(20)	NOT NULL,

	CONSTRAINT pk_aroRiesgoFactor PRIMARY KEY CLUSTERED (Riesgo, FactorRiesgo)
)
GO

EXEC spFK 'aroRiesgoFactor','FactorRiesgo','aroFactor','FactorRiesgo'
GO

-- drop table aroRiesgoControlInterno
/****** aroRiesgoControlInterno ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgoControlInterno')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgoControlInterno','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgoControlInterno') and type = 'U') 
  CREATE TABLE dbo.aroRiesgoControlInterno  (
	Riesgo			varchar(10)	NOT NULL,
	ControlInterno		varchar(255)	NOT NULL,

	Tipo			varchar(20)	NULL,		-- Automatizado, Semi Automatizado, Manual

	CONSTRAINT pk_aroRiesgoControlInterno PRIMARY KEY CLUSTERED (Riesgo, ControlInterno)
)
GO

-- drop table aroRiesgoEvaluacion
/****** aroRiesgoEvaluacion ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgoEvaluacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgoEvaluacion','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgoEvaluacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.aroRiesgoEvaluacion (
	ID			int		NOT NULL IDENTITY(1,1),

	Riesgo			varchar(10)	NULL,

	Fecha			datetime	NULL,
	Usuario			varchar(10)	NULL,
	Estatus			varchar(15)	NULL,

	Tipo			varchar(20)	NULL,	-- Real / Plantilla
	Version			varchar(10)	NULL,
	Observaciones		varchar(255)	NULL,

	Severidad		varchar(255)	NULL,
	Ocurrencia		varchar(255)	NULL,
	Deteccion		varchar(255)	NULL,
	Nivel			int		NULL,

	ValorSeveridad		int		NULL,
	ValorOcurrencia		int		NULL,
	ValorDeteccion		int		NULL,
	Valor			int		NULL,

	UsuarioConclusion	varchar(10)	NULL,
	FechaConclusion		datetime	NULL,
	UsuarioCancelacion	varchar(10)	NULL,
	FechaCancelacion	datetime	NULL,
	
	CONSTRAINT pk_aroRiesgoEvaluacion PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'aroRiesgoEvaluacion'
END
GO
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'ValorSeveridad', 'int NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'ValorOcurrencia', 'int NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'ValorDeteccion', 'int NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'UsuarioConclusion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'FechaConclusion', 'datetime	NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'UsuarioCancelacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'aroRiesgoEvaluacion', 'FechaCancelacion', 'datetime	NULL'
GO
EXEC spADD_INDEX 'aroRiesgoEvaluacion', 'Riesgo', 'Riesgo'
GO

EXEC spFK 'aroRiesgoEvaluacion','Nivel','aroNivel','Nivel'
GO

-- drop table aroRiesgoEvaluacionD
/****** aroRiesgoEvaluacionD ******/
if not exists(select * from SysTabla where SysTabla = 'aroRiesgoEvaluacionD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroRiesgoEvaluacionD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroRiesgoEvaluacionD') and type = 'U') 
  CREATE TABLE dbo.aroRiesgoEvaluacionD  (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	EventoRiesgo		varchar(20)	NULL,
	Desde			money		NULL,
	Hasta			money		NULL,

	CONSTRAINT pk_aroRiesgoEvaluacionD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO

EXEC spFK 'aroRiesgoEvaluacionD','EventoRiesgo','aroEvento','EventoRiesgo'
GO

if exists (select * from sysobjects where id = object_id('dbo.tg_aroRiesgoBC') and sysstat & 0xf = 8) drop trigger dbo.tg_aroRiesgoBC
GO
CREATE TRIGGER tg_aroRiesgoBC ON aroRiesgo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @RiesgoN  	varchar(20),
    @RiesgoA	varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @RiesgoN = Riesgo FROM Inserted
  SELECT @RiesgoA = Riesgo FROM Deleted
  IF @RiesgoN = @RiesgoA RETURN

  IF @RiesgoN IS NULL 
  BEGIN
    DELETE aroRiesgoArt 		WHERE Riesgo = @RiesgoA
    DELETE aroRiesgoFactor 		WHERE Riesgo = @RiesgoA
    DELETE aroRiesgoControlInterno 	WHERE Riesgo = @RiesgoA
    DELETE aroRiesgoEvaluacion 		WHERE Riesgo = @RiesgoA
  END ELSE
  IF @RiesgoA IS NOT NULL 
  BEGIN
    UPDATE aroRiesgoArt 		SET Riesgo = @RiesgoN WHERE Riesgo = @RiesgoA
    UPDATE aroRiesgoFactor  		SET Riesgo = @RiesgoN WHERE Riesgo = @RiesgoA
    UPDATE aroRiesgoControlInterno 	SET Riesgo = @RiesgoN WHERE Riesgo = @RiesgoA
    UPDATE aroRiesgoEvaluacion		SET Riesgo = @RiesgoN WHERE Riesgo = @RiesgoA
  END
END
GO

-- drop table aroEventoPerdida
/****** aroEventoPerdida ******/
if not exists(select * from SysTabla where SysTabla = 'aroEventoPerdida')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroEventoPerdida','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroEventoPerdida') and type = 'U') 
BEGIN
  CREATE TABLE dbo.aroEventoPerdida (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	NULL,
	Tipo			varchar(20)	NULL,	-- Oficio / Formato
	Descripcion		varchar(255)	NULL,
	Comentarios		text		NULL,
	Referencia		varchar(50)	NULL,
	FechaRegistro		datetime	NULL,
	FechaNotificacion	datetime	NULL,
	FechaSuceso		datetime	NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,

	ClienteRef		varchar(20)	NULL,
	Riesgo			varchar(10)	NULL,

	Supervisor		varchar(10)	NULL,
	Usuario			varchar(10)	NULL,
	Estatus 		varchar(15) 	NULL,
	Situacion		varchar(50)	NULL,
	SituacionFecha		datetime	NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,
	ReportadoPor		varchar(100)	NULL,
	ReportadoPorPuesto	varchar(100)	NULL,

	Procedimiento		varchar(20)	NULL,
	Proceso			varchar(20)	NULL,
	CentroCostos		varchar(20)	NULL,
	UnidadOrganizacional	varchar(20)	NULL,
	LineaNegocios		varchar(20)	NULL,
	Articulo		varchar(20)	NULL,
	FactorRiesgo		varchar(20)	NULL,

	UsuarioConclusion	varchar(10)	NULL,
	FechaConclusion		datetime	NULL,
	UsuarioCancelacion	varchar(10)	NULL,
	FechaCancelacion	datetime	NULL,

	CONSTRAINT pk_aroEventoPerdida PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'aroEventoPerdida'
END
GO
EXEC spALTER_TABLE 'aroEventoPerdida', 'UsuarioConclusion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'aroEventoPerdida', 'FechaConclusion', 'datetime	NULL'
EXEC spALTER_TABLE 'aroEventoPerdida', 'UsuarioCancelacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'aroEventoPerdida', 'FechaCancelacion', 'datetime	NULL'
GO

EXEC spFK 'aroEventoPerdida','Riesgo','aroRiesgo','Riesgo'
EXEC spFK 'aroEventoPerdida','Supervisor','Recurso','Recurso'
EXEC spFK 'aroEventoPerdida','Procedimiento','aroProcedimiento','Procedimiento'
EXEC spFK 'aroEventoPerdida','Proceso','aroProceso','Proceso'
EXEC spFK 'aroEventoPerdida','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'aroEventoPerdida','UnidadOrganizacional','aroUnidad','UnidadOrganizacional'
EXEC spFK 'aroEventoPerdida','LineaNegocios','aroLinea','LineaNegocios'
EXEC spFK 'aroEventoPerdida','Articulo','Art','Articulo'
EXEC spFK 'aroEventoPerdida','FactorRiesgo','aroFactor','FactorRiesgo'
GO

-- drop table aroEventoPerdidaD
/****** aroEventoPerdidaD ******/
if not exists(select * from SysTabla where SysTabla = 'aroEventoPerdidaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroEventoPerdidaD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroEventoPerdidaD') and type = 'U') 
  CREATE TABLE dbo.aroEventoPerdidaD (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	TipoPerdida		varchar(20)	NULL,
	TipoPerdidaFolio	int		NULL,
	Importe			money		NULL,

	CONSTRAINT pk_aroEventoPerdidaD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO

EXEC spFK 'aroEventoPerdidaD','TipoPerdida','aroEvento','EventoRiesgo'
EXEC spFK 'aroEventoPerdidaD','ID','aroEventoPerdida','ID'
GO

-- drop table aroEventoPerdidaPoliza
/****** aroEventoPerdidaPoliza ******/
if not exists(select * from SysTabla where SysTabla = 'aroEventoPerdidaPoliza')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('aroEventoPerdidaPoliza','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.aroEventoPerdidaPoliza') and type = 'U') 
  CREATE TABLE dbo.aroEventoPerdidaPoliza (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	Cuenta			varchar(20)	NULL,
	CentroCostos		varchar(50)	NULL,
	Concepto		varchar(50)	NULL,
	Referencia		varchar(50)	NULL,
	Debe			money		NULL,
	Haber			money		NULL,

	CONSTRAINT pk_aroEventoPerdidaPoliza PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO

EXEC spFK 'aroEventoPerdidaPoliza','Cuenta','Cta','Cuenta'
GO


/************** sp_aroRiesgoEstatus *************/
if exists (select * from sysobjects where id = object_id('dbo.sp_aroRiesgoEstatus') and type = 'P') drop procedure dbo.sp_aroRiesgoEstatus
GO
CREATE PROCEDURE sp_aroRiesgoEstatus
		   @Riesgo		varchar(20),
		   @Estatus		varchar(15),
		   @Usuario		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  IF @Estatus = 'AUTORIZADO'
    UPDATE aroRiesgo 
       SET Estatus = @Estatus,
           FechaAutorizacion = dbo.fnFechaSinHora(GETDATE()),
           UsuarioAutorizacion = @Usuario
     WHERE Riesgo = @Riesgo
  ELSE
  IF @Estatus = 'CANCELADO'
    UPDATE aroRiesgo 
       SET Estatus = @Estatus,
           FechaCancelacion = dbo.fnFechaSinHora(GETDATE()),
           UsuarioCancelacion = @Usuario
     WHERE Riesgo = @Riesgo
  RETURN 
END
GO


/************** sp_aroRiesgoEvaluacionEstatus *************/
if exists (select * from sysobjects where id = object_id('dbo.sp_aroRiesgoEvaluacionEstatus') and type = 'P') drop procedure dbo.sp_aroRiesgoEvaluacionEstatus
GO
CREATE PROCEDURE sp_aroRiesgoEvaluacionEstatus
		   @ID			int,
		   @Estatus		varchar(15),
		   @Usuario		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(100),
    @Valor	int

  SELECT @Mensaje = NULL
  IF @Estatus = 'CONCLUIDO'
  BEGIN
    SELECT @Valor = NULLIF(Valor, 0) FROM aroRiesgoEvaluacion WHERE ID = @ID
    IF @Valor IS NULL SELECT @Mensaje = 'Evaluacion Incorrecta'
    IF @Mensaje IS NULL
      UPDATE aroRiesgoEvaluacion
         SET Estatus = @Estatus,
             FechaConclusion = dbo.fnFechaSinHora(GETDATE()),
             UsuarioConclusion = @Usuario
       WHERE ID = @ID
  END ELSE
  IF @Estatus = 'CANCELADO'
    UPDATE aroRiesgoEvaluacion
       SET Estatus = @Estatus,
           FechaCancelacion = dbo.fnFechaSinHora(GETDATE()),
           UsuarioCancelacion = @Usuario
     WHERE ID = @ID
  SELECT 'Mensaje' = @Mensaje
  RETURN 
END
GO

/**************** fn_aroTipoPerdidaFolio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fn_aroTipoPerdidaFolio') DROP FUNCTION fn_aroTipoPerdidaFolio
GO
CREATE FUNCTION fn_aroTipoPerdidaFolio (@Empresa varchar(5), @TipoPerdida varchar(20))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	int

  SELECT @Resultado = 0
  SELECT @Resultado = ISNULL(MAX(TipoPerdidaFolio), 0)
    FROM aroEventoPerdidaD d
    JOIN aroEventoPerdida e ON e.ID = d.ID
   WHERE d.TipoPerdida = @TipoPerdida AND e.Empresa = @Empresa AND e.Estatus IN ('CONCLUIDO', 'CANCELADO')

  RETURN (ISNULL(@Resultado, 0))
END
GO


/************** sp_aroEventoPerdidaEstatus *************/
if exists (select * from sysobjects where id = object_id('dbo.sp_aroEventoPerdidaEstatus') and type = 'P') drop procedure dbo.sp_aroEventoPerdidaEstatus
GO
CREATE PROCEDURE sp_aroEventoPerdidaEstatus
		   @ID			int,
		   @Estatus		varchar(15),
		   @Usuario		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(100),
    @Valor	int,
    @Empresa	varchar(5),
    @Importe	money,
    @Debe	money,
    @Haber	money

  SELECT @Mensaje = NULL
  IF @Estatus = 'CONCLUIDO'
  BEGIN
    SELECT @Empresa = Empresa FROM aroEventoPerdida WHERE ID = @ID
    SELECT @Importe = SUM(Importe) FROM aroEventoPerdidaD WHERE ID = @ID
    SELECT @Debe = SUM(Debe), @Haber = SUM(Haber) FROM aroEventoPerdidaPoliza WHERE ID = @ID

    IF @Debe <> @Haber SELECT @Mensaje = 'La Poliza No Cuadra' ELSE
    IF @Importe <> @Debe SELECT @Mensaje = 'La Poliza No Corresponde con el Importe del Movimiento'
    IF @Mensaje IS NULL
    BEGIN
      UPDATE aroEventoPerdidaD
         SET TipoPerdidaFolio = dbo.fn_aroTipoPerdidaFolio(@Empresa, TipoPerdida) + 1
       WHERE ID = @ID
      UPDATE aroEventoPerdida
         SET Estatus = @Estatus,
             FechaConclusion = dbo.fnFechaSinHora(GETDATE()),
             UsuarioConclusion = @Usuario
       WHERE ID = @ID
    END
  END ELSE
  IF @Estatus = 'CANCELADO'
    UPDATE aroEventoPerdida
       SET Estatus = @Estatus,
           FechaCancelacion = dbo.fnFechaSinHora(GETDATE()),
           UsuarioCancelacion = @Usuario
     WHERE ID = @ID
  SELECT 'Mensaje' = @Mensaje
  RETURN 
END
GO