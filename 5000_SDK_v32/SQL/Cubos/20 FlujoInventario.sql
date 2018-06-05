/*INV_FLUJO*/
EXEC spInsertarCubo 'INV_FLUJO','Flujo de Inventario','Cubo de Flujo de Inventario','Cubo_Inv_Flujo',0  , 0
GO
EXEC spInsertarMedida 'INV_FLUJO','Cargo','Cargo','Cargo','aggSum'
EXEC spInsertarMedida 'INV_FLUJO','Abono','Abono','Abono','aggSum'
EXEC spInsertarMedida 'INV_FLUJO','CargoU','Cargo Unidades','Cargo Unidades','aggSum'
EXEC spInsertarMedida 'INV_FLUJO','AbonoU','Abono Unidades','Abono Unidades','aggSum'
GO
EXEC spInsertarDimension 'INV_FLUJO','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Movimiento','Mov','Movimiento','Movimiento',2

GO
EXEC spInsertarDimension 'INV_FLUJO','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Aplica','Normal','Aplica',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Aplica','AplicaID','AplicaID','AplicaId',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Aplica','Aplica','Aplica','Aplica',2
GO
EXEC spInsertarDimension 'INV_FLUJO','Modulo','Normal','Modulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Modulo','Modulo','Modulo','Modulo',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Fecha','Tiempo','Fecha',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Fecha','Fecha','Fecha','Fecha',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Opcion','Normal','Opcion',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Opcion','Opcion','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel  'INV_FLUJO','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'INV_FLUJO','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'INV_FLUJO','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'INV_FLUJO','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Cliente','Cliente','Cliente','Cliente',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Cliente','ClienteNombre','Cliente Grupo','Cliente Nombre',2
GO
EXEC spInsertarDimension 'INV_FLUJO','Almacen','Normal','Almacen',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Almacen','AlmNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'INV_FLUJO','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Proveedor Categoria','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Proveedor Categoria','ProvCategoria','Proveedor Categoria','Proveedor Categoria',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Proveedor Familia','Normal','Proveedor Familia',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Proveedor Familia','ProvFamilia','Proveedor Familia','Proveedor Familia',1
GO
EXEC spInsertarDimension 'INV_FLUJO','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'INV_FLUJO','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',2
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_Inv_Flujo]'))
DROP VIEW Cubo_Inv_Flujo
GO
CREATE VIEW Cubo_Inv_Flujo 
--//WITH ENCRYPTION
AS
SELECT   
    'Sucursal'		= a.Sucursal,
    'SucursalNombre'	= s.Nombre,      
    'SucursalRegion'	= s.Region, 
    'Empresa'		= a.Empresa ,
    'EmpresaNombre' 	= e.Nombre , 
    'EmpresaGrupo'	= e.Grupo,
    a.Mov,    
    a.MovID,
    'Modulo'		=  CASE a.modulo WHEN 'INV' THEN 'Inventario'
				     	 WHEN 'COMS' THEN 'Compras'
				         WHEN 'VTAS' THEN 'Ventas' END,
    a.moneda,    
    a.Grupo,
    'Articulo'		= a.Cuenta, 
    'ArtNombre'		= ar.Descripcion1,
    'ArtFamilia'	= ar.Familia,
    'ArtCategoria'	= ar.Categoria,
    'ArtGrupo'		= ar.Grupo,
    'ArtLinea'		= ar.Linea,
    'ArtFabricante'	= ar.Fabricante,
    'Opcion'		= a.Subcuenta,
    a.Ejercicio,    
    a.Periodo,     
    a.Fecha, 
    a.Aplica,
    a.AplicaId,
    a.Cargo,                 
    a.Abono,                 
    a.CargoU,                                                
    a.AbonoU, 
    'Almacen'		= a.grupo,
    'AlmNombre'		= al.Nombre,
    'AlmGrupo'		= al.Grupo,
    'AlmCategoria'	= al.Categoria,
    'Proveedor'		= p.Proveedor,
    'ProvNombre'	= p.Nombre,  
    'ProvCategoria'	= p.Categoria,  
    'ProvFamilia'	= p.Familia,
    'Cliente'		= C.Cliente,
    'ClienteNombre'	= c.Nombre,
    'ClienteFamilia'	= c.Familia,
    'ClienteCategoria'	= c.Categoria,
    'ClienteGrupo'	= c.Grupo
FROM 
	Auxiliaru a
LEFT OUTER JOIN alm al		ON a.grupo 	= al.Almacen
LEFT OUTER JOIN sucursal s	ON a.sucursal 	= s.sucursal
LEFT OUTER JOIN empresa e	ON a.empresa 	= e.empresa
LEFT OUTER JOIN art ar		ON a.cuenta 	= ar.articulo
LEFT OUTER JOIN Compra com 	ON a.Mov 	 = com.Mov 
				AND a.MovID 	 = com.MovID
LEFT OUTER JOIN prov p		ON com.proveedor = p.Proveedor
LEFT OUTER JOIN venta v 	ON a.Mov 	= v.Mov 
				AND a.MovID 	= v.MovID
LEFT OUTER JOIN cte c		ON v.cliente    = c.cliente

WHERE a.rama='INV'
	AND a.modulo IN ('INV','COMS','VTAS')
GO