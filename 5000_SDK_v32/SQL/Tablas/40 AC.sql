/*******************************************************************************************/
/*                                        ADMON CREDITOS                                   */
/*******************************************************************************************/

/****** ACDiaCerrado ******/
if not exists(select * from SysTabla where SysTabla = 'ACDiaCerrado')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ACDiaCerrado','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.ACDiaCerrado') and type = 'U') 
CREATE TABLE dbo.ACDiaCerrado (
	Fecha		datetime	NOT NULL,

	CONSTRAINT priACDiaCerrado PRIMARY KEY  CLUSTERED (Fecha)
)
GO


/****** MetodoAmortizacion ******/
if not exists(select * from SysTabla where SysTabla = 'MetodoAmortizacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MetodoAmortizacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.MetodoAmortizacion') and type = 'U') 
CREATE TABLE dbo.MetodoAmortizacion (
	Numero		    	int 	        NOT NULL,
	Descripcion		varchar(100)	NULL,

	CONSTRAINT priMetodoAmortizacion PRIMARY KEY  CLUSTERED (Numero)
)
GO


/****** Calificacion de Cartera ******/
if not exists(select * from SysTabla where SysTabla = 'CalificacionCartera')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CalificacionCartera','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CalificacionCartera') and type = 'U') 
CREATE TABLE dbo.CalificacionCartera (
	Calificacion        char(2) 	        NOT NULL,
        Reserva             float               NULL,

	CONSTRAINT priCalificacionCartera PRIMARY KEY  CLUSTERED (Calificacion)
)
GO

