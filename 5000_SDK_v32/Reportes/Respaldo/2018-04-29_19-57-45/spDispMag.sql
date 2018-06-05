IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('DBO.spDispMag') AND TYPE='P') DROP PROC spDispMag
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

CREATE PROCEDURE [dbo].[spDispMag]	
				   (@Mov			varchar(20),
					@FechaD			DateTime,
					@FechaA			DateTime)
--					@RegistroPat    Varchar(11))
--					@Empresa		Varchar(5))
AS BEGIN

SELECT
	(SELECT COUNT(personal.personal)
	 FROM RH,RHD, PersonalPropValor,Personal
	 WHERE RH.Estatus='Concluido'
	 AND RH.ID=RHD.id
	 AND Personal.SucursalTrabajo=PersonalPropvalor.Cuenta
	 AND Rama='SUC'
	 AND PersonalPropValor.Propiedad='Registro Patronal'
	 AND Personal.Personal=RHD.Personal
	 AND RH.Mov= '@Mov'
	 AND RH.FechaEmision BETWEEN @FechaD AND @FechaA
	 ) Cuantos,

	ISNULL(PersonalPropValor.Valor,'') RegistroPatonal ,
	ISNULL(Personal.Registro3,'') IMSS ,
	ISNULL(Personal.ApellidoPaterno,'') ApellidoPaterno ,
	ISNULL(Personal.ApellidoMaterno,'') ApellidoMaterno,
	ISNULL(Personal.Nombre,'') Nombre,
	ISNULL(Personal.Madre,'') Madre,
	ISNULL(Personal.Padre,'') Padre,
	ISNULL(Personal.SDI,0)*100 SDI,
	ISNULL(Personal.SDIAnterior,0)*100 SDIAnterior,
	ISNULL(Personal.SucursalTrabajo,'') SucursalTrabajo,
	Personal.puesto,

	TipoTrabajador = Case Personal.TipoContrato 
			 WHEN 'Trab. Permanente'  THEN '1'
			 WHEN 'Trab. Ev. Ciudad'  THEN '2'
			 WHEN 'Trab. Ev. Constrn' THEN '3'
			 WHEN 'Eventual'          THEN '2'
			 WHEN 'Construccion'      THEN '3'
			 WHEN 'Permanente'        THEN '1'
			 ELSE '1'
			 END,

	TipoSueldo = Case Personal.TipoSueldo
		     WHEN 'Fijo'     THEN '0'
		     WHEN 'Variable' THEN '1'
		     WHEN 'Mixto'    THEN '2'
		     ELSE '0'
		     END,

	Jornada = Case Personal.Jornada
		  WHEN 'Horario Completo' 	THEN '0'
		  WHEN 'Un Dia' 		THEN '1'
		  WHEN 'Dos Dias' 		THEN '2'
		  WHEN 'Tres Dias' 		THEN '3'
		  WHEN 'Cuatro Dias'		THEN '4'
		  WHEN 'Cinco Dias'		THEN '5'
		  WHEN 'Jornada Reducida'	THEN '6'
		  ELSE '0'
		  END,

	RIGHT('0'+LTRIM(DATEPART(dd,rh.FechaEmision)),2)+
	RIGHT('0'+LTRIM(DATEPART(mm,rh.FechaEmision)),2)+
	LTRIM(DATEPART(yyyy,rh.FechaEmision)) FechaEmision,
	UnidadMedica,
	rh.Mov,
	TipoMovimiento = CASE RH.Mov    
			WHEN 'Modificaciones'	THEN '07'
			WHEN 'Altas'			THEN '08'
			WHEN 'Reingresos'		THEN '08'
			WHEN 'Bajas'			THEN '02'
			END,

	Personal.Personal,
	Sexo = 	CASE Personal.Sexo
		WHEN 'MASCULINO' THEN '1'
		WHEN 'FEMENINO'  THEN '2'
		ELSE  '1'
		END,

	CausaBaja =	CASE RH.Concepto
			WHEN 'Termino de Contrato'	    THEN '1'
			WHEN 'Separacion Voluntaria'    THEN '2'
			WHEN 'Abandono de Empleo'	    THEN '3'
			WHEN 'Defuncion'		        THEN '4'
			WHEN 'Clausura'		            THEN '5'
			WHEN 'Otras'	                THEN '6'
			WHEN 'Ausentismo'			    THEN '7'
			WHEN 'Rescicion de Contrato'	THEN '8'
			WHEN 'Jubilacion'				THEN '9'
			WHEN 'Pension'					THEN 'A'			
			ELSE '1'
			END,
	Personal.Registro Curp

FROM
	RH,
	RHD,
	PersonalPropValor,
	Personal

WHERE
	RH.Estatus='Concluido'
	AND RH.ID=RHD.id
	AND Personal.SucursalTrabajo=PersonalPropvalor.Cuenta
	AND Rama='SUC'
	AND PersonalPropValor.Propiedad='Registro Patronal'
	AND Personal.Personal=RHD.Personal
	AND RH.Mov=@Mov
	AND RH.FechaEmision BETWEEN @FechaD AND @FechaA 
END

/*

EXEC spDispMag 'Altas','01/01/2014','30/09/2014'
EXEC spDispMag 'Modificaciones','01/01/2014','30/09/2014'
EXEC spDispMag 'Bajas','01/01/2014','30/09/2014'

*/


