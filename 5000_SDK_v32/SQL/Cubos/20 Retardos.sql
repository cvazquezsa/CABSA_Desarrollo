/* cubo de RETARDOS */
---17-12-2003 Se agrego la fecha de alta del empleado
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('PersonalFalta') AND type = 'U') 
DROP TABLE PersonalFalta
GO
/* vista de faltas del personal */ 
IF NOT EXISTS(SELECT * FROM SysObjects WHERE id = object_id('PersonalFalta') AND type = 'U') 
CREATE TABLE PersonalFalta(
	ID		int	 IDENTITY NOT NULL,	
	Personal	char	(10) NOT NULL,
	Fecha		DATETIME	NULL,
	Registro	DATETIME	NULL
)
GO
IF NOT EXISTS (SELECT name 
	FROM SYSCOLUMNS 
	WHERE ID = (SELECT id FROM SYSOBJECTS WHERE name like ('PersonalFalta') AND TYPE='u') 
			AND NAME = 'Registro')
	EXEC spAlter_Table 'PersonalFalta','Registro','DATETIME NULL'
GO
IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('CuboPersonalRegistro') AND type = 'U') 
DROP TABLE CuboPersonalRegistro
GO
/* vista de faltas del personal */  
IF NOT EXISTS(SELECT * FROM SysObjects WHERE id = object_id('CuboPersonalRegistro') AND type = 'U') 
CREATE TABLE CuboPersonalRegistro(
	ID		int	 IDENTITY NOT NULL,	
	Personal	char	(10)  NULL,
	Fecha		DATETIME	NULL,
	Registro	varchar(10)	NULL
)
go

IF EXISTS(SELECT * FROM SysObjects WHERE id = object_id('spPersonalFalta') AND type = 'P') 
DROP PROCEDURE spPersonalFalta
GO
CREATE PROCEDURE spPersonalFalta 
--//WITH ENCRYPTION
AS
DECLARE     @Ok		int,
	    @OkRef      varchar(255),
	    @Personal   char(10),
	    @FechaAlta  datetime,
	    @HoraEntrada char(2)

SELECT @Ok = NULL, @OkRef = NULL

TRUNCATE TABLE PersonalFalta
TRUNCATE TABLE CuboPersonalRegistro

SELECT @HoraEntrada = MIN(DATEPART(HH,Entrada))
FROM VerJornadaTiempo
WHERE Jornada 	= 'Horario Completo'

SELECT 'Fecha' = ASISTED.Fechad,'Registro' = MIN(AsisteD.HoraRegistro)
INTO #MINIMO
FROM ASISTED 
WHERE Registro='Entrada'
GROUP BY FECHAd

INSERT  CuboPersonalRegistro (Personal,Fecha,Registro)
SELECT  DISTINCT NULL,VerJornadaTiempo.Entrada,Registro	
FROM    VerJornadaTiempo ,#MINIMO A
 WHERE YEAR(VerJornadaTiempo.entrada) 		= YEAR(a.Fecha)
	AND MONTH(VerJornadaTiempo.entrada) 	= MONTH(a.Fecha)
	AND DAY(VerJornadaTiempo.entrada) 		= DAY(a.Fecha)
	AND a.Registro > @HoraEntrada
	AND VerJornadaTiempo.Jornada 		= 'Horario Completo'

INSERT  CuboPersonalRegistro(Personal,Fecha,Registro)
SELECT  DISTINCT NULL,VerJornadaTiempo.Entrada,NULL
FROM    VerJornadaTiempo 
 WHERE VerJornadaTiempo.entrada NOT IN (SELECT Fechad + '09:00'  FROM Asisted WHERE FechaD IS NOT NULL)
	AND DATEPART(HH,VerJornadaTiempo.Entrada)=@HoraEntrada

DECLARE crLista CURSOR 
FOR SELECT Personal,FechaAlta FROM Personal ORDER BY Personal
OPEN crLista
FETCH NEXT FROM crLista INTO @Personal,@FechaAlta
WHILE @@FETCH_STATUS <> -1 AND @Personal IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
      BEGIN
	INSERT PersonalFalta 
	SELECT @Personal, VerJornadaTiempo.Entrada,
	       Fechad
  	  FROM VerJornadaTiempo
          LEFT OUTER JOIN AsisteD ON CONVERT(CHAR(10),VerJornadaTiempo.Entrada,102) = CONVERT(CHAR(10),FechaD,102) AND Asisted.Personal=@Personal
	 WHERE VerJornadaTiempo.Jornada	= 'Horario Completo' 
	       AND VerJornadaTiempo.Entrada <= GETDATE()
	       AND CONVERT(DATETIME,CONVERT(CHAR(10),VerJornadaTiempo.Entrada,102)) NOT IN (SELECT Fecha FROM DiaFestivo)
	       AND DATEPART(HH,VerJornadaTiempo.Entrada)=@HoraEntrada

        END
    FETCH NEXT FROM crLista INTO @Personal,@FechaAlta
  END
