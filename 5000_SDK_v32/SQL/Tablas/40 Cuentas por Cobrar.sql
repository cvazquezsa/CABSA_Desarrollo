/*******************************************************************************************/
/*                                      CUENTAS POR COBRAR                                 */
/*******************************************************************************************/

/****** MovRef ******/
if not exists (select * from SysTabla where SysTabla = 'MovRef') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovRef','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.MovRef') and type = 'U') 
  CREATE TABLE dbo.MovRef (
	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5)		NOT NULL,
	Contacto		varchar(10)	NOT NULL,
	Mov			varchar(20)	NOT NULL,
	MovID			varchar(20)	NOT NULL,

	Referencia		varchar(50)	NULL,
	FechaEmision		datetime	NULL,
	Vencimiento		datetime	NULL,
	EnviarA			int		NULL,

	CONSTRAINT priMovRef PRIMARY KEY  CLUSTERED (Contacto, MovID, Mov, Modulo, Empresa)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'MovRef' AND sysindexes.name = 'MovID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovID ON dbo.MovRef (MovID, Mov, Modulo, Empresa)
GO

/****** Cuentas por Cobrar ******/
if not exists (select * from SysTabla where SysTabla = 'CxcC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CxcC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CxcC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxcC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCxcC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CxcC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CxcC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CxcC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE CxcC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** CxcPersonalCobradorLog ******/
if (select version from version)<=2098 delete systabla where systabla = 'CxcPersonalCobradorLog'
go
if not exists (select * from SysTabla where SysTabla = 'CxcPersonalCobradorLog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CxcPersonalCobradorLog','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.CxcPersonalCobradorLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxcPersonalCobradorLog (
	ID 			int         	NOT NULL,
	Fecha			datetime	NOT NULL,
	PersonalCobrador	varchar(10)	NOT NULL,

	CONSTRAINT priCxcPersonalCobradorLog PRIMARY KEY CLUSTERED (ID, Fecha, PersonalCobrador)
  )
END
GO

/****** Cxc (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'Cxc') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Cxc','Movimiento','CXC')
if not exists (select * from sysobjects where id = object_id('dbo.Cxc') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Cxc (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov			varchar(20)        NOT NULL,        -- tipo de movimiento Factura, Cobro, Bonificacion, etc.
	MovID			varchar(20)    	NULL,	     -- consecutivo a asignar en la afectacion
	FechaEmision 		datetime    	NULL,	     -- fecha original en la que se realiza el movimiento
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda  		varchar(10)   	NOT NULL,
	TipoCambio		float		NULL,
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

	Codigo			varchar(30)	NULL,
	Cliente 		varchar(10)   	NOT NULL,	
	ClienteEnviarA		int		NULL,
	ClienteMoneda		varchar(10)	NULL,
	ClienteTipoCambio	float		NULL,
	CtaDinero		varchar(10)        NULL,       
	Cobrador 		varchar(50)   	NULL,
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	FormaCobro		varchar(50)	NULL,
	Importe   		money       	NULL,	 -- Importe sin Iva y sin Descuentos
	Impuestos	        money       	NULL,
	Retencion			money       	NULL,
	Retencion2			float       	NULL, --MEJORA4648	
	Retencion3			float       	NULL, --MEJORA4648		
	AplicaManual		bit		NOT NULL DEFAULT 0,
	ConDesglose		bit		NOT NULL DEFAULT 0,
	FormaCobro1 		varchar(50)   	NULL,
	FormaCobro2 		varchar(50)   	NULL,
	FormaCobro3 		varchar(50)   	NULL,
	FormaCobro4 		varchar(50)   	NULL,
	FormaCobro5 		varchar(50)   	NULL,
	Importe1		float		NULL,
	Importe2		float		NULL,
	Importe3		float		NULL,
	Importe4		float		NULL,
	Importe5		float		NULL,
	Referencia1		varchar(50)   	NULL,
	Referencia2		varchar(50)   	NULL,
	Referencia3		varchar(50)   	NULL,
	Referencia4		varchar(50)   	NULL,
	Referencia5		varchar(50)	NULL,
	Cambio			money		NULL,
	DelEfectivo		money		NULL,

	Agente			varchar(10)	NULL, -- El Agente y su comision se carga al generar la factura
	ComisionTotal		money		NULL,
	ComisionPendiente	money		NULL, -- La comision pendiente se abona al disminur el saldo de la factura en forma proporcional.
	ComisionGenerada	money		NULL,
	ComisionCorte		datetime	NULL,

	MovAplica		varchar(20)	NULL,
	MovAplicaID		varchar(20)	NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,
    NoAutoAjustar   bit NULL	DEFAULT 0,
    NoAutoAplicar   bit NULL	DEFAULT 0,		--BUG10848

	OrigenTipo		varchar(10)	NULL,
	Origen			varchar(20)	NULL,
	OrigenID		varchar(20)	NULL,

	Poliza			varchar(20)     NULL,
	PolizaID		varchar(20)	NULL,
	GenerarPoliza		bit	    	NOT NULL DEFAULT 0,
	ContID			int		NULL,

	Ejercicio		int		NULL,
	Periodo			int		NULL,
	FechaRegistro		datetime	NULL,
	FechaConclusion		datetime    	NULL,
	FechaCancelacion	datetime    	NULL,
	FechaProntoPago		datetime    	NULL,
	DescuentoProntoPago	float		NULL,
	Indirecto		bit		NOT NULL DEFAULT 0,

	GenerarDinero		bit		NOT NULL DEFAULT 0,
	Dinero			varchar(20)	NULL,
	DineroID		varchar(20)	NULL,
	DineroCtaDinero		varchar(10)	NULL,
	DineroConciliado	bit		NULL     DEFAULT 0,
	DineroFechaConciliacion datetime	NULL,

	VIN			varchar(20)	NULL,

	FechaEntrega		datetime    	NULL,
	EmbarqueEstado		varchar(50)	NULL,

	Sucursal		int		NOT NULL DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,

	ConTramites		bit		NOT NULL DEFAULT 0,
	Cajero			varchar(10)	NULL,
	IVAFiscal		float		NULL,	
	IEPSFiscal		float		NULL,	
	DiferenciaCambiaria	money		NULL,
	EstaImpreso		bit		NULL	  DEFAULT 0,

	AnticipoAplicar		money		NULL,
	AnticipoAplicaModulo	varchar(5)		NULL	  DEFAULT 'VTAS',
	AnticipoAplicaID	int		NULL,
	AnticipoSaldo		money		NULL,
	PersonalCobrador	varchar(10)	NULL,
	FechaOriginal		datetime	NULL,
	Comentarios		text		NULL,
	Nota			varchar(100)	NULL,

	RamaID			int		NULL,
	Tasa			varchar(50)	NULL,
	TasaDiaria		float		NULL,
	TasaRealDiaria	float		NULL, --MEJORA10041

	LineaCredito		varchar(20)	NULL,
 	TipoTasa		varchar(20)	NULL,
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,
	TipoAmortizacion	varchar(20)	NULL,
	Amortizaciones		int		NULL,
	InteresesAnticipados	money		NULL,
	InteresesFijos				money		NULL,
	InteresesOrdinarios			money		NULL,
	InteresesMoratorios			money		NULL,
	InteresesOrdinariosIVA		float		NULL, --MEJORA10041
	InteresesMoratoriosIVA		float		NULL, --MEJORA10041
	--FechaIntereses		datetime	NULL,

	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,
	CarteraVencidaCNBV	bit		NULL	DEFAULT 0,
	FechaRevision		datetime	NULL,
	OperacionRelevante	bit 		NULL 	DEFAULT 0,
	ContUso				varchar(20) 	NULL,
	ContUso2			varchar(20) 	NULL, --MEJORA4752	
	ContUso3			varchar(20) 	NULL, --MEJORA4752		
	SaldoInteresesOrdinarios		money	NULL,
	SaldoInteresesMoratorios		money	NULL,
	SaldoInteresesOrdinariosIVA		float		NULL, --MEJORA10041
	SaldoInteresesMoratoriosIVA		float		NULL, --MEJORA10041
	IVAInteresPorcentaje			float		NULL, --MEJORA10041
	
	SubModulo		varchar(5)	NULL	DEFAULT 'CXC',

	ContratoID		int		NULL,
	ContratoMov		varchar(20)	NULL,
	ContratoMovID		varchar(20)	NULL,

	EsInteresFijo				bit NULL DEFAULT 0, --MEJORA10041
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 
 	POSGUID                 varchar(50)	NULL,--REQ 15448
	
	CONSTRAINT priCxc PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Cxc'
END
GO
EXEC spSincroNivelRegistro @Tabla = 'Cxc'
GO
if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Cxc.Consecutivo
  ALTER TABLE Cxc ALTER COLUMN MovID varchar(20)
  ALTER TABLE Cxc ALTER COLUMN MovAplicaID varchar(20)
  ALTER TABLE Cxc ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Cxc ALTER COLUMN PolizaID varchar(20)
  ALTER TABLE Cxc ALTER COLUMN DineroID varchar(20)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.tgCxcA') and sysstat & 0xf = 8) drop trigger dbo.tgCxcA
go
if exists (select * from sysobjects where id = object_id('dbo.tgCxcC') and sysstat & 0xf = 8) drop trigger dbo.tgCxcC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCxcB') and sysstat & 0xf = 8) drop trigger dbo.tgCxcB
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCxcRef') and sysstat & 0xf = 8) drop trigger dbo.tgCxcRef
GO
EXEC spModificarPK_Mov 'Cxc'
GO
-- Trigger SincroC despues de triggers
EXEC spSincroNivelRegistroCampos 'Cxc'
GO
EXEC spALTER_TABLE 'Cxc', 'Cajero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxc', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Cxc', 'IEPSFiscal', 'float NULL'
EXEC spALTER_TABLE 'Cxc', 'DiferenciaCambiaria', 'money	NULL'
EXEC spALTER_TABLE 'Cxc', 'ComisionGenerada', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'ComisionCorte', 'datetime NULL'
EXEC spALTER_TABLE 'Cxc', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'AnticipoAplicar', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'AnticipoAplicaModulo', 'varchar(5) NULL DEFAULT "VTAS" WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'AnticipoAplicaID', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'AnticipoSaldo', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'PersonalCobrador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxc', 'DineroConciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'DineroFechaConciliacion', 'datetime NULL'
EXEC spALTER_TABLE 'Cxc', 'FechaOriginal', 'datetime NULL'
EXEC spALTER_TABLE 'Cxc', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Cxc', 'Nota', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'Cxc', 'Tasa', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cxc', 'TasaDiaria', 'float NULL'
EXEC spALTER_TABLE 'Cxc', 'RamaID', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'LineaCredito', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'TipoAmortizacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'TipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'Amortizaciones', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'InteresesAnticipados', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'InteresesFijos', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'InteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'InteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'CarteraVencidaCNBV', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'Cxc', 'Comisiones', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'ComisionesIVA', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'FechaRevision', 'datetime NULL'
EXEC spALTER_TABLE 'Cxc', 'OperacionRelevante','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'TieneTasaEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'TasaEsp', 'float NULL'
EXEC spALTER_TABLE 'Cxc', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxc', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cxc', 'Codigo', 'varchar(30) NULL'
EXEC spDROP_COLUMN 'Cxc', 'FechaIntereses'
GO
EXEC spDROP_COLUMN 'Cxc', 'AcumInteresesOrdinarios'
EXEC spDROP_COLUMN 'Cxc', 'AcumInteresesMoratorios'
EXEC spALTER_TABLE 'Cxc', 'SaldoInteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'SaldoInteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'SubModulo', 'varchar(5) NULL DEFAULT "CXC" WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'ContratoMovID', 'varchar(20) NULL'
-- 6024
EXEC spALTER_TABLE 'Cxc', 'NoAutoAjustar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--BUG10848
EXEC spALTER_TABLE 'Cxc', 'NoAutoAplicar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
		
EXEC spALTER_TABLE 'Cxc', 'Retencion2', 'float NULL'
EXEC spALTER_TABLE 'Cxc', 'Retencion3', 'float NULL'
GO
EXEC spALTER_TABLE 'Cxc', 'ContUso2', 'varchar(20) NULL' --MEJORA4752
EXEC spALTER_TABLE 'Cxc', 'ContUso3', 'varchar(20) NULL' --MEJORA4752
GO
EXEC spALTER_TABLE 'Cxc', 'TasaRealDiaria', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'InteresesOrdinariosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'InteresesMoratoriosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'SaldoInteresesOrdinariosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'SaldoInteresesMoratoriosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'IVAInteresPorcentaje', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxc', 'EsInteresFijo', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA10041
GO

--REQ13163
EXEC spALTER_TABLE 'Cxc', 'TarjetaBancariaAutorizacion', 'varchar(255) NULL'
GO
 --REQ 15739 
Exec spAlter_Table 'Cxc','CFDFlexEstatus','varchar(15) Null'
--Task 18909
EXEC spALTER_TABLE 'Cxc', 'CFDTimbrado', 'bit NULL DEFAULT 0 WITH VALUES'


--REQ 15448
 EXEC spALTER_TABLE 'Cxc', 'PedidoReferencia','varchar(50)	NULL'
 EXEC spALTER_TABLE 'Cxc', 'PedidoReferenciaID','int	NULL'
 EXEC spALTER_TABLE 'Cxc', 'POSGUID', 'varchar(50) NULL' 
 EXEC spADD_INDEX 'Cxc', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
 EXEC spADD_INDEX 'Cxc', 'Referencia2', 'Referencia, FechaEmision, Estatus, Empresa'
GO

EXEC spFK2 'Cxc','Cliente','ClienteEnviarA','CteEnviarA','Cliente','ID'
EXEC spFK 'Cxc','Cliente','Cte','Cliente'
EXEC spFK 'Cxc','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Cxc','UEN','UEN','UEN'
EXEC spFK 'Cxc','PersonalCobrador','Personal','Personal'
EXEC spFK 'Cxc','LineaCredito','LC','LineaCredito'
EXEC spFK 'Cxc','TipoTasa','TipoTasa','TipoTasa'
EXEC spFK 'Cxc','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'Cxc','VIN','VIN','VIN'
EXEC spFK 'Cxc','ContUso','CentroCostos','CentroCostos'
GO
EXEC spALTER_TABLE 'Cxc', 'Actividad', 'varchar(50) NULL' 
GO

--Integracion DEVOLUCION POS con Articulos tipo Serie
EXEC spALTER_TABLE 'Cxc', 'FechaOriginalAnt', 'datetime NULL'
EXEC spALTER_TABLE 'Cxc', 'ReferenciaMAVI', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cxc', 'InteresesMoratoriosMAVI', 'money NULL'
GO

EXEC spALTER_TABLE 'Cxc', 'PadreMAVI', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'PadreIDMAVI', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxc', 'IDPadreMAVI', 'int NULL'
EXEC spALTER_TABLE 'Cxc', 'IDCobroBonifMAVI', 'int NULL' 
EXEC spALTER_TABLE 'Cxc', 'Mayor12Meses', 'bit DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'EsCredilana', 'bit DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxc', 'InteresMoratorioAnt', 'money NULL'
EXEC spALTER_TABLE 'Cxc', 'FacDesgloseIVA', 'bit DEFAULT 0 WITH VALUES'
GO

-- Cxc
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Cliente' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Cliente 	    ON dbo.Cxc (Cliente)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Cxc (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'VIN' AND sysobjects.id = sysindexes.id)
  CREATE INDEX VIN	    ON dbo.Cxc (VIN)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Cxc (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Cxc (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Cxc (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Cxc (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Cxc (Usuario, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Cxc (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Dinero2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Dinero2	     ON dbo.Cxc (DineroID, Dinero, DineroCtaDinero, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'RamaID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX RamaID	     ON dbo.Cxc (RamaID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'LineaCredito' AND sysobjects.id = sysindexes.id)
  CREATE INDEX LineaCredito  ON dbo.Cxc (LineaCredito)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Origen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Origen 	     ON dbo.Cxc (OrigenID, Origen, OrigenTipo, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Codigo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Codigo        ON dbo.Cxc (Codigo)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Dinero' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.Dinero
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxc.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Cxc (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Cxc (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Cxc (OrigenID,Origen,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'ClienteTipoCambio' AND sysobjects.id = sysindexes.id)
   CREATE INDEX ClienteTipoCambio ON Cxc(ClienteTipoCambio)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'Moneda' AND sysobjects.id = sysindexes.id)--Bug 21604
   CREATE INDEX Moneda ON Cxc(Moneda)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxc' AND sysindexes.name = 'SubModulo' AND sysobjects.id = sysindexes.id)
   CREATE INDEX SubModulo ON Cxc(SubModulo)

-- Aqui va el Matenimiento a la tabla
GO
CREATE TRIGGER tgCxcA ON Cxc
--//WITH ENCRYPTION
FOR INSERT
AS BEGIN
  IF dbo.fnEstaSincronizando() = 1 RETURN
  INSERT CxcPersonalCobradorLog (ID, Fecha, PersonalCobrador) 
  SELECT ID, GETDATE(), PersonalCobrador FROM Inserted WHERE NULLIF(RTRIM(PersonalCobrador), '') IS NOT NULL
END
GO
CREATE TRIGGER tgCxcC ON Cxc
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
    @MovID		varchar(20),
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
    @Empresa		varchar(5),
    @DineroA		varchar(20),
    @DineroN		varchar(20),
    @DineroIDA		varchar(20),
    @DineroIDN		varchar(20),
    @CtaDinero		varchar(10),/*,
    @Amortizaciones	int,
    @Saldo		money,
    @UltimoCambio	datetime*/
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(DineroConciliado) OR UPDATE(DineroFechaConciliacion) RETURN

  IF UPDATE(PersonalCobrador)
    INSERT CxcPersonalCobradorLog (ID, Fecha, PersonalCobrador) 
    SELECT ID, GETDATE(), PersonalCobrador FROM Inserted WHERE NULLIF(RTRIM(PersonalCobrador), '') IS NOT NULL

  SELECT @Modulo = 'CXC'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), ''), @DineroA = NULLIF(RTRIM(Dinero), ''), @DineroIDA = NULLIF(RTRIM(DineroID), '') FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @DineroN = NULLIF(RTRIM(Dinero), ''), @DineroIDN = NULLIF(RTRIM(DineroID), ''), @CtaDinero = DineroCtaDinero, @Empresa = Empresa, @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @MovID = MovID, @Usuario = Usuario/*, @Saldo = ISNULL(Saldo, 0.0), @Amortizaciones = ISNULL(Amortizaciones, 0), @UltimoCambio = UltimoCambio */FROM Inserted


