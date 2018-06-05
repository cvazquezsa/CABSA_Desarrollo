SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

if exists (select * from sysobjects where id = object_id('dbo.Sucursal') and type = 'U') 
  EXEC spALTER_TABLE 'Sucursal', 'UltimaSincronizacion', 'datetime NULL'
GO

UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovImpuesto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'PagadoAux'
GO

EXEC spALTER_TABLE 'IntelisisService', 'SolicitudBinario', 'varbinary(max) NULL'
EXEC spALTER_TABLE 'Version', 'DirectorioEmpaquetadorArchivos', 'varchar(255) NULL'
GO

--JGD
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'AfectarBitacora'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'AgenteAgenda'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Anticipo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'BackOrderLog'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CB'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CFDEnviar'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'COMS' WHERE SysTabla = 'CompraSugerir'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'CONT' WHERE SysTabla = 'ContReg'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'CONT' WHERE SysTabla = 'ContXProcesar'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'CuotaCxD'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'eDocSeccionTemporal'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'EstadoCuenta'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'EvaluacionCto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'InvCapaAux'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ListaIDRenglon'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ListaModuloID'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCampoExtra'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCodigo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovCto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovDReg'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovExportacionDatos'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovFormaAnexo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovGastoIndirecto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovGrupo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovPersonal'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovPresupuesto'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovRecibo'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovReg'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'MovXML'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Outlook'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'OutlookProcesar'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'ProcesarCBInfo'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'PROD' WHERE SysTabla = 'ProdSerieLoteCosto'
UPDATE SysTabla SET Tipo = 'Movimiento' ,Modulo = 'PROD' WHERE SysTabla = 'ProyResultado'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'SMS'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacion'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacionGuia'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'TablaAmortizacionMigracion'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'Tarea'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerAux'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerAuxCorte'
UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'VerMovFlujo'
--Fin JGD
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'PRECI' WHERE SysTabla = 'Precio'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'PRECI' WHERE SysTabla = 'PrecioD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS01'  WHERE SysTabla = 'AroEventoPerdida'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS01' WHERE SysTabla = 'AroEventoPerdidaD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS02'  WHERE SysTabla = 'AroRiesgoEvaluacion'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS02' WHERE SysTabla = 'AroRiesgoEvaluacionD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS03'  WHERE SysTabla = 'ArtMaterialHist'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS03' WHERE SysTabla = 'ArtMaterialHistD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS04'  WHERE SysTabla = 'GRP_Presupuesto'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS04' WHERE SysTabla = 'GRP_PresupuestoD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05'  WHERE SysTabla = 'MovSituacion'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05' WHERE SysTabla = 'MovSituacionD'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS05' WHERE SysTabla = 'MovSituacionUsuario'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS06'  WHERE SysTabla = 'PlantillaOffice'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS06' WHERE SysTabla = 'PlantillaOfficeD'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07'  WHERE SysTabla = 'CteCto'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoGrupo'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoComites'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoActividad'
UPDATE SysTabla SET Tipo = 'Maestro', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoDireccion'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoEvento'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS07' WHERE SysTabla = 'CteCtoHist'
UPDATE SysTabla SET Tipo = 'Movimiento', Modulo = 'SIS08' WHERE SysTabla = 'Tarea'
UPDATE SysTabla SET Tipo = 'Cuenta', Modulo = 'SIS08' WHERE SysTabla = 'TareaBitacora'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomX'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXDin'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXGasto'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXCxp'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXPersonal'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXCxc'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXFormula'
UPDATE SysTabla SET Modulo = 'SIS09' WHERE SysTabla = 'NomXPersonalGrupo'
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocD'
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocDMapeoCampo'
UPDATE SysTabla SET Modulo = 'SIS10' WHERE SysTabla = 'eDocDTagSostener'
UPDATE SysTabla SET Modulo = 'SIS11' WHERE SysTabla = 'ContX'
UPDATE SysTabla SET Modulo = 'SIS11' WHERE SysTabla = 'ContXD'
UPDATE SysTabla SET Modulo = 'SIS12' WHERE SysTabla = 'Evento'
UPDATE SysTabla SET Modulo = 'SIS12' WHERE SysTabla = 'EventoD'
UPDATE SysTabla SET Modulo = 'SIS13' WHERE SysTabla = 'EmbarqueMov'
GO

UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'DocCta'
UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'Politica'
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVista'
UPDATE SysTabla SET Tipo = 'N/A' WHERE SysTabla = 'eDocModuloVistaAyuda'
UPDATE SysTabla SET Tipo = 'Cuenta' WHERE SysTabla = 'ProyPuntoCritico'
GO
UPDATE SysTabla SET Tipo = 'Maestro' WHERE SysTabla = 'EmpresaCfgPVMonCta'
GO

if not exists (select * from SysTabla where SysTabla = 'MovEspecificoNomina') INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovEspecificoNomina', 'Maestro')
if not exists (select * from SysTabla where SysTabla = 'ImpuestoEstatalGastoOperacion') INSERT INTO SysTabla (SysTabla, Tipo, Modulo) VALUES ('ImpuestoEstatalGastoOperacion', 'Movimiento','NOM')
GO

IF NOT EXISTS(SELECT * FROM MensajeLista WHERE Mensaje = 72080) INSERT MensajeLista (Mensaje,Descripcion) VALUES (72080,'Información Incompleta')
GO

EXEC spDROP_COLUMN 'Cta', 'CentrosCostos2'
EXEC spDROP_COLUMN 'Cta', 'CentrosCostos3'
GO

EXEC spALTER_TABLE 'Version', 'SincroIS', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroISRecibirRespaldoMatriz', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroISDBMailAsunto', 'varchar(8000) null DEFAULT "Notificacion Intelisis Sincro IS (ID#IntelisisServiceID#)"'
EXEC spALTER_TABLE 'Version', 'SincroISDBMailMensaje', 'varchar(8000) null DEFAULT "Tipo Solicitud #SubReferencia#<BR> Estatus #Estatus#<BR>Error #IntelisisServiceOk#<BR>Referencia #IntelisisServiceOkRef#<BR>Fecha #FechaEstatus#<BR>Conversación #Conversacion#<BR>Identificador Registro #SincroGUID#<BR>Sucursal Origen #SucursalOrigen#<BR>Sucursal Destino #SucursalDestino#"'
EXEC spALTER_TABLE 'Version', 'SincroISTransmitiendo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Version', 'SincroISLongitudPaquete', 'int NULL DEFAULT 500 WITH VALUES'
GO

if EXISTS(select * from sysobjects where id = object_id('dbo.UsuarioCfg2') and type = 'U') 
  EXEC spALTER_TABLE 'UsuarioCfg2', 'SincroISNotificarError', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if EXISTS(select * from sysobjects where id = object_id('dbo.IntelisisService') and type = 'U') 
BEGIN
  EXEC spALTER_TABLE 'IntelisisService', 'Conversacion', 'uniqueidentifier NULL'
  EXEC spALTER_TABLE 'IntelisisService', 'SincroGUID', 'uniqueidentifier NULL'
  EXEC spALTER_TABLE 'IntelisisService', 'SucursalOrigen', 'int NULL'
  EXEC spALTER_TABLE 'IntelisisService', 'SucursalDestino', 'int NULL'
  EXEC spALTER_TABLE 'IntelisisService', 'SincroTabla', 'varchar(100) NULL'  
  EXEC spALTER_TABLE 'IntelisisService', 'SincroSolicitud', 'uniqueidentifier NULL'    
  EXEC spALTER_TABLE 'IntelisisService', 'SolicitudBinario', 'varbinary(max) NULL' -- REQ12766
END
GO

UPDATE SysTabla SET Tipo = 'Movimiento' WHERE SysTabla = 'InvCapaAux'
GO

--DROP TABLE SincroISRetransmisor
IF NOT EXISTS(SELECT * FROM sysobjects where id = object_id('dbo.SincroISRetransmisor') and type = 'U') 
CREATE TABLE SincroISRetransmisor (
	RID					int				NOT NULL IDENTITY(1,1),

	SPID				int				NULL,	
	HoraInicio			datetime		NULL,
	HoraFin				datetime		NULL,	
	Comentarios			varchar(1000)	NULL,
	
	CONSTRAINT priSincroISRetransmisor PRIMARY KEY CLUSTERED (RID)	
)
GO

-- 9562
if EXISTS(select * from sysobjects where id = object_id('dbo.eDocInDirDetalle') and type = 'U') 
  EXEC spALTER_TABLE 'eDocInDirDetalle', 'FechaCreacion', 'datetime NULL'
GO

/****** SincroISDropBoxPaquete ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISDropBoxPaquete') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISDropBoxPaquete')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISDropBoxPaquete') and type = 'U') 
CREATE TABLE dbo.SincroISDropBoxPaquete (
	RID						int identity(1,1) NOT NULL,
	Conversacion			uniqueidentifier,
    Paquete					varchar(255),

	IntelisisServiceID		int,

	CONSTRAINT priSincroISDropBoxPaquete PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'SincroISDropBoxPaquete', 'Estatus', 'varchar(15) NOT NULL DEFAULT ''PENDIENTE'' WITH VALUES'
GO
EXEC spADD_INDEX 'SincroISDropBoxPaquete', 'IntelisisServiceID', 'IntelisisServiceID, Conversacion'
GO

/****** SincroISDebugTrigger ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISDebugTrigger') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISDebugTrigger')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISDebugTrigger') and type = 'U') 
CREATE TABLE dbo.SincroISDebugTrigger (

	RID						int identity(1,1) NOT NULL,

	Tabla					varchar(50)		    NULL,	
	Tipo					varchar(10)			NULL,
	
	CONSTRAINT priSincroISDebugTrigger PRIMARY KEY CLUSTERED (RID)
)
GO

/****** SincroISTablaFiltroEspecial ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISTablaFiltroEspecial') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISTablaFiltroEspecial')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISTablaFiltroEspecial') and type = 'U') 
CREATE TABLE dbo.SincroISTablaFiltroEspecial (
	Tabla					varchar(50)		NOT NULL,
	RID						int identity(1,1) NOT NULL,
	
	Orden					int					NULL,
	Expresion				varchar(255)		NULL,
	Operador				varchar(50)			NULL,
	

	CONSTRAINT priSincroISTablaFiltroEspecial PRIMARY KEY CLUSTERED (Tabla, RID)
)
GO

/****** SincroISTablaSinonimo ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISTablaSinonimo') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISTablaSinonimo')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISTablaSinonimo') and type = 'U') 
CREATE TABLE dbo.SincroISTablaSinonimo (
	Tabla					varchar(50)		NOT NULL,
	
	SinonimoTabla			varchar(50)		NULL,	

	CONSTRAINT priSincroISTablaSinonimo PRIMARY KEY CLUSTERED (Tabla)
)
GO

DELETE FROM SincroISTablaFiltroEspecial
GO
DELETE FROM SincroISTablaSinonimo
GO

/****** VirtualTareaCuenta ******/
if not exists (select * from SysTabla where SysTabla = 'VirtualTareaCuenta') 
  INSERT INTO SysTabla (SysTabla, Descripcion, Tipo, SincroActivo, Modulo) VALUES ('VirtualTareaCuenta', 'Tabla Virtual de Tarea con Tipo Cuenta', 'Cuenta', 1, 'SIS08')
GO

INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualTareaCuenta', 1, 'Tarea.Modulo IS NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualTareaCuenta', 2, 'Tarea.ModuloID IS NULL', 'AND')
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('Tarea', 1, 'NULLIF(Tarea.Modulo,'''') IS NOT NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('Tarea', 2, 'NULLIF(Tarea.ModuloID,'''') IS NOT NULL', 'AND')
GO

INSERT SincroISTablaSinonimo (Tabla, SinonimoTabla) VALUES ('VirtualTareaCuenta', 'Tarea')
GO

/****** VirtualEvaluacionCtoCuenta ******/
if not exists (select * from SysTabla where SysTabla = 'VirtualEvaluacionCtoCuenta') 
  INSERT INTO SysTabla (SysTabla, Descripcion, Tipo, SincroActivo) VALUES ('VirtualEvaluacionCtoCuenta', 'Tabla Virtual de EvaluacionCto con Tipo Cuenta', 'Cuenta', 1)
GO

INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualEvaluacionCtoCuenta', 1, 'EvaluacionCto.Modulo IS NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualEvaluacionCtoCuenta', 2, 'EvaluacionCto.ModuloID IS NULL', 'AND')
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('EvaluacionCto', 1, 'NULLIF(EvaluacionCto.Modulo,'''') IS NOT NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('EvaluacionCto', 2, 'NULLIF(EvaluacionCto.ModuloID,'''') IS NOT NULL', 'AND')
GO

INSERT SincroISTablaSinonimo (Tabla, SinonimoTabla) VALUES ('VirtualEvaluacionCtoCuenta', 'EvaluacionCto')
GO

/****** VirtualCBCuenta ******/
if not exists (select * from SysTabla where SysTabla = 'VirtualCBCuenta') 
  INSERT INTO SysTabla (SysTabla, Descripcion, Tipo, SincroActivo) VALUES ('VirtualCBCuenta', 'Tabla Virtual de CB con Tipo Cuenta', 'Cuenta', 1)
GO
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualCBCuenta', 1, 'CB.Modulo IS NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualCBCuenta', 2, 'CB.ModuloID IS NULL', 'AND')
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('CB', 1, 'NULLIF(CB.Modulo,'''') IS NOT NULL', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('CB', 2, 'NULLIF(CB.ModuloID,'''') IS NOT NULL', 'AND')
GO

INSERT SincroISTablaSinonimo (Tabla, SinonimoTabla) VALUES ('VirtualCBCuenta', 'CB')
GO

/****** VirtualNomXFormulaMaestro ******/
if not exists (select * from SysTabla where SysTabla = 'VirtualNomXFormulaMaestro') 
  INSERT INTO SysTabla (SysTabla, Descripcion, Tipo, SincroActivo) VALUES ('VirtualNomXFormulaMaestro', 'Tabla Virtual de NomXFormula con Tipo Maestro', 'Maestro', 1)
GO
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('VirtualNomXFormulaMaestro', 1, 'NomXFormula.ID = 0', NULL)
INSERT SincroISTablaFiltroEspecial (Tabla, Orden, Expresion, Operador) VALUES ('NomXFormula', 1, 'NomXFormula.ID <> 0', NULL)
GO

INSERT SincroISTablaSinonimo (Tabla, SinonimoTabla) VALUES ('VirtualNomXFormulaMaestro', 'NomXFormula')
GO

/**************** fnSincroISTablaConCampoIdentity ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISTablaConCampoIdentity') DROP FUNCTION fnSincroISTablaConCampoIdentity
GO
CREATE FUNCTION fnSincroISTablaConCampoIdentity 
	(
	@Tabla				varchar(50)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  IF EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMNPROPERTY(OBJECT_ID(TABLE_NAME),COLUMN_NAME,'IsIdentity') = 1 AND TABLE_NAME = @Tabla) SET @Resultado = 1 ELSE SET @Resultado = 0
  
  RETURN (@Resultado)
END
GO

/**************** fnSincroISTablaTipo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISTablaTipo') DROP FUNCTION fnSincroISTablaTipo
GO
CREATE FUNCTION fnSincroISTablaTipo 
	(
	@Tabla					varchar(50) 
	)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)
      
  SET @Resultado = NULL    
  SELECT @Resultado = Tipo FROM SysTabla WHERE SysTabla = @Tabla    

  IF @Tabla IN ('Precio','PrecioD','AroEventoPerdida','AroEventoPerdidaD','AroEvaluacion','AroEvaluacionD','ArtMaterialHist','ArtMaterialHistD','GRP_Presupuesto','GRP_PresupuestoD','MovSituacion','MovSituacionD','MovSituacionUsuario','PlantillaOffice','PlantillaOfficeD','CteCto','CteCtoGrupo','CteCtoComites','CteCtoActividad','CteCtoDireccion','CteCtoHist','TareaBitacora','Tarea','NomX','NomXPersonal','NomXDin','NomXGasto','NomXCxp','NomXCxc','NomXFormula','NomXPersonalGrupo','eDocD','eDocDMapeoCampo','eDocDTagSostener','ContX','ContXD','Evento','EventoD') SELECT @Resultado = 'Movimiento'
  
  RETURN (@Resultado)
END
GO

--select dbo.fnSincroISTablaTipo('AroEventoPerdida')

/**************** fnSincroISTablaSinonimo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISTablaSinonimo') DROP FUNCTION fnSincroISTablaSinonimo
GO
CREATE FUNCTION fnSincroISTablaSinonimo 
	(
	@Tabla					varchar(50) 
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)
      
  SET @Resultado = NULL    
  SELECT @Resultado = SinonimoTabla FROM SincroISTablaSinonimo WHERE Tabla = @Tabla    
  SET @Resultado = RTRIM(ISNULL(@Resultado,@Tabla))
  
  RETURN (@Resultado)
END
GO
--select dbo.fnSincroISTablaSinonimo('VirtualTareaCuenta')

/**************** fnSincroISSincroIDTablaSinonimo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISSincroIDTablaSinonimo') DROP FUNCTION fnSincroISSincroIDTablaSinonimo
GO
CREATE FUNCTION fnSincroISSincroIDTablaSinonimo 
	(
	@Tabla					varchar(50),
	@SincroID				int
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			int,
    @TablaSinonimo		varchar(50)
      
  SELECT @Resultado = NULL, @TablaSinonimo = NULL
      
  SELECT @TablaSinonimo = SinonimoTabla FROM SincroISTablaSinonimo WHERE Tabla = @Tabla    
  
  IF @TablaSinonimo IS NOT NULL
    SELECT @Resultado = CONVERT(int,SincroID) FROM SysTabla WHERE SysTabla = @TablaSinonimo
  
  SET @Resultado = ISNULL(@Resultado,CONVERT(int,@SincroID))
  
  RETURN (@Resultado)
END
GO

--DECLARE @Timestamp int
--SELECT @TimeStamp = CONVERT(int,SincroID) FROM SysTabla WHERE SysTabla = 'VirtualTareaCuenta'
--SELECT convert(timestamp,dbo.fnSincroISSincroIDTablaSinonimo('VirtualTareaCuenta',@TimeStamp))
--select sincroid from systabla where systabla = 'Tarea'

/**************** fnSincroISTablaFiltroEspecial ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISTablaFiltroEspecial') DROP FUNCTION fnSincroISTablaFiltroEspecial
GO
CREATE FUNCTION fnSincroISTablaFiltroEspecial 
	(
	@Tabla					varchar(50) 
	)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255),
    @Expresion	varchar(255),
    @Operador	varchar(50)

  DECLARE crSincroISTablaFiltroEspecial CURSOR FOR
   SELECT ISNULL(Expresion,''), ISNULL(Operador,'')
     FROM SincroISTablaFiltroEspecial
    WHERE Tabla = @Tabla
    ORDER BY Orden

  SET @Resultado = ''
  OPEN crSincroISTablaFiltroEspecial
  FETCH NEXT FROM crSincroISTablaFiltroEspecial INTO @Expresion, @Operador
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Resultado = LTRIM(@Resultado) + @Operador + CASE WHEN NULLIF(@Operador,'') IS NOT NULL THEN ' ' + @Expresion ELSE @Expresion END + ' ' 
    FETCH NEXT FROM crSincroISTablaFiltroEspecial INTO @Expresion, @Operador
  END
  CLOSE crSincroISTablaFiltroEspecial
  DEALLOCATE crSincroISTablaFiltroEspecial

  IF NULLIF(@Resultado,'') IS NOT NULL
    SET @Resultado = '(' + RTRIM(@Resultado) + ')'

  SET @Resultado = ISNULL(@Resultado,'')
      
  RETURN (@Resultado)
END
GO
--select dbo.fnSincroISTablaFiltroEspecial('VirtualTareaCuenta')

/***************************************** fnSincroISMovSucursal ************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISMovSucursal') DROP FUNCTION fnSincroISMovSucursal --MEJORAMOVFLUJO
GO
CREATE FUNCTION fnSincroISMovSucursal (@Modulo varchar(5), @ID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal	int
  
  SELECT @Sucursal = NULL
    
  IF @Modulo = 'VTAS'  SELECT @Sucursal = Sucursal   FROM Venta        WHERE ID = @ID ELSE 
  IF @Modulo = 'COMS'  SELECT @Sucursal = Sucursal   FROM Compra       WHERE ID = @ID ELSE   
  IF @Modulo = 'ST'    SELECT @Sucursal = Sucursal   FROM Soporte      WHERE ID = @ID ELSE     
  IF @Modulo = 'EMB'   SELECT @Sucursal = Sucursal   FROM Embarque     WHERE ID = @ID ELSE     
  IF @Modulo = 'DIN'   SELECT @Sucursal = Sucursal   FROM Dinero       WHERE ID = @ID ELSE       
  IF @Modulo = 'AF'    SELECT @Sucursal = Sucursal   FROM ActivoFijo   WHERE ID = @ID ELSE         
  IF @Modulo = 'NOM'   SELECT @Sucursal = Sucursal   FROM Nomina       WHERE ID = @ID ELSE           
  IF @Modulo = 'ASIS'  SELECT @Sucursal = Sucursal   FROM Asiste       WHERE ID = @ID ELSE           
  IF @Modulo = 'GAS'   SELECT @Sucursal = Sucursal   FROM Gasto        WHERE ID = @ID ELSE           
  IF @Modulo = 'CAP'   SELECT @Sucursal = Sucursal   FROM Capital      WHERE ID = @ID ELSE           
  IF @Modulo = 'CAM'   SELECT @Sucursal = Sucursal   FROM Cambio       WHERE ID = @ID ELSE           
  IF @Modulo = 'PROY'  SELECT @Sucursal = Sucursal   FROM Proyecto     WHERE ID = @ID ELSE           
  IF @Modulo = 'INC'   SELECT @Sucursal = Sucursal   FROM Incidencia   WHERE ID = @ID ELSE           
  IF @Modulo = 'CONC'  SELECT @Sucursal = Sucursal   FROM Conciliacion WHERE ID = @ID ELSE           
  IF @Modulo = 'PPTO'  SELECT @Sucursal = Sucursal   FROM Presup       WHERE ID = @ID ELSE                 
  IF @Modulo = 'CREDI' SELECT @Sucursal = Sucursal   FROM Credito      WHERE ID = @ID ELSE                 
  IF @Modulo = 'CMP'   SELECT @Sucursal = Sucursal   FROM Campana      WHERE ID = @ID ELSE                 
  IF @Modulo = 'FIS'   SELECT @Sucursal = Sucursal   FROM Fiscal       WHERE ID = @ID ELSE                     
  --REQ25014
  IF @Modulo = 'CONTP' SELECT @Sucursal = Sucursal   FROM ContParalela WHERE ID = @ID ELSE                     
  --REQ16092
  IF @Modulo = 'OPORT' SELECT @Sucursal = Sucursal   FROM Oportunidad  WHERE ID = @ID ELSE                     
  IF @Modulo = 'CORTE' SELECT @Sucursal = Sucursal   FROM Corte        WHERE ID = @ID ELSE                       
  IF @Modulo = 'ORG'   SELECT @Sucursal = Sucursal   FROM Organiza     WHERE ID = @ID ELSE                     
  IF @Modulo = 'RE'    SELECT @Sucursal = Sucursal   FROM Recluta      WHERE ID = @ID ELSE                     
  IF @Modulo = 'FRM'   SELECT @Sucursal = Sucursal   FROM FormaExtra   WHERE ID = @ID ELSE                     
  IF @Modulo = 'CAPT'  SELECT @Sucursal = Sucursal   FROM Captura      WHERE ID = @ID ELSE                     
  IF @Modulo = 'GES'   SELECT @Sucursal = Sucursal   FROM Gestion      WHERE ID = @ID ELSE                     
  IF @Modulo = 'OFER'  SELECT @Sucursal = Sucursal   FROM Oferta       WHERE ID = @ID ELSE                     
  IF @Modulo = 'PACTO' SELECT @Sucursal = Sucursal   FROM Contrato     WHERE ID = @ID ELSE                     
  IF @Modulo = 'CXP'   SELECT @Sucursal = Sucursal   FROM Cxp          WHERE ID = @ID ELSE                     
  IF @Modulo = 'TMA'   SELECT @Sucursal = Sucursal   FROM TMA          WHERE ID = @ID ELSE                     
  IF @Modulo = 'AGENT' SELECT @Sucursal = Sucursal   FROM AGENT        WHERE ID = @ID ELSE                       
  IF @Modulo = 'ISL'   SELECT @Sucursal = Sucursal    FROM ISL          WHERE ID = @ID ELSE                               
  IF @Modulo = 'PROD'  SELECT @Sucursal = Sucursal    FROM PROD         WHERE ID = @ID ELSE                               
  IF @Modulo = 'CONT'  SELECT @Sucursal = Sucursal    FROM CONT         WHERE ID = @ID ELSE                               
  IF @Modulo = 'CP'    SELECT @Sucursal = Sucursal    FROM CP           WHERE ID = @ID ELSE                               
  IF @Modulo = 'PC'    SELECT @Sucursal = Sucursal    FROM PC           WHERE ID = @ID ELSE                               
  IF @Modulo = 'RH'    SELECT @Sucursal = Sucursal    FROM RH           WHERE ID = @ID ELSE                               
  IF @Modulo = 'CXC'   SELECT @Sucursal = Sucursal    FROM CXC          WHERE ID = @ID ELSE                               
  IF @Modulo = 'VALE'  SELECT @Sucursal = Sucursal    FROM VALE         WHERE ID = @ID ELSE                               
  IF @Modulo = 'RSS'   SELECT @Sucursal = Sucursal    FROM RSS          WHERE ID = @ID ELSE                               
  IF @Modulo = 'CR'    SELECT @Sucursal = Sucursal    FROM CR           WHERE ID = @ID ELSE                               
  IF @Modulo = 'INV'   SELECT @Sucursal = Sucursal    FROM INV          WHERE ID = @ID 
  ELSE SET @Sucursal = NULL

  
  RETURN (@Sucursal)
END
GO

/***************************************** fnSincroISMovTabla ************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISMovTabla') DROP FUNCTION fnSincroISMovTabla
GO
CREATE FUNCTION fnSincroISMovTabla (@Modulo char(5))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(50)
  SELECT @Tabla = NULL
  SELECT @Tabla = CASE @Modulo 
    WHEN 'VTAS'  THEN 'Venta' 
    WHEN 'COMS'  THEN 'Compra'
    WHEN 'ST'    THEN 'Soporte'
    WHEN 'EMB'   THEN 'Embarque'
    WHEN 'DIN'   THEN 'Dinero' 
    WHEN 'AF'    THEN 'ActivoFijo'
    WHEN 'NOM'   THEN 'Nomina'
    WHEN 'ASIS'  THEN 'Asiste'
    WHEN 'GAS'   THEN 'Gasto'
    WHEN 'CAP'   THEN 'Capital'
    WHEN 'CAM'   THEN 'Cambio'
    WHEN 'PROY'  THEN 'Proyecto'
    WHEN 'INC'   THEN 'Incidencia'
    WHEN 'CONC'  THEN 'Conciliacion'
    WHEN 'PPTO'  THEN 'Presup'
    WHEN 'CREDI' THEN 'Credito'
    WHEN 'CMP'   THEN 'Campana'
    WHEN 'FIS'   THEN 'Fiscal'
    --REQ25014
    WHEN 'CONTP'   THEN 'ContParalela'
    --REQ16092
	WHEN 'OPORT' THEN 'Oportunidad'	
    WHEN 'CORTE' THEN 'Corte'    
    --WHEN 'MEX01' THEN 'ModuloExtra01'
    --WHEN 'MEX02' THEN 'ModuloExtra02'
    --WHEN 'MEX03' THEN 'ModuloExtra03'
    --WHEN 'MEX04' THEN 'ModuloExtra04'
    --WHEN 'MEX05' THEN 'ModuloExtra05'
    --WHEN 'MEX06' THEN 'ModuloExtra06'
    --WHEN 'MEX07' THEN 'ModuloExtra07'
    --WHEN 'MEX08' THEN 'ModuloExtra08'
    --WHEN 'MEX09' THEN 'ModuloExtra09'
    WHEN 'ORG'   THEN 'Organiza'
    WHEN 'RE'	 THEN 'Recluta'
    WHEN 'FRM'   THEN 'FormaExtra'
    WHEN 'CAPT'  THEN 'Captura'
    WHEN 'GES'   THEN 'Gestion'
    WHEN 'OFER'  THEN 'Oferta'
    WHEN 'PACTO' THEN 'Contrato'
    WHEN 'CXP'   THEN 'CXP'   
    WHEN 'TMA'	 THEN 'TMA'	 
    WHEN 'AGENT' THEN 'AGENT' 
    WHEN 'ISL'	 THEN 'ISL'	 
    WHEN 'PROD'	 THEN 'PROD'	 
    WHEN 'CONT'	 THEN 'CONT'	 
    WHEN 'CP'	 THEN 'CP'	 
    WHEN 'PC'    THEN 'PC'    
    WHEN 'RH'	 THEN 'RH'	 
    WHEN 'CXC'	 THEN 'CXC'	 
    WHEN 'VALE'	 THEN 'VALE'	 
    WHEN 'RSS'	 THEN 'RSS'	 
    WHEN 'CR'	 THEN 'CR'	 
    WHEN 'INV'	 THEN 'INV'	     
    WHEN 'PRECI' THEN 'Precio'
    WHEN 'SIS01' THEN 'AroEventoPerdida'	         
    WHEN 'SIS02' THEN 'AroRiesgoEvaluacion'	             
    WHEN 'SIS03' THEN 'ArtMaterialHist'	                 
    WHEN 'SIS04' THEN 'GRP_Presupuesto'	                     
    WHEN 'SIS05' THEN 'MovSituacion'	                         
    WHEN 'SIS06' THEN 'PlantillaOffice'	                             
    WHEN 'SIS07' THEN 'CteCto'	                                 
    WHEN 'SIS08' THEN 'Tarea'
    WHEN 'SIS09' THEN 'NomX'  
    WHEN 'SIS10' THEN 'eDocD'
    WHEN 'SIS11' THEN 'ContX'	                                                 
    WHEN 'SIS12' THEN 'Evento'	
    WHEN 'SIS13' THEN 'EmbarqueMov'                                                                                                                  	                                                       	                                     
    ELSE @Modulo
  END
  
  RETURN (@Tabla)
END
GO

/****** SincroISSesion ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISSesion') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISSesion')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISSesion') and type = 'U') 
CREATE TABLE dbo.SincroISSesion (
	SPID					int				NOT NULL DEFAULT @@SPID,
	
	Usuario					varchar(10)		NOT NULL,

	CONSTRAINT priSincroISSesion PRIMARY KEY CLUSTERED (SPID)
)
GO

/****** SincroISTransmisorSucursal ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISTransmisorSucursal') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISTransmisorSucursal')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISTransmisorSucursal') and type = 'U') 
CREATE TABLE dbo.SincroISTransmisorSucursal (
	Sucursal				int				NOT NULL,
	
	Servidor				varchar(50)		NOT NULL,	
	BaseDatosNombre			varchar(50)		NOT NULL,

	CONSTRAINT priSincroISTransmisorSucursal PRIMARY KEY CLUSTERED (Sucursal)
)
GO
-- 11325
EXEC spALTER_TABLE 'SincroISTransmisorSucursal', 'SincroISDropBox', 'bit NULL DEFAULT 1 WITH VALUES'
GO

EXEC spALTER_TABLE 'SincroISTransmisorSucursal', 'HabilitarCompresion', 'bit NOT NULL DEFAULT 0' -- REQ12766
GO

/****** SincroISGUIDRecibido ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISGUIDRecibido') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISGUIDRecibido')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISGUIDRecibido') and type = 'U') 
CREATE TABLE dbo.SincroISGUIDRecibido (
	SincroGUIDRecibido				uniqueidentifier	NOT NULL,	

	CONSTRAINT priSincroISGUIDRecibido PRIMARY KEY CLUSTERED (SincroGUIDRecibido)
)
GO

/****** SincroISRetraso ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISRetraso') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISRetraso')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISRetraso') and type = 'U') 
CREATE TABLE dbo.SincroISRetraso (
	Hora					varchar(5)			NOT NULL,	
	
	Retraso					float				NULL,

	CONSTRAINT priSincroISRetraso PRIMARY KEY CLUSTERED (Hora)
)
GO

/****** SincroISSucursalRetraso ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISSucursalRetraso') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISSucursalRetraso')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISSucursalRetraso') and type = 'U') 
CREATE TABLE dbo.SincroISSucursalRetraso (
	Sucursal				int					NOT NULL,
	Hora					varchar(5)			NOT NULL,
		
	Retraso					float				NULL,

	CONSTRAINT priSincroISSucursalRetraso PRIMARY KEY CLUSTERED (Sucursal, Hora)
)
GO

/****** SincroISGUIDSesion ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISGUIDSesion') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISGUIDSesion')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISGUIDSesion') and type = 'U') 
CREATE TABLE dbo.SincroISGUIDSesion (
	SPID					int					NOT NULL DEFAULT @@SPID,	
	SincroGUID				uniqueidentifier	NOT NULL

	CONSTRAINT priSincroISGUIDSesion PRIMARY KEY CLUSTERED (SincroGUID, SPID)
)
GO

EXEC spADD_INDEX 'SincroISGUIDSesion', 'SPID_SincroGUID', 'SPID, SincroGUID'
GO


-- drop table SincroISOk
/****** SincroISOk ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISOk') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISOk')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISOk') and type = 'U') 
CREATE TABLE dbo.SincroISOk (
	Conversacion		uniqueidentifier	NOT NULL,

	Fecha				datetime			NULL	DEFAULT GETDATE(),
	TipoMensaje			varchar(255)		NULL,
	Datos				xml					NULL,	
	DatosRef			varchar(max)		NULL,

	Ok					int					NULL,
	OkRef				varchar(255)		NULL,

	CONSTRAINT priSincroISOk PRIMARY KEY CLUSTERED (Conversacion)
)
GO
EXEC spADD_INDEX 'SincroISOk', 'Fecha', 'Fecha'
GO
--INTELISISSERVICELOG
-- drop table SincroISBaja
/****** SincroISBaja ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISBaja') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISBaja')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISBaja') and type = 'U') 
CREATE TABLE dbo.SincroISBaja (
	Tabla			varchar(100) 		NOT NULL,
	SincroID		timestamp		NOT NULL,

	Llave			xml			NOT NULL,

	CONSTRAINT priSincroISBaja PRIMARY KEY CLUSTERED (Tabla, SincroID)
)
GO

/****** SincroISControl ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISControl') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISControl')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISControl') and type = 'U') 
CREATE TABLE dbo.SincroISControl (
	SucursalOrigen		int			NOT NULL,
	SucursalDestino		int			NOT NULL,
	SincroID		timestamp		NOT NULL,

	SincroIDAnterior	binary(8)		NULL,
	Conversacion		uniqueidentifier	NULL,
	FechaEnvio		datetime		NULL,

	CONSTRAINT priSincroISControl PRIMARY KEY CLUSTERED (SucursalOrigen, SucursalDestino, SincroID)
)
GO
EXEC spADD_INDEX 'SincroISControl', 'SincroID', 'SincroID'
GO

/****** SincroISIDRemotoControl ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISIDRemotoControl') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISIDRemotoControl')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISIDRemotoControl') and type = 'U') 
CREATE TABLE dbo.SincroISIDRemotoControl (
	SucursalOrigen		int					NOT NULL,
	SucursalDestino		int					NOT NULL,
	SincroID			timestamp			NOT NULL,

	SincroIDAnterior	binary(8)			NULL,
	Conversacion		uniqueidentifier	NULL,
	FechaEnvio		datetime				NULL,

	CONSTRAINT priSincroISIDRemotoControl PRIMARY KEY CLUSTERED (SucursalOrigen, SucursalDestino, SincroID)
)
GO
EXEC spADD_INDEX 'SincroISControl', 'SincroID', 'SincroID'
GO

/****** SincroISLog ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISLog') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISLog')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISLog') and type = 'U') 
CREATE TABLE dbo.SincroISLog (
	RID			int			NOT NULL IDENTITY(1,1),

	Solicitud			uniqueidentifier	NULL,
	Conversacion		uniqueidentifier	NULL,
	Tabla				varchar(100) 		NULL,
	PaqueteCambios		int					NULL,
	PaqueteBajas		int					NULL,
	SucursalOrigen		int					NULL,
	SucursalDestino		int					NULL,
	FechaEnvio			datetime			NULL,
	FechaRecibo			datetime			NULL,

	CONSTRAINT priSincroISLog PRIMARY KEY CLUSTERED (RID)
)
GO
EXEC spALTER_TABLE 'SincroISLog', 'PaqueteCambios', 'int NULL'
EXEC spALTER_TABLE 'SincroISLog', 'PaqueteBajas', 'int	NULL'
GO

--EXEC spDROP_TABLE 'SincroISSolicitud'
/****** SincroISSolicitud ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISSolicitud') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISSolicitud')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISSolicitud') and type = 'U') 
CREATE TABLE dbo.SincroISSolicitud (
	Solicitud			uniqueidentifier	NOT NULL,

	Tipo				varchar(100)		NULL,
	SucursalOrigen		int				NULL,
	SucursalDestino		int				NULL,
	FechaEnvio			datetime		NULL,
	FechaRecibo			datetime		NULL,	
	FechaConclusion		datetime		NULL,
	Estatus				varchar(15)		NULL,

	CONSTRAINT priSincroISSolicitud PRIMARY KEY CLUSTERED (Solicitud)
)
GO
EXEC spDROP_COLUMN 'SincroISSolicitud', 'FechaSolicitud'
GO
EXEC spALTER_TABLE 'SincroISSolicitud', 'FechaConclusion', 'datetime NULL'
GO
EXEC spADD_INDEX 'SincroISSolicitud', 'Estatus', 'SucursalOrigen, SucursalDestino, Tipo, Estatus, Solicitud'
GO

/****** SincroISNoRebote ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISNoRebote') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISNoRebote')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISNoRebote') and type = 'U') 
CREATE TABLE dbo.SincroISNoRebote (
	SincroID		binary(8)		NOT NULL,
	Sucursal		int				NOT NULL,

	CONSTRAINT priSincroISNoRebote PRIMARY KEY CLUSTERED (SincroID, Sucursal)
)
GO

-- drop table IDLocal
/****** IDLocal ******/
if not exists (select * from SysTabla where SysTabla = 'IDLocal') 
INSERT INTO SysTabla (SysTabla) VALUES ('IDLocal')
if not exists (select * from sysobjects where id = object_id('dbo.IDLocal') and type = 'U') 
CREATE TABLE dbo.IDLocal (
	Tabla				varchar(100)		NOT NULL,
	SucursalRemota		int					NOT NULL,
	IDRemoto			int					NOT NULL,

	SucursalLocal		int					NOT NULL,
	IDLocal				int					NOT NULL,
	RegistroTemporal	uniqueidentifier	NULL,

	CONSTRAINT priIDLocal PRIMARY KEY CLUSTERED (IDRemoto, Tabla, SucursalRemota)
)
GO
EXEC spADD_INDEX 'IDLocal', 'IDLocal', 'IDLocal, Tabla, SucursalLocal'
EXEC spADD_INDEX 'IDLocal', 'IDLocal_IDR', 'IDRemoto, Tabla, SucursalRemota'
GO

EXEC spALTER_TABLE 'IDLocal', 'RegistroTemporal', 'uniqueidentifier NULL'
GO

/****** IDRemoto ******/
if not exists (select * from SysTabla where SysTabla = 'IDRemoto') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IDRemoto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.IDRemoto') and type = 'U') 
CREATE TABLE dbo.IDRemoto (
	Tabla				varchar(100)		NOT NULL,
	SucursalRemota		int					NOT NULL,
	IDRemoto			int					NOT NULL,

	SucursalLocal		int					NOT NULL,
	IDLocal				int					NOT NULL,

	CONSTRAINT priIDRemoto PRIMARY KEY CLUSTERED (IDRemoto, Tabla, SucursalRemota)
)
GO
EXEC spADD_INDEX 'IDRemoto', 'IDRemoto', 'IDLocal, Tabla, SucursalLocal'
EXEC spADD_INDEX 'IDRemoto', 'IDRemoto2', 'IDLocal, Tabla, SucursalLocal'
GO

/****** SincroISTablaEstructura ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISTablaEstructura') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISTablaEstructura')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISTablaEstructura') and type = 'U') 
CREATE TABLE dbo.SincroISTablaEstructura (
    SPID				int				NOT NULL,
    Tabla				varchar(100)	NOT NULL,
	RID					int				NOT NULL IDENTITY(1,1),

    Modulo				varchar(5)		NULL,
    CampoModulo			varchar(100)	NULL,    
    Campo				varchar(100)	NULL,
    SucursalRemota		int				NULL,
    SELECT_IDLocal		varchar(max)	NULL,
    
	CONSTRAINT priSincroISTablaEstructura PRIMARY KEY CLUSTERED (SPID, Tabla, RID)
)
GO

/****** SincroISInsertarEncabezado ******/
if not exists (select * from SysTabla where SysTabla = 'SincroISInsertarEncabezado') 
INSERT INTO SysTabla (SysTabla) VALUES ('SincroISInsertarEncabezado')
if not exists (select * from sysobjects where id = object_id('dbo.SincroISInsertarEncabezado') and type = 'U') 
CREATE TABLE dbo.SincroISInsertarEncabezado (
    SPID				int				NOT NULL,
    Tabla				varchar(100)	NOT NULL,
	RID					int				NOT NULL IDENTITY(1,1),

	Modulo				varchar(5)		NULL,
	Empresa				varchar(5)		NULL,
	Usuario				varchar(10)		NULL,
	IDRemoto			int				NULL,
	SucursalRemota		int				NULL,
	SucursalLocal		int				NULL,		
    
	CONSTRAINT priSincroISInsertarEncabezado PRIMARY KEY CLUSTERED (SPID, Tabla, RID)
)
GO

/*** VerSincroISOk ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroISOk') and type = 'V') drop view dbo.VerSincroISOk
GO
CREATE VIEW VerSincroISOk
--//WITH ENCRYPTION
AS
SELECT CONVERT(varchar(36), Conversacion) AS Conversacion,
       Fecha,
       TipoMensaje,
       CONVERT(varchar(max), Datos) AS Datos,
       DatosRef,
       Ok,
       OkRef
  FROM SincroISOk
GO     

/*** IntelisisServiceBorrador ***/
if exists (select * from sysobjects where id = object_id('dbo.IntelisisServiceBorrador') and type = 'V') drop view dbo.IntelisisServiceBorrador
GO
CREATE VIEW IntelisisServiceBorrador
--//WITH ENCRYPTION
AS
SELECT 
    iss.ID,
    iss.Sistema,
    iss.Contenido,
    iss.Referencia,
    iss.SubReferencia,
    iss.Version,
    iss.Usuario,
    iss.Solicitud,
    iss.Resultado,
    iss.Estatus,
    iss.FechaEstatus,
    iss.Ok,
    iss.OkRef, 
    iss.SucursalOrigen,
    iss.SucursalDestino   
  FROM IntelisisService iss JOIN IntelisisService is1
    ON is1.Conversacion = iss.Conversacion JOIN Version
    ON 1 = 1
 WHERE is1.SubReferencia = 'SincroFinal' 
   AND is1.Estatus = 'BORRADOR'
   AND iss.SucursalDestino <> Version.Sucursal
   AND is1.SucursalDestino <> Version.Sucursal
GO

/*** VerSincroISLog ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroISLog') and type = 'V') drop view dbo.VerSincroISLog
GO
CREATE VIEW VerSincroISLog
--//WITH ENCRYPTION
AS
SELECT RID,
       CONVERT(varchar(36), Solicitud) AS Solicitud,
       CONVERT(varchar(36), Conversacion) AS Conversacion,
       'ConversacionTabla' = Tabla,
       PaqueteCambios,
       PaqueteBajas,
       SucursalOrigen,
       SucursalDestino,
       FechaEnvio,
       FechaRecibo
  FROM SincroISLog
GO     

/*** VerSincroISSolicitud ***/
if exists (select * from sysobjects where id = object_id('dbo.VerSincroISSolicitud') and type = 'V') drop view dbo.VerSincroISSolicitud
GO
CREATE VIEW VerSincroISSolicitud
--//WITH ENCRYPTION
AS
SELECT CONVERT(varchar(36), Solicitud) AS Solicitud,
       Tipo,
       SucursalOrigen,
       SucursalDestino,
       FechaEnvio,
       FechaRecibo,
       Estatus
  FROM SincroISSolicitud
GO     

