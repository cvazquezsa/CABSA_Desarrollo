/*ST_CTE*/
EXEC spLimpiarCubo 'ST_CTE'
EXEC spInsertarCubo 'ST_CTE','Atención Clientes','Cubo de Atención Clientes','Cubo_ST_CTE',0,1
GO
EXEC spInsertarMedida  'ST_CTE','Antiguedad','Antiguedad','Antiguedad','aggSum'
EXEC spInsertarMedida  'ST_CTE','Documentos','Documentos','Documentos','aggSum'
EXEC spInsertarMedida  'ST_CTE','TiempoDIAS','TiempoDIAS','TiempoDIAS','aggSum'
GO
EXEC spInsertarFormula 'ST_CTE','Promedio','Promedio','[Measures].[TiempoDias]/[Measures].[Documentos]',1
GO
EXEC spInsertarDimension   'ST_CTE','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel    'ST_CTE','Movimiento','MovID','Consecutivo','Consecutivo',1
EXEC spInsertarDimensionNivel    'ST_CTE','Movimiento','Mov','Movimiento','Movimiento',2
GO
EXEC spInsertarDimension   'ST_CTE','Cliente Sucursal','Normal','Cliente Sucursal',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Sucursal','Enviara','Cliente Sucursal','Cliente Sucursal',1
GO
EXEC spInsertarDimension   'ST_CTE','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel    'ST_CTE','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension   'ST_CTE','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel    'ST_CTE','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension   'ST_CTE','AgenteCategoria','Normal','AgenteCategoria',1
EXEC spInsertarDimensionNivel    'ST_CTE','AgenteCategoria','AgenteCategoria','AgenteCategoria','AgenteCategoria',1
GO
EXEC spInsertarDimension   'ST_CTE','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel    'ST_CTE','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel    'ST_CTE','Agente','AgenteNombre','Agente Nombre','Agente Nombre',2
EXEC spInsertarDimensionNivel    'ST_CTE','Agente','AgenteGrupo','Agente Grupo','Agente Grupo',3
GO
EXEC spInsertarDimension   'ST_CTE','Fuente','Normal','Fuente',1
EXEC spInsertarDimensionNivel    'ST_CTE','Fuente','Fuente','Fuente','Fuente',1
EXEC spInsertarDimensionNivel    'ST_CTE','Fuente','FuenteNombre','Fuente Nombre','Fuente Nombre',2
EXEC spInsertarDimensionNivel    'ST_CTE','Fuente','FuenteGrupo','Fuente Grupo','Fuente Grupo',3
GO
EXEC spInsertarDimension   'ST_CTE','Clasificacion','Normal','Clasificacion',1
EXEC spInsertarDimensionNivel    'ST_CTE','Clasificacion','Clase','Clasificacion','Clasificacion',2
GO
EXEC spInsertarDimension   'ST_CTE','SubClasificacion','Normal','SubClasificacion',1
EXEC spInsertarDimensionNivel    'ST_CTE','SubClasificacion','SubClase','Sub Clasificacion','Sub Clasificacion',1
GO
EXEC spInsertarDimension   'ST_CTE','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'ST_CTE','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'ST_CTE','Fecha Documento','Tiempo','Fecha Documento',1
EXEC spInsertarDimensionNivel    'ST_CTE','Fecha Documento','FechaEmision','Fecha Documento','FechaDocumento',1
GO
EXEC spInsertarDimension   'ST_CTE','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel    'ST_CTE','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel    'ST_CTE','Empresa','EmpresaNombre','Empresa Nombre','Empresa Nombre',2
EXEC spInsertarDimensionNivel    'ST_CTE','Empresa','EmpresaGrupo','Grupo','Grupo',3
GO
EXEC spInsertarDimension   'ST_CTE','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel    'ST_CTE','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel    'ST_CTE','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel    'ST_CTE','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension   'ST_CTE','Cliente','Normal','Cliente Clave',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension   'ST_CTE','Cliente Nombre','Normal','Cliente Nombre',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Nombre','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension   'ST_CTE','Cliente Categoria','Normal','Cliente Categoria',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Categoria','ClienteCategoria','Cliente Categoria','Cliente Categoria',1
GO
EXEC spInsertarDimension   'ST_CTE','Cliente Grupo','Normal','Cliente Grupo',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Familia','ClienteFamilia','Cliente Familia','Cliente Familia',1
GO
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Grupo','ClienteGrupo','Cliente Grupo','Cliente Grupo',1
EXEC spInsertarDimension   'ST_CTE','Cliente Familia','Normal','Cliente Familia',1
GO
EXEC spInsertarDimension   'ST_CTE','Cliente Tipo','Normal','Cliente Tipo',1
EXEC spInsertarDimensionNivel    'ST_CTE','Cliente Tipo','ClienteTipo','Cliente Tipo','Cliente Tipo',1
GO
EXEC spInsertarDimension   'ST_CTE','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel    'ST_CTE','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel    'ST_CTE','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension   'ST_CTE','Usuario','Normal','Usuario',1
EXEC spInsertarDimensionNivel    'ST_CTE','Usuario','Usuario','Usuario','Usuario',1
EXEC spInsertarDimensionNivel    'ST_CTE','Usuario','UsuarioNombre','Usuario Nombre','Usuario Nombre',2
EXEC spInsertarDimensionNivel    'ST_CTE','Usuario','UsuarioGrupoTrabajo','Usuario Grupo Trabajo','UsuarioGrupoTrabajo',3
GO
EXEC spInsertarDimension   'ST_CTE','Titulo','Normal','Titulo',1
EXEC spInsertarDimensionNivel    'ST_CTE','Titulo','Titulo','Titulo','Titulo',1
GO
EXEC spInsertarDimension   'ST_CTE','Elemento','Normal','Elemento',1
EXEC spInsertarDimensionNivel    'ST_CTE','Elemento','Elemento','Elemento','Elemento',1
GO
EXEC spInsertarDimension   'ST_CTE','SubModulo','Normal','SubModulo',1
EXEC spInsertarDimensionNivel    'ST_CTE','SubModulo','SubModulo','SubModulo','SubModulo',1
GO
EXEC spInsertarDimension   'ST_CTE','Medio','Normal','Medio',1
EXEC spInsertarDimensionNivel    'ST_CTE','Medio','Medio','Medio','Medio',1
GO
EXEC spInsertarDimension   'ST_CTE','Titulo','Normal','Titulo',1
EXEC spInsertarDimensionNivel    'ST_CTE','Titulo','Titulo','Titulo','Titulo',1
GO
EXEC spInsertarDimension   'ST_CTE','Referencia','Normal','Referencia',1
EXEC spInsertarDimensionNivel    'ST_CTE','Referencia','Referencia','Referencia','Referencia',1
GO
EXEC spInsertarDimension   'ST_CTE','Observaciones','Normal','Observaciones',1
EXEC spInsertarDimensionNivel    'ST_CTE','Observaciones','Observaciones','Observaciones','Observaciones',1
GO
EXEC spInsertarDimension   'ST_CTE','Problema','Normal','Problema',1
EXEC spInsertarDimensionNivel    'ST_CTE','Problema','Problema','Problema','Problema',1
GO
EXEC spInsertarDimension   'ST_CTE','Solucion','Normal','Solucion',1
EXEC spInsertarDimensionNivel    'ST_CTE','Solucion','Solucion','Solucion','Solucion',1
GO
EXEC spInsertarDimension   'ST_CTE','Comentarios','Normal','Comentarios',1
EXEC spInsertarDimensionNivel    'ST_CTE','Comentarios','Comentarios','Comentarios','Comentarios',1
GO
EXEC spInsertarDimension   'ST_CTE','situacion','Normal','situacion',1
EXEC spInsertarDimensionNivel    'ST_CTE','situacion','situacion','situacion','situacion',1
GO
EXEC spInsertarDimension   'ST_CTE','SituacionFecha','Normal','SituacionFecha',1
EXEC spInsertarDimensionNivel    'ST_CTE','SituacionFecha','SituacionFecha','SituacionFecha','SituacionFecha',1
GO
EXEC spInsertarDimension 'ST_CTE','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'ST_CTE','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'ST_CTE','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'ST_CTE','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'ST_CTE','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'ST_CTE','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'ST_CTE','Hora','Normal','Hora',1
EXEC spInsertarDimensionNivel  'ST_CTE','Hora','Hora','Hora','Hora',1
GO
EXEC spInsertarDimension 'ST_CTE','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'ST_CTE','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'ST_CTE','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'ST_CTE','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'ST_CTE','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'ST_CTE','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'ST_CTE','FechaInicio','Normal','FechaInicio',1
EXEC spInsertarDimensionNivel  'ST_CTE','FechaInicio','FechaInicio','FechaInicio','FechaInicio',1
GO
EXEC spInsertarDimension 'ST_CTE','FechaConclusion','Normal','FechaConclusion',1
EXEC spInsertarDimensionNivel  'ST_CTE','FechaConclusion','FechaConclusion','FechaConclusion','FechaConclusion',1
GO