/****** Tipos de Documentacion ******/
if not exists(select * from SysTabla where SysTabla = 'DocTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('DocTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.DocTipo') and type = 'U') 
CREATE TABLE dbo.DocTipo (
	Tipo		        varchar(20) 	NOT NULL,

	CONSTRAINT priDocTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** Tipos de Garantias ******/
if not exists(select * from SysTabla where SysTabla = 'GarantiaTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GarantiaTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GarantiaTipo') and type = 'U') 
CREATE TABLE dbo.GarantiaTipo (
	Tipo		        varchar(20) 	NOT NULL,

	CONSTRAINT priGarantiaTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO

/****** Tipo de Credito ******/
if not exists(select * from SysTabla where SysTabla = 'TipoCredito')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoCredito','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.TipoCredito') and type = 'U') 
CREATE TABLE dbo.TipoCredito (
	TipoCredito        	varchar(50) 	NOT NULL,

	Descripcion		varchar(100)	NULL,
	TipoTasa		varchar(20)	NULL,
	TipoTasaBonificacion	varchar(20)	NULL,
	Reciprocidad		float		NULL,

	CONSTRAINT priTipoCredito PRIMARY KEY  CLUSTERED (TipoCredito)
)
GO
EXEC spALTER_TABLE 'TipoCredito', 'Descripcion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'TipoCredito', 'TipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'TipoCredito', 'TipoTasaBonificacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'TipoCredito', 'Reciprocidad', 'float NULL'
GO

EXEC spFK 'TipoCredito','TipoTasa','TipoTasa','TipoTasa'
GO

/****** TipoTasa ******/
if (select version from version)<=2611
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.TipoInteres') and type = 'U') drop table TipoInteres")
  EXEC("DELETE SysTabla where SysTabla = 'TipoInteres'")
END
GO
if (select version from version)<=2613
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.TipoTasa') and type = 'U') drop table TipoTasa")
END
GO
if not exists(select * from SysTabla where SysTabla = 'TipoTasa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoTasa','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.TipoTasa') and type = 'U') 
CREATE TABLE dbo.TipoTasa (
	TipoTasa      		varchar(20) 	NOT NULL,

	Descripcion		varchar(100)	NULL,
        EsTasaFija              bit	        NULL	DEFAULT 0,
        TasaFija                float	        NULL,        -- Tasa Fija

        TasaBase                varchar(50)     NULL,        -- TIIE 
        TasaBase2               varchar(50)     NULL,        -- TIIE 
        TasaBase3               varchar(50)     NULL,        -- TIIE 
        SobreTasa               float           NULL,
        SobreTasaEn             varchar(20)     NULL,        -- Puntos / %
	TasaTotalMinima         float           NULL,        
        TasaTotalMaxima         float           NULL,        

	MoratoriosFactor        float           NULL,
	PagoAnticipadoFactor	float		NULL,
	ImpuestoIncluido	float		NULL,

	RetencionPuntos		float		NULL,
	ComisionPorcentaje	float		NULL,	

	Estatus			varchar(15)	NULL,

	CONSTRAINT priTipoTasa PRIMARY KEY  CLUSTERED (TipoTasa)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TipoTasa' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.TipoTasa (Descripcion)
GO
EXEC spALTER_TABLE 'TipoTasa', 'RetencionPuntos', 'float NULL'
EXEC spALTER_TABLE 'TipoTasa', 'ComisionPorcentaje', 'float NULL'
GO


if exists (select * from sysobjects where id = object_id('dbo.tgTipoTasaAC') and sysstat & 0xf = 8) drop trigger dbo.tgTipoTasaAC
GO
CREATE TRIGGER tgTipoTasaAC ON TipoTasa
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @EsTasaFija	bit,
    @TasaBase	varchar(50),
    @SobreTasa	float,
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EsTasaFija = ISNULL(EsTasaFija, 0), @TasaBase = NULLIF(RTRIM(TasaBase), ''), @SobreTasa = NULLIF(SobreTasa, 0.0) 
    FROM Inserted

  IF @EsTasaFija = 0 AND (@TasaBase IS NULL OR @SobreTasa IS NULL)
  BEGIN
    SELECT @Mensaje = Descripcion + ' Tasa / SobreTasa' FROM MensajeLista WHERE Mensaje = 10010
    RAISERROR (@Mensaje,16,-1) 
  END
END
GO

/****** TipoAmortizacion ******/
if (select version from version)<=2611
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.FormaAmortizacion') and type = 'U') drop table FormaAmortizacion")
  EXEC("DELETE SysTabla where SysTabla = 'FormaAmortizacion'")
END
GO

if not exists(select * from SysTabla where SysTabla = 'TipoAmortizacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TipoAmortizacion','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.TipoAmortizacion') and type = 'U') 
CREATE TABLE dbo.TipoAmortizacion (
	TipoAmortizacion	varchar(20)	NOT NULL,

	Descripcion		varchar(100)	NULL,
	Metodo			int		NULL,        
        PagoInhabiles           varchar(20)     NULL,        
        PagoVencimiento         varchar(20)     NULL,        -- Dias / Dia Especifico / Fin Mes
        PagoDias                int             NULL,
	PeriodosGraciaCapital	int		NULL,
	ComisionesFinanciadas	bit		NULL	DEFAULT 0,
	ReinversionAutomatica	bit		NULL	DEFAULT 0,

	Estatus			varchar(15)	NULL,

	CONSTRAINT priTipoAmortizacion PRIMARY KEY  CLUSTERED (TipoAmortizacion)
)
GO
if (select version from version)<=2612
BEGIN
  EXEC("IF EXISTS(SELECT * FROM SysCampo WHERE Tabla='TipoAmortizacion' AND Campo='PagoCapital') ALTER TABLE TipoAmortizacion DROP COLUMN PagoCapital")
  EXEC("IF EXISTS(SELECT * FROM SysCampo WHERE Tabla='TipoAmortizacion' AND Campo='PagoInteres') ALTER TABLE TipoAmortizacion DROP COLUMN PagoInteres")
END
GO
EXEC spALTER_TABLE 'TipoAmortizacion', 'Metodo', 'int NULL'
EXEC spALTER_TABLE 'TipoAmortizacion', 'ComisionesFinanciadas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TipoAmortizacion', 'ReinversionAutomatica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TipoAmortizacion', 'DiasIncluirUltima', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TipoAmortizacion', 'FinMes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'TipoAmortizacion', 'PagoDiasQ1',  'int NULL'
EXEC spALTER_TABLE 'TipoAmortizacion', 'PagoDiasQ2',  'int NULL'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TipoAmortizacion' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.TipoAmortizacion (Descripcion)
GO

EXEC spFK 'TipoAmortizacion','Metodo','MetodoAmortizacion','Numero'
GO

/****** Documentacion del Credito ******/
if not exists(select * from SysTabla where SysTabla = 'LCDoc')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCDoc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LCDoc') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCDoc (
	LineaCredito 		varchar(20) 	NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

        Tipo                    varchar(20)     NULL,        -- LCDocTipo
        Referencia              varchar(50)     NULL,
        Fecha                   datetime        NULL,
        Estado                  varchar(30)     NULL,
        Almacen                 char(10)        NULL,

	CONSTRAINT priLCDoc PRIMARY KEY  CLUSTERED (LineaCredito, ID)
  )
  EXEC spSincroSemilla 'LCDoc'
