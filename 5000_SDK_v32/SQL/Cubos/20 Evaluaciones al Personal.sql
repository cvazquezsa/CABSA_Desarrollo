EXEC spLimpiarCubo   'EVA'
EXEC spInsertarCubo 'EVA','Evaluación de personal','Cubo de Evaluación de Personal','Cubo_EVA',0,1
GO
EXEC spInsertarMedida  'EVA','Evaluacion','Evaluacion','Evaluacion','aggSum'
EXEC spInsertarMedida  'EVA','Calificacion','Calificacion','Calificacion','aggSum'
EXEC spInsertarMedida  'EVA','Peso','Peso','Peso','aggSum'
EXEC spInsertarMedida  'EVA','Registros','Registros','Registros','aggSum'
EXEC spInsertarMedida  'EVA','Visitas','Visitas','Visitas','aggSum'
GO
EXEC spInsertarFormula 'EVA','Promedio','Promedio','[Measures].[Evaluacion]/[Measures].[Registros]',1
GO
EXEC spInsertarDimension   'EVA','EvaluacionNombre','Normal','EvaluacionNombre',1
EXEC spInsertarDimensionNivel    'EVA','EvaluacionNombre','EvaluacionNombre','EvaluacionNombre','EvaluacionNombre',1
GO
EXEC spInsertarDimension   'EVA','Punto','Normal','Punto',1
EXEC spInsertarDimensionNivel    'EVA','Punto','Punto','Punto','Punto',1
GO
EXEC spInsertarDimension   'EVA','ID','Normal','ID',1
EXEC spInsertarDimensionNivel    'EVA','ID','ID','ID','ID',1
GO
EXEC spInsertarDimension   'EVA','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel    'EVA','Personal','Personal','Personal','Personal',1
EXEC spInsertarDimensionNivel    'EVA','Personal','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension   'EVA','Cliente','Normal','Cliente',1
EXEC spInsertarDimensionNivel    'EVA','Cliente','Cliente','Cliente','Cliente',1
GO
EXEC spInsertarDimension   'EVA','ClienteNombre','Normal','ClienteNombre',1
EXEC spInsertarDimensionNivel    'EVA','ClienteNombre','ClienteNombre','ClienteNombre','ClienteNombre',1
GO
EXEC spInsertarDimension   'EVA','ClienteSituacion','Normal','ClienteSituacion',1
EXEC spInsertarDimensionNivel    'EVA','ClienteSituacion','ClienteSituacion','ClienteSituacion','ClienteSituacion',1
GO
EXEC spInsertarDimension   'EVA','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel    'EVA','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension   'EVA','Año','Normal','Año',1
EXEC spInsertarDimensionNivel    'EVA','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension   'EVA','FechaEmision','Tiempo','FechaEmision',1
EXEC spInsertarDimensionNivel    'EVA','FechaEmision','FechaEmision','FechaEmision','FechaEmision',1
GO
EXEC spInsertarDimension   'EVA','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel    'EVA','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension   'EVA','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel    'EVA','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension   'EVA','ProyCategoria','Normal','ProyCategoria',1
EXEC spInsertarDimensionNivel    'EVA','ProyCategoria','ProyCategoria','ProyCategoria','ProyCategoria',1
GO
EXEC spInsertarDimension   'EVA','ProySituacion','Normal','ProySituacion',1
EXEC spInsertarDimensionNivel    'EVA','ProySituacion','ProySituacion','ProySituacion','ProySituacion',1
GO
EXEC spInsertarDimension   'EVA','Agente','Normal','Agente',1
EXEC spInsertarDimensionNivel    'EVA','Agente','Agente','Agente','Agente',1
EXEC spInsertarDimensionNivel    'EVA','Agente','AgenteNombre','AgenteNombre','AgenteNombre',2
GO
EXEC spInsertarDimension   'EVA','Proveedor','Normal','Proveedor',1
EXEC spInsertarDimensionNivel    'EVA','Proveedor','Proveedor','Proveedor','Proveedor',1
EXEC spInsertarDimensionNivel    'EVA','Proveedor','ProveedorNombre','ProveedorNombre','ProveedorNombre',2
GO
EXEC spInsertarDimension   'EVA','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel    'EVA','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension   'EVA','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel    'EVA','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension   'EVA','CentroCostos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel    'EVA','CentroCostos','CentroCostos','CentroCostos','CentroCostos',1
GO
EXEC spInsertarDimension   'EVA','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel    'EVA','UEN','UenID','UenID','UenID',1
EXEC spInsertarDimensionNivel    'EVA','UEN','UenNombre','UenNombre','UenNombre',2
GO
EXEC spInsertarDimension   'EVA','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel    'EVA','Sucursal','SucursalID','SucursalID','SucursalID',1
EXEC spInsertarDimensionNivel    'EVA','Sucursal','SucursalNombre','SucursalNombre','SucursalNombre',2
GO
EXEC spInsertarDimension   'EVA','CatPersonal','Normal','CatPersonal',1
EXEC spInsertarDimensionNivel    'EVA','CatPersonal','CatPersonal','CatPersonal','CatPersonal',1
EXEC spInsertarDimensionNivel    'EVA','CatPersonal','CatNombre','CatNombre','CatNombre',2

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_Evaluacioncto]'))
DROP VIEW Cubo_Evaluacioncto
GO
CREATE VIEW Cubo_Evaluacioncto
--//WITH ENCRYPTION
AS
SELECT Evaluacion,Contacto,COUNT(*) 'Preguntas'
FROM Evaluacioncto 
WHERE SUBSTRING(Contacto,1,2) = 'ST'
GROUP BY Evaluacion,Contacto
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EvaluacionPer]'))
DROP VIEW Cubo_EvaluacionPer
GO
CREATE VIEW Cubo_EvaluacionPer
--//WITH ENCRYPTION
AS
SELECT Evaluacion,Fecha,Contacto,COUNT(*) 'Preguntas'
FROM Evaluacioncto c
	JOIN Personal p ON c.Contacto = p.Personal