CLOSE crLista
DEALLOCATE crLista
GO

EXEC spInsertarStore 'RETARDO','spPersonalFalta',1
EXEC spInsertarCubo 'RETARDO','Retardos','Cubo de Retardos del personal','Cubo_RETARDO',0,1
GO
DELETE FROM CUBOMEDIDA WHERE CUBO='RETARDO'
EXEC spInsertarMedida 'RETARDO','MinRetardo','Minutos','Minutos','aggSum'
----EXEC spInsertarMedida 'RETARDO','HorasTrabajadas','HorasTrabajadas','HorasTrabajadas','aggSum'
EXEC spInsertarMedida 'RETARDO','Faltas','Faltas','Faltas','aggSum'
EXEC spInsertarMedida 'RETARDO','SinRegistro','SinRegistro','SinRegistro','aggSum'
EXEC spInsertarMedida 'RETARDO','SinSistema','SinSistema','SinSistema','aggSum'
EXEC spInsertarMedida 'RETARDO','Vacaciones','Vacaciones','Vacaciones','aggSum'
EXEC spInsertarMedida 'RETARDO','NoRetardos','NoRetardos','NoRetardos','aggSum'
----EXEC spInsertarMedida 'RETARDO','NoEmpleados','NoEmpleados','NoEmpleados','aggDistinctCount'
GO
EXEC spInsertarDimension 'RETARDO','Personal','Normal','Personal',1
EXEC spInsertarDimensionNivel  'RETARDO','Personal','Personal','Personal','Personal',1
GO
EXEC spInsertarDimension 'RETARDO','Nombre','Normal','Nombre',1
EXEC spInsertarDimensionNivel  'RETARDO','Nombre','Nombre','Nombre','Nombre',1
GO
EXEC spInsertarDimension 'RETARDO','Departamento','Normal','Departamento',1
EXEC spInsertarDimensionNivel  'RETARDO','Departamento','Departamento','Departamento','Departamento',1
GO
EXEC spInsertarDimension 'RETARDO','Categoria','Normal','Categoria',1
EXEC spInsertarDimensionNivel  'RETARDO','Categoria','Categoria','Categoria','Categoria',1
GO
EXEC spInsertarDimension 'RETARDO','Grupo','Normal','Grupo',1
EXEC spInsertarDimensionNivel  'RETARDO','Grupo','Grupo','Grupo','Grupo',1
GO
EXEC spInsertarDimension 'RETARDO','Puesto','Normal','Puesto',1
EXEC spInsertarDimensionNivel  'RETARDO','Puesto','Puesto','Puesto','Puesto',1
GO
EXEC spInsertarDimension 'RETARDO','Hora Registro','Normal','HoraRegistro',1
EXEC spInsertarDimensionNivel  'RETARDO','Hora Registro','HoraRegistro','Hora Registro','HoraRegistro',1
GO
EXEC spInsertarDimension 'RETARDO','Hora Salida','Normal','HoraSalida',1
EXEC spInsertarDimensionNivel  'RETARDO','Hora Salida','HoraSalida','Hora Salida','HoraSalida',1
GO
EXEC spInsertarDimension 'RETARDO','Estatus','Normal','Estatus',1
EXEC spInsertarDimensionNivel  'RETARDO','Estatus','Estatus','Estatus','Estatus',1
GO
EXEC spInsertarDimension 'RETARDO','Fecha','Normal','Fecha',1
EXEC spInsertarDimensionNivel  'RETARDO','Fecha','Fecha','Fecha','Fecha',1
GO
EXEC spInsertarDimension 'RETARDO','Fecha Alta','Tiempo','FechaAlta',1
EXEC spInsertarDimensionNivel  'RETARDO','Fecha Alta','FechaAlta','FechaAlta','FechaAlta',1
GO
EXEC spInsertarDimension 'RETARDO','Fecha Falta','Normal','FechaFalta',1
EXEC spInsertarDimensionNivel  'RETARDO','Fecha Falta','FechaFalta','Fecha Falta','Fecha Falta',1
GO
EXEC spInsertarDimension 'RETARDO','Semana','Normal','Semana',1
EXEC spInsertarDimensionNivel  'RETARDO','Semana','Semana','Semana','Semana',1
GO
EXEC spInsertarDimension 'RETARDO','Trimestre','Normal','Trimestre',1
EXEC spInsertarDimensionNivel  'RETARDO','Trimestre','Trimestre','Trimestre','Trimestre',1
GO
EXEC spInsertarDimension 'RETARDO','Dia Semana','Normal','Dia Semana',1
EXEC spInsertarDimensionNivel  'RETARDO','Dia Semana','DiaSemana','Dia Semana','DiaSemana',1
GO
EXEC spInsertarDimension 'RETARDO','Año','Normal','Año',1
EXEC spInsertarDimensionNivel  'RETARDO','Año','Año','Año','Año',1
GO
EXEC spInsertarDimension 'RETARDO','Dia','Normal','Dia',1
EXEC spInsertarDimensionNivel  'RETARDO','Dia','Dia','Dia','Dia',1
GO
EXEC spInsertarDimension 'RETARDO','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'RETARDO','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'RETARDO','Mes','Normal','Mes',1
EXEC spInsertarDimensionNivel  'RETARDO','Mes','Mes','Mes','Mes',1
GO
EXEC spInsertarDimension 'RETARDO','UEN','Normal','UEN',1
EXEC spInsertarDimensionNivel  'RETARDO','UEN','UEN','UEN','UEN',1
EXEC spInsertarDimensionNivel  'RETARDO','UEN','UENNombre','UEN Nombre','UEN Nombre',2
GO
EXEC spInsertarDimension 'RETARDO','Sexo','Normal','Sexo',1
EXEC spInsertarDimensionNivel  'RETARDO','Sexo','Sexo','Sexo','Sexo',1
GO
EXEC spInsertarDimension 'RETARDO','Puesto','Normal','Puesto',1
EXEC spInsertarDimensionNivel  'RETARDO','Puesto','Puesto','Puesto','Puesto',1
GO
EXEC spInsertarDimension 'RETARDO','TipoContrato','Normal','TipoContrato',1
EXEC spInsertarDimensionNivel  'RETARDO','TipoContrato','TipoContrato','TipoContrato','TipoContrato',1
GO
EXEC spInsertarDimension 'RETARDO','Area','Normal','Area',1
EXEC spInsertarDimensionNivel  'RETARDO','Area','Area','Area','Area',1
GO
EXEC spInsertarDimension 'RETARDO','Entrada','Normal','Entrada',1
EXEC spInsertarDimensionNivel  'RETARDO','Entrada','Entrada','Entrada','Entrada',1
GO
EXEC spInsertarDimension 'RETARDO','CentroCostos','Normal','CentroCostos',1
EXEC spInsertarDimensionNivel  'RETARDO','CentroCostos','CentroCostos','CentroCostos','CentroCostos',1
GO
EXEC spInsertarDimension 'RETARDO','Usuario','Normal','Usuario',1
EXEC spInsertarDimensionNivel  'RETARDO','Usuario','Usuario','Usuario','usuario',1
EXEC spInsertarDimensionNivel  'RETARDO','UsuarioNombre','UsuarioNombre','UsuarioNombre','usuarioNombre',2
GO

