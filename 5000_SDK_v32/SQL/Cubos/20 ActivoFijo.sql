/* CuboAFIJO */

EXEC spInsertarCubo 'AF','Activos Fijos','Cubo de Activo Fijo','Cubo_AF',0,1
GO
EXEC spInsertarMedida 'AF','AdquisicionValor','Valor Adquisicion','Valor Adquisicion','aggSum'
EXEC spInsertarMedida 'AF','MantenimientoAcum','Mantenimiento Acumulado','Mantenimiento Acumulado','aggSum'
EXEC spInsertarMedida 'AF','DepreciacionAcum','Depreciacion Acumulado','Depreciacion Acumulado','aggSum'
EXEC spInsertarMedida 'AF','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'AF','SeguroMonto','SeguroMonto','SeguroMonto','aggSum'
GO
EXEC spInsertarDimension 'AF','Serie','Normal','Serie',1
EXEC spInsertarDimensionNivel 'AF','Serie','Serie','Serie','Serie',1
GO
EXEC spInsertarDimension 'AF','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel 'AF','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'AF','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel 'AF','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'AF','Localizacion','Normal','Localizacion',1
EXEC spInsertarDimensionNivel 'AF','Localizacion','Localizacion','Localizacion','Localizacion',1
GO
EXEC spInsertarDimension 'AF','Observaciones','Normal','Observaciones',1
EXEC spInsertarDimensionNivel 'AF','Observaciones','Observaciones','Observaciones','Observaciones',1
GO
EXEC spInsertarDimension 'AF','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel 'AF','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'AF','Adquisicion Fecha','Tiempo','Fecha Adquisicion',1
EXEC spInsertarDimensionNivel 'AF','Adquisicion Fecha','AdquisicionFecha','Fecha Adquisicion','AdquisicionFecha',1
GO
EXEC spInsertarDimension 'AF','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel 'AF','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel 'AF','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel 'AF','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'AF','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel 'AF','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel 'AF','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
GO
EXEC spInsertarDimension 'AF','Almacen','Normal','Almacen',1
EXEC spInsertarDimensionNivel 'AF','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel 'AF','Almacen','AlmNombre','Almacen Nombre','AlmNombre',2
EXEC spInsertarDimensionNivel 'AF','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'AF','Articulo Familia','Normal','Articulo Familia',1
EXEC spInsertarDimensionNivel 'AF','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
GO
EXEC spInsertarDimension 'AF','Articulo Grupo','Normal','Articulo Grupo',1
EXEC spInsertarDimensionNivel 'AF','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
GO
EXEC spInsertarDimension 'AF','Articulo Categoria','Normal','Articulo Categoria',1
EXEC spInsertarDimensionNivel 'AF','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
GO
EXEC spInsertarDimension 'AF','Articulo','Normal','Articulo',1
EXEC spInsertarDimensionNivel 'AF','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel 'AF','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
GO
EXEC spInsertarDimension 'AF','Articulo Fabricante','Normal','Articulo Fabricante',1
EXEC spInsertarDimensionNivel 'AF','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
GO
EXEC spInsertarDimension 'AF','Articulo Linea','Normal','Articulo Linea',1
EXEC spInsertarDimensionNivel 'AF','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'AF','Aseguradora','Normal','Aseguradora',1
EXEC spInsertarDimensionNivel 'AF','Aseguradora','Aseguradora','Aseguradora','Aseguradora',1
GO
EXEC spInsertarDimension 'AF','SeguroInicio','Tiempo','SeguroInicio',1
EXEC spInsertarDimensionNivel 'AF','SeguroInicio','SeguroInicio','SeguroInicio','SeguroInicio',1
GO
EXEC spInsertarDimension 'AF','SeguroTipoPoliza','Normal','SeguroTipoPoliza',1
EXEC spInsertarDimensionNivel 'AF','SeguroTipoPoliza','SeguroTipoPoliza','SeguroTipoPoliza','SeguroTipoPoliza',1
GO
EXEC spInsertarDimension 'AF','Año','Normal','Año',1
EXEC spInsertarDimensionNivel 'AF','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'AF','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel 'AF','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'AF','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel 'AF','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'AF','DiaSemana','Normal','DiaSemana',1
EXEC spInsertarDimensionNivel 'AF','DiaSemana','DiaSemana','DiaSemana','DiaSemana',1
GO

/* CuboAFIJO */
IF  exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_AF]'))
DROP VIEW Cubo_AF
GO
CREATE VIEW Cubo_AF
--//WITH ENCRYPTION
AS
SELECT
  af.ID,
  'Sucursal' 		= af.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa' 		= af.Empresa,
  'EmpresaNombre'	= e.Nombre,  	
  'EmpresaGrupo' 	= e.Grupo,
  'Articulo' 		= af.Articulo, 
  'ArtNombre'	 	= a.Descripcion1,
  'ArtDescripcion' 	= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  af.Serie,
  af.Moneda,
  'almacen' 		= af.Almacen, 
  'almNombre' 		= al.Nombre,
  'AlmGrupo' 		= al.Grupo,
  'AlmCategoria' 	= al.Categoria,
  af.Categoria,
  af.Localizacion,
  af.UltimoCambio,
  af.AdquisicionValor,
  af.AdquisicionFecha,
  af.GarantiaVence,
  af.VidaUtil,
  af.Utilizacion,
  af.DepreciacionMeses,
  af.DepreciacionAcum,
  af.DepreciacionUltima,
  af.ValorRevaluado,
  af.RevaluacionUltima,
  af.Mantenimientos,
  af.MantenimientoUltimo,
  af.MantenimientoSiguiente,
  af.MantenimientoVence,
  af.MantenimientoAcum,
  af.MantenimientoHoras,
  af.MantenimientoPeriodicidad,
  af.Reparaciones,
  af.ReparacionAcum,
  af.ReparacionHoras,
  af.ReparacionUltima,
  af.SeguroVence,
  af.SeguroAcum,
   t.trimestre,
   t.Semana,
 'Año'			= t.anio,
 'Mes'			= t.MesNombre,
 'DiaSemana'		= t.DiaNombre,
 'Dia'			= CASE WHEN DATEPART(d, af.AdquisicionFecha) < 10 
				  THEN '0' + CONVERT(CHAR(1),DATEPART(d, af.AdquisicionFecha))
				  ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, af.AdquisicionFecha))) END ,
  af.Observaciones,
  af.Estatus,
  af.Aseguradora, 
  af.SeguroInicio,
  af.SeguroTipoPoliza,
  af.SeguroMonto,
  'Cantidad'		= 1
FROM    
  ACTIVOF af  

LEFT OUTER JOIN Empresa e 	ON af.Empresa = e.Empresa 
LEFT OUTER JOIN Sucursal s 	ON af.Sucursal = s.Sucursal 
LEFT OUTER JOIN Art a 		ON af.Articulo = a.Articulo 
LEFT OUTER JOIN Alm al 		ON af.Almacen = al.Almacen 
LEFT OUTER JOIN Tiempo t	ON af.AdquisicionFecha = t.fecha
GO