/****************** Corte ************************/
if not exists (select * from SysTabla where SysTabla = 'Corte') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Corte','Movimiento','CORTE')
if not exists (select * from sysobjects where id = object_id('Corte') and type = 'u')
  CREATE TABLE Corte(
    ID					int			NOT NULL IDENTITY(1, 1),
    
    Empresa				varchar(5)	NOT NULL, 
    Mov					varchar(20)	NOT NULL,
    MovID				varchar(20)	NULL,
    FechaEmision		datetime	NULL, 
    UltimoCambio		datetime	NULL,
    Concepto			varchar(50)	NULL,
    Proyecto			varchar(50)	NULL,
    UEN					int			NULL,
    Usuario				varchar(10)	NULL,
    Autorizacion		varchar(10)	NULL,
    Referencia			varchar(50)	NULL,
    Observaciones		varchar(100)NULL,
    Estatus				varchar(15)	NULL,
    Situacion			varchar(50)	NULL,
    SituacionFecha		datetime	NULL,
    SituacionUsuario	varchar(10)	NULL,
    SituacionNota		varchar(100)NULL,
    OrigenTipo			varchar(10)	NULL,
    Origen				varchar(20)	NULL,
    OrigenID			varchar(20)	NULL,
    Ejercicio			int			NULL,
    Periodo				int			NULL,
    FechaRegistro		datetime	NULL,
    FechaConclusion		datetime	NULL,
    FechaCancelacion	datetime	NULL,
    Sucursal			int			NOT NULL DEFAULT 0,
    SucursalOrigen		int			NOT NULL DEFAULT 0,
    SucursalDestino		int			NOT NULL DEFAULT 0,
	CorteFrecuencia		varchar(50)	NULL,
	CorteGrupo			varchar(50)	NULL,
	CorteTipo			varchar(50)	NULL,
	CortePeriodo		int			NULL,
	CorteEjercicio		int			NULL,
	CorteOrigen			varchar(50)	NULL,	
	
    CorteCuentaTipo		varchar(20)	NULL,    
    CorteGrupoDe		varchar(10)	NULL,
    CorteGrupoA			varchar(10)	NULL,
    CorteSubGrupoDe		varchar(20)	NULL,        
    CorteSubGrupoA		varchar(20)	NULL,
    CorteCuentaDe		varchar(10)	NULL,
    CorteCuentaA		varchar(10)	NULL,
    CorteSubCuentaDe	varchar(50)	NULL,
    CorteSubCuenta2A	varchar(50)	NULL,
    CorteSubCuenta2De	varchar(50)	NULL,
    CorteSubCuenta3A	varchar(50)	NULL,
    CorteSubCuenta3De	varchar(50)	NULL,
    CorteSubCuentaA		varchar(50)	NULL,
    CorteUENDe			int			NULL,
    CorteUENA			int			NULL,
    CorteProyectoDe		varchar(50)	NULL,
    CorteProyectoA		varchar(50)	NULL,
    CorteFechaD			datetime	NULL,
    CorteFechaA			datetime	NULL,
    Moneda				varchar(10)	NULL,
    TipoCambio			float		NULL,    
    CorteTitulo			varchar(100)NULL,
    CorteMensaje		varchar(100)NULL,
    CorteEstatus		varchar(15)	NULL,
	CorteSucursalDe		int			NULL,
	CorteSucursalA		int			NULL,
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 	

    CONSTRAINT priCorte PRIMARY KEY CLUSTERED(ID)
    )
GO

EXEC spALTER_TABLE 'Corte', 'CorteValuacion', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'Corte', 'CorteDesglosar', 'varchar(2)', 'NULL'
EXEC spALTER_TABLE 'Corte', 'CorteDesglosar', 'varchar(2)', 'NULL'
EXEC spALTER_TABLE 'Corte', 'CorteDesglosar', 'varchar(2)', 'NULL'

EXEC spALTER_TABLE 'Corte', 'Importe', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'SaldoI', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'Cargo', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'Abono', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'Saldo', 'float', 'NULL'

EXEC spALTER_TABLE 'Corte', 'SaldoUI', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'CargoU', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'AbonoU', 'float', 'NULL'
EXEC spALTER_TABLE 'Corte', 'SaldoU', 'float', 'NULL'


EXEC spALTER_TABLE 'Corte', 'CorteFiltrarFechas', 'bit', 'NULL'

