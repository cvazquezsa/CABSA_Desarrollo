/* Sistema */
if (select version from version)<=2131
  delete systabla where systabla in ('MovTipoContAuto', 'MovClave', 'CtoTipo')
GO

/****** SysVista ******/
if not exists (select * from SysTabla where SysTabla = 'SysVista') 
INSERT INTO SysTabla (SysTabla) VALUES ('SysVista')
if not exists (select * from sysobjects where id = object_id('dbo.SysVista') and type = 'U') 
CREATE TABLE dbo.SysVista (
	SysVista		varchar(50) 	NOT NULL,
	Descripcion		varchar(100)	NULL,
	TRCL			bit		NOT NULL	DEFAULT 0,

	CONSTRAINT priSysVista PRIMARY KEY CLUSTERED (SysVista)
)
GO

/****** ObjetoSR ******/
if not exists (select * from SysTabla where SysTabla = 'ObjetoSR') 
INSERT INTO SysTabla (SysTabla) VALUES ('ObjetoSR')
if not exists (select * from sysobjects where id = object_id('dbo.ObjetoSR') and type = 'U') 
CREATE TABLE dbo.ObjetoSR (
	Objeto			varchar(100) 	NOT NULL,

	CONSTRAINT priObjetoSR PRIMARY KEY CLUSTERED (Objeto)
)
GO

/****** SysVariable  ******/
if not exists (select * from SysTabla where SysTabla = 'SysVariable') 
INSERT INTO SysTabla (SysTabla) VALUES ('SysVariable')
if not exists (select * from sysobjects where id = object_id('dbo.SysVariable') and type = 'U') 
CREATE TABLE dbo.SysVariable (
	Variable		varchar(50)  	NOT NULL,
	Tipo			varchar(10)	NOT NULL,
	ValorInicial		varchar(50)  	NULL,
	Nombre			varchar(100)	NULL,
	Tamano			varchar(5)	NULL,
	AyudaEnCaptura		varchar(20)	NULL,
	Ayuda			varchar(100)	NULL,
	Mayusculas		bit		NOT NULL DEFAULT 0,
	ListaOpciones		text		NULL,
	OpcionPredefinida	varchar(30)	NULL,
	UnicamenteOpciones	bit		NOT NULL DEFAULT 0,
	Validar			bit		NOT NULL DEFAULT 0,
	Sistema			bit		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priSysVariable PRIMARY KEY CLUSTERED (Variable)

)
GO

/****** SysBase ******/
if not exists (select * from SysTabla where SysTabla = 'SysBase') 
INSERT INTO SysTabla (SysTabla) VALUES ('SysBase')
if not exists (select * from sysobjects where id = object_id('dbo.SysBase') and type = 'U') 
CREATE TABLE dbo.SysBase (
	Objeto			varchar(50)	NOT NULL, 
	Fecha			datetime	NULL,
	Datos			image		NULL,
	
	CONSTRAINT priSysBase PRIMARY KEY CLUSTERED (Objeto)

)
go

EXEC spDROP_TABLE 'SincroPaquete', 3100
GO
/****** SincroPaquete ******/
/*if not exists (select * from SysTabla where SysTabla = 'SincroPaquete') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SincroPaquete', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SincroPaquete') and type = 'U') 
  CREATE TABLE dbo.SincroPaquete (
	Sucursal		int		NOT NULL,
	ID			int  		NOT NULL,

	Fecha			datetime	NULL	DEFAULT GETDATE(),
	SincroIDAnterior	binary(8)	NULL,
	SincroID		timestamp	NULL,
	OrdenID			int		NOT NULL IDENTITY(1,1),

	CONSTRAINT priSincroPaquete PRIMARY KEY CLUSTERED (Sucursal, ID)
  )*/
GO
--EXEC spALTER_TABLE 'SincroPaquete', 'OrdenID', 'int NOT NULL IDENTITY(1,1)'
GO

EXEC spDROP_TABLE 'SincroMovRegistro', 3100
GO
/****** SincroMovRegistro ******/
/*if (select version from version) <= 1153 and exists (select * from sysobjects where id = object_id('dbo.SincroMovRegistro') and type = 'U') 
DROP TABLE SincroMovRegistro*/
GO
/*if not exists (select * from SysTabla where SysTabla = 'SincroMovRegistro') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SincroMovRegistro', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SincroMovRegistro') and type = 'U') 
  CREATE TABLE dbo.SincroMovRegistro (
	Sucursal	int		NOT NULL,
	Modulo		varchar(5)	NOT NULL,
	ID		int  		NOT NULL,

	CONSTRAINT priSincroMovRegistro PRIMARY KEY CLUSTERED (Sucursal, Modulo, ID)
  )*/
GO


EXEC spDROP_TABLE 'SincroLog', 3100
GO
/****** SincroLog ******/
/*if not exists (select * from SysTabla where SysTabla = 'SincroLog') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SincroLog', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SincroLog') and type = 'U') 
  CREATE TABLE dbo.SincroLog (
	Sucursal	int  		NOT NULL,
	Accion		varchar(20)	NOT NULL,
	Origen		int		NOT NULL,
	Consecutivo	int		NOT NULL,

	Tablas		int		NULL,
	Registros	int		NULL,

	Advertencias	int		NULL,
	Errores		int		NULL,

	Fecha		datetime	NULL	 DEFAULT GETDATE(),
	TiempoProceso	int		NULL,
	Conciliado	bit		NOT NULL DEFAULT 0,

	OrdenID		int		NOT NULL IDENTITY(1,1),

	CONSTRAINT priSincroLog PRIMARY KEY CLUSTERED (Sucursal, Accion, Origen, Consecutivo)
  )*/
GO
--EXEC spALTER_TABLE 'SincroLog', 'OrdenID', 'int NOT NULL IDENTITY(1,1)'
GO

EXEC spDROP_TABLE 'SincroLogAdvertencia', 3100
GO
/****** SincroLogAdvertencia ******/
/*if exists (select * from sysobjects where id = object_id('dbo.SincroLogAdvertencia') and type = 'U') AND (select version from version) <= 1133 
DROP TABLE SincroLogAdvertencia*/
GO
/*if not exists (select * from SysTabla where SysTabla = 'SincroLogAdvertencia') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SincroLogAdvertencia', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SincroLogAdvertencia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SincroLogAdvertencia (
	ID		int		NOT NULL 	IDENTITY(1,1),
	Sucursal	int  		NOT NULL,
	Accion		varchar(20)	NOT NULL,
	Origen		int		NOT NULL,
	Consecutivo	int		NOT NULL,

	Mensaje		varchar(255)	NULL,
	Fecha		datetime	NULL	 DEFAULT GETDATE(),

	CONSTRAINT priSincroLogAdvertencia PRIMARY KEY CLUSTERED (ID, Sucursal, Accion, Origen, Consecutivo)
  )
  EXEC spSincroSemilla 'SincroLogAdvertencia'
END*/
GO
/*if not exists(select * from syscampo where tabla = 'SincroLogAdvertencia' and campo = 'Fecha')
  ALTER TABLE SincroLogAdvertencia ADD Fecha datetime NULL DEFAULT GETDATE() WITH VALUES*/
GO

EXEC spDROP_TABLE 'SincroLogError', 3100
GO
/****** SincroLogError ******/
/*if exists (select * from sysobjects where id = object_id('dbo.SincroLogError') and type = 'U') AND (select version from version) <= 1133 
DROP TABLE SincroLogError*/
GO
/*if not exists (select * from SysTabla where SysTabla = 'SincroLogError') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SincroLogError', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.SincroLogError') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SincroLogError (
	ID		int		NOT NULL 	IDENTITY(1,1),
	Sucursal	int  		NOT NULL,
	Accion		varchar(20)	NOT NULL,
	Origen		int		NOT NULL,
	Consecutivo	int		NOT NULL,

	Mensaje		varchar(255)	NULL,
	Fecha		datetime	NULL	 DEFAULT GETDATE(),

	CONSTRAINT priSincroLogError PRIMARY KEY CLUSTERED (ID, Sucursal, Accion, Origen, Consecutivo)
  )
  EXEC spSincroSemilla 'SincroLogError'
END*/
GO
/*if not exists(select * from syscampo where tabla = 'SincroLogError' and campo = 'Fecha')
  ALTER TABLE SincroLogError ADD Fecha datetime NULL DEFAULT GETDATE() WITH VALUES*/
GO

/****** MovTipo  ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipo') and type = 'U') 
CREATE TABLE dbo.MovTipo (
	Modulo			varchar(5)      NOT NULL,
	Mov 		        varchar(20)     NOT NULL,

        Orden			int		NULL,
	Clave			varchar(20)	NOT NULL,  
	SubClave		varchar(20)	NULL,  
        ConsecutivoModulo       varchar(5)		NOT NULL,
        ConsecutivoMov	        varchar(20)	NOT NULL,
        Grupo			varchar(50)	NULL,
	Icono			int	   	NULL,
	Factor			int		NULL     DEFAULT 1,
	ConsecutivoPorPeriodo	bit		NOT NULL DEFAULT 0,
	ConsecutivoPorEjercicio	bit		NOT NULL DEFAULT 0,
	ConsecutivoPorEmpresa   varchar(20)	NULL	 DEFAULT 'Si',  -- Si, No o Grupo
	ConsecutivoSucursalEsp	bit		NULL 	 DEFAULT 0,
	PrefijoSucursal	bit		NULL 	 DEFAULT 0,--bug4219
	ConsecutivoControl	bit		NULL 	 DEFAULT 0,
	SucursalEsp		int		NULL,
	Almacen			varchar(10)	NULL,
	DiasVencimiento		int		NULL,
	NomProcesarIncidencias	bit		NOT NULL DEFAULT 1,
	NomGenerarBaja		bit		NOT NULL DEFAULT 0,
        NomDividirCantidades	bit		NULL     DEFAULT 1,
	GenerarParalelo		varchar(50)	NULL	 DEFAULT 'No',
	PV			bit		NULL 	 DEFAULT 0,
	EstatusContabilizar	varchar(15)	NULL	 DEFAULT '(por Omision)',
	AfectarPresupuesto	varchar(20)	NULL	 DEFAULT '(por Omision)',
	AfectarFiscal		varchar(20)	NULL	 DEFAULT 'No',		-- No, Ingreso, Egreso, Mixto
	ObligacionFiscal	varchar(50)	NULL,
	ObligacionFiscalTasa	float		NULL,
	ObligacionFiscalTipoImporte		varchar(20) NULL,

	GenerarGasto		bit		NULL 	 DEFAULT 0,
	GastoMov		varchar(20)	NULL,
	GastoClase		varchar(50)	NULL,
	GastoSubClase		varchar(50)	NULL,
	GastoAcreedor		varchar(10)	NULL,
	GastoFactor		float		NULL	 DEFAULT 1.0,
	GastoConcepto		varchar(50)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	eMailAuto		bit		NULL 	 DEFAULT 0,
	SinAfectarVINCostoExtra	bit		NULL 	 DEFAULT 0,
	TipoPago		varchar(20)	NULL,

	CE			bit		NULL	 DEFAULT 0,
	CEAntesAfectar		bit		NULL	 DEFAULT 0,
	CEAfectarContacto 	bit		NULL	 DEFAULT 0,
	NomAuto			bit		NULL 	 DEFAULT 0,
	NomAutoTipo		varchar(50)	NULL,
	NomAutoCalcSDI		bit		NULL 	 DEFAULT 0,
	NomAutoCxc		varchar(20)	NULL,
	NomAutoCalendarioEsp	bit		NULL 	 DEFAULT 0,
--	PlantillaInfoPath	varchar(100)	NULL,
	ImpresionInmediata	bit		NULL	 DEFAULT 0,
	ConsecutivoFEA		varchar(20)	NULL,
	EditarDeptoDetallista	bit		NULL	 DEFAULT 0,

	ProyectoContactoTipo	varchar(20)	NULL,
	PlantillaProyecto	varchar(50)	NULL,
	PlantillaProyectoFija	bit		NULL	 DEFAULT 0,
	ProyectoLineaBase	bit		NULL	 DEFAULT 0,
	CFD			bit		NULL	 DEFAULT 0,
	CFD_tipoDeComprobante	varchar(20)	NULL,		-- Ingreso, egreso, traslado
	CFD_Reporte		varchar(100)	NULL,

	Instrucciones		text	NULL,

	FormaTipo		varchar(20)	NULL,
	FormaFija		bit		NULL	 DEFAULT 0,
	AplicarOfertas		bit		NULL	 DEFAULT 0,
	FormaAnexaOmision	varchar(50)	NULL,
	TraspasoExpress		bit		NULL	 DEFAULT 0,
	ModuloCentral		bit		NULL	 DEFAULT 0,
	DefUsuario		varchar(10)	NULL,
	SubFoliosOrigen		bit		NULL	 DEFAULT 0,
	RequiereAutorizacion	bit		NULL	 DEFAULT 0,

	TipoConsecutivo			varchar(20)	NULL	 DEFAULT 'Modulo',
	ConsecutivoGeneral		varchar(20)	NULL,
	ArrastrarTipoCambioGenerarMov	bit		NULL	 DEFAULT 0,
	AfectarCP			varchar(20)	NULL	 DEFAULT 'No',		-- No, Presupuesto, Comprometido, Devengado, Ejercido
	AplicarCP			varchar(21)	NULL	 DEFAULT 'No',		-- No, Presupuesto, Comprometido, Devengado, Ejercido
	FactorCP			float		NULL	 DEFAULT 1.0,
	ReservarCP			varchar(20)	NULL	 DEFAULT 'No',		-- No, Si, Desreservar
	AnticiposCP			varchar(20)	NULL	 DEFAULT 'No',		-- No, Si, Desanticipar

	EcuadorMostrarAnexo		varchar(20)	NULL	 DEFAULT 'No',
	GuatemalaLibroVentaExento	bit		NULL	 DEFAULT 0,
	
	FactorFiscalEsp				bit		NULL	 DEFAULT 0,			--MEJORA1015
	FactorFiscal				int		NULL	 DEFAULT NULL,      --MEJORA1015
	
	eDocEstatus				varchar(15)	NULL, --MEJORA2104
	eDoc					varchar(50) NULL, --MEJORA2104
	CFDFlex					bit NULL, --MEJORA2104	
	
	SAUXMov					varchar(20) NULL,
	SAUXMovInvPendiente		varchar(20)	NULL	 DEFAULT 'Ord Consumo Servicio',
	SAUXMovInvConcluida		varchar(20)	NULL	 DEFAULT 'Consumo Material Ser',

	Interno						bit		NULL	 DEFAULT 0,
	OpcionPermitirDescontinuado	bit		NULL	DEFAULT 0, --MEJORA5547

	CFDEsParcialidad			bit		NULL	DEFAULT 0,
	SerieMES					varchar(3) NULL,  --REQ12534 Factory  
	
		
	CONSTRAINT priMovTipo PRIMARY KEY CLUSTERED (Mov, Modulo)

)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgMovTipoABC') and sysstat & 0xf = 8) drop trigger dbo.tgMovTipoABC
GO
EXEC spALTER_TABLE 'MovTipo', 'DiasVencimiento',       	'int NULL'
EXEC spALTER_TABLE 'MovTipo', 'NomProcesarIncidencias',	'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'NomGenerarBaja',		'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'GenerarParalelo', 'varchar(50) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'PV', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'EstatusContabilizar', 'varchar(15) NULL DEFAULT "(por Omision)" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ConsecutivoSucursalEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'SucursalEsp', 'int NULL'
EXEC spALTER_TABLE 'MovTipo', 'GenerarGasto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'GastoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'GastoClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'GastoSubClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'GastoAcreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovTipo', 'eMailAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'NomDividirCantidades', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'SinAfectarVINCostoExtra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ConsecutivoControl', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'TipoPago', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'GastoFactor', 'float NULL DEFAULT 1.0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'CE', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'CEAntesAfectar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'CEAfectarContacto', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'NomAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'NomAutoTipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'NomAutoCalcSDI', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'NomAutoCxc', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'NomAutoCalendarioEsp', 'bit NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'PlantillaInfoPath', 'varchar(100) NULL'
EXEC spALTER_TABLE 'MovTipo', 'ImpresionInmediata', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ConsecutivoFEA', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'EditarDeptoDetallista', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'AfectarPresupuesto', 'varchar(20) NULL DEFAULT "(por Omision)" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'CFD', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'CFD_tipoDeComprobante', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'CFD_Reporte', 'varchar(100) NULL'
EXEC spALTER_TABLE 'MovTipo', 'Instrucciones', 'text NULL'
GO
EXEC spRENAME_COLUMN 'MovTipo', 'GestionContactoTipo', 'ProyectoContactoTipo'
EXEC spRENAME_COLUMN 'MovTipo', 'GestionProyectoPlantilla', 'ProyectoPlantilla'
EXEC spRENAME_COLUMN 'MovTipo', 'ProyectoPlantilla', 'PlantillaProyecto'
EXEC spRENAME_COLUMN 'MovTipo', 'ProyectoPlantillaFija', 'PlantillaProyectoFija'
GO
EXEC spALTER_TABLE 'MovTipo', 'ProyectoContactoTipo', 'varchar(20)'
EXEC spALTER_TABLE 'MovTipo', 'PlantillaProyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'PlantillaProyectoFija', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ProyectoLineaBase', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spDROP_COLUMN 'MovTipo', 'ProyectoPresupuestoNivel'
--EXEC spRENAME_COLUMN 'MovTipo', 'ParaContactos', 'ParaProspectos'
--EXEC spALTER_TABLE 'MovTipo', 'ParaProspectos', 'bit NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'ParaClientes', 'bit NULL	DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'ParaProveedores', 'bit NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'ParaPersonal', 'bit NULL	DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'ParaAgentes', 'bit NULL DEFAULT 0 WITH VALUES'
--EXEC spALTER_TABLE 'MovTipo', 'OportunidadMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'GastoConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'FormaTipo', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'MovTipo', 'FormaFija', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'MovTipo', 'AplicarOfertas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'FormaAnexaOmision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'TraspasoExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ModuloCentral', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'AfectarFiscal', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'SubClave', 'varchar(20) NULL'
GO
if (select version from version) <= 2121
  UPDATE MovTipo SET PV = 1 WHERE Clave IN ('VTAS.N', 'VTAS.FM')
GO
EXEC spALTER_TABLE 'MovTipo', 'DefUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'MovTipo', 'SubFoliosOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'RequiereAutorizacion', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ObligacionFiscal', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovTipo', 'ObligacionFiscalTasa', 'float NULL'
EXEC spALTER_TABLE 'MovTipo', 'ObligacionFiscalTipoImporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'EsISRReglamento', ' bit null DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'TipoConsecutivo', 'varchar(20) NULL DEFAULT "Modulo" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ConsecutivoGeneral', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'ArrastrarTipoCambioGenerarMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'AfectarCP', 'varchar(20)	NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'AplicarCP', 'varchar(20)	NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'FactorCP', 'float NULL DEFAULT 1.0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ReservarCP', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'AnticiposCP', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'EcuadorMostrarAnexo', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'GuatemalaLibroVentaExento', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'FactorFiscalEsp', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA1015
EXEC spALTER_TABLE 'MovTipo', 'FactorFiscal', 'int NULL DEFAULT NULL WITH VALUES' --MEJORA1015
GO
EXEC spAlter_Table 'MovTipo', 'eDocEstatus', 'varchar(15) NULL' --MEJORA2104
EXEC spAlter_Table 'MovTipo', 'eDoc', 'varchar(50) NULL' --MEJORA2104
EXEC spAlter_Table 'MovTipo', 'CFDFlex', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA2104
EXEC spALTER_TABLE 'MovTipo', 'CFDEsParcialidad', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'MovTipo', 'SAUXMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovTipo', 'SAUXMovInvPendiente', 'varchar(20) NULL DEFAULT "Ord Consumo Servicio" WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'SAUXMovInvConcluida', 'varchar(20) NULL DEFAULT "Consumo Material Ser" WITH VALUES'
GO
EXEC spALTER_TABLE 'MovTipo', 'DividirCatorcenas', ' bit null DEFAULT 0 WITH VALUES' --JGD 06Julio2011 Ticket 4867
GO
EXEC spALTER_TABLE 'MovTipo', 'CFDReporteJasper', 'varchar(50) NULL'
GO
EXEC spALTER_TABLE 'MovTipo', 'OpcionPermitirDescontinuado', ' bit NULL DEFAULT 0 WITH VALUES' --MEJORA5547
GO

EXEC SPALTER_TABLE 'MovTipo', 'Interno', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spFK 'MovTipo','SucursalEsp','Sucursal','Sucursal'
GO

-- 11042
EXEC spALTER_TABLE 'MovTipo', 'AFMovGenerarGastoCfg', 'varchar(20) NULL DEFAULT ''Empresa'' WITH VALUES'
GO
 --REQ12534 Factory  
 EXEC spALTER_TABLE 'MovTipo', 'SerieMES', 'varchar(3) NULL'
GO 

--REQ13163
EXEC spALTER_TABLE 'MovTipo', 'TCAccion', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'MovTipo','PrefijoSucursal', 'bit DEFAULT 0 WITH VALUES'--BUG4219
GO

EXEC spAlter_Table 'MovTipo', 'CartaPorte','bit DEFAULT 0 WITH VALUES'
EXEC spAlter_Table 'MovTipo', 'EstatusCartaPorte','varchar(15) NULL'
EXEC spAlter_Table 'MovTipo', 'RutaCartaPorte','varchar(255) NULL'
GO


/****** MovTipoAFConceptoGAS  ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoAFConceptoGAS') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoAFConceptoGAS','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoAFConceptoGAS') and type = 'U') 
CREATE TABLE dbo.MovTipoAFConceptoGAS(
  ID			int			IDENTITY,
  Mov			varchar(20)	NOT NULL,
  Categoria		varchar(50)	NULL,
  Articulo		varchar(20)	NULL,
  Serie			varchar(20)	NULL,
  Concepto		varchar(50)	NOT NULL,
  CONSTRAINT priMovTipoAFConceptoGAS PRIMARY KEY CLUSTERED(ID)
  )
GO

if (select version from version) <= 4600
  UPDATE MovTipo SET GenerarGasto = 1 WHERE Clave IN('AF.DP', 'AF.DT')
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovTipo' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave ON dbo.MovTipo (Clave)
GO

/****** MovTipoInfoPath ******/
/*if not exists(select * from SysTabla where SysTabla = 'MovTipoInfoPath')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoInfoPath','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoInfoPath') and type = 'U') 
  CREATE TABLE dbo.MovTipoInfoPath (
	Modulo		varchar(5)     	NOT NULL,
	Mov		varchar(20) 	NOT NULL,
	Plantilla	varchar(100)    NOT NULL,

	CONSTRAINT priMovTipoInfoPath PRIMARY KEY CLUSTERED (Mov, Plantilla, Modulo)
)*/
go

