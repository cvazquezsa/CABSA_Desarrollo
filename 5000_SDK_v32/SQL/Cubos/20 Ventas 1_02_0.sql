/* Cubo_VTAS */  
--- ver 1.0.1 6-11-2003 Se agrego la medida de presupuesto
--- ver 1.0.2 2-12-2003 Se agrego el max dias de Backorder
--- ver 1.0.2 2-12-2003 Se agrego el EL PRECIO PROMEDIO
--- ver 1.0.3 4-12-2003 Se agrego el saldo 
--- ver 1.0.3 4-12-2003 Se agrego LA CANTIDAD Pendiente, Reservada, Ordenada
--- ver 1.0.4 5-01-2004 Se agrego CRM especial para cliente de fritos

EXEC spInsertarStore 'VTAS','spCuboCteId',1
EXEC spInsertarCubo  'VTAS','Ventas','Cubo de Ventas','Cubo_VTAS',0,1
GO 
EXEC spInsertarMedida 'VTAS','CantidadOrdenada','Cantidad Ordenada','Cantidad Ordenada','aggSum'
EXEC spInsertarMedida 'VTAS','CantidadReservada','Cantidad Reservada','Cantidad Reservada','aggSum'
EXEC spInsertarMedida 'VTAS','CantidadPendiente','Cantidad Pendiente','Cantidad Pendiente','aggSum'
EXEC spInsertarMedida 'VTAS','ImporteCancelado','Importe Cancelado','Importe Cancelado','aggSum'
EXEC spInsertarMedida 'VTAS','Operaciones','No Operaciones','No Operaciones','aggSum'
EXEC spInsertarMedida 'VTAS','Presupuesto','Presupuesto','Presupuesto','aggSum'
EXEC spInsertarMedida 'VTAS','ImpuestoIVA','Impuesto IVA','ImpuestoIVA','aggSum'
EXEC spInsertarMedida 'VTAS','ImpuestoSuntuario','Impuesto Suntuario','ImpuestoSuntuario','aggSum'
EXEC spInsertarMedida 'VTAS','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'VTAS','Descuentos','Descuentos','Descuentos','aggSum'
EXEC spInsertarMedida 'VTAS','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'VTAS','ImporteTotal','Importe Total','ImporteTotal','aggSum'
EXEC spInsertarMedida 'VTAS','ImporteEnPesos','Importe en Pesos','Importe en pesos (por tipo cambio)','aggSum'
EXEC spInsertarMedida 'VTAS','Comision','Comision','Comision','aggSum'
EXEC spInsertarMedida 'VTAS','CostoTotal','Costo','Costo','aggSum'
EXEC spInsertarMedida 'VTAS','Saldo','Saldo','Saldo','aggSum'
EXEC spInsertarMedida 'VTAS','NoCliente','No Cliente','NoCliente','aggDistinctCount'
EXEC spInsertarMedida 'VTAS','MaxDiasBO','MaxDiasBO','MaxDiasBO','aggSum'
GO
EXEC spInsertarFormula 'VTAS','Utilidad','Utilidad','[Measures].[Importe]-[Measures].[Costo]',1
EXEC spInsertarFormula 'VTAS','% Margen','% Margen','[Measures].[Utilidad]/[Measures].[Importe]',2
EXEC spInsertarFormula 'VTAS','Precio Prom','Precio Prom','[Measures].[Importe]/[Measures].[Cantidad]',3
EXEC spInsertarFormula 'VTAS','Objetivo','Objetivo','([Measures].[Importe en Pesos],[Venta].[Real])/([Measures].[Importe en Pesos],[Venta].[Presupuestos])',4
GO
EXEC spInsertarDimension 'VTAS','Cliente Sucursal','Normal','Cliente Sucursal',0
EXEC spInsertarDimensionNivel  'VTAS','Cliente Sucursal','ClienteSucursal','Cliente Sucursal','Cliente Sucursal',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente Sucursal','ClienteSucursalNombre','Cliente Sucursal Nombre','Cliente Sucursal Nombre',2
GO
EXEC spInsertarDimension 'VTAS','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'VTAS','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'VTAS','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'VTAS','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'VTAS','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'VTAS','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'VTAS','Hora','Normal','Hora',1
EXEC spInsertarDimensionNivel  'VTAS','Hora','Hora','Hora','Hora',1
GO
EXEC spInsertarDimension 'VTAS','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'VTAS','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'VTAS','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'VTAS','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'VTAS','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'VTAS','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'VTAS','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'VTAS','Movimiento','Mov','Movimiento','Movimiento',1
EXEC spInsertarDimensionNivel  'VTAS','Movimiento','MovGrupo','Grupo','Grupo Movimiento',2
GO
EXEC spInsertarDimension 'VTAS','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'VTAS','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'VTAS','Causa','Normal','Causa',1
EXEC spInsertarDimensionNivel  'VTAS','Causa','Causa','Causa','Causa',1
GO
EXEC spInsertarDimension 'VTAS','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'VTAS','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'VTAS','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'VTAS','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'VTAS','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'VTAS','Estatus','Estatus','Estatus','Estatus',1
---EXEC spInsertarDimensionNivel  'VTAS','Estatus','Situacion','Situacion','Situacion',2
GO
EXEC spInsertarDimension 'VTAS','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'VTAS','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'VTAS','Fecha Requerida','Tiempo','Fecha Requerida',0
EXEC spInsertarDimensionNivel  'VTAS','Fecha Requerida','FechaRequerida','Fecha Requerida','FechaRequerida',1
GO
EXEC spInsertarDimension 'VTAS','Lista Precios','Normal','Lista Precios',0
EXEC spInsertarDimensionNivel  'VTAS','Lista Precios','ListaPrecios','Lista Precios','Lista Precios',1
GO 
EXEC spInsertarDimension 'VTAS','Opcion','Normal','Opcion',1
EXEC spInsertarDimensionNivel  'VTAS','Opcion','OpcionNombre','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'VTAS','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel  'VTAS','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel  'VTAS','Agente','AgenteNombre','Agente Nombre','Agente Nombre',2
EXEC spInsertarDimensionNivel  'VTAS','Agente','AgenteGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'VTAS','Forma Envio','Normal','Forma Envio',1
EXEC spInsertarDimensionNivel  'VTAS','Forma Envio','FormaEnvio','Forma Envio','Forma Envio',1
GO
EXEC spInsertarDimension 'VTAS','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'VTAS','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'VTAS','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'VTAS','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'VTAS','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'VTAS','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'VTAS','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'VTAS','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'VTAS','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'VTAS','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'VTAS','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'VTAS','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'VTAS','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',2
GO
EXEC spInsertarDimension 'VTAS','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimension 'VTAS','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimension 'VTAS','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimension 'VTAS','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension 'VTAS','Cliente Nombre','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'VTAS','Cliente Nombre','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'VTAS','CteAltaAño','Normal','CteAltaAño',1
EXEC spInsertarDimensionNivel  'VTAS','CteAltaAño','CteAltaAño','CteAltaAño','CteAltaAño',1
GO
EXEC spInsertarDimension 'VTAS','CteAltaMes','Normal','CteAltaMes',1
EXEC spInsertarDimensionNivel  'VTAS','CteAltaMes','CteAltaMes','CteAltaMes','CteAltaMes',1
GO
EXEC spInsertarDimension 'VTAS','CteAltaDia','Normal','CteAltaDia',1
EXEC spInsertarDimensionNivel  'VTAS','CteAltaDia','CteAltaDia','CteAltaDia','CteAltaDia',1
GO
EXEC spInsertarDimension 'VTAS','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel 'VTAS','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO
EXEC spInsertarDimension 'VTAS','Almacen','Normal','Almacen',0
EXEC spInsertarDimensionNivel  'VTAS','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'VTAS','Almacen','AlmNombre','AlmNombre','AlmNombre',3
EXEC spInsertarDimensionNivel  'VTAS','Almacen','AlmGrupo','Grupo','AlmGrupo',2
GO
EXEC spInsertarDimension 'VTAS','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimension 'VTAS','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimension 'VTAS','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimension 'VTAS','Articulo','Normal','Articulo',1
EXEC spInsertarDimension 'VTAS','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimension 'VTAS','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
EXEC spInsertarDimensionNivel  'VTAS','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
EXEC spInsertarDimensionNivel  'VTAS','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'VTAS','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'VTAS','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'VTAS','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'VTAS','Forma Pago','Normal','Forma Pago',0
EXEC spInsertarDimensionNivel  'VTAS','Forma Pago','FormaPago','Forma Pago','Forma Pago',1
GO
EXEC spInsertarDimension 'VTAS','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'VTAS','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'VTAS','Venta','Normal','Venta',1
EXEC spInsertarDimensionNivel  'VTAS','Venta','Venta','Venta','Venta',1
GO
EXEC spInsertarDimension 'VTAS','Clasificacion','Normal','Clasificacion',0
EXEC spInsertarDimensionNivel  'VTAS','Clasificacion','Clase','Clasificacion','Clasificacion',1
EXEC spInsertarDimensionNivel  'VTAS','Clasificacion','SubClase','SubClasificacion','SubClasificacion',2
GO
EXEC spInsertarDimension 'VTAS','Lunes','Normal','Lunes',0
EXEC spInsertarDimensionNivel  'VTAS','Lunes','Lunes','Lunes','Lunes',1
GO
EXEC spInsertarDimension 'VTAS','Martes','Normal','Martes',0
EXEC spInsertarDimensionNivel  'VTAS','Martes','Martes','Martes','Martes',1
GO
EXEC spInsertarDimension 'VTAS','Miercoles','Normal','Miercoles',0
EXEC spInsertarDimensionNivel  'VTAS','Miercoles','Miercoles','Miercoles','Miercoles',1
GO
EXEC spInsertarDimension 'VTAS','Jueves','Normal','Jueves',0
EXEC spInsertarDimensionNivel  'VTAS','Jueves','Jueves','Jueves','Jueves',1
GO
EXEC spInsertarDimension 'VTAS','Viernes','Normal','Viernes',0
EXEC spInsertarDimensionNivel  'VTAS','Viernes','Viernes','Viernes','Viernes',1
GO
EXEC spInsertarDimension 'VTAS','Sabado','Normal','Sabado',0
EXEC spInsertarDimensionNivel  'VTAS','Sabado','Sabado','Sabado','Sabado',1
GO
EXEC spInsertarDimension 'VTAS','Domingo','Normal','Domingo',0
EXEC spInsertarDimensionNivel  'VTAS','Domingo','Domingo','Domingo','Domingo',1
GO
EXEC spInsertarDimension 'VTAS','CRM Tipo Venta','Normal','TipoVenta',0
EXEC spInsertarDimensionNivel  'VTAS','CRM Tipo Venta','TipoVenta','Tipo Venta','TipoVenta',1
GO
EXEC spInsertarDimension 'VTAS','CRM Empleados','Normal','NoEmpleados',0
EXEC spInsertarDimensionNivel  'VTAS','CRM Empleados','NoEmpleados','No Empleados','NoEmpleados',1
GO
EXEC spInsertarDimension 'VTAS','CRM Prob Venta','Normal','Probabilidad Venta',0
EXEC spInsertarDimensionNivel  'VTAS','CRM Prob Venta','ProbVenta','Probabilidad Venta','Probabilidad Venta',1
GO
EXEC spInsertarDimension 'VTAS','Direccion','Normal','Direccion',0
EXEC spInsertarDimensionNivel  'VTAS','Direccion','Direccion','Direccion','Direccion',1
GO
EXEC spInsertarDimension 'VTAS','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel  'VTAS','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension 'VTAS','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel  'VTAS','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension 'VTAS','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'VTAS','Estado','Estado','Poblacion','Poblacion',1
GO
/*Dimensión duplicada en código original	Víctor Gutiérrez Méndez	*/
--EXEC spInsertarDimension 'VTAS','Estado','Normal','Estado',1
--EXEC spInsertarDimensionNivel  'VTAS','Estado','Estado','Poblacion','Poblacion',1
--GO
EXEC spInsertarDimension 'VTAS','Codigo Postal','Normal','Codigo Postal Cliente',1
EXEC spInsertarDimensionNivel  'VTAS','Codigo Postal','CodigoPostal','Codigo Postal','Codigo Postal Cliente',1
GO
EXEC spInsertarDimension 'VTAS','ServicioSerie','Normal','ServicioSerie',0
EXEC spInsertarDimensionNivel  'VTAS','ServicioSerie','ServicioSerie','ServicioSerie','ServicioSerie',0
GO
/*	Se agregaron las dimensiones CentroCostos y TipoVenta	Víctor Gutiérrez Méndez	*/
EXEC spInsertarDimension 'VTAS','CentroCostos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel  'VTAS','CentroCostos','CentroCostos','CentroCostos','CentroCostos',0
GO
EXEC spInsertarDimension 'VTAS','TipoVenta','Normal','TipoVenta',1
EXEC spInsertarDimensionNivel  'VTAS','TipoVenta','TipoVenta','TipoVenta','TipoVenta',0
GO

