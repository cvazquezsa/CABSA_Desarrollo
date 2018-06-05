/*************************** eDocModuloVista **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocModuloVista') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocModuloVista','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocModuloVista') and type = 'U') 
CREATE TABLE eDocModuloVista
    (
	Modulo				varchar(5)		NOT NULL,
	Vista				varchar(50)	    NOT NULL,
	
	CONSTRAINT prieDocModuloVista PRIMARY KEY  CLUSTERED (Modulo, Vista)
	)
GO

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVenta')                INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVenta')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaD')               INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaD')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaMovImpuesto')     INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaMovImpuesto')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaDMovImpuesto')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaDMovImpuesto')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaPedidos')       INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaPedidos')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaArticulos')     INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaArticulos')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaCajaTarima')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaCajaTarima')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaArtCajaTarima') INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaArtCajaTarima')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaSerieLoteMov')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaSerieLoteMov')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaPedidos')       INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaPedidos')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaArticulos')     INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaArticulos')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaCajaTarima')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaCajaTarima')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDSorianaArtCajaTarima') INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDSorianaArtCajaTarima')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaSerieLoteMov')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaSerieLoteMov')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaPedimento')       INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaPedimento')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaMovRetencion')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaMovRetencion')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDVentaCadenaOriginal')  INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDVentaCadenaOriginal')

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CXC' AND Vista = 'CFDCxc')                   INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CXC','CFDCxc')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CXC' AND Vista = 'CFDCxcDetalle')            INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CXC','CFDCxcDetalle')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CXC' AND Vista = 'CFDCXCMovImpuesto')        INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CXC','CFDCXCMovImpuesto')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CXC' AND Vista = 'CFDCXCMovRetencion')       INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CXC','CFDCXCMovRetencion')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CXC' AND Vista = 'CFDCxcCadenaOriginal')     INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CXC','CFDCxcCadenaOriginal')

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDExternoVenta')                INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDExternoVenta')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDExternoVentaD')               INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDExternoVentaD')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDExternoVentaMovImpuesto')     INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDExternoVentaMovImpuesto')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDExternoVentaDMovImpuesto')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDExternoVentaDMovImpuesto')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'VTAS' AND Vista = 'CFDExternoVentaSerieLoteMov')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('VTAS','CFDExternoVentaSerieLoteMov')
GO

IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CORTE' AND Vista = 'CFDCorteCxc')    INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CORTE','CFDCorteCxc')
IF NOT EXISTS(SELECT * FROM eDocModuloVista WHERE Modulo = 'CORTE' AND Vista = 'CFDCorteD')      INSERT eDocModuloVista (Modulo, Vista)  VALUES ('CORTE','CFDCorteD')
GO

/*************************** eDocModuloVistaAyuda **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocModuloVistaAyuda') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocModuloVistaAyuda','N/A')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocModuloVistaAyuda') and type = 'U') 
CREATE TABLE eDocModuloVistaAyuda
    (
	Modulo				varchar(5)		NOT NULL,
	Vista				varchar(50)	    NOT NULL,
	Campo				varchar(100)		NOT NULL,
	
	Descripcion			varchar(255)	NULL,
	
	CONSTRAINT prieDocModuloVistaAyuda PRIMARY KEY  CLUSTERED (Modulo, Vista, Campo)
	)
GO

DELETE FROM eDocModuloVistaAyuda
GO
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','ID','ID del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','ImporteDescuentoGlobal','La Suma del Importe del detalle de la Venta por el % de DescuentoGlobal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','DescuentosTotales','La Suma del Importe del detalle de la Venta por el % de DescuentoGlobal + El Importe del Descuento Lineal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','ImporteSobrePrecio','La suma del Importe del detalle de la Venta por el SobrePrecio de Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','SubTotal','La Suma del Importe del detalle de la Venta Menos el Importe de Descuento Global')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','Impuesto1Total','Total del Impuesto2')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','Impuesto2Total','Total del Impuesto2')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','Impuesto3Total','Total del Impuesto3')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','Impuestos','Total de Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','ImporteTotal','Subtotal Mas los Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'VentaTCalcExportacion','TotalNeto','Subtotal Mas los Impuestos Menos AnticiposFacturados Menos Retenciones')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','OrdenExportacion','Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ID','Id del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaSerie','Numero de Serie (Parte Alfabetica obtenida del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaFolio','Numero de Folio (Parte numerica que es el consecutivo del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaFechaRegistro','Fecha Registro del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaCondicion','Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImporteDescuentoGlobal','Importe del Descuento Global')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImporteSobrePrecio','Importe sobrePrecio')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaSubTotal','La Suma del Importe del detalle de la Venta Menos el Importe de Descuento Global Menos Anticipos Facturados menos Anticipos impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImpuesto1Total','Total del Impuesto2')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImpuesto2Total','Total del Impuesto2')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImpuesto3Total','Total del Impuesto3')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImporteTotal','Subtotal Mas los Impuestos Menos AnticipoFacturados Menos Anticipos Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaTotal','Subtotal Mas los Impuestos Menos AnticiposFacturados Menos Retenciones')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaDescuentoImporte','La Suma del Importe del detalle de la Venta por el % de DescuentoGlobal mas El Importe del Descuento Lineal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImpuestos','Total de Impuestos menos Anticipos Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaFormaPago','La forma de Pago Tipo del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaTipoComprobante','Tipo de comprobante CFD (Ingreso, Egreso, Traslado)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEstatusCancelacion','Estatus del movimiento ORIGINAL o DELETE')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaTipoDocumento','Depende del MovTipo el valor sera INVOICE O CREDIT O DEBIT NOTE ')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaMov','Nombre del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaMovID','MovID del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaImporteLetra','El valor del total neto expresado en Letras')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaOrdenCompra','Folio de la Orden de Compra del receptor')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaOrdenCompraFecha','Fecha de la Orden de Compra del receptor')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaMoneda','Moneda del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaTipoCambio','Tipo de Cambio del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEstatus','Estatus del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','Departamento','Clave del Departamento del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaClaveAfectacion','Clave de afectacion (movTipo) del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaSubClaveAfectacion','SubClave de afectacion (movTipo) del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaGLN','Numero de Localizacion Global de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaNombre','Nombre de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaRFC','RFC de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaCalle','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaNumeroExterior','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaNumeroInterior','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaColonia','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaLocalidad','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaMunicipio','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaEstado','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaPais','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','EmpresaCodigoPostal','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalGLN','Numero de Localizacion Global de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalNombre','Nombre de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalRFC','RFC de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalCalle','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalNumeroExterior','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalNumeroInterior','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalColonia','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalLocalidad','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalMunicipio','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalEstado','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalPais','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','SucursalCodigoPostal','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAGLN','Numero de Localizacion Global de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarANombre','Nombre de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarACalle','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarANumeroExterior','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarANumeroInterior','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAColonia','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarALocalidad','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAMunicipio','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAEstado','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAPais','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarACodigoPostal','Domicilio de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteEnviarAClave','Clave de la Sucursal del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteEmisorID','Clave Emisor con el que se identificara ante su receptor')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteProveedorID','Clave Proveedor con el que se identificara ante su Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteNombre','Nombre del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteRFC','RFC del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteGLN','Numero de Localizacion Global del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteCalle','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteNumeroExterior','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteNumeroInterior','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteColonia','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteLocalidad','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteMunicipio','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteEstado','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClientePais','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteCodigoPostal','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteDireccion','Domicilio Completo del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaTipoPago','Tipo de Condicion de Pago DATE_OF_INVOICE ó EFFECTIVE_DATE')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClientePersonalCobrador','Clave del Personal que esta definido como Cobrador del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','ClienteReceptorID','Clave Receptor con el que identificara a su Emisor')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteDeptoClave','Calve del departamento del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CteDeptocontacto','Contacto asignado al departamento definido en la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CondicionDiasVencimiento','Dias de vencimeinto de la Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CondicionMetodoDePago','Leyenda en "Pago en x Parcialidades" o "Pago en una sola exhibicion" definida en la condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CondicionFormaDePago','Forma de Pago definida en la Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CondicionDescuentoProntoPago','Descuento Pronto Pago definido en la Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaDescuentoGlobalClave','Calve del Descuento global')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaPorcentajeDescuentoGlobal','% De Descuento global')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CFDanoAprobacion','Año de Aprobacion del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','CFDnoAprobacion','Numero de Aprobación del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VariosAhora','Fecha Hora de Hoy')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VariosModuloID','Clave del Modulo + el MovID')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaEmbarque','El Folio del Embarque de la Mercancia')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaEmbarqueFecha','La Fecha del embarque de la mercancia')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaEmbarqueReferencia','Referencia del Embarque')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaRecibo','Folio del Recibo de la Mercancia')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaReciboFecha','Fecha del Recibo de la Mercancia')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaReciboReferencia','Referencia del Recibo de la Mercancia')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaSucursal','Sucursal de la Entrega')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaSucursalOrigen','Sucursal Origen de la entrega')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaEntregaMercancia','Clave del Tipo de Entrega')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVenta','VentaEntregaTotalCajas','Numero Total de Cajas')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','OrdenExportacion','Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaCliente','Clave del Cliente de la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','ID','ID del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDCantidad','Cantidad de Articulos del Detalle de la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDCantidadInventario','Cantidad Inventario de los Articulos de la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDUnidad','Unidad de los articulos de la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','UnidadClave','Clave de la Unidad')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDArticulo','Clave del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','EAN13','Codigo de Barras del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','SKUCliente','Codigo de Inventario del Articulo Asignado por el Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','SKUEmpresa','Codigo de Inventario del articulo Asignado por la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','DUN14','Codigo DUN14 (Codigo de Barras mas Digito de Empaque)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescripcion','Descripcion 1 del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescripcion2','Descripcion 2 del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','ArtTipoEmpaque','Tipo de Empaque Asignado en el Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDPrecio','Precio Unitario del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDPrecioTotal','Precio Total')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescuentoLinea','Descuento Lineal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescuentoImporte','Importe del Descuento Lineal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','ventaDImpuesto1','Impuesto1')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','ventaDImpuesto2','Impuesto2')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImporte','Importe del Detalle')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImporteUnitario','El Importe Dividido entre la Cantidad')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescLineal','')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDDescuentosTotales','Total de Descuento Lineal mas el Descuento Global Prorrateado')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImporteSobrePrecio','El Importe del detalle considerando el SobrePrecio Prorrateado')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDSubTotal','Importe Menos el Importe de Descuento Global Prorrateado')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDSubTotalUnitario','SubTotal Entre Cantidad')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImpuesto1Total','Total de Impuesto 1 de la Partida')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImpuesto2Total','Total de Impuesto 2 de la Partida')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImpuestos','Suma de todos los Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDImporteTotal','Subtotal Mas los Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','VentaDTotalNeto','Subtotal Mas los Impuestos Menos Retenciones Menos AnticiposFacturados (Prorrateados)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','TipoEmpaqueClave','Clave del tipo Empaque Definido para el Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaD','TipoEmpaqueTipo','Tipo de Empaque Definido para el Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','OrdenExportacion','Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','ID','Id del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','VentaDImpuestoClave','Calve del Impuesto VAT(IVA) o GST(IEPS)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','VentaDImpuestoTasa','Tasa del Impuesto')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','VentaDImpuestoImporte','Importe del Impuesto correspondeinte a IVA o IEPS por Articulo del Detalle')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaDMovImpuesto','VentaDCategoriaImpuesto','Categoria dependiendo el Impuesto RETENIDO O TRANSFERIDO por Articulo del Detalle')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','OrdenExportacion','Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','ID','Id del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','Impuesto','IVA O IEPS')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','ImpuestoClave','Calve del Impuesto VAT(IVA) o GST(IEPS)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','Tasa','Tasa del Impuesto ')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','Importe','Suma del Importe del Impuesto Agrupado por tipo de Impuesto ')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaMovImpuesto','CategoriaImpuesto','Categoria dependiendo el Impuesto RETENIDO O TRANSFERIDO ')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','OrdenExportacion','Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','ID','Id del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','SerieLote','Numero de Serie Lote Asignado al Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Cantidad','Cantidad de Series Lotes ')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Propiedades','Pedimento correspondiente a la Serie/Lote del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Ubicacion','Ubicación Asignada para la Serie Lote')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Localizacion','Localizacion de la Serie Lote')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','ArtCostoInv','Costo de la SerieLote')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Fecha1','Fecha del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Fecha2','Fecha2 del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Fecha3','FEcha3 Del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','PedimentoClave','Clave del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','PedimentoRegimen','Regimen Fiscal del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','AgenteAduanal','Agente Aduanal Asignado al Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','Aduana','Aduana que le corresponde al pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','PedimentoTipo','Tipo de Pediemento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaSerieLoteMov','AduanaGLN','Numero de Localizacion global del Pedimento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('VTAS', 'CFDVentaCadenaOriginal','CadenaOriginal','Cadena original del documento')
GO
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaRFC','RFC de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaNombre','Nombre de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaCalle','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaNumeroExterior','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaColonia','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaLocalidad','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaMunicipio','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaEstado','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaPais','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','EmpresaCodigoPostal','Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcFechaRegistro','Fecha Registro del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcSerie','Numero de Serie (Parte Alfabetica obtenida del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcFolio','Numero de Folio (Parte numerica que es el consecutivo del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcCondicion','Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcSubTotal','La Suma del Importe del encabezado Menos el Importe de Descuento Global')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcTipoComprobante','Tipo de comprobante CFD (Ingreso, Egreso, Traslado)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcTotal','Subtotal Mas los Impuestos Menos Retenciones')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcFormaPago','La forma de Pago Tipo del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteRFC','RFC del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteNombre','Nombre del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteCalle','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteNumeroExterior','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteNumeroInterior','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteColonia','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteLocalidad','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteMunicipio','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteEstado','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClientePais','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','ClienteCodigoPostal','Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CondicionFormaDePago','Forma de Pago definida en la Condicion de Pago')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CFDanoAprobacion','Año de Aprobacion del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CFDnoAprobacion','Numero de Aprobación del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalCalle','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalNumeroExterior','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalNumeroInterior','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalColonia','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalMunicipio','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalPais','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalEstado','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalCodigoPostal','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','SucursalLocalidad','Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcRetencion','Total de Retenciones')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxc','CxcImpuestos','Total de Impuestos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDCantidad','Cantidad de Articulos del Detalle de la Venta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDUnidad','Unidad de los artículos')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDArticulo','Clave del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDDescripcion','Descripcion 1 del Artículo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDPrecio','Precio Unitario del Articulo')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcD','CFDCxcDPrecioTotal','Precio Total')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCXCMovImpuesto','Impuesto','Calve del Impuesto VAT(IVA) o GST(IEPS)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCXCMovImpuesto','Tasa','Tasa del Impuesto')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCXCMovImpuesto','Importe','Importe del Impuesto correspondeinte a IVA')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CXC', 'CFDCxcCadenaOriginal','CadenaOriginal','Cadena original del documento')
GO

INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','{NombreSeccion}','Etiqueta utilizada para definir el inicio de sección en una plantilla')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','{/NombreSeccion}','Etiqueta utilizada para definir el fin de sección en una plantilla')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','[NombreCampoeDoc]','Etiqueta utilizada para definir un campo en una plantilla que será sustituido por algún dato de Intelisis. Ejemplo: [NombreCliente]')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','«NombreConsecutivo|Inicial|Intervalo»','Etiqueta utilizada para definir un consecutivo dentro de una plantilla. Ejemplos: «ConsecutivoTipoRenglon|2048|2048» «ConsecutivoTipoRenglonSub|0» «ConsecutivoEstandar»')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','^NombreContador^','Se utilizada para contar la cantidad de veces que aparece una cierta seccion en un documento. Esta etiqueta no aparecerá en el documento final y el total se presentará donde se encuentre ~NombreContador~. Ejemplo: ^ContadorSerieLote^')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('Todos', 'Plantilla','~NombreContador~','En el documento final, se sistituirá esta etiqueta por el total de veces que se encuentre la siguiente etiqueta en el documento: ^NombreContador^')
GO

INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CFDanoAprobacion', 'Año de Aprobacion del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CFDnoAprobacion', 'Numero de Aprobación del Rango de Folios Autorizados por el SAT')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteCalle', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteCodigoPostal', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteColonia', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteDireccion', 'Domicilio Completo del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteEstado', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteGLN', 'Numero de Localizacion Global del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteLocalidad', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteMunicipio', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteNombre', 'Nombre del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteNumeroExterior', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteNumeroInterior', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClientePais', 'Domicilio del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteRFC', 'RFC del Cliente')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaCalle', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaCodigoPostal', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaColonia', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaEstado', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaGLN', 'Numero de Localizacion Global de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaLocalidad', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaMunicipio', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaNombre', 'Nombre de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaNumeroExterior', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaNumeroInterior', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaPais', 'Domicilio de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'EmpresaRFC', 'RFC de la Empresa')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ID', 'Id del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'OrdenExportacion', 'Exclusivo para el Ordenamiento al construir el Documento Electronico')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalCalle', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalCodigoPostal', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalColonia', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalEstado', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalGLN', 'Numero de Localizacion Global de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalLocalidad', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalMunicipio', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalNombre', 'Nombre de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalNumeroExterior', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalNumeroInterior', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalPais', 'Domicilio de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'SucursalRFC', 'RFC de la Sucursal')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteEstatus', 'Estatus del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteFechaRegistro', 'Fecha Registro del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteFolio', 'Numero de Folio (Parte numerica que es el consecutivo del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteMoneda', 'Moneda del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteMov', 'Nombre del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteMovID', 'MovID del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteSerie', 'Numero de Serie (Parte Alfabetica obtenida del MovID)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteTipoCambio', 'Tipo de Cambio del movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteTipoComprobante', 'Tipo de comprobante CFD (Ingreso, Egreso, Traslado)')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteFechaDe', 'Fecha Inicial del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteFechaA', 'Fecha Final del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteClienteDe', 'Cliente Inicial del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteClienteA', 'Cliente Final del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteEjercicio', 'Ejercicio del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CortePeriodo', 'Periodo del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CorteConcepto', 'Concepto del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'ClienteClave', 'Cliente del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteCxc', 'CortePeriodoFechas', 'Intervalo de Fechas del Estado de Cuenta')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoFecha', 'Fecha del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoVencimiento', 'Vencimiento del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoCargo', 'Cargo del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoAbono', 'Abono del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'CorteCliente', 'Cliente del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'Movimiento', 'Nombre y Folio del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoFolio', 'Folio del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoMoneda', 'Moneda del Movimiento')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoAplica', 'Nombre del Movimiento que Aplica')
INSERT eDocModuloVistaAyuda (Modulo, Vista, Campo, Descripcion) VALUES ('CORTE', 'CFDCorteD', 'MovimientoAplicaFolio', 'Folio del Movimiento que Aplica')
GO

/*************************** eDocSeccionTemporal **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocSeccionTemporal') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocSeccionTemporal','N/A') -- Bug 12306
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocSeccionTemporal') and type = 'U') 
CREATE TABLE eDocSeccionTemporal
    (
	Estacion			int				NOT NULL,
	Modulo				varchar(5)		NOT NULL,
	ModuloID			int				NOT NULL,
	RID					int				identity(1,1),
	OrdenExportacion	varchar(255)	NULL,
	Documento			text			NULL,
	
	CONSTRAINT prieDocSeccionTemporal PRIMARY KEY  CLUSTERED (Estacion, Modulo, ModuloID, RID)
	)
GO

/*************************** eDocXSD **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocXSD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocXSD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocXSD') and type = 'U')
CREATE TABLE eDocXSD
        (
    Modulo			varchar(5)    NOT NULL,    
	Clave			varchar(50)   NOT NULL,
	
	XSD				varchar(MAX)  NULL,

	CONSTRAINT prieDocXSD PRIMARY KEY CLUSTERED (Clave)
	)
GO

/*************************** eDoc **************************/
if not exists (select * from SysTabla where SysTabla = 'eDoc') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDoc','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDoc') and type = 'U')
CREATE TABLE eDoc
        (
	Modulo						varchar(5)   NOT NULL,
    eDoc						varchar(50)  NOT NULL,

    TipoXML						bit          NULL DEFAULT 0,
	Documento					varchar(MAX) NULL,
	XSD							varchar(50)  NULL,
	TipoCFD						bit			 NULL DEFAULT 0,
	DecimalesPorOmision			int			 NULL DEFAULT 2,
	TipoCFDI					bit			 NULL DEFAULT 0,
	TimbrarEnTransaccion		bit			 NULL DEFAULT 1,

	CaracterExtendidoAASCII		bit			 NULL DEFAULT 1,
	ConvertirPaginaCodigo437	bit			 NULL DEFAULT 0,
	ConvertirComillaDobleAASCII	bit			 NULL DEFAULT 1,

	UltimoCambio				datetime	NULL,
	UltimaCompilacion			datetime	NULL,
	--REQ Q3069 CFDGT
	Sellar						bit			NULL DEFAULT 1,

	CONSTRAINT prieDoc PRIMARY KEY CLUSTERED (Modulo, eDoc)
	)
GO

EXEC spALTER_TABLE 'eDoc', 'TipoCFD', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA1792
EXEC spAlter_Table 'eDoc', 'DecimalesPorOmision', 'int NULL DEFAULT 2 WITH VALUES'
EXEC spALTER_TABLE 'eDoc', 'TipoCFDI', 'bit NULL DEFAULT 0 WITH VALUES' --MEJORA1792
EXEC spALTER_TABLE 'eDoc', 'TimbrarEnTransaccion', 'bit NULL DEFAULT 1 WITH VALUES' --MEJORA1792
GO
EXEC spALTER_TABLE 'eDoc', 'CaracterExtendidoAASCII',	  'bit	NULL DEFAULT 1 WITH VALUES' --Caracteres Extendidos a ASCII
EXEC spALTER_TABLE 'eDoc', 'ConvertirPaginaCodigo437',	  'bit	NULL DEFAULT 0 WITH VALUES' --Convertir a CP437
EXEC spALTER_TABLE 'eDoc', 'ConvertirComillaDobleAASCII', 'bit	NULL DEFAULT 1 WITH VALUES' --Comilla Doble a ASCII
EXEC spALTER_TABLE 'eDoc', 'UltimoCambio',	      'datetime	NULL'
EXEC spALTER_TABLE 'eDoc', 'UltimaCompilacion',	  'datetime	NULL'
GO

--REQ Q3069 CFDGT
EXEC spALTER_TABLE 'eDoc', 'Sellar', 'bit NULL DEFAULT 1 WITH VALUES'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeDocAC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocAC
GO
CREATE TRIGGER tgeDocAC ON eDoc
--//WITH ENCRYPTION
FOR UPDATE, INSERT
AS BEGIN
  DECLARE
    
    @eDocA					varchar(50),
    @eDocN					varchar(50),
    @ModuloA				varchar(5),
    @ModuloN				varchar(5),
    @UltimoCambioA			datetime,
    @UltimaCompilacionA		datetime,
    @UltimoCambioN			datetime,
    @UltimaCompilacionN		datetime
  
  SELECT @eDocA = NULLIF(RTRIM(eDoc), ''), @ModuloA = NULLIF(RTRIM(Modulo), ''), @UltimoCambioA = NULLIF(UltimoCambio, ''), @UltimaCompilacionA = NULLIF(UltimaCompilacion, '') FROM Deleted
  SELECT @eDocN = NULLIF(RTRIM(eDoc), ''), @ModuloN = NULLIF(RTRIM(Modulo), ''), @UltimoCambioN = NULLIF(UltimoCambio, ''), @UltimaCompilacionN = NULLIF(UltimaCompilacion, '') FROM Inserted

--SELECT @eDocA, @eDocN, @ModuloA, @ModuloN, @UltimoCambioA, @UltimaCompilacionA, @UltimoCambioN, @UltimaCompilacionN

  IF @UltimoCambioA = @UltimoCambioN AND @UltimaCompilacionA = @UltimaCompilacionN
  BEGIN    
    UPDATE eDoc SET UltimoCambio = GETDATE() WHERE eDoc = @eDocN AND Modulo = @ModuloN
  END

END
GO


/*************************** eDocD **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocD','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocD') and type = 'U')
CREATE TABLE eDocD
        (
	Modulo				varchar(5) NOT NULL,
    eDoc				varchar(50)  NOT NULL,
	RID					int IDENTITY(1,1) NOT NULL,

	Orden				int NULL,
	Seccion				varchar(50) NULL,
	SubSeccionDe		varchar(50) NULL,
	Vista				varchar(100) NULL,
	Cierre				bit NULL,
	TablaSt				varchar(50) NULL,				
	
	CONSTRAINT prieDocD PRIMARY KEY  CLUSTERED (Modulo, eDoc, RID)
	)
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeDocDAC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocDAC
GO
CREATE TRIGGER tgeDocDAC ON eDocD
--//WITH ENCRYPTION
FOR UPDATE, INSERT
AS BEGIN
  DECLARE
    
    @eDocA					varchar(50),
    @eDocN					varchar(50),
    @ModuloA				varchar(5),
    @ModuloN				varchar(5)
  
  SELECT @eDocA = NULLIF(RTRIM(eDoc), ''), @ModuloA = NULLIF(RTRIM(Modulo), '') FROM Deleted
  SELECT @eDocN = NULLIF(RTRIM(eDoc), ''), @ModuloN = NULLIF(RTRIM(Modulo), '') FROM Inserted

  UPDATE eDoc SET UltimoCambio = GETDATE() WHERE eDoc = @eDocN AND Modulo = @ModuloN

END
GO


/*************************** eDocDTagSostener **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocDTagSostener') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocDTagSostener','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocDTagSostener') and type = 'U')
CREATE TABLE eDocDTagSostener
        (
	Modulo				varchar(5) NOT NULL,
    eDoc				varchar(50)  NOT NULL,
	SeccionID			int NOT NULL,
	Tag					varchar(255) NOT NULL,
	
	CONSTRAINT prieDocDTagSostener PRIMARY KEY  CLUSTERED (Modulo, eDoc, SeccionID, Tag)
	)
GO


/*************************** eDocDMapeoCampo **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocDMapeoCampo') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocDMapeoCampo','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocDMapeoCampo') and type = 'U')
CREATE TABLE eDocDMapeoCampo
        (
	Modulo				varchar(5) NOT NULL,
	eDoc				varchar(50)  NOT NULL,
	IDSeccion			int NOT NULL,
	RID					int IDENTITY(1,1) NOT NULL,

	CampoXML			varchar(255)	NOT NULL,
	CampoVista			varchar(255)	NULL,
	FormatoOpcional		varchar(50)		NULL,
	Traducir			bit				NULL DEFAULT 0,
	Opcional			bit				NULL DEFAULT 0,	
	BorrarSiOpcional	varchar(255)	NULL,
	
	TablaSt				varchar(50)		NULL,					
	Decimales			int				NULL,

	CaracterExtendidoAASCII		bit		NULL,
	ConvertirPaginaCodigo437	bit		NULL,
	ConvertirComillaDobleAASCII	bit		NULL,

	NumericoNuloACero	bit				NULL DEFAULT 0,
	
	CONSTRAINT prieDocDMapeoCampo PRIMARY KEY  CLUSTERED (Modulo, eDoc, IDSeccion, RID)
	)
GO

EXEC spAlter_Table 'eDocDMapeoCampo', 'TablaSt', 'varchar(50) NULL'
EXEC spAlter_Table 'eDocDMapeoCampo', 'Decimales', 'int NULL'
GO
EXEC spALTER_TABLE 'eDocDMapeoCampo', 'CaracterExtendidoAASCII', 'bit NULL'
EXEC spALTER_TABLE 'eDocDMapeoCampo', 'ConvertirPaginaCodigo437', 'bit NULL'
EXEC spALTER_TABLE 'eDocDMapeoCampo', 'ConvertirComillaDobleAASCII', 'bit NULL'
GO
EXEC spALTER_TABLE 'eDocDMapeoCampo', 'NumericoNuloACero', 'bit NULL DEFAULT 0 WITH VALUES'
GO

if exists (select * from sysobjects where id = object_id('dbo.tgeDocDMapeoCampoAC') and sysstat & 0xf = 8) drop trigger dbo.tgeDocDMapeoCampoAC
GO
CREATE TRIGGER tgeDocDMapeoCampoAC ON eDocDMapeoCampo
--//WITH ENCRYPTION
FOR UPDATE, INSERT
AS BEGIN
  DECLARE
    
    @eDocA					varchar(50),
    @eDocN					varchar(50),
    @ModuloA				varchar(5),
    @ModuloN				varchar(5)
  
  SELECT @eDocA = NULLIF(RTRIM(eDoc), ''), @ModuloA = NULLIF(RTRIM(Modulo), '') FROM Deleted
  SELECT @eDocN = NULLIF(RTRIM(eDoc), ''), @ModuloN = NULLIF(RTRIM(Modulo), '') FROM Inserted

  UPDATE eDoc SET UltimoCambio = GETDATE() WHERE eDoc = @eDocN AND Modulo = @ModuloN

END
GO

/****** CFDFlexSesion  ******/
if not exists(select * from SysTabla where SysTabla = 'CFDFlexSesion')
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDFlexSesion','N/A') -- Bug 12306
if not exists (select * from sysobjects where id = object_id('dbo.CFDFlexSesion') and type = 'U') 
  CREATE TABLE dbo.CFDFlexSesion (
	Estacion			int		NOT NULL,
	Modulo				char(5)	NOT NULL,
	ID					int		NOT NULL
	
	CONSTRAINT priCFDFlexSesion PRIMARY KEY  CLUSTERED (Estacion, Modulo, ID)
)
GO

/*************************** eDocCompilacion **************************/
if not exists (select * from SysTabla where SysTabla = 'eDocCompilacion') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('eDocCompilacion','N/A') -- Bug 12306
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.eDocCompilacion') and type = 'U')
CREATE TABLE eDocCompilacion
        (
	Modulo						varchar(5)   NOT NULL,
    eDoc						varchar(50)  NOT NULL,
	Orden						int			 NOT NULL,
	
	CodigoSQL					varchar(max) NULL,

	CONSTRAINT prieDocCompilacion PRIMARY KEY CLUSTERED (Modulo, eDoc, Orden)
	)
GO

/*************************** MovTipoeDoc **************************/
if not exists (select * from SysTabla where SysTabla = 'MovTipoeDoc') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('MovTipoeDoc','Maestro')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.MovTipoeDoc') and type = 'U')
CREATE TABLE MovTipoeDoc
        (
	Modulo				varchar(5) NOT NULL,
	Mov					varchar(20) NOT NULL,
	Contacto			varchar(10) NOT NULL,
	
	eDoc				varchar(50)  NULL,	
	Estatus				varchar(15) NULL,

	CONSTRAINT priMovTipoeDoc PRIMARY KEY  CLUSTERED (Modulo, Mov, Contacto)
	)
GO

/*************************** CFDExtVenta **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDExtVenta') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDExtVenta','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExtVenta') and type = 'U')
CREATE TABLE CFDExtVenta
        (

        ID								int	identity(1,1) NOT NULL,
        
        VentaSerie						varchar(20)	NULL,
        VentaFolio						varchar(20)	NULL,
        VentaFechaRegistro				datetime	NULL,
        VentaCondicion					varchar(50)	NULL,
        VentaImporteDescuentoGlobal		money	NULL,
        VentaImporteSobrePrecio			money	NULL,
        VentaSubTotal					money	NULL,
        VentaImpuesto1Total				money	NULL,
        VentaImpuesto2Total				money	NULL,
        VentaImpuesto3Total				money	NULL,
        VentaImporteTotal				money	NULL,
        VentaTotal						money	NULL,
        VentaDescuentoImporte			money	NULL,
        VentaImpuestos					money	NULL,
        VentaFormaPago					varchar(50)	NULL,
        VentaTipoComprobante			varchar(20)	NULL,
        VentaEstatusCancelacion			varchar(15)	NULL,
        VentaTipoDocumento				varchar(11)	NULL,
        VentaMovID						varchar(20)	NULL,
        VentaImporteLetra				varchar(255)	NULL,
        VentaOrdenCompra				varchar(50)		NULL,
        VentaOrdenCompraFecha			datetime		NULL,
        VentaMoneda						varchar(10)		NULL,
        VentaTipoCambio					float			NULL,
        VentaEstatus					varchar(15)		NULL,
        Departamento					int				NULL,
        VentaClaveAfectacion			varchar(20)		NULL,
        VentaSubClaveAfectacion			varchar(20)		NULL,
        EmpresaGLN						varchar(50)		NULL,
        EmpresaNombre					varchar(100)	NULL,
        EmpresaRFC						varchar(20)		NULL,
        EmpresaCalle					varchar(100)	NULL,
        EmpresaNumeroExterior			varchar(20)		NULL,
        EmpresaNumeroInterior			varchar(20)		NULL,
        EmpresaColonia					varchar(30)		NULL,
        EmpresaLocalidad				varchar(30)		NULL,
        EmpresaMunicipio				varchar(100) NULL,
        EmpresaEstado					varchar(30) NULL,
        EmpresaPais						varchar(30) NULL,
        EmpresaCodigoPostal				varchar(15) NULL,
        SucursalGLN						varchar(50) NULL,
        SucursalNombre					varchar(100) NULL,
        SucursalRFC						varchar(20) NULL,
        SucursalCalle					varchar(100) NULL,
        SucursalNumeroExterior			varchar(20) NULL,
        SucursalNumeroInterior			varchar(20) NULL,
        SucursalColonia					varchar(30) NULL,
        SucursalLocalidad				varchar(30) NULL,
        SucursalMunicipio				varchar(100) NULL,
        SucursalEstado					varchar(30) NULL,
        SucursalPais					varchar(30) NULL,
        SucursalCodigoPostal			varchar(15) NULL,
        CteEnviarAGLN					varchar(50) NULL,
        CteEnviarANombre				varchar(100) NULL,
        CteEnviarACalle					varchar(100) NULL,
        CteEnviarANumeroExterior		varchar(20) NULL,
        CteEnviarANumeroInterior		varchar(20) NULL,
        CteEnviarAColonia				varchar(100) NULL,
        CteEnviarALocalidad				varchar(100) NULL,
        CteEnviarAMunicipio				varchar(100) NULL,
        CteEnviarAEstado				varchar(30) NULL,
        CteEnviarAPais					varchar(30) NULL,
        CteEnviarACodigoPostal			varchar(15) NULL,
        CteEnviarAClave					varchar(10) NULL,
        ClienteEmisorID					varchar(20) NULL,
        ClienteProveedorID				varchar(20) NULL,
        ClienteNombre					varchar(100) NULL,
        ClienteRFC						varchar(15) NULL,
        ClienteGLN						varchar(50) NULL,
        ClienteCalle					varchar(100) NULL,
        ClienteNumeroExterior			varchar(20) NULL,
        ClienteNumeroInterior			varchar(20) NULL,
        ClienteColonia					varchar(100) NULL,
        ClienteLocalidad				varchar(100) NULL,
        ClienteMunicipio				varchar(100) NULL,
        ClienteEstado					varchar(30) NULL,
        ClientePais						varchar(30) NULL,
        ClienteCodigoPostal				varchar(15) NULL,
        ClienteDireccion				varchar(255) NULL,
        VentaTipoPago					varchar(15) NULL,
        ClientePersonalCobrador			varchar(10) NULL,
        ClienteReceptorID				varchar(20) NULL,
        CteDeptoClave					varchar(20) NULL,
        CteDeptocontacto				varchar(100) NULL,
        CondicionDiasVencimiento		int NULL,
        CondicionMetodoDePago			varchar(100) NULL,
        CondicionFormaDePago			varchar(100) NULL,
        CondicionDescuentoProntoPago	float NULL,
        VentaDescuentoGlobalClave		varchar(20) NULL,
        VentaPorcentajeDescuentoGlobal	float NULL,
        CFDanoAprobacion				int NULL,
        CFDnoAprobacion					int NULL,
        VariosAhora						datetime NULL,
        VariosModuloID					varchar(50) NULL,
        VentaEntregaEmbarque			varchar(50) NULL,
        VentaEntregaEmbarqueFecha		datetime NULL,
        VentaEntregaEmbarqueReferencia	varchar(50) NULL,
        VentaEntregaRecibo				varchar(50) NULL,
        VentaEntregaReciboFecha			datetime NULL,
        VentaEntregaReciboReferencia	varchar(50) NULL,
        VentaEntregaSucursal			int NULL,
        VentaEntregaSucursalOrigen		int NULL,
        VentaEntregaEntregaMercancia	varchar(20) NULL,
        VentaEntregaTotalCajas			int NULL,

        CONSTRAINT priCFDExtVenta PRIMARY KEY  CLUSTERED (ID)
)
GO
EXEC spAlter_Table 'CFDExtVenta', 'ClienteEmisorID', 'varchar(20) NULL'
GO
EXEC spAlter_Table 'CFDExtVenta', 'ClienteProveedorID', 'varchar(20) NULL'
GO


/***************** CFDExternoVenta *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExternoVenta') AND TYPE = 'V') 
  DROP VIEW CFDExternoVenta
GO
CREATE VIEW CFDExternoVenta AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  ID,
  VentaSerie,
  VentaFolio,
  VentaFechaRegistro,
  VentaCondicion,
  VentaImporteDescuentoGlobal,
  VentaImporteSobrePrecio,
  VentaSubTotal,
  VentaImpuesto1Total,
  VentaImpuesto2Total,
  VentaImpuesto3Total,
  VentaImporteTotal,
  VentaTotal,
  VentaDescuentoImporte,
  VentaImpuestos,
  VentaFormaPago,
  VentaTipoComprobante,
  VentaEstatusCancelacion,
  VentaTipoDocumento,
  VentaMovID,
  VentaImporteLetra,
  VentaOrdenCompra,
  VentaOrdenCompraFecha,
  VentaMoneda,
  VentaTipoCambio,
  VentaEstatus,
  Departamento,
  VentaClaveAfectacion,
  VentaSubClaveAfectacion,
  EmpresaGLN,
  EmpresaNombre,
  EmpresaRFC,
  EmpresaCalle,
  EmpresaNumeroExterior,
  EmpresaNumeroInterior,
  EmpresaColonia,
  EmpresaLocalidad,
  EmpresaMunicipio,
  EmpresaEstado,
  EmpresaPais,
  EmpresaCodigoPostal,
  SucursalGLN,
  SucursalNombre,
  SucursalRFC,
  SucursalCalle,
  SucursalNumeroExterior,
  SucursalNumeroInterior,
  SucursalColonia,
  SucursalLocalidad,
  SucursalMunicipio,
  SucursalEstado,
  SucursalPais,
  SucursalCodigoPostal,
  CteEnviarAGLN,
  CteEnviarANombre,
  CteEnviarACalle,
  CteEnviarANumeroExterior,
  CteEnviarANumeroInterior,
  CteEnviarAColonia,
  CteEnviarALocalidad,
  CteEnviarAMunicipio,
  CteEnviarAEstado,
  CteEnviarAPais,
  CteEnviarACodigoPostal,
  CteEnviarAClave,
  ClienteEmisorID,
  ClienteProveedorID,
  ClienteNombre,
  ClienteRFC,
  ClienteGLN,
  ClienteCalle,
  ClienteNumeroExterior,
  ClienteNumeroInterior,
  ClienteColonia, 
  ClienteLocalidad,
  ClienteMunicipio,
  ClienteEstado,
  ClientePais,
  ClienteCodigoPostal,
  ClienteDireccion,
  VentaTipoPago,
  ClientePersonalCobrador,
  ClienteReceptorID,
  CteDeptoClave,
  CteDeptocontacto,
  CondicionDiasVencimiento,
  CondicionMetodoDePago,
  CondicionFormaDePago,
  CondicionDescuentoProntoPago,
  VentaDescuentoGlobalClave,
  VentaPorcentajeDescuentoGlobal,
  CFDanoAprobacion,
  CFDnoAprobacion,
  VariosAhora,
  VariosModuloID,
  VentaEntregaEmbarque,
  VentaEntregaEmbarqueFecha,
  VentaEntregaEmbarqueReferencia,
  VentaEntregaRecibo,
  VentaEntregaReciboFecha,
  VentaEntregaReciboReferencia,
  VentaEntregaSucursal,
  VentaEntregaSucursalOrigen,
  VentaEntregaEntregaMercancia,
  VentaEntregaTotalCajas
  FROM CFDExtVenta  
GO

/*************************** CFDExtVentaD **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDExtVentaD') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDExtVentaD','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExtVentaD') and type = 'U')
CREATE TABLE CFDExtVentaD
        (

        ID								int NOT NULL,
        Renglon							float NOT NULL,
        RenglonSub						int NOT NULL,
        
        VentaCliente					varchar(10) NULL,
        VentaDCantidad					float NULL,
        VentaDCantidadInventario		float NULL,
        VentaDUnidad					varchar(50) NULL,
        UnidadClave						char(10) NULL,
        VentaDArticulo					varchar(20) NULL,
        EAN13				varchar(50) NULL,
        SKUCliente						varchar(50) NULL,
        SKUEmpresa				varchar(50) NULL,
        DUN14						varchar(50) NULL,
        VentaDDescripcion				varchar(100) NULL,
        VentaDDescripcion2				varchar(255) NULL,
        ArtTipoEmpaque					varchar(50) NULL,
        VentaDPrecio					float NULL,
        VentaDPrecioTotal				money NULL,
        VentaDDescuentoLinea			money NULL,
        VentaDDescuentoImporte			money NULL,
        ventaDImpuesto1					float NULL,
        ventaDImpuesto2					float NULL,
        VentaDImporte					float NULL,
        VentaDImporteUnitario			float NULL,
        VentaDDescLineal				float NULL,
        VentaDDescuentosTotales			money NULL,
        VentaDImporteSobrePrecio		money NULL,
        VentaDSubTotal					money NULL,
        VentaDSubTotalUnitario			float NULL,
        VentaDImpuesto1Total			money NULL,
        VentaDImpuesto2Total			money NULL,
        VentaDImpuestos					money NULL,
        VentaDImporteTotal				money NULL,
        VentaDTotalNeto					money NULL,
        TipoEmpaqueClave				varchar(20) NULL,
        TipoEmpaqueTipo					varchar(20) NULL,

        CONSTRAINT priCFDExtVentaD PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub)
)
GO

EXEC spAlter_Table 'CFDExtVentaD', 'EAN13', 'varchar(50) NULL'
EXEC spAlter_Table 'CFDExtVentaD', 'SKUCliente', 'varchar(50) NULL'
EXEC spAlter_Table 'CFDExtVentaD', 'SKUEmpresa', 'varchar(50) NULL'
EXEC spAlter_Table 'CFDExtVentaD', 'DUN14', 'varchar(50) NULL'
GO

/***************** CFDExternoVentaD *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExternoVentaD') AND TYPE = 'V') 
  DROP VIEW CFDExternoVentaD
GO
CREATE VIEW CFDExternoVentaD AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,RenglonSub))) +
  REPLICATE(' ',50)
  OrdenExportacion,
  ID,
  Renglon,
  RenglonSub,
  VentaCliente,
  VentaDCantidad,
  VentaDCantidadInventario,
  VentaDUnidad,
  UnidadClave,
  VentaDArticulo,
  EAN13,
  SKUCliente,
  SKUEmpresa,
  DUN14,
  VentaDDescripcion,
  VentaDDescripcion2,
  ArtTipoEmpaque,
  VentaDPrecio,
  VentaDPrecioTotal,
  VentaDDescuentoLinea,
  VentaDDescuentoImporte,
  ventaDImpuesto1,
  ventaDImpuesto2,
  VentaDImporte,
  VentaDImporteUnitario,
  VentaDDescLineal,
  VentaDDescuentosTotales,
  VentaDImporteSobrePrecio,
  VentaDSubTotal,
  VentaDSubTotalUnitario,
  VentaDImpuesto1Total,
  VentaDImpuesto2Total,
  VentaDImpuestos,
  VentaDImporteTotal,
  VentaDTotalNeto,
  TipoEmpaqueClave,
  TipoEmpaqueTipo
  FROM CFDExtVentaD
GO

/*************************** CFDExtVentaDMovImpuesto **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDExtVentaDMovImpuesto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDExtVentaDMovImpuesto','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExtVentaDMovImpuesto') and type = 'U')
CREATE TABLE CFDExtVentaDMovImpuesto
        (

        ID								int NOT NULL,
        Renglon							float NOT NULL,
        RenglonSub						int NOT NULL,
        VentaDImpuestoClave				varchar(10) NOT NULL,

        VentaDImpuestoTasa				float NULL,
        VentaDImpuestoImporte			float NULL,
        VentaDCategoriaImpuesto			varchar(20) NULL,
        
        CONSTRAINT priCFDExtVentaDMovImpuesto PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub, VentaDImpuestoClave)        
)
GO

/***************** CFDExternoVentaDMovImpuesto *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExternoVentaDMovImpuesto') AND TYPE = 'V') 
  DROP VIEW CFDExternoVentaDMovImpuesto
GO
CREATE VIEW CFDExternoVentaDMovImpuesto AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,RenglonSub))) +
  VentaDImpuestoClave + REPLICATE(' ',50 - LEN(VentaDImpuestoClave))
  OrdenExportacion,
  ID,
  Renglon,
  RenglonSub,
  VentaDImpuestoClave,
  VentaDImpuestoTasa,
  VentaDImpuestoImporte,
  VentaDCategoriaImpuesto
  FROM CFDExtVentaDMovImpuesto
GO  

/*************************** CFDExtVentaSerieLoteMov **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDExtVentaSerieLoteMov') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDExtVentaSerieLoteMov','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExtVentaSerieLoteMov') and type = 'U')
CREATE TABLE CFDExtVentaSerieLoteMov
        (
        ID						int NOT NULL,
        Renglon					float NOT NULL,
        RenglonSub				int NOT NULL,
        SerieLote				varchar(50) NOT NULL,
        
        Cantidad				float NULL,
        Propiedades				varchar(20) NULL,
        Ubicacion				int NULL,
        Localizacion			varchar(10) NULL,
        ArtCostoInv				money NULL,
        Fecha1					datetime NULL,
        Fecha2					datetime NULL,
        Fecha3					datetime NULL,
        PedimentoClave			varchar(5) NULL,
        PedimentoRegimen		varchar(5) NULL,
        AgenteAduanal			varchar(10) NULL,
        Aduana					varchar(50) NULL,
        PedimentoTipo			varchar(20) NULL,
        AduanaGLN				varchar(50) NULL,
        
        CONSTRAINT priCFDExtVentaSerieLoteMov PRIMARY KEY  CLUSTERED (ID, Renglon, RenglonSub, SerieLote)                
)
GO

/***************** CFDExternoVentaSerieLoteMov *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExternoVentaSerieLoteMov') AND TYPE = 'V') 
  DROP VIEW CFDExternoVentaSerieLoteMov
GO
CREATE VIEW CFDExternoVentaSerieLoteMov AS
SELECT 
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE('0',12-LEN(RTRIM(LTRIM(CONVERT(varchar,Renglon))))) + RTRIM(LTRIM(CONVERT(varchar,Renglon))) + 
  REPLICATE('0',7-LEN(RTRIM(LTRIM(CONVERT(varchar,RenglonSub))))) + RTRIM(LTRIM(CONVERT(varchar,RenglonSub))) +
  RTRIM(SerieLote) + REPLICATE (' ', 50 - LEN(RTRIM(SerieLote)))
  OrdenExportacion,
  ID,
  Renglon,
  RenglonSub,
  SerieLote,
  Cantidad,
  Propiedades,
  Ubicacion,
  Localizacion,
  ArtCostoInv,
  Fecha1,
  Fecha2,
  Fecha3,
  PedimentoClave,
  PedimentoRegimen,
  AgenteAduanal,
  Aduana,
  PedimentoTipo,
  AduanaGLN
  FROM CFDExtVentaSerieLoteMov
GO

/*************************** CFDExtVentaMovImpuesto **************************/
if not exists (select * from SysTabla where SysTabla = 'CFDExtVentaMovImpuesto') 
INSERT INTO SysTabla (SysTabla,Tipo) VALUES ('CFDExtVentaMovImpuesto','Movimiento')
IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExtVentaMovImpuesto') and type = 'U')
CREATE TABLE CFDExtVentaMovImpuesto
        (
        ID								int NOT NULL,
        Impuesto						varchar(50) NOT NULL,
        
        ImpuestoClave					varchar(50) NULL,
        Tasa							float NULL,
        Importe							money NULL,
        CategoriaImpuesto				varchar(11) NULL,
                
        CONSTRAINT priCFDExtVentaMovImpuesto PRIMARY KEY  CLUSTERED (ID, Impuesto)                
)
GO

/***************** CFDExternoVentaMovImpuesto *******************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.CFDExternoVentaMovImpuesto') AND TYPE = 'V') 
  DROP VIEW CFDExternoVentaMovImpuesto
GO
CREATE VIEW CFDExternoVentaMovImpuesto AS
SELECT
  REPLICATE('0',20-LEN(RTRIM(LTRIM(CONVERT(varchar,ID))))) + RTRIM(LTRIM(CONVERT(varchar,ID))) +
  REPLICATE('0',12) + 
  REPLICATE('0',7) +
  REPLICATE(' ',50)
  OrdenExportacion,   
  ID,
  Impuesto,
  ImpuestoClave,
  Tasa,
  Importe,
  CategoriaImpuesto
  FROM CFDExtVentaMovImpuesto
GO


--select
--  '  ' + name + ','
--  from sys.columns where object_id = object_id('CFDExtVentaMovImpuesto')

--select
--  REPLICATE(' ',8) + name + REPLICATE(CHAR(32),1) + 
--  dbo.fneDocObtenerTipoColumna(Name,'CFDVentaMovImpuesto') +
--  CASE WHEN dbo.fneDocObtenerTipoColumna(Name,'CFDVentaMovImpuesto') IN ('char','varchar') THEN '(' + CASE WHEN CONVERT(varchar,max_length) = '8000' THEN 'max' ELSE CONVERT(varchar,max_length) END + ')' + CASE WHEN Name = 'ID' THEN ' NOT NULL' ELSE ' NULL' END ELSE CASE WHEN Name = 'ID' THEN ' NOT NULL' ELSE ' NULL' END END + ','
--  from sys.columns where object_id = object_id('CFDVentaMovImpuesto')