END
go

/****** Cuentas del Credito ******/
if not exists(select * from SysTabla where SysTabla = 'LCCtaDinero')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCCtaDinero','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LCCtaDinero') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCCtaDinero (
	LineaCredito 		varchar(20) 	NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

	CtaDinero		char(10)	NULL,
	Importe			money		NULL,

	CONSTRAINT priLCCtaDinero PRIMARY KEY  CLUSTERED (LineaCredito, ID)
  )
  EXEC spSincroSemilla 'LCCtaDinero'
END
go

-- drop table lcgasto
/****** Gastos ******/
if not exists(select * from SysTabla where SysTabla = 'LCGasto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCGasto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LCGasto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCGasto (
	LineaCredito 		varchar(20) 	NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

	Concepto		varchar(50)	NULL,
	Importe			money		NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priLCGasto PRIMARY KEY  CLUSTERED (LineaCredito, ID)
  )
  EXEC spSincroSemilla 'LCGasto'
END
go

/****** Garantias del Credito ******/
if not exists(select * from SysTabla where SysTabla = 'LCGarantia')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCGarantia','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LCGarantia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCGarantia (
	LineaCredito 		varchar(20) 	NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

        Tipo                    varchar(20)     NULL,        -- Hipotecaria/Fiduciaria/Quirografaria/Prendaria
        Referencia              varchar(50)     NULL,
        Fecha                   datetime        NULL,
        Estado                  varchar(30)     NULL,
        Almacen                 char(10)        NULL,
        Importe                 money           NULL,
        Moneda                  char(10)        NULL,
	Descripcion		varchar(255)	NULL,
	Avaluo1Fecha		datetime	NULL,
	Avaluo1Importe		money		NULL,
	Avaluo2Fecha		datetime	NULL,
	Avaluo2Importe		money		NULL,

	CONSTRAINT priLCGarantia PRIMARY KEY  CLUSTERED (LineaCredito, ID)
  )
  EXEC spSincroSemilla 'LCGarantia'
END
go
EXEC spALTER_TABLE 'LCGarantia', 'Descripcion', 'varchar(255) NULL'
EXEC spALTER_TABLE 'LCGarantia', 'Avaluo1Fecha','datetime NULL'
EXEC spALTER_TABLE 'LCGarantia', 'Avaluo1Importe','money NULL'
EXEC spALTER_TABLE 'LCGarantia', 'Avaluo2Fecha','datetime NULL'
EXEC spALTER_TABLE 'LCGarantia', 'Avaluo2Importe','money NULL'
go

