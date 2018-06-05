/* CuboServ */
EXEC spInsertarCubo  'SERV','Servicio','Cubo de Servicio','Cubo_SERV',0,1
GO
EXEC spInsertarMedida 'SERV','ImpuestoIVA','Impuesto IVA','ImpuestoIVA','aggSum'
EXEC spInsertarMedida 'SERV','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'SERV','Descuentos','Descuentos','Descuentos','aggSum'
EXEC spInsertarMedida 'SERV','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'SERV','ImporteTotal','Importe Total','ImporteTotal','aggSum'
EXEC spInsertarMedida 'SERV','Comision','Comision','Comision','aggSum'
EXEC spInsertarMedida 'SERV','CostoTotal','Costo','Costo','aggSum'
EXEC spInsertarMedida 'SERV','DiasDuracion','Dias Duracion','DiasDuracion','aggSum'
EXEC spInsertarMedida 'SERV','DiasCierre','Dias Cierre','DiasCierre','aggSum'
EXEC spInsertarMedida 'SERV','DiasAfectacion','Dias Afectacion','DiasAfectacion','aggSum'
EXEC spInsertarMedida 'SERV','ArtHora','Hora','Hora','aggSum'
GO
EXEC spInsertarFormula 'SERV','Utilidad','Utilidad','[Measures].[Importe]-[Measures].[Costo]',1
EXEC spInsertarFormula 'SERV','% Margen','% Margen','[Measures].[Utilidad]/[Measures].[Importe]',2
GO
EXEC spInsertarDimension 'SERV','Cliente Sucursal','Normal','Cliente Sucursal',0
EXEC spInsertarDimensionNivel  'SERV','Cliente Sucursal','ClienteSucursal','Cliente Sucursal','Cliente Sucursal',1
EXEC spInsertarDimensionNivel  'SERV','Cliente Sucursal','ClienteSucursalNombre','Cliente Sucursal Nombre','Cliente Sucursal Nombre',2
GO
EXEC spInsertarDimension 'SERV','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'SERV','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'SERV','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'SERV','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'SERV','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'SERV','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'SERV','Hora','Normal','Hora',0
EXEC spInsertarDimensionNivel  'SERV','Hora','Hora','Hora','Hora',1
GO
EXEC spInsertarDimension 'SERV','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'SERV','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'SERV','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'SERV','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'SERV','Calificacion','Normal','Calificacion',1
EXEC spInsertarDimensionNivel  'SERV','Calificacion','Calificacion','Calificacion','Calificacion',1
GO
EXEC spInsertarDimension 'SERV','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'SERV','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'SERV','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'SERV','Movimiento','MoviD','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel  'SERV','Movimiento','Mov','Movimiento','Movimiento',2
EXEC spInsertarDimensionNivel  'SERV','Movimiento','MovGrupo','Grupo','Grupo Movimiento',3
GO
EXEC spInsertarDimension 'SERV','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'SERV','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'SERV','Causa','Normal','Causa',1
EXEC spInsertarDimensionNivel  'SERV','Causa','Causa','Causa','Causa',1
GO
EXEC spInsertarDimension 'SERV','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'SERV','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'SERV','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'SERV','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'SERV','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'SERV','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'SERV','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel  'SERV','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'SERV','Fecha Emision','Normal','Fecha Emision',1
EXEC spInsertarDimensionNivel  'SERV','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'SERV','Fecha','Tiempo','Fecha',1
EXEC spInsertarDimensionNivel  'SERV','Fecha','FechaEmision','Fecha','Fecha',1
GO
EXEC spInsertarDimension 'SERV','Fecha Requerida','Normal','Fecha Requerida',1
EXEC spInsertarDimensionNivel  'SERV','Fecha Requerida','FechaRequerida','Fecha Requerida','FechaRequerida',1
GO
EXEC spInsertarDimension 'SERV','Lista Precios','Normal','Lista Precios',0
EXEC spInsertarDimensionNivel  'SERV','Lista Precios','ListaPrecios','Lista Precios','Lista Precios',1
GO 
EXEC spInsertarDimension 'SERV','Opcion','Normal','Opcion',0
EXEC spInsertarDimensionNivel  'SERV','Opcion','OpcionNombre','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'SERV','Asesor Servicio','Normal','Agente',1
EXEC spInsertarDimensionNivel  'SERV','Asesor Servicio','Agente','Asesor Servicio','Agente',1
EXEC spInsertarDimensionNivel  'SERV','Asesor Servicio','AgenteNombre','Asesor Nombre','Agente Nombre',2
EXEC spInsertarDimensionNivel  'SERV','Asesor Servicio','AgenteGrupo','Grupo Asesor','Grupo',3
GO
EXEC spInsertarDimension 'SERV','Asesor Categoria','Normal','Asesor Categoria',1
EXEC spInsertarDimensionNivel  'SERV','Asesor Categoria','AgenteCategoria','Categoria Asesor','Categoria',1
GO
EXEC spInsertarDimension 'SERV','Personal Asignado','Normal','Personal',1
EXEC spInsertarDimensionNivel  'SERV','Personal Asignado','AgenteD','Personal Asignado','Agente',1
EXEC spInsertarDimensionNivel  'SERV','Personal Asignado','AgenteNombreD','Personal Nombre','Agente Nombre',2
EXEC spInsertarDimensionNivel  'SERV','Personal Asignado','AgenteGrupoD','Grupo Personal','Grupo',3
GO
EXEC spInsertarDimension 'SERV','Personal Categoria','Normal','Personal',1
EXEC spInsertarDimensionNivel  'SERV','Personal Categoria','AgenteCategoriaD','Categoria Personal','Categoria',1
GO
EXEC spInsertarDimension 'SERV','Forma Envio','Normal','Forma Envio',1
EXEC spInsertarDimensionNivel  'SERV','Forma Envio','FormaEnvio','Forma Envio','Forma Envio',1
GO
EXEC spInsertarDimension 'SERV','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'SERV','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'SERV','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'SERV','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'SERV','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'SERV','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'SERV','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'SERV','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'SERV','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'SERV','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'SERV','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'SERV','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'SERV','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',3
GO
EXEC spInsertarDimension 'SERV','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimension 'SERV','Cliente Familia','Normal','Cliente Familia',1
EXEC spInsertarDimension 'SERV','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimension 'SERV','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'SERV','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
EXEC spInsertarDimensionNivel  'SERV','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
EXEC spInsertarDimensionNivel  'SERV','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimensionNivel  'SERV','Cliente','Cliente','Cliente','Cliente',1
EXEC spInsertarDimensionNivel  'SERV','Cliente','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'SERV','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel 'SERV','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO
EXEC spInsertarDimension 'SERV','Distribuidor','Normal','Distribuidor',1
EXEC spInsertarDimensionNivel 'SERV','Distribuidor','Distribuidor','Distribuidor','Distribuidor',1
GO
EXEC spInsertarDimension 'SERV','Codigo Postal','Normal','Codigo Postal Cliente',0
EXEC spInsertarDimensionNivel  'SERV','Codigo Postal','CodigoPostal','Codigo Postal','Codigo Postal Cliente',1
GO
EXEC spInsertarDimension 'SERV','Almacen','Normal','Almacen',0
EXEC spInsertarDimensionNivel  'SERV','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'SERV','Almacen','AlmNombre','AlmNombre','AlmNombre',2
EXEC spInsertarDimensionNivel  'SERV','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'SERV','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimension 'SERV','Articulo','Normal','Articulo',1
EXEC spInsertarDimension 'SERV','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'SERV','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
EXEC spInsertarDimensionNivel  'SERV','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'SERV','Articulo','ArtNombre','Articulo Nombre','Articulo Nombre',2
EXEC spInsertarDimensionNivel  'SERV','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
GO
EXEC spInsertarDimension 'SERV','Tipo Vehiculo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Vehiculo','ArtFamilia','Tipo Vehiculo','Articulo Familia',1
GO
EXEC spInsertarDimension 'SERV','Modelo','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'SERV','Modelo','ArtCategoria','Modelo','Articulo Categoria',1
GO
EXEC spInsertarDimension 'SERV','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'SERV','Articulo Linea','ArtLinea','Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'SERV','Horario Cita','Normal','ArtHora',1
EXEC spInsertarDimensionNivel  'SERV','Horario Cita','Hora','Horario Cita','ArtHora',1
GO
EXEC spInsertarDimension 'SERV','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'SERV','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'SERV','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'SERV','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'SERV','Venta','Normal','Venta',1
EXEC spInsertarDimensionNivel  'SERV','Venta','Venta','Venta','Venta',1
GO
EXEC spInsertarDimension 'SERV','Clasificacion','Normal','Clasificacion',1
EXEC spInsertarDimensionNivel  'SERV','Clasificacion','Clase','Clasificacion','Clasificacion',1
EXEC spInsertarDimensionNivel  'SERV','Clasificacion','SubClase','SubClasificacion','SubClasificacion',2
GO
EXEC spInsertarDimension 'SERV','Tipo Servicio','Normal','ServTipo',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Servicio','ServTipo','Tipo Servicio','ServTipo',1
GO
EXEC spInsertarDimension 'SERV','Articulo Servicio','Normal','ServArticulo',1
EXEC spInsertarDimensionNivel  'SERV','Articulo Servicio','ServArticulo','Articulo Servicio','ServArticulo',1
GO
EXEC spInsertarDimension 'SERV','VIN','Normal','ServSerie',1
EXEC spInsertarDimensionNivel  'SERV','VIN','ServSerie','VIN','ServSerie',1
GO
EXEC spInsertarDimension 'SERV','Contrato','Normal','ServContrato',1
EXEC spInsertarDimensionNivel  'SERV','Contrato','ServContrato','Contrato','ServContrato',1
GO
EXEC spInsertarDimension 'SERV','Tipo Contrato','Normal','ServContratoTipo',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Contrato','ServContratoTipo','Tipo Contrato','ServContratoTipo',1
GO
EXEC spInsertarDimension 'SERV','Numero Contrato','Normal','ServContratoId',1
EXEC spInsertarDimensionNivel  'SERV','Numero Contrato','ServContratoId','Numero Contrato','ServContratoId',1
GO
EXEC spInsertarDimension 'SERV','Garantia','Normal','ServGarantia',1
EXEC spInsertarDimensionNivel  'SERV','Garantia','ServGarantia','Garantia','ServGarantia',1
GO
EXEC spInsertarDimension 'SERV','Fecha Servicio','Normal','ServFecha',1
EXEC spInsertarDimensionNivel  'SERV','Fecha Servicio','ServFecha','Fecha Servicio','ServFecha',1
GO
EXEC spInsertarDimension 'SERV','Torre','Normal','ServIdentificador',1
EXEC spInsertarDimensionNivel  'SERV','Torre','ServIdentificador','Torre','ServIdentificador',1
GO
EXEC spInsertarDimension 'SERV','Localizacion','Normal','ServDescripcion',1
EXEC spInsertarDimensionNivel  'SERV','Localizacion','ServDescripcion','Localizacion','ServDescripcion',1
GO
EXEC spInsertarDimension 'SERV','Numero Matricula','Normal','ServPlacas',1
EXEC spInsertarDimensionNivel  'SERV','Numero Matricula','ServPlacas','Numero Matricula','ServPlacas',1
GO
EXEC spInsertarDimension 'SERV','Numero Siniestro','Normal','ServSiniestro',1
EXEC spInsertarDimensionNivel  'SERV','Numero Siniestro','ServSiniestro','Numero Siniestro','ServSiniestro',1
GO
EXEC spInsertarDimension 'SERV','Kilometraje','Normal','ServKms',1
EXEC spInsertarDimensionNivel  'SERV','Kilometraje','ServKms','Kilometraje','ServKms',1
GO  		
EXEC spInsertarDimension 'SERV','Tipo Orden','Normal','ServTipoOrden',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Orden','ServTipoOrden','Tipo Orden','ServTipoOrden',1
GO  	
EXEC spInsertarDimension 'SERV','Tipo Operacion','Normal','ServTipoOperacion',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Operacion','ServTipoOperacion','Tipo Operacion','ServTipoOperacion',1
GO  	
EXEC spInsertarDimension 'SERV','Servicio Express','Normal','ServExpress',1
EXEC spInsertarDimensionNivel  'SERV','Servicio Express','ServExpress','Servicio Express','ServExpress',1
GO
EXEC spInsertarDimension 'SERV','Tipo Articulo','Normal','ArtTipo',1
EXEC spInsertarDimensionNivel  'SERV','Tipo Articulo','ArtTipo','Tipo Articulo','ArtTipo',1
GO
EXEC spInsertarDimension 'SERV','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'SERV','Estado','Estado','Estado','Estado',1
GO
EXEC spInsertarDimension 'SERV','Demerito','Normal','Demerito',1
EXEC spInsertarDimensionNivel  'SERV','Demerito','ServicioDemerito','Demerito','Demerito',1
GO
EXEC spInsertarDimension 'SERV','Venta Seguros','Normal','Deducible',1
EXEC spInsertarDimensionNivel  'SERV','Venta Seguros','ServicioDeducible','Venta Seguros','Deducible',1
GO
EXEC spInsertarDimension 'SERV','Paneles Agente','Normal','paneles',1
EXEC spInsertarDimensionNivel  'SERV','Paneles Agente','ServicioNumeroD','Paneles Agente','paneles Agente',1
GO
EXEC spInsertarDimension 'SERV','Numero Paneles','Normal','Numero paneles',1
EXEC spInsertarDimensionNivel  'SERV','Numero Paneles','ServicioNumero','numero Paneles','numero paneles',1
GO
EXEC spInsertarDimension 'SERV','Comentarios','Normal','Comentarios',1
EXEC spInsertarDimensionNivel  'SERV','Comentarios','Comentarios','Comentarios','Comentarios',1
GO
/* CuboServ */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_SERV]'))
DROP VIEW Cubo_SERV
GO
CREATE VIEW Cubo_SERV
--//WITH ENCRYPTION
AS
SELECT
  v.ID,
  'Sucursal' 		= v.Sucursal,
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
  v.MovID,
  v.Moneda,
  v.TipoCambio,
  v.Concepto,
  v.Referencia,
  V.Observaciones,
  v.Proyecto,
  v.FechaRegistro,
  'FechaEmision'	= v.FechaEmision,
  'FechaRequerida'	= v.FechaRequerida,
  v.HoraRequerida,
  v.FechaOriginal,
  v.FechaConclusion,
  v.FechaEntrega,
  v.EmbarqueEstado,
  v.ZonaImpuesto,
  v.Prioridad,
  v.Estatus,
  v.Situacion,
  v.SituacionFecha,
  'Cliente' 		= v.Cliente, 
  'ClienteNombre' 	= c.Nombre,
  'ClienteFamilia' 	= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 	= c.Grupo,
  'ClienteTipo'		= c.Tipo,
  'Distribuidor'	= c.FordDistribuidor,
  'Agente' 		= v.Agente,
  'AgenteNombre' 	= ag.Nombre,
  'AgenteGrupo'		= ag.Grupo,
  'AgenteCategoria'	= ag.Categoria,
  'AgenteD' 		= vtad.Agente,
  'AgenteNombreD' 	= agd.Nombre,
  'AgenteGrupoD'	= agd.Grupo,
  'AgenteCategoriaD'	= agd.Categoria,
  v.FormaEnvio,
  v.Condicion,
  v.Vencimiento,
  v.Paquetes,
  v.Causa,
  vta.clase,
  vta.subclase,
  ca.Categoria,
  vta.UEN,
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
  'ArtHora'		= ISNULL(CONVERT(DECIMAL(4,2),a.horas),0),
  'ArtTipo'		= a.Tipo,
  'PrecioUnitario' 	= v.Precio,
  'CostoUnitario' 	= v.Costo,
  'ImpuestoIVA' 	= v.Impuesto1Total	* mt.Factor, 
  'ImpuestoSuntuario' 	= v.Impuesto2Total	* mt.Factor,
  'Cantidad' 		= v.CantidadNeta	* mt.Factor, 
  'CantidadPendiente' 	= v.CantidadPendiente	* mt.Factor, 
  'CantidadReservada' 	= v.CantidadReservada	* mt.Factor, 
  'CantidadOrdenada' 	= v.CantidadOrdenada	* mt.Factor, 
  'Comision' 		= v.Comision 		* mt.Factor, 
  'CostoTotal' 		= v.CostoTotal 		* mt.Factor, 
  'Descuentos' 		= v.DescuentosTotales 	* mt.Factor, 
  'Importe' 		= v.SubTotal 		* mt.Factor,
  'Impuestos' 		= v.Impuestos 		* mt.Factor, 
  'ImporteTotal' 	= v.ImporteTotal	* mt.Factor,

  'DiasDuracion'	= DATEDIFF(day,v.fechaEmision,v.FechaConclusion),
  'DiasCierre'		= DATEDIFF(day,v.fechaEmision,v.FechaRequerida),
  'DiasAfectacion'	= DATEDIFF(day,v.fechaRequerida,vta.ServicioFecha),
  
  'ServTipo'		= vta.ServicioTipo,
  'ServArticulo'	= vta.ServicioArticulo,
  'ServSerie'		= vta.ServicioSerie,
  'ServContrato'	= vta.ServicioContrato,
  'ServContratoId'	= vta.ServicioContratoID,
  'ServContratoTipo'	= vta.ServicioContratoTipo,
  'ServGarantia'	= vta.ServicioGarantia,
  'ServDescripcion'	= vta.ServicioDescripcion,
  'ServFecha'		= vta.ServicioFecha,
  'ServIdentificador'	= vta.ServicioIdentificador,
  'ServPlacas'		= vta.ServicioPlacas,
  'ServSiniestro'	= vta.ServicioSiniestro,
  'ServKms'		= vta.ServicioKms,
  'ServTipoOrden'	= vta.ServicioTipoOrden,
  'ServTipoOperacion'	= vta.ServicioTipoOperacion,
  'Comentarios'		= CONVERT(VARCHAR(255),vta.Comentarios),
  'ServExpress'		= CASE WHEN vta.ServicioExpress = 1
					THEN 'Servicio Express'
					ELSE 'Paquete' END,
  'ServicioDemerito'	= CASE WHEN vta.ServicioDemerito = 0 
					THEN 'Sin Demerito'
					ELSE 'Con Demerito' END,
  'ServicioDeducible'	= CASE WHEN vta.ServicioDeducible = 0
					THEN 'Sin Deducible'
					ELSE 'Con Deducible' END,
  'ServicioNumero'	= vta.ServicioNumero,
  'ServicioNumeroD'	= vtad.ServicioNumero,
  'Calificacion'	= CONVERT(DECIMAL(8,2),ec.Calificacion),
  'Estado'		= vtad.Estado

