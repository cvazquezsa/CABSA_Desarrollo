if (select version from version)<=2273 and exists (select * from sysobjects where id = object_id('dbo.CRMov') and type = 'U') 
drop table crMov
go


if not exists (select * from sysobjects where id = object_id('dbo.CRMov') and type = 'U') 
CREATE TABLE dbo.CRMov (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	FechaRegistro		datetime	NOT NULL	DEFAULT GETDATE(),
	Tipo			varchar(20)	NOT NULL,	-- Venta/Devolucion/Apertura/Recoleccion/Deposito/Corte/Inventario Fisico
	Cxc			bit 		NULL 		DEFAULT 0,
	Folio			int		NOT NULL,
	FechaEmision		datetime	NOT NULL,
	Estatus			char(15)	NOT NULL,	-- CONCLUIDO/CANCELADO/CERRADO
	Caja			int		NULL,
	CajaRef			int		NULL,
	Banco			int		NULL,
	Cajero			int		NULL,
	ClienteSucursal		int		NULL,
	Cliente			int		NULL,
	ClienteIntelisis	varchar(10)	NULL,
	Referencia		varchar(50)	NULL,
  	Corte                   int             NULL,
  	FechaD                  datetime        NULL,
  	FechaA                  datetime        NULL,
	Vencimiento		datetime        NULL,
	Concepto		varchar(50)	NULL,
        FechaBanco		datetime 	NULL,
	Enviado			bit 		NULL DEFAULT 0,
	CajeroCancelacion	int 		NULL,
	OrigenID		int		NULL,
	OrigenTipo		varchar(20)	NULL,
	OrigenFolio		int		NULL,
	Proveedor		int 		NULL,
	ListaPrecios		varchar(20) 	NULL,

    CFDGenerado		bit NULL DEFAULT 0, --MEJORA3051
    CFDID           int NULL, --MEJORA3051
    CFDSerie		varchar(20) NULL, --MEJORA3051
    CFDFolio        varchar(20) NULL, --MEJORA3051

	CONSTRAINT pk_CRMov PRIMARY KEY  CLUSTERED (ID, Sucursal)
)
GO
EXEC spALTER_TABLE 'CRMov', 'Vencimiento', 'datetime NULL'
EXEC spALTER_TABLE 'CRMov', 'Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crMov', 'FechaBanco', 'datetime NULL'
EXEC spALTER_TABLE 'crMov', 'Enviado', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crMov', 'CajeroCancelacion', 'int NULL'
EXEC spALTER_TABLE 'crMov', 'ClienteIntelisis', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crMov', 'Cxc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crMov', 'OrigenID', 'int NULL'
EXEC spALTER_TABLE 'crMov', 'OrigenTipo', 'varchar(20) NULL'
EXEC spALTER_TABLE 'crMov', 'OrigenFolio', 'int	NULL'
EXEC spALTER_TABLE 'crMov', 'Proveedor', 'int NULL'
EXEC spALTER_TABLE 'crMov', 'ListaPrecios', 'varchar(20) NULL'
GO
EXEC spADD_INDEX 'crMov', 'FechaEmision', 'FechaEmision, Tipo, Sucursal'
EXEC spADD_INDEX 'crMov', 'Corte', 'Corte, Sucursal'
GO
EXEC spALTER_TABLE 'crMov', 'CFDGenerado', 'bit NULL DEFAULT 0' --ARCC
EXEC spALTER_TABLE 'crMov', 'CFDID', 'int NULL' --ARCC
EXEC spALTER_TABLE 'crMov', 'CFDSerie', 'varchar(20) NULL' --ARCC
EXEC spALTER_TABLE 'crMov', 'CFDFolio', 'varchar(20) NULL' --ARCC
GO