/* vista de retardos del personal */ 
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Retardo]'))
DROP VIEW Retardo
GO
CREATE VIEW Retardo
--//WITH ENCRYPTION
AS 
SELECT Personal.Personal,
 HoraRegistro 	= MIN(AsisteD.HoraRegistro),
 HoraSalida	= MAX(AsisteD.HoraRegistro),
 'Fecha' 	= AsisteD.FechaD,
Retardo,
Usuario		= (SELECT  top 1 MovEstatusLog.Usuario FROM  MovEstatusLog WHERE MovEstatusLog.Modulo='ASIS'   AND MovEstatusLog.ModuloID=asiste.id AND ESTATUS='CONCLUIDO' )
FROM Personal, AsisteD ,Asiste
WHERE   Personal.Personal 	= AsisteD.Personal  
	AND Asiste.ID 		= AsisteD.ID
GROUP BY Personal.Personal,AsisteD.FechaD,Retardo,Usuario,Asiste.Id
GO

/* Cubo de retardos y faltas */
IF exists (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[Cubo_RETARDO]'))
DROP VIEW Cubo_RETARDO
GO
CREATE VIEW Cubo_RETARDO
--//WITH ENCRYPTION
AS 

SELECT 
	Personal.Personal,
	'Nombre'		= RTRIM(Personal.ApellidoPaterno) + ' ' + RTRIM(Personal.ApellidoMaterno) + ' ' + RTRIM(Personal.Nombre),
	Personal.Departamento,
	Personal.Categoria,
	Personal.Grupo,
	Personal.Puesto,
	Retardo.HoraRegistro ,
	Retardo.HoraSalida ,
	'HorasTrabajadas'	= 0,
	Personal.Estatus,
	tiempo.trimestre,
	tiempo.Semana,
	'Mes'			= tiempo.MesNombre,
	'Año'			= tiempo.Anio,
	'DiaSemana'		= tiempo.DiaNombre,
	'Dia'			= CASE WHEN DATEPART(d, Retardo.Fecha) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, Retardo.Fecha))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d, Retardo.Fecha))) END ,
	Retardo.Fecha,
	'NoEmpleados'		= 0,
	MinRetardo = Case WHEN Retardo.Retardo = 1
	           THEN DATEDIFF(MINUTE,JornadaD.Entrada,Retardo.HoraRegistro)
	           ELSE 0 END,
	'FechaFalta'		= NULL,
	'SinRegistro'		= 0,
	'FechaAlta'		= Personal.FechaAlta,
	'Faltas'			= 0,
	'SinSistema'		= 0,
	'Vacaciones'		= 0,
	'NoRetardos'		=  CASE WHEN Retardo.Retardo = 1
					THEN 1 ELSE 0 END,
	'UEN'			= personal.UEN,
	'UENNombre'		= UEN.Nombre,
	'Sexo'			= personal.Sexo,
	'CentroCostos'		= Personal.CentroCostos,
	'NombreCentroCostos'	= CentroCostos.Descripcion,
	'TipoContrato'		= Personal.TipoContrato,
	'Area'			= personal.ReportaA,
	'Entrada'		= JornadaD.Entrada,
	'Usuario'		= Retardo.Usuario,
	'UsuarioNombre'	= Usuario.Nombre