FROM 
  VentaTcalc v

LEFT OUTER JOIN Empresa 	e  	ON v.Empresa  	= e.Empresa 
LEFT OUTER JOIN Sucursal 	s 	ON v.Sucursal 	= s.Sucursal 
LEFT OUTER JOIN Agente 		ag  	ON v.Agente   	= ag.Agente
LEFT OUTER JOIN Cte  		c     	ON v.Cliente  	= c.Cliente
LEFT OUTER JOIN Alm 		al     	ON v.Almacen  	= al.Almacen 
LEFT OUTER JOIN Art 		a   	ON v.Articulo 	= a.Articulo 
LEFT OUTER JOIN Prov 		pr    	ON a.Proveedor 	= pr.Proveedor
LEFT OUTER JOIN Venta 		vta    	ON v.Id 	= vta.Id
LEFT OUTER JOIN VentaD 		vtad   	ON v.Id 	= vtad.Id
					AND v.Articulo  = vtad.Articulo
LEFT OUTER JOIN Agente 		agd  	ON vtad.Agente 	= agd.Agente
LEFT OUTER JOIN MovTipo 	mt 	ON v.Mov  	= mt.Mov  
	   JOIN MovClave 	mc 	ON mc.Modulo 	= mt.Modulo 
					AND mc.Clave    = mt.Clave 
	   JOIN Tiempo		t  	ON v.FechaEmision = t.Fecha
LEFT OUTER JOIN UEN 		uen   	ON vta.uen	= uen.uen	
LEFT OUTER JOIN Causa 		ca 	ON v.Causa 	= ca.Causa 
LEFT OUTER JOIN evaluacionCalificacion EC 	ON V.ID = CONVERT(INT,SUBSTRING(EC.CONTACTO,5,3))
WHERE mt.Modulo 	= 'VTAS' 
	AND mt.Clave 	= 'VTAS.S'

GO


