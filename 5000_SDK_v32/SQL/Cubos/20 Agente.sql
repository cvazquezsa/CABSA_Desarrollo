/* CuboAgent */
EXEC spInsertarCubo  'AGENT','Comisiones','Cubo de Comisiones','Cubo_AGENT',0,1
GO
EXEC spInsertarMedida 'AGENT','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'AGENT','Retencion','Retencion','Retencion','aggSum'
EXEC spInsertarMedida 'AGENT','Impuestos','Impuestos','Impuestos','aggSum'
GO
EXEC spInsertarDimension 'AGENT','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'AGENT','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'AGENT','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'AGENT','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'AGENT','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'AGENT','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'AGENT','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'AGENT','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'AGENT','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'AGENT','Movimiento','Mov','Movimiento','Movimiento',1
EXEC spInsertarDimensionNivel  'AGENT','Movimiento','MovGrupo','Grupo','Grupo Movimiento',2
GO
EXEC spInsertarDimension 'AGENT','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'AGENT','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'AGENT','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'AGENT','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'AGENT','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'AGENT','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'AGENT','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'AGENT','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'AGENT','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'AGENT','Estatus','Situacion','Situacion','Situacion',1
EXEC spInsertarDimensionNivel  'AGENT','Estatus','Estatus','Estatus','Estatus',2
GO
EXEC spInsertarDimension 'AGENT','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel  'AGENT','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel  'AGENT','Agente','AgenteNombre','Agente Nombre','Agente Nombre',2
GO
EXEC spInsertarDimension 'AGENT','Agente Grupo','Normal','Agente',1
EXEC spInsertarDimensionNivel  'AGENT','Agente Grupo','AgenteGrupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension 'AGENT','Agente Categoria','Normal','Agente Categoria',1
EXEC spInsertarDimensionNivel  'AGENT','Agente Categoria','AgenteCategoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'AGENT','Tipo Comision','Normal','TipoComision',1
EXEC spInsertarDimensionNivel  'AGENT','Tipo Comision','TipoComision','TipoComision','TipoComision',1
GO
EXEC spInsertarDimension 'AGENT','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'AGENT','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension 'AGENT','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'AGENT','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'AGENT','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'AGENT','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'AGENT','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'AGENT','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'AGENT','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'AGENT','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'AGENT','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
/* CuboAgent */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_AGENT]'))
DROP VIEW Cubo_AGENT
GO
CREATE VIEW Cubo_AGENT
--//WITH ENCRYPTION
AS
SELECT 
	'Sucursal' 			= a.Sucursal,
  	'SucursalNombre'	= s.Nombre,  
  	'SucursalRegion' 	= s.Region, 
  	'Empresa'			= a.Empresa,
  	'EmpresaNombre'		= e.Nombre,  
  	'EmpresaGrupo' 		= e.Grupo,
  	'MovGrupo' 			= mc.Grupo,
	a.Mov,
	a.MovId,
	a.FechaEmision,
	a.Concepto,
	a.Proyecto,
	a.Moneda,
	a.referencia,
	a.Observaciones,
	a.Estatus,
	a.Situacion,
  	'Agente' 			= a.Agente,
  	'AgenteNombre' 		= ag.Nombre,
  	'AgenteGrupo'		= ag.Grupo,
	'AgenteCategoria'	= ag.Categoria,	
	'TipoComision'		= ag.TipoComision,
 	'Importe' 			= CONVERT(money, a.Importe		* mt.Factor),
 	'Retencion' 		= CONVERT(money, a.Retencion	* mt.Factor),
 	'Impuestos' 		= CONVERT(money, a.Impuestos	* mt.Factor),
	a.Ejercicio,
	a.Periodo,
  	a.UEN,
  	'UENNombre'			= uen.Nombre,
    t.Anio,
  	t.Trimestre,
	t.Semana,
	'DiaSemana'			= t.DiaNombre,
	'Mes'				= t.MesNombre,
	'Dia'				= CASE WHEN DATEPART(d, a.FechaEmision) < 10 
							   THEN '0' + CONVERT(CHAR(1),DATEPART(d, a.FechaEmision))
							   ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, a.FechaEmision))) 
						  END 
FROM Agent a
LEFT OUTER JOIN Empresa e  	ON a.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal s 	ON a.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Agente ag  	ON a.Agente   	= ag.Agente
LEFT OUTER JOIN Tiempo	t  	ON dbo.fnFechaSinHora(a.FechaEmision) = t.Fecha
LEFT OUTER JOIN UEN uen	   	ON a.uen		= uen.uen	
LEFT OUTER JOIN MovTipo mt 	ON a.Mov  		= mt.Mov  
	   JOIN MovClave mc 	ON mc.Modulo 	= mt.Modulo AND mc.Clave    = mt.Clave 
WHERE 
	mt.Modulo = 'AGENT'
GO
