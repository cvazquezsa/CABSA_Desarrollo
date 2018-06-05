/* COMS */
EXEC spInsertarCubo 'COMS','Compras','Cubo de Compras','Cubo_COMS',0,1
GO
EXEC spInsertarMedida 'COMS','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'COMS','CantidadPendiente','CantidadPendiente','CantidadPendiente','aggSum'
EXEC spInsertarMedida 'COMS','Descuentos','Descuentos','Descuentos','aggSum'
EXEC spInsertarMedida 'COMS','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'COMS','Impuestos','Impuestos','Impuestos','aggSum'
EXEC spInsertarMedida 'COMS','ImporteTotal','Importe Total','Importe Total','aggSum'
EXEC spInsertarMedida 'COMS','ImporteEnPesos','ImporteEnPesos','ImporteEnPesos','aggSum'
EXEC spInsertarMedida 'COMS','PresupuestoEnPesos','PresupuestoEnPesos','PresupuestoEnPesos','aggSum'
GO
EXEC spInsertarFormula 'COMS','Costo Unitario','Costo Unitario','[Measures].[Importe]/[Measures].[Cantidad]',1
EXEC spInsertarFormula 'COMS','Saldo','Saldo','[Measures].[Cantidad]-[Measures].[CantidadPendiente]',1
EXEC spInsertarFormula 'COMS','Variacion','Variacion','[Measures].[ImporteEnPesos]/[Measures].[PresupuestoEnPesos]',1
GO
EXEC spInsertarDimension 'COMS','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'COMS','Movimiento','Mov','Movimiento','Movimiento',1
EXEC spInsertarDimensionNivel  'COMS','Movimiento','MovID','Consecutivo','Consecutivo',2
EXEC spInsertarDimensionNivel  'COMS','Movimiento','MovGrupo','Grupo','Grupo Movimiento',3
GO
EXEC spInsertarDimension 'COMS','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'COMS','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'COMS','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'COMS','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'COMS','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'COMS','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'COMS','Hora','Normal','Hora',0
EXEC spInsertarDimensionNivel  'COMS','Hora','DiaSemana','Hora','Hora',1
GO
EXEC spInsertarDimension 'COMS','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'COMS','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'COMS','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel  'COMS','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel  'COMS','Agente','AgenteNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'COMS','Agente','AgenteGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'COMS','Usuario','Normal','Usuario',0
EXEC spInsertarDimensionNivel  'COMS','Usuario','Usuario','Usuario','Usuario',1
EXEC spInsertarDimensionNivel  'COMS','Usuario','UsuarioNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'COMS','Usuario','UsuarioGrupoTrabajo','Usuario Grupo Trabajo','Grupo',3
GO
EXEC spInsertarDimension 'COMS','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'COMS','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'COMS','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'COMS','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'COMS','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'COMS','Estatus','Estatus','Estatus','Estatus',1
EXEC spInsertarDimensionNivel  'COMS','Estatus','Situacion','Situacion','Situacion',2
GO
EXEC spInsertarDimension 'COMS','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'COMS','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'COMS','Opcion','Normal','Opcion',1
EXEC spInsertarDimensionNivel  'COMS','Opcion','OpcionNombre','Opcion','Opcion',1
GO
EXEC spInsertarDimension 'COMS','Fecha Requerida','Tiempo','Fecha Requerida',1
EXEC spInsertarDimensionNivel  'COMS','Fecha Requerida','FechaRequerida','Fecha Requerida','FechaRequerida',1
GO
EXEC spInsertarDimension 'COMS','Localizacion','Normal','Localizacion',0
EXEC spInsertarDimensionNivel  'COMS','Localizacion','Colonia','Colonia','Colonia',1
EXEC spInsertarDimensionNivel  'COMS','Localizacion','Delegacion','Delegacion','Delegacion',2
EXEC spInsertarDimensionNivel  'COMS','Localizacion','Poblacion','Poblacion','Poblacion',3
EXEC spInsertarDimensionNivel  'COMS','Localizacion','Estado','Estado','Estado',4
EXEC spInsertarDimensionNivel  'COMS','Localizacion','Pais','Pais','Pais',5
GO
EXEC spInsertarDimension 'COMS','Forma Envio','Normal','Forma Envio',1
EXEC spInsertarDimensionNivel  'COMS','Forma Envio','FormaEnvio','Forma Envio','Forma Envio',1
GO
EXEC spInsertarDimension 'COMS','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'COMS','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'COMS','Proveedor Categoria','Normal','Proveedor',1
EXEC spInsertarDimension 'COMS','Proveedor Familia','Normal','Proveedor Familia',1
EXEC spInsertarDimension 'COMS','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'COMS','Proveedor Categoria','ProvCategoria','Proveedor Categoria','Proveedor Categoria',1
EXEC spInsertarDimensionNivel  'COMS','Proveedor Familia','ProvFamilia','Proveedor Familia','Proveedor Familia',1
EXEC spInsertarDimensionNivel  'COMS','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'COMS','Proveedor','ProvNombre','Proveedor Nombre','Proveedor Nombre',2
GO
EXEC spInsertarDimension 'COMS','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'COMS','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'COMS','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'COMS','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'COMS','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'COMS','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'COMS','Empresa','EmpresaNombre','Nombre','Empresa',2
EXEC spInsertarDimensionNivel  'COMS','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'COMS','Almacen','Normal','Almacen',1
EXEC spInsertarDimensionNivel  'COMS','Almacen','Almacen','Almacen','Almacen',1
EXEC spInsertarDimensionNivel  'COMS','Almacen','AlmNombre','Nombre','Almacen',2
EXEC spInsertarDimensionNivel  'COMS','Almacen','AlmGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension 'COMS','Articulo Rama','Normal','Articulo Rama',1
EXEC spInsertarDimensionNivel  'COMS','Articulo Rama','ArtRama','Articulo Rama','Articulo Rama',1
GO
EXEC spInsertarDimension 'COMS','Articulo Categoria','Normal','Articulo',1
EXEC spInsertarDimension 'COMS','Articulo Familia','Normal','Articulo',1
EXEC spInsertarDimension 'COMS','Articulo Grupo','Normal','Articulo',1
EXEC spInsertarDimension 'COMS','Articulo','Normal','Articulo',1
EXEC spInsertarDimension 'COMS','Articulo Linea','Normal','Articulo',1
EXEC spInsertarDimension 'COMS','Articulo Fabricante','Normal','Articulo',1
EXEC spInsertarDimensionNivel  'COMS','Articulo Categoria','ArtCategoria','Articulo Categoria','Articulo Categoria',1
EXEC spInsertarDimensionNivel  'COMS','Articulo Familia','ArtFamilia','Articulo Familia','Articulo Familia',1
EXEC spInsertarDimensionNivel  'COMS','Articulo Grupo','ArtGrupo','Articulo Grupo','Articulo Grupo',1
EXEC spInsertarDimensionNivel  'COMS','Articulo','Articulo','Articulo','Articulo',1
EXEC spInsertarDimensionNivel  'COMS','Articulo','ArtNombre','Art Nombre','ArtNombre',2
EXEC spInsertarDimensionNivel  'COMS','Articulo Fabricante','ArtFabricante','Articulo Fabricante','Articulo Fabricante',1
EXEC spInsertarDimensionNivel  'COMS','Articulo Linea','ArtLinea','Articulo Linea','Articulo Linea',1
GO
EXEC spInsertarDimension 'COMS','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'COMS','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'COMS','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'COMS','Tipo Cambio','Normal','Tipo Cambio',1
EXEC spInsertarDimensionNivel  'COMS','Tipo Cambio','TipoCambio','Tipo Cambio','Tipo Cambio',1
GO
EXEC spInsertarDimension 'COMS','Direccion','Normal','Direccion',1
EXEC spInsertarDimensionNivel  'COMS','Direccion','Direccion','Direccion','Direccion',1
GO
EXEC spInsertarDimension 'COMS','Colonia','Normal','Colonia',1
EXEC spInsertarDimensionNivel  'COMS','Colonia','Colonia','Colonia','Colonia',1
GO
EXEC spInsertarDimension 'COMS','Poblacion','Normal','Poblacion',1
EXEC spInsertarDimensionNivel  'COMS','Poblacion','Poblacion','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension 'COMS','Compra','Normal','Compra',1
EXEC spInsertarDimensionNivel  'COMS','Compra','Compra','Compra','Compra',1
GO
EXEC spInsertarDimension 'COMS','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'COMS','Estado','Estado','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension 'COMS','Estado','Normal','Estado',1
EXEC spInsertarDimensionNivel  'COMS','Estado','Estado','Poblacion','Poblacion',1
GO
EXEC spInsertarDimension 'COMS','Codigo Postal','Normal','Codigo Postal Cliente',1
EXEC spInsertarDimensionNivel  'COMS','Codigo Postal','CodigoPostal','Codigo Postal','Codigo Postal Cliente',1
GO
EXEC spInsertarDimension 'COMS','Vencimiento','Tiempo','Vencimiento',1
EXEC spInsertarDimensionNivel  'COMS','Vencimiento','Vencimiento','Vencimiento','Vencimiento',1
GO
EXEC spInsertarDimension 'COMS','Antigüedad','Normal','Antigüedad',1
EXEC spInsertarDimensionNivel  'COMS','Antigüedad','Antigüedad','Antigüedad','Antigüedad',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[Cubo_COMS]'))
 DROP VIEW Cubo_COMS
