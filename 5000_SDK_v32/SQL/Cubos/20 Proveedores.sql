
/* CUBO  para Proveedores */

EXEC spLimpiarCubo 'PROV'
EXEC spInsertarCubo 'PROV','Maestro Proveedores','Cubo de Proveedores','CUBO_PROV',0,1
GO
EXEC spInsertarMedida  'PROV','NoProveedores','NoProveedores','NoProveedores','aggSum'
GO
EXEC spInsertarDimension   'PROV','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel    'PROV','Proveedor','Proveedor','Proveedor','Proveedor',1
GO
EXEC spInsertarDimension   'PROV','Rama','Normal','Rama',1
EXEC spInsertarDimensionNivel    'PROV','Rama','Rama','Rama','Rama',1
GO
EXEC spInsertarDimension   'PROV','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel    'PROV','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension   'PROV','Delegacion','Normal','Delegacion',1
EXEC spInsertarDimensionNivel    'PROV','Delegacion','Delegacion','Delegacion','Delegacion',1
GO
EXEC spInsertarDimension   'PROV','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel    'PROV','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension   'PROV','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel    'PROV','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension   'PROV','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel    'PROV','Estado','Estado','Estado','Estado',1
GO
EXEC spInsertarDimension   'PROV','Zona','Normal','Zona',1
EXEC spInsertarDimensionNivel    'PROV','Zona','Zona','Zona','Zona',1
GO
EXEC spInsertarDimension   'PROV','Pais','Normal','Pais',1
EXEC spInsertarDimensionNivel    'PROV','Pais','Pais','Pais','Pais',1
GO
EXEC spInsertarDimension   'PROV','CodigoPostal','Normal','CodigoPostal',1
EXEC spInsertarDimensionNivel    'PROV','CodigoPostal','CodigoPostal','CodigoPostal','CodigoPostal',1
GO
EXEC spInsertarDimension   'PROV','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel    'PROV','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension   'PROV','Familia','Normal','Familia',1
EXEC spInsertarDimensionNivel    'PROV','Familia','Familia','Familia','Familia',1
GO
EXEC spInsertarDimension   'PROV','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel    'PROV','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension   'PROV','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel    'PROV','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension   'PROV','CtaDinero','Normal','CtaDinero',1
EXEC spInsertarDimensionNivel    'PROV','CtaDinero','CtaDinero','CtaDinero','CtaDinero',1
GO
EXEC spInsertarDimension   'PROV','BeneficiarioNombre','Normal','BeneficiarioNombre',1
EXEC spInsertarDimensionNivel    'PROV','BeneficiarioNombre','BeneficiarioNombre','BeneficiarioNombre','BeneficiarioNombre',1
GO
EXEC spInsertarDimension   'PROV','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel    'PROV','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension   'PROV','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel    'PROV','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension   'PROV','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'PROV','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'PROV','ProvBancoSucursal','Normal','ProvBancoSucursal',1
EXEC spInsertarDimensionNivel    'PROV','ProvBancoSucursal','ProvBancoSucursal','ProvBancoSucursal','ProvBancoSucursal',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_PROV]'))
DROP VIEW Cubo_PROV
GO
CREATE VIEW Cubo_PROV
--//WITH ENCRYPTION
AS
SELECT 
	'NoProveedores'	= 1,
	Proveedor,
	Rama,
	Nombre,
	NombreCorto,
	Direccion,
	EntreCalles,
	Plano,
	Observaciones,
	Delegacion,
	Colonia,
	Poblacion,
	Estado,
	Zona,
	Ruta,
	Pais,
	CodigoPostal,
	Telefonos,
	Fax,
	PedirTono,
	DirInternet,
	Contacto1,
	Contacto2,
	Extencion1,
	Extencion2,
	eMail1,
	eMail2,
	RFC,
	CURP,
	Categoria,
	Familia,
	ZonaImpuesto,
	FormaEnvio,
	Descuento,
	Comprador,
	Proyecto,
	Condicion,
	CtaDinero,
	Almacen,
	DiaRevision1,
	DiaRevision2,
	HorarioRevision,
	DiaPago1,
	DiaPago2,
	HorarioPago,
	Beneficiario,
	BeneficiarioNombre,
	LeyendaCheque,
	Agente,
	Situacion,
	SituacionFecha,
	Clase,
	Estatus,
	UltimoCambio,
	Alta,
	Conciliar,
	Mensaje,
	Tipo,
	ProntoPago,
	DefMoneda,
	ProvBancoSucursal,
	ProvCuenta,
	TieneMovimientos,
	DescuentoRecargos,
	CompraAutoCargosTipo,
	CompraAutoCargos,
	Pagares,
	Aforo,
	MaximoAplicacionPagos,
	NivelAcceso,
	Idioma,
	ListaPreciosEsp,
	Contrasena,
	AutoEndoso,
	Cuenta,
	CuentaRetencion,
	FormaPago,
	wGastoSolicitud,
	ConLimiteAnticipos,
	LimiteAnticiposMN,
	ChecarLimite,
	eMailAuto,
	FiscalRegimen
FROM Prov
GO