EXEC spALTER_TABLE 'Corte', 'Frecuencia', 'varchar (20) NULL', '''Diaria'''
EXEC spALTER_TABLE 'Corte', 'Domingo', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Lunes', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Martes', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Miercoles', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Jueves', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Viernes', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'Sabado', 'bit NULL', '0'
EXEC spALTER_TABLE 'Corte', 'DiaMes', 'int NULL'
EXEC spALTER_TABLE 'Corte', 'FechaInicio', 'datetime NULL'
EXEC spDROP_COLUMN 'Corte', 'FechaInicio'

EXEC spALTER_TABLE 'Corte', 'VigenciaD', 'datetime NULL'
EXEC spALTER_TABLE 'Corte', 'VigenciaA', 'datetime NULL'
EXEC spALTER_TABLE 'Corte', 'CorteMoneda', 'varchar(10) NULL'

EXEC spALTER_TABLE 'Corte', 'CorteNoPeriodos', 'int NULL'
EXEC spALTER_TABLE 'Corte', 'CorteTipoPeriodo', 'varchar(3) NULL'

 --REQ 15739 
Exec spAlter_Table 'Corte','CFDFlexEstatus','varchar(15) Null'
EXEC spADD_INDEX 'Corte', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
GO

/****************** CorteD ************************/
if not exists (select * from SysTabla where SysTabla = 'CorteD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CorteD','Movimiento','CORTE')
if not exists (select * from sysobjects where id = object_id('CorteD') and type = 'u')
  CREATE TABLE CorteD(
    ID						int			NOT NULL,
    Renglon					float		NOT NULL,
    RenglonSub				int			NOT NULL,

    RID						int			NOT NULL IDENTITY(1, 1),    
    Cuenta					varchar(20)	NULL,
    Mov						varchar(20)	NULL,
    MovID					varchar(20)	NULL,
    Fecha					datetime	NULL,
    Vencimiento				datetime	NULL,
    Moneda					varchar(10)	NULL,
    Aplica					varchar(20)	NULL,
    AplicaID				varchar(20)	NULL,
    Referencia				varchar(50)	NULL,
    CtaCreditoDias			int			NULL,
    CtaCondicion			varchar(50)	NULL,
    CtaLimiteCredito		float		NULL,
    CtaLimiteCreditoMoneda	varchar(10) NULL,
    
    Cargo					float		NULL,
    Abono					float		NULL,
    CargoU					float		NULL,
    AbonoU					float		NULL,
    
    CONSTRAINT priCorteD PRIMARY KEY CLUSTERED(ID, Renglon, RenglonSub)
    )
GO

EXEC spALTER_TABLE 'CorteD', 'SaldoU', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'CostoPromedio', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'UltimoCosto', 'float', 'NULL'

EXEC spALTER_TABLE 'CorteD', 'ValuacionNombre', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'ValuacionValor', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'ValuacionValorArtConCosto', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'PrecioLista', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio2', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio3', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio4', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio5', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio6', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio7', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio8', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio9', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio10', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'CostoEstandar', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'CostoReposicion', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Grupo', 'varchar(10)', 'NULL'

EXEC spALTER_TABLE 'CorteD', 'Sucursal', 'int', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'SubCuenta', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'CostoUnitario', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'CostoUnitarioOtraMoneda', 'float', 'NULL'

EXEC spALTER_TABLE 'CorteD', 'MonedaContable', 'varchar(10)', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Modulo', 'varchar(5)', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'ModuloID', 'int', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Cantidad', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Precio', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Importe', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'RIDConsulta', 'int', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'TipoCambio', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Saldo', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Empresa', 'varchar(5)', 'NULL'

EXEC spALTER_TABLE 'CorteD', 'Periodo', 'int', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Ejercicio', 'int', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'Estatus', 'varchar(15)', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'SaldoI',   'float', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'EsCancelacion',   'bit', 'NULL'
EXEC spALTER_TABLE 'CorteD', 'SaldoUI', 'float', 'NULL'

