/* Cubo de clientes */
EXEC spLimpiarCubo 'CTE'
EXEC spInsertarCubo 'CTE','Maestro Clientes','Cubo de Clientes','Cubo_CTE',0,1
GO
EXEC spInsertarMedida  'CTE','NoCliente','NoCliente','NoClientes','aggSum'
GO
EXEC spInsertarDimension   'CTE','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel    'CTE','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension   'CTE','Rama','Normal','Rama',1
EXEC spInsertarDimensionNivel    'CTE','Rama','Rama','Rama','Rama',1
GO
EXEC spInsertarDimension   'CTE','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel    'CTE','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension   'CTE','Delegacion','Normal','Delegacion',1
EXEC spInsertarDimensionNivel    'CTE','Delegacion','Delegacion','Delegacion','Delegacion',1
GO
EXEC spInsertarDimension   'CTE','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel    'CTE','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension   'CTE','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel    'CTE','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension   'CTE','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel    'CTE','Estado','Estado','Estado','Estado',1
GO
EXEC spInsertarDimension   'CTE','Pais','Normal','Pais',1
EXEC spInsertarDimensionNivel    'CTE','Pais','Pais','Pais','Pais',1
GO
EXEC spInsertarDimension   'CTE','Zona','Normal','Zona',1
EXEC spInsertarDimensionNivel    'CTE','Zona','Zona','Zona','Zona',1
GO
EXEC spInsertarDimension   'CTE','CodigoPostal','Normal','CodigoPostal',1
EXEC spInsertarDimensionNivel    'CTE','CodigoPostal','CodigoPostal','CodigoPostal','CodigoPostal',1
GO
EXEC spInsertarDimension   'CTE','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel    'CTE','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension   'CTE','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel    'CTE','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension   'CTE','Familia','Normal','Familia',1
EXEC spInsertarDimensionNivel    'CTE','Familia','Familia','Familia','Familia',1
GO
EXEC spInsertarDimension   'CTE','Credito','Normal','Credito',1
EXEC spInsertarDimensionNivel    'CTE','Credito','Credito','Credito','Credito',1
GO
EXEC spInsertarDimension   'CTE','ZonaImpuesto','Normal','ZonaImpuesto',1
EXEC spInsertarDimensionNivel    'CTE','ZonaImpuesto','ZonaImpuesto','ZonaImpuesto','ZonaImpuesto',1
GO
EXEC spInsertarDimension   'CTE','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel    'CTE','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension   'CTE','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel    'CTE','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension   'CTE','SituacionFecha','Normal','SituacionFecha',1
EXEC spInsertarDimensionNivel    'CTE','SituacionFecha','SituacionFecha','SituacionFecha','SituacionFecha',1
GO
/*	Se le agrego la dimensión AgenteNombre		*Víctor Gutiérrez Méndez*/
EXEC spInsertarDimension   'CTE','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel    'CTE','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel    'CTE','Agente','AgenteNombre','AgenteNombre','AgenteNombre',2
GO
EXEC spInsertarDimension   'CTE','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel    'CTE','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension   'CTE','FormaEnvio','Normal','FormaEnvio',1
EXEC spInsertarDimensionNivel    'CTE','FormaEnvio','FormaEnvio','FormaEnvio','FormaEnvio',1
GO
EXEC spInsertarDimension   'CTE','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel    'CTE','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension   'CTE','ListaPreciosEsp','Normal','ListaPreciosEsp',1
EXEC spInsertarDimensionNivel    'CTE','ListaPreciosEsp','ListaPreciosEsp','ListaPreciosEsp','ListaPreciosEsp',1
GO
EXEC spInsertarDimension   'CTE','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel    'CTE','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension   'CTE','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'CTE','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'CTE','Alta','Tiempo','Alta',1
EXEC spInsertarDimensionNivel    'CTE','Alta','Alta','Alta','Alta',1
GO
EXEC spInsertarDimension   'CTE','CreditoLimite','Normal','CreditoLimite',1
EXEC spInsertarDimensionNivel    'CTE','CreditoLimite','CreditoLimite','CreditoLimite','CreditoLimite',1
GO
EXEC spInsertarDimension   'CTE','Cobrador','Normal','Cobrador',1
EXEC spInsertarDimensionNivel    'CTE','Cobrador','Cobrador','Cobrador','Cobrador',1
GO
/*	Se le agregaron las dimensiones Fuente, Año, Mes, PST y AgenteGrupo		*Víctor Gutiérrez Méndez*/
EXEC spInsertarDimension   'CTE','Fuente','Normal','Fuente',1
EXEC spInsertarDimensionNivel    'CTE','Fuente','Fuente','Fuente','Fuente',1
GO
EXEC spInsertarDimension   'CTE','Año','Normal','Año',1
EXEC spInsertarDimensionNivel    'CTE','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension   'CTE','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel    'CTE','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension   'CTE','PST','Normal','PST',1
EXEC spInsertarDimensionNivel    'CTE','PST','PST','PST','PST',1
GO
EXEC spInsertarDimension   'CTE','AgenteGrupo','Normal','AgenteGrupo',1
EXEC spInsertarDimensionNivel    'CTE','AgenteGrupo','AgenteGrupo','AgenteGrupo','AgenteGrupo',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CTE]'))
DROP VIEW Cubo_CTE
GO
CREATE VIEW Cubo_CTE
--//WITH ENCRYPTION
AS
SELECT 
	'NoCliente'	= 1,
	CTE.Cliente,
	CTE.Rama,
	CTE.Nombre,
	CTE.NombreCorto,
	CTE.Direccion,
	CTE.EntreCalles,
	CTE.Plano,
	CTE.Observaciones,
	CTE.Delegacion,
	CTE.Colonia,
	CTE.Poblacion,
	CTE.Estado,
	CTE.Pais,
	CTE.Zona,
	CTE.CodigoPostal,
	CTE.RFC,
	CTE.CURP,
	CTE.Telefonos,
	CTE.Fax,
	CTE.PedirTono,
	CTE.Contacto1,
	CTE.Contacto2,
	CTE.Extencion1,
	CTE.Extencion2,
	CTE.eMail1,
	CTE.eMail2,
	CTE.DirInternet,
	CTE.Categoria,
	CTE.Grupo,
	CTE.Familia,
	CTE.Credito,
	DiaRevision1,
	DiaRevision2,
	HorarioRevision,
	DiaPago1,
	DiaPago2,
	HorarioPago,
	ZonaImpuesto,
	PedidosParciales,
	CTE.Tipo,
	Situacion,
	SituacionFecha,
	Descuento,
	CTE.Agente,
	'AgenteNombre'	= agente.Nombre,
	CTE.Agente3,
	'Fuente'		= agente3.Nombre,
	AgenteServicio,
	EnviarA,
	Proyecto,
	FormaEnvio,
	Condicion,
	Ruta,
	ListaPrecios,
	ListaPreciosEsp,
	DefMoneda,
	VtasConsignacion,
	AlmacenVtasConsignacion,
	CTE.Clase,
	CTE.Estatus,
	CTE.UltimoCambio,
	CTE.Alta,
	'Año'		= YEAR(CTE.Alta),
	'Mes'		= CASE MONTH(CTE.Alta)
				WHEN 1		THEN '01 Enero'
				WHEN 2		THEN '02 Febrero'
				WHEN 3		THEN '03 Marzo'
				WHEN 4		THEN '04 Abril'
				WHEN 5		THEN '05 Mayo'
				WHEN 6		THEN '06 Junio'
				WHEN 7		THEN '07 Julio'
				WHEN 8		THEN '08 Agosto'
				WHEN 9		THEN '09 Septiembre'
				WHEN 10		THEN '10 Octubre'
				WHEN 11		THEN '11 Noviembre'
				WHEN 12		THEN '12 Diciembre'
			END,
	CTE.Conciliar,
	CTE.Mensaje,
	Numero,
	Contrasena,
	Contrasena2,
	wVerDisponible,
	wVerArtListaPreciosEsp,
	ChecarCredito,
	BloquearMorosos,
	ModificarVencimiento,
	CreditoEspecial,
	CreditoConLimite,
	CreditoLimite,
	CreditoConLimitePedidos,
	CreditoLimitePedidos,
	CreditoMoneda,
	CreditoConDias,
	CreditoDias,
	CreditoConCondiciones,
	CreditoCondiciones,
	CTE.TieneMovimientos,
	Cobrador,
	PersonalCobrador,
	DescuentoRecargos,
	RecorrerVencimiento,
	CTE.AlmacenDef,
	CTE.SucursalEmpresa,
	CTE.NivelAcceso,
	Idioma,
	BonificacionTipo,
	Bonificacion,
	VigenciaDesde,
	VigenciaHasta,
	Descripcion1,
	Descripcion2,
	Descripcion3,
	Descripcion4,
	Descripcion5,
	Descripcion6,
	Descripcion7,
	Descripcion8,
	Descripcion9,
	Descripcion10,
	Descripcion11,
	Descripcion12,
	Descripcion13,
	Descripcion14,
	Descripcion15,
	Descripcion16,
	Descripcion17,
	Descripcion18,
	Descripcion19,
	Descripcion20,
	FormasPagoRestringidas,
	PreciosInferioresMinimo,
	CBDir,
	PersonalNombres,
	PersonalApellidoPaterno,
	PersonalApellidoMaterno,
	PersonalDireccion,
	PersonalEntreCalles,
	PersonalPlano,
	PersonalDelegacion,
	PersonalColonia,
	PersonalPoblacion,
	PersonalEstado,
	PersonalPais,
	PersonalZona,
	PersonalCodigoPostal,
	PersonalTelefonos,
	PersonalTelefonoMovil,
	FechaNacimiento,
	Titulo,
	EstadoCivil,
	FechaMatrimonio,
	Conyuge,
	Sexo,
	Fuma,
	Profesion,
	Puesto,
	NumeroHijos,
	Alergias,
	Religion,
	Responsable,
	Parentesco,
	FacturarCte,
	FacturarCteEnviarA,
	Aseguradora,
	NombreAsegurado,
	PolizaTipo,
	PolizaNumero,
	PolizaReferencia,
	PolizaImporte,
	Deducible,
	DeducibleMoneda,
	Coaseguro,
	Espacio,
	OtrosCargos,
	Flotilla,
	FordDistribuidor,
	FordZona,
	---SinISAN,
	CRMImporte,
	CRMCantidad,
	CRMEtapa,
	CRMCierreProbabilidad,
	CRMCierreFechaAprox,
	CRMPresupuestoAsignado,
	CRMCompetencia,
	CRMInfluencia,
	CRMFuente,
	Fecha1,
	Fecha2,
	Fecha3,
	Fecha4,
	Fecha5,
	EsProveedor,
	EsPersonal,
	EsAgente,
	EsAlmacen,
	EsEspacio,
	EsCentroCostos,
	EsProyecto,
	EsCentroTrabajo,
	EsEstacionTrabajo,
	Usuario,
	Licencias,
	LicenciasTipo,
	LicenciasLlave,
	Cuenta,
	CuentaRetencion,
	FiscalRegimen,
	ExcentoISAN,
	PedidoDef,
	CTE.eMailAuto,
	RutaOrden,
	CTE.DireccionNumero,
	TelefonosLada,
	PersonalTelefonosLada,
	IEPS,
	wMovVentas,
	PITEX,
	'PST'	= CASE CTE.Rama
				WHEN '04-01-01'	THEN 'PST'
				WHEN '04-01-02'	THEN 'PST'
				WHEN '04-01-03'	THEN 'PST'
				ELSE 'VACIAS' END,
	'AgenteGrupo' 	= Agente.Grupo
FROM CTE
	LEFT OUTER JOIN Agente  ON  agente.Agente = cte.agente
	LEFT OUTER JOIN Agente Agente3 ON  agente3.Agente = cte.agente3
GO