FROM Personal
	LEFT OUTER JOIN  Retardo 	ON Personal.Personal 		= Retardo.Personal  
	LEFT OUTER JOIN  JornadaD	ON Personal.Jornada  		= JornadaD.Jornada
	LEFT OUTER JOIN  Tiempo	ON Retardo.Fecha		= Tiempo.Fecha
	LEFT OUTER JOIN  UEN	ON  Personal.UEN		= UEN.UEN
	LEFT OUTER JOIN  usuario	ON  Retardo.Usuario		= Usuario.usuario
	LEFT OUTER JOIN  CentroCostos	ON Personal.CentroCostos = CentroCostos.CentroCostos
WHERE   
	 JornadaD.Logico3 = 1 
	AND Retardo.HoraRegistro IS NOT NULL

UNION
SELECT DISTINCT
	NULL,
	'Nombre'		= NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL ,
	NULL,
	0,
	NULL,
	tiempo.trimestre,
	tiempo.Semana,
	'Mes'			= tiempo.MesNombre,
	'Año'			= tiempo.Anio,
	'DiaSemana'		= tiempo.DiaNombre,
	'Dia'			= CASE WHEN DATEPART(d, tiempo.Fecha) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d, tiempo.Fecha))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d,tiempo.Fecha))) END ,
	tiempo.Fecha,
	'NoEmpleados'		= 0,
	0,
	'FechaFalta'		= NULL,
	'SinRegistro'		= 0,
	NULL,
	'Faltas'			= 0,
	'SinSistema'		= CASE WHEN CuboPersonalRegistro.Registro > '9:00' OR CuboPersonalRegistro.Registro IS NULL THEN 1 ELSE 0 END,
	'Vacaciones'		= 0,
	'NoRetardos'		= 0,
	'UEN'			= NULL,
	'NombreUEN'		= NULL,
	'Sexo'			= NULL,
	'CentroCostos'		= NULL,
	'NombreCentroCostos'	= NULL,
	'TipoContrato'		= NULL,
	'Area'		= NULL,
	'Entrada'		= NULL,
	'Usuario'		= NULL,
	'UsuarioNombre'	= NULL

FROM  CuboPersonalRegistro, Tiempo
WHERE  YEAR(CuboPersonalRegistro.Fecha) 	= YEAR(Tiempo.Fecha)
	AND MONTH(CuboPersonalRegistro.Fecha) 	= MONTH(Tiempo.Fecha)
	AND DAY(CuboPersonalRegistro.Fecha) 	= DAY(Tiempo.Fecha)

