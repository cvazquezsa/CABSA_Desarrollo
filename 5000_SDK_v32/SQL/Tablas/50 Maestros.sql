/* MAESTROS             */

/****** SubModulos  ******/
if not exists(select * from SysTabla where SysTabla = 'SubModulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SubModulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SubModulo') and type = 'U') 
CREATE TABLE dbo.SubModulo (
	Modulo 		        varchar(5)		NOT NULL,
	SubModulo		varchar(5)		NOT NULL,

	Nombre			varchar(50)	NULL,
	Filtrar			bit		NULL	DEFAULT 0,
	Orden			int		NULL,

	CONSTRAINT priSubModulo PRIMARY KEY  CLUSTERED (Modulo, SubModulo)
)
GO

/****** Modulos  ******/
if not exists(select * from SysTabla where SysTabla = 'Modulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Modulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Modulo') and type = 'U') 
CREATE TABLE dbo.Modulo (
	Modulo 				char(5)		NOT NULL ,
	Nombre				varchar(50)	NULL,
	Hist				bit 		NULL	DEFAULT 0,
	HistMin				varchar(20) 	NULL,
	HistMinUnidad			varchar(20) 	NULL,
	HistMax				varchar(20) 	NULL,
	HistMaxUnidad			varchar(20) 	NULL,
	ConsecutivoUnico		bit		NULL	DEFAULT 0,

	CONSTRAINT priModulo PRIMARY KEY  CLUSTERED (Modulo)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgModuloBC') and sysstat & 0xf = 8) drop trigger dbo.tgModuloBC
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'Modulo', 'Hist', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Modulo', 'HistMin', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Modulo', 'HistMinUnidad', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Modulo', 'HistMax', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Modulo', 'HistMaxUnidad', 'varchar(20) NULL'
GO
EXEC spDROP_COLUMN 'Modulo', 'SubFoliosOrigen'
EXEC spDROP_COLUMN 'Modulo', 'SubFoliosOrigenSeparador'
GO
EXEC spALTER_TABLE 'Modulo', 'ConsecutivoUnico', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spDROP_COLUMN 'Modulo', 'TRCLFueraLinea'
GO

CREATE TRIGGER tgModuloBC ON Modulo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ModuloN  	char(5),
    @ModuloA	char(5)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ModuloN = Modulo FROM Inserted
  SELECT @ModuloA = Modulo FROM Deleted
  IF @ModuloN = @ModuloA RETURN

  IF @ModuloN IS NULL 
    DELETE SubModulo WHERE Modulo = @ModuloA
  ELSE BEGIN
    UPDATE SubModulo SET Modulo = @ModuloN WHERE Modulo = @ModuloA
  END
END
GO

/****** OtrosModulos  ******/
if not exists(select * from SysTabla where SysTabla = 'OtrosModulos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OtrosModulos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OtrosModulos') and type = 'U') 
CREATE TABLE dbo.OtrosModulos (
	Modulo 		        char(5)		NOT NULL ,
	Nombre			varchar(50)	NULL,

	CONSTRAINT priOtrosModulos PRIMARY KEY  CLUSTERED (Modulo)
)
GO

/****** CondicionGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'CondicionGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CondicionGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CondicionGrupo') and type = 'U') 
CREATE TABLE dbo.CondicionGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priCondicionGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** TasaD ******/
if not exists(select * from SysTabla where SysTabla = 'TasaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TasaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TasaD') and type = 'U') 
CREATE TABLE dbo.TasaD (
	Tasa		varchar(50) 	NOT NULL,
	Fecha		datetime	NOT NULL,

	Porcentaje	float		NULL,

	CONSTRAINT priTasaD PRIMARY KEY CLUSTERED (Tasa, Fecha)
)
GO

/****** TasaGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'TasaGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TasaGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TasaGrupo') and type = 'U') 
CREATE TABLE dbo.TasaGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priTasaGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** Tasa ******/
if not exists(select * from SysTabla where SysTabla = 'Tasa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Tasa','Maestro')
go
if exists (select * from sysobjects where id = object_id('dbo.Tasa') and type = 'U') and (select version from version)<=2456
  drop table tasa
go
if not exists (select * from sysobjects where id = object_id('dbo.Tasa') and type = 'U') 
CREATE TABLE dbo.Tasa (
	Tasa			varchar(50) 	NOT NULL,
	Tipo			varchar(20)	NULL,
	Dias			int		NULL,      
        Fecha       datetime        NULL,
	Porcentaje		float		NULL,
        Estatus     char(15)        NULL,
	Grupo			varchar(50)	NULL,
	CalcularIVA		bit NULL DEFAULT 0, --MEJORA10041

	CONSTRAINT priTasa PRIMARY KEY CLUSTERED (Tasa)
)
GO

EXEC spAlter_Table 'Tasa', 'CalcularIVA', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA10041
GO

if exists (select * from sysobjects where id = object_id('dbo.tgTasaABC') and sysstat & 0xf = 8) drop trigger dbo.tgTasaABC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTasaBC') and sysstat & 0xf = 8) drop trigger dbo.tgTasaBC
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'Tasa', 'Fecha', 'datetime NULL'
EXEC spALTER_TABLE 'Tasa', 'Porcentaje', 'float	NULL'
EXEC spALTER_TABLE 'Tasa', 'Estatus', 'char(15)	NULL DEFAULT "ALTA" WITH VALUES'
EXEC spALTER_TABLE 'Tasa', 'Grupo', 'varchar(50) NULL'
GO
CREATE TRIGGER tgTasaABC ON Tasa
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @TasaN  	varchar(50),
    @TasaA	varchar(50),
    @Porcentaje float,
    @Fecha      datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @TasaN = Tasa, @Porcentaje = Porcentaje, @Fecha = Fecha FROM Inserted
  SELECT @TasaA = Tasa FROM Deleted

  IF @TasaN IS NULL 
    DELETE TasaD WHERE Tasa = @TasaA
  ELSE BEGIN
    IF @TasaA <> @TasaN UPDATE TasaD SET Tasa = @TasaN WHERE Tasa = @TasaA
    UPDATE TasaD SET Porcentaje = @Porcentaje WHERE Tasa = @TasaN AND Fecha = @Fecha
    IF @@ROWCOUNT = 0 
      INSERT TasaD (Tasa, Fecha, Porcentaje) VALUES (@TasaN, @Fecha, @Porcentaje)
  END
END
GO

/****** Condiciones de Pago ******/
if not exists(select * from SysTabla where SysTabla = 'Condicion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Condicion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Condicion') and type = 'U') 
CREATE TABLE dbo.Condicion (
	Condicion 		varchar(50)	NOT NULL,

	DiasVencimiento 	int 	  	NULL,			-- "Neto" Anterior
	TipoCondicion		varchar(20)	NULL,
	TipoDias		char(10)	NULL 	 DEFAULT 'Habiles', -- Naturales/Habiles
        DiasHabiles		char(10)	NULL 	 DEFAULT 'Lun-Vie',	-- Todos / Lun-Vie / Lun-Sab
	DiasProntoPago		int       	NULL,			-- Dias para utilizar el pronto pago
	DescuentoProntoPago	float	  	NULL,
	FechaProntoPago 	varchar(20)   	NULL	 DEFAULT 'Emision',	
	TipoDiasProntoPago	char(10)	NULL     DEFAULT 'Habiles', -- Naturales/Habiles
        DiasHabilesProntoPago	char(10)	NULL 	 DEFAULT 'Lun-Vie',	-- Todos / Lun-Vie / Lun-Sab
	ProntoPago		bit	  	NOT NULL DEFAULT 0,
	TipoInteres		varchar(10)  	NULL,    		-- Dia/Mes/Ano
	Interes			float	  	NULL,
	PorMeses    		bit 	  	NOT NULL DEFAULT 0,	-- por Meses
	Meses			int		NULL,
	PorSemanas		bit 	  	NULL    DEFAULT 0,	-- por Semanas
	Semanas			int		NULL,
	Orden			int		NULL,
	RecorrerVencimiento	bit		NULL	DEFAULT 0,
	RecorrerDiaSemana	varchar(20)	NULL,

	InteresesDevengados	bit		NULL	DEFAULT 0,
	Tasa			varchar(50)	NULL,

	DA			bit		NULL 	DEFAULT 0,
	DANumeroDocumentos	int		NULL,
        DATipoInteres		varchar(20)	NULL	DEFAULT 'Global', -- Global/Saldos Insolutos
	DAInteres		float		NULL,
	DAInteresImpuesto	float		NULL,
	DAInteresConcepto	varchar(50)	NULL,
	DAPeriodo		char(15)	NULL,
	DAImpPrimerDoc		bit		NULL 	DEFAULT 0,
	DADiaEspecifico		int		NULL,

	ControlAnticipos	varchar(20)	NULL	DEFAULT 'No',
	Anticipado		bit		NULL	DEFAULT 0,
	AnticipadoNumero	int		NULL,
	AnticipadoPeriodo	char(15)	NULL,

	Corte			bit		NULL	DEFAULT 0,
        CorteDia		int		NULL,

	AutoViajes		int		NULL,
	AutoCobroDef		money		NULL,
	AutoCobroPorcentajeDef	float		NULL,

	Grupo			varchar(50)	NULL,

	TipoVenta		varchar(50)	NULL,
	Termino			int		NULL,
	PagoMensual		money		NULL,
	TipoPago		varchar(50)	NULL,
	NivelAcceso		varchar(50)  	NULL,
	InteresMoratorioBaseTabla bit		NULL	DEFAULT 0,

	AutoFin			bit		NULL	DEFAULT 0,  
	AutoFinPedidoTipo	char(1)		NULL,  
	AutoFinPedidoComision	float		NULL,
	AutoFinFacturaTipo	char(1)		NULL,  
	AutoFinFacturaComision	float		NULL,
	Neteo			bit 		NULL 	DEFAULT 0,
        FacturaCobroIntegradoParcial bit        NULL 	DEFAULT 0,

	CFD_formaDePago		varchar(100)	NULL,
	CFD_metodoDePago	varchar(100)	NULL,

	CONSTRAINT priCondicion PRIMARY KEY CLUSTERED (Condicion)
)
GO
EXEC spALTER_TABLE 'Condicion', 'RecorrerVencimiento', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'RecorrerDiaSemana', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Condicion', 'Anticipado', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'AnticipadoNumero', 'int NULL'
EXEC spALTER_TABLE 'Condicion', 'AnticipadoPeriodo', 'char(15) NULL'
EXEC spALTER_TABLE 'Condicion', 'ControlAnticipos', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'Corte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'CorteDia', 'int NULL'
EXEC spALTER_TABLE 'Condicion', 'AutoViajes', 'int NULL'
EXEC spALTER_TABLE 'Condicion', 'AutoCobroDef', 'money NULL'
EXEC spALTER_TABLE 'Condicion', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Condicion', 'Termino', 'int NULL'
EXEC spALTER_TABLE 'Condicion', 'PagoMensual', 'money NULL'
EXEC spALTER_TABLE 'Condicion', 'TipoPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Condicion', 'TipoVenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Condicion', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Condicion', 'FechaProntoPago', 'varchar(20) NULL DEFAULT "Emision" WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'AutoCobroPorcentajeDef', 'float NULL'
EXEC spALTER_TABLE 'Condicion', 'TipoCondicion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Condicion', 'InteresMoratorioBaseTabla', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'AutoFin', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'AutoFinPedidoTipo', 'char(1) NULL'
EXEC spALTER_TABLE 'Condicion', 'AutoFinPedidoComision', 'float NULL'
EXEC spALTER_TABLE 'Condicion', 'AutoFinFacturaTipo', 'char(1) NULL'
EXEC spALTER_TABLE 'Condicion', 'AutoFinFacturaComision', 'float NULL'
EXEC spALTER_TABLE 'Condicion', 'Neteo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'InteresesDevengados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'Tasa', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Condicion', 'DATipoInteres', 'varchar(20) NULL DEFAULT "Global" WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'FacturaCobroIntegradoParcial','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'PorSemanas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Condicion', 'Semanas', 'int	NULL'
EXEC spALTER_TABLE 'Condicion', 'DADiaEspecifico', 'int	NULL'
EXEC spALTER_TABLE 'Condicion', 'CFD_formaDePago', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Condicion', 'CFD_metodoDePago', 'varchar(100) NULL'
GO

IF (select version from version)<=1239
  UPDATE Condicion SET ControlAnticipos = CASE WHEN AnticipadoNumero > 1 THEN 'Plazos' ELSE 'Si' END WHERE Anticipado = 1
GO
IF (select version from version)<=1248
  UPDATE Condicion SET ControlAnticipos = 'Abierto' WHERE ControlAnticipos = 'Si'
GO
IF (select version from version)<=2350
  UPDATE Condicion SET TipoCondicion = CASE WHEN NULLIF(DiasVencimiento, 0) IS NULL THEN 'Contado' ELSE 'Credito' END WHERE TipoCondicion IS NULL
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCondicionBC') and sysstat & 0xf = 8) drop trigger dbo.tgCondicionBC
GO

/****** FormaPagoGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'FormaPagoGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoGrupo') and type = 'U') 
CREATE TABLE dbo.FormaPagoGrupo (
	Grupo		varchar(50) 	NOT NULL,

	CONSTRAINT priFormaPagoGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** Formas de Pago ******/
if not exists(select * from SysTabla where SysTabla = 'FormaPago')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPago','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPago') and type = 'U') 
CREATE TABLE dbo.FormaPago (
	FormaPago 		varchar(50) 	NOT NULL,

	MovIngresos		char(20)	NULL,
	MovEgresos		char(20)	NULL,

	Comision		float   	NULL,
	Comision2		float   	NULL,
	Impuestos		float		NULL,
	Moneda			char(10)	NULL,
	RequiereReferencia	bit		NULL  DEFAULT 0,
	Orden			int		NULL,
	Restringida		bit		NULL  DEFAULT 0,
	PermiteCambio		bit		NULL  DEFAULT 1,
	PV			bit		NULL  DEFAULT 1,
	TarjetaBandaMagnetica	bit		NULL  DEFAULT 0,	
	Cuenta			varchar(20)	NULL,
	Grupo			varchar(50) 	NULL,
	DefCtaDinero		varchar(10)	NULL,
	Importacion		bit		NULL  DEFAULT 0,
	LDI     		bit		NULL  DEFAULT 0,--REQ13386
	LDIServicio             varchar(20)     NULL,--REQ13386
	POSForma                varchar(50)     NULL,--REQ13386
	Recoleccion     	bit		NULL  DEFAULT 0,--REQ 13393 POS	
	POSDenominacion  	bit		NULL  DEFAULT 0,--REQ 13393 POS		
	AbreCajon       	bit		NULL  DEFAULT 0,--REQ 13393 POS		
	
	CONSTRAINT priFormaPago PRIMARY KEY CLUSTERED (FormaPago)
)
GO