/*  IF @Amortizaciones > 0
  BEGIN
    EXEC spExtraerFecha @UltimoCambio OUTPUT
    EXEC spTablaAmortizacionAjustar 'CXC', @ID, @UltimoCambio, @Saldo
  END*/

  IF @DineroA <> @DineroN OR @DineroIDA <> @DineroIDN 
    EXEC spDineroPagado @Empresa, @Modulo, @ID, @DineroA, @DineroN, @DineroIDA, @DineroIDN, @CtaDinero, 100


  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    SELECT @Mensaje = RTRIM(@Mensaje) + ' '+RTRIM(@Mov)+' '+RTRIM(@MovID)
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
  IF @EstatusNuevo = 'CANCELADO' AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO') AND EXISTS(SELECT * FROM Version WHERE Sucursal = 0 AND SincroContabilidadMatriz = 1)
    UPDATE Cxc SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgCxcB ON Cxc
--//WITH ENCRYPTION
FOR DELETE
AS BEGIN
  DECLARE
    @ID		int,
    @Estatus 	varchar(15),
    @Mensaje	varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ID = ID, @Estatus = Estatus FROM Deleted
  IF @Estatus IS NOT NULL AND @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR')
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
    RAISERROR (@Mensaje,16,-1) 
  END ELSE 
    EXEC spMovAlEliminar 'CXC', @ID
