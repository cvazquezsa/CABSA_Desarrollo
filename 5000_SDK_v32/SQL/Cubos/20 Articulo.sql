/* cubo maestro de articulos con opciones */

EXEC spInsertarStore 'ART','spCuboArt',1
EXEC spInsertarCubo 'ART','Maestro de Articulos','Cubo de Maestro de Articulos','Cubo_ART',0,1
GO
EXEC spInsertarMedida 'ART','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'ART','NoArticulo','NoArticulo','NoArticulo','aggDistinctCount'
EXEC spInsertarMedida 'ART','PrecioLista','zEst1','PrecioLista','aggSum'
EXEC spInsertarMedida 'ART','CostoEstandar','zEst2','Costo','aggSum'
EXEC spInsertarMedida 'ART','CostoReposicion','zEst3','Costo','aggSum'
EXEC spInsertarMedida 'ART','UltimoCosto','zEst4','Costo','aggSum'
EXEC spInsertarMedida 'ART','CostoPromedio','zEst5','Costo','aggSum'
GO
EXEC spInsertarFormula 'ART','PrecioLista','PrecioLista','([Measures].[zEst1]/[Measures].[Cantidad])',1
EXEC spInsertarFormula 'ART','CostoEstandar','CostoEstandar','([Measures].[zEst2]/[Measures].[Cantidad])',3
EXEC spInsertarFormula 'ART','CostoReposicion','CostoReposicion','([Measures].[zEst3]/[Measures].[Cantidad])',4
EXEC spInsertarFormula 'ART','UltimoCosto','UltimoCosto','([Measures].[zEst4]/[Measures].[Cantidad])',5
EXEC spInsertarFormula 'ART','CostoPromedio','CostoPromedio','([Measures].[zEst5]/[Measures].[Cantidad])',6
EXEC spInsertarFormula 'ART','Utilidad','Utilidad','[Measures].[PrecioLista]-[Measures].[CostoPromedio]',7
EXEC spInsertarFormula 'ART','% Margen','% Margen','[Measures].[Utilidad]/[Measures].[PrecioLista]',8
GO
EXEC spInsertarDimension 'ART','Articulo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'ART','Articulo','Articulo','Articulo','Articulo',1
GO
EXEC spInsertarDimension 'ART','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel  'ART','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'ART','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'ART','Empresa','Empresa','Empresa','Empresa',1
GO
EXEC spInsertarDimension 'ART','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'ART','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'ART','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
GO
EXEC spInsertarDimension 'ART','Familia','Normal','Familia',1
EXEC spInsertarDimensionNivel  'ART','Familia','Familia','Familia','Familia',1
GO
EXEC spInsertarDimension 'ART','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel  'ART','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension 'ART','Linea','Normal','Linea',1
EXEC spInsertarDimensionNivel  'ART','Linea','Linea','Linea','Linea',1
GO
EXEC spInsertarDimension 'ART','Fabricante','Normal','Fabricante',1
EXEC spInsertarDimensionNivel  'ART','Fabricante','Fabricante','Fabricante','Fabricante',1
GO
EXEC spInsertarDimension 'ART','Descripcion','Normal','Descripcion',1
EXEC spInsertarDimensionNivel  'ART','Descripcion','Descripcion1','Descripcion','Descripcion',2
GO
EXEC spInsertarDimension 'ART','Rama','Normal','Rama',1
EXEC spInsertarDimensionNivel  'ART','Rama','Rama','Rama','Rama',1
GO
EXEC spInsertarDimension 'ART','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel  'ART','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'ART','Estatus Precio','Normal','EstatusPrecio',1
EXEC spInsertarDimensionNivel  'ART','Estatus Precio','EstatusPrecio','EstatusPrecio','EstatusPrecio',1
GO
EXEC spInsertarDimension 'ART','Unidad','Normal','Unidad',1
EXEC spInsertarDimensionNivel  'ART','Unidad','Unidad','Unidad','Unidad',1
GO
EXEC spInsertarDimension 'ART','Tipo Costeo','Normal','TipoCosteo',1
EXEC spInsertarDimensionNivel  'ART','Tipo Costeo','TipoCosteo','TipoCosteo','TipoCosteo',1
GO
EXEC spInsertarDimension 'ART','Clase','Normal','Clase',1
EXEC spInsertarDimensionNivel  'ART','Clase','Clase','Clase','Clase',1
GO
EXEC spInsertarDimension 'ART','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel  'ART','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension 'ART','ABC','Normal','ABC',1
EXEC spInsertarDimensionNivel  'ART','ABC','ABC','ABC','ABC',1
GO
EXEC spInsertarDimension 'ART','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'ART','Proveedor','Proveedor','Proveedor','Proveedor',1
GO
EXEC spInsertarDimension 'ART','Proveedor Nombre','Normal','Proveedor Nombre',1
EXEC spInsertarDimensionNivel  'ART','Proveedor Nombre','ProveedorNombre','Proveedor Nombre','Proveedor Nombre',1
GO
EXEC spInsertarDimension 'ART','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'ART','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'ART','ListaOpcion','Normal','ListaOpcion',1
EXEC spInsertarDimensionNivel  'ART','ListaOpcion','ListaOpcion','ListaOpcion','ListaOpcion',1
GO
EXEC spInsertarDimension 'ART','Opcion','Normal','Opcion',1
EXEC spInsertarDimensionNivel  'ART','Opcion','Opcion','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'ART','OpcionDesc','Normal','OpcionDesc',1
EXEC spInsertarDimensionNivel  'ART','OpcionDesc','DescripcionOpcion','OpcionDesc','OpcionDesc',1
GO
EXEC spInsertarDimension 'ART','Opcion Detalle','Normal','NombreOpcion',1
EXEC spInsertarDimensionNivel  'ART','Opcion Detalle','NombreOpcionD','Opcion Detalle','NombreOpcion',1
GO
EXEC spInsertarDimension 'ART','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'ART','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'ART','Lista Precio','Normal','Lista',1
EXEC spInsertarDimensionNivel  'ART','Lista Precio','Lista','Lista Precio','Lista precio',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_PRECART]'))
DROP VIEW Cubo_PRECART
GO
CREATE VIEW Cubo_PRECART
--//WITH ENCRYPTION
AS
	SELECT Articulo,'Precios' = 'Omision','Precio' = PrecioLista,Moneda = 'Pesos' FROM Art UNION
	SELECT Articulo,'Precios' = '02','Precio' = Precio2,'Pesos' FROM Art WHERE Precio2 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '03','Precio' = Precio3,'Pesos' FROM Art WHERE Precio3 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '04','Precio' = Precio4,'Pesos' FROM Art WHERE Precio4 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '05','Precio' = Precio5,'Pesos' FROM Art WHERE Precio5 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '06','Precio' = Precio6,'Pesos' FROM Art WHERE Precio6 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '07','Precio' = Precio7,'Pesos' FROM Art WHERE Precio7 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '08','Precio' = Precio8,'Pesos' FROM Art WHERE Precio8 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '09','Precio' = Precio9,'Pesos' FROM Art WHERE Precio9 IS NOT NULL UNION
	SELECT Articulo,'Precios' = '10','Precio' = Precio10,'Pesos' FROM Art WHERE Precio10 IS NOT NULL UNION
	SELECT Articulo,'Precios' = Lista,precio,MOneda FROM LISTAPRECIOSD

