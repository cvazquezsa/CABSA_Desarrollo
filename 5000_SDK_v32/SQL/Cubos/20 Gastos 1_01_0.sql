/*GAS*/  
-- 1.0.1 04-11-2003 Se agrego la dimension de Acreeddor Referencia (acreedor detalle)
-- 1.0.2 06-11-2003 Se agrego la medida de presupuesto
-- 1.0.3 23-01-2004 El centro de costos es a nivel detalle

/* Cubo modificado el 15-05-2007 No se presentaban todos los conceptos y no cuadraba el original	Víctor Gutiérrez Méndez */

EXEC spLimpiarCubo 'GAS'
EXEC spInsertarCubo 'GAS','Gastos','Cubo de Gastos','Cubo_GAS',0,1
GO
EXEC spInsertarMedida 'GAS','ImporteTotal','ImporteTotal','ImporteTotal','aggSum'
EXEC spInsertarMedida 'GAS','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'GAS','ImporteEnPesos','Importe en Pesos','ImporteEnPesos','aggSum'
EXEC spInsertarMedida 'GAS','Retencion','Retencion','Retencion','aggSum'
EXEC spInsertarMedida 'GAS','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'GAS','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'GAS','Presupuesto','Presupuesto','Presupuesto','aggSum'
GO
EXEC spInsertarFormula 'GAS','Objetivo','Objetivo','([Measures].[ImporteTotal],[Gasto].[Real])/([Measures].[Importe],[Gasto].[Presupuestos])',1
GO
EXEC spInsertarDimension 'GAS','Centro Costos','Normal','Centro Costos',1
EXEC spInsertarDimensionNivel  'GAS','Centro Costos','ContUso','Centro Costos','Centro Costos',1
EXEC spInsertarDimensionNivel  'GAS','Centro Costos','Descripcion','Descripcion','Descripcion',2
EXEC spInsertarDimensionNivel  'GAS','Centro Costos','Rama','Rama','Rama',3
GO
EXEC spInsertarDimension 'GAS','Observaciones','Normal','Observaciones',0
EXEC spInsertarDimensionNivel  'GAS','Observaciones','Observaciones','Observaciones','Observaciones',1
GO
EXEC spInsertarDimension 'GAS','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'GAS','Movimiento','MovID','MovId','MovId',1
EXEC spInsertarDimensionNivel  'GAS','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel  'GAS','Movimiento','MovGrupo','Grupo Movimiento','Grupo Movimiento',3
GO
EXEC spInsertarDimension 'GAS','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'GAS','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'GAS','Concepto Actividad','Normal','Concepto Actividad',1
EXEC spInsertarDimensionNivel  'GAS','Concepto Actividad','ConceptoActividad','Concepto Actividad','Concepto Actividad',1
GO
EXEC spInsertarDimension 'GAS','Concepto Clase','Normal','ConceptoClase',1
EXEC spInsertarDimensionNivel  'GAS','Concepto Clase','ConceptoClase','ConceptoClase','ConceptoClase',1
EXEC spInsertarDimensionNivel  'GAS','Concepto Clase','ConceptoSubClase','ConceptoSubClase','ConceptoSubClase',2
GO
EXEC spInsertarDimension 'GAS','Concepto Tipo','Normal','ConceptoTipo',1
EXEC spInsertarDimensionNivel  'GAS','Concepto Tipo','ConceptoTipo','Concepto Tipo','ConceptoTipo',1
GO
EXEC spInsertarDimension 'GAS','Porcentaje Deducible','Normal','PorcentajeDeducible',1
EXEC spInsertarDimensionNivel  'GAS','Porcentaje Deducible','PorcentajeDeducible','Porcentaje Deducible','PorcentajeDeducible',1
GO
EXEC spInsertarDimension 'GAS','Deducible','Normal','Deducible',1
EXEC spInsertarDimensionNivel  'GAS','Deducible','Impuestos','Deducible','Deducible',1
GO
EXEC spInsertarDimension 'GAS','RetencionISR','Normal','RetencionISR',1
EXEC spInsertarDimensionNivel  'GAS','RetencionISR','RetencionISR','RetencionISR','RetencionISR',1
GO
EXEC spInsertarDimension 'GAS','RetencionIVA','Normal','RetencionIVA',1
EXEC spInsertarDimensionNivel  'GAS','RetencionIVA','RetencionIVA','RetencionIVA','RetencionIVA',1
GO
EXEC spInsertarDimension 'GAS','ConceptoIndirecto','Normal','ConceptoIndirecto',1
EXEC spInsertarDimensionNivel  'GAS','ConceptoIndirecto','ConceptoIndirecto','ConceptoIndirecto','ConceptoIndirecto',1
GO
EXEC spInsertarDimension 'GAS','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'GAS','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'GAS','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'GAS','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'GAS','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'GAS','Estatus','Estatus','Estatus','Estatus',1
EXEC spInsertarDimensionNivel  'GAS','Estatus','Situacion','Situacion','Situacion',2
GO
EXEC spInsertarDimension 'GAS','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'GAS','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'GAS','Fecha Requerida','Tiempo','Fecha Requerida',1
EXEC spInsertarDimensionNivel  'GAS','Fecha Requerida','FechaRequerida','Fecha Requerida','FechaRequerida',1
GO
EXEC spInsertarDimension 'GAS','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'GAS','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension  'GAS','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'GAS','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'GAS','Condicion Pago','Normal','Condicion Pago',1
EXEC spInsertarDimensionNivel  'GAS','Condicion Pago','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'GAS','Clasificacion','Normal','Clasificacion',1
EXEC spInsertarDimensionNivel  'GAS','Clasificacion','SubClasificacion','SubClase','SubClase',1
EXEC spInsertarDimensionNivel  'GAS','Clasificacion','Clasificacion','Clase','Clase',2
GO
EXEC spInsertarDimension 'GAS','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'GAS','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'GAS','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel  'GAS','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'GAS','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'GAS','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'GAS','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'GAS','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'GAS','Acreedor Categoria','Normal','Acreedor Categoria',1
EXEC spInsertarDimension 'GAS','Acreedor Familia','Normal','Acreedor Familia',1
EXEC spInsertarDimension 'GAS','Acreedor','Normal','Acreedor Clave',1
GO
EXEC spInsertarDimensionNivel  'GAS','Acreedor Categoria','AcreedorCategoria','Acreedor Categoria','Acreedor Categoria',1
EXEC spInsertarDimensionNivel  'GAS','Acreedor Familia','AcreedorFamilia','Acreedor Familia','Acreedor Familia',1
EXEC spInsertarDimensionNivel  'GAS','Acreedor','Acreedor','Acreedor','Acreedor',1
EXEC spInsertarDimensionNivel  'GAS','Acreedor','AcreedorNombre','Acreedor Nombre','Acreedor Nombre',2
GO
EXEC spInsertarDimension 'GAS','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'GAS','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'GAS','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'GAS','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'GAS','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'GAS','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'GAS','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'GAS','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'GAS','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'GAS','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'GAS','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'GAS','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'GAS','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'GAS','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'GAS','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'GAS','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'GAS','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'GAS','Gasto','Normal','Gasto',1
EXEC spInsertarDimensionNivel  'GAS','Gasto','Gasto','Gasto','Gasto',1
GO
EXEC spInsertarDimension 'GAS','Direccion','Normal','Direccion',1
EXEC spInsertarDimensionNivel  'GAS','Direccion','Direccion','Direccion','Direccion',1
GO
EXEC spInsertarDimension 'GAS','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel  'GAS','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension 'GAS','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel  'GAS','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension 'GAS','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'GAS','Estado','Estado','Poblacion','Poblacion',1
GO
/* Código duplicado en el original		Víctor Gutiérrez Méndez */
--EXEC spInsertarDimension 'GAS','Estado','Normal','Estado',1
--EXEC spInsertarDimensionNivel  'GAS','Estado','Estado','Poblacion','Poblacion',1
--GO
EXEC spInsertarDimension 'GAS','Codigo Postal','Normal','Codigo Postal Cliente',1
EXEC spInsertarDimensionNivel  'GAS','Codigo Postal','CodigoPostal','Codigo Postal','Codigo Postal Cliente',1
GO
EXEC spInsertarDimension 'GAS','AFArticulo','Normal','AFArticulo',1
EXEC spInsertarDimensionNivel  'GAS','AFArticulo','AFArticulo','AFArticulo','AFArticulo',1
GO
EXEC spInsertarDimension 'GAS','AFSerie','Normal','AFSerie',1
EXEC spInsertarDimensionNivel  'GAS','AFSerie','AFSerie','AFSerie','AFSerie',1
GO
EXEC spInsertarDimension 'GAS','Codigo Postal','Normal','Codigo Postal Cliente',1
EXEC spInsertarDimensionNivel  'GAS','Codigo Postal','CodigoPostal','Codigo Postal','Codigo Postal Cliente',1
GO
EXEC spInsertarDimension 'GAS','AcreedorRef','Normal','AcreedorRef',1
EXEC spInsertarDimensionNivel  'GAS','AcreedorRef','AcreedorRef','AcreedorRef','AcreedorRef',1
GO
/*	Se le agregaron las dimensiones Referencia, Personal y PersonalNombre		Víctor Gutiérrez Méndez */
EXEC spInsertarDimension 'GAS','Referencia','Normal','Referencia',1
EXEC spInsertarDimensionNivel  'GAS','Referencia','Referencia','Referencia','Referencia',1
GO
EXEC spInsertarDimension 'GAS','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel  'GAS','Personal','Personal','Personal','Personal',1
GO
EXEC spInsertarDimension 'GAS','PersonalNombre','Normal','PersonalNombre',1
EXEC spInsertarDimensionNivel  'GAS','PersonalNombre','PersonalNombre','PersonalNombre','PersonalNombre',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_GAS]'))
DROP VIEW Cubo_GAS
GO 
CREATE VIEW Cubo_GAS
AS
SELECT
gasto.Id,
'Sucursal' 		= gasto.Sucursal,
'SucursalNombre'	= su.Nombre,
'SucursalRegion' 	= su.Region,
'Empresa' 		= gasto.Empresa,
'EmpresaNombre'		= e.Nombre,
'EmpresaGrupo' 		= e.Grupo,
'Acreedor' 		= gasto.Acreedor,
'AcreedorNombre' 	= p.Nombre,
'AcreedorCategoria' 	= p.Categoria,
'AcreedorFamilia' 	= p.Familia,
'Direccion'		= p.Direccion,
'Colonia'		= p.Colonia,
'Poblacion'		= p.Poblacion,
'Estado'		= p.Estado,
'CodigoPostal'		= p.CodigoPostal,
'MovGrupo' 		= mc.Grupo,
gasto.Mov,
gasto.MovID,
'Gasto'			= CASE WHEN mc.Grupo = 'Presupuestos' THEN 'Presupuestos' ELSE 'Real' END,
gasto.FechaEmision,
gasto.FechaRequerida,
d.Proyecto,
gasto.Moneda,
gasto.Tipocambio,
'Clasificacion'		= c.Clase,
'Subclasificacion'	= c.SubClase,
gasto.Estatus,
gasto.Situacion,
gasto.Condicion,
gasto.Vencimiento,
gasto.FormaPago,
gasto.CtaDinero,
gasto.Ejercicio,
gasto.Periodo,
gasto.AFArticulo,
gasto.AFSerie,
d.Concepto,
d.Referencia,
d.Precio,
d.ContUso,
'AcreedorRef'		= pp.Nombre,
'Rama'			= cc.SubGrupo,
cc.Descripcion,
t.trimestre,
t.Semana,
'Año'			= t.anio,
'Mes'			= t.MesNombre,
'DiaSemana'		= t.DiaNombre,
'Dia'			= CASE WHEN DATEPART(d, gasto.FechaEmision) < 10
			       THEN '0' + CONVERT(CHAR(1),DATEPART(d, gasto.FechaEmision))
			       ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, gasto.FechaEmision))) END ,
