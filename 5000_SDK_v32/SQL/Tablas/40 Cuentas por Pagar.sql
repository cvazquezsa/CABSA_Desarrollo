
/*******************************************************************************************/
/*                                      CUENTAS POR PAGAR                                  */
/*******************************************************************************************/

/****** Cuentas por Pagar ******/
if not exists (select * from SysTabla where SysTabla = 'CxpC') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CxpC', 'Movimiento')
if not exists (select * from sysobjects where id = object_id('dbo.CxpC') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxpC (
        ID			int		NOT NULL IDENTITY (1,1),

	Empresa			varchar(5)         NULL,
	Mov 		        varchar(20) 	NULL,
	Serie			varchar(20)	NULL,
	Periodo			int		NULL,
	Ejercicio		int		NULL,

	Consecutivo 		int		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCxpC PRIMARY KEY  CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'CxpC'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'CxpC', '(ID)'
GO
if (select version from version)<=2700 
BEGIN
  EXEC("ALTER TABLE CxpC ALTER COLUMN Empresa varchar(5)  NULL")
  EXEC("ALTER TABLE CxpC ALTER COLUMN Mov     varchar(20) NULL")
END
GO

/****** Cxp (Ficha) ******/
if not exists (select * from SysTabla where SysTabla = 'Cxp') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('Cxp','Movimiento','CXP')
if not exists (select * from sysobjects where id = object_id('dbo.Cxp') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Cxp (
	ID 			int         	NOT NULL IDENTITY(1,1),

	Empresa			varchar(5)	        NOT NULL,
	Mov  			varchar(20)        NOT NULL,        -- tipo de movimiento Factura, Cobro, Bonificacion, etc.
	MovID			varchar(20)    	NULL,	     -- consecutivo a asignar en la afectacion
	FechaEmision 		datetime    	NULL,	     -- fecha original en la que se realiza el movimiento
	UltimoCambio 		datetime    	NULL,
	Concepto		varchar(50)	NULL,
	Proyecto  		varchar(50)   	NULL,
	UEN			int		NULL,
	Moneda 			varchar(10)   	NOT NULL,
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

	Proveedor  		varchar(10)   	NOT NULL,
	ProveedorSucursal	int		NULL,
        ProveedorMoneda		char(10)	NULL,
	ProveedorTipoCambio	float		NULL,
	CtaDinero		varchar(10)        NULL,       
	Condicion 		varchar(50)   	NULL,
	Vencimiento		datetime    	NULL,
	FormaPago		varchar(50)	NULL,
	Importe   		money       	NULL,	    -- Importe sin Iva y sin Descuentos
	Impuestos	        money       	NULL,
	Retencion		money       	NULL,
	Retencion2		money       	NULL,
	Retencion3		money       	NULL,
	AplicaManual		bit		NOT NULL DEFAULT 0,
        Beneficiario		int		NULL,

	MovAplica		varchar(20)	NULL,
	MovAplicaID		varchar(20)	NULL,

	Saldo 		        money       	NULL,
	AutoAjuste		money		NULL,
    NoAutoAjustar   bit NULL	DEFAULT 0,
    NoAutoAplicar   bit NULL	DEFAULT 0,   --BUG10848

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
	Conciliado		bit		NOT NULL DEFAULT 0,

	GenerarDinero		bit		NOT NULL DEFAULT 0,
	Dinero			varchar(20)	NULL,
	DineroID		varchar(20)	NULL,
	DineroCtaDinero		varchar(10)	NULL,
	DineroConciliado	bit		NULL     DEFAULT 0,
	DineroFechaConciliacion datetime	NULL,

	Sucursal		int		NOT NULL DEFAULT 0,
	Mensaje			int		NULL,

	Logico1			bit		NOT NULL DEFAULT 0,
	Logico2			bit		NOT NULL DEFAULT 0,
	Logico3			bit		NOT NULL DEFAULT 0,
	Logico4			bit		NOT NULL DEFAULT 0,
	Logico5			bit		NOT NULL DEFAULT 0,
	Logico6			bit		NOT NULL DEFAULT 0,
	EstaImpreso		bit		NULL	 DEFAULT 0,

	Cajero			varchar(10)	NULL,
	Aforo			money		NULL,
	IVAFiscal		float		NULL,
	IEPSFiscal		float		NULL,
	DiferenciaCambiaria	money		NULL,
	ProveedorAutoEndoso	varchar(10)	NULL,
	FechaProgramada		datetime	NULL,
	Comentarios		text		NULL,
	Nota			varchar(100)	NULL,

	Tasa			varchar(50)	NULL,
	TasaDiaria		float		NULL,
	TasaRealDiaria	float		NULL, --MEJORA10041	
	RamaID			int		NULL,

	LineaCredito		varchar(20)	NULL,
	TipoAmortizacion	varchar(20)	NULL,
 	TipoTasa		varchar(20)	NULL,
	Amortizaciones		int		NULL,
	InteresesAnticipados	money 		NULL,
	InteresesFijos		money 		NULL,
	InteresesOrdinarios	money		NULL,
	InteresesMoratorios	money		NULL,
	InteresesOrdinariosIVA		float		NULL, --MEJORA10041
	InteresesMoratoriosIVA		float		NULL, --MEJORA10041	
	IVAInteresPorcentaje		float		NULL, --MEJORA10041
	--FechaIntereses		datetime	NULL,

	Comisiones		money		NULL,
	ComisionesIVA		money		NULL,
	VIN			varchar(20)	NULL,
	RetencionAlPago		bit		NULL	DEFAULT 0,
	OperacionRelevante	bit 		NULL 	DEFAULT 0,
	ContUso				varchar(20) 	NULL,
	ContUso2			varchar(20) 	NULL, --MEJORA4752	
	ContUso3			varchar(20) 	NULL, --MEJORA4752		
	TieneTasaEsp		bit		NULL	DEFAULT 0,
	TasaEsp			float		NULL,

	InteresesRetencion			money	NULL,
	InteresesFijosRetencion		money	NULL,
	SaldoInteresesOrdinarios	money	NULL,
	SaldoInteresesMoratorios	money	NULL,	
	SaldoInteresesOrdinariosIVA		float		NULL, --MEJORA10041
	SaldoInteresesMoratoriosIVA		float		NULL, --MEJORA10041
	
	ContratoID						int		NULL,
	ContratoMov						varchar(20)	NULL,
	ContratoMovID					varchar(20)	NULL,
	ConsignacionFechaCorte			datetime	NULL, --MEJORASLC

	EsInteresFijo				bit NULL DEFAULT 0, --MEJORA10041
 	CFDFlexEstatus          varchar(15)     NULL, --REQ 15739 	
	    
	CONSTRAINT priCxp PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Cxp'
END
go
EXEC spSincroNivelRegistro @Tabla = 'Cxp'
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
    DROP INDEX Cxp.Consecutivo
  ALTER TABLE Cxp ALTER COLUMN MovID varchar(20)
  ALTER TABLE Cxp ALTER COLUMN MovAplicaID varchar(20)
  ALTER TABLE Cxp ALTER COLUMN OrigenID varchar(20)
  ALTER TABLE Cxp ALTER COLUMN PolizaID varchar(20)
  ALTER TABLE Cxp ALTER COLUMN DineroID varchar(20)
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCxpA') and sysstat & 0xf = 8) drop trigger dbo.tgCxpA
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCxpC') and sysstat & 0xf = 8) drop trigger dbo.tgCxpC
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCxpB') and sysstat & 0xf = 8) drop trigger dbo.tgCxpB
GO
EXEC spModificarPK_Mov 'Cxp'
GO
EXEC spSincroNivelRegistroCampos 'Cxp'
GO
EXEC spALTER_TABLE 'Cxp', 'Cajero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxp', 'Aforo', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'IVAFiscal', 'float NULL'
EXEC spALTER_TABLE 'Cxp', 'IEPSFiscal', 'float NULL'
EXEC spALTER_TABLE 'Cxp', 'DiferenciaCambiaria', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Cxp', 'EstaImpreso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxp', 'Retencion', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'DineroConciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxp', 'DineroFechaConciliacion', 'datetime	NULL'
EXEC spALTER_TABLE 'Cxp', 'Retencion2', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'Retencion3', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'ProveedorAutoEndoso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxp', 'FechaProgramada', 'datetime NULL'
EXEC spALTER_TABLE 'Cxp', 'Comentarios', 'text NULL'
EXEC spALTER_TABLE 'Cxp', 'Nota', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'Cxp', 'Tasa', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Cxp', 'TasaDiaria', 'float NULL'
EXEC spALTER_TABLE 'Cxp', 'RamaID', 'int NULL'
EXEC spALTER_TABLE 'Cxp', 'LineaCredito', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'TipoAmortizacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'TipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'Amortizaciones', 'int NULL'
EXEC spALTER_TABLE 'Cxp', 'InteresesAnticipados', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'InteresesFijos', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'InteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'InteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'Comisiones', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'ComisionesIVA', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'VIN', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'RetencionAlPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxp', 'OperacionRelevante','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxp', 'ContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'TieneTasaEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Cxp', 'TasaEsp', 'float NULL'
EXEC spALTER_TABLE 'Cxp', 'SituacionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Cxp', 'SituacionNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Cxp', 'ProveedorSucursal', 'int NULL'
EXEC spDROP_COLUMN 'Cxp', 'FechaIntereses'
GO
EXEC spALTER_TABLE 'Cxp', 'InteresesRetencion',		 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'InteresesFijosRetencion', 'money NULL'
EXEC spDROP_COLUMN 'Cxp', 'AcumInteresesOrdinarios'
EXEC spDROP_COLUMN 'Cxp', 'AcumInteresesMoratorios'
EXEC spALTER_TABLE 'Cxp', 'SaldoInteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'SaldoInteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'Cxp', 'ContratoID', 'int NULL'
EXEC spALTER_TABLE 'Cxp', 'ContratoMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Cxp', 'ContratoMovID', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'Cxp', 'ContUso2', 'varchar(20) NULL' --MEJORA4752
EXEC spALTER_TABLE 'Cxp', 'ContUso3', 'varchar(20) NULL' --MEJORA4752
GO
EXEC spALTER_TABLE 'Cxp', 'ConsignacionFechaCorte', 'datetime NULL' --MEJORASLC
GO
-- 6024
EXEC spALTER_TABLE 'Cxp', 'NoAutoAjustar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
--BUG10848
EXEC spALTER_TABLE 'Cxp', 'NoAutoAplicar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'Cxc', 'TasaRealDiaria', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'InteresesOrdinariosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'InteresesMoratoriosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'SaldoInteresesOrdinariosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'SaldoInteresesMoratoriosIVA', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'IVAInteresPorcentaje', 'float NULL' --MEJORA10041
EXEC spALTER_TABLE 'Cxp', 'EsInteresFijo', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA10041
GO

-- REQ12336
EXEC spALTER_TABLE 'Cxp', 'EmidaCarrierID', 'varchar(255) NULL'
GO
-- REQ12336
EXEC spALTER_TABLE 'Cxp', 'EmidaRequestId', 'varchar(20) NULL'
GO
 --REQ 15739 
 Exec spAlter_Table 'Cxp','CFDFlexEstatus','varchar(15) Null'
 EXEC spADD_INDEX 'Cxp', 'CFDFlexEstatus', 'Estatus, CFDFlexEstatus'
 EXEC spADD_INDEX 'Cxp', 'Referencia2', 'Referencia, FechaEmision, Estatus, Empresa'
GO

EXEC spFK 'Cxp','Proveedor','Prov','Proveedor'
EXEC spFK 'Cxp','CtaDinero','CtaDinero','CtaDinero'
EXEC spFK 'Cxp','Mensaje','MensajeLista','Mensaje'
EXEC spFK 'Cxp','UEN','UEN','UEN'
EXEC spFK 'Cxp','LineaCredito','LC','LineaCredito'
EXEC spFK 'Cxp','TipoAmortizacion','TipoAmortizacion','TipoAmortizacion'
EXEC spFK 'Cxp','TipoTasa','TipoTasa','TipoTasa'
EXEC spFK 'Cxp','VIN','VIN','VIN'
EXEC spFK 'Cxp','ContUso','CentroCostos','CentroCostos'
GO
EXEC spALTER_TABLE 'Cxp', 'Actividad', 'varchar(50) NULL' 
GO

-- Cxp
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Proveedor' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Proveedor    ON dbo.Cxp (Proveedor)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Referencia' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Referencia   ON dbo.Cxp (Referencia)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'ProveedorAutoEndoso' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ProveedorAutoEndoso ON dbo.Cxp (ProveedorAutoEndoso)

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Consecutivo2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Consecutivo2  ON dbo.Cxp (MovID, Mov, Estatus, Sucursal, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'FechaEmision2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX FechaEmision2 ON dbo.Cxp (FechaEmision, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Abrir2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Abrir2        ON dbo.Cxp (Mov, Estatus, Moneda, Sucursal, Empresa, GenerarPoliza, FechaEmision, FechaCancelacion)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Situacion3' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Situacion3    ON dbo.Cxp (Estatus, Situacion, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Usuario' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Usuario       ON dbo.Cxp (Usuario, Estatus, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'ContID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX ContID	     ON dbo.Cxp (ContID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Dinero2' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Dinero2       ON dbo.Cxp (DineroID, Dinero, DineroCtaDinero, Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'RamaID' AND sysobjects.id = sysindexes.id)
  CREATE INDEX RamaID	     ON dbo.Cxp (RamaID)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'VIN' AND sysobjects.id = sysindexes.id)
  CREATE INDEX VIN	     ON dbo.Cxp (VIN)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'LineaCredito' AND sysobjects.id = sysindexes.id)
  CREATE INDEX LineaCredito  ON dbo.Cxp (LineaCredito)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Origen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Origen 	     ON dbo.Cxp (OrigenID, Origen, OrigenTipo, Empresa)
GO

-- Eliminar Indices Anteriores
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Consecutivo' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.Consecutivo
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'FechaEmision' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.FechaEmision
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Situacion' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.Situacion
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Situacion2' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.Situacion2
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Dinero' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.Dinero
if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'Abrir' AND sysobjects.id = sysindexes.id)
  DROP INDEX Cxp.Abrir
GO
--Indices Optimización Task 18641
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'MovIDMov' AND sysobjects.id = sysindexes.id)
  CREATE INDEX MovIDMov ON Cxp (MovID,Mov,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'OrigenIDOrigen' AND sysobjects.id = sysindexes.id)
  CREATE INDEX OrigenIDOrigen ON Cxp (OrigenID,Origen,Mov)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'OrigenEmpresa' AND sysobjects.id = sysindexes.id)
   CREATE INDEX OrigenEmpresa ON Cxp (OrigenID,Origen,Empresa)
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'Cxp' AND sysindexes.name = 'ProveedorTipoCambio' AND sysobjects.id = sysindexes.id)
   CREATE INDEX ProveedorTipoCambio ON Cxp(ProveedorTipoCambio)
go
-- Aqui va el Matenimiento a la tabla
if not exists(select * from syscampo where tabla = 'Cxp' and Campo = 'Mensaje')
  ALTER TABLE Cxp ADD Mensaje int NULL
GO
CREATE TRIGGER tgCxpC ON Cxp
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Modulo 		varchar(5),
    @Mov		varchar(20),
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
    @CtaDinero		varchar(10),
    -- 7052
    @SPID				int,
    @AfectacionUsuario	varchar(10)

  SELECT @SPID = @@SPID
  
  SELECT @AfectacionUsuario = Usuario FROM AfectacionUsuario WHERE SPID = @SPID

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(DineroConciliado) OR UPDATE(DineroFechaConciliacion) RETURN

  SELECT @Modulo = 'CXP'
  SELECT @EstatusAnterior = NULLIF(RTRIM(Estatus), ''), @SituacionAnterior = NULLIF(RTRIM(Situacion), ''), @DineroA = NULLIF(RTRIM(Dinero), ''), @DineroIDA = NULLIF(RTRIM(DineroID), '')  FROM Deleted
  SELECT @EstatusNuevo    = NULLIF(RTRIM(Estatus), ''), @SituacionNueva    = NULLIF(RTRIM(Situacion), ''), @DineroN = NULLIF(RTRIM(Dinero), ''), @DineroIDN = NULLIF(RTRIM(DineroID), ''), @CtaDinero = DineroCtaDinero, @Empresa = Empresa, @Sucursal = Sucursal, @ID = ID, @Mov = NULLIF(RTRIM(Mov), ''), @Usuario = Usuario FROM Inserted

  IF @DineroA <> @DineroN OR @DineroIDA <> @DineroIDN 
    EXEC spDineroPagado @Empresa, @Modulo, @ID, @DineroA, @DineroN, @DineroIDA, @DineroIDN, @CtaDinero, 100

  IF @EstatusNuevo <> @EstatusAnterior AND 
     ((@EstatusNuevo = 'SINAFECTAR' AND @EstatusAnterior IN ('CONFIRMAR', 'PENDIENTE', 'CONCLUIDO', 'CANCELADO') AND @EstatusAnterior NOT IN (NULL, 'AFECTANDO')) OR
      (@EstatusNuevo = 'CONFIRMAR'  AND @EstatusAnterior IN ('PENDIENTE', 'CONCLUIDO', 'CANCELADO')) OR
      (@EstatusNuevo IN ('PENDIENTE', 'CONCLUIDO') AND @EstatusAnterior = 'CANCELADO'))
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60090
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
    UPDATE Cxp SET GenerarPoliza = 1 WHERE ID = @ID AND GenerarPoliza = 0 AND ContID IS NOT NULL 
END
GO
CREATE TRIGGER tgCxpB ON Cxp
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
    EXEC spMovAlEliminar 'CXP', @ID
END
GO

/****** Cxp (Detalle) ******/
if not exists (select * from SysTabla where SysTabla = 'CxpD') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxpD','Movimiento','CXP')
if not exists (select * from sysobjects where id = object_id('dbo.CxpD') and type = 'U') 
CREATE TABLE dbo.CxpD (
	ID 			int             NOT NULL,
 	Renglon			float	        NOT NULL,
	RenglonSub		int		NOT NULL DEFAULT 0,

        Importe                 money           NULL,
	Aplica   	        varchar(20)        NULL,
        AplicaID	        varchar(20)     NULL,
	Fecha			datetime	NULL,
	FechaAnterior		datetime	NULL,

	Ligado			bit		NOT NULL DEFAULT 0,
	Sucursal		int		NOT NULL DEFAULT 0,

	LigadoDR		bit		NOT NULL DEFAULT 0,
	Logico1			bit		NOT NULL DEFAULT 0,

	DescuentoRecargos	money		NULL,
	InteresesOrdinarios	 money		NULL,
	InteresesOrdinariosQuita float		NULL,
	InteresesOrdinariosIVA float	NULL, --MEJORA10041
	InteresesOrdinariosTasaDia float NULL, --MEJORA10041
	InteresesOrdinariosTasaRealDia float NULL, --MEJORA10041	
	InteresesOrdinariosIVADescInfl float NULL, --MEJORA10041
		
	InteresesMoratorios	 money		NULL,
	InteresesMoratoriosQuita float		NULL,

	InteresesMoratoriosIVA float	NULL, --MEJORA10041
	InteresesMoratoriosTasaDia float NULL, --MEJORA10041
	InteresesMoratoriosTasaRealDia float NULL, --MEJORA10041	
	
	Retencion		money       	NULL,

	CONSTRAINT priCxpD PRIMARY KEY CLUSTERED (ID, Renglon, RenglonSub)

)
GO

EXEC spAlter_Table 'CxpD','InteresesOrdinariosIVA', 'float	NULL'; --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesOrdinariosTasaDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesOrdinariosTasaRealDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesMoratoriosIVA', 'float	NULL'; --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesMoratoriosTasaDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesMoratoriosTasaRealDia', 'float NULL' --MEJORA10041
EXEC spAlter_Table 'CxpD','InteresesOrdinariosIVADescInfl', 'float NULL' --MEJORA10041
GO

if (select version from version) <= 1095
BEGIN
  if exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CxpD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
    DROP INDEX CxpD.Aplica
  ALTER TABLE CxpD ALTER COLUMN AplicaID varchar(20)
END
GO
EXEC spModificarPK_Sucursal 'CxpD', '(ID, Renglon, RenglonSub)'
GO
if exists(select * from syscampo where tabla = 'CxpD' AND Campo = 'DescuentoProntoPago') and not exists(select * from syscampo where tabla = 'CxpD' AND Campo = 'DescuentoRecargos') 
BEGIN
  EXEC("sp_rename 'CxpD.DescuentoProntoPago', 'DescuentoRecargos', 'COLUMN'")
  EXEC("ALTER TABLE CxpD ALTER COLUMN DescuentoRecargos money NULL")
END
GO
EXEC spALTER_TABLE 'CxpD', 'DescuentoRecargos', 'money NULL'
GO
if not exists(select * from syscampo where tabla = 'CxpD' AND Campo = 'LigadoDR') 
  EXEC sp_rename 'CxpD.Logico2', 'LigadoDR', 'COLUMN'
GO

if (select version from version) <= 2615
  if exists(select * from syscampo where tabla = 'CxpD' and campo='AplicaDocumento')
    alter table cxpd drop column AplicaDocumento
go

EXEC spALTER_TABLE 'CxpD', 'InteresesOrdinarios', 'money NULL'
EXEC spALTER_TABLE 'CxpD', 'InteresesMoratorios', 'money NULL'
EXEC spALTER_TABLE 'CxpD', 'InteresesOrdinariosQuita', 'float NULL'
EXEC spALTER_TABLE 'CxpD', 'InteresesMoratoriosQuita', 'float NULL'
EXEC spALTER_TABLE 'CxpD', 'Retencion', 'money NULL'
go

EXEC spFK 'CxpD','ID','Cxp','ID'
GO

if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CxpD' AND sysindexes.name = 'Aplica' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Aplica ON dbo.CxpD (Aplica, AplicaID)
go

if exists (select * from sysobjects where id = object_id('dbo.cCxpD') and sysstat & 0xf = 2) drop view dbo.cCxpD
GO
CREATE VIEW cCxpD
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

  DescuentoRecargos,
  InteresesOrdinarios,
  InteresesOrdinariosQuita,
  InteresesMoratorios,
  InteresesMoratoriosQuita,
  Retencion,
  Ligado,
  Sucursal,
  SucursalOrigen,
  LigadoDR,
  Logico1

FROM 
  CxpD
GO


/****** CxpAplicaDif ******/
if not exists (select * from SysTabla where SysTabla = 'CxpAplicaDif') 
INSERT INTO SysTabla (SysTabla,Tipo,Modulo) VALUES ('CxpAplicaDif','Movimiento','CXP')
if not exists (select * from sysobjects where id = object_id('dbo.CxpAplicaDif') and type = 'U') 
BEGIN
  CREATE TABLE dbo.CxpAplicaDif (
	ID 			int         	NOT NULL,
	OrdenID 		int         	NOT NULL IDENTITY(1,1),

	Mov			varchar(20)        NULL,        
	Concepto		varchar(50)	NULL,
	Importe			money		NULL,
	Impuestos		money		NULL,

	Referencia 		varchar(50) 	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priCxpAplicaDif PRIMARY KEY CLUSTERED (ID, OrdenID)
  )
  EXEC spSincroSemilla 'CxpAplicaDif'
END
GO
EXEC spModificarPK_Sucursal 'CxpAplicaDif', '(ID, OrdenID)'
GO
EXEC spALTER_TABLE 'CxpAplicaDif', 'Impuestos', 'money NULL'
GO

-- drop table CxpPagarEnLote
/****** CxpPagarEnLote ******/
if not exists (select * from SysTabla where SysTabla = 'CxpPagarEnLote') 
INSERT INTO SysTabla (SysTabla) VALUES ('CxpPagarEnLote')
if not exists (select * from sysobjects where id = object_id('dbo.CxpPagarEnLote') and type = 'U') 
  CREATE TABLE dbo.CxpPagarEnLote (
	Estacion		int		NOT NULL,
	ID 			int         	NOT NULL,

	Calificacion		float		NULL,
	ImporteAPagar		money		NULL,	

	CONSTRAINT priCxpPagarEnLote PRIMARY KEY CLUSTERED (Estacion, ID)
  )
GO

EXEC spFK 'CxpPagarEnLote','ID','Cxp','ID'
GO

-- spCxpPagarEnLoteSugerir 'DEMO', 101, '1/1/9', 100000, 'Pesos'
-- select * from CxpPagarEnLote
/************** spCxpPagarEnLoteSugerir *************/
if exists (select * from sysobjects where id = object_id('dbo.spCxpPagarEnLoteSugerir') and type = 'P') drop procedure dbo.spCxpPagarEnLoteSugerir
GO
CREATE PROCEDURE spCxpPagarEnLoteSugerir
			@Empresa	varchar(5),
			@Estacion	int,
			@Vencimiento	datetime,
			@Importe	money,
			@Moneda		varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Evaluacion	varchar(50),
    @Saldo	money,
    @APagar	money

  SELECT @Evaluacion = CxpPagarEnLoteEvaluacion
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  DELETE CxpPagarEnLote WHERE Estacion = @Estacion
  INSERT CxpPagarEnLote (Estacion, ID, Calificacion)
  SELECT @Estacion, p.ID, dbo.fnUltEvaluacion(@Evaluacion, p.Proveedor)
    FROM Cxp p
    JOIN MovTipo mt ON mt.Modulo = 'CXP' AND mt.Mov = p.Mov AND mt.Clave IN ('CXP.F', 'CXP.CA', 'CXP.CAP', 'CXP.CAD', 'CXP.D', 'CXP.DM')
   WHERE p.Empresa = @Empresa AND p.Vencimiento <= @Vencimiento AND p.Moneda = @Moneda AND p.Estatus = 'PENDIENTE' AND ROUND(p.Saldo, 2) > 0.0

  DECLARE crCxpPagarEnLote CURSOR LOCAL FOR
  SELECT ISNULL(p.Saldo, 0.0)
    FROM CxpPagarEnLote l
    JOIN Cxp p ON p.ID = l.ID
   WHERE l.Estacion = @Estacion
   ORDER BY l.Calificacion DESC, p.Proveedor, p.Vencimiento, p.ID
  OPEN crCxpPagarEnLote
  FETCH NEXT FROM crCxpPagarEnLote INTO @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @Importe > 0.0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @APagar = 0.0
      IF @Saldo > @Importe SELECT @APagar = @Importe ELSE SELECT @APagar = @Saldo
      IF @APagar > 0.0
      BEGIN
        SELECT @Importe = @Importe - @APagar
        UPDATE CxpPagarEnLote SET ImporteAPagar = @APagar WHERE CURRENT OF crCxpPagarEnLote
      END
    END
    FETCH NEXT FROM crCxpPagarEnLote INTO @Saldo
  END
  CLOSE crCxpPagarEnLote
  DEALLOCATE crCxpPagarEnLote


  RETURN 
END
GO

/************** spCxpPagarEnLoteProcesar *************/
if exists (select * from sysobjects where id = object_id('dbo.spCxpPagarEnLoteProcesar') and type = 'P') drop procedure dbo.spCxpPagarEnLoteProcesar
GO
CREATE PROCEDURE spCxpPagarEnLoteProcesar
			@Empresa	varchar(5),
			@Estacion	int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @APagar		money,
    @Conteo		int,
    @Ok			int,
    @OkRef		varchar(255),
    @PagoID		int,
    @PagoMov		varchar(20)

  SELECT @PagoMov = CxpPago FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @Ok = NULL, @OkRef = NULL, @Conteo = 0
  DECLARE crCxpPagarEnLote CURSOR LOCAL FOR
  SELECT p.ID, ImporteAPagar
    FROM CxpPagarEnLote l
    JOIN Cxp p ON p.ID = l.ID
   WHERE l.Estacion = @Estacion AND ISNULL(ImporteAPagar, 0.0) > 0.0
   ORDER BY l.Calificacion, p.Proveedor, p.Vencimiento, p.ID
  OPEN crCxpPagarEnLote
  FETCH NEXT FROM crCxpPagarEnLote INTO @ID, @APagar
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      BEGIN TRANSACTION
      EXEC @PagoID = spAfectar 'CXP', @ID, 'GENERAR', 'TODO', @PagoMov, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @PagoID IS NOT NULL
      BEGIN
        UPDATE Cxp  SET Importe = @APagar, Impuestos = NULL WHERE ID = @PagoID
        UPDATE CxpD SET Importe = @APagar WHERE ID = @PagoID
      END
      EXEC spAfectar 'CXP', @PagoID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL 
      BEGIN
        SELECT @Conteo = @Conteo + 1
        DELETE CxpPagarEnLote WHERE CURRENT OF crCxpPagarEnLote
        COMMIT TRANSACTION
      END ELSE
        ROLLBACK TRANSACTION
    END
    FETCH NEXT FROM crCxpPagarEnLote INTO @ID, @APagar
  END
  CLOSE crCxpPagarEnLote
  DEALLOCATE crCxpPagarEnLote

  IF @Ok IN (NULL, 80300)
    SELECT 'Se Procesaron '+LTRIM(CONVERT(char, @Conteo))+ ' Movimientos'
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  

  RETURN 
END
GO