/****************** CorteDReporte ************************/
if not exists (select * from SysTabla where SysTabla = 'CorteDReporte') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CorteDReporte','Movimiento','CORTE')
if not exists (select * from sysobjects where id = object_id('CorteDReporte') and type = 'u')
  CREATE TABLE CorteDReporte(
    ID					int			NOT NULL,
    Renglon				float		NOT NULL,
    RenglonSub			int			NOT NULL DEFAULT 0,
    
    RID					int			NOT NULL IDENTITY(1, 1),
	Tipo				varchar(5)	NOT NULL,
	Columna1			varchar(100)NULL,
	Columna2			varchar(100)NULL,	
	Columna3			varchar(100)NULL,	
	Columna4			varchar(100)NULL,	
	Columna5			varchar(100)NULL,	
	Columna6			varchar(100)NULL,	
	Columna7			varchar(100)NULL,	
	Columna8			varchar(100)NULL,	
	Columna9			varchar(100)NULL,	
	Columna10			varchar(100)NULL,	
	Columna11			varchar(100)NULL,
	Columna12			varchar(100)NULL,	
	Columna13			varchar(100)NULL,	
	Columna14			varchar(100)NULL,	
	Columna15			varchar(100)NULL,	
	Columna16			varchar(100)NULL,	
	Columna17			varchar(100)NULL,	
	Columna18			varchar(100)NULL,	
	Columna19			varchar(100)NULL,	
	Columna20			varchar(100)NULL,	
	Columna21			varchar(100)NULL,
	Columna22			varchar(100)NULL,	
	Columna23			varchar(100)NULL,	
	Columna24			varchar(100)NULL,	
	Columna25			varchar(100)NULL,	
	Columna26			varchar(100)NULL,	
	Columna27			varchar(100)NULL,	
	Columna28			varchar(100)NULL,	
	Columna29			varchar(100)NULL,	
	Columna30			varchar(100)NULL,	
	Columna31			varchar(100)NULL,
	Columna32			varchar(100)NULL,	
	Columna33			varchar(100)NULL,	
	Columna34			varchar(100)NULL,	
	Columna35			varchar(100)NULL,	
	Columna36			varchar(100)NULL,	
	Columna37			varchar(100)NULL,	
	Columna38			varchar(100)NULL,	
	Columna39			varchar(100)NULL,	
	Columna40			varchar(100)NULL,	
	Columna41			varchar(100)NULL,
	Columna42			varchar(100)NULL,	
	Columna43			varchar(100)NULL,	
	Columna44			varchar(100)NULL,	
	Columna45			varchar(100)NULL,	
	Columna46			varchar(100)NULL,	
	Columna47			varchar(100)NULL,	
	Columna48			varchar(100)NULL,	
	Columna49			varchar(100)NULL,	
	Columna50			varchar(100)NULL,
	
	Agrupador1			varchar(100)NULL,
	Agrupador2			varchar(100)NULL,
	Agrupador3			varchar(100)NULL,
	Agrupador4			varchar(100)NULL,
	Agrupador5			varchar(100)NULL,
	Agrupador6			varchar(100)NULL,
	Agrupador7			varchar(100)NULL,
	Agrupador8			varchar(100)NULL,
	Agrupador9			varchar(100)NULL,
	Agrupador10			varchar(100)NULL,
	
    CONSTRAINT priCorteDReporte PRIMARY KEY CLUSTERED(ID, Renglon, RenglonSub)
    )
GO

EXEC spALTER_COLUMN 'CorteDReporte', 'Tipo', 'varchar(5)	NULL'