if not exists (select * from sysobjects where id = object_id('dbo.CRMovTemp') and type = 'U') 
CREATE TABLE dbo.CRMovTemp (
	Sesion			varchar(50)	NOT NULL,
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	FechaRegistro		datetime	NOT NULL	DEFAULT GETDATE(),
	Tipo			varchar(20)	NOT NULL,	-- Venta/Devolucion/Apertura/Recoleccion/Deposito/Corte/Inventario Fisico
	Cxc			bit 		NULL 		DEFAULT 0,
	Folio			int		NOT NULL,
	FechaEmision		datetime	NOT NULL,
	Estatus			char(15)	NOT NULL,	-- CONCLUIDO/CANCELADO/CERRADO
	Caja			int		NULL,
	CajaRef			int		NULL,
	Banco			int		NULL,
	Cajero			int		NULL,
	ClienteSucursal		int		NULL,
	Cliente			int		NULL,
	ClienteIntelisis	varchar(10)	NULL,
	Referencia		varchar(50)	NULL,
  	Corte                   int             NULL,
  	FechaD                  datetime        NULL,
  	FechaA                  datetime        NULL,
	Vencimiento		datetime        NULL,
	Concepto		varchar(50)	NULL,
        FechaBanco		datetime 	NULL,
	Enviado			bit 		NULL DEFAULT 0,
	CajeroCancelacion	int 		NULL,
	OrigenID		int		NULL,
	OrigenTipo		varchar(20)	NULL,
	OrigenFolio		int		NULL,
	Proveedor		int 		NULL,
	ListaPrecios		varchar(20) 	NULL,

    CFDGenerado		bit NULL DEFAULT 0, --MEJORA3051
    CFDID           int NULL, --MEJORA3051
    CFDSerie		varchar(20) NULL, --MEJORA3051
    CFDFolio        varchar(20) NULL, --MEJORA3051

	CONSTRAINT pk_CRMovTemp PRIMARY KEY  CLUSTERED (Sesion, ID, Sucursal)
)
GO

EXEC spALTER_TABLE 'crMovTemp', 'CFDGenerado', 'bit NULL DEFAULT 0' --MEJORA3051
EXEC spALTER_TABLE 'crMovTemp', 'CFDID', 'int NULL' --MEJORA3051
EXEC spALTER_TABLE 'crMovTemp', 'CFDSerie', 'varchar(20) NULL' --MEJORA3051
EXEC spALTER_TABLE 'crMovTemp', 'CFDFolio', 'varchar(20) NULL' --MEJORA3051
GO

if (select version from version)<=2273 and exists (select * from sysobjects where id = object_id('dbo.CRMovD') and type = 'U') 
drop table crMovD
go
if not exists (select * from sysobjects where id = object_id('dbo.CRMovD') and type = 'U') 
CREATE TABLE dbo.CRMovD (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	Tipo			varchar(20)	NOT NULL,	-- Venta/Devolucion/Cobro/Pago/Inventario Fisico
	Vendedor		int		NULL,
	FormaPago		int		NULL,
	Referencia		varchar(50)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50) 	NULL,
	Departamento		int		NULL,
	Cantidad		float		NULL,
	Descuento1		float		NULL,
	Descuento2		float		NULL,
	Importe			money		NULL,
	Moneda			int		NULL,
	TipoCambio		float		NULL,
        Concepto		varchar(50) 	NULL,
	Unidad			varchar(50) 	NULL,
	Codigo			varchar(30) 	NULL,
	Ubicacion		varchar(10) 	NULL,
	Posicion		varchar(10) 	NULL,
	UsuarioAutorizacion	varchar(10)	NULL,
	EsJuego			bit		NULL 	DEFAULT 0,
	RenglonTipo		char(1) 	NULL,
	PrecioEspecial		bit		NULL 	DEFAULT 0,
	PrecioNormal		float		NULL,
	Cancelado		bit 		NULL,
	Costo			money 		NULL,
	TarjetaBanco		varchar(20) 	NULL,
	TarjetaTipo		varchar(20) 	NULL,

	CONSTRAINT pk_CRMovD PRIMARY KEY  CLUSTERED (ID, Sucursal, RID)
)
GO
EXEC spALTER_TABLE 'crMovD', 'SubCuenta', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crMovD', 'Concepto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crMovD', 'Unidad', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crMovD', 'Codigo', 'varchar(30) NULL'
EXEC spALTER_TABLE 'crMovD', 'Ubicacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crMovD', 'RenglonTipo', 'char(1) NULL'
EXEC spALTER_TABLE 'crMovD', 'Posicion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crMovD', 'UsuarioAutorizacion', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crMovD', 'EsJuego', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crMovD', 'PrecioEspecial', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crMovD', 'PrecioNormal', 'float NULL'
EXEC spALTER_TABLE 'crMovD', 'Cancelado', 'bit NULL'
EXEC spALTER_TABLE 'crMovD', 'Costo', 'money NULL'
EXEC spALTER_TABLE 'crMovD', 'TarjetaBanco', 'varchar(20) NULL'
EXEC spALTER_TABLE 'crMovD', 'TarjetaTipo', 'varchar(20) NULL'
GO
EXEC spADD_INDEX 'crMovD', 'IDArticulo', 'Sucursal, ID, Articulo'
GO