END
GO

if substring(@@version, 1, 26) <> 'Microsoft SQL Server  7.00' 
  EXEC("CREATE TRIGGER tgCxcRef ON Cxc
  --//WITH ENCRYPTION
  FOR INSERT, UPDATE
  AS BEGIN
    DECLARE 
      @Empresa		varchar(5),
      @Contacto		varchar(10),
      @Mov		varchar(20),
      @MovID		varchar(20),
      @Referencia		varchar(50),
      @FechaEmision	datetime,
      @Vencimiento	datetime,
      @EnviarA		int

    IF dbo.fnEstaSincronizando() = 1 RETURN
  
    IF UPDATE(Empresa) OR UPDATE(Referencia) OR UPDATE(Vencimiento)
    BEGIN
      SELECT @Empresa = NULLIF(RTRIM(Empresa), ''), @Contacto = NULLIF(RTRIM(Cliente), ''), @Mov = NULLIF(RTRIM(Mov), ''), @MovID = NULLIF(RTRIM(MovID), ''), @Referencia = Referencia, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @EnviarA = ClienteEnviarA FROM Inserted
      IF @Empresa IS NOT NULL AND @Contacto IS NOT NULL AND @Mov IS NOT NULL AND @MovID IS NOT NULL
      BEGIN
        UPDATE MovRef SET Referencia = @Referencia, FechaEmision = @FechaEmision, Vencimiento = @Vencimiento, EnviarA = @EnviarA WHERE Empresa = @Empresa AND Modulo = 'CXC' AND Contacto = @Contacto AND Mov = @Mov AND MovID = @MovID
        IF @@ROWCOUNT = 0
          INSERT MovRef (Empresa, Modulo, Contacto, Mov, MovID, Referencia, FechaEmision, Vencimiento, EnviarA) VALUES (@Empresa, 'CXC', @Contacto, @Mov, @MovID, @Referencia, @FechaEmision, @Vencimiento, @EnviarA)
      END
    END    
  END")
GO

/****** Cxc (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'CxcD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxcD','Movimiento','CXC')
if not exists (select * from sysobjects where id = object_id('dbo.CxcD') and type = 'U') 
CREATE TABLE dbo.CxcD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

        Importe                 money           NULL,
	Aplica 			varchar(20)        NULL,
        AplicaID	        varchar(20)     NULL,
	Fecha			datetime	NULL,
	FechaAnterior		datetime	NULL,
	Comision		money			NULL,
	InteresesOrdinarios	 money		NULL,
	InteresesOrdinariosQuita float	NULL,
	InteresesOrdinariosIVA float	NULL, --MEJORA10041
	InteresesOrdinariosTasaDia float NULL, --MEJORA10041
	InteresesOrdinariosTasaRealDia float NULL, --MEJORA10041	
	InteresesOrdinariosIVADescInfl float NULL, --MEJORA10041
	
	InteresesMoratorios	 money		NULL,
	InteresesMoratoriosQuita float	NULL,
	InteresesMoratoriosIVA float	NULL, --MEJORA10041
	InteresesMoratoriosTasaDia float NULL, --MEJORA10041
	InteresesMoratoriosTasaRealDia float NULL, --MEJORA10041	
		
	ImpuestoAdicional	float		NULL,
	OtrosCargos		money			NULL,
	Retencion		money       	NULL,
    Retencion2		float			NULL, --MEJORA4648
    Retencion3		float			NULL, --MEJORA4648
	Ligado			bit		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	LigadoDR		bit		NOT NULL DEFAULT 0,
	EsReferencia		bit		NULL 	 DEFAULT 0,

	Logico1			bit		NOT NULL DEFAULT 0,

	DescuentoRecargos	money		NULL,

	CONSTRAINT priCxcD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)

)
GO

EXEC spAlter_Table 'CxcD','InteresesOrdinariosIVA', 'float	NULL'; --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesOrdinariosTasaDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesOrdinariosTasaRealDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesMoratoriosIVA', 'float	NULL'; --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesMoratoriosTasaDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesMoratoriosTasaRealDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxcD','InteresesOrdinariosIVADescInfl', 'float NULL' --MEJORA10041
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CxcD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
    DROP INDEX CxcD.Aplica
  ALTER TABLE CxcD ALTER COLUMN AplicaID varchar(20)
END
GO
EXEC spModificarPK_Sucursal 'CxcD', '(ID, Renglon, RenglonSub)'
GO
if exists(select * from syscampo where tabla = 'CxcD' AND Campo = 'DescuentoProntoPago') and not exists(select * from syscampo where tabla = 'CxcD' AND Campo = 'DescuentoRecargos') 
BEGIN
  EXEC("sp_rename 'CxcD.DescuentoProntoPago', 'DescuentoRecargos', 'COLUMN'")
  EXEC("ALTER TABLE CxcD ALTER COLUMN DescuentoRecargos money NULL")
END
GO
EXEC spALTER_TABLE 'CxcD', 'DescuentoRecargos', 'money NULL'
GO
if not exists(select * from syscampo where tabla = 'CxcD' AND Campo = 'LigadoDR') 
  EXEC sp_rename 'CxcD.Logico2', 'LigadoDR', 'COLUMN'
GO
if (select version from version) <= 2615
  if exists(select * from syscampo where tabla = 'CxcD' and campo='AplicaDocumento')
    alter table cxcd drop column AplicaDocumento
go
EXEC spALTER_TABLE 'CxcD', 'InteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'CxcD', 'InteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'CxcD', 'InteresesOrdinariosQuita', 'float NULL'
EXEC spALTER_TABLE 'CxcD', 'InteresesMoratoriosQuita', 'float NULL'
EXEC spALTER_TABLE 'CxcD', 'EsReferencia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CxcD', 'ImpuestoAdicional', 'float NULL'
EXEC spALTER_TABLE 'CxcD', 'OtrosCargos', 'money NULL'
EXEC spALTER_TABLE 'CxcD', 'Retencion', 'money NULL'
EXEC spAlter_Table 'CxcD', 'Retencion2', 'float NULL' --MEJORA4648
EXEC spAlter_Table 'CxcD', 'Retencion3', 'float NULL' --MEJORA4648
go

EXEC spFK 'CxcD','ID','Cxc','ID'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CxcD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Aplica ON dbo.CxcD (Aplica, AplicaID)
go

if exists (select * from sysobjects where id = object_id('dbo.cCxcD') and sysstat & 0xf = 2) drop view dbo.cCxcD
GO
CREATE VIEW cCxcD
--//WITH ENCRYPTION
AS
SELECT
  ID,
  Renglon,
  RenglonSub,

  Importe,
  Aplica,
  AplicaID,
  Fecha,
  FechaAnterior,
  Comision,

  DescuentoRecargos,
  InteresesOrdinarios,
  InteresesOrdinariosQuita,
  InteresesMoratorios,
  InteresesMoratoriosQuita,
  ImpuestoAdicional,
  OtrosCargos,
  Retencion,
  Ligado,

  Sucursal,
  SucursalOrigen,
  LigadoDR

FROM
  CxcD
GO

/****** CxcVoucher ******/
if not exists (select * from SysTabla where SysTabla = 'CxcVoucher') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxcVoucher','Movimiento','CXC')
if not exists (select * from sysobjects where id = object_id('dbo.CxcVoucher') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxcVoucher (
	ID 			int             NOT NULL,
	RID			int		NOT NULL	IDENTITY(1, 1),

	Sucursal		int		NOT NULL 	DEFAULT 0,
	Mov 			varchar(20)        NULL,
        Referencia	        varchar(50)     NULL,
        Concepto	        varchar(50)     NULL,
	EnviarA			int		NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Nuevo			bit		NULL		DEFAULT 0,
	Aceptar			bit		NULL		DEFAULT 1,
	IDAplica		int		NULL,

	CONSTRAINT priCxcVoucher PRIMARY KEY CLUSTERED (ID, RID)
  )
  EXEC spSincroSemilla 'CxcVoucher'
END
GO
EXEC spModificarPK_Sucursal 'CxcVoucher', '(ID, RID)'
GO
EXEC spALTER_TABLE 'CxcVoucher', 'IDAplica', 'int NULL'
GO

/****** CxcAplicaDif ******/
if not exists (select * from SysTabla where SysTabla = 'CxcAplicaDif') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxcAplicaDif','Movimiento','CXC')
if not exists (select * from sysobjects where id = object_id('dbo.CxcAplicaDif') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxcAplicaDif (
	ID 			int         	NOT NULL,
	OrdenID 		int         	NOT NULL IDENTITY(1,1),

	Mov			varchar(20)        NULL,        
	Concepto		varchar(50)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,

	Cliente			varchar(10)	NULL,
	ClienteEnviarA		int		NULL,

	Referencia 		varchar(50) 	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCxcAplicaDif PRIMARY KEY CLUSTERED (ID, OrdenID)
  )
  EXEC spSincroSemilla 'CxcAplicaDif'
END
GO
EXEC spModificarPK_Sucursal 'CxcAplicaDif', '(ID, OrdenID)'
GO
EXEC spALTER_TABLE 'CxcAplicaDif', 'Impuestos', 'money NULL'
GO

EXEC spFK2 'CxcAplicaDif','Cliente','ClienteEnviarA','CteEnviarA','Cliente','ID'
GO

/****** Anticipo ******/
if not exists (select * from SysTabla where SysTabla = 'Anticipo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Anticipo', 'Movimiento')
--JGD INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Anticipo', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Anticipo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Anticipo (
	ID			int         	NOT NULL IDENTITY(1,1),

	Sucursal		int		NOT NULL DEFAULT 0,
	Rama			varchar(5)		NULL,
	Modulo			varchar(5)		NULL,
	ModuloID		int		NULL,
	Empresa			varchar(5)		NULL,
	Cuenta			varchar(10)	NULL,
	Mov			varchar(20)	NULL,
	MovID			varchar(20)	NULL,
	Moneda			varchar(10)	NULL,
	TipoCambio		float		NULL,
	Proyecto		varchar(50)	NULL,
	UEN			int		NULL,
	Referencia		varchar(50)	NULL,
	Cargo			money		NULL,
	Abono			money		NULL,
	Fecha			datetime	NULL,
	FechaRegistro		datetime	NULL,
	Cancelado		bit		NOT NULL DEFAULT 0,

	CONSTRAINT priAnticipo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Anticipo'
END
GO
EXEC spALTER_TABLE 'Anticipo', 'UEN', 'int NULL'
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Anticipo' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia ON dbo.Anticipo (Referencia)
GO

/****** DocAuto (Documentacion Automatica) ******/
if not exists (select * from SysTabla where SysTabla = 'DocAuto') 
INSERT INTO SysTabla (SysTabla) VALUES ('DocAuto')
if not exists (select * from sysobjects where id = object_id('dbo.DocAuto') and type = 'U') 
BEGIN
  CREATE TABLE dbo.DocAuto (
	ID			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5)		NOT NULL,
	Cuenta			varchar(10)	NOT NULL,
	Moneda			varchar(10)	NOT NULL,
	Mov			varchar(20)	NOT NULL,
	MovID			varchar(20)	NOT NULL,
	ImporteDocumentar	money		NOT NULL,
	Intereses            	money		NULL,
	InteresesImpuestos     	money		NULL,
	InteresesConcepto	varchar(50)	NULL,
	NumeroDocumentos	int		NOT NULL,
	PrimerVencimiento	datetime	NOT NULL,
	Periodo			varchar(15)	NOT NULL,
	Concepto		varchar(50)	NULL,
	Observaciones		varchar(100)	NULL,
	Estatus			varchar(15)	NOT NULL,
	Usuario 		varchar(10)   	NULL,
	FechaEmision 		datetime    	NULL,	
	ImpPrimerDoc		bit		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,
	Condicion		varchar(50)	NULL,
	Documento		varchar(20)	NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Interes			float		NULL,

	CONSTRAINT priDocAuto PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'DocAuto'
END
GO
if (select version from version) <= 1101
  ALTER TABLE DocAuto ALTER COLUMN MovID varchar(20)
GO
EXEC spModificarPK_SucursalSinOrigen 'DocAuto', '(ID)'
GO
EXEC spALTER_TABLE 'DocAuto', 'Condicion', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'DocAuto', 'Documento', 'varchar(20) NULL'
EXEC spALTER_TABLE 'DocAuto', 'Interes', 'float NULL'
GO

EXEC spFK 'DocAuto','Cuenta','Cte','Cliente'
EXEC spFK 'DocAuto','Cuenta','Prov','Proveedor'
GO

/****** Conversion (Conversion Monedas) ******/
if not exists (select * from SysTabla where SysTabla = 'Conversion') 
INSERT INTO SysTabla (SysTabla) VALUES ('Conversion')
if not exists (select * from sysobjects where id = object_id('dbo.Conversion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Conversion (
	ID			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)		NOT NULL,
	Modulo			varchar(5)		NOT NULL,
	Cuenta			varchar(10)	NOT NULL,
	MovMoneda		varchar(10)	NOT NULL,
	MovTipoCambio		float		NOT NULL,
	Mov			varchar(20)	NOT NULL,
	MovID			varchar(20)	NOT NULL,

	Estatus			varchar(15)	NOT NULL,
	Usuario 		varchar(10)   	NULL,
	FechaEmision 		datetime    	NULL,	

	Moneda			varchar(10)	NOT NULL,
	TipoCambio		float		NOT NULL,
	Movimiento		varchar(20)	NOT NULL,

	CONSTRAINT priConversion PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Conversion'
END
GO
EXEC spALTER_TABLE 'Conversion', 'MovTipoCambio', 'float NULL'
EXEC spALTER_TABLE 'Conversion', 'Movimiento', 'varchar(20) NULL'
GO

EXEC spFK 'Conversion','Cuenta','Cte','Cliente'
EXEC spFK 'Conversion','Cuenta','Prov','Proveedor'
GO

if not exists(select * from MovRef) and (substring(@@version, 1, 26) <> 'Microsoft SQL Server  7.00')
  EXEC("INSERT MovRef (Empresa, Modulo, Contacto, Mov, MovID, Referencia, FechaEmision, Vencimiento, EnviarA)
        SELECT Empresa, 'CXC', Cliente, Mov, MovID, MIN(Referencia), MIN(FechaEmision), MIN(Vencimiento), MIN(ClienteEnviarA)
          FROM CXC
         WHERE NULLIF(RTRIM(Empresa), '') IS NOT NULL AND NULLIF(RTRIM(Cliente), '') IS NOT NULL AND NULLIF(RTRIM(Mov), '') IS NOT NULL AND NULLIF(RTRIM(MovID), '') IS NOT NULL
           AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
         GROUP BY Empresa, Cliente, Mov, MovID
         ORDER BY Empresa, Cliente, Mov, MovID")
ELSE
  TRUNCATE TABLE MovRef
GO



/****** CxReevaluacionLog ******/
if not exists (select * from SysTabla where SysTabla = 'CxReevaluacionLog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CxReevaluacionLog','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.CxReevaluacionLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxReevaluacionLog (
	Modulo			varchar(5)		NOT NULL,
	ID 			int         	NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL,

	TipoCambio		float		NULL,

	CONSTRAINT priCxReevaluacionLog PRIMARY KEY CLUSTERED (Modulo, ID, Renglon, RenglonSub)
  )
END
GO


/****** CxTasaDiariaLog ******/
/*if not exists (select * from SysTabla where SysTabla = 'CxTasaDiariaLog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CxTasaDiariaLog','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.CxTasaDiariaLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxTasaDiariaLog (
	Modulo			varchar(5)		NOT NULL,
	ID 			int         	NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL,

	TasaDiaria		float		NULL,

	CONSTRAINT priCxTasaDiariaLog PRIMARY KEY CLUSTERED (Modulo, ID, Renglon, RenglonSub)
  )
END*/
GO

/****** CxUltimoDevengadoLog ******/
/*if not exists (select * from SysTabla where SysTabla = 'CxUltimoDevengadoLog') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CxUltimoDevengadoLog','MovimientoInfo')
if not exists (select * from sysobjects where id = object_id('dbo.CxUltimoDevengadoLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxUltimoDevengadoLog (
	Modulo			varchar(5)		NOT NULL,
	ID 			int         	NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL,

	UltimoDevengado		datetime	NULL,

	CONSTRAINT priCxUltimoDevengadoLog PRIMARY KEY CLUSTERED (Modulo, ID, Renglon, RenglonSub)
  )
END*/
GO

/****** Neteo ******/
if not exists (select * from SysTabla where SysTabla = 'Neteo') 
INSERT INTO SysTabla (SysTabla) VALUES ('Neteo')
if not exists (select * from sysobjects where id = object_id('dbo.Neteo') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Neteo (
	ID			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)		NOT NULL,
	Usuario			varchar(10)	NOT NULL,
	Moneda			varchar(10)	NOT NULL,
	Cliente			varchar(10)	NOT NULL,
	CxcMov			varchar(20)	NOT NULL,
	CxcMovID		varchar(20)	NOT NULL,

	Proveedor		varchar(10)	NOT NULL,
	CxpMov			varchar(20)	NOT NULL,
	CxpMovID		varchar(20)	NOT NULL,

	CONSTRAINT priNeteo PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Neteo'
END
GO

EXEC spFK 'Neteo','Cliente','Cte','Cliente'
EXEC spFK 'Neteo','Proveedor','Prov','Proveedor'
GO

/****** CxcFacturaAnticipo ******/
if not exists(select * from SysTabla where SysTabla = 'CxcFacturaAnticipo')
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxcFacturaAnticipo','Movimiento','CXC')
if not exists (select * from sysobjects where id = object_id('dbo.CxcFacturaAnticipo') and type = 'U') 
CREATE TABLE dbo.CxcFacturaAnticipo (
	ID 			int         	NOT NULL,
	CxcID			int		NOT NULL,

	Importe			money		NULL,	

	CONSTRAINT priCxcFacturaAnticipo PRIMARY KEY CLUSTERED (ID, CxcID)
)
GO
EXEC spModificarPK_Sucursal 'CxcFacturaAnticipo', '(ID, CxcID)'
GO

