/*PERSONAL*/
/*	Se le agrego la línea spLimpiarCubo		Víctor Gutiérrez Méndez*/
EXEC spLimpiarCubo 'PER'
EXEC spInsertarCubo 'PER','Maestro de Personal','Cubo de Personal','Cubo_PER',0,1
GO
EXEC spInsertarMedida 'PER','SueldoDiario','Sueldo Diario','Sueldo Diario','aggSum'
EXEC spInsertarMedida 'PER','SDI','Sueldo Diario Integrado','Sueldo Diario Integrado','aggSum'
EXEC spInsertarMedida 'PER','NoPersonas','Personas','Numero de personas','aggSum'
EXEC spInsertarMedida 'PER','Sueldo','Sueldo','Sueldo','aggSum'
/*	Se le agregaron las medidas MesesTrabajados y SueldoMensualBruto		Víctor Gutiérrez Méndez*/
EXEC spInsertarMedida 'PER','MesesTrabajados','MesesTrabajados','MesesTrabajados','aggSum'
EXEC spInsertarMedida 'PER','SueldoMensualBruto','SueldoMensualBruto','SueldoMensualBruto','aggSum'
GO
EXEC spInsertarFormula 'PER','Promedio Sueldo','Promedio Sueldo','[Measures].[Sueldo Diario]/[Measures].[Personas]',1
EXEC spInsertarFormula 'PER','Promedio SDI','Promedio SDI','[Measures].[Sueldo Diario Integrado]/[Measures].[Personas]',1
GO
EXEC spInsertarDimension 'PER','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel  'PER','Personal','Personal','Personal','Personal',1
EXEC spInsertarDimensionNivel  'PER','Personal','Nombre','Nombre','Nombre',2
GO
EXEC spInsertarDimension 'PER','Tipo','Normal','Tipo',1
EXEC spInsertarDimensionNivel  'PER','Tipo','Tipo','Tipo','Tipo',1
GO
EXEC spInsertarDimension 'PER','Domicilio','Normal','Domicilio',1
EXEC spInsertarDimensionNivel  'PER','Domicilio','Colonia','Colonia','Colonia',1
EXEC spInsertarDimensionNivel  'PER','Domicilio','Delegacion','Delegacion','Delegacion',2
EXEC spInsertarDimensionNivel  'PER','Domicilio','Poblacion','Poblacion','Poblacion',3
EXEC spInsertarDimensionNivel  'PER','Domicilio','Estado','Estado','Estado',4
EXEC spInsertarDimensionNivel  'PER','Domicilio','Pais','Pais','Pais',5
GO
EXEC spInsertarDimension 'PER','Zona Economica','Normal','Zona Economica',1
EXEC spInsertarDimensionNivel  'PER','Zona Economica','ZonaEconomica','Zona Economica','Zona Economica',1
GO
EXEC spInsertarDimension 'PER','Cuenta Dinero','Normal','Cuenta Dinero',1
EXEC spInsertarDimensionNivel  'PER','Cuenta Dinero','Descripcion','Descripcion','Descripcion',1
GO
EXEC spInsertarDimension 'PER','Edad','Normal','Edad',1
EXEC spInsertarDimensionNivel  'PER','Edad','Edad','Edad','Edad',1
GO
EXEC spInsertarDimension 'PER','Antiguedad','Normal','Antiguedad',1
EXEC spInsertarDimensionNivel  'PER','Antiguedad','Antiguedad','Antiguedad','Antiguedad',1
GO
EXEC spInsertarDimension 'PER','Nacionalidad','Normal','Nacionalidad',1
EXEC spInsertarDimensionNivel  'PER','Nacionalidad','Nacionalidad','Nacionalidad','Nacionalidad',1
GO
EXEC spInsertarDimension 'PER','Fecha Alta','Tiempo','Fecha Alta',1
EXEC spInsertarDimensionNivel  'PER','Fecha Alta','FechaAlta','Fecha Alta','Fecha Alta',1
GO
EXEC spInsertarDimension 'PER','Fecha Baja','Tiempo','Fecha Baja',1
EXEC spInsertarDimensionNivel  'PER','Fecha Baja','FechaBaja','Fecha Baja','Fecha Baja',1
GO
EXEC spInsertarDimension 'PER','Fecha Antiguedad','Tiempo','Fecha Antiguedad',1
EXEC spInsertarDimensionNivel  'PER','Fecha Antiguedad','FechaAntiguedad','Fecha Antiguedad','Fecha Antiguedad',1
GO
EXEC spInsertarDimension 'PER','Vencimiento Contrato','Tiempo','Vencimiento Contrato',1
EXEC spInsertarDimensionNivel  'PER','Vencimiento Contrato','VencimientoContrato','Vencimiento Contrato','Vencimiento Contrato',1
GO
EXEC spInsertarDimension 'PER','Sexo','Normal','Sexo',1
EXEC spInsertarDimensionNivel  'PER','Sexo','Sexo','Sexo','Sexo',1
GO
EXEC spInsertarDimension 'PER','Estado Civil','Normal','Estado Civil',1
EXEC spInsertarDimensionNivel  'PER','Estado Civil','EstadoCivil','Estado Civil','Estado Civil',1
GO
EXEC spInsertarDimension 'PER','Centro Costos','Normal','Centro Costos',1
EXEC spInsertarDimensionNivel  'PER','Centro Costos','CentroCostos','Centro Costos','Centro Costos',1
EXEC spInsertarDimensionNivel  'PER','Centro Costos','DescripcionCC','Descripcion','Descripcion',2
GO
EXEC spInsertarDimension 'PER','Departamento','Normal','Departamento',1
EXEC spInsertarDimensionNivel  'PER','Departamento','Departamento','Departamento','Departamento',1
GO
EXEC spInsertarDimension 'PER','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel  'PER','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension 'PER','Puesto','Normal','Puesto',1
EXEC spInsertarDimensionNivel  'PER','Puesto','Puesto','Puesto','Puesto',1
GO
EXEC spInsertarDimension 'PER','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'PER','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'PER','Periodo Tipo','Normal','PeriodoTipo',1
EXEC spInsertarDimensionNivel  'PER','Periodo Tipo','PeriodoTipo','Periodo Tipo','PeriodoTipo',1
GO
EXEC spInsertarDimension 'PER','Jornada','Normal','Jornada',1
EXEC spInsertarDimensionNivel  'PER','Jornada','Jornada','Jornada','Jornada',1
GO
EXEC spInsertarDimension 'PER','Tipo Sueldo','Normal','TipoSueldo',1
EXEC spInsertarDimensionNivel  'PER','Tipo Sueldo','TipoSueldo','Tipo Sueldo','Tipo Sueldo',1
GO
EXEC spInsertarDimension 'PER','Vehiculo','Normal','Vehiculo',1
EXEC spInsertarDimensionNivel  'PER','Vehiculo','Vehiculo','Vehiculo','Vehiculo',1
GO
EXEC spInsertarDimension 'PER','Sindicato','Normal','Sindicato',1
EXEC spInsertarDimensionNivel  'PER','Sindicato','Sindicato','Sindicato','Sindicato',1
GO
EXEC spInsertarDimension 'PER','Nivel Academico','Normal','NivelAcademico',1
EXEC spInsertarDimensionNivel  'PER','Nivel Academico','NivelAcademico','Nivel Academico','NivelAcademico',1
GO
EXEC spInsertarDimension 'PER','Forma Pago','Normal','Forma Pago',1
EXEC spInsertarDimensionNivel  'PER','Forma Pago','FormaPago','Forma Pago','FormaPago',1
GO
EXEC spInsertarDimension 'PER','Fecha Nacimiento','Tiempo','FechaNacimiento',1
EXEC spInsertarDimensionNivel  'PER','Fecha Nacimiento','FechaNacimiento','Fecha Nacimiento','FechaNacimiento',1
GO
EXEC spInsertarDimension 'PER','Reporta A','Normal','Reporta A',1
EXEC spInsertarDimensionNivel  'PER','Reporta A','ReportaA','Reporta A','Reporta A',1
GO
/*	Dimensión duplicada en código original		Víctor Gutiérrez Méndez	*/
--EXEC spInsertarDimension 'PER','Reporta A','Normal','Reporta A',1
--EXEC spInsertarDimensionNivel  'PER','Reporta A','ReportaA','Reporta A','Reporta A',1
--GO
EXEC spInsertarDimension 'PER','Aspira Categoria','Normal','AspiraCategoria',1
EXEC spInsertarDimensionNivel  'PER','Aspira Categoria','AspiraCategoria','Aspira Categoria','AspiraCategoria',1
GO
EXEC spInsertarDimension 'PER','Aspira Departamento','Normal','AspiraDepartamento',1
EXEC spInsertarDimensionNivel  'PER','Aspira Departamento','AspiraDepartamento','Aspira Departamento','AspiraDepartamento',1
GO
EXEC spInsertarDimension 'PER','Aspira Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel  'PER','Aspira Grupo','AspiraGrupo','Aspira Grupo','AspiraGrupo',1
GO
EXEC spInsertarDimension 'PER','Aspira Puesto','Normal','AspiraPuesto',1
EXEC spInsertarDimensionNivel  'PER','Aspira Puesto','AspiraPuesto','Aspira Puesto','AspiraPuesto',1
GO
EXEC spInsertarDimension 'PER','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel  'PER','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'PER','Tipo Contrato','Normal','TipoContrato',1
EXEC spInsertarDimensionNivel  'PER','Tipo Contrato','TipoContrato','Tipo Contrato','TipoContrato',1
GO
EXEC spInsertarDimension 'PER','Situacion','Normal','Situacion',1
EXEC spInsertarDimensionNivel  'PER','Situacion','Situacion','Situacion','Situacion',1
GO
EXEC spInsertarDimension 'PER','CumpleAñosDia','Normal','CumpleAñosDia',1
EXEC spInsertarDimensionNivel  'PER','CumpleAñosDia','CumpleDia','CumpleDia','CumpleDia',1

