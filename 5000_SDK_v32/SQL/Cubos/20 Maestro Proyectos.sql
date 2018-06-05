/* Maestro de proyecto */
EXEC spInsertarCubo  'MPROY','Maestro Proyectos','Cubo de Maestro de Proyectos','Cubo_MPROY',0,1
GO
EXEC spInsertarMedida 'MPROY','NoPersonas','NoPersonas','NoPersonas','aggSum'
GO
EXEC spInsertarDimension 'MPROY','Proyecto Categoria','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'MPROY','Proyecto Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'MPROY','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'MPROY','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'MPROY','Proyecto Estatus','Normal','Proyecto Estatus',1
EXEC spInsertarDimensionNivel  'MPROY','Proyecto Estatus','Estatus','Proyecto Estatus','Proyecto Estatus',1
GO
EXEC spInsertarDimension 'MPROY','FechaInicio','Tiempo','FechaInicio',1
EXEC spInsertarDimensionNivel  'MPROY','FechaInicio','FechaInicio','FechaInicio','FechaInicio',1
GO
EXEC spInsertarDimension 'MPROY','FechaFin','Tiempo','FechaFin',1
EXEC spInsertarDimensionNivel  'MPROY','FechaFin','FechaFin','FechaFin','FechaFin',1
GO
EXEC spInsertarDimension 'MPROY','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel  'MPROY','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'MPROY','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel  'MPROY','Personal','Personal','Personal','Personal',1
EXEC spInsertarDimensionNivel  'MPROY','Personal','PersonalNombre','Personal Nombre','Personal Nombre',2
GO
EXEC spInsertarDimension 'MPROY','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel  'MPROY','Cliente','Cliente','Cliente','Cliente',1
EXEC spInsertarDimensionNivel  'MPROY','Cliente','ClienteNombre','Cliente Nombre','Cliente Nombre',2
GO
EXEC spInsertarDimension 'MPROY','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel  'MPROY','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel  'MPROY','Proveedor','ProveedorNombre','Proveedor Nombre','Proveedor Nombre',2
GO
EXEC spInsertarDimension 'MPROY','Estatus Personal','Normal','Estatus Personal ',1
EXEC spInsertarDimensionNivel  'MPROY','Estatus Personal','EstatusPersonal','EstatusPersonal','Estatus Personal',1
GO
EXEC spInsertarDimension 'MPROY','FechaInicioPersonal','Normal','FechaInicioPersonal',1
EXEC spInsertarDimensionNivel  'MPROY','FechaInicioPersonal','FechaInicioPersonal','FechaInicioPersonal','FechaInicioPersonal',1
GO
EXEC spInsertarDimension 'MPROY','FechaFinPersonal','Normal','FechaFinPersonal',1
EXEC spInsertarDimensionNivel  'MPROY','FechaFinPersonal','FechaFinPersonal','FechaFinPersonal','FechaFinPersonal',1
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_MPROY]'))
DROP VIEW Cubo_MPROY
GO
CREATE VIEW Cubo_MPROY
--//WITH ENCRYPTION
AS
SELECT 
	p.Proyecto,
	p.Categoria,
	p.Estatus,
	p.FechaInicio,
	p.FechaFin,
	p.Situacion,
	p.SituacionFecha,
	pe.Personal,
	'PersonalNombre'	= RTRIM(ApellidoPaterno) + ' ' + RTRIM(ApellidoMaterno) + ' ' + RTRIM(pe.Nombre),
	pd.Cliente,
	'ClienteNombre'		= cte.Nombre,
	pd.Proveedor,
	'ProveedorNombre'	= pv.Nombre,
	pd.Agente,
	'NombreAgente'		= ag.Nombre,
	'EstatusPersonal'	= pd.Estatus,
	'FechaInicioPersonal'	= pd.FechaInicio,
	'FechaFinPersonal'	= pd.FechaFin,
	'NoPersonas'		= CASE WHEN pe.Personal IS NULL THEN 0 ELSE 1 END
FROM	Proy p
LEFT OUTER JOIN Proyd  pd     	ON p.Proyecto  	 = pd.Proyecto
LEFT OUTER JOIN Cte  cte     	ON pd.Cliente  	 = cte.cliente
LEFT OUTER JOIN Personal  pe   	ON pd.Personal   = pe.Personal
LEFT OUTER JOIN Agente  ag     	ON pd.Agente  	 = ag.Agente
LEFT OUTER JOIN Prov  pv     	ON pd.Proveedor  = pv.Proveedor
GO