if not exists (select * from sysobjects where id = object_id('dbo.CRMovDTemp') and type = 'U') 
CREATE TABLE dbo.CRMovDTemp (
        Sesion			varchar(50)	NOT NULL,
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL,
	RID			int		NOT NULL	IDENTITY(1,1),

	Tipo			varchar(20)	NOT NULL,	-- Venta/Devolucion/Cobro/Pago/Inventario Fisico
	Vendedor		int		NULL,
	FormaPago		int		NULL,
	Referencia		varchar(50)	NULL,
	Articulo		varchar(20)	NULL,
	SubCuenta		varchar(50) 	NULL,
	Departamento		int		NULL,
	Cantidad		float		NULL,
	Descuento1		float		NULL,
	Descuento2		float		NULL,
	Importe			money		NULL,
	Moneda			int		NULL,
	TipoCambio		float		NULL,
        Concepto		varchar(50) 	NULL,
	Unidad			varchar(50) 	NULL,
	Codigo			varchar(30) 	NULL,
	Ubicacion		varchar(10) 	NULL,
	Posicion		varchar(10) 	NULL,
	UsuarioAutorizacion	varchar(10)	NULL,
	EsJuego			bit		NULL 	DEFAULT 0,
	RenglonTipo		char(1) 	NULL,
	PrecioEspecial		bit		NULL 	DEFAULT 0,
	PrecioNormal		float		NULL,
	Cancelado		bit 		NULL,
	Costo			money 		NULL,
	CONSTRAINT pk_CRMovDTemp PRIMARY KEY  CLUSTERED (Sesion, ID, Sucursal, RID)
)
GO

if not exists (select * from sysobjects where id = object_id('dbo.CRMovSoporte') and type = 'U') 
CREATE TABLE dbo.CRMovSoporte (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

  	Corte                   int             NULL,
	FechaRegistro		datetime	NOT NULL	DEFAULT GETDATE(),
	Mov			varchar(20)	NOT NULL,	
	FechaEmision		datetime	NOT NULL,
	Estatus			char(15)	NOT NULL,	-- CONCLUIDO/CANCELADO
	Caja			int		NULL,
	Cajero			int		NULL,
	ClienteIntelisis	varchar(10)	NULL,
	Titulo			varchar(100)	NULL,
	Problema		text		NULL,
	Contacto		varchar(50)	NULL,
	Telefono		varchar(30)	NULL,
	Enviado			bit 		NULL DEFAULT 0,

	CONSTRAINT pk_CRMovSoporte PRIMARY KEY  CLUSTERED (ID, Sucursal)
)
GO
EXEC spALTER_TABLE 'crMovSoporte', 'Corte', 'int NULL'
EXEC spALTER_TABLE 'crMovSoporte', 'Contacto', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crMovSoporte', 'Telefono', 'varchar(30) NULL'
EXEC spALTER_TABLE 'crMovSoporte', 'Enviado', 'bit NULL DEFAULT 0 WITH VALUES'
GO
-- crMovSoporte

if not exists (select * from sysobjects where id = object_id('dbo.crCta') and type = 'U')
CREATE TABLE dbo.crCta (
  Sucursal                    	int             NOT NULL,
  Tipo                        	varchar(20)     NOT NULL,
  Numero                      	int             NOT NULL,

  Nombre                      	varchar(100)    NOT NULL,
  Estatus                     	char(15)        NOT NULL,

  ClaveIntelisis              	varchar(50)     NULL,
  CajeroContrasena            	varchar(20)     NULL,
  CajeroEditarNota            	bit             NULL          DEFAULT 0,
  CajeroPermiteDesc           	bit             NULL          DEFAULT 0,
  CajeroCancelarNotas         	bit             NULL          DEFAULT 0,
  CajeroReasignarCliente      	bit             NULL          DEFAULT 0,
  CajeroCteExpress            	bit             NULL          DEFAULT 0,
  CajeroCteExpressDesc        	bit             NULL          DEFAULT 0,
  CajeroVerSaldo              	bit             NULL          DEFAULT 0,
  CajeroRealizarCorte         	bit             NULL          DEFAULT 0,
  CajeroAnticipo              	bit             NULL          DEFAULT 0,
  CajeroDevAnticipo           	bit             NULL          DEFAULT 0,
  CajeroGasto                 	bit             NULL          DEFAULT 0,
  CajeroDevolucionGasto       	bit             NULL          DEFAULT 0,
  CajeroPrestamo              	bit             NULL          DEFAULT 0,
  CajeroDevPrestamo           	bit             NULL          DEFAULT 0,
  CajeroVentaCredito          	bit             NULL          DEFAULT 0,
  CajeroDevolucionCredito     	bit             NULL          DEFAULT 0,
  CajeroCobroCredito          	bit             NULL          DEFAULT 0,
  CajeroMovsOtrosCajeros      	bit             NULL          DEFAULT 0,
  CajeroMovsOtrasCajas	      	bit             NULL          DEFAULT 0,

  VendedorDeptoOmision        	int             NULL,

  CajaLimiteInferior          	money           NULL,
  CajaLimiteSuperior          	money           NULL,
  CajaFondoFijo               	money           NULL,
  CajaPausaValidar	      	bit 	      	NULL 	    DEFAULT 0,

  VendedorPresupuesto	      	float 	      	NULL,
  MonedaTipoCambio            	float           NULL,
  BancoNumeroCuenta           	varchar(100)    NULL,
  FormaPagoReferenciaOmision  	varchar(50)     NULL,

  VendedorPrimerFolio		varchar(10) 	NULL,
  VendedorUltimoFolio		varchar(10) 	NULL,
  CajaSaltosRenglon		int 		NULL,
  CajaPausaImprimir		int 		NULL 	DEFAULT 0,  
  CajaAbrirCajon		varchar(100) 	NULL,
  CajaCortarTicket		varchar(100) 	NULL,
  CajaValidarNota		varchar(100) 	NULL,
  CajaImpresionNegritas		varchar(100) 	NULL,
  CajaImpresionComprimido	varchar(100) 	NULL,
  CajaImpresionNormal		varchar(100) 	NULL,
  CajaCortarPapel		bit 		NULL 	DEFAULT 0,
  CajaSiguienteDia		bit 		NULL 	DEFAULT 0,

  MonedaTipoCambioCompra	float 		NULL,
  MonedaTipoCambioVenta		float 		NULL,

  CONSTRAINT pk_crCta PRIMARY KEY  CLUSTERED (Sucursal, Tipo, Numero)
)
GO
EXEC spALTER_TABLE 'crCta', 'CajeroEditarNota', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroPermiteDesc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCancelarNotas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroReasignarCliente', 'bit NULL  DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCteExpress', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCteExpressDesc', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'MonedaTipoCambio', 'float NULL'
EXEC spALTER_TABLE 'crCta', 'BancoNumeroCuenta', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajeroVerSaldo', 'bit NULL  DEFAULT 0'
EXEC spALTER_TABLE 'crCta', 'CajeroRealizarCorte', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroAnticipo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroDevAnticipo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroGasto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroDevolucionGasto', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroPrestamo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroDevPrestamo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroVentaCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroDevolucionCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCobroCredito', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovsOtrosCajeros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovsOtrasCajas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'FormaPagoReferenciaOmision', 'varchar(50) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaPausaValidar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'VendedorPresupuesto', 'float NULL'
EXEC spALTER_TABLE 'crCta', 'VendedorPrimerFolio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crCta', 'VendedorUltimoFolio', 'varchar(10) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaSaltosRenglon', 'int NULL'
EXEC spALTER_TABLE 'crCta', 'CajaPausaImprimir', 'int NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajaAbrirCajon', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaCortarTicket', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaValidarNota', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaImpresionNegritas', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaImpresionComprimido', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaImpresionNormal', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'CajaCortarPapel', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajaSiguienteDia', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'MonedaTipoCambioCompra', 'float NULL'
EXEC spALTER_TABLE 'crCta', 'MonedaTipoCambioVenta', 'float NULL'
EXEC spALTER_TABLE 'crCta', 'CajaVentasPorHora', 'float NULL'
EXEC spALTER_TABLE 'crCta', 'CajaPuertoLocal', 'char(10) NULL'
EXEC spALTER_TABLE 'crCta', 'CajeroBorrarCapturaAlm', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonArticulos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonBancos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonCajas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonCajeros', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonCerrarSucursal', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonClientes', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonConceptos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonConfigurar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonDepartamentos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonEliminar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonesPermitidos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonFormasPago', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonMonedas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonSaldoCajas', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroBotonVendedores', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCancelarMovsCaja', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCancelarVentaActual', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCapacidades', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroCapacidadesEspeciales', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroConfigurarAdmin', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroEditarTipoCambio', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroModificarRango', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovCorteCaja', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovFondoInicial', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovRecoleccion', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovsAlmacen', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovsPermitidos', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroPassword', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroReimprimirNota', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroUsarAdmin', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'FormaPagoAceptarCambio', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'FormaPagoDesglosar', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'FormaPagoMonedaEspecifica', 'varchar(100) NULL'
EXEC spALTER_TABLE 'crCta', 'FormaPagoRecolectar', 'bit NULL DEFAULT 1 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroMovAjusteSaldo', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'crCta', 'CajeroVencimContrasena ', 'datetime NULL'
GO

if not exists (select * from sysobjects where id = object_id('dbo.CRCte') and type = 'U') 
CREATE TABLE dbo.CRCte (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	Nombre			varchar(100)	NOT NULL,
	Estatus			char(15)	NOT NULL,	-- ALTA/BLOQUEADO/BAJA
	Tipo			varchar(15)	NULL	DEFAULT 'Cliente',	-- Cliente/Deudor

	Direccion		varchar(100)	NULL,
	EntreCalles		varchar(100) 	NULL,
	Delegacion		varchar(30) 	NULL,
	Colonia 		varchar(30) 	NULL,
	Poblacion 		varchar(30) 	NULL,
	Estado 			varchar(30) 	NULL,
	Pais 			varchar(30)     NULL,
	Zona 			varchar(30) 	NULL,
	CodigoPostal 		varchar(15) 	NULL,
	RFC 			varchar(15)     NULL,
	CURP			varchar(30)     NULL,
	Telefonos		varchar(100) 	NULL,
	Observaciones		varchar(100)    NULL,
	Publico			bit		NULL	DEFAULT 0,
	Descuento		float		NULL,

	CONSTRAINT pk_CRCte PRIMARY KEY  CLUSTERED (ID, Sucursal)
)
GO
EXEC spALTER_TABLE 'CRCte', 'Publico', 'bit NULL DEFAULT 0 WITH VALUES'
EXEC spALTER_TABLE 'CRCte', 'Descuento', 'float NULL'
EXEC spALTER_TABLE 'CRCte', 'Tipo', 'varchar(15) NULL DEFAULT "Cliente" WITH VALUES'
GO

if not exists (select * from sysobjects where id = object_id('dbo.CRBitacora') and type = 'U') 
CREATE TABLE dbo.CRBitacora (
	Sucursal		int		NOT NULL,
	ID			int		NOT NULL	IDENTITY(1,1),

	FechaRegistro		datetime	NOT NULL	DEFAULT GETDATE(),
	FechaEmision		datetime	NOT NULL,
	Mensaje			varchar(255)	NULL,		

	CONSTRAINT pk_CRBitacora PRIMARY KEY  CLUSTERED (ID, Sucursal)
)
GO

if not exists (select * from sysobjects where id = object_id('dbo.crArtPromo') and type = 'U') 
CREATE TABLE dbo.crArtPromo (
	Sucursal		int		NOT NULL,
	Articulo		varchar(20)	NOT NULL,

	VigenciaD		datetime	NULL,
	VigenciaA		datetime	NULL,
	Precio			money		NULL,
	Costo			money		NULL,

	CONSTRAINT pk_crArtPromo PRIMARY KEY  CLUSTERED (Articulo, Sucursal)
)
GO

EXEC spFK 'CRArtPromo','Articulo','Art','Articulo'
GO