GO
EXEC spInsertarDimension 'PER','CumpleAñosMes','Normal','CumpleAñosMes',1
EXEC spInsertarDimensionNivel  'PER','CumpleAñosMes','CumpleMes','CumpleMes','CumpleMes',2
GO
EXEC spInsertarDimension 'PER','Actividad','Normal','Actividad',1
EXEC spInsertarDimensionNivel  'PER','Actividad','Actividad','Actividad','Actividad',1
GO
EXEC spInsertarDimension 'PER','Proyecto','Normal','Proyecto',1
EXEC spInsertarDimensionNivel  'PER','Proyecto','Proyecto','Proyecto','Proyecto',1
GO
EXEC spInsertarDimension 'PER','Personal Cuenta','Normal','PersonalCuenta',1
EXEC spInsertarDimensionNivel  'PER','Personal Cuenta','PersonalCuenta','PersonalCuenta','PersonalCuenta',1
GO
EXEC spInsertarDimension 'PER','Banco','Normal','PersonalSucursal',1
EXEC spInsertarDimensionNivel  'PER','Banco','PersonalSucursal','PersonalSucursal','PersonalSucursal',1
GO
EXEC spInsertarDimension 'PER','RFC','Normal','RFC',1
EXEC spInsertarDimensionNivel  'PER','RFC','RFC','RFC','RFC',1
GO
EXEC spInsertarDimension 'PER','Afore','Normal','Afore',1
EXEC spInsertarDimensionNivel  'PER','Afore','Afore','Afore','Afore',1
GO
EXEC spInsertarDimension 'PER','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'PER','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'PER','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
/* 09-01-2007 Se ingresaron las dimensiones de Sucursal, Plaza, VigenciaA y VigenciaD*/
EXEC spInsertarDimension 'PER','Sucursal','Normal','Sucursal',1
EXEC spInsertarDimensionNivel  'PER','Sucursal','Sucursal','Sucursal','Sucursal',1
EXEC spInsertarDimensionNivel  'PER','Sucursal','SucursalNombre','Sucursal Nombre','SucursalNombre',2
EXEC spInsertarDimensionNivel  'PER','Sucursal','SucursalRegion','Region','Region',3
GO
EXEC spInsertarDimension 'PER','Plaza','Normal','Plaza',1
EXEC spInsertarDimensionNivel  'PER','Plaza','Plaza','Plaza','Plaza',1
EXEC spInsertarDimensionNivel  'PER','Plaza','PlazaDescripcion','PlazaDescripcion','PlazaDescripcion',2
EXEC spInsertarDimensionNivel  'PER','Plaza','PlazaTipo','PlazaTipo','PlazaTipo',3
EXEC spInsertarDimensionNivel  'PER','Plaza','PlazaRama','PlazaRama','PlazaRama',4
GO
EXEC spInsertarDimension 'NOM','VigenciaA','Normal','VigenciaA',1
EXEC spInsertarDimensionNivel  'PER','VigenciaA','VigenciaA','VigenciaA','VigenciaA',1
GO
EXEC spInsertarDimension 'NOM','VigenciaD','Normal','VigenciaD',1
EXEC spInsertarDimensionNivel  'PER','VigenciaD','VigenciaD','VigenciaD','VigenciaD',1
GO

