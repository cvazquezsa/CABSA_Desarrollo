/*  CONFIGURACION */
SET ANSI_DEFAULTS OFF
 GO

/****** CfgMovFlujo ******/
if not exists (select * from SysTabla where SysTabla = 'CfgMovFlujo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgMovFlujo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgMovFlujo') and type = 'U') 
CREATE TABLE dbo.CfgMovFlujo (
	Modulo		varchar(5)	NOT NULL,
	OMov		varchar(20)	NOT NULL,
	DMov		varchar(50)	NOT NULL,
	Orden		int		NULL,
	Nombre		varchar(100)	NULL,

	--Nivel		varchar(20)	NULL	DEFAULT 'Hijo',		-- Hermano, Padre

	CONSTRAINT priCfgMovFlujo PRIMARY KEY  CLUSTERED (Modulo, OMov, DMov)
)
GO
if (select version from version) <= 2630
BEGIN
  EXEC("spEliminarPK 'CfgMovFlujo'")
  EXEC("ALTER TABLE CfgMovFlujo ALTER COLUMN DMov varchar(50) NOT NULL")
  EXEC("ALTER TABLE CfgMovFlujo ADD CONSTRAINT priCfgMovFlujo PRIMARY KEY  CLUSTERED (Modulo, OMov, DMov)")
END
GO
EXEC spALTER_TABLE 'CfgMovFlujo', 'Nombre', 'varchar(100) NULL'
EXEC spDROP_COLUMN 'CfgMovFlujo', 'Nivel'
GO

/****** EmpresaGrupo ******/
if not exists (select * from SysTabla where SysTabla = 'EmpresaGrupo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaGrupo') and type = 'U') 
CREATE TABLE dbo.EmpresaGrupo (
	Grupo	varchar(100) 	NOT NULL,
	Clave	varchar(5)		NULL,    -- Se utiliza cuando en movTipo.ConsecutivoPorEmpresa = 'Grupo'

	CONSTRAINT priEmpresaGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/****** EmpresaZona ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaZona')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaZona','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaZona') and type = 'U') 
CREATE TABLE dbo.EmpresaZona (
	Zona	varchar(50) 	NOT NULL,

	CONSTRAINT priEmpresaZona PRIMARY KEY  CLUSTERED (Zona)
)
GO

/****** SituacionArea ******/
if not exists(select * from SysTabla where SysTabla = 'SituacionArea')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SituacionArea','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SituacionArea') and type = 'U') 
CREATE TABLE dbo.SituacionArea (
	Area	varchar(50) 	NOT NULL,

	CONSTRAINT priSituacionArea PRIMARY KEY  CLUSTERED (Area)
)
GO

/****** Fechas ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaFecha')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaFecha','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaFecha') and type = 'U') 
CREATE TABLE dbo.EmpresaFecha (
	Empresa 		varchar(5) 	NOT NULL,
	FechaD			datetime 	NOT NULL,
	FechaA			datetime 	NULL,

	CONSTRAINT priEmpresaFecha PRIMARY KEY CLUSTERED (Empresa, FechaD)
)
GO

/****** EmpresaCostoPiso ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCostoPiso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCostoPiso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCostoPiso') and type = 'U') 
CREATE TABLE dbo.EmpresaCostoPiso (
	Empresa 		varchar(5) 	NOT NULL,
	Fecha			datetime 	NOT NULL,

	Plazo1Tasa		float		NULL,
	Plazo2Tasa		float		NULL,
	Plazo3Tasa		float		NULL,

	Plazo1TasaDolar		float		NULL,
	Plazo2TasaDolar		float		NULL,
	Plazo3TasaDolar		float		NULL,
        
	Plazo1TasaEuro		float		NULL,
	Plazo2TasaEuro		float		NULL,
	Plazo3TasaEuro		float		NULL,

	CONSTRAINT priEmpresaCostoPiso PRIMARY KEY CLUSTERED (Empresa, Fecha)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaCostoPisoAC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaCostoPisoAC
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo1TasaDolar', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo2TasaDolar', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo3TasaDolar', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo1TasaEuro',  'float NULL'
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo2TasaEuro',  'float NULL'
EXEC spALTER_TABLE 'EmpresaCostoPiso', 'Plazo3TasaEuro',  'float NULL'
GO

CREATE TRIGGER tgEmpresaCostoPisoAC ON EmpresaCostoPiso
--//WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  DECLARE
    @Empresa		varchar(5),
    @Fecha		datetime,
    @FechaA		datetime, 
    @FechaN		datetime, 
    @Plazo1Tasa		float,
    @Plazo2Tasa		float,
    @Plazo3Tasa		float

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Empresa = Empresa, @FechaN = Fecha FROM Inserted
  SELECT @FechaA = MAX(Fecha) FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha < @FechaN
  IF @FechaA IS NOT NULL
  BEGIN
    SELECT @Plazo1Tasa = Plazo1Tasa, @Plazo2Tasa = Plazo2Tasa, @Plazo3Tasa = Plazo3Tasa FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha = @FechaA
    SELECT @Fecha = DATEADD(day, 1, @FechaA)
    WHILE @Fecha < @FechaN
    BEGIN
      INSERT EmpresaCostoPiso (Empresa,  Fecha,  Plazo1Tasa,  Plazo2Tasa,  Plazo3Tasa) 
                       VALUES (@Empresa, @Fecha, @Plazo1Tasa, @Plazo2Tasa, @Plazo3Tasa) 
      SELECT @Fecha = DATEADD(day, 1, @Fecha)
    END
  END
END
GO

/****** Configuracion de la Empresa Guatemala (GT) ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgGT')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgGT','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgGT') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgGT (
	Empresa 			varchar(5)  	NOT NULL,
	
	Impuesto1Mov			varchar(20)	NULL,
	Impuesto1Acreedor		varchar(10)	NULL,

	CONSTRAINT priEmpresaCfgGT PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** Configuracion de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfg')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfg','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfg') and type = 'U') 
CREATE TABLE dbo.EmpresaCfg (
	Empresa 			varchar(5)  	NOT NULL,

	FormaCosteo			varchar(20)	NULL 		DEFAULT 'Empresa',       
	TipoCosteo			varchar(20)	NULL 		DEFAULT 'Promedio',
	SugerirCostoDev			varchar(20)	NULL		DEFAULT 'Promedio',
	SugerirCostoArtServicio		varchar(20)	NULL	DEFAULT 'No',
	CosteoNivelSubCuenta		bit			NULL	DEFAULT 0,
	PreciosNivelSubCuenta		bit			NULL	DEFAULT 0,
	CosteoActividades			varchar(20)	NULL	DEFAULT 'Tiempo Estandar',
	ToleranciaCosto				money		NULL	DEFAULT 15.0,
	ToleranciaCostoInferior		money		NULL	DEFAULT 15.0,
	ToleranciaTipoCosto		varchar(20)	NULL		DEFAULT 'Promedio',
	ValidarMargenMinimo		varchar(20)	NULL		DEFAULT 'No',
	SeriesLotesMayoreo		bit		NOT NULL	DEFAULT 0,
	Partidas			bit		NOT NULL	DEFAULT 0,
	SeriesLotesAutoCampo		varchar(20)     	NULL 		DEFAULT 'Numero',
	SeriesLotesAutoOrden		varchar(20)     	NULL 		DEFAULT 'ASCENDENTE',
	SeriesImprimirMov		bit		NOT NULL 	DEFAULT 0,
	SeriesImprimirProp		bit		NOT NULL 	DEFAULT 0,
	PresentacionAutoOrden		varchar(20)     	NULL 		DEFAULT 'Unidades Primero',
        CB				bit		NOT NULL	DEFAULT 1,
	CBSerieLote			bit		NULL		DEFAULT 0,
	CBSubCodigos			bit		NOT NULL 	DEFAULT 0,
	CBSubCuentas			bit		NOT NULL 	DEFAULT 0,
	CBPreguntarCantidad		bit		NULL 		DEFAULT 0,
	CBProcesarLote			bit		NOT NULL 	DEFAULT 0,
	CxcAplicaAutoOrden		varchar(20)     	NULL 		DEFAULT 'Fecha Vencimiento',
	CxpAplicaAutoOrden		varchar(20)     	NULL 		DEFAULT 'Fecha Vencimiento',
	PedidosReservar			bit		NOT NULL 	DEFAULT 1,
	PedidosReservarEsp		bit		NULL 		DEFAULT 0,
        PedidosReservarLineaCompleta	bit 		NULL 		DEFAULT 0,
	FacturasPendientes 		bit		NOT NULL 	DEFAULT 0,
	CompraConsignacion		varchar(20)	NULL 		DEFAULT 'No',
	CompraCostoSugerido		varchar(20)	NULL		DEFAULT 'Ultimo',
	CompraDescImporte		bit		NOT NULL	DEFAULT 0,
	CompraVentaSinIVA		bit		NOT NULL 	DEFAULT 1,
	CompraVerClaveProveedor		bit		NOT NULL 	DEFAULT 0,
	VentaDescImporte		bit		NOT NULL	DEFAULT 0,
	VentaChecarCredito		varchar(20)	NULL	        DEFAULT 'Pedido',
	VentaPedidosDisminuyenCredito	bit		NULL		DEFAULT 0,
	VentaBloquearMorosos		varchar(20)	NULL		DEFAULT 'No',
        VentaLiquidaIntegral   		bit		NOT NULL 	DEFAULT 1,
	VentaLiquidaIntegralCxc		bit		NULL	        DEFAULT 1,
	BackOrders			bit		NOT NULL	DEFAULT 0,
	BackOrdersNivel			varchar(20)	NULL		DEFAULT 'Cliente',
	VentaSurtirDemas		bit		NOT NULL	DEFAULT 0,
	VentaPrecios			int		NULL		DEFAULT 1,
	VentaIncentivos			bit		NULL		DEFAULT 0,
	VentaListaPrecios		varchar(20)	NULL,
	VentaConfirmarServicios		bit		NOT NULL 	DEFAULT 1,
	VentaConfirmarContratos		bit		NOT NULL 	DEFAULT 1,
	VentaContratosImpuesto 		float 		NULL 		DEFAULT 15.0,
	VentaContratosArticulo		varchar(20)	NULL,
	VentaServiciosRequiereTareas	bit		NOT NULL 	DEFAULT 0,
	VentaServiciosTareaOmision	varchar(50)	NULL,
	VentaServiciosAutoOP		bit		NULL 		DEFAULT 0,
	VentaServiciosValidarID		bit		NULL 		DEFAULT 1,
	VentaDefCantidad 		float 		NULL		DEFAULT 1,
	VentaPaquetes			bit		NOT NULL 	DEFAULT 0,
	VentaPreciosImpuestoIncluido	bit		NOT NULL 	DEFAULT 0,
	VentaComisionesCobradas		bit		NOT NULL 	DEFAULT 0,
	ComisionBase			varchar(20)	NOT NULL	DEFAULT 'Venta',
	ComisionEspecial		bit		NOT NULL 	DEFAULT 0,

        VentaLimiteRenFacturas		int		NULL,
	VentaLimiteRenFacturasVMOS	bit		NULL 		DEFAULT 0,
	VentaTEEstandar 		int 	  	NULL,
	VentaTEEstandarTipoDias		varchar(10)	NULL 		DEFAULT 'Habiles',
	VentaTEEstandarRecorrerDomingo	bit		NULL		DEFAULT 1,
	InvPaquetes			bit		NOT NULL 	DEFAULT 0,
	InvPrestamosGarantias		bit		NOT NULL 	DEFAULT 0,
	InvEntradasSinCosto		bit		NOT NULL	DEFAULT 0,
	InvSugererirCompra		varchar(20)	NULL,

	CxcProntoPagoTasaDiaria		bit		NULL		DEFAULT 0,
	CxcProntoPagoTasa		float		NULL,
	CxpProntoPagoTasaDiaria		bit		NULL		DEFAULT 0,
	CxpProntoPagoTasa		float		NULL,
	CxcMoratoriosTasa		float		NULL,
	CxcRefinanciamientoTasa		float		NULL,
	CxcAutoAjuste			money		NULL		DEFAULT 1,
	CxcAutoAjusteMov		money		NULL		DEFAULT 1,
	CxcFormaCobroDA  		varchar(50)	NULL		DEFAULT 'Deposito Anticipado',
	CxcDARef				bit			NULL		DEFAULT 0,
	CxcFormaCobroVales  		varchar(50)	NULL		DEFAULT 'Vales',
	CxpProntoPago			bit		NULL 		DEFAULT 0,
	CxcProntoPago			bit		NOT NULL 	DEFAULT 0,
	CxcProntoPagoConcepto		varchar(50)	NULL,
	CxpAutoAjuste			money		NULL		DEFAULT 1,
	CxpAutoAjusteMov		money		NULL		DEFAULT 1,
	CxcControlEfectivo		bit		NOT NULL 	DEFAULT 0,
	CxcTopeEfectivoAuto		money		NULL		DEFAULT 50.0,
	CxcFormaCobroTarjetas		varchar(50) 	NULL 		DEFAULT 'Tarjetas', 	-- ETO Tarjetas 9-Feb-2007
	CxcArticuloTarjetasDef		varchar(20) 	NULL,					-- ETO Tarjetas 9-Feb-2007
	CxcAlmacenTarjetasDef		varchar(10) 	NULL,					-- ETO Tarjetas 9-Feb-2007
	CxcValidarPrecioTarjetas	bit 		NULL 		DEFAULT 1,		-- ETO Tarjetas 9-Feb-2007

	CxpProntoPagoConcepto		varchar(50)	NULL,
	CxpControlEfectivo		bit		NOT NULL 	DEFAULT 0,
	CxpTopeEfectivoAuto		money		NULL		DEFAULT 50.0,
	ChequesPendientes		bit		NOT NULL	DEFAULT 0,
	eChequesPendientes		bit		NOT NULL	DEFAULT 0,
	ChequesDirectos			bit		NULL		DEFAULT 1,
	FormaPagoCambio			varchar(50)	NULL,
	CtaFormato			varchar(20)	NULL		DEFAULT '999-99-999;2',
	CteFormato			varchar(20)	NULL,
	ArtFormato			varchar(20)	NULL,
	PersonalFormato			varchar(20)	NULL,
	CentrosCostosFormato		varchar(20)	NULL,
	ContMoneda			varchar(20)	NULL		DEFAULT 'Pesos',
	ContVerificarPosicion		bit		NOT NULL	DEFAULT 1,
	ContVerificarIVA		bit		NOT NULL	DEFAULT 0,
	ContCentrosCostos		bit		NOT NULL	DEFAULT 0,
	ContCentrosCostosVerificarPos	bit		NOT NULL	DEFAULT 0,
	ContTablaINPC			varchar(50)	NULL		DEFAULT 'INPC',
	TablaISAN			varchar(50)	NULL		DEFAULT 'ISAN',
	ImporteISANLujo			money		NULL,
	TablaISANLujo			varchar(50)	NULL,
	ContUsoInv			bit		NOT NULL 	DEFAULT 0,
	ContUsoCompras			bit		NOT NULL 	DEFAULT 0,
	ContUsoGastos			bit		NOT NULL 	DEFAULT 0,
	ContUsoVentas			bit		NOT NULL 	DEFAULT 0,
	ContUsoDinero			bit		NOT NULL 	DEFAULT 0,
	ContUsoCxc			bit		NOT NULL 	DEFAULT 0,
	ContUsoCxp			bit		NOT NULL 	DEFAULT 0,
	ContUsoFormato			varchar(20)	NULL,
	CtaContabilidad			varchar(20)	NULL		DEFAULT 'A',
	CtaActivo			varchar(20)	NULL		DEFAULT 'B',
	CtaPasivo			varchar(20)	NULL		DEFAULT 'H',
	CtaCapital			varchar(20)	NULL		DEFAULT 'Q',
	CtaResultados			varchar(20)	NULL		DEFAULT 'R',
	CtaIngresos			varchar(20)	NULL		DEFAULT 'S',
	CtaCostoDirecto			varchar(20)	NULL		DEFAULT 'T',
	CtaGastosOperacion		varchar(20)	NULL		DEFAULT 'U',
	CtaOtrosGastosProductos		varchar(20)	NULL		DEFAULT 'U2',
	CtaImpuestos			varchar(20)	NULL		DEFAULT 'U3',
	CtaOrden			varchar(20)	NULL		DEFAULT 'X',
	AutorizarRequisiciones		bit		NOT NULL	DEFAULT 0,
	EmbarqueAfectarCobros		bit		NOT NULL 	DEFAULT 0,
	EmbarqueCobrarDemas		bit		NULL 		DEFAULT 0,
	EmbarqueModificarVencimiento	bit		NULL 		DEFAULT 0,
	AFRevaluarDepreciacion		bit		NOT NULL	DEFAULT 1,
	AFAfectarDinero			bit		NOT NULL	DEFAULT 1,
	AFMantenimientoPendiente	bit		NOT NULL	DEFAULT 1,
	NomOmision			varchar(50)	NULL		DEFAULT 'Normal',
	NomOmisionPeriodo		varchar(20)	NULL		DEFAULT 'Quincenal',
	NomBeneficiario			varchar(50)	NULL,
	NomISRSimplificado		bit		NULL		DEFAULT 0,
	NomSugerirSDI			bit		NULL		DEFAULT 1,
	NomConceptoSDI			varchar(50)	NULL		DEFAULT 'SDI',
	NomSugerirAumentoVacaciones	bit		NULL		DEFAULT 1,
	NomConceptoAumentoVacaciones	varchar(50)	NULL		DEFAULT 'Aumento Vacaciones',
	NomAfectarAumentoVacaciones	bit		NULL		DEFAULT 0,
	NomSugerirDisminuirVacaciones	bit		NULL		DEFAULT 1,
	NomConceptoDisminuirVacaciones	varchar(50)	NULL		DEFAULT 'Vacaciones Disfrutadas',
	NomAfectarDisminuirVacaciones	bit		NULL		DEFAULT 0,

	NomModificarFechaNomina		bit		NULL		DEFAULT 1,
	TablaVacaciones			varchar(50)	NULL		DEFAULT 'Vacaciones',	
	AsisteToleraEntrada		int		NULL		DEFAULT 15,
	AsisteToleraSalida		int		NULL		DEFAULT 1,
	AsisteGenerarFaltas		bit		NULL		DEFAULT 1,
	AsisteGenerarRetardos		bit		NULL		DEFAULT 1,
	AsisteGenerarHorasExtras	bit		NULL		DEFAULT 1,
	RHControlPlazas			varchar(20)	NULL		DEFAULT 'No',	
	RHPlaza				bit		NOT NULL	DEFAULT 0,
	RHValidarAF			varchar(20)	NULL		DEFAULT 'Baja',
	RHIDSE				bit		NOT NULL	DEFAULT 0,
	RHIDSERuta			varchar(255)		NULL,
	CambioTasa			float		NULL,
	NotasBorrador			bit		NOT NULL 	DEFAULT 0,
	InvFisicoConteo			int		NULL		DEFAULT 1,
	ValidarPrecios			varchar(20)	NULL		DEFAULT 'No',
	CxcPlazo1			int		NULL		DEFAULT 15,
	CxcPlazo2			int		NULL		DEFAULT 30,
	CxcPlazo3			int		NULL		DEFAULT 60,
	CxcPlazo4			int		NULL		DEFAULT 90,
	GastoAfecta			varchar(20)	NULL		DEFAULT 'Dinero',
	AlmacenDestinoEntregaGarantia	varchar(10)	NULL,
	CxpPlazo1			int		NULL		DEFAULT 15,
	CxpPlazo2			int		NULL		DEFAULT 30,
	CxpPlazo3			int		NULL		DEFAULT 60,
	CxpPlazo4			int		NULL		DEFAULT 90,
	CosteoSeries			bit		NULL		DEFAULT 0,
	CosteoLotes			bit		NULL		DEFAULT 0,
	ArtRevision			bit		NULL		DEFAULT 0,
	CancelarOtroMesFactura		bit		NULL		DEFAULT 1,
	CancelarFactura			varchar(20)	NULL		DEFAULT 'Cambio Mes',
	CancelarFacturaFecha		varchar(20)	NULL		DEFAULT 'Fecha Cancelacion',
	CancelarFacturaFisicamente	bit		NULL		DEFAULT 0,
	EmbarqueEstadoPendiente		varchar(50)	NULL		DEFAULT 'Pendiente',
	EmbarqueEstadoTransito		varchar(50)	NULL		DEFAULT 'Transito',
	TransferirDemas			bit		NOT NULL	DEFAULT 0,
	CxcDocAutoFolio			varchar(20)	NULL,
	CxpDocAutoFolio			varchar(20)	NULL,
	CxcDocAnticipoAutoFolio		varchar(20)	NULL,
	CxpDocAnticipoAutoFolio		varchar(20)	NULL,
	CxcAnticipoEfectivo		bit		NOT NULL	DEFAULT 0,
	CxpAnticipoEfectivo		bit		NOT NULL	DEFAULT 0,
	Cajeros				bit		NULL		DEFAULT 1,
	ClienteFacturaVMOS		varchar(10)	NULL,
	EstatusFacturaVMOS		varchar(15)	NULL		DEFAULT 'CONCLUIDO',
	AsignarConsecutivoFacturaVMOS	bit		NULL		DEFAULT 0,
	CxpMoratoriosTasa		float		NULL,
	CxcRecargosConcepto		varchar(50)	NULL,
	CxpRecargosConcepto		varchar(50)	NULL,
/*	CxcDescuentoRecargosImpuesto	float		NULL		DEFAULT 15,
	CxpDescuentoRecargosImpuesto	float		NULL		DEFAULT 15,*/
	FormaPagoOmision		varchar(50)	NULL,
	FormaCobroOmision		varchar(50)	NULL,
	CxpRecorrerVencimiento		varchar(20)	NULL		DEFAULT 'No',
	CxcRecorrerVencimiento		varchar(20)	NULL		DEFAULT 'No',
	FormaPagoRequerida		bit		NULL		DEFAULT 0,
	MonedaCosteo			varchar(10)	NULL		DEFAULT 'Pesos',
	MonedaCosteoNivelArticulo	bit		NULL		DEFAULT 0,
	CambioOperacionRelevante	money		NULL		DEFAULT 10000,
	CambioMonedaRelevante		varchar(10)	NULL		DEFAULT 'Dolar',
	CambioCategoriaRelevante1	varchar(50)	NULL		DEFAULT 'Persona Moral',
	CambioCategoriaRelevante2	varchar(50)	NULL		DEFAULT 'Persona Fisica',
	CambioDiasRemesas		int		NULL,
	CompraPaquetes			bit		NULL 		DEFAULT 0,
	EmbarqueGenerarGastoTarifas	bit		NULL 		DEFAULT 0,
	EmbarqueAfectarGastoTarifas	bit		NULL 		DEFAULT 0,
	DineroDesgloseObligatorio	bit		NULL		DEFAULT 0,
	DineroAfectarComision		bit		NULL		DEFAULT 0,

	CancelarFacturaReservarPedido	bit		NULL		DEFAULT 0,

	Texto1				varchar(50)	NULL,
	Fecha1				datetime	NULL,
	Fecha2				datetime	NULL,

	CompraVerClaveIdioma		bit		NULL 		DEFAULT 0,
	InvVerClaveIdioma		bit		NULL 		DEFAULT 0,
	VentaVerClaveIdioma		bit		NULL 		DEFAULT 0,

	CBDirAlmacen			bit		NOT NULL 	DEFAULT 0,
	NomCCRequerido			bit		NULL		DEFAULT 0,
	VentaAnticipoCredito		bit		NULL		DEFAULT 0,
	CompraAnticipoCredito		bit		NULL		DEFAULT 0,
	DineroContX			varchar(20)	NULL		DEFAULT 'Encabezado',
	DineroControlarSobregiros	bit		NULL		DEFAULT 0,
	VentaSugerirSaldoFavorID 	bit		NULL		DEFAULT 0,
	VentaCobroRedondeoDecimales	int		NULL		DEFAULT 2,
	ContMovPresupuesto		bit		NULL		DEFAULT 0,
	ContReservarPresupuesto		bit		NULL		DEFAULT 0,
	ContValidarPresupuesto		bit		NULL		DEFAULT 0,
	ContNivelPresupuesto		varchar(20)	NULL		DEFAULT 'Detalle',
	CompraProveedorRequisicion	bit		NULL 		DEFAULT 0,
	VentaActualizarPrecioMoneda	bit		NULL		DEFAULT 0,

	EspaciosNivel			varchar(50)	NULL		DEFAULT 'Dia',
	EspaciosSobreventa		float		NULL,
	EspaciosMinutos			int		NULL		DEFAULT 60,
	EspaciosBloquearAnteriores 	bit		NULL		DEFAULT 1,
	EspaciosHoraD			varchar(5)	NULL,
	EspaciosHoraA			varchar(5)	NULL,
	EspaciosCfg			varchar(20)	NULL		DEFAULT 'Empresa',
	EspaciosAsignacion		bit		NULL		DEFAULT 0,

	CentroCostosRamas		bit		NULL		DEFAULT 0,
	CentroCostosValidar		bit		NULL		DEFAULT 0,
	CentroCostos2Venta		bit		NULL		DEFAULT 0,
	CentroCostos2VentaD		bit		NULL		DEFAULT 0,		
	CentroCostos2Gasto		bit		NULL		DEFAULT 0,	
	CentroCostos2GastoD		bit		NULL		DEFAULT 0,			
	CentroCostos2Compra		bit		NULL		DEFAULT 0,				
	CentroCostos2CompraD		bit		NULL		DEFAULT 0,			
	CentroCostos3Venta		bit		NULL		DEFAULT 0,
	CentroCostos3VentaD		bit		NULL		DEFAULT 0,		
	CentroCostos3Gasto		bit		NULL		DEFAULT 0,	
	CentroCostos3GastoD		bit		NULL		DEFAULT 0,			
	CentroCostos3Compra		bit		NULL		DEFAULT 0,				
	CentroCostos3CompraD		bit		NULL		DEFAULT 0,			

	ContMoneda2			varchar(10)	NULL		DEFAULT '(No)',
	ContMoneda2Auto			bit		NULL		DEFAULT 1,
	CompraValidarArtProv		bit		NULL		DEFAULT 0,
	InvConfirmarSolicitudes		bit		NULL		DEFAULT 0,
	VentaServicioSituacionTipo	bit		NULL		DEFAULT 0,
	KmsxMes				int		NULL		DEFAULT	1500,

	AFConceptoDepreciacion		varchar(50)	NULL,
	AFAcreedorDepreciacion		varchar(10)	NULL,
	CompraAutoEndoso		bit		NULL		DEFAULT 0,
	CompraAutoEndosoEmpresas	bit		NULL		DEFAULT 0,
	CompraAutoEndosoWS		bit		NULL		DEFAULT 0,
	CompraAutoEndosoWSDL		varchar(255)	NULL,
	CompraAutoEndosoMovs		bit		NULL		DEFAULT 0,
	CompraAutoEndosoAutoCargos	bit		NULL		DEFAULT 0,
	NomDiasDesfasoIncidencias	int		NULL		DEFAULT 0,
	NomPremios			bit		NULL		DEFAULT 0,
	ContMultiSucursal		bit		NULL		DEFAULT 0,
	ContCtaCliente			bit		NULL		DEFAULT 0,
	ContCtaProveedor		bit		NULL		DEFAULT 0,
	ContCtaAlmacen			bit		NULL		DEFAULT 0,
	ContCtaPersonal			bit		NULL		DEFAULT 0,
	ContCtaDinero			bit		NULL		DEFAULT 0,
	ContCtaFormaPago		bit		NULL		DEFAULT 0,
	ContCtaArticulo			bit		NULL		DEFAULT 0,
	NomValidarReferencias		bit		NULL		DEFAULT 0,
	CompraProrrateada		bit		NULL		DEFAULT 0,
	CompraProrrateadaRedondeo	int		NULL		DEFAULT 0,
	DineroAutoFaltanteSobrante 	bit		NULL		DEFAULT 0,
	FormaPagoEfectivo		varchar(50) 	NULL 		DEFAULT 'Efectivo',
	CxcDescContado			bit		NULL		DEFAULT 0,
	CxcDescContadoDias		int		NULL		DEFAULT 1,
	CxcDescContadoPorcentaje	float		NULL,
	CxcValidarDescPPMorosos		bit		NULL		DEFAULT 0,
	ContPermitirCancelacionOrigen	bit		NULL		DEFAULT 0,
	DineroFaltanteModulo		varchar(5)		NULL		DEFAULT 'AGENT',
	DineroConciliarPorSucursales	bit		NULL		DEFAULT 0,
	PrecioMinimoNivelSucursal	bit		NULL		DEFAULT 0,
	ContToleraciaRedondeo		float		NULL		DEFAULT 0.2,
	NomPorcentajeSubsidio		float		NULL		DEFAULT 100,
	CRAcreedor			varchar(10)	NULL,
	CRClase				varchar(50)	NULL,
	CRSubClase			varchar(50)	NULL,
	CRFormaPago			varchar(50)	NULL,
	CRCorteCajaCentralMax		int		NULL		DEFAULT 1,
	CRValidarCorteSaldoCero		bit		NULL		DEFAULT 0,
	CRValidarCorteZSaldoCero	bit		NULL		DEFAULT 0,
	CRAfectarAuto			bit		NULL		DEFAULT 1,
	CREstatusSinAfectar		varchar(15)	NULL		DEFAULT 'SINAFECTAR',
	CRCerrarDiaAuto			bit		NULL		DEFAULT 1,
	CRValidarFolio			bit		NULL		DEFAULT 0,
	ArtRedondeo			varchar(20)	NULL,
	VentaRestringirArtBloqueados	bit		NULL		DEFAULT 0,
	CompraRestringirArtBloquedos	bit		NULL		DEFAULT 0,
	VentaLimiteCreditoNivelGrupo	bit		NULL		DEFAULT 0,
	VentaLimiteCreditoNivelUEN	bit		NULL		DEFAULT 0,
	VentaAnexosAlFacturar		bit		NULL		DEFAULT 0,
	CompraValidarPresupuesto	varchar(20)	NULL		DEFAULT 'No',
	CompraValidarPresupuestoFR	bit		NULL		DEFAULT 0,
	ContCuentaCierre		varchar(20)	NULL,
	VentaEndoso			bit		NULL		DEFAULT 0,
	AFSugerirSerieEntrada		bit		NULL		DEFAULT 0,
	AFConsecutivo			int		NULL,
	VentaPPIndirectos		bit		NULL		DEFAULT 0,
	EmbarqueBaseProrrateo		varchar(20)	NULL		DEFAULT 'Importe',	-- Importe / Paquetes / Peso / Volumen / Peso/Volumen
	VentaRefSerieLotePedidos	bit		NULL		DEFAULT 0,
	VentaArrastrarSerieLote		bit		NULL		DEFAULT 1,
	ACFactorCapacidadPago		float		NULL,
	ACClienteDevengados		varchar(10)	NULL,
	ACProveedorDevengados		varchar(10)	NULL,
	ACCobroIntereses					varchar(20)	NULL		DEFAULT 'Devengados',	-- Devengados / Fijos
	ACConsiderarInflacionIVA			bit		NULL		DEFAULT 0, --MEJORA10041
	ACMonedaCalculoInflacionIVA			varchar(10) NULL, --MEJORA10041
        VentaVerDescripcionExtra        bit		NULL		DEFAULT 0,
        CompraVerDescripcionExtra       bit		NULL		DEFAULT 0,
	DineroCorteSDPorFormaPago	bit		NULL		DEFAULT 0,
	CompraConcentrarEntrada		bit		NULL		DEFAULT 1,
	EmbarqueEliminarDetalle		bit		NULL 		DEFAULT 0,
	CRVentaDescripcionExtra		bit		NULL 		DEFAULT 0,
	CRVentaPrecio			bit		NULL 		DEFAULT 0,
	CRVentaDescuentoLinea		bit		NULL 		DEFAULT 0,
	CRAgente			bit		NULL 		DEFAULT 1,
	CRSoporte			bit 		NULL 		DEFAULT 0,
	CRInvFisico			bit 		NULL 		DEFAULT 0,
	CRCaja				bit 		NULL 		DEFAULT 0,
	CRCxc				bit 		NULL 		DEFAULT 0,
	CRSugerirDescuento		bit 		NULL 		DEFAULT 0,
	CRSugerirPrecio			bit 		NULL 		DEFAULT 0,
	VentaComisionVariable		bit 		NULL 		DEFAULT 0,
	ContArticulo			bit		NULL		DEFAULT 0,

	NConsumoSugerir			bit		NULL		DEFAULT 0,
	NConsumoArtDeducible		varchar(20)	NULL,
	NConsumoArtCoAseguro		varchar(20)	NULL,
	NConsumoArtAjusteCobertura	varchar(20)	NULL,

	CRTransferencias		bit		NULL		DEFAULT 0,
	CosteoMultipleSimultaneo	bit		NULL		DEFAULT 1,
	ExistenciaAlterna		bit		NULL		DEFAULT 0,
	ExistenciaAlternaSerieLote	bit		NULL		DEFAULT 0,
	Posiciones			bit		NULL		DEFAULT 0,

	ACRetencionPF			float		NULL,
	VentaPerdidaAuto		bit		NULL		DEFAULT 0,
	CompraPerdidaAuto		bit		NULL		DEFAULT 0,
	EmbarqueDesembarquesParciales	bit		NULL 		DEFAULT 0,
	AsisteJornadasNocturnas		bit		NULL 		DEFAULT 1,
	ACReciprocidad			float		NULL,

	ImportacionImpuesto1Acreedor	varchar(10)	NULL,
	ImportacionImpuesto1Concepto	varchar(50)	NULL,
	ImportacionImpuesto2Acreedor	varchar(10)	NULL,
	ImportacionImpuesto2Concepto	varchar(50)	NULL,

	ACAjusteConceptoValorResidual	varchar(50) 	NULL,
	ACAjusteConceptoImpuestoAd	varchar(50) 	NULL,
	
	CRPrestamoCxc			bit		NULL		DEFAULT 0,
	ACPlazoDias			varchar(20) 	NULL		DEFAULT 'Naturales',	-- Naturales/Meses 30
	VentaVerDatosOC			bit		NULL		DEFAULT 0,
	CRVentaMov			bit		NULL 		DEFAULT 0,
	CRVentaMovID			bit		NULL 		DEFAULT 0,

	CRZonaImpuestoNivelCte		bit		NULL 		DEFAULT 0,

	AFDepreciacionAnualAjustada	bit		NULL 		DEFAULT 0,
	ACAcreedorEnDisposiciones	bit		NULL 		DEFAULT 0,

	DineroPagoConciliado		bit		NULL 		DEFAULT 0,
	AsisteRegistroCantidad		bit		NULL 		DEFAULT 0,
	AsisteRegistroEstadoAvance	bit		NULL 		DEFAULT 0,
	AsisteVerCostoHora		bit		NULL 		DEFAULT 0,
	AsisteCargarTiempoActConcluida	bit		NULL 		DEFAULT 0,
	AsisteCargarTiempoActCancelada	bit		NULL 		DEFAULT 0,
	DineroValidarMovImpuesto	bit		NULL 		DEFAULT 0,
	ACLineaCreditoExpress		bit		NULL 		DEFAULT 0,
	CreditoTipoAmortizacion		varchar(20)	NULL,	
	CreditoTipoTasa			varchar(20)	NULL,	

	NomDiasMes			float		NULL		DEFAULT 30,
	NomComplemento			bit		NULL		DEFAULT 0,
	NomComplementoTope		money		NULL,
	NomComplementoPremios		float		NULL,
	NomComplementoRetencion		float		NULL,

	DineroInversionIntereses	varchar(20)	NULL		DEFAULT 'Retiro',
	AsisteRecurso			bit		NULL		DEFAULT 0,
	ProyCrearProyecto		varchar(20)	NULL		DEFAULT 'Proyecto',
	ProyActividadAsunto		varchar(20)	NULL		DEFAULT 'Abierto', -- Abierto, Clave, Mixto
	ProyFechaRevision		varchar(20)	NULL		DEFAULT 'Servidor', -- Servidor, Proyecto
	ProyDiasIndicador1		int		NULL,
	ProyIndicador1Liberados		bit		NULL		DEFAULT 0,
	ProyFasesInformativas		bit		NULL		DEFAULT 0,
	ProyGenerarInvAlAfectar		bit		NULL		DEFAULT 0,
	ProyGenerarInvPorActividad	bit		NULL		DEFAULT 0,
	ProyGenerarInvTiempo		int		NULL		DEFAULT 7,
	ProyGenerarInvTiempoUnidad	varchar(20)	NULL		DEFAULT 'Dia',

	VentaProveedorRef		bit		NULL		DEFAULT 0,
	VentaPrecioMoneda		bit		NULL		DEFAULT 0,

	CRProcesoDistribuido		bit		NULL		DEFAULT 0,
	CRServidorOperaciones		varchar(50)	NULL,
	CRBaseDatosOperaciones		varchar(50)	NULL,
	MoverNotasAuto			bit		NULL		DEFAULT 0,
	ACPermitirMovFechaAnterior	bit		NULL		DEFAULT 0,
	DineroConciliarEstatus		bit		NULL		DEFAULT 0,

	PermiteCompletarEnAvances	bit		NULL		DEFAULT 0,
	ContCuentaCuadre		varchar(20)	NULL,
	ContToleranciaCuadre		float		NULL,

	VisualizarArrastre		bit		NULL		DEFAULT 0,
	VentaPerdidaAutoPorcentaje	float		NULL,
	CompraPerdidaAutoPorcentaje	float		NULL,
	ValidarOrdenCompraTolerancia	bit		NULL		DEFAULT 0,
	CompraValidarPresupuestoMov	varchar(15)	NULL		DEFAULT 'Entrada Compra',
	CompraValidarPresupuestoCC	bit		NULL		DEFAULT 0,
	CompraValidarPresupuestoCant	bit		NULL		DEFAULT 0,
	
	WMSSugerirEntarimado		bit		NULL		DEFAULT 0,
	WMSInventarioTarimas		bit		NULL		DEFAULT 0,
	
	CPComprometido2			bit		NULL		DEFAULT 0,
	CPDevengado2			bit		NULL		DEFAULT 0,
	CxcIntransferibleTarjeta	bit		NULL		DEFAULT 0,
	CxcCaducidadTarjeta		bit		NULL		DEFAULT 0,
	CxcCaducidadTarjetaFecha	datetime	NULL,
	
	CPSepararImpuestos		bit		NULL		DEFAULT 0,
	CPClavePresupuestalImpuesto1	varchar(50)	NULL,
	CPClavePresupuestalImpuesto2	varchar(50)	NULL,
	CPClavePresupuestalImpuesto3	varchar(50)	NULL,
	CPClavePresupuestalRetencion1	varchar(50)	NULL,  --BUG15710
	CPClavePresupuestalRetencion2	varchar(50)	NULL,  --BUG15710
	CPClavePresupuestalRetencion3	varchar(50)	NULL,  --BUG15710

	PersonalCostoHoraFactor		float		NULL,
	OrganizacionNivelDetalle	bit		NULL		DEFAULT 0,
	CompraCostoConImpuesto		bit		NULL		DEFAULT 0,
	RHAutorizarPlazas		bit		NULL		DEFAULT 0,
	VentaMovImpuestoDesdeRemision	bit		NULL		DEFAULT 0, --MEJORA1002
		
	SAUXConsumo						varchar(20)	NULL	DEFAULT '(Sol. Pendiente)',
    DineroProrrateoMovImpuesto      bit     NULL        DEFAULT 0,	

	AFGenerarGastoCfg				varchar(20) NULL, --MEJORA10041
	AFGenerarGasto					bit		NULL, --MEJORA10041
	
    AjustesAutomaticosMES	        bit     NULL        DEFAULT 0, --REQ12534 Factory

--REQ12615 WMS	
	WMSAndenSurtidoContacto			bit		NULL		DEFAULT 0,
	WMSDispararReacomodos			bit		NULL		DEFAULT 0,
	WMSPermitirReacomodosDomicilio	bit		NULL		DEFAULT 0,
	WMSLeerPosicionOrigen			bit		NULL		DEFAULT 1,
	WMSRotacionArticulo				bit		NULL		DEFAULT 0,
	WMSTipoAcomodador				varchar(50)	NULL	DEFAULT "Agente",
	WMSValidarZona					bit		NULL		DEFAULT 1,
	WMSMovilTarea					varchar(20)	NULL	DEFAULT "Flujo y Prioridad",
	GenerarNCAlProcesar                             bit NULL DEFAULT 0,
	ArtTarjetaServicio                              varchar(20)     NULL,
	FacturaGlobalPeriodo            bit     NULL        DEFAULT 0,--23046
--REQ PROYECTOS
    ProyEnviarTareaGestion          bit     NULL        DEFAULT 0,
	ProyTareaEstado                 varchar(30) NULL    DEFAULT 'No comenzada',
	CONSTRAINT priEmpresaCfg PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaTEEstandar', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaTEEstandarTipoDias', 'varchar(10) NULL DEFAULT "Habiles" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaServiciosAutoOP', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'TransferirDemas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDocAutoFolio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpDocAutoFolio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcProntoPagoTasaDiaria', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcProntoPagoTasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpProntoPago', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpProntoPagoTasaDiaria', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpProntoPagoTasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcAnticipoEfectivo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpAnticipoEfectivo', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'Cajeros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcFormaCobroVales', 'varchar(50) NULL DEFAULT "Vales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ClienteFacturaVMOS', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpMoratoriosTasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcRecargosConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpRecargosConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'FormaPagoOmision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'FormaCobroOmision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpRecorrerVencimiento','varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcRecorrerVencimiento','varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'FormaPagoRequerida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomSugerirSDI', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomConceptoSDI', 'varchar(50)	NULL DEFAULT "SDI" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomSugerirAumentoVacaciones', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomConceptoAumentoVacaciones', 'varchar(50) NULL DEFAULT "Aumento Vacaciones" WITH VALUES'

EXEC spALTER_TABLE 'EmpresaCfg', 'NomSugerirDisminuirVacaciones', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomConceptoDisminuirVacaciones', 'varchar(50) NULL DEFAULT "Vacaciones Disfrutadas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomAfectarDisminuirVacaciones', 'bit NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'EmpresaCfg', 'MonedaCosteo', 'varchar(10) NULL	DEFAULT "Pesos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'MonedaCosteoNivelArticulo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CambioOperacionRelevante', 'money NULL DEFAULT 10000 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CambioMonedaRelevante', 'varchar(10) NULL DEFAULT "Dolar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CambioCategoriaRelevante1', 'varchar(50) NULL	DEFAULT "Persona Moral" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CambioCategoriaRelevante2', 'varchar(50) NULL	DEFAULT "Persona Fisica" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CambioDiasRemesas', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDocAnticipoAutoFolio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpDocAnticipoAutoFolio', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraPaquetes', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueGenerarGastoTarifas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueAfectarGastoTarifas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroDesgloseObligatorio', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroAfectarComision', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraVerClaveIdioma', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CancelarFacturaReservarPedido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'InvVerClaveIdioma', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaVerClaveIdioma', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ComisionBase', 'varchar(20) NOT NULL DEFAULT "Venta" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomAfectarAumentoVacaciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CBDirAlmacen', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomCCRequerido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ComisionEspecial', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaAnticipoCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAnticipoCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroContX', 'varchar(20) NULL DEFAULT "Encabezado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroControlarSobregiros', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaSugerirSaldoFavorID', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContMovPresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContReservarPresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContValidarPresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraProveedorRequisicion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaActualizarPrecioMoneda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosCfg', 'varchar(20) NULL DEFAULT "Empresa" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosSobreventa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosNivel', 'varchar(50)	NULL DEFAULT "Dia" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosMinutos', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosBloquearAnteriores', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosHoraD', 'varchar(5) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosHoraA', 'varchar(5) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'EspaciosAsignacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostosRamas', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CtaGastosOperacion', 'varchar(20) NULL DEFAULT "U" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CtaOtrosGastosProductos', 'varchar(20) NULL DEFAULT "U2" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CtaImpuestos', 'varchar(20) NULL	DEFAULT "U3" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContMoneda2', 'varchar(10) NULL DEFAULT "(No)" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarArtProv', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'InvConfirmarSolicitudes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EstatusFacturaVMOS', 'varchar(15) NULL DEFAULT "CONCLUIDO" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaIncentivos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ChequesDirectos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'PedidosReservarLineaCompleta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2Venta',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2VentaD',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2Gasto',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2GastoD',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2Compra',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2CompraD',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3Venta',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3VentaD',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3Gasto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3GastoD',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3Compra',	'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3CompraD', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VisualizarArrastre', 'bit NULL DEFAULT 0 WITH VALUES'
-- 9036
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos2AF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostos3AF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFGastoConCategoriaAF', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if (select version from version) <= 2023
BEGIN
  EXEC spALTER_TABLE 'EmpresaCfg', 'VentaCobroRedondeoDecimales', 'int NULL DEFAULT 2 WITH VALUES'
  EXEC("UPDATE EmpresaCfg SET VentaCobroRedondeoDecimales = CASE WHEN VentaPreciosImpuestoIncluido = 1 THEN 1 ELSE 2 END")
END
EXEC spALTER_TABLE 'EmpresaCfg', 'TablaISAN', 'varchar(50) NULL	DEFAULT "ISAN" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomModificarFechaNomina', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'TablaVacaciones', 'varchar(50) NULL DEFAULT "Vacaciones" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'SugerirCostoArtServicio', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaServicioSituacionTipo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'KmsxMes', 'int NULL DEFAULT 1500 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFConceptoDepreciacion', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFAcreedorDepreciacion', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndoso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndosoEmpresas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomDiasDesfasoIncidencias', 'int NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomPremios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContMultiSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaCliente', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaProveedor', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaAlmacen', 'bit	NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaDinero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'PersonalFormato', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomValidarReferencias', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContNivelPresupuesto', 'varchar(20) NULL DEFAULT "Detalle" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraProrrateada', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraProrrateadaRedondeo', 'int NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteGenerarFaltas', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteGenerarRetardos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteGenerarHorasExtras', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaFormaPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCtaArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroAutoFaltanteSobrante', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'FormaPagoEfectivo', 'varchar(50) NULL DEFAULT "Efectivo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDescContado', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDescContadoDias', 'int NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDescContadoPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcValidarDescPPMorosos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CentroCostosValidar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContPermitirCancelacionOrigen', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroFaltanteModulo', 'varchar(5) NULL DEFAULT "AGENT" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'PedidosReservarEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroConciliarPorSucursales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'PrecioMinimoNivelSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContToleraciaRedondeo','float	NULL DEFAULT 0.2 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomPorcentajeSubsidio', 'float NULL DEFAULT 100 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRAcreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRSubClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRFormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaRestringirArtBloqueados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraRestringirArtBloquedos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaServiciosValidarID', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRCorteCajaCentralMax', 'int NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRValidarCorteSaldoCero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRValidarCorteZSaldoCero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaLimiteCreditoNivelGrupo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaLimiteCreditoNivelUEN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaAnexosAlFacturar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRAfectarAuto', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRCerrarDiaAuto', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRValidarFolio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarPresupuesto', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCuentaCierre', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaEndoso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndosoMovs', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ImporteISANLujo', 'money NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'TablaISANLujo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ArtRedondeo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFSugerirSerieEntrada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFConsecutivo', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsignarConsecutivoFacturaVMOS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaPPIndirectos', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueBaseProrrateo', 'varchar(20) NULL DEFAULT "Importe" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContUsoDinero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarPresupuestoFR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaRefSerieLotePedidos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaArrastrarSerieLote', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CosteoActividades', 'varchar(20) NULL	DEFAULT "Tiempo Real" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CBPreguntarCantidad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFactorCapacidadPago', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACClienteDevengados', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACProveedorDevengados', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaVerDescripcionExtra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraVerDescripcionExtra', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaLiquidaIntegralCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACCobroIntereses', 'varchar(20) NULL DEFAULT "Devengados" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaPedidosDisminuyenCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroCorteSDPorFormaPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaTEEstandarRecorrerDomingo', 'bit	NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraConcentrarEntrada', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CancelarFacturaFecha', 'varchar(20) NULL DEFAULT "Fecha Cancelacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CancelarFacturaFisicamente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContMoneda2Auto', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueEliminarDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRVentaDescripcionExtra','bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRVentaPrecio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRVentaDescuentoLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRAgente', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRSoporte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRInvFisico', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRCaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRSugerirDescuento', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRSugerirPrecio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContUsoCxc', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContUsoCxp', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaComisionVariable', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NConsumoSugerir', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NConsumoArtDeducible', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'NConsumoArtCoAseguro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRTransferencias', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CosteoMultipleSimultaneo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'Posiciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACRetencionPF', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'RHAutorizarPlazas', 'bit NULL DEFAULT 0 WITH VALUES'
GO
/*
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDescuentoRecargosImpuesto', 'float NULL DEFAULT 15 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxpDescuentoRecargosImpuesto', 'float NULL DEFAULT 15 WITH VALUES'
*/
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroAfectarComisionIVA', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaPerdidaAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraPerdidaAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueDesembarquesParciales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NConsumoArtAjusteCobertura', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteJornadasNocturnas', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACReciprocidad', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ImportacionImpuesto1Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ImportacionImpuesto1Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ImportacionImpuesto2Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ImportacionImpuesto2Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CBSerieLote', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACAjusteConceptoValorResidual', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACAjusteConceptoImpuestoAd', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRPrestamoCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACPlazoDias', 'varchar(20) NULL DEFAULT "Naturales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ExistenciaAlterna','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ExistenciaAlternaSerieLote', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaVerDatosOC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcDARef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRVentaMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRVentaMovID', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaLimiteRenFacturasVMOS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRZonaImpuestoNivelCte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AFDepreciacionAnualAjustada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACAcreedorEnDisposiciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroPagoConciliado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CREstatusSinAfectar', 'varchar(15) NULL DEFAULT "SINAFECTAR" WITH VALUES'
go
if not exists(select * from syscampo where tabla = 'EmpresaCfg' and campo = 'RHControlPlazas')
begin
  EXEC("ALTER TABLE EmpresaCfg ADD RHControlPlazas varchar(20) NULL DEFAULT 'No' WITH VALUES")
  EXEC("UPDATE EmpresaCfg SET RHControlPlazas = 'Simple' WHERE RHPlaza = 1")
end
GO
EXEC spRENAME_COLUMN 'EmpresaCfg', 'FactorajeTipoAmortizacion', 'CreditoTipoAmortizacion'
EXEC spRENAME_COLUMN 'EmpresaCfg', 'FactorajeTipoTasa', 'CreditoTipoTasa'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteRegistroCantidad', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteRegistroEstadoAvance','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteVerCostoHora', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteCargarTiempoActConcluida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteCargarTiempoActCancelada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroValidarMovImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACLineaCreditoExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CreditoTipoAmortizacion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CreditoTipoTasa', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndosoWS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndosoWSDL', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcFormaCobroTarjetas', 'varchar(50) NULL DEFAULT "Tarjetas" WITH VALUES'	-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcArticuloTarjetasDef', 'varchar(20) NULL'					-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcAlmacenTarjetasDef', 'varchar(10) NULL'					-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'EmpresaCfg', 'CxcValidarPrecioTarjetas', 'bit NULL DEFAULT 1 WITH VALUES'			-- ETO Tarjetas 9-Feb-2007
EXEC spALTER_TABLE 'EmpresaCfg', 'NomComplemento', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomComplementoTope', 'money NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomComplementoRetencion', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomComplementoPremios', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'NomDiasMes', 'float NULL DEFAULT 30 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroInversionIntereses', 'varchar(20) NULL DEFAULT "Retiro Inversion" WITH VALUES'
GO
if not exists(select * FROM SysCampo where tabla = 'EmpresaCfg' AND Campo='CxcAutoAjusteMov')
BEGIN
  EXEC spALTER_TABLE 'EmpresaCfg', 'CxcAutoAjusteMov', 'money NULL DEFAULT 1'
  EXEC ('UPDATE EmpresaCfg SET CxcAutoAjusteMov = CxcAutoAjuste')
END
GO
if not exists(select * FROM SysCampo where tabla = 'EmpresaCfg' AND Campo='CxpAutoAjusteMov')
BEGIN
  EXEC spALTER_TABLE 'EmpresaCfg', 'CxpAutoAjusteMov', 'money NULL DEFAULT 1'
  EXEC ('UPDATE EmpresaCfg SET CxpAutoAjusteMov = CxpAutoAjuste')
END
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'AsisteRecurso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyCrearProyecto', 'varchar(20) NULL DEFAULT "Proyecto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyAsunto', 'varchar(20) NULL DEFAULT "Abierto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyFechaRevision', 'varchar(20) NULL	DEFAULT "Servidor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyDiasIndicador1', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyIndicador1Liberados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueCobrarDemas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaProveedorRef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaPrecioMoneda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyFasesInformativas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRProcesoDistribuido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRServidorOperaciones', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CRBaseDatosOperaciones', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraAutoEndosoAutoCargos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'MoverNotasAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACPermitirMovFechaAnterior', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroConciliarEstatus', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'RHValidarAF', 'varchar(20) NULL DEFAULT "Baja" WITH VALUES'

EXEC spALTER_TABLE 'EmpresaCfg', 'RHIDSE', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'RHIDSERuta', 'varchar(255) NULL'

EXEC spALTER_TABLE 'EmpresaCfg', 'PermiteCompletarEnAvances', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContCuentaCuadre', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ContToleranciaCuadre', 'float NULL'
GO
EXEC spALTER_COLUMN 'EmpresaCfg' ,'FormaCosteo', 'varchar(20)	NULL', '"Empresa"'      
EXEC spALTER_COLUMN 'EmpresaCfg' ,'TipoCosteo', 'varchar(20)	NULL', '"Promedio"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'SugerirCostoDev', 'varchar(20)	NULL', '"Promedio"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'SugerirCostoArtServicio','varchar(20)	NULL', '"No"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ToleranciaTipoCosto', 'varchar(20)	NULL', '"Promedio"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ValidarMargenMinimo', 'varchar(20)	NULL', '"No"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'SeriesLotesAutoCampo', 'varchar(20) NULL', '"Numero"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'SeriesLotesAutoOrden', 'varchar(20) NULL', '"ASCENDENTE"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'PresentacionAutoOrden', 'varchar(20) NULL', '"Unidades Primero"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxcAplicaAutoOrden', 'varchar(20) NULL', '"Fecha Vencimiento"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxpAplicaAutoOrden', 'varchar(20) NULL', '"Fecha Vencimiento"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CompraConsignacion', 'varchar(20) NULL', '"No"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CompraCostoSugerido', 'varchar(20) NULL', '"Ultimo"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'VentaChecarCredito', 'varchar(20) NULL', '"Pedido"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'VentaBloquearMorosos', 'varchar(20)	NULL', '"No"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'BackOrdersNivel', 'varchar(20) NULL', '"Cliente"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'VentaListaPrecios', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'VentaContratosArticulo', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ComisionBase', 'varchar(20)	NOT NULL', '"Venta"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'VentaTEEstandarTipoDias', 'varchar(10) NULL', '"Habiles"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'InvSugererirCompra', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxcAlmacenTarjetasDef', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaFormato', 'varchar(20) NULL', '"999-99-999;2"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CteFormato', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ArtFormato', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'PersonalFormato', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CentrosCostosFormato', 'varchar(20)	NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ContMoneda', 'varchar(20) NULL', '"Pesos"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ContUsoFormato', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaContabilidad', 'varchar(20) NULL', '"A"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaActivo', 'varchar(20) NULL', '"B"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaPasivo', 'varchar(20) NULL', '"H"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaCapital', 'varchar(20) NULL', '"Q"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaResultados', 'varchar(20) NULL', '"R"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaIngresos', 'varchar(20) NULL', '"S"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaCostoDirecto', 'varchar(20) NULL', '"T"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaGastosOperacion', 'varchar(20) NULL', '"U"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaOtrosGastosProductos', 'varchar(20) NULL', '"U2"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaImpuestos', 'varchar(20) NULL', '"U3"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CtaOrden', 'varchar(20)	NULL', '"X"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ValidarPrecios', 'varchar(20) NULL', '"No"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'GastoAfecta', 'varchar(20) NULL', '"Dinero"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'AlmacenDestinoEntregaGarantia', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxcDocAutoFolio', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxpDocAutoFolio', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxcDocAnticipoAutoFolio', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CxpDocAnticipoAutoFolio', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ClienteFacturaVMOS', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'EstatusFacturaVMOS', 'varchar(15) NULL', '"CONCLUIDO"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'MonedaCosteo', 'varchar(10)	NULL', '"Pesos"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CambioMonedaRelevante', 'varchar(10) NULL', '"Dolar"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ContMoneda2', 'varchar(10) NULL', '"(No)"'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'CRAcreedor', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ACClienteDevengados', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'ACProveedorDevengados', 'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'NConsumoArtDeducible', 'varchar(20)	NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'NConsumoArtCoAseguro', 'varchar(20)	NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'NConsumoArtAjusteCobertura', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg' ,'DineroFaltanteModulo', 'varchar(5) NULL', '"AGENT"'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'EmbarqueSugerirCobros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFacturarInteresesAlCobro', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFacturarInteresesMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFacturarInteresesConcepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFacturarMoratoriosMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACFacturarMoratoriosConcepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACBonificarQuitasAlCobro', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACBonificarQuitasMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACBonificarQuitasConcepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACBonificarQuitasMoraMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ACBonificarQuitasMoraConcepto', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaPerdidaAutoPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraPerdidaAutoPorcentaje', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyGenerarInvAlAfectar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyGenerarInvPorActividad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyGenerarInvTiempo', 'int DEFAULT 7 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'ProyGenerarInvTiempoUnidad', 'varchar(20) DEFAULT "Dia" WITH VALUES'
GO

if not exists(select * from syscampo where tabla = 'EmpresaCfg' and campo = 'ToleranciaCostoInferior')
BEGIN
  EXEC("ALTER TABLE EmpresaCfg ADD ToleranciaCostoInferior money NULL")
  EXEC("UPDATE EmpresaCfg SET ToleranciaCostoInferior = ToleranciaCosto")
END
GO

EXEC spALTER_TABLE 'EmpresaCfg', 'ValidarOrdenCompraTolerancia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarPresupuestoMov', 'varchar(15) NULL Default "Entrada Compra" WITH VALUES' -- Requisicion/Orden Compra/Entrada Compra
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarPresupuestoCC', 'bit NULL Default 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraValidarPresupuestoCant', 'bit NULL Default 0 WITH VALUES'
GO	
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSSugerirEntarimado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSInventarioTarimas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPComprometido2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPDevengado2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaCfg', 'CxcIntransferibleTarjeta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaCfg', 'CxcCaducidadTarjeta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC SPALTER_TABLE 'EmpresaCfg', 'CxcCaducidadTarjetaFecha', 'datetime NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPSepararImpuestos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalImpuesto1', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalImpuesto2', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalImpuesto3', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalRetencion1', 'varchar(50) NULL' --BUG15710
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalRetencion2', 'varchar(50) NULL' --BUG15710
EXEC spALTER_TABLE 'EmpresaCfg', 'CPClavePresupuestalRetencion3', 'varchar(50) NULL' --BUG15710
EXEC spALTER_TABLE 'EmpresaCfg', 'PersonalCostoHoraFactor', 'FLOAT'
EXEC spALTER_TABLE 'EmpresaCfg', 'OrganizacionNivelDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'CompraCostoConImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'VentaMovImpuestoDesdeRemision', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA1002
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'SAUXConsumo', 'varchar(20) NULL DEFAULT "(Sol. Pendiente)" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'DineroProrrateoMovImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg', 'ACConsiderarInflacionIVA', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA10041
EXEC spALTER_TABLE 'EmpresaCfg', 'ACMonedaCalculoInflacionIVA', 'varchar(10) NULL' --MEJORA10041
EXEC spALTER_TABLE 'EmpresaCfg', 'AFGenerarGastoCfg', 'varchar(20) NULL' --MEJORA10041
EXEC spALTER_TABLE 'EmpresaCfg', 'AFGenerarGasto', 'bit NULL' --MEJORA10041
GO

 --REQ12534 Factory  
 EXEC spALTER_TABLE 'EmpresaCfg', 'AjustesAutomaticosMES', 'bit NULL' 
 GO

  EXEC spALTER_TABLE 'EmpresaCfg', 'ReservarSolicitudesFacory', 'bit NULL' 
 GO

  EXEC spALTER_TABLE 'EmpresaCfg', 'ToleranciaAjuste', 'float NULL' 
 GO

--REQ12615 WMS
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSAndenSurtidoContacto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSDispararReacomodos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSPermitirReacomodosDomicilio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSLeerPosicionOrigen', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSRotacionArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSTipoAcomodador', 'varchar(50)  NULL DEFAULT "Agente" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSValidarZona', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSMovilTarea', 'varchar(20) NULL DEFAULT "Flujo y Prioridad" WITH VALUES'
GO

 --REQ 15448  
 EXEC spALTER_TABLE 'EmpresaCfg', 'GenerarNCAlProcesar ', 'bit NULL DEFAULT 0 WITH VALUES'
 EXEC spALTER_TABLE 'EmpresaCfg', 'ArtTarjetaServicio ', 'varchar(20)  NULL'
GO

--23063
EXEC spALTER_TABLE 'EmpresaCfg', 'FacturaGlobalPeriodo', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--BUG6556
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSPorcentajeMinimoADom', 'float NULL'
GO
--TASK6535
EXEC spALTER_TABLE 'EmpresaCfg', 'WMSPCKUbicacion', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_Table 'EmpresaCfg', 'HorasExtrasCompletas', 'bit default 1 WITH VALUES'
EXEC spALTER_Table 'EmpresaCfg', 'HerramientaHorasExtra', 'bit default 1 WITH VALUES'
GO

-- REQ PROYECTOS
EXEC spALTER_Table 'EmpresaCfg', 'ProyEnviarTareaGestion', 'bit default 0 WITH VALUES'
EXEC spALTER_Table 'EmpresaCfg', 'ProyTareaEstado', 'varchar(30) NULL DEFAULT ''No comenzada'' WITH VALUES'
GO

EXEC spALTER_Table 'EmpresaCfg', 'ProyActividadAsunto', 'varchar(20) NULL DEFAULT ''Abierto'' WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaCfg', 'AsistDescansolaborado', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsistDiaFestivolaborado', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg', 'AsistDomingoLaborado', 'bit NULL DEFAULT 1 WITH VALUES'
GO

EXEC spALTER_Table 'EmpresaCfg', 'CompraCostearDCporMovimiento', 'bit default 0 WITH VALUES'
GO

--Integración MES
EXEC spALTER_TABLE 'EmpresaCfg', 'IntelMESInterfase',     'BIT',          '0'
EXEC spALTER_TABLE 'EmpresaCfg', 'IntelMESInterfaseRuta', 'VARCHAR(200)'
GO

/****** Configuracion de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfg2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfg2','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfg2') and type = 'U') 
CREATE TABLE dbo.EmpresaCfg2 (
	Empresa 			varchar(5)  	NOT NULL,
	
	CxcPosfechados			bit		NOT NULL	DEFAULT 0,
	CxpPosfechados			bit		NOT NULL	DEFAULT 0,
	MultiUnidades			bit		NOT NULL	DEFAULT 0,
	VentaInstrucciones		bit		NOT NULL	DEFAULT 0,
	FacturaCobroIntegrado		bit		NOT NULL	DEFAULT 0,
	PrecioNivelUnidad		bit		NULL		DEFAULT 0,
	
	Logico1				bit		NOT NULL	DEFAULT 0,
	Logico2				bit		NOT NULL	DEFAULT 0,
	Logico3				bit		NOT NULL	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	VentaMultiDepartamento		bit		NOT NULL	DEFAULT 0,
	VentaMultiAgente		bit		NOT NULL	DEFAULT 0,
	VentaDMultiAgente		bit		NOT NULL	DEFAULT 0,
	VentaDMultiAgenteSugerir	bit		NULL		DEFAULT 0,
	InvVerPuntoOrden		bit		NOT NULL	DEFAULT 0,
	ProdDesglosarGrupoSolicitud	bit		NOT NULL	DEFAULT 0,
	GastoSolicitudAnticipoImpuesto	bit		NOT NULL	DEFAULT 1,
	GastoCopiarImporte		bit		NOT NULL	DEFAULT 1,
	ProdMermaIncluida		bit		NOT NULL	DEFAULT 0,
	ProdDesperdicioIncluido		bit		NOT NULL	DEFAULT 0,
	ValidarLotesCostoDif		bit		NOT NULL	DEFAULT 0,
	CxpAplicaDif			bit		NOT NULL	DEFAULT 0,
	CxcAplicaDif			bit		NOT NULL	DEFAULT 0,
	ProdDesglosarDestinoCompra	bit		NOT NULL	DEFAULT 0,
	ProdDesglosarDestinoProducto	bit		NOT NULL	DEFAULT 0,
	ProdDesglosarDestinoSolicitud	bit		NOT NULL	DEFAULT 0,
	GastoCantidades			bit		NOT NULL	DEFAULT 1,
	ProdAutoReservar		bit		NOT NULL	DEFAULT 0,
	VentaDevSinAntecedente		bit		NOT NULL	DEFAULT 0,
	VentaDevSeriesSinAntecedente	bit		NOT NULL	DEFAULT 1,
	VIN				bit		NOT NULL	DEFAULT 0,
	VINAccesorioArt			bit		NULL		DEFAULT 0,
	VINCostoSumaAccesorios		bit		NULL		DEFAULT 0,
	CxcTramites			bit		NOT NULL	DEFAULT 0,
	InvMultiAlmacen			bit		NOT NULL	DEFAULT 0,
	VentaMultiAlmacen		bit		NOT NULL	DEFAULT 0,
	AutoAsignarBackOrders		bit		NOT NULL	DEFAULT 0,
	VentaAutoBloqueo		bit		NOT NULL	DEFAULT 0,
	AgentMonedaCont			bit		NOT NULL	DEFAULT 0,
	CxpMonedaCont			bit		NOT NULL	DEFAULT 0,
	CxcMonedaCont			bit		NOT NULL	DEFAULT 0,
	FacturasPendientesSerieLote	bit		NOT NULL	DEFAULT 0,
	CompraBonifConsecutivoIndep	bit		NOT NULL	DEFAULT 0,
	CompraDevConsecutivoIndep	bit		NOT NULL	DEFAULT 0,
	VentaDevConsecutivoIndep	bit		NOT NULL	DEFAULT 0,
	VentaBonifConsecutivoIndep	bit		NOT NULL	DEFAULT 0,
	CxcComisionCreditos		bit		NOT NULL	DEFAULT 0,
	CxcComisionCreditoDiverso	bit		NOT NULL	DEFAULT 0,
	ProdFactorDinamico		bit		NOT NULL	DEFAULT 0,
	InvFactorDinamico		bit		NOT NULL	DEFAULT 0,
	VentaFactorDinamico		bit		NOT NULL	DEFAULT 0,
	CompraFactorDinamico		bit		NOT NULL	DEFAULT 0,
	AutoAjustarArtUnidadFactor	bit		NULL		DEFAULT 0,
	Gasto2Retenciones		bit		NOT NULL	DEFAULT 0,
	Gasto3Retenciones		bit		NOT NULL	DEFAULT 0,
	CompraRecibirDemas		bit		NOT NULL	DEFAULT 0,
	CompraRecibirDemasTolerancia	float		NULL,
	VentaDFechaRequerida		bit		NOT NULL	DEFAULT 0,
	VentaDHoraRequerida		bit		NOT NULL	DEFAULT 0,
	CxpAplicaManualDef		bit		NOT NULL	DEFAULT 0,
	CxcAplicaManualDef		bit		NOT NULL	DEFAULT 0,
	CxcAnticiposFacturados		bit		NOT NULL	DEFAULT 0,
	Logico51			bit		NOT NULL	DEFAULT 0,
	Logico52			bit		NOT NULL	DEFAULT 0,
	ProdAlmacenMP			varchar(10)	NULL,
	ProdAlmacenProcesoDef		varchar(10)	NULL,
	ProdTipoOpcionDef		varchar(20)	NULL,
	Logico53			bit		NOT NULL	DEFAULT 0,
	Logico54			bit		NOT NULL	DEFAULT 0,

	NivelFactorMultiUnidad		varchar(20)	NULL		DEFAULT 'Unidad',
	ProdAutoLote			varchar(20)	NULL,
	ProdAutoCB			varchar(20)	NULL,
	PlanAfectarOrdenesDistribucion	bit		NULL		DEFAULT 0,
	ProdLoteOrdenar			varchar(30)	NULL,
	ProdAccionOrdenar		varchar(50)	NULL,
	ProdGenerarConsumo		bit		NOT NULL	DEFAULT 1,
	ProdAfectarConsumo		bit		NULL		DEFAULT 1,
	OpcionMatriz			bit		NULL		DEFAULT 0,
	ProdProgramar			bit		NULL		DEFAULT 0,
	ProdDiasFestivos		bit		NULL		DEFAULT 1,

	Mermas				bit		NULL		DEFAULT 1,
	Desperdicios			bit		NULL		DEFAULT 1,

	RetencionAlPago			bit		NULL		DEFAULT 1,
	RetencionAlPagoMovImpuesto	bit		NULL		DEFAULT 1,
	GastoRetencionAcreedor		varchar(10)	NULL,
	GastoRetencionConcepto		varchar(50)	NULL,
	GastoRetencion2Acreedor		varchar(10)	NULL,
	GastoRetencion2Concepto		varchar(50)	NULL,
	GastoRetencion3Acreedor		varchar(10)	NULL,
	GastoRetencion3Concepto		varchar(50)	NULL,
	VentaArtAlmacenEspecifico	bit		NULL		DEFAULT 0,
	RutaDistribucion		varchar(50)	NULL,
	RutaDistribucionNivelArticulo	bit		NULL		DEFAULT 0,
	CodigoCliente			bit		NULL		DEFAULT 0,
	CxcDescuentoRecargos		bit		NULL		DEFAULT 0,
	CxpDescuentoRecargos		bit		NULL		DEFAULT 0,

	CompraMultiAlmacen		bit		NOT NULL	DEFAULT 1,
	PlanNivelAlmacen		bit		NULL		DEFAULT 0,
	CompraAutoCargos		bit		NULL		DEFAULT 0,
	GastoAutoCargos			bit		NULL		DEFAULT 0,
	PlanSinDemanda			bit		NULL		DEFAULT 1,
	PlanISDemanda			bit		NULL		DEFAULT 0,
	ProdTipoMerma			varchar(1)		NULL		DEFAULT '%',
	PlanMetodo			varchar(20)	NULL		DEFAULT 'MRP',
	PlanTESeguridad			bit		NULL		DEFAULT 0,
	PlanIgnorarZonaCongelada	bit		NULL		DEFAULT 0,
	ComisionAnticipos		varchar(20)	NULL		DEFAULT 'Aplicacion',
	VentaDescuentoImporte		bit		NULL		DEFAULT 0,
	CompraDescuentoImporte		bit		NULL		DEFAULT 0,
	PlanLiberarCompra		varchar(30)	NULL		DEFAULT 'Orden por Proveedor',	
	PlanLiberarProduccion		varchar(30)	NULL		DEFAULT 'Orden por Seleccion',
	PlanLiberarDistribucion		varchar(30)	NULL		DEFAULT 'Orden por Almacen',
	VentaBonificacionAuto		bit		NULL		DEFAULT 0,
	PlanInvSeguridadDias		int		NULL		DEFAULT 7,
	PlanInvSeguridadFactor		float		NULL		DEFAULT 1,
	CxpAplicacionPagos		bit		NULL		DEFAULT 0,
	VentaSolicitarPrecios		bit		NULL		DEFAULT 0,
	CxcDegloseDef			bit		NULL		DEFAULT 0,
	CxpAfectarPagosAutomaticos	bit		NULL		DEFAULT 0,
	GastoValidarPresupuesto		bit		NULL		DEFAULT 0,
	GastoValidarPresupuestoCC	bit		NULL		DEFAULT 0,
	GastoValidarPresupuestoFR	bit		NULL		DEFAULT 0,
	ProvPresupuesto			varchar(10)	NULL		DEFAULT 'PRESUP',
	CxcDiasMorosidad		int		NULL		DEFAULT 60,
	CxpDiasMorosidad		int		NULL		DEFAULT 60,
	ProdTransferenciaConcentrada	bit		NULL		DEFAULT 1,
	GastoActividad			bit		NULL		DEFAULT 0,
	GastoProyectoDetalle		bit		NULL		DEFAULT 0,
	CxcCobroImpuestos		bit		NULL		DEFAULT 0,
	CompraSugerirUltimoCostoProv	bit		NULL		DEFAULT 0,
	ProdPeriodosCorrida		int		NULL 		DEFAULT 10,
	PlanCalcATP			bit		NULL		DEFAULT 1,
	PlanAbortarPrimerError		bit		NULL		DEFAULT 1,

	FiscalVerIVA			bit		NULL		DEFAULT 0,
	FiscalVerIEPS			bit		NULL		DEFAULT 0,
	FiscalVentaImpuesto3		varchar(255)	NULL		DEFAULT '0',
	FiscalCompraImpuesto3		varchar(255)	NULL		DEFAULT '0',
	FiscalInicioIVA			datetime	NULL,

	ProdAfectarConsumoParcial	bit		NULL		DEFAULT 1,
	PlanEstadoOmision		varchar(20)	NULL		DEFAULT 'Plan',	
	PlanCorridaOrden		varchar(50)	NULL		DEFAULT 'Articulo',
	VentaLimiteNivelSucursal	bit		NULL		DEFAULT 0,
	InvRegistrarPrecios		bit		NULL		DEFAULT 0,
	CxcAutoAplicarAnticiposPedidos	bit		NULL		DEFAULT 0,
	PlanUnidadDistribucion		varchar(20)	NULL		DEFAULT 'Compra/Produccion',
	MargenNivelListaPrecios		bit		NULL		DEFAULT 0,
	FacturarSustitutos		bit		NULL		DEFAULT 0,
	FacturarSustitutosOpciones	bit		NULL		DEFAULT 0,
	FacturarSustitutosPrecios	bit		NULL		DEFAULT 0,

	GastoUENDetalle			bit		NULL		DEFAULT 0,
	VentaUENDetalle			bit		NULL		DEFAULT 0,
	PlanTipoPeriodo			varchar(20)	NULL		DEFAULT 'Semana',
	AutoAutorizacionFacturas	bit		NULL		DEFAULT 0,
	VentaEspacioDetalle		bit		NULL		DEFAULT 1,
	CompraCostosImpuestoIncluido	bit		NULL 		DEFAULT 0,
	CompraRetenciones		bit		NULL		DEFAULT 0,
	ComisionesCobranza		bit		NULL		DEFAULT 0,
	VentaRenCompletosFactRapida	bit		NULL		DEFAULT 0,
	BloquearOpcionesArtConMovs	bit		NULL		DEFAULT 0,
	CxcVerRetencion			bit 		NULL 		DEFAULT 0,
    CxcVerRetencion2		bit			NULL		DEFAULT 0, --MEJORA4648
    CxcVerRetencion3		bit			NULL		DEFAULT 0, --MEJORA4648        	
	DecimalesCantidadPendiente	int		NULL		DEFAULT 2,
	GastoClaseRequerida		bit		NOT NULL	DEFAULT 0,
	GastoAFDetalle			bit		NULL		DEFAULT 0,

	AutoOperadorMaxDescuento	float		NULL		DEFAULT 30,	
	AutoArtComision			varchar(20)	NULL		DEFAULT 'COMISION',
	AutoArtPension			varchar(20)	NULL,
	AutoMovPension			varchar(20)	NULL,
	AutoArtMantExterno		varchar(20)	NULL,
	AutoArtBA			varchar(20)	NULL		DEFAULT 'BA',
	AutoArtBT			varchar(20)	NULL		DEFAULT 'BT',
	AutoArtBX			varchar(20)	NULL		DEFAULT 'BX',
	AutoMultiplesPapeletas		bit		NULL		DEFAULT 0,
	AutoAlmacenBX			varchar(10)	NULL		DEFAULT 'BX',
	AutoOperadorComision		float		NULL,
	AutoKmsMaximos			int		NULL,
	AutoCANAPAT			bit		NULL		DEFAULT 0,

	GastoAyudaConceptos		varchar(20)	NULL		DEFAULT 'Clasificacion',
	CompraSugerirArtR		bit		NULL		DEFAULT 0,
	CompraSugerirUnidadDemanda	bit		NULL		DEFAULT 0,
	
	PCParcial			bit		NULL		DEFAULT 0,
	PCBaja				bit		NULL		DEFAULT 0,
	PCRecalcPrecioFinVigencia	bit		NULL		DEFAULT 0,

	PlanIgnorarDemandaDirecta	bit		NULL		DEFAULT 0,
	VentaSubMovimientos		bit		NULL		DEFAULT 0,
	VentaAnexarMov			bit		NULL		DEFAULT 0,
	VentaAnexarOrdenes		bit		NULL		DEFAULT 0,
	VentaVerImpuesto1		bit		NULL		DEFAULT 0,
	VentaVerImpuesto2		bit		NULL		DEFAULT 0,
	VentaVerImpuesto3		bit		NULL		DEFAULT 0,
	VentaPresupuestosPendientes	bit		NULL		DEFAULT 0,
	CxcSugerirProntoPago		bit		NULL		DEFAULT 0,
	ProdVerPersonal			bit		NULL		DEFAULT 0,
	ProdVerTurno			bit		NULL		DEFAULT 0,
	ProdVerTiempo			bit		NULL		DEFAULT 1,
	ProdVerTiempoMuerto		bit		NULL		DEFAULT 0,
	ProdVerManoObra			bit		NULL		DEFAULT 1,
	ProdVerMaquila			bit		NULL		DEFAULT 1,
	ProdVerIndirectos		bit		NULL		DEFAULT 1,
	CxcEnviarABeneficiario		bit		NULL		DEFAULT 0,
	GastoDiversoReferenciaCxp	bit		NULL		DEFAULT 0,
	GastoBorradorComprobantes	bit		NULL		DEFAULT 0,
	GastoBorradorCajaChica		bit		NULL		DEFAULT 0,
	GastoGenerarAnticiposBorrador	bit		NULL		DEFAULT 0,
	AgentAfectarGastos		bit		NULL		DEFAULT 1,
	AgentConceptoGastos		varchar(50)	NULL,	
	AgentImpRetencionConcepto	bit		NULL		DEFAULT 0,	
	VentaAFDetalle			bit		NULL		DEFAULT 0,
	VentaRestringida		bit		NULL		DEFAULT 0,
	VentaExcluirPlaneacionDetalle	bit		NULL		DEFAULT 0,
	ProdVolumen			bit		NULL		DEFAULT 0,
	PlanAutoGuardarHist		bit		NULL		DEFAULT 0,
	CompraCaducidad			bit		NULL		DEFAULT 0,
	BloquearCantidadInventario	bit		NULL		DEFAULT 0,
	VentaValidarFechaRequerida	bit		NULL		DEFAULT 0,
	CompraValidarFechaRequerida	bit		NULL		DEFAULT 0,
	VentaDevAutoAplicar		bit		NULL		DEFAULT 0,
	CompraDevAutoAplicar		bit		NULL		DEFAULT 0,
	InvFrecuenciaABCDiasHabiles	bit		NULL		DEFAULT 0,
	GastoCxc			bit		NULL		DEFAULT 0,
	PlanBasePresupuesto		bit		NULL		DEFAULT 0,
	VentaEnviarADetalle		bit		NULL		DEFAULT 0,
	VentaMonedero			bit		NULL		DEFAULT 0,
	VentaPuntosEnVales		bit		NULL		DEFAULT 0,
	VentaPuntosArtCat		bit		NULL		DEFAULT 0,
        AlmacenOrigenOT                 varchar(30)     NULL            DEFAULT 'Ruta Distribucion',
        GastoDiversoSinProrratear       varchar(20)     NULL            DEFAULT 'Gastos',
	FacturaCobroIntegradoParcial	bit		NULL	        DEFAULT 0,
	CxcRecorrerVenceRevisionPago	bit		NULL	        DEFAULT 0,
	PlanRecorrerLiberacion		bit		NULL	        DEFAULT 0,

	PeruRetenciones			bit		NULL		DEFAULT 0,
	PeruRetencionesTopeExcento	money		NULL,
	CompraDescuentoCascadaDetalle	bit		NULL		DEFAULT 0,
	ArtDescuentoCompraCascada	bit		NULL		DEFAULT 0,
	InvAjusteCargoAgente		varchar(20)	NULL		DEFAULT 'No',	-- No/Costo/Precio
	GastoConceptoCxp		bit		NULL		DEFAULT 0,
	InvVerDescripcionExtra		bit		NULL 		DEFAULT 0,
	GastoPersonal			bit		NULL 		DEFAULT 0,
	GastoProvisionTolerancia	float		NULL		DEFAULT 10,
	InvAjusteSaldosMenores		float		NULL		DEFAULT 0.01,
	CompraGastoDiversoCxc		bit		NULL 		DEFAULT 0,
	GastoAnticipoCxp		bit		NULL 		DEFAULT 0,
	PlanInicio			varchar(20) 	NULL 		DEFAULT 'Hoy',
	CBSugerir			varchar(20)	NULL		DEFAULT 'No',	-- No/Codigo Consecutivo/Codigo Compuesto
	CxcDocAutoBorrador		bit		NULL 		DEFAULT 0,
	CxpDocAutoBorrador		bit		NULL 		DEFAULT 0,
	PlanNivelArtAutoRecalc		bit		NULL 		DEFAULT 0,
	PlanPlanearServicios		bit		NULL		DEFAULT 1,
	CompraPresupuestosPendientes	bit		NULL		DEFAULT 0,

	ConcToleranciaDec		int		NULL		DEFAULT 2,
	ConcGastosAuto			bit		NULL		DEFAULT 0,
	ConcGastosAutoConceptoFijo	varchar(50)	NULL,
	ConcRepetirFecha		bit		NULL		DEFAULT 0,
	ConcTraslaparFecha		bit		NULL		DEFAULT 0,
	ConcDiasCargos			int		NULL,
	ConcDiasAbonos			int		NULL,
	PCListaModificarDetalle		bit		NULL		DEFAULT 0,
	PCPrecioNuevoForma		varchar(20)	NULL		DEFAULT 'Metodos', 	-- Metodos / Asistente
	PCSugerir			bit		NULL		DEFAULT 0,
	ArtProvSucursalCompra		bit		NULL		DEFAULT 0,

	OfertaFechaHora			varchar(20)	NULL		DEFAULT 'Fecha Servidor',
	OfertaModificarTipo		bit		NULL		DEFAULT 0,
--	GastoRiesgo			bit		NULL		DEFAULT 0,
--	GastoRecurso			bit		NULL		DEFAULT 0,
	VentaVerCosto			bit		NULL		DEFAULT 0,
	PC_H1				bit		NULL		DEFAULT 0,
	PC_H2				bit		NULL		DEFAULT 0,
	VentaArtEstatus			bit		NULL		DEFAULT 0,
	VentaArtSituacion		bit		NULL		DEFAULT 0,
	GastoClienteRef			bit		NULL		DEFAULT 0,
	GastoArticuloRef		bit		NULL		DEFAULT 0,
	ConcNoSugerirImportesDup	bit		NULL		DEFAULT 0,
	ConcSugerirDespuesPeriodo	bit		NULL		DEFAULT 0,
	GastoSugerirCostoEstandar	bit		NULL		DEFAULT 0,
	CxpPagarEnLoteEvaluacion	varchar(50)	NULL,
	VentaEspacioCantidadMetros	bit		NULL		DEFAULT 0,
	GastoConceptosInventariables	bit		NULL		DEFAULT 0,
	GastoAlmacen			varchar(10)	NULL,
	GastoInvCopiarMov		bit		NULL		DEFAULT 0,
	CxpPagoTasa			bit		NULL		DEFAULT 0,
	GastoPresupuestoPendiente	bit		NULL		DEFAULT 0,

	FiscalOmitirDepositoAntCxc	bit		NULL		DEFAULT 0,
	FiscalOmitirChAntCxp		bit		NULL		DEFAULT 0,
	FiscalOmitirCobrosChDevCxc	bit		NULL		DEFAULT 0,
	FiscalOmitirPagosChDevCxp	bit		NULL		DEFAULT 0,
	FiscalOmitirPagosEndosoCxp	bit		NULL		DEFAULT 0,
	FiscalRegAplicaAnticipoCxc	bit		NULL		DEFAULT 0,
	FiscalRegAplicaFacturaCxc	bit		NULL		DEFAULT 0,
	FiscalRegAplicaAnticipoCxp	bit		NULL		DEFAULT 0,
	FiscalRegAplicaFacturaCxp	bit		NULL		DEFAULT 0,
	ConcImportesLejanos		bit		NULL		DEFAULT 1,
	GastoRecurso			bit		NULL 		DEFAULT 0,
	CxcGenerarEnBorrador		bit		NULL		DEFAULT 0,
	CxpGenerarEnBorrador		bit		NULL		DEFAULT	0,
	CompraMultiEmpresas		bit		NULL		DEFAULT	0,
	CompraPresupuestosCategoria	bit		NULL		DEFAULT 0,
	CompraABC			bit		NULL		DEFAULT 0,
	GastoABC			bit		NULL		DEFAULT 0,
	VentaABC			bit		NULL		DEFAULT 0,
	ConcPolizaGenerar		bit		NULL		DEFAULT 0,
	CompraAutoCancelaCotizacion	bit		NULL		DEFAULT 0,
	VentaCteArtEmpaqueCorrugado	bit		NULL		DEFAULT 0,
	VentaVerPesoVolumen             bit		NULL	DEFAULT 0,
	OfertaNivelOpcion				bit		NULL	DEFAULT 0,

	MAFInspeccionUsuario		varchar(10)	NULL,
	MAFServicioTaller		varchar(10)	NULL,
	MAFServicioUsuario		varchar(10)	NULL,
	MAFServicioMov			varchar(20)	NULL,
	MAFServicioConcepto		varchar(50)	NULL,
	MAFServicioCliente		varchar(10)	NULL,
	InvCostearTransferencias	bit		NULL		DEFAULT 1,
	CompraVerImpuesto1		bit		NULL		DEFAULT 0,
	CompraVerImpuesto2		bit		NULL		DEFAULT 0,
	CompraVerImpuesto3		bit		NULL		DEFAULT 0,
	CompraVerImpuesto4		bit		NULL		DEFAULT 0,
	CompraVerImpuesto5		bit		NULL		DEFAULT 0,
	CompraVerRetencion1		bit		NULL		DEFAULT 0,
	CompraVerRetencion2		bit		NULL		DEFAULT 0,
	CompraVerRetencion3		bit		NULL		DEFAULT 0,
	GastoVerImpuesto1		bit		NULL		DEFAULT 0,
	GastoVerImpuesto2		bit		NULL		DEFAULT 0,
	GastoVerImpuesto3		bit		NULL		DEFAULT 0,
	GastoVerImpuesto4		bit		NULL		DEFAULT 0,
	GastoVerImpuesto5		bit		NULL		DEFAULT 0,
	GastoVerRetencion1		bit		NULL		DEFAULT 0,
	GastoVerRetencion2		bit		NULL		DEFAULT 0,
	GastoVerRetencion3		bit		NULL		DEFAULT 0,
	GastoImporteConImpuesto		bit		NULL		DEFAULT 0,
	ProdSerieLoteDesdeOrden		bit		NULL		DEFAULT 0,
	FiscalGenerarRetenciones	bit		NULL		DEFAULT 0,
	ProdSerieloteIndicarArrastre	bit		NULL		DEFAULT 0,
	ProdValidarSLEntradaProduccion  bit		NULL		DEFAULT 0,
	GASCIMovEntrada			varchar(20)	NULL,
	GASCIMovSalida			varchar(20)	NULL,		
        VentaVerRetencion1		bit		NULL		DEFAULT 0, --MEJORA4648
        VentaVerRetencion2		bit		NULL		DEFAULT 0, --MEJORA4648	
        VentaVerRetencion3		bit		NULL		DEFAULT 0, --MEJORA4648	            
        BloquearFacturaOtraSucursal	bit		NULL		DEFAULT 0,
        GasConceptoMultiple  		bit		NULL		DEFAULT 0,
        
    
	InvValuacionOtraMoneda			varchar(10) NULL, --MEJORA6230
    
	CxcAnticipoTipoServicio			bit NULL DEFAULT 0,
	CxcAnticipoArticuloServicio		varchar(20) NULL,
    
	CONSTRAINT priEmpresaCfg2 PRIMARY KEY  CLUSTERED (Empresa)
)
GO
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfg2' and campo = 'GastoRetencionAcreedor')
  ALTER TABLE EmpresaCfg2 ADD GastoRetencionAcreedor char(10) NULL
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfg2' and campo = 'GastoRetencionConcepto')
  ALTER TABLE EmpresaCfg2 ADD GastoRetencionConcepto varchar(50) NULL
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfg2' and campo = 'GastoRetencion2Acreedor')
  ALTER TABLE EmpresaCfg2 ADD GastoRetencion2Acreedor char(10) NULL
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfg2' and campo = 'GastoRetencion2Concepto')
  ALTER TABLE EmpresaCfg2 ADD GastoRetencion2Concepto varchar(50) NULL
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfg2' and campo = 'ProdAfectarConsumo')
  ALTER TABLE EmpresaCfg2 ADD ProdAfectarConsumo bit NULL DEFAULT 1 WITH VALUES
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanAfectarOrdenesDistribucion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdProgramar', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdDiasFestivos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaArtAlmacenEspecifico', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'RutaDistribucion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'RutaDistribucionNivelArticulo', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CodigoCliente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcDescuentoRecargos','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpDescuentoRecargos','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraMultiAlmacen', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanNivelAlmacen', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraAutoCargos', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoAutoCargos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanSinDemanda', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdTipoMerma', 'varchar(1) NULL DEFAULT "%" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanMetodo', 'varchar(20) NULL DEFAULT "MRP" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanTESeguridad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ComisionAnticipos', 'varchar(20) NULL DEFAULT "Aplicacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDescuentoImporte', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraDescuentoImporte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdAutoCB', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanLiberarCompra', 'varchar(30) NULL DEFAULT "Orden por Proveedor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanLiberarProduccion', 'varchar(30)	NULL DEFAULT "Orden por Seleccion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanLiberarDistribucion', 'varchar(30) NULL DEFAULT "Orden por Almacen" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaBonificacionAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanInvSeguridadDias', 'int NULL DEFAULT 7 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanInvSeguridadFactor', 'float NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpAplicacionPagos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaSolicitarPrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcDegloseDef', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpAfectarPagosAutomaticos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoValidarPresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoValidarPresupuestoFR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProvPresupuesto', 'varchar(10) NULL DEFAULT "PRESUP" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcDiasMorosidad', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpDiasMorosidad', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdTransferenciaConcentrada', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoActividad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoProyectoDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcCobroImpuestos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraSugerirUltimoCostoProv', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdPeriodosCorrida', 'int NULL DEFAULT 10 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalVerIVA', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalVentaImpuesto3', 'varchar(255)	NULL DEFAULT "0" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalCompraImpuesto3', 'varchar(255) NULL DEFAULT "0" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanCalcATP', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanAbortarPrimerError', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdAfectarConsumoParcial', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanEstadoOmision', 'varchar(20) NULL DEFAULT "Plan" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanCorridaOrden', 'varchar(50) NULL	DEFAULT "Articulo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalInicioIVA', 'datetime NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcComisionCreditos', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaLimiteNivelSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'InvRegistrarPrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcAutoAplicarAnticiposPedidos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanUnidadDistribucion', 'varchar(20) NULL DEFAULT "Compra/Produccion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MargenNivelListaPrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanISDemanda', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FacturarSustitutos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoUENDetalle', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaUENDetalle', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanTipoPeriodo', 'varchar(20) NULL DEFAULT "Semana" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoAutorizacionFacturas', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaEspacioDetalle', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDHoraRequerida', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraCostosImpuestoIncluido', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraRetenciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ComisionesCobranza', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaRenCompletosFactRapida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'BloquearOpcionesArtConMovs', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcVerRetencion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'DecimalesCantidadPendiente', 'int NULL DEFAULT 2 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDMultiAgente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoClaseRequerida', 'bit NOT NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoAFDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoOperadorMaxDescuento', 'float NULL DEFAULT 30 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtComision', 'varchar(20) NULL DEFAULT "COMISION" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtMantExterno', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtBA', 'varchar(20) NULL DEFAULT "BA" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtBT', 'varchar(20) NULL DEFAULT "BT" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtBX', 'varchar(20) NULL DEFAULT "BX" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraSugerirArtR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoAyudaConceptos', 'varchar(20) NULL DEFAULT "Clasificacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDevSeriesSinAntecedente', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraSugerirUnidadDemanda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoAjustarArtUnidadFactor', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FacturarSustitutosOpciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCParcial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCBaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanIgnorarDemandaDirecta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoMultiplesPapeletas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanIgnorarZonaCongelada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaSubMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaAnexarMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaVerImpuesto1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaVerImpuesto2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaVerImpuesto3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoAlmacenBX', 'varchar(10)	NULL DEFAULT "BX" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaPresupuestosPendientes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoValidarPresupuestoCC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcSugerirProntoPago', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if exists(select * from syscampo where tabla = 'EmpresaCfg2' AND Campo = 'EspaciosSobreventa')
  ALTER TABLE EmpresaCfg2 DROP COLUMN EspaciosSobreventa
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerTiempo', 'bit	NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerManoObra', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerMaquila', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerIndirectos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoOperadorComision', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoKmsMaximos', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcEnviarABeneficiario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'RetencionAlPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerTurno', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVerTiempoMuerto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoDiversoReferenciaCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCRecalcPrecioFinVigencia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoBorradorComprobantes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AgentAfectarGastos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AgentConceptoGastos', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaAFDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaRestringida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaExcluirPlaneacionDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdVolumen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanAutoGuardarHist', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoBorradorCajaChica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraCaducidad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PrecioNivelUnidad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoCANAPAT', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoGenerarAnticiposBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalVerIEPS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoArtPension', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AutoMovPension', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'BloquearCantidadInventario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaValidarFechaRequerida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraValidarFechaRequerida', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraRecibirDemasTolerancia', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDevAutoAplicar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraDevAutoAplicar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaAnexarOrdenes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'InvFrecuenciaABCDiasHabiles', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoCxc', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanBasePresupuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaEnviarADetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VINAccesorioArt', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VINCostoSumaAccesorios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AlmacenOrigenOT', 'varchar(30) NULL DEFAULT "Ruta Distribucion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoDiversoSinProrratear', 'varchar(20) NULL DEFAULT "Cuentas por Pagar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FacturaCobroIntegradoParcial','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcRecorrerVenceRevisionPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FacturarSustitutosPrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanRecorrerLiberacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoRetencion3Acreedor', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoRetencion3Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'Gasto3Retenciones', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PeruRetenciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PeruRetencionesTopeExcento', 'money NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraDescuentoCascadaDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ArtDescuentoCompraCascada', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'InvAjusteCargoAgente', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoConceptoCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'InvVerDescripcionExtra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoProvisionTolerancia', 'float NULL DEFAULT 10 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'InvAjusteSaldosMenores', 'float NULL DEFAULT 0.01 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraGastoDiversoCxc', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaDMultiAgenteSugerir', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoAnticipoCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AgentImpRetencionConcepto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanInicio', 'varchar(20) NULL DEFAULT "Hoy" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CBSugerir', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcDocAutoBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpDocAutoBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PlanNivelArtAutoRecalc', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraPresupuestosPendientes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcToleranciaDec','int NULL DEFAULT 2 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcGastosAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcGastosAutoConceptoFijo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcRepetirFecha', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaMonedero', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spRENAME_COLUMN 'EmpresaCfg2', 'VentaTarjetaPuntos', 'VentaPuntosArtCat'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaPuntosArtCat', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCListaModificarDetalle', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCPrecioNuevoForma', 'varchar(20) NULL DEFAULT "Metodos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PCSugerir', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ArtProvSucursalCompra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'OfertaFechaHora', 'varchar(20) NULL DEFAULT "Fecha Servidor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaPuntosEnVales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'RetencionAlPagoMovImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'OfertaModificarTipo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcDiasCargos', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcDiasAbonos', 'int NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaVerCosto', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PC_H1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PC_H2', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaArtEstatus', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaArtSituacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoClienteRef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoArticuloRef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalSugerirCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spDROP_COLUMN 'EmpresaCfg2', 'ConcSugerirPorImporte'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcNoSugerirImportesDup', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcSugerirDespuesPeriodo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoSugerirCostoEstandar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpPagarEnLoteEvaluacion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaEspacioCantidadMetros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spDROP_COLUMN 'EmpresaCfg2', 'FiscalSugerirImpuestosPorCobrar'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoConceptosInventariables', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoAlmacen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoInvCopiarMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpPagoTasa', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoPresupuestoPendiente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalOmitirDepositoAntCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalOmitirChAntCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalOmitirCobrosChDevCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalOmitirPagosChDevCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalOmitirPagosEndosoCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalRegAplicaAnticipoCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalRegAplicaFacturaCxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalRegAplicaAnticipoCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalRegAplicaFacturaCxp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcImportesLejanos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcTraslaparFecha', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoRecurso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFInspeccionUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFServicioTaller', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFServicioUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFServicioMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFServicioConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'MAFServicioCliente', 'varchar(10) NULL'
GO

EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdSerieloteIndicarArrastre ', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdValidarSLEntradaProduccion ', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'CXPReferenciaEnAnticiposCP', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'GasConceptoMultiple', 'bit NULL DEFAULT 0 WITH VALUES' 
EXEC spAlter_Table 'EmpresaCFG2', 'CxcAnticipoTipoServicio','bit NULL DEFAULT 0'
EXEC spAlter_Table 'EmpresaCFG2', 'CxcAnticipoArticuloServicio','varchar(20) NULL'
Go
if (select version from version)<=3192
BEGIN
  EXEC("spEliminarPK 'EmpresaCfg2'")	
  EXEC("spALTER_COLUMN 'EmpresaCfg2' ,'Empresa', 'varchar(5) NOT NULL'")  
  EXEC("ALTER TABLE EmpresaCfg2 ADD CONSTRAINT priEmpresaCfg2 PRIMARY KEY CLUSTERED (Empresa)")
END
GO

EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdAlmacenMP' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdAlmacenProcesoDef' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdTipoOpcionDef' ,'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'NivelFactorMultiUnidad' ,'varchar(20) NULL' ,'"Unidad"'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdAutoLote' ,'varchar(20)	NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdAutoCB' ,'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'GastoRetencionAcreedor' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'GastoRetencion2Acreedor' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'GastoRetencion3Acreedor' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProdTipoMerma' ,'varchar(1)	NULL' ,'"%"'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'PlanMetodo' ,'varchar(20) NULL' ,'"MRP"'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ComisionAnticipos' ,'varchar(20) NULL' ,'"Aplicacion"'
EXEC spALTER_COLUMN 'EmpresaCfg2' ,'ProvPresupuesto' ,'varchar(10) NULL' ,'"PRESUP"'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxcGenerarEnBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CxpGenerarEnBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraMultiEmpresas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraPresupuestosCategoria', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraABC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoABC', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaABC', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ConcPolizaGenerar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2' ,'CompraAutoCancelaCotizacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2' ,'PlanPlanearServicios', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaCteArtEmpaqueCorrugado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaVerPesoVolumen', 'bit NULL Default 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2' ,'OfertaNivelOpcion', 'bit NULL Default 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2' ,'InvCostearTransferencias', 'bit NULL	DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerImpuesto1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerImpuesto2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerImpuesto3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerImpuesto4', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerImpuesto5', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerRetencion1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerRetencion2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CompraVerRetencion3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerImpuesto1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerImpuesto2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerImpuesto3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerImpuesto4', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerImpuesto5', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerRetencion1', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerRetencion2', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoVerRetencion3', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GastoImporteConImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'ProdSerieLoteDesdeOrden', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'FiscalGenerarRetenciones','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'EmbarqueSumaArtJuego', 'varchar(20) NOT NULL', '"Articulo Juego"'
EXEC spAlter_Table 'EmpresaCfg2', 'GASCIMovEntrada',' varchar(20)  NULL'
EXEC spAlter_Table 'EmpresaCfg2', 'GASCIMovSalida',' varchar(20)  NULL'
GO
EXEC spAlter_Table 'EmpresaCfg2', 'VentaVerRetencion1', 'bit NULL DEFAULT 0' --MEJORA4648
EXEC spAlter_Table 'EmpresaCfg2', 'VentaVerRetencion2', 'bit NULL DEFAULT 0' --MEJORA4648
EXEC spAlter_Table 'EmpresaCfg2', 'VentaVerRetencion3', 'bit NULL DEFAULT 0' --MEJORA4648
EXEC spAlter_Table 'EmpresaCfg2', 'CxcVerRetencion2', 'bit NULL DEFAULT 0' --MEJORA4648
EXEC spAlter_Table 'EmpresaCfg2', 'CxcVerRetencion3', 'bit NULL DEFAULT 0' --MEJORA4648
GO		
EXEC spALTER_TABLE 'EmpresaCfg2', 'BloquearFacturaOtraSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spAlter_Table 'EmpresaCfg2', 'InvValuacionOtraMoneda',' varchar(10)  NULL' --MEJORA6230
GO

--BUG15194
EXEC SPALTER_TABLE 'EmpresaCfg2', 'GASRetencion3Independiente',' bit NULL DEFAULT 0 WITH VALUES'
-- 9319
EXEC spALTER_TABLE 'EmpresaCfg2', 'VTASValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'COMSValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'INVValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CXCValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CXPValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'DINValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'GASValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'PRODValidarFechaAplicacion', 'varchar(10) NULL DEFAULT ''No'' WITH VALUES'
GO

--REQ16092
EXEC spALTER_TABLE 'EmpresaCfg2', 'OPORTTareaEstado', 'varchar(30) NULL DEFAULT ''No comenzada'' WITH VALUES'
GO

--BUG16710
EXEC spALTER_TABLE 'EmpresaCfg2', 'CXCDTotalizarRedondeo', 'bit NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CXPDTotalizarRedondeo', 'bit NOT NULL DEFAULT 1 WITH VALUES'
GO

--REQ25014
EXEC spALTER_TABLE 'EmpresaCfg2', 'CONTPConcluirPaquete', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CONTPMaximoDiasPaquete', 'int NOT NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CONTPConcluirPolizas', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfg2', 'CONTPMovPoliza', 'varchar(20) NOT NULL DEFAULT ''Diario'' WITH VALUES'
EXEC spDROP_COLUMN 'EmpresaCfg2', 'CONTPMovPoliza'

--REQ25300
EXEC spALTER_TABLE 'EmpresaCfg2', 'CONTPEnLinea', 'bit NOT NULL DEFAULT 0 WITH VALUES'

--REQ26368
EXEC spALTER_TABLE 'EmpresaCfg2', 'OfertaAplicaLog', 'bit NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'OfertaAplicaLogPOS', 'bit NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'OfertaPorPartidaPOS', 'bit NULL'
GO
EXEC spALTER_TABLE 'EmpresaCfg2', 'MontoMinMoratorioMAVI', 'float NULL'
EXEC spALTER_TABLE 'EmpresaCfg2', 'AgruparConceptoSATRetenciones', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'EmpresaCfg2', 'VentaMonederoA', 'bit NULL DEFAULT 0'
GO

/****** Configuracion NomAuto de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgNomAuto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgNomAuto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgNomAuto') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgNomAuto (
	Empresa 			char(5)  	NOT NULL,

	AjusteMensualISR		bit		NULL	DEFAULT 1,
	TopeHorasExtrasSemanal		bit		NULL	DEFAULT 1,
	Cxc				varchar(20)	NULL	DEFAULT 'No',	-- No/Parciales/Completas
	SueldoMinimo			varchar(20)	NULL	DEFAULT 'No',	-- No/Oficial
	SubsidioIncapacidadEG		bit		NULL	DEFAULT 0,
	PrimaDominicalAuto		bit		NULL	DEFAULT 0,
	ISRLiquidacionSueldoMensual	varchar(50)	NULL	DEFAULT 'Sueldo Mensual',	-- Sueldo Mensual/Acumulado Mensual Anterior
	ISRReglamentoAguinaldo		bit		NULL	DEFAULT 0,
	ISRReglamentoPTU		bit		NULL	DEFAULT 0,
	FactorIntegracionAntiguedad	varchar(20)	NULL	DEFAULT 'Siguiente',		-- Actual/Siguiente/Tabla
	FactorIntegracionTabla		varchar(50)	NULL,
	FondoAhorroRepartirInteres	varchar(20)	NULL	DEFAULT 'PTU',			-- PTU/%
	CajaAhorroRepartirInteres	varchar(20)	NULL	DEFAULT 'PTU',			-- PTU/%

	CONSTRAINT priEmpresaCfgNomAuto PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'TopeHorasExtrasSemanal', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'Cxc', 'varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'SueldoMinimo','varchar(20) NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'SubsidioIncapacidadEG', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'PrimaDominicalAuto', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'ISRLiquidacionSueldoMensual', 'varchar(50) NULL DEFAULT "Sueldo Mensual" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'ISRReglamentoAguinaldo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'ISRReglamentoPTU', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'FactorIntegracionAntiguedad', 'varchar(20) NULL DEFAULT "Siguiente" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'FactorIntegracionTabla', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'FondoAhorroRepartirInteres', 'varchar(20) NULL	DEFAULT "PTU" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgNomAuto', 'CajaAhorroRepartirInteres', 'varchar(20) NULL	DEFAULT "PTU" WITH VALUES'
GO


/****** Configuracion Acumulado Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgNominaAcum')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgNominaAcum','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgNominaAcum') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgNominaAcum (
	Empresa 		char(5)  	NOT NULL,
	EmpresaAcum		char(5)  	NOT NULL,

	CONSTRAINT priEmpresaCfgNominaAcum PRIMARY KEY  CLUSTERED (Empresa, EmpresaAcum)
)
GO

/****** Configuracion PuntosEnVales de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPuntosEnVales')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPuntosEnVales','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPuntosEnVales') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPuntosEnVales (
	Empresa 		char(5)  	NOT NULL,

	ValesMov		varchar(20)	NULL,
	ValeTipo		varchar(50)	NULL,
	Duracion		varchar(20)	NULL,
	DuracionUnidad		varchar(20)	NULL,
	Consecutivo		varchar(20)	NULL,

	CONSTRAINT priEmpresaCfgPuntosEnVales PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** Configuracion PuntosEnVales de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPuntosEnValesMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPuntosEnValesMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPuntosEnValesMov') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPuntosEnValesMov (
	Empresa 		char(5)  	NOT NULL,

	Mov			varchar(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgPuntosEnValesMov PRIMARY KEY  CLUSTERED (Empresa, Mov)
)
GO


/****** Configuracion Gastos Indirectos de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgGastoIndirecto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgGastoIndirecto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgGastoIndirecto') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgGastoIndirecto (
	Empresa 			char(5)  	NOT NULL,
	Concepto			varchar(50)	NOT NULL,

	Porcentaje			float		NULL,

	CONSTRAINT priEmpresaCfgGastoIndirecto PRIMARY KEY  CLUSTERED (Empresa, Concepto)
)
GO
-- drop table EmpresaCfgMovAmortizacion 
/****** Configuracion Amortizacion ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovAmortizacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovAmortizacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovAmortizacion') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovAmortizacion (
	Empresa 			varchar(5)  	NOT NULL,
	Modulo				varchar(5)	NOT NULL,
	Mov				varchar(20)	NOT NULL,

	Amortizacion			varchar(20)	NULL,

	CONSTRAINT priEmpresaCfgMovAmortizacion PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

--REQ25014
/****** Configuracion Contabilidad Paralela ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovContParalela')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovContParalela','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovContParalela') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovContParalela(
	Empresa 				varchar(5)  NOT NULL,

	CPCentralizarCuentas	varchar(20)	NOT NULL DEFAULT 'Centralizar Cuentas',
	CPRecibirCuentas		varchar(20)	NOT NULL DEFAULT 'Recepcion Cuentas',
	CPGeneradorPaq			varchar(20)	NOT NULL DEFAULT 'Generador Paquetes',
	CPPaquete				varchar(20)	NOT NULL DEFAULT 'Paquete Contable',
	CPRecepcionPaq			varchar(20)	NOT NULL DEFAULT 'Recepcion Paquete',

	CPTransformacion		varchar(20) NOT NULL DEFAULT 'Transformacion',
	CPPoliza				varchar(20) NOT NULL DEFAULT 'Poliza',
	CPCierrePeriodo			varchar(20) NOT NULL DEFAULT 'Cierre Periodo',
	
	CONSTRAINT priEmpresaCfgMovContParalela PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPGeneradorPaq', 'varchar(20)	NOT NULL DEFAULT ''Generador Paquetes'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPPaquete', 'varchar(20)	NOT NULL DEFAULT ''Paquete Contable'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPRecepcionPaq', 'varchar(20)	NOT NULL DEFAULT ''Recepcion Paquete'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPTransformacion', 'varchar(20) NOT NULL DEFAULT ''Transformacion'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPPoliza', 'varchar(20) NOT NULL DEFAULT ''Poliza'' WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMovContParalela', 'CPCierrePeriodo', 'varchar(20) NOT NULL DEFAULT ''Cierre Periodo'' WITH VALUES'
GO

/****** EmpresaCfgMovRecluta ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovRecluta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovRecluta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovRecluta') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovRecluta (
	Empresa 			varchar(5)  	NOT NULL,

	REAutorizacionPlaza		varchar(20)	NULL		DEFAULT 'Autorizacion Plaza',
	REEntrevista			varchar(20)	NULL		DEFAULT 'Entrevista',
	REContratacion			varchar(20)	NULL		DEFAULT 'Contratacion',
	RERechazoRequisicion		varchar(20)	NULL		DEFAULT 'Rechazo Requisicion',
	RESolicitudEvaluacion		varchar(20)	NULL		DEFAULT 'Solicitud Evaluacion',
	REEvaluacion			varchar(20)	NULL		DEFAULT 'Evaluacion',

	CONSTRAINT priEmpresaCfgMovRecluta PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** EmpresaCfgMovCompra ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovCompra') --MEJORASLC
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovCompra','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovCompra') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovCompra (
	Empresa 			varchar(5)  	NOT NULL,

	COMSEntradaConsignacion		varchar(20)	NULL		DEFAULT 'Entrada Consignacion',
	EntradaMaquila   		varchar(20)	NULL		DEFAULT 'Entrada Maquila',

	CONSTRAINT priEmpresaCfgMovCompra PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgMovCompra', 'EntradaMaquila', 'varchar(20) NULL DEFAULT "Entrada Maquila" WITH VALUES'

/****** EmpresaCfgMovCxp ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovCxp') --MEJORASLC
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovCxp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovCxp') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovCxp (
	Empresa 			varchar(5)  	NOT NULL,

	CXPEntradaConsignacion		varchar(20)	NULL		DEFAULT 'Entrada Consignacion',
	CXPCorteConsignacion		varchar(20)	NULL		DEFAULT 'Corte Consignacion',	
	CXPChequeDevuelto			varchar(20) NULL		DEFAULT 'Cheque Devuelto', --MEJORA6013
	CXPInteresMoratorio			varchar(20) NULL		DEFAULT 'Interes Moratorio', --MEJORA10015
	CXPDescuentoInflacion		varchar(20) NULL		DEFAULT 'Descuento Inflacion' --MEJORA10041

	CONSTRAINT priEmpresaCfgMovCxp PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spAlter_Table 'EmpresaCfgMovCxp', 'CxpChequeDevuelto', 'varchar(20) NULL DEFAULT ''Cheque Devuelto'' WITH VALUES' --MEJORA6013
EXEC spAlter_Table 'EmpresaCfgMovCxp', 'CxpInteresMoratorio', 'varchar(20) NULL DEFAULT ''Interes Moratorio'' WITH VALUES' --MEJORA10015
EXEC spAlter_Table 'EmpresaCfgMovCxp', 'CxpDescuentoInflacion', 'varchar(20) NULL DEFAULT ''Descuento Inflacion'' WITH VALUES' --MEJORA10041
GO

/****** EmpresaCfgMovCxc ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovCxc') --MEJORA10041
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovCxc','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovCxc') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovCxc (
	Empresa 			varchar(5)  	NOT NULL,

	CXCDescuentoInflacion		varchar(20) NULL		DEFAULT 'Descuento Inflacion' --MEJORA10041

	CONSTRAINT priEmpresaCfgMovCxc PRIMARY KEY  CLUSTERED (Empresa)
)
GO


--Mejora 5669
/****** EmpresaCfgMovDinero******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovDinero') --MEJORASLC
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovDinero','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovDinero') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovDinero (
	Empresa 			varchar(5)  	NOT NULL,
	CajaAumento     		varchar(20)	NULL		DEFAULT 'Aumento Caja',	
	CajaCorteParc     		varchar(20)	NULL		DEFAULT 'Corte Parcial Caja',
	CONSTRAINT priEmpresaCfgMovDinero PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** EmpresaCfgMovGES ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovGES') --MEJORA5066
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovGES','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovGES') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovGES (
	Empresa 			varchar(5)  	NOT NULL,

	Notificacion		varchar(20)	NULL		DEFAULT 'Notificacion'

	CONSTRAINT priEmpresaCfgMovGES PRIMARY KEY  CLUSTERED (Empresa)
)
GO

-- select InvEntradaDiversa from empresacfgmov
/****** Configuracion de Movimientos de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMov') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMov (
	Empresa 			char(5)  	NOT NULL,

        InvAjuste			char(20)	NULL 		DEFAULT 'Ajuste',
        InvReevaluacion			char(20)	NULL 		DEFAULT 'Reevaluacion',
        InvReciboPrestamo		char(20)	NULL 		DEFAULT 'Recibo Prestamo',
        InvCambioPresentacion 		char(20)	NULL 		DEFAULT 'Cambio Presentacion',
        InvSalidaDiversa		char(20)	NULL 		DEFAULT 'Salida Diversa',
        InvPrestamo			char(20)	NULL 		DEFAULT 'Prestamo',
	InvOrdenTransferencia		char(20)	NULL 		DEFAULT 'Orden Transferencia',
        InvTransferencia		char(20)	NULL 		DEFAULT 'Transferencia',
        InvTransferenciaConsig		char(20)	NULL 		DEFAULT 'Transferencia Consig',
	InvOrdenTraspaso		char(20)	NULL 		DEFAULT 'Orden Traspaso',
	InvSalidaTraspaso		char(20)	NULL 		DEFAULT 'Salida Traspaso',
	InvDevTransito			char(20)	NULL 		DEFAULT 'Devolucion Transito',
	InvReciboTraspaso		char(20)	NULL 		DEFAULT 'Recibo Traspaso',
	InvTransito			char(20)	NULL 		DEFAULT 'Transito',
	InvTransitoFaltante		char(20)	NULL 		DEFAULT 'Transito Faltante',
	InvTransitoSobrante		char(20)	NULL 		DEFAULT 'Transito Sobrante',
	VentaNota			char(20)	NULL		DEFAULT 'Nota',
	VentaNotaResumen		char(20)	NULL		DEFAULT 'Nota Resumen',
        VentaCotizacion			char(20)	NULL 		DEFAULT 'Cotizacion',
        VentaPedido 			char(20)	NULL 		DEFAULT 'Pedido',
        VentaFactura 			char(20)	NULL 		DEFAULT 'Factura',
	VentaSalidaGarantia		char(20)	NULL 		DEFAULT 'Salida Garantia',
	VentaEntregaGarantia		char(20)	NULL 		DEFAULT 'Entrega Garantia',
	VentaDev			char(20)	NULL		DEFAULT 'Devolucion Venta',
        VentaDevCxc			char(20)	NULL		DEFAULT 'Nota Credito',
	VentaConsignacion		char(20)	NULL 		DEFAULT 'Venta Consignacion',
	VentaDevConsignacion		char(20)	NULL 		DEFAULT 'Dev. Venta Consig.',
        VentaFacturaNota		char(20)	NULL 		DEFAULT 'Factura',
        VentaRemision			char(20)	NULL 		DEFAULT 'Remision',
        VentaDevRemision		char(20)	NULL 		DEFAULT 'Devolucion Remision',
	VentaCancelacionFactura		char(20)	NULL 		DEFAULT 'Cancelacion Factura',
        VentaPerdida 			char(20)	NULL 		DEFAULT 'Venta Perdida',
	CompraRequisicion		char(20)	NULL 		DEFAULT 'Requisicion',
	CompraCotizacion		char(20)	NULL 		DEFAULT 'Cotizacion',
	CompraOrden			char(20)	NULL 		DEFAULT 'Orden Compra',
	CompraControlCalidad		char(20)	NULL 		DEFAULT 'Control Calidad',
	CompraEntrada			char(20)	NULL 		DEFAULT 'Entrada Compra',
	CompraLocal			char(20)	NULL 		DEFAULT 'Compra Local',
	CompraEntradaGastos		char(20)	NULL 		DEFAULT 'Entrada con Gastos',
	CompraDev			char(20)	NULL		DEFAULT 'Devolucion Compra',
        CompraDevCxp			char(20)	NULL		DEFAULT 'Nota Credito',
	CompraBonificacion		char(20)	NULL		DEFAULT 'Bonificacion Compra',
	CompraBonificacionCxp		char(20)	NULL		DEFAULT 'Nota Credito',
	CompraConsignacion		char(20)	NULL 		DEFAULT 'Compra Consignacion',
	CompraDevConsignacion		char(20)	NULL 		DEFAULT 'Dev. Compra Consig.',
	CompraIntercambio		char(20)	NULL		DEFAULT 'Intercambio Garantia',
	CompraDevGarantia		char(20)	NULL		DEFAULT 'Devolucion Garantia',
        CxcFactura 			char(20)	NULL 		DEFAULT 'Factura',
	CxcNCargo			char(20)	NULL 		DEFAULT 'Nota Cargo',
	CxcDocumento			char(20)	NULL 		DEFAULT 'Documento',
	CxcContraRecibo			char(20)	NULL 		DEFAULT 'Contra Recibo',
        CxcNCredito 			char(20)	NULL 		DEFAULT 'Nota Credito',
        CxcNCreditoVoucher		char(20)	NULL 		DEFAULT 'Nota Credito',
        CxcNCargoVoucher		char(20)	NULL 		DEFAULT 'Nota Cargo',
        CxcNCreditoProntoPago		char(20)	NULL 		DEFAULT 'Nota Credito',
        CxcAnticipo			char(20)	NULL 		DEFAULT 'Anticipo',
        CxcCobro 			char(20)	NULL 		DEFAULT 'Cobro',
        CxcCobroPosfechado		char(20)	NULL 		DEFAULT 'Cobro Posfechado',
	CxcCobroDirecto			char(20)	NULL		DEFAULT 'Deposito',
        CxcAplicacionNCredito		char(20)	NULL 		DEFAULT 'Aplicacion Credito',
        CxcAplicacionCobro		char(20)	NULL 		DEFAULT 'Aplicacion Cobro',
	CxcAplicacionAnticipo		char(20)	NULL		DEFAULT 'Aplicacion Anticipo',
	CxcAjusteEfectivo		char(20)	NULL		DEFAULT 'Ajuste Efectivo',
	CxcCargoDiverso			char(20)	NULL		DEFAULT 'Cargo Diverso',
	CxcCreditoDiverso		char(20)	NULL		DEFAULT 'Credito Diverso',
	CxcDevolucionEfectivo		char(20)	NULL		DEFAULT 'Devolucion Saldo',
	CxcDevolucionCredito		char(20)	NULL		DEFAULT 'Devolucion Credito',
	CxcDevolucionAnticipo		char(20)	NULL		DEFAULT 'Devolucion Anticipo',
	CxcReasignacionAnticipo		char(20)	NULL		DEFAULT 'Reasignacion',
	CxcCancelacionFactura		char(20)	NULL 		DEFAULT 'Cancelacion Factura',
	CxcVentaVales			char(20)	NULL 		DEFAULT 'Venta Vales',
	CxcAplicacionVales		char(20)	NULL 		DEFAULT 'Aplicacion Vales',
	CxcDevolucionVales		char(20)	NULL 		DEFAULT 'Devolucion Vales',
        CxpFactura 			char(20)	NULL 		DEFAULT 'Entrada Compra',
	CxpNCargo			char(20)	NULL 		DEFAULT 'Nota Cargo',
	CxpDocumento			char(20)	NULL 		DEFAULT 'Documento',
	CxpNomina			char(20)	NULL 		DEFAULT 'Pago Nomina',
	CxpCancelacionNomina		char(20)	NULL 		DEFAULT 'Cancelacion Nomina',
        CxpNCredito 			char(20)	NULL 		DEFAULT 'Nota Credito',
        CxpNCreditoProntoPago		char(20)	NULL 		DEFAULT 'Nota Credito',
	CxpCargoDiverso			char(20)	NULL		DEFAULT 'Cargo Diverso',
	CxpCreditoDiverso		char(20)	NULL		DEFAULT 'Credito Diverso',
        CxpAnticipo			char(20)	NULL 		DEFAULT 'Anticipo',
        CxpPago 			char(20)	NULL 		DEFAULT 'Pago',
        CxpPagoPosfechado		char(20)	NULL 		DEFAULT 'Pago Posfechado',
	CxpPagoDirecto			char(20)	NULL		DEFAULT 'Cheque',
        CxpAplicacionNCredito		char(20)	NULL 		DEFAULT 'Aplicacion Credito',
        CxpAplicacionPago		char(20)	NULL 		DEFAULT 'Aplicacion Pago',
	CxpAplicacionAnticipo		char(20)	NULL		DEFAULT 'Aplicacion Anticipo',
        CxpGastoDiverso			char(20)	NULL 		DEFAULT 'Gasto Diverso',
	CxpDevolucionEfectivo		char(20)	NULL		DEFAULT 'Devolucion Saldo',
	CxpDevolucionCredito		char(20)	NULL		DEFAULT 'Devolucion Credito',
	CxpDevolucionAnticipo		char(20)	NULL		DEFAULT 'Devolucion Anticipo',
	CxpAjusteEfectivo		char(20)	NULL		DEFAULT 'Ajuste Efectivo',
	CxpRetencion			char(20)	NULL		DEFAULT 'Retencion',
	CxpReasignacionAnticipo		char(20)	NULL		DEFAULT 'Reasignacion',
	CxcNomina			char(20)	NULL 		DEFAULT 'Cobro Nomina',
	CxcCancelacionNomina		char(20)	NULL 		DEFAULT 'Cancelacion Nomina',
	BancoIngreso			char(20)	NULL 		DEFAULT 'Ingreso',
	BancoEgreso			char(20)	NULL 		DEFAULT 'Egreso',
	BancoDeposito			char(20)	NULL 		DEFAULT 'Deposito',
	BancoDepositoElectronico	char(20)	NULL 		DEFAULT 'Deposito Electronico',
	BancoCheque			char(20)	NULL 		DEFAULT 'Cheque',
	BancoChequeTraspaso		char(20)	NULL 		DEFAULT 'Cheque',
	BancoChequeElectronico		char(20)	NULL 		DEFAULT 'Cheque Electronico',
	BancoDepositoEnFalso		char(20)	NULL 		DEFAULT 'Deposito en Falso',
	BancoChequeDevuelto		char(20)	NULL 		DEFAULT 'Cheque Devuelto',
	BancoCargoBancario		char(20)	NULL 		DEFAULT 'Cargo Bancario',
	BancoCargoBancarioIVA		char(20)	NULL 		DEFAULT 'Cargo Bancario IVA',
	BancoAbonoBancario		char(20)	NULL 		DEFAULT 'Abono Bancario',
	BancoAbonoBancarioIVA		char(20)	NULL 		DEFAULT 'Abono Bancario IVA',
	CajaIngreso			char(20)	NULL 		DEFAULT 'Ingreso',
	CajaEgreso			char(20)	NULL 		DEFAULT 'Egreso',
	CajaFaltanteCaja		char(20)	NULL		DEFAULT 'Faltante Caja',
	CajaSobranteCaja		char(20)	NULL		DEFAULT 'Sobrante Caja',
	CajaCorteCaja			char(20)	NULL		DEFAULT 'Corte Caja',
	CajaApertura			char(20)	NULL		DEFAULT 'Apertura Caja',
	CajaRecoleccion			char(20)	NULL		DEFAULT 'Recoleccion Caja',
        CajaFondoInicial		char(20)	NULL		DEFAULT 'Fondo Inicial Caja',
	CajaTransferencia		char(20)	NULL		DEFAULT 'Transferencia Caja',
	Gasto				char(20)	NULL 		DEFAULT 'Gasto',
	GastoTCredito			char(20)	NULL 		DEFAULT 'Gasto T/Credito',
	GastoComprobante		char(20)	NULL 		DEFAULT 'Comprobante',
	GastoDevComprobante		char(20)	NULL 		DEFAULT 'Dev. Comprobante',
	GastoSinComprobante		char(20)	NULL 		DEFAULT 'Sin Comprobante',
	GastoAnticipoSinComprobar	char(20)	NULL 		DEFAULT 'Anticipo s/Comprobar',
	GastoCajaChica			char(20)	NULL 		DEFAULT 'Caja Chica',
	GastoSolicitud			char(20)	NULL 		DEFAULT 'Solicitud',
	GastoAnticipo			char(20)	NULL 		DEFAULT 'Anticipo',
	GastoDevolucionAnticipo		char(20)	NULL 		DEFAULT 'Devolucion Anticipo',
	EmbarqueLiquidacion		char(20)	NULL		DEFAULT 'Liquidacion',
        EmbarqueDesembarque		char(20)	NULL		DEFAULT 'Desembarque',
	EmbarqueCxp			char(20)	NULL		DEFAULT 'Embarque',
	ContCierre			char(20)	NULL 		DEFAULT 'Cierre',
	ContDiario			char(20)	NULL 		DEFAULT 'Diario',
	ContEliminacion			char(20)	NULL 		DEFAULT 'Eliminacion',
	AsisteAsistencia		char(20)	NULL		DEFAULT	'Asistencia',
	AsisteCorte			char(20)	NULL		DEFAULT	'Corte',
	AgentComision			char(20)	NULL		DEFAULT	'Comision',
	AgentBono			char(20)	NULL		DEFAULT	'Bono',
	AgentDestajo			char(20)	NULL		DEFAULT	'Destajo',
	AgentDevolucion			char(20)	NULL		DEFAULT 'Devolucion',
	AgentBonificacion		char(20)	NULL		DEFAULT 'Bonificacion',
	AgentFaltanteCaja		char(20)	NULL		DEFAULT 'Faltante Caja',
	AgentAjusteInv			char(20)	NULL		DEFAULT 'Ajuste Inventario',
	AgentPago			char(20)	NULL		DEFAULT	'Pago',
	AgentPagoNomina			char(20)	NULL		DEFAULT 'Pago Nomina',
	AgentPagoGastos			char(20)	NULL		DEFAULT	'Comprobante',
	AgentCobro			char(20)	NULL		DEFAULT	'Cobro',
	ProdOrdenProduccion		char(20)	NULL		DEFAULT 'Orden Produccion',
	ProdRequisicion			char(20)	NULL		DEFAULT 'Requisicion',
	ProdOrdenTrabajo		char(20)	NULL		DEFAULT 'Orden Trabajo',
	ProdSolicitud			char(20)	NULL		DEFAULT 'Solicitud',
	ProdProceso			char(20)	NULL		DEFAULT 'Proceso',
	ProdAsignacion			char(20)	NULL		DEFAULT 'Asignacion',
	ProdDevolucion			char(20)	NULL		DEFAULT 'Devolucion',
	ProdConsumo			char(20)	NULL		DEFAULT 'Consumo',
	ProdAvanceProduccion		char(20)	NULL		DEFAULT 'Avance Produccion',
	ProdAvance			char(20)	NULL		DEFAULT 'Avance',
	ProdAvanceCxp			char(20)	NULL		DEFAULT 'Entrada Maquila',
	ProdEntradaProduccion		char(20)	NULL		DEFAULT 'Entrada Produccion',

	ProdSolicitudMaterial		char(20)	NULL		DEFAULT 'Solicitud Material',
	ProdSalidaMaterial		char(20)	NULL		DEFAULT 'Salida Material',
	ProdDevolucionMaterial		char(20)	NULL		DEFAULT 'Devolucion Material',
	ProdAsignacionMaterial		char(20)	NULL		DEFAULT 'Asignacion Material',
	ProdOrdenConsumo		char(20)	NULL		DEFAULT 'Orden Consumo',
	ProdConsumoMaterial		char(20)	NULL		DEFAULT 'Consumo Material',
	ProdRetroceso			char(20)	NULL		DEFAULT 'Retroceso',
	ProdRetrocesoCxp		char(20)	NULL		DEFAULT 'Devolucion Maquila',
	ProdDevProduccion		char(20)	NULL		DEFAULT 'Dev. Produccion',
	ProdOrdenTransferencia		char(20)	NULL		DEFAULT 'Orden Transferencia',

	ProdPlanMaestro			char(20)	NULL 		DEFAULT 'Plan Maestro',
	ProdRequisicionPlan		char(20)	NULL 		DEFAULT 'Requisicion Plan',
	CompraRequisicionPlan		char(20)	NULL 		DEFAULT 'Requisicion Plan',

	BancoSolicitudDeposito		char(20)	NULL 		DEFAULT 'Solicitud Deposito',
	BancoSolicitudCheque		char(20)	NULL 		DEFAULT 'Solicitud Cheque',

        CxcNCargoRecargos		char(20)	NULL 		DEFAULT 'Nota Cargo',
        CxpNCargoRecargos		char(20)	NULL 		DEFAULT 'Nota Cargo',
	BancoTransferencia		char(20)	NULL 		DEFAULT 'Transferencia',
	CxcAjusteRedondeo		char(20)	NULL		DEFAULT 'Ajuste Redondeo',
	CxpAjusteRedondeo		char(20)	NULL		DEFAULT 'Ajuste Redondeo',
	CompraEntradaImportacion	char(20)	NULL 		DEFAULT 'Entrada Importacion',
	VentaSolicitudDevolucion	char(20)	NULL		DEFAULT 'Solicitud Devolucion',
	EmbarqueGastoTarifas		char(20)	NULL		DEFAULT 'Gasto Prorrateado',

	RHAltas				char(20)	NULL		DEFAULT 'Altas',
	RHModificaciones		char(20)	NULL		DEFAULT 'Modificaciones',
	RHBajas				char(20)	NULL		DEFAULT 'Bajas',

	NomAumentoVacaciones		char(20)	NULL		DEFAULT 'Aumento Vacaciones',
	NomVacacionesTomadas		char(20)	NULL		DEFAULT 'Vacaciones Tomadas',
	NomCancelacionParcial		char(20)	NULL		DEFAULT 'Cancelacion Parcial',
	NomIncapacidades		char(20)	NULL		DEFAULT 'Incapacidades',
	NomFaltas			char(20)	NULL		DEFAULT 'Faltas',
	NomRetardos			char(20)	NULL		DEFAULT 'Retardos',
	NomHorasExtras			char(20)	NULL		DEFAULT 'Horas Extras',
        CxcAnticipoSaldo		char(20)	NULL 		DEFAULT 'Anticipo Saldo',
        CxcAnticipoFactura		char(20)	NULL 		DEFAULT 'Anticipo Factura',
        CxpAnticipoSaldo		char(20)	NULL 		DEFAULT 'Anticipo Saldo',
        CxpAnticipoFactura		char(20)	NULL 		DEFAULT 'Anticipo Factura',
        CxcDevolucionSaldo		char(20)	NULL 		DEFAULT 'Devolucion Saldo',
        CxpDevolucionSaldo		char(20)	NULL 		DEFAULT 'Devolucion Saldo',
        CxcAplicacion			char(20)	NULL 		DEFAULT 'Aplicacion',
        CxpAplicacion			char(20)	NULL 		DEFAULT 'Aplicacion',
        CxcDevolucion			char(20)	NULL 		DEFAULT 'Devolucion',
        CxpDevolucion			char(20)	NULL 		DEFAULT 'Devolucion',
	CxpCreditoProveedor		char(20)	NULL 		DEFAULT 'Credito Proveedor',
	CxpCargoProveedor		char(20)	NULL 		DEFAULT 'Cargo Proveedor',
        CxpRecargos			char(20)	NULL 		DEFAULT 'Cargo Proveedor',
        CxpProntoPago			char(20)	NULL 		DEFAULT 'Credito Proveedor',
	CxcDocumentoAnticipo		char(20)	NULL 		DEFAULT 'Documento Anticipo',
	CxpDocumentoAnticipo		char(20)	NULL 		DEFAULT 'Documento Anticipo',
	GastoProrrateado		char(20)	NULL 		DEFAULT 'Gasto Prorrateado',
	ComprobanteProrrateado		char(20)	NULL 		DEFAULT 'Comp. Prorrateado',
	CxpContraRecibo			char(20)	NULL 		DEFAULT 'Contra Recibo',
	ProdCancelacionOrden		char(20)	NULL		DEFAULT 'Cancelacion Orden',
	CxpPagare			char(20)	NULL 		DEFAULT 'Pagare',
	CxpAforo			char(20)	NULL 		DEFAULT 'Aforo',
	CxpFactoraje			char(20)	NULL 		DEFAULT 'Factoraje',
	CxpCartaCredito			char(20)	NULL 		DEFAULT 'Carta Credito',
	GastoDev			char(20)	NULL 		DEFAULT 'Devolucion Gasto',
	GastoDevProrrateada		char(20)	NULL 		DEFAULT 'Dev. Prorrateada',
	CxpGastoDev			char(20)	NULL 		DEFAULT 'Devolucion Gasto',
	CxpGastoDevProrrateada		char(20)	NULL 		DEFAULT 'Dev. Prorrateada',
	CxpDevRetencion			char(20)	NULL		DEFAULT 'Devolucion Retencion',
	VentaNotaDev			char(20)	NULL		DEFAULT 'Nota',
        VentaOrdenSurtido		char(20)	NULL 		DEFAULT 'Orden Surtido',
	CxcAjuste			char(20)	NULL		DEFAULT 'Ajuste',
	CxpAjuste			char(20)	NULL		DEFAULT 'Ajuste',

	CxcConversionCredito		char(20)	NULL		DEFAULT 'Conversion Credito',
	CxcConversionCargo		char(20)	NULL		DEFAULT 'Conversion Cargo',
	CxpConversionCredito		char(20)	NULL		DEFAULT 'Conversion Credito',
	CxpConversionCargo		char(20)	NULL		DEFAULT 'Conversion Cargo',

        CompraPerdida 			char(20)	NULL 		DEFAULT 'Compra Perdida',
        CompraRechazada			char(20)	NULL 		DEFAULT 'Compra Rechazada',
	CxpImportacion			char(20)	NULL		DEFAULT 'Importacion',

	AutoPapeleta			char(20)	NULL		DEFAULT 'Papeleta',
	AutoRecaudacion			char(20)	NULL		DEFAULT 'Recaudacion',
	AutoCancelacionRecaudacion	char(20)	NULL		DEFAULT 'Cancel. Recaudacion',
	AutoMantenimiento		char(20)	NULL		DEFAULT 'Mantenimiento',
	AutoGasto			char(20)	NULL,
	AutoNomina			char(20)	NULL,
	AutoMantenimientoPreventivo	char(20)	NULL,
	CxcAplicacionSaldo		char(20)	NULL		DEFAULT 'Aplicacion Saldo',

	CxcForwardVenta			char(20)	NULL		DEFAULT 'Forward Venta',
	CxcForwardPorCobrar		char(20)	NULL		DEFAULT 'Forward por Cobrar',
	CxpForwardCompra		char(20)	NULL		DEFAULT 'Forward Compra',
	CxpForwardPorPagar		char(20)	NULL		DEFAULT 'Forward por Pagar',

	CxcFacturaSeguro		char(20)	NULL		DEFAULT 'Factura Seguro',
	VentaReservacion		char(20)	NULL		DEFAULT 'Reservacion',
	VentaIngreso			char(20)	NULL		DEFAULT 'Ingreso',
	VentaNotaConsumo		char(20)	NULL		DEFAULT 'Nota Consumo',
	CompraLicitacion		char(20)	NULL		DEFAULT 'Licitacion',
	InvReciboPrevio			char(20)	NULL		DEFAULT 'Recibo Previo',
	GastoDisminucionPresupuesto	char(20)	NULL		DEFAULT 'Disminucion Presup.',
	InvValeSalida			char(20)	NULL,
	InvValeDevolucion		char(20)	NULL,

	PCPrecios			char(20)	NULL		DEFAULT 'Precios',
	PCCostos			char(20)	NULL		DEFAULT 'Costos',
	PCBoletin			char(20)	NULL		DEFAULT 'Boletin',

	GastoDepreciacion		char(20)	NULL		DEFAULT 'Depreciacion',
	CxcEndoso			char(20)	NULL		DEFAULT 'Endoso',
	CxpEndoso			char(20)	NULL		DEFAULT 'Endoso',
	CxcEndosoAFavor			char(20)	NULL		DEFAULT 'Endoso a Favor',
	CxpEndosoAFavor			char(20)	NULL		DEFAULT 'Endoso a Favor',

	CRCorteCaja			char(20)	NULL		DEFAULT 'Corte Caja',
	CRCorteCajaCentral		char(20)	NULL		DEFAULT 'Corte Caja Central',
	CRNota				char(20)	NULL		DEFAULT 'Nota',
	CRFactura			char(20)	NULL		DEFAULT 'Factura',
	CRRemision			char(20)	NULL		DEFAULT 'Remision',

	ServicioPropuesta		char(20)	NULL		DEFAULT 'Propuesta Servicio',
	ServicioCotizacion		char(20)	NULL		DEFAULT 'Cotizacion Servicio',
	ServicioCita			char(20)	NULL		DEFAULT 'Cita Servicio',
	Servicio			char(20)	NULL		DEFAULT 'Servicio',
	ServicioExterno			char(20)	NULL		DEFAULT 'Servicio Externo',
	CxcReevaluacion			char(20)	NULL		DEFAULT 'Reevaluacion',
	CxpReevaluacion			char(20)	NULL		DEFAULT 'Reevaluacion',
	CxcReevaluacionCredito		char(20)	NULL		DEFAULT 'Reevaluacion Credito',
	CxpReevaluacionCredito		char(20)	NULL		DEFAULT 'Reevaluacion Credito',
	DineroReevaluacion		char(20)	NULL		DEFAULT 'Reevaluacion',
	CxcFaltanteCaja			char(20)	NULL		DEFAULT 'Faltante Caja',
	GastoOtrosIngresos		char(20)	NULL		DEFAULT 'Otros Ingresos',
	InvSolicitud			char(20)	NULL		DEFAULT 'Solicitud',
	InvSolicitudCancelada		char(20)	NULL		DEFAULT 'Solicitud Cancelada',
	GastoSolicitudRechazada		char(20)	NULL		DEFAULT 'Solicitud Rechazada',
	VentaPedidoAuto			char(20)	NULL		DEFAULT 'Pedido',
	VentaConsumo			char(20)	NULL		DEFAULT 'Consumo',
	CxcNeteo			char(20)	NULL		DEFAULT 'Neteo',
	CxpNeteo			char(20)	NULL		DEFAULT 'Neteo',
	InvPrimerConteo			char(20)	NULL		DEFAULT 'Primer Conteo',
	InvSegundoConteo		char(20)	NULL		DEFAULT 'Segundo Conteo',
	InvTercerConteo			char(20)	NULL		DEFAULT 'Tercer Conteo',
	DineroRedondeo			char(20)	NULL		DEFAULT 'Redondeo',
	CxcAjusteSaldo			char(20)	NULL		DEFAULT 'Ajuste Saldo',
	CxpAjusteSaldo			char(20)	NULL		DEFAULT 'Ajuste Saldo',
	VentaContrato			char(20)	NULL		DEFAULT 'Contrato',
	DineroInversion			char(20)	NULL		DEFAULT 'Inversion',
	DineroRetiroInversion		char(20)	NULL		DEFAULT 'Retiro Inversion',
	CxcInteresesDevengados		char(20)	NULL		DEFAULT 'Intereses Devengados',
	CxpInteresesDevengados		char(20)	NULL		DEFAULT 'Intereses Devengados',
	CxcCargoIntereses		char(20)	NULL		DEFAULT 'Cargo Intereses',
	CxpAbonoIntereses		char(20)	NULL		DEFAULT 'Abono Intereses',
	VentaFacturaGasto		char(20)	NULL		DEFAULT 'Gasto',
	CxcIntentoCobro			char(20)	NULL		DEFAULT 'Intento Cobro',
	GastoPresupuesto		char(20)	NULL		DEFAULT 'Presupuesto',
        VentaPresupuesto		char(20)	NULL		DEFAULT 'Presupuesto',
	CxcIntereses			char(20)	NULL		DEFAULT 'Intereses',
	CxcInteresesVencidos		char(20)	NULL		DEFAULT 'Intereses Vencidos',
	CxpIntereses			char(20)	NULL		DEFAULT 'Intereses',
	CxcCapital			char(20)	NULL		DEFAULT 'Capital',
	CxpCapital			char(20)	NULL		DEFAULT 'Capital',
	CxcAmortizacion			char(20)	NULL		DEFAULT 'Amortizacion',
	CxpAmortizacion			char(20)	NULL		DEFAULT 'Amortizacion',
	InvFisico			char(20)	NULL		DEFAULT 'Inventario Fisico',

	RHIncremento			char(20)	NULL		DEFAULT 'Incremento',
	ACReinversionCxc		char(20)	NULL,
	ACReinversionCxp		char(20)	NULL,
	ACMHIntereses			char(20)	NULL,
	ACMHInteresesBonificacion	char(20)	NULL,
	ACMHInteresesDocumento		char(20)	NULL,
	ACGasto				varchar(20)	NULL		DEFAULT 'Gasto',

	PCCancelacionPrecios		char(20)	NULL		DEFAULT 'Cancelacion Precios',
	GastoProvision			char(20)	NULL		DEFAULT 'Provision',

	AFDepreciacion			char(20)	NULL		DEFAULT 'Depreciacion',
	AFRevaluacion			char(20)	NULL		DEFAULT 'Revaluacion',
	VentaDevolucionFaltante		char(20)	NULL		DEFAULT 'Devolucion Faltante',
	AgentDevolucionFaltante		char(20)	NULL		DEFAULT 'Devolucion Faltante',
	InvAjusteSaldosMenores		char(20)	NULL 		DEFAULT 'Ajuste',
	CxcRenta			char(20)	NULL		DEFAULT 'Renta',
	CxcAplicacionNomina		char(20)	NULL		DEFAULT 'Aplicacion Nomina',
	ACAjusteValorResidual		char(20)	NULL		DEFAULT 'Ajuste',
	ACAjusteImpuestoAd		char(20)	NULL		DEFAULT 'Ajuste',

	CRPrestamoCxc			char(20)	NULL		DEFAULT 'Nota Cargo',
	ACBajaParcial			char(20)	NULL,

/*	WMSOrdenRecibo			char(20)	NULL		DEFAULT 'Orden Recibo',
	WMSRecibo			char(20)	NULL		DEFAULT 'Recibo',
	WMSOrdenAcomodo			char(20)	NULL		DEFAULT 'Orden Acomodo',
	WMSAcomodo			char(20)	NULL		DEFAULT 'Acomodo',
	WMSOrdenSurtido			char(20)	NULL		DEFAULT 'Orden Surtido',
	WMSSurtido			char(20)	NULL		DEFAULT 'Surtido',
*/
	InvEstadisticaAjusteMerma	char(20)	NULL,
	CxpGastoAnticipo		char(20)	NULL		DEFAULT 'Gasto Anticipo',
	CxpGastoDevAnticipo		char(20)	NULL		DEFAULT 'Gasto Dev Anticipo',
        CxcAplicacionNCargo		char(20)	NULL 		DEFAULT 'Aplicacion N/Cargo',

	ActActividad			char(20)	NULL 		DEFAULT 'Actividad',
	ActAvance			char(20)	NULL 		DEFAULT 'Avance',
	ActConclusion			char(20)	NULL 		DEFAULT 'Conclusion',
	ActCancelacion			char(20)	NULL 		DEFAULT 'Cancelacion',
	ActModificacion			char(20)	NULL 		DEFAULT 'Modificacion',
	ActAtraso			char(20)	NULL 		DEFAULT 'Atraso',
	ACDisposicionCxp		char(20)	NULL,

	BancoDepositoAnticipado		char(20)	NULL 		DEFAULT 'Deposito Anticipado',
	BancoCargoNoIdentificado	char(20)	NULL 		DEFAULT 'Cargo No Ident', 
	GastoCargoBancario		char(20)	NULL 		DEFAULT 'Cargo Bancario',
	GastoCargoBancarioIVA		char(20)	NULL 		DEFAULT 'Cargo Bancario IVA',
	GastoAbonoBancario		char(20)	NULL 		DEFAULT 'Abono Bancario',
	GastoAbonoBancarioIVA		char(20)	NULL 		DEFAULT 'Abono Bancario IVA',

	CreditoDocumentoCxc		char(20)	NULL 		DEFAULT 'Documento Factoraje',
	CreditoDocumentoCxp		char(20)	NULL 		DEFAULT 'Documento Factoraje',
	CreditoPrestamoCxc		char(20)	NULL 		DEFAULT 'Prestamo Factoraje',
	CreditoPrestamoCxp		char(20)	NULL 		DEFAULT 'Prestamo Factoraje',
	CreditoComisiones		char(20)	NULL		DEFAULT 'Nota Cargo',
	CreditoDisposicion		char(20)	NULL		DEFAULT 'Disposicion',
	CreditoFondeo			char(20)	NULL		DEFAULT 'Fondeo',
	CreditoBackToBack		char(20)	NULL		DEFAULT 'Back To Back',
	CreditoDepositoAnticipado	char(20)	NULL		DEFAULT 'Deposito',
	CreditoFondeoAnticipado		char(20)	NULL		DEFAULT 'Fondeo Anticipado',

	BancoIntereses			char(20)	NULL		DEFAULT 'Intereses Ganados',

	ProyProyecto			varchar(20)	NULL		DEFAULT 'Proyecto',
	ProyMitigacion			varchar(20)	NULL		DEFAULT 'Mitigacion',
	InvEntradaDiversa		varchar(20)	NULL		DEFAULT 'Entrada Diversa',
	ContPresupuesto			varchar(20)	NULL		DEFAULT 'Presupuesto',

	FiscalEmisionAcumulable		varchar(20)	NULL		DEFAULT 'Emision Acumulable',
	FiscalEndosoAcumulable		varchar(20)	NULL		DEFAULT 'Endoso Acumulable',
	FiscalFlujoAcumulable		varchar(20)	NULL		DEFAULT 'Flujo Acumulable',
	FiscalEmisionDeducible		varchar(20)	NULL		DEFAULT 'Emision Deducible',
	FiscalEndosoDeducible		varchar(20)	NULL		DEFAULT 'Endoso Deducible',
	FiscalFlujoDeducible		varchar(20)	NULL		DEFAULT 'Flujo Deducible',

	FiscalDeclaracion		varchar(20)	NULL		DEFAULT 'Declaracion',
	FiscalComplementaria		varchar(20)	NULL		DEFAULT 'Complementaria',

	CxpImpuestosPorPagar		varchar(20)	NULL		DEFAULT 'Impuestos por Pagar',
	CxpImpuestosFavor		varchar(20)	NULL		DEFAULT 'Impuestos a Favor',
	InvOrdenEntarimado		varchar(20)	NULL		DEFAULT 'Orden Entarimado',
	InvEntarimado			varchar(20)	NULL		DEFAULT 'Entarimado',
	InvDesentarimado		varchar(20)	NULL		DEFAULT 'Desentarimado', --REQ12615 WMS

	GastoConsumo				varchar(20)	NULL 		DEFAULT 'Consumo',
/*	GastoInvSolicitud			varchar(20)	NULL		DEFAULT 'Solicitud',
	GastoInvSolicitudCI			bit		NULL		DEFAULT 1,
	GastoInvConsumo				varchar(20)	NULL		DEFAULT 'Salida Diversa',
	GastoInvConsumoCI			bit		NULL		DEFAULT 1,*/

	InvSolicitudRechazada		varchar(20)	NULL		DEFAULT 'Solicitud Rechazada',
	InvConsumo			varchar(20)	NULL		DEFAULT 'Consumo',

	VentaOportunidad		varchar(20)	NULL		DEFAULT 'Oportunidad',
	
	CPAsignacion			varchar(20)	NULL		DEFAULT 'Asignacion',
	CPOperacion			varchar(20)	NULL		DEFAULT 'Operacion',
	CPReservadoFlujo		varchar(20)	NULL		DEFAULT 'Reservado Flujo',
	
	MAFSolicitudInspeccion		varchar(20)	NULL		DEFAULT 'Solicitud Inspeccion',	
	GESTarea			varchar(20)	NULL		DEFAULT	'Tarea',
	
	--REAutorizacionPlaza		varchar(20)	NULL		DEFAULT 'Autorizacion Plaza',
	--REEntrevista			varchar(20)	NULL		DEFAULT 'Entrevista',
	--REContratacion			varchar(20)	NULL		DEFAULT 'Contratacion',
	--RERechazoRequisicion		varchar(20)	NULL		DEFAULT 'Rechazo Requisicion',
	--RESolicitudEvaluacion		varchar(20)	NULL		DEFAULT 'Solicitud Evaluacion',
	--REEvaluacion			varchar(20)	NULL		DEFAULT 'Evaluacion',
	
	SAUXServicio			varchar(20)	NULL		DEFAULT 'Servicio',	
	SAUXSolicitudServicio	varchar(20)	NULL		DEFAULT 'Solicitud Servicio',	
	InvConsumoMaterial		varchar(20)	NULL		DEFAULT 'Consumo Material Ser',	
	InvEntradaProducto		varchar(20)	NULL		DEFAULT 'Entrada Producto',	

	CONSTRAINT priEmpresaCfgMov PRIMARY KEY  CLUSTERED (Empresa)
)
GO
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'CxpRetencion')
  ALTER TABLE EmpresaCfgMov ADD CxpRetencion char(20) NULL DEFAULT 'Retencion' WITH VALUES
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'InvSalidaTraspaso')
  ALTER TABLE EmpresaCfgMov ADD InvSalidaTraspaso char(20) NULL DEFAULT 'Salida Traspaso' WITH VALUES
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'InvReciboTraspaso')
  ALTER TABLE EmpresaCfgMov ADD InvReciboTraspaso char(20) NULL DEFAULT 'Recibo Traspaso' WITH VALUES
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'InvTransito')
  ALTER TABLE EmpresaCfgMov ADD InvTransito char(20) NULL DEFAULT 'Transito' WITH VALUES
IF NOT EXISTS (select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'CxcAplicacionTarjetas')	-- ETO Tarjetas 9-Feb-2007
BEGIN
  ALTER TABLE EmpresaCfgMov ADD CxcAplicacionTarjetas char(20) NULL DEFAULT 'Aplicacion Tarjetas'
  EXEC("UPDATE EmpresaCfgMov SET CxcAplicacionTarjetas = DEFAULT")  
END
IF not EXISTS(select * from syscampo where tabla = 'EmpresaCfgMov' AND Campo = 'BancoCargoNoIdentificado')
  ALTER TABLE EmpresaCfgMov ADD BancoCargoNoIdentificado char(20) NULL DEFAULT 'Cargo No Ident' WITH VALUES

EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvTransitoFaltante', 'char(20) NULL DEFAULT "Transito Faltante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaFaltanteCaja', 'char(20) NULL DEFAULT "Faltante Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentFaltanteCaja', 'char(20) NULL DEFAULT "Faltante Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvOrdenTransferencia', 'char(20) NULL DEFAULT "Orden Transferencia" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvOrdenTraspaso', 'char(20) NULL DEFAULT "Orden Traspaso" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacionAnticipo', 'char(20) NULL DEFAULT "Aplicacion Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAplicacionAnticipo', 'char(20) NULL DEFAULT "Aplicacion Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcDevolucionAnticipo', 'char(20) NULL DEFAULT "Devolucion Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpDevolucionAnticipo', 'char(20) NULL DEFAULT "Devolucion Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcReasignacionAnticipo', 'char(20) NULL DEFAULT "Reasignacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpReasignacionAnticipo', 'char(20) NULL DEFAULT "Reasignacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAnticipo', 'char(20) NULL DEFAULT "Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAnticipo', 'char(20) NULL DEFAULT "Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcVentaVales', 'char(20) NULL DEFAULT "Venta Vales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcObsequioVales', 'char(20) NULL DEFAULT "Obsequio Vales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacionVales', 'char(20) NULL DEFAULT "Aplicacion Vales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcDevolucionVales', 'char(20) NULL DEFAULT "Devolucion Vales" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaNota', 'char(20) NULL DEFAULT "Nota" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcContraRecibo', 'char(20) NULL DEFAULT "Contra Recibo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcNCargoRecargos' ,'char(20) NULL DEFAULT "Nota Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpNCargoRecargos', 'char(20) NULL DEFAULT "Nota Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvTransitoSobrante', 'char(20) NULL DEFAULT "Transito Sobrante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoTransferencia', 'char(20) NULL DEFAULT "Transferencia" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAjusteRedondeo', 'char(20) NULL	DEFAULT "Ajuste Redondeo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAjusteRedondeo', 'char(20) NULL	DEFAULT "Ajuste Redondeo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraEntradaImportacion', 'char(20) NULL DEFAULT "Entrada Importacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaSolicitudDevolucion', 'char(20) NULL DEFAULT "Solicitud Devolucion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'EmbarqueGastoTarifas', 'char(20) NULL DEFAULT "Gasto Prorrateado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'RHAltas', 'char(20) NULL DEFAULT "Altas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'RHModificaciones', 'char(20) NULL DEFAULT "Modificaciones" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'RHBajas', 'char(20) NULL DEFAULT "Bajas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomAumentoVacaciones', 'char(20) NULL DEFAULT "Aumento Vacaciones" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomVacacionesTomadas', 'char(20) NULL DEFAULT "Vacaciones Tomadas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAnticipoSaldo', 'char(20) NULL DEFAULT "Anticipo Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAnticipoSaldo', 'char(20) NULL DEFAULT "Anticipo Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacion','char(20) NULL DEFAULT "Aplicacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcDevolucion','char(20) NULL DEFAULT "Devolucion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAplicacion','char(20) NULL DEFAULT "Aplicacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpDevolucion','char(20) NULL DEFAULT "Devolucion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcDevolucionSaldo', 'char(20) NULL DEFAULT "Devolucion Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpDevolucionSaldo','char(20) NULL DEFAULT "Devolucion Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpCreditoProveedor', 'char(20) NULL DEFAULT "Credito Proveedor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpCargoProveedor', 'char(20) NULL DEFAULT "Cargo Proveedor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpRecargos', 'char(20) NULL DEFAULT "Cargo Proveedor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpProntoPago', 'char(20) NULL DEFAULT "Credito Proveedor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcDocumentoAnticipo', 'char(20) NULL DEFAULT "Documento Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpDocumentoAnticipo', 'char(20) NULL DEFAULT "Documento Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoProrrateado', 'char(20) NULL DEFAULT "Gasto Prorrateado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ComprobanteProrrateado', 'char(20)	NULL DEFAULT "Comp. Prorrateado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpContraRecibo','char(20)	NULL DEFAULT "Contra Recibo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ProdCancelacionOrden', 'char(20) NULL DEFAULT "Cancelacion Orden" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpPagare', 'char(20) NULL DEFAULT "Pagare" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAforo', 'char(20) NULL DEFAULT "Aforo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpFactoraje', 'char(20) NULL DEFAULT "Factoraje" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoDev', 'char(20) NULL DEFAULT "Devolucion Gasto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoDevProrrateada', 'char(20) NULL DEFAULT "Dev. Prorrateada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpDevRetencion', 'char(20) NULL DEFAULT "Devolucion Retencion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpGastoDev', 'char(20) NULL DEFAULT "Devolucion Gasto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpGastoDevProrrateada', 'char(20)	NULL DEFAULT "Dev. Prorrateada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaNotaDev', 'char(20) NULL DEFAULT "Nota" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaOrdenSurtido', 'char(20) NULL DEFAULT "Orden Surtido" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAjuste', 'char(20) NULL	DEFAULT "Ajuste" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAjuste', 'char(20) NULL	DEFAULT "Ajuste" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraLocal', 'char(20) NULL DEFAULT "Compra Local" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ProdOrdenConsumo', 'char(20) NULL DEFAULT "Orden Consumo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcConversionCredito', 'char(20) NULL DEFAULT "Conversion Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcConversionCargo', 'char(20) NULL DEFAULT "Conversion Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpConversionCredito', 'char(20) NULL DEFAULT "Conversion Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpConversionCargo', 'char(20) NULL DEFAULT "Conversion Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomCancelacionParcial', 'char(20) NULL DEFAULT "Cancelacion Parcial" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpCancelacionNomina', 'char(20) NULL DEFAULT "Cancelacion Nomina" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraPerdida', 'char(20) NULL DEFAULT "Compra Perdida" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraRechazada', 'char(20) NULL DEFAULT "Compra Rechazada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAnticipoFactura', 'char(20) NULL DEFAULT "Anticipo Factura" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAnticipoFactura', 'char(20) NULL DEFAULT "Anticipo Factura" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpImportacion', 'char(20)	NULL DEFAULT "Importacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoRecaudacion', 'char(20) NULL DEFAULT "Recaudacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoCancelacionRecaudacion', 'char(20) NULL DEFAULT "Cancel. Recaudacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoPapeleta', 'char(20) NULL DEFAULT "Papeleta" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoMantenimiento', 'char(20) NULL	DEFAULT "Mantenimiento" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoGasto', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoNomina', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacionSaldo', 'char(20) NULL DEFAULT "Aplicacion Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoSinComprobante', 'char(20) NULL DEFAULT "Sin Comprobante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpCartaCredito', 'char(20) NULL DEFAULT "Carta Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcForwardVenta', 'char(20) NULL DEFAULT "Forward Venta" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcForwardPorCobrar', 'char(20) NULL DEFAULT "Forward por Cobrar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpForwardCompra', 'char(20) NULL DEFAULT "Forward Compra" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpForwardPorPagar', 'char(20) NULL DEFAULT "Forward por Pagar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcFacturaSeguro', 'char(20) NULL DEFAULT "Factura Seguro" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaReservacion', 'char(20) NULL DEFAULT "Reservacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaIngreso', 'char(20) NULL DEFAULT "Ingreso" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaNotaConsumo', 'char(20) NULL DEFAULT "Nota Consumo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraLicitacion', 'char(20) NULL DEFAULT "Licitacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvReciboPrevio', 'char(20) NULL DEFAULT "Recibo Previo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AutoMantenimientoPreventivo', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoCajaChica', 'char(20)	NULL DEFAULT "Caja Chica" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoDisminucionPresupuesto', 'char(20) NULL DEFAULT "Disminucion Presup." WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvValeSalida', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvValeDevolucion', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PCPrecios', 'char(20) NULL DEFAULT "Precios" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PCCostos', 'char(20) NULL DEFAULT "Costos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PCBoletin', 'char(20) NULL	DEFAULT "Boletin" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoDepreciacion', 'char(20) NULL	DEFAULT "Depreciacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaCorteCaja', 'char(20) NULL DEFAULT "Corte Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcEndoso', 'char(20) NULL	DEFAULT "Endoso" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpEndoso', 'char(20) NULL	DEFAULT "Endoso" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomIncapacidades', 'char(20) NULL DEFAULT "Incapacidades" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvDevTransito', 'char(20)	NULL DEFAULT "Devolucion Transito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomFaltas', 'char(20) NULL	DEFAULT "Faltas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomRetardos', 'char(20) NULL DEFAULT "Retardos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'NomHorasExtras', 'char(20)	NULL DEFAULT "Horas Extras" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvReevaluacion', 'char(20) NULL DEFAULT "Reevaluacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaSobranteCaja', 'char(20) NULL DEFAULT "Sobrante Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentCobro', 'char(20) NULL DEFAULT "Cobro" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoAnticipoSinComprobar', 'char(20) NULL DEFAULT "Anticipo s/Comprobar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaApertura', 'char(20) NULL DEFAULT "Apertura Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaRecoleccion', 'char(20) NULL DEFAULT "Recoleccion Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ServicioPropuesta', 'char(20) NULL	DEFAULT "Propuesta Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ServicioCotizacion', 'char(20) NULL DEFAULT "Cotizacion Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ServicioCita', 'char(20) NULL DEFAULT "Cita Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'Servicio', 'char(20) NULL DEFAULT "Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ServicioExterno', 'char(20) NULL DEFAULT "Servicio Externo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcReevaluacion', 'char(20) NULL DEFAULT "Reevaluacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpReevaluacion', 'char(20) NULL DEFAULT "Reevaluacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaTransferencia', 'char(20) NULL	DEFAULT "Transferencia Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CajaFondoInicial', 'char(20) NULL DEFAULT "Fondo Inicial Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRCorteCaja', 'char(20) NULL DEFAULT "Corte Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRCorteCajaCentral', 'char(20) NULL DEFAULT "Corte Caja Central" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcFaltanteCaja', 'char(20) NULL DEFAULT "Faltante Caja" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentPagoGastos', 'char(20) NULL DEFAULT "Comprobante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoOtrosIngresos', 'char(20) NULL DEFAULT "Otros Ingresos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'DineroReevaluacion', 'char(20) NULL DEFAULT "Reevaluacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvSolicitud', 'char(20) NULL DEFAULT "Solicitud" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoDevComprobante', 'char(20) NULL DEFAULT "Dev. Comprobante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoCargoBancarioIVA', 'char(20) NULL DEFAULT "Cargo Bancario IVA" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CompraControlCalidad', 'char(20) NULL DEFAULT "Control Calidad" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcNomina', 'char(20) NULL DEFAULT "Cobro Nomina" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcCancelacionNomina', 'char(20) NULL DEFAULT "Cancelacion Nomina" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoSolicitudRechazada', 'char(20) NULL DEFAULT "Solicitud Rechazada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaPedidoAuto', 'char(20) NULL DEFAULT "Pedido" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaConsumo', 'char(20) NULL DEFAULT "Consumo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcNeteo', 'char(20) NULL DEFAULT "Neteo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpNeteo', 'char(20) NULL DEFAULT "Neteo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcEndosoAFavor', 'char(20) NULL DEFAULT "Endoso a Favor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpEndosoAFavor', 'char(20) NULL DEFAULT "Endoso a Favor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaNotaResumen', 'char(20) NULL DEFAULT "Nota Resumen" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoTCredito', 'char(20) NULL DEFAULT "Gasto T/Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ContDiario', 'char(20) NULL DEFAULT "Diario" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvPrimerConteo', 'char(20) NULL DEFAULT "Primer Conteo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvSegundoConteo', 'char(20) NULL DEFAULT "Segundo Conteo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvTercerConteo', 'char(20) NULL DEFAULT "Tercer Conteo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcReevaluacionCredito', 'char(20)	NULL DEFAULT "Reevaluacion Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpReevaluacionCredito', 'char(20)	NULL DEFAULT "Reevaluacion Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'DineroRedondeo', 'char(20)	NULL DEFAULT "Redondeo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAjusteSaldo', 'char(20)	NULL DEFAULT "Ajuste Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAjusteSaldo', 'char(20)	NULL DEFAULT "Ajuste Saldo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaContrato', 'char(20) NULL DEFAULT "Contrato" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'DineroInversion', 'char(20) NULL DEFAULT "Inversion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'DineroRetiroInversion', 'char(20) NULL DEFAULT "Retiro Inversion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcInteresesDevengados', 'char(20)	NULL DEFAULT "Intereses Devengados" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpInteresesDevengados', 'char(20)	NULL DEFAULT "Intereses Devengados" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcCargoIntereses', 'char(20) NULL	DEFAULT "Cargo Intereses" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAbonoIntereses', 'char(20) NULL	DEFAULT "Abono Intereses" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentBono', 'char(20) NULL DEFAULT	"Bono" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaFacturaGasto', 'char(20) NULL	DEFAULT "Gasto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoPresupuesto', 'char(20) NULL DEFAULT "Presupuesto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaPresupuesto', 'char(20) NULL DEFAULT "Presupuesto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcIntereses', 'char(20) NULL DEFAULT "Intereses" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcCapital', 'char(20) NULL DEFAULT "Capital" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcIntentoCobro', 'char(20) NULL DEFAULT "Intento Cobro" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpIntereses', 'char(20) NULL DEFAULT "Intereses" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpCapital', 'char(20) NULL DEFAULT "Capital" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAmortizacion', 'char(20) NULL DEFAULT "Amortizacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpAmortizacion', 'char(20) NULL DEFAULT "Amortizacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvSolicitudCancelada', 'char(20) NULL DEFAULT "Solicitud Cancelada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcInteresesVencidos', 'char(20) NULL DEFAULT "Intereses Vencidos" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ContEliminacion', 'char(20) NULL DEFAULT "Eliminacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvFisico', 'char(20) NULL DEFAULT "Inventario Fisico" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcNCreditoVoucher', 'char(20) NULL DEFAULT "Nota Credito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcNCargoVoucher', 'char(20) NULL DEFAULT "Nota Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRNota', 'char(20)	NULL DEFAULT "Nota" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRFactura', 'char(20) NULL DEFAULT "Factura" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRRemision', 'char(20) NULL DEFAULT "Remision" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentAjusteInv', 'char(20) NULL DEFAULT "Ajuste Inventario" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'RHIncremento', 'char(20) NULL DEFAULT "Incremento" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACReinversionCxc', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACReinversionCxp', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACMHIntereses', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACMHInteresesBonificacion', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACMHInteresesDocumento', 'char(20)	NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PCCancelacionPrecios', 'char(20) NULL DEFAULT "Cancelacion Precios" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoProvision', 'char(20)	NULL DEFAULT "Provision" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AFDepreciacion', 'char(20)	NULL DEFAULT "Depreciacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AFRevaluacion', 'char(20) NULL DEFAULT "Revaluacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaDevolucionFaltante', 'char(20) NULL DEFAULT "Devolucion Faltante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'AgentDevolucionFaltante', 'char(20) NULL DEFAULT "Devolucion Faltante" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvAjusteSaldosMenores', 'char(20)	NULL DEFAULT "Ajuste" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcArrendamiento', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacionNomina', 'char(20) NULL DEFAULT "Aplicacion Nomina" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACAjusteValorResidual', 'char(20) NULL DEFAULT "Ajuste" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACAjusteImpuestoAd', 'char(20) NULL DEFAULT "Ajuste" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CRPrestamoCxc', 'char(20) NULL DEFAULT "Nota Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoAbonoBancarioIVA', 'char(20) NULL DEFAULT "Abono Bancario IVA" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACBajaParcial', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'MAFSolicitudInspeccion', 'varchar(20) NULL DEFAULT "Solicitud Inspeccion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GESTarea', 'varchar(20) NULL DEFAULT "Tarea" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PlanPreliminar', 'varchar(20) NULL DEFAULT "Plan Preliminar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'PropuestaEconomica', 'varchar(20) NULL DEFAULT "Propuesta Economica" WITH VALUES'
GO
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSOrdenRecibo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSRecibo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSOrdenAcomodo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSAcomodo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSOrdenSurtido'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'WMSSurtido'
GO
--REQ12615 WMS
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'TMASolicitudAcomodo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'TMAOrdenAcomodo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'TMAAcomodo'
GO

EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvEstadisticaAjusteMerma' ,'char(20) NULL'
go
if not exists(select * from syscampo where tabla = 'EmpresaCfgMov' and campo = 'BancoChequeTraspaso')
begin
  EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoChequeTraspaso', 'char(20) NULL'
  EXEC ("UPDATE EmpresaCfgMov SET BancoChequeTraspaso = BancoCheque")
end
GO
EXEC spRENAME_COLUMN 'EmpresaCfgMov', 'FactorajeDocumentoCxc', 'CreditoDocumentoCxc'
EXEC spRENAME_COLUMN 'EmpresaCfgMov', 'FactorajeDocumentoCxp', 'CreditoDocumentoCxp'
EXEC spRENAME_COLUMN 'EmpresaCfgMov', 'FactorajePrestamoCxc', 'CreditoPrestamoCxc'
EXEC spRENAME_COLUMN 'EmpresaCfgMov', 'FactorajePrestamoCxp', 'CreditoPrestamoCxp'
EXEC spRENAME_COLUMN 'EmpresaCfgMov', 'FactorajeComisiones', 'CreditoComisiones'
GO
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpGastoAnticipo', 'char(20) NULL DEFAULT "Gasto Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpGastoDevAnticipo', 'char(20) NULL DEFAULT "Gasto Dev Anticipo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcAplicacionNCargo', 'char(20) NULL DEFAULT "Aplicacion N/Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActActividad', 'char(20) NULL DEFAULT "Actividad" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActAvance', 'char(20) NULL DEFAULT "Avance" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActConclusion', 'char(20) NULL DEFAULT "Conclusion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActCancelacion', 'char(20)	NULL DEFAULT "Cancelacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActModificacion', 'char(20) NULL DEFAULT "Modificacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ActAtraso', 'char(20) NULL DEFAULT "Atraso" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACDisposicionCxp', 'char(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoDepositoAnticipado', 'char(20) NULL DEFAULT "Deposito Anticipado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoCargoBancario', 'char(20) NULL DEFAULT "Cargo Bancario" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoAbonoBancario', 'char(20) NULL DEFAULT "Abono Bancario" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoDocumentoCxc', 'char(20) NULL DEFAULT "Documento Factoraje" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoDocumentoCxp', 'char(20) NULL DEFAULT "Documento Factoraje" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoPrestamoCxc', 'char(20) NULL DEFAULT "Prestamo Factoraje" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoPrestamoCxp', 'char(20) NULL DEFAULT "Prestamo Factoraje" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoComisiones', 'char(20) NULL DEFAULT "Nota Cargo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoIntereses', 'char(20)	NULL DEFAULT "Intereses Ganados" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'DineroReevaluacionTitulo', 'char(20) NULL DEFAULT "Reevaluacion Titulo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoDisposicion', 'char(20) NULL DEFAULT "Disposicion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoFondeo', 'char(20)	NULL DEFAULT "Fondeo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoBackToBack', 'char(20) NULL DEFAULT "Back To Back" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoDepositoAnticipado', 'char(20) NULL DEFAULT "Deposito" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CreditoFondeoAnticipado', 'char(20) NULL DEFAULT "Fondeo Anticipado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ProyProyecto', 'varchar(20) NULL DEFAULT "Proyecto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ProyMitigacion', 'varchar(20) NULL DEFAULT "Mitigacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvEntradaDiversa', 'varchar(20) NULL DEFAULT "Entrada Diversa" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ContPresupuesto', 'varchar(20) NULL DEFAULT "Presupuesto" WITH VALUES'

EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalDeclaracion', 'varchar(20) NULL DEFAULT "Declaracion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalComplementaria', 'varchar(20) NULL DEFAULT "Complementaria" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpImpuestosPorPagar', 'varchar(20) NULL DEFAULT "Impuestos por Pagar" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxpImpuestosFavor', 'varchar(20) NULL DEFAULT "Impuestos a Favor" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalEmisionAcumulable', 'varchar(20) NULL DEFAULT "Emision Acumulable" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalEndosoAcumulable', 'varchar(20) NULL	DEFAULT "Endoso Acumulable" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalFlujoAcumulable', 'varchar(20) NULL DEFAULT "Flujo Acumulable" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalEmisionDeducible', 'varchar(20) NULL DEFAULT "Emision Deducible" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalEndosoDeducible', 'varchar(20) NULL DEFAULT "Endoso Deducible" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'FiscalFlujoDeducible', 'varchar(20) NULL DEFAULT "Flujo Deducible" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'ACGasto', 'varchar(20) NULL DEFAULT "Gasto" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvOrdenEntarimado', 'varchar(20) NULL DEFAULT "Orden Entarimado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvEntarimado', 'varchar(20) NULL DEFAULT "Entarimado" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvDesentarimado', 'varchar(20) NULL DEFAULT "Desentarimado" WITH VALUES' --REQ12615 WMS
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoConsumo', 'varchar(20) NULL DEFAULT "Consumo" WITH VALUES'
GO
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'GastoInvSolicitud'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'GastoInvSolicitudCI'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'GastoInvConsumo'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'GastoInvConsumoCI'
GO
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvSolicitudRechazada', 'varchar(20) NULL DEFAULT "Solicitud Rechazada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvConsumo', 'varchar(20) NULL DEFAULT "Consumo" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoCargoBancarioIVA', 'varchar(20) NULL DEFAULT "Cargo Bancario IVA" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'GastoAbonoBancarioIVA', 'varchar(20) NULL DEFAULT "Abono Bancario IVA" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'VentaOportunidad', 'varchar(20) NULL DEFAULT "Oportunidad" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'BancoCargoNoIdentificado', 'char(20) NULL DEFAULT "Cargo No Ident" WITH VALUES'
GO
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'CPAmpliacion'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'CPReduccion'
GO
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CPAsignacion', 'varchar(20) NULL DEFAULT "Asignacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CPOperacion', 'varchar(20)	NULL DEFAULT "Operacion" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'CPReservadoFlujo', 'varchar(20) NULL DEFAULT "Reservado Flujo" WITH VALUES'
GO

--EXEC spALTER_TABLE 'EmpresaCfgMov', 'REAutorizacionPlaza', 'varchar(20)	NULL DEFAULT "Autorizacion Plaza" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgMov', 'REEntrevista', 'varchar(20) NULL DEFAULT "Entrevista" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgMov', 'REContratacion', 'varchar(20) NULL DEFAULT "Contratacion" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgMov', 'RERechazoRequisicion', 'varchar(20) NULL DEFAULT "Rechazo Requisicion" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgMov', 'RESolicitudEvaluacion', 'varchar(20) NULL DEFAULT "Solicitud Evaluacion" WITH VALUES'
--EXEC spALTER_TABLE 'EmpresaCfgMov', 'REEvaluacion', 'varchar(20) NULL DEFAULT "Evaluacion" WITH VALUES'
--GO



EXEC spDROP_COLUMN 'EmpresaCfgMov', 'REAutorizacionPlaza'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'REEntrevista'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'REContratacion'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'RERechazoRequisicion'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'RESolicitudEvaluacion'
EXEC spDROP_COLUMN 'EmpresaCfgMov', 'REEvaluacion'
GO

EXEC spALTER_TABLE 'EmpresaCfgMov', 'SAUXServicio', 'varchar(20) NULL DEFAULT "Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'SAUXSolicitudServicio', 'varchar(20) NULL DEFAULT "Solicitud Servicio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvConsumoMaterial', 'varchar(20) NULL DEFAULT "Consumo Material Ser" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgMov', 'InvEntradaProducto', 'varchar(20) NULL DEFAULT "Entrada Producto" WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaCfgMov', 'CxcRenta', 'varchar(20) NULL DEFAULT "Renta" WITH VALUES'
GO


/****** Configuracion de Movimientos de la Empresa Ventas ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovVenta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovVenta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovVenta') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovVenta (
	Empresa 			char(5)  	NOT NULL,

	VentaBonificacion		varchar(20)	NULL		DEFAULT 'Bonificacion Venta',
	VentaEstadistica		varchar(20)	NULL		DEFAULT 'Estadistica',
	VentaPedidoEstadistico		varchar(20)	NULL		DEFAULT 'Estadistica',

	CONSTRAINT priEmpresaCfgMovVenta PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'EmpresaCfgMovVenta', 'VentaBonificacion', 'varchar(20) NULL DEFAULT "Bonificacion Venta" WITH VALUES'
EXEC spAlter_table 'EmpresaCfgMovVenta', 'VentaEstadistica', 'varchar(20) NULL DEFAULT "Estadistica" WITH VALUES' 
EXEC spAlter_table 'EmpresaCfgMovVenta', 'VentaPedidoEstadistico', 'varchar(20) NULL DEFAULT "Estadistica" WITH VALUES' 
GO

-- 'CORTE'
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovCorte')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovCorte','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovCorte') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovCorte (
  Empresa 			char(5)  	NOT NULL,
  CorteImporte		char(20)  	NULL DEFAULT 'Corte Importe',
  CorteContable		char(20)  	NULL DEFAULT 'Corte Contable',
  CorteUnidades		char(20)  	NULL DEFAULT 'Corte Unidades',

  CONSTRAINT priEmpresaCfgMovCorte PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spALTER_TABLE 'EmpresaCfgMovCorte', 'CorteCx',  'char(20) NULL DEFAULT "Corte Cx" WITH VALUES' 
GO

--REQ16092
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovOPORT')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovOPORT','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovOPORT') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovOPORT (
  Empresa 			char(5)  	NOT NULL,
  OPORTOportunidad	char(20)  	NULL DEFAULT 'Oportunidad',
  OPORTGenerador	char(20)  	NULL DEFAULT 'Generador Op',

  CONSTRAINT priEmpresaCfgMovOPORT PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** Movimientos Almacen Def ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovAlmacenDef')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovAlmacenDef','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovAlmacenDef') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovAlmacenDef (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,
	Almacen		char(10)	NOT NULL,

	CONSTRAINT priEmpresaCfgMovAlmacenDef PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov, Almacen)
)
GO

/****** EmpresaCfgMovCP ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovCP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovCP','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovCP') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovCP (
	Empresa 			varchar(5)  	NOT NULL,

	CPAnteproyecto			varchar(20)	NULL		DEFAULT 'Anteproyecto'

	CONSTRAINT priEmpresaCfgMovCP PRIMARY KEY  CLUSTERED (Empresa)
)
GO

/****** Configuracion de Movimientos de la Empresa Planeacion Presupuestal ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovPCP')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovPCP','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovPCP') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovPCP (
	Empresa 			char(5)  	NOT NULL,

	PCPPresupuesto			varchar(20)	NULL		DEFAULT 'Presupuesto',
	
	PCPEstructura			varchar(20)	NULL		DEFAULT 'Estructura',
	PCPEstructuraAprobada	varchar(20)	NULL		DEFAULT 'Estructura Aprobada',	
	
	PCPCatalogo				varchar(20)	NULL		DEFAULT 'Catalogo',
	PCPEliminacionCatalogo	varchar(20)	NULL		DEFAULT 'Eliminacion Catalogo',	
	PCPModificacionCatalogo	varchar(20)	NULL		DEFAULT 'Catalogo Modificado',		
	
	PCPClavePresupuestal	varchar(20)	NULL		DEFAULT 'Clave Presupuestal',
	PCPEliminacionClave		varchar(20)	NULL		DEFAULT 'Eliminacion Clave',	
	
	PCPRegla				varchar(20)	NULL		DEFAULT 'Regla',
	PCPEliminacionRegla		varchar(20)	NULL		DEFAULT 'Eliminacion Regla',
	PCPConcluirPresupuesto	varchar(20)	NULL		DEFAULT 'Concluir Presupuesto',
	
	CONSTRAINT priEmpresaCfgMovPCP PRIMARY KEY  CLUSTERED (Empresa)
)
GO

EXEC spAlter_Table 'EmpresaCfgMovPCP', 'PCPEliminacionClave', 'varchar(20) NULL DEFAULT "Eliminacion Clave"'
EXEC spAlter_Table 'EmpresaCfgMovPCP', 'PCPConcluirPresupuesto', 'varchar(20) NULL DEFAULT "Concluir Presupuesto"'
GO
--BUG24180
--REQ12615 WMS
/****** Configuracion de Movimientos de la Empresa WMS ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovWMS')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovWMS','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovWMS') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovWMS (
	Empresa 				char(5)  	NOT NULL,

	TMASolicitudAcomodo		varchar(20)		NULL	DEFAULT 'Solicitud Acomodo',
	TMAOrdenAcomodo			varchar(20)		NULL	DEFAULT 'Orden Acomodo',
	TMAAcomodo				varchar(20)		NULL	DEFAULT 'Acomodo',
	TMASolicitudReacomodo	varchar(20)		NULL	DEFAULT 'Solicitud Reacomodo',
	TMAOrdenReacomodo		varchar(20)		NULL	DEFAULT 'Orden Reacomodo',
	TMAReacomodo			varchar(20)		NULL	DEFAULT 'Reacomodo',
	TMAOrdenSurtido			varchar(20)		NULL	DEFAULT 'Orden Surtido',
	TMASurtidoTransito		varchar(20)		NULL	DEFAULT 'Surtido Transito',
	TMAOrdenSurtidoPCK		varchar(20)		NULL	DEFAULT 'Orden Surtido PCK',
	TMASurtidoTransitoPCK	varchar(20)		NULL	DEFAULT 'Surtido Transito PCK',
	TMASurtido				varchar(20)		NULL	DEFAULT 'Surtido',
	TMASurtidoPerdido		varchar(20)		NULL	DEFAULT 'Surtido Perdido',

	--BUG24180
	InvEntarimado			varchar(20)		NULL	DEFAULT 'Entarimado',
	InvDesentarimado		varchar(20)		NULL	DEFAULT 'Desentarimado',
		
	CONSTRAINT priEmpresaCfgMovWMS PRIMARY KEY  CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgMovWMS', 'InvEntarimado', 'varchar(20) NULL DEFAULT "Entarimado"'
EXEC spALTER_TABLE 'EmpresaCfgMovWMS', 'InvDesentarimado', 'varchar(20) NULL DEFAULT "Desentarimado"'
GO

--TASK6535
EXEC spALTER_TABLE 'EmpresaCfgMovWMS', 'TMAOrdenPCKTarima','varchar(20) NULL DEFAULT "Orden PCK Tarima"'
GO
EXEC spALTER_TABLE 'EmpresaCfgMovWMS', 'TMAPCKTarimaTransito', 'varchar(20) NULL DEFAULT "PCK Tarima Transito"'
GO
EXEC spALTER_TABLE 'EmpresaCfgMovWMS', 'TMAPCKTarima', 'varchar(20) NULL DEFAULT "PCK Tarima"'
GO

/****** Flujo Movimientos Recurrentes ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovRecurrente')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovRecurrente','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovRecurrente') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovRecurrente (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	MovOrigen	char(20)	NOT NULL,

	MovDestino	char(20)	NULL,

	CONSTRAINT priEmpresaCfgMovRecurrente PRIMARY KEY  CLUSTERED (Empresa, Modulo, MovOrigen)
)
GO
if (select version from version) <= 2300
  ALTER TABLE EmpresaCfgMovRecurrente ALTER COLUMN MovDestino char(20) NULL
GO

/****** Flujo Contratos ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovContrato')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovContrato','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovContrato') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovContrato (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	MovOrigen	char(20)	NOT NULL,

	MovDestino	char(20)	NULL,

	CONSTRAINT priEmpresaCfgMovContrato PRIMARY KEY  CLUSTERED (Empresa, Modulo, MovOrigen)
)
GO
if (select version from version) <= 2300
  ALTER TABLE EmpresaCfgMovContrato ALTER COLUMN MovDestino char(20) NULL
GO

/****** EmpresaCfgCxcVoucher ******/
if not exists (select * from SysTabla where SysTabla = 'EmpresaCfgCxcVoucher') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgCxcVoucher','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgCxcVoucher') and type = 'U') 
  CREATE TABLE dbo.EmpresaCfgCxcVoucher (
	Empresa			char(5)		NOT NULL,
	Mov			char(20)        NOT NULL,

	MovGenerar		char(20)        NULL,

	CONSTRAINT priEmpresaCfgCxcVoucher PRIMARY KEY CLUSTERED (Empresa, Mov)
)
GO


/****** Configuracion de Movimientos de la Empresa Generados ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovGenera')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovGenera','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovGenera') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovGenera (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,
	GeneraModulo	char(5)		NOT NULL,
	GeneraMov	char(20)	NOT NULL,

	ArrastrarMovID	bit		NULL	DEFAULT 0,

	CONSTRAINT priEmpresaCfgMovGenera PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov, GeneraModulo)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgMovGenera', 'ArrastrarMovID' ,'bit NULL DEFAULT 0 WITH VALUES'
GO
/****** EmpresaCfgMovImp ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovImp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovImp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovImp') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmpresaCfgMovImp (
	Empresa 		char(5)  	NOT NULL,
	ID			int		NOT NULL IDENTITY (1,1),

	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,
	Estatus			char(15)	NULL	DEFAULT '(Todos)',
	ReporteImpresora	varchar(50)	NULL,
	ReportePantalla		varchar(50)	NULL,
	Sucursal		int		NOT NULL DEFAULT 0,

	CONSTRAINT priEmpresaCfgMovImp PRIMARY KEY CLUSTERED (Empresa, ID)
  )
  EXEC spSincroSemilla 'EmpresaCfgMovImp'
END
GO
EXEC spModificarPK_SucursalSinOrigen 'EmpresaCfgMovImp', '(Empresa, ID)'
GO


/****** SucursalMovSeguimiento ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalMovSeguimiento')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalMovSeguimiento','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalMovSeguimiento') and type = 'U') 
  CREATE TABLE dbo.SucursalMovSeguimiento (
	Sucursal		int	  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,

	Seguimiento		char(20)	NOT NULL, 

	CONSTRAINT priSucursalMovMatriz PRIMARY KEY CLUSTERED (Sucursal, Modulo, Mov)
  )
GO

/****** SucursalMovBloquearCambio ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalMovBloquearCambio')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalMovBloquearCambio','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalMovBloquearCambio') and type = 'U') 
  CREATE TABLE dbo.SucursalMovBloquearCambio (
	Sucursal		int	  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,

	CONSTRAINT priSucursalMovBloquearCambio PRIMARY KEY CLUSTERED (Sucursal, Modulo, Mov)
  )
GO

/****** Configuracion de Movimientos Especiales ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgMovEsp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgMovEsp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgMovEsp') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgMovEsp (
	Empresa 	char(5)  	NOT NULL,
	Asunto		char(5)		NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,
	Accion		varchar(50)	NULL,

	CONSTRAINT priEmpresaCfgMovEsp PRIMARY KEY CLUSTERED (Empresa, Asunto, Modulo, Mov)
)
GO

/****** Configuracion de Sistema Detallista ******/
if not exists(select * from SysTabla where SysTabla = 'CfgSistemaDetallista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgSistemaDetallista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgSistemaDetallista') and type = 'U') 
CREATE TABLE dbo.CfgSistemaDetallista (
	Concepto	varchar(50)	NOT NULL,
	Orden		int		NULL,
	Grupo		varchar(50)	NULL,

	CuentaCosto	varchar(20)	NULL,
	CuentaPrecio	varchar(20)	NULL,

	CONSTRAINT priCfgSistemaDetallista PRIMARY KEY CLUSTERED (Concepto)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'CfgSistemaDetallista' AND sysindexes.name = 'Orden' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Orden ON dbo.CfgSistemaDetallista (Orden)
GO
EXEC spALTER_TABLE 'CfgSistemaDetallista', 'Grupo', 'varchar(50) NULL'
GO
IF exists(select * from CfgSistemaDetallista where Grupo IS NULL)
  UPDATE CfgSistemaDetallista SET Grupo = CASE WHEN ORDEN < 100 THEN 'Compras' ELSE 'Ventas' END
GO

EXEC spFK 'CfgSistemaDetallista','CuentaCosto','Cta','Cuenta'
GO

/****** Configuracion de Anexar Movimientos ******/
if not exists(select * from SysTabla where SysTabla = 'CfgAnexarMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgAnexarMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgAnexarMov') and type = 'U') 
CREATE TABLE dbo.CfgAnexarMov (
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,
	MovDestino	char(20)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priCfgAnexarMov PRIMARY KEY CLUSTERED (Modulo, Mov, MovDestino)
)
GO

/****** EmpresaCfgContXMov ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgContXMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgContXMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgContXMov') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgContXMov (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				varchar(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgContXMov PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

/****** CfgCuentasContablesImpuesto1 ******/
if not exists(select * from SysTabla where SysTabla = 'CfgCuentasContablesImpuesto1')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgCuentasContablesImpuesto1','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgCuentasContablesImpuesto1') and type = 'U') 
CREATE TABLE CfgCuentasContablesImpuesto1(
 Nombre       varchar(20)  NOT NULL,
 Tasa         float NULL,
 Cuenta       varchar(20)  NULL

CONSTRAINT priCfgCuentasContablesImpuesto1 PRIMARY KEY(Nombre)
)
GO


/****** CfgCuentasContablesCondImpuesto1 ******/
if not exists(select * from SysTabla where SysTabla = 'CfgCuentasContablesCondImpuesto1')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgCuentasContablesCondImpuesto1','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgCuentasContablesCondImpuesto1') and type = 'U') 
CREATE TABLE CfgCuentasContablesCondImpuesto1(
 Condicion    varchar(50)  NOT NULL,
 Nombre       varchar(20)  NOT NULL,
 Tasa         float NULL,
 Cuenta       varchar(20)  NULL

CONSTRAINT priCfgCuentasContablesCondImpuesto1 PRIMARY KEY(Condicion, Nombre)
)
GO


-- 9319
/************** EmpresaValidarFechaAplicacion ***************/
if not exists (select * from SysTabla where SysTabla = 'EmpresaValidarFechaAplicacion') 
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmpresaValidarFechaAplicacion', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaValidarFechaAplicacion') and type = 'U') 
  CREATE TABLE EmpresaValidarFechaAplicacion(
    Empresa			varchar(5),
    Modulo			varchar(5),
    Mov				varchar(20),
    AplicaModulo	varchar(5),
    AplicaMov		varchar(20),
    
    CONSTRAINT priEmpresaValidarFechaAplicacion PRIMARY KEY CLUSTERED(Empresa, Modulo, Mov, AplicaModulo, AplicaMov)
    )
GO

/****** Configuracion General de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaGral')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaGral','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaGral') and type = 'U') 
CREATE TABLE dbo.EmpresaGral (
	Empresa 			varchar(5)  	NOT NULL,

	EmpresaDinero			varchar(5)		NULL		DEFAULT 'Misma',
	EmpresaCont			varchar(5)		NULL		DEFAULT 'Misma',
	DiasHabiles			varchar(20)	NULL		DEFAULT 'Lun-Vie',
	HorasDia			float		NULL		DEFAULT 8.0,
	DiasMes				float		NULL		DEFAULT 30.0,
	ClaveDesarrollo			varchar(20)	NULL,
	DirectorioCodigo		varchar(150)	NULL,
	Mensaje1			varchar(255)	NULL		DEFAULT 'Empresa.Nombre',
	Mensaje1Ancho			int		NULL		DEFAULT 200,
	Mensaje2			varchar(255)	NULL		DEFAULT 'Sucursal.Nombre',
	Mensaje2Ancho			int		NULL		DEFAULT 100,
	Mensaje3			varchar(255)	NULL		DEFAULT 'Usuario.Nombre',
	Mensaje3Ancho			int		NULL		DEFAULT 100,
	Mensaje4			varchar(255)	NULL,
	Mensaje4Ancho			int		NULL,
	MensajeAutoRefrescar		int		NULL,
	ExpresionAlIniciar		varchar(255)	NULL,

	AlmacenTransito			varchar(20)	NULL 		DEFAULT '(TRANSITO)',
	AlmacenGarantias		varchar(20)	NULL,
	DefServicioTipo			varchar(50)	NULL,
	DefArtTipo			varchar(20)	NULL		DEFAULT 'Normal',
	DefImpuesto			float		NULL		DEFAULT 16.0,
	DefRetencion			float		NULL		DEFAULT 10.0,
	DefUnidad			varchar(20)	NULL		DEFAULT 'Piezas',
	DefEsDeducible			bit		NULL		DEFAULT 0,
	DefCondicion			varchar(50)	NULL,
	DefCredito			varchar(50)	NULL,
	DefUsuario			varchar(10)	NULL,
	TiposPresupuesto		bit		NOT NULL	DEFAULT 0,
	CteExpressDef			varchar(20)	NULL		DEFAULT '(CONSECUTIVO)',
	CteExpressPrefijo		varchar(5)		NULL		DEFAULT 'C',
	CteExpressDigitos		int		NULL		DEFAULT 5,
	CteExpressCategoria		varchar(50)	NULL,
	CteExpressCondicion		varchar(50)	NULL,
	CteExpressUsarPrefijoSucursal	bit		NULL		DEFAULT 1,

	ArtExpressDef			varchar(20)	NULL		DEFAULT '(CONSECUTIVO)',
	ArtExpressPrefijo		varchar(5)		NULL		DEFAULT 'A',
	ArtExpressDigitos		int		NULL		DEFAULT 5,
	ArtExpressCategoria		varchar(50)	NULL,
	ArtExpressUsarPrefijoSucursal	bit		NULL		DEFAULT 1,

	ContX       			bit		NOT NULL	DEFAULT 0,
	ContXAfectar   			bit		NOT NULL	DEFAULT 0,
	ContXGenerarDinero		bit		NOT NULL 	DEFAULT 0,
        ContXFacturasPendientes         bit		NULL 	        DEFAULT 0,
	ContXCancelarMismoMes		bit		NULL		DEFAULT 1,
	ContXMovimientosEspecificos	bit		NULL		DEFAULT 0,
	ContXUniDireccional		bit		NULL		DEFAULT 1,

	ContAuto			bit		NULL		DEFAULT 0,
	ContAutoConceptoGastos		bit		NULL		DEFAULT 0,
	ContAutoClaseConceptoGastos	bit		NULL		DEFAULT 0,
	ContAutoPartidasSinImporte	bit		NULL		DEFAULT 0,
	ContAutoConsolidacion		bit		NULL		DEFAULT 0,
	ContAutoCteTipoFilial		varchar(20)	NULL		DEFAULT 'Filial',
	ContAutoChequesMultiContacto	bit		NULL		DEFAULT 0,
	ContAutoCancelarMismoMes	bit		NULL		DEFAULT 1,
	ContAutoEliminarCCNoReq		bit		NULL		DEFAULT 0,

	ContPersonalSucursal		bit		NULL		DEFAULT 0,
	ContabilizarMesesFuturos	bit		NULL		DEFAULT 1,

	EjercicioInicio			datetime	NULL,
	EjercicioFinal			datetime	NULL,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,
	VistaOpcionesOmision		bit		NOT NULL 	DEFAULT 0,
	ConsecutivoSerial		bit		NOT NULL 	DEFAULT 0,
	ConsecutivoDigitos		int		NULL,
	Prod				bit		NOT NULL 	DEFAULT 0,
	FiltrarFechasMovPendientes	bit		NOT NULL 	DEFAULT 1,
	AccesoPaginas			bit		NOT NULL 	DEFAULT 0,
	PC				bit		NULL		DEFAULT 0,
	Cambios				bit		NOT NULL 	DEFAULT 0,
	AC				bit		NULL		DEFAULT 0,
	Espacios			bit		NOT NULL 	DEFAULT 0,
	EspacioNombreSingular		varchar(50)	NULL		DEFAULT 'Espacio',
	EspacioNombrePlural		varchar(50)	NULL		DEFAULT 'Espacios',
	Autotransportes			bit		NOT NULL 	DEFAULT 0,

	ExpirarContrasenas		bit		NULL		DEFAULT 0,
	ExpirarDias			int		NULL		DEFAULT 60,
	DefContrasenaModificar		bit		NULL		DEFAULT 0,

	FormatoCantidades		varchar(50)	NULL		DEFAULT '#,.##',
	DecimalesCantidades		int		NULL		DEFAULT 0,
	UsarConsecutivoSucursalDestino	bit		NULL		DEFAULT 0,
	UsarSucursalMovOrigen		bit		NULL		DEFAULT 0,
	AutoAsignarMovSucursalAlmacen	bit		NULL		DEFAULT 1,
	PermitirMovSucursalDiferente	bit		NULL		DEFAULT 0,
	NivelAcceso			bit		NULL		DEFAULT 0,
	NivelAccesoEsp			bit		NULL		DEFAULT 0,
	CambiarFechaTrabajoAcceso	bit		NULL		DEFAULT 1,

	CteDatosPersonales		bit		NULL		DEFAULT 0,
	CteDatosAseguradora		bit		NULL		DEFAULT 0,
	CteCtoApellidos			bit		NULL		DEFAULT 0,
	CteUsoServicio			bit		NULL		DEFAULT 0,
	CteUsoServicioEvaluacion	varchar(20)	NULL,
	AdvertirProyectosExpirados	bit		NULL		DEFAULT 0,
	ArrastrarTipoCambioGenerarMov	bit		NULL		DEFAULT 0,
	CopiarBitacoraOrigen		bit		NULL		DEFAULT 0,

	UltimoCorteComisionesCobranza	datetime	NULL,

	Ford				bit		NULL		DEFAULT 0,
	FordDistribuidor		varchar(3)		NULL,
	FordMercado			varchar(2)		NULL,
	FordDirectorioEntrada		varchar(150)	NULL,
	FordDirectorioSalida		varchar(150)	NULL,
	FordDirectorioFBCM		varchar(150)	NULL,
	FordMovPedido			varchar(20)	NULL		DEFAULT 'Orden Compra',
	FordMovAvance			varchar(20)	NULL		DEFAULT 'Avance Compra',
	FordMovRemision			varchar(20)	NULL		DEFAULT 'Entrada Compra',
	FordMovCxcFactura		varchar(20)	NULL,
	FordCliente			varchar(10)	NULL,
	FordCredit			varchar(10)	NULL,
	FordCtePrefijo			varchar(5)		NULL		DEFAULT 'F',
	FordCteDigitos			int		NULL		DEFAULT 5,
	FordUDIMov			varchar(20)	NULL,
	FordUDIArticulo			varchar(20)	NULL,

	FordX_Oderep			varchar(100)	NULL,	
	FordX_PINS			varchar(100)	NULL,
	FordX_Segundos			int		NULL		DEFAULT 60,
	FordX_DealerID			varchar(20)	NULL,
	FordX_Password			varchar(20)	NULL,
	FordX_DealerIDAlterno		varchar(20)	NULL,
	FordX_PasswordAlterno		varchar(20)	NULL,
	FordX_DesacopladorIP		varchar(15)	NULL,
        FordOASIS                       varchar(150)    NULL,

	FordPlazo1			int		NULL		DEFAULT 40,
	FordPlazo2			int		NULL		DEFAULT 80,
	FordPlazo3			int		NULL		DEFAULT 120,
	FordPlazo1Tasa			float		NULL,
	FordPlazo2Tasa			float		NULL,
	FordPlazo3Tasa			float		NULL,

	FordTipoCosteoAutos		varchar(20)	NULL 		DEFAULT 'Promedio',
	FordTipoCosteoRefacciones	varchar(20)	NULL 		DEFAULT 'Promedio',
	FordComisionVentasCasa		money		NULL,
	FordComisionComprasUsados	money		NULL,
	Volvo				bit		NULL		DEFAULT 0,

        Chrysler                        bit		NULL		DEFAULT 0,
	ChryslerCliente			varchar(10)	NULL,

	FordUtilidadTraspaso		float		NULL,
	FordUtilidadTraspasoOrigen	varchar(10)	NULL,
	FordUtilidadTraspasoDestino	varchar(10)	NULL,
	FordRetencionUsadosTope		money		NULL,
	FordRetencionUsados		float		NULL,

        FordValidarOASIS                bit             NULL            DEFAULT 1,
        FordValidarHojaServicio         bit             NULL            DEFAULT 1,
        FordEmpresaComisiones           char(10)        NULL            DEFAULT '(Misma)',

	ReabastecidoHasta		datetime	NULL,
	fixCancelarTraspasoSinTransito	bit		NULL		DEFAULT 0,

	CerrarDia			bit		NULL		DEFAULT 0,
	CerrarSucursalAuto		bit		NULL		DEFAULT 0,
	CerrarSucursalSincro		bit		NULL		DEFAULT 0,
	CerrarDiaAuto			bit		NULL		DEFAULT 0,
	Intelisis			bit		NULL		DEFAULT 0,

	CR				bit		NULL		DEFAULT 0,
	SugerirConsecCentralizado	bit		NULL		DEFAULT 1,
	eMailAutoAsunto			varchar(255)	NULL,
	eMailAutoMensaje		text		NULL,
	UltimoPagoCostoPiso		datetime	NULL,
	ConceptoGastoCostoPiso		varchar(50)	NULL,
	AcreedorISAN			varchar(10)	NULL,
        ConceptoISAN        		varchar(50)	NULL,
	MovCB				bit		NULL		DEFAULT 0,

	RSReportASPX			varchar(255)	NULL,

	CostoPisoPlazo1			int		NULL		DEFAULT 40,
	CostoPisoPlazo2			int		NULL		DEFAULT 80,
	CostoPisoPlazo3			int		NULL		DEFAULT 120,
        FechaInicioCostoPiso            varchar(20)     NULL            DEFAULT 'Fecha Entrada',

        CostoPisoUsados                 bit             NULL            DEFAULT 0,
        CostoPisoUsadosTasa             float           NULL,
        CostoPisoUsadosDiasLibres       int             NULL,

	eCollaboration			bit		NULL		DEFAULT 0,
	eCollaboration2Capas		bit		NULL		DEFAULT 0,
	ConsolidacionEmpresas		bit		NULL		DEFAULT 0,

	CfgRegistro			int		NULL,
	ValidarRegistros		bit		NULL		DEFAULT 1,
	
	DirectorioPlantillasOffice	varchar(255)	NULL,
	DirectorioAnexosEsp		varchar(255)	NULL,

	WMS				bit		NULL		DEFAULT 0,
	Capital				bit		NULL		DEFAULT 0,
	SistemaDetallista		bit		NULL		DEFAULT 0,
	NomAuto				bit		NULL		DEFAULT 0,

	GRP				bit		NULL		DEFAULT 0,
	GRPRamo				varchar(1)		NULL,
	GRPUnidad			varchar(4)		NULL,
	GRPCuota			money		NULL,

	PPTO				bit		NULL		DEFAULT 0,
	PPTOVentas			bit		NULL		DEFAULT 0,
	Registro			bit		NULL		DEFAULT 1,
	InfoPath			bit		NULL		DEFAULT 0,
	FEA				bit		NULL		DEFAULT 0,
	FEAVersion			varchar(10)	NULL,
	FEAWebService			varchar(100)	NULL,
	FEACertificado			varchar(100)	NULL,
	FEAEnLinea			bit		NULL		DEFAULT 0,

	CMP				bit		NULL		DEFAULT 0,
	PM				bit		NULL		DEFAULT 0,

	Interfactura			bit		NULL		DEFAULT 0,
	InterfacturaRI			varchar(10)	NULL,
	EDIIdentificador		varchar(10)	NULL,
	EDICalificador			varchar(10)	NULL,
	EDIArtIdioma			varchar(2)		NULL		DEFAULT 'ES',

	ContSocios			bit		NULL		DEFAULT 0,

	RS				bit		NULL		DEFAULT 0,
	Hasp				bit		NULL		DEFAULT 0,
	CRM				bit		NULL		DEFAULT 0,
	--REQ16092
	OPORT			bit		NULL		DEFAULT 0,
	Gestion				bit		NULL		DEFAULT 0,

	BPlanAgrupadorArt		varchar(20)	NULL,
	BPlanAgrupadorPersonal		varchar(20)	NULL,
	BPlanMesPeriodo1		int		NULL		DEFAULT 1,
	CamposExtras			varchar(20)	NULL		DEFAULT 'Caracteristicas',

	URL1				varchar(255)	NULL,
	URL2				varchar(255)	NULL,
	URL3				varchar(255)	NULL,
	URL4				varchar(255)	NULL,

	Menu				varchar(50)	NULL,

	URL_RecibirForma		varchar(255)	NULL,
	URL_Logo			varchar(255)	NULL,
	URL_Imagenes			varchar(255)	NULL,
	RecibirFormaHTML		text		NULL,
	DBMailPerfil			varchar(50)	NULL,

	OFER				bit		NULL		DEFAULT 0,
	ARO				bit		NULL		DEFAULT 0,
	AGD				bit		NULL		DEFAULT 0,
	FIS				bit		NULL		DEFAULT 0,
	CAPT				bit		NULL		DEFAULT 0,
	GES				bit		NULL		DEFAULT 0,
	CP				bit		NULL		DEFAULT 0,

	CostoBase			varchar(50)	NULL		DEFAULT '(Costo Reposicion)',
	ProspectoExpressPagina		varchar(20)	NULL,
	MovConcurrente			bit		NULL		DEFAULT 0,

	IntelisisServiceWSDL		varchar(255)	NULL,
	IntelisisServiceComprimir	bit		NULL		DEFAULT 1,
	IntelisisServiceEncriptar	bit		NULL		DEFAULT 1,

	SubFoliosOrigen			bit		NULL		DEFAULT 0,
	SubFoliosOrigenSeparador	varchar(10)	NULL 		DEFAULT '-',
	
	Pacto				bit		NULL		DEFAULT 0,

	VerMovAgrupadores		bit		NULL		DEFAULT 0,
	
	MAF				bit		NULL		DEFAULT 0,
	VIC				bit		NULL		DEFAULT 0,	

	TipoImpuesto			bit		NULL		DEFAULT 0,
	FiscalRegimenCriterioEmpresa	varchar(30)	NULL		DEFAULT 'Empresa/Sucursal',
	FiscalRegimenCriterioCliente	varchar(30)	NULL		DEFAULT 'Cliente/Sucursal Envio',
	FiscalRegimenCriterioProveedor	varchar(30)	NULL		DEFAULT 'Proveedor',
	
	SituacionesPorArea		bit		NULL		DEFAULT 0,

	ExportacionXML			bit		NULL		DEFAULT 0,
	ProdInterfazINFOR		bit		NULL		DEFAULT 0,

    eDoc					bit		NULL		DEFAULT 0, --MEJORA2104
    CFDFlex					bit		NULL		DEFAULT 0, --MEJORA2104    
    CFDI					bit		NULL		DEFAULT 0, --MEJORA2104    
    PCP						bit		NULL		DEFAULT 0, --MEJORA4722
    BloquearMovOtraFecha	bit		NULL		DEFAULT 1,
    
    SAUX					bit		NULL		DEFAULT 0,
    
    SubCuentaExplotarInformacion	bit		NULL		DEFAULT 0,
    MovPosicionAnterior				bit		NULL		DEFAULT 0,
    
    Notificacion					bit		NULL		DEFAULT 0, --MEJORA5066
    InterfazAspel				bit		NULL		DEFAULT 0,
    InterfazAspelNOI				bit		NULL		DEFAULT 0,
    InterfazAspelSAE				bit		NULL		DEFAULT 0,
    
    OpcionBloquearDescontinuado		bit		NULL		DEFAULT 0, --MEJORA5547

	InterfazEmida					bit		NOT NULL	DEFAULT 0, -- REQ12336
    InterfazTC						bit		NOT NULL	DEFAULT 0, -- REQ13163
    InterfazLDI						bit		NOT NULL	DEFAULT 0, -- REQ13386
    POS  						bit		NOT NULL	DEFAULT 0, -- REQ13393,
    eCommerce                                           bit             NOT NULL        DEFAULT 0,-- REQ13987   
	
	--REQ 13389
	UrlCRM							varchar(40) NULL,
	SincronizarClientesCRM			bit			NULL	DEFAULT 0,
	SincronizarProspectosCRM		bit			NULL	DEFAULT 0,
	InterfazDynamicsCRM				bit			NULL	DEFAULT 0,
	AnexosCloud				bit			NULL	DEFAULT 0,

	CONSTRAINT priEmpresaGral PRIMARY KEY  CLUSTERED (Empresa)
)
GO

if (select version from version) <= 1120
  UPDATE EmpresaGral 
     SET Mensaje1 = 'Empresa.Nombre',  Mensaje1Ancho = 200,
         Mensaje2 = 'Sucursal.Nombre', Mensaje2Ancho = 120,
         Mensaje3 = 'Usuario.Nombre',  Mensaje3Ancho = 120
GO
if not exists(select * from syscampo where tabla = 'EmpresaGral' and campo = 'CteExpressUsarPrefijoSucursal')
  ALTER TABLE EmpresaGral ADD CteExpressUsarPrefijoSucursal bit	NULL DEFAULT 1 WITH VALUES
if not exists(select * from syscampo where tabla = 'EmpresaGral' and campo = 'ArtExpressUsarPrefijoSucursal')
  ALTER TABLE EmpresaGral ADD ArtExpressUsarPrefijoSucursal bit	NULL DEFAULT 1 WITH VALUES
GO
EXEC spALTER_TABLE 'EmpresaGral', 'PC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ExpirarContrasenas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ExpirarDias', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Cambios', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'UsarConsecutivoSucursalDestino','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'UsarSucursalMovOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'NivelAcceso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CambiarFechaTrabajoAcceso', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Autotransportes', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Espacios', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteDatosPersonales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteDatosAseguradora', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'EspacioNombreSingular', 'varchar(50)	NULL DEFAULT "Espacio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'EspacioNombrePlural', 'varchar(50) NULL DEFAULT "Espacios" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'AdvertirProyectosExpirados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ArrastrarTipoCambioGenerarMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'UltimoCorteComisionesCobranza', 'datetime NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoConceptoGastos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoClaseConceptoGastos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteExpressCondicion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'Ford', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordDistribuidor', 'varchar(3) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordMercado', 'varchar(2) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordDirectorioEntrada', 'varchar(150) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordDirectorioSalida', 'varchar(150)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordDirectorioFBCM', 'varchar(150) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordMovCxcFactura', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordCliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordCtePrefijo', 'varchar(5) NULL DEFAULT "F" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordCteDigitos', 'int NULL DEFAULT 5 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_Oderep', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_PINS', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_Segundos', 'int NULL DEFAULT 60 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_DealerID', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_Password', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_DealerIDAlterno', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_PasswordAlterno', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ReabastecidoHasta', 'datetime NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'fixCancelarTraspasoSinTransito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordMovRemision', 'varchar(20) NULL DEFAULT "Entrada Compra" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordMovPedido', 'varchar(20)	NULL DEFAULT "Orden Compra" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordMovAvance', 'varchar(20)	NULL DEFAULT "Avance Compra" WITH VALUES'
GO
if (select version from version)<=2134
BEGIN
  EXEC("alter table EmpresaGral ALTER COLUMN FordDistribuidor varchar(3) NULL")
  EXEC("alter table EmpresaGral ALTER COLUMN FordMercado varchar(2) NULL")
END
GO
EXEC spALTER_TABLE 'EmpresaGral', 'CerrarSucursalAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CerrarSucursalSincro', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'DefEsDeducible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Intelisis', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContPersonalSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'NivelAccesoEsp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CR', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo1', 'int NULL DEFAULT 40 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo1Tasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo2', 'int NULL DEFAULT 80 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo2Tasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo3', 'int NULL DEFAULT 120 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordPlazo3Tasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'CerrarDia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoPartidasSinImporte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordTipoCosteoAutos', 'varchar(20) NULL  DEFAULT "Promedio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordTipoCosteoRefacciones', 'varchar(20) NULL DEFAULT "Promedio" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'SugerirConsecCentralizado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoConsolidacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoCteTipoFilial', 'varchar(20)	NULL DEFAULT "Filial" WITH VALUES'
GO
if not exists(select * FROM SysCampo WHERE Tabla = 'EmpresaCfg' AND Campo = 'CancelarFactura')
BEGIN
  EXEC spALTER_TABLE 'EmpresaCfg', 'CancelarFactura', 'varchar(20) NULL	DEFAULT "Cambio Mes" WITH VALUES'
  IF EXISTS(SELECT * FROM EmpresaGral WHERE Autotransportes = 1)
    EXEC ("UPDATE EmpresaCfg SET CancelarFactura = 'Cambio Dia'")
  ELSE
    EXEC ("UPDATE EmpresaCfg SET CancelarFactura = CASE WHEN CancelarOtroMesFactura = 1 THEN 'Cambio Mes' ELSE 'No' END")
END
GO

if (select version from version) <= 3223
BEGIN
  UPDATE EmpresaCfg SET CompraValidarPresupuestoMov = 'Orden Compra', CompraValidarPresupuesto = 'Si'
  WHERE CompraValidarPresupuesto = 'Orden Compra'
END

EXEC spALTER_TABLE 'EmpresaGral', 'eMailAutoAsunto', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'eMailAutoMensaje', 'text NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoChequesMultiContacto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'UltimoPagoCostoPiso', 'datetime NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ConceptoGastoCostoPiso', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'AcreedorISAN', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ConceptoISAN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordComisionVentasCasa', 'money NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordComisionComprasUsados', 'money NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'Volvo', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordUtilidadTraspaso', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordUtilidadTraspasoOrigen', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordUtilidadTraspasoDestino', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordRetencionUsadosTope', 'money NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordRetencionUsados', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'MovCB', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'RSReportASPX', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoCancelarMismoMes','bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordValidarOASIS', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordValidarHojaServicio', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordEmpresaComisiones', 'varchar(10) NULL DEFAULT "(Misma)" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordOASIS', 'varchar(150) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ContXFacturasPendientes', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if not exists(select * from syscampo where tabla = 'EmpresaGral' and campo = 'CostoPisoPlazo1')
begin
  EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoPlazo1', 'int NULL DEFAULT 40 WITH VALUES'
  EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoPlazo2', 'int NULL DEFAULT 80 WITH VALUES'
  EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoPlazo3', 'int NULL DEFAULT 120 WITH VALUES'
  EXEC("UPDATE EmpresaGral SET CostoPisoPlazo1 = FordPlazo1, CostoPisoPlazo2 = FordPlazo2, CostoPisoPlazo3 = FordPlazo3")
end
GO
EXEC spALTER_TABLE 'EmpresaGral', 'FechaInicioCostoPiso', 'varchar(20) NULL DEFAULT "Fecha Entrada" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Chrysler', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoUsados', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoUsadosTasa', 'float NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'CostoPisoUsadosDiasLibres', 'int NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ChryslerCliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordCredit', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'AC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'eCollaboration', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ConsolidacionEmpresas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CfgRegistro', 'int NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'AutoAsignarMovSucursalAlmacen', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'PermitirMovSucursalDiferente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ValidarRegistros', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'DirectorioPlantillasOffice', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'eCollaboration2Capas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordX_DesacopladorIP', 'varchar(15) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'WMS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContXCancelarMismoMes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'SistemaDetallista', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Capital', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteCtoApellidos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContabilizarMesesFuturos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'NomAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'GRP', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'GRPRamo', 'char(1) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'GRPUnidad', 'varchar(4) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'GRPCuota', 'money NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ContXMovimientosEspecificos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FordUDIMov', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FordUDIArticulo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'Registro', 'bit NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'InfoPath', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContAutoEliminarCCNoReq', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FEA', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FEAVersion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FEAWebService', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FEACertificado', 'varchar(100) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'FEAEnLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'PM', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'HorasDia', 'float NULL DEFAULT 8.0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Interfactura', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'InterfacturaRI', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'EDIIdentificador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'EDICalificador', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'EDIArtIdioma', 'varchar(2) NULL	DEFAULT "ES" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContSocios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'RS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Hasp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ContXUniDireccional', 'bit NULL DEFAULT 1 WITH VALUES'
GO
if (select version from version)<=3261
  UPDATE EmpresaGral SET ContXUniDireccional = 1
GO
EXEC spALTER_TABLE 'EmpresaGral', 'CRM', 'bit NULL DEFAULT 0 WITH VALUES'

--REQ16092
EXEC spALTER_TABLE 'EmpresaGral', 'OPORT', 'bit NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'EmpresaGral', 'Gestion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'BPlanAgrupadorArt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'BPlanAgrupadorPersonal', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'BPlanMesPeriodo1', 'int NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressDef', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressPrefijo', 'varchar(5) NULL DEFAULT "A" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressUsarPrefijoSucursal', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressDigitos', 'int NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressCategoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ProvExpressCondicion', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'CamposExtras', 'varchar(20) NULL DEFAULT "Caracteristicas" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'DefUsuario', 'varchar(10) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL1', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL2', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL3', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL4', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'Menu', 'varchar(50) NULL'
GO
EXEC spRENAME_COLUMN 'EmpresaGral', 'WSDL_RecibirForma', 'URL_RecibirForma'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'URL_RecibirForma', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'DirectorioAnexosEsp', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'RecibirFormaHTML', 'text NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL_Logo', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'DBMailPerfil', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'PACTO', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'VerMovAgrupadores', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'MAF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'VIC', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=3192
BEGIN
  EXEC("spEliminarPK 'EmpresaGral'")	
  EXEC("spALTER_COLUMN 'EmpresaGral' ,'Empresa', 'varchar(5) NOT NULL'")  
  EXEC("ALTER TABLE EmpresaGral ADD CONSTRAINT priEmpresaGral PRIMARY KEY CLUSTERED (Empresa)")
END
GO

EXEC spALTER_TABLE 'EmpresaGral', 'ProdInterfazINFOR', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'eDoc', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaGral', 'CFDFlex', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaGral', 'CFDI', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA2104
EXEC spALTER_TABLE 'EmpresaGral', 'Notificacion', 'bit NULL DEFAULT 0' --MEJORA5066
GO
EXEC spALTER_TABLE 'EmpresaGral', 'OpcionBloquearDescontinuado', 'bit NULL DEFAULT 0' --MEJORA5547
GO

EXEC spALTER_COLUMN 'EmpresaGral' ,'EmpresaDinero', 'varchar(5) NULL', '"Misma"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'EmpresaCont', 'varchar(5) NULL', '"Misma"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'DiasHabiles', 'varchar(10) NULL', '"Lin-Vie"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'ClaveDesarrollo', 'varchar(20) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'AlmacenTransito', 'varchar(20) NULL','"(TRANSITO)"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'AlmacenGarantias', 'varchar(20) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'DefArtTipo', 'varchar(20) NULL','"Normal"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'DefUnidad', 'varchar(20) NULL','"Piezas"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'CteExpressDef', 'varchar(20) NULL','"(CONSECUTIVO)"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'CteExpressPrefijo', 'varchar(5) NULL','"C"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'ArtExpressDef', 'varchar(20) NULL','"(CONSECUTIVO)"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'ArtExpressPrefijo', 'varchar(5) NULL','"A"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordDistribuidor', 'varchar(3) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordMercado', 'varchar(2) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordCtePrefijo', 'varchar(5) NULL','"F"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordTipoCosteoAutos', 'varchar(20) NULL','"Promedio"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordTipoCosteoRefacciones', 'varchar(20) NULL','"Promedio"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordUtilidadTraspasoOrigen', 'varchar(10) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordUtilidadTraspasoDestino', 'varchar(10) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'FordEmpresaComisiones', 'varchar(10) NULL','"(Misma)"'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'GRPRamo', 'varchar(1) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'GRPUnidad', 'varchar(4) NULL'  
EXEC spALTER_COLUMN 'EmpresaGral' ,'EDIArtIdioma', 'varchar(2) NULL','"ES"'  
EXEC spALTER_COLUMN 'EmpresaGral', 'ProvExpressDef', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaGral', 'ProvExpressPrefijo', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'EmpresaGral', 'ProvExpressPrefijo', 'varchar(5) NULL','"A"' 
GO

--BUG22313
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
GO

-- 11464
EXEC spALTER_TABLE 'EmpresaGral', 'MovSituacionBinaria', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--REQ 13389
EXEC spALTER_TABLE 'EmpresaGral', 'UrlCRM', 'varchar(40) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'SincronizarClientesCRM', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'SincronizarProspectosCRM', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazDynamicsCRM', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

if (select version from version)<=2901
  UPDATE EmpresaGral 
     SET RecibirFormaHTML = '
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
  </head>
  <body>
    <div><img alt="" hspace="0" src="Logo.jpg" align="baseline" border="0" /></div>
    <div>&nbsp;</div>
    <div><strong><font size="5">{_Ok}</font></strong></div>
    <div><font size="6">{_OkDesc}</font></div>
    <div>
      <div><font size="6">{_OkRef}</font></div>
    </div>
    <div><font size="6">&nbsp;</font></div>
  </body>
</html>'
GO
if not exists(select * from syscampo where tabla = 'EmpresaGral' and campo='PPTO')
begin
  EXEC spALTER_TABLE 'EmpresaGral', 'PPTO', 'bit NULL DEFAULT 0'
  EXEC('UPDATE EmpresaGral SET PPTO = GRP')
END
EXEC spALTER_TABLE 'EmpresaGral', 'PPTOVentas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'OFER', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CMP', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spRENAME_COLUMN 'EmpresaGral', 'Riesgos', 'ARO'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'ARO', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'AGD', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CostoBase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'URL_Imagenes', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'ProspectoExpressPagina', 'varchar(20) NULL'
GO
EXEC spRENAME_COLUMN 'EmpresaGral', 'FIS', 'Fiscal'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'Fiscal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'Corte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'MovConcurrente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'DiasMes', 'float NULL DEFAULT 30.0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'IntelisisServiceWSDL', 'varchar(255)	NULL'
EXEC spALTER_TABLE 'EmpresaGral', 'IntelisisServiceComprimir', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'IntelisisServiceEncriptar', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CerrarDiaAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteUsoServicio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CteUsoServicioEvaluacion', 'varchar(20) NULL'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'CAPT', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'GES', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'SubFoliosOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'SubFoliosOrigenSeparador', 'varchar(10) NULL DEFAULT "-" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CopiarBitacoraOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'CP', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=3175
  UPDATE EmpresaGral SET SubFoliosOrigenSeparador = '-'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'DefContrasenaModificar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'TipoImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'FiscalRegimenCriterioEmpresa', 'varchar(30) NULL DEFAULT "Empresa/Sucursal" WITH VALUES'		-- Empresa, Sucursal, Empresa/Sucursal
EXEC spALTER_TABLE 'EmpresaGral', 'FiscalRegimenCriterioCliente', 'varchar(30) NULL DEFAULT "Cliente/Sucursal Envio" WITH VALUES'	-- Cliente, Sucursal Envio, Cliente/Sucursal Envio
EXEC spALTER_TABLE 'EmpresaGral', 'FiscalRegimenCriterioProveedor', 'varchar(30) NULL DEFAULT "Proveedor" WITH VALUES'			-- Proveedor
EXEC spALTER_TABLE 'EmpresaGral', 'SituacionesPorArea', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaGral', 'ExportacionXML', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'PCP', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA4722
GO
EXEC spALTER_TABLE 'EmpresaGral', 'BloquearMovOtraFecha', 'bit NULL DEFAULT 1 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'SAUX', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'SubCuentaExplotarInformacion', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'EmpresaGral', 'MovPosicionAnterior', 'bit NULL DEFAULT 0 WITH VALUES'
GO


EXEC spALTER_TABLE 'EmpresaGral', 'InterfazAspel', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazAspelNOI', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazAspelSAE ', 'bit NULL DEFAULT 0 WITH VALUES'
GO

-- REQ12336
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazEmida', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

-- REQ13163
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazTC', 'bit NOT NULL DEFAULT 0'
GO

--REQ13386
EXEC spALTER_TABLE 'EmpresaGral', 'InterfazLDI','bit NULL DEFAULT 0 WITH VALUES'
--REQ13393
EXEC spALTER_TABLE 'EmpresaGral', 'POS','bit NULL DEFAULT 0 WITH VALUES'

-- REQ13987
Exec spAlter_Table 'EmpresaGral','eCommerce',' bit NULL DEFAULT 0'

EXEC spFK 'EmpresaGral','FordCliente','Cte','Cliente'
EXEC spFK 'EmpresaGral','FordCredit','Prov','Proveedor'
GO

--REQ16092
EXEC spALTER_TABLE 'EmpresaGral', 'OPORT', 'bit NULL DEFAULT 0 WITH VALUES'
GO

EXEC spALTER_TABLE 'EmpresaGral', 'AnexosCloud', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ25014
EXEC spALTER_TABLE 'EmpresaGral', 'ContabilidadParalela', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--DSG
EXEC spALTER_TABLE 'EmpresaGral', 'NominaG4', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO
--DSG
EXEC spALTER_TABLE 'EmpresaGral', 'eCommerce', 'int NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaGralC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaGralC
GO
CREATE TRIGGER tgEmpresaGralC ON EmpresaGral
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE	@EmpresaI		varchar(5),
		@EmpresaD		varchar(5)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @EmpresaI = Empresa FROM Inserted
  SELECT @EmpresaD = Empresa FROM Deleted

  IF UPDATE(AC)
  BEGIN
     IF (SELECT AC FROM Inserted) = 1
     BEGIN
      if not exists(select * from MovTipo WHERE Modulo = 'CXC' AND Mov = 'Documento Factoraje') INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXC', 4000, 'Documento Factoraje', 'CXC.F',  'CXC', 'Documento Factoraje')
      if not exists(select * from MovTipo WHERE Modulo = 'CXC' AND Mov = 'Prestamo Factoraje')  INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXC', 4010, 'Prestamo Factoraje',  'CXC.F',  'CXC', 'Prestamo Factoraje')
      if not exists(select * from MovTipo WHERE Modulo = 'CXC' AND Mov = 'Disposicion')         INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXC', 4020, 'Disposicion',         'CXC.CAP','CXC', 'Disposicion')
      if not exists(select * from MovTipo WHERE Modulo = 'CXC' AND Mov = 'Back to Back')        INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXC', 4030, 'Back to Back',        'CXC.CAP','CXC', 'Back to Back')
      if not exists(select * from MovTipo WHERE Modulo = 'CXP' AND Mov = 'Documento Factoraje') INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXP', 4000, 'Documento Factoraje', 'CXP.F',  'CXP', 'Documento Factoraje')
      if not exists(select * from MovTipo WHERE Modulo = 'CXP' AND Mov = 'Prestamo Factoraje')  INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXP', 4010, 'Prestamo Factoraje',  'CXP.F',  'CXP', 'Prestamo Factoraje')
      if not exists(select * from MovTipo WHERE Modulo = 'CXP' AND Mov = 'Fondeo')              INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXP', 4020, 'Fondeo',              'CXP.CAP','CXP', 'Fondeo')
      if not exists(select * from MovTipo WHERE Modulo = 'CXP' AND Mov = 'Fondeo Anticipado')   INSERT MovTipo (Modulo, Orden, Mov, Clave, ConsecutivoModulo, ConsecutivoMov) VALUES ('CXP', 4040, 'Fondeo Anticipado',   'CXP.F',  'CXP', 'Fondeo Anticipado')
     END
  END

  IF UPDATE(MAF)
  BEGIN
    IF (SELECT MAF FROM Inserted) = 1 --ARCC GESTION
    BEGIN     	
      IF NOT EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.SI') INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('GES',	'Solicitud Inspeccion',		'GES.SRES',	'MAF.SI')
      IF NOT EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.I')  INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('GES',	'Inspeccion',			'GES.RES',	'MAF.I') 
      IF NOT EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.S')  INSERT MovClave (Modulo, NombreOmision, SubClaveDe, Clave) values ('VTAS',	'Servicio AF',			'VTAS.S',	'MAF.S')

      IF NOT EXISTS(SELECT * FROM movtipo WHERE modulo = 'GES' AND  Mov = 'Solicitud Inspeccion') INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('GES',	970,	'Solicitud Inspeccion',		'GES.SRES',	'MAF.SI',	'GES',   'Solicitud Inspeccion')
      IF NOT EXISTS(SELECT * FROM movtipo WHERE modulo = 'GES' AND  Mov = 'Inspeccion')           INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('GES',	980,	'Inspeccion',			'GES.RES',      'MAF.I',	'GES',   'Inspeccion')
      IF NOT EXISTS(SELECT * FROM movtipo WHERE modulo = 'VTAS' AND Mov = 'Servicio AF')          INSERT MovTipo (Modulo, Orden, Mov, Clave, SubClave, ConsecutivoModulo, ConsecutivoMov) values ('VTAS',	990,	'Servicio AF',			'VTAS.S',       'MAF.S',	'VTAS',  'Servicio AF')
     	
      IF NOT EXISTS(SELECT * FROM CfgMovFlujo WHERE modulo = 'GES' AND Orden = 1 AND OMov = 'Solicitud Inspeccion' AND DMov = 'Inspeccion') INSERT CfgMovFlujo (Modulo, Orden, OMov, DMov, Nombre) VALUES ('GES', 1, 'Solicitud Inspeccion',	'Inspeccion',			'Aceptar Inspeccion')
    END

    IF (SELECT MAF FROM Inserted) = 0 --ARCC GESTION
    BEGIN     	
      IF NOT EXISTS(SELECT * FROM Gestion g JOIN MovTipo mt ON mt.Modulo = 'GES' AND mt.Mov = g.Mov WHERE mt.SubClave IN ('MAF.SI','MAF.I')) AND
         NOT EXISTS(SELECT * FROM Venta v JOIN MovTipo mt ON mt.Modulo = 'VTAS' AND mt.Mov = v.Mov WHERE mt.SubClave IN ('MAF.S'))   
      BEGIN
        IF EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.SI') DELETE FROM MovClave WHERE Clave = 'MAF.SI'
        IF EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.I')  DELETE FROM MovClave WHERE Clave = 'MAF.I'
        IF EXISTS(SELECT * FROM MovClave WHERE Clave = 'MAF.S')  DELETE FROM MovClave WHERE Clave = 'MAF.S'

        IF EXISTS(SELECT * FROM movtipo WHERE modulo = 'GES'  AND  Mov = 'Solicitud Inspeccion') DELETE FROM MovTipo WHERE Modulo = 'GES'  AND Mov = 'Solicitud Inspeccion'
        IF EXISTS(SELECT * FROM movtipo WHERE modulo = 'GES'  AND  Mov = 'Inspeccion')           DELETE FROM MovTipo WHERE Modulo = 'GES'  AND Mov = 'Inspeccion'
        IF EXISTS(SELECT * FROM movtipo WHERE modulo = 'VTAS' AND Mov = 'Servicio AF')           DELETE FROM MovTipo WHERE Modulo = 'VTAS' AND Mov = 'Servicio AF'
     	
        IF EXISTS(SELECT * FROM CfgMovFlujo WHERE modulo = 'GES' AND Orden = 1 AND OMov = 'Solicitud Inspeccion' AND DMov = 'Inspeccion' AND Nombre = 'Aceptar Inspeccion') DELETE FROM CfgMovFlujo WHERE modulo = 'GES' AND Orden = 1 AND OMov = 'Solicitud Inspeccion' AND DMov = 'Inspeccion' AND Nombre = 'Aceptar Inspeccion'
      END
    END
  END
  
  IF UPDATE(VIC)
  BEGIN
    IF (SELECT VIC FROM Inserted) = 1 --VIC
    BEGIN     	
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.CR')  INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.CR', 'Contrato Renta', 'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.CV')  INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.CV', 'Contrato Venta', 'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.CM')  INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.CM', 'Contrato Compra', 'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.CS')  INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.CS', 'Contrato Cosociedad', 'CONCLUIDO',    'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.INV') INSERT INTO MovClave (Modulo,  Clave,       NombreOmision,        EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.INV', 'Contrato Inversion', 'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.ARR') INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.ARR', 'Arrendamiento', 'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.O')   INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.O', 'Orden Compra',    'CONCLUIDO',         'PACTO.C')
      IF NOT EXISTS(SELECT 1 FROM MovClave WHERE Modulo='PACTO' AND Clave='VIC.MA')  INSERT INTO MovClave (Modulo,  Clave,      NombreOmision,    EstatusContabilizar, SubClaveDe) VALUES ('PACTO', 'VIC.MA', 'Mantenimiento',    'CONCLUIDO',       'PACTO.C')


      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Arrendamiento' AND Modulo = 'PACTO')       INSERT INTO MovTipo (Modulo,  Mov,             Orden, Clave,     SubClave,    ConsecutivoModulo, ConsecutivoMov,  Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)            VALUES ('PACTO', 'Arrendamiento', 300,   'PACTO.C', 'VIC.ARR',   'PACTO',           'Arrendamiento', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Compra' AND Modulo = 'PACTO')     INSERT INTO MovTipo (Modulo,  Mov,               Orden, Clave,     SubClave,   ConsecutivoModulo, ConsecutivoMov,    Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)         VALUES ('PACTO', 'Contrato Compra', 310,   'PACTO.C', 'VIC.CM',   'PACTO',           'Contrato Compra', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Cosociedad' AND Modulo = 'PACTO') INSERT INTO MovTipo (Modulo,  Mov,                   Orden, Clave,     SubClave,   ConsecutivoModulo, ConsecutivoMov,        Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo) VALUES ('PACTO', 'Contrato Cosociedad', 320,   'PACTO.C', 'VIC.CS',   'PACTO',           'Contrato Cosociedad', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Inversion' AND Modulo = 'PACTO')  INSERT INTO MovTipo (Modulo,  Mov,                  Orden, Clave,     SubClave,    ConsecutivoModulo, ConsecutivoMov,       Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)  VALUES ('PACTO', 'Contrato Inversion', 330,   'PACTO.C', 'VIC.INV',   'PACTO',           'Contrato Inversion', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Renta' AND Modulo = 'PACTO')      INSERT INTO MovTipo (Modulo,  Mov,              Orden, Clave,     SubClave,   ConsecutivoModulo, ConsecutivoMov,   Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)           VALUES ('PACTO', 'Contrato Renta', 340,   'PACTO.C', 'VIC.CR',   'PACTO',           'Contrato Renta', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Venta' AND Modulo = 'PACTO')      INSERT INTO MovTipo (Modulo,  Mov,              Orden, Clave,     SubClave,   ConsecutivoModulo, ConsecutivoMov,   Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)           VALUES ('PACTO', 'Contrato Venta', 350,   'PACTO.C', 'VIC.CV',   'PACTO',           'Contrato Venta', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Mantenimiento' AND Modulo = 'PACTO')       INSERT INTO MovTipo (Modulo,  Mov,             Orden, Clave,     SubClave,    ConsecutivoModulo, ConsecutivoMov,  Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)            VALUES ('PACTO', 'Mantenimiento', 360,   'PACTO.C', 'VIC.MA',    'PACTO',           'Mantenimiento', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',     'Modulo')
      IF NOT EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Orden Compra' AND Modulo = 'PACTO')        INSERT INTO MovTipo (Modulo,  Mov,            Orden, Clave,     SubClave,  ConsecutivoModulo, ConsecutivoMov, Grupo, Icono, Factor, ConsecutivoPorEmpresa, AfectarPresupuesto, ProyectoSugerir, TipoConsecutivo)                VALUES ('PACTO', 'Orden Compra', 370,   'PACTO.C', 'VIC.O',   'PACTO',           'Orden Compra', NULL,  NULL,  1,      'Si',                  '(por Omision)',    'Movimiento',    'Modulo')
     	
    END
    IF (SELECT VIC FROM Inserted) = 0 --VIC
    BEGIN 
      IF NOT EXISTS(SELECT * FROM Contrato p JOIN MovTipo mt ON mt.Modulo = 'PACTO' AND mt.Mov = p.Mov WHERE mt.SubClave IN ('VIC.CR','VIC.CV','VIC.CM','VIC.CS','VIC.INV','VIC.ARR','VIC.O','VIC.MA')) 	    	
      BEGIN
        IF EXISTS(SELECT * FROM MovClave WHERE Clave IN ('VIC.CR','VIC.CV','VIC.CM','VIC.CS','VIC.INV','VIC.ARR','VIC.O','VIC.MA')) DELETE FROM MovClave WHERE Clave IN ('VIC.CR','VIC.CV','VIC.CM','VIC.CS','VIC.INV','VIC.ARR','VIC.O','VIC.MA')

        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Arrendamiento' AND Modulo = 'PACTO')       DELETE FROM MovTipo WHERE Mov = 'Arrendamiento' AND Modulo = 'PACTO'
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Compra' AND Modulo = 'PACTO')     DELETE FROM MovTipo WHERE Mov = 'Contrato Compra' AND Modulo = 'PACTO'
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Cosociedad' AND Modulo = 'PACTO') DELETE FROM MovTipo WHERE Mov = 'Contrato Cosociedad' AND Modulo = 'PACTO'          
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Inversion' AND Modulo = 'PACTO')  DELETE FROM MovTipo WHERE Mov = 'Contrato Inversion' AND Modulo = 'PACTO'           
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Renta' AND Modulo = 'PACTO')      DELETE FROM MovTipo WHERE Mov = 'Contrato Renta' AND Modulo = 'PACTO'                   
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Contrato Venta' AND Modulo = 'PACTO')      DELETE FROM MovTipo WHERE Mov = 'Contrato Venta' AND Modulo = 'PACTO'                   
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Mantenimiento' AND Modulo = 'PACTO')       DELETE FROM MovTipo WHERE Mov = 'Mantenimiento' AND Modulo = 'PACTO'                     
        IF EXISTS (SELECT 1 FROM MovTipo WHERE Mov = 'Orden Compra' AND Modulo = 'PACTO')        DELETE FROM MovTipo WHERE Mov = 'Orden Compra' AND Modulo = 'PACTO'                       
      END
    END
  END
    
END
GO

/**************** tgInforEmpresaCfgBC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforEmpresaCfgBC') and sysstat & 0xf = 8) drop trigger dbo.tgInforEmpresaCfgBC
GO
--CREATE TRIGGER tgInforEmpresaCfgBC ON EmpresaCfg
----//WITH ENCRYPTION
--FOR UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa							varchar(20),
--   @ReferenciaIntelisisService			varchar(50)	

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID
--  SET @Estatus = 'CAMBIO'
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa

 
--  IF   UPDATE(ContMoneda)  AND  @ProdInterfazINFOR = 1
 
--  BEGIN
--   EXEC spInforGenerarSolicitudEmpresa  @Empresa,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--  END
--END
--GO

/**************** tgEmpresaCfgABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaCfgABC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaCfgABC
GO
CREATE TRIGGER tgEmpresaCfgABC ON EmpresaCfg
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
  @EmpresaN						varchar(10),
  @TieneAuxiliares				bit,
  @MonedaCosteoA				varchar(10),
  @TipoCosteoA					varchar(20),
  @CosteoNivelSubCuentaA		bit,
  @CosteoLotesA					bit,
  @CosteoSeriesA				bit,
  @CosteoMultipleSimultaneoA	bit,
  @MonedaCosteoN				varchar(10),
  @TipoCosteoN					varchar(20),
  @CosteoNivelSubCuentaN		bit, 
  @CosteoLotesN					bit,
  @CosteoSeriesN				bit,
  @CosteoMultipleSimultaneoN	bit,
  @CambioCfgCosteo				bit,
  @OkRef						varchar(255),
  @Preconfigurado				bit,
  @FormacosteoA					varchar(20),
  @FormacosteoN					varchar(20)

  SELECT @Preconfigurado = Preconfigurado FROM Version 

  SELECT @FormacosteoA=FormaCosteo,@MonedaCosteoA =MonedaCosteo, @TipoCosteoA = TipoCosteo, @CosteoNivelSubCuentaA = CosteoNivelSubCuenta, @CosteoLotesA = CosteoLotes, @CosteoSeriesA = CosteoSeries, @CosteoMultipleSimultaneoA = CosteoMultipleSimultaneo FROM DELETED
  SELECT @FormacosteoN=FormaCosteo,@EmpresaN = Empresa, @MonedaCosteoN =MonedaCosteo, @TipoCosteoN = TipoCosteo, @CosteoNivelSubCuentaN = CosteoNivelSubCuenta, @CosteoLotesN = CosteoLotes, @CosteoSeriesN = CosteoSeries, @CosteoMultipleSimultaneoN = CosteoMultipleSimultaneo FROM INSERTED
  IF @Preconfigurado = 1
  BEGIN
    IF EXISTS (SELECT ID FROM AuxiliarU WHERE Empresa = @EmpresaN) SELECT @TieneAuxiliares = 1 
    IF (@MonedaCosteoA <> @MonedaCosteoN)							SELECT @CambioCfgCosteo =1, @okREf = 'Moneda Costeo' ELSE
    IF (@TipoCosteoA <> @TipoCosteoN)								SELECT @CambioCfgCosteo =1, @okREf = 'Tipo Costeo' ELSE
    IF (@CosteoNivelSubCuentaA <> @CosteoNivelSubCuentaN)			SELECT @CambioCfgCosteo =1, @okREf = 'Costeo Nivel Opción' ELSE
    IF (@CosteoLotesA <> @CosteoLotesN)							SELECT @CambioCfgCosteo =1, @okREf = 'Costeo Por Lotes' ELSE
    IF (@CosteoSeriesA <> @CosteoSeriesN)							SELECT @CambioCfgCosteo =1, @okREf = 'Costeo Por Series' ELSE
    IF (@CosteoMultipleSimultaneoA <> @CosteoMultipleSimultaneoN) SELECT @CambioCfgCosteo =1, @okREf = 'Costeo Multiple Simultaneo'
    IF (@FormacosteoA <> @FormacosteoN)							  SELECT @CambioCfgCosteo =1, @okREf = 'Forma Costeo '

    SELECT @OkRef = 'Ya Existen Auxiliares. No Puede Modificar la Configuración '+@OkRef
    IF @TieneAuxiliares = 1 AND @CambioCfgCosteo = 1
      RAISERROR (@OkRef,16,-1) 
  END 

END
GO

/****** Configuracion de la Empresa por Modulo ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgModulo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgModulo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgModulo') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgModulo (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,

	EditarConsec			char(2)		NULL DEFAULT 'No',
	Situaciones			char(2)		NULL DEFAULT 'No',
	Tiempos				char(2)		NULL DEFAULT 'No',
	ContXGenerar			char(20)	NULL DEFAULT 'No',
	ValidarFechas			char(20)	NULL DEFAULT 'No',
	PeriodosEspeciales		char(2)		NULL DEFAULT 'No',
	FechaEmision			char(20)	NULL DEFAULT 'Cliente',
	FlujoAbierto			char(2)		NULL DEFAULT 'No',
	TipoCambio			varchar(20)	NULL DEFAULT 'General',

	CONSTRAINT priEmpresaCfgModulo PRIMARY KEY  CLUSTERED (Empresa, Modulo)
)
GO
EXEC spALTER_TABLE 'EmpresaCfgModulo', 'FechaEmision', 'char(20) NULL DEFAULT "Cliente" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgModulo', 'FlujoAbierto', 'char(2)	 NULL DEFAULT "No" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgModulo', 'TipoCambio', 'varchar(20) NULL DEFAULT "General" WITH VALUES'
GO
/****** Configuracion de la Empresa por Modulo Excepciones para la Vaidacion de Fechas ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgValidarFechasEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgValidarFechasEx','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgValidarFechasEx') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgValidarFechasEx (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgValidarFechasEx PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

/****** Configuracion de la Empresa por Modulo (Cancelar Movimientos en Periodos Cerrados) ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgCancelarMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgCancelarMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgCancelarMov') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgCancelarMov (
	Empresa 	char(5)  	NOT NULL,
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,

	CONSTRAINT priEmpresaCfgCancelarMov PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

/****** Orden Aplicacion Sugerida ******/
if not exists(select * from SysTabla where SysTabla = 'CfgAplicaOrden')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgAplicaOrden','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgAplicaOrden') and type = 'U') 
CREATE TABLE dbo.CfgAplicaOrden (
	Modulo		char(5)		NOT NULL,
	Mov		char(20)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priCfgAplicaOrden PRIMARY KEY  CLUSTERED (Modulo, Mov)
)
GO


/****** Conceptos por Omision de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaConcepto')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaConcepto','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaConcepto') and type = 'U') 
CREATE TABLE dbo.EmpresaConcepto (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				char(20)	NOT NULL,
	Concepto			varchar(50)	NULL,
	Requerido			bit		NOT NULL 	DEFAULT 0,
	UtilizarEste			bit		NOT NULL 	DEFAULT 0,

	Logico1				bit		NOT NULL 	DEFAULT 0,
	Logico2				bit		NOT NULL 	DEFAULT 0,
	Logico3				bit		NOT NULL 	DEFAULT 0,

	CONSTRAINT priEmpresaConcepto PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

/****** Conceptos Validados de la Empresa ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaConceptoValidar')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaConceptoValidar','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaConceptoValidar') and type = 'U') 
CREATE TABLE dbo.EmpresaConceptoValidar (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				char(20)	NOT NULL,
	Concepto			varchar(50)	NOT NULL,
	CR				bit		NULL	DEFAULT 0,

	CONSTRAINT priEmpresaConceptoValidar PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov, Concepto)
)
GO
EXEC spALTER_TABLE 'EmpresaConceptoValidar', 'CR', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spFK2 'EmpresaConceptoValidar','Modulo','Concepto','Concepto','Modulo','Concepto'
GO

/****** EmpresaPedidosReservarEsp ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaPedidosReservarEsp')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaPedidosReservarEsp','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaPedidosReservarEsp') and type = 'U') 
CREATE TABLE dbo.EmpresaPedidosReservarEsp (
	Empresa 			char(5)  	NOT NULL,
	Modulo				char(5)		NOT NULL,
	Mov				char(20)	NOT NULL,

	CONSTRAINT priEmpresaPedidosReservarEsp PRIMARY KEY  CLUSTERED (Empresa, Modulo, Mov)
)
GO

/****** EmpresaCfgAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgAcceso')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgAcceso') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgAcceso (
  Empresa 			char(5) 	NOT NULL,

  LogoEmpresa 			varchar(255) 	NULL,
  MostrarMensajes		bit 		NULL	DEFAULT 0,
  MostrarLeyendaCumpleanos	bit 		NULL	DEFAULT 1,
  NombreAnexoFotoEmpleado 	varchar(50) 	NULL	DEFAULT 'Foto',
  LeyendaCumpleanos		varchar(50) 	NULL	DEFAULT '¡ Feliz Cumpleaños !',
  VerCodigo 			bit 		NULL	DEFAULT 1,
  EstirarFoto 			bit 		NULL	DEFAULT 0,
  ColorEstatusBaja		Int 		NULL	DEFAULT 255,
  ColorFuenteEstatusBaja	Int 		NULL	DEFAULT 65535,
  ColorEntrada			Int 		NULL	DEFAULT 12639424,
  ColorSalida			Int 		NULL	DEFAULT 8454143,
  ColorAlterno			Int 		NULL	DEFAULT 16776960,
  EtiquetaCodigo 		varchar(50) 	NULL	DEFAULT '&Código',
  EtiquetaNombre 		varchar(50) 	NULL,
  EtiquetaCampoPrincipal	varchar(50) 	NULL,
  EtiquetaCampoSecundario	varchar(50) 	NULL,
  EtiquetaExtra1 		varchar(50) 	NULL,
  EtiquetaExtra2 		varchar(50) 	NULL,
  EtiquetaExtra3 		varchar(50) 	NULL,
  EtiquetaExtra4 		varchar(50) 	NULL,
  CampoPrincipal		varchar(50) 	NULL,
  CampoSecundario		varchar(50) 	NULL,
  CampoExtra1 			varchar(50) 	NULL,
  CampoExtra2 			varchar(50) 	NULL,
  CampoExtra3 			varchar(50) 	NULL,
  CampoExtra4 			varchar(50) 	NULL,
  TiempoEspera 			int 		NULL 	DEFAULT 10,
  InterfaseMonitor		bit		NULL	DEFAULT 0,
  InterfaseTipo			varchar(20)	NULL,	-- Archivo 
  InterfaseRuta			varchar(255)	NULL,
  InterfaseHardware		varchar(50)	NULL,	-- Hand Punch
  RegistroMovSucursal		bit		NULL	DEFAULT 0,
  HoraCambioJornada		char(5)		NULL,

	CONSTRAINT priEmpresaCfgAcceso PRIMARY KEY CLUSTERED (Empresa)
)
GO
if not exists(select * from syscampo where Tabla = 'EmpresaCfgAcceso' and Campo = 'TiempoEspera')
  ALTER TABLE EmpresaCfgAcceso ADD TiempoEspera int NULL DEFAULT 10 WITH VALUES
GO
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'InterfaseMonitor', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'InterfaseTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'InterfaseRuta', 'varchar(255) NULL'
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'InterfaseHardware', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'RegistroMovSucursal', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgAcceso', 'HoraCambioJornada', 'char(5) NULL'
GO


/****** EmpresaCfgPV ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPV')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPV','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPV') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPV (
  Empresa 			char(5) 	NOT NULL,

  LogoEmpresa 			varchar(255) 	NULL,
  Mov				varchar(20)	NULL	DEFAULT 'Nota',
  MovServicios			varchar(20)	NULL	DEFAULT 'Nota',
  Cliente 			char(10) 	NULL,
  Almacen 			char(10) 	NULL,
  Agente 			char(10) 	NULL,
  Moneda 			char(10) 	NULL,
  Proyecto 			varchar(50) 	NULL,
  Concepto 			varchar(50) 	NULL,
  Descuento			varchar(30) 	NULL,
  ListaPreciosEsp		varchar(50) 	NULL	DEFAULT '(Precio Lista)',
  DefaultUsuario		bit 	 	NULL	DEFAULT 0,
  MostrarImpuestos 		bit 	 	NULL	DEFAULT 0,
  DesglosarImpuestos 		bit 	 	NULL	DEFAULT 0,
  MostrarAnuncios 		bit 	 	NULL	DEFAULT 0,
  MostrarFotoArticulo 		bit 	 	NULL	DEFAULT 0,
  NombreAnexoFotoArticulo 	varchar(50) 	NULL	DEFAULT 'Foto',
  VerCodigo 			bit  		NULL	DEFAULT 1,
  CantidadIndependiente		bit 		NULL	DEFAULT 0,
  PrecioIndependiente		bit 		NULL	DEFAULT 0,
  ConsultarArtDisponible	bit 		NULL	DEFAULT 0,
  TiraContinua 			bit 	 	NULL	DEFAULT 0,
  EstirarFoto 			bit 	 	NULL	DEFAULT 0,  
  EtiquetaCodigo 		varchar(50) 	NULL	DEFAULT '&Código',
  EtiquetaDescripcion 		varchar(50) 	NULL,
  EtiquetaPrecio 		varchar(50) 	NULL	DEFAULT 'Precio',
  EtiquetaDescuento 		varchar(50) 	NULL	DEFAULT 'Descuento',
  EtiquetaSubTotal 		varchar(50) 	NULL	DEFAULT 'Sub Total',
  EtiquetaImpuestos 		varchar(50) 	NULL	DEFAULT	'Impuestos',
  EtiquetaImporteTotal 		varchar(50) 	NULL	DEFAULT 'Importe Total',
  EtiquetaImporteCobrado 	varchar(50) 	NULL	DEFAULT 'Importe Cobrado',
  EtiquetaCambio 		varchar(50) 	NULL	DEFAULT 'Cambio',
  EtiquetaImporte 		varchar(50) 	NULL	DEFAULT 'Importe',
  EtiquetaFormaPago 		varchar(50) 	NULL	DEFAULT 'Forma de Pago',
  EtiquetaReferencia 		varchar(50) 	NULL	DEFAULT 'Referencia',
  EtiquetaExtra1 		varchar(50) 	NULL,
  EtiquetaExtra2 		varchar(50) 	NULL,
  EtiquetaExtra3 		varchar(50) 	NULL,
  EtiquetaExtra4 		varchar(50) 	NULL,
  CampoExtra1 			varchar(50) 	NULL,
  CampoExtra2 			varchar(50) 	NULL,
  CampoExtra3 			varchar(50) 	NULL,
  CampoExtra4 			varchar(50) 	NULL,
  AbrirCajon			bit  		NULL	DEFAULT 0,
  CajonPuerto 			char(10) 	NULL,
  CajonCodigo 			varchar(50) 	NULL,
  FormaPago 			varchar(50) 	NULL,
  MultiplesCajeros		bit 	 	NULL	DEFAULT 0,
  AutoBloqueoCaja		bit  		NULL	DEFAULT 0,

  TorretaPuerto			char(5)		NULL	DEFAULT 'COM1',
  TorretaVelocidad		int		NULL	DEFAULT 9600,
  TorretaParidad		char(5)		NULL	DEFAULT 'Odd',
  TorretaDataBits		int		NULL	DEFAULT 8,
  TorretaStopBits		int		NULL	DEFAULT 1,
  TorretaCaracteres		int		NULL	DEFAULT 20,
  TorretaLineas			int		NULL	DEFAULT 2,

  NavegadorInicioAuto		bit		NULL 	DEFAULT 0,
  NavegadorEstiloBoton		varchar(100)	NULL	DEFAULT '<Descripcion Inteligente>',
  STMov1			varchar(20)	NULL,
  STMov2			varchar(20)	NULL,
  STMov3			varchar(20)	NULL,
  STMov4			varchar(20)	NULL,
  STMov5			varchar(20)	NULL,
  MostrarDisponibleOpciones	bit		NULL 	DEFAULT 0,

  ImpresionSimultanea		bit		NULL	DEFAULT 0,
  PuertoLocal			char(10)	NULL	DEFAULT 'LPT1',
  TicketInicio			text		NULL	DEFAULT '<Empresa.Nombre>',
  TicketDetalle			text		NULL	DEFAULT '<Detalle.Cantidad> <Detalle.Clave> <Detalle.Precio>',
  TicketFin			text		NULL	DEFAULT 'Importe Total <Nota.ImporteTotal>  Folio <Nota.Folio>',
  TicketFormaPago		text		NULL	DEFAULT '<Detalle.Descripcion> <Detalle.Importe>',
  TicketPiePagina		text		NULL,
  TicketCancelado		text		NULL	DEFAULT '*** NOTA CANCELADA ***',
  TicketAbrirCajon		text		NULL,
  ImprimirAlFinal		bit		NULL	DEFAULT 0,

  BasculaPuerto			char(5)		NULL	DEFAULT 'COM1',
  BasculaVelocidad		int		NULL	DEFAULT 9600,
  BasculaSolicitudPeso		int		NULL	DEFAULT 87,
  BasculaParidad		char(5)		NULL	DEFAULT 'Even',
  BasculaDataBits		int		NULL	DEFAULT 7,
  BasculaStopBits		int		NULL	DEFAULT 1,
  BasculaPausa			int		NULL	DEFAULT 100,

  EscanerPuerto			char(5)		NULL	DEFAULT 'COM1',
  EscanerVelocidad		int		NULL	DEFAULT 9600,
  EscanerParidad		char(5)		NULL	DEFAULT 'None',
  EscanerDataBits		int		NULL	DEFAULT 8,
  EscanerStopBits		int		NULL	DEFAULT 1,
  EscanerPausa			int		NULL	DEFAULT 100,

  Torreta			bit		NULL	DEFAULT 1,
  Escaner			bit		NULL	DEFAULT 1,
  Bascula			bit		NULL	DEFAULT 0,

  GastoClase			varchar(50)	NULL,
  GastoSubClase			varchar(50)	NULL,

  ExpresionAlAfectar		 text		NULL,
  AcumularMismoArticulo		 bit		NULL	DEFAULT 0,
  AcumularMismoArticuloIntelisis bit		NULL	DEFAULT 1,
  AcumularMismoArticuloPoliticas bit		NULL	DEFAULT 0,

  CodigoCompuesto		bit		NULL	DEFAULT 0,
  CCMascara			varchar(20)	NULL,	-- 02AAAA#IIIII#  (A = Articulo, C = Cantidad, P = Precio, I = Importe, 0..9 Numero Fijo, # = Numero Variable)
  CCDecimales			int		NULL    DEFAULT 2,

  CodigoUnicamenteArticulos	bit		NULL	DEFAULT 0,
  NotasEstatusBorrador		bit		NULL	DEFAULT 0, 
  MostrarPreciosConImpuesto	bit		NULL	DEFAULT 0,
  ModoDesconectado		bit		NULL	DEFAULT 0,
  ModoDesconectadoEstacion	bit		NULL	DEFAULT 0,
  AcumularMismoArtIgnorarOpcion	bit		NULL	DEFAULT 0,
  AgenteRequerido		bit		NULL	DEFAULT 0,
  BloquearCantidadInventario	bit		NULL	DEFAULT 0,
  MezclarDevolucionesConVentas	bit		NULL	DEFAULT 0,
  AceptarDevolucionesSinOrigen	bit		NULL	DEFAULT 0,
  PreFoliarNotas		bit		NULL	DEFAULT 0,
  RegistroCaptura		bit 		NULL 	DEFAULT 0,
  ValidarCaducidadLotes		bit 		NULL 	DEFAULT 0,
  SolicitarAutorizacionBuscarArt bit		NULL 	DEFAULT 0,
  CapturarCantidadEnter		bit 		NULL 	DEFAULT 1,
  AnexoFotoNivelOpcion		bit 		NULL 	DEFAULT 0,
  
  CONSTRAINT priEmpresaCfgPV PRIMARY KEY CLUSTERED (Empresa)
)
GO

if not exists(select * from syscampo where Tabla = 'EmpresaCfgPV' and Campo = 'CantidadIndependiente')
  ALTER TABLE EmpresaCfgPV ADD CantidadIndependiente bit NULL DEFAULT 0 WITH VALUES
if not exists(select * from syscampo where Tabla = 'EmpresaCfgPV' and Campo = 'FormaPago')
  ALTER TABLE EmpresaCfgPV ADD FormaPago varchar(50) NULL 
GO
if (select version from version) <= 1169
  UPDATE EmpresaCfgPV SET CantidadIndependiente = 0
GO
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaPuerto', 'char(5) NULL DEFAULT "COM1" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaVelocidad', 'int NULL DEFAULT 9600 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaCaracteres','int NULL DEFAULT 20 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaLineas','int	NULL DEFAULT 2 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'MultiplesCajeros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AutoBloqueoCaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'NavegadorInicioAuto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'STMov1', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'STMov2', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'STMov3', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'STMov4', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'STMov5', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'NavegadorEstiloBoton', 'varchar(100) NULL DEFAULT "Descripcion Inteligente" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'MostrarDisponibleOpciones', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ImpresionSimultanea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'PuertoLocal', 'char(10) NULL DEFAULT "LPT1" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketInicio', 'text NULL DEFAULT "<Empresa.Nombre>" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketDetalle', 'text NULL DEFAULT "<Detalle.Cantidad> <Detalle.Clave> <Detalle.Precio>" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketFin', 'text NULL DEFAULT "Importe Total <Nota.ImporteTotal>  Folio <Nota.Folio>" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketFormaPago', 'text NULL DEFAULT "<Detalle.Descripcion> <Detalle.Importe>" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketCancelado', 'text NULL DEFAULT "*** NOTA CANCELADA ***" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'DefaultUsuario', 'bit NULL DEFAULT 0 WITH VALUES'

EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaPuerto', 'char(5) NULL DEFAULT "COM2" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaVelocidad', 'int NULL DEFAULT 9600 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaSolicitudPeso', 'int	NULL DEFAULT 87 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaParidad', 'char(5) NULL DEFAULT "Even" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaDataBits', 'int NULL	DEFAULT 7 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaStopBits', 'int NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BasculaPausa', 'int	NULL DEFAULT 100 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerPuerto', 'char(5) NULL DEFAULT "COM3" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerVelocidad', 'int NULL DEFAULT 9600 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerParidad', 'char(5) NULL DEFAULT "None" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerDataBits', 'int NULL	DEFAULT 8 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerStopBits', 'int NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'EscanerPausa', 'int	NULL DEFAULT 100 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'Torreta', 'bit NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'Escaner', 'bit NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'Bascula', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaParidad', 'char(5) NULL DEFAULT "Odd" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaDataBits', 'int NULL	DEFAULT 8 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TorretaStopBits', 'int NULL	DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'DesglosarImpuestos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'Mov', 'varchar(20)	NULL DEFAULT "Nota" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'Descuento', 'varchar(30) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ListaPreciosEsp', 'varchar(50) NULL	DEFAULT "(Precio Lista)" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'GastoClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'GastoSubClase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ImprimirAlFinal', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ExpresionAlAfectar', 'text NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AcumularMismoArticulo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'CodigoCompuesto', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'CCMascara', 'varchar(20) NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'CCDecimales' ,'int NULL DEFAULT 2 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'CodigoUnicamenteArticulos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'NotasEstatusBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'MostrarPreciosConImpuesto','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ModoDesconectado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AcumularMismoArtIgnorarOpcion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AgenteRequerido', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketAbrirCajon', 'text NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'BloquearCantidadInventario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'MezclarDevolucionesConVentas', 'bit	NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AceptarDevolucionesSinOrigen', 'bit	NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'MovServicios', 'varchar(20)	NULL DEFAULT "Nota" WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'TicketPiePagina', 'text NULL'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'PrecioIndependiente','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ConsultarArtDisponible','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'PrefoliarNotas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AcumularMismoArticuloIntelisis', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'RegistroCaptura', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ValidarCaducidadLotes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'ModoDesconectadoEstacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'SolicitarAutorizacionBuscarArt', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AcumularMismoArticuloPoliticas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'CapturarCantidadEnter', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'EmpresaCfgPV', 'AnexoFotoNivelOpcion', 'bit NULL DEFAULT 0 WITH VALUES'
GO


/****** EmpresaCfgPVMonCta ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EmpresaCfgPVMonCta')
INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmpresaCfgPVMonCta', 'Maestro')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.EmpresaCfgPVMonCta') AND Type = 'U')
CREATE TABLE EmpresaCfgPVMonCta (
  Empresa                 char(5)         NOT NULL,
  Moneda                  char(10)        NOT NULL,
  FormaPago               varchar(50)     NOT NULL,
  Usuario                 char(10)        NOT NULL,	

  CuentaCorteParcial      char(10)        NULL,
  CuentaCorteCaja         char(10)        NULL,

  CONSTRAINT priEmpresaCfgPVMonCta PRIMARY KEY CLUSTERED (Empresa, Moneda, FormaPago, Usuario)
)
GO

/****** EmpresaCfgPVPrecioVolumen ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'EmpresaCfgPVPrecioVolumen')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPVPrecioVolumen', 'Maestro')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.EmpresaCfgPVPrecioVolumen') AND Type = 'U')
BEGIN
  CREATE TABLE EmpresaCfgPVPrecioVolumen (
  	Empresa                 char(5)         NOT NULL,
	ID			int		NOT NULL IDENTITY(1,1),

	Region			varchar(50)	NULL,
	VigenteD		datetime	NULL,
	VigenteA		datetime	NULL,
	Estatus			char(15)	NULL	DEFAULT 'ACTIVO',
	Articulo		char(20)	NULL,
	Cantidad		float		NULL,
	Precio			money		NULL,

  CONSTRAINT priEmpresaCfgPVPrecioVolumen PRIMARY KEY CLUSTERED (Empresa, ID)
  )
  EXEC spSincroSemilla 'EmpresaCfgPVPrecioVolumen'
END
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'EmpresaCfgPVPrecioVolumen' AND sysindexes.name = 'Articulo' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Articulo ON dbo.EmpresaCfgPVPrecioVolumen (Articulo)
GO

/****** PVRegistroCaptura ******/
IF NOT EXISTS(SELECT * FROM SysTabla WHERE SysTabla = 'PVRegistroCaptura')
INSERT INTO SysTabla (SysTabla) VALUES ('PVRegistroCaptura')
GO
IF NOT EXISTS(SELECT * FROM SysObjects WHERE Id = Object_Id('dbo.PVRegistroCaptura') AND Type = 'U')
CREATE TABLE PVRegistroCaptura(
  ID			  int		  NOT NULL IDENTITY(1,1),

  Empresa                 char(5)         NULL,
  Sucursal                int             NULL,
  Estacion	          int             NULL,
  Fecha                   datetime        NULL  DEFAULT GETDATE(),
  Usuario                 varchar(10)     NULL,
  Caja                    varchar(10)     NULL,
  TeclaFuncion            varchar(20)     NULL,
  TextoFuncion            varchar(50)     NULL,
  TextoPregunta           varchar(100)    NULL,
  TextoRespuesta          varchar(255)    NULL,
  Observaciones           varchar(255)    NULL,

  CONSTRAINT priPVRegistroCaptura PRIMARY KEY CLUSTERED (ID)
)
GO

/****** EmpresaCfgPVCampo ******/
if (select version from version)<=2067 delete SysTabla where SysTabla = 'EmpresaCfgPVCampo'
GO
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPVCampo')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPVCampo', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPVCampo') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPVCampo (
	  Campo		varchar(50) 	NOT NULL,

	CONSTRAINT priEmpresaCfgPVCampo PRIMARY KEY CLUSTERED (Campo)
)
GO

/****** EmpresaCfgPVServicio ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPVServicio')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPVServicio', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPVServicio') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPVServicio (
	  Empresa	char(5)		NOT NULL,
	  Servicio	varchar(50) 	NOT NULL,

	  Articulo	char(20)	NULL,

	CONSTRAINT priEmpresaCfgPVServicio PRIMARY KEY CLUSTERED (Empresa, Servicio)
)
GO

/****** EmpresaCfgPVEtiqueta ******/
if (select version from version)<=2067 delete SysTabla where SysTabla = 'EmpresaCfgPVEtiqueta'
GO
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPVEtiqueta')
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('EmpresaCfgPVEtiqueta', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPVEtiqueta') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPVEtiqueta (
	  Modulo	char(5)		NOT NULL,
	  Mov		char(20) 	NOT NULL,
	  Etiqueta	varchar(100)	NOT NULL,

	  Titulo	varchar(100)	NULL,

	CONSTRAINT priEmpresaCfgPVEtiqueta PRIMARY KEY CLUSTERED (Modulo, Mov, Etiqueta)
)
GO

/****** EmpresaCfgPVMenu ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgPVMenu')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgPVMenu', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgPVMenu') and type = 'U') 
CREATE TABLE dbo.EmpresaCfgPVMenu (
	  Tecla		varchar(50)	NOT NULL,

	  Nombre	varchar(50)	NULL,
	  Expresion	text		NULL,
          NivelAcceso	varchar(50)	NULL,

	CONSTRAINT priEmpresaCfgPVMenu PRIMARY KEY CLUSTERED (Tecla)
)
GO

/****** EmpresaCfgCR ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaCfgCR')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaCfgCR','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaCfgCR') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmpresaCfgCR (
	  Empresa 		char(5) 	NOT NULL,
 	  ID			int		NOT NULL IDENTITY (1,1),

  	  Articulo		char(20)	NULL,
	  FormaPago		varchar(50)	NULL,

	  CONSTRAINT priEmpresaCfgCR PRIMARY KEY CLUSTERED (Empresa, ID)
  )
  EXEC spSincroSemilla 'EmpresaCfgCR'
END
GO

/****** EmpresaSocio ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaSocio')
  INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaSocio', 'Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaSocio') and type = 'U') 
CREATE TABLE dbo.EmpresaSocio (
	  Empresa	char(5)		NOT NULL,
	  Socio		char(10) 	NOT NULL,

	  Participacion	float		NULL,

	CONSTRAINT priEmpresaSocio PRIMARY KEY CLUSTERED (Empresa, Socio)
)
GO

/****** Empresas ******/
if not exists(select * from SysTabla where SysTabla = 'Empresa')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Empresa','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Empresa') and type = 'U') 
CREATE TABLE dbo.Empresa (
	Empresa 			varchar(5) 	NOT NULL,

	Nombre				varchar(100) 	NULL,
        Grupo				varchar(100)	NULL,
	Direccion 			varchar(100) 	NULL,
	DireccionNumero			varchar(20)	NULL,
	DireccionNumeroInt		varchar(20)	NULL,
	Colonia 			varchar(30)  	NULL,
	Poblacion 			varchar(30)  	NULL,
	Estado 				varchar(30)  	NULL,
	Pais				varchar(30)     NULL,
	CodigoPostal 			varchar(15)  	NULL,
	Telefonos 			varchar(100)  	NULL,
	Fax	 			varchar(50)     NULL,
	Encabezado1			varchar(255)	NULL,
	Encabezado2			varchar(255)	NULL,

	Estatus				varchar(15) 	NOT NULL,
	UltimoCambio			datetime  	NULL,
	UltimaCorrida			datetime	NULL,
	Alta				datetime	NULL,

	RFC				varchar(20)	NULL,
	RegistroPatronal		varchar(20)	NULL,
	ClaveActividad			varchar(20)	NULL,
	Representante			varchar(100)	NULL,
	RepresentanteRFC		varchar(20)	NULL,
	RepresentanteCURP		varchar(20)	NULL,

	Zona				varchar(50)	NULL,
	Numero				int		NULL,

	TieneMovimientos		bit		NULL		DEFAULT 0,
	CambioBloquear			bit		NULL		DEFAULT 0,

	Controladora			varchar(5) 	NULL,
	FactorIntegracion		float		NULL		DEFAULT 1.0,
	Tipo				varchar(20)	NULL		DEFAULT '',

	ImportadorRegimen		varchar(30)	NULL,
	ImportadorRegistro		varchar(30)	NULL,
	ImportadorFechaD		datetime	NULL,
	ImportadorFechaA		datetime	NULL,
	Delegacion			varchar(100)	NULL,
	GLN				varchar(50)	NULL,

	CFD				bit		NULL		DEFAULT 0,
	FiscalRegimen			varchar(30)	NULL,
	FiscalZona				varchar(30)	NULL, --MEJORA4769	
	Organizacion			int		NULL,

	TipoRegistro			varchar(20)	NULL,
	IdentificacionRepresentante	varchar(20)	NULL,
	Contador			varchar(40)	NULL,
	RFCContador			varchar(15)	NULL,
	LongitudEstablecimiento		int		NULL,
	LongitudPuntoEmision		int		NULL,
	LongitudSecuencialSRI		int		NULL,
	LongitudAutorizacion		int		NULL,

	EcuadorRepresentanteLegal	varchar(40)	NULL,
	EcuadorNumeroIdentificacion	varchar(15)	NULL,
	EcuadorRepresentanteLegalTipo	varchar(20)	NULL,
	EcuadorRUCContadorTipo		varchar(20)	NULL,

	EsEcuador			AS CONVERT(bit,CASE RTRIM(Pais) WHEN 'Ecuador' THEN 1 ELSE 0 END),
	EsGuatemala			AS CONVERT(bit,CASE RTRIM(Pais) WHEN 'Guatemala' THEN 1 ELSE 0 END),
	GtImporteMinimoSinRetencion	float		NULL,

	Configuracion				varchar(10) NULL,
 --REQ12534 Factory  	
	ReferenciaIntelisisService      varchar(50) NULL,
	EmpresaLDI                      varchar(20) NULL, --REQ13386

	CONSTRAINT priEmpresa PRIMARY KEY  CLUSTERED (Empresa)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgEmpresaABC') and sysstat & 0xf = 8) drop trigger dbo.tgEmpresaABC
GO
if exists (select * from syscampo where tabla = 'Empresa' AND campo='Sucursal') and not exists (select * from syscampo where tabla = 'Empresa' AND campo='Numero')
  EXEC("sp_rename 'Empresa.Sucursal', 'Numero', 'COLUMN'")
GO
-- Aqui va el Matenimiento a la tabla
EXEC spALTER_TABLE 'Empresa', 'CambioBloquear', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Empresa', 'RegistroPatronal', 'varchar(20) NULL'
GO
if not exists(select * from syscampo where tabla = 'Empresa' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Empresa ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Empresa SET TieneMovimientos = 1")
END
GO

EXEC spALTER_TABLE 'Empresa', 'Controladora', 'char(5) NULL'
EXEC spALTER_TABLE 'Empresa', 'Tipo', 'varchar(20) NULL	DEFAULT "" WITH VALUES'
EXEC spALTER_TABLE 'Empresa', 'ImportadorRegimen', 'varchar(30)	NULL'
EXEC spALTER_TABLE 'Empresa', 'ImportadorRegistro', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Empresa', 'ImportadorFechaD', 'datetime NULL'
EXEC spALTER_TABLE 'Empresa', 'ImportadorFechaA', 'datetime NULL'
EXEC spALTER_TABLE 'Empresa', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'Delegacion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Empresa', 'GLN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Empresa', 'CFD_noCertificado', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_version', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_versionFecha', 'datetime NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_versionAnterior', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_EAN13', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_DUN14', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_SKU', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_SKUCodigoInterno', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Empresa', 'CFD_Llave', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_Certificado', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Empresa', 'CFD_ContrasenaSello', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Empresa', 'FactorIntegracion', 'float NULL DEFAULT 1.0 WITH VALUES'
EXEC spALTER_COLUMN 'Empresa' ,'Estatus', 'varchar(15) NOT NULL'
EXEC spALTER_COLUMN 'Empresa' ,'Controladora', 'varchar(5) NULL'
GO

EXEC spALTER_TABLE 'Empresa', 'TipoRegistro', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'IdentificacionRepresentante', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Empresa', 'Contador', 'varchar(40) NULL'
EXEC spALTER_TABLE 'Empresa', 'RFCContador', 'varchar(15) NULL'
EXEC spALTER_TABLE 'Empresa', 'LongitudEstablecimiento', 'int NULL'
EXEC spALTER_TABLE 'Empresa', 'LongitudPuntoEmision', 'int NULL'
EXEC spALTER_TABLE 'Empresa', 'LongitudSecuencialSRI', 'int NULL'
EXEC spALTER_TABLE 'Empresa', 'LongitudAutorizacion', 'int NULL'
EXEC spALTER_COLUMN 'Empresa', 'Contador', 'varchar(40) NULL'
GO

EXEC spALTER_TABLE 'Empresa', 'Configuracion', 'varchar(10) NULL'
GO

if (select version from version)<=3192
BEGIN
--BUG 25414 Se presenta al no concluir un mantto y no agregar el registro en la tabla version
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Empresa_inhibido]') AND parent_object_id = OBJECT_ID(N'[dbo].[empresa_respuesta]'))
    ALTER TABLE [dbo].[empresa_respuesta] DROP CONSTRAINT [FK_Empresa_inhibido]
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ParametrosIVA_Empresa]') AND parent_object_id = OBJECT_ID(N'[dbo].[ParametrosIVA]'))
    ALTER TABLE [dbo].[ParametrosIVA] DROP CONSTRAINT [FK_ParametrosIVA_Empresa]
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ParametrosISR_Empresa]') AND parent_object_id = OBJECT_ID(N'[dbo].[ParametrosISR]'))
    ALTER TABLE [dbo].[ParametrosISR] DROP CONSTRAINT [FK_ParametrosISR_Empresa]
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ParametrosGrals_Empresa]') AND parent_object_id = OBJECT_ID(N'[dbo].[ParametrosGrals]'))
    ALTER TABLE [dbo].[ParametrosGrals] DROP CONSTRAINT [FK_ParametrosGrals_Empresa]
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UsuarioPerfil_Empresas]') AND parent_object_id = OBJECT_ID(N'[dbo].[UsuarioPerfil]'))
    ALTER TABLE [dbo].[UsuarioPerfil] DROP CONSTRAINT [FK_UsuarioPerfil_Empresas]
  IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Sucursales_Empresa]') AND parent_object_id = OBJECT_ID(N'[dbo].[Sucursales]'))
    ALTER TABLE [dbo].[Sucursales] DROP CONSTRAINT [FK_Sucursales_Empresa]

  EXEC("spEliminarPK 'Empresa'")	
  EXEC("spALTER_COLUMN 'Empresa' ,'Empresa', 'varchar(5) NOT NULL'")  
  EXEC("ALTER TABLE Empresa ADD CONSTRAINT priEmpresa PRIMARY KEY CLUSTERED (Empresa)")
END
GO
EXEC spALTER_TABLE 'Empresa', 'FiscalRegimen', 'varchar(30) NULL' 
EXEC spALTER_TABLE 'Empresa', 'FiscalZona', 'varchar(30) NULL' --MEJORA4769
EXEC spALTER_TABLE 'Empresa', 'Organizacion', 'int NULL'
GO

IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'Empresa' AND Campo='EsEcuador')
BEGIN
  EXEC("ALTER TABLE Empresa ADD EsEcuador AS CONVERT(bit,CASE RTRIM(Pais) WHEN 'Ecuador' THEN 1 ELSE 0 END)")
END
GO

IF NOT EXISTS(SELECT * FROM SysCampo WHERE Tabla = 'Empresa' AND Campo='EsGuatemala')
BEGIN
  EXEC("ALTER TABLE Empresa ADD EsGuatemala AS CONVERT(bit,CASE RTRIM(Pais) WHEN 'Guatemala' THEN 1 ELSE 0 END)")
END
GO

EXEC spALTER_TABLE 'Empresa', 'GtImporteMinimoSinRetencion', 'float NULL'
GO

EXEC spALTER_TABLE 'Empresa', 'EcuadorRepresentantelegal', 'varchar(40)'
EXEC spALTER_TABLE 'Empresa', 'EcuadorNumeroidentificacion', 'varchar(15)'
EXEC spALTER_TABLE 'Empresa', 'EcuadorRepresentantelegalTipo', 'varchar(20)'
EXEC spALTER_TABLE 'Empresa', 'EcuadorRUCContadorTipo', 'varchar(20)'
GO
 --REQ12534 Factory  
Exec spAlter_Table 'Empresa', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO

--REQ13386
EXEC spALTER_TABLE 'Empresa', 'EmpresaLDI','  varchar(20) NULL'
GO

--Integración CRM
EXEC spAlter_Table 'empresa', 'CRMObjectId', 'uniqueidentifier NULL'
EXEC spAlter_Table 'empresa', 'CRMLastUpdate', 'datetime DEFAULT GETDATE()'	
GO

/**************** tgInforEmpresaABC ****************/
if exists (select * from sysobjects where id = object_id('dbo.tgInforEmpresaABC') and sysstat & 0xf = 8) drop trigger dbo.tgInforEmpresaABC
GO
--CREATE TRIGGER tgInforEmpresaABC ON Empresa
----//WITH ENCRYPTION
--FOR INSERT, UPDATE ,DELETE
--AS BEGIN
--  DECLARE
--   @ProdInterfazINFOR					bit,
--   @Empresa	        					varchar (10),
--   @Estatus							    varchar (10),
--   @Datos								varchar (max),
--   @Ok									int,
--   @OkRef								varchar(255),
--   @Id									int,
--   @Cinserted		                	int,
--   @Cdeleted			                int,
--   @Empresa1							varchar(20),
--   @ReferenciaIntelisisService			varchar(50)	,
--   @PlantaSucEmpresa					varchar(10)

--  SELECT @ID = dbo.fnAccesoID(@@SPID)
  
--  SELECT @Empresa1 = Empresa FROM Acceso WHERE ID = @ID
  
--  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
--    FROM EmpresaGral WHERE Empresa = @Empresa1

----  SELECT @PlantaSucEmpresa = PlantaSucEmpresa
----    FROM Version


--  SELECT @Cinserted =  COUNT(*) FROM inserted
--  SELECT @Cdeleted =  COUNT(*) FROM deleted

  
--  IF @ProdInterfazINFOR = 1 --AND @PlantaSucEmpresa='Empresa'
--  BEGIN
--	IF @Cinserted <> 0 AND @Cdeleted = 0 
--	BEGIN
--      SET @Estatus = 'ALTA' 
--	END
--    IF @Cinserted <> 0 AND @Cdeleted<> 0 
--	 BEGIN
--      SET @Estatus = 'CAMBIO'
--     END
--    IF @Cinserted = 0 AND @Cdeleted <> 0 
--     BEGIN 
--      SET @Estatus = 'BAJA'
--     END
--    IF  @Estatus IN( 'ALTA','CAMBIO')
--      BEGIN
--        DECLARE crActualizar CURSOR FOR
--	    SELECT Empresa,ReferenciaIntelisisService
--	      FROM Inserted
--      END
--    ELSE
--    IF @Estatus = 'BAJA'
--      BEGIN
--      DECLARE crActualizar CURSOR local FOR
--	  SELECT Empresa,ReferenciaIntelisisService
--	    FROM Deleted     
--      END 
--      IF @Estatus IS NOT NULL
--      BEGIN         
--        OPEN crActualizar
--        FETCH NEXT FROM crActualizar INTO @Empresa,@ReferenciaIntelisisService
--        WHILE @@FETCH_STATUS = 0 
--        BEGIN
--          EXEC spInforGenerarSolicitudEmpresa  @Empresa,@Estatus,@ReferenciaIntelisisService,@Datos OUTPUT
--          FETCH NEXT FROM crActualizar INTO @Empresa,@ReferenciaIntelisisService
--		  END
--        CLOSE crActualizar
--        DEALLOCATE crActualizar
--      END  
      
--  END
--END
--GO

--Integración CRM
IF OBJECT_ID ('tr_empresa', 'TR') IS NOT NULL DROP TRIGGER tr_empresa 
GO									
/*CREATE TRIGGER tr_empresa ON empresa 
AFTER UPDATE as BEGIN
	SET NOCOUNT ON;
	IF not UPDATE(crmlastupdate) BEGIN
		update empresa  set CRMLastUpdate=GETDATE() 
			FROM INSERTED i
		WHERE i.empresa= empresa.Empresa
	END
END
GO*/

/****** GrupoTrabajoD  ******/
if not exists(select * from SysTabla where SysTabla = 'GrupoTrabajoD')
	INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GrupoTrabajoD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GrupoTrabajoD') and type = 'U') 
CREATE TABLE dbo.GrupoTrabajoD (
	GrupoTrabajo 		varchar(50)     NOT NULL,
	GrupoTrabajoD 		varchar(50)     NOT NULL,

	CONSTRAINT priGrupoTrabajoD PRIMARY KEY CLUSTERED (GrupoTrabajo, GrupoTrabajoD)
)
GO

/****** Grupos de Trabajo  ******/
if not exists(select * from SysTabla where SysTabla = 'GrupoTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('GrupoTrabajo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.GrupoTrabajo') and type = 'U') 
CREATE TABLE dbo.GrupoTrabajo (
	GrupoTrabajo 		varchar(50)     NOT NULL,

	Multiple		bit		NULL	DEFAULT 0,
	DirectorioCodigo	varchar(150)	NULL,

	CONSTRAINT priGrupoTrabajo PRIMARY KEY CLUSTERED (GrupoTrabajo)
)
GO
EXEC spALTER_TABLE 'GrupoTrabajo', 'Multiple', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'GrupoTrabajo', 'DirectorioCodigo', 'varchar(150) NULL'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgGrupoTrabajoBC') and sysstat & 0xf = 8) drop trigger dbo.tgGrupoTrabajoBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgGrupoTrabajoBC ON GrupoTrabajo
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @GrupoTrabajoN  	varchar(50),
    @GrupoTrabajoA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @GrupoTrabajoN = GrupoTrabajo FROM Inserted
  SELECT @GrupoTrabajoA = GrupoTrabajo FROM Deleted
  IF @GrupoTrabajoN = @GrupoTrabajoA RETURN

  IF @GrupoTrabajoN IS NULL 
    DELETE GrupoTrabajoD WHERE GrupoTrabajo = @GrupoTrabajoA
  ELSE BEGIN
    UPDATE GrupoTrabajoD SET GrupoTrabajo = @GrupoTrabajoN WHERE GrupoTrabajo = @GrupoTrabajoA
  END
END
GO

/****** Usuarios ******/
if not exists(select * from SysTabla where SysTabla = 'Usuario')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Usuario','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Usuario') and type = 'U') 
CREATE TABLE dbo.Usuario (
	Usuario 			varchar(10)  	NOT NULL,

	Nombre 				varchar(100) 	NULL,
	Sucursal			int		NULL 	DEFAULT 0,
	DefEmpresa			varchar(5)		NULL,
	GrupoTrabajo			varchar(50)	NULL,
	Departamento			varchar(50)	NULL,
	Contrasena			varchar(32) 	NULL,
	ContrasenaConfirmacion		varchar(32) 	NULL,
	ContrasenaFecha			datetime	NULL,
	ContrasenaModificar		bit		NULL	DEFAULT 0,
	Telefono 			varchar(100)  	NULL,
	Extencion 			varchar(10) 	NULL,

	DefAgente			varchar(10)	NULL,
	DefCajero			varchar(10)	NULL,
	DefAlmacen			varchar(10)	NULL,
	DefAlmacenTrans			varchar(10)	NULL,
	DefCtaDinero			varchar(10)	NULL,
	DefCtaDineroTrans		varchar(10)	NULL,
        DefMoneda			varchar(10)	NULL,
	DefProyecto			varchar(50)	NULL,
	DefLocalidad			varchar(50)	NULL,
	DefCliente			varchar(10)	NULL,
	DefActividad			varchar(50)	NULL,
	DefMovVentas			varchar(20)	NULL,
	DefZonaImpuesto			varchar(30)	NULL,
	DefFormaPago			varchar(50)	NULL,
	Afectar				bit		NOT NULL	DEFAULT 1,
	Cancelar			bit		NOT NULL	DEFAULT 1,
	Desafectar			bit		NOT NULL	DEFAULT 0,
	Autorizar			bit		NULL		DEFAULT 0,
	AutorizarVenta			bit		NULL		DEFAULT 0,
	AutorizarCxp			bit		NULL		DEFAULT 0,
	AutorizarGasto			bit		NULL		DEFAULT 0,
	AutorizarDinero			bit		NULL		DEFAULT 0,
	AutorizarPV			bit		NULL		DEFAULT 0,
	AutorizarCompra			bit		NULL		DEFAULT 0,
	AutorizarGestion		bit		NULL		DEFAULT 0,
	AutorizarSeriesLotes		bit		NULL		DEFAULT 0,
	
	AfectarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	CancelarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ConsultarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ConsultarOtrosMovsGrupo		bit		NULL		DEFAULT 0,
	ConsultarOtrasEmpresas		bit		NULL		DEFAULT 0,
	ConsultarOtrasSucursales	bit		NULL		DEFAULT 0,
	AccesarOtrasSucursalesEnLinea	bit		NULL		DEFAULT 0,
	AfectarOtrasSucursalesEnLinea	bit		NULL		DEFAULT 0,
	ModificarOtrosMovs		bit		NOT NULL	DEFAULT 0,
	ModificarVencimientos		bit		NOT NULL	DEFAULT 0,
	ModificarEntregas		bit		NOT NULL	DEFAULT 0,
	ModificarFechaRequerida		bit		NULL		DEFAULT 0,
	ModificarEnvios			bit		NOT NULL	DEFAULT 0,
	ModificarReferencias		bit		NOT NULL	DEFAULT 0,
	ModificarAlmacenEntregas 	bit		NOT NULL	DEFAULT 0,
	ModificarSituacion		bit		NOT NULL 	DEFAULT 1,
	ModificarAgente			bit		NOT NULL 	DEFAULT 0,
	ModificarUsuario		bit		NOT NULL 	DEFAULT 0,
	ModificarListaPrecios		bit		NOT NULL 	DEFAULT 0,
	ModificarZonaImpuesto		bit		NOT NULL 	DEFAULT 0,
	ModificarSucursalDestino	bit		NULL 		DEFAULT 0,
	ModificarProyUENActCC		bit		NULL		DEFAULT 0,
	AgregarCteExpress	 	bit		NOT NULL	DEFAULT 0,
	AgregarArtExpress	 	bit		NOT NULL	DEFAULT 0,
	Costos				bit		NOT NULL	DEFAULT 0,
	BloquearCostos			bit		NULL		DEFAULT 0,
	VerInfoDeudores			bit		NOT NULL	DEFAULT 0,
	VerInfoAcreedores		bit		NOT NULL	DEFAULT 0,
	VerComisionesPendientes		bit		NOT NULL	DEFAULT 0,
	BloquearEncabezadoVenta		bit		NOT NULL	DEFAULT 0,
	BloquearCxcCtaDinero		bit		NOT NULL 	DEFAULT 0,
	BloquearCxpCtaDinero		bit		NOT NULL 	DEFAULT 0,
	BloquearDineroCtaDinero		bit		NOT NULL 	DEFAULT 0,
	EnviarExcel			bit		NOT NULL	DEFAULT 1,
	ImprimirMovs			bit		NOT NULL	DEFAULT 1,
	PreliminarMovs			bit		NOT NULL	DEFAULT 1,
	Reservar			bit		NOT NULL 	DEFAULT 1,
	DesReservar			bit		NOT NULL 	DEFAULT 1,
	Asignar				bit		NOT NULL 	DEFAULT 1,
	DesAsignar			bit		NOT NULL 	DEFAULT 1,
	ModificarAlmacenPedidos		bit		NOT NULL	DEFAULT 0,
	ModificarConceptos		bit		NOT NULL 	DEFAULT 0,
	ModificarReferenciasSiempre	bit		NOT NULL 	DEFAULT 0,
	ModificarAgenteCxcPendiente	bit		NOT NULL	DEFAULT 0,
	ModificarMovsNominaVigentes	bit		NULL 		DEFAULT 0,
	BloquearPrecios			bit		NOT NULL 	DEFAULT 0,
	BloquearDescGlobal		bit		NULL 		DEFAULT 0,
	BloquearDescLinea		bit		NULL 		DEFAULT 0,
	BloquearCondiciones		bit		NOT NULL 	DEFAULT 0,
	BloquearAlmacen			bit		NOT NULL	DEFAULT 0,
	BloquearMoneda			bit		NOT NULL 	DEFAULT 0,
	BloquearAgente			bit		NOT NULL	DEFAULT 0,
	BloquearFechaEmision		bit		NOT NULL 	DEFAULT 0,
	BloquearProyecto		bit		NOT NULL 	DEFAULT 0,
	BloquearFormaPago		bit		NULL 		DEFAULT 0,
	Oficina				varchar(50)	NULL,
	DefArtTipo			varchar(20)	NULL		DEFAULT '(Empresa)',
	DefUnidad      			varchar(50)  	NULL		DEFAULT '(Empresa)',
	AbrirCajon			bit		NULL		DEFAULT 0,
	BloquearCobroInmediato		bit		NULL		DEFAULT 0,
	ConsultarCompraPendiente 	bit		NULL		DEFAULT 1,
	AccesoTotalCuentas		bit		NULL		DEFAULT 0,

	Estatus				varchar(15) 	NOT NULL,
	UltimoCambio			datetime  	NULL,
	Alta				datetime	NULL,	
	Configuracion			varchar(10)	NULL,
	Acceso				varchar(10)	NULL,

	TieneMovimientos		bit		NULL		DEFAULT 0,
	Refacturar			bit		NULL		DEFAULT 0,

	DefListaPreciosEsp		varchar(20)	NULL,
	LimiteTableroControl		int		NULL		DEFAULT 200,
	CteInfo				bit		NULL		DEFAULT 1,
	CteBloquearOtrosDatos		bit		NULL		DEFAULT 0,
	ArtBloquearOtrosDatos		bit		NULL		DEFAULT 0,
	CteSucursalVenta		bit		NULL		DEFAULT 0,
	CtaDineroInfo			bit		NULL		DEFAULT 1,
	ImpresionInmediata		bit		NULL		DEFAULT 0,
	MostrarCampos			bit		NULL		DEFAULT 1,
	AsistentePrecios		bit		NULL		DEFAULT 0,

	CambioValidarCobertura		bit		NULL		DEFAULT 0,
	CambioNormatividad		bit		NULL		DEFAULT 0,
	CambioEditarCobertura		bit		NULL		DEFAULT 0,
	CambioVerPosicionEmpresa	bit		NULL		DEFAULT 1,
	CambioVerPosicionSucursal	bit		NULL		DEFAULT 1,
	CambioVerPosicionOtraSucursal 	bit		NULL		DEFAULT 1,
	CambioAutorizarOperacionLimite	bit		NULL		DEFAULT 0,

	AutoDobleCapturaPrecios		bit		NULL		DEFAULT 1,
	AutoArtGrupo			varchar(50)	NULL,
	AutoAgregarRecaudacionConsumo	bit		NULL		DEFAULT 0,
	AutoDiesel			bit		NULL		DEFAULT 0,

	BloquearActividad		bit		NULL		DEFAULT 0,
	UEN				int		NULL,
	eMail				varchar(50) 	NULL,
	CteMov				bit		NULL		DEFAULT 0,
	CteArt				bit		NULL		DEFAULT 0,
	ProvMov				bit		NULL		DEFAULT 0,
	ArtMov				bit		NULL		DEFAULT 0,
	DefContUso			varchar(20)	NULL,
	BloquearContUso			bit		NULL		DEFAULT 0,
	Observaciones			varchar(255)	NULL,
	TraspasarTodo			bit		NULL		DEFAULT 0,
	BloquearNotasNegativas		bit		NULL		DEFAULT 0,
	ModificarSerieLoteProp		bit		NULL		DEFAULT 0,
	NominaEliminacionParcial	bit		NULL		DEFAULT 0,

	ModificarPropiedadesLotes	bit		NULL		DEFAULT 0,

	PVAbrirCajonSiempre		bit		NULL		DEFAULT 0,
	PVBloquearEgresos		bit		NULL		DEFAULT 0,
	PVCobrarNotasEstatusBorrador	bit		NULL		DEFAULT 0,
	PVModificarEstatusBorrador	bit		NULL		DEFAULT 0,
	BloquearPersonalCfg		bit		NULL		DEFAULT 0,
	BloquearFacturacionDirecta	bit		NULL		DEFAULT 0,
	BloquearInvSalidaDirecta	bit		NULL		DEFAULT 0,
	Idioma				varchar(50)	NULL,
	ModificarDatosVIN		bit		NULL		DEFAULT 0,
	ModificarDatosCliente		bit		NULL		DEFAULT 0,
	CxcExpress			bit		NULL		DEFAULT 0,
	CxpExpress			bit		NULL		DEFAULT 0,

	Cliente				varchar(10)	NULL,
	SubModuloAtencion		varchar(5)		NULL,
	BloquearCancelarFactura		bit		NULL		DEFAULT 0,
        CambioPresentacionExpress       bit		NULL		DEFAULT 0,

	ModificarConsecutivos		bit		NULL 		DEFAULT 0,
	ModificarVINFechaBaja		bit		NULL 		DEFAULT 0,
	ModificarVINFechaPago		bit		NULL 		DEFAULT 0,
	ModificarVINAccesorio		bit		NULL 		DEFAULT 0,
	PVEditarNota			bit		NULL 		DEFAULT 1,
	ModificarDescGlobalImporte	bit		NULL 		DEFAULT 0,
	ConsultarClientesOtrosAgentes	bit		NULL 		DEFAULT 1,

	ACLCUsoEspecifico		varchar(20)	NULL,
	ACEditarTablaAmortizacion	bit		NULL 		DEFAULT 0,
	PlantillasOffice		bit		NULL 		DEFAULT 1,
	ConfigPlantillasOffice		bit		NULL 		DEFAULT 0,
	ACTasaGrupo			varchar(50)	NULL,
	CambioAgregarBeneficiarios	bit		NULL 		DEFAULT 1,
	AgregarConceptoExpress	 	bit		NULL		DEFAULT 0,

	BloquearArtMaterial		bit		NULL		DEFAULT 0,
	
	InfoPath			bit		NULL		DEFAULT 0,
	InfoPathExe			varchar(255)	NULL,

	FEA				bit		NULL		DEFAULT 0,
	FEACertificado			varchar(100)	NULL,
	FEALlave			varchar(100)	NULL,
	ContrasenaNuncaExpira		bit		NULL		DEFAULT 0,

	Menu				varchar(50)	NULL,
	MenuAccesoTotal			bit		NULL		DEFAULT 0,

	BloquearPDF			bit		NULL		DEFAULT 0,
	VerificarOrtografia		bit		NULL		DEFAULT 0,
	ContSinOrigen			bit		NULL		DEFAULT 0,
	UnidadOrganizacional		varchar(20)	NULL,
	ProyectoMov			bit		NULL		DEFAULT 0,

	CompraDevTodo			bit		NULL		DEFAULT 0,

	BloquearWebContenido		bit		NULL		DEFAULT 0,
	BloquearWebHTML			bit		NULL		DEFAULT 0,
	DBMailPerfil			varchar(50)	NULL,

	UltimoAcceso			datetime	NULL,
	BloquearSituacionUsuario	bit		NULL		DEFAULT 0,
	InformacionConfidencial		bit		NULL,
	PerfilForma			varchar(50)	NULL,
	Licenciamiento			varchar(50)	NULL		DEFAULT '(Total)',
	SituacionArea			varchar(50)	NULL 		DEFAULT '(General)',
	
	ModificarTipoImpuesto		bit		NULL		DEFAULT 0,
	Personal					varchar(10) NULL, --MEJORA5066
 --REQ12534 Factory  	
	INFORPerfil			varchar(30)	NULL,
	ReferenciaIntelisisService	varchar(50)	NULL,
	INFORSupervisor			bit		NULL		DEFAULT 0,
	ISMESNotificarError		bit		NULL		DEFAULT 0,

--REQ12615 WMS	
	ModificarPosicionSugeridaWMS	bit	NULL	DEFAULT 0,
	ModificarAgenteWMS				bit NULL	DEFAULT 0,
	POSPerfil                       varchar(10)	NULL,--REQ 13393 POS
	OPORTPlantilla					varchar(20) NULL, --REQ16092
	CONSTRAINT priUsuario PRIMARY KEY CLUSTERED (Usuario)
)

-- SPOtros/Generales/spCopiarUsuarioCfg
GO
EXEC spALTER_TABLE 'Usuario', 'ModificarSucursalDestino', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ConsultarOtrasSucursales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AccesarOtrasSucursalesEnLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AfectarOtrasSucursalesEnLinea', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Sucursal', 'int NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefCajero', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Usuario', 'DefEmpresa', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Usuario', 'ContrasenaFecha', 'datetime NULL'		
EXEC spALTER_TABLE 'Usuario', 'BloquearCobroInmediato', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ConsultarCompraPendiente', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Refacturar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Usuario', 'LimiteTableroControl', 'int NULL	DEFAULT 200 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CteInfo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ImpresionInmediata', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioValidarCobertura', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioNormatividad', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefCtaDineroTrans', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Usuario', 'AccesoTotalCuentas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioEditarCobertura', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'MostrarCampos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AsistentePrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Acceso', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Usuario', 'CteBloquearOtrosDatos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ArtBloquearOtrosDatos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CteSucursalVenta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'Usuario', 'eMail', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'CteMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ProvMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ArtMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarReferenciasSiempre', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'TraspasarTodo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefMovVentas', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Usuario', 'Departamento', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'CtaDineroInfo', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarPropiedadesLotes', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioPresentacionExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AgregarConceptoExpress','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'FEA', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'FEACertificado', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Usuario', 'FEALlave', 'varchar(100)	NULL'
EXEC spALTER_TABLE 'Usuario', 'AutorizarGestion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearTipoCambio', 'bit NULL DEFAULT 0 WITH VALUES' --JGD17Junio2011 Ticket 4967

-- 'CORTE'
EXEC spALTER_TABLE 'Usuario', 'AfectarCORTE', 'bit NULL DEFAULT 0 WITH VALUES' 
GO

--REQ12615 WMS
EXEC spALTER_TABLE 'Usuario', 'ModificarPosicionSugeridaWMS', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarAgenteWMS', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ16092
EXEC spALTER_TABLE 'Usuario', 'OPORTPlantilla', 'varchar(20) NULL'
GO

if (select version from version) <= 1459
  UPDATE Usuario SET Acceso = Configuracion 
GO
if (select version from version) <= 1173
  UPDATE Usuario SET Sucursal = 0 WHERE Sucursal IS NULL
GO
if not exists(select * from syscampo where tabla = 'Usuario' AND Campo='AutorizarVenta')
BEGIN
  EXEC spALTER_TABLE 'Usuario', 'AutorizarVenta', 'bit NULL DEFAULT 0 WITH VALUES'
  EXEC spALTER_TABLE 'Usuario', 'AutorizarCxp', 'bit NULL DEFAULT 0 WITH VALUES'
  EXEC spALTER_TABLE 'Usuario', 'AutorizarGasto', 'bit NULL DEFAULT 0 WITH VALUES'
  EXEC("UPDATE Usuario SET AutorizarVenta = Autorizar, AutorizarCxp = Autorizar, AutorizarGasto = Autorizar")
END
GO
EXEC spALTER_TABLE 'Usuario', 'AutorizarDinero', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AutorizarPV', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioVerPosicionEmpresa', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioVerPosicionSucursal', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioVerPosicionOtraSucursal', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AutoDobleCapturaPrecios', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AutoArtGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'DefActividad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearActividad', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefContUso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearContUso', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Observaciones', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Usuario', 'AutoAgregarRecaudacionConsumo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AutoDiesel', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarAgenteCxcPendiente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearNotasNegativas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearDineroCtaDinero', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarSerieLoteProp', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'NominaEliminacionParcial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ConsultarOtrosMovsGrupo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefZonaImpuesto',  'varchar(30) NULL'
EXEC spALTER_TABLE 'Usuario', 'ModificarProyUENActCC', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefFormaPago', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearFormaPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PVAbrirCajonSiempre', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PVBloquearEgresos', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PVCobrarNotasEstatusBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearPersonalCfg', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarMovsNominaVigentes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearFacturacionDirecta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Idioma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'AutorizarCompra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarDatosVIN', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarDatosCliente', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CxcExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CxpExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PVModificarEstatusBorrador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Usuario', 'SubModuloAtencion', 'varchar(5) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearCostos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DefAlmacenTrans', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearCancelarFactura', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AutorizarSeriesLotes', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarConsecutivos', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarVINFechaBaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarVINAccesorio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PVEditarNota', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarDescGlobalImporte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarVINFechaPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ConsultarClientesOtrosAgentes',' bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ACLCUsoEspecifico', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Usuario', 'ACEditarTablaAmortizacion', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CteArt', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CambioAutorizarOperacionLimite', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'PlantillasOffice', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ConfigPlantillasOffice', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ACTasaGrupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'CambioAgregarBeneficiarios', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearArtMaterial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'InfoPath', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'InfoPathExe', 'varchar(255) NULL'
EXEC spALTER_TABLE 'Usuario', 'ContrasenaNuncaExpira', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'AgregarProvExpress', 'bit NULL'
EXEC spALTER_TABLE 'Usuario', 'Menu', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'MenuAccesoTotal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearPDF', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'VerificarOrtografia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ContSinOrigen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'UnidadOrganizacional', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Usuario', 'ProyMov', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'CompraDevTodo', 'bit NULL DEFAULT 0 WITH VALUES'
GO
IF EXISTS(SELECT * FROM SysTipoDatos WHERE Tabla='Usuario' AND Campo='Contrasena' AND Tamano=10)
BEGIN
  EXEC("spALTER_COLUMN 'Usuario', 'Contrasena', 'varchar(32) NULL'")
  EXEC("spALTER_COLUMN 'Usuario', 'ContrasenaConfirmacion', 'varchar(32) NULL'")
  EXEC("UPDATE Version SET EncriptarContrasenas = 1")
--  EXEC("UPDATE Usuario SET Contrasena = dbo.fnMD5(Contrasena), ContrasenaConfirmacion = dbo.fnMD5(Contrasena) WHERE LEN(Contrasena)<32")
END
GO
-- hay que tener mucho cuidado con este tema porque se pueden reencriptar las contraseñas
if (select version from version)<=3255
  UPDATE Version SET EncriptarContrasenas = 1
GO

EXEC spALTER_TABLE 'Usuario', 'BloquearWebContenido', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'BloquearWebHTML', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'DBMailPerfil', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearInvSalidaDirecta', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'Personal', 'varchar(10) NULL' --MEJORA5066
GO
if (select version from version)<=3192
BEGIN
  EXEC("spEliminarPK 'Usuario'")	
  EXEC("spALTER_COLUMN 'Usuario' ,'Usuario', 'varchar(10) NOT NULL'")  
  EXEC("ALTER TABLE Usuario ADD CONSTRAINT priUsuario PRIMARY KEY CLUSTERED (Usuario)")
END
GO
EXEC spALTER_COLUMN 'Usuario' ,'DefEmpresa' ,'varchar(5) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefAgente' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefCajero' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefAlmacen' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefAlmacenTrans' ,'varchar(10)	NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefCtaDinero' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefCtaDineroTrans' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefMoneda' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefCliente' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'DefArtTipo' ,'varchar(20) NULL' ,'"(Empresa)"'
EXEC spALTER_COLUMN 'Usuario' ,'Estatus' ,'varchar(15) NOT NULL'
EXEC spALTER_COLUMN 'Usuario' ,'Configuracion' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'Acceso' ,'varchar(10) NULL'
EXEC spALTER_COLUMN 'Usuario' ,'SubModuloAtencion' ,'varchar(5) NULL'
EXEC spALTER_TABLE 'Usuario', 'UltimoAcceso', 'datetime	NULL'
EXEC spALTER_TABLE 'Usuario', 'BloquearSituacionUsuario', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'InformacionConfidencial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ContrasenaModificar', 'bit NULL DEFAULT 0 WITH VALUES'
GO
if (select version from version)<=3245
  UPDATE Usuario SET Menu = '(Clasico)'
GO
EXEC spALTER_TABLE 'Usuario', 'PerfilForma', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Usuario', 'Licenciamiento', 'varchar(50) NULL DEFAULT "(Total)" WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'SituacionArea', 'varchar(50) NULL DEFAULT "(General)" WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'ModificarTipoImpuesto', 'bit NULL DEFAULT 0 WITH VALUES'
GO
 --REQ12534 Factory  
EXEC spAlter_Table 'Usuario', 'INFORPerfil',' varchar(30)NULL '
EXEC spAlter_Table 'Usuario', 'INFORSupervisor',' bit NOT NULL DEFAULT 0'
EXEC spAlter_Table 'Usuario', 'ReferenciaIntelisisService',' varchar(50) NULL '
EXEC spALTER_TABLE 'Usuario', 'ISMESNotificarError', 'bit NULL DEFAULT 0 WITH VALUES'    

--REQ 13393 POS
EXEC spALTER_TABLE 'Usuario', 'POSPerfil', 'varchar(10)  NULL'
EXEC spALTER_TABLE 'Usuario', 'POSEsSupervisor', 'bit  NULL'

EXEC spALTER_TABLE 'Usuario', 'ProyectoMov', 'bit NULL DEFAULT 0 WITH VALUES'

EXEC spFK 'Usuario','Sucursal','Sucursal','Sucursal'
EXEC spFK 'Usuario','UEN','UEN','UEN'
EXEC spFK 'Usuario','DefContUso','CentroCostos','CentroCostos'
EXEC spFK 'Usuario','Cliente','Cte','Cliente'
EXEC spFK 'Usuario','UnidadOrganizacional','aroUnidad','UnidadOrganizacional'
GO

--Integración MES
EXEC spALTER_TABLE 'Usuario', 'MESAcceso', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'MESEstructura', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'MESPlanificacion', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'MESVariantes', 'bit NOT NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Usuario', 'MESScheduling', 'bit NOT NULL DEFAULT 0 WITH VALUES'
GO

--Integración Planograma WMS
/* Campos Nuevos a Tabla Usuario para configurar y dar permisos */
EXEC spALTER_TABLE 'Usuario', 'VicAgregaCondic',     'bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicActualizaCondic',  'bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicInactivaCondic', '  bit NULL'
EXEC spALTER_TABLE 'Usuario', 'VicEliminaCondic', '   bit NULL'
GO

EXEC spALTER_TABLE 'Usuario', 'vic_VerPlanoGramaDiseno',	   'bit', '0' 
EXEC spALTER_TABLE 'Usuario', 'vic_VerPlanoGramaProduccion',   'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_CopiarAccionesPlanoGrama',  'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_ActualizarPlanoGrama',      'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_EliminarPlanoGrama',        'bit', '0'
EXEC spALTER_TABLE 'Usuario', 'vic_AccionesPlanoGrama',        'bit', '0'
GO

-- select * from usuario where LEN(Contrasena)=32
-- Agegrar en spCopiarUsuarioCfg

if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioBC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioBC
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioABC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioABC
GO
-- Aqui va el Matenimiento a la tabla
IF not EXISTS(select * from sysobjects o, syscolumns c where c.id = o.id and o.id = object_id('dbo.Usuario') and c.name = 'Sucursal' and o.type = 'U')
  ALTER TABLE Usuario ADD Sucursal int NULL
if not exists(select * from syscampo where tabla = 'Usuario' and Campo = 'AbrirCajon')
  ALTER TABLE Usuario ADD AbrirCajon bit NULL DEFAULT 0 WITH VALUES
GO
if not exists(select * from syscampo where tabla = 'Usuario' and Campo='TieneMovimientos')
BEGIN
  EXEC("ALTER TABLE Usuario ADD TieneMovimientos bit NULL DEFAULT 0")
  EXEC("UPDATE Usuario SET TieneMovimientos = 1")
END
GO

/************************tgInforUsuarioABC********************/
IF EXISTS(SELECT * FROM sysobjects WHERE name='tgUsuarioABC' AND type='TR')
DROP TRIGGER tgUsuarioABC
GO
CREATE TRIGGER tgUsuarioABC ON Usuario
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @Ok				int,
    @TieneMovimientosN		bit,
    @TieneMovimientosA		bit,
    @UsuarioI			char(10), 
    @UsuarioD			char(10), 
    @ConfiguracionI		char(10),
    @ConfiguracionD		char(10),
    @AccesoI			char(10),
    @AccesoD			char(10),
    @ContrasenaI		varchar(32),
    @ContrasenaD		varchar(32),
    @ConfirmacionI		varchar(32),
    @ConfirmacionD		varchar(32),
    @Mensaje			varchar(255),
    @TamanoMinimo		int,
    @RequiereAlfa		bit,
    @RequiereNumeros	bit,
    @UsuarioConfig		char(10)


  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Ok = NULL
  SELECT @TamanoMinimo    = ISNULL(ContrasenaTamanoMinimo, 0),
         @RequiereAlfa    = ISNULL(ContrasenaRequiereAlfa, 0),
         @RequiereNumeros = ISNULL(ContrasenaRequiereNumeros, 0)
    FROM Version

  SELECT @UsuarioI = Usuario, @TieneMovimientosN = TieneMovimientos, @ConfiguracionI = NULLIF(RTRIM(Configuracion), ''), @AccesoI = NULLIF(RTRIM(Acceso), ''), @ContrasenaI = Contrasena, @ConfirmacionI = ContrasenaConfirmacion FROM Inserted
  SELECT @UsuarioD = Usuario, @TieneMovimientosA = TieneMovimientos, @ConfiguracionD = NULLIF(RTRIM(Configuracion), ''), @AccesoD = NULLIF(RTRIM(Acceso), ''), @ContrasenaD = Contrasena, @ConfirmacionD = ContrasenaConfirmacion FROM Deleted

  IF (NULLIF(@ConfiguracionI,'') IS NOT NULL AND @ConfiguracionI = @UsuarioI) OR (NULLIF(@AccesoI,'') IS NOT NULL AND @AccesoI = @UsuarioI)
  BEGIN
    RAISERROR ('No Puede Copiar Configuración o Accesos del Mismo Usuario',16,-1) 
	RETURN
  END
	
  SELECT  @UsuarioConfig=Configuracion from Usuario where Usuario =@UsuarioI
  IF UPDATE (Configuracion)
   EXEC spCopiarUsuarioMaestroCfg @UsuarioConfig
   
  IF @UsuarioI <> @UsuarioD
  BEGIN
    -- Si Inserto
     EXEC spCopiarUsuarioMaestroCfg @UsuarioConfig
    IF @UsuarioD IS NULL
    BEGIN
      DELETE UsuarioCfg2   WHERE Usuario = @UsuarioI 
      DELETE UsuarioAcceso WHERE Usuario = @UsuarioI 

      INSERT INTO UsuarioCfg2   (Usuario) VALUES (@UsuarioI)          
      INSERT INTO UsuarioAcceso (Usuario) VALUES (@UsuarioI)
    END ELSE
    BEGIN
      IF (@UsuarioI IS NULL AND @TieneMovimientosA = 1) OR  (@UsuarioI IS NOT NULL AND @TieneMovimientosN = 1)
      BEGIN
        SELECT @Mensaje = '"'+LTRIM(RTRIM(@UsuarioD))+ '" ' + Descripcion FROM MensajeLista WHERE Mensaje = 30150
        RAISERROR (@Mensaje,16,-1) 
      END

      -- Si Elimino 
      IF @UsuarioI IS NULL 
      BEGIN
        DELETE UsuarioD      	       WHERE Usuario = @UsuarioD
        DELETE UsuarioAcceso 	       WHERE Usuario = @UsuarioD
        DELETE UsuarioAccesoForma      WHERE Usuario = @UsuarioD
        DELETE UsuarioCfg2   	       WHERE Usuario = @UsuarioD
        DELETE UsuarioMovImporteMaximo WHERE Usuario = @UsuarioD
        DELETE UsuarioImpresora        WHERE Usuario = @UsuarioD
        DELETE Prop          	       WHERE Cuenta  = @UsuarioD AND Rama='USR'
        DELETE NotaCta       	       WHERE Cuenta  = @UsuarioD AND Rama='USR'
      END ELSE

      -- Si Modifico
      IF @UsuarioI <> @UsuarioD
      BEGIN
        UPDATE UsuarioD                SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE UsuarioAcceso           SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE UsuarioAccesoForma      SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE UsuarioCfg2             SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE UsuarioMovImporteMaximo SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE UsuarioImpresora        SET Usuario = @UsuarioI WHERE Usuario = @UsuarioD
        UPDATE Prop                    SET Cuenta  = @UsuarioI WHERE Cuenta  = @UsuarioD AND Rama='USR'
        UPDATE NotaCta                 SET Cuenta  = @UsuarioI WHERE Cuenta  = @UsuarioD AND Rama='USR'
      END
    END
  END

  IF @UsuarioI IS NOT NULL AND @ContrasenaD <> @ContrasenaI
  BEGIN
    IF @ContrasenaI <> @ConfirmacionI    SELECT @Ok = 60230/* ELSE
    IF LEN(@ContrasenaI) < @TamanoMinimo SELECT @Ok = 60231 ELSE
    IF @RequiereNumeros = 1 AND (SELECT dbo.fnTieneNumero(@ContrasenaI)) = 0 SELECT @Ok = 60232 ELSE
    IF @RequiereAlfa    = 1 AND (SELECT dbo.fnTieneAlfa(@ContrasenaI))   = 0 SELECT @Ok = 60233*/
  END

  IF @Ok IS NOT NULL
  BEGIN
    SELECT @Mensaje = RTRIM(@UsuarioI)+' '+Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END

  IF @ContrasenaI <> @ContrasenaD
    UPDATE Usuario SET ContrasenaFecha = GETDATE() WHERE Usuario = @UsuarioI

  IF @UsuarioI IS NOT NULL 
  BEGIN
    IF @ConfiguracionI IS NULL 
      EXEC spCopiarTablaLista 'Usuario', @UsuarioI
    ELSE BEGIN
      IF @ConfiguracionI <> @ConfiguracionD
        EXEC spCopiarTabla 'Usuario', @ConfiguracionI, @UsuarioI
    END

    IF @AccesoI IS NULL 
      EXEC spCopiarTablaLista 'UsuarioAcceso', @UsuarioI
    ELSE BEGIN
      IF @AccesoI <> @AccesoD
        EXEC spCopiarTabla 'UsuarioAcceso', @ConfiguracionI, @UsuarioI
    END
  END
END
GO

/************************tgInforUsuarioABC********************/
IF EXISTS(SELECT * FROM sysobjects WHERE name='tgInforUsuarioABC' AND type='TR')
DROP TRIGGER tgInforUsuarioABC
GO
CREATE TRIGGER tgInforUsuarioABC ON Usuario
--//WITH ENCRYPTION
FOR INSERT, UPDATE ,DELETE
AS BEGIN
  DECLARE
   @ProdInterfazINFOR					bit,
   @Usuario 							varchar (10),
   @Nombre	 							varchar (10),
   @Estatus							    varchar (10),
   @Datos								varchar (max),
   @Ok									int,
   @OkRef								varchar(255),
   @Id									int,
   @Cinserted		                	int,
   @Cdeleted			                int,
   @ReferenciaIntelisisService			varchar(50),
   @Empresa								varchar(20) ,
   @Alta								datetime,
   @Cinfo                               varbinary(128),
   @EstatusIns						    varchar (10),
   @EstatusDel						    varchar (10),
   @EstatusUsuarioA					    varchar (10), -- 02/11/2015
   @EstatusUsuarioN					    varchar (10), -- 02/11/2015
   @EstatusInfor						varchar(10) -- 02/11/2015


  SELECT @ID = dbo.fnAccesoID(@@SPID)
  SELECT @Cinfo = Context_Info()  
  IF @Cinfo = 0x55555  
    RETURN  
  
  SELECT @Empresa = Empresa FROM Acceso WHERE ID = @ID

  SELECT @ProdInterfazINFOR = ProdInterfazINFOR
    FROM EmpresaGral WHERE Empresa = @Empresa

  SELECT @Cinserted =  COUNT(*) FROM inserted
  SELECT @Cdeleted =  COUNT(*) FROM deleted

  IF @Cinserted = 1 OR @Cdeleted=1 -- Puede haber casos en que el primer registro no sea el que sea baja
  BEGIN
  SELECT @EstatusIns = Estatus FROM inserted
  SELECT @EstatusDel = Estatus FROM deleted
  
  IF (@EstatusIns <> 'BAJA' AND @EstatusDel = 'BAJA')
  BEGIN
	SELECT @Ok = 71020, @OkRef = 'No se permite modificar el Estatus de usuarios dados de BAJA  - ' + Usuario FROM inserted
	UPDATE Usuario set Estatus = @EstatusDel WHERE Usuario = (SELECT Usuario FROM inserted)
	RAISERROR(@OkRef, 16, 1)
  END
  END
  
  IF @Ok IS NULL AND @ProdInterfazINFOR = 1
  BEGIN
    IF @Cinserted <> 0 AND @Cdeleted = 0 
    BEGIN
      SET @Estatus = 'ALTA' 
    END
    IF @Cinserted <> 0 AND @Cdeleted<> 0 
    BEGIN
      SET @Estatus = 'CAMBIO'
    END
    --Se comenta ya que en una actualización masiva, si el estatus del primer registro es baja, todos los considera como bajas
    IF (@Cinserted = 0 AND @Cdeleted <> 0) --or (@EstatusIns <> 'ALTA')  --02/11/2015
    BEGIN 
      SET @Estatus = 'BAJA'
    END
    
    IF  @Estatus IN( 'ALTA','CAMBIO')
    BEGIN
      DECLARE  crActualizar CURSOR LOCAL FAST_FORWARD FOR
       SELECT  Usuario, ReferenciaIntelisisService, Nombre, Alta, Estatus
         FROM Inserted
    END

    IF @Estatus = 'BAJA'
    BEGIN
	 DECLARE  crActualizar CURSOR LOCAL FAST_FORWARD FOR
	  SELECT  Usuario, ReferenciaIntelisisService, Nombre, Alta, Estatus
       FROM Deleted    
    END   
    

    IF @Estatus IN( 'ALTA','CAMBIO', 'BAJA') 
    BEGIN     
      OPEN  crActualizar
      FETCH NEXT FROM crActualizar INTO @Usuario, @ReferenciaIntelisisService, @Nombre, @Alta, @EstatusUsuarioN
      WHILE @@FETCH_STATUS = 0 
      BEGIN
      
      --02/11/2015
		SELECT @EstatusUsuarioA='', @EstatusInfor=''
		SELECT @EstatusInfor = @Estatus
 
		IF @Estatus ='CAMBIO' 
		BEGIN
		SELECT @EstatusUsuarioA = Estatus FROM Deleted WHERE Usuario=@Usuario
		 
		 IF (@EstatusUsuarioN <> 'BAJA' AND @EstatusUsuarioA = 'BAJA')
		  BEGIN
			SELECT @Ok = 71020, @OkRef = 'No se permite modificar el Estatus de usuarios dados de BAJA  - ' + @Usuario
			UPDATE Usuario SET Estatus = @EstatusUsuarioA WHERE Usuario = @Usuario
			RAISERROR(@OkRef, 16, 1)
		  END
		  
		
		  IF @EstatusUsuarioN = 'BAJA' AND @EstatusUsuarioA <> 'BAJA'
		  SELECT @EstatusInfor = 'BAJA'
		  
		END
           -- SELECT 'EXEC  spInforGenerarSolicitudUsuario',@Usuario, @Estatus, @ReferenciaIntelisisService, @Nombre, @Alta, @Datos

		--EXEC  spInforGenerarSolicitudUsuario  @Usuario, @Estatus, @ReferenciaIntelisisService, @Nombre, @Alta, @Datos OUTPUT
		EXEC  spInforGenerarSolicitudUsuario  @Usuario, @EstatusInfor, @ReferenciaIntelisisService, @Nombre, @Alta, @Datos OUTPUT

		FETCH NEXT FROM crActualizar INTO @Usuario, @ReferenciaIntelisisService, @Nombre, @Alta, @EstatusUsuarioN
      --02/11/2015
      END
      CLOSE crActualizar
      DEALLOCATE crActualizar  
    END  
  END
END
GO

/* NOTA Si se agregan campos modificar \SPOtros\spGenerales\spCopiarUsuarioCfg */

/****** Configuracion2 del Usuario ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioCfg2')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioCfg2','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioCfg2') and type = 'U') 
CREATE TABLE dbo.UsuarioCfg2 (
	Usuario 			varchar(10)  	NOT NULL,
	
	CxcMovExpress			bit		NOT NULL	DEFAULT 0,
	CxpMovExpress			bit		NOT NULL	DEFAULT 0,
	
	Logico1				bit		NOT NULL	DEFAULT 0,
	Logico2				bit		NOT NULL	DEFAULT 0,
	Logico3				bit		NOT NULL	DEFAULT 0,
	Logico4				bit		NOT NULL	DEFAULT 0,
	Logico5				bit		NOT NULL	DEFAULT 0,
	Logico6				bit		NOT NULL	DEFAULT 0,
	Logico7				bit		NOT NULL	DEFAULT 0,
	Logico8				bit		NOT NULL	DEFAULT 0,
	Logico9				bit		NOT NULL	DEFAULT 0,
	Logico10			bit		NOT NULL	DEFAULT 0,
	Logico11			bit		NOT NULL	DEFAULT 0,
	Logico12			bit		NOT NULL	DEFAULT 0,
	Logico13			bit		NOT NULL	DEFAULT 0,
	Logico14			bit		NOT NULL	DEFAULT 0,
	Logico15			bit		NOT NULL	DEFAULT 0,
	Logico16			bit		NOT NULL	DEFAULT 0,
	Logico17			bit		NOT NULL	DEFAULT 0,
	Logico18			bit		NOT NULL	DEFAULT 0,
	Logico19			bit		NOT NULL	DEFAULT 0,
	Logico20			bit		NOT NULL	DEFAULT 0,
	Logico21			bit		NOT NULL	DEFAULT 0,
	Logico22			bit		NOT NULL	DEFAULT 0,
	Logico23			bit		NOT NULL	DEFAULT 0,
	Logico24			bit		NOT NULL	DEFAULT 0,
	Logico25			bit		NOT NULL	DEFAULT 0,
	Logico26			bit		NOT NULL	DEFAULT 0,
	Logico27			bit		NOT NULL	DEFAULT 0,
	Logico28			bit		NOT NULL	DEFAULT 0,
	Logico29			bit		NOT NULL	DEFAULT 0,
	Logico30			bit		NOT NULL	DEFAULT 0,
	Logico31			bit		NOT NULL	DEFAULT 0,
	Logico32			bit		NOT NULL	DEFAULT 0,
	Logico33			bit		NOT NULL	DEFAULT 0,
	Logico34			bit		NOT NULL	DEFAULT 0,
	Logico35			bit		NOT NULL	DEFAULT 0,
	Logico36			bit		NOT NULL	DEFAULT 0,
	Logico37			bit		NOT NULL	DEFAULT 0,
	LimitarCompraLocal		bit		NOT NULL	DEFAULT 0,
	VentaSugerirDisponible		bit		NOT NULL	DEFAULT 0,
	Digitalizar			bit		NOT NULL	DEFAULT 0,
	AutorizarProdAvances		bit		NOT NULL	DEFAULT 0,
	ModificarProdCostosAd		bit		NOT NULL	DEFAULT 0,
	ModificarAnexosMovConcluidos	bit		NOT NULL	DEFAULT 0,
	ControlAlmacenes		bit		NOT NULL	DEFAULT 0,
	ControlAlmacenesEnAlm		bit		NULL		DEFAULT 0,
	ControlListasPrecios		bit		NULL		DEFAULT 0,
	ModificarObservaciones		bit		NOT NULL	DEFAULT 0,
	BloquearMonedaArtPrecio		bit		NOT NULL	DEFAULT 0,
	BloquearMonedaArtCosto		bit		NOT NULL	DEFAULT 0,
	AfectarLote			bit		NOT NULL	DEFAULT 0,
	CancelarLote			bit		NOT NULL	DEFAULT 0,
	ContabilizarLote		bit		NOT NULL	DEFAULT 0,
	ModificarClienteBackOrder	bit		NOT NULL	DEFAULT 0,
	GastoModificarProrrateo		bit		NULL		DEFAULT 0,
	InvFisicoAlmacen		bit		NULL		DEFAULT 0,
	CompraSugerirDisponible		bit		NULL		DEFAULT 0,
	PedidoGenerarOT			bit		NULL		DEFAULT 0,
        PedidoGenerarOTAbrir		bit		NULL		DEFAULT 0,
	BloquearMaestrosPersonal	bit		NULL		DEFAULT 0,
	BloquearAltaExpressPersonal	bit		NULL		DEFAULT 0,
	GastosPV			bit		NULL		DEFAULT 0,
	CompraGenerarOrdenesAlProcesar	bit		NULL		DEFAULT 0,
	GastosEditarDeducible		bit		NULL		DEFAULT 0,
	PlanEditarOrdenes		bit		NULL		DEFAULT 0,
	PlanOrdenCompra			varchar(20)	NULL,
	PlanOrdenProduccion		varchar(20)	NULL,
	PlanOrdenTransferencia		varchar(20)	NULL,
	PlanOrdenTraspaso		varchar(20)	NULL,
	TraspasarMovimientos		bit		NULL		DEFAULT 0,
	CancelarEmbarquesExplorador	bit		NULL		DEFAULT 0,
	OcultarDineroCtaDineroSaldo	bit		NULL		DEFAULT 0,
	RecibirDemasSinLimites		bit		NULL		DEFAULT 0,
	ModificarFactorMovTipo		bit		NULL		DEFAULT 0,
	BloquearListaMateriales		bit		NULL		DEFAULT 0,
	VINTransferirComponentes	bit		NULL		DEFAULT 0,
	TransferirEntradas		bit		NULL		DEFAULT 0,
	LimitarDialogoAbrirGuardar	bit		NULL		DEFAULT 0,
	ModificarEstatusCuotaCx		bit		NULL		DEFAULT 0,
	ModificarGestionAgenda		bit		NULL		DEFAULT 0,	
	AgendaAccesoOtrosModulos	bit		NULL		DEFAULT 0,

	ModificarAsistenciaExtra	bit		NULL		DEFAULT 0,
	ModificarAsisteMovimientoRef	bit		NULL		DEFAULT 0,
	ModificarAsisteGestionRef	bit		NULL		DEFAULT 0,
	ModificarAsisteActividadABCRef	bit		NULL		DEFAULT 0,
	SincroISNotificarError			bit		NULL		DEFAULT 0,
	NotificacionAlAcceso			bit		NULL		DEFAULT 0, --MEJORA5066
	eCommerce						bit		NULL		DEFAULT 0, -- REQ13987
	eCommerceMostrarHerramienta			bit		NULL		DEFAULT 0, -- BUG14953
	CONSTRAINT priUsuarioCfg2 PRIMARY KEY  CLUSTERED (Usuario)
)
GO
EXEC spALTER_TABLE 'UsuarioCfg2', 'GastoModificarProrrateo','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'InvFisicoAlmacen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ControlListasPrecios', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'CompraSugerirDisponible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PedidoGenerarOT', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'BloquearMaestrosPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'GastosPV', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'CompraGenerarOrdenesAlProcesar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'GastosEditarDeducible', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PlanEditarOrdenes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PlanOrdenCompra', 'varchar(20) NULL'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PlanOrdenProduccion', 'varchar(20) NULL'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PlanOrdenTransferencia', 'varchar(20) NULL'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PlanOrdenTraspaso', 'varchar(20) NULL'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ContabilizarLote', 'bit NULL	DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'TraspasarMovimientos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ControlAlmacenesEnAlm', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'BloquearAltaExpressPersonal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'CancelarEmbarquesExplorador', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'OcultarDineroCtaDineroSaldo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'RecibirDemasSinLimites', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarFactorMovTipo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'BloquearListaMateriales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'VINTransferirComponentes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'PedidoGenerarOTAbrir','bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'TransferirEntradas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'LimitarDialogoAbrirGuardar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarEstatusCuotaCx', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarGestionAgenda', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'AgendaAccesoOtrosModulos', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarAsisteExtra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarAsistenciaExtra', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarAsisteMovimientoRef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarAsisteGestionRef', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'ModificarAsisteActividadABCRef', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'UsuarioCfg2', 'SincroISNotificarError', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'NotificacionAlAcceso', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA5066
GO

-- REQ13987
Exec spAlter_Table 'UsuarioCfg2', 'eCommerce',' bit NULL DEFAULT 0'
-- BUG14953
Exec spAlter_Table 'UsuarioCfg2', 'eCommerceMostrarHerramienta',' bit NULL DEFAULT 0'
if (select version from version)<=3192
BEGIN
  EXEC("spEliminarPK 'UsuarioCfg2'")	
  EXEC("spALTER_COLUMN 'UsuarioCfg2' ,'Usuario', 'varchar(10) NOT NULL'")  
  EXEC("ALTER TABLE UsuarioCfg2 ADD CONSTRAINT priUsuarioCfg2 PRIMARY KEY CLUSTERED (Usuario)")
END
GO
EXEC spALTER_COLUMN 'UsuarioCfg2' ,'PlanOrdenCompra' ,'varchar(20)	NULL'
EXEC spALTER_COLUMN 'UsuarioCfg2' ,'PlanOrdenProduccion' ,'varchar(20)	NULL'
EXEC spALTER_COLUMN 'UsuarioCfg2' ,'PlanOrdenTransferencia' ,'varchar(20) NULL'
EXEC spALTER_COLUMN 'UsuarioCfg2' ,'PlanOrdenTraspaso' ,'varchar(20) NULL'
GO

--BUG22313
EXEC spALTER_TABLE 'UsuarioCfg2', 'InterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'UsuarioCfg2', 'AccesoInterfazExentus', 'bit NULL DEFAULT 0 WITH VALUES'
GO

--REQ25014
EXEC spALTER_TABLE 'UsuarioCfg2', 'CONTPModificarDatosMov', 'bit NULL DEFAULT 0 WITH VALUES'
GO
EXEC spALTER_TABLE 'UsuarioCfg2', 'PorcentajeCondMoratorioMAVI', 'float NULL'
GO

EXEC spFK 'UsuarioCfg2','Usuario','Usuario','Usuario'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioCfg2C') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioCfg2C
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgUsuarioCfg2C ON UsuarioCfg2
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Usuario		char(10), 
    @Configuracion	char(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Usuario = Usuario FROM Inserted
  SELECT @Configuracion = NULLIF(RTRIM(Configuracion), '') FROM Usuario WHERE Usuario = @Usuario

  IF @Usuario IS NOT NULL 
  BEGIN
    IF @Configuracion IS NULL 
      EXEC spCopiarUsuarioMaestroCfg @Usuario
    ELSE
      EXEC spCopiarUsuarioCfg @Configuracion, @Usuario
  END
END
GO

/* NOTA Si se agregan campos modificar \SPOtros\spGenerales\spCopiarUsuarioCfg */

/****** UsuariosD ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioD') and type = 'U') 
CREATE TABLE dbo.UsuarioD (
	Usuario 		varchar(10)  	NOT NULL,
	Empresa			varchar(5)	 	NOT NULL,

	CONSTRAINT priUsuarioD PRIMARY KEY CLUSTERED (Usuario,Empresa)
)
GO

if (select version from version)<=3299
BEGIN
  EXEC("spEliminarPK 'UsuarioD'")	
  EXEC("spALTER_COLUMN 'UsuarioD' ,'Usuario', 'varchar(10) NOT NULL'")  
  EXEC("spALTER_COLUMN 'UsuarioD' ,'Empresa', 'varchar(5) NOT NULL'")  
  EXEC("ALTER TABLE UsuarioD ADD CONSTRAINT priUsuarioD PRIMARY KEY CLUSTERED (Usuario,Empresa)")
END
GO

EXEC spFK 'UsuarioD','Usuario','Usuario','Usuario'
EXEC spFK 'UsuarioD','Empresa','Empresa','Empresa'
GO

/****** UsuarioAccesoForma ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioAccesoForma')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioAccesoForma','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioAccesoForma') and type = 'U') 
CREATE TABLE dbo.UsuarioAccesoForma (
	Usuario 		varchar(10)  	NOT NULL,
	Forma			varchar(100)	NOT NULL,

	CONSTRAINT priUsuarioAccesoForma PRIMARY KEY CLUSTERED (Usuario, Forma)
)
GO


/****** UsuarioSucursalAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioSucursalAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioSucursalAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioSucursalAcceso') and type = 'U') 
CREATE TABLE dbo.UsuarioSucursalAcceso (
	Usuario 		char(10)  	NOT NULL,
	Sucursal		int	 	NOT NULL,

	CONSTRAINT priUsuarioSucursalAcceso PRIMARY KEY CLUSTERED (Usuario, Sucursal)
)
GO

EXEC spFK 'UsuarioSucursalAcceso','Sucursal','Sucursal','Sucursal' --(No procesado)
GO

/****** UsuarioMovCancelacionEx ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioMovCancelacionEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioMovCancelacionEx','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioMovCancelacionEx') and type = 'U') 
CREATE TABLE dbo.UsuarioMovCancelacionEx (
	Usuario 		char(10)  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov			char(20) 	NOT NULL,

	CONSTRAINT priUsuarioMovCancelacionEx PRIMARY KEY CLUSTERED (Usuario, Modulo, Mov)
)
GO

/****** UsuarioModuloEx ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioModuloEx')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioModuloEx','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioModuloEx') and type = 'U') 
CREATE TABLE dbo.UsuarioModuloEx (
	Usuario 		char(10)  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	
	BloquearFiltroSucursal	bit		NULL	DEFAULT 0,

	CONSTRAINT priUsuarioModuloEx PRIMARY KEY CLUSTERED (Usuario, Modulo)
)
GO

/****** UsuarioPrecios ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioPrecios')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioPrecios','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioPrecios') and type = 'U') 
CREATE TABLE dbo.UsuarioPrecios (
	Usuario 	char(10)  	NOT NULL,
	ListaPrecios	varchar(20)	NOT NULL,

	CONSTRAINT priUsuarioPrecios PRIMARY KEY CLUSTERED (Usuario, ListaPrecios)
)
GO


/****** UsuarioImpresora ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioImpresora')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioImpresora','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioImpresora') and type = 'U') 
CREATE TABLE dbo.UsuarioImpresora (
	Usuario 	char(10)  	NOT NULL,
	Impresora	varchar(255)	NOT NULL,

	Orden		int		NULL,

	CONSTRAINT priUsuarioImpresora PRIMARY KEY CLUSTERED (Usuario, Impresora)
)
GO
if not exists (SELECT * FROM sysindexes, sysobjects WHERE sysobjects.name = 'UsuarioImpresora' AND sysindexes.name = 'Orden' AND sysobjects.id = sysindexes.id)
  CREATE INDEX Orden ON dbo.UsuarioImpresora (Usuario, Orden)
GO


/****** UsuarioMovImporteMaximo ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioMovImporteMaximo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioMovImporteMaximo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioMovImporteMaximo') and type = 'U') 
CREATE TABLE dbo.UsuarioMovImporteMaximo (
	Usuario 		char(10)  	NOT NULL,
	Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,

	ImporteMaximo		money		NULL,
	NoDeducibleMaximo	money		NULL,
	DescuentoMaximo		money		NULL,
	DescuentoGlobalMaximo	float		NULL,
	DescuentoLineaMaximo	float		NULL,

	CONSTRAINT priUsuarioMovImporteMaximo PRIMARY KEY CLUSTERED (Usuario, Modulo, Mov)
)
GO
EXEC spALTER_TABLE 'UsuarioMovImporteMaximo', 'NoDeducibleMaximo', 'money NULL'
EXEC spALTER_TABLE 'UsuarioMovImporteMaximo', 'DescuentoMaximo', 'money NULL'
EXEC spALTER_TABLE 'UsuarioMovImporteMaximo', 'DescuentoGlobalMaximo', 'float NULL'
EXEC spALTER_TABLE 'UsuarioMovImporteMaximo', 'DescuentoLineaMaximo', 'float NULL'
go

/****** UsuariosAcceso ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioAcceso')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioAcceso','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioAcceso') and type = 'U') 
CREATE TABLE dbo.UsuarioAcceso (
	Usuario 		char(10)  	NOT NULL,

	MenuPrincipal		text		NULL,
	MovsEdicion		text		NULL,
	MovsConsulta		text		NULL,
	MovsAutorizar		text		NULL,
	Reportes		text		NULL,

	CONSTRAINT priUsuarioAcceso PRIMARY KEY CLUSTERED (Usuario)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioAccesoC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioAccesoC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgUsuarioAccesoC ON UsuarioAcceso
--//WITH ENCRYPTION
FOR UPDATE
AS BEGIN
  DECLARE
    @Usuario	char(10), 
    @Acceso	char(10)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @Usuario = Usuario FROM Inserted
  SELECT @Acceso = NULLIF(RTRIM(Acceso), '') FROM Usuario WHERE Usuario = @Usuario

  IF @Usuario IS NOT NULL AND @Acceso IS NULL 
    EXEC spCopiarUsuarioMaestroAcceso @Usuario
END
GO

/****** UsuarioPerfilFormaD ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioPerfilFormaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioPerfilFormaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioPerfilFormaD') and type = 'U') 
CREATE TABLE dbo.UsuarioPerfilFormaD (
	Perfil		varchar(50)  	NOT NULL,
	Forma		varchar(100)	NOT NULL,
	
	Estatus		varchar(15)	NULL,
	FormaVirtual	varchar(100)	NULL,

	CONSTRAINT priUsuarioPerfilFormaD PRIMARY KEY CLUSTERED (Perfil, Forma)
)
GO

/****** UsuarioPerfilForma ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioPerfilForma')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioPerfilForma','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioPerfilForma') and type = 'U') 
CREATE TABLE dbo.UsuarioPerfilForma (
	Perfil		varchar(50)  	NOT NULL,

	CONSTRAINT priUsuarioPerfilForma PRIMARY KEY CLUSTERED (Perfil)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgUsuarioPerfilFormaBC') and sysstat & 0xf = 8) drop trigger dbo.tgUsuarioPerfilFormaBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgUsuarioPerfilFormaBC ON UsuarioPerfilForma
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @PerfilA	varchar(50),
    @PerfilN	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  IF UPDATE(Perfil)
  BEGIN
    SELECT @PerfilA = Perfil FROM Deleted
    SELECT @PerfilN = Perfil FROM Inserted
    
    IF @PerfilA <> @PerfilN 
      UPDATE UsuarioPerfilFormaD SET Perfil = @PerfilN WHERE Perfil = @PerfilA
  END
END
GO

/****** UsuarioAlm ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioAlm')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('UsuarioAlm','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioAlm') and type = 'U') 
CREATE TABLE dbo.UsuarioAlm (
	Usuario 	varchar(10)  	NOT NULL,
	Almacen		char(10)	NOT NULL,

	CONSTRAINT priUsuarioAlm PRIMARY KEY CLUSTERED (Usuario, Almacen)
)
GO

if (select version from version)<=3299
BEGIN
  EXEC("spEliminarPK 'UsuarioAlm'")	
  EXEC("spALTER_COLUMN 'UsuarioAlm' ,'Usuario', 'varchar(10) NOT NULL'")  
  EXEC("ALTER TABLE UsuarioAlm ADD CONSTRAINT priUsuarioAlm PRIMARY KEY CLUSTERED (Usuario,Almacen)")
END
GO

EXEC spFK 'UsuarioAlm','Usuario','Usuario','Usuario'
GO

/****** SucursalRegion ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalRegion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalRegion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalRegion') and type = 'U') 
CREATE TABLE dbo.SucursalRegion (
	Region	varchar(50) 	NOT NULL,

	CONSTRAINT priSucursalRegion PRIMARY KEY  CLUSTERED (Region)
)
GO



/****** SucursalGrupo ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalGrupo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalGrupo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalGrupo') and type = 'U') 
CREATE TABLE dbo.SucursalGrupo (
	Grupo	varchar(50) 	NOT NULL,

	CONSTRAINT priSucursalGrupo PRIMARY KEY  CLUSTERED (Grupo)
)
GO

/****** SucursalCat ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalCat')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalCat','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalCat') and type = 'U') 
CREATE TABLE dbo.SucursalCat (
	Categoria	varchar(50) 	NOT NULL,

	CONSTRAINT priSucursalCat PRIMARY KEY  CLUSTERED (Categoria)
)
GO

/****** SucursalTipo ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalTipo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalTipo','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalTipo') and type = 'U') 
CREATE TABLE dbo.SucursalTipo (
	Tipo		varchar(50) 	NOT NULL,

	CONSTRAINT priSucursalTipo PRIMARY KEY  CLUSTERED (Tipo)
)
GO


/****** SucursalCfgCR ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalCfgCR')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalCfgCR','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalCfgCR') and type = 'U') 
BEGIN
  CREATE TABLE dbo.SucursalCfgCR (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL IDENTITY (1,1),

	Agente			char(10)	NULL,

	CONSTRAINT priSucursalCfgCR PRIMARY KEY CLUSTERED (Sucursal, ID)
  )
  EXEC spSincroSemilla 'SucursalCfgCR'
END
GO

/****** SucursalBanco ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalBanco')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalBanco','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalBanco') and type = 'U') 
CREATE TABLE dbo.SucursalBanco (
	Sucursal		int	 	NOT NULL,
	Institucion		char(20)	NOT NULL,
	Numero			int		NOT NULL,

	CONSTRAINT priSucursalBanco PRIMARY KEY  CLUSTERED (Sucursal, Institucion, Numero)
)
go


/****** Sucursal ******/
if exists (select * from syscampo where tabla = 'Sucursal' and Campo = 'Banco') and not exists (select * from sysobjects where id = object_id('dbo.BancoSucursal') and type = 'U') 
BEGIN
  EXEC("sp_rename 'Sucursal', 'BancoSucursal'")
  EXEC("spEliminarPK 'BancoSucursal'")
  EXEC("sp_rename 'BancoSucursal.Sucursal', 'BancoSucursal', 'COLUMN'")
  EXEC("ALTER TABLE BancoSucursal ADD CONSTRAINT priBancoSucursal PRIMARY KEY CLUSTERED (BancoSucursal)")
  EXEC("UPDATE SysTabla SET SysTabla = 'BancoSucursal' WHERE SysTabla = 'Sucursal'")
END
GO
if not exists(select * from SysTabla where SysTabla = 'Sucursal')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Sucursal','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.Sucursal') and type = 'U') 
CREATE TABLE dbo.Sucursal (
	Sucursal	 	int	  	NOT NULL,

	Nombre			varchar(100) 	NULL,
	Prefijo			char(5)		NULL,
	Relacion		varchar(20)	NOT NULL,	-- En Linea / Sincronizacion

	Direccion 		varchar(100) 	NULL,
	DireccionNumero		varchar(20) 	NULL,
	DireccionNumeroInt	varchar(20) 	NULL,
	Delegacion		varchar(100) 	NULL,
	GLN			varchar(50) 	NULL,
	Colonia 		varchar(30)  	NULL,
	Poblacion 		varchar(30)  	NULL,
	Estado 			varchar(30)  	NULL,
	Pais			varchar(30)     NULL,
	CodigoPostal 		varchar(15)  	NULL,
	Telefonos 		varchar(100)  	NULL,
	Fax	 		varchar(50)     NULL,

	Estatus			char(15) 	NOT NULL,
	UltimoCambio		datetime  	NULL,

	RFC			varchar(20)	NULL,
	RegistroPatronal	varchar(20)	NULL,

	Encargado		varchar(100)	NULL,
	Alta			datetime	NULL,

	Region			varchar(50)	NULL,
	CentralRegional		bit		NULL	DEFAULT 0,
	EnLinea			bit		NULL	DEFAULT 0,
	SucursalPrincipal	int		NULL,
	ListaPreciosEsp		varchar(20)	NULL,
	Cajeros			bit		NULL	DEFAULT 1,
	CentroCostos		varchar(20)	NULL,
	OperacionContinua	bit		NULL	DEFAULT 0,
	ZonaEconomica		varchar(30)	NULL,
	Grupo			varchar(50)	NULL,
	AlmacenPrincipal	char(10)	NULL,
	Servidor		varchar(50)	NULL,
	BaseDatos		varchar(50)	NULL,
	Usuario			varchar(10)	NULL,
	ZonaImpuesto		varchar(30)	NULL,
	CajaCentral		varchar(10)	NULL,

	wMovVentas		varchar(20)	NULL	DEFAULT 'Pedido',
	wAlmacen		varchar(10)	NULL,
	wAgente			varchar(10)	NULL,
	wUsuario		varchar(10)	NULL,
	wUEN			int		NULL,
	wConcepto		varchar(50)	NULL,

	CRTipoCredito		varchar(20)	NULL	DEFAULT 'Tesoreria',		-- Tesoreria/Cuentas por Cobrar
	Cliente			varchar(10)	NULL,
	Categoria		varchar(50)	NULL,
	Acreedor		varchar(10)	NULL,
	LocalidadCNBV		varchar(10)	NULL,

	Tipo			varchar(50)	NULL,
	FechaApertura		datetime	NULL,
	VencimientoContrato	datetime	NULL,
	Metros			float		NULL,

	CostoBase			varchar(50)	NULL		DEFAULT '(Costo Reposicion)',
	UltimaSincronizacion	datetime	NULL,
	IP			varchar(20)	NULL,
	IPDinamica		bit		NULL	DEFAULT 0,
	IPPuerto		int		NULL,
	ComunicacionEncriptada	bit		NULL	DEFAULT 1,

	MapaLatitud		float		NULL,
	MapaLongitud		float		NULL,
	MapaPrecision			int		NULL,
	BloquearCobroTarjeta	bit		NULL DEFAULT 0,
	FiscalRegimen			varchar(30)	NULL,
	FiscalZona				varchar(30)	NULL, --MEJORA4769	

    CFDFlex					bit				NULL		DEFAULT 0,
	noCertificado			varchar(20)		NULL,
	Llave					varchar(255)	NULL,
	ContrasenaSello			varchar(100)	NULL,
	CertificadoBase64		varchar(max)	NULL,
	RutaCertificado			varchar(255)	NULL,
        ReferenciaIntelisisService      varchar(30)	NULL,--REQ12534 Factory  
        SucursalLDI                     varchar(20)     NULL, --REQ13386
        eCommerce                       bit             NULL DEFAULT 0,-- REQ13987
        eCommerceOffLine                bit             NULL DEFAULT 0,-- REQ13987
        eCommerceSucursal               varchar(10)     NULL,-- REQ13987
        eCommerceImagenes               varchar(50)     NULL,-- REQ13987
        eCommerceAlmacen                varchar(10)     NULL,-- REQ13987
        eCommerceListaPrecios           varchar(20)     NULL,-- REQ13987
        eCommercePedido                 varchar(20)     NULL,-- REQ13987
        eCommerceEstrategiaDescuento    varchar(20)     NULL,-- REQ13987
        eCommerceArticuloFlete          varchar(20)     NULL,-- REQ13987
        eCommerceTipoConsecutivo        varchar(20)     NULL,-- REQ13987
        eCommerceCondicion              varchar(50)     NULL,-- REQ13987
        eCommerceCajero                 varchar(10)     NULL,-- REQ13987
        eCommerceCteCat                 varchar(50)     NULL,-- REQ13987
        eCommerceAgente                 varchar(10)     NULL,-- REQ13987
        eCommerceSincroniza             bit             NULL DEFAULT 1 ,-- REQ13987
        eCommerceImpuestoIncluido       bit             NULL DEFAULT 0 ,-- REQ13987       	
        POSMensajeLimiteCaja            bit             NULL DEFAULT 0 ,--REQ 13393 POS      
        HOST                            varchar(20)     NULL,--REQ 13393 POS  
        POSLimiteCaja                   float     NULL,--REQ 13393 POS 
        ParamAccDirIntelisisMES         varchar(255)   NULL, 
        	

	CONSTRAINT priSuc PRIMARY KEY CLUSTERED (Sucursal)
)
GO



	






if exists (select * from sysobjects where id = object_id('dbo.tgSucursalABC') and sysstat & 0xf = 8) drop trigger dbo.tgSucursalABC
GO
-- Aqui va el Matenimiento a la tabla
if not exists(select * from syscampo where tabla = 'Sucursal' and campo = 'EnLinea')
  ALTER TABLE Sucursal ADD EnLinea bit NULL DEFAULT 0 WITH VALUES
GO
if not exists(select * from syscampo where tabla = 'Sucursal' and campo = 'SucursalPrincipal')
  ALTER TABLE Sucursal ADD SucursalPrincipal int NULL
GO
EXEC spALTER_TABLE 'Sucursal', 'Region', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'ListaPreciosEsp', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Cajeros', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'CentroCostos', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'OperacionContinua', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'wMovVentas', 'varchar(20) NULL DEFAULT "Pedido" WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'wAlmacen', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'wAgente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'wUsuario', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'wUEN', 'int NULL'
EXEC spALTER_TABLE 'Sucursal', 'wConcepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'CentralRegional', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'ZonaEconomica', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Grupo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'AlmacenPrincipal', 'char(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Servidor', 'varchar(50)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'BaseDatos', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Usuario', 'char(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'ZonaImpuesto', 'varchar(30) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Alta', 'datetime NULL'
EXEC spALTER_TABLE 'Sucursal', 'RegistroPatronal', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'CajaCentral', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'CRTipoCredito', 'varchar(20) NULL DEFAULT "Tesoreria" WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'Cliente', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Categoria', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Acreedor', 'varchar(10)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'LocalidadCNBV', 'varchar(10) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Tipo', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'FechaApertura', 'datetime NULL'
EXEC spALTER_TABLE 'Sucursal', 'VencimientoContrato', 'datetime	NULL'
EXEC spALTER_TABLE 'Sucursal', 'Metros', 'float NULL'
EXEC spALTER_TABLE 'Sucursal', 'DireccionNumero', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'DireccionNumeroInt', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Delegacion', 'varchar(100) NULL'
EXEC spALTER_TABLE 'Sucursal', 'GLN', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'CostoBase', 'varchar(50) NULL'
EXEC spALTER_TABLE 'Sucursal', 'UltimaSincronizacion', 'datetime NULL'
EXEC spDROP_COLUMN 'Sucursal', 'SSB_TCP'
EXEC spALTER_TABLE 'Sucursal', 'IP', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'IPDinamica', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'IPPuerto', 'int NULL'
EXEC spALTER_TABLE 'Sucursal', 'ComunicacionEncriptada', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'MapaLatitud', 'float NULL'
EXEC spALTER_TABLE 'Sucursal', 'MapaLongitud', 'float NULL'
EXEC spALTER_TABLE 'Sucursal', 'MapaPrecision', 'int NULL'
EXEC SPALTER_TABLE 'Sucursal', 'BloquearCobroTarjeta', 'bit NULL DEFAULT 0 WITH VALUES' 
GO

EXEC SPALTER_COLUMN 'Sucursal', 'Usuario', 'varchar(10) NULL' 
GO
EXEC spALTER_TABLE 'Sucursal', 'FiscalRegimen', 'varchar(30) NULL' 
EXEC spALTER_TABLE 'Sucursal', 'FiscalZona', 'varchar(30) NULL' --MEJORA4769 
GO

EXEC spAlter_Table 'Sucursal', 'CFDFlex', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'noCertificado', 'varchar(20)	NULL'
EXEC spALTER_TABLE 'Sucursal', 'Llave', 'varchar(255)	NULL'
EXEC spAlter_Table 'Sucursal', 'ContrasenaSello', 'varchar(100)	NULL'
EXEC spAlter_Table 'Sucursal', 'CertificadoBase64', 'text		NULL'
EXEC spAlter_Table 'Sucursal', 'RutaCertificado', 'varchar(255)	NULL'
GO


EXEC spFK 'Sucursal','Usuario','Usuario','Usuario'
EXEC spFK 'Sucursal','CentroCostos','CentroCostos','CentroCostos'
EXEC spFK 'Sucursal','CajaCentral','CtaDinero','CtaDinero'
EXEC spFK 'Sucursal','Cliente','Cte','Cliente'
EXEC spFK 'Sucursal','LocalidadCNBV','LocalidadCNBV','LocalidadCNBV'
GO
 --REQ12534 Factory  
 Exec spAlter_Table 'Sucursal', 'ReferenciaIntelisisService',' varchar(50) NULL '
GO 

--REQ13386
EXEC spALTER_TABLE 'Sucursal', 'SucursalLDI','  varchar(20) NULL'
GO


-- REQ13987
Exec spAlter_Table 'Sucursal','eCommerce',' bit NULL DEFAULT 0'
Exec spAlter_Table 'Sucursal','eCommerceOffLine',' bit NULL DEFAULT 0'
Exec spAlter_Table 'Sucursal','eCommerceSucursal','varchar(10) Null'
Exec spAlter_Table 'Sucursal','eCommerceImagenes','varchar(50) Null'
Exec spAlter_Table 'Sucursal','eCommerceAlmacen','varchar(10) Null'
Exec spAlter_Table 'Sucursal','eCommerceListaPrecios','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommercePedido','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommerceEstrategiaDescuento','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommerceArticuloFlete','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommerceTipoConsecutivo','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommerceTipoConsecutivoFact','varchar(20) Null'
Exec spAlter_Table 'Sucursal','eCommerceCondicion','varchar(50) Null'
Exec spAlter_Table 'Sucursal','eCommerceCajero','varchar(10) Null'
Exec spAlter_Table 'Sucursal','eCommerceCteCat','varchar(50) Null'
Exec spAlter_Table 'Sucursal','eCommerceAgente','varchar(10) Null'
Exec spAlter_Table 'Sucursal', 'eCommerceSincroniza',' bit NULL DEFAULT 1 WITH VALUES'
Exec spAlter_Table 'Sucursal', 'eCommerceImpuestoIncluido',' bit NULL DEFAULT 1'
-- REQ13987
GO
-- NES: Por ahora no se soportan los precios sin impuesto en eCommerce, por lo que siempre ponemos en 1 esta bandera
UPDATE Sucursal SET eCommerceImpuestoIncluido = 1
GO

--REQ 13393 POS
EXEC spALTER_TABLE 'Sucursal', 'POSMensajeLimiteCaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'Sucursal', 'HOST', 'varchar(20)  NULL'
EXEC spALTER_TABLE 'Sucursal', 'POSLimiteCaja', 'float NULL' 
Exec spAlter_Table 'Sucursal', 'ParamAccDirIntelisisMES',' varchar(255) NULL '
Exec spAlter_Table 'Sucursal', 'eCommerceConsultaExistencias',' bit NULL DEFAULT 0'
Exec spAlter_Table 'Sucursal', 'eCommerceURL',' varchar(100) NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceEnvolturaOmision',' int NULL'

Exec spAlter_Table 'Sucursal', 'eCommerceCRModo',' varchar(20) NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRArticulo',' varchar(20) NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRArticuloAplica',' varchar(20) NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRMinimo',' float NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRMaximo',' float NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRTipo',' varchar(50) NULL'
Exec spAlter_Table 'Sucursal', 'eCommerceCRConcepto',' varchar(50) NULL'
GO

EXEC spALTER_TABLE 'Sucursal', 'EnviaCorreo', 'bit NULL DEFAULT 0'
EXEC spALTER_TABLE 'Sucursal', 'Perfil', 'varchar(20) NULL'
EXEC spALTER_TABLE 'Sucursal', 'Remitente', 'varchar(255) NULL'
GO

--Integración MES
EXEC spALTER_TABLE 'Sucursal', 'BDMES', 'varchar(50) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgSucursalABC') and sysstat & 0xf = 8) drop trigger dbo.tgSucursalABC
GO
CREATE TRIGGER tgSucursalABC ON Sucursal
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @SucursalI		int,
    @SucursalD		int,
    @PaisI		varchar(50),
    @PaisD		varchar(50),
    @EnLinea		bit,
    @SucursalPrincipal	int,
    @Mensaje		varchar(255)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @SucursalI         = Sucursal,
         @PaisI             = Pais,
         @EnLinea           = EnLinea,
 	 @SucursalPrincipal = SucursalPrincipal
    FROM Inserted

  SELECT @SucursalD = Sucursal, 
         @PaisD = Pais 
    FROM Deleted

  IF @PaisI = 'México' SELECT @PaisI ='Mexico'
  IF @PaisD = 'México' SELECT @PaisD ='Mexico'
  IF EXISTS (SELECT Pais FROM PersonalPropPais WHERE Pais = 'México')
    UPDATE PersonalPropPais SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Empresa WHERE Pais = 'México')
    UPDATE Empresa SET Pais = 'Mexico'
 
IF EXISTS (SELECT Pais FROM Sucursal WHERE Pais = 'México')
    UPDATE Sucursal SET Pais = 'Mexico'

IF EXISTS (SELECT Pais FROM Personal WHERE Pais = 'México')
   UPDATE Personal SET Pais = 'Mexico'


  IF @SucursalI IS NOT NULL AND @EnLinea = 1 AND @SucursalPrincipal IS NULL AND @SucursalI <> 0
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = 60410
    RAISERROR (@Mensaje,16,-1) 
    RETURN
  END

  IF @SucursalI = @SucursalD AND @PaisI <> @PaisD
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'SUC' AND Cuenta = CONVERT(char, @SucursalI)
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) 
    SELECT p.Propiedad, 'SUC', CONVERT(char, @SucursalI), p.porOmision 
      FROM PersonalProp p
      JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisI 
     WHERE p.NivelSucursal = 1
  END

  IF @SucursalI = @SucursalD RETURN

  -- Si Inserto
  IF @SucursalD IS NULL
  BEGIN
    DELETE PersonalPropValor WHERE Rama = 'SUC' AND Cuenta = CONVERT(char, @SucursalI)
    INSERT PersonalPropValor (Propiedad, Rama, Cuenta, Valor) 
    SELECT p.Propiedad, 'SUC', CONVERT(char, @SucursalI), p.porOmision 
      FROM PersonalProp p
      JOIN PersonalPropPais pp ON pp.Propiedad = p.Propiedad AND pp.Pais = @PaisI 
     WHERE p.NivelSucursal = 1
  END ELSE

  -- Si Elimino 
  IF @SucursalI IS NULL 
  BEGIN
    DELETE PersonalPropValor  WHERE Rama = 'SUC' AND Cuenta = CONVERT(char, @SucursalD)
    DELETE SucursalOtrosDatos WHERE Sucursal = @SucursalD
    DELETE SucursalBanco      WHERE Sucursal = @SucursalD
  END ELSE


  -- Si Modifico
  IF @SucursalD <> @SucursalI
  BEGIN
    UPDATE PersonalPropValor  SET Cuenta  = CONVERT(char, @SucursalI) WHERE Rama = 'SUC' AND Cuenta = CONVERT(char, @SucursalD)
    UPDATE SucursalOtrosDatos SET Sucursal = @SucursalI WHERE Sucursal = @SucursalD
    UPDATE SucursalBanco      SET Sucursal = @SucursalI WHERE Sucursal = @SucursalD
  END
END
GO


/****** Otros Datos Sucursal  ******/
if not exists(select * from SysTabla where SysTabla = 'SucursalOtrosDatos')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('SucursalOtrosDatos','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.SucursalOtrosDatos') and type = 'U') 
CREATE TABLE dbo.SucursalOtrosDatos (
	Sucursal		int	 	NOT NULL,

	Descripcion1		varchar(50)	NULL,
	Descripcion2		varchar(50)	NULL,
	Descripcion3		varchar(50)	NULL,
	Descripcion4		varchar(50)	NULL,
	Descripcion5		varchar(50)	NULL,
	Descripcion6		varchar(50)	NULL,
	Descripcion7		varchar(50)	NULL,
	Descripcion8		varchar(50)	NULL,
	Descripcion9		varchar(50)	NULL,
	Descripcion10		varchar(50)	NULL,
	Descripcion11		varchar(50)	NULL,
	Descripcion12		varchar(50)	NULL,
	Descripcion13		varchar(50)	NULL,
	Descripcion14		varchar(50)	NULL,
	Descripcion15		varchar(50)	NULL,
	Descripcion16		varchar(50)	NULL,
	Descripcion17		varchar(50)	NULL,
	Descripcion18		varchar(50)	NULL,
	Descripcion19		varchar(50)	NULL,
	Descripcion20		varchar(50)	NULL,

	CONSTRAINT priSucursalOtrosDatos PRIMARY KEY  CLUSTERED (Sucursal)
)
go

EXEC spFK 'SucursalOtrosDatos','Sucursal','Sucursal','Sucursal'
GO

/****** UsuarioSucursal ******/
if not exists(select * from SysTabla where SysTabla = 'UsuarioSucursal')
INSERT INTO SysTabla (SysTabla) VALUES ('UsuarioSucursal')
if not exists (select * from sysobjects where id = object_id('dbo.UsuarioSucursal') and type = 'U') 
BEGIN
  CREATE TABLE dbo.UsuarioSucursal (
	Usuario 	char(10)  	NOT NULL,

	Sucursal	int		NULL,
	Empresa		char(5)		NULL,

	CONSTRAINT priUsuarioSucursal PRIMARY KEY CLUSTERED (Usuario)
  )
  INSERT UsuarioSucursal (Usuario, Sucursal, Empresa)
  SELECT Usuario, Sucursal, DefEmpresa
    FROM Usuario
END
GO


/****** EstacionTrabajo ******/
/*if not exists(select * from SysTabla where SysTabla = 'EstacionTrabajo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EstacionTrabajo','N/A')*/
/*if not exists (select * from sysobjects where id = object_id('dbo.EstacionTrabajo') and type = 'U') 
  CREATE TABLE dbo.EstacionTrabajo (
        EstacionTrabajo		int		NOT NULL,

	Empresa 		char(5) 	NULL,
	Sucursal		int		NULL,
	Usuario 		char(10)  	NULL,
	FechaRegistro		datetime	NULL	DEFAULT GETDATE(),

	CONSTRAINT priEstacionTrabajo PRIMARY KEY CLUSTERED (EstacionTrabajo)
)*/
GO

/****** ObjetoLog ******/
if not exists(select * from SysTabla where SysTabla = 'ObjetoLog')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('ObjetoLog','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.ObjetoLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.ObjetoLog (
        ID			int		NOT NULL IDENTITY(1,1),

	SPID			int		NULL 	DEFAULT @@SPID,
	FechaRegistro		datetime	NULL	DEFAULT GETDATE(),
        AccesoID		int		NULL,
	Objeto			varchar(100)	NULL,
	Tiempo			timestamp	NULL,

	CONSTRAINT priObjetoLog PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'ObjetoLog'
END
GO

-- select dbo.fnAccesoUsuario(@@SPID)
/**************** fnAccesoUsuario ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAccesoUsuario') DROP FUNCTION fnAccesoUsuario
GO
CREATE FUNCTION fnAccesoUsuario (@SPID int)
RETURNS varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @ID	int
  SELECT @ID = MAX(ID)
    FROM Acceso
   WHERE SPID = @SPID AND FechaSalida IS NULL
  RETURN(SELECT Usuario FROM Acceso WHERE ID = @ID)
END
GO

/****** CfgWeb ******/
if (select version from version)<=2067 delete SysTabla where SysTabla = 'CfgWeb'
GO
if not exists(select * from SysTabla where SysTabla = 'CfgWeb')
  INSERT INTO SysTabla (SysTabla, Tipo) VALUES ('CfgWeb', 'Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.CfgWeb') and type = 'U') 
CREATE TABLE dbo.CfgWeb (
	Empresa				varchar(5)	NOT NULL,
	
	Usuario				varchar(10)	NOT NULL,
	Almacen				char(10)	NOT NULL,
	MovPedido			char(20)	NOT NULL,
	
	ActualizarDatosCliente		bit		NOT NULL	DEFAULT 0,
	PermiteSeleccionarEnviarA	bit		NOT NULL	DEFAULT 0,
	ConfirmacionPedidos		bit		NOT NULL	DEFAULT 0,

	ConfirmacionServidorSMTP	varchar(20)	NULL,
	ConfirmacionNombreRemitente	varchar(100)	NULL,
	ConfirmacionCorreoRemitente	varchar(100)	NULL,
	ConfirmacionAsunto		varchar(100)	NULL,
	ConfirmacionEnvioInmediato	bit		NOT NULL	DEFAULT 0,

	UEN				int		NULL,
	Concepto			varchar(50)	NULL,
	OcultarDescuentoArticulos	bit		NULL		DEFAULT 0,
	OcultarPrecioLista		bit		NULL		DEFAULT 0,
	MostrarUnicamenteArtExistencia	bit		NULL		DEFAULT 0,

	CONSTRAINT priCfgWeb PRIMARY KEY CLUSTERED (Empresa)
)
GO
EXEC spALTER_TABLE 'CfgWeb', 'UEN', 'int NULL'
EXEC spALTER_TABLE 'CfgWeb', 'Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'CfgWeb', 'OcultarDescuentoArticulos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CfgWeb', 'OcultarPrecioLista', 'bit	NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CfgWeb', 'MostrarUnicamenteArtExistencia', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if (select version from version)<=3299
BEGIN
  EXEC("spEliminarPK 'CfgWeb'")	
  EXEC("spALTER_COLUMN 'CfgWeb' ,'Usuario', 'varchar(10) NOT NULL'")  
  EXEC("spALTER_COLUMN 'CfgWeb' ,'Empresa', 'varchar(5) NOT NULL'")  
  EXEC("ALTER TABLE CfgWeb ADD CONSTRAINT priCfgWeb PRIMARY KEY CLUSTERED (Empresa)")
END
GO

EXEC spFK 'CfgWeb','Empresa','Empresa','Empresa'
EXEC spFK 'CfgWeb','Usuario','Usuario','Usuario'
GO

/****** Mensaje ******/
if not exists(select * from SysTabla where SysTabla = 'Mensaje')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Mensaje','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.Mensaje') and type = 'U') 
BEGIN
  CREATE TABLE dbo.Mensaje (
        ID			int		NOT NULL IDENTITY(1,1),

	Asunto			varchar(255)	NULL,
	Mensaje			text		NULL,
	Fecha			datetime	NULL,

	CONSTRAINT priMensaje PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'Mensaje'
END
GO

/****** MensajeAnexo ******/
if not exists(select * from SysTabla where SysTabla = 'MensajeAnexo')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MensajeAnexo','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeAnexo') and type = 'U') 
  CREATE TABLE dbo.MensajeAnexo (
        MensajeID		int		NOT NULL,
	Anexo			varchar(255)	NOT NULL,

	CONSTRAINT priMensajeAnexo PRIMARY KEY CLUSTERED (MensajeID, Anexo)
  )
GO

/****** MensajeSalida ******/
if not exists(select * from SysTabla where SysTabla = 'MensajeSalida')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MensajeSalida','N/A')
if not exists (select * from sysobjects where id = object_id('dbo.MensajeSalida') and type = 'U') 
BEGIN
  CREATE TABLE dbo.MensajeSalida (
        ID			int		NOT NULL IDENTITY(1,1),

        MensajeID		int		NOT NULL,
	Cliente			char(10)	NULL,
	Nombre			varchar(100)	NULL,

	Estatus			varchar(15)	NULL	DEFAULT 'PENDIENTE',
	FechaSalida		datetime	NULL,

	CONSTRAINT priMensajeSalida PRIMARY KEY CLUSTERED (ID)
  )
  EXEC spSincroSemilla 'MensajeSalida'
END
GO

/****** EmpresaParticipacion ******/
if not exists(select * from SysTabla where SysTabla = 'EmpresaParticipacion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('EmpresaParticipacion','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.EmpresaParticipacion') and type = 'U') 
BEGIN
  CREATE TABLE dbo.EmpresaParticipacion (
	Empresa 		char(5) 	NOT NULL,
        ID			int		NOT NULL IDENTITY(1,1),

	Tipo			varchar(20)	NULL,	-- Empresa/Otro
	Simbolo			varchar(20)	NULL,
	Descripcion		varchar(100)	NULL,
	Porcentaje		float		NULL,
	Resultado		money		NULL,
	Moneda			char(10)	NULL,
	UltimoCambio		datetime	NULL,
	CuentaDebe		varchar(20)	NULL,
	CuentaHaber		varchar(20)	NULL,

	CONSTRAINT priEmpresaParticipacion PRIMARY KEY CLUSTERED (Empresa, ID)
  )
  EXEC spSincroSemilla 'EmpresaParticipacion'
END
GO

EXEC spFK 'EmpresaParticipacion','CuentaDebe','Cta','Cuenta'
GO

/****** Sistema ******/
if not exists(select * from SysTabla where SysTabla = 'Sistema')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('Sistema','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.Sistema') and type = 'U') 
CREATE TABLE dbo.Sistema (
	Sistema		int		NOT NULL,

	Nombre		varchar(100)	NULL,

	CONSTRAINT priSistema PRIMARY KEY CLUSTERED (Sistema)
)
GO

/****** Configuracion del Registro Mayor ******/
if not exists(select * from SysTabla where SysTabla = 'CfgRegistroCuenta')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgRegistroCuenta','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgRegistroCuenta') and type = 'U') 
CREATE TABLE dbo.CfgRegistroCuenta (
	CfgRegistro		int		NOT NULL,
	Referencia		varchar(50)	NOT NULL,

	Cuenta			varchar(20)	NULL,

	CONSTRAINT priCfgRegistroCuenta PRIMARY KEY CLUSTERED (CfgRegistro, Referencia)
)
GO

EXEC spFK 'CfgRegistroCuenta','Cuenta','Cta','Cuenta'
GO

/****** Configuracion del Registro ******/
if not exists(select * from SysTabla where SysTabla = 'CfgRegistro')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgRegistro','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgRegistro') and type = 'U') 
CREATE TABLE dbo.CfgRegistro (
	CfgRegistro		int		NOT NULL,

	Nombre			varchar(100)	NULL,
	FechaCancelaciones	varchar(20)	NULL	DEFAULT 'Fecha Emision',	-- Fecha Emision / Fecha Cancelacion

	CONSTRAINT priCfgRegistro PRIMARY KEY CLUSTERED (CfgRegistro)
)
GO
EXEC spALTER_TABLE 'CfgRegistro', 'FechaCancelaciones', 'varchar(20) NULL DEFAULT "Fecha Emision" WITH VALUES'
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCfgRegistroABC') and sysstat & 0xf = 8) drop trigger dbo.tgCfgRegistroABC
GO
CREATE TRIGGER tgCfgRegistroABC ON CfgRegistro
--//WITH ENCRYPTION
FOR INSERT, UPDATE, DELETE
AS BEGIN
  DECLARE
    @CfgRegistroN	int,
    @CfgRegistroA	int

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @CfgRegistroN = CfgRegistro FROM Inserted
  SELECT @CfgRegistroA = CfgRegistro FROM Deleted
  
  IF @CfgRegistroN = @CfgRegistroA RETURN
  
  -- Inserto
  IF @CfgRegistroA IS NULL
  BEGIN
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Cuentas por Cobrar')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Cuentas por Pagar')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Impuestos por Cobrar')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Impuestos por Pagar')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Ventas')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Costo Ventas')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Inventarios')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Tersoreria')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Gastos')
    INSERT CfgRegistroCuenta (CfgRegistro, Referencia) VALUES (@CfgRegistroN, 'Activos Fijos')
  END ELSE

  -- Elimino
  IF @CfgRegistroN IS NULL
  BEGIN
    DELETE CfgRegistroCuenta WHERE CfgRegistro = @CfgRegistroA
  END ELSE

  -- Modifico
  BEGIN
    UPDATE CfgRegistroCuenta SET CfgRegistro = @CfgRegistroN WHERE CfgRegistro = @CfgRegistroA
  END
END
GO
-- delete cfgregistro


/****** Configuracion del Politica Precios Mov ******/
if not exists(select * from SysTabla where SysTabla = 'CfgPoliticaPreciosMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgPoliticaPreciosMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgPoliticaPreciosMov') and type = 'U') 
CREATE TABLE dbo.CfgPoliticaPreciosMov (
        ID			int		NOT NULL IDENTITY(1,1),

	Estatus			char(15)	NULL,
	Empresa			varchar(5)	NULL,
	Sucursal		int		NULL,
	Agrupador		varchar(50)	NULL,
	Nombre			varchar(50)	NULL,
	Cantidad		float		NULL,
	Porcentaje		float		NULL,

	CONSTRAINT priCfgPoliticaPreciosMov PRIMARY KEY CLUSTERED (ID)
)
GO

EXEC spALTER_COLUMN 'CfgPoliticaPreciosMov', 'Empresa', 'varchar(5) NULL'
GO

EXEC spFK 'CfgPoliticaPreciosMov','Sucursal','Sucursal','Sucursal'
EXEC spFK 'CfgPoliticaPreciosMov','Empresa','Empresa','Empresa'
GO

/****** Configuracion del ECollaborationMov  ******/
if not exists(select * from SysTabla where SysTabla = 'CfgECollaborationMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgECollaborationMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgECollaborationMov') and type = 'U') 
CREATE TABLE dbo.CfgECollaborationMov (
        Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,
	ModuloDestino		char(5)		NULL,
	MovDestino		char(20)	NULL,

	CONSTRAINT priCfgECollaborationMov PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

/****** Configuracion de eCollaboration Proveedor/Cliente  ******/
if not exists(select * from SysTabla where SysTabla = 'eCollaborationProvCte')
INSERT INTO SysTabla (SysTabla) VALUES ('eCollaborationProvCte')
if not exists (select * from sysobjects where id = object_id('dbo.eCollaborationProvCte') and type = 'U') 
CREATE TABLE dbo.eCollaborationProvCte (
	ModuloOrigen        varchar(5)	NOT NULL,
	MovimientoOrigen    varchar(20)	NOT NULL,
	EmpresaProv		    varchar(5)	NULL,
	Proveedor		    varchar(10)	NULL,
	EmpresaCte		    varchar(5)	NULL,
	Cliente	        	varchar(10)	NULL

	CONSTRAINT pk_eCollaborationProvCte PRIMARY KEY CLUSTERED (ModuloOrigen,MovimientoOrigen)
)
GO

/****** Configuracion del WMS ******/
if not exists(select * from SysTabla where SysTabla = 'CfgWMSMov')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgWMSMov','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgWMSMov') and type = 'U') 
CREATE TABLE dbo.CfgWMSMov (
        Modulo			char(5)		NOT NULL,
	Mov			char(20)	NOT NULL,

	WMSMov			char(20)	NULL,

	CONSTRAINT priCfgWMSMov PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO

-- drop table CfgMovProy
/****** Configuracion del Proyectos ******/
if not exists(select * from SysTabla where SysTabla = 'CfgMovProy')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgMovProy','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgMovProy') and type = 'U') 
CREATE TABLE dbo.CfgMovProy (
        Modulo			char(5)		NOT NULL,
	Mov			varchar(20)	NOT NULL,

	
	Tipo			varchar(20)	NULL,		-- Presupuesto, Real
	Factor			float		NULL		DEFAULT 1.0,

	CONSTRAINT priCfgMovProy PRIMARY KEY CLUSTERED (Modulo, Mov)
)
GO
EXEC spALTER_TABLE 'CfgMovProy', 'SubTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'CfgMovProy', 'Proveedor', 'varchar(20) NULL'
GO

/****** IntelisisSL ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisSL')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisSL','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisSL') and type = 'U') 
CREATE TABLE dbo.IntelisisSL (
	Licencia		varchar(50) 	NOT NULL,

	Nombre			varchar(255)	NULL,
	Cliente			varchar(10)	NULL,
	Dominio			varchar(100)	NULL,
	Firma			varchar(40)	NULL,
	Fabricacion		datetime	NULL,
	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	Tipo			varchar(20)	NULL,	-- Venta, Renta,
	Observaciones		varchar(255)	NULL,
	Contacto		varchar(100)	NULL,
	eMail			varchar(100)	NULL,

	Alta			datetime	NULL,
	Estatus			varchar(15)	NULL,
	UltimoCambio 		datetime  	NULL,
	UsuarioCambio		varchar(10)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,
	LicenciaXML		text		NULL,

	CONSTRAINT priIntelisisSL PRIMARY KEY  CLUSTERED (Licencia)
)
GO
EXEC spALTER_TABLE 'IntelisisSL', 'Fabricacion', 'datetime NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'Mantenimiento', 'datetime NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'TieneMovimientos', 'bit NULL	DEFAULT 0 WITH VALUES'
GO
EXEC spADD_INDEX 'IntelisisSL', 'Cliente', 'Cliente, Licencia'
EXEC spALTER_COLUMN 'IntelisisSL', 'Firma', 'varchar(40) NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'LicenciaXML', 'text NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'Contacto', 'varchar(100) NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'eMail', 'varchar(100) NULL'
EXEC spALTER_TABLE 'IntelisisSL', 'Dominio', 'varchar(100) NULL'
GO

EXEC spDROP_TABLE 'IntelisisSLHist', 3301
GO
/****** IntelisisSLHist ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisSLHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisSLHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisSLHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisSLHist (
	Licencia		varchar(50) 	NOT NULL,
	FechaHora		datetime	NOT NULL	DEFAULT GETDATE(),
	RID			int		IDENTITY(1,1)	NOT NULL,

	Nombre			varchar(255)	NULL,
	Cliente			varchar(10)	NULL,
	Dominio			varchar(100)	NULL,
	Firma			varchar(40)	NULL,
	Fabricacion		datetime	NULL,
	Vencimiento		datetime	NULL,
	Mantenimiento		datetime	NULL,
	Tipo			varchar(20)	NULL,	-- Venta, Renta,
	Observaciones		varchar(255)	NULL,

	Alta			datetime	NULL,
	Estatus			varchar(15)	NULL,
	UltimoCambio 		datetime  	NULL,
	UsuarioCambio		varchar(10)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	CONSTRAINT priIntelisisSLHist PRIMARY KEY  CLUSTERED (Licencia, FechaHora, RID)
  )
  EXEC spSincroSemilla 'IntelisisSLHist'
END
GO

EXEC spALTER_TABLE 'IntelisisSLHist', 'Fabricacion', 'datetime NULL'
EXEC spALTER_TABLE 'IntelisisSLHist', 'Mantenimiento', 'datetime NULL'
EXEC spALTER_TABLE 'IntelisisSLHist', 'Tipo', 'varchar(20) NULL'
EXEC spALTER_COLUMN 'IntelisisSLHist', 'Firma', 'varchar(40) NULL'
EXEC spALTER_TABLE 'IntelisisSLHist', 'Dominio', 'varchar(100) NULL'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgIntelisisSLAC') and sysstat & 0xf = 8) drop trigger dbo.tgIntelisisSLAC
GO
CREATE TRIGGER tgIntelisisSLAC ON IntelisisSL
WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  INSERT IntelisisSLHist (
  	 Licencia, Nombre, Cliente, Firma, Dominio, Fabricacion, Vencimiento, Mantenimiento, Tipo, Observaciones, Alta, Estatus, UltimoCambio, UsuarioCambio, TieneMovimientos)
  SELECT Licencia, Nombre, Cliente, Firma, Dominio, Fabricacion, Vencimiento, Mantenimiento, Tipo, Observaciones, Alta, Estatus, UltimoCambio, UsuarioCambio, TieneMovimientos
    FROM Inserted
END
GO

EXEC spDROP_TABLE 'IntelisisSLD', 3294
GO
/****** IntelisisSLD ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisSLD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisSLD','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisSLD') and type = 'U') 
CREATE TABLE dbo.IntelisisSLD (
	Licencia		varchar(50) 	NOT NULL,
	Licenciamiento		varchar(50)	NOT NULL,

	Cantidad		int		NULL,
	Estatus			varchar(15)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	CONSTRAINT priIntelisisSLD PRIMARY KEY  CLUSTERED (Licencia, Licenciamiento)
)
GO

EXEC spDROP_TABLE 'IntelisisSLDHist', 3294
GO
/****** IntelisisSLDHist ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisSLDHist')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisSLDHist','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisSLDHist') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisSLDHist (
	Licencia		varchar(50) 	NOT NULL,
        Licenciamiento		varchar(50)	NOT NULL,
        RID			int		NOT NULL	IDENTITY(1,1),

	FechaHora		datetime	NULL	DEFAULT GETDATE(),
	Cantidad		int		NULL,
	Estatus			varchar(15)	NULL,
	TieneMovimientos	bit		NULL	DEFAULT 0,

	CONSTRAINT priIntelisisSLDHist PRIMARY KEY  CLUSTERED (Licencia, Licenciamiento, RID)  
  )
  EXEC spSincroSemilla 'IntelisisSLDHist'
END
GO
if exists (select * from sysobjects where id = object_id('dbo.tgIntelisisSLDAC') and sysstat & 0xf = 8) drop trigger dbo.tgIntelisisSLDAC
GO
CREATE TRIGGER tgIntelisisSLDAC ON IntelisisSLD
WITH ENCRYPTION
FOR INSERT, UPDATE
AS BEGIN
  
  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  INSERT IntelisisSLDHist (
  	 Licencia, Licenciamiento, Cantidad, Estatus, TieneMovimientos)
  SELECT Licencia, Licenciamiento, Cantidad, Estatus, TieneMovimientos
    FROM Inserted
END
GO

EXEC spDROP_TABLE 'IntelisisSLLog', 3301
GO
/****** IntelisisSLLog ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisSLLog')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisSLLog','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisSLLog') and type = 'U') 
BEGIN
  CREATE TABLE dbo.IntelisisSLLog (
	Licencia		varchar(50) 	NOT NULL,
	Fecha			datetime	NOT NULL,
        RID			int		NOT NULL	IDENTITY(1,1),

	Usuario			varchar(255)	NULL,
	Equipo			varchar(255)	NULL,
	Dominio			varchar(255)	NULL,
	IP			varchar(20)	NULL,
	Ok			int		NULL,
	OkRef			varchar(255)	NULL,

	CONSTRAINT priIntelisisSLLog PRIMARY KEY  CLUSTERED (Licencia, Fecha, RID)
  )
  EXEC spSincroSemilla 'IntelisisSLLog'  
END
GO

/**************** spIntelisisSLHQ ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisSLHQ') and type = 'P') 
  drop procedure dbo.spIntelisisSLHQ
GO
CREATE PROCEDURE spIntelisisSLHQ
		   @Licencia	varchar(50),
		   @Fecha126	varchar(50),
		   @Usuario	varchar(255),
		   @NT_Equipo	varchar(255),
		   @NT_Dominio	varchar(255),
		   @NT_IP	varchar(20),
		   @XMLEnLista	bit = 0		   
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @Ok  		int, 
    @OkDesc		varchar(255),
    @OkRef		varchar(255),
    @Cliente		varchar(10),    
    @ClienteNombre	varchar(255),
    @Dominio		varchar(100),
    @Nombre		varchar(255),
    @Observaciones	varchar(255),
    @Fabricacion	datetime,
    @Vencimiento	datetime,
    @Mantenimiento	datetime,
    @Tipo		varchar(20),
    @CantidadTotal	int,
    @Firma		varchar(40),
    @Estatus            varchar(15),
    @Usuarios		varchar(8000)  

  SELECT @Ok = NULL, @OkDesc = NULL, @OkRef = NULL, @Nombre = NULL, @Observaciones = NULL, @Cliente = NULL, 
         @ClienteNombre = NULL, @Firma = NULL, @Dominio = NULL, @Vencimiento = NULL, @CantidadTotal = 0, @Usuarios = NULL,  
         @Fecha = CONVERT(datetime, @Fecha126, 126)

  SELECT @Cliente = sl.Cliente, 
         @ClienteNombre = c.Nombre,
         @Nombre = sl.Nombre,
         @Observaciones = sl.Observaciones,
         @Mantenimiento = sl.Mantenimiento,
         @Vencimiento = sl.Vencimiento,
         @Fabricacion = sl.Fabricacion,
         @Tipo = sl.Tipo,
         @Estatus = sl.Estatus,
         @Firma = sl.Firma,
         @Dominio = sl.Dominio
    FROM IntelisisSL sl
    JOIN Cte c ON c.Cliente = sl.Cliente
   WHERE sl.Licencia = @Licencia 

  IF @@ROWCOUNT = 0 OR @Estatus IS NULL SELECT @Ok = 9010 ELSE
  IF @Estatus = 'BLOQUEADO' SELECT @Ok = 9020 ELSE
  IF @Estatus <> 'ALTA' SELECT @Ok = 9030 

  IF @Ok IS NULL
  BEGIN       
    UPDATE IntelisisSL  SET TieneMovimientos = 1 WHERE Licencia = @Licencia AND TieneMovimientos = 0
    UPDATE IntelisisSLD SET TieneMovimientos = 1 WHERE Licencia = @Licencia AND TieneMovimientos = 0
    SELECT @Usuarios = (SELECT Licenciamiento, Cantidad FROM IntelisisSLD WHERE Licencia = @Licencia AND Estatus = 'ALTA' FOR XML RAW ('Acceso'), ROOT ('Usuarios'))
    SELECT @CantidadTotal = SUM(Cantidad) FROM IntelisisSLD WHERE Licencia = @Licencia AND Estatus = 'ALTA' 
  END

  IF @Ok IS NOT NULL
  BEGIN
    SELECT @OkDesc = Descripcion
      FROM MensajeLista
     WHERE Mensaje = @Ok
    IF @OkRef IS NULL SELECT @OkRef = @Licencia
  END

  INSERT IntelisisSLLog 
         (Licencia,  Fecha,  Usuario,  Equipo,     Dominio,     IP,     Ok,  OkRef) 
  VALUES (@Licencia, @Fecha, @Usuario, @NT_Equipo, @NT_Dominio, @NT_IP, @Ok, @OkRef) 

  IF @XMLEnLista = 1
  BEGIN
    CREATE TABLE #Resultado (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, Valor varchar(255) COLLATE Database_Default NULL)
    INSERT #Resultado (Valor) SELECT '<?xml version="1.0" encoding="windows-1252"?>'
    INSERT #Resultado (Valor) SELECT '<Intelisis Contenido="Licencia">'
    INSERT #Resultado (Valor) SELECT '<Licencia>'
    INSERT #Resultado (Valor) SELECT '<Licencia>'+@Licencia+'</Licencia>'
    INSERT #Resultado (Valor) SELECT '<Nombre>'+ISNULL(@Nombre, '')+'</Nombre>'
    INSERT #Resultado (Valor) SELECT '<Observaciones>'+ISNULL(@Observaciones, '')+'</Observaciones>'
    INSERT #Resultado (Valor) SELECT '<Cliente>'+ISNULL(@Cliente, '')+'</Cliente>'
    INSERT #Resultado (Valor) SELECT '<ClienteNombre>'+ISNULL(@ClienteNombre, '')+'</ClienteNombre>'
    INSERT #Resultado (Valor) SELECT '<Dominio>'+ISNULL(@Dominio, '')+'</Dominio>'
    INSERT #Resultado (Valor) SELECT '<FechaSolicitud>'+ISNULL(@Fecha126, '')+'</FechaSolicitud>'
    INSERT #Resultado (Valor) SELECT '<Fabricacion>'+ISNULL(CONVERT(varchar, @Fabricacion, 126), '')+'</Fabricacion>'
    INSERT #Resultado (Valor) SELECT '<Vencimiento>'+ISNULL(CONVERT(varchar, @Vencimiento, 126), '')+'</Vencimiento>'
    INSERT #Resultado (Valor) SELECT '<Mantenimiento>'+ISNULL(CONVERT(varchar, @Mantenimiento, 126), '')+'</Mantenimiento>'
    INSERT #Resultado (Valor) SELECT '<Tipo>'+ISNULL(@Tipo, '')+'</Tipo>'
    INSERT #Resultado (Valor) SELECT ISNULL(@Usuarios, '')
    INSERT #Resultado (Valor) SELECT '<Firma>'+ISNULL(@Firma, '')+'</Firma>'
    INSERT #Resultado (Valor) SELECT '<Version>1.1</Version>'    
    INSERT #Resultado (Valor) SELECT '</Licencia>'
    IF @Ok IS NOT NULL
    BEGIN
      INSERT #Resultado (Valor) SELECT '<Mensaje>'    
      INSERT #Resultado (Valor) SELECT '<Ok>'+CONVERT(varchar, @Ok)+'</Ok>' 
      INSERT #Resultado (Valor) SELECT '<OkDesc>'+ISNULL(@OkDesc, '')+'</OkDesc>' 
      INSERT #Resultado (Valor) SELECT '<OkRef>'+ISNULL(@OkRef, '')+'</OkRef>'             
      INSERT #Resultado (Valor) SELECT '</Mensaje>'
    END
    INSERT #Resultado (Valor) SELECT '<LicenciaLlave></LicenciaLlave>'
    INSERT #Resultado (Valor) SELECT '</Intelisis>'    
    SELECT Valor FROM #Resultado ORDER BY ID
    DROP TABLE #Resultado
  END ELSE
    SELECT "Ok" = @Ok, "OkDesc" = @OkDesc, "OkRef" = @OkRef, 
           "Nombre" = @Nombre, "Observaciones" = @Observaciones, 
           "Cliente" = @Cliente, "ClienteNombre" = @ClienteNombre, 
           "Fabricacion" = @Fabricacion, "Vencimiento" = @Vencimiento, "Mantenimiento" = @Mantenimiento, "Tipo" = @Tipo,
           "Firma" = REPLACE(@Firma, '-', ''), "CantidadTotal" = @CantidadTotal,  
           "XML" = @Usuarios
  RETURN   
END
GO



/****** IntelisisLic ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisLic')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisLic','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisLic') and type = 'U') 
CREATE TABLE dbo.IntelisisLic (
	Licenciamiento		varchar(50) 	NOT NULL,

	Descripcion		varchar(255)	NULL,
	LicenciamientoXML	text		NULL,

	CONSTRAINT priIntelisisLic PRIMARY KEY  CLUSTERED (Licenciamiento)
)
GO

/****** IntelisisLicForma ******/
if not exists(select * from SysTabla where SysTabla = 'IntelisisLicForma')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('IntelisisLicForma','Cuenta')
if not exists (select * from sysobjects where id = object_id('dbo.IntelisisLicForma') and type = 'U') 
CREATE TABLE dbo.IntelisisLicForma (
	Licenciamiento		varchar(50) 	NOT NULL,
	Forma			varchar(100)	NOT NULL,

	CONSTRAINT priIntelisisLicForma PRIMARY KEY  CLUSTERED (Licenciamiento, Forma)
)
GO

-- spIntelisisLic 'Comercial'
/**************** spIntelisisLic ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIntelisisLic') and type = 'P') 
  drop procedure dbo.spIntelisisLic
GO
CREATE PROCEDURE spIntelisisLic
		   @Licenciamiento	varchar(50)	   
WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #Resultado (ID int IDENTITY(1,1) NOT NULL PRIMARY KEY, Valor varchar(255) COLLATE Database_Default NULL)
  INSERT #Resultado (Valor) SELECT '<?xml version="1.0" encoding="windows-1252"?>'
  INSERT #Resultado (Valor) SELECT '<Intelisis Contenido="Licenciamiento">'
  INSERT #Resultado (Valor) SELECT '<Licenciamiento>'
  INSERT #Resultado (Valor) SELECT '<Licenciamiento>'+@Licenciamiento+'</Licenciamiento>'
  INSERT #Resultado (Valor) SELECT '<Formas>'
  INSERT #Resultado (Valor) SELECT '<Forma Clave="'+RTRIM(Forma)+'"/>' FROM IntelisisLicForma WHERE Licenciamiento = @Licenciamiento
  INSERT #Resultado (Valor) SELECT '</Formas>'
  INSERT #Resultado (Valor) SELECT '</Licenciamiento>'
  INSERT #Resultado (Valor) SELECT '<LicenciamientoLlave></LicenciamientoLlave>'
  INSERT #Resultado (Valor) SELECT '</Intelisis>'    
  SELECT Valor FROM #Resultado ORDER BY ID
  DROP TABLE #Resultado
  RETURN   
END
GO


/****** CfgListaD ******/
if not exists(select * from SysTabla where SysTabla = 'CfgListaD')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgListaD','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgListaD') and type = 'U') 
CREATE TABLE dbo.CfgListaD (
	Lista			varchar(50)	NOT NULL,
	Campo			varchar(100) 	NOT NULL,

	Valor			varchar(100)	NULL,

	CONSTRAINT priCfgListaD PRIMARY KEY CLUSTERED (Lista, Campo)
)
GO

/****** CfgListas ******/
if not exists(select * from SysTabla where SysTabla = 'CfgLista')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgLista','Maestro')
if not exists (select * from sysobjects where id = object_id('dbo.CfgLista') and type = 'U') 
CREATE TABLE dbo.CfgLista (
	Lista			varchar(50) 	NOT NULL,

	CONSTRAINT priCfgLista PRIMARY KEY CLUSTERED (Lista)
)
GO
if exists (select * from sysobjects where id = object_id('dbo.tgCfgListaBC') and sysstat & 0xf = 8) drop trigger dbo.tgCfgListaBC
GO
-- Aqui va el Matenimiento a la tabla

CREATE TRIGGER tgCfgListaBC ON CfgLista
--//WITH ENCRYPTION
FOR UPDATE, DELETE
AS BEGIN
  DECLARE
    @ListaN  	varchar(50),
    @ListaA	varchar(50)

  IF dbo.fnEstaSincronizando() = 1 RETURN
  
  SELECT @ListaN = Lista FROM Inserted
  SELECT @ListaA = Lista FROM Deleted

  IF @ListaN = @ListaA  RETURN

  IF @ListaN IS NULL
    DELETE CfgListaD WHERE Lista = @ListaA 
  ELSE
    UPDATE CfgListaD SET Lista = @ListaN WHERE Lista = @ListaA 
END
GO

--REQ 13389
/*************************** CfgCRM **************************/
if not exists (select * from SysTabla where SysTabla = 'CfgCRM') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CfgCRM','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CfgCRM') and type = 'U') 
CREATE TABLE CfgCRM
    (
	ServidorIntelisis		varchar(100)	NOT	NULL,
	BaseIntelisis			varchar(100)	NOT	NULL,
	Usuario					varchar(10)			NULL,
	Contrasena				varchar(32)			NULL
		
	CONSTRAINT priCfgCRM PRIMARY KEY  CLUSTERED (ServidorIntelisis, BaseIntelisis)
	)
GO
--INSERT CfgCRM select 'Labprod3', 'CRM', 'DEMO', '0633971b5e442cd51b8e0a972d74f054'

--REQ 13389
/*************************** TablaSyncro **************************/
if not exists (select * from SysTabla where SysTabla = 'TablaSyncro') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('TablaSyncro','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.TablaSyncro') and type = 'U') 
CREATE TABLE TablaSyncro
    (
	ID						int	IDENTITY(1,1)	NOT NULL,
	TablaIntelisis			varchar(256)			NULL,
	TablaCRM				varchar(256)			NULL,
	OrdenCampo				int						NULL CONSTRAINT [DF_TablaSyncro_Orden]  DEFAULT ((1)),
	OrdenTabla				int						NULL,
	CampoInt				varchar(256)			NULL,
	CampoExt				varchar(256)			NULL,
	IdAutomatico			bit					NOT NULL CONSTRAINT [DF_TablaSyncro_IdAutomatico]  DEFAULT ((0)),
	BuscarDato				bit					NOT NULL CONSTRAINT [DF_TablaSyncro_Buscar]  DEFAULT ((0)),
	DefaultInsert			varchar(50)				NULL,
	AccionEspecifica		varchar(50)				NULL,
	
	CONSTRAINT priTablaSyncro PRIMARY KEY  CLUSTERED (ID)
	)
GO