d.UEN,
'ConceptoTipo'		= C.Tipo,
'PorcentajeDeducible'	= C.PorcentajeDeducible,
'Deducible'		= C.Impuestos,
'RetencionISR' 		= C.Retencion,
'RetencionIVA'		= C.Retencion2,
'ConceptoClase'		= C.Clase,
'ConceptoSubClase'	= C.SubClase,
'ConceptoActividad'	= C.Actividad,
'ConceptoIndirecto'	= C.Indirecto,
'uenNombre' 		= uen.Nombre,
'Cantidad'		= ISNULL(d.Cantidad, 0.0),
'ImporteEnPesos'   	= ISNULL(d.Importe, 0.0) * mt.Factor * Tipocambio,
'Importe'   		= ISNULL(d.Importe, 0.0) * mt.Factor ,
'Presupuesto'		= CASE WHEN mc.Grupo = 'Presupuestos' THEN ISNULL(d.Importe,0) ELSE 0 END,
'Impuestos'  		= ISNULL(d.Impuestos, 0.0) * mt.Factor ,
'Retencion'  		= (ISNULL(d.Retencion, 0.0) + ISNULL(d.Retencion2, 0.0)) * mt.Factor ,
'ImporteTotal'      	= (ISNULL(d.Importe, 0.0) - ISNULL(d.Retencion, 0.0) - ISNULL(d.Retencion2, 0.0) + ISNULL(d.Impuestos, 0.0)) * mt.Factor ,
'Personal'		= d.Personal,
'PersonalNombre'	= RTRIM(per.Nombre)+' '+RTRIM(per.ApellidoPaterno)+' '+RTRIM (per.ApellidoMaterno)
FROM
Gasto
LEFT OUTER JOIN GastoD d 	ON gasto.ID 	  	= d.ID
LEFT OUTER JOIN Concepto c 	ON c.Modulo 		= 'GAS' AND d.Concepto = c.Concepto
LEFT OUTER JOIN Empresa e 	ON gasto.Empresa  	= e.Empresa
LEFT OUTER JOIN Sucursal su 	ON gasto.Sucursal 	= su.Sucursal
LEFT OUTER JOIN CentroCostos cc	ON d.ContUso 	  	= cc.CentroCostos
LEFT OUTER JOIN Prov p 		ON gasto.Acreedor 	= p.Proveedor
LEFT OUTER JOIN Prov pp		ON d.AcreedorRef  	= pp.Proveedor
	   JOIN MovTipo mt 	ON gasto.Mov      	= mt.Mov
	   JOIN MovClave mc  	ON mc.Modulo 	  	= mt.Modulo AND mc.Clave = mt.Clave
LEFT OUTER JOIN Tiempo t	ON CONVERT(DATETIME,convert(VARCHAR(11),gasto.FechaEmision),103) = t.fecha
LEFT OUTER JOIN UEN uen	   	ON d.uen	 	= uen.uen
LEFT OUTER JOIN Personal per 	ON d.Personal  		= per.Personal
WHERE mt.Modulo = 'GAS'

GO

/*select count(*), clasificacion from cubo_gast0
where fechaemision = '02/26/2007'
group by clasificacion*/