/* Vista para ver el sueldo del empleado */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_SUELDO]'))
DROP VIEW Cubo_SUELDO
GO
CREATE VIEW Cubo_SUELDO
--//WITH ENCRYPTION
AS
SELECT NominaD.Personal,
'INGRESO' = SUM(CASE WHEN NominaD.Movimiento = 'Percepcion' THEN NominaD.Importe ELSE NominaD.Importe * -1 END)
	FROM Nomina, NominaD, MovTipo
	WHERE  NominaD.ID = Nomina.ID 
		AND MovTipo.Mov = Nomina.Mov
		AND MovTipo.Modulo = 'NOM' 
		AND Nomina.Estatus = 'CONCLUIDO'
		AND NominaD.Movimiento IN ('Percepcion','Deduccion')
		AND MONTH(Nomina.FechaEmision) = MONTH(DATEADD(M,-1,GETDATE()))
		AND Nominad.Concepto in ('IMSS','ISR','Premio Asistencia','Premio Puntualidad','Sueldo','Credito al Salario','Anticipo de Utilidades','Anticipo Utilidades Proyecto','Anticipo Utilidades Induccion')
	GROUP BY NominaD.Personal

GO
/* Cubo del maestro de personal */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_PER]'))
DROP VIEW Cubo_PER
GO
CREATE VIEW Cubo_PER
--//WITH ENCRYPTION
AS
SELECT
p.Personal,
'Nombre'	= RTRIM(p.ApellidoPaterno) + ' ' + RTRIM(p.ApellidoMaterno) + ' ' + p.Nombre,
p.Tipo,
p.Direccion,
p.Colonia,
p.Delegacion,
p.Poblacion,
p.Estado,
p.Pais,
p.Afore,
p.PersonalSucursal,
p.PersonalCuenta,
'RFC'		= p.Registro2,
p.CodigoPostal,
p.ZonaEconomica,
p.Ctadinero,
d.descripcion,
'Edad' 		= CASE WHEN DATEDIFF(yy,p.FechaNacimiento,GETDATE()) < 10
THEN '0' + CONVERT(CHAR(1),DATEDIFF(yy,p.FechaNacimiento,GETDATE()))
ELSE CONVERT(CHAR(2),DATEDIFF(yy,p.FechaNacimiento,GETDATE())) END,
'Antiguedad'	= CASE WHEN DATEDIFF(yy,p.FechaAntiguedad,GETDATE()) < 10
THEN '0' + CONVERT(CHAR(1),DATEDIFF(yy,p.FechaAntiguedad,GETDATE()))
ELSE CONVERT(CHAR(2),DATEDIFF(yy,p.FechaAntiguedad,GETDATE())) END,
p.Nacionalidad,
p.FechaAntiguedad,
'AntiguedadMes'	= (SELECT DISTINCT MesNombre FROM TIEMPO WHERE mes = month(p.FechaAntiguedad)),
p.FechaAlta,
p.FechaBaja,
p.VencimientoContrato,
p.Sexo,
p.EstadoCivil,
p.CentroCostos,
'DescripcionCC' = cc.Descripcion,
p.Departamento,
p.Grupo,
p.Puesto,
p.PeriodoTipo,
p.Jornada,
p.TipoSueldo,
p.Estatus,
p.Actividad,
p.Vehiculo,
p.Sindicato,
p.NivelAcademico,
p.Moneda,
p.Hijos,
p.Dependientes,
p.SueldoDiario,
p.SDI,
'NoPersonas'	= 1,
p.FormaPago,
p.FechaNacimiento,
'CumpleMes'	= (SELECT DISTINCT MesNombre FROM TIEMPO WHERE mes = month(p.FechaNacimiento)),
'CumpleDia'	= CASE WHEN Day(p.FechaNacimiento) < 10
THEN '0' + CONVERT(CHAR(1),Day(p.FechaNacimiento))
ELSE CONVERT(CHAR(2),Day(p.FechaNacimiento)) END,
p.LugarNacimiento,
p.ReportaA,
p.AspiraSueldo,
p.AspiraCategoria,
p.AspiraDepartamento,
p.AspiraGrupo,
p.AspiraPuesto,
p.AspiraFecha,
p.Categoria,
p.TipoContrato,
p.ConceptoBaja,
p.Situacion,
p.SituacionFecha,
p.MinimoProfesional,
'Sueldo'	= cs.Ingreso,
'proyecto'	= NULL,
p.UEN,
'UENNombre'	= uen.Nombre,
'Sucursal'		= p.SucursalTrabajo,
'SucursalNombre'	= s.Nombre,
'SucursalRegion' 	= s.Region,
'MesesTrabajados'	= CASE WHEN p.Estatus = 'ALTA'
THEN DATEDIFF(mm, FechaAlta, GETDATE())
ELSE DATEDIFF(mm, FechaAlta, FechaBaja)
END, 
'SueldoMensualBruto' = (p.SueldoDiario+p.SueldoDiarioComplemento)*30, 
pza.plaza as Plaza, 
pza.descripcion as PlazaDescripcion, 
pza.Tipo as PlazaTipo, 
pza.Rama as PlazaRama, 
pza.VigenciaA as PlazaVigenciaA, 
pza.VigenciaD as PlazaVigenciaD
FROM Personal p
LEFT OUTER JOIN CtaDinero d	ON p.CtaDinero 		= d.CtaDinero
LEFT OUTER JOIN CentroCostos cc	ON p.CentroCostos 	= cc.CentroCostos
LEFT OUTER JOIN UEN 	uen   	ON p.uen		= uen.uen
LEFT OUTER JOIN Cubo_Sueldo cs 	ON p.Personal		= cs.Personal
LEFT OUTER JOIN Sucursal 	s 	ON p.SucursalTrabajo 		= s.Sucursal
LEFT OUTER JOIN  Plaza pza 	ON p.plaza 	= pza.plaza
GO