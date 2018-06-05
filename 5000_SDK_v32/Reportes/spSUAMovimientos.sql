IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('DBO.spSUAMovimientos') AND TYPE='P') DROP PROC spSUAMovimientos
GO

CREATE PROCEDURE spSUAMovimientos
	@EMPRESA		CHAR(10),
	@FechaD			DATETIME,
	@FechaA			DATETIME
--	@RegistroPat    Varchar(11)

--WITH ENCRYPTION

AS BEGIN

CREATE TABLE #SUAMovimiento(
	RegistroPatronal CHAR(11),
	IMSS CHAR(11),
	TipoMovimiento CHAR(2),
	FechaMovimiento CHAR(8),
	FolioIncapacidad CHAR(8),
	Dias CHAR(2),
	SDI MONEY)

INSERT INTO #SUAMovimiento (RegistroPatronal,Imss,TipoMovimiento,FechaMovimiento,SDI,DIAS,FolioIncapacidad)

SELECT DISTINCT
	CAST(RIGHT(ISNULL(REPLACE(PersonalPropValor.Valor,'-',''),''),11) AS CHAR(11)) RegistroPatronal,
	CAST(RIGHT(ISNULL(Registro3,''),11) AS CHAR(11))               IMSS,
	TipoMovimiento = CASE A.Mov
						WHEN 'Modificaciones' THEN '07'
						WHEN 'Reingresos'     THEN '08'
						WHEN 'Bajas'          THEN '02'
					 END,
	RIGHT('0'+LTRIM(DATEPART(dd,a.FechaEmision)),2)+RIGHT('0'+LTRIM(DATEPART(mm,a.FechaEmision)),2)+LTRIM(DATEPART(yyyy,a.FechaEmision)) FechaEmision,
	CEILING(ISNULL(B.SDI,0)*100) SDI, '00',''
  FROM
	RH A,
	RHD B,
	Personal,
	PersonalPropValor
	
 WHERE
	A.FechaEmision BETWEEN  @FechaD AND @FechaA AND --'01/01/2008' and '05/31/2008' AND-- 
	B.Personal=Personal.Personal  AND
	A.EMPRESA= @Empresa AND
	A.ID=B.ID AND
	A.Estatus='Concluido' AND
	A.Mov IN('Reingresos','Modificaciones','Bajas') AND
	PersonalPropValor.Propiedad ='Registro Patronal' AND 
	A.Empresa = Personal.Empresa AND 
	A.Sucursal= Personal.SucursalTrabajo AND
	PersonalPropValor.Cuenta = Personal.SucursalTrabajo


ORDER BY FechaEmision

INSERT INTO #SUAMovimiento (RegistroPatronal,Imss,TipoMovimiento,FechaMovimiento,dias,FolioIncapacidad,SDI)

SELECT
	CAST(RIGHT(ISNULL(REPLACE(PersonalPropValor.Valor,'-',''),''),11) AS CHAR(11)) RegistroPatronal,
	CAST(RIGHT(ISNULL(Registro3,''),11) AS CHAR(11)) IMSS,
	TipoMovimiento = CASE Nomina.Mov
						WHEN 'Incapacidades'	THEN '12'
						WHEN 'Faltas'			THEN '11'
						WHEN 'Permiso Sin Goce' THEN '11'
					 END,
	RIGHT('0'+LTRIM(DATEPART(dd,NominaD.FechaD)),2)+RIGHT('0'+LTRIM(DATEPART(mm,NominaD.FechaD)),2)+LTRIM(DATEPART(yyyy,NominaD.FechaD)) FECHAEMISION,
	LEFT('0'+LTRIM(RIGHT(Convert(CHAR, ISNULL(NominaD.Cantidad,0)),20)),2),
	ISNULL(NominaD.Referencia,''),0
  FROM
	Nomina,
	NominaD,
	Personal,
	PersonalPropValor,
	Sucursal

 WHERE
	Nomina.FechaEmision BETWEEN @FechaD AND @FechaA AND-- '01/01/2008' and '05/31/2008' -- 
	NominaD.id=Nomina.id AND
	Nomina.EMPRESA= @Empresa AND -- 001 
	Mov in('Incapacidades','Faltas','Permiso Sin Goce') AND
	Nomina.Estatus in('PROCESAR','CONCLUIDO') AND
	NominaD.Personal = Personal.Personal AND
	PersonalPropValor.Propiedad ='Registro Patronal' AND
	Sucursal.Sucursal=Personal.SucursalTrabajo 
	

 ORDER BY FechaEmision

SELECT
	RegistroPatronal,
	IMSS,
	TipoMovimiento,
	FechaMovimiento,
	FolioIncapacidad,
	Dias,
	SDI
  FROM
	#SUAMovimiento

END


/*

EXEC  spSUAMovimientos 'FRAJU', '01/01/2014' , '30/09/2014'


*/

