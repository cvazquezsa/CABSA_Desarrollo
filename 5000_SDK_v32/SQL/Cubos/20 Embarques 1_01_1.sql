/* EMB */
--- 4-12-2003 Se agrego porcentaje de gastos por volumen embarcado
--- 15-01-2004 El importe del embarque es sin IVA

EXEC spInsertarStore 'EMB','spCuboEmbarque',1
EXEC spInsertarCubo 'EMB','Embarques','Cubo de Embarques','Cubo_EMB',0,1
GO
EXEC spInsertarMedida 'EMB','Peso','Peso','Peso','aggSum'
EXEC spInsertarMedida 'EMB','Volumen','Volumen','Volumen','aggSum'
EXEC spInsertarMedida 'EMB','Paquetes','Paquetes','Paquetes','aggSum'
EXEC spInsertarMedida 'EMB','ImporteTotal','ImporteTotal','ImporteTotal','aggSum'
EXEC spInsertarMedida 'EMB','ImporteEmbarque','ImporteEmbarque','Importe','aggSum'
EXEC spInsertarMedida 'EMB','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'EMB','CostoTotal','Costo VTAS','Costo VTAS','aggSum'
EXEC spInsertarMedida 'EMB','GastoTotalPorc','Gasto','Gasto','aggSum'
GO
EXEC spInsertarFormula 'EMB','Importe Total','ImporteTotal','[Measures].[Importe]+[Measures].[Impuestos]',1
GO
EXEC spInsertarDimension 'EMB','MovimientoEMB','Normal','Movimiento',1
EXEC spInsertarDimensionNivel 'EMB','MovimientoEMB','Mov','Movimiento','Movimiento',1
EXEC spInsertarDimensionNivel 'EMB','MovimientoEMB','MovID','Consecutivo','Consecutivo',2
GO
EXEC spInsertarDimension 'EMB','Ruta','Normal','Ruta',1
EXEC spInsertarDimensionNivel 'EMB','Ruta','Ruta','Ruta','Ruta',1
GO
EXEC spInsertarDimension 'EMB','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimension 'EMB','Proveedor Categoria','Normal','Proveedor Categoria',1
EXEC spInsertarDimension 'EMB','Proveedor Familia','Normal','Proveedor Familia',1
EXEC spInsertarDimensionNivel 'EMB','Proveedor Categoria','ProvCategoria','Proveedor Categoria','Proveedor Categoria',1
EXEC spInsertarDimensionNivel 'EMB','Proveedor Familia','ProvFamilia','Proveedor Familia','Proveedor Familia',1
EXEC spInsertarDimensionNivel 'EMB','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel 'EMB','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',2
GO
EXEC spInsertarDimension 'EMB','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel 'EMB','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'EMB','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel 'EMB','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'EMB','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel 'EMB','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'EMB','Fecha Salida','Tiempo','Fecha Salida',1
EXEC spInsertarDimensionNivel 'EMB','Fecha Salida','FechaSalida','Fecha Salida','FechaSalida',1
go
EXEC spInsertarDimension 'EMB','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel 'EMB','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel 'EMB','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel 'EMB','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'EMB','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel 'EMB','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel 'EMB','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel 'EMB','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'EMB','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'EMB','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'EMB','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'EMB','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'EMB','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'EMB','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'EMB','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'EMB','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'EMB','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'EMB','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'EMB','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'EMB','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'EMB','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'EMB','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimension 'EMB','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimension 'EMB','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimension 'EMB','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'EMB','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'EMB','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
EXEC spInsertarDimensionNivel  'EMB','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'EMB','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension 'EMB','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'EMB','Movimiento','Movimiento','Movimiento','Movimiento',2
GO
EXEC spInsertarDimension 'EMB','MovConsecutivo','Normal','MovConsecutivo',1
EXEC spInsertarDimensionNivel  'EMB','MovConsecutivo','MovConsecutivo','MovConsecutivo','MovConsecutivo',2
GO
EXEC spInsertarDimension 'EMB','Cliente Nombre','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'EMB','Cliente Nombre','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'EMB','ClienteEnviarA','Normal','ClienteEnviarA',1
EXEC spInsertarDimensionNivel  'EMB','ClienteEnviarA','ClienteEnviarA','ClienteEnviarA','ClienteEnviarA',2
GO
EXEC spInsertarDimension 'EMB','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'EMB','Estado','Estado','Estado','Estado',2
GO
/*Vista para embarques */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EMBM3]'))
DROP VIEW Cubo_EMBM3
GO
CREATE VIEW Cubo_EMBM3
--//WITH ENCRYPTION
AS
SELECT
	'EMBId'		= e.Id,
	'VTASId'	= vta.Id,
	'CantidadTotal'	= SUM(eda.CantidadTotal),
	'Cantidad'	= SUM(eda.Cantidad),
	'ImporteTotal'	= SUM(eda.ImporteTotal),
	'VolumenTotal'	= SUM(a.Volumen * eda.CantidadTotal),
	'Volumen'	= SUM(a.Volumen * eda.Cantidad)
FROM Embarque e
LEFT OUTER JOIN EmbarqueD ed 	ON e.Id 	= ed.Id 
LEFT OUTER JOIN EmbarqueMov em 	ON ed.EmbarqueMov = em.Id 
LEFT OUTER JOIN Venta vta 	ON em.ModuloId 	= vta.Id
LEFT OUTER JOIN EmbarqueDArt eda ON e.Id 	= eda.id
				AND eda.Modulo='VTAS'
				AND eda.ModuloId=vta.Id	
LEFT OUTER JOIN Ventad vtad 	ON eda.ModuloId	= vtad.id
				AND eda.Renglon = vtad.Renglon
LEFT OUTER JOIN Art a	 	ON vtad.Articulo= a.Articulo
GROUP BY e.ID,vta.Id
GO
--- Vista para obtener el volumen total por embarque
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EMBTOTM3]'))
DROP VIEW Cubo_EMBTOTM3
GO
CREATE VIEW Cubo_EMBTOTM3
--//WITH ENCRYPTION
AS
SELECT
	'EMBId'		= e.Id,
	'VolumenTotal'	= SUM(a.Volumen * eda.Cantidad)
FROM Embarque e
LEFT OUTER JOIN EmbarqueD ed 	ON e.Id 	= ed.Id 
LEFT OUTER JOIN EmbarqueMov em 	ON ed.EmbarqueMov = em.Id 
LEFT OUTER JOIN Venta vta 	ON em.ModuloId 	= vta.Id
LEFT OUTER JOIN EmbarqueDArt eda ON e.Id 	= eda.id
				AND eda.Modulo='VTAS'
				AND eda.ModuloId=vta.Id	
LEFT OUTER JOIN Ventad vtad 	ON eda.ModuloId	= vtad.id
				AND eda.Renglon = vtad.Renglon
LEFT OUTER JOIN Art a	 	ON vtad.Articulo= a.Articulo
GROUP BY e.ID
GO
/* Vista para agrupar los gastos */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EMBGAS]'))
DROP VIEW Cubo_EMBGAS
GO
CREATE VIEW Cubo_EMBGAS
--//WITH ENCRYPTION
AS
SELECT AnexoID, 
  'Importe'	= SUM(Importe),
  'Impuestos'	= SUM(Impuestos),
  'Retencion'	= SUM(Retencion)
FROM Gasto
WHERE AnexoModulo ='EMB'
GROUP BY AnexoID
GO
/*Vista para embarques */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EMB]'))
DROP VIEW Cubo_EMB
GO
CREATE VIEW Cubo_EMB
--//WITH ENCRYPTION
AS
SELECT
  e.Id,
  'Sucursal' 		= su.Sucursal,
  'SucursalNombre'	= su.Nombre,  
  'SucursalRegion' 	= su.Region, 
  'Empresa' 		= ep.Empresa, 
  'EmpresaNombre' 	= ep.Nombre,  
  'EmpresaGrupo' 	= ep.Grupo,
  e.Mov, 
  e.MovID, 
  'Camiones'		= 0,
  'RepartosXId'		= 0,
  'RepartosXMov'	= 0,
  e.FechaEmision,
  e.FechaSalida,
  'Proveedor' 		= e.Proveedor,
  'ProvNombre' 		= p.Nombre,  
  'ProvCategoria' 	= p.Categoria,  
  'ProvFamilia' 	= p.Familia,
  em.Peso,
  'VolumenEMB'		= MT3.VolumenTotal,
  M3.VolumenTotal,
  M3.Volumen,
  'Paquetes'		= m3.cantidad,
  em.moneda,
  'ImporteTotal'	= em.Importe,
  'ImporteEmbarque'	= CASE WHEN ed.MovPorcentaje IS NULL THEN  0 ELSE (ed.MovPorcentaje/100) * (em.Importe) END,
  'ImporteEmbarque2'	= CASE WHEN ed.MovPorcentaje IS NULL THEN em.Importe ELSE 0 END,
  em.Impuestos,
  ed.Estado,
  'ImporteEMB' 		= ISNULL(e.Importe, 0) + ISNULL(e.Impuestos, 0),
  'GastoClase'		= NULL,
  'GastoSubClase'	= NULL,
  'GastoImporte'	= ISNULL(g.Importe,0),
  'GastoImpuesto'	= ISNULL(g.Impuestos,0),
  'GastoRetencion'	= ISNULL(g.Retencion,0),
  'GastoTotal'		= ISNULL(g.Importe,0) + ISNULL(g.Impuestos,0) - ISNULL(g.Retencion,0),
  'GastoTotalPorc'	= CASE WHEN MT3.VolumenTotal > 0 
				THEN convert(decimal(12,2),(ISNULL(M3.Volumen,0)/MT3.VolumenTotal)) * (ISNULL(g.Importe,0) + ISNULL(g.Impuestos,0) - ISNULL(g.Retencion,0))
				ELSE 0 END,
  'EmbarqueVehiculo' 	= e.Vehiculo,
  'EmbarqueVehiculoProveedor' = v.Proveedor,
  'EmbarqueEmision' 	= e.FechaEmision,
  'EMBSalida' 		= e.FechaSalida,
  'EmbarqueRetorno' 	= e.FechaRetorno,
  'EmbarqueConclusion' 	= e.FechaConclusion,
  e.Ruta,
  e.Usuario,
  'UsuarioNombre' 	= u.Nombre,
  'UsuarioGrupoTrabajo' = u.GrupoTrabajo,
  'Cliente'		= em.Cliente,
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  em.ClienteEnviarA,
  'MovConsecutivo'	= RTRIM(vta.Mov) + ' ' + RTRIM(vta.MovId),
  'Movimiento'		= vta.Mov ,
  'CostoTotal' 		= vta.CostoTotal,
  'PrecioTotal'		= vta.PrecioTotal,
  e.UEN,
  e.Estatus,
  'NoRegistros'		= 1,
  'uenNombre' 		= uen.Nombre,	  
  t.trimestre,
  t.Semana,
  'Año'			= t.anio,
  'Mes'			= t.MesNombre,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, e.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, e.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, e.FechaEmision))) END 

FROM 
  Embarque e
LEFT OUTER JOIN EmbarqueD ed 	ON e.Id 	= ed.Id 
LEFT OUTER JOIN EmbarqueMov em 	ON ed.EmbarqueMov = em.Id 
LEFT OUTER JOIN Cubo_EMBGAS g 	ON e.ID 	= g.AnexoId
LEFT OUTER JOIN Venta vta 	ON em.ModuloId 	= vta.Id
LEFT OUTER JOIN Cubo_EMBM3 M3 	ON e.Id = M3.EMBId
				AND vta.Id = M3.VTASId
LEFT OUTER JOIN Cubo_EMBTOTM3 MT3 ON e.Id = MT3.EMBId
LEFT OUTER JOIN Cte  	c     	ON em.Cliente 	= c.Cliente
LEFT OUTER JOIN Vehiculo v 	ON e.Vehiculo 	= v.Vehiculo 
LEFT OUTER JOIN Empresa ep 	ON em.Empresa 	= ep.Empresa 
LEFT OUTER JOIN Sucursal su 	ON e.Sucursal 	= su.Sucursal 
LEFT OUTER JOIN Usuario u 	ON e.Usuario 	= u.Usuario 
LEFT OUTER JOIN Prov p 		ON e.Proveedor  = p.Proveedor
	   JOIN Tiempo t	ON e.FechaEmision = t.fecha
LEFT OUTER JOIN UEN uen	   	ON e.uen	= uen.uen

WHERE 
 e.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
AND em.Cliente IS NOT NULL
GO

