EXEC spLimpiarCubo   'EVAMES'
EXEC spInsertarCubo 'EVAMES','Evaluación Cuentas','Cubo de Evaluación Cuentas','Cubo_EVAMES',0,1
GO
EXEC spInsertarMedida  'EVAMES','Evaluacion','Evaluacion','Evaluacion','aggSum'
EXEC spInsertarMedida  'EVAMES','Calificacion','Calificacion','Calificacion','aggSum'
EXEC spInsertarMedida  'EVAMES','Peso','Peso','Peso','aggSum'
EXEC spInsertarMedida  'EVAMES','Visitas','Visitas','Visitas','aggSum'
GO
EXEC spInsertarFormula 'EVAMES','Promedio','Promedio','[Measures].[Evaluacion]/[Measures].[Visitas]',1
GO
EXEC spInsertarDimension   'EVAMES','EvaluacionNombre','Normal','EvaluacionNombre',1
EXEC spInsertarDimensionNivel    'EVAMES','EvaluacionNombre','EvaluacionNombre','EvaluacionNombre','EvaluacionNombre',1
GO
EXEC spInsertarDimension   'EVAMES','Punto','Normal','Punto',1
EXEC spInsertarDimensionNivel    'EVAMES','Punto','Punto','Punto','Punto',1
GO
EXEC spInsertarDimension   'EVAMES','ID','Normal','ID',1
EXEC spInsertarDimensionNivel    'EVAMES','ID','ID','ID','ID',1
GO
EXEC spInsertarDimension   'EVAMES','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel    'EVAMES','Personal','Nombre','Nombre','Nombre',1
EXEC spInsertarDimensionNivel    'EVAMES','Personal','Personal','Personal','Personal',2
GO
EXEC spInsertarDimension   'EVAMES','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel    'EVAMES','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension   'EVAMES','ClienteNombre','Normal','ClienteNombre',1
EXEC spInsertarDimensionNivel    'EVAMES','ClienteNombre','ClienteNombre','ClienteNombre','ClienteNombre',1
GO
EXEC spInsertarDimension   'EVAMES','ClienteSituacion','Normal','ClienteSituacion',1
EXEC spInsertarDimensionNivel    'EVAMES','ClienteSituacion','ClienteSituacion','ClienteSituacion','ClienteSituacion',1
GO
EXEC spInsertarDimension   'EVAMES','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel    'EVAMES','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension   'EVAMES','Año','Normal','Año',1
EXEC spInsertarDimensionNivel    'EVAMES','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension   'EVAMES','FechaEmision','Tiempo','FechaEmision',1
EXEC spInsertarDimensionNivel    'EVAMES','FechaEmision','FechaEmision','FechaEmision','FechaEmision',1
GO
EXEC spInsertarDimension   'EVAMES','Puesto','Normal','Puesto',1
EXEC spInsertarDimensionNivel    'EVAMES','Puesto','Puesto','Puesto','Puesto',1
GO
EXEC spInsertarDimension   'EVAMES','Departamento','Normal','Departamento',1
EXEC spInsertarDimensionNivel    'EVAMES','Departamento','Departamento','Departamento','Departamento',1
GO
EXEC spInsertarDimension   'EVAMES','CentroCostos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel    'EVAMES','CentroCostos','CentroCostos','CentroCostos','CentroCostos',1
GO
EXEC spInsertarDimension   'EVAMES','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel    'EVAMES','UEN','UEN','UEN','UEN',1
GO
EXEC spInsertarDimension   'EVAMES','Area','Normal','Area',1
EXEC spInsertarDimensionNivel    'EVAMES','Area','Area','Area','Area',1
GO
EXEC spInsertarDimension   'EVAMES','Plaza','Normal','Plaza',1
EXEC spInsertarDimensionNivel    'EVAMES','Plaza','Plaza','Plaza','Plaza',1
GO
EXEC spInsertarDimension   'EVAMES','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel    'EVAMES','Sucursal','Sucursal','Sucursal','Sucursal',1
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EvaluacionctoMes]'))
DROP VIEW Cubo_EvaluacionctoMes
GO
CREATE VIEW Cubo_EvaluacionctoMes
--//WITH ENCRYPTION
AS
SELECT Evaluacion,Contacto,
	Fecha ,
	COUNT(*) 'Preguntas'
