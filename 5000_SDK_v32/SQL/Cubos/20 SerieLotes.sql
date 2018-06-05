/* CuboSERIELOTES */
EXEC spInsertarCubo  'SL','Serie y Lote','Cubo de Serie y Lote','Cubo_SL',0,1
GO
EXEC spInsertarMedida 'SL','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'SL','CantidadAlterna','Cantidad Alterna','Cantidad Alterna','aggSum'
EXEC spInsertarMedida 'SL','Existencia','Existencia','Existencia','aggSum'
EXEC spInsertarMedida 'SL','ExistenciaAlterna','Existencia Alterna','ExistenciaAlterna','aggSum'
EXEC spInsertarMedida 'SL','ExistenciaActivoFijo','Existencia Activo Fijo','ExistenciaActivoFijo','aggSum'
EXEC spInsertarMedida 'SL','Costo','Costo','Costo','aggSum'		
EXEC spInsertarMedida 'SL','CostoInv','Costo Inv','Costo Inv','aggSum'
EXEC spInsertarMedida 'SL','CostoPromedio','Costo Promedio','Costo Promedio','aggSum'	
GO
EXEC spInsertarDimension 'SL','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'SL','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'SL','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'SL','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'SL','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'SL','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'SL','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'SL','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'SL','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimension 'SL','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimension 'SL','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimension 'SL','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'SL','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'SL','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
EXEC spInsertarDimensionNivel  'SL','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'SL','Cliente','Cliente','Cliente','Cliente',1
EXEC spInsertarDimensionNivel  'SL','Cliente','ClienteNombre','Cliente Nombre','Cliente Nombre',2
EXEC spInsertarDimension 'SL','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel 'SL','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO
EXEC spInsertarDimension 'SL','Almacen','Normal','Almacen',0
EXEC spInsertarDimensionNivel  'SL','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'SL','Almacen','AlmNombre','AlmNombre','AlmNombre',2
EXEC spInsertarDimensionNivel  'SL','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'SL','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimension 'SL','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimension 'SL','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimension 'SL','Articulo','Normal','Articulo',1
EXEC spInsertarDimension 'SL','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimension 'SL','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'SL','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
EXEC spInsertarDimensionNivel  'SL','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
EXEC spInsertarDimensionNivel  'SL','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
EXEC spInsertarDimensionNivel  'SL','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'SL','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
EXEC spInsertarDimensionNivel  'SL','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
EXEC spInsertarDimensionNivel  'SL','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'SL','Opcion','Normal','Opcion',1
EXEC spInsertarDimensionNivel  'SL','Opcion','OpcionNombre','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'SL','Modulo','Normal','Modulo',1
EXEC spInsertarDimensionNivel  'SL','Modulo','Modulo','Modulo','Modulo',1
GO
EXEC spInsertarDimension 'SL','Serie Lote','Normal','Serie Lote',1
EXEC spInsertarDimensionNivel  'SL','Serie Lote','SerieLote','Serie Lote','Serie Lote',1
GO
EXEC spInsertarDimension 'SL','Pedimento Clave','Normal','Pedimento Clave',1
EXEC spInsertarDimensionNivel  'SL','Pedimento Clave','PedimentoClave','Pedimento Clave','PedimentoClavee',1
GO
EXEC spInsertarDimension 'SL','Pedimento Regimen','Normal','Pedimento Regimen',1
EXEC spInsertarDimensionNivel  'SL','Pedimento Regimen','PedimentoRegimen','Pedimento Regimen','Pedimento Regimen',1
GO
EXEC spInsertarDimension 'SL','AgenteAduanal','Normal','AgenteAduanal',1
EXEC spInsertarDimensionNivel  'SL','AgenteAduanal','AgenteAduanal','AgenteAduanal','AgenteAduanal',1
GO
EXEC spInsertarDimension 'SL','Aduana','Normal','Aduana',1
EXEC spInsertarDimensionNivel  'SL','Aduana','Aduana','Aduana','Aduana',1
GO
EXEC spInsertarDimension 'SL','Antigüedad','Normal','Antigüedad',1
EXEC spInsertarDimensionNivel  'SL','Antigüedad','Antigüedad','Antigüedad','Antigüedad',1
GO
EXEC spInsertarDimension 'SL','Caducidad','Tiempo','Caducidad',1
EXEC spInsertarDimensionNivel  'SL','Caducidad','Caducidad','Caducidad','Caducidad',1
GO
EXEC spInsertarDimension 'SL','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'SL','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'SL','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'SL','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'SL','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'SL','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'SL','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'SL','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'SL','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'SL','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'SL','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'SL','Mes','Mes','Mes','Mes',1
GO