-- drop table MovTipoFormaAnexo
/****** MovTipoFormaAnexo ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoFormaAnexo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoFormaAnexo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoFormaAnexo') and type = 'U') 
  CREATE TABLE dbo.MovTipoFormaAnexo (
	Modulo			varchar(5)     	NOT NULL,
	Mov			varchar(20) 	NOT NULL,
	Nombre			varchar(100)	NOT NULL,

	Tipo			varchar(20)	NULL,	-- InfoPath / Intelisis
	Clave			varchar(100)    NULL,

 	ExpresionesAlAbrir	text		NULL,
 	ExpresionesAlAnexar	text		NULL,
	ExpresionesAlEliminar	text		NULL,

	CONSTRAINT priMovTipoFormaAnexo PRIMARY KEY CLUSTERED (Mov, Modulo, Nombre)
  )
go

if exists (select * from sysobjects where id = object_id('dbo.MovTipoInfoPath') and type = 'U') 
BEGIN
  EXEC ('INSERT MovTipoFormaAnexo (Modulo, Mov, Nombre, Tipo, Clave) SELECT Modulo, Mov, Plantilla, "InfoPath", Plantilla FROM MovTipoInfoPath')
  EXEC ('spDROP_TABLE "MovTipoInfoPath"')
  EXEC ('DELETE SysTabla WHERE SysTabla="MovTipoInfoPath"')
END
GO


/****** MovTipoTarea  ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoTarea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoTarea (
	Modulo		varchar(5)     	NOT NULL,
	Mov		varchar(20) 	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Tarea		varchar(100)    NULL,
	Dias		int		NULL,
	Forzosa		bit		NULL	DEFAULT 0,
	Orden		int		NULL,
	Tipo		varchar(20)	NULL,

	CONSTRAINT priMovTipoTarea PRIMARY KEY CLUSTERED (Mov, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovTipoTarea'
END
go
EXEC spALTER_TABLE 'MovTipoTarea', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'MovTipoTarea', 'Tipo', 'varchar(20) NULL'
go

/****** MovTipoObligacionFiscal  ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoObligacionFiscal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoObligacionFiscal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoObligacionFiscal') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoObligacionFiscal (
	Modulo						varchar(5)     	NOT NULL,
	Mov							varchar(20) 	NOT NULL,
	ObligacionFiscal			varchar(30)		NOT NULL,

	CONSTRAINT priMovTipoObligacionFiscal PRIMARY KEY CLUSTERED (Mov, Modulo, ObligacionFiscal)
  )
  EXEC spSincroSemilla 'MovTipoObligacionFiscal'
END
go

/****** MovTipoObligacionFiscalOmitir  ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoObligacionFiscalOmitir')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoObligacionFiscalOmitir','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoObligacionFiscalOmitir') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoObligacionFiscalOmitir (
	Modulo						varchar(5)     	NOT NULL,
	Mov							varchar(20) 	NOT NULL,
	ObligacionFiscal			varchar(30)		NOT NULL,
	OrigenModulo				varchar(50)		NOT NULL,
	OrigenMov					varchar(20)		NOT NULL,

	CONSTRAINT priMovTipoObligacionFiscalOmitir PRIMARY KEY CLUSTERED (Mov, Modulo, ObligacionFiscal, OrigenMov)
  )
  EXEC spSincroSemilla 'MovTipoObligacionFiscalOmitir'
END
go

/****** MovTipoContAuto ******/
if (select version from version) <= 2039 and exists (select * from sysobjects where id = object_id('dbo.MovTipoContAuto') and type = 'U') 
DROP TABLE MovTipoContAuto
GO
if not exists (select * from SysTabla where SysTabla = 'MovTipoContAuto') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoContAuto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoContAuto') and type = 'U') 
CREATE TABLE dbo.MovTipoContAuto (
	Empresa			varchar(10)	NOT NULL,
	Modulo			varchar(5)     	NOT NULL,
	Clave			varchar(20)	NOT NULL,
	Nombre			varchar(50)	NOT NULL,	-- Ventas, Cxc, Inventarios, IVA

	Cuenta			varchar(20)	NULL,		-- Especifica, Tipo Contacto, Concepto, Proveedor, Articulo, etc.
	CuentaOmision		varchar(20)	NULL,
	Debe			varchar(20)	NULL,		
	Haber			varchar(20)	NULL,		
	Orden			int		NULL,
	OmitirConcepto		bit		NULL	DEFAULT 0,
	Condicion		varchar(50)	NULL,
	Presupuesto		bit		NULL	DEFAULT 0,
	OmitirCentroCostos	bit		NULL	DEFAULT 0,
	Controladora		bit		NULL	DEFAULT 0,
	IncluirArticulos	bit		NULL	DEFAULT 0,
	IncluirDepartamento	bit		NULL	DEFAULT 0,
	--EsContactoAplica	bit		NULL	DEFAULT 0,
	CentroCostos		varchar(20)	NULL	DEFAULT 'Movimiento',
	Sucursal		varchar(20)	NULL	DEFAULT 'Movimiento',
	Concepto		varchar(20)	NULL	DEFAULT 'Encabezado',
	ObligacionFiscal	varchar(50)	NULL,
	ContactoEspecifico	varchar(50)	NULL,	-- Contacto, Contacto Aplica, Contacto Detalle, Cuenta Dinero, Cuenta Dinero Destino, Agente, Personal, Almacen, Almacen Destino, Almacen Detalle

	CONSTRAINT priMovTipoContAuto PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa)
)
GO
EXEC spALTER_TABLE 'MovTipoContAuto', 'Presupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'OmitirCentroCostos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'Controladora', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'IncluirArticulos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'CentroCostos', 'varchar(20) NULL	DEFAULT "Movimiento" WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'Sucursal', 'varchar(20) NULL DEFAULT "Movimiento" WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'IncluirDepartamento', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'Concepto', 'varchar(20) NULL DEFAULT "Encabezado" WITH VALUES'
--EXEC spALTER_TABLE 'MovTipoContAuto', 'EsContactoAplica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoContAuto', 'ObligacionFiscal', 'varchar(50) NULL'
GO
IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'MovTipoContAuto' AND Campo = 'EsContactoAplica') AND
   NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'MovTipoContAuto' AND Campo = 'ContactoEspecifico')
BEGIN
  EXEC spALTER_TABLE 'MovTipoContAuto', 'ContactoEspecifico', 'varchar(50) NULL'
  EXEC ("UPDATE MovTipoContAuto SET ContactoEspecifico = 'Contacto Aplica' WHERE EsContactoAplica = 1")
END
GO
EXEC spALTER_TABLE 'MovTipoContAuto', 'ContactoEspecifico', 'varchar(50) NULL'
EXEC spDROP_COLUMN 'MovTipoContAuto', 'EsContactoAplica'
GO
IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'MovTipoContAuto' AND Campo = 'Empresa')
BEGIN
  EXEC spEliminarPK 'MovTipoContAuto'
  EXEC spALTER_TABLE 'MovTipoContAuto', 'Empresa', 'varchar(10) NOT NULL DEFAULT "(Todas)" WITH VALUES'
  EXEC('ALTER TABLE MovTipoContAuto ADD CONSTRAINT priMovTipoContAuto PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa)')
END
GO

EXEC spFK 'MovTipoContAuto','CuentaOmision','Cta','Cuenta'
GO
--Optimización Bug 18308
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovTipoContAuto' AND sysindexes.name = 'ClaveModulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ClaveModulo ON MovTipoContAuto(Clave,Modulo,Empresa)
GO
/****** MovTipoContAutoCampoExtra ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoContAutoCampoExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoContAutoCampoExtra', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoContAutoCampoExtra') and type = 'U') 
  CREATE TABLE dbo.MovTipoContAutoCampoExtra (
	Modulo			varchar(5)     	NOT NULL,
	Campo			varchar(20)	NOT NULL,

	CONSTRAINT priMovTipoContAutoCampoExtra PRIMARY KEY  CLUSTERED (Modulo, Campo)
)
GO

/****** MovTipoContAutoCuentaExtra ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoContAutoCuentaExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoContAutoCuentaExtra', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoContAutoCuentaExtra') and type = 'U') 
  CREATE TABLE dbo.MovTipoContAutoCuentaExtra (
	Modulo			varchar(5)     	NOT NULL,
	Cuenta			varchar(20)	NOT NULL,

	CONSTRAINT priMovTipoContAutoCuentaExtra PRIMARY KEY  CLUSTERED (Modulo, Cuenta)
)
GO

/*
  INSERT MovTipoContAutoCampoExtra  VALUES ('VTAS', 'Importe Extra')
  INSERT MovTipoContAutoCuentaExtra VALUES ('VTAS', 'Cuenta Extra')
*/
-- drop table MovTipoContAutoTabla
/****** MovTipoContAutoTabla ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoContAutoTabla') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoContAutoTabla', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoContAutoTabla') and type = 'U') 
  CREATE TABLE dbo.MovTipoContAutoTabla (
	Empresa			varchar(10)	NOT NULL,
	Modulo			varchar(5)     	NOT NULL,
	Clave			varchar(20)	NOT NULL,
	Nombre			varchar(50)	NOT NULL,	-- Ventas, Cxc, Inventarios, IVA
	Porcentaje		money		NOT NULL,
	Excento			bit		NOT NULL	DEFAULT 0,

	Cuenta			varchar(20)	NULL

	CONSTRAINT priMovTipoContAutoTabla PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa, Porcentaje, Excento)
)
GO
EXEC spALTER_TABLE 'MovTipoContAutoTabla', 'Excento', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version) <=3091
BEGIN
  EXEC spEliminarPK 'MovTipoContAutoTabla'
  EXEC('ALTER TABLE MovTipoContAutoTabla ADD CONSTRAINT priMovTipoContAutoTabla PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Porcentaje, Excento)')
END
GO
IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'MovTipoContAutoTabla' AND Campo = 'Empresa')
BEGIN
  EXEC spEliminarPK 'MovTipoContAutoTabla'
  EXEC spALTER_TABLE 'MovTipoContAutoTabla', 'Empresa', 'varchar(10) NOT NULL DEFAULT "(Todas)" WITH VALUES'
  EXEC('ALTER TABLE MovTipoContAutoTabla ADD CONSTRAINT priMovTipoContAutoTabla PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa, Porcentaje, Excento)')
END
GO

EXEC spFK 'MovTipoContAutoTabla','Cuenta','Cta','Cuenta'
GO

/****** MovTipoContAutoLoteFijo ******/
if not exists(select * from SysTabla where SysTabla = 'MovTipoContAutoLoteFijo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoContAutoLoteFijo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoContAutoLoteFijo') and type = 'U') 
CREATE TABLE dbo.MovTipoContAutoLoteFijo (
	Empresa			varchar(10)	NOT NULL,
	Modulo			varchar(5)     	NOT NULL,
	Clave			varchar(20)	NOT NULL,
	Nombre			varchar(50)	NOT NULL,	-- Ventas, Cxc, Inventarios, IVA
	Lote			varchar(20) 	NOT NULL,

	Impuesto1		float		NULL,
	Impuesto2		float		NULL,
	Impuesto3		float		NULL,
	Impuesto5		float		NULL,

	Cuenta1			varchar(20)	NULL,
	Cuenta2			varchar(20)	NULL,
	Cuenta3			varchar(20)	NULL,
	Cuenta5			varchar(20)	NULL,

	CONSTRAINT priMovTipoContAutoLoteFijo PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa, Lote)
)
go
IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'MovTipoContAutoLoteFijo' AND Campo = 'Empresa')
BEGIN
  EXEC spEliminarPK 'MovTipoContAutoLoteFijo'
  EXEC spALTER_TABLE 'MovTipoContAutoLoteFijo', 'Empresa', 'varchar(10) NOT NULL DEFAULT "(Todas)" WITH VALUES'
  EXEC('ALTER TABLE MovTipoContAutoLoteFijo ADD CONSTRAINT priMovTipoContAutoLoteFijo PRIMARY KEY  CLUSTERED (Clave, Nombre, Modulo, Empresa, Lote)')
END
GO

EXEC spALTER_TABLE 'MovTipoContAutoLoteFijo', 'Impuesto5', 'float NULL'
EXEC spALTER_TABLE 'MovTipoContAutoLoteFijo', 'Cuenta5', 'varchar(20) NULL'
GO

EXEC spFK 'MovTipoContAutoLoteFijo','Cuenta1','Cta','Cuenta'
GO