/****** Avales del Credito ******/
if not exists(select * from SysTabla where SysTabla = 'LCAval')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCAval', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.LCAval') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCAval (
	LineaCredito 		varchar(20) 	NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

        Aval                    char(10)        NULL,        -- Clientes
        Referencia              varchar(50)     NULL,
        Fecha                   datetime        NULL,
        Estado                  varchar(30)     NULL,
        Importe                 money           NULL,
        Moneda                  char(10)        NULL,

	CONSTRAINT priLCAval PRIMARY KEY  CLUSTERED (LineaCredito, ID)
  )
  EXEC spSincroSemilla 'LCAval'
END
go

EXEC spFK 'LCAval','LineaCredito','LC','LineaCredito'
GO

/*
        CapacidadCredito        money           NULL,
        CreditosExistentes      money           NULL,
        CapacidadPago           money           NULL,

        Reestructurado          bit             NULL        DEFAULT 0,

*/

/****** Historico Linea Credito ******/
if not exists(select * from SysTabla where SysTabla = 'LCHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LCHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.LCHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.LCHist (
	LineaCredito   		varchar(20) 	NOT NULL,
	FechaCambio		datetime	NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Uso			varchar(20)	NULL,
        Fecha		        datetime        NULL,
	Descripcion		varchar(100)    NULL,
	TipoCredito		varchar(50)	NULL,        
		
        Acreditado              varchar(10)     NULL,
	Coacreditado		varchar(10)     NULL,
	Acreedor		varchar(10)     NULL,
        Agente                  char(10)        NULL,

	VigenciaDesde		datetime	NULL,
	VigenciaCondicion	varchar(50)    	NULL,
	VigenciaHasta		datetime	NULL,


	Importe			money		NULL,
        Moneda                  char(10)        NULL,
        DisposicionTipo         varchar(20)     NULL,
        DisposicionPlazoMinimo  int             NULL,
        DisposicionPlazoMaximo  int             NULL,

	Condicion		varchar(50)     NULL,
	TipoTasa		varchar(20)	NULL,
	TipoAmortizacion	varchar(20)	NULL,

	Estatus 		char(15) 	NOT NULL,
        Situacion               varchar(50)     NULL,
        SituacionFecha          datetime        NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	Reestructurada		bit		NULL,
	CarteraVencidaCBNV	bit		NULL,
	Calificacion        	char(2)		NULL,

	UsuarioCambio		char(10)	NULL,

	CONSTRAINT priLCHist PRIMARY KEY CLUSTERED (LineaCredito, FechaCambio, RID)
  )
  EXEC spSincroSemilla 'LCHist'
END
go
EXEC spALTER_TABLE 'LCHist', 'CarteraVencidaCBNV', 'bit NULL'
EXEC spALTER_TABLE 'LCHist', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'LCHist', 'SituacionNota', 'varchar(100) NULL'
go

/****** Linea Credito ******/
if (select version from version)<=2611 and exists (select * from sysobjects where id = object_id('dbo.LC') and type = 'U') 
  drop table LC