GO
CREATE VIEW Cubo_COMS 
	--//WITH ENCRYPTION
	AS
	SELECT   
	  co.id,
	  'Sucursal' 		= co.Sucursal,
	  'SucursalNombre'	= su.Nombre,  
	  'SucursalRegion' 	= su.Region, 
	  'Empresa' 		= co.Empresa,
	  'EmpresaNombre'	= e.Nombre,  
	  'EmpresaGrupo' 	= e.Grupo,
	  'MovGrupo' 		= mc.Grupo,
	  co.Mov,  
	  co.MovID,
	  co.Moneda,
	  co.TipoCambio,
	  co.Concepto,
	  co.Referencia,
	  co.Proyecto, 
	  co.FechaRegistro,
	  co.Estatus,
	  'Compra'		= CASE WHEN co.Mov = 'Presupuesto' THEN 'Presupuesto' ELSE 'Real' END,
	  co.Situacion,
	  'Proveedor' 		= co.Proveedor, 
	  'ProvNombre' 		= p.Nombre,  
	  'ProvCategoria' 	= p.Categoria,  
	  'ProvFamilia' 	= p.Familia,
	  co.FormaEnvio,
	  co.Condicion,
	  co.Vencimiento,
	  'Almacen' 		= co.Almacen, 
	  'AlmNombre' 		= al.Nombre,  
	  'AlmGrupo' 		= al.Grupo,
	  'AlmCategoria' 	= al.Categoria,
	  'ArtCategoria' 	= a.Categoria,  
	  'ArtGrupo' 		= a.Grupo,  
	  'ArtFamilia'		= a.Familia,
	  'ArtLinea' 		= a.Linea,  
	  'ArtRama'		= a.Rama,
	  'Articulo' 		= co.Articulo, 
	  'ArtNombre' 		= a.Descripcion1,
	  'ArtFabricante' 	= a.Fabricante,
	  'Cantidad' 		= CONVERT(float, co.CantidadNeta	* mt.Factor), 
	  'CantidadPendiente' 	= CONVERT(float, co.CantidadPendiente	* mt.Factor), 
	  'Descuentos' 		= CONVERT(money, co.DescuentosTotales	* mt.Factor), 
	  'Importe' 		= CONVERT(money, co.SubTotal		* mt.Factor), 
	  'Impuestos' 		= CONVERT(money, co.Impuestos		* mt.Factor), 
	  'ImporteTotal' 	= CONVERT(money, co.ImporteTotal	* mt.Factor),
	  'PresupuestoEnPesos' 	= CASE WHEN co.Mov = 'Presupuesto' 
				THEN CONVERT(money, co.Importe		* mt.Factor * co.TipoCambio)
				ELSE 0 END,
	  'ImporteEnPesos' 	= CASE WHEN co.Mov = 'Presupuesto' 
				THEN 0
				ELSE CONVERT(money, co.Importe		* mt.Factor * co.TipoCambio) END,
	  co.FechaRequerida,
	  co.FechaConclusion,
	  co.FechaEntrega,
	  co.EmbarqueEstado,
	  co.FechaEmision,
	  co.Peso,
	  co.Volumen,
	  co.ZonaImpuesto,
	  co.Prioridad,
	  co.SituacionFecha,