/****** MovTipoForma ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoForma') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoForma', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoForma') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoForma (
	Modulo		varchar(5)     	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),
	
	Campo		varchar(50)	NULL,
	TipoAyuda	varchar(20)	NULL,
	Orden		int		NULL,

	CONSTRAINT priMovTipoForma PRIMARY KEY  CLUSTERED (Mov, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovTipoForma'
END
GO

/****** MovTipoFormaAyuda ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoFormaAyuda') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoFormaAyuda', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoFormaAyuda') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoFormaAyuda (
	Modulo		varchar(5)     	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	Campo		varchar(50)	NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),
	
	Ayuda		varchar(100)	NULL,
	Orden		int		NULL,

	CONSTRAINT priMovTipoFormaAyuda PRIMARY KEY  CLUSTERED (Mov, Campo, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovTipoFormaAyuda'
END
GO

/****** MovTipoConsecutivo ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoConsecutivo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoConsecutivo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoConsecutivo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovTipoConsecutivo (
	Modulo		varchar(5)      	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	Empresa		varchar(5)		NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),
	
	Serie		varchar(20)	NULL,
	ConsecutivoD	int		NULL,
	ConsecutivoA	int		NULL,
	VigenciaD	datetime	NULL,
	VigenciaA	datetime	NULL,
	Estatus		varchar(15)	NULL,

	CONSTRAINT priMovTipoConsecutivo PRIMARY KEY  CLUSTERED (Mov, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovTipoConsecutivo'
END
GO

if (select version from version)<=2780
BEGIN
  EXEC ("if exists (select * from sysobjects where id = object_id('dbo.MovTipoCampoExtra') and type = 'U') DROP Table MovTipoCampoExtra")
  EXEC ("if exists (select * from sysobjects where id = object_id('dbo.CtoTipoCampoExtra') and type = 'U') DROP Table CtoTipoCampoExtra")
  EXEC ("if exists (select * from sysobjects where id = object_id('dbo.MovCampoExtra') and type = 'U') DROP Table MovCampoExtra")
  EXEC ("if exists (select * from sysobjects where id = object_id('dbo.CtoCampoExtra') and type = 'U') DROP Table CtoCampoExtra")
  EXEC ("if exists (select * from sysobjects where id = object_id('dbo.CampoExtra') and type = 'U') DROP Table CampoExtra")
END
GO

/****** MovTipoCampoExtra ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoCampoExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoCampoExtra', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoCampoExtra') and type = 'U') 
  CREATE TABLE dbo.MovTipoCampoExtra (
	Modulo		varchar(5)      	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	CampoExtra	varchar(50)	NOT NULL,
	
	Grupo		varchar(50)	NULL,
	Requerido	bit		NULL	DEFAULT 0,
	Orden		int		NULL,

	CONSTRAINT priMovTipoCampoExtra PRIMARY KEY  CLUSTERED (Mov, Modulo, CampoExtra)
  )
GO
EXEC spALTER_TABLE 'MovTipoCampoExtra', 'Orden', 'int NULL'
GO

EXEC spFK 'MovTipoCampoExtra','CampoExtra','CampoExtra','CampoExtra'
GO

/****** MovTipoNomAutoCalendarioEsp ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoNomAutoCalendarioEsp') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTipoNomAutoCalendarioEsp', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoNomAutoCalendarioEsp') and type = 'U') 
  CREATE TABLE dbo.MovTipoNomAutoCalendarioEsp (
	Modulo		varchar(5)      	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	FechaNomina	datetime	NOT NULL,
	
	IncidenciaD	datetime	NULL,
	IncidenciaA	datetime	NULL,
	Cerrado		bit		NULL	DEFAULT 0,

	CONSTRAINT priMovTipoNomAutoCalendarioEsp PRIMARY KEY  CLUSTERED (Mov, Modulo, FechaNomina)
  )
GO
EXEC spALTER_TABLE 'MovTipoNomAutoCalendarioEsp', 'EsFinMes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipoNomAutoCalendarioEsp', 'EsFinBimestre', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** CtoTipoCampoExtra ******/
if not exists (select * from SysTabla where SysTabla = 'CtoTipoCampoExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CtoTipoCampoExtra', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtoTipoCampoExtra') and type = 'U') 
  CREATE TABLE dbo.CtoTipoCampoExtra (
	Tipo		varchar(20)	NOT NULL,
	SubTipo		varchar(20)	NOT NULL,
	CampoExtra	varchar(50)	NOT NULL,
	
	Grupo		varchar(50)	NULL,
	Requerido	bit		NULL	DEFAULT 0,
	Orden		int		NULL,

	CONSTRAINT priCtoTipoCampoExtra PRIMARY KEY  CLUSTERED (Tipo, SubTipo, CampoExtra)
  )
GO
EXEC spALTER_TABLE 'CtoTipoCampoExtra', 'Orden', 'int NULL'
GO

EXEC spFK 'CtoTipoCampoExtra','CampoExtra','CampoExtra','CampoExtra'
GO

/****** MovCampoExtra ******/
if not exists (select * from SysTabla where SysTabla = 'MovCampoExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovCampoExtra', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovCampoExtra', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MovCampoExtra') and type = 'U') 
  CREATE TABLE dbo.MovCampoExtra (
	Modulo		varchar(5)      	NOT NULL,
	Mov		varchar(20)	NOT NULL,
	ID		int		NOT NULL,
	CampoExtra	varchar(50)	NOT NULL,

	Valor			varchar(255)	NULL,
	ValorAnterior		varchar(255)	NULL,
	Puntos			float		NULL,
	PuntosAnteriores 	float		NULL,

	CONSTRAINT priMovCampoExtra PRIMARY KEY  CLUSTERED (ID, Modulo, Mov, CampoExtra)
  )
GO
EXEC spALTER_TABLE 'MovCampoExtra', 'ValorAnterior', 'varchar(255) NULL'
EXEC spALTER_TABLE 'MovCampoExtra', 'Puntos', 'float NULL'
EXEC spALTER_TABLE 'MovCampoExtra', 'PuntosAnteriores', 'float NULL'
GO
/****** CtoCampoExtra ******/
if not exists (select * from SysTabla where SysTabla = 'CtoCampoExtra') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CtoCampoExtra', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CtoCampoExtra') and type = 'U') 
  CREATE TABLE dbo.CtoCampoExtra (
	Tipo		varchar(20)    	NOT NULL,
	SubTipo		varchar(20)	NOT NULL,
	Clave		varchar(20)	NOT NULL,
	CampoExtra	varchar(50)	NOT NULL,

	Valor		varchar(255)	NULL,
	Puntos		float		NULL,

	CONSTRAINT priCtoCampoExtra PRIMARY KEY  CLUSTERED (Clave, Tipo, SubTipo, CampoExtra)
  )
GO
EXEC spALTER_TABLE 'CtoCampoExtra', 'Puntos', 'float NULL'
GO

/****** CampoExtraAyudaLista ******/
if not exists (select * from SysTabla where SysTabla = 'CampoExtraAyudaLista') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CampoExtraAyudaLista', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampoExtraAyudaLista') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CampoExtraAyudaLista (
	CampoExtra	varchar(50)	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	Orden		int		NULL,
	Opcion		varchar(255)	NULL,
	Puntos		float		NULL,

	CONSTRAINT priCampoExtraAyudaLista PRIMARY KEY CLUSTERED (CampoExtra, ID)
  )
  EXEC spSincroSemilla 'CampoExtraAyudaLista'
END
GO
EXEC spALTER_TABLE 'CampoExtraAyudaLista', 'Puntos', 'float NULL'
GO

/****** CampoExtra  ******/
if not exists (select * from SysTabla where SysTabla = 'CampoExtra') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CampoExtra','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CampoExtra') and type = 'U') 
CREATE TABLE dbo.CampoExtra (
	CampoExtra		varchar(50)     NOT NULL,
	
	Prefijo			varchar(20)	NULL,
	Base			varchar(20)	NULL,
	Sufijo			varchar(20)	NULL,

	Nombre			varchar(100)	NULL,
	AyudaTipo		varchar(50)	NULL,
	AyudaReferencia		varchar(50)	NULL,
	AyudaExpresion		text		NULL,
	ValidacionTipo		varchar(50)	NULL,
	ValidacionTabla		varchar(50)	NULL,
	ValidacionCampo		varchar(50)	NULL,
	ValidacionReferencia	varchar(50)	NULL,
	ValidacionExpresion	text		NULL,
	Mascara			varchar(50)	NULL,
	
	
	CONSTRAINT priCampoExtra PRIMARY KEY CLUSTERED (CampoExtra)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCampoExtraBC') and sysstat & 0xf = 8) drop trigger dbo.tgCampoExtraBC
GO
EXEC spALTER_TABLE 'CampoExtra', 'ValidacionTabla', 'varchar(50) NULL'
GO
-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgCampoExtraBC ON CampoExtra
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @CampoExtraN  varchar(50),
    @CampoExtraA  varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CampoExtraN = CampoExtra FROM Inserted
  SELECT @CampoExtraA = CampoExtra FROM Deleted
  
  IF @CampoExtraA = @CampoExtraN RETURN

  IF EXISTS(SELECT * FROM MovCampoExtra WHERE CampoExtra = @CampoExtraA) OR EXISTS(SELECT * FROM CtoCampoExtra WHERE CampoExtra = @CampoExtraA)
  BEGIN
    RAISERROR ('Campo Extra en Uso',16,-1) 
    RETURN
  END

  IF @CampoExtraN IS NULL
  BEGIN
    DELETE MovTipoCampoExtra    WHERE CampoExtra = @CampoExtraA
    DELETE CtoTipoCampoExtra    WHERE CampoExtra = @CampoExtraA
    DELETE CampoExtraAyudaLista WHERE CampoExtra = @CampoExtraA
  END ELSE
  BEGIN
    UPDATE MovTipoCampoExtra    SET CampoExtra = @CampoExtraN WHERE CampoExtra = @CampoExtraA
    UPDATE CtoTipoCampoExtra    SET CampoExtra = @CampoExtraN WHERE CampoExtra = @CampoExtraA
    UPDATE CampoExtraAyudaLista SET CampoExtra = @CampoExtraN WHERE CampoExtra = @CampoExtraA
  END
END
GO



/****** MovForma ******/
if not exists (select * from SysTabla where SysTabla = 'MovForma') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovForma', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.MovForma') and type = 'U') 
CREATE TABLE dbo.MovForma (
	Modulo		varchar(5)      	NOT NULL,
	ID		int		NOT NULL,
	Mov		varchar(20)	NOT NULL,
	RID		int		NOT NULL 	IDENTITY(1,1),
	
	Orden		int		NULL,
	Sucursal	int		NULL,
	Campo		varchar(50)	NULL,
	Valor		varchar(100)	NULL,

	CONSTRAINT priMovForma PRIMARY KEY  CLUSTERED (ID, Mov, Modulo, RID)
)
GO

/****** CtoTipo ******/
if not exists (select * from SysTabla where SysTabla = 'CtoTipo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CtoTipo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CtoTipo') and type = 'U') 
CREATE TABLE dbo.CtoTipo (
	Tipo			varchar(20)      	NOT NULL,	-- Cliente, Proveedor, Agente, Personal
	SubTipo			varchar(20)	NOT NULL,	-- Cliente, Deudor, etc.

	Cuenta			varchar(20)	NULL,

	CONSTRAINT priCtoTipo PRIMARY KEY  CLUSTERED (Tipo, SubTipo)
)
GO

EXEC spFK 'CtoTipo','Cuenta','Cta','Cuenta'
GO

/****** Turnos ******/
if not exists (select * from SysTabla where SysTabla = 'MovTurno') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovTurno', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTurno') and type = 'U') 
  CREATE TABLE dbo.MovTurno (
	Turno			int	NOT NULL,

	HoraD			varchar(5)	NOT NULL,
	HoraA			varchar(5)	NOT NULL,

	CONSTRAINT priMovTurno PRIMARY KEY CLUSTERED (Turno)
  )
go
if not exists (select * from MovTurno)
begin
  INSERT MovTurno (Turno, HoraD, HoraA) VALUES (1, '08:00', '15:00')
  INSERT MovTurno (Turno, HoraD, HoraA) VALUES (2, '15:00', '23:00')
  INSERT MovTurno (Turno, HoraD, HoraA) VALUES (3, '23:00', '08:00')
end
GO


/****** MovTipoIncidencias  ******/
if not exists (select * from SysTabla where SysTabla = 'MovTipoIncidencias') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoIncidencias','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovTipoIncidencias') and type = 'U') 
CREATE TABLE dbo.MovTipoIncidencias (
	Modulo			varchar(5)      	NOT NULL,
	Mov 		        varchar(20)        NOT NULL,
	Incidencia		varchar(20)        NOT NULL,
	Concepto		varchar(50)     NOT NULL	DEFAULT '(Todos)',

	CONSTRAINT priMovTipoIncidencias PRIMARY KEY CLUSTERED (Mov, Incidencia, Modulo, Concepto)
)
GO
EXEC spALTER_TABLE 'MovTipoIncidencias', 'Concepto', 'varchar(50) NOT NULL DEFAULT "(Todos)" WITH VALUES'
GO
if (select version from version)<=2262
begin
  EXEC("spEliminarPK 'MovTipoIncidencias'")
  EXEC("ALTER TABLE MovTipoIncidencias ADD CONSTRAINT priMovTipoIncidencias PRIMARY KEY CLUSTERED (Modulo, Mov, Incidencia, Concepto)")
end
go

/****** MovClave ******/
if exists (select * from sysobjects where id = object_id('dbo.MovClave') and type = 'U') AND (select version from version) <= 1468 
DROP TABLE MovClave
GO
if not exists (select * from SysTabla where SysTabla = 'MovClave') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovClave', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovClave') and type = 'U') 
CREATE TABLE dbo.MovClave (
	Modulo			varchar(5)      	NOT NULL,
	Clave			varchar(20)	NOT NULL,

	NombreOmision		varchar(100)	NULL,
	Descripcion		varchar(255)	NULL,
	Grupo			varchar(100)	NULL,
	Factor			money		NULL,
	Folio			int		NOT NULL IDENTITY(1,1),

	ContMov			varchar(20)	NULL,
	EstatusContabilizar	varchar(15)	NULL	DEFAULT 'CONCLUIDO',
	AfectarPresupuesto	varchar(30)	NULL,
	SubClaveDe		varchar(20)	NULL,
	--AfectarFiscal		varchar(20)	NULL,

	CONSTRAINT priMovClave PRIMARY KEY CLUSTERED (Clave, Modulo)
)
GO
EXEC spALTER_TABLE 'MovClave', 'ContMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MovClave', 'EstatusContabilizar', 'varchar(15)	NULL DEFAULT "CONCLUIDO" WITH VALUES'
EXEC spALTER_TABLE 'MovClave', 'AfectarPresupuesto', 'varchar(30) NULL'
EXEC spDROP_COLUMN 'MovClave', 'AfectarFiscal'
EXEC spALTER_TABLE 'MovClave', 'SubClaveDe', 'varchar(20) NULL'
GO
if exists(select * from SysTipoDatos where Tabla = 'MovClave' AND Campo = 'AfectarPresupuesto' and Tamano<30)
  ALTER TABLE MovClave ALTER COLUMN AfectarPresupuesto varchar(30) NULL
go
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovClave' AND sysindexes.name = 'Clave' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Clave ON dbo.MovClave (Clave, Modulo)
GO

/****** IdiomaEtiqueta ******/
if (select version from version)<=2439 
  delete SysTabla where SysTabla = 'IdiomaEtiqueta'
GO
if not exists (select * from SysTabla where SysTabla = 'IdiomaEtiqueta') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IdiomaEtiqueta', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.IdiomaEtiqueta') and type = 'U') 
  CREATE TABLE dbo.IdiomaEtiqueta (
	Idioma			varchar(50)	NOT NULL,
	Etiqueta		varchar(255)	NOT NULL,

	Nombre			varchar(255)	NULL,

	CONSTRAINT priIdiomaEtiqueta PRIMARY KEY  CLUSTERED (Etiqueta, Idioma)
)
GO

/**************** spIdiomaEtiquedaAutoAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIdiomaEtiquedaAutoAgregar') and type = 'P') 
  drop procedure dbo.spIdiomaEtiquedaAutoAgregar
GO
CREATE PROCEDURE spIdiomaEtiquedaAutoAgregar
		    @idioma		varchar(50),
		    @Etiqueta		varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Idioma = NULLIF(NULLIF(RTRIM(@Idioma), ''), '0'), @Etiqueta = NULLIF(NULLIF(RTRIM(@Etiqueta), ''), '0')
  IF @Idioma IS NOT NULL AND @Etiqueta IS NOT NULL
    IF NOT EXISTS(SELECT * FROM IdiomaEtiqueta WHERE Idioma = @Idioma AND Etiqueta = @Etiqueta)
      INSERT IdiomaEtiqueta (Idioma, Etiqueta) VALUES (@Idioma, @Etiqueta)
END
GO

/****** IdiomaCampo ******/
if not exists (select * from SysTabla where SysTabla = 'IdiomaCampo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('IdiomaCampo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.IdiomaCampo') and type = 'U') 
  CREATE TABLE dbo.IdiomaCampo (
	Idioma			varchar(50)	NOT NULL,
	Campo			varchar(255)	NOT NULL,

	CONSTRAINT priIdiomaCampo PRIMARY KEY  CLUSTERED (Idioma, Campo)
)
GO

/****** MensajeInstitucionClase  ******/
if not exists(select * from SysTabla where SysTabla = 'MensajeInstitucionClase') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MensajeInstitucionClase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeInstitucionClase') and type = 'U') 
CREATE TABLE dbo.MensajeInstitucionClase (
	Clasificacion		varchar(50)	NOT NULL,
	Descripcion		varchar(255)	NULL,
	Orden			int		NULL,

	CONSTRAINT priMensajeInstitucionClase PRIMARY KEY  CLUSTERED (Clasificacion)
)
GO
EXEC spALTER_TABLE 'MensajeInstitucionClase', 'Descripcion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'MensajeInstitucionClase', 'Orden', 'int NULL'
GO

/****** MensajeInstitucion  ******/
if not exists(select * from SysTabla where SysTabla = 'MensajeInstitucion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MensajeInstitucion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeInstitucion') and type = 'U') 
CREATE TABLE dbo.MensajeInstitucion (
	Institucion			varchar(20)	NOT NULL,
	Mensaje				varchar(10)	NOT NULL,
	Descripcion			varchar(255)	NULL,
	ConciliarMismaFecha		bit		NULL	DEFAULT 0,
	TipoMovimiento			varchar(20)	NULL,
	ConceptoGasto			varchar(50)	NULL,
	PermiteAbonoNoIdentificado	bit		NULL	DEFAULT 0,
	Clasificacion			varchar(50)	NULL,
	NaturalezaMovimiento	varchar(20)	NULL,

	CONSTRAINT priMensajeInstitucion PRIMARY KEY  CLUSTERED (Institucion, Mensaje)
)
GO
EXEC spALTER_TABLE 'MensajeInstitucion', 'ConciliarMismaFecha', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MensajeInstitucion', 'TipoMovimiento', 'varchar(20) NULL'
EXEC spALTER_TABLE 'MensajeInstitucion', 'ConceptoGasto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MensajeInstitucion', 'PermiteAbonoNoIdentificado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MensajeInstitucion', 'Clasificacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MensajeInstitucion', 'NaturalezaMovimiento', 'varchar(20) NULL'
GO

/****** MensajeLayout  ******/
if not exists(select * from SysTabla where SysTabla = 'MensajeLayout') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MensajeLayout','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeLayout') and type = 'U') 
CREATE TABLE dbo.MensajeLayout (
	Layout					varchar(20)	NOT NULL,
	Mensaje					varchar(10)	NOT NULL,
	Descripcion				varchar(255)	NULL,
	TipoMovimiento			varchar(20)	NULL,
	NaturalezaMovimiento	varchar(20)	NULL,
	ConciliarMismaFecha		bit		NULL	DEFAULT 0,

	CONSTRAINT priMensajeLayout PRIMARY KEY  CLUSTERED (Layout, Mensaje)
)
GO