GROUP BY Evaluacion, Fecha, Contacto
GO

IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_EVA]'))
DROP TABLE Cubo_EVA
GO
CREATE TABLE Cubo_EVA
(
	ID			varchar(50) NULL, 
	EvaluacionNombre	varchar(50) NULL,
	Punto			varchar(100) NULL,
	Personal		char(10) NULL,
	Nombre			varchar(100) NULL,
	Calificacion		float NULL,
	Peso			float NULL,
	Evaluacion		float NULL, 
	Cliente			char(10) NULL, 
	ClienteNombre		varchar(100) NULL,
	ClienteSituacion	varchar(50) NULL,
	FechaEmision		datetime NULL,
	Año			smallint NULL,
	Mes			varchar(30) NULL,
	Semana			varchar(50) NULL,
	DiaSemana		varchar(30) NULL,
	Preguntas		float NULL,
	Registros		float NULL,
	Visitas			float NULL, 
	Categoria		varchar(50) NULL,
	Proyecto		varchar(50) NULL,
	ProyCategoria		varchar(50) NULL,
	ProySituacion		varchar(50) NULL,
	Agente			char(10) NULL,
	AgenteNombre		varchar(100) NULL,
	Proveedor		char(10) NULL,
	ProveedorNombre		varchar(100) NULL,
	Concepto		varchar(50) NULL,
	Estatus		        varchar(15) NULL,
	UenID		 	varchar(10) NULL,
	UenNombre		varchar(50) NULL,
	SucursalId		varchar(10) NULL,
	SucursalNombre		varchar(50) NULL,
	CatPersonal		char(10) NULL,
	CatNombre		varchar(100) NULL,
	CentroCostos		varchar(20) NULL)
GO

--- EXEC spCubo_Eva
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spCubo_Eva]'))
DROP PROCEDURE spCubo_Eva
go
CREATE PROCEDURE spCubo_Eva
--//WITH ENCRYPTION
AS
BEGIN

TRUNCATE TABLE CUBO_EVA
SET ANSI_WARNINGS OFF
INSERT INTO CUBO_EVA

SELECT	RTRIM(s.Mov) + ' ' + RTRIM(s.MovID) AS ID, 
	ec.Evaluacion AS EvaluacionNombre, 
	ec.Punto, 
	p.Agente AS Personal, 
	p.Nombre, 
        ec.Calificacion, 
	ef.Peso, 
	CONVERT(MONEY, ROUND(ec.Calificacion * ef.Peso / 100.00, 2)) AS Evaluacion, 
	s.Cliente, 
        c.Nombre AS ClienteNombre, 
	c.Situacion AS ClienteSituacion, 
	s.FechaEmision, 
	t.Anio AS Año, 
	t.MesNombre AS Mes, 
        t.Semana, 
	t.DiaNombre AS DiaSemana, 
	ce.Preguntas, 
	1.00 / ce.Preguntas AS Registros, 
        CASE WHEN ec.Evaluacion = 'VisitaPeriodica' 
		THEN (1.00 / ce.Preguntas) * 5 
		ELSE 1.00 / ce.Preguntas END AS Visitas, 
	c.Categoria, 
        s.Proyecto, 
	py.Categoria AS ProyCategoria, 
	py.Situacion AS ProySituacion, 
	ag.Agente, 
	ag.Nombre AS AgenteNombre, 
        pv.Proveedor, 
	pv.Nombre AS ProveedorNombre, 
	s.Concepto, 
	s.Estatus, 
	s.UEN AS UenID, 
        u.Nombre AS UenNombre, 
	s.Sucursal AS SucursalId, 
	suc.Nombre AS SucursalNombre, 
	per.Personal AS CatPersonal, 
        per.Nombre + ' ' + per.ApellidoPaterno + ' ' + per.ApellidoMaterno AS CatNombre,
	per.CentroCostos
