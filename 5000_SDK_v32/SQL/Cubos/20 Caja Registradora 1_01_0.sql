/* Cubo de caja registradora 20-11-2003 */  
EXEC spInsertarCubo  'CR','Caja Registradora','Cubo de Ventas de la Caja Registradora','Cubo_CR',0,1
GO 
EXEC spInsertarMedida 'CR','Operaciones','Operaciones','Operaciones','aggSum'
EXEC spInsertarMedida 'CR','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'CR','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'CR','Utilidad','Utilidad','Utilidad','aggSum'
GO
EXEC spInsertarFormula 'CR','PromXNota','PromXNota','[Measures].[Importe]/[Measures].[Operaciones]',1
GO
EXEC spInsertarDimension 'CR','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'CR','Semana','Año','Año','Año',1
GO
EXEC spInsertarDimension 'CR','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'CR','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'CR','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'CR','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'CR','Hora','Normal','Hora',1
EXEC spInsertarDimensionNivel  'CR','Hora','Hora','Hora','Hora',1
GO
EXEC spInsertarDimension 'CR','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'CR','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'CR','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'CR','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'CR','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'CR','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'CR','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'CR','Movimiento','Mov','Movimiento','Movimiento',1
EXEC spInsertarDimensionNivel  'CR','Movimiento','MovGrupo','Grupo','Grupo Movimiento',2
GO
EXEC spInsertarDimension 'CR','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'CR','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'CR','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'CR','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'CR','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'CR','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'CR','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'CR','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'CR','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'CR','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'CR','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'CR','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'CR','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'CR','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'CR','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
GO
EXEC spInsertarDimension 'CR','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
GO
EXEC spInsertarDimension 'CR','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
GO
EXEC spInsertarDimension 'CR','Articulo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
GO
EXEC spInsertarDimension 'CR','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
GO
EXEC spInsertarDimension 'CR','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'CR','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
/* CuboCR */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CR]'))
DROP VIEW Cubo_CR
GO
CREATE VIEW Cubo_CR
--//WITH ENCRYPTION
AS
SELECT
  cr.ID,
  'Sucursal'		= cr.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'			= cr.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'MovGrupo' 		= mc.Grupo ,				
  'Mov'				= cr.Mov ,
  'MovId'			= cr.MovID,
  cr.Moneda, 
  cr.TipoCambio,
  cr.Concepto,
  cr.Referencia,
  cr.Observaciones,
  cr.Proyecto,
  cr.FechaRegistro,
  cr.FechaEmision,
  cr.Estatus,
  cr.Situacion,
  cr.SituacionFecha,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, cr.FechaEmision) < 10 
					THEN '0' + CONVERT(CHAR(1),DATEPART(d, cr.FechaEmision))
					ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, cr.FechaEmision))) END ,
  'Hora' 		= CASE  DATEPART(hour, cr.FechaRegistro) 
				WHEN 0 THEN '01:00 - 01:59 HRS' 
				WHEN 1 THEN '01:00 - 01:59 HRS' 
				WHEN 2 THEN '02:00 - 02:59 HRS' 
				WHEN 3 THEN '03:00 - 03:59 HRS' 
				WHEN 4 THEN '04:00 - 04:59 HRS' 
				WHEN 5 THEN '05:00 - 05:59 HRS' 
				WHEN 6 THEN '06:00 - 06:59 HRS' 
				WHEN 7 THEN '07:00 - 07:59 HRS' 
				WHEN 8 THEN '08:00 - 08:59 HRS' 
				WHEN 9 THEN '09:00 - 09:59 HRS' 
				WHEN 10 THEN '10:00 - 10:59 HRS' 
				WHEN 11 THEN '11:00 - 11:59 HRS' 
				WHEN 12 THEN '12:00 - 12:59 HRS' 
				WHEN 13 THEN '13:00 - 13:59 HRS' 
				WHEN 14 THEN '14:00 - 14:59 HRS' 
				WHEN 15 THEN '15:00 - 15:59 HRS' 
				WHEN 16 THEN '16:00 - 16:59 HRS' 
				WHEN 17 THEN '17:00 - 17:59 HRS' 
				WHEN 18 THEN '18:00 - 18:59 HRS' 
				WHEN 19 THEN '19:00 - 19:59 HRS' 
				WHEN 20 THEN '20:00 - 20:59 HRS' 
				WHEN 21 THEN '21:00 - 21:59 HRS' 
				WHEN 22 THEN '22:00 - 22:59 HRS' 
				WHEN 23 THEN '23:00 - 23:59 HRS' 
				WHEN 24 THEN '24:00 - 24:59 HRS' END,
  'Articulo' 		= crv.Articulo, 
  'ArtNombre' 		= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  'Cantidad' 		= crv.Cantidad,
  'Importe' 		= crv.Importe 		* mt.Factor,
  'Utilidad' 		= crv.Importe 		* mt.Factor	* ISNULL(a.MargenMinimo,0),
  'Operaciones' 	= crv.Operaciones 