/****** Acronimo ******/
if not exists(select * from SysTabla where SysTabla = 'Acronimo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Acronimo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Acronimo') and type = 'U') 
CREATE TABLE dbo.Acronimo (
	Acronimo	varchar(10)	NOT NULL, 
	Termino		varchar(100)	NULL,

	CONSTRAINT priAcronimo PRIMARY KEY CLUSTERED (Acronimo)
)
GO


/****** Direcciones ******/
if not exists(select * from SysTabla where SysTabla = 'Direccion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Direccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Direccion') and type = 'U') 
CREATE TABLE dbo.Direccion (
        Direccion 		varchar(50)	NOT NULL,

	Rama          		varchar(5)		NULL,
  	CuentaSingular 		varchar(50)	NULL,
  	CuentaPlural 		varchar(50)	NULL,
  	GrupoSingular  		varchar(50)	NULL,
  	GrupoPlural  		varchar(50)	NULL,
	EsMonetario		bit		NOT NULL DEFAULT 1,
	EsUnidades		bit 		NOT NULL DEFAULT 0,
	EsContable		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priDireccion PRIMARY KEY CLUSTERED (Direccion)
)
GO

/****** ContX ******/
if not exists(select * from SysTabla where SysTabla = 'ContX') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContX','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContX') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContX (
	ID			int		NOT NULL IDENTITY(1,1),

	Empresa			varchar(7)		NULL DEFAULT '(Todas)',
	Modulo			varchar(5)		NULL,
	Mov       		varchar(20)	NULL,
	Conceptos		varchar(255)	NULL,
	ContMov			varchar(255)	NULL,
	ContConcepto		varchar(255)	NULL,
	ContReferencia		varchar(255)	NULL,
	ContProyecto		varchar(255)	NULL,
	ContObservaciones	varchar(255) 	NULL,
	ContUEN			varchar(255) 	NULL,
	ContContacto		varchar(255) 	NULL,
	ContContactoTipo	varchar(255) 	NULL,
	ContIntercompania	varchar(255) 	NULL,
	ContAfectarPresupuesto	varchar(20)	NULL	DEFAULT 'No',
	--ContAfectarFiscal	varchar(20)	NULL	DEFAULT 'No',
	Moneda			varchar(255)	NULL,
	TipoCambio		varchar(255) 	NULL,
	Condicion		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,
	Estatus			char(15)	NULL,

	ConceptoNull		bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	EnLinea			bit		NULL	 DEFAULT 0,

	CONSTRAINT priContX PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ContX'
END
GO
EXEC spALTER_TABLE 'ContX', 'EnLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ContX', 'ContUEN', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContX', 'ContContacto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContX', 'ContContactoTipo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContX', 'ContIntercompania', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContX', 'ContAfectarPresupuesto', 'varchar(20) NULL	DEFAULT "No" WITH VALUES'
EXEC spDROP_COLUMN 'ContX', 'ContAfectarFiscal'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ContX' AND sysindexes.name = 'Mov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Mov ON dbo.ContX (Mov, Modulo, Empresa)
GO

/****** ContXD ******/
if not exists(select * from SysTabla where SysTabla = 'ContXD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContXD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContXD') and type = 'U') 
CREATE TABLE dbo.ContXD (
	ID			int		NOT NULL,
	Renglon			float		NOT NULL,

	Orden			int		NULL,
	UnaVez			char(2)		NULL,
	Cuenta			varchar(255)	NULL,
	SubCuenta		varchar(255)	NULL,
	SubCuenta2		varchar(255)	NULL,
	SubCuenta3		varchar(255)	NULL,
	Concepto		varchar(255)	NULL,
	Articulo		varchar(255)	NULL,
	Debe			varchar(255)	NULL,
	Debe2			varchar(255)	NULL,
	Haber			varchar(255)	NULL,
	Haber2			varchar(255)	NULL,
	Condicion		varchar(255)	NULL,
	Comentarios		varchar(255)	NULL,
	Presupuesto		bit		NULL	DEFAULT 0,
	SucursalContable	varchar(255)	NULL,
	ContactoEspecifico	varchar(255)	NULL,

	CONSTRAINT priContXD PRIMARY KEY CLUSTERED (ID, Renglon)
)
GO
EXEC spALTER_TABLE 'ContXD', 'Presupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ContXD', 'SucursalContable', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'Debe2', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'Haber2', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'Articulo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'ContactoEspecifico', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'SubCuenta2', 'varchar(255) NULL'
EXEC spALTER_TABLE 'ContXD', 'SubCuenta3', 'varchar(255) NULL'
GO

/****** ContXCta ******/
if not exists(select * from SysTabla where SysTabla = 'ContXCta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContXCta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContXCta') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ContXCta (
	ID			int		NOT NULL IDENTITY(1,1),

	CuentaContable		varchar(20)	NULL,
	Cuenta			varchar(20)	NULL,
	SubCuenta		varchar(50)	NULL,
	TipoCuenta		varchar(20)	NULL, 

	CONSTRAINT priContXCta PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ContXCta'
END
GO
EXEC spALTER_COLUMN 'ContXCta', 'Cuenta', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'ContXCta', 'SubCuenta', 'varchar(50) NULL'
GO

EXEC spFK 'ContXCta','CuentaContable','Cta','Cuenta'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgContXCtaAC') and sysstat & 0xf = 8) drop trigger dbo.tgContXCtaAC
GO
CREATE TRIGGER tgContXCtaAC ON ContXCta
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @ID			int,
    @TipoCuenta		varchar(20),
    @Cuenta		varchar(20),
    @SubCuenta		varchar(50),
    @CuentaContable	varchar(20),
    @Mensaje		varchar(255)
    
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @TipoCuenta = ISNULL(TipoCuenta, ''), @Cuenta = ISNULL(Cuenta, ''), @SubCuenta = ISNULL(SubCuenta, ''), @CuentaContable = ISNULL(CuentaContable, '') FROM INSERTED

  IF @TipoCuenta NOT IN ('Conceptos Gastos') AND EXISTS(SELECT * FROM ContXCta WHERE ID <> @ID AND ISNULL(TipoCuenta, '') = @TipoCuenta AND ISNULL(Cuenta, '') = @Cuenta AND ISNULL(SubCuenta, '') = @SubCuenta)
  BEGIN
    SELECT @Mensaje = '"'+@TipoCuenta+' '+@Cuenta+' '+@SubCuenta+' - '+@CuentaContable+'" ' + Descripcion FROM MensajeLista WHERE Mensaje = 40110
    RAISERROR (@Mensaje,16,-1) 
  END
END
GO

/****** ContXProcesar ******/
if not exists(select * from SysTabla where SysTabla = 'ContXProcesar') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('ContXProcesar','Movimiento','CONT')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('ContXProcesar')
if not exists (select * from sysobjects where id = object_id('dbo.ContXProcesar') and type = 'U') 
CREATE TABLE dbo.ContXProcesar (
	Modulo		varchar(5)		NOT NULL,
	ID		int		NOT NULL,

	CONSTRAINT priContXProcesar PRIMARY KEY CLUSTERED (ID, Modulo)
)
GO

/****** ContXCtaConcepto ******/
if not exists(select * from SysTabla where SysTabla = 'ContXCtaConcepto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ContXCtaConcepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ContXCtaConcepto') and type = 'U') 
CREATE TABLE dbo.ContXCtaConcepto (
	Modulo			varchar(5)		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Cuenta         		varchar(20)	NULL,

	CONSTRAINT priContXCtaConcepto PRIMARY KEY CLUSTERED (Concepto, Modulo)
)
GO

EXEC spFK 'ContXCtaConcepto','Cuenta','Cta','Cuenta'
GO

/****** NomX ******/
if not exists(select * from SysTabla where SysTabla = 'NomX') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomX','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomX') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NomX (
	ID			int		NOT NULL IDENTITY(1,1),

	Nombre			varchar(100)	NULL,
	Empresa			varchar(7)		NULL DEFAULT '(Todas)',
	Moneda			varchar(10)	NULL,
	NomMov			varchar(255)	NULL,
	NomConcepto		varchar(255)	NULL,
	NomProyecto		varchar(255)	NULL,
	NomObservaciones	varchar(255) 	NULL,
	Condicion		varchar(255)	NULL,
	Estatus			varchar(15)	NULL,
	Finiquito		bit		NOT NULL DEFAULT 0,
	AceptaBajas		bit		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	GastoClase		varchar(50)	NULL,
	GastoSubClase		varchar(50)	NULL,
	FiltrarUltimoDiaPagado	bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNomX PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'NomX'
END
GO
EXEC spALTER_TABLE 'NomX', 'Finiquito', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NomX', 'AceptaBajas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'NomX', 'GastoClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NomX', 'GastoSubClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'NomX', 'FiltrarUltimoDiaPagado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO
--DSG
EXEC spALTER_TABLE 'NomX', 'TipoNominaG4', 'varchar(50) NULL'
GO

/****** NomXFormula ******/
if (select version from version)<=2308 AND exists (select * from sysobjects where id = object_id('dbo.NomXFormula') and type = 'U')
  and (select TipoDatos from systipoDatos where Tabla = 'NomXFormula' AND Campo = 'Expresion') <> 'text'
  ALTER TABLE NomXFormula ALTER COLUMN Expresion text NULL
GO
if not exists(select * from SysTabla where SysTabla = 'NomXFormula') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXFormula','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.NomXFormula') and type = 'U') 
CREATE TABLE dbo.NomXFormula (
	ID			int		NOT NULL,
	Formula			varchar(50)	NOT NULL,

	Orden			int		NULL,
	Expresion		text		NULL,
	Comentarios		varchar(100)	NULL,
	Tipo			varchar(20)	NULL,		-- Acumulador / Formula
	Calculo			varchar(20)	NULL,		-- Previo / Final
	FormulaCerrada		bit		NULL	 DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priNomXFormula PRIMARY KEY CLUSTERED (ID, Formula)
)
GO
EXEC spALTER_TABLE 'NomXFormula', 'FormulaCerrada', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** NomXPersonalGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'NomXPersonalGrupo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXPersonalGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXPersonalGrupo') and type = 'U') 
CREATE TABLE dbo.NomXPersonalGrupo (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,
	Personal		varchar(10)	NOT NULL,

	CONSTRAINT priNomXPersonalGrupo PRIMARY KEY CLUSTERED (ID, Concepto, Personal)
)
GO

EXEC spFK 'NomXPersonalGrupo','Personal','Personal','Personal'
GO

/****** NomXPersonal ******/
if not exists(select * from SysTabla where SysTabla = 'NomXPersonal') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXPersonal','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXPersonal') and type = 'U') 
CREATE TABLE dbo.NomXPersonal (
	ID					int			NOT NULL,
	Concepto			varchar(50)	NOT NULL,

	Orden				int				NULL,
	Condicion			varchar(255)	NULL,
	Referencia			varchar(255)	NULL,
	Cantidad			varchar(255)	NULL,
	Percepcion			varchar(255)	NULL,
	Deduccion			varchar(255)	NULL,
	Importe				varchar(255)	NULL,
	Acum				varchar(255)	NULL,
	Comentarios			varchar(100)	NULL,
	Aplica				varchar(20)		NULL, 	-- Todos, Todos menos Grupo, Grupo
	CuentaDebe			varchar(255)	NULL,
	CuentaHaber			varchar(255)	NULL,
	CuentaContAuto		varchar(255)	NULL,
	ObligacionFiscal	varchar(255)	NULL,
	ClavePresupuestal	varchar(50)		NULL, --REQ 13451

	CONSTRAINT priNomXPersonal PRIMARY KEY CLUSTERED (ID, Concepto)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgNomXPersonalBC') and sysstat & 0xf = 8) drop trigger dbo.tgNomXPersonalBC
GO
EXEC spALTER_TABLE 'NomXPersonal', 'CuentaDebe', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXPersonal', 'CuentaHaber', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXPersonal', 'CuentaContAuto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXPersonal', 'ObligacionFiscal', 'varchar(255) NULL'
GO
EXEC spALTER_TABLE 'NomXPersonal', 'ClavePresupuestal', 'varchar(50) NULL' --REQ 13451
GO

if (select version from version)<=1459
begin
  ALTER TABLE NomXPersonal ALTER COLUMN CuentaDebe varchar(255)
  ALTER TABLE NomXPersonal ALTER COLUMN CuentaHaber varchar(255)
end
GO
if (select version from version)<=2327
  ALTER TABLE NomXPersonal ALTER COLUMN CuentaContAuto varchar(255)
GO
if (select version from version)<=2327
  UPDATE NomXPersonal SET CuentaContAuto = "'"+RTRIM(CuentaContAuto)+"'" WHERE NULLIF(RTRIM(CuentaContAuto), '') IS NOT NULL
GO

EXEC spFK 'NomXPersonal','ID','NomX','ID'
GO

-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgNomXPersonalBC ON NomXPersonal
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ConceptoN  varchar(50),
    @ConceptoA	varchar(50),
    @IDN 	int,
    @IDA 	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @IDN = ID, @ConceptoN = Concepto FROM Inserted
  SELECT @IDA = ID, @ConceptoA = Concepto FROM Deleted
  
  IF @ConceptoA = @ConceptoN RETURN

  IF @ConceptoN IS NULL
    DELETE NomXPersonalGrupo WHERE ID = @IDA AND Concepto = @ConceptoA
  ELSE
    UPDATE NomXPersonalGrupo SET Concepto = @ConceptoN WHERE ID = @IDA AND Concepto = @ConceptoA
END
GO

/****** NomXCxp ******/
if not exists(select * from SysTabla where SysTabla = 'NomXCxp') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXCxp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXCxp') and type = 'U') 
CREATE TABLE dbo.NomXCxp (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Acreedor		varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	Impuestos		varchar(255)	NULL,
	Vencimiento		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXCxp PRIMARY KEY CLUSTERED (ID, Concepto)
)
GO
EXEC spALTER_TABLE 'NomXCxp', 'Impuestos', 'varchar(255) NULL'
GO

EXEC spFK 'NomXCxp','ID','NomX','ID'
GO

/****** NomXCxc ******/
if not exists(select * from SysTabla where SysTabla = 'NomXCxc') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXCxc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXCxc') and type = 'U') 
CREATE TABLE dbo.NomXCxc (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Cliente			varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	Impuestos		varchar(255)	NULL,
	Vencimiento		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXCxc PRIMARY KEY CLUSTERED (ID, Concepto)
)
GO
EXEC spALTER_TABLE 'NomXCxc', 'Impuestos', 'varchar(255) NULL'
GO

EXEC spFK 'NomXCxc','ID','NomX','ID'
GO

/****** NomXGasto ******/
if not exists(select * from SysTabla where SysTabla = 'NomXGasto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXGasto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXGasto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.NomXGasto (
	ID					int		NOT NULL,
	IDRenglon			int		IDENTITY(1,1)	NOT NULL,

	Orden				int				NULL,
	Condicion			varchar(255)	NULL,
	Movimiento			varchar(255)	NULL,
	Acreedor			varchar(255)	NULL,
	Clase				varchar(50)		NULL,
	SubClase			varchar(50)		NULL,
	Concepto			varchar(50)		NULL,
	Importe				varchar(255)	NULL,
	Vencimiento			varchar(255)	NULL,
	Referencia			varchar(255)	NULL,
	Comentarios			varchar(100)	NULL,
	ContUso				varchar(255)	NULL,
	UEN					varchar(255)	NULL,
	ClavePresupuestal	varchar(50)		NULL, --REQ 13451

	CONSTRAINT priNomXGasto PRIMARY KEY CLUSTERED (ID, IDRenglon)
  )
  EXEC spSincroSemilla 'NomXGasto'
END
GO
EXEC spALTER_TABLE 'NomXGasto', 'ContUso', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXGasto', 'UEN', 'varchar(255) NULL'
GO
EXEC spALTER_TABLE 'NomXGasto', 'ClavePresupuestal', 'varchar(50) NULL' --REQ 13451
GO
EXEC spFK 'NomXGasto','ID','NomX','ID'
GO

/****** NomXDin ******/
if not exists(select * from SysTabla where SysTabla = 'NomXDin') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('NomXDin','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.NomXDin') and type = 'U') 
CREATE TABLE dbo.NomXDin (
	ID			int		NOT NULL,
	Concepto		varchar(50)	NOT NULL,

	Orden			int		NULL,
	Condicion		varchar(255)	NULL,
	Movimiento		varchar(255)	NULL,
	Cuenta			varchar(255)	NULL,
	Beneficiario		varchar(255)	NULL,
	Importe			varchar(255)	NULL,
	FormaPago		varchar(255)	NULL,
	Referencia		varchar(255)	NULL,
	Personal		varchar(255)	NULL,
	Comentarios		varchar(100)	NULL,

	CONSTRAINT priNomXDin PRIMARY KEY CLUSTERED (ID, Concepto)
)
GO
EXEC spALTER_TABLE 'NomXDin', 'FormaPago', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXDin', 'Referencia', 'varchar(255) NULL'
EXEC spALTER_TABLE 'NomXDin', 'Personal', 'varchar(255)	NULL'
GO

/****** ExcelD ******/
if not exists(select * from SysTabla where SysTabla = 'ExcelD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ExcelD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ExcelD') and type = 'U') 
CREATE TABLE dbo.ExcelD (
	Plantilla	varchar(50)	NOT NULL,
	Campo		varchar(50)	NOT NULL,

	Tipo		varchar(20)	NULL,	-- Texto, Numerico, Monetario, Floante, Fecha
	Origen		varchar(20)	NULL,  -- Celda, Guia, Detalle, Matriz
	Posicion	varchar(5)	NULL,
	ColumnasOmitir	varchar(50)	NULL,

	Orden		int		NULL,
	CONSTRAINT priExcelD PRIMARY KEY CLUSTERED (Plantilla, Campo)
)
GO

/****** Excel ******/
if not exists(select * from SysTabla where SysTabla = 'Excel') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Excel','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Excel') and type = 'U') 
CREATE TABLE dbo.Excel (
	Plantilla		varchar(50)	NOT NULL,	-- Orden de compra de Carrefour
	Tipo			varchar(50)	NULL,	-- Pedido / SUA / Etc.

	Categoria		varchar(50)	NULL,		-- bCentral
	RenglonesDetalle	int		NULL,		-- 4
	Direccion		varchar(10)	NULL,		-- Vertical / Horizontal
	StoredProcedure		varchar(50)	NULL,
	Mov			varchar(20)	NULL,

	Cliente			varchar(10)	NULL,	-- VTAS/CXC
	EnviarA			int		NULL,	-- VTAS/CXC
	Almacen			varchar(10)	NULL,
	Moneda			varchar(10)	NULL,

	CONSTRAINT priExcel PRIMARY KEY CLUSTERED (Plantilla)
)
GO