/* CuboVTAS */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_VTAS]'))
DROP VIEW Cubo_VTAS
GO
CREATE VIEW Cubo_VTAS
--//WITH ENCRYPTION
AS
SELECT
  v.ID,
  'Sucursal'		= v.Sucursal,
  'SucursalNombre'	= s.Nombre,  
  'SucursalRegion' 	= s.Region, 
  'Empresa'		= v.Empresa,
  'EmpresaNombre'	= e.Nombre,  
  'EmpresaGrupo' 	= e.Grupo,
  'Venta'		= CASE WHEN mc.Grupo = 'Presupuestos'
				THEN 'Presupuestos'
				ELSE 'Real' END,
  'MovGrupo' 		= mc.Grupo ,				
  'Mov'			= v.Mov ,
  'MovId'		= v.MovID,
  'GrupoMovId'		= NULL,
  v.Moneda, 
  v.TipoCambio,
  v.Concepto,
  v.Referencia,
  V.Observaciones,
  v.Proyecto,
  v.FechaRegistro,
  v.FechaEmision,
  v.FechaRequerida,
  v.HoraRequerida,
  v.FechaOriginal,
  v.FechaConclusion,
  v.FechaEntrega,
  v.EmbarqueEstado,
  v.Peso,
  v.Volumen,
  'Operaciones' 	= 1,
  'ListaPrecios' 	= v.ListaPreciosEsp,
  v.ZonaImpuesto,
  'Extraordinario' 	= v.Extra,
  v.Prioridad,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  'ClienteSucursal' 	= v.EnviarA,
  'ClienteSucursalNombre' = cs.Nombre,
  'Cliente' 		= v.Cliente, 
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  'Direccion'		= c.Direccion,
  'Colonia'		= c.Colonia,
  'Poblacion'		= c.Poblacion,
  'Estado'		= c.Estado,
  'CodigoPostal'	= c.CodigoPostal,
  'ClienteAlta'		= c.Alta,
  'CteAltaAño'		= YEAR(c.Alta),
  'CteAltaMes'		= CASE WHEN MONTH(c.Alta) < 10 
				THEN '0' + CONVERT(CHAR(1),MONTH(c.Alta))
				ELSE RTRIM(CONVERT(CHAR(2),MONTH(c.Alta))) END + DATENAME(M,c.Alta),
  'CteAltaDia'		= CASE WHEN DATEPART(d, c.Alta) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, c.Alta))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, c.Alta))) END ,
  'Lunes'		= c.Descripcion1,
  'Martes'		= c.Descripcion2,
  'Miercoles'		= c.Descripcion3,
  'Jueves'		= c.Descripcion4,
  'Viernes'		= c.Descripcion5,
  'Sabado'		= c.Descripcion6,
  'Domingo'		= c.Descripcion7,
  'Agente' 		= v.Agente,
  'AgenteNombre'	= ag.Nombre,
  'AgenteGrupo'		= ag.Grupo,
  v.FormaEnvio,
  v.Condicion,
  v.Vencimiento,
  v.Paquetes,
  v.Causa,
  'Clase'		= NULL,
  'SubClase'		= NULL,
  ca.Categoria,
  v.UEN,
  'UENNombre'		= uen.Nombre,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'Año'			= t.Anio,
  'DiaSemana'		= t.DiaNombre,
  'Dia'			= CASE WHEN DATEPART(d, v.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, v.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, v.FechaEmision))) END ,
  'Hora' 		= CASE  DATEPART(hour, v.FechaRegistro) 
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
  v.Almacen,
  'AlmNombre' 		= al.Nombre,
  'AlmGrupo' 		= al.Grupo,
  'AlmCategoria' 	= al.Categoria,
  v.PoliticaPrecios,
  pr.proveedor,
  'ProvNombre'		= pr.Nombre,
  'Articulo' 		= v.Articulo, 
  'ArtNombre' 		= a.Descripcion1,
  'ArtFamilia'		= a.Familia,
  'ArtCategoria' 	= a.Categoria,
  'ArtGrupo' 		= a.Grupo,
  'ArtLinea' 		= a.Linea,
  'ArtFabricante' 	= a.Fabricante,
  'Opcion' 		= v.SubCuenta,
  'OpcionNombre'	= dbo.fnOpcion(v.SubCuenta),
  'FormaPago'		= NULL,
  'PrecioUnitario' 	= v.Precio,
  'CostoUnitario' 	= v.Costo,
  'ImporteCancelado'= CASE WHEN mt.Modulo = 'VTAS' 
				AND mt.ConsecutivoModulo IN('VTAS') 
				AND mt.Factor < 1
				THEN v.importe * mt.Factor 
			   ELSE 0 END,
  'ImpuestoIVA' 		= v.Impuesto1Total	* mt.Factor, 
  'ImpuestoSuntuario' 	= v.Impuesto2Total	* mt.Factor,
  'Cantidad' 			= v.CantidadNeta	* mt.Factor, 
  'CantidadPendiente' 	= CantidadPendiente	* mt.Factor, 
  'CantidadReservada' 	= CantidadReservada	* mt.Factor, 
  'CantidadOrdenada' 	= CantidadOrdenada	* mt.Factor, 
  'Comision' 			= v.Comision 		* mt.Factor, 
  'Presupuesto'			= CASE WHEN mc.Grupo = 'Presupuestos'
				THEN v.SubTotal
				ELSE 0 END,
  'CostoTotal' 		= v.CostoTotal 		* mt.Factor, 
  'Descuentos' 		= v.DescuentosTotales 	* mt.Factor, 
  'Importe' 		= v.SubTotal 		* mt.Factor,
  'Impuestos' 		= v.Impuestos 		* mt.Factor, 
  'ImporteTotal' 	= v.ImporteTotal	* mt.Factor,
  'ImporteEnPesos' 	= v.SubTotal	 	* mt.Factor	* v.TipoCambio,
  'NoCliente'		= cte.CteId,
  'MaxDiasBO'		= CASE WHEN v.Estatus='PENDIENTE' THEN DATEDIFF(day,v.FechaEmision,GETDATE()) ELSE 0 END,
  'Saldo'		= v.Precio * v.CantidadPendiente,
  'ServicioSerie'	= v.ServicioSerie,
  'CentroCostos'	= v.Contuso,
  'TipoVenta'		= c.Ruta