GO
if not exists(select * from SysTabla where SysTabla = 'LC')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('LC','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.LC') and type = 'U') 
CREATE TABLE dbo.LC (
	LineaCredito   		varchar(20) 	NOT NULL,

	LineaMaestra		varchar(20)	NULL,
	Uso			varchar(20)	NULL,	--	Colocacion / Fondeo
        Fecha		        datetime        NULL,
	Descripcion		varchar(100)    NULL,
	TipoCredito		varchar(50)	NULL,        
		
	Codigo			varchar(30)     NULL,
        Acreditado              varchar(10)     NULL,
	Coacreditado		varchar(10)     NULL,
	Acreedor		varchar(10)     NULL,
	AcreedorSucursal	int		NULL,
        Agente                  char(10)        NULL,

	VigenciaDesde		datetime	NULL,
	VigenciaCondicion	varchar(50)    	NULL,
	VigenciaHasta		datetime	NULL,

	Importe			money		NULL,
        Moneda                  char(10)        NULL,
        DisposicionTipo         varchar(20)     NULL,        -- Revolvente / Parcial / Total
        DisposicionPlazoMinimo  int             NULL,
        DisposicionPlazoMaximo  int             NULL,

	Condicion		varchar(50)     NULL,
	TipoTasa		varchar(20)	NULL,
	TipoTasaBonificacion	varchar(20)	NULL,
	TipoAmortizacion	varchar(20)	NULL,
        PeriodosGraciaCapital	int		NULL,

	Estatus 		char(15) 	NOT NULL,
        Situacion               varchar(50)     NULL,
        SituacionFecha          datetime        NULL,
	SituacionUsuario	varchar(10)	NULL,
	SituacionNota		varchar(100)	NULL,

	UltimoCambio 		datetime  	NULL,
	UsuarioCambio		char(10)	NULL,
	Alta			datetime	NULL,
        NivelAcceso		varchar(50)	NULL,
	Reestructurada		bit		NULL	DEFAULT 0,
	CarteraVencidaCBNV	bit		NULL	DEFAULT 0,
	Calificacion        	char(2)		NULL,
	MinistracionHipotecaria bit		NULL	DEFAULT 0,

	Empresa			char(5)		NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	Contrato		varchar(20)	NULL,
	ContratoFolio		int		NULL,

	SeguroImporte		money		NULL,
	SeguroImpuestos		money		NULL,
	SeguroAmortizar		bit		NULL	DEFAULT 0,
	PorcentajeResidual	float		NULL,
	CobroIntereses		varchar(20)	NULL,
	TieneImporteFijo	bit		NULL	DEFAULT 0,
	ImporteFijo		money		NULL,

	Referencia1		varchar(50)	NULL,
	Referencia2		varchar(50)	NULL,
	Referencia3		varchar(50)	NULL,

	Fecha1			datetime	NULL,
	Fecha2			datetime	NULL,
	Fecha3			datetime	NULL,

	ReferenciaOk1		bit		NULL,
	ReferenciaOk2		bit		NULL,
	ReferenciaOk3		bit		NULL,
	Express			bit		NULL	DEFAULT 0,

	CONSTRAINT priLC PRIMARY KEY CLUSTERED (LineaCredito)
)
go
if exists (select * from sysobjects where id = object_id('dbo.tgLCBC') and sysstat & 0xf = 8) drop trigger dbo.tgLCBC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgLCABC') and sysstat & 0xf = 8) drop trigger dbo.tgLCABC
GO
EXEC spALTER_TABLE 'LC', 'Uso', 'varchar(20) NULL DEFAULT "Colocacion" WITH VALUES'
EXEC spALTER_TABLE 'LC', 'Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'LC', 'Reestructurada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'CarteraVencidaCBNV', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'Calificacion', 'char(2) NULL'
EXEC spALTER_TABLE 'LC', 'UsuarioCambio', 'char(10) NULL'
EXEC spALTER_TABLE 'LC', 'PeriodosGraciaCapital', 'int NULL'
EXEC spALTER_TABLE 'LC', 'TipoTasaBonificacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LC', 'MinistracionHipotecaria', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'Empresa', 'char(5) NULL'
EXEC spALTER_TABLE 'LC', 'TieneTasaEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'TasaEsp', 'float NULL'
EXEC spALTER_TABLE 'LC', 'Contrato', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LC', 'ContratoFolio', 'int NULL'
EXEC spALTER_TABLE 'LC', 'SeguroImporte', 'money NULL'
EXEC spALTER_TABLE 'LC', 'SeguroImpuestos', 'money NULL'
EXEC spALTER_TABLE 'LC', 'SeguroAmortizar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'PorcentajeResidual', 'float NULL'
GO
if not exists(select * from syscampo where tabla='LC' and campo='CobroIntereses')
BEGIN
  EXEC spALTER_TABLE 'LC', 'CobroIntereses', 'varchar(20) NULL'
  EXEC ("UPDATE LC SET CobroIntereses = e.ACCobroIntereses FROM LC JOIN EmpresaCfg e ON e.Empresa = lc.Empresa")