if exists (select * from sysobjects where id = object_id('dbo.tgFormaPagoBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaPagoBC
GO
EXEC spALTER_TABLE 'FormaPago', 'Moneda', 'char(10) NULL'
EXEC spALTER_TABLE 'FormaPago', 'RequiereReferencia','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'FormaPago', 'Impuestos', 'float NULL'
EXEC spALTER_TABLE 'FormaPago', 'Restringida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'PermiteCambio', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'PV', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TarjetaBandaMagnetica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'Cuenta', 'varchar(20) NULL'
GO
if (select version from version)<=1491
  update FormaPago SET PermiteCambio = 1 WHERE FormaPago = 'Efectivo'
GO
EXEC spALTER_TABLE 'FormaPago', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'FormaPago', 'DefCtaDinero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'FormaPago', 'Comision2', 'float NULL'
EXEC spALTER_TABLE 'FormaPago', 'Importacion', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK 'FormaPago','Cuenta','Cta','Cuenta'
EXEC spFK 'FormaPago','DefCtaDinero','CtaDinero','CtaDinero'
GO

-- 9150
EXEC spALTER_TABLE 'FormaPago', 'CobroIntegrado', 'bit NULL DEFAULT 1 WITH VALUES'
GO

--REQ13386
EXEC spALTER_TABLE 'FormaPago', 'LDI', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'LDIServicio','  varchar(20) NULL'
EXEC spALTER_TABLE 'FormaPago', 'POSForma','  varchar(50) NULL'
GO

-- REQ13163
EXEC spALTER_TABLE 'FormaPago', 'TCActivarInterfaz', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCTipoPlan', 'varchar(20) NOT NULL DEFAULT ''Regular'' WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCMontoMinimo', 'float NOT NULL DEFAULT 0.0 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCNoMeses', 'int NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCPlanIDBanco', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCInstitucionEmisor', 'varchar(20) NOT NULL DEFAULT '''' WITH VALUES'
EXEC spALTER_TABLE 'FormaPago', 'TCEstatus', 'varchar(10) NOT NULL DEFAULT ''ALTA'' WITH VALUES'
GO


--REQ 13393 POS  
EXEC spAlter_Table 'FormaPago', 'Recoleccion', 'bit NULL DEFAULT 0 WITH VALUES' 
EXEC spAlter_Table 'FormaPago', 'POSDenominacion', 'bit NULL DEFAULT 0 WITH VALUES' 
EXEC spALTER_TABLE 'FormaPago', 'AbreCajon', 'bit NULL DEFAULT 0 WITH VALUES'

Go
EXEC spALTER_COLUMN 'FormaPago', 'TCActivarInterfaz', 'bit NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCTipoPlan', 'varchar(20) NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCMontoMinimo', 'float NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCNoMeses', 'int NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCPlanIDBanco', 'varchar(20) NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCInstitucionEmisor', 'varchar(20) NULL' -- BUG14000
EXEC spALTER_COLUMN 'FormaPago', 'TCEstatus', 'varchar(10) NULL' -- BUG14000
GO

-- REQ13163
EXEC spALTER_TABLE 'FormaPago', 'TCDiferirMeses', 'int NULL'
EXEC spDROP_COLUMN 'FormaPago', 'TCMontoMinimo'
EXEC spDROP_COLUMN 'FormaPago', 'TCPlanIDBanco'
EXEC spDROP_COLUMN 'FormaPago', 'TCInstitucionEmisor'
EXEC spDROP_COLUMN 'FormaPago', 'TCEstatus'
EXEC spALTER_Table 'FormaPago', 'MetodoPagoSAT', 'int NULL'
GO

--Integracion DEVOLUCION POS con Articulos tipo Serie
EXEC spALTER_TABLE 'FormaPago', 'POSMoneda', 'varchar(10) NULL'	
GO

EXEC spALTER_TABLE 'FormaPago', 'Comision3', 'float NULL'	
EXEC spALTER_TABLE 'FormaPago', 'POSValidaPromocion', 'bit null default 0 with values'
GO

/****** FormaPagoD  ******/
if exists (select * from sysobjects where id = object_id('dbo.FormaPagoD') and type = 'U') and (select version from version)<=2134
  DROP TABLE FormaPagoD
GO
if not exists(select * from SysTabla where SysTabla = 'FormaPagoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoD') and type = 'U') 
CREATE TABLE dbo.FormaPagoD (
        FormaPago		varchar(50)	NOT NULL,
	Denominacion		money		NOT NULL,
        Nombre  		varchar(50)	NULL,--REQ 13393 POS	
	

	CONSTRAINT priFormaPagoD PRIMARY KEY  CLUSTERED (FormaPago, Denominacion)
)
GO
--REQ 13393 POS  
EXEC spALTER_TABLE 'FormaPagoD', 'Nombre', 'varchar(50) NULL'
GO

/****** FormaPagoTipo  ******/
if not exists(select * from SysTabla where SysTabla = 'FormaPagoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoTipo') and type = 'U') 
CREATE TABLE dbo.FormaPagoTipo (
	Tipo			varchar(50)	NOT NULL,

	SobrePrecio		float		NULL,

	CONSTRAINT priFormaPagoTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO
EXEC spALTER_TABLE 'FormaPagoTipo', 'SobrePrecio', 'float NULL'
GO

/****** FormaPagoTipoD  ******/
if not exists(select * from SysTabla where SysTabla = 'FormaPagoTipoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoTipoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoTipoD') and type = 'U') 
CREATE TABLE dbo.FormaPagoTipoD (
	Tipo			varchar(50)	NOT NULL,
        FormaPago		varchar(50)	NOT NULL,

	CONSTRAINT priFormaPagoTipoD PRIMARY KEY  CLUSTERED (Tipo, FormaPago)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaPagoTipoBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaPagoTipoBC
GO
CREATE TRIGGER tgFormaPagoTipoBC ON FormaPagoTipo
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @TipoN 	varchar(50),
    @TipoA		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @TipoN = Tipo FROM Inserted
  SELECT @TipoA = Tipo FROM Deleted

  IF @TipoN = @TipoA RETURN
  IF @TipoN IS NULL
  BEGIN
    DELETE FormaPagoTipoD WHERE Tipo = @TipoA
  END ELSE
  BEGIN
    UPDATE FormaPagoTipoD SET Tipo = @TipoN WHERE Tipo = @TipoA
  END
END
GO

/****** FormaPagoDesc  ******/
if exists (select * from sysobjects where id = object_id('dbo.FormaPagoDesc') and type = 'U') and (select version from version)<=2134
  DROP TABLE FormaPagoDesc
GO
if not exists(select * from SysTabla where SysTabla = 'FormaPagoDesc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoDesc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoDesc') and type = 'U') 
CREATE TABLE dbo.FormaPagoDesc (
        FormaPago		varchar(50)	NOT NULL,
	ListaPreciosEsp		varchar(20)	NOT NULL,

	Descuento		float		NULL,

	CONSTRAINT priFormaPagoDesc PRIMARY KEY  CLUSTERED (FormaPago, ListaPreciosEsp)
)
GO

-- 9150
/****** FormaPagoMovEsp ******/
if exists (select * from sysobjects where id = object_id('dbo.FormaPagoMovEsp') and type = 'U') and (select version from version)<=2134
  DROP TABLE FormaPagoMovEsp
GO
if not exists(select * from SysTabla where SysTabla = 'FormaPagoMovEsp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoMovEsp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoMovEsp') and type = 'U') 
CREATE TABLE dbo.FormaPagoMovEsp (
  FormaPago		varchar(50)	NOT NULL,
  Modulo		varchar(5)	NOT NULL,
  Mov			varchar(20)	NOT NULL,
  ConDesglose	varchar(20)	NOT NULL DEFAULT 'Si',

  CONSTRAINT priFormaPagoMovEsp PRIMARY KEY CLUSTERED(FormaPago, Modulo, Mov)
  )
GO

/****** FormaPagoAcceso ******/
if exists (select * from sysobjects where id = object_id('dbo.FormaPagoAcceso') and type = 'U') and (select version from version)<=2134
  DROP TABLE FormaPagoAcceso
GO
if not exists(select * from SysTabla where SysTabla = 'FormaPagoAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaPagoAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaPagoAcceso') and type = 'U') 
CREATE TABLE dbo.FormaPagoAcceso (
  FormaPago		varchar(50)	NOT NULL,
  Nivel			varchar(50)	NOT NULL,

  CONSTRAINT priFormaPagoAcceso PRIMARY KEY CLUSTERED(FormaPago, Nivel)
  )
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaPagoBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaPagoBC
GO
CREATE TRIGGER tgFormaPagoBC ON FormaPago
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @FormaPagoN 	varchar(50),
    @FormaPagoA		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @FormaPagoN = FormaPago FROM Inserted
  SELECT @FormaPagoA = FormaPago FROM Deleted

  IF @FormaPagoN = @FormaPagoA RETURN
  IF @FormaPagoN IS NULL
  BEGIN
    DELETE FormaPagoDesc  WHERE FormaPago = @FormaPagoA
    DELETE FormaPagoD     WHERE FormaPago = @FormaPagoA
    DELETE FormaPagoTipoD WHERE FormaPago = @FormaPagoA
  END ELSE
  BEGIN
    UPDATE FormaPagoDesc  SET FormaPago = @FormaPagoN WHERE FormaPago = @FormaPagoA
    UPDATE FormaPagoD     SET FormaPago = @FormaPagoN WHERE FormaPago = @FormaPagoA
    UPDATE FormaPagoTipoD SET FormaPago = @FormaPagoN WHERE FormaPago = @FormaPagoA
  END
END
GO

/****** FormaEntrega ******/
if not exists(select * from SysTabla where SysTabla = 'FormaEntrega')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaEntrega','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaEntrega') and type = 'U') 
CREATE TABLE dbo.FormaEntrega (
	FormaEntrega	varchar(50) 	NOT NULL,

	CONSTRAINT priFormaEntrega PRIMARY KEY CLUSTERED (FormaEntrega)
)
GO

/****** Pais ******/
if not exists(select * from SysTabla where SysTabla = 'Pais')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Pais','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Pais') and type = 'U') 
CREATE TABLE dbo.Pais (
	Pais			varchar(50) 	NOT NULL,

	Clave			varchar(10)	NULL,

	CONSTRAINT priPais PRIMARY KEY  CLUSTERED (Pais)
)
GO

/****** PaisEstado ******/
if not exists(select * from SysTabla where SysTabla = 'PaisEstado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PaisEstado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PaisEstado') and type = 'U') 
CREATE TABLE dbo.PaisEstado (
	Pais			varchar(50)	NOT NULL,
	Estado 			varchar(50) 	NOT NULL,

	Clave			varchar(10)	NULL,
	ClaveCURP		char(2)		NULL,
	ImpuestoNomina		float		NULL,

	CONSTRAINT priPaisEstado PRIMARY KEY  CLUSTERED (Pais, Estado)
)
GO
EXEC spALTER_TABLE 'PaisEstado', 'Clave', 'varchar(10) NULL'
EXEC spALTER_TABLE 'PaisEstado', 'ClaveCURP', 'char(2) NULL'
GO
if (select version from version) <= 2796 and not exists(select * from syscampo where tabla = 'PaisEstado' and campo = 'Pais')
BEGIN
  EXEC("spEliminarPK 'PaisEstado'")
  EXEC("ALTER TABLE PaisEstado ADD Pais varchar(50) NOT NULL DEFAULT 'Mexico' WITH VALUES")
  EXEC("ALTER TABLE PaisEstado ADD CONSTRAINT priPaisEstado PRIMARY KEY  CLUSTERED (Pais, Estado)")
END
GO


/****** LocalidadCNBV ******/
if not exists(select * from SysTabla where SysTabla = 'LocalidadCNBV')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LocalidadCNBV','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LocalidadCNBV') and type = 'U') 
CREATE TABLE dbo.LocalidadCNBV (
	LocalidadCNBV		varchar(10)	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priLocalidadCNBV PRIMARY KEY  CLUSTERED (LocalidadCNBV)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LocalidadCNBV' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.LocalidadCNBV (Nombre)
GO

/****** ActividadEconomicaCNBV ******/
if not exists(select * from SysTabla where SysTabla = 'ActividadEconomicaCNBV')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActividadEconomicaCNBV','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActividadEconomicaCNBV') and type = 'U') 
CREATE TABLE dbo.ActividadEconomicaCNBV (
	ActividadEconomicaCNBV	varchar(10)	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priActividadEconomicaCNBV PRIMARY KEY  CLUSTERED (ActividadEconomicaCNBV)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'ActividadEconomicaCNBV' AND sysindexes.name = 'Nombre' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Nombre ON dbo.ActividadEconomicaCNBV (Nombre)
GO

/****** Codigo Postal ******/
if (select version from version)<=1341 
  delete systabla where systabla = 'CodigoPostal'
if not exists(select * from SysTabla where SysTabla = 'CodigoPostal')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CodigoPostal','Maestro')
if (select version from version) <= 1195 and exists (select * from sysobjects where id = object_id('dbo.CodigoPostal') and type = 'U') 
	DROP TABLE CodigoPostal
if not exists (select * from sysobjects where id = object_id('dbo.CodigoPostal') and type = 'U') 
CREATE TABLE dbo.CodigoPostal (
	ID			int 		IDENTITY(1,1) NOT NULL,
	CodigoPostal 		varchar(15) 	NOT NULL,
	Colonia			varchar(60)	NOT NULL,
	Delegacion		varchar(50)	NOT NULL,
	Estado			varchar(50)	NULL,
	Ruta			varchar(50) 	NULL,
	LocalidadCNBV		varchar(10)	NULL,

	CONSTRAINT priCodigoPostal PRIMARY KEY CLUSTERED (ID)
)
GO
if not exists(select * from syscampo where tabla = 'CodigoPostal' AND Campo = 'ID')
BEGIN
  EXEC("spALTER_TABLE 'CodigoPostal', 'ID', 'int IDENTITY(1,1) NOT NULL'")
  EXEC("spEliminarPK 'CodigoPostal'")
  EXEC("ALTER TABLE CodigoPostal ADD CONSTRAINT priCodigoPostal PRIMARY KEY CLUSTERED (ID)")
END
GO
EXEC spALTER_TABLE 'CodigoPostal', 'Estado', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CodigoPostal', 'LocalidadCNBV', 'varchar(10) NULL'
GO

EXEC spFK 'CodigoPostal','LocalidadCNBV','LocalidadCNBV','LocalidadCNBV'
GO

--Integración CRM
EXEC spAlter_Table 'CodigoPostal', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'CodigoPostal', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_CodigoPostal', 'TR') IS NOT NULL DROP TRIGGER tr_CodigoPostal
GO									
/*CREATE TRIGGER tr_CodigoPostal ON CodigoPostal 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update CodigoPostal  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.ID= CodigoPostal.ID
	END
END
GO*/

/****** Zonas Impuestos ******/
if not exists(select * from SysTabla where SysTabla = 'ZonaImp')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ZonaImp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ZonaImp') and type = 'U') 
CREATE TABLE dbo.ZonaImp (
	Zona                    varchar(30)  	NOT NULL,
        Impuesto 		float	  	NOT NULL,

	Porcentaje 		float 	  	NULL,

	CONSTRAINT priZonaImp PRIMARY KEY CLUSTERED (Zona,Impuesto)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgZonaImpBC') and sysstat & 0xf = 8) drop trigger dbo.tgZonaImpBC
GO

/****** PresentacionGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'PresentacionGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PresentacionGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PresentacionGrupo') and type = 'U') 
CREATE TABLE dbo.PresentacionGrupo (
	Grupo			varchar(50)	NOT NULL,

	CONSTRAINT priPresentacionGrupo PRIMARY KEY CLUSTERED (Grupo)
)
GO

/****** Presentacion ******/
if not exists(select * from SysTabla where SysTabla = 'Presentacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Presentacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Presentacion') and type = 'U') 
CREATE TABLE dbo.Presentacion (
	Presentacion		varchar(50)   	NOT NULL,

	Grupo			varchar(50)	NULL,

	CONSTRAINT priPresentacion PRIMARY KEY CLUSTERED (Presentacion)
)
GO
EXEC spALTER_TABLE 'Presentacion', 'Grupo', 'varchar(50) NULL'
GO
/****** PresentacionPrecio ******/
if not exists(select * from SysTabla where SysTabla = 'PresentacionPrecio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('PresentacionPrecio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.PresentacionPrecio') and type = 'U') 
BEGIN
  CREATE TABLE dbo.PresentacionPrecio (
	ID			int		NOT NULL	IDENTITY(1,1),

	Presentacion		varchar(50)   	NOT NULL,
	Region			varchar(50)	NULL,
	Sucursal		int		NULL,
	CantidadD		float		NULL,
	CantidadA		float		NULL,
	PrecioNormal		float		NULL,
	PrecioOferta		float		NULL,
	VigenciaD		datetime	NULL,
	VigenciaA		datetime	NULL,

	CONSTRAINT priPresentacionPrecio PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'PresentacionPrecio'
END
GO

EXEC spFK 'PresentacionPrecio','Sucursal','Sucursal','Sucursal'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'PresentacionPrecio' AND sysindexes.name = 'Presentacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Presentacion ON dbo.PresentacionPrecio (Presentacion)
GO

/****** Fabricante ******/
if not exists(select * from SysTabla where SysTabla = 'Fabricante')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Fabricante','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Fabricante') and type = 'U') 
CREATE TABLE dbo.Fabricante (
	Fabricante 		varchar(50)   	NOT NULL,

	Telefonos		varchar(100)   	NULL,
	DirInternet		varchar(50)   	NULL,
	Notas	   		text 	      	NULL,

	CONSTRAINT priFabricante PRIMARY KEY CLUSTERED (Fabricante)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgFabricanteBC') and sysstat & 0xf = 8) drop trigger dbo.tgFabricanteBC
GO
--Integracion DEVOLUCION POS con Articulos tipo Serie
EXEC spALTER_TABLE 'Fabricante', 'POSAgenteDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--Integración CRM
EXEC spAlter_Table 'fabricante', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'fabricante', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_fabricante', 'TR') IS NOT NULL DROP TRIGGER tr_fabricante
GO									
/*CREATE TRIGGER tr_fabricante ON fabricante 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update fabricante  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.fabricante= fabricante.Fabricante
	END
END
GO*/

/****** Cobradores ******/
if not exists(select * from SysTabla where SysTabla = 'Cobrador')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Cobrador','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Cobrador') and type = 'U') 
CREATE TABLE dbo.Cobrador (
	Cobrador 		varchar(50)   	NOT NULL,

	Telefonos		varchar(100)  	NULL,
	Comision		float	   	NULL,
	Notas			text 	   	NULL,

	CONSTRAINT priCobrador PRIMARY KEY  CLUSTERED (Cobrador)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCobradorBC') and sysstat & 0xf = 8) drop trigger dbo.tgCobradorBC
GO

/****** FormaEnvio ******/
if not exists(select * from SysTabla where SysTabla = 'FormaEnvio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('FormaEnvio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.FormaEnvio') and type = 'U') 
CREATE TABLE dbo.FormaEnvio (
	FormaEnvio 		varchar(50)  	NOT NULL,

	Direccion 		varchar(100)	NULL,
	Colonia 		varchar(50)  	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	Poblacion 		varchar(50)  	NULL,
	Estado 			varchar(50)  	NULL,
	Pais			varchar(50)	NULL,
	Encargado 		varchar(50)  	NULL,
	Telefonos 		varchar(100)  	NULL,

	Volumen			float		NULL,
	Peso			float		NULL,

	UltimoCambio		datetime      	NULL,

	Embarcar		bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,

	CONSTRAINT priFormaEnvio PRIMARY KEY CLUSTERED (FormaEnvio)
)
GO

EXEC spALTER_TABLE 'FormaEnvio', 'EsPropia', 'Bit Not NULL default 0'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgFormaEnvioBC') and sysstat & 0xf = 8) drop trigger dbo.tgFormaEnvioBC
GO

/****** Beneficiarios Bancarios  ******/
if not exists(select * from SysTabla where SysTabla = 'BeneficiarioNombre')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('BeneficiarioNombre','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.BeneficiarioNombre') and type = 'U') 
CREATE TABLE dbo.BeneficiarioNombre (
	Beneficiario 		varchar(100) 	NOT NULL,

	ImporteOmision		money	  	NULL,
	ConceptoOmision		varchar(50)  	NULL,

	CONSTRAINT priBeneficiarioNombre PRIMARY KEY CLUSTERED (Beneficiario)
)
GO
IF (select version from version) <= 1098
BEGIN
  EXEC spEliminarPK 'BeneficiarioNombre'
  ALTER TABLE BeneficiarioNombre ADD CONSTRAINT priBeneficiarioNombre PRIMARY KEY CLUSTERED (Beneficiario)
END
GO

/****** MonHist ******/
if not exists(select * from SysTabla where SysTabla = 'MonHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MonHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.MonHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MonHist (
        ID                      int        	NOT NULL IDENTITY(1,1),

	Moneda	 		char(10)  	NOT NULL,
	Fecha                   datetime   	NULL,
	TipoCambio		float     	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,
	FechaSinHora			datetime NULL, --MEJORA10041

	CONSTRAINT priMonHist PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MonHist'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'MonHist', '(ID)'
GO

EXEC spAlter_Table 'MonHist', 'FechaSinHora', 'datetime NULL' --MEJORA10041
GO

EXEC spADD_INDEX 'MonHist', 'secMonHist', 'ID, FechaSinHora, Moneda, Sucursal' --MEJORA10041
GO

EXEC spFK 'MonHist','Moneda','Mon','Moneda'
GO

/****** Monedas ******/
if not exists(select * from SysTabla where SysTabla = 'Mon')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Mon','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Mon') and type = 'U') 
CREATE TABLE dbo.Mon (
	Moneda	 		char(10)  	NOT NULL,
	Orden			int		NOT NULL,
	Nombre			varchar(50)	NULL,
	TipoCambio		float     	NULL,
	TipoCambioDolar		float     	NULL,
	TipoCambioVenta		float     	NULL,
	TipoCambioCompra	float     	NULL,
	Tolerancia		float     	NULL,
	Interbancario 		float 		NULL,
	UltimoCambio		datetime	NULL,
	Icono			int	  	NULL,
	CxcAjusteRedondeo	money		NULL,
	CxpAjusteRedondeo	money		NULL,
	CxcEliminarSaldosMenores money		NULL,
	CxpEliminarSaldosMenores money		NULL,
	TablaISAN		varchar(50)	NULL,
	Clave			char(3)		NULL,
	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	InforClave		varchar(4)	NULL,
	CodigoInt		varchar(5)  NULL,

	CONSTRAINT priMon PRIMARY KEY CLUSTERED (Moneda)
)
GO

EXEC spRENAME_COLUMN 'Mon', 'CxcAjusteEfectivo', 'CxcAjusteRedondeo'
EXEC spRENAME_COLUMN 'Mon', 'CxpAjusteEfectivo', 'CxpAjusteRedondeo'
EXEC spALTER_TABLE 'Mon', 'CxcEliminarSaldosMenores', 'money NULL'
EXEC spALTER_TABLE 'Mon', 'CxpEliminarSaldosMenores', 'money NULL'
EXEC spALTER_TABLE 'Mon', 'TablaISAN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Mon', 'TipoCambioVenta', 'float NULL'
EXEC spALTER_TABLE 'Mon', 'TipoCambioCompra', 'float NULL'
EXEC spALTER_TABLE 'Mon', 'Clave', 'char(3) NULL'
EXEC spALTER_TABLE 'Mon', 'InforClave', 'varchar(4) NULL'
EXEC spALTER_TABLE 'Mon', 'CodigoInt', 'varchar(5) NULL'
 --REQ12534 Factory  
Exec spAlter_Table 'Mon', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--Integración CRM
EXEC spAlter_Table 'Mon', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'Mon', 'CRMISOCode', 'Varchar(3) NULL'
GO

IF OBJECT_ID ('tr_Mon', 'TR') IS NOT NULL DROP TRIGGER tr_Mon 
GO									
/*CREATE TRIGGER tr_Mon ON Mon 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(ultimocambio) BEGIN
		update Mon  set ultimocambio=GETDATE() 
			FROM INSERTED i
		WHERE i.Moneda= Mon.Moneda
	END
END
GO*/

-- Aqui va el Matenimiento a la tabla

/********************* tgMonABC **********************/
IF OBJECT_ID(N'dbo.tgMonABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgMonABC
GO
CREATE TRIGGER tgMonABC ON Mon
--//WITH ENCRYPTION
FOR UPDATE, INSERT, DELETE
AS BEGIN
  DECLARE
    @Sucursal		int,
    @Hoy		datetime,
    @MonedaN 		varchar(50),
    @MonedaA 		varchar(50),
    @TipoCambio		float,
    @Mensaje		varchar(255)

	DELETE FROM MonMes WHERE Moneda IN (SELECT Moneda FROM DELETED)
		
	INSERT MonMes (Moneda, Descripcion, DescripcionAbreviada, NumeroDecimales, EstatusIntelIMES)
	SELECT Moneda, Nombre, ISNULL(Clave,''), 2, 0 
	FROM INSERTED 

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Hoy = GETDATE() --MEJORA10041
  
  SELECT @MonedaN = Moneda, @TipoCambio = TipoCambio FROM Inserted
  SELECT @MonedaA = Moneda FROM Deleted
  SELECT @Sucursal = Sucursal FROM Version

  IF UPDATE(TipoCambio) 
    INSERT INTO MonHist (Sucursal, Moneda, Fecha, TipoCambio, FechaSinHora) VALUES (@Sucursal, @MonedaN, @Hoy, @TipoCambio, dbo.fnFechaSinHora(@Hoy)) --MEJORA10041
 
  IF @MonedaA IS NULL AND EXISTS(SELECT * FROM CambioAcum)
  BEGIN
    --SELECT @Hoy = GETDATE() --MEJORA10041
    EXEC spExtraerFecha @Hoy OUTPUT
    INSERT INTO CambioAcum (Sucursal, Empresa, Moneda, Fecha) SELECT DISTINCT @Sucursal, Empresa, @MonedaN, @Hoy FROM CambioAcum
  END  

END
GO

/****** MonActualizarTemp ******/
if not exists(select * from SysTabla where SysTabla = 'MonActualizarTemp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MonActualizarTemp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MonActualizarTemp') and type = 'U') 
CREATE TABLE dbo.MonActualizarTemp (
	Estacion			int		NOT NULL,
	Moneda				varchar(20)	NOT NULL,
	Codigo				varchar(5)	NULL,
	TipoCambio			float		NULL,
	Estatus				varchar(15)	NULL,
	Icono				int			NULL,

	CONSTRAINT priMonActualizarTemp PRIMARY KEY CLUSTERED (Estacion, Moneda)
)
GO


/****** MonHistTemp ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'MonHistTemp')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MonHistTemp', 'N/A')
IF NOT EXISTS (SELECT * FROM SysObjects WHERE id = object_id('dbo.MonHistTemp') AND type = 'U') 
  CREATE TABLE dbo.MonHistTemp (
        Estacion                int             NOT NULL,
	Moneda	 		varchar(10)  	NOT NULL,
	Fecha                   datetime   	NOT NULL,
	TipoCambio		float     	NULL,
	Sucursal		int		NOT NULL,

  CONSTRAINT priMonHistTemp PRIMARY KEY CLUSTERED (Estacion,Moneda,Fecha,Sucursal)  
	   )
GO

/****** MonActualizacionAuto ******/
if not exists(select * from SysTabla where SysTabla = 'MonActualizacionAuto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MonActualizacionAuto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MonActualizacionAuto') and type = 'U') 
CREATE TABLE dbo.MonActualizacionAuto (
	ActualizacionAuto	varchar(50)	NOT NULL,
	Url					varchar(max)	NULL,
	ExpInicial			varchar(max)	NULL,
	ExpFinal			varchar(max)	NULL,

	CONSTRAINT priMonActualizacionAuto PRIMARY KEY CLUSTERED (ActualizacionAuto)
)
GO

/****** Monedas Codigo Internacional ******/
if not exists(select * from SysTabla where SysTabla = 'MonCodigoInternacional')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MonCodigoInternacional','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MonCodigoInternacional') and type = 'U') 
CREATE TABLE dbo.MonCodigoInternacional (
	Codigo	 			varchar(5)  NOT NULL,
	Descripcion			varchar(50)	NOT NULL,
	ActualizacionAuto	varchar(50)	NOT NULL,

	CONSTRAINT priMonCodigoInternacional PRIMARY KEY CLUSTERED (Codigo)
)
GO

-- REQ13163
EXEC spALTER_TABLE 'MonCodigoInternacional', 'CodigoNumerico', 'int NULL'
EXEC spALTER_TABLE 'MonCodigoInternacional', 'Moneda', 'varchar(10) NULL'
GO

 --REQ12534 Factory  
if exists (select * from sysobjects where id = object_id('dbo.tgInforMonABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforMonABC
GO
--CREATE TRIGGER tgInforMonABC ON Mon
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Moneda						varchar (10),
--   @Estatus						varchar (10),
--   @Datos						varchar (max),
--   @Datos2						varchar (max),
--   @Resultado						varchar(max),
--   @Ok							int,
--   @OkRef						varchar(255),
--   @Id							int,
--   @Cinserted						int,
--   @Cdeleted						int,
--   @Empresa						varchar(20),
--   @ReferenciaIntelisisService			varchar(50)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted
  
--  IF @ProdInterfazINFOR = 1
--  BEGIN
--    IF @Cinserted <> 0 AND @Cdeleted = 0 
--    BEGIN
--      SET @Estatus = 'ALTA' 
--    END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--    BEGIN
--      SET @Estatus = 'CAMBIO'
--    END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--    BEGIN 
--      SET @Estatus = 'BAJA'
--    END
    
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--    BEGIN
--      DECLARE crActualizar CURSOR FOR
--      SELECT Moneda,ReferenciaIntelisisService
--        FROM Inserted
--    END
--    ELSE
--    IF @Estatus = 'BAJA'
--    BEGIN
--      DECLARE crActualizar CURSOR  FOR
--       SELECT Moneda,ReferenciaIntelisisService
--         FROM Deleted     
--    END          
--    IF @Estatus IS NOT NULL
--    BEGIN
--      OPEN crActualizar
--      FETCH NEXT FROM crActualizar INTO @Moneda ,@ReferenciaIntelisisService
--      WHILE @@FETCH_STATUS = 0 
--      BEGIN
--        EXEC spInforGenerarSolicitudMoneda @Moneda,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--        FETCH NEXT FROM crActualizar INTO @Moneda,@ReferenciaIntelisisService
--      END
--      CLOSE crActualizar
--      DEALLOCATE crActualizar   
--    END     

--  END
--END
--GO


/****** Descuentos en Cascada ******/
if not exists(select * from SysTabla where SysTabla = 'Descuento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Descuento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Descuento') and type = 'U') 
CREATE TABLE dbo.Descuento (
	Descuento 		varchar(30)  	NOT NULL,

	Porcentaje		float		NULL,

	Descuento1 		float 	  	NULL,
	Descuento2 		float 	  	NULL,
	Descuento3 		float 	  	NULL,
	Descuento4 		float 	  	NULL,
	Descuento5 		float     	NULL,
	Descuento6 		float     	NULL,
	Descuento7 		float     	NULL,
	Descuento8 		float     	NULL,
	Descuento9 		float     	NULL,
	Descuento10 		float     	NULL,
	Descripcion1 		varchar(50) 	NULL,
	Descripcion2 		varchar(50) 	NULL,
	Descripcion3 		varchar(50) 	NULL,
	Descripcion4 		varchar(50) 	NULL,
	Descripcion5 		varchar(50) 	NULL,
	Descripcion6 		varchar(50) 	NULL,
	Descripcion7 		varchar(50) 	NULL,
	Descripcion8 		varchar(50) 	NULL,
	Descripcion9 		varchar(50) 	NULL,
	Descripcion10 		varchar(50) 	NULL,

	FormaPagoDesc		bit		NULL	DEFAULT 0,
	Clave			varchar(20)	NULL,


	CONSTRAINT priDescuento PRIMARY KEY  CLUSTERED (Descuento)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgDescuentoAC') and sysstat & 0xf = 8) drop trigger dbo.tgDescuentoAC
GO
EXEC spALTER_TABLE 'Descuento', 'FormaPagoDesc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Descuento', 'Clave', 'varchar(20) NULL'
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgDescuentoAC ON Descuento
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Descuento  varchar(50),
    @Porcentaje float

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Porcentaje = 100 - ((100-ISNULL(Descuento1,0))/100 * (100-ISNULL(Descuento2,0))/100 * (100-ISNULL(Descuento3,0))/100 * (100-ISNULL(Descuento4,0))/100 * (100-ISNULL(Descuento5,0))/100 * (100-ISNULL(Descuento6,0))/100 * (100-ISNULL(Descuento7,0))/100 * (100-ISNULL(Descuento8,0))/100 * (100-ISNULL(Descuento9,0))/100 * (100-ISNULL(Descuento10,0))/100 ) * 100,
         @Descuento  = Descuento
    FROM Inserted

  --SELECT @Porcentaje = ROUND(@Porcentaje, 10)
  UPDATE Descuento SET Porcentaje = @Porcentaje WHERE Descuento = @Descuento
END
GO

/****** ProyectoD  ******/
if not exists(select * from SysTabla where SysTabla = 'ProyD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyD','Maestro')
if (select version from version) <= 1464 and exists (select * from sysobjects where id = object_id('dbo.ProyD') and type = 'U') 
DROP TABLE ProyD
GO
if not exists (select * from sysobjects where id = object_id('dbo.ProyD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ProyD (
	Proyecto 		varchar(50) 	NOT NULL,
	ID			int	     	NOT NULL	IDENTITY(1,1),

	Personal		char(10)	NULL,
	Cliente			char(10)	NULL,
	Proveedor		char(10)	NULL,
	Agente			char(10)	NULL,
	Nombre			varchar(100)	NULL,

	Estatus			char(15)	NULL,
	Situacion		varchar(50)	NULL,			
	FechaInicio		datetime	NULL,
    	FechaFin		datetime	NULL,

	CONSTRAINT priProyD PRIMARY KEY CLUSTERED (Proyecto, ID)
  )
  EXEC spSincroSemilla 'ProyD'
END
GO
EXEC spALTER_TABLE 'ProyD', 'Nombre', 'varchar(100) NULL'
EXEC spALTER_TABLE 'ProyD', 'Situacion', 'varchar(50) NULL'
GO

EXEC spFK 'ProyD','Proyecto','Proy','Proyecto'
GO

/****** Plantilla Tarea  ******/
if not exists(select * from SysTabla where SysTabla = 'ProyPlanTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyPlanTarea','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.ProyPlanTarea') and type = 'U') 
  CREATE TABLE dbo.ProyPlanTarea (

	Plantilla 		varchar(50) 	NOT NULL,
	Clave			varchar(50)		NOT NULL, -- sugerir GUID
	
	Rama			varchar(50)		NULL,
	Asunto			varchar(100)	NULL,
	Orden			int				NULL,
	TieneDetalle		bit				NULL	DEFAULT 0,
	Tiempo			float			NULL,
	TiempoUnidad		varchar(50)		NULL,
	
	CONSTRAINT priProyPlanTarea PRIMARY KEY CLUSTERED (Plantilla, Clave)
)
GO
IF EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'ProyPlanTarea' AND Campo = 'Multiple')
  EXEC sp_rename 'ProyPlanTarea.Multiple', 'TieneDetalle', 'COLUMN'
GO
EXEC spALTER_TABLE 'ProyPlanTarea', 'TieneDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ProyPlanTarea', 'Rama', 'varchar(50) NULL'
GO

/****** Plantilla Proyecto  ******/
if not exists(select * from SysTabla where SysTabla = 'ProyPlan')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyPlan','Maestro')
GO
if not exists (select * from sysobjects where id = object_id('dbo.ProyPlan') and type = 'U') 
  CREATE TABLE dbo.ProyPlan (

	Plantilla 		varchar(50) 	NOT NULL,
	
	CONSTRAINT priProyPlan PRIMARY KEY CLUSTERED (Plantilla)
)
GO

/****** Proyectos  ******/
if not exists(select * from SysTabla where SysTabla = 'Proy')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Proy','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Proy') and type = 'U') 
CREATE TABLE dbo.Proy (
	Proyecto 			varchar(50) 	NOT NULL,
    	Rama				varchar(50) 	NULL,

	Categoria 			varchar(50) 	NULL,
	Icono				int	  	NULL,
	Descripcion			varchar(100)	NULL,
	Estatus				char(15)	NULL,
	FechaInicio			datetime	NULL,
    	FechaFin			datetime	NULL,
	Comentarios			text		NULL,
	Situacion			varchar(50)	NULL,
	SituacionFecha			datetime	NULL,
	SituacionUsuario		varchar(10)	NULL,
	SituacionNota			varchar(100)	NULL,

	Direccion 			varchar(100) 	NULL,
	EntreCalles			varchar(100) 	NULL,
	Plano				varchar(15)     NULL,
	Observaciones			varchar(100)    NULL,
	Colonia 			varchar(100) 	NULL,
	Delegacion			varchar(100) 	NULL,
	Poblacion 			varchar(100) 	NULL,
	CodigoPostal 			varchar(15) 	NULL,
	Estado 				varchar(30) 	NULL,
	Pais 				varchar(30)     NULL,

	Descripcion1			varchar(50)	NULL,
	Descripcion2			varchar(50)	NULL,
	Descripcion3			varchar(50)	NULL,
	Descripcion4			varchar(50)	NULL,
	Descripcion5			varchar(50)	NULL,
	Descripcion6			varchar(50)	NULL,
	Descripcion7			varchar(50)	NULL,
	Descripcion8			varchar(50)	NULL,
	Descripcion9			varchar(50)	NULL,
	Descripcion10			varchar(50)	NULL,

	Espacio				char(10)	NULL,
	ComentariosInicio		text		NULL,
	ComentariosFin			text		NULL,

    	Presupuesto         		money       	NULL,
	Tipo				char(15)	NULL		DEFAULT 'Normal',

	FechaInicioReal			datetime	NULL,
    	FechaFinReal			datetime	NULL,

	Peso				float		NULL,
	Plantilla			varchar(50)	NULL,
	ProyectoID			int		NULL,
	FechaProyResultado		datetime	NULL,

	ClavePresupuestalMascara	varchar(50)	NULL, --MEJORA4722

	CONSTRAINT priProy PRIMARY KEY CLUSTERED (Proyecto)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProyBC') and sysstat & 0xf = 8) drop trigger dbo.tgProyBC
GO
EXEC spALTER_TABLE 'Proy', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Proy', 'Situacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Proy', 'SituacionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'Proy', 'Direccion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Proy', 'EntreCalles', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Proy', 'Plano', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Proy', 'Observaciones', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Proy', 'Colonia', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Proy', 'Delegacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Proy', 'CodigoPostal', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Proy', 'Poblacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Proy', 'Estado', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Proy', 'Pais', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion1', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion2', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion3', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion4', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion5', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion6', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion7', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion8', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion9', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Proy', 'Descripcion10', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Proy', 'Espacio', 'char(10)	NULL'
EXEC spALTER_TABLE 'Proy', 'ComentariosInicio', 'text NULL'
EXEC spALTER_TABLE 'Proy', 'ComentariosFin', 'text NULL'
EXEC spALTER_TABLE 'Proy', 'Rama', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Proy', 'Presupuesto','money NULL'
EXEC spALTER_TABLE 'Proy', 'Tipo', 'char(15) NULL DEFAULT "Normal" WITH VALUES'
EXEC spALTER_TABLE 'Proy', 'FechaInicioReal', 'datetime	NULL'
EXEC spALTER_TABLE 'Proy', 'FechaFinReal', 'datetime NULL'
EXEC spALTER_TABLE 'Proy', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Proy', 'Peso', 'float NULL'
EXEC spALTER_TABLE 'Proy', 'ProyectoID', 'int NULL'
EXEC spALTER_TABLE 'Proy', 'ContactoTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Proy', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'Agente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'Prospecto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'Riesgo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'ProyectoRama', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Proy', 'Personal', 'varchar(10) NULL'
GO
EXEC spALTER_TABLE 'Proy', 'ClavePresupuestalMascara', 'varchar(50) NULL' --MEJORA4722
GO

if exists (select * from sysobjects where id = object_id('dbo.tgProyBC') and sysstat & 0xf = 8) drop trigger dbo.tgProyBC
GO
if (select version from version)<=2642
BEGIN
  EXEC("ALTER TABLE Proy ALTER COLUMN Colonia varchar(100) NULL")
  EXEC("ALTER TABLE Proy ALTER COLUMN Delegacion varchar(100) NULL")
  EXEC("ALTER TABLE Proy ALTER COLUMN Poblacion varchar(100) NULL")
END
GO
EXEC spALTER_TABLE 'Proy', 'Plantilla', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Proy', 'Version', 'float NULL'
EXEC spALTER_TABLE 'Proy', 'FechaProyResultado', 'datetime NULL'
GO
EXEC spADD_INDEX 'Proy', 'ProyectoID', 'ProyectoID'
GO

EXEC spFK 'Proy','Cliente','Cte','Cliente'
EXEC spFK 'Proy','Proveedor','Prov','Proveedor'
EXEC spFK 'Proy','Agente','Agente','Agente'
EXEC spFK 'Proy','Prospecto','Prospecto','Prospecto'
EXEC spFK 'Proy','Personal','Personal','Personal'
EXEC spFK 'Proy','Riesgo','aroRiesgo','Riesgo'
GO

--Integración CRM
EXEC spAlter_Table 'proy', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'proy', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgProyBC ON Proy
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ProyectoN 	varchar(50),
    @ProyectoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ProyectoN = Proyecto FROM Inserted
  SELECT @ProyectoA = Proyecto FROM Deleted
  IF @ProyectoN = @ProyectoA RETURN

  IF @ProyectoN IS NULL 
    DELETE ProyD WHERE Proyecto = @ProyectoA
  ELSE BEGIN
    UPDATE ProyD SET Proyecto = @ProyectoN WHERE Proyecto = @ProyectoA
  END
END
GO

/****** UEN ******/
if not exists(select * from SysTabla where SysTabla = 'UEN')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UEN','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UEN') and type = 'U') 
CREATE TABLE dbo.UEN (
	UEN 			int		NOT NULL,
	Nombre			varchar(100)	NULL,
	VentaLimiteRenFacturas	int		NULL,
	Estatus			varchar(15)	NULL	DEFAULT 'ALTA',

	CONSTRAINT priUEN PRIMARY KEY CLUSTERED (UEN)
)
GO
EXEC spALTER_TABLE 'UEN', 'VentaLimiteRenFacturas', 'int NULL'
EXEC spALTER_TABLE 'UEN', 'Estatus', 'varchar(15) NULL DEFAULT "ALTA" WITH VALUES'
GO


/****** Categorias de Proyectos  ******/
if not exists(select * from SysTabla where SysTabla = 'ProyCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProyCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProyCat') and type = 'U') 
CREATE TABLE dbo.ProyCat (
	Categoria 		varchar(50) 	NOT NULL,

	CONSTRAINT priProyCat PRIMARY KEY CLUSTERED (Categoria)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgProyCatBC') and sysstat & 0xf = 8) drop trigger dbo.tgProyCatBC
GO

--Integración CRM
EXEC spAlter_Table 'proycat', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'proycat', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

/****** Dias Festivos  ******/
if not exists(select * from SysTabla where SysTabla = 'DiaFestivo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DiaFestivo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DiaFestivo') and type = 'U') 
CREATE TABLE dbo.DiaFestivo (
	Fecha			datetime 	NOT NULL,
	Concepto		varchar(50)	NULL,

        EsLaborable		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priDiaFestivo PRIMARY KEY  CLUSTERED (Fecha)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgDiaFestivoAC') and sysstat & 0xf = 8) drop trigger dbo.tgDiaFestivoAC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgDiaFestivoAC ON DiaFestivo
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @FechaSinHora	datetime

  IF dbo.fnEstaSincronizando() = 1 RETURN
      
  SELECT @Fecha = Fecha FROM Inserted
  SELECT @FechaSinHora = @Fecha
  EXEC spExtraerFecha @FechaSinHora OUTPUT

  UPDATE DiaFestivo SET Fecha = @FechaSinHora WHERE Fecha = @Fecha
END
GO

/****** ClaseTarea  ******/
if not exists(select * from SysTabla where SysTabla = 'ClaseTarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ClaseTarea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ClaseTarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ClaseTarea (
	Modulo		char(5)	     	NOT NULL,
	Clase		varchar(50) 	NOT NULL,
	ID		int		NOT NULL IDENTITY(1,1),

	SubClase	varchar(50) 	NULL,
	Tarea		varchar(100)    NULL,
	Tipo		varchar(20)	NULL,
	Dias		int		NULL,
	Forzosa		bit		NULL	DEFAULT 0,
	Orden		int		NULL,

	CONSTRAINT priClaseTarea PRIMARY KEY CLUSTERED (Modulo, Clase, ID)
  )
  EXEC spSincroSemilla 'ClaseTarea'
END
go
EXEC spALTER_TABLE 'ClaseTarea', 'Dias', 'int NULL'
EXEC spALTER_TABLE 'ClaseTarea', 'Forzosa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ClaseTarea', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ClaseTarea', 'Tipo', 'varchar(20) NULL'
GO
if (select version from version)<=2423
  alter table ClaseTarea ALTER COLUMN Tarea varchar(100) NULL
GO

/****** ClaseProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'ClaseProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ClaseProrrateo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ClaseProrrateo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ClaseProrrateo (
	Modulo			char(5)	     NOT NULL,
	Clase	 		varchar(50)  NOT NULL,
	RenglonID		int	     IDENTITY(1,1) NOT NULL,

	SubClase		varchar(50)  NULL,
	EmpresaProrrateo	char(7)	     NULL	DEFAULT '(Todas)',
	SucursalProrrateo	int	     NULL,
	CCProrrateo		varchar(20)  NULL,
	CC2Prorrateo		varchar(20)  NULL,
	CC3Prorrateo		varchar(20)  NULL,
	EspacioProrrateo	char(10)     NULL,
	VINProrrateo	        varchar(20)  NULL,
	ProyectoProrrateo	varchar(50)  NULL,
	UENProrrateo		int	     NULL,
	ActividadProrrateo	varchar(100) NULL,
	AFArticuloProrrateo	varchar(20)  NULL,
	AFSerieProrrateo	varchar(20)  NULL, 
	Porcentaje		float	     NULL,

	CONSTRAINT priClaseProrrateo PRIMARY KEY CLUSTERED (Modulo, Clase, RenglonID)
  )
  EXEC spSincroSemilla 'ClaseProrrateo'
END
GO
EXEC spALTER_TABLE 'ClaseProrrateo', 'CC2Prorrateo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ClaseProrrateo', 'CC3Prorrateo', 'varchar(20) NULL'
GO

EXEC spALTER_COLUMN 'ClaseProrrateo', 'AFSerieProrrateo', 'varchar(50) NULL' -- BUG12333
GO

EXEC spFK 'ClaseProrrateo','SucursalProrrateo','Sucursal','Sucursal'
EXEC spFK 'ClaseProrrateo','CCProrrateo','CentroCostos','CentroCostos'
EXEC spFK 'ClaseProrrateo','UENProrrateo','UEN','UEN'
EXEC spFK 'ClaseProrrateo','AFArticuloProrrateo','Art','Articulo'
EXEC spFK 'ClaseProrrateo','VINProrrateo','VIN','VIN'
GO

/****** SubClase  ******/
if not exists(select * from SysTabla where SysTabla = 'SubClase')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SubClase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SubClase') and type = 'U') 
CREATE TABLE dbo.SubClase (
	Modulo			char(5)	     	NOT NULL,
	Clase			varchar(50) 	NOT NULL,
	SubClase		varchar(50) 	NOT NULL,
	Cuenta			char(20)     	NULL,
	Comentarios		text		NULL,
	Descripcion		varchar(255)	NULL,

	Orden			int		NULL,
	Numero			int		NULL,
	InflacionPresupuesto	money 		NULL,

	CONSTRAINT priSubClase PRIMARY KEY CLUSTERED (Modulo, Clase, SubClase)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgSubClaseBC') and sysstat & 0xf = 8) drop trigger dbo.tgSubClaseBC
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'SubClase', 'Cuenta','char(20) NULL'
EXEC spALTER_TABLE 'SubClase', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'SubClase', 'InflacionPresupuesto', 'money NULL'
EXEC spALTER_TABLE 'SubClase', 'Numero', 'int NULL'
EXEC spALTER_TABLE 'SubClase', 'Descripcion', 'varchar(255) NULL'
GO
CREATE TRIGGER tgSubClaseBC ON SubClase
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ModuloA    char(5),
    @ClaseA	varchar(50),
    @SubClaseN 	varchar(50),
    @SubClaseA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @SubClaseN = SubClase FROM Inserted
  SELECT @SubClaseA = SubClase, @ClaseA = Clase, @ModuloA = Modulo FROM Deleted

  IF @SubClaseN = @SubClaseA RETURN

  IF @SubClaseN IS NULL
  BEGIN
    DELETE ClaseTarea     WHERE Modulo = @ModuloA AND Clase = @ClaseA AND SubClase = @SubClaseA
    DELETE ClaseProrrateo WHERE Modulo = @ModuloA AND Clase = @ClaseA AND SubClase = @SubClaseA
  END ELSE
  BEGIN
    UPDATE ClaseTarea     SET SubClase = @SubClaseN WHERE Modulo = @ModuloA AND Clase = @ClaseA AND SubClase = @SubClaseA
    UPDATE ClaseProrrateo SET SubClase = @SubClaseN WHERE Modulo = @ModuloA AND Clase = @ClaseA AND SubClase = @SubClaseA
  END
END
GO


/****** Clase  ******/
if not exists(select * from SysTabla where SysTabla = 'Clase')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Clase','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Clase') and type = 'U') 
CREATE TABLE dbo.Clase (
	Modulo		char(5)	     	NOT NULL,
	Clase		varchar(50) 	NOT NULL,
	Cuenta		char(20)     	NULL,
	Comentarios	text		NULL,
	Responsable	varchar(10)	NULL,
	Descripcion	varchar(255)	NULL,

	Orden		int		NULL,
	Numero		int		NULL,

	CONSTRAINT priClase PRIMARY KEY CLUSTERED (Modulo, Clase)
)
go
EXEC spALTER_TABLE 'Clase', 'Cuenta','char(20) NULL'
EXEC spALTER_TABLE 'Clase', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Clase', 'Responsable', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Clase', 'Numero', 'int NULL'
EXEC spALTER_TABLE 'Clase', 'Descripcion', 'varchar(255) NULL'
go
if exists (select * from sysobjects where id = object_id('dbo.tgClaseBC') and sysstat & 0xf = 8) drop trigger dbo.tgClaseBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgClaseBC ON Clase
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ModuloA    char(5),
    @ClaseN 	varchar(50),
    @ClaseA	varchar(50),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ClaseN = Clase FROM Inserted
  SELECT @ClaseA = Clase, @ModuloA = Modulo FROM Deleted

  IF @ClaseN = @ClaseA RETURN

  IF @ClaseN IS NULL
  BEGIN
    DELETE SubClase       WHERE Clase = @ClaseA AND Modulo = @ModuloA
    DELETE ClaseTarea     WHERE Clase = @ClaseA AND Modulo = @ModuloA
    DELETE ClaseProrrateo WHERE Clase = @ClaseA AND Modulo = @ModuloA
  END ELSE
  BEGIN
    UPDATE SubClase       SET Clase = @ClaseN WHERE Clase = @ClaseA AND Modulo = @ModuloA
    UPDATE ClaseTarea     SET Clase = @ClaseN WHERE Clase = @ClaseA AND Modulo = @ModuloA
    UPDATE ClaseProrrateo SET Clase = @ClaseN WHERE Clase = @ClaseA AND Modulo = @ModuloA
  END
END
GO

if not exists (select * from sysobjects where id = object_id('dbo.TareaDef') and type = 'U') and exists (select * from sysobjects where id = object_id('dbo.Tarea') and type = 'U') 
  EXEC sp_rename 'Tarea', 'TareaDef'
GO

/****** TareaDef ******/
if not exists(select * from SysTabla where SysTabla = 'TareaDef')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TareaDef','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TareaDef') and type = 'U') 
CREATE TABLE dbo.TareaDef (
	Tarea 		varchar(50) 	NOT NULL,

	Categoria 	varchar(50) 	NULL,
	Tiempo		float		NULL,
	Orden		int		NULL,

	CONSTRAINT priTareaDef PRIMARY KEY CLUSTERED (Tarea)
)
GO
EXEC spALTER_TABLE 'TareaDef', 'Tiempo', 'float NULL'
EXEC spALTER_TABLE 'TareaDef', 'Orden', 'int NULL'
GO

/****** TareaTipo ******/
if not exists(select * from SysTabla where SysTabla = 'TareaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TareaTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TareaTipo') and type = 'U') 
CREATE TABLE dbo.TareaTipo (
	Tipo		varchar(50) 	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priTareaTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO
EXEC spALTER_TABLE 'TareaTipo', 'Orden', 'int NULL'
GO

/****** ActividadTipo ******/
if not exists(select * from SysTabla where SysTabla = 'ActividadTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ActividadTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ActividadTipo') and type = 'U') 
CREATE TABLE dbo.ActividadTipo (
	Tipo		varchar(50) 	NOT NULL,

	Icono		int		NULL,
	Orden		int		NULL,

	CONSTRAINT priActividadTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO
EXEC spALTER_TABLE 'ActividadTipo', 'Orden', 'int NULL'
EXEC spALTER_TABLE 'ActividadTipo', 'Icono', 'int NULL'
GO


/****** AcuerdoTipo ******/
if not exists(select * from SysTabla where SysTabla = 'AcuerdoTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('AcuerdoTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.AcuerdoTipo') and type = 'U') 
CREATE TABLE dbo.AcuerdoTipo (
	Tipo		varchar(50) 	NOT NULL,

	CONSTRAINT priAcuerdoTipo PRIMARY KEY CLUSTERED (Tipo)
)
GO

/****** Tarea  ******/
if not exists(select * from SysTabla where SysTabla = 'Tarea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Tarea','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Tarea','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Tarea') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Tarea (
	ID			int		NOT NULL  IDENTITY(1,1),

	Tarea			varchar(20)	NULL,
	Empresa			char(5)		NULL,	
	Modulo			char(5)		NULL,
	ModuloID		int		NULL,
	Contacto		varchar(10)	NULL,
	Cliente			varchar(10)	NULL,
	Proveedor		varchar(10)	NULL,
	Personal		varchar(10)	NULL,
	Agente			varchar(10)	NULL,
	Usuario			char(10)	NULL,
	UsuarioResponsable	char(10)	NULL,
	UsuarioAsignado		char(10)	NULL,
	Proyecto 		varchar(50) 	NULL,
	UEN			int		NULL,
	Reporte			varchar(20)	NULL,
	Prospecto		varchar(10)	NULL,

	Asunto			varchar(100)	NULL,
	Tipo			varchar(50)	NULL,
	Comentarios		text		NULL,
	Estado			varchar(30)	NULL,
	Vencimiento		datetime	NULL,
	Prioridad		char(10)	NULL,

	FechaEmision		datetime	NULL,
	FechaInicio		datetime	NULL,
	FechaConclusion		datetime	NULL,
	FechaInicioEst		datetime	NULL,
	FechaConclusionEst	datetime	NULL,
	Tiempo			float		NULL,
	Forzosa			bit		NULL	DEFAULT 0,
	Completada		int		NULL	DEFAULT 0,

	RelacionTipo		varchar(10)	NULL,
	Relacion		varchar(50)	NULL,
		
	Orden			int		NULL,
	Revision		int		NULL,
	Sincronizando		bit		NULL	DEFAULT 0,

	CONSTRAINT pTarea PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Tarea'
END
go
EXEC spALTER_TABLE 'Tarea', 'Forzosa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Tarea', 'Completada', 'int NULL DEFAULT 0'
EXEC spALTER_TABLE 'Tarea', 'FechaInicioEst', 'datetime	NULL'
EXEC spALTER_TABLE 'Tarea', 'FechaConclusionEst', 'datetime NULL'
EXEC spALTER_TABLE 'Tarea', 'Revision', 'int NULL'
EXEC spALTER_TABLE 'Tarea', 'Reporte', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Tarea', 'Tipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Tarea', 'FechaEmision', 'datetime NULL'
EXEC spALTER_TABLE 'Tarea', 'Sincronizando', 'bit NULL DEFAULT 0 WITH VALUES'
if not exists(select * from syscampo where tabla = 'Tarea' AND Campo = 'UsuarioResponsable')
BEGIN
  EXEC spALTER_TABLE 'Tarea', 'UsuarioResponsable', 'char(10) NULL'
  EXEC("UPDATE Tarea SET UsuarioResponsable = Usuario")
END
EXEC spALTER_TABLE 'Tarea', 'Tarea', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Tarea', 'UsuarioAsignado', 'char(10) NULL'
EXEC spALTER_TABLE 'Tarea', 'Contacto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Tarea', 'RelacionTipo', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Tarea', 'Relacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Tarea', 'Prospecto', 'varchar(10) NULL'
GO

if (select version from version) < 2873 AND exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  DROP INDEX Tarea.ID 
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'ID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ID ON dbo.Tarea (ModuloID, Modulo)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente ON dbo.Tarea (Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Proveedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proveedor ON dbo.Tarea (Proveedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Personal' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Personal ON dbo.Tarea (Personal)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Contacto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Contacto ON dbo.Tarea (Contacto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Agente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Agente ON dbo.Tarea (Agente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario ON dbo.Tarea (Usuario)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Asunto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Asunto ON dbo.Tarea (Asunto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Reporte' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Reporte ON dbo.Tarea (Reporte)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Prospecto' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Prospecto ON dbo.Tarea (Prospecto)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Tarea' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Tarea ON dbo.Tarea (Tarea)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Tarea' AND sysindexes.name = 'Relacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Relacion ON dbo.Tarea (Relacion, RelacionTipo)
go

if exists (select * from sysobjects where id = object_id('dbo.tgTareaABC') and sysstat & 0xf = 8) drop trigger dbo.tgTareaABC
GO
CREATE TRIGGER tgTareaABC ON Tarea
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ID				int,
    @IDN			int,
    @IDA			int,
    @UsuarioN			char(10),
    @UsuarioA			char(10),
    @UsuarioResponsableN	char(10),
    @UsuarioResponsableA	char(10),
    @UsuarioAsignadoN		char(10),
    @UsuarioAsignadoA		char(10),
    @DeN			varchar(100),
    @DeA			varchar(100),
    @ParaN			varchar(100),
    @ParaA			varchar(100),
    @Tarea			varchar(20)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF NOT EXISTS (SELECT * FROM Version WHERE OutlookTareas = 1 AND OutlookTareasSincronizar = 1) RETURN

  SELECT @IDN = ID, @UsuarioN = Usuario, @UsuarioResponsableN = NULLIF(RTRIM(UsuarioResponsable), ''), @UsuarioAsignadoN = NULLIF(RTRIM(UsuarioAsignado), '') FROM Inserted  
  SELECT @IDA = ID, @UsuarioA = Usuario, @UsuarioResponsableA = NULLIF(RTRIM(UsuarioResponsable), ''), @UsuarioAsignadoA = NULLIF(RTRIM(UsuarioAsignado), '') FROM Deleted

  SELECT @UsuarioResponsableN = ISNULL(@UsuarioResponsableN, @UsuarioN),
         @UsuarioResponsableA = ISNULL(@UsuarioResponsableA, @UsuarioA)
  SELECT @UsuarioAsignadoN = ISNULL(@UsuarioAsignadoN, @UsuarioResponsableN),
         @UsuarioAsignadoA = ISNULL(@UsuarioAsignadoA, @UsuarioResponsableA)

  IF @IDN IS NOT NULL
  BEGIN
    SELECT @DeN   = MIN(Nombre) FROM OutlookNombre WHERE Usuario = @UsuarioResponsableN AND Estatus = 'ALTA'
    SELECT @ParaN = MIN(Nombre) FROM OutlookNombre WHERE Usuario = @UsuarioAsignadoN    AND Estatus = 'ALTA'
  END

  IF @IDA IS NOT NULL
  BEGIN
    SELECT @DeA   = MIN(Nombre) FROM OutlookNombre WHERE Usuario = @UsuarioResponsableA AND Estatus = 'ALTA'
    SELECT @ParaA = MIN(Nombre) FROM OutlookNombre WHERE Usuario = @UsuarioAsignadoA    AND Estatus = 'ALTA'
  END

  -- Agregar
  IF @IDA IS NULL
    BEGIN
	IF @IDN IS NOT NULL
	BEGIN
		INSERT INTO TareaBitacora (ID, Fecha, Evento, Usuario)
		VALUES (@IDN, getdate(), 'Alta', @UsuarioResponsableN)
	END    
	INSERT OutlookProcesar (
           Tipo,    De,   Fecha,        Asunto, Mensaje,     FechaD,      FechaA,          Vencimiento, Estado, Completado, Prioridad, Accion,    Modulo,  ModuloID)
    SELECT 'Tarea', @DeN, FechaEmision, Asunto, Comentarios, FechaInicio, FechaConclusion, Vencimiento, Estado, Completada, Prioridad, 'Agregar', 'TAREA', ID
      FROM Tarea
     WHERE ID = @IDN
    SELECT @ID = SCOPE_IDENTITY()
    IF @UsuarioAsignadoN <> NULL
        INSERT OutlookProcesarPara (ID, Para) VALUES (@ID, @ParaN)
  END 
  ELSE
  -- Eliminar
  IF @IDN IS NULL
    INSERT OutlookProcesar (Tipo, De, Accion, Modulo, ModuloID) VALUES ('Tarea', @DeA , 'Eliminar', 'TAREA', @IDA)
  ELSE

  -- Modificar
  BEGIN
	IF NOT UPDATE(Sincronizando) 
    BEGIN
	  IF @UsuarioResponsableA = @UsuarioResponsableN  and @UsuarioResponsableA <> @UsuarioAsignadoA and @UsuarioAsignadoN = @UsuarioAsignadoA 
			SELECT @DeN = @ParaN
      INSERT OutlookProcesar (
             Tipo,    De,   Fecha,        Asunto, Mensaje,     FechaD,      FechaA,          Vencimiento, Estado, Completado, Prioridad, Accion,      Modulo,  ModuloID)
      SELECT 'Tarea', @DeN, FechaEmision, Asunto, Comentarios, FechaInicio, FechaConclusion, Vencimiento, Estado, Completada, Prioridad, 'Modificar', 'TAREA', ID
        FROM Tarea
       WHERE ID = @IDN
      SELECT @ID = SCOPE_IDENTITY()
      IF @ParaN <> @ParaA
        INSERT OutlookProcesarPara (ID, Para) VALUES (@ID, @ParaN)
   	  INSERT INTO TareaBitacora (ID, Fecha, Evento, Usuario)
      VALUES (@IDN, getdate(), 'Actualizada', @UsuarioAsignadoN)
    END
  END
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgTareaProcesoABC') and sysstat & 0xf = 8) drop trigger dbo.tgTareaProcesoABC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTareaProceso') and sysstat & 0xf = 8) drop trigger dbo.tgTareaProceso
GO
/*CREATE TRIGGER tgTareaProceso ON Tarea
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Hoy	datetime,
    @ID		int,
    @Proceso	varchar(50),
    @Fase	int,
    @Orden	int,
    @Empresa 	varchar(5),
    @Modulo 	varchar(5), 
    @ModuloID 	int, 
    @Prospecto 	varchar(10),
    @Cliente 	varchar(10),
    @Proveedor 	varchar(10),
    @Personal 	varchar(10),
    @Agente 	varchar(10),
    @Usuario 	varchar(10),
    @Proyecto 	varchar(50),
    @UEN 	int,
    @EstadoN	varchar(30),
    @EstadoA	varchar(30)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF NOT UPDATE(Estado) RETURN

  SELECT @EstadoN = UPPER(Estado), @ID = ID, @Proceso = Proceso, @Fase = Fase, @Orden = Orden, @Empresa = Empresa, @Modulo = Modulo, @ModuloID = ModuloID, @Prospecto = Prospecto, @Cliente = Cliente, @Proveedor = Proveedor, @Personal = Personal, @Agente = Agente, @Usuario = Usuario, @Proyecto = Proyecto, @UEN = UEN FROM Inserted
  SELECT @EstadoA = UPPER(Estado) FROM Deleted

  IF @Proceso IS NOT NULL AND @EstadoN <> @EstadoA
  BEGIN
    SELECT @Hoy = dbo.fnFechaSinHora(GETDATE())
    IF @EstadoN = 'COMPLETADA'
    BEGIN
      IF EXISTS(SELECT * FROM CRMProcesoTarea WHERE Proceso = @Proceso AND Fase = @Fase AND Predecesora = @Orden)
        INSERT Tarea (
               Empresa,  Modulo,  ModuloID,  Proceso,  Fase, Orden, Prospecto,  Cliente,  Proveedor,  Personal,  Agente,  Usuario,  Proyecto,  UEN,  Asunto,  Estado,        Vencimiento,              Prioridad, Tipo)
        SELECT @Empresa, @Modulo, @ModuloID, @Proceso, Fase, Tarea, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @Usuario, @Proyecto, @UEN, Asunto, 'No comenzada', DATEADD(day, Dias, @Hoy), 'Normal',  Tipo
          FROM CRMProcesoTarea
         WHERE Proceso = @Proceso AND Fase = @Fase AND Predecesora = @Orden AND Tarea NOT IN (SELECT Orden FROM Tarea WHERE Modulo = @Modulo AND ModuloID = @ModuloID AND Fase = @Fase)
      ELSE
        INSERT Tarea (
               Empresa,  Modulo,  ModuloID,  Proceso,  Fase, Orden, Prospecto,  Cliente,  Proveedor,  Personal,  Agente,  Usuario,  Proyecto,  UEN,  Asunto,  Estado,        Vencimiento,              Prioridad, Tipo)
        SELECT @Empresa, @Modulo, @ModuloID, @Proceso, Fase, Tarea, @Prospecto, @Cliente, @Proveedor, @Personal, @Agente, @Usuario, @Proyecto, @UEN, Asunto, 'No comenzada', DATEADD(day, Dias, @Hoy), 'Normal',  Tipo
          FROM CRMProcesoTarea
         WHERE Proceso = @Proceso AND Fase = @Fase + 1 AND Predecesora IS NULL AND Tarea NOT IN (SELECT Orden FROM Tarea WHERE Modulo = @Modulo AND ModuloID = @ModuloID  AND Fase = @Fase + 1)
    END
  END
END*/
GO

if exists (select * from sysobjects where id = object_id('dbo.tgOutlookABC') and sysstat & 0xf = 8) drop trigger dbo.tgOutlookABC
GO
CREATE TRIGGER tgOutlookABC ON Outlook
----//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @ID			int,
    @IDN		int,
    @IDA		int,
    @TipoN		varchar(20),
    @TipoA		varchar(20),
    @ModuloN		char(5),
    @ModuloA		char(5),
    @ModuloIDN		int,
    @ModuloIDA		int,
    @De			varchar(100),
    @Para		varchar(100),
    @UsuarioAsignado	char(10),
    @UsuarioModificador	char(10),
    @Estado		varchar(30)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF NOT EXISTS (SELECT * FROM Version WHERE OutlookTareas = 1 AND OutlookTareasSincronizar = 1) RETURN

  SELECT @IDN = ID, @TipoN = UPPER(Tipo), @ModuloN = Modulo, @ModuloIDN = ModuloID FROM Inserted  
  SELECT @IDA = ID, @TipoA = UPPER(Tipo), @ModuloA = Modulo, @ModuloIDA = ModuloID FROM Deleted

  SELECT @Para = MIN(Para) FROM OutlookPara WHERE ID = @IDN
  SELECT @De = MIN(De) FROM Outlook WHERE ID = @IDN

  SELECT @UsuarioAsignado = MIN(Usuario) FROM OutlookNombre WHERE Nombre = @Para AND Estatus = 'ALTA'
  IF not @UsuarioAsignado IS NULL
		SELECT @UsuarioModificador = @UsuarioAsignado
  ELSE
		SELECT @UsuarioModificador = MIN(Usuario) FROM OutlookNombre WHERE Nombre = @De AND Estatus = 'ALTA'

  -- Falta Agregar tarea

  -- Eliminar tarea
  IF @IDN IS NULL AND @TipoA = 'TAREA' AND @ModuloA = 'TAREA' AND @ModuloIDA IS NOT NULL
    UPDATE Tarea set Estado = 'Eliminada', UsuarioAsignado = @UsuarioModificador WHERE ID = @ModuloIDA
  ELSE
  -- Modificar tarea
  IF @IDA IS NOT NULL AND @IDN IS NOT NULL AND @TipoN = 'TAREA' 
  BEGIN
    SELECT @Estado = Estado FROM Tarea WHERE Id = @ModuloIDA
    UPDATE Tarea
       SET FechaEmision = o.Fecha,
           Asunto = o.Asunto,
           Comentarios = o.Mensaje,
           FechaInicio = o.FechaD,
           FechaConclusion = o.FechaA,
           Vencimiento = o.Vencimiento,
           Estado = CASE WHEN @Estado = 'Eliminada' THEN 'Eliminada' ELSE o.Estado END,
           Completada = o.Completado,
           Prioridad = o.Prioridad,
           UsuarioAsignado = ISNULL(NULLIF(RTRIM(@UsuarioModificador), ''), t.UsuarioAsignado),
           Sincronizando = 1
      FROM Outlook o, Tarea t
     WHERE t.ID = @ModuloIDN AND o.ID = @IDN
    UPDATE Tarea
       SET Sincronizando = 0
     WHERE ID = @IDN
  END

  -- Eliminar Actividad
  IF @IDN IS NULL AND @TipoA = 'ACTIVIDAD' AND @ModuloA = 'ACT' AND @ModuloIDA IS NOT NULL
    UPDATE Act SET Estado = 'Eliminada' WHERE ID = @ModuloIDA
  ELSE
  -- Modificar Actividad
  IF @IDA IS NOT NULL AND @IDN IS NOT NULL AND @TipoN = 'ACTIVIDAD' 
  BEGIN
    SELECT @Estado = Estado FROM Act WHERE ID = @ModuloIDA
    UPDATE Act
       SET Asunto = o.Asunto,
           Comentarios = o.Mensaje,
           Comienzo = o.FechaD,
           Fin = o.FechaA,
           Estado = CASE WHEN @Estado = 'Eliminada' THEN 'Eliminada' ELSE o.Estado END,
           Avance = o.Completado,
           Prioridad = o.Prioridad,
           Sincronizando = 1
      FROM Outlook o, Act a
     WHERE a.ID = @ModuloIDN AND o.ID = @IDN
    UPDATE Act
       SET Sincronizando = 0
     WHERE ID = @IDN    
  END
END
GO

/****** TareaBitacora  ******/
if not exists(select * from SysTabla where SysTabla = 'TareaBitacora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TareaBitacora','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.TareaBitacora') and type = 'U') 
  CREATE TABLE dbo.TareaBitacora (
	ID		int		NOT NULL,
	Fecha		datetime	NOT NULL,

	Evento		varchar(255)	NULL,
	Usuario		char(10)	NULL,

	CONSTRAINT priTareaBitacora PRIMARY KEY CLUSTERED (ID, Fecha)
)
GO

/****** TareaCat  ******/
if not exists(select * from SysTabla where SysTabla = 'TareaCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TareaCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TareaCat') and type = 'U') 
CREATE TABLE dbo.TareaCat (
	Categoria 		varchar(50) 	NOT NULL,

	CONSTRAINT priTareaCat PRIMARY KEY CLUSTERED (Categoria)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTareaCatBC') and sysstat & 0xf = 8) drop trigger dbo.tgTareaCatBC
GO

/****** TiposCuentas  ******/
if not exists(select * from SysTabla where SysTabla = 'TipoCuenta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoCuenta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoCuenta') and type = 'U') 
CREATE TABLE dbo.TipoCuenta (
        ClaveOrden		char(5)		NOT NULL,
	TipoCuenta	        char(20)	NOT NULL,

	CONSTRAINT priTipoCuenta PRIMARY KEY  CLUSTERED (ClaveOrden)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgTipoCuentaBC') and sysstat & 0xf = 8) drop trigger dbo.tgTipoCuentaBC
GO

/****** Concepto ******/
if not exists(select * from SysTabla where SysTabla = 'Concepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Concepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Concepto') and type = 'U') 
CREATE TABLE dbo.Concepto (
	Modulo			char(5)	     NOT NULL,
	Concepto 		varchar(50)  NOT NULL,
	EsDeducible		bit	     NOT NULL 	DEFAULT 1,
	Logico1			bit	     NOT NULL 	DEFAULT 0,
	Indirecto		bit	     NOT NULL 	DEFAULT 0,
	ConSueldo		bit	     NOT NULL 	DEFAULT 0,

	Cuenta			char(20)     NULL,
	Impuestos		money	     NULL,
	Retencion		money	     NULL,
	Retencion2		money	     NULL,
	Retencion3		money	     NULL,

	Clase			varchar(50)  NULL,
	SubClase	        varchar(50)  NULL,
	
	Bloqueo			varchar(50)  NULL,
	Orden			int	     NULL,
	ValidarPresupuesto	varchar(20)  NULL 	DEFAULT 'No',
	Tipo			varchar(20)  NULL 	DEFAULT 'Fijo',
	Proyecto		varchar(50)  NULL,
	Actividad		varchar(100) NULL,
	PorcentajeDeducible	float	     NULL 	DEFAULT 100,
	LimiteDeducible		money	     NULL,
	AcreedorDef		char(10)     NULL,
        NivelAcceso		varchar(50)  NULL,
	TipoProrrateo		varchar(50)  NULL,
	EstimuloFiscal		float	     NULL,
	CR			bit	     NULL	DEFAULT 0,
	UEN			int	     NULL,
	Politica		text	     NULL,
	ConceptoCxp 		varchar(50)  NULL,
	Provisionable		bit	     NULL	DEFAULT 0,
	ProvisionImporte	money	     NULL,
	CuentaPresupuesto	varchar(20)  NULL,
	CalcularPresupuesto	bit 	     NULL	DEFAULT 0,
	InflacionPresupuesto	money 	     NULL,
	DepartamentoDetallista	int	     NULL,
	Impuesto1Excento	bit 	     NULL	DEFAULT 0,
	TipoOperacion		varchar(30)  NULL,	-- Honorarios, Renta, Intereses, Otros, Importación Bienes, Importación Servicios
	Numero			int	     NULL,
	Descripcion		varchar(255) NULL,
	CostoEstandar		money	     NULL,
	UltimoCosto		money	     NULL,
	UltimoGasto		datetime     NULL,
	MonedaCosto		varchar(10)  NULL,
	Excento2		bit	     NULL	DEFAULT 0,
	Excento3		bit	     NULL	DEFAULT 0,
	EsInventariable		bit	     NULL	DEFAULT 0,
	Articulo		varchar(20)  NULL,
	ContUso		        varchar(20)  NULL,
	ContUso2	        varchar(20)  NULL,	
	ContUso3	        varchar(20)  NULL,		
	ObjetoGasto		varchar(10)  NULL,
	ObjetoGastoRef		varchar(10)  NULL,
	ClavePresupuestalImpuesto1 varchar(50)	NULL,
	ClavePresupuestalRetencion1 varchar(50)	NULL, --BUG15710	
	
	TipoImpuesto1		varchar(10) 	NULL,
	TipoImpuesto2		varchar(10) 	NULL,
	TipoImpuesto3		varchar(10) 	NULL,
	TipoImpuesto4		varchar(10) 	NULL,
	TipoImpuesto5		varchar(10) 	NULL,
	TipoRetencion1		varchar(10) 	NULL, 
	TipoRetencion2		varchar(10) 	NULL, 
	TipoRetencion3		varchar(10) 	NULL, 

	EcuadorTipoOperacionGasto	varchar(50)	NULL,

	InvSeguridad		float		NULL,
	CantidadMinima		float		NULL,
	CantidadMaxima		float		NULL,
	POSImpuestos		bit	     NULL	DEFAULT 0,--REQ 13393 POS	
	CONSTRAINT priConcepto PRIMARY KEY CLUSTERED (Modulo, Concepto)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgConceptoBC') and sysstat & 0xf = 8) drop trigger dbo.tgConceptoBC
GO
EXEC spALTER_TABLE 'Concepto', 'Retencion2', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'Clase', 'varchar(50)  NULL'
EXEC spALTER_TABLE 'Concepto', 'SubClase', 'varchar(50)  NULL'
EXEC spALTER_TABLE 'Concepto', 'ValidarPresupuesto', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'Tipo', 'varchar(20)  NULL DEFAULT "Fijo" WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'Actividad', 'varchar(100) NULL'
if not exists(select * from syscampo where tabla ='Concepto' and campo ='PorcentajeDeducible')
begin
  EXEC spALTER_TABLE 'Concepto', 'PorcentajeDeducible', 'float NULL DEFAULT 100 WITH VALUES'
  EXEC("UPDATE Concepto SET PorcentajeDeducible = 0 WHERE EsDeducible = 0")
end
EXEC spALTER_TABLE 'Concepto', 'AcreedorDef', 'char(10) NULL'
GO
EXEC spRENAME_COLUMN 'Concepto', 'Logico2', 'Indirecto'
EXEC spALTER_TABLE 'Concepto', 'NivelAcceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoProrrateo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Concepto', 'EstimuloFiscal', 'float NULL'
EXEC spALTER_TABLE 'Concepto', 'CR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'UEN', 'int NULL'
GO
IF (select version from version)<=2328
  UPDATE Concepto SET PorcentajeDeducible = 100 WHERE Modulo = 'GAS' AND PorcentajeDeducible IS NULL
GO
if (select version from version) <= 2331
  ALTER TABLE Concepto ALTER COLUMN Actividad varchar(100) NULL
GO
EXEC spALTER_TABLE 'Concepto', 'Retencion3', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'LimiteDeducible', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'Politica', 'text NULL'
EXEC spALTER_TABLE 'Concepto', 'ConceptoCxp', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Concepto', 'Provisionable', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'ProvisionImporte', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'CuentaPresupuesto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Concepto', 'CalcularPresupuesto', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'Concepto', 'InflacionPresupuesto', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'DepartamentoDetallista', 'int NULL'
EXEC spALTER_TABLE 'Concepto', 'Impuesto1Excento', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoOperacion', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Concepto', 'Numero', 'int NULL'
EXEC spALTER_TABLE 'Concepto', 'Descripcion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Concepto', 'CostoEstandar', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'UltimoCosto', 'money NULL'
EXEC spALTER_TABLE 'Concepto', 'UltimoGasto', 'datetime NULL'
EXEC spALTER_TABLE 'Concepto', 'MonedaCosto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto' ,'Excento2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto' ,'Excento3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto' ,'EsInventariable', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Concepto' ,'Articulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Concepto', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Concepto', 'ContUso2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Concepto', 'ContUso3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Concepto', 'ObjetoGasto', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'ObjetoGastoRef', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'ClavePresupuestalImpuesto1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Concepto', 'ClavePresupuestalRetencion1', 'varchar(50) NULL' --BUG15710
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto1', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto2', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto4', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoImpuesto5', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion1', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion2', 'varchar(10) NULL' 
EXEC spALTER_TABLE 'Concepto', 'TipoRetencion3', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Concepto', 'EcuadorTipoOperacionGasto', 'varchar(50)'
EXEC spALTER_TABLE 'Concepto','InvSeguridad', 'float NULL'
EXEC spALTER_TABLE 'Concepto','CantidadMinima', 'float NULL'
EXEC spALTER_TABLE 'Concepto','CantidadMaxima', 'float NULL'	
EXEC spALTER_TABLE 'Concepto', 'CFDIRetClave', 'varchar(2) NULL'
GO
EXEC spALTER_TABLE 'Concepto', 'ValorAduana', 'BIT NULL DEFAULT 0'
GO

--REQ 13393 POS
EXEC spALTER_TABLE 'Concepto', 'POSImpuestos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spFK 'Concepto','UEN','UEN','UEN'
EXEC spFK 'Concepto','DepartamentoDetallista','DepartamentoDetallista','Departamento'
GO

/****** ConceptoExpress ******/
if not exists(select * from SysTabla where SysTabla = 'ConceptoExpress')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConceptoExpress','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ConceptoExpress') and type = 'U') 
CREATE TABLE dbo.ConceptoExpress (
	ID			int	     NOT NULL   IDENTITY(1,1),

	Modulo			char(5)	     NULL,
	Concepto 		varchar(50)  NULL,
	Clase			varchar(50)  NULL,
	SubClase	        varchar(50)  NULL,
	
	CONSTRAINT priConceptoExpress PRIMARY KEY CLUSTERED (ID)
)
GO

/****** ConceptoAcreedor ******/
if not exists(select * from SysTabla where SysTabla = 'ConceptoAcreedor')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConceptoAcreedor','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ConceptoAcreedor') and type = 'U') 
CREATE TABLE dbo.ConceptoAcreedor (
	Modulo			char(5)	     NOT NULL,
	Concepto 		varchar(50)  NOT NULL,
	Acreedor		char(10)     NOT NULL,

	porOmision		bit	     NULL DEFAULT 0,

	CONSTRAINT priConceptoAcreedor PRIMARY KEY CLUSTERED (Modulo, Concepto, Acreedor)
)
GO
EXEC spALTER_TABLE 'ConceptoAcreedor', 'porOmision', 'bit NULL DEFAULT 0 WITH VALUES'
GO

/****** ConceptoAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'ConceptoAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConceptoAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ConceptoAcceso') and type = 'U') 
CREATE TABLE dbo.ConceptoAcceso (
	Modulo			char(5)	     NOT NULL,
	Concepto 		varchar(50)  NOT NULL,
	Usuario			char(10)     NOT NULL,

	CONSTRAINT priConceptoAcceso PRIMARY KEY CLUSTERED (Modulo, Concepto, Usuario)
)
GO


/****** ConceptoProrrateo ******/
if not exists(select * from SysTabla where SysTabla = 'ConceptoProrrateo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ConceptoProrrateo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ConceptoProrrateo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ConceptoProrrateo (
	Modulo			char(5)	     NOT NULL,
	Concepto 		varchar(50)  NOT NULL,
	RenglonID		int	     IDENTITY(1,1) NOT NULL,

	EmpresaProrrateo	char(7)	     NULL	DEFAULT '(Todas)',
	SucursalProrrateo	int	     NULL,
	CCProrrateo		varchar(20)  NULL,
	CC2Prorrateo		varchar(20)  NULL,
	CC3Prorrateo		varchar(20)  NULL,
	EspacioProrrateo	char(10)     NULL,
	VINProrrateo	        varchar(20)  NULL,
	ProyectoProrrateo	varchar(50)  NULL,
	UENProrrateo		int	     NULL,
	ActividadProrrateo	varchar(100) NULL,
	AFArticuloProrrateo	varchar(20)  NULL,
	AFSerieProrrateo	varchar(20)  NULL,
	Porcentaje		float	     NULL,

	CONSTRAINT priConceptoProrrateo PRIMARY KEY CLUSTERED (Modulo, Concepto, RenglonID)
  )
  EXEC spSincroSemilla 'ConceptoProrrateo'
END
GO
EXEC spALTER_TABLE 'ConceptoProrrateo', 'ProyectoProrrateo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'ActividadProrrateo', 'varchar(100) NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'EmpresaProrrateo', 'char(7) NULL DEFAULT "(Todas)" WITH VALUES'
GO
EXEC spRENAME_COLUMN 'ConceptoProrrateo', 'AutobusProrrateo', 'EspacioProrrateo'
GO
EXEC spALTER_TABLE 'ConceptoProrrateo', 'EspacioProrrateo', 'char(10) NULL'
GO
EXEC spALTER_TABLE 'ConceptoProrrateo', 'UENProrrateo', 'int NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'VINProrrateo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'AFArticuloProrrateo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'AFSerieProrrateo', 'varchar(20) NULL'
GO

EXEC spALTER_COLUMN 'ConceptoProrrateo', 'AFSerieProrrateo', 'varchar(50) NULL' -- BUG12333
GO

if (select version from version) <= 2331
  ALTER TABLE ConceptoProrrateo ALTER COLUMN ActividadProrrateo varchar(100) NULL
GO
EXEC spALTER_TABLE 'ConceptoProrrateo', 'CC2Prorrateo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'ConceptoProrrateo', 'CC3Prorrateo', 'varchar(20) NULL'
GO

EXEC spFK 'ConceptoProrrateo','SucursalProrrateo','Sucursal','Sucursal'
EXEC spFK 'ConceptoProrrateo','CCProrrateo','CentroCostos','CentroCostos'
EXEC spFK 'ConceptoProrrateo','UENProrrateo','UEN','UEN'
EXEC spFK 'ConceptoProrrateo','AFArticuloProrrateo','Art','Articulo'
EXEC spFK 'ConceptoProrrateo','VINProrrateo','VIN','VIN'
GO

CREATE TRIGGER tgConceptoBC ON Concepto
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ModuloA    char(5),
    @ConceptoN 	varchar(50),
    @ConceptoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ConceptoN = Concepto FROM Inserted
  SELECT @ConceptoA = Concepto, @ModuloA = Modulo FROM Deleted

  IF @ConceptoN = @ConceptoA RETURN

  IF @ConceptoN IS NULL
  BEGIN
    DELETE ConceptoProrrateo WHERE Concepto = @ConceptoA AND Modulo = @ModuloA
    DELETE ConceptoAcceso    WHERE Concepto = @ConceptoA AND Modulo = @ModuloA
    DELETE ConceptoAcreedor  WHERE Concepto = @ConceptoA AND Modulo = @ModuloA
  END ELSE
  BEGIN
    UPDATE ConceptoProrrateo SET Concepto = @ConceptoN WHERE Concepto = @ConceptoA AND Modulo = @ModuloA
    UPDATE ConceptoAcreedor  SET Concepto = @ConceptoN WHERE Concepto = @ConceptoA AND Modulo = @ModuloA
  END
END
GO


/****** Observacion  ******/
if not exists(select * from SysTabla where SysTabla = 'Observacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Observacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Observacion') and type = 'U') 
CREATE TABLE dbo.Observacion (
	Modulo			char(5)	     	NOT NULL,
	Observacion		varchar(255) 	NOT NULL ,

	CONSTRAINT priObservacion PRIMARY KEY CLUSTERED (Modulo, Observacion)
)
GO

/****** Comentario ******/
if not exists(select * from SysTabla where SysTabla = 'Comentario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Comentario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Comentario') and type = 'U') 
CREATE TABLE dbo.Comentario (
	Modulo			char(5)	     	NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Comentario		text 		NULL ,

	CONSTRAINT priComentario PRIMARY KEY CLUSTERED (Modulo, ID)
)
GO

/****** Instrucciones  ******/
if not exists(select * from SysTabla where SysTabla = 'Instruccion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Instruccion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Instruccion') and type = 'U') 
CREATE TABLE dbo.Instruccion (
	Modulo			char(5)	     	NOT NULL,
	Instruccion		varchar(50) 	NOT NULL ,

	CONSTRAINT priInstruccion PRIMARY KEY CLUSTERED (Modulo, Instruccion)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgInstruccionBC') and sysstat & 0xf = 8) drop trigger dbo.tgInstruccionBC
GO

/****** Localidad ******/
if not exists(select * from SysTabla where SysTabla = 'Localidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Localidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Localidad') and type = 'U') 
CREATE TABLE dbo.Localidad (
	Localidad	varchar(50) 	NOT NULL,

	Direccion 	varchar(100) 	NULL,
	Colonia 	varchar(30)  	NULL,
	CodigoPostal 	varchar(15)  	NULL,
	Poblacion 	varchar(30)  	NULL,
	Estado 		varchar(30)  	NULL,
	Pais		varchar(30)     NULL,
	Telefonos 	varchar(50)  	NULL,
	Responsable	varchar(50)	NULL,
	eMail		varchar(50) 	NULL,

	CONSTRAINT priLocalidad PRIMARY KEY CLUSTERED (Localidad)
)
GO

/****** UnidadConversion ******/
if not exists(select * from SysTabla where SysTabla = 'UnidadConversion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UnidadConversion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UnidadConversion') and type = 'U') 
CREATE TABLE dbo.UnidadConversion (
	Unidad 		varchar(50) 	NOT NULL,
	Conversion	varchar(50) 	NOT NULL,

	CONSTRAINT priUnidadConversion PRIMARY KEY CLUSTERED (Unidad, Conversion)
)
GO

/****** Unidad  ******/
if not exists(select * from SysTabla where SysTabla = 'Unidad')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Unidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Unidad') and type = 'U') 
CREATE TABLE dbo.Unidad (
	Unidad 		varchar(50) 	NOT NULL,
	Factor		float		NULL	DEFAULT 1.0,
	Multiplo	float		NULL    DEFAULT 1.0,
	Decimales	int		NULL	DEFAULT 0,
	Orden		int		NULL,
	AutoAjuste	float		NULL,
	Clave		char(3)		NULL,

	CONSTRAINT priUnidad PRIMARY KEY CLUSTERED (Unidad)
)
GO

EXEC spALTER_TABLE 'Unidad', 'AutoAjuste', 'float NULL'
EXEC spALTER_TABLE 'Unidad', 'Clave', 'char(3) NULL'
 --REQ12534 Factory  
Exec spAlter_Table 'Unidad','INFORDescripcion','varchar(30) Null'
Exec spAlter_Table 'Unidad', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--Integración CRM
EXEC spAlter_Table 'Unidad', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'Unidad', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'
GO

IF OBJECT_ID ('tr_unidad', 'TR') IS NOT NULL DROP TRIGGER tr_unidad
GO									
/*CREATE TRIGGER tr_unidad ON unidad 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update unidad  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Unidad= unidad.Unidad
	END
END
GO*/

-- Aqui va el Matenimiento a la tabla

/********************* tgUnidadBC **********************/
IF OBJECT_ID(N'dbo.tgUnidadBC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgUnidadBC
GO
CREATE TRIGGER tgUnidadBC ON Unidad
--//WITH ENCRYPTION
FOR UPDATE, DELETE, INSERT
AS BEGIN
  DECLARE
    @UnidadN  	varchar(50),
    @UnidadA	varchar(50),
    @Mensaje	varchar(255)

	--DELETE FROM UnidadMES WHERE UnidadMedida IN (SELECT Unidad FROM DELETED)

	--INSERT UnidadMES (UnidadMedida, Descripcion, EstatusIntelIMES)
	--SELECT Unidad, Unidad, 0
	--FROM INSERTED

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @UnidadN = Unidad FROM Inserted
  SELECT @UnidadA = Unidad FROM Deleted
  IF @UnidadN = @UnidadA RETURN

  IF @UnidadN IS NULL AND 
    EXISTS(SELECT * FROM UnidadConversion WHERE Unidad = @UnidadA OR Conversion = @UnidadA)
  BEGIN
    SELECT @Mensaje = '"'+LTRIM(RTRIM(@UnidadA))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30155
    RAISERROR (@Mensaje,16,-1) 
  END ELSE
  IF @UnidadA IS NOT NULL 
  BEGIN
    UPDATE UnidadConversion SET Unidad = @UnidadN WHERE Unidad = @UnidadA
    UPDATE UnidadConversion SET Conversion = @UnidadN WHERE Conversion = @UnidadA
  END
END
GO


--REQ12534 Factory 
if exists (select * from sysobjects where id = object_id('dbo.tgInforUnidadABC')           AND sysstat & 0xf = 8) drop trigger dbo.tgInforUnidadABC
GO
CREATE TRIGGER tgInforUnidadABC ON Unidad
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Unidad    							varchar (50),
   @Estatus							    varchar (10),
   @Datos								varchar(max),
   @Ok									int,
   @OkRef								varchar(255),
   @Id									int,
   @Cinserted		                	int,
   @Cdeleted			                int,
   @Empresa								varchar(20),
   @ReferenciaIntelisisService			varchar(50)
   

  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
  
  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral
   WHERE Empresa = @Empresa
  SELECT @ProdInterfazINFOR = 1
  SELECT @Cinserted = COUNT(*) FROM inserted
  SELECT @Cdeleted  = COUNT(*) FROM deleted
  IF @ProdInterfazINFOR = 1
  BEGIN
    IF @Cinserted <> 0           AND @Cdeleted = 0 
    BEGIN
      SET @Estatus = 'ALTA' 
    END
    IF @Cinserted <> 0           AND @Cdeleted<> 0 
    BEGIN
      SET @Estatus = 'CAMBIO'
    END
    IF @Cinserted = 0           AND @Cdeleted <> 0 
    BEGIN 
      SET @Estatus = 'BAJA'
    END
    IF  @Estatus IN( 'ALTA','CAMBIO')
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Unidad,ReferenciaIntelisisService	
         FROM Inserted
    END
    ELSE
    IF @Estatus = 'BAJA'
    BEGIN
      DECLARE crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT Unidad,ReferenciaIntelisisService	
         FROM Deleted    
    END 
    IF @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
    BEGIN    
      OPEN crActualizar
      FETCH NEXT FROM crActualizar INTO @Unidad ,@ReferenciaIntelisisService		
      WHILE @@FETCH_STATUS = 0 
      BEGIN
        EXEC spInforGenerarSolicitudUnidad @Unidad,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
        FETCH NEXT FROM crActualizar INTO @Unidad,@ReferenciaIntelisisService		 
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar
    END    
  END
END
GO


/****** Causas ******/
if not exists(select * from SysTabla where SysTabla = 'Causa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Causa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Causa') and type = 'U') 
CREATE TABLE dbo.Causa (
	Modulo			char(5)	     NOT NULL,
	Causa	 		varchar(50)  NOT NULL,
	Categoria		varchar(50)  NULL,
	Orden			int	     NULL,

	CONSTRAINT priCausa PRIMARY KEY CLUSTERED (Modulo, Causa)
)
GO

/****** CausaCat ******/
if not exists(select * from SysTabla where SysTabla = 'CausaCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CausaCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CausaCat') and type = 'U') 
CREATE TABLE dbo.CausaCat (
	Categoria 		varchar(50) 	NOT NULL,

	CONSTRAINT priCausaCat PRIMARY KEY CLUSTERED (Categoria)
)
GO

/****** Aduana ******/
if not exists(select * from SysTabla where SysTabla = 'Aduana')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Aduana','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Aduana') and type = 'U') 
CREATE TABLE dbo.Aduana (
	Aduana			varchar(50) 	NOT NULL,

	Seccion			varchar(20)	NULL,
	Denominacion		varchar(255)	NULL,
	GLN			varchar(50)	NULL,
	Ciudad			varchar(50)	NULL,

	CONSTRAINT priAduana PRIMARY KEY CLUSTERED (Aduana)
)
GO
EXEC spALTER_TABLE 'Aduana', 'Seccion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Aduana', 'Denominacion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Aduana', 'GLN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Aduana', 'Ciudad', 'varchar(50) NULL'
GO

/****** Tramite  ******/
if not exists(select * from SysTabla where SysTabla = 'Tramite')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Tramite','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Tramite') and type = 'U') 
CREATE TABLE dbo.Tramite (
	Tramite		varchar(50)	NOT NULL,

	Acreedor	char(10)	NULL,
	Comision	money		NULL,

	CONSTRAINT priTramite PRIMARY KEY  CLUSTERED (Tramite)
)
GO

/****** Nacionalidad ******/
if not exists(select * from SysTabla where SysTabla = 'Nacionalidad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Nacionalidad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Nacionalidad') and type = 'U') 
CREATE TABLE dbo.Nacionalidad (
	Nacionalidad 		varchar(30) 	NOT NULL,

	Orden			int		NULL,
	CONSTRAINT priNacionalidad PRIMARY KEY CLUSTERED (Nacionalidad)
)
GO

/****** ListaNegra ******/
if not exists(select * from SysTabla where SysTabla = 'ListaNegra')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaNegra','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaNegra') and type = 'U') 
CREATE TABLE dbo.ListaNegra (
	Nombre			varchar(100) 	NOT NULL,
	Registro		char(20)	NULL,

	Datos			varchar(255)	NULL,

	CONSTRAINT priListaNegra PRIMARY KEY CLUSTERED (Nombre)
)
GO


/****** ListaPoliticos ******/
if not exists(select * from SysTabla where SysTabla = 'ListaPoliticos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaPoliticos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaPoliticos') and type = 'U') 
CREATE TABLE dbo.ListaPoliticos (
	Nombre			varchar(100) 	NOT NULL,
	Registro		char(20)	NULL,

	Datos			varchar(255)	NULL,

	CONSTRAINT priListaPoliticos PRIMARY KEY CLUSTERED (Nombre)
)
GO

/****** ListaNegraCalle ******/
if not exists(select * from SysTabla where SysTabla = 'ListaNegraCalle')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaNegraCalle','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaNegraCalle') and type = 'U') 
CREATE TABLE dbo.ListaNegraCalle (
	Colonia			varchar(50) 	NOT NULL,
	Calle			varchar(100)	NOT NULL,

	CONSTRAINT priListaNegraCalle PRIMARY KEY CLUSTERED (Colonia, Calle)
)
GO

/****** ListaNegraColonia ******/
if not exists(select * from SysTabla where SysTabla = 'ListaNegraColonia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ListaNegraColonia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ListaNegraColonia') and type = 'U') 
CREATE TABLE dbo.ListaNegraColonia (
	Colonia			varchar(50) 	NOT NULL,

	CONSTRAINT priListaNegraColonia PRIMARY KEY CLUSTERED (Colonia)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgListaNegraColoniaBC') and sysstat & 0xf = 8) drop trigger dbo.tgListaNegraColoniaBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgListaNegraColoniaBC ON ListaNegraColonia
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ColoniaN  	varchar(50),
    @ColoniaA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ColoniaN = Colonia FROM Inserted
  SELECT @ColoniaA = Colonia FROM Deleted
  IF @ColoniaN = @ColoniaA RETURN

  IF @ColoniaN IS NULL 
    DELETE ListaNegraCalle WHERE Colonia = @ColoniaA
  ELSE BEGIN
    UPDATE ListaNegraCalle SET Colonia = @ColoniaN WHERE Colonia = @ColoniaA
  END
END
GO

/****** Idioma ******/
if not exists(select * from SysTabla where SysTabla = 'Idioma')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Idioma','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Idioma') and type = 'U') 
CREATE TABLE dbo.Idioma (
	Idioma 		varchar(50) 	NOT NULL,

	Orden		int		NULL,
	SinAcentos	bit		NULL	DEFAULT 0,
	AutoAgregar	bit		NULL	DEFAULT 0,

	CONSTRAINT priIdioma PRIMARY KEY CLUSTERED (Idioma)
)
GO
EXEC spALTER_TABLE 'Idioma', 'SinAcentos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Idioma', 'AutoAgregar', 'bit NULL DEFAULT 0 WITH VALUES'
GO


/****** Actividad ******/
if not exists(select * from SysTabla where SysTabla = 'Actividad')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Actividad','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Actividad') and type = 'U') 
CREATE TABLE dbo.Actividad (
	Actividad 		varchar(100) 	NOT NULL,
	Grupo			varchar(50) 	NULL,
	Costo			money		NULL,
	ModuloEsp		char(5)		NULL,

	Orden		int		NULL,
	CONSTRAINT priActividad PRIMARY KEY CLUSTERED (Actividad)
)
GO
EXEC spALTER_TABLE 'Actividad', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Actividad', 'Costo', 'money NULL'
EXEC spALTER_TABLE 'Actividad', 'ModuloEsp', 'char(5) NULL'
GO
if (select version from version) <= 2331
BEGIN
  EXEC spEliminarPK 'Actividad'
  ALTER TABLE Actividad ALTER COLUMN Actividad varchar(100) NOT NULL
  ALTER TABLE Actividad ADD CONSTRAINT priActividad PRIMARY KEY CLUSTERED (Actividad)
END
GO

/****** OtrosCargos ******/
if not exists(select * from SysTabla where SysTabla = 'OtrosCargos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('OtrosCargos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.OtrosCargos') and type = 'U') 
CREATE TABLE dbo.OtrosCargos (
	OtrosCargos		varchar(50) 	NOT NULL,

	Articulo		char(20)	NULL,
	Tipo			varchar(20)	NULL,
	Porcentaje		float		NULL,
	Importe			money		NULL,
	Moneda			char(10)	NULL,

	CONSTRAINT priOtrosCargos PRIMARY KEY CLUSTERED (OtrosCargos)
)
GO

/****** Cargo ******/
if not exists(select * from SysTabla where SysTabla = 'Cargo')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Cargo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Cargo') and type = 'U') 
CREATE TABLE dbo.Cargo (
	Cargo		varchar(50) 	NOT NULL,

	CONSTRAINT priCargo PRIMARY KEY  CLUSTERED (Cargo)
)
GO

--Integración CRM
EXEC spAlter_Table 'cargo', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'cargo', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

IF OBJECT_ID ('tr_cargo', 'TR') IS NOT NULL DROP TRIGGER tr_cargo 
GO									
/*CREATE TRIGGER tr_cargo ON cargo 
--//WITH ENCRYPTION	
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update cargo  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.Cargo= cargo.Cargo
	END
END
GO*/

/****** Aseguradora ******/
if not exists(select * from SysTabla where SysTabla = 'Aseguradora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Aseguradora','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Aseguradora') and type = 'U') 
CREATE TABLE dbo.Aseguradora (
	Aseguradora		varchar(50)   	NOT NULL,

	Direccion		varchar(255)	NULL,
	Telefonos		varchar(100)	NULL,

	CONSTRAINT priAseguradora PRIMARY KEY CLUSTERED (Aseguradora)
)
GO
EXEC spALTER_TABLE 'Aseguradora', 'Direccion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Aseguradora', 'Telefonos', 'varchar(100) NULL'
GO

/****** SeguroTipoPolizaEx ******/
if not exists(select * from SysTabla where SysTabla = 'SeguroTipoPolizaEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SeguroTipoPolizaEx','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SeguroTipoPolizaEx') and type = 'U') 
CREATE TABLE dbo.SeguroTipoPolizaEx (
	Tipo		varchar(50)   	NOT NULL,
	Articulo	varchar(20)	NOT NULL,

	CantidadMaxima	float		NULL,
	PrecioMaximo	money		NULL,
	ImporteMaximo	money		NULL,

	CONSTRAINT priSeguroTipoPolizaEx PRIMARY KEY CLUSTERED (Tipo, Articulo)
)
GO
EXEC spALTER_TABLE 'SeguroTipoPolizaEx', 'ImporteMaximo', 'money NULL'
GO

EXEC spFK 'SeguroTipoPolizaEx','Articulo','Art','Articulo'
GO

/****** SeguroTipoPolizaCobertura ******/
if not exists(select * from SysTabla where SysTabla = 'SeguroTipoPolizaCobertura')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SeguroTipoPolizaCobertura','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SeguroTipoPolizaCobertura') and type = 'U') 
CREATE TABLE dbo.SeguroTipoPolizaCobertura (
	Tipo		varchar(50)   	NOT NULL,
	Articulo	varchar(20)	NOT NULL,

	ImporteMaximo	money		NULL,

	CONSTRAINT priSeguroTipoPolizaCobertura PRIMARY KEY CLUSTERED (Tipo, Articulo)
)
GO

EXEC spFK 'SeguroTipoPolizaCobertura','Articulo','Art','Articulo'
GO

/****** SeguroTipoPoliza ******/
if not exists(select * from SysTabla where SysTabla = 'SeguroTipoPoliza')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SeguroTipoPoliza','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SeguroTipoPoliza') and type = 'U') 
CREATE TABLE dbo.SeguroTipoPoliza (
	Tipo		varchar(50)   	NOT NULL,

	CONSTRAINT priSeguroTipoPoliza PRIMARY KEY CLUSTERED (Tipo)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSeguroTipoPolizaBC') and sysstat & 0xf = 8) drop trigger dbo.tgSeguroTipoPolizaBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgSeguroTipoPolizaBC ON SeguroTipoPoliza
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @TipoN  	varchar(50),
    @TipoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @TipoN = Tipo FROM Inserted
  SELECT @TipoA = Tipo FROM Deleted
  IF @TipoN = @TipoA RETURN

  IF @TipoN IS NULL 
  BEGIN
    DELETE SeguroTipoPolizaEx        WHERE Tipo = @TipoA
    DELETE SeguroTipoPolizaCobertura WHERE Tipo = @TipoA
  END ELSE BEGIN
    UPDATE SeguroTipoPolizaEx        SET Tipo = @TipoN WHERE Tipo = @TipoA
    UPDATE SeguroTipoPolizaCobertura SET Tipo = @TipoN WHERE Tipo = @TipoA
  END
END
GO

/****** Religion ******/
if not exists(select * from SysTabla where SysTabla = 'Religion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Religion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Religion') and type = 'U') 
CREATE TABLE dbo.Religion (
	Religion	varchar(50)   	NOT NULL,

	CONSTRAINT priReligion PRIMARY KEY CLUSTERED (Religion)
)
GO


/****** ServicioIdentificador ******/
if not exists(select * from SysTabla where SysTabla = 'ServicioIdentificador')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ServicioIdentificador','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ServicioIdentificador') and type = 'U') 
CREATE TABLE dbo.ServicioIdentificador (
	Identificador	varchar(20)   	NOT NULL,

	CONSTRAINT priServicioIdentificador PRIMARY KEY CLUSTERED (Identificador)
)
GO

/****** Evento ******/
if not exists(select * from SysTabla where SysTabla = 'Evento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Evento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Evento') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Evento (
	ID		int	     	IDENTITY(1,1) NOT NULL,

	Nombre		varchar(100)   	NULL,
	Fecha		datetime	NULL,
	Direccion 	varchar(255) 	NULL,

	CONSTRAINT priEvento PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Evento'
END
GO

/****** EventoD ******/
if not exists(select * from SysTabla where SysTabla = 'EventoD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EventoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EventoD') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EventoD (
	ID		int	     	IDENTITY(1,1) NOT NULL,

	Evento		int		NULL,
	Giro		varchar(100)   	NULL,
	SubGiro		varchar(100)   	NULL,
	Turn		varchar(100)   	NULL,
	SubTurn		varchar(100)   	NULL,

	CONSTRAINT priEventoD PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'EventoD'
END
GO

EXEC spFK 'EventoD','Evento','Evento','ID'
GO

/****** Paises Tratados Comerciales ******/
if not exists(select * from SysTabla where SysTabla = 'TratadoComercialPais')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TratadoComercialPais','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TratadoComercialPais') and type = 'U') 
CREATE TABLE dbo.TratadoComercialPais (
	TratadoComercial	varchar(50) 	NOT NULL,
        Pais			varchar(50) 	NOT NULL,

	CONSTRAINT priTratadoComercialPais PRIMARY KEY CLUSTERED (TratadoComercial, Pais)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TratadoComercialPais' AND sysindexes.name = 'Pais' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Pais ON dbo.TratadoComercialPais (Pais)
GO

/****** Tratados Comerciales ******/
if not exists(select * from SysTabla where SysTabla = 'TratadoComercial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TratadoComercial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TratadoComercial') and type = 'U') 
CREATE TABLE dbo.TratadoComercial (
	TratadoComercial	varchar(50) 	NOT NULL,

	CONSTRAINT priTratadoComercial PRIMARY KEY CLUSTERED (TratadoComercial)
)
GO


/****** Programa Sectorial ******/
if not exists(select * from SysTabla where SysTabla = 'ProgramaSectorial')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ProgramaSectorial','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.ProgramaSectorial') and type = 'U') 
CREATE TABLE dbo.ProgramaSectorial (
	ProgramaSectorial	varchar(50) 	NOT NULL,

	Descripcion		varchar(255)	NULL,

	CONSTRAINT priProgramaSectorial PRIMARY KEY CLUSTERED (ProgramaSectorial)
)
GO

/****** IDImportacion ******/
if not exists(select * from SysTabla where SysTabla = 'IDImportacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IDImportacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.IDImportacion') and type = 'U') 
CREATE TABLE dbo.IDImportacion (
	Clave		char(2) 	NOT NULL,

	Descripcion	varchar(100)	NULL,
	Nivel		varchar(20)	NULL,
	Complemento	varchar(100)	NULL,

	CONSTRAINT priIDImportacion PRIMARY KEY CLUSTERED (Clave)
)
GO



/****** Grado ******/
if not exists(select * from SysTabla where SysTabla = 'Grado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Grado','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Grado') and type = 'U') 
CREATE TABLE dbo.Grado (
	Grado			varchar(10) 	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priGrado PRIMARY KEY CLUSTERED (Grado)
)
GO

/****** Aula ******/
if not exists(select * from SysTabla where SysTabla = 'Aula')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Aula','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Aula') and type = 'U') 
CREATE TABLE dbo.Aula (
	Aula			varchar(10) 	NOT NULL,

	Nombre			varchar(100)	NULL,

	CONSTRAINT priAula PRIMARY KEY CLUSTERED (Aula)
)
GO

/****** Materia ******/
if not exists(select * from SysTabla where SysTabla = 'Materia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Materia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Materia') and type = 'U') 
CREATE TABLE dbo.Materia (
	Materia			varchar(20) 	NOT NULL,

	Nombre			varchar(100)	NULL,
	Curso			varchar(50)	NULL,

	CONSTRAINT priMateria PRIMARY KEY CLUSTERED (Materia)
)
GO


/****** DiasEspD ******/
if not exists(select * from SysTabla where SysTabla = 'DiasEspD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DiasEspD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DiasEspD') and type = 'U') 
CREATE TABLE dbo.DiasEspD (
	DiasEsp			varchar(50) 	NOT NULL,
	Dia			varchar(20)	NOT NULL,	-- 1..31, Domingo, Lunes, Sabado, Quincena, Fin Mes

	CONSTRAINT priDiasEspD PRIMARY KEY CLUSTERED (DiasEsp, Dia)
)
GO

-- drop table DiasEsp
/****** DiasEsp ******/
if not exists(select * from SysTabla where SysTabla = 'DiasEsp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DiasEsp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DiasEsp') and type = 'U') 
CREATE TABLE dbo.DiasEsp (
	DiasEsp			varchar(50) 	NOT NULL,

	CONSTRAINT priDiasEsp PRIMARY KEY CLUSTERED (DiasEsp)
)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgDiasEspBC') and sysstat & 0xf = 8) drop trigger dbo.tgDiasEspBC
GO
CREATE TRIGGER tgDiasEspBC ON DiasEsp
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @DiasEspN		varchar(50),
    @DiasEspA		varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @DiasEspN = DiasEsp FROM Inserted
  SELECT @DiasEspA = DiasEsp FROM Deleted
  IF @DiasEspN = @DiasEspA RETURN

  IF @DiasEspN IS NULL 
  BEGIN
    DELETE DiasEspD WHERE DiasEsp = @DiasEspA
  END ELSE
  IF @DiasEspA IS NOT NULL 
  BEGIN
    UPDATE DiasEspD SET DiasEsp = @DiasEspN WHERE DiasEsp = @DiasEspA
  END
END
GO


/*******************************************************************************************/
/*                             DIRECCIONES FISCALES SAT                                    */
/*******************************************************************************************/
EXEC spALTER_COLUMN 'Sucursal', 'Colonia', 'varchar(100) NULL'
EXEC spALTER_COLUMN 'Empresa', 'Colonia', 'varchar(100) NULL'
GO
EXEC spALTER_TABLE 'Venta', 'Posicion', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'CteCFD', 'NumRegIdTrib', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Condicion', 'DiferirFechaAcumulacion', 'bit NULL default 0'
EXEC spALTER_TABLE 'TipoImpuesto', 'Clave', 'varchar(5)'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'FracccionArancelaria', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PesoBruto', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'UnidadAduana', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'CantidadAduana', 'float NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'FracccionArancelaria2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'PesoBruto2', 'float NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'UnidadAduana2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'CantidadAduana2', 'float NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'Clave', 'varchar(21) NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'Clave2', 'varchar(21) NULL'
GO
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribOFP', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribEfectivo', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ContribTotal', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'Contraprestacion', 'money NULL'
EXEC spALTER_TABLE 'SerieLoteProp', 'ImporteTotal', 'money NULL'
GO
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribOFP', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribEfectivo', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ContribTotal', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'Contraprestacion', 'money NULL'
EXEC spALTER_COLUMN 'SerieLoteProp', 'ImporteTotal', 'money NULL'
GO
EXEC spALTER_TABLE 'CteEnviarA', 'TipoProceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'TipoComite', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'IdContabilidad', 'varchar(6) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'ClaveEntidad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Ambito', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'EntidadIdContabilidad', 'varchar(6) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'FormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteEnviarA', 'Cuenta', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'CteCFD', 'TipoComplemento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'TipoProceso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'TipoComite', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'IdContabilidad', 'varchar(6) NULL'
EXEC spALTER_TABLE 'CteCFD', 'ClaveEntidad', 'varchar(10) NULL'
EXEC spALTER_TABLE 'CteCFD', 'Ambito', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CteCFD', 'EntidadIdContabilidad', 'varchar(6) NULL'
GO
EXEC spALTER_TABLE  'Empresa', 'TipoOperacion',             'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'ClavePedimento',            'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'CertificadoOrigen',         'varchar(100) NULL'
EXEC spALTER_TABLE  'Empresa', 'NumCertificadoOrigen',      'varchar(50)  NULL'
EXEC spALTER_TABLE  'Empresa', 'NumeroExportadorConfiable', 'varchar(50)  NULL'
GO
EXEC spALTER_TABLE  'FormaPago', 'ClaveSAT', 'varchar(10) NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.SATColonia') and type = 'U') DROP TABLE SATColonia
GO
if exists (select * from sysobjects where id = object_id('dbo.SATColoniaHist') and type = 'U') DROP TABLE SATColoniaHist
GO
if exists (select * from sysobjects where id = object_id('dbo.SATLocalidad') and type = 'U') DROP TABLE SATLocalidad
GO
if exists (select * from sysobjects where id = object_id('dbo.SATLocalidadHist') and type = 'U') DROP TABLE SATLocalidadHist
GO
if exists (select * from sysobjects where id = object_id('dbo.SATMunicipio') and type = 'U') DROP TABLE SATMunicipio
GO
if exists (select * from sysobjects where id = object_id('dbo.SATMunicipioHist') and type = 'U') DROP TABLE SATMunicipioHist
GO
if exists (select * from sysobjects where id = object_id('dbo.SATEstado') and type = 'U') DROP TABLE SATEstado
GO
if exists (select * from sysobjects where id = object_id('dbo.SATEstadoHist') and type = 'U') DROP TABLE SATEstadoHist
GO
if exists (select * from sysobjects where id = object_id('dbo.SATPais') and type = 'U') DROP TABLE SATPais
GO
if exists (select * from sysobjects where id = object_id('dbo.SATPaisHist') and type = 'U') DROP TABLE SATPaisHist
GO
if exists (select * from sysobjects where id = object_id('dbo.SATCatCP') and type = 'U') DROP TABLE SATCatCP
GO
if exists (select * from sysobjects where id = object_id('dbo.SATCatCPHist') and type = 'U') DROP TABLE SATCatCPHist
GO

/****** SATColonia ******/
if not exists(select * from SysTabla where SysTabla = 'SATColonia')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATColonia', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATColonia') and type = 'U') 
CREATE TABLE dbo.SATColonia(
    ClaveColonia  varchar(4)   NOT NULL,
    ClaveCP       varchar(5)   NOT NULL,
    Descripcion   varchar(255) NULL,

    CONSTRAINT priSATColonia PRIMARY KEY CLUSTERED(ClaveColonia, ClaveCP)
)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SATColonia' AND sysindexes.name = 'ClaveCP' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ClaveCP ON dbo.SATColonia (ClaveCP, ClaveColonia, Descripcion) ON [PRIMARY]  
GO

/****** SATColoniaHist ******/
if exists(select * from SysTabla where SysTabla = 'SATColoniaHist') DELETE FROM SysTabla WHERE SysTabla = 'SATColoniaHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATColoniaHist') and type = 'U') DROP TABLE dbo.SATColoniaHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATColoniaAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATColoniaAC
GO


/****** SATLocalidad ******/
if not exists(select * from SysTabla where SysTabla = 'SATLocalidad')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATLocalidad', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATLocalidad') and type = 'U') 
CREATE TABLE SATLocalidad(
    ClaveLocalidad varchar(2)   NOT NULL,
    ClaveEstado    varchar(3)   NOT NULL,
    Descripcion    varchar(255) NULL,

    CONSTRAINT priSATLocalidad PRIMARY KEY CLUSTERED(ClaveLocalidad, ClaveEstado)
)
GO


/****** SATLocalidadHist ******/
if exists(select * from SysTabla where SysTabla = 'SATLocalidadHist') DELETE FROM SysTabla WHERE SysTabla = 'SATLocalidadHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATLocalidadHist') and type = 'U') DROP TABLE dbo.SATLocalidadHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATLocalidadAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATLocalidadAC
GO

/****** SATMunicipio ******/
if not exists(select * from SysTabla where SysTabla = 'SATMunicipio')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATMunicipio', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATMunicipio') and type = 'U') 
CREATE TABLE SATMunicipio(
    ClaveMunicipio varchar(3)   NOT NULL,
    ClaveEstado    varchar(3)   NOT NULL,
    Descripcion    varchar(255) NULL,

    CONSTRAINT priSATMunicipio PRIMARY KEY CLUSTERED(ClaveMunicipio, ClaveEstado)
)
GO


/****** SATMunicipioHist ******/
if exists(select * from SysTabla where SysTabla = 'SATMunicipioHist') DELETE FROM SysTabla WHERE SysTabla = 'SATMunicipioHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATMunicipioHist') and type = 'U') DROP TABLE dbo.SATMunicipioHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATMunicipioAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATMunicipioAC
GO

/****** SATEstado ******/
if not exists(select * from SysTabla where SysTabla = 'SATEstado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATEstado', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATEstado') and type = 'U') 
CREATE TABLE SATEstado(
    ClaveEstado varchar(3)   NOT NULL,
    ClavePais   varchar(3)   NOT NULL,
    Descripcion varchar(255) NULL,

    CONSTRAINT priSATEstado PRIMARY KEY CLUSTERED(ClaveEstado, ClavePais)
)
GO


/****** SATEstadoHist ******/
if exists(select * from SysTabla where SysTabla = 'SATEstadoHist') DELETE FROM SysTabla WHERE SysTabla = 'SATEstadoHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATEstadoHist') and type = 'U') DROP TABLE dbo.SATEstadoHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATEstadoAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATEstadoAC
GO

/****** SATPais ******/
if not exists(select * from SysTabla where SysTabla = 'SATPais')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATPais', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATPais') and type = 'U')
CREATE TABLE SATPais(
    ClavePais     varchar(3)   NOT NULL,
    Descripcion   varchar(30) NULL,
    FormatoCP     varchar(255) NULL,
    FormatoRIT    varchar(255) NULL,
    ValidacionRIT varchar(255) NULL,

    CONSTRAINT priSATPais PRIMARY KEY CLUSTERED(ClavePais)
)
GO
EXEC spALTER_COLUMN 'SATPais', 'Descripcion', 'varchar(30) NULL'
GO

/****** SATPaisHist ******/
if exists(select * from SysTabla where SysTabla = 'SATPaisHist') DELETE FROM SysTabla WHERE SysTabla = 'SATPaisHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATPaisHist') and type = 'U') DROP TABLE dbo.SATPaisHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATPaisAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATPaisAC
GO


/****** SATCatCP ******/
if not exists(select * from SysTabla where SysTabla = 'SATCatCP')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATCatCP', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATCatCP') and type = 'U')
CREATE TABLE SATCatCP(
    ID                        int		   NOT NULL IDENTITY(1,1),
    ClaveCP                   varchar(5)   NULL,
    ClaveEstado               varchar(3)   NULL,
    ClaveMunicipio            varchar(3)   NULL,
    ClaveLocalidad            varchar(2)   NULL,
    HusoHorario               varchar(2)   NULL,
	Descripcion               varchar(255) NULL,
    VeranoMesInicio	          varchar(10)  NULL,
	VeranoDiaInicio	          varchar(50)  NULL,
	VeranoHoraInicio	      varchar(5)   NULL,
	VeranoDiferenciaHoraria	  varchar(2)   NULL,
	InviernoMesInicio	      varchar(10)  NULL,
	InviernoDiaInicio	      varchar(50)  NULL,
	InviernoHoraInicio	      varchar(5)   NULL,
	InviernoDiferenciaHoraria varchar(2)   NULL,

    CONSTRAINT priSATCP PRIMARY KEY CLUSTERED(ID)
)
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'SATCatCP' AND sysindexes.name = 'ClaveEstado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ClaveEstado ON dbo.SATCatCP (ClaveEstado, ClaveMunicipio, ClaveCP) ON [PRIMARY]
GO

/****** SATCatCPHist ******/
if exists(select * from SysTabla where SysTabla = 'SATCatCPHist') DELETE FROM SysTabla WHERE SysTabla = 'SATCatCPHist' AND Tipo = 'Maestro'
if exists (select * from sysobjects where id = object_id('dbo.SATCatCPHist') and type = 'U') DROP TABLE dbo.SATCatCPHist 
GO
if exists (select * from sysobjects where id = object_id('dbo.tgSATCatCPAC') and sysstat & 0xf = 8) drop trigger dbo.tgSATCatCPAC
GO


/****** SATUnidadAduana ******/
if not exists(select * from SysTabla where SysTabla = 'SATUnidadAduana')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATUnidadAduana', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATUnidadAduana') and type = 'U')
CREATE TABLE SATUnidadAduana(
    Clave	       varchar(2)   NOT NULL,
	Descripcion    varchar(255) NULL,

    CONSTRAINT priSATUnidadAduana PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** SATFraccionArancelaria ******/
if not exists(select * from SysTabla where SysTabla = 'SATFraccionArancelaria')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATFraccionArancelaria', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATFraccionArancelaria') and type = 'U')
CREATE TABLE SATFraccionArancelaria(
    Clave	       varchar(20)   NOT NULL,
	Descripcion    varchar(8000) NULL,
	UnidadMedida   varchar(50)   NULL,
	Importacion    varchar(10)   NULL,
	Exportacion    varchar(10)   NULL,

    CONSTRAINT priSATFraccionArancelaria PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** SATTipoImpuesto ******/
if not exists(select * from SysTabla where SysTabla = 'SATTipoImpuesto')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATTipoImpuesto', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATTipoImpuesto') and type = 'U')
CREATE TABLE SATTipoImpuesto(
    Clave	       varchar(20)   NOT NULL,
	Descripcion    varchar(8000)  NULL,

    CONSTRAINT priSATTipoImpuesto PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** SATMetodoPago ******/
if not exists(select * from SysTabla where SysTabla = 'SATMetodoPago')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATMetodoPago', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATMetodoPago') and type = 'U')
CREATE TABLE SATMetodoPago(
    Clave      varchar(100) NOT NULL,

    CONSTRAINT priSATMetodoPago PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** SATMoneda ******/
if not exists(select * from SysTabla where SysTabla = 'SATMoneda')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATMoneda', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATMoneda') and type = 'U')
CREATE TABLE SATMoneda(
    Clave       varchar(3)   NOT NULL,
	Descripcion varchar(255) NULL,
	Decimales   int          NULL

    CONSTRAINT priSATMoneda PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** Nómina *************/
/****** SATTipoNomina ******/
if not exists(select * from SysTabla where SysTabla = 'SATTipoNomina')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATTipoNomina', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATTipoNomina') and type = 'U')
CREATE TABLE SATTipoNomina(
    Clave	       varchar(5)   NOT NULL,
	Descripcion    varchar(8000)  NULL,

    CONSTRAINT priSATTipoNomina PRIMARY KEY CLUSTERED(Clave)
)
GO


/****** VentaCFDIRelacionado ******/
if not exists(select * from SysTabla where SysTabla = 'VentaCFDIRelacionado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaCFDIRelacionado', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.VentaCFDIRelacionado') and type = 'U')
CREATE TABLE VentaCFDIRelacionado(
     ID               int   NOT NULL,
     CFDIAplica       varchar(20) NULL,
     CFDIAplicaID     varchar(20) NULL,
     CFDIAplicaUUID   varchar(50) NULL,
	 TipoOperacion             varchar(100) NULL,
	 ClavePedimento            varchar(100) NULL,
	 CertificadoOrigen         varchar(100) NULL,
	 NumCertificadoOrigen      varchar(50)  NULL,
	 NumeroExportadorConfiable varchar(50)  NULL,
	 Incoterm                  varchar(20)  NULL,
	 Subdivision               varchar(100) NULL,
	 Destinatario              varchar(10)  NULL,
    CONSTRAINT priVentaCFDIRelacionado PRIMARY KEY CLUSTERED(ID)
)
GO
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'TipoOperacion',             'varchar(100) NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'ClavePedimento',            'varchar(100) NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'CertificadoOrigen',         'varchar(100) NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'NumCertificadoOrigen',      'varchar(50)  NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'NumeroExportadorConfiable', 'varchar(50)  NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'Incoterm',                  'varchar(20)  NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'Subdivision',               'varchar(100) NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'Destinatario',              'varchar(10)  NULL'
EXEC spALTER_TABLE  'VentaCFDIRelacionado', 'MotivoTraslado',			 'varchar(2)  NULL'
GO

/****** SATIncoterm ******/
if not exists (select * from SysTabla where SysTabla = 'SATIncoterm') 
INSERT INTO SysTabla (SysTabla) VALUES ('SATIncoterm')
if not exists (select * from sysobjects where id = object_id('dbo.SATIncoterm') and type = 'U') 
CREATE TABLE SATIncoterm(
 Clave        varchar(20),
 Descripcion  varchar(100) NULL,
 
 CONSTRAINT priSATIncoterm PRIMARY KEY(Clave)
)
GO
DELETE FROM SATIncoterm
GO
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'CFR', 'COSTE Y FLETE (PUERTO DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'CIF', 'COSTE, SEGURO Y FLETE (PUERTO DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'CPT', 'TRANSPORTE PAGADO HASTA (EL LUGAR DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'CIP', 'TRANSPORTE Y SEGURO PAGADOS HASTA (LUGAR DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DAF', 'ENTREGADA EN FRONTERA (LUGAR CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DAP', 'ENTREGADA EN LUGAR.'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DAT', 'ENTREGADA EN TERMINAL.'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DES', 'ENTREGADA SOBRE BUQUE (PUERTO DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DEQ', 'ENTREGADA EN MUELLE (PUERTO DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DDU', 'ENTREGADA DERECHOS NO PAGADOS (LUGAR DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'DDP', 'ENTREGADA DERECHOS PAGADOS (LUGAR DE DESTINO CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'EXW', 'EN FABRICA (LUGAR CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'FCA', 'FRANCO TRANSPORTISTA (LUGAR DESIGNADO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'FAS', 'FRANCO AL COSTADO DEL BUQUE (PUERTO DE CARGA CONVENIDO).'
INSERT INTO SATIncoterm(Clave, Descripcion) SELECT 'FOB', 'FRANCO A BORDO (PUERTO DE CARGA CONVENIDO).'
GO

/****** SATClavePedimento ******/
if not exists (select * from SysTabla where SysTabla = 'SATClavePedimento') 
INSERT INTO SysTabla (SysTabla) VALUES ('SATClavePedimento')
if not exists (select * from sysobjects where id = object_id('dbo.SATClavePedimento') and type = 'U') 
CREATE TABLE SATClavePedimento(
 Clave        varchar(20),
 Descripcion  varchar(100) NULL,
 
 CONSTRAINT priSATClavePedimento PRIMARY KEY(Clave)
)
GO
DELETE FROM SATClavePedimento
GO
INSERT INTO SATClavePedimento(Clave, Descripcion) SELECT 'A1', 'Importación o Exportación definitiva'
GO

/****** SATTipoOperacion ******/
if not exists (select * from SysTabla where SysTabla = 'SATTipoOperacion') 
INSERT INTO SysTabla (SysTabla) VALUES ('SATTipoOperacion')
if not exists (select * from sysobjects where id = object_id('dbo.SATTipoOperacion') and type = 'U') 
CREATE TABLE SATTipoOperacion(
 Clave        varchar(20),
 Descripcion  varchar(100) NULL,
 
 CONSTRAINT priSATTipoOperacion PRIMARY KEY(Clave)
)
GO
DELETE FROM SATTipoOperacion
GO
INSERT INTO SATTipoOperacion(Clave, Descripcion) SELECT 'A', 'Exportación de Servicios'
INSERT INTO SATTipoOperacion(Clave, Descripcion) SELECT '2', 'Exportación'
GO

/****** SATCertificadoOrigen ******/
if not exists (select * from SysTabla where SysTabla = 'SATCertificadoOrigen') 
INSERT INTO SysTabla (SysTabla) VALUES ('SATCertificadoOrigen')
if not exists (select * from sysobjects where id = object_id('dbo.SATCertificadoOrigen') and type = 'U') 
CREATE TABLE SATCertificadoOrigen(
 TratadoAcuerdo            varchar(50),
 TipoCertificado           varchar(50)  NULL,
 NumCertificado            varchar(50)  NULL,
 NumeroExportadorConfiable varchar(50)  NULL,
 CONSTRAINT priSATCertificadoOrigen PRIMARY KEY(TratadoAcuerdo)
)
GO

/****** SATArticuloInfo ******/
if not exists (select * from SysTabla where SysTabla = 'SATArticuloInfo') 
INSERT INTO SysTabla (SysTabla) VALUES ('SATArticuloInfo')
if not exists (select * from sysobjects where id = object_id('dbo.SATArticuloInfo') and type = 'U') 
CREATE TABLE SATArticuloInfo(
 Articulo              varchar(20),
 FraccionArancelaria   varchar(20) NULL,
 Marca                 varchar(50) NULL,
 Modelo                varchar(50) NULL,
 SubModelo             varchar(50) NULL,
 CONSTRAINT priSATArticuloInfo PRIMARY KEY(Articulo)
)
GO

/****** SATFormaPago ******/
if not exists(select * from SysTabla where SysTabla = 'SATFormaPago')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATFormaPago', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATFormaPago') and type = 'U')
CREATE TABLE SATFormaPago(
    Clave       varchar(10)  NOT NULL,
	Descripcion varchar(255) NULL
    CONSTRAINT priSATFormaPago PRIMARY KEY CLUSTERED(Clave)
)
GO

DELETE FROM SATFormaPago
GO
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '01', 'Efectivo'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '02', 'Cheque nominativo'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '03', 'Transferencia electrónica de fondos'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '04', 'Tarjetas de crédito'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '05', 'Monederos Electrónico'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '06', 'Dinero electrónico'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '08', 'Vales de despensa'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '28', 'Tarjeta de Débito'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '29', 'Tarjeta de Servicio'
INSERT INTO SATFormaPago(Clave, Descripcion) SELECT '99', 'Otros'
GO

/****** SATCatMotivoTraslado ******/
if not exists(select * from SysTabla where SysTabla = 'SATCatMotivoTraslado')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SATCatMotivoTraslado', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SATCatMotivoTraslado') and type = 'U') 
CREATE TABLE dbo.SATCatMotivoTraslado(
	Clave			varchar(4)		NOT NULL,
    Descripcion		varchar(255)	NULL,
    CONSTRAINT priSATCatMotivoTraslado PRIMARY KEY CLUSTERED(Clave)
)
GO