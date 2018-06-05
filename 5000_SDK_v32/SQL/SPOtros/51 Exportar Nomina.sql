IF exists (SELECT * FROM sysobjects WHERE id = object_id('dbo.spExportarNominaBanamex') and type = 'P')  
	DROP PROCEDURE  dbo.spExportarNominaBanamex
go

CREATE PROCEDURE spExportarNominaBanamex
		@Empresa		CHAR(5),
		@Ejercicio		int,
		@Mov			varchar(20),
		@MovID			varchar(20),
		@CtaDinero		CHAR(10)
--//WITH ENCRYPTION
AS
BEGIN

CREATE TABLE #Nomina
	(Cadena VARCHAR(221))

CREATE TABLE #Personal
	(TipoReg 			VARCHAR(1)	COLLATE Database_Default,
	TipoOper 			VARCHAR(1)	COLLATE Database_Default,
	CveMoneda 			VARCHAR(3)	COLLATE Database_Default,
	TipoCta 			VARCHAR(2)	COLLATE Database_Default,
	PersonalSucursal		VARCHAR(4)	COLLATE Database_Default,
	Referencia			VARCHAR(40)	COLLATE Database_Default,
	Instrucciones			VARCHAR(40)	COLLATE Database_Default,
	DescTEF				VARCHAR(24)	COLLATE Database_Default,
	CveBanco			VARCHAR(4)	COLLATE Database_Default,
	RefVal				VARCHAR(7)	COLLATE Database_Default,
	Plazo				VARCHAR(2)	COLLATE Database_Default,
	Personal			VARCHAR(10)	COLLATE Database_Default,
	Empleado			VARCHAR(55)	COLLATE Database_Default,
	PersonalCuenta			VARCHAR(20)	COLLATE Database_Default,
	importe				DECIMAL (10,2)
)

	DECLARE @FechaNom		VARCHAR(10),
		@NomEmpresa		CHAR(36),
		@ImpTotal 		INT,
		@ImpStr			CHAR(18),
		@Continua		BIT,
		@MsgError		VARCHAR(221)

	SELECT @Continua = 1
	--Valida que los parámetros de entrada sean correctos
	IF not exists(SELECT * FROM Empresa WHERE Empresa=@Empresa)	or 
	   not exists(SELECT * FROM CtaDinero WHERE Institucion='BANAMEX' and CtaDinero=@CtaDinero)
	BEGIN
		SELECT @Continua=0
		SELECT @MsgError='Error en los parametros proporcionados. Corrigelo'
	END
	
	IF @Continua=1
	BEGIN
		--Inserta el cabecero (registro de control)
		SELECT @FechaNom = convert(varchar,dateadd(day, 2, getdate()),102)
		SELECT @FechaNom = substring(@FechaNom,9,2) + substring(@FechaNom,6,2) + substring(@FechaNom,3,2)
		SELECT @NomEmpresa=substring(Nombre,1,36) FROM Empresa WHERE Empresa=@Empresa
		INSERT INTO #Nomina
		SELECT '1' + '000023089614' + @FechaNom + '0001' + @NomEmpresa + space(20) + '05' + space(40) + 'B' + '0' + '1'

		Insert into #Personal
		SELECT  TipoReg = '3', TipoOper = '0', CveMoneda = '001', TipoCta = case isnull(a.PersonalSucursal,'Plastico') WHEN 'Plastico' THEN '03' ELSE '01' END, 
                PersonalSucursal = ISNULL(STUFF('0000', 5 - LEN(PersonalSucursal), LEN(PersonalSucursal), PersonalSucursal),'0000'),
                Referencia = '0123456789' + space(30), Instrucciones = space(40), DescTEF = space(24), CveBanco = '0000', RefVal = '0000001', Plazo='00', a.Personal, 
		Empleado=rtrim(a.Nombre) + ' ' +  rtrim(a.ApellidoPaterno) + ' ' + rtrim(a.ApellidoMaterno), a.PersonalCuenta, Importe=(SUM(CASE WHEN c.Movimiento = 'Percepcion' THEN c.Importe ELSE c.Importe * -1 END)) 
		FROM  Personal a, Nomina b, NominaD c 
		WHERE a.Personal=c.Personal 
		  AND b.ID = c.ID
		  AND c.Movimiento in ('Percepcion','Deduccion')
		  AND b.Mov	  	  = @Mov
		  AND b.MovID		  = @MovID
		  AND b.Ejercicio	  = @Ejercicio
		  AND b.Estatus		  = 'CONCLUIDO'
		  AND b.Empresa		  = @Empresa
		  AND c.Concepto	  <> 'FACTURA'
		  AND a.PersonalCuenta IS NOT NULL
		  AND c.Importe		  <> 0
		GROUP BY a.Personal, a.PersonalSucursal, a.Nombre, a.ApellidoPaterno, a.ApellidoMaterno, a.PersonalCuenta
		

		--Inserta el cabecero de la empresa (Registro Global)
		SELECT  @ImpTotal = ROUND(SUM(Importe),2)*100
		FROM #Personal
		SELECT @ImpStr = CONVERT(varchar,@ImpTotal)
		INSERT INTO #Nomina
		SELECT '2' + '1' + '001' + STUFF('000000000000000000', 19 - LEN(@ImpStr), LEN(@ImpStr), @ImpStr) + 
 	    	   '01' + STUFF('0000', 5 - LEN(BancoSucursal), LEN(BancoSucursal), BancoSucursal) +
			   STUFF('00000000000000000000', 21 - LEN(NumeroCta), LEN(NumeroCta), NumeroCta) + space(20)
		FROM  CtaDinero
		WHERE Institucion = 'BANAMEX' AND CtaDinero = @CtaDinero

		--Inserta los detalles
		INSERT INTO #Nomina
		SELECT  TipoReg + TipoOper + CveMoneda + STUFF('000000000000000000', 19 - LEN(CONVERT(int,ROUND(importe,2)*100)), LEN(CONVERT(int, ROUND(importe,2) * 100)), CONVERT(int, ROUND(importe,2) * 100)) +
				TipoCta + PersonalSucursal + STUFF('00000000000000000000', 21 - LEN(PersonalCuenta), LEN(PersonalCuenta), PersonalCuenta) +
				Referencia + rtrim(Empleado) + SPACE(55 - LEN(rtrim(Empleado))) + Instrucciones + DescTEF + CveBanco + RefVal + Plazo
		FROM   	#Personal
		WHERE  	Importe > 0

		--Inserta el registro de Totales
		INSERT INTO #Nomina
		SELECT '4' + '001' + STUFF('000000', 7 - LEN(COUNT(Personal)), LEN(COUNT(Personal)),  COUNT(Personal)) + 
    	       	STUFF('000000000000000000', 19 - LEN(@ImpStr), LEN(@ImpStr), @ImpStr) + '000001' + 
               	STUFF('000000000000000000', 19 - LEN(@ImpStr), LEN(@ImpStr), @ImpStr)
		FROM #Personal
		WHERE  importe > 0

		--Manda el resultado final al archivo.
		SELECT Cadena FROM #Nomina
	END
	ELSE
		SELECT @MsgError Cadena
END
GO

IF exists (SELECT * FROM sysobjects WHERE id = object_id('dbo.spExportarNominaBancomer') and type = 'P')  
DROP PROCEDURE  dbo.spExportarNominaBancomer
go

CREATE PROCEDURE spExportarNominaBancomer
		@Empresa		char(5),
		@Ejercicio		int,
		@Mov			varchar(20),
		@MovID			varchar(20)
--//WITH ENCRYPTION		
AS
BEGIN

	CREATE TABLE #CASH
	(	CADENA CHAR(108) COLLATE Database_Default)
	
	CREATE TABLE #Sueldos
	(	ID		int	IDENTITY,
		RFC		char(16)	COLLATE Database_Default NULL,
		Nombre		char(40)	COLLATE Database_Default NULL,
		CtaDinero	char(10)	COLLATE Database_Default NULL,
		Importe		money 		NULL)
	

	INSERT #Sueldos
	SELECT  Personal.Registro2,
			SUBSTRING(RTRIM(Personal.Nombre) + ' ' + RTRIM(ApellidoPaterno) + ' ' + RTRIM(ApellidoMaterno),1,40),
			Personal.PersonalCuenta,
			'Importe' = SUM(CASE WHEN NominaD.Movimiento = 'Percepcion' THEN NominaD.Importe ELSE NominaD.Importe * -1 END)
	FROM Nomina
		LEFT OUTER JOIN NominaD 	ON Nomina.ID			= NominaD.ID
		LEFT OUTER JOIN Personal 	ON Personal.Personal		= NominaD.Personal
		WHERE 	NominaD.Movimiento	IN ('Percepcion','Deduccion')
			AND Nomina.Mov			= @Mov
			AND Nomina.MovID		= @MovID
			AND Nomina.Ejercicio		= @Ejercicio
			AND Nomina.Empresa		= @Empresa
			AND Nomina.Estatus		= 'CONCLUIDO'
			AND NominaD.Concepto		<> 'FACTURA'
			AND Personal.PersonalCuenta IS NOT NULL
			AND NominaD.Importe		<> 0
		GROUP BY Personal.Registro2,personal.Nombre,ApellidoPaterno,ApellidoMaterno,PersonalCuenta
		
	---update #Sueldos set Importe = 0.01 
	INSERT #CASH
	SELECT REPLICATE('0',9 - LEN(RTRIM(CONVERT(VARCHAR,ID)))) + RTRIM(CONVERT(VARCHAR,ID)) +
		RTRIM(ISNULL(RFC,SPACE(1))) + REPLICATE(SPACE(1),16 - LEN(RTRIM(ISNULL(RFC,SPACE(1))))) +
		'99' +
		RTRIM(CtaDinero) + SPACE(10) +
		REPLACE(REPLICATE('0',16 - LEN(RTRIM(CONVERT(VARCHAR,Importe)))) + RTRIM(CONVERT(VARCHAR,Importe)),'.','') +
		RTRIM(Nombre) + REPLICATE(SPACE(1),40 - LEN(RTRIM(Nombre)))+ 
		'001' +  
		'001'		
	FROM #Sueldos a
	WHERE a.IMPORTE > 0	
	ORDER BY CtaDinero

	SELECT * 
	FROM #CASH
	ORDER BY CADENA

END
GO