FROM 
  VentaTCalc/*Intelisis*/ v

LEFT OUTER JOIN Empresa 	e  	ON v.Empresa  		= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON v.Sucursal 		= s.Sucursal 
LEFT OUTER JOIN Agente 		ag  ON v.Agente   	= ag.Agente
LEFT OUTER JOIN Cte  		c    	ON v.Cliente  	= c.Cliente
LEFT OUTER JOIN Alm 		al     	ON v.Almacen  	= al.Almacen 
LEFT OUTER JOIN Art 		a   	ON v.Articulo 	= a.Articulo 
LEFT OUTER JOIN Prov 		pr    	ON a.Proveedor 	= pr.Proveedor
LEFT OUTER JOIN CuboCteId	cte    	ON v.Cliente 	= cte.Cliente
LEFT OUTER JOIN MovTipo 	mt 	ON v.Mov  			= mt.Mov  
		   JOIN MovClave 	mc 	ON mc.Modulo		= mt.Modulo AND mc.Clave = mt.Clave 
LEFT OUTER JOIN Tiempo		t  	ON v.FechaEmision	= t.Fecha
LEFT OUTER JOIN UEN 		uen   	ON v.uen		= uen.uen	
LEFT OUTER JOIN CteEnviarA 	cs 	ON c.Cliente   		= cs.Cliente AND v.EnviarA = cs.id
LEFT OUTER JOIN Causa 		ca 	ON v.Causa 	= ca.Causa 

WHERE mt.Modulo = 'VTAS'

GO