END
GO
EXEC spALTER_TABLE 'LC', 'LineaMaestra', 'varchar(20) NULL'
EXEC spALTER_TABLE 'LC', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'LC', 'TieneImporteFijo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'ImporteFijo', 'money NULL'
EXEC spALTER_TABLE 'LC', 'SituacionNota', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'LC', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'LC', 'AcreedorSucursal', 'int NULL'
EXEC spALTER_TABLE 'LC', 'Referencia1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'LC', 'Referencia2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'LC', 'Referencia3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'LC', 'Fecha1', 'datetime NULL'
EXEC spALTER_TABLE 'LC', 'Fecha2', 'datetime NULL'
EXEC spALTER_TABLE 'LC', 'Fecha3', 'datetime NULL'
EXEC spALTER_TABLE 'LC', 'ReferenciaOk1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'ReferenciaOk2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'ReferenciaOk3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'LC', 'Express', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spFK2 'LC','Acreedor','AcreedorSucursal','ProvSucursal','Proveedor','ID'
EXEC spFK 'LC','Acreditado','Cte','Cliente'
EXEC spFK 'LC','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'LC','TipoTasa','TipoTasa','TipoTasa'
GO

-- Aqui va el mantenimiento a la tabla

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LC' AND sysindexes.name = 'Descripcion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Descripcion ON dbo.LC (Descripcion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LC' AND sysindexes.name = 'Acreditado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Acreditado ON dbo.LC (Acreditado)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LC' AND sysindexes.name = 'Coacreditado' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Coacreditado ON dbo.LC (Coacreditado)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LC' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion ON dbo.LC (Situacion, Estatus)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'LC' AND sysindexes.name = 'Codigo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Codigo ON dbo.LC (Codigo)
go
CREATE TRIGGER tgLCABC ON LC
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  INSERT LCHist (LineaCredito, FechaCambio, Uso, Fecha, Descripcion, TipoCredito, Acreditado, Coacreditado, Acreedor, Agente, VigenciaDesde, VigenciaCondicion, VigenciaHasta, Importe, Moneda, DisposicionTipo, DisposicionPlazoMinimo, DisposicionPlazoMaximo, Condicion, TipoTasa, TipoAmortizacion, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Reestructurada, Calificacion, UsuarioCambio)
         SELECT LineaCredito,   GETDATE(),   Uso, Fecha, Descripcion, TipoCredito, Acreditado, Coacreditado, Acreedor, Agente, VigenciaDesde, VigenciaCondicion, VigenciaHasta, Importe, Moneda, DisposicionTipo, DisposicionPlazoMinimo, DisposicionPlazoMaximo, Condicion, TipoTasa, TipoAmortizacion, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, Reestructurada, Calificacion, UsuarioCambio
           FROM Inserted
  DECLARE
    @LineaCreditoN	char(20),
    @LineaCreditoA	char(20)

  SELECT @LineaCreditoN = LineaCredito FROM Inserted
  SELECT @LineaCreditoA = LineaCredito FROM Deleted

  IF @LineaCreditoN=@LineaCreditoA RETURN

  IF @LineaCreditoN IS NULL 
  BEGIN
    DELETE LCAval     WHERE LineaCredito = @LineaCreditoN
    DELETE LCGarantia WHERE LineaCredito = @LineaCreditoN
    DELETE LCDoc      WHERE LineaCredito = @LineaCreditoN
  END ELSE 
  IF @LineaCreditoN <> @LineaCreditoA AND @LineaCreditoA IS NOT NULL
  BEGIN
    UPDATE LCAval     SET LineaCredito = @LineaCreditoN WHERE LineaCredito = @LineaCreditoA
    UPDATE LCGarantia SET LineaCredito = @LineaCreditoN WHERE LineaCredito = @LineaCreditoA
    UPDATE LCDoc      SET LineaCredito = @LineaCreditoN WHERE LineaCredito = @LineaCreditoA
  END
END
GO


/****** TablaAmortizacion ******/
if (select version from version)<=2611
begin
  EXEC ("IF exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacion') and type = 'U') DROP TABLE TablaAmortizacion")
  EXEC ("delete systabla where systabla = 'TablaAmortizacion'")
END
if (select version from version)<=2615 AND exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacion') and type = 'U') 
  DROP TABLE TablaAmortizacion
go
if not exists (select * from SysTabla where SysTabla = 'TablaAmortizacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacion','Movimiento')
--INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacion') and type = 'U') 
CREATE TABLE dbo.TablaAmortizacion (
	Modulo						char(5)		NOT NULL,
	ID							int       	NOT NULL,
	Amortizacion				int		NOT NULL,

	FechaD						datetime	NULL,
	FechaA						datetime	NULL,
	SaldoInicial				money		NULL,
	Capital						money		NULL,
	Intereses					money		NULL,
	IVAInteres					float		NULL, --MEJORA10041
	IVAInteresPorcentaje		float		NULL, --MEJORA10041
	CxcID						int			NULL,
	CxpID						int			NULL,
	Retencion					money		NULL,
	CONSTRAINT priTablaAmortizacion PRIMARY KEY CLUSTERED (ID, Modulo, Amortizacion)
)
GO
EXEC spALTER_TABLE 'TablaAmortizacion', 'Retencion','money NULL'
GO
EXEC spALTER_TABLE 'TablaAmortizacion', 'IVAInteres','float NULL' --MEJORA10041
EXEC spALTER_TABLE 'TablaAmortizacion', 'IVAInteresPorcentaje','float NULL' --MEJORA10041
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TablaAmortizacion' AND sysindexes.name = 'CxcID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CxcID ON dbo.TablaAmortizacion (CxcID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TablaAmortizacion' AND sysindexes.name = 'CxpID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CxpID ON dbo.TablaAmortizacion (CxpID)
GO

/*
 EXEC spSincroNivelRegistro 0
 EXEC spSincroNivelTabla 0
*/

DELETE SysTabla WHERE SysTabla IN ('AC', 'ACAplica', 'ACArt', 'ACAuxiliar', 'ACC', 'ACD', 'ACPago', 'ACSaldo')
GO

if not exists(select * from syscampo where tabla = 'TablaAmortizacionGuia' and campo = 'RID')
BEGIN
  EXEC("if exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacionGuia') and type = 'U') drop table TablaAmortizacionGuia")
END
GO

EXEC spFK 'TablaAmortizacion','CxcID','Cxc','ID'
EXEC spFK 'TablaAmortizacion','CxpID','Cxp','ID'
GO

/****** TablaAmortizacionGuia ******/
if not exists (select * from SysTabla where SysTabla = 'TablaAmortizacionGuia') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacionGuia','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacionGuia','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacionGuia') and type = 'U') 
BEGIN
  CREATE TABLE dbo.TablaAmortizacionGuia (
	Modulo			char(5)		NOT NULL,
	ID 			int       	NOT NULL,
	RID			int		NOT NULL IDENTITY(1,1),

	Vencimiento		datetime	NULL,
	Capital			money		NULL,

	CONSTRAINT priTablaAmortizacionGuia PRIMARY KEY CLUSTERED (ID, Modulo, RID)
  )
  EXEC spSincroSemilla 'TablaAmortizacionGuia'
END
GO

/****** TablaAmortizacionMigracion ******/
if not exists (select * from SysTabla where SysTabla = 'TablaAmortizacionMigracion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacionMigracion','Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaAmortizacionMigracion','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.TablaAmortizacionMigracion') and type = 'U') 
CREATE TABLE dbo.TablaAmortizacionMigracion (
	Modulo							char(5)		NOT NULL,
	ID 								int       	NOT NULL,
	Amortizacion					int		NOT NULL,

	FechaD							datetime	NULL,
	FechaA							datetime	NULL,
	SaldoInicial					money		NULL,
	Capital							money		NULL,
	Intereses						money		NULL,
	IVAInteres						float	NULL, --MEJORA10041
	IVAInteresPorcentaje			float	NULL, --MEJORA10041	

	InteresesOrdinarios				money		NULL,
	InteresesOrdinariosIVA			float		NULL, --MEJORA10041
	InteresesMoratorios				money		NULL,
	InteresesMoratoriosIVA			float		NULL, --MEJORA10041	
	TasaDiaria						float		NULL,

	Pendiente						bit		NULL	DEFAULT 1,
	FechaCobro						datetime	NULL,

	CONSTRAINT priTablaAmortizacionMigracion PRIMARY KEY CLUSTERED (ID, Modulo, Amortizacion)
)
GO
EXEC spALTER_TABLE 'TablaAmortizacionMigracion', 'FechaCobro', 'datetime NULL'
GO
EXEC spALTER_TABLE 'TablaAmortizacionMigracion', 'IVAInteres','float NULL' --MEJORA10041
EXEC spALTER_TABLE 'TablaAmortizacionMigracion', 'IVAInteresPorcentaje','float NULL' --MEJORA10041
EXEC spALTER_TABLE 'TablaAmortizacionMigracion', 'InteresesOrdinariosIVA','float NULL' --MEJORA10041
EXEC spALTER_TABLE 'TablaAmortizacionMigracion', 'InteresesMoratoriosIVA','float NULL' --MEJORA10041
GO

/****** TablaArrendamiento ******/
/*if not exists (select * from SysTabla where SysTabla = 'TablaArrendamiento') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaArrendamiento','N/A')*/
/*if not exists (select * from sysobjects where id = object_id('dbo.TablaArrendamiento') and type = 'U') 
CREATE TABLE dbo.TablaArrendamiento (
	Modulo			char(5)		NOT NULL,
	ID 			int       	NOT NULL,
        Amortizacion		int		NOT NULL,

	FechaD			datetime	NULL,
	FechaA			datetime	NULL,
	SaldoInicial		money		NULL,
	Fijo			money		NULL,
	Variable		money		NULL,
	Seguro			money		NULL,
	IVA			money		NULL,

	CxcID			int		NULL,

	CONSTRAINT priTablaArrendamiento PRIMARY KEY CLUSTERED (Modulo, ID, Amortizacion)
)*/
GO
/*if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'TablaArrendamiento' AND sysindexes.name = 'CxcID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX CxcID ON dbo.TablaArrendamiento (CxcID)*/
GO


/****** ACInversionAuto ******/
if not exists(select * from SysTabla where SysTabla = 'ACInversionAuto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ACInversionAuto','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ACInversionAuto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ACInversionAuto (
	CxpID			int		NOT NULL,
        ID                      int             NOT NULL IDENTITY(1,1),

	Accion			varchar(20)	NULL,	-- Retiro/Renovacion/Deposito
	Importe			money		NULL,
	CtaDinero		varchar(10)	NULL,
	Beneficiario		varchar(100)	NULL,
	Nota			varchar(100)	NULL,
	TipoCredito        	varchar(50) 	NULL,
	TipoTasa		varchar(20)	NULL,
	Condicion		varchar(50)     NULL,

	CONSTRAINT priACInversionAuto PRIMARY KEY  CLUSTERED (CxpID, ID)
  )
  EXEC spSincroSemilla 'ACInversionAuto'
END
go

EXEC spFK 'ACInversionAuto','TipoTasa','TipoTasa','TipoTasa'
EXEC spFK 'ACInversionAuto','CtaDinero','CtaDinero','CtaDinero'
GO