SET DATEFIRST 7
SET ANSI_NULLS OFF
SET ANSI_WARNINGS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT-1
SET QUOTED_IDENTIFIER OFF
SET NOCOUNT ON
GO

/**************************************************************/
/********************* CREACIÓN DE TABLAS *********************/
/**************************************************************/

/********************* TipoArticuloMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'TipoArticuloMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TipoArticuloMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'TipoArticuloMES' AND TYPE = 'u')
	CREATE TABLE dbo.TipoArticuloMES(
		Codigo              INT               NOT NULL,
		Descripcion         VARCHAR(020)      NOT NULL,
	  CONSTRAINT priTipoArticuloMES PRIMARY KEY CLUSTERED (Codigo ASC)
	) 

GO

/********************* AcumMESU **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'AcumMESU')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AcumMESU', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'AcumMESU' AND TYPE = 'u')
	CREATE TABLE dbo.AcumMESU(
		Sucursal            INT               NOT NULL DEFAULT 0,
		Empresa             VARCHAR(05)       NOT NULL,
		Rama                VARCHAR(05)       NOT NULL,
		Ejercicio           INT               NOT NULL,
		Periodo             INT               NOT NULL,
		Moneda              VARCHAR(10)       NOT NULL,
		Grupo               VARCHAR(10)       NOT NULL,
		SubGrupo            VARCHAR(20)       NOT NULL,
		Cuenta              VARCHAR(20)       NOT NULL,
		SubCuenta           VARCHAR(50)       NOT NULL,
		Cargos              MONEY                 NULL,
		Abonos              MONEY                 NULL,
		CargosU             FLOAT                 NULL,
		AbonosU             FLOAT                 NULL,
		UltimoCambio        DATETIME              NULL,
		Procesado           BIT               NOT NULL DEFAULT 0,
		EstatusIntelIMES    INT                   NULL,
	  CONSTRAINT priAcumMESU PRIMARY KEY CLUSTERED (Cuenta    ASC, SubCuenta ASC, Grupo  ASC, SubGrupo ASC, Rama    ASC, 
												   Ejercicio ASC, Periodo   ASC, Moneda ASC, Sucursal ASC, Empresa ASC)
	)
GO 

/********************* AlmMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'AlmMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AlmMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'AlmMES' AND TYPE = 'u')
	CREATE TABLE dbo.AlmMES(
		CodigoAlmacen       VARCHAR(010)	  NOT NULL,
		RazonSocial         VARCHAR(100)	  NOT NULL,
		NombreComercial     VARCHAR(100)		  NULL,
		Direccion1          VARCHAR(100)          NULL,
		Direccion2          VARCHAR(100)          NULL,
		Poblacion           VARCHAR(100)          NULL,
		Provincia           VARCHAR(030)          NULL,
		CodigoPostal        VARCHAR(015)          NULL, 
		Pais                VARCHAR(030)          NULL,
		Idioma              VARCHAR(050)          NULL,
		Sucursal			INT			      NOT NULL DEFAULT 0,	 
		EstatusIntelIMES    INT                   NULL,
	  CONSTRAINT priAlmMES PRIMARY KEY CLUSTERED (CodigoAlmacen ASC)
	) 
GO

EXEC spALTER_TABLE 'AlmMES', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
GO

/********************* ArtFamMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ArtFamMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ArtFamMes', 'N/A')
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME = 'ArtFamMes' AND TYPE = 'u') -- DROP TABLE ArtFamMes
	CREATE TABLE dbo.ArtFamMes(
		Clave               VARCHAR(4)  NOT NULL,
		Descripcion         VARCHAR(50) NOT NULL,
		EstatusIntelIMES    INT         NULL,
	  CONSTRAINT priArtFamMes PRIMARY KEY CLUSTERED (Clave)
	)
GO

EXEC spALTER_TABLE 'ArtFamMes', 'EstatusIntelIMES', 'int NULL'
GO

/********************* ArtSubFamMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ArtSubFamMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ArtSubFamMes', 'N/A')
IF NOT EXISTS(SELECT * FROM sysobjects WHERE NAME = 'ArtSubFamMes' AND TYPE = 'u') -- DROP TABLE ArtSubFamMes
	CREATE TABLE dbo.ArtSubFamMes(
		Clave               VARCHAR(4)  NOT NULL,
		Descripcion         VARCHAR(50) NOT NULL,
		EstatusIntelIMES    INT         NULL,
	  CONSTRAINT priArtSubFamMes PRIMARY KEY CLUSTERED (Clave)
	) 
GO

EXEC spALTER_TABLE 'ArtSubFamMes', 'EstatusIntelIMES', 'int NULL'
GO

/********************* ArtMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ArtMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ArtMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ArtMES' AND TYPE = 'u')
	CREATE TABLE dbo.ArtMES(
		Articulo            VARCHAR(20)       NOT NULL,
		Descripcion1        VARCHAR(100)          NULL,
		Descripcion2        VARCHAR(255)          NULL,
		Categoria           VARCHAR(50)           NULL,
		Inventariable       VARCHAR(01)           NULL,
		Almacen             VARCHAR(10)           NULL,
		Ubicacion           VARCHAR(20)           NULL,
		UnidadAlmacen       VARCHAR(50)           NULL,
		UnidadCompra        VARCHAR(50)           NULL,
		UnidadVenta         VARCHAR(50)           NULL,
		CostoEstandar       FLOAT                 NULL,
		Impuesto1           FLOAT             NOT NULL,
		TipoCosteo          VARCHAR(10)           NULL,
		PrecioLista         MONEY                 NULL,
		Estatus             VARCHAR(15)       NOT NULL,
		Cuenta              VARCHAR(20)           NULL,
		Familia				VARCHAR(50)			  NULL,
		SubFamilia			VARCHAR(50)			  NULL,
		SMR					INT                   NULL,
		MOE					FLOAT				  NULL DEFAULT 0,
		FactorConversion	FLOAT				  NULL DEFAULT 0,
		MinimoCompra		FLOAT				  NULL DEFAULT 0,
		StockMinimo			FLOAT				  NULL DEFAULT 0,
		StockMaximo			FLOAT				  NULL DEFAULT 0,
		Proveedor			VARCHAR(10)           NULL,
		TiempoEntrega		INT                   NULL,
		TiempoEntregaSeg	INT                   NULL,
		EstatusIntelIMES    INT                   NULL,
	  CONSTRAINT priArtMES PRIMARY KEY CLUSTERED (Articulo ASC)
	)
GO

EXEC spALTER_TABLE 'ArtMES', 'Familia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtMES', 'SubFamilia', 'varchar(50) NULL'
EXEC spALTER_TABLE 'ArtMES', 'SMR', 'int NULL'
EXEC spALTER_TABLE 'ArtMES', 'MOE', 'float NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtMES', 'FactorConversion', 'float NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtMES', 'MinimoCompra', 'float NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtMES', 'StockMinimo', 'float NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtMES', 'StockMaximo', 'float NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'ArtMes', 'TipoArticulo', 'int NULL'
EXEC spALTER_TABLE 'ArtMES', 'Proveedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ArtMES', 'TiempoEntrega', 'int NULL'
EXEC spALTER_TABLE 'ArtMES', 'TiempoEntregaSeg', 'int NULL'
GO

/********************* AuxiliarMESU **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'AuxiliarMESU')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AuxiliarMESU', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'AuxiliarMESU' AND TYPE = 'u')
	CREATE TABLE dbo.AuxiliarMESU(
		ID                  INT IDENTITY(1,1) NOT NULL,
		Empresa             VARCHAR(05)       NOT NULL,
		Rama                VARCHAR(05)       NOT NULL,
		Mov                 VARCHAR(20)       NOT NULL,
		MovID               VARCHAR(20)       NOT NULL,
		Modulo              VARCHAR(05)           NULL,
		ModuloID            INT                   NULL,
		Moneda              VARCHAR(10)           NULL,
		TipoCambio          FLOAT                 NULL,
		Grupo               VARCHAR(10)           NULL,
		SubGrupo            VARCHAR(20)           NULL,
		Cuenta              VARCHAR(20)           NULL,
		SubCuenta           VARCHAR(50)           NULL,
		Ejercicio           INT                   NULL,
		Periodo             INT                   NULL,
		Fecha               DATETIME              NULL,
		Cargo               MONEY                 NULL,
		Abono               MONEY                 NULL,
		CargoU              FLOAT                 NULL,
		AbonoU              FLOAT                 NULL,
		Aplica              VARCHAR(20)           NULL,
		AplicaID            VARCHAR(20)           NULL,
		Acumulado           BIT               NOT NULL DEFAULT 0,
		Conciliado          BIT               NOT NULL DEFAULT 0,
		EsCancelacion       BIT               NOT NULL DEFAULT 0,
		FechaConciliacion   DATETIME              NULL,
		Sucursal            INT               NOT NULL DEFAULT 0,
		Renglon             FLOAT                 NULL,
		RenglonSub          INT                   NULL,
		Procesado           BIT               NOT NULL DEFAULT 0,
		ModuloID2			INT                   NULL,
		Direccion			AS CASE WHEN ISNULL(CargoU,0) <> 0 THEN 'E' ELSE 'S' END,
		EstatusIntelIMES    INT                   NULL,
	  CONSTRAINT priAuxiliarMESU PRIMARY KEY CLUSTERED (ID ASC)
	) 
GO

EXEC spALTER_TABLE 'AuxiliarMesU', 'ModuloID2', 'int NULL'
EXEC spALTER_TABLE 'AuxiliarMESU', 'Direccion', 'AS CASE WHEN ISNULL(CargoU,0) <> 0 THEN "E" ELSE "S" END'
GO

/********************* CompraMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CompraMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompraMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CompraMES' AND TYPE = 'u')
	CREATE TABLE dbo.CompraMES(
		ID                  INT                NOT NULL,
		Serie               VARCHAR(020)       NOT NULL,
		NumerodePedido      VARCHAR(020)           NULL,
		Proveedor           VARCHAR(10)            NULL,
		FechaEmision        DATETIME               NULL,
		FechaRequerida      DATETIME               NULL,
		Referencia          VARCHAR(50)            NULL,
		Condicion           VARCHAR(50)            NULL,
		Concepto            VARCHAR(50)            NULL,
		DiaPago1            VARCHAR(010)           NULL,
		DiaPago2            VARCHAR(010)           NULL,
		DiaPago3            VARCHAR(010)           NULL,
		PorcIVA             FLOAT                  NULL,
		Moneda              VARCHAR(010)       NOT NULL,
		Anulado				INT                    NULL,
		TipoPropuestaPedido	VARCHAR(50)            NULL,
		ModuloID			INT                    NULL,
		Entrada				BIT				   NOT NULL DEFAULT 0,
		Cancelado			BIT				   NOT NULL DEFAULT 0,
		Sucursal			INT                NOT NULL DEFAULT 0,
		Lanzamiento			VARCHAR(100)           NULL,
		Proyecto			VARCHAR(50)            NULL,
		SubProyecto			VARCHAR(50)            NULL,
		EstatusIntelIMES    INT                    NULL,
	  CONSTRAINT priCompraMES PRIMARY KEY CLUSTERED (ID ASC)
	)
GO

EXEC spALTER_TABLE 'CompraMes', 'Anulado', 'integer NULL'
EXEC spALTER_TABLE 'CompraMes', 'TipoPropuestaPedido', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraMES', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'CompraMES', 'Entrada', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CompraMES', 'Cancelado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CompraMES', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CompraMES', 'Lanzamiento', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CompraMES', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraMES', 'SubProyecto', 'varchar(50) NULL'
GO

/********************* CompraDMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CompraDMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CompraDMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CompraDMES' AND TYPE = 'u')
	CREATE TABLE dbo.CompraDMES(
		ID                     INT                NOT NULL,
		Renglon                FLOAT              NOT NULL,
		Serie                  VARCHAR(020)       NOT NULL,
		NumerodePedido         VARCHAR(020)           NULL,   
		Articulo               VARCHAR(20)            NULL,
		Almacen                VARCHAR(20)            NULL,
		FechaEntrega           DATETIME               NULL,
		FechaRequerida         DATETIME               NULL,
		FechaConfirmada        DATETIME               NULL,
		Cantidad               FLOAT                  NULL,
		CantidadRecibida       FLOAT                  NULL,
		CantidadPendiente      FLOAT                  NULL,
		Precio                 FLOAT                  NULL,
		PorcIVA                FLOAT                  NULL,
		SuReferencia           VARCHAR(20)            NULL,
		UnidadPedida           VARCHAR(50)            NULL,
		UnidadPrecio           FLOAT                  NULL,
		Proyecto			   VARCHAR(50)            NULL,
		SubProyecto			   VARCHAR(50)            NULL,
		SubCuenta			   VARCHAR(50)            NULL,
		Lanzamiento			   VARCHAR(100)           NULL,
		OrdenProduccion		   VARCHAR(100)           NULL,
		ModuloID			   INT                    NULL,
		UnidConverCompra	   FLOAT                  NULL,
		EstatusIntelIMES       INT                    NULL,
	  CONSTRAINT priCompraDMES PRIMARY KEY CLUSTERED (ID ASC, Renglon ASC)
	)
GO

EXEC spALTER_TABLE 'CompraDMes', 'Anulado', 'integer NULL'
EXEC spALTER_TABLE 'CompraDMes', 'TipoPropuestaPedido', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'SubProyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'Lanzamiento', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'OrdenProduccion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'CompraDMES', 'ModuloID', 'int NULL'
EXEC spALTER_TABLE 'CompraDMES', 'UnidConverCompra', 'float NULL'
GO

/********************* CteMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CteMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CteMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CteMES' AND TYPE = 'u')
	CREATE TABLE dbo.CteMES(
		Cliente              VARCHAR(010)       NOT NULL,
		RazonSocial          VARCHAR(100)           NULL,
		NombreComercial      VARCHAR(100)           NULL,
		Direccion1           VARCHAR(100)           NULL,
		Direccion2           VARCHAR(100)           NULL,
		Poblacion            VARCHAR(100)           NULL,
		Provincia            VARCHAR(030)           NULL,
		CodigoPostal         VARCHAR(015)           NULL,
		Pais                 VARCHAR(030)           NULL,
		CIFDNI               VARCHAR(015)           NULL,
		FormaPago            VARCHAR(050)           NULL,
		TipoDocumento        VARCHAR(050)           NULL,
		CodigoMoneda         VARCHAR(050)           NULL,
		Idioma               VARCHAR(050)           NULL,
		CodigoPortes         VARCHAR(050)           NULL,
		DiaPago1             VARCHAR(010)           NULL,
		DiaPago2             VARCHAR(010)           NULL,
		DiaPago3             VARCHAR(010)           NULL,
		Cuenta               VARCHAR(020)           NULL,
		SubCuenta            VARCHAR(020)           NULL,
		EstatusIntelIMES     INT                    NULL,
	  CONSTRAINT priCteMES PRIMARY KEY CLUSTERED (Cliente ASC)
	)
GO

/********************* FormaPagoMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'FormaPagoMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('FormaPagoMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'FormaPagoMES' AND TYPE = 'u')
	CREATE TABLE dbo.FormaPagoMES(
		FormaPago             VARCHAR(50)       NOT NULL,
		Descripcion           VARCHAR(50)       NOT NULL,
		TipoDocumento         VARCHAR(10)           NULL,
		DiasPrimerVencimiento INT                   NULL,
		DiasEntreVencimientos INT                   NULL,
		EstatusIntelIMES      INT                   NULL,
	  CONSTRAINT priFormaPagoMES PRIMARY KEY CLUSTERED (FormaPago ASC)
	)
GO

/********************* MonMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'MonMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MonMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'MonMES' AND TYPE = 'u')
	CREATE TABLE dbo.MonMES(
		Moneda                VARCHAR(10)       NOT NULL,
		Descripcion           VARCHAR(50)           NULL,
		DescripcionAbreviada  VARCHAR(10)       NOT NULL,
		NumeroDecimales       INT                   NULL,
		EstatusIntelIMES      INT                   NULL,
	  CONSTRAINT priMonMES PRIMARY KEY CLUSTERED(Moneda ASC)
	)
GO

/********************* PaisMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'PaisMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PaisMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'PaisMES' AND TYPE = 'u')
	CREATE TABLE dbo.PaisMES(
		Pais                 VARCHAR(50)       NOT NULL,
		Clave                VARCHAR(10)       NOT NULL,
		DescripcionAbreviada VARCHAR(10)       NOT NULL,
		CodPaisIntrastat     VARCHAR(10)       NOT NULL,
		DigitosNIF           INT               NOT NULL,
		MiembroCE            BIT               NOT NULL,
		EstatusIntelIMES     INT                   NULL,
	  CONSTRAINT priPaisMES PRIMARY KEY CLUSTERED (Clave ASC)
	)
GO

/********************* RastreaDatos **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'RastreaDatos')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('RastreaDatos', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'RastreaDatos' AND TYPE = 'u')
	CREATE TABLE dbo.RastreaDatos(
		ID                    INT                   IDENTITY,
		TrcScript             VARCHAR(050)          NULL,
		TrcVariable           VARCHAR(050)          NULL,
		TrcValor              VARCHAR(200)          NULL,
	  CONSTRAINT priRastreaDatos PRIMARY KEY CLUSTERED (ID ASC)
	)
GO

/********************* ProvMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ProvMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProvMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ProvMES' AND TYPE = 'u')
	CREATE TABLE dbo.ProvMES(
		Proveedor             VARCHAR(010)       NOT NULL,
		RazonSocial           VARCHAR(100)           NULL,
		NombreComercial       VARCHAR(100)           NULL,
		Direccion1            VARCHAR(100)           NULL,
		Direccion2            VARCHAR(100)           NULL,
		Poblacion             VARCHAR(100)           NULL,
		Provincia             VARCHAR(030)           NULL,
		CodigoPostal          VARCHAR(015)           NULL,
		CodigoPais            VARCHAR(030)           NULL,
		CIFDNI                VARCHAR(015)           NULL,
		FormaPago             VARCHAR(050)           NULL,
		TipoDocumento         VARCHAR(030)           NULL,
		DefMoneda             VARCHAR(010)           NULL,
		Idioma                VARCHAR(010)           NULL,
		CodigoPortes          VARCHAR(050)           NULL,
		DiaPago1              VARCHAR(010)           NULL,
		DiaPago2              VARCHAR(010)           NULL,
		DiaPago3              VARCHAR(010)           NULL,
		Cuenta                VARCHAR(020)           NULL,
		SubCuenta             VARCHAR(020)           NULL,
		EstatusIntelIMES      INT                    NULL,
	  CONSTRAINT priProvMES PRIMARY KEY CLUSTERED(Proveedor ASC)
	)
GO

/********************* SaldoMESU **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'SaldoMESU')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SaldoMESU', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SaldoMESU' AND TYPE = 'u')
	CREATE TABLE dbo.SaldoMESU(
		Sucursal            INT               NOT NULL DEFAULT 0,
		Empresa             VARCHAR(5)        NOT NULL,
		Rama                VARCHAR(5)        NOT NULL,
		Moneda              VARCHAR(10)       NOT NULL,
		Grupo               VARCHAR(10)       NOT NULL,
		SubGrupo            VARCHAR(20)       NOT NULL,
		Cuenta              VARCHAR(20)       NOT NULL,
		SubCuenta           VARCHAR(50)       NOT NULL,
		Saldo               MONEY                 NULL,
		SaldoU              FLOAT                 NULL,
		PorConciliar        MONEY                 NULL,
		PorConciliarU       FLOAT                 NULL,
		UltimoCambio        DATETIME              NULL,
		EstatusIntelIMES    INT                   NULL,
	  CONSTRAINT priSaldoMESU PRIMARY KEY CLUSTERED (Cuenta ASC, SubCuenta ASC, Grupo   ASC, SubGrupo ASC, Rama ASC)
	)
GO

/********************* UnidadMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'UnidadMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('UnidadMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'UnidadMES' AND TYPE = 'u')
	CREATE TABLE dbo.UnidadMES(
		UnidadMedida        VARCHAR(50)       NOT NULL,
		Descripcion         VARCHAR(50)       NOT NULL,
		EstatusIntelIMES    INT                   NULL,	
		CONSTRAINT priUnidadMES PRIMARY KEY CLUSTERED (UnidadMedida ASC)
	)
GO

/********************* VentaMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'VentaMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'VentaMES' AND TYPE = 'u')
	CREATE TABLE dbo.VentaMES(
		ID                  INT                NOT NULL,
		Serie               VARCHAR(020)       NOT NULL,
		NumerodePedido      VARCHAR(020)           NULL,
		Cliente             VARCHAR(010)       NOT NULL,
		FechaPedido         DATETIME               NULL,
		FechaEntrega        DATETIME               NULL,
		SuPedido            VARCHAR(050)           NULL,
		FormadePago         VARCHAR(050)           NULL,
		TipoDocumento       VARCHAR(050)           NULL,
		DiaPago1            VARCHAR(010)           NULL,
		DiaPago2            VARCHAR(010)           NULL,
		DiaPago3            VARCHAR(010)           NULL,
		PorcIVA             FLOAT                  NULL,
		Moneda              VARCHAR(010)       NOT NULL,
		Cancelado			BIT				   NOT NULL DEFAULT 0,
		Aprobado			BIT				   NOT NULL DEFAULT 0,
		Sucursal			INT                NOT NULL DEFAULT 0,
		Proyecto			VARCHAR(050)           NULL,
		SubProyecto			VARCHAR(050)           NULL,
		EstatusIntelIMES    INT                    NULL,
	  CONSTRAINT priVentaMES PRIMARY KEY CLUSTERED(ID ASC)
	)
GO

EXEC spALTER_TABLE 'VentaMES', 'Cancelado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaMES', 'Aprobado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaMES', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'VentaMES', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VentaMES', 'SubProyecto', 'varchar(50) NULL'
GO

/********************* VentaDMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'VentaDMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('VentaDMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'VentaDMES' AND TYPE = 'u')
	CREATE TABLE dbo.VentaDMES(
		ID                     INT                NOT NULL,
		Renglon                FLOAT              NOT NULL,
		Serie                  VARCHAR(020)       NOT NULL,
		NumerodePedido         VARCHAR(020)           NULL,   
		Articulo               VARCHAR(20)        NOT NULL,
		AlmacenSalida          VARCHAR(10)            NULL,
		FechaEntregaRequerida  DATETIME               NULL,
		FechaEntregaConfirmada DATETIME               NULL,
		CantidadPedida         FLOAT                  NULL,
		CantidadServida        FLOAT                  NULL,
		CantidadPendiente      FLOAT                  NULL,
		PrecioIntroducido      FLOAT                  NULL,
		PorcIVA                FLOAT                  NULL,
		SuReferencia           VARCHAR(20)            NULL,
		UnidadPedida           VARCHAR(50)            NULL,
		UnidadPrecio           FLOAT                  NULL,
		Proyecto               VARCHAR(50)            NULL,
		SubProyecto            VARCHAR(50)            NULL,
		ContUso				   VARCHAR(20)            NULL,
		ContUso2			   VARCHAR(20)            NULL,
		SubCuenta			   VARCHAR(50)            NULL,
		LineaPedidoMes		   INT                    NULL,
		Lanzamiento			   VARCHAR(100)           NULL,
		EstatusIntelIMES       INT                    NULL,
	  CONSTRAINT priVentaDMES PRIMARY KEY CLUSTERED (ID ASC, Renglon ASC)
	)
GO

EXEC spALTER_TABLE 'VentaDMES', 'Proyecto', 'varchar(50) null'
EXEC spALTER_TABLE 'VentaDMES', 'SubProyecto', 'varchar(50) null'
EXEC spALTER_TABLE 'VentaDMES', 'ContUso', 'varchar(20) null'
EXEC spALTER_TABLE 'VentaDMES', 'ContUso2', 'varchar(20) null'
EXEC spALTER_TABLE 'VentaDMES', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'VentaDMES', 'LineaPedidoMes', 'int NULL'
EXEC spALTER_TABLE 'VentaDMES', 'Lanzamiento', 'varchar(100) NULL'
GO

/********************* MovMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'MovMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MovMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'MovMES' AND TYPE = 'u')
	CREATE TABLE dbo.MovMES(
		ID					BIGINT IDENTITY(1,1)	NOT NULL,
		Almacen				VARCHAR(100)			NOT NULL,
		Articulo			VARCHAR(100)			NOT NULL,
		Cantidad			FLOAT					NOT NULL,
		Lanzamiento			VARCHAR(100)			NOT NULL,
		Lote				VARCHAR(100)			NOT NULL,
		Ubicacion			VARCHAR(100)			NOT NULL,
		Direccion			VARCHAR(100)			NOT NULL,
		PrecioCosteMedio	FLOAT					NOT NULL,
		OrdenProduccion		VARCHAR(100)			NOT NULL,
		UltimoPrecioCoste	FLOAT					NOT NULL,
		AlmacenDestino		VARCHAR(100)			NOT NULL,
		Importe				FLOAT					NOT NULL,
		PrecioCosteStandard FLOAT					NOT NULL,
		Moneda				VARCHAR(100)			NOT NULL,
		Unidad				VARCHAR(100)			NOT NULL,
		TipoMovimiento		VARCHAR(100)			NOT NULL,
		CosteOperarios		VARCHAR(100)			NOT NULL,
		CosteMaterial		FLOAT					NOT NULL,
		CosteIndirecto		FLOAT					NOT NULL,
		CosteMaquinaria		FLOAT					NOT NULL,
		MotivoRechazo		VARCHAR(100)			NOT NULL,
		ProcesadoINTELISIS	BIT						    NULL,
		Subcuenta			VARCHAR(50) 			    NULL,
		Sucursal			INT						NOT NULL DEFAULT 0,
		Proyecto			VARCHAR(50) 			    NULL,
		SubProyecto			VARCHAR(50) 			    NULL,
	  CONSTRAINT PK_MovMES PRIMARY KEY CLUSTERED 
		(
			ID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

EXEC spALTER_TABLE 'MovMES', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovMES', 'Sucursal', 'int NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'MovMES', 'Proyecto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'MovMES', 'SubProyecto', 'varchar(50) NULL'
--EXEC spALTER_TABLE 'MovMES', 'Aprobado', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

/********************* ArtAlmMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ArtAlmMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ArtAlmMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ArtAlmMES' AND TYPE = 'u')
	CREATE TABLE dbo.ArtAlmMES(
		Empresa	            VARCHAR(5),
		Articulo	        VARCHAR(20),
		Almacen	            VARCHAR(10),
		Minimo	            FLOAT			NULL,
		Maximo	            FLOAT			NULL,
		PuntoOrden	        FLOAT			NULL,
		PuntoOrdenOrdenar	FLOAT			NULL,
		LoteOrdenar	        VARCHAR(30)		NULL,
		CantidadOrdenar	    FLOAT			NULL,
		MultiplosOrdenar	FLOAT			NULL,
		SubCuenta			VARCHAR(50)	,
	  CONSTRAINT priArtAlmMES PRIMARY KEY CLUSTERED (Articulo, Almacen, Empresa, SubCuenta)
	)
GO

EXEC spALTER_TABLE 'ArtAlmMES', 'LoteOrdenar', 'varchar(30) NULL'
EXEC spALTER_TABLE 'ArtAlmMES', 'CantidadOrdenar', 'float NULL'
EXEC spALTER_TABLE 'ArtAlmMES', 'MultiplosOrdenar', 'float NULL'
EXEC spALTER_TABLE 'ArtAlmMES', 'SubCuenta', 'varchar(50)'
GO
--Modificación de la PK de ArtAlmMES
IF EXISTS (SELECT * FROM ArtAlmMES WHERE SubCuenta IS NULL)
	UPDATE ArtAlmMES 
	SET SubCuenta = ''
	WHERE SubCuenta IS NULL
EXEC spDROP_PK 'ArtAlmMES'
EXEC spALTER_COLUMN 'ArtAlmMES', 'SubCuenta', 'varchar(50) NOT NULL'
EXEC spADD_PK 'ArtAlmMES', 'Articulo, Almacen, Empresa, SubCuenta'
GO

/********************* TipoArtMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'TipoArtMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TipoArtMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'TipoArtMES' AND TYPE = 'u')
	CREATE TABLE dbo.TipoArtMES(
		TipoArticulo        VARCHAR(50)       NOT NULL,
		Descripcion         VARCHAR(50)       NOT NULL,
		EstatusIntelIMES    INT                   NULL,
		CONSTRAINT priTipoArtMES PRIMARY KEY CLUSTERED (TipoArticulo ASC)
	)
GO

/********************* ProyMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'ProyMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('ProyMes', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'ProyMes' AND TYPE = 'u')
	CREATE TABLE dbo.ProyMes(
		Proy                VARCHAR(50),
		Descripcion         VARCHAR(100)      NULL,
		Categoria           VARCHAR(50)       NULL,
		FechaInicio         DATETIME          NULL,
		FechaFin            DATETIME          NULL,
		Tipo                VARCHAR(15)       NULL,
		Estatus             VARCHAR(15)       NULL,
		Cliente				VARCHAR(10)		  NULL,
		ProyectoRama        VARCHAR(10)       NULL,
		EstatusInteliMES    INT               NULL,
	  CONSTRAINT priProyMes PRIMARY KEY CLUSTERED (Proy)
	)
GO

EXEC spALTER_TABLE 'ProyMes', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'ProyMes', 'ProyectoRama', 'varchar(10) NULL'
GO

/********************* CotizaMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CotizaMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CotizaMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CotizaMES' AND TYPE = 'u')
	CREATE TABLE dbo.CotizaMES(
		ID					INT			NOT NULL,
		Serie				VARCHAR(20) NOT NULL,
		NumerodePedido		VARCHAR(20) NULL,
		Cliente				VARCHAR(10) NOT NULL,
		FechaPedido			DATETIME	NULL,
		FechaEntrega		DATETIME	NULL,
		SuPedido			VARCHAR(50) NULL,
		FormadePago			VARCHAR(50) NULL,
		TipoDocumento		VARCHAR(50) NULL,
		DiaPago1			VARCHAR(10) NULL,
		DiaPago2			VARCHAR(10) NULL,
		DiaPago3			VARCHAR(10) NULL,
		PorcIVA				FLOAT		NULL,
		Moneda				VARCHAR(10) NOT NULL,
		Cancelado			BIT			NOT NULL DEFAULT 0,
		Aprobado			BIT			NOT NULL DEFAULT 0,
		Sucursal			INT			NOT NULL DEFAULT 0,
		Proyecto			VARCHAR(50) NULL,
		SubProyecto			VARCHAR(50) NULL,
		EstatusIntelIMES	INT			NULL,
	  CONSTRAINT priCotizaMES PRIMARY KEY CLUSTERED 
		(
			ID ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO

/********************* CotizaDMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'CotizaDMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CotizaDMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CotizaDMES' AND TYPE = 'u')
	CREATE TABLE dbo.CotizaDMES(
		ID						INT 		NOT NULL,
		Renglon					FLOAT 		NOT NULL,
		Serie					VARCHAR(20) NOT NULL,
		NumerodePedido			VARCHAR(20) NULL,
		Articulo				VARCHAR(20) NOT NULL,
		AlmacenSalida			VARCHAR(10) NULL,
		FechaEntregaRequerida	DATETIME	NULL,
		FechaEntregaConfirmada	DATETIME	NULL,
		CantidadPedida			FLOAT		NULL,
		CantidadServida			FLOAT		NULL,
		CantidadPendiente		FLOAT		NULL,
		PrecioIntroducido		FLOAT		NULL,
		PorcIVA					FLOAT		NULL,
		SuReferencia			VARCHAR(20) NULL,
		UnidadPedida			VARCHAR(50) NULL,
		UnidadPrecio			FLOAT		NULL,
		SubCuenta				VARCHAR(50) NULL,
		LineaPedidoMes			INT			NULL,
		Lanzamiento				VARCHAR(100)NULL,
		Proyecto				VARCHAR(50) NULL,
		SubProyecto				VARCHAR(50) NULL,
		EstatusIntelIMES		INT			NULL,
	  CONSTRAINT priCotizaDMES PRIMARY KEY CLUSTERED 
	(
		ID ASC,
		Renglon ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

/********************* EmpresaCfgMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'EmpresaCfgMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmpresaCfgMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'EmpresaCfgMES' AND TYPE = 'u')
	CREATE TABLE dbo.EmpresaCfgMES(
		Empresa					VARCHAR(5),
		Servidor				VARCHAR(50)		NULL,
		BD						VARCHAR(50)		NULL,
		MonedaIntelisis			VARCHAR(10)		NULL,
		--MonedaMES				VARCHAR(4)		NULL, -- Moneda (MEmpresa)
		PaisIntelisis			VARCHAR(50)		NULL,
		--PaisMES				VARCHAR(4)		NULL, -- CodigoPais (MEmpresa)
		RutaSituacionArticulo   VARCHAR(255)	NULL,
		TransferenciaManual		BIT				NOT NULL DEFAULT 0,
	  CONSTRAINT priEmpresaCfgMES PRIMARY KEY CLUSTERED (Empresa)
	)
GO

EXEC spALTER_TABLE 'EmpresaCfgMES', 'RutaSituacionArticulo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMES', 'TransferenciaManual', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

/********************* UsuarioMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'UsuarioMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('UsuarioMes', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'UsuarioMes' AND TYPE = 'u')
	CREATE TABLE dbo.UsuarioMes(
		Usuario             VARCHAR(10),
		Nombre              VARCHAR(100)  NULL,
		Supervisor          SMALLINT      NULL,
		Sucursal			VARCHAR(255)  NULL,
		EstatusInteliMES    INT           NULL,
	  CONSTRAINT priUsuarioMes PRIMARY KEY CLUSTERED (Usuario)
	)
GO

EXEC spALTER_TABLE 'UsuarioMes', 'Supervisor', 'smallint NULL'
EXEC spALTER_COLUMN 'UsuarioMes', 'Supervisor', 'smallint NULL'
EXEC spALTER_TABLE 'UsuarioMes', 'Sucursal', 'varchar(255) NULL'
GO

/********************* OperMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'OperMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('OperMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'OperMES' AND TYPE = 'u')
	CREATE TABLE dbo.OperMES(
		Operario          VARCHAR(50) NOT NULL,
		Nombre            VARCHAR(50) NULL,
		Sucursal		  VARCHAR(50) NULL,
		EstatusIntelIMES  INT         NULL,
	  CONSTRAINT priOperMES PRIMARY KEY CLUSTERED (Operario)
	)
GO

EXEC spALTER_TABLE 'OperMES', 'Sucursal', 'varchar(50) NULL'
GO
/********************* SucursalMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'SucursalMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('SucursalMes', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'SucursalMes' AND TYPE = 'u')
	CREATE TABLE dbo.SucursalMes(
		Sucursal            INT,
		[Server]            VARCHAR(100)  NULL,
		UserMes             VARCHAR(20)   NULL,
		Pass                VARCHAR(20)   NULL,
		--DBMES               VARCHAR(20)   NULL,
		BDMES               VARCHAR(20)   NULL,
		FormatoFecha        VARCHAR(10)   NULL,--"DD/MM/YYYY" 
		OptSyncServicio     VARCHAR(10)   NULL,
		TiempoSyncServicio  INT           NULL, 
		DeleteLOGFiles      VARCHAR(1)    NULL,
		BDINT               VARCHAR(50)   NULL,
	  CONSTRAINT priSucursalMes PRIMARY KEY CLUSTERED (Sucursal)
	)
GO

-- se agrego 20abr16 jsmv
EXEC spALTER_TABLE 'SucursalMes', 'BDINT', 'varchar(50) NULL'
GO

/********************* TraspasoAlmacenesMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'TraspasoAlmacenesMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('TraspasoAlmacenesMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'TraspasoAlmacenesMES' AND TYPE = 'u')
	CREATE TABLE dbo.TraspasoAlmacenesMES(
		CodigoArticulo         VARCHAR(250) NOT NULL,
		Lote                   VARCHAR(250) NOT NULL,
		AlmacenOrigen          VARCHAR(250) NOT NULL,
		UbicacionOrigen        VARCHAR(250) NOT NULL,
		Cantidad               FLOAT        NOT NULL,
		UnidadMedida           VARCHAR(250) NOT NULL,
		UbicacionDestino       VARCHAR(250) NOT NULL,
		AlmacenDestino         VARCHAR(250) NOT NULL,
		Observaciones          VARCHAR(250) NULL,
		Observaciones2         VARCHAR(250) NULL,
		FechaAlta              DATETIME     NOT NULL,
		UsuarioAlta            VARCHAR(250) NOT NULL,
		BBDDMES                VARCHAR(250) NOT NULL,
		EstatusIntelIMES       INT          NOT NULL
	) ON [PRIMARY]
GO
	
/********************* AccesoMes **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'AccesoMes')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('AccesoMes', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'AccesoMes' AND TYPE = 'u')
	CREATE TABLE dbo.AccesoMes(
		ID                    INT,
		Empresa               VARCHAR(5)	NOT NULL,
		Usuario               VARCHAR(10)	NOT NULL,
		FechaRegistro         DATETIME		NOT NULL,
		FechaSalida           DATETIME		NULL,
	  CONSTRAINT priAccesoMes PRIMARY KEY CLUSTERED (ID)
	)
GO

/********************* PrevisionesConsumoMES **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'PrevisionesConsumoMES')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('PrevisionesConsumoMES', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'PrevisionesConsumoMES' AND TYPE = 'u')
	CREATE TABLE dbo.PrevisionesConsumoMES(
		Lanzamiento				INT				NOT NULL,
		Padre					VARCHAR(100)	NOT NULL,
		Hijo					VARCHAR(100)	NOT NULL,
		CantidadTotalPadre		FLOAT			NULL DEFAULT 0,
		CantidadPorHijo			FLOAT			NULL DEFAULT 0,
		CantidadTotalHijo		FLOAT			NULL DEFAULT 0,
		FechaDeAlta				DATETIME		NULL DEFAULT (GETDATE()),
		--FaseConsumo			SMALLINT		NULL,
		FaseConsumo				VARCHAR(50)		NULL,
		Trabajo					INT				NOT NULL DEFAULT 0,
		OrdenProd				INT				NULL DEFAULT 0,
		UltimoPrecioCoste		FLOAT			NULL DEFAULT 0,
		PrecioCosteMedio		FLOAT			NULL DEFAULT 0,
		ProveedorHabitualPadre	VARCHAR(50)		NULL,
		ProveedorHabitualHijo	VARCHAR(50)		NULL,
		TipoArticulo			SMALLINT		NOT NULL,
		UnidMedidaCompra		VARCHAR(50)		NULL,
		UnidMedidaVenta			VARCHAR(50)		NULL,
		UnidMedidaAlmacen		VARCHAR(50)		NULL,
		AlmacenDefecto			VARCHAR(50)		NULL,
		UnidConverVenta			FLOAT			NULL DEFAULT 0,
		CodigoMoneda			VARCHAR(50)		NULL,
		CosteStandarMOE			FLOAT			NULL,
		Transferido				FLOAT			NULL,
		EstatusIntelIMES		INT				NULL,
	  CONSTRAINT PK_PrevisionesConsumoMES PRIMARY KEY CLUSTERED
	  (Hijo ASC,Lanzamiento ASC,Padre ASC)
	  WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

EXEC spALTER_TABLE 'PrevisionesConsumoMES', 'Transferido', 'float NULL'
EXEC spALTER_COLUMN 'PrevisionesConsumoMES', 'FaseConsumo', 'varchar(50) NULL'
GO

/********************* MesInvTransfer **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'MesInvTransfer')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MesInvTransfer', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'MesInvTransfer' AND TYPE = 'u')
	CREATE TABLE dbo.MesInvTransfer(
		Usuario               VARCHAR(10),
		ID                    INT       IDENTITY,
		Lanzamiento           INT,
		Padre                 VARCHAR(20),
		Hijo                  VARCHAR(20),
		Almacen               VARCHAR(10)   NULL,
		AlmacenD              VARCHAR(10)   NULL,
		Cantidad              FLOAT         NULL,
		CantidadA             FLOAT         NULL,
		UltimoPrecioCoste     FLOAT         NULL,
		PrecioCosteMedio      FLOAT         NULL,
		TipoArticulo          SMALLINT      NULL,
		UnidMedidaCompra      VARCHAR(50)   NULL,
		UnidMedidaAlmacen     VARCHAR(50)   NULL,
		Transferido			  FLOAT         NULL,
	  CONSTRAINT priMesInvTransfer PRIMARY KEY CLUSTERED (ID, Usuario)
	)
GO

EXEC spALTER_TABLE 'MesInvTransfer', 'Transferido', 'float NULL'
GO

-- 7/Ago/2016
/********************* MesInvTransferSerieLote **********************/
IF NOT EXISTS (SELECT * FROM SysTabla WHERE SysTabla = 'MesInvTransferSerieLote')
	INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('MesInvTransferSerieLote', 'N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'MesInvTransferSerieLote' AND TYPE = 'u')
	CREATE TABLE dbo.MesInvTransferSerieLote(
		Usuario               VARCHAR(10),
		ID                    INT,
		SerieLote             VARCHAR(50)	NOT NULL,
		Cantidad              FLOAT			NOT NULL
	  CONSTRAINT priMesInvTransferSerieLote PRIMARY KEY CLUSTERED (ID, Usuario, SerieLote)
	)
GO

/**************************************************************/
/********************* CREACIÓN DE TRIGGER ********************/
/**************************************************************/

/********************* tgArtCatABC **********************/
IF OBJECT_ID(N'dbo.tgArtCatABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgArtCatABC
GO
CREATE TRIGGER tgArtCatABC
ON ArtCat
--//WITH ENCRYPTION
FOR  UPDATE, DELETE, INSERT
AS
BEGIN

	DELETE FROM TipoArtMES WHERE TipoArticulo IN (SELECT Categoria FROM DELETED)

	INSERT TipoArtMES (TipoArticulo, Descripcion, EstatusIntelIMES)
	SELECT Categoria, Categoria, 0
	FROM INSERTED

END
GO

/********************* tgFormaPagoABC **********************/
IF OBJECT_ID(N'dbo.tgFormaPagoABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgFormaPagoABC
GO
CREATE TRIGGER tgFormaPagoABC
ON FormaPago
--//WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN

	DELETE FROM FormaPagoMES WHERE FormaPago IN (SELECT FormaPago FROM DELETED)    

	INSERT FormaPagoMES (FormaPago,   Descripcion, TipoDocumento, DiasPrimerVencimiento, DiasEntreVencimientos, EstatusIntelIMES)
	SELECT FormaPago, FormaPago, '', 0, 0, 0 
	FROM INSERTED

END
GO

/********************* tgPaisABC **********************/
IF OBJECT_ID(N'dbo.tgPaisABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgPaisABC
GO
CREATE TRIGGER tgPaisABC
ON Pais
--//WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
    
	DELETE FROM PaisMes WHERE Clave IN (SELECT Clave FROM DELETED)

	INSERT PaisMes (Pais,   Clave,   DescripcionAbreviada, CodPaisIntrastat, DigitosNIF, MiembroCE, EstatusIntelIMES)
	SELECT Pais, Clave, Clave, Clave, 13, 0, 0 
	FROM INSERTED

END
GO

/********************* tgCompraABC **********************/
IF OBJECT_ID(N'[dbo].[tgCompraABC]' ,'TR') IS NOT NULL
    DROP TRIGGER [dbo].[tgCompraABC]
GO
/*
CREATE TRIGGER tgCompraABC
ON Compra
   WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @IDNueva               INT
           ,@IDAnterior            INT
           ,@SPID                  INT
           ,@AfectacionUsuario     VARCHAR(010)
           ,@Serie                 VARCHAR(020)
           ,@NumerodePedido        VARCHAR(020)
           ,@Proveedor             VARCHAR(010)
           ,@FechaEmision          DATETIME
           ,@FechaRequerida        DATETIME
           ,@Referencia            VARCHAR(050)
           ,@Condicion             VARCHAR(050)
           ,@Concepto              VARCHAR(050)
           ,@DiaPago1              VARCHAR(010)
           ,@DiaPago2              VARCHAR(010)
           ,@DiaPago3              VARCHAR(010)
           ,@PorcIVA               FLOAT
           ,@Moneda                VARCHAR(010)
           ,@EstatusIntelIMES      INT

    SELECT @SPID = @@SPID

    SELECT @AfectacionUsuario      = Usuario
    FROM   AfectacionUsuario
    WHERE  SPID                    = @SPID
    
    IF dbo.fnEstaSincronizando()   = 1
        RETURN
    
    SELECT @IDAnterior             = ID
    FROM   DELETED
    
    SELECT @IDNueva                = ID
           ,@Serie                 = Mov
           ,@NumerodePedido        = MovID
           ,@Proveedor             = Proveedor
           ,@FechaEmision          = FechaEmision
           ,@FechaRequerida        = FechaRequerida
           ,@Referencia            = Referencia
           ,@Condicion             = Condicion
           ,@Concepto              = Concepto
           ,@DiaPago1              = ''
           ,@DiaPago2              = ''
           ,@DiaPago3              = ''
           ,@PorcIVA               = 0
           ,@Moneda                = Moneda
           ,@EstatusIntelIMES      = 0
    FROM   INSERTED

    IF @IDNueva IS NULL AND @IDAnterior IS NULL
       RETURN

    IF @IDNueva IS NOT NULL AND @IDAnterior IS NULL
       INSERT INTO CompraMES
       (ID,              Serie,       NumerodePedido,  Proveedor,  FechaEmision, 
        FechaRequerida,  Referencia,  Condicion,       Concepto,   DiaPago1,
       	DiaPago2,        DiaPago3,    PorcIVA,         Moneda,     EstatusIntelIMES)
       VALUES
       (@IDNueva,        @Serie,      @NumerodePedido, @Proveedor, @FechaEmision,
        @FechaRequerida, @Referencia, @Condicion,      @Concepto,  @DiaPago1,
        @DiaPago2,       @DiaPago3,   @PorcIVA,        @Moneda,    @EstatusIntelIMES)

    IF @IDNueva IS NOT NULL AND @IDAnterior IS NOT NULL
       BEGIN
         IF EXISTS(SELECT * FROM CompraMES WHERE ID = @IDNueva)
            UPDATE CompraMES
               SET	Serie          = @Serie,          NumerodePedido   = @NumerodePedido,
            	      Proveedor      = @Proveedor,      FechaEmision     = @FechaEmision,
               	   FechaRequerida = @FechaRequerida, Referencia       = @Referencia,
               	   Condicion      = @Condicion,      Concepto         = @Concepto,
             	     DiaPago1       = @DiaPago1,       DiaPago2         = @DiaPago2,
               	   DiaPago3       = @DiaPago3,	      PorcIVA          = @PorcIVA,
               	   Moneda         = @Moneda,         EstatusIntelIMES = @EstatusIntelIMES
             WHERE ID = @IDNueva
            ELSE
            INSERT INTO CompraMES
            (ID,              Serie,       NumerodePedido,  Proveedor,  FechaEmision, 
             FechaRequerida,  Referencia,  Condicion,       Concepto,   DiaPago1,
            	DiaPago2,        DiaPago3,    PorcIVA,         Moneda,     EstatusIntelIMES)
            VALUES
            (@IDNueva,        @Serie,      @NumerodePedido, @Proveedor, @FechaEmision,
             @FechaRequerida, @Referencia, @Condicion,      @Concepto,  @DiaPago1,
             @DiaPago2,       @DiaPago3,   @PorcIVA,        @Moneda,    @EstatusIntelIMES)
       END
    RETURN
END
*/
GO

/********************* tgCompraDABC **********************/
IF OBJECT_ID(N'[dbo].[tgCompraDABC]' ,'TR') IS NOT NULL DROP TRIGGER [dbo].[tgCompraDABC]
GO
/*
CREATE TRIGGER tgCompraDABC
ON CompraD
   WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @IDNueva               INT
           ,@IDAnterior            INT
           ,@SPID                  INT
           ,@AfectacionUsuario     VARCHAR(010)
           ,@Estatus               VARCHAR(015)
           ,@Mensaje               VARCHAR(255)
           ,@Renglon               FLOAT
           ,@Serie                 VARCHAR(020)
           ,@NumerodePedido        VARCHAR(020)
           ,@Articulo              VARCHAR(20)
           ,@Almacen               VARCHAR(20)
           ,@FechaEntrega          DATETIME
           ,@FechaRequerida        DATETIME
           ,@FechaConfirmada       DATETIME
           ,@Cantidad              FLOAT
           ,@CantidadRecibida      FLOAT
           ,@CantidadPendiente     FLOAT
           ,@Precio                FLOAT
           ,@SuReferencia          VARCHAR(20)
           ,@UnidadPedida          VARCHAR(50)
           ,@UnidadPrecio          FLOAT
           ,@EstatusIntelIMES      INT

    SELECT @IDNueva                = ID
          ,@Articulo               = Articulo
          ,@Cantidad               = Cantidad
	         ,@Renglon                = Renglon 
          ,@Almacen                = Almacen
          ,@FechaEntrega           = FechaOrdenar
          ,@FechaRequerida         = FechaRequerida
          ,@FechaConfirmada        = FechaEntrega
          ,@CantidadRecibida       = 0
          ,@CantidadPendiente      = CantidadPendiente
          ,@Precio                 = Costo
          ,@SuReferencia           = ''
          ,@UnidadPedida           = Unidad
          ,@UnidadPrecio           = Costo
          ,@EstatusIntelIMES       = 0
    FROM   INSERTED
    
    SELECT @Serie                  = Mov
          ,@NumerodePedido         = MovID   
     FROM  Compra 
    WHERE  ID                      = @IDNueva
    
    SELECT @IDAnterior             = ID
    FROM   DELETED

    SELECT @Estatus = Estatus
    FROM   Compra
    WHERE  ID = @IDNueva
    
    IF @IDNueva IS NOT NULL
       AND @Estatus = 'CONFIRMAR'
       AND NULLIF(@Cantidad ,'') IS NULL
    BEGIN
        SELECT @Mensaje = 
               'No se pueden Guardar Cambios en un Movimiento con Estatus Por Confirmar. Articulo: ' 
              +RTRIM(@Articulo)
        RAISERROR(@Mensaje ,16 ,-1)
        RETURN
    END

    IF @IDNueva IS NULL AND @IDAnterior IS NULL
       RETURN

    IF @IDNueva IS NOT NULL AND @IDAnterior IS NULL
       INSERT INTO CompraDMES
       (ID,                Renglon,            Serie,           NumerodePedido,   Articulo,
       	Almacen,           FechaEntrega,       FechaRequerida,  FechaConfirmada,  Cantidad,
       	CantidadRecibida,  CantidadPendiente,  Precio,          SuReferencia,     UnidadPedida,
       	UnidadPrecio,      EstatusIntelIMES)
       VALUES
       (@IDNueva,          @Renglon,           @Serie,          @NumerodePedido,  @Articulo,
        @Almacen,          @FechaEntrega,      @FechaRequerida, @FechaConfirmada, @Cantidad,
        @CantidadRecibida, @CantidadPendiente, @Precio,         @SuReferencia,    @UnidadPedida,
        @UnidadPrecio,     @EstatusIntelIMES)

    IF @IDNueva IS NOT NULL AND @IDAnterior IS NOT NULL
       BEGIN
         IF EXISTS(SELECT * FROM CompraDMES WHERE ID = @IDNueva AND Renglon = @Renglon)
            UPDATE CompraDMES
               SET Serie            = @Serie,            NumerodePedido    = @NumerodePedido,
                  	Articulo         = @Articulo,         Almacen           = @Almacen,
                  	FechaEntrega     = @FechaEntrega,     FechaRequerida    = @FechaRequerida,
                  	FechaConfirmada  = @FechaConfirmada,  Cantidad          = @Cantidad,
                  	CantidadRecibida = @CantidadRecibida, CantidadPendiente = @CantidadPendiente,
          	        Precio           = @Precio,           SuReferencia      = @SuReferencia,
          	        UnidadPedida     = @UnidadPedida,     UnidadPrecio      = @UnidadPrecio,
            	      EstatusIntelIMES = @EstatusIntelIMES
             WHERE ID      = @IDNueva 
               AND Renglon = @Renglon
            ELSE
            INSERT INTO CompraDMES
            (ID,                Renglon,            Serie,           NumerodePedido,   Articulo,
       	     Almacen,           FechaEntrega,       FechaRequerida,  FechaConfirmada,  Cantidad,
            	CantidadRecibida,  CantidadPendiente,  Precio,          SuReferencia,     UnidadPedida,
       	     UnidadPrecio,      EstatusIntelIMES)
            VALUES
            (@IDNueva,          @Renglon,           @Serie,          @NumerodePedido,  @Articulo,
             @Almacen,          @FechaEntrega,      @FechaRequerida, @FechaConfirmada, @Cantidad,
             @CantidadRecibida, @CantidadPendiente, @Precio,         @SuReferencia,    @UnidadPedida,
             @UnidadPrecio,     @EstatusIntelIMES)
       END
    RETURN
END
*/
GO

/********************* tgArtAlmABC **********************/
IF OBJECT_ID(N'dbo.tgArtAlmABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgArtAlmABC
GO
CREATE TRIGGER tgArtAlmABC
ON ArtAlm
--//WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
	
	DECLARE @Empresa	VARCHAR(5),
			@Articulo	VARCHAR(20),
			@SubCuenta	VARCHAR(50),
			@Almacen	VARCHAR(10)
	
	DECLARE crArtAlmMES CURSOR FOR
	SELECT Empresa, Articulo, SubCuenta, Almacen 
	FROM INSERTED
	
	OPEN crArtAlmMES
	FETCH crArtAlmMES INTO @Empresa, @Articulo, @SubCuenta, @Almacen
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DELETE FROM ArtAlmMES
		WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = @SubCuenta AND Almacen = @Almacen
		
		FETCH crArtAlmMES INTO @Empresa, @Articulo, @SubCuenta, @Almacen
	END
	
	CLOSE crArtAlmMES
	DEALLOCATE crArtAlmMES
	
	INSERT INTO ArtAlmMES(Empresa, Articulo, Almacen, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar, LoteOrdenar, CantidadOrdenar, MultiplosOrdenar, SubCuenta)
	SELECT Empresa, Articulo, Almacen, Minimo, Maximo, PuntoOrden, PuntoOrdenOrdenar, LoteOrdenar, CantidadOrdenar, MultiplosOrdenar, SubCuenta 
	FROM   INSERTED

	UPDATE ArtMES SET EstatusIntelIMES = 0 WHERE Articulo IN (SELECT Articulo FROM INSERTED)
  	UPDATE Art SET TieneMovimientos = 1 WHERE Articulo IN (SELECT Articulo FROM INSERTED)
  
END
GO

/********************* tgArtFamMes **********************/
IF OBJECT_ID(N'dbo.tgArtFamMes' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgArtFamMes
GO
CREATE TRIGGER tgArtFamMes
ON ArtFam
--//WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN

	DELETE FROM ArtFamMes WHERE Clave = (SELECT ClaveMES FROM DELETED)

	INSERT ArtFamMes (Clave, Descripcion, EstatusIntelIMES)
	SELECT ClaveMES, Familia, 0
	FROM INSERTED

  RETURN	
END
GO

/********************* tgArtSubFamMes **********************/
IF OBJECT_ID(N'dbo.tgArtSubFamMes' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgArtSubFamMes
GO
CREATE TRIGGER tgArtSubFamMes
ON ArtGrupo
--//WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
	
	DELETE FROM ArtSubFamMes 
	WHERE Clave IN (SELECT ClaveMes FROM DELETED)
	
	INSERT ArtSubFamMes (Clave, Descripcion, EstatusIntelIMES)
	SELECT ClaveMES, Grupo, 0 
	FROM INSERTED
	  
  RETURN	
END
GO


/********************* tgVentaABC **********************/
IF OBJECT_ID(N'dbo.tgVentaABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgVentaABC
GO
/*
CREATE TRIGGER tgVentaABC
ON Venta
-- WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @IDNueva           INT
        ,@IDAnterior        INT
        ,@Serie             VARCHAR(20)
        ,@NumerodePedido    VARCHAR(20)
        ,@Cliente           VARCHAR(10)
        ,@FechaPedido       DATETIME
        ,@FechaEntrega      DATETIME
        ,@SuPedido          VARCHAR(50)
        ,@FormadePago       VARCHAR(50)
        ,@TipoDocumento     VARCHAR(50)
        ,@DiaPago1          VARCHAR(10)
        ,@DiaPago2          VARCHAR(10)
        ,@DiaPago3          VARCHAR(10)
        ,@Moneda            VARCHAR(10)
        ,@SPID				          INT
        ,@AfectacionUsuario	VARCHAR(10)
        ,@VentaEstatus      varchar(15)
        ,@EstatusNuevo      VARCHAR(20)
        ,@EstatusAnterior   VARCHAR(20)
        ,@Cancelado         bit

 SELECT @SPID              = @@SPID
 SELECT @AfectacionUsuario = Usuario 
   FROM AfectacionUsuario 
  WHERE SPID = @SPID

 IF dbo.fnEstaSincronizando() = 1 RETURN

 SELECT  @EstatusNuevo    = Estatus
        ,@IDNueva         = ID
        ,@Serie           = Mov
        ,@NumerodePedido  = MovID
        ,@Cliente         = Cliente
        ,@FechaPedido     = FechaRegistro
        ,@FechaEntrega    = FechaRequerida
        ,@SuPedido        = Referencia
        --,@FormadePago     = Condicion
        ,@TipoDocumento   = Mov
        ,@DiaPago3        = ''
        ,@Moneda          = Moneda
        ,@VentaEstatus    = Estatus
   FROM INSERTED
   
 SELECT @FormadePago = vc.FormaCobro1 FROM VentaCobro vc WHERE vc.ID = @IDNueva

 SELECT  @DiaPago1        = DiaPago1 
        ,@DiaPago2        = DiaPago2
   FROM  Cte 
  WHERE  Cliente          = @Cliente
    AND  Estatus          = 'ALTA'

 SELECT  @EstatusAnterior = Estatus
        ,@IDAnterior      = ID 
   FROM DELETED
   
 IF @VentaEstatus = 'CANCELADO'
   SELECT @Cancelado = 1
 ELSE
 	 SELECT @Cancelado = 0

-- SELECT @EstatusNuevo, @EstatusAnterior

 IF @IDAnterior IS NULL AND (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior NOT IN ('PENDIENTE', 'CONCLUIDO'))
    INSERT VentaMES
          (ID,           Serie,          NumerodePedido,  Cliente,   FechaPedido,  FechaEntrega, SuPedido, 
           FormadePago,  TipoDocumento,  DiaPago1,        DiaPago2,  DiaPago3,     Moneda, Cancelado)
    VALUES
          (@IDNueva,     @Serie,         @NumerodePedido, @Cliente,  @FechaPedido, @FechaEntrega, @SuPedido,
           @FormadePago, @TipoDocumento, @DiaPago1,       @DiaPago2, @DiaPago3,    @Moneda, @Cancelado)

 IF @IDAnterior IS NOT NULL AND
    @IDNueva    IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaMES WHERE ID = @IDNueva)
         BEGIN
           UPDATE VentaMES SET
                  Serie        = @Serie,        NumerodePedido = @NumerodePedido
                 ,Cliente      = @Cliente,      FechaPedido    = @FechaPedido
                 ,FechaEntrega = @FechaEntrega, SuPedido       = @SuPedido
                 ,FormadePago  = @FormadePago,  TipoDocumento  = @TipoDocumento
                 ,DiaPago1     = @DiaPago1,     DiaPago2       = @DiaPago2
                 ,DiaPago3     = '',            Moneda         = @Moneda
                 ,Cancelado    = @Cancelado
            WHERE ID = @IDNueva
         END
         ELSE
         BEGIN
           INSERT VentaMES
                 (ID,           Serie,          NumerodePedido,  Cliente,   FechaPedido,  FechaEntrega, SuPedido, 
                  FormadePago,  TipoDocumento,  DiaPago1,        DiaPago2,  DiaPago3,     Moneda, Cancelado)
           VALUES
                 (@IDNueva,     @Serie,         @NumerodePedido, @Cliente,  @FechaPedido, @FechaEntrega, @SuPedido,
                  @FormadePago, @TipoDocumento, @DiaPago1,       @DiaPago2, @DiaPago3,    @Moneda, @Cancelado)
         END
    END
           
END
*/
GO

/********************* tgVentaDABC **********************/
IF OBJECT_ID(N'dbo.tgVentaDABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgVentaDABC
GO
/*
CREATE TRIGGER tgVentaDABC
ON VentaD
-- WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @IDNueva                  INT
        ,@RenglonNueva             FLOAT
        ,@IDAnterior               INT
        ,@RenglonAnterior          FLOAT
        ,@Serie                    VARCHAR(20)
        ,@NumerodePedido           VARCHAR(20)
        ,@Articulo                 VARCHAR(20)
        ,@AlmacenSalida            VARCHAR(10)
        ,@FechaEntregaRequerida    DATETIME
        ,@FechaEntregaConfirmada   DATETIME
        ,@CantidadPedida           FLOAT
        ,@CantidadServida          FLOAT
        ,@CantidadPendiente        FLOAT
        ,@PrecioIntroducido        FLOAT
        ,@PorcIVA                  FLOAT
        ,@SuReferencia             VARCHAR(20)
        ,@UnidadPedida             VARCHAR(50)
        ,@UnidadPrecio             FLOAT
        ,@EstatusNuevo             VARCHAR(20)
        ,@EstatusAnterior          VARCHAR(20)

 SELECT  @IDNueva                  = ID
        ,@RenglonNueva             = Renglon
        ,@Articulo                 = Articulo
        ,@AlmacenSalida            = Almacen
        ,@FechaEntregaRequerida    = FechaRequerida
        ,@FechaEntregaConfirmada   = FechaRequerida
        ,@CantidadPedida           = Cantidad
        ,@CantidadServida          = 0
        ,@CantidadPendiente        = CantidadPendiente
        ,@PrecioIntroducido        = Precio
        ,@PorcIVA                  = Impuesto1
        ,@SuReferencia             = ''
        ,@UnidadPedida             = Unidad
        ,@UnidadPrecio             = Precio
   FROM INSERTED

 IF @IDNueva IS NULL AND @IDAnterior = NULL
    RETURN

 SELECT  @Serie           = Mov
        ,@NumerodePedido  = MovID
   FROM  Venta
  WHERE  ID               = @IDNueva

 SELECT  @IDAnterior      = ID
        ,@RenglonAnterior = Renglon
   FROM DELETED

 --INSERT RastreaDatos (TrcVariable, TrcValor) VALUES ('@IDNueva', CONVERT(VARCHAR(100), @IDNueva))
 --INSERT RastreaDatos (TrcVariable, TrcValor) VALUES ('@IDAnterior', CONVERT(VARCHAR(100), @IDAnterior))

 IF @IDAnterior IS NULL
    IF NOT EXISTS(SELECT * FROM VentaDMES WHERE ID = @IDNueva AND Renglon = @RenglonNueva)
       INSERT VentaDMES
              (ID,                     Renglon,                 Serie,           NumerodePedido,   Articulo,           AlmacenSalida, 
               FechaEntregaRequerida,  FechaEntregaConfirmada,  CantidadPedida,  CantidadServida,  CantidadPendiente,  PrecioIntroducido, 
               PorcIVA,                SuReferencia,            UnidadPedida,    UnidadPrecio)    
       VALUES
              (@IDNueva,               @RenglonNueva,           @Serie,          @NumerodePedido,  @Articulo,          @AlmacenSalida, 
               @FechaEntregaRequerida, @FechaEntregaConfirmada, @CantidadPedida, @CantidadServida, @CantidadPendiente, @PrecioIntroducido, 
               @PorcIVA,               @SuReferencia,           @UnidadPedida,   @UnidadPrecio)    
       ELSE
       UPDATE VentaDMES SET       
              Serie                   = @Serie,                 NumerodePedido         = @NumerodePedido,
              Articulo                = @Articulo,              AlmacenSalida          = @AlmacenSalida,
              FechaEntregaRequerida   = @FechaEntregaRequerida, FechaEntregaConfirmada = @FechaEntregaConfirmada,
              CantidadPedida          = @CantidadPedida,        CantidadServida        = @CantidadServida,
              CantidadPendiente       = @CantidadPendiente,     PrecioIntroducido      = @PrecioIntroducido, 
              PorcIVA                 = @PorcIVA,               SuReferencia           = @SuReferencia,
              UnidadPedida            = @UnidadPedida,          UnidadPrecio           = @UnidadPrecio
        WHERE ID      = @IDNueva 
          AND Renglon = @RenglonNueva

 IF @IDAnterior IS NOT NULL AND
    @IDNueva    IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM VentaDMES WHERE ID = @IDNueva AND Renglon = @RenglonNueva)
         BEGIN
           UPDATE VentaDMES SET
                  Serie                   = @Serie,                 NumerodePedido         = @NumerodePedido,
                  Articulo                = @Articulo,              AlmacenSalida          = @AlmacenSalida, 
                  FechaEntregaRequerida   = @FechaEntregaRequerida, FechaEntregaConfirmada = @FechaEntregaConfirmada,
                  CantidadPedida          = @CantidadPedida,        CantidadServida        = @CantidadServida,
                  CantidadPendiente       = @CantidadPendiente,     PrecioIntroducido      = @PrecioIntroducido, 
                  PorcIVA                 = @PorcIVA,               SuReferencia           = @SuReferencia,
                  UnidadPedida            = @UnidadPedida,          UnidadPrecio           = @UnidadPrecio
            WHERE ID                      = @IDNueva
              AND Renglon                 = @RenglonNueva
         END
         ELSE
         BEGIN
           INSERT VentaDMES
                  (ID,                     Renglon,                 Serie,           NumerodePedido,   Articulo,           AlmacenSalida, 
                   FechaEntregaRequerida,  FechaEntregaConfirmada,  CantidadPedida,  CantidadServida,  CantidadPendiente,  PrecioIntroducido, 
                   PorcIVA,                SuReferencia,            UnidadPedida,    UnidadPrecio)    
           VALUES
                  (@IDNueva,               @RenglonNueva,           @Serie,          @NumerodePedido,  @Articulo,          @AlmacenSalida, 
                   @FechaEntregaRequerida, @FechaEntregaConfirmada, @CantidadPedida, @CantidadServida, @CantidadPendiente, @PrecioIntroducido, 
                   @PorcIVA,               @SuReferencia,           @UnidadPedida,   @UnidadPrecio)    
         END    	
    END
END
*/
GO


/********************* tgProvABC **********************/
IF OBJECT_ID(N'dbo.tgProvABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgProvABC
GO
/*
CREATE TRIGGER tgProvABC
ON Prov
WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @ClaveNueva            VARCHAR(10)
           ,@ClaveAnterior         VARCHAR(010)
           ,@Mensaje               VARCHAR(255)
           ,@RazonSocial           VARCHAR(100)
	          ,@NombreComercial       VARCHAR(100)
	          ,@Direccion1            VARCHAR(100)
	          ,@Direccion2            VARCHAR(100)
           ,@Poblacion             VARCHAR(100)
           ,@Provincia             VARCHAR(030)
           ,@CodigoPostal          VARCHAR(015)
           ,@CodigoPais            VARCHAR(030)
           ,@CIFDNI                VARCHAR(015)
           ,@FormaPago             VARCHAR(050)
           ,@TipoDocumento         VARCHAR(030)
           ,@DefMoneda             VARCHAR(010)
           ,@Idioma                VARCHAR(050)
           ,@CodigoPortes          VARCHAR(050)
           ,@DiaPago1              VARCHAR(010)
           ,@DiaPago2              VARCHAR(010)
           ,@DiaPago3              VARCHAR(010)
           ,@Cuenta                VARCHAR(020)
           ,@SubCuenta             VARCHAR(020),/*
           @Mes                    bit,*/
           @MonedaMes              varchar(10)
		   , @Fer varchar(max)

    SELECT @ClaveNueva            = Proveedor
          ,@RazonSocial           = Nombre
          ,@NombreComercial       = Nombre
          ,@Direccion1            = (Direccion + ' ' + DireccionNumero + ' ' + DireccionNumeroInt) 
          ,@Direccion2            = Colonia
          ,@Poblacion             = COALESCE(NULLIF(RTRIM(Delegacion), ''), NULLIF(RTRIM(Poblacion), ''))-- (ISNULL(Delegacion, '') + ISNULL(Poblacion, ''))
          ,@Provincia             = Estado
          ,@CodigoPostal          = CodigoPostal
          ,@CodigoPais            = Pais
          ,@CIFDNI                = RFC
          ,@FormaPago             = NULLIF(RTRIM(FormaPago), '')--'(NONE)'--Condicion
          ,@TipoDocumento         = ''
          ,@DefMoneda             = DefMoneda
          ,@Idioma                = Idioma
          ,@CodigoPortes          = ''
          ,@DiaPago1              = NULL-- DiaPago1
          ,@DiaPago2              = NULL--DiaPago2
          ,@DiaPago3              = NULL--''
          ,@Cuenta                = Cuenta
          ,@SubCuenta             = ''
    FROM inserted

    SELECT @ClaveAnterior = Proveedor FROM DELETED
    
    SELECT @MonedaMes = m.Moneda FROM MonMes m WHERE m.Descripcion = @DefMoneda
    SELECT @MonedaMes = ISNULL(@MonedaMes, @DefMoneda)

    IF @ClaveNueva IS NOT NULL
    BEGIN
      UPDATE ProvMES SET
        RazonSocial   = @RazonSocial,   NombreComercial = @NombreComercial,	
        Direccion1    = @Direccion1,    Direccion2      = @Direccion2, 
        Poblacion     = @Poblacion,     Provincia       = @Provincia, 
        CodigoPostal  = @CodigoPostal,  CodigoPais      = @CodigoPais, 
        CIFDNI        = @CIFDNI,        FormaPago       = @FormaPago, 
        TipoDocumento = @TipoDocumento, DefMoneda       = @MonedaMes, 
        Idioma        = @Idioma,        CodigoPortes    = @CodigoPortes, 
        DiaPago1      = @DiaPago1,      DiaPago2        = @DiaPago2, 
        DiaPago3      = @DiaPago3,      Cuenta          = @Cuenta, 
        SubCuenta     = @SubCuenta,     EstatusIntelIMES = 0
      WHERE Proveedor     = @ClaveNueva
    
      IF @@ROWCOUNT = 0
	  BEGIN
        SELECT @CodigoPais = Pais FROM PaisMES WHERE Pais = @CodigoPais
        INSERT ProvMES
	             (Proveedor,   RazonSocial,    NombreComercial,  Direccion1, Direccion2, 
	              Poblacion,   Provincia,      CodigoPostal,     CodigoPais, CIFDNI, 
	              FormaPago,   TipoDocumento,  DefMoneda,        Idioma,     CodigoPortes,
	              DiaPago1,    DiaPago2,       DiaPago3,         Cuenta,     SubCuenta, EstatusIntelIMES)
        VALUES              
              (@ClaveNueva, @RazonSocial,   @NombreComercial, @Direccion1, @Direccion2, 
               @Poblacion,  @Provincia,     @CodigoPostal,    @CodigoPais, @CIFDNI, 
               @FormaPago,  @TipoDocumento, @MonedaMes,       @Idioma,     @CodigoPortes, 
               @DiaPago1,   @DiaPago2,      @DiaPago3,        @Cuenta,     @SubCuenta, 0)
      END
    END

    IF @ClaveNueva IS NULL
       DELETE ProvMES WHERE Proveedor = @ClaveAnterior
END
*/
GO

/********************* tgCteABC **********************/
IF OBJECT_ID(N'dbo.tgCteABC' ,'TR') IS NOT NULL DROP TRIGGER dbo.tgCteABC
GO
/*
CREATE TRIGGER tgCteABC
ON Cte
WITH ENCRYPTION
FOR  INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @ClaveN               VARCHAR(010)
           ,@ClaveA               VARCHAR(010)
           ,@Mensaje              VARCHAR(255)
	          ,@RazonSocial          VARCHAR(100)
	          ,@NombreComercial      VARCHAR(100)
	          ,@Direccion1           VARCHAR(100)
	          ,@Direccion2           VARCHAR(100)
           ,@Poblacion            VARCHAR(100)
           ,@Provincia            VARCHAR(030)
           ,@CodigoPostal         VARCHAR(015)
           ,@Pais                 VARCHAR(030)
           ,@CIFDNI               VARCHAR(015)
           ,@Condicion            VARCHAR(050)
           ,@TipoDocumento        VARCHAR(050)
           ,@CodigoMoneda         VARCHAR(050)
           ,@Idioma               VARCHAR(050)
           ,@CodigoPortes         VARCHAR(050)
           ,@DiaPago1             VARCHAR(010)
           ,@DiaPago2             VARCHAR(010)
           ,@DiaPago3             VARCHAR(010)
           ,@Cuenta               VARCHAR(020)
           ,@SubCuenta            VARCHAR(020),/*
           @Mes                   bit,*/
           @MonedaMes             varchar(10)

    SELECT @ClaveN                = Cliente
          ,@RazonSocial           = Nombre
          ,@NombreComercial       = Nombre
          ,@Direccion1            = (Direccion + ' ' + DireccionNumero + ' ' + DireccionNumeroInt) 
          ,@Direccion2            = Colonia
          ,@Poblacion             = COALESCE(NULLIF(RTRIM(Delegacion), ''), NULLIF(RTRIM(Poblacion), ''))--(ISNULL(Delegacion, '') + ISNULL(Poblacion, '')) 
          ,@Provincia             = Estado
          ,@CodigoPostal          = CodigoPostal
          ,@Pais                  = Pais
          ,@CIFDNI                = RFC
          ,@Condicion             = Condicion
          ,@TipoDocumento         = ''
          ,@CodigoMoneda          = DefMoneda
          ,@Idioma                = ''
          ,@CodigoPortes          = ''
          ,@DiaPago1              = NULL--DiaPago1
          ,@DiaPago2              = NULL--DiaPago2
          ,@DiaPago3              = NULL--0
          ,@Cuenta                = Cuenta
          ,@SubCuenta             = ''/*,
          @Mes                    = ISNULL(Mes, 0)*/
    FROM   INSERTED
    
    SELECT @MonedaMes = m.Moneda FROM MonMes m WHERE m.Descripcion = @CodigoMoneda
    SELECT @MonedaMes = ISNULL(@MonedaMes, @CodigoMoneda)
    
    SELECT @ClaveA = Cliente FROM   DELETED

    IF @ClaveN IS NULL
       DELETE CteMES WHERE Cliente = @ClaveA

    IF @ClaveN IS NOT NULL
    BEGIN
      UPDATE CteMES SET 
        RazonSocial   = @RazonSocial,    
        NombreComercial = @NombreComercial, Direccion1    = @Direccion1,  
        Direccion2      = @Direccion2,      Poblacion     = @Poblacion,
        Provincia       = @Provincia,       CodigoPostal  = @CodigoPostal,
        Pais            = @Pais,            CIFDNI        = @CIFDNI,
        FormaPago       = @Condicion,       TipoDocumento = @TipoDocumento,
        CodigoMoneda    = @MonedaMes,       Idioma        = @Idioma,
        CodigoPortes    = @CodigoPortes,    DiaPago1      = @DiaPago1,
        DiaPago2        = @DiaPago2,        DiaPago3      = @DiaPago3, 
        Cuenta          = @Cuenta,          SubCuenta     = @SubCuenta, EstatusIntelIMES = 0
      WHERE Cliente = @ClaveN
	  IF @@ROWCOUNT = 0
	  BEGIN
        INSERT CteMES(
          Cliente,    RazonSocial,    NombreComercial,  Direccion1,  Direccion2,
          Poblacion,  Provincia,      CodigoPostal,     Pais,        CIFDNI,
          FormaPago,  TipoDocumento,  CodigoMoneda,     Idioma,      CodigoPortes,
          DiaPago1,   DiaPago2,       DiaPago3,         Cuenta,      SubCuenta, EstatusIntelIMES)
        VALUES(
          @ClaveN,    @RazonSocial,   @NombreComercial, @Direccion1, @Direccion2, 
          @Poblacion, @Provincia,     @CodigoPostal,    @Pais,       @CIFDNI,
          @Condicion, @TipoDocumento, @MonedaMes,       @Idioma,     @CodigoPortes,
          @DiaPago1,  @DiaPago2,      @DiaPago3,        @Cuenta,     @SubCuenta, 0)
	  END
    END 
END
*/
GO

/********************* tgProyMesAC **********************/
IF EXISTS(SELECT * FROM sysobjects WHERE NAME = 'tgProyMesAC' AND TYPE = 'TR') DROP TRIGGER tgProyMesAC
GO
/*
CREATE TRIGGER tgProyMesAC
ON Proy
FOR  INSERT, UPDATE
AS
BEGIN
	DECLARE
	@Proy 	            varchar(50),
  @Descripcion       varchar(100),
  @Categoria         varchar(50),
  @Tipo              varchar(15),
  @FechaInicio       datetime,
  @FechaFin          datetime,
  @Estatus           varchar(15),
  @Cliente           varchar(10),
  @ProyectoRama      varchar(10),
  @ContactoTipo      varchar(20)
  
  DECLARE crProyMesAC CURSOR FOR 
  SELECT Proyecto, Descripcion, Categoria, FechaInicio, FechaFin, Estatus, Tipo, Cliente, ProyectoRama, ContactoTipo
    FROM Inserted
  
  OPEN crProyMesAC
  FETCH next FROM crProyMesAC INTO @Proy, @Descripcion, @Categoria, @FechaInicio, @FechaFin, @Estatus, @Tipo, @Cliente, @ProyectoRama, @ContactoTipo
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @ContactoTipo = 'Proyecto' AND NULLIF(RTRIM(@ProyectoRama), '') IS NOT NULL
      SELECT @Cliente = Cliente FROM Proy WHERE Proyecto = @ProyectoRama
  
  	UPDATE ProyMes SET Descripcion = @Descripcion, Categoria = @Categoria, FechaInicio = @FechaInicio, FechaFin = @FechaFin, 
  	       Estatus = CASE @Estatus WHEN 'CONCLUIDO' THEN 'CIERRE' WHEN 'REVISION' THEN 'REAPERTURA' ELSE @Estatus END, 
  	       EstatusInteliMES = CASE @Estatus WHEN 'CONCLUIDO' THEN 2 WHEN 'REVISION' THEN 2 ELSE 0 END, 
  	       Tipo = @Tipo, Cliente = @Cliente, ProyectoRama = @ProyectoRama
  	WHERE Proy = @Proy
  	
  	IF @@ROWCOUNT = 0
  	  INSERT INTO ProyMes
  	         (Proy,  Descripcion,  Categoria,  FechaInicio,  FechaFin, Estatus, 
  	         Tipo, EstatusInteliMES, Cliente, ProyectoRama)
  	  VALUES(@Proy, @Descripcion, @Categoria, @FechaInicio, @FechaFin, CASE @Estatus WHEN 'CONCLUIDO' THEN 'CIERRE' WHEN 'REVISION' THEN 'REAPERTURA' ELSE @Estatus END, 
  	        @Tipo, CASE @Estatus WHEN 'CONCLUIDO' THEN 2 WHEN 'REVISION' THEN 2 ELSE 0 END, @Cliente, @ProyectoRama)
  	  
    UPDATE Art SET Descripcion1 = @Descripcion, Impuesto1 = 16, Tipo = 'Servicio', MonedaCosto = 'Pesos', MonedaPrecio = 'Pesos', Estatus = @Estatus
     WHERE Articulo = RTRIM(@Proy)

    IF @@ROWCOUNT = 0
      INSERT INTO Art(Articulo, Descripcion1, Impuesto1, Tipo, MonedaCosto, MonedaPrecio, Estatus, Unidad, UnidadCompra, UnidadTraspaso)
      SELECT RTRIM(@Proy), @Descripcion, 16, 'Servicio', 'Pesos', 'Pesos', @Estatus, 'PIEZA', 'PIEZA', 'PIEZA'
  	
  	UPDATE CentroCostos SET Descripcion = @Descripcion, Estatus = @Estatus
  	WHERE CentroCostos = RTRIM(@Proy)
  	
  	IF @@ROWCOUNT = 0
  	  INSERT INTO CentroCostos(CentroCostos, Descripcion, Estatus)
  	  SELECT RTRIM(@Proy), @Descripcion, @Estatus
  	
  	FETCH next FROM crProyMesAC INTO @Proy, @Descripcion, @Categoria, @FechaInicio, @FechaFin, @Estatus, @Tipo, @Cliente, @ProyectoRama, @ContactoTipo
  END
  
  CLOSE crProyMesAC
  DEALLOCATE crProyMesAC

  RETURN
END
*/
GO

/********************* tgUsuarioMesAC **********************/
IF EXISTS(SELECT * FROM sysobjects WHERE NAME = 'tgUsuarioMesAC' AND TYPE = 'TR') DROP TRIGGER tgUsuarioMesAC
GO
/*
CREATE TRIGGER tgUsuarioMesAC
ON Usuario
FOR  INSERT, UPDATE
AS
BEGIN
	DECLARE
	@Usuario        varchar(10),
	@Nombre         varchar(100),
	@MESAcceso      bit,
	@Supervisor     bit
	
	DECLARE crUsuarioMesAC CURSOR FOR
	SELECT Usuario, Nombre, MESAcceso, ISNULL(MESScheduling, 0)
	  FROM INSERTED
	  
	OPEN crUsuarioMesAC
	FETCH NEXT FROM crUsuarioMesAC INTO @Usuario, @Nombre, @MESAcceso, @Supervisor
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE UsuarioMes SET Nombre = @Nombre, EstatusInteliMES = 0, Supervisor = CASE @MESAcceso WHEN 1 THEN @Supervisor ELSE 0 END 
		 WHERE Usuario = @Usuario
		
		IF @@ROWCOUNT = 0
		  INSERT INTO UsuarioMes(Usuario, Nombre, EstatusInteliMES, Supervisor)
		  SELECT @Usuario, @Nombre, NULL, CASE @MESAcceso WHEN 1 THEN @Supervisor ELSE 0 END
		  
		--UPDATE Usuario SET TieneMovimientos = 1 WHERE Usuario = @Usuario AND TieneMovimientos = 0 -- 7/Ago/2016
		
		FETCH NEXT FROM crUsuarioMesAC INTO @Usuario, @Nombre, @MESAcceso, @Supervisor
	END
	
	CLOSE crUsuarioMesAC
	DEALLOCATE crUsuarioMesAC
	
END
GO*/

/********************* tgPersonalMESAC **********************/
IF EXISTS(SELECT * FROM sysobjects WHERE NAME = 'tgPersonalMESAC' AND TYPE = 'TR') DROP TRIGGER tgPersonalMESAC
GO
/*
CREATE TRIGGER tgPersonalMESAC
ON Personal
FOR  INSERT, UPDATE
AS
BEGIN
	DECLARE
	@Personal         varchar(10),
	@Nombre           varchar(120),
	@MES              bit
	
	DECLARE crPersonalMESAC CURSOR FOR
	SELECT Personal, RTRIM(Nombre) + ' ' + RTRIM(ISNULL(ApellidoPaterno, '')) + ' ' + RTRIM(ISNULL(ApellidoMaterno, '')), ISNULL(MES, 0)
    FROM Inserted
    
  OPEN crPersonalMESAC
  FETCH next FROM crPersonalMESAC INTO @Personal, @Nombre, @MES
  WHILE @@FETCH_STATUS = 0
  BEGIN
  	IF @MES = 1
  	BEGIN
  		UPDATE OperMES SET Nombre = @Nombre, EstatusIntelIMES = 1 WHERE Operario = @Personal
  		
  		IF @@ROWCOUNT = 0
  		  INSERT INTO OperMES(Operario, Nombre, EstatusIntelIMES)
  		  VALUES(@Personal, @Nombre, @MES)
  	END
  	FETCH next FROM crPersonalMESAC INTO @Personal, @Nombre, @MES
  END
  
  CLOSE crPersonalMESAC
  DEALLOCATE crPersonalMESAC
	
END
GO*/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME = 'CtrlHotFixINTELIMES' AND TYPE = 'u')
	CREATE TABLE CtrlHotFixINTELIMES(
		FechaActualizacion datetime NOT NULL,
		Descripcion varchar(250)	NOT NULL,
		CONSTRAINT PK_CtrlHotFixINTELIMES PRIMARY KEY CLUSTERED(
			 FechaActualizacion ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ArtExistenciaIntMES') AND type IN ('U')) -- drop table MesInvTransferSerieLote
	CREATE TABLE ArtExistenciaIntMES(	
		Articulo varchar(20)	NOT NULL,
		SubCuenta varchar(50)	NULL,
		SerieLote varchar(20)	NULL,
		Almacen varchar(10)		NULL,
		ExistenciaInte float	NULL,
		ExistenciaMES float		NULL,
		CostoMes float			NULL
	) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('MapeoPlantaIntelisisMes') AND type in ('U')) -- drop table MesInvTransferSerieLote
	CREATE TABLE MapeoPlantaIntelisisMes(
		Referencia varchar(50)					NULL,
		Empresa varchar(5)						NULL,
		Planta varchar(20)						NULL,
		MapeoPlantaIntelisisMes varchar(10)	NULL,
		Sucursal int							NULL,
		AlmacenMatPrima varchar(10)			NULL
	) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('PerfilMES') AND type IN ('U')) -- drop table MesInvTransferSerieLote
	CREATE TABLE PerfilMES(	
		PerfilMES varchar(50)	NOT NULL
	) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('SaldoInicialMES') AND type IN ('U'))
	CREATE TABLE SaldoInicialMES(
		ID                                INT IDENTITY(1,1) NOT NULL,
		Articulo                          varchar(20)		NOT NULL,
		SubCuenta                         varchar(50)		NOT NULL,
		Almacen                           varchar(10)		NOT NULL,
		Lote                              varchar(50)		NOT NULL,
		Cantidad                          float				NULL,
		Costo                             float				NULL,
		Moneda                            varchar(50)		NOT NULL,
		EstatusIntelIMES				  int				NULL,
		Sucursal                          int				NULL,
		FechaProcesado                    datetime			NULL,
		Unidad							  varchar (50)		NULL
		CONSTRAINT priSaldoInicialMes PRIMARY KEY CLUSTERED (Articulo, SubCuenta, Almacen, Lote)
	)
GO

EXEC spALTER_TABLE 'SaldoInicialMES', 'Unidad', 'varchar (50) NULL'
GO