--- Para ver los dias habiles
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_ST_DIAHABIL]'))
DROP VIEW Cubo_ST_DIAHABIL
GO
CREATE VIEW Cubo_ST_DIAHABIL
--//WITH ENCRYPTION
AS
SELECT ID,
	'DiasDescanso'	= (SELECT COUNT(*) 
				FROM TIEMPO 
					WHERE Fecha BETWEEN FECHAEMISION AND FECHACONCLUSION
						AND DATEPART(dw,Fecha) IN (1,7))
	FROM SOPORTE 
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_ST_CTE]'))
DROP VIEW Cubo_ST_CTE
GO
CREATE VIEW Cubo_ST_CTE
--//WITH ENCRYPTION
AS
SELECT 
  s.ID,
  'Sucursal' 			= S.Sucursal,
  'SucursalNombre'		= su.Nombre,  
  'SucursalRegion' 		= su.Region, 
  'Empresa' 			= s.Empresa,
  'EmpresaNombre'		= e.Nombre,  
  'EmpresaGrupo' 		= e.Grupo,
  s.Mov,
  s.MovID,
  s.UltimoCambio,
  s.Concepto,
  s.Proyecto,
  'Usuario'				= s.UsuarioResponsable,
  'UsuarioNombre' 		= u.Nombre,
  'UsuarioGrupoTrabajo' = u.GrupoTrabajo,
  s.Autorizacion,
  s.Referencia,
  s.Observaciones,
  s.Cliente,
  'ClienteNombre' 		= c.Nombre,
  'ClienteFamilia' 		= c.Familia,
  'ClienteCategoria' 	= c.Categoria,
  'ClienteGrupo' 		= c.Grupo,
  'ClienteTipo'			= c.Tipo,
  s.EnviarA,
  s.Agente,
  'AgenteNombre' 		= ag.Nombre,
  'AgenteCategoria' 	= ag.Categoria,
  'AgenteGrupo' 		= ag.Grupo,
  s.Estado,
  s.Contacto,
  s.UsuarioResponsable,
  s.Vencimiento,
  s.TieneContrato,
  s.PuedeDevolver,
  s.Prioridad,
  s.Clase,
  s.Subclase,
  s.situacion,
  s.SituacionFecha,
  'Problema'			= CONVERT(VARCHAR(100),s.Problema),
  'Solucion'			= CONVERT(VARCHAR(100),s.Solucion),
  'Comentarios'			= CONVERT(VARCHAR(100),s.Comentarios),
  s.TiempoUnidad,
  s.Importe,
  s.CondicionPago,
  s.CondicionEntrega,
  s.OrigenTipo,
  s.Origen,
  s.OrigenID,
  s.Poliza,
  s.PolizaID,
  s.GenerarPoliza,
  s.ContID,
  s.Ejercicio,
  s.Periodo,
  s.FechaRegistro,
 'TiempoDIAS' 			= DATEDIFF(DD,FECHAEMISION,FECHACONCLUSION) - ISNULL(DiasDescanso,0),
 'TiempoHORAS'			= DATEDIFF(HH,FECHAEMISION,FECHACONCLUSION),
  s.FechaEmision,
  'FechaInicio'			= s.FechaEmision,
  s.FechaConclusion,
  s.FechaCancelacion,
  s.Version,
  s.Proveedor,
  s.Personal,
  s.UEN,
  s.SubModulo,
  s.fuente,
  'FuenteNombre' 		= age.Nombre,
  'FuenteCategoria' 	= age.Categoria,
  'FuenteGrupo' 		= age.Grupo,
  s.Medio,
  s.Elemento,
  s.Titulo,
  'Estatus'				= s.Estatus,
  t.trimestre, 
  t.Semana,
  'Mes'					= t.MesNombre,
  'Año'					= t.Anio,
  'DiaSemana'			= t.DiaNombre,
  'Dia'					= CASE WHEN DATEPART(d, s.FechaEmision) < 10 
							   THEN '0' + CONVERT(CHAR(1),DATEPART(d, s.FechaEmision))
							   ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, s.FechaEmision))) END ,
  'Hora' 				= CASE  DATEPART(hour, s.FechaEmision) 
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
  'UENNombre'			= uen.Nombre,
  'Documentos'			= 1,
  'Antiguedad'			= CASE WHEN s.Estatus='PENDIENTE' 
							   THEN DATEDIFF(day, s.FechaEmision, GETDATE())
							   ELSE 0 END
FROM 
  Soporte s 

LEFT OUTER JOIN Empresa e 			ON s.Empresa  = e.Empresa 
LEFT OUTER JOIN Sucursal su 		ON s.Sucursal = su.Sucursal 
LEFT OUTER JOIN Cte c 				ON s.Cliente  = c.Cliente 
LEFT OUTER JOIN Agente ag 			ON s.Agente   = ag.Agente
LEFT OUTER JOIN Agente age 			ON s.Fuente   = age.Agente
LEFT OUTER JOIN UEN uen 			ON s.UEN      = uen.UEN
LEFT OUTER JOIN Usuario u 			ON s.UsuarioResponsable  = u.Usuario
LEFT OUTER JOIN tiempo t 			ON YEAR(s.FechaEmision)  = YEAR(t.fecha)
							AND MONTH(s.FechaEmision)= MONTH(t.fecha)
							AND DAY(s.FechaEmision)  = DAY(t.fecha)
LEFT OUTER JOIN Cubo_ST_DIAHABIL cdh 	ON s.ID  = cdh.ID
GO