FROM Evaluacioncto 
WHERE SUBSTRING(Contacto,1,2) <> 'ST'
AND calificacion IS NOT NULL
GROUP BY Evaluacion,Contacto,Fecha
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EVAMES]'))
DROP VIEW Cubo_EVAMES
GO
CREATE VIEW Cubo_EVAMES
--//WITH ENCRYPTION
AS
SELECT  'ID'		= ec.Contacto,
	'EvaluacionNombre' 	= ec.Evaluacion, 
	ec.Punto ,  
	'Personal'		= p.Personal,
	'Nombre'		= RTRIM(p.Nombre) + ' ' + RTRIM(ApellidoPaterno)  + ' ' + RTRIM(ApellidoMaterno),
	ec.Calificacion,
	ef.Peso,
	'Evaluacion'		= CONVERT(DECIMAL(12,2),(ec.Calificacion * ef.Peso) / 100.00) ,
	'Cliente'		= NULL,
	'ClienteNombre'		= NULL,
	'ClienteSituacion' 	= NULL,
	'FechaEmision'		= ec.Fecha,
	'Año'			= t.anio,
	'Mes'			= t.MesNombre,
	'Semana'		= t.Semana,
	'DiaSemana'		= t.DiaNombre,
	ce.Preguntas,
	'Visitas'		= 1.00/ce.Preguntas,
	'Tipo'			= 'Personal',
	p.Puesto,
	'Departamento'		= p.departamento,
	'CentroCostos'		= p.centrocostos, 
	'UEN'			= u.nombre,
	'Area'			= p.area,
	'Plaza'			= pza.descripcion,
	'Sucursal'		=S.nombre
FROM Evaluacioncto ec
LEFT OUTER JOIN Evaluacion eva			ON ec.Evaluacion	= eva.Evaluacion
LEFT OUTER JOIN Personal p 			ON ec.Contacto		= p.Personal
LEFT OUTER JOIN EvaluacionFormato ef 		ON ec.Evaluacion 	= ef.Evaluacion
							AND ec.Punto		= ef.Punto
LEFT OUTER JOIN Tiempo t 			ON ec.Fecha		= t.Fecha
LEFT OUTER JOIN Cubo_EvaluacionctoMes ce	ON ce.Contacto		= ec.Contacto 
							AND ce.Evaluacion	= ec.Evaluacion 	
							AND ce.Fecha		= ec.Fecha
LEFT OUTER JOIN UEN U				ON p.uen = u.uen
LEFT OUTER JOIN Plaza Pza			ON p.plaza = pza.plaza
LEFT OUTER JOIN Sucursal S			ON pza.sucursal = S.sucursal
WHERE eva.Aplica = 'Personal' AND EC.calificacion IS NOT NULL

UNION
SELECT  'ID'			= ec.Contacto,
	'EvaluacionNombre' 	= ec.Evaluacion, 
	ec.Punto ,  
	'Personal'		= p.Cliente,
	'Nombre'		= NULL ,
	ec.Calificacion,
	ef.Peso,
	'Evaluacion'		= CONVERT(DECIMAL(12,2),(ec.Calificacion * ISNULL(ef.Peso,1) / 100.00)) ,
	'Cliente'		= p.Cliente,
	'ClienteNombre'		= p.Nombre,
	'ClienteSituacion' 	= p.Situacion,
	'FechaEmision'		= ec.Fecha,
	'Año'			= t.anio,
	'Mes'			= t.MesNombre,
	'Semana'		= t.Semana,
	'DiaSemana'		= t.DiaNombre,
	ce.Preguntas,
	'Visitas'		= 1.00/ce.Preguntas,
	'tipo'			= 'Clientes',
	'Puesto'		= NULL,
	'Departamento'		= NULL,
	'CentroCostos'		= NULL, 
	'UEN'			= NULL,
	'Area'			= NULL,
	'Plaza'			= NULL,
	'Sucursal'		= NULL

FROM Evaluacioncto ec
LEFT OUTER JOIN Evaluacion eva			ON ec.Evaluacion	= eva.Evaluacion
LEFT OUTER JOIN Cte p 				ON ec.Contacto		= p.Cliente
LEFT OUTER JOIN EvaluacionFormato ef 		ON ec.Evaluacion 	= ef.Evaluacion
							AND ec.Punto		= ef.Punto
LEFT OUTER JOIN Tiempo t 			ON ec.Fecha		= t.Fecha
LEFT OUTER JOIN Cubo_EvaluacionctoMes ce	ON ce.Contacto		= ec.Contacto 
							AND ce.Evaluacion	= ec.Evaluacion 	
							AND ce.Fecha		= ec.Fecha
WHERE eva.Aplica = 'Clientes'
GO