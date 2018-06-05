/* spVerNominaCorrespondeFechas */
if exists (select * from sysobjects where id =object_id('dbo.spVerNominaCorrespondeFechas') and type = 'P') drop procedure dbo.spVerNominaCorrespondeFechas 
GO 
CREATE PROCEDURE spVerNominaCorrespondeFechas
  @Personal	char(10),
  @Empresa	char(5),
  @Mov		char(20),
  @Concepto	varchar(50),
  @Fecha	datetime,
  @Fecha2	datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Suma 		money,
  @Condicion		varchar(50),
  @Importe		money,
  @Cantidad		money,
  @Porcentaje		money,
  @Monto		money,
  @FechaD		datetime,
  @FechaA		datetime,
  @CantidadPendiente	money,
  @Saldo		money

  EXEC spExtraerFecha @Fecha OUTPUT
  EXEC spExtraerFecha @Fecha2 OUTPUT
  SELECT @Suma = 0.0,@Mov = NULLIF(RTRIM(@Mov), ''), @Concepto = NULLIF(RTRIM(@Concepto), '')

  BEGIN
    IF @Concepto IS NULL
      SELECT @Suma = SUM(d.CantidadPendiente)
      FROM   Nomina n, NominaD d, MovTipo mt
      WHERE  n.ID = d.ID
      AND n.Estatus in('PROCESAR','CONCLUIDO')
      AND n.Empresa = @Empresa
      AND d.FechaD between @Fecha AND @Fecha2
      AND n.Mov = @Mov
      AND n.Mov = mt.Mov
      AND mt.Modulo = 'NOM'
      AND mt.Clave IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
      AND d.Personal = @Personal

    ELSE
      SELECT @Suma = SUM(d.CantidadPendiente)
      FROM   Nomina n, NominaD d, MovTipo mt
      WHERE  n.ID = d.ID
      AND n.Estatus in('PROCESAR','CONCLUIDO')
      AND n.Empresa = @Empresa
      AND d.FechaD between @Fecha AND @Fecha2
      AND n.Mov = @Mov
      AND n.Concepto = @Concepto
      AND n.Mov = mt.Mov
      AND mt.Modulo = 'NOM'
      AND mt.Clave IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
      AND d.Personal = @Personal

  END
  SELECT @Suma
  RETURN
END
GO

/**********spDiasLibres*********/
if exists (select * from sysobjects where id =object_id('dbo.spDiasLibres') and type = 'P') drop procedure dbo.spDiasLibres 
GO  
CREATE PROCEDURE spDiasLibres 
  @Jornada Char(20),
  @FechaDel DateTime,
  @FechaAL DateTime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
          @PrimerDia Int,
          @DiasSinTrabajo Int,
          @Domingo Int,
          @Lunes Int,
          @Martes Int,
          @Miercoles Int,
          @Jueves Int,
          @Viernes Int,
          @Sabado Int

  SELECT @Domingo=0, @Lunes=0, @Martes=0, @Miercoles=0, @Jueves=0, @Viernes=0, @Sabado=0
  SELECT @DiasSintrabajo=0
  SELECT 
    @Domingo=Domingo, 
    @Lunes=Lunes, 
    @Martes=Martes, 
    @Miercoles=Miercoles, 
    @Jueves=Jueves, 
    @Viernes=Viernes, 
    @Sabado=Sabado
  FROM 
    Jornada 
  WHERE 
    Jornada=@Jornada

  SELECT @PrimerDia=@@DateFirst/* para guardar la configuracion actual */
  SET DATEFIRST 7 /* para que el domingo sea el primer dia */
  WHILE @FechaDel <= @FechaAl 
  BEGIN
    IF DATEPART(dw, @FechaDel)=1 and @Domingo=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    IF DATEPART(dw, @FechaDel)=2 and @Lunes=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    IF DATEPART(dw, @FechaDel)=3 and @Martes=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    IF DATEPART(dw, @FechaDel)=4 and @Miercoles=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    IF DATEPART(dw, @FechaDel)=5 and @Jueves=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1
    IF DATEPART(dw, @FechaDel)=6 and @Viernes=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    IF DATEPART(dw, @FechaDel)=7 and @Sabado=1 
      SELECT @DiasSinTrabajo=@DiasSinTrabajo+1 
    SELECT @FechaDel=@FechaDel+1
  END
-- para restaurar la configuracion original
  SET DATEFIRST @PrimerDia 
  SELECT @DiasSinTrabajo
END

/* spGroosUpISR */
GO
if exists (select * from sysobjects where id =object_id('dbo.spGroosUpISR') and type = 'P') drop procedure dbo.spGroosUpISR 
GO
CREATE PROCEDURE spGroosUpISR
                 @PeriodoTipo		char(20),
                 @SubsidioAcreditable	float,
                 @ImporteRequerido     	money

--//WITH ENCRYPTION
AS BEGIN
  Declare   @ISR Money,
            @ImporteActual Money,
            @ImporteContodo Money,
            @Cont int ,
            @TotalBono		money	
  Select @ImporteContodo=@ImporteRequerido*1.20,@ImporteContodo=@ImporteRequerido 
  Select @Cont=0
  exec spNominaISR @PeriodoTipo,@ImporteConTodo ,@SubsidioAcreditable,@ISR Output
  Select @ImporteActual=@ImporteContodo-@ISR
  WHILE @ImporteActual-@ImporteRequerido <> 0.0 AND @Cont < 30
  Begin
    Select @Cont=@Cont+1
    SELECT @ImporteContodo=@ImporteContodo+(@ImporteRequerido-@ImporteActual)
    exec spNominaISR @PeriodoTipo,@ImporteConTodo ,@SubsidioAcreditable,@ISR Output
    Select @ImporteActual=@ImporteContodo-@ISR
  End 
  Select @TotalBono=@ImporteContodo-@ImporteActual 
  Select @TotalBono
END
GO

/**************** spReemplazaEspecial ****************/
if exists (select * from sysobjects where id =object_id('dbo.spReemplazaEspecial') and type = 'P') drop procedure dbo.spReemplazaEspecial
GO             
CREATE PROCEDURE spReemplazaEspecial    @Linea       varchar(500)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Caracter char(1), 
          @P        int,
          @Comodin  char(1)
  SELECT @Linea=UPPER(@Linea),@P=1,@Comodin='X'
  WHILE @P<= LEN(@Linea) 
  BEGIN
    SELECT @Caracter =SUBSTRING(@Linea,@P,1)
    IF @Caracter='Ñ'  SELECT @Caracter='N'
    IF @Caracter='#'  SELECT @Caracter='N'
    IF @Caracter='Á'  SELECT @Caracter='A'
    IF @Caracter='É'  SELECT @Caracter='E'     
    IF @Caracter='Í'  SELECT @Caracter='I'
    IF @Caracter='Ó'  SELECT @Caracter='O'
    IF @Caracter='Ú'  SELECT @Caracter='U'
    IF @Caracter='-'  SELECT @Caracter='X'
    IF ASCII(@Caracter) > 90  SELECT @Caracter=@Comodin
    IF ASCII(@Caracter) < 48 AND ASCII(@Caracter)<> 32 AND @Caracter <> '*'
      SELECT @Caracter=@Comodin
    IF ASCII(@Caracter) < 65 AND ASCII(@Caracter) > 57  
      SELECT @Caracter=@Comodin
    SELECT @Linea=STUFF(@Linea,@P,1,@Caracter)
    SELECT @P=@P+1
  END
  SELECT @Linea
END
GO

--SPReemplazaEspecial 'áéíóúñabcd$º1234567890¡qwertyuiopàsdfghjklñzxcvbnm,.-¡+ç`´'
/*******************************SpRHDispMag*******************/
If exists(select * from sysobjects where id=object_id('dbo.SpRHDispMag') and Type ='p') drop procedure dbo.SpRHDispMag
GO
CREATE PROCEDURE SpRHDispMag (@Mov varchar(20), @FechaD DateTime, @FechaA DateTime) 
--//WITH ENCRYPTION
AS BEGIN
  SELECT 
    (SELECT 
       COUNT(personal.personal)
     FROM 
       RH,RHD,PersonalPropValor,Personal
     WHERE 
       RH.Estatus='Concluido' 
       AND RH.ID=RHD.id  
       AND Personal.SucursalTrabajo=PersonalPropvalor.Cuenta 
       AND Rama='SUC'   
       AND PersonalPropValor.Propiedad='Registro Patronal'
       AND Personal.Personal=RHD.Personal
       AND RH.Mov=@Mov
       AND RH.FechaEmision BETWEEN @FechaD AND @FechaA 
    ) Cuantos,
    ISNULL(PersonalPropValor.Valor,'') RegistroPatonal ,
    ISNULL(Personal.Registro3,'') IMSS ,  
    ISNULL(Personal.ApellidoPaterno,'') ApellidoPaterno ,
    ISNULL(Personal.ApellidoMaterno,'') ApellidoMaterno,
    ISNULL(Personal.Nombre,'') Nombre,ISNULL(Personal.Madre,'') Madre,ISNULL(Personal.Padre,'') Padre,
    ISNULL(Personal.SDI,0)*100 SDI ,ISNULL(Personal.SDIAnterior,0)*100 SDIAnterior,
    ISNULL(Personal.SucursalTrabajo,'') SucursalTrabajo,Personal.puesto,
    TipoTrabajador=Case Personal.TipoContrato WHEN 'Trab. Permanente'  THEN '1'
                                              WHEN 'Trab. Ev. Ciudad'  THEN '2'
                                              WHEN 'Trab. Ev. Constrn' THEN '3'
                                              WHEN 'Eventual'          THEN '2'
                                              WHEN 'Construccion'      THEN '3'    
                                              WHEN 'Permanente'        THEN '1'    
                                              ELSE '1'
                   END,
    TipoSueldo=Case Personal.TipoSueldo WHEN 'Fijo'     THEN '0'
                                        WHEN 'Variable' THEN '1'
                                        WHEN 'Mixto'    THEN '2'
                                        ELSE '0'
               END,
    Jornada = Case Personal.Jornada WHEN 'Horario Completo' THEN '0'
                                    WHEN 'Un Dia' THEN           '1'
                                    WHEN 'Dos Dias' THEN         '2'
                                    WHEN 'Tres Dias' THEN        '3'
                                    WHEN 'Cuatro Dias' THEN      '4'
                                    WHEN 'Cinco Dias' THEN       '5'
                                    WHEN 'Jornada Reducida' THEN '6'
                                    ELSE  '0'
              END,
    RIGHT('0'+LTRIM(DATEPART(dd,rh.FechaEmision)),2)+RIGHT('0'+LTRIM(DATEPART(mm,rh.FechaEmision)),2)+LTRIM(DATEPART(yyyy,rh.FechaEmision)) FechaEmision,
    UnidadMedica,
    rh.Mov,
    TipoMovimiento = CASE RH.Mov    WHEN 'Modificaciones' THEN '07'
                                    WHEN 'Altas'          THEN '08'
                                    WHEN 'Bajas'          THEN '02'
                     END,
    Personal.Personal,
    Sexo = CASE Personal.Sexo
                WHEN 'MASCULINO' THEN '1'
                WHEN 'FEMENINO'  THEN '2'
                ELSE  '1'  
                END,
    CausaBaja = CASE RH.Concepto
                       WHEN 'Termino de Contrato' THEN '1'
                       WHEN 'Separ. Voluntaria'   THEN '2'
                       WHEN 'Abandono de Empleo'  THEN '3'
                       WHEN 'Defuncion'           THEN '4'
                       WHEN 'Clausura'            THEN '5'
                       WHEN 'Otras'               THEN '6'
                       ELSE '1'
                END,
    Personal.Registro Curp
  FROM 
    RH,RHD,PersonalPropValor,Personal
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
Go


--exec SpRHDispMag 'altas','01-22-2002','01-25-2002'
--Select estatus,* from RH
-- Select * from personal
-- Select *  from empresa


--Select * from nomina where id=18
/******************************* Sp_AyudaConceptoDim *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spVerConceptoDim') AND type = 'P') 
DROP PROCEDURE dbo.spVerConceptoDim
GO
CREATE PROCEDURE dbo.spVerConceptoDim
@Empresa			VARCHAR(5),
@EstacionTrabajo	INT
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @NomAuto BIT 
	SELECT	@NomAuto=NomAuto 
	  FROM	Empresagral			
	 WHERE	Empresa=@Empresa

	DELETE	DimListaConcepto
	 WHERE	Empresa=@Empresa
	
	IF @NomAuto=1
	BEGIN
		INSERT	DimListaConcepto
				(Empresa,	NominaConcepto,	Concepto)
		SELECT	@Empresa,	NominaConcepto,	Concepto 
		  FROM	NominaConcepto nc
		 ORDER	BY nc.Concepto
	END

	ELSE 
	BEGIN
		INSERT	DimListaConcepto 
				(Empresa,	NominaConcepto,	Concepto)
		SELECT  distinct @Empresa,	Concepto  ,		Concepto 
		  FROM	NomXPersonal nx
		 ORDER	BY nx.Concepto
	END
END
GO
/******************************* spFiltroDim *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spFiltroDim') AND type = 'P')
BEGIN
	DROP PROCEDURE dbo.spFiltroDim
END
GO
CREATE PROCEDURE dbo.spFiltroDim
@EstacionTrabajo	int,
@Empresa			VARCHAR(5)
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON
DECLARE @Finiquito varchar(100),
        @Asimilado varchar(100),
        @LISR varchar(100),
        @IDC int
        
	DELETE Listast WHERE Estacion =@EstacionTrabajo

	IF (SELECT Obligatorio FROM DimCfg WHERE Columna=30 AND Empresa=@Empresa) = 0
	BEGIN
		INSERT	INTO Listast 
				(Estacion,			Clave)
		SELECT	@EstacionTrabajo,	Columna 
		  FROM	DimCfg
		 WHERE	Columna BETWEEN 33 AND 50 AND Empresa=@Empresa
	END
	ELSE
	BEGIN
		UPDATE	DimCfg	SET Obligatorio = 1
		 WHERE	Columna	BETWEEN 33 AND 50 AND Empresa=@Empresa
	END

	IF (SELECT Obligatorio FROM DimCfg WHERE Columna=31 AND Empresa=@Empresa) = 0
	BEGIN
		INSERT	INTO Listast 
				(Estacion,			Clave)
		SELECT	@EstacionTrabajo,	Columna 
		  FROM	DimCfg
		 WHERE	Columna BETWEEN 51 AND 57 AND Empresa=@Empresa
	END
	ELSE
	BEGIN
		UPDATE	DimCfg	SET Obligatorio = 1
		 WHERE	Columna	BETWEEN 51 AND 57 AND Empresa=@Empresa
	END

	IF (SELECT Obligatorio FROM DimCfg WHERE Columna=32 AND Empresa=@Empresa) = 0
	BEGIN
		INSERT	INTO Listast 
				(Estacion,			Clave)
		SELECT	@EstacionTrabajo,	Columna 
		  FROM	DimCfg
		 WHERE	Columna BETWEEN 58 AND 134 AND Empresa=@Empresa
	END
	ELSE
	BEGIN
		UPDATE	DimCfg SET Obligatorio = 1
		 WHERE	Columna BETWEEN 58 AND 134  AND Empresa=@Empresa
	END

	UPDATE	DimCfg SET Obligatorio = 0
	  FROM	DimCfg c JOIN Listast l ON l.Clave = c.Columna
	 WHERE	l.Estacion=@EstacionTrabajo AND c.Empresa=@Empresa


RETURN(0)
SET NOCOUNT OFF
END
GO
/******************************* spReporteDim *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spReporteDim') AND type = 'P')
BEGIN
	DROP PROCEDURE dbo.spReporteDim
END
GO
CREATE PROCEDURE dbo.spReporteDim
@Cadena		VARCHAR(2),  
@Empresa	VARCHAR(5),  
@Anio		int,  
@Estacion	int  
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON
	DECLARE  
	@Personal				VARCHAR(30),  
	@Columna				VARCHAR(30),  
	@SQL					VARCHAR(8000),  
	@SQL2					VARCHAR(8000), 
	@FechaD					DATETIME,  
	@FechaA					DATETIME,  
	@FechaDSiguiente		DATETIME,  
	@FechaASiguiente		DATETIME,  
	@Campo					VARCHAR(50),  
	@Tabla					BIT,  
	@Tipo					VARCHAR(30),  
	@obligatorio			BIT,  
	@MaxColum				INT,  
	@Titulo					VARCHAR(90),  
	@ConceptoSubsidioEmpleo	VARCHAR(50)  ,
	@Colum30				VARCHAR(2),
	@Colum31				VARCHAR(2),
	@Colum32				VARCHAR(2),
    @PagosporSeparacionMov	VARCHAR(50),
    @AsimiladosASalarios	VARCHAR(50),
    @PagoPatronEfectuados	VARCHAR(50),
    @Movimiento             VARCHAR(20),--BUG 17346
    @MovConcepto            VARCHAR(50),
    @Concepto               VARCHAR(50),
    @Cantidad               MONEY

	SET DATEFORMAT mdy;

    CREATE TABLE #PasoAjusteAnual(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
    CREATE TABLE #PasoSeparacion(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
    CREATE TABLE #PasoPagoPatronEfectuados(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
    CREATE TABLE #PasoAsimilado(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
    CREATE TABLE #PasoPagoPatron(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
    CREATE TABLE #PasoValor (Valor VARCHAR(30) COLLATE database_DEFAULT NULL)
	CREATE TABLE #PasoOrden(IDColum  int,Columna  VARCHAR(30)COLLATE database_DEFAULT  NULL)  
	CREATE TABLE #PasoPersonal(IDPer VARCHAR(20)COLLATE database_DEFAULT,Personal VARCHAR(20)COLLATE database_DEFAULT  NULL)
  	CREATE TABLE #PasoSubTotales(Personal VARCHAR(20)COLLATE database_DEFAULT NULL,Columna  VARCHAR(30)COLLATE database_DEFAULT,SubTotal MONEY NULL,SubTotalC MONEY NULL)  
	CREATE TABLE #PasoTotales(Personal VARCHAR(20) COLLATE database_DEFAULT NULL,Columna  VARCHAR(30)COLLATE database_DEFAULT,Total    int NULL)  
	CREATE TABLE #PasoExisteEnMov(Personal VARCHAR(20) COLLATE database_DEFAULT	NULL)  
	CREATE TABLE #Pasotexto(Personal VARCHAR(20) COLLATE database_DEFAULT NULL,Columna  VARCHAR(30) COLLATE database_DEFAULT,Valor    VARCHAR(90) COLLATE database_DEFAULT NULL)  
    CREATE TABLE #PasoPTUa(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL,Importe FLOAT NULL)
    CREATE TABLE #PasoPTUb(Personal VARCHAR(20)COLLATE database_DEFAULT  NULL,Importe FLOAT NULL)
	
    IF NOT EXISTS(SELECT * FROM sysindexes WHERE sysindexes.name = 'PSTPersonal')
      CREATE INDEX PTTPersonal ON #PasoSubTotales(Personal,Columna)INCLUDE(SubTotal)
    IF NOT EXISTS(SELECT * FROM sysindexes WHERE sysindexes.name = 'PTTPersonal')
      CREATE INDEX PTTPersonal ON #PasoTotales(Personal)
	IF NOT EXISTS(SELECT * FROM sysindexes WHERE sysindexes.name = 'PTPersonalColumna')
      CREATE INDEX PTPersonalColumna ON #Pasotexto(Personal,Columna)
	IF NOT EXISTS(SELECT * FROM sysindexes WHERE sysindexes.name = 'PTPersonal')
       CREATE INDEX PTPersonal ON #Pasotexto(Personal)    

	IF @Cadena='SI'  
	BEGIN  
		DELETE	DimPasoPipe	WHERE Estacion=@Estacion  
		DELETE	DimPaso		WHERE Estacion=@Estacion AND Personal='0'  
		SELECT	@MaxColum=134--Max(Columna) FROM DimCfg WHERE Obligatorio=1  

		DECLARE	CrpipePersonal CURSOR LOCAL FAST_FORWARD  FOR  
		SELECT	Personal
		  FROM	DIMPaso
		 WHERE	Estacion=@Estacion
		 OPEN	CrpipePersonal  
		FETCH	NEXT FROM CrpipePersonal INTO @Personal 
		WHILE	@@FETCH_STATUS <> -1  
		BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  		
			
					SELECT	@Colum30='',@Colum31='',@Colum32=''
					DECLARE	Crpipe CURSOR LOCAL FAST_FORWARD  FOR  
					SELECT	Columna FROM DimCfg WHERE /*Obligatorio=1 AND*/    empresa=@empresa 
					--order by columna  
					SELECT	@SQL='INSERT INTO DimPasoPipe (Estacion,Cadena01) SELECT '+Convert(VARCHAR(10),@Estacion)+', '  
					 OPEN	Crpipe  
					FETCH	NEXT FROM Crpipe
					 INTO	@Columna  

					WHILE	@@FETCH_STATUS <> -1  
					BEGIN  
							IF	@@FETCH_STATUS <> -2  
							BEGIN  				

								IF @Columna IN (30,31,32)
								BEGIN
									DELETE	#pasoValor
									SET		@SQL2=''
									SET		@SQL2='INSERT INTO #pasoValor (Valor) SELECT ISNULL( Dim'+@Columna+','+CHAR(39)+CHAR(39)+') FROM  DIMPaso WHERE Personal='+CHAR(39)+@Personal+CHAR(39)+' AND Estacion='+Convert(VARCHAR(10),@Estacion)
									EXEC	(@SQL2)

									IF	@Columna=30
										SELECT @Colum30=vALOR FROM #pasoValor
									IF	@Columna=31
										SELECT @Colum31=vALOR FROM #pasoValor
									IF	@Columna=32
										SELECT @Colum32=vALOR FROM #pasoValor
								END
							
								IF @Columna BETWEEN 33 AND 126
								BEGIN				
									IF	(@Colum30='2' AND @Columna BETWEEN 33 AND 50 )
									OR	(@Colum31='2' AND @Columna BETWEEN 51 AND 57 )
									OR	(@Colum32='2' AND @Columna BETWEEN 58 AND 126)
									BEGIN								
										--SELECT @SQL = @SQL +''
										SELECT @SQL = @SQL + CHAR(39)+CHAR(39) + '+'
										SELECT @SQL = @SQL + CHAR(39)+'|'+CHAR(39)+ '+'
									END
								
									ELSE 
									BEGIN
										SELECT @SQL = @SQL + 'ISNULL( Dim'+@Columna+','''' )+''|'''
										SELECT @SQL = @SQL + '+' 
									END
								END 
											
								ELSE
								BEGIN
									SELECT @SQL = @SQL +'ISNULL( Dim'+@Columna+','''' )+''|'''
						
									IF @MaxColum <> @Columna  
									BEGIN
										SELECT @SQL = @SQL + '+'  
									END
									ELSE
									BEGIN
										SELECT @SQL = @SQL+' FROM DIMPaso WHERE Personal='+CHAR(39)+@Personal+CHAR(39)+' AND  Estacion='+Convert(VARCHAR(10),@Estacion)+' ORDER BY  Personal'  
									END
								END 
							END  
				
					FETCH	NEXT FROM Crpipe INTO @Columna  
					END  
					
					CLOSE	Crpipe  
					DEALLOCATE	Crpipe  

					EXECUTE (@SQL)  

				END  
		
				FETCH	NEXT FROM CrpipePersonal INTO @Personal  
		END
		
		CLOSE	CrpipePersonal  
		DEALLOCATE	CrpipePersonal  

		SELECT	Estacion, Cadena01, Cadena02  
		  FROM	DimPasoPipe  
		 WHERE	Estacion=@Estacion  
	END
	ELSE  
	BEGIN  
	
        DELETE	DIMPaso WHERE Estacion=@Estacion 
		
		SELECT  @FechaD='01/01/'+CONVERT(VARCHAR(4),@Anio), @FechaA='12/31/'+CONVERT(VARCHAR(4),@Anio) 
		SELECT	@FechaDSiguiente = DATEADD(YEAR,1,@FechaD),@FechaASiguiente=DATEADD(YEAR,1,@FechaA)  
		
		DECLARE	@NomAuto bit  
		SELECT	@NomAuto=NomAuto
		  FROM	Empresagral  
		 WHERE	Empresa=@Empresa  

		IF @NomAuto=1
		BEGIN  
			INSERT	#PasoSubTotales (
					Personal ,	Columna,	SubTotal,                SubTotalC)
			SELECT	d.Personal,	C.Columna,	Sum(ISNULL(CASE WHEN D.Movimiento = 'Deduccion' THEN -1 ELSE 1 END * d.Importe,0)),Sum(ISNULL(d.Cantidad,0))
			  FROM	Nomina N
			  JOIN  NominaD D	ON D.ID = N.ID
			  JOIN	DimCfgD Cd	ON D.NominaConcepto=Cd.NominaConcepto
			  JOIN	DimCfg C	ON C.Id =Cd.Id  
			 WHERE  N.FechaA BETWEEN @FechaD AND @FechaA  
					AND	n.Empresa=@Empresa  
					AND	c.Empresa=@Empresa  
					AND	n.Estatus IN ('CONCLUIDO')  
			 GROUP	BY d.Personal,C.Columna  
		END 
		 
		IF @NomAuto=0  
		BEGIN  
			INSERT	#PasoSubTotales (
					Personal,	Columna,	SubTotal,                SubTotalC)
			SELECT	d.Personal,	C.Columna,	Sum(ISNULL(CASE WHEN D.Movimiento =  'Deduccion' THEN -1 ELSE 1 END * d.Importe,0)),Sum(ISNULL(d.Cantidad,0))
			  FROM	Nomina N
			  JOIN	NominaD D  ON D.ID = N.ID
			  JOIN	DimCfgD Cd ON ISNULL(D.Concepto,D.NominaConcepto)=Cd.Concepto
			  JOIN	DimCfg C   ON C.Id =Cd.Id  
			 WHERE	N.FechaA BETWEEN @FechaD AND @FechaA  
					AND n.Empresa=@Empresa  
					AND c.Empresa=@Empresa  
					AND n.Estatus IN ('CONCLUIDO')  
			GROUP	BY d.Personal,C.Columna  
		END  
		UPDATE #PasoSubTotales SET SubTotal = SubTotalC WHERE ISNULL(SubTotal,0) = 0
		
		INSERT	#PasoOrden(
				idColum, Columna)
		SELECT	1,		 Columna  
		  FROM	DimCfg
		 WHERE	Empresa=@Empresa
		 ORDER	BY Columna DESC  
		
		INSERT	#PasoPersonal(
				idPer, Personal)  
		SELECT	1,	   Personal  
		  FROM	#PasoSubTotales  
		 GROUP	BY Personal  
		
		INSERT	#PasoPersonal(
				idPer, Personal)  
		SELECT	1,	   0  
		
		INSERT	DIMPaso(
				id, Personal, Estacion)  
		SELECT	1,  Personal, @Estacion
		  FROM	#PasoPersonal  
		
		INSERT	#PasoSubTotales(
				Personal,	 Columna,	 SubTotal)
		SELECT	pp.Personal, po.Columna, 0  
		  FROM	#PasoOrden po
		  JOIN	#PasoPersonal pp ON po.idColum=pp.idPer  
		
		INSERT	#PasoTotales(
				Personal, Columna, Total)  
		SELECT	Personal, Columna, ISNULL(ROUND(SUM(SubTotal),0),0)  
		  FROM	#PasoSubTotales  
		 GROUP	BY Personal, Columna  
			
		UPDATE	#PasoTotales SET Total=Total*-1  
		 WHERE	Total<0  

		DECLARE	CrCamposPersonal CURSOR LOCAL FAST_FORWARD FOR  
		SELECT	Columna,Campo,Tipo  
		  FROM	DimCfg  
		 WHERE	Obligatorio=1 AND Empresa=@Empresa  
--		 ORDER	BY Columna  
		OPEN	CrCamposPersonal  
		FETCH	NEXT FROM CrCamposPersonal INTO  @Columna,@Campo,@Tipo  
		WHILE	@@FETCH_STATUS <> -1  
		BEGIN  
				IF	@@FETCH_STATUS <> -2  
				BEGIN  
					IF @Tipo='Tabla Personal'  
					BEGIN  
						SET @SQL=''  
					
						IF @Campo in ('FechaAlta')  
						BEGIN
							SET	@SQL='INSERT INTO #Pasotexto (Personal ,Columna ,Valor) SELECT p.Personal, '+@Columna+', right('+CHAR(39)+'00'+CHAR(39)+'+CONVERT(VARCHAR(2),DATEPART(MONTH, case when p.FechaAlta < '+CHAR(39)+convert(VARCHAR(10),@FechaD,101)+CHAR(39)+' then '+CHAR(39)
								+convert(VARCHAR(10),@FechaD,101)+CHAR(39)+' else p.FechaAlta END)),2) FROM #PasoTotales Pst JOIN Personal p ON pst.Personal=p.Personal'  
						END
						
						ELSE IF @Campo in ('FechaBaja')  
						BEGIN
							SET	@SQL='INSERT INTO #Pasotexto (Personal ,Columna ,Valor)	SELECT p.Personal,'+@Columna+',
								right('+CHAR(39)+'00'+CHAR(39)+'+CONVERT(VARCHAR(2),DATEPART(MONTH, case when p.Estatus = '+CHAR(39)+'BAJA'+CHAR(39)+' AND p.FechaBaja <'+CHAR(39)+convert(VARCHAR(10),@FechaA,101)+CHAR(39)+' then p.FechaBaja else '+CHAR(39)+convert(VARCHAR(10),@FechaA,101)+CHAR(39)+' END)),2) 
								FROM #PasoTotales Pst JOIN Personal p ON pst.Personal=p.Personal '  
						END
						
						ELSE IF @Campo in ('ZonaEconomica')  
						BEGIN
							SET	@SQL='INSERT INTO #Pasotexto (Personal ,Columna ,Valor) SELECT p.Personal, '+@Columna+',  case p.ZonaEconomica when '+CHAR(39)+'A'+CHAR(39)+' then '+CHAR(39)+'01'+CHAR(39)+' when '+CHAR(39)+'B'+CHAR(39)+' then '+CHAR(39)+'02'+CHAR(39)+' when '+CHAR(39
								)+'C'+CHAR(39)+' then '+CHAR(39)+'03'+CHAR(39)+' else '+CHAR(39)+'0'+CHAR(39)+' END  FROM #PasoTotales Pst JOIN Personal p ON pst.Personal=p.Personal'  
						END
						
						ELSE IF @Campo in ('Sindicato')  
						BEGIN
							SET	@SQL='INSERT INTO #Pasotexto (Personal ,Columna ,Valor) SELECT p.Personal, '+@Columna+', ISNULL(p.'+@Campo+','+CHAR(39)+'2'+CHAR(39)+') FROM #PasoTotales Pst JOIN Personal p ON pst.Personal=p.Personal'  
						END
						
						ELSE  
						BEGIN
							SET	@SQL='INSERT INTO #Pasotexto (Personal ,Columna ,Valor) SELECT p.Personal, '+@Columna+', replace (p.'+@Campo+','+CHAR(39)+'Ñ'+CHAR(39)+','+CHAR(39)+'N'+CHAR(39)+') FROM #PasoTotales Pst JOIN Personal p ON pst.Personal=p.Personal'  
						END
					
						EXEC (@SQL)  
					END  
				
				    IF @Columna IN (70)
                    BEGIN
                        SELECT @Movimiento = m.Campo, @MovConcepto = d.MovConcepto,
					           @Concepto = d.NominaConcepto, @Cantidad = d.Cantidad
					      FROM DimCfg m
     			          JOIN DimCfgD d on m.ID=d.ID
					     WHERE m.Columna = @Columna AND m.Empresa = @Empresa
					    
						INSERT	INTO #PasoPTUa (Personal,Importe)  
						SELECT	nd.Personal,SUM(nd.Importe)  
						  FROM	Nomina n  
						  JOIN  NominaD nd ON n.id=nd.id  
						 WHERE	n.Estatus='CONCLUIDO'  
								AND YEAR(n.FechaA) = @Anio
								AND n.Mov = @Movimiento
								AND n.Empresa = @Empresa
								AND nd.Concepto = @Concepto
						 GROUP BY nd.Personal  

                    END 
				
				    IF @Columna IN (71)
                    BEGIN
                        SELECT @Movimiento = m.Campo, @MovConcepto = d.MovConcepto,
					           @Concepto = d.NominaConcepto, @Cantidad = d.Cantidad
					      FROM DimCfg m
     			          JOIN DimCfgD d on m.ID=d.ID
					     WHERE m.Columna = @Columna AND m.Empresa = @Empresa
					    
						INSERT	INTO #PasoPTUb (Personal,Importe)  
						SELECT	nd.Personal,SUM(nd.Importe) 
						  FROM	Nomina n  
						  JOIN  NominaD nd ON n.id=nd.id  
						 WHERE	n.Estatus='CONCLUIDO'  
								AND YEAR(n.FechaA) = @Anio
								AND n.Mov = @Movimiento
								AND n.Empresa = @Empresa
								AND nd.Concepto = @Concepto

						 GROUP BY nd.Personal  

                    END 


					IF @Columna = 9 --BUG 17346
					BEGIN  
					    SELECT @Movimiento = d.Mov, @MovConcepto = d.MovConcepto,
					           @Concepto = d.NominaConcepto, @Cantidad = d.Cantidad
					      FROM DimCfg m
					      JOIN DimCfgD d on m.ID=d.ID
					     WHERE m.Columna = @Columna AND m.Empresa = @Empresa
					    
						INSERT	INTO #PasoAjusteAnual (Personal)  
						SELECT	nd.Personal  
						  FROM	Nomina n  
						  JOIN  NominaD nd ON n.id=nd.id  
						 WHERE	n.Estatus='CONCLUIDO'  
								AND YEAR(n.FechaA) = @Anio
								AND n.Mov = @Movimiento
								AND n.Concepto = @MovConcepto
								AND n.Empresa = @Empresa
								AND nd.Concepto = @Concepto
								AND nd.Cantidad = @Cantidad
						 GROUP BY nd.Personal  
  
					END  
					IF @Tipo='Expresion'  
					BEGIN  
						IF @Campo IN ('Entidad')  
						BEGIN  
							INSERT	INTO #Pasotexto (Personal ,Columna ,Valor)  
							SELECT	pp.Personal,@Columna,RIGHT('00'+ISNULL(Clave,'0'),2)--Bug 17531
							  FROM	#PasoPersonal pp 
							  JOIN  Personal p	  ON  pp.Personal= p.Personal 
							  JOIN	Sucursal s	  ON p.SucursalTrabajo=s.Sucursal 
							  JOIN	PaisEstado pe ON pe.Estado=s.Estado  
						END  
					END  
					
					IF @Tipo='Texto'  
					BEGIN  
						INSERT	#Pasotexto(
								Personal, Columna,  Valor)  
						SELECT	Personal, @Columna, CASE WHEN @Campo='NULL' THEN '' ELSE @Campo END  
						  FROM	#PasoPersonal  
					END  
				END  
				FETCH NEXT FROM CrCamposPersonal INTO  @Columna,@Campo,@Tipo  
		END  
		
		CLOSE	CrCamposPersonal  
		DEALLOCATE	CrCamposPersonal 
				
		DECLARE	CrActualiza CURSOR LOCAL FAST_FORWARD  FOR  
		
		SELECT	cfg.Columna, cfg.Titulo, cfg.Tipo  
		  FROM	#PasoOrden po 
		  JOIN	DimCfg cfg ON po.Columna=cfg.Columna  
		 WHERE	cfg.Obligatorio=1 AND cfg.Empresa=@Empresa  
		 --ORDER	BY cfg.Columna
		  
		OPEN	CrActualiza  
		FETCH	NEXT FROM CrActualiza INTO @Columna, @Titulo, @Tipo  
		WHILE	@@FETCH_STATUS <> -1  
		BEGIN  
				IF @@FETCH_STATUS <> -2  
				BEGIN  
					SELECT	@SQL='' 
					
					IF	@Tipo ='Suma Concepto'  
					BEGIN
						SET	@SQL='Update DIMPaso set  Dim'+ @Columna +'=pt.Total FROM DIMPaso po join #PasoTotales pt ON po.Personal=pt.Personal WHERE pt.Columna='+@Columna  
					END 
					
					ELSE  
					BEGIN
						SET	@SQL='Update DIMPaso set  Dim'+ @Columna +'=pt.Valor FROM DIMPaso po join #Pasotexto pt ON po.Personal=pt.Personal WHERE pt.Columna='+@Columna  
					END
					
					EXEC(@SQL) 
					
					SELECT	@SQL=''  
					SELECT	@SQL='Update DIMPaso set  Dim'+ @Columna +'='+CHAR(39)+Case when ISNULL(@Titulo,'')='' then 'Titulo '+@Columna else @Titulo END+CHAR(39)+' WHERE Personal='+CHAR(39)+'0'+CHAR(39)  
					
					EXEC(@SQL)  
				END  
				
				FETCH	NEXT FROM CrActualiza INTO @Columna, @Titulo, @Tipo  
		END  
		CLOSE	CrActualiza  
		DEALLOCATE	CrActualiza 
		
		--UPDATE	DIMPaso SET Dim9=CASE WHEN Dim9='0' THEN '2' ELSE Dim9 END 
		-- WHERE	Estacion=@Estacion AND Personal<>'0' 
		
		UPDATE	DIMPaso SET Dim13=CASE WHEN Dim13='Sindicalizado' THEN '1' ELSE '2' END 
		 WHERE	Estacion=@Estacion AND Personal<>'0' 
	
		SELECT	@PagosporSeparacionMov=Campo 
		  FROM	DimCfg
		 WHERE	Empresa=@Empresa AND columna=30

		SELECT	@AsimiladosASalarios=Campo 
		  FROM	DimCfg
		 WHERE	Empresa=@Empresa AND columna=31
		
		SELECT	@PagoPatronEfectuados=Campo 
		  FROM	DimCfg
		 WHERE	Empresa=@Empresa AND columna=32
		 
		DELETE	#PasoSeparacion
		INSERT	#PasoSeparacion(
				Personal)
		SELECT	b.Personal
		  FROM	Nomina a
		  JOIN	NominaD b ON a.id=b.id
		 WHERE	a.Mov =ltrim(rtrim(@PagosporSeparacionMov))
				AND a.FechaA BETWEEN @FechaD AND @FechaA
				AND a.Estatus IN ('Concluido')
				AND b.Personal <> NULL
		 GROUP	BY b.Personal
		 ORDER	BY b.Personal

        DELETE  #PasoPagoPatronEfectuados
        INSERT  #PasoPagoPatronEfectuados(
                Personal)
        SELECT  d.Personal
		  FROM	Nomina a
		  JOIN	NominaD d ON a.id=d.id
		 WHERE  a.Mov IN (SELECT LTRIM(RTRIM(d.Mov)) FROM DimCfg c JOIN DimCfgD d ON(c.ID = d.ID) WHERE c.Empresa = @Empresa AND c.Columna = 32)
                AND a.FechaA BETWEEN @FechaD AND @FechaA
				AND a.Estatus IN ('Concluido')
				AND d.Personal <> NULL
				
		DELETE	#PasoAsimilado
		INSERT	#PasoAsimilado(
				Personal)
		SELECT	b.Personal
		  FROM	Nomina a
		  JOIN	NominaD b ON a.id=b.id
		 WHERE	a.Mov =ltrim(rtrim(@AsimiladosASalarios))
				AND a.FechaA BETWEEN @FechaD AND @FechaA
				AND a.Estatus IN ('Concluido')
				AND b.Personal <> NULL
		 GROUP	BY b.Personal
		 ORDER	BY b.Personal
	
		DELETE	#PasoPagoPatron
		INSERT	#PasoPagoPatron(
				Personal)
		SELECT	b.Personal
		  FROM	Nomina a
		  JOIN	NominaD b ON a.id=b.id
		 WHERE	a.Mov =ltrim(rtrim(@PagoPatronEfectuados))
				AND a.FechaA BETWEEN @FechaD AND @FechaA
				AND a.Estatus IN ('Concluido')
				AND b.Personal <> NULL
		 GROUP	BY b.Personal
		 ORDER	BY b.Personal
	

	    UPDATE DIMPaso SET Dim30 = '2',Dim31 = '2',Dim32 = '2',Dim9='2'  WHERE Estacion = @Estacion AND Personal <>'0'
	    UPDATE DimPaso SET Dim30 = '1', Dim32 = '1' WHERE Estacion = @Estacion AND Personal IN(SELECT Personal FROM #PasoSeparacion)
	    UPDATE DimPaso SET Dim31 = '1' WHERE Estacion = @Estacion AND Personal IN(SELECT Personal FROM #PasoAsimilado)
	    UPDATE DimPaso SET Dim32 = '1' WHERE Estacion = @Estacion AND Personal IN(SELECT Personal FROM #PasoPagoPatron)--Bug 17537
	    UPDATE DimPaso SET Dim9 = '1' WHERE Estacion = @Estacion AND Personal IN(SELECT Personal FROM #PasoAjusteAnual)
	    UPDATE DimPaso SET Dim31 = '1', Dim32 = 1 WHERE Estacion = @Estacion AND Personal IN(SELECT Personal FROM #PasoPagoPatronEfectuados)
	    UPDATE DimPaso SET Dim70 = ISNULL(ROUND(i.Importe,0,0),0),Dim32 = '1' 
        FROM DimPaso d
        JOIN #PasoPTUa i ON d.Personal = i.Personal
        WHERE Estacion = @Estacion --AND Personal IN(SELECT Personal FROM #PasoPTUa)
        UPDATE DimPaso SET Dim71 = ISNULL(ROUND(i.Importe,0,0),0),Dim32 = '1' 
        FROM DimPaso d
        JOIN #PasoPTUb i ON d.Personal = i.Personal
        WHERE Estacion = @Estacion --AND Personal IN(SELECT Personal FROM #PasoPTUa)

	    UPDATE DIMPaso SET Dim51='',Dim52='',Dim53='',Dim54='',Dim55='',Dim56='',Dim57='' WHERE Estacion = @Estacion AND Personal <>'0' AND Dim31 = '2'
		--IF (SELECT COUNT(idPer) FROM #PasoSeparacion)>0 
		--BEGIN
		--	UPDATE	DIMPaso 
		--	   SET	Dim31 ='2', Dim53='',Dim54='',Dim55='',Dim56='',Dim57='',Dim51='',Dim52=''
		--	 WHERE	Personal NOT IN (SELECT Personal FROM #PasoPersonal )
		--			AND Estacion=@Estacion
		--			AND Personal <>'0'

		--END
		
		--ELSE
		--BEGIN
		--	UPDATE	DIMPaso 
		--	   SET	Dim31 ='2', Dim53='',Dim54='',Dim55='',Dim56='',Dim57='',Dim51='',Dim52=''
		--	 WHERE	Estacion=@Estacion
		--			AND Personal <>'0' 
		--END

		/*********************CONDICIONANTES****************************/



		
		UPDATE	DIMPaso 
		   SET	Dim58='',Dim59='',Dim60='',Dim61='',Dim62='',Dim63='',Dim64='',Dim65='',Dim66='',Dim67='',Dim68='',Dim69='',--Bug 17537
				Dim70='',Dim71='',Dim72='',Dim73='',Dim74='',Dim75='',Dim76='',Dim77='',Dim78='',Dim79='',Dim80='',Dim81='',Dim82='',Dim83='',Dim84='',Dim85='',
				Dim86='',Dim87='',Dim88='',Dim89='',Dim90='',Dim91='',Dim92='',Dim93='',Dim94='',Dim95='',Dim96='',Dim97='',Dim98='',Dim99='',Dim100='',Dim101='',
				Dim102='',Dim103='',Dim104='',Dim105='',Dim106='',Dim107='',Dim108='',Dim109='',Dim110='',Dim111='',Dim112='',Dim113='',Dim114='',Dim115='',Dim116='',
				Dim117='',Dim118='',Dim119='',Dim120='',Dim121='',Dim122='',Dim123='',Dim124='',Dim125='',Dim126=''
		 WHERE	Estacion=@Estacion 
				AND Personal<>'0'
				AND  Personal in (SELECT Personal FROM #PasoPersonal)
				AND Personal NOT in (SELECT Personal FROM #PasoSubTotales WHERE Columna=58 AND Personal<>'0' AND SubTotal>0 )
                AND Personal NOT IN (SELECT Personal FROM #PasoPTUa)
                AND Personal NOT IN (SELECT Personal FROM #PasoPTUb)
                AND Personal NOT IN (SELECT Personal FROM #PasoSeparacion)
                AND Personal NOT IN (Select Personal FROM #PasoPagoPatronEfectuados)


		--UPDATE	DIMPaso set Dim30= CASE WHEN ISNULL(LTRIM(RTRIM(Dim30)),'0') IN('0','2','') THEN '2' ELSE '1' END
		-- WHERE	Estacion=@Estacion AND Personal<>'0'--AND Dim30 is NULL

		--UPDATE	DIMPaso set Dim31= CASE WHEN ISNULL(LTRIM(RTRIM(Dim31)),'0') IN ('0','','2') THEN '2' ELSE '1' END
		-- WHERE	Estacion=@Estacion AND Personal<>'0'--AND Dim30 is NULL

		--UPDATE	DIMPaso set Dim32= CASE WHEN ISNULL(LTRIM(RTRIM(Dim32)),'0') IN ('0','','2') THEN '2' ELSE '1' END
		-- WHERE	Estacion=@Estacion AND Personal<>'0'--AND Dim30 is NULL

		
		UPDATE	DIMPaso set Dim14='0' 
		 WHERE	Estacion=@Estacion AND  Dim31='2' 

		SELECT	*
		  FROM	DIMPaso  
		 WHERE	Estacion=@Estacion  
		 ORDER	BY Personal  
			
	END  


RETURN(0)
SET NOCOUNT OFF	
END  
GO
/******************************* spInsertarDIM *************************************************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('dbo.spInsertarDIM') AND type = 'P') 
	DROP PROCEDURE dbo.spInsertarDIM
GO
CREATE PROCEDURE dbo.spInsertarDIM 
--//WITH ENCRYPTION
AS BEGIN
	DECLARE @Emp	VARCHAR(10),
			@EmpAnt	VARCHAR(10)

	SELECT @EmpAnt = ''
		WHILE(1=1)
	BEGIN
	  SELECT @Emp = MIN(EMpresa)  FROM Empresa  WHERE Empresa > @EmpAnt
	  IF @Emp IS NULL BREAK
	  
	  IF NOT EXISTS (SELECT 1 FROM DimCfg WHERE empresa=@Emp)
	  BEGIN
			--																							Empresa,	Columna,	Titulo,					Descripcion,																																	Tipo,				Obligatorio,	Campo
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		1,			'Mes inicial',																																				'Mes inicial',																																	'Tabla Personal',	1,				'FechaAlta')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		2,			'Mes Final',																																				'Mes final',																																	'Tabla Personal',	1,				'FechaBaja')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		3,			'RegistroFederalCon',																																		'Registro federal de contribuyentes',																											'Tabla Personal',	1,				'Registro2')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		4,			'Curp',																																						'Clave única de registro de población',																											'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		5,			'Apaterno',																																					'Apellido Paterno',																																'Tabla Personal',	1,				'ApellidoPaterno')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		6,			'Amaterno',																																					'Apellido Materno',																																'Tabla Personal',	1,				'ApellidoMaterno')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		7,			'Nombre',																																					'Nombre(s)',																																	'Tabla Personal',	1,				'Nombre')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		8,			'AreaGeografica',																																			'Área geográfica del salario mínimo',																											'Tabla Personal',	1,				'ZonaEconomica')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		9,			'CalculoAnualPatron',																																		'Indique si el patrón realizó cálculo anual',																									'Expresion',		1,				'AjusteAnual')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		10,			'TarIFaUtilizada',																																			'TarIFa utilizada: del ejercicio que declara',																									'Texto',			1,				'1')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		11,			'TarIFaUtilizada1991',																																		'TarIFa utilizada: 1991 actualizada',																											'Texto',			1,				'2')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		12,			'ProporcionSubSidioA',																																		'Proporción del subsidio aplicada',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		13,			'Sindicalizado',																																			'Indique si el trabajador es sindicalizado',																									'Texto',			1,				'1')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		14,			'AsimiladoASalarios',																																		'Si es asimilado a salarios, señale la clave correspondiente',																					'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		15,			'EntidadFederativa',																																		'Clave de la Entidad federativa donde presento sus servicion',																					'Expresion',		1,				'Entidad')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		16,			'RFC1',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 1 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		17,			'RFC2',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 2 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		18,			'RFC3',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 3 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		19,			'RFC4',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 4 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		20,			'RFC5',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 5 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		21,			'RFC6',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 6 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		22,			'RFC7',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 7 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		23,			'RFC8',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 8 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		24,			'RFC9',																																						'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 9 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		25,			'RFC10',																																					'En caso de que el trabajador haya tenido más de un patrón en el ejercicio, señale el RFC num 10 del otro patrón',								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		26,			'AportacionesVol',																																			'Monto de las aportaciones voluntarias efectuadas',																								'Texto',			1,				'NULL')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		27,			'PatronAplicoMonto',																																		'Indique si el patrón aplicó el monto de las aportaciones voluntarias en el cálculo del impuesto',												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		28,			'MontoDeduciblesTrab',																																		'Monto de las aportaciones voluntarias deducibles para trabajadores que realizarán su declaración',												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		29,			'MontoDeduciblesPatron',																																	'Monto de las aportaciones voluntarias deducibles aplicadas por el patrón',																		'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		30,			'PagosporSeparacion',																																		'B. Pagos por separación',																														'Texto',	        1,				'Finiquito')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		31,			'AsimiladosASalarios',																																		'C. Asimilados a salarios (excepto fracción I del Art. 110 de la LISR)',																		'Texto',	        1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		32,			'PagoPatronEfectuados',																																		'D. Pagos del patrón efectuados a sus trabajadores (incluyENDo fracción I del Art. 110 de la LISR)',											'Expresion',		1,				'Nomina')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		33,			'TotalesPagoParciales',																																		'Ingresos totales por pago en parcialidades',																									'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		34,			LEFT('Monto diario percibido por jubilaciones, pensiones o haberes de retiro en parcialidades',90),													  		'Monto diario percibido por jubilaciones, pensiones o haberes de retiro en parcialidades',													  	'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		35,			LEFT('Cantidad que se hubiera percibido en el periodo de no haber pago único por jubilaciones, pensiones o haberes de retiro en una sola exhibición',90),	'Cantidad que se hubiera percibido en el periodo de no haber pago único por jubilaciones, pensiones o haberes de retiro en una sola exhibición','Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		36,			LEFT('Monto total del pago en una sola exhibición',90),																										'Monto total del pago en una sola exhibición',																									'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		37,			LEFT('Número de días',90),																																	'Número de días',																																'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		38,			LEFT('Ingresos exentos',90),																																'Ingresos exentos',																																'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		39,			LEFT('Ingresos gravables',90),																																'Ingresos gravables',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		40,			LEFT('Ingresos acumulables',90),																															'Ingresos acumulables',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		41,			LEFT('Ingresos no acumulables',90),																															'Ingresos no acumulables',																														'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		42,			LEFT('Impuesto retenido',90),																																'Impuesto retenido',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		43,			LEFT('Monto total pagado de otros pagos por separación',90),																								'Monto total pagado de otros pagos por separación',																								'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		44,			LEFT('Número de años de servicio del trabajador',90),																										'Número de años de servicio del trabajador',																									'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		45,			LEFT('Ingresos excentos',90),																																'Ingresos excentos',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		46,			LEFT('Ingresos gravados',90),																																'Ingresos gravados',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		47,			LEFT('Ingresos acumulables (último sueldo mensual ordinario)',90),																							'Ingresos acumulables (último sueldo mensual ordinario)',																						'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		48,			LEFT('Impuesto correspondiente al último sueldo mensual ordinario',90),																						'Impuesto correspondiente al último sueldo mensual ordinario',																					'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		49,			LEFT('Ingresos no acumulables',90),																															'Ingresos no acumulables',																														'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		50,			LEFT('Impuesto Retenido',90),																																'Impuesto Retenido',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		51,			LEFT('Ingresos asimilados a salarios',90),																													'Ingresos asimilados a salarios',																												'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		52,			LEFT('Impuesto retenido durante el ejercicio',90),																											'Impuesto retenido durante el ejercicio',																										'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		53,			LEFT('Indique si ejerció la opción otorgada por el empleador para adquirir acciones o títulos valor',90),													'Indique si ejerció la opción otorgada por el empleador para adquirir acciones o títulos valor',												'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		54,			LEFT('Valor de mercado de las acciones o títulos valor al ejercer la opción',90),																			'Valor de mercado de las acciones o títulos valor al ejercer la opción',																		'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		55,			LEFT('Precio esTABLEcido al otorgarse la opción de ingresos en acciones o títulos valor',90),																'Precio esTABLEcido al otorgarse la opción de ingresos en acciones o títulos valor',															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		56,			LEFT('Ingreso Acumulable',90),																																'Ingreso Acumulable',																															'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		57,			LEFT('Impuesto retenido durante el ejercicio',90),																											'Impuesto retenido durante el ejercicio',																										'Texto',			0,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		58,			LEFT('Sueldos, salarios, rayas y jornales gravado',90),																										'Sueldos, salarios, rayas y jornales gravado',																									'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		59,			LEFT('Sueldos, salarios, rayas y jornales exento',90),																										'Sueldos, salarios, rayas y jornales exento',																									'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		60,			LEFT('GratIFicación anual gravado',90),																														'GratIFicación anual gravado',																													'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		61,			LEFT('GratIFicación anual exento',90),																														'GratIFicación anual exento',																													'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		62,			LEFT('Viáticos y gastos de viaje gravado',90),																												'Viáticos y gastos de viaje gravado',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		63,			LEFT('Viáticos y gastos de viaje exento',90),																												'Viáticos y gastos de viaje exento',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		64,			LEFT('Tiempo extraordinario gravado',90),																													'Tiempo extraordinario gravado',																												'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		65,			LEFT('Tiempo extraordinario exento',90),																													'Tiempo extraordinario exento',																													'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		66,			LEFT('Prima vacacional gravado',90),																														'Prima vacacional gravado',																														'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		67,			LEFT('Prima vacacional exento',90),																															'Prima vacacional exento',																														'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		68,			LEFT('Prima dominical gravado',90),																															'Prima dominical gravado',																														'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		69,			LEFT('Prima dominical exento',90),																															'Prima dominical exento',																														'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		70,			LEFT('Participación de los trabajadores en las utilidades (PTU) gravado',90),																				'Participación de los trabajadores en las utilidades (PTU) gravado',																			'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		71,			LEFT('Participación de los trabajadores en las utilidades (PTU) exento',90),																				'Participación de los trabajadores en las utilidades (PTU) exento',																				'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		72,			LEFT('Reembolso de gastos médicos, dentales y hospitalarios gravado',90),																					'Reembolso de gastos médicos, dentales y hospitalarios gravado',																				'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		73,			LEFT('Reembolso de gastos médicos, dentales y hospitalarios exento',90),																					'Reembolso de gastos médicos, dentales y hospitalarios exento',																					'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		74,			LEFT('Fondo de ahorro gravado',90),																															'Fondo de ahorro gravado',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		75,			LEFT('Fondo de ahorro exento',90),																															'Fondo de ahorro exento',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		76,			LEFT('Caja de ahorro gravado',90),																															'Caja de ahorro gravado',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		77,			LEFT('Caja de ahorro exento',90),																															'Caja de ahorro exento',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		78,			LEFT('Vales para despensa gravado',90),																														'Vales para despensa gravado',																													'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		79,			LEFT('Vales para despensa exento',90),																														'Vales para despensa exento',																													'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		80,			LEFT('Ayuda para gastos de funeral gravado',90),																											'Ayuda para gastos de funeral gravado',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		81,			LEFT('Ayuda para gastos de funeral exento',90),																												'Ayuda para gastos de funeral exento',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		82,			LEFT('Contribuciones a cargo del trabajador pagadas por el patrón gravado',90),																				'Contribuciones a cargo del trabajador pagadas por el patrón gravado',																			'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		83,			LEFT('Contribuciones a cargo del trabajador pagadas por el patrón exento',90),																				'Contribuciones a cargo del trabajador pagadas por el patrón exento',																			'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		84,			LEFT('Premios por puntualidad gravado',90),																													'Premios por puntualidad gravado',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		85,			LEFT('Premios por puntualidad exento',90),																													'Premios por puntualidad exento',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		86,			LEFT('Prima de seguro de vida gravado',90),																													'Prima de seguro de vida gravado',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		87,			LEFT('Prima de seguro de vida exento',90),																													'Prima de seguro de vida exento',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		88,			LEFT('Seguro de gastos médicos mayores gravado',90),																										'Seguro de gastos médicos mayores gravado',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		89,			LEFT('Seguro de gastos médicos mayores exento',90),																											'Seguro de gastos médicos mayores exento',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		90,			LEFT('Vales para restaurante gravado',90),																													'Vales para restaurante gravado',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		91,			LEFT('Vales para restaurante exento',90),																													'Vales para restaurante exento',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		92,			LEFT('Vales para gasolina gravado',90),																														'Vales para gasolina gravado',																													'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		93,			LEFT('Vales para gasolina exento',90),																														'Vales para gasolina exento',																													'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		94,			LEFT('Vales para ropa gravado',90),																															'Vales para ropa gravado',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		95,			LEFT('Vales para ropa exento',90),																															'Vales para ropa exento',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		96,			LEFT('Ayuda para renta gravado',90),																														'Ayuda para renta gravado',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		97,			LEFT('Ayuda para renta exento',90),																															'Ayuda para renta exento',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		98,			LEFT('Ayuda para artículos escolares gravado',90),																											'Ayuda para artículos escolares gravado',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		99,			LEFT('Ayuda para artículos escolares exento',90),																											'Ayuda para artículos escolares exento',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		100,		LEFT('Dotación o ayuda para anteojos gravado',90),																											'Dotación o ayuda para anteojos gravado',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		101,		LEFT('Dotación o ayuda para anteojos exento',90),																											'Dotación o ayuda para anteojos exento',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		102,		LEFT('Ayuda para transporte gravado',90),																													'Ayuda para transporte gravado',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		103,		LEFT('Ayuda para transporte exento',90),																													'Ayuda para transporte exento',																													'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		104,		LEFT('Cuotas sindicales pagadas por el patrón gravado',90),																									'Cuotas sindicales pagadas por el patrón gravado',																								'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		105,		LEFT('Cuotas sindicales pagadas por el patrón exento',90),																									'Cuotas sindicales pagadas por el patrón exento',																								'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		106,		LEFT('Subsidios por incapacidad gravado',90),																												'Subsidios por incapacidad gravado',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		107,		LEFT('Subsidios por incapacidad exento',90),																												'Subsidios por incapacidad exento',																												'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		108,		LEFT('Becas para trabajadores y/o sus hijos gravado',90),																									'Becas para trabajadores y/o sus hijos gravado',																								'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		109,		LEFT('Becas para trabajadores y/o sus hijos exento',90),																									'Becas para trabajadores y/o sus hijos exento',																									'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		110,		LEFT('Pagos efectuados por otros empleadores (sólo si el patrón que declara realizó cálculo anual) gravado',90),											'Pagos efectuados por otros empleadores (sólo si el patrón que declara realizó cálculo anual) gravado',											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		111,		LEFT('Pagos efectuados por otros empleadores (sólo si el patrón que declara realizó cálculo anual) exento',90),												'Pagos efectuados por otros empleadores (sólo si el patrón que declara realizó cálculo anual) exento',											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		112,		LEFT('Otros ingresos por salarios gravado',90),																												'Otros ingresos por salarios gravado',																											'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		113,		LEFT('Otros ingresos por salarios exento',90),																												'Otros ingresos por salarios exento',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		114,		LEFT('Suma del ingreso GRAVADO por sueldos y salarios',90),																									'Suma del ingreso GRAVADO por sueldos y salarios',																								'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		115,		LEFT('Suma del ingreso EXENTO por sueldos y salarios',90),																									'Suma del ingreso EXENTO por sueldos y salarios',																								'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		116,		LEFT('Impuesto retenido durante el ejercicio que declara',90),																								'Impuesto retenido durante el ejercicio que declara',																							'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		117,		LEFT('Impuesto retenido por otro(s) patrón(es) durante el ejercicio que declara',90),																		'Impuesto retenido por otro(s) patrón(es) durante el ejercicio que declara',																	'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		118,		LEFT('Saldo a favor determinado en el ejercicio que declara, que el patrón compensará durante el siguiente ejercicio o solicitará su devolución',90),		'Saldo a favor determinado en el ejercicio que declara, que el patrón compensará durante el siguiente ejercicio o solicitará su devolución',	'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		119,		LEFT('Saldo a favor del ejercicio anterior no compensado durante el ejercicio que declara',90),																'Saldo a favor del ejercicio anterior no compensado durante el ejercicio que declara',															'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		120,		LEFT('Suma de las cantidades que por concepto de crédito al salario le correspondió al trabajador',90),														'Suma de las cantidades que por concepto de crédito al salario le correspondió al trabajador',													'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		121,		LEFT('Crédito al salario entregado en efectivo al trabajador durante el ejercicio que declara',90),															'Crédito al salario entregado en efectivo al trabajador durante el ejercicio que declara',														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		122,		LEFT('Monto total de ingresos obtenidos por concepto de prEstaciones de previsión social',90),																'Monto total de ingresos obtenidos por concepto de prEstaciones de previsión social',															'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		123,		LEFT('Suma de ingresos exentos por concepto de prEstaciones de previsión social',90),																		'Suma de ingresos exentos por concepto de prEstaciones de previsión social',																	'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		124,		LEFT('Suma de ingresos por sueldos y salarios',90),																											'Suma de ingresos por sueldos y salarios',																										'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		125,		LEFT('Monto del impuesto local a los ingresos por sueldos, salarios y en general por la prestación de un servicio Personal subordinado retenido',90),		'Monto del impuesto local a los ingresos por sueldos, salarios y en general por la prestación de un servicio Personal subordinado retenido',	'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		126,		LEFT('Monto del subsidio para el empleo entregado en efectivo al trabajador durante el ejercicio que declara',90),											'Monto del subsidio para el empleo entregado en efectivo al trabajador durante el ejercicio que declara',										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		127,		LEFT('Total de las aportaciones voluntarias deducibles',90),																								'Total de las aportaciones voluntarias deducibles',																								'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		128,		LEFT('ISR conforme a la tarifa anual',90),																													'ISR conforme a la tarIFa anual',																												'Suma Concepto',	1,				'')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		129,		LEFT('Subsidio acreditable',90),																															'Subsidio acrediTABLE',																															'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		130,		LEFT('Subsidio no acreditable',90),																															'Subsidio no acrediTABLE',																														'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		131,		LEFT('Impuesto sobre ingresos acumulables',90),																												'Impuesto sobre ingresos acumulables',																											'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		132,		LEFT('Impuesto sobre ingresos no acumulables',90),																											'Impuesto sobre ingresos no acumulables',																										'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		133,		LEFT('Impuesto local a los ingresos por sueldos, salarios y en general por la prestación de un servicio Personal subordinado',90),							'Impuesto local a los ingresos por sueldos, salarios y en general por la prestación de un servicio Personal subordinado',						'Texto',			1,				'0')
			INSERT INTO DimCfg ( Empresa, Columna ,Titulo,Descripcion,Tipo,Obligatorio,Campo ) Values	(@Emp,		134,		LEFT('Monto del subsidio para el empleo que le correspondió al trabajador durante el ejercicio',90),														'Monto del subsidio para el empleo que le correspondió al trabajador durante el ejercicio',														'Suma Concepto',	1,				'')
  	  END  

	  SELECT @EmpAnt = @Emp
	END
END
GO
UPDATE DimCfg SET Titulo = LEFT(Descripcion,90) WHERE Titulo LIKE 'Titulo%'
GO
  EXEC spInsertarDIM
GO
/******************************* SPSDIVariables *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('DBO.SPSDIVariables') AND TYPE='P') DROP PROC SPSDIVariables
GO
CREATE PROC SPSDIVariables
	@Mov VARCHAR(25),
	@MovID VARCHAR (25)
WITH ENCRYPTION
AS BEGIN

	SELECT DISTINCT D.Personal, 
	  'NombreEmpleado'=P.ApellidoPaterno+' '+P.ApellidoMaterno+' '+P.Nombre,
	  'F.Ingreso'=P.FechaAntiguedad,
	  'Depto'=P.Departamento,
	  'Puesto'=P.Puesto,
	  'IMSS'=P.Registro3,
	  'R.F.C.'=P.Registro2,
	  'Antiguedad'=  max (CASE WHEN D.Concepto='Antiguedad' then convert (varchar (10),Cantidad) else '' end),
	  'SD'= max (CASE WHEN D.Concepto='Sueldo Diario' then convert (varchar (10),importe) else '' end),
	  'FactInteg'=max (CASE WHEN D.Concepto='Factor de Integracion' then convert (varchar (10),Cantidad) else '' end),
	  'SDILey'=max (CASE WHEN D.Concepto='Salario Integrado de Ley' then convert (varchar (10),importe) else '' end),
	  'Acum Imp Bim Var IMSS'=max (CASE WHEN D.Concepto='Acum Importe Bimestral Variable IMSS' then convert (varchar (10),Importe) else '' end),
	  'NoDiasBim'=max (CASE WHEN D.Concepto='No Dias del Bimestre' then convert (varchar (10),Cantidad) else '' end),	
	  'VariableDiaria'=max (CASE WHEN D.Concepto='Variable Diaria del Bimestre' then convert (varchar (10),importe) else '' end),
	  'SDIEstimado'= max (CASE WHEN D.Concepto='SDI Estimado' then convert (varchar (10),importe) else '' end),
	  'SDIAnterior'= max (CASE WHEN D.Concepto='SDI Usado para esta Nómina' then convert (varchar (10),importe) else '' end),
	  'CambiaSDI'= max (CASE WHEN D.Concepto='Cambia SDI' then convert (varchar (10),Cantidad) else '' end),
	  'Mes'=N.Periodo,
	  'AÑO'=N.Ejercicio	
	
	FROM NominaD D LEFT OUTER JOIN Nomina N	ON D.ID=N.ID
		       LEFT OUTER JOIN Personal P ON D.Personal=P.Personal

	WHERE MOV=@MOV
	  AND N.ESTATUS='CONCLUIDO'
	  AND MOVID=@MOVID
	  AND D.PERSONAL IS NOT NULL

	GROUP BY D.Personal, P.FechaAntiguedad, P.Departamento, P.Puesto, P.SueldoDiario, P.ApellidoPaterno, P.ApellidoMaterno, P.Nombre, P.Registro3, P.Registro2, N.Periodo, N.Ejercicio
	ORDER BY D.Personal

END
/*
EXEC SPSDIVariables 'NOMINA','46'
*/
GO
/******************************* spSDIVariablesDetalle *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('DBO.spSDIVariablesDetalle') AND TYPE='P') DROP PROC spSDIVariablesDetalle
GO
CREATE PROC spSDIVariablesDetalle
	@FechaD	 DATETIME,
	@FechaA	 DATETIME,
	@Periodo CHAR(20)
WITH ENCRYPTION
AS BEGIN

SELECT  N.Mov,
		N.MovID,
		N.Ejercicio, 
		N.Periodo, 
		N.FechaD, 
		N.FechaA, 
		D.Personal,
		'Nombre'=P.Nombre+' '+P.ApellidoPaterno+' '+P.ApellidoMaterno,
		D.Concepto, 
		D.Cantidad, 
		D.Importe 
  FROM  Nomina N JOIN NominaD D ON N.ID=D.ID
				 JOIN Personal P ON D.Personal=P.Personal
		  		 JOIN NomXPersonal NXP ON D.Concepto=NXP.Concepto
 WHERE  N.MOV='Nomina'
   AND  N.Estatus='CONCLUIDO'
   AND  N.PeriodoTipo=@Periodo
   AND  NXP.Acum LIKE '%Total Gravable IMSS Variable%' --or NXP.Acum LIKE '%Total Gravable IMSS%'
   AND  NXP.ID=1
   AND  N.FechaEmision BETWEEN @FechaD AND @FechaA
 GROUP BY  N.ID, N.Mov, N.MovID, N.FechaEmision, N.Estatus, N.Ejercicio, N.Periodo, N.FechaD, N.FechaA, D.Personal, P.Nombre, P.ApellidoPaterno, P.ApellidoMaterno, D.Concepto, D.Cantidad, D.Importe, D.Movimiento
 ORDER BY D.Personal

END
/*
EXEC spSDIVariablesDetalle '01/01/2015','28/02/2015','Quincenal' 
*/
GO
/******************************* SPNomCaratulaBorrador *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('DBO.SPNomCaratulaBorrador') AND TYPE='P') DROP PROC SPNomCaratulaBorrador
GO
CREATE PROC SPNomCaratulaBorrador
	@ID INT
WITH ENCRYPTION
AS BEGIN
	DECLARE
	@Concepto		varchar(50),
	@Movi			varchar(20),
	@Orden			int
	
	CREATE TABLE #Conceptos(
		Concepto		varchar(50) NULL,
		Importe			money NULL,
		ImportePercepciones	money NULL,
		ImporteDeducciones	money NULL,
		ImportePorPagar		money NULL,
		Nomina			varchar NULL,
		MovID			varchar (20)NULL,
	    Sucursal		int Null,
        PeriodoTipo	    varchar(10) NULL,
		Movimiento		varchar(50) NULL,
		Mov			varchar(50) NULL,
		Ejercicio		int NULL,
		FechaD			datetime NULL,
		FechaA			datetime NULL,
		Orden			int default 0)

	INSERT INTO #Conceptos(Concepto, Importe, ImportePercepciones, ImporteDeducciones, ImportePorPagar, Nomina, MovID, Sucursal, PeriodoTipo, Movimiento, Mov, Ejercicio, FechaD, FechaA)

SELECT	distinct D.Concepto,
	'Importe'=SUM(D.Importe),
	'ImportePercepciones'= CASE WHEN D.MOVIMIENTO='PERCEPCION' THEN SUM(IMPORTE) ELSE 0 END,
	'ImporteDeducciones'= CASE WHEN D.MOVIMIENTO='DEDUCCION' THEN SUM(IMPORTE) ELSE 0 END,
	'ImportePorPagar'= CASE WHEN D.MOVIMIENTO='Por Pagar' THEN SUM(IMPORTE) ELSE 0 END,
	'NOMINA'=MAX (CASE WHEN MOV IN ('NOMINA','Finiquito','Liquidacion','Aguinaldo','PTU','Fondo Ahorro') THEN MOVID ELSE '' END),
    N.MovID,
    N.Sucursal,
    N.PeriodoTipo,
	D.Movimiento,
	N.Mov,
	N.Ejercicio,
	N.FechaD,
	N.FechaA

FROM NominaD D LEFT OUTER JOIN Nomina N on D.ID=N.ID

WHERE	D.Movimiento IN ('Percepcion','Deduccion','por Pagar')
	AND	N.ID=@ID
GROUP BY D.Concepto, N.Estatus, N.Ejercicio,N.MovID,  N.Sucursal, N.PeriodoTipo, D.Movimiento, N.FechaD, N.FechaA, N.Mov
ORDER BY  D.Movimiento desc, D.CONCEPTO


	DECLARE crnom CURSOR FOR
	   SELECT t.Concepto, t.Mov, p.Orden
	FROM #Conceptos t
		 JOIN NomXPersonal p	ON	p.Concepto	=	t.Concepto
		   JOIN NomX x		ON	X.ID		=	p.ID
					AND	X.NomMov	=	t.Mov
	  OPEN crnom
	  FETCH NEXT FROM crnom INTO @Concepto, @Movi, @Orden
	  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
	  BEGIN
	    IF @@FETCH_STATUS <> -2 
	    BEGIN
		UPDATE #Conceptos SET Orden=@Orden WHERE Concepto=@Concepto AND Mov=@Movi
	    END
	    FETCH NEXT FROM crnom INTO @Concepto, @Movi, @Orden
	  END
	  CLOSE crnom
	  DEALLOCATE crnom

	SELECT * FROM #Conceptos ORDER BY Movimiento Desc, Orden

END
GO
/******************************* SPNomCaratulaBorradorXDepto *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('SPNomCaratulaBorradorXDepto') AND TYPE='P') DROP PROC SPNomCaratulaBorradorXDepto
GO
CREATE PROC SPNomCaratulaBorradorXDepto
	@ID INT
WITH ENCRYPTION
AS BEGIN
	DECLARE
	@Concepto		varchar(50),
	@Movi			varchar(20),
	@Orden			int
	
	CREATE TABLE #Conceptos(
		Concepto		varchar(50) NULL,
		Importe			money NULL,
		ImportePercepciones	money NULL,
		ImporteDeducciones	money NULL,
		Nomina			int NULL,
		Movimiento		varchar(50) NULL,
		Mov			varchar(50) NULL,
		Departamento		varchar(50) NULL,
		FechaD			datetime NULL,
		FechaA			datetime NULL,
		Orden			int default 0)

	INSERT INTO #Conceptos(Concepto, Importe, ImportePercepciones, ImporteDeducciones, Nomina, Movimiento, Mov, FechaD, FechaA, Departamento)

SELECT DISTINCT D.Concepto,
	'Importe' = SUM(D.Importe),
	'ImportePercepciones' = CASE WHEN D.Movimiento = 'PERCEPCION' THEN SUM(Importe) ELSE 0 END,
	'ImporteDeducciones' = CASE WHEN D.Movimiento = 'DEDUCCION' THEN SUM(Importe) ELSE 0 END,
	'NOMINA' = MAX (CASE WHEN Mov IN ('NOMINA','Finiquito','Liquidacion','Aguinaldo','PTU','Fondo de Ahorro') THEN MovID ELSE '' END),
	D.Movimiento,
	N.Mov,
	N.FechaD,
	N.FechaA,
	P.Departamento

FROM Nomina N JOIN NominaD D ON N.ID=D.ID
			  JOIN Personal P ON D.Personal=P.Personal		
--			  JOIN NominaPersonal NP ON D.Personal=NP.Personal

WHERE D.Movimiento IN ('Percepcion','Deduccion')
AND N.ID=@ID

GROUP BY P.Departamento, D.Concepto, D.Movimiento, N.Estatus, D.Movimiento, N.FechaD, N.FechaA, N.Mov

ORDER BY P.Departamento, D.Movimiento desc, D.CONCEPTO
	
	DECLARE crnom CURSOR FOR
	   SELECT t.Concepto, t.Mov, p.Orden
	FROM #Conceptos t
		 JOIN NomXPersonal p	ON	p.Concepto	=	t.Concepto
		   JOIN NomX x		ON	X.ID		=	p.ID
					AND	X.NomMov	=	t.Mov
	  OPEN crnom
	  FETCH NEXT FROM crnom INTO @Concepto, @Movi, @Orden
	  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
	  BEGIN
    IF @@FETCH_STATUS <> -2 
	    BEGIN
		UPDATE #Conceptos SET Orden=@Orden WHERE Concepto=@Concepto AND Mov=@Movi
	    END
	    FETCH NEXT FROM crnom INTO @Concepto, @Movi, @Orden
	  END
	  CLOSE crnom
	  DEALLOCATE crnom

	SELECT * FROM #Conceptos ORDER BY Departamento, Movimiento Desc, Orden

END
GO
/******************************* spDispMag *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('DBO.spDispMag') AND TYPE='P') DROP PROC spDispMag
GO
CREATE PROCEDURE spDispMag
				   (@Mov			varchar(20),
					@FechaD			DateTime,
					@FechaA			DateTime)
--					@RegistroPat    Varchar(11))
--					@Empresa		Varchar(5))
--//WITH ENCRYPTION
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
GO
/******************************* SPNomConceptoBorrador *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('DBO.SPNomConceptoBorrador') AND TYPE='P') DROP PROC SPNomConceptoBorrador
GO
CREATE PROC SPNomConceptoBorrador
	@ID INT
WITH ENCRYPTION
AS BEGIN
  SELECT D.id, D.Personal, P.ApellidoPaterno, P.ApellidoMaterno, P.Nombre, P.Departamento, D.Movimiento, D.Concepto, D.Importe, D.Cantidad 
    FROM NominaD D 
    JOIN Personal P on D.Personal=P.Personal 
   WHERE ID=@ID and D.Movimiento in ('Percepcion','Deduccion')

END
GO
/******************************* SPNominaPTU *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('SPNominaPTU') AND TYPE='P') DROP PROC SPNominaPTU
GO
CREATE PROC SPNominaPTU    
   @ID INT        
WITH ENCRYPTION
AS BEGIN    
    
    SELECT  D.PERSONAL,    
            P.ApellidoPaterno+' '+P.ApellidoMaterno+' '+P.Nombre as [NombreEmpleado],    
            'AcumImporteSueldoAñoAnt'= max (CASE WHEN D.CONCEPTO='Sueldo Acumulado' then D.Importe else 0 end),      
            'AcumDiasSueldoAñoAnt'= max (CASE WHEN D.CONCEPTO='Sueldo Acumulado' then D.Cantidad else 0 end),    
            'FactorDias'= max (CASE WHEN D.CONCEPTO='Factor Dias' then convert (varchar (30),importe) else '' end),    
            'FactorSdo'= max (CASE WHEN D.CONCEPTO='Factor Sueldo' then convert (varchar (30),importe) else '' end),    
            'PTUDias'= max (CASE WHEN D.CONCEPTO='PTU Dias' then D.importe else 0 end),    
            'PTUSueldo'= max (CASE WHEN D.CONCEPTO='PTU Sueldo' then D.importe else 0 end),    
            'SueldoTopado'= max (CASE WHEN D.CONCEPTO='Sueldo Topado' then D.importe else 0 end),    
            'TotalPTU'= max (CASE WHEN D.CONCEPTO='Total PTU' then D.importe else 0 end),    
            'DiasAcumulados'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then convert (varchar (30),Cantidad) else '' end),    
            'SueldoAcumulado'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then D.Importe else 0 end),    
            'SueldoTopePTU'= max (CASE WHEN D.CONCEPTO='Sueldo para PTU' then D.importe else 0 end), 
            'UtilidadRepartir'= max (CASE WHEN D.CONCEPTO='Utilidad Repartible' then D.importe else 0 end),
            P.CentroCostos,    
            N.FechaEmision  
       FROM NOMINA N LEFT OUTER JOIN NOMINAD D  ON  N.ID=D.ID    
  LEFT JOIN PERSONAL P  ON D.PERSONAL=P.PERSONAL    
  LEFT JOIN NominaPersonal NP ON NP.Personal=P.Personal    
      WHERE   N.ID=@ID    
        AND  D.Personal is not null    
     -- AND  Importe not in (null,0,'')         
   GROUP BY D.PERSONAL, ApellidoPaterno,ApellidoMaterno, P.Nombre, N.Ejercicio, P.CentroCostos, N.FechaEmision    
   ORDER BY D.PERSONAL        

END     
/*      
EXEC  SPNominaPTU  '253'    
*/    
GO
/******************************* SpReciboNomina *************************************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID= OBJECT_ID ('SpReciboNomina') AND TYPE='P') DROP PROC SpReciboNomina
GO
CREATE  Procedure SpReciboNomina
          @Empresa  char(20),        
          @Mov   char(20),        
          @MovID   varchar(20),        
          @Personal  char(10),        
          @Departamento  char(50),        
          @Puesto   char(50),        
          @Categoria  char(50),        
          @Grupo   char(50),        
          @Ejercicio Int        
--//WITH ENCRYPTION                                
AS BEGIN        
-------------Declaracion de Tablas Temporales-----------------------------------        
 Create Table #Recibo(        
   ID   int IDENTITY(1,1),        
   NominaID  int null,        
   Personal  char(10) COLLATE Database_Default null,        
   EmpresaNombre char(100) COLLATE Database_Default null,        
   Direccion  char(100) COLLATE Database_Default null,        
   Nombre  char(100) COLLATE Database_Default null,        
   ApellidoPaterno char(50) COLLATE Database_Default null,        
   ApellidoMaterno char(50) COLLATE Database_Default null,        
   Cantidad  Money null,        
   FechaD  DateTime null,        
   FechaA  DateTime null,        
   ConceptoPercepcion char(100) COLLATE Database_Default null,        
   CantidadPercepcion Money NULL,        
   ImportePercepcion Money NULL,        
   ConceptoDeduccion char(100) null,        
   CantidadDeduccion Money NULL,        
   ImporteDeduccion Money NULL,        
   Consecutivo  int null)        
        
 Truncate Table #Recibo        
        
Create Table #RECIBX1(        
   Orden INT null,        
   ID  int null,        
   Consecutivo int null,        
   FechaD  DateTime null,        
   FechaA  DateTime null,         
   Cantidad  Money null,        
   NominaID  int null,        
   Personal  char(10) null,        
   EmpresaNombre char(100) null,        
   Direccion  char(100) null,        
   Nombre  char(100) null,        
   ApellidoPaterno char(50) null,        
   ApellidoMaterno char(50) null,        
   ConceptoPercepcion char(100) null,        
   CantidadPercepcion Money NULL,        
   ImportePercepcion Money NULL,        
   ConceptoDeduccion char(100) null,        
   CantidadDeduccion Money NULL,        
   ImporteDeduccion Money NULL,        
   Departamento  char(50) null,        
   Categoria   char(50) null,        
   Puesto      char(50) null,        
   Grupo       char(50) null,        
   FechaAlta   DateTime null,        
   Registro2   char(30) null,        
   Registro3   char(30) null,        
   SueldoDiario Money NULL,        
   Percepciones Money NULL,        
   Deducciones  Money NULL        
)        
        
 Truncate Table #RECIBX1        
        
Create Table #RECIBX2(        
   Orden  INT null,        
   ID   int null,        
   Consecutivo  int null,        
   FechaD  DateTime null,        
   FechaA  DateTime null,         
   Cantidad  Money null,        
   NominaID  int null,        
   Personal  char(10) null,        
   EmpresaNombre char(100) null,        
   Direccion  char(100) null,        
   Nombre  char(100) null,        
   ApellidoPaterno char(50) null,        
   ApellidoMaterno char(50) null,        
   ConceptoPercepcion char(100) null,        
   CantidadPercepcion Money NULL,        
   ImportePercepcion Money NULL,        
   ConceptoDeduccion char(100) null,        
   CantidadDeduccion Money NULL,        
   ImporteDeduccion Money NULL,        
   Departamento  char(50) null,        
   Categoria  char(50) null,        
   Puesto   char(50) null,        
   Grupo   char(50) null,        
   FechaAlta DateTime null,        
   Registro2  char(30) null,        
   Registro3  char(30) null,        
   SueldoDiario  Money NULL,        
   Percepciones  Money NULL,        
   Deducciones   Money NULL        
)        
        
 Truncate Table #RECIBX2        
        
Create Table #Recibo2(        
   ID  int null,        
   FechaD  DateTime null,        
   FechaA  DateTime null,        
   Personal  char(10) null,        
   Empresa   char(5) null,        
   Nombre    char(100) null,        
   Direccion  char(100) null,        
   NombrePersonal  char(30) null,        
   ApellidoPaterno  char(30) null,        
   ApellidoMaterno  char(30) null,        
   Movimiento  char(20) null,        
   Concepto   char(50) null,        
   Cantidad  money null,        
   Importe   money null        
)         
        
 Truncate Table #Recibo2        
---------Declaracion de Variables internas----------------------------------        
 Declare        
   @Linea    varchar(1000),        
   @ConceptoPercepcionRecibo  char(100),        
   @ConceptoDeduccionRecibo  char(100),        
   @NominaID    int,        
   @NominaIDRecibo   int,        
   @ID     int,        
   @PersonalRecibo   char(10),        
   @EmpresaNombre   char(100),        
   @Direccion    char(100),        
   @Nombre    char(50),        
   @ApellidoPaterno   char(50),        
   @ApellidoMaterno   char(50),        
   @Movimiento    char(20),        
   @Concepto    char(50),        
   @Cantidad    Money,        
   @FechaD    DateTime,        
   @FechaA    DateTime,        
   @Importe    Money,        
   @Conta_1    Int,        
   @Movimiento2   char(20),        
   @Personal2   char(10)        
         
 IF @Personal     IN ('NULL', '(TODOS)', '') SELECT @Personal = NULL        
 IF @Departamento IN ('NULL', '(TODOS)', '') SELECT @Departamento = NULL        
 IF @Puesto       IN ('NULL', '(TODOS)', '') SELECT @Puesto = NULL        
 IF @Categoria    IN ('NULL', '(TODOS)', '') SELECT @Categoria = NULL        
 IF @Grupo        IN ('NULL', '(TODOS)', '') SELECT @Grupo = NULL        
        
 SELECT @Linea=''        
        
 -- Agrupa las cantidades de dos o mas conceptos        
 Insert into #Recibo2(ID,FechaD,FechaA,Personal,Empresa,Nombre,Direccion,NombrePersonal,ApellidoPaterno,        
                      ApellidoMaterno,Movimiento,Concepto,Cantidad,Importe)        
        
SELECT Nomina.Id,Nomina.FechaD,Nomina.FechaA,Personal.Personal,Empresa.Empresa,Empresa.Nombre,Empresa.Direccion,        
     Personal.Nombre,Personal.ApellidoPaterno,Personal.ApellidoMaterno,NominaD.Movimiento,NominaD.Concepto,        
     NominaD.Cantidad,NominaD.Importe        
   FROM Nomina,NominaD,Personal,Empresa--, NomXPersonal, NomX --, NominaConcepto        
   WHERE        
     NominaD.Id=Nomina.Id        
     AND NominaD.Personal=Personal.Personal        
     AND Nomina.Estatus='CONCLUIDO'        
     AND Empresa.Empresa=Nomina.Empresa AND Empresa.Empresa= @Empresa        
     AND Nomina.Mov=@Mov        
     AND Nomina.MovID= @MovID        
     AND Nomina.Ejercicio=@Ejercicio        
        
-- SELECT Nomina.Id,Nomina.FechaD,Nomina.FechaA,Personal.Personal,Empresa.Empresa,Empresa.Nombre,Empresa.Direccion,        
--     Personal.Nombre,Personal.ApellidoPaterno,Personal.ApellidoMaterno,NominaD.Movimiento,NominaD.Concepto,        
--     NominaD.Cantidad,NominaD.Importe        
--   FROM Nomina,NominaD,Personal,Empresa, NomXPersonal, NomX        
--   WHERE        
--     NominaD.Id=Nomina.Id        
--     AND NominaD.Personal=Personal.Personal        
--     AND Nomina.Estatus='Concluido'        
--     AND Empresa.Empresa=Nomina.Empresa AND Empresa.Empresa= @Empresa        
--     AND Nomina.Mov= @Mov        
--     AND Nomina.MovID= @MovID        
--     AND Nomina.Ejercicio=@Ejercicio        
     AND ISNULL(Personal.Personal, '') = ISNULL(ISNULL(@Personal, Personal.Personal), '')        
     AND ISNULL(Personal.Departamento, '') = ISNULL(ISNULL(@Departamento, Personal.Departamento), '')        
     AND ISNULL(Personal.Puesto, '') = ISNULL(ISNULL(@Puesto, Personal.Puesto), '')        
     AND ISNULL(Personal.Categoria, '') = ISNULL(ISNULL(@Categoria, Personal.Categoria), '')        
     AND ISNULL(Personal.Grupo, '') = ISNULL(ISNULL(@Grupo, Personal.Grupo), '')        
     --AND NominaConcepto.concepto = Nominad.Concepto        
     --AND NominaConcepto.nominaconcepto = Nominad.nominaConcepto        
        
    -- AND NomX.Nombre = Nomina.Concepto        
    -- AND NomXPersonal.Concepto =  NominaD.Concepto and NomXPersonal.ID = NomX.ID        
--           
  ORDER BY NominaD.Personal, NominaD.Movimiento-- , NomXPersonal.Orden        
           
  -----------------------------        
        
 DECLARE Recibo CURSOR FOR        
  Select  *        
     from #Recibo2 order by personal,movimiento desc        
        
   set @Personal2 = ''        
   set @Movimiento2  = ''        
        
 Open Recibo        
 FETCH NEXT FROM Recibo        
 INTO @NominaID, @FechaD, @FechaA,@Personal, @Empresa, @EmpresaNombre, @Direccion, @Nombre,  @ApellidoPaterno ,        
   @ApellidoMaterno ,@Movimiento,@Concepto,   @Cantidad        ,   @Importe                  
 WHILE @@FETCH_STATUS = 0        
 BEGIN        
  --Select @OrdenConcepto, @Concepto        
   --Select @Personal2 as '@Personal2' , @Personal as '@Personal' , @Movimiento2 as '@Movimiento2' , @Movimiento as '@Movimiento'        
        
   IF (@Personal2 <> @Personal) --or @Movimiento2 <> @Movimiento)        
 and @Movimiento in ('Percepcion','Deduccion')        
 set @Conta_1 = 0         
   IF @Movimiento in ('Percepcion','Deduccion')        
   begin        
   set @Conta_1 = @Conta_1  + 1            
   --Select @Movimiento as Movimiento , @Conta_1 as Conta_1        
 END         
          
        
   IF (@Movimiento='Deduccion' )         
   BEGIN        
     set @Personal2 = @Personal        
     set @Movimiento2 = 'Deduccion'         
     SELECT        
       @ID=id,        
       @FechaD=FechaD,        
       @FechaA=FechaA,        
       @NominaIDRecibo=NominaID,        
       @PersonalRecibo=Personal,        
       @Cantidad=ISNULL(Cantidad,0),        
       @ConceptoPercepcionRecibo=ISNULL(ConceptoPercepcion,''),        
       @ConceptoDeduccionRecibo=ISNULL(ConceptoDeduccion,'')        
     FROM        
       #RECIBO        
     WHERE        
       ID=(SELECT MIN(ID) FROM #Recibo WHERE NominaID=@NominaID AND Personal=@Personal  AND ConceptoDeduccion Is Null)        
     IF @@RowCount=0        
       INSERT INTO #Recibo        
                (NominaID,FechaD, FechaA, Cantidad, Personal,EmpresaNombre, Direccion, Nombre, ApellidoPaterno, ApellidoMaterno,        
                 ConceptoDeduccion,CantidadDeduccion,ImporteDeduccion, Consecutivo)        
       Values   (@NominaID,@FechaD, @FechaA, @Cantidad, @Personal,@EmpresaNombre,@Direccion,@Nombre,@ApellidoPaterno,@ApellidoMaterno,        
                 isnull(@Concepto,''), isnull(@Cantidad,0), isnull(@Importe,0), @Conta_1)        
     ELSE        
     BEGIN        
       UPDATE #Recibo        
         SET ConceptoDeduccion=@Concepto,ImporteDeduccion=@Importe,CantidadDeduccion=@Cantidad        
       WHERE        
         ID=@ID        
       set @Conta_1 = @Conta_1  - 1        
     END        
    END        
   ELSE IF @Movimiento = 'Percepcion'         
   BEGIN        
     set @Personal2 = @Personal        
     set @Movimiento2 = 'Percepcion'        
     SELECT        
       @ID=ID,        
       @FechaD=FechaD,        
       @FechaA=FechaA,        
       @NominaIDRecibo=NominaID,        
       @PersonalRecibo=Personal,        
       @Cantidad=ISNULL(Cantidad,0),        
       @ConceptoPercepcionRecibo=ISNULL(ConceptoPercepcion,''),        
       @ConceptoDeduccionRecibo=ISNULL(ConceptoDeduccion,'')        
     FROM        
       #RECIBO        
     WHERE        
       ID=(SELECT MIN(ID) FROM #Recibo WHERE NominaID=@NominaID AND Personal=@Personal  AND ConceptoPercepcion Is Null)        
     IF @@RowCount=0        
       INSERT Into #Recibo        
                 (NominaID, FechaD, FechaA, Cantidad, Personal,EmpresaNombre, Direccion, Nombre, ApellidoPaterno, ApellidoMaterno,        
                  ConceptoPercepcion,CantidadPercepcion,ImportePercepcion, Consecutivo)        
     Values (@NominaID,@FechaD, @FechaA, @Cantidad, @Personal,@EmpresaNombre,@Direccion,@Nombre,@ApellidoPaterno,@ApellidoMaterno,        
                  isnull(@Concepto,''), isnull(@Cantidad,0), isnull(@Importe,0), @Conta_1)        
     ELSE        
     BEGIN        
       UPDATE #Recibo        
        SET ConceptoPercepcion=@Concepto,ImportePercepcion=@Importe,CantidadPercepcion=@Cantidad        
       WHERE        
         Id=@ID        
       set @Conta_1 = @Conta_1  - 1        
     END          
   END        
/*FETCH NEXT FROM Recibo        
   INTO     @NominaID,     @FechaD,     @FechaA,     @Personal,     @Empresa,     @EmpresaNombre,     @Direccion,        
     @Nombre,     @ApellidoPaterno ,     @ApellidoMaterno ,     @Movimiento      ,     @Concepto        ,     @Cantidad        ,        
     @Importe        
*/        
Siguiente:        
           
   FETCH NEXT FROM Recibo        
   INTO     @NominaID,     @FechaD,     @FechaA,     @Personal,     @Empresa,     @EmpresaNombre,     @Direccion,        
     @Nombre,     @ApellidoPaterno ,     @ApellidoMaterno ,     @Movimiento      ,     @Concepto        ,     @Cantidad        ,        
     @Importe        
             
 END--end del while fetch        
 CLOSE Recibo        
 DEALLOCATE Recibo        
        
 INSERT INTO #RECIBX1(Orden,ID,Consecutivo,FechaD,FechaA,Cantidad,NominaID,Personal,EmpresaNombre,Direccion,Nombre,        
                      ApellidoPaterno,ApellidoMaterno,ConceptoPercepcion,CantidadPercepcion,ImportePercepcion,        
                      ConceptoDeduccion,CantidadDeduccion,ImporteDeduccion,Departamento,Categoria,Puesto,Grupo,        
                      FechaAlta,Registro2,Registro3,SueldoDiario,Percepciones,Deducciones)         
  SELECT 1,a.ID,a.Consecutivo,a.FechaD,a.FechaA,a.Cantidad,a.NominaID,a.Personal,a.EmpresaNombre,a.Direccion,        
            a.Nombre,a.ApellidoPaterno,a.ApellidoMaterno, ISNULL(a.ConceptoPercepcion,''),        
            ISNULL(a.CantidadPercepcion,0),ISNULL(a.ImportePercepcion,0),        
            ISNULL(a.ConceptoDeduccion,''),ISNULL(a.CantidadDeduccion,0),        
            ISNULL(a.ImporteDeduccion,0),b.Departamento, b.Categoria, b.Puesto, b.Grupo,b.FechaAlta,        
            b.Registro2,ISNULL(b.Registro3,''),b.SueldoDiario,c.Percepciones,c.Deducciones        
            --c.FechaA        
  FROM #Recibo a        
   Left join Personal b on a.personal=b.Personal        
   Left join Nomina c on a.NominaID=c.id        
  --Order by a.personal        
--Union        
   INSERT INTO #RECIBX2(Orden,ID,Consecutivo,FechaD,FechaA,Cantidad,NominaID,Personal,EmpresaNombre,Direccion,Nombre,        
                      ApellidoPaterno,ApellidoMaterno,ConceptoPercepcion,CantidadPercepcion,ImportePercepcion,        
                      ConceptoDeduccion,CantidadDeduccion,ImporteDeduccion,Departamento,Categoria,Puesto,Grupo,        
                      FechaAlta,Registro2,Registro3,SueldoDiario,Percepciones,Deducciones)        
   SELECT 2,a.ID,a.Consecutivo,a.FechaD,a.FechaA,a.Cantidad,a.NominaID,a.Personal,a.EmpresaNombre,a.Direccion,        
            a.Nombre,a.ApellidoPaterno,a.ApellidoMaterno,ISNULL(a.ConceptoPercepcion,''),         
     ISNULL(a.CantidadPercepcion,0),ISNULL(a.ImportePercepcion,0),        
            ISNULL(a.ConceptoDeduccion,''),ISNULL(a.CantidadDeduccion,0),        
            ISNULL(a.ImporteDeduccion,0),b.Departamento,b.Categoria,b.Puesto,b.Grupo,b.FechaAlta,        
            b.Registro2,ISNULL(b.Registro3,''),b.SueldoDiario,c.Percepciones,c.Deducciones        
            --c.FechaA        
   FROM #Recibo a        
   Left join Personal b on a.personal=b.Personal        
   Left join Nomina c on a.NominaID=c.id        
  --Order by a.personal        
        
--END        
        
 Select Orden,NominaID,FechaD,FechaA,Personal,EmpresaNombre,Direccion,Nombre,ApellidoPaterno,ApellidoMaterno,Departamento,         
       Categoria,Puesto,Grupo,FechaAlta,Registro2,Registro3,SueldoDiario,        
 ConceptoPercepcion1 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1),        
       CantidadPercepcion1 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1),        
       ImportePercepcion1 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1)        
       ,ConceptoDeduccion1 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       CantidadDeduccion1 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       Importededuccion1 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       ConceptoPercepcion2 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       CantidadPercepcion2 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ImportePercepcion2 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ConceptoDeduccion2 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       CantidadDeduccion2 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       Importededuccion2 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ConceptoPercepcion3 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       CantidadPercepcion3 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ImportePercepcion3 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ConceptoDeduccion3 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       CantidadDeduccion3 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       Importededuccion3 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ConceptoPercepcion4 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       CantidadPercepcion4 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ImportePercepcion4 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ConceptoDeduccion4 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       CantidadDeduccion4 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       Importededuccion4 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ConceptoPercepcion5 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       CantidadPercepcion5 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ImportePercepcion5 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ConceptoDeduccion5 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       CantidadDeduccion5 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       Importededuccion5 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ConceptoPercepcion6 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       CantidadPercepcion6 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ImportePercepcion6 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ConceptoDeduccion6 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       CantidadDeduccion6 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       Importededuccion6 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ConceptoPercepcion7 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       CantidadPercepcion7 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ImportePercepcion7 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ConceptoDeduccion7 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       CantidadDeduccion7 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       Importededuccion7 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ConceptoPercepcion8 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       CantidadPercepcion8 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       ImportePercepcion8 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       ConceptoDeduccion8 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       CantidadDeduccion8 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       Importededuccion8 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8)        
      , ConceptoPercepcion9 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       CantidadPercepcion9 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ImportePercepcion9 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ConceptoDeduccion9 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       CantidadDeduccion9 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       Importededuccion9 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ConceptoPercepcion10 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       CantidadPercepcion10 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ImportePercepcion10 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ConceptoDeduccion10 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       CantidadDeduccion10 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       Importededuccion10 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ConceptoPercepcion11 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       CantidadPercepcion11 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ImportePercepcion11 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ConceptoDeduccion11 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       CantidadDeduccion11 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       Importededuccion11 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ConceptoPercepcion12 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       CantidadPercepcion12 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       ImportePercepcion12 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       ConceptoDeduccion12 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       CantidadDeduccion12 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       Importededuccion12 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
ConceptoPercepcion13 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       CantidadPercepcion13 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       ImportePercepcion13 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       ConceptoDeduccion13 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       CantidadDeduccion13 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       Importededuccion13 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
ConceptoPercepcion14 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       CantidadPercepcion14 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       ImportePercepcion14 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       ConceptoDeduccion14 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       CantidadDeduccion14 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       Importededuccion14 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
ConceptoPercepcion15 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       CantidadPercepcion15 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       ImportePercepcion15 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       ConceptoDeduccion15 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       CantidadDeduccion15 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       Importededuccion15 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15)        
        
From #RECIBX1 --where consecutivo='1'        
Group by Orden,NominaID,FechaD,FechaA,Personal,EmpresaNombre,Direccion,Nombre,ApellidoPaterno,ApellidoMaterno,        
       Departamento,Categoria,Puesto,Grupo,FechaAlta,Registro2,Registro3,SueldoDiario        
--Order by personal,orden        
/*        
Union All        
Select 'Orden'='2',NominaID,FechaD,FechaA,Personal,EmpresaNombre,Direccion,Nombre,ApellidoPaterno,ApellidoMaterno,Departamento,         
       Categoria,Puesto,Grupo,FechaAlta,Registro2,Registro3,SueldoDiario,        
       ConceptoPercepcion1 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1),        
       CantidadPercepcion1 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1),        
       ImportePercepcion1 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBx1.Personal and Consecutivo = 1)        
       ,ConceptoDeduccion1 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       CantidadDeduccion1 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       Importededuccion1 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 1),        
       ConceptoPercepcion2 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       CantidadPercepcion2 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ImportePercepcion2 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ConceptoDeduccion2 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       CantidadDeduccion2 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       Importededuccion2 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 2),        
       ConceptoPercepcion3 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       CantidadPercepcion3 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ImportePercepcion3 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ConceptoDeduccion3 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       CantidadDeduccion3 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       Importededuccion3 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 3),        
       ConceptoPercepcion4 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       CantidadPercepcion4 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ImportePercepcion4 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ConceptoDeduccion4 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       CantidadDeduccion4 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       Importededuccion4 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 4),        
       ConceptoPercepcion5 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       CantidadPercepcion5 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ImportePercepcion5 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ConceptoDeduccion5 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       CantidadDeduccion5 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       Importededuccion5 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 5),        
       ConceptoPercepcion6 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       CantidadPercepcion6 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ImportePercepcion6 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ConceptoDeduccion6 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       CantidadDeduccion6 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       Importededuccion6 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 6),        
       ConceptoPercepcion7 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       CantidadPercepcion7 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ImportePercepcion7 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ConceptoDeduccion7 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       CantidadDeduccion7 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       Importededuccion7 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 7),        
       ConceptoPercepcion8 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       CantidadPercepcion8 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       ImportePercepcion8 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       ConceptoDeduccion8 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       CantidadDeduccion8 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8),        
       Importededuccion8 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 8)        
      , ConceptoPercepcion9 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       CantidadPercepcion9 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ImportePercepcion9 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ConceptoDeduccion9 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       CantidadDeduccion9 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       Importededuccion9 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 9),        
       ConceptoPercepcion10 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       CantidadPercepcion10 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ImportePercepcion10 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ConceptoDeduccion10 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       CantidadDeduccion10 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       Importededuccion10 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 10),        
       ConceptoPercepcion11 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       CantidadPercepcion11 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ImportePercepcion11 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ConceptoDeduccion11 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       CantidadDeduccion11 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       Importededuccion11 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 11),        
       ConceptoPercepcion12 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       CantidadPercepcion12 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       ImportePercepcion12 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       ConceptoDeduccion12 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       CantidadDeduccion12 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
       Importededuccion12 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 12),        
ConceptoPercepcion13 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       CantidadPercepcion13 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       ImportePercepcion13 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       ConceptoDeduccion13 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       CantidadDeduccion13 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
       Importededuccion13 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 13),        
ConceptoPercepcion14 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       CantidadPercepcion14 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       ImportePercepcion14 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       ConceptoDeduccion14 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       CantidadDeduccion14 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
       Importededuccion14 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 14),        
ConceptoPercepcion15 = (Select ConceptoPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       CantidadPercepcion15 = (Select CantidadPercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       ImportePercepcion15 = (Select ImportePercepcion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       ConceptoDeduccion15 = (Select ConceptoDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       CantidadDeduccion15 = (Select CantidadDeduccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15),        
       Importededuccion15 = (Select Importededuccion from #RECIBO a Where a.Personal = #RECIBX1.Personal and Consecutivo = 15)        
        
From #RECIBX1 --where consecutivo='1'      
        
Group by Orden,NominaID,FechaD,FechaA,Personal,EmpresaNombre,Direccion,Nombre,ApellidoPaterno,ApellidoMaterno,        
       Departamento,Categoria,Puesto,Grupo,FechaAlta,Registro2,Registro3,SueldoDiario        
Order by personal,orden        
*/        
--Select * from #Recibo2        
--Select * from #RECIBX1        
--Select * from #RECIBX2        
        
END        
GO
/***************** spSUAMovimientos *************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('spSUAMovimientos') AND TYPE='P') DROP PROC spSUAMovimientos
GO
CREATE PROCEDURE spSUAMovimientos
	@EMPRESA		CHAR(10),
	@FechaD			DATETIME,
	@FechaA			DATETIME
--	@RegistroPat    Varchar(11)
WITH ENCRYPTION
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
						WHEN 'Modificaciones'		THEN '07'
						WHEN 'Reingresos'			THEN '08'
						WHEN 'Bajas'				THEN '02'
						WHEN 'Alta Reg. Patronal'	THEN '08'
						WHEN 'Baja Reg. Patronal'	THEN '02'
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
	A.Mov IN('Reingresos','Modificaciones','Bajas','Alta Reg. Patronal','Baja Reg. Patronal') AND
	PersonalPropValor.Propiedad ='Registro Patronal' AND 
	A.Empresa = Personal.Empresa AND 
	A.Sucursal= Personal.SucursalTrabajo AND
	PersonalPropValor.Cuenta = Personal.Personal


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

GO

IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('DBO.spSUATrabajador') AND TYPE='P') DROP PROC spSUATrabajador
GO
CREATE PROC spSUATrabajador  
  @EMPRESA  VARCHAR(20),  
  @FECHAD   DATETIME,  
  @FECHAA   DATETIME  
WITH ENCRYPTION
AS BEGIN
SELECT   
    PersonalPropValor.Valor RegistroPatronal,  
    SucursalTrabajo,  
    Registro3             IMSS,  
    Registro2             RFC,  
    Registro              CURP,  
    ApellidoPaterno+'$'+ApellidoMaterno+'$'+Personal.Nombre Nombre,  
    TipoTrabajador = CASE TipoContrato   
                       WHEN 'Construccion' THEN '3'  
                       WHEN 'Eventual'     THEN '2'    
                       ELSE '1'  
                     END,  
    Jornada = Case Jornada WHEN 'Horario Completo' THEN '0' END,  
    Right('0'+ltrim(DATEPART(dd,FechaAlta)),2)+right('0'+ltrim(DATEPART(mm,FechaAlta)),2)+LTRIM(DATEPART(yyyy,FechaAlta)) FechaAlta,  
    SDI * 100 SDI,  
    Personal  
FROM   
      Personal JOIN Sucursal ON Personal.SucursalTrabajo=Sucursal.Sucursal JOIN
      PersonalPropValor ON Sucursal.Sucursal=PersonalPropValor.Cuenta  
WHERE   
      Personal.Estatus = 'ALTA' AND  
      Personal.Empresa = @EMPRESA AND  
      PersonalPropValor.Propiedad = 'Registro Patronal' AND
      PersonalPropValor.Cuenta = Personal.SucursalTrabajo AND
      Sucursal.Sucursal = Personal.SucursalTrabajo AND  
      Personal.FechaAntiguedad BETWEEN @FECHAD AND @FECHAA  
  
END  
GO
/***************** spSUATrabajador *************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('spSUATrabajador') AND TYPE='P') DROP PROC spSUATrabajador
GO
CREATE PROC spSUATrabajador  
  @EMPRESA  VARCHAR(20),  
  @FECHAD   DATETIME,  
  @FECHAA   DATETIME  
--//WITH ENCRYPTION
AS BEGIN  
  
SELECT   
    PersonalPropValor.Valor RegistroPatronal,  
    SucursalTrabajo,  
    Registro3             IMSS,  
    Registro2             RFC,  
    Registro              CURP,  
    ApellidoPaterno+'$'+ApellidoMaterno+'$'+Personal.Nombre Nombre,  
    TipoTrabajador = CASE TipoContrato   
                       WHEN 'Construccion' THEN '3'  
                       WHEN 'Eventual'     THEN '2'    
                       ELSE '1'  
                     END,  
    Jornada = Case Jornada WHEN 'Horario Completo' THEN '0' END,  
    Right('0'+ltrim(DATEPART(dd,FechaAlta)),2)+right('0'+ltrim(DATEPART(mm,FechaAlta)),2)+LTRIM(DATEPART(yyyy,FechaAlta)) FechaAlta,  
    SDI * 100 SDI,  
    Personal  
FROM   
      Personal JOIN Sucursal ON Personal.SucursalTrabajo=Sucursal.Sucursal JOIN
      PersonalPropValor ON Sucursal.Sucursal=PersonalPropValor.Cuenta  
WHERE   
      Personal.Estatus = 'ALTA' AND  
      Personal.Empresa = @EMPRESA AND  
      PersonalPropValor.Propiedad = 'Registro Patronal' AND
      PersonalPropValor.Cuenta = Personal.SucursalTrabajo AND
      Sucursal.Sucursal = Personal.SucursalTrabajo AND  
      Personal.FechaAntiguedad BETWEEN @FECHAD AND @FECHAA  
  
END  
/*  
EXEC    spSUATrabajador  'INT', '01/01/2014' ,'30/09/2014'
*/  
GO
/***************** spNomAniversario *************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('spNomAniversario') AND TYPE='P') DROP PROC spNomAniversario
GO
CREATE PROC spNomAniversario  
@Personal varchar(10),      
@PeriodoTipo varchar(20),      
@FechaD datetime,      
@FechaA datetime      
WITH ENCRYPTION
AS      
BEGIN      
 DECLARE       
 @FechaAlta DATETIME,      
 @EsAniversario INT,       
 @FechaVar datetime,    
 @DiaRango int,    
 @MesRango int,    
 @AmoRango int,    
 @DiaAniv int,    
 @MesAniv int,    
 @AmoAniv int    
      
    
 SELECT @FechaAlta=FechaAntiguedad FROM personal WHERE Personal=@Personal and PeriodoTipo=@PeriodoTipo     
 --select   convert(varchar,@FechaD), convert(varchar,@FechaA),convert(varchar,@FechaAlta)     
 SELECT @EsAniversario =0    
 SET @FechaVar=@FechaD    
 SELECT @DiaAniv=datepart(day,@FechaAlta),@MesAniv=datepart(month,@FechaAlta),@AmoAniv=datepart(year,@FechaAlta)    
 IF @DiaAniv=29 AND @MesAniv=2    
  SET @DiaAniv=28    
 WHILE  @FechaVar<=@FechaA    
 BEGIN    
  --SELECT @EsAniversario =0    
  SELECT @DiaRango=datepart(day,@FechaVar),@MesRango=datepart(month,@FechaVar),@AmoRango=datepart(year,@FechaVar)    
  IF @DiaRango=@DiaAniv and @MesRango=@MesAniv AND @AmoAniv<>@AmoRango    
   SELECT @EsAniversario =1    
  --select @FechaVar,@EsAniversario    
  SELECT @FechaVar=dateadd(day,1,@FechaVar)    
 END     
    
SELECT @EsAniversario 'Aniversario'    
END 
GO
/*
exec SP_NomAniversario  '01588', 'QUINCENAL', '16/11/2011', '30/11/2011'
exec SP_NomAniversario  '00122', 'SEMANAL', '16/11/2011', '30/11/2011'
*/
GO
/***************** spNominaSaldosFinales *************************/
IF EXISTS ( SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('spNominaSaldosFinales') AND TYPE='P') DROP PROC spNominaSaldosFinales
GO
CREATE PROCEDURE spNominaSaldosFinales
@Empresa        char(5),
@Personal       char(10),
@Movimiento       varchar(50),
@Concepto       varchar(50)
WITH ENCRYPTION
AS BEGIN
    SELECT @Movimiento = NULLIF(RTRIM(@Movimiento), '')
    SELECT @Concepto = NULLIF(RTRIM(@Concepto), '')

    SELECT SUM(Saldo)
      FROM Nomina n
      JOIN NominaD d ON n.id = d.id
     WHERE n.Empresa  = @Empresa
       AND d.Personal = @Personal
       AND n.Estatus  in('Vigente','PROCESAR')
       AND d.Activo   = 1
       AND n.Mov = ISNULL(@Movimiento, n.Mov)
       AND n.Concepto = ISNULL(@Concepto, n.Concepto)
END
GO
/************** spVerMinutosTiempoExtra2 *************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMinutosTiempoExtra2') and type = 'P') drop procedure dbo.spVerMinutosTiempoExtra2
GO
CREATE PROCEDURE [dbo].[spVerMinutosTiempoExtra2]
    @ID			int,
    @Empresa	varchar(5),
	@FechaD		datetime,
	@FechaA		datetime,
	@BorraTabla bit 
--//WITH ENCRYPTION 
AS BEGIN
DECLARE
	@SQL		varchar(max),
	@Dias		varchar(max),
	@Insert		varchar(max),
	@cNum		int,
	@cDia		varchar(10),
	@cFechaD	varchar(10),
	@cFechaA	varchar(10),
	@Semana		int,
	@DiaSem		int,
	@S1D6       datetime,
    @S2D6       datetime,
	@S1D7       datetime,
	@S2D7       datetime,
	@Idt        int
	
	--IF @BorraTabla = 1
	--BEGIN
	--	--DELETE SELECT * FROM AuxAsistenciaHE
	--	RETURN
	--END
	
	IF EXISTS(SELECT * FROM AuxAsistenciaHE WHERE ID = @ID AND Estatus <> 'SINAFECTAR')
		BEGIN
			RETURN
		END
	
	SELECT * FROM AuxAsistenciaHE
	--DELETE FROM AuxAsistenciaHE
	
	IF @BorraTabla = 0
	BEGIN

		DECLARE @TABLE TABLE
		(	
			Id    Int,
			Fecha varchar(10),
			DiaS  Int
		)		

		INSERT INTO @TABLE (Id, Fecha, DiaS)
		SELECT ROW_NUMBER() OVER(ORDER BY Fecha ASC),
		       CONVERT(varchar(10),B.Fecha,105),		
			   CASE WHEN DATEPART(dw, B.Fecha) = 1 THEN 1 
					WHEN DATEPART(dw, B.Fecha) = 2 THEN 2 
					WHEN DATEPART(dw, B.Fecha) = 3 THEN 3 
					WHEN DATEPART(dw, B.Fecha) = 4 THEN 4 
					WHEN DATEPART(dw, B.Fecha) = 5 THEN 5 
					WHEN DATEPART(dw, B.Fecha) = 6 THEN 6 
					ELSE 7 END	 
		  FROM Asiste A
		  JOIN AsisteD B
			ON A.ID = B.ID
		  JOIN MovTipo C
			ON A.Mov = C.Mov
		 WHERE C.Clave = 'ASIS.C'
		   AND A.Empresa = @Empresa
		   AND A.FechaD  = @FechaD
		   AND A.FechaA  = @FechaA
		   AND A.Estatus <> 'CANCELADO'
	  GROUP BY Fecha

	  IF NOT EXISTS (SELECT * FROM @TABLE WHERE DiaS = 6)
	  BEGIN
			SELECT @Idt = COUNT(*) FROM @TABLE
			
			SELECT @S1D6 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 5 
		  ORDER BY FECHA ASC

		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, @S1D6, CASE  WHEN DATEPART(dw, @S1D6) = 1 THEN 1 
												WHEN DATEPART(dw, @S1D6) = 2 THEN 2 
												WHEN DATEPART(dw, @S1D6) = 3 THEN 3 
												WHEN DATEPART(dw, @S1D6) = 4 THEN 4 
												WHEN DATEPART(dw, @S1D6) = 5 THEN 5 
												WHEN DATEPART(dw, @S1D6) = 6 THEN 6 
												ELSE 7 END	

			SELECT @Idt = COUNT(*) FROM @TABLE

			SELECT @S2D6 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 5 
		  ORDER BY FECHA DESC

		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, @S2D6, CASE  WHEN DATEPART(dw, @S2D6) = 1 THEN 1 
												WHEN DATEPART(dw, @S2D6) = 2 THEN 2 
												WHEN DATEPART(dw, @S2D6) = 3 THEN 3 
												WHEN DATEPART(dw, @S2D6) = 4 THEN 4 
												WHEN DATEPART(dw, @S2D6) = 5 THEN 5 
												WHEN DATEPART(dw, @S2D6) = 6 THEN 6 
												ELSE 7 END	
	  END


	  IF NOT EXISTS (SELECT * FROM @TABLE WHERE DiaS = 7)
	  BEGIN
			SELECT @Idt = COUNT(*) FROM @TABLE
			
			SELECT @S1D7 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 6
		  ORDER BY FECHA ASC

		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, @S1D7, CASE  WHEN DATEPART(dw, @S1D7) = 1 THEN 1 
												WHEN DATEPART(dw, @S1D7) = 2 THEN 2 
												WHEN DATEPART(dw, @S1D7) = 3 THEN 3 
												WHEN DATEPART(dw, @S1D7) = 4 THEN 4 
												WHEN DATEPART(dw, @S1D7) = 5 THEN 5 
												WHEN DATEPART(dw, @S1D7) = 6 THEN 6 
												ELSE 7 END	

			SELECT @Idt = COUNT(*) FROM @TABLE

			SELECT @S2D7 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 6
		  ORDER BY FECHA DESC

		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, @S2D7, CASE  WHEN DATEPART(dw, @S2D7) = 1 THEN 1 
												WHEN DATEPART(dw, @S2D7) = 2 THEN 2 
												WHEN DATEPART(dw, @S2D7) = 3 THEN 3 
												WHEN DATEPART(dw, @S2D7) = 4 THEN 4 
												WHEN DATEPART(dw, @S2D7) = 5 THEN 5 
												WHEN DATEPART(dw, @S2D7) = 6 THEN 6 
												ELSE 7 END	

	  END

		DECLARE cDías CURSOR FOR
			SELECT ROW_NUMBER() OVER(ORDER BY Fecha ASC), 
			       CONVERT(VARCHAR(10),fecha,105) 
			  FROM @TABLE 
		  ORDER BY fecha
		SELECT @Insert = 'INSERT INTO AuxAsistenciaHE(ID,Personal, Empresa, FechaD, FechaA'
		
		OPEN cDías
		FETCH NEXT FROM cDías INTO @cNum,@cDia
		
		WHILE @@FETCH_STATUS = 0 AND @cNum <= 14
		BEGIN
			SELECT @Semana = CEILING(@cNum/7.0), 
				   @DiaSem = CASE WHEN @cNum <= 7 
								  THEN @cNum 
								  ELSE CASE WHEN @cNum%7.0 = 0 
											THEN 7 
											ELSE (@cNum - (FLOOR(@cNum/7.0)*7)) 
								  END
							  END,
				   @cFechaD = ISNULL(@cFechaD,@cDia),
				   @cFechaA = @cDia
			
			SELECT @Insert = @Insert+',Semana'+CAST(@Semana AS VARCHAR)+'Dia'+CAST(@DiaSem AS VARCHAR)
			SELECT @Dias = ISNULL(@Dias,'')+
						   ' ,CASE WHEN ('+
						   ' DATEDIFF(mi,(MIN(CASE WHEN B.Registro = '+CHAR(39)+'Entrada'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN B.HoraRegistro ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)),'+
						   '              (MIN(CASE WHEN B.Registro = '+CHAR(39)+'Entrada'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN CONVERT(Time,F.Entrada) ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)))'+
						   ') < 0 THEN 0 ELSE'+
						   ' DATEDIFF(mi,(MIN(CASE WHEN B.Registro = '+CHAR(39)+'Entrada'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN B.HoraRegistro ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)),'+
						   '              (MIN(CASE WHEN B.Registro = '+CHAR(39)+'Entrada'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN CONVERT(Time,F.Entrada) ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)))'+
						   'END + '+
						   ' CASE WHEN ('+
						   '  DATEDIFF(mi,(MAX(CASE WHEN B.Registro = '+CHAR(39)+'Salida'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN CONVERT(Time,F.Salida) ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)),'+
						   '              (MAX(CASE WHEN B.Registro = '+CHAR(39)+'Salida'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN B.HoraRegistro ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)))'+
						   ') < 0 THEN 0 ELSE'+
						   '  DATEDIFF(mi,(MAX(CASE WHEN B.Registro = '+CHAR(39)+'Salida'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN CONVERT(Time,F.Salida) ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)),'+
						   '              (MAX(CASE WHEN B.Registro = '+CHAR(39)+'Salida'+CHAR(39)+' AND B.Fecha = '+CHAR(39)+@cDia+CHAR(39)+' THEN B.HoraRegistro ELSE '+CHAR(39)+'00:00'+CHAR(39)+' END)))'+
						   'END'
						   
			FETCH NEXT FROM cDías INTO @cNum,@cDia
		END
		
		CLOSE cDías
		DEALLOCATE cDías 

		IF OBJECT_ID(N'tempdb..#VerJornadaTiempo', N'U') IS NOT NULL 
		DROP TABLE #VerJornadaTiempo

		SET LANGUAGE ESPAÑOL
		
		SELECT DISTINCT B.Personal, F.Jornada, F.Entrada, F.Salida, F.Ano, F.Mes, F.Dia, F.Semana 
		  INTO #VerJornadaTiempo 
		  FROM Asiste A
		  JOIN AsisteD B  ON A.ID = B.ID
		  JOIN MovTipo C  ON A.Mov = C.Mov AND C.Modulo = 'ASIS' AND C.Clave = 'ASIS.R'
		  JOIN Personal D ON B.Personal = D.Personal
		  JOIN VerJornadaTiempo F ON D.Jornada = F.Jornada AND CONVERT(DATE, B.Fecha,105) = CONVERT(DATE, F.Entrada, 105)
		 WHERE B.Fecha >= CONVERT(DATETIME,@FechaD,105) 
		   AND B.Fecha <= CONVERT(DATETIME,@FechaA,105) 
		   AND A.Estatus <> 'CANCELADO'
		   AND A.Empresa = @Empresa
	     UNION
		SELECT B.Personal, D.Jornada, B.Fecha,CAST((CONVERT(VARCHAR(10),B.Fecha,105)+' '+
											  CAST(MIN(CASE WHEN B.Registro = 'Entrada' THEN B.HoraRegistro ELSE '23:59' END) AS VARCHAR(5))) AS DATETIME),
			   DATEPART(YEAR,B.Fecha), DATEPART(Month,B.Fecha), DATEPART(day,B.Fecha), DATEPART(week,B.Fecha) 
		  FROM Asiste A
		  JOIN AsisteD B  ON A.ID = B.ID
		  JOIN MovTipo C  ON A.Mov = C.Mov AND C.Modulo = 'ASIS' AND C.Clave = 'ASIS.R'
		  JOIN Personal D ON B.Personal = D.Personal
	 LEFT JOIN VerJornadaTiempo F ON D.Jornada = F.Jornada AND CONVERT(DATE, B.Fecha,105) = CONVERT(DATE, F.Entrada, 105)
		 WHERE B.Fecha >= CONVERT(DATETIME,@FechaD,105) 
		   AND B.Fecha <= CONVERT(DATETIME,@FechaA,105) 
		   AND A.Estatus <> 'CANCELADO'
		   AND A.Empresa = @Empresa
		   AND F.Jornada IS NULL
	  GROUP BY D.Jornada, B.Fecha, B.Personal

		SELECT @SQL = @Insert+') '+
					   'SELECT '+CAST(@ID AS VARCHAR)+', B.Personal, A.Empresa,'+CHAR(39)+@cFechaD+CHAR(39)+','+CHAR(39)+@cFechaA+CHAR(39)+
							   @Dias+
						' FROM Asiste A'+
						' JOIN AsisteD B'+ 
						'   ON A.ID = B.ID'+
						' JOIN MovTipo C'+
						'   ON A.Mov = C.Mov'+
						'  AND C.Modulo = '+CHAR(39)+'ASIS'+CHAR(39)+
						'  AND C.Clave = '+CHAR(39)+'ASIS.R'+CHAR(39)+' '+
						' JOIN Personal D'+
						'   ON B.Personal = D.Personal'+
						' JOIN #VerJornadaTiempo F'+
						'   ON D.Jornada = F.Jornada'+
						'  AND D.Personal = F.Personal'+
						'  AND CONVERT(DATE, B.Fecha,105) = CONVERT(DATE, F.Entrada, 105)'+
						'WHERE B.Fecha >= CONVERT(DATETIME,'+CHAR(39)+CONVERT(VARCHAR(10),@FechaD,105)+CHAR(39)+',105)'+
						 ' AND B.Fecha <= CONVERT(DATETIME,'+CHAR(39)+CONVERT(VARCHAR(10),@FechaA,105)+CHAR(39)+',105)'+
						 ' AND A.Estatus <> '+CHAR(39)+'CANCELADO'+CHAR(39)+
						 ' AND A.Empresa = ' +CHAR(39)+@Empresa+CHAR(39)+
						 --' AND B.Personal = '+CHAR(39)+'002144'+CHAR(39)+
					' GROUP BY B.Personal, A.Empresa'
		EXEC(@SQL)
		
		IF OBJECT_ID(N'tempdb..#VerJornadaTiempo', N'U') IS NOT NULL 
		DROP TABLE #VerJornadaTiempo

	END
END
GO


/************** spVerMinutosTiempoExtra *************/
if exists (select * from sysobjects where id = object_id('dbo.spVerMinutosTiempoExtra') and type = 'P') drop procedure dbo.spVerMinutosTiempoExtra
GO
CREATE PROCEDURE [dbo].[spVerMinutosTiempoExtra]
    @ID			int,
    @Empresa	varchar(5),
	@FechaD		datetime,
	@FechaA		datetime,
	@BorraTabla bit 
--//WITH ENCRYPTION 
AS BEGIN
    DECLARE
    	@SQL		    varchar(max),
	    @DiasIns        varchar(max),
	    @Insert		    varchar(max),
	    @Semana		    int,
        @DiaSem		    int,
        @S1D6           datetime,
        @S2D6           datetime,
        @S1D7           datetime,
        @S2D7           datetime,
        @Idt            int,
        @InsDia         datetime,
        @cPersonal      varchar(10),
        @cDia           datetime,
        @cDias          datetime,
        @Jornada        varchar(20),
        @MinutosJor     float,
        @cID            int,
        @MinutosAs      float,
        @MinutosAu      float,
        @MinutosLab     float,
        @MinutosHE      float,
        @cNum           int,
        @cNum1          int,
        @cFechaD        varchar(10),
        @cFechaA        datetime,
		@IdDias			int

	IF EXISTS(SELECT * FROM AuxAsistenciaHE WHERE ID = @ID AND Estatus <> 'SINAFECTAR')
		BEGIN
			RETURN
		END

    IF @BorraTabla = 0
	BEGIN

        DECLARE @TABLE TABLE
		(	
			Id      Int,
			Fecha	varchar(10),
			DiaS    Int
		)	

		SET LANGUAGE ESPAÑOL	

		INSERT INTO @TABLE (Id, Fecha, DiaS)
		SELECT ROW_NUMBER() OVER(ORDER BY B.Fecha ASC),
		       CONVERT(varchar(10),B.Fecha,105),		
			   CASE WHEN DATEPART(dw, B.Fecha) = 1 THEN 1 
					WHEN DATEPART(dw, B.Fecha) = 2 THEN 2 
					WHEN DATEPART(dw, B.Fecha) = 3 THEN 3 
					WHEN DATEPART(dw, B.Fecha) = 4 THEN 4 
					WHEN DATEPART(dw, B.Fecha) = 5 THEN 5 
					WHEN DATEPART(dw, B.Fecha) = 6 THEN 6 
					ELSE 7 END
		  FROM Asiste A
		  JOIN AsisteD B
			ON A.ID = B.ID
		  JOIN MovTipo C
			ON A.Mov = C.Mov
		 WHERE C.Clave = 'ASIS.C'
		   AND A.Empresa = @Empresa
		   AND A.FechaD  = @FechaD
		   AND A.FechaA  = @FechaA
		   AND A.Estatus <> 'CANCELADO'
	  GROUP BY B.Fecha

	  SELECT @IdDias = COUNT(*) FROM @TABLE
	  
	  IF NOT EXISTS (SELECT * FROM @TABLE WHERE DiaS = 6)
	  BEGIN
			SELECT @Idt = COUNT(*) FROM @TABLE
			
			SELECT @S1D6 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 5 
		  ORDER BY FECHA ASC
	  

		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, CONVERT(varchar(10),@S1D6,105), CASE  WHEN DATEPART(dw, @S1D6) = 1 THEN 1 
												  WHEN DATEPART(dw, @S1D6) = 2 THEN 2 
												  WHEN DATEPART(dw, @S1D6) = 3 THEN 3 
												  WHEN DATEPART(dw, @S1D6) = 4 THEN 4 
												  WHEN DATEPART(dw, @S1D6) = 5 THEN 5 
												  WHEN DATEPART(dw, @S1D6) = 6 THEN 6 
										    ELSE 7 END
			IF @IdDias > 5
			BEGIN
				SELECT @Idt = COUNT(*) 
				FROM @TABLE

				SELECT @S2D6 = DATEADD (DAY,1,FECHA)
				  FROM @TABLE 
				 WHERE dias = 5 
			  ORDER BY FECHA DESC

			  INSERT INTO @TABLE (Id, Fecha, DiaS)
						SELECT @Idt + 1, CONVERT(varchar(10),@S1D6,105), CASE  WHEN DATEPART(dw, @S2D6) = 1 THEN 1 
													  WHEN DATEPART(dw, @S2D6) = 2 THEN 2 
													  WHEN DATEPART(dw, @S2D6) = 3 THEN 3 
													  WHEN DATEPART(dw, @S2D6) = 4 THEN 4 
													  WHEN DATEPART(dw, @S2D6) = 5 THEN 5 
													  WHEN DATEPART(dw, @S2D6) = 6 THEN 6 
												ELSE 7 END	
			END
	  END


	  IF NOT EXISTS (SELECT * FROM @TABLE WHERE DiaS = 7)
	  BEGIN
			SELECT @Idt = COUNT(*) FROM @TABLE
			
			SELECT @S1D7 = DATEADD (DAY,1,FECHA)
			  FROM @TABLE 
			 WHERE dias = 6
		  ORDER BY FECHA ASC


		  INSERT INTO @TABLE (Id, Fecha, DiaS)
					SELECT @Idt + 1, CONVERT(varchar(10),@S1D7,105), CASE  WHEN DATEPART(dw, @S1D7) = 1 THEN 1 
												  WHEN DATEPART(dw, @S1D7) = 2 THEN 2 
												  WHEN DATEPART(dw, @S1D7) = 3 THEN 3 
												  WHEN DATEPART(dw, @S1D7) = 4 THEN 4 
												  WHEN DATEPART(dw, @S1D7) = 5 THEN 5 
												  WHEN DATEPART(dw, @S1D7) = 6 THEN 6 
											ELSE 7 END	
			IF @IdDias > 5
			BEGIN
				SELECT @Idt = COUNT(*) FROM @TABLE

				SELECT @S2D7 = DATEADD (DAY,1,FECHA)
				  FROM @TABLE 
				 WHERE dias = 6
			  ORDER BY FECHA DESC

			  INSERT INTO @TABLE (Id, Fecha, DiaS)
						SELECT @Idt + 1, CONVERT(varchar(10),@S1D7,105), CASE  WHEN DATEPART(dw, @S2D7) = 1 THEN 1 
													  WHEN DATEPART(dw, @S2D7) = 2 THEN 2 
													  WHEN DATEPART(dw, @S2D7) = 3 THEN 3 
													  WHEN DATEPART(dw, @S2D7) = 4 THEN 4 
													  WHEN DATEPART(dw, @S2D7) = 5 THEN 5 
													  WHEN DATEPART(dw, @S2D7) = 6 THEN 6 
												ELSE 7 END	
			END
	  END


		DECLARE cDías CURSOR FOR
			SELECT ROW_NUMBER() OVER(ORDER BY Fecha ASC), 
			       CONVERT(DATETIME, fecha)
			  FROM @TABLE 
		  ORDER BY fecha
		SELECT @Insert = 'INSERT INTO AuxAsistenciaHE (ID,Personal, Empresa, FechaD, FechaA'
		
		OPEN cDías
		FETCH NEXT FROM cDías INTO @cNum1, @cDias
		
		WHILE @@FETCH_STATUS = 0 AND @cNum1 <= 14
		BEGIN
			
			SELECT @Semana = CEILING(@cNum1/7.0), 
				   @DiaSem = CASE WHEN @cNum1 <= 7 
								  THEN @cNum1 
								  ELSE CASE WHEN @cNum1%7.0 = 0 
											THEN 7 
											ELSE (@cNum1 - (FLOOR(@cNum1/7.0)*7)) 
								  END
							  END,
				   @cFechaD = ISNULL(@cFechaD,@cDias),
				   @cFechaA = @cDias

		
			SELECT @Insert = @Insert+',Semana'+CAST(@Semana AS VARCHAR)+'Dia'+CAST(@DiaSem AS VARCHAR)			
            FETCH NEXT FROM cDías INTO @cNum1,@cDia
		END
		
		CLOSE cDías
		DEALLOCATE cDías 
    
    DECLARE @Dias TABLE(Dia datetime)
    SET @InsDia = @FechaD    

    WHILE @InsDia <= @FechaA
        BEGIN
            INSERT INTO @Dias(Dia) VALUES(@InsDia)
            SELECT @InsDia = @InsDia + 1
        END

    DECLARE cPersonal CURSOR FOR
        SELECT A.ID, B.Personal
          FROM Asiste A
          JOIN AsisteD B
            ON A.ID = B.ID
          JOIN MovTipo C
            ON A.Mov = C.Mov
         WHERE C.Clave = 'ASIS.C'
           AND A.Empresa = @Empresa
           AND A.FechaD  = @FechaD
           AND A.FechaA  = @FechaA
           AND A.Estatus <> 'CANCELADO'
      GROUP BY A.ID, B.Personal
      ORDER BY A.ID, B.Personal ASC

    OPEN cPersonal
    FETCH NEXT FROM cPersonal INTO @cID, @cPersonal
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SELECT @cNum = 0, @DiasIns = ''
            -----------------   DATOS DEL PERSONAL
            SELECT @Jornada = Jornada FROM Personal WHERE Personal = @cPersonal
            
            DECLARE cDias CURSOR FOR
            SELECT Dia FROM @Dias
            OPEN cDias
            FETCH NEXT FROM cDias INTO @cDia

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    SELECT  @MinutosAs = 0, @MinutosAu = 0, @MinutosLab = 0, @MinutosHE = 0
                    -------------------------------------------------------------------
                    SELECT @MinutosJor = ISNULL(SUM(DATEDIFF(mi,Entrada,Salida)),0)
                      FROM VerJornadaTiempo 
                     WHERE Jornada = @Jornada 
                       AND DATEPART(YEAR,@cDia) = Ano
                       AND DATEPART(MONTH,@cDia) = Mes
                       AND DATEPART(DAY,@cDia) = Dia
                  GROUP BY Ano, Mes, Dia
                    -------------------------------------------------------------------
                    SELECT @MinutosAs = ISNULL(SUM(Cantidad),0) FROM ASISTED WHERE ID = @cID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia' 
                    SELECT @MinutosAu = ISNULL(SUM(Cantidad),0) FROM ASISTED WHERE ID = @cID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Ausencia'
                    SELECT @MinutosLab = @MinutosAs - @MinutosAu

                    IF @MinutosJor < @MinutosLab
                        SELECT @MinutosHE = @MinutosLab - @MinutosJor
                  
                    IF @cNum < 14 AND @IdDias > 5
                    BEGIN
                        SELECT @DiasIns = ISNULL(@DiasIns, '') + ',' + CAST(@MinutosHE AS VARCHAR(4))
                        SELECT @cNum = ISNULL(@cNum,0) + 1
                    END
                    IF @cNum < 14 AND @IdDias = 5
                    BEGIN
                        SELECT @DiasIns = ISNULL(@DiasIns, '') + ',' + CAST(@MinutosHE AS VARCHAR(4))
                        SELECT @cNum = ISNULL(@cNum,0) + 1
                    END

                    FETCH NEXT FROM cDias INTO @cDia
                END

            CLOSE cDias
            DEALLOCATE cDias
                
                SELECT @SQL = @Insert + ') '+
                             'SELECT '+ CAST(@ID AS VARCHAR)+','+CHAR(39)+@cPersonal+CHAR(39)+','+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+CONVERT(VARCHAR(10), @FechaD, 105) +CHAR(39)+','+CHAR(39)+CONVERT(VARCHAR(10), @FechaA, 105)+CHAR(39)+
                              @DiasIns

                --SELECT @SQL				
                EXEC(@SQL)

            FETCH NEXT FROM cPersonal INTO @cID, @cPersonal
        END

    CLOSE cPersonal
    DEALLOCATE cPersonal
    END
END
GO

/************** spEjecutaTiempoExtra *************/
if exists (select * from sysobjects where id = object_id('dbo.spEjecutaTiempoExtra') and type = 'P') drop procedure dbo.spEjecutaTiempoExtra
GO
CREATE PROCEDURE dbo.spEjecutaTiempoExtra
											 @rID		int,
											 @Empresa	varchar(5),
											 @Sucursal  int,
											 @Estacion  int,
											 @Usuario	varchar(10)
--//WITH ENCRYPTION 
AS BEGIN
DECLARE		@ID          int,
            @Personal	 varchar(10),
            @Semana1Dia1 varchar(5),
			@Semana1Dia2 varchar(5),
			@Semana1Dia3 varchar(5),
			@Semana1Dia4 varchar(5),
			@Semana1Dia5 varchar(5),
			@Semana1Dia6 varchar(5),
			@Semana1Dia7 varchar(5), 
			@Semana2Dia1 varchar(5),
			@Semana2Dia2 varchar(5),
			@Semana2Dia3 varchar(5),
			@Semana2Dia4 varchar(5),
			@Semana2Dia5 varchar(5),
			@Semana2Dia6 varchar(5),
			@Semana2Dia7 varchar(5),
			@Horas       varchar(5),
			@Moneda      varchar(20),
			@TipoCambio  float,
			@Cantidad    money,
			@Renglon     float,
			@SQL1		 varchar(8000),
			@SQL2		 varchar(8000),
			@SQLInsert1	 varchar(4000),
			@SQLInsert2	 varchar(4000),
			@SQLD1		 varchar(8000),
			@SQLD2		 varchar(8000),
			@SQLD3       varchar(8000),
			--------------------------
			@HorasCompletas bit,
			@RegEncabezado  int,
			@IDNomina		int,
			@DiaHE			varchar(10),
			---------------------------
			@Semana1     varchar(17),
			@Semana2     varchar(17),
			@Dia1        varchar(4),
			@Dia2		 varchar(4),
			@Dia3        varchar(4),
			@Dia4        varchar(4),
			@Dia5        varchar(4),
			@Dia6        varchar(4),
			@Dia7        varchar(4),
			@Modulo      varchar(20),
			@Mov         varchar(20), 
			@MovID       varchar(20),
			@DMovID      varchar(20),
			@Ok			 int

	SELECT @Semana1 = 'Horas Extras Sem1', 
		   @Semana2 = 'Horas Extras Sem2',
		   @Dia1    = 'Dia1',  
		   @Dia2    = 'Dia2',	
		   @Dia3    = 'Dia3',
		   @Dia4    = 'Dia4', 
		   @Dia5    = 'Dia5', 
		   @Dia6    = 'Dia6', 
		   @Dia7    = 'Dia7'  
	   	
	SELECT @Mov    = ISNULL(A.Mov,''),
	       @MovID  = ISNULL(A.MovID,''),
		   @Modulo = ISNULL(MT.Modulo,'')
	  FROM Asiste A
	  LEFT JOIN MovTipo MT ON MT.Mov = A.Mov 
	 WHERE A.ID = @rID
	   AND A.Empresa = @Empresa
	   AND RTRIM(LTRIM(A.Estatus)) = 'CONCLUIDO'
	   AND MT.Clave = 'ASIS.C'
	   AND MT.Modulo = 'ASIS'

	SELECT @HorasCompletas = HorasExtrasCompletas
	  FROM EMPRESACFG
	 WHERE EMPRESA = @Empresa

	SELECT @RegEncabezado = 0
	SELECT @Renglon = 0.0
	SELECT @SQLInsert1 = 'INSERT INTO Nomina (Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, Sucursal, SucursalOrigen, UEN, FechaOrigen, NOI)'
	SELECT @SQLInsert2 = 'INSERT INTO NominaD (ID, Renglon, Modulo, Plaza, Personal, Importe, Cuenta, FormaPago, Horas, Cantidad, Porcentaje, Monto, FechaD, FechaA, Movimiento, Saldo, Concepto, Referencia, CantidadPendiente, Activo, Sucursal, SucursalOrigen, Beneficiario, ContUso, CuentaContable, UEN, ObligacionFiscal, ClavePresupuestal)'

/******************************************************************************************************************************************/	
	SET LANGUAGE ESPAÑOL
/******************************************************************************************************************************************/	
	
	DECLARE crHES1D1 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia1,
            CONVERT(varchar(10),FechaD,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia1 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D1
	FETCH NEXT FROM crHES1D1 INTO @ID, @Personal, @Semana1Dia1, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia1),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia1)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END
		
		IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia1+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1
				
				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
			
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END	
		FETCH NEXT FROM crHES1D1 INTO @ID, @Personal, @Semana1Dia1, @DiaHE
	END
	CLOSE crHES1D1
	DEALLOCATE crHES1D1

/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/	
	DECLARE crHES1D2 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia2,
            CONVERT(varchar(10),FechaD+1,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia2 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D2
	FETCH NEXT FROM crHES1D2 INTO @ID, @Personal, @Semana1Dia2, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia2),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia2)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
		
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia2+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
			
		FETCH NEXT FROM crHES1D2 INTO @ID, @Personal, @Semana1Dia2, @DiaHE
	END
	CLOSE crHES1D2
	DEALLOCATE crHES1D2	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES1D3 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia3,
            CONVERT(varchar(10),FechaD+2,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia3 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D3
	FETCH NEXT FROM crHES1D3 INTO @ID, @Personal, @Semana1Dia3, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia3),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia3)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END
		
        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia3+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
			
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
			
		FETCH NEXT FROM crHES1D3 INTO @ID, @Personal, @Semana1Dia3, @DiaHE
	END
	CLOSE crHES1D3
	DEALLOCATE crHES1D3	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES1D4 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia4,
            CONVERT(varchar(10),FechaD+3,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia4 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D4
	FETCH NEXT FROM crHES1D4 INTO @ID, @Personal, @Semana1Dia4, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia4),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia4)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia4+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END	
		FETCH NEXT FROM crHES1D4 INTO @ID, @Personal, @Semana1Dia4, @DiaHE
	END
	CLOSE crHES1D4
	DEALLOCATE crHES1D4
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES1D5 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia5,
            CONVERT(varchar(10),FechaD+4,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia5 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D5
	FETCH NEXT FROM crHES1D5 INTO @ID, @Personal, @Semana1Dia5, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia5),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia5)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia5+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES1D5 INTO @ID, @Personal, @Semana1Dia5, @DiaHE
	END
	CLOSE crHES1D5
	DEALLOCATE crHES1D5	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES1D6 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia6,
            CONVERT(varchar(10),FechaD+5,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia6 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D6
	FETCH NEXT FROM crHES1D6 INTO @ID, @Personal, @Semana1Dia6, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia6),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia6)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia6+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END	
		FETCH NEXT FROM crHES1D6 INTO @ID, @Personal, @Semana1Dia6, @DiaHE
	END
	CLOSE crHES1D6
	DEALLOCATE crHES1D6	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES1D7 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana1Dia7,
            CONVERT(varchar(10),FechaD+6,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana1Dia7 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES1D7
	FETCH NEXT FROM crHES1D7 INTO @ID, @Personal, @Semana1Dia7, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana1Dia7),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana1Dia7)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana1+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia7+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina

			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES1D7 INTO @ID, @Personal, @Semana1Dia7, @DiaHE
	END
	CLOSE crHES1D7
	DEALLOCATE crHES1D7	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D1 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia1,
            CONVERT(varchar(10),FechaD+7,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia1 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D1
	FETCH NEXT FROM crHES2D1 INTO @ID, @Personal, @Semana2Dia1, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia1),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia1)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia1+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
			
		FETCH NEXT FROM crHES2D1 INTO @ID, @Personal, @Semana2Dia1, @DiaHE
	END
	CLOSE crHES2D1
	DEALLOCATE crHES2D1	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D2 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia2,
            CONVERT(varchar(10),FechaD+8,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia2 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D2
	FETCH NEXT FROM crHES2D2 INTO @ID, @Personal, @Semana2Dia2, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia2),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia2)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia2+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES2D2 INTO @ID, @Personal, @Semana2Dia2, @DiaHE
	END
	CLOSE crHES2D2
	DEALLOCATE crHES2D2	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D3 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia3,
            CONVERT(varchar(10),FechaD+9,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia3 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D3
	FETCH NEXT FROM crHES2D3 INTO @ID, @Personal, @Semana2Dia3, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia3),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia3)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia3+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES2D3 INTO @ID, @Personal, @Semana2Dia3, @DiaHE
	END
	CLOSE crHES2D3
	DEALLOCATE crHES2D3	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D4 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia4,
            CONVERT(varchar(10),FechaD+10,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia4 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D4
	FETCH NEXT FROM crHES2D4 INTO @ID, @Personal, @Semana2Dia4, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia4),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia4)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia4+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES2D4 INTO @ID, @Personal, @Semana2Dia4, @DiaHE
	END
	CLOSE crHES2D4
	DEALLOCATE crHES2D4	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D5 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia5,
            CONVERT(varchar(10),FechaD+11,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia5 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D5
	FETCH NEXT FROM crHES2D5 INTO @ID, @Personal, @Semana2Dia5, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia5),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia5)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia5+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
			
		FETCH NEXT FROM crHES2D5 INTO @ID, @Personal, @Semana2Dia5, @DiaHE
	END
	CLOSE crHES2D5
	DEALLOCATE crHES2D5	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D6 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia6,
            CONVERT(varchar(10),FechaD+12,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia6 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D6
	FETCH NEXT FROM crHES2D6 INTO @ID, @Personal, @Semana2Dia6, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia6),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia6)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia6+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END
		FETCH NEXT FROM crHES2D6 INTO @ID, @Personal, @Semana2Dia6, @DiaHE
	END
	CLOSE crHES2D6
	DEALLOCATE crHES2D6	
/******************************************************************************************************************************************/	
	SELECT @RegEncabezado = 0
/******************************************************************************************************************************************/
	DECLARE crHES2D7 CURSOR FOR
	 SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID,
	        Personal,
            Semana2Dia7,
            CONVERT(varchar(10),FechaD+13,103)
	  FROM AuxAsistenciaHE
	 WHERE Generar = 1
	   AND Semana2Dia7 >= CASE WHEN @HorasCompletas = 1 THEN 60 ELSE 1 END
	   AND ID = @rID

	OPEN crHES2D7
	FETCH NEXT FROM crHES2D7 INTO @ID, @Personal, @Semana2Dia7, @DiaHE
	WHILE @@FETCH_STATUS = 0 
	BEGIN
		SELECT @RegEncabezado = @RegEncabezado + 1

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @Personal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
		 WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float,@ID)

		SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Semana2Dia7),'00:00'))
		SELECT @Cantidad = CONVERT(MONEY, CONVERT(INT,@Semana2Dia7)/60.00)

		IF EXISTS (SELECT HorasExtrasCompletas FROM EMPRESACFG WHERE EMPRESA = @Empresa AND HorasExtrasCompletas = 1)
		BEGIN		   
			SELECT @Cantidad = FLOOR(@Cantidad/1.0) -- Horas Completas
			SELECT @Horas = CONVERT(TIME,DATEADD(HOUR,CONVERT(INT,@Cantidad),'00:00')) -- Horas Completas
		END

        IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN
			IF @RegEncabezado = 1
			BEGIN
				SELECT @SQL1 = @SQLInsert1
				SELECT @SQLD1 = ' VALUES('+CHAR(39)+@Empresa+CHAR(39)+','+CHAR(39)+@Semana2+CHAR(39)+', NULL, GETDATE(), GETDATE(), '+CHAR(39)+@Dia7+CHAR(39)+', NULL, '
				SELECT @SQLD1 = @SQLD1+CHAR(39)+@Moneda+CHAR(39)+','+CHAR(39)+CAST(@TipoCambio AS VARCHAR(10))+CHAR(39)+','+CHAR(39)+@Usuario+CHAR(39)
				SELECT @SQLD1 = @SQLD1+', NULL, NULL, NULL, '+CHAR(39)+'SINAFECTAR'+CHAR(39)+', NULL, NULL, NULL, NULL,'+CHAR(39)+@Modulo+CHAR(39)+','+CHAR(39)+@Mov+CHAR(39)+','+CHAR(39)+@MovID+CHAR(39)+',NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0)'		
				SELECT @SQL1 = @SQLInsert1+@SQLD1
				--SELECT @SQL1

				EXEC(@SQL1)
				SET @IDNomina = @@IDENTITY
			END
		
			SELECT @SQL2 = @SQLInsert2		
			SELECT @SQLD2 = @SQL2+' VALUES('+CONVERT(VARCHAR(5000),@IDNomina)+','+CONVERT(VARCHAR(5000),@Renglon)+','+CHAR(39)+'NOM'+CHAR(39)+','+'NULL,'+CHAR(39)+@Personal+CHAR(39)+','+'NULL, NULL, NULL,'+CHAR(39)+@Horas+CHAR(39)+','+CONVERT(VARCHAR(5000),@Cantidad)+',NULL, NULL,'+CHAR(39)+@DiaHE+CHAR(39)+', NULL, NULL, NULL, NULL, NULL, NULL, 1,'+CONVERT(VARCHAR(5000),@Sucursal)+','+CONVERT(VARCHAR(5000),@Sucursal)+', NULL, NULL, NULL, NULL, NULL, NULL)'			
			--SELECT @SQLD2
			EXEC(@SQLD2)
			EXEC spAfectar 'NOM', @IDNomina, 'AFECTAR', 'Todo', NULL, @Usuario, @Estacion, @EnSilencio = 1
			UPDATE Nomina SET Estatus = 'PROCESAR' WHERE ID = @IDNomina
			
			SELECT @DMovID = MovID FROM NOMINA WHERE ID = @IDNomina
			EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @rID, @Mov, @MovID, 'NOM', @IDNomina, @Semana1, @DMovID, @OK OUTPUT
		END	
		FETCH NEXT FROM crHES2D7 INTO @ID, @Personal, @Semana2Dia7, @DiaHE
	END
	CLOSE crHES2D7
	DEALLOCATE crHES2D7	

	UPDATE AuxAsistenciaHE SET ESTATUS = 'CONCLUIDO' WHERE ID = @ID

	SELECT 'Proceso concluido.' 
	
END
GO

/************** spCancelaTiempoExtra *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spCancelaTiempoExtra') AND Type = 'P') DROP PROCEDURE dbo.spCancelaTiempoExtra
GO
CREATE PROCEDURE spCancelaTiempoExtra
											 @Empresa	varchar(5),
											 @Mov       varchar(20), 
			                                 @MovID     varchar(20)
--//WITH ENCRYPTION 
AS BEGIN

	IF RTRIM(LTRIM(@Mov)) = 'Corte'
	BEGIN
		UPDATE Nomina
		   SET Estatus  = 'CANCELADO'
		 WHERE Empresa  = @Empresa
		   AND Origen   = @Mov
		   AND OrigenID = @MovID
	END
	 
END
GO


/************** SpPropiedadInfonavitCF *************/
IF EXISTS (SELECT * FROM sysobjects where id = OBJECT_ID('dbo.SpPropiedadInfonavitCF') AND Type = 'P') DROP PROCEDURE dbo.SpPropiedadInfonavitCF
GO
CREATE PROC SpPropiedadInfonavitCF
	@Personal varchar (10)
--//WITH ENCRYPTION 
AS BEGIN

	SELECT Valor1 = CASE Valor WHEN ' ' THEN '0.00' 
							   WHEN NULL THEN '0.00'
					ELSE Valor end
	FROM personalpropvalor 
	WHERE Rama = 'PER' AND Propiedad = 'Credito Fijo Infonavit' AND Cuenta=@Personal --# SMGDF Credito Infonavit  % SDI Credito Infonavit Credito Fijo Infonavit
	--Valor IS NOT NULL and
	--Valor <> ' ' and 
	

END
GO

/************** SpPropiedadInfonavit100 *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.SpPropiedadInfonavit100') AND Type = 'P') DROP PROCEDURE dbo.SpPropiedadInfonavit100
GO
CREATE PROC SpPropiedadInfonavit100
	@Personal varchar (10)
--//WITH ENCRYPTION 
AS BEGIN

	SELECT Valor1 = CASE Valor WHEN ' ' THEN '0.00' 
							   WHEN NULL THEN '0.00'
					ELSE Valor end
	FROM personalpropvalor 
	WHERE Rama = 'PER' AND Propiedad='% SDI Credito Infonavit' AND  Cuenta=@Personal --# SMGDF Credito Infonavit  % SDI Credito Infonavit

	--Valor IS NOT NULL and
	--Valor <> ' ' and 

END
GO

/************** SpPropiedadInfonavitVSM *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.SpPropiedadInfonavitVSM') AND Type = 'P') DROP PROCEDURE dbo.SpPropiedadInfonavitVSM
GO
CREATE PROC SpPropiedadInfonavitVSM
	@Personal varchar (10)
--//WITH ENCRYPTION 
AS BEGIN

	SELECT Valor1 = CASE Valor WHEN ' ' THEN '0.00' 
							   WHEN NULL THEN '0.00'
					ELSE Valor end
	FROM personalpropvalor 
	WHERE Rama = 'PER' AND Propiedad='# SMGDF Credito Infonavit' AND Cuenta=@Personal--# SMGDF Credito Infonavit  % SDI Credito Infonavit 
	--Valor IS NOT NULL and
	--Valor <> ' ' and 

END
GO

/************** SpRangoDiaBimestre *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.SpRangoDiaBimestre') AND Type = 'P') DROP PROCEDURE dbo.SpRangoDiaBimestre
GO
CREATE PROCEDURE SpRangoDiaBimestre
	@TRango VARCHAR(50),
	@Num	INT
--//WITH ENCRYPTION
AS 
BEGIN

	SELECT Valor
	FROM TablaRangoD 
	WHERE TablaRango = @TRango AND NumeroA = @Num

END
GO

/************** spNomAniversarioBim *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spNomAniversarioBim') AND Type = 'P') DROP PROCEDURE dbo.spNomAniversarioBim
GO
CREATE PROCEDURE spNomAniversarioBim
	@Personal		VARCHAR(10),
	@PeriodoTipo	VARCHAR(20),
	@FechaD			DATETIME,
	@FechaA			DATETIME
--//WITH ENCRYPTION
AS
BEGIN

	SELECT CONVERT(NUMERIC, @FechaA - @FechaD + 1)

END
GO

/************** spNomDIASBimESTRE *************/
IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID('dbo.spNomDIASBimESTRE') AND Type = 'P') DROP PROCEDURE dbo.spNomDIASBimESTRE
GO
CREATE PROC spNomDIASBimESTRE
	@Personal		VARCHAR(10),
	@PeriodoTipo	VARCHAR(20),
	@FechaD			DATETIME,
	@FechaA			DATETIME
--//WITH ENCRYPTION
AS
BEGIN
	DECLARE
		@FechaNominaAl	DATETIME,
		@FechaPLus		DATETIME
	
	SELECT @FechaNominaAl = @FechaA 
	SELECT @FechaPLus = CASE WHEN @FechaNominaAl + 63 < @FechaD THEN @FechaNominaAl + 63
							 WHEN @FechaNominaAl + 56 < @FechaD THEN @FechaNominaAl + 56
							 WHEN @FechaNominaAl + 49 < @FechaD THEN @FechaNominaAl + 49
							 WHEN @FechaNominaAl + 42 < @FechaD THEN @FechaNominaAl + 42
							 WHEN @FechaNominaAl + 35 < @FechaD THEN @FechaNominaAl + 35
							 WHEN @FechaNominaAl + 28 < @FechaD THEN @FechaNominaAl + 28
							 WHEN @FechaNominaAl + 21 < @FechaD THEN @FechaNominaAl + 21
							 WHEN @FechaNominaAl + 14 < @FechaD THEN @FechaNominaAl + 14
							 WHEN @FechaNominaAl + 7 < @FechaD THEN @FechaNominaAl + 7  
							 ELSE @FechaNominaAl END       
	BEGIN
		SELECT @FechaPLus
	END
END
GO