FROM 
  Cr 

LEFT OUTER JOIN Empresa 	e  	ON cr.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON cr.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN CrVenta 	crv 	ON cr.Id 	= crv.Id
LEFT OUTER JOIN Art 		a   	ON crv.Articulo 	= a.Articulo 
LEFT OUTER JOIN MovTipo 	mt 	ON cr.Mov  	= mt.Mov  
	   JOIN MovClave 	mc 	ON mc.Modulo 	= mt.Modulo 
					AND mc.Clave    = mt.Clave 
LEFT OUTER JOIN Tiempo	t  	ON cr.FechaEmision = t.Fecha

WHERE mt.Modulo = 'CR'
UNION
SELECT
  cr.ID,
  'Sucursal'		= cr.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= cr.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'MovGrupo' 		= mc.Grupo ,				
  'Mov'			= cr.Mov ,
  'MovId'		= cr.MovID,
  cr.Moneda, 
  cr.TipoCambio,
  cr.Concepto,
  cr.Referencia,
  cr.Observaciones,
  cr.Proyecto,
  cr.FechaRegistro,
  cr.FechaEmision,
  cr.Estatus,
  cr.Situacion,
  cr.SituacionFecha,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, cr.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, cr.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, cr.FechaEmision))) END ,
  'Hora' 		= CASE  DATEPART(hour, cr.FechaRegistro) 
				WHEN 0 THEN '01:00 - 01:59 HRS' 
				WHEN 1 THEN '01:00 - 01:59 HRS' 
				WHEN 2 THEN '02:00 - 02:59 HRS' 
				WHEN 3 THEN '03:00 - 03:59 HRS' 
				WHEN 4 THEN '04:00 - 04:59 HRS' 
				WHEN 5 THEN '05:00 - 05:59 HRS' 
				WHEN 6 THEN '06:00 - 06:59 HRS' 
				WHEN 7 THEN '07:00 - 07:59 HRS' 
				WHEN 8 THEN '08:00 - 08:59 HRS' 
				WHEN 9 THEN '09:00 - 09:59 HRS' 
				WHEN 10 THEN '10:00 - 10:59 HRS' 
				WHEN 11 THEN '11:00 - 11:59 HRS' 
				WHEN 12 THEN '12:00 - 12:59 HRS' 
				WHEN 13 THEN '13:00 - 13:59 HRS' 
				WHEN 14 THEN '14:00 - 14:59 HRS' 
				WHEN 15 THEN '15:00 - 15:59 HRS' 
				WHEN 16 THEN '16:00 - 16:59 HRS' 
				WHEN 17 THEN '17:00 - 17:59 HRS' 
				WHEN 18 THEN '18:00 - 18:59 HRS' 
				WHEN 19 THEN '19:00 - 19:59 HRS' 
				WHEN 20 THEN '20:00 - 20:59 HRS' 
				WHEN 21 THEN '21:00 - 21:59 HRS' 
				WHEN 22 THEN '22:00 - 22:59 HRS' 
				WHEN 23 THEN '23:00 - 23:59 HRS' 
				WHEN 24 THEN '24:00 - 24:59 HRS' END,
  'Articulo' 		= cr.Articulo, 
  'ArtNombre' 		= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  'Cantidad' 		= cr.Cantidad,
  'Importe' 		= cr.ImporteTotal	* mt.Factor,
  'Utilidad' 		= 0,
  'Operaciones' 	= 0 

FROM 
  VENTATCALC cr

LEFT OUTER JOIN Empresa 	e  	ON cr.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON cr.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Art 		a   	ON cr.Articulo 	= a.Articulo 
LEFT OUTER JOIN MovTipo 	mt 	ON cr.Mov  	= mt.Mov  
	   JOIN MovClave 	mc 	ON mc.Modulo 	= mt.Modulo 
					AND mc.Clave    = mt.Clave 
LEFT OUTER JOIN Tiempo	t  		ON cr.FechaEmision = t.Fecha

WHERE mt.Modulo = 'VTAS'
 	AND cr.Mov 	= 'Venta Perdida'

GO