UNION
SELECT DISTINCT
	Personal.Personal,
	'Nombre'		= RTRIM(Personal.ApellidoPaterno) + ' ' + RTRIM(Personal.ApellidoMaterno) + ' ' + RTRIM(Personal.Nombre),
	Personal.Departamento,
	Personal.Categoria,
	Personal.Grupo,
	Personal.Puesto,
	NULL ,
	NULL,
	0,
	Personal.Estatus,
	tiempo.trimestre,
	tiempo.Semana,
	'Mes'			= tiempo.MesNombre,
	'Año'			= tiempo.Anio,
	'DiaSemana'		= tiempo.DiaNombre,
	'Dia'			= CASE WHEN DATEPART(d,  Nomina.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d,  Nomina.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d,  Nomina.FechaEmision))) END ,
	Nomina.FechaEmision,
	'NoEmpleados'		= 0,
	0,
	'FechaFalta'		= NULL,
	'SinRegistro'		= 0,
	personal.FechaAlta,
	'Faltas'			= 0,
	'SinSistema'		= 0,
	'Vacaciones'		= NominaD.Cantidad,
	'NoRetardos'		= 0,
	'UEN'			= NULL,
	'NombreUEN'		= NULL,
	'Sexo'			= NULL,
	'CentroCostos'		= NULL,
	'NombreCentroCostos'	= NULL,
	'TipoContrato'		= NULL,
	'Area'			= NULL,
	'Entrada'		= NULL,
	'Usuario'		= NULL,
	'UsuarioNombre'	= NULL

FROM Personal
	LEFT OUTER JOIN  NominaD 	ON Personal.Personal 	= NominaD.Personal  
	LEFT OUTER JOIN  Nomina 	ON Nomina.Id		= NominaD.Id
	LEFT OUTER JOIN  Tiempo 	ON Nomina.FechaEmision= Tiempo.Fecha
WHERE 
	 NominaD.Concepto	 IN ( 'Vacaciones Disfrutadas','Vacaciones','Vacaciones Adeudadas','Vacaciones Este Periodo')
	AND Nomina.Estatus	= 'CONCLUIDO'

UNION
SELECT DISTINCT
	Personal.Personal,
	'Nombre'		= RTRIM(Personal.ApellidoPaterno) + ' ' + RTRIM(Personal.ApellidoMaterno) + ' ' + RTRIM(Personal.Nombre),
	Personal.Departamento,
	Personal.Categoria,
	Personal.Grupo,
	Personal.Puesto,
	NULL ,
	NULL,
	0,
	Personal.Estatus,
	tiempo.trimestre,
	tiempo.Semana,
	'Mes'			= tiempo.MesNombre,
	'Año'			= tiempo.Anio,
	'DiaSemana'		= tiempo.DiaNombre,
	'Dia'			= CASE WHEN DATEPART(d,  Nomina.FechaEmision) < 10 
				THEN '0' + CONVERT(CHAR(1),DATEPART(d,  Nomina.FechaEmision))
				ELSE RTRIM(CONVERT(CHAR(2),DATEPART(d,  Nomina.FechaEmision))) END ,
	FechaEmision,
	'NoEmpleados'		= 0,
	0,
	'FechaFalta'		= nomina.FechaEmision,
	'SinRegistro'		= 0,
	personal.FechaAlta,
	'Faltas'			= 1,
	'SinSistema'		= 0,
	'Vacaciones'		= 0,
	'NoRetardos'		= 0,
	'UEN'			= NULL,
	'NombreUEN'		= NULL,
	'Sexo'			= NULL,
	'CentroCostos'		= NULL,
	'NombreCentroCostos'	= NULL,
	'TipoContrato'		= NULL,
	'Area'			= NULL,
	'Entrada'		= NULL,
	'Usuario'		= NULL,
	'UsuarioNombre'	= NULL

FROM Personal
	LEFT OUTER JOIN  NominaD 	ON Personal.Personal 	= NominaD.Personal
	LEFT OUTER JOIN  Nomina 	ON  Nomina.ID		= Nominad.ID
	LEFT OUTER JOIN  tiempo 	ON  Nomina.FechaEmision= Tiempo.Fecha

WHERE   
	Nomina.Estatus	= 'CONCLUIDO'
	AND Nominad.Concepto	 IN ( 'Faltas')  
GO