/* CuboSERIELOTES */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_SL]'))
DROP VIEW Cubo_SL
GO
CREATE VIEW Cubo_SL
--//WITH ENCRYPTION
AS
SELECT 
  'Sucursal' 		= sl.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= sl.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  sl.Modulo,
  'Articulo' 		= sl.Articulo, 
  'ArtNombre' 		= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  'Opcion' 		= sl.SubCuenta,
  'OpcionNombre'	= dbo.fnOpcion(sl.SubCuenta),
  sl.SerieLote,
  'Cliente' 		= sl.Cliente, 
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  Cantidad,
  CantidadAlterna,
  sl.Ubicacion,
  Localizacion,
  sl.Propiedades,
  slp.Extra1,
  slp.Extra2,
  slp.Extra3,
  'Caducidad'		= slp.Fecha1,
  slp.Fecha2,
  slp.Fecha3,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, slp.Fecha1) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, slp.Fecha1))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, slp.Fecha1))) END ,
  slp.PedimentoClave,
  slp.PedimentoRegimen,
  slp.ValorDolares,
  slp.ValorAduana,
  slp.ValorComercial,
  slp.AgenteAduanal,
  slp.Aduana,
  slp.DTA,
  slp.IVA,
  slp.IGI,
  'Almacen'		= NULL,
  'AlmNombre' 		= NULL,
  'AlmGrupo' 		= NULL,
  'AlmCategoria' 	= NULL,
  'Existencia'		= 0,
  'ExistenciaAlterna'	= 0,
  'ExistenciaActivoFijo'= 0,
  'UltimaEntrada'	= NULL,	
  'UltimaSalida'	= NULL,	
  'Costo'		= 0,
  'CostoInv'		= 0,
  'CostoPromedio'	= 0,
  'Dias'		= 0,
   'Antigüedad'		= null
FROM 
   SerieLoteMov sl

LEFT OUTER JOIN Empresa 	e  	ON sl.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON sl.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Art 		a   	ON sl.Articulo 	= a.Articulo 
LEFT OUTER JOIN Cte  		c     	ON sl.Cliente  	= c.Cliente
LEFT OUTER JOIN SerieLoteProp	slp    	ON sl.Propiedades= slp.Propiedades
LEFT OUTER JOIN Tiempo t 		ON YEAR(slp.Fecha1) = YEAR(t.Fecha)
						AND MONTH(slp.Fecha1) = MONTH(t.Fecha)
						AND DAY(slp.Fecha1) = DAY(t.Fecha)
UNION
SELECT 
  'Sucursal' 		= sl.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= sl.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  NULL,
  'Articulo' 		= sl.Articulo, 
  'ArtNombre' 		= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  'Opcion' 		= sl.SubCuenta,
  'OpcionNombre'	= dbo.fnOpcion(sl.SubCuenta),
  sl.SerieLote,
  'Cliente' 		= sl.Cliente, 
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  0,
  0,
  NULL,
  Localizacion,
  sl.Propiedades,
  slp.Extra1,
  slp.Extra2,
  slp.Extra3,
  slp.Fecha1,
  slp.Fecha2,
  slp.Fecha3,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, slp.Fecha1) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, slp.Fecha1))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, slp.Fecha1))) END ,
  slp.PedimentoClave,
  slp.PedimentoRegimen,
  slp.ValorDolares,
  slp.ValorAduana,
  slp.ValorComercial,
  slp.AgenteAduanal,
  slp.Aduana,
  slp.DTA,
  slp.IVA,
  slp.IGI,
  sl.Almacen,
  'AlmNombre' 		= al.Nombre,
  'AlmGrupo' 		= al.Grupo,
  'AlmCategoria' 	= al.Categoria,
  Existencia,
  ExistenciaAlterna,
  ExistenciaActivoFijo,
  UltimaEntrada,	
  UltimaSalida,	
  Costo,
  CostoInv,
  CostoPromedio,
  'Dias'		= CASE WHEN Existencia > 0 
				THEN DATEDIFF(day,UltimaEntrada,GETDATE())
				ELSE 0 END,
  'Antigüedad'	 	= CASE	WHEN DATEDIFF(day, slp.Fecha1, GETDATE())<= 0 
					THEN 'Corriente'  
				WHEN DATEDIFF(day, slp.Fecha1, GETDATE())>= 1	
				AND DATEDIFF(day, slp.Fecha1, GETDATE())<= 30 
					THEN ' 1 - 30'  
				WHEN DATEDIFF(day, slp.Fecha1, GETDATE())>= 31 
				AND DATEDIFF(day, slp.Fecha1, GETDATE())<= 60 
					THEN '31 - 60' 
				WHEN DATEDIFF(day, slp.Fecha1, GETDATE())>= 61 
				AND DATEDIFF(day, slp.Fecha1, GETDATE())<= 90 
					THEN '61 - 90' 
				WHEN DATEDIFF(day, slp.Fecha1, GETDATE())>= 91 
					THEN '+ 90'    END

FROM 
   SerieLote sl

LEFT OUTER JOIN Empresa 	e  	ON sl.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON sl.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Art 		a   	ON sl.Articulo 	= a.Articulo 
LEFT OUTER JOIN Cte  		c     	ON sl.Cliente  	= c.Cliente
LEFT OUTER JOIN SerieLoteProp	slp    	ON sl.Propiedades= slp.Propiedades
LEFT OUTER JOIN Alm 		al     	ON sl.Almacen  	= al.Almacen 
LEFT OUTER JOIN Tiempo t 		ON YEAR(slp.Fecha1) = YEAR(t.Fecha)
						AND MONTH(slp.Fecha1) = MONTH(t.Fecha)
						AND DAY(slp.Fecha1) = DAY(t.Fecha)

GO