--	  cd.ReferenciaExtra,
	  p.Ruta,
	  p.Pais,
	  p.Estado,
	  p.Poblacion,
	  p.Delegacion,
	  p.Direccion,
	  p.CodigoPostal,
	  p.Colonia,
	  co.Usuario,
	  'UsuarioNombre' 	= u.Nombre,
	  'UsuarioGrupoTrabajo' = u.GrupoTrabajo,
	  co.Causa,
	  co.UEN,
	  'UENNombre'		= uen.Nombre,
	  t.trimestre,
	  t.Semana,
	  'DiaSemana'		= t.DiaNombre,
	  'Mes'			= t.MesNombre,
	  'Dia'			= CASE WHEN DATEPART(d, co.FechaEmision) < 10 
					THEN '0' + CONVERT(CHAR(1),DATEPART(d, co.FechaEmision))
					ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, co.FechaEmision))) END ,
	
	  'Hora' 		= CASE  DATEPART(hour, co.FechaRegistro) 
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
	 'Antigüedad'	 	= CASE	WHEN co.Estatus = 'PENDIENTE' AND DATEDIFF(day, co.Vencimiento, GETDATE())<= 0 
					THEN 'Corriente'  
				WHEN co.Estatus = 'PENDIENTE' AND DATEDIFF(day, co.Vencimiento, GETDATE())>= 1	
				AND DATEDIFF(day, co.Vencimiento, GETDATE())<= 30 
					THEN ' 1 - 30'  
				WHEN  co.Estatus = 'PENDIENTE' AND  DATEDIFF(day, co.Vencimiento, GETDATE())>= 31 
				AND DATEDIFF(day, co.Vencimiento, GETDATE())<= 60 
					THEN '31 - 60' 
				WHEN  co.Estatus = 'PENDIENTE' AND DATEDIFF(day, co.Vencimiento, GETDATE())>= 61 
				AND DATEDIFF(day, co.Vencimiento, GETDATE())<= 90 
					THEN '61 - 90' 
				WHEN  co.Estatus = 'PENDIENTE' AND DATEDIFF(day, co.Vencimiento, GETDATE())>= 91 
					THEN '+ 90'    END,
	  'Opcion' 		= co.SubCuenta,
	  'OpcionNombre'	= dbo.fnOpcion(co.SubCuenta),
	  'Agente' 		= co.agente,
	  'AgenteNombre' 	= ag.Nombre,
	  'AgenteGrupo' 	= ag.grupo
	FROM 
	  CompraTCalc co 
		
	LEFT OUTER JOIN Empresa e 	ON co.Empresa 	= e.Empresa 
	LEFT OUTER JOIN Sucursal su 	ON co.Sucursal 	= su.Sucursal 
	LEFT OUTER JOIN UEN uen	ON co.UEN 	= uen.UEN
	LEFT OUTER JOIN Prov p 	ON co.Proveedor = p.Proveedor
	LEFT OUTER JOIN Agente ag 	ON co.Agente 	= ag.Agente 
	LEFT OUTER JOIN Alm al 		ON co.Almacen 	= al.Almacen 
	LEFT OUTER JOIN Art a 		ON co.Articulo  = a.Articulo 
	           JOIN MovTipo mt 	ON co.Mov 	= mt.Mov 
		   JOIN MovClave mc  	ON mc.Modulo 	= mt.Modulo 
					AND mc.Clave 	= mt.Clave 
	LEFT OUTER JOIN Usuario u 	ON co.Usuario 	= u.Usuario 
	LEFT OUTER JOIN Tiempo t 	ON co.FechaEmision = t.Fecha
	
	WHERE  mt.Modulo = 'COMS'
GO