/****************** CorteC ************************/
if not exists (select * from SysTabla where SysTabla = 'CorteC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CorteC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('CorteC') and type = 'u')
  CREATE TABLE CorteC(
	ID			int			IDENTITY(1,1) NOT NULL,
	
	Empresa		char(5)		NULL,
	Mov			char(20)	NULL,
	Serie		varchar(20) NULL,
	Periodo		int			NULL,
	Ejercicio	int			NULL,
	Consecutivo int			NOT NULL	DEFAULT 0,
	Sucursal	int			NOT NULL	DEFAULT 0,
	
    CONSTRAINT priCorteC PRIMARY KEY CLUSTERED(ID)
)
GO

/****************** CorteFrecuencia ************************/
if not exists(select * from SysTabla where SysTabla = 'CorteFrecuencia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorteFrecuencia','Maestro')
if not exists (select * from sysobjects where id = object_id('CorteFrecuencia') and type = 'u')
  CREATE TABLE CorteFrecuencia(
    Frecuencia			varchar(50)	NOT NULL,
    
    CONSTRAINT priCorteFrecuencia PRIMARY KEY CLUSTERED(Frecuencia)
    )
GO

/****************** CorteGrupo ************************/
if not exists(select * from SysTabla where SysTabla = 'CorteGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorteGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('CorteGrupo') and type = 'u')
  CREATE TABLE CorteGrupo(
    Grupo				varchar(50)	NOT NULL,
    
    CONSTRAINT priCorteGrupo PRIMARY KEY CLUSTERED(Grupo)
    )
GO

/****************** CorteTipo ************************/
if not exists(select * from SysTabla where SysTabla = 'CorteTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorteTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('CorteTipo') and type = 'u')
  CREATE TABLE CorteTipo(
    Tipo				varchar(50)	NOT NULL,
    
    CONSTRAINT priCorteTipo PRIMARY KEY CLUSTERED(Tipo)
    )
GO

/****************** CorteMovTotalizadorTipoCampo ************************/
if not exists(select * from SysTabla where SysTabla = 'CorteMovTotalizadorTipoCampo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorteMovTotalizadorTipoCampo','Maestro')
if not exists (select * from sysobjects where id = object_id('CorteMovTotalizadorTipoCampo') and type = 'u')
  CREATE TABLE CorteMovTotalizadorTipoCampo(
    Totalizador			varchar(255) NOT NULL,
    Tipo				varchar(255) NOT NULL,
    
    CONSTRAINT priCorteMovTotalizadorTipoCampo PRIMARY KEY CLUSTERED(Totalizador)
    )
GO

/****************** CorteMovTotalizador ************************/
if not exists(select * from SysTabla where SysTabla = 'CorteMovTotalizador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CorteMovTotalizador','Maestro')
if not exists (select * from sysobjects where id = object_id('CorteMovTotalizador') and type = 'u')
  CREATE TABLE CorteMovTotalizador(
    Mov					varchar(20)	 NOT NULL,
    Totalizador			varchar(255) NOT NULL,
    
    CONSTRAINT priCorteMovTotalizador PRIMARY KEY CLUSTERED(Mov, Totalizador)
    )
GO

/****** CorteDConsulta ******/
if not exists (select * from SysTabla where SysTabla = 'CorteDConsulta') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CorteDConsulta','Movimiento','CORTE')
if not exists (select * from sysobjects where id = object_id('dbo.CorteDConsulta') and type = 'U') 
CREATE TABLE dbo.CorteDConsulta (
    ID						int			NOT NULL,
    Renglon					float		NOT NULL,
    RenglonSub				int			NOT NULL	DEFAULT 0,

    RID						int identity(1,1) NOT NULL,	
	Empresa					varchar(10) NULL,
	Sucursal				varchar(10) NULL,
	UEN						varchar(10) NULL,
	Usuario					varchar(10) NULL,
	Modulo					varchar(10) NULL,
	Movimiento				varchar(20) NULL,
	Estatus					varchar(15) NULL,
	Situacion				varchar(50) NULL,
	Proyecto				varchar(50) NULL,
	ContactoTipo			varchar(20) NULL,
	Contacto				varchar(10) NULL,
	ImporteMin				float		NULL,
	ImporteMax				float		NULL,
	ValidarAlEmitir			bit			NULL DEFAULT 1,

	CONSTRAINT priCorteDConsulta PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
)
GO

EXEC spALTER_TABLE 'CorteDConsulta', 'Signo', 'varchar(5)', 'NULL'
EXEC spDROP_COLUMN 'CorteDConsulta', 'Signo'

EXEC spALTER_TABLE 'CorteDConsulta', 'Accion', 'varchar(8)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Informativo', 'varchar(2)', 'NULL'
EXEC spDROP_COLUMN 'CorteDConsulta', 'Informativo'
EXEC spALTER_TABLE 'CorteDConsulta', 'Desglosar', 'varchar(2)', 'NULL'
EXEC spALTER_COLUMN 'CorteDConsulta', 'Desglosar', 'varchar(20)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Agrupador', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Importe', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Moneda', 'varchar(10)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Totalizador', 'varchar(255)', 'NULL'

EXEC spALTER_TABLE 'CorteDConsulta', 'Cuenta', 'varchar(20)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaCategoria', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaFamilia', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaGrupo', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaFabricante', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaLinea', 'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CtaTipo', 'varchar(50)', 'NULL'

EXEC spALTER_TABLE 'CorteDConsulta', 'Saldo',   'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Cargo',   'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Abono',   'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Importe', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'SaldoI',   'float', 'NULL'

EXEC spALTER_TABLE 'CorteDConsulta', 'SaldoUI', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'CargoU', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'AbonoU', 'float', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'SaldoU', 'float', 'NULL'


EXEC spALTER_TABLE 'CorteDConsulta', 'Rama',    'varchar(50)', 'NULL'
EXEC spALTER_TABLE 'CorteDConsulta', 'Almacen', 'varchar(50)', 'NULL'

/* CorteTrabajo */
if not exists(select * from SysTabla where SysTabla = 'CorteTrabajo')
INSERT INTO SysTabla (SysTabla) VALUES ('CorteTrabajo')
if not exists (select * from sysobjects where id = object_id('dbo.CorteTrabajo') and type = 'U') 
CREATE TABLE dbo.CorteTrabajo (
    Trabajo        		varchar(100)NOT NULL,

	spSucursal			int			NOT NULL,
	spEmpresa			varchar(5)	NOT NULL,
	spUsuario			varchar(30) NOT NULL,
	Nombre				varchar(100)	NULL,
	Descripcion			varchar(255)	NULL,
	UltimaActualizacion	datetime		NULL	DEFAULT GETDATE(),
	Activo				bit				NULL	DEFAULT 0,

	Modificar			bit				NULL	DEFAULT 0,


	HoraInicial			varchar(6)		NULL	DEFAULT '00:00',
	HoraFinal			varchar(6)		NULL	DEFAULT '23:59',
	Frecuencia			varchar (20)	NULL	DEFAULT 'Diaria',
	Valor				tinyint			NULL	DEFAULT 1,
	Recurrencia			tinyint			NULL	DEFAULT 1,
	FrecuenciaD			varchar (20)	NULL	DEFAULT 'Minutos',
	ValorD				tinyint			NULL	DEFAULT 30,
	
	Usuario    			varchar(30)		NULL	DEFAULT 'sa',
  	Contrasena  		varchar(30)		NULL	DEFAULT '',
  	
  	Domingo				bit				NULL	DEFAULT 0,
  	Lunes				bit				NULL	DEFAULT 0,
  	Martes				bit				NULL	DEFAULT 0,
  	Miercoles			bit				NULL	DEFAULT 0,
  	Jueves				bit				NULL	DEFAULT 0,
  	Viernes				bit				NULL	DEFAULT 0,
  	Sabado				bit				NULL	DEFAULT 0,
  	
  	Tipo  				varchar(30)		NULL	DEFAULT 'Primer',
  	Dia  				varchar(30)		NULL	DEFAULT 'Lunes',
  	FechaInicial		datetime		NULL    DEFAULT	GETDATE(),

	Procesar    		varchar(30)		NULL	DEFAULT 'Procesar Notificaciones',
  	
    	CONSTRAINT priCorteTrabajo PRIMARY KEY  CLUSTERED (Trabajo)
)
GO

EXEC spALTER_TABLE 'CorteTrabajo', 'Procesar', 'varchar(30) NULL DEFAULT "Procesar Cortes"'
GO

IF NOT EXISTS (SELECT * FROM CorteTrabajo WHERE Trabajo = 'Corte_DEMO_ 0_DEMO_Procesar Notificaciones')
INSERT CorteTrabajo (Trabajo,	Nombre,   Descripcion, spSucursal, spEmpresa, spUsuario)
VALUES('Corte_DEMO_ 0_DEMO_Procesar Notificaciones', 'Corte_DEMO_ 0_DEMO_Procesar Cortes', 'Intelisis Service', 0, 'DEMO', 'DEMO')

/****************** cCorteDReporte ************************/
if exists (select * from sysobjects where id = object_id('dbo.cCorteDReporte') and sysstat & 0xf = 2) drop view dbo.cCorteDReporte
GO
CREATE VIEW cCorteDReporte
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Tipo,
  Columna1,
  Columna2,
  Columna3,
  Columna4,
  Columna5,
  Columna6,
  Columna7,
  Columna8,
  Columna9,
  Columna10,
  Columna11,
  Columna12,
  Columna13,
  Columna14,
  Columna15,
  Columna16,
  Columna17,
  Columna18,
  Columna19,
  Columna20,
  Columna21,
  Columna22,
  Columna23,
  Columna24,
  Columna25
  Columna26,
  Columna27,
  Columna28,
  Columna29,
  Columna30,
  Columna31,
  Columna32,
  Columna33,
  Columna34,
  Columna35,
  Columna36,
  Columna37,
  Columna38,
  Columna39,
  Columna40,
  Columna41,
  Columna42,
  Columna43,
  Columna44,
  Columna45,
  Columna46,
  Columna47,
  Columna48,
  Columna49,
  Columna50
  
FROM
  CorteDReporte
GO

/****************** cCorteDConsulta ************************/
if exists (select * from sysobjects where id = object_id('dbo.cCorteDConsulta') and sysstat & 0xf = 2) drop view dbo.cCorteDConsulta
GO
CREATE VIEW cCorteDConsulta
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,

  Empresa,
  Sucursal,
  UEN,
  Usuario,
  Modulo,
  Movimiento,
  Estatus,
  Situacion,
  Proyecto,
  ContactoTipo,
  Contacto,
  ImporteMin,
  ImporteMax,
  ValidarAlEmitir,
  Desglosar,
  Agrupador,  
  Accion,
  Moneda,
  Totalizador,
  Cuenta,
  CtaCategoria,
  CtaFamilia,
  CtaGrupo,
  Rama,
  CtaFabricante,
  CtaLinea,
  Almacen,
  CtaTipo

FROM
  CorteDConsulta
GO

/*** CorteDConsultaNormalizada ***/
if exists (select * from sysobjects where id = object_id('dbo.CorteDConsultaNormalizada') and type = 'V') drop view dbo.CorteDConsultaNormalizada
GO
CREATE VIEW CorteDConsultaNormalizada
--//WITH ENCRYPTION
AS 
SELECT 
  cd.ID, 
  cd.RID,
  CONVERT(varchar(5),NULLIF(NULLIF(cd.Empresa,'(TODOS)'), '')) Empresa,
  CONVERT(int,NULLIF(NULLIF(cd.Sucursal,'(TODOS)'), '')) Sucursal,
  CONVERT(int,NULLIF(NULLIF(cd.UEN,'(TODOS)'), '')) UEN,  
  NULLIF(NULLIF(cd.Usuario,'(TODOS)'), '') Usuario,    
  CONVERT(varchar(5),NULLIF(NULLIF(cd.Modulo,'(TODOS)'), '')) Modulo,
  NULLIF(NULLIF(cd.Movimiento,'(TODOS)'), '') Movimiento,            
  e.Estatus Estatus,              
  NULLIF(NULLIF(cd.Situacion,'(TODOS)'), '') Situacion,
  NULLIF(NULLIF(cd.Proyecto,'(TODOS)'), '') Proyecto,
  NULLIF(NULLIF(cd.ContactoTipo,'(TODOS)'), '') ContactoTipo,      
  NULLIF(NULLIF(cd.Contacto,'(TODOS)'), '') Contacto,
  NULLIF(cd.ImporteMin,0.0) ImporteMin,  
  NULLIF(cd.ImporteMax,0.0) ImporteMax,
  ValidarAlEmitir ValidarAlEmitir,
  Accion,
  Desglosar,
  Agrupador,
  NULLIF(NULLIF(cd.Moneda,'(TODOS)'), '') Moneda,
  Totalizador,
  NULLIF(NULLIF(cd.Cuenta,'(TODOS)'), '') Cuenta,
  NULLIF(NULLIF(cd.CtaCategoria,'(TODOS)'), '') CtaCategoria,
  NULLIF(NULLIF(cd.CtaFamilia,'(TODOS)'), '') CtaFamilia,
  NULLIF(NULLIF(cd.CtaGrupo,'(TODOS)'), '') CtaGrupo,
  NULLIF(NULLIF(cd.CtaFabricante,'(TODOS)'), '')  CtaFabricante,
  NULLIF(NULLIF(cd.CtaLinea,'(TODOS)'), '') CtaLinea,
  NULLIF(NULLIF(cd.Rama,'(TODOS)'), '') Rama,
  NULLIF(NULLIF(cd.Almacen,'(TODOS)'), '') Almacen,
  NULLIF(NULLIF(cd.CtaTipo,'(TODOS)'), '') CtaTipo  
  FROM CorteDConsulta cd 
  LEFT OUTER JOIN Estatus e ON UPPER(RTRIM(e.Nombre)) = UPPER(RTRIM(NULLIF(NULLIF(cd.Estatus,'(TODOS)'), '')))
GO