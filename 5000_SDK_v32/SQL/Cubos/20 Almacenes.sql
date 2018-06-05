/* cubo maestro de almacenes */
EXEC spInsertarCubo 'ALM','Maestro Almacenes','Cubo de Almacenes','Cubo_ALM',0,1
GO
EXEC spInsertarMedida  'ALM','NoAlmacenes','NoAlmacenes','NoAlmacenes','aggSum'
GO
EXEC spInsertarDimension   'ALM','Almacen','Normal','Almacen',1
EXEC spInsertarDimensionNivel    'ALM','Almacen','Almacen','Almacen','Almacen',1
GO
EXEC spInsertarDimension   'ALM','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel    'ALM','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension   'ALM','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel    'ALM','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension   'ALM','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel    'ALM','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension   'ALM','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel    'ALM','Estado','Estado','Estado','Estado',1
GO
EXEC spInsertarDimension   'ALM','Pais','Normal','Pais',1
EXEC spInsertarDimensionNivel    'ALM','Pais','Pais','Pais','Pais',1
GO
EXEC spInsertarDimension   'ALM','CodigoPostal','Normal','CodigoPostal',1
EXEC spInsertarDimensionNivel    'ALM','CodigoPostal','CodigoPostal','CodigoPostal','CodigoPostal',1
GO
EXEC spInsertarDimension   'ALM','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel    'ALM','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension   'ALM','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel    'ALM','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension   'ALM','Delegacion','Normal','Delegacion',1
EXEC spInsertarDimensionNivel    'ALM','Delegacion','Delegacion','Delegacion','Delegacion',1
GO
EXEC spInsertarDimension   'ALM','Zona','Normal','Zona',1
EXEC spInsertarDimensionNivel    'ALM','Zona','Zona','Zona','Zona',1
GO
EXEC spInsertarDimension   'ALM','Ruta','Normal','Ruta',1
EXEC spInsertarDimensionNivel    'ALM','Ruta','Ruta','Ruta','Ruta',1
GO
EXEC spInsertarDimension   'ALM','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel    'ALM','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension   'ALM','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'ALM','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'ALM','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel    'ALM','Sucursal','Sucursal','Sucursal','Sucursal',1
GO
EXEC spInsertarDimension   'ALM','SucursalRef','Normal','SucursalRef',1
EXEC spInsertarDimensionNivel    'ALM','SucursalRef','SucursalRef','SucursalRef','SucursalRef',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_Alm]'))
DROP VIEW Cubo_Alm
GO
CREATE VIEW Cubo_Alm
--//WITH ENCRYPTION
AS
SELECT
	'NoAlmacenes'		 = 1,
	Almacen,
	Nombre,
	Colonia,
	Poblacion,
	Estado,
	Pais,
	CodigoPostal,
	Grupo,
	Categoria,
	Delegacion,
	Zona,
	Ruta,
	Tipo,
	Sucursal,
	Estatus,
	SucursalRef
FROM ALM
GO