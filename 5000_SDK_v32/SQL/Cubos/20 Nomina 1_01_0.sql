/*'NOMINA*/ 
--- 1.0.1 Se agrego un store para obtener el id del empleado numerico 
--- 1.0.2 29-ENE-2004 Se agrego las quincenas (1/2)

--- STORE PARA CREAR TABLA DE Personal con ID NUMERICO PARA CONTABILIZARLO EN EL CUBO */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[CuboPERId]'))
	DROP TABLE [dbo].[CuboPERId]
GO		
	CREATE TABLE CuboPERId(
			PERid			INTEGER	IDENTITY,
			Personal			CHAR(10))
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id('[dbo].[spCuboPERId]'))
DROP PROCEDURE [dbo].[spCuboPERId]
GO

CREATE PROCEDURE spCuboPERId 
--//WITH ENCRYPTION
AS
	
	TRUNCATE TABLE 	CuboPERId
	INSERT CuboPERId
	SELECT Personal
	FROM   Personal
	
GO
EXEC spCuboPERId
GO
EXEC spInsertarStore 'NOM','spCuboPerId',1
EXEC spInsertarCubo 'NOM','Nomina','Cubo de Nomina','Cubo_NOM',0,1
GO
EXEC spInsertarMedida 'NOM','Percepciones','Percepciones','Percepciones','aggSum'
EXEC spInsertarMedida 'NOM','Deducciones','Deducciones','Deducciones','aggSum'
EXEC spInsertarMedida 'NOM','Importe','Importe','Importe','aggSum'
EXEC spInsertarMedida 'NOM','Estadistica','Estadistica','Estadistica','aggSum'
EXEC spInsertarMedida 'NOM','Cantidad','Cantidad','Cantidad','aggSum'
EXEC spInsertarMedida 'NOM','NoEmpleados','No Empleados','NoEmpleados','aggDistinctCount'
GO
EXEC spInsertarDimension 'NOM','Moneda','Normal','Moneda',1
EXEC spInsertarDimensionNivel  'NOM','Moneda','Moneda','Moneda','Moneda',1
GO
EXEC spInsertarDimension 'NOM','Mov','Normal','Mov',1
EXEC spInsertarDimensionNivel  'NOM','Mov','Mov','Mov','Movimiento',1
EXEC spInsertarDimensionNivel  'NOM','Mov','MovID','Consecutivo','Consecutivo',2
GO
EXEC spInsertarDimension 'NOM','Movimiento','Normal','Movimiento',1
EXEC spInsertarDimensionNivel  'NOM','Movimiento','Movimiento','Movimiento','Movimiento',1
GO
EXEC spInsertarDimension 'NOM','Ejercicio','Normal','Ejercicio',1
EXEC spInsertarDimensionNivel  'NOM','Ejercicio','Ejercicio','Ejercicio','Ejercicio',1
GO
EXEC spInsertarDimension 'NOM','Periodo','Normal','Periodo',1
EXEC spInsertarDimensionNivel  'NOM','Periodo','Periodo','Periodo','Periodo',1
GO
EXEC spInsertarDimension 'NOM','Condicion','Normal','Condicion',1
EXEC spInsertarDimensionNivel  'NOM','Condicion','Condicion','Condicion','Condicion',1
GO
EXEC spInsertarDimension 'NOM','Tipo Persona','Normal','Tipo Persona',0
EXEC spInsertarDimensionNivel  'NOM','Tipo Persona','TipoPersona','Tipo Persona','Tipo Persona',1
GO
EXEC spInsertarDimension 'NOM','Periodo Tipo','Normal','Periodo Tipo',1
EXEC spInsertarDimensionNivel  'NOM','Periodo Tipo','PeriodoTipo','Periodo Tipo','Periodo Tipo',1
GO
EXEC spInsertarDimension 'NOM','Sexo','Normal','Sexo',1
EXEC spInsertarDimensionNivel  'NOM','Sexo','Sexo','Sexo','Sexo',1
GO
EXEC spInsertarDimension 'NOM','Edad','Normal','Edad',1
EXEC spInsertarDimensionNivel  'NOM','Edad','Edad','Edad','Edad',1
GO
EXEC spInsertarDimension 'NOM','Antiguedad','Normal','Antiguedad',1
EXEC spInsertarDimensionNivel  'NOM','Antiguedad','Antiguedad','Antiguedad','Antiguedad',1
GO
EXEC spInsertarDimension 'NOM','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel  'NOM','Personal','Personal','Personal','Personal',1
EXEC spInsertarDimensionNivel  'NOM','Personal','PersonalNombre','Personal Nombre','Personal Nombre',2
GO
EXEC spInsertarDimension 'NOM','Concepto','Normal','Concepto',1
EXEC spInsertarDimensionNivel  'NOM','Concepto','Concepto','Concepto','Concepto',1
GO
EXEC spInsertarDimension 'NOM','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'NOM','Estatus','Estatus','Estatus','Estatus',1
EXEC spInsertarDimensionNivel  'NOM','Estatus','Situacion','Situacion','Situacion',2
GO
EXEC spInsertarDimension 'NOM','Fecha Emision','Tiempo','Fecha Emision',1
EXEC spInsertarDimensionNivel  'NOM','Fecha Emision','FechaEmision','Fecha Emision','FechaEmision',1
GO
EXEC spInsertarDimension 'NOM','Empresa','Normal','Empresa',1
EXEC spInsertarDimensionNivel  'NOM','Empresa','Empresa','Empresa','Empresa',1
EXEC spInsertarDimensionNivel  'NOM','Empresa','EmpresaNombre','Empresa Nombre','EmpresaNombre',2
EXEC spInsertarDimensionNivel  'NOM','Empresa','EmpresaGrupo','Empresa Grupo','Empresa Grupo',3
GO
EXEC spInsertarDimension 'NOM','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'NOM','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'NOM','Sucursal','SucursalNombre','Nombre','Nombre',2
EXEC spInsertarDimensionNivel  'NOM','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'NOM','Fecha Pago','Tiempo','FechaPago',1
EXEC spInsertarDimensionNivel  'NOM','Fecha Pago','FechaPago','Fecha Pago','FechaPago',1
GO
EXEC spInsertarDimension 'NOM','Fecha Alta','Tiempo','FechaAlta',1
EXEC spInsertarDimensionNivel  'NOM','Fecha Alta','FechaAlta','Fecha Alta','FechaAlta',1
GO
EXEC spInsertarDimension 'NOM','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'NOM','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'NOM','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'NOM','CentroCostos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel  'NOM','CentroCostos','CentroCostos','CentroCostos','CentroCostos',1
GO
EXEC spInsertarDimension 'NOM','Departamento','Normal','Departamento',1
EXEC spInsertarDimensionNivel  'NOM','Departamento','Departamento','Departamento','Departamento',1
GO
EXEC spInsertarDimension 'NOM','Puesto','Normal','Puesto',1
EXEC spInsertarDimensionNivel  'NOM','Puesto','Puesto','Puesto','Puesto',1
GO
EXEC spInsertarDimension 'NOM','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel  'NOM','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'NOM','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel  'NOM','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension 'NOM','Tipo Contrato','Normal','TipoContrato',1
EXEC spInsertarDimensionNivel  'NOM','Tipo Contrato','TipoContrato','TipoContrato','TipoContrato',1
GO
EXEC spInsertarDimension 'NOM','Estatus Personal','Normal','EstatusPersonal',1
EXEC spInsertarDimensionNivel  'NOM','Estatus Personal','EstatusPersonal','EstatusPersonal','EstatusPersonal',1
GO
EXEC spInsertarDimension 'NOM','CargaSocial','Normal','CargaSocial',1
EXEC spInsertarDimensionNivel  'NOM','CargaSocial','CargaSocial','CargaSocial','CargaSocial',1
GO
EXEC spInsertarDimension 'NOM','Cpto','Normal','Cpto',1
EXEC spInsertarDimensionNivel  'NOM','Cpto','Cpto','Cpto','Cpto',1
GO
EXEC spInsertarDimension 'NOM','Quincena','Normal','Quincena',1
EXEC spInsertarDimensionNivel  'NOM','Quincena','Quincena','Quincena','Quincena',1
GO
EXEC spInsertarDimension 'NOM','QuincenaMes','Normal','QuincenaMes',1
EXEC spInsertarDimensionNivel  'NOM','QuincenaMes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'NOM','QuincenaAño','Normal','QuincenaAño',1
EXEC spInsertarDimensionNivel  'NOM','QuincenaAño','Año','Año','Año',3
GO
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_NOM]'))
DROP VIEW Cubo_NOM
GO
CREATE VIEW Cubo_NOM
--//WITH ENCRYPTION
AS
SELECT 
  n.Id,
  'Sucursal' 		= n.Sucursal,
  'SucursalNombre'	= su.Nombre,
  'SucursalRegion' 	= su.Region, 
  'Empresa' 		= n.Empresa,
  'EmpresaNombre'	= e.Nombre,
  'EmpresaGrupo' 	= e.Grupo,
  n.Mov,
  n.MovID,
  n.FechaEmision,
  'Proyecto'		= CASE WHEN n.Proyecto IS NULL THEN 'Sin Proyecto' ELSE n.Proyecto END,
  n.Moneda,
  n.Estatus,
  n.Situacion,
  n.SituacionFecha,
  n.Ejercicio,
  n.Periodo,
  'FechaPago' 		= n.FechaA,
   n.Condicion,
  n.PeriodoTipo,
  'TipoPersona' 	= p.Tipo,
  'Personal' 		= d.Personal,
  'PersonalNombre' 	= RTRIM(p.Nombre) + ' ' + RTRIM(p.ApellidoPaterno) + ' ' +RTRIM(ApellidoMaterno),
  'Edad' 		= CASE WHEN DATEDIFF(yy,p.FechaNacimiento,GETDATE()) < 10
				THEN '0' + CONVERT(CHAR(1),DATEDIFF(yy,p.FechaNacimiento,GETDATE()))
				ELSE CONVERT(CHAR(2),DATEDIFF(yy,p.FechaNacimiento,GETDATE())) END,
  'Antiguedad'		= CASE WHEN DATEDIFF(yy,p.FechaAntiguedad,GETDATE()) < 10
				THEN '0' + CONVERT(CHAR(1),DATEDIFF(yy,p.FechaAntiguedad,GETDATE()))
				ELSE CONVERT(CHAR(2),DATEDIFF(yy,p.FechaAntiguedad,GETDATE())) END,
  p.Sexo,
  p.CentroCostos,
  p.Departamento,
  p.Puesto,
  p.Categoria,
  p.Grupo,
  p.TipoContrato,
  p.FechaAlta,
  d.Cuenta,
  'Cantidad'		= ISNULL(d.Cantidad,0),		
  d.Concepto,
  'Cpto'		= n.Concepto,
  d.FormaPago,
  d.Porcentaje,
  'Movimiento'		= CASE WHEN d.Movimiento IS NULL THEN 'Sin Mov' ELSE d.Movimiento END,
  p.UEN,
  'UENNombre'		= uen.Nombre,
  t.trimestre,
  t.Semana,
  'Mes'			= t.MesNombre,
  'DiaSemana'		= t.DiaNombre,
  'Año'			= YEAR(n.FechaEmision),
  'Quincena'		= CASE WHEN DATEPART(d, n.FechaD) < 16 THEN 1 ELSE 2 END,
  'Dia'			= CASE WHEN DATEPART(d, n.FechaD) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, n.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, n.FechaEmision))) END ,
  'CargaSocial'		= CASE WHEN d.concepto in('Crédito Infonavir','Imss Patron','Patron CV','Patron Retiro','Infonavit','ISCAS') 
				THEN 'SI'
				ELSE 'NO' END,
  'Deducciones' 	= CASE WHEN d.movimiento = 'Deduccion' 	THEN d.Importe ELSE 0 END,
  'Percepciones' 	= CASE WHEN d.movimiento = 'Percepcion' 	THEN d.Importe ELSE 0 END,
  'Estadistica' 		= CASE WHEN d.movimiento = 'Estadistica'	THEN d.Importe ELSE 0 END,
  'NoEmpleados'	= CONVERT(INT,cp.PERID),
  'Importe' 		= ISNULL(d.Importe,0),
  'Saldo'		= ISNULL(d.Saldo,0),
  'EstatusPersonal'	= p.Estatus
FROM 
  NOMINA n

	LEFT OUTER JOIN  NOMINAD d 	ON n.ID		= d.ID
	LEFT OUTER JOIN  Personal p 	ON d.Personal 	= p.Personal
	LEFT OUTER JOIN	 CuboPERId cp	ON d.Personal 	= cp.Personal
	LEFT OUTER JOIN  Empresa e 	ON n.Empresa 	= e.Empresa 
	LEFT OUTER JOIN  Sucursal su	ON n.Sucursal	= su.Sucursal
	LEFT OUTER JOIN  Tiempo t 	ON n.FechaEmision = t.Fecha
	LEFT OUTER JOIN  UEN uen	ON p.UEN 	= uen.UEN

GO