GO

/*Cubo de articulos por opciones */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_ART]'))
DROP VIEW Cubo_ART
GO
CREATE VIEW Cubo_ART
--//WITH ENCRYPTION
AS
SELECT 
	art.Articulo,
	'PrecioLista'		= pre.Precio,
	'Lista'			= pre.Precios,
	art.MargenMinimo,
	art.Categoria,
	art.Familia,
	art.Grupo,
	art.Linea,
	art.Fabricante,
	art.Descripcion1,
	art.Rama,
	art.Situacion,
	art.EstatusPrecio,
	art.Unidad,
	art.TipoCosteo,
	art.Clase,
	art.Tipo,
	art.ABC,
	'Sucursal'			= artcos.Sucursal,
	'SucursalNombre'	= s.Nombre,  
	'SucursalRegion' 	= s.Region, 
	'Empresa'			= artcos.Empresa,
	'EmpresaNombre'		= e.Nombre,  
	'EmpresaGrupo' 		= e.Grupo,
	art.Proveedor,
	'ProveedorNombre'	= prov.Nombre,
	art.Estatus,
	'ListaOpcion'		= artopc.ListaEspecifica,
	'DescripcionOpcion' = opc.Lista,
	'Opcion'			= artopc.Opcion,
	'Numero'			= opcd.Numero,
	'NombreOpcionD'		= CASE WHEN opcd.Numero < 10 
				THEN '0' + CONVERT(CHAR(1),opcd.Numero)
				ELSE RTRIM(CONVERT(CHAR(2),opcd.Numero)) END + '  ' + opcd.Nombre ,
	'Cantidad'			= 1,
	'CostoEstandar'		= art.CostoEstandar,
	'CostoReposicion'	= artcos.CostoReposicion,
	'UltimoCosto'		= artcos.UltimoCosto,
	'CostoPromedio'		= artcos.CostoPromedio,
	'Moneda'			= pre.Moneda,
	'NoArticulo'		= cart.Id
	
FROM Art 

LEFT OUTER JOIN ArtOpcion		artopc 	ON art.Articulo 	= artopc.Articulo
LEFT OUTER JOIN ArtCosto		artcos 	ON art.Articulo 	= artcos.Articulo
LEFT OUTER JOIN OpcionListaD	opc 	ON artopc.ListaEspecifica = opc.Lista
LEFT OUTER JOIN opciond			opcd 	ON opc.Opcion		= opcd.Opcion
			AND opc.Numero		= opcd.Numero
LEFT OUTER JOIN Empresa 		e  		ON artcos.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 		s 		ON artcos.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Prov			prov	ON art.Proveedor	= prov.Proveedor
LEFT OUTER JOIN Cubo_Artid		cart	ON art.Articulo		= cart.articulo
LEFT OUTER JOIN Cubo_PRECART	pre		ON art.Articulo		= pre.Articulo
GO	