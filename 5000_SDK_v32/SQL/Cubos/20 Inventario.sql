/*INV*/
EXEC spInsertarStore 'INV','spReconstruirArtR',1
EXEC spInsertarCubo 'INV','Inventario','Cubo de Inventario','Cubo_INV',0,1
GO
EXEC spInsertarMedida 'INV','Minimo','Minimo','Minimo'
EXEC spInsertarMedida 'INV','Maximo','Maximo','Maximo'
EXEC spInsertarMedida 'INV','PuntoOrden','Punto Orden','PuntoOrden'
EXEC spInsertarMedida 'INV','PuntoOrdenOrdenar','Punto Orden Ordenar','PuntoOrdenOrdenar'
EXEC spInsertarMedida 'INV','CantidadOrdenada','Cantidad Ordenada','Cantidad Ordenada'
EXEC spInsertarMedida 'INV','CompraPendiente','Compra Pendiente','Compra Pendiente'
EXEC spInsertarMedida 'INV','VentaPendiente','Venta Pendiente','Venta Pendiente'
EXEC spInsertarMedida 'INV','VentaRemisionada','Venta Remisionada','Venta Remisionada'
EXEC spInsertarMedida 'INV','ProdPendiente','Prod Pendiente','Prod Pendiente'
EXEC spInsertarMedida 'INV','InvPendiente','Inv Pendiente','Inv Pendiente'
EXEC spInsertarMedida 'INV','EnTransito','En Transito','En Transito'
EXEC spInsertarMedida 'INV','UltimoCosto','Ultimo Costo','Ultimo Costo'
EXEC spInsertarMedida 'INV','CostoPromedio','Costo Promedio','CostoPromedio'
EXEC spInsertarMedida 'INV','Disponible','Disponible','Disponible'
EXEC spInsertarMedida 'INV','UltimoCostoSinGastos','UltimoCostoSinGastos','UltimoCostoSinGastos'
EXEC spInsertarMedida 'INV','CostoEstandar','CostoEstandar','CostoEstandar'
EXEC spInsertarMedida 'INV','CostoReposicion','CostoReposicion','CostoReposicion'
EXEC spInsertarMedida 'INV','ValorInventario','ValorInventario','ValorInventario'
GO
EXEC spInsertarDimension 'INV','Empresa','Normal','Empresa',1
EXEC spInsertarDimension 'INV','Localizacion','Normal','Localizacion',1
EXEC spInsertarDimension 'INV','Almacen','Normal','Almacen',1
EXEC spInsertarDimension 'INV','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimension 'INV','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimension 'INV','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimension 'INV','Articulo','Normal','Articulo',1
EXEC spInsertarDimension 'INV','Articulo SubCuenta','Normal','SubCuenta',1
EXEC spInsertarDimension 'INV','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimension 'INV','Articulo Linea','Normal','Articulo',1
GO
EXEC spInsertarDimensionNivel  'INV','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'INV','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',1
EXEC spInsertarDimensionNivel  'INV','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimensionNivel  'INV','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'INV','Almacen','AlmNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'INV','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimensionNivel  'INV','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
EXEC spInsertarDimensionNivel  'INV','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
EXEC spInsertarDimensionNivel  'INV','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
EXEC spInsertarDimensionNivel  'INV','Articulo SubCuenta','SubCuenta','SubCuenta','SubCuenta',1
EXEC spInsertarDimensionNivel  'INV','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'INV','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
EXEC spInsertarDimensionNivel  'INV','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
EXEC spInsertarDimensionNivel  'INV','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimensionNivel  'INV','Localizacion','Localizacion','Localizacion','Localizacion',1
GO
EXEC spInsertarDimension 'INV','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'INV','Estatus','Estatus','Estatus','Estatus',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_INV]'))
DROP VIEW Cubo_INV
GO
CREATE VIEW Cubo_INV
--//WITH ENCRYPTION
AS
SELECT   
    'Empresa'		= a.Empresa ,
    'EmpresaNombre' 	= e.Nombre , 
    'EmpresaGrupo'	= e.Grupo,
    'Articulo'		= a.Articulo, 
    'ArtNombre'		= ar.Descripcion1,
    'ArtFamilia'	= ar.Familia,
    'ArtCategoria'	= ar.Categoria,
    'ArtGrupo'		= ar.Grupo,
    'ArtLinea'		= ar.Linea,
    'ArtFabricante'	= ar.Fabricante,
    'Estatus'		= ar.Estatus,
    a.Subcuenta,
    a.Localizacion,
    'Almacen'		= a.Almacen,
    'AlmNombre'		= al.Nombre,
    'AlmGrupo'		= al.Grupo,
    'AlmCategoria'	= al.Categoria,
    'Minimo'		= ISNULL(Minimo,0),
    'Maximo'		= ISNULL(Maximo,0),
    'PuntoOrden'	= ISNULL(PuntoOrden,0),
    'PuntoOrdenOrdenar'	= ISNULL(PuntoOrdenOrdenar,0),
    'INV'		= ISNULL(INV,0),
    'CSG'		= ISNULL(CSG,0),
    'RESV'		= ISNULL(RESV,0),
    'VMOS'		= ISNULL(VMOS,0),
    'GAR'		= ISNULL(GAR,0),
    'AF'		= ISNULL(AF,0),
    'PZA'		= ISNULL(PZA,0),
    'CantidadOrdenada'	= ISNULL(CantidadOrdenada,0),
    'CompraPendiente'	= ISNULL(CompraPendiente,0),
    'VentaPendiente'	= ISNULL(VentaPendiente,0),
    'VentaRemisionada'	= ISNULL(VentaRemisionada,0),
    'ProdPendiente'	= ISNULL(ProdPendiente,0),
    'InvPendiente'	= ISNULL(InvPendiente,0),
    'EnTransito'	= ISNULL(EnTransito,0),
    'Disponible'	= ISNULL(ad.Disponible,0),  
    'UltimoCosto'	= ISNULL(ac.UltimoCosto,0),
    'CostoPromedio'	= ISNULL(ac.CostoPromedio,0) * m.Tipocambio,    
    'UltimoCostoSinGastos'= ISNULL(ac.UltimoCostoSinGastos,0) * m.Tipocambio,    
    'CostoEstandar'	= ISNULL(ac.CostoEstandar,0) * m.Tipocambio,    
    'CostoReposicion'	= ISNULL(ac.CostoReposicion,0) * m.Tipocambio,    
    'InventarioCero'	= CASE WHEN ISNULL(ad.Disponible,0) = 0
				THEN 'SI'
				ELSE 'NO' END,
    'Nolocalizacion'	= CASE WHEN ISNULL(ad.Disponible,0) = 0
				THEN 'SI'
				ELSE 'NO' END,

    'ValorInventario'	= ad.Disponible * ac.CostoPromedio * m.TipoCambio
FROM 
	ArtR a
LEFT OUTER JOIN Empresa     e 	ON a.Empresa 	= e.Empresa 
LEFT OUTER JOIN Art         ar	ON a.Articulo 	= ar.Articulo 
LEFT OUTER JOIN Mon       m 	ON ar.MonedaCosto = m.Moneda 
LEFT OUTER JOIN Alm         al	ON a.Almacen 	= al.Almacen 
LEFT OUTER JOIN ArtDisponible ad ON a.Articulo 	= ad.Articulo 
				AND a.Empresa 	= ad.Empresa 
				AND a.Almacen 	= ad.Almacen 
LEFT OUTER JOIN ArtCosto ac 	ON a.Articulo 	= ac.Articulo 
				AND a.Empresa 	= ac.Empresa
				AND ac.Sucursal = 0
GO