/**************** fnSincroISTablaConMovimientos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISTablaConMovimientos') DROP FUNCTION dbo.fnSincroISTablaConMovimientos
GO
CREATE FUNCTION dbo.fnSincroISTablaConMovimientos 
	(
	@Tabla				varchar(50)
	)
RETURNS nvarchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				nvarchar(100),
	@ID						int,
	@TipoCampo				int,
	@Campo					varchar(50)
  
  SET @Campo = 'TIENEMOVIMIENTOS'
  SELECT @ID = ID FROM SysObjects WHERE ID = OBJECT_ID('dbo.' + RTRIM(LTRIM(@Tabla))) AND type IN ('U')
  SELECT @TipoCampo = XType FROM SysColumns WHERE ID = @ID AND RTRIM(LTRIM(UPPER([Name]))) = RTRIM(LTRIM(@Campo))     

  IF @TipoCampo = 104
    SET @Resultado = N' AND ISNULL(' + RTRIM(LTRIM(@Tabla)) + N'.TieneMovimientos,0) = 0'
  ELSE
    SET @Resultado = ''
          
  RETURN (@Resultado)
END
GO

--select dbo.fnSincroISTablaConMovimientos('Art')

/**************** fnTablaTipoMovimiento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTablaTipoMovimiento') DROP FUNCTION dbo.fnTablaTipoMovimiento
GO
CREATE FUNCTION dbo.fnTablaTipoMovimiento 
	(
	@Tabla				varchar(50)
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tipo					int
    
  SELECT @Tipo = 0  
  IF dbo.fnIDLocalTablaModulo(@Tabla) IS NOT NULL SELECT @Tipo = 1
  IF @Tipo = 0 AND EXISTS(SELECT * FROM SysColumns WHERE Name LIKE '%Modulo%' AND Length = 5 AND xType IN (167,175) AND ID = OBJECT_ID(@Tabla)) AND EXISTS(SELECT * FROM SysColumns WHERE Name IN ('ID', 'ModuloID', 'OID', 'DID') AND xType = 56 AND ID = OBJECT_ID(@Tabla)) SELECT @Tipo = 2
  RETURN (@Tipo)
END
GO

/**************** fnVerificarEncabezadoModulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVerificarEncabezadoModulo') DROP FUNCTION dbo.fnVerificarEncabezadoModulo
GO
CREATE FUNCTION dbo.fnVerificarEncabezadoModulo 
	(
	@ID					int,
	@Modulo				varchar(5)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				bit
    
  SELECT @Resultado = 0

  IF @Modulo = 'VTAS'  IF EXISTS(SELECT ID FROM Venta        WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'COMS'  IF EXISTS(SELECT ID FROM Compra       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'ST'    IF EXISTS(SELECT ID FROM Soporte      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'EMB'   IF EXISTS(SELECT ID FROM Embarque     WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'DIN'   IF EXISTS(SELECT ID FROM Dinero       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE 
  IF @Modulo = 'AF'    IF EXISTS(SELECT ID FROM ActivoFijo   WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'NOM'   IF EXISTS(SELECT ID FROM Nomina       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'ASIS'  IF EXISTS(SELECT ID FROM Asiste       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'GAS'   IF EXISTS(SELECT ID FROM Gasto        WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CAP'   IF EXISTS(SELECT ID FROM Capital      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CAM'   IF EXISTS(SELECT ID FROM Cambio       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'PROY'  IF EXISTS(SELECT ID FROM Proyecto     WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'INC'   IF EXISTS(SELECT ID FROM Incidencia   WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CONC'  IF EXISTS(SELECT ID FROM Conciliacion WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'PPTO'  IF EXISTS(SELECT ID FROM Presup       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CREDI' IF EXISTS(SELECT ID FROM Credito      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CMP'   IF EXISTS(SELECT ID FROM Campana      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'FIS'   IF EXISTS(SELECT ID FROM Fiscal       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  --REQ25014
  IF @Modulo = 'CONTP' IF EXISTS(SELECT ID FROM ContParalela WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  --REQ16092
  IF @Modulo = 'OPORT' IF EXISTS(SELECT ID FROM Oportunidad  WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE  
  IF @Modulo = 'CORTE' IF EXISTS(SELECT ID FROM Corte        WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE  
  IF @Modulo = 'ORG'   IF EXISTS(SELECT ID FROM Organiza     WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'RE'	   IF EXISTS(SELECT ID FROM Recluta      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'FRM'   IF EXISTS(SELECT ID FROM FormaExtra   WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CAPT'  IF EXISTS(SELECT ID FROM Captura      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'GES'   IF EXISTS(SELECT ID FROM Gestion      WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'OFER'  IF EXISTS(SELECT ID FROM Oferta       WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'PACTO' IF EXISTS(SELECT ID FROM Contrato     WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'CXC'   IF EXISTS(SELECT ID FROM Cxc          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE  
  IF @Modulo = 'CXP'   IF EXISTS(SELECT ID FROM Cxp          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE        
  IF @Modulo = 'INV'   IF EXISTS(SELECT ID FROM Inv          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'AGENT' IF EXISTS(SELECT ID FROM Agent        WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE
  IF @Modulo = 'PROD'  IF EXISTS(SELECT ID FROM Prod         WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE   
  IF @Modulo = 'CONT'  IF EXISTS(SELECT ID FROM Cont         WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'CP'    IF EXISTS(SELECT ID FROM CP           WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'CR'    IF EXISTS(SELECT ID FROM CR           WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'ISL'   IF EXISTS(SELECT ID FROM ISL          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'PC'    IF EXISTS(SELECT ID FROM PC           WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'RH'    IF EXISTS(SELECT ID FROM RH           WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'RSS'   IF EXISTS(SELECT ID FROM RSS          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'TMA'   IF EXISTS(SELECT ID FROM TMA          WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 ELSE    
  IF @Modulo = 'VALE'  IF EXISTS(SELECT ID FROM Vale         WHERE ID = @ID) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
  
  RETURN (@Resultado)
END
GO

--/**************** fnObjetoCorriendo ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnObjetoCorriendo') DROP FUNCTION fnObjetoCorriendo
--GO
--CREATE FUNCTION fnObjetoCorriendo 
--	(
--	@Procedimiento				varchar(100)
--	)
--RETURNS bit
----//WITH ENCRYPTION
--AS BEGIN
--  DECLARE
--    @Resultado	bit

--  SELECT @Resultado = 0
--  IF NULLIF(@Procedimiento,'') IS NOT NULL
--  BEGIN
--    IF EXISTS(SELECT ssp.SPID FROM sys.sysprocesses ssp JOIN sys.sysdatabases sdb ON sdb.[dbid] = ssp.[dbid] WHERE ssp.SPID <> @@SPID AND NULLIF(PATINDEX('%' + @Procedimiento + '%',OBJECT_NAME((SELECT ObjectID FROM sys.dm_exec_sql_text(ssp.sql_handle)))),0) IS NOT NULL AND sdb.name = DB_NAME()) 
--      SELECT @Resultado = 1
--  END 
    
--  RETURN (@Resultado)
--END
--GO

/**************** fnInformacionContexto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnInformacionContexto') DROP FUNCTION fnInformacionContexto
GO
CREATE FUNCTION fnInformacionContexto 
	(
	@bit				varchar(100)
	)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus		bit,
    @DosBigint		bigint
    
  SET @Estatus = 0
  SET @DosBigint = 2
    
  IF @bit = 'SINCROIS' AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,0))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'CRM'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,1))  <> 0 SET @Estatus = 1 ELSE --REQ 13389
  IF @bit = 'ECOMMERCE'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,2))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB4'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,3))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB5'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,4))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB6'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,5))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB7'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,6))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB8'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,7))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB9'     AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,8))  <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB10'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,9))  <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB11'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,10)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB12'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,11)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB13'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,12)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB14'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,13)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB15'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,14)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB16'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,15)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB17'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,16)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB18'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,17)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB19'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,18)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB20'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,19)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB21'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,20)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB22'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,21)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB23'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,22)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB24'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,23)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB25'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,24)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB26'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,25)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB27'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,26)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB28'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,27)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB29'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,28)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB30'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,29)) <> 0 SET @Estatus = 1 ELSE  
  IF @bit = 'LSB31'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,30)) <> 0 SET @Estatus = 1 ELSE
  IF @bit = 'LSB32'    AND (CONVERT(varbinary(8),CONTEXT_INFO()) & POWER(@DosBigint,31)) <> 0 SET @Estatus = 1 
  
  RETURN (@Estatus)
END
GO

/**************** spSetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSetInformacionContexto') and type = 'P') drop procedure dbo.spSetInformacionContexto
GO             
CREATE PROCEDURE spSetInformacionContexto
		@bit		varchar(50),
		@Accion		bit = 1

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InformacionContexto		bigint,
    @DosBigint					bigint,
    @MiContext_Info				varbinary(128)
    
  SELECT @DosBigint = 2
    
  SET @InformacionContexto = ISNULL(CONVERT(int,CONVERT(varbinary(8),CONTEXT_INFO())), 0)
  IF @bit = 'SINCROIS'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,0) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,0)
  END ELSE 
  IF @bit = 'CRM' --REQ 13389
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,1) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,1)
  END ELSE  
  IF @bit = 'ECOMMERCE'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,2) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,2)
  END ELSE  
  IF @bit = 'LSB4'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,3) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,3)
  END ELSE  
  IF @bit = 'LSB5'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,4) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,4)
  END ELSE  
  IF @bit = 'LSB6'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,5) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,5)
  END ELSE  
  IF @bit = 'LSB7'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,6) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,6)
  END ELSE  
  IF @bit = 'LSB8'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,7) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,7)
  END ELSE  

  IF @bit = 'LSB9'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,8) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,8)
  END ELSE 
  IF @bit = 'LSB10'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,9) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,9)
  END ELSE  
  IF @bit = 'LSB11'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,10) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,10)
  END ELSE  
  IF @bit = 'LSB12'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,11) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,11)
  END ELSE  
  IF @bit = 'LSB13'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,12) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,12)
  END ELSE  
  IF @bit = 'LSB14'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,13) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,13)
  END ELSE  
  IF @bit = 'LSB15'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,14) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,14)
  END ELSE  
  IF @bit = 'LSB16'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,15) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,15)
  END ELSE  
  IF @bit = 'LSB17'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,16) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,16)
  END ELSE 
  IF @bit = 'LSB18'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,17) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,17)
  END ELSE  
  IF @bit = 'LSB19'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,18) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,18)
  END ELSE  
  IF @bit = 'LSB20'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,19) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,19)
  END ELSE  
  IF @bit = 'LSB21'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,20) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,20)
  END ELSE  
  IF @bit = 'LSB22'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,21) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,21)
  END ELSE  
  IF @bit = 'LSB23'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,22) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,22)
  END ELSE  
  IF @bit = 'LSB24'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,23) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,23)
  END ELSE  
  IF @bit = 'LSB25'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,24) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,24)
  END ELSE 
  IF @bit = 'LSB26'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,25) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,25)
  END ELSE  
  IF @bit = 'LSB27'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,26) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,26)
  END ELSE  
  IF @bit = 'LSB28'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,27) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,27)
  END ELSE  
  IF @bit = 'LSB29'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,28) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,28)
  END ELSE  
  IF @bit = 'LSB30'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,29) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,29)
  END ELSE  
  IF @bit = 'LSB31'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,30) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,30)
  END ELSE  
  IF @bit = 'LSB32'
  BEGIN
    IF @Accion = 1 AND dbo.fnInformacionContexto(@bit) = 0 SET @InformacionContexto = @InformacionContexto + POWER(@DosBigint,31) ELSE
    IF @Accion = 0 AND dbo.fnInformacionContexto(@bit) = 1 SET @InformacionContexto = @InformacionContexto - POWER(@DosBigint,31)
  END
  
  SET @MiContext_Info = ISNULL(CONVERT(varbinary(128),@InformacionContexto),0X0) 
  
  SET Context_Info @MiContext_Info
END
GO

/**************** spResetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spResetInformacionContexto') and type = 'P') drop procedure dbo.spResetInformacionContexto
GO             
CREATE PROCEDURE spResetInformacionContexto
--//WITH ENCRYPTION
AS BEGIN

  SET Context_Info 0x0
END
GO

/**************** spGetInformacionContexto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGetInformacionContexto') and type = 'P') drop procedure dbo.spGetInformacionContexto
GO             
CREATE PROCEDURE spGetInformacionContexto
--//WITH ENCRYPTION
AS BEGIN

  SELECT CONVERT(varbinary(8),Context_Info())
END
GO

/**************** fnEstaSincronizando ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaSincronizando') DROP FUNCTION fnEstaSincronizando
GO
CREATE FUNCTION fnEstaSincronizando ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado bit
    
  SELECT @Resultado = dbo.fnInformacionContexto('SINCROIS')    
  
  RETURN(@Resultado)
END
GO

--REQ 13389
/**************** fnEstaSincronizandoCRM ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaSincronizandoCRM') DROP FUNCTION fnEstaSincronizandoCRM
GO
CREATE FUNCTION fnEstaSincronizandoCRM ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado bit
    
  SELECT @Resultado = dbo.fnInformacionContexto('CRM')    
  
  RETURN(@Resultado)
END
GO

EXEC spSetInformacionContexto 'SINCROIS', 1      
UPDATE Version SET SincroISLongitudPaquete = 99000000
EXEC spSetInformacionContexto 'SINCROIS', 0
      
--EXEC spSetInformacionContexto 'SINCROIS',0
--SELECT dbo.fnEstaSincronizando()
--IF dbo.fnEstaSincronizando() = 1 RETURN

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/**************** fnSincroISRetraso ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISRetraso') DROP FUNCTION fnSincroISRetraso
GO
CREATE FUNCTION fnSincroISRetraso 
	(
	@Sucursal				int
	)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Retraso			datetime,
    @Segundos			float,
    @Ahora				datetime,
    @HoraActual			varchar(2),
    @MinutoActual		varchar(2),
    @TiempoActual		varchar(5),
    @HoraRetraso		varchar(2),
    @MinutoRetraso		varchar(2),
    @SegundoRetraso		varchar(2),
    @CentesimaRetraso	varchar(3),
    @Entero				int,
    @Fraccion			float,
    @HoraSobrante		int,
    @MinutoSobrante		int,
    @SegundoSobrante	int
    
  SET @Retraso = NULL
  SET @Segundos = NULL
    
  SET @Ahora = GETDATE()
  SET @HoraActual = LTRIM(RTRIM(CONVERT(varchar(2),DATEPART(hour,@Ahora))))
  SET @HoraActual = REPLICATE('0',2-LEN(@HoraActual)) + @HoraActual
  SET @MinutoActual = LTRIM(RTRIM(CONVERT(varchar(2),DATEPART(minute,@Ahora))))
  SET @MinutoActual = REPLICATE('0',2-LEN(@MinutoActual)) + @MinutoActual   
  SET @TiempoActual = @HoraActual + ':' + @MinutoActual

  SELECT TOP 1 @Segundos = NULLIF(Retraso,0.0) FROM SincroISSucursalRetraso WHERE Sucursal = @Sucursal AND Hora <= @TiempoActual ORDER BY Sucursal, Hora DESC
  
  IF @Segundos IS NULL SELECT TOP 1 @Segundos = NULLIF(Retraso,0.0) FROM SincroISRetraso WHERE Hora <= @TiempoActual ORDER BY Hora DESC
  
  IF @Segundos IS NOT NULL
  BEGIN
    SET @Entero = FLOOR(@Segundos)
    SET @Fraccion = @Segundos - FLOOR(@Segundos)
        
    --Horas
    SET @HoraRetraso = LTRIM(RTRIM(CONVERT(varchar(2),@Entero / 3600)))
    SET @HoraRetraso = REPLICATE('0',2-LEN(@HoraRetraso)) + @HoraRetraso
    
    --Minutos
    SET @MinutoSobrante = (@Entero - ((@Entero / 3600) * 3600)) / 60
    SET @MinutoRetraso = LTRIM(RTRIM(CONVERT(varchar(2),@MinutoSobrante)))
    SET @MinutoRetraso = REPLICATE('0',2-LEN(@MinutoRetraso)) + @MinutoRetraso

    --Segundos
    SET @SegundoSobrante = @Entero - (((@Entero / 3600) * 3600) + (@MinutoSobrante * 60))
    SET @SegundoRetraso = LTRIM(RTRIM(CONVERT(varchar(2),@SegundoSobrante)))
    SET @SegundoRetraso = REPLICATE('0',2-LEN(@SegundoRetraso)) + @SegundoRetraso

    --Centesima
    SET @CentesimaRetraso = SUBSTRING(LTRIM(RTRIM(CONVERT(varchar,ROUND(@Fraccion,3)))),1,3)
    SET @CentesimaRetraso = SUBSTRING(@CentesimaRetraso,CHARINDEX('.',@CentesimaRetraso)+1,3)
    SET @CentesimaRetraso = @CentesimaRetraso + REPLICATE('0',3-LEN(@CentesimaRetraso))    
    
    SET @Retraso = CONVERT(datetime,'1900-01-01 ' + @HoraRetraso + ':' + @MinutoRetraso + ':' + @SegundoRetraso + '.' + @CentesimaRetraso)
  END
    
  RETURN (@Retraso)
END
GO

/******************************* spSincroISCrearArchivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISCrearArchivo') and type = 'P') drop procedure dbo.spSincroISCrearArchivo
GO             
CREATE PROCEDURE spSincroISCrearArchivo
		@Archivo		varchar(255),
		@XML			varchar(max),
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int

    
  SELECT @ManejadorObjeto = NULL, @IDArchivo = NULL
    
  IF @Ok IS NULL      
    EXEC spCrearArchivo @Archivo, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT    
  
  IF @Ok IS NULL  
    EXEC spInsertaTextoEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  
  
END
GO

/******************************* spSincroISComprimirPaquete *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISComprimirPaquete') and type = 'P') drop procedure dbo.spSincroISComprimirPaquete
GO             
CREATE PROCEDURE spSincroISComprimirPaquete
		@IDPaquete				int,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @XML						varchar(max),
    @SQL						nvarchar(max),
    @RutaCompresor				varchar(1000),
    @Archivo					varchar(1000),
    @ArchivoComprimido			varchar(1000),
    @SucursalOrigen				int,
    @SucursalDestino			int,
    @Transaccion				varchar(100)

    SELECT @XML = Solicitud, @SucursalOrigen = SucursalOrigen, @SucursalDestino = SucursalDestino FROM IntelisisService WHERE ID = @IDPaquete

    IF NULLIF(@XML,'') IS NULL RETURN    

    SELECT @Transaccion = 'spSincroISComprimirPaquete' + RTRIM(LTRIM(CONVERT(varchar,@@SPID)))
    
    BEGIN TRANSACTION @Transaccion
    
    SELECT @RutaCompresor = dbo.fnDirectorioEmpaquetadorArchivos()

    SELECT @Archivo = @RutaCompresor + '\TempSincroISIn_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,@IDPaquete))) + '.xml'   
    SELECT @ArchivoComprimido = @RutaCompresor + '\TempSincroISOut_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,@IDPaquete))) + '.zip'       

    IF @Ok IS NULL                   
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT                 

    IF @Ok IS NULL      
      EXEC spEliminarArchivo @ArchivoComprimido, @Ok OUTPUT, @OkRef OUTPUT                       
          
    EXEC spSincroISCrearArchivo @Archivo, @XML, @Ok OUTPUT, @OkRef OUTPUT
  
    IF @Ok IS NULL 
      EXEC spComprimirArchivo @Archivo, @ArchivoComprimido, @Ok OUTPUT, @OkRef OUTPUT  
      
    IF @Ok IS NULL  
    BEGIN
    
      SET @SQL = N' UPDATE IntelisisService' + 
                 N' SET SolicitudBinario = (SELECT * FROM OPENROWSET(BULK ' + CHAR(39)+ @ArchivoComprimido + CHAR(39) + ',SINGLE_BLOB) AS A) ' + 
                 N' WHERE ID = ' + LTRIM(RTRIM(CONVERT(varchar,@IDPaquete)))
   
      EXEC sp_executesql @SQL
    END   

    IF @Ok IS NULL
      UPDATE IntelisisService SET Solicitud = NULL WHERE ID = @IDPaquete

    IF @Ok IS NULL                   
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT                 

    IF @Ok IS NULL      
      EXEC spEliminarArchivo @ArchivoComprimido, @Ok OUTPUT, @OkRef OUTPUT                       

    IF @Ok IS NULL
      COMMIT TRANSACTION @Transaccion
    ELSE
      ROLLBACK TRANSACTION @Transaccion
              
END
GO

/******************************* spSincroISDescomprimirPaquete *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISDescomprimirPaquete') and type = 'P') drop procedure dbo.spSincroISDescomprimirPaquete
GO             
CREATE PROCEDURE spSincroISDescomprimirPaquete
		@IDPaquete				int,
		@Ok						int = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ManejadorObjeto			int,
    @IDArchivo					int,
    @XML						varchar(max),
    @XMLBinario					varbinary(max),
    @SQL						nvarchar(max),
    @RutaCompresor				varchar(1000),
    @Archivo					varchar(1000),
    @ArchivoComprimido			varchar(1000),
    @SucursalOrigen				int,
    @SucursalDestino			int,
    @Transaccion				varchar(100),
    @ObjectToken				int    

    SELECT @XMLBinario = SolicitudBinario, @SucursalOrigen = SucursalOrigen, @SucursalDestino = SucursalDestino FROM IntelisisService WHERE ID = @IDPaquete

    IF @XMLBinario IS NULL RETURN    

    SELECT @Transaccion = 'spSincroISDescomprimirPaquete' + RTRIM(LTRIM(CONVERT(varchar,@@SPID)))
    
    BEGIN TRANSACTION @Transaccion
    
    SELECT @RutaCompresor = dbo.fnDirectorioEliminarDiagonalFinal(dbo.fnDirectorioEmpaquetadorArchivos())

    SELECT @ArchivoComprimido = @RutaCompresor + '\TempSincroISIn_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,@IDPaquete))) + '.zip'   
    SELECT @Archivo = @RutaCompresor + '\TempSincroISOut_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,0)))) + '_' + RTRIM(LTRIM(CONVERT(varchar,@IDPaquete))) + '.xml'       

    IF @Ok IS NULL                   
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT                 

    IF @Ok IS NULL      
      EXEC spEliminarArchivo @ArchivoComprimido, @Ok OUTPUT, @OkRef OUTPUT                       

    EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT
    EXEC sp_OASetProperty @ObjectToken, 'Type', 1
    EXEC sp_OAMethod @ObjectToken, 'Open'
    EXEC sp_OAMethod @ObjectToken, 'Write', NULL,@XMLBinario
    EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @ArchivoComprimido, 2
    EXEC sp_OAMethod @ObjectToken, 'Close'
    EXEC sp_OADestroy @ObjectToken
  
    IF @Ok IS NULL 
      EXEC spDescomprimirArchivo @ArchivoComprimido, @Archivo, @Ok OUTPUT, @OkRef OUTPUT  

    IF @Ok IS NULL
      EXEC spLeerArchivo @Archivo, @Archivo = @XML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
      
    IF @Ok IS NULL
      UPDATE IntelisisService SET Solicitud = @XML, SolicitudBinario = NULL WHERE ID = @IDPaquete

    IF @Ok IS NULL                   
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT                 

    IF @Ok IS NULL      
      EXEC spEliminarArchivo @ArchivoComprimido, @Ok OUTPUT, @OkRef OUTPUT                       

    IF @Ok IS NULL
      COMMIT TRANSACTION @Transaccion
    ELSE
      ROLLBACK TRANSACTION @Transaccion

END
GO

/**************** spSincroISVerificarEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificarEncabezado') and type = 'P') drop procedure dbo.spSincroISVerificarEncabezado
GO             
CREATE PROCEDURE spSincroISVerificarEncabezado

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SysTabla				varchar(50),
    @Tipo					varchar(20),
    @Modulo					varchar(5),
    @SQL					nvarchar(MAX),
    @JOIN_Encabezado		nvarchar(MAX),
    @WHERE_Encabezado		nvarchar(MAX),    
    @TablaRemota			varchar(50)
    
  DECLARE crSysTabla CURSOR FOR
   SELECT SysTabla, dbo.fnSincroISTablaTipo(SysTabla), Modulo
     FROM SysTabla
    WHERE dbo.fnSincroISTablaTipo(SysTabla) IN ('Movimiento','MovimientoInfo')
      --AND NULLIF(Modulo,'') NOT IN ('MEX01')
      AND SincroActivo = 1
    ORDER BY SysTabla

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  WHILE @@FETCH_STATUS = 0
  BEGIN

    EXEC spSincroISTablaEstructura @SysTabla, @JOIN_Encabezado = @JOIN_Encabezado OUTPUT, @WHERE_Encabezado = @WHERE_Encabezado OUTPUT
    IF NULLIF(@JOIN_Encabezado,'') IS NOT NULL
    BEGIN
      SET @TablaRemota = dbo.fnSincroISMovTabla(@Modulo)

      SELECT @SQL = N'IF EXISTS(SELECT * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL) SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',' + CHAR(39) + @TablaRemota + CHAR(39) + ',* FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL'
      EXEC sp_ExecuteSql @SQL
    END ELSE 
    IF NULLIF(@JOIN_Encabezado,'') IS NULL
    BEGIN
      IF NULLIF(@WHERE_Encabezado,'') IS NOT NULL
      BEGIN
        SELECT @SQL = N'IF EXISTS(SELECT * FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ') SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',* FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ' '
        EXEC sp_ExecuteSql @SQL      
      END
    END 
    FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla
END
GO

/**************** spSincroIS_Activar2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_Activar2') and type = 'P') drop procedure dbo.spSincroIS_Activar2
GO             
CREATE PROCEDURE spSincroIS_Activar2

--//WITH ENCRYPTION
AS BEGIN


  EXEC('if exists (select * from sysobjects where id = object_id(''dbo.spSincroISInsertarEncabezado'') and type = ''P'') drop procedure dbo.spSincroISInsertarEncabezado')

  EXEC('CREATE PROCEDURE spSincroISInsertarEncabezado
		@Modulo			varchar(5),
		@Empresa		varchar(5),
		@Usuario		varchar(10),
		@IDRemoto		int,
		@SucursalRemota	int,
		@SucursalLocal	int,		
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


  --//WITH ENCRYPTION
  AS BEGIN
    DECLARE
      @Mov				varchar(20),
      @Cliente			varchar(10),
      @Articulo			varchar(10),      
      @Proveedor			varchar(10),
      @Agente				varchar(10),
  	  @Condicion			varchar(50),
	  @Moneda				varchar(10),
	  @Almacen			varchar(10),
	  @UsuarioResponsable	varchar(10),
	  @FechaContable		datetime,
	  @Estatus			varchar(15),
	  @Tabla				varchar(100),
	  @IDLocal			int,
	  @SincroGUID			uniqueidentifier,
	  @SincroID				timestamp,
	  @Descripcion			varchar(50)
	   
    -- SET nocount ON

    SET @Mov                = ''Error SincroIS''
    SET @Estatus            = ''ERR SINCRO''
    SET @Cliente            = ''ERR SINCRO''
    SET @Articulo           = ''ERR SINCRO''    
    SET @Proveedor          = ''ERR SINCRO''  
    SET @Agente             = ''ERR SINCRO''
    SET @Condicion          = ''ERR SINCRO''
    SET @Moneda             = ''ERR SINCRO''
    SET @Almacen            = ''ERR SINCRO''  
    SET @Descripcion        = ''ERR SINCRO''      
    SET @FechaContable      = GETDATE()
    SET @UsuarioResponsable = @Usuario

    SET @Tabla = dbo.fnSincroISMovTabla(@Modulo)
    IF EXISTS(SELECT 1 FROM IDLOCAL WHERE IDRemoto = @IDRemoto AND Tabla = @Tabla AND  SucursalRemota = @SucursalRemota) RETURN

    EXEC spSetInformacionContexto ''SINCROIS'', 1    
    IF @Modulo = ''AF'' INSERT ActivoFijo (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''AGENT'' INSERT AGENT (Empresa, Mov, Moneda, Agente, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Agente, @Estatus) ELSE
    IF @Modulo = ''ASIS'' INSERT Asiste (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CAM'' INSERT Cambio (Empresa, Mov, Cliente, Condicion, Estatus) VALUES (@Empresa, @Mov, @Cliente, @Condicion, @Estatus) ELSE
    IF @Modulo = ''CAP'' INSERT Capital (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CAPT'' INSERT Captura (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CMP'' INSERT Campana (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''COMS'' INSERT Compra (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''CONC'' INSERT Conciliacion (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CONT'' INSERT CONT (Empresa, Mov, FechaContable, Moneda, Estatus) VALUES (@Empresa, @Mov, @FechaContable, @Moneda, @Estatus) ELSE
    IF @Modulo = ''CP'' INSERT CP (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CR'' INSERT CR (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''CREDI'' INSERT Credito (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''CXC'' INSERT CXC (Empresa, Mov, Moneda, Cliente, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Cliente, @Estatus) ELSE
    IF @Modulo = ''CXP'' INSERT CXP (Empresa, Mov, Moneda, Proveedor, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Proveedor, @Estatus) ELSE
    IF @Modulo = ''DIN'' INSERT Dinero (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''EMB'' INSERT Embarque (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''FIS'' INSERT Fiscal (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
	--REQ25014
    IF @Modulo = ''CONTP'' INSERT ContParalela (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE    
	--REQ16092
    IF @Modulo = ''OPORT'' INSERT Oportunidad (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE	
    IF @Modulo = ''CORTE''INSERT Corte (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE    
    IF @Modulo = ''FRM'' INSERT FormaExtra (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''GAS'' INSERT Gasto (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''GES'' INSERT Gestion (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''INC'' INSERT Incidencia (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''INV'' INSERT INV (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''ISL'' INSERT ISL (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''NOM'' INSERT Nomina (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''OFER'' INSERT Oferta (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''ORG'' INSERT Organiza (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''PACTO'' INSERT Contrato (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''PC'' INSERT PC (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''PPTO'' INSERT Presup (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''PROD'' INSERT PROD (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''PROY'' INSERT Proyecto (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''RE'' INSERT Recluta (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''RH'' INSERT RH (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''RSS'' INSERT RSS (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''ST'' INSERT Soporte (Empresa, Mov, UsuarioResponsable, Estatus) VALUES (@Empresa, @Mov, @UsuarioResponsable, @Estatus) ELSE
    IF @Modulo = ''TMA'' INSERT TMA (Empresa, Mov, Estatus) VALUES (@Empresa, @Mov, @Estatus) ELSE
    IF @Modulo = ''VALE'' INSERT VALE (Empresa, Mov, Moneda, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Estatus) ELSE
    IF @Modulo = ''VTAS'' INSERT Venta (Empresa, Mov, Moneda, Cliente, Almacen, Estatus) VALUES (@Empresa, @Mov, @Moneda, @Cliente, @Almacen, @Estatus) ELSE
    IF @Modulo = ''PRECI'' INSERT Precio (Descripcion) VALUES (@Descripcion) ELSE
    IF @Modulo = ''SIS01'' INSERT AroEventoPerdida (Descripcion) VALUES (@Descripcion) ELSE   
    IF @Modulo = ''SIS02'' INSERT AroRiesgoEvaluacion (Observaciones) VALUES (@Descripcion) ELSE        
    IF @Modulo = ''SIS03'' INSERT ArtMaterialHist (Articulo) VALUES (@Articulo) ELSE     
    IF @Modulo = ''SIS04'' INSERT GRP_Presupuesto (Partida) VALUES (@Articulo) ELSE         
    IF @Modulo = ''SIS05'' INSERT MovSituacion (Cuesta, PermiteAfectacion, PermiteRetroceder, PermiteBrincar, ControlUsuarios, Sucursal, Logico1, Logico2) VALUES (0,0,0,0,0,-1,0,0) ELSE             
    IF @Modulo = ''SIS06'' INSERT PlantillaOffice (Forma) VALUES (@Articulo) ELSE                 
    IF @Modulo = ''SIS07'' INSERT CteCto (Cliente) VALUES (@Cliente) ELSE
    IF @Modulo = ''SIS08'' INSERT Tarea (FechaEmision) VALUES (@FechaContable) ELSE    
    IF @Modulo = ''SIS09'' INSERT NomX (Finiquito, AceptaBajas, Logico1, Logico2, Logico3, Logico4, Logico5, FiltrarUltimoDiaPagado) VALUES (0, 0, 0, 0, 0, 0, 0, 0) ELSE           
    IF @Modulo = ''SIS10'' INSERT eDocD (Modulo, eDoc) VALUES (@Modulo, @Mov) ELSE            
    IF @Modulo = ''SIS11'' INSERT ContX (Modulo) VALUES (@Modulo) ELSE
    IF @Modulo = ''SIS12'' INSERT Evento (Fecha) VALUES (@FechaContable) ELSE
    IF @Modulo = ''SIS13'' INSERT EmbarqueMov (Sucursal, Logico1, Logico2, Logico3, Logico4, Logico5, DireccionNumero, DireccionNumeroInt, MapaLatitud, MapaLongitud, MapaPrecision) VALUES (-1, 0, 0, 0, 0, 0, @Descripcion, @Descripcion, 0.0, 0.0, 0)                                                             
    SET @IDLocal = SCOPE_IDENTITY()

    IF @Modulo = ''AF''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM ActivoFijo          WHERE ID = @IDLocal ELSE
    IF @Modulo = ''AGENT'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM AGENT               WHERE ID = @IDLocal ELSE
    IF @Modulo = ''ASIS''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Asiste              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CAM''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Cambio              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CAP''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Capital             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CAPT''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Captura             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CMP''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Campana             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''COMS''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Compra              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CONC''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Conciliacion        WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CONT''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CONT                WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CP''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CP                  WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CR''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CR                  WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CREDI'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Credito             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CXC''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CXC                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''CXP''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CXP                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''DIN''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Dinero              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''EMB''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Embarque            WHERE ID = @IDLocal ELSE
    IF @Modulo = ''FIS''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Fiscal              WHERE ID = @IDLocal ELSE
    --REQ25014
    IF @Modulo = ''CONTP'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM ContParalela        WHERE ID = @IDLocal ELSE    
    IF @Modulo = ''OPORT'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Oportunidad         WHERE ID = @IDLocal ELSE	
    IF @Modulo = ''CORTE'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Corte               WHERE ID = @IDLocal ELSE    
    IF @Modulo = ''FRM''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM FormaExtra          WHERE ID = @IDLocal ELSE
    IF @Modulo = ''GAS''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Gasto               WHERE ID = @IDLocal ELSE
    IF @Modulo = ''GES''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Gestion             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''INC''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Incidencia          WHERE ID = @IDLocal ELSE
    IF @Modulo = ''INV''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM INV                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''ISL''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM ISL                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''NOM''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Nomina              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''OFER''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Oferta              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''ORG''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Organiza            WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PACTO'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Contrato            WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PC''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM PC                  WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PPTO''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Presup              WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PROD''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM PROD                WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PROY''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Proyecto            WHERE ID = @IDLocal ELSE
    IF @Modulo = ''RE''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Recluta             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''RH''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM RH                  WHERE ID = @IDLocal ELSE
    IF @Modulo = ''RSS''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM RSS                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''ST''    SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Soporte             WHERE ID = @IDLocal ELSE
    IF @Modulo = ''TMA''   SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM TMA                 WHERE ID = @IDLocal ELSE
    IF @Modulo = ''VALE''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM VALE                WHERE ID = @IDLocal ELSE
    IF @Modulo = ''VTAS''  SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Venta               WHERE ID = @IDLocal ELSE
    IF @Modulo = ''PRECI'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Precio              WHERE ID = @IDLocal ELSE --este no es un modulo   
    IF @Modulo = ''SIS01'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM AroEventoPerdida    WHERE ID = @IDLocal ELSE --este no es un modulo       
    IF @Modulo = ''SIS02'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM AroRiesgoEvaluacion WHERE ID = @IDLocal ELSE --este no es un modulo           
    IF @Modulo = ''SIS03'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM ArtMaterialHist     WHERE ID = @IDLocal ELSE --este no es un modulo               
    IF @Modulo = ''SIS04'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM GRP_Presupuesto     WHERE ID = @IDLocal ELSE --este no es un modulo                   
    IF @Modulo = ''SIS05'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM MovSituacion        WHERE ID = @IDLocal ELSE --este no es un modulo                       
    IF @Modulo = ''SIS06'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM PlantillaOffice     WHERE ID = @IDLocal ELSE --este no es un modulo                           
    IF @Modulo = ''SIS07'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM CteCto              WHERE ID = @IDLocal ELSE --este no es un modulo                               
    IF @Modulo = ''SIS08'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Tarea               WHERE ID = @IDLocal ELSE --este no es un modulo                                       
    IF @Modulo = ''SIS09'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM NomX                WHERE ID = @IDLocal ELSE --este no es un modulo                                           
    IF @Modulo = ''SIS10'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM eDocD               WHERE RID = @IDLocal ELSE --este no es un modulo                                               
    IF @Modulo = ''SIS11'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM ContX               WHERE ID = @IDLocal ELSE  --este no es un modulo                                               
    IF @Modulo = ''SIS12'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM Evento              WHERE ID = @IDLocal ELSE  --este no es un modulo                                                   
    IF @Modulo = ''SIS13'' SELECT @SincroGUID = SincroGUID, @SincroID = SincroID FROM EmbarqueMov         WHERE ID = @IDLocal       --este no es un modulo                                                           
    
    --SET @Tabla = dbo.fnSincroISMovTabla(@Modulo)

    IF @SincroID IS NOT NULL
      INSERT SincroISNoRebote (SincroID, Sucursal) VALUES (@SincroID, @SucursalRemota)
    
    INSERT IDLocal (Tabla,  SucursalRemota,  IDRemoto,  SucursalLocal,  IDLocal,  RegistroTemporal)
            VALUES (@Tabla, @SucursalRemota, @IDRemoto, @SucursalLocal, @IDLocal, @SincroGUID)
    EXEC spSetInformacionContexto ''SINCROIS'', 0    
  END')
END  
GO

/**************** spSincroISVerificarEncabezado2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificarEncabezado2') and type = 'P') drop procedure dbo.spSincroISVerificarEncabezado2
GO             
CREATE PROCEDURE spSincroISVerificarEncabezado2
			(
			@MarcarRegistros			bit = 0,
			@Sucursal					int = 0
			)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SysTabla				varchar(50),
    @Tipo					varchar(20),
    @Modulo					varchar(5),
    @SQL					nvarchar(MAX),
    @JOIN_Encabezado		nvarchar(MAX),
    @WHERE_Encabezado		nvarchar(MAX),    
    @TablaRemota			varchar(50)
        
    
  DECLARE crSysTabla CURSOR FOR
   SELECT SysTabla, dbo.fnSincroISTablaTipo(SysTabla), Modulo
     FROM SysTabla
    WHERE dbo.fnSincroISTablaTipo(SysTabla) IN ('Movimiento','MovimientoInfo')
      --AND NULLIF(Modulo,'') NOT IN ('MEX01')
      AND SincroActivo = 1
    ORDER BY SysTabla

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC spSincroISTablaEstructura @SysTabla, @JOIN_Encabezado = @JOIN_Encabezado OUTPUT, @WHERE_Encabezado = @WHERE_Encabezado OUTPUT

    IF NULLIF(@JOIN_Encabezado,'') IS NOT NULL
    BEGIN
      SET @TablaRemota = dbo.fnSincroISMovTabla(@Modulo)

      IF @MarcarRegistros = 0
      BEGIN
        SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL) SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',' + CHAR(39) + @TablaRemota + CHAR(39) + ',* FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL'
      END ELSE
      IF @MarcarRegistros = 1
      BEGIN
        SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL) INSERT SincroISNoRebote (SincroID, Sucursal) SELECT ' + @SysTabla + '.SincroID, ' + RTRIM(LTRIM(CONVERT(varchar,@Sucursal))) + ' FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL'
    
        EXEC sp_ExecuteSql @SQL        
        SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL) SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',' + CHAR(39) + @TablaRemota + CHAR(39) + ',* FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE ' + @TablaRemota + '.ID IS NULL'
      END
      EXEC sp_ExecuteSql @SQL
    END ELSE 
    IF NULLIF(@JOIN_Encabezado,'') IS NULL
    BEGIN
      IF NULLIF(@WHERE_Encabezado,'') IS NOT NULL
      BEGIN
        IF @MarcarRegistros = 0
        BEGIN      
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ') SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',* FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ' '          
        END ELSE
        IF @MarcarRegistros = 1        
        BEGIN
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ') INSERT SincroISNoRebote (SincroID, Sucursal) SELECT '+ @SysTabla + '.SincroID, ' + RTRIM(LTRIM(CONVERT(varchar,@Sucursal))) + ' FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ' '        
              
          EXEC sp_ExecuteSql @SQL                
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ') SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',* FROM ' + @SysTabla + ' WHERE ' + @WHERE_Encabezado + ' '                    
        END  
        EXEC sp_ExecuteSql @SQL      
      END
    END 
    FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla
END
GO

--EXEC spSincroISVerificarEncabezado2 1, 1

/**************** spSincroISVerificarEncabezadoSuc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificarEncabezadoSuc') and type = 'P') drop procedure dbo.spSincroISVerificarEncabezadoSuc
GO             
CREATE PROCEDURE spSincroISVerificarEncabezadoSuc
			(
			@MarcarRegistros			bit = 0,
			@Sucursal					int = 0
			)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SysTabla				varchar(50),
    @Tipo					varchar(20),
    @Modulo					varchar(5),
    @SQL					nvarchar(MAX),
    @JOIN_Encabezado		nvarchar(MAX),
    @WHERE_Encabezado		nvarchar(MAX),    
    @TablaRemota			varchar(50),
    @ConSucursal			bit,
    @ConSucursalDestino		bit,    
    @SucursalTexto			varchar(50)
        
    
  SELECT @SucursalTexto = RTRIM(LTRIM(CONVERT(varchar,@Sucursal)))
    
  DECLARE crSysTabla CURSOR FOR
   SELECT SysTabla, dbo.fnSincroISTablaTipo(SysTabla), Modulo
     FROM SysTabla
    WHERE dbo.fnSincroISTablaTipo(SysTabla) IN ('Movimiento','MovimientoInfo')
      --AND NULLIF(Modulo,'') NOT IN ('MEX01')
      AND SincroActivo = 1
    ORDER BY SysTabla

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC spSincroISTablaEstructura @SysTabla, @JOIN_Encabezado = @JOIN_Encabezado OUTPUT, @WHERE_Encabezado = @WHERE_Encabezado OUTPUT

    SELECT @ConSucursal = ISNULL(dbo.fnCampoExiste(@SysTabla, 'Sucursal'),0)
    SELECT @ConSucursalDestino = ISNULL(dbo.fnCampoExiste(@SysTabla, 'SucursalDestino'),0)    
    IF NULLIF(@JOIN_Encabezado,'') IS NOT NULL
    BEGIN
      SET @TablaRemota = dbo.fnSincroISMovTabla(@Modulo)
      IF @MarcarRegistros = 0
      BEGIN
        IF @ConSucursal = 1
        BEGIN
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1 THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto ELSE '' END + ')) SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',' + CHAR(39) + @TablaRemota + CHAR(39) + ',* FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1 THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto + ')' ELSE ')' END           
          EXEC sp_ExecuteSql @SQL
        END  
      END ELSE
      IF @MarcarRegistros = 1
      BEGIN
        IF @ConSucursal = 1
        BEGIN      
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1  THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto ELSE '' END + ')) SELECT ' + CHAR(39) + @SysTabla + CHAR(39) + ',' + CHAR(39) + @TablaRemota + CHAR(39) + ',* FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1 THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto + ')' ELSE ')' END                   
          EXEC sp_ExecuteSql @SQL        
          SELECT @SQL = N'IF EXISTS(SELECT TOP 1 * FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1 THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto ELSE '' END + ')) INSERT SincroISNoRebote (Sucursal, SincroID) SELECT ' + @SucursalTexto + ', ' + @SysTabla + '.SincroID  FROM ' + @SysTabla + ' ' + @JOIN_Encabezado + ' WHERE (' + @TablaRemota + '.Sucursal <> ' + @SucursalTexto + ' AND ' + @TablaRemota + '.SucursalDestino <> ' + @SucursalTexto + ') AND (' + @SysTabla + '.Sucursal = ' + @SucursalTexto + CASE WHEN @ConSucursalDestino = 1 THEN ' OR ' + @SysTabla + '.SucursalDestino = ' + @SucursalTexto + ')' ELSE ')' END                             
                 
          EXEC sp_ExecuteSql @SQL        
        END  
      END
    END
    FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla
END
GO

--EXEC spSincroISVerificarEncabezadoSuc 0, 1

/**************** spSincroISVerificarClasificacionTabla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificarClasificacionTabla') and type = 'P') drop procedure dbo.spSincroISVerificarClasificacionTabla
GO             
CREATE PROCEDURE spSincroISVerificarClasificacionTabla

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SysTabla				varchar(50),
    @Tipo					varchar(20),
    @Modulo					varchar(5),
    @SQL					nvarchar(MAX),
    @TablaRemota			varchar(50),
    @TieneTablaRemota		bit,
    @TieneModulo			bit,        
    @Campo					varchar(100), 
    @CampoModulo			varchar(100),     
    @TipoDatos				varchar(100),
    @Ancho					int,
    @AceptaNulos			bit,
    @EsIdentity				bit,
    @EsCalculado			bit,
    @TieneIDRemoto			bit    


  DECLARE @Resultado TABLE
  (
  Tabla					varchar(50),
  Tipo					varchar(50),
  Modulo				varchar(5)
  )    
  
  DECLARE crSysTabla CURSOR FOR
   SELECT SysTabla, dbo.fnSincroISTablaTipo(SysTabla), Modulo
     FROM SysTabla
    WHERE SincroActivo = 1
    ORDER BY SysTabla

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    --EXEC spSincroISTablaEstructura @SysTabla, @JOIN_Encabezado = @JOIN_Encabezado OUTPUT, @WHERE_Encabezado = @WHERE_Encabezado OUTPUT

    SELECT @TieneTablaRemota = 0, @TieneModulo = 0, @TieneIDRemoto = 0, @CampoModulo = NULL
    SELECT @TablaRemota = dbo.fnIDLocalTablaModulo(@SysTabla)
    IF @TablaRemota IS NOT NULL AND @SysTabla <> @TablaRemota SELECT @TieneTablaRemota = 1

    DECLARE crSysCampo CURSOR LOCAL FOR 
     SELECT Campo, TipoDatos, Ancho, AceptaNulos, EsIdentity, EsCalculado
       FROM SysCampoExt
      WHERE Tabla = @SysTabla
      ORDER BY Orden

    OPEN crSysCampo
    FETCH NEXT FROM crSysCampo INTO @Campo, @TipoDatos, @Ancho, @AceptaNulos, @EsIdentity, @EsCalculado
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN

        --Si tiene un ID y no pertenece a un modulo, obtiene el nombre del campo modulo.
        IF @TieneTablaRemota = 0 AND @Campo LIKE '%Modulo%' AND @Ancho = 5
          SELECT @TieneModulo = 1, @CampoModulo = @Campo
          
        IF @TieneModulo = 1 AND @Campo IN ('ID', 'ModuloID', 'OID', 'DID') AND @TipoDatos = 'int' SELECT @TieneIDRemoto = 1
                  
      END        
      FETCH NEXT FROM crSysCampo INTO @Campo, @TipoDatos, @Ancho, @AceptaNulos, @EsIdentity, @EsCalculado
    END 
    CLOSE crSysCampo
    DEALLOCATE crSysCampo
    
    IF (@TieneTablaRemota = 1 OR (@TieneModulo = 1 AND @TieneIDRemoto = 1)) AND @Tipo NOT IN ('Movimiento','MovimientoInfo') 
      INSERT @Resultado (Tabla, Tipo, Modulo) VALUES (@SysTabla, @Tipo, @Modulo)
    
    FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo, @Modulo
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla
  
  SELECT * FROM @Resultado
END
GO

/************** spSincroISTransmisor *************/
--if exists (select * from sysobjects where id = object_id('dbo.spSincroISTransmisor') and type = 'P') drop procedure dbo.spSincroISTransmisor
--GO
/*
CREATE PROCEDURE dbo.spSincroISTransmisor
		@Enviar			bit = 1,
		@Ok				int = NULL OUTPUT,
		@OkRef			varchar(255) = NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@SQLIdentificador	nvarchar(MAX),
	@Insert				nvarchar(MAX),
	@InsertGuidRecibido	nvarchar(MAX),
	@Comando			nvarchar(MAX),
	@Update				nvarchar(MAX),
	@Tipo				varchar(20),
	@Sucursal			int,
	@OServidor			varchar(50),
	@DServidor			varchar(50),
	@OBase				varchar(50),
	@DBase				varchar(50),
	@ID					int,
    @DSucursal			int,
    @GUID				uniqueidentifier,
    @ISGUID				uniqueidentifier,
    @Retraso			datetime,
    @SucursalAnterior	int		

  SELECT @Sucursal = Sucursal FROM Version
  --SET @OBase = db_name()
  --SET @OServidor = @@SERVERNAME
  SELECT @OServidor = Servidor, @OBase = BaseDatosNombre FROM SincroISTransmisorSucursal WHERE Sucursal = @Sucursal
  SET @SucursalAnterior = -1
  SET @Retraso = NULL

  IF @Enviar = 1
  BEGIN
    DECLARE crIS CURSOR FOR
     SELECT ID, SincroGUID, SucursalDestino 
       FROM IntelisisService
      WHERE SucursalDestino <> @Sucursal   
        AND Estatus = 'SINPROCESAR'

    OPEN crIS
    FETCH NEXT FROM crIS INTO @ID, @ISGUID, @DSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
      IF @Sucursal = 0
        SELECT @DBase = BaseDatosNombre, @DServidor = Servidor FROM SincroISTransmisorSucursal s JOIN IntelisisService isr ON isr.SucursalDestino = s.Sucursal WHERE isr.ID = @ID
      ELSE 
        SELECT @DBase = BaseDatosNombre, @DServidor = Servidor FROM SincroISTransmisorSucursal WHERE Sucursal = 0

      --Liga al servidor destino
      --IF NOT EXISTS(SELECT * FROM sys.servers WHERE NAME = @DServidor)
      --BEGIN      
      --  EXEC sp_addlinkedserver @DServidor, 'SQL Server'
      --END
      
      --Generar Identificador
      IF @ISGUID IS NULL and @Ok IS NULL
      BEGIN
        SET @GUID = NEWID()
        SET @SQLIdentificador = N' UPDATE  ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + N'.*/  N'dbo.IntelisisService SET SincroGUID = ' + NCHAR(39) + CONVERT(varchar(100),@GUID) + NCHAR(39) + N' WHERE ID = ' + CONVERT(nchar,@ID)      

        EXEC sp_executesql @SQLIdentificador
        IF @@ERROR <> 0 SET @Ok = 1        
      END ELSE
      BEGIN
        SET @GUID = @ISGUID
      END
            
      --Enviar
      IF @Ok IS NULL
      BEGIN
        SET @Insert = 'SET ANSI_NULLS ON SET ANSI_WARNINGS ON IF NOT EXISTS(SELECT * FROM ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.IntelisisService WHERE SincroGUID = ' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') INSERT ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.IntelisisService (Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, SincroGUID, Conversacion, SucursalOrigen, SucursalDestino) ' + 
                                                'SELECT                   Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, SincroGUID, Conversacion, SucursalOrigen, SucursalDestino ' +
                                                  'FROM ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + '.*/N'dbo.IntelisisService ' +
                                                 'WHERE ID = ' + CONVERT(varchar,@ID)

        EXEC sp_executesql @Insert 	  
        IF @@ERROR <> 0 SET @Ok = 1
      END

      IF @Ok IS NULL
      BEGIN
        SET @InsertGUIDRecibido = 'SET ANSI_NULLS ON SET ANSI_WARNINGS ON IF NOT EXISTS(SELECT * FROM ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.SincroISGUIDRecibido WHERE SincroGUIDRecibido = ' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') INSERT ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.SincroISGUIDRecibido (SincroGUIDRecibido) VALUES (' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') '                                    

        EXEC sp_executesql @InsertGUIDRecibido 	  
        IF @@ERROR <> 0 SET @Ok = 1
      END

      IF @Ok IS NULL
      BEGIN
        SET @Update = N'UPDATE ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + '.*/N'dbo.intelisisservice SET estatus = ' + CHAR(39) + 'ENVIADO' + CHAR(39) + ' WHERE ID = ' + CONVERT(varchar,@ID)          

        EXEC sp_executesql @Update 	  
        IF @@ERROR <> 0 SET @Ok = 1 
      END  
      
  
      IF @DSucursal <> @SucursalAnterior
      BEGIN    
        SELECT @Retraso = dbo.fnSincroISRetraso(@DSucursal)        
        SELECT @SucursalAnterior = @DSucursal
      END
      
      IF @Retraso IS NOT NULL WAITFOR DELAY @Retraso
      
      FETCH NEXT FROM crIS INTO @ID, @ISGUID, @DSucursal
    END
    CLOSE crIS
    DEALLOCATE crIS
  END

END	
*/			  
GO


/************** spSincroISTransmisorInsertarIS *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISTransmisorInsertarIS') and type = 'P') drop procedure dbo.spSincroISTransmisorInsertarIS
GO             
CREATE PROCEDURE spSincroISTransmisorInsertarIS
		@Sistema			varchar(100),
		@Contenido			varchar(100),
		@Referencia			varchar(100),
		@SubReferencia		varchar(100),
		@Version			float,
		@Usuario			varchar(10),
		@Solicitud			varchar(max),
		@SolicitudBinario	varbinary(max),  -- REQ12766		
		@Resultado			varchar(max),
		@Estatus			varchar(15),
		@FechaEstatus		datetime,
		@ISOk				int,
		@ISOkRef			varchar(255),
		@SincroGUID			uniqueidentifier, 
		@Conversacion		uniqueidentifier, 
		@SucursalOrigen		int, 
		@SucursalDestino	int,		

		@GUID				uniqueidentifier,
		@SincroTabla		varchar(100),
		@SincroSolicitud	uniqueidentifier,
				
		@Ok		int = NULL OUTPUT,
		@OkRef		varchar(255) = NULL OUTPUT

        
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  IF NOT EXISTS(SELECT * FROM IntelisisService WHERE SincroGUID = CONVERT(varchar(100),@GUID)) AND @GUID IS NOT NULL
  BEGIN
    INSERT IntelisisService (Sistema,  Contenido,  Referencia,  SubReferencia,  [Version], Usuario,  Solicitud,   SolicitudBinario, Resultado,  Estatus,  FechaEstatus,  Ok,  OkRef,  SincroGUID,  Conversacion,  SucursalOrigen,  SucursalDestino,  SincroTabla,  SincroSolicitud) -- REQ12766
                     VALUES (@Sistema, @Contenido, @Referencia, @SubReferencia, @Version,  @Usuario, @Solicitud, @SolicitudBinario, @Resultado, @Estatus, @FechaEstatus, @Ok, @OkRef, @SincroGUID, @Conversacion, @SucursalOrigen, @SucursalDestino, @SincroTabla, @SincroSolicitud) -- REQ12766
    IF @@ERROR <> 0 SET @Ok = 1
  END ELSE IF @GUID IS NULL SET @Ok = 1
  
  IF @Ok IS NULL
    IF NOT EXISTS(SELECT * FROM SincroISGUIDRecibido WHERE SincroGUIDRecibido = CONVERT(varchar(100),@GUID)) INSERT SincroISGUIDRecibido (SincroGUIDRecibido) VALUES (CONVERT(varchar(100),@GUID))                                    
  
END
GO

/**************** fnSincroISDropBoxNombreArchivo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISDropBoxNombreArchivo') DROP FUNCTION fnSincroISDropBoxNombreArchivo
GO
CREATE FUNCTION fnSincroISDropBoxNombreArchivo(
		@ID					int, 
		@SucursalOrigen		int, 
		@SucursalDestino	int, 
		@SincroTabla		varchar(100), 
		@SubReferencia		varchar(100)
		)
RETURNS varchar(255)
AS
BEGIN
  DECLARE @Nombre	varchar(255)
  
  IF ISNULL(@SincroTabla, '') = ''
    SELECT @Nombre = 'SincroIS_' + CONVERT(varchar, @ID) + '_' + CONVERT(varchar, @SucursalOrigen) + '_' + CONVERT(varchar, @SucursalDestino) + '_' + ISNULL(@SubReferencia, '')
  ELSE
    SELECT @Nombre = 'SincroIS_' + CONVERT(varchar, @ID) + '_' + CONVERT(varchar, @SucursalOrigen) + '_' + CONVERT(varchar, @SucursalDestino) + '_' + ISNULL(@SincroTabla, '')

  RETURN @Nombre
END
GO

/**************** fnDirectorioEliminarDiagonalFinal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDirectorioEliminarDiagonalFinal') DROP FUNCTION fnDirectorioEliminarDiagonalFinal
GO
CREATE FUNCTION fnDirectorioEliminarDiagonalFinal(
		@Directorio			varchar(255))
RETURNS varchar(255)
AS
BEGIN
  IF RIGHT(@Directorio, 1) = '\'
    SELECT @Directorio = SUBSTRING(@Directorio, 1, LEN(@Directorio) - 1)
  
  RETURN @Directorio
END
GO

/**************** fnDirectorioEmpaquetadorArchivos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDirectorioEmpaquetadorArchivos') DROP FUNCTION fnDirectorioEmpaquetadorArchivos
GO
CREATE FUNCTION fnDirectorioEmpaquetadorArchivos()
RETURNS varchar(255)
AS
BEGIN
  DECLARE @Directorio		varchar(255)
		
  SELECT @Directorio = dbo.fnDirectorioEliminarDiagonalFinal(DirectorioEmpaquetadorArchivos) FROM Version
  
  RETURN @Directorio
END
GO

/************** spDescomprimirArchivo *************/
if exists (select * from sysobjects where id = object_id('dbo.spDescomprimirArchivo') and type = 'P') drop procedure dbo.spDescomprimirArchivo
GO
CREATE PROCEDURE spDescomprimirArchivo
		@RutaArchivoComprimido	varchar(255), 
		@RutaArchivo			varchar(255), 
		@Ok						int			  = NULL OUTPUT, 
		@OkRef					varchar(255)  = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Shell								varchar(8000),
		  @DirectorioEmpaquetadorArchivos		varchar(255)
  
  SELECT @DirectorioEmpaquetadorArchivos = dbo.fnDirectorioEmpaquetadorArchivos()
  
  SELECT @Shell = @DirectorioEmpaquetadorArchivos + '\SincroISCompresor.exe d "' + @RutaArchivoComprimido + '" "' + @RutaArchivo + '"'

  EXEC xp_cmdshell @Shell, no_output

  RETURN
END
GO

/************** spComprimirArchivo *************/
if exists (select * from sysobjects where id = object_id('dbo.spComprimirArchivo') and type = 'P') drop procedure dbo.spComprimirArchivo
GO
CREATE PROCEDURE spComprimirArchivo
		@RutaArchivo			varchar(255), 
		@RutaArchivoComprimido	varchar(255), 
		@Ok						int			 = NULL OUTPUT, 
		@OkRef					varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Shell								varchar(8000),
		  @DirectorioEmpaquetadorArchivos		varchar(255)
  
  SELECT @DirectorioEmpaquetadorArchivos = dbo.fnDirectorioEmpaquetadorArchivos()
  
  SELECT @Shell = @DirectorioEmpaquetadorArchivos + '\SincroISCompresor.exe e "' + @RutaArchivo + '" "' + @RutaArchivoComprimido + '"'

  EXEC xp_cmdshell @Shell, no_output

  RETURN
END
GO

/************** spSincroISTransmisorDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISTransmisorDropBox') and type = 'P') drop procedure dbo.spSincroISTransmisorDropBox
GO
CREATE PROCEDURE dbo.spSincroISTransmisorDropBox
		@ID						int, 
		@ISGUID					uniqueidentifier, 
		@Sucursal				int,
		@SucursalDestino		int, 
		@SucursalOrigen			int,
		@SincroTabla			varchar(100), 
		@SubReferencia			varchar(100), 
		@SincroISDropBox		bit, 
		@SincroISDropBoxRuta	varchar(255), 
		@Ok						int			 OUTPUT, 
		@OkRef					varchar(255) OUTPUT		
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @ManejadorObjeto				int, 
		  @IDArchivo					int,
		  @XML							varchar(max),
		  @SincroISDropBoxRutaSucursal	varchar(255), 
		  @ArchivoXML					varchar(255),
		  @ArchivoZIP					varchar(255)

  CREATE TABLE #IntelisisService(
    Tag										int					NULL,
    Parent									int					NULL,
    [IntelisisService!1!]					int					NULL,     
    [IntelisisService!2!ID]					int					NULL, 
    [IntelisisService!2!Sistema]			varchar(100)		NULL, 
    [IntelisisService!2!Contenido]			varchar(100)		NULL, 
    [IntelisisService!2!Referencia]			varchar(100)		NULL, 
    [IntelisisService!2!SubReferencia]		varchar(100)		NULL, 
    [IntelisisService!2!Version]			float				NULL, 
    [IntelisisService!2!Usuario]			varchar(10)			NULL, 
    [IntelisisService!2!Solicitud!cdata]	varchar(max)		NULL, 
    [IntelisisService!2!Resultado!cdata]	varchar(max)		NULL, 
    [IntelisisService!2!Estatus]			varchar(15)			NULL, 
    [IntelisisService!2!FechaEstatus]		datetime			NULL, 
    [IntelisisService!2!Ok]					int					NULL, 
    [IntelisisService!2!OkRef]				varchar(255)		NULL, 
    [IntelisisService!2!Conversacion]		uniqueidentifier	NULL, 
    [IntelisisService!2!SincroGUID]			uniqueidentifier	NULL, 
    [IntelisisService!2!SucursalOrigen]		int					NULL, 
    [IntelisisService!2!SucursalDestino]	int					NULL, 
    [IntelisisService!2!eDocInArchivo]		varchar(255)		NULL, 
    [IntelisisService!2!SincroTabla]		varchar(100)		NULL, 
    [IntelisisService!2!SincroSolicitud]	uniqueidentifier	NULL
    )

  IF ISNULL(@SincroISDropBoxRuta, '') = '' AND ISNULL(@SincroISDropBox, 0) = 1
  BEGIN
    SELECT @Ok = 71665 
    RETURN
  END

  IF @Sucursal = 0
    SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\' + CONVERT(varchar, @SucursalDestino)
  ELSE 
    SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\0'

  INSERT INTO #IntelisisService
    SELECT 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
	UNION ALL 
    SELECT 2, 1, NULL, ID, Sistema, Contenido, Referencia, SubReferencia, Version, Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, eDocInArchivo, SincroTabla, SincroSolicitud 
      FROM IntelisisService 
     WHERE ID = @ID

  SELECT @XML = (SELECT * FROM #IntelisisService FOR XML EXPLICIT)
  
  EXEC spCrearDirectorio @SincroISDropBoxRutaSucursal, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @ArchivoXML = @SincroISDropBoxRutaSucursal + '\' + dbo.fnSincroISDropBoxNombreArchivo(@ID, @SucursalOrigen, @SucursalDestino, @SincroTabla, @SubReferencia) + '.xml',
		   @ArchivoZIP = @SincroISDropBoxRutaSucursal + '\' + dbo.fnSincroISDropBoxNombreArchivo(@ID, @SucursalOrigen, @SucursalDestino, @SincroTabla, @SubReferencia) + '.zip'
    
    EXEC spCrearArchivo @ArchivoXML, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  
  IF @Ok IS NULL
    EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT  
    
  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  

  IF @Ok IS NULL
    EXEC spComprimirArchivo @ArchivoXML, @ArchivoZIP, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spEliminarArchivo @ArchivoXML, @Ok OUTPUT, @OkRef OUTPUT    
  RETURN
END
GO

/************** spSincroISTransmisorPaqueteDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISTransmisorPaqueteDropBox') and type = 'P') drop procedure dbo.spSincroISTransmisorPaqueteDropBox
GO
CREATE PROCEDURE dbo.spSincroISTransmisorPaqueteDropBox
		@Conversacion				uniqueidentifier,
		@Sucursal					int,
		@SucursalDestino			int,
		@SucursalOrigen				int,
		@SincroISDropBox			bit,
		@SincroISDropBoxRuta		varchar(255),
		@Ok							int			 OUTPUT, 
		@OkRef						varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @SincroISDropBoxRutaSucursal	varchar(255),
  		  @ArchivoXML					varchar(255),
		  @ArchivoPAQ					varchar(255),
		  @ManejadorObjeto				int, 
		  @IDArchivo					int,
		  @XML							varchar(max)
  
  IF ISNULL(@SincroISDropBoxRuta, '') = '' AND ISNULL(@SincroISDropBox, 0) = 1
  BEGIN
    SELECT @Ok = 71665 
    RETURN
  END
  
  --IF EXISTS(SELECT RID FROM SincroISDropBoxPaquete WHERE Conversacion = @Conversacion) RETURN
  
  IF @Sucursal = 0
    SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\' + CONVERT(varchar, @SucursalDestino)
  ELSE 
    SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\0'

  EXEC spCrearDirectorio @SincroISDropBoxRutaSucursal, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN
    SELECT @ArchivoXML = @SincroISDropBoxRutaSucursal + '\' + CONVERT(varchar(255), @Conversacion) + '.xml',
		   @ArchivoPAQ = @SincroISDropBoxRutaSucursal + '\' + CONVERT(varchar(255), @Conversacion) + '.paq'
    
    EXEC spCrearArchivo @ArchivoXML, @ManejadorObjeto OUTPUT, @IDArchivo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END
  
  IF @Ok IS NULL
  BEGIN
    SELECT @XML = (SELECT ID 'IntelisisServiceID', Conversacion FROM IntelisisService WHERE Conversacion = @Conversacion AND SucursalOrigen = @Sucursal AND Estatus IN('SINPROCESAR', 'ENVIADO') FOR XML AUTO, ROOT('SincroISDropBoxPaquete'))
    
    EXEC spInsertaEnArchivo @IDArchivo, @XML, @Ok OUTPUT, @OkRef OUTPUT    
  END

  IF @Ok IS NULL
    EXEC spCerrarArchivo @IDArchivo, @ManejadorObjeto, @Ok OUTPUT, @OkRef OUTPUT  

  IF @Ok IS NULL
    EXEC spComprimirArchivo @ArchivoXML, @ArchivoPAQ, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    EXEC spEliminarArchivo @ArchivoXML, @Ok OUTPUT, @OkRef OUTPUT      
  RETURN
END
GO

/************** spSincroISTransmisor *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISTransmisor') and type = 'P') drop procedure dbo.spSincroISTransmisor
GO
CREATE PROCEDURE dbo.spSincroISTransmisor
		@Enviar					bit = 1,
		@Ok						int			 = NULL OUTPUT,
		@OkRef					varchar(255) = NULL OUTPUT,
		-- 9562
		@SincroISDropBox		bit = 0,
		@SincroISDropBoxRuta	varchar(255) = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@SQLIdentificador	nvarchar(MAX),
	@Insert				nvarchar(MAX),
	@InsertGuidRecibido	nvarchar(MAX),
	@Comando			nvarchar(MAX),
	@Update				nvarchar(MAX),
	@Tipo				varchar(20),
	@Sucursal			int,
	@OServidor			varchar(50),
	@DServidor			varchar(50),
	@OBase				varchar(50),
	@DBase				varchar(50),
	@ID					int,
    @DSucursal			int,
    @GUID				uniqueidentifier,
    @ISGUID				uniqueidentifier,
    @Retraso			datetime,
    @SucursalAnterior	int,
    
    @Sistema			varchar(100),
    @Contenido			varchar(100),
    @Referencia			varchar(100),
    @SubReferencia		varchar(100),
    @Version			float,
    @Usuario			varchar(10),
    @Solicitud			varchar(max), 
    @SolicitudBinario	varbinary(max), -- REQ12776
    @Resultado			varchar(max),
    @Estatus			varchar(15),
    @FechaEstatus		datetime,
    @ISOk				int,
    @ISOkRef			varchar(255),
    @SincroGUID			uniqueidentifier, 
    @Conversacion		uniqueidentifier, 
    @SucursalOrigen		int, 
    @SucursalDestino	int,		
    @SincroTabla		varchar(100),
    @SincroSolicitud	uniqueidentifier,
    @Parametros			nvarchar(MAX),
    
    @SincroISDropBoxSuc		bit,
    @HabilitarCompresion	bit			-- REQ12776

  SELECT @Sucursal = Sucursal FROM Version
  --SET @OBase = db_name()
  --SET @OServidor = @@SERVERNAME
  SELECT @OServidor = Servidor, @OBase = BaseDatosNombre FROM SincroISTransmisorSucursal WHERE Sucursal = @Sucursal
  SET @SucursalAnterior = -1
  SET @Retraso = NULL

  IF @Enviar = 1
  BEGIN
    DECLARE crIS CURSOR FOR
     SELECT ID, SincroGUID, SucursalDestino 
       FROM IntelisisService
      WHERE SucursalDestino <> @Sucursal   
        AND Estatus = 'SINPROCESAR'

    OPEN crIS
    FETCH NEXT FROM crIS INTO @ID, @ISGUID, @DSucursal
    WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
    BEGIN 
      IF @Sucursal = 0
      BEGIN
        SELECT @DBase = BaseDatosNombre, @DServidor = Servidor FROM SincroISTransmisorSucursal s JOIN IntelisisService isr ON isr.SucursalDestino = s.Sucursal WHERE isr.ID = @ID
      
        SELECT @SincroISDropBoxSuc = ISNULL(SincroISDropBox, 0), @HabilitarCompresion = ISNULL(HabilitarCompresion, 0) FROM SincroISTransmisorSucursal WHERE Sucursal = @DSucursal -- REQ12766
      END
      ELSE 
      BEGIN
        SELECT @DBase = BaseDatosNombre, @DServidor = Servidor FROM SincroISTransmisorSucursal WHERE Sucursal = 0

        SELECT @SincroISDropBoxSuc = ISNULL(SincroISDropBox, 0), @HabilitarCompresion = ISNULL(HabilitarCompresion, 0) FROM SincroISTransmisorSucursal WHERE Sucursal = @Sucursal -- REQ12766
      END

      -- REQ12766
      IF @HabilitarCompresion = 1
        EXEC spSincroISComprimirPaquete @ID, @Ok OUTPUT, @OkRef OUTPUT

      --Liga al servidor destino
      --IF NOT EXISTS(SELECT * FROM sys.servers WHERE NAME = @DServidor)
      --BEGIN      
      --  EXEC sp_addlinkedserver @DServidor, 'SQL Server'
      --END
      
      --Generar Identificador
      IF @ISGUID IS NULL and @Ok IS NULL
      BEGIN
        SET @GUID = NEWID()
        SET @SQLIdentificador = N' UPDATE  ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + N'.*/  N'dbo.IntelisisService SET SincroGUID = ' + NCHAR(39) + CONVERT(varchar(100),@GUID) + NCHAR(39) + N' WHERE ID = ' + CONVERT(nchar,@ID)      

        EXEC sp_executesql @SQLIdentificador
        IF @@ERROR <> 0 SET @Ok = 1        
      END ELSE
      BEGIN
        SET @GUID = @ISGUID
      END
      
      --Enviar
      IF @Ok IS NULL
      BEGIN
        SELECT  @Sistema = Sistema, @Contenido = Contenido, @Referencia = Referencia, @SubReferencia = SubReferencia, @Version = [Version], @Usuario = Usuario, @Solicitud = Solicitud, @Resultado = Resultado, @Estatus = Estatus, @FechaEstatus = FechaEstatus, @ISOk = Ok, @ISOkRef = OkRef, @SincroGUID = SincroGUID, @Conversacion = Conversacion, @SucursalOrigen = SucursalOrigen, @SucursalDestino = SucursalDestino, @SincroTabla = SincroTabla, @SincroSolicitud = SincroSolicitud, @SolicitudBinario = SolicitudBinario  --REQ12766
          FROM  dbo.IntelisisService 
         WHERE ID = CONVERT(varchar,@ID)

        -- 9562
        IF @SincroISDropBox = 0 OR(@SincroISDropBox = 1 AND @SincroISDropBoxSuc = 0)
        BEGIN
          SET @Parametros = '@Sistema varchar(100), @Contenido varchar(100), @Referencia varchar(100), @SubReferencia varchar(100), @Version	float, @Usuario varchar(10), @Solicitud varchar(max), @Resultado varchar(max), @Estatus varchar(15), @FechaEstatus datetime, @ISOk int, @ISOkRef varchar(255), @SincroGUID uniqueidentifier, @Conversacion uniqueidentifier, @SucursalOrigen int,  @SucursalDestino	int, @GUID uniqueidentifier, @SincroTabla varchar(100), @SincroSolicitud uniqueidentifier, @Ok int OUTPUT, @OkRef varchar(255) OUTPUT, @SolicitudBinario varbinary(max)' --REQ12766
          SELECT @Insert = 'EXEC [' + RTRIM(@DServidor) + '].' + RTRIM(@DBase) + N'.dbo.spSincroISTransmisorInsertarIS @Sistema, @Contenido, @Referencia, @SubReferencia, @Version, @Usuario, @Solicitud, @SolicitudBinario, @Resultado, @Estatus, @FechaEstatus, @ISOk, @ISOkRef, @SincroGUID,  @Conversacion, @SucursalOrigen, @SucursalDestino, @GUID, @SincroTabla, @SincroSolicitud, @Ok, @OkRef'       --REQ12766
          --SET @Insert = 'SET ANSI_NULLS ON SET ANSI_WARNINGS ON IF NOT EXISTS(SELECT * FROM ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.IntelisisService WHERE SincroGUID = ' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') INSERT ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.IntelisisService (Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, SincroGUID, Conversacion, SucursalOrigen, SucursalDestino) ' + 
          --                                        'SELECT                   Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, SincroGUID, Conversacion, SucursalOrigen, SucursalDestino ' +
          --                                          'FROM ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + '.*/N'dbo.IntelisisService ' +
          --                                         'WHERE ID = ' + CONVERT(varchar,@ID)
          EXEC sp_executesql @Insert, @Parametros, 
               @Sistema = @Sistema, 
               @Contenido = @Contenido, 
               @Referencia = @Referencia, 
               @SubReferencia = @SubReferencia, 
               @Version = @Version, 
               @Usuario = @Usuario,
               @Solicitud = @Solicitud, 
			   @SolicitudBinario = @SolicitudBinario, -- REQ12766
               @Resultado = @Resultado,
               @Estatus = @Estatus,
               @FechaEstatus = @FechaEstatus,
               @ISOk = @ISOk,
               @ISOkRef = @ISOkRef,
               @SincroGUID = @SincroGUID,
               @Conversacion = @Conversacion,
               @SucursalOrigen = @SucursalOrigen,
               @SucursalDestino = @SucursalDestino,
               @GUID = @GUID,
               @SincroTabla = @SincroTabla,
               @SincroSolicitud = @SincroSolicitud,
               @Ok = @Ok OUTPUT, 
               @OkRef = @OkRef OUTPUT
          IF @@ERROR <> 0 SET @Ok = 1
        END
        ELSE IF @SincroISDropBox = 1 AND @SincroISDropBoxSuc = 1
        BEGIN
          EXEC spSincroISTransmisorPaqueteDropBox @Conversacion, @Sucursal, @DSucursal, @SucursalOrigen, @SincroISDropBox, @SincroISDropBoxRuta, @Ok OUTPUT, @OkRef OUTPUT
          
          IF  @Ok IS NULL
            EXEC spSincroISTransmisorDropBox @ID, @ISGUID, @Sucursal, @DSucursal, @SucursalOrigen, @SincroTabla, @SubReferencia, @SincroISDropBox, @SincroISDropBoxRuta, @Ok OUTPUT, @OkRef OUTPUT		
        END
      END
      --IF @Ok IS NULL
      --BEGIN
      --  SET @InsertGUIDRecibido = 'SET ANSI_NULLS ON SET ANSI_WARNINGS ON IF NOT EXISTS(SELECT * FROM ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.SincroISGUIDRecibido WHERE SincroGUIDRecibido = ' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') INSERT ' + RTRIM(@DServidor) + '.' + RTRIM(@DBase) + '.dbo.SincroISGUIDRecibido (SincroGUIDRecibido) VALUES (' + CHAR(39) + CONVERT(varchar(100),@GUID) + CHAR(39) + ') '                                    

      --  EXEC sp_executesql @InsertGUIDRecibido 	  
      --  IF @@ERROR <> 0 SET @Ok = 1
      --END

      --IF @Ok IS NULL
      --BEGIN
      --  SET @Update = N'UPDATE ' + /*RTRIM(@OServidor) + '.' + RTRIM(@OBase) + '.*/N'dbo.intelisisservice SET estatus = ' + CHAR(39) + 'ENVIADO' + CHAR(39) + ' WHERE ID = ' + CONVERT(varchar,@ID)          

      --  EXEC sp_executesql @Update 	  
      --  IF @@ERROR <> 0 SET @Ok = 1 
      --END  
      
      IF @Ok IS NULL
      BEGIN
        UPDATE intelisisservice SET estatus = 'ENVIADO' WHERE ID = CONVERT(varchar,@ID)          
        IF @@ERROR <> 0 SET @Ok = 1 
      END  
  
      IF @DSucursal <> @SucursalAnterior
      BEGIN    
        SELECT @Retraso = dbo.fnSincroISRetraso(@DSucursal)        
        SELECT @SucursalAnterior = @DSucursal
      END
      
      IF @Retraso IS NOT NULL WAITFOR DELAY @Retraso
      
      FETCH NEXT FROM crIS INTO @ID, @ISGUID, @DSucursal
    END
    CLOSE crIS
    DEALLOCATE crIS
  END

END				  
GO

--EXEC spSincroISTransmisor 1
--UPDATE intelisisservice SET ESTATUS = 'SINPROCESAR'
--DELETE FROM INTELISISSERVICELOG
--select * from intelisisservice
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
GO

/**************** spSincroISVerificarTipoTabla ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISVerificarTipoTabla') and type = 'P') drop procedure dbo.spSincroISVerificarTipoTabla
GO             
CREATE PROCEDURE spSincroISVerificarTipoTabla
		@Cambiar			bit = 0,
		@EnSilencio			bit = 0


--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SysTabla				varchar(50),
    @Tipo					varchar(20),
    @TipoMovimiento			int,
    @TipoPropuesto			varchar(20)
  
  DECLARE @TipoIncorrecto TABLE
  (
   Tabla					varchar(50),
   TipoActual				varchar(20),
   TipoPropuesto			varchar(20)
  )    
    
  DECLARE crSysTabla CURSOR FOR
   SELECT SysTabla, dbo.fnSincroISTablaTipo(SysTabla)
     FROM SysTabla

  OPEN crSysTabla
  FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SELECT @TipoMovimiento = dbo.fnTablaTipoMovimiento(@SysTabla)
    IF @TipoMovimiento = 1 
      SELECT @TipoPropuesto = 'Movimiento'
    ELSE IF @TipoMovimiento = 1
      SELECT @TipoPropuesto = 'MovimientoInfo'
        
    IF @TipoMovimiento IN (1,2) AND @Tipo NOT IN ('Movimiento','MovimientoInfo') 
    BEGIN
      INSERT @TipoIncorrecto (Tabla, TipoActual, TipoPropuesto) VALUES (@SysTabla, @Tipo, @TipoPropuesto)  
      IF @Cambiar = 1 UPDATE SysTabla SET Tipo = @TipoPropuesto WHERE SysTabla = @SysTabla
    END  
    
    FETCH NEXT FROM crSysTabla INTO @SysTabla, @Tipo
  END
  CLOSE crSysTabla
  DEALLOCATE crSysTabla
  
  IF @EnSilencio = 0 SELECT * FROM @TipoIncorrecto
END
GO

/************** spSincroISOk *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISOk') and type = 'P') drop procedure dbo.spSincroISOk
GO
CREATE PROCEDURE spSincroISOk
			@Conversacion		uniqueidentifier,
			@TipoMensaje		varchar(255),
			@Datos				xml,
			@DatosRef			varchar(max),

			@SQL_ERROR_NUMBER	int,
			@SQL_ERROR_MESSAGE	varchar(255),
			@Ok					int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias	int

  IF @Conversacion IS NULL RETURN

  IF @SQL_ERROR_NUMBER <> 0 
    SELECT @Ok = 1, @OkRef = ISNULL(@SQL_ERROR_MESSAGE, '')+' ['+CONVERT(varchar, @SQL_ERROR_NUMBER)+']'

  IF @Ok IS NOT NULL 
  BEGIN    
    SELECT @Dias = ISNULL(SincroSBBOkConservar, 1)
      FROM Version
    DELETE SincroISOk WHERE Fecha < DATEADD(day, -@Dias, GETDATE())

    IF NOT EXISTS(SELECT Conversacion FROM SincroISOk WHERE Conversacion = @Conversacion)
      INSERT SincroISOk (
              Conversacion,  TipoMensaje,  Datos,  DatosRef,  Ok,  OkRef)
      VALUES (@Conversacion, @TipoMensaje, @Datos, @DatosRef, @Ok, @OkRef)
  END
  RETURN
END
GO

/************** spSincroISBaja *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISBaja') and type = 'P') drop procedure dbo.spSincroISBaja
GO
CREATE PROCEDURE spSincroISBaja
			@Tabla			varchar(100),
			@Llave			xml
--//WITH ENCRYPTION
AS BEGIN
  IF @Tabla IS NOT NULL AND @Llave IS NOT NULL
    INSERT SincroISBaja (Tabla, Llave) VALUES (@Tabla, @Llave)

  RETURN
END
GO
/*
EXEC spSincroISBaja 'Art', '<Llave Articulo="A1"/>'
EXEC spSincroISBaja 'Art', '<Llave Articulo="A2"/>'
SELECT Llave FROM SincroISBaja WHERE Tabla='Art' FOR XML RAW("Baja"), ROOT("Bajas")
*/

/************** spSincroISControl *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISControl') and type = 'P') drop procedure dbo.spSincroISControl
GO
CREATE PROCEDURE spSincroISControl
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@Conversacion		uniqueidentifier	OUTPUT,
			@FechaEnvio		datetime		OUTPUT,
			@Desde			timestamp		OUTPUT,
			@Hasta			timestamp		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Desde = 0, @FechaEnvio = GETDATE()
  SELECT @Desde = ISNULL(MAX(SincroID), 0) 
    FROM SincroISControl
   WHERE SucursalDestino = @SucursalDestino
  INSERT SincroISControl (
          SucursalOrigen,  SucursalDestino,  Conversacion,  FechaEnvio,  SincroIDAnterior) 
  VALUES (@SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio, @Desde)
  SELECT @Hasta = @@DBTS
  RETURN
END
GO

/************** spSincroISIDRemotoControl *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISIDRemotoControl') and type = 'P') drop procedure dbo.spSincroISIDRemotoControl
GO
CREATE PROCEDURE spSincroISIDRemotoControl
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@Conversacion		uniqueidentifier	OUTPUT,
			@FechaEnvio			datetime		OUTPUT,
			@Desde				timestamp		OUTPUT,
			@Hasta				timestamp		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Desde = 0, @FechaEnvio = GETDATE()
  SELECT @Desde = ISNULL(MAX(SincroID), 0) 
    FROM SincroISIDRemotoControl
   WHERE SucursalDestino = @SucursalDestino
  INSERT SincroISIDRemotoControl (
          SucursalOrigen,  SucursalDestino,  Conversacion,  FechaEnvio,  SincroIDAnterior) 
  VALUES (@SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio, @Desde)
  SELECT @Hasta = @@DBTS
  RETURN
END
GO

/************** spSincroISLog *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISLog') and type = 'P') drop procedure dbo.spSincroISLog
GO
CREATE PROCEDURE spSincroISLog
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@Tabla			varchar(100),
			@PaqueteCambios		int,
			@PaqueteBajas		int,
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@FechaEnvio		datetime,
			@FechaRecibo		datetime
--//WITH ENCRYPTION
AS BEGIN
  INSERT SincroISLog (
          Solicitud,  Conversacion,  Tabla,  PaqueteCambios,  PaqueteBajas,  SucursalOrigen,  SucursalDestino,  FechaEnvio,  FechaRecibo)
  VALUES (@Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalOrigen, @SucursalDestino, @FechaEnvio, @FechaRecibo)
  RETURN
END
GO

/************** spSincroISUsuario *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISUsuario') and type = 'P') drop procedure dbo.spSincroISUsuario
GO
CREATE PROCEDURE spSincroISUsuario
			@Usuario			varchar(10)		OUTPUT,
			@Contrasena			varchar(32)		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  --SELECT @Usuario = dbo.fnAccesoUsuario(@@SPID)
  SELECT @Usuario = Usuario FROM SincroISSesion WHERE SPID = @@SPID
  SELECT @Contrasena = Contrasena FROM Usuario WHERE Usuario = @Usuario
  RETURN
END
GO

/************** spSincroISActualizarSesion *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISActualizarSesion') and type = 'P') drop procedure dbo.spSincroISActualizarSesion
GO
CREATE PROCEDURE spSincroISActualizarSesion
			@Usuario			varchar(10)
			
--//WITH ENCRYPTION
AS BEGIN
  DELETE FROM SincroISSesion WHERE SPID = @@SPID
  INSERT SincroISSesion (Usuario) VALUES (@Usuario)
END
GO

/************** spSincroISSend *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISSend') and type = 'P') drop procedure dbo.spSincroISSend
GO
CREATE PROCEDURE spSincroISSend
			@Tipo				varchar(100),
			@Datos				xml,
			@Conversacion		uniqueidentifier,
			@SucursalOrigen		int,
			@SucursalDestino	int,
			@Tabla				varchar(100),
			@SincroSolicitud	uniqueidentifier,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Usuario			varchar(10),
	@Contrasena			varchar(32),
    @Solicitud			varchar(max),
    @ID					int

  IF @Datos IS NOT NULL
  BEGIN    
    SELECT @Solicitud = '<?xml version="1.0" encoding="windows-1252"?><Intelisis'+
	  	dbo.fnXML('Sistema', 'Intelisis')+
		dbo.fnXML('Contenido', 'Solicitud')+
		dbo.fnXML('Referencia', 'SincroIS')+
		dbo.fnXML('SubReferencia', @Tipo)+
		dbo.fnXML('Tipo', 'SolicitudPrueba')+'>'+ 
		'<Solicitud>'+CONVERT(varchar(max), @Datos)+'</Solicitud>'+
		'</Intelisis>'
		
    EXEC spSincroISUsuario @Usuario OUTPUT, @Contrasena OUTPUT
    EXEC spIntelisisService @Usuario, @Contrasena, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT, 0, 0, @ID = @ID OUTPUT
    UPDATE IntelisisService SET Conversacion = @Conversacion, SucursalOrigen = @SucursalOrigen, SucursalDestino = @SucursalDestino, SincroTabla = @Tabla, SincroSolicitud = @SincroSolicitud WHERE ID = @ID    
    IF @Tipo NOT IN ('SolicitarRespaldo','SolicitarTRCL','SolicitarPrueba')
    BEGIN
      UPDATE IntelisisService SET Estatus = 'BORRADOR' WHERE ID = @ID    
      DELETE FROM IntelisisServiceLog WHERE ID = @ID AND Estatus = 'SINPROCESAR'
    END
  END  
  RETURN
END
GO

/************** spSincroISSolicitud *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISSolicitud') and type = 'P') drop procedure dbo.spSincroISSolicitud
GO
CREATE PROCEDURE spSincroISSolicitud
			@Solicitud			uniqueidentifier,
			@Tipo				varchar(100)	= NULL,
			@SucursalOrigen		int				= NULL,
			@SucursalDestino	int				= NULL,
			@FechaEnvio			datetime		= NULL,
			@FechaRecibo		datetime		= NULL,
			@Estatus			varchar(15)		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaConclusion	datetime

  IF @Estatus = 'CONCLUIDO' SELECT @FechaConclusion = GETDATE()
  
  IF @Solicitud IS NOT NULL
  BEGIN
    UPDATE SincroISSolicitud
       SET Tipo = ISNULL(@Tipo, Tipo),
    	   SucursalOrigen = ISNULL(@SucursalOrigen, SucursalOrigen),
 		   SucursalDestino = ISNULL(@SucursalDestino, SucursalDestino), 
	       FechaEnvio = ISNULL(@FechaEnvio, FechaEnvio),  
           FechaRecibo = ISNULL(@FechaRecibo, FechaRecibo),
           FechaConclusion = ISNULL(@FechaConclusion, FechaConclusion),
	       Estatus = ISNULL(@Estatus, Estatus)
     WHERE Solicitud = @Solicitud
          
    IF @@ROWCOUNT = 0
      INSERT SincroISSolicitud (
              Solicitud,  Tipo,  SucursalOrigen,  SucursalDestino,  FechaEnvio,  FechaRecibo,  FechaConclusion,  Estatus)
      VALUES (@Solicitud, @Tipo, @SucursalOrigen, @SucursalDestino, @FechaEnvio, @FechaRecibo, @FechaConclusion, @Estatus)
      
  END
  RETURN
END
GO

-- drop table SincroISNoRebote

/**************** fnIDLocal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIDLocal') DROP FUNCTION fnIDLocal
GO
CREATE FUNCTION fnIDLocal (@Tabla varchar(100), @SucursalRemota int, @IDRemoto int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT IDLocal FROM IDLocal WHERE Tabla = @Tabla AND SucursalRemota = @SucursalRemota AND IDRemoto = @IDRemoto)
END
GO

/**************** fnRegistroTemporal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRegistroTemporal') DROP FUNCTION fnRegistroTemporal
GO
CREATE FUNCTION fnRegistroTemporal (@Tabla varchar(100), @SucursalRemota int, @IDRemoto int, @SincroGUID uniqueidentifier)
RETURNS uniqueidentifier
--//WITH ENCRYPTION
AS BEGIN
  --RETURN(SELECT ISNULL(RegistroTemporal,@SincroGUID) FROM IDLocal WHERE Tabla = @Tabla AND SucursalRemota = @SucursalRemota AND IDRemoto = @IDRemoto)
  RETURN(SELECT ISNULL(RegistroTemporal,@SincroGUID) FROM IDLocal WHERE IDRemoto = @IDRemoto AND Tabla = @Tabla AND SucursalRemota = @SucursalRemota)
END
GO


/**************** fnIDLocalModulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIDLocalModulo') DROP FUNCTION fnIDLocalModulo
GO
CREATE FUNCTION fnIDLocalModulo (@Modulo varchar(5), @SucursalRemota int, @IDRemoto int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla varchar(100)
  SELECT @Tabla = dbo.fnSincroISMovTabla(@Modulo)
  RETURN(dbo.fnIDLocal(@Tabla, @SucursalRemota, @IDRemoto))
END
GO

/**************** fnIDRemoto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIDRemoto') DROP FUNCTION fnIDRemoto
GO
CREATE FUNCTION fnIDRemoto (@Tabla varchar(100), @SucursalLocal int, @IDLocal int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT IDRemoto FROM IDLocal WHERE Tabla = @Tabla AND SucursalLocal = @SucursalLocal AND IDLocal = @IDLocal)
END
GO

-- select dbo.fnIDLocalTablaModulo('Cte')
/**************** fnIDLocalTablaModulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIDLocalTablaModulo') DROP FUNCTION fnIDLocalTablaModulo
GO
CREATE FUNCTION fnIDLocalTablaModulo (@Tabla varchar(100))
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT dbo.fnSincroISMovTabla(Modulo) FROM SysTabla WHERE SysTabla = @Tabla)
END
GO

-- select dbo.fnSincroISConcatenarMAX('', '2', ', ')
/**************************** fnSincroISConcatenarMAX ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnSincroISConcatenarMAX') and type in ('fn','tf')) drop function dbo.fnSincroISConcatenarMAX
GO
CREATE FUNCTION fnSincroISConcatenarMAX (@Valor varchar(max), @Agregar varchar(max), @Separador varchar(20))
RETURNS varchar(max)
AS BEGIN		
  DECLARE
    @Resultado	varchar(max)

  SELECT @Valor = ISNULL(@Valor, '')
  IF @Valor <> '' SELECT @Valor = @Valor + @Separador
  RETURN (@Valor + @Agregar)
END
GO

/**************** fnSincroISBloquearInsercionNulos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISBloquearInsercionNulos') DROP FUNCTION fnSincroISBloquearInsercionNulos
GO
CREATE FUNCTION fnSincroISBloquearInsercionNulos 
	(
	@Campo				varchar(50),
	@TipoDatos			varchar(50),
	@AceptaNulos		bit
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(50)

  IF ISNULL(@AceptaNulos,0) = 1 SET @Resultado = RTRIM(@Campo) ELSE
  IF ISNULL(@AceptaNulos,0) = 0 
  BEGIN
    IF @TipoDatos = 'int'              SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',0)'                                                  ELSE
    IF @TipoDatos = 'datetime'         SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',CONVERT(datetime,''01/01/1900''))'                   ELSE
    IF @TipoDatos = 'float'            SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',0.0)'                                                ELSE    
    IF @TipoDatos = 'bit'              SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',0)'                                                  ELSE        
    IF @TipoDatos = 'varchar'          SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ','''')'                                               ELSE            
    IF @TipoDatos = 'char'             SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ','''')'                                               ELSE
    IF @TipoDatos = 'datetime'         SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',CONVERT(timestamp,CONVERT(datetime,''01/01/1900''))' ELSE                    
    IF @TipoDatos = 'uniqueidentifier' SET @Resultado = 'ISNULL(' + RTRIM(@Campo) + ',NEWID())'                                            ELSE
    SET @Resultado = @Campo             
  END
  RETURN (@Resultado)
END
GO

/****************************** spSincroISTablaEstructura ******************************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISTablaEstructura') and type = 'p') drop procedure dbo.spSincroISTablaEstructura
GO
CREATE PROCEDURE spSincroISTablaEstructura
			@Tabla			varchar(255),

			@SELECT			varchar(max)	= NULL OUTPUT,
			@TABLE			varchar(max)	= NULL OUTPUT,
			@DECALRE		varchar(max)	= NULL OUTPUT,
			@SET			varchar(max)	= NULL OUTPUT,
			@PARAMS			varchar(max)	= NULL OUTPUT,
			@WITH			varchar(max)	= NULL OUTPUT,
			@JOIN			varchar(max)	= NULL OUTPUT,
--			@PIPES			varchar(max)	= NULL OUTPUT,
			@VALUES			varchar(max)	= NULL OUTPUT,
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
			@SucursalRemota		int				= NULL,
			@SELECT_VALUES		varchar(max)	= NULL OUTPUT,
			@SELECT_IDLocal		varchar(max)    = NULL OUTPUT,
			@SELECTCampoLocal	bit = 0	               OUTPUT,
			@JOIN_Mov			varchar(max)	= NULL OUTPUT,
			@WHERE_IDLocal		varchar(max)	= NULL OUTPUT,
			@JOIN_Encabezado	varchar(max)	= NULL OUTPUT,
			@WHERE_Encabezado	varchar(max)	= NULL OUTPUT,
			@SET_JOIN_T1		varchar(max)    = NULL OUTPUT,
			@SET_JOIN_T2		varchar(max)    = NULL OUTPUT,			
			@GenerarTabla		bit = 0,
			@TablaVirtual		varchar(50) = NULL, --MEJORANOMXFORMULA
            @SET_JOIN_T3		varchar(max)    = NULL OUTPUT, --MEJORACONTABILIDAD
			@WHERE_Mov			varchar(max)	= NULL OUTPUT, --MEJORAMOVFLUJO
			@JOIN_IDLocal		varchar(max)	= NULL OUTPUT  --REQ12808
						
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo				varchar(265), 
    @TipoDatos			varchar(256), 
    @TipoDatosExt		varchar(256), 
    @AS					varchar(256), 
    @Valor				varchar(256),
    @Ancho				smallint, 
    @AceptaNulos		bit, 
    @EsIdentity			bit, 
    @EsCalculado		bit,
    @Continuar			bit,
    @TablaRemota		varchar(100),
    @TieneTablaRemota	bit,
    @SELECTCampo		varchar(255),
    @TieneModulo		bit,
    @CampoModulo		varchar(100),
    @Modulo				varchar(5),
    @TablaVirtualTipo	varchar(50), --MEJORANOMXFORMULA
    @ContadorCampoIDLocal		int --MEJORAMOVFLUJO
    
  IF @GenerarTabla = 1 DELETE FROM SincroISTablaEstructura WHERE SPID = @@SPID AND Tabla = @Tabla
    
  --Inicializa Variables
  SELECT @SELECT = NULL, @SELECT_VALUES = NULL, @VALUES = NULL, @TABLE = NULL, @DECALRE = NULL, @SET = NULL, @PARAMS = NULL, @WITH = NULL, @JOIN = NULL, @CampoIdentity = NULL, @SELECT_IDLocal = NULL, @SELECTCampoLocal = 0, @WHERE_IDLocal = NULL, @JOIN_Encabezado = NULL, @WHERE_Encabezado = NULL, @SET_JOIN_T1 = NULL, @SET_JOIN_T2 = NULL, @SET_JOIN_T3 = NULL, @ContadorCampoIDLocal = 1, @JOIN_IDLocal = NULL --, @PIPES = NULL --MEJORACONTABILIDAD --MEJORAMOVFLUJO --REQ12808
  SELECT @Prefijo = ISNULL(@Prefijo, ''), @Sufijo = ISNULL(@Sufijo, ''), @JOIN_Tabla1 = ISNULL(@JOIN_Tabla1, ''), @JOIN_Tabla2 = ISNULL(@JOIN_Tabla2, '')

  --@TieneTablaRemota se prende si la tabla que se esta procesando no es encabezado de un modulo pero si forma parte de un modulo
  SELECT @TieneTablaRemota = 0, @TieneModulo = 0
  SELECT @TablaRemota = dbo.fnIDLocalTablaModulo(@Tabla)
  IF @TablaRemota IS NOT NULL AND @Tabla <> @TablaRemota SELECT @TieneTablaRemota = 1

  IF @TablaVirtual <> @Tabla AND NULLIF(@TablaVirtual,'') IS NOT NULL AND @TablaRemota IS NOT NULL AND @TieneTablaRemota = 1 --MEJORANOMXFORMULA
  BEGIN
    SELECT @TablaVirtualTipo = Tipo FROM SysTabla WHERE SysTabla = @TablaVirtual
    IF @TablaVirtualTipo NOT IN ('Movimiento','MovimientoInfo') 
      SELECT @TablaRemota = NULL, @TieneTablaRemota = 0
  END  

  --Si estan vacias, pone un punto.  
  IF @JOIN_Tabla1 <> '' SELECT @JOIN_Tabla1 = @JOIN_Tabla1 + '.'
  IF @JOIN_Tabla2 <> '' SELECT @JOIN_Tabla2 = @JOIN_Tabla2 + '.'
  
  --Si hay llave primaria en la tabla, obtiene la llave primaria y si no, obtiene todos los campos
  IF @PK = 1
    DECLARE crSysCampo CURSOR LOCAL FOR 
     SELECT Campo, TipoDatos, Ancho, ISNULL(AceptaNulos,0), ISNULL(EsIdentity,0), ISNULL(EsCalculado,0)
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

      --Si tiene un ID y no pertenece a un modulo, obtiene el nombre del campo modulo.
      IF (@TieneTablaRemota = 0 OR @Tabla IN ('EmbarqueMov')) AND @Campo LIKE '%Modulo%' AND @Ancho = 5 --REQ12808
        SELECT @TieneModulo = 1, @CampoModulo = @Campo
      
      --Si el campo es un identity, establece una variable
      IF @EsIdentity = 1 SELECT @CampoIdentity = @Campo
      
      --Si es identity y se debe excluir o si es timestamp y se debe de excluir o si es calculado y se debe excluir o si es blob y se debe excluir o si es imagen y se debe de excluir, no continua
      IF @EsIdentity = 1 AND @ExcluirIdentity = 1 SELECT @Continuar = 0
      IF @ExcluirTimeStamp = 1 AND LOWER(@TipoDatos) = 'timestamp' SELECT @Continuar = 0
      IF @ExcluirCalculados = 1 AND @EsCalculado = 1 SELECT @Continuar = 0
      IF @ExcluirBLOBs = 1 AND LOWER(@TipoDatos) IN ('text', 'ntext', 'image') SELECT @Continuar = 0
      IF @ExcluirImage = 1 AND LOWER(@TipoDatos) = 'image' SELECT @Continuar = 0

      --Continua... 
      IF @Continuar = 1
      BEGIN
        SELECT @TipoDatosExt = @TipoDatos
        --Aumenta la longitud a las cadenas de texto o binarias
        IF LOWER(@TipoDatos) IN ('char', 'varchar', 'nchar', 'nvarchar', 'binary')
          SELECT @TipoDatosExt = @TipoDatosExt+'('+CASE WHEN @Ancho = -1 THEN 'max' ELSE CONVERT(varchar, @Ancho) END+')'
  
        --Si se va a incluir la clausula AS, la genera... 
        IF @ASCampo = 1 SELECT @AS = ' AS '+@Campo ELSE SELECT @AS = ''
        
        --Si se envia un valor especifico para reemplazar un campo, pone ese valor en el reemplaso y si no, pone el campo de sustitucion normal.
        IF @Campo = @ReemplazarCampo SELECT @Valor = @ReemplazarValor ELSE SELECT @Valor = @Prefijo+@Campo+@Sufijo+@AS
        
        --SELECT @SELECTCampo = dbo.fnSincroISBloquearInsercionNulos(@Prefijo+@Campo+@Sufijo,@TipoDatos,@AceptaNulos)        
        SELECT @SELECTCampo = @Prefijo+@Campo+@Sufijo

        SELECT @SELECT      = CASE WHEN @EsIdentity = 0 THEN dbo.fnSincroISConcatenarMAX(@SELECT, @SELECTCampo+@AS, ', ') ELSE @SELECT END,                             --Son los campos a actualizar o a insertar
               @VALUES      = dbo.fnSincroISConcatenarMAX(@VALUES, @Valor, ', '),                                       --Son los valores que se van a insertar o los que actualizaran la tabla
               @TABLE       = dbo.fnSincroISConcatenarMAX(@TABLE, @Campo + ' ' + @TipoDatosExt, ', '),                  --Representa la estructura de la tabla
               @WITH        = dbo.fnSincroISConcatenarMAX(@WITH, @Campo + ' ' + @TipoDatosExt, ', '),                   --Representa la estructura de la tabla y se utiliza normalmente para accesar un XML
               @JOIN        = dbo.fnSincroISConcatenarMAX(@JOIN, @JOIN_Tabla1+@Campo+'='+@JOIN_Tabla2+@Campo, ' AND '), --Genera los Joins necesarios
               @DECALRE     = dbo.fnSincroISConcatenarMAX(@DECALRE, '@'+@Campo+' '+@TipoDatosExt, ', '),                --Genera declares de campos
               @SET         = dbo.fnSincroISConcatenarMAX(@SET, @Prefijo+@Campo+@Sufijo+'=@'+@Campo, ', '),             --Genera los SETS de un update
               @SET_JOIN_T1 = dbo.fnSincroISConcatenarMAX(@SET_JOIN_T1, @Prefijo+@Campo+@Sufijo+'='+@JOIN_Tabla1+@Campo, ', '),        --Genera los SETS de un update utilizando combinandolo con la tabla 1             
               @SET_JOIN_T2 = dbo.fnSincroISConcatenarMAX(@SET_JOIN_T2, @Prefijo+@Campo+@Sufijo+'='+@JOIN_Tabla2+@Campo, ', '),        --Genera los SETS de un update utilizando combinandolo con la tabla 2                             
               @PARAMS      = dbo.fnSincroISConcatenarMAX(@PARAMS, '@'+@Campo, ', ')/*,                                 --Genera los parametros de un código dinamico
               @PIPES       = dbo.fnSincroISConcatenarMAX(@PIPES, 'CONVERT(varchar(max), '+@Campo+')', '+"|"+')*/
 
        IF @TieneTablaRemota = 1 AND ((@Campo IN ('ID','IDSeccion','SeccionID') AND @Tabla NOT IN ('Evento')) OR (@Campo IN ('Evento') AND @Tabla IN ('EventoD'))) AND @TipoDatos = 'int' AND @TieneModulo = 0 
        BEGIN
          SELECT @SET_JOIN_T3 = dbo.fnSincroISConcatenarMAX(@SET_JOIN_T3, @Prefijo+@Campo+@Sufijo+'=dbo.fnIDLocal('''+ISNULL(@TablaRemota,'')+''','+CONVERT(varchar, ISNULL(@SucursalRemota,''))+', '+ISNULL(@JOIN_Tabla1,'')+ISNULL(@Campo,'')+')', ', ')        --Genera los SETS de un update utilizando combinandolo con la tabla 1 pero cuando tiene un campo que apunta a un ID --MEJORACONTABILIDAD           
        END ELSE
        BEGIN
          SELECT @SET_JOIN_T3 = dbo.fnSincroISConcatenarMAX(@SET_JOIN_T3, @Prefijo+@Campo+@Sufijo+'='+@JOIN_Tabla1+@Campo, ', ')        --Genera los SETS de un update utilizando combinandolo con la tabla 1 pero cuando tiene un campo que apunta a un ID --MEJORACONTABILIDAD           
        END
               
        --Si se tiene tabla remota y el campo es ID y el tipo de datos es entero busca el id local para ponerlo en los valores que se sustituiran.       
        IF @TieneTablaRemota = 1 AND ((@Campo IN ('ID','IDSeccion','SeccionID') AND @Tabla NOT IN ('Evento')) OR (@Campo IN ('Evento') AND @Tabla IN ('EventoD'))) AND @TipoDatos = 'int' AND @TieneModulo = 0
        BEGIN
          IF @SELECTCampoLocal = 1 SELECT @SELECT_IDLocal = @SELECT_IDLocal + ' OR ' ELSE
          IF @SELECTCampoLocal = 0 SELECT @SELECT_IDLocal = ''
          SELECT @SELECT_IDLocal = @SELECT_IDLocal + '((dbo.fnIDLocal('''+@TablaRemota+''', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))'        
          
          IF @GenerarTabla = 1
          BEGIN
            SELECT @Modulo = Modulo FROM SysTabla WHERE SysTabla = @Tabla
            INSERT SincroISTablaEstructura (SPID,   Tabla,  Modulo,  Campo,                   SucursalRemota,  SELECT_IDLocal)
                                    VALUES (@@SPID, @Tabla, @Modulo, @Prefijo+@Campo+@Sufijo, @SucursalRemota, '((dbo.fnIDLocal('''+@TablaRemota+''', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))')
          END
          
          SELECT @SELECTCampo = 'dbo.fnIDLocal('''+@TablaRemota+''', '+CONVERT(varchar, @SucursalRemota)+', ' +@Prefijo+@Campo+@Sufijo+')', @SELECTCampoLocal = 1                                  
          SELECT @JOIN_Encabezado = ISNULL(@JOIN_Encabezado,'') + ' LEFT OUTER JOIN ' + @TablaRemota + ' ON ' + @Tabla + '.' + @Campo + ' = ' + @TablaRemota + '.ID '
        END          

        --Si el campo es ID y existe un campo de Modulo regresa el id local.          
        IF @TieneModulo = 1 AND @Campo IN ('ID', 'ModuloID', 'OID', 'DID') AND @TipoDatos = 'int' AND @EsIdentity = 0
        BEGIN
          IF @SELECTCampoLocal = 1 SELECT @SELECT_IDLocal = @SELECT_IDLocal + ' OR ', @WHERE_IDLocal = @WHERE_IDLocal + ' AND ', @WHERE_Encabezado = @WHERE_Encabezado + ' OR ', @JOIN_Mov = @JOIN_Mov + ' LEFT OUTER JOIN Mov m' + LTRIM(RTRIM(CONVERT(varchar,@ContadorCampoIDLocal))) + ' ON ', @WHERE_MOV = @WHERE_MOV + ' OR ' ELSE --MEJORAMOVFLUJO
          IF @SELECTCampoLocal = 0 
          BEGIN
            SELECT @SELECT_IDLocal = ''
            SELECT @WHERE_IDLocal = ''
            SELECT @WHERE_Encabezado = ''
            -- SELECT @JOIN_Mov = ' JOIN Mov ON ('+@Tabla+'.'+@CampoModulo+' = Mov.Modulo AND '+@Tabla+'.'+@Campo+' = Mov.ID) '
            SELECT @JOIN_Mov = ' LEFT OUTER JOIN Mov m' + LTRIM(RTRIM(CONVERT(varchar,@ContadorCampoIDLocal))) + ' ON ' --MEJORAMOVFLUJO
            SELECT @WHERE_Mov = '' --MEJORAMOVFLUJO
          END  

          IF @GenerarTabla = 1
          BEGIN
            INSERT SincroISTablaEstructura (SPID,   Tabla,  CampoModulo,                   Campo,                   SucursalRemota,  SELECT_IDLocal)
                                    VALUES (@@SPID, @Tabla, @Prefijo+@CampoModulo+@Sufijo, @Prefijo+@Campo+@Sufijo, @SucursalRemota, '((dbo.fnIDLocalModulo('+@Prefijo+@CampoModulo+@Sufijo+', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL AND '+@Prefijo+@CampoModulo+@Sufijo+' IS NOT NULL))')
          END          

          SELECT @SELECT_IDLocal = @SELECT_IDLocal + '((dbo.fnIDLocalModulo('+@Prefijo+@CampoModulo+@Sufijo+', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL AND '+@Prefijo+@CampoModulo+@Sufijo+' IS NOT NULL))'
          
          SELECT @JOIN_Mov = @JOIN_Mov + ' ' + @Tabla+'.'+@CampoModulo+' = m' + LTRIM(RTRIM(CONVERT(varchar,@ContadorCampoIDLocal))) + '.Modulo AND '+@Tabla+'.'+@Campo+' = m' + LTRIM(RTRIM(CONVERT(varchar,@ContadorCampoIDLocal))) + '.ID '  --MEJORAMOVFLUJO         
          SELECT @WHERE_Mov = @WHERE_Mov + ' ISNULL(m' + LTRIM(RTRIM(CONVERT(varchar,@ContadorCampoIDLocal))) + '.Sucursal,dbo.fnSincroISMovSucursal('+ @Tabla+'.'+@CampoModulo+ ','+@Tabla+'.'+@Campo+')) IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino)) ' --MEJORAMOVFLUJO
          SET @ContadorCampoIDLocal = @ContadorCampoIDLocal + 1 --MEJORAMOVFLUJO
                    
          SELECT @SELECTCampo = 'dbo.fnIDLocalModulo('+@Prefijo+@CampoModulo+@Sufijo+', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+')', @SELECTCampoLocal = 1                        
          SELECT @WHERE_IDLocal = @WHERE_IDLocal + '(NULLIF('+@Tabla+'.'+@Campo+',0) IS NOT NULL AND NULLIF('+@Tabla+'.'+@CampoModulo+','+CHAR(39)+CHAR(39)+') IS NOT NULL)'                    
          SELECT @WHERE_Encabezado = @WHERE_Encabezado + 'dbo.fnVerificarEncabezadoModulo(ISNULL('+@Tabla+'.'+@Campo+',0),'+@Tabla+'.'+@CampoModulo+') = 0 '                    
          SELECT @TieneModulo = 0
        END        
        
        --Si el campo se llama PolizaID, obtiene el id de la poliza en el modulo de contabilidad.
        IF @Campo = 'PolizaID' AND @TipoDatos = 'int'
        BEGIN
          IF @SELECTCampoLocal = 1 SELECT @SELECT_IDLocal = @SELECT_IDLocal + ' OR ' ELSE
          IF @SELECTCampoLocal = 0 SELECT @SELECT_IDLocal = ''
          
          IF @GenerarTabla = 1
          BEGIN
            SELECT @Modulo = Modulo FROM SysTabla WHERE SysTabla = @Tabla
            INSERT SincroISTablaEstructura (SPID,   Tabla,  Modulo, Campo,                   SucursalRemota,  SELECT_IDLocal)
                                    VALUES (@@SPID, @Tabla, 'CONT', @Prefijo+@Campo+@Sufijo, @SucursalRemota, '((dbo.fnIDLocalModulo(''CONT'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))')        
          END
          
          SELECT @SELECT_IDLocal = @SELECT_IDLocal + '((dbo.fnIDLocalModulo(''CONT'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))'        
          SELECT @SELECTCampo = 'dbo.fnIDLocalModulo(''CONT'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+')', @SELECTCampoLocal = 1                
        END          

        --Si el campo se llama GestionID, obtiene el id del movimiento de gestion.
        IF @Campo = 'GestionID' AND @TipoDatos = 'int'
        BEGIN
          IF @SELECTCampoLocal = 1 SELECT @SELECT_IDLocal = @SELECT_IDLocal + ' OR ' ELSE
          IF @SELECTCampoLocal = 0 SELECT @SELECT_IDLocal = ''
          
          IF @GenerarTabla = 1
          BEGIN
            SELECT @Modulo = Modulo FROM SysTabla WHERE SysTabla = @Tabla
            INSERT SincroISTablaEstructura (SPID,   Tabla,  Modulo, Campo,                   SucursalRemota,  SELECT_IDLocal)
                                    VALUES (@@SPID, @Tabla, 'GES',  @Prefijo+@Campo+@Sufijo, @SucursalRemota, '((dbo.fnIDLocalModulo(''GES'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))')        
          END
          
          SELECT @SELECT_IDLocal = @SELECT_IDLocal + '((dbo.fnIDLocalModulo(''GES'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))'        
          SELECT @SELECTCampo = 'dbo.fnIDLocalModulo(''GES'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+')', @SELECTCampoLocal = 1                        
        END  
        
        --Si el campo se llama EmbarqueMov, obtiene el id del movimiento de EmbarqueMov.
        IF @Campo = 'EmbarqueMov' AND @TipoDatos = 'int' --REQ12808
        BEGIN
          IF @SELECTCampoLocal = 1 SELECT @SELECT_IDLocal = @SELECT_IDLocal + ' OR ' ELSE
          IF @SELECTCampoLocal = 0 SELECT @SELECT_IDLocal = ''
          
          IF @GenerarTabla = 1
          BEGIN
            SELECT @Modulo = Modulo FROM SysTabla WHERE SysTabla = @Tabla
            INSERT SincroISTablaEstructura (SPID,   Tabla,  Modulo,  Campo,                   SucursalRemota,  SELECT_IDLocal)
                                    VALUES (@@SPID, @Tabla, 'SIS13', @Prefijo+@Campo+@Sufijo, @SucursalRemota, '((dbo.fnIDLocalModulo(''SIS13'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))')        
          END
          
          SELECT @SELECT_IDLocal = @SELECT_IDLocal + '((dbo.fnIDLocalModulo(''SIS13'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+') IS NULL) AND ('+@Prefijo+@Campo+@Sufijo+' IS NOT NULL))'        
          SELECT @SELECTCampo = 'dbo.fnIDLocalModulo(''SIS13'', '+CONVERT(varchar, @SucursalRemota)+', '+@Prefijo+@Campo+@Sufijo+')', @SELECTCampoLocal = 1                        
        END

        
        --SELECT @SELECTCampo = dbo.fnSincroISBloquearInsercionNulos(@SELECTCampo,@TipoDatos,@AceptaNulos)                
        --Concatena todos los campos EN select_values
        SELECT @SELECT_VALUES = CASE WHEN @EsIdentity = 0 THEN dbo.fnSincroISConcatenarMAX(@SELECT_VALUES,@SELECTCampo+@AS, ', ') ELSE @SELECT_VALUES END
        
        IF @PK = 1 --REQ12808
        BEGIN
          SELECT @JOIN_IDLocal = dbo.fnSincroISConcatenarMAX(@JOIN_IDLocal, @SELECTCampo+'='+@JOIN_Tabla2+@Campo, ' AND ') --Genera los Joins necesarios
        END  
                
        --Si el tipo de datos es char o varchar, aumenta el collate a la estructura de la tabla     
        IF CHARINDEX('CHAR', UPPER(@TipoDatos)) > 0
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

/*    
declare @join_mov varchar(max)
EXEC spSincroISTablaEstructura 'NomXPersonal', @JOIN_Mov = @JOIN_Mov OUTPUT    
select @join_mov
*/

/*
declare
  @datos xml,
@Conversacion uniqueidentifier,
@PaqueteCambios int,
@PaqueteBajas int
select @Conversacion = newid()
EXEC spSincroISEnviarTabla NULL, @Conversacion, 0, 108, 0, 0, 0, 'Art', 'Cuenta', NULL, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT
select @datos, @PaqueteCambios, @PaqueteBajas
*/

/************** spSincroISEnviarTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarTabla') and type = 'P') drop procedure dbo.spSincroISEnviarTabla
GO

CREATE PROCEDURE spSincroISEnviarTabla
                  @Desde                timestamp,
                  @Hasta                timestamp,
                  @Solicitud			uniqueidentifier,
                  @Conversacion         uniqueidentifier,
                  @SucursalOrigen       int,
                  @SucursalDestino		int,
                  @EsSincroFinal        bit,
                  @EsRespaldo			bit,
                  @EsTRCL               bit,              
                  @Tabla                varchar(100),
                  @TablaTipo			varchar(20),
                  @TablaModulo          char(5),
                  @Datos                xml       OUTPUT,
                  @PaqueteCambios       int       OUTPUT, 
                  @PaqueteBajas         int       OUTPUT

--//WITH ENCRYPTION

AS BEGIN
  DECLARE
    @FechaEnvio		datetime,
    @SQL			nvarchar(max),
    @Cambios		nvarchar(max),
    @Bajas			nvarchar(max),
    @WHERE			nvarchar(max),
    @JOIN_Mov		nvarchar(max),
    @WHERE_IDLocal	nvarchar(max)

  SELECT @Datos = NULL, @PaqueteCambios = 0, @PaqueteBajas = 0
  IF dbo.fnCampoExiste(@Tabla, 'SincroID') = 0 OR dbo.fnCampoExiste(@Tabla, 'SincroGUID') = 0 
    EXEC spSincroISActivarTabla @Tabla

  SELECT @TablaTipo = UPPER(@TablaTipo), @TablaModulo = NULLIF(RTRIM(@TablaModulo), ''), @WHERE = '', @Bajas = '', @JOIN_Mov = ''
  IF @TablaTipo IN ('MOVIMIENTO','MOVIMIENTOINFO') AND @SucursalDestino > 0 AND dbo.fnCampoExiste(@Tabla, 'Sucursal') = 1
  BEGIN
    SELECT @WHERE = N'(Sucursal IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino))'
    IF @TablaModulo IS NOT NULL AND dbo.fnCampoExiste(@Tabla, 'SucursalOrigen') = 1
      SELECT @WHERE = @WHERE + N' OR SucursalOrigen IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino))'
    SELECT @WHERE = @WHERE + N')'
  END
  ELSE
  BEGIN

    IF UPPER(@TablaTipo) IN ('MOVIMIENTO','MOVIMIENTOINFO') AND @SucursalDestino > 0 AND ISNULL(dbo.fnCampoExiste(@Tabla, 'Sucursal'),0) = 0 AND @Tabla NOT IN ('Mov')
    BEGIN
      EXEC spSincroISTablaEstructura @Tabla, @JOIN_Mov = @JOIN_Mov OUTPUT
      IF NULLIF(@JOIN_Mov,'') IS NOT NULL
        SELECT @WHERE = N'(Mov.Sucursal IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino)))'
    END  
  END
  
  IF @EsRespaldo = 0
  BEGIN
    SELECT @SQL = N'SELECT @Bajas = CONVERT(nvarchar(max), (SELECT Llave FROM SincroISBaja WHERE Tabla='''+@Tabla+''' AND SincroID BETWEEN @Desde AND @Hasta FOR XML RAW(''Baja''), ROOT(''Bajas'')))'
          
    EXEC sp_executesql @SQL, N'@Bajas nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp', @Bajas OUTPUT, @Desde = @Desde, @Hasta = @Hasta
  END

  IF @EsRespaldo = 0
  BEGIN
    IF @WHERE <> '' SELECT @WHERE = @WHERE + N' AND '
    SELECT @WHERE = @WHERE + N' (SincroID NOT IN (SELECT SincroID FROM SincroISNoRebote WHERE Sucursal=@SucursalDestino)) AND (SincroID BETWEEN @Desde AND @Hasta)'
  END 
 
  IF @WHERE <> '' SELECT @WHERE = N' WHERE '+@WHERE
  SELECT @SQL = N'SELECT @Cambios = CONVERT(nvarchar(max), (SELECT '+@Tabla+N'.* FROM '+@Tabla+ISNULL(@JOIN_Mov,'')+@WHERE+N' FOR XML RAW(''Cambio''), BINARY BASE64, ROOT(''Cambios'')))'

  
  EXEC spSincroISTablaEstructura @Tabla, @WHERE_IDLocal = @WHERE_IDLocal OUTPUT    
  IF NULLIF(@WHERE_IDLocal,'') IS NOT NULL
  BEGIN
    IF @WHERE <> '' SELECT @WHERE = @WHERE + N' AND '
    SELECT @WHERE = @WHERE + '('+@WHERE_IDLocal+') '
  END
        
  EXEC sp_executesql @SQL, N'@Cambios nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp, @SucursalDestino int', @Cambios OUTPUT, @Desde = @Desde, @Hasta = @Hasta, @SucursalDestino = @SucursalDestino
  -- para evitar caracteres raros
    
  SELECT @Cambios = REPLACE(@Cambios,'&#','##')
  SELECT @Cambios = REPLACE(@Cambios,'##x0D','&#x0D')
  SELECT @Cambios = REPLACE(@Cambios,'##x0A','&#x0A')

  SELECT @PaqueteCambios = LEN(@Cambios), @PaqueteBajas = LEN(@Bajas)
  IF @Bajas IS NOT NULL
    SELECT @Cambios = ISNULL(@Cambios, '') + @Bajas

  IF @Cambios IS NOT NULL
    SELECT @Cambios = '<IntelisisSincroIS'+
                  dbo.fnXML('Tipo', 'Tabla')+
                  dbo.fnXMLGID('Solicitud', @Solicitud)+
                  dbo.fnXMLGID('Conversacion', @Conversacion)+
                  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
                  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
                  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '>'+
                  '<Tabla'+
                  dbo.fnXML('Tabla', @Tabla)+
                  dbo.fnXMLBit('EsSincroFinal', @EsSincroFinal)+
                  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
                  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
                  dbo.fnXMLInt('PaqueteCambios', @PaqueteCambios)+
                  dbo.fnXMLInt('PaqueteBajas', @PaqueteBajas)+
                        '>'+
                  NULLIF(RTRIM(@Cambios), '')+
                  '</Tabla></IntelisisSincroIS>'

  SELECT @Datos = CONVERT(xml,@Cambios)
      
  RETURN
END
GO

/************** spSincroISEnviarTablaEnPartes *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarTablaEnPartes') and type = 'P') drop procedure dbo.spSincroISEnviarTablaEnPartes
GO

CREATE PROCEDURE spSincroISEnviarTablaEnPartes
                  @Desde                timestamp,
                  @Hasta                timestamp,
                  @Solicitud			uniqueidentifier,
                  @Conversacion         uniqueidentifier,
                  @SucursalOrigen       int,
                  @SucursalDestino		int,
                  @EsSincroFinal        bit,
                  @EsRespaldo			bit,
                  @EsTRCL               bit,              
                  @Tabla                varchar(100),
                  @TablaTipo			varchar(20),
                  @TablaModulo          char(5),
                  @LongitudPaquete		int,
                  @Datos                xml       OUTPUT,
                  @PaqueteCambios       int       OUTPUT, 
                  @PaqueteBajas         int       OUTPUT,
                  
                  @Continuar			bit       OUTPUT

--//WITH ENCRYPTION

AS BEGIN
  DECLARE
    @FechaEnvio			datetime,
    @SQL				nvarchar(max),
    @Cambios			nvarchar(max),
    @Bajas				nvarchar(max),
    @WHERE				nvarchar(max),
    @JOIN_Mov			nvarchar(max),
    @WHERE_IDLocal		nvarchar(max),
    @JOIN_GUIDSesion	nvarchar(max),
    @WHERE_GUIDSesion	nvarchar(max),
    @RegistrosEnviados	int,
    @RegistrosPorEnviar	int,
    @TruncarTabla		bit,
    @FiltroEspecial		varchar(255),
    @TablaVirtual		bit,
    @TablaVirtualNombre	varchar(50), --MEJORANOMXFORMULA
    @TablaRemota		varchar(50), --OMITIRSINAFECTAR
    @WHERE_Mov			varchar(max) --MEJORAMOVFLUJO  
    
  --Activa la tabla en caso de que este inactiva
  SELECT @Datos = NULL, @PaqueteCambios = 0, @PaqueteBajas = 0, @TablaVirtual = 0, @TablaVirtualNombre = @Tabla --MEJORANOMXFormula
  

  SET @FiltroEspecial = dbo.fnSincroISTablaFiltroEspecial(@Tabla)  
  
  IF @Tabla <> dbo.fnSincroISTablaSinonimo(@Tabla)  
  BEGIN
    SET @TablaVirtualNombre = @Tabla   --MEJORANOMXFORMULA  
    SET @Tabla = dbo.fnSincroISTablaSinonimo(@Tabla)  
    SET @TablaVirtual = 1
  END
  
  IF dbo.fnCampoExiste(@Tabla, 'SincroID') = 0 OR dbo.fnCampoExiste(@Tabla, 'SincroGUID') = 0 
    EXEC spSincroISActivarTabla @Tabla

  SELECT @TablaTipo = UPPER(@TablaTipo), @TablaModulo = NULLIF(RTRIM(@TablaModulo), ''), @WHERE = '', @Bajas = '', @JOIN_Mov = ''

  --Si la tabla es de tipo movimiento y la sucursal destino no es la matriz y la tabla tiene el campo sucursal...  
  IF @TablaTipo IN ('MOVIMIENTO','MOVIMIENTOINFO') AND @SucursalDestino > 0 AND dbo.fnCampoExiste(@Tabla, 'Sucursal') = 1 AND @Tabla NOT IN ('MovFlujo') --MEJORAMOVFLUJO
  BEGIN 
    --Pone un where para que solo envie los movimientos de la sucursal destino
    SELECT @WHERE = N'(Sucursal IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino)) OR ' + CHAR(39) + ISNULL(RTRIM(@TablaModulo),'') + CHAR(39) + ' IN (''PRECI'',''SIS01'',''SIS02'',''SIS03'',''SIS04'',''SIS05'',''SIS06'',''SIS07'',''SIS08'',''SIS09'',''SIS10'',''OFER'',''SIS11'',''SIS12'',''SIS13'')'
    --Le aumenta un or al where para que tambien busque en la sucursal origen
    IF @TablaModulo IS NOT NULL AND dbo.fnCampoExiste(@Tabla, 'SucursalOrigen') = 1
      SELECT @WHERE = @WHERE + N' OR SucursalOrigen IN (SELECT Sucursal FROM dbo.fnSucursalesLigadas(@SucursalDestino))'
    SELECT @WHERE = @WHERE + N')'

  END
  ELSE
  BEGIN
    --Si la tabla no tiene el campo sucursal aumenta un join con la tabla mov para sacar la sucursal y poner un where
    IF UPPER(@TablaTipo) IN ('MOVIMIENTO','MOVIMIENTOINFO') AND @SucursalDestino > 0 AND (ISNULL(dbo.fnCampoExiste(@Tabla, 'Sucursal'),0) = 0 OR @Tabla IN ('MovFlujo'))AND @Tabla NOT IN ('Mov') --MEJORAMOVFLUJO
    BEGIN
      EXEC spSincroISTablaEstructura @Tabla, @JOIN_Mov = @JOIN_Mov OUTPUT, @WHERE_Mov = @WHERE_Mov OUTPUT
      IF NULLIF(@JOIN_Mov,'') IS NOT NULL
        SELECT @WHERE = N'(' + @WHERE_Mov + N' OR ' + CHAR(39) + ISNULL(RTRIM(@TablaModulo),'') + CHAR(39) + ' IN (''PRECI'',''SIS01'',''SIS02'',''SIS03'',''SIS04'',''SIS05'',''SIS06'',''SIS07'',''SIS08'',''SIS09'',''SIS10'',''OFER'',''SIS11'',''SIS12'',''SIS13''))' --MEJORAMOVFLUJO
      ELSE
        SELECT @WHERE = N'(' + CHAR(39) + ISNULL(RTRIM(@TablaModulo),'') + CHAR(39) + N' IN (''PRECI'',''SIS01'',''SIS02'',''SIS03'',''SIS04'',''SIS05'',''SIS06'',''SIS07'',''SIS08'',''SIS09'',''SIS10'',''OFER'',''SIS11'',''SIS12'',''SIS13''))'      
    END  
  END

  SET @TablaRemota = dbo.fnSincroISMovTabla(@TablaModulo) --OMITIRSINAFECTAR
  IF @TablaRemota = @Tabla AND dbo.fnCampoExiste(@Tabla, 'Estatus') = 1 AND @TablaTipo = 'MOVIMIENTO' --OMITIRSINAFECTAR
  BEGIN
    IF @WHERE <> '' SELECT @WHERE = @WHERE + N' AND '
    SELECT @WHERE = @WHERE + N' ('+@Tabla + N'.Estatus NOT IN (''SINAFECTAR'',''BORRADOR'',''CONFIRMAR'',''AUTORIZARE'') OR ' + N'(' + CHAR(39) + ISNULL(RTRIM(@TablaModulo),'') + CHAR(39) + N' IN (''PRECI'',''SIS01'',''SIS02'',''SIS03'',''SIS04'',''SIS05'',''SIS06'',''SIS07'',''SIS08'',''SIS09'',''SIS10'',''SIS11'',''SIS12'',''SIS13''))' + N')'   
  END  

  --Arma el paquete de bajas  
  IF @EsRespaldo = 0
  BEGIN
    SELECT @SQL = N'SELECT @Bajas = CONVERT(nvarchar(max), (SELECT Llave FROM SincroISBaja WHERE Tabla='''+@Tabla+''' AND SincroID BETWEEN @Desde AND @Hasta FOR XML RAW(''Baja''), ROOT(''Bajas'')))'

    --Debug
    PRINT @tabla + ',Env,Query 1,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              
          
    EXEC sp_executesql @SQL, N'@Bajas nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp', @Bajas OUTPUT, @Desde = @Desde, @Hasta = @Hasta

  END
  
  --Pone un where para que no envie los registros que rebotan
  IF @EsRespaldo = 0
  BEGIN
    IF @WHERE <> '' SELECT @WHERE = @WHERE + N' AND '
    SELECT @WHERE = @WHERE + N' ('+@Tabla + N'.SincroID NOT IN (SELECT SincroID FROM SincroISNoRebote WHERE Sucursal=@SucursalDestino)) AND ('+@Tabla + N'.SincroID BETWEEN @Desde AND @Hasta)'
  END  
 
  IF @WHERE <> '' SELECT @WHERE = N' WHERE '+@WHERE
  
  EXEC spSincroISTablaEstructura @Tabla, @WHERE_IDLocal = @WHERE_IDLocal OUTPUT    
  IF NULLIF(@WHERE_IDLocal,'') IS NOT NULL AND ISNULL(@FiltroEspecial,'') = ''
  BEGIN
    IF @WHERE <> '' 
      SELECT @WHERE = @WHERE + N' AND '
    ELSE 
      SELECT @WHERE = @WHERE + N' WHERE '
    SELECT @WHERE = @WHERE + '('+@WHERE_IDLocal+') '
  END

  --Arma el JOIN con SincroISGUIDSesion
--  SELECT @JOIN_GUIDSesion = N' LEFT OUTER JOIN SincroISGUIDSesion sigs ON sigs.SincroGUID = ' + @Tabla + N'.SincroGUID  AND sigs.SPID = ' + CONVERT(varchar,@@SPID) + ' ' 
  
  --Arma el WHERE con SincroISGUIDSesion
--  SELECT @WHERE_GUIDSesion = N' sigs.SincroGUID IS NULL '
--  IF @WHERE <> '' 
--    SELECT @WHERE = @WHERE + N' AND '  
--  ELSE
--    SELECT @WHERE = @WHERE + N' WHERE '  
--  SELECT @WHERE = @WHERE + @WHERE_GUIDSesion

  --Arma el JOIN con SincroISGUIDSesion
  SELECT @JOIN_GUIDSesion = N'' 
  
  --Arma el WHERE con SincroISGUIDSesion
  SELECT @WHERE_GUIDSesion = @Tabla + N'.SincroGUID NOT IN (SELECT SincroGUID FROM SincroISGUIDSesion WHERE SPID = ' + CONVERT(varchar,@@SPID) + ') '
  IF @WHERE <> '' 
    SELECT @WHERE = @WHERE + N' AND '  
  ELSE
    SELECT @WHERE = @WHERE + N' WHERE '  
  SELECT @WHERE = @WHERE + @WHERE_GUIDSesion

  --Esta linea sirve para insertar un filtro especial en tablas que pueden sert tipo Movimiento o Cuenta como por ejemplo la tabla Tarea
  IF ISNULL(@FiltroEspecial,'') <> ''
  BEGIN
    IF @WHERE <> '' 
      SELECT @WHERE = @WHERE + N' AND '  
    ELSE
      SELECT @WHERE = @WHERE + N' WHERE '  
    SELECT @WHERE = @WHERE + @FiltroEspecial
  END
  
  --Genera el XML    
  SELECT @SQL = N'SELECT @Cambios = CONVERT(nvarchar(max), (SELECT TOP ' + CONVERT(varchar,@LongitudPaquete) + ' '+@Tabla+N'.* FROM '+@Tabla+ISNULL(@JOIN_Mov,'')+ISNULL(@JOIN_GUIDSesion,'')+@WHERE + N' ORDER BY ' + @Tabla + N'.SincroGUID ' + N' FOR XML RAW(''Cambio''), BINARY BASE64, ROOT(''Cambios'')))'    

  --Debug
  PRINT @tabla + ',Env,Query 2,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

  EXEC sp_executesql @SQL, N'@Cambios nvarchar(max) OUTPUT, @Desde timestamp, @Hasta timestamp, @SucursalDestino int', @Cambios OUTPUT, @Desde = @Desde, @Hasta = @Hasta, @SucursalDestino = @SucursalDestino

  --Obtiene los registros que ya se enviaron
  SELECT @RegistrosEnviados = ISNULL(COUNT(*),0) FROM SincroISGUIDSesion WHERE SPID = @@SPID

  --Si es el primer paquete de la tabla, se truncara y si no no  
  IF @EsRespaldo = 1 AND @RegistrosEnviados = 0 SELECT @TruncarTabla = 1 ELSE SELECT @TruncarTabla = 0

  IF @EsRespaldo = 1 AND @TruncarTabla = 1 AND @TablaVirtual = 1 AND EXISTS(SELECT SincroTabla FROM IntelisisService WHERE SincroTabla = @Tabla AND Conversacion = @Conversacion AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino) SELECT @TruncarTabla = 0

  --Inserta el GUID de los registros enviados en la tabla SincroISGUIDSesion
  SELECT @SQL = N'INSERT SincroISGUIDSesion (SincroGUID, SPID) SELECT TOP ' + CONVERT(varchar,@LongitudPaquete) + ' '+@Tabla+N'.SincroGUID, ' + CONVERT(varchar,@@SPID) + N' FROM '+@Tabla+ISNULL(@JOIN_Mov,'')+ISNULL(@JOIN_GUIDSesion,'')+@WHERE + N' ORDER BY ' + @Tabla + N'.SincroGUID '

  --Debug
  PRINT @tabla + ',Env,Query 3,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

  EXEC sp_executesql @SQL, N'@Desde timestamp, @Hasta timestamp, @SucursalDestino int', @Desde = @Desde, @Hasta = @Hasta, @SucursalDestino = @SucursalDestino
  
  --Obriene los registros que estan por enviarse  
  SELECT @RegistrosPorEnviar = ISNULL(COUNT(*),0) - @RegistrosEnviados FROM SincroISGUIDSesion WHERE SPID = @@SPID
  
  --Si ya termino de enviar la tabla no continua y si no ha terminado dará otra vuelta
  IF @RegistrosPorEnviar < @LongitudPaquete
    SET @Continuar = 0
  ELSE
    SET @Continuar = 1  

  -- para evitar caracteres raros    
  SELECT @Cambios = REPLACE(@Cambios,'&#','##')
  SELECT @Cambios = REPLACE(@Cambios,'##x0D','&#x0D')
  SELECT @Cambios = REPLACE(@Cambios,'##x0A','&#x0A')

  SELECT @PaqueteCambios = LEN(@Cambios), @PaqueteBajas = LEN(@Bajas)
  IF @Bajas IS NOT NULL
    SELECT @Cambios = ISNULL(@Cambios, '') + @Bajas

  IF @Cambios IS NOT NULL
    SELECT @Cambios = '<IntelisisSincroIS'+
                  dbo.fnXML('Tipo', 'Tabla')+
                  dbo.fnXMLGID('Solicitud', @Solicitud)+
                  dbo.fnXMLGID('Conversacion', @Conversacion)+
                  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
                  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
                  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '>'+
                  '<Tabla'+
                  dbo.fnXML('Tabla', @Tabla)+
                  dbo.fnXML('TablaVirtual', ISNULL(@TablaVirtualNombre,''))+  --MejoraNomXFormula                                  
                  dbo.fnXMLBit('EsSincroFinal', @EsSincroFinal)+
                  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
                  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
                  dbo.fnXMLBit('Truncar', @TruncarTabla)+                  
                  dbo.fnXMLInt('PaqueteCambios', @PaqueteCambios)+
                  dbo.fnXMLInt('PaqueteBajas', @PaqueteBajas)+
                        '>'+
                  NULLIF(RTRIM(@Cambios), '')+
                  '</Tabla></IntelisisSincroIS>'

  SELECT @Datos = CONVERT(xml,@Cambios)
      
  RETURN
END
GO

/************** spSincroISEnviarTablasEnPartes *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarTablasEnPartes') and type = 'P') drop procedure dbo.spSincroISEnviarTablasEnPartes
GO
CREATE PROCEDURE spSincroISEnviarTablasEnPartes
			@SucursalDestino	int = 0,
			@EsSincroFinal		bit = 0,
			@EsRespaldo			bit = 0,
			@EsTRCL				bit = 0,
			@EsPrueba			bit = 0,
			@Solicitud			uniqueidentifier	= NULL,
			@Conversacion		uniqueidentifier    = NULL,			
			@FechaEnvio			datetime			= NULL OUTPUT,
			@Ok					int					= NULL OUTPUT,
			@OkRef				varchar(255)		= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen					int,
    @Desde							timestamp,
    @Hasta							timestamp,
    @SQL							nvarchar(max),
    @Tabla							varchar(100),
    @TablaTipo						varchar(20),
    @TablaModulo					char(5),
    @EnviarTabla					bit,
    @Datos							xml,
    @PaqueteCambios					int, 
    @PaqueteBajas					int,
    @Conteo							bit,
    @SQL_ERROR_NUMBER				int,
    @SQL_ERROR_MESSAGE				varchar(255),
    @SincroISLongitudPaquete		int,
    @Continuar						bit,
    @IDRemotoDesde					timestamp,
    @IDRemotoHasta					timestamp,
    @ContadorLimpieza				int
    
    
  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Conteo = 0, @ContadorLimpieza = 0
  SELECT @SucursalOrigen = Sucursal, @SincroISLongitudPaquete = SincroISLongitudPaquete FROM Version
  
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  --CREATE TABLE #SincroISGUIDSesion(
  --  SincroGUID		uniqueidentifier	NOT NULL,

  --  CONSTRAINT priSincroISGUIDSesionT PRIMARY KEY CLUSTERED (SincroGUID)
  --)

  --BEGIN TRY
    IF @EsPrueba = 1
    BEGIN
      SELECT @Datos = '<IntelisisSincroIS'+
  			dbo.fnXML('Tipo', 'Prueba')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
		      '/>'
      EXEC spSincroISSend 'Prueba', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
    END ELSE
    BEGIN
      EXEC spSincroISControl @SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio OUTPUT, @Desde OUTPUT, @Hasta OUTPUT
      EXEC spSincroISIDRemotoControl @SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio, @IDRemotoDesde OUTPUT, @IDRemotoHasta OUTPUT      
      
      DECLARE crSincroISEnviar CURSOR LOCAL FOR 
       SELECT SysTabla, UPPER(dbo.fnSincroISTablaTipo(SysTabla)), Modulo
         FROM SysTabla
        WHERE SincroActivo = 1 
          AND UPPER(NULLIF(RTRIM(dbo.fnSincroISTablaTipo(SysTabla)), '')) NOT IN (NULL, 'N/A') 
          AND (@EsRespaldo = 1 OR CONVERT(timestamp,dbo.fnSincroISSincroIDTablaSinonimo(SysTabla,CONVERT(int,SincroID))) BETWEEN @Desde AND @Hasta OR @Tabla = 'IDRemoto')
        ORDER BY SincroOrden, SysTabla

      OPEN crSincroISEnviar
      FETCH NEXT FROM crSincroISEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
      BEGIN
        IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(dbo.fnSincroISTablaSinonimo(@Tabla)) = 1
        BEGIN      
          SELECT @EnviarTabla = 1
          IF @EsTRCL = 1 AND @TablaTipo NOT IN ('MAESTRO', 'CUENTA') SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo IN ('CUENTASUCURSAL', 'CUENTAREGION', 'SALDOSUCURSAL', 'SALDOREGION') AND @SucursalOrigen > 0 SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo = 'SUCURSALINFOMATRIZ' AND @SucursalOrigen = 0 SELECT @EnviarTabla = 0 ELSE
          IF @EsRespaldo = 0 AND @TablaTipo = 'MAESTRO' AND @SucursalOrigen > 0 AND @Tabla NOT IN ('IDRemoto') SELECT @EnviarTabla = 0           
          IF @EnviarTabla = 1
          BEGIN
            --Inicializa la tabla de registros enviados
            DELETE FROM SincroISGUIDSesion WHERE SPID = @@SPID

            --Continua hasta que se terminen de transmitir todos los registros de la tabla
            SET @Continuar = 1          
            WHILE @Continuar = 1
            BEGIN
              IF @Tabla NOT IN ('IDRemoto')
              BEGIN
                EXEC spSincroISEnviarTablaEnPartes @Desde, @Hasta, @Solicitud, @Conversacion, @SucursalOrigen, @SucursalDestino, @EsSincroFinal, @EsRespaldo, @EsTRCL, @Tabla, @TablaTipo, @TablaModulo, @SincroISLongitudPaquete, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT, @Continuar OUTPUT
              END ELSE
              BEGIN
                EXEC spSincroISEnviarTablaEnPartes @IDRemotoDesde, @IDRemotoHasta, @Solicitud, @Conversacion, @SucursalOrigen, @SucursalDestino, @EsSincroFinal, @EsRespaldo, @EsTRCL, @Tabla, @TablaTipo, @TablaModulo, @SincroISLongitudPaquete, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT, @Continuar OUTPUT              
              END                
            
              IF @Datos IS NOT NULL
              BEGIN            
                EXEC spSincroISSend 'Sincro', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, @Tabla, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
                EXEC spSincroISLog @Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalOrigen, @SucursalDestino, @FechaEnvio, NULL
                SELECT @Conteo = @Conteo + 1
              END
            
            
            END
            
            SET @ContadorLimpieza = @ContadorLimpieza + 1
            IF @ContadorLimpieza = 20
            BEGIN
              CHECKPOINT 
              DBCC DROPCLEANBUFFERS
              SET @ContadorLimpieza = 0  
            END
            
          END
        END
        FETCH NEXT FROM crSincroISEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      END
      CLOSE crSincroISEnviar
      DEALLOCATE crSincroISEnviar
      
      /* Hay que checar bien esto del conteo porque puede genear un rebote permantent si se quita */
      IF @Conteo > 0 OR NOT EXISTS(SELECT 1 FROM IntelisisService WHERE Referencia = 'SincroIS' AND SubReferencia = 'SincroFinal' AND Estatus = 'BORRADOR' AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino) OR @SucursalOrigen = 0 --arcc
      BEGIN
        SELECT @Datos = '<IntelisisSincroIS'+
    		  dbo.fnXML('Tipo', 'SincroFinal')+
    		  dbo.fnXMLGID('Solicitud', @Solicitud)+
    		  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
    		  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
    		  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
    		  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
    		  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
    		  '/>'
        EXEC spSincroISSend 'SincroFinal', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
        IF @EsRespaldo = 0 AND @EsTRCL = 0
          EXEC spSincroISSolicitud @Solicitud, 'Sincronizacion', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      END
    END
    
  --DROP TABLE #SincroISGUIDSesion    
  
  --END TRY
  --BEGIN CATCH
  --  SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
  --END CATCH
  EXEC spSincroISOk @Conversacion, 'SincroIS/Sincro', @Datos, @Tabla, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
  
  
  RETURN
END
GO

-- spSincroISEnviarTablas 0
/************** spSincroISEnviarTablas *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarTablas') and type = 'P') drop procedure dbo.spSincroISEnviarTablas
GO
CREATE PROCEDURE spSincroISEnviarTablas
			@SucursalDestino	int = 0,
			@EsSincroFinal		bit = 0,
			@EsRespaldo			bit = 0,
			@EsTRCL				bit = 0,
			@EsPrueba			bit = 0,
			@Solicitud			uniqueidentifier	= NULL,
			@Conversacion		uniqueidentifier    = NULL,			
			@FechaEnvio			datetime			= NULL OUTPUT,
			@Ok					int					= NULL OUTPUT,
			@OkRef				varchar(255)		= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @Desde				timestamp,
    @Hasta				timestamp,
    @SQL				nvarchar(max),
    @Tabla				varchar(100),
    @TablaTipo			varchar(20),
    @TablaModulo		char(5),
    @EnviarTabla		bit,
    @Datos				xml,
    @PaqueteCambios		int, 
    @PaqueteBajas		int,
    @Conteo				bit,
    @SQL_ERROR_NUMBER	int,
    @SQL_ERROR_MESSAGE	varchar(255)

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Conteo = 0
  SELECT @SucursalOrigen = Sucursal FROM Version

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  --BEGIN TRY
    IF @EsPrueba = 1
    BEGIN
      SELECT @Datos = '<IntelisisSincroIS'+
  			dbo.fnXML('Tipo', 'Prueba')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
		      '/>'
      EXEC spSincroISSend 'Prueba', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
    END ELSE
    BEGIN
      EXEC spSincroISControl @SucursalOrigen, @SucursalDestino, @Conversacion, @FechaEnvio OUTPUT, @Desde OUTPUT, @Hasta OUTPUT
      DECLARE crSincroISEnviar CURSOR LOCAL FOR 
       SELECT SysTabla, UPPER(dbo.fnSincroISTablaTipo(SysTabla)), Modulo
         FROM SysTabla
        WHERE SincroActivo = 1 AND UPPER(NULLIF(RTRIM(dbo.fnSincroISTablaTipo(SysTabla)), '')) NOT IN (NULL, 'N/A') AND (@EsRespaldo = 1 OR SincroID BETWEEN @Desde AND @Hasta)
        ORDER BY SincroOrden, SysTabla

      OPEN crSincroISEnviar
      FETCH NEXT FROM crSincroISEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL 
      BEGIN
        IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(@Tabla) = 1
        BEGIN
          SELECT @EnviarTabla = 1
          IF @EsTRCL = 1 AND @TablaTipo NOT IN ('MAESTRO', 'CUENTA') SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo IN ('CUENTASUCURSAL', 'CUENTAREGION', 'SALDOSUCURSAL', 'SALDOREGION') AND @SucursalOrigen > 0 SELECT @EnviarTabla = 0 ELSE
          IF @TablaTipo = 'SUCURSALINFOMATRIZ' AND @SucursalOrigen = 0 SELECT @EnviarTabla = 0 ELSE
          IF @EsRespaldo = 0 AND @TablaTipo = 'MAESTRO' AND @SucursalOrigen > 0 SELECT @EnviarTabla = 0           
          IF @EnviarTabla = 1
          BEGIN
            EXEC spSincroISEnviarTabla @Desde, @Hasta, @Solicitud, @Conversacion, @SucursalOrigen, @SucursalDestino, @EsSincroFinal, @EsRespaldo, @EsTRCL, @Tabla, @TablaTipo, @TablaModulo, @Datos OUTPUT, @PaqueteCambios OUTPUT, @PaqueteBajas OUTPUT
            
            IF @Datos IS NOT NULL
            BEGIN            
              EXEC spSincroISSend 'Sincro', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, @Tabla, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
              EXEC spSincroISLog @Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalOrigen, @SucursalDestino, @FechaEnvio, NULL
              SELECT @Conteo = @Conteo + 1
            END
          END
        END
        FETCH NEXT FROM crSincroISEnviar INTO @Tabla, @TablaTipo, @TablaModulo
      END
      CLOSE crSincroISEnviar
      DEALLOCATE crSincroISEnviar

      /* Hay que checar bien esto del conteo porque puede genear un rebote permantent si se quita */
      IF @Conteo > 0 
      BEGIN
        SELECT @Datos = '<IntelisisSincroIS'+
			  dbo.fnXML('Tipo', 'SincroFinal')+
  			  dbo.fnXMLGID('Solicitud', @Solicitud)+
			  dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			  dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			  dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
			  dbo.fnXMLBit('EsRespaldo', @EsRespaldo)+
			  dbo.fnXMLBit('EsTRCL', @EsTRCL)+
			'/>'
        EXEC spSincroISSend 'SincroFinal', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
        IF @EsRespaldo = 0 AND @EsTRCL = 0
          EXEC spSincroISSolicitud @Solicitud, 'Sincronizacion', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      END
    END
  --END TRY
  --BEGIN CATCH
  --  SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
  --END CATCH
  EXEC spSincroISOk @Conversacion, 'SincroIS/Sincro', @Datos, @Tabla, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/************** spSincroISRecibirSincro *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISRecibirSincro') and type = 'P') drop procedure dbo.spSincroISRecibirSincro
GO
CREATE PROCEDURE spSincroISRecibirSincro
			@iDatos				int,
			@Solicitud			uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio			datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Brincar			bit				OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla				varchar(100),
    @FechaRecibo		datetime,
    @EsRespaldo			bit,
    @EsTRCL				bit,
    @TruncarTabla		bit,
    @PaqueteCambios		int, 
    @PaqueteBajas		int,
    @SQL				nvarchar(max),
    @SELECT				varchar(max),
    @SELECT2			varchar(max),    
    @SELECT_VALUES		varchar(max),
	@SELECT_VALUES2		varchar(max),    
    @WITH				varchar(max),
    @JOIN				varchar(max),
	@SET_JOIN			varchar(max),    
    @CampoIdentity		varchar(100),
	@SQL_ERROR_NUMBER	int,
	@SQL_ERROR_MESSAGE	varchar(255),
	@SELECT_IDLocal		nvarchar(max),
	@SELECTCampoLocal	bit,
	@ModuloCur			varchar(100),
	@CampoCur			varchar(100),	
	@SucursalRemota		int,
	@Empresa			varchar(5),
	@Usuario			varchar(10),
	@IDRemoto			int,
	@SucursalLocalCur	int,
	@TablaVirtual		varchar(50), --MEJORANOMXFORMULA
	@SET_JOIN_UPDATE	varchar(max), --MEJORACONTABILIDAD
    @JOIN_QUERY11			varchar(max), --REQ12808	
    @SELECT_VALUES_QUERY11	varchar(max)  --REQ12808

  SELECT @SQL_ERROR_NUMBER = NULL, @SQL_ERROR_MESSAGE = NULL
  EXEC spSetInformacionContexto 'SINCROIS', 1  

  --SET CONTEXT_INFO 0x1
/*  
  BEGIN TRY  
*/  
    SELECT @FechaRecibo = GETDATE()    
    DECLARE crSincroISRecibirTablas CURSOR LOCAL FOR
     SELECT  Tabla, ISNULL(EsRespaldo, 0), ISNULL(EsTRCL, 0), ISNULL(Truncar,0), PaqueteCambios, PaqueteBajas, TablaVirtual --REQ12808
       FROM OPENXML (@iDatos, '/Intelisis/Solicitud/IntelisisSincroIS/Tabla')
       WITH (Tabla varchar(100), EsRespaldo bit, EsTRCL bit, Truncar bit, PaqueteCambios int, PaqueteBajas int, TablaVirtual varchar(50)) --REQ12808
      
    OPEN crSincroISRecibirTablas
    FETCH NEXT FROM crSincroISRecibirTablas INTO @Tabla, @EsRespaldo, @EsTRCL, @TruncarTabla, @PaqueteCambios, @PaqueteBajas, @TablaVirtual --REQ12808
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @EsRespaldo = 1 AND @SucursalLocal = 0
      BEGIN
        IF (SELECT SincroISRecibirRespaldoMatriz FROM Version) = 0 SELECT @Ok = 17030
      END
      IF @@FETCH_STATUS <> -2 AND ((@SucursalLocal = 0 AND @SucursalSincro > 0) OR (@SucursalLocal > 0 AND @SucursalSincro = 0)) AND dbo.fnTablaExiste(@Tabla) = 1
      BEGIN
        EXEC spSincroISTablaEstructura @Tabla, @Prefijo = 'u.', @ExcluirIdentity=1, @ExcluirTimeStamp = 1, @ExcluirCalculados=1, @JOIN_TABLA1='x', @SET_JOIN_T1 = @SET_JOIN OUTPUT, @TablaVirtual = @TablaVirtual, @SET_JOIN_T3 = @SET_JOIN_UPDATE OUTPUT --MEJORANOMXFORMULA --MEJORACONTABILIDAD           
        EXEC spSincroISTablaEstructura @Tabla, @SELECT_VALUES = @SELECT_VALUES2 OUTPUT, @Prefijo = 'x.', @ExcluirTimeStamp = 1, @ExcluirCalculados=1, @SucursalRemota = @SucursalSincro, @TablaVirtual = @TablaVirtual --MEJORANOMXFORMULA       
        EXEC spSincroISTablaEstructura @Tabla, @SELECT = @SELECT2 OUTPUT, @ExcluirIdentity=1, @ExcluirTimeStamp = 1, @ExcluirCalculados=1, @TablaVirtual = @TablaVirtual --MEJORANOMXFORMULA                                          
        EXEC spSincroISTablaEstructura @Tabla, @SELECT = @SELECT OUTPUT, @WITH = @WITH OUTPUT, @CampoIdentity = @CampoIdentity OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @SucursalRemota = @SucursalSincro, @SELECT_VALUES = @SELECT_VALUES OUTPUT, @SELECT_IDLocal = @SELECT_IDLocal OUTPUT, @SELECTCampoLocal = @SELECTCampoLocal OUTPUT, @GenerarTabla = 1, @TablaVirtual = @TablaVirtual --MEJORANOMXFORMULA      

        IF @SELECTCampoLocal = 1
        BEGIN        
          DELETE FROM SincroISInsertarEncabezado WHERE SPID = @@SPID

          DECLARE crTablaEstructura CURSOR FOR
           SELECT ISNULL(CASE WHEN Modulo IS NULL THEN NULL ELSE CHAR(39) + Modulo + CHAR(39) END,CampoModulo), SucursalRemota, SELECT_IDLocal, Campo
             FROM SincroISTablaEstructura
            WHERE [SPID] = @@SPID
              AND Tabla = @Tabla

          OPEN crTablaEstructura
          FETCH NEXT FROM crTablaEstructura INTO @ModuloCur, @SucursalRemota, @SELECT_IDLocal, @CampoCur
          WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          BEGIN
            SELECT @SELECT_IDLocal = N'INSERT SincroISInsertarEncabezado (SPID,  Tabla,  Modulo,               Empresa,                               Usuario,                             IDRemoto,                SucursalRemota,  SucursalLocal) ' + 
                                     N'                           SELECT  @SPID, @Tabla, ' + @ModuloCur + ', ' + CHAR(39) + 'ERROR' + CHAR(39) + ', ' + CHAR(39) + 'ERROR' + CHAR(39) + ', ' + @CampoCur + ',       @SucursalRemota, @SucursalLocal ' +
                                     N'FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') WHERE '+@SELECT_IDLocal+' '          


            --Debug
            PRINT @tabla + ',Rec,Query 1,'  + convert(varchar,getdate(),126) + ','+@SELECT_IDLocal 	
                                     
            EXEC sp_executesql @SELECT_IDLocal, N'@iDatos int, @SPID int, @Tabla varchar(100), @Modulo varchar(5), @SucursalRemota int, @SucursalLocal int', @iDatos = @iDatos, @SPID = @@SPID, @Tabla = @Tabla, @Modulo = @ModuloCur, @SucursalRemota = @SucursalRemota, @SucursalLocal = @SucursalLocal                                  

            FETCH NEXT FROM crTablaEstructura INTO @ModuloCur, @SucursalRemota, @SELECT_IDLocal, @CampoCur
          END
          CLOSE crTablaEstructura
          DEALLOCATE crTablaEstructura

          DECLARE crInsertarEncabezado CURSOR FOR
           SELECT Modulo, Empresa, Usuario, IDRemoto, SucursalRemota, SucursalLocal
             FROM SincroISInsertarEncabezado
            WHERE [SPID] = @@SPID
              AND Tabla = @Tabla
            GROUP BY Modulo, Empresa, Usuario, IDRemoto, SucursalRemota, SucursalLocal 

          OPEN crInsertarEncabezado
          FETCH NEXT FROM crInsertarEncabezado INTO @ModuloCur, @Empresa, @Usuario, @IDRemoto, @SucursalRemota, @SucursalLocalCur
          WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
          BEGIN
            EXEC spSincroISInsertarEncabezado @ModuloCur, @Empresa, @Usuario, @IDRemoto, @SucursalRemota, @SucursalLocalCur, @Ok OUTPUT, @OkRef OUTPUT
            FETCH NEXT FROM crInsertarEncabezado INTO @ModuloCur, @Empresa, @Usuario, @IDRemoto, @SucursalRemota, @SucursalLocalCur
          END
          CLOSE crInsertarEncabezado
          DEALLOCATE crInsertarEncabezado
                             
        END

        EXEC spSincroISTablaEstructura @Tabla, @JOIN = @JOIN OUTPUT, @JOIN_Tabla1 = @Tabla, @JOIN_Tabla2 = 'x', @PK = 1, @TablaVirtual = @TablaVirtual --MEJORANOMXFORMULA      

        -- si no tiene llave primaria que no haga nada
        IF NULLIF(RTRIM(@JOIN), '') IS NOT NULL
        BEGIN
          EXEC spSincroISLog @Solicitud, @Conversacion, @Tabla, @PaqueteCambios, @PaqueteBajas, @SucursalSincro, @SucursalLocal, @FechaEnvio, @FechaRecibo
          EXEC spSincroISSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'RECIBIENDO'

          IF @EsRespaldo = 1
          BEGIN
            IF @TruncarTabla = 1
            BEGIN
          
              --SELECT @SQL = N'TRUNCATE TABLE '+@Tabla
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 DELETE FROM ' + @Tabla + ' FROM ' + @Tabla + ' t LEFT OUTER JOIN IDLocal i ON t.SincroGUID = i.RegistroTemporal WHERE i.RegistroTemporal IS NULL' 
              --Debug
              PRINT @tabla + ',Rec,Query 2,'  + convert(varchar,getdate(),126) + ','+@SQL 	
              EXEC sp_executesql @SQL            
            END  
            --Inserta en la tabla con los valores del XML          
            IF @CampoIdentity IS NOT NULL
            BEGIN
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N' UPDATE u ' +
                              N'  SET ' + @SET_JOIN + N' ' +
                              N' FROM ' + @Tabla + N' AS u JOIN OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH (' + @WITH + N') AS x ' +
                              N'   ON  (SELECT ISNULL(RegistroTemporal,x.SincroGUID) FROM IDLocal WHERE IDRemoto = x.' + RTRIM(LTRIM(@CampoIdentity)) + ' AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND SucursalRemota = ' + RTRIM(CONVERT(varchar,@SucursalSincro)) + ') = u.SincroGUID '
              --Debug
              PRINT @tabla + ',Rec,Query 3,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos       
              
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'INSERT '+@Tabla+ N' ('+@SELECT2+N') '+
                            N'SELECT '+@SELECT_VALUES2+N' ' +
                            N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x LEFT OUTER JOIN ' + @Tabla + ' t ' +
                            N'    ON t.SincroGUID = x.SincroGUID ' + 
                            N' WHERE t.SincroGUID IS NULL '                    

              --Debug
              PRINT @tabla + ',Rec,Query 4,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              
                            
              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos                                           
            
            END ELSE
            BEGIN
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'INSERT '+@Tabla+ N' ('+@SELECT+N') '+
                            N'SELECT '+@SELECT_VALUES+N' FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+')'
              --Debug
              PRINT @tabla + ',Rec,Query 5,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
            
            END
            
          END ELSE
          BEGIN
            --Borra los registros que se daran de baja
            IF @CampoIdentity IS NOT NULL
            BEGIN
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'DELETE '+@Tabla+N' WHERE SincroGUID IN (SELECT dbo.fnRegistroTemporal(' + CHAR(39) +  @Tabla + CHAR(39) + N',' + RTRIM(LTRIM(CONVERT(varchar,@SucursalSincro))) + N',' + RTRIM(LTRIM(@CampoIdentity))+ N',SincroGUID) FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Bajas/Baja/Llave/Llave'', 1) WITH (' + RTRIM(LTRIM(@CampoIdentity))+ N' int, SincroGUID uniqueidentifier))'  + dbo.fnSincroISTablaConMovimientos(@Tabla)                                                  
                            --N'DELETE '+@Tabla+N' WHERE SincroGUID IN (SELECT (SELECT ISNULL(RegistroTemporal,SincroGUID) FROM IDLocal WHERE IDRemoto = x.' + RTRIM(LTRIM(@CampoIdentity)) + ' AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND SucursalRemota = ' + RTRIM(CONVERT(varchar,@SucursalSincro)) + ') FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Bajas/Baja/Llave/Llave'', 1) WITH (' + RTRIM(LTRIM(@CampoIdentity))+ N' int, SincroGUID uniqueidentifier))'            
              --Debug
              PRINT @tabla + ',Rec,Query 6,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
              
            END ELSE
            BEGIN
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'DELETE '+@Tabla+N' WHERE SincroGUID IN (SELECT SincroGUID FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Bajas/Baja/Llave/Llave'', 1) WITH (SincroGUID uniqueidentifier))' + dbo.fnSincroISTablaConMovimientos(@Tabla)                                        
              --Debug
              PRINT @tabla + ',Rec,Query 7,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos            
            END

            --Borra los registros que se cambiaran cuando no tienen identitys y cuando si, solo hace update 
            IF @CampoIdentity IS NOT NULL
            BEGIN
              --SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
              --              N'DELETE '+@Tabla+N' WHERE SincroGUID IN (SELECT dbo.fnRegistroTemporal(' + CHAR(39) +  @Tabla + CHAR(39) + N',' + RTRIM(LTRIM(CONVERT(varchar,@SucursalSincro))) + N',' + RTRIM(LTRIM(@CampoIdentity))+ N',SincroGUID) FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH (' + RTRIM(LTRIM(@CampoIdentity))+ N' int, SincroGUID uniqueidentifier))'                            
              --EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos       

              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N' UPDATE u ' +
                              N'  SET ' + @SET_JOIN_UPDATE + N' ' + --MEJORACONTABILIDAD
                              N' FROM ' + @Tabla + N' AS u JOIN OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH (' + @WITH + N') AS x ' +
                              N'   ON  (SELECT ISNULL(RegistroTemporal,x.SincroGUID) FROM IDLocal WHERE IDRemoto = x.' + RTRIM(LTRIM(@CampoIdentity)) + ' AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND SucursalRemota = ' + RTRIM(CONVERT(varchar,@SucursalSincro)) + ') = u.SincroGUID '
              --Debug
              PRINT @tabla + ',Rec,Query 8,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos       
              
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'INSERT '+@Tabla+ N' ('+@SELECT2+N') '+
                            N'SELECT '+@SELECT_VALUES2+N' ' +
                            N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x LEFT OUTER JOIN ' + @Tabla + ' t ' +
                            N'    ON t.SincroGUID = x.SincroGUID ' + 
                            N' WHERE t.SincroGUID IS NULL '                            
              --Debug
              PRINT @tabla + ',Rec,Query 9,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
              
            END ELSE
            BEGIN
              SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                            N'DELETE '+@Tabla+N' WHERE SincroGUID IN (SELECT SincroGUID FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH (SincroGUID uniqueidentifier))'
              --Debug
              PRINT @tabla + ',Rec,Query 10,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos                   

                EXEC spSincroISTablaEstructura @Tabla, @CampoIdentity = @CampoIdentity OUTPUT, @ExcluirTimeStamp = 1, @ExcluirCalculados = 1, @SucursalRemota = @SucursalSincro, @SELECT_VALUES = @SELECT_VALUES_QUERY11 OUTPUT, @GenerarTabla = 0, @TablaVirtual = @TablaVirtual, @Prefijo = 'x.' --REQ12808                
                EXEC spSincroISTablaEstructura @Tabla, @JOIN_IDLocal = @JOIN_QUERY11 OUTPUT, @JOIN_Tabla1 = '', @JOIN_Tabla2 = 't', @Prefijo = 'x.', @PK = 1, @SucursalRemota = @SucursalSincro --REQ12808
                              
                SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + --REQ12808
                              N'INSERT '+@Tabla+ N' ('+@SELECT+N') '+
                              N'SELECT '+@SELECT_VALUES_QUERY11+N' FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x ' +
                              N'  LEFT OUTER JOIN ' + @Tabla + N' t ON ' +  @JOIN_QUERY11 + ' ' +
                              N' WHERE t.SincroID IS NULL '                              
              --Debug
              PRINT @tabla + ',Rec,Query 11,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

              EXEC sp_executesql @SQL, N'@iDatos int', @iDatos = @iDatos
              
            END
          END

          --Actualiza el campo UltimoCambio con la fecha y hora actual
          SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + 
                        N'UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+''''          
          --Debug
          PRINT @tabla + ',Rec,Query 12,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

          EXEC sp_executesql @SQL
          
          --Si existe un campo IDENTITY Inserta el registro en la tabla IDLocal (IDLocal) 
          
          IF @CampoIdentity IS NOT NULL
          BEGIN
          
            SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' +             
                          N'DELETE FROM IDLocal ' +
                          N'FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x JOIN IDLocal il ' +
                          N'ON il.IDRemoto = x.' + @CampoIdentity + ' JOIN ' + @Tabla + ' t ' +
                          N'ON (t.SincroGUID = ISNULL(il.RegistroTemporal,x.SincroGUID) OR t.SincroGUID = x.SincroGUID) ' +
                          N'WHERE il.Tabla = ' + CHAR(39) + @Tabla + char(39) + ' ' +
                          N'AND il.SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +
                          N'AND IDRemoto = x.' + @CampoIdentity + ' ' + 
                          N'AND Tabla = ' + CHAR(39) + @Tabla + char(39) + ' ' + 
                          N'AND SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' + 
                          N'INSERT IDLocal (Tabla,                                    SucursalRemota,                                     IDRemoto,                  SucursalLocal,                                         IDLocal) '+
                          N'        SELECT  ' + CHAR(39) + @Tabla + CHAR(39) + ', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ', x.'+@CampoIdentity+N', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalLocal))) + ', '+N'MIN(t.'+@CampoIdentity+') ' + --REQ12808
			              N'          FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                          N'          JOIN '+@Tabla+N' t ON t.SincroGUID = x.SincroGUID' +
                          N'         GROUP BY x.' + @CampoIdentity + ' ' --REQ12808

            --Debug
            PRINT @tabla + ',Rec,Query 13,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              
                          
                          
            EXEC sp_executesql @SQL, N'@iDatos int, @SucursalRemota int, @SucursalLocal int, @Tabla varchar(100)', @iDatos = @iDatos, @Tabla = @Tabla, @SucursalRemota = @SucursalSincro, @SucursalLocal = @SucursalLocal

/*
            --Inserta Registros a IDRemoto
            SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 0 ' +             
                          N'DELETE FROM IDRemoto ' +
                          N'FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x   JOIN ' + @Tabla + ' t ' +     
                          --N'ON (t.SincroGUID = dbo.fnRegistroTemporal(' + CHAR(39) + @Tabla + CHAR(39) + ',' + CONVERT(varchar,@SucursalSincro) + ',x.' + RTRIM(LTRIM(@CampoIdentity)) + ',x.SincroGUID) OR t.SincroGUID = x.SincroGUID) ' +
                          N'ON (t.SincroGUID = (SELECT ISNULL(RegistroTemporal,x.SincroGUID) FROM IDLocal WHERE IDRemoto = x.' + RTRIM(LTRIM(@CampoIdentity)) + ' AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND SucursalRemota = ' + RTRIM(CONVERT(varchar,@SucursalSincro)) + ') OR t.SincroGUID = x.SincroGUID) ' +
                          N'WHERE IDRemoto = x.' + @CampoIdentity + ' ' + 
                          N'AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' ' +
                          N'AND SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +                        
                          N'INSERT IDRemoto (Tabla, SucursalRemota, IDRemoto, SucursalLocal, IDLocal) '+
                          N'SELECT ' + CHAR(39) + @Tabla + CHAR(39) + ', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ', x.'+@CampoIdentity+N', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalLocal))) + ', '+N't.'+@CampoIdentity +
			              N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                          N'  JOIN '+@Tabla+N' t ON t.SincroGUID = (SELECT ISNULL(RegistroTemporal,x.SincroGUID) FROM IDLocal WHERE IDRemoto = x.' + RTRIM(LTRIM(@CampoIdentity)) + ' AND Tabla = ' + CHAR(39) + @Tabla + CHAR(39) + ' AND SucursalRemota = ' + RTRIM(CONVERT(varchar,@SucursalSincro)) + ') '
*/
            SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 0 ' + --REQ12808              
                          N'DELETE FROM IDRemoto ' +
                          N'FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x 
                          JOIN IDLocal ON IDLocal.IDRemoto = x.'+LTRIM(RTRIM(@CampoIdentity))+ ' AND IDLocal.Tabla = ' + CHAR(39) + @Tabla + CHAR(39) +  ' AND IDLocal.SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) +
                          ' JOIN ' + @Tabla + ' t ON (t.SincroGUID = ISNULL(IDLocal.RegistroTemporal,x.SincroGUID) OR t.SincroGUID = x.SincroGUID) ' +
                          N'JOIN IDRemoto ON IDRemoto.IDRemoto = x.'+LTRIM(RTRIM(@CampoIdentity))+' AND IDRemoto.Tabla = ' + CHAR(39) + @Tabla + char(39) + ' AND IDRemoto.SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' + 
                          N'INSERT IDRemoto (Tabla,       SucursalRemota, IDRemoto, SucursalLocal, IDLocal) ' +
                          N'SELECT ' + CHAR(39) + @Tabla + CHAR(39) + ', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ', x.'+@CampoIdentity+N', ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalLocal))) + ', '+N'MIN(t.'+@CampoIdentity + ') ' +
                          N'FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x ' +
                          N'JOIN IDLocal ON IDLocal.IDRemoto = x.'+LTRIM(RTRIM(@CampoIdentity)) + ' AND IDLocal.Tabla = ' + CHAR(39) + @Tabla + CHAR(39) +  ' AND IDLocal.SucursalRemota = ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +
                          N'JOIN ' + @Tabla + ' t ON (t.SincroGUID = ISNULL(IDLocal.RegistroTemporal,x.SincroGUID) OR t.SincroGUID = x.SincroGUID)' +
                          N' GROUP BY x.' + @CampoIdentity + ' '                           
                          
            --Debug
            PRINT @tabla + ',Rec,Query 14,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              
                          
            EXEC sp_executesql @SQL, N'@iDatos int, @SucursalRemota int, @SucursalLocal int, @Tabla varchar(100)', @iDatos = @iDatos, @Tabla = @Tabla, @SucursalRemota = @SucursalSincro, @SucursalLocal = @SucursalLocal

          END
          
          SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' +           
                        N'DECLARE @TablaTemp TABLE (SincroID binary(8) NULL,  Sucursal int NULL) ' +
                        N'INSERT @TablaTemp (SincroID, Sucursal) ' +
                        N'SELECT t.SincroID, ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +
			            N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                        N'  JOIN '+@Tabla+N' t ON t.SincroGUID = x.SincroGUID ' +                                                         
                        N'DELETE FROM SincroISNoRebote ' +
                        N'  FROM @TablaTemp t ' +
                        N'  JOIN SincroISNoRebote sisnr ON sisnr.SincroID = t.SincroID AND sisnr.Sucursal = t.Sucursal ' + 
                        N'INSERT SincroISNoRebote (SincroID, Sucursal) ' +  
                        N'SELECT          DISTINCT SincroID, Sucursal FROM @TablaTemp '                      
          
          --Registrar en la tabla de rebote el sincroid
          /*
          SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + --REQ12808           
                        N'DECLARE @TablaTemp TABLE (SincroID binary(8) NULL,  Sucursal int NULL) ' +
                        N'INSERT @TablaTemp (SincroID, Sucursal) ' +
                        N'SELECT t.SincroID, ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +
			            N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                        N'  JOIN '+@Tabla+N' t ON t.SincroGUID = x.SincroGUID ' +                                                         
                        N'DELETE FROM SincroISNoRebote ' +
                        N'  FROM @TablaTemp t ' +
                        N'  JOIN SincroISNoRebote sisnr ON sisnr.SincroID = t.SincroID AND sisnr.Sucursal = t.Sucursal ' + 
                        N'INSERT SincroISNoRebote (SincroID, Sucursal) ' +                        
                        N'SELECT '+N't.SincroID, ' + LTRIM(RTRIM(CONVERT(varchar,@SucursalSincro))) + ' ' +
			            N'  FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                        N'  JOIN '+@Tabla+N' t ON t.SincroGUID = x.SincroGUID '                                                                    
                        */
          --Debug
          PRINT @tabla + ',Rec,Query 15,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              
                        
          EXEC sp_executesql @SQL, N'@iDatos int, @Sucursal int', @iDatos = @iDatos, @Sucursal = @SucursalSincro

          IF @Tabla = 'IDRemoto'
          BEGIN
            SELECT @SQL = N'EXEC spSetInformacionContexto ''SINCROIS'', 1 ' + --REQ12808
                          N'        DELETE FROM IDLocal' +
	  	  	              N'          FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x JOIN IDLocal '+
                          N'            ON x.Tabla = IDLocal.Tabla AND x.SucursalLocal = IDLocal.SucursalRemota AND x.IDLocal = IDLocal.IDRemoto JOIN '+@Tabla+N' t ' + 
                          N'            ON t.SincroGUID = x.SincroGUID ' +
                          N'         WHERE x.SucursalRemota = ' + CONVERT(varchar,@SucursalLocal) + ' ' +
                          N'INSERT IDLocal (Tabla,      SucursalRemota,   IDRemoto,       SucursalLocal,    IDLocal) ' +
                          N'        SELECT '+N't.Tabla, t.SucursalLocal,  MIN(t.IDLocal), t.SucursalRemota, t.IDRemoto' +
	  	  	              N'          FROM OPENXML (@iDatos, ''/Intelisis/Solicitud/IntelisisSincroIS/Tabla/Cambios/Cambio'', 1) WITH ('+@WITH+') x '+
                          N'          JOIN '+@Tabla+N' t ON t.SincroGUID = x.SincroGUID ' +
                          N'         WHERE x.SucursalRemota = ' + CONVERT(varchar,@SucursalLocal) + ' ' +
                          N'         GROUP BY t.IDRemoto, t.Tabla, t.SucursalRemota, t.SucursalLocal '                          

            --Debug
            PRINT @tabla + ',Rec,Query 16,'  + convert(varchar,getdate(),126) + ','+@SQL 	                              

            EXEC sp_executesql @SQL, N'@iDatos int, @Sucursal int', @iDatos = @iDatos, @Sucursal = @SucursalSincro

          END
        END
      END
      FETCH NEXT FROM crSincroISRecibirTablas INTO @Tabla, @EsRespaldo, @EsTRCL, @TruncarTabla, @PaqueteCambios, @PaqueteBajas, @TablaVirtual --REQ12808
    END
    CLOSE crSincroISRecibirTablas
    DEALLOCATE crSincroISRecibirTablas
/*    
  END TRY
  BEGIN CATCH
    IF NULLIF(@SQL_ERROR_NUMBER,0) IS NOT NULL 
      SELECT @Ok = 1, @OkRef = ISNULL(@SQL_ERROR_MESSAGE, '')+' ['+CONVERT(varchar, @SQL_ERROR_NUMBER)+']'
  END CATCH 
*/  
  --SET CONTEXT_INFO 0x0
  EXEC spSetInformacionContexto 'SINCROIS', 0
  RETURN
END
GO

/************** spSincroISEnviarRespaldo *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarRespaldo') and type = 'P') drop procedure dbo.spSincroISEnviarRespaldo	
GO

CREATE PROCEDURE spSincroISEnviarRespaldo
                  @iDatos					int,
                  @Solicitud				uniqueidentifier,
                  @Conversacion				uniqueidentifier,
                  @FechaEnvio				datetime,
                  @SucursalLocal			int,
                  @SucursalSincro			int,
                  @Ok						int					OUTPUT,
                  @OkRef					varchar(255)		OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsTRCL bit
    
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    SELECT @EsTRCL = TRCL FROM Version
    EXEC spSincroISEnviarTablasEnPartes @SucursalSincro, @EsRespaldo = 1, @EsTRCL = @EsTRCL, @Solicitud = @Solicitud, @Conversacion = @Conversacion, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroISSolicitud @Solicitud, 'Respaldo', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO

/************** spSincroISEnviarTRCL *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarTRCL') and type = 'P') drop procedure dbo.spSincroISEnviarTRCL
GO
CREATE PROCEDURE spSincroISEnviarTRCL
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    EXEC spSincroISEnviarTablasEnPartes @SucursalSincro, @EsTRCL = 1, @Solicitud = @Solicitud, @Conversacion = @Conversacion, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroISSolicitud @Solicitud, 'TRCL', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO


/************** spSincroISEnviarPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarPrueba') and type = 'P') drop procedure dbo.spSincroISEnviarPrueba
GO
CREATE PROCEDURE spSincroISEnviarPrueba
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @SucursalLocal <> @SucursalSincro AND @SucursalLocal = 0 AND @SucursalSincro > 0
  BEGIN
    EXEC spSincroISEnviarTablasEnPartes @SucursalSincro, @EsPrueba = 1, @Solicitud = @Solicitud, @Conversacion = @Conversacion, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    EXEC spSincroISSolicitud @Solicitud, 'Prueba', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
  END
  RETURN
END
GO

/************** spSincroISRecibirPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISRecibirPrueba') and type = 'P') drop procedure dbo.spSincroISRecibirPrueba
GO
CREATE PROCEDURE spSincroISRecibirPrueba
			@iDatos			int,
			@Solicitud		uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio		datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRecibo	datetime

  SELECT @FechaRecibo = GETDATE()
  IF @SucursalLocal <> @SucursalSincro
    EXEC spSincroISSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'CONCLUIDO'
  RETURN
END
GO



/************** spSincroISSincroFinal *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISSincroFinal') and type = 'P') drop procedure dbo.spSincroISSincroFinal
GO
CREATE PROCEDURE spSincroISSincroFinal
			@iDatos				int,
			@Solicitud			uniqueidentifier,
			@Conversacion		uniqueidentifier,
			@FechaEnvio			datetime,
			@SucursalLocal		int,
			@SucursalSincro		int,
			@Ok					int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaRecibo	datetime,
    @EsRespaldo		bit,
    @EsTRCL		bit

  SELECT @FechaRecibo = GETDATE()
  SELECT @EsRespaldo = ISNULL(EsRespaldo, 0), @EsTRCL = ISNULL(EsTRCL, 0)
    FROM OPENXML (@iDatos, '/Intelisis/Solicitud/IntelisisSincroIS')
    WITH (EsRespaldo bit, EsTRCL bit)

  IF @SucursalLocal <> @SucursalSincro
  BEGIN
    EXEC spSincroFinal
    EXEC spSincroISSolicitud @Solicitud, @FechaRecibo = @FechaRecibo, @Estatus = 'CONCLUIDO'

    IF @EsRespaldo = 0 AND @EsTRCL = 0
    BEGIN
      IF @SucursalLocal = 0
      BEGIN
        EXEC spSetInformacionContexto 'SINCROIS', 1      
        UPDATE Sucursal SET UltimaSincronizacion = @FechaRecibo WHERE Sucursal = @SucursalLocal
        EXEC spSetInformacionContexto 'SINCROIS', 0              
      END  

      EXEC spSincroISEnviarTablasEnPartes @SucursalSincro, @EsSincroFinal = 1, @Solicitud = @Solicitud, @Conversacion = @Conversacion, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      EXEC spSincroISSolicitud @Solicitud, 'Sincronizacion', @SucursalLocal, @SucursalSincro, @FechaEnvio = @FechaEnvio, @Estatus = 'CONCLUIDO'
    END
  END
  RETURN
END
GO


/************** spSincroISProcesarMensaje *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISProcesarMensaje') and type = 'P') drop procedure dbo.spSincroISProcesarMensaje
GO
CREATE PROCEDURE spSincroISProcesarMensaje
			@Conversacion		uniqueidentifier,
			@TipoMensaje		nvarchar(256),
			@iDatos				int,
			@Brincar			bit		OUTPUT,
			@Ok					int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT,
			@Debug				bit	= 0
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Solicitud			uniqueidentifier, 
    @FechaEnvio			datetime, 
    @SucursalSincro		int,
    @SucursalLocal		int,
    @FechaRecibo		datetime


  SELECT @SucursalLocal = Sucursal FROM Version
  SELECT @SucursalSincro = NULL

  SELECT @Solicitud = Solicitud, @FechaEnvio = FechaEnvio, @SucursalSincro = SucursalOrigen
    FROM OPENXML (@iDatos, '/Intelisis/Solicitud/IntelisisSincroIS')
    WITH (Solicitud uniqueidentifier, FechaEnvio datetime, SucursalOrigen int, SucursalDestino int)
   WHERE SucursalDestino = @SucursalLocal

  IF @SucursalSincro IS NOT NULL
  BEGIN
    IF @TipoMensaje = 'SincroIS/Sincro'				EXEC spSincroISRecibirSincro  @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Brincar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroIS/SincroFinal'		EXEC spSincroISSincroFinal    @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroIS/SolicitarTRCL'		EXEC spSincroISEnviarTRCL     @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroIS/SolicitarRespaldo'	EXEC spSincroISEnviarRespaldo @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroIS/SolicitarPrueba'	EXEC spSincroISEnviarPrueba   @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT ELSE
    IF @TipoMensaje = 'SincroIS/Prueba'				EXEC spSincroISRecibirPrueba  @iDatos, @Solicitud, @Conversacion, @FechaEnvio, @SucursalLocal, @SucursalSincro, @Ok OUTPUT, @OkRef OUTPUT 
  END ELSE
    SELECT @Ok = 17040, @OkRef = CONVERT(varchar, @SucursalSincro)

  RETURN
END
GO

/************** spSincroISObtenerSolicitud *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISObtenerSolicitud') and type = 'P') drop procedure dbo.spSincroISObtenerSolicitud
GO
CREATE PROCEDURE spSincroISObtenerSolicitud
			@iDatos				int,
			@Solicitud			uniqueidentifier OUTPUT
			
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Solicitud = Solicitud
    FROM OPENXML (@iDatos, '/Intelisis/Solicitud/IntelisisSincroIS')
    WITH (Solicitud uniqueidentifier)
END
GO


/**************** spSincroISEnviarCorreo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEnviarCorreo') and type = 'P') drop procedure dbo.spSincroISEnviarCorreo
GO             
CREATE PROCEDURE spSincroISEnviarCorreo
		@IntelisisServiceID		int

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @SincroISDBMailPerfil				varchar(50),
    @SincroISDBMailAsunto				varchar(8000),
    @SincroISDBMailMensaje				varchar(8000),
    @eMail								varchar(50),
    @SubReferencia						varchar(100),
    @Estatus							varchar(15),
    @FechaEstatus						datetime,
    @Conversacion						uniqueidentifier,
    @SincroGUID							uniqueidentifier,
    @SucursalOrigen						int, 
    @SucursalDestino					int,
    @IntelisisServiceOk					int,
    @IntelisisServiceOkRef				varchar(255)
    
  SELECT 
    @SincroISDBMailPerfil = SincroISDBMailPerfil, 
    @SincroISDBMailAsunto = SincroISDBMailAsunto, 
    @SincroISDBMailMensaje = SincroISDBMailMensaje 
    FROM Version 

  SELECT 
    @SubReferencia         = SubReferencia,
    @Estatus               = Estatus,
    @FechaEstatus          = FechaEstatus,
    @Conversacion          = Conversacion, 
    @SincroGUID            = SincroGUID,
    @SucursalOrigen        = SucursalOrigen,
    @SucursalDestino       = SucursalDestino,
    @IntelisisServiceOk    = Ok,
    @IntelisisServiceOkRef = OkRef
    FROM IntelisisService 
   WHERE ID = @IntelisisServiceID

  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#IntelisisServiceID#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@IntelisisServiceID,0)))))
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#SubReferencia#',LTRIM(RTRIM(ISNULL(@SubReferencia,''))))
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#Estatus#',LTRIM(RTRIM(ISNULL(@Estatus,''))))
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#IntelisisServiceOk#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@IntelisisServiceOk,-1)))))      
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#IntelisisServiceOkRef#',LTRIM(RTRIM(ISNULL(@IntelisisServiceOkRef,''))))  
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#FechaEstatus#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@FechaEstatus,GETDATE())))))  
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#Conversacion#',LTRIM(RTRIM(ISNULL(CONVERT(varchar(100),@Conversacion),''))))  
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#SincroGUID#',LTRIM(RTRIM(ISNULL(CONVERT(varchar(100),@SincroGUID),''))))    
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#SucursalOrigen#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,-1)))))  
  SELECT @SincroISDBMailAsunto = REPLACE(@SincroISDBMailAsunto,'#SucursalDestino#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,-1)))))    

  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#IntelisisServiceID#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@IntelisisServiceID,0)))))
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#SubReferencia#',LTRIM(RTRIM(ISNULL(@SubReferencia,''))))
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#Estatus#',LTRIM(RTRIM(ISNULL(@Estatus,''))))
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#IntelisisServiceOk#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@IntelisisServiceOk,-1)))))      
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#IntelisisServiceOkRef#',LTRIM(RTRIM(ISNULL(@IntelisisServiceOkRef,''))))  
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#FechaEstatus#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@FechaEstatus,GETDATE())))))  
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#Conversacion#',LTRIM(RTRIM(ISNULL(CONVERT(varchar(100),@Conversacion),''))))  
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#SincroGUID#',LTRIM(RTRIM(ISNULL(CONVERT(varchar(100),@SincroGUID),''))))    
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#SucursalOrigen#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@SucursalOrigen,-1)))))  
  SELECT @SincroISDBMailMensaje = REPLACE(@SincroISDBMailMensaje,'#SucursalDestino#',LTRIM(RTRIM(CONVERT(varchar,ISNULL(@SucursalDestino,-1)))))    

  IF NULLIF(@SincroISDBMailPerfil,'') IS NOT NULL AND NULLIF(@SincroISDBMailAsunto,'') IS NOT NULL AND NULLIF(@SincroisdbMailMensaje,'') IS NOT NULL
  BEGIN
    DECLARE crUsuario CURSOR FOR
     SELECT u.eMail
       FROM Usuario u JOIN UsuarioCfg2 uc2
         ON uc2.Usuario = uc2.Usuario
      WHERE uc2.SincroISNotificarError = 1
        AND NULLIF(u.eMail,'') IS NOT NULL  

    OPEN crUsuario
    FETCH NEXT FROM crUsuario INTO @eMail
    WHILE @@FETCH_STATUS = 0
    BEGIN
      EXEC spEnviarDBMail @SincroISDBMailPerfil, @eMail, NULL, NULL, @SincroISDBMailAsunto, @SincroISDBMailMensaje  
      FETCH NEXT FROM crUsuario INTO @eMail
    END
    CLOSE crUsuario
    DEALLOCATE crUsuario
  END
END
GO

/************** spSincroIS_Recibir *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_Recibir') and type = 'P') drop procedure dbo.spSincroIS_Recibir
GO
CREATE PROCEDURE spSincroIS_Recibir
			@Usuario	varchar(10),
			@Debug		bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoMensaje			nvarchar(256),
    @iDatos					int,
    @Brincar				bit,
    @Ok						int,
    @OkRef					varchar(255),
    
    @ID						int,
    @Sistema				varchar(100),
    @Contenido				varchar(100),
    @Referencia				varchar(100),
    @SubReferencia			varchar(100),
    @Version				float,
    @Solicitud				varchar(max),
    @SolicitudBinario		varbinary(max),  -- REQ12766
    @HabilitarCompresion	bit,    -- REQ12766
    @Resultado				varchar(max),
    @Estatus				varchar(15),
    @FechaEstatus			datetime,
    @ISOk					int,
    @ISOkRef				varchar(255),
    @Conversacion			uniqueidentifier,
    @SincroGUID				uniqueidentifier,
    @IntelisisServiceID		int,
    @FechaRecibo			datetime,
    @UsuarioIS				varchar(10),
    @SucursalLocal			int,
    --BUG25012
    @SucursalOrigen			int,
    @SucursalDestino		int,
    @Detener				int,
    @GUIDSolicitud			uniqueidentifier,
    @SincroTabla			varchar(100)
    

  SELECT @SucursalLocal = Sucursal FROM Version  
  EXEC spSincroISActualizarSesion @Usuario

  --Cambia el estatus de todos los registros que por alguna razon quedaron en estatus BORRADOR y cuya generacion termino adecuadamente.
  UPDATE IntelisisService 
     SET Estatus = 'SINPROCESAR'
    FROM IntelisisService iss JOIN IntelisisServiceBorrador isb
      ON isb.ID = iss.ID
 
  IF NOT EXISTS(SELECT * FROM IntelisisService WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR') AND SucursalDestino = @SucursalLocal) RETURN  

  DECLARE @ConversacionTemporal table
          (
          Conversacion				uniqueidentifier
          ) 


  DECLARE @IntelisisService table
          (
          ID						int NOT NULL identity(1,1),
          IntelisisServiceID		int NULL,
          Sistema					varchar(100) COLLATE DATABASE_DEFAULT NULL,
          Contenido					varchar(100) COLLATE DATABASE_DEFAULT NULL,
          Referencia				varchar(100) COLLATE DATABASE_DEFAULT NULL,
          SubReferencia				varchar(100) COLLATE DATABASE_DEFAULT NULL,				          
          [Version]					float NULL,
          Usuario					varchar(10) COLLATE DATABASE_DEFAULT NULL,
          Solicitud					varchar(max) COLLATE DATABASE_DEFAULT NULL,
          SolicitudBinario			varbinary(max)   NULL, -- REQ12766
          Resultado					varchar(max) COLLATE DATABASE_DEFAULT NULL,
          Estatus					varchar(15) COLLATE DATABASE_DEFAULT NULL,
          FechaEstatus				datetime NULL,
          Ok						int NULL,
          OkRef						varchar(255) COLLATE DATABASE_DEFAULT NULL,          
          Conversacion				uniqueidentifier NULL,
          SincroGUID				uniqueidentifier NULL,
          --BUG25012
          SucursalOrigen			int			NULL,
          SucursalDestino			int			NULL,
          Detener					int NULL DEFAULT 0,
          SincroTabla				varchar(100) COLLATE DATABASE_DEFAULT NULL,
          HabilitarCompresion		bit				 NULL -- REQ12766
          ) 

   INSERT @IntelisisService (IntelisisServiceID,  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, Detener, SincroTabla) -- REQ12766
                     SELECT  ID,                  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, 0,       SincroTabla -- REQ12766
                       FROM IntelisisService
                      WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR')
                        AND SucursalDestino = @SucursalLocal
                        AND ISNULL(SincroTabla,'') = 'IDRemoto'
                        AND RTRIM(SubReferencia) NOT IN ('SincroFinal')
                      ORDER BY ID

   INSERT @IntelisisService (IntelisisServiceID,  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, Detener, SincroTabla) -- REQ12766
                     SELECT  ID,                  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, 0,       SincroTabla -- REQ12766
                       FROM IntelisisService
                      WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR')
                        AND SucursalDestino = @SucursalLocal
                        AND ISNULL(SincroTabla,'') NOT IN ('IDRemoto')                        
                        AND RTRIM(SubReferencia) NOT IN ('SincroFinal')                        
                      ORDER BY ID

   INSERT @IntelisisService (IntelisisServiceID,  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, Detener, SincroTabla) -- REQ12766
                     SELECT  ID,                  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, SolicitudBinario, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, 0,       SincroTabla -- REQ12766
                       FROM IntelisisService
                      WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR')
                        AND SucursalDestino = @SucursalLocal
                        AND ISNULL(SincroTabla,'') NOT IN ('IDRemoto')                        
                        AND RTRIM(SubReferencia) IN ('SincroFinal')                        
                      ORDER BY ID

  UPDATE @IntelisisService SET HabilitarCompresion = 1 WHERE SolicitudBinario IS NOT NULL  -- REQ12766                      

  --BUG25012
  DELETE @IntelisisService WHERE SolicitudBinario IS NULL AND Solicitud IS NULL
  
   /*
   INSERT @IntelisisService (IntelisisServiceID,  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, Detener, SincroTabla)
                     SELECT  ID,                  Sistema, Contenido, Referencia, SubReferencia, [Version], Usuario, Solicitud, Resultado, Estatus, FechaEstatus, Ok, OkRef, Conversacion, SincroGUID, SucursalOrigen, SucursalDestino, 0,       SincroTabla
                       FROM IntelisisService
                      WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR')
                        AND SucursalDestino = @SucursalLocal
                        AND SincroTabla NOT IN ('IDRemoto')                     
                        AND dbo.fnSincroISTablaConCampoIdentity(SincroTabla) = 0                           
                      ORDER BY ID
   */
     
   WHILE EXISTS(SELECT * FROM @IntelisisService WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR') AND SucursalDestino = @SucursalLocal) AND @Ok IS NULL
   BEGIN
     SELECT @ID = ID, @IntelisisServiceID = IntelisisServiceID, @Sistema = Sistema, @Contenido = Contenido, @Referencia = Referencia, @SubReferencia = SubReferencia, @Version = [Version],  @UsuarioIS = Usuario, @Solicitud = Solicitud, @SolicitudBinario = SolicitudBinario, @HabilitarCompresion = ISNULL(HabilitarCompresion, 0), @Resultado = Resultado, @Estatus = Estatus, @FechaEstatus = FechaEstatus, @ISOk = Ok, @ISOkRef = OkRef, @Conversacion = Conversacion, @SincroGUID = SincroGUID, @SucursalOrigen = SucursalOrigen, @SucursalDestino = SucursalDestino, @Detener = Detener, @SincroTabla = SincroTabla FROM @IntelisisService WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR') AND ID = (SELECT MIN(ID) FROM @IntelisisService WHERE Referencia = 'SincroIS' AND Estatus IN ('SINPROCESAR','ERROR') AND SucursalDestino = @SucursalLocal) AND SucursalDestino = @SucursalLocal -- REQ12766

     IF @HabilitarCompresion = 1
     BEGIN
       EXEC spSincroISDescomprimirPaquete @IntelisisServiceID
    
       UPDATE i SET i.Solicitud = IntelisisService.Solicitud FROM @IntelisisService i JOIN IntelisisService ON i.IntelisisServiceID = IntelisisService.ID WHERE i.IntelisisServiceID = @IntelisisServiceID     
       
       SELECT @Solicitud = Solicitud FROM @IntelisisService WHERE IntelisisServiceID = @IntelisisServiceID     
     END

     SELECT @TipoMensaje = 'SincroIS/' + @SubReferencia   
     --BEGIN TRY
       BEGIN TRANSACTION 
       
       IF @SubReferencia NOT IN ('SincroFinal')
       BEGIN
         EXEC sp_xml_preparedocument @iDatos OUTPUT, @Solicitud 
		 BEGIN TRY
           SET @Brincar = 0
           EXEC spSincroISProcesarMensaje @Conversacion, @TipoMensaje, @iDatos, @Brincar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Debug = @Debug
         END TRY
         BEGIN CATCH
           SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
         BREAK
         END CATCH 	
         EXEC sp_xml_removedocument @iDatos
       END ELSE
       BEGIN
         IF NOT EXISTS(SELECT * FROM @IntelisisService WHERE RTRIM(Referencia) = 'SincroIS' AND RTRIM(SubReferencia) = 'Sincro' AND RTRIM(Estatus) IN ('SINPROCESAR','ERROR') AND SucursalDestino = @SucursalLocal AND Conversacion = @Conversacion)
         BEGIN
           EXEC sp_xml_preparedocument @iDatos OUTPUT, @Solicitud   
		   BEGIN TRY
             SET @Brincar = 0
             EXEC spSincroISProcesarMensaje @Conversacion, @TipoMensaje, @iDatos, @Brincar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @Debug = @Debug
           END TRY
           BEGIN CATCH
             SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
           BREAK
           END CATCH 	
           EXEC sp_xml_removedocument @iDatos         
         END ELSE
           SET @Brincar = 1  
       END  

       IF @Brincar = 0
       BEGIN
         UPDATE IntelisisService 
            SET Estatus = CASE WHEN @Ok IS NULL THEN 'PROCESADO' ELSE 'ERROR' END, 
                Ok = @Ok, 
                OkRef = @OkRef 
          WHERE ID = @IntelisisServiceID

         IF @HabilitarCompresion = 1
           UPDATE IntelisisService SET Solicitud = NULL, SolicitudBinario = @SolicitudBinario WHERE ID = @IntelisisServiceID
                     
         DELETE FROM @IntelisisService WHERE ID = @ID 
         --Apaga la bandera detener para que cuando encuentre algun registro que estaba marcado para detenerlo no lo detenga ya que se procesaron registros.
         IF @Ok IS NULL UPDATE @IntelisisService SET Detener = 0 WHERE Detener > 0
         
         IF @Ok IS NOT NULL 
         BEGIN
           EXEC sp_xml_preparedocument @iDatos OUTPUT, @Solicitud
		   BEGIN TRY
             EXEC spSincroISObtenerSolicitud @iDatos, @GUIDSolicitud OUTPUT
           END TRY
           BEGIN CATCH
             SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
           BREAK
           END CATCH 	
           EXEC sp_xml_removedocument @iDatos                                   
           EXEC spSincroISSolicitud @GUIDSolicitud, @Estatus = 'ERROR'         
           EXEC spSincroISEnviarCorreo @IntelisisServiceID
         END  
       END ELSE
       IF @Brincar = 1
       BEGIN
         IF ISNULL(@Detener,0) < 5
         BEGIN
           DELETE FROM @IntelisisService WHERE ID = @ID        
           INSERT @IntelisisService (IntelisisServiceID,  Sistema,  Contenido,  Referencia,  SubReferencia,  [Version], Usuario,    Solicitud,   SolicitudBinario,  Resultado,  Estatus,  FechaEstatus,  Ok,  OkRef,  Conversacion,  SincroGUID,  SucursalOrigen,  SucursalDestino,  Detener,                SincroTabla,  HabilitarCompresion) --REQ12808
                             VALUES (@IntelisisServiceID, @Sistema, @Contenido, @Referencia, @SubReferencia, @Version,  @UsuarioIS, @Solicitud, @SolicitudBinario,  @Resultado, @Estatus, @FechaEstatus, @Ok, @OkRef, @Conversacion, @SincroGUID, @SucursalOrigen, @SucursalDestino, ISNULL(@Detener,0) + 1, @SincroTabla, @HabilitarCompresion) --REQ12808
         END
         BEGIN
           IF @Detener = 5
           BEGIN
             SELECT @Ok = 72080
             EXEC sp_xml_preparedocument @iDatos OUTPUT, @Solicitud
			 BEGIN TRY
               EXEC spSincroISObtenerSolicitud @iDatos, @GUIDSolicitud OUTPUT             
             END TRY
             BEGIN CATCH
               SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
             BREAK
             END CATCH 	
             EXEC sp_xml_removedocument @iDatos                                                
             EXEC spSincroISSolicitud @GUIDSolicitud, @Estatus = 'ERROR'
             UPDATE IntelisisService SET Estatus = 'ERROR', Ok = @Ok, OkRef = @OkRef WHERE ID = @IntelisisServiceID
             EXEC spSincroISEnviarCorreo @IntelisisServiceID                      
           END
         END                           
       END        
       INSERT @ConversacionTemporal (Conversacion) VALUES (@Conversacion)
       IF @Debug = 1
       BEGIN
         ROLLBACK TRANSACTION
         BREAK
       END ELSE
         COMMIT TRANSACTION 
     --END TRY
     --BEGIN CATCH
       --SELECT @Ok = ERROR_NUMBER(), @OkRef = ERROR_MESSAGE()
       --ROLLBACK TRANSACTION
       --SELECT 'Error' = @Ok, 'Mensaje' = @OkRef
       --BREAK
     --END CATCH
   END                   
 
  --ARCC
  UPDATE IntelisisService SET Estatus = 'SINPROCESAR' 
    FROM IntelisisService inser JOIN @ConversacionTemporal c
      ON inser.Conversacion = c.Conversacion
   WHERE inser.Estatus = 'BORRADOR'

  RETURN
END
GO


--EXEC spSincroIS_Sincronizar 'DEMO0'
--exec spSetInformacionContexto 'SINCROIS', 1
--insert Sucursal (Sucursal, Nombre, Pais, Estatus, Relacion) values (2, 'Sucursal 2', 'Mexico', 'ALTA', 'n/a')
--SELECT DBO.fnEstaSincronizando()
--DELETE FROM Sucursal WHERE Sucursal = 2
--exec spSetInformacionContexto 'SINCROIS', 0

-- spSincroISActivarTabla 'Sucursal'
/************** spSincroISActivarTabla *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISActivarTabla') and type = 'P') drop procedure dbo.spSincroISActivarTabla
GO
CREATE PROCEDURE spSincroISActivarTabla
			@Tabla		varchar(100),
			@Activar	bit = 1
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SQL				varchar(max),
    @Trigger			varchar(100),
    @CampoIdentity		varchar(100)

  /* Eliminar Sincro Anterior */
  SELECT @SQL = 'spDROP_TRIGGER ''sincro'+@Tabla+''''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER ''sincroT'+@Tabla+''''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER ''sincroR'+@Tabla+''''
  EXEC (@SQL)

  -- Eliminar triggers de SSB
  SELECT @SQL = 'spDROP_TRIGGER ''tg'+@Tabla+'SincroSSB_AC'''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER ''tg'+@Tabla+'SincroSSB_B'''
  EXEC (@SQL)

  --EXEC spDROP_INDEX @Tabla, 'SincroID'
  --EXEC spDROP_COLUMN @Tabla, 'SincroC'
  IF @Activar = 1
  BEGIN
    EXEC spALTER_TABLE @Tabla, 'SincroID', 'timestamp NULL'
    EXEC spADD_INDEX @Tabla, 'Sincro', 'SincroID'
    EXEC spALTER_TABLE @Tabla, 'SincroGUID', 'uniqueidentifier NOT NULL DEFAULT NEWID() WITH VALUES'
    EXEC spADD_INDEX @Tabla, 'SincroGUID', 'SincroGUID'
  END

  SELECT @Trigger = 'dbo.tg'+@Tabla+'SincroIS'
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+'_AC'''
  EXEC (@SQL)
  SELECT @SQL = 'spDROP_TRIGGER '''+@Trigger+'_B'''
  EXEC (@SQL)
  IF @Activar = 1
  BEGIN
    SELECT @SQL = 
      'CREATE TRIGGER '+@Trigger+'_AC ON '+@Tabla+'
      --//WITH ENCRYPTION
      FOR INSERT, UPDATE
      AS BEGIN
        SET ANSI_NULLS OFF

    	DECLARE
      	  @SincroIDMax		binary(8),
      	  @SincroIDTabla	binary(8)
      	  
        IF dbo.fnEstaSincronizando() = 1 RETURN      	  

      IF (SELECT SincroIS FROM Version) = 1 
        BEGIN
        
          SELECT @SincroIDMax = MAX(SincroID) FROM ' + CASE WHEN @Tabla = 'IDRemoto' THEN 'SincroISIDRemotoControl' ELSE 'SincroISControl ' END + ' 
          SELECT @SincroIDTabla = SincroID FROM SysTabla WHERE SysTabla = '''+@Tabla+'''
          IF @SincroIDTabla < @SincroIDMax
            UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+'''
        END
      END'
      EXEC (@SQL)

    EXEC spSincroISTablaEstructura @Tabla, @CampoIdentity = @CampoIdentity OUTPUT
    IF @CampoIdentity IS NOT NULL 
      SET @CampoIdentity = CHAR(44) + CHAR(32) + @CampoIdentity
    ELSE  
      SET @CampoIdentity = ''

    SELECT @SQL = 
    'CREATE TRIGGER '+@Trigger+'_B ON '+@Tabla+'
    --//WITH ENCRYPTION
    FOR DELETE
    AS BEGIN
    	DECLARE
    	  @SincroIDMax		binary(8),
    	  @SincroIDTabla	binary(8)
    	  
      IF dbo.fnEstaSincronizando() = 1 RETURN

      IF (SELECT SincroIS FROM Version) = 1 
      BEGIN
          
        SELECT @SincroIDMax = MAX(SincroID) FROM ' + CASE WHEN @Tabla = 'IDRemoto' THEN 'SincroISIDRemotoControl' ELSE 'SincroISControl ' END + ' 
        SELECT @SincroIDTabla = SincroID FROM SysTabla WHERE SysTabla = '''+@Tabla+'''
        IF @SincroIDTabla < @SincroIDMax

          UPDATE SysTabla WITH (ROWLOCK) SET UltimoCambio = GETDATE() WHERE SysTabla = '''+@Tabla+'''
          
        DECLARE @Llave xml
        SELECT @Llave = (SELECT SincroGUID ' + @CampoIdentity + ' FROM DELETED FOR XML RAW(''Llave''))
        EXEC spSincroISBaja '''+@Tabla+''', @Llave
      END
    END'      
    
    
      BEGIN TRY
        EXEC (@SQL)
      END TRY
      BEGIN CATCH
        SELECT @SQL = 'Error al Creare el Trigger '+@Trigger+' en la Tabla '+@Tabla
        RAISERROR (@SQL,16,-1)     
      END CATCH
  END
  RETURN
END
GO
--EXEC spSincroISActualizar

/************** spSincroISActualizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISActualizar') and type = 'P') drop procedure dbo.spSincroISActualizar
GO
CREATE PROCEDURE spSincroISActualizar
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(100),
    @Activar	bit

  IF EXISTS(SELECT * FROM Version WHERE SincroSSB = 1 AND SincroIS = 1)
  BEGIN
    RAISERROR ('No se puede Activar Sincro SSB y Sincro IS Simultaneamente',16,-1)     
    RETURN
  END
  EXEC spSetInformacionContexto 'SINCROIS', 1        
  UPDATE Version SET validarsincrosemilla = 0
  EXEC spSetInformacionContexto 'SINCROIS', 0          
  SELECT @Activar = SincroIS FROM Version
  IF @Activar = 1
    UPDATE SysTabla WITH (ROWLOCK) SET Tipo = 'N/A' WHERE SysTabla IN ('SincroLog','SincroLogAdvertencia','SincroLogError','SincroMovRegistro','SincroPaquete')

  --UPDATE SysTabla SET UltimoCambio = GETDATE()
  DECLARE crSincroISActualizar CURSOR LOCAL FOR 
   SELECT SysTabla
     FROM SysTabla
    WHERE UPPER(NULLIF(RTRIM(dbo.fnSincroISTablaTipo(SysTabla)), '')) NOT IN (NULL, 'N/A')
  OPEN crSincroISActualizar
  FETCH NEXT FROM crSincroISActualizar INTO @Tabla
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND dbo.fnTablaExiste(@Tabla) = 1
    BEGIN
      EXEC spSincroISActivarTabla @Tabla, @Activar
    END
    FETCH NEXT FROM crSincroISActualizar INTO @Tabla
  END
  CLOSE crSincroISActualizar
  DEALLOCATE crSincroISActualizar

  RETURN
END
GO

/************** spSincroIS_Activar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_Activar') and type = 'P') drop procedure dbo.spSincroIS_Activar
GO
CREATE PROCEDURE spSincroIS_Activar
--//WITH ENCRYPTION
AS BEGIN        
  UPDATE Version SET Sincro = 0, SincroSSB = 0, SincroIS = 1
  EXEC spSincroISActualizar  
  
  EXEC spSincroIS_Activar2
END
GO
--exec spSincroIS_Activar
--exec spSincroIS_Activar2
/************** spSincroIS_SolicitarRespaldo *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_SolicitarRespaldo') and type = 'P') drop procedure dbo.spSincroIS_SolicitarRespaldo
GO
CREATE PROCEDURE spSincroIS_SolicitarRespaldo
				@Usuario			varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalDestino	int,
    @Solicitud			uniqueidentifier,
    @Conversacion		uniqueidentifier,
    @FechaEnvio			datetime,
    @SQL				nvarchar(max),
    @Datos				xml,
    @SQL_ERROR_NUMBER	int,
    @SQL_ERROR_MESSAGE	varchar(255),
    @Ok					int,
    @OkRef				varchar(255),
	-- 9562
	@SincroISDropBox		bit,
	@SincroISDropBoxRuta	varchar(255)

  EXEC spSincroISActualizarSesion @Usuario

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Ok = NULL, @OkRef = NULL
  -- 9562
  SELECT @SucursalOrigen = Sucursal, @SincroISDropBox = ISNULL(SincroISDropBox, 0), @SincroISDropBoxRuta = dbo.fnDirectorioEliminarDiagonalFinal(SincroISDropBoxRuta)
  FROM Version
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF EXISTS (SELECT * FROM SincroISSolicitud WHERE Tipo = 'Respaldo' AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino AND Estatus IN ('PENDIENTE', 'RECIBIENDO','ERROR'))
   SELECT @Ok = 17010

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      SELECT @Solicitud = NEWID()
      SELECT @Conversacion = NEWID()      
      SELECT @Datos = '<?xml version="1.0" encoding="windows-1252"?><IntelisisSincroIS'+
			dbo.fnXML('Tipo', 'SolicitarRespaldo')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '/>'
      EXEC spSincroISSend 'SolicitarRespaldo', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
        EXEC spSincroISSolicitud @Solicitud, 'Respaldo', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
    END CATCH
  END
  EXEC spSincroISOk @Solicitud, 'SincroIS/SolicitarRespaldo', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+'. '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  -- 9562
  IF @Ok IS NULL
    EXEC spSincroISTransmisor @SincroISDropBox = @SincroISDropBox, @SincroISDropBoxRuta = @SincroISDropBoxRuta
  RETURN
END
GO

/************** spSincroIS_SolicitarTRCL *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_SolicitarTRCL') and type = 'P') drop procedure dbo.spSincroIS_SolicitarTRCL
GO
CREATE PROCEDURE spSincroIS_SolicitarTRCL
				@Usuario				varchar(10)  
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen		int,
    @SucursalDestino		int,
    @Solicitud			uniqueidentifier,
    @Conversacion		uniqueidentifier,    
    @FechaEnvio			datetime,
    @SQL			nvarchar(max),
    @Datos			xml,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok				int,
    @OkRef			varchar(255)

  EXEC spSincroISActualizarSesion @Usuario

  SELECT @Ok = NULL, @OkRef = NULL, @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @SucursalOrigen = Sucursal FROM Version
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF EXISTS (SELECT * FROM SincroISSolicitud WHERE Tipo = 'TRCL' AND SucursalOrigen = @SucursalOrigen AND SucursalDestino = @SucursalDestino AND Estatus = 'PENDIENTE')
   SELECT @Ok = 17020

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      SELECT @Solicitud = NEWID()
      SELECT @Conversacion = NEWID()      
      SELECT @Datos = '<IntelisisSincroIS'+
			dbo.fnXML('Tipo', 'SolicitarTRCL')+
			dbo.fnXMLGID('Solicitud', @Solicitud)+
			dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
                      '/>'
      EXEC spSincroISSend 'SolicitarTRCL', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
        EXEC spSincroISSolicitud @Solicitud, 'TRCL', @SucursalOrigen, @SucursalDestino, @FechaEnvio = @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
    END CATCH
  END
  EXEC spSincroISOk @Solicitud, 'SincroIS/SolicitarTRCL', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/************** spSincroIS_Enviar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_Enviar') and type = 'P') drop procedure dbo.spSincroIS_Enviar
GO
CREATE PROCEDURE spSincroIS_Enviar
		@Usuario				varchar(10)
		
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen	int,
    @Conversacion	uniqueidentifier,
    @Solicitud		uniqueidentifier,
    @FechaEnvio		datetime,
    @Ok			int,
    @OkRef		varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
    
  EXEC spSincroISActualizarSesion @Usuario
  
  SELECT @Solicitud = NEWID(), @Conversacion = NEWID(), @FechaEnvio = GETDATE()
  
  SELECT @SucursalOrigen = Sucursal FROM Version
  IF @SucursalOrigen > 0 
  BEGIN
    BEGIN TRANSACTION 
    EXEC spSetInformacionContexto 'SINCROIS', 1      
    UPDATE Sucursal SET UltimaSincronizacion = @FechaEnvio WHERE Sucursal = @SucursalOrigen
    EXEC spSetInformacionContexto 'SINCROIS', 0          

    EXEC spSincroISEnviarTablasEnPartes @Solicitud = @Solicitud, @Conversacion = @Conversacion, @FechaEnvio = @FechaEnvio OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    UPDATE IntelisisService SET Estatus = 'SINPROCESAR' WHERE Estatus = 'BORRADOR' AND Conversacion = @Conversacion --ARCC
    --arcc
    --PRINT 'Ok->' + ISNULL(CONVERT(varchar,@Ok),'NULL')    
    IF @Ok IS NULL
      COMMIT TRANSACTION 
    ELSE
      ROLLBACK TRANSACTION 
  END
  EXEC spSincroISOk @Solicitud, 'SincroIS/Sincro', NULL, NULL, NULL, NULL, @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/************** spSincroIS_SolicitarPrueba *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_SolicitarPrueba') and type = 'P') drop procedure dbo.spSincroIS_SolicitarPrueba
GO
CREATE PROCEDURE spSincroIS_SolicitarPrueba
				@Usuario			varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SucursalOrigen			int,
    @SucursalDestino		int,
    @Solicitud				uniqueidentifier,
    @Conversacion			uniqueidentifier,    
    @FechaEnvio				datetime,
    @Datos					xml,
    @SQL_ERROR_NUMBER		int,
    @SQL_ERROR_MESSAGE		varchar(255),
    @Ok						int,
    @OkRef					varchar(255),
    -- 9562
	@SincroISDropBox		bit,
	@SincroISDropBoxRuta	varchar(255)

  EXEC spSincroISActualizarSesion @Usuario

  SELECT @SQL_ERROR_NUMBER = 0, @SQL_ERROR_MESSAGE = NULL
  SELECT @Ok = NULL, @OkRef = NULL
  -- 9562
  SELECT @SucursalOrigen = Sucursal, @SincroISDropBox = ISNULL(SincroISDropBox, 0), @SincroISDropBoxRuta = dbo.fnDirectorioEliminarDiagonalFinal(SincroISDropBoxRuta) FROM Version
  SELECT @SucursalDestino = 0, @FechaEnvio = GETDATE()

  IF @SucursalOrigen > 0 AND @Ok IS NULL
  BEGIN
    BEGIN TRY
      BEGIN TRANSACTION 
      SELECT @Solicitud = NEWID()
      SELECT @Conversacion = NEWID()      
      SELECT @Datos = '<IntelisisSincroIS'+
			 dbo.fnXML('Tipo', 'SolicitarPrueba')+
			 dbo.fnXMLGID('Solicitud', @Solicitud)+
			 dbo.fnXMLDateTime('FechaEnvio', @FechaEnvio)+
			 dbo.fnXMLInt('SucursalOrigen', @SucursalOrigen)+
			 dbo.fnXMLInt('SucursalDestino', @SucursalDestino)+
             '/>'
      EXEC spSincroISSend 'SolicitarPrueba', @Datos, @Conversacion, @SucursalOrigen, @SucursalDestino, NULL, @Solicitud, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL
        EXEC spSincroISSolicitud @Solicitud, 'Prueba', @SucursalOrigen, @SucursalDestino, @FechaEnvio, @Estatus = 'PENDIENTE'
      COMMIT TRANSACTION 
    END TRY
    BEGIN CATCH
      SELECT @SQL_ERROR_NUMBER = ERROR_NUMBER(), @SQL_ERROR_MESSAGE = ERROR_MESSAGE()
      ROLLBACK TRANSACTION 
    END CATCH
  END
  EXEC spSincroISOk @Solicitud, 'Prueba', @Datos, NULL, @SQL_ERROR_NUMBER, @SQL_ERROR_MESSAGE, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NULL
  BEGIN    
    SET ANSI_NULLS ON
    SET ANSI_WARNINGS ON  
    -- 9562
    EXEC spSincroISTransmisor @SincroISDropBox = @SincroISDropBox, @SincroISDropBoxRuta = @SincroISDropBoxRuta
    SET ANSI_NULLS OFF
    SET ANSI_WARNINGS OFF
  END  

  IF @Ok IS NULL
    SELECT 'Solicitud Enviada con Exito'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN
END
GO

/******************************* spSincroISEliminarEnviadosSucursal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEliminarEnviadosSucursal') and type = 'P') drop procedure dbo.spSincroISEliminarEnviadosSucursal
GO             
CREATE PROCEDURE spSincroISEliminarEnviadosSucursal
				(
				@SucursalDestino			int,
				@Fecha						datetime
				)

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @UltimoRegistroEnviado			int,
  @IDPenultimaSincronizacion		int

  SELECT @UltimoRegistroEnviado = MAX(ID) 
    FROM IntelisisService 
   WHERE Estatus = 'ENVIADO' 
     AND SubReferencia = 'SincroFinal' 
     AND SucursalDestino = @SucursalDestino
     AND dbo.fnFechaSinHora(FechaEstatus) <= @Fecha
     AND Referencia = 'SincroIS'
     
  SELECT @IDPenultimaSincronizacion = MAX(ID)
    FROM IntelisisService 
   WHERE Estatus = 'ENVIADO' 
     AND SubReferencia = 'SincroFinal' 
     AND SucursalDestino = @SucursalDestino
     AND dbo.fnFechaSinHora(FechaEstatus) <= @Fecha
     AND ID < @UltimoRegistroEnviado
     AND Referencia = 'SincroIS'
       
  DELETE FROM IntelisisService
   WHERE Estatus = 'ENVIADO'
     AND SucursalDestino = @SucursalDestino
     AND ID <= @IDPenultimaSincronizacion
     AND dbo.fnFechaSinHora(FechaEstatus) <= @Fecha
     AND Referencia = 'SincroIS'
               
END
GO

/**************** spSincroISEliminarEnviados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISEliminarEnviados') and type = 'P') drop procedure dbo.spSincroISEliminarEnviados
GO             
CREATE PROCEDURE spSincroISEliminarEnviados

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
	@Transaccion		varchar(50),
	@Ok					int,
	@OkRef				varchar(255),
	@Fecha				datetime,
	@Sucursal			int,
	@SucursalLocal		int

  SET @Transaccion = 'spSincroISEliminarEnviados' + RTRIM(LTRIM(CONVERT(varchar,@@SPID)))

  SELECT @Fecha = dbo.fnFechaSinHora(DATEADD(dd,0-(5+ISNULL(ISDiasResguardoSolicitud,0)),GETDATE())), @SucursalLocal = Sucursal FROM Version

  PRINT @Fecha
  BEGIN TRANSACTION @Transaccion

  DECLARE crSucursal CURSOR FOR
   SELECT Sucursal
     FROM Sucursal
    WHERE Sucursal NOT IN (@SucursalLocal)

  OPEN crSucursal
  FETCH NEXT FROM crSucursal INTO @Sucursal
  WHILE @@FETCH_STATUS = 0 AND @Ok IS NULL
  BEGIN
    EXEC spSincroISEliminarEnviadosSucursal @Sucursal, @Fecha
    FETCH NEXT FROM crSucursal INTO @Sucursal
  END
  CLOSE crSucursal
  DEALLOCATE crSucursal

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION @Transaccion
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION @Transaccion
    SELECT 'ERROR: ' + CONVERT(varchar,@Ok) + (SELECT Descripcion FROM MensajeLista WHERE Mensaje = @Ok) +'. ' + ISNULL(@OkRef,'')    
  END

END
GO


/**************** fnSincroISReceptorPuedeInsertarDropBox ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSincroISReceptorPuedeInsertarDropBox') DROP FUNCTION fnSincroISReceptorPuedeInsertarDropBox
GO
CREATE FUNCTION fnSincroISReceptorPuedeInsertarDropBox(
			@ID				int, 
			@Conversacion	uniqueidentifier)
RETURNS bit
AS
BEGIN
  DECLARE @Valor		bit,
		  @IDInserta	int

  SELECT @IDInserta = MIN(IntelisisServiceID)
    FROM SincroISDropBoxPaquete
   WHERE Estatus = 'PENDIENTE'
     AND Conversacion = @Conversacion

  IF @IDInserta = @ID
    SELECT @Valor = 1
  ELSE
    SELECT @Valor = 0

  RETURN @Valor
END
GO


/************** spSincroISActualizaEstatusPaqueteDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISActualizaEstatusPaqueteDropBox') and type = 'P') drop procedure dbo.spSincroISActualizaEstatusPaqueteDropBox
GO
CREATE PROC spSincroISActualizaEstatusPaqueteDropBox 
			@Conversacion		uniqueidentifier, 
			@ID					int
--//WITH ENCRYPTION
AS
BEGIN
  UPDATE SincroISDropBoxPaquete SET Estatus = 'RECIBIDO' WHERE IntelisisServiceID = @ID AND Conversacion = @Conversacion

  IF NOT EXISTS(SELECT RID FROM SincroISDropBoxPaquete WHERE Conversacion = @Conversacion AND Estatus = 'PENDIENTE')
    UPDATE IntelisisService SET Estatus = 'SINPROCESAR' WHERE Conversacion = @Conversacion AND Estatus = 'RECIBIDO'
END
GO

/************** spSincroISReceptorDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISReceptorDropBox') and type = 'P') drop procedure dbo.spSincroISReceptorDropBox
GO
CREATE PROC spSincroISReceptorDropBox
		  @Ok								int				= NULL,
		  @OkRef							varchar(255)	= NULL
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion							int,
		  @SincroISDropBox					bit, 
		  @SincroISDropBoxRuta				varchar(255),
		  @Sucursal							int,
		  @SincroISDropBoxRutaSucursal		varchar(255),
		  @SincroISDropBoxRutaSucursalProc	varchar(255),
		  @ArchivoXML						varchar(255),
		  @ArchivoZIP						varchar(255),
		  @ArchivoProcesado					varchar(255),		  
		  @Nombre							varchar(128),
		  @NombreAnt						varchar(128),
		  @XML								varchar(max),
		  @ID								int,
		  @iDatos							int,
		  
		  @Sistema							varchar(100),
		  @Contenido						varchar(100),
		  @Referencia						varchar(100),
		  @SubReferencia					varchar(100),
		  @Version							float,
		  @Usuario							varchar(10),
		  @Solicitud						varchar(max), 
		  @Resultado						varchar(max),
		  @Estatus							varchar(15),
		  @FechaEstatus						datetime,
		  @ISOk								int,
		  @ISOkRef							varchar(255),
		  @SincroGUID						uniqueidentifier, 
		  @Conversacion						uniqueidentifier, 
		  @SucursalOrigen					int, 
		  @SucursalDestino					int,		
		  @SincroTabla						varchar(100),
		  @SincroSolicitud					uniqueidentifier

  SELECT @SincroISDropBox		= ISNULL(SincroISDropBox, 0),
		 @SincroISDropBoxRuta	= dbo.fnDirectorioEliminarDiagonalFinal(SincroISDropBoxRuta),
		 @Sucursal				= Sucursal
	FROM Version

  IF @SincroISDropBox = 0 RETURN

  SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\' + CONVERT(varchar, @Sucursal)
  SELECT @SincroISDropBoxRutaSucursalProc = @SincroISDropBoxRutaSucursal + '\Procesados'
  
  EXEC spCrearDirectorio @SincroISDropBoxRutaSucursalProc, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  SELECT @Estacion = @@SPID

  EXEC speDocInListarDirectorio @SincroISDropBoxRutaSucursal, @Estacion
  
  SELECT @NombreAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Nombre = MIN(Nombre)
      FROM eDocInDirDetalle
     WHERE Estacion = @Estacion
       AND Nombre > @NombreAnt
       AND Tipo	= '.zip'

    IF @Nombre IS NULL BREAK
    
    SELECT @NombreAnt = @Nombre
    
    SELECT @ArchivoZIP		 = @SincroISDropBoxRutaSucursal + '\' + @Nombre,
		   @ArchivoXML		 = @SincroISDropBoxRutaSucursal + '\' + REPLACE(@Nombre, '.zip', '.xml'),
		   @ArchivoProcesado = @SincroISDropBoxRutaSucursalProc + '\' + @Nombre

    IF @Ok IS NULL
      EXEC spDescomprimirArchivo @ArchivoZIP, @ArchivoXML, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
    BEGIN
      EXEC spLeerArchivo @ArchivoXML, @Archivo = @XML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      SELECT @XML = '<?xml version="1.0" encoding="windows-1252"?>' + REPLACE(CONVERT(varchar(max), @XML), '<?xml version="1.0" encoding="UTF-8"?>', '')
    END
    
    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
      
      SELECT @ID				= ID,
			 @Sistema			= Sistema,
		     @Contenido			= Contenido,
   		     @Referencia		= Referencia,
		     @SubReferencia		= SubReferencia,
		     @Version			= Version,
		     @Usuario			= Usuario,
		     @Solicitud			= Solicitud,
		     @Resultado			= Resultado,
		     @Estatus			= Estatus,
		     @FechaEstatus		= FechaEstatus,
		     @ISOk				= Ok,
		     @ISOkRef			= OkRef,
		     @SincroGUID		= SincroGUID,
		     @Conversacion		= Conversacion,
		     @SucursalOrigen	= SucursalOrigen,
		     @SucursalDestino	= SucursalDestino,
		     @SincroTabla		= SincroTabla,
		     @SincroSolicitud	= SincroSolicitud
        FROM OPENXML (@iDatos, '/IntelisisService/IntelisisService', 3)
        WITH (ID				int,
			  Sistema			varchar(100),
			  Contenido			varchar(100),
			  Referencia		varchar(100),
			  SubReferencia		varchar(100),
			  Version			float,
			  Usuario			varchar(10),
			  Solicitud			varchar(max),
			  Resultado			varchar(max),
			  Estatus			varchar(15),
			  FechaEstatus		datetime,
			  Ok				int,
			  OkRef				varchar(255),
			  Conversacion		uniqueidentifier,
			  SincroGUID		uniqueidentifier,
			  SucursalOrigen	int,
			  SucursalDestino	int,
			  SincroTabla		varchar(100),
			  SincroSolicitud	uniqueidentifier)
        
      EXEC sp_xml_removedocument @iDatos
    END

    IF dbo.fnSincroISReceptorPuedeInsertarDropBox(@ID, @Conversacion) = 1
    BEGIN
      EXEC spSincroISTransmisorInsertarIS @Sistema, @Contenido, @Referencia, @SubReferencia, @Version, @Usuario, @Solicitud, NULL, @Resultado, 
										  'RECIBIDO', @FechaEstatus, @ISOk, @ISOkRef, @SincroGUID, @Conversacion, @SucursalOrigen, @SucursalDestino, 
										  @SincroGUID, @SincroTabla, @SincroSolicitud, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL
        EXEC spEliminarArchivo @ArchivoProcesado, @Ok OUTPUT, @OkRef OUTPUT
              
      IF @Ok IS NULL
        EXEC spMoverArchivo @ArchivoZIP, @ArchivoProcesado, @Ok OUTPUT, @OkRef OUTPUT
      
      IF @Ok IS NULL
        EXEC spSincroISActualizaEstatusPaqueteDropBox @Conversacion, @ID
    END
    
    IF @Ok IS NULL
      EXEC spEliminarArchivo @ArchivoXML, @Ok OUTPUT, @OkRef OUTPUT
  END

  RETURN
END
GO

/************** spSincroISReceptorPaqueteDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISReceptorPaqueteDropBox') and type = 'P') drop procedure dbo.spSincroISReceptorPaqueteDropBox
GO
CREATE PROC spSincroISReceptorPaqueteDropBox
		  @Ok								int				= NULL OUTPUT,
		  @OkRef							varchar(255)	= NULL OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion							int,
		  @SincroISDropBox					bit, 
		  @SincroISDropBoxRuta				varchar(255),
		  @Sucursal							int,
		  @SincroISDropBoxRutaSucursal		varchar(255),
		  @SincroISDropBoxRutaSucursalProc	varchar(255),
		  @ArchivoXML						varchar(255),
		  @ArchivoPAQ						varchar(255),
		  @ArchivoProcesado					varchar(255),		  
		  @Nombre							varchar(128),
		  @NombreAnt						varchar(128),
		  @XML								varchar(max),
		  @iDatos							int

  CREATE TABLE #SincroISDropBoxPaquete(
    RID						int identity(1,1) NOT NULL,
	Conversacion			uniqueidentifier,
    Paquete					varchar(255),

	IntelisisServiceID		int
    )

  SELECT @SincroISDropBox		= ISNULL(SincroISDropBox, 0),
		 @SincroISDropBoxRuta	= dbo.fnDirectorioEliminarDiagonalFinal(SincroISDropBoxRuta),
		 @Sucursal				= Sucursal
	FROM Version

  IF @SincroISDropBox = 0 RETURN

  SELECT @SincroISDropBoxRutaSucursal = @SincroISDropBoxRuta + '\' + CONVERT(varchar, @Sucursal)
  SELECT @SincroISDropBoxRutaSucursalProc = @SincroISDropBoxRutaSucursal + '\Procesados'
  
  EXEC spCrearDirectorio @SincroISDropBoxRutaSucursalProc, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  SELECT @Estacion = @@SPID

  EXEC speDocInListarDirectorio @SincroISDropBoxRutaSucursal, @Estacion
  
  SELECT @NombreAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Nombre = MIN(Nombre)
      FROM eDocInDirDetalle
     WHERE Estacion = @Estacion
       AND Nombre > @NombreAnt
       AND Tipo	= '.paq'

    IF @Nombre IS NULL BREAK
    
    SELECT @NombreAnt = @Nombre

    SELECT @ArchivoPAQ		 = @SincroISDropBoxRutaSucursal + '\' + @Nombre,
		   @ArchivoXML		 = @SincroISDropBoxRutaSucursal + '\' + REPLACE(@Nombre, '.paq', '.xml'),
		   @ArchivoProcesado = @SincroISDropBoxRutaSucursalProc + '\' + @Nombre

    IF @Ok IS NULL
      EXEC spDescomprimirArchivo @ArchivoPAQ, @ArchivoXML, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @Ok IS NULL
    BEGIN
      EXEC spLeerArchivo @ArchivoXML, @Archivo = @XML OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
      SELECT @XML = '<?xml version="1.0" encoding="windows-1252"?>' + REPLACE(@XML, '<?xml version="1.0" encoding="UTF-8"?>', '')
    END

    IF @Ok IS NULL
    BEGIN
      EXEC sp_xml_preparedocument @iDatos OUTPUT, @XML
      
      INSERT INTO #SincroISDropBoxPaquete(
			   Conversacion,		Paquete,		
			   IntelisisServiceID) 
        SELECT Conversacion,		@Nombre,
			   IntelisisServiceID
	      FROM OPENXML (@iDatos, '/SincroISDropBoxPaquete/IntelisisService')
          WITH SincroISDropBoxPaquete

      INSERT INTO SincroISDropBoxPaquete(
			   Conversacion,		Paquete,		
			   IntelisisServiceID) 
        SELECT Conversacion,		@Nombre,
			   IntelisisServiceID
		  FROM #SincroISDropBoxPaquete I
		 WHERE IntelisisServiceID NOT IN(SELECT IntelisisServiceID FROM SincroISDropBoxPaquete WHERE Conversacion = I.Conversacion)
      
      EXEC sp_xml_removedocument @iDatos    
    END
    
    IF @Ok IS NULL
      EXEC spEliminarArchivo @ArchivoXML, @Ok OUTPUT, @OkRef OUTPUT    

    IF @Ok IS NULL
      EXEC spEliminarArchivo @ArchivoProcesado, @Ok OUTPUT, @OkRef OUTPUT
        
    IF @Ok IS NULL
      EXEC spMoverArchivo @ArchivoPAQ, @ArchivoProcesado, @Ok OUTPUT, @OkRef OUTPUT        
    
  END
  RETURN
END
GO

/************** spSincroISReceptorEliminarArchivosDropBox *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroISReceptorEliminarArchivosDropBox') and type = 'P') drop procedure dbo.spSincroISReceptorEliminarArchivosDropBox
GO
CREATE PROC spSincroISReceptorEliminarArchivosDropBox
		 @SincroISDropBox					bit,
		 @SincroISDropBoxRuta				varchar(255),
		 @Sucursal							int,
		 @ISDropBoxDiasResguardoArchivos	int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Estacion							int,
		  @SincroISDropBoxRutaSucursalProc	varchar(255),
		  @Nombre							varchar(128),
		  @NombreAnt						varchar(128),
		  @NoDias							int,
		  @Hoy								datetime,
		  @Archivo							varchar(255),
		  @Ok								int,
		  @OkRef							varchar(255)
		  		    
  SELECT @Estacion = @@SPID, @Hoy = GETDATE()

  SELECT @SincroISDropBoxRutaSucursalProc = @SincroISDropBoxRuta + '\' + CONVERT(varchar, @Sucursal) + '\Procesados'
  
  EXEC speDocInListarDirectorio @SincroISDropBoxRutaSucursalProc, @Estacion

  SELECT @NombreAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Nombre = MIN(Nombre)
      FROM eDocInDirDetalle
     WHERE Estacion = @Estacion
       AND Nombre > @NombreAnt
       AND Tipo	IN('.zip', '.paq')

    IF @Nombre IS NULL BREAK
    
    SELECT @NombreAnt = @Nombre, @Archivo = @SincroISDropBoxRutaSucursalProc + '\' + @Nombre

    SELECT @NoDias = DATEDIFF(dd, FechaCreacion, @Hoy)
      FROM eDocInDirDetalle
     WHERE Estacion = @Estacion
       AND Nombre	= @Nombre

    IF @NoDias > @ISDropBoxDiasResguardoArchivos
      EXEC spEliminarArchivo @Archivo, @Ok OUTPUT, @OkRef OUTPUT    
  END
  RETURN
END
GO

/************** spSincroIS_Sincronizar *************/
if exists (select * from sysobjects where id = object_id('dbo.spSincroIS_Sincronizar') and type = 'P') drop procedure dbo.spSincroIS_Sincronizar
GO
CREATE PROCEDURE spSincroIS_Sincronizar
			@Usuario	varchar(10),
			@Debug		bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Sucursal							int,
          @Transmitiendo					bit,
		  -- 9562
		  @SincroISDropBox					bit,
		  @SincroISDropBoxRuta				varchar(255),
		  @ISDropBoxDiasResguardoArchivos	int,
		  @Ok								int,
		  @OkRef							varchar(255)
 
  CHECKPOINT 
  DBCC DROPCLEANBUFFERS
  EXEC("CHECKPOINT; DBCC DROPCLEANBUFFERS;")

  -- 9562
  SELECT @Sucursal = Sucursal, @Transmitiendo = SincroISTransmitiendo, @SincroISDropBox = ISNULL(SincroISDropBox, 0), @SincroISDropBoxRuta = dbo.fnDirectorioEliminarDiagonalFinal(SincroISDropBoxRuta), @ISDropBoxDiasResguardoArchivos = ISDropBoxDiasResguardoArchivos FROM Version

  IF @SincroISDropBox = 1
  BEGIN
    EXEC spSincroISReceptorEliminarArchivosDropBox @SincroISDropBox, @SincroISDropBoxRuta, @Sucursal, @ISDropBoxDiasResguardoArchivos
      
    EXEC spSincroISReceptorPaqueteDropBox @Ok OUTPUT, @OkRef OUTPUT
    
    IF @Ok IS NULL
      EXEC spSincroISReceptorDropBox
  END
  
  --IF dbo.fnObjetoCorriendo('spSincroIS') = 0 AND dbo.fnObjetoCorriendo('spIntelisisService') = 0
  --BEGIN
  EXEC spSetInformacionContexto 'SINCROIS', 1        
  UPDATE Version SET SincroISTransmitiendo = 1  
  EXEC spSetInformacionContexto 'SINCROIS', 0          
  EXEC spSincroIS_Recibir @Usuario, @Debug

  IF @Sucursal > 0 EXEC spSincroIS_Enviar @Usuario

  SET ANSI_NULLS ON
  SET ANSI_WARNINGS ON
  -- 9562
  EXEC spSincroISTransmisor @SincroISDropBox = @SincroISDropBox, @SincroISDropBoxRuta = @SincroISDropBoxRuta
  SET ANSI_NULLS OFF
  SET ANSI_WARNINGS OFF
  --END

  RETURN
END
GO

--DELETE FROM INTELISISSERVICELOG
--UPDATE INTELISISSERVICE SET ESTATUS = 'SINPROCESAR'
--select no lo estatus,* FROM INTELISISSERVICE WHERE ESTATUS = 'sinprocesar'

--select * from sincroistransmisorsucursal

--select * from idremoto
-------------------------------------------------
/*
if db_name() in ('Indar2')     use SurteFacil else 
--if db_name() in ('Calzada')    use SurteFacil else
if db_name() in ('SurteFacil') use master
*/

/*
if db_name() in ('indar')     use surtefacil else 
if db_name() in ('surtefacil')    use master
*/

--SELECT * FROM USUARIO

--SELECT * FROM SYSTABLA WHERE SYSTABLA = 'comprac'

--select * from movtipocontauto