EXEC spFK2 'Excel','Cliente','EnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'Excel','Cliente','Cte','Cliente'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgExcelC') and sysstat & 0xf = 8) drop trigger dbo.tgExcelC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgExcelC ON Excel
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @PlantillaN	varchar(50),
    @PlantillaA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @PlantillaN = Plantilla FROM Inserted
  SELECT @PlantillaA = Plantilla FROM Deleted

  IF @PlantillaN <> @PlantillaA
    UPDATE ExcelD SET Plantilla = @PlantillaN WHERE Plantilla = @PlantillaA
END
GO

/****** ExcelCat ******/
if not exists(select * from SysTabla where SysTabla = 'ExcelCat') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ExcelCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ExcelCat') and type = 'U') 
CREATE TABLE dbo.ExcelCat (
	Categoria	varchar(50)	NOT NULL,
	Posicion	varchar(5)		NULL,

	CONSTRAINT priExcelCat PRIMARY KEY CLUSTERED (Categoria)
)
GO


/****** SysDoc ******/
if not exists(select * from SysTabla where SysTabla = 'SysDoc') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SysDoc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SysDoc') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SysDoc (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Objeto		varchar(10)	NULL,
	Modulo		varchar(5)		NULL,
	SysTabla	varchar(50)	NULL,
	Nombre		varchar(50)	NULL,
	Descripcion	text		NULL,
	UltimoCambio	datetime	NULL,

	CONSTRAINT priSysDoc PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'SysDoc'
END
GO

/****** LPR ******/
if not exists (select * from SysTabla where SysTabla = 'LPR') 
INSERT INTO SysTabla (SysTabla) VALUES ('LPR')
if not exists (select * from sysobjects where id = object_id('dbo.LPR') and type = 'U') 
CREATE TABLE dbo.LPR (
	Servidor		varchar(50)	NOT NULL,

	IP			varchar(15)	NULL,
	Sucursal		int		NULL	DEFAULT 0,

	CONSTRAINT priLPR PRIMARY KEY  CLUSTERED (Servidor)
)
GO
EXEC spALTER_TABLE 'LPR', 'Sucursal', 'int NULL	DEFAULT 0 WITH VALUES'
GO

EXEC spFK 'LPR','Sucursal','Sucursal','Sucursal'
GO



/****** AfectarBitacora ******/
if not exists(select * from SysTabla where SysTabla = 'AfectarBitacora') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AfectarBitacora', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla) VALUES ('AfectarBitacora')
if not exists (select * from sysobjects where id = object_id('dbo.AfectarBitacora') and type = 'U') 
BEGIN
  CREATE TABLE dbo.AfectarBitacora (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Modulo		varchar(5)		NULL,  
	ModuloID	int		NULL,  	
	Accion		varchar(20)	NULL,  
        Base		varchar(20)	NULL,  
	GenerarMov	varchar(20)	NULL,  
	Usuario		varchar(10)	NULL,  
	FechaRegistro	datetime	NULL,  	
	Ok		int		NULL, 
	OkRef		varchar(255)	NULL,

	CONSTRAINT priAfectarBitacora PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'AfectarBitacora'
END
GO


/****** FueraLineaC ******/
if not exists(select * from SysTabla where SysTabla = 'FueraLineaC') 
INSERT INTO SysTabla (SysTabla) VALUES ('FueraLineaC')
if not exists (select * from sysobjects where id = object_id('dbo.FueraLineaC') and type = 'U') 
  CREATE TABLE dbo.FueraLineaC (
 	Empresa		varchar(5)		NOT NULL,
	Modulo		varchar(5)		NOT NULL,
	Mov		varchar(20)	NOT NULL,
	Consecutivo	int		NOT NULL,

	CONSTRAINT priFueraLineaC PRIMARY KEY CLUSTERED (Mov, Modulo, Empresa, Consecutivo)
)
GO

/****** MovCte ******/
if not exists(select * from SysTabla where SysTabla = 'MovCte') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovCte', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovCte') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovCte (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Nombre		varchar(100)	NULL,
	Tipo		varchar(50)	NULL,		-- PV/Modulo/Facturar Notas Consumo
	Modulo		varchar(5)		NULL,
	SubModulo	varchar(5)		NULL,
	Mov		varchar(20)	NULL,
	NivelAcceso	varchar(50)	NULL,
	Orden		int		NULL,

	CONSTRAINT priMovCte PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MovCte'
END
GO

EXEC spFK2 'MovCte','Modulo','SubModulo','SubModulo','Modulo','SubModulo'
GO

/****** MovProv ******/
if not exists(select * from SysTabla where SysTabla = 'MovProv') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovProv', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovProv') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovProv (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Nombre		varchar(100)	NULL,
	Tipo		varchar(50)	NULL,		-- PV/Modulo/Facturar Notas Consumo
	Modulo		varchar(5)		NULL,
	SubModulo	varchar(5)		NULL,
	Mov		varchar(20)	NULL,
	NivelAcceso	varchar(50)	NULL,
	Orden		int		NULL,

	CONSTRAINT priMovProv PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MovProv'
END
GO

EXEC spFK2 'MovProv','Modulo','SubModulo','SubModulo','Modulo','SubModulo'
GO

/****** MovProy ******/
if not exists(select * from SysTabla where SysTabla = 'MovProy') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovProy', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovProy') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovProy (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Nombre		varchar(100)	NULL,
	Tipo		varchar(50)	NULL,		-- PV/Modulo/Facturar Notas Consumo
	Modulo		varchar(5)		NULL,
	SubModulo	varchar(5)		NULL,
	Mov		varchar(20)	NULL,
	NivelAcceso	varchar(50)	NULL,
	Orden		int		NULL,

	CONSTRAINT priMovProy PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MovProy'
END
GO

EXEC spFK2 'MovProy','Modulo','SubModulo','SubModulo','Modulo','SubModulo'
EXEC spALTER_TABLE 'MovProy', 'Proveedor', 'varchar(20)'
GO

/****** MovCodigo ******/
if not exists(select * from SysTabla where SysTabla = 'MovCodigo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovCodigo', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovCodigo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MovCodigo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MovCodigo (
	Modulo		varchar(5)		NOT NULL,
	ModuloID	int		NOT NULL,
	ID		int		NOT NULL 	IDENTITY(1,1),

	Codigo		varchar(20)	NULL,
	Cantidad	float		NULL,
	SerieLote	varchar(50)	NULL,

	CONSTRAINT priMovCodigo PRIMARY KEY CLUSTERED (ModuloID, Modulo, ID)
  )
  EXEC spSincroSemilla 'MovCodigo'
END
GO
EXEC spALTER_TABLE 'MovCodigo', 'SerieLote', 'varchar(50) NULL'
EXEC spALTER_COLUMN 'MovCodigo', 'SerieLote', 'varchar(50) NULL'
GO


/****** Politica ******/
if not exists (select * from SysTabla where SysTabla = 'Politica') 
INSERT INTO SysTabla (SysTabla) VALUES ('Politica')
if not exists (select * from sysobjects where id = object_id('dbo.Politica') and type = 'U') 
CREATE TABLE dbo.Politica (
	Rama		varchar(5)		NOT NULL,		-- ART, CTE, PROV, PER, + Modulos
	Clave		varchar(20)	NOT NULL,

	Politica	text		NULL,
	
	CONSTRAINT priPolitica PRIMARY KEY  CLUSTERED (Rama, Clave)
)
GO

/****** CfgEstatusConsecutivoDuplicado ******/
if not exists (select * from SysTabla where SysTabla = 'CfgEstatusConsecutivoDuplicado') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CfgEstatusConsecutivoDuplicado', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgEstatusConsecutivoDuplicado') and type = 'U') 
CREATE TABLE dbo.CfgEstatusConsecutivoDuplicado (
	Estatus		varchar(15)	NOT NULL,
	
	CONSTRAINT priCfgEstatusConsecutivoDuplicado PRIMARY KEY  CLUSTERED (Estatus)
)
GO

/****** EnviarCorreo ******/
if not exists(select * from SysTabla where SysTabla = 'EnviarCorreo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EnviarCorreo', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.EnviarCorreo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EnviarCorreo (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Fecha		datetime	NULL,
	Asunto		varchar(255)	NULL,
	Mensaje		text		NULL,
	Anexos		varchar(255)	NULL,
	Grupo		varchar(50)	NULL,

	CONSTRAINT priEnviarCorreo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'EnviarCorreo'
END
GO
EXEC spALTER_TABLE 'EnviarCorreo', 'Grupo', 'varchar(50) NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EnviarCorreo' AND sysindexes.name = 'Asunto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Asunto ON dbo.EnviarCorreo (Asunto)
GO

/****** LanzarProyecto ******/
if not exists(select * from SysTabla where SysTabla = 'LanzarProyecto') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('LanzarProyecto', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.LanzarProyecto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LanzarProyecto (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Fecha		datetime	NULL,
	Mov		varchar(20)	NULL,
	Proyecto	varchar(50)	NULL,
	UEN		int		NULL,
	Grupo		varchar(50)	NULL,
	Asunto		varchar(255)	NULL,

	CONSTRAINT priLanzarProyecto PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'LanzarProyecto'
END
GO
EXEC spALTER_TABLE 'LanzarProyecto', 'Asunto', 'varchar(255) NULL'
GO

EXEC spFK 'LanzarProyecto','UEN','UEN','UEN'
GO

/****** OutlookNombre ******/
if not exists(select * from SysTabla where SysTabla = 'OutlookNombre') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OutlookNombre', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.OutlookNombre') and type = 'U') 
  CREATE TABLE dbo.OutlookNombre (
	Nombre		varchar(100)	NOT NULL,

	Cliente		varchar(10)	NULL,
	ClienteContacto	int		NULL,
	Proveedor	varchar(10)	NULL,
	Agente		varchar(10)	NULL,
	Personal	varchar(10)	NULL,
	Usuario		varchar(10)	NULL,

	Estatus		varchar(15)	NULL	DEFAULT 'NUEVO',

	CONSTRAINT priOutlookNombre PRIMARY KEY CLUSTERED (Nombre)
  )
GO

EXEC spFK2 'OutlookNombre','Cliente','ClienteContacto','CteCto','Cliente','ID'
EXEC spFK 'OutlookNombre','Cliente','Cte','Cliente'
EXEC spFK 'OutlookNombre','Proveedor','Prov','Proveedor'
EXEC spFK 'OutlookNombre','Agente','Agente','Agente'
EXEC spFK 'OutlookNombre','Personal','Personal','Personal'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'OutlookNombre' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario ON dbo.OutlookNombre (Usuario, Estatus)
GO

if not exists(select * from SysTabla where SysTabla = 'Outlook')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Outlook', 'Movimiento') 
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Outlook', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.Outlook') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Outlook (
	ID			int		NOT NULL 	IDENTITY(1,1),

	Tipo			varchar(20)	NULL,		-- Correo/Cita/Tarea
	De			varchar(100)	NULL,
	Fecha			datetime	NULL,
	Asunto			varchar(255)	NULL,
	Ubicacion		varchar(255)	NULL,
	Mensaje			text		NULL,
	Anexos			varchar(255)	NULL,
	OutlookID		varchar(150)	NULL,
	Recibido		bit		NULL	DEFAULT 0,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Vencimiento		datetime	NULL,
	DiaCompleto		bit		NULL	DEFAULT 0,
	Estado			varchar(100)	NULL,
	Completado		float		NULL,
	Prioridad		varchar(20)	NULL,
	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,
	Referencia		varchar(50)	NULL,
	UsuarioAsignado		varchar(10) 	NULL,
	ColorEtiqueta		int 		NULL,

	CONSTRAINT priOutlook PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Outlook'
END
GO
EXEC spALTER_TABLE 'Outlook', 'Ubicacion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Outlook', 'Estado', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Outlook', 'Completado', 'float NULL'
EXEC spALTER_TABLE 'Outlook', 'Prioridad', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Outlook', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Outlook', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'Outlook', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Outlook', 'UsuarioAsignado', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Outlook', 'ColorEtiqueta', 'int NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Outlook' AND sysindexes.name = 'OutlookID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OutlookID ON dbo.Outlook (OutlookID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Outlook' AND sysindexes.name = 'De' AND sysobjects.id = sysindexes.id)
  CREATE INDEX De ON dbo.Outlook (De)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Outlook' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia ON dbo.Outlook (Referencia)
GO

-- tgOutlookABC (en 50 Maestros.sql)


if not exists(select * from SysTabla where SysTabla = 'OutlookProcesar') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OutlookProcesar', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OutlookProcesar', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.OutlookProcesar') and type = 'U') 
BEGIN
  CREATE TABLE dbo.OutlookProcesar (
	ID			int		NOT NULL 	IDENTITY(1,1),

	Tipo			varchar(20)	NULL,		-- Correo/Cita/Tarea
	De			varchar(100)	NULL,		-- Propietario del Elemento
	Fecha			datetime	NULL,
	Asunto			varchar(255)	NULL,
	Ubicacion		varchar(255)	NULL,
	Mensaje			text		NULL,
	Anexos			varchar(255)	NULL,
	OutlookID		varchar(150)	NULL,
	Recibido		bit		NULL	DEFAULT 0,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	Vencimiento		datetime	NULL,
	DiaCompleto		bit		NULL	DEFAULT 0,
	Estado			varchar(100)	NULL,
	Completado		float		NULL,
	Prioridad		varchar(20)	NULL,
	Accion			varchar(20)	NULL,	-- Agregar/Modificar/Eliminar
	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,
	Referencia		varchar(50)	NULL,
	CCO 			bit 		NULL	DEFAULT 0,		-- Con Copia Oculta

	CONSTRAINT priOutlookProcesar PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'OutlookProcesar'
END
GO
EXEC spALTER_TABLE 'OutlookProcesar', 'Referencia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'OutlookProcesar', 'Modulo', 'varchar(5) NULL'
EXEC spALTER_TABLE 'OutlookProcesar', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'OutlookProcesar', 'Accion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'OutlookProcesar', 'CCO', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'OutlookProcesar' AND sysindexes.name = 'OutlookID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OutlookID ON dbo.OutlookProcesar (OutlookID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'OutlookProcesar' AND sysindexes.name = 'De' AND sysobjects.id = sysindexes.id)
  CREATE INDEX De ON dbo.OutlookProcesar (De)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'OutlookProcesar' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia ON dbo.OutlookProcesar (Referencia)
GO
-- Trigger tgOutlookABC en la Tabla Tarea


/****** OutlookPara ******/
if not exists(select * from SysTabla where SysTabla = 'OutlookPara') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OutlookPara', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.OutlookPara') and type = 'U') 
  CREATE TABLE dbo.OutlookPara (
	ID		int		NOT NULL,
        Para		varchar(100)	NOT NULL,

	CONSTRAINT priOutlookPara PRIMARY KEY CLUSTERED (ID, Para)
  )
GO

/****** OutlookProcesarPara ******/
if not exists(select * from SysTabla where SysTabla = 'OutlookProcesarPara') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OutlookProcesarPara', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.OutlookProcesarPara') and type = 'U') 
  CREATE TABLE dbo.OutlookProcesarPara (
	ID		int		NOT NULL,
        Para		varchar(100)	NOT NULL,

	CONSTRAINT priOutlookProcesarPara PRIMARY KEY CLUSTERED (ID, Para)
  )
GO

/****** CalendarioTipoEvento ******/
if not exists (select * from SysTabla where SysTabla = 'CalendarioTipoEvento') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CalendarioTipoEvento', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CalendarioTipoEvento') and type = 'U') 
CREATE TABLE dbo.CalendarioTipoEvento (
	TipoEvento	varchar(50)	NOT NULL,
	
	CONSTRAINT priCalendarioTipoEvento PRIMARY KEY  CLUSTERED (TipoEvento)
)
GO

if not exists(select * from SysTabla where SysTabla = 'Calendario') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Calendario', 'Cuenta')
go 
if not exists (select * from sysobjects where id = object_id('dbo.Calendario') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Calendario (
	ID			int		NOT NULL 	IDENTITY(1,1),
	
	TipoEvento		varchar(50)	NULL,		-- Tipo de Evento
	Empresa			varchar(5)		NULL,
	Fecha			datetime	NULL,
	Asunto			varchar(255)	NULL,
	Ubicacion		varchar(255)	NULL,
	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	DiaCompleto		bit		NULL	DEFAULT 0,
	General			bit		NULL	DEFAULT 0,

	Aula			varchar(10)	NULL,
	Grado			varchar(10)	NULL,
	Grupo			varchar(50)	NULL,
	Materia			varchar(10)	NULL,
	Agente			varchar(10)	NULL,
	Cliente			varchar(10)	NULL,

	CONSTRAINT priCalendario PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Calendario'
END
GO

EXEC spFK 'Calendario','Aula','Aula','Aula'
EXEC spFK 'Calendario','Grado','Grado','Grado'
EXEC spFK 'Calendario','Agente','Agente','Agente'
EXEC spFK 'Calendario','Cliente','Cte','Cliente'
GO

/****** TranBloqueo ******/
if not exists (select * from SysTabla where SysTabla = 'TranBloqueo') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TranBloqueo', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.TranBloqueo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.TranBloqueo (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Empresa		varchar(5)		NULL,
	Usuario		varchar(10)	NULL,
	Sucursal	int		NULL,
	Estacion	int		NULL,

	SQL		text		NULL,
	TranCount	int		NULL,
	Inicio		datetime	NULL,
	Fin		datetime	NULL,

	CONSTRAINT priTranBloqueo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'TranBloqueo'
END
GO

/****** SMS ******/
if not exists (select * from SysTabla where SysTabla = 'SMS') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SMS', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SMS', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.SMS') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SMS (
	ID		int		NOT NULL 	IDENTITY(1,1),

	Telefono	varchar(20)	NULL,
	Tipo		varchar(20)	NULL,		-- Evento/Lote

	ReciboFecha	datetime	NULL,		-- Fecha en la que se recibe el mensaje
	ReciboMensaje	varchar(147)	NULL,		-- Mensaje recibido

	EnvioFecha	datetime	NULL,		-- Fecha en que se envia el mensaje (real)
	EnvioMensaje	varchar(147)	NULL,		-- mensaje a enviar

	Modulo		varchar(5)	NULL,
	ModuloID	int		NULL,
	Referencia	varchar(50)	NULL,

	CONSTRAINT priSMS PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'SMS'
END
GO
EXEC spALTER_TABLE 'SMS', 'Modulo', 'varchar(5)	NULL'
EXEC spALTER_TABLE 'SMS', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'SMS', 'Referencia', 'varchar(50) NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SMS' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia ON dbo.SMS (Referencia)
GO


/****** WSEnviar ******/
if not exists (select * from SysTabla where SysTabla = 'WSEnviar') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WSEnviar', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.WSEnviar') and type = 'U') 
BEGIN
  CREATE TABLE dbo.WSEnviar (
	ID		int		NOT NULL 	IDENTITY(1,1),

	WSDL		varchar(255)	NULL,
	Estatus		varchar(15)	NULL,		-- SINAFECTAR, PENDIENTE, ENVIADO, ERROR
	EstatusFecha	datetime	NULL,
	Mensaje		varchar(255)	NULL,
	QueryXML	varchar(4000)	NULL,

	CONSTRAINT priWSEnviar PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'WSEnviar'
END
GO
EXEC spALTER_TABLE 'WSEnviar', 'Mensaje', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'WSEnviar', 'QueryXML', 'varchar(4000) NULL'
GO


/****** WSEnviarD ******/
if not exists (select * from SysTabla where SysTabla = 'WSEnviarD') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WSEnviarD', 'N/A')
if not exists (select * from sysobjects where id = object_id('dbo.WSEnviarD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.WSEnviarD (
	ID		int		NOT NULL,
	RID		int		NOT NULL 	IDENTITY(1,1),

	Datos		varchar(8000)	NULL,

	CONSTRAINT priWSEnviarD PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'WSEnviarD'
END
GO


-- drop table MenuAccion
/****** MenuAccion ******/
if not exists (select * from SysTabla where SysTabla = 'MenuAccion') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MenuAccion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MenuAccion') and type = 'U') 
  CREATE TABLE dbo.MenuAccion (
	Accion			varchar(50)	NOT NULL,

	Nombre			varchar(100)	NULL,
	Imagen  		int		NULL,
	Descripcion		varchar(255)	NULL,
	Visible			bit		NULL	DEFAULT 1,
	VisibleCondicion	varchar(1000)	NULL,
	Activo			bit		NULL	DEFAULT 1,
	ActivoCondicion		varchar(1000)	NULL,
	Expresion		varchar(1000)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priMenuAccion PRIMARY KEY CLUSTERED (Accion)
  )
GO
EXEC spALTER_TABLE 'MenuAccion', 'Imagen', 'int NULL'
EXEC spALTER_TABLE 'MenuAccion', 'Estatus', 'varchar(15) NULL DEFAULT "ALTA" WITH VALUES'
GO

EXEC spFK 'MenuAccion','Estatus','Estatus','Estatus'
GO

-- drop table UsuarioMenu
/****** MenuOpcion ******/
if not exists (select * from SysTabla where SysTabla = 'MenuOpcion') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MenuOpcion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MenuOpcion') and type = 'U') 
  CREATE TABLE dbo.MenuOpcion (
	Menu			varchar(50)	NOT NULL,
	Opcion			varchar(20)	NOT NULL,

        Tipo                    varchar(20)	NULL,                 -- Folder, Grupo, Submenu, Accion
	Accion			varchar(50)	NULL,
	Nombre			varchar(100)	NULL,
	Imagen  		int		NULL,
	EspacioPrevio		bit		NULL	DEFAULT 0,
	TeclaRapida		varchar(50)	NULL,
	BotonGrande             bit		NULL	DEFAULT 1,
	OpcionOrden		varchar(100)	NULL,
	URL			varchar(255)	NULL,
	Reporte			varchar(255)	NULL,
	HTML			text		NULL,

	CONSTRAINT priMenuOpcion PRIMARY KEY CLUSTERED (Menu, Opcion)
  )
GO
EXEC spALTER_TABLE 'MenuOpcion', 'Reporte', 'varchar(255) NULL'
EXEC spALTER_TABLE 'MenuOpcion', 'URL', 'varchar(255) NULL'
EXEC spALTER_TABLE 'MenuOpcion', 'HTML', 'text NULL'
GO

EXEC spFK 'MenuOpcion','Accion','MenuAccion','Accion'
GO

/****** UsuarioMenuOpcion ******/
if not exists (select * from SysTabla where SysTabla = 'UsuarioMenuOpcion') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('UsuarioMenuOpcion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioMenuOpcion') and type = 'U') 
  CREATE TABLE dbo.UsuarioMenuOpcion (
	Usuario			varchar(10)	NOT NULL,
	Menu			varchar(50)	NOT NULL,
	Opcion			varchar(20)	NOT NULL,

	Estatus			varchar(15)	NULL,

	CONSTRAINT priUsuarioMenuOpcion PRIMARY KEY CLUSTERED (Usuario, Menu, Opcion)
  )
GO
EXEC spALTER_TABLE 'UsuarioMenuOpcion', 'Estatus', 'varchar(15)	NULL'
GO

EXEC spFK2 'UsuarioMenuOpcion','Menu','Opcion','MenuOpcion','Menu','Opcion'
GO

/****** MenuTicker ******/
if not exists (select * from SysTabla where SysTabla = 'MenuTicker') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MenuTicker', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MenuTicker') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MenuTicker (
	ID			int		NOT NULL 	IDENTITY(1,1),

	Mensaje1		text		NULL,
	Tipo1			varchar(20)	NULL,
	Mensaje2		text		NULL,
	Tipo2			varchar(20)	NULL,

	CONSTRAINT priMenuTicker PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MenuTicker'
END
GO

EXEC spDROP_TABLE 'Menu', 2885
EXEC spDROP_TABLE 'UsuarioMenu', 2885
GO

EXEC spDROP_TABLE 'Color', 3029
GO
-- drop table Color
/****** Color ******/
if not exists (select * from SysTabla where SysTabla = 'Color') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Color', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Color') and type = 'U') 
  CREATE TABLE dbo.Color (
	Color			varchar(50)	NOT NULL,

	Numero			int		NULL,

	CONSTRAINT priColor PRIMARY KEY CLUSTERED (Color)
  )
GO

/****** WebColor ******/
if not exists (select * from SysTabla where SysTabla = 'WebColor') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('WebColor', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.WebColor') and type = 'U') 
  CREATE TABLE dbo.WebColor (
	Color			varchar(50)	NOT NULL,

	Hexadecimal		varchar(10)	NULL,

	CONSTRAINT priWebColor PRIMARY KEY CLUSTERED (Color)
  )
GO

/****** Menu ******/
if not exists (select * from SysTabla where SysTabla = 'Menu') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('Menu', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Menu') and type = 'U') 
  CREATE TABLE dbo.Menu (
	Menu			varchar(50)	NOT NULL,

	Tipo			varchar(20)	NULL	DEFAULT 'Windows', 	-- Windows/Web
	Posicion		varchar(20)	NULL,				-- Titulo/Cuerpo/Pie

	ColorFondo		varchar(50)	NULL,				-- Azul Metalico
	ColorLetras		varchar(50)	NULL,				-- Blanco

	CONSTRAINT priMenu PRIMARY KEY CLUSTERED (Menu)
  )
GO
EXEC spALTER_TABLE 'Menu', 'Tipo', 'varchar(20)	NULL DEFAULT "Windows" WITH VALUES'
EXEC spALTER_TABLE 'Menu', 'Posicion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Menu', 'ColorFondo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Menu', 'ColorLetras', 'varchar(50) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgMenuBC') and sysstat & 0xf = 8) drop trigger dbo.tgMenuBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgMenuBC ON Menu
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @MenuN  	varchar(50),
    @MenuA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @MenuN = Menu FROM Inserted
  SELECT @MenuA = Menu FROM Deleted
  
  IF @MenuA = @MenuN RETURN

  IF @MenuN IS NULL
  BEGIN
    DELETE MenuOpcion        WHERE Menu = @MenuA
    DELETE UsuarioMenuOpcion WHERE Menu = @MenuA
  END ELSE
  BEGIN
    UPDATE MenuOpcion        SET Menu = @MenuN WHERE Menu = @MenuA
    UPDATE UsuarioMenuOpcion SET Menu = @MenuN WHERE Menu = @MenuA
  END
END
GO


-- drop table Sesion
/****** Sesion ******/
if not exists (select * from SysTabla where SysTabla = 'Sesion') 
INSERT INTO SysTabla (SysTabla) VALUES ('Sesion')
if not exists (select * from sysobjects where id = object_id('dbo.Sesion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Sesion (
	Sesion			int		NOT NULL	IDENTITY(1,1),

	Empresa			varchar(5)		NOT NULL,
	Sucursal		int		NOT NULL,
	Usuario			varchar(10)	NOT NULL,
	FechaTrabajo		datetime	NOT NULL,

	EstacionTrabajo		int		NULL,
	IP			varchar(20)	NULL,
	Estatus			varchar(15)	NULL,

	CONSTRAINT priSesion PRIMARY KEY CLUSTERED (Sesion)
  )
  EXEC spSincroSemilla 'Sesion'
END
GO

/****** SesionVar ******/
if not exists (select * from SysTabla where SysTabla = 'SesionVar') 
INSERT INTO SysTabla (SysTabla) VALUES ('SesionVar')
if not exists (select * from sysobjects where id = object_id('dbo.SesionVar') and type = 'U') 
  CREATE TABLE dbo.SesionVar (
	Sesion			int		NOT NULL,
	Variable		varchar(100)	NOT NULL,

	Valor			varchar(8000)	NULL,

	CONSTRAINT priSesionVar PRIMARY KEY CLUSTERED (Sesion, Variable)
)
GO

EXEC spDROP_TABLE 'FormaCarpetaVista', 3100
EXEC spDROP_TABLE 'FormaExtraCarpetaVista', 3100
GO
-- delete FormaExtraCarpetaVista
-- select * from FormaExtraCarpetaVista
/****** FormaExtraCarpetaVista ******/
if not exists (select * from SysTabla where SysTabla = 'FormaExtraCarpetaVista') 
INSERT INTO SysTabla (SysTabla) VALUES ('FormaExtraCarpetaVista')
if not exists (select * from sysobjects where id = object_id('dbo.FormaExtraCarpetaVista') and type = 'U') 
  CREATE TABLE dbo.FormaExtraCarpetaVista (
	FormaExtra		varchar(100)	NOT NULL,
	Carpeta			varchar(100)	NOT NULL,
	Vista			varchar(100)	NOT NULL,
	
	Datos			text		NULL,

	CONSTRAINT priFormaExtraCarpetaVista PRIMARY KEY CLUSTERED (FormaExtra, Carpeta, Vista)
)
GO


EXEC spALTER_TABLE 'MovTipo', 'ProyectoSugerir', 'varchar(20) NULL DEFAULT "Movimiento" WITH VALUES' -- "Movimiento", "Catálogo", "Abierto"
GO

EXEC spALTER_TABLE 'MovTipo', 'CalculoMoratorioMAVI', 'bit DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovTipo', 'ConsecutivoFiscal', 'bit NULL default 0 with values'
GO

/****** Archivo  ******/
if not exists(select * from SysTabla where SysTabla = 'Archivo')
INSERT INTO SysTabla (SysTabla) VALUES ('Archivo')
if exists (select * from sysobjects where id = object_id('dbo.Archivo') and type = 'U') 
DROP TABLE dbo.Archivo
CREATE TABLE dbo.Archivo (
	ID		int		NOT NULL IDENTITY (1,1),

	Nombre		varchar(255)	NULL,
	Fecha		datetime	NULL	DEFAULT GETDATE(),
	Accion		varchar(20)	NULL,	-- Leer, Escribir

	Layout		varchar(50)	NULL,
	Referencia	varchar(100)	NULL,

	CONSTRAINT priArchivo PRIMARY KEY CLUSTERED (ID)

  )
GO
EXEC spALTER_TABLE 'Archivo', 'Layout', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Archivo', 'Referencia', 'varchar(100) NULL'
GO

if not exists(select * from SysTabla where SysTabla = 'ArchivoD')
INSERT INTO SysTabla (SysTabla) VALUES ('ArchivoD')
if exists (select * from sysobjects where id = object_id('dbo.ArchivoD') and type = 'U') 
DROP TABLE dbo.ArchivoD
CREATE TABLE dbo.ArchivoD (
	ID		int		NOT NULL,
	RID		int		NOT NULL IDENTITY (1,1),

	Datos		varchar(8000)	NULL,

	CONSTRAINT priArchivoD PRIMARY KEY CLUSTERED (ID, RID)

)
GO
ALTER TABLE ArchivoD ALTER COLUMN Datos varchar(8000) NULL
GO

/**************** spArchivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArchivo') and type = 'P') drop procedure dbo.spArchivo
GO
CREATE PROCEDURE spArchivo
			@Nombre		varchar(255),
			@Accion		varchar(20),
			@ID		int		OUTPUT,
			@Layout		varchar(50)  = NULL,
			@Referencia	varchar(100) = NULL,
			@EnSilencio	bit	= 1
--//WITH ENCRYPTION
AS BEGIN
  INSERT Archivo (Nombre, Accion, Layout, Referencia) VALUES (@Nombre, @Accion, @Layout, @Referencia)
  SELECT @ID = SCOPE_IDENTITY()
  IF @EnSilencio = 0
    SELECT 'ID' = @ID
  RETURN
END
GO

/**************** spArchivoD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArchivoD') and type = 'P') drop procedure dbo.spArchivoD
GO
CREATE PROCEDURE spArchivoD
			@ID	int,
			@Datos	varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  INSERT ArchivoD (ID, Datos) VALUES (@ID, @Datos)
  RETURN
END
GO

/**************** spArchivoEliminar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArchivoEliminar') and type = 'P') drop procedure dbo.spArchivoEliminar
GO
CREATE PROCEDURE spArchivoEliminar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DELETE ArchivoD WHERE ID = @ID 
  DELETE Archivo  WHERE ID = @ID
  RETURN
END
GO

/**************** xpArchivoProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArchivoProcesar') and type = 'P') drop procedure dbo.xpArchivoProcesar
GO
CREATE PROCEDURE xpArchivoProcesar
			@ID		int,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** spArchivoProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spArchivoProcesar') and type = 'P') drop procedure dbo.spArchivoProcesar
GO
CREATE PROCEDURE spArchivoProcesar
			@ID		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @Error	varchar(255)	

  SELECT @Error = NULL, @Ok = NULL, @OkRef = NULL
  IF (SELECT UPPER(Accion) FROM Archivo WHERE ID = @ID) IN ('LEER', 'PROCESAR')
  BEGIN
    EXEC xpArchivoProcesar @ID, @Ok OUTPUT, @OkRef OUTPUT
    EXEC spArchivoEliminar @ID
  END 
  SELECT 'Error' = @Error
  RETURN
END
GO

EXEC spDROP_TABLE 'PersonalizarForma', 3002
EXEC spDROP_TABLE 'PersonalizarSubForma', 3002
EXEC spDROP_TABLE 'PersonalizarFormaCampo', 3002
GO


-- drop table FormaVirtual
/****** FormaVirtual ******/
if not exists(select * from SysTabla where SysTabla = 'FormaVirtual')
INSERT INTO SysTabla (SysTabla) VALUES ('FormaVirtual')
if not exists (select * from sysobjects where id = object_id('dbo.FormaVirtual') and type = 'U') 
  CREATE TABLE dbo.FormaVirtual (
	FormaVirtual	varchar(100)	NOT NULL,

	Titulo		varchar(100)	NULL,
	Forma		varchar(100)	NULL,
	Modo		varchar(20)	NULL,		-- Deteccion, Ejecucion, por Omision

	CONSTRAINT priFormaVirtual PRIMARY KEY CLUSTERED (FormaVirtual)

  )
GO

-- drop table FormaVirtualCarpeta
-- delete FormaVirtualCarpeta
/****** FormaVirtualCarpeta ******/
if not exists(select * from SysTabla where SysTabla = 'FormaVirtualCarpeta')
INSERT INTO SysTabla (SysTabla) VALUES ('FormaVirtualCarpeta')
if not exists (select * from sysobjects where id = object_id('dbo.FormaVirtualCarpeta') and type = 'U') 
  CREATE TABLE dbo.FormaVirtualCarpeta (
	FormaVirtual	varchar(100)	NOT NULL,
	Carpeta		varchar(100)	NOT NULL,

	Nombre		varchar(100)	NULL,
	Pagina		int		NULL,	
	Etiqueta	varchar(100)	NULL,
	Visible		bit		NULL	DEFAULT 1,
	Orden		int		NULL,

	Filtro1		varchar(100)	NULL,
	Filtro2		varchar(100)	NULL,
	Filtro3		varchar(100)	NULL,
	Filtro4		varchar(100)	NULL,
	Filtro5		varchar(100)	NULL,
	Filtro6		varchar(100)	NULL,

	CONSTRAINT priFormaVirtualCarpeta PRIMARY KEY CLUSTERED (FormaVirtual, Carpeta)
)
GO

/**************** spFormaVirtualCarpeta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaVirtualCarpeta') and type = 'P') drop procedure dbo.spFormaVirtualCarpeta
GO
CREATE PROCEDURE spFormaVirtualCarpeta
			@FormaVirtual	varchar(100),
			@Carpeta	varchar(100),
			@Nombre		varchar(100),
			@Pagina		int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE FormaVirtualCarpeta
     SET Nombre = @Nombre, Pagina = @Pagina
   WHERE FormaVirtual = @FormaVirtual AND Carpeta = @Carpeta
  IF @@ROWCOUNT = 0
    INSERT FormaVirtualCarpeta (
            FormaVirtual,  Carpeta,  Nombre,  Pagina,  Orden) 
    VALUES (@FormaVirtual, @Carpeta, @Nombre, @Pagina, @Pagina)
  RETURN
END
GO

-- drop table FormaVirtualCampo
/****** FormaVirtualCampo ******/
if not exists(select * from SysTabla where SysTabla = 'FormaVirtualCampo')
INSERT INTO SysTabla (SysTabla) VALUES ('FormaVirtualCampo')
if not exists (select * from sysobjects where id = object_id('dbo.FormaVirtualCampo') and type = 'U') 
  CREATE TABLE dbo.FormaVirtualCampo (
	FormaVirtual	varchar(100)	NOT NULL,
	Vista		varchar(100)	NOT NULL,
	Campo		varchar(100)	NOT NULL,

	Nombre		varchar(100)	NULL,
	Etiqueta	varchar(100)	NULL,
	Visible		bit		NULL	DEFAULT 1,
	Activo		bit		NULL	DEFAULT 1,

	CONSTRAINT priFormaVirtualCampo PRIMARY KEY CLUSTERED (FormaVirtual, Campo, Vista)
)
GO

/**************** spFormaVirtualCampo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaVirtualCampo') and type = 'P') drop procedure dbo.spFormaVirtualCampo
GO
CREATE PROCEDURE spFormaVirtualCampo
			@FormaVirtual	varchar(100),
			@Vista		varchar(100),
			@Campo		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE FormaVirtualCampo
     SET Nombre = @Nombre
   WHERE FormaVirtual = @FormaVirtual AND Vista = @Vista AND Campo = @Campo
  IF @@ROWCOUNT = 0
    INSERT FormaVirtualCampo (
            FormaVirtual,  Vista,  Campo,  Nombre) 
    VALUES (@FormaVirtual, @Vista, @Campo, @Nombre)
  RETURN
END
GO

-- drop table FormaVirtualAccion
/****** FormaVirtualAccion ******/
if not exists(select * from SysTabla where SysTabla = 'FormaVirtualAccion')
INSERT INTO SysTabla (SysTabla) VALUES ('FormaVirtualAccion')
if not exists (select * from sysobjects where id = object_id('dbo.FormaVirtualAccion') and type = 'U') 
  CREATE TABLE dbo.FormaVirtualAccion (
	FormaVirtual	varchar(100)	NOT NULL,
	Accion		varchar(100)	NOT NULL,

	Nombre		varchar(100)	NULL,
	Etiqueta	varchar(100)	NULL,
	Visible		bit		NULL	DEFAULT 1,
	Activo		bit		NULL	DEFAULT 1,

	CONSTRAINT priFormaVirtualAccion PRIMARY KEY CLUSTERED (FormaVirtual, Accion)
)
GO

/**************** spFormaVirtualAccion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaVirtualAccion') and type = 'P') drop procedure dbo.spFormaVirtualAccion
GO
CREATE PROCEDURE spFormaVirtualAccion
			@FormaVirtual	varchar(100),
			@Accion		varchar(100),
			@Nombre		varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE FormaVirtualAccion
     SET Nombre = @Nombre
   WHERE FormaVirtual = @FormaVirtual AND Accion = @Accion
  IF @@ROWCOUNT = 0
    INSERT FormaVirtualAccion (
            FormaVirtual,  Accion,  Nombre) 
    VALUES (@FormaVirtual, @Accion, @Nombre)
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaVirtualBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaVirtualBC
GO
CREATE TRIGGER tgFormaVirtualBC ON FormaVirtual
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @FormaVirtualN	varchar(100),
    @FormaVirtualA	varchar(100)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FormaVirtualN = FormaVirtual FROM Inserted
  SELECT @FormaVirtualA = FormaVirtual FROM Deleted
  
  IF @FormaVirtualA = @FormaVirtualN RETURN

  IF @FormaVirtualN IS NULL
  BEGIN
    DELETE FormaVirtualCarpeta WHERE FormaVirtual = @FormaVirtualA
    DELETE FormaVirtualCampo   WHERE FormaVirtual = @FormaVirtualA
    DELETE FormaVirtualAccion  WHERE FormaVirtual = @FormaVirtualA
  END ELSE
  BEGIN
    UPDATE FormaVirtualCarpeta SET FormaVirtual = @FormaVirtualN WHERE FormaVirtual = @FormaVirtualA
    UPDATE FormaVirtualCampo   SET FormaVirtual = @FormaVirtualN WHERE FormaVirtual = @FormaVirtualA
    UPDATE FormaVirtualAccion  SET FormaVirtual = @FormaVirtualN WHERE FormaVirtual = @FormaVirtualA
  END
END
GO

/**************** spFormaVirtualCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFormaVirtualCopiar') and type = 'P') drop procedure dbo.spFormaVirtualCopiar
GO
CREATE PROCEDURE spFormaVirtualCopiar
			@FormaVirtualD	varchar(100),
			@FormaVirtualA	varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM FormaVirtual WHERE FormaVirtual = @FormaVirtualA)
  BEGIN
    DELETE FormaVirtualCarpeta WHERE FormaVirtual = @FormaVirtualA
    DELETE FormaVirtualCampo   WHERE FormaVirtual = @FormaVirtualA
    DELETE FormaVirtualAccion  WHERE FormaVirtual = @FormaVirtualA
    
    INSERT FormaVirtual (
    	   FormaVirtual,   Titulo, Forma, Modo)
    SELECT @FormaVirtualA, Titulo, Forma, Modo
      FROM FormaVirtual
     WHERE FormaVirtual = @FormaVirtualD
     
    INSERT FormaVirtualCarpeta (
    	   FormaVirtual,   Carpeta, Nombre, Pagina, Etiqueta, Visible, Orden, Filtro1, Filtro2, Filtro3, Filtro4, Filtro5, Filtro6)
    SELECT @FormaVirtualA, Carpeta, Nombre, Pagina, Etiqueta, Visible, Orden, Filtro1, Filtro2, Filtro3, Filtro4, Filtro5, Filtro6
      FROM FormaVirtualCarpeta
     WHERE FormaVirtual = @FormaVirtualD

    INSERT FormaVirtualCampo ( 
    	   FormaVirtual,   Vista, Campo, Nombre, Etiqueta, Visible, Activo)
    SELECT @FormaVirtualA, Vista, Campo, Nombre, Etiqueta, Visible, Activo
      FROM FormaVirtualCampo
     WHERE FormaVirtual = @FormaVirtualD

    INSERT FormaVirtualAccion (
    	   FormaVirtual,   Accion, Nombre, Etiqueta, Visible, Activo)
    SELECT @FormaVirtualA, Accion, Nombre, Etiqueta, Visible, Activo
      FROM FormaVirtualAccion
     WHERE FormaVirtual = @FormaVirtualD
  END
  RETURN
END
GO

-- drop table CargaCta
if not exists(select * from SysTabla where SysTabla = 'CargaCta')
INSERT INTO SysTabla (SysTabla) VALUES ('CargaCta')
if not exists (select * from sysobjects where id = object_id('dbo.CargaCta') and type = 'U') 
  CREATE TABLE dbo.CargaCta (
	ID			int		NOT NULL IDENTITY (1,1),
	
	Fecha			datetime	NULL,
	Catalogo		varchar(20)	NULL,	-- Prospectos
	Clave			varchar(20)	NULL,	-- Automatica/Manual
	ClavePrefijo		varchar(10)	NULL,
	ClaveFolioInicial	int		NULL,
	FormaTipo		varchar(20)	NULL,
	Estatus			varchar(15)	NULL,
	Observaciones		varchar(100)	NULL,

	CONSTRAINT priCargaCta PRIMARY KEY CLUSTERED (ID)

  )
GO
EXEC spALTER_TABLE 'CargaCta', 'FormaTipo', 'varchar(20) NULL'
GO

EXEC spFK 'CargaCta','FormaTipo','FormaTipo','FormaTipo'
GO

-- SELECT AA, [AS] FROM CargaCtaD
-- drop table CargaCtaD
EXEC spDROP_TABLE 'CargaCtaD', 3067
GO
if not exists(select * from SysTabla where SysTabla = 'CargaCtaD')
INSERT INTO SysTabla (SysTabla) VALUES ('CargaCtaD')
if not exists (select * from sysobjects where id = object_id('dbo.CargaCtaD') and type = 'U') 
  CREATE TABLE dbo.CargaCtaD (
	ID		int		NOT NULL,
	RID		int		NOT NULL IDENTITY (1,1),

	C1		varchar(100)	NULL,
	C2		varchar(100)	NULL,
	C3		varchar(100)	NULL,
	C4		varchar(100)	NULL,
	C5		varchar(100)	NULL,
	C6		varchar(100)	NULL,
	C7		varchar(100)	NULL,
	C8		varchar(100)	NULL,
	C9		varchar(100)	NULL,
	C10		varchar(100)	NULL,
	C11		varchar(100)	NULL,
	C12		varchar(100)	NULL,
	C13		varchar(100)	NULL,
	C14		varchar(100)	NULL,
	C15		varchar(100)	NULL,
	C16		varchar(100)	NULL,
	C17		varchar(100)	NULL,
	C18		varchar(100)	NULL,
	C19		varchar(100)	NULL,
	C20		varchar(100)	NULL,
	C21		varchar(100)	NULL,
	C22		varchar(100)	NULL,
	C23		varchar(100)	NULL,
	C24		varchar(100)	NULL,
	C25		varchar(100)	NULL,
	C26		varchar(100)	NULL,
	C27		varchar(100)	NULL,
	C28		varchar(100)	NULL,
	C29		varchar(100)	NULL,
	C30		varchar(100)	NULL,
	C31		varchar(100)	NULL,
	C32		varchar(100)	NULL,
	C33		varchar(100)	NULL,
	C34		varchar(100)	NULL,
	C35		varchar(100)	NULL,
	C36		varchar(100)	NULL,
	C37		varchar(100)	NULL,
	C38		varchar(100)	NULL,
	C39		varchar(100)	NULL,
	C40		varchar(100)	NULL,
	C41		varchar(100)	NULL,
	C42		varchar(100)	NULL,
	C43		varchar(100)	NULL,
	C44		varchar(100)	NULL,
	C45		varchar(100)	NULL,
	C46		varchar(100)	NULL,
	C47		varchar(100)	NULL,
	C48		varchar(100)	NULL,
	C49		varchar(100)	NULL,
	C50		varchar(100)	NULL,
	
	CONSTRAINT priCargaCtaD PRIMARY KEY CLUSTERED (ID, RID)
  )
GO

-- drop table CargaCtaMapa
if not exists(select * from SysTabla where SysTabla = 'CargaCtaMapa')
INSERT INTO SysTabla (SysTabla) VALUES ('CargaCtaMapa')
if not exists (select * from sysobjects where id = object_id('dbo.CargaCtaMapa') and type = 'U') 
  CREATE TABLE dbo.CargaCtaMapa (
	ID		int		NOT NULL,
	RID		int		NOT NULL IDENTITY (1,1),

	TablaCampo	varchar(50)	NULL,	-- Prospecto/ProspectoCto/(Caracteristicas)
	Campo		varchar(50)	NULL,	
	Expresion	varchar(250)	NULL,
	Nivel		int		NULL,
	Orden		int		NULL,

	CONSTRAINT priCargaCtaMapa PRIMARY KEY CLUSTERED (ID, RID)

  )
GO
EXEC spALTER_TABLE 'CargaCtaMapa', 'Nivel', 'int NULL'
GO


/****** RepParam  ******/
if not exists (select * from SysTabla where SysTabla = 'RepParam') 
INSERT INTO SysTabla (SysTabla) VALUES ('RepParam')
if not exists (select * from sysobjects where id = object_id('dbo.RepParam') and type = 'U') 
CREATE TABLE dbo.RepParam (
	Estacion				int		NOT NULL,
	AccesoID				int		NULL,
	
	InfoAgenteA				varchar(10)	NULL,
	InfoAgenteD				varchar(10)	NULL,
	InfoAgrupadoCC			varchar(50)	NULL,
	InfoAlmacen				varchar(10)	NULL,
	InfoAlmacenA			varchar(10)	NULL,
	InfoAlmacenD			varchar(10)	NULL,
	InfoAlCentroCostos		varchar(50)	NULL,
	InfoAlCentroCostos2		varchar(50)	NULL,
	InfoAlCentroCostos3		varchar(50)	NULL,
	InfoArtCat				varchar(50)	NULL,
	InfoArtGrupo			varchar(50)	NULL,
	InfoArtFam				varchar(50)	NULL,
	InfoArticuloA			varchar(20)	NULL,
	InfoArticuloD			varchar(20)	NULL,
	InfoArtLinea			varchar(50)	NULL,
	
	InfoBaseDatos1			varchar(100)NULL,
	InfoBaseDatos2			varchar(100)NULL,

	InfoCaja				varchar(10) NULL,
	InfoCajero				varchar(10) NULL,
	InfoCatPersonal			varchar(50)	NULL,
	InfoCentroCostos		varchar(50)	NULL,
	InfoCentroCostos2		varchar(50)	NULL,
	InfoCentroCostos3		varchar(50)	NULL,
	InfoCtaA				varchar(20)	NULL,
	InfoCtaCat				varchar(50)	NULL,
	InfoCtaD				varchar(20)	NULL,
	InfoCtaDinero			varchar(10)	NULL,
	InfoCtaDineroD			varchar(10)	NULL,	
	InfoCtaDineroA			varchar(10)	NULL,		
	InfoCtaFam				varchar(50)	NULL,
	InfoCtaGrupo			varchar(50)	NULL,
	InfoCtaNivel			varchar(20)	NULL,
	InfoCteCat				varchar(50)	NULL,
	InfoCteFam				varchar(50)	NULL,
	InfoCteGrupo			varchar(50)	NULL,
	InfoCteTipo				varchar(50)	NULL,
	InfoClavePresupuestalA	varchar(50) NULL,
	InfoClavePresupuestalD	varchar(50) NULL,
	InfoCliente				varchar(10)	NULL,
	InfoClienteA			varchar(10)	NULL,
	InfoClienteD			varchar(10)	NULL,
	InfoClienteEnviarA		int		NULL,
	InfoConcepto			varchar(50)	NULL,
	InfoConMovs				varchar(20)	NULL,
	InfoConsecutivo			varchar(10)	NULL,
	InfoContMoneda			varchar(15)	NULL,
	InfoContrato			int		NULL,
	InfoContResAnual		varchar(50)	NULL,
	InfoControladora		varchar(5)	NULL,

	InfoDepartamento		varchar(50)	NULL,
	InfoDescripcion			varchar(100)NULL,
	InfoDesglosar			varchar(2)	NULL,
	InfoDias				int		NULL,
	
	InfoEjercicio			int		NULL,
	InfoEjercicioA			int		NULL,
	InfoEjercicioD			int		NULL,
	InfoEmpresa				varchar(5)	NULL,
	InfoEstatus				varchar(15)	NULL,
	InfoEstatusAltaBaja		varchar(4)	NULL,
	InfoEstatusEspecifico	varchar(15)	NULL,
	InfoEstatusFianza		varchar(30)	NULL,
	InfoEstatusLocales		varchar(15)	NULL,
	InfoEtiqueta			bit		NULL,	
	
	InfoFabricante			varchar(50)	NULL,
	InfoFechaA				datetime	NULL,	
	InfoFechaD				datetime	NULL,
	InfoFechaTrabajo		datetime	NULL,
	InfoFormaPago			varchar(50)	NULL,
	
	InfoGrupoLista			varchar(50)	NULL,
	InfoGrupoPersonal		varchar(50)	NULL,
	
	InfoID					int		NULL,
	InfoInmueble			varchar(50)	NULL,
	InfoInvVal				varchar(50)	NULL,
	
	InfoLayoutNomina		varchar(100)NULL,
	InfoLineasPorPagina		int		NULL,
	
	InfoMedida				varchar(50)	NULL,
	InfoModulo				varchar(5)	NULL,
	InfoMoneda				varchar(15)	NULL,
	InfoMov					varchar(20)	NULL,
	InfoMovID				varchar(20)	NULL,
	
	InfoNivel				varchar(20) NULL,
	InfoNomTipoRecibo		varchar(20)	NULL,
	InfoNumeroCliente		varchar(10)	NULL,
	
	InfoPeriodoA			int		NULL,
	InfoPeriodoD			int		NULL,	
	InfoPersonal			varchar(10)	NULL,
	InfoPersonalA			varchar(10)	NULL,
	InfoPersonalD			varchar(10)	NULL,
	InfoProveedor			varchar(10)	NULL,
	InfoProveedorA			varchar(10)	NULL,
	InfoProveedorD			varchar(10)	NULL,
	InfoProyecto			varchar(50)	NULL,	
	InfoPuesto				varchar(50)	NULL,
	
	InfoRepCompras			varchar(30)	NULL,
	InfoReportaA			varchar(20)	NULL,
	InfoReporteA			varchar(20)	NULL,
	InfoRepVentas			varchar(30)	NULL,	
	InformeGraficarCantidad	int	NULL	DEFAULT 5,
	InformeGraficarFecha	int	NULL	DEFAULT 12,
	InformeGraficarTipo		varchar(30)	DEFAULT "Mas Sobresalientes" NULL,
	
	InfoServidor1			varchar(100)NULL,
	InfoServidor2			varchar(100)NULL,
	InfoSucursal			int		NULL,
	InfoSucursalEdoCta		int		NULL,
	
	InfoTipoBackOrder		varchar(20)	NULL,
	InfoTitulo				varchar(50) NULL,	
	InfoTituloCXCEC			varchar(50)	NULL,
	InfoTituloCXPEC			varchar(50)	NULL,
	InfoTituloContRes		varchar(50)	NULL,
	InfoTituloContResAnual	varchar(50)	NULL,
	InfoTituloVTASTri		varchar(50)	NULL,

	InfoUEN					int	NULL,
	InfoUso					varchar(20) NULL DEFAULT '(Todos)',
	InfoUsuario				varchar(10)	NULL,

	RepAux					varchar(20)	NULL,
	RepMovEspecifico		varchar(20)	NULL,
	RepTitulo				varchar(100)NULL,

	InfoFechaDia			datetime	NULL,
	InfoInvValOtraMoneda	varchar(50) NULL,
	InfoCorte				varchar(50) NULL,

	InfoFechaRequeridaA		datetime	NULL,	
	InfoFechaRequeridaD		datetime	NULL,
	InfoServicio			varchar(50) NULL,

	VerGraficaDetalle		bit	NULL	DEFAULT 0,
	
	--REQ12615 WMS
	InfoAcomodador			varchar(50) NULL,
	InfoAlmacenWMS			varchar(10) NULL,
	InfoArtFabricante		varchar(50) NULL,
	InfoArticuloCaducidad	varchar(50) NULL,
	InfoArticuloEsp			varchar(20) NULL,
	InfoCaducidadA			datetime NULL,
	InfoCaducidadD			datetime NULL,
	InfoCaducidadDiaA		int NULL,
	InfoCaducidadDiaD		int NULL,
	InfoContacto			varchar(20) NULL,
	InfoContactoCat			varchar(50) NULL,
	InfoContactoCP			varchar(20) NULL,
	InfoContactoEspecifico	varchar(50) NULL,
	InfoContactoEstado		varchar(30) NULL,
	InfoContactoFam			varchar(50) NULL,
	InfoContactoGrupo		varchar(50) NULL,
	InfoContactoPais		varchar(30) NULL,
	InfoContactoRuta		varchar(50) NULL,
	InfoContactoZona		varchar(30) NULL,
	InfoEstatusTarima		varchar(15) NULL,
	InfoFechaEmision		datetime NULL,
	InfoFechaRequerida		datetime NULL,
	InfoFila				int NULL,
	InfoFlujo				varchar(10) NULL,
	InfoMontacarga			varchar(50) NULL,
	InfoMovimientoEsp		varchar(25) NULL,
	InfoNivelWMS			int NULL,
	InfoOrdenWMS			varchar(20) NULL,
	InfoPasillo				int NULL,
	InfoPosicion			varchar(20) NULL,
	InfoSucursalDestino		int NULL,
	InfoTarimaA				varchar(20) NULL,
	InfoTarimaARep			varchar(20) NULL,
	InfoTarimaD				varchar(20) NULL,
	InfoTarimaDRep			varchar(20) NULL,
	InfoTipo				varchar(20) NULL,
	InfoTipoCaducidad		varchar(50) NULL,
	InfoValuacion			varchar(25) NULL,
	InfoZona				varchar(50) NULL,

	CONSTRAINT priRepParam PRIMARY KEY CLUSTERED (Estacion)
)
GO
EXEC spAlter_Table 'RepParam','AccesoID','int NULL'

EXEC spAlter_Table 'RepParam','InfoAgenteA','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoAgenteD','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoAgrupadoCC','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoAlmacen','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoAlmacenA','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoAlmacenD','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoAlCentroCostos','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoAlCentroCostos2','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoAlCentroCostos3','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoArtCat','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoArtGrupo','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoArtFam','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoArticuloA','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoArticuloD','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoArtLinea','varchar(50) NULL'

EXEC spAlter_Table 'RepParam','InfoBaseDatos1','varchar(100) NULL'
EXEC spAlter_Table 'RepParam','InfoBaseDatos2','varchar(100) NULL'

EXEC spAlter_Table 'RepParam','InfoCaja', 'varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoCajero', 'varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoCatPersonal','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCentroCostos','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCentroCostos2','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCentroCostos3','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaA','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaCat','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaD','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaDinero','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaDineroA','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaDineroD','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaFam','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaGrupo','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCtaNivel','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoCteCat','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCteFam','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCteGrupo','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCteTipo','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoClavePresupuestalA','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoClavePresupuestalD','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoCliente','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoClienteA','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoClienteD','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoClienteEnviarA','int NULL'
EXEC spAlter_Table 'RepParam','InfoConcepto','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoConMovs','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoConsecutivo','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoContrato','int null'
EXEC spAlter_Table 'RepParam','InfoContResAnual','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContMoneda','varchar(15) NULL'
EXEC spAlter_Table 'RepParam','InfoControladora','varchar(5) NULL'

EXEC spAlter_Table 'RepParam','InfoDepartamento','varchar(50) null'
EXEC spAlter_Table 'RepParam','InfoDescripcion','varchar(100) null'
EXEC spAlter_Table 'RepParam','InfoDesglosar','varchar(2) NULL' 
EXEC spAlter_Table 'RepParam','InfoDias', 'int null'

EXEC spAlter_Table 'RepParam','InfoEjercicio','int NULL'
EXEC spAlter_Table 'RepParam','InfoEjercicioA','int NULL'
EXEC spAlter_Table 'RepParam','InfoEjercicioD','int NULL'
EXEC spAlter_Table 'RepParam','InfoEmpresa','varchar(5) null'
EXEC spAlter_Table 'RepParam','InfoEstatus','varchar(15) null'
EXEC spAlter_Table 'RepParam','InfoEstatusAltaBaja','varchar(4) null'
EXEC spAlter_Table 'RepParam','InfoEstatusEspecifico','varchar(15) null'
EXEC spAlter_Table 'RepParam','InfoEstatusFianza','varchar(30) null'
EXEC spAlter_Table 'RepParam','InfoEstatusLocales','varchar(15) null'
EXEC spAlter_Table 'RepParam','InfoEtiqueta','bit NULL' 

EXEC spAlter_Table 'RepParam','InfoFabricante','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoFechaA','datetime null'
EXEC spAlter_Table 'RepParam','InfoFechaD','datetime null'
EXEC spAlter_Table 'RepParam','InfoFechaTrabajo','datetime null'
EXEC spAlter_Table 'RepParam','InfoFormaPago','varchar(50) null'

EXEC spAlter_Table 'RepParam','InfoGrupoLista','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoGrupoPersonal','varchar(50) null'

EXEC spAlter_Table 'RepParam','InfoID','int NULL'
EXEC spAlter_Table 'RepParam','InfoInmueble','varchar(50) null'
EXEC spAlter_Table 'RepParam','InfoInvVal','varchar(50) NULL' 

EXEC spAlter_Table 'RepParam','InfoLayoutNomina','varchar(100) null'
EXEC spAlter_Table 'RepParam','InfoLineasPorPagina','int NULL'

EXEC spAlter_Table 'RepParam','InfoMedida','varchar(50) null'
EXEC spAlter_Table 'RepParam','InfoModulo','varchar(5)  NULL' 
EXEC spAlter_Table 'RepParam','InfoMoneda','varchar(15) null'
EXEC spAlter_Table 'RepParam','InfoMov','varchar(20) null'
EXEC spAlter_Table 'RepParam','InfoMovID','varchar(20) null'

EXEC spAlter_Table 'RepParam','InfoNivel','varchar(20) null'
EXEC spAlter_Table 'RepParam','InfoNOMTipoRecibo','varchar(20) null'
EXEC spAlter_Table 'RepParam','InfoNumeroCliente','varchar(10) null'

EXEC spAlter_Table 'RepParam','InfoPeriodoA','int NULL'
EXEC spAlter_Table 'RepParam','InfoPeriodoD','int NULL'
EXEC spAlter_Table 'RepParam','InfoPersonal','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoPersonalA','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoPersonalD','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoProveedor','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoProveedorA','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoProveedorD','varchar(10) NULL' 
EXEC spAlter_Table 'RepParam','InfoProyecto','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoPuesto','varchar(50) NULL'

EXEC spAlter_Table 'RepParam','InfoRepCompras','varchar(30) NULL' 
EXEC spALTER_TABLE 'RepParam','InfoReportaA','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoReporteA','varchar(20) NULL' 
EXEC spAlter_Table 'RepParam','InfoRepVentas','varchar(30) NULL'

EXEC spDROP_COLUMN 'RepParam', 'InformeGraficarCantidad'
EXEC spAlter_Table 'RepParam','InformeGraficarCantidad','int DEFAULT 5 WITH VALUES NULL'
EXEC spAlter_Table 'RepParam','InformeGraficarFecha','int DEFAULT 12 WITH VALUES NULL'
EXEC spAlter_Table 'RepParam','InformeGraficarTipo','varchar(30) DEFAULT "Mas Sobresalientes" WITH VALUES NULL'

EXEC spAlter_Table 'RepParam','InfoServidor1','varchar(100) NULL'
EXEC spAlter_Table 'RepParam','InfoServidor2','varchar(100) NULL'
EXEC spAlter_Table 'RepParam','InfoSucursal','int NULL'
EXEC spAlter_Table 'RepParam','InfoSucursalEdoCta','int NULL'

EXEC spAlter_Table 'RepParam','InfoTipoBackOrder','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTitulo','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoTituloCXCEC','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoTituloCXPEC','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoTituloContRes','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoTituloContResAnual','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoTituloVTASTri','varchar(50) NULL' 

EXEC spAlter_Table 'RepParam','InfoUEN','int NULL'
EXEC spAlter_Table 'RepParam','InfoUso','varchar(20) NULL DEFAULT "(Todos)"'
EXEC spAlter_Table 'RepParam','InfoUsuario','varchar(10) NULL'

EXEC spAlter_Table 'RepParam','RepAux','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','RepMovEspecifico','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','RepTitulo','varchar(100) NULL'
GO

EXEC spAlter_Table 'RepParam','InfoFechaDia', 'datetime NULL'
EXEC spAlter_Table 'RepParam','InfoInvValOtraMoneda','varchar(50) NULL' 
EXEC spAlter_Table 'RepParam','InfoCorte', 'varchar(50) NULL'
GO

EXEC spAlter_Table 'RepParam','InfoFechaRequeridaA','datetime null'
EXEC spAlter_Table 'RepParam','InfoFechaRequeridaD','datetime null'
EXEC spAlter_Table 'RepParam','InfoServicio','varchar(50) null'
GO

EXEC spAlter_Table 'RepParam','VerGraficaDetalle','bit	NULL DEFAULT 0 WITH VALUES'
GO

--REQ12615 WMS
EXEC spAlter_Table 'RepParam','InfoAcomodador','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoAlmacenWMS', 'varchar(10) null'
EXEC spAlter_Table 'RepParam','InfoArtFabricante', 'varchar(50) null'
EXEC spAlter_Table 'RepParam','InfoArticuloCaducidad','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoArticuloEsp', 'varchar(20) null'
EXEC spAlter_Table 'RepParam','InfoCaducidadA','datetime NULL'
EXEC spAlter_Table 'RepParam','InfoCaducidadD','datetime NULL'
EXEC spAlter_Table 'RepParam','InfoCaducidadDiaA','int NULL'
EXEC spAlter_Table 'RepParam','InfoCaducidadDiaD','int NULL'
EXEC spAlter_Table 'RepParam','InfoContacto','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoCat','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoCP','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoEspecifico','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoEstado','varchar(30) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoFam','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoGrupo','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoPais','varchar(30) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoRuta','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoContactoZona','varchar(30) NULL'
EXEC spAlter_Table 'RepParam','InfoEstatusTarima', 'varchar(15) null'
EXEC spAlter_Table 'RepParam','InfoFechaEmision','datetime NULL'
EXEC spAlter_Table 'RepParam','InfoFechaRequerida','datetime NULL'
EXEC spAlter_Table 'RepParam','InfoFila','int NULL'
EXEC spAlter_Table 'RepParam','InfoFlujo','varchar(10) NULL'
EXEC spAlter_Table 'RepParam','InfoMontacarga','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoMovimientoEsp', 'varchar(25) null'
EXEC spAlter_Table 'RepParam','InfoNivelWMS','int NULL'
EXEC spAlter_Table 'RepParam','InfoOrdenWMS', 'varchar(20) null'
EXEC spAlter_Table 'RepParam','InfoPasillo','int NULL'
EXEC spAlter_Table 'RepParam','InfoPosicion', 'varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoSucursalDestino', 'int NULL'
EXEC spAlter_Table 'RepParam','InfoTarimaA','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTarimaARep','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTarimaD','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTarimaDRep','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTipo','varchar(20) NULL'
EXEC spAlter_Table 'RepParam','InfoTipoCaducidad','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoValuacion', 'varchar(25) null'
EXEC spAlter_Table 'RepParam','InfoZona','varchar(50) NULL'
GO

-- BUG 16101
EXEC spAlter_Table 'RepParam','InfoProyectoD','varchar(50) NULL'
EXEC spAlter_Table 'RepParam','InfoProyectoA','varchar(50) NULL'
GO

EXEC spCHANGE_COLUMN 'RepParam', 'InfoClienteEnviarA', 'varchar', 20, 'int', null
GO

--REQ 1586 Preconfigurado
EXEC spAlter_Table 'RepParam','InfoEdoCtaRangos','varchar(50) NULL'
GO

-- drop table Variable
/****** Variable  ******/
if not exists (select * from SysTabla where SysTabla = 'Variable') 
INSERT INTO SysTabla (SysTabla) VALUES ('Variable')
if not exists (select * from sysobjects where id = object_id('dbo.Variable') and type = 'U') 
CREATE TABLE dbo.Variable (
	Estacion		int		NOT NULL,
	Variable		varchar(100)	NOT NULL,

	ValorChar		varchar(255)	NULL,
	ValorInt		int		NULL,
	ValorFloat		float		NULL,
	ValorDateTime		datetime	NULL,
	ValorBit		bit		NULL	DEFAULT 0,

	CONSTRAINT priVariable PRIMARY KEY CLUSTERED (Variable, Estacion)
)
GO
EXEC spALTER_TABLE 'Variable', 'Estacion', 'int NOT NULL'
EXEC spALTER_TABLE 'Variable', 'ValorChar', 'varchar(255)NULL'
EXEC spALTER_TABLE 'Variable', 'ValorInt', 'int NULL'
EXEC spALTER_TABLE 'Variable', 'ValorFloat', 'float NULL'
EXEC spALTER_TABLE 'Variable', 'ValorDateTime', 'datetime NULL'
EXEC spALTER_TABLE 'Variable', 'ValorBit', 'bit	NULL DEFAULT 0'
GO


/*************** spVariableInit *******************/
if exists (select * from sysobjects where id = object_id('dbo.spVariableInit') and type = 'P') drop procedure dbo.spVariableInit
GO             
CREATE PROCEDURE spVariableInit
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Variable  
     SET ValorChar = NULL,
         ValorInt = NULL,
         ValorFloat = NULL,
         ValorDateTime = NULL,
         ValorBit = NULL
   WHERE Estacion = @Estacion
END
GO

/*************** spVariablePut *******************/
if exists (select * from sysobjects where id = object_id('dbo.spVariablePut') and type = 'P') drop procedure dbo.spVariablePut
GO             
CREATE PROCEDURE spVariablePut
			@Estacion	int,
			@Variable	varchar(100),
			@ValorChar	varchar(255)	= NULL,
			@ValorInt	int		= NULL,
			@ValorFloat	float		= NULL,
			@ValorDateTime	datetime	= NULL,
			@ValorBit	bit		= NULL,
			@Inc		bit		= 0
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Variable  
     SET ValorChar     = @ValorChar,
         ValorInt      = CASE WHEN @Inc = 1 THEN NULLIF(ISNULL(ValorInt, 0.0) + @ValorInt, 0.0) ELSE @ValorInt END,
         ValorFloat    = CASE WHEN @Inc = 1 THEN NULLIF(ISNULL(ValorFloat, 0.0) + @ValorFloat, 0.0) ELSE @ValorFloat END,
         ValorDateTime = @ValorDateTime,
         ValorBit = @ValorBit
   WHERE Estacion = @Estacion 
     AND Variable = @Variable
  IF @@ROWCOUNT = 0
    INSERT Variable 
           (Estacion,  Variable,  ValorChar,  ValorInt,  ValorFloat,  ValorDateTime,  ValorBit)
    VALUES (@Estacion, @Variable, @ValorChar, @ValorInt, @ValorFloat, @ValorDateTime, @ValorBit)
END
GO

/*************** spVariableGet *******************/
if exists (select * from sysobjects where id = object_id('dbo.spVariableGet') and type = 'P') drop procedure dbo.spVariableGet
GO             
CREATE PROCEDURE spVariableGet
			@Estacion	int,
			@Variable	varchar(100),
			@ValorChar	varchar(255)	= NULL OUTPUT,
			@ValorInt	int		= NULL OUTPUT,
			@ValorFloat	float		= NULL OUTPUT,
			@ValorDateTime	datetime	= NULL OUTPUT,
			@ValorBit	bit		= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @ValorChar = ValorChar,
         @ValorInt = ValorInt,
         @ValorFloat = ValorFloat,
         @ValorDateTime = ValorDateTime,
         @ValorBit = ValorBit
    FROM Variable  
   WHERE Estacion = @Estacion 
     AND Variable = @Variable
END
GO

/****** Acceso ******/
if not exists(select * from SysTabla where SysTabla = 'Acceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Acceso','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.Acceso') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Acceso (
        ID			int		NOT NULL IDENTITY(1,1),

	Empresa 		varchar(5) 	NULL,
	EstacionTrabajo		int		NULL,
	Sucursal		int		NULL,
	Usuario 		varchar(10)  	NULL,
	Contrasena		varchar(32)	NULL,
	FechaTrabajo		datetime  	NULL,
	FechaRegistro		datetime	NULL,
	FechaSalida		datetime	NULL,
	SPID			int		NULL	DEFAULT @@SPID,

	CONSTRAINT priAcceso PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Acceso'
END
GO
if not exists(select * from syscampo where tabla = 'Acceso' and Campo = 'Sucursal')
  ALTER TABLE Acceso ADD Sucursal int NULL
GO
EXEC spALTER_TABLE 'Acceso', 'FechaSalida', 'datetime	NULL'
EXEC spALTER_TABLE 'Acceso', 'SPID' ,'int NULL DEFAULT @@SPID'
GO
EXEC spADD_INDEX 'Acceso', 'SPID', 'SPID, ID'
GO
--Optimización Bug 18308
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Acceso' AND sysindexes.name = 'Fechasalida' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Fechasalida ON Acceso(SPID,FechaSalida)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgAccesoA') and sysstat & 0xf = 8) drop trigger dbo.tgAccesoA
GO
IF EXISTS(SELECT * FROM SysTipoDatos WHERE Tabla='Acceso' AND Campo='Contrasena' AND Tamano=10)
BEGIN
  EXEC("spALTER_COLUMN 'Acceso', 'Contrasena', 'varchar(32) NULL'")
  EXEC("UPDATE Acceso SET Contrasena = NULL WHERE LEN(Contrasena)<32")