FROM    EvaluacionCto ec 
	LEFT OUTER JOIN Soporte s ON ec.Modulo = 'ST' AND s.ID = ec.ModuloID 
	LEFT OUTER JOIN Agente p ON s.Agente = p.Agente 
	LEFT OUTER JOIN Personal per ON s.Personal = per.Personal 
	LEFT OUTER JOIN Sucursal suc ON s.Sucursal = suc.Sucursal 
	LEFT OUTER JOIN UEN u ON s.UEN = u.UEN 
	LEFT OUTER JOIN Proy py ON py.Proyecto = s.Proyecto 
	LEFT OUTER JOIN Cte c ON s.Cliente = c.Cliente AND s.Cliente IS NOT NULL 
	LEFT OUTER JOIN Agente ag ON c.Agente = ag.Agente 
	LEFT OUTER JOIN Prov pv ON s.Proveedor = pv.Proveedor AND s.Proveedor IS NOT NULL 
	LEFT OUTER JOIN EvaluacionCalificacion en ON ec.Evaluacion = en.Evaluacion AND ec.Contacto = en.Contacto AND ec.Fecha = en.Fecha 
	LEFT OUTER JOIN EvaluacionFormato ef ON ec.Evaluacion = ef.Evaluacion AND ec.Punto = ef.Punto 
	LEFT OUTER JOIN Tiempo t ON en.Fecha = t.Fecha 
	LEFT OUTER JOIN Cubo_Evaluacioncto ce ON ce.Contacto = ec.Contacto AND ce.Evaluacion = ec.Evaluacion
WHERE   (SUBSTRING(ec.Contacto, 1, 2) = 'ST') AND (s.Estatus IN ('CONCLUIDO', 'PENDIENTE')) AND (en.Estatus IN ('CONCLUIDO', 'PENDIENTE'))
UNION
SELECT	ec.Contacto AS ID, 
	ec.Evaluacion AS EvaluacionNombre, 
	ec.Punto, 
	p.Personal, 
	RTRIM(p.Nombre) + ' ' + RTRIM(p.ApellidoPaterno) + ' ' + RTRIM(p.ApellidoMaterno) AS Nombre, 
	ec.Calificacion, 
	ef.Peso, 
	ROUND(ec.Calificacion * ef.Peso / 100.00, 2) AS Evaluacion, 
	NULL AS Cliente, 
	NULL AS ClienteNombre, 
	NULL AS ClienteSituacion, 
	en.Fecha AS FechaEmision, 
	t.Anio AS Año, 
	t.MesNombre AS Mes, 
	t.Semana,
        t.DiaNombre AS DiaSemana, 
	ce.Preguntas, 1.00 / ce.Preguntas AS Registros, 
	1.00 / ce.Preguntas AS Visitas, 
	p.Categoria, 
	NULL AS Proyecto, 
	NULL AS ProyCategoria, 
	NULL AS ProySituacion, 
	NULL AS Agente, 
	NULL AS AgenteNombre, 
	NULL AS Proveedor, 
	NULL AS ProveedorNombre, 
	NULL AS Concepto, 
	NULL AS Estatus, 
	s.UEN AS UenID, 
	u.Nombre AS UenNombre, 
	s.Sucursal AS SucursalId, 
        suc.Nombre AS SucursalNombre, 
	p.Personal AS CatPersonal, 
	p.Nombre + ' ' + p.ApellidoPaterno + ' ' + p.ApellidoMaterno AS CatNombre,
	p.CentroCostos
FROM    EvaluacionCto ec 
	LEFT OUTER JOIN Soporte s ON ec.Modulo = 'ST' AND s.ID = ec.ModuloID 
	LEFT OUTER JOIN Sucursal suc ON s.Sucursal = suc.Sucursal 
	LEFT OUTER JOIN UEN u ON s.UEN = u.UEN 
	LEFT OUTER JOIN Personal p ON ec.Contacto = p.Personal 
	LEFT OUTER JOIN EvaluacionCalificacion en ON ec.Evaluacion = en.Evaluacion AND ec.Contacto = en.Contacto AND ec.Fecha = en.Fecha 
	LEFT OUTER JOIN EvaluacionFormato ef ON ec.Evaluacion = ef.Evaluacion AND ec.Punto = ef.Punto 
	LEFT OUTER JOIN Tiempo t ON en.Fecha = t.Fecha 
	LEFT OUTER JOIN Cubo_EvaluacionPer ce ON ce.Contacto = ec.Contacto AND ce.Evaluacion = ec.Evaluacion AND ce.Fecha = ec.Fecha
WHERE   (SUBSTRING(ec.Contacto, 1, 2) <> 'ST') AND (en.Estatus IN ('CONCLUIDO', 'PENDIENTE')) AND (YEAR(en.Fecha) > 2005)
END
GO