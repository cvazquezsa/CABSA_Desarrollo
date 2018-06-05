SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF 
GO

/************************************************** Campos para Versiones anteriores **************************************************/
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

/**************** spShrink_Log ****************/
if exists (select * from sysobjects where id = object_id('dbo.spShrink_Log') and type = 'P') drop procedure dbo.spShrink_Log
GO
CREATE PROC spShrink_Log
			@Base		varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @SQL		nvarchar(2000),
		  @Size		float,
		  @SizeAnt	float

  CREATE TABLE #dbccOpenTran(DatabaseName sysname, OpenTran varchar(30))

  WHILE(1=1)
  BEGIN
    DELETE #dbccopentran
    
    SELECT @SizeAnt = size/128.0
      FROM master..sysaltfiles AS saf 
      JOIN master..sysdatabases AS sdb ON saf.dbid = sdb.dbid 
     WHERE saf.filename LIKE '%.ldf%' 
       AND sdb.name = @Base 
           
    INSERT INTO #dbccopentran EXEC ('DBCC OPENTRAN WITH TABLERESULTS, NO_INFOMSGS')
    
    IF NOT EXISTS(SELECT * FROM #dbccopentran)
    BEGIN
      SELECT @SQL = 'USE '+sdb.name+';CHECKPOINT;DBCC SHRINKFILE ('+ CONVERT(varchar(max), saf.fileid)+', 1) WITH NO_INFOMSGS'  
        FROM master..sysaltfiles AS saf 
        JOIN master..sysdatabases AS sdb ON saf.dbid = sdb.dbid 
       WHERE saf.filename LIKE '%.ldf%' 
         AND sdb.name = @Base    
    
      EXEC sp_executesql @SQL

      SELECT @Size = size/128.0
        FROM master..sysaltfiles AS saf 
        JOIN master..sysdatabases AS sdb ON saf.dbid = sdb.dbid 
       WHERE saf.filename LIKE '%.ldf%' 
         AND sdb.name = @Base 
             
      IF ISNULL(@Size, 0) <= ISNULL(@SizeAnt, 0)
        BREAK
    END
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
  if not exists(select * from syscampo where tabla = @Tabla and campo = @Campo)
  BEGIN
    SELECT @SQL = 'ALTER TABLE '+@Tabla+' ADD '+@Campo+' '+@Extras
    IF NULLIF(RTRIM(@Default), '') IS NOT NULL
      SELECT @SQL = @SQL + ' DEFAULT '+@Default
    EXEC(@SQL)
  END
END
GO

--BUG16116
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

--BUG16116
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

  EXEC spDROP_CONSTRAINT @Tabla, @Campo
  EXEC('ALTER TABLE '+@Tabla+' ALTER COLUMN '+@Campo+' '+@Extras)

  IF NULLIF(RTRIM(@Default), '') IS NOT NULL
  BEGIN
    SELECT @Nombre = 'DF_'+@Tabla+'_'+@Campo+'_'+CONVERT(varchar, ColID) FROM SysCampo WHERE Tabla = @Tabla AND Campo = @Campo
    EXEC('ALTER TABLE '+@Tabla+' ADD CONSTRAINT '+@Nombre+' DEFAULT '+@Default+' FOR '+@Campo)
  END
END
GO

--select * from EmpresaMFA
--update EmpresaMFA set UnidadGramo='Litro'

--select Unidad,* from VentaD where Articulo='12002'

EXEC spAlter_Table 'Version', 'Impuesto2Info', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'Version', 'Impuesto3Info', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'Version', 'Impuesto2BaseImpuesto1', 'bit NULL DEFAULT 1 WITH VALUES'

EXEC spAlter_Table 'GastoD', 'Impuestos2', 'float NULL'
EXEC spAlter_Table 'GastoD', 'Impuesto1', 'float NULL'
EXEC spAlter_Table 'GastoD', 'Impuesto2', 'float NULL'

EXEC spAlter_Table 'VentaD', 'Impuesto1', 'float NULL'

EXEC spAlter_Table 'VentaD', 'Retencion1', 'float NULL'
EXEC spAlter_Table 'VentaD', 'Retencion2', 'float NULL'
EXEC spAlter_Table 'VentaD', 'Retencion3', 'float NULL'
--BUG22277
EXEC spAlter_Table 'VentaD', 'AnticipoFacturado','bit NULL DEFAULT 0 WITH VALUES'

EXEC spAlter_Table 'CompraD', 'Impuesto1', 'float NULL'

EXEC spAlter_Table 'CompraD', 'Impuesto1', 'float NULL'
EXEC spAlter_Table 'CompraD', 'Impuesto2', 'float NULL'

EXEC spALTER_TABLE 'CompraD', 'CostoEstandar', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'CantidadEmbarcada', 'float NULL'
EXEC spALTER_TABLE 'CompraD', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CompraD', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CompraD', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'ClavePresupuestal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'TipoRetencion3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoPromedio', 'money NULL'
EXEC spALTER_TABLE 'CompraD', 'CostoReposicion', 'money NULL'

EXEC spAlter_Table 'Cte', 'MFATipoOperacion', 'varchar(50) DEFAULT ''otros'' WITH VALUES'
EXEC spAlter_Table 'Prov', 'MFATipoOperacion', 'varchar(50) DEFAULT ''otros'' WITH VALUES'
EXEC spAlter_Table 'Art', 'MFATipoDeducibilidad', 'varchar(50) DEFAULT ''deducible'' WITH VALUES'
EXEC spAlter_Table 'Concepto', 'MFATipoDeducibilidad', 'varchar(50) DEFAULT ''deducible'' WITH VALUES'
GO

--REQ16748
EXEC spALTER_TABLE 'Concepto', 'EsImportacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'EsIVAImportacion', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--BUG17795
EXEC spALTER_TABLE 'Concepto', 'MFAEsDeducible', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaGral', 'InterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'UsuarioCfg2', 'InterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'AccesoInterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Version', 'InterfazExentus', 'varchar(255) NULL DEFAULT "" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'AccesoInterfazExentus', 'varchar(255) NULL DEFAULT "" WITH VALUES'
EXEC spALTER_TABLE 'Version', 'InterfazExentus2', 'varchar(255) NULL DEFAULT "" WITH VALUES'
GO

EXEC spALTER_TABLE 'Prov', 'ClaveTipoTercero', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Prov', 'ClaveTipoOperacion', 'varchar(50) NULL'
GO

--BUG21567
EXEC spALTER_TABLE 'ContD', 'SubCuenta2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ContD', 'SubCuenta3', 'varchar(50) NULL'
GO

--BUG26056
EXEC spALTER_TABLE 'Inv', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Compra', 'ContUso', 'varchar(20) NULL'
GO

--REQ23317
if not exists(select * from mensajelista where mensaje = 10385)
  insert MensajeLista (Mensaje,Descripcion) VALUES (10385,'Falta Configurar el Numero de Periodo')
if not exists(select * from mensajelista where mensaje = 10050)
  insert MensajeLista (Mensaje,Descripcion) VALUES (10050,'Ejercicio Incorrecto')
GO

/************************************************** Tablas **************************************************/
--BUG21567
/****** MFACuentaComplementaria ******/
if not exists(select * from SysTabla where SysTabla = 'MFACuentaComplementaria')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFACuentaComplementaria','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFACuentaComplementaria') and type = 'U') 
CREATE TABLE dbo.MFACuentaComplementaria(
	Cuenta			varchar(20)	NOT NULL,
	Moneda			varchar(10)	NOT NULL,
	CONSTRAINT priMFACuentaComplementaria PRIMARY KEY CLUSTERED(Cuenta)
)
GO	

--BUG24031
EXEC spDROP_PK 'MFACuentaComplementaria'
GO
EXEC spALTER_TABLE 'MFACuentaComplementaria', 'Empresa', 'varchar(5) NOT NULL DEFAULT '''' WITH VALUES'
GO
EXEC spADD_PK 'MFACuentaComplementaria', 'Empresa, Cuenta, Moneda'
GO

/****** TipoTercero ******/
if not exists(select * from SysTabla where SysTabla = 'TipoTercero')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoTercero','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoTercero') and type = 'U') 
CREATE TABLE dbo.TipoTercero (
	Codigo	 		varchar(10) 	NOT NULL,
	Clave			varchar(50) 	NOT NULL,

	CONSTRAINT priTipoTercero PRIMARY KEY  CLUSTERED (Codigo, Clave)
)
GO

/****** TipoOperacion ******/
if not exists(select * from SysTabla where SysTabla = 'TipoOperacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoOperacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoOperacion') and type = 'U') 
CREATE TABLE dbo.TipoOperacion (
	Codigo	 		varchar(10) 	NOT NULL,
	Clave			varchar(50) 	NOT NULL,

	CONSTRAINT priTipoOperacion PRIMARY KEY  CLUSTERED (Codigo, Clave)
)
GO


-- drop table layout_log
if not exists (select * from sysobjects where id = object_id('dbo.layout_log') and type = 'U') 
CREATE TABLE layout_log (
	log_id				int				NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
	accion				varchar(50)		NULL,
	estatus				varchar(50)		NULL,
	usuario				varchar(20)		NULL,
	conteo				int				NULL,
	inicio				datetime		NULL		DEFAULT GETDATE(),
	fin					datetime		NULL,
	error				int				NULL,
	error_mensaje		varchar(255)	NULL,
)
GO

--REQ16752
EXEC spALTER_TABLE 'layout_log', 'SQL', 'varchar(max) NULL'
EXEC spALTER_TABLE 'layout_log', 'SQLDelete', 'varchar(max) NULL'
EXEC spALTER_TABLE 'layout_log', 'Procesado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spDROP_COLUMN 'layout_log', 'Procesado'
EXEC spALTER_TABLE 'layout_log', 'EstatusAnalisis', 'varchar(15) NOT NULL DEFAULT ''SINAFECTAR'' WITH VALUES'
GO

--BUG22719
EXEC spALTER_TABLE 'layout_log', 'Empresa', 'varchar(5) NULL'
GO

-- drop table layout_logd
if not exists (select * from sysobjects where id = object_id('dbo.layout_logd') and type = 'U') 
CREATE TABLE layout_logd (
	log_id				int				NOT NULL,
	d_id				int				NOT NULL	IDENTITY(1,1),
	
	folio				varchar(50)		NULL,
	referencia			varchar(50)		NULL,
	
	CONSTRAINT pk_layout_logd PRIMARY KEY CLUSTERED (log_id, d_id)
)
GO
EXEC spALTER_TABLE 'layout_logd', 'folio', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_logd', 'referencia', 'varchar(50) NULL'
GO

--REQ16752
EXEC spALTER_TABLE 'layout_logd', 'aplicacion_origen_id', 'int NULL'
EXEC spALTER_TABLE 'layout_logd', 'aplicacion_origen_modulo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_logd', 'aplicacion_tipo_aplicacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_logd', 'aplicacion_Mov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_logd', 'aplicacion_MovID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_logd', 'empresa', 'varchar(5) NULL'
EXEC spALTER_TABLE 'layout_logd', 'origen_vista', 'varchar(255) NULL'
EXEC spALTER_TABLE 'layout_logd', 'Accion', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'layout_logd', 'Accion', 'varchar(30) NULL'
GO

-- drop table layout_documentos
if not exists (select * from sysobjects where id = object_id('dbo.layout_documentos') and type = 'U') 
CREATE TABLE layout_documentos (
	origen_tipo						varchar(50)		NULL,		-- auto, manual
	origen_modulo					varchar(50)		NULL,		-- ventas, compras, gastos
	origen_id						varchar(50)		NULL,
	empresa							varchar(5)		NULL,
	emisor							varchar(50)		NULL,		-- empresa, terceros
	tipo_documento					varchar(50)		NULL,		-- factura, nota_cargo, nota_credito, anticipo, devolucion, prestamo, comprobacion_gastos
	folio							varchar(50)		NULL,	
	ejercicio						smallint		NULL,
	periodo							smallint		NULL,
	dia								smallint		NULL,
	entidad_clave					varchar(20)		NULL,
	entidad_nombre					varchar(150)	NULL,
	entidad_rfc						varchar(15)		NULL,
	entidad_id_fiscal				varchar(50)		NULL,
	entidad_tipo_tercero			varchar(50)		NULL,		-- nacional, extranjero, global			
	entidad_tipo_operacion			varchar(50)		NULL,		-- prestacion_servicios, arrendamiento_inmuebles, otros	
	entidad_pais					varchar(20)		NULL,
	entidad_nacionalidad			varchar(50)		NULL,
	entidad_cuenta_contable			varchar(60)		NULL,
	agente_clave					varchar(20)		NULL,
	agente_nombre					varchar(150)	NULL,
	concepto						varchar(200)	NULL,
	concepto_cuenta_contable		varchar(60)		NULL,
	acumulable_deducible			varchar(50)		NULL,		-- si, no, viaticos, intereses, activos
	importe							float			NULL,
	retencion_isr					float			NULL,
	retencion_iva					float			NULL,
	base_iva						float			NULL,
	iva_excento						bit				NULL	DEFAULT 0,
	iva_tasa						float			NULL,
	iva								float			NULL,
	base_ieps						float			NULL,
	ieps_tasa						float			NULL,
	ieps							float			NULL,
	base_isan						float			NULL,
	isan							float			NULL,
	base_otros_impuestos			float			NULL,
	otros_impuestos_tasa			float			NULL,
	otros_impuestos					float			NULL,
	otros_impuestos_tipo			varchar(20)		NULL,		-- ish
	otros_impuestos_cuenta_contable	varchar(60)		NULL,
	importe_total					float			NULL,
	
	ieps_num_reporte			varchar(20)		NULL,
	ieps_categoria_concepto		varchar(20)		NULL,
	ieps_exento					bit				NULL DEFAULT 0,
	ieps_envase_reutilizable	bit				NULL DEFAULT 0,
	ieps_retencion				float			NULL,
	ieps_cantidad				float			NULL,
	ieps_unidad					varchar(50)		NULL,
	ieps_cantidad2				float			NULL,
	ieps_unidad2				varchar(50)		NULL,
)
GO
EXEC spALTER_TABLE 'layout_documentos', 'entidad_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'concepto_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'base_otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_tasa', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_cuenta_contable', 'varchar(60) NULL'
GO
EXEC spALTER_TABLE 'layout_documentos', 'ieps_num_reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_categoria_concepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_exento', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_envase_reutilizable', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_retencion', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_cantidad', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_cantidad2', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_unidad2', 'varchar(50) NULL'
GO

--REQ16752
EXEC spALTER_TABLE 'layout_documentos', 'origen_vista', 'varchar(255) NULL'
GO

--BUG23552
EXEC spALTER_TABLE 'layout_documentos', 'ieps_iva', 'float NULL'
GO

--CAMPOS PARA USO INTERNO
EXEC spAlter_Table 'layout_documentos', 'concepto_clave', 'varchar(50) NULL'

--CAMPOS CUENTAS CONTABLES
EXEC spAlter_Table 'layout_documentos', 'subtipo_documento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'entidad_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'concepto_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'base_otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_tasa', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'otros_impuestos_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'retencion_isr_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'iva_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'retencion_iva_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'isan_cuenta_contable', 'varchar(60) NULL'
GO

--CAMPOS IEPS
EXEC spALTER_TABLE 'layout_documentos', 'ieps_num_reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_categoria_concepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_exento', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_envase_reutilizable', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_retencion', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_cantidad', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_cantidad2', 'float NULL'
EXEC spALTER_TABLE 'layout_documentos', 'ieps_unidad2', 'varchar(50) NULL'
GO

--REQ16520
EXEC spALTER_TABLE 'Layout_Documentos', 'SubTipoIetu', 'Int NULL'
GO

--REQ16748
EXEC spALTER_TABLE 'Layout_Documentos', 'concepto_es_importacion', 'bit NULL'
GO

--BUG17507
EXEC spALTER_TABLE 'layout_documentos', 'dinero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_documentos', 'dinero_id', 'varchar(20) NULL'
GO

--BUG18077
EXEC spALTER_TABLE 'layout_documentos', 'EsIFRS', 'bit NULL DEFAULT 0'
GO

--BUG20353
EXEC spALTER_TABLE 'layout_documentos', 'concepto_aplica_ieps', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'layout_documentos', 'concepto_aplica_ietu', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'layout_documentos', 'concepto_aplica_iva',  'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--BUG22156
EXEC spALTER_TABLE 'layout_documentos', 'EsActivoFijo', 'bit NULL'
EXEC spALTER_TABLE 'layout_documentos', 'TipoActivo', 'smallint NULL'
EXEC spALTER_TABLE 'layout_documentos', 'TipoActividad', 'varchar(20) NULL'
GO

EXEC spALTER_TABLE 'Layout_documentos', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'layout_documentos', 'fecha', 'datetime NULL'
GO

--BUG22833
EXEC spALTER_TABLE 'layout_documentos', 'BaseIVAImportacion', 'float NULL'
GO

--BUG24733
EXEC spALTER_TABLE 'layout_documentos', 'PorcentajeDeducible', 'float NULL'
GO

-- drop table documentos
if not exists (select * from sysobjects where id = object_id('dbo.documentos') and type = 'U') 
CREATE TABLE documentos (
	documento_id					int				NOT NULL	IDENTITY(1,1)	PRIMARY KEY,
	log_id							int				NULL,	

	origen_tipo						varchar(50)		NULL,		-- auto, manual
	origen_modulo					varchar(50)		NULL,		-- ventas, compras, gastos
	origen_id						varchar(50)		NULL,
	empresa							varchar(5)		NULL,
	emisor							varchar(50)		NULL,		-- empresa, terceros
	tipo_documento					varchar(50)		NULL,		-- factura, nota_cargo, nota_credito, anticipo, devolucion, prestamo, comprobacion_gastos
	folio							varchar(50)		NULL,	
	ejercicio						smallint		NULL,
	periodo							smallint		NULL,
	dia								smallint		NULL,
	entidad_clave					varchar(20)		NULL,
	entidad_nombre					varchar(150)	NULL,
	entidad_rfc						varchar(15)		NULL,
	entidad_id_fiscal				varchar(50)		NULL,
	entidad_tipo_tercero			varchar(50)		NULL,		-- nacional, extranjero, global			
	entidad_tipo_operacion			varchar(50)		NULL,		-- prestacion_servicios, arrendamiento_inmuebles, otros	
	entidad_pais					varchar(20)		NULL,
	entidad_nacionalidad			varchar(50)		NULL,
	entidad_cuenta_contable			varchar(60)		NULL,
	agente_clave					varchar(20)		NULL,
	agente_nombre					varchar(150)	NULL,
	concepto						varchar(200)	NULL,
	concepto_cuenta_contable		varchar(60)		NULL,
	acumulable_deducible			varchar(50)		NULL,		-- si, no, viaticos, intereses, activos
	importe							float			NULL,
	retencion_isr					float			NULL,
	retencion_iva					float			NULL,
	base_iva						float			NULL,
	iva_excento						bit				NULL	DEFAULT 0,
	iva_tasa						float			NULL,
	iva								float			NULL,
	base_ieps						float			NULL,
	ieps_tasa						float			NULL,
	ieps							float			NULL,
	base_isan						float			NULL,
	isan							float			NULL,
	base_otros_impuestos			float			NULL,
	otros_impuestos_tasa			float			NULL,
	otros_impuestos					float			NULL,
	otros_impuestos_tipo			varchar(20)		NULL,	-- ish
	otros_impuestos_cuenta_contable	varchar(60)		NULL,
	importe_total					float			NULL,

	referencia						varchar(50)		NULL,
	aplicacion_id					int				NULL,
	
	ieps_num_reporte			varchar(20)		NULL,
	ieps_categoria_concepto		varchar(20)		NULL,
	ieps_exento					bit				NULL DEFAULT 0,
	ieps_envase_reutilizable	bit				NULL DEFAULT 0,
	ieps_retencion				float			NULL,
	ieps_cantidad				float			NULL,
	ieps_unidad					varchar(50)		NULL,
	ieps_cantidad2				float			NULL,
	ieps_unidad2				varchar(50)		NULL,
)
GO
EXEC spALTER_TABLE 'documentos', 'entidad_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'documentos', 'concepto_cuenta_contable', 'varchar(60) NULL'
EXEC spALTER_TABLE 'documentos', 'base_otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'otros_impuestos_tasa', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'otros_impuestos', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'otros_impuestos_tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'documentos', 'otros_impuestos_cuenta_contable', 'varchar(60) NULL'
GO
EXEC spAlter_Table 'documentos', 'subtipo_documento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_num_reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_categoria_concepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_exento', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'documentos', 'ieps_envase_reutilizable', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'documentos', 'ieps_retencion', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_cantidad', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_cantidad2', 'float NULL'
EXEC spALTER_TABLE 'documentos', 'ieps_unidad2', 'varchar(50) NULL'
GO

--REQ16520
EXEC spALTER_TABLE 'documentos', 'concepto_clave', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Documentos', 'SubTipoIetu', 'Int NULL'
EXEC spALTER_TABLE 'DatosIetu', 'SubTipoIetu', 'Int NULL'
GO

--REQ16748
EXEC spALTER_TABLE 'documentos', 'concepto_es_importacion', 'bit NULL'
GO

--BUG20353
EXEC spALTER_TABLE 'documentos', 'concepto_aplica_ieps', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'documentos', 'concepto_aplica_ietu', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'documentos', 'concepto_aplica_iva',  'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--BUG22156
EXEC spALTER_TABLE 'documentos', 'EsActivoFijo', 'bit NULL'
EXEC spALTER_TABLE 'documentos', 'TipoActivo', 'smallint NULL'
EXEC spALTER_TABLE 'documentos', 'TipoActividad', 'varchar(20) NULL'
GO

EXEC spALTER_TABLE 'Documentos', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'documentos', 'fecha', 'datetime NULL'
GO

--BUG22759
EXEC spALTER_TABLE 'documentos', 'EsRedocumentacion', 'bit NULL'
GO

--BUG22833
EXEC spALTER_TABLE 'documentos', 'BaseIVAImportacion', 'float NULL'
GO

--BUG23552
EXEC spALTER_TABLE 'documentos', 'ieps_iva', 'float NULL'
GO

--REQ16752
EXEC spALTER_TABLE 'documentos', 'origen_vista', 'varchar(255) NULL'
GO

--BUG24733
EXEC spALTER_TABLE 'documentos', 'PorcentajeDeducible', 'float NULL'
GO

-- drop table layout_aplicaciones
if not exists (select * from sysobjects where id = object_id('dbo.layout_aplicaciones') and type = 'U') 
CREATE TABLE layout_aplicaciones (
	origen_tipo				varchar(50)		NULL,		-- auto, manual
	origen_modulo			varchar(50)		NULL,		-- cxc, cxp
	origen_id				varchar(50)		NULL,
	empresa					varchar(5)		NULL,
	tipo_aplicacion			varchar(50)		NULL,		-- aplicacion, redocumentacion, cobro, pago
	folio					varchar(50)		NULL,
	ejercicio				smallint		NULL,
	periodo					smallint		NULL,
	dia						smallint		NULL,
	referencia				varchar(50)		NULL,
	importe					float			NULL,
	cuenta_bancaria			varchar(50)		NULL,
)
GO

--BUG16247
EXEC spALTER_TABLE 'layout_aplicaciones', 'aplica_ieps', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'layout_aplicaciones', 'aplica_ietu', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'layout_aplicaciones', 'aplica_iva',  'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--REQ16752
EXEC spALTER_TABLE 'layout_aplicaciones', 'origen_vista', 'varchar(255) NULL'

--BUG17507
EXEC spALTER_TABLE 'layout_aplicaciones', 'dinero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_aplicaciones', 'dinero_id', 'varchar(20) NULL'
EXEC spALTER_TABLE 'layout_aplicaciones', 'EsIFRS', 'bit NULL DEFAULT 0'
GO

--BUG18767
EXEC spALTER_TABLE 'layout_aplicaciones', 'tipo_documento', 'varchar(50) NULL'
GO

EXEC spALTER_TABLE 'Layout_aplicaciones', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'layout_aplicaciones', 'fecha', 'datetime NULL'
GO

-- drop table aplicaciones
if not exists (select * from sysobjects where id = object_id('dbo.aplicaciones') and type = 'U') 
CREATE TABLE aplicaciones (
	aplicacion_id			int				NOT NULL IDENTITY(1,1)	PRIMARY KEY,	
	log_id					int				NULL,	
	
	origen_tipo				varchar(50)		NULL,		-- auto, manual
	origen_modulo			varchar(50)		NULL,		-- cxc, cxp
	origen_id				varchar(50)		NULL,
	empresa					varchar(5)		NULL,
	tipo_aplicacion			varchar(50)		NULL,		-- aplicacion, redocumentacion, cobro, pago
	folio					varchar(50)		NULL,
	ejercicio				smallint		NULL,
	periodo					smallint		NULL,
	dia						smallint		NULL,
	referencia				varchar(50)		NULL,
	importe					float			NULL,
	cuenta_bancaria			varchar(50)		NULL,
)
GO

--BUG16247
EXEC spALTER_TABLE 'aplicaciones', 'aplica_ieps', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'aplicaciones', 'aplica_ietu', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'aplicaciones', 'aplica_iva',  'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--REQ16752
EXEC spALTER_TABLE 'aplicaciones', 'origen_vista', 'varchar(255) NULL'
GO

--BUG18767
EXEC spALTER_TABLE 'aplicaciones', 'tipo_documento', 'varchar(50) NULL'
GO

EXEC spALTER_TABLE 'Aplicaciones', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'aplicaciones', 'fecha', 'datetime NULL'
GO

-- drop table layout_cuentas
if not exists (select * from sysobjects where id = object_id('dbo.layout_cuentas') and type = 'U') 
CREATE TABLE layout_cuentas (
	empresa					varchar(5)		NULL,	
	cuenta_contable			varchar(60)		NULL,		
	cuenta_control			varchar(60)		NULL,
	descripcion				varchar(150)	NULL,
	nivel					smallint		NULL,
	clase_cuenta			varchar(50)		NULL,		-- control, registro
	tipo_cuenta				varchar(50)		NULL,		-- activo_circulante, activo_fijo, activo_diferido, pasivo_corto_plazo, pasivo_largo_plazo, capital_contable, otros_gastos, otros_productos, gastos_operacion, impuestos, cuentas_orden, costos, ingresos
	ejercicio				smallint		NULL,
	saldo_inicial			float			NULL,
	moneda					varchar(10)		NULL,
)
GO

EXEC spALTER_TABLE 'Layout_cuentas', 'sucursal', 'varchar(10) not null default '''''
GO

--REQ23317
EXEC spALTER_TABLE 'Layout_cuentas', 'EsComplementaria', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Layout_cuentas', 'saldo_inicial_cargos', 'float NULL'
EXEC spALTER_TABLE 'Layout_cuentas', 'saldo_inicial_abonos', 'float NULL'
GO

-- drop table cuentas
if not exists (select * from sysobjects where id = object_id('dbo.cuentas') and type = 'U') 
CREATE TABLE cuentas (
	cuenta_id				int				NOT NULL IDENTITY(1,1)	PRIMARY KEY,	
	log_id					int				NULL,	

	empresa					varchar(5)		NULL,
	cuenta_contable			varchar(50)		NULL,
	cuenta_control			varchar(50)		NULL,
	descripcion				varchar(150)	NULL,
	nivel					smallint		NULL,
	clase_cuenta			varchar(50)		NULL,		-- control, registro
	tipo_cuenta				varchar(50)		NULL,		-- activo_circulante, activo_fijo, activo_diferido, pasivo_corto_plazo, pasivo_largo_plazo, capital_contable, otros_gastos, otros_productos, gastos_operacion, impuestos, cuentas_orden, costos, ingresos
	ejercicio				smallint		NULL,
	saldo_inicial			float			NULL,
	moneda					varchar(10)		NULL,
)
GO

EXEC spALTER_TABLE 'Cuentas', 'sucursal', 'varchar(10) not null default '''''
GO

-- drop table layout_polizas
if not exists (select * from sysobjects where id = object_id('dbo.layout_polizas') and type = 'U') 
CREATE TABLE layout_polizas (
	empresa					varchar(5)		NULL,	
	ejercicio				smallint		NULL,
	periodo					smallint		NULL,
	cuenta_contable			varchar(50)		NULL,	
	cargos					float			NULL,
	abonos					float			NULL,
)
GO

EXEC spALTER_TABLE 'Layout_polizas', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'Layout_polizas', 'fecha', 'datetime NULL '
GO

--REQ23317
EXEC spALTER_TABLE 'Layout_polizas', 'EsComplementaria', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

-- drop table polizas
if not exists (select * from sysobjects where id = object_id('dbo.polizas') and type = 'U') 
CREATE TABLE polizas (
	poliza_id				int				NOT NULL IDENTITY(1,1)	PRIMARY KEY,	
	log_id					int				NULL,	

	empresa					varchar(5)		NULL,	
	ejercicio				smallint		NULL,
	periodo					smallint		NULL,
	cuenta_contable			varchar(50)		NULL,	
	cargos					float			NULL,
	abonos					float			NULL,
)
GO

EXEC spALTER_TABLE 'Polizas', 'sucursal', 'varchar(10) not null default '''''
GO

--BUG22460
EXEC spALTER_TABLE 'Polizas', 'fecha', 'datetime NULL'
GO

/****** MFAIEPSNumReporte ******/
if not exists(select * from SysTabla where SysTabla = 'MFAIEPSNumReporte') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAIEPSNumReporte','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAIEPSNumReporte') and type = 'U') 
  CREATE TABLE dbo.MFAIEPSNumReporte (
    NumReporte			varchar(20)  NOT NULL,
	Descripcion			varchar(255) NOT NULL,
	
	CONSTRAINT priMFAIEPSNumReporte PRIMARY KEY CLUSTERED (NumReporte)
)
GO

IF NOT EXISTS(SELECT 1 FROM MFAIEPSNumReporte)
BEGIN
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2000', 'IEPS por alcohol y mieles incristalizables')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2010', 'IEPS por servicios de comisión, mediación, agencia, representación, correduría, consignación.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2020', 'IEPS por juegos y apuestas.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2030', 'IEPS por redes y telecomunicaciones.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2040', 'IEPS por bebidas energetizantes.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2050', 'Determinación de IEPS por la enajenación de tabacos labrados.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2060', 'IEPS bebidas alcoholicas.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2070', 'IEPS por cerveza.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2080', 'R27 IEPS por bebidas refrescantes.')
	INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('2090', 'Gasolina y diesel.')	
END
GO

--BUG22118
IF NOT EXISTS(SELECT * FROM MFAIEPSNumReporte WHERE NumReporte = '3000')
  INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('3000', 'IEPS por bebidas saborizadas')
IF NOT EXISTS(SELECT * FROM MFAIEPSNumReporte WHERE NumReporte = '3010')
  INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('3010', 'IEPS por plaguicidas')
IF NOT EXISTS(SELECT * FROM MFAIEPSNumReporte WHERE NumReporte = '3020')
  INSERT MFAIEPSNumReporte (NumReporte, Descripcion) VALUES ('3020', 'IEPS por alimentos no básicos con alta densidad calórica')  
GO  

/****** MFAIEPSCategoriaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'MFAIEPSCategoriaConcepto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAIEPSCategoriaConcepto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAIEPSCategoriaConcepto') and type = 'U') 
  CREATE TABLE dbo.MFAIEPSCategoriaConcepto (
    Categoria			varchar(20)  NOT NULL,
	Descripcion			varchar(255) NOT NULL,
	
	CONSTRAINT priMFAIEPSCategoriaConcepto PRIMARY KEY CLUSTERED (Categoria)
)
GO

IF NOT EXISTS(SELECT 1 FROM MFAIEPSCategoriaConcepto)
BEGIN
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('01', 'Magna')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('02', 'Premium')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('03', 'Diesel')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('04', 'Diesel industrial bajo azufre')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('05', 'Diesel marino especial')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('06', 'Cigarros')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('07', 'Tabacos labrados')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('08', 'Tabacos labrados hecho puramente a mano')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('09', 'Bebidas con contenido alcohólico de hasta 14')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('10', 'Bebidas con contenido alcohólico de 14% hasta 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('11', 'Bebidas con contenido alcohólico de mas de 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('12', 'Cerveza de hasta 14')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('13', 'Cerveza de 14% hasta 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('14', 'Cerveza de mas de 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('15', 'Bebidas refrescantes de hasta 14')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('16', 'Bebidas refrescantes de 14% hasta 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('17', 'Bebidas refrescantes de mas de 20%')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('18', 'Redes de telecomunicaciones')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('19', 'Telefonía pública rural')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('20', 'Servicios de internet')
	INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('21', 'General')	
END
GO
--BUG22233
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '22')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('22', 'Cerveza en envases no reutilizable') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '23')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('23', 'Cerveza en envase reutilizable') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '24')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('24', 'Plaguicidas categoría 1') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '25')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('25', 'Plaguicidas categoría 2') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '26')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('26', 'Plaguicidas categoría 3') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '27')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('27', 'Plaguicidas categoría 4') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '28')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('28', 'Plaguicidas categoría 5') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '29')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('29', 'Botanas') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '30')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('30', 'Productos de confitería') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '31')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('31', 'Chocolate y productos derivados del cacao')
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '32')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('32', 'Flanes y pudines') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '33')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('33', 'Dulces de frutas y hortalizas') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '34')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('34', 'Cremas de cacahuate y avellanas') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '35')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('35', 'Dulces de leche') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '36')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('36', 'Alimentos a base de cereal') 
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '37')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('37', 'Helados, paletas y nieves') 

--BUG23510
IF NOT EXISTS(SELECT * FROM MFAIEPSCategoriaConcepto WHERE Categoria = '38')
  INSERT MFAIEPSCategoriaConcepto (Categoria, Descripcion) VALUES ('38', 'Concentrados, Polvos y Jarabes para preparar bebidas saborizadas')   
GO

--REQ16520
/****** MFAIETUSubTipoConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'MFAIETUSubTipoConcepto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAIETUSubTipoConcepto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAIETUSubTipoConcepto') and type = 'U') 
  CREATE TABLE dbo.MFAIETUSubTipoConcepto (
    Concepto				varchar(50),
    TipoAplicacion			varchar(50),
    SubTipo					int,
    CONSTRAINT priMFAIETUSubTipoConcepto PRIMARY KEY CLUSTERED(Concepto, TipoAplicacion)
    )
GO


if exists (select * from sysobjects where id = object_id('dbo.MFAGastoPendientePreCalc') and type = 'V') drop view dbo.MFAGastoPendientePreCalc
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoPendienteCalc') and type = 'V') drop view dbo.MFAGastoPendienteCalc
GO

/****** MFAArt ******/
if not exists(select * from SysTabla where SysTabla = 'MFAArt') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAArt','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAArt') and type = 'U') 
  CREATE TABLE dbo.MFAArt (
    Articulo						varchar(20) NOT NULL,
    IEPSNumReporte					varchar(20) NOT NULL,
    IEPSCategoriaConcepto			varchar(20) NULL,
	IEPSExento						bit NULL DEFAULT 0,
	IEPSEnvaseReutilizable			bit NULL DEFAULT 0,	
	CONSTRAINT priMFAArt PRIMARY KEY CLUSTERED (Articulo)
)
GO

--BUG23510
EXEC spALTER_TABLE 'MFAArt', 'Impuesto', 'varchar(10) NOT NULL DEFAULT ''Impuesto 2'' WITH VALUES'
GO
EXEC spALTER_TABLE 'MFAArt', 'UnidadBaseIEPS', 'varchar(50) NULL'
GO


/****** MFAConceptoGas ******/
if not exists(select * from SysTabla where SysTabla = 'MFAConceptoGas') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAConceptoGas','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAConceptoGas') and type = 'U') 
  CREATE TABLE dbo.MFAConceptoGas (
    ConceptoGas						varchar(50) NOT NULL,
    IEPSNumReporte					varchar(20) NOT NULL,
    IEPSCategoriaConcepto			varchar(20) NULL,
	IEPSExento						bit NULL DEFAULT 0,
	IEPSEnvaseReutilizable			bit NULL DEFAULT 0,	
	CONSTRAINT priMFAConceptoGas PRIMARY KEY CLUSTERED (ConceptoGas)
)
GO

/****** MovTipoMFADocExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFADocExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFADocExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFADocExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFADocExcepcion (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	
	CONSTRAINT priMovTipoMFADocExcepcion PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

--BUG26056
/****** MovTipoMFACostoVenta ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFACostoVenta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFACostoVenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFACostoVenta') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFACostoVenta (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	
	CONSTRAINT priMovTipoMFACostoVenta PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

--BUG18278
/****** MovTipoMFACompDocExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFACompDocExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFACompDocExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFACompDocExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFACompDocExcepcion (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	
	CONSTRAINT priMovTipoMFACompDocExcepcion PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

/****** MFAMovSubTipoDocumentoExcepcionArt ******/
if not exists(select * from SysTabla where SysTabla = 'MFAMovSubTipoDocumentoExcepcionArt') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAMovSubTipoDocumentoExcepcionArt','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAMovSubTipoDocumentoExcepcionArt') and type = 'U') 
  CREATE TABLE dbo.MFAMovSubTipoDocumentoExcepcionArt (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
	Articulo			varchar(50) NULL,
	SubTipoDocumento	varchar(50) NULL,
	
	CONSTRAINT priMFAMovSubTipoDocumentoExcepcionArt PRIMARY KEY CLUSTERED (RID)
)
GO

/****** MFAMovSubTipoDocumentoExcepcionGas ******/
if not exists(select * from SysTabla where SysTabla = 'MFAMovSubTipoDocumentoExcepcionGas') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAMovSubTipoDocumentoExcepcionGas','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAMovSubTipoDocumentoExcepcionGas') and type = 'U') 
  CREATE TABLE dbo.MFAMovSubTipoDocumentoExcepcionGas (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
	ConceptoGas			varchar(20) NULL,
	SubTipoDocumento	varchar(50) NULL,
	
	CONSTRAINT priMFAMovSubTipoDocumentoExcepcionGas PRIMARY KEY CLUSTERED (RID)
)
GO

/****** MovTipoMFAAplicaExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAAplicaExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAAplicaExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAAplicaExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAAplicaExcepcion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFAAplicaExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spAlter_Table 'MovTipoMFAAplicaExcepcion', 'OrigenTipo', 'varchar(5) NULL'
EXEC spAlter_Table 'MovTipoMFAAplicaExcepcion', 'Origen', 'varchar(20) NULL'
--BUG22207
EXEC spDROP_PK 'MovTipoMFAAplicaExcepcion'
EXEC spAlter_Table 'MovTipoMFAAplicaExcepcion', 'RID', 'int identity(1,1) NOT NULL'
EXEC spADD_PK 'MovTipoMFAAplicaExcepcion', 'RID'
GO

--BUG16464
/****** MovTipoMFAEndosoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAEndosoExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAEndosoExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAEndosoExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAEndosoExcepcion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFAEndosoExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spAlter_Table 'MovTipoMFAEndosoExcepcion', 'OrigenTipo', 'varchar(5) NULL'
EXEC spAlter_Table 'MovTipoMFAEndosoExcepcion', 'Origen', 'varchar(20) NULL'
GO

/****** MovTipoMFADocAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFADocAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFADocAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFADocAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFADocAdicion (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	DocumentoTipo		varchar(50) NOT NULL,
	
	CONSTRAINT priMovTipoMFADocAdicion PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

--BUG18599
/****** MovTipoMFADocConciliado ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFADocConciliado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFADocConciliado','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFADocConciliado') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFADocConciliado(
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	
	CONSTRAINT priMovTipoMFADocConciliado PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

--BUG18278
/****** MovTipoMFACompDocAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFACompDocAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFACompDocAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFACompDocAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFACompDocAdicion (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
	DocumentoTipo		varchar(50) NOT NULL,
	
	CONSTRAINT priMovTipoMFACompDocAdicion PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

/*
INSERT MovTipoMFADocAdicion (Modulo, Mov, DocumentoTipo) VALUES ('CXC', 'ANTICIPO ADUANAL', 'factura')
*/
--drop table MovTipoMFAAplicaAdicion
/****** MovTipoMFAAplicaAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAAplicaAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAAplicaAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAAplicaAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAAplicaAdicion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFAAplicaAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'MovTipoMFAAplicaAdicion', 'RID', 'int identity(1,1) NOT NULL'
GO
--BUG18767
EXEC spALTER_TABLE 'MovTipoMFAAplicaAdicion', 'tipo_documento', 'varchar(50)		NULL'
GO

/****** MovTipoMFACobroAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFACobroAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFACobroAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFACobroAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFACobroAdicion (
    RID					int identity(1,1) NOT NULL,    
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFACobroAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'MovTipoMFACobroAdicion', 'RID', 'int identity(1,1) NOT NULL'
GO
--BUG18767
EXEC spALTER_TABLE 'MovTipoMFACobroAdicion', 'tipo_documento', 'varchar(50)		NULL'
GO

/****** MovTipoMFAPagoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAPagoAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAPagoAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAPagoAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAPagoAdicion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFAPagoAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'MovTipoMFAPagoAdicion', 'RID', 'int identity(1,1) NOT NULL'
GO
--BUG18767
EXEC spALTER_TABLE 'MovTipoMFAPagoAdicion', 'tipo_documento', 'varchar(50)		NULL'
GO

/****** MovTipoMFARedocAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFARedocAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFARedocAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFARedocAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFARedocAdicion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL
	--CONSTRAINT priMovTipoMFARedocAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'MovTipoMFARedocAdicion', 'RID', 'int identity(1,1) NOT NULL'
GO
--BUG18767
EXEC spALTER_TABLE 'MovTipoMFARedocAdicion', 'tipo_documento', 'varchar(50)		NULL'
GO

/****** MovTipoMFAEndosoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAEndosoAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAEndosoAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAEndosoAdicion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAEndosoAdicion (
    RID					int identity(1,1) NOT NULL,          
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	CONSTRAINT priMovTipoMFAEndosoAdicion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spALTER_TABLE 'MovTipoMFAEndosoAdicion', 'RID', 'int identity(1,1) NOT NULL'
GO
--BUG18767
EXEC spALTER_TABLE 'MovTipoMFAEndosoAdicion', 'tipo_documento', 'varchar(50) NULL'
GO

/****** MovTipoMFAAplicacionCambio ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAAplicacionCambio') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAAplicacionCambio','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAAplicacionCambio') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAAplicacionCambio (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
    OrigenTipo			varchar(5)  NOT NULL DEFAULT '',	
    Origen				varchar(20) NOT NULL DEFAULT '',
    TipoAplicacion		varchar(50) NULL,
	CONSTRAINT priMovTipoMFAAplicacionCambio PRIMARY KEY CLUSTERED (Modulo, Mov, OrigenTipo, Origen)
)
GO

--BUG16247
/****** MovTipoMFAAplicaReporteExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAAplicaReporteExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAAplicaReporteExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAAplicaReporteExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAAplicaReporteExcepcion (
    Modulo				varchar(5)  NOT NULL,
	Mov					varchar(20) NOT NULL,
    OrigenTipo			varchar(5)  NOT NULL DEFAULT '',	
    Origen				varchar(20) NOT NULL DEFAULT '',
    AplicaIetu			varchar(2)  NOT NULL DEFAULT 'Si',
    AplicaIeps			varchar(2)  NOT NULL DEFAULT 'Si',   
	CONSTRAINT priMovTipoMFAAplicaIetuExcepcion PRIMARY KEY CLUSTERED (Modulo, Mov, OrigenTipo, Origen)
)
GO

EXEC spALTER_TABLE 'MovTipoMFAAplicaReporteExcepcion', 'AplicaIVA', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--BUG20353
/****** MovTipoMFAConceptoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFAConceptoExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFAConceptoExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFAConceptoExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFAConceptoExcepcion(
    Concepto			varchar(50) NOT NULL,
    AplicaIetu			varchar(2)  NOT NULL DEFAULT 'Si',
    AplicaIeps			varchar(2)  NOT NULL DEFAULT 'Si',   
    AplicaIVA			varchar(2)  NOT NULL DEFAULT 'Si',       
	CONSTRAINT priMovTipoMFAConceptoExcepcion PRIMARY KEY CLUSTERED (Concepto)
)
GO

/****** MFAMovExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MFAMovExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAMovExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAMovExcepcion') and type = 'U') 
  CREATE TABLE dbo.MFAMovExcepcion (
    Modulo					varchar(5)  NOT NULL,
	ModuloID				varchar(20) NOT NULL,
	
	CONSTRAINT priMFAMovExcepcion PRIMARY KEY CLUSTERED (Modulo, ModuloID)
)
GO

--BUG19036
/****** MFAContAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MFAContAdicion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAContAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAContAdicion') and type = 'U') 
  CREATE TABLE dbo.MFAContAdicion (
	ModuloID				varchar(20) NOT NULL,
	CONSTRAINT priMFAContAdicion PRIMARY KEY CLUSTERED (ModuloID)
)
GO

--BUG20109
/****** MFAContOrigenAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MFAContOrigenAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAContOrigenAdicion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAContOrigenAdicion') and type = 'U') 
  CREATE TABLE dbo.MFAContOrigenAdicion(
    OrigenTipo			varchar(5)  NOT NULL,
    Origen				varchar(20)	NOT NULL,
	Mov					varchar(20) NOT NULL,
	CONSTRAINT priMFAContOrigenAdicion PRIMARY KEY CLUSTERED (OrigenTipo, Origen, Mov)
)
GO

/****** MovTipoMFACobroPagoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFACobroPagoExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFACobroPagoExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFACobroPagoExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFACobroPagoExcepcion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	
	CONSTRAINT priMovTipoMFACobroPagoExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spAlter_Table 'MovTipoMFACobroPagoExcepcion', 'OrigenTipo', 'varchar(5) NULL'
EXEC spAlter_Table 'MovTipoMFACobroPagoExcepcion', 'Origen', 'varchar(20) NULL'
--BUG22207
EXEC spDROP_PK 'MovTipoMFACobroPagoExcepcion'
EXEC spAlter_Table 'MovTipoMFACobroPagoExcepcion', 'RID', 'int identity(1,1) NOT NULL'
EXEC spADD_PK 'MovTipoMFACobroPagoExcepcion', 'RID'
GO

/****** MovTipoMFARedocExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoMFARedocExcepcion') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoMFARedocExcepcion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoMFARedocExcepcion') and type = 'U') 
  CREATE TABLE dbo.MovTipoMFARedocExcepcion (
    RID					int identity(1,1) NOT NULL,
    Modulo				varchar(5)  NULL,
	Mov					varchar(20) NULL,
    OrigenTipo			varchar(5)  NULL,	
    Origen				varchar(20) NULL,
	
	CONSTRAINT priMovTipoMFARedocExcepcion PRIMARY KEY CLUSTERED (RID)
)
GO

EXEC spAlter_Table 'MovTipoMFARedocExcepcion', 'OrigenTipo', 'varchar(5) NULL'
EXEC spAlter_Table 'MovTipoMFARedocExcepcion', 'Origen', 'varchar(20) NULL'
--BUG22207
EXEC spDROP_PK 'MovTipoMFARedocExcepcion'
EXEC spAlter_Table 'MovTipoMFARedocExcepcion', 'RID', 'int identity(1,1) NOT NULL'
EXEC spADD_PK 'MovTipoMFARedocExcepcion', 'RID'
GO

/****** MFAIFRSUsuario ******/
if not exists(select * from SysTabla where SysTabla = 'MFAIFRSUsuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAIFRSUsuario','maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFAIFRSUsuario') and type = 'U') 
CREATE TABLE dbo.MFAIFRSUsuario(
  Usuario			varchar(10),
  CONSTRAINT priMFAIFRSUsuario PRIMARY KEY CLUSTERED(Usuario)
  )
GO

/****** EmpresaMFA ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaMFA') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaMFA','EmpresaMFA')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaMFA') and type = 'U') 
  CREATE TABLE dbo.EmpresaMFA (
	Empresa				varchar(5) NOT NULL,

	Impuesto2				varchar(10) NULL DEFAULT 'ninguno',	
	EjercicioInicial		int NULL,
	PeriodoInicial			int NULL,
	CobrosConciliados		bit NULL DEFAULT 1,
	PagosConciliados		bit NULL DEFAULT 1,
	TasaImpuesto1Omision	float NULL DEFAULT 0.0,
	UnidadGramo				varchar(10) NULL,
	[Version]				integer NULL,
	
	CONSTRAINT priEmpresaMFA PRIMARY KEY CLUSTERED (Empresa)
)
GO

EXEC spAlter_Table 'EmpresaMFA', 'EjercicioInicial', 'int NULL DEFAULT 0'
EXEC spAlter_Table 'EmpresaMFA', 'PeriodoInicial', 'int NULL DEFAULT 0'
EXEC spAlter_Table 'EmpresaMFA', 'TasaImpuesto1Omision', 'float NULL DEFAULT 0.0'
EXEC spAlter_Table 'EmpresaMFA', 'UnidadGramo', 'varchar(10) NULL'
EXEC spAlter_Table 'EmpresaMFA', 'Version', 'integer NULL'
GO

--REQ16670
EXEC spAlter_Table 'EmpresaMFA', 'AnticiposPagadosPeriodo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--REQ16711
EXEC spAlter_Table 'EmpresaMFA', 'IncluirNomina', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ16899
EXEC spAlter_Table 'EmpresaMFA', 'CxpAnticiposPagadosPeriodo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--REQ16901
EXEC spAlter_Table 'EmpresaMFA', 'COMSCalcularBaseImportacion', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG17507
EXEC SPALTER_TABLE 'EmpresaMFA', 'IFRS', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirPolizasTesoreria', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG18013
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirNotasAnteriores', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG18077
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirPolizasNomina', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG18278
EXEC SPALTER_TABLE 'EmpresaMFA', 'GASComprobantesPorConcepto', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG18599
EXEC SPALTER_TABLE 'EmpresaMFA', 'DINDepositosAnticipados', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaMFA', 'DINCteDepositosAnticipados', 'varchar(10) NULL'
EXEC SPALTER_TABLE 'EmpresaMFA', 'DINImpuesto1', 'float NULL'
GO

--BUG19036
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirPolizasEspecificas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG19776
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirCuentasEspecificas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG22460
EXEC SPALTER_TABLE 'EmpresaMFA', 'ImportarRangoFechas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG22544
EXEC SPALTER_TABLE 'EmpresaMFA', 'ImportarFacturasContado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG22575
EXEC SPALTER_TABLE 'EmpresaMFA', 'ValidarReferencias', 'bit NOT NULL DEFAULT 1 WITH VALUES'
GO

--BUG22575
EXEC SPALTER_TABLE 'EmpresaMFA', 'ExportarSIA', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG23996
EXEC SPALTER_TABLE 'EmpresaMFA', 'CxcChequesDevueltosNegativo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaMFA', 'CxpChequesDevueltosNegativo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG24040
EXEC SPALTER_TABLE 'EmpresaMFA', 'COMSIVAImportacionAnticipado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG24598
EXEC SPALTER_TABLE 'EmpresaMFA', 'SIABaseIndependiente', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaMFA', 'SIABaseDatos', 'varchar(255) NULL'
GO

--BUG24733
EXEC SPALTER_TABLE 'EmpresaMFA', 'GASPorcentajeDeducible', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--BUG23510
EXEC spDROP_COLUMN 'EmpresaMFA', 'UnidadGramo'
GO

--BUG24895
EXEC SPALTER_TABLE 'EmpresaMFA', 'IncluirNotas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaMFA', 'FuncionTesoreria', 'bit NULL DEFAULT 0 WITH VALUES'
GO
/****** MFACuentasEspeciales ******/
if not exists(select * from SysTabla where SysTabla = 'MFACuentasEspeciales') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFACuentasEspeciales','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFACuentasEspeciales') and type = 'U') 
  CREATE TABLE MFACuentasEspeciales(
	Cuenta		varchar(20) NOT NULL,
	CONSTRAINT priMFACuentasEspeciales PRIMARY KEY CLUSTERED(Cuenta)
)
GO

/*
DELETE FROM EmpresaMFA 
INSERT EmpresaMFA (Empresa, EjercicioInicial, PeriodoInicial, Impuesto2, TasaImpuesto1Omision, Version)
           SELECT  Empresa, 2012,             1,              'ieps',    16.0,                 2
             FROM Empresa
*/

/****** MFATipoCta ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoCta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoCta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoCta') and type = 'U') 
  CREATE TABLE dbo.MFATipoCta (
        Cuenta					varchar(50) NOT NULL,
        Tipo					varchar(50) NOT NULL, --entidad, concepto, retencion_isr, iva, retencion_iva, ieps, isan, otros_impuestos
        SubTipo					varchar(50) NULL,
        Longitud				int NULL,

	CONSTRAINT priMFATipoCta PRIMARY KEY CLUSTERED (Cuenta)
)
GO

/*
--SELECT * FROM CTA WHERE DESCRIPCION LIKE '%inventario%'
DELETE FROM MFATipoCta
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('118',     'entidad',       'cliente',              3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('130',     'iva',           '',                     3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('132',     'iva',           '',                     3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('230-120', 'iva',           '',                     7)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('230-170', 'retencion_iva', '',                     7)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('639-104', 'retencion_iva', '',                     7)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('200',     'entidad',       'proveedor',            3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('800',     'entidad',       'proveedor extranjero', 3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('136',     'entidad',       'anticipo a proveedor', 3)
INSERT MFATipoCta (Cuenta, Tipo, SubTipo, Longitud) VALUES ('135',     'concepto',      '',                     3)
*/

/****** MFATipoCta ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoCta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoCta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoCta') and type = 'U') 
  CREATE TABLE dbo.MFATipoCta (
  
        Cuenta					varchar(50) NOT NULL,
        Tipo					varchar(50) NOT NULL, --entidad, concepto, retencion_isr, iva, retencion_iva, ieps, isan, otros_impuestos
        SubTipo					varchar(50) NULL,
        Longitud				int NULL,

	CONSTRAINT priMFATipoCta PRIMARY KEY CLUSTERED (Cuenta)
)
GO

--BUG16116
EXEC spALTER_COLUMN 'DatosIEPS', 'Tipo_Movimiento', 'varchar(50) NULL'
--BUG16117
EXEC spALTER_COLUMN 'DatosIEPS', 'Categoria_Concepto', 'varchar(20) NULL'
GO

EXEC spDROP_INDEX 'DatosIETU', 'Init'
go
EXEC spALTER_COLUMN 'DatosIETU', 'ejercicio', 'float NOT NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'periodoasi', 'float NOT NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'ietu', 'float NOT NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'tipo', 'float NOT NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'retencion', 'float NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'retencion2', 'float NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'impuestos', 'float NOT NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'nocliente', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'DatosIETU', 'nombre', 'varchar(150) NULL'

EXEC spALTER_COLUMN 'DatosIETU', 'concepto', 'varchar(200) NULL'
GO

EXEC spDROP_INDEX 'ximpiva', 'Init'
go
EXEC spALTER_COLUMN 'ximpiva', 'ejercicio', 'float NULL'
EXEC spALTER_COLUMN 'ximpiva', 'periodo', 'float NULL'
EXEC spALTER_COLUMN 'ximpiva', 'tipoiva', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'tipoopera', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'importe', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'tasa', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'iva', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'origen', 'float NOT NULL'
EXEC spALTER_COLUMN 'ximpiva', 'reten2', 'float NULL'
EXEC spALTER_COLUMN 'ximpiva', 'mov', 'varchar(200) NULL'
go

--BUG16136
EXEC spALTER_COLUMN 'DatosIEPS', 'Nocliente', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'DatosIEPS', 'Nombre', 'varchar(150) NULL'
EXEC spALTER_COLUMN 'DatosIEPS', 'Rfc', 'varchar(15) NULL'
EXEC spALTER_COLUMN 'ximpiva', 'tipoter', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ximpiva', 'tipoope', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ximpiva', 'nombre', 'varchar(150) NULL'
EXEC spALTER_COLUMN 'DatosIeps', 'Documento_Id', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'DatosIeps', 'Concepto', 'varchar(200) NULL'
EXEC spALTER_COLUMN 'DatosIeps', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'DatosIeps', 'Unidad1', 'varchar(50) NULL'
GO

EXEC spALTER_TABLE 'MovContables', 'fecha', 'datetime NULL'
GO

/****** layout_documentos_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'layout_documentos_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('layout_documentos_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.layout_documentos_cuenta') and type = 'U') 
  CREATE TABLE dbo.layout_documentos_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	cuenta_contable				varchar(50),
	debe						float,
	haber						float,
		
	CONSTRAINT pri_layout_documentos_cuenta PRIMARY KEY CLUSTERED (cuenta_contable, origen_id, origen_modulo, empresa)
)
GO

--BUG18077
EXEC spALTER_TABLE 'layout_documentos_cuenta', 'Ejercicio', 'int NULL'
EXEC spALTER_TABLE 'layout_documentos_cuenta', 'Periodo', 'int NULL'
GO

--BUG19259
TRUNCATE TABLE layout_documentos_cuenta
GO
EXEC spDROP_PK 'layout_documentos_cuenta'
EXEC spDROP_COLUMN 'layout_documentos_cuenta', 'Ejercicio'
EXEC spDROP_COLUMN 'layout_documentos_cuenta', 'Periodo'
EXEC spALTER_TABLE 'layout_documentos_cuenta', 'Ejercicio', 'int NOT NULL'
EXEC spALTER_TABLE 'layout_documentos_cuenta', 'Periodo', 'int NOT NULL'
EXEC spADD_PK 'layout_documentos_cuenta', 'cuenta_contable, origen_id, origen_modulo, empresa, ejercicio, periodo'
GO

--BUG22370
EXEC spALTER_TABLE 'layout_documentos_cuenta', 'ContID', 'int NOT NULL'
GO

/****** temp_layout_documentos_cuenta ******/
/*
if not exists(select * from SysTabla where SysTabla = 'temp_layout_documentos_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp_layout_documentos_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp_layout_documentos_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp_layout_documentos_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	cuenta_contable				varchar(50),
	debe						float,
	haber						float,
	
	CONSTRAINT pri_temp_layout_documentos_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa, cuenta_contable)
)
*/

/****** temp2_layout_documentos_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'temp2_layout_documentos_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp2_layout_documentos_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp2_layout_documentos_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp2_layout_documentos_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	
	CONSTRAINT pri_temp2_layout_documentos_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa)
)
GO

/****** temp3_layout_documentos_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'temp3_layout_documentos_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp3_layout_documentos_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp3_layout_documentos_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp3_layout_documentos_cuenta (
  
    empresa						varchar(5) NOT NULL,
	origen_modulo				varchar(50) NOT NULL,
	origen_id					varchar(50) NOT NULL,
	mov							varchar(20) NULL,
	mov_id						varchar(20) NULL,
	poliza						varchar(20) NULL,
	poliza_id					varchar(20) NULL,
	
	CONSTRAINT pri_temp3_layout_documentos_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa)
)
GO

/****** layout_aplicaciones_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'layout_aplicaciones_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('layout_aplicaciones_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.layout_aplicaciones_cuenta') and type = 'U') 
  CREATE TABLE dbo.layout_aplicaciones_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	cuenta_contable				varchar(50),
	debe						float,
	haber						float,
		
	CONSTRAINT pri_layout_aplicaciones_cuenta PRIMARY KEY CLUSTERED (cuenta_contable, origen_id, origen_modulo, empresa)
)
GO

--BUG18077
EXEC spALTER_TABLE 'layout_aplicaciones_cuenta', 'Ejercicio', 'int NULL'
EXEC spALTER_TABLE 'layout_aplicaciones_cuenta', 'Periodo', 'int NULL'

--BUG19259
TRUNCATE TABLE layout_aplicaciones_cuenta
GO
EXEC spDROP_PK 'layout_aplicaciones_cuenta'
EXEC spDROP_COLUMN 'layout_aplicaciones_cuenta', 'Ejercicio'
EXEC spDROP_COLUMN 'layout_aplicaciones_cuenta', 'Periodo'
EXEC spALTER_TABLE 'layout_aplicaciones_cuenta', 'Ejercicio', 'int NOT NULL'
EXEC spALTER_TABLE 'layout_aplicaciones_cuenta', 'Periodo', 'int NOT NULL'
EXEC spADD_PK 'layout_aplicaciones_cuenta', 'cuenta_contable, origen_id, origen_modulo, empresa, ejercicio, periodo'
GO

--BUG22370
EXEC spALTER_TABLE 'layout_aplicaciones_cuenta', 'ContID', 'int NOT NULL'
GO

/****** temp_layout_aplicaciones_cuenta ******/
/*
if not exists(select * from SysTabla where SysTabla = 'temp_layout_aplicaciones_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp_layout_aplicaciones_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp_layout_aplicaciones_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp_layout_aplicaciones_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	cuenta_contable				varchar(50),
	debe						float,
	haber						float,
	
	CONSTRAINT pri_temp_layout_aplicaciones_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa, cuenta_contable)
)
*/

/****** temp2_layout_aplicaciones_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'temp2_layout_aplicaciones_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp2_layout_aplicaciones_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp2_layout_aplicaciones_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp2_layout_aplicaciones_cuenta (
  
    empresa						varchar(5),
	origen_modulo				varchar(50),
	origen_id					varchar(50),
	
	CONSTRAINT pri_temp2_layout_aplicaciones_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa)
)
GO

/****** temp3_layout_aplicaciones_cuenta ******/
if not exists(select * from SysTabla where SysTabla = 'temp3_layout_aplicaciones_cuenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('temp3_layout_aplicaciones_cuenta','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.temp3_layout_aplicaciones_cuenta') and type = 'U') 
  CREATE TABLE dbo.temp3_layout_aplicaciones_cuenta (
  
    empresa						varchar(5) NOT NULL,
	origen_modulo				varchar(50) NOT NULL,
	origen_id					varchar(50) NOT NULL,
	mov							varchar(20) NULL,
	mov_id						varchar(20) NULL,
	poliza						varchar(20) NULL,
	poliza_id					varchar(20) NULL,
	
	CONSTRAINT pri_temp3_layout_aplicaciones_cuenta PRIMARY KEY CLUSTERED (origen_id, origen_modulo, empresa)
)
GO

/****** MFATipoCtaEntidad ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoCtaEntidad') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoCtaEntidad','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoCtaEntidad') and type = 'U') 
  CREATE TABLE dbo.MFATipoCtaEntidad (
  
        Modulo					varchar(10)  NOT NULL,
        Mov						varchar(20) NOT NULL,
        Categoria				varchar(50) NOT NULL,
        Grupo					varchar(50) NOT NULL,
        Familia					varchar(50) NOT NULL,
        Entidad					varchar(10) NOT NULL,
        EntidadTipo				varchar(20) NOT NULL,
        Cuenta					varchar(20) NULL

	CONSTRAINT priMFATipoCtaEntidad PRIMARY KEY CLUSTERED (Modulo, Mov, Categoria, Grupo, Familia, Entidad, EntidadTipo)
)
GO

/****** MFATipoCtaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoCtaConcepto') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoCtaConcepto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoCtaConcepto') and type = 'U') 
  CREATE TABLE dbo.MFATipoCtaConcepto (
  
        Modulo					varchar(10)  NOT NULL,
        Mov						varchar(20) NOT NULL,
        Categoria				varchar(50) NOT NULL,
        Grupo					varchar(50) NOT NULL,
        Familia					varchar(50) NOT NULL,
        Concepto				varchar(50) NOT NULL,
        ConceptoTipo			varchar(20) NOT NULL,
        Cuenta					varchar(20) NULL

	CONSTRAINT priMFATipoCtaConcepto PRIMARY KEY CLUSTERED (Modulo, Mov, Categoria, Grupo, Familia, Concepto, ConceptoTipo)
)
GO

--select grupo, familia, categoria from art
--drop table mfatipoctaimpuesto
/****** MFATipoCtaImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoCtaImpuesto') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoCtaImpuesto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoCtaImpuesto') and type = 'U') 
  CREATE TABLE dbo.MFATipoCtaImpuesto (
  
        Modulo					varchar(10)  NOT NULL,
        Mov						varchar(20) NOT NULL,
        Minimo					float NOT NULL,
        Maximo					float NOT NULL,
        ImpuestoTipo			varchar(20) NOT NULL, --ISR, Retencion ISR, IVA, Retencion IVA, IEPS, ISAN, Otros
        Cuenta					varchar(20) NULL

	CONSTRAINT priMFATipoCtaImpuesto PRIMARY KEY CLUSTERED (Modulo, Mov, Minimo, Maximo, ImpuestoTipo)
)
GO

/****** MFAPolizaEntidad ******/
if not exists(select * from SysTabla where SysTabla = 'MFAPolizaEntidad') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAPolizaEntidad','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAPolizaEntidad') and type = 'U') 
  CREATE TABLE dbo.MFAPolizaEntidad (
    ID					int identity(1,1) NOT NULL,
    Empresa				varchar(5)  NULL,
    Poliza				varchar(20) NULL,
    PolizaID            varchar(20) NULL,
    Modulo				varchar(5)  NULL,
    ModuloID			int NULL,
	Mov					varchar(20) NULL,
	Categoria			varchar(50) NULL,
	Familia				varchar(50) NULL,
	Grupo				varchar(50) NULL,
	EntidadTipo			varchar(20) NULL,
	Entidad				varchar(10) NULL,
	Cuenta              varchar(20) NULL,
	
	CONSTRAINT priMFAPolizaEntidad PRIMARY KEY CLUSTERED (ID)
)
GO

/****** MFAPolizaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'MFAPolizaConcepto') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAPolizaConcepto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAPolizaConcepto') and type = 'U') 
  CREATE TABLE dbo.MFAPolizaConcepto (
    ID					int identity(1,1) NOT NULL,
    Empresa				varchar(5)  NULL,
    Poliza				varchar(20) NULL,
    PolizaID            varchar(20) NULL,
    Modulo				varchar(5)  NULL,
    ModuloID			int NULL,
	Mov					varchar(20) NULL,
	Categoria			varchar(50) NULL,
	Familia				varchar(50) NULL,
	Grupo				varchar(50) NULL,
	ConceptoTipo		varchar(20) NULL,
	Concepto			varchar(50) NULL,
	Cuenta              varchar(20) NULL,
	
	CONSTRAINT priMFAPolizaConcepto PRIMARY KEY CLUSTERED (ID)
)
GO

/****** MFAPolizaImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'MFAPolizaImpuesto') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAPolizaImpuesto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFAPolizaImpuesto') and type = 'U') 
  CREATE TABLE dbo.MFAPolizaImpuesto (
    ID					int identity(1,1) NOT NULL,
    Empresa				varchar(5)  NULL,
    Poliza				varchar(20) NULL,
    PolizaID            varchar(20) NULL,
    Modulo				varchar(5)  NULL,
    ModuloID			int NULL,
	Mov					varchar(20) NULL,
	ImpuestoTipo		varchar(20) NULL,
	ImpuestoTasa		float NULL,
	Cuenta              varchar(20) NULL,
	
	CONSTRAINT priMFAPolizaImpuesto PRIMARY KEY CLUSTERED (ID)
)
GO

/****** MFADocumentosIniciales ******/
if not exists(select * from SysTabla where SysTabla = 'MFADocumentosIniciales') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFADocumentosIniciales','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MFADocumentosIniciales') and type = 'U') 
  CREATE TABLE dbo.MFADocumentosIniciales (

		Descripcion				varchar(20) NOT NULL,

	CONSTRAINT priMFADocumentosIniciales PRIMARY KEY CLUSTERED (Descripcion)
)
GO

DELETE FROM MFADocumentosIniciales
GO
INSERT MFADocumentosIniciales (Descripcion) VALUES ('Saldo a favor')
INSERT MFADocumentosIniciales (Descripcion) VALUES ('Vales en Circulacion')
INSERT MFADocumentosIniciales (Descripcion) VALUES ('Consumos Pendientes')
INSERT MFADocumentosIniciales (Descripcion) VALUES ('Redondeo')
GO

/****** MFAPais ******/
if not exists(select * from SysTabla where SysTabla = 'MFAPais') --ARCCAMBIAR Quitar clave del pais y dejar el nombre en varchar(50)
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAPais','MFAPais')
if not exists (select * from sysobjects where id = object_id('dbo.MFAPais') and type = 'U') 
  CREATE TABLE dbo.MFAPais (
	Pais				varchar(50) NOT NULL,
	Nacionalidad		varchar(50) NULL,

	CONSTRAINT priMFAPais PRIMARY KEY CLUSTERED (Pais)
)
GO

IF NOT EXISTS(SELECT * FROM MFAPais)
BEGIN
  INSERT MFAPais (Pais, Nacionalidad) VALUES ('Mexico', 'Mexicano')
  INSERT MFAPais (Pais, Nacionalidad) VALUES ('Estados Unidos', 'Estadounidense')
  INSERT MFAPais (Pais, Nacionalidad) VALUES ('Canada', 'Canadiense')
END
GO

-- drop table MFALayoutPeriodo
if not exists (select * from sysobjects where id = object_id('dbo.MFALayoutPeriodo') and type = 'U') 
CREATE TABLE MFALayoutPeriodo (
    RID							int			NOT NULL,
	PeriodoID					varchar(36) NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),
	
	Ejercicio					int			NOT NULL,
	Periodo						int			NOT NULL,    

	CONSTRAINT priMFALayoutPeriodo PRIMARY KEY CLUSTERED (PeriodoID)
)
GO

--BUG17399
EXEC spDROP_COLUMN 'MFALayoutPeriodo', 'RID'
GO
EXEC spALTER_TABLE 'MFALayoutPeriodo', 'RID', 'int	IDENTITY'
GO

-- drop table MFALayoutDocumento
if not exists (select * from sysobjects where id = object_id('dbo.MFALayoutDocumento') and type = 'U') 
CREATE TABLE MFALayoutDocumento (
	PeriodoID				varchar(36)		NOT NULL,
    DocumentoID				varchar(36)		NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),
    
    RID						int				NOT NULL,
	origen_tipo				varchar(50)		NULL,		-- auto, manual
	empresa					varchar(5)		NULL,
	origen_modulo			varchar(5)		NULL,		-- ventas, compras, gastos	
	origen_id				varchar(50)		NULL,
	emisor					varchar(50)		NULL,		-- empresa, terceros
	tipo_documento			varchar(50)		NULL,		-- factura, nota_cargo, nota_credito, anticipo
	subtipo_documento		varchar(50)		NULL,       --adquisicion, enajenacion, importacion, premio, prestacion_servicios, pago_federacion, participacion_federal, impuesto_estatal
	folio					varchar(50)		NULL,	
	fecha					datetime		NULL,
	entidad_clave			varchar(20)		NULL,
	agente_clave			varchar(20)		NULL,
	
	CONSTRAINT priMFALayoutDocumento PRIMARY KEY CLUSTERED (DocumentoID, PeriodoID)
)
GO

EXEC spALTER_TABLE 'MFALayoutDocumento', 'subtipo_documento', 'varchar(50) NULL' -- ABC
GO

--BUG17399
EXEC spDROP_COLUMN 'MFALayoutDocumento', 'RID'
GO
EXEC spALTER_TABLE 'MFALayoutDocumento', 'RID', 'int	IDENTITY'
GO

-- drop table MFALayoutDocumentoD
if not exists (select * from sysobjects where id = object_id('dbo.MFALayoutDocumentoD') and type = 'U') 
CREATE TABLE MFALayoutDocumentoD (
    DocumentoID					varchar(36)		NOT NULL,
    RID							varchar(36)		NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),
    
	concepto					varchar(200)	NULL,
	acumulable_deducible		varchar(50)		NULL,		-- si, no, viaticos, intereses, activos
	importe						float			NULL,
	retencion_isr				float			NULL,
	retencion_iva				float			NULL,
	base_iva					float			NULL,
	iva_excento					bit				NULL	DEFAULT 0,
	iva_tasa					float			NULL,
	iva							float			NULL,
	base_ieps					float			NULL,
	ieps_tasa					float			NULL,
	ieps						float			NULL,
	base_isan					float			NULL,
	isan						float			NULL,
	importe_total				float			NULL,
	ieps_num_reporte			varchar(20)		NULL,
	ieps_categoria_concepto		varchar(20)		NULL,
	ieps_exento					bit				NULL DEFAULT 0,
	ieps_envase_reutilizable	bit				NULL DEFAULT 0,
	ieps_retencion				float			NULL,
	ieps_cantidad				float			NULL,
	ieps_unidad					varchar(50)		NULL,
	ieps_cantidad2				float			NULL,
	ieps_unidad2				varchar(50)		NULL,
	
	CONSTRAINT priMFALayoutDocumentoD PRIMARY KEY CLUSTERED (DocumentoID, RID)
)
GO

EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_num_reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_categoria_concepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_exento', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_envase_reutilizable', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_retencion', 'float NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_cantidad', 'float NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_cantidad2', 'float NULL'
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'ieps_unidad2', 'varchar(50) NULL'
GO

--BUG17399
EXEC spDROP_PK 'MFALayoutDocumentoD'
GO
EXEC spDROP_COLUMN 'MFALayoutDocumentoD', 'RID'
GO
EXEC spALTER_TABLE 'MFALayoutDocumentoD', 'RID', 'int	IDENTITY'
GO
EXEC spADD_PK 'MFALayoutDocumentoD', 'RID'
GO

if not exists (select * from sysobjects where id = object_id('dbo.MFALayoutAplicacion') and type = 'U') 
CREATE TABLE MFALayoutAplicacion (
	PeriodoID				varchar(36) NOT NULL,
    DocumentoID				varchar(36) NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),
	
    RID						int			NOT NULL,
	origen_tipo				varchar(50)		NULL,		-- auto, manual
	origen_id				varchar(50)		NULL,
	empresa					varchar(5)		NULL,
	tipo_aplicacion			varchar(50)		NULL,		-- aplicacion, redocumentacion, cobro, pago
	folio					varchar(50)		NULL,
	fecha					datetime		NULL,	
	
	CONSTRAINT priMFALayoutAplicacion PRIMARY KEY CLUSTERED (DocumentoID, PeriodoID)
)
GO

--BUG16247
EXEC spALTER_TABLE 'MFALayoutAplicacion', 'aplica_ieps', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'MFALayoutAplicacion', 'aplica_ietu', 'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
EXEC spALTER_TABLE 'MFALayoutAplicacion', 'aplica_iva',  'varchar(2) NOT NULL DEFAULT ''Si'' WITH VALUES'
GO

--BUG17158
EXEC spALTER_TABLE 'MFALayoutAplicacion', 'origen_modulo',  'varchar(5)		NULL'
GO

--BUG17399
EXEC spDROP_COLUMN 'MFALayoutAplicacion', 'RID'
GO
EXEC spALTER_TABLE 'MFALayoutAplicacion', 'RID', 'int	IDENTITY'
GO

if not exists (select * from sysobjects where id = object_id('dbo.MFALayoutAplicacionD') and type = 'U') 
CREATE TABLE MFALayoutAplicacionD (
    DocumentoID				varchar(36) NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),
    RID						varchar(36) NOT NULL DEFAULT CONVERT(varchar(36),NEWID()),    
	
	referencia				varchar(50)		NULL,
	importe					float			NULL,
	cuenta_bancaria			varchar(50)		NULL,

	CONSTRAINT priMFALayoutAplicacionD PRIMARY KEY CLUSTERED (RID, DocumentoID)
)
GO

--BUG17399
EXEC spDROP_PK 'MFALayoutAplicacionD'
GO
EXEC spDROP_COLUMN 'MFALayoutAplicacionD', 'RID'
GO
EXEC spALTER_TABLE 'MFALayoutAplicacionD', 'RID', 'int	IDENTITY'
GO
EXEC spADD_PK 'MFALayoutAplicacionD', 'RID'
GO

-- drop table layout_aplicacion_entidad
if not exists (select * from sysobjects where id = object_id('dbo.layout_aplicacion_entidad') and type = 'U') 
CREATE TABLE layout_aplicacion_entidad (	
    RID						int identity(1,1) NOT NULL,
    empresa					varchar(5) NOT NULL,
	referencia				varchar(50) NOT NULL,
	folio                   varchar(50) NOT NULL,	
    entidad_clave           varchar(20) NULL,
    entidad_nombre          varchar(150) NULL,
    entidad_rfc             varchar(15) NULL,
    entidad_id_fiscal       varchar(50) NULL,
    entidad_tipo_tercero    varchar(50) NULL,
    entidad_tipo_operacion  varchar(50) NULL,
    entidad_pais            varchar(20) NULL,
    entidad_nacionalidad    varchar(50) NULL,
	
	CONSTRAINT pri_layout_aplicacion_entidad PRIMARY KEY CLUSTERED (RID)
)
GO

--BUG17210
/****** MFACtaEstructuraTipo ******/
if not exists(select * from SysTabla where SysTabla = 'MFACtaEstructuraTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFACtaEstructuraTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFACtaEstructuraTipo') and type = 'U') 
  CREATE TABLE MFACtaEstructuraTipo(
    Cuenta			varchar(20),
    Tipo			varchar(50)		NULL,
	CONSTRAINT priMFACtaEstructuraTipo PRIMARY KEY CLUSTERED(Cuenta)
	)
GO

--BUG17210
IF NOT EXISTS(SELECT * FROM MFACtaEstructuraTipo)
BEGIN
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('A', '')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('B', 'activo_circulante')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('C', 'activo_circulante')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('D', 'activo_fijo')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('E', 'activo_diferido')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('H', 'pasivo_corto_plazo')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('I', 'pasivo_corto_plazo')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('J', 'pasivo_largo_plazo')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('K', '')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('Q', 'capital_contable')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('R', 'capital_contable')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('S', 'ingresos')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('T', 'costos')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('U', 'gastos_operacion')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('U2','otros_gastos')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('U3','impuestos')
  INSERT INTO MFACtaEstructuraTipo(Cuenta, Tipo) VALUES('X', 'cuentas_orden')
END
GO

--REQ19173
/****** MFARepCxpFisicas ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicas')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicas','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicas') and type = 'U') 
  CREATE TABLE MFARepCxpFisicas(
    Empresa				varchar(5),
    IncluirConcluidos	bit,
	CONSTRAINT priMFARepCxpFisicas PRIMARY KEY CLUSTERED(Empresa)
	)
GO

EXEC spDROP_COLUMN 'MFARepCxpFisicas', 'IncluirConcluidos'
EXEC spALTER_TABLE 'MFARepCxpFisicas', 'Estatus', 'varchar(15) NOT NULL'
EXEC spALTER_TABLE 'MFARepCxpFisicas', 'Concepto', 'varchar(100) NULL'
EXEC spDROP_PK 'MFARepCxpFisicas'
EXEC spADD_PK 'MFARepCxpFisicas', 'Empresa, Estatus'
GO

IF NOT EXISTS(SELECT * FROM MFARepCxpFisicas)
BEGIN
  INSERT INTO MFARepCxpFisicas(Empresa, Concepto, Estatus) SELECT Empresa, 'Pagos Deducibles a Personas Físicas  y Morales de Régimen Simplificado', 'Pendiente' FROM Empresa
  INSERT INTO MFARepCxpFisicas(Empresa, Concepto, Estatus) SELECT Empresa, 'Pagos No Deducibles a Personas Físicas  y Morales de Régimen Simplificado', 'Concluido' FROM Empresa  
END
GO

--REQ19173
/****** MFARepCxpFisicasAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasAdicion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasAdicion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasAdicion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasExcepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasExcepcion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasExcepcion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasExcepcion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasDevAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasDevAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasDevAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasDevAdicion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasDevAdicion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasDevAdicion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasDevExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasDevExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasDevExcepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasDevExcepcion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasDevExcepcion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasDevExcepcion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasPagoAdicion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasPagoAdicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasPagoAdicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasPagoAdicion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasPagoAdicion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasPagoAdicion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasPagoExcepcion ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasPagoExcepcion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasPagoExcepcion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasPagoExcepcion') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasPagoExcepcion(
    Modulo				varchar(5),
    Mov					varchar(20),
	CONSTRAINT priMFARepCxpFisicasPagoExcepcion PRIMARY KEY CLUSTERED(Modulo, Mov)
	)
GO

--REQ19173
/****** MFARepCxpFisicasClaseSubClase ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasClaseSubClase')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasClaseSubClase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasClaseSubClase') and type = 'U') 
  CREATE TABLE MFARepCxpFisicasClaseSubClase(
    Clase		varchar(50),
    Subclase	varchar(50)
	CONSTRAINT priMFARepCxpFisicasClaseSubClase PRIMARY KEY CLUSTERED(Clase, SubClase)
	)
GO

EXEC spALTER_TABLE 'MFARepCxpFisicasClaseSubClase', 'RID', 'int	IDENTITY'
GO
EXEC spDROP_PK 'MFARepCxpFisicasClaseSubClase'
GO
EXEC spADD_PK 'MFARepCxpFisicasClaseSubClase', 'RID'
GO
EXEC spALTER_COLUMN 'MFARepCxpFisicasClaseSubClase', 'Subclase', 'varchar(50) NULL'
GO

--REQ19173
/****** MFARepCxpFisicasFiscalRegimen ******/
if not exists(select * from SysTabla where SysTabla = 'MFARepCxpFisicasFiscalRegimen')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFARepCxpFisicasFiscalRegimen','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFARepCxpFisicasFiscalRegimen') and type = 'U') 
BEGIN
  CREATE TABLE MFARepCxpFisicasFiscalRegimen(
    FiscalRegimen		varchar(30),
	CONSTRAINT priMFARepCxpFisicasFiscalRegimen PRIMARY KEY CLUSTERED(FiscalRegimen)
	)

  INSERT INTO MFARepCxpFisicasFiscalRegimen(FiscalRegimen) SELECT 'Persona Fisica'
  INSERT INTO MFARepCxpFisicasFiscalRegimen(FiscalRegimen) SELECT 'Sociedad Civil'
  INSERT INTO MFARepCxpFisicasFiscalRegimen(FiscalRegimen) SELECT 'Extranjero'
END
GO

--BUG20350
/****** MFAMon ******/
if not exists(select * from SysTabla where SysTabla = 'MFAMon')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAMon','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFAMon') and type = 'U') 
BEGIN
  CREATE TABLE MFAMon(
    Moneda		varchar(10),
    Codigo		varchar(5)	NULL,
    CONSTRAINT priMFAMon PRIMARY KEY CLUSTERED(Moneda)
  )

  INSERT INTO MFAMon(Moneda, Codigo) SELECT 'Pesos', ''
END
GO

--BUG21567
/****** MFAAcum ******/
if not exists(select * from SysTabla where SysTabla = 'MFAAcum')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAAcum','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFAAcum') and type = 'U') 
CREATE TABLE MFAAcum(
	Sucursal		int			NOT NULL,
	Empresa			char(5)		NOT NULL,
	Rama			char(5)		NOT NULL,
	Ejercicio		int			NOT NULL,
	Periodo			int			NOT NULL,
	Moneda			char(10)	NOT NULL,
	Grupo			char(10)	NOT NULL,
	Cuenta			char(20)	NOT NULL,
	SubCuenta		varchar(50) NOT NULL,
	SubCuenta2		varchar(50) NOT NULL,
	SubCuenta3		varchar(50) NOT NULL,
	Proyecto		varchar(50) NOT NULL,
	UEN				int			NOT NULL,
	Cargos			money		NULL,
	Abonos			money		NULL,
	UltimoCambio	datetime	NULL,
    CONSTRAINT priMFAAcum PRIMARY KEY CLUSTERED(Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Rama, Ejercicio, Periodo, Moneda, Sucursal, Empresa)
)
GO

--BUG22165
/****** MFAActivoFCat ******/
if not exists(select * from SysTabla where SysTabla = 'MFAActivoFCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAActivoFCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFAActivoFCat') and type = 'U') 
CREATE TABLE MFAActivoFCat(
    Categoria		varchar(50)	NOT NULL,
    Tipo			int			NULL,
    CONSTRAINT priMFAActivoFCat PRIMARY KEY CLUSTERED(Categoria)
)
GO

--BUG22165
/****** MFAArtAF ******/
if not exists(select * from SysTabla where SysTabla = 'MFAArtAF')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAArtAF','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFAArtAF') and type = 'U') 
CREATE TABLE MFAArtAF(
    Articulo		varchar(20)	NOT NULL,
    CONSTRAINT priMFAArtAF PRIMARY KEY CLUSTERED(Articulo)
)
GO

--BUG22165
/****** MFATipoActividad ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoActividad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoActividad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoActividad') and type = 'U') 
CREATE TABLE MFATipoActividad(
    Modulo			varchar(5)		NOT NULL,
    Mov				varchar(20)		NOT NULL,
    Tipo			varchar(10)		NOT NULL,
    CONSTRAINT priMFATipoActividad PRIMARY KEY CLUSTERED(Modulo, Mov)
)
GO

/****** MFATipoActivo ******/
if not exists(select * from SysTabla where SysTabla = 'MFATipoActivo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFATipoActivo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MFATipoActivo') and type = 'U') 
CREATE TABLE MFATipoActivo(
    Tipo			int				NOT NULL,
    Descripcion		varchar(255)	NOT NULL,
    CONSTRAINT priMFATipoActivo PRIMARY KEY CLUSTERED(Tipo)
)
GO

IF NOT EXISTS(SELECT * FROM MFATipoActivo)
BEGIN
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 1, 'MAQUINARIA Y EQUIPO'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 2, 'MOBILIARIO Y EQUIPO DE OFICINA'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 3, 'EQUIPO DE CÓMPUTO'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 4, 'EQUIPO DE TRANSPORTE'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 5, 'CONSTRUCCIONES'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 6, 'OTROS ACTIVOS FIJOS'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 7, 'OTROS ACTIVOS DIFERIDOS'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 8, 'TERRENOS'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 9, 'ACCIONES'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 10, 'MAQ Y EQ P\GENERACION DE ENERGIA'
  INSERT INTO MFATipoActivo(Tipo, Descripcion) SELECT 11, 'ADAPTACION INST P\PERS C\CAP DIF'
END
GO

/************************************************** Indices **************************************************/
--BUG22759
EXEC spADD_INDEX 'documentos', 'EsRedocumentacion', 'EsRedocumentacion'
GO

--BUG22719
EXEC spADD_INDEX 'layout_polizas', 'polizas', 'Periodo, Ejercicio, Empresa'
EXEC spADD_INDEX 'layout_cuentas', 'polizas', 'Ejercicio, Empresa'
GO

--BU22575
EXEC spADD_INDEX 'Cont', 'layout_documentos_cuenta', 'Empresa,Estatus)INCLUDE (ID,Mov,MovID,OrigenTipo,Origen,OrigenID,Ejercicio,Periodo'
EXEC spADD_INDEX 'Documentos', 'NoDocumentos', 'folio,empresa,origen_modulo,documento_id'
GO
EXEC spADD_INDEX 'layout_aplicacion_entidad', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'temp2_layout_documentos_cuenta', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'temp3_layout_documentos_cuenta', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'layout_documentos_cuenta', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'temp2_layout_aplicaciones_cuenta', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'temp3_layout_aplicaciones_cuenta', 'Empresa', 'Empresa'
EXEC spADD_INDEX 'layout_aplicaciones_cuenta', 'Empresa', 'Empresa'
GO

--BUG22460
EXEC spADD_INDEX 'Cxc', 'MFACxcCobroSinAnticipadoCalc', 'Estatus)INCLUDE (ID,Empresa,Mov,MovID,FechaEmision,TipoCambio,FormaCobro,FormaCobro1,OrigenTipo,Origen,Ejercicio,Periodo,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion'
GO
EXEC spADD_INDEX 'Cxc', 'MFAVentaCalc', 'OrigenTipo,Estatus)INCLUDE (Empresa,Mov,MovID,Origen,OrigenID,Dinero,DineroID'
GO
EXEC spADD_INDEX 'MovFlujo', 'MFACxcDineroCalc', 'OModulo,DModulo)INCLUDE (OID,DID'
GO
EXEC spADD_INDEX 'Dinero', 'MFACxcDineroCalc', 'OrigenTipo,Estatus)INCLUDE (ID,Empresa,Mov,Origen,OrigenID'
go
EXEC spADD_INDEX 'Dinero', 'MFACxcDineroCalc2', 'OrigenTipo,Estatus,Importe)INCLUDE (ID,Empresa,Mov,MovID,CtaDinero,Origen,OrigenID,Conciliado'
GO
EXEC spADD_INDEX 'Dinero', 'MFACxcDineroCalc3', 'OrigenTipo,Origen,Estatus)INCLUDE (ID,Empresa,Mov,OrigenID'
GO
EXEC spADD_INDEX 'Dinero', 'MFACxcDineroCalc4', 'Mov,OrigenTipo,Estatus,Importe)INCLUDE(ID,Empresa,MovID,CtaDinero,Origen,OrigenID,Conciliado'
GO
EXEC spADD_INDEX 'aplicaciones', 'fecha2', 'Empresa, Fecha'
GO
EXEC spADD_INDEX 'documentos', 'fecha2', 'Empresa, Fecha'
GO
EXEC spADD_INDEX 'aplicaciones', 'Redoc', 'Ejercicio, Periodo, Empresa, tipo_aplicacion'
EXEC spADD_INDEX 'documentos', 'Redoc', 'empresa,ejercicio,periodo)INCLUDE(documento_id,EsRedocumentacion'
GO
EXEC spADD_INDEX 'documentos', 'Redoc2', 'referencia, empresa, documento_id)INCLUDE(importe_total, BaseIVAImportacion'
GO
EXEC spADD_INDEX 'documentos', 'RedocDia', 'ejercicio,EsRedocumentacion,dia)INCLUDE(documento_id'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'layout_documentos' AND sysindexes.name = 'sec01layout_documentos' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01layout_documentos ON dbo.layout_documentos (origen_id, origen_modulo)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'documentos' AND sysindexes.name = 'fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX fecha ON documentos (empresa, ejercicio, periodo, origen_tipo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'documentos' AND sysindexes.name = 'folio' AND sysobjects.id = sysindexes.id)
  CREATE INDEX folio ON documentos (folio, empresa, origen_tipo)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'documentos' AND sysindexes.name = 'referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX referencia ON documentos (referencia, empresa)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'aplicaciones' AND sysindexes.name = 'fecha' AND sysobjects.id = sysindexes.id)
  CREATE INDEX fecha ON aplicaciones (empresa, ejercicio, periodo, dia)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'aplicaciones' AND sysindexes.name = 'folio' AND sysobjects.id = sysindexes.id)
  CREATE INDEX folio ON aplicaciones (folio, empresa)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'aplicaciones' AND sysindexes.name = 'referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX referencia ON aplicaciones (referencia, empresa)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MFAMovSubTipoDocumentoExcepcionArt' AND sysindexes.name = 'uniMFAMovSubTipoDocumentoExcepcionArt' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE INDEX uniMFAMovSubTipoDocumentoExcepcionArt ON dbo.MFAMovSubTipoDocumentoExcepcionArt (Articulo, Mov, Modulo)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MFAMovSubTipoDocumentoExcepcionGas' AND sysindexes.name = 'uniMFAMovSubTipoDocumentoExcepcionGas' AND sysobjects.id = sysindexes.id)
  CREATE UNIQUE INDEX uniMFAMovSubTipoDocumentoExcepcionGas ON dbo.MFAMovSubTipoDocumentoExcepcionGas (ConceptoGas, Mov, Modulo)
GO


IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[MovTipoMFAAplicaAdicion]') AND name = N'IX_MovTipoMFAAplicaAdicion')
CREATE UNIQUE NONCLUSTERED INDEX [IX_MovTipoMFAAplicaAdicion] ON [dbo].[MovTipoMFAAplicaAdicion] 
(
	[Modulo] ASC,
	[Mov] ASC,
	[Origen] ASC,
	[OrigenTipo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'layout_documentos_cuenta' AND sysindexes.name = 'sec01_layout_documentos_cuenta' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01_layout_documentos_cuenta ON layout_documentos_cuenta (origen_id, origen_modulo, empresa)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MFAPolizaEntidad' AND sysindexes.name = 'sec01MFAPolizaEntidad' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01MFAPolizaEntidad ON dbo.MFAPolizaEntidad (ModuloID, Modulo)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MFAPolizaConcepto' AND sysindexes.name = 'sec01MFAPolizaConcepto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01MFAPolizaConcepto ON dbo.MFAPolizaConcepto (ModuloID, Modulo)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MFAPolizaImpuesto' AND sysindexes.name = 'sec01MFAPolizaImpuesto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01MFAPolizaImpuesto ON dbo.MFAPolizaImpuesto (ModuloID, Modulo, ImpuestoTipo)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'layout_documentos' AND sysindexes.name = 'sec01_layout_documentos' AND sysobjects.id = sysindexes.id)
  CREATE INDEX sec01_layout_documentos ON layout_documentos (origen_id, origen_modulo, empresa)
GO

IF EXISTS(SELECT * FROM sysobjects where name ='Venta' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVVentaEP')
CREATE INDEX tnMFAVVentaEP ON Venta(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Agent' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVAgentEP')
CREATE INDEX tnMFAVAgentEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Cxc' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCxcEP')
CREATE INDEX tnMFAVCxcEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Cxp' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCxpEP')
CREATE INDEX tnMFAVCxpEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Compra' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVCompraEP')
CREATE INDEX tnMFAVCompraEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='Gasto' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnMFAVGastoEP')
CREATE INDEX tnMFAVGastoEP ON Agent(Periodo,Ejercicio)
GO
IF EXISTS(SELECT * FROM sysobjects where name ='aplicaciones' AND type ='u') AND NOT EXISTS(SELECT * FROM sysindexes WHERE name ='tnaplicaciones1')
CREATE INDEX tnaplicaciones1 ON aplicaciones(Periodo,Ejercicio,Empresa)
GO

EXEC spADD_INDEX 'documentos', 'tipo_documento', 'empresa, folio, documento_id) INCLUDE(tipo_documento'
EXEC spADD_INDEX 'layout_documentos', 'DocumentoCuenta', 'empresa, origen_modulo, origen_id'
EXEC spADD_INDEX 'temp2_layout_documentos_cuenta', 'DocumentoCuenta', 'origen_modulo, empresa, origen_id'
EXEC spADD_INDEX 'Venta', 'DocumentoCuenta', 'Empresa, ID)INCLUDE(Mov, MovID, Poliza, PolizaID'
EXEC spADD_INDEX 'Compra', 'DocumentoCuenta', 'Empresa, ID)INCLUDE(Mov, MovID, Poliza, PolizaID'
EXEC spADD_INDEX 'Gasto', 'DocumentoCuenta', 'Empresa, ID)INCLUDE(Mov, MovID, Poliza, PolizaID'
EXEC spADD_INDEX 'Cxc', 'DocumentoCuenta', 'Empresa, ID)INCLUDE(Mov, MovID, Poliza, PolizaID'
EXEC spADD_INDEX 'Cxp', 'DocumentoCuenta', 'Empresa, ID)INCLUDE(Mov, MovID, Poliza, PolizaID'
EXEC spADD_INDEX 'layout_aplicaciones', 'AplicacionEntidad', 'referencia, periodo, empresa, ejercicio, folio'
EXEC spADD_INDEX 'layout_documentos', 'AplicacionEntidad', 'folio, empresa, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad'
EXEC spADD_INDEX 'DatosIetu', 'Init', 'empresa, ejercicio, periodoasi'
EXEC spADD_INDEX 'ximpiva', 'Init', 'empresa, ejercicio, periodo'
EXEC spADD_INDEX 'DatosIeps', 'Init', 'empresa, ejercicio, periodo'
GO

EXEC spADD_INDEX 'DatosIeps', 'ObtenerImporte', 'Empresa, Num_Reporte, Ejercicio, Periodo)INCLUDE(Tipo_Movimiento, Categoria_Concepto, Importe'
GO

EXEC spADD_INDEX 'Cxc', 'MFAImportar', 'OrigenTipo, Estatus) INCLUDE(Empresa, Mov, MovID, Origen, OrigenID'
EXEC spADD_INDEX 'Cxc', 'MFAImportar2', 'Estatus) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Cliente, Importe, Retencion, Agente, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, IVAFiscal, IEPSFiscal'
EXEC spADD_INDEX 'Cxc', 'MFAImportar3', 'Estatus, Importe) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Impuestos, Retencion, MovAplica, MovAplicaID, OrigenTipo, Origen, Ejercicio, Periodo, DineroCtaDinero'
EXEC spADD_INDEX 'Cxc', 'MFAImportar4', 'Ejercicio, Periodo, Estatus) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Cliente, Importe, Retencion, Agente, OrigenTipo, Origen, OrigenID, IVAFiscal, IEPSFiscal'
EXEC spADD_INDEX 'Cxc', 'MFAImportar5', 'Ejercicio, Periodo, Estatus) INCLUDE (ID, Empresa, Mov, FechaEmision, TipoCambio, MovAplica, MovAplicaID, OrigenTipo, Origen, DineroCtaDinero'
EXEC spADD_INDEX 'Cxc', 'MFAImportar6', 'Ejercicio, Periodo, Estatus, Importe) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Impuestos, Retencion, MovAplica, MovAplicaID, OrigenTipo, Origen, DineroCtaDinero'
EXEC spADD_INDEX 'Gasto', 'MFAImportar', 'Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Acreedor, Ejercicio, Periodo'
EXEC spADD_INDEX 'Venta', 'MFAImportar', 'Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Cliente, Agente, Ejercicio, Periodo'
EXEC spADD_INDEX 'Venta', 'MFAImportar2', 'Ejercicio, Periodo, Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Cliente, Agente, OrigenTipo'
EXEC spADD_INDEX 'Cxp', 'MFAImportar', 'OrigenTipo, Estatus) INCLUDE(Empresa, Mov, MovID, Origen, OrigenID'
EXEC spADD_INDEX 'Cxp', 'MFAImportar2', 'Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Proveedor, Importe, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, IVAFiscal'
EXEC spADD_INDEX 'Cxp', 'MFAImportar3', 'Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Proveedor, Importe, Impuestos, Retencion, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, IEPSFiscal'
EXEC spADD_INDEX 'Cxp', 'MFAImportar4', 'Estatus, Importe) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Impuestos, Retencion, MovAplica, MovAplicaID, OrigenTipo, Origen, Ejercicio, Periodo, DineroCtaDinero'
EXEC spADD_INDEX 'Cxp', 'MFAImportar5', 'Ejercicio, Periodo, Estatus) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Proveedor, Importe, OrigenTipo, Origen, OrigenID, IVAFiscal'
EXEC spADD_INDEX 'Cxp', 'MFAImportar6', 'Ejercicio, Periodo, Estatus) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, Concepto, TipoCambio, Proveedor, Importe, Impuestos, Retencion, OrigenTipo, Origen, OrigenID, IEPSFiscal'
EXEC spADD_INDEX 'Cxp', 'MFAImportar7', 'Ejercicio, Periodo, Estatus) INCLUDE (ID, Empresa, Mov, FechaEmision, TipoCambio, MovAplica, MovAplicaID, OrigenTipo, Origen, DineroCtaDinero'
EXEC spADD_INDEX 'Cxp', 'MFAImportar8', 'Ejercicio, Periodo, Estatus, Importe) INCLUDE (ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Impuestos, Retencion, MovAplica, MovAplicaID, OrigenTipo, Origen, DineroCtaDinero'
EXEC spADD_INDEX 'Compra', 'MFAImportar', 'Estatus) INCLUDE(ID, Empresa, Mov, MovID, FechaEmision, TipoCambio, Proveedor, Agente, Ejercicio, Periodo'
EXEC spADD_INDEX 'Prov', 'MFAImportar', 'Estatus) INCLUDE(Proveedor, Pais, RFC, FiscalRegimen, MFATipoOperacion'
EXEC spADD_INDEX 'Cte', 'MFAImportar', 'Estatus) INCLUDE(Cliente, Pais, RFC, FiscalRegimen, MFATipoOperacion'
EXEC spADD_INDEX 'CxcD', 'MFAImportar', 'Importe) INCLUDE (ID, Aplica, AplicaID'
EXEC spADD_INDEX 'CxpD', 'MFAImportar', 'Importe) INCLUDE (ID, Aplica, AplicaID'
GO

EXEC spADD_INDEX 'Compra', 'LayoutImportar', 'Poliza) INCLUDE(ID, Empresa, Mov, MovID, PolizaID'
EXEC spADD_INDEX 'Gasto', 'LayoutImportar', 'Poliza) INCLUDE (ID, Empresa, Mov, MovID, PolizaID'
GO

EXEC spADD_INDEX 'Documentos', 'ImporteTotal', 'Referencia, Empresa, importe_total'
GO

EXEC spADD_INDEX 'layout_documentos', 'EjercicioPeriodo', 'Empresa, Ejercicio, Periodo'
EXEC spADD_INDEX 'layout_aplicaciones', 'EjercicioPeriodo', 'Empresa, Ejercicio, Periodo'

EXEC spADD_INDEX 'aplicaciones', 'ValidaRef', 'empresa, periodo, aplicacion_id, referencia, folio'
GO
EXEC spADD_INDEX 'Venta', 'DocumentoCuenta2', 'Poliza) INCLUDE (ID, Empresa, Mov, MovID, PolizaID'
GO
EXEC spADD_INDEX 'Cxc', 'DocumentoCuenta2', 'Poliza) INCLUDE (ID, Empresa, Mov, MovID, PolizaID'
GO
EXEC spADD_INDEX 'Cxp', 'DocumentoCuenta2', 'Poliza) INCLUDE (ID, Empresa, Mov, MovID, PolizaID'
GO

EXEC spADD_INDEX 'Cont', 'MFACuenta', 'ID, OrigenID, Origen, Empresa, MovID, Mov, OrigenTipo'
EXEC spADD_INDEX 'ContD', 'MFACuenta', 'Cuenta) INCLUDE(Debe, Haber'
GO

--BUG17507
EXEC spADD_INDEX 'layout_aplicaciones', 'EsIFRS', 'EsIFRS'
GO

--BUG18077
EXEC spADD_INDEX 'layout_documentos', 'EsIFRS', 'EsIFRS'
GO

EXEC spADD_INDEX 'layout_documentos', 'Borra', 'empresa)INCLUDE(origen_vista,fecha'
EXEC spADD_INDEX 'documentos', 'Borra', 'empresa,fecha,origen_vista'
EXEC spADD_INDEX 'layout_aplicaciones', 'Borra', 'empresa)INCLUDE(origen_vista,fecha'
EXEC spADD_INDEX 'aplicaciones', 'Borra', 'empresa,fecha,origen_vista'
GO

--BUG24882
EXEC spADD_INDEX 'Cte', 'MFAVentaContadoPagoCalc', 'Cliente, Pais'
EXEC spADD_INDEX 'Cxc', 'MFAVentaContadoPagoCalc', 'Empresa, Mov, MovID'
EXEC spADD_INDEX 'MovTipo', 'MFAVentaContadoPagoCalc', 'Clave, Modulo'
EXEC spADD_INDEX 'Venta', 'MFAVentaContadoPagoCalc', 'Empresa,Estatus)INCLUDE (ID,Mov,MovID,FechaEmision,TipoCambio,Cliente,Importe,OrigenTipo,Origen,Ejercicio,Periodo,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion'
EXEC spADD_INDEX 'Venta', 'MFAVentaContadoPagoCalc2', 'Empresa,Mov,Estatus)INCLUDE (ID,MovID,FechaEmision,TipoCambio,Cliente,Importe,OrigenTipo,Origen,Ejercicio,Periodo,Dinero,DineroID,DineroCtaDinero,DineroConciliado,DineroFechaConciliacion'
GO

/****** MFAIrTesoreria ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MFAIrTesoreria') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MFAIrTesoreria','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MFAIrTesoreria') and TYPE = 'U') 
CREATE TABLE dbo.MFAIrTesoreria 
(
	Movimiento   varchar(20)   NOT NULL,
	Clave        varchar(20)   NOT NULL,
    CONSTRAINT priMFAIrTesoreria PRIMARY KEY  CLUSTERED (Movimiento, Clave)
)
GO
EXEC spALTER_COLUMN 'MFAIrTesoreria', 'Movimiento', 'varchar(20) NOT NULL'
EXEC spALTER_COLUMN 'MFAIrTesoreria', 'Clave', 'varchar(20) NOT NULL'
GO
ALTER TABLE MFAIrTesoreria DROP CONSTRAINT priMFAIrTesoreria
GO
ALTER TABLE MFAIrTesoreria ADD CONSTRAINT priMFAIrTesoreria PRIMARY KEY CLUSTERED (Movimiento, Clave)
GO

IF NOT EXISTS (SELECT * FROM MFAIrTesoreria WHERE CLAVE IN ('DIN.D','DIN.DE','DIN.CH','DIN.CHE'))
BEGIN
	INSERT INTO MFAIrTesoreria (Movimiento, Clave)
						SELECT  MOV,        CLAVE 
						  FROM  MOVTIPO 
						  WHERE CLAVE IN ('DIN.D','DIN.DE','DIN.CH','DIN.CHE') 
						    AND MODULO = 'DIN' 
					   ORDER BY MOV
END
GO

/************************************************** Funciones **************************************************/
--BUG24733
/**************** fnMFAGASImporte ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAGASImporte') drop function dbo.fnMFAGASImporte
GO
CREATE FUNCTION fnMFAGASImporte(
				@GASPorcentajeDeducible		bit,
				@PorcentajeDeducible		float
				)
RETURNS float
AS BEGIN
  DECLARE @Valor	float
  
  IF ISNULL(@GASPorcentajeDeducible, 0) = 0
    SELECT @Valor = 100.0
  ELSE
    SELECT @Valor = @PorcentajeDeducible
    
  RETURN @Valor
END
GO

--REQ23552
/**************** fnMFAIEPSIVA ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAIEPSIVA') drop function dbo.fnMFAIEPSIVA
GO
CREATE FUNCTION fnMFAIEPSIVA(
				@Empresa		varchar(5),
				@DefImpuesto	float,
				@IVATasa		float,
				@IEPS			float
				)
RETURNS float
AS
BEGIN
  DECLARE @Valor	float
  
  IF @DefImpuesto = @IVATasa
    SELECT @Valor = @IEPS * (@DefImpuesto/100)
  ELSE
    SELECT @Valor = 0
  
  RETURN @Valor
END
GO

/**************** fn_fecha ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_fecha') drop function dbo.fn_fecha
GO
CREATE FUNCTION fn_fecha (@ejercicio smallint, @periodo smallint, @dia smallint)
RETURNS datetime
--WITH ENCRYPTION
AS BEGIN
  RETURN CONVERT(datetime, CONVERT(varchar, @dia) + '/' + CONVERT(varchar, @periodo) + '/' + CONVERT(varchar, @ejercicio), 103)
END
GO

/**************** fn_r3 ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_r3') drop function dbo.fn_r3
GO
CREATE FUNCTION fn_r3 (@si_1 float, @entonces_1 float, @si_2 float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN (ISNULL(@si_2, 0.0) * ISNULL(@entonces_1, 0.0)) / NULLIF(@si_1, 0.0)
END
GO

/**************** fn_tipo_datosietu ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipo_datosietu') drop function dbo.fn_tipo_datosietu
GO
CREATE FUNCTION fn_tipo_datosietu (@tipo_aplicacion varchar(50))
RETURNS smallint
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@tipo_aplicacion) 
      WHEN 'cobro'	THEN 1 
      WHEN 'pago'	THEN 2 
      ELSE NULL
    END
END
GO

/**************** fn_documento_factor ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_documento_factor') drop function dbo.fn_documento_factor
GO
--BUG18752
CREATE FUNCTION fn_documento_factor (@origen_modulo varchar(50), @tipo_documento varchar(50))
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @resultado float
  --BUG18752 BUG23996
  IF (LOWER(@tipo_documento) IN ('nota_credito', /*'anticipo',*/ 'devolucion') and @origen_modulo IN('CXC', 'VTAS') OR (LOWER(@tipo_documento) IN ('nota_credito') and @origen_modulo IN('CXP')))
    SELECT @resultado = -1.0
  ELSE
    SELECT @resultado = 1.0 
  RETURN @resultado
END
GO

/**************** fn_tipoiva ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipoiva') drop function dbo.fn_tipoiva
GO
CREATE FUNCTION fn_tipoiva (@tipo_aplicacion varchar(50))
RETURNS smallint
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@tipo_aplicacion) 
      WHEN 'cobro'	THEN 1 
      WHEN 'pago'	THEN 2 
      ELSE NULL
    END
END
GO

/**************** fn_tipoopera ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipoopera') drop function dbo.fn_tipoopera
GO
--BUG16705 BUG18752
CREATE FUNCTION fn_tipoopera (@origen_modulo varchar(50), @iva_excento bit, @iva_tasa float, @entidad_tipo_tercero varchar(50), @concepto_es_importacion float, @tipo_documento varchar(50))
RETURNS smallint
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @resultado smallint

  --BUG16705 REQ16748
  IF @entidad_tipo_tercero = 'extranjero' AND ISNULL(@concepto_es_importacion, 0) = 1 AND ROUND(ISNULL(@iva_tasa, 0), 2)  = 16
    SELECT @resultado = 1
  ELSE IF @entidad_tipo_tercero = 'extranjero' AND ISNULL(@concepto_es_importacion, 0) = 1 AND ROUND(ISNULL(@iva_tasa, 0), 2)  = 11
    SELECT @resultado = 9
  ELSE IF @entidad_tipo_tercero = 'extranjero' AND ISNULL(@concepto_es_importacion, 0) = 1 AND ROUND(ISNULL(@iva_tasa, 0), 2)  = 0
    SELECT @resultado = 10
  ELSE
  BEGIN
    IF ISNULL(@iva_excento, 0) = 1
      SELECT @resultado = 3 --BUG14400
    ELSE
      IF @tipo_documento IN('nota_credito', 'devolucion') AND @origen_modulo IN('COMS', 'CXP', 'GAS')
        SELECT @resultado = 8
      ELSE 
        SELECT @resultado = 
          CASE ROUND(ISNULL(@iva_tasa, 0), 2) 
            WHEN 16.0 THEN 6
            WHEN 11.0 THEN 7
            WHEN 0.0  THEN 2
            ELSE 4 --BUG14400
          END
  END
  RETURN @resultado
END
GO

/**************** fn_tipoope ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipoope') drop function dbo.fn_tipoope
GO
CREATE FUNCTION fn_tipoope (@tipo_operacion varchar(50))
RETURNS varchar(10)
--WITH ENCRYPTION
AS BEGIN
  RETURN
    CASE LOWER(@tipo_operacion)
      WHEN 'prestacion_servicios'		THEN '03'
      WHEN 'arrendamiento_inmuebles'	THEN '06'
      WHEN 'otros'						THEN '85'
    END  
END
GO

/**************** fn_tipoter ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipoter') drop function dbo.fn_tipoter
GO
CREATE FUNCTION fn_tipoter (@tipo_tercero varchar(50))
RETURNS varchar(10)
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@tipo_tercero) 
      WHEN 'nacional'	THEN '04'
      WHEN 'extranjero' THEN '05'
      WHEN 'global'		THEN '15'
      ELSE NULL
    END
END
GO

/**************** fn_emisor ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_emisor') drop function dbo.fn_emisor
GO
CREATE FUNCTION fn_emisor (@tipo_aplicacion varchar(50))
RETURNS varchar(50)
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@tipo_aplicacion) 
      WHEN 'cobro' THEN 'terceros'
      WHEN 'pago'  THEN 'empresa'
      ELSE NULL
    END
END
GO

/**************** fn_clase_cuenta ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_clase_cuenta') drop function dbo.fn_clase_cuenta
GO
CREATE FUNCTION fn_clase_cuenta (@clase_cuenta varchar(50))
RETURNS nvarchar(1)
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@clase_cuenta) 
      WHEN 'control'  THEN N'C'
      WHEN 'registro' THEN N'R'
      ELSE NULL
    END
END
GO

/**************** fn_tipo_cuenta ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_tipo_cuenta') drop function dbo.fn_tipo_cuenta
GO
CREATE FUNCTION fn_tipo_cuenta (@tipo_cuenta varchar(50))
RETURNS nvarchar(2)
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    CASE LOWER(@tipo_cuenta) 
      WHEN 'activo_circulante'  THEN N'A1'
      WHEN 'activo_fijo'		THEN N'A2'
      WHEN 'activo_diferido'	THEN N'A3'
      WHEN 'pasivo_corto_plazo'	THEN N'P1'
      WHEN 'pasivo_largo_plazo'	THEN N'P2'
      WHEN 'capital_contable'	THEN N'C1'
      WHEN 'otros_gastos'		THEN N'F1'
      WHEN 'otros_productos'	THEN N'H0'
      WHEN 'gastos_operacion'	THEN N'G1'
      WHEN 'impuestos'			THEN N'I1'
      WHEN 'cuentas_orden'		THEN N'O1'
      WHEN 'costos'				THEN N'T1'
      WHEN 'ingresos'			THEN N'V1'
      ELSE NULL
    END
END
GO

--REQ16520
/**************** fn_subtipo_datosietu ****************/
if exists (select * FROM sysobjects WHERE name = 'fn_subtipo_datosietu') drop function dbo.fn_subtipo_datosietu
GO
CREATE FUNCTION fn_subtipo_datosietu (@Concepto varchar(50), @tipo_aplicacion varchar(50))
RETURNS smallint
--WITH ENCRYPTION
AS BEGIN
  DECLARE @SubTipo	int
  SELECT @SubTipo = SubTipo FROM MFAIETUSubTipoConcepto WHERE Concepto = @Concepto AND TipoAplicacion = @tipo_aplicacion
  
  --BUG17151
  RETURN ISNULL(@SubTipo, 1)
  
END
GO

--BUG22370
/**************** fnMFAIVATasa ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAIVATasa') drop function dbo.fnMFAIVATasa
GO
CREATE FUNCTION fnMFAIVATasa (@Empresa varchar(5), @Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @IVAFiscal float,
  @Tasa		 float
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
  
  SET @IVAFiscal = dbo.fnMFAIVAFiscal(@Importe,@Impuestos)
 
  IF @Importe = 0 AND @Impuestos <> 0
    --BUG22833
    SELECT @Tasa = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa  
  --BUG23552
  --ELSE IF @Importe <> 0 AND @Impuestos = 0
  --  SELECT @Tasa = DefImpuesto FROM EmpresaGral WHERE Empresa = @Empresa
  ELSE
    SELECT @Tasa = ROUND(((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)/NULLIF(@Importe,0.0),2)*100.0

  RETURN @Tasa
    
END
GO

/**************** fnMFAArtUnidadConvertir ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMFAArtUnidadConvertir') DROP FUNCTION fnMFAArtUnidadConvertir
GO
CREATE FUNCTION fnMFAArtUnidadConvertir 
	( 
	@Cantidad				float,
	@FactorOrigen			float,
	@FactorDestino			float
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			float
  
  SET @Resultado = @Cantidad * @FactorOrigen
  SET @Resultado = @Resultado / NULLIF(@FactorDestino,0.0)
  
  RETURN (@Resultado)
END
GO

/**************** fnMFARetencionIVAFiscal ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFARetencionIVAFiscal') drop function dbo.fnMFARetencionIVAFiscal
GO
CREATE FUNCTION fnMFARetencionIVAFiscal (@Importe float, @Impuestos float, @Retencion2 float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    (ISNULL(@Retencion2,0.0)/NULLIF((ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)-ISNULL(@Retencion2,0.0)),0.0))
END
GO

/**************** fnMFATipoCuentaEstructura ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFATipoCuentaEstructura') drop function dbo.fnMFATipoCuentaEstructura
GO
CREATE FUNCTION fnMFATipoCuentaEstructura (@Cuenta varchar(20))
RETURNS varchar(50)
WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Tipo					varchar(20),
  @Resultado			varchar(50),
  @Rama					varchar(20)
  
  SELECT @Tipo = ISNULL(RTRIM(Tipo), ''), @Rama = ISNULL(RTRIM(Rama), '') FROM Cta WHERE Cuenta = @Cuenta
  
  --BUG16172
  IF NOT EXISTS(SELECT Cuenta FROM Cta WHERE Cuenta = @Rama) AND @Rama <> ''
    SET @Resultado = NULL
  ELSE
    SET @Resultado = dbo.fnMFATipoCuenta(dbo.fnMFACuentaEstructura(@Cuenta))
  RETURN @Resultado
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgMFATipoCtaAC') and sysstat & 0xf = 8) drop trigger dbo.tgMFATipoCtaAC
GO
CREATE TRIGGER tgMFATipoCtaAC ON MFATipoCta
--//WITH ENCRYPTION
AFTER INSERT, UPDATE
AS BEGIN
  DECLARE
    @CuentaN  		varchar(50),
    @CuentaA  		varchar(50)    

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CuentaN = Cuenta FROM Inserted
  SELECT @CuentaA = Cuenta FROM Deleted

  IF @CuentaN <> @CuentaA
    UPDATE MFATipoCta SET Longitud = LEN(@CuentaN) WHERE Cuenta = @CuentaN 
END
GO

/**************** fnMFARetencionIVA ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFARetencionIVA') drop function dbo.fnMFARetencionIVA
GO
CREATE FUNCTION fnMFARetencionIVA (@Importe float, @Impuestos float, @Retencion2 float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    ((ISNULL(@Retencion2,0.0)/NULLIF((ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)-ISNULL(@Retencion2,0.0)),0.0))*(ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)-ISNULL(@Retencion2,0.0)))
END
GO

/**************** fnMFAIVAFiscal ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAIVAFiscal') drop function dbo.fnMFAIVAFiscal
GO
CREATE FUNCTION fnMFAIVAFiscal (@Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  RETURN 
    (ISNULL(@Impuestos,0.0)/NULLIF((ISNULL(@Importe,0.0)+ISNULL(@Impuestos,0.0)),0.0))
END
GO

--BUG22370
/**************** fnMFAIVA ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAIVA') drop function dbo.fnMFAIVA
GO
--BUG22833
CREATE FUNCTION fnMFAIVA (@Empresa varchar(5), @Importe float, @Impuestos float)
RETURNS float
--WITH ENCRYPTION
AS BEGIN
  --BUG22833
  DECLARE 
  @IVAFiscal float,
  @IVA		 float,
  @Tasa		 float
 
  SELECT @Tasa = NULLIF(DefImpuesto/100.0, 0) FROM EmpresaGral WHERE Empresa = @Empresa
 
  SET @Importe = ISNULL(@Importe,0.0)
  SET @Impuestos = ISNULL(@Impuestos,0.0)
   
  SET @IVAFiscal = dbo.fnMFAIVAFiscal(@Importe,@Impuestos)

  IF @Importe = 0 AND @Impuestos <> 0  
    SELECT @IVA = @Impuestos/2
  --BUG23552
  --ELSE IF @Importe <> 0 AND @Impuestos = 0
  --BEGIN
  --  SELECT @Importe = @Importe/(1+@Tasa)
  --  SELECT @IVA = @Importe*@Tasa
  --END
  ELSE
    SELECT @IVA = ((@Importe/NULLIF((1-@IVAFiscal),0.0))*@IVAFiscal)    
 
  RETURN @IVA
END
GO

--select dbo.fnMFAIVAFiscal(Importe,Impuestos),dbo.fnMFAIVATasa(Importe,Impuestos),dbo.fnMFAIVA(Importe,Impuestos),Impuestos,ivafiscal,RETENCION,RETENCION2,* FROM Cxp WHERE ID = 101407    

/**************** fnMFARetencionIVA ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMFARetencionIVA') DROP FUNCTION fnMFARetencionIVA
GO
CREATE FUNCTION fnMFARetencionIVA 
	(
	@Articulo				varchar(20), 
	@ArtTipo				varchar(20),				
	@Pitex					varchar(20),
	@ImporteIVA				float,
	@SubTotal				float				
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RetencionIVA	float

  SET @RetencionIVA = 0.0
  
  IF RTRIM(UPPER(@Articulo)) = 'FLETE' AND RTRIM(UPPER(@ArtTipo)) = 'SERVICIO'
  BEGIN
    SET @RetencionIVA = ISNULL(@SubTotal,0.0) * 0.04
  END
  
  IF @Pitex IS NOT NULL
  BEGIN
    SET @RetencionIVA = @RetencionIVA + ISNULL(@ImporteIVA,0.0)
  END
  RETURN (@RetencionIVA)
END
GO

--SELECT dbo.fnMFAArtUnidadConvertir(1,20,0.4)

/**************** fnMFATipoCuenta ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFATipoCuenta') drop function dbo.fnMFATipoCuenta
GO
CREATE FUNCTION fnMFATipoCuenta (@Cuenta varchar(20))
RETURNS varchar(50)
WITH ENCRYPTION
AS BEGIN
  --BUG17210
  DECLARE @tipo_cuenta varchar(50)
  
  SELECT @tipo_cuenta = tipo FROM MFACtaEstructuraTipo WHERE Cuenta = @Cuenta
  
  RETURN @tipo_cuenta 
  --RETURN 
  --  CASE UPPER(@tipo_cuenta) 
  --    WHEN 'C'  THEN 'activo_circulante'  
  --    WHEN 'D'  THEN 'activo_fijo'		
  --    WHEN 'E'  THEN 'activo_diferido'	
  --    WHEN 'I'  THEN 'pasivo_corto_plazo'	
  --    WHEN 'J'  THEN 'pasivo_largo_plazo'	
  --    WHEN 'Q'  THEN 'capital_contable'	
  --    WHEN 'U2' THEN 'otros_gastos'			
  --    WHEN 'U'  THEN 'gastos_operacion'	
  --    WHEN 'U3' THEN 'impuestos'			
  --    WHEN 'X'  THEN 'cuentas_orden'		
  --    WHEN 'S'  THEN 'ingresos'						      
  --    WHEN 'T'  THEN 'costos'						
  --    ELSE NULL
  --  END
END
GO

/**************** fnMFACuentaEstructura ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFACuentaEstructura') drop function dbo.fnMFACuentaEstructura
GO
CREATE FUNCTION fnMFACuentaEstructura (@Cuenta varchar(20))
RETURNS varchar(20)
WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @Rama				varchar(20),
  @Tipo				varchar(15)
  
  SELECT 
    @Rama = Rama,
    @Tipo = Tipo 
    FROM Cta 
   WHERE Cuenta = @Cuenta
  
  IF @Tipo NOT IN ('Estructura')
  BEGIN
    SELECT @Cuenta = dbo.fnMFACuentaEstructura(@Rama)  
  END
    
  RETURN @Cuenta  
END
GO

/******************************** fnMFAObtenerCuentaEntidad *************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMFAObtenerCuentaEntidad') DROP FUNCTION fnMFAObtenerCuentaEntidad
GO
CREATE FUNCTION fnMFAObtenerCuentaEntidad 
	(
		   @Modulo						varchar(5),
		   @Mov							varchar(20),
		   @Categoria					varchar(50),
		   @Grupo						varchar(50),
		   @Familia						varchar(50),
		   @Entidad						varchar(10),
		   @EntidadTipo					varchar(20),
		   @Empresa						varchar(5),
		   @Poliza						varchar(20),
		   @PolizaID					varchar(20)		   		   		   
	)
RETURNS varchar(20)			   
AS BEGIN  
  DECLARE
    @Cuenta			varchar(20),
    @ID				int
  
  DECLARE @MFATipoCtaEntidad TABLE (
    Modulo				varchar(5) COLLATE DATABASE_DEFAULT NULL,
    ModuloCalif			int NULL DEFAULT 0,
    Mov					varchar(20) COLLATE DATABASE_DEFAULT NULL,
    MovCalif			int NULL DEFAULT 0,
    Categoria			varchar(50) COLLATE DATABASE_DEFAULT NULL,    
    CategoriaCalif		int NULL DEFAULT 0,
    Grupo				varchar(50) COLLATE DATABASE_DEFAULT NULL,        
    GrupoCalif			int NULL DEFAULT 0,
    Familia				varchar(50) COLLATE DATABASE_DEFAULT NULL,            
    FamiliaCalif		int NULL DEFAULT 0,
    Entidad				varchar(50) COLLATE DATABASE_DEFAULT NULL,                
    EntidadCalif		int NULL DEFAULT 0,
    EntidadTipo			varchar(50) COLLATE DATABASE_DEFAULT NULL,
    EntidadTipoCalif	int NULL DEFAULT 0,
    CalificacionTotal   int NULL DEFAULT 0,
    Cuenta				varchar(20) COLLATE DATABASE_DEFAULT NULL
  )  
  
  INSERT @MFATipoCtaEntidad (Modulo, Mov, Categoria, Grupo, Familia, Entidad, EntidadTipo)
                     SELECT  Modulo, Mov, Categoria, Grupo, Familia, Entidad, EntidadTipo
                       FROM  MFATipoCtaEntidad

  UPDATE @MFATipoCtaEntidad
     SET 
     ModuloCalif      = CASE 
                          WHEN Modulo = @Modulo   THEN 2
                          WHEN Modulo = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     MovCalif         = CASE 
                          WHEN Mov = @Mov      THEN 2
                          WHEN Mov = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     CategoriaCalif   = CASE 
                          WHEN Categoria = @Categoria THEN 2
                          WHEN Categoria = '(Todos)'  THEN 1
                          ELSE 0                        
                        END,
     GrupoCalif       = CASE 
                          WHEN Grupo = @Grupo    THEN 2
                          WHEN Grupo = '(Todos)' THEN 1
                          ELSE 0                    
                        END,
     FamiliaCalif     = CASE 
                          WHEN Familia = @Familia  THEN 2
                          WHEN Familia = '(Todos)' THEN 1
                          ELSE 0                 
                        END,
     EntidadCalif     = CASE 
                          WHEN Entidad = @Entidad  THEN 2
                          WHEN Entidad = '(Todos)' THEN 1
                          ELSE 0
                        END,
     EntidadTipoCalif = CASE 
                          WHEN EntidadTipo = @EntidadTipo  THEN 2
                          ELSE 0
                        END
                      
   UPDATE @MFATipoCtaEntidad 
      SET CalificacionTotal = ModuloCalif + MovCalif + CategoriaCalif + GrupoCalif + FamiliaCalif + EntidadCalif + EntidadTipoCalif                  
        
   SELECT 
      TOP 1 @Cuenta = Cuenta 
     FROM @MFATipoCtaEntidad 
    WHERE CalificacionTotal = (SELECT MAX(CalificacionTotal) FROM @MFATipoCtaEntidad
                                WHERE ModuloCalif <> 0
                                  AND MovCalif <> 0
                                  AND CategoriaCalif <> 0
                                  AND GrupoCalif <> 0
                                  AND FamiliaCalif <> 0
                                  AND EntidadCalif <> 0
                                  AND EntidadTipoCalif <> 0)
   
   SELECT @ID = ID FROM Cont WHERE MovID = @PolizaID AND Mov = @Poliza AND Empresa = @Empresa
      
   IF NOT EXISTS(SELECT 1 FROM ContD WHERE Cuenta = @Cuenta AND ID = @ID)
     SET @Cuenta = NULL
      
  RETURN @Cuenta
END
GO

/******************************** fnMFAObtenerCuentaConcepto *************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMFAObtenerCuentaConcepto') DROP FUNCTION fnMFAObtenerCuentaConcepto
GO
CREATE FUNCTION fnMFAObtenerCuentaConcepto 
	(
		   @Modulo						varchar(5),
		   @Mov							varchar(20),
		   @Categoria					varchar(50),
		   @Grupo						varchar(50),
		   @Familia						varchar(50),
		   @Concepto					varchar(50),
		   @ConceptoTipo				varchar(20),
		   @Empresa						varchar(5),
		   @Poliza						varchar(20),
		   @PolizaID					varchar(20)		   		   		   
	)
RETURNS varchar(20)			   
AS BEGIN  
  DECLARE
    @Cuenta			varchar(20),
    @ID				int
  
  DECLARE @MFATipoCtaConcepto TABLE (
    Modulo				varchar(5) COLLATE DATABASE_DEFAULT NULL,
    ModuloCalif			int NULL DEFAULT 0,
    Mov					varchar(20) COLLATE DATABASE_DEFAULT NULL,
    MovCalif			int NULL DEFAULT 0,
    Categoria			varchar(50) COLLATE DATABASE_DEFAULT NULL,    
    CategoriaCalif		int NULL DEFAULT 0,
    Grupo				varchar(50) COLLATE DATABASE_DEFAULT NULL,        
    GrupoCalif			int NULL DEFAULT 0,
    Familia				varchar(50) COLLATE DATABASE_DEFAULT NULL,            
    FamiliaCalif		int NULL DEFAULT 0,
    Concepto			varchar(50) COLLATE DATABASE_DEFAULT NULL,                
    ConceptoCalif		int NULL DEFAULT 0,
    ConceptoTipo		varchar(50) COLLATE DATABASE_DEFAULT NULL,
    ConceptoTipoCalif	int NULL DEFAULT 0,
    CalificacionTotal   int NULL DEFAULT 0,
    Cuenta				varchar(20) COLLATE DATABASE_DEFAULT NULL
  )  
  
  INSERT @MFATipoCtaConcepto (Modulo, Mov, Categoria, Grupo, Familia, Concepto, ConceptoTipo)
                      SELECT  Modulo, Mov, Categoria, Grupo, Familia, Concepto, ConceptoTipo
                        FROM  MFATipoCtaConcepto

  UPDATE @MFATipoCtaConcepto
     SET 
     ModuloCalif      = CASE 
                          WHEN Modulo = @Modulo   THEN 2
                          WHEN Modulo = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     MovCalif         = CASE 
                          WHEN Mov = @Mov      THEN 2
                          WHEN Mov = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     CategoriaCalif   = CASE 
                          WHEN Categoria = @Categoria THEN 2
                          WHEN Categoria = '(Todos)'  THEN 1
                          ELSE 0                        
                        END,
     GrupoCalif       = CASE 
                          WHEN Grupo = @Grupo    THEN 2
                          WHEN Grupo = '(Todos)' THEN 1
                          ELSE 0                    
                        END,
     FamiliaCalif     = CASE 
                          WHEN Familia = @Familia  THEN 2
                          WHEN Familia = '(Todos)' THEN 1
                          ELSE 0                 
                        END,
     ConceptoCalif    = CASE 
                          WHEN Concepto = @Concepto  THEN 2
                          WHEN Concepto = '(Todos)' THEN 1
                          ELSE 0
                        END,
     ConceptoTipoCalif = CASE 
                          WHEN ConceptoTipo = @ConceptoTipo  THEN 2
                          ELSE 0
                        END
                      
   UPDATE @MFATipoCtaConcepto 
      SET CalificacionTotal = ModuloCalif + MovCalif + CategoriaCalif + GrupoCalif + FamiliaCalif + ConceptoCalif + ConceptoTipoCalif                  
        
   SELECT 
      TOP 1 @Cuenta = Cuenta 
     FROM @MFATipoCtaConcepto 
    WHERE CalificacionTotal = (SELECT MAX(CalificacionTotal) FROM @MFATipoCtaConcepto
                               WHERE ModuloCalif <> 0
                                 AND MovCalif <> 0
                                 AND CategoriaCalif <> 0
                                 AND GrupoCalif <> 0
                                 AND FamiliaCalif <> 0
                                 AND ConceptoCalif <> 0
                                 AND ConceptoTipoCalif <> 0)

   
   SELECT @ID = ID FROM Cont WHERE MovID = @PolizaID AND Mov = @Poliza AND Empresa = @Empresa
      
   IF NOT EXISTS(SELECT 1 FROM ContD WHERE Cuenta = @Cuenta AND ID = @ID)
     SET @Cuenta = NULL
      
  RETURN @Cuenta
END
GO

/******************************** fnMFAObtenerCuentaImpuesto *************************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMFAObtenerCuentaImpuesto') DROP FUNCTION fnMFAObtenerCuentaImpuesto
GO
CREATE FUNCTION fnMFAObtenerCuentaImpuesto 
	(
		   @Modulo						varchar(5),
		   @Mov							varchar(20),
		   @ImpuestoTasa					float,
		   @ImpuestoTipo				varchar(20),
		   @Empresa						varchar(5),
		   @Poliza						varchar(20),
		   @PolizaID					varchar(20)		   		   		   
	)
RETURNS varchar(20)			   
AS BEGIN  
  DECLARE
    @Cuenta			varchar(20),
    @ID				int
  --select * from mfatipoCtaImpuesto
  DECLARE @MFATipoCtaImpuesto TABLE (
    Modulo				varchar(5) COLLATE DATABASE_DEFAULT NULL,
    ModuloCalif			int NULL DEFAULT 0,
    Mov					varchar(20) COLLATE DATABASE_DEFAULT NULL,
    MovCalif			int NULL DEFAULT 0,
    Minimo				int NULL DEFAULT 0,
    Maximo				int NULL DEFAULT 0,
    ImpuestoCalif		int NULL DEFAULT 0,
    ImpuestoTipo		varchar(20) COLLATE DATABASE_DEFAULT NULL,
    ImpuestoTipoCalif	int NULL DEFAULT 0,
    CalificacionTotal   int NULL DEFAULT 0,
    Cuenta				varchar(20) COLLATE DATABASE_DEFAULT NULL
  )  
  
  INSERT @MFATipoCtaImpuesto (Modulo, Mov, Minimo, Maximo, ImpuestoTipo)
                      SELECT  Modulo, Mov, Minimo, Maximo, ImpuestoTipo
                        FROM  MFATipoCtaImpuesto
                       WHERE  ImpuestoTipo = @ImpuestoTipo 

  UPDATE @MFATipoCtaImpuesto
     SET 
     ModuloCalif      = CASE 
                          WHEN Modulo = @Modulo   THEN 2
                          WHEN Modulo = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     MovCalif         = CASE 
                          WHEN Mov = @Mov      THEN 2
                          WHEN Mov = '(Todos)' THEN 1
                          ELSE 0                     
                        END,
     ImpuestoCalif    = CASE 
                          WHEN @ImpuestoTasa BETWEEN Minimo AND Maximo THEN 2
                          ELSE 0
                        END,
     ImpuestoTipoCalif = CASE 
                          WHEN ImpuestoTipo = @ImpuestoTipo  THEN 2
                          ELSE 0
                        END
                      
   UPDATE @MFATipoCtaImpuesto 
      SET CalificacionTotal = ModuloCalif + MovCalif + ImpuestoCalif + ImpuestoTipoCalif                  
        
   SELECT 
      TOP 1 @Cuenta = Cuenta 
     FROM @MFATipoCtaImpuesto 
    WHERE CalificacionTotal = (SELECT MAX(CalificacionTotal) FROM @MFATipoCtaImpuesto
                                WHERE ModuloCalif <> 0
                                  AND MovCalif <> 0
                                  AND ImpuestoCalif <> 0
                                  AND ImpuestoTipoCalif <> 0)

   
   SELECT @ID = ID FROM Cont WHERE MovID = @PolizaID AND Mov = @Poliza AND Empresa = @Empresa
      
   IF NOT EXISTS(SELECT 1 FROM ContD WHERE Cuenta = @Cuenta AND ID = @ID)
     SET @Cuenta = NULL
      
  RETURN @Cuenta
END
GO

--REQ16752
/**************** fnMovEnReferencia ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMovEnReferencia') drop function dbo.fnMovEnReferencia
GO
CREATE FUNCTION fnMovEnReferencia(
				@Referencia			varchar(50)
				)
RETURNS varchar(20)
AS
BEGIN
  DECLARE @Valor			varchar(20),
		  @Posicion			int,
		  @PosicionNueva	int

  SELECT @Posicion = 0

  WHILE(1=1)
  BEGIN
    SELECT @PosicionNueva = CHARINDEX(' ', @Referencia, @Posicion)
    
    IF @PosicionNueva <> 0
      SELECT @Posicion = @PosicionNueva + 1
    ELSE
      BREAK
  END

  SELECT @Valor = RTRIM(SUBSTRING(@Referencia, 1, @Posicion - 1))

  RETURN @Valor
END
GO

--REQ16752
/**************** fnMFATablaExcepcion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFATablaExcepcion') drop function dbo.fnMFATablaExcepcion
GO
CREATE FUNCTION fnMFATablaExcepcion(
				@origen_vista				varchar(255),
				@aplicacion_MovTipo			varchar(20)
				)
RETURNS varchar(255)
AS
BEGIN
  DECLARE @Valor		varchar(255)

  IF ISNULL(@origen_vista, '')  = ''
  BEGIN
    IF @aplicacion_MovTipo IN('CXC.ANC','CXC.ACA','CXC.AV','CXC.AE') 
      SELECT @origen_vista = 'MFACxcAplicacionCalc'
    ELSE IF @aplicacion_MovTipo IN('CXC.C','CXC.DP','CXC.NCP') 
      SELECT @origen_vista = 'MFACxcCobroCalc'
    ELSE IF @aplicacion_MovTipo IN('CXC.FAC') 
      SELECT @origen_vista = 'MFACxcEndosoCalc'
    ELSE IF @aplicacion_MovTipo IN('CXC.DC') 
      SELECT @origen_vista = 'MFACxcPagoCalc'
    ELSE IF @aplicacion_MovTipo IN('CR.C') 
      SELECT @origen_vista = 'MFACrCobroCalc'
    ELSE IF @aplicacion_MovTipo IN('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE') 
      SELECT @origen_vista = 'MFACxcDineroCalc'
    ELSE IF @aplicacion_MovTipo IN('CXC.D','CXC.DA','CXC.DOCMON') 
      SELECT @origen_vista = 'MFACxcRedocumentacionCalc'
    ELSE IF @aplicacion_MovTipo IN('CXP.ACA','CXP.AE','CXP.ANC') 
      SELECT @origen_vista = 'MFACxpAplicacionCalc'
    ELSE IF @aplicacion_MovTipo IN('CXP.DC') 
      SELECT @origen_vista = 'MFACxpCobroCalc'
    ELSE IF @aplicacion_MovTipo IN('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE') 
      SELECT @origen_vista = 'MFACxpDineroCalc'
    ELSE IF @aplicacion_MovTipo IN('CXP.FAC') 
      SELECT @origen_vista = 'MFACxpEndosoCalc'
    ELSE IF @aplicacion_MovTipo IN('CXP.P','CXP.NCP','CXP.DP') 
      SELECT @origen_vista = 'MFACxpPagoCalc'
    ELSE IF @aplicacion_MovTipo IN('CXP.D','CXP.DA') 
      SELECT @origen_vista = 'MFACxpRedocumentacionCalc'
    ELSE IF @aplicacion_MovTipo IN('GAS.G', 'GAS.DC') 
      SELECT @origen_vista = 'MFAGastoDineroPagoCalc'
    ELSE IF @aplicacion_MovTipo IN('GAS.C') 
      SELECT @origen_vista = 'MFAGastoPagoCalc'  
  END

  IF @origen_vista = 'MFACompraCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACompraPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACrCobroCalc' SELECT @Valor = 'MovTipoMFARedocExcepcion'
  ELSE IF @origen_vista = 'MFACxcAplicacionCalc' SELECT @Valor = 'MovTipoMFAAplicaExcepcion'
  ELSE IF @origen_vista = 'MFACxcCobroCalc' SELECT @Valor = 'MovTipoMFACobroPagoExcepcion'
  ELSE IF @origen_vista = 'MFACxcDineroCalc' SELECT @Valor = 'MovTipoMFAAplicaExcepcion'
  ELSE IF @origen_vista = 'MFACxcDocumentoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACxcDocumentoPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACxcEndosoCalc' SELECT @Valor = 'MovTipoMFAEndosoExcepcion'
  ELSE IF @origen_vista = 'MFACxcRedocumentacionCalc' SELECT @Valor = 'MovTipoMFARedocExcepcion'
  ELSE IF @origen_vista = 'MFACxpAplicacionCalc' SELECT @Valor = 'MovTipoMFAAplicaExcepcion'
  ELSE IF @origen_vista = 'MFACxpCobroCalc' SELECT @Valor = 'MovTipoMFACobroPagoExcepcion'
  ELSE IF @origen_vista = 'MFACxpDineroCalc' SELECT @Valor = 'MovTipoMFAAplicaExcepcion'
  ELSE IF @origen_vista = 'MFACxpDocumentoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACxpDocumentoPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACxpEndosoCalc' SELECT @Valor = 'MovTipoMFAEndosoExcepcion'
  ELSE IF @origen_vista = 'MFACxpPagoCalc' SELECT @Valor = 'MovTipoMFACobroPagoExcepcion'
  ELSE IF @origen_vista = 'MFACxpRedocumentacionCalc' SELECT @Valor = 'MovTipoMFARedocExcepcion'
  ELSE IF @origen_vista = 'MFADocumentoInicialCalc' SELECT @Valor = ''
  ELSE IF @origen_vista = 'MFAGastoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAGastoCxcPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAGastoCxpPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAGastoDineroPagoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAGastoDineroPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAGastoPagoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFALayoutAplicacionCalc' SELECT @Valor = ''
  ELSE IF @origen_vista = 'MFALayoutDocCalc' SELECT @Valor = ''
  ELSE IF @origen_vista = 'MFANominaCxpDocumentoCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFANominaCxpDocumentoPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFANotaCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAVentaCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFAVentaPendienteCalc' SELECT @Valor = 'MovTipoMFADocExcepcion'
  ELSE IF @origen_vista = 'MFACxcPagoCalc' SELECT @Valor = 'MovTipoMFACobroPagoExcepcion'
  
  RETURN @Valor
END
GO

--BUG18599
/**************** fnCxcFormaPagoEsDineroAnticipado ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCxcFormaPagoEsDineroAnticipado') drop function dbo.fnCxcFormaPagoEsDineroAnticipado
GO
CREATE FUNCTION fnCxcFormaPagoEsDineroAnticipado (@ID		int)
RETURNS bit
--WITH ENCRYPTION
AS BEGIN
  DECLARE @FormaPago		varchar(50),
		  @FormaPago1		varchar(50),
		  @Valor			bit

  SELECT @FormaPago = FormaCobro, @FormaPago1 = FormaCobro1 FROM Cxc WHERE ID = @ID
  
  IF EXISTS(SELECT MovTipo.Clave
              FROM MovTipo
              JOIN FormaPago ON FormaPago.MovIngresos = MovTipo.Mov AND MovTipo.Modulo = 'DIN'
             WHERE MovTipo.Clave IN('DIN.DA')
               AND FormaPago.FormaPago IN(@FormaPago, @FormaPago1))
    SELECT @Valor = 1
  ELSE
    SELECT @Valor = 0

  RETURN @Valor 
END
GO

/**************** fnCxpDocumentoPreCalc2ImporteTotal ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCxpDocumentoPreCalc2ImporteTotal') drop function dbo.fnCxpDocumentoPreCalc2ImporteTotal
GO
CREATE FUNCTION fnCxpDocumentoPreCalc2ImporteTotal(@ImporteO float, @ImpuestosO float, @RetencionO float)
RETURNS float
AS
BEGIN
  DECLARE @ImporteTotal	float
  
  SELECT @ImporteTotal = ISNULL(@ImporteO, 0) + ISNULL(@ImpuestosO, 0) - ISNULL(@RetencionO, 0)
  
  RETURN @ImporteTotal 
END
GO

/**************** fnCxpDocumentoPreCalc2Prorrateo ****************/
if exists (select * FROM sysobjects WHERE name = 'fnCxpDocumentoPreCalc2Prorrateo') drop function dbo.fnCxpDocumentoPreCalc2Prorrateo
GO
CREATE FUNCTION fnCxpDocumentoPreCalc2Prorrateo(@ImporteO float, @ImpuestosO float, @RetencionO float, @ImporteD float)
RETURNS float
AS
BEGIN
  DECLARE @Valor		float,
		  @ImporteTotal	float
  
  SELECT @ImporteTotal = ISNULL(@ImporteO, 0) + ISNULL(@ImpuestosO, 0) - ISNULL(@RetencionO, 0)
  
  SELECT @Valor = ((@ImporteD*100.0)/@ImporteTotal)/100.0

  RETURN @Valor
END
GO

--BUG22370
/**************** fmMFAAcumulableDeducibleCOMSEI ****************/
if exists (select * FROM sysobjects WHERE name = 'fmMFAAcumulableDeducibleCOMSEI') drop function dbo.fmMFAAcumulableDeducibleCOMSEI
GO
--BUG24040
CREATE FUNCTION fmMFAAcumulableDeducibleCOMSEI (@Concepto varchar(50), @Empresa varchar(5), @Mov varchar(20), @COMSIVAImportacionAnticipado bit)
RETURNS varchar(2)
AS
BEGIN
  DECLARE @EsImportacion		bit,
		  @EsIVAImportacion		bit,
		  @Valor				varchar(2),
		  @MovGastoDiverso		varchar(20),
		  @MovGasto				varchar(20)

  SELECT @MovGastoDiverso = CxpGastoDiverso, @MovGasto = Gasto FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @EsImportacion = ISNULL(EsImportacion, 0), @EsIVAImportacion = ISNULL(EsIVAImportacion, 0) FROM Concepto WHERE Concepto = @Concepto AND Modulo = 'COMSG'

  IF @Mov IN(@MovGastoDiverso, @MovGasto)
  BEGIN
    IF ISNULL(@COMSIVAImportacionAnticipado, 0) = 0
    BEGIN
      IF @EsImportacion = 0 AND @EsIVAImportacion = 0
        SELECT @Valor = 'Si'
      ELSE
        SELECT @Valor = 'No'
    END
    ELSE 
    BEGIN
      IF @EsImportacion = 0 AND @EsIVAImportacion = 1
        SELECT @Valor = 'Si'
      ELSE IF @EsImportacion = 0 AND @EsIVAImportacion = 0
        SELECT @Valor = 'Si'    
      ELSE
        SELECT @Valor = 'No'    
    END
  END
  ELSE
    SELECT @Valor = 'Si'
    
  RETURN @Valor
END
GO

SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
GO
/********************************  fnBuscadatosdinero  ********************************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnBuscadatosdinero') 
DROP FUNCTION fnBuscadatosdinero
GO
CREATE FUNCTION fnBuscadatosdinero (
                                     @Mov     varchar(25), 
									 @MovId   varchar(25),
									 @Empresa varchar(5),
									 @Filtro  int,
									 @CtaDinero varchar(10)
								   )
RETURNS varchar(100)
AS BEGIN
  DECLARE
    @Resultado	        varchar(20),
	@Fecha              datetime,
	@FechaConciliacion  datetime,
	@FechaConclusion    datetime,
	@TipoCambio			float,
	@Ejercicio			int,
	@Periodo			int

IF(@Filtro NOT IN (1,2,3,4,5,6))
BEGIN
	SET @Resultado = ''
END

IF(@Filtro = 1)
BEGIN
	SELECT @Fecha = FECHAEMISION
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId
	   AND D.Empresa = @Empresa
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = CONVERT(VARCHAR(25),@Fecha)
END
IF(@Filtro = 2)
BEGIN
	SELECT @TipoCambio = TipoCambio
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId	 
	   AND D.Empresa = @Empresa  
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = @TipoCambio
END
IF(@Filtro = 3)
BEGIN
	SELECT @Ejercicio = Ejercicio
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId	 
	   AND D.Empresa = @Empresa  
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = @Ejercicio
END
IF(@Filtro = 4)
BEGIN
	SELECT @Periodo = Periodo
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId	  
	   AND D.Empresa = @Empresa 
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = @Periodo
END
IF(@Filtro = 5)
BEGIN
	SELECT @FechaConciliacion = FechaConciliacion
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId	  
	   AND D.Empresa = @Empresa
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = CONVERT(VARCHAR(25),@FechaConciliacion)
END
IF(@Filtro = 6)
BEGIN
	SELECT @FechaConclusion = FechaConclusion
	  FROM DINERO D
	   JOIN MovTipo MT ON MT.Mov = D.Mov AND mt.Modulo = 'DIN'
	   JOIN MFAIrTesoreria T ON T.Movimiento = MT.Mov AND T.Clave = MT.Clave
	 WHERE D.MOV   = @Mov
	   AND D.MOVID = @MovId	  
	   AND D.Empresa = @Empresa 
	   AND D.CtaDinero = @CtaDinero

	SET @Resultado = CONVERT(VARCHAR(25),@FechaConclusion)
END


  IF(ISNULL(@Resultado,'') = '')	
	SET @Resultado = ''

  RETURN (@Resultado)
END
GO

/************************************************** Vistas **************************************************/
--BUG23996
/*** MFACxpChequeDevueltoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpChequeDevueltoPreCalc') and type = 'V') drop view dbo.MFACxpChequeDevueltoPreCalc
GO
CREATE VIEW MFACxpChequeDevueltoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = 'factura',
  subtipo_documento      = CONVERT(varchar(50),NULL),                         
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  iva_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,  
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,

  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),  
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov              
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('Cxp.CD'))
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

--BUG23996
/*** MFACxpChequeDevueltoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpChequeDevueltoCalc') and type = 'V') drop view dbo.MFACxpChequeDevueltoCalc
GO
CREATE VIEW MFACxpChequeDevueltoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,    
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad
FROM MFACxpChequeDevueltoPreCalc
GO

--BUG23996
/*** MFACxpChequeDevueltoPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpChequeDevueltoPagoCalc') and type = 'V') drop view dbo.MFACxpChequeDevueltoPagoCalc
GO
CREATE VIEW MFACxpChequeDevueltoPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),   
  --BUG18599 BUG22544
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXP.DP' THEN YEAR(c.FechaConclusion) ELSE c.Ejercicio         END ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXP.DP' THEN MONTH(c.FechaConclusion)ELSE c.Periodo           END ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXP.DP' THEN DAY(c.FechaConclusion)  ELSE DAY(c.FechaEmision) END ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460 BUG22544
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXP.DP' THEN c.FechaConclusion ELSE c.FechaEmision END ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG22759
  importe                = (c.Importe+ISNULL(c.Impuestos, 0))*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = 'nota_credito'
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXP' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP' AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXP' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('Cxp.CD'))
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))       
   AND c.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
GO

--BUG23996
/*** MFACxcChequeDevueltoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcChequeDevueltoPreCalc') and type = 'V') drop view dbo.MFACxcChequeDevueltoPreCalc
GO
CREATE VIEW MFACxcChequeDevueltoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = 'factura',
  subtipo_documento      = CONVERT(varchar(50),NULL),                         
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Cliente,
  entidad_nombre         = cl.Nombre,
  entidad_rfc            = cl.RFC,
  entidad_id_fiscal      = cl.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = cl.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = c.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  iva_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,  
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,

  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),  
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxc c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC' 
  JOIN Cte cl ON cl.Cliente = c.Cliente 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = cl.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = cl.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXC'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXC' AND mtmde.Mov = c.Mov              
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXC' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.CD'))
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXC'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

--BUG23996
/*** MFACxcChequeDevueltoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcChequeDevueltoCalc') and type = 'V') drop view dbo.MFACxcChequeDevueltoCalc
GO
CREATE VIEW MFACxcChequeDevueltoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,    
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad
FROM MFACxcChequeDevueltoPreCalc
GO

--BUG23996
/*** MFACxcChequeDevueltoCobroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcChequeDevueltoCobroCalc') and type = 'V') drop view dbo.MFACxcChequeDevueltoCobroCalc
GO
CREATE VIEW MFACxcChequeDevueltoCobroCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),   
  --BUG18599 BUG22544
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN YEAR(c.FechaConclusion) ELSE c.Ejercicio         END ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN MONTH(c.FechaConclusion)ELSE c.Periodo           END ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN DAY(c.FechaConclusion)  ELSE DAY(c.FechaEmision) END ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460 BUG22544
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN c.FechaConclusion ELSE c.FechaEmision END ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG22759
  importe                = (c.Importe+ISNULL(c.Impuestos, 0))*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = 'nota_credito'
  FROM Cxc c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXC' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC' AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXC' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.CD'))
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))       
   AND c.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
GO

--REQ23317
/*** MFAEmpresa ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAEmpresa') and type = 'V') drop view dbo.MFAEmpresa
GO
CREATE VIEW MFAEmpresa AS
  SELECT 
    em.Empresa							'id_empresa',
    ISNULL(em.Nombre, '')				'Nombre',
    ISNULL(em.Grupo, '')				'Grupo',    
    ISNULL(em.Direccion, '')			'Direccion',
    ISNULL(em.DireccionNumero, '')		'DireccionNumero',
    ISNULL(em.DireccionNumeroInt, '')	'DireccionNumeroInt',    
    ISNULL(em.Poblacion, '')			'Clave_ciudad',
    ISNULL(em.CodigoPostal, '')			'CodigoPostal',
    ISNULL(em.Telefonos, '')			'Telefonos',
    ISNULL(em.RFC, '')					'RFC',
    ISNULL(RegistroPatronal, '')		'RegistroPatronal'
    FROM EmpresaMFA e
    JOIN Empresa em ON e.Empresa = em.Empresa
GO

--REQ23317
/*** MFAContacto ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAContacto') and type = 'V') drop view dbo.MFAContacto
GO
CREATE VIEW MFAContacto AS
  SELECT 
    u.Usuario				'Clave',
	ISNULL(u.Nombre, '')	'Nombres',
	''						'Apellidos',
	''						'Puesto',
	ISNULL(u.Telefono, '')	'Telefono',
	ISNULL(u.eMail, '')		'eMail'
    FROM Usuario u
   WHERE Estatus = 'ALTA'
GO

--REQ23317
/*** MFACuentaContable ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACuentaContable') and type = 'V') drop view dbo.MFACuentaContable
GO
CREATE VIEW MFACuentaContable AS
  SELECT
    cuenta_contable				'Cuenta_contable',
    ISNULL(cuenta_control, '')	'Cuenta_control',
    ISNULL(nivel, '')			'Nivel',
    ISNULL(descripcion, '')		'Descripcion',
    CASE clase_cuenta WHEN 'control' THEN 'C' ELSE 'R' END 'Clase_cuenta',
    ISNULL(moneda, '')			'Moneda',
	''							'Cuenta_orden',
	1							'Estatus',
	empresa						'Empresa',
	EsComplementaria
  FROM layout_cuentas
GO

--REQ23317
/*** MFAPolizas ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAPolizas') and type = 'V') drop view dbo.MFAPolizas
GO
CREATE VIEW MFAPolizas AS
  SELECT
    c.Empresa						'Empresa', 
    cuenta							'Cuenta_contable', 
    c.Ejercicio						'ejercicio', 
	c.periodo						'Periodo', 
	DAY(c.FechaEmision)				'Dia', 
	RTRIM(c.Mov) +' '+RTRIM(c.MovID)'Poliza',
	CASE c.Mov WHEN 'Diario' THEN 'D' WHEN 'Egreso' THEN 'E' WHEN 'Ingreso' THEN 'I' ELSE 'D' END 'ID_poliza', 
	--ISNULL(ROUND(debe, 4), 0)		'debe', 
	--ISNULL(ROUND(haber, 4), 0)		'Haber', 
	ISNULL(debe, 0)										'debe', 
	ISNULL(haber, 0)									'Haber', 	
	--BUG24986
	ISNULL(c.OrigenMoneda, c.Moneda)					'Tipo_moneda', 
	ISNULL(c.OrigenTipoCambio, c.TipoCambio)			'Tipo_Cambio', 
	''													'ID_concepto', 
	''													'ID_recordatorio', 
	ISNULL(RTRIM(c.Origen) +' '+RTRIM(c.OrigenID), '')  'Referencia', 
	ISNULL(c.OrigenTipo, '')							'origen_modulo', 
	''													'Concepto'
  FROM Cont c
  JOIN ContD d ON c.ID = d.ID
  JOIN MovTipo ON c.Mov = MovTipo.Mov AND MovTipo.Modulo = 'CONT'
 WHERE d.Presupuesto = 0
   AND c.Estatus = 'CONCLUIDO'
 UNION ALL
  SELECT
    layout_polizas.Empresa			'Empresa', 
    cuenta_contable					'Cuenta_contable', 
    Ejercicio						'ejercicio', 
	periodo							'Periodo', 
	ISNULL(DAY(Fecha), 0)			'Dia', 
	''								'Poliza',
	'D'								'ID_poliza', 
	ISNULL(cargos, 0)				'debe', 
	ISNULL(abonos, 0)				'Haber', 	
	'1'								'Tipo_Cambio',
	--BUG24986
	EmpresaCfg.ContMoneda			'Tipo_moneda', 	
	''								'ID_concepto', 
	''								'ID_recordatorio', 
	''								'Referencia', 
	''								'origen_modulo', 
	''								'Concepto'
  FROM layout_polizas
  --BUG24986
  JOIN EmpresaCfg ON layout_polizas.Empresa = EmpresaCfg.Empresa
 WHERE EsComplementaria = 1
GO

--REQ23317
/*** MFASaldoInicial ***/
if exists (select * from sysobjects where id = object_id('dbo.MFASaldoInicial') and type = 'V') drop view dbo.MFASaldoInicial
GO
CREATE VIEW MFASaldoInicial AS
  --BUG25726
  SELECT Cuenta,
         ISNULL(EsAcreedora, 0) 'EsAcreedora'
    FROM Cta c
   WHERE UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA','AUXILIAR') 
GO

--REQ23317
/*** MFASaldoInicialComp ***/
if exists (select * from sysobjects where id = object_id('dbo.MFASaldoInicialComp') and type = 'V') drop view dbo.MFASaldoInicialComp
GO
CREATE VIEW MFASaldoInicialComp AS
  SELECT c.Cuenta,
         layout_cuentas.cuenta_contable,
         layout_cuentas.Moneda,
         saldo_inicial_cargos,
		 saldo_inicial_abonos
    FROM Cta c
    JOIN MFACuentaComplementaria ON c.Cuenta = MFACuentaComplementaria.Cuenta
    JOIN layout_cuentas ON c.Cuenta = layout_cuentas.cuenta_control
   WHERE UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA','AUXILIAR') 
     AND layout_cuentas.EsComplementaria = 1
GO

--BUG21567
/*** MFAContAux ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAContAux') and type = 'V') drop view dbo.MFAContAux
GO

/*** MFAEntidad ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAEntidad') and type = 'V') drop view dbo.MFAEntidad
GO
CREATE VIEW MFAEntidad AS
SELECT
  entidad_clave          = c.Cliente,
  entidad_nombre         = c.Nombre,
  entidad_tipo           = 'Cliente',
  entidad_rfc            = c.RFC,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = c.MFATipoOperacion                                                                 
  FROM Cte c 
  LEFT OUTER JOIN Pais pa ON pa.Clave = c.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = c.FiscalRegimen   
 WHERE c.Estatus IN ('ALTA')
UNION ALL
SELECT
  entidad_clave          = p.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_tipo           = 'Proveedor',
  entidad_rfc            = p.RFC,    
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion                                
  FROM Prov p 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais  
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
 WHERE p.Estatus IN ('ALTA') 
GO

--select * from fiscalregimen
--select * from MFAEntidad
/*** MFAEntidadOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAEntidadOpcional') and type = 'V') drop view dbo.MFAEntidadOpcional
GO
CREATE VIEW MFAEntidadOpcional AS
SELECT
  entidad_clave          = '(todos)',
  entidad_nombre         = '(todos)',
  entidad_tipo           = NULL,
  entidad_rfc            = NULL,    
  entidad_pais           = NULL,
  entidad_nacionalidad   = NULL,
  entidad_tipo_tercero   = NULL,
  entidad_tipo_operacion = NULL
UNION ALL
SELECT
  entidad_clave,
  entidad_nombre,
  entidad_tipo,
  entidad_rfc,    
  entidad_pais,
  entidad_nacionalidad,
  entidad_tipo_tercero,
  entidad_tipo_operacion
  FROM MFAEntidad
GO  

/*** MFAMovTipoOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAMovTipoOpcional') and type = 'V') drop view dbo.MFAMovTipoOpcional
GO
CREATE VIEW MFAMovTipoOpcional AS
SELECT
  Modulo       = CONVERT(varchar(10),'(todos)'),
  Mov          = '(todos)'
UNION ALL
SELECT
  Modulo = CONVERT(varchar(10),Modulo),
  Mov
  FROM MovTipo
GO  

--select * from MFAMovTipoOpcional

/*** MFACategoriaEntidadOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACategoriaEntidadOpcional') and type = 'V') drop view dbo.MFACategoriaEntidadOpcional
GO
CREATE VIEW MFACategoriaEntidadOpcional AS
SELECT
  Categoria    = '(todos)'
UNION
SELECT
  Categoria
  FROM CteCat
UNION
SELECT
  Categoria
  FROM ProvCat
GO  

--select * from mfacategoriaentidadopcional

/*** MFAFamiliaEntidadOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAFamiliaEntidadOpcional') and type = 'V') drop view dbo.MFAFamiliaEntidadOpcional
GO
CREATE VIEW MFAFamiliaEntidadOpcional AS
SELECT
  Familia    = '(todos)'
UNION
SELECT
  Familia
  FROM CteFam
UNION
SELECT
  Familia
  FROM ProvFam
GO  

--select * from mfafamiliaopcional

/*** MFAGrupoEntidadOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGrupoEntidadOpcional') and type = 'V') drop view dbo.MFAGrupoEntidadOpcional
GO
CREATE VIEW MFAGrupoEntidadOpcional AS
SELECT
  Grupo    = '(todos)'
UNION
SELECT
  Grupo
  FROM CteGrupo
GO  

--select grupo,* from cte
--select grupo,* from prov
--select * from mfagrupoopcional

--select * from mfamovtipoopcional                      
--SELECT * FROM MFAEntidadOpcional                                  
--select * from ctecat
--select * from provcat

/*** MFAConcepto ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAConcepto') and type = 'V') drop view dbo.MFAConcepto
GO
CREATE VIEW MFAConcepto AS
SELECT
  concepto_clave         = a.Articulo,
  concepto_descripcion   = a.Descripcion1,
  concepto_tipo          = 'Articulo'
  FROM Art a 
 WHERE a.Estatus IN ('ALTA')
UNION ALL
SELECT
  concepto_clave         = c.Concepto,
  concepto_descripcion   = c.Concepto,
  concepto_tipo          = 'Gastos'
  FROM Concepto c 
 WHERE c.Modulo = 'GAS'
GO

--REQ16748
/*** MFAConceptoGASCfg ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAConceptoGASCfg') and type = 'V') drop view dbo.MFAConceptoGASCfg
GO
CREATE VIEW MFAConceptoGASCfg AS
SELECT
  Modulo,
  Concepto,  
  EsImportacion,
  --BUG17795
  MFAEsDeducible,
  Clase,
  SubClase,
  Orden
  FROM Concepto
 WHERE Modulo = 'GAS'
GO

--BUG16901
/*** MFAConceptoCOMSG ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAConceptoCOMSG') and type = 'V') drop view dbo.MFAConceptoCOMSG
GO
CREATE VIEW MFAConceptoCOMSG AS
SELECT
  Clase,
  SubClase,
  Orden,
  Concepto, 
  EsImportacion,
  EsIVAImportacion
FROM 
  Concepto
WHERE Modulo = 'COMSG'
GO




--select * from MFAConcepto
/*** MFAConceptoOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAConceptoOpcional') and type = 'V') drop view dbo.MFAConceptoOpcional
GO
CREATE VIEW MFAConceptoOpcional AS
SELECT
  concepto_clave       = '(todos)',
  concepto_descripcion = NULL,
  concepto_tipo        = NULL
UNION ALL
SELECT
  concepto_clave,
  concepto_descripcion,
  concepto_tipo
  FROM MFAConcepto  
GO

--SELECT * FROM MFAConceptoOpcional

/*** MFACategoriaConceptoOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACategoriaConceptoOpcional') and type = 'V') drop view dbo.MFACategoriaConceptoOpcional
GO
CREATE VIEW MFACategoriaConceptoOpcional AS
SELECT
  Categoria    = '(todos)'
UNION
SELECT
  Categoria
  FROM ArtCat
GO  

--select * from mfacategoriaconceptoopcional

/*** MFAFamiliaConceptoOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAFamiliaConceptoOpcional') and type = 'V') drop view dbo.MFAFamiliaConceptoOpcional
GO
CREATE VIEW MFAFamiliaConceptoOpcional AS
SELECT
  Familia    = '(todos)'
UNION
SELECT
  Familia
  FROM ArtFam
GO  

--select * from mfafamiliaconceptoopcional

/*** MFAGrupoConceptoOpcional ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGrupoConceptoOpcional') and type = 'V') drop view dbo.MFAGrupoConceptoOpcional
GO
CREATE VIEW MFAGrupoConceptoOpcional AS
SELECT
  Grupo    = '(todos)'
UNION
SELECT
  Grupo
  FROM CteGrupo
GO  

--BUG19036
/*** MFAContLista ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAContLista') and type = 'V') drop view dbo.MFAContLista
GO
CREATE VIEW MFAContLista AS
SELECT
  Empresa,
  'CONT' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Cont
 WHERE Estatus IN ('CONCLUIDO') 
GO

/*** MFAMovimientoLista ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAMovimientoLista') and type = 'V') drop view dbo.MFAMovimientoLista
GO
CREATE VIEW MFAMovimientoLista AS
SELECT
  Empresa,
  'VTAS' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Venta
 WHERE Estatus IN ('CONCLUIDO','PENDIENTE') 
 UNION ALL
SELECT
  Empresa,
  'COMS' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Compra
 WHERE Estatus IN ('CONCLUIDO','PENDIENTE') 
 UNION ALL
SELECT
  Empresa,
  'GAS' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Gasto
 WHERE Estatus IN ('CONCLUIDO','PENDIENTE') 
 UNION ALL 
SELECT
  Empresa,
  'CXP' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Cxp
 WHERE Estatus IN ('CONCLUIDO','PENDIENTE') 
 UNION ALL 
SELECT
  Empresa,
  'CXC' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Cxc
 WHERE Estatus IN ('CONCLUIDO','PENDIENTE') 
 UNION ALL  
SELECT
  Empresa,
  'CR' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM CR
 WHERE Estatus IN ('CONCLUIDO') 
 UNION ALL  
 --REQ16670
SELECT
  Empresa,
  'DIN' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Dinero
 WHERE Estatus IN ('PENDIENTE', 'CONCLUIDO')  
 UNION ALL
 --BUG18077
SELECT
  Empresa,
  'NOM' Modulo,
  ID,
  Mov,
  MovID,
  Ejercicio,
  Periodo,
  --REQ16752
  RTRIM(Mov) + ' ' + RTRIM(MovID) 'Movimiento'
  FROM Nomina
 WHERE Estatus IN ('CONCLUIDO')   
GO  

--SELECT * FROM MOV
--select * from mfamovimiento

/*** MFALayoutDocumentoLista ***/
if exists (select * from sysobjects where id = object_id('dbo.MFALayoutDocumentoLista') and type = 'V') drop view dbo.MFALayoutDocumentoLista
GO
CREATE VIEW MFALayoutDocumentoLista AS
SELECT
  folio,
  fecha,
  empresa,
  emisor
  FROM MFALayoutDocumento
GO  

--SELECT * FROM MFALayoutDocumentoLista

--IEPS_PENDIENTE
/*** MFALayoutDocCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFALayoutDocCalc') and type = 'V') drop view dbo.MFALayoutDocCalc
GO
CREATE VIEW MFALayoutDocCalc AS
SELECT
  origen_tipo            = mld.origen_tipo,
  origen_modulo          = ISNULL(mld.origen_modulo,mld.origen_tipo),
  origen_id              = mld.origen_id,
  empresa                = mld.empresa,
  emisor                 = mld.emisor,
  tipo_documento         = mld.tipo_documento,
  subtipo_documento      = mld.subtipo_documento,
  folio                  = mld.folio,
  ejercicio              = YEAR(mld.fecha),
  periodo                = MONTH(mld.fecha),
  dia                    = DAY(mld.fecha),
  --BUG22460
  fecha					 = mld.fecha,
  entidad_clave          = mld.entidad_clave,
  entidad_nombre         = me.entidad_clave,
  entidad_rfc            = me.entidad_rfc,
  entidad_id_fiscal      = me.entidad_rfc,
  entidad_tipo_tercero   = me.entidad_tipo_tercero,
  entidad_tipo_operacion = me.entidad_tipo_operacion,
  entidad_pais           = me.entidad_pais,
  entidad_nacionalidad   = me.entidad_nacionalidad,
  agente_clave           = mld.agente_clave,
  agente_nombre          = a.Nombre,
  concepto               = mc.concepto_descripcion,
  acumulable_deducible   = mldd.acumulable_deducible,
  importe                = mldd.importe,
  retencion_isr          = mldd.retencion_isr, 
  retencion_iva          = mldd.retencion_iva,
  base_iva               = mldd.base_iva,
  iva_excento            = mldd.iva_excento,
  iva_tasa               = mldd.iva_tasa,
  iva                    = mldd.iva,
  base_ieps              = mldd.base_ieps,
  ieps_tasa              = mldd.ieps_tasa,  
  ieps                   = mldd.ieps,
  base_isan              = mldd.base_isan,
  isan                   = mldd.isan,
  ieps_num_reporte         = mldd.ieps_num_reporte,        
  ieps_categoria_concepto  = mldd.ieps_categoria_concepto, 
  ieps_exento              = mldd.ieps_exento,             
  ieps_envase_reutilizable = mldd.ieps_envase_reutilizable,
  ieps_retencion           = mldd.ieps_retencion,          
  ieps_cantidad            = mldd.ieps_cantidad,           
  ieps_unidad              = mldd.ieps_unidad,             
  ieps_cantidad2           = mldd.ieps_cantidad2,          
  ieps_unidad2             = mldd.ieps_unidad2,            
  importe_total            = mldd.importe_total,
  dinero				   = NULL,
  dinero_id				   = NULL,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = NULL  
  FROM MFALayoutDocumento mld
  JOIN MFALayoutDocumentoD mldd ON mldd.DocumentoID = mld.DocumentoID
  JOIN MFAEntidad me ON me.entidad_clave = mld.entidad_clave
  LEFT OUTER JOIN Agente a ON a.Agente = mld.agente_clave
  JOIN MFAConcepto mc ON mc.concepto_clave = mldd.concepto 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON mc.concepto_clave = mtmce.Concepto       
GO

--drop table mfalayoutaplicacion

/*** MFALayoutAplicacionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFALayoutAplicacionCalc') and type = 'V') drop view dbo.MFALayoutAplicacionCalc
GO
CREATE VIEW MFALayoutAplicacionCalc AS
SELECT
  origen_tipo            = mla.origen_tipo,
  --BUG17158
  origen_modulo          = mla.origen_modulo,
  origen_id              = mla.origen_id,
  empresa                = mla.empresa,
  tipo_aplicacion        = mla.tipo_aplicacion,
  folio                  = mla.folio,
  ejercicio              = YEAR(mla.fecha),
  periodo                = MONTH(mla.fecha),
  dia                    = DAY(mla.fecha),
  --BUG22460
  fecha					 = mla.fecha,
  Referencia             = mlad.referencia,
  importe                = mlad.importe,
  cuenta_bancaria        = mlad.cuenta_bancaria,
  --BUG16247
  aplica_ieps			 = mla.aplica_ieps,
  aplica_ietu			 = mla.aplica_ietu,
  aplica_iva			 = mla.aplica_iva,
  dinero				 = NULL,
  dinero_id				 = NULL,
  --BUG18767
  tipo_documento		 = NULL
  FROM MFALayoutAplicacion mla 
  JOIN MFALayoutAplicacionD mlad ON mlad.DocumentoID = mla.DocumentoID 
GO

--select * from mfalayoutaplicacioncalc

/*** MFADocumentoInicialCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADocumentoInicialCalc') and type = 'V') drop view dbo.MFADocumentoInicialCalc
GO
CREATE VIEW MFADocumentoInicialCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,0))),
  empresa                = e.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = 'factura',
  subtipo_documento      = 'enajenacion',
  folio                  = mdi.Descripcion,
  ejercicio              = em.EjercicioInicial,
  periodo                = em.PeriodoInicial,
  dia                    = 1,
  entidad_clave          = e.Empresa,
  entidad_nombre         = e.Nombre,
  entidad_rfc            = e.RFC,
  entidad_id_fiscal      = e.RFC,
  entidad_tipo_tercero   = 'nacional',
  entidad_tipo_operacion = 'otros',
  entidad_pais           = p.Pais,
  entidad_nacionalidad   = p.Nacionalidad,
  agente_clave           = 'N/A',
  agente_nombre          = 'N/A',
  concepto               = 'N/A',
  acumulable_deducible   = 'Si',
  importe                = 1.0,
  retencion_isr          = 0.0, 
  retencion_iva          = 0.0,
  base_iva               = 1.0,
  iva_excento            = 0.0,
  iva_tasa               = em.TasaImpuesto1Omision,
  iva                    = 1.0 * (em.TasaImpuesto1Omision/100.0),
  base_ieps              = 1.0,
  ieps_tasa              = 0.0,  
  ieps                   = 0.0,
  base_isan              = 0.0,
  isan                   = 0.0,
  importe_total          = 1.0 + (1.0 * (ISNULL(em.TasaImpuesto1Omision,0.0)/100.0)),
  ieps_num_reporte         = CONVERT(varchar(20),null),
  ieps_categoria_concepto  = CONVERT(varchar(20),null),
  ieps_exento              = CONVERT(bit,0),
  ieps_envase_reutilizable = CONVERT(bit,0),
  ieps_retencion           = CONVERT(float,0.0), 
  ieps_cantidad            = CONVERT(float,0.0), 
  ieps_unidad              = CONVERT(varchar(50),0.0), 
  ieps_cantidad2           = CONVERT(float,0.0), 
  ieps_unidad2             = CONVERT(varchar(50),0.0),
  dinero				   = CONVERT(varchar(20), NULL),
  dinero_id				   = CONVERT(varchar(20), NULL),
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL, 
  TipoActividad			   = NULL
  FROM Empresa e 
  JOIN EmpresaMFA em ON em.Empresa = e.Empresa
  JOIN MFADocumentosIniciales mdi ON 1 = 1
  LEFT OUTER JOIN Pais pa ON pa.Clave = e.Pais
  LEFT OUTER JOIN MFAPais p ON p.Pais = pa.Pais 
GO
--select * FROM MFADocumentoInicialCalc

/*** MFAVentaDpreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaDpreCalc') and type = 'V') drop view dbo.MFAVentaDpreCalc
GO
--BUG22277
CREATE VIEW MFAVentaDpreCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.ID,
  d.Renglon,
  d.RenglonSub,
  d.Precio,
  d.PrecioTipoCambio,
  d.DescuentoLinea,
  v.RedondeoMonetarios,
  "CantidadSinObsequios" = Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0),
  "Impuesto1Base" = Impuesto1,
  "Impuesto2Base" = CASE WHEN v.Impuesto2Info=1 THEN 0.0 ELSE Impuesto2 END,
  "Impuesto3Base" = CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END,
  "Impuesto2BaseImpuesto1" = CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END,
  "preImporte"          = convert(float, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio)-ISNULL(case when DescuentoTipo='$' then DescuentoLinea else (Cantidad-ISNULL(CantidadCancelada, 0.0)-ISNULL(CantidadObsequio, 0.0))*Precio*(DescuentoLinea/100.0) end, 0.0), v.RedondeoMonetarios)),
  --BUG16644
  Retencion2BaseImpuesto1,
  d.AnticipoFacturado,
  "ImpuestosImporte"    = convert(float, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*ISNULL(CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END, 0.0), ISNULL(v.RedondeoMonetarios,0))),
  d.Retencion1,
  d.Retencion2,
  "ImpuestosPorcentaje" = convert(float, round((CASE WHEN v.Impuesto2Info=0 THEN ISNULL(Impuesto2,0.0) ELSE 0.0 END)+(ISNULL(Impuesto1, 0.0)*(1.0+((CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE ISNULL(Impuesto2,0.0) END)/100))), 10.0))
FROM
  VentaD d
JOIN Version v ON 1 = 1
GO

--SELECT * FROM MFAVentaDpreCalc
/*** MFAVentaDpreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaDpreCalc2') and type = 'V') drop view dbo.MFAVentaDpreCalc2
GO
--BUG22277
CREATE VIEW MFAVentaDpreCalc2
--//WITH ENCRYPTION
AS 
SELECT 
  d.ID,
  d.Renglon,
  d.RenglonSub,
  d.Impuesto3Base,
  d.Impuesto2Base,
  d.Impuesto1Base,
  d.Impuesto2BaseImpuesto1,
  d.RedondeoMonetarios,
  --BUG16644
  d.Retencion2BaseImpuesto1,
  "preImporte2" = CASE 
                    WHEN cfg.VentaPrecioMoneda = 1 THEN preImporte*PrecioTipoCambio/v.TipoCambio
                    ELSE preImporte
                  END,
  "DescuentoLineal" = CASE
                    WHEN cfg.VentaPrecioMoneda = 1 THEN CantidadSinObsequios*Precio*PrecioTipoCambio/v.TipoCambio*(DescuentoLinea/100.0)
                    ELSE CantidadSinObsequios*Precio*(DescuentoLinea/100.0)
                  END,
  d.AnticipoFacturado,
  d.ImpuestosImporte,
  d.Retencion1,
  d.Retencion2,
  d.ImpuestosPorcentaje
FROM
  Venta v 
  JOIN MFAVentaDpreCalc d ON d.ID = v.ID
  JOIN EmpresaCfg cfg ON cfg.Empresa = v.Empresa
GO

/*** MFAVentaDCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaDCalc') and type = 'V') drop view dbo.MFAVentaDCalc
GO
--BUG22277
CREATE VIEW MFAVentaDCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.ID,
  d.Renglon,
  d.RenglonSub,
  d.Impuesto2Base,
  d.Impuesto1Base,
  d.Impuesto2BaseImpuesto1,  
  d.RedondeoMonetarios,
  --BUG16644
  d.Retencion2BaseImpuesto1,
  "Importe" = CASE 
				WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (preImporte2-ISNULL(d.Impuesto3Base,0.0))/ (1.0 + (ISNULL(d.Impuesto2Base, 0.0)/100) + ((ISNULL(d.Impuesto1Base,0.0)/100) * (1+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100))))
                ELSE preImporte2
              END,
  d.AnticipoFacturado,
  d.ImpuestosImporte,
  d.Retencion1,
  d.Retencion2,
  d.ImpuestosPorcentaje
FROM
  Venta v
  JOIN MFAVentaDpreCalc2 d ON d.ID = v.ID
  JOIN EmpresaCfg cfg ON cfg.Empresa = v.Empresa
GO

--select * from mfaventadcalc
/*** MFAVentaTCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaTCalc') and type = 'V') drop view dbo.MFAVentaTCalc
GO
--BUG22277
CREATE VIEW MFAVentaTCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.ID,
  v.Empresa,
  d.Renglon,
  d.RenglonSub,
  --BUG16644
  d.Retencion2BaseImpuesto1,
  d.Impuesto2BaseImpuesto1,
  d.RedondeoMonetarios,
  "SubTotal"               = Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), d.RedondeoMonetarios)),
  "Impuesto1Total"         = Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), d.RedondeoMonetarios)),
  "Impuesto2Total"         = Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(Impuesto2Base, 0.0)/100.0), d.RedondeoMonetarios)),
  dinero				   = v.Dinero,
  dinero_id				   = v.DineroID,
  "ImporteDescuentoGlobal" = convert(float, ROUND((d.Importe*(CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "DescuentosTotales" = (Convert(money, ROUND((v.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))+ISNULL(v.DescuentoLineal, 0.0)),
  "ImporteSobrePrecio"= (Convert(money, ROUND((v.Importe*ISNULL(v.SobrePrecio, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0)))),
  "Impuesto3Total"         = ISNULL(ImpuestosImporte, 0.0),
  "Retencion1Total"        = Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) *(ISNULL(d.Retencion1, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Retencion2Total"        = Convert(float, ROUND((CASE WHEN d.Retencion2BaseImpuesto1 = 0 THEN dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) ELSE Convert(float, ROUND(dbo.fnSubTotal(ISNULL(d.Importe,0.0), (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))) END) *(ISNULL(d.Retencion2, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  "Impuestos" 	           = ISNULL(ImpuestosImporte, 0.0) + Convert(float, ROUND(dbo.fnSubTotal(d.Importe, (CASE WHEN ISNULL(d.AnticipoFacturado, 0) = 0 THEN ISNULL(v.DescuentoGlobal,0.0) ELSE 0 END), v.SobrePrecio) * (ISNULL(ImpuestosPorcentaje, 0.0)/100.0), ISNULL(vs.RedondeoMonetarios,0))),
  v.Retencion,
  "ImporteTotal"      = Convert(money, ROUND(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) + ISNULL(v.Impuestos, 0.0), ISNULL(vs.RedondeoMonetarios,0))),
  "TotalNeto"         = Convert(money, ROUND(dbo.fnSubTotal(v.Importe, v.DescuentoGlobal, v.SobrePrecio) + ISNULL(v.Impuestos, 0.0) - ISNULL(v.AnticiposFacturados, 0.0) - ISNULL(v.Retencion, 0.0), ISNULL(vs.RedondeoMonetarios,0)))
FROM 
  Venta v
JOIN MFAVentaDCalc d ON d.ID = v.id  
JOIN Version vs ON 1=1
GO

/*** MFAVentaPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaPreCalc') and type = 'V') drop view dbo.MFAVentaPreCalc
GO
CREATE VIEW MFAVentaPreCalc AS
SELECT
  id                     = v.ID,
  concepto_clave         = vd.Articulo,
  origen_tipo            = 'auto',
  origen_modulo          = 'VTAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,v.ID))),
  empresa                = v.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('VTAS.F','VTAS.FX','VTAS.FAR','VTAS.FB','VTAS.FM','VTAS.N') THEN 'factura'
                             WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,                           
  subtipo_documento      = ISNULL(NULLIF(mmdtdea.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('VTAS.F','VTAS.FX','VTAS.FAR','VTAS.FB','VTAS.FM','VTAS.N') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             ELSE ''  
                           END),                         
  folio                  = RTRIM(ISNULL(cxc.Mov,'')) + ' ' + RTRIM(ISNULL(cxc.MovID,'')),
  ejercicio              = v.Ejercicio, --CAMBIAR A YEAR DE FECHA EMISION
  periodo                = v.Periodo,   --CAMBIAR A MONTH DE FECHA EMISION
  dia                    = DAY(v.FechaEmision),
  --BUG22460
  fecha					 = v.FechaEmision,
  entidad_clave          = v.Cliente,
  entidad_nombre         = c.Nombre,
  entidad_rfc            = c.RFC,
  entidad_id_fiscal      = c.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = c.MFATipoOperacion,
  entidad_pais           = p.Pais,
  entidad_nacionalidad   = p.Nacionalidad,
  agente_clave           = v.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = a.Descripcion1,
  acumulable_deducible   = 'Si',
  importe                = (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios)))*v.TipoCambio,
  retencion_isr          = 0.0,
  --BUG16644
  --retencion_iva          = dbo.fnMFARetencionIVA(vd.Articulo, a.Tipo, c.Pitex, vtc.Impuesto1Total, vtc.SubTotal)*v.TipoCambio,
  --retencion_iva          = (CASE --ARCNUEVO
  --                           WHEN RTRIM(UPPER(vd.Articulo)) = 'FLETE' AND RTRIM(UPPER(a.Tipo)) = 'SERVICIO' THEN ISNULL(vtc.SubTotal,0.0) * 0.04 ELSE 0.0
  --                         END +
  --                         CASE
  --                           WHEN NULLIF(c.Pitex,'') IS NOT NULL THEN vtc.Impuesto1Total ELSE 0.0
  --                         END) * v.TipoCambio,  
  retencion_iva          = CONVERT(float, (ROUND((CASE WHEN ver.Retencion2BaseImpuesto1 = 0 THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE Convert(float, ROUND((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) * (1.0+(ISNULL(ver.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), ver.RedondeoMonetarios) * v.TipoCambio)),
  base_iva               = (ISNULL((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END)*v.TipoCambio,
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  iva_tasa               = vd.Impuesto1,
  iva                    = ISNULL((Convert(float, ROUND(dbo.fnSubTotal(ISNULL(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END END,0.0), (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (1.0+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios))),0.0)*v.TipoCambio,
  base_ieps              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  --BUG23510
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END ELSE 0 END,  
  --BUG23510
  ieps                   = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio ELSE ISNULL(vd.Impuesto3, 0)*v.TipoCambio END,
  --ieps_tasa              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END,  
  --ieps                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio, 
  base_isan              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  isan                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio,  
  ieps_num_reporte         = ma.IEPSNumReporte,
  ieps_categoria_concepto  = ma.IEPSCategoriaConcepto,
  ieps_exento              = ma.IEPSExento,
  ieps_envase_reutilizable = ma.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  --BUG23510  
  ieps_cantidad            = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
  --BUG23510
  ieps_unidad              = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),
  --BUG23510  
  ieps_cantidad2           = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
  --BUG23510
  ieps_unidad2             = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),
  dinero				   = cxc.Dinero,
  dinero_id				   = cxc.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),  
  --BUG22156
  EsActivoFijo			   = CASE MFAArtAF.Articulo WHEN NULL THEN 0 ELSE 1 END, 
  TipoActivo			   = CASE MFAArtAF.Articulo WHEN NULL THEN NULL ELSE MFAActivoFCat.Tipo END,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxc cxc 
  JOIN Venta v ON v.MovID = cxc.OrigenID AND v.Mov = cxc.Origen AND cxc.OrigenTipo = 'VTAS' AND v.Empresa = cxc.Empresa
  JOIN MovTipo mt ON mt.Mov = v.Mov AND mt.Modulo = 'VTAS' 
  JOIN Cte c ON c.Cliente = v.Cliente 
  JOIN VentaD vd ON vd.ID = v.ID 
  --JOIN MFAVentaTCalc vtc ON vtc.ID = v.ID AND vtc.Renglon = vd.Renglon AND vtc.RenglonSub = vd.RenglonSub --ARC NUEVO
  JOIN Art a ON a.Articulo = vd.Articulo 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON a.Articulo = mtmce.Concepto
  JOIN EmpresaGral eg ON eg.Empresa = v.Empresa
  --BUG22460
  JOIN EmpresaCfg cfg ON cfg.Empresa = v.Empresa 
  JOIN EmpresaMFA em ON em.Empresa = v.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'VTAS' AND mme.ModuloID = v.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'VTAS' AND mtmde.Mov = v.Mov 
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'VTAS' AND mtmda.Mov = v.Mov
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionArt mmdtdea ON  ISNULL(NULLIF(mmdtdea.Articulo,''),a.Articulo) = a.Articulo AND mmdtdea.Mov = v.Mov AND mmdtdea.Modulo = 'VTAS'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = c.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = c.Pais
  LEFT OUTER JOIN MFAPais p ON p.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = v.Agente   
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  LEFT OUTER JOIN Unidad u ON u.Unidad = vd.Unidad
  --BUG23510
  LEFT OUTER JOIN Unidad u2 ON u2.Unidad = ma.UnidadBaseIEPS
  LEFT OUTER JOIN ArtUnidad au ON au.Articulo = a.Articulo AND au.Unidad = vd.Unidad
  LEFT OUTER JOIN ArtUnidad au2 ON au2.Articulo = a.Articulo AND au2.Unidad = ma.UnidadBaseIEPS
  --BUG22156
  LEFT OUTER JOIN MFAArtAF ON a.Articulo = MFAArtAF.Articulo
  LEFT OUTER JOIN MFAActivoFCat ON a.CategoriaActivoFijo = MFAActivoFCat.Categoria
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'VTAS' AND MFATipoActividad.Mov = v.Mov
 WHERE mtmde.Modulo IS NULL
   AND cxc.OrigenTipo = 'VTAS'
   AND mme.ModuloID IS NULL
   AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxc.Estatus IN ('CONCLUIDO','PENDIENTE')      
   AND (mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF','VTAS.F','VTAS.FX','VTAS.FAR','VTAS.FB') OR (mtmda.Modulo IS NOT NULL))
GO

--BUG22544
/*** MFAVentaContadoPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaContadoPagoCalc') and type = 'V') drop view dbo.MFAVentaContadoPagoCalc
GO
CREATE VIEW MFAVentaContadoPagoCalc AS
SELECT 
  origen_tipo            = 'auto',
  origen_modulo          = 'VTAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,v.ID))),
  empresa                = v.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
  folio                  = RTRIM(ISNULL(v.Mov,'')) + ' ' + RTRIM(ISNULL(v.MovID,'')),
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN v.Ejercicio ELSE YEAR(v.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN v.Periodo ELSE MONTH(v.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(v.FechaEmision) ELSE DAY(v.DineroFechaConciliacion) END,
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN v.FechaEmision ELSE v.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(v.Mov,'')) + ' ' + RTRIM(ISNULL(v.MovID,'')),
  --BUG24882
  --importe                = SUM(((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) /*ISNULL(importe,0.0)*/ + 
  --                           ISNULL((Convert(float, ROUND(dbo.fnSubTotal(ISNULL(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END END,0.0), (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (1.0+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) /*ISNULL(iva,0.0)*/ + 
  --                           CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END /*ISNULL(ieps,0.0)*/ + 
  --                           CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END /*ISNULL(isan,0.0)*/ - 
  --                           0.0 /*ISNULL(retencion_isr,0.0)*/ - 
  --                           CONVERT(float, ROUND((CASE WHEN ver.Retencion2BaseImpuesto1 = 0 THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE Convert(float, ROUND((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) * (1.0+(ISNULL(ver.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), ver.RedondeoMonetarios)) /*ISNULL(retencion_iva,0.0)*/
  --                         )*v.TipoCambio),
  importe                = v.Importe*v.TipoCambio,
  cuenta_bancaria        = v.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(v.DineroConciliado, 0),
  dinero				 = v.Dinero,
  dinero_id				 = v.DineroID,
  tipo_documento		 = mtmpa.tipo_documento
  FROM Venta v 
  JOIN MovTipo mt ON mt.Mov = v.Mov AND mt.Modulo = 'VTAS' 
  --BUG24882
  --LEFT OUTER JOIN Cxc ON Cxc.OrigenTipo = 'VTAS' AND Cxc.Origen = v.Mov AND Cxc.OrigenID = v.MovID AND Cxc.Empresa = v.Empresa
  --LEFT OUTER JOIN MovTipo mt2 ON mt2.Mov = Cxc.Mov AND mt2.Modulo = 'CXC' AND mt2.Clave = 'CXC.F'
  --JOIN VentaD vd ON v.ID = vd.ID
  JOIN Cte c ON c.Cliente = v.Cliente 
  JOIN EmpresaMFA em ON em.Empresa = v.Empresa
  --BUG24882
  --JOIN EmpresaCfg cfg ON cfg.Empresa = em.Empresa
  --JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'VTAS' AND mme.ModuloID = v.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'VTAS' AND mtmde.Mov = v.Mov 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = c.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = c.Pais
  LEFT OUTER JOIN MFAPais p ON p.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = v.Agente   
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'VTAS' AND MFATipoActividad.Mov = v.Mov
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'VTAS' AND mtmac.Mov = v.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(v.OrigenTipo,'')) = ISNULL(v.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(v.Origen,'')) = ISNULL(v.Origen,'')  
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'VTAS' AND mtdc.Mov = v.Mov  
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'VTAS' AND mtmree.Mov = v.Mov           
  LEFT OUTER JOIN MovTipoMFAPagoAdicion mtmpa ON mtmpa.Modulo = 'VTAS' AND mtmpa.Mov = v.Mov AND ISNULL(NULLIF(mtmpa.OrigenTipo,''),ISNULL(v.OrigenTipo, '')) = ISNULL(v.OrigenTipo,'') AND ISNULL(NULLIF(mtmpa.Origen,''),ISNULL(v.Origen, '')) = ISNULL(v.Origen,'')
 WHERE mtmde.Modulo IS NULL
   AND mme.ModuloID IS NULL
   AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND mt.Clave IN ('VTAS.F')
   --BUG24882
   AND NOT EXISTS(SELECT ID FROM Cxc WHERE Mov = v.Mov AND MovID = v.MovID AND Empresa = v.Empresa)
   --AND Cxc.ID IS NULL
   --AND mt2.Clave IS NULL      
  --GROUP BY v.ID, v.Empresa, mtmac.TipoAplicacion,v.Mov,v.MovID,mtdc.Mov, v.Ejercicio, v.DineroFechaConciliacion, v.Periodo, v.FechaEmision, v.DineroCtaDinero,mtmree.AplicaIetu,mtmree.AplicaIeps,mtmree.AplicaIVA,v.DineroConciliado,v.Dinero,v.DineroID,mtmpa.tipo_documento
GO

--BUG22544
/*** MFAVentaPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaPreCalc2') and type = 'V') drop view dbo.MFAVentaPreCalc2
GO
CREATE VIEW MFAVentaPreCalc2 AS
SELECT
  id                     = v.ID,
  concepto_clave         = vd.Articulo,
  --REQ16748
  concepto_es_importacion= 0,
  origen_tipo            = 'auto',
  origen_modulo          = 'VTAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,v.ID))),
  empresa                = v.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('VTAS.F','VTAS.FX','VTAS.FAR','VTAS.FB','VTAS.FM','VTAS.N') THEN 'factura'
                             WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF') THEN 'nota_credito'
                           END,                           
  subtipo_documento      = ISNULL(NULLIF(mmdtdea.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('VTAS.F','VTAS.FX','VTAS.FAR','VTAS.FB','VTAS.FM','VTAS.N') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             WHEN mt.Clave IN ('VTAS.B','VTAS.D','VTAS.DF') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             ELSE ''  
                           END),                         
  folio                  = RTRIM(ISNULL(v.Mov,'')) + ' ' + RTRIM(ISNULL(v.MovID,'')),
  ejercicio              = v.Ejercicio, --CAMBIAR A YEAR DE FECHA EMISION
  periodo                = v.Periodo,   --CAMBIAR A MONTH DE FECHA EMISION
  dia                    = DAY(v.FechaEmision),
  --BUG22460
  fecha					 = v.FechaEmision,
  entidad_clave          = v.Cliente,
  entidad_nombre         = c.Nombre,
  entidad_rfc            = c.RFC,
  entidad_id_fiscal      = c.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = c.MFATipoOperacion,
  entidad_pais           = p.Pais,
  entidad_nacionalidad   = p.Nacionalidad,
  agente_clave           = v.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = a.Descripcion1,
  acumulable_deducible   = 'Si',
  importe                = (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios)))*v.TipoCambio,
  --importe                = vtc.SubTotal*v.TipoCambio,
  retencion_isr          = 0.0, 
  --BUG16644
  ----retencion_iva          = dbo.fnMFARetencionIVA(vd.Articulo, a.Tipo, c.Pitex, vtc.Impuesto1Total, vtc.SubTotal)*v.TipoCambio,
  --retencion_iva          = (CASE --ARCNUEVO
  --                           WHEN RTRIM(UPPER(vd.Articulo)) = 'FLETE' AND RTRIM(UPPER(a.Tipo)) = 'SERVICIO' THEN ISNULL(vtc.SubTotal,0.0) * 0.04 ELSE 0.0
  --                         END +
  --                         CASE
  --                           WHEN NULLIF(c.Pitex,'') IS NOT NULL THEN vtc.Impuesto1Total ELSE 0.0
  --                         END) * v.TipoCambio,    
  retencion_iva          = CONVERT(float, ROUND((CASE WHEN ver.Retencion2BaseImpuesto1 = 0 THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE Convert(float, ROUND((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) * (1.0+(ISNULL(ver.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), ver.RedondeoMonetarios))*v.TipoCambio,
  --retencion_iva          = CONVERT(float, ROUND((CASE WHEN vtc.Retencion2BaseImpuesto1 = 0 THEN vtc.SubTotal ELSE Convert(float, ROUND(vtc.SubTotal * (1.0+(ISNULL(vtc.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), vtc.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), vtc.RedondeoMonetarios)),
  base_iva               = (ISNULL((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END)*v.TipoCambio,
  --base_iva               = (ISNULL(vtc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END)*v.TipoCambio,
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  iva_tasa               = vd.Impuesto1,
  iva                    = ISNULL((Convert(float, ROUND(dbo.fnSubTotal(ISNULL(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END END,0.0), (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (1.0+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios))),0.0)*v.TipoCambio,
  --iva                    = ISNULL(vtc.Impuesto1Total,0.0)*v.TipoCambio,
  base_ieps              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  --base_ieps              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vtc.Subtotal ELSE 0.0 END*v.TipoCambio,
  --BUG23510
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END ELSE 0 END,  
  --BUG23510
  ieps                   = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio ELSE ISNULL(vd.Impuesto3, 0)*v.TipoCambio END,
  --ieps_tasa              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END,  
  --ieps                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio,
  ----ieps                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END*v.TipoCambio,
  base_isan              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  --base_isan              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN vtc.Subtotal ELSE 0.0 END*v.TipoCambio,
  --isan                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END*v.TipoCambio,
  isan                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio,
  ieps_num_reporte         = ma.IEPSNumReporte,
  ieps_categoria_concepto  = ma.IEPSCategoriaConcepto,
  ieps_exento              = ma.IEPSExento,
  ieps_envase_reutilizable = ma.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad           = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
  --BUG23510
  ieps_unidad             = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),      
  ieps_cantidad2           = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
--BUG23510
  ieps_unidad2             = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),    
  dinero				   = v.Dinero,
  dinero_id				   = v.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = CASE MFAArtAF.Articulo WHEN NULL THEN 0 ELSE 1 END, 
  TipoActivo			   = CASE MFAArtAF.Articulo WHEN NULL THEN NULL ELSE MFAActivoFCat.Tipo END,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Venta v
  JOIN MovTipo mt ON mt.Mov = v.Mov AND mt.Modulo = 'VTAS'   
  --LEFT OUTER JOIN Cxc ON Cxc.OrigenTipo = 'VTAS' AND Cxc.Origen = v.Mov AND Cxc.OrigenID = v.MovID AND Cxc.Empresa = v.Empresa
  --LEFT OUTER JOIN MovTipo mt2 ON mt2.Mov = Cxc.Mov AND mt2.Modulo = 'CXC' AND mt2.Clave = 'CXC.F'
  JOIN Cte c ON c.Cliente = v.Cliente 
  JOIN VentaD vd ON vd.ID = v.ID 
  JOIN Art a ON a.Articulo = vd.Articulo 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON a.Articulo = mtmce.Concepto    
  JOIN EmpresaMFA em ON em.Empresa = v.Empresa
  --BUG22460
  JOIN EmpresaCfg cfg ON cfg.Empresa = em.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'VTAS' AND mme.ModuloID = v.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'VTAS' AND mtmde.Mov = v.Mov 
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionArt mmdtdea ON  ISNULL(NULLIF(mmdtdea.Articulo,''),a.Articulo) = a.Articulo AND mmdtdea.Mov = v.Mov AND mmdtdea.Modulo = 'VTAS'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = c.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = c.Pais
  LEFT OUTER JOIN MFAPais p ON p.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = v.Agente   
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  LEFT OUTER JOIN Unidad u ON u.Unidad = vd.Unidad
  --BUG23510
  LEFT OUTER JOIN Unidad u2 ON u2.Unidad = ma.UnidadBaseIEPS 
  LEFT OUTER JOIN ArtUnidad au ON au.Articulo = a.Articulo AND au.Unidad = vd.Unidad
  --BUG23510
  LEFT OUTER JOIN ArtUnidad au2 ON au2.Articulo = a.Articulo AND au2.Unidad = ma.UnidadBaseIEPS
  --BUG22156
  LEFT OUTER JOIN MFAArtAF ON a.Articulo = MFAArtAF.Articulo
  LEFT OUTER JOIN MFAActivoFCat ON a.CategoriaActivoFijo = MFAActivoFCat.Categoria    
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'VTAS' AND MFATipoActividad.Mov = v.Mov
 WHERE mtmde.Modulo IS NULL
   AND mme.ModuloID IS NULL
   AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND mt.Clave IN ('VTAS.F')
   AND NOT EXISTS(SELECT ID FROM Cxc WHERE Mov = v.Mov AND MovID = v.MovID AND Empresa = v.Empresa)   
   --AND Cxc.ID IS NULL
   --AND mt2.Clave IS NULL
GO

--select ieps_unidad2,* from layout_documentos where concepto like '%sake%'
--select unidad,* from VentaD where Articulo = '12002'
--SELECT * FROM MFAVentaPreCalc
--select * from mfaart
--select * from unidad
--select * from ArtUnidad where Articulo = '12002'

--BUG22544
/*** MFAVentaContadoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaContadoCalc') and type = 'V') drop view dbo.MFAVentaContadoCalc
GO
CREATE VIEW MFAVentaContadoCalc AS
SELECT 
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion = 0,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,  
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG21156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad
FROM MFAVentaPreCalc2
GO

/*** MFAVentaCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaCalc') and type = 'V') drop view dbo.MFAVentaCalc
GO
CREATE VIEW MFAVentaCalc AS
SELECT 
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion = 0,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,  
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG21156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad
FROM MFAVentaPreCalc
GO

--SELECT * FROM MFAVentaCalc

/*** MFAVentaPendientePreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaPendientePreCalc') and type = 'V') drop view dbo.MFAVentaPendientePreCalc
GO
CREATE VIEW MFAVentaPendientePreCalc AS
SELECT 
  v.ID,
  c.Empresa,
  c.Origen,
  c.OrigenID,
  YEAR(v.FechaEmision) Ejercicio,
  MONTH(v.FechaEmision) Periodo
  FROM Cxc c 
  JOIN Venta v ON v.MovID = c.OrigenID AND v.Mov = c.Origen
 WHERE c.OrigenTipo = 'VTAS' 
   --AND c.Estatus = 'PENDIENTE'
   AND v.Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--SELECT * FROM MFAVentaPendientePreCalc
--select * from mfaventapendienteprecalc where origenid = 'can7050'
--select * from Venta where MovID = 'can7050'
--select Estatus,* from Cxc where MovID = 'can3505'
--select Estatus,* from Cxc where MovID = 'can7050'

--select * from mfaventapendienteprecalc

/*** MFAVentaPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaPendienteCalc') and type = 'V') drop view dbo.MFAVentaPendienteCalc
GO
CREATE VIEW MFAVentaPendienteCalc AS
SELECT 
  mvc.origen_tipo,
  mvc.origen_modulo,
  mvc.origen_id,
  mvc.empresa,
  mvc.emisor,
  mvc.tipo_documento,
  mvc.subtipo_documento,  
  mvc.folio,
  mvc.ejercicio,
  mvc.periodo,
  mvc.dia,
  --BUG22460
  mvc.fecha,
  mvc.entidad_clave,
  mvc.entidad_nombre,
  mvc.entidad_rfc,
  mvc.entidad_id_fiscal,
  mvc.entidad_tipo_tercero,
  mvc.entidad_tipo_operacion,
  mvc.entidad_pais,
  mvc.entidad_nacionalidad,
  mvc.agente_clave,
  mvc.agente_nombre,
  mvc.concepto,
  mvc.acumulable_deducible,
  mvc.importe,
  mvc.retencion_isr,
  mvc.retencion_iva,
  mvc.base_iva,
  mvc.iva_excento,
  mvc.iva_tasa,
  mvc.iva, 
  mvc.base_ieps,
  mvc.ieps_tasa,
  mvc.ieps,
  mvc.base_isan,
  mvc.isan,
  mvc.ieps_num_reporte,
  mvc.ieps_categoria_concepto,
  mvc.ieps_exento,
  mvc.ieps_envase_reutilizable,
  mvc.ieps_retencion, 
  mvc.ieps_cantidad, 
  mvc.ieps_unidad, 
  mvc.ieps_cantidad2,
  mvc.ieps_unidad2,    
  mvc.importe_total,
  mvc.concepto_clave,
  --REQ16748
  mvc.concepto_es_importacion,
  mvc.dinero,
  mvc.dinero_id,
  --BUG20353
  mvc.concepto_aplica_ietu,
  mvc.concepto_aplica_ieps,
  mvc.concepto_aplica_iva,
  --BUG2156
  mvc.EsActivoFijo, 
  mvc.TipoActivo, 
  mvc.TipoActividad
  FROM MFAVentaCalc mvc
  JOIN MFAVentaPendientePreCalc mvppc ON mvppc.ID = mvc.ID  
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'VTAS' AND mme.ModuloID = mvc.ID
 WHERE mme.ModuloID IS NULL   
GO

--select * from mfaventapendientecalc where folio like '%can7050%'
--SELECT * FROM MFAVentaPendienteCalc

/*** MFANotaPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANotaPreCalc') and type = 'V') drop view dbo.MFANotaPreCalc
GO
CREATE VIEW MFANotaPreCalc AS
SELECT
  concepto_clave         = vd.Articulo,
  --REQ16748
  concepto_es_importacion= 0,
  origen_tipo            = 'auto',
  origen_modulo          = 'VTAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,v.ID))),
  empresa                = v.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('VTAS.FM','VTAS.N') THEN 'factura'
                             WHEN mt.Clave IN ('VTAS.B') THEN 'nota_credito'
                             WHEN mt.Clave IN ('VTAS.D','VTAS.DF') THEN 'devolucion'
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdea.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('VTAS.FM','VTAS.N') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             WHEN mt.Clave IN ('VTAS.B') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             WHEN mt.Clave IN ('VTAS.D') THEN 
                               (CASE WHEN a.Articulo NOT IN ('Servicio') THEN 'enajenacion' ELSE 'prestacion_servicios' END)
                             ELSE ''  
                           END),                                                    
  folio                  = RTRIM(ISNULL(v.Mov,'')) + ' ' + RTRIM(ISNULL(v.MovID,'')),
  ejercicio              = v.Ejercicio, --CAMBIAR A YEAR DE FECHA EMISION
  periodo                = v.Periodo,   --CAMBIAR A MONTH DE FECHA EMISION
  dia                    = DAY(v.FechaEmision),
  --BUG22460
  fecha					 = v.FechaEmision,
  entidad_clave          = v.Cliente,
  entidad_nombre         = c.Nombre,
  entidad_rfc            = c.RFC,
  entidad_id_fiscal      = c.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = c.MFATipoOperacion,
  entidad_pais           = p.Pais,
  entidad_nacionalidad   = p.Nacionalidad,
  agente_clave           = v.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = a.Descripcion1,
  acumulable_deducible   = 'Si',
  importe                = (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios)))*v.TipoCambio,
  --importe                = vtc.SubTotal*v.TipoCambio,
  retencion_isr          = 0.0, 
  --BUG16644
  ----retencion_iva          = dbo.fnMFARetencionIVA(vd.Articulo, a.Tipo, c.Pitex, vtc.Impuesto1Total, vtc.SubTotal)*v.TipoCambio,
  --retencion_iva          = (CASE --ARCNUEVO
  --                           WHEN RTRIM(UPPER(vd.Articulo)) = 'FLETE' AND RTRIM(UPPER(a.Tipo)) = 'SERVICIO' THEN ISNULL(vtc.SubTotal,0.0) * 0.04 ELSE 0.0
  --                         END +
  --                         CASE
  --                           WHEN NULLIF(c.Pitex,'') IS NOT NULL THEN vtc.Impuesto1Total ELSE 0.0
  --                         END) * v.TipoCambio,    
  retencion_iva          = CONVERT(float, ROUND((CASE WHEN ver.Retencion2BaseImpuesto1 = 0 THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE Convert(float, ROUND((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) * (1.0+(ISNULL(ver.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), ver.RedondeoMonetarios)),
  --retencion_iva          = CONVERT(float, ROUND((CASE WHEN vtc.Retencion2BaseImpuesto1 = 0 THEN vtc.SubTotal ELSE Convert(float, ROUND(vtc.SubTotal * (1.0+(ISNULL(vtc.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), vtc.RedondeoMonetarios)) END) *(ISNULL(vd.Retencion2, 0.0)/100.0), vtc.RedondeoMonetarios)),
  base_iva               = (ISNULL((CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END)*v.TipoCambio,
  --base_iva               = (ISNULL(vtc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END)*v.TipoCambio,
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  iva_tasa               = vd.Impuesto1,
  iva                    = ISNULL((Convert(float, ROUND(dbo.fnSubTotal(ISNULL(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END END,0.0), (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (1.0+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0))*(ISNULL(vd.Impuesto1, 0.0)/100.0), ver.RedondeoMonetarios))),0.0)*v.TipoCambio,
  --iva                    = ISNULL(vtc.Impuesto1Total,0.0)*v.TipoCambio,
  base_ieps              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  --base_ieps              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vtc.Subtotal ELSE 0.0 END*v.TipoCambio,
  --BUG23510
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END ELSE 0 END,  
  --BUG23510
  ieps                   = CASE ma.Impuesto WHEN 'Impuesto 2' THEN CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio ELSE ISNULL(vd.Impuesto3, 0)*v.TipoCambio END,
  --ieps_tasa              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN vd.Impuesto2 ELSE 0.0 END,  
  --ieps                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio,
  ----ieps                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('ieps') THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END*v.TipoCambio,
  base_isan              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN (CONVERT(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN CONVERT(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(CASE WHEN vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) END, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio), ver.RedondeoMonetarios))) ELSE 0.0 END*v.TipoCambio,
  --base_isan              = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN vtc.Subtotal ELSE 0.0 END*v.TipoCambio,
  --isan                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL(vtc.Impuesto2Total,0.0) ELSE 0.0 END*v.TipoCambio,
  isan                   = CASE WHEN ISNULL(em.Impuesto2,'') IN ('isan') THEN ISNULL((Convert(float, ROUND(dbo.fnSubTotal(CASE WHEN cfg.VentaPreciosImpuestoIncluido = 1 THEN (CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END-ISNULL(CASE WHEN ver.Impuesto3Info=1 THEN 0.0 ELSE vd.Impuesto3 END,0.0))/ (1.0 + (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100) + ((ISNULL(vd.Impuesto1,0.0)/100) * (1+(ISNULL(CASE WHEN ver.Impuesto2Info=1 OR ver.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100)))) ELSE CASE WHEN cfg.VentaPrecioMoneda = 1 THEN convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios))*vd.PrecioTipoCambio/v.TipoCambio ELSE convert(float, ROUND(((vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio)-ISNULL(case when vd.DescuentoTipo='$' then vd.DescuentoLinea else (vd.Cantidad-ISNULL(vd.CantidadCancelada, 0.0)-ISNULL(vd.CantidadObsequio, 0.0))*vd.Precio*(vd.DescuentoLinea/100.0) end, 0.0), ver.RedondeoMonetarios)) END END, (ISNULL(v.DescuentoGlobal,0.0)), v.SobrePrecio) * (ISNULL(CASE WHEN ver.Impuesto2Info=1 THEN 0.0 ELSE vd.Impuesto2 END, 0.0)/100.0), ver.RedondeoMonetarios))),0.0) ELSE 0.0 END*v.TipoCambio,
  ieps_num_reporte         = ma.IEPSNumReporte,
  ieps_categoria_concepto  = ma.IEPSCategoriaConcepto,
  ieps_exento              = ma.IEPSExento,
  ieps_envase_reutilizable = ma.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
  --BUG23510
  ieps_unidad              = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),    
  ieps_cantidad2           = ISNULL(dbo.fnMFAArtUnidadConvertir(vd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), vd.Cantidad), 
  --BUG23510
  ieps_unidad2             = ISNULL(ma.UnidadBaseIEPS, vd.Unidad),    
  dinero				   = v.Dinero,
  dinero_id				   = v.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = CASE MFAArtAF.Articulo WHEN NULL THEN 0 ELSE 1 END, 
  TipoActivo			   = CASE MFAArtAF.Articulo WHEN NULL THEN NULL ELSE MFAActivoFCat.Tipo END,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Venta v 
  JOIN MovTipo mt ON mt.Mov = v.Mov AND mt.Modulo = 'VTAS' 
  JOIN Cte c ON c.Cliente = v.Cliente 
  JOIN VentaD vd ON vd.ID = v.ID 
  --JOIN MFAVentaTCalc vtc ON vtc.ID = v.ID AND vtc.Renglon = vd.Renglon AND vtc.RenglonSub = vd.RenglonSub --ARC NUEVO
  JOIN Art a ON a.Articulo = vd.Articulo 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON a.Articulo = mtmce.Concepto    
  JOIN EmpresaGral eg ON eg.Empresa = v.Empresa
  JOIN EmpresaMFA em ON em.Empresa = v.Empresa
  --BUG22460
  JOIN EmpresaCfg cfg ON cfg.Empresa = em.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MovFlujo mf ON mf.DID = v.ID AND mf.DModulo = 'VTAS'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'VTAS' AND mme.ModuloID = v.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'VTAS' AND mtmde.Mov = v.Mov 
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionArt mmdtdea ON  ISNULL(NULLIF(mmdtdea.Articulo,''),a.Articulo) = a.Articulo AND mmdtdea.Mov = v.Mov AND mmdtdea.Modulo = 'VTAS'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = c.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = c.Pais
  LEFT OUTER JOIN MFAPais p ON p.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = v.Agente   
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  LEFT OUTER JOIN Unidad u ON u.Unidad = vd.Unidad
  --BUG23510
  LEFT OUTER JOIN Unidad u2 ON u2.Unidad = ma.UnidadBaseIEPS  
  LEFT OUTER JOIN ArtUnidad au ON au.Articulo = a.Articulo AND au.Unidad = vd.Unidad
  --BUG23510
  LEFT OUTER JOIN ArtUnidad au2 ON au2.Articulo = a.Articulo AND au2.Unidad = ma.UnidadBaseIEPS  
  --BUG22156
  LEFT OUTER JOIN MFAArtAF ON a.Articulo = MFAArtAF.Articulo
  LEFT OUTER JOIN MFAActivoFCat ON a.CategoriaActivoFijo = MFAActivoFCat.Categoria    
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'VTAS' AND MFATipoActividad.Mov = v.Mov
 WHERE mtmde.Modulo IS NULL
   AND mme.ModuloID IS NULL
   AND v.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND mt.Clave IN ('VTAS.N','VTAS.FM') 
   --BUG18013
   --AND (v.OrigenTipo IN ('CR') OR mf.OModulo = 'CR')
GO

/*** MFANotaCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANotaCalc') and type = 'V') drop view dbo.MFANotaCalc
GO
CREATE VIEW MFANotaCalc
AS
SELECT 
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,    
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFANotaPreCalc
GO

--BUG16115
--/*** MFACompraCalc ***/
--if exists (select * from sysobjects where id = object_id('dbo.MFACompraCalc') and type = 'V') drop view dbo.MFACompraCalc
--GO
--CREATE VIEW MFACompraCalc
----//WITH ENCRYPTION
--AS 
--SELECT 
--  v.*,
--  ver.RedondeoMonetarios,
--  "DescuentosTotales" = (Convert(money, ROUND((v.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0), ver.RedondeoMonetarios))+ISNULL(v.DescuentoLineal, 0.0)),
--  "SubTotal"= Convert(money, ROUND((v.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0), ver.RedondeoMonetarios)),
--  "ImporteTotal"= Convert(money, ROUND((v.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) + v.Impuestos, ver.RedondeoMonetarios))

--FROM
--  Compra v 
--  JOIN Version ver ON 1 = 1
--GO

--BUG16901
/*** MFACompraImportacionCxpDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraImportacionCxpDocumentoPreCalc') and type = 'V') drop view dbo.MFACompraImportacionCxpDocumentoPreCalc
GO
CREATE VIEW MFACompraImportacionCxpDocumentoPreCalc AS
SELECT
  Origen				 = c.Origen,
  OrigenID				 = c.OrigenID,
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  --BUG22370
  --importe                = c.Importe*c.TipoCambio,
  importe                = CASE ISNULL(CONVERT(float,c.Importe),0.0)
                             WHEN 0.0 THEN
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
  	                             WHEN 0.0 THEN 0.0
	                             ELSE (ISNULL(CONVERT(float,c.Impuestos),0.0)/2)*c.TipoCambio
                               END
                             ELSE 
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
                                 WHEN 0.0 THEN (ISNULL(CONVERT(float,c.Importe),0.0) - dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos))*c.TipoCambio
                                 ELSE (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio
                               END
                           END,
  retencion_isr          = c.Retencion2*c.TipoCambio,
  retencion_iva          = c.Retencion*c.TipoCambio,
  --BUG22370
  --base_iva             = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  base_iva               = CASE ISNULL(CONVERT(float,c.Importe),0.0)
                             WHEN 0.0 THEN
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
  	                             WHEN 0.0 THEN 0.0
	                             ELSE (ISNULL(CONVERT(float,c.Impuestos),0.0)/2)*c.TipoCambio
                               END
                             ELSE 
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
                                 WHEN 0.0 THEN (ISNULL(CONVERT(float,c.Importe),0.0) - dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos))*c.TipoCambio
                                 ELSE (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio
                               END
                           END,
  iva_excento            = 0,
  --iva_tasa             = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio, 
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = c.Concepto,
  concepto_es_importacion  = ISNULL(EsImportacion, 0),
  concepto_es_iva_importacion  = ISNULL(EsIVAImportacion, 0),
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   --AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   AND cd.ID IS NULL
   AND c.OrigenTipo IN ('COMS')
GO

--BUG24040
/*** MFACompraImportacionCxpDocumentoPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraImportacionCxpDocumentoPreCalc2') and type = 'V') drop view dbo.MFACompraImportacionCxpDocumentoPreCalc2
GO
CREATE VIEW MFACompraImportacionCxpDocumentoPreCalc2 AS
SELECT
  Origen				 = g.Origen,
  OrigenID				 = g.OrigenID,
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = gd.Concepto,
  acumulable_deducible   = 'Si',
  --BUG22370
  --importe                = c.Importe*c.TipoCambio,
  importe                = CASE ISNULL(CONVERT(float,c.Importe),0.0)
                             WHEN 0.0 THEN
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
  	                             WHEN 0.0 THEN 0.0
	                             ELSE (ISNULL(CONVERT(float,c.Impuestos),0.0)/2)*c.TipoCambio
                               END
                             ELSE 
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
                                 WHEN 0.0 THEN (ISNULL(CONVERT(float,c.Importe),0.0) - dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos))*c.TipoCambio
                                 ELSE (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio
                               END
                           END,
  retencion_isr          = c.Retencion2*c.TipoCambio,
  retencion_iva          = c.Retencion*c.TipoCambio,
  --BUG22370
  --base_iva             = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  base_iva               = CASE ISNULL(CONVERT(float,c.Importe),0.0)
                             WHEN 0.0 THEN
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
  	                             WHEN 0.0 THEN 0.0
	                             ELSE (ISNULL(CONVERT(float,c.Impuestos),0.0)/2)*c.TipoCambio
                               END
                             ELSE 
                               CASE ISNULL(CONVERT(float,c.Impuestos),0.0)
                                 WHEN 0.0 THEN (ISNULL(CONVERT(float,c.Importe),0.0) - dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos))*c.TipoCambio
                                 ELSE (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio
                               END
                           END,
  iva_excento            = 0,
  --iva_tasa             = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = gd.Concepto,
  concepto_es_importacion  = ISNULL(EsImportacion, 0),
  concepto_es_iva_importacion  = ISNULL(EsIVAImportacion, 0),
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID
  FROM Cxp c
  JOIN Gasto g ON c.OrigenTipo = 'GAS' AND c.Empresa = g.Empresa AND c.Origen = g.Mov AND c.OrigenID = g.MovID
  JOIN GastoD gd ON g.ID = gd.ID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  JOIN Concepto co ON co.Concepto = gd.Concepto AND co.Modulo = 'COMSG'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   --AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   AND cd.ID IS NULL
   AND c.OrigenTipo IN ('GAS')
GO

--BUG16901
/*** MFACompraImportacionCxpDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraImportacionCxpDocumentoCalc') and type = 'V') drop view dbo.MFACompraImportacionCxpDocumentoCalc
GO
CREATE VIEW MFACompraImportacionCxpDocumentoCalc
AS
SELECT 
  Origen,
  OrigenID,
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,  
  --REQ16748
  concepto_es_importacion,
  concepto_es_iva_importacion,
  dinero,
  dinero_id
FROM MFACompraImportacionCxpDocumentoPreCalc
--BUG24040
UNION ALL
SELECT 
  Origen,
  OrigenID,
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,  
  --REQ16748
  concepto_es_importacion,
  concepto_es_iva_importacion,
  dinero,
  dinero_id
FROM MFACompraImportacionCxpDocumentoPreCalc2
GO

/*** MFACompraDCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraDCalc') and type = 'V') drop view dbo.MFACompraDCalc
GO
CREATE VIEW MFACompraDCalc
--//WITH ENCRYPTION
AS 
SELECT 
  d.*,
  v.RedondeoMonetarios,
  "CantidadNeta" = (Cantidad-ISNULL(CantidadCancelada, 0.0)),
  "CantidadFactor" = (Cantidad-ISNULL(CantidadCancelada, 0.0))*Factor,
  "PendienteFactor" = CantidadPendiente*Factor,
  "Impuesto1Base" = Impuesto1,
  "Impuesto2Base" = CASE WHEN v.Impuesto2Info=1 THEN 0.0 ELSE Impuesto2 END,
  "Impuesto3Base" = CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END,
  "Impuesto2BaseImpuesto1" = CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END,
  "ImpuestosPorcentaje" = convert(float, ROUND((100.0+ISNULL(CASE WHEN v.Impuesto2Info=1 OR v.Impuesto2BaseImpuesto1=0 THEN 0.0 ELSE Impuesto2 END, 0.0))*(1.0+((ISNULL(Impuesto1, 0.0)/*+ISNULL(Impuesto3, 0.0)*/)/100.0))-100, v.RedondeoMonetarios)),
  "ImpuestosImporte"    = convert(money, ROUND((Cantidad-ISNULL(CantidadCancelada, 0.0))*ISNULL(CASE WHEN v.Impuesto3Info=1 THEN 0.0 ELSE Impuesto3 END, 0.0) /*+ ISNULL(Impuesto5,0.0)*/, v.RedondeoMonetarios)),
  "Importe" = convert(money, ROUND(((Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo)-ISNULL(case when DescuentoTipo='$' then ISNULL(DescuentoLinea, 0.0) else (Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo*(ISNULL(DescuentoLinea, 0.0)/100.0) end, 0.0), v.RedondeoMonetarios)),  
  "DescuentoLineal" = convert(money, ROUND((case when DescuentoTipo='$' then DescuentoLinea else (Cantidad-ISNULL(CantidadCancelada, 0.0))*Costo*(DescuentoLinea/100.0) end), v.RedondeoMonetarios))

FROM
  CompraD d, Version v
GO

/*** MFACompraTCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraTCalc') and type = 'V') drop view dbo.MFACompraTCalc
GO
CREATE VIEW MFACompraTCalc
--//WITH ENCRYPTION
AS 
SELECT 
  v.ID,
  v.Sucursal,
  v.Empresa,
  v.Mov,
  v.MovID,
  v.Moneda,
  v.TipoCambio,
  v.Concepto,
  v.Referencia,
  v.Proyecto,
  v.FechaEmision,
  d.FechaRequerida,
  v.Prioridad,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  v.SituacionUsuario,
  v.SituacionNota,
  v.Proveedor,
  v.Agente,
  v.FormaEnvio,
  v.Condicion,
  v.Vencimiento,
  v.Usuario,
  v.Observaciones,
  v.Ejercicio,
  v.Periodo,
  v.Peso,
  v.Volumen,
  v.causa,
  v.ZonaImpuesto,
  v.FechaEntrega,
  v.EmbarqueEstado,
  v.FechaConclusion,
  v.FechaRegistro,
  v.UEN,
  --BUG22370 BUG22833
  dbo.fnSubTotal(v.Importe, (ISNULL(v.DescuentoGlobal,0.0)), NULL) + ISNULL(v.Impuestos, 0) 'ImporteMov',
  --v.Importe + ISNULL(v.Impuestos, 0) 'ImporteMov',
  d.Renglon,
  d.RenglonSub,
  d.RenglonID,
  d.RenglonTipo,
  d.ImportacionProveedor,
  d.ImportacionReferencia,
  d.Articulo,
  d.SubCuenta,
  d.Unidad,
  d.Almacen,
  d.Costo,
  d.AjusteCosteo,
  d.CostoUEPS,
  d.CostoPEPS,
  d.UltimoCosto,
  d.CostoEstandar,
  d.PrecioLista,
  d.DescuentoTipo,
  d.Impuesto1,
  d.Impuesto2,
  d.Impuesto3,
  d.Retencion1,
  d.Retencion2,
  d.Retencion3,
  d.Cantidad, 
  d.Factor,
  d.CantidadInventario,
  d.CantidadNeta, 
  d.CantidadPendiente,
  d.CantidadEmbarcada,
  d.CantidadFactor,
  d.PendienteFactor,
  d.ImpuestosPorcentaje, 
  d.Importe, 
  d.DescuentoLineal,
  d.ContUso,
  d.ContUso2,
  d.ContUso3,
  d.Categoria,
  d.Aplica,
  d.AplicaID,
  d.PresupuestoEsp,
  d.ClavePresupuestal,
  d.TipoImpuesto1,
  d.TipoImpuesto2,
  d.TipoImpuesto3,
  d.TipoRetencion1,
  d.TipoRetencion2,
  d.TipoRetencion3,
  d.CostoPromedio,
  d.CostoReposicion,
  d.RedondeoMonetarios,
  "SubTotalInv"       = Convert(money, ROUND(d.CostoInv*d.CantidadNeta, d.RedondeoMonetarios)),
  "DescuentosTotales" = convert(money, ROUND((d.Importe*ISNULL(v.DescuentoGlobal, 0.0)/100.0)+ISNULL(d.DescuentoLineal, 0.0), d.RedondeoMonetarios)),
  "SubTotal"          = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END, d.RedondeoMonetarios)),
  "Impuesto1Total"    = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END*(1.0+(ISNULL(d.Impuesto2BaseImpuesto1, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0), d.RedondeoMonetarios)),
  "Impuesto2Total"    = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*CASE WHEN mt.SubClave = 'COMS.CE/GT' THEN (1-(ISNULL(Retencion3, 0.0)/100.0)) ELSE 1 END*(ISNULL(Impuesto2Base, 0.0)/100.0), d.RedondeoMonetarios)),
  "Impuesto3Total"    = ISNULL(ImpuestosImporte, 0.0), -- - ISNULL(Impuesto5Base,0.0),Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto3Base, 0.0)/100.0), d.RedondeoMonetarios)),
  --"Impuesto5Total"    = ISNULL(Impuesto5Base,0.0),--Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto3Base, 0.0)/100.0), d.RedondeoMonetarios)),
  "Impuestos" 	      = ISNULL(ImpuestosImporte, 0.0) + Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) * (ISNULL(ImpuestosPorcentaje, 0.0)/100.0), d.RedondeoMonetarios)),
  "ImporteTotal"      = ISNULL(ImpuestosImporte, 0.0) + Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0) * (1.0+(ISNULL(ImpuestosPorcentaje, 0.0)/100.0)), d.RedondeoMonetarios)),
  "Retencion1Total"   = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(ISNULL(Retencion1, 0.0)/100.0), d.RedondeoMonetarios)),
  "Retencion2Total"   = CASE 
                        WHEN Version.Retencion2BaseImpuesto1 = 1 THEN 
                          Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(1.0+(ISNULL(Impuesto2Base, 0.0)/100.0))*(ISNULL(Impuesto1Base, 0.0)/100.0)*(ISNULL(Retencion2, 0.0)/100.0), d.RedondeoMonetarios))
                        ELSE 
                          Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(1-(ISNULL(Retencion3, 0.0)/100.0))*(ISNULL(Retencion2, 0.0)/100.0), d.RedondeoMonetarios)) END,
  "Retencion3Total"   = Convert(money, ROUND((d.Importe*(100-ISNULL(v.DescuentoGlobal, 0.0))/100.0)*(ISNULL(Retencion3, 0.0)/100.0), d.RedondeoMonetarios))
FROM 
  Compra v, MFACompraDCalc d, Version, MovTipo mt
WHERE
  v.ID = d.ID
  AND mt.Mov = v.Mov 
  AND mt.Modulo = 'COMS'
GO

/*** MFACompraPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc') and type = 'V') drop view dbo.MFACompraPreCalc
GO
CREATE VIEW MFACompraPreCalc AS
SELECT
  id                     = c.ID,
  concepto_clave         = cd.Articulo,
  origen_tipo            = 'auto',
  origen_modulo          = 'COMS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 'factura'
                             WHEN mt.Clave IN ('COMS.B') THEN 'nota_credito'
                             WHEN mt.Clave IN ('COMS.D') THEN 'devolucion'                             
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdea.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = p.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = c.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = a.Descripcion1,
  acumulable_deducible   = 'Si',
  importe                = ctc.SubTotal*c.TipoCambio,
  retencion_isr          = ctc.Retencion2Total*c.TipoCambio, --CAMBIARARC 
  retencion_iva          = ctc.Retencion1Total*c.TipoCambio,
  base_iva               = (ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  iva_tasa               = cd.Impuesto1,
  iva                    = ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio,
  base_ieps              = ctc.Subtotal*c.TipoCambio,
  --23510
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(cd.Impuesto2, 0) ELSE 0 END,
  ieps                   = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total, 0)*c.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*c.TipoCambio END,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = ma.IEPSNumReporte,
  ieps_categoria_concepto  = ma.IEPSCategoriaConcepto,
  ieps_exento              = ma.IEPSExento,
  ieps_envase_reutilizable = ma.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = cd.Cantidad, 
  ieps_unidad              = cd.Unidad, 
  ieps_cantidad2           = dbo.fnMFAArtUnidadConvertir(cd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), 
  --BUG23510
  ieps_unidad2             = ISNULL(ma.UnidadBaseIEPS, cd.Unidad),
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = CASE MFAArtAF.Articulo WHEN NULL THEN 0 ELSE 1 END, 
  TipoActivo			   = CASE MFAArtAF.Articulo WHEN NULL THEN NULL ELSE MFAActivoFCat.Tipo END,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG22833
  0 'BaseIVAImportacion'
  FROM Cxp cxp 
  JOIN Compra c ON c.MovID = cxp.OrigenID AND c.Mov = cxp.Origen AND cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS' 
  JOIN Prov p ON p.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  JOIN CompraD cd ON cd.ID = c.ID 
  JOIN MFACompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
  JOIN Art a ON a.Articulo = cd.Articulo 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON a.Articulo = mtmce.Concepto    
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionArt mmdtdea ON  ISNULL(NULLIF(mmdtdea.Articulo,''),a.Articulo) = a.Articulo AND mmdtdea.Mov = c.Mov AND mmdtdea.Modulo = 'COMS'
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  LEFT OUTER JOIN Unidad u ON u.Unidad = cd.Unidad
  --BUG23510
  LEFT OUTER JOIN Unidad u2 ON u2.Unidad = ma.UnidadBaseIEPS
  LEFT OUTER JOIN ArtUnidad au ON au.Articulo = a.Articulo AND au.Unidad = cd.Unidad
  --BUG23510
  LEFT OUTER JOIN ArtUnidad au2 ON au2.Articulo = a.Articulo AND au2.Unidad = ma.UnidadBaseIEPS
  --BUG22156
  LEFT OUTER JOIN MFAArtAF ON a.Articulo = MFAArtAF.Articulo
  LEFT OUTER JOIN MFAActivoFCat ON a.CategoriaActivoFijo = MFAActivoFCat.Categoria  
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   --BUG16901
   AND (mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', /*'COMS.EI',*/'COMS.D','COMS.B','COMS.CA', 'COMS.GX') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'COMS' 
   AND mme.ModuloID IS NULL
GO

/**************** fnMFATasaIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFATasaIVAImportacion') drop function dbo.fnMFATasaIVAImportacion
GO
CREATE FUNCTION fnMFATasaIVAImportacion(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@Empresa						varchar(5),
				@COMSCalcularBaseImportacion	bit,
				--BUG24779
				@Impuesto1						float
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float

  --BUG24779
  SELECT @Valor = NULL
  
  SELECT @Valor = iva_tasa
    FROM MFACompraImportacionCxpDocumentoCalc
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID
     AND NULLIF(iva_tasa, 0) IS NOT NULL
  
  IF(RTRIM(LTRIM(@Mov)) = 'Entrada Importacion' AND (select COUNT(*) from MFAConceptoCOMSG where EsIVAImportacion = 1) = 0 )
	SET @Valor = 0

  --BUG24779
  IF @Valor IS NULL
    SELECT @Valor = @Impuesto1
     
  RETURN ISNULL(@Valor, 0)
    
  RETURN @Valor
END
GO

--BUG16901 --BUG22370
/**************** fnMFABaseIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFABaseIVAImportacion') drop function dbo.fnMFABaseIVAImportacion
GO
CREATE FUNCTION fnMFABaseIVAImportacion(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@ImporteMov						float, 
				@ImporteTotal					float, 
				@Empresa						varchar(5),
				@COMSCalcularBaseImportacion	bit
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float,
		  @Factor		float
  
  SELECT @Factor = (@ImporteTotal)/NULLIF(@ImporteMov, 0)

  SELECT @Valor = SUM(importe_total)
    FROM MFACompraImportacionCxpDocumentoCalc
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID
     AND ISNULL(concepto_es_importacion, 0) = 1

  SELECT @Valor = ISNULL(@Valor * @Factor, 0)

  RETURN ISNULL(@Valor, 0)
END
GO

--BUG24040
/**************** fnMFABaseIVAImportacionAnticipado ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFABaseIVAImportacionAnticipado') drop function dbo.fnMFABaseIVAImportacionAnticipado
GO
CREATE FUNCTION fnMFABaseIVAImportacionAnticipado(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@Empresa						varchar(5),
				@COMSCalcularBaseImportacion	bit
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float

  SELECT @Valor = SUM(importe_total)
    FROM MFACompraImportacionCxpDocumentoCalc
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID
     AND ISNULL(concepto_es_importacion, 0) = 1

  RETURN ISNULL(@Valor, 0)
END
GO

--BUG22370
/**************** fnMFAIVAImportacion ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFAIVAImportacion') drop function dbo.fnMFAIVAImportacion
GO
CREATE FUNCTION fnMFAIVAImportacion(
				@Mov							varchar(20), 
				@MovID							varchar(20), 
				@ImporteMov						float, 
				@ImporteTotal					float, 
				@Empresa						varchar(5),
				@COMSCalcularBaseImportacion	bit,
				--BUG24779
				@Impuesto1Total					float,
				@TipoCambio						float
				)				
RETURNS float
AS
BEGIN
  DECLARE @Valor		float,
		  @Factor		float

  SELECT @Factor = (@ImporteTotal)/NULLIF(@ImporteMov, 0)
  
  --BUG24779
  SELECT @Valor = SUM(importe_total)
    FROM MFACompraImportacionCxpDocumentoCalc
   WHERE Empresa  = @Empresa
     AND Origen   = @Mov
     AND OrigenID = @MovID
     AND ISNULL(concepto_es_iva_importacion, 0) = 1
	 
  IF(@Mov = 'Entrada Importacion' AND (select COUNT(*) from MFAConceptoCOMSG where EsIVAImportacion = 1) = 0 )
	SET @Valor = 0

  --BUG24779
  IF @Valor IS NULL
    SELECT @Valor = @Impuesto1Total*@TipoCambio
  ELSE
    SELECT @Valor = ISNULL(@Valor * @Factor, 0)
  
  RETURN ISNULL(@Valor, 0)
END
GO

--BUG16901
/*** MFACompraPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc2') and type = 'V') drop view dbo.MFACompraPreCalc2
GO
CREATE VIEW MFACompraPreCalc2 AS
SELECT
  id                     = c.ID,
  concepto_clave         = cd.Articulo,
  origen_tipo            = 'auto',
  origen_modulo          = 'COMS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 'factura'
                             WHEN mt.Clave IN ('COMS.B') THEN 'nota_credito'
                             WHEN mt.Clave IN ('COMS.D') THEN 'devolucion'                             
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdea.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = p.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = c.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = a.Descripcion1,
  --BUG22370 BUG24040
  acumulable_deducible   = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0) WHEN 0 THEN ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si') ELSE 'No' END,
  importe                = CASE ISNULL(em.COMSCalcularBaseImportacion, 0)
                             WHEN 1 THEN (ctc.SubTotal*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)
                             WHEN 0 THEN (ctc.SubTotal*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)
                           END,
  retencion_isr          = ctc.Retencion2Total*c.TipoCambio, --CAMBIARARC 
  retencion_iva          = ctc.Retencion1Total*c.TipoCambio, 
  base_iva               = CASE ISNULL(em.COMSCalcularBaseImportacion, 0)
                             --BUG24779
                             WHEN 1 THEN CASE dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio) WHEN 0 THEN (ctc.SubTotal*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion) ELSE dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio)/NULLIF((dbo.fnMFATasaIVAImportacion(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion, cd.Impuesto1)/100.0), 0) END
                             WHEN 0 THEN (ctc.SubTotal*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)
                           END,
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  iva_tasa               = CASE ISNULL(em.COMSCalcularBaseImportacion, 0)
                             --BUG24779
                             WHEN 1 THEN CASE dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio) WHEN 0 THEN 0 ELSE dbo.fnMFATasaIVAImportacion(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion, cd.Impuesto1) END
                             WHEN 0 THEN dbo.fnMFATasaIVAImportacion(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion, cd.Impuesto1)
                           END,                           
  iva					 = CASE ISNULL(em.COMSCalcularBaseImportacion, 0)
                             --BUG24779
                             WHEN 1 THEN dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio)--dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion)
                             WHEN 0 THEN dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio)
                           END,
  base_ieps              = ctc.Subtotal*c.TipoCambio,
  --23510
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(cd.Impuesto2, 0) ELSE 0 END,    
  ieps                   = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total, 0)*c.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*c.TipoCambio END,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = ma.IEPSNumReporte,
  ieps_categoria_concepto  = ma.IEPSCategoriaConcepto,
  ieps_exento              = ma.IEPSExento,
  ieps_envase_reutilizable = ma.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = cd.Cantidad, 
  ieps_unidad              = cd.Unidad, 
  ieps_cantidad2           = dbo.fnMFAArtUnidadConvertir(cd.Cantidad,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u.Factor ELSE au.Factor END)
      ELSE 0.0
    END,
    CASE 
      WHEN 
        ISNULL(ec.Multiunidades,0) = 1 
      THEN (CASE WHEN ec.NivelFactorMultiunidad = 'UNIDAD' THEN u2.Factor ELSE au2.Factor END)
      ELSE 0.0
    END), 
  --BUG23510
  ieps_unidad2             = ISNULL(ma.UnidadBaseIEPS, cd.Unidad),    
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353 BUG24040
  concepto_aplica_ietu     = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0) WHEN 0 THEN ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si') ELSE 'No' END,
  concepto_aplica_ieps     = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0) WHEN 0 THEN ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si') ELSE 'No' END,
  concepto_aplica_iva      = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0) WHEN 0 THEN ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si')  ELSE 'No' END,
  --BUG22156
  EsActivoFijo			   = CASE MFAArtAF.Articulo WHEN NULL THEN 0 ELSE 1 END, 
  TipoActivo			   = CASE MFAArtAF.Articulo WHEN NULL THEN NULL ELSE MFAActivoFCat.Tipo END,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG22833 BUG24779
  ISNULL(dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion), 0) + ISNULL(dbo.fnMFAIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion, ctc.Impuesto1Total, ctc.TipoCambio), 0) - ISNULL(ctc.Impuesto1Total,0.0)*c.TipoCambio 'BaseIVAImportacion'
  FROM Cxp cxp 
  JOIN Compra c ON c.MovID = cxp.OrigenID AND c.Mov = cxp.Origen AND cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS'
  --BUG22833
  JOIN Prov p ON p.Proveedor = cxp.Proveedor 
  LEFT OUTER JOIN Concepto ON Concepto.Concepto = Cxp.Concepto AND Concepto.Modulo = 'COMSG'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  --BUG22833 BUG24992
  JOIN CompraD cd ON cd.ID = c.ID AND Cxp.Proveedor = ISNULL(NULLIF(RTRIM(cd.ImportacionProveedor), ''), c.Proveedor) AND ISNULL(Cxp.Referencia, '') = ISNULL(NULLIF(RTRIM(cd.ImportacionReferencia), ''), ISNULL(Cxp.Referencia, ''))
  JOIN MFACompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
  JOIN Art a ON a.Articulo = cd.Articulo 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON a.Articulo = mtmce.Concepto    
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  --BUG22833
  JOIN EmpresaCfgMov ON EmpresaCfgMov.Empresa = c.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionArt mmdtdea ON  ISNULL(NULLIF(mmdtdea.Articulo,''),a.Articulo) = a.Articulo AND mmdtdea.Mov = c.Mov AND mmdtdea.Modulo = 'COMS'
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  LEFT OUTER JOIN Unidad u ON u.Unidad = cd.Unidad
  --BUG23510
  LEFT OUTER JOIN Unidad u2 ON u2.Unidad = ma.UnidadBaseIEPS
  LEFT OUTER JOIN ArtUnidad au ON au.Articulo = a.Articulo AND au.Unidad = cd.Unidad
  --BUG23510
  LEFT OUTER JOIN ArtUnidad au2 ON au2.Articulo = a.Articulo AND au2.Unidad = ma.UnidadBaseIEPS
  --BUG22156
  LEFT OUTER JOIN MFAArtAF ON a.Articulo = MFAArtAF.Articulo
  LEFT OUTER JOIN MFAActivoFCat ON a.CategoriaActivoFijo = MFAActivoFCat.Categoria    
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   --BUG22833
   AND cxp.Mov <> EmpresaCfgMov.CxpGastoDiverso
   AND (mt.Clave IN ('COMS.EI') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'COMS' 
   AND mme.ModuloID IS NULL
GO

--BUG22833
/*** MFACompraPreCalc3 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc3') and type = 'V') drop view dbo.MFACompraPreCalc3
GO
CREATE VIEW MFACompraPreCalc3 AS
SELECT
  ID					 = cxp.ID,
  Estatus                = cxp.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,cxp.ID))),
  empresa                = cxp.Empresa,
  emisor                 = 'terceros',
  --BUG24040
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('COMS.EI') THEN 'factura'
                             ELSE mtmda.DocumentoTipo
                           END,
  --BUG24040
  subtipo_documento      = CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END,                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = cxp.Ejercicio,
  periodo                = cxp.Periodo,
  dia                    = DAY(cxp.FechaEmision),
  --BUG22460
  fecha					 = cxp.FechaEmision,
  entidad_clave          = cxp.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = p.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(cxp.Concepto,cxp.Mov),
  --BUG24040
  acumulable_deducible   = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  importe                = cxp.Importe*cxp.TipoCambio,
  retencion_isr          = cxp.Retencion2*cxp.TipoCambio,
  retencion_iva          = cxp.Retencion*cxp.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*cxp.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(cxp.Empresa, cxp.Importe,cxp.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(cxp.Empresa,cxp.Importe,cxp.Impuestos)*cxp.TipoCambio,  
  base_ieps              = ISNULL(cxp.Importe,0.0)*cxp.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,cxp.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,cxp.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)*cxp.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = cxp.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353 BUG24040
  concepto_aplica_ietu     = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  concepto_aplica_ieps     = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  concepto_aplica_iva      = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG22833
  0 'BaseIVAImportacion'  
  FROM Cxp cxp 
  JOIN Compra c ON c.MovID = cxp.OrigenID AND c.Mov = cxp.Origen AND cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS'
  --BUG22833
  JOIN Prov p ON p.Proveedor = cxp.Proveedor 
  LEFT OUTER JOIN Concepto ON Concepto.Concepto = Cxp.Concepto AND Concepto.Modulo = 'COMSG'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  --BUG22833
  JOIN EmpresaCfgMov ON EmpresaCfgMov.Empresa = c.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND cxp.Mov = EmpresaCfgMov.CxpGastoDiverso
   AND (mt.Clave IN ('COMS.EI') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'COMS' 
   AND mme.ModuloID IS NULL
   --BUG24040
   AND 1 = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0)
             WHEN 0 THEN 1
             ELSE CASE ISNULL(Concepto.EsIVAImportacion, 0)
                    WHEN 0 THEN 1
                    ELSE 0
                   END
             END
GO

--BUG24040
/*** MFACompraPreCalc4 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc4') and type = 'V') drop view dbo.MFACompraPreCalc4
GO
CREATE VIEW MFACompraPreCalc4 AS
SELECT
  ID					 = cxp.ID,
  Estatus                = cxp.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,cxp.ID))),
  empresa                = cxp.Empresa,
  emisor                 = 'terceros',
  --BUG24040
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('COMS.EI') THEN 'factura'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END,                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = cxp.Ejercicio,
  periodo                = cxp.Periodo,
  dia                    = DAY(cxp.FechaEmision),
  --BUG22460
  fecha					 = cxp.FechaEmision,
  entidad_clave          = cxp.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = p.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(cxp.Concepto,cxp.Mov),
  --BUG24040
  acumulable_deducible   = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  importe                = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),  
  retencion_isr          = SUM(ctc.Retencion2Total*c.TipoCambio),
  retencion_iva          = SUM(ctc.Retencion1Total*c.TipoCambio),
  base_iva               = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),  
  iva_excento            = ISNULL(a.Impuesto1Excento,0),
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(cxp.Empresa, cxp.Importe,cxp.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = 2*dbo.fnMFAIVA(cxp.Empresa,cxp.Importe,cxp.Impuestos)*cxp.TipoCambio,
  base_ieps              = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),
  ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(cd.Impuesto2, 0) ELSE 0 END,
  ieps                   = SUM(CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total, 0)*c.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*c.TipoCambio END),
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = cxp.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353 BUG24040
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,	
  TipoActividad			   = MFATipoActividad.Tipo,
  --BaseIVAImportacion	   = ISNULL(dbo.fnMFABaseIVAImportacionAnticipado(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion), 0)
  BaseIVAImportacion	   = -1
  FROM Cxp cxp 
  JOIN Compra c ON c.MovID = cxp.OrigenID AND c.Mov = cxp.Origen AND cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS'
  --BUG22833
  JOIN Prov p ON p.Proveedor = c.Proveedor 
  JOIN CompraD cd ON cd.ID = c.ID  
  JOIN MFACompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
  JOIN Art a ON a.Articulo = cd.Articulo   
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  
  LEFT OUTER JOIN Concepto ON Concepto.Concepto = Cxp.Concepto AND Concepto.Modulo = 'COMSG'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente   
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  --BUG22833
  JOIN EmpresaCfgMov ON EmpresaCfgMov.Empresa = c.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND cxp.Mov = EmpresaCfgMov.CxpGastoDiverso
   AND (mt.Clave IN ('COMS.EI') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'COMS' 
   AND mme.ModuloID IS NULL
   AND ISNULL(Concepto.EsIVAImportacion, 0) = 1
   AND ISNULL(em.COMSIVAImportacionAnticipado, 0) = 1
   GROUP BY cxp.ID, cxp.Estatus, mt.Clave, mtmda.DocumentoTipo, fr.Extranjero, cxp.Mov, cxp.MovID, cxp.Ejercicio, cxp.Periodo, cxp.FechaEmision, cxp.Proveedor, 
            p.Nombre, p.RFC,p.MFATipoOperacion, mp.Pais, mp.Nacionalidad, p.Agente, ag.Nombre, cxp.Concepto, Concepto.Concepto, Cxp.Empresa, em.COMSIVAImportacionAnticipado, a.Impuesto1Excento, 
            Cxp.Importe, Cxp.Impuestos, Cxp.TipoCambio, cd.Impuesto2, cxp.Dinero, cxp.DineroID, MFATipoActividad.Tipo, ma.Impuesto, 
            c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion           
GO

--BUG24040
/*** MFACompraPreCalc5 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc5') and type = 'V') drop view dbo.MFACompraPreCalc5
GO
CREATE VIEW MFACompraPreCalc5 AS
SELECT
  ID					 = cxp.ID,
  Estatus                = cxp.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,cxp.ID))),
  empresa                = cxp.Empresa,
  emisor                 = 'terceros',
  --BUG24040
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('COMS.EI') THEN 'factura'
                             ELSE mtmda.DocumentoTipo
                           END,
  --BUG24040
  subtipo_documento      = CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END,                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = cxp.Ejercicio,
  periodo                = cxp.Periodo,
  dia                    = DAY(cxp.FechaEmision),
  --BUG22460
  fecha					 = cxp.FechaEmision,
  entidad_clave          = cxp.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = p.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = Concepto.Concepto,
  --BUG24040
  acumulable_deducible   = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  importe                = cxp.Importe*cxp.TipoCambio,
  retencion_isr          = cxp.Retencion2*cxp.TipoCambio,
  retencion_iva          = cxp.Retencion*cxp.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,cxp.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,cxp.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)) ELSE 0.0 END)*cxp.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(cxp.Empresa, cxp.Importe,cxp.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(cxp.Empresa,cxp.Importe,cxp.Impuestos)*cxp.TipoCambio,  
  base_ieps              = ISNULL(cxp.Importe,0.0)*cxp.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,cxp.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,cxp.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)*cxp.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = Concepto.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353 BUG24040
  concepto_aplica_ietu     = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  concepto_aplica_ieps     = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  concepto_aplica_iva      = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG22833
  0 'BaseIVAImportacion'  
  FROM Cxp cxp

  JOIN Gasto g   ON g.MovID = cxp.OrigenID AND g.Mov = cxp.Origen AND cxp.OrigenTipo = 'GAS' AND g.Empresa = cxp.Empresa
  JOIN GastoD gd ON g.ID = gd.ID  
  JOIN Compra c ON c.MovID = g.OrigenID AND c.Mov = g.Origen AND g.OrigenTipo = 'COMS' AND g.Empresa = c.Empresa  
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS'
  --BUG22833
  JOIN Prov p ON p.Proveedor = cxp.Proveedor 
  LEFT OUTER JOIN Concepto ON Concepto.Concepto = gd.Concepto AND Concepto.Modulo = 'COMSG'
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  --BUG22833
  JOIN EmpresaCfgMov ON EmpresaCfgMov.Empresa = c.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND cxp.Mov = EmpresaCfgMov.Gasto
   AND (mt.Clave IN ('COMS.EI') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'GAS' 
   AND mme.ModuloID IS NULL
   --BUG24040
   AND 1 = CASE ISNULL(em.COMSIVAImportacionAnticipado, 0)
             WHEN 0 THEN 1
             ELSE CASE ISNULL(Concepto.EsIVAImportacion, 0)
                    WHEN 0 THEN 1
                    ELSE 0
                   END
             END
GO

--BUG24040
/*** MFACompraPreCalc6 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPreCalc6') and type = 'V') drop view dbo.MFACompraPreCalc6
GO
CREATE VIEW MFACompraPreCalc6 AS
SELECT
  ID					 = cxp.ID,
  Estatus                = cxp.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,cxp.ID))),
  empresa                = cxp.Empresa,
  emisor                 = 'terceros',
  --BUG24040
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('COMS.EI') THEN 'factura'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CASE  
                             WHEN mt.Clave IN ('COMS.F','COMS.FL','COMS.EG', 'COMS.EI','COMS.CA','COMS.GX') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.B') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('COMS.D') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END,                                                                               
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = cxp.Ejercicio,
  periodo                = cxp.Periodo,
  dia                    = DAY(cxp.FechaEmision),
  --BUG22460
  fecha					 = cxp.FechaEmision,
  entidad_clave          = cxp.Proveedor,
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = p.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = p.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = Concepto.Concepto,
  --BUG24040
  acumulable_deducible   = dbo.fmMFAAcumulableDeducibleCOMSEI(Concepto.Concepto, Cxp.Empresa, Cxp.Mov, em.COMSIVAImportacionAnticipado),
  importe                = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),  
  retencion_isr          = SUM(ctc.Retencion2Total*c.TipoCambio),
  retencion_iva          = SUM(ctc.Retencion1Total*c.TipoCambio),
  base_iva               = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),  
  --BUG24915
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = ISNULL(NULLIF(dbo.fnMFAIVATasa(cxp.Empresa, cxp.Importe, cxp.Impuestos), 0), eg.DefImpuesto),  
  --iva                    = 2*dbo.fnMFAIVA(cxp.Empresa,cxp.Importe,cxp.Impuestos)*cxp.TipoCambio,}
  --BUG24915
  iva                    = (ISNULL(cxp.Importe, 0) + ISNULL(cxp.Impuestos, 0))*cxp.TipoCambio,
  base_ieps              = SUM(((ISNULL(ctc.SubTotal,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(ctc.Impuesto2Total,0.0) ELSE 0.0 END)*c.TipoCambio) + dbo.fnMFABaseIVAImportacion(c.Mov, c.MovID, ctc.ImporteMov, ctc.ImporteTotal, c.Empresa, em.COMSCalcularBaseImportacion)),
  --BUG24915
  ieps_tasa              = ROUND(((CONVERT(float,cxp.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(cxp.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,cxp.Importe),0.0),2)*100.0,
  ieps                   = (ISNULL(CONVERT(float,cxp.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,cxp.IEPSFiscal),0.0)*cxp.TipoCambio,
  --ieps_tasa              = CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(cd.Impuesto2, 0) ELSE 0 END,
  --ieps                   = SUM(CASE ma.Impuesto WHEN 'Impuesto 2' THEN ISNULL(ctc.Impuesto2Total, 0)*c.TipoCambio ELSE ISNULL(ctc.Impuesto3Total, 0)*c.TipoCambio END),
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = Concepto.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353 BUG24040
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,	
  TipoActividad			   = MFATipoActividad.Tipo,
  BaseIVAImportacion	   = -1
  --BaseIVAImportacion	   = ISNULL(dbo.fnMFABaseIVAImportacionAnticipado(c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion), 0)
  --FROM Cxp cxp 
  --JOIN Compra c ON c.MovID = cxp.OrigenID AND c.Mov = cxp.Origen AND cxp.OrigenTipo = 'COMS' AND c.Empresa = cxp.Empresa  
  FROM Cxp cxp
  JOIN Gasto g ON cxp.OrigenTipo = 'GAS' AND cxp.Empresa = g.Empresa AND cxp.Origen = g.Mov AND cxp.OrigenID = g.MovID
  JOIN GastoD gd ON g.ID = gd.ID  
  JOIN Compra c ON g.OrigenTipo = 'COMS' AND g.Empresa = c.Empresa AND g.Origen = c.Mov AND g.OrigenID = c.MovID   
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'COMS'
  --BUG22833
  JOIN Prov p ON p.Proveedor = c.Proveedor 

  JOIN CompraD cd ON cd.ID = c.ID
  
  JOIN MFACompraTCalc ctc ON ctc.RenglonSub = cd.RenglonSub AND ctc.Renglon = cd.Renglon AND ctc.ID = cd.ID 
  JOIN Art a ON a.Articulo = cd.Articulo   
  LEFT OUTER JOIN MFAArt ma ON ma.Articulo = a.Articulo
  
  LEFT OUTER JOIN Concepto ON Concepto.Concepto = gd.Concepto AND Concepto.Modulo = 'COMSG'
  
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente   
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa
  JOIN EmpresaMFA em ON em.Empresa = c.Empresa
  JOIN EmpresaCfg2 ec ON ec.Empresa = em.Empresa
  --BUG22833
  JOIN EmpresaCfgMov ON EmpresaCfgMov.Empresa = c.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = c.ID  
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'COMS' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND cxp.Mov = EmpresaCfgMov.Gasto
   AND (mt.Clave IN ('COMS.EI') OR (mtmda.Modulo IS NOT NULL))
   AND mtmde.Mov IS NULL
   AND cxp.OrigenTipo = 'GAS' 
   AND mme.ModuloID IS NULL
   AND ISNULL(Concepto.EsIVAImportacion, 0) = 1
   AND ISNULL(em.COMSIVAImportacionAnticipado, 0) = 1
   GROUP BY cxp.ID, cxp.Estatus, mt.Clave, mtmda.DocumentoTipo, fr.Extranjero, cxp.Mov, cxp.MovID, cxp.Ejercicio, cxp.Periodo, cxp.FechaEmision, cxp.Proveedor, 
            --BUG24915
            p.Nombre, p.RFC,p.MFATipoOperacion, mp.Pais, mp.Nacionalidad, p.Agente, ag.Nombre, cxp.Concepto, Concepto.Concepto, Cxp.Empresa, em.COMSIVAImportacionAnticipado, /*a.Impuesto1Excento, */
            --BUG24915
            Cxp.Importe, Cxp.Impuestos, Cxp.TipoCambio, /*cd.Impuesto2, */cxp.Dinero, cxp.DineroID, MFATipoActividad.Tipo, /*ma.Impuesto, */ Cxp.IEPSFiscal,
            c.Mov, c.MovID, c.Empresa, em.COMSCalcularBaseImportacion, eg.DefImpuesto          
GO

--SELECT * FROM MFACompraPreCalc

/*** MFACompraCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraCalc') and type = 'V') drop view dbo.MFACompraCalc
GO
CREATE VIEW MFACompraCalc
AS
SELECT
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion = 0,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG22833
  BaseIVAImportacion
FROM MFACompraPreCalc
--BUG16901
UNION ALL
SELECT
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion = 1,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG22833
  BaseIVAImportacion
FROM MFACompraPreCalc2
--BUG22833
UNION ALL
SELECT
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion = 1,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG22833
  BaseIVAImportacion
FROM MFACompraPreCalc3
--BUG24040
UNION ALL
SELECT
  id,
  concepto_clave,
  concepto_es_importacion = 1,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  BaseIVAImportacion
FROM MFACompraPreCalc4
--BUG24040
UNION ALL
SELECT
  id,
  concepto_clave,
  concepto_es_importacion = 1,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  BaseIVAImportacion
FROM MFACompraPreCalc5
--BUG24040
UNION ALL
SELECT
  id,
  concepto_clave,
  concepto_es_importacion = 1,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,      
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  BaseIVAImportacion
FROM MFACompraPreCalc6
GO

--select * from MFACompraCalc

/*** MFACompraPendientePreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPendientePreCalc') and type = 'V') drop view dbo.MFACompraPendientePreCalc
GO
CREATE VIEW MFACompraPendientePreCalc AS
SELECT DISTINCT
  c.ID,
  p.Empresa,
  p.Origen,
  p.OrigenID,
  YEAR(c.FechaEmision) Ejercicio,
  MONTH(c.FechaEmision) Periodo
  FROM Cxp p 
  JOIN Compra c ON c.MovID = p.OrigenID AND c.Mov = p.Origen
 WHERE p.OrigenTipo = 'COMS' 
   --AND p.Estatus = 'PENDIENTE'
   AND c.Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--select * from mfacomprapendienteprecalc

/*** MFACompraPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACompraPendienteCalc') and type = 'V') drop view dbo.MFACompraPendienteCalc
GO
CREATE VIEW MFACompraPendienteCalc AS
SELECT 
  mcc.origen_tipo,
  mcc.origen_modulo,
  mcc.origen_id,
  mcc.empresa,
  mcc.emisor,
  mcc.tipo_documento,
  mcc.subtipo_documento,
  mcc.folio,
  mcc.ejercicio,
  mcc.periodo,
  mcc.dia,
  --BUG22460
  mcc.fecha,
  mcc.entidad_clave,
  mcc.entidad_nombre,
  mcc.entidad_rfc,
  mcc.entidad_id_fiscal,
  mcc.entidad_tipo_tercero,
  mcc.entidad_tipo_operacion,
  mcc.entidad_pais,
  mcc.entidad_nacionalidad,
  mcc.agente_clave,
  mcc.agente_nombre,
  mcc.concepto,
  mcc.acumulable_deducible,
  mcc.importe,
  mcc.retencion_isr,
  mcc.retencion_iva,
  mcc.base_iva,
  mcc.iva_excento,
  mcc.iva_tasa,
  mcc.iva, 
  mcc.base_ieps,
  mcc.ieps_tasa,
  mcc.ieps,
  mcc.base_isan,
  mcc.isan,
  mcc.ieps_num_reporte,
  mcc.ieps_categoria_concepto,
  mcc.ieps_exento,
  mcc.ieps_envase_reutilizable,
  mcc.ieps_retencion, 
  mcc.ieps_cantidad, 
  mcc.ieps_unidad, 
  mcc.ieps_cantidad2,
  mcc.ieps_unidad2,      
  mcc.importe_total,
  mcc.concepto_clave,
  --REQ16748
  mcc.concepto_es_importacion,
  mcc.dinero,
  mcc.dinero_id,
  --BUG20353
  mcc.concepto_aplica_ietu,
  mcc.concepto_aplica_ieps,
  mcc.concepto_aplica_iva,
  --BUG22156
  mcc.EsActivoFijo, 
  mcc.TipoActivo, 
  mcc.TipoActividad,
  --BUG22833
  mcc.BaseIVAImportacion
  FROM MFACompraCalc mcc
  --BUG23552
  --JOIN MFACompraPendientePreCalc mcppc ON mcppc.ID = mcc.ID  
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'COMS' AND mme.ModuloID = mcc.ID
 WHERE mme.ModuloID IS NULL
GO

--select * from mfacomprapendientecalc
--select * from movtipo where modulo = 'GAS' ORDER BY CLAVE

/*** MFAGastoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoPreCalc') and type = 'V') drop view dbo.MFAGastoPreCalc
GO
CREATE VIEW MFAGastoPreCalc AS
SELECT
  ID                     = g.ID,
  concepto_clave         = gd.Concepto,
  --REQ16748
  concepto_es_importacion= ISNULL(co.EsImportacion, 0),
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,g.ID))),
  empresa                = g.Empresa,
  emisor                 = 'terceros',  
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 'factura'
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdeg.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                                                          
  folio                  = RTRIM(ISNULL(cxp.Mov,'')) + ' ' + RTRIM(ISNULL(cxp.MovID,'')),
  ejercicio              = g.Ejercicio,
  periodo                = g.Periodo,
  dia                    = DAY(g.FechaEmision),
  --BUG22460
  fecha					 = g.FechaEmision,
  entidad_clave          = p.Proveedor,  
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = CASE
                             WHEN co.TipoOperacion IN ('Renta') THEN 'arrendamiento_inmuebles'
                             WHEN co.TipoOperacion IN ('Honorarios', 'Importacion Servicios') THEN 'prestacion_servicios'
                             WHEN co.TipoOperacion NOT IN ('Honorarios', 'Importacion Servicios', 'Renta') THEN 'otros' 
                           END,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = gd.Concepto,
  --BUG17795
  acumulable_deducible   = CASE WHEN ISNULL(co.MFAEsDeducible,0) = 1 THEN 'Si' ELSE 'No' END,
  importe                = gd.Importe*g.TipoCambio,
  retencion_isr          = gd.Retencion*g.TipoCambio, 
  retencion_iva          = gd.Retencion2*g.TipoCambio,   
  base_iva               = (ISNULL(gd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(gd.Impuestos2,0.0) ELSE 0.0 END)*g.TipoCambio,  
  iva_excento            = ISNULL(co.Impuesto1Excento,0)*g.TipoCambio,
--REQ25087
  iva_tasa               = CASE 
                             WHEN NULLIF(gd.Impuestos,0.0) IS NULL THEN NULL
                             ELSE 
                               CASE 
                                 WHEN NULLIF(gd.Impuesto1, 0) IS NULL THEN dbo.fnMFAIVATasa(g.Empresa, gd.Importe,gd.Impuestos) 
                                 ELSE gd.Impuesto1
                               END                              
                           END,
  iva                    = ISNULL(gd.Impuestos,0.0)*g.TipoCambio,
  base_ieps              = gd.Importe*g.TipoCambio,
  ieps_tasa              = CASE WHEN NULLIF(gd.Impuestos2,0.0) IS NULL THEN NULL ELSE  gd.Impuesto2 END,    
  ieps                   = ISNULL(gd.Impuestos2,0.0)*g.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = mcg.IEPSNumReporte,
  ieps_categoria_concepto  = mcg.IEPSCategoriaConcepto,
  ieps_exento              = mcg.IEPSExento,
  ieps_envase_reutilizable = mcg.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 1, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = CONVERT(float,NULL),
  ieps_unidad2             = CONVERT(varchar(50),NULL),
  dinero				   = cxp.Dinero,
  dinero_id				   = cxp.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG24733
  PorcentajeDeducible	   = dbo.fnMFAGASImporte(ISNULL(emfa.GASPorcentajeDeducible, 0), gd.PorcentajeDeducible)
  FROM Cxp cxp 
  JOIN Gasto g ON g.MovID = cxp.OrigenID AND g.Mov = cxp.Origen AND cxp.OrigenTipo = 'GAS' AND g.Empresa = cxp.Empresa
  JOIN MovTipo mt ON mt.Mov = g.Mov AND mt.Modulo = 'GAS' 
  JOIN GastoD gd ON gd.ID = g.ID   
  JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(gd.AcreedorRef,''),g.Acreedor) 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = p.Agente 
  JOIN Concepto co ON co.Concepto = gd.Concepto AND co.Modulo = 'GAS' 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON co.Concepto = mtmce.Concepto    
  JOIN EmpresaGral eg ON eg.Empresa = g.Empresa
  --BUG24733
  LEFT OUTER JOIN EmpresaMFA emfa ON eg.Empresa = emfa.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = g.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'GAS' AND mtmde.Mov = g.Mov        
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'GAS' AND mtmda.Mov = g.Mov
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionGas mmdtdeg ON ISNULL(NULLIF(mmdtdeg.ConceptoGas,''),co.Concepto) = co.Concepto AND mmdtdeg.Mov = g.Mov AND mmdtdeg.Modulo = 'GAS'   
  LEFT OUTER JOIN MFAConceptoGas mcg ON mcg.ConceptoGas = co.Concepto      
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'GAS' AND MFATipoActividad.Mov = g.Mov  
 WHERE g.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxp.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND (mt.Clave IN ('GAS.A','GAS.DA', 'GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.DG','GAS.DC','GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB') OR mtmda.Modulo IS NOT NULL)
   AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFADocExcepcion WHERE Modulo = 'GAS')       
   --BUG17768 BUG17795
   AND ISNULL(co.MFAEsDeducible,0) = 1
   AND mme.ModuloID IS NULL
   AND mtmde.Mov IS NULL
GO

/*** MFAGastoComprobantePreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoComprobantePreCalc') and type = 'V') drop view dbo.MFAGastoComprobantePreCalc
GO
CREATE VIEW MFAGastoComprobantePreCalc AS
SELECT
  ID                     = g.ID,
  concepto_clave         = gd.Concepto,
  --REQ16748
  concepto_es_importacion= ISNULL(co.EsImportacion, 0),  
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,g.ID))),
  empresa                = g.Empresa,
  emisor                 = 'terceros',  
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('GAS.C') THEN 'factura'
                             --WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdeg.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                                                          
  folio                  = RTRIM(ISNULL(g.Mov,'')) + ' ' + RTRIM(ISNULL(g.MovID,'')),
  ejercicio              = g.Ejercicio,
  periodo                = g.Periodo,
  dia                    = DAY(g.FechaEmision),
  --BUG22460
  fecha					 = g.FechaEmision,
  entidad_clave          = p.Proveedor,  
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = CASE
                             WHEN co.TipoOperacion IN ('Renta') THEN 'arrendamiento_inmuebles'
                             WHEN co.TipoOperacion IN ('Honorarios', 'Importacion Servicios') THEN 'prestacion_servicios'
                             WHEN co.TipoOperacion NOT IN ('Honorarios', 'Importacion Servicios', 'Renta') THEN 'otros' 
                           END,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = gd.Concepto,   
  --BUG17795
  acumulable_deducible   = CASE WHEN ISNULL(co.MFAEsDeducible,0) = 1 THEN 'Si' ELSE 'No' END,
  importe                = gd.Importe*g.TipoCambio,
  retencion_isr          = gd.Retencion*g.TipoCambio, 
  retencion_iva          = gd.Retencion2*g.TipoCambio,   
  base_iva               = (ISNULL(gd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(gd.Impuestos2,0.0) ELSE 0.0 END)*g.TipoCambio,  
  iva_excento            = ISNULL(co.Impuesto1Excento,0)*g.TipoCambio,
  --REQ25087
  iva_tasa               = CASE 
                             WHEN NULLIF(gd.Impuestos,0.0) IS NULL THEN NULL
                             ELSE 
                               CASE 
                                 WHEN NULLIF(gd.Impuesto1, 0) IS NULL THEN dbo.fnMFAIVATasa(g.Empresa, gd.Importe,gd.Impuestos) 
                                 ELSE gd.Impuesto1
                               END                              
                           END,
  iva                    = ISNULL(gd.Impuestos,0.0)*g.TipoCambio,
  base_ieps              = gd.Importe*g.TipoCambio,
  ieps_tasa              = gd.Impuesto2,    
  ieps                   = ISNULL(gd.Impuestos2,0.0)*g.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = mcg.IEPSNumReporte,
  ieps_categoria_concepto  = mcg.IEPSCategoriaConcepto,
  ieps_exento              = mcg.IEPSExento,
  ieps_envase_reutilizable = mcg.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 1, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = CONVERT(float,NULL),
  ieps_unidad2             = CONVERT(varchar(50),NULL),
  dinero				   = g.Dinero,
  dinero_id				   = g.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si')  ,
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG24733
  PorcentajeDeducible	   = dbo.fnMFAGASImporte(ISNULL(emfa.GASPorcentajeDeducible, 0), gd.PorcentajeDeducible)
  FROM Gasto g 
  JOIN MovTipo mt ON mt.Mov = g.Mov AND mt.Modulo = 'GAS' 
  JOIN GastoD gd ON gd.ID = g.ID   
  JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(gd.AcreedorRef,''),g.Acreedor) 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = p.Agente 
  JOIN Concepto co ON co.Concepto = gd.Concepto AND co.Modulo = 'GAS'
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON co.Concepto = mtmce.Concepto     
  JOIN EmpresaGral eg ON eg.Empresa = g.Empresa
  --BUG24733
  LEFT OUTER JOIN EmpresaMFA emfa on eg.Empresa = emfa.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = g.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'GAS' AND mtmde.Mov = g.Mov        
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'GAS' AND mtmda.Mov = g.Mov     
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionGas mmdtdeg ON ISNULL(NULLIF(mmdtdeg.ConceptoGas,''),co.Concepto) = co.Concepto AND mmdtdeg.Mov = g.Mov AND mmdtdeg.Modulo = 'GAS'   
  LEFT OUTER JOIN MFAConceptoGas mcg ON mcg.ConceptoGas = co.Concepto      
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'GAS' AND MFATipoActividad.Mov = g.Mov
 WHERE g.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND (mt.Clave IN ('GAS.C') OR mtmda.Modulo IS NOT NULL)
   AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFADocExcepcion WHERE Modulo = 'GAS')       
   --BUG17768 BUG17795
   AND ISNULL(co.MFAEsDeducible,0) = 1
   AND mme.ModuloID IS NULL
   AND mtmde.Mov IS NULL  
GO

/*** MFAGastoDineroPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoDineroPagoCalc') and type = 'V') drop view dbo.MFAGastoDineroPagoCalc
GO
CREATE VIEW MFAGastoDineroPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --importe                = SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0))*c.TipoCambio),
  --BUG19418
  importe                = SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio),
  cuenta_bancaria        = NULL,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),  
  --CONCILIACION
  conciliado			= ISNULL(c.DineroConciliado, 0),
  dinero				= c.Dinero,
  dinero_id				= c.DineroID,
  --BUG18767
  tipo_documento		= mtmpa.DocumentoTipo
  FROM Gasto c
  JOIN GastoD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
  --BUG24960 BUG25242
  LEFT OUTER JOIN MovTipo mto ON mto.Mov = c.Origen AND mto.Modulo = c.OrigenTipo 
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = c.ID      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmpa ON mtmpa.Modulo = 'GAS' AND mtmpa.Mov = c.Mov                        
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmcpe ON mtmcpe.Modulo = 'GAS' AND mtmcpe.Mov = c.Mov   
  --BUG20341
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'GAS' AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'GAS' AND mtmree.Mov = c.Mov           
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'GAS' AND mtdc.Mov = c.Mov  
  --BUG19418
  JOIN Concepto co ON co.Concepto = cd.Concepto AND co.Modulo = 'GAS'     
  LEFT OUTER JOIN MFAConceptoGas mcg ON mcg.ConceptoGas = co.Concepto     
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   --BUG18131
   AND (mt.Clave IN (/*'GAS.A','GAS.DA', 'GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.CCH','GAS.CP','GAS.DG',*/'GAS.CB', 'GAS.CCH', 'GAS.G', 'GAS.DC'/*,'GAS.DGP', 'GAS.OI', 'GAS.AB'*/) OR mtmpa.Modulo IS NOT NULL)
   AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = c.ID AND DModulo IN('CXC', 'CXP'))
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))                
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
   --BUG19418
   AND ISNULL(co.MFAEsDeducible,0) = 1
   --BUG24960
   AND ISNULL(mto.Clave, '') <> 'GAS.GP'
   --BUG18599 BUG22460
 GROUP BY RTRIM(LTRIM(CONVERT(varchar,c.ID))), c.Empresa, ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), c.Ejercicio, c.Periodo, DAY(c.FechaEmision), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'), ISNULL(c.DineroConciliado, 0), c.Dinero, c.DineroID, mtdc.Mov, c.DineroFechaConciliacion, mtmpa.DocumentoTipo, c.FechaEmision
GO

--BUG18278
/*** MFAGastoConceptoPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoConceptoPagoCalc') and type = 'V') drop view dbo.MFAGastoConceptoPagoCalc
GO
CREATE VIEW MFAGastoConceptoPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,  
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0)-ISNULL(cd.Retencion,0.0)-ISNULL(cd.Retencion2,0.0))*c.TipoCambio),
  cuenta_bancaria        = NULL,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),  
  --CONCILIACION
  conciliado			= ISNULL(c.DineroConciliado, 0),
  dinero			    = c.Dinero,
  dinero_id			    = c.DineroID,
  --BUG18767
  tipo_documento		= mtmpa.DocumentoTipo
  FROM Gasto c
  JOIN GastoD cd ON cd.ID = c.ID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = c.ID
  LEFT OUTER JOIN MovTipoMFACompDocAdicion mtmpa ON mtmpa.Modulo = 'GAS' AND mtmpa.Mov = c.Mov
  LEFT OUTER JOIN MovTipoMFACompDocExcepcion mtmcpe ON mtmcpe.Modulo = 'GAS' AND mtmcpe.Mov = c.Mov
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'GAS'AND mtmac.Mov = c.Mov
  JOIN Concepto co ON co.Concepto = cd.Concepto AND co.Modulo = 'GAS' 
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'GAS' AND mtmree.Mov = c.Mov           
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'GAS' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('GAS.C') OR mtmpa.Modulo IS NOT NULL)
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
   AND ISNULL(co.MFAEsDeducible,0) = 1
   --BUG22460
 GROUP BY RTRIM(LTRIM(CONVERT(varchar,c.ID))), c.Empresa, ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), c.Ejercicio, c.Periodo, DAY(c.FechaEmision), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'), ISNULL(c.DineroConciliado, 0), c.Dinero, c.DineroID, mtdc.Mov, c.DineroFechaConciliacion, mtmpa.DocumentoTipo, c.FechaEmision
GO

/*** MFAGastoPagoCalc ***/-- angel
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoPagoCalc') and type = 'V') drop view dbo.MFAGastoPagoCalc
GO
CREATE VIEW MFAGastoPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,  
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = SUM((ISNULL(cd.Importe,0.0)+ISNULL(cd.Impuestos,0.0)+ISNULL(cd.Impuestos2,0.0))*c.TipoCambio),
  cuenta_bancaria        = NULL,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),  
  --CONCILIACION
  conciliado			= ISNULL(c.DineroConciliado, 0),
  dinero			    = c.Dinero,
  dinero_id			    = c.DineroID,
  --BUG18767
  tipo_documento		= mtmpa.DocumentoTipo
  FROM Gasto c
  JOIN GastoD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'GAS'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = c.ID      
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmpa ON mtmpa.Modulo = 'GAS' AND mtmpa.Mov = c.Mov                        
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmcpe ON mtmcpe.Modulo = 'GAS' AND mtmcpe.Mov = c.Mov   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'GAS'AND mtmac.Mov = c.Mov         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'GAS' AND mtmree.Mov = c.Mov           
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'GAS' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('GAS.C') OR mtmpa.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))                
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
   --BUG22460
 GROUP BY RTRIM(LTRIM(CONVERT(varchar,c.ID))), c.Empresa, ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), c.Ejercicio, c.Periodo, DAY(c.FechaEmision), RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')), ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'), ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'), ISNULL(c.DineroConciliado, 0), c.Dinero, c.DineroID, mtdc.Mov, c.DineroFechaConciliacion, mtmpa.DocumentoTipo, c.FechaEmision
GO

--select * from gasto where mov = 'comprobante ppto' and movid = '247'
--select * from gastod where id = 51019

/*** MFAGastoCxcPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCxcPreCalc') and type = 'V') drop view dbo.MFAGastoCxcPreCalc
GO
CREATE VIEW MFAGastoCxcPreCalc AS
SELECT
  id                     = g.id,
  concepto_clave         = gd.Concepto,
  --REQ16748
  concepto_es_importacion= ISNULL(co.EsImportacion, 0),
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,g.ID))),
  empresa                = g.Empresa,
  emisor                 = 'terceros',  
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 'factura'
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdeg.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.CB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                                                                                     
  folio                  = RTRIM(ISNULL(cxc.Mov,'')) + ' ' + RTRIM(ISNULL(cxc.MovID,'')),
  ejercicio              = g.Ejercicio,
  periodo                = g.Periodo,
  dia                    = DAY(g.FechaEmision),
  --BUG22460
  fecha					 = g.FechaEmision,  
  entidad_clave          = p.Proveedor,  
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = CASE
                             WHEN co.TipoOperacion IN ('Renta') THEN 'arrendamiento_inmuebles'
                             WHEN co.TipoOperacion IN ('Honorarios', 'Importacion Servicios') THEN 'prestacion_servicios'
                             WHEN co.TipoOperacion NOT IN ('Honorarios', 'Importacion Servicios', 'Renta') THEN 'otros' 
                           END,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = gd.Concepto,   
  --BUG17795
  acumulable_deducible   = CASE WHEN ISNULL(co.MFAEsDeducible,0) = 1 THEN 'Si' ELSE 'No' END,
  importe                = gd.Importe*g.TipoCambio,
  retencion_isr          = gd.Retencion*g.TipoCambio, 
  retencion_iva          = gd.Retencion2*g.TipoCambio,   
  base_iva               = (ISNULL(gd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(gd.Impuestos2,0.0) ELSE 0.0 END)*g.TipoCambio,  
  iva_excento            = ISNULL(co.Impuesto1Excento,0)*g.TipoCambio,
--REQ25087
  iva_tasa               = CASE 
                             WHEN NULLIF(gd.Impuestos,0.0) IS NULL THEN NULL
                             ELSE 
                               CASE 
                                 WHEN NULLIF(gd.Impuesto1, 0) IS NULL THEN dbo.fnMFAIVATasa(g.Empresa, gd.Importe,gd.Impuestos) 
                                 ELSE gd.Impuesto1
                               END                              
                           END,
  iva                    = ISNULL(gd.Impuestos,0.0)*g.TipoCambio,
  base_ieps              = gd.Importe*g.TipoCambio,
  ieps_tasa              = gd.Impuesto2,    
  ieps                   = ISNULL(gd.Impuestos2,0.0)*g.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = mcg.IEPSNumReporte,
  ieps_categoria_concepto  = mcg.IEPSCategoriaConcepto,
  ieps_exento              = mcg.IEPSExento,
  ieps_envase_reutilizable = mcg.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 1, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = CONVERT(float,NULL),
  ieps_unidad2             = CONVERT(varchar(50),NULL),
  dinero				   = cxc.Dinero,
  dinero_id				   = cxc.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG24733
  PorcentajeDeducible	   = dbo.fnMFAGASImporte(ISNULL(emfa.GASPorcentajeDeducible, 0), gd.PorcentajeDeducible)
  FROM Cxc cxc 
  JOIN Gasto g ON g.MovID = cxc.OrigenID AND g.Mov = cxc.Origen AND cxc.OrigenTipo = 'GAS' AND g.Empresa = cxc.Empresa
  JOIN MovTipo mt ON mt.Mov = g.Mov AND mt.Modulo = 'GAS' 
  JOIN GastoD gd ON gd.ID = g.ID   
  JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(gd.AcreedorRef,''),g.Acreedor) 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = p.Agente 
  JOIN Concepto co ON co.Concepto = gd.Concepto AND co.Modulo = 'GAS' 
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON co.Concepto = mtmce.Concepto    
  JOIN EmpresaGral eg ON eg.Empresa = g.Empresa
  --BUG24733
  LEFT OUTER JOIN EmpresaMFA emfa ON eg.Empresa = emfa.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = g.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'GAS' AND mtmde.Mov = g.Mov        
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'GAS' AND mtmda.Mov = g.Mov     
  LEFT OUTER JOIN MFAConceptoGas mcg ON mcg.ConceptoGas = co.Concepto
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionGas mmdtdeg ON ISNULL(NULLIF(mmdtdeg.ConceptoGas,''),co.Concepto) = co.Concepto AND mmdtdeg.Mov = g.Mov AND mmdtdeg.Modulo = 'GAS'   
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'GAS' AND MFATipoActividad.Mov = g.Mov
 WHERE g.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND cxc.Estatus IN ('CONCLUIDO','PENDIENTE')    
   AND (mt.Clave IN ('GAS.A','GAS.DA', 'GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.C','GAS.CCH','GAS.CP','GAS.DG','GAS.DC','GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB') OR mtmda.Modulo IS NOT NULL)
   AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFADocExcepcion WHERE Modulo = 'GAS')       
   --BUG17768 BUG17795
   AND ISNULL(co.MFAEsDeducible,0) = 1
   AND mme.ModuloID IS NULL
   AND mtmde.Mov IS NULL
GO

--BUG17507
/*** MFADineroPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroPreCalc') and type = 'V') drop view dbo.MFADineroPreCalc
GO
CREATE VIEW MFADineroPreCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'DIN',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = d.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'pago'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  ejercicio              = d.Ejercicio,
  periodo                = d.Periodo,
  dia                    = DAY(d.FechaEmision),
  --BUG22460
  fecha					 = d.FechaEmision,  
  Referencia             = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  importe                = d.Importe*d.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = d.Retencion*d.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,d.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,d.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,d.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,d.IEPSFiscal),0.0)) ELSE 0.0 END)*d.TipoCambio,
  iva_excento            = 0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(d.Empresa, d.Importe,d.Impuestos),  
  iva                    = dbo.fnMFAIVA(d.Empresa,d.Importe,d.Impuestos)*d.TipoCambio,  
  base_ieps              = ISNULL(d.Importe,0.0)*d.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,d.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(d.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(d.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,d.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,d.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,d.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,d.IEPSFiscal),0.0)*d.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  --BUG16247
  aplica_ietu            = 'Si',--ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = 'Si',--ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = 'Si',--ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(d.Conciliado, 0),
  dinero				 = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN Version ver ON 1 = 1  
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(d.OrigenTipo, '')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(d.Origen, '')) = ISNULL(d.Origen,'')                    
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'')         
  --BUG16247
  --LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'DIN' AND mtmree.Mov = d.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
 WHERE d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.A', 'DIN.AB', 'DIN.ACXC', 'DIN.ACXP', 'DIN.AP', 'DIN.C', 'DIN.CB', 'DIN.CD', 'DIN.CH', 'DIN.CHE', 'DIN.CNI', 'DIN.CP', 'DIN.D', 'DIN.DA', 'DIN.DE', 'DIN.DF', 'DIN.E', 'DIN.F', 'DIN.I', 'DIN.INV', 'DIN.PR', 'DIN.RE', 'DIN.REI', 'DIN.RET', 'DIN.RND', 'DIN.SCH', 'DIN.SD', 'DIN.T', 'DIN.TC') OR mtmaa.Modulo IS NOT NULL)
   AND d.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--BUG18599
/*** MFADineroAnticipadoCobroPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroAnticipadoCobroPreCalc') and type = 'V') drop view dbo.MFADineroAnticipadoCobroPreCalc
GO
CREATE VIEW MFADineroAnticipadoCobroPreCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'DIN',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = d.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'cobro'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Ejercicio ELSE YEAR(d.FechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Periodo ELSE MONTH(d.FechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(d.FechaEmision) ELSE DAY(d.FechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.FechaEmision ELSE d.FechaConciliacion END,
  Referencia             = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  importe                = ROUND((d.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*d.TipoCambio, 2),
  retencion_isr          = 0.0, 
  retencion_iva          = d.Retencion*d.TipoCambio,
  base_iva               = ROUND((d.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*d.TipoCambio, 2),
  iva_excento            = 0,
  iva_tasa               = emfa.DINImpuesto1,  
  iva                    = ROUND((d.Importe-(d.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*d.TipoCambio), 2),
  base_ieps              = ROUND((d.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*d.TipoCambio, 2),
  ieps_tasa               = ROUND(((CONVERT(float,d.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(d.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(d.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,d.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,d.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,d.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,d.IEPSFiscal),0.0)*d.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  aplica_ietu            = 'Si',--ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = 'Si',--ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = 'Si',--ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  conciliado			 = ISNULL(d.Conciliado, 0),
  dinero				 = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN Version ver ON 1 = 1  
  JOIN EmpresaMFA emfa ON d.Empresa = emfa.Empresa
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(d.OrigenTipo, '')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(d.Origen, '')) = ISNULL(d.Origen,'')                    
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'DIN' AND mtdc.Mov = d.Mov
 WHERE d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.DA') OR mtmaa.Modulo IS NOT NULL)
   AND d.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--BUG18599
/*** MFADineroAnticipadoCobroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroAnticipadoCobroCalc') and type = 'V') drop view dbo.MFADineroAnticipadoCobroCalc
GO
CREATE VIEW MFADineroAnticipadoCobroCalc AS
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFADineroAnticipadoCobroPreCalc
GO

--BUG17507
/*** MFADineroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroCalc') and type = 'V') drop view dbo.MFADineroCalc
GO
CREATE VIEW MFADineroCalc AS
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFADineroPreCalc
GO

/*** MFAGastoDineroPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoDineroPreCalc') and type = 'V') drop view dbo.MFAGastoDineroPreCalc
GO
CREATE VIEW MFAGastoDineroPreCalc AS
SELECT
  ID                     = g.ID,
  concepto_clave         = gd.Concepto,
  --REQ16748
  concepto_es_importacion= ISNULL(co.EsImportacion, 0),  
  origen_tipo            = 'auto',
  origen_modulo          = 'GAS',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,g.ID))),
  empresa                = g.Empresa,
  emisor                 = 'terceros',  
  tipo_documento         = CASE
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.CCH','GAS.CP','GAS.CB') THEN 'factura'
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = ISNULL(NULLIF(mmdtdeg.SubTipoDocumento,''),CASE  
                             WHEN mt.Clave IN ('GAS.A','GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.CCH','GAS.CP','GAS.CB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             WHEN mt.Clave IN ('GAS.DA','GAS.DG','GAS.DC','GAS.DGP','GAS.OI','GAS.AB') THEN 
                               (CASE WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'adquisicion' ELSE 'importacion' END)
                             ELSE ''  
                           END),                                                                                                          
  folio                  = RTRIM(ISNULL(g.Mov,'')) + ' ' + RTRIM(ISNULL(g.MovID,'')),
  ejercicio              = g.Ejercicio,
  periodo                = g.Periodo,
  dia                    = DAY(g.FechaEmision),
  --BUG22460
  fecha                  = g.FechaEmision,
  entidad_clave          = p.Proveedor,  
  entidad_nombre         = p.Nombre,
  entidad_rfc            = p.RFC,
  entidad_id_fiscal      = CASE
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN p.RFC 
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN p.ImportadorRegistro
                           END,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = CASE
                             WHEN co.TipoOperacion IN ('Renta') THEN 'arrendamiento_inmuebles'
                             WHEN co.TipoOperacion IN ('Honorarios', 'Importacion Servicios') THEN 'prestacion_servicios'
                             WHEN co.TipoOperacion NOT IN ('Honorarios', 'Importacion Servicios', 'Renta') THEN 'otros' 
                           END,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = p.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = gd.Concepto,   
  --BUG17795
  acumulable_deducible   = CASE WHEN ISNULL(co.MFAEsDeducible,0) = 1 THEN 'Si' ELSE 'No' END,
  importe                = gd.Importe*g.TipoCambio,
  retencion_isr          = gd.Retencion*g.TipoCambio, 
  retencion_iva          = gd.Retencion2*g.TipoCambio,   
  base_iva               = (ISNULL(gd.Importe,0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ISNULL(gd.Impuestos2,0.0) ELSE 0.0 END)*g.TipoCambio,  
  iva_excento            = ISNULL(co.Impuesto1Excento,0)*g.TipoCambio,
  --REQ25087
  iva_tasa               = CASE 
                             WHEN NULLIF(gd.Impuestos,0.0) IS NULL THEN NULL
                             ELSE 
                               CASE 
                                 WHEN NULLIF(gd.Impuesto1, 0) IS NULL THEN dbo.fnMFAIVATasa(g.Empresa, gd.Importe,gd.Impuestos) 
                                 ELSE gd.Impuesto1
                               END                              
                           END,
  iva                    = ISNULL(gd.Impuestos,0.0)*g.TipoCambio,
  base_ieps              = gd.Importe*g.TipoCambio,
  ieps_tasa              = CASE WHEN NULLIF(gd.Impuestos2,0.0) IS NULL THEN NULL ELSE  gd.Impuesto2 END,    
  ieps                   = ISNULL(gd.Impuestos2,0.0)*g.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = mcg.IEPSNumReporte,
  ieps_categoria_concepto  = mcg.IEPSCategoriaConcepto,
  ieps_exento              = mcg.IEPSExento,
  ieps_envase_reutilizable = mcg.IEPSEnvaseReutilizable,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 1, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = CONVERT(float,NULL),
  ieps_unidad2             = CONVERT(varchar(50),NULL),
  dinero				   = g.Dinero,
  dinero_id				   = g.DineroID,
  --BUG20353
  concepto_aplica_ietu     = ISNULL(NULLIF(mtmce.AplicaIetu,''), 'Si'),
  concepto_aplica_ieps     = ISNULL(NULLIF(mtmce.AplicaIeps,''), 'Si'),
  concepto_aplica_iva      = ISNULL(NULLIF(mtmce.AplicaIVA,''), 'Si'),
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo,
  --BUG24733
  PorcentajeDeducible	   = dbo.fnMFAGASImporte(ISNULL(emfa.GASPorcentajeDeducible, 0), gd.PorcentajeDeducible)
  FROM Gasto g
  JOIN MovTipo mt ON mt.Mov = g.Mov AND mt.Modulo = 'GAS' 
  JOIN GastoD gd ON gd.ID = g.ID   
  JOIN Prov p ON p.Proveedor = ISNULL(NULLIF(gd.AcreedorRef,''),g.Acreedor) 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = p.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = p.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais
  LEFT OUTER JOIN Agente ag ON ag.Agente = p.Agente 
  JOIN Concepto co ON co.Concepto = gd.Concepto AND co.Modulo = 'GAS'
  --BUG20353
  LEFT OUTER JOIN MovTipoMFAConceptoExcepcion mtmce ON co.Concepto = mtmce.Concepto     
  JOIN EmpresaGral eg ON eg.Empresa = g.Empresa
  --BUG24733
  LEFT OUTER JOIN EmpresaMFA emfa ON eg.Empresa = emfa.Empresa
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = g.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'GAS' AND mtmde.Mov = g.Mov        
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'GAS' AND mtmda.Mov = g.Mov
  LEFT OUTER JOIN MFAMovSubTipoDocumentoExcepcionGas mmdtdeg ON ISNULL(NULLIF(mmdtdeg.ConceptoGas,''),co.Concepto) = co.Concepto AND mmdtdeg.Mov = g.Mov AND mmdtdeg.Modulo = 'GAS'   
  LEFT OUTER JOIN MFAConceptoGas mcg ON mcg.ConceptoGas = co.Concepto      
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'GAS' AND MFATipoActividad.Mov = g.Mov
 WHERE g.Estatus IN ('CONCLUIDO','PENDIENTE')
   AND NOT EXISTS(SELECT DID FROM MovFlujo WHERE OModulo = 'GAS' AND OID = g.ID AND DModulo IN('CXC', 'CXP'))
   AND (mt.Clave IN ('GAS.A','GAS.DA', 'GAS.ASC','GAS.G','GAS.GTC','GAS.GP','GAS.CCH','GAS.CP','GAS.DG','GAS.DC','GAS.DGP', 'GAS.OI', 'GAS.CB', 'GAS.AB') OR mtmda.Modulo IS NOT NULL)
   AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFADocExcepcion WHERE Modulo = 'GAS')       
   --BUG17768 BUG17795
   AND ISNULL(co.MFAEsDeducible,0) = 1
   AND mme.ModuloID IS NULL
   AND mtmde.Mov IS NULL
GO

/*** MFAGastoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCalc') and type = 'V') drop view dbo.MFAGastoCalc
GO
CREATE VIEW MFAGastoCalc
AS
SELECT 
  id,
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG24733
  PorcentajeDeducible
FROM MFAGastoPreCalc
UNION ALL
SELECT
  id, 
  concepto_clave,
  --REQ16748
  concepto_es_importacion,  
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,  
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2, 
  ieps_unidad2, 
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG24733
  PorcentajeDeducible
FROM MFAGastoCxcPreCalc
UNION ALL
SELECT
  id, 
  concepto_clave,
  --REQ16748
  concepto_es_importacion,  
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,  
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2, 
  ieps_unidad2, 
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG24733
  PorcentajeDeducible
FROM MFAGastoComprobantePreCalc
UNION ALL
SELECT
  id, 
  concepto_clave,
  --REQ16748
  concepto_es_importacion,  
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,  
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2, 
  ieps_unidad2, 
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad,
  --BUG24733
  PorcentajeDeducible
FROM MFAGastoDineroPreCalc
GO

--select * from MFAGastoCalc

/*** MFAGastoCxpPendientePreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCxpPendientePreCalc') and type = 'V') drop view dbo.MFAGastoCxpPendientePreCalc
GO
CREATE VIEW MFAGastoCxpPendientePreCalc AS
SELECT 
  g.ID,
  p.Empresa,
  p.Origen,
  p.OrigenID,
  YEAR(g.FechaEmision) Ejercicio,
  MONTH(g.FechaEmision) Periodo
  FROM Cxp p 
  JOIN Gasto g ON g.MovID = p.OrigenID AND g.Mov = p.Origen
 WHERE p.OrigenTipo = 'GAS' 
   --AND p.Estatus = 'PENDIENTE'
   AND g.Estatus IN ('PENDIENTE','CONCLUIDO')
GO

/*** MFAGastoCxcPendientePreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCxcPendientePreCalc') and type = 'V') drop view dbo.MFAGastoCxcPendientePreCalc
GO
CREATE VIEW MFAGastoCxcPendientePreCalc AS
SELECT 
  g.ID,
  p.Empresa,
  p.Origen,
  p.OrigenID,
  YEAR(g.FechaEmision) Ejercicio,
  MONTH(g.FechaEmision) Periodo
  FROM Cxc p 
  JOIN Gasto g ON g.MovID = p.OrigenID AND g.Mov = p.Origen
 WHERE p.OrigenTipo = 'GAS' 
   --AND p.Estatus = 'PENDIENTE'
   AND g.Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--select * from MFAGastoCxpPendientePreCalc

/*** MFAGastoCxpPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCxpPendienteCalc') and type = 'V') drop view dbo.MFAGastoCxpPendienteCalc
GO
CREATE VIEW MFAGastoCxpPendienteCalc AS
SELECT 
  mgc.origen_tipo,
  mgc.origen_modulo,
  mgc.origen_id,
  mgc.empresa,
  mgc.emisor,
  mgc.tipo_documento,
  mgc.subtipo_documento,
  mgc.folio,
  mgc.ejercicio,
  mgc.periodo,
  mgc.dia,
  --BUG22460
  mgc.fecha,
  mgc.entidad_clave,
  mgc.entidad_nombre,
  mgc.entidad_rfc,
  mgc.entidad_id_fiscal,
  mgc.entidad_tipo_tercero,
  mgc.entidad_tipo_operacion,
  mgc.entidad_pais,
  mgc.entidad_nacionalidad,
  mgc.agente_clave,
  mgc.agente_nombre,
  mgc.concepto,
  mgc.acumulable_deducible,
  mgc.importe,
  mgc.retencion_isr,
  mgc.retencion_iva,
  mgc.base_iva,
  mgc.iva_excento,
  mgc.iva_tasa,
  mgc.iva, 
  mgc.base_ieps,
  mgc.ieps_tasa,
  mgc.ieps,
  mgc.base_isan,
  mgc.isan,
  mgc.ieps_num_reporte,
  mgc.ieps_categoria_concepto,
  mgc.ieps_exento,
  mgc.ieps_envase_reutilizable,
  mgc.ieps_retencion, 
  mgc.ieps_cantidad, 
  mgc.ieps_unidad, 
  mgc.ieps_cantidad2,    
  mgc.ieps_unidad2,    
  mgc.importe_total,
  mgc.concepto_clave,
  --REQ16748
  mgc.concepto_es_importacion,
  mgc.dinero,
  mgc.dinero_id,
  --BUG20353
  mgc.concepto_aplica_ietu,
  mgc.concepto_aplica_ieps,
  mgc.concepto_aplica_iva,
  --BUG22156
  mgc.EsActivoFijo, 
  mgc.TipoActivo, 
  mgc.TipoActividad,
  --BUG24733
  mgc.PorcentajeDeducible
  FROM MFAGastoCalc mgc
  JOIN MFAGastoCxpPendientePreCalc mgppc ON mgppc.ID = mgc.ID
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = mgc.ID     
 WHERE mme.ModuloID IS NULL  
GO

/*** MFAGastoDineroPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoDineroPendienteCalc') and type = 'V') drop view dbo.MFAGastoDineroPendienteCalc
GO
CREATE VIEW MFAGastoDineroPendienteCalc AS
SELECT 
  mgdpc.origen_tipo,
  mgdpc.origen_modulo,
  mgdpc.origen_id,
  mgdpc.empresa,
  mgdpc.emisor,
  mgdpc.tipo_documento,
  mgdpc.subtipo_documento,
  mgdpc.folio,
  mgdpc.ejercicio,
  mgdpc.periodo,
  mgdpc.dia,
  --BUG22460
  mgdpc.fecha,
  mgdpc.entidad_clave,
  mgdpc.entidad_nombre,
  mgdpc.entidad_rfc,
  mgdpc.entidad_id_fiscal,
  mgdpc.entidad_tipo_tercero,
  mgdpc.entidad_tipo_operacion,
  mgdpc.entidad_pais,
  mgdpc.entidad_nacionalidad,
  mgdpc.agente_clave,
  mgdpc.agente_nombre,
  mgdpc.concepto,
  mgdpc.acumulable_deducible,
  mgdpc.importe,
  mgdpc.retencion_isr,
  mgdpc.retencion_iva,
  mgdpc.base_iva,
  mgdpc.iva_excento,
  mgdpc.iva_tasa,
  mgdpc.iva, 
  mgdpc.base_ieps,
  mgdpc.ieps_tasa,
  mgdpc.ieps,
  mgdpc.base_isan,
  mgdpc.isan,
  mgdpc.ieps_num_reporte,
  mgdpc.ieps_categoria_concepto,
  mgdpc.ieps_exento,
  mgdpc.ieps_envase_reutilizable,
  mgdpc.ieps_retencion, 
  mgdpc.ieps_cantidad, 
  mgdpc.ieps_unidad, 
  mgdpc.ieps_cantidad2,    
  mgdpc.ieps_unidad2,    
  ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0) 'importe_total',
  mgdpc.concepto_clave,
  --REQ16748
  mgdpc.concepto_es_importacion,
  mgdpc.dinero,
  mgdpc.dinero_id,
  --BUG20353
  mgdpc.concepto_aplica_ietu,
  mgdpc.concepto_aplica_ieps,
  mgdpc.concepto_aplica_iva,
  --BUG22156
  mgdpc.EsActivoFijo, 
  mgdpc.TipoActivo, 
  mgdpc.TipoActividad,
  --BUG24733
  mgdpc.PorcentajeDeducible
  FROM MFAGastoDineroPreCalc mgdpc
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = mgdpc.ID     
 WHERE mme.ModuloID IS NULL
GO

/*** MFAGastoCxcPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAGastoCxcPendienteCalc') and type = 'V') drop view dbo.MFAGastoCxcPendienteCalc
GO
CREATE VIEW MFAGastoCxcPendienteCalc AS
SELECT 
  mgc.origen_tipo,
  mgc.origen_modulo,
  mgc.origen_id,
  mgc.empresa,
  mgc.emisor,
  mgc.tipo_documento,
  mgc.subtipo_documento,
  mgc.folio,
  mgc.ejercicio,
  mgc.periodo,
  mgc.dia,
  --BUG22460
  mgc.fecha,
  mgc.entidad_clave,
  mgc.entidad_nombre,
  mgc.entidad_rfc,
  mgc.entidad_id_fiscal,
  mgc.entidad_tipo_tercero,
  mgc.entidad_tipo_operacion,
  mgc.entidad_pais,
  mgc.entidad_nacionalidad,
  mgc.agente_clave,
  mgc.agente_nombre,
  mgc.concepto,
  mgc.acumulable_deducible,
  mgc.importe,
  mgc.retencion_isr,
  mgc.retencion_iva,
  mgc.base_iva,
  mgc.iva_excento,
  mgc.iva_tasa,
  mgc.iva, 
  mgc.base_ieps,
  mgc.ieps_tasa,
  mgc.ieps,
  mgc.base_isan,
  mgc.isan,
  mgc.ieps_num_reporte,
  mgc.ieps_categoria_concepto,
  mgc.ieps_exento,
  mgc.ieps_envase_reutilizable,
  mgc.ieps_retencion, 
  mgc.ieps_cantidad, 
  mgc.ieps_unidad, 
  mgc.ieps_cantidad2,    
  mgc.ieps_unidad2,    
  mgc.importe_total,
  mgc.concepto_clave,
  --REQ16748
  mgc.concepto_es_importacion,
  mgc.dinero,
  mgc.dinero_id,
  --BUG20353
  mgc.concepto_aplica_ietu,
  mgc.concepto_aplica_ieps,
  mgc.concepto_aplica_iva,
  --BUG22156
  mgc.EsActivoFijo, 
  mgc.TipoActivo, 
  mgc.TipoActividad,
  --BUG24733
  mgc.PorcentajeDeducible
  FROM MFAGastoCalc mgc
  JOIN MFAGastoCxcPendientePreCalc mgppc ON mgppc.ID = mgc.ID
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'GAS' AND mme.ModuloID = mgc.ID     
 WHERE mme.ModuloID IS NULL  
GO

/*** MFACxcDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDocumentoPreCalc') and type = 'V') drop view dbo.MFACxcDocumentoPreCalc
GO
CREATE VIEW MFACxcDocumentoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXC.FA','CXC.AF','CXC.A','CXC.AA') THEN 'anticipo'  
                             WHEN mt.Clave IN ('CXC.CA','CXC.F','CXC.FAC','CXC.CD') THEN 'factura'
                             WHEN mt.Clave IN ('CXC.NC') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                         
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Cliente,
  entidad_nombre         = cl.Nombre,
  entidad_rfc            = cl.RFC,
  entidad_id_fiscal      = cl.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = cl.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = c.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  iva_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,  
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
--select ((19087.61)/(1.0-0.151889105026769))*(0.151889105026769/19087.61)  
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),  
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxc c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC' 
  JOIN Cte cl ON cl.Cliente = c.Cliente 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = cl.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = cl.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = c.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXC'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXC' AND mtmde.Mov = c.Mov              
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXC' AND mtmda.Mov = c.Mov       
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXC' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.FA','CXC.CA','CXC.F','CXC.FAC','CXC.NC','CXC.DFA','CXC.AF','CXC.A','CXC.AA','CXC.CD') OR mtmda.Modulo IS NOT NULL)
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXC'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

--BUG18599
/*** MFADineroAnticipadoDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroAnticipadoDocumentoPreCalc') and type = 'V') drop view dbo.MFADineroAnticipadoDocumentoPreCalc
GO
CREATE VIEW MFADineroAnticipadoDocumentoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'DIN',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'empresa',
  tipo_documento         = 'anticipo',
  subtipo_documento      = CONVERT(varchar(50),NULL),                         
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = cl.Cliente,
  entidad_nombre         = cl.Nombre,
  entidad_rfc            = cl.RFC,
  entidad_id_fiscal      = cl.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = cl.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = NULL,
  agente_nombre          = NULL,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = ROUND((c.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*c.TipoCambio, 2),
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = ROUND((c.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*c.TipoCambio, 2),
  iva_excento            = 0,
  iva_tasa               = emfa.DINImpuesto1,  
  iva                    = ROUND((c.Importe-(c.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*c.TipoCambio), 2),
  base_ieps              = ROUND((c.Importe/(1.0+((ISNULL(CONVERT(float,emfa.DINImpuesto1),0.0))/100.0)))*c.TipoCambio, 2),
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,  
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
--select ((19087.61)/(1.0-0.151889105026769))*(0.151889105026769/19087.61)  
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),  
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero                   = c.Mov,
  dinero_id                = c.MovID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Dinero c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'DIN' 
  JOIN EmpresaMFA emfa ON c.Empresa = emfa.Empresa
  JOIN Cte cl ON cl.Cliente = emfa.DINCteDepositosAnticipados
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = cl.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = cl.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'DIN'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = c.ID
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'DIN' AND mtmde.Mov = c.Mov              
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'DIN' AND mtmda.Mov = c.Mov       
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'DIN' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.DA') OR mtmda.Modulo IS NOT NULL)
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'DIN'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

--BUG18599
/*** MFADineroAnticipadoDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFADineroAnticipadoDocumentoCalc') and type = 'V') drop view dbo.MFADineroAnticipadoDocumentoCalc
GO
CREATE VIEW MFADineroAnticipadoDocumentoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,    
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFADineroAnticipadoDocumentoPreCalc
GO

--select * from MFACxcDocumentoPreCalc

/*** MFACxcDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDocumentoCalc') and type = 'V') drop view dbo.MFACxcDocumentoCalc
GO
CREATE VIEW MFACxcDocumentoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,    
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo, 
  TipoActividad
FROM MFACxcDocumentoPreCalc
GO

--SELECT * FROM MFACxcDocumentoCalc
/*** MFACxcDocumentoPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDocumentoPendienteCalc') and type = 'V') drop view dbo.MFACxcDocumentoPendienteCalc
GO
CREATE VIEW MFACxcDocumentoPendienteCalc
AS
SELECT 
   origen_tipo,
   origen_modulo,
   origen_id,
   empresa,
   emisor,
   tipo_documento,
   subtipo_documento,
   folio,
   ejercicio,
   periodo,
   dia,
   --BUG22460
   fecha,
   entidad_clave,
   entidad_nombre,
   entidad_rfc,
   entidad_id_fiscal,
   entidad_tipo_tercero,
   entidad_tipo_operacion,
   entidad_pais,
   entidad_nacionalidad,
   agente_clave,
   agente_nombre,
   concepto,
   acumulable_deducible,
   importe,
   retencion_isr,
   retencion_iva,
   base_iva,
   iva_excento,
   iva_tasa,
   iva, 
   base_ieps,
   ieps_tasa,
   ieps,
   base_isan,
   isan,
   ieps_num_reporte,
   ieps_categoria_concepto,
   ieps_exento,
   ieps_envase_reutilizable,
   ieps_retencion, 
   ieps_cantidad, 
   ieps_unidad, 
   ieps_cantidad2,
   ieps_unidad2,      
   importe_total,
   concepto_clave,
   --REQ16748
   concepto_es_importacion,
   dinero,
   dinero_id,
   --BUG20353
   concepto_aplica_ietu,
   concepto_aplica_ieps,
   concepto_aplica_iva,
   --BUG22156
   EsActivoFijo, 
   TipoActivo, 
   TipoActividad
 FROM MFACxcDocumentoCalc
WHERE Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--SELECT * FROM MFACxcDocumentoPendienteCalc

/*** MFACxpDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoPreCalc') and type = 'V') drop view dbo.MFACxpDocumentoPreCalc
GO
CREATE VIEW MFACxpDocumentoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   AND cd.ID IS NULL
GO

/*** MFACxpDocumentoPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoPreCalc2') and type = 'V') drop view dbo.MFACxpDocumentoPreCalc2
GO
CREATE VIEW MFACxpDocumentoPreCalc2 AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  --BUG18696
  importe                = ROUND((cd.Importe+ISNULL(c.Retencion2, 0)+ISNULL(c.Retencion, 0)-(c2.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c2.Importe, c2.Impuestos, c2.Retencion, cd.Importe)))*c.TipoCambio, 2),
  retencion_isr          = c.Retencion2*c.TipoCambio,
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = ROUND((cd.Importe+ISNULL(c.Retencion2, 0)+ISNULL(c.Retencion, 0)-(c2.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c2.Importe, c2.Impuestos, c2.Retencion, cd.Importe)))*c.TipoCambio, 2),
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c2.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c2.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c2.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c2.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c2.Empresa, c2.Importe,c2.Impuestos),
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  --iva                    = dbo.fnMFAIVA(cd.Importe, c2.Impuestos)*c.TipoCambio,
  iva                    = ROUND((c2.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c2.Importe, c2.Impuestos, c2.Retencion, cd.Importe))*c.TipoCambio, 2),
  base_ieps              = ROUND((cd.Importe+ISNULL(c.Retencion2, 0)+ISNULL(c.Retencion, 0)-(c2.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c2.Importe, c2.Impuestos, c2.Retencion, cd.Importe)))*c.TipoCambio, 2),
  ieps_tasa              = ROUND(((CONVERT(float,cd.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c2.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c2.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,cd.Importe),0.0),2)*100.0,
  ieps                   = (dbo.fnCxpDocumentoPreCalc2Prorrateo(c2.Importe, c2.Impuestos, c2.Retencion, cd.Importe)*(ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0))*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  /*
  importe                = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*cd.Importe*c.TipoCambio,
  base_iva               = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  --base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva_tasa               = dbo.fnMFAIVATasa((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),(c.Importe*ISNULL(c.IVAFiscal, 0))),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),c.Importe*ISNULL(c.IVAFiscal, 0))*c.TipoCambio,  
  base_ieps              = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  ieps_tasa               = 0.0,    
  ieps                   = 0.0,
  base_isan              = 0.0,
  isan                   = 0.0,
  */
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero                   = c.Dinero,
  dinero_id                = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN Cxp c2 ON c2.MovID = cd.AplicaID AND cd.Aplica = c2.Mov AND c2.Empresa = c.Empresa           
  --REQ25113
  LEFT OUTER JOIN CxpD cd2 ON c2.ID = cd2.ID AND cd.AplicaID IS NOT NULL
  --REQ25113
  LEFT OUTER JOIN Cxp c3 ON cd2.AplicaID = c3.MovID AND cd2.Aplica = c3.Mov AND c2.Empresa = c3.Empresa
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   AND (mt.Clave NOT IN ('CXP.FAC'))
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   --REQ25113
   AND c3.ID IS NULL
GO

/*** MFACxpDocumentoPreCalc3 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoPreCalc3') and type = 'V') drop view dbo.MFACxpDocumentoPreCalc3
GO
CREATE VIEW MFACxpDocumentoPreCalc3 AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  --BUG18696
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = c.Retencion2*c.TipoCambio,
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,  
  /*
  importe                = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*cd.Importe*c.TipoCambio,
  base_iva               = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  --base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva_tasa               = dbo.fnMFAIVATasa((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),(c.Importe*ISNULL(c.IVAFiscal, 0))),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),c.Importe*ISNULL(c.IVAFiscal, 0))*c.TipoCambio,  
  base_ieps              = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  ieps_tasa               = 0.0,    
  ieps                   = 0.0,
  base_isan              = 0.0,
  isan                   = 0.0,
  */
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave        = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero                = c.Dinero,
  dinero_id             = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN Cxp c2 ON c2.MovID = cd.AplicaID AND cd.Aplica = c2.Mov AND c2.Empresa = c.Empresa           
  --REQ25113
  LEFT OUTER JOIN CxpD cd2 ON c2.ID = cd2.ID AND cd2.AplicaID IS NOT NULL
  --REQ25113
  LEFT OUTER JOIN Cxp c3 ON cd2.AplicaID = c3.MovID AND cd2.Aplica = c3.Mov AND c2.Empresa = c3.Empresa
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov  
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.FAC') OR mtmda.Modulo IS NOT NULL)
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   --REQ25113
   AND c3.ID IS NULL   
GO

--REQ25113
/*** MFACxpDocumentoPreCalc4 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoPreCalc4') and type = 'V') drop view dbo.MFACxpDocumentoPreCalc4
GO
CREATE VIEW MFACxpDocumentoPreCalc4 AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  --BUG18696
  importe                = ROUND((cd2.Importe+ISNULL(c2.Retencion2, 0)+ISNULL(c2.Retencion, 0)-(c3.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c3.Importe, c3.Impuestos, c3.Retencion, cd2.Importe)))*c2.TipoCambio, 2),
  retencion_isr          = c2.Retencion2*c2.TipoCambio,
  retencion_iva          = c2.Retencion*c2.TipoCambio,
  base_iva               = ROUND((cd2.Importe+ISNULL(c2.Retencion2, 0)+ISNULL(c2.Retencion, 0)-(c3.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c3.Importe, c3.Impuestos, c3.Retencion, cd2.Importe)))*c2.TipoCambio, 2),
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c2.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c2.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c2.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c2.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c3.Empresa, c3.Importe,c3.Impuestos),
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  --iva                    = dbo.fnMFAIVA(cd.Importe, c2.Impuestos)*c.TipoCambio,
  iva                    = ROUND((c3.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c3.Importe, c3.Impuestos, c3.Retencion, cd2.Importe))*c2.TipoCambio, 2),
  base_ieps              = ROUND((cd2.Importe+ISNULL(c2.Retencion2, 0)+ISNULL(c2.Retencion, 0)-(c3.Impuestos*dbo.fnCxpDocumentoPreCalc2Prorrateo(c3.Importe, c3.Impuestos, c3.Retencion, cd2.Importe)))*c2.TipoCambio, 2),
  ieps_tasa              = ROUND(((CONVERT(float,cd2.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c3.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c3.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,cd2.Importe),0.0),2)*100.0,
  ieps                   = (dbo.fnCxpDocumentoPreCalc2Prorrateo(c3.Importe, c3.Impuestos, c3.Retencion, cd2.Importe)*(ISNULL(CONVERT(float,c2.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c2.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c2.IEPSFiscal),0.0))*c2.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  /*
  importe                = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*cd.Importe*c.TipoCambio,
  base_iva               = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  --base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  iva_tasa               = dbo.fnMFAIVATasa((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),(c.Importe*ISNULL(c.IVAFiscal, 0))),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA((c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe)),c.Importe*ISNULL(c.IVAFiscal, 0))*c.TipoCambio,  
  base_ieps              = (c.Importe+(dbo.fnMFARetencionIVAFiscal(c2.Importe,c2.Impuestos,c2.Retencion2)*c.Importe)-(ISNULL(c.IVAFiscal, 0)*c.Importe))*c.TipoCambio,  
  ieps_tasa               = 0.0,    
  ieps                   = 0.0,
  base_isan              = 0.0,
  isan                   = 0.0,
  */
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave           = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero                   = c.Dinero,
  dinero_id                = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0,
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  JOIN CxpD cd  ON cd.ID = c.ID 
  JOIN Cxp c2   ON c2.MovID = cd.AplicaID AND cd.Aplica = c2.Mov AND c2.Empresa = c.Empresa           
  JOIN CxpD cd2 ON c2.ID = cd2.ID
  JOIN Cxp c3 ON cd2.AplicaID = c3.MovID AND cd2.Aplica = c3.Mov AND c2.Empresa = c3.Empresa
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.FAC', 'CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

/*** MFACxpDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoCalc') and type = 'V') drop view dbo.MFACxpDocumentoCalc
GO
CREATE VIEW MFACxpDocumentoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFACxpDocumentoPreCalc
UNION ALL
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFACxpDocumentoPreCalc2
UNION ALL
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFACxpDocumentoPreCalc3
--REQ25113
UNION ALL
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFACxpDocumentoPreCalc4
GO

--SELECT * FROM MFACxpDocumentoCalc

/*** MFACxpDocumentoPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDocumentoPendienteCalc') and type = 'V') drop view dbo.MFACxpDocumentoPendienteCalc
GO
CREATE VIEW MFACxpDocumentoPendienteCalc
AS
SELECT 
   origen_tipo,
   origen_modulo,
   origen_id,
   empresa,
   emisor,
   tipo_documento,
   subtipo_documento,
   folio,
   ejercicio,
   periodo,
   dia,
   --BUG22460
   fecha,
   entidad_clave,
   entidad_nombre,
   entidad_rfc,
   entidad_id_fiscal,
   entidad_tipo_tercero,
   entidad_tipo_operacion,
   entidad_pais,
   entidad_nacionalidad,
   agente_clave,
   agente_nombre,
   concepto,
   acumulable_deducible,
   importe,
   retencion_isr,
   retencion_iva,
   base_iva,
   iva_excento,
   iva_tasa,
   iva, 
   base_ieps,
   ieps_tasa,
   ieps,
   base_isan,
   isan,
   ieps_num_reporte,
   ieps_categoria_concepto,
   ieps_exento,
   ieps_envase_reutilizable,
   ieps_retencion, 
   ieps_cantidad, 
   ieps_unidad, 
   ieps_cantidad2,
   ieps_unidad2,          
   importe_total,
   concepto_clave,
   concepto_es_importacion,
   dinero,
   dinero_id,
   --BUG20353
   concepto_aplica_ietu,
   concepto_aplica_ieps,
   concepto_aplica_iva,
   --BUG22156
   EsActivoFijo,
   TipoActivo,
   TipoActividad
 FROM MFACxpDocumentoCalc
WHERE Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--SELECT * FROM MFACxpDocumentoPendienteCalc

/*** MFACxcAplicacionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcAplicacionCalc') and type = 'V') drop view dbo.MFACxcAplicacionCalc
GO
CREATE VIEW MFACxcAplicacionCalc AS
--BUG24879
SELECT DISTINCT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'aplicacion'),
  --BUG18599
  folio                  = RTRIM(ISNULL(ISNULL(c.MovAplica,c.Mov), '')) + ' ' + RTRIM(ISNULL(ISNULL(c.MovAplicaID,c.MovID), '')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),  
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Cxc c 
  JOIN CxcD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID    
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'CXC' AND mtmaa.Mov = c.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')          
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'CXC' AND mtmae.Mov = c.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')     
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')     
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.ANC','CXC.ACA','CXC.AV','CXC.AE') OR mtmaa.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFAAplicaExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--select * from MFACxcAplicacionCalc where referencia like '%CAN3505%'

--select * from movtipo where modulo = 'cxc'

/*** MFACxcEndosoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcEndosoCalc') and type = 'V') drop view dbo.MFACxcEndosoCalc
GO
CREATE VIEW MFACxcEndosoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'redocumentacion'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(c.MovAplica,'')) + ' ' + RTRIM(ISNULL(c.MovAplicaID,'')),
  importe                = (ISNULL(c.Importe,0.0)+ISNULL(c.Impuestos,0.0)-ISNULL(c.Retencion,0.0))*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmea.tipo_documento
  FROM Cxc c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAEndosoAdicion mtmea ON mtmea.Modulo = 'CXC' AND mtmea.Mov = c.Mov AND ISNULL(NULLIF(mtmea.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmea.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')            
  --BUG16464
  LEFT OUTER JOIN MovTipoMFAEndosoExcepcion mtmae ON mtmae.Modulo = 'CXC' AND mtmae.Mov = c.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmree.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.FAC') OR mtmea.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFAAplicaExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))
   AND c.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO
--select * from MFACxcEndosoCalc where referencia like '%CAN3505%'
--select * from movtipo where modulo = 'cxc'


/*** MFACxcCobroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcCobroCalc') and type = 'V') drop view dbo.MFACxcCobroCalc
GO
CREATE VIEW MFACxcCobroCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
 folio                  = CASE
                              WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
                               THEN RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,''))
						      WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
							   THEN RTRIM(ISNULL(c.Dinero,'')) + ' ' + RTRIM(ISNULL(c.DineroID,'')) 
							  ELSE RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,''))
						   END,
  --BUG18599 BUG22544
  ejercicio              = CASE 
	                           WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN YEAR(c.FechaConclusion) ELSE c.Ejercicio END ELSE YEAR(c.DineroFechaConciliacion) END
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
						        THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN 
								YEAR(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,6,c.DineroCtaDinero))) ELSE dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,3,c.DineroCtaDinero) END ELSE YEAR(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END
						       ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN YEAR(c.FechaConclusion) ELSE c.Ejercicio END ELSE YEAR(c.DineroFechaConciliacion) END
						   END,
  periodo                = CASE
							   WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN MONTH(c.FechaConclusion)ELSE c.Periodo END ELSE MONTH(c.DineroFechaConciliacion) END
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN MONTH(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,6,c.DineroCtaDinero))) ELSE dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,4,c.DineroCtaDinero) END ELSE MONTH(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END
							   ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN MONTH(c.FechaConclusion)ELSE c.Periodo END ELSE MONTH(c.DineroFechaConciliacion) END
							END,
  dia                    = CASE 
	                           WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN DAY(c.FechaConclusion) ELSE DAY(c.FechaEmision) END ELSE DAY(c.DineroFechaConciliacion) END
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
							    THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN DAY(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,6,c.DineroCtaDinero))) ELSE DAY(dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,1,c.DineroCtaDinero)) END ELSE DAY(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END						        
							   ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN DAY(c.FechaConclusion) ELSE DAY(c.FechaEmision) END ELSE DAY(c.DineroFechaConciliacion) END
						   END,
  --BUG22460 BUG22544
  fecha					 = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0    
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN c.FechaConclusion ELSE c.FechaEmision END ELSE c.DineroFechaConciliacion END
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
						        THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,6,c.DineroCtaDinero)) ELSE CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,1,c.DineroCtaDinero)) END ELSE CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero)) END
							   ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN c.FechaConclusion ELSE c.FechaEmision END ELSE c.DineroFechaConciliacion END
						   END,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  --BUG22759
  importe                = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0    
								THEN (cd.Importe+ISNULL(cd.DescuentoRecargos, 0))*c.TipoCambio
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
								THEN (cd.Importe+ISNULL(cd.DescuentoRecargos, 0))*(dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero))
							   ELSE (cd.Importe+ISNULL(cd.DescuentoRecargos, 0))*c.TipoCambio
						   END,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmca.tipo_documento
  FROM Cxc c 
  JOIN CxcD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFACobroAdicion mtmca ON mtmca.Modulo = 'CXC' AND mtmca.Mov = c.Mov AND ISNULL(NULLIF(mtmca.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmca.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')              
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXC' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC' AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXC' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.C','CXC.DP','CXC.NCP') OR mtmca.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))       
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
GO

--BUG18599
/*** MFACxcCobroSinAnticipadoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcCobroSinAnticipadoCalc') and type = 'V') drop view dbo.MFACxcCobroSinAnticipadoCalc
GO
CREATE VIEW MFACxcCobroSinAnticipadoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN YEAR(c.FechaConclusion) ELSE c.Ejercicio         END ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN MONTH(c.FechaConclusion)ELSE c.Periodo           END ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN DAY(c.FechaConclusion)  ELSE DAY(c.FechaEmision) END ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460 BUG22544
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CASE mt.Clave WHEN 'CXC.DP' THEN c.FechaConclusion ELSE c.FechaEmision END ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  --BUG22759
  importe                = (cd.Importe+ISNULL(cd.DescuentoRecargos, 0))*c.TipoCambio,  
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmca.tipo_documento
  FROM Cxc c 
  JOIN CxcD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFACobroAdicion mtmca ON mtmca.Modulo = 'CXC' AND mtmca.Mov = c.Mov AND ISNULL(NULLIF(mtmca.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmca.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')              
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXC' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC' AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXC' AND mtdc.Mov = c.Mov
  --BUG22460
  LEFT OUTER JOIN FormaPago fp1 ON c.FormaCobro = fp1.FormaPago
  LEFT OUTER JOIN MovTipo mtfp1 ON fp1.MovIngresos = mtfp1.Mov AND mtfp1.Modulo = 'DIN'
  LEFT OUTER JOIN FormaPago fp2 ON c.FormaCobro1 = fp2.FormaPago
  LEFT OUTER JOIN MovTipo mtfp2 ON fp2.MovIngresos = mtfp2.Mov AND mtfp2.Modulo = 'DIN'  
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.C','CXC.DP','CXC.NCP') OR mtmca.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))       
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
   --BUG22460
   AND ISNULL(mtfp1.Clave, '') <> 'DIN.DA' 
   AND ISNULL(mtfp2.Clave, '') <> 'DIN.DA'
   --AND dbo.fnCxcFormaPagoEsDineroAnticipado(c.ID) = 0
GO

--select * from MFACxcCobroCalc where referencia like '%CAN3505%'
--select * from documentos where folio = 'FACTURA CFD GDL GDL13949'
--select * from mfacxccobrocalc
--select * from layout_logd where referencia = 'FACTURA CFD GDL GDL13949'
--select aplica, aplicaid from cxcd
--select * from mfacxccobrocalc where Ejercicio = 2012 and periodo = 1
--select * from aplicaciones where tipo_aplicacion = 'cobro' and periodo = 1 and ejercicio = 2012 and dia = 2
--select * from datosietu 
--where Tipo = 1 
--and Ejercicio = 2012 
--and periodoasi = 1
--and DAY(fecha) = 2

/*** MFACxcPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcPagoCalc') and type = 'V') drop view dbo.MFACxcPagoCalc
GO
CREATE VIEW MFACxcPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmpa.tipo_documento
  FROM Cxc c 
  JOIN CxcD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID    
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAPagoAdicion mtmpa ON mtmpa.Modulo = 'CXC' AND mtmpa.Mov = c.Mov AND ISNULL(ISNULL(NULLIF(mtmpa.OrigenTipo,''),ISNULL(c.OrigenTipo, '')), '') = ISNULL(c.OrigenTipo,'') AND ISNULL(ISNULL(NULLIF(mtmpa.Origen,''),ISNULL(c.Origen, '')), '') = ISNULL(c.Origen,'')    
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXC' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')           
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')         
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXC' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.DC') OR mtmpa.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))       
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
 GROUP BY c.ID, c.Empresa, mtmac.TipoAplicacion, c.Mov, c.MovID, mtdc.Mov, c.Ejercicio, c.DineroFechaConciliacion, mtdc.Mov, c.Periodo, c.DineroFechaConciliacion,
          mtdc.Mov, c.FechaEmision, c.DineroFechaConciliacion, cd.Aplica, cd.AplicaID,  cd.Importe, c.TipoCambio, c.DineroCtaDinero, mtmree.AplicaIetu, mtmree.AplicaIeps,
          mtmree.AplicaIVA, c.DineroConciliado,  c.Dinero, c.DineroID, mtmpa.tipo_documento 
GO

--select * from MFACxcPagoCalc where referencia like '%CAN3505%'

/*** MFACxcRedocumentacionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcRedocumentacionCalc') and type = 'V') drop view dbo.MFACxcRedocumentacionCalc
GO
CREATE VIEW MFACxcRedocumentacionCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'redocumentacion'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmra.tipo_documento
  FROM Cxc c 
  JOIN CxcD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXC' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFARedocAdicion mtmra ON mtmra.Modulo = 'CXC' AND mtmra.Mov = c.Mov AND ISNULL(NULLIF(mtmra.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmra.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                  
  LEFT OUTER JOIN MovTipoMFARedocExcepcion mtmre ON mtmre.Modulo = 'CXC' AND mtmre.Mov = c.Mov AND ISNULL(NULLIF(mtmre.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmre.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')           
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXC'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXC' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')         
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXC.D','CXC.DA','CXC.DOCMON') OR mtmra.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFARedocExcepcion WHERE Modulo = 'CXC' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))          
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmre.Mov IS NULL
GO

/*** MFAVentaTCalcExportacion ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAVentaTCalcExportacion') and type = 'V') drop view dbo.MFAVentaTCalcExportacion
GO
CREATE VIEW MFAVentaTCalcExportacion
WITH ENCRYPTION
AS
SELECT
  ID,
  SUM(ISNULL(ImporteDescuentoGlobal,0.0)) ImporteDescuentoGlobal,
  SUM(ISNULL(DescuentosTotales,0.0)) DescuentosTotales,
  SUM(ISNULL(ImporteSobrePrecio,0.0)) ImporteSobrePrecio,
  SUM(ISNULL(SubTotal,0.0)) SubTotal,
  SUM(ISNULL(Impuesto1Total,0.0)) Impuesto1Total,
  SUM(ISNULL(Impuesto2Total,0.0)) Impuesto2Total,
  SUM(ISNULL(Impuesto3Total,0.0)) Impuesto3Total,
  SUM(ISNULL(Retencion1Total,0.0)) Retencion1Total,
  SUM(ISNULL(Retencion2Total,0.0)) Retencion2Total,
  SUM(ISNULL(Impuestos,0.0)) Impuestos,
  SUM(ISNULL(Retencion,0.0)) Retenciones,
  SUM(ISNULL(ImporteTotal,0.0)) ImporteTotal,
  SUM(ISNULL(TotalNeto,0.0)) TotalNeto
--BUG22277
FROM MFAVentaTCalc
LEFT OUTER JOIN EmpresaCFD ON MFAVentaTCalc.Empresa = EmpresaCFD.Empresa
GROUP BY ID
GO

/*** MFACrCobroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACrCobroCalc') and type = 'V') drop view dbo.MFACrCobroCalc
GO
CREATE VIEW MFACrCobroCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CR',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(mf.DMov,'')) + ' ' + RTRIM(ISNULL(mf.DMovID,'')),
  importe                = vtce.TotalNeto*v.TipoCambio,
  cuenta_bancaria        = NULL,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = NULL,
  dinero_id				 = NULL,
  --BUG18767
  tipo_documento		 = NULL
  FROM CR c
  JOIN MovFlujo mf ON mf.Sucursal = c.Sucursal AND mf.Empresa = c.Empresa AND mf.OModulo = 'CR' AND mf.OID = c.ID AND DModulo = 'VTAS' 
  JOIN Venta v ON v.ID = mf.DID JOIN MFAVentaTCalcExportacion vtce ON vtce.ID = v.ID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CR'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CR' AND mme.ModuloID = c.ID      
  LEFT OUTER JOIN MovTipoMFARedocExcepcion mtmae ON mtmae.Modulo = 'CR' AND mtmae.Mov = c.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CR'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')       
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CR'AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmree.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
 WHERE c.Estatus IN ('CONCLUIDO')
   AND mt.Clave IN ('CR.C')
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFARedocExcepcion WHERE Modulo = 'CR' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))          
   AND v.Estatus IN ('CONCLUIDO')
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--select * from MFACrCobroCalc

--select * from MFAVentaTCalcExportacion

/*** MFACxpAplicacionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpAplicacionCalc') and type = 'V') drop view dbo.MFACxpAplicacionCalc
GO
CREATE VIEW MFACxpAplicacionCalc AS
--BUG24879
SELECT DISTINCT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'aplicacion'),
  --BUG18599
  folio                  = RTRIM(ISNULL(ISNULL(c.MovAplica,c.Mov), '')) + ' ' + RTRIM(ISNULL(ISNULL(c.MovAplicaID,c.MovID), '')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Cxp c 
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'CXP' AND mtmaa.Mov = c.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                    
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'CXP' AND mtmae.Mov = c.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.ACA','CXP.AE','CXP.ANC') OR mtmaa.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFAAplicaExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))             
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO
--select * from MFACxpAplicacionCalc where referencia like '%CAN3505%'

--select * from movtipo where modulo = 'cxp'

/*** MFACxpEndosoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpEndosoCalc') and type = 'V') drop view dbo.MFACxpEndosoCalc
GO
CREATE VIEW MFACxpEndosoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'redocumentacion'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(c.MovAplica,'')) + ' ' + RTRIM(ISNULL(c.MovAplicaID,'')),
  importe                = (ISNULL(c.Importe,0.0)+ISNULL(c.Impuestos,0.0)-ISNULL(c.Retencion,0.0))*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmea.tipo_documento
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAEndosoAdicion mtmea ON mtmea.Modulo = 'CXP' AND mtmea.Mov = c.Mov AND ISNULL(NULLIF(mtmea.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmea.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                      
  --BUG16464
  LEFT OUTER JOIN MovTipoMFAEndosoExcepcion mtmae ON mtmae.Modulo = 'CXP' AND mtmae.Mov = c.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP'AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmree.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')           
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.FAC') OR mtmea.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFAAplicaExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))
   AND c.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO
--SELECT * FROM CXC WHERE ID = 139048
--select * from MFACxpEndosoCalc 
--select * from movtipo where modulo = 'cxc'
--SELECT * FROM MOVTIPO WHERE MOV = 'ENDOSO' AND MODULO = 'CXP'

/*** MFACxpPagoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpPagoCalc') and type = 'V') drop view dbo.MFACxpPagoCalc
GO
CREATE VIEW MFACxpPagoCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'pago'),
  folio                  = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,''))
							   WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
								THEN RTRIM(ISNULL(c.Dinero,'')) + ' ' + RTRIM(ISNULL(c.DineroID,'')) 
                               ELSE RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')) 
						   END,
  ejercicio              = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END
						       WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
						        THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,3,c.DineroCtaDinero) ELSE YEAR(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END
						       ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END
						   END,
  periodo                = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
                                THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END
                               WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
                                THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,4,c.DineroCtaDinero)  ELSE MONTH(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END 
						       ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END
						   END,
  dia                    = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END

						       WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,1,c.DineroCtaDinero)) ELSE DAY(CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero))) END 
							   ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END
						   END,  
  fecha					 = CASE
	                           WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END
                               WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
								THEN CASE ISNULL(mtdc.Mov, '') WHEN '' THEN CONVERT(DATETIME, dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,1,c.DineroCtaDinero)) ELSE CONVERT(DATETIME,dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,5,c.DineroCtaDinero)) END
							   ELSE CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END
						   END,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = CASE 
                               WHEN ISNULL(c.DineroID,'') = '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 0 
								THEN cd.Importe*c.TipoCambio
                               WHEN ISNULL(c.DineroID,'') <> '' AND (SELECT FuncionTesoreria FROM EmpresaMFA WHERE Empresa = c.Empresa) = 1
							    THEN cd.Importe*(dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero)) 
							   ELSE cd.Importe*c.TipoCambio 
						   END,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero			     = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmpa.tipo_documento
  FROM Cxp c 
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAPagoAdicion mtmpa ON mtmpa.Modulo = 'CXP' AND mtmpa.Mov = c.Mov AND ISNULL(NULLIF(mtmpa.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmpa.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                        
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXP' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXP' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.P','CXP.NCP','CXP.DP') OR mtmpa.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))                
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL
GO
--select * from MFACxpPagoCalc where referencia like '%CAN3505%'

--SELECT * FROM MOVCLAVE WHERE NOMBREOMISION LIKE '%pago%' AND MODULO = 'CXP'

/*** MFACxpCobroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpCobroCalc') and type = 'V') drop view dbo.MFACxpCobroCalc
GO
CREATE VIEW MFACxpCobroCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'cobro'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,  
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(c.DineroConciliado, 0),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmca.tipo_documento
  FROM Cxp c 
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFACobroAdicion mtmca ON mtmca.Modulo = 'CXP' AND mtmca.Mov = c.Mov AND ISNULL(NULLIF(mtmca.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmca.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                          
  LEFT OUTER JOIN MovTipoMFACobroPagoExcepcion mtmcpe ON mtmcpe.Modulo = 'CXP' AND mtmcpe.Mov = c.Mov AND ISNULL(NULLIF(mtmcpe.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmcpe.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'CXP' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.DC') OR mtmca.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFACobroPagoExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))                
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmcpe.Mov IS NULL   
GO
--select * from MFACxpCobroCalc where referencia like '%CAN3505%'
--select origen,origenid,* from cxc where movid = 'can3505'
--SELECT * FROM MOVCLAVE WHERE NOMBREOMISION LIKE '%pago%' AND MODULO = 'CXP'
--select * from documentos where folio like '%can7050%'
--select * from Venta where MovID = 'can7050'

/*** MFACxpRedocumentacionCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpRedocumentacionCalc') and type = 'V') drop view dbo.MFACxpRedocumentacionCalc
GO
CREATE VIEW MFACxpRedocumentacionCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''),'redocumentacion'),
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  Referencia             = RTRIM(ISNULL(cd.Aplica,'')) + ' ' + RTRIM(ISNULL(cd.AplicaID,'')),
  importe                = cd.Importe*c.TipoCambio,
  cuenta_bancaria        = c.DineroCtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  dinero				 = c.Dinero,
  dinero_id				 = c.DineroID,
  --BUG18767
  tipo_documento		 = mtmra.tipo_documento
  FROM Cxp c 
  JOIN CxpD cd ON cd.ID = c.ID 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFARedocAdicion mtmra ON mtmra.Modulo = 'CXP' AND mtmra.Mov = c.Mov AND ISNULL(NULLIF(mtmra.OrigenTipo,''),ISNULL(c.OrigenTipo, '')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmra.Origen,''),ISNULL(c.Origen, '')) = ISNULL(c.Origen,'')                            
  LEFT OUTER JOIN MovTipoMFARedocExcepcion mtmre ON mtmre.Modulo = 'CXP' AND mtmre.Mov = c.Mov AND ISNULL(NULLIF(mtmre.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmre.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')   
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'CXP'AND mtmac.Mov = c.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'CXP' AND mtmree.Mov = c.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(cd.Aplica,'')) = ISNULL(cd.Aplica,'')
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.D','CXP.DA') OR mtmra.Modulo IS NOT NULL)
   --AND mt.Mov NOT IN (SELECT Mov FROM MovTipoMFARedocExcepcion WHERE Modulo = 'CXP' AND ISNULL(NULLIF(OrigenTipo,''),ISNULL(c.OrigenTipo,'')) = ISNULL(c.OrigenTipo,'') AND ISNULL(NULLIF(Origen,''),ISNULL(c.Origen,'')) = ISNULL(c.Origen,''))                   
   AND cd.Importe IS NOT NULL    
   AND mme.ModuloID IS NULL
   AND mtmre.Mov IS NULL
GO

/*** MFACtaSaldoEjercicio ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACtaSaldoEjercicio') and type = 'V') drop view dbo.MFACtaSaldoEjercicio
GO
CREATE VIEW MFACtaSaldoEjercicio AS
SELECT
  A.Empresa,
  A.Ejercicio,
  --BUG19206
  A.Periodo,
  A.Cuenta,
  A.Moneda,
  --REQ23317
  ISNULL(SUM(ISNULL(A.Cargos,0.0)),0.0) 'Cargos',
  ISNULL(SUM(ISNULL(A.Abonos,0.0)),0.0) 'Abonos', 
  ISNULL(SUM(ISNULL(A.Cargos,0.0)-ISNULL(A.Abonos,0.0)),0.0) 'Saldo'
  FROM Acum A
 WHERE A.Rama = 'CONT'
 GROUP BY A.Empresa, A.Ejercicio, A.Periodo, A.Cuenta, A.Moneda
GO

--BUG21567
/*** MFACtaSaldoEjercicioComp ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACtaSaldoEjercicioComp') and type = 'V') drop view dbo.MFACtaSaldoEjercicioComp
GO
CREATE VIEW MFACtaSaldoEjercicioComp AS
SELECT
  A.Empresa,
  A.Ejercicio,
  --BUG19206
  A.Periodo,
  A.Cuenta,
  A.Moneda,
  --REQ23317
  ISNULL(SUM(ISNULL(A.Cargos,0.0)),0.0) 'Cargos',
  ISNULL(SUM(ISNULL(A.Abonos,0.0)),0.0) 'Abonos',   
  ISNULL(SUM(ISNULL(A.Cargos,0.0)-ISNULL(A.Abonos,0.0)),0.0) 'Saldo'
  FROM MFAAcum A
 WHERE A.Rama = 'CONT'
 GROUP BY A.Empresa, A.Ejercicio, A.Periodo, A.Cuenta, A.Moneda
GO

/*** MFACtaSaldoPeriodoCero ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACtaSaldoPeriodoCero') and type = 'V') drop view dbo.MFACtaSaldoPeriodoCero
GO
--CREATE VIEW MFACtaSaldoPeriodoCero AS
--SELECT
--  Empresa,
--  Ejercicio, 
--  Cuenta,
--  Moneda,
--  ISNULL(SUM(ISNULL(Cargos,0.0)-ISNULL(Abonos,0.0)),0.0) Saldo  
--  FROM Acum
-- WHERE Rama = 'CONT' 
--     AND Periodo = 0 
-- GROUP BY Empresa, Ejercicio, Cuenta, Moneda
--GO

/*** MFACuentasContablesSaldo ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACuentasContablesSaldo') and type = 'V') drop view dbo.MFACuentasContablesSaldo
GO
CREATE VIEW MFACuentasContablesSaldo AS
SELECT
  --empresa						= a.Empresa,
  cuenta_contable				= c.Cuenta,
  cuenta_control				= CASE WHEN UPPER(c.Tipo) = 'MAYOR' THEN NULL ELSE c.Rama END,
  descripcion					= c.Descripcion,
  nivel							= CASE 
                                    WHEN UPPER(c.Tipo) = 'MAYOR'     THEN 1
                                    WHEN UPPER(c.Tipo) = 'SUBCUENTA' THEN 2
                                    WHEN UPPER(c.Tipo) = 'AUXILIAR'  THEN 3 
                                  END,
  clase_cuenta                  = CASE
                                    WHEN ISNULL(c.EsAcumulativa,0) = 1 THEN 'control'
                                    WHEN ISNULL(c.EsAcumulativa,0) = 0 THEN 'registro'                                    
                                  END,                                    
  tipo_cuenta                   = dbo.fnMFATipoCuentaEstructura(c.Cuenta)--,
  --ejercicio                     = a.Ejercicio    
  FROM Cta c
  --JOIN Acum a ON a.Cuenta = c.Cuenta
 WHERE UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA','AUXILIAR') 
GO
--select * from mfacuentascontablessaldo
--MONEDA GENERAL DEL ERP (ya)
--SACAR EL DE POLIZAS DE LAS POLIZAS Y NO DE ACUM (ya)
--LAS CUENTAS CONTABLES SON TODAS MENOS LAS DE ESTRUCTURA (ya)
--LA TABLA DE CUENTAS SE LLAMA LAYOUT_CUENTAS	


--REQ16670
/*** MFACxpDineroPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDineroPreCalc') and type = 'V') drop view dbo.MFACxpDineroPreCalc
GO
CREATE VIEW MFACxpDineroPreCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'pago'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Ejercicio ELSE YEAR(d.FechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Periodo ELSE MONTH(d.FechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(d.FechaEmision) ELSE DAY(d.FechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.FechaEmision ELSE d.FechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(d.Conciliado, 0),
  dinero				 = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'CXP' AND DModulo = 'DIN'
  JOIN Cxp c ON d.OrigenTipo = 'CXP' AND d.Origen = c.Mov AND d.OrigenID = c.MovID AND d.Empresa = c.Empresa AND c.ID = mf.OID
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN MovTipo mt2 ON mt2.Mov = c.Mov AND mt2.Modulo = 'CXP'  
  JOIN Version ver ON 1 = 1  
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(d.OrigenTipo, '')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(d.Origen, '')) = ISNULL(d.Origen,'')                    
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'DIN' AND mtmree.Mov = d.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'DIN' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   --BUG18130
   AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE'))
   AND (mt2.Clave IN ('CXP.A') OR mtmaa.Modulo IS NOT NULL)
   AND d.Importe IS NOT NULL    
   AND c.Importe IS NOT NULL       
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--REQ16670
 /*** MFACxpDineroPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDineroPreCalc2') and type = 'V') drop view dbo.MFACxpDineroPreCalc2
GO
CREATE VIEW MFACxpDineroPreCalc2 AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXP',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'pago'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Ejercicio ELSE YEAR(d.FechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.Periodo ELSE MONTH(d.FechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(d.FechaEmision) ELSE DAY(d.FechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN d.FechaEmision ELSE d.FechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = c.Importe*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),  
  base_ieps              = ISNULL(c.Importe,0.0)*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*dbo.fnBuscadatosdinero(c.Dinero,c.DineroID,c.Empresa,2,c.DineroCtaDinero),
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(d.Conciliado, 0),
  dinero				 = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'DIN' AND DModulo = 'DIN'
  JOIN Dinero d2 ON d2.ID = mf.OID
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN MovTipo mt2 ON mt2.Mov = d2.Mov AND mt2.Modulo = 'DIN'
  JOIN Cxp c ON d2.OrigenTipo = 'CXP' AND d2.Origen = c.Mov AND d2.OrigenID = c.MovID AND d2.Empresa = c.Empresa
  JOIN MovTipo mt3 ON mt3.Mov = c.Mov AND mt3.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1  
  --BUG20901
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(c.Mov, '')) = ISNULL(c.Mov,'')                     
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),'CXP') = 'CXP' AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Mov,'')) = ISNULL(c.Mov,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),'CXP') = 'CXP' AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'DIN' AND mtmree.Mov = d.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXP') = 'CXP' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'DIN' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND d2.Estatus IN ('PENDIENTE','CONCLUIDO')
   --BUG18130
   AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE'))
   AND (mt2.Clave IN ('DIN.SCH', 'DIN.SD'))
   AND (mt3.Clave IN ('CXP.A') /*OR mtmaa.Modulo IS NOT NULL*/)
   AND d.Importe IS NOT NULL    
   AND c.Importe IS NOT NULL       
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--REQ16670
/*** MFACxpDineroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxpDineroCalc') and type = 'V') drop view dbo.MFACxpDineroCalc
GO
CREATE VIEW MFACxpDineroCalc AS
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFACxpDineroPreCalc
  UNION ALL
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFACxpDineroPreCalc2
GO

--REQ16670
/*** MFACxcDineroPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDineroPreCalc') and type = 'V') drop view dbo.MFACxcDineroPreCalc
GO
CREATE VIEW MFACxcDineroPreCalc AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'cobro'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado		 	 = ISNULL(d.Conciliado, 0),
  dinero			     = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'CXC' AND DModulo = 'DIN'
  --BUG23552
  JOIN Cxc c ON /*d.OrigenTipo = 'CXC' AND d.Origen = c.Mov AND d.OrigenID = c.MovID AND */d.Empresa = c.Empresa AND c.ID = mf.OID
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN MovTipo mt2 ON mt2.Mov = c.Mov AND mt2.Modulo = 'CXC'  
  JOIN Version ver ON 1 = 1  
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  --BUG20901
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''),ISNULL(d.OrigenTipo, '')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmaa.Origen,''),ISNULL(d.Origen, '')) = ISNULL(d.Origen,'')                    
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),ISNULL(d.OrigenTipo,'')) = ISNULL(d.OrigenTipo,'') AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(d.Origen,'')) = ISNULL(d.Origen,'')         
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'DIN' AND mtmree.Mov = d.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'DIN' AND mtdc.Mov = c.Mov  
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   --BUG18130
   AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   --BUGDIN.I
   AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE', 'DIN.I', 'DIN.DA'))
   AND (mt2.Clave IN ('CXC.A') OR mtmaa.Modulo IS NOT NULL)
   AND d.Importe IS NOT NULL    
   AND c.Importe IS NOT NULL       
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--REQ16670
/*** MFACxcDineroPreCalc2 ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDineroPreCalc2') and type = 'V') drop view dbo.MFACxcDineroPreCalc2
GO
CREATE VIEW MFACxcDineroPreCalc2 AS
SELECT
  origen_tipo            = 'auto',
  origen_modulo          = 'CXC',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,d.ID))),
  empresa                = c.Empresa,
  tipo_aplicacion        = ISNULL(NULLIF(mtmac.TipoAplicacion,''), 'cobro'),
  folio                  = RTRIM(ISNULL(d.Mov,'')) + ' ' + RTRIM(ISNULL(d.MovID,'')),
  --BUG18599
  ejercicio              = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Ejercicio ELSE YEAR(c.DineroFechaConciliacion) END,
  periodo                = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.Periodo ELSE MONTH(c.DineroFechaConciliacion) END,
  dia                    = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN DAY(c.FechaEmision) ELSE DAY(c.DineroFechaConciliacion) END,
  --BUG22460
  fecha					 = CASE ISNULL(mtdc.Mov, '') WHEN '' THEN c.FechaEmision ELSE c.DineroFechaConciliacion END,
  Referencia             = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa               = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  cuenta_bancaria        = d.CtaDinero,
  --BUG16247
  aplica_ietu            = ISNULL(NULLIF(mtmree.AplicaIetu,''), 'Si'),
  aplica_ieps            = ISNULL(NULLIF(mtmree.AplicaIeps,''), 'Si'),
  aplica_iva             = ISNULL(NULLIF(mtmree.AplicaIVA,''), 'Si'),
  --CONCILIACION
  conciliado			 = ISNULL(d.Conciliado, 0),
  dinero				 = d.Mov,
  dinero_id				 = d.MovID,
  --BUG18767
  tipo_documento		 = mtmaa.tipo_documento
  FROM Dinero d
  JOIN MovFlujo mf ON d.ID = mf.DID AND mf.OModulo = 'DIN' AND DModulo = 'DIN'
  JOIN Dinero d2 ON d2.ID = mf.OID
  JOIN Version ver ON 1 = 1  
  JOIN MovTipo mt ON mt.Mov = d.Mov AND mt.Modulo = 'DIN'
  JOIN MovTipo mt2 ON mt2.Mov = d2.Mov AND mt2.Modulo = 'DIN'
  JOIN Cxc c ON d2.OrigenTipo = 'CXC' AND d2.Origen = c.Mov AND d2.OrigenID = c.MovID AND d2.Empresa = c.Empresa
  JOIN MovTipo mt3 ON mt3.Mov = c.Mov AND mt3.Modulo = 'CXC'
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'DIN' AND mme.ModuloID = d.ID      
  LEFT OUTER JOIN MovTipoMFAAplicaAdicion mtmaa ON mtmaa.Modulo = 'DIN' AND mtmaa.Mov = d.Mov AND ISNULL(NULLIF(mtmaa.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmaa.Origen,''),c.Mov) = ISNULL(c.Mov,'')                     
  LEFT OUTER JOIN MovTipoMFAAplicaExcepcion mtmae ON mtmae.Modulo = 'DIN' AND mtmae.Mov = d.Mov AND ISNULL(NULLIF(mtmae.OrigenTipo,''),'CXC') = 'CXC' AND ISNULL(NULLIF(mtmae.Origen,''),ISNULL(c.Mov,'')) = ISNULL(c.Mov,'') 
  LEFT OUTER JOIN MovTipoMFAAplicacionCambio mtmac ON mtmac.Modulo = 'DIN' AND mtmac.Mov = d.Mov AND ISNULL(NULLIF(mtmac.OrigenTipo,''),'CXC') = 'CXC' AND ISNULL(NULLIF(mtmac.Origen,''),ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG16247
  LEFT OUTER JOIN MovTipoMFAAplicaReporteExcepcion mtmree ON mtmree.Modulo = 'DIN' AND mtmree.Mov = d.Mov AND ISNULL(NULLIF(mtmree.OrigenTipo,''), 'CXC') = 'CXC' AND ISNULL(NULLIF(mtmree.Origen,''), ISNULL(c.Mov,'')) = ISNULL(c.Mov,'')
  --BUG18599
  LEFT OUTER JOIN MovTipoMFADocConciliado mtdc ON mtdc.Modulo = 'DIN' AND mtdc.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   --BUG18130
   AND d2.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND d.Estatus IN ('PENDIENTE','CONCLUIDO', 'CONCILIADO')
   AND (mt.Clave IN ('DIN.CH', 'DIN.CHE', 'DIN.D', 'DIN.DE'))
   AND (mt2.Clave IN ('DIN.SCH', 'DIN.SD'))
   AND (mt3.Clave IN ('CXC.A') /*OR mtmaa.Modulo IS NOT NULL*/)
   AND d.Importe IS NOT NULL    
   AND c.Importe IS NOT NULL       
   AND mme.ModuloID IS NULL
   AND mtmae.Mov IS NULL
GO

--REQ16670
/*** MFACxcDineroCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFACxcDineroCalc') and type = 'V') drop view dbo.MFACxcDineroCalc
GO
CREATE VIEW MFACxcDineroCalc AS
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFACxcDineroPreCalc
  UNION ALL
SELECT
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  tipo_aplicacion,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  Referencia,
  importe = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  cuenta_bancaria,
  aplica_ietu,
  aplica_ieps,
  aplica_iva,
  conciliado,
  dinero,
  dinero_id,
  --BUG18767
  tipo_documento
  FROM MFACxcDineroPreCalc2
GO

--REQ16711
/*** MFANominaCxpDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANominaCxpDocumentoPreCalc') and type = 'V') drop view dbo.MFANominaCxpDocumentoPreCalc
GO
CREATE VIEW MFANominaCxpDocumentoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'NOM',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = c.Proveedor,
  entidad_nombre         = pr.Nombre,
  entidad_rfc            = pr.RFC,
  entidad_id_fiscal      = pr.RFC,
  entidad_tipo_tercero   = CASE 
                             WHEN ISNULL(fr.Extranjero,0) = 0 THEN 'nacional'
                             WHEN ISNULL(fr.Extranjero,0) = 1 THEN 'extranjero'
                           END,
  entidad_tipo_operacion = pr.MFATipoOperacion,
  entidad_pais           = mp.Pais,
  entidad_nacionalidad   = mp.Nacionalidad,
  agente_clave           = pr.Agente,
  agente_nombre          = ag.Nombre,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = c.Importe*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = c.Retencion*c.TipoCambio,
  base_iva               = (ISNULL(CONVERT(float,c.Importe),0.0) + CASE WHEN ISNULL(ver.Impuesto2BaseImpuesto1,0.0) = 1 THEN ((CONVERT(float,c.Importe)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)) ELSE 0.0 END)*c.TipoCambio,
  iva_excento            = 0,
  --iva_tasa             = ROUND( ((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IVAFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IVAFiscal,0.0))) /NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,
  --BUG22370
  iva_tasa               = dbo.fnMFAIVATasa(c.Empresa, c.Importe,c.Impuestos),  
  --iva                    = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IVAFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IVAFiscal),0.0)*c.TipoCambio,
  iva                    = dbo.fnMFAIVA(c.Empresa,c.Importe,c.Impuestos)*c.TipoCambio,  
  base_ieps              = ISNULL(c.Importe,0.0)*c.TipoCambio,
  ieps_tasa               = ROUND(((CONVERT(float,c.Importe)/NULLIF((1.0-CONVERT(float,ISNULL(c.IEPSFiscal,0.0))),0.0))*CONVERT(float,ISNULL(c.IEPSFiscal,0.0)))/NULLIF(CONVERT(float,c.Importe),0.0),2)*100.0,    
  ieps                   = (ISNULL(CONVERT(float,c.Importe),0.0)/NULLIF((1.0-ISNULL(CONVERT(float,c.IEPSFiscal),0.0)),0.0))*ISNULL(CONVERT(float,c.IEPSFiscal),0.0)*c.TipoCambio,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = c.Dinero,
  dinero_id				   = c.DineroID,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Cxp c 
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CXP' 
  JOIN Prov pr ON pr.Proveedor = c.Proveedor 
  LEFT OUTER JOIN FiscalRegimen fr ON fr.FiscalRegimen = pr.FiscalRegimen 
  LEFT OUTER JOIN Pais pa ON pa.Clave = pr.Pais
  LEFT OUTER JOIN MFAPais mp ON mp.Pais = pa.Pais 
  LEFT OUTER JOIN Agente ag ON ag.Agente = pr.Agente 
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'CXP' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
  LEFT OUTER JOIN CxpD cd ON cd.ID = c.ID 
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'CXP' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('PENDIENTE','CONCLUIDO')
   AND (mt.Clave IN ('CXP.AF','CXP.CA','CXP.F','CXP.NC','CXP.CA','CXP.A','CXP.CD','CXP.D') OR mtmda.Modulo IS NOT NULL)
   --AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
   AND cd.ID IS NULL
   AND c.OrigenTipo IN ('NOM')
GO

--REQ16711
/*** MFANominaCxpDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANominaCxpDocumentoCalc') and type = 'V') drop view dbo.MFANominaCxpDocumentoCalc
GO
CREATE VIEW MFANominaCxpDocumentoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,  
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo, 
  TipoActivo,
  TipoActividad
FROM MFANominaCxpDocumentoPreCalc
GO

--REQ16711
/*** MFANominaCxpDocumentoPendienteCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANominaCxpDocumentoPendienteCalc') and type = 'V') drop view dbo.MFANominaCxpDocumentoPendienteCalc
GO
CREATE VIEW MFANominaCxpDocumentoPendienteCalc
AS
SELECT 
   origen_tipo,
   origen_modulo,
   origen_id,
   empresa,
   emisor,
   tipo_documento,
   subtipo_documento,
   folio,
   ejercicio,
   periodo,
   dia,
   --BUG22460
   fecha,
   entidad_clave,
   entidad_nombre,
   entidad_rfc,
   entidad_id_fiscal,
   entidad_tipo_tercero,
   entidad_tipo_operacion,
   entidad_pais,
   entidad_nacionalidad,
   agente_clave,
   agente_nombre,
   concepto,
   acumulable_deducible,
   importe,
   retencion_isr,
   retencion_iva,
   base_iva,
   iva_excento,
   iva_tasa,
   iva, 
   base_ieps,
   ieps_tasa,
   ieps,
   base_isan,
   isan,
   ieps_num_reporte,
   ieps_categoria_concepto,
   ieps_exento,
   ieps_envase_reutilizable,
   ieps_retencion, 
   ieps_cantidad, 
   ieps_unidad, 
   ieps_cantidad2,
   ieps_unidad2,          
   importe_total,
   concepto_clave,
   --REQ16748
   concepto_es_importacion,
   dinero,
   dinero_id,
   --BUG20353
   concepto_aplica_ietu,
   concepto_aplica_ieps,
   concepto_aplica_iva,
   --BUG22156
   EsActivoFijo, 
   TipoActivo,
   TipoActividad
 FROM MFANominaCxpDocumentoCalc
WHERE Estatus IN ('PENDIENTE','CONCLUIDO')
GO

--BUG18077
/*** MFANominaDocumentoPreCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANominaDocumentoPreCalc') and type = 'V') drop view dbo.MFANominaDocumentoPreCalc
GO
CREATE VIEW MFANominaDocumentoPreCalc AS
SELECT
  Estatus                = c.Estatus,
  origen_tipo            = 'auto',
  origen_modulo          = 'NOM',
  origen_id              = RTRIM(LTRIM(CONVERT(varchar,c.ID))),
  empresa                = c.Empresa,
  emisor                 = 'terceros',
  tipo_documento         = CASE  
                             WHEN mt.Clave IN ('CXP.AF','CXP.A') THEN 'anticipo' 
                             WHEN mt.Clave IN ('CXP.CA','CXP.F','CXP.NC','CXP.CD','CXP.D') THEN 'factura'
                             WHEN mt.Clave IN ('CXP.CA') THEN 'nota_credito'
                             ELSE mtmda.DocumentoTipo
                           END,
  subtipo_documento      = CONVERT(varchar(50),NULL),                                                  
  folio                  = RTRIM(ISNULL(c.Mov,'')) + ' ' + RTRIM(ISNULL(c.MovID,'')),
  ejercicio              = c.Ejercicio,
  periodo                = c.Periodo,
  dia                    = DAY(c.FechaEmision),
  --BUG22460
  fecha					 = c.FechaEmision,
  entidad_clave          = NULL,
  entidad_nombre         = NULL,
  entidad_rfc            = NULL,
  entidad_id_fiscal      = NULL,
  entidad_tipo_tercero   = NULL,
  entidad_tipo_operacion = NULL,
  entidad_pais           = NULL,
  entidad_nacionalidad   = NULL,
  agente_clave           = NULL,
  agente_nombre          = NULL,
  concepto               = ISNULL(c.Concepto,c.Mov),
  acumulable_deducible   = 'Si',
  importe                = (ISNULL(c.Percepciones, 0) - ISNULL(c.Deducciones, 0))*c.TipoCambio,
  retencion_isr          = 0.0, 
  retencion_iva          = 0.0,
  base_iva               = 0.0,
  iva_excento            = 0.0,
  iva_tasa               = 0.0,
  iva                    = 0.0,
  base_ieps              = 0.0,
  ieps_tasa              = 0.0,
  ieps                   = 0.0,
  base_isan              = 0.0,
  isan                   = 0.0,
  ieps_num_reporte         = CONVERT(varchar(20),NULL),
  ieps_categoria_concepto  = CONVERT(varchar(20),NULL),
  ieps_exento              = 0,
  ieps_envase_reutilizable = 0,
  ieps_retencion           = NULL, 
  ieps_cantidad            = 0.0, 
  ieps_unidad              = CONVERT(varchar(50),NULL), 
  ieps_cantidad2           = 0.0,
  ieps_unidad2             = CONVERT(varchar(50),NULL),    
  concepto_clave	       = c.Concepto,
  --REQ16748
  concepto_es_importacion  = 0,
  dinero				   = NULL,
  dinero_id				   = NULL,
  --BUG20353
  concepto_aplica_ietu     = 'Si',
  concepto_aplica_ieps     = 'Si',
  concepto_aplica_iva      = 'Si',
  --BUG22156
  EsActivoFijo			   = 0, 
  TipoActivo			   = NULL,
  TipoActividad			   = MFATipoActividad.Tipo
  FROM Nomina c  
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'NOM'
  JOIN EmpresaGral eg ON eg.Empresa = c.Empresa 
  LEFT OUTER JOIN Concepto co ON co.Concepto = c.Concepto AND co.Modulo = 'CXP'
  JOIN Version ver ON 1 = 1
  LEFT OUTER JOIN MFAMovExcepcion mme ON mme.Modulo = 'NOM' AND mme.ModuloID = c.ID    
  LEFT OUTER JOIN MovTipoMFADocExcepcion mtmde ON mtmde.Modulo = 'NOM' AND mtmde.Mov = c.Mov                
  LEFT OUTER JOIN MovTipoMFADocAdicion mtmda ON mtmda.Modulo = 'NOM' AND mtmda.Mov = c.Mov
  --BUG22156
  LEFT OUTER JOIN MFATipoActividad ON MFATipoActividad.Modulo = 'NOM' AND MFATipoActividad.Mov = c.Mov
 WHERE c.Estatus IN ('CONCLUIDO')
   AND (mt.Clave IN ('NOM.N', 'NOM.NE') OR mtmda.Modulo IS NOT NULL)
   AND mtmde.Mov IS NULL
   AND mme.ModuloID IS NULL
GO

--BUG18077
/*** MFANominaDocumentoCalc ***/
if exists (select * from sysobjects where id = object_id('dbo.MFANominaDocumentoCalc') and type = 'V') drop view dbo.MFANominaDocumentoCalc
GO
CREATE VIEW MFANominaDocumentoCalc
AS
SELECT 
  Estatus,
  origen_tipo,
  origen_modulo,
  origen_id,
  empresa,
  emisor,
  tipo_documento,
  subtipo_documento,
  folio,
  ejercicio,
  periodo,
  dia,
  --BUG22460
  fecha,
  entidad_clave,
  entidad_nombre,
  entidad_rfc,
  entidad_id_fiscal,
  entidad_tipo_tercero,
  entidad_tipo_operacion,
  entidad_pais,
  entidad_nacionalidad,
  agente_clave,
  agente_nombre,
  concepto,
  acumulable_deducible,
  importe,
  retencion_isr,
  retencion_iva,
  base_iva,
  iva_excento,
  iva_tasa,
  iva, 
  base_ieps,
  ieps_tasa,
  ieps,
  base_isan,
  isan,
  ieps_num_reporte,
  ieps_categoria_concepto,
  ieps_exento,
  ieps_envase_reutilizable,
  ieps_retencion, 
  ieps_cantidad, 
  ieps_unidad, 
  ieps_cantidad2,
  ieps_unidad2,        
  importe_total = ISNULL(importe,0.0) + ISNULL(iva,0.0) + ISNULL(ieps,0.0) + ISNULL(isan,0.0) - ISNULL(retencion_isr,0.0) - ISNULL(retencion_iva,0.0),
  concepto_clave,  
  --REQ16748
  concepto_es_importacion,
  dinero,
  dinero_id,
  --BUG20353
  concepto_aplica_ietu,
  concepto_aplica_ieps,
  concepto_aplica_iva,
  --BUG22156
  EsActivoFijo,
  TipoActivo,
  TipoActividad
FROM MFANominaDocumentoPreCalc
GO
/************************************************** Stored Procedures **************************************************/
--BUG22169
/************** spCopiarUsuarioCfgMFA *************/
if exists (select * from sysobjects where id = object_id('dbo.spCopiarUsuarioCfgMFA') and sysstat & 0xf = 4) drop procedure dbo.spCopiarUsuarioCfgMFA
GO
CREATE PROCEDURE spCopiarUsuarioCfgMFA
                   @UsuarioD    char(10),
                   @UsuarioA	char(10)
--//WITH ENCRYPTION
AS BEGIN
 
 UPDATE a
    SET InterfazExentus             = d.InterfazExentus,
		AccesoInterfazExentus       = d.AccesoInterfazExentus
   FROM UsuarioCfg2 a, UsuarioCfg2 d 
  WHERE a.Usuario = @UsuarioA AND d.Usuario = @UsuarioD

  EXEC xpCopiarUsuarioCfg @UsuarioD, @UsuarioA
  RETURN
END
GO

--BUG22169
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioMFA') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioMFA
GO
CREATE TRIGGER tgUsuarioMFA ON Usuario
--WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Usuario		char(10), 
    @Configuracion	char(10)
		
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Configuracion)
  BEGIN
    SELECT @Usuario = Usuario FROM Inserted
    SELECT @Configuracion = NULLIF(RTRIM(Configuracion), '') FROM Usuario WHERE Usuario = @Usuario

    IF @Usuario IS NOT NULL 
    BEGIN
      IF @Configuracion IS NOT NULL 
  	    EXEC spCopiarUsuarioCfgMFA @Configuracion, @Usuario
    END
  END
END
GO

--BUG22165
/**************** spMFAActivoFCatSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFAActivoFCatSugerir') and type = 'P') drop procedure dbo.spMFAActivoFCatSugerir
GO
CREATE PROC spMFAActivoFCatSugerir
--//WITH ENCRYPTION
AS BEGIN
  DELETE MFAActivoFCat
  
  INSERT INTO MFAActivoFCat(Categoria) SELECT Categoria FROM ActivoFCat

  RETURN
END
GO

--BUG22165
/**************** spMFAArtAFSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFAArtAFSugerir') and type = 'P') drop procedure dbo.spMFAArtAFSugerir
GO
CREATE PROC spMFAArtAFSugerir
--//WITH ENCRYPTION
AS BEGIN
  DELETE MFAArtAF
  
  INSERT INTO MFAArtAF(Articulo) SELECT Art.Articulo FROM Art JOIN ActivoFCat ON Art.CategoriaActivoFijo = ActivoFCat.Categoria WHERE Art.Tipo IN('Serie', 'Lote')
  
  RETURN
END
GO

--BUG21567
/**************** spMFAContAcum ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFAContAcum') and type = 'P') drop procedure dbo.spMFAContAcum
GO
CREATE PROC spMFAContAcum
			@Cuenta		char(20)= NULL
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE @Moneda				char(10) ,
		  @Moneda2				char(10) ,    
		  @SubCuenta			varchar(20),
		  @SubCuenta2			varchar(50),
		  @SubCuenta3			varchar(50),
		  @Proyecto				varchar(50),
		  @UEN					int,    
		  @CuentaAux			varchar(20),
		  @Grupo				char(10),
		  @Cargo				money,
		  @Abono				money,
		  @Cargo2				money,
		  @Abono2				money,
		  @Conciliado			bit,
		  @ImporteConciliar		money,
		  @ImporteConciliar2	money,    
		  @Fecha				datetime,
		  @Rama					char(5),
		  @Ejercicio			int,
		  @Periodo				int,
		  @Empresa				char(5),
		  @Sucursal				int

  DECLARE @CuentaNew	CHAR(20)
  DECLARE @RamaNew		CHAR(20)
  DECLARE @Contador		INT

  SELECT @Rama = 'CONT', @Fecha = GETDATE(), @Grupo = '', @Ejercicio = NULL, @Periodo =NULL

  SET @CuentaAux = @Cuenta

  IF @Cuenta IS NOT NULL
  BEGIN
    SET @RamaNew  = ''
    
    WHILE @RamaNew is not null
    BEGIN
      DELETE MFAAcum 
       WHERE Rama = @Rama
         AND Empresa 	= ISNULL(@Empresa,Empresa)
         AND Sucursal 	= ISNULL(@Sucursal,Sucursal)
         AND Cuenta 	= ISNULL(@Cuenta,Cuenta)
         AND Ejercicio 	= ISNULL(@Ejercicio,Ejercicio)
         AND Periodo 	= ISNULL(@Periodo,Periodo)
    
      SELECT @CuentaNew = b.cuenta, @RamaNew = NULLIF(ISNULL(RTRIM(b.rama), ''), '')
        FROM Cta a,Cta b
       WHERE a.Cuenta = @Cuenta
         AND a.Rama = b.Cuenta

      SELECT @RamaNew = NULLIF(ISNULL(RTRIM(@RamaNew), ''), '')
      
      SET @Cuenta = @CuentaNew
    END
  END
  ELSE
  BEGIN    
    DELETE MFAAcum 
     WHERE Rama = @Rama
       AND Empresa = ISNULL(@Empresa,Empresa)
       AND Sucursal = ISNULL(@Sucursal,Sucursal)
  END

  SET @Cuenta = @CuentaAux

  SELECT a.Sucursal, a.Empresa, a.Moneda, b.Cuenta, "SubCuenta"=ISNULL(LTRIM(b.SubCuenta),''),  
         Grupo = '', a.Ejercicio, a.Periodo, "Debe"=SUM(ISNULL(b.Debe,0)), "Haber"=SUM(ISNULL(b.Haber,0)),
         "SubCuenta2"=ISNULL(RTRIM(b.SubCuenta2), ''),  "SubCuenta3"=ISNULL(RTRIM(b.SubCuenta3), ''), "Proyecto"=ISNULL(RTRIM(a.Proyecto), ''), "UEN"=ISNULL(a.UEN, 0),
         --BUG22473 BUG2355
         ISNULL(a.OrigenMoneda, a.Moneda) 'Moneda2',
         SUM(ISNULL(b.Debe/NULLIF(ISNULL(a.OrigenTipoCambio, a.TipoCambio), 0),0)) "Debe2", 
         SUM(ISNULL(b.Haber/NULLIF(ISNULL(a.OrigenTipoCambio, a.TipoCambio), 0),0)) "Haber2"
/*
         CASE a.OrigenMoneda
           WHEN a.Moneda THEN NULL
           ELSE a.OrigenMoneda
         END 'Moneda2'/*a.Moneda2*/, 
         CASE a.OrigenMoneda
           WHEN a.Moneda THEN NULL
           ELSE SUM(ISNULL(b.Debe/NULLIF(a.OrigenTipoCambio, 0),0))
         END "Debe2", 
         CASE a.OrigenMoneda
           WHEN a.Moneda THEN NULL
           ELSE SUM(ISNULL(b.Haber/NULLIF(a.OrigenTipoCambio, 0),0))
         END "Haber2"
*/         
    INTO #tcrAuxiliar
    FROM Cont a, ContD b, Movtipo c
   WHERE a.Id = b.Id
     AND a.Estatus   = 'CONCLUIDO'
     AND a.Empresa = ISNULL(@Empresa,a.Empresa)
     AND a.Sucursal = ISNULL(@Sucursal,a.Sucursal)
     AND b.Cuenta   = ISNULL(@Cuenta,b.Cuenta)
     AND a.Ejercicio = ISNULL(@Ejercicio,a.Ejercicio)
     AND a.Periodo   = ISNULL(@Periodo,a.Periodo)
     AND a.Mov  = c.Mov
     AND c.Modulo  = 'CONT'
     AND c.Clave   <> 'CONT.PR'
   GROUP BY a.Sucursal, a.Empresa, a.Moneda, b.Cuenta,  ISNULL(LTRIM(b.SubCuenta),''), a.Ejercicio, a.Periodo,
        ISNULL(RTRIM(b.SubCuenta2), ''),  ISNULL(RTRIM(b.SubCuenta3), ''), ISNULL(RTRIM(a.Proyecto), ''), ISNULL(a.UEN, 0), a.OrigenMoneda/*a.Moneda2*/

  DELETE #tcrAuxiliar WHERE ISNULL(Debe,0)=0 AND ISNULL(Haber,0)=0 AND ISNULL(Debe2,0)=0 AND ISNULL(Haber2,0)=0
  DECLARE crAuxiliar CURSOR FOR
    SELECT Sucursal, Empresa, Moneda, Cuenta, SubCuenta, Grupo, Ejercicio, Periodo, Debe, Haber, SubCuenta2, SubCuenta3, Proyecto, UEN, Moneda2, Debe2, Haber2
      FROM #tcrAuxiliar
     ORDER BY Cuenta, SubCuenta, SubCuenta2, SubCuenta3, Grupo, Proyecto, UEN, Ejercicio, Periodo, Moneda, Sucursal, Empresa
  OPEN crAuxiliar
  FETCH NEXT FROM crAuxiliar INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @SubCuenta2, @SubCuenta3, @Proyecto, @UEN, @Moneda2, @Cargo2, @Abono2
  WHILE @@FETCH_STATUS <> -1
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SET @RamaNew  = ''
      WHILE @RamaNew is not null
      BEGIN
        SELECT @ImporteConciliar = @Cargo - @Abono,
               @ImporteConciliar2 = @Cargo2 - @Abono2

        IF ISNULL(@Moneda,'')<>'' AND ISNULL(@Moneda2,'')=ISNULL(@Moneda,'')
        BEGIN                        
          -- Para Moneda                 
          UPDATE MFAAcum
             SET Cargos		= ISNULL(Cargos, 0.0) + ISNULL(@Cargo,0.0),
                 Abonos		= ISNULL(Abonos, 0.0) + ISNULL(@Abono,0.0),
                 UltimoCambio	= @Fecha
           WHERE Sucursal		= @Sucursal
             AND Empresa		= @Empresa
             AND Rama			= @Rama
             AND Moneda			= @Moneda
             AND Grupo			= @Grupo
             AND Cuenta			= @Cuenta
             AND SubCuenta		= @SubCuenta
             AND Periodo		= @Periodo
             AND Ejercicio		= @Ejercicio
             AND SubCuenta2		= @SubCuenta2
             AND SubCuenta3		= @SubCuenta3
             AND Proyecto		= @Proyecto
             AND UEN			= @UEN

          IF @@ROWCOUNT = 0
            INSERT MFAAcum (Sucursal,  Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, UltimoCambio, SubCuenta2, SubCuenta3, Proyecto, UEN)
                VALUES (@Sucursal, @Empresa, @Rama, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo,  @Abono, @Fecha, @SubCuenta2, @SubCuenta3, @Proyecto, @UEN)         

        END
                             
        IF ISNULL(@Moneda2,'')<>'' AND ISNULL(@Moneda2,'')<>ISNULL(@Moneda,'')
        BEGIN  
          --Para Moneda2
          UPDATE MFAAcum
             SET Cargos			= ISNULL(Cargos, 0.0) + ISNULL(@Cargo2,0.0),
                 Abonos			= ISNULL(Abonos, 0.0) + ISNULL(@Abono2,0.0),
                 UltimoCambio	= @Fecha
           WHERE Sucursal		= @Sucursal
             AND Empresa		= @Empresa
             AND Rama			= @Rama
             AND Moneda			= @Moneda2
             AND Grupo			= @Grupo
             AND Cuenta			= @Cuenta
             AND SubCuenta		= @SubCuenta
             AND Periodo		= @Periodo
             AND Ejercicio		= @Ejercicio
             AND SubCuenta2		= @SubCuenta2
             AND SubCuenta3		= @SubCuenta3
             AND Proyecto		= @Proyecto
             AND UEN			= @UEN

          IF @@ROWCOUNT = 0
            INSERT MFAAcum (Sucursal, Empresa,  Rama,  Moneda,  Cuenta,  SubCuenta,  Grupo,  Ejercicio,  Periodo,  Cargos,  Abonos, UltimoCambio, SubCuenta2, SubCuenta3, Proyecto, UEN)
                VALUES (@Sucursal, @Empresa, @Rama, @Moneda2, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo2,  @Abono2, @Fecha, @SubCuenta2, @SubCuenta3, @Proyecto, @UEN)

        END

        SELECT @CuentaNew = b.cuenta, @RamaNew = b.rama
          FROM Cta a,Cta b
         WHERE a.Cuenta = @Cuenta
           AND a.Rama = b.Cuenta

        SET @Cuenta = @CuentaNew
        SET @Contador = @Contador + 1

        --EXEC spMFAContTraspasarSaldos @Cuenta, @Empresa, @Ejercicio
      END      
    END
    FETCH NEXT FROM crAuxiliar INTO @Sucursal, @Empresa, @Moneda, @Cuenta, @SubCuenta, @Grupo, @Ejercicio, @Periodo, @Cargo, @Abono, @SubCuenta2, @SubCuenta3, @Proyecto, @UEN, @Moneda2, @Cargo2, @Abono2  
  END
  
  CLOSE crAuxiliar
  DEALLOCATE crAuxiliar
         
  RETURN
END
GO

--BUG21567
/**************** spMFAContTraspasarSaldos ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFAContTraspasarSaldos') and type = 'P') drop procedure dbo.spMFAContTraspasarSaldos
GO             
CREATE PROC spMFAContTraspasarSaldos
            @Empresa	char(5),
		    @Ejercicio	int,
            @Procesando bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ahora		datetime,
    @EjercicioAnterior	int,
    @Sucursal		int,
    @Rama		char(5), 
    @Moneda		char(10),
    @Grupo		char(10),
    @Cuenta		char(20),
    @SubCuenta		varchar(50),
    @Cargos		money,
    @Abonos		money,
    @CargoInicial	money,
    @AbonoInicial	money,
    @CargosU		float,
    @AbonosU		float,
    @CargoInicialU	float,
    @AbonoInicialU	float,
    @EjercicioInicio	datetime,
    @EjercicioFinal	datetime,
    @SeCreoEjercicio	bit,
    @SeModificioGral	bit,
    @Mensaje		char(150)

  SELECT @Ahora = GETDATE(), @EjercicioAnterior = @Ejercicio - 1, @SeCreoEjercicio = 0, @SeModificioGral = 0

    /* Acum */
    DECLARE crAcum CURSOR FOR
     SELECT Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta, "Cargos"=ISNULL(SUM(Cargos), 0.0), "Abonos"=ISNULL(SUM(Abonos), 0.0)
       FROM MFAAcum
      WHERE Empresa = @Empresa AND Ejercicio = @EjercicioAnterior
      GROUP BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta
      ORDER BY Sucursal, Rama, Moneda, Grupo, Cuenta, SubCuenta

    OPEN crAcum
    FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Cargos > @Abonos 
          SELECT @CargoInicial = @Cargos - @Abonos, @AbonoInicial = 0.0
        ELSE
          SELECT @CargoInicial = 0.0, @AbonoInicial = @Abonos - @Cargos
      
        UPDATE MFAAcum
           --SET Cargos 	    = @Cargos, Abonos = @Abonos,
           SET Cargos 	    = @CargoInicial, Abonos = @AbonoInicial,
               UltimoCambio = @Ahora
         WHERE Sucursal  = @Sucursal
           AND Rama 	 = @Rama
           AND Empresa 	 = @Empresa 
           AND Ejercicio = @Ejercicio
           AND Periodo 	 = 0
           AND Moneda 	 = @Moneda
           AND Grupo 	 = @Grupo
           AND Cuenta 	 = @Cuenta
           AND SubCuenta = @SubCuenta

         IF @@ROWCOUNT = 0
         BEGIN
           SELECT @SeCreoEjercicio = 1
           --BUG23552
           INSERT MFAAcum (Sucursal, Empresa, Rama, Ejercicio, Periodo, Moneda, Grupo, Cuenta, SubCuenta, Cargos, Abonos, UltimoCambio, SubCuenta2, SubCuenta3, Proyecto, UEN)
                VALUES (@Sucursal, @Empresa, @Rama, @Ejercicio, 0, @Moneda, @Grupo, @Cuenta, @SubCuenta, @CargoInicial, @AbonoInicial, @Ahora, '', '', '', '')
         END
      END
      FETCH NEXT FROM crAcum INTO @Sucursal, @Rama, @Moneda, @Grupo, @Cuenta, @SubCuenta, @Cargos, @Abonos
    END -- While
    CLOSE crAcum
    DEALLOCATE crAcum
    
  RETURN
END
GO

/**************** fnMFACuentaSaldoInicial ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFACuentaSaldoInicial') drop function dbo.fnMFACuentaSaldoInicial
GO
--BUG19206 REQ23317
CREATE FUNCTION fnMFACuentaSaldoInicial (@Empresa varchar(5), @Ejercicio int, @Periodo int, @Cuenta varchar(20), @Moneda varchar(10), @Campo varchar(10))
RETURNS float
WITH ENCRYPTION
AS BEGIN

  DECLARE
  @Resultado					float,
  @Resultado2					float,
  
  @IFRS							bit,
  @IncluirCuentasEspecificas	bit
  
  SELECT @IFRS = ISNULL(IFRS, 0), @IncluirCuentasEspecificas = ISNULL(IncluirCuentasEspecificas, 0) FROM EmpresaMFA WHERE Empresa = @Empresa
  
  --BUG22575 REQ23317
  IF @Campo = ''
    SELECT @Periodo = 1
  
  SET @Resultado2 = 0
  
  --BUG22478
  --IF @IFRS  = 1 AND @IncluirCuentasEspecificas = 1
  IF @IncluirCuentasEspecificas = 1
    --BUG19206
    SELECT 
      --REQ23317
      @Resultado = CASE ISNULL(@Campo, '')
                     WHEN ''		THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Saldo,0.0)),0.0)  ELSE ISNULL(SUM(ISNULL(Saldo,0.0)),0.0) *-1 END --BUG19776         
                     WHEN 'Cargos'	THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Cargos,0.0)),0.0) ELSE ISNULL(SUM(ISNULL(Cargos,0.0)),0.0) *-1 END --BUG19776         
                     WHEN 'Abonos'	THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Abonos,0.0)),0.0) ELSE ISNULL(SUM(ISNULL(Abonos,0.0)),0.0) *-1 END --BUG19776                              
                   END
      FROM MFACtaSaldoEjercicio
      LEFT OUTER JOIN MFACuentasEspeciales C ON C.Cuenta=MFACtaSaldoEjercicio.Cuenta --BUG19776 
     WHERE MFACtaSaldoEjercicio.Empresa = @Empresa
       AND MFACtaSaldoEjercicio.Ejercicio = @Ejercicio
       AND MFACtaSaldoEjercicio.Periodo BETWEEN 0 AND @Periodo-1
       AND MFACtaSaldoEjercicio.Cuenta = @Cuenta
       AND MFACtaSaldoEjercicio.Moneda = @Moneda
      GROUP BY ISNULL(C.Cuenta, '')
  ELSE
  BEGIN
    --BUG19206
    SELECT 
      --REQ23317
      @Resultado = CASE ISNULL(@Campo, '')
                     WHEN ''		THEN ISNULL(SUM(ISNULL(Saldo,0.0)),0.0)
                     WHEN 'Cargos'	THEN ISNULL(SUM(ISNULL(Cargos,0.0)),0.0)
                     WHEN 'Abonos'	THEN ISNULL(SUM(ISNULL(Abonos,0.0)),0.0)
                   END            
      FROM MFACtaSaldoEjercicio
     WHERE Empresa = @Empresa
       AND Ejercicio = @Ejercicio
       AND Periodo BETWEEN 0 AND @Periodo - 1
       AND Cuenta = @Cuenta
       AND Moneda = @Moneda       
  END
     
  --BUG19206
  IF @Resultado = 0 AND @Resultado2 <> 0
    SET @Resultado = @Resultado2
          
  RETURN ISNULL(@Resultado, 0)
  
END
GO

--BUG21567
/**************** fnMFACuentaSaldoInicialComp ****************/
if exists (select * FROM sysobjects WHERE name = 'fnMFACuentaSaldoInicialComp') drop function dbo.fnMFACuentaSaldoInicialComp
GO
CREATE FUNCTION fnMFACuentaSaldoInicialComp (@Empresa varchar(5), @Ejercicio int, @Periodo int, @Cuenta varchar(20), @Moneda varchar(10), @Campo varchar(10))
RETURNS float
WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado					float,
  @Resultado2					float,
  
  @IFRS							bit,
  @IncluirCuentasEspecificas	bit
  
  SELECT @IFRS = ISNULL(IFRS, 0), @IncluirCuentasEspecificas = ISNULL(IncluirCuentasEspecificas, 0) FROM EmpresaMFA WHERE Empresa = @Empresa
  
  --BUG22575
  IF @Campo = ''  
    SELECT @Periodo = 1
  
  SET @Resultado2 = NULL
  
  --BUG22478
  --IF @IFRS  = 1 AND @IncluirCuentasEspecificas = 1
  IF @IncluirCuentasEspecificas = 1
    --BUG19206
    SELECT 
      @Resultado = CASE ISNULL(@Campo, '')
                     WHEN ''		THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Saldo,0.0)),0.0)  ELSE ISNULL(SUM(ISNULL(Saldo,0.0)),0.0) *-1 END --BUG19776         
                     WHEN 'Cargos'	THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Cargos,0.0)),0.0) ELSE ISNULL(SUM(ISNULL(Cargos,0.0)),0.0) *-1 END --BUG19776         
                     WHEN 'Abonos'	THEN CASE ISNULL(C.Cuenta, '')  WHEN '' THEN ISNULL(SUM(ISNULL(Abonos,0.0)),0.0) ELSE ISNULL(SUM(ISNULL(Abonos,0.0)),0.0) *-1 END --BUG19776                              
                   END      
      FROM MFACtaSaldoEjercicioComp
      LEFT OUTER JOIN MFACuentasEspeciales C ON C.Cuenta=MFACtaSaldoEjercicioComp.Cuenta --BUG19776 
     WHERE MFACtaSaldoEjercicioComp.Empresa = @Empresa
       AND MFACtaSaldoEjercicioComp.Ejercicio = @Ejercicio
       AND MFACtaSaldoEjercicioComp.Periodo BETWEEN 0 AND @Periodo-1
       AND MFACtaSaldoEjercicioComp.Cuenta = @Cuenta
       AND MFACtaSaldoEjercicioComp.Moneda = @Moneda
      GROUP BY ISNULL(C.Cuenta, '')
  ELSE
  BEGIN
    --BUG19206
    SELECT 
      --REQ23317
      @Resultado = CASE ISNULL(@Campo, '')
                     WHEN ''		THEN ISNULL(SUM(ISNULL(Saldo,0.0)),0.0)
                     WHEN 'Cargos'	THEN ISNULL(SUM(ISNULL(Cargos,0.0)),0.0)
                     WHEN 'Abonos'	THEN ISNULL(SUM(ISNULL(Abonos,0.0)),0.0)
                   END
      FROM MFACtaSaldoEjercicioComp
     WHERE Empresa = @Empresa
       AND Ejercicio = @Ejercicio
       AND Periodo BETWEEN 0 AND @Periodo - 1
       AND Cuenta = @Cuenta
       AND Moneda = @Moneda       
  END
     
  --BUG19206
  IF @Resultado = 0 AND @Resultado2 <> 0
    SET @Resultado = @Resultado2
          
  RETURN ISNULL(@Resultado, 0)
END
GO

/*********** sp_layout_init ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_init') and type = 'P') drop procedure dbo.sp_layout_init
GO
CREATE PROCEDURE sp_layout_init
					@log_id		int,
					@empresa	varchar(5),
					@ejercicio	smallint,
					@periodo	smallint,
					@tipo		varchar(50),
					--BUG22460
					@FechaD		datetime	= NULL,
					@FechaA		datetime	= NULL
WITH ENCRYPTION
AS BEGIN
  IF @tipo IN ('todo', 'flujo')
  BEGIN
    --BUG22460
	DELETE 
	  FROM documentos	  
	 WHERE empresa = @empresa 
	   AND ejercicio = ISNULL(@ejercicio, ejercicio) 
	   AND periodo = ISNULL(@periodo, periodo)
	   AND fecha >= ISNULL(@FechaD, fecha) 
	   AND fecha <= ISNULL(@FechaA, fecha)
	   AND origen_tipo = 'calc'

    --BUG22460
	DELETE
	  FROM DatosIetu
	 WHERE empresa = @empresa 
	   AND ejercicio = ISNULL(@ejercicio, ejercicio) 
	   AND periodoasi = ISNULL(@periodo, periodoasi)
	   AND fecha >= ISNULL(@FechaD, fecha) 
	   AND fecha <= ISNULL(@FechaA, fecha)

    --BUG22460
	DELETE
	  FROM ximpiva
	 WHERE empresa = @empresa
	   AND ejercicio = ISNULL(@ejercicio, ejercicio) 
	   AND periodo = ISNULL(@periodo, periodo)
	   AND fecha >= ISNULL(@FechaD, fecha) 
	   AND fecha <= ISNULL(@FechaA, fecha)
     
    --BUG22460
	DELETE
	  FROM DatosIeps
	 WHERE empresa = @empresa 
	   AND ejercicio = ISNULL(@ejercicio, ejercicio) 
	   AND periodo = ISNULL(@periodo, periodo)
	   AND fecha >= ISNULL(@FechaD, fecha) 
	   AND fecha <= ISNULL(@FechaA, fecha)
  END
   
  IF @tipo IN ('todo', 'contabilidad')
  BEGIN
    --BUG22460
	DELETE
	  FROM MovContables
	 WHERE empresa = @empresa 
	   AND anio  = ISNULL(@ejercicio, YEAR(@FechaA))
	   AND mes	 = ISNULL(@periodo, MONTH(@FechaA))

	DELETE
	  FROM CuentasContables
    
    --BUG22460
	DELETE
	  FROM SaldosIni
	 WHERE Empresa = @empresa AND anio = ISNULL(@ejercicio, YEAR(@FechaD))
  END
END					
GO

/*********** sp_layout_referencias_ok ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_referencias_ok') and type = 'P') drop procedure dbo.sp_layout_referencias_ok
GO
CREATE PROCEDURE sp_layout_referencias_ok
					@log_id				int,
					@empresa			varchar(5),
					@ejercicio			smallint,
					@periodo			smallint,
					@error				int				OUTPUT,
					@error_mensaje		varchar(255)	OUTPUT,
					--BUG22460
					@FechaD				datetime		= NULL,
					@FechaA				datetime		= NULL,
					--BUG22575
					@ValidarReferencias	bit				= 1
WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  ---REQ16752 BUG22460
  INSERT layout_logd (
         log_id,  folio, referencia, aplicacion_origen_id, aplicacion_origen_modulo, aplicacion_tipo_aplicacion, empresa, origen_vista)
  SELECT @log_id, folio, referencia, origen_id,            origen_modulo,            tipo_aplicacion,            empresa, origen_vista
    FROM aplicaciones 
   WHERE empresa = @empresa 
     AND periodo = @periodo
     AND fecha     >= ISNULL(@FechaD, fecha) 
     AND fecha     <= ISNULL(@FechaA, fecha)
     AND referencia NOT IN (SELECT folio FROM documentos WHERE empresa = @empresa UNION ALL SELECT folio FROM aplicaciones WHERE empresa = @empresa)  

  --BUG22575
  IF @@ROWCOUNT > 0
    IF @ValidarReferencias	= 1
      SELECT @error = 1, @error_mensaje = 'Referencias Invalidas'
    ELSE
      SELECT @error = NULL, @error_mensaje = 'Referencias Invalidas'
END					
GO

/*********** sp_layout_aplicaciones ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_aplicaciones') and type = 'P') drop procedure dbo.sp_layout_aplicaciones
GO
CREATE PROCEDURE sp_layout_aplicaciones
					@log_id				int,
					@empresa			varchar(5),
					@ejercicio			smallint,
					@periodo			smallint,
					@conteo_documentos	int			OUTPUT,
					--BUG22460
					@FechaD				datetime	= NULL,
					@FechaA				datetime	= NULL
WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @folio_id				int,
    @referencia_id			int,
    @aplicacion_id			int, 
    @folio					varchar(50), 
    @referencia				varchar(50), 
    @tipo_aplicacion		varchar(50), 
    @tipo_documento			varchar(50), 
    @importe				float,
    @importe_total			float,
    @factor					float,
    @entidad_clave          varchar(20),
    @entidad_nombre         varchar(150),
    @entidad_rfc            varchar(15),
    @entidad_id_fiscal      varchar(50),
    @entidad_tipo_tercero   varchar(50),
    @entidad_tipo_operacion varchar(50),
    @entidad_pais           varchar(20),
    @entidad_nacionalidad   varchar(50),
    --BUG16688
    @origen_modulo			varchar(50),
    @EsRedocumentacion		bit,
    @Base					varchar(255),
    @EjercicioAux			int,
    @EjercicioAuxAnt		int,
    @PeriodoAux				int,
    @PeriodoAuxAnt			int

  CREATE TABLE #Valida(RID int IDENTITY, empresa varchar(5), origen_modulo varchar(50) NULL, folio varchar(50) NULL)  
  CREATE INDEX Valida ON #Valida(empresa, origen_modulo, folio)
  
  SELECT @Base = db_name()
/*  
  SELECT @EjercicioAuxAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @EjercicioAux = MIN(Ejercicio)
      FROM aplicaciones
     WHERE empresa = @Empresa
       AND tipo_aplicacion IN ('aplicacion', 'redocumentacion')
       AND Ejercicio > @EjercicioAuxAnt

    IF @EjercicioAux IS NULL BREAK
    
    SELECT @EjercicioAuxAnt = @EjercicioAux

    SELECT @PeriodoAuxAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @PeriodoAux = MIN(Periodo)
        FROM aplicaciones
       WHERE empresa = @Empresa
         AND tipo_aplicacion IN ('aplicacion', 'redocumentacion')
         AND Ejercicio = @EjercicioAux
         AND Periodo > @PeriodoAuxAnt

      IF @PeriodoAux IS NULL BREAK
    
      SELECT @PeriodoAuxAnt = @PeriodoAux

      --BUG22759
      DELETE documentos WHERE ISNULL(EsRedocumentacion, 0) = 1 and empresa = @empresa AND Ejercicio = @EjercicioAux AND Periodo = @PeriodoAux
      
      EXEC spShrink_Log @Base
    END    
  END
*/
  
  DECLARE cr_aplicaciones CURSOR LOCAL STATIC FOR
   --BUG16688 BUG22460
   SELECT a.aplicacion_id, a.tipo_aplicacion, a.folio, a.referencia, ISNULL(a.importe, 0.0), lae.entidad_clave, lae.entidad_nombre, lae.entidad_rfc, lae.entidad_id_fiscal, lae.entidad_tipo_tercero, lae.entidad_tipo_operacion, lae.entidad_pais, lae.entidad_nacionalidad, a.origen_modulo
     FROM aplicaciones a
     LEFT OUTER JOIN layout_aplicacion_entidad lae ON lae.folio = a.folio AND lae.referencia = a.referencia AND lae.empresa = a.empresa     
    WHERE a.empresa = @empresa     
      --AND ejercicio = ISNULL(@ejercicio, Ejercicio) 
      --AND periodo   = ISNULL(@periodo, periodo)
      --AND fecha     >= ISNULL(@FechaD, fecha) 
      --AND fecha     <= ISNULL(@FechaA, fecha)         
      AND a.tipo_aplicacion IN ('aplicacion', 'redocumentacion')
    ORDER BY dia
  OPEN cr_aplicaciones
  --BUG16688
  FETCH NEXT FROM cr_aplicaciones INTO @aplicacion_id, @tipo_aplicacion, @folio, @referencia, @importe, @entidad_clave, @entidad_nombre, @entidad_rfc, @entidad_id_fiscal, @entidad_tipo_tercero, @entidad_tipo_operacion, @entidad_pais, @entidad_nacionalidad, @origen_modulo
  WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @importe_total = 0.0, @factor = 0.0, @tipo_documento = NULL
      
      IF NOT EXISTS(SELECT RID FROM #Valida WHERE empresa = @empresa AND origen_modulo = @origen_modulo AND folio = @folio)
      BEGIN
        INSERT INTO #Valida(empresa, origen_modulo, folio) SELECT @empresa, @origen_modulo, @folio
        
        IF EXISTS(SELECT TOP 1 documento_id FROM documentos WHERE empresa = @empresa AND folio = @folio)
          SELECT @EsRedocumentacion = 1
        ELSE
          SELECT @EsRedocumentacion = 0      
      END

      IF @EsRedocumentacion = 0
      BEGIN
        IF @tipo_aplicacion = 'redocumentacion'
        BEGIN
	      SELECT @tipo_documento = (SELECT TOP(1) tipo_documento FROM documentos WHERE empresa = @empresa AND folio = @referencia ORDER BY documento_id)
	      --BUG22833
	      SELECT @importe_total = SUM(importe_total - ISNULL(BaseIVAImportacion, 0))
  	        FROM documentos 
           WHERE empresa = @empresa AND referencia = @referencia
           --BUG16688
             --AND origen_modulo = @origen_modulo
          SELECT @factor = @importe / NULLIF(@importe_total, 0.0)
		  IF ISNULL(@factor, 0.0) <> 0.0 AND @tipo_documento IN ('factura', 'nota_cargo')
		  BEGIN
  		    --TRUNCATE TABLEdocumentos where folio = @folio and empresa = @empresa
  		    INSERT INTO documentos (
		     log_id,
		     origen_tipo, 
		     origen_modulo,
		     empresa, 
		     emisor, 
		     tipo_documento, 
		     folio,
		     ejercicio, 
		     periodo, 
		     dia,
		     entidad_clave,
		     entidad_nombre,
		     entidad_rfc,
		     entidad_id_fiscal,
		     entidad_tipo_tercero,
		     entidad_tipo_operacion,
		     entidad_pais,
		     entidad_nacionalidad,
		     concepto,
		     acumulable_deducible,
		     importe, 
		     retencion_isr, 
		     retencion_iva,
		     base_iva, 
		     iva_excento, 
		     iva_tasa, iva, 
		     base_ieps, 
		     ieps_tasa, 
		     ieps, 
		     base_isan, 
		     isan, 
		     importe_total, 
		     referencia, 
		     aplicacion_id,
		     ieps_num_reporte,
		     ieps_categoria_concepto,
		     ieps_exento,					
		     ieps_envase_reutilizable,
		     ieps_retencion,
		     ieps_cantidad,
		     ieps_unidad,
		     ieps_cantidad2,
		     ieps_unidad2,
		     /*REQ16520*/
		     concepto_clave,
		     /*REQ16748*/
		     concepto_es_importacion,
		     /*BUG20353*/
		     concepto_aplica_ieps, 
		     concepto_aplica_ietu, 
		     concepto_aplica_iva,
		     /*BUG22460*/
		     fecha,
		     /*BUG22759*/
		     EsRedocumentacion,
		     /*BUG22833*/
		     BaseIVAImportacion, 
		     /*BUG23552*/
		     ieps_iva,
		     origen_vista,
             --BUG24733
             PorcentajeDeducible)
		    SELECT 
		     @log_id,
		     /*BUG16688 BUG22759*/
		     origen_tipo, 
		     --BUG24719
		     @origen_modulo,
		     empresa, 
		     emisor, 
		     @tipo_documento, 
		     @folio, 
		     ejercicio, 
		     periodo, 
		     dia, 
  		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE @entidad_clave END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE @entidad_nombre END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE @entidad_rfc END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE @entidad_id_fiscal END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_tercero ELSE @entidad_tipo_tercero END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_operacion ELSE @entidad_tipo_operacion END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE @entidad_pais END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE @entidad_nacionalidad END,			   
		     concepto, 
		     acumulable_deducible,
		     SUM(importe)*@factor, 
		     SUM(retencion_isr)*@factor, 
		     SUM(retencion_iva)*@factor,
		     SUM(base_iva)*@factor, 
		     iva_excento, 
		     iva_tasa, 
		     SUM(iva)*@factor,
		     SUM(base_ieps)*@factor, 
		     ieps_tasa, 
		     SUM(ieps)*@factor, 
		     SUM(base_isan)*@factor, 
		     SUM(isan)*@factor,
		     SUM(importe_total)*@factor, 
		     @folio, 
		     @aplicacion_id,
		     ieps_num_reporte,
		     ieps_categoria_concepto,
		     ieps_exento,					
		     ieps_envase_reutilizable,
		     SUM(ieps_retencion),
		     SUM(ieps_cantidad),
		     ieps_unidad,
		     SUM(ieps_cantidad2),				
		     ieps_unidad2,
		     /*REQ16520*/
		     concepto_clave,
		     /*REQ16748*/
		     concepto_es_importacion,
		     /*BUG20353*/
		     concepto_aplica_ieps, 
		     concepto_aplica_ietu, 
		     concepto_aplica_iva,
		     /*BUG22460*/
		     fecha,
		     /*BUG22759*/
		     @EsRedocumentacion,
		     /*BUG22833*/
		     SUM(BaseIVAImportacion)*@factor, 
		     /*BUG23552*/
		     SUM(ieps_iva)*@factor,
		     origen_vista,
             --BUG24733
             ISNULL(PorcentajeDeducible, 100)
		    FROM documentos
		    --BUG16688
	       WHERE empresa = @empresa AND referencia = @referencia --AND origen_modulo = @origen_modulo
	       GROUP BY origen_tipo,origen_modulo,origen_id,empresa,emisor,ejercicio,periodo,dia, 
  		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE @entidad_clave END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE @entidad_nombre END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE @entidad_rfc END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE @entidad_id_fiscal END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_tercero ELSE @entidad_tipo_tercero END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_operacion ELSE @entidad_tipo_operacion END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE @entidad_pais END, 
		     CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE @entidad_nacionalidad END,			   	       
	         concepto,acumulable_deducible,iva_excento, iva_tasa,ieps_tasa, ieps_num_reporte, ieps_categoria_concepto, 
	         ieps_exento, ieps_envase_reutilizable,	ieps_unidad, ieps_unidad2,/*REQ16520*/concepto_clave,/*REQ16748*/concepto_es_importacion,/*BUG20353*/concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva,/*BUG22460*/
	         fecha, origen_vista, 
	         --BUG24733
	         PorcentajeDeducible
	       SELECT @conteo_documentos = @conteo_documentos + @@ROWCOUNT
	    END
      END ELSE 
      BEGIN
    	  SELECT @tipo_documento = (SELECT TOP(1) tipo_documento FROM documentos WHERE empresa = @empresa AND folio = @folio ORDER BY documento_id)
	      --BUG22833
	      SELECT @importe_total = SUM(importe_total - ISNULL(BaseIVAImportacion, 0))
  	        FROM documentos 
           WHERE empresa = @empresa AND referencia = @folio
               --BUG16688
             --AND origen_modulo = @origen_modulo
          SELECT @factor = @importe / NULLIF(@importe_total, 0.0)
		  IF ISNULL(@factor, 0.0) <> 0.0 AND @tipo_documento IN ('nota_credito', 'nota_cargo', 'devolucion')
		  BEGIN
  		    IF @tipo_documento IN ('nota_credito')
		      SELECT @factor = -@factor        

		    INSERT INTO documentos (
			   log_id, 
			   --BUG16688 BUG22759
			   origen_tipo, origen_modulo,
			   empresa, emisor, tipo_documento, folio, 
			   ejercicio, periodo, dia, 
			   entidad_clave, 
			   entidad_nombre, 
			   entidad_rfc, 
			   entidad_id_fiscal, 
			   entidad_tipo_tercero, 
			   entidad_tipo_operacion, 
			   entidad_pais, 
			   entidad_nacionalidad,	
			   concepto, acumulable_deducible,
			   importe, retencion_isr, retencion_iva, 
			   base_iva, iva_excento, iva_tasa, iva, 
			   base_ieps, ieps_tasa, ieps, base_isan, isan, 
			   importe_total, 
			   referencia, aplicacion_id,
               ieps_num_reporte,			
               ieps_categoria_concepto,		
               ieps_exento,					
               ieps_envase_reutilizable,	
               ieps_retencion,				
               ieps_cantidad,				
               ieps_unidad,					
               ieps_cantidad2,				
               ieps_unidad2,
               --REQ16520
               concepto_clave,
               --REQ16748
               concepto_es_importacion,
               --BUG20353
               concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva,
               --BUG22460
               fecha,
               --BUG22759
               EsRedocumentacion,
               --BUG22833
               BaseIVAImportacion, 
		       /*BUG23552*/
		       ieps_iva,
		       origen_vista,
               --BUG24733
               PorcentajeDeducible
			   )
	         SELECT @log_id,
  	           --BUG16688 BUG22759
	           origen_tipo, 
	           --BUG24719
		       @origen_modulo,
	           empresa, emisor, tipo_documento, folio, 
			   ejercicio, periodo, dia, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE @entidad_clave END, 
  			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE @entidad_nombre END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE @entidad_rfc END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE @entidad_id_fiscal END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_tercero ELSE @entidad_tipo_tercero END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_tipo_operacion ELSE @entidad_tipo_operacion END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE @entidad_pais END, 
			   CASE WHEN folio NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE @entidad_nacionalidad END,	
			   concepto, acumulable_deducible,
			   importe*@factor, retencion_isr*@factor, retencion_iva*@factor, 
			   base_iva*@factor, iva_excento, iva_tasa, iva*@factor, 
			   base_ieps*@factor, ieps_tasa, ieps*@factor, base_isan*@factor, isan*@factor, 
    		   importe_total*@factor, 
			   @referencia, @aplicacion_id,
               ieps_num_reporte,			
               ieps_categoria_concepto,		
               ieps_exento,					
               ieps_envase_reutilizable,	
               ieps_retencion,				
               ieps_cantidad,				
               ieps_unidad,					
               ieps_cantidad2,				
               ieps_unidad2,
               --REQ16520
               concepto_clave,
               --REQ16748
               concepto_es_importacion,
               --BUG20353
               concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva,
               --BUG22460
               fecha,
               --BUG22759
               @EsRedocumentacion,
               --BUG22833
               BaseIVAImportacion*@factor, 
		       /*BUG23552*/
  		       ieps_iva*@factor,
  		       origen_vista,
               --BUG24733
               ISNULL(PorcentajeDeducible, 100)
		    FROM documentos
		   WHERE empresa = @empresa AND folio = @folio AND origen_tipo <> 'calc'
  		     --BUG16688
		     --AND origen_modulo = @origen_modulo
	       SELECT @conteo_documentos = @conteo_documentos + @@ROWCOUNT
          END
        END
      END
    END
    --BUG16688
	FETCH NEXT FROM cr_aplicaciones INTO @aplicacion_id, @tipo_aplicacion, @folio, @referencia, @importe, @entidad_clave, @entidad_nombre, @entidad_rfc, @entidad_id_fiscal, @entidad_tipo_tercero, @entidad_tipo_operacion, @entidad_pais, @entidad_nacionalidad, @origen_modulo
  END 
  CLOSE cr_aplicaciones
  DEALLOCATE cr_aplicaciones
  RETURN 
END					
GO

/*********** sp_layout_afectar_exentus ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_afectar_exentus') and type = 'P') drop procedure dbo.sp_layout_afectar_exentus
GO
CREATE PROCEDURE sp_layout_afectar_exentus
					@log_id						int,
					@empresa					varchar(5),
					@ejercicio					smallint,
					@periodo					smallint,
					@tipo						varchar(50),
					@conteo_datosietu			int			OUTPUT, 
					@conteo_ximpiva				int			OUTPUT,
					@conteo_cuentascontables	int			OUTPUT, 
					@conteo_saldosini			int			OUTPUT, 
					@conteo_movcontables		int			OUTPUT,
					--BUG22460
					@FechaD						datetime	= NULL,
					@FechaA						datetime	= NULL
WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @dia					 smallint,
    @tipo_aplicacion		 varchar(50), 
    @emisor					 varchar(50), 
    @folio					 varchar(50), 
    @referencia				 varchar(50), 
    @importe				 float, 
    @cuenta_bancaria		 varchar(50),
    @fecha					 datetime,
    @factor					 float,
    @importe_total			 float,
    @entidad_clave           varchar(20),
    @entidad_nombre          varchar(150),
    @entidad_rfc             varchar(15),
    @entidad_id_fiscal       varchar(50),
    @entidad_tipo_tercero    varchar(50),
    @entidad_tipo_operacion  varchar(50),
    @entidad_pais            varchar(20),
    @entidad_nacionalidad    varchar(50),

    --BUG16247
    @aplica_ieps		varchar(2),
    @aplica_ietu		varchar(2),
    @aplica_iva		    varchar(2),
    
    --BUG16688
    @origen_modulo		varchar(50),
    @NoModulos			int,
    --BUG18767
    @tipo_documento		varchar(50),
    @Base				varchar(255),
    --BUG24882
    @origen_vista		varchar(255)
    
   SELECT @Base = db_name()
	   
   IF @tipo IN ('todo', 'flujo')
   BEGIN
	  DECLARE cr_flujo CURSOR LOCAL STATIC FOR
	   --BUG16247 BUG16688 --BUG18767 BUG22460 BUG24882
	   SELECT a.dia, LOWER(a.tipo_aplicacion), a.folio, a.referencia, ISNULL(a.importe, 0.0), a.cuenta_bancaria, lae.entidad_clave, lae.entidad_nombre, lae.entidad_rfc, lae.entidad_id_fiscal, lae.entidad_tipo_tercero, lae.entidad_tipo_operacion, lae.entidad_pais, lae.entidad_nacionalidad,
	          a.aplica_ieps, a.aplica_ietu, a.aplica_iva, a.origen_modulo, ISNULL(RTRIM(a.tipo_documento), ''), a.fecha, a.origen_vista
		 FROM aplicaciones a
         LEFT OUTER JOIN layout_aplicacion_entidad lae ON lae.folio = a.folio AND lae.referencia = a.referencia AND lae.empresa = a.empresa     		 
		WHERE a.empresa = @empresa 
          AND ejercicio = ISNULL(@ejercicio, Ejercicio) 
          AND periodo   = ISNULL(@periodo, periodo)
          AND fecha     >= ISNULL(@FechaD, fecha) 
          AND fecha     <= ISNULL(@FechaA, fecha)                   
		  AND a.tipo_aplicacion IN ('cobro', 'pago')
	   ORDER BY dia
	  OPEN cr_flujo
	  --BUG16247 BUG16688 --BUG18767 BUG22460 BUG24882
	  FETCH NEXT FROM cr_flujo INTO @dia, @tipo_aplicacion, @folio, @referencia, @importe, @cuenta_bancaria, @entidad_clave, @entidad_nombre, @entidad_rfc, @entidad_id_fiscal, @entidad_tipo_tercero, @entidad_tipo_operacion, @entidad_pais, @entidad_nacionalidad, @aplica_ieps, @aplica_ietu, @aplica_iva, @origen_modulo, @tipo_documento, @fecha, @origen_vista
	  WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0 
	  BEGIN
		IF @@FETCH_STATUS <> -2 
		BEGIN		
		  SELECT @factor = 0.0, @importe_total = 0.0,
				 @emisor = dbo.fn_emisor(@tipo_aplicacion),
				 --BUG22460
				 --@fecha = dbo.fn_fecha(@ejercicio, @periodo, @dia),
				 --BUG16688
				 @NoModulos = 0

          --BUG22460
          IF @Ejercicio IS NOT NULL AND @Periodo IS NOT NULL
            SELECT @fecha = dbo.fn_fecha(@ejercicio, @periodo, @dia)

          IF @Ejercicio IS NULL
            SELECT @Ejercicio = YEAR(@fecha)
          IF @Periodo IS NULL
            SELECT @Periodo  = MONTH(@fecha)

          --BUG18696 BUG22596
          SELECT @NoModulos = COUNT(DISTINCT origen_modulo) FROM documentos WHERE folio = @referencia AND origen_modulo IN('GAS', 'CXC', 'CXP', 'VTAS') AND Empresa = @empresa AND ISNULL(origen_tipo, '') <> 'calc' AND ISNULL(EsRedocumentacion, 0) = 0

		  IF @NoModulos > 1
		    --BUG22833
		    SELECT @importe_total = SUM(CASE ISNULL(BaseIVAImportacion, 0) WHEN -1 THEN iva ELSE importe_total - ISNULL(BaseIVAImportacion, 0) END)
  			  FROM documentos 
		     WHERE empresa = @empresa AND referencia = @referencia
		       AND origen_modulo = @origen_modulo
		       AND ISNULL(origen_tipo, '') <> 'calc'
		       AND ISNULL(EsRedocumentacion, 0) = 0
		  ELSE
		    --BUG22833
		    SELECT @importe_total = SUM(CASE ISNULL(BaseIVAImportacion, 0) WHEN -1 THEN iva ELSE importe_total - ISNULL(BaseIVAImportacion, 0) END)
  			  FROM documentos 
		     WHERE empresa = @empresa AND referencia = @referencia
  		       AND ISNULL(origen_tipo, '') <> 'calc'
  		       AND ISNULL(EsRedocumentacion, 0) = 0

          --BUG24882
          IF @origen_vista <> 'MFAVentaContadoPagoCalc'
		    SELECT @factor = @importe / NULLIF(@importe_total, 0.0)
		  ELSE
		    SELECT @factor = 1

		  IF NULLIF(@factor, 0.0) IS NOT NULL
		  BEGIN
            IF @NoModulos > 1
            BEGIN
		      --BUG16247  
		      IF @aplica_ietu = 'Si'
		      BEGIN
  			    INSERT INTO DatosIetu (
					   empresa, movimiento, 
					   nocliente, 
					   nombre, 
					   concepto, referencia,
					   fecha,  ejercicio,	periodoasi, 
					   tipo, cuenta,
					   ietu, retencion, retencion2, impuestos,
					   --REQ16520
					   SubTipoIetu
					   )
			    SELECT @empresa, @referencia, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
			           CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END,			         
					   concepto, @folio, 
					   @fecha, @ejercicio, @periodo, 
					   ISNULL(dbo.fn_tipo_datosietu(@tipo_aplicacion), 1), @cuenta_bancaria,
					   --BUG24733
					   ISNULL(SUM(importe)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_isr)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_iva)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(base_iva*(iva_tasa/100.0)*@factor),0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   --REQ16520
					   dbo.fn_subtipo_datosietu(concepto_clave, @tipo_aplicacion)
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
			        -- BUG16688
		           AND origen_modulo = @origen_modulo
		           --BUG16700
		           AND referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')		           
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'
		           AND ISNULL(EsRedocumentacion, 0) = 0
		           --BUG20353
		           AND ISNULL(concepto_aplica_ietu, '') = 'Si'
			     GROUP BY 
                   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END,			         			   
			       concepto, 
			       iva_tasa, 
			       --REQ16520
			       concepto_clave,
			       origen_modulo, 
			       ISNULL(@tipo_documento, tipo_documento),
			       --BUG24733
			       PorcentajeDeducible
			    SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT

                IF @referencia IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')
                BEGIN		           			     
    			  INSERT INTO DatosIetu(
    			              empresa, movimiento, nocliente, nombre, concepto, referencia, fecha, ejercicio, periodoasi, tipo, cuenta,ietu, retencion, retencion2, impuestos, SubTipoIetu)
                      SELECT @empresa, @referencia, ISNULL(@entidad_clave,''), ISNULL(@entidad_nombre,''), @referencia, @folio, @fecha, @ejercicio, @periodo, ISNULL(dbo.fn_tipo_datosietu(@tipo_aplicacion), 1), @cuenta_bancaria, ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), dbo.fn_subtipo_datosietu(@referencia, @tipo_aplicacion)
			      SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT		           
                END
		      END
		      --BUG16247  
		      IF @aplica_iva = 'Si'
		      BEGIN		    
  			    INSERT INTO ximpiva (
					   id, empresa, nombre, mov, 
					   tipoiva, tipoopera, tasa, origen,
					   rfc, idfiscal, tipoter, tipoope,
					   cvepais, naciona, cheque, 
					   fecha, ejercicio, periodo,
					   importe, iva, reten2,
         			   --BUG22156
         			   EsActivoFijo, TipoActivo, TipoActividad		   
					   )
			    SELECT @referencia, @empresa, 
			           CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 
			           concepto, 
			           --BUG16705 REQ16748 BUG18752
					   ISNULL(dbo.fn_tipoiva(@tipo_aplicacion),0), dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento), ISNULL(iva_tasa/100.0,0), 2,		
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE ISNULL(@entidad_id_fiscal,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoter(entidad_tipo_tercero) ELSE dbo.fn_tipoter(ISNULL(@entidad_tipo_tercero,'')) END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoope(entidad_tipo_operacion) ELSE dbo.fn_tipoope(ISNULL(@entidad_tipo_operacion,'')) END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE ISNULL(@entidad_pais,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE ISNULL(@entidad_nacionalidad,'') END, 
					   @folio, 
					   @fecha, @ejercicio, @periodo,
					   --BUG18752 BUG24733
					   CASE dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento) 
					     WHEN 1  THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 9  THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 10 THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     ELSE ISNULL((SUM(importe)+ CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento) *(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					   END,
					   --BUG24040
					   CASE dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento) 					   
					     WHEN 1  THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 9  THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 10 THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     --BUG23552
					     ELSE ISNULL(SUM((importe + CASE ISNULL(ieps_iva, 0) WHEN 0 THEN 0 ELSE ISNULL(ieps, 0) END)*(iva_tasa/100.0))*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					   END,
					   ISNULL(SUM(retencion_iva)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   --BUG22156
         			   ISNULL(EsActivoFijo, 0), TipoActivo, ISNULL(TipoActividad, 'gravado')
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
			        -- BUG16688
		           AND origen_modulo = @origen_modulo			   
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'
		           AND ISNULL(EsRedocumentacion, 0) = 0		           
		           --BUG20353
		           AND ISNULL(concepto_aplica_iva, '') = 'Si'
		           --BUG25072
		           AND referencia NOT IN ('Redondeo')
			     GROUP BY 
  			       origen_tipo, 
			       origen_modulo, 
			       origen_id, 
                   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 			     
			       concepto, iva_excento, 
			       iva_tasa, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE ISNULL(@entidad_id_fiscal,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoter(entidad_tipo_tercero) ELSE dbo.fn_tipoter(ISNULL(@entidad_tipo_tercero,'')) END, 
				   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoope(entidad_tipo_operacion) ELSE dbo.fn_tipoope(ISNULL(@entidad_tipo_operacion,'')) END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE ISNULL(@entidad_pais,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE ISNULL(@entidad_nacionalidad,'') END,
			       --BUG16705
			       entidad_tipo_tercero,
			       --REQ16748
			       concepto_es_importacion, 
			       ISNULL(@tipo_documento, tipo_documento),
			       --BUG22156
         		   EsActivoFijo, TipoActivo, TipoActividad,
         		   --BUG24733
         		   PorcentajeDeducible
			    SELECT @conteo_ximpiva = @conteo_ximpiva + @@ROWCOUNT
		      END
              --BUG16247
              IF @aplica_ieps = 'Si'
		      BEGIN			  
  			    INSERT INTO DatosIeps (
					   empresa, documento, documento_id, tipo_movimiento, 
                       nocliente, 
                       rfc, 
                       nombre, 
					   concepto, referencia,
					   fecha,  ejercicio,	periodo, 
					   importe, 
					   retencion_ieps,
					   tasa_ieps,
					   importe_ieps,
					   num_reporte,
					   categoria_concepto,					 
					   es_exento,
	                   es_envase_reutilizable,	
	                   cantidad,
	                   unidad,
	                   cantidad1,
	                   unidad1					 
					   )				 
			    SELECT @empresa, folio, origen_id, subtipo_documento, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 
					   concepto, @folio, 
					   @fecha, @ejercicio, @periodo, 
					   --BUG24733
					   ISNULL(SUM(importe)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_isr)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   ieps_tasa,
					   ISNULL(SUM(ieps)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   ieps_num_reporte,
                       ieps_categoria_concepto,
                       ieps_exento,					
                       ieps_envase_reutilizable,	
                       SUM(ieps_cantidad),
                       ieps_unidad,					
                       SUM(ieps_cantidad2),				
                       ieps_unidad2									 
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
			        -- BUG16688
		           AND origen_modulo = @origen_modulo			   
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'		           
		           AND ISNULL(EsRedocumentacion, 0) = 0		           
		           --BUG20353
		           AND ISNULL(concepto_aplica_ieps, '') = 'Si'
		           --BUG25072
		           AND referencia NOT IN ('Redondeo')
			     GROUP BY folio, origen_id, subtipo_documento, entidad_clave, entidad_rfc, entidad_nombre, concepto, ieps_tasa, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_unidad, ieps_unidad2, origen_modulo, ISNULL(@tipo_documento, tipo_documento),
			              --BUG24733
			              PorcentajeDeducible
			    SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT
		      END			  
		    END
            ELSE IF @NoModulos <= 1
            BEGIN
		      --BUG16247  
		      IF @aplica_ietu = 'Si'
		      BEGIN
  			    INSERT INTO DatosIetu (
					   empresa, movimiento, 
					   nocliente, 
					   nombre, 
					   concepto, referencia,
					   fecha,  ejercicio,	periodoasi, 
					   tipo, cuenta,
					   ietu, retencion, retencion2, impuestos,
					   --REQ16520
					   SubTipoIetu
					   )
			    SELECT @empresa, @referencia, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
			           CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END,			         
					   concepto, @folio, 
					   @fecha, @ejercicio, @periodo, 
					   ISNULL(dbo.fn_tipo_datosietu(@tipo_aplicacion), 1), @cuenta_bancaria,
					   --BUG24733
					   ISNULL(SUM(importe)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_isr)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_iva)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(base_iva*(iva_tasa/100.0)*@factor),0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   --REQ16520
					   dbo.fn_subtipo_datosietu(concepto_clave, @tipo_aplicacion)
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
			       --BUG16700
		           AND referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')		           			     
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'		           
		           AND ISNULL(EsRedocumentacion, 0) = 0		           
		           --BUG20353
		           AND ISNULL(concepto_aplica_ietu, '') = 'Si'
		           --BUG25072
		           AND referencia NOT IN ('Redondeo')
			     GROUP BY 
                   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END,			         			   
			       concepto, 
			       iva_tasa, 
			       --REQ16520
			       concepto_clave,
			       origen_modulo, 
			       ISNULL(@tipo_documento, tipo_documento),
			       --BUG24733
			       PorcentajeDeducible
			    SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT

                IF @referencia IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')
                BEGIN		           			     
    			  INSERT INTO DatosIetu(
    			              empresa, movimiento, nocliente, nombre, concepto, referencia, fecha, ejercicio, periodoasi, tipo, cuenta,ietu, retencion, retencion2, impuestos, SubTipoIetu)
                      SELECT @empresa, @referencia, ISNULL(@entidad_clave,''), ISNULL(@entidad_nombre,''), @referencia, @folio, @fecha, @ejercicio, @periodo, ISNULL(dbo.fn_tipo_datosietu(@tipo_aplicacion), 1), @cuenta_bancaria, ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), ISNULL(@importe*@factor,0), dbo.fn_subtipo_datosietu(@referencia, @tipo_aplicacion)
			      SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT		           
                END
		      END
		      --BUG16247  
		      IF @aplica_iva = 'Si'
		      BEGIN	
  			    INSERT INTO ximpiva (
					   id, empresa, nombre, mov, 
					   tipoiva, tipoopera, tasa, origen,
					   rfc, idfiscal, tipoter, tipoope,
					   cvepais, naciona, cheque, 
					   fecha, ejercicio, periodo,
					   importe, iva, reten2,
					   --BUG22156
         			   EsActivoFijo, TipoActivo, TipoActividad)
			    SELECT @referencia, @empresa, 
			           CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 
			           concepto, 
			           --BUG16705 REQ16748 BUG18752
					   ISNULL(dbo.fn_tipoiva(@tipo_aplicacion),0), dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento), ISNULL(iva_tasa/100.0,0), 2,		
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE ISNULL(@entidad_id_fiscal,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoter(entidad_tipo_tercero) ELSE dbo.fn_tipoter(ISNULL(@entidad_tipo_tercero,'')) END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoope(entidad_tipo_operacion) ELSE dbo.fn_tipoope(ISNULL(@entidad_tipo_operacion,'')) END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE ISNULL(@entidad_pais,'') END, 
					   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE ISNULL(@entidad_nacionalidad,'') END, 
					   @folio, 
					   @fecha, @ejercicio, @periodo,
					   --BUG18752
					   CASE dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento) 
					     WHEN 1  THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 9  THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 10 THEN ISNULL((SUM(base_iva) + CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     ELSE ISNULL((SUM(importe)+ CASE ISNULL(SUM(ieps_iva), 0) WHEN 0 THEN 0 ELSE ISNULL(SUM(ieps), 0) END)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					   END,
					   --BUG24040
					   CASE dbo.fn_tipoopera(origen_modulo, iva_excento, iva_tasa, entidad_tipo_tercero, concepto_es_importacion, @tipo_documento) 					   
					     WHEN 1  THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 9  THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     WHEN 10 THEN ISNULL(SUM(iva), 0)*@factor*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					     --BUG23552
					     ELSE ISNULL(SUM((importe+CASE ISNULL(ieps_iva, 0) WHEN 0 THEN 0 ELSE ISNULL(ieps, 0) END)*(iva_tasa/100.0))*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0)
					   END,					   
					   --BUG23552					   
					   ISNULL(SUM(retencion_iva)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   --BUG22156
         			   ISNULL(EsActivoFijo, 0), TipoActivo, ISNULL(TipoActividad, 'gravado')
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'
		           AND ISNULL(EsRedocumentacion, 0) = 0
		           --BUG20353
		           AND ISNULL(concepto_aplica_iva, '') = 'Si'
		           --BUG25072
		           AND referencia NOT IN ('Redondeo')
			     GROUP BY 
  			       origen_tipo, 
			       origen_modulo, 
			       origen_id, 
                   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 			     
			       concepto, iva_excento, 
			       iva_tasa, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_id_fiscal ELSE ISNULL(@entidad_id_fiscal,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoter(entidad_tipo_tercero) ELSE dbo.fn_tipoter(ISNULL(@entidad_tipo_tercero,'')) END, 
				   CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN dbo.fn_tipoope(entidad_tipo_operacion) ELSE dbo.fn_tipoope(ISNULL(@entidad_tipo_operacion,'')) END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_pais ELSE ISNULL(@entidad_pais,'') END, 
			       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nacionalidad ELSE ISNULL(@entidad_nacionalidad,'') END,
			       --BUG16705
			       entidad_tipo_tercero,
			       --REQ16748
			       concepto_es_importacion, 
			       ISNULL(@tipo_documento, tipo_documento),
			       --BUG22156
         		   EsActivoFijo, TipoActivo, TipoActividad,
         		   --BUG24733
         		   PorcentajeDeducible
			    SELECT @conteo_ximpiva = @conteo_ximpiva + @@ROWCOUNT
		      END
              --BUG16247
              IF @aplica_ieps = 'Si'
		      BEGIN			  
  			    INSERT INTO DatosIeps (
					   empresa, documento, documento_id, tipo_movimiento, 
                       nocliente, 
                       rfc, 
                       nombre, 
					   concepto, referencia,
					   fecha,  ejercicio,	periodo, 
					   importe, 
					   retencion_ieps,
					   tasa_ieps,
					   importe_ieps,
					   num_reporte,
					   categoria_concepto,					 
					   es_exento,
	                   es_envase_reutilizable,	
	                   cantidad,
	                   unidad,
	                   cantidad1,
	                   unidad1					 
					   )				 
			    SELECT @empresa, folio, origen_id, subtipo_documento, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_clave ELSE ISNULL(@entidad_clave,'') END, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_rfc ELSE ISNULL(@entidad_rfc,'') END, 
                       CASE WHEN @referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes') THEN entidad_nombre ELSE ISNULL(@entidad_nombre,'') END, 
					   concepto, @folio, 
					   @fecha, @ejercicio, @periodo, 
					   ISNULL(SUM(importe)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0), 
					   ISNULL(SUM(retencion_isr)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   ieps_tasa,
					   ISNULL(SUM(ieps)*@factor,0)*dbo.fn_documento_factor(origen_modulo, @tipo_documento)*(ISNULL(PorcentajeDeducible, 100.0)/100.0),
					   ieps_num_reporte,
                       ieps_categoria_concepto,
                       ieps_exento,					
                       ieps_envase_reutilizable,	
                       SUM(ieps_cantidad),
                       ieps_unidad,					
                       SUM(ieps_cantidad2),
                       ieps_unidad2									 
				  FROM documentos
			     WHERE empresa = @empresa AND referencia = @referencia and lower(acumulable_deducible) = 'si' --BUG14400
		           --BUG16711
		           AND ISNULL(origen_modulo, '') <> 'NOM'
		           --BUGCALC
		           AND ISNULL(origen_tipo, '') <> 'calc'		           
		           AND ISNULL(EsRedocumentacion, 0) = 0		           
		           --BUG20353
		           AND ISNULL(concepto_aplica_ieps, '') = 'Si'
		           --BUG25072
		           AND referencia NOT IN ('Redondeo')
			     GROUP BY folio, origen_id, subtipo_documento, entidad_clave, entidad_rfc, entidad_nombre, concepto, ieps_tasa, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_unidad, ieps_unidad2, origen_modulo, ISNULL(@tipo_documento, tipo_documento),
			              --BUG24733
			              PorcentajeDeducible
			    SELECT @conteo_datosietu = @conteo_datosietu + @@ROWCOUNT
		      END
		    END		    
		  END
		END			      
		-- BUG16688 BUG22460 BUG24882
		FETCH NEXT FROM cr_flujo INTO @dia, @tipo_aplicacion, @folio, @referencia, @importe, @cuenta_bancaria, @entidad_clave, @entidad_nombre, @entidad_rfc, @entidad_id_fiscal, @entidad_tipo_tercero, @entidad_tipo_operacion, @entidad_pais, @entidad_nacionalidad, @aplica_ieps, @aplica_ietu, @aplica_iva, @origen_modulo, @tipo_documento, @fecha, @origen_vista
	  END 
	  CLOSE cr_flujo
	  DEALLOCATE cr_flujo
	END
  
  EXEC spShrink_log @Base
  
  IF @tipo IN ('todo', 'contabilidad')
  BEGIN
    INSERT INTO CuentasContables(
           CuentaContable,  CuentaControl,  Nivel, Descripcion, 
		   Clase,        
		   Tipo,        
		   Moneda)
    SELECT cuenta_contable, cuenta_control, nivel, descripcion, 
		   dbo.fn_clase_cuenta(clase_cuenta), 
		   dbo.fn_tipo_cuenta(tipo_cuenta), 
		   --BUG20350
		   MFAMon.Codigo
      FROM cuentas
      LEFT OUTER JOIN MFAMon ON cuentas.moneda = MFAMon.Moneda
     WHERE empresa = @empresa AND ejercicio = @ejercicio
     SELECT @conteo_cuentascontables = @conteo_cuentascontables + @@ROWCOUNT

    INSERT INTO SaldosIni (
           Empresa, CuentaContable,  anio,      saldoinicial) 
    SELECT empresa, cuenta_contable, ejercicio, SUM(saldo_inicial)
      FROM cuentas
     WHERE empresa = @empresa AND ejercicio = @ejercicio
     GROUP BY empresa, cuenta_contable, ejercicio
     SELECT @conteo_saldosini = @conteo_saldosini + @@ROWCOUNT
 
    --BUG22460
    INSERT INTO MovContables (
           Empresa, CuentaContable,  anio,      mes,     cargo,       abono)
    SELECT empresa, cuenta_contable, ejercicio, periodo, SUM(cargos), SUM(abonos)
      FROM polizas
     WHERE empresa = @empresa 
       AND ejercicio = ISNULL(@ejercicio, YEAR(@FechaA))
       AND periodo   = ISNULL(@periodo, MONTH(@FechaA))
     GROUP BY empresa, cuenta_contable, ejercicio, periodo
     
    EXEC spShrink_log @Base
  END
  
  RETURN
END
GO

/*********** sp_layout_log_in ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_log_in') and type = 'P') drop procedure dbo.sp_layout_log_in
GO
CREATE PROCEDURE sp_layout_log_in
					@usuario	varchar(20),
					@accion		varchar(50),
					@estatus	varchar(50),
					--BUG22719
					@Empresa	varchar(5),
					@log_id		int		OUTPUT
WITH ENCRYPTION
AS BEGIN
  --REQ16752 BUG22719
  INSERT INTO layout_log 
	     (usuario,  accion,  estatus,  Empresa)
  SELECT @usuario, @accion, @estatus, @Empresa
  
  SELECT @log_id = SCOPE_IDENTITY()
END
GO					

/*********** sp_layout_log_out ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_log_out') and type = 'P') drop procedure dbo.sp_layout_log_out
GO
CREATE PROCEDURE sp_layout_log_out
					@log_id				int,
					@conteo				int,
					@error				int,
					@error_mensaje		varchar(255)
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @estatus	varchar(50)
  
  --BUG22575
  IF NULLIF(@error, 0) IS NOT NULL OR @error_mensaje = 'Referencias Invalidas'
    SELECT @estatus = 'error' 
  ELSE 
    SELECT @estatus = 'concluido'
    
  UPDATE layout_log
     SET estatus = @estatus,
         conteo = @conteo,
         error = @error,
         error_mensaje = @error_mensaje,
         fin = GETDATE()
   WHERE log_id = @log_id
END
GO					

/*********** sp_layout_procesar ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_procesar') and type = 'P') drop procedure dbo.sp_layout_procesar
GO
CREATE PROCEDURE sp_layout_procesar
					@usuario	varchar(20),
					@empresa	varchar(5),
					@ejercicio	smallint,
					@periodo	smallint,
					@tipo		varchar(50)	= 'todo',
					@FechaD		datetime	= NULL,
					@FechaA		datetime	= NULL,
					--BUG22558
					@IFRS				bit			= 0,
					@ValidarReferencias bit			= 1
WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @log_id						int,
    @error						int,
    @error_mensaje				varchar(255),
    @conteo						int,
	@conteo_documentos			int,
	@conteo_aplcaciones			int,
	@conteo_datosietu			int,
	@conteo_ximpiva				int,
	@conteo_cuentascontables	int,
	@conteo_saldosini			int,
	@conteo_movcontables		int,
	@Base						varchar(255)

  SELECT @error						= NULL, 
	     @error_mensaje				= NULL,
	     @conteo_documentos			= 0,
		 @conteo_aplcaciones		= 0,
		 @conteo_datosietu			= 0,
		 @conteo_ximpiva			= 0,
		 @conteo_cuentascontables	= 0,
		 @conteo_saldosini			= 0,
		 @conteo_movcontables		= 0,
		 @tipo						= LOWER(@tipo),
		 @Base						= db_name()
		 
  --BUG22719
  EXEC sp_layout_log_in @usuario, 'procesar', 'procesando', @empresa, @log_id OUTPUT
  
  --BUG22460
  EXEC sp_layout_init @log_id, @empresa, @ejercicio, @periodo, @tipo, @FechaD, @FechaA
  
  EXEC spShrink_log @Base
  
  IF @tipo IN ('todo', 'flujo') --BUG14400
  BEGIN
    --BUG22460 BUG22558 BUG22575
    IF @IFRS = 0
	   EXEC sp_layout_referencias_ok @log_id, @empresa, @ejercicio, @periodo, @error OUTPUT, @error_mensaje OUTPUT, @FechaD, @FechaA, @ValidarReferencias
  END
  	
  IF @error IS NULL
  BEGIN
    IF @tipo IN ('todo', 'flujo') --BUG14400
    BEGIN
      --BUG22460
      EXEC sp_layout_aplicaciones @log_id, @empresa, @ejercicio, @periodo, @conteo_documentos OUTPUT, @FechaD, @FechaA
      EXEC spShrink_log @Base
    END  
    
    --BUG22460
    EXEC sp_layout_afectar_exentus @log_id, @empresa, @ejercicio, @periodo, @tipo,
								   @conteo_datosietu OUTPUT, @conteo_ximpiva OUTPUT,
								   @conteo_cuentascontables OUTPUT, @conteo_saldosini OUTPUT, @conteo_movcontables OUTPUT, @FechaD, @FechaA
    SELECT @conteo = @conteo_documentos + @conteo_aplcaciones + @conteo_datosietu + @conteo_ximpiva
  END
  EXEC sp_layout_log_out @log_id, @conteo, @error, @error_mensaje
  RETURN @log_id
END
GO

/*********** sp_layout_importar_documentos ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_importar_documentos') and type = 'P') drop procedure dbo.sp_layout_importar_documentos
GO
CREATE PROCEDURE sp_layout_importar_documentos
							@usuario	varchar(20),
                            --BU22575
							@Empresa	varchar(5) = NULL
WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @log_id				int,
    @error				int,
    @error_mensaje		varchar(255),
    @conteo				int, 
    @ejercicio			smallint,
    @periodo			smallint,
    @Base				varchar(255)

  SELECT @error			= NULL, 
		 @error_mensaje = NULL,
		 @conteo		= 0
  SELECT @usuario = UPPER(@usuario)
  
  SELECT @Base = db_name()

  --REQ16752 --BUG22719
  EXEC sp_layout_log_in @usuario, 'importar documentos', 'importando', @Empresa, @log_id OUTPUT
 
 -- Se cambia por performance
 -- DECLARE cr_layout CURSOR LOCAL FOR
 --  SELECT empresa, ejercicio, periodo
 --    FROM layout_documentos
 --   GROUP BY empresa, ejercicio, periodo
 --   ORDER BY empresa, ejercicio, periodo
 -- OPEN cr_layout
 -- FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
 -- WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0
 -- BEGIN
 --   IF @@FETCH_STATUS <> -2 
 --   BEGIN  
 --     DELETE 
 --       FROM documentos
 --      WHERE empresa = @empresa AND ejercicio = @ejercicio AND periodo = @periodo
 --   END
	--FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
 -- END 
 -- CLOSE cr_layout
 -- DEALLOCATE cr_layout

  --BUG22460
  -- SELECT empresa, ejercicio, periodo
  --   INTO #EjercicioPeriodo
  --   FROM layout_documentos
  --  GROUP BY empresa, ejercicio, periodo
  --  ORDER BY empresa, ejercicio, periodo    

  --DELETE d
  --  FROM documentos d
  --  JOIN #EjercicioPeriodo e ON d.empresa = e.empresa AND d.ejercicio = e.ejercicio AND d.periodo = e.periodo

   --BU22575
   SELECT empresa, fecha, origen_vista
     INTO #fecha
     FROM layout_documentos
    WHERE Empresa = ISNULL(@Empresa, Empresa)
    GROUP BY empresa, fecha, origen_vista
    --ORDER BY empresa, fecha, origen_vista

  DELETE a
    FROM documentos a
    JOIN #fecha e ON a.empresa = e.empresa AND a.fecha = e.fecha AND a.origen_vista = e.origen_vista
  EXEC spShrink_Log @Base
  
  INSERT INTO documentos (
		 log_id, 
		 origen_tipo, origen_modulo, origen_id,
		 empresa, emisor, tipo_documento, folio, 
		 ejercicio, periodo, dia, 
		 entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, entidad_cuenta_contable,	
		 concepto, concepto_cuenta_contable, acumulable_deducible,
		 importe, retencion_isr, retencion_iva, 
		 base_iva, iva_excento, iva_tasa, iva, 
		 base_ieps, ieps_tasa, ieps, base_isan, isan, 
		 base_otros_impuestos, otros_impuestos_tasa, otros_impuestos, otros_impuestos_tipo, otros_impuestos_cuenta_contable,
		 importe_total, 
		 referencia,
		 ieps_num_reporte,
		 ieps_categoria_concepto,
		 ieps_exento,
		 ieps_envase_reutilizable,
		 ieps_retencion,
		 ieps_cantidad,
		 ieps_unidad,
		 ieps_cantidad2,
		 ieps_unidad2,
		 --BUG16117
		 subtipo_documento,
         --REQ16520
         concepto_clave,
         --REQ16748
         concepto_es_importacion,
         --BUG20353
         concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva,
         --BUG22156
         EsActivoFijo, TipoActivo, TipoActividad,
         --BUG22460
         fecha,
         --BUG22833
         BaseIVAImportacion,
         --BUG23552
         ieps_iva,
         origen_vista,
         --BUG24733
         PorcentajeDeducible
         )
  SELECT @log_id, 
		 origen_tipo, origen_modulo, origen_id,
		 UPPER(empresa), LOWER(emisor), LOWER(tipo_documento), UPPER(folio), 
		 ejercicio, periodo, dia, 
	     UPPER(entidad_clave), entidad_nombre, UPPER(entidad_rfc), UPPER(entidad_id_fiscal), LOWER(entidad_tipo_tercero), LOWER(entidad_tipo_operacion), UPPER(entidad_pais), entidad_nacionalidad,	entidad_cuenta_contable,
	     concepto, concepto_cuenta_contable, acumulable_deducible,
	     importe, retencion_isr, retencion_iva, 
	     base_iva, ISNULL(iva_excento, 0), iva_tasa, iva, 
	     base_ieps, ieps_tasa, ieps, base_isan, isan, 
	     base_otros_impuestos, otros_impuestos_tasa, otros_impuestos, otros_impuestos_tipo, otros_impuestos_cuenta_contable,
	     importe_total, 
	     UPPER(folio),
		 ieps_num_reporte,
		 ieps_categoria_concepto,
		 ieps_exento,
		 ieps_envase_reutilizable,
		 ieps_retencion,
		 ieps_cantidad,
		 ieps_unidad,
		 ieps_cantidad2,
		 ieps_unidad2,
		 --BUG16117
		 subtipo_documento,
         --REQ16520
         concepto_clave,
         --REQ16748
         concepto_es_importacion,
         --BUG20353
         concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva,
         --BUG22156
         EsActivoFijo, TipoActivo, TipoActividad,
         --BU22460
         fecha,
         --BUG22833
         BaseIVAImportacion,
         --BUG23552
         ieps_iva,
         origen_vista,
         --BUG24733
         ISNULL(PorcentajeDeducible, 100)
    FROM layout_documentos
	--BUG18077
   WHERE EsIFRS = 0  
     --BU22575  
     AND Empresa = ISNULL(@Empresa, Empresa)
  SELECT @conteo = @conteo + @@ROWCOUNT 

  EXEC sp_layout_log_out @log_id, @conteo, @error, @error_mensaje
  RETURN
END
GO

/*********** sp_layout_importar_aplicaciones ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_importar_aplicaciones') and type = 'P') drop procedure dbo.sp_layout_importar_aplicaciones
GO
CREATE PROCEDURE sp_layout_importar_aplicaciones
							@usuario	varchar(20),
                            --BU22575
							@Empresa	varchar(5) = NULL
WITH ENCRYPTION
AS BEGIN  
  DECLARE @Base varchar(255)
  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @log_id				int,
    @error				int,
    @error_mensaje		varchar(255),
    @conteo				int,
    @ejercicio			smallint,
    @periodo			smallint
  
  SELECT @usuario = UPPER(@usuario)
  SELECT @error			= NULL, 
		 @error_mensaje = NULL,
		 @conteo		= 0

  SELECT @Base = db_name()
  
  --BUG22719
  EXEC sp_layout_log_in @usuario, 'importar aplicaciones', 'importando', @Empresa, @log_id OUTPUT
  
  --Se cambia por performance
  --DECLARE cr_layout CURSOR LOCAL FOR
  -- SELECT empresa, ejercicio, periodo
  --   FROM layout_aplicaciones
  --  GROUP BY empresa, ejercicio, periodo
  --  ORDER BY empresa, ejercicio, periodo
  --OPEN cr_layout
  --FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
  --WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0
  --BEGIN
  --  IF @@FETCH_STATUS <> -2 
  --  BEGIN  
  --    DELETE 
  --      FROM aplicaciones
  --     WHERE empresa = @empresa AND ejercicio = @ejercicio AND periodo = @periodo
  --  END
  -- FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
  --END 
  --CLOSE cr_layout
  --DEALLOCATE cr_layout

  --BUG22460
  -- SELECT empresa, ejercicio, periodo
  --   INTO #EjercicioPeriodo
  --   FROM layout_aplicaciones
  --  GROUP BY empresa, ejercicio, periodo
  --  ORDER BY empresa, ejercicio, periodo    

  --DELETE a
  --  FROM aplicaciones a
  --  JOIN #EjercicioPeriodo e ON a.empresa = e.empresa AND a.ejercicio = e.ejercicio AND a.periodo = e.periodo
  
   SELECT empresa, fecha, origen_vista
     INTO #fecha
     FROM layout_aplicaciones
    --BU22575
    WHERE Empresa = ISNULL(@Empresa, Empresa)
    GROUP BY empresa, fecha, origen_vista
    --ORDER BY empresa, fecha, origen_vista

  DELETE a
    FROM aplicaciones a
    JOIN #fecha e ON a.empresa = e.empresa AND a.fecha = e.fecha AND a.origen_vista = e.origen_vista

  EXEC spShrink_Log @Base
  
  INSERT INTO aplicaciones (
		 log_id, 
		 origen_tipo, origen_modulo, origen_id,
		 empresa, tipo_aplicacion, folio, 
		 ejercicio, periodo, dia, 
		 referencia, importe, 
		 cuenta_bancaria, 
		 --BUG16247
		 aplica_ieps, aplica_ietu, aplica_iva,
		 --REQ16752
		 origen_vista,
		 --BUG18767
		 tipo_documento,
		 --BUG22460
		 fecha
		 )
  SELECT @log_id,
         origen_tipo, origen_modulo, origen_id,
		 UPPER(empresa), LOWER(tipo_aplicacion), UPPER(folio),	
		 ejercicio, periodo, dia, 
		 UPPER(referencia), importe, 
		 UPPER(cuenta_bancaria),
		 --BUG16247
		 aplica_ieps, aplica_ietu, aplica_iva,
		 --REQ16752
		 origen_vista,
		 --BUG18767
		 tipo_documento,
		 --BUG22460
		 fecha
	FROM layout_aplicaciones
	--BUG17507
   WHERE EsIFRS = 0
     --BU22575
     AND Empresa = ISNULL(@Empresa, Empresa)
   
  SELECT @conteo = @conteo + @@ROWCOUNT

  EXEC sp_layout_log_out @log_id, @conteo, @error, @error_mensaje
  RETURN
END
GO

/*********** sp_layout_importar_polizas ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_importar_polizas') and type = 'P') drop procedure dbo.sp_layout_importar_polizas
GO
CREATE PROCEDURE sp_layout_importar_polizas
							@usuario	varchar(20)
							
WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @log_id				int,
    @error				int,
    @error_mensaje		varchar(255),
    @conteo				int, 
    @empresa			varchar(5),
    @ejercicio			smallint,
    @periodo			smallint
  
  SELECT @usuario = UPPER(@usuario)
  SELECT @error			= NULL, 
		 @error_mensaje = NULL,
		 @conteo		= 0
  
  DECLARE cr_layout CURSOR LOCAL STATIC FOR
   SELECT empresa, ejercicio, periodo
     FROM layout_polizas
    GROUP BY empresa, ejercicio, periodo
    ORDER BY empresa, ejercicio, periodo
  OPEN cr_layout
  FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
  WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      --BUG22719
      EXEC sp_layout_log_in @usuario, 'importar polizas', 'importando', @Empresa, @log_id OUTPUT    
      
      --BUG22460
      DELETE 
        FROM polizas
       WHERE empresa = @empresa 
         AND ejercicio = @ejercicio
         AND periodo   = @periodo
      
      --BUG22460
      INSERT INTO polizas (
		     log_id, 
		     empresa, ejercicio, periodo, cuenta_contable, 
		     cargos, abonos, fecha)
      SELECT @log_id,
		     UPPER(empresa), ejercicio, periodo, UPPER(cuenta_contable), 
		     cargos, abonos, fecha
	    FROM layout_polizas
	   WHERE empresa = @empresa
	     AND ejercicio = @ejercicio
	     AND periodo = @periodo
	     
      SELECT @conteo = @conteo + @@ROWCOUNT
  
      EXEC sp_layout_log_out @log_id, @conteo, @error, @error_mensaje
      
    END
   FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio, @periodo
  END 
  CLOSE cr_layout
  DEALLOCATE cr_layout
	
  RETURN
END
GO

/*********** sp_layout_importar_cuentas ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_importar_cuentas') and type = 'P') drop procedure dbo.sp_layout_importar_cuentas
GO
CREATE PROCEDURE sp_layout_importar_cuentas
							@usuario	varchar(20)
WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @log_id				int,
    @error				int,
    @error_mensaje		varchar(255),
    @conteo				int, 
    @empresa			varchar(5),
    @ejercicio			smallint
  
  SELECT @usuario = UPPER(@usuario)
  SELECT @error			= NULL, 
		 @error_mensaje = NULL,
		 @conteo		= 0
  
  DECLARE cr_layout CURSOR LOCAL STATIC FOR
   SELECT empresa, ejercicio
     FROM layout_cuentas
    GROUP BY empresa, ejercicio
    ORDER BY empresa, ejercicio
  OPEN cr_layout
  FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio
  WHILE @@FETCH_STATUS <> -1 AND @@ERROR = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN  
      --BUG22719
      EXEC sp_layout_log_in @usuario, 'importar cuentas', 'importando', @Empresa, @log_id OUTPUT    
      
      DELETE 
        FROM cuentas
       WHERE empresa = @empresa AND ejercicio = @ejercicio 

      INSERT INTO cuentas (
		     log_id, 
		     empresa, ejercicio, cuenta_contable, cuenta_control, descripcion, nivel, clase_cuenta, tipo_cuenta, moneda, 
		     saldo_inicial)
      SELECT @log_id,
		     UPPER(empresa), ejercicio, cuenta_contable, cuenta_control, descripcion, nivel, LOWER(clase_cuenta), LOWER(tipo_cuenta), moneda, 
		     saldo_inicial
	    FROM layout_cuentas
       WHERE empresa = @empresa AND ejercicio = @ejercicio 	    
       
      SELECT @conteo = @conteo + @@ROWCOUNT
  
      EXEC sp_layout_log_out @log_id, @conteo, @error, @error_mensaje
    END
   FETCH NEXT FROM cr_layout INTO @empresa, @ejercicio
  END 
  CLOSE cr_layout
  DEALLOCATE cr_layout
	
  RETURN
END
GO

/*********** sp_layout_importar ***********/
if exists (select * from sysobjects where id = object_id('dbo.sp_layout_importar') and type = 'P') drop procedure dbo.sp_layout_importar
GO
CREATE PROCEDURE sp_layout_importar
		   @usuario						varchar(20),
		   @tipo						varchar(50),	-- documentos, aplicaciones, polizas, cuentas
		   @archivo						varchar(255)
WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @cmd				varchar(8000),    
    @with				varchar(255)
  
  SELECT @usuario = UPPER(@usuario),
		 @tipo    = LOWER(@tipo),
		 @archivo = NULLIF(RTRIM(@archivo), '')
  SELECT @with = 'CODEPAGE = ''RAW'', FIELDTERMINATOR = ''\t'', FIRSTROW = 2'
  
  IF @archivo IS NOT NULL
  BEGIN
    IF @tipo = 'documentos'
    BEGIN 
	  TRUNCATE TABLE layout_documentos
      SET @cmd = 'BULK INSERT layout_documentos FROM '''+@archivo+''' WITH ('+@with+')'
      EXEC(@cmd)
      EXEC sp_layout_importar_documentos @usuario
    END ELSE
    IF @tipo = 'aplicaciones' 
    BEGIN
  	  TRUNCATE TABLE layout_aplicaciones
	  SET @cmd = 'BULK INSERT layout_aplicaciones FROM '''+@archivo+''' WITH ('+@with+')'
	  EXEC(@cmd)	
	  EXEC sp_layout_importar_aplicaciones @usuario
	END ELSE
	IF @tipo = 'polizas' 
    BEGIN
  	  TRUNCATE TABLE layout_polizas
	  SET @cmd = 'BULK INSERT layout_polizas FROM '''+@archivo+''' WITH ('+@with+')'
	  EXEC(@cmd)	
	  EXEC sp_layout_importar_polizas @usuario
	END ELSE	
	IF @tipo = 'cuentas' 
    BEGIN
  	  TRUNCATE TABLE layout_cuentas
	  SET @cmd = 'BULK INSERT layout_cuentas FROM '''+@archivo+''' WITH ('+@with+')'
	  EXEC(@cmd)	
	  EXEC sp_layout_importar_cuentas @usuario
	END	
  END
  
  RETURN
END
GO

/*
EXEC sp_layout_importar 'JPEREZ', 'documentos', 'C:\exentus-1.5.6-layout\ejemplo 1\documentos.txt'
EXEC sp_layout_importar 'JPEREZ', 'aplicaciones', 'C:\exentus-1.5.6-layout\ejemplo 1\aplicaciones.txt'
EXEC sp_layout_importar 'JPEREZ', 'polizas', 'C:\exentus-1.5.6-layout\ejemplo 1\polizas.txt'
EXEC sp_layout_importar 'JPEREZ', 'cuentas', 'C:\exentus-1.5.6-layout\ejemplo 1\cuentas.txt'

DECLARE
  @log_id int
EXEC @log_id = sp_layout_procesar 'JPEREZ', 'DEMO', 2012, 8
EXEC @log_id = sp_layout_procesar 'JPEREZ', 'DEMO', 2012, 9
EXEC @log_id = sp_layout_procesar 'JPEREZ', 'DEMO', 2012, 10

-- tablas layout
SELECT * FROM layout_log
SELECT * FROM documentos
SELECT * FROM aplicaciones
SELECT * FROM polizas
SELECT * FROM cuentas

-- tablas Exentus
SELECT * FROM DatosIetu 
SELECT * FROM ximpiva
SELECT * FROM CuentasContables
SELECT * FROM SaldosIni
SELECT * FROM MovContables

SELECT empresa, ejercicio, periodoasi, referencia, 'total'= sum(ietu)+sum(impuestos) 
FROM DatosIetu 
group by empresa, ejercicio, periodoasi, referencia

SELECT sum(importe),sum(iva), SUM(importe+iva) FROM ximpiva

-- tablas layout
DROP TABLE layout_log
DROP TABLE layout_documentos
DROP TABLE layout_aplicaciones
DROP TABLE layout_cuentas
DROP TABLE layout_polizas
DROP TABLE documentos
DROP TABLE aplicaciones
DROP TABLE cuentas
DROP TABLE polizas

-- tablas Exentus
TRUNCATE TABLE DatosIetu
TRUNCATE TABLE ximpiva
TRUNCATE TABLE CuentasContables
TRUNCATE TABLE SaldosIni
TRUNCATE TABLE MovContables

*/

/*********** spMFACuentasContablesSaldo ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFACuentasContablesSaldo') and type = 'P') drop procedure dbo.spMFACuentasContablesSaldo
GO
CREATE PROCEDURE spMFACuentasContablesSaldo
		   @Empresa						varchar(5),
		   @Ejercicio					int,
		   --BUG19206
		   @Periodo						int,
		   @Moneda						varchar(10)
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
  @ContMoneda				varchar(10)

  TRUNCATE TABLE layout_cuentas
    
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  --BUG19206 REQ23317
  INSERT layout_cuentas (empresa,  cuenta_contable, cuenta_control, descripcion, nivel, clase_cuenta, tipo_cuenta, ejercicio, saldo_inicial,                                                                           moneda, saldo_inicial_cargos,                                                                         saldo_inicial_abonos)  
                 SELECT @empresa, cuenta_contable, cuenta_control, descripcion, nivel, clase_cuenta, tipo_cuenta, @ejercicio, dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo,cuenta_contable, @Moneda, ''), @Moneda, dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo,cuenta_contable, @Moneda, 'Cargos'), dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo,cuenta_contable, @Moneda, 'Abonos')
                   FROM MFACuentasContablesSaldo
                  --WHERE empresa = @empresa
                  --  AND ejercicio = @Ejercicio
END
GO

--EXEC spMFACuentasContablesSaldo 'DEMO', 2013, 'Pesos'


/*** MFAPoliza ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAPoliza') and type = 'V') drop view dbo.MFAPoliza
GO
CREATE VIEW MFAPoliza AS
SELECT
  empresa                    = cd.Empresa,
  ejercicio                  = c.Ejercicio,
  --BUG20903
  periodo                    = c.Periodo,
  --BUG22460 BUG22473
  --fecha						 = c.FechaEmision,
  cuenta_contable            = cd.Cuenta,
  cargos                     = ISNULL(SUM(ISNULL(cd.Debe,0.0)),0.0),
  abonos                     = ISNULL(SUM(ISNULL(cd.Haber,0.0)),0.0)
  FROM ContD cd 
    JOIN Cont c ON cd.ID = c.ID
    JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CONT' 
 WHERE c.Estatus = 'CONCLUIDO' 
   AND mt.Clave IN ('CONT.P','CONT.C')
   AND ISNULL(cd.Presupuesto, 0) = 0
 --BUG22473
 GROUP BY cd.Empresa, c.Ejercicio, c.Periodo, cd.Cuenta
GO

--BUG21567
/*** MFAPolizaComp ***/
if exists (select * from sysobjects where id = object_id('dbo.MFAPolizaComp') and type = 'V') drop view dbo.MFAPolizaComp
GO
CREATE VIEW MFAPolizaComp AS
SELECT
  empresa                    = cd.Empresa,
  ejercicio                  = c.Ejercicio,
  periodo                    = c.Periodo,
  --BUG22460 BUG22473
  --fecha						 = c.FechaEmision,
  cuenta_contable            = cd.Cuenta,
  --BUG22473
  cargos                     = ISNULL(SUM(ISNULL(cd.Debe/NULLIF(ISNULL(c.OrigenTipoCambio, c.TipoCambio), 0),0.0)),0.0),
  abonos                     = ISNULL(SUM(ISNULL(cd.Haber/NULLIF(ISNULL(c.OrigenTipoCambio, c.TipoCambio), 0),0.0)),0.0),
  cargos1                    = ISNULL(SUM(ISNULL(cd.Debe,0.0)),0.0),
  abonos1                    = ISNULL(SUM(ISNULL(cd.Haber,0.0)),0.0),
  OrigenMoneda				 = ISNULL(OrigenMoneda, c.Moneda) 
  FROM ContD cd 
  JOIN Cont c ON cd.ID = c.ID
  JOIN MovTipo mt ON mt.Mov = c.Mov AND mt.Modulo = 'CONT' 
 WHERE c.Estatus = 'CONCLUIDO' 
   AND mt.Clave IN ('CONT.P','CONT.C')
   AND ISNULL(cd.Presupuesto, 0) = 0  
   --AND ISNULL(c.OrigenMoneda, '') <> c.Moneda
 --BUG22473 
 GROUP BY cd.Empresa, c.Ejercicio, c.Periodo, cd.Cuenta, OrigenMoneda, c.Moneda
GO

--select * from contd
--SELECT * FROM MFAPoliza	

/*********** spMFADocumentosAgregarCuentaEntidad ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFADocumentosAgregarCuentaEntidad') and type = 'P') drop procedure dbo.spMFADocumentosAgregarCuentaEntidad
GO
CREATE PROCEDURE spMFADocumentosAgregarCuentaEntidad
--//WITH ENCRYPTION
AS BEGIN  
  --select * from MFAPolizaEntidad
  TRUNCATE TABLE MFAPolizaEntidad  
  
  INSERT MFAPolizaEntidad (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   Categoria,   Familia,   Grupo,   EntidadTipo, Entidad)
                   SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, c.Categoria, c.Familia, c.Grupo, 'Cliente',   c.Cliente
                     FROM layout_documentos ld
                     JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                     JOIN Cte c ON c.Cliente = v.Cliente
                    WHERE ld.origen_modulo = 'VTAS' 
  
  INSERT MFAPolizaEntidad (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   Categoria,   Familia,   Grupo, EntidadTipo, Entidad)
                   SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, p.Categoria, p.Familia, NULL,  'Proveedor', p.Proveedor
                     FROM layout_documentos ld
                     JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                     JOIN Prov p ON p.Proveedor = c.Proveedor
                    WHERE ld.origen_modulo = 'COMS' 
  
  INSERT MFAPolizaEntidad (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   Categoria,   Familia,   Grupo, EntidadTipo, Entidad)
                   SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, p.Categoria, p.Familia, NULL,  'Proveedor', p.Proveedor
                     FROM layout_documentos ld
                     JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     JOIN Prov p ON p.Proveedor = g.Acreedor
                    WHERE ld.origen_modulo = 'GAS' 
  
  INSERT MFAPolizaEntidad (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    Categoria,   Familia,   Grupo,   EntidadTipo, Entidad)
                   SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, c.Categoria, c.Familia, c.Grupo, 'Cliente',   c.Cliente
                     FROM layout_documentos ld
                     JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     JOIN Cte c ON c.Cliente = cx.Cliente
                    WHERE ld.origen_modulo = 'CXC' 
  
  INSERT MFAPolizaEntidad (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    Categoria,   Familia,   Grupo,   EntidadTipo, Entidad)
                   SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, p.Categoria, p.Familia, NULL,    'Proveedor', p.Proveedor
                     FROM layout_documentos ld
                     JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     JOIN Prov p ON p.Proveedor = cx.Proveedor
                    WHERE ld.origen_modulo = 'CXP' 

  PRINT 'Fin inserts MFAPolizaEntidad: ' + CONVERT(varchar,getdate(),126)                                          
  
  UPDATE MFAPolizaEntidad
     SET Cuenta = dbo.fnMFAObtenerCuentaEntidad(Modulo,Mov,Categoria,Grupo,Familia,Entidad,EntidadTipo,Empresa, Poliza, PolizaID)   

  PRINT 'Fin update MFAPolizaEntidad: ' + CONVERT(varchar,getdate(),126)                                               
  
  UPDATE layout_documentos
     SET entidad_cuenta_contable = mpe.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaEntidad mpe ON mpe.ModuloID = CONVERT(int,ld.origen_id) AND mpe.Modulo = ld.origen_modulo     
    
  PRINT 'Fin update layout_documentos entidad: ' + CONVERT(varchar,getdate(),126)                                               
  RETURN
END
GO

/*********** spMFADocumentosAgregarCuentaConcepto ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFADocumentosAgregarCuentaConcepto') and type = 'P') drop procedure dbo.spMFADocumentosAgregarCuentaConcepto
GO
CREATE PROCEDURE spMFADocumentosAgregarCuentaConcepto
--//WITH ENCRYPTION
AS BEGIN  
  --select * from MFAPolizaEntidad
  TRUNCATE TABLE MFAPolizaConcepto
  
  INSERT MFAPolizaConcepto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   Categoria,   Familia,   Grupo,   ConceptoTipo, Concepto)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, a.Categoria, a.Familia, a.Grupo, 'Articulo',   ld.concepto_clave
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaConcepto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   Categoria,   Familia,   Grupo,   ConceptoTipo, Concepto)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, a.Categoria, a.Familia, a.Grupo, 'Articulo',   ld.concepto_clave
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 
  
  INSERT MFAPolizaConcepto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   Categoria, Familia, Grupo, ConceptoTipo,     Concepto)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, NULL,      NULL,    NULL,  'Concepto Gasto', ld.concepto_clave
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 
  
  INSERT MFAPolizaConcepto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    Categoria, Familia, Grupo, ConceptoTipo,   Concepto)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, NULL,      NULL,    NULL,  'Concepto Cxc', ld.concepto_clave
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 
  
  INSERT MFAPolizaConcepto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    Categoria, Familia, Grupo,   ConceptoTipo,   Concepto)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, NULL,      NULL,    NULL,    'Concepto Cxp', ld.concepto_clave
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 
  
  PRINT 'Fin inserts MFAPolizaConcepto: ' + CONVERT(varchar,getdate(),126)                                          
  UPDATE MFAPolizaConcepto
     SET Cuenta = dbo.fnMFAObtenerCuentaConcepto(Modulo,Mov,Categoria,Grupo,Familia,Concepto,ConceptoTipo,Empresa, Poliza, PolizaID)   
  PRINT 'Fin update MFAPolizaConcepto: ' + CONVERT(varchar,getdate(),126)                                               
  UPDATE layout_documentos
     SET concepto_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaConcepto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo     
  PRINT 'Fin update layout_documento concepto: ' + CONVERT(varchar,getdate(),126)                                                   
  RETURN
END
GO


/******************************* spInsertarLayoutAplicacionEntidad *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spInsertarLayoutAplicacionEntidad') and type = 'P') drop procedure dbo.spInsertarLayoutAplicacionEntidad
GO             
CREATE PROCEDURE spInsertarLayoutAplicacionEntidad
        --BU22575
		@Empresa    varchar(5),
		@Ok			int			= NULL OUTPUT,
		@OkRef		varchar(255)= NULL OUTPUT


--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  -- SET nocount ON

 DELETE layout_aplicacion_entidad WHERE Empresa = @Empresa
 
 INSERT layout_aplicacion_entidad (empresa, referencia, folio, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad)
 SELECT 
  empresa				 = la.empresa,
  referencia             = la.referencia,
  folio                  = la.folio,
  entidad_clave          = ld.entidad_clave,
  entidad_nombre         = ld.entidad_nombre,
  entidad_rfc            = ld.entidad_rfc,
  entidad_id_fiscal      = ld.entidad_id_fiscal,
  entidad_tipo_tercero   = ld.entidad_tipo_tercero,
  entidad_tipo_operacion = ld.entidad_tipo_operacion,
  entidad_pais           = ld.entidad_pais,
  entidad_nacionalidad   = ld.entidad_nacionalidad
  FROM layout_aplicaciones la  WITH(NOLOCK)
  JOIN layout_aplicaciones la2 WITH(NOLOCK) ON la2.folio = la.folio AND la2.Empresa = la.Empresa AND la2.Ejercicio = la.Ejercicio AND la2.Periodo = la.Periodo
  JOIN layout_documentos ld    WITH(NOLOCK) ON la2.Referencia = ld.folio and la2.empresa = ld.empresa
 WHERE la.referencia IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')
   AND la2.referencia NOT IN ('Redondeo','Saldo a favor','Vales en Circulacion','Consumos Pendientes')
   --BU22575
   AND la.Empresa = @Empresa
 GROUP BY la.empresa, la.referencia, la.folio, ld.entidad_clave, ld.entidad_nombre, ld.entidad_rfc, ld.entidad_id_fiscal, ld.entidad_tipo_tercero, ld.entidad_tipo_operacion, ld.entidad_pais, ld.entidad_nacionalidad
END
GO

/*********** spMFADocumentosAgregarCuentaImpuesto ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFADocumentosAgregarCuentaImpuesto') and type = 'P') drop procedure dbo.spMFADocumentosAgregarCuentaImpuesto
GO
CREATE PROCEDURE spMFADocumentosAgregarCuentaImpuesto
--//WITH ENCRYPTION
AS BEGIN  

  TRUNCATE TABLE MFAPolizaImpuesto  
  --Ventas
  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'Retencion ISR', 0   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'IVA',        iva_tasa   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'Retencion IVA', 0   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'IEPS',          ieps_tasa   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'ISAN',          0   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  v.Empresa, v.Poliza, v.PolizaID, 'VTAS', CONVERT(int,ld.origen_id), v.Mov, 'Otros',         otros_impuestos_tasa   
                      FROM layout_documentos ld
                      JOIN Venta v ON v.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave
                     WHERE ld.origen_modulo = 'VTAS' 
  
  --Compras
  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'Retencion ISR', 0
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'IVA',           iva_tasa
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'Retencion IVA', 0
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 
  
  --ISR, Retencion ISR, IVA, Retencion IVA, IEPS, ISAN, Otros
  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'IEPS',       ieps_tasa
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'ISAN',       0
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                  Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  c.Empresa, c.Poliza, c.PolizaID, 'COMS', CONVERT(int,ld.origen_id), c.Mov, 'Otros',      otros_impuestos_tasa
                      FROM layout_documentos ld
                      JOIN Compra c ON c.ID = CONVERT(int,ld.origen_id)
                      JOIN Art a ON a.Articulo = ld.concepto_clave                      
                     WHERE ld.origen_modulo = 'COMS' 
   
  --Gastos 
  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'Retencion ISR', 0
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'IVA',        iva_tasa
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo,    ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'Retencion IVA', 0
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 
  
  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'IEPS',       ieps_tasa
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'ISAN',       0
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 

  INSERT MFAPolizaImpuesto (Empresa,   Poliza,   PolizaID,   Modulo, ModuloID,                   Mov,   ImpuestoTipo, ImpuestoTasa)
                    SELECT  g.Empresa, g.Poliza, g.PolizaID, 'GAS',  CONVERT(int,ld.origen_id),  g.Mov, 'Otros',      otros_impuestos_tasa
                      FROM layout_documentos ld
                      JOIN Gasto g ON g.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'GAS' 
  
  --Cuentas por cobrar
  --Retencion ISR, IVA, Retencion IVA, IEPS, ISAN, Otros    
  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo,    ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'Retencion ISR', 0
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'IVA',        iva_tasa
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo,    ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'Retencion IVA', 0
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'IEPS',       ieps_tasa
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'ISAN',       0
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXC',  CONVERT(int,ld.origen_id),  cx.Mov, 'Otros',      otros_impuestos_tasa
                      FROM layout_documentos ld
                      JOIN Cxc cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXC' 
  
  --Cuentas por pagar
  --Retencion ISR, IVA, Retencion IVA, IEPS, ISAN, Otros    
  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo,    ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'Retencion ISR', 0
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'IVA',        iva_tasa
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo,    ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'Retencion IVA', 0
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'IEPS',       ieps_tasa
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'ISAN',       0
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  INSERT MFAPolizaImpuesto (Empresa,    Poliza,    PolizaID,    Modulo, ModuloID,                   Mov,    ImpuestoTipo, ImpuestoTasa)
                    SELECT  cx.Empresa, cx.Poliza, cx.PolizaID, 'CXP',  CONVERT(int,ld.origen_id),  cx.Mov, 'Otros',      otros_impuestos_tasa
                      FROM layout_documentos ld
                      JOIN Cxp cx ON cx.ID = CONVERT(int,ld.origen_id)
                     WHERE ld.origen_modulo = 'CXP' 

  PRINT 'Fin inserts MFAPolizaImpuesto: ' + CONVERT(varchar,getdate(),126)                                            
  UPDATE MFAPolizaImpuesto
     SET Cuenta = dbo.fnMFAObtenerCuentaImpuesto(Modulo,Mov,ImpuestoTasa,ImpuestoTipo,Empresa, Poliza, PolizaID)   
  PRINT 'Fin update MFAPolizaImpuesto: ' + CONVERT(varchar,getdate(),126)                                                 

  UPDATE layout_documentos
     SET retencion_isr_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'ISR'      
   
  UPDATE layout_documentos
     SET iva_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'IVA'      

  UPDATE layout_documentos
     SET retencion_iva_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'Retencion IVA'      

  UPDATE layout_documentos
     SET ieps_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'IEPS'      

  UPDATE layout_documentos
     SET isan_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'ISAN'      

  UPDATE layout_documentos
     SET otros_impuestos_cuenta_contable = mpc.Cuenta
    FROM layout_documentos ld
    JOIN MFAPolizaImpuesto mpc ON mpc.ModuloID = CONVERT(int,ld.origen_id) AND mpc.Modulo = ld.origen_modulo AND mpc.ImpuestoTipo = 'Otros'      
  PRINT 'Fin update layout_documentos impuesto: ' + CONVERT(varchar,getdate(),126)                                                 
  RETURN
END
GO


--exec spMFALayoutImportar 'ADMON', 'NOVA', 2012, 1

/*********** spMFADocumentosAgregarCuenta ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFADocumentosAgregarCuenta') and type = 'P') drop procedure dbo.spMFADocumentosAgregarCuenta
GO
CREATE PROCEDURE spMFADocumentosAgregarCuenta
--//WITH ENCRYPTION
AS BEGIN  
  EXEC spMFADocumentosAgregarCuentaEntidad
  PRINT 'Fin agregar cuenta entidad (Q26.1): ' + CONVERT(varchar,getdate(),126)                                      
  EXEC spMFADocumentosAgregarCuentaConcepto
  PRINT 'Fin agregar cuenta concepto (Q26.2): ' + CONVERT(varchar,getdate(),126)                                        
  EXEC spMFADocumentosAgregarCuentaImpuesto
  PRINT 'Fin agregar cuenta concepto (Q26.3): ' + CONVERT(varchar,getdate(),126)                                        
  RETURN
END
GO

/*********** spMFADocumentosAgregarDocumentoCuenta ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFADocumentosAgregarDocumentoCuenta') and type = 'P') drop procedure dbo.spMFADocumentosAgregarDocumentoCuenta
GO
CREATE PROC spMFADocumentosAgregarDocumentoCuenta
			--BUG19036
			@IFRS							bit,
			@IncluirPolizasEspecificas		bit,
            --BU22575
			@Empresa						varchar(5)
--//WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE @Base		varchar(255)

  SELECT @Base = db_name()
  
  --BU22575 BUG24882
  --DELETE temp2_layout_documentos_cuenta WHERE Empresa = @Empresa
  --DELETE temp3_layout_documentos_cuenta WHERE Empresa = @Empresa
  TRUNCATE TABLE temp2_layout_documentos_cuenta 
  TRUNCATE TABLE temp3_layout_documentos_cuenta 
  
  --TRUNCATE TABLE temp_layout_documentos_cuenta     WHERE Empresa = @Empresa
  DELETE layout_documentos_cuenta WHERE Empresa = @Empresa

  EXEC spShrink_Log @Base

  INSERT temp2_layout_documentos_cuenta (empresa, origen_modulo, origen_id)
                                 SELECT  empresa, origen_modulo, origen_id
                                   FROM  layout_documentos WITH(NOLOCK)
                                  --BU22575
                                  WHERE  Empresa = @Empresa
                                  GROUP  BY origen_id, origen_modulo, empresa

  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp2_layout_documentos_cuenta (Q26.1): ' + CONVERT(varchar,getdate(),126)      
                                     
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id,  mov,   mov_id)
                                 SELECT t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID
                                   FROM temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN Venta t WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'VTAS' AND t.Empresa = t2ldc.empresa 
                                  WHERE t.Poliza IS NOT NULL 
                                    --BU22575
                                    AND  t2ldc.Empresa = @Empresa

  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta venta (Q26.2): ' + CONVERT(varchar,getdate(),126)      
  
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id,  mov,   mov_id)
                                 SELECT  t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID 
                                   FROM  temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN  Compra t WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'COMS' AND t.Empresa = t2ldc.empresa 
                                  WHERE  t.Poliza IS NOT NULL    
                                   --BU22575
                                    AND  t2ldc.Empresa = @Empresa                                                                  
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta compra (Q26.3): ' + CONVERT(varchar,getdate(),126)      
  
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id,  mov,   mov_id)
                                 SELECT  t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                   FROM  temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN  Gasto t WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'GAS' AND t.Empresa = t2ldc.empresa 
                                  WHERE  t.Poliza IS NOT NULL 
                                    --BU22575
                                    AND  t2ldc.Empresa = @Empresa                                  
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta gasto (Q26.4): ' + CONVERT(varchar,getdate(),126)      
                                    
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id,  mov,   mov_id)
                                 SELECT  t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                   FROM  temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN  Cxc t  WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'CXC' AND t.Empresa = t2ldc.empresa 
                                  WHERE  t.Poliza IS NOT NULL 
                                    --BU22575
                                    AND  t2ldc.Empresa = @Empresa                                  
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta cxc (Q26.5): ' + CONVERT(varchar,getdate(),126)      
                                    
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id, mov,   mov_id)
                                 SELECT t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                   FROM temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN Cxp t WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'CXP' AND t.Empresa = t2ldc.empresa 
                                  WHERE t.Poliza IS NOT NULL     
                                   --BU22575
                                   AND  t2ldc.Empresa = @Empresa                                                                 
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta cxp (Q26.6): ' + CONVERT(varchar,getdate(),126)      

  --BUG18077
  INSERT temp3_layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id, mov,   mov_id)
                                 SELECT t2ldc.empresa, t2ldc.origen_modulo, t2ldc.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                   FROM temp2_layout_documentos_cuenta t2ldc WITH(NOLOCK)
                                   JOIN Nomina t WITH(NOLOCK) ON t.ID = CONVERT(int,t2ldc.origen_id) AND t2ldc.origen_modulo = 'NOM' AND t.Empresa = t2ldc.empresa 
                                  WHERE t.Poliza IS NOT NULL                                    
                                   AND  t2ldc.Empresa = @Empresa                                  
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta nom (Q26.6): ' + CONVERT(varchar,getdate(),126)        

  IF @IFRS = 1 AND @IncluirPolizasEspecificas = 1
  BEGIN
    --BUG19036    
    INSERT layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       cuenta_contable, debe,                     haber,                     Ejercicio,   Periodo,     ContID)
                             SELECT t3ldc.empresa,  t3ldc.origen_modulo, t3ldc.origen_id, cd.Cuenta,       SUM(ISNULL(cd.Debe,0.0)), SUM(ISNULL(cd.Haber,0.0)), c.Ejercicio, c.Periodo, c.ID
                               FROM temp3_layout_documentos_cuenta t3ldc  WITH(NOLOCK)
                               JOIN Cont c WITH(NOLOCK) ON c.MovID = t3ldc.poliza_id AND c.Mov = t3ldc.poliza AND c.Empresa = t3ldc.empresa and c.OrigenTipo = t3ldc.origen_modulo AND c.Origen = t3ldc.mov AND c.OrigenID = t3ldc.mov_id
                               JOIN ContD cd WITH(NOLOCK) ON cd.ID = c.ID
                              --BUG22460
                              WHERE c.Estatus = 'CONCLUIDO'
                               --BU22575
                               AND  t3ldc.Empresa = @Empresa                              
                              GROUP BY t3ldc.empresa,  t3ldc.origen_modulo, t3ldc.origen_id, cd.Cuenta, c.Ejercicio, c.Periodo, c.ID
    EXEC spShrink_Log @Base
    
                              --BUG20109                               
    INSERT layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       cuenta_contable, debe,                     haber,                     Ejercicio,   Periodo,     ContID)
                              SELECT c.empresa,     ISNULL(c.OrigenTipo, 'CONT'), c.id,			  cd.Cuenta,       SUM(ISNULL(cd.Debe,0.0)), SUM(ISNULL(cd.Haber,0.0)), c.Ejercicio, c.Periodo, c.ID
                                FROM MFAContAdicion t3ldc WITH(NOLOCK)
                                JOIN Cont c  WITH(NOLOCK) ON c.ID = t3ldc.ModuloID
                                JOIN ContD cd  WITH(NOLOCK) ON cd.ID = c.ID
                               --BUG22460
                               WHERE c.Estatus = 'CONCLUIDO'
                                 --BU22575
                                 AND c.Empresa = @Empresa
                                 AND c.ID NOT IN(SELECT ContID FROM layout_documentos_cuenta)
                               GROUP BY c.empresa, c.OrigenTipo, c.id, cd.Cuenta, c.Ejercicio, c.Periodo, c.ID  
    EXEC spShrink_Log @Base
                              --BUG20109                               
    INSERT layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       cuenta_contable, debe,                     haber,                     Ejercicio,   Periodo,     ContID)                               
                              SELECT c.empresa,     ISNULL(c.OrigenTipo, 'CONT'), c.id,			  cd.Cuenta,       SUM(ISNULL(cd.Debe,0.0)), SUM(ISNULL(cd.Haber,0.0)), c.Ejercicio, c.Periodo, c.ID
                                FROM MFAContOrigenAdicion t3ldc WITH(NOLOCK)
                                JOIN Cont c  WITH(NOLOCK) ON ISNULL(c.OrigenTipo, '') = ISNULL(t3ldc.OrigenTipo, '') AND ISNULL(c.Origen, '') = ISNULL(t3ldc.Origen, '') AND ISNULL(c.Mov, '') = ISNULL(t3ldc.Mov, '')
                                JOIN ContD cd WITH(NOLOCK) ON cd.ID = c.ID
                              --BUG22460
                               WHERE c.Estatus = 'CONCLUIDO'
                                 --BU22575
                                 AND c.Empresa = @Empresa                               
                                 AND c.ID NOT IN(SELECT ContID FROM layout_documentos_cuenta)
                               GROUP BY c.empresa, c.OrigenTipo, c.id, cd.Cuenta, c.Ejercicio, c.Periodo, c.ID

    EXEC spShrink_Log @Base                               
  END
  ELSE
    --BUG18077
    INSERT layout_documentos_cuenta (empresa,       origen_modulo,       origen_id,       cuenta_contable, debe,                     haber,                     Ejercicio,   Periodo,     ContID)
                             SELECT t3ldc.empresa,  t3ldc.origen_modulo, t3ldc.origen_id, cd.Cuenta,       SUM(ISNULL(cd.Debe,0.0)), SUM(ISNULL(cd.Haber,0.0)), c.Ejercicio, c.Periodo, c.ID
                               FROM temp3_layout_documentos_cuenta t3ldc  WITH(NOLOCK)
                               JOIN Cont c  WITH(NOLOCK) ON c.MovID = t3ldc.poliza_id AND c.Mov = t3ldc.poliza AND c.Empresa = t3ldc.empresa and c.OrigenTipo = t3ldc.origen_modulo AND c.Origen = t3ldc.mov AND c.OrigenID = t3ldc.mov_id
                               JOIN ContD cd  WITH(NOLOCK) ON cd.ID = c.ID 
                              --BUG22460
                              WHERE c.Estatus = 'CONCLUIDO'                               
                                --BU22575
                                AND c.Empresa = @Empresa                              
                              GROUP BY t3ldc.empresa,  t3ldc.origen_modulo, t3ldc.origen_id, cd.Cuenta, c.Ejercicio, c.Periodo, c.ID
    EXEC spShrink_Log @Base
    PRINT 'Fin generar temp_layout_documentos_cuenta (Q26.7): ' + CONVERT(varchar,getdate(),126)                                           

  /*  
  INSERT layout_documentos_cuenta (empresa,      origen_modulo,      origen_id,      cuenta_contable,      debe,      haber)--,      tipo,     subtipo)
                           SELECT tldc.empresa,  tldc.origen_modulo, tldc.origen_id, tldc.cuenta_contable, tldc.debe, tldc.haber--, mtc.tipo, mtc.subtipo  
                             FROM temp_layout_documentos_cuenta tldc
                             --LEFT OUTER JOIN MFATipoCta mtc ON mtc.Cuenta = SUBSTRING(tldc.cuenta_contable,1,mtc.Longitud)
                            --WHERE mtc.Cuenta IS NOT NULL  
  PRINT 'Fin generar layout_documentos_cuenta (Q26.8): ' + CONVERT(varchar,getdate(),126)                                         
  */
  RETURN
END
GO

/*********** spMFAAplicacionesAgregarAplicacionCuenta ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFAAplicacionesAgregarAplicacionCuenta') and type = 'P') drop procedure dbo.spMFAAplicacionesAgregarAplicacionCuenta
GO
CREATE PROCEDURE spMFAAplicacionesAgregarAplicacionCuenta
                 --BU22575
				 @Empresa			varchar(5)
--//WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE @Base		varchar(255)
  
  SELECT @Base = db_name()
    
  --BU22575
  DELETE temp2_layout_aplicaciones_cuenta WHERE Empresa = @Empresa
  DELETE temp3_layout_aplicaciones_cuenta WHERE Empresa = @Empresa
  --TRUNCATE TABLE temp_layout_aplicaciones_cuenta    
  DELETE layout_aplicaciones_cuenta  WHERE Empresa = @Empresa

  EXEC spShrink_Log @Base

  INSERT temp2_layout_aplicaciones_cuenta (empresa, origen_modulo, origen_id)
                                 SELECT  empresa, origen_modulo, origen_id
                                   FROM  layout_aplicaciones
                                  --BU22575
                                  WHERE  empresa = @Empresa
                                  GROUP  BY origen_id, origen_modulo, empresa 

  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp2_layout_aplicaciones_cuenta (Q26.81): ' + CONVERT(varchar,getdate(),126)      

  INSERT temp3_layout_aplicaciones_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id,  mov,   mov_id)
                                   SELECT  t2lac.empresa, t2lac.origen_modulo, t2lac.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                     FROM  temp2_layout_aplicaciones_cuenta t2lac WITH(NOLOCK)
                                     JOIN  Cxc t WITH(NOLOCK) ON t.ID = CONVERT(int,t2lac.origen_id) AND t2lac.origen_modulo = 'CXC' AND t.Empresa = t2lac.empresa 
                                    WHERE  t.Poliza IS NOT NULL 
                                      --BU22575
                                      AND  t2lac.empresa = @Empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta cxc (Q26.82): ' + CONVERT(varchar,getdate(),126)      

  INSERT temp3_layout_aplicaciones_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id, mov,   mov_id)
                                   SELECT  t2lac.empresa, t2lac.origen_modulo, t2lac.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                     FROM temp2_layout_aplicaciones_cuenta t2lac WITH(NOLOCK)
                                     JOIN Cxp t WITH(NOLOCK) ON t.ID = CONVERT(int,t2lac.origen_id) AND t2lac.origen_modulo = 'CXP' AND t.Empresa = t2lac.empresa 
                                    WHERE t.Poliza IS NOT NULL     
                                     --BU22575
                                     AND  t2lac.empresa = @Empresa                               
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta cxp (Q26.83): ' + CONVERT(varchar,getdate(),126)      

  --BUG17507
  INSERT temp3_layout_aplicaciones_cuenta (empresa,       origen_modulo,       origen_id,       poliza,   poliza_id, mov,   mov_id)
                                   SELECT  t2lac.empresa, t2lac.origen_modulo, t2lac.origen_id, t.Poliza, t.PolizaID, t.Mov, t.MovID  
                                     FROM temp2_layout_aplicaciones_cuenta t2lac WITH(NOLOCK)
                                     JOIN Dinero t WITH(NOLOCK) ON t.ID = CONVERT(int,t2lac.origen_id) AND t2lac.origen_modulo = 'DIN' AND t.Empresa = t2lac.empresa 
                                    WHERE t.Poliza IS NOT NULL                                    
                                     --BU22575
                                     AND  t2lac.empresa = @Empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp3_layout_documentos_cuenta cxp (Q26.83): ' + CONVERT(varchar,getdate(),126)        

  --BUG18077
  INSERT layout_aplicaciones_cuenta (empresa,       origen_modulo,       origen_id,       cuenta_contable, debe,                     haber,                     Ejercicio,   Periodo,     ContID)
                             SELECT  t3lac.empresa, t3lac.origen_modulo, t3lac.origen_id, cd.Cuenta,       SUM(ISNULL(cd.Debe,0.0)), SUM(ISNULL(cd.Haber,0.0)), c.Ejercicio, c.Periodo, c.ID
                               FROM temp3_layout_aplicaciones_cuenta t3lac WITH(NOLOCK)
                               JOIN Cont c WITH(NOLOCK) ON c.MovID = t3lac.poliza_id AND c.Mov = t3lac.poliza AND c.Empresa = t3lac.empresa and c.OrigenTipo = t3lac.origen_modulo AND c.Origen = t3lac.mov AND c.OrigenID = t3lac.mov_id
                               JOIN ContD cd WITH(NOLOCK) ON cd.ID = c.ID 
                               --BUG22460
                              WHERE c.Estatus = 'CONCLUIDO'
                                --BU22575
                                AND c.Empresa = @Empresa
                              GROUP BY t3lac.empresa,  t3lac.origen_modulo, t3lac.origen_id, cd.Cuenta, c.Ejercicio, c.Periodo, c.ID
  EXEC spShrink_Log @Base
  PRINT 'Fin generar temp_layout_documentos_cuenta (Q26.85): ' + CONVERT(varchar,getdate(),126)                                         

  /*
  INSERT layout_aplicaciones_cuenta (empresa,      origen_modulo,      origen_id,      cuenta_contable,      debe,      haber)
                             SELECT tlac.empresa,  tlac.origen_modulo, tlac.origen_id, tlac.cuenta_contable, tlac.debe, tlac.haber
                               FROM temp_layout_aplicaciones_cuenta tlac
  PRINT 'Fin generar layout_documentos_cuenta (Q26.85): ' + CONVERT(varchar,getdate(),126)                                         
  */
  RETURN
END
GO

--BUG22558
/*********** spMFAContBalanzaCfg ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFAContBalanzaCfg') and type = 'P') drop procedure dbo.spMFAContBalanzaCfg
GO
CREATE PROC spMFAContBalanzaCfg
			@Empresa		varchar(5), 
			@Ejercicio		int, 
			@Periodo		int,
			@FechaD			datetime,
			@FechaA			datetime
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  UPDATE EmpresaMFA SET IncluirPolizasEspecificas = 1 WHERE Empresa = @Empresa
  
  DELETE MFAContAdicion
    FROM MFAContAdicion WITH(NOLOCK)
    JOIN Cont           WITH(NOLOCK) ON MFAContAdicion.ModuloID = Cont.ID
   WHERE Cont.Ejercicio = ISNULL(@ejercicio, Cont.Ejercicio) 
     AND Cont.Periodo   = ISNULL(@periodo, Cont.Periodo)
     AND Cont.Empresa = @Empresa
     AND Cont.FechaEmision     >= ISNULL(@FechaD, FechaEmision) 
     AND Cont.FechaEmision     <= ISNULL(@FechaA, FechaEmision)

  INSERT INTO MFAContAdicion(
		 ModuloID)
  SELECT a.ID
    FROM Cont a WITH(NOLOCK), ContD b WITH(NOLOCK), Movtipo c WITH(NOLOCK)
   WHERE a.Id = b.Id
     AND a.Estatus   = 'CONCLUIDO'
     AND a.Ejercicio = ISNULL(@ejercicio, a.Ejercicio) 
     AND a.Periodo = ISNULL(@periodo, a.Periodo)
     AND a.Empresa = @Empresa
     AND a.FechaEmision >= ISNULL(@FechaD, FechaEmision) 
     AND a.FechaEmision <= ISNULL(@FechaA, FechaEmision)
     AND a.Mov = c.Mov
     AND c.Modulo = 'CONT'
     AND c.Clave <> 'CONT.PR'
     AND ISNULL(b.Presupuesto, 0) = 0
   GROUP BY a.ID
   
  DELETE MFAContAdicion
    FROM MFAContAdicion WITH(NOLOCK)
    JOIN Cont WITH(NOLOCK) ON MFAContAdicion.ModuloID = Cont.ID
    JOIN layout_aplicaciones_cuenta WITH(NOLOCK) ON layout_aplicaciones_cuenta.ContID = Cont.ID AND layout_aplicaciones_cuenta.ContID = MFAContAdicion.ModuloID
   WHERE Cont.Ejercicio = ISNULL(@ejercicio, Cont.Ejercicio)
     AND Cont.Periodo = ISNULL(@periodo, Cont.Periodo)
     AND Cont.Empresa = @Empresa
     AND Cont.FechaEmision >= ISNULL(@FechaD, Cont.FechaEmision) 
     AND Cont.FechaEmision <= ISNULL(@FechaA, Cont.FechaEmision)
END
GO

/*********** spMFALayoutImportar ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutImportar') and type = 'P') drop procedure dbo.spMFALayoutImportar
GO
CREATE PROCEDURE spMFALayoutImportar
		   @Usuario						varchar(20),
		   @Empresa						varchar(5),
		   @Ejercicio					int,
		   @Periodo						int,
		   --BUG22460
		   @FechaD						datetime	= NULL,
		   @FechaA						datetime	= NULL,
		   @EnSilencio					bit			= 0
--//WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
  
  DECLARE
    @cmd				varchar(8000),    
    @with				varchar(255),
    @moneda				varchar(10),
    @PeriodoInicial		int,
    @EjercicioInicial	int,
    @log_id				int,
    --CONCILIACION
    @CobrosConciliados	bit,
	@PagosConciliados	bit,
	--REQ16670
	@AnticiposPagadosPeriodo	bit,
	--REQ16899
	@CxpAnticiposPagadosPeriodo	bit,
	--REQ16711
	@IncluirNomina				bit,
	--BUG17507
	@IFRS						bit,
	@IncluirPolizasTesoreria	bit,
	--BUG18013
	@IncluirNotasAnteriores		bit,
	--BUG18077
	@IncluirPolizasNomina		bit,
	--BUG18278
	@GASComprobantesPorConcepto	bit,
	--BUG18599
	@DINDepositosAnticipados	bit,
	--BUG18599
	@IncluirPolizasEspecificas	bit,
	--BUG22544
	@ImportarFacturasContado	bit,
	--BUG22575
	@ValidarReferencias			bit,	
	
	@Base						varchar(255),
	--BUG23552
	@DefImpuesto				float,
	--BUG23996
	@CxcChequesDevueltosNegativo bit,
	@CxpChequesDevueltosNegativo bit,
	--BUG24895
	@IncluirNotas				 bit
	
  SELECT @Base = db_name()
	
  SELECT @usuario = UPPER(@usuario)
  
  --CONCILIACION REQ16670
  SELECT @PeriodoInicial = PeriodoInicial, 
         @EjercicioInicial = EjercicioInicial, 
         @CobrosConciliados = NULLIF(CobrosConciliados, 0), 
         @PagosConciliados = NULLIF(PagosConciliados, 0), 
         @AnticiposPagadosPeriodo = ISNULL(AnticiposPagadosPeriodo, 0),
         --REQ16899
		 @CxpAnticiposPagadosPeriodo = ISNULL(CxpAnticiposPagadosPeriodo, 0),
         @IncluirNomina = ISNULL(IncluirNomina, 0),
         --BUG17507
		 @IFRS = ISNULL(IFRS, 0),
		 @IncluirPolizasTesoreria = ISNULL(IncluirPolizasTesoreria, 0),
		 --BUG18013
		 @IncluirNotasAnteriores = ISNULL(IncluirNotasAnteriores, 0),
		 --BUG18077
		 @IncluirPolizasNomina = ISNULL(IncluirPolizasNomina, 0),
		 --BUG18278
	     @GASComprobantesPorConcepto = ISNULL(GASComprobantesPorConcepto, 0),
	     --BUG18599
	     @DINDepositosAnticipados = ISNULL(DINDepositosAnticipados, 0),
	     @IncluirPolizasEspecificas = ISNULL(IncluirPolizasEspecificas, 0),
	     --BUG22544
	     @ImportarFacturasContado	= ISNULL(ImportarFacturasContado, 0),
	     --BUG22575
	     @ValidarReferencias = ISNULL(ValidarReferencias, 0),
	     @CxcChequesDevueltosNegativo = ISNULL(CxcChequesDevueltosNegativo, 0),
	     @CxpChequesDevueltosNegativo = ISNULL(CxpChequesDevueltosNegativo, 0),
	     --BUG24895
	     @IncluirNotas				  = ISNULL(IncluirNotas, 0)
    FROM EmpresaMFA
   WHERE Empresa = @Empresa
  
  SELECT @moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  --BUG23552
  SELECT @DefImpuesto = ISNULL(DefImpuesto, 0) FROM EmpresaGral WHERE Empresa = @Empresa
  
  --BU22575 BUG24876
  --DELETE layout_documentos WHERE Empresa = @Empresa
  TRUNCATE TABLE layout_documentos    
  --DELETE layout_aplicaciones WHERE Empresa = @Empresa
  TRUNCATE TABLE layout_aplicaciones 

  PRINT 'Al iniciar: ' + CONVERT(varchar,getdate(),126)  
  
  --BUG22156
  IF @Ejercicio = @EjercicioInicial AND @PeriodoInicial = @Periodo AND @FechaD IS NULL AND @FechaA IS NULL
  BEGIN
    PRINT 'Inicio Ejercicio y periodo inicial: ' + CONVERT(varchar,getdate(),126)  

    --BUG17507 BUG20353 BUG22156 BUG22833 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,              EsActivoFijo, TipoActivo, TipoActividad,  fecha,  BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFADocumentoInicialCalc', EsActivoFijo, TipoActivo, TipoActividad, @FechaA, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFADocumentoInicialCalc WITH(NOLOCK)
                       WHERE ejercicio = @ejercicio 
                         AND periodo = @periodo
                         --BU22575
                         AND empresa = @empresa

    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos iniciales (Q1): ' + CONVERT(varchar,getdate(),126)  
    
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,            EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAVentaPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFAVentaPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa                       
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores venta (Q2): ' + CONVERT(varchar,getdate(),126)  

    --BUG24882    
    --BUG22544
    --IF @ImportarFacturasContado = 1
    --BEGIN
    --  --BUG22833 BUG24733
    --  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,          EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
    --                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAVentaContadoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
    --                      FROM MFAVentaContadoCalc WITH(NOLOCK)
				--	     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
    --                       --BU22575
    --                       AND empresa = @empresa
    --  EXEC spShrink_Log @Base
    --  PRINT 'Fin Documentos periodos anteriores venta contado (Q2.1): ' + CONVERT(varchar,getdate(),126)      
    --END
    
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,             EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACompraPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFACompraPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores compra (Q3): ' + CONVERT(varchar,getdate(),126)  
                           
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAGastoCxpPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), PorcentajeDeducible
                        FROM MFAGastoCxpPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores gasto Cxp (Q4): ' + CONVERT(varchar,getdate(),126)  
    
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAGastoCxcPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), PorcentajeDeducible
                        FROM MFAGastoCxcPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores gasto Cxc (Q4): ' + CONVERT(varchar,getdate(),126)
    
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                  EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAGastoDineroPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), PorcentajeDeducible
                        FROM MFAGastoDineroPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa                       
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores gasto Dinero (Q4.1): ' + CONVERT(varchar,getdate(),126)          
                           
    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                   EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxcDocumentoPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFACxcDocumentoPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores cxc (Q5): ' + CONVERT(varchar,getdate(),126)  

    --BUG18599
    IF @DINDepositosAnticipados = 1
    BEGIN
      -- BUG20353 BUG22460 BUG22833 BUG24733
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                       EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFADineroAnticipadoDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                          FROM MFADineroAnticipadoDocumentoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base
      PRINT 'Fin Documentos periodos anteriores Deposito Anticipado (Q5.1): ' + CONVERT(varchar,getdate(),126)      
    END

    --REQ16748 --BUG17507 BUG20353 BUG22156 BUG22460 BUG22833 BUG24733
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                   EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxpDocumentoPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFACxpDocumentoPendienteCalc WITH(NOLOCK)
					   WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin Documentos periodos anteriores cxp (Q6): ' + CONVERT(varchar,getdate(),126)  

    IF @IncluirNomina = 1
    BEGIN
      --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                         EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANominaCxpDocumentoPendienteCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                          FROM MFANominaCxpDocumentoPendienteCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base
      PRINT 'Fin Documentos de Nomina periodos anteriores cxp (Q6.1): ' + CONVERT(varchar,getdate(),126)
    END
    
    --BUG16247 --BUG17507 --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcEndosoCalc', fecha
                          FROM MFACxcEndosoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa                       
    EXEC spShrink_Log @Base
    PRINT 'Fin endoso periodos anteriores cxc (Q7): ' + CONVERT(varchar,getdate(),126)  

    --BUG16247 --BUG17507 --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpEndosoCalc', fecha
                          FROM MFACxpEndosoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa                       
    EXEC spShrink_Log @Base
    PRINT 'Fin endoso periodos anteriores cxp (Q8): ' + CONVERT(varchar,getdate(),126)      

    --BUG18077
    IF @IFRS = 1 AND @IncluirPolizasNomina = 1
    BEGIN
      --BUG20353 BUG22460 BUG22833 BUG24733
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, EsIFRS, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,             EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, 1,      concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANominaDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                          FROM MFANominaDocumentoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base
      PRINT 'Fin documentos Nomina (Q14.1): ' + CONVERT(varchar,getdate(),126)        
    END

    --BUG18920 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcRedocumentacionCalc', fecha
                          FROM MFACxcRedocumentacionCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base
    
    --BUG23996
    IF @CxcChequesDevueltosNegativo = 1
    BEGIN
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva, PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxcChequeDevueltoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  0,        100.0
                          FROM MFACxcChequeDevueltoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base      
    END
    
    IF @CxpChequesDevueltosNegativo = 1
    BEGIN
      --BUG23996
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva, PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxpChequeDevueltoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  0,        100.0
                          FROM MFACxpChequeDevueltoCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base      
    END    

    --BUG24719        
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpRedocumentacionCalc', fecha
                          FROM MFACxpRedocumentacionCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base    
    
    PRINT 'Fin Ejercicio y periodo inicial: : ' + CONVERT(varchar,getdate(),126)          
    
    --BUG18013
    IF @IncluirNotasAnteriores = 1
    BEGIN
      -- BUG20353 BUG22460 BUG22833
      INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,  EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANotaCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                          FROM MFANotaCalc WITH(NOLOCK)
					     WHERE ((ejercicio = @ejercicio AND periodo < @periodo) OR (ejercicio < @ejercicio))
                           --BU22575
                           AND empresa = @empresa
      EXEC spShrink_Log @Base
      PRINT 'Fin Notas periodos anteriores (Q8.1): ' + CONVERT(varchar,getdate(),126)      
    END    
  END

  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, importe_total, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,       EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, importe_total, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFALayoutDocCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                      FROM MFALayoutDocCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin documentos manuales (Q9): ' + CONVERT(varchar,getdate(),126)      
  
  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,   EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAVentaCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                      FROM MFAVentaCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base                       
  PRINT 'Fin documentos ventas (Q10): ' + CONVERT(varchar,getdate(),126)      

  --BUG22544
  IF @ImportarFacturasContado = 1
  BEGIN
     --BUG22833
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,          EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAVentaContadoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFAVentaContadoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin documentos ventas contado (Q10.1): ' + CONVERT(varchar,getdate(),126)      
  END

  --BUG24895
  IF @IncluirNotas = 0
  BEGIN
    --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,  EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANotaCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFANotaCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin documentos notas (Q10.5): ' + CONVERT(varchar,getdate(),126)      
  END
  
  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,    EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACompraCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                      FROM MFACompraCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin documentos compras (Q11): ' + CONVERT(varchar,getdate(),126)      
  
  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,   EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFAGastoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), PorcentajeDeducible
                      FROM MFAGastoCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base                       
  PRINT 'Fin documentos gastos (Q12): ' + CONVERT(varchar,getdate(),126)      
  
  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,          EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxcDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                      FROM MFACxcDocumentoCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base                       
  PRINT 'Fin documentos cxc (Q13): ' + CONVERT(varchar,getdate(),126)      

  --BUG18599
  IF @DINDepositosAnticipados = 1
  BEGIN
    --BUG20353 BUG22460 BUG22833
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                       EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFADineroAnticipadoDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFADineroAnticipadoDocumentoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base                         
    PRINT 'Fin Documentos Deposito Anticipado (Q13.1): ' + CONVERT(varchar,getdate(),126)      
  END
  
  --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
  INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,          EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                    SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxpDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                      FROM MFACxpDocumentoCalc WITH(NOLOCK)
                     WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                       AND periodo   = ISNULL(@periodo, periodo)
                       AND fecha     >= ISNULL(@FechaD, fecha) 
                       AND fecha     <= ISNULL(@FechaA, fecha)
                       --BU22575
                       AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin documentos cxp (Q14): ' + CONVERT(varchar,getdate(),126)      

  --BUG18077
  IF @IFRS = 1 AND @IncluirPolizasNomina = 1
  BEGIN
    --BUG20353 BUG22460 BUG22833
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, EsIFRS, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,             EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, 1,      concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANominaDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFANominaDocumentoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin documentos Nomina (Q14.1): ' + CONVERT(varchar,getdate(),126)        
  END

  --REQ16711
  IF @IncluirNomina = 1
  BEGIN
    --REQ16748 --BUG17507 BUG20353 BUG22460 BUG22833
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,                EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva,                                                 PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFANominaCxpDocumentoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  dbo.fnMFAIEPSIVA(@Empresa, @DefImpuesto, iva_tasa, ieps), 100.0
                        FROM MFANominaCxpDocumentoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin documentos Nomina cxp (Q14.1): ' + CONVERT(varchar,getdate(),126)      
  END  

  --BUG23996
  IF @CxcChequesDevueltosNegativo = 1
  BEGIN
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva, PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxcChequeDevueltoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  0,        100.0
                        FROM MFACxcChequeDevueltoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND empresa = @empresa
    EXEC spShrink_Log @Base      
  
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                    fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcChequeDevueltoCobroCalc', fecha
                          FROM MFACxcChequeDevueltoCobroCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           --BU22575
                           AND empresa = @empresa    
    EXEC spShrink_Log @Base
  END  

  --BUG23996
  IF @CxpChequesDevueltosNegativo = 1
  BEGIN
    INSERT layout_documentos(origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, origen_vista,               EsActivoFijo, TipoActivo, TipoActividad, fecha, BaseIVAImportacion, ieps_iva, PorcentajeDeducible)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, emisor, tipo_documento, subtipo_documento, folio, ejercicio, periodo, dia, entidad_clave, entidad_nombre, entidad_rfc, entidad_id_fiscal, entidad_tipo_tercero, entidad_tipo_operacion, entidad_pais, entidad_nacionalidad, agente_clave, agente_nombre, concepto, acumulable_deducible, importe, retencion_isr, retencion_iva, base_iva, iva_excento, iva_tasa, iva, base_ieps, ieps_tasa, ieps, base_isan, isan, ieps_num_reporte, ieps_categoria_concepto, ieps_exento, ieps_envase_reutilizable, ieps_retencion, ieps_cantidad, ieps_unidad, ieps_cantidad2, ieps_unidad2, importe_total, concepto_clave, concepto_es_importacion, dinero, dinero_id, concepto_aplica_ieps, concepto_aplica_ietu, concepto_aplica_iva, 'MFACxpChequeDevueltoCalc', EsActivoFijo, TipoActivo, TipoActividad, fecha, 0,                  0,        100.0
                        FROM MFACxpChequeDevueltoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND empresa = @empresa
    EXEC spShrink_Log @Base      
     
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                    fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpChequeDevueltoPagoCalc', fecha
                          FROM MFACxpChequeDevueltoPagoCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           --BU22575
                           AND empresa = @empresa    
    EXEC spShrink_Log @Base      
  END    
  
  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,              fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFALayoutAplicacionCalc', fecha
                        FROM MFALayoutAplicacionCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base                       
  PRINT 'Fin aplicaciones manuales (Q15): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,           fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcAplicacionCalc', fecha
                        FROM MFACxcAplicacionCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base                         
  PRINT 'Fin aplicaciones cxc (Q16): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcEndosoCalc', fecha
                        FROM MFACxcEndosoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base                         
  PRINT 'Fin endosos cxc (Q17): ' + CONVERT(varchar,getdate(),126)      

  --BUG18599
  IF @DINDepositosAnticipados = 0
  BEGIN
    --BUG16247 --BUG17507 --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,      fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcCobroCalc', fecha
                          FROM MFACxcCobroCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@CobrosConciliados, conciliado) = conciliado
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin cobros cxc (Q18): ' + CONVERT(varchar,getdate(),126)      
  END
  ELSE
  BEGIN
     --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                   fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcCobroSinAnticipadoCalc', fecha
                          FROM MFACxcCobroSinAnticipadoCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo = ISNULL(@periodo, periodo)
                           AND fecha >= ISNULL(@FechaD, fecha) 
                           AND fecha <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@CobrosConciliados, conciliado) = conciliado
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin cobros cxc (Q18): ' + CONVERT(varchar,getdate(),126)        
  END
  
  --BUG18599
  IF @DINDepositosAnticipados = 1
  BEGIN
    --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                   fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFADineroAnticipadoCobroCalc', fecha
                          FROM MFADineroAnticipadoCobroCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@CobrosConciliados, conciliado) = conciliado
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin cobros cxc (Q18): ' + CONVERT(varchar,getdate(),126)
  END
  
  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,     fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcPagoCalc', fecha
                        FROM MFACxcPagoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base                         
  PRINT 'Fin pagos cxc (Q19): ' + CONVERT(varchar,getdate(),126)      
  
  --BUG22544
  IF @ImportarFacturasContado = 1
  BEGIN
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,              fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFAVentaContadoPagoCalc', fecha
                          FROM MFAVentaContadoPagoCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base
    PRINT 'Fin pagos Ventas Contado  (Q19.1): ' + CONVERT(varchar,getdate(),126)        
  END
  
  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcRedocumentacionCalc', fecha
                        FROM MFACxcRedocumentacionCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin redocumentacion cxc (Q20): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,           fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpAplicacionCalc', fecha
                        FROM MFACxpAplicacionCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin aplicaciones cxp (Q21): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpEndosoCalc', fecha
                        FROM MFACxpEndosoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin endosos cxp (Q22): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,     fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpPagoCalc', fecha
                        FROM MFACxpPagoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND ISNULL(@PagosConciliados, conciliado) = conciliado
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin pagos cxp (Q23): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,      fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpCobroCalc', fecha
                        FROM MFACxpCobroCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND ISNULL(@CobrosConciliados, conciliado) = conciliado
                         --BU22575
                         AND empresa = @empresa 
  EXEC spShrink_Log @Base
  PRINT 'Fin cobros cxp (Q24): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,                fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpRedocumentacionCalc', fecha
                        FROM MFACxpRedocumentacionCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin redocumentacion cxp (Q25): ' + CONVERT(varchar,getdate(),126)      

  --BUG16247 --BUG17507
  --BUG18278
  IF @GASComprobantesPorConcepto = 0
  BEGIN  
     --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFAGastoPagoCalc', fecha
                          FROM MFAGastoPagoCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin GastosComprobante (Q30): ' + CONVERT(varchar,getdate(),126)
  END
  ELSE IF @GASComprobantesPorConcepto = 1
  BEGIN
     --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,               fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFAGastoConceptoPagoCalc', fecha
                          FROM MFAGastoConceptoPagoCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin Gastos Concepto Comprobante (Q30.1): ' + CONVERT(varchar,getdate(),126)  
  END
  
  --BUG16247 --BUG17507 --BUG18767 BUG22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,             fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFAGastoDineroPagoCalc', fecha
                        FROM MFAGastoDineroPagoCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base                         
  PRINT 'Fin Pagos Gastos sin Cxc ni Cxp (Q30.1): ' + CONVERT(varchar,getdate(),126)        

  --BUG16247 --BUG17507 --BUG18767 BU22460
  INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,     fecha)
                      SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACrCobroCalc', fecha
                        FROM MFACrCobroCalc WITH(NOLOCK)
                       WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                         AND periodo   = ISNULL(@periodo, periodo)
                         AND fecha     >= ISNULL(@FechaD, fecha) 
                         AND fecha     <= ISNULL(@FechaA, fecha)
                         --BU22575
                         AND empresa = @empresa
  EXEC spShrink_Log @Base
  PRINT 'Fin cobros notas (Q26): ' + CONVERT(varchar,getdate(),126)      

  --REQ16899
  IF @CxpAnticiposPagadosPeriodo  = 1
  BEGIN
    --BUG17507 --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxpDineroCalc', fecha
                          FROM MFACxpDineroCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin Anticipos Pagados Cxp (Q31): ' + CONVERT(varchar,getdate(),126)        
  END
 
  --REQ16899
  IF @AnticiposPagadosPeriodo  = 1
  BEGIN
    --REQ16670 --BUG17507 --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, origen_vista,       fecha)
                        SELECT origen_tipo, origen_modulo, origen_id, empresa, tipo_aplicacion, folio, ejercicio, periodo, dia, referencia, importe, cuenta_bancaria, aplica_ieps, aplica_ietu, aplica_iva, dinero, dinero_id, tipo_documento, 'MFACxcDineroCalc', fecha
                          FROM MFACxcDineroCalc WITH(NOLOCK)
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           AND ISNULL(@PagosConciliados, conciliado) = conciliado                          
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin Anticipos Pagados Cxp (Q32): ' + CONVERT(varchar,getdate(),126)        
  END
  
  IF @IFRS = 1 AND @IncluirPolizasTesoreria = 1
  BEGIN
    --INSERT layout_aplicaciones (origen_tipo,   origen_modulo,   origen_id,   empresa,   tipo_aplicacion,   folio,   ejercicio,   periodo,   dia,   referencia,   importe,   cuenta_bancaria,   aplica_ieps,   aplica_ietu,   aplica_iva,   dinero,   dinero_id,   EsIFRS, origen_vista)
    --                     SELECT m.origen_tipo, m.origen_modulo, m.origen_id, m.empresa, m.tipo_aplicacion, m.folio, m.ejercicio, m.periodo, m.dia, m.referencia, m.importe, m.cuenta_bancaria, m.aplica_ieps, m.aplica_ietu, m.aplica_iva, m.dinero, m.dinero_id, 1,      'MFADineroCalc'
    --                       FROM MFADineroCalc m
    --                       JOIN layout_documentos d ON m.Empresa = d.Empresa AND m.dinero = d.dinero and m.dinero_id = d.dinero_id
    --                      WHERE m.ejercicio = @ejercicio 
    --                        AND m.periodo = @periodo
                            
    --PRINT 'Fin Polizas Documentos Tesorería (Q33): ' + CONVERT(varchar,getdate(),126)

    --BUG18767 BUG22460
    INSERT layout_aplicaciones(origen_tipo,   origen_modulo,   origen_id,   empresa,   tipo_aplicacion,   folio,   ejercicio,   periodo,   dia,   referencia,   importe,   cuenta_bancaria,   aplica_ieps,   aplica_ietu,   aplica_iva,     dinero,   dinero_id,   EsIFRS, tipo_documento, origen_vista,  fecha)
                        SELECT m.origen_tipo, m.origen_modulo, m.origen_id, m.empresa, m.tipo_aplicacion, m.folio, m.ejercicio, m.periodo, m.dia, m.referencia, m.importe, m.cuenta_bancaria, m.aplica_ieps, m.aplica_ietu, m.aplica_iva, m.dinero, m.dinero_id, 1,      tipo_documento, 'MFADineroCalc', fecha
                          FROM MFADineroCalc m WITH(NOLOCK)
                           --JOIN layout_aplicaciones d ON m.Empresa = d.Empresa AND m.dinero = d.dinero and m.dinero_id = d.dinero_id
                         WHERE ejercicio = ISNULL(@ejercicio, Ejercicio) 
                           AND periodo   = ISNULL(@periodo, periodo)
                           AND fecha     >= ISNULL(@FechaD, fecha) 
                           AND fecha     <= ISNULL(@FechaA, fecha)
                           --BU22575
                           AND empresa = @empresa
    EXEC spShrink_Log @Base                           
    PRINT 'Fin Polizas Aplicaciones Tesorería (Q33): ' + CONVERT(varchar,getdate(),126)    
  END

  --BU22575  
  EXEC spInsertarLayoutAplicacionEntidad @Empresa
  EXEC spShrink_Log @Base  
  
  PRINT 'Fin cobros notas (Q26.5): ' + CONVERT(varchar,getdate(),126)

  --BU22575
  EXEC spMFAAplicacionesAgregarAplicacionCuenta @Empresa

  --BUG22558
  IF @IFRS = 1
  BEGIN
    --BU22575
    EXEC spMFAContBalanzaCfg @Empresa, @Ejercicio, @Periodo, @FechaD, @FechaA
    EXEC spShrink_Log @Base
  END
  
  --BU22575
  EXEC spMFADocumentosAgregarDocumentoCuenta @IFRS, @IncluirPolizasEspecificas, @Empresa
  
  /*
  EXEC spMFADocumentosAgregarCuenta
  
  PRINT 'Fin agregar cuenta (Q26.5): ' + CONVERT(varchar,getdate(),126)                                      
  */

  --BU22575  
  EXEC sp_layout_importar_aplicaciones @usuario, @Empresa
  EXEC spShrink_Log @Base  
  
  PRINT 'Fin importar aplicaciones (Q27): ' + CONVERT(varchar,getdate(),126)      
  
  --BU22575  
  EXEC sp_layout_importar_documentos @usuario, @Empresa
  EXEC spShrink_Log @Base  
  
  PRINT 'Fin importar documentos (Q28): ' + CONVERT(varchar,getdate(),126)        

  --BUG22460 BU22575 BUG22575
  EXEC @log_id = sp_layout_procesar @Usuario, @Empresa, @Ejercicio, @Periodo, 'flujo', @FechaD, @FechaA, @IFRS, @ValidarReferencias 
  EXEC spShrink_Log @Base    
  
  PRINT 'Fin procesamiento (Q29): ' + CONVERT(varchar,getdate(),126)        
    
  IF @EnSilencio = 0
  BEGIN
    SELECT * FROM layout_log WHERE log_id = @log_id
    SELECT * FROM layout_logd WHERE log_id = @log_id
  END

  RETURN @log_id
END
GO

--BUG22575
/*********** spMFALayoutEmpresaImportar ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutEmpresaImportar') and type = 'P') drop procedure dbo.spMFALayoutEmpresaImportar
GO
CREATE PROCEDURE spMFALayoutEmpresaImportar
		   @Usuario				varchar(20),
		   @Empresa				varchar(5),
		   @Ejercicio			int,
		   @Periodo				int,
		   --BUG22460
		   @FechaD				datetime,
		   @FechaA				datetime,
		   @Ok					int			 = NULL OUTPUT,
		   @OkRef				varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  DECLARE @OkDesc			varchar(255),
		  @OkTipo			varchar(50),
		  @EmpresaAux		varchar(5),
		  @EmpresaAuxAnt	varchar(5)

  IF YEAR(@FechaD) = 1899 SELECT @FechaD = NULL
  IF YEAR(@FechaA) = 1899 SELECT @FechaA = NULL
  
  IF @Ejercicio IS NOT NULL OR @Periodo IS NOT NULL
    SELECT @FechaD = NULL, @FechaA = NULL

  SELECT @Empresa = NULLIF(RTRIM(UPPER(@Empresa)), '')
  
  IF @Ok IS NULL AND @Ejercicio IS NOT NULL AND @Periodo IS NULL
    SELECT @Ok = 10385
  IF @Ok IS NULL AND @Periodo IS NOT NULL AND @Ejercicio IS NULL
    SELECT @Ok = 10050
  IF @Ok IS NULL AND @Ejercicio IS NULL AND @Periodo IS NULL AND (@FechaD IS NULL OR @FechaA IS NULL)
    SELECT @Ok = 55090
  IF @Ok IS NOT NULL AND @Empresa IS NOT NULL AND NOT EXISTS(SELECT Empresa FROM Empresa WHERE Empresa = @Empresa)
    SELECT @Ok = 26070, @OkRef = UPPER(@Empresa)

  IF @Ok IS NULL
  BEGIN
    SELECT @EmpresaAuxAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @EmpresaAux = MIN(Empresa)
        FROM EmpresaMFA
       WHERE Empresa > @EmpresaAuxAnt
         AND Empresa = ISNULL(@Empresa, Empresa)
      
      IF @EmpresaAux IS NULL BREAK
      
      SELECT @EmpresaAuxAnt = @EmpresaAux

      EXEC spMFALayoutImportar @Usuario, @EmpresaAux, @Ejercicio, @Periodo, @FechaD = @FechaD, @FechaA = @FechaA, @EnSilencio = 1
    END
  END

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok

  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL  
END
GO

--REQ23317
/*********** spMFALayoutEmpresaCuentasImportar ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutEmpresaCuentasImportar') and type = 'P') drop procedure dbo.spMFALayoutEmpresaCuentasImportar
GO
CREATE PROCEDURE spMFALayoutEmpresaCuentasImportar
		   @Usuario				varchar(20),
		   @Empresa				varchar(5),
		   @Ejercicio			int,
		   @Periodo				int,
		   @Ok					int			 = NULL OUTPUT,
		   @OkRef				varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  SET NOCOUNT ON
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

  DECLARE @OkDesc			varchar(255),
		  @OkTipo			varchar(50),
		  @EmpresaAux		varchar(5),
		  @EmpresaAuxAnt	varchar(5)

  SELECT @Empresa = NULLIF(RTRIM(UPPER(@Empresa)), '')
  
  IF @Ok IS NULL AND @Periodo IS NULL
    SELECT @Ok = 10385
  IF @Ok IS NULL AND @Ejercicio IS NULL
    SELECT @Ok = 10050
    
  IF @Ok IS NULL
  BEGIN
    SELECT @EmpresaAuxAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @EmpresaAux = MIN(Empresa)
        FROM EmpresaMFA
       WHERE Empresa > @EmpresaAuxAnt
         AND Empresa = ISNULL(@Empresa, Empresa)
      
      IF @EmpresaAux IS NULL BREAK
      
      SELECT @EmpresaAuxAnt = @EmpresaAux

      EXEC spMFALayoutImportar_Cuentas @Usuario, @EmpresaAux, @Ejercicio, @Periodo, @EnSilencio = 1
    END
  END

  IF @Ok IS NULL 
    SELECT @OkRef = NULL
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok

  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL  
END
GO

--BUG22460
/*********** spMFALayoutImportarFecha ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutImportarFecha') and type = 'P') drop procedure dbo.spMFALayoutImportarFecha
GO
CREATE PROCEDURE spMFALayoutImportarFecha
		   @Usuario						varchar(20),
		   @Empresa						varchar(5),
		   @FechaD						datetime	= NULL,
		   @FechaA						datetime	= NULL
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE @log_id		int
  
  EXEC @log_id = spMFALayoutImportar @Usuario, @Empresa, @Ejercicio = NULL, @Periodo = NULL, @FechaD = @FechaD, @FechaA = @FechaA, @EnSilencio = 1

  IF EXISTS(SELECT * FROM layout_logd where log_id  = @log_id )
    SELECT 'Referencias Inválidas.'
  ELSE
    SELECT 'Proceso Concluido.'  
END
GO

--BUG21567
/*********** spMFACuentasComplementarias ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFACuentasComplementarias') and type = 'P') drop procedure dbo.spMFACuentasComplementarias
GO
CREATE PROCEDURE spMFACuentasComplementarias
		   @Usuario				varchar(20),
		   @Empresa				varchar(5),
		   @Ejercicio			int,
		   @Periodo				int
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE @Cuenta			varchar(20),
		  @CuentaAnt		varchar(20),
		  --BUG23552
		  @Cuenta2			varchar(50),
		  @Cuenta3			varchar(50),
		  @CuentaComp		varchar(50),
		  @ContMoneda		varchar(10),
		  @Moneda			varchar(10),
		  @EjercicioAnt		int,
		  @EjercicioResp	int,
		  @Cargos			float,
		  @Abonos			float,
		  @Cargos2			float,
		  @Abonos2			float,
		  @Cargos3			float,
		  @Abonos3			float,
		  @SI2				float,
		  @SI3				float,
		  @SIC2				float,
		  @SIC3				float,
		  @SID2				float,
		  @SID3				float		  

  SELECT @EjercicioResp = @Ejercicio

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa		  
  
  SELECT @CuentaAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Cuenta = MIN(Cuenta)
      FROM MFACuentaComplementaria
     WHERE Cuenta > @CuentaAnt
       --BUG24031
       AND Empresa = @Empresa

    IF @Cuenta IS NULL BREAK
    
    SELECT @CuentaAnt = @Cuenta, @Moneda = NULL
    
    SELECT @Cuenta2 = @Cuenta + '-001', @CuentaComp = @Cuenta + '-002', @Cuenta3 = @Cuenta + '-003'
    
    SELECT @Moneda = Moneda FROM MFACuentaComplementaria WHERE Cuenta = @Cuenta
    
    EXEC spMFAContAcum @Cuenta = @Cuenta
  END
  
  SELECT @EjercicioAnt = MIN(Ejercicio) - 2 FROM Acum
  WHILE(1=1)
  BEGIN
    SELECT @Ejercicio = MIN(Ejercicio)
      FROM Acum
     WHERE Ejercicio > @EjercicioAnt
     
    IF @Ejercicio IS NULL BREAK
    
    SELECT @EjercicioAnt = @Ejercicio
    
    SELECT @Ejercicio = @Ejercicio + 1
    
    EXEC spMFAContTraspasarSaldos @Empresa, @Ejercicio
  END  
  
  SELECT @Ejercicio = @EjercicioResp
  
  SELECT @CuentaAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Cuenta = MIN(Cuenta)
      FROM MFACuentaComplementaria
     WHERE Cuenta > @CuentaAnt
       --BUG24031
       AND Empresa = @Empresa
    
    IF @Cuenta IS NULL BREAK
    SELECT @CuentaAnt = @Cuenta, @Moneda = NULL
    
    SELECT @Cuenta2 = @Cuenta + '-001', @CuentaComp = @Cuenta + '-002', @Cuenta3 = @Cuenta + '-003'
    
    SELECT @Moneda = Moneda FROM MFACuentaComplementaria WHERE Cuenta = @Cuenta
    
    --BUG22473 BUG24031
    DELETE layout_polizas WHERE cuenta_contable IN(@Cuenta2, @CuentaComp, @Cuenta3) AND Empresa = @Empresa
    DELETE layout_cuentas WHERE cuenta_contable IN(@Cuenta2, @CuentaComp, @Cuenta3) AND Empresa = @Empresa

    SELECT @Cargos = 0, @Abonos = 0
    SELECT @Cargos = SUM(Cargos1), @Abonos = SUM(Abonos1)
      FROM MFAPolizaComp
     WHERE ejercicio = @ejercicio
       AND periodo   = @periodo
       AND cuenta_contable = @Cuenta
       --BUG24031
       AND empresa = @Empresa

    SELECT @Cargos2 = 0, @Abonos2 = 0
    SELECT @Cargos2 = SUM(Cargos), @Abonos2 = SUM(Abonos)
      FROM MFAPolizaComp
     WHERE ejercicio = @ejercicio
       AND periodo   = @periodo
       AND cuenta_contable = @Cuenta
       AND OrigenMoneda = @Moneda
       --BUG24031
       AND empresa = @Empresa
                  
    --BUG22460
    --Insertamos la cuenta en dolares
    INSERT layout_polizas (
			    empresa,  ejercicio,  periodo,  cuenta_contable, cargos,              abonos,              EsComplementaria)
        SELECT @empresa, @ejercicio, @periodo, @Cuenta2,         ISNULL(@cargos2, 0), ISNULL(@abonos2, 0), 1

    SELECT @Cargos3 = 0, @Abonos3 = 0
    SELECT @Cargos3 = SUM(Cargos), @Abonos3 = SUM(Abonos)
      FROM MFAPolizaComp
     WHERE ejercicio = @ejercicio
       AND periodo   = @periodo
       AND cuenta_contable = @Cuenta
       AND OrigenMoneda = @ContMoneda
       --BUG24031
       AND empresa = @Empresa

    --Insertamos la cuenta en pesos
    INSERT layout_polizas (
			    empresa,  ejercicio,  periodo,  cuenta_contable, cargos,              abonos,              EsComplementaria)
        SELECT @empresa, @ejercicio, @periodo, @Cuenta3,         ISNULL(@cargos3, 0), ISNULL(@Abonos3, 0), 1
        
    SELECT @SI2  = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @Moneda, ''),
           @SI3  = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @ContMoneda, ''),

           @SIC2 = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @Moneda, 'Cargos'),
           @SID2 = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @Moneda, 'Abonos'),
                      
           @SIC3 = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @ContMoneda, 'Cargos'),
           @SID3 = dbo.fnMFACuentaSaldoInicialComp(@Empresa,@Ejercicio,@Periodo,@Cuenta, @ContMoneda, 'Abonos')

    INSERT layout_cuentas (
			    empresa,  cuenta_contable,  cuenta_control, descripcion, nivel, clase_cuenta, tipo_cuenta, ejercicio,  saldo_inicial,  moneda, EsComplementaria,  saldo_inicial_cargos,  saldo_inicial_abonos)
        SELECT @empresa, @Cuenta2,         @Cuenta,         descripcion, 4,     clase_cuenta, tipo_cuenta, @ejercicio, @SI2,          @Moneda, 1,                @SIC2,                 @SID2
          FROM layout_cuentas a
         WHERE cuenta_contable = @Cuenta
           --BUG24031
           AND empresa = @Empresa

    INSERT layout_cuentas (
			    empresa,  cuenta_contable,  cuenta_control, descripcion, nivel, clase_cuenta, tipo_cuenta, ejercicio,  saldo_inicial,  moneda,     EsComplementaria,  saldo_inicial_cargos,  saldo_inicial_abonos)  
        SELECT @empresa, @Cuenta3,         @Cuenta,         descripcion, 4,     clase_cuenta, tipo_cuenta, @ejercicio, @SI3,          @ContMoneda, 1,                @SIC3,                 @SID3
          FROM layout_cuentas a
         WHERE cuenta_contable = @Cuenta
           --BUG24031
           AND empresa = @Empresa
           
    --BUG22460
    --Insertamos la cuenta complementaria
    INSERT layout_polizas (
			     empresa,   ejercicio,   periodo,  cuenta_contable, cargos,                                                         abonos,                                                           fecha, EsComplementaria)
        SELECT a.empresa, a.ejercicio, a.periodo, @CuentaComp,      ISNULL(@Cargos, 0) - ISNULL(@Cargos2, 0) - ISNULL(@Cargos3, 0), ISNULL(@Abonos, 0) - ISNULL(@Abonos2, 0) - ISNULL(@Abonos3, 0), a.fecha, 1
          FROM layout_polizas a
         WHERE a.ejercicio = @ejercicio
           AND a.periodo   = @periodo
           AND a.cuenta_contable = @Cuenta  
           --BUG24031
           AND a.empresa = @Empresa
           
    INSERT layout_cuentas(
			    empresa,  cuenta_contable,  cuenta_control,   descripcion, nivel,   clase_cuenta,   tipo_cuenta,  ejercicio, saldo_inicial,                                                   moneda,     EsComplementaria,  saldo_inicial_cargos,                                                    saldo_inicial_abonos)  
        SELECT @empresa, @CuentaComp,      @Cuenta,         a.descripcion, 4,     a.clase_cuenta, a.tipo_cuenta, @ejercicio, ISNULL(a.saldo_inicial, 0) - ISNULL(@SI2, 0) - ISNULL(@SI3, 0), @ContMoneda, 1,                 ISNULL(a.saldo_inicial_cargos, 0) - ISNULL(@SIC2, 0) - ISNULL(@SIC3, 0), ISNULL(a.saldo_inicial_abonos, 0) - ISNULL(@SID2, 0) - ISNULL(@SID3, 0)
          FROM layout_cuentas a
         WHERE a.ejercicio = @ejercicio
           AND a.cuenta_contable = @Cuenta  
           --BUG24031
           AND a.empresa = @Empresa

    --BUG24031
    UPDATE layout_cuentas SET clase_cuenta = 'control' WHERE cuenta_contable = @cuenta AND empresa = @Empresa
  END
  
  RETURN
END
GO

--REQ23317
/*********** spMFASIALayoutImportar_Cuentas ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFASIALayoutImportar_Cuentas') and type = 'P') drop procedure dbo.spMFASIALayoutImportar_Cuentas
GO
CREATE PROCEDURE spMFASIALayoutImportar_Cuentas
		   @Usuario					varchar(20),
		   @Empresa					varchar(5),
		   @Ejercicio				int,
		   @Periodo					int,
		   --BUG24598
		   @SIABaseIndependiente	bit,
		   @SIABaseDatos			varchar(255)		   
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  DECLARE @Moneda		varchar(10),
          --BUG24598
		  @SQL			nvarchar(max),
		  @BaseDatos	varchar(255),
		  @Parametros	nvarchar(max)

  SELECT @BaseDatos = DB_NAME()
  
  IF @SIABaseIndependiente = 0 SELECT @SIABaseDatos = DB_NAME()
  
  SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa  
  
  SELECT @Parametros = '@Empresa	varchar(5),
						@Ejercicio	int,
						@Periodo	int'

  SELECT @SQL = 'DELETE ' + @SIABaseDatos + '.dbo.tmpPolizas WHERE ID_empresa = @Empresa AND Ejercicio = @Ejercicio AND Periodo = @Periodo'
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa, @Ejercicio = @Ejercicio, @Periodo = @Periodo
  
  SELECT @SQL = 'DELETE ' + @SIABaseDatos + '.dbo.tmpSaldo_Inicial WHERE ID_empresa = @Empresa AND Ejercicio = @Ejercicio AND Periodo = @Periodo'
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa, @Ejercicio = @Ejercicio, @Periodo = @Periodo  
  
  SELECT @Parametros = '@Empresa	varchar(5)'

  SELECT @SQL = 'DELETE ' + @SIABaseDatos + '.dbo.tmpEmpresas WHERE ID_empresa = @Empresa'
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa
  
  SELECT @SQL = 'DELETE ' + @SIABaseDatos + '.dbo.tmpContactos WHERE ID_empresa = @Empresa'
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa
    
  SELECT @SQL = 'DELETE ' + @SIABaseDatos + '.dbo.tmpCuentas_Contables WHERE ID_empresa = @Empresa'
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa
  
  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpEmpresas(
		                  ID_empresa, Nombre, Grupo, Direccion, DireccionNumero, DireccionNumeroInt, Clave_ciudad, CodigoPostal, Telefonos, RFC)
	               SELECT ID_empresa, Nombre, Grupo, Direccion, DireccionNumero, DireccionNumeroInt, Clave_ciudad, CodigoPostal, Telefonos, RFC
	                 FROM ' + @BaseDatos + '.dbo.MFAEmpresa 
	                WHERE ID_empresa = @Empresa'
	                
  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa

  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpContactos(
		                  Clave, Nombres, Apellidos, Puesto, Telefono, Email, ID_empresa)
	               SELECT Clave, Nombres, Apellidos, Puesto, Telefono, Email, @Empresa
	                 FROM MFAContacto'

  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa

  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpCuentas_Contables(
		                  ID_empresa, Cuenta_contable, Cuenta_control, Descripcion, Clase_cuenta, Moneda, Estatus, ID_impuesto)
	               SELECT Empresa,    Cuenta_contable, Cuenta_control, Descripcion, Clase_cuenta, Moneda, Estatus, ''''
	                 FROM MFACuentaContable
	                WHERE Empresa = @Empresa'

  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa
  
  SELECT @Parametros = '@Empresa	varchar(5),
						@Ejercicio	int,
						@Periodo	int'

  --BUG24986
  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpPolizas(
                          ID_empresa, Cuenta_contable, Ejercicio, Periodo, Debe, Haber, Tipo_moneda, Tipo_cambio, ID_concepto, ID_recordatorio, Referencia, Origen_modulo)		                  
	               SELECT Empresa,    Cuenta_contable, Ejercicio, Periodo, Debe, Haber, Tipo_moneda, Tipo_cambio, ID_concepto, ID_recordatorio, Referencia, Origen_modulo
	                 FROM MFAPolizas
	                WHERE Empresa = @Empresa	 
	                  AND Ejercicio = @Ejercicio
	                  AND Periodo = @Periodo'

  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa, @Ejercicio = @Ejercicio, @Periodo = @Periodo

  SELECT @Parametros = '@Empresa	varchar(5),
						@Ejercicio	int,
						@Periodo	int,
						@Moneda		varchar(10)'

  --BUG25726
  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpSaldo_Inicial(
		                  ID_empresa, Cuenta_contable, Ejercicio,   Periodo, Saldo_inicial_debe,                                                                                                                                                                                                     Saldo_inicial_haber)
	              SELECT @Empresa,    Cuenta,          @Ejercicio, @Periodo, CASE EsAcreedora WHEN 0 THEN dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo,Cuenta, @Moneda, ''Cargos'') - dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo, Cuenta, @Moneda, ''Abonos'') ELSE 0 END, CASE EsAcreedora WHEN 1 THEN dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo,Cuenta, @Moneda, ''Cargos'') - dbo.fnMFACuentaSaldoInicial(@Empresa,@Ejercicio,@Periodo, Cuenta, @Moneda, ''Abonos'') ELSE 0 END
                    FROM MFASaldoInicial'

  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa, @Ejercicio = @Ejercicio, @Periodo = @Periodo, @Moneda = @Moneda

  SELECT @Parametros = '@Empresa	varchar(5),
						@Ejercicio	int,
						@Periodo	int'
  
  SELECT @SQL = 'INSERT INTO ' + @SIABaseDatos + '.dbo.tmpSaldo_Inicial( 
		                  ID_empresa, Cuenta_contable,  Ejercicio,  Periodo, Saldo_inicial_debe,   Saldo_inicial_haber)
	              SELECT @Empresa,    cuenta_contable, @Ejercicio, @Periodo, saldo_inicial_cargos, saldo_inicial_abonos
                    FROM MFASaldoInicialComp'

  EXEC sp_executesql @SQL, @Parametros, @Empresa = @Empresa, @Ejercicio = @Ejercicio, @Periodo = @Periodo
  
END
GO

--BUG26056
/*********** spMFALayoutImportar_CostoVentas ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutImportar_CostoVentas') and type = 'P') drop procedure dbo.spMFALayoutImportar_CostoVentas
GO
CREATE PROCEDURE spMFALayoutImportar_CostoVentas
		   @Usuario			varchar(20),
		   @Empresa			varchar(5),
		   @Ejercicio		int,
		   @Periodo			int
--//WITH ENCRYPTION
AS BEGIN
  DELETE Layout_CostoMovs WHERE Empresa = @Empresa AND Ejercicio = @Ejercicio AND Periodo = @Periodo
  
  INSERT INTO Layout_CostoMovs(
		     Empresa,   Sucursal,   Centro,    Cve_almacen,  Descr_almacen, Tipo_movimiento, es_importacion, es_relacionada, es_deducible,   Num_documento,   Ejercicio,   Periodo, Dia,                   Unidad,   Cantidad, Importe,                                                                                    Material,     Descr_material, CatAlmacen,                 Fecha)
    SELECT e.Empresa, e.Sucursal, e.ContUso, e.Almacen,    a.Nombre,        'Otros',         0,              0,              1,            e.MovID,         e.Ejercicio, e.Periodo, DAY(e.FechaEmision), d.Unidad, d.Cantidad, CASE WHEN MovTipo.Clave IN('INV.S') THEN -d.Cantidad*d.Costo ELSE d.Cantidad*d.Costo END, d.Articulo, Art.Descripcion1,   ISNULL(a.Categoria, ''),  e.FechaEmision
     FROM Inv e   WITH(NOLOCK)
     JOIN InvD d  WITH(NOLOCK) ON e.ID = d.ID
     JOIN Alm a   WITH(NOLOCK) ON e.Almacen = a.Almacen
     JOIN Art     WITH(NOLOCK) ON d.Articulo = Art.Articulo
     JOIN MovTipo WITH(NOLOCK) ON e.Mov = MovTipo.Mov AND MovTipo.Modulo = 'INV'
     JOIN MovTipoMFACostoVenta WITH(NOLOCK) ON e.Mov = MovTipoMFACostoVenta.Mov AND MovTipoMFACostoVenta.Modulo = 'INV'
    WHERE e.Empresa = @Empresa 
      AND e.Ejercicio = @Ejercicio
      AND e.Periodo = @Periodo
      AND e.Estatus IN('PENDIENTE', 'CONCLUIDO')

  INSERT INTO Layout_CostoMovs(
		     Empresa,   Sucursal,   Centro,    Cve_almacen,  Descr_almacen, Tipo_movimiento, es_importacion,                                      es_relacionada, es_deducible,   Num_documento,   Ejercicio,   Periodo, Dia,                   Unidad,   Cantidad, Importe,                                                                               Material,     Descr_material, CatAlmacen,                 Fecha)
    SELECT e.Empresa, e.Sucursal, e.ContUso, e.Almacen,    a.Nombre,        'Compras',       CASE MovTipo.Clave WHEN 'COMS.EI' THEN 1 ELSE 0 END, 0,              1,            e.MovID,         e.Ejercicio, e.Periodo, DAY(e.FechaEmision), e.Unidad, e.Cantidad, CASE WHEN MovTipo.Clave IN('COMS.B', 'COMS.D') THEN -e.SubTotal ELSE e.SubTotal END, e.Articulo, Art.Descripcion1,   ISNULL(a.Categoria, ''),  e.FechaEmision
     FROM CompraTCalc e
     JOIN Alm a      WITH(NOLOCK) ON e.Almacen = a.Almacen
     JOIN Art        WITH(NOLOCK) ON e.Articulo = Art.Articulo
     JOIN MovTipo    WITH(NOLOCK) ON e.Mov = MovTipo.Mov AND MovTipo.Modulo = 'COMS'
     JOIN MovTipoMFACostoVenta WITH(NOLOCK) ON e.Mov = MovTipoMFACostoVenta.Mov AND MovTipoMFACostoVenta.Modulo = 'COMS'
    WHERE e.Empresa = @Empresa 
      AND e.Ejercicio = @Ejercicio
      AND e.Periodo = @Periodo      
      AND e.Estatus IN('PENDIENTE', 'CONCLUIDO')      

  EXEC sp_layout_importar_costomovs @Usuario, @Empresa, @Ejercicio

  RETURN
END
GO

/*********** spMFALayoutImportar_Cuentas ***********/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutImportar_Cuentas') and type = 'P') drop procedure dbo.spMFALayoutImportar_Cuentas
GO
CREATE PROCEDURE spMFALayoutImportar_Cuentas
		   @Usuario			varchar(20),
		   @Empresa			varchar(5),
		   @Ejercicio		int,
		   @Periodo			int,
		   --REQ23317
		   @EnSilencio		bit			= 0
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE
    @cmd					varchar(8000),    
    @with					varchar(255),
    @moneda					varchar(10),
    @PeriodoInicial			int,
    @EjercicioInicial		int,
    @log_id					int,
    --REQ23317
    @ExportarSIA			bit,
    --BUG24598
    @SIABaseIndependiente	bit,
    @SIABaseDatos			varchar(255)
    
  SELECT @usuario = UPPER(@usuario)
  
  --REQ23317
  SELECT @PeriodoInicial = PeriodoInicial, @EjercicioInicial = EjercicioInicial, @ExportarSIA = ISNULL(ExportarSIA, 0), @SIABaseDatos = SIABaseDatos FROM EmpresaMFA WHERE Empresa = @Empresa
  
  SELECT @moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  TRUNCATE TABLE layout_polizas  

  --BUG22473
  INSERT layout_polizas(empresa, ejercicio, periodo, cuenta_contable, cargos, abonos)
                 SELECT empresa, ejercicio, periodo, cuenta_contable, cargos, abonos
                   FROM MFAPoliza
                  WHERE ejercicio = @ejercicio
                    AND periodo   = @periodo

  --BUG19206
  EXEC spMFACuentasContablesSaldo @empresa, @ejercicio, @periodo, @moneda
  
  --BUG21567
  EXEC spMFACuentasComplementarias @Usuario, @Empresa, @Ejercicio, @Periodo

  EXEC sp_layout_importar_cuentas @usuario
  
  --BUG22460
  EXEC sp_layout_importar_polizas @usuario

  EXEC @log_id = sp_layout_procesar @Usuario, @Empresa, @Ejercicio, @Periodo, 'contabilidad'                        

  --REQ23317
  IF @EnSilencio = 0
  BEGIN
    SELECT * FROM layout_log WHERE log_id = @log_id
    SELECT * FROM layout_logd WHERE log_id = @log_id
  END  
   
  --REQ23317 BUG24598
  IF @ExportarSIA = 1
    EXEC spMFASIALayoutImportar_Cuentas @Usuario, @Empresa, @Ejercicio, @Periodo, @SIABaseIndependiente, @SIABaseDatos

  EXEC spMFALayoutImportar_CostoVentas @Usuario, @Empresa, @Ejercicio, @Periodo
		       
  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepAp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepAp') and type = 'P') drop procedure dbo.spMFALayoutDExcepAp
GO
CREATE PROC spMFALayoutDExcepAp
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@aplicacion_MovTipo			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255)
  
  SELECT @TablaExcepcion = dbo.fnMFATablaExcepcion(@origen_vista, @aplicacion_MovTipo)

  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Origen, '') + '''' + CHAR(13) + CHAR(10)
 
  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM '+ @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Origen, '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, Mov, OrigenTipo, Origen) VALUES(''' + ISNULL(@aplicacion_origen_modulo, '') + ''', ''' + ISNULL(@aplicacion_Mov, '') + ''', ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''', ''' + ISNULL(@aplicacion_Origen, '') + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepDoc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepDoc') and type = 'P') drop procedure dbo.spMFALayoutDExcepDoc
GO
CREATE PROC spMFALayoutDExcepDoc
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255),
		  @aplicacion_Aplica	varchar(20)

  SELECT @aplicacion_Aplica = dbo.fnMovEnReferencia(@referencia)
  
  SELECT @TablaExcepcion = 'MovTipoMFADocExcepcion'

  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Aplica, '') + '''' + CHAR(13) + CHAR(10)

  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Aplica, '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, Mov) VALUES(''' + ISNULL(@aplicacion_origen_modulo, '') + ''', ''' + ISNULL(@aplicacion_Aplica, '') + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepApEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepApEsp') and type = 'P') drop procedure dbo.spMFALayoutDExcepApEsp
GO
CREATE PROC spMFALayoutDExcepApEsp
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255)
  
  SELECT @TablaExcepcion = 'MFAMovExcepcion'
  
  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND ModuloID = ''' + ISNULL(CONVERT(varchar, @aplicacion_origen_id), '') + '''' + CHAR(13) + CHAR(10)
  
  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND ModuloID = ''' + ISNULL(CONVERT(varchar, @aplicacion_origen_id), '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL  + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, ModuloID) VALUES(''' + ISNULL(CONVERT(varchar, @aplicacion_origen_modulo), '') + ''', ''' + ISNULL(CONVERT(varchar, @aplicacion_origen_id), '') + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDAgregarDocumento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDAgregarDocumento') and type = 'P') drop procedure dbo.spMFALayoutDAgregarDocumento
GO
CREATE PROC spMFALayoutDAgregarDocumento
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255),
		  @DocumentoTipo		varchar(50),
		  @aplicacion_Aplica	varchar(20)

  SELECT @aplicacion_Aplica = dbo.fnMovEnReferencia(@referencia)

  IF @Accion = 'A-Agregar Anticipo'
    SELECT @DocumentoTipo = 'anticipo'
  ELSE IF @Accion = 'B-Agregar Comp. Gasto'
    SELECT @DocumentoTipo = 'comprobante_gasto'
  ELSE IF @Accion = 'C-Agregar Factura'
    SELECT @DocumentoTipo = 'factura'
  ELSE IF @Accion = 'D-Agregar Nota Cargo'
    SELECT @DocumentoTipo = 'nota_cargo'
  ELSE IF @Accion = 'E-Agregar Nota Credito'
    SELECT @DocumentoTipo = 'nota_credito'
  ELSE IF @Accion = 'F-Agregar Devolucion'
    SELECT @DocumentoTipo = 'devolucion'
  ELSE IF @Accion = 'G-Agregar Prestamo'  
    SELECT @DocumentoTipo = 'prestamo'
  
  SELECT @TablaExcepcion = 'MovTipoMFADocAdicion'
  
  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(CONVERT(varchar, @aplicacion_Aplica), '') + '''' + CHAR(13) + CHAR(10)
  
  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM '+ @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(CONVERT(varchar, @aplicacion_Aplica), '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, Mov, DocumentoTipo) VALUES(''' + ISNULL(CONVERT(varchar, @aplicacion_origen_modulo), '') + ''', ''' + ISNULL(CONVERT(varchar, @aplicacion_Aplica), '') + ''', ''' + @DocumentoTipo + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDAplicacionCambio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDAplicacionCambio') and type = 'P') drop procedure dbo.spMFALayoutDAplicacionCambio
GO
CREATE PROC spMFALayoutDAplicacionCambio
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255),
		  @TipoAplicacion		varchar(50)

  IF @Accion = 'H-Cambiar a Aplicacion'
    SELECT @TipoAplicacion = 'aplicacion'
  ELSE IF @Accion = 'I-Cambiar a Cobro'
    SELECT @TipoAplicacion = 'cobro'  
  ELSE IF @Accion = 'J-Cambiar a Endoso'
    SELECT @TipoAplicacion = 'endoso'  
  ELSE IF @Accion = 'K-Cambiar a Pago'
    SELECT @TipoAplicacion = 'pago'  
  ELSE IF @Accion = 'L-Cambiar a Redoc.'
    SELECT @TipoAplicacion = 'redocumentacion'  

  SELECT @TablaExcepcion = 'MovTipoMFAAplicacionCambio'
  
  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Origen, '') + '''' + CHAR(13) + CHAR(10)

  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM '+ @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Origen, '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, Mov, OrigenTipo, Origen, TipoAplicacion) VALUES(''' + ISNULL(@aplicacion_origen_modulo, '') + ''', ''' + ISNULL(@aplicacion_Mov, '') + ''', ''' + ISNULL(@aplicacion_OrigenTipo, '') + ''', ''' + ISNULL(@aplicacion_Origen, '') + ''', ''' + @TipoAplicacion + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepReporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepReporte') and type = 'P') drop procedure dbo.spMFALayoutDExcepReporte
GO
CREATE PROC spMFALayoutDExcepReporte
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255),
		  @AplicaIetu			varchar(2),
		  @AplicaIeps			varchar(2),
		  @AplicaIVA			varchar(2),
		  @aplicacion_Aplica	varchar(20)

  SELECT @aplicacion_Aplica = dbo.fnMovEnReferencia(@referencia)
  
  IF @Accion = 'Q-Excep. Reporte'
    SELECT @AplicaIetu = 'No', @AplicaIeps = 'No', @AplicaIVA = 'No'
  ELSE IF @Accion = 'R-Excep. Reporte IEPS'
    SELECT @AplicaIetu = 'Si', @AplicaIeps = 'No', @AplicaIVA = 'Si'  
  ELSE IF @Accion = 'S-Excep. Reporte IETU'
    SELECT @AplicaIetu = 'No', @AplicaIeps = 'Si', @AplicaIVA = 'Si'
  ELSE IF @Accion = 'T-Excep. Reporte IVA'
    SELECT @AplicaIetu = 'Si', @AplicaIeps = 'Si', @AplicaIVA = 'No'
      
  SELECT @TablaExcepcion = 'MovTipoMFAAplicaReporteExcepcion'
  
  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Aplica, '') + '''' + CHAR(13) + CHAR(10)
  
  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM '+ @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Mov = ''' + ISNULL(@aplicacion_Mov, '') + ''' AND OrigenTipo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND Origen = ''' + ISNULL(@aplicacion_Aplica, '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, Mov, OrigenTipo, Origen, AplicaIetu, AplicaIeps, AplicaIVA) VALUES(''' + ISNULL(@aplicacion_origen_modulo, '') + ''', ''' + ISNULL(@aplicacion_Mov, '') + ''', ''' + ISNULL(@aplicacion_origen_modulo, '') + ''', ''' + ISNULL(@aplicacion_Aplica, '') + ''', ''' + @AplicaIetu + ''', ''' + @AplicaIeps + ''', ''' + @AplicaIVA + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepDocEsp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepDocEsp') and type = 'P') drop procedure dbo.spMFALayoutDExcepDocEsp
GO
CREATE PROC spMFALayoutDExcepDocEsp
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete 					varchar(max)	OUTPUT,			
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @TablaExcepcion		varchar(255),
	      @documento_origen_id	int

  SELECT @documento_origen_id = ID FROM MFAMovimientoLista WHERE Modulo = @aplicacion_origen_modulo AND Movimiento = @referencia AND Empresa = @empresa
  
  SELECT @TablaExcepcion = 'MFAMovExcepcion'
  
  SELECT @SQLDelete = 'DELETE ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND ModuloID = ''' + ISNULL(CONVERT(varchar, @documento_origen_id), '') + '''' + CHAR(13) + CHAR(10)
  
  SELECT @SQL = 'IF NOT EXISTS(SELECT * FROM ' + @TablaExcepcion + ' WHERE Modulo = ''' + ISNULL(@aplicacion_origen_modulo, '') + ''' AND ModuloID = ''' + ISNULL(CONVERT(varchar, @documento_origen_id), '') + ''')' + CHAR(13) + CHAR(10)
  SELECT @SQL = @SQL + 'INSERT INTO ' + @TablaExcepcion + '(Modulo, ModuloID) VALUES(''' + ISNULL(CONVERT(varchar, @aplicacion_origen_modulo), '') + ''', ''' + ISNULL(CONVERT(varchar, @documento_origen_id), '') + ''')' + CHAR(13) + CHAR(10)

  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDExcepcionProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDExcepcionProcesar') and type = 'P') drop procedure dbo.spMFALayoutDExcepcionProcesar
GO
CREATE PROC spMFALayoutDExcepcionProcesar
			@log_id						int,
			@d_id						int,
			@Accion						varchar(50),
			@origen_vista				varchar(255),
			@folio						varchar(50),
			@referencia					varchar(50),
			@aplicacion_origen_id		int,
			@aplicacion_origen_modulo	varchar(50),
			@aplicacion_tipo_aplicacion	varchar(50),
			@empresa					varchar(5),
			@aplicacion_Mov				varchar(20),
			@aplicacion_OrigenTipo		varchar(5),
			@aplicacion_Origen			varchar(20),
			@aplicacion_MovTipo			varchar(20),
			@SQL						varchar(max)	OUTPUT,
			@SQLDelete					varchar(max)	OUTPUT,
			@Ok							int				OUTPUT,
			@OkRef						varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @Accion IN('M-Excep. Ap.')
    EXEC spMFALayoutDExcepAp @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @aplicacion_MovTipo, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  ELSE IF @Accion IN('N-Excep. Doc.')
    EXEC spMFALayoutDExcepDoc @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
  ELSE IF @Accion = 'O-Excep. Ap. Esp.'
    EXEC spMFALayoutDExcepApEsp @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
  ELSE IF @Accion = 'P-Excep. Doc. Esp.'
    EXEC spMFALayoutDExcepDocEsp @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        
  ELSE IF @Accion IN('Q-Excep. Reporte', 'R-Excep. Reporte IEPS', 'S-Excep. Reporte IETU', 'T-Excep. Reporte IVA')
    EXEC spMFALayoutDExcepReporte @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT        
  ELSE IF @Accion IN('H-Cambiar a Aplicacion', 'I-Cambiar a Cobro', 'J-Cambiar a Endoso', 'K-Cambiar a Pago', 'L-Cambiar a Redoc.')
    EXEC spMFALayoutDAplicacionCambio @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT             
  ELSE IF @Accion IN('A-Agregar Anticipo', 'B-Agregar Comp. Gasto', 'C-Agregar Factura', 'D-Agregar Nota Cargo', 'E-Agregar Nota Credito', 'F-Agregar Devolucion', 'G-Agregar Prestamo')
    EXEC spMFALayoutDAgregarDocumento @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @SQL = @SQL OUTPUT, @SQLDelete = @SQLDelete OUTPUT, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  RETURN
END
GO

--REQ16752
/**************** spMFALayoutDSentenciaArmar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDSentenciaArmar') and type = 'P') drop procedure dbo.spMFALayoutDSentenciaArmar
GO
CREATE PROC spMFALayoutDSentenciaArmar
		    @Tipo		varchar(20),
			@SQL		varchar(max)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @ID		int,
		  @IDAnt	int

  CREATE TABLE #Agrupado(ID int IDENTITY, Sentencia varchar(max))

  IF @Tipo = 'Sentencia'  
    INSERT INTO #Agrupado(Sentencia) SELECT Sentencia FROM #Resultado GROUP BY Sentencia
  ELSE IF @Tipo = 'Sentencia Delete'
    INSERT INTO #Agrupado(Sentencia) SELECT Sentencia FROM #ResultadoDelete GROUP BY Sentencia
    
  SELECT @IDAnt = 0, @SQL = ''
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM #Agrupado
     WHERE ID > @IDAnt

    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @SQL = @SQL + ISNULL(Sentencia, '') FROM #Agrupado WHERE ID = @ID
  END
  
  RETURN 
END
GO

--REQ16752
/**************** spMFALayoutDProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFALayoutDProcesar') and type = 'P') drop procedure dbo.spMFALayoutDProcesar
GO
CREATE PROC spMFALayoutDProcesar
			@log_id			int,
			@Cancelar		bit,
			@Ok				int			 = NULL OUTPUT,
			@OkRef			varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET NOCOUNT ON
  
  DECLARE @d_id							int,
		  @d_idAnt						int,
		  @Accion						varchar(50),
		  @origen_vista					varchar(255),
		  @OkDesc						varchar(255),
		  @OkTipo						varchar(50),
		  --BUG17005
		  @SQL							nvarchar(max),
		  @SQLDeleteEx					varchar(max),
		  @SQLExcepcion					varchar(max),		  
		  @SQLDelete					nvarchar(max),		  		  
		  @folio						varchar(50),
		  @referencia					varchar(50),
		  @aplicacion_origen_id			int,
		  @aplicacion_origen_modulo		varchar(50),
		  @aplicacion_tipo_aplicacion	varchar(50),
		  @aplicacion_Mov				varchar(20),
		  @aplicacion_MovTipo			varchar(20),
		  @aplicacion_OrigenTipo		varchar(5),
		  @aplicacion_Origen			varchar(20),
		  @empresa						varchar(5)

  IF NOT EXISTS(SELECT * FROM layout_logd WHERE log_id = @log_id AND ISNULL(Accion, '') <> '')
    SELECT @Ok = 60010

  --BUG17005
  SELECT @SQL			= '',
		 @SQLDeleteEx	= '',
		 @SQLExcepcion	= '',
		 @SQLDelete		= ''

  IF @Cancelar = 0 AND @Ok IS NULL
  BEGIN
    SELECT @SQL = ''
  
    CREATE TABLE #Resultado(ID int IDENTITY, Sentencia varchar(max))
    CREATE TABLE #ResultadoDelete(ID int IDENTITY, Sentencia varchar(max))

    SELECT @d_idAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @d_id = MIN(d_id)
        FROM layout_logd
       WHERE log_id = @log_id
         AND ISNULL(Accion, '') <> ''
         AND d_id > @d_idAnt
  
      IF @d_id IS NULL BREAK
    
      SELECT @d_idAnt = @d_id
    
      SELECT @Accion = Accion, 
             @origen_vista = ISNULL(origen_vista, ''),
 		     @folio = ISNULL(folio, ''),
		     @referencia = ISNULL(referencia, ''),
		     @aplicacion_origen_id = aplicacion_origen_id,
		     @aplicacion_origen_modulo = ISNULL(aplicacion_origen_modulo, ''),
		     @aplicacion_tipo_aplicacion = ISNULL(aplicacion_tipo_aplicacion, ''),
		     @empresa = ISNULL(empresa, '')
        FROM layout_logd 
       WHERE log_id = @log_id 
         AND d_id = @d_id

      IF @aplicacion_origen_id IS NULL
        SELECT @aplicacion_origen_id = ID FROM MFAMovimientoLista WHERE Modulo = @aplicacion_origen_modulo AND Movimiento = @folio AND Empresa = @empresa

      EXEC spMovInfo @aplicacion_origen_id, @aplicacion_origen_modulo, @MovTipo = @aplicacion_MovTipo OUTPUT, @Mov = @aplicacion_Mov OUTPUT, @OrigenTipo = @aplicacion_OrigenTipo OUTPUT, @Origen = @aplicacion_Origen OUTPUT
    
      EXEC spMFALayoutDExcepcionProcesar @log_id, @d_id, @Accion, @origen_vista, @folio, @referencia, @aplicacion_origen_id, @aplicacion_origen_modulo, @aplicacion_tipo_aplicacion, @empresa, @aplicacion_Mov, @aplicacion_OrigenTipo, @aplicacion_Origen, @aplicacion_MovTipo, @SQL = @SQLExcepcion OUTPUT, @SQLDelete = @SQLDeleteEx OUTPUT,  @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
      IF ISNULL(@SQLExcepcion, '') <> ''
        INSERT INTO #Resultado(Sentencia) SELECT ISNULL(@SQLExcepcion, '') + CHAR(13) + CHAR(10)

      IF ISNULL(@SQLDeleteEx, '') <> ''
        INSERT INTO #ResultadoDelete(Sentencia) SELECT ISNULL(@SQLDeleteEx, '') + CHAR(13) + CHAR(10)
    END

    IF @Ok IS NULL
    BEGIN
      EXEC spMFALayoutDSentenciaArmar 'Sentencia', @SQL = @SQL OUTPUT
      EXEC spMFALayoutDSentenciaArmar 'Sentencia Delete', @SQL = @SQLDelete OUTPUT
    
      BEGIN TRY
        EXEC sp_executesql @SQL
      
        UPDATE layout_log SET SQL = @SQL, SQLDelete = @SQLDelete, EstatusAnalisis = 'CONCLUIDO' WHERE log_id = @log_id        
      END TRY
      BEGIN CATCH
        SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
      END CATCH
    END
  END
  ELSE IF @Cancelar = 1
  BEGIN
    SELECT @SQLDelete = SQLDelete FROM layout_log WHERE log_id = @log_id
    
    BEGIN TRY
      EXEC sp_executesql @SQLDelete
      
      UPDATE layout_log SET SQL = '', SQLDelete = '', EstatusAnalisis = 'SINAFECTAR' WHERE log_id = @log_id
    END TRY
    BEGIN CATCH
      SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
    END CATCH
  END
  
  IF @Ok IS NULL 
    SELECT @OkRef = NULL
  ELSE
    -- Leer el Mensaje
    SELECT @OkDesc = Descripcion, 
           @OkTipo = Tipo
      FROM MensajeLista
     WHERE Mensaje = @Ok
  
  SELECT @Ok, @OkDesc, @OkTipo, @OkRef, NULL
END
GO

-- EXEC spMFARepCxpFisicas 'DEMO', '2013-01-01', '2014-03-03'
--REQ19173
/**************** spMFARepCxpFisicas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spMFARepCxpFisicas') and type = 'P') drop procedure dbo.spMFARepCxpFisicas
GO
CREATE PROC spMFARepCxpFisicas
			@Empresa		varchar(5),
			@FechaD			datetime,
			@FechaA			datetime,
			@Estatus		varchar(15),
			@Procesar		bit		 = 0,
			--BUG22515
			@FechaCierreD	datetime = NULL,
			@FechaCierreA	datetime = NULL
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE @Reporte		int,
		  @ClaveBC		int,
		  @Concepto		varchar(100),
		  @Fecha		datetime,
		  @Ejercicio	int,
		  @SQL			varchar(max)

  CREATE TABLE #Movimentos(
    RID				int				IDENTITY,
    Modulo			varchar(20)		COLLATE Database_Default	NULL,
    ModuloID		int				NULL,
    Empresa			varchar(5)		COLLATE Database_Default	NULL,
    Estatus			varchar(15)		COLLATE Database_Default	NULL,
    Mov				varchar(20)		COLLATE Database_Default	NULL,
    MovID			varchar(20)		COLLATE Database_Default	NULL,
    Proveedor		varchar(10)		COLLATE Database_Default	NULL,
    Nombre			varchar(100)	COLLATE Database_Default	NULL,
    FiscalRegimen	varchar(30)		COLLATE Database_Default	NULL,
    Ejercicio		int				NULL,
    Periodo			int				NULL,
    FechaEmision	datetime		NULL,
    Importe			float			NULL,
    Impuestos		float			NULL,
    Aplica			varchar(20)		COLLATE Database_Default	NULL,
    AplicaID		varchar(20)		COLLATE Database_Default	NULL,
    FechaAplica		datetime		NULL,
    EjercicioAplica	int				NULL,
    PeriodoAplica	int				NULL
    )
  
  IF @Estatus  = 'Pendientes' SELECT @Estatus = 'PENDIENTE', @Ejercicio = YEAR(@FechaD)
  IF @Estatus  = 'Concluidos' SELECT @Estatus = 'CONCLUIDO', @Ejercicio = YEAR(@FechaD) - 1

  --BUG22515
  IF @Estatus IN('PENDIENTE', '(Todos)')
  BEGIN
    IF @Estatus  = '(Todos)' 
      SELECT @Ejercicio = YEAR(@FechaD)
      
    /************** Movimientos de Cxp con Origen de Compras **************/
    INSERT INTO #Movimentos(
		   Modulo,   ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,   Importe,                Impuestos,                Estatus)
    SELECT 'COMS', c.ID,       d.Empresa, d.Mov, d.MovID, d.Proveedor, p.Nombre, p.FiscalRegimen, d.Ejercicio, d.Periodo, d.FechaEmision, d.Importe*d.TipoCambio, d.Impuestos*d.TipoCambio, d.Estatus
      FROM Cxp d
      JOIN Compra c ON d.Origen = c.Mov AND d.OrigenID = c.MovID AND d.OrigenTipo = 'COMS'
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'COMS'
      JOIN Prov p ON d.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasAdicion mtmda ON mtmda.Modulo = 'COMS' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasExcepcion mtmde ON mtmde.Modulo = 'COMS' AND mtmde.Mov = c.Mov
     WHERE mtmde.Modulo IS NULL
       AND (mt.Clave IN ('COMS.F', 'COMS.OP', 'COMS.FL', 'COMS.CC', 'COMS.CA', 'COMS.GX') OR (mtmda.Modulo IS NOT NULL))
       --BUG2515
       AND d.Ejercicio     = CASE d.Estatus WHEN 'PENDIENTE' THEN d.Ejercicio WHEN 'CONCLUIDO' THEN @Ejercicio END
       AND d.FechaEmision >= CASE d.Estatus WHEN 'PENDIENTE' THEN @FechaD WHEN 'CONCLUIDO' THEN d.FechaEmision END     
       AND d.FechaEmision <= CASE d.Estatus WHEN 'PENDIENTE' THEN @FechaA WHEN 'CONCLUIDO' THEN d.FechaEmision END
       AND d.Estatus IN('PENDIENTE')
       AND d.Empresa = @Empresa

    /************** Movimientos de Cxp con Origen de Gastos **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,   Importe,                Impuestos,                Estatus)
    SELECT 'GAS', c.ID,       d.Empresa, d.Mov, d.MovID, d.Proveedor, p.Nombre, p.FiscalRegimen, d.Ejercicio, d.Periodo, d.FechaEmision, d.Importe*d.TipoCambio, d.Impuestos*d.TipoCambio, d.Estatus
      FROM Cxp d
      JOIN Gasto c ON d.Origen = c.Mov AND d.OrigenID = c.MovID AND d.OrigenTipo = 'GAS'
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'GAS'
      JOIN Prov p ON d.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasClaseSubClase mfcs ON ISNULL(mfcs.Clase, '') = ISNULL(c.Clase, '') AND ISNULL(mfcs.Subclase, '') = ISNULL(c.Subclase, '')
      LEFT OUTER JOIN MFARepCxpFisicasAdicion mtmda ON mtmda.Modulo = 'GAS' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasExcepcion mtmde ON mtmde.Modulo = 'GAS' AND mtmde.Mov = c.Mov
     WHERE mtmde.Modulo IS NULL
       AND (mt.Clave IN ('GAS.G', 'GAS.GP', 'GAS.A', 'GAS.ASC', 'GAS.G', 'GAS.GTC', 'GAS.GP', 'GAS.CP', 'GAS.GR') OR (mtmda.Modulo IS NOT NULL))
       --BUG22515
       AND d.Ejercicio     = CASE d.Estatus WHEN 'PENDIENTE' THEN d.Ejercicio WHEN 'CONCLUIDO' THEN @Ejercicio END
       AND d.FechaEmision >= CASE d.Estatus WHEN 'PENDIENTE' THEN @FechaD WHEN 'CONCLUIDO' THEN d.FechaEmision END     
       AND d.FechaEmision <= CASE d.Estatus WHEN 'PENDIENTE' THEN @FechaA WHEN 'CONCLUIDO' THEN d.FechaEmision END
       AND d.Estatus IN('PENDIENTE')
       AND d.Empresa = @Empresa
       AND mfcs.RID IS NOT NULL

    /************** Devoluciones y Creditos **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,   Importe,                 Impuestos,   Estatus,   Aplica,   AplicaID,   FechaAplica,    EjercicioAplica,   PeriodoAplica)
    SELECT 'CXP', c.ID,       c.Empresa, c.Mov, c.MovID, c.Proveedor, p.Nombre, p.FiscalRegimen, c.Ejercicio, c.Periodo, c.FechaEmision, d.Importe*c.TipoCambio*-1, 0,         c.Estatus, d.Aplica, d.AplicaID, o.FechaEmision, o.Ejercicio,       o.Periodo
      FROM Cxp c
      JOIN CxpD d ON c.ID = d.ID
      JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID            
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
      JOIN MovTipo mt2 ON o.Mov = mt2.Mov AND mt2.Modulo = 'CXP'
      JOIN Prov p ON c.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasDevAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov
      --BUG22205
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmdeo ON mtmdeo.Modulo = 'CXP' AND mtmdeo.Mov = c.Mov      
     WHERE mtmde.Modulo IS NULL
       AND mtmdeo.Modulo IS NULL
       AND (mt.Clave IN ('CXP.DC', 'CXP.NC') OR (mtmda.Modulo IS NOT NULL))
       AND (mt2.Clave IN ('CXP.F'))
       AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
       --BUG22515
       AND c.Ejercicio     = CASE o.Estatus WHEN 'PENDIENTE' THEN c.Ejercicio WHEN 'CONCLUIDO' THEN @Ejercicio END
       AND c.FechaEmision >= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaD WHEN 'CONCLUIDO' THEN c.FechaEmision END     
       AND c.FechaEmision <= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaA WHEN 'CONCLUIDO' THEN c.FechaEmision END
       AND c.Estatus =('CONCLUIDO')
       AND o.Estatus =('PENDIENTE')
       AND c.Empresa = @Empresa
       
    /************** Neteos y Aplicaciones **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,  Importe,                                                                Impuestos,    Estatus,   Aplica,   AplicaID,   FechaAplica,    EjercicioAplica,   PeriodoAplica)
    SELECT 'CXP', c.ID,       c.Empresa, c.Mov, c.MovID, c.Proveedor, p.Nombre, p.FiscalRegimen, c.Ejercicio, c.Periodo, c.FechaEmision, (d.Importe)/(1+((((o.Impuestos*100.0)/o.Importe))/100.0))*c.TipoCambio*-1, 0,          c.Estatus, d.Aplica, d.AplicaID, o.FechaEmision, o.Ejercicio,       o.Periodo
      FROM Cxp c
      JOIN CxpD d ON c.ID = d.ID
      JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID            
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
      JOIN MovTipo mt2 ON o.Mov = mt2.Mov AND mt2.Modulo = 'CXP'      
      JOIN Prov p ON c.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasDevAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov
      --BUG22205      
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmdeo ON mtmdeo.Modulo = 'CXP' AND mtmdeo.Mov = c.Mov      
     WHERE mtmde.Modulo IS NULL
       AND mtmdeo.Modulo IS NULL
       AND (mt.Clave IN ('CXP.NET', 'CXP.ANC') OR (mtmda.Modulo IS NOT NULL))
       AND (mt2.Clave IN ('CXP.F'))
       AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
       --BUG22515
       AND c.Ejercicio     = CASE o.Estatus WHEN 'PENDIENTE' THEN c.Ejercicio WHEN 'CONCLUIDO' THEN @Ejercicio END
       AND c.FechaEmision >= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaD WHEN 'CONCLUIDO' THEN c.FechaEmision END     
       AND c.FechaEmision <= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaA WHEN 'CONCLUIDO' THEN c.FechaEmision END
       AND c.Estatus =('CONCLUIDO')
       AND o.Estatus IN('PENDIENTE')       
       AND c.Empresa = @Empresa           
    
    --BUG24910
    /************** Pagos **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,  Importe,                                                                Impuestos,    Estatus,   Aplica,   AplicaID,   FechaAplica,    EjercicioAplica,   PeriodoAplica)
    SELECT 'CXP', c.ID,       c.Empresa, c.Mov, c.MovID, c.Proveedor, p.Nombre, p.FiscalRegimen, c.Ejercicio, c.Periodo, c.FechaEmision, (d.Importe)/(1+((((o.Impuestos*100.0)/o.Importe))/100.0))*c.TipoCambio*-1, 0,          c.Estatus, d.Aplica, d.AplicaID, o.FechaEmision, o.Ejercicio,       o.Periodo
      FROM Cxp c
      JOIN CxpD d ON c.ID = d.ID
      JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID            
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
      JOIN MovTipo mt2 ON o.Mov = mt2.Mov AND mt2.Modulo = 'CXP'      
      JOIN Prov p ON c.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasDevAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov
      --BUG22205      
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmdeo ON mtmdeo.Modulo = 'CXP' AND mtmdeo.Mov = c.Mov      
     WHERE mtmde.Modulo IS NULL
       AND mtmdeo.Modulo IS NULL
       AND (mt.Clave IN ('CXP.P','CXP.NCP','CXP.DP') OR (mtmda.Modulo IS NOT NULL))
       AND (mt2.Clave IN ('CXP.F'))
       AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
       --BUG22515
       AND c.Ejercicio     = CASE o.Estatus WHEN 'PENDIENTE' THEN c.Ejercicio WHEN 'CONCLUIDO' THEN @Ejercicio END
       AND c.FechaEmision >= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaD WHEN 'CONCLUIDO' THEN c.FechaEmision END     
       AND c.FechaEmision <= CASE o.Estatus WHEN 'PENDIENTE' THEN @FechaA WHEN 'CONCLUIDO' THEN c.FechaEmision END
       AND c.Estatus =('CONCLUIDO')
       AND o.Estatus IN('PENDIENTE')       
       AND c.Empresa = @Empresa                  
  END
  --BUG22515
  IF @Estatus IN('CONCLUIDO', '(Todos)')
  BEGIN
    --BUG22515
    IF @Estatus = '(Todos)'
      SELECT @FechaD = @FechaCierreD, @FechaA = @FechaCierreA, @Ejercicio = YEAR(@FechaCierreD) - 1

    /************** Pagos **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,  Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision, Importe,                                                                                                                                                                                                                                                                                                                                          Impuestos,   Estatus,   Aplica,   AplicaID,   FechaAplica,    EjercicioAplica,   PeriodoAplica)
    SELECT 'CXP', c.ID,      c.Empresa, c.Mov, c.MovID, c.Proveedor, p.Nombre, p.FiscalRegimen, c.Ejercicio, c.Periodo, c.FechaEmision, CASE ISNULL(o.Retencion, 0)+ISNULL(o.Retencion2, 0)+ISNULL(o.Retencion3, 0) WHEN 0 THEN (d.Importe)/(1+((((o.Impuestos*100.0)/o.Importe))/100.0))*c.TipoCambio ELSE ROUND((o.Importe*((d.Importe*100.0)/(o.Importe-(ISNULL(o.Retencion, 0)+ISNULL(o.Retencion2, 0)+ISNULL(o.Retencion3, 0))+ISNULL(o.Impuestos, 0))/100.0))*c.TipoCambio, 2) END, 0,         c.Estatus, d.Aplica, d.AplicaID, o.FechaEmision, o.Ejercicio,       o.Periodo
      FROM Cxp c
      JOIN CxpD d ON c.ID = d.ID
      JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
      JOIN Prov p ON c.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasPagoAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasPagoExcepcion mtmde  ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov
      --BUG22205      
      LEFT OUTER JOIN MFARepCxpFisicasPagoExcepcion mtmdeo ON mtmdeo.Modulo = 'CXP' AND mtmdeo.Mov = d.Aplica
     WHERE mtmde.Modulo IS NULL
       AND mtmdeo.Modulo IS NULL
       AND (mt.Clave IN ('CXP.P','CXP.NCP','CXP.DP') OR (mtmda.Modulo IS NOT NULL))
       AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND o.Ejercicio <= @Ejercicio
       AND c.Estatus =('CONCLUIDO')
       AND o.Estatus IN('PENDIENTE', 'CONCLUIDO')              
       AND c.Empresa = @Empresa
       
    /************** Neteos y Aplicaciones **************/
    INSERT INTO #Movimentos(
		   Modulo,  ModuloID,   Empresa,   Mov,   MovID,   Proveedor,   Nombre,   FiscalRegimen,   Ejercicio,   Periodo,   FechaEmision,    Importe,                                                             Impuestos,    Estatus,   Aplica,   AplicaID,   FechaAplica,    EjercicioAplica,   PeriodoAplica)
    SELECT 'CXP', c.ID,       c.Empresa, c.Mov, c.MovID, c.Proveedor, p.Nombre, p.FiscalRegimen, c.Ejercicio, c.Periodo, c.FechaEmision, (d.Importe)/(1+((((o.Impuestos*100.0)/o.Importe))/100.0))*c.TipoCambio, 0,          c.Estatus, d.Aplica, d.AplicaID, o.FechaEmision, o.Ejercicio,       o.Periodo
      FROM Cxp c
      JOIN CxpD d ON c.ID = d.ID
      JOIN Cxp o ON c.Empresa = o.Empresa AND d.Aplica = o.Mov AND d.AplicaID = o.MovID            
      JOIN MovTipo mt ON c.Mov = mt.Mov AND mt.Modulo = 'CXP'
      JOIN MovTipo mt2 ON o.Mov = mt2.Mov AND mt2.Modulo = 'CXP'      
      JOIN Prov p ON c.Proveedor = p.Proveedor
      JOIN MFARepCxpFisicasFiscalRegimen mtmfr ON p.FiscalRegimen = mtmfr.FiscalRegimen
      LEFT OUTER JOIN MFARepCxpFisicasDevAdicion mtmda ON mtmda.Modulo = 'CXP' AND mtmda.Mov = c.Mov
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmde ON mtmde.Modulo = 'CXP' AND mtmde.Mov = c.Mov
      --BUG22205      
      LEFT OUTER JOIN MFARepCxpFisicasDevExcepcion mtmdeo ON mtmdeo.Modulo = 'CXP' AND mtmdeo.Mov = c.Mov
     WHERE mtmde.Modulo IS NULL
       AND mtmdeo.Modulo IS NULL
       AND (mt.Clave IN ('CXP.NET') OR (mtmda.Modulo IS NOT NULL))
       AND (mt2.Clave IN ('CXP.F'))
       AND ((NULLIF(c.Origen,'') IS NULL AND NULLIF(c.OrigenTipo,'') IS NULL AND NULLIF(c.OrigenID,'') IS NULL) OR (c.OrigenTipo = 'CXP'))
       AND c.FechaEmision BETWEEN @FechaD AND @FechaA
       AND o.Ejercicio <= @Ejercicio
       AND c.Estatus =('CONCLUIDO')
       AND o.Estatus IN('PENDIENTE', 'CONCLUIDO')       
       AND c.Empresa = @Empresa                  
  END
  IF @Procesar = 0
    SELECT * FROM #Movimentos ORDER BY Proveedor, Modulo
  --BUG22515
  ELSE IF @Procesar = 1 AND @Estatus IN('PENDIENTE', 'CONCLUIDO', '(Todos)')
  BEGIN
    SELECT @Fecha = GETDATE()

    IF @Estatus = 'PENDIENTE'
      SELECT @Reporte = 40, @ClaveBC = 28, @Concepto = Concepto FROM MFARepCxpFisicas WHERE Empresa = @Empresa AND Estatus = @Estatus
    ELSE IF @Estatus = 'CONCLUIDO'
      SELECT @Reporte = 40, @ClaveBC = 50, @Concepto = Concepto FROM MFARepCxpFisicas WHERE Empresa = @Empresa AND Estatus = @Estatus
    --BUG22515
    ELSE IF @Estatus = '(Todos)'
      SELECT @Reporte = 40, @ClaveBC = 28, @Concepto = Concepto FROM MFARepCxpFisicas WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE'  
    --DELETE MFAAjustesCalculo WHERE Empresa = @Empresa AND Ejercicio = YEAR(@Fecha) AND Reporte = @Reporte AND ClaveBC = @ClaveBC
    --BUG20300
    DELETE MFAAjustesCalculo WHERE Empresa = @Empresa AND Ejercicio = YEAR(@Fecha) AND Reporte = @Reporte AND ClaveBC = @ClaveBC
    
    INSERT INTO MFAAjustesCalculo(
				Empresa,  Reporte,  ClaveBC,  Fecha,  Ejercicio,   Periodo, Importe,                  Concepto)
		SELECT @Empresa, @Reporte, @ClaveBC, @Fecha, YEAR(@Fecha), 12,      ISNULL(SUM(Importe), 0), @Concepto
		  FROM #Movimentos
  
    SELECT 'Proceso Concluido'
  END

  --BUG22257 BUG22515
  --IF @Estatus = '(Todos)' AND @Procesar=1
  --  SELECT 'Estatus Incorrecto.'

  RETURN
END
GO

--EXEC spMFALayoutDProcesar 153
--EXEC spMFALayoutImportar 'DEMO', 'DEMO', 2014, 9
--EXEC spMFALayoutImportar_Cuentas 'DEMO','DEMO',2014,7

/*
DELETE FROM LAYOUT_DOCUMENTOS
DELETE FROM LAYOUT_APLICACIONES
DELETE FROM DOCUMENTOS
DELETE FROM APLICACIONES
DELETE FROM LAYOUT_LOG
DELETE FROM LAYOUT_LOGD
DELETE FROM ximpiva
DELETE FROM DatosIEPS
DELETE FROM DatosIETU
*/

/*
select * from layout_aplicaciones where referencia = 'Gasto 1'
select * from layout_documentos where folio = 'Gasto 1'
select * from documentos where folio = 'Gasto 1'
*/