END
GO

EXEC spALTER_COLUMN 'Acceso', 'Empresa', 'varchar(5) NULL'
EXEC spALTER_COLUMN 'Acceso', 'Usuario', 'varchar(10) NULL'
GO

EXEC spFK 'Acceso','Empresa','Empresa','Empresa'
EXEC spFK 'Acceso','Usuario','Usuario','Usuario'
EXEC spFK 'Acceso','Sucursal','Sucursal','Sucursal'
GO

/**************** fnAccesoID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAccesoID') DROP FUNCTION fnAccesoID
GO
CREATE FUNCTION fnAccesoID (@SPID int)
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @ID	int
  SELECT @ID = MAX(ID)
    FROM Acceso
   WHERE SPID = @SPID AND FechaSalida IS NULL
  RETURN @ID
END
GO

/****** SysBaseWeb ******/
if not exists (select * from SysTabla where SysTabla = 'SysBaseWeb') 
INSERT INTO SysTabla (SysTabla) VALUES ('SysBaseWeb')
if not exists (select * from sysobjects where id = object_id('dbo.SysBaseWeb') and type = 'U') 
CREATE TABLE dbo.SysBaseWeb (
	Objeto			varchar(50)	NOT NULL, 
	Fecha			datetime	NULL,
	Datos			image		NULL,
	
	CONSTRAINT priSysBaseWeb PRIMARY KEY CLUSTERED (Objeto)

)
go

