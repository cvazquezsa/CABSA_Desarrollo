
/* CUBO  maetsro de agentes */
EXEC spInsertarCubo 'MAGENTE','Maestro Agentes','Cubo de Agentes','CUBO_AGENTE',0,1
GO
EXEC spInsertarMedida  'MAGENTE','NoAgentes','NoAgentes','NoAgentes','aggSum'
GO
EXEC spInsertarDimension   'MAGENTE','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel    'MAGENTE','Agente','Agente','Agente','Agente',1
GO
EXEC spInsertarDimension   'MAGENTE','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel    'MAGENTE','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension   'MAGENTE','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel    'MAGENTE','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension   'MAGENTE','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel    'MAGENTE','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension   'MAGENTE','Zona','Normal','Zona',1
EXEC spInsertarDimensionNivel    'MAGENTE','Zona','Zona','Zona','Zona',1
GO
EXEC spInsertarDimension   'MAGENTE','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel    'MAGENTE','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension   'MAGENTE','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'MAGENTE','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'MAGENTE','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel    'MAGENTE','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension   'MAGENTE','BeneficiarioNombre','Normal','BeneficiarioNombre',1
EXEC spInsertarDimensionNivel    'MAGENTE','BeneficiarioNombre','BeneficiarioNombre','BeneficiarioNombre','BeneficiarioNombre',1
GO
EXEC spInsertarDimension   'MAGENTE','TipoComision','Normal','TipoComision',1
EXEC spInsertarDimensionNivel    'MAGENTE','TipoComision','TipoComision','TipoComision','TipoComision',1
GO
EXEC spInsertarDimension   'MAGENTE','Porcentaje','Normal','Porcentaje',1
EXEC spInsertarDimensionNivel    'MAGENTE','Porcentaje','Porcentaje','Porcentaje','Porcentaje',1
GO
EXEC spInsertarDimension   'MAGENTE','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel    'MAGENTE','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension   'MAGENTE','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel    'MAGENTE','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension   'MAGENTE','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel    'MAGENTE','Estado','Estado','Estado','Estado',1
GO
EXEC spInsertarDimension   'MAGENTE','Pais','Normal','Pais',1
EXEC spInsertarDimensionNivel    'MAGENTE','Pais','Pais','Pais','Pais',1
GO
EXEC spInsertarDimension   'MAGENTE','CodigoPostal','Normal','CodigoPostal',1
EXEC spInsertarDimensionNivel    'MAGENTE','CodigoPostal','CodigoPostal','CodigoPostal','CodigoPostal',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_AGENTE]'))
DROP VIEW Cubo_AGENTE
GO
CREATE VIEW Cubo_AGENTE
--//WITH ENCRYPTION
AS
SELECT 
	'NoAgentes' 	= 1,
	Agente,
	Nombre,
	Tipo,
	Moneda,
	Telefonos,
	Extencion,
	Categoria,
	Zona,
	Grupo,
	Estatus,
	UltimoCambio,
	Clase,
	Alta,
	Conciliar,
	Mensaje,
	BeneficiarioNombre,
	CostoHora,
	TipoComision,
	Porcentaje,
	Nomina,
	Personal,
	NominaMov,
	NominaConcepto,
	Direccion,
	Colonia,
	Poblacion,
	Estado,
	Pais,
	CodigoPostal,
	RFC,
	CURP,
	TieneMovimientos,
	NivelAcceso,
	SucursalEmpresa,
	Equipo,
	Cuota,
	ArticuloDef,
	Acreedor,
	eMail,
	eMailAuto,
	VentasCasa,
	Familia,
	Baja,
	ReportaA
FROM AGENTE
GO