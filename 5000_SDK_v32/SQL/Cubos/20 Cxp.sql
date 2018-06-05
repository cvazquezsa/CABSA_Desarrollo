/* cxp */
EXEC spInsertarCubo 'CXP','Cuentas por Pagar','Cubo de Cuentas por Pagar','Cubo_CXP',0,1
GO
EXEC spInsertarMedida 'CXP','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'CXP','ImporteEnPesos','Importe en Pesos','ImporteEnPesos','aggSum'
EXEC spInsertarMedida 'CXP','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'CXP','Saldo','Saldo','Saldo','aggSum'
EXEC spInsertarMedida 'CXP','Throughput','Throughput','Throughput','aggSum'
EXEC spInsertarMedida 'CXP','DiasRetraso','Dias Retraso','Dias Retraso','aggSum'
EXEC spInsertarMedida 'CXP','HabitoDiasEmision','Habito Dias Emision','Habito Dias Emision','aggSum'
EXEC spInsertarMedida 'CXP','HabitoDiasRetraso','Habito Dias Retraso','Habito Dias Retraso','aggSum'
GO
EXEC spInsertarDimension 'CXP','Aplicacion','Normal','Aplicacion',0
EXEC spInsertarDimensionNivel 'CXP','Aplicacion','AplicaId','Aplica Id','Aplica ID',1
EXEC spInsertarDimensionNivel 'CXP','Aplicacion','Aplica','Aplica','Aplica',2
GO
EXEC spInsertarDimension 'CXP','Referencia','Normal','Referencia',0
EXEC spInsertarDimensionNivel 'CXP','Referencia','Referencia','Referencia','Referencia',1
GO
EXEC spInsertarDimension 'CXP','Observaciones','Normal','Observaciones',0
EXEC spInsertarDimensionNivel 'CXP','Observaciones','Observaciones','Observaciones','Observaciones',1
GO
EXEC spInsertarDimension 'CXP','Estatus Saldo','Normal','Estatus Saldo',1
EXEC spInsertarDimensionNivel 'CXP','Estatus Saldo','EstatusSaldo','EstatusSaldo','EstatusSaldo',1
GO
EXEC spInsertarDimension 'CXP','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel 'CXP','Movimiento','MovID','Concecutivo','Concecutivo',1
EXEC spInsertarDimensionNivel 'CXP','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel 'CXP','Movimiento','MovGrupo','Grupo','Grupo Movimiento',3
GO
EXEC spInsertarDimension 'CXP','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel 'CXP','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'CXP','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel 'CXP','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'CXP','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel 'CXP','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'CXP','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel 'CXP','Estatus','Situacion','Situacion','Situacion',1
EXEC spInsertarDimensionNivel 'CXP','Estatus','Estatus','Estatus','Estatus',2
GO
EXEC spInsertarDimension 'CXP','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel 'CXP','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'CXP','Vencimiento','Tiempo','Vencimiento',1
EXEC spInsertarDimensionNivel 'CXP','Vencimiento','Vencimiento','Vencimiento','Vencimiento',1
GO
EXEC spInsertarDimension 'CXP','EstaVencido','Normal','EstaVencido',1
EXEC spInsertarDimensionNivel 'CXP','EstaVencido','EstaVencido','Esta Vencido','Esta Vencido',1
GO
EXEC spInsertarDimension 'CXP','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel 'CXP','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel 'CXP','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel 'CXP','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'CXP','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel 'CXP','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel 'CXP','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel 'CXP','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'CXP','Proveedor Categoria','Normal','Proveedor Categoria',1
EXEC spInsertarDimension 'CXP','Proveedor Familia','Normal','Proveedor Familia',1
EXEC spInsertarDimension 'CXP','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel 'CXP','Proveedor Categoria','ProvCategoria','Proveedor Categoria','Proveedor Categoria',1
EXEC spInsertarDimensionNivel 'CXP','Proveedor Familia','ProvFamilia','Proveedor Familia','Proveedor Familia',1
EXEC spInsertarDimensionNivel 'CXP','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel 'CXP','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',2
GO
EXEC spInsertarDimension 'CXP','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'CXP','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'CXP','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'CXP','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'CXP','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'CXP','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'CXP','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'CXP','Proveedor Tipo','Normal','Proveedor Tipo',1
EXEC spInsertarDimensionNivel 'CXP','Proveedor Tipo','ProvTipo','Proveedor Tipo','Proveedor Tipo',1
GO
EXEC spInsertarDimension 'CXP','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'CXP','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'CXP','Año','Normal','Año',1
EXEC spInsertarDimensionNivel 'CXP','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'CXP','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel 'CXP','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'CXP','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel 'CXP','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'CXP','DiaSemana','Normal','DiaSemana',1
EXEC spInsertarDimensionNivel 'CXP','DiaSemana','DiaSemana','DiaSemana','DiaSemana',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_CXP]'))
DROP VIEW Cubo_CXP
GO
CREATE VIEW Cubo_CXP 
--//WITH ENCRYPTION
AS
SELECT
  Cxp.ID,
  'Sucursal' 		= cxP.Sucursal,
  'SucursalNombre'	= su.Nombre,  
  'SucursalRegion' 	= su.Region, 
  'Empresa' 		= cxP.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'MovGrupo' 		= mc.Grupo,
  CxP.Mov,
  Cxp.MovID,
  Cxp.FechaEmision,
  Cxp.Concepto,
  Cxp.Referencia,
  Cxp.Observaciones,
  Cxp.Proyecto,
  Cxp.Moneda,
  Cxp.TipoCambio,
  Cxp.Usuario,
  'UsuarioNombre' 	= u.Nombre,
  'UsuarioGrupoTrabajo' = u.GrupoTrabajo,
  Cxp.Estatus,
  Cxp.Situacion,
  Cxp.SituacionFecha,
  'Proveedor' 		= cxp.Proveedor,
  'ProvNombre' 		= p.Nombre,
  'ProvCategoria' 	= p.Categoria,
  'ProvFamilia' 	= p.Familia,
  'ProvTipo'		= p.Tipo,
  Cxp.ProveedorMoneda,
  Cxp.ProveedorTipoCambio,
  Cxp.Condicion,
  Cxp.Vencimiento,
  Cxp.FormaPago,
  Cxp.CtaDinero,
  'Importe' 		= cxp.importe * mt.Factor ,
  'ImporteEnPesos'	= cxp.importe * mt.Factor * Cxp.TipoCambio,
  'Impuestos' 		= cxp.Impuestos * mt.Factor ,
  'Saldo' 		= cxp.Saldo     * mt.Factor ,
  Cxp.OrigenTipo,
  Cxp.Origen,
  Cxp.OrigenID,
  Cxp.Dinero,
  Cxp.DineroID,
  Cxp.DineroCtaDinero,
  t.trimestre,
  t.semana,
  'Año'			= t.Anio,
  'Mes'			= t.MesNombre,
  'DiaSemana'	= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, cxp.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, cxp.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, cxp.FechaEmision))) END ,

  cxp.UEN,
  'uenNombre' 		= uen.Nombre,	 
  'HabitoDiasEmision' 	= DATEDIFF(day, Cxp.FechaEmision, Cxp.FechaConclusion),
  'HabitoDiasRetraso' 	= DATEDIFF(day, Cxp.Vencimiento, Cxp.FechaConclusion),
  'EstaVencido'  	= CASE WHEN Cxp.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxp.Vencimiento, GETDATE())>0 THEN 'Si' ELSE 'No' END,
  'EstatusSaldo' 	= CASE WHEN Cxp.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxp.Vencimiento, GETDATE())>=cfg.CxpDiasMorosidad THEN 'Moroso' WHEN Cxp.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxp.Vencimiento, GETDATE())>0 THEN 'Vencido' ELSE 'Corriente' END,
  'DiasRetraso'  	= CASE WHEN Cxp.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxp.Vencimiento, GETDATE())>0 THEN DATEDIFF(day, Cxp.Vencimiento, GETDATE()) ELSE 0 END,
  'Throughput'   	= CASE WHEN Cxp.Estatus = 'PENDIENTE' AND DATEDIFF(day, Cxp.Vencimiento, GETDATE())>0 THEN DATEDIFF(day, Cxp.Vencimiento, GETDATE()) ELSE 0 END * Cxp.Saldo
FROM
  Cxp

LEFT OUTER JOIN Empresa e 	ON Cxp.Empresa 	 = e.Empresa 
LEFT OUTER JOIN Sucursal su 	ON Cxp.Sucursal  = su.Sucursal 
LEFT OUTER JOIN Prov p 		ON Cxp.Proveedor = p.Proveedor
LEFT OUTER JOIN Usuario u 	ON Cxp.Usuario   = u.Usuario
LEFT OUTER JOIN MovTipo mt 	ON mt.Mov 	 = Cxp.Mov
LEFT OUTER JOIN MovClave mc 	ON mc.Modulo 	 = mt.Modulo 
				AND mc.Clave 	 = mt.Clave
LEFT OUTER JOIN EmpresaCfg2 Cfg ON Cxp.Empresa   = cfg.Empresa 
LEFT OUTER JOIN Tiempo t	ON cxp.FechaEmision = t.fecha
LEFT OUTER JOIN UEN uen	   	ON CXP.uen	 = uen.uen	

WHERE
  Cxp.Estatus IN ('PENDIENTE', 'CONCLUIDO') 
 AND mt.Modulo = 'CXP'
GO

 