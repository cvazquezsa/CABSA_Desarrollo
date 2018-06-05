/* SP NOMINA   */ 

-- NOM.C   Cantidad Diversa
-- NOM.CH  Cantidad Horas
-- NOM.CD  Cantidad Dias
-- NOM.CDH Cantidad Dias Habiles
-- NOM.P   Percepciones
-- NOM.D   Deducciones
-- NOM.PD  Prestamos
-- NOM.DP  Devolucion Prestamos
-- NOM.PI  Prestamos Inmediatos
-- NOM.CA  Otros Cargos

-- NOM.VA Aumento Vacaciones
-- NOM.VT Vacaciones Tomadas

-- NOM.N  Nomina
-- NOM.NE Nomina Especial
-- NOM.NA Acumulados
-- NOM.NC Cancelacion Parcial

-- DESAFECTAR MOVIMIENTOS POR PROCESAR

SET NOCOUNT ON
GO


if exists (select * from sysobjects where id = object_id('dbo.spNominaInsertarAcumulado') and type = 'P') drop procedure dbo.spNominaInsertarAcumulado
GO  
CREATE PROCEDURE spNominaInsertarAcumulado 
        @ID      int, 
        @Usuario varchar(10), 
        @FechaD  datetime, 
        @FechaA  datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 

    @Estatus varchar(15)

  SELECT  @ID = ISNULL(@id,0)

  SELECT @Estatus = Estatus FROM Nomina WHERE ID = @ID
  IF @Estatus ='SINAFECTAR'
  BEGIN
    BEGIN TRANSACTION
    DELETE NominaD WHERE ID = @ID
    INSERT NominaD(ID, Renglon,                      Personal, Cantidad, Importe, NominaConcepto, Concepto, Movimiento)
    SELECT         ID,  Renglon , Personal, Cantidad, Importe, NominaConcepto, Concepto, Movimiento FROM NominaImportar WHERE ID = @ID
    UPDATE Nomina SET Usuario = @Usuario, Estatus = 'BORRADOR', FechaD = @FechaD, FechaA = @FechaA, FechaOrigen = @FechaA  WHERE ID = @ID
    UPDATE NominaImportar SET Estatus = 'BORRADOR' WHERE ID = @ID AND Usuario = @Usuario
    COMMIT TRANSACTION
 END ELSE
 BEGIN
  SELECT 'No se realizaron cambios'
  RETURN
 END
  SELECT 'Proceso Concluido' 
END
GO

/*************************  spNominaBuscarDiasBimestre  ************************arreglar*/
if exists (select * from sysobjects where object_id('dbo.spNominaBuscarDiasBimestre')=id and type='P') drop procedure dbo.spNominaBuscarDiasBimestre
go
CREATE PROCEDURE dbo.spNominaBuscarDiasBimestre 
                     @FechaA      Datetime,
                     @PeriodoTipo varchar(20),
                     @DesfaseFin  int,
                     @FechaIni    datetime output,
                     @FechaFin    datetime output,
                     @Dias        int Output
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @DiasPeriodo int,
    @Mes int,
    @Mes2 int,
    @FechaFin2 datetime, 
    @FechaFinFIN datetime 
          

  SELECT @DiasPeriodo = DiasPeriodo 
    FROM PeriodoTipo 
   WHERE PeriodoTipo =  @PeriodoTipo

   IF @PeriodoTipo = 'Catorcenal' 
   BEGIN
     SELECT @FechaFin = @FechaA
     SELECT @FechaFin2 = DATEADD(DAY, @DiasPeriodo, @FechaFin)
     SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin * -1, @FechaFin2)
     SELECT @Mes= MONTH(@FechaFin)
     SELECT @Mes2= MONTH(@FechaFin2)
     SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin ,    @FechaFin2)
     WHILE  @Mes = @Mes2 and @Mes2 NOT IN(1,4,5,7,9,11) 
     BEGIN
       SELECT @FechaFin  = DATEADD(DAY, 1,                @FechaFin2 )
       SELECT @FechaFin2 = DATEADD(DAY, @DiasPeriodo,      @FechaFin  )
       SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin * -1,    @FechaFin2 )
       SELECT @Mes  = MONTH(@FechaFin)
       SELECT @Mes2 = MONTH(@FechaFin2)
       SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin ,    @FechaFin2 )
     END
     SELECT @FechaFin = DATEADD(day, @Desfasefin , @FechaFin2)
     SELECT @FechaFinfin = DATEADD(day, (@DiasPeriodo * -1) -1, @FechaFin2)
   -- busca la fecha inicial
     SELECT @FechaA = DATEADD(day, (70 * -1) ,@FechaFinFin)
     SELECT @FechaFin = @FechaA
     SELECT @FechaFin2 = DATEADD(DAY, @DiasPeriodo, @FechaFin)
     SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin * -1, @FechaFin2)
     SELECT @Mes= MONTH(@FechaFin)
     SELECT @Mes2= MONTH(@FechaFin2)
     SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin ,    @FechaFin2 )
     WHILE  @Mes = @Mes2 and @Mes2 NOT IN(1,3,5,7,9,11) 
     BEGIN
       SELECT @FechaFin  = DATEADD(DAY, 1,                @FechaFin2 )
       SELECT @FechaFin2 = DATEADD(DAY, @DiasPeriodo,      @FechaFin  )
       SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin * -1,    @FechaFin2 )
       SELECT @Mes  = MONTH(@FechaFin)
       SELECT @Mes2 = MONTH(@FechaFin2)
       SELECT @FechaFin2 = DATEADD(DAY, @DesfaseFin ,    @FechaFin2 )
     END
     SELECT @FechaFin = DATEADD(day, @Desfasefin , @FechaFin2)
     SELECT @Fechaini = DATEADD(day, (@DiasPeriodo * -1)+1 , @FechaFin2)
     SELECT @FechaFin= @FechaFinFin
   END 
   SELECT @Dias = DATEDIFF(day,@FechaINI,@FechaFIN) + 1
END
GO 

/**************** spNominaGravaEstandarPanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGravaEstandarPanama') and type = 'P') drop procedure dbo.spNominaGravaEstandarPanama
go
CREATE PROCEDURE spNominaGravaEstandarPanama
			@Empresa			          char(5),
			@Sucursal			          int,
			@ID				              int,
			@Personal			          char(10),
			@SucursalTrabajoEstado  varchar(50),
			@FechaD				          datetime,
			@FechaA				          datetime,
			@Moneda				          char(10),
			@TipoCambio			        float,
			@SMZ 				            money, 
			@SMZTopeHorasDobles		  float,
			@SDI 				            money, 
			@DiasPeriodo 			      float,
			@DiasMes			          float,
			@DiasAno			          float,
			@Antiguedad			        float,
			@IndemnizacionTope		  money,
			@SueldoMensual          money,
			@ISRBase			          money		OUTPUT,
			@IMSSBase			          money		OUTPUT,
			@ImpuestoEstatalBase		money		OUTPUT,
			@CedularBase			      money		OUTPUT,
			@Ok				              int		  OUTPUT,
			@OkRef				          varchar(255)	OUTPUT

--//WITH ENCRYPTION

AS BEGIN
  DECLARE
    @Semana				          int,
    @Movimiento				      varchar(20),
    @Factor				          float,
    @Cantidad 				      float, 
    @Importe 			  	      money, 
    @Tope				            money,
    @Exento				          money,
    @ExentoF				        money,
    @Gravable				        money,
    @GravableF				      money,
    @ClaveInterna			      varchar(50),
    @ClaveInternaPrefijo		varchar(50),
    @GravaISR				        varchar(50), 
    @GravaIMSS				      varchar(50), 
    @GravaImpuestoEstatal		varchar(50), 
    @GravaCedular			      varchar(50),
    @TopeHorasDoblesSemanal	money, 
    @TopePrimaDominical			money,
    @TopePrimaVacacional		money,
    @TopeAguinaldo			    money,
    @TopePTU				        money,
    @TopePremioPuntualidad	money,
    @TopePremioAsistencia		money,
    @TopeValesDespensaISR		money,
    @TopeValesDespensaIMSS	money,
    @TopeBonoProduccion			money,
    @ImporteHorasExtrasDobles		money,
    @ImporteBonoproduccion		  money,
    @ImporteBonoproduccionGravable	money,
    @ImporteBonoproduccionExento		money,
    @FinMes                         int,
    @NominaConcepto			        varchar(10),
    @PrimerDiaMes               datetime,
    @UltimoDiaMes               datetime


  IF @Ok IS NOT NULL RETURN

  SELECT @TopePrimaVacacional    = @SMZ*15,
         @TopeAguinaldo          = @SMZ*30,
         @TopePTU                = @SMZ*15,
         @TopePremioPuntualidad  = (@DiasMes*@SDI*0.1)/@DiasMes*@DiasPeriodo,
         @TopePremioAsistencia   = (@DiasMes*@SDI*0.1)/@DiasMes*@DiasPeriodo,
         @TopeValesDespensaIMSS  = @SMZ*@DiasPeriodo*0.4,
         @TopeValesDespensaISR   = @SMZ*(@DiasAno/12.0),  
         @TopeHorasDoblesSemanal = @SMZTopeHorasDobles * @SMZ
-- ojo hay que cambiarlo en el caso de que el personal tenga rata por hora.
  SELECT @TopeBonoProduccion     = @SueldoMensual /2.0


  DECLARE crNominaGrava CURSOR FOR 

   SELECT nc.NominaConcepto, d.Movimiento, d.Semana, SUM(d.Cantidad), SUM(d.Importe), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaISR)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaIMSS)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaImpuestoEstatal)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaCedular)), ''), 'NO') 
     FROM #Nomina d
     JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
    WHERE d.Personal = @Personal AND d.Movimiento IN ('Percepcion', 'Deduccion', 'Estadistica')
    GROUP BY nc.NominaConcepto, d.Movimiento, nc.GravaISR, nc.GravaIMSS, nc.GravaImpuestoEstatal, nc.GravaCedular, d.Semana
    ORDER BY nc.NominaConcepto, d.Movimiento, nc.GravaISR, nc.GravaIMSS, nc.GravaImpuestoEstatal, nc.GravaCedular, d.Semana

  OPEN crNominaGrava
  FETCH NEXT FROM crNominaGrava INTO @NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @GravaCedular
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @GravaImpuestoEstatal = 'POR ESTADO'
      BEGIN 
        SELECT @GravaImpuestoEstatal = 'NO'
        SELECT @GravaImpuestoEstatal = GravaImpuestoEstatal FROM NominaConceptoEstado WHERE NominaConcepto = @NominaConcepto AND Estado = @SucursalTrabajoEstado
      END

      IF @Movimiento = 'Deduccion' SELECT @Factor = -1.0 ELSE SELECT @Factor = 1.0
      SELECT @TopePrimaDominical = @Cantidad*@SMZ

      -- ISR
      IF @GravaISR <> 'NO'
      BEGIN
        SELECT @Tope = 0.0, @ClaveInternaPrefijo = NULL
        IF @GravaISR = 'HORAS EXTRAS DOBLES'
        BEGIN
          SELECT @ImporteHorasExtrasDobles = (@Importe/2.0)
          EXEC spNominaTope @ImporteHorasExtrasDobles, @TopeHorasDoblesSemanal, @Exento OUTPUT, @Gravable OUTPUT
          SELECT @Gravable = (@Importe/2.0) + @Gravable, @ClaveInternaPrefijo = 'HorasExtras/Dobles'
        END ELSE 
        BEGIN
          IF @GravaISR = 'PRIMA DOMINICAL'  	SELECT @ClaveInternaPrefijo = 'PrimaDominical',  @Tope = @TopePrimaDominical   ELSE
          IF @GravaISR = 'PRIMA VACACIONAL' 	SELECT @ClaveInternaPrefijo = 'PrimaVacacional', @Tope = @TopePrimaVacacional  ELSE
          IF @GravaISR = 'VALES DESPENSA' 	  SELECT @ClaveInternaPrefijo = 'ValesDespensa',   @Tope = @TopeValesDespensaISR ELSE
          IF @GravaISR = 'AGUINALDO'        	SELECT @ClaveInternaPrefijo = 'Aguinaldo', 	 @Tope = @TopeAguinaldo        ELSE
          IF @GravaISR = 'PTU'        	    	SELECT @ClaveInternaPrefijo = 'PTU', 	 	 @Tope = @TopePTU              ELSE
          IF @GravaISR = 'INDEMNIZACION'      SELECT @ClaveInternaPrefijo = 'Indemnizacion',   @Tope = @IndemnizacionTope
          EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        END

        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @ISRBase = @ISRBase + @GravableF
        IF @ClaveInternaPrefijo IS NOT NULL
        BEGIN
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Exento'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @ExentoF
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Gravable'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @GravableF
        END
      END
      -- Estatal
      IF @GravaImpuestoEstatal <> 'NO' 
      BEGIN
        SELECT @Tope = 0.0
        EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @ImpuestoEstatalBase = @ImpuestoEstatalBase + @GravableF
      END
      -- Cedular  --- es el que guarda lo que grava al isr de los gastos de representacion
      IF @GravaCedular <> 'NO' 
      BEGIN
        SELECT @Tope = 0.0
        EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @CedularBase = @CedularBase + @GravableF
      END
      -- IMSS
      IF @GravaIMSS <> 'NO'
      BEGIN
        SELECT @ClaveInternaPrefijo = NULL
        SELECT @Tope = 0.0
        IF @GravaIMSS = 'PREMIO PUNTUALIDAD'    SELECT @Tope = @TopePremioPuntualidad ELSE
        IF @GravaIMSS = 'PREMIO ASISTENCIA'     SELECT @Tope = @TopePremioAsistencia ELSE
        IF @GravaIMSS = 'VALES DESPENSA'        SELECT @Tope = @TopeValesDespensaIMSS
        IF @GravaIMSS = 'GASTO REPRESENTACION' SELECT @Importe = @Importe * CASE WHEN @FechaA < CONVERT(datetime, '01/07/2008', 103) then 0.25 
                                                                                  WHEN @FechaA < CONVERT(datetime, '01/07/2010', 103)  then 0.55
                                                                                  ELSE  1.0 END
        IF @GravaIMSS = 'BONO PRODUCCION'     
        BEGIN
          SELECT @ClaveInternaPrefijo = 'BonoProduccion',   @Tope = @TopeBonoProduccion
          SELECT @PrimerDiaMes = DATEADD(dd, 1-day(@FechaA), @FechaA )
          SELECT @UltimoDiaMes = DATEADD(dd, -1, DATEADD(mm, 1, @PrimerDiaMes))
          EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'BonoProduccion', @PrimerDiaMes, @UltimoDiaMes, NULL, @ImporteBonoProduccion	OUTPUT, NULL, NULL
          EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'BonoProduccionExento', @PrimerDiaMes, @UltimoDiaMes, NULL, @ImporteBonoProduccionExento	OUTPUT, NULL, NULL
          EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'BonoProduccionGravable', @PrimerDiaMes, @UltimoDiaMes, NULL, @ImporteBonoProduccionGravable	OUTPUT, NULL, NULL
          SELECT @ImporteBonoProduccion = ISNULL(@ImporteBonoProduccion,0) + @Importe 
          EXEC spNominaTope @ImporteBonoProduccion, @Tope, @Exento OUTPUT, @Gravable OUTPUT
          SELECT @GravableF = @Gravable * @Factor, 
                 @ExentoF   = @Exento * @Factor
          SELECT @ExentoF   = @ExentoF   - @ImporteBonoProduccionExento,
                 @GravableF = @GravableF - @ImporteBonoProduccionGravable
          SELECT @IMSSBase = @IMSSBase + @GravableF
        END ELSE
        BEGIN
          EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
          SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
          SELECT @IMSSBase = @IMSSBase + @GravableF
        END

        IF @ClaveInternaPrefijo IS NOT NULL
        BEGIN
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Exento'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @ExentoF
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Gravable'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @GravableF
        END
        SELECT @ClaveInternaPrefijo=NULL
      END
    END
    FETCH NEXT FROM crNominaGrava INTO @NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @GravaCedular
  END
  CLOSE crNominaGrava
  DEALLOCATE crNominaGrava

  RETURN
END 
GO

go
/**************** fnPanamaSueldoMensual ****************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'fnPanamaSueldoMensual' and type = 'FN') DROP Function dbo.fnPanamaSueldoMensual
GO
CREATE FUNCTION dbo.fnPanamaSueldoMensual(    @Personal varchar(10),    @FechaD   datetime )    returns  money 
AS BEGIN
  DECLARE 
    @PrimerDiaMes          datetime,
    @UltimoDiaMes          datetime,
    @SueldoDiario          money,
    @Jornada               varchar(20),
    @JornadaHoras          float,
    @PersonalDiasPeriodo	 varchar(20),
    @SueldoMensualPersonal money,
    @RataHora              money,
    @HorasSemana           int,
    @ISRFijoPeriodo        money,          
    @HorasMes              float,
    @Sueldomensual         money

  SELECT @SueldoDiario		      = ISNULL(p.SueldoDiario, 0.0),
         @Jornada		            = p.Jornada,
         @JornadaHoras		      = NULLIF(j.HorasPromedio, 0.0),
         @PersonalDiasPeriodo	  = UPPER(p.DiasPeriodo),
         @SueldoMensualPersonal = ISNULL(p.SueldoMensual, 0),
         @RataHora              = ISNULL(p.RataHora, 0),
         @HorasSemana           = ISNULL(j.HorasSemana, 0),
         @ISRFijoPeriodo        = ISNULL(p.ISRFijoPeriodo, 0)                  
    FROM Personal p
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo
    LEFT OUTER JOIN Jornada j      ON j.Jornada      = p.Jornada 
   WHERE p.Personal = @Personal 

  SELECT @PrimerDiaMes  = DATEADD(day, 1-DAY(@FechaD), @FechaD)
  SELECT @UltimoDiaMes = DATEADD(dd, -1, DATEADD(mm, 1, @PrimerDiaMes))

  IF @PersonalDiasPeriodo = 'RATA POR HORA'
  BEGIN
     SELECT @HorasMes = ISNULL(SUM(DATEDIFF(mi, Entrada, Salida)/60.0),0) 
      FROM PersonalJornadaTiemposPanama 
     WHERE Entrada BETWEEN @PrimerDiaMes and @UltimoDiaMes
       AND Personal = @Personal
  
    IF ISNULL(@HorasMes,0) = 0 
    BEGIN 
        SELECT @HorasMes= ISNULL(SUM(DATEDIFF(mi, Entrada, Salida)/60.0),0) 
        FROM JornadaTiempo 
       WHERE Entrada BETWEEN @PrimerDiaMes and @UltimoDiaMes
         AND Jornada = @Jornada
    END
    SELECT @HorasMes =  ISNULL(@HorasMes,0)
    IF @HorasMes < (140)--- para validar si no tiene BIEN la jornada se calcula un "estandar" 
      SELECT @HorasMes=  @HorasSemana* 4.33

    SELECT @SueldoMensual = @RataHora * @HorasMes
  END ELSE
     SELECT  @SueldoMensual = @SueldoMensualPersonal

   RETURN isNULL(@SueldoMensual,0)
END
GO

if exists (select * from sysobjects where id = object_id('dbo.fnCalculaPremioAsistencia') and type = 'FN') drop function dbo.fnCalculaPremioAsistencia
GO
CREATE FUNCTION fnCalculaPremioAsistencia
    (
      @Empresa        varchar(5),
      @Personal       char(10),  
      @Fecha          datetime
    )
  RETURNS MONEY
AS
  BEGIN
    DECLARE  
      @FechaD           datetime,
      @FechaA           datetime,
      @ClaveInterna     varchar(50),  
      @Importe          money,  
      @Sueldo           money,  
      @DiasTrabajados   tinyint,  
      @Dia              tinyint,
      @Mesa             tinyint,
      @Anoa             smallint,
      @FechaI           datetime,
      @ImportePremio    money

        -- Constante 
          SELECT @ClaveInterna = 'Sueldo'

        -- Calcula día,mes y año de inicio del periodo
          SELECT @Dia = DAY(@Fecha)
          SELECT @Mesa = MONTH(@Fecha)
          SELECT @Anoa = YEAR(@Fecha)
   
         -- Calcula Fechas De y A del periodo anterior
          IF LEN(CONVERT(VARCHAR,@Mesa))=1
            SELECT @FechaI = CONVERT(DATETIME,CONVERT(CHAR(4),@Anoa)+'0'+CONVERT(CHAR(1),@Mesa)+'01', 101)
          ELSE
            SELECT @FechaI = CONVERT(DATETIME,CONVERT(CHAR(4),@Anoa)+CONVERT(CHAR(2),@Mesa)+'01', 101)

          SELECT @FechaD = DATEADD(M,-1,@FechaI)
          SELECT @FechaA = DATEADD(D,-1,@FechaI)
    
        EXEC spNominaClaveInternaAcumuladoFechas 
              @Empresa, 
              @Personal, 
              @ClaveInterna, 
              @FechaD, 
              @FechaA, 
              NULL,
              @Sueldo OUTPUT, 
              @DiasTrabajados OUTPUT
        SELECT @ImportePremio =  @Sueldo * @DiasTrabajados
    RETURN (@ImportePremio)
  END
GO

if exists (select * from sysobjects where id = object_id('dbo.spDiasHabilesPanama') and type = 'P') drop procedure dbo.spDiasHabilesPanama
GO             
CREATE PROCEDURE spDiasHabilesPanama @Personal varchar(10), @FechaD datetime, @FechaA datetime, @DiasHabiles int OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Fecha datetime

  SELECT @Fecha = @FechaD, @DiasHabiles = 0
  WHILE @Fecha <= @FechaA
  BEGIN
    IF dbo.fnPanamaEsDiaHabil (@Personal, @Fecha) = 1
      SELECT @DiasHabiles = @DiasHabiles + 1
    SELECT @Fecha = DATEADD(dd, 1, @Fecha)  
  END
END
go

/**************** spNominaGravaConceptoAcumuladoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGravaConceptoAcumuladoFechas') and type = 'P') drop procedure dbo.spNominaGravaConceptoAcumuladoFechas
GO             
CREATE PROCEDURE spNominaGravaConceptoAcumuladoFechas
			@Empresa	       char(5),
			@Personal	       char(10),
			@FechaD		       datetime,
			@FechaA		       datetime,
      @GravaConcepto   varchar(20),
			@Importe	       money	OUTPUT,
                        @cantidad              Float = NULL      OUTPUT 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Linea varchar(500)
  SELECT @Personal   = NULLIF(RTRIM(@Personal), '')

  SELECT @Importe = 0.0

  SELECT @Importe = @Importe + ISNULL(SUM(case when d.movimiento ='Deduccion' THEN -d.Importe else d.Importe END ), 0.0)
    FROM  Nomina n,  
          NominaD d,  
          MovTipo mt, 
          NominaConcepto nc 
    WHERE n.ID = d.ID 
      AND n.Estatus   =  'CONCLUIDO'
      AND n.Empresa   = @Empresa 
      AND n.FechaA    BETWEEN @FechaD AND @FechaA 
      AND mt.Clave    IN ('NOM.N', 'NOM.NE') 
      AND n.Mov       = mt.Mov 
      AND mt.Modulo   = 'NOM'
      AND d.Personal  = @Personal
      AND nc.nominaConcepto = d.nominaConcepto       
      AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
      AND ISNULL(nc.GravaIndemnizacion,'')   = CASE  WHEN @GravaConcepto = 'GravaIndemnizacion' THEN 'SI' 
                                          ELSE ISNULL(nc.GravaIndemnizacion,'') END
      AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
      AND ISNULL(nc.AplicaPreelaborada,'')   = CASE  WHEN @GravaConcepto = 'AplicaPreelaborada' THEN  'SI' 
                                          ELSE ISNULL(nc.AplicaPreelaborada,'') END
      AND ISNULL(nc.GravaSeguroEducativo,'') = CASE  WHEN @GravaConcepto = 'GravaSeguroEducativo' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaSeguroEducativo,'') END
      AND ISNULL(nc.GravaVacaciones,'')      = CASE  WHEN @GravaConcepto = 'GravaVacaciones' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaVacaciones,'') END
      AND ISNULL(nc.GravaCedular,'')      = CASE  WHEN @GravaConcepto = 'GravaCedular' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaCedular,'') END
     AND ISNULL(nc.GravaISR,'')      = CASE  WHEN @GravaConcepto = 'GravaISR' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaISR,'') END

  SELECT @Cantidad = @Cantidad + ISNULL(SUM(case when d.movimiento ='Deduccion' THEN -d.Cantidad else d.Cantidad END ), 0.0)
    FROM  Nomina n,  
          NominaD d,  
          MovTipo mt, 
          NominaConcepto nc 
    WHERE n.ID = d.ID 
      AND n.Estatus   =  'CONCLUIDO'
      AND n.Empresa   = @Empresa 
      AND n.FechaA    BETWEEN @FechaD AND @FechaA 
      AND mt.Clave    IN ('NOM.N', 'NOM.NE') 
      AND n.Mov       = mt.Mov 
      AND mt.Modulo   = 'NOM'
      AND d.Personal  = @Personal
      AND nc.nominaConcepto = d.nominaConcepto       
      AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
      AND ISNULL(nc.GravaIndemnizacion,'')   = CASE  WHEN @GravaConcepto = 'GravaIndemnizacion' THEN 'SI' 
                                          ELSE ISNULL(nc.GravaIndemnizacion,'') END
      AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
      AND ISNULL(nc.AplicaPreelaborada,'')   = CASE  WHEN @GravaConcepto = 'AplicaPreelaborada' THEN  'SI' 
                                          ELSE ISNULL(nc.AplicaPreelaborada,'') END
      AND ISNULL(nc.GravaSeguroEducativo,'') = CASE  WHEN @GravaConcepto = 'GravaSeguroEducativo' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaSeguroEducativo,'') END
      AND ISNULL(nc.GravaVacaciones,'')      = CASE  WHEN @GravaConcepto = 'GravaVacaciones' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaVacaciones,'') END
      AND ISNULL(nc.GravaCedular,'')      = CASE  WHEN @GravaConcepto = 'GravaCedular' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaCedular,'') END
      AND ISNULL(nc.GravaISR,'')      = CASE  WHEN @GravaConcepto = 'GravaISR' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaISR,'') END

  SELECT @Importe = @Importe + ISNULL(SUM(case when d.movimiento ='Deduccion' THEN -d.Importe else d.Importe END ), 0.0)
    FROM Nomina n,  
         NominaD d,  
         MovTipo mt, 
         NominaConcepto nc 
   WHERE n.ID = d.ID 
     AND n.Estatus      = 'CONCLUIDO'
     AND n.Empresa      = @Empresa 
     AND n.FechaEmision BETWEEN @FechaD AND @FechaA 
     AND mt.Clave       IN ('NOM.NA', 'NOM.NC') 
     AND n.Mov          = mt.Mov 
     AND mt.Modulo      = 'NOM'
     AND d.Personal     = @Personal
     AND nc.NominaConcepto    = d.NominaConcepto 
     AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
     AND ISNULL(nc.GravaIndemnizacion,'')   = CASE  WHEN @GravaConcepto = 'GravaIndemnizacion' THEN 'SI' 
                                          ELSE ISNULL(nc.GravaIndemnizacion,'') END
     AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
     AND ISNULL(nc.AplicaPreelaborada,'')   = CASE  WHEN @GravaConcepto = 'AplicaPreelaborada' THEN  'SI' 
                                          ELSE ISNULL(nc.AplicaPreelaborada,'') END
     AND ISNULL(nc.GravaSeguroEducativo,'') = CASE  WHEN @GravaConcepto = 'GravaSeguroEducativo' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaSeguroEducativo,'') END
     AND ISNULL(nc.GravaVacaciones,'')      = CASE  WHEN @GravaConcepto = 'GravaVacaciones' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaVacaciones,'') END
     AND ISNULL(nc.GravaCedular,'')      = CASE  WHEN @GravaConcepto = 'GravaCedular' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaCedular,'') END
     AND ISNULL(nc.GravaISR,'')          = CASE  WHEN @GravaConcepto = 'GravaISR' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaISR,'') END


  SELECT @Cantidad = @Cantidad + ISNULL(SUM(case when d.movimiento ='Deduccion' THEN -d.Cantidad else d.Cantidad END ), 0.0)
    FROM Nomina n,  
         NominaD d,  
         MovTipo mt, 
         NominaConcepto nc 
   WHERE n.ID = d.ID 
     AND n.Estatus      = 'CONCLUIDO'
     AND n.Empresa      = @Empresa 
     AND n.FechaEmision BETWEEN @FechaD AND @FechaA 
     AND mt.Clave       IN ('NOM.NA', 'NOM.NC') 
     AND n.Mov          = mt.Mov 
     AND mt.Modulo      = 'NOM'
     AND d.Personal     = @Personal
     AND nc.NominaConcepto    = d.NominaConcepto 
     AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
     AND ISNULL(nc.GravaIndemnizacion,'')   = CASE  WHEN @GravaConcepto = 'GravaIndemnizacion' THEN 'SI' 
                                          ELSE ISNULL(nc.GravaIndemnizacion,'') END
     AND ISNULL(nc.GravaPrimaAntiguedad,'') = CASE  WHEN @GravaConcepto = 'GravaPrimaAntiguedad' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaPrimaAntiguedad,'') END
     AND ISNULL(nc.AplicaPreelaborada,'')   = CASE  WHEN @GravaConcepto = 'AplicaPreelaborada' THEN  'SI' 
                                          ELSE ISNULL(nc.AplicaPreelaborada,'') END
     AND ISNULL(nc.GravaSeguroEducativo,'') = CASE  WHEN @GravaConcepto = 'GravaSeguroEducativo' THEN  'SI' 
                                          ELSE ISNULL(nc.GravaSeguroEducativo,'') END
     AND ISNULL(nc.GravaVacaciones,'')      = CASE  WHEN @GravaConcepto = 'GravaVacaciones' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaVacaciones,'') END
     AND ISNULL(nc.GravaCedular,'')      = CASE  WHEN @GravaConcepto = 'GravaCedular' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaCedular,'') END
     AND ISNULL(nc.GravaISR,'')      = CASE  WHEN @GravaConcepto = 'GravaISR' THEN  'SI' 
                                           ELSE ISNULL(nc.GravaISR,'') END

  RETURN
END
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fnSalvadorSueldoMensual]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fnSalvadorSueldoMensual]
GO
CREATE FUNCTION dbo.fnSalvadorSueldoMensual(    @Personal varchar(10),    @FechaD   datetime )    
returns  money 
AS BEGIN
  DECLARE 
    @PrimerDiaMes          datetime,
    @UltimoDiaMes          datetime,
    @SueldoDiario          money,
    @Jornada               varchar(20),
    @JornadaHoras          float,
    @PersonalDiasPeriodo            varchar(20),
    @SueldoMensualPersonal money,
    @RataHora              money,
    @HorasSemana           int,
    @ISRFijoPeriodo        money,          
    @HorasMes              float,
    @Sueldomensual         money
 

  SELECT @SueldoDiario                                     = ISNULL(p.SueldoDiario, 0.0),
         @Jornada                              = p.Jornada,
         @JornadaHoras                            = NULLIF(j.HorasPromedio, 0.0),
         @PersonalDiasPeriodo         = UPPER(p.DiasPeriodo),
         @SueldoMensualPersonal = ISNULL(p.SueldoMensual, 0),
      --   @RataHora              = ISNULL(p.RataHora, 0),
         @HorasSemana           = ISNULL(j.HorasSemana, 0)--,
      --   @ISRFijoPeriodo        = ISNULL(p.ISRFijoPeriodo, 0)                  
    FROM Personal p
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo
    LEFT OUTER JOIN Jornada j      ON j.Jornada      = p.Jornada 
   WHERE p.Personal = @Personal 
 
  SELECT @PrimerDiaMes  = DATEADD(day, 1-DAY(@FechaD), @FechaD)
  SELECT @UltimoDiaMes = DATEADD(dd, -1, DATEADD(mm, 1, @PrimerDiaMes))
 
  IF @PersonalDiasPeriodo = 'RATA POR HORA'
  BEGIN
     SELECT @HorasMes = ISNULL(SUM(DATEDIFF(mi, Entrada, Salida)/60.0),0) 
      FROM PersonalJornadaTiemposPanama 
     WHERE Entrada BETWEEN @PrimerDiaMes and @UltimoDiaMes
       AND Personal = @Personal
  

    IF ISNULL(@HorasMes,0) = 0 
    BEGIN 
        SELECT @HorasMes= ISNULL(SUM(DATEDIFF(mi, Entrada, Salida)/60.0),0) 
        FROM JornadaTiempo 
       WHERE Entrada BETWEEN @PrimerDiaMes and @UltimoDiaMes
         AND Jornada = @Jornada
    END

    SELECT @HorasMes =  ISNULL(@HorasMes,0)
    IF @HorasMes < (140)--- para validar si no tiene BIEN la jornada se calcula un "estandar" 
      SELECT @HorasMes=  @HorasSemana* 4.33
 
    SELECT @SueldoMensual = @RataHora * @HorasMes
  END ELSE
     SELECT  @SueldoMensual = @Sueldodiario * 30.0
 
   RETURN isnull(@SueldoMensual,0)
END
GO

/**************** spNominaGravaSalvador ****************/
if exists (select * from sysobjects where id = object_id('spNominaGravaSalvador') and type = 'P') drop procedure dbo.spNominaGravaSalvador
GO             
CREATE PROCEDURE dbo.spNominaGravaSalvador
			@Empresa			           char(5),
			@Sucursal			           int,
			@ID				               int,
			@Personal			           char(10),
			@SucursalTrabajoEstado   varchar(50),
			@FechaD				           datetime,
			@FechaA				           datetime,
			@Moneda				           char(10),
			@TipoCambio			         float,
      @BasePrimaAntiguedad     money		OUTPUT,
      @BaseIndemnizacion       money		OUTPUT,
      @BasePreelaborada        money		OUTPUT,
      @BaseSeguroEducativo     money		OUTPUT,
      @BaseVacaciones          money		OUTPUT,
			@Ok				               int   		OUTPUT,
			@OkRef				           varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Factor				        float,
    @Tope				          money,
    @Exento				        money,
    @ExentoF				      money,
    @Gravable				      money,
    @GravableF				    money,
    @ClaveInterna			    varchar(50),
    @ClaveInternaPrefijo	varchar(50),
    @GravaPrimaAntiguedad varchar(50), 
    @GravaIndemnizacion		varchar(50), 
    @AplicaPreelaborada		varchar(50), 
    @GravaSeguroEducativo	varchar(50),
    @GravaVacaciones			varchar(50),
    @Importe 				      money, 
    @Cantidad 				    float, 
    @Semana				        int,
    @NominaConcepto			  varchar(10),
    @Movimiento				    varchar(20),
    @IncidenciaID         int,    
    @Repetir	            bit,
    @Prorratear	          bit,
    @Frecuencia	          varchar(20)


  IF @Ok IS NOT NULL RETURN

  SELECT @BasePrimaAntiguedad     = ISNULL(@BasePrimaAntiguedad, 0) ,
         @BaseIndemnizacion       = ISNULL(@BaseIndemnizacion, 0),
         @BasePreelaborada        = ISNULL(@BasePreelaborada, 0),
         @BaseSeguroEducativo     = ISNULL(@BaseSeguroEducativo, 0),
         @BaseVacaciones          = ISNULL(@BaseVacaciones, 0)






  DECLARE crNominaGrava CURSOR LOCAL FOR 
   SELECT d.IncidenciaID, nc.NominaConcepto, 
          d.Movimiento, 
          d.Semana, 
          SUM(d.Cantidad), 
          SUM(isnull(d.Importe,0)), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaPrimaAntiguedad)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaIndemnizacion)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.AplicaPreelaborada)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaSeguroEducativo)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaVacaciones)), ''), 'NO') 

     FROM #Nomina d
     JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
    WHERE d.Personal = @Personal 
      AND d.Movimiento IN('Percepcion', 'Deduccion', 'Estadistica')
    GROUP BY d.IncidenciaID, nc.NominaConcepto, d.Movimiento, 
             nc.GravaPrimaAntiguedad, 
             nc.GravaIndemnizacion, 
             nc.AplicaPreelaborada, 
             nc.GravaSeguroEducativo, 
             nc.GravaVacaciones,  
             d.Semana
    ORDER BY d.IncidenciaID, nc.NominaConcepto, d.Movimiento, 
             nc.GravaPrimaAntiguedad, 
             nc.GravaIndemnizacion, 
             nc.AplicaPreelaborada, 
             nc.GravaSeguroEducativo, 
             nc.GravaVacaciones,  
             d.Semana

  OPEN crNominaGrava
  FETCH NEXT FROM crNominaGrava INTO @IncidenciaID, @NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, 
                                     @GravaPrimaAntiguedad, @GravaIndemnizacion, @AplicaPreelaborada, 
                                     @GravaSeguroEducativo, @GravaVacaciones

  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
        SELECT @Repetir    = Repetir, 
               @Prorratear = Prorratear, 
               @Frecuencia = Frecuencia  FROM Incidencia WHERE ID = @IncidenciaID 
      IF @Movimiento not in ('Percepcion','Estadistica') SELECT @Importe= -@Importe

      SELECT @Repetir= ISNULL(@Repetir,0),@Prorratear = ISNULL(@Prorratear,0)
  
      IF @GravaPrimaAntiguedad <> 'NO'
        SELECT @BasePrimaAntiguedad = @BasePrimaAntiguedad + @Importe

      IF @GravaIndemnizacion <> 'NO'
        SELECT @BaseIndemnizacion = @BaseIndemnizacion + @Importe

      IF @AplicaPreelaborada <> 'NO'
        SELECT @BasePreelaborada = @BasePreelaborada + @Importe


      IF @GravaSeguroEducativo <> 'NO'
      BEGIN

       IF @Repetir =0 AND @Prorratear=0
          SELECT @BaseSeguroEducativo = @BaseSeguroEducativo + @Importe 
       ELSE
         IF @Repetir=1
         BEGIN
           IF  @Frecuencia ='Cada Nomina'
             SELECT @BaseSeguroEducativo =  @BaseSeguroEducativo  + @Importe --* 2
           ELSE
             SELECT @BaseSeguroEducativo = @BaseSeguroEducativo   + @Importe
         END
      END
      IF @GravaVacaciones <> 'NO'
        SELECT @BaseVacaciones = @BaseVacaciones + @Importe
    END
    FETCH NEXT FROM crNominaGrava INTO @IncidenciaID,@NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, 
                                     @GravaPrimaAntiguedad, @GravaIndemnizacion, @AplicaPreelaborada, 
                                     @GravaSeguroEducativo, @GravaVacaciones
  END
  CLOSE crNominaGrava
  DEALLOCATE crNominaGrava

  RETURN
END 
GO

if exists (select * from sysobjects where id = object_id('dbo.spNominaPanamaMueveQuincenasDias') and type = 'P') drop procedure dbo.spNominaPanamaMueveQuincenasDias
GO             
CREATE PROCEDURE  dbo.spNominaPanamaMueveQuincenasDias(@FechaIni datetime, @Dias int, @FechaFin datetime output)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Fecha datetime,

          @CuantasQuincenas int ,
          @Cual int ,
          @CuantosMeses int,
          @DiasMes int,
          @Mes int,
          @Dia int,
          @Ani int

  IF DAY(@FechaIni) <= 15 
    SELECT @DiasMes=1
  ELSE BEGIN
     SELECT @Mes=MONTH(@FechaIni),@Ani=YEAR(@FechaIni)
     EXEC spDiasMes @Mes, @Ani, @DiasMes OUTPUT
  END

  SELECT @Mes=MONTH(@FechaIni),@Ani=YEAR(@FechaIni)
  EXEC spIntToDateTime @DiasMes, @mes, @ani, @FechaIni OUTPUT
    
  SELECT @CuantasQuincenas=ROUND(@Dias/15,0)
  SELECT @CuantosMeses=ROUND(@CuantasQuincenas/2,0)

  IF ABS(@CuantosMeses) >= 1
     SELECT @Fecha = DATEADD(mm,@CuantosMeses,@FechaIni)
  ELSE 
     SELECT @Fecha = @FechaIni

  IF DAY(@Fecha) <= 15 
    SELECT @DiasMes=1
  ELSE BEGIN
     SELECT @Mes=MONTH(@Fecha),@Ani=YEAR(@Fecha)
     EXEC spDiasMes @Mes, @Ani, @DiasMes OUTPUT
  END
   SELECT @Mes=MONTH(@Fecha),@Ani=YEAR(@Fecha)


  EXEC spIntToDateTime @DiasMes, @Mes, @Ani, @Fecha OUTPUT

  IF @CuantosMeses * 1.0 <>  @CuantasQuincenas /2.0-- sobra todavia una quincena
  IF @Dias < 0  
  BEGIN
    IF DAY(@Fecha) < = 15 -- se va al final de el mes anterior
    BEGIN
      SELECT @Fecha= DATEADD(mm,-1,@Fecha)
      SELECT @Mes=MONTH(@Fecha),@Ani=YEAR(@Fecha)
      EXEC spDiasMes @Mes, @Ani, @DiasMes OUTPUT
      SELECT @Mes=MONTH(@Fecha),@Ani=YEAR(@Fecha)
      EXEC spIntToDateTime @DiasMes, @Mes, @ani, @Fecha OUTPUT
    END ELSE -- se va a la quincena
    BEGIN
      SELECT @Mes=MONTH(@Fecha), @Ani=YEAR(@Fecha)
      EXEC spIntToDateTime 15, @Mes, @Ani, @Fecha OUTPUT
    END
  END ELSE 
  BEGIN
    IF DAY(@Fecha) < = 15 -- se va al final de el mes 
    BEGIN
      SELECT @Mes = MONTH(@Fecha), @Ani=YEAR(@Fecha)
      EXEC spDiasMes @MEs,@Ani, @DiasMes OUTPUT
      SELECT @Mes = MONTH(@Fecha), @Ani=YEAR(@Fecha)
      EXEC spIntToDateTime @DiasMes, @Mes, @Ani, @Fecha OUTPUT
    END ELSE -- se va a la quincena del mes que sigue
    BEGIN
      SELECT @Fecha= DATEADD(mm,1,@Fecha)
      SELECT @Mes = MONTH(@Fecha), @Ani=YEAR(@Fecha)
      EXEC spIntToDateTime 15, @mes, @Ani, @Fecha OUTPUT
    END
  END
  SELECT @FechaFin = @Fecha    

END
GO

/********** spPeriodosPlanillaFaltantes ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spPeriodosPlanillaFaltantes' and type = 'P') DROP PROCEDURE spPeriodosPlanillaFaltantes
GO
CREATE PROCEDURE spPeriodosPlanillaFaltantes
                       @Personal     varchar(10),
                       @PeriodoTipo  varchar(20),
                       @FechaA       datetime,
                       @TipoCalculo  int = 0,    --- 0= calculo de fechas primer dia año, 2= Leido de la bd
                       @Periodos FLOAT OUTPUT -- ojo estas son quincenas
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @FechaAlta      datetime,
    @PrimerDiaAno   datetime,
    @PeriodosLeidos float

  IF @PeriodoTipo='Quincenal'
  BEGIN 

    SELECT @PrimerDiaAno = CONVERT(datetime,'01-01-' + RTRIM(CONVERT(varchar, YEAR(@FechaA))))

    SELECT @FechaAlta    = CONVERT(datetime, ISNULL(dbo.fnMayor(CONVERT(float,FechaAlta), CONVERT(float,@PrimerDiaAno)), CONVERT(float,@PrimerDiaAno))) 
      FROM Personal 
     WHERE Personal      = @Personal

    SELECT @FechaAlta    = ISNULL(@FechaAlta, @PrimerDiaAno)
    IF @TipoCalculo = 0
      SELECT @FechaAlta    = @PrimerDiaAno

    SELECT @Periodos     = DATEDIFF(M, @FechaAlta, @FechaA) * 2
    IF DAY(@FechaAlta) < = 15  AND DAY(@FechaA) > 15   SELECT @Periodos = @Periodos + 2
    IF DAY(@FechaAlta) >   15  AND DAY(@FechaA) > 15   SELECT @Periodos = @Periodos + 1
    IF DAY(@FechaAlta) < = 15  AND DAY(@FechaA) < = 15 SELECT @Periodos = @Periodos + 1

    IF @TipoCalculo = 1   
    BEGIN 

      SELECT @PeriodosLeidos      = sum(isNULL(Nominad.Cantidad,0))  
        FROM NominaConcepto
        JOIN cfgNominaConcepto   ON cfgNominaConcepto.NominaConcepto = NominaConcepto.NominaConcepto   
                                AND cfgNominaConcepto.ClaveInterna   in ('Sueldo','VacacionesTomadas' ) 
        JOIN NominaD             ON Nominad.Concepto = NominaConcepto.Concepto 
                                AND Nominad.Personal = @Personal
        JOIN Nomina              ON Nomina.id        = Nominad.ID                                               
                                AND ISNULL(Nomina.FechaA,Nomina.FechaEmision)       > @PrimerDiaAno 
                                AND YEAR(ISNULL(Nomina.FechaA,Nomina.FechaEmision)) = YEAR(@PrimerDiaAno)
                                AND Nomina.Estatus                                  = 'CONCLUIDO'       
      SELECT @PeriodosLeidos = @PeriodosLeidos/15.0
      SELECT @Periodos=dbo.fnMenor(@Periodos, @PeriodosLeidos)
    END
    SELECT @Periodos= 24 - @Periodos
  END
END
GO

/**************** spNominaPanamaSueldoDiarioVariableVacaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaPanamaSueldoDiarioVariableVacaciones') and type = 'P') drop procedure dbo.spNominaPanamaSueldoDiarioVariableVacaciones
GO
CREATE PROCEDURE spNominaPanamaSueldoDiarioVariableVacaciones
     @Empresa               varchar(5), 
     @Personal              varchar(10), 
     @FechaAlta             datetime, 
     @SueldoMensualPersonal money, 
     @ImporteComisiones     money,  
     @ImportePrimProd       money , 
     @FechaInicio           datetime,
     @SueldoDiarioVariable  money OUTPUT,
     @FechaIni              datetime=NULL output,
     @GastosRepresentacion  bit = 0
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @SueldoVariableVacacionesA datetime,
    @SueldoVariableVacacionesD datetime,
    @DiasVacaciones            float,
    @DiasVacaciones2           float,
    @DiasVacaciones3           float,
    @MasVacaciones             bit,
    @SueldoVariableAcumulado   money,
    @DiasTrabajados2           float,
    @SDI                       money,
    @Cantidad                  float,
    @AntiguedadMes             float
   

  SELECT @SDI = SDI FROM Personal where Personal=@Personal
  SELECT @Diasvacaciones = 0, @Diasvacaciones2 = 0, @Diasvacaciones3 = 0, @Cantidad = 0
  IF @FechaAlta > DATEADD(mm,-11,@FechaInicio)
    SELECT @SueldoVariableVacacionesD = @FechaAlta --se toman 11 meses menos de la fecha de calculo sueldo variable o la fecha de alta
  ELSE
    SELECT @SueldoVariableVacacionesD = DATEADD(mm,-11, @FechaInicio) --se toman 11 meses menos de la fecha de calculo sueldo variable o la fecha de alta
  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'SUELDO', @SueldoVariableVacacionesD, @FechaInicio, NULL, NULL, @DiasTrabajados2 OUTPUT        
  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'SUELDO', @SueldoVariableVacacionesD, @FechaInicio, NULL, NULL, @DiasTrabajados2 OUTPUT      
  WHILE (@DiasTrabajados2 ) < 11.0*30.0 and @SueldoVariableVacacionesD > @FechaAlta
  BEGIN
    EXEC spNominaPanamaMueveQuincenasDias @SueldoVariableVacacionesD, -15 , @SueldoVariableVacacionesD OUTPUT       
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'SUELDO', @SueldoVariableVacacionesD, @FechaInicio, NULL, NULL, @DiasTrabajados2 OUTPUT        
  END
  SELECT @SueldoVariableVacacionesA = @FechaInicio, @SueldoVariableAcumulado=0
  IF @GastosRepresentacion = 0
    EXEC spNominaGravaConceptoAcumuladoFechas	 @Empresa, @Personal,	@SueldoVariableVacacionesD,	@SueldoVariableVacacionesA, 'GravaVacaciones',		@SueldoVariableAcumulado	OUTPUT
  ELSE  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'GastosRepresentacion', @SueldoVariableVacacionesD, @FechaInicio, NULL, @SueldoVariableAcumulado Output, @Cantidad OUTPUT        



  SELECT @SueldoVariableAcumulado= (@SueldoVariableAcumulado) / 11.0 
  SELECT @AntiguedadMes = DATEDIFF(month, @FechaAlta, @FechaInicio)
  IF @GastosRepresentacion = 0 
    IF @AntiguedadMes < 11 
      SELECT @SueldoDiarioVariable = @SueldoVariableAcumulado
    ELSE
    IF @SueldoVariableAcumulado > (@SueldoMensualPersonal + @ImporteComisiones + @ImportePrimProd )
      SELECT  @SueldoDiarioVariable = @SueldoVariableAcumulado/30.0
    ELSE 
      SELECT @SueldoDiarioVariable = (@SueldoMensualPersonal + @ImporteComisiones + @ImportePrimProd ) / 30.0
  ELSE
    IF @SueldoVariableAcumulado > @SDI
      SELECT  @SueldoDiarioVariable = @SueldoVariableAcumulado/30.0
    ELSE
      IF @Cantidad > = 22
        SELECT  @SueldoDiarioVariable = @SDI / 30.0
      ELSE
        SELECT @SueldoDiarioVariable = @SueldoVariableAcumulado / 30.0
  SELECT @FechaIni = @SueldoVariableVacacionesD
END
GO

/**************** spNominaGravaPanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGravaPanama') and type = 'P') drop procedure dbo.spNominaGravaPanama
go
CREATE PROCEDURE spNominaGravaPanama
			@Empresa			           char(5),
			@Sucursal			           int,
			@ID				               int,
			@Personal			           char(10),
			@SucursalTrabajoEstado   varchar(50),
			@FechaD				           datetime,
			@FechaA				           datetime,
			@Moneda				           char(10),
			@TipoCambio			         float,
            @BasePrimaAntiguedad     money		OUTPUT,
            @BaseIndemnizacion       money		OUTPUT,
            @BasePreelaborada        money		OUTPUT,
            @BaseSeguroEducativo     money		OUTPUT,
            @BaseVacaciones          money		OUTPUT,
			@Ok				               int   		OUTPUT,
			@OkRef				           varchar(255)	OUTPUT,
            @BaseSueldoVariable money Output

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Factor				        float,
    @Tope				          money,
    @Exento				        money,
    @ExentoF				      money,
    @Gravable				      money,
    @GravableF				    money,
    @ClaveInterna			    varchar(50),
    @ClaveInternaPrefijo	varchar(50),
    @GravaPrimaAntiguedad varchar(50), 
    @GravaIndemnizacion		varchar(50), 
    @AplicaPreelaborada		varchar(50), 
    @GravaSeguroEducativo	varchar(50),
    @GravaVacaciones			varchar(50),
    @Importe 				      money, 
    @Cantidad 				    float, 
    @Semana				        int,
    @NominaConcepto			  varchar(10),
    @Movimiento				    varchar(20),
    @IncidenciaID         int,    
    @Repetir	            bit,
    @Prorratear	          bit,
    @SueldoVariable       bit,

    @Frecuencia	          varchar(20)


  IF @Ok IS NOT NULL RETURN

  SELECT @BasePrimaAntiguedad     = ISNULL(@BasePrimaAntiguedad, 0) ,
         @BaseIndemnizacion       = ISNULL(@BaseIndemnizacion, 0),
         @BasePreelaborada        = ISNULL(@BasePreelaborada, 0),
         @BaseSeguroEducativo     = ISNULL(@BaseSeguroEducativo, 0),
         @BaseVacaciones          = ISNULL(@BaseVacaciones, 0),
         @BaseSueldoVariable      = ISNULL(@BaseSueldoVariable, 0)

  DECLARE crNominaGrava CURSOR LOCAL FOR 
   SELECT d.IncidenciaID, nc.NominaConcepto, 
          d.Movimiento, 
          d.Semana, 
          SUM(d.Cantidad), 
          SUM(isNULL(d.Importe,0)), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaPrimaAntiguedad)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaIndemnizacion)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.AplicaPreelaborada)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaSeguroEducativo)), ''), 'NO'), 
          ISNULL(NULLIF(RTRIM(UPPER(nc.GravaVacaciones)), ''), 'NO'), 
          nc.SueldoVariable 
     FROM #Nomina d
     JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
    WHERE d.Personal = @Personal 
      AND d.Movimiento IN('Percepcion', 'Deduccion', 'Estadistica')

    GROUP BY d.IncidenciaID, nc.NominaConcepto, d.Movimiento, 
             nc.GravaPrimaAntiguedad, 
             nc.GravaIndemnizacion, 
             nc.AplicaPreelaborada, 
             nc.GravaSeguroEducativo, 
             nc.GravaVacaciones,
             nc.sueldoVariable,  
             d.Semana
    ORDER BY d.IncidenciaID, nc.NominaConcepto, d.Movimiento, 
             nc.GravaPrimaAntiguedad, 
             nc.GravaIndemnizacion, 
             nc.AplicaPreelaborada, 
             nc.GravaSeguroEducativo, 
             nc.GravaVacaciones,  
             d.Semana

  OPEN crNominaGrava
  FETCH NEXT FROM crNominaGrava INTO @IncidenciaID, @NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, 
                                     @GravaPrimaAntiguedad, @GravaIndemnizacion, @AplicaPreelaborada, 
                                     @GravaSeguroEducativo, @GravaVacaciones,@SueldoVariable

  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
        SELECT @Repetir    = Repetir, 
               @Prorratear = Prorratear, 
               @Frecuencia = Frecuencia  FROM Incidencia WHERE ID = @IncidenciaID 
      IF @Movimiento not in ('Percepcion','Estadistica') SELECT @Importe= -@Importe

      SELECT @Repetir= ISNULL(@Repetir,0),@Prorratear = ISNULL(@Prorratear,0)
  
      IF @GravaPrimaAntiguedad <> 'NO'
        SELECT @BasePrimaAntiguedad = @BasePrimaAntiguedad + @Importe

      IF @GravaIndemnizacion <> 'NO'
        SELECT @BaseIndemnizacion = @BaseIndemnizacion + @Importe

      IF @AplicaPreelaborada <> 'NO'
        SELECT @BasePreelaborada = @BasePreelaborada + @Importe


      IF @SueldoVariable = 1
        SELECT @BaseSueldoVariable = @BaseSueldoVariable + @Importe

      IF @GravaSeguroEducativo <> 'NO'
      BEGIN

       IF @Repetir =0 AND @Prorratear=0
          SELECT @BaseSeguroEducativo = @BaseSeguroEducativo + @Importe 
       ELSE
         IF @Repetir=1
         BEGIN
           IF  @Frecuencia ='Cada Nomina'
             SELECT @BaseSeguroEducativo =  @BaseSeguroEducativo  + @Importe --* 2
           ELSE
             SELECT @BaseSeguroEducativo = @BaseSeguroEducativo   + @Importe
         END
      END
      IF @GravaVacaciones <> 'NO'
        SELECT @BaseVacaciones = @BaseVacaciones + @Importe
    END
    FETCH NEXT FROM crNominaGrava INTO @IncidenciaID,@NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, 
                                     @GravaPrimaAntiguedad, @GravaIndemnizacion, @AplicaPreelaborada, 
                                     @GravaSeguroEducativo, @GravaVacaciones,@SueldoVariable
  END
  CLOSE crNominaGrava
  DEALLOCATE crNominaGrava

  RETURN
END 
GO

/**************** spISRLiquidacionPanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spISRLiquidacionPanama') and type = 'P') drop procedure dbo.spISRLiquidacionPanama
go
CREATE PROCEDURE  spISRLiquidacionPanama @Empresa varchar(5), @Personal varchar(10), @ISRTABLA VARCHAR(20), @Antiguedad float, @Indemnizacion money, @PrimaAntiguedad money, @PrimaAntiguedadAdicional money, @ISRLiquidacion money OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Gravable float
 
  SELECT @Antiguedad = CONVERT(float, CONVERT(int, @Antiguedad)), 
         @ISRLiquidacion = 0
  SELECT @Gravable   = @Indemnizacion + @PrimaAntiguedad + @PrimaAntiguedadAdicional 
  SELECT @Gravable   = @Gravable - (@Gravable * @Antiguedad / 100.0) -- SE LE QUITA UN 1% POR AÑO
  SELECT @Gravable   = @Gravable - 5000 --- SE QUITA 5000 
  IF @Gravable > 0 
    EXEC spTablaImpuesto @ISRTabla, NULL, '(Sin Periodo)', @Gravable, @ISRLiquidacion OUTPUT
END
GO

/********** spPeriodosXIIIFaltan ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spPeriodosXIIIFaltan' and type = 'P') DROP PROCEDURE dbo.spPeriodosXIIIFaltan
GO
CREATE PROCEDURE dbo.spPeriodosXIIIFaltan
                       @Personal     varchar(10),
                       @PeriodoTipo  varchar(20),
                       @FechaA       datetime,
                       @TipoCalculo  int = 0,    --- 0= calculo de fechas primer dia año, 2= Leido de la bd
                       @Periodos     float OUTPUT -- ojo estos son meses
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @Peridos        float,
    @FechaAlta      datetime,
    @PrimerDiaAno   datetime,
    @PeriodosLeidos float


  IF @PeriodoTipo='Quincenal'
  BEGIN 
    SELECT @PrimerDiaAno = CONVERT(datetime,'01-01-'+ RTRIM(CONVERT(varchar,YEAR(@FechaA))))
    IF MONTH(@FechaA) <=  4 and DAY(@FechaA) <= 15
       SELECT @Periodos = 1
    ELSE
      IF MONTH(@FechaA) >= 4   AND (MONTH(@FechaA) < 8 )
        SELECT @Periodos =  0.66667

      ELSE
      IF MONTH(@FechaA) >= 8 AND MONTH(@FechaA)<=12
        IF MONTH(@FechaA)=8 and DAY(@FechaA)<=15
          SELECT @Periodos =  0.66667
        ELSE
          SELECT @Periodos =  0.33334
      ELSE
        SELECT @Periodos = 0
  END
  IF @TipoCalculo = 1 
  BEGIN   
     SELECT @PeriodosLeidos=1-(count(Nominad.Concepto)*0.3333) 
     FROM NominaConcepto
     JOIN cfgNominaConcepto   ON cfgNominaConcepto.NominaConcepto   = NominaConcepto.NominaConcepto   
                             AND cfgNominaConcepto.ClaveInterna     = 'Aguinaldo' 
     JOIN NominaD             ON Nominad.Concepto                   = NominaConcepto.Concepto 
                             AND Nominad.Personal                          = @Personal
     JOIN Nomina              ON Nomina.id                                 = Nominad.ID                                               
                             AND ISNULL(Nomina.FechaA,Nomina.FechaEmision) > @PrimerDiaAno 
                             AND YEAR(ISNULL(Nomina.FechaA,Nomina.FechaEmision)) =YEAR(@PrimerDiaAno)
                             AND Nomina.Estatus= 'Concluido'       
  
     SELECT @Periodos = dbo.fnMenor(@Periodos, @PeriodosLeidos)
  END 
END
GO

/*************** spNominaPanamaAguinaldoNavidad *******************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaPanamaAguinaldoNavidad') and type = 'P') drop procedure dbo.spNominaPanamaAguinaldoNavidad
GO  
CREATE PROCEDURE spNominaPanamaAguinaldoNavidad
			@Empresa	     char(5),
			@Personal	     char(10),
                        @Ejercicio     int,            
                        @ImporteXIII   money,
                        @SueldoMensual money,
                        @Importe       int OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Concepto	varchar(50),
     @FechaD           Datetime,  
     @Cantidad         int,
     @FechaA           Datetime,
     @FechaAlta        Datetime,
     @SueldoDiario     money,
     @Tiempo           float

  SELECT @FechaD = Convert(Datetime,'01/01/' + convert(varchar(4),@Ejercicio),101)
  SELECT @FechaA = Convert(DateTime, '12/15/' + convert(varchar(4),@Ejercicio),101)
  SELECT @Cantidad  = 0.0, @Importe = 0.0
  SELECT @FechaAlta = FechaAntiguedad
    FROM Personal 
   WHERE Personal = @Personal AND FechaBaja IS NULL AND ESTATUS = 'ALTA'

  SELECT @Tiempo = DATEDIFF(mm,@FechaAlta, @FechaA)
  SELECT @SueldoDiario = @SueldoMensual / 30.0
  IF @Tiempo < 6 SELECT @Importe = 0
  ELSE
   IF (@Tiempo >= 6) AND (@Tiempo <= 12) 
     IF (@SueldoMensual / 2) > @ImporteXIII
        SELECT @Importe = (@SueldoMensual / 2.0)
      ELSE
          SELECT @Importe = 0
  ELSE    
  IF (@Tiempo > 12) and (@Tiempo < 24)
     SELECT @Importe =  (CASE WHEN (@SueldoMensual * 3.0/4.0) > @ImporteXIII THEN (@SueldoMensual * 3.0 /4.0) ELSE 0 END)
  ELSE
  IF  (@Tiempo >= 24)
    SELECT @Importe =  (CASE WHEN @SueldoMensual > @ImporteXIII THEN @SueldoMensual ELSE 0 END)

 RETURN
END
GO


/*************** spNominaIncentivosAsistencia *******************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaincentivosAsistencia') and type = 'P') drop procedure dbo.spNominaincentivosAsistencia
GO  
CREATE PROCEDURE spNominaincentivosAsistencia
			@Empresa	char(5),
			@Personal	char(10),
                        @Ejercicio      int,            
                        @Horas          float OUTPUT
--//WITH ENCRYPTION

AS BEGIN
  DECLARE
     @FechaA           Datetime,
     @FechaD           Datetime,  
     @Cantidad         Float,
     @FechaAntiguedad  DateTime ,
     @QCantidad        float


   SELECT  @FechaD = Convert(Datetime, '12/16/'  + convert(varchar(4),@Ejercicio-1),101)
   SELECT  @FechaA = Convert(DateTime, '12/15/'  + convert(varchar(4),@Ejercicio),101), @Horas = 0
   SELECT @FechaAntiguedad = FechaAntiguedad FROM Personal WHERE Personal = @Personal
   IF ABS(DATEDIFF(yy, @FechaA, @Fechaantiguedad)) >= 1
   BEGIN 
     SELECT  @Cantidad = 0.0, @Horas = 0.0
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Ausentismo', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Tardanza', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Falta/Injustificada', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Falta/PermisoSinSueldo', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Falta/Sancion', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Suspension', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Incapacidad', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'AusentismoJustificado', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Permiso', @FechaD, @FechaA, NULL, NULL, @QCantidad OUTPUT
     SELECT @Cantidad = @Cantidad + @QCantidad
     SELECT @QCantidad=0
     

     SELECT @Cantidad = 96 - @Cantidad 
     IF @Cantidad < 48 
       SELECT @Horas = 0
     ELSE 
        SELECT @Horas= @cantidad 
   END
  RETURN
END
GO

/******************************   spCalculaPremioAsistencia    ************************** cambio ABC*/

if exists (select * from dbo.sysobjects where id = object_id(N'dbo.spCalculaPremioAsistencia') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spCalculaPremioAsistencia]
GO
CREATE PROCEDURE dbo.spCalculaPremioAsistencia
    (
      @Empresa        varchar(5),
      @Personal       char(10),  
      @Fecha          datetime,
      @ImportePremio  money OUTPUT
    )
--//WITH ENCRYPTION
AS
  BEGIN
    DECLARE  
      @FechaD           datetime,
      @FechaA           datetime,
      @ClaveInterna     varchar(50),  
      @Importe          money,  
      @Sueldo           money,  
      @DiasTrabajados   tinyint,  
      @DiasVacaciones   tinyint,  
      @Dia              tinyint,
      @Mesa             tinyint,
      @Anoa             smallint,
      @FechaI           datetime      

        -- Constante 
          SELECT @ClaveInterna = 'Sueldo'

        -- Calcula d¡a,mes y a¤o de inicio del periodo
          SELECT @Dia = DAY(@Fecha)
          SELECT @Mesa = MONTH(@Fecha)
          SELECT @Anoa = YEAR(@Fecha)
   
         -- Calcula Fechas De y A del periodo anterior
          IF LEN(CONVERT(VARCHAR,@Mesa))=1
            SELECT @FechaI = CONVERT(DATETIME,CONVERT(CHAR(4),@Anoa)+'0'+CONVERT(CHAR(1),@Mesa)+'01', 101)
          ELSE
            SELECT @FechaI = CONVERT(DATETIME,CONVERT(CHAR(4),@Anoa)+CONVERT(CHAR(2),@Mesa)+'01', 101)

          SELECT @FechaD = DATEADD(M,-1,@FechaI)
          SELECT @FechaA = DATEADD(D,-1,@FechaI)
    
         -- Calcula sueldo y dias trabajados
           EXEC spNominaClaveInternaAcumuladoFechas 
                @Empresa, 
                @Personal, 
                @ClaveInterna, 
                @FechaD, 
                @FechaA, 
                NULL,
                @Sueldo OUTPUT, 
                @DiasTrabajados OUTPUT
 
         -- Calcula dias de vacaiones
           SELECT  @DiasVacaciones = COALESCE(SUM(NominaD.Cantidad),0)
             FROM  NominaD
             JOIN  Nomina          ON Nomina.ID              = NominaD.ID
             JOIN  NominaConcepto  ON NominaD.NominaConcepto = NominaConcepto.NominaConcepto
            WHERE  NominaConcepto.Especial = 'Vacaciones'
              AND  Nomina.Estatus = 'CONCLUIDO'
              AND  Nomina.fechaD BETWEEN @FechaD AND @FechaA
              AND  Personal = @Personal
 
        -- Calcula importe del premio
           SELECT @ImportePremio =  (@Sueldo  / @DiasTrabajados) * (@DiasTrabajados - @DiasVacaciones)
  END
GO

/***********************   SpEntidadImp    **********************************/
if exists (select * from sysobjects where object_id('dbo.SpEntidadImp')=id and type='P') drop procedure dbo.SpEntidadImp
GO
CREATE PROCEDURE dbo.SpEntidadImp
        @Entidad                                varchar(30)
--//WITH ENCRYPTION
AS BEGIN


  SELECT DISTINCT
     v.valor
    FROM PersonalPropValor v, Personal p, Sucursal s
   WHERE v.propiedad = '% Impuesto Nominas'
     AND v.Cuenta = S.Sucursal
     AND V.Rama = 'SUC'
     AND S.Sucursal = P.SucursalTrabajo
     AND S.Estado = @Entidad
     AND V.Valor <> '0'
END
GO

/***********************   spNominaSueldoComplementoIncidencia    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaSueldoComplementoIncidencia')=id and type='P') drop procedure dbo.spNominaSueldoComplementoIncidencia
GO
CREATE PROCEDURE dbo.spNominaSueldoComplementoIncidencia
        @Empresa                                char(5),
        @Personal                               char(10),
        @NomTipo                                varchar(50),
        @TipoCambio                             float,
        @RedondeoMonetarios                     float,
        @FechaA                                 datetime,
        @FechaD                                 datetime,
        @Ok                                     int             OUTPUT,
        @OkRef                                  varchar(255)    OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  INSERT #Nomina (
  Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)
  SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)
  FROM IncidenciaD d
  JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'
  JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
  WHERE NULLIF(d.SALDO, 0.0) IS NOT NULL
  AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina= 'Sueldo Complemento')
  AND d.FechaAplicacion <= @FechaA

END
GO

/***********************   spNominaAguinaldoComplementoIncidencia    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaAguinaldoComplementoIncidencia')=id and type='P') drop procedure dbo.spNominaAguinaldoComplementoIncidencia
GO
CREATE PROCEDURE dbo.spNominaAguinaldoComplementoIncidencia
        @Empresa                                char(5),
        @Personal                               char(10),
        @NomTipo                                varchar(50),
        @TipoCambio                             float,
        @RedondeoMonetarios                     float,
        @FechaA                                 datetime,
        @FechaD                                 datetime,
        @Ok                                     int             OUTPUT,
        @OkRef                                  varchar(255)    OUTPUT
--//WITH ENCRYPTION
AS BEGIN          
      
  INSERT #Nomina (          
  Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)
  SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)
  FROM IncidenciaD d
  JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'
  JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
  WHERE NULLIF(d.SALDO, 0.0) IS NOT NULL
  AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina In ('Aguinaldo Conf','AguinaldoComplemento'))
  AND d.FechaAplicacion <= @FechaA

END
GO

/***********************   spNominaCalcMexicoTipo    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaCalcMexicoTipo')=id and type='P') drop procedure dbo.spNominaCalcMexicoTipo
GO  
CREATE   PROCEDURE dbo.spNominaCalcMexicoTipo
   @Empresa                           char(5) OUTPUT,
   @TipoCambio                        float OUTPUT,
   @Personal                          char(10) OUTPUT,
   @FechaD                            datetime OUTPUT,
   @FechaA                            datetime OUTPUT,
   @CfgPrimaDominicalAuto             bit OUTPUT,
   @NomTipo                           varchar(50) OUTPUT,
   @NomCalcSDI                        bit OUTPUT,
   @CfgSubsidioIncapacidadEG          bit OUTPUT,
   @CfgFactorintegracionAntiguedad    varchar(20) OUTPUT,
   @CfgFactorintegracionTabla         varchar(50) OUTPUT,
   @IncidenciaD                       datetime OUTPUT,
   @IncidenciaA                       datetime OUTPUT,
   @RedondeoMonetarios                int OUTPUT,
   @Calc                              float OUTPUT,
   @CalcImporte                       money OUTPUT,
   @DescansaDomingos                  bit OUTPUT,
   @LaboraDomingos                    bit OUTPUT,
   @EsBimestre                        bit OUTPUT,
   @PrimerDiaMes                      datetime OUTPUT,
   @PrimerDiaBimestre                 datetime OUTPUT,
   @PersonalEstatus                   varchar(15) OUTPUT,
   @SucursalTrabajo                   int OUTPUT,
   @Categoria                         varchar(50) OUTPUT,
   @Puesto                            varchar(50) OUTPUT,
   @Cliente                           varchar(10) OUTPUT,
   @Jornada                           varchar(20) OUTPUT,
   @SMZ                               money OUTPUT,
   @SMDF                              money OUTPUT,
   @PrimerDiaAno1                     datetime OUTPUT,
   @UltimoDiaAno                      datetime OUTPUT,
   @FechaAlta                         datetime OUTPUT,
   @FechaAntiguedad                   datetime OUTPUT,
   @EsSocio                           bit OUTPUT,
   @SDI                               money OUTPUT,
   @SDINuevo                          money OUTPUT,
   @SueldoPeriodo                     money OUTPUT,
   @SueldoDiario                      money OUTPUT,
   @DiasMes                           float OUTPUT,
   @DiasMesTrabajados                 float OUTPUT,
   @DiasBimestre                      float OUTPUT,
   @DiasBimestreTrabajados            float OUTPUT,
   @DiasAno                           float OUTPUT,
   @DiasPeriodo                       float OUTPUT,
   @DiasPeriodoSubsidio               float OUTPUT,
   @DiasHabilesPeriodo                float OUTPUT,
   @DiasPeriodoEstandar               float OUTPUT,
   @DiasTrabajados                    float OUTPUT,
   @DiasTrabajadosImporte             float OUTPUT,
   @DiasNaturales                     float OUTPUT,
   @FactorAusentismo                  float OUTPUT,
   @DiasNaturalesTrabajados           float OUTPUT,
   @DomingosLaborados                 float OUTPUT,
   @Faltas                            float OUTPUT,
   @FaltasAcumulado                   float OUTPUT,
   @FaltasImporte                     money OUTPUT,
   @Incapacidades                     float OUTPUT,
   @IncapacidadesAcumulado            float OUTPUT,
   @IncapacidadesImporte              money OUTPUT,
   @ISRLiquidacionGravable            money OUTPUT,
   @SubsidoSueldoMensual              money OUTPUT,
   @IMSSBase                          money OUTPUT,
   @IMSSBaseAcumulado                 money OUTPUT,
   @IMSSBaseMes                       money OUTPUT,
   @IMSSObrero                        money OUTPUT,
   @IMSSObreroCV                      money OUTPUT,
   @IMSSObreroSinCV                   money OUTPUT,
   @IMSSPatron                        money OUTPUT,
   @IMSSPatronMensual                 money OUTPUT,
   @IMSSPatronCV                      money OUTPUT,
   @IMSSPatronRetiro                  money OUTPUT,
   @IMSSPatronInfonavit               money OUTPUT,
   @Antiguedad                        float OUTPUT,
   @PrimaDominicalPct                 float OUTPUT,
   @PrimaDominical                    money OUTPUT,
   @PrimaVacacionalPct                float OUTPUT,
   @Vacaciones                        money OUTPUT,
   @VacacionesTomadas                 float OUTPUT,
   @PrimaVacacional                   money OUTPUT,
   @PrimaVacacionalProporcion         money OUTPUT,
   @DiasVacaciones                    float OUTPUT,
   @DiasVacacionesProporcion          float OUTPUT,
   @DiasVacacionesSiguiente           float OUTPUT,
   @DiasVacacionesAcumulado           float OUTPUT,
   @Factorintegracion                 float OUTPUT,
   @CajaAhorro                        money OUTPUT,
   @CajaAhorroDesde                   datetime OUTPUT,
   @CajaAhorroHasta                   datetime OUTPUT,
   @FondoAhorroFactorAusentismo       varchar(10) OUTPUT,
   @ValesDespensaFactorAusentismo     varchar(10) OUTPUT,
   @AyudaFamiliarFactorAusentismo     varchar(10) OUTPUT,
   @FondoAhorroPct                    float OUTPUT,
   @FondoAhorro                       money OUTPUT,
   @FondoAhorro1                      money OUTPUT,
   @FondoAhorroAnticipoPct            float OUTPUT,
   @FondoAhorroDesde                  datetime OUTPUT,
   @FondoAhorroHasta                  datetime OUTPUT,
   @EsAniversario                     bit OUTPUT,
   @OtorgarDiasVacacionesAniversario  bit OUTPUT,
   @OtorgarPrimaVacacionalAniversario bit OUTPUT,
   @OtorgarPrimaVacacionalAguinaldo   bit OUTPUT,
   @TieneValesDespensa                bit OUTPUT,
   @ValesDespensaPct                  float OUTPUT,
   @ValesDespensaImporte              money OUTPUT,
   @ValesDespensa                     money OUTPUT,
   @PremioPuntualidadPct              float OUTPUT,
   @AyudaTransportePct	              float OUTPUT,
   @PremioAsistenciaPct               float OUTPUT,
   @SueldoVariable                    money OUTPUT,
   @SubsidioProporcionalFalta         bit OUTPUT,
   @Contrato                          varchar(100) OUTPUT,
   @MaxID                             int OUTPUT,
   @MaxRID                            float OUTPUT,
   @IncapacidadesD                    int OUTPUT,
   @CuotaSindical                     money OUTPUT,
   @Mov                               varchar(20) OUTPUT,
   @SDIAnterior                       money OUTPUT,
   @SDIVariableDiario                 money OUTPUT,
   @SDIBruto                          money OUTPUT,
   @FhiAntiguedad                     float OUTPUT,
   @AntiguedadSDI	                  float OUTPUT,
   @DiasAguinaldoSDI			      float OUTPUT,
   @DiasAguinaldoSiguienteSDI	      float OUTPUT,
   @AyudaFamiliar                     money OUTPUT,
   @TopeFondoAhorro                   money OUTPUT,
   @FondoAhorroTipoContrato           varchar(20) OUTPUT,
   @Plaza                             varchar(10) OUTPUT,
   @Ok                                int  OUTPUT,
   @OkRef                             varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  IF @NomTipo IN ('SDI', 'NORMAL', 'AJUSTE', 'FINIQUITO', 'LIQUIDACION', 'H.ASIMILABLE', 'PRIMA VACACIONAL','Prestamo Fondo Ahorr','Liquidacion Fondo Ahorro','Liquidacion Caja Ahorro','Aguinaldo')  
  BEGIN  
      -- Horas Extras (Explosion Automatica)  
    IF @NomTipo NOT IN ('LIQUIDACION FONDO AHORRO')  
      EXEC spNominaAgregarHorasExtras @NomTipo, @Empresa, @Personal, @FechaD, @FechaA, @IncidenciaD, @IncidenciaA, @TipoCambio, @Ok OUTPUT, @OkRef OUTPUT  
     -- Incidencias Manuales  
    IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION', 'Liquidacion Caja Ahorro') 
    BEGIN  
      INSERT #Nomina (  
             Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
      SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
        FROM IncidenciaD d  
        JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal 
         AND i.Estatus = 'PENDIENTE'  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
       WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL  

      INSERT #Nomina (  
             Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
      SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
        FROM IncidenciaD d  
        JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal 
         AND i.Estatus = 'PENDIENTE'  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto  AND nc.Movimiento <> 'Percepcion'  
       WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL 
    END ELSE  IF @NomTipo NOT IN ('FINIQUITO', 'LIQUIDACION', 'Aguinaldo', 'Liquidacion Caja Ahorro')                        
      INSERT #Nomina (  
             Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
      SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
        FROM IncidenciaD d  
        JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto 
         AND( RequiereDiasTrabajados  = 0  OR ( RequiereDiasTrabajados  = 1 AND @NomTipo ='AJUSTE' AND nc.Movimiento <> 'Deduccion'))  
         WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL  AND d.FechaAplicacion <= @IncidenciaA  
     
--spNominaGenerar 101, 1214, '04/14/2008 00:00:00', '04/27/2008 00:00:00', 'Catorcenal', '04/08/2008 00:00:00'
---se borran todos los conceptos que no aplican para este MOV

    DELETE #Nomina    
      FROM #Nomina n    
      JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto    
     WHERE nc.NominaConcepto NOT IN(SELECT MovEspecificoNomina.NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina.MovEspecificoNomina = @Mov)    
       AND n.Personal = @Personal   and exists(select * from MovEspecificoNomina where MovEspecificoNomina.nominaconcepto= n.NominaConcepto)


  ---se borran todos los conceptos que no aplican para este MOV

    EXEC xpNominaCalcIncidencia @NomTipo, @Empresa, @Personal, @FechaD, @FechaA, @IncidenciaD, @IncidenciaA, @TipoCambio, @Ok OUTPUT, @OkRef OUTPUT  

    -- Faltas   
    SELECT @Faltas = ISNULL(SUM(d.Cantidad), 0), @FaltasImporte = ISNULL(SUM(d.Importe), 0)  
      FROM #Nomina d  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Faltas'  
     WHERE d.Personal = @Personal  
-- SELECT *FROM NominaConcepto WHERE  ISNULL(Especial,'') = 'Faltas' 
-- CALCULA AYUDA FAMILIAR  
    IF @NomTipo IN ('NORMAL', 'AJUSTE', 'FINIQUITO', 'LIQUIDACION')  
    BEGIN  
      EXEC spCalculaAyudaFamiliar @Empresa, @Personal, @AyudaFamiliar OUTPUT  

      IF ISNULL(@AyudaFamiliar,0) <>0  
      BEGIN
        IF ISNULL(@AyudaFamiliarFactorAusentismo,'N') ='S'
          SELECT  @AyudaFamiliar= @AyudaFamiliar / @DiasPeriodo * (@DiasPeriodo -(ISNULL(@Faltas,0) * @FactorAusentismo))  

        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'AyudaFamiliar', @Empresa, @Personal,@DiasPeriodo, @AyudaFamiliar  
      END    
    END  
   -- Sueldo  
    IF @NomTipo IN ('NORMAL', 'FINIQUITO', 'LIQUIDACION','H.ASIMILABLE','Prima Vacacional')  
    BEGIN  
      EXEC spNominaClaveInternaEstaNomina @Personal, 'Vacaciones', @VacacionesTomadas OUTPUT  
      SELECT @VacacionesTomadas = isnull(@VacacionesTomadas,0)  
      SELECT @DiasPeriodo = @DiasPeriodo -  @VacacionesTomadas  
      SELECT @SueldoPeriodo = @SueldoDiario * @DiasPeriodo  

      SELECT @Plaza = Plaza from personal where personal = @Personal
      IF @mov = 'presupuesto'
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Sueldo', @Empresa, @Personal, @DiasPeriodo, @SueldoPeriodo , @referencia =@Plaza 
      ELSE
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Sueldo', @Empresa, @Personal, @DiasPeriodo, @SueldoPeriodo 
        
      EXEC spCalculaValesDespensa @Empresa, @Personal, @ValesDespensa OUTPUT  
      IF ISNULL(@ValesDespensa,0) <> 0  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ValesDespensa', @Empresa, @Personal, @DiasPeriodo, @ValesDespensa        
      EXEC spCalculaCuotaSindical  @Empresa, @Personal, @FechaD, @FechaA, @Mov, @CuotaSindical OUTPUT        
      IF  ISNULL(@CuotaSindical ,0)<>0.0  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'CuotaSindical', @Empresa, @Personal, @DiasPeriodo, @CuotaSindical  
      SELECT @DiasPeriodo = @DiasPeriodo +  @VacacionesTomadas  
    END   
    
  
   -- Incapacidades  
    SELECT @Incapacidades = ISNULL(SUM(d.Cantidad), 0), @IncapacidadesImporte = ISNULL(SUM(d.Importe), 0)  
      FROM #Nomina d  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Incapacidades'  
     WHERE d.Personal = @Personal  
  
    WHILE @Incapacidades > @DiasPeriodo AND @Incapacidades > 0 AND @PersonalEstatus='ALTA'  
    BEGIN  
      SELECT @MaxID = ISNULL(MAX (IncidenciaID), 0), @MaxRID= ISNULL(MAX (IncidenciaRID), 0)  
        FROM #Nomina d  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Incapacidades'  
       WHERE d.Personal = @Personal  
  
      DELETE #Nomina WHERE IncidenciaID = @Maxid AND IncidenciaRID=@MaxRid  
      SELECT @Incapacidades = ISNULL(SUM(d.Cantidad), 0), @IncapacidadesImporte = ISNULL(SUM(d.Importe), 0)  
        FROM #Nomina d  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Incapacidades'  
       WHERE d.Personal = @Personal  
    END  

    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Incapacidades', @FechaD, @FechaA, NULL, NULL, @IncapacidadesD OUTPUT  
  
    WHILE (@Incapacidades+@IncapacidadesD) > @DiasPeriodo and (@Incapacidades+@IncapacidadesD) > 0  and (@IncapacidadesD <= @DiasPeriodo) AND @PersonalEstatus='ALTA'  
    BEGIN  
      SELECT @MaxID = ISNULL(MAX (IncidenciaID), 0), @MaxRID= ISNULL(MAX (IncidenciaRID), 0)  
        FROM #Nomina d  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Incapacidades'  
       WHERE d.Personal = @Personal   
      DELETE #Nomina WHERE IncidenciaID = @Maxid AND IncidenciaRID=@MaxRid  
      SELECT @Incapacidades = ISNULL(SUM(d.Cantidad), 0), @IncapacidadesImporte = ISNULL(SUM(d.Importe), 0)  
        FROM #Nomina d  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND ISNULL(nc.Especial,'') = 'Incapacidades'  
       WHERE d.Personal = @Personal  
    END  

    --IF @NomTipo<>'SUELDO COMPLEMENTO'
	 -- BEGIN
	  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Faltas', @Empresa, @Personal, @Faltas, @FaltasImporte  
	 -- END  
	  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Incapacidades', @Empresa, @Personal, @Incapacidades, @IncapacidadesImporte  
	  
	  
	  IF @SubsidioProporcionalFalta = 1
             SELECT @DiasPeriodoSubsidio = (@DiasPeriodo - @Incapacidades) - (@Faltas * ( @DiasPeriodo/@DiasHabilesPeriodo ))  
    ELSE  
      SELECT @DiasPeriodoSubsidio = (@DiasPeriodo - @Incapacidades) - @Faltas  
    
    SELECT @SueldoVariable = ISNULL(SUM(d.Importe), 0)  
      FROM #Nomina d  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.SueldoVariable = 1  
     WHERE d.Personal = @Personal  
  
    IF @NomTipo = 'AJUSTE'  
    BEGIN  
      EXEC spNominaClaveInternaEstaNomina @Personal, 'Sueldo', @DiasNaturales OUTPUT  
      SELECT @DiasPeriodo = @DiasNaturales  
    END  
  
    EXEC spNominaClaveInternaEstaNomina @Personal, 'Vacaciones', @VacacionesTomadas OUTPUT  
    SELECT @Calc = -@VacacionesTomadas  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasVacaciones', @Empresa, @Personal, @Calc  
  
    SELECT @DiasNaturalesTrabajados = dbo.fnMayor(0, @DiasNaturales - @Faltas - @Incapacidades)  
    SELECT @DiasTrabajados = @DiasPeriodo - @Incapacidades - @Faltas  
--SELECT @DiasPeriodo , @Incapacidades , @Faltas
    IF @NomTipo NOT IN ('AJUSTE','LIQUIDACION FONDO AHORRO') AND @DiasTrabajados<0.0 SELECT @DiasTrabajados = 0.0  
    SELECT @DiasTrabajadosImporte = (@SueldoDiario*@DiasPeriodo) + @SueldoVariable - @FaltasImporte - @IncapacidadesImporte  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasPeriodo',   @Empresa, @Personal, @DiasPeriodo  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasNaturales',   @Empresa, @Personal, @DiasNaturales  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasTrabajados',   @Empresa, @Personal, @DiasTrabajados, @DiasTrabajadosImporte  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasTrabajadosSubsidio',   @Empresa, @Personal, @DiasPeriodoSubsidio, 0  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/SDI',   @Empresa, @Personal, @Importe = @SDI  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/SueldoDiario',  @Empresa, @Personal, @Importe = @SueldoDiario  
    
    IF @DiasTrabajados > 0  
    BEGIN  
     IF @NomTipo NOT IN ('FINIQUITO', 'LIQUIDACION', 'AJUSTE', 'SDI', 'LIQUIDACION FONDO AHORRO', 'AGUINALDO') --OR (@NomTipo IN ('Liquidacion Caja Ahorro') AND @Personal IN ('0279'))     /**********lagt**************/
     BEGIN  
       INSERT #Nomina (  
              Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Cuenta,     Vencimiento,   Cantidad,   Importe)  
       SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
         FROM IncidenciaD d  
         JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
         JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND RequiereDiasTrabajados = 1   
        WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL AND d.FechaAplicacion <= @IncidenciaA   
      END  
   
     IF @NomTipo  IN ('AJUSTE')  
       INSERT #Nomina (  
              Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Cuenta,     Vencimiento,   Cantidad,   Importe)  
       SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
         FROM IncidenciaD d  
         JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
         JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND  RequiereDiasTrabajados  = 1 AND nc.Movimiento = 'Deduccion'  
        WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL AND d.FechaAplicacion <= @IncidenciaA   
   
    END  
    
    --- ojo le arregle por la prima dominical no aplica para los nuevos  
    IF @CfgPrimaDominicalAuto = 1 AND (@DescansaDomingos = 1 OR @LaboraDomingos = 1) AND @NomTipo = 'NORMAL'  
    BEGIN  
      IF @FechaAlta <= @IncidenciaA  
      BEGIN  
        EXEC spNominaDomingosLaborados @Empresa, @Personal, @FechaD, @FechaA, @IncidenciaD, @IncidenciaA, @DomingosLaborados OUTPUT  
        SELECT @PrimaDominical = Round(@DomingosLaborados * Round((@SueldoDiario * Round( (@PrimaDominicalPct/100.0) ,2)),2),2)  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaDominical', @Empresa, @Personal, @DomingosLaborados, @PrimaDominical  
      END  
    END 
     
    IF @NomTipo in('NORMAL', 'PRIMA VACACIONAL','SDI')
    BEGIN ---- 0 -1
      IF @OtorgarDiasVacacionesAniversario = 0 AND @OtorgarPrimaVacacionalAniversario = 0  
      BEGIN  
        EXEC spNominaClaveInternaEstaNomina @Personal, 'Vacaciones', @DiasVacaciones OUTPUT  
        IF @DiasVacaciones > 0  
        BEGIN  
          SELECT @PrimaVacacionalPct = CASE WHEN ISNUMERIC(Valor)=1 THEN   
                 CONVERT(tinyint,Valor)  ELSE NULL END  
            FROM PersonalPropValor  
           WHERE Cuenta = @Empresa  
             AND Rama = 'EMP'  
             AND Propiedad = '% Prima Vacacional'  
          IF @PrimaVacacionalPct IS NULL  
           EXEC spTablaNum 'PRIMA VACACIONAL', @Antiguedad, @PrimaVacacionalPct OUTPUT  
        END  
        IF @OtorgarDiasVacacionesAniversario = 0
          IF  @OtorgarPrimaVacacionalAguinaldo = 1 AND ISNULL(@DiasVacaciones,0) = 0 
          BEGIN 
            IF ISNULL(@DiasVacaciones,0) = 0 
              EXEC spTablaNum 'VACACIONES', @Antiguedad, @DiasVacaciones OUTPUT  
  		      IF YEAR(@FechaA) = YEAR(@FechaAntiguedad)
  		      BEGIN
              SELECT @DiasVacaciones = 0.0 + @DiasVacaciones * (DATEDIFF(day, @PrimerDiaAno1, @UltimoDiaAno)+1.0)/@DiasAno
              SELECT @DiasAguinaldoSiguienteSDI = 0.0+ @DiasAguinaldoSiguienteSDI* (( DATEDIFF(day, @FechaAntiguedad, @UltimoDiaAno)+1.0)/ (DATEDIFF(day, @PrimerDiaAno1, @UltimoDiaAno)+1.0))
              SELECT @DiasAguinaldoSDI = @DiasAguinaldoSDI * (( DATEDIFF(day, @FechaAntiguedad, @UltimoDiaAno)+1.0) / (DATEDIFF(day, @PrimerDiaAno1, @UltimoDiaAno)+1.0))
            END
          END   
        SELECT @PrimaVacacional = @SueldoDiario * @DiasVacaciones * (@PrimaVacacionalPct / 100.0)  
      END       
      IF (@OtorgarPrimaVacacionalAguinaldo = 1 AND @NomTipo='PRIMA VACACIONAL') 
--     OR (@NomTipo='Normal' AND  @OtorgarPrimaVacacionalAguinaldo = 0 )
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaVacacional', @Empresa, @Personal, @DiasVacaciones, @PrimaVacacional  
    END  

    EXEC spNominaMexicoCalcSdi @Empresa,@SucursalTrabajo, @Categoria, @Puesto, @Personal, @NomTipo, @EsSocio, @SDI, @DiasNaturales,@Incapacidades, @Faltas, @SMDF, 
		   @EsBimestre, @NomCalcSDI, @PrimerDiaBimestre, @FechaA, @DiasAguinaldoSiguienteSDI, @DiasAguinaldoSDI, @PrimaVacacionalPct, @DiasVacacionesSiguiente, @DiasAno,
		   @DiasVacaciones, @AntiguedadSDI, @DiasBimestre, @DiasBimestreTrabajados, @SueldoDiario, @SDIAnterior, @SDIVariableDiario, @SDINuevo, @FechaAntiguedad, @SDIBruto,
		   @FhiAntiguedad, @ISRLiquidacionGravable, @CfgFactorIntegracionAntiguedad, @FaltasAcumulado OUTPUT, @IncapacidadesAcumulado	OUTPUT, @FactorIntegracion	OUTPUT,
		   @IMSSObrero	OUTPUT,  @IMSSObreroCV	OUTPUT, @IMSSPatron	OUTPUT, @IMSSPatronMensual	OUTPUT, @IMSSPatronCV	OUTPUT, @IMSSPatronRetiro	OUTPUT,
		   @IMSSPatronInfonavit	OUTPUT, @IMSSBase	OUTPUT,  @IMSSBaseMes	OUTPUT, @IMSSBaseAcumulado	OUTPUT, @IMSSObreroSinCV	OUTPUT, @Ok	OUTPUT, @CfgFactorIntegracionTabla	OUTPUT, @OkRef	OUTPUT
--FIN SDI
    
    IF @NomTipo = 'NORMAL' AND @EsAniversario = 1  
    BEGIN  

      IF @OtorgarDiasVacacionesAniversario = 1  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasVacaciones', @Empresa, @Personal, @DiasVacaciones  

      IF @OtorgarPrimaVacacionalAniversario = 1  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaVacacional', @Empresa, @Personal, @DiasVacaciones, @PrimaVacacional  

    END ELSE  
    IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')  
    BEGIN  
      IF @OtorgarPrimaVacacionalAguinaldo = 0 
      BEGIN 
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'DiasVacaciones', @FechaAntiguedad, @FechaA, NULL, NULL, @DiasVacacionesAcumulado OUTPUT  
        SELECT @Calc = -@DiasVacacionesAcumulado  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasVacaciones', @Empresa, @Personal, @Calc  
        SELECT @Vacaciones = @SueldoDiario * (@DiasVacacionesProporcion + @DiasVacacionesAcumulado)  
        Select @DiasVacacionesProporcion= @DiasVacacionesProporcion + @DiasVacacionesAcumulado  
         EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Vacaciones', @Empresa, @Personal, @DiasVacacionesProporcion, @Vacaciones  
        SELECT @DiasVacacionesProporcion =  @DiasVacacionesProporcion - @DiasVacacionesAcumulado   
        SELECT @PrimaVacacionalProporcion = @SueldoDiario * @DiasVacacionesProporcion * (@PrimaVacacionalPct/100.0)  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaVacacional', @Empresa, @Personal, @DiasVacacionesProporcion, @PrimaVacacionalProporcion  
      END ELSE 
      BEGIN
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'DiasVacaciones', @FechaAntiguedad, @FechaA, NULL, NULL, @DiasVacacionesAcumulado OUTPUT  

        SELECT @Calc = -@DiasVacacionesAcumulado  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'DiasVacaciones', @Empresa, @Personal, @Calc  

        SELECT @Vacaciones = @SueldoDiario * (@DiasVacacionesProporcion + @DiasVacacionesAcumulado)  
        SELECT @DiasVacacionesProporcion= @DiasVacacionesProporcion + @DiasVacacionesAcumulado  
EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Vacaciones', @Empresa, @Personal, @DiasVacacionesProporcion, @Vacaciones  

-- spNominaGenerar 100, 1677, '05/12/2008 00:00:00', '05/25/2008 00:00:00', 'Catorcenal', '05/19/2008 00:00:00'
-- select * from cfgnominaconcepto where nominaconcepto ='101'


        SELECT @DiasVacacionesProporcion =  @DiasVacacionesProporcion - @DiasVacacionesAcumulado   
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaVacacional', @Empresa, @Personal, @DiasVacacionesProporcion, @PrimaVacacionalProporcion  
      END  
    END  
  
    IF @TieneValesDespensa = 1  AND @NomTipo IN ('NORMAL', 'FINIQUITO', 'LIQUIDACION')  --AND @EsFinMes = 1 QUE SEA UN APROPIEDAD
    BEGIN  
      EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Faltas', @PrimerDiaMes, @FechaA, NULL, NULL, @FaltasAcumulado OUTPUT  
      EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Incapacidades', @PrimerDiaMes, @FechaA, NULL, NULL, @IncapacidadesAcumulado OUTPUT  
      SELECT @DiasMesTrabajados = dbo.fnMayor(0, @DiasMes - @Faltas - @FaltasAcumulado - @Incapacidades - @IncapacidadesAcumulado)  
      SELECT @ValesDespensaImporte = @ValesDespensaImporte + (@SueldoDiario*@DiasMesTrabajados*(@ValesDespensaPct/100.0))  
      IF ISNULL(@ValesDespensaImporte,0) <>0  
      BEGIN
         IF ISNULL(@ValesDespensaFactorAusentismo,'NO') = 'S'
            SELECT @ValesDespensaImporte = @ValesDespensaImporte / @DiasPeriodo * ( @DiasPeriodo -(@Faltas * @FactorAusentismo))
         IF @NomTipo IN ('NORMAL')
           EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ValesDespensa', @Empresa, @Personal, @Importe = @ValesDespensaImporte  

      END
    END  
    IF @PremioPuntualidadPct > 0.0 AND @NomTipo IN ('NORMAL', 'FINIQUITO', 'LIQUIDACION')  
    BEGIN  
      SELECT @CalcImporte = @DiasTrabajados*@SueldoDiario*(@PremioPuntualidadPct/100.0)  
      IF @Jornada in('Horario Completo') 
        SELECT @CalcImporte =@CalcImporte 
      IF @Contrato in ('TIEMPO DETERMINADO','TIEMPO INDETERMINADO') 
        IF @mov='presupuesto'  
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PremioPuntualidad', @Empresa, @Personal, @DiasTrabajados, @CalcImporte, @referencia=@Plaza  
        ELSE
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PremioPuntualidad', @Empresa, @Personal, @DiasTrabajados, @CalcImporte       
    END  









    IF @PremioAsistenciaPct > 0.0 AND @NomTipo IN ('NORMAL', 'FINIQUITO', 'LIQUIDACION')  
    BEGIN  
      SELECT @CalcImporte = @DiasTrabajados*@SueldoDiario*(@PremioAsistenciaPct/100.0)  
      IF @Mov='Presupuesto'
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PremioAsistencia', @Empresa, @Personal, @DiasTrabajados, @CalcImporte , @referencia=@Plaza 
      ELSE
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PremioAsistencia', @Empresa, @Personal, @DiasTrabajados, @CalcImporte  
    END  
  
    IF @NomTipo IN ('NORMAL')  
    BEGIN  
      IF NULLIF(@CajaAhorro, 0.0) IS NOT NULL AND ((@FechaD BETWEEN @CajaAhorroDesde AND @CajaAhorroHasta) OR (@FechaA BETWEEN @CajaAhorroDesde AND @CajaAhorroHasta))  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'CajaAhorro', @Empresa, @Personal, @Importe = @CajaAhorro  
    END  
  
    IF @NomTipo IN ('NORMAL', 'AJUSTE') AND ABS(@DiasTrabajados) > 0  

    BEGIN  
      SELECT @FondoAhorro1 = ISNULL(@FondoAhorro, 0.0) + ((@FondoAhorroPct/100)*@SueldoDiario*@DiasPeriodo+1)

      IF  @FondoAhorro1 < (@SMZ * 10.0 * @DiasPeriodoEstandar * 0.13)
      BEGIN
        IF @FondoAhorroFactorAusentismo = 'S' 
             SELECT @FondoAhorro = ISNULL(@FondoAhorro, 0.0) + ((@FondoAhorroPct/100)* @SueldoDiario * (@DiasPeriodo - (@Faltas * @FactorAusentismo)) ) 
        ELSE   
          SELECT @FondoAhorro = ISNULL(@FondoAhorro, 0.0) + ((@FondoAhorroPct/100)* @SueldoDiario * @DiasPeriodo )
        
      END ELSE 
        IF @FondoAhorroFactorAusentismo = 'S'   
          SELECT @FondoAhorro =  (@SMZ * 10.0 * @DiasPeriodoEstandar * 0.13 ) / @Diasperiodo *(@DiasPeriodo - (@Faltas * @FactorAusentismo)) 
        ELSE
          SELECT @FondoAhorro =  (@SMZ * 10.0 * @DiasPeriodoEstandar * 0.13 ) / @Diasperiodo *(@DiasPeriodo /*- (@Faltas)*/) 
        
      IF NULLIF(@FondoAhorro, 0.0) IS NOT NULL AND ((@FechaD BETWEEN @FondoAhorroDesde AND @FondoAhorroHasta) OR (@FechaA BETWEEN @FondoAhorroDesde AND @FondoAhorroHasta))  
      BEGIN  
        IF ISNULL(NULLIF(@TopeFondoAhorro, 0), 0) > 0  
          IF @FondoAhorro > @TopeFondoAhorro 
            SELECT @FondoAhorro = @TopeFondoAhorro

        IF RTRIM(@FondoAhorroTipoContrato) <> '' 
          IF @Contrato <> @FondoAhorroTipoContrato
            SELECT @FondoAhorro = 0
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro',      @Empresa, @Personal, @DiasPeriodo, @FondoAhorro  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Patron',          @Empresa, @Personal, @DiasPeriodo, @Importe = @FondoAhorro  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/PatronPercepcion', @Empresa, @Personal, @DiasPeriodo, @Importe = @FondoAhorro  
        SELECT @CalcImporte = (@FondoAhorro*2)*(@FondoAhorroAnticipoPct/100.0)  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Anticipo', @Empresa, @Personal, @Importe = @CalcImporte  
--select @diastrabajados,@FondoAhorro  
--spNominaGenerar 14504, 877, '03/03/2008 00:00:00', '03/16/2008 00:00:00', 'Catorcenal', '03/11/2008 00:00:00'
      END  
    END  
 
    IF @CfgSubsidioIncapacidadEG = 1 AND @NomTipo IN ('NORMAL', 'FINIQUITO', 'LIQUIDACION')  
      IF @Contrato='PERMANENTE'  
        EXEC spNominaSubsidioIncapacidadEG @Empresa, @Personal, @SueldoDiario, @SDI, @Ok OUTPUT, @OkRef OUTPUT  

  END  
END
GO

/***********************   spNominaCalcMexicoNomina    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaCalcMexicoNomina')=id and type='P') drop procedure dbo.spNominaCalcMexicoNomina
GO  
CREATE   PROCEDURE dbo.spNominaCalcMexicoNomina
   @Empresa                         char(5) OUTPUT,
   @Sucursal                        int OUTPUT,
   @ID                              int OUTPUT,
   @Moneda                          char(10) OUTPUT,
   @TipoCambio                      float OUTPUT,
   @Personal                        char(10) OUTPUT,
   @FechaD                          datetime OUTPUT,
   @FechaA                          datetime OUTPUT,
   @PeriodoTipo                     varchar(20) OUTPUT,
   @CfgAjusteMensualISR             bit OUTPUT,
   @CfgISRReglamentoAguinaldo       bit OUTPUT,
   @CfgISRReglamentoPTU             bit OUTPUT,
   @NomTipo                         varchar(50) OUTPUT,
   @EsFinMes                        bit OUTPUT,
   @PrimerDiaMes                    datetime OUTPUT,
   @PrimerDiaMesAnterior            datetime OUTPUT,
   @UltimoDiaMesAnterior            datetime OUTPUT,
   @UltimoDiaMes                    datetime OUTPUT,
   @SucursalTrabajoEstado           varchar(50) OUTPUT,
   @SMZ                             money OUTPUT,
   @SMZTopeHorasDobles              float OUTPUT,
   @SDI                             money OUTPUT,
   @SueldoMensual                   money OUTPUT,
   @SueldoMensualReglamento         money OUTPUT,
   @DiasMes                         float OUTPUT,
   @DiasAno                         float OUTPUT,
   @DiasPeriodo                     float OUTPUT,
   @DiasPeriodoSubsidio             float OUTPUT,
   @ISR                             money OUTPUT,
   @ISRAcumulado                    money OUTPUT,
   @ISRBruto                        money OUTPUT,
   @ISRVencimiento                  datetime OUTPUT,
   @ISRCreditoAlSalarioTabla        money OUTPUT,
   @ISRSubsidioAlEmpleoTabla        money OUTPUT,
   @ISRSubsidioAlEmpleoAcumulado    money OUTPUT,
   @ISRBase                         money OUTPUT,
   @ISRBaseMes                      money OUTPUT,
   @ISRBaseAcumulado                money OUTPUT,
   @ISRReglamentoBase               float OUTPUT,
   @ISRReglamentoFactor             float OUTPUT,
   @ISRSueldoMensual                money OUTPUT,
   @ISRSueldoMensualReglamento      money OUTPUT,
   @IMSSBase                        money OUTPUT,
   @ImpuestoEstatalBase             money OUTPUT,
   @CedularBase                     money OUTPUT,
   @AcreedorISR                     varchar(10) OUTPUT,
   @Antiguedad                      float OUTPUT,
   @PercepcionBruta                 money OUTPUT,
   @IndemnizacionTope               money OUTPUT,
   @Mov                             varchar(20) OUTPUT,
   @NuevoImporteISR                 money OUTPUT,
   @NuevoImporteCAS                 money OUTPUT,
   @DiasPeriodoMes                  int OUTPUT,
   @DiasTrabajadosSubsidioAcumulado float OUTPUT,
   @DiasTrabajadosImporteSubsidio   money OUTPUT,
   @EsISRReglamento                 bit OUTPUT,
   @Ok                              int  OUTPUT,
   @OkRef                           varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
  IF @NomTipo NOT IN ('AJUSTE ANUAL','SDI','IMPUESTO ESTATAL','LIQUIDACION FONDO AHORRO','SUELDO COMPLEMENTO')
  BEGIN  
    EXEC spNominaGrava @Empresa, @Sucursal, @ID, @Personal, @SucursalTrabajoEstado, @FechaD, @FechaA, @Moneda, @TipoCambio,  
                       @SMZ, @SMZTopeHorasDobles, @SDI, @DiasPeriodo, @DiasMes, @DiasAno, @Antiguedad, @IndemnizacionTope,   
                       @ISRBase OUTPUT, @IMSSBase OUTPUT, @ImpuestoEstatalBase OUTPUT, @CedularBase OUTPUT,  
                       @Ok OUTPUT, @OkRef OUTPUT  
--5SELECT @ISRBase,@IndemnizacionTope
-- spNominaGenerar 1, 380, '16/03/2008 00:00:00', '31/03/2008 00:00:00', 'Quincenal', '25/03/2008 00:00:00'

    SELECT @PercepcionBruta = 0.0  
    SELECT @PercepcionBruta = @PercepcionBruta + ISNULL(SUM(d.Importe), 0.0)  
      FROM #Nomina d  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
     WHERE d.Personal = @Personal  
--select @PercepcionBruta

    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Base',   @Empresa, @Personal, @Importe = @ISRBase  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/Base',   @Empresa, @Personal, @Importe = @IMSSBase  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/Base', @Empresa, @Personal, @Importe = @ImpuestoEstatalBase  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Cedular/Base',  @Empresa, @Personal, @Importe = @CedularBase  
    SELECT @EsIsrReglamento = 0
    SELECT @EsIsrReglamento = isnull(EsIsrReglamento,0) FROM MovTipo WHERE  Modulo = 'NOM' AND Mov = @Mov

    IF  (@CfgAjusteMensualISR = 1 AND @EsFinMes = 1) 
        OR @NomTipo IN ('FINIQUITO', 'LIQUIDACION', 'AGUINALDO', 'PTU', 'Prima Vacacional')  
        OR (@EsIsrReglamento = 1)
    BEGIN  
      IF (@NomTipo = 'AGUINALDO' AND @CfgISRReglamentoAguinaldo = 1) 
         OR (@NomTipo = 'PTU' AND @CfgISRReglamentoPTU = 1)  
         OR (@NomTipo = 'Prima Vacacional' AND @CfgISRReglamentoAguinaldo = 1)  
         OR (@EsIsrReglamento = 1)
      BEGIN  
        SELECT @SueldoMensualReglamento=0  
        if @MOV='BONO'
          SELECT @ISRReglamentoBase = @ISRBase / 90.0 * 30.4  
        ELSE 
          SELECT @ISRReglamentoBase = @ISRBase / 365.0 * 30.4  
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR', @PrimerDiaMesAnterior, @UltimoDiaMesAnterior, NULL, @SueldoMensualReglamento OUTPUT, NULL  
        SELECT @SueldoMensualReglamento = @SueldoMensual+ @ISRReglamentoBase  
        EXEC spTablaImpuesto 'ISR',     NULL, 'MENSUAL', @SueldoMensual, @ISRSueldoMensual OUTPUT
        SELECT @ISRSueldoMensual = @ISRSueldoMensual 
        EXEC spTablaImpuesto 'ISR',     NULL, 'MENSUAL', @SueldoMensualReglamento, @ISRSueldoMensualReglamento OUTPUT  
        SELECT @ISRReglamentoFactor = (@ISRSueldoMensualReglamento - @ISRSueldoMensual) / NULLIF(@ISRReglamentoBase, 0.0)  
        SELECT @ISR = @ISRBase * @ISRReglamentoFactor  
      END ELSE  
      BEGIN  
        IF @NomTipo IN ('AGUINALDO','PTU','Prima Vacacional')
        BEGIN
          EXEC spTablaImpuesto 'ISR',     NULL, 'MENSUAL', @ISRBase, @ISRSueldoMensual OUTPUT  
          SELECT @ISRSueldoMensual = @ISRSueldoMensual --- (@SubsidoSueldoMensual*@ISRSubsidioPct/100.0)  
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @ISRSueldoMensual, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
        END
        IF @NomTipo NOT IN ('AGUINALDO','PTU','Prima Vacacional')
        BEGIN
          IF @EsFinMEs = 0 
          BEGIN 
            EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/Base',             @PrimerDiaMes, @FechaA, NULL, @ISRBaseAcumulado OUTPUT, NULL  
            EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR',                  @PrimerDiaMes, @FechaA, NULL, @ISRAcumulado OUTPUT, NULL  
	        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/SubsidioAlEmpleo', @PrimerDiaMes, @FechaA, NULL, @ISRSubsidioAlEmpleoAcumulado OUTPUT, NULL  
	      END ELSE  
	      BEGIN
	        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/Base',             @PrimerDiaMes, @UltimoDiaMes, NULL, @ISRBaseAcumulado OUTPUT, NULL  
            EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR',                  @PrimerDiaMes, @UltimoDiaMes, NULL, @ISRAcumulado OUTPUT, NULL  
	        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/SubsidioAlEmpleo', @PrimerDiaMes, @UltimoDiaMes, NULL, @ISRSubsidioAlEmpleoAcumulado OUTPUT, NULL  
	      END  
          SELECT @DiasTrabajadosSubsidioAcumulado = ISNULL(@DiasTrabajadosSubsidioAcumulado, 0)   
          SELECT @ISRBaseAcumulado = ISNULL(@ISRBaseAcumulado, 0)   
          SELECT @ISRBaseMes = @ISRBaseAcumulado + @ISRBase  
          IF  @NomTipo = 'H.ASIMILABLE' -- ojo que aplica aqui  
          BEGIN   
            EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasPeriodo,	@DiasPeriodoSubsidio, @DiasMes ,@ISRBaseMes, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla		OUTPUT,	@ISRBruto	OUTPUT
            SELECT @ISR = @ISRBruto 
            SELECT @ISR = ROUND(@ISR,2) --, @ISRSubsidioAlEmpleo =ROUND(@ISRSubsidioAlEmpleo,2), @ISRBruto =ROUND(@ISRBruto,2)  --, @ISRSubsidio = ROUND(@ISRSubsidio,2)
            SELECT @ISR = @ISR - @ISRAcumulado , @ISRCreditoAlSalarioTabla = 0 --, @ISRSubsidio = @ISRSubsidio - @ISRSubsidioAcumulado  
          END ELSE  
          BEGIN
            EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'DiasTrabajadosSubsidio', @PrimerDiaMes, @FechaA, NULL, @DiasTrabajadosImporteSubsidio OUTPUT, @DiasTrabajadosSubsidioAcumulado OUTPUT
            SELECT @DiasTrabajadosSubsidioAcumulado = ISNULL(@DiasTrabajadosSubsidioAcumulado, 0)   
            SELECT @ISRBaseAcumulado = @ISRBaseAcumulado + @ISRBase
            SELECT @DiasTrabajadosSubsidioAcumulado =  isnull(@DiasPeriodoSubsidio,0) +  isnull(@DiasTrabajadosSubsidioAcumulado ,0)

       IF @Mov='PRESUPUESTO'
           BEGIN
           SELECT   @DIASPERIODOMES=@DiasMes,@DiasTrabajadosSubsidioAcumulado=@DiasMes
           END
            EXEC spNominaISRSubsidioAlEmpleoProporcional	@DIASPERIODOMES,	@DiasTrabajadosSubsidioAcumulado, @DiasMes,@ISRBaseAcumulado, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT, @esfinmes
            SELECT @ISR=ROUND(@ISR,2),@ISRSubsidioAlEmpleoTabla =ROUND(@ISRSubsidioAlEmpleoTabla,2), @ISRBruto =ROUND(@ISRBruto,2) -- , @ISRSubsidio = ROUND(@ISRSubsidio,2) 
          END  
        END
      END  
    END ELSE  -- cuando no es fin de mes
    BEGIN
      IF  @NomTipo = 'H.ASIMILABLE'  
      BEGIN  
        EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasPeriodo,	@DiasPeriodoSubsidio, @DiasMes ,@ISRBase, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
        SELECT @ISR = ROUND(@ISRBruto,2) 
        SELECT @ISRCreditoAlSalarioTabla = 0    
      END ELSE       
      IF @PeriodoTipo = 'SEMANAL'  
      BEGIN  
         EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasPeriodo,	@DiasPeriodoSubsidio, @DiasMes ,@ISRBase, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
      END ELSE  
      BEGIN  
        SELECT @DiasTrabajadosSubsidioAcumulado = ISNULL(@DiasTrabajadosSubsidioAcumulado, 0)   
        SELECT @ISRBaseAcumulado = ISNULL(@ISRBaseAcumulado, 0)   
        EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasPeriodo,	@DiasPeriodoSubsidio, @DiasMes ,@ISRBase, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
      END  
    END
    IF @ISR < 0.0  
    BEGIN  
      IF @EsFinMes = 1  
      BEGIN     
        SELECT @NuevoImporteISR = 0  
        SELECT @NuevoImporteISR = @ISRAcumulado * -1  
        IF @NuevoImporteISR <> 0   
        BEGIN  
  		    IF @PeriodoTipo = 'SEMANAL'  
		      BEGIN  
            EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @NuevoImporteISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
            EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasMES,	@DiasTrabajadosSubsidioAcumulado, @DiasMes ,@ISRBaseMEs, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
		      END ELSE 
		      BEGIN
-- spNominaGenerar 100, 1724, '05/26/2008 00:00:00', '06/08/2008 00:00:00', 'Catorcenal', '05/20/2008 00:00:00'
-- select @ISR
            EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @NuevoImporteISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
            EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasMes,	@DiasTrabajadosSubsidioAcumulado, @DiasMes ,@ISRBaseMes, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
	        END  
  	    END  
    ---AJUSTE DE CREDITO AL SALARIO
    -- AJUSTE DE SubsidioAlEmpleo
	      SELECT @ISR = @ISR - @ISRSubsidioAlEmpleoAcumulado
	      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleo', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
      END ELSE  
      BEGIN  
	      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleo', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
      END  
    END ELSE  
    BEGIN 
      IF @EsFinMes=1  AND @NomTipo <> 'Prima Vacacional' and @EsISrReglamento <>1
      BEGIN  
        SELECT @NuevoImporteCAS=0  
        SELECT @NuevoImporteCAS = @ISRSubsidioAlEmpleoAcumulado * -1  
        IF @NuevoImporteCAS<>0   
        BEGIN  
          IF @PeriodoTipo = 'SEMANAL'  
          BEGIN  
             EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleo', @Empresa, @Personal, @Importe = @NuevoImporteCAS, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento 
          END ELSE  
          IF (@NomTipo = 'AGUINALDO' AND @CfgISRReglamentoAguinaldo = 0 ) OR (@NomTipo <> 'AGUINALDO')
          BEGIN
	        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleo', @Empresa, @Personal, @Importe = @NuevoImporteCAS, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento 
            EXEC spNominaISRSubsidioAlEmpleoProporcional	@DiasMes,	@DiasTrabajadosSubsidioAcumulado, @DiasMes ,@ISRBaseMes, @ISR	OUTPUT,	@ISRSubsidioAlEmpleoTabla	OUTPUT,	@ISRBruto	OUTPUT
          END  
        END

        IF @NuevoImporteCAS = 0  
        BEGIN  
          SELECT @NuevoImporteISR=0  
          SELECT @NuevoImporteISR = @ISRAcumulado   
          IF @NuevoImporteISR <> 0   
          BEGIN  
            SELECT @ISR = @ISR - @NuevoImporteISR  
            EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
          END ELSE 
            begin
            EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
            end
        END ELSE 
        BEGIN  
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
        END          
      END ELSE  
      BEGIN  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR', @Empresa, @Personal, @Importe = @ISR, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
      END  
    END  
    
    IF  @NomTipo NOT IN ('SDI','LIQUIDACION FONDO AHORRO')
    BEGIN 
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Bruto',               @Empresa, @Personal, @Importe = @ISRBruto  
	  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleoTabla', @Empresa, @Personal, @Importe = @ISRSubsidioAlEmpleoTabla  
	 END
  END  

END
GO

/***********************   spNominaCalcMexicoIMSSInfonavit    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaCalcMexicoIMSSInfonavit')=id and type='P') drop procedure dbo.spNominaCalcMexicoIMSSInfonavit
GO  
CREATE   PROCEDURE dbo.spNominaCalcMexicoIMSSInfonavit
   @Empresa                        char(5) OUTPUT,
   @Personal                       char(10) OUTPUT,
   @FechaD                         datetime OUTPUT,
   @FechaA                         datetime OUTPUT,
   @PeriodoTipo                    varchar(20) OUTPUT,
   @CfgFactorIntegracionAntiguedad varchar(20) OUTPUT,
   @CfgFactorIntegracionTabla      varchar(50) OUTPUT,
   @NomTipo                        varchar(50) OUTPUT,
   @NomCalcSDI                     bit OUTPUT,
   @CalcImporte                    money OUTPUT,
   @EsBimestre                     bit OUTPUT,
   @PrimerDiaBimestre              datetime OUTPUT,
   @PrimerDiaBimestreAnterior      datetime OUTPUT,
   @UltimoDiaBimestreAnterior      datetime OUTPUT,
   @SucursalTrabajo                int OUTPUT,
   @Categoria                      varchar(50) OUTPUT,
   @Puesto                         varchar(50) OUTPUT,
   @SMZ                            money OUTPUT,
   @SMZPrimaAntiguedad             float OUTPUT,
   @SMDF                           money OUTPUT,
   @PrimerDiaAnoAnterior           datetime OUTPUT,
   @EsSocio                        bit OUTPUT,
   @SDI                            money OUTPUT,
   @SDINuevo                       money OUTPUT,
   @SueldoDiario                   money OUTPUT,
   @DiasBimestre                   float OUTPUT,
   @DiasBimestreTrabajados         float OUTPUT,
   @DiasAno                        float OUTPUT,
   @DiasAguinaldo                  float OUTPUT,
   @DiasAguinaldoSiguiente         float OUTPUT,
   @DiasPeriodo                    float OUTPUT,
   @DiasTrabajados                 float OUTPUT,
   @DiasNaturales                  float OUTPUT,
   @DiasNaturalesTrabajados        float OUTPUT,
   @DiasPrimaAntiguedad            float OUTPUT,
   @Faltas                         float OUTPUT,
   @FaltasAcumulado                float OUTPUT,
   @Incapacidades                  float OUTPUT,
   @IncapacidadesAcumulado         float OUTPUT,
   @IMSSBase                       money OUTPUT,
   @IMSSBaseAcumulado              money OUTPUT,
   @IMSSBaseMes                    money OUTPUT,
   @AcreedorIMSS                   varchar(10) OUTPUT,
   @AcreedorRetiro                 varchar(10) OUTPUT,
   @AcreedorInfonavit              varchar(10) OUTPUT,
   @IMSSVencimiento                datetime OUTPUT,
   @IMSSVencimientoBimestre        datetime OUTPUT,
   @IMSSObrero                     money OUTPUT,
   @IMSSObreroCV                   money OUTPUT,
   @IMSSObreroSinCV                money OUTPUT,
   @IMSSPatron                     money OUTPUT,
   @IMSSPatronMensual              money OUTPUT,
   @IMSSPatronCV                   money OUTPUT,
   @IMSSPatronRetiro               money OUTPUT,
   @IMSSPatronInfonavit            money OUTPUT,
   @Antiguedad                     float OUTPUT,
   @PrimaVacacionalPct             float OUTPUT,
   @PrimaVacacional                money OUTPUT,
   @DiasVacaciones                 float OUTPUT,
   @DiasVacacionesSiguiente        float OUTPUT,
   @FactorIntegracion              float OUTPUT,
   @InfonavitObrero                money OUTPUT,
   @AcumuladoInfonavitObrero       money OUTPUT,
   @InfonavitSDI                   float OUTPUT,
   @InfonavitSMGDF                 float OUTPUT,
   @InfonavitImporte               float OUTPUT,
   @SeguroRiesgoInfonavit          money OUTPUT,
   @PersonalPercepciones           money OUTPUT,
   @Mov                            varchar(20) OUTPUT,
   @DiasMesInfonavit               int OUTPUT,
   @MesI                           int OUTPUT,
   @YearI                          int OUTPUT,
   @InfonavitDias                  int OUTPUT,
   @DiasBimestreInfonavit          int OUTPUT,
   @FechaInicioDescuentoInfonavit  datetime OUTPUT,
   @DiasNaturalesInfonavit         float OUTPUT,
   @Ok                             int  OUTPUT,
   @OkRef                          varchar(255) OUTPUT  
--//WITH ENCRYPTION 
AS BEGIN  
  IF @NomTipo IN ('NORMAL', 'AJUSTE', 'FINIQUITO', 'LIQUIDACION')  
  BEGIN  
  --- imss  
    IF @EsSocio = 0 
    BEGIN  
      EXEC spNominaIMSS @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @SDI, @DiasNaturales, @Incapacidades, @Faltas, @SMDF, 1,  
                        @IMSSObrero OUTPUT, @IMSSObreroCV OUTPUT,  
                        @IMSSPatron OUTPUT, @IMSSPatronMensual OUTPUT, @IMSSPatronCV OUTPUT, @IMSSPatronRetiro OUTPUT, @IMSSPatronInfonavit OUTPUT  
      SELECT @IMSSObreroSinCV = @IMSSObrero-@IMSSObreroCV  
      -- Recalcular SDI Bimestral  
      IF @EsBimestre = 1 AND @NomCalcSDI = 1  
      BEGIN  
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'IMSS/Base',      @PrimerDiaBimestre, @FechaA, NULL, @IMSSBaseAcumulado OUTPUT, NULL  
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Faltas',         @PrimerDiaBimestre, @FechaA, NULL, NULL, @FaltasAcumulado OUTPUT  
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Incapacidades',  @PrimerDiaBimestre, @FechaA, NULL, NULL, @IncapacidadesAcumulado OUTPUT  
         
        SELECT @IMSSBaseMes = @IMSSBaseAcumulado + @IMSSBase  
        SELECT @FactorIntegracion = NULL  
       
        IF @CfgFactorIntegracionAntiguedad = 'SIGUIENTE'  
          SELECT @FactorIntegracion = 1+((@DiasAguinaldoSiguiente+((@PrimaVacacionalPct/100.0)*@DiasVacacionesSiguiente))/@DiasAno)  
        ELSE  
        IF @CfgFactorIntegracionAntiguedad = 'ACTUAL'   
          SELECT @FactorIntegracion = 1+((@DiasAguinaldo+((@PrimaVacacionalPct/100.0)*@DiasVacaciones))/@DiasAno)  
        ELSE  
        IF @CfgFactorIntegracionAntiguedad = 'TABLA'  
          EXEC spTablaNum @CfgFactorIntegracionTabla, @Antiguedad, @FactorIntegracion OUTPUT  
              
        SELECT @DiasBimestre = DATEDIFF(day, @PrimerDiaBimestre, @FechaA) + 1  
        SELECT @DiasBimestreTrabajados = dbo.fnmenor(@DiasBimestre, @DiasBimestre - ISNULL(@FaltasAcumulado, 0.0) - ISNULL(@IncapacidadesAcumulado, 0.0) - @Faltas - @Incapacidades)  
        SELECT @SDINuevo = dbo.fnMayor(dbo.fnMenor(@SueldoDiario * @FactorIntegracion + (@IMSSBaseMes / @DiasBimestreTrabajados), 25*@SMDF),@SMDF*1.0452)  
      
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI', @Empresa, @Personal, @DiasBimestreTrabajados, @SDINuevo  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/Factor', @Empresa, @Personal, @FactorIntegracion  
      END  
      IF @NomTipo <> 'H.ASIMILABLE'  
      BEGIN  
        IF ISNULL(@DiasTrabajados,0) <> 0  or @Mov='Presupuesto'  
        BEGIN
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/Obrero', @Empresa, @Personal, @DiasTrabajados, @IMSSObrero, @Vencimiento = @IMSSVencimiento, @Cuenta = @AcreedorIMSS  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/ObreroCV', @Empresa, @Personal, @Importe = @IMSSObreroCV, @Cuenta = @AcreedorIMSS, @Vencimiento = @IMSSVencimientoBimestre  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/ObreroSinCV', @Empresa, @Personal, @Importe = @IMSSObreroSinCV, @Cuenta = @AcreedorIMSS, @Vencimiento = @IMSSVencimiento  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/Patron', @Empresa, @Personal, @Importe = @IMSSPatron,   @Cuenta = @AcreedorIMSS, @Vencimiento = @IMSSVencimiento  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'IMSS/PatronCV', @Empresa, @Personal, @Importe = @IMSSPatronCV, @Cuenta = @AcreedorIMSS, @Vencimiento = @IMSSVencimientoBimestre  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Retiro/Patron', @Empresa, @Personal, @Importe = @IMSSPatronRetiro,  @Cuenta = @AcreedorRetiro, @Vencimiento = @IMSSVencimientoBimestre  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Infonavit/Patron', @Empresa, @Personal, @Importe = @IMSSPatronInfonavit, @Cuenta = @AcreedorInfonavit, @Vencimiento = @IMSSVencimientoBimestre  
    END
      END  
    END  
   -- Infonavit Obrero  
    SELECT @MesI  = DATEPART(MONTH, @FechaD)  
    SELECT @YearI = DATEPART(YEAR, @FechaD)  
    EXEC  spDiasMes @MesI, @YearI,@DiasMesInfonavit output  
    SELECT @InfonavitObrero = NULL  
    SELECT @InfonavitDias = ISNULL(@DiasPeriodo,0)- isnull(@Incapacidades,0)- isnull(@Faltas,0)
    
    IF @NomTipo = 'Ajuste'
    BEGIN
      SELECT @PersonalPercepciones = ISNULL(SUM(d.Importe), 0.0)  
        FROM #Nomina d  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
       WHERE d.Personal = @Personal  
      SELECT @InfonavitObrero = (@InfonavitSDI/100.0) * @PersonalPercepciones
-- spNominaGenerar 450, 1062, '03/31/2008 00:00:00', '04/13/2008 00:00:00', 'Catorcenal', '04/01/2008 00:00:00'

    END ELSE
    BEGIN 
    SELECT @DiasNaturalesInfonavit =  dbo.FnMenor(ABS(datediff (day, @FechaInicioDescuentoInfonavit,@FechaA))+1, @DiasNaturalesTrabajados)

    SELECT  @AcumuladoInfonavitObrero =NULL
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Infonavit/Obrero',  @PrimerDiaAnoAnterior, @Fechaa, NULL,  @AcumuladoInfonavitObrero OUTPUT, NULL
/*select @PrimerDiaAnoAnterior
select * from nominad where nominaconcepto='208' and personal ='0730'
select * from cfgnominaconcepto where claveinterna='Infonavit/Obrero'
select * from nominaconcepto where nominaconcepto='208'*/
    IF NULLIF(@AcumuladoInfonavitObrero,0) = NULL
      SELECT @DiasNaturalesInfonavit = datediff (day,  @FechaInicioDescuentoInfonavit,@FechaA)+1
    SELECT @AcumuladoInfonavitObrero = 0
--select isnull(@DiasNaturalesInfonavit,0)
--  spNominaGenerar 450, 1075, '03/31/2008 00:00:00', '04/13/2008 00:00:00', 'Catorcenal', '04/01/2008 00:00:00'
-- 

      IF NULLIF(@InfonavitSDI, 0.0) IS NOT NULL 
      BEGIN

        IF @PeriodoTipo = 'Catorcenal'
        BEGIN 
          EXEC spNominaBuscarDiasBimestre  @FechaA ,'Catorcenal', 4, @FechaD    ,  @FechaA    ,  @DiasBimestreInfonavit  output
          select @DiasBimestreInfonavit=70.0 -- ojo
          SELECT @UltimoDiaBimestreAnterior = DATEADD(day, -1, @PrimerDiaBimestre)
          SELECT @PrimerDiaBimestreAnterior = DATEADD(month, -2, @UltimoDiaBimestreAnterior)
          WHILE isnull(day(@PrimerDiaBimestreAnterior),1) <> 1
            SELECT @PrimerDiaBimestreAnterior =DATEADD(day,1,@PrimerDiaBimestreAnterior)
          EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Infonavit/Obrero',  @PrimerDiaBimestreAnterior, @UltimoDiaBimestreAnterior, NULL,  @AcumuladoInfonavitObrero OUTPUT, NULL, 'NOMINA'
          SELECT @InfonavitObrero =  ((((@InfonavitSDI/100.0) * @SDI * @DiasBimestreInfonavit) - @AcumuladoInfonavitObrero) / @DiasBimestreInfonavit) * @DiasNaturalesInfonavit ---@DiasNaturalesTrabajados
        END ELSE
        BEGIN
--select isnull(@DiasNaturalesInfonavit,0)
          SELECT @InfonavitObrero = (@InfonavitSDI/100.0) * @SDI * @DiasNaturalesInfonavit -- @DiasNaturalesTrabajados 

        END
      END
      ELSE BEGIN	  
        IF @InfonavitDias > 0
        BEGIN
          IF @PeriodoTipo = 'Catorcenal'
          BEGIN
              EXEC spNominaBuscarDiasBimestre  @FechaA ,'Catorcenal', 4, @FechaD    ,  @FechaA    ,  @DiasBimestreInfonavit  output
              SELECT @DiasBimestreInfonavit = 70.0-- ojo
              SELECT @InfonavitObrero = ISNULL(@InfonavitObrero,0.0) + (((@InfonavitSMGDF*@SMDF)*2)/ISNULL(@DiasBimestreInfonavit, 1)) * @DiasNaturalesInfonavit
              
              -- IF @PERSONAL='171'
              -- SELECT @DIASNATURALESTRABAJADOS,ISNULL(@InfonavitObrero,0.0), @InfonavitSMGDF, @SMDF, ISNULL(@DiasBimestreInfonavit, 1) , @DiasNaturalesInfonavit
              -- spNominaGenerar 100, 1944, '05/26/2008 00:00:00', '06/08/2008 00:00:00', 'Catorcenal', '06/02/2008 00:00:00'
          END    
          ELSE  
          IF NULLIF(@InfonavitSMGDF, 0.0) IS NOT NULL 
	          SELECT @InfonavitObrero = ISNULL(@InfonavitObrero,0.0) + (((@InfonavitSMGDF*@SMDF)*2)/ISNULL(dbo.fnDiasBimestre(@FechaA),1)) * @DiasNaturalesInfonavit
-- select @InfonavitSMGDF
          SELECT @InfonavitObrero = ISNULL(@InfonavitObrero,0.0)
        END ELSE
          IF NULLIF(@InfonavitSMGDF, 0.0) IS NOT NULL 
            SELECT @InfonavitObrero = 0
      END
  
      IF NULLIF(@InfonavitImporte, 0.0) IS NOT NULL  
        SELECT @InfonavitObrero = ISNULL(@InfonavitObrero,0) + @InfonavitImporte  
  
      IF @PeriodoTipo = 'QUINCENAL'  
        SELECT @SeguroRiesgoInfonavit = ISNULL(@SeguroRiesgoInfonavit,0)/4  
      ELSE IF @PeriodoTipo = 'MENSUAL'   
        SELECT @SeguroRiesgoInfonavit = ISNULL(@SeguroRiesgoInfonavit,0)/2  
      ELSE IF @PeriodoTipo = 'SEMANAL'  
        SELECT @SeguroRiesgoInfonavit = ISNULL(@SeguroRiesgoInfonavit,0)/16  
      ELSE IF @PeriodoTipo = 'Catorcenal'  
		--select @DiasNaturalesInfonavit =56
        SELECT @SeguroRiesgoInfonavit = (ISNULL(@SeguroRiesgoInfonavit,0)/ @DiasBimestreInfonavit) *  @DiasNaturalesInfonavit --@DiasNaturalesTrabajados

      IF ISNULL(@InfonavitObrero,0) <> 0   
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SeguroRiesgoInfonavit', @Empresa, @Personal, @Importe = @SeguroRiesgoInfonavit  
    END 
-- select @InfonavitObrero  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Infonavit/Obrero', @Empresa, @Personal, @Importe = @InfonavitObrero  
    
--    select  @DiasNaturalesInfonavit,@InfonavitObrero  
  -- Provisiones      
    IF @NomTipo IN ('NORMAL', 'AJUSTE')  
    BEGIN  
      SELECT @CalcImporte = @PrimaVacacional/@DiasAno*@DiasNaturales  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Provision/Vacaciones', @Empresa, @Personal, @Importe = @CalcImporte,@cantidad=@diasvacaciones  
      SELECT @CalcImporte = (@DiasAguinaldo*@SueldoDiario/@DiasAno)*@DiasNaturales  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Provision/Aguinaldo', @Empresa, @Personal, @Importe = @CalcImporte  
      IF (@SMZ*@SMZPrimaAntiguedad) < @SueldoDiario  
        SELECT @CalcImporte = (@DiasPrimaAntiguedad*@SMZ*@SMZPrimaAntiguedad*@Antiguedad)/@DiasAno*@DiasNaturales  
      ELSE  
        SELECT @CalcImporte =(@DiasPrimaAntiguedad*@SueldoDiario*@Antiguedad)/@DiasAno*@DiasNaturales  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Provision/Antiguedad', @Empresa, @Personal, @Importe = @CalcImporte  
    END  
  END  

END
GO

/***********************   spNominaCalcMexicoFinal    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaCalcMexicoFinal')=id and type='P') drop procedure dbo.spNominaCalcMexicoFinal
GO
CREATE PROCEDURE dbo.spNominaCalcMexicoFinal
   @Empresa                        char(5) OUTPUT,
   @Personal                       char(10) OUTPUT,
   @CalcImporte                    money OUTPUT,
   @PensionAAcreedor               varchar(10) OUTPUT, 
   @PersonalNeto                   money OUTPUT,
   @PersonalPercepciones           money OUTPUT,
   @PersonalDeducciones            money OUTPUT,
   @BeneficiarioSueldoNeto         varchar(100) OUTPUT,
   @Mov                            varchar(20) OUTPUT,
   @Plaza                          varchar(10) OUTPUT,
   @SeguroAuto                     money OUTPUT,
   @SeguroMedico                   money OUTPUT,
   @PensionSueldoNeto              money OUTPUT,
   @Ok                             int OUTPUT,
   @OkRef                          varchar(255) OUTPUT
   --//WITH ENCRYPTION

AS BEGIN

  DELETE #Nomina    
      FROM #Nomina n    
      JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto    
     WHERE nc.NominaConcepto NOT IN(SELECT MovEspecificoNomina.NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina.MovEspecificoNomina = @Mov)    
       AND n.Personal = @Personal   and exists(select * from MovEspecificoNomina where MovEspecificoNomina.nominaconcepto= n.NominaConcepto)

  SELECT @PersonalPercepciones = 0.0, @PersonalDeducciones = 0.0  

IF @MOV  = 'PRESUPUESTO'
    UPDATE #NOMINA SET REFERENCIA =@PLAZA WHERE NULLIF(referencia,'') IS NULL and personal=@Personal                        

IF @MOV  = 'PRESUPUESTO'
BEGIN                        
SELECT @PersonalPercepciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
   WHERE d.Personal = @Personal And isnull(Referencia,'')=isnull(@Plaza,'')                        
                        
SELECT @PersonalDeducciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Deduccion'  
   WHERE d.Personal = @Personal And isnull(Referencia,'')=isnull(@Plaza,'') 
 END                        
ELSE                        
  BEGIN 
  SELECT @PersonalPercepciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
   WHERE d.Personal = @Personal  

 	SELECT @PersonalDeducciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Deduccion'  
   WHERE d.Personal = @Personal  
  END
  SELECT @PersonalNeto = @PersonalPercepciones - @PersonalDeducciones  

  SELECT @PersonalDeducciones = @PersonalPercepciones - @PersonalNeto  
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/Percepciones', @Empresa, @Personal, @Importe = @PersonalPercepciones  
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/Deducciones', @Empresa, @Personal, @Importe = @PersonalDeducciones  
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/Neto', @Empresa, @Personal, @Importe = @PersonalNeto, @Beneficiario = @BeneficiarioSueldoNeto  
---se borran todos los conceptos que no aplican para este MOV

  EXEC spNominaClaveInternaEstaNomina @Personal, 'SEGURODEAUTO',                NULL,  @SeguroAuto OUTPUT  
  EXEC spNominaClaveInternaEstaNomina @Personal, 'SEGURODEGASTOSMEDICOSMAYORES', NULL, @SeguroMedico OUTPUT  
  EXEC spNominaClaveInternaEstaNomina @Personal, 'PensionA/SueldoNeto', NULL, @PensionSueldoNeto OUTPUT  
  SELECT @CalcImporte = @PensionSueldoNeto + @SeguroAuto + @SeguroMedico
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SumaSegurosyPensionesalim', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor  
      

    DELETE #Nomina    
      FROM #Nomina n    
      JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto    
     WHERE nc.NominaConcepto NOT IN(SELECT MovEspecificoNomina.NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina.MovEspecificoNomina = @Mov)    
       AND n.Personal = @Personal   and exists(select * from MovEspecificoNomina where MovEspecificoNomina.nominaconcepto= n.NominaConcepto)

END
GO

/***********************   spNominaCalcMexico    **********************************/
if exists (select * from sysobjects where object_id('dbo.spNominaCalcMexico')=id and type='P') drop procedure dbo.spNominaCalcMexico
GO  
CREATE   PROCEDURE dbo.spNominaCalcMexico  
   @Empresa                        char(5),  
   @FechaTrabajo                   datetime,  
   @Sucursal                       int,  
   @ID                             int,  
   @Moneda                         char(10),  
   @TipoCambio                     float,  
   @Personal                       char(10),  
   @FechaD                         datetime,  
   @FechaA                         datetime,  
   @PeriodoTipo                    varchar(20),  
   @CfgAjusteMensualISR            bit,  
   @CfgSueldoMinimo                varchar(20),  
   @CfgTablaVacaciones             varchar(50),  
   @CfgSubsidioIncapacidadEG       bit,  
   @CfgPrimaDominicalAuto          bit,  
   @CfgISRReglamentoAguinaldo      bit,  
   @CfgISRReglamentoPTU            bit,  
   @CfgISRLiquidacionSueldoMensual varchar(50),  
   @CfgFactorIntegracionAntiguedad varchar(20),  
   @CfgFactorIntegracionTabla      varchar(50),  
   @NomTipo                        varchar(50),  
   @NomCalcSDI                     bit,  
   @NomCxc                         varchar(20),  
   @RepartirDesde                  datetime,  
   @RepartirHasta                  datetime,  
   @RepartirIngresoTope            money,  
   @RepartirIngresoFactor          float,  
   @RepartirDiasFactor             float,  
   @CalendarioEsp                  bit,  
   @IncidenciaD                    datetime,  
   @IncidenciaA                    datetime,  
   @Estacion		                   int,
   @Ok                             int  OUTPUT,  
   @OkRef                          varchar(255) OUTPUT  
--//WITH ENCRYPTION
AS BEGIN  
  DECLARE  
    @RedondeoMonetarios    int,  
    @Dia                   int,  
    @Mes                   int,  
    @Ano                   int,  
    @Calc                  float,  
    @CalcImporte           money,  
    @FechaDAno             int,  
    @FechaAAno             int,  
    @DescansaDomingos      bit,  
    @LaboraDomingos        bit,  
    @EsInicioMes           bit,  
    @EsFinMes              bit,  
    @EsBimestre            bit,  
    @PrimerDiaMes          datetime,  
    @PrimerDiaMesAnterior  datetime,  
    @PrimerDiaBimestre     datetime,  
    @PrimerDiaBimestreAnterior     datetime,  
    @UltimoDiaBimestreAnterior  datetime,  
    @UltimoDiaMesAnterior  datetime,  
    @UltimoDiaMes          datetime,  
    @PersonalEstatus       varchar(15),  
    @PersonalCtaDinero     varchar(20),  
    @SucursalTrabajo       int,  
    @SucursalTrabajoEstado varchar(50),  
    @Categoria             varchar(50),  
    @Puesto                varchar(50),  
    @Cliente               varchar(10),  
    @Jornada               varchar(20),  
    @JornadaDiasLibres     int,  
    @JornadaHoras          float,  
    @PersonalDiasPeriodo   varchar(20),  
    @ZonaEconomica         varchar(30),  
    @SMZ                   money,  
    @SMZTopeHorasDobles    float,  
    @SMZPrimaAntiguedad    float,  
    @SMDF                  money,  
    @PrimerDiaAno          datetime,  
    @PrimerDiaAno1         datetime,  
    @PrimerDiaAnoAnterior  datetime,  
    @UltimoDiaAno          datetime,  
    @UltimoDiaAnoAnterior  datetime,  
    @FechaAlta             datetime,  
    @FechaBaja             datetime,  
    @FechaAntiguedad         datetime,  
    @FechaAniversario        datetime,  
    @FechaDAntiguedad        datetime,  
    @FechaAAntiguedad        datetime,  
    @UltimoPago              datetime,  
    @EsSocio                 bit,  
    @SDI                     money,  
    @SDINuevo                money,  
    @SueldoPeriodo           money,  
    @SueldoDiario            money,  
    @SueldoMensual           money,  
    @SueldoMensualReglamento money,  
    @DiasMes                 float,  
    @DiasMesTrabajados       float,  
    @DiasBimestre            float,  
    @DiasBimestreTrabajados  float,  
    @DiasAno                 float,  
    @Aguinaldo               money,  
    @AguinaldoPuntyAsis      money,  
    @AguinaldoAcumulado      money,  
    @DiasAguinaldo           float,  
    @DiasAguinaldoSiguiente  float,  
    @DiasAguinaldoProporcion  float,  
    @DiasAguinaldoSt       varchar(50),  
    @DiasPeriodo           float, 
    @DiasPeriodoSubsidio   float, 
    @DiasHabilesPeriodo    float,
    @DiasPeriodoEstandar   float,  
    @DiasTrabajados        float,  
    @DiasTrabajadosImporte float,  
    @DiasNaturales         float,  
    @FactorAusentismo      float,  
    @DiasNaturalesTrabajados  float,  
    @DiasNaturalesOriginales  float,  
    @DiasNaturalesDiferencia  float,  
    @DiasPrimaAntiguedad   float,  
    @DomingosLaborados     float,  
    @Faltas                float,  
    @FaltasAcumulado       float,  
    @FaltasImporte         money,  
    @Incapacidades         float,  
    @IncapacidadesAcumulado float,  
    @IncapacidadesImporte  money,  
    @ISR                   money,  
    @ISRAcumulado          money,  
    @ISRBruto              money,  
    @ISRVencimiento        datetime,  
    @ISRSubsidio           money,  
    @ISRSubsidioAcumulado  money,  
    @ISRSubsidioPct        float,  
    @ISRSubsidioPctH       float,  
    @ISRCreditoAlSalarioTabla  money,  
    @ISRSubsidioAlEmpleoTabla  money,  
    @ISRCreditoAlSalarioAcumulado money,  
    @ISRSubsidioAlEmpleoAcumulado money,  
    @ISRBase               money,  
    @ISRBaseMes            money,  
    @ISRBaseAcumulado      money,  
    @ISRReglamentoBase     float,  
    @ISRReglamentoFactor   float,  
    @ISRSueldoMensual      money,  
    @ISRSueldoMensualReglamento  money,  
    @ISRLiquidacion        money,  
    @ISRLiquidacionExcento money,  
    @ISRLiquidacionGravable  money,  
    @ISRLiquidacionFactor  float,  
    @ISRLiquidacionBase    float,  
    @ISRAnual              money,  
    @ISRAjuste             money,  
    @ISRAjusteMax          money,  
    @ISRAjusteAnual        money,  
    @SubsidoSueldoMensual  money,  
    @SubsidoSueldoMensualReglamento money,  
    @IMSSBase              money,  
    @IMSSBaseAcumulado     money,  
    @IMSSBaseMes           money,  
    @ImpuestoEstatalBase   money,  
    @CedularBase           money,  
    @AcreedorIMSS          varchar(10),  
    @AcreedorRetiro        varchar(10),  
    @AcreedorISR           varchar(10),  
    @AcreedorInfonavit     varchar(10),  
    @AcreedorFonacot       varchar(10),  
    @AcreedorImpuestoEstatal  varchar(10),  
    @IMSSVencimiento       datetime,  
    @IMSSVencimientoBimestre  datetime,  
    @IMSSObrero            money,  
    @IMSSObreroCV          money,  
    @IMSSObreroSinCV       money,  
    @IMSSPatron            money,  
    @IMSSPatronMensual     money,  
    @IMSSPatronCV          money,  
    @IMSSPatronRetiro      money,  
    @IMSSPatronInfonavit   money,  
    @Antiguedad            float,  
    @AntiguedadFlotante    float,  
    @AntiguedadSiguiente   float,  
    @AntiguedadDia         int,  
    @AntiguedadMes         int,  
    @PrimaDominicalPct     float,  
    @PrimaDominical        money,  
    @PrimaVacacionalPct    float,  
    @Vacaciones            money,  
    @VacacionesTomadas     float,  
    @PrimaAntiguedad       money,  
    @PrimaVacacional       money,  
    @PrimaVacacionalProporcion  money,  
    @PrimaVacacionalTope   money,  
    @PrimaVacacionalExcenta money,  
    @DiasVacaciones        float,  
    @DiasVacacionesProporcion  float,  
    @DiasVacacionesSiguiente  float,  
    @DiasVacacionesAcumulado  float,  
    @FactorIntegracion     float,  
    @ImpuestoEstatal       money,  
    @ImpuestoEstatalPct    float,  
    @ImpuestoEstatalGastoOperacionPct float,  
    @ImpuestoEstatalVencimiento       datetime,  
    @InfonavitObrero          money,  
    @AcumuladoInfonavitObrero money,
    @InfonavitSDI          float,  
    @InfonavitSMGDF        float,  
    @InfonavitImporte      float,  
    @SeguroRiesgoInfonavit money,  
    @PensionASueldoBruto   float,  
    @PensionASueldoBruto2  float,  
    @PensionASueldoBruto3  float,  
    @PensionASueldoNeto    float,  
    @PensionASueldoNeto2   float,  
    @PensionASueldoNeto3   float,  
    @PensionAAcreedor      varchar(10),  
    @PensionAAcreedor2     varchar(10),  
    @PensionAAcreedor3     varchar(10),  
    @PercepcionBruta       money,  
    @CajaAhorro            money,  
    @CajaAhorroDesde       datetime,  
    @CajaAhorroHasta       datetime,  
    @CajaAhorroLiquidacion datetime,  
    @CajaAhorroInteresTotalPct  float,  
    @CajaAhorroAcumulado   money,  
    @CajaAhorroAcumuladoDias float,  
    @CajaAhorroIngresosTopados money,  
    @CajaAhorroDiasTrabajados money,  
    @FondoAhorroFactorAusentismo varchar(10),
    @ValesDespensaFactorAusentismo varchar(10),
    @AyudaFamiliarFactorAusentismo varchar(10),
    @FondoAhorroPct        float,  
    @FondoAhorro           money,  
    @FondoAhorro1           money,  
    @FondoAhorroAnticipoPct float,  
    @FondoAhorroDesde      datetime,  
    @FondoAhorroHasta      datetime,  
    @FondoAhorroLiquidacion datetime,  
    @FondoAhorroInteresTotal money,  
    @FondoAhorroInteresTotalPct float,  
    @FondoAhorroDiasAcumulado float,  
    @FondoAhorroAcumulado  money,  
    @FondoAhorroAcumuladoDias  float,  
    @FondoAhorroPatronAcumulado  money,  
    @FondoAhorroPatronAcumuladoDias float,  
    @FondoAhorroAnticipoAcumulado  money,  
    @FondoAhorroPrestamoAcumulado  money,  
    @FondoAhorroAnticipoAcumuladoDias float,  
    @FondoAhorroIngresosTopados  money,  
    @FondoAhorroDiasTrabajados  money,  
    @EsAniversario         bit,  
    @OtorgarDiasVacacionesAniversario bit,  
    @OtorgarPrimaVacacionalAniversario bit,
    @OtorgarPrimaVacacionalAguinaldo   bit,
    @TieneValesDespensa    bit,  
    @ValesDespensaPct      float,  
    @ValesDespensaImporte  money,  
    @ValesDespensaImportePension  money,  
    @ValesDespensa         money,  
    @PremioPuntualidadPct  float,  
    @AyudaTransportePct    float,  
    @PremioAsistenciaPct   float,  
    @PersonalNeto          money,  
    @PersonalPercepciones  money,  
    @PersonalDeducciones   money,  
    @SueldoMinimo          money,  
    @IndemnizacionPct      float,  
    @Indemnizacion         money,  
    @IndemnizacionTope     money,  
    @Indemnizacion3Meses   money,  
    @Indemnizacion20Dias   money,  
    @SueldoVariable        money,  
    @SueldoVariableAcumulado  money,  
    @SueldoVariableDias    float,  
    @SueldoVariablePromedio money,  
    @SueldoVariablePTUDesde datetime,  
    @SueldoVariablePTUHasta datetime,  
    @SueldoVariableAguinaldoDesde datetime,  
    @SueldoVariableAguinaldoHasta datetime,  
    @PTUIngresosTopados    money,  
    @PTUDiasTrabajados     money,  
    @DescuentoISRAjusteAnualPct float,  
    @FiniquitoNetoEnCeros  bit,  
    @ConSueldoMinimo       bit,  
    @SubsidioProporcionalFalta bit,
    @BeneficiarioSueldoNeto  varchar(100),  
    @Contrato              varchar(100),  
    @MaxID                 int,  
    @MaxRID                float,  
    @IncapacidadesD        int,  
    @CuotaSindical         money,  
    @Mov                   varchar(20),  
    @ImporteISR            money,   
    @NuevoImporteISR       money,  
    @ImporteCAS            money,   
    @NuevoImporteCAS       money,  
    @DiasPeriodoMes        int,  
    @DiasMesInfonavit      int,   
    @MesI                  int,   
    @YearI                 int,
    @SDIAnterior           money,
    @SDIVariableDiario     money,
    @SDIBruto              money,
    @FhiAntiguedad         float,
    @FhiAntiguedadSDI      datetime,
    @AntiguedadSDI	   float,
    @DiasAguinaldoSDI			 float,
    @DiasAguinaldoSiguienteSDI	float,
    @AntiguedadSiguienteSDI float,
    @InfonavitDias         int,
    @ImpuestoEstatalExento float,
    @AguinaldoImporte		   money,
    @SueldoDiarioComplemento money,
    @ISRBaseAcumuladoSubsidioEmpleo	float,
    @DiasTrabajadosSubsidioAcumulado float,
    @DiasTrabajadosImporteSubsidio money,
    @AyudaFamiliar                  money,
    @DiasBimestreInfonavit int,
    @TopeFondoAhorro       money,
    @FondoAhorroTipoContrato varchar(20),
    @FondoAhorroEnFiniquito  varchar(2),
    @Plaza varchar(10),
    @PctIncremento float,
    @EsISRReglamento bit,
    @PrestamoFondoAhorroDesde datetime,
    @PrestamoFondoAhorroHasta datetime,
    @FechaInicioDescuentoInfonavit datetime,
    @DiasNaturalesInfonavit  float,
    @FondoAhorroAusentismoAcumulado float,
    @FondoAhorroAusentismoHorasAcumulado float,
    @FechaOrigen datetime,
    @SeguroAuto                 money,
    @SeguroMedico               money,
    @PensionSueldoNeto          money,
    @DESCAUSENTISMOFONDOAHORRO  money,
    @DESCAUSENTIMOAYUDAFAMILIAR	money,
    @DESCAUSENTHORASFONDOAH     money,
    @DESCAUSENTHORASAYUDAFAMIL  money,
    @RequiereAjusteAnual        bit,
    @RequiereAjuste        		varchar(5),
    @SueldoMaxAjuste        	money,
    @AjusteD                	datetime, 
    @AjusteA                	datetime,
    @CalcularAjusteAnual        bit,
    @Estatus                	varchar(30)

  SELECT @FechaOrigen = FechaOrigen FROM Nomina WHERE ID = @ID  
  SELECT @Plaza = Plaza FROM Personal WHERE Personal = @Personal
  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID  
  
  SELECT @Mov =LTRIM(RTRIM(@Mov)  )
   

  SELECT @EsInicioMes = 0, @EsFinMes = 0, @EsBimestre = 0, @Incapacidades = 0, @Faltas = 0, @EsAniversario = 0, @DiasNaturalesDiferencia = 0,  
         @ISRBase = 0.0, @IMSSBase = 0.0, @ImpuestoEstatalBase = 0.0, @CedularBase = 0.0,  
         @ISR = 0.0, @IMSSObrero = 0.0, @IMSSPatron = 0.0, @SueldoMinimo = 0.0, @DomingosLaborados = 0.0, @DiasAguinaldo = 0.0, @DiasAguinaldoSiguiente = 0.0,  
         @SueldoVariable = 0.0, @SubsidioProporcionalFalta=0  

  SELECT @SucursalTrabajo  = p.SucursalTrabajo,  
         @SucursalTrabajoEstado  = s.Estado,  
         @Categoria    = p.Categoria,  
         @Puesto   = p.Puesto,  
         @Cliente   = p.Cliente,  
         @PersonalEstatus  = p.Estatus,  
         @PersonalCtaDinero  = p.CtaDinero,  
         @SDI     = ISNULL(p.SDI, 0.0),  
         @SueldoDiario   = ISNULL(p.SueldoDiario, 0.0),  
         @FechaAlta    = p.FechaAlta,  
         @FechaAntiguedad  = ISNULL(p.FechaAntiguedad, p.FechaAlta),  
         @FechaBaja   = p.FechaBaja,  
         @Jornada   = p.Jornada,  
         @JornadaHoras   = NULLIF(j.HorasPromedio, 0.0),  
         @PersonalDiasPeriodo  = UPPER(p.DiasPeriodo),  
         @ZonaEconomica   = p.ZonaEconomica,  
         @UltimoPago   = p.UltimoPago,  
         @EsSocio   = ISNULL(p.EsSocio, 0),  
         @DiasPeriodoEstandar   = ISNULL(pt.DiasPeriodo, 0),  
         @DescansaDomingos  = ISNULL(j.Domingo, 0),  
         @IndemnizacionPct  = ISNULL(p.IndemnizacionPct, 100.0),  
         @Contrato   = UPPER(p.TipoContrato)  ,
         @DiasHabilesPeriodo = ISNULL(pt.DiasHabiles, 0),  
         @FactorAusentismo  = ISNULL(j.FactorAusentismo, 0),
         @PctIncremento    = isnull(p.Incremento,0),
         @SueldoDiarioComplemento = ISNULL(SueldoDiarioComplemento,0.0) ,
         @Estatus=   UPPER(p.Estatus)
    FROM Personal p  
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo  
    LEFT OUTER JOIN Jornada j ON j.Jornada = p.Jornada  
    LEFT OUTER JOIN Sucursal s ON s.Sucursal = p.SucursalTrabajo  
   WHERE p.Personal = @Personal 
   -- AND p.PeriodoTipo = @PeriodoTipo  

  SELECT @Mov = Mov FROM Nomina WHERE ID = @ID  
  SELECT @Mov =LTRIM(RTRIM(@Mov)  )
     

  IF @FechaA < @FechaAlta and @mov <>'Presupuesto' SELECT @Ok = 45010  
  IF @UltimoPago > @FechaA and @Nomtipo <> 'Impuesto Estatal' and @mov <>'Presupuesto' SELECT @Ok = 45020  
  
  IF @Ok IN (45010, 45020) AND @NomTipo = 'SDI'
    SELECT @Ok = NULL

  SELECT @DiasNaturalesOriginales = DATEDIFF(day, @FechaD, @FechaA) + 1  
  
  IF @Mov ='PRESUPUESTO' 
   BEGIN
     SELECT @Diasperiodo=30, @DiasPeriodoEstandar=30, @PersonalDiasPeriodo=30, @DiasNaturalesOriginales=30, @DiasNaturales=30, @EsFinMes = 1
     
    IF @Mov ='PRESUPUESTO'      SELECT   @EsFinMes = 1

   --IF (5000)-(@SueldoDiario * 30.0 * 1.20) > 2  -- si no ha llegado a 5000
   SELECT @Antiguedad = dbo.fnAntiguedad(@FechaAntiguedad, @FechaA)
    IF @Antiguedad >=1
    BEGIN
       SELECT @SueldoDiario = @SueldoDiario*(1+(@PctIncremento/100.0))
    --ELSE 
       SELECT @SueldoDiarioComplemento = @SueldoDiarioComplemento * (1+(@PctIncremento/100.0))
    end

   END

  IF @UltimoPago IS NULL SELECT @FechaD = @FechaAlta  
  
  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')  
  BEGIN  
    IF @UltimoPago IS NULL SELECT @FechaD = @FechaAlta ELSE SELECT @FechaD = DATEADD(day, 1, @UltimoPago)  
    IF @PersonalEstatus = 'BAJA' SELECT @FechaA = ISNULL(@FechaBaja, @FechaTrabajo) ELSE SELECT @FechaA = FechaOrigen FROM Nomina WHERE ID = @ID  
  END  
  IF @CalendarioEsp = 0 SELECT @IncidenciaD = @FechaD, @IncidenciaA = @FechaA  
    
  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version  
  SELECT @SMDF = SueldoMinimo FROM ZonaEconomica WHERE Zona = 'A'  
  SELECT @SMZ = SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica  

  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Mes',      @DiasMes OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Ano',     @DiasAno OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Aguinaldo',    @DiasAguinaldoSt OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Subsidio Acreditable Honorarios',    @ISRSubsidioPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Subsidio Acreditable',    @ISRSubsidioPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Prima Dominical',    @PrimaDominicalPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Prima Vacacional',    @PrimaVacacionalPct OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor SHCP',     @AcreedorISR OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor IMSS',     @AcreedorIMSS OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Retiro',     @AcreedorRetiro OUTPUT  
  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Infonavit',    @AcreedorInfonavit OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Fonacot',    @AcreedorFonacot OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Impuesto Estatal',  @AcreedorImpuestoEstatal OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# SMZ Prima Antiguedad',    @SMZPrimaAntiguedad OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Impuesto Estatal',    @ImpuestoEstatalPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'GastosOperacionImpuestoEstatal',  @ImpuestoEstatalGastoOperacionPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% SDI Credito Infonavit',    @InfonavitSDI OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# SMGDF Credito Infonavit',  @InfonavitSMGDF OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '$ Credito Infonavit',    @InfonavitImporte OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Pension Alimenticia',  @PensionAAcreedor OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Pension Alimenticia 2',  @PensionAAcreedor2 OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Acreedor Pension Alimenticia 3',  @PensionAAcreedor3 OUTPUT  
  --EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Cuenta Pension Alimenticia',    @PensionACuenta  OUTPUT  
  --EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Cuenta Pension Alimenticia 2',  @PensionACuenta2 OUTPUT  
  -- EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Cuenta Pension Alimenticia 3',  @PensionACuenta3 OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Ayuda Familiar Factor Ausentismo(S/N)', @AyudaFamiliarFactorAusentismo OUTPUT  
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Ayuda Familiar',     @AyudaFamiliar OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Vales Despensa Factor Ausentismo(S/N)', @ValesDespensaFactorAusentismo OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Fondo Ahorro Factor Ausentismo(S/N)', @FondoAhorroFactorAusentismo OUTPUT  

  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Fondo Ahorro en el Finiquito(S/N)', @FondoAhorroEnFiniquito OUTPUT 

  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Bruto',  @PensionASueldoBruto OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Bruto 2', @PensionASueldoBruto2 OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Bruto 3', @PensionASueldoBruto3 OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Neto',  @PensionASueldoNeto OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Neto 2',  @PensionASueldoNeto2 OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Pension Alimenticia Sueldo Neto 3',  @PensionASueldoNeto3 OUTPUT  
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Caja de Ahorro',     @CajaAhorro OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Caja de Ahorro Desde (DD/MM/AAAA)',    @CajaAhorroDesde OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Caja de Ahorro Hasta (DD/MM/AAAA)',    @CajaAhorroHasta OUTPUT  

  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Fondo de Ahorro',    @FondoAhorroPct OUTPUT  
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Fondo de Ahorro',     @FondoAhorro OUTPUT  
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Tope Fondo de Ahorro',     @TopeFondoAhorro OUTPUT
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Fondo Ahorro Tipo Contrato', @FondoAhorroTipoContrato OUTPUT      
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Anticipo Fondo de Ahorro',   @FondoAhorroAnticipoPct OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Fondo de Ahorro Desde (DD/MM/AAAA)',    @FondoAhorroDesde OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Fondo de Ahorro Hasta (DD/MM/AAAA)',    @FondoAhorroHasta OUTPUT
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Prestamo Fondo de Ahorro Desde (DD/MM/AAAA)',    @PrestamoFondoAhorroDesde OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'Prestamo Fondo de Ahorro Hasta (DD/MM/AAAA)',    @PrestamoFondoAhorroHasta OUTPUT
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# SMZ Tope Horas Dobles',    @SMZTopeHorasDobles OUTPUT  

  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Dias Vacaciones Aniversario (S/N)', @OtorgarDiasVacacionesAniversario OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Prima Vacacional Aniversario (S/N)', @OtorgarPrimaVacacionalAniversario OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Prima Vacacional Tipo Aguinaldo (S/N)', @OtorgarPrimaVacacionalAguinaldo OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Vales Despensa (S/N)',   @TieneValesDespensa OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'SubsidioProporcionalAusentismo(S/N)', @SubsidioProporcionalFalta OUTPUT
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Vales Despensa % Sueldo',   @ValesDespensaPct OUTPUT  
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Vales Despensa Importe',   @ValesDespensaImporte OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Premio Puntualidad',   @PremioPuntualidadPct OUTPUT  
  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Premio Asistencia',   @PremioAsistenciaPct OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Prima Antiguedad',    @DiasPrimaAntiguedad OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Sueldo Variable PTU Desde (DD/MM/AAAA)',  @SueldoVariablePTUDesde OUTPUT  

  EXEC spPersonalPropValorDMA   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Sueldo Variable PTU Hasta (DD/MM/AAAA)',  @SueldoVariablePTUHasta OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Sueldo Variable Aguinaldo Desde (DD/MM/AAAA)', @SueldoVariableAguinaldoDesde OUTPUT  
  EXEC spPersonalPropValorDMA   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Sueldo Variable Aguinaldo Hasta (DD/MM/AAAA)', @SueldoVariableAguinaldoHasta OUTPUT  
 

   EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Desc ISR Ajuste Anual (Sueldo Dias Trabajados)', @DescuentoISRAjusteAnualPct OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Labora Domingos (S/N)',   @LaboraDomingos OUTPUT  
  EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Finiquito Neto en Ceros (S/N)',  @FiniquitoNetoEnCeros OUTPUT  
  EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Beneficiario Sueldo Neto',   @BeneficiarioSueldoNeto OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Seguro Riesgo Infonavit',  @SeguroRiesgoInfonavit OUTPUT    
--/* INTELISIS */ spNominaGenerar 100, 1885, '05/26/2008 00:00:00', '06/08/2008 00:00:00', 'Catorcenal', '06/02/2008 00:00:00'
 
 EXEC spPersonalPropValorDMA   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Fecha Inicio Descuento', @FechaInicioDescuentoInfonavit OUTPUT  
  
 EXEC spPersonalPropValor   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Requiere Ajuste Anual', @RequiereAjusteAnual OUTPUT  

--/* INTELISIS */ spNominaGenerar 100, 1885, '05/26/2008 00:00:00', '06/08/2008 00:00:00', 'Catorcenal', '06/02/2008 00:00:00'
  
  EXEC spNominaCalculaDiasMes  @FechaD, @FechaA, @DiasPeriodoMes OUTPUT  
  IF @FechaAntiguedad > @SueldoVariablePTUDesde SELECT @SueldoVariablePTUDesde = @FechaAntiguedad  
  IF @FechaAntiguedad > @SueldoVariableAguinaldoDesde SELECT @SueldoVariableAguinaldoDesde = @FechaAntiguedad  



  IF @PeriodoTipo='CONFIDENCIAL'
    SELECT @PeriodoTipo = 'QUINCENAL' 

  SELECT @Dia = DAY(@FechaA), @Mes = MONTH(@FechaA), @Ano = YEAR(@FechaA)  
  EXEC spIntToDateTime 1, 1, @Ano, @PrimerDiaAno OUTPUT  
  EXEC spIntToDateTime 31, 12, @Ano, @UltimoDiaAno OUTPUT  
  EXEc SPDiasMes @Mes,@Ano,@Dia OUTPUT

  SELECT @Dia = DAY(@FechaA), @Mes = MONTH(@FechaA), @Ano = YEAR(@FechaA)
  EXEc SPDiasMes @Mes,@Ano,@Dia OUTPUT
  EXEC spIntToDateTime @DIA, @MEs, @Ano, @UltimoDiaMes OUTPUT  
  
  SELECT @Dia = DAY(@FechaA), @Mes = MONTH(@FechaA), @Ano = YEAR(@FechaA)  
  
  SELECT @PrimerDiaAnoAnterior = DATEADD(year, -1, @PrimerDiaAno),  
         @UltimoDiaAnoAnterior = DATEADD(year, -1, @UltimoDiaAno)  
  SELECT @PrimerDiaAno1 = @PrimerDiaAno

  IF @OtorgarPrimaVacacionalAguinaldo = 1 
  BEGIN
    IF @FechaAntiguedad < @PrimerDiaAno 
      SELECT  @PrimerDiaAno1  = @PrimerDiaAno
    ELSE
      SELECT  @PrimerDiaAno1  = @FechaAntiguedad
  END ELSE 
    SELECT @PrimerDiaAno1 = case when @FechaAntiguedad > @PrimerDiaAno then @FechaAntiguedad else @PrimerDiaAno END

  IF ISNUMERIC(@DiasAguinaldoSt) = 1  
	  SELECT @DiasAguinaldo = CONVERT(float, @DiasAguinaldoSt), @DiasAguinaldoSiguiente = CONVERT(float, @DiasAguinaldoSt),  @DiasAguinaldoSDI = CONVERT(float, @DiasAguinaldoSt), @DiasAguinaldoSiguienteSDI = CONVERT(float, @DiasAguinaldoSt)

  IF @Mov <> 'Presupuesto'
  BEGIN
  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')  
    SELECT @SueldoMinimo = 0.0  
  ELSE  
  IF @CfgSueldoMinimo = 'OFICIAL'  
    SELECT @SueldoMinimo = @SMDF * @DiasMes * 1.3  
  IF @FechaAlta > @FechaD SELECT @FechaD = @FechaAlta  
  SELECT @DiasNaturales = DATEDIFF(day, @FechaD, @FechaA) + 1  
  SELECT @DiasNaturalesDiferencia = @DiasNaturalesOriginales - @DiasNaturales  
  SELECT @DiasPeriodo = @DiasNaturales  
  END
--spNominaGenerar 450, 10, '14/04/2008 00:00:00', '27/04/2008 00:00:00', 'Catorcenal', '21/04/2008 00:00:00'

  IF @NomTipo = 'NORMAL'  
  BEGIN  
    IF @PersonalDiasPeriodo = 'DIAS PERIODO'  
      SELECT @DiasPeriodo = @DiasPeriodoEstandar - @DiasNaturalesDiferencia  
    ELSE  
    IF @PersonalDiasPeriodo = 'DIAS JORNADA'  
    BEGIN  
      EXEC spJornadaDiasLibres @Jornada, @FechaD, @FechaA, @JornadaDiasLibres OUTPUT  
	    SET @JornadaDiasLibres = 0
      SELECT @DiasPeriodo = dbo.fnMayor(0, @DiasNaturales - @JornadaDiasLibres)  
    END  
  END  
 
  EXEC spFechaAniversario @FechaAntiguedad, @FechaA, @FechaAniversario OUTPUT  

  /* Para que pague la quincena de maximo 15 dias y no de 16 */  
  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION') AND @PeriodoTipo IN ('QUINCENAL', 'MENSUAL','CONFIDENCIAL') 
     AND (SELECT dbo.fnEsFinMes(@FechaA)) = 0  
    SELECT @DiasPeriodo = @DiasNaturales  
  
  SELECT @DiasMes = NULLIF(@DiasMes, 0), @DiasMesTrabajados = NULLIF(@DiasMesTrabajados, 0), @DiasBimestre = NULLIF(@DiasBimestre, 0),  
         @DiasBimestreTrabajados = NULLIF(@DiasBimestreTrabajados, 0), @DiasAno = NULLIF(@DiasAno, 0),  
         @DiasPeriodo = NULLIF(@DiasPeriodo, 0), @DiasTrabajados = NULLIF(@DiasTrabajados, 0), @DiasNaturales = NULLIF(@DiasNaturales, 0),  
         @DiasNaturalesTrabajados = NULLIF(@DiasNaturalesTrabajados, 0), @DiasNaturalesOriginales = NULLIF(@DiasNaturalesOriginales, 0),  
         @DiasNaturalesDiferencia = NULLIF(@DiasNaturalesDiferencia, 0)  
  
  SELECT @Antiguedad = dbo.fnAntiguedad(@FechaAntiguedad, @FechaA)  

  IF @OtorgarPrimaVacacionalAguinaldo = 1
    IF @NomTipo in( 'Normal', 'Prima Vacacional', 'SDI') AND YEAR(@Antiguedad) < YEAR(@FechaA) AND @OtorgarPrimaVacacionalAguinaldo = 1
      SELECT @Antiguedad = YEAR(@UltimoDiaano) - YEAR(@FechaAntiguedad)  

  IF @OtorgarPrimaVacacionalAguinaldo = 1
    IF @NomTipo in( 'Normal', 'Prima Vacacional', 'SDI') AND YEAR(@Antiguedad) = YEAR(@FechaA) AND @OtorgarPrimaVacacionalAguinaldo = 1
      SELECT @Antiguedad = dbo.fnAntiguedad(@FechaAntiguedad, @UltimoDiaAno)  
  
  IF @OtorgarPrimaVacacionalAguinaldo = 1
    IF @NomTipo in( 'Finiquito', 'Liquidacion') AND YEAR(@Antiguedad) < YEAR(@FechaA) AND @OtorgarPrimaVacacionalAguinaldo = 1
      SELECT @Antiguedad = YEAR(@FechaA) - YEAR(@FechaAntiguedad)    
  
  IF @OtorgarPrimaVacacionalAguinaldo = 1
    IF @NomTipo in( 'Finiquito', 'Liquidacion') AND YEAR(@Antiguedad) = YEAR(@FechaA) AND @OtorgarPrimaVacacionalAguinaldo = 1
      SELECT @Antiguedad = dbo.fnAntiguedad(@FechaAntiguedad, @FechaA)  
    
 
  SELECT @AntiguedadSiguiente = dbo.fnAntiguedad(@FechaAntiguedad, @FechaA) + 1  
  SELECT @AntiguedadFlotante = dbo.fnAntiguedad(@FechaAntiguedad, @FechaA)  
  SELECT @AntiguedadDia = DAY(@FechaAntiguedad), @AntiguedadMes = MONTH(@FechaAntiguedad), @FechaDAno = YEAR(@FechaD), @FechaAAno = YEAR(@FechaA)  
  EXEC   spIntToDateTime @AntiguedadDia, @AntiguedadMes, @FechaDAno, @FechaDAntiguedad OUTPUT  
  EXEC   spIntToDateTime @AntiguedadDia, @AntiguedadMes, @FechaAAno, @FechaAAntiguedad OUTPUT  
  EXEC   spTablaNum @CfgTablaVacaciones, @Antiguedad, @DiasVacaciones OUTPUT  
  EXEC   spTablaNum @CfgTablaVacaciones, @AntiguedadSiguiente, @DiasVacacionesSiguiente OUTPUT  
  IF @Antiguedad > 0 AND (@FechaDAntiguedad BETWEEN @FechaD AND @FechaA OR @FechaAAntiguedad BETWEEN @FechaD AND @FechaA)  
    SELECT @EsAniversario = 1  
    
  IF ISNULL(@DiasPeriodo, 0) = 0  SELECT @DiasNaturales = 0, @DiasPeriodo = 0  
  
  IF ISNUMERIC(@DiasAguinaldoSt) = 0  
  BEGIN  
    EXEC spTablaNum @DiasAguinaldoSt, @Antiguedad, @DiasAguinaldo OUTPUT  
    EXEC spTablaNum @DiasAguinaldoSt, @AntiguedadSiguiente, @DiasAguinaldoSiguiente OUTPUT  
  END  
  
  SELECT @IndemnizacionTope = @SMZ * 90 * ROUND(@AntiguedadFlotante, 0)  
  SELECT @PrimaVacacional = @SueldoDiario * @DiasVacaciones * (@PrimaVacacionalPct/100.0)  
  
  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')  
  BEGIN  
    IF @OtorgarPrimaVacacionalAguinaldo = 0
    BEGIN 
      SELECT @DiasVacacionesProporcion = @DiasVacacionesSiguiente * dbo.fnAntiguedadFloat(@FechaAniversario, @FechaA)  
      SELECT @PrimaVacacionalProporcion = @SueldoDiario * @DiasVacacionesProporcion * (@PrimaVacacionalPct/100.0)  
    END 
    IF @OtorgarPrimaVacacionalAguinaldo = 1
    BEGIN
      SELECT @DiasVacacionesProporcion = @DiasVacaciones/*Siguiente*/ * dbo.fnAntiguedadFloat(@PrimerDiaAno1, @FechaA)  
      SELECT @PrimaVacacionalProporcion = @SueldoDiario * @DiasVacacionesProporcion * (@PrimaVacacionalPct/100.0)  
    END
    
  END  
 
  -- Aguinaldo  
  IF @NomTipo = 'AGUINALDO'  
  BEGIN
    IF @PUESTO IN('Vendedor(a)','Vendedor Viajero')
    BEGIN
      SELECT @SueldoVariableDias = DATEDIFF(day, @SueldoVariableAguinaldoDesde, @SueldoVariableAguinaldoHasta) + 1  
      EXEC spNominaSueldoVariableAcumuladoFechas @Empresa, @Personal, @SueldoVariableAguinaldoDesde, @SueldoVariableAguinaldoHasta, @SueldoVariableAcumulado OUTPUT  
    END ELSE
      SELECT @SueldoVariableDias = 0

    IF @FechaAntiguedad < @PrimerDiaAno1    
      SELECT @DiasAguinaldoProporcion = DATEDIFF(DAY,@PrimerDiaAno1,@UltimoDiaAno) + 1
    ELSE
	    SELECT @DiasAguinaldoProporcion = DATEDIFF(DAY, @FechaAntiguedad,@UltimoDiaAno) + 1

    SELECT @DiasAguinaldoProporcion = ISNULL((@DiasAguinaldoProporcion / @DiasAno) * (@DiasAguinaldo - ISNULL(@FaltasAcumulado,0)),0)
    SELECT @SueldoVariablePromedio = @SueldoVariableAcumulado / NULLIF(@SueldoVariableDias, 0)  
    SELECT @Aguinaldo = ((@SueldoDiario) + ISNULL(@SueldoVariablePromedio, 0.0)) * @DiasAguinaldoProporcion

-- Aqui se configura el importe del Aguinaldo complemento por el importe de los Premios de puntualidad y Asistencia
 SELECT @AguinaldoPuntyAsis = ((@SueldoDiario*.20) + ISNULL(@SueldoVariablePromedio, 0.0)) * @DiasAguinaldoProporcion



    SELECT @AguinaldoImporte = @Aguinaldo
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Aguinaldo', @Empresa, @Personal, @DiasAguinaldoProporcion, @Aguinaldo  
 EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'AguinaldoComplemento', @Empresa, @Personal, @DiasAguinaldoProporcion, @AguinaldoPuntyAsis


  END ELSE  
    IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION') AND @FechaA >= @PrimerDiaAno  
    BEGIN  
      EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Aguinaldo', @PrimerDiaAno, @FechaA, NULL, @AguinaldoAcumulado OUTPUT, NULL  
      SELECT @DiasAguinaldoProporcion = @DiasAguinaldoSiguiente * dbo.fnAntiguedadFloat(@PrimerDiaAno1, @FechaA)  
      SELECT @Aguinaldo = (@SueldoDiario * @DiasAguinaldoProporcion) - @AguinaldoAcumulado  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Aguinaldo', @Empresa, @Personal, @DiasAguinaldoProporcion, @Aguinaldo  
    END  
  -- PTU  
  IF @NomTipo = 'PTU'  
  BEGIN  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'DiasTrabajados', @RepartirDesde, @RepartirHasta, NULL, @DiasTrabajadosImporte OUTPUT, @DiasTrabajados OUTPUT  
    IF @DiasTrabajados>=60  
    BEGIN  
      SELECT @PTUIngresosTopados = dbo.fnMenor(@DiasTrabajadosImporte, @RepartirIngresoTope) * @RepartirIngresoFactor  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PTU/IngresosTopados', @Empresa, @Personal, @DiasTrabajados, @PTUIngresosTopados  
  
      SELECT @PTUDiasTrabajados = @DiasTrabajados * @RepartirDiasFactor  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PTU/DiasTrabajados', @Empresa, @Personal, @DiasTrabajados, @PTUDiasTrabajados  
  
      SELECT @CalcImporte = @PTUIngresosTopados + @PTUDiasTrabajados  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PTU', @Empresa, @Personal, @DiasTrabajados, @CalcImporte  
    END  
  END  
  IF @NomTipo = 'PRESTAMO FONDO AHORR'
  BEGIN
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro',                 @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroAcumulado OUTPUT, @FondoAhorroAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro/Patron',          @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroPatronAcumulado OUTPUT, @FondoAhorroPatronAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro/Anticipo',        @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroAnticipoAcumulado OUTPUT, @FondoAhorroAnticipoAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro/Prestamo',        @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroPrestamoAcumulado OUTPUT, @FondoAhorroAnticipoAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro/Ausentismo',      @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroAusentismoAcumulado OUTPUT,  NULL
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 'FondoAhorro/AusentismoHoras', @PrestamoFondoAhorroDesde, @PrestamoFondoAhorroHasta, NULL, @FondoAhorroAusentismoHorasAcumulado OUTPUT, NULL
    
-- select * from cfgnominaconcepto  where nominaconcepto in ('208')
    SELECT @FondoAhorroAcumulado = ISNULL(@FondoAhorroAcumulado,0) + ISNULL(@FondoAhorroPatronAcumulado,0) - (ISNULL(@FondoAhorroAnticipoAcumulado,0) + ISNULL(@FondoAhorroPrestamoAcumulado,0)- ISNULL(@FondoAhorroAusentismoAcumulado,0)*2.0 - ISNULL(@FondoAhorroAusentismoHorasAcumulado,0)*2.0)
    
    IF ISNULL(@FondoAhorroAnticipoPct,0.0) > 0.0
    BEGIN
      SELECT @FondoAhorro = @FondoAhorroAcumulado * @FondoAhorroAnticipoPct / 100.0
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Prestamo', @Empresa, @Personal,@FondoAhorroAcumuladoDias, @FondoAhorro  
    END
    
  END
  -- LIQUIDACION FONDO AHORRO   o LIQUIDACION
  IF @NomTipo in( 'LIQUIDACION FONDO AHORRO')  OR ((@NomTipo IN('FINIQUITO')) AND (@FondoAhorroEnFiniquito = 'S'))
  BEGIN  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 	'DiasTrabajados',       @RepartirDesde,    @RepartirHasta,    NULL, @DiasTrabajadosImporte OUTPUT, @DiasTrabajados OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 	'FondoAhorro',          @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroAcumulado OUTPUT, @FondoAhorroAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 	'FondoAhorro/Anticipo', @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroAnticipoAcumulado OUTPUT, @FondoAhorroAnticipoAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal,  'FondoAhorro/Prestamo',  @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroPrestamoAcumulado OUTPUT, @FondoAhorroAnticipoAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal, 	'FondoAhorro/Patron',   @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroPatronAcumulado OUTPUT, @FondoAhorroPatronAcumuladoDias OUTPUT  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal,  'FondoAhorro/Ausentismo',      @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroAusentismoAcumulado OUTPUT,  NULL
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, 	@Personal,  'FondoAhorro/AusentismoHoras', @FondoAhorroDesde, @FondoAhorroHasta, NULL, @FondoAhorroAusentismoHorasAcumulado OUTPUT, NULL
    SELECT @FondoAhorroPatronAcumulado = @FondoAhorroPatronAcumulado  + ISNULL(@FondoAhorroAusentismoHorasAcumulado, 0) + ISNULL(@FondoAhorroAusentismoAcumulado, 0)
    SELECT @FondoAhorroAcumulado       = @FondoAhorroAcumulado        + ISNULL(@FondoAhorroAusentismoHorasAcumulado, 0) + ISNULL(@FondoAhorroAusentismoAcumulado, 0)
    EXEC spNominaAgregarClaveInterna 			@Ok OUTPUT, @OkRef OUTPUT,'FondoAhorro/Liquidacion',         @Empresa, @Personal, @FondoAhorroAcumuladoDias, @FondoAhorroAcumulado  
    EXEC spNominaAgregarClaveInterna 			@Ok OUTPUT, @OkRef OUTPUT,'FondoAhorro/Liquidacion/Patron',  @Empresa, @Personal, @FondoAhorroPatronAcumuladoDias, @FondoAhorroPatronAcumulado  
    
    SELECT @FondoAhorroAnticipoAcumulado =  (isnull(@FondoAhorroAnticipoAcumulado,0) + isnull(@FondoAhorroPrestamoAcumulado,0)) 
    
    IF ISNULL(@FondoAhorroAnticipoPct,0.0) > 0.0
       EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Liquidacion/Anticipo',@Empresa, @Personal, @FondoAhorroPatronAcumuladoDias, @FondoAhorroAnticipoAcumulado  
  
    SELECT @FondoAhorroIngresosTopados = dbo.fnMenor(@DiasTrabajadosImporte, @RepartirIngresoTope) * @RepartirIngresoFactor  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/IngresosTopados',     @Empresa, @Personal, @DiasTrabajados, @FondoAhorroIngresosTopados  
   
    SELECT @FondoAhorroDiasTrabajados = @DiasTrabajados * @RepartirDiasFactor  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/DiasTrabajados',      @Empresa, @Personal, @DiasTrabajados, @FondoAhorroDiasTrabajados  
  
    -- EXEC spCalculaAnticipoFondoAhorro @Empresa, @Personal, @FondoAhorro OUTPUT  

	--  IF ISNULL(@FondoAhorro,0.0)> 0.0
	--	  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Anticipo', @Empresa, @Personal,@FondoAhorroAcumuladoDias, @FondoAhorro  
  
    SELECT @CalcImporte = @FondoAhorroIngresosTopados + @FondoAhorroDiasTrabajados  
	
	  IF ISNULL(@CalcImporte,0.0)> 0.0
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'FondoAhorro/Liquidacion/Interes', @Empresa, @Personal, @DiasTrabajados, @CalcImporte  
  END  
    
  SELECT @SueldoMensual = @SueldoDiario * @DiasMes  
  SELECT @PrimerDiaMes = DATEADD(day, 1-DAY(@FechaA), @FechaA)
  if @NomTipo IN('FINIQUITO', 'liquidacion')  
    SELECT @PrimerDiaMes = DATEADD(day, 1-DAY(@FechaOrigen), @FechaOrigen)  

  SELECT @PrimerDiaMesAnterior = DATEADD(month, -1, @PrimerDiaMes)  
  SELECT @UltimoDiaMesAnterior = DATEADD(day, -1, @PrimerDiaMes)  
  SELECT @ISRVencimiento = DATEADD(day, 16, DATEADD(month, 1, @PrimerDiaMes))  
  SELECT @IMSSVencimiento = @ISRVencimiento, 
         @IMSSVencimientoBimestre = @ISRVencimiento, 
         @ImpuestoEstatalVencimiento = @ISRVencimiento  
  IF MONTH(@FechaA) % 2 <> 0 SELECT @IMSSVencimientoBimestre = DATEADD(month, 1, @IMSSVencimientoBimestre)  
 
  
  IF MONTH(@FechaA) <> MONTH(DATEADD(day, @DiasNaturalesOriginales, @FechaA))  
  BEGIN  
    IF MONTH(@FechaA)= 2 AND DAY(@FechaA) = 15 AND @PeriodoTipo = 'Quincenal' 
      SELECT @EsFinMes = 0   
    ELSE 
      SELECT @EsFinMes = 1    
  END  
  IF @Mov ='PRESUPUESTO'   SELECT   @EsFinMes = 1    
  IF (MONTH(@PrimerDiaMes) % 2) = 0  
    SELECT  @PrimerDiaBimestre = DATEADD(month, -1, @PrimerDiaMes) 
  ELSE
    SELECT  @PrimerDiaBimestre =  @PrimerDiaMes 

  IF @EsFinMes = 1
  BEGIN 
    IF MONTH(@FechaA) % 2 = 0 
      SELECT @EsBimestre = 1, @PrimerDiaBimestre = DATEADD(month, -1, @PrimerDiaMes)  
    SELECT @PrimerDiaBimestre = Convert(DateTime, dbo.fnMayor(Convert(FLOAT,@PrimerDiaBimestre), Convert(FLOAT,@FechaAntiguedad)))  
    IF MONTH(@FechaA) % 2 = 0 SELECT @EsBimestre = 1
  END
  
  IF DAY(@FechaA) = 15 AND @PeriodoTipo = 'Quincenal' SELECT @EsFinMes = 0

  IF  @PeriodoTipo = 'CATORCENAL'
  BEGIN
    IF MONTH(@FechaA) <> MONTH(DATEADD(DAY,-3,DATEADD(day, @DiasNaturalesOriginales, @FechaA)))
      SELECT @EsFinMes = 1  
    ELSE  
      SELECT @EsFinMes = 0    
  END    

  IF @CfgAjusteMensualISR = 0   
    SELECT @EsFinMes = 0 
  
--  SELECT @DiasBimestre = DATEDIFF(day, @PrimerDiaBimestre, @FechaA) + 1
--    IF @PrimerDiaMes BETWEEN @FechaD AND @FechaA SELECT @EsInicioMes = 1
  
  SELECT @DiasBimestre = ISNULL(dbo.fnDiasBimestre(@FechaA),1)
  
  IF MONTH(@FechaA) % 2 = 0 
    SELECT @EsBimestre = 1
    
  
   SELECT @EsFinMes = 0
--SDI INICIO
  
  IF @NomTipo in ('Finiquito', 'Liquidacion') 
     SELECT @EsFinMes = 1
  IF @Mov ='PRESUPUESTO'      SELECT   @EsFinMes = 1

-- IMPUESTO ESTATAL INICIO

  IF @NomTipo='IMPUESTO ESTATAL'
  BEGIN
	  EXEC spNominaMexicoImpuestoEstatal @Empresa,@SucursalTrabajo,@Personal,@NomTipo, @DiasNaturales   ,@SMZ,@PrimerDiaBimestre, @PrimerDiaMes,
         @SucursalTrabajoEstado,@ImpuestoEstatalExento,@ImpuestoEstatalBase,@ImpuestoEstatal,@PersonalPercepciones,@FechaA,@FechaD,@ImpuestoEstatalPct,
         @ImpuestoEstatalGastoOperacionPct,@AcreedorImpuestoEstatal,@ImpuestoEstatalVencimiento,@CalcImporte,@Estacion,@ID,@Ok OUTPUT,@OkRef OUTPUT
	END

  IF @NomTipo='LIQUIDACION FONDO AHORRO'
  BEGIN  
    INSERT #Nomina (  
             Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
    SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
      FROM IncidenciaD d  
      JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
     WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL 

    INSERT #Nomina (  
            Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
    SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
      FROM IncidenciaD d  
      JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento <> 'Percepcion'  
     WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL 
  END
-- FIN IMPUESTO ESTATAL
-- SUELDO COMPLEMETARIO

  IF @NomTipo='SUELDO COMPLEMENTO'
  BEGIN
 IF (SELECT isnull(SueldoDiarioComplemento,0.0) FROM Personal WHERE Personal = @Personal) >1
 BEGIN
    SELECT @DiasNaturalesTrabajados = dbo.fnMayor(0, @DiasPeriodo - @Faltas )  
    SELECT @DiasTrabajados = @DiasPeriodo - @Faltas  
  	EXEC  spNominaSueldoComplemento @Empresa, @Personal, @NomTipo, @DiasNaturalesTrabajados, @DiasVacaciones, @EsAniversario, @Faltas, @Antiguedad,
  	      @OtorgarPrimaVacacionalAniversario, @OtorgarDiasVacacionesAniversario, @TipoCambio, @RedondeoMonetarios, 
  	      @FechaA, @FechaD,  @SueldoDiarioComplemento,@Mov, @Ok, @OkRef 
	END
 ELSE
 BEGIN
   EXEC spNominaSueldoComplementoIncidencia @Empresa ,@Personal,@NomTipo ,@TipoCambio,@RedondeoMonetarios ,@FechaA  ,@FechaD  ,@Ok      OUTPUT,@OkRef     OUTPUT
 END

 END
-- FIN SUELDO COMPLEMENTARIO
-- AGUINALDO COMPLEMETARIO
-- SELECT '@NomTipo'=@NomTipo

  IF @NomTipo='AGUINALDOCOMPLEMENTO'
	BEGIN
    IF @FechaAntiguedad < @PrimerDiaAno    
	    SELECT @DiasAguinaldoProporcion = DATEDIFF(DAY,@PrimerDiaAno,@UltimoDiaAno) +1
    ELSE
	    SELECT @DiasAguinaldoProporcion = DATEDIFF(DAY, @FechaAntiguedad,@UltimoDiaAno)+1
    SELECT @DiasAguinaldoProporcion = isnull((ISNULL(@DiasAguinaldoProporcion,365) / 365.0) * (@DiasAguinaldo-ISNULL(@FaltasAcumulado,0)),0)
    --SELECT @SueldoDiarioComplemento = ISNULL(SueldoDiarioComplemento,0.0) FROM Personal WHERE Personal.Personal = @Personal
    SELECT @Aguinaldo = (@SueldoDiarioComplemento * @DiasAguinaldoProporcion) * 1.0
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Aguinaldo/Complemento', @Empresa, @Personal, @DiasAguinaldoProporcion, @Aguinaldo  
    EXEC spNominaAguinaldoComplementoIncidencia @Empresa ,@Personal,@NomTipo ,@TipoCambio,@RedondeoMonetarios ,@FechaA  ,@FechaD  ,@Ok      OUTPUT,@OkRef     OUTPUT                      
                
  END
-- FIN SUELDO COMPLEMENTARIO

  EXEC spNominaCalcMexicoTipo @Empresa OUTPUT, @TipoCambio OUTPUT, @Personal OUTPUT, @FechaD OUTPUT, @FechaA OUTPUT, @CfgPrimaDominicalAuto OUTPUT, @NomTipo OUTPUT, @NomCalcSDI OUTPUT,
                              @CfgSubsidioIncapacidadEG OUTPUT, @CfgFactorintegracionAntiguedad OUTPUT, @CfgFactorintegracionTabla OUTPUT, @IncidenciaD OUTPUT, @IncidenciaA OUTPUT,
                              @RedondeoMonetarios OUTPUT, @Calc OUTPUT, @CalcImporte OUTPUT, @DescansaDomingos OUTPUT, @LaboraDomingos OUTPUT, @EsBimestre OUTPUT, @PrimerDiaMes OUTPUT,
                              @PrimerDiaBimestre OUTPUT, @PersonalEstatus OUTPUT, @SucursalTrabajo OUTPUT, @Categoria OUTPUT, @Puesto OUTPUT, @Cliente OUTPUT, @Jornada OUTPUT,
                              @SMZ OUTPUT, @SMDF OUTPUT, @PrimerDiaAno1 OUTPUT, @UltimoDiaAno OUTPUT,@FechaAlta OUTPUT, @FechaAntiguedad OUTPUT, @EsSocio OUTPUT, @SDI OUTPUT,
                              @SDINuevo OUTPUT, @SueldoPeriodo OUTPUT, @SueldoDiario OUTPUT, @DiasMes OUTPUT, @DiasMesTrabajados OUTPUT, @DiasBimestre OUTPUT,
                              @DiasBimestreTrabajados OUTPUT, @DiasAno OUTPUT, @DiasPeriodo OUTPUT, @DiasPeriodoSubsidio OUTPUT, @DiasHabilesPeriodo OUTPUT, @DiasPeriodoEstandar OUTPUT,
                              @DiasTrabajados OUTPUT, @DiasTrabajadosImporte OUTPUT, @DiasNaturales OUTPUT, @FactorAusentismo OUTPUT, @DiasNaturalesTrabajados OUTPUT,
                              @DomingosLaborados OUTPUT, @Faltas OUTPUT, @FaltasAcumulado OUTPUT, @FaltasImporte OUTPUT, @Incapacidades OUTPUT, @IncapacidadesAcumulado OUTPUT,
                              @IncapacidadesImporte OUTPUT, @ISRLiquidacionGravable OUTPUT, @SubsidoSueldoMensual OUTPUT, @IMSSBase OUTPUT, @IMSSBaseAcumulado OUTPUT, @IMSSBaseMes OUTPUT,
                              @IMSSObrero OUTPUT, @IMSSObreroCV OUTPUT, @IMSSObreroSinCV OUTPUT, @IMSSPatron OUTPUT, @IMSSPatronMensual OUTPUT, @IMSSPatronCV OUTPUT,
                              @IMSSPatronRetiro OUTPUT, @IMSSPatronInfonavit OUTPUT, @Antiguedad OUTPUT, @PrimaDominicalPct OUTPUT, @PrimaDominical OUTPUT, @PrimaVacacionalPct OUTPUT,
                              @Vacaciones OUTPUT, @VacacionesTomadas OUTPUT, @PrimaVacacional OUTPUT, @PrimaVacacionalProporcion OUTPUT, @DiasVacaciones OUTPUT,
                              @DiasVacacionesProporcion OUTPUT, @DiasVacacionesSiguiente OUTPUT, @DiasVacacionesAcumulado OUTPUT, @Factorintegracion OUTPUT, @CajaAhorro OUTPUT,
                              @CajaAhorroDesde OUTPUT, @CajaAhorroHasta OUTPUT, @FondoAhorroFactorAusentismo OUTPUT, @ValesDespensaFactorAusentismo OUTPUT,
                              @AyudaFamiliarFactorAusentismo OUTPUT, @FondoAhorroPct OUTPUT, @FondoAhorro OUTPUT, @FondoAhorro1 OUTPUT, @FondoAhorroAnticipoPct OUTPUT,
                              @FondoAhorroDesde OUTPUT, @FondoAhorroHasta OUTPUT, @EsAniversario OUTPUT, @OtorgarDiasVacacionesAniversario OUTPUT,
                              @OtorgarPrimaVacacionalAniversario OUTPUT, @OtorgarPrimaVacacionalAguinaldo OUTPUT, @TieneValesDespensa OUTPUT, @ValesDespensaPct OUTPUT,
                              @ValesDespensaImporte OUTPUT, @ValesDespensa OUTPUT, @PremioPuntualidadPct OUTPUT, @AyudaTransportePct OUTPUT, @PremioAsistenciaPct OUTPUT,
                              @SueldoVariable OUTPUT, @SubsidioProporcionalFalta OUTPUT, @Contrato OUTPUT, @MaxID OUTPUT, @MaxRID OUTPUT, @IncapacidadesD OUTPUT, @CuotaSindical OUTPUT,
                              @Mov OUTPUT, @SDIAnterior OUTPUT, @SDIVariableDiario OUTPUT, @SDIBruto OUTPUT, @FhiAntiguedad OUTPUT, @AntiguedadSDI OUTPUT, @DiasAguinaldoSDI OUTPUT,
                              @DiasAguinaldoSiguienteSDI OUTPUT, @AyudaFamiliar OUTPUT, @TopeFondoAhorro OUTPUT, @FondoAhorroTipoContrato OUTPUT, @Plaza OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @NomTipo = 'FINIQUITO' AND @AntiguedadFlotante >= 15.0  
  BEGIN  
    SELECT @PrimaAntiguedad = dbo.fnMenor(@SueldoDiario, @SMZ * 2.0) * 12.0 * @AntiguedadFlotante  
 --EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaAntiguedad/15Anos', @Empresa, @Personal, @AntiguedadFlotante, @PrimaAntiguedad  
  END  
   
  IF @NomTipo = 'LIQUIDACION'  
  BEGIN   
    SELECT @Indemnizacion3Meses = @SDI * 90  
    IF @IndemnizacionPct = 100.0  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion/3Meses', @Empresa, @Personal, 90, @Indemnizacion3Meses  
    SELECT @Indemnizacion20Dias = @SDI * 20 * @AntiguedadFlotante  
      
    IF @IndemnizacionPct = 100.0  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion/20Dias', @Empresa, @Personal, @AntiguedadFlotante, @Indemnizacion20Dias  
    SELECT @PrimaAntiguedad = dbo.fnMenor(@SueldoDiario, @SMZ * 2.0) * 12.0 * @AntiguedadFlotante  
      
    IF @IndemnizacionPct = 100.0  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PrimaAntiguedad', @Empresa, @Personal, @AntiguedadFlotante, @PrimaAntiguedad  
    SELECT @Indemnizacion = (@Indemnizacion3Meses + @Indemnizacion20Dias + @PrimaAntiguedad) * (@IndemnizacionPct/100.0)  
  
    IF @IndemnizacionPct <> 100.0  
      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion', @Empresa, @Personal, @AntiguedadFlotante, @Indemnizacion  
  END  


  
  
  DELETE #Nomina    
      FROM #Nomina n    
      JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto    
     WHERE nc.NominaConcepto NOT IN(SELECT MovEspecificoNomina.NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina.MovEspecificoNomina = @Mov)    
       AND n.Personal = @Personal   and exists(select * from MovEspecificoNomina where MovEspecificoNomina.nominaconcepto= n.NominaConcepto)
  IF @MOV  = 'PRESUPUESTO'
    UPDATE #NOMINA SET REFERENCIA =@PLAZA WHERE NULLIF(referencia,'') IS NULL and personal=@Personal                        

  EXEC spNominaCalcMexicoNomina @Empresa OUTPUT, @Sucursal OUTPUT, @ID OUTPUT, @Moneda OUTPUT, @TipoCambio OUTPUT, @Personal OUTPUT, @FechaD OUTPUT, @FechaA OUTPUT, @PeriodoTipo OUTPUT,
                                @CfgAjusteMensualISR OUTPUT, @CfgISRReglamentoAguinaldo OUTPUT, @CfgISRReglamentoPTU OUTPUT, @NomTipo OUTPUT, @EsFinMes OUTPUT, @PrimerDiaMes OUTPUT,
                                @PrimerDiaMesAnterior OUTPUT, @UltimoDiaMesAnterior OUTPUT, @UltimoDiaMes OUTPUT, @SucursalTrabajoEstado OUTPUT, @SMZ OUTPUT, @SMZTopeHorasDobles OUTPUT,
                                @SDI OUTPUT, @SueldoMensual OUTPUT, @SueldoMensualReglamento OUTPUT, @DiasMes OUTPUT, @DiasAno OUTPUT, @DiasPeriodo OUTPUT, @DiasPeriodoSubsidio OUTPUT,
                                @ISR OUTPUT, @ISRAcumulado OUTPUT, @ISRBruto OUTPUT, @ISRVencimiento OUTPUT, @ISRCreditoAlSalarioTabla OUTPUT, @ISRSubsidioAlEmpleoTabla OUTPUT,
                                @ISRSubsidioAlEmpleoAcumulado OUTPUT, @ISRBase OUTPUT, @ISRBaseMes OUTPUT, @ISRBaseAcumulado OUTPUT, @ISRReglamentoBase OUTPUT, @ISRReglamentoFactor OUTPUT,
                                @ISRSueldoMensual OUTPUT, @ISRSueldoMensualReglamento OUTPUT, @IMSSBase OUTPUT, @ImpuestoEstatalBase OUTPUT, @CedularBase OUTPUT, @AcreedorISR OUTPUT,
                                @Antiguedad OUTPUT, @PercepcionBruta OUTPUT, @IndemnizacionTope OUTPUT, @Mov OUTPUT, @NuevoImporteISR OUTPUT, @NuevoImporteCAS OUTPUT,
                                @DiasPeriodoMes OUTPUT, @DiasTrabajadosSubsidioAcumulado OUTPUT, @DiasTrabajadosImporteSubsidio OUTPUT, @EsISRReglamento OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @NomTipo = 'NORMAL'   
  BEGIN  
    SELECT @ISRAjuste = 0.0  
    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/AjusteAnual', @FechaAlta, @FechaA, NULL, @ISRAjusteAnual OUTPUT, NULL   
    IF @ISRAjusteAnual < 0.0 AND @ISR > 0.0   SELECT @ISRAjuste = dbo.fnMenor(ABS(@ISRAjusteAnual), @ISR)  
    IF @ISRAjusteAnual > 0.0  
    BEGIN  
      EXEC spPersonalPropValorMONEY @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '$ Descuento quincenal por ISR Ajuste anual',   @ISRAjusteMax OUTPUT  
      SELECT @ISRAjuste = dbo.fnMenor(@ISRAjusteAnual, @ISRAjusteMax) * -1.0  
    END  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/AjusteAnual', @Empresa, @Personal, @Importe = @ISRAjuste  
    SELECT @CalcImporte =0-- -@ISRAjuste tenemos que adecuar esto porque lo ise para que en bayon jo salga el ajuste anual********************* abanos 
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Ajuste', @Empresa, @Personal, @Importe = @CalcImporte,@Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento, @Mov='CXP'  
  END  
   
  IF @NomTipo = 'LIQUIDACION'  
  BEGIN  
    IF @CfgISRLiquidacionSueldoMensual = 'SUELDO MENSUAL'  
      SELECT @ISRLiquidacionBase = @SueldoMensual  
    ELSE  
	      EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/Base', @PrimerDiaMesAnterior, @UltimoDiaMesAnterior, NULL, @ISRLiquidacionBase OUTPUT, NULL  

--spNominaGenerar 104, 1237, '04/14/2008 00:00:00', '04/27/2008 00:00:00', 'Catorcenal', '04/08/2008 00:00:00'
    EXEC spNominaISRSubsidioAlEmpleoProporcional	30.4,	30.4, 30.4 ,@ISRLiquidacionBase, @ISRLiquidacion OUTPUT,	NULL,	NULL  
    SELECT  @ISRLiquidacion= dbo.fnMayor(0,@ISRLiquidacion)
--spNominaGenerar 450, 1092, '03/31/2008 00:00:00', '04/13/2008 00:00:00', 'Catorcenal', '04/02/2008 00:00:00'

    SELECT @ISRLiquidacionFactor = @ISRLiquidacion / @ISRLiquidacionBase  
    EXEC spNominaTope @Indemnizacion, @IndemnizacionTope, @ISRLiquidacionExcento OUTPUT, @ISRLiquidacionGravable OUTPUT  
    SELECT @ISRLiquidacion = @ISRLiquidacionGravable * @ISRLiquidacionFactor  

-- select @ISRLiquidacionFactor,@ISRLiquidacion , @ISRLiquidacionBase,@ISRLiquidacionGravable
    IF @ISRLiquidacion<0  
      SELECT @ISRLiquidacion=0  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Liquidacion', @Empresa, @Personal, @Importe = @ISRLiquidacion, @Cuenta = @AcreedorISR, @Vencimiento = @ISRVencimiento  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion/Exento', @Empresa, @Personal, @Importe = @ISRLiquidacionExcento  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion/Gravable', @Empresa, @Personal, @Importe = @ISRLiquidacionGravable  
  END  
  -- select * from cfgnominaconcepto where claveinterna='ISR/Liquidacion'
  -- select * from nominaconcepto where nominaconcepto='204'


 EXEC spNominaCalcMexicoIMSSInfonavit @Empresa OUTPUT, @Personal OUTPUT, @FechaD OUTPUT, @FechaA OUTPUT, @PeriodoTipo OUTPUT, @CfgFactorIntegracionAntiguedad OUTPUT,
                                      @CfgFactorIntegracionTabla OUTPUT, @NomTipo OUTPUT, @NomCalcSDI OUTPUT, @CalcImporte OUTPUT, @EsBimestre OUTPUT, @PrimerDiaBimestre OUTPUT,
                                      @PrimerDiaBimestreAnterior OUTPUT, @UltimoDiaBimestreAnterior OUTPUT, @SucursalTrabajo OUTPUT, @Categoria OUTPUT, @Puesto OUTPUT, @SMZ OUTPUT,
                                      @SMZPrimaAntiguedad OUTPUT, @SMDF OUTPUT, @PrimerDiaAnoAnterior OUTPUT, @EsSocio OUTPUT, @SDI OUTPUT, @SDINuevo OUTPUT, @SueldoDiario OUTPUT,
                                      @DiasBimestre OUTPUT, @DiasBimestreTrabajados OUTPUT, @DiasAno OUTPUT, @DiasAguinaldo OUTPUT, @DiasAguinaldoSiguiente OUTPUT,@DiasPeriodo OUTPUT,
                                      @DiasTrabajados OUTPUT, @DiasNaturales OUTPUT, @DiasNaturalesTrabajados OUTPUT, @DiasPrimaAntiguedad OUTPUT, @Faltas OUTPUT, @FaltasAcumulado OUTPUT,
                                      @Incapacidades OUTPUT, @IncapacidadesAcumulado OUTPUT, @IMSSBase OUTPUT, @IMSSBaseAcumulado OUTPUT, @IMSSBaseMes OUTPUT, @AcreedorIMSS OUTPUT,
                                      @AcreedorRetiro OUTPUT, @AcreedorInfonavit OUTPUT, @IMSSVencimiento OUTPUT, @IMSSVencimientoBimestre OUTPUT, @IMSSObrero OUTPUT, @IMSSObreroCV OUTPUT,
                                      @IMSSObreroSinCV OUTPUT, @IMSSPatron OUTPUT, @IMSSPatronMensual OUTPUT, @IMSSPatronCV OUTPUT, @IMSSPatronRetiro OUTPUT, @IMSSPatronInfonavit OUTPUT,
                                      @Antiguedad OUTPUT, @PrimaVacacionalPct OUTPUT, @PrimaVacacional OUTPUT, @DiasVacaciones OUTPUT, @DiasVacacionesSiguiente OUTPUT,
                                      @FactorIntegracion OUTPUT, @InfonavitObrero OUTPUT, @AcumuladoInfonavitObrero OUTPUT, @InfonavitSDI OUTPUT, @InfonavitSMGDF OUTPUT,
                                      @InfonavitImporte OUTPUT, @SeguroRiesgoInfonavit OUTPUT, @PersonalPercepciones OUTPUT, @Mov OUTPUT, @DiasMesInfonavit OUTPUT, @MesI OUTPUT,
                                      @YearI OUTPUT, @InfonavitDias OUTPUT, @DiasBimestreInfonavit OUTPUT, @FechaInicioDescuentoInfonavit OUTPUT, @DiasNaturalesInfonavit OUTPUT,
                                      @Ok OUTPUT, @OkRef OUTPUT

--  IF @NomTipo = 'AJUSTE ANUAL' AND @RequiereAjusteAnual = 1
--  BEGIN  
--    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/Base', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRBaseAcumulado OUTPUT, NULL  
--    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRAcumulado OUTPUT, NULL  
--    --EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/CreditoAlSalario', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRCreditoAlSalarioAcumulado OUTPUT, NULL  
--    EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/SubsidoAlEmpleo', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRSubsidioAlEmpleoAcumulado OUTPUT, NULL  
--    EXEC spNominaISRAnual @ISRBaseAcumulado, @ISRSubsidioPct, @ISRAnual OUTPUT  
--    -- SELECT @ISRAjusteAnual = @ISRAnual - @ISRAcumulado + @ISRCreditoAlSalarioAcumulado  
--    SELECT @ISRAjusteAnual = @ISRAnual - @ISRAcumulado + @ISRSubsidioAlEmpleoAcumulado  
--    IF @ISRAjusteAnual < 0.0  
--    BEGIN  
--      --SELECT @ISRAjusteAnual = @ISRAjusteAnual + @ISRCreditoAlSalarioAcumulado  
--      SELECT @ISRAjusteAnual = @ISRAjusteAnual + @ISRSubsidioAlEmpleoAcumulado  
--      IF @ISRAjusteAnual > 0.0 SELECT @ISRAjusteAnual = 0.0  
--    END  
--    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/BaseAcumAnual',   @Empresa, @Personal, @Importe = @ISRBaseAcumulado  
--    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/AcumAnual',   @Empresa, @Personal, @Importe = @ISRAcumulado  
--    --EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/CreditoAlSalarioAcumAnual',@Empresa, @Personal, @Importe = @ISRCreditoAlSalarioAcumulado  
--    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleoAcumAnual',@Empresa, @Personal, @Importe = @ISRSubsidioAlEmpleoAcumulado  
--    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Anual',           @Empresa, @Personal, @Importe = @ISRAnual  
--    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/AjusteAnual',   @Empresa, @Personal, @Importe = @ISRAjusteAnual  
IF @NomTipo = 'AJUSTE ANUAL'

 BEGIN

  SELECT @PersonalPercepciones = 0.0,@CalcularAjusteAnual=0
  EXEC spPersonalPropValor  @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Requiere Ajuste Anual', @RequiereAjuste OUTPUT
  EXEC spPersonalPropValor  @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Sueldo Maximo para Ajuste de ISR', @SueldoMaxAjuste OUTPUT
        SELECT @RequiereAjuste = 'S', @SueldoMaxAjuste = 400000
  SELECT @AjusteD =dateadd(day,1,dbo.fnUltimoDiaAno(dateadd(year,-2,@FechaA))),@AjusteA=dbo.fnUltimoDiaAno(dateadd(year,-1,@FechaA))
  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'Personal/Percepciones', @AjusteD, @AjusteA, NULL, @PersonalPercepciones OUTPUT, NULL

    IF @Estatus='Alta'
  IF @RequiereAjuste='S' and @FechaAlta<=@AjusteD and @PersonalPercepciones < @SueldoMaxAjuste
   set @CalcularAjusteAnual=1

    IF @Estatus='Baja'
  IF @RequiereAjuste='S' and @FechaAlta<=@AjusteD and @FechaBaja > = @AjusteA  and @PersonalPercepciones < @SueldoMaxAjuste
   SET @CalcularAjusteAnual=1
 
   
  IF @CalcularAjusteAnual=1
  BEGIN

  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/Base', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRBaseAcumulado OUTPUT, NULL
  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRAcumulado OUTPUT, NULL
  EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'ISR/SubsidioAlEmpleoTabla', @PrimerDiaAnoAnterior, @UltimoDiaAnoAnterior, NULL, @ISRSubsidioAlEmpleoAcumulado OUTPUT, NULL
 
        EXEC spTablaImpuesto 'ISR',     NULL, 'ANUAL', @ISRBaseAcumulado, @ISRAnual OUTPUT
                
  SET @ISRAnual =isnull(@ISRAnual,0)
 
  IF  @ISRAnual < @ISRSubsidioAlEmpleoAcumulado
   SELECT @ISRAjusteAnual = @ISRAcumulado
  ELSE IF  @ISRAnual > @ISRSubsidioAlEmpleoAcumulado
   SELECT @ISRAjusteAnual = (@ISRAnual - @ISRSubsidioAlEmpleoAcumulado) - @ISRAcumulado

  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/BaseAcumAnual',   @Empresa, @Personal, @Importe = @ISRBaseAcumulado                  
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/AcumAnual',   @Empresa, @Personal, @Importe = @ISRAcumulado            
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/SubsidioAlEmpleoAcumAnual',@Empresa, @Personal, @Importe = @ISRSubsidioAlEmpleoAcumulado            
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/Anual',           @Empresa, @Personal, @Importe = @ISRAnual            
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ISR/AjusteAnual',   @Empresa, @Personal, @Importe = @ISRAjusteAnual                
  END
  END	ELSE  
  SELECT @PercepcionBruta = 0.0  
  SELECT @PercepcionBruta = @PercepcionBruta + ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
   WHERE d.Personal = @Personal  
  IF ISNULL(@PensionASueldoBruto,0)<>0 OR ISNULL(@PensionASueldoNeto,0) <> 0 OR
     ISNULL(@PensionASueldoBruto2,0)<>0 OR ISNULL(@PensionASueldoNeto2,0) <> 0 OR
     ISNULL(@PensionASueldoBruto3,0)<>0 OR ISNULL(@PensionASueldoNeto3,0) <> 0
  BEGIN 
    SELECT @CalcImporte = (@PensionASueldoBruto/100.0) * @PercepcionBruta  
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoBruto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor  
 	  IF @Nomtipo in('PRESTAMO FONDO AHORR')--, 'LIQUIDACION FONDO AHORRO')
      SELECT @CalcImporte = (@PensionASueldoNeto/100.0)*(@PercepcionBruta)---ISNULL(@ISR, 0.0)  - ISNULL(@FondoAhorro,0)- isnull (@FondoAhorroPrestamoAcumulado,0))   
--    lo cambie      SELECT @CalcImporte = (@PensionASueldoNeto/100.0)*(@PercepcionBruta-ISNULL(@ISR, 0.0)  )       
  	ELSE
 	    IF @Nomtipo in('LIQUIDACION FONDO AHORRO')--, 'LIQUIDACION FONDO AHORRO')
        SELECT @CalcImporte = (@PensionASueldoNeto/100.0)*(@PercepcionBruta-ISNULL(@ISR, 0.0)  - ISNULL(@FondoAhorro,0)- isnull (@FondoAhorroPrestamoAcumulado,0))    
--      lo cambie      SELECT @CalcImporte = (@PensionASueldoNeto/100.0)*(@PercepcionBruta-ISNULL(@ISR, 0.0)  )   
      ELSE BEGIN
/*      AQUI ESTA LO QUE LE MODIFIQUE ANGEL BC*/
	      SELECT @ValesDespensaImportePension = (@PensionASueldoNeto/100.0)*(case when @nomtipo in('Normal')then @ValesDespensaImporte else 0 end )
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ValesDespensaPension', @Empresa, @Personal, @Importe = @ValesDespensaImportePension
        EXEC spNominaClaveInternaEstaNomina @Personal, 'DESCAUSENTISMOFONDOAHORRO',             NULL,  @DESCAUSENTISMOFONDOAHORRO OUTPUT  
        EXEC spNominaClaveInternaEstaNomina @Personal, 'DESCAUSENTIMOAYUDAFAMILIAR',            NULL,  @DESCAUSENTIMOAYUDAFAMILIAR OUTPUT  
        EXEC spNominaClaveInternaEstaNomina @Personal, 'DESCAUSENTHORASFONDOAH',                NULL,  @DESCAUSENTHORASFONDOAH OUTPUT  
        EXEC spNominaClaveInternaEstaNomina @Personal, 'DESCAUSENTHORASAYUDAFAMIL',             NULL,  @DESCAUSENTHORASAYUDAFAMIL OUTPUT
        SELECT @CalcImporte = (@PensionASueldoNeto/100.0)* (ISNULL(@PercepcionBruta ,0.0)
                         - ISNULL(@ISR, 0.0)  
                         - ISNULL(@FondoAhorro,0)
                         - ISNULL(@FondoAhorroPrestamoAcumulado,0)
                         - ISNULL(@DESCAUSENTISMOFONDOAHORRO,0) 
                         - ISNULL(@DESCAUSENTIMOAYUDAFAMILIAR,0) 
                         - ISNULL(@DESCAUSENTHORASFONDOAH,0) 
                         - ISNULL(@DESCAUSENTHORASAYUDAFAMIL,0) 
                         - ISNULL(@Faltasimporte,0) )   
       
        IF @NomTipo IN ('NORMAL')
        BEGIN  
          SELECT @Calc = (@PensionASueldoNeto/100.0) * (@ValesDespensaImporte) * -1
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ValesDespensa', @Empresa, @Personal, @Importe = @Calc    
        END
      END
    IF 'ESTADISTICA' <> (SELECT Movimiento 
                           FROM NominaConcepto, CfgNominaConcepto 
                          WHERE NominaConcepto.NominaConcepto  = cfgNominaConcepto.NominaConcepto   
                            AND Cfgnominaconcepto.Claveinterna = 'IMSS/Obrero' 
                       )
    SELECT @CalcImporte =  @CalcImporte  - ISNULL(@IMSSObrero, 0.0)
	  SELECT @CalcImporte =  dbo.fnMayor(0,@CalcImporte) 
  	EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoNeto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor  
  	SELECT @CalcImporte = (@PensionASueldoBruto2/100.0)*@PercepcionBruta  
	  SELECT @CalcImporte =  dbo.fnMayor(0,@CalcImporte) 
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoBruto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor2  
    SELECT @CalcImporte = (@PensionASueldoNeto2/100.0)*(@PercepcionBruta-ISNULL(@IMSSObrero, 0.0)- ISNULL(@FondoAhorro,0))  
    IF 'ESTADISTICA' <> (SELECT Movimiento 
                           FROM NominaConcepto, CfgNominaConcepto 
                          WHERE NominaConcepto.NominaConcepto  = cfgNominaConcepto.NominaConcepto   
                            AND Cfgnominaconcepto.Claveinterna = 'IMSS/Obrero' 
                        )
      SELECT @CalcImporte =  @CalcImporte  - ISNULL(@IMSSObrero, 0.0)

    SELECT @CalcImporte =  dbo.fnMayor(0,@CalcImporte) 
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoNeto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor2  
    SELECT @CalcImporte = (@PensionASueldoBruto3/100.0)*@PercepcionBruta  

    SELECT @CalcImporte =  dbo.fnMayor(0,@CalcImporte) 
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoBruto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor3  
    SELECT @CalcImporte = (@PensionASueldoNeto3/100.0)*(@PercepcionBruta-ISNULL(@ISR, 0.0)- ISNULL(@FondoAhorro,0)) 

    IF 'ESTADISTICA' <> (SELECT Movimiento 
                           FROM NominaConcepto, CfgNominaConcepto 
                          WHERE NominaConcepto.NominaConcepto  = cfgNominaConcepto.NominaConcepto   
                            AND Cfgnominaconcepto.Claveinterna = 'IMSS/Obrero' 
                        )
      SELECT @CalcImporte =  dbo.fnmayor(0,@CalcImporte  - ISNULL(@IMSSObrero, 0.0))
    SELECT @CalcImporte =  dbo.fnMayor(0,@CalcImporte) 
    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'PensionA/SueldoNeto', @Empresa, @Personal, @Importe = @CalcImporte, @Cuenta = @PensionAAcreedor3  
  END  


---se borran todos los conceptos que no aplican para este MOV
    DELETE #Nomina    
      FROM #Nomina n    
      JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto    
     WHERE nc.NominaConcepto NOT IN(SELECT MovEspecificoNomina.NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina.MovEspecificoNomina = @Mov)    
       AND n.Personal = @Personal   and exists(select * from MovEspecificoNomina where MovEspecificoNomina.nominaconcepto= n.NominaConcepto)

IF @MOV  = 'PRESUPUESTO'
    UPDATE #NOMINA SET REFERENCIA =@PLAZA WHERE NULLIF(referencia,'') IS NULL and personal=@Personal                        

  SELECT @PersonalPercepciones = 0.0, @PersonalDeducciones = 0.0  
IF @MOV  = 'PRESUPUESTO'
BEGIN                        
  SELECT @PersonalPercepciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
   WHERE d.Personal = @Personal And isnull(Referencia,'')=isnull(@Plaza,'')                        
                        
SELECT @PersonalDeducciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Deduccion'  
   WHERE d.Personal = @Personal And isnull(Referencia,'')=isnull(@Plaza,'') 
 END                        
ELSE                        
  BEGIN                         
  SELECT @PersonalPercepciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Percepcion'  
   WHERE d.Personal = @Personal  

 	SELECT @PersonalDeducciones = ISNULL(SUM(d.Importe), 0.0)  
    FROM #Nomina d  
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Movimiento = 'Deduccion'  
   WHERE d.Personal = @Personal  
  END
  
  SELECT @PersonalNeto = @PersonalPercepciones - @PersonalDeducciones  

  IF  @NomCxc IN ('PARCIALES', 'COMPLETAS') 
 AND (@NomTipo NOT IN ('AJUSTE', 'AJUSTE ANUAL') OR  @PersonalEstatus = 'Baja') 
 AND @Ok IS NULL
  BEGIN  
    SELECT @ConSueldoMinimo = 1  
    IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION') AND @FiniquitoNetoEnCeros = 0 SELECT @ConSueldoMinimo = 0  
    IF @PersonalNeto > @SueldoMinimo OR @ConSueldoMinimo = 0  
      EXEC spNominaCxc @NomCxc, @NomTipo, @Empresa, @Sucursal, @ID, @Personal, @Cliente, @FechaD, @FechaA, @Moneda, @TipoCambio, @ConSueldoMinimo, @SueldoMinimo, @PersonalNeto OUTPUT, @Ok OUTPUT, @OkRef OUTPUT  
  END  

  EXEC spNominaCalcMexicoFinal @Empresa OUTPUT, @Personal OUTPUT, @CalcImporte OUTPUT, @PensionAAcreedor OUTPUT, @PersonalNeto OUTPUT, @PersonalPercepciones OUTPUT, @PersonalDeducciones OUTPUT,
                               @BeneficiarioSueldoNeto OUTPUT, @Mov OUTPUT, @Plaza OUTPUT, @SeguroAuto OUTPUT, @SeguroMedico OUTPUT, @PensionSueldoNeto OUTPUT,    @Ok OUTPUT,    @OkRef OUTPUT

  IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Personal  

  RETURN  
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spNominaCalcElSalvador') and type = 'P') drop procedure dbo.spNominaCalcElSalvador
go
CREATE PROCEDURE dbo.spNominaCalcElSalvador  
  
   @Empresa                        char(5),    
   @FechaTrabajo                   datetime,    
   @Sucursal                       int,    
   @ID                             int,    
   @Mov                            varchar(20),    
   @Moneda                         char(10),    
   @TipoCambio                     float,    
   @Personal                       char(10),    
   @FechaD                         datetime,    
   @FechaA                         datetime,    
   @PeriodoTipo                    varchar(20),    
   @CfgAjusteMensualISR            bit,    
   @CfgSueldoMinimo                varchar(20),    
   @CfgTablaVacaciones             varchar(50),    
   @CfgSubsidioIncapacidadEG       bit,    
   @CfgPrimaDominicalAuto          bit,    
   @CfgISRReglamentoAguinaldo      bit,    
   @CfgISRReglamentoPTU            bit,    
   @CfgISRLiquidacionSueldoMensual varchar(50),    
   @CfgFactorIntegracionAntiguedad varchar(20),    
   @CfgFactorIntegracionTabla      varchar(50),    
   @NomTipo                        varchar(50),    
   @NomCalcSDI                     bit,     
   @NomCxc                         varchar(20),    
   @RepartirDesde                  datetime,    
   @RepartirHasta                  datetime,    
   @RepartirIngresoTope            money,    
   @RepartirIngresoFactor          float,    
   @RepartirDiasFactor             float,    
   @CalendarioEsp                  bit,     
   @IncidenciaD                    datetime,     
   @IncidenciaA                    datetime,    
   @Ok                             int  OUTPUT,    
   @OkRef                          varchar(255) OUTPUT    
--//WITH ENCRYPTION
AS BEGIN    
  RETURN
END
GO

/**************** spNominaCalcPanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaCalcPanama') and type = 'P') drop procedure dbo.spNominaCalcPanama
go
CREATE PROCEDURE spNominaCalcPanama
			@Empresa                        char(5),
			@FechaTrabajo                   datetime,
			@Sucursal                       int,
			@ID                             int,
			@Mov                            varchar(20),
			@Moneda                         char(10),
			@TipoCambio                     float,
			@Personal                       char(10),
			@FechaD                         datetime,
			@FechaA                         datetime,
			@PeriodoTipo                    varchar(20),
			@CfgAjusteMensualISR            bit,
			@CfgSueldoMinimo                varchar(20),
			@CfgTablaVacaciones             varchar(50),
			@CfgSubsidioIncapacidadEG       bit,
			@CfgPrimaDominicalAuto          bit,
			@CfgISRReglamentoAguinaldo      bit,
			@CfgISRReglamentoPTU            bit,
			@CfgISRLiquidacionSueldoMensual	varchar(50),
			@CfgFactorIntegracionAntiguedad	varchar(20),
			@CfgFactorIntegracionTabla      varchar(50),
			@NomTipo                        varchar(50),
      			@NomCalcSDI                     bit, 
    			@NomCxc				varchar(20),
			@RepartirDesde                  datetime,
			@RepartirHasta                  datetime,
      			@RepartirIngresoTope		money,
			@RepartirIngresoFactor          float,
			@RepartirDiasFactor             float,
			@CalendarioEsp                  bit, 
			@IncidenciaD                    datetime, 
			@IncidenciaA                    datetime,
			@Ok                             int		OUTPUT,
			@OkRef                          varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  RETURN
END
GO

/**************** spNominaGenerarVacacionesPanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGenerarVacacionesPanama') and type = 'P') drop procedure dbo.spNominaGenerarVacacionesPanama
go
CREATE PROCEDURE dbo.spNominaGenerarVacacionesPanama
			@Estacion	    int,
			@ID		        int,
			@FechaD		    datetime,
			@FechaA		    datetime,
			@PeriodoTipo	varchar(20),
			@FechaTrabajo	datetime = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa				                char(5),
    @RedondeoMonetarios 		        int,
    @CfgAjusteMensualISR		        bit,
    @CfgSueldoMinimo			          varchar(20),
    @CfgTablaVacaciones			        varchar(50),
    @CfgSubsidioIncapacidadEG		    bit,
    @CfgPrimaDominicalAuto		      bit,
    @CfgISRReglamentoAguinaldo		  bit,
    @CfgISRReglamentoPTU      		  bit,
    @CfgISRLiquidacionSueldoMensual	varchar(50),
    @CfgFactorIntegracionAntiguedad	varchar(20),
    @CfgFactorIntegracionTabla		  varchar(50),
    @CfgFondoAhorroRepartirInteres	varchar(20),
    @CfgCajaAhorroRepartirInteres	  varchar(20),
    @Sucursal				                int,
    @Mov				                    varchar(20),
    @NomTipo				                varchar(50),
    @NomCalcSDI				              bit,
    @NomCxc 				                varchar(20),
    @Moneda				                  char(10),
    @TipoCambio				              float,
    @Personal				                char(10),
    @ClaveInterna			              varchar(10), 
    @Conteo				                  int,
    @RepartirDesde			            datetime,
    @RepartirHasta			            datetime,
    @RepartirImporte			          money,
    @RepartirIngresoTope		        money,
    @RepartirIngresoTotal		        money,
    @RepartirTotalDias			        float,
    @RepartirIngresoFactor		      float,
    @RepartirDiasFactor			        float,
    @Renglon				                float,
    @CalendarioEsp			            bit,
    @IncidenciaD			              datetime, 
    @IncidenciaA			              datetime,
    @Ok					                    int,
    @OkRef				                  varchar(255), 
    @FechaMaxVacaciones             datetime,
    @Dia                            int,
    @Mes                            int,
    @Ano                            int,
    @CuantosMov                     int,
    @RamaID                         int
  SELECT @RamaID = @ID --es el papa
  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version
  SELECT @IncidenciaD = @FechaD, @IncidenciaA = @FechaA

  IF @FechaTrabajo IS NULL
  BEGIN
    SELECT @FechaTrabajo = GETDATE()
    EXEC spExtraerFecha @FechaTrabajo OUTPUT
  END
  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL
  SELECT @Empresa = n.Empresa, @Sucursal = n.Sucursal, @Mov = n.Mov, @Moneda = n.Moneda, @TipoCambio = n.TipoCambio, 
         @NomTipo = ISNULL(NULLIF(RTRIM(UPPER(mt.NomAutoTipo)), ''), 'NORMAL'),
         @NomCalcSDI = ISNULL(mt.NomAutoCalcSDI, 0),
         @NomCxc  = UPPER(mt.NomAutoCxc)		-- No/Parciales/Completas
    FROM Nomina n
    JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov
   WHERE n.ID = @ID

  SELECT @CalendarioEsp = NomAutoCalendarioEsp FROM MovTipo WHERE Modulo = 'NOM' AND Mov = @Mov

  IF @CalendarioEsp = 1
    SELECT @IncidenciaD = IncidenciaD, @IncidenciaA = IncidenciaA
      FROM MovTipoNomAutoCalendarioEsp
     WHERE Modulo = 'NOM' AND Mov = @Mov AND FechaNomina = @FechaA

  SELECT @FechaMaxVacaciones= MAX(d.FechaAplicacion) 
    FROM  Incidencia i
    JOIN IncidenciaD d ON i.ID = d.id AND i.estatus = 'PENDIENTE' 
    JOIN NominaConcepto c ON c.NominaConcepto = d.NominaConcepto AND c.Especial = 'VACACIONES' 
     AND i.Personal in(
  SELECT i2.Personal
    FROM Incidencia i2 
    JOIN IncidenciaD d2 ON i.ID = d2.id AND i2.estatus = 'PENDIENTE' 
    JOIN NominaConcepto c ON c.NominaConcepto = d2.NominaConcepto AND c.Especial = 'VACACIONES' 
    JOIN ListaSt  s ON  i2.Personal = s.Clave 
     AND s.Estacion = @Estacion
   WHERE d2.FechaAplicacion BETWEEN @IncidenciaD AND @IncidenciaA)

  CREATE TABLE #Nomina (
  	         ID		          int		NOT NULL IDENTITY(1,1) PRIMARY KEY,
  	         IncidenciaID	  int		NULL,
  	         IncidenciaRID	int		NULL,
             Fecha		      datetime	NULL,
             Personal	      varchar(10)COLLATE Database_Default 	NULL,
  	         Semana		      int		NULL,  
             NominaConcepto	varchar(10)COLLATE Database_Default 	NULL, 
             Movimiento	    varchar(20)COLLATE Database_Default 	NULL,
  	         Referencia	    varchar(50)	COLLATE Database_Default NULL, 
  	         Cantidad	      float		NULL, 
  	         Importe		    money		NULL,
  	         Cuenta	 	      varchar(10) COLLATE Database_Default 	NULL,
    	       Vencimiento  	datetime 	NULL,
  	         Beneficiario	  varchar(100)	COLLATE Database_Default  NULL)
  
  CREATE TABLE #Nomina2 (
          ID		          int		NOT NULL IDENTITY(1,1) PRIMARY KEY,
  	      IncidenciaID	  int		NULL,
  	      IncidenciaRID	  int		NULL,
          Fecha		        datetime	NULL,
          Personal	      varchar(10)	COLLATE Database_Default NULL,  
          NominaConcepto	varchar(10)	COLLATE Database_Default NULL, 
          Movimiento	    varchar(20)	COLLATE Database_Default NULL,
  	      Referencia	    varchar(50)	COLLATE Database_Default NULL, 
  	      Cantidad	      float		NULL, 
  	      Importe		      money		NULL,
  	      Cuenta	 	      varchar(10) 	COLLATE Database_Default NULL,
    	    Vencimiento  	  datetime 	NULL,
  	      Beneficiario	  varchar(100)	COLLATE Database_Default NULL)
  CREATE INDEX Personal ON #Nomina (Personal, NominaConcepto)
  CREATE INDEX IncidenciaID ON #Nomina (Personal, IncidenciaID)
  CREATE INDEX IncidenciaRID ON #Nomina (Personal, IncidenciaRID)

  SELECT @CfgTablaVacaciones = TablaVacaciones
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgAjusteMensualISR            = AjusteMensualISR,
	       @CfgSueldoMinimo                = UPPER(SueldoMinimo),	-- No/Oficial
         @CfgSubsidioIncapacidadEG       = ISNULL(SubsidioIncapacidadEG, 0),
         @CfgPrimaDominicalAuto          = ISNULL(PrimaDominicalAuto, 0),
 	       @CfgISRReglamentoAguinaldo      = ISNULL(ISRReglamentoAguinaldo, 0),
	       @CfgISRReglamentoPTU            = ISNULL(ISRReglamentoPTU, 0),
         @CfgISRLiquidacionSueldoMensual = UPPER(ISRLiquidacionSueldoMensual),
         @CfgFactorIntegracionAntiguedad = UPPER(FactorIntegracionAntiguedad),
         @CfgFactorIntegracionTabla      = FactorIntegracionTabla,
         @CfgFondoAhorroRepartirInteres  = FondoAhorroRepartirInteres,
         @CfgCajaAhorroRepartirInteres   = CajaAhorroRepartirInteres
    FROM EmpresaCfgNomAuto
   WHERE Empresa = @Empresa

  SELECT @ClaveInterna = NULL
  
  SELECT @ClaveInterna = MIN(cfg.ClaveInterna)
    FROM CfgNominaConcepto cfg
    LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
   WHERE nc.NominaConcepto IS NULL
  
  IF @ClaveInterna IS NOT NULL
    SELECT @Ok = 10034, @OkRef = @ClaveInterna 

  SELECT @CuantosMov = 1
  WHILE @IncidenciaD <= @FechaMaxVacaciones AND @OK IS NULL
  BEGIN
    DELETE #Nomina    
    DELETE #Nomina2    



    SELECT @IncidenciaD = @FechaD, @IncidenciaA = @FechaA

    IF @CalendarioEsp = 1
      SELECT @IncidenciaD = IncidenciaD, @IncidenciaA = IncidenciaA
        FROM MovTipoNomAutoCalendarioEsp
       WHERE Modulo = 'NOM' AND Mov = @Mov AND FechaNomina = @FechaA

    DECLARE crLista CURSOR FOR
      SELECT DISTINCT  i2.Personal
        FROM Incidencia i2 
        JOIN IncidenciaD d2 ON i2.ID = d2.ID AND i2.Estatus = 'PENDIENTE' 
        JOIN NominaConcepto c ON c.NominaConcepto = d2.NominaConcepto AND c.Especial = 'VACACIONES' 
        JOIN ListaSt  s ON i2.Personal = s.Clave 
         AND s.Estacion = @Estacion
       WHERE d2.FechaAplicacion BETWEEN @IncidenciaD AND @IncidenciaA

    OPEN crLista
    FETCH NEXT FROM crLista INTO @Personal
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
  
          EXEC spNominaCalc @Empresa, @FechaTrabajo, @Sucursal, @ID, @Mov, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo, 
                            @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto, 
                            @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla, 
                            @NomTipo, @NomCalcSDI, @NomCxc,
                            @RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                            @CalendarioEsp, @IncidenciaD, @IncidenciaA,
                            @Ok OUTPUT, @OkRef OUTPUT
  
        IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
      END
      FETCH NEXT FROM crLista INTO @Personal
    END -- While
    CLOSE crLista
    DEALLOCATE crLista
    IF @Ok IS NULL
    BEGIN
      EXEC spNominaImpuestoEstatalEspecial @Empresa, @Ok OUTPUT, @OkRef OUTPUT
      --BEGIN TRANSACTION
      DELETE NominaD WHERE ID = @ID
 
     INSERT #Nomina2 (
             Personal,   IncidenciaID,   IncidenciaRID,   NominaConcepto,   Movimiento,   Referencia,   Cuenta,   Vencimiento,   Beneficiario,   Importe,        Cantidad)
      SELECT d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, d.Movimiento, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, SUM(d.Importe), SUM(d.Cantidad)
        FROM #Nomina d
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
       WHERE NULLIF(d.Importe, 0.0) IS NOT NULL OR NULLIF(d.Cantidad, 0.0) IS NOT NULL
       GROUP BY nc.Modulo,      d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, d.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario
       ORDER BY nc.Modulo DESC, d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, d.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario
  
      INSERT NominaD (
             ID,  Sucursal,  Renglon, Modulo,    Personal,   IncidenciaID,    NominaConcepto,   Movimiento,   Concepto,    Referencia,   Cuenta,   FechaA,        Beneficiario,   Importe,                               Cantidad,   CuentaContable)
      SELECT @ID, @Sucursal, d.ID,    nc.Modulo, d.Personal, d.IncidenciaRID, d.NominaConcepto, d.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, d.Importe/*ROUND(d.Importe, @RedondeoMonetarios)*/, d.Cantidad, dbo.fnNominaCuentaContable (nc.CuentaBase, nc.Cuenta, d.Personal, d.NominaConcepto)
        FROM #Nomina2 d
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
  
      SELECT @Renglon = MAX(Renglon) FROM NominaD WHERE ID = @ID
      INSERT NominaD (
             ID,  Sucursal,  Renglon,       Modulo, Personal,   IncidenciaID,    NominaConcepto,   Movimiento,    Concepto,    Referencia,   Cuenta,                FechaA,        Beneficiario,   Importe,                               Cantidad,   CuentaContable)
      SELECT @ID, @Sucursal, @Renglon+d.ID, 'CXP',  d.Personal, d.IncidenciaRID, d.NominaConcepto, 'Estadistica', nc.Concepto, d.Referencia, nc.AcreedorDef, d.Vencimiento, d.Beneficiario, d.Importe/*ROUND(d.Importe, @RedondeoMonetarios)*/, d.Cantidad, dbo.fnNominaCuentaContable (nc.CuentaBase, nc.Cuenta, d.Personal, d.NominaConcepto)
        FROM #Nomina2 d
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Modulo = 'CXC' AND nc.GenerarEstadisticaCxp = 1
  
      UPDATE Nomina SET PeriodoTipo = @PeriodoTipo, FechaD = @FechaD, FechaA = @FechaA, Estatus = 'BORRADOR', RamaID = @RamaID WHERE ID = @ID
  
      EXEC xpNominaGenerar @Estacion, @ID, @FechaD, @FechaA, @PeriodoTipo
 
      IF @FechaD <= @FechaMaxVacaciones
      BEGIN
        SELECT @FechaD = DATEADD(dd, 1,  @FechaA)
        IF DAY(@FechaD) = 1   -- para ajustar FECHAA  por el problema de 31, 30,28  etc
        BEGIN 
          SELECT @Mes = MONTH(@FechaD), @Ano = YEAR(@FechaD)
          EXEC SpIntToDateTime 15, @Mes, @Ano, @FechaA OUTPUT
        END ELSE  
        BEGIN
          SELECT @Mes = MONTH(@FechaD), @Ano = YEAR(@FechaD)
          EXEC spDiasMes @Mes, @Ano, @Dia OUTPUT 
          EXEC SpIntToDateTime @Dia, @Mes, @Ano, @FechaA OUTPUT
        END
        SELECT @IncidenciaD = @FechaD, @IncidenciaA = @FechaA
        IF @CalendarioEsp = 1
          SELECT @IncidenciaD = IncidenciaD, @IncidenciaA = IncidenciaA
            FROM MovTipoNomAutoCalendarioEsp
           WHERE Modulo = 'NOM' AND Mov = @Mov AND FechaNomina = @FechaA

        IF @FechaD <= @FechaMaxVacaciones
        BEGIN
          INSERT Nomina (Empresa, Mov,  FechaEmision, UltimoCambio, Proyecto, UEN, Concepto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, GenerarPoliza, ContID, Sucursal, Percepciones, Deducciones, FechaOrigen, FechaRegistroNomXD, FechaRegistroNomXA, SucursalOrigen, SucursalDestino, RamaID) 
          SELECT         Empresa, Mov,  FechaEmision, UltimoCambio, Proyecto, UEN, Concepto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, GenerarPoliza, ContID, Sucursal, Percepciones, Deducciones, FechaOrigen, FechaRegistroNomXD, FechaRegistroNomXA, SucursalOrigen, SucursalDestino, @RamaID 
            FROM Nomina 
           WHERE ID = @ID  
          SELECT @ID = SCOPE_IDENTITY() 
          SELECT @CuantosMov = @CuantosMov + 1
        END

      END
    END ELSE
    BEGIN
      SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
      return
    END
  END

  IF @Ok IS  NULL
    SELECT 'Se Generaron ' + CONVERT(VARCHAR, @CuantosMov) +' Movimientos.'       
  ELSE
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  RETURN

END
GO

/*************************   spNominaCalculaDiasMes   ************************* cambioABC*/
if exists (select * from sysobjects where object_id('dbo.spNominaCalculaDiasMes')=id and type='P') drop procedure dbo.spNominaCalculaDiasMes
go
CREATE PROCEDURE dbo.spNominaCalculaDiasMes
    (  
      @FechaD         datetime,  
      @FechaA         datetime,  
      @CalculaDiasMes int  output  
    )  
 --//WITH ENCRYPTION   
AS  
  BEGIN  
    SET DATEFIRST 7  
    SET ANSI_NULLS OFF  
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
    SET LOCK_TIMEOUT -1  
    SET QUOTED_IDENTIFIER OFF  
    SET NOCOUNT ON
    SET DATEFORMAT dmy
  
  DECLARE @TipoPeriodo    varchar(20),    @MesF int,  
          @Diaa INT, @Mesa int, @Anoa int, @Diad INT, @Mesd int, @Anod int, @DiasPeriodoMes INT,  
          @Fhi  dateTIME, @FechaI datetime, @Fhf DATETIME, @FechaF datetime, @Diaensemana int, @FhInsert datetime  
  DECLARE @loop_dia INT, @item_dia INT, @cuenta int, @semana int  
  DECLARE @item_Agenda  TABLE (Id INT IDENTITY(1,1) NOT NULL, NbFecha varchar(1), Fecha Datetime)  
  
  DELETE @item_Agenda  
  
  SET @FechaD = CONVERT(datetime, @FechaD,103)  
  SET @FechaA = CONVERT(datetime, @FechaA,103)  
  
  SELECT @Diad = Datepart(weekday, @FechaD)  
  SELECT @Fhi = DATEADD(DAY, -7, @FechaD)  
     Set @Mesd = Datepart(month, @FechaD)  
   
  SELECT @Fhi = CONVERT(DATETIME,  '01/'+CONVERT(VARCHAR(2),Datepart(month, @FechaA)) + '/' +CONVERT(VARCHAR(4),Datepart(YEAR, @FechaA)),103)  
  
  SET @FhInsert  = @Fhi  
  SELECT @FechaI = @FechaA  
  SET @cuenta    = 0  
  
  DECLARE @loop_counter INT, @item_semana INT  
  SET @item_semana = 1  
  SET @loop_counter=7  
  SET @Fhf = @FechaA  
  WHILE @loop_counter >= @item_semana  
  BEGIN  
    set @cuenta=0  
    SET @FechaI=DATEADD(week,-1,@FechaI)   
    Set @semana=Datepart(weekday,@FechaI)  
    SET @FhInsert =@FechaI  
    SET @item_dia = 7  
    SET @loop_dia=1  
    WHILE @loop_dia <= @item_dia   
    BEGIN       
      INSERT INTO @item_Agenda values('D',@FhInsert)  
      set @FhInsert = DATEADD(day,1,@FhInsert)   
      IF @FhInsert=@Fhi  
      Begin  
        Select @cuenta=100  
      End  
      set  @loop_dia = @loop_dia + 1  
    END  
    IF  isnull(@cuenta,0) > 0  
    Begin  
      SET  @loop_counter = 0  
    End  
    SET  @loop_counter = @loop_counter - 1  
  END  
  Select top 1 @FechaI =fecha from  @item_Agenda order by fecha  
  Delete  @item_Agenda  
  SELECT @MesA = Datepart(month,@FechaA)  
  SET @item_semana = 7  
  SET @loop_counter=1  
  SET @Fhf = @FechaA  
  WHILE @loop_counter <= @item_semana  
  BEGIN  
    set @FechaF = DATEADD(week,1,@Fhf)   
    set @MesF  = DATEPART(month,@FechaF)  
    IF @MesA=@MesF   
    Begin  
      SET @Fhf = @FechaF  
    End  Else  
    SET @loop_counter=100     
    SET  @loop_counter = @loop_counter + 1  
  END  
  SELECT @CalculaDiasMes = DATEDIFF(day,@FechaI,@Fhf)  
 --RETURN @CalculaDiasMes  
  RETURN  
END  
GO

/************************  spCalculaAnticipoFondoAhorro  ************************ cambioABC*/
if exists (select * from sysobjects where object_id('dbo.spCalculaAnticipoFondoAhorro')=id and type='P') drop procedure dbo.spCalculaAnticipoFondoAhorro
go
CREATE PROCEDURE dbo.spCalculaAnticipoFondoAhorro
  (
    @Empresa        varchar(5),
    @Personal       varchar(20),
    @FondoAhorro  money OUTPUT
  )
  --//WITH ENCRYPTION
  AS
  BEGIN
    DECLARE @PorcentajeAntic  float,
            @ImporteEmp       money,
            @ImportePer       money,
            @FondoEmp         varchar(10),
            @FondoPer         varchar(10),
	    @FechaD           datetime,
	    @FechaA           datetime


    -- Inicializa constantes
       SELECT @FondoEmp = '252'
       SELECT @FondoPer = '253'

    -- Calcula el porcentaje de anticipo de la propiedad    
      SELECT @PorcentajeAntic = convert(float, isnull(Valor,0)) / 100.00
        FROM PersonalPropValor
       WHERE Cuenta=@Empresa
         AND Rama = 'EMP'
         AND Propiedad = '% Anticipo Fondo de Ahorro'

    -- Trae la fecha De
      SELECT @FechaD = CONVERT(DATETIME,Valor,103)
        FROM PersonalPropValor
       WHERE Cuenta=@Empresa
         AND Rama = 'EMP'
         AND Propiedad = 'ANTICIPO FONDO DE AHORRO FECHAD'


    -- Trae la fecha A
      SELECT @FechaA = CONVERT(DATETIME,Valor,103)
        FROM PersonalPropValor
       WHERE Cuenta=@Empresa
         AND Rama = 'EMP'
         AND Propiedad = 'ANTICIPO FONDO DE AHORRO FECHAA'

    -- Suma los importes de aportaciones por fondo de ahorro empresa
      SELECT @ImporteEmp = SUM(isnull(importe,0))
      FROM NominaD
      JOIN Nomina ON NominaD.ID = Nomina.ID
      WHERE NominaD.NominaConcepto = @FondoEmp
      AND NominaD.Personal = @Personal
      AND Nomina.FechaEmision BETWEEN @FechaD AND @FechaA



    -- Suma los importes de aportaciones por fondo de ahorro personal
      SELECT @ImportePer = SUM(isnull(importe,0))
      FROM NominaD
      JOIN Nomina ON NominaD.ID = Nomina.ID
      WHERE NominaD.NominaConcepto = @FondoPer
      AND NominaD.Personal = @Personal
      AND Nomina.FechaEmision BETWEEN @FechaD AND @FechaA

    -- Calcula el anticipo del fondo de ahorro

    SELECT @FondoAhorro = (@ImportePer + @ImporteEmp) * @PorcentajeAntic

  END
GO

/************************   spCalculaCuotaSindical  ************************** cambioABC*/ 
if exists (select * from sysobjects where object_id('dbo.spCalculaCuotaSindical')=id and type='P') drop procedure dbo.spCalculaCuotaSindical
go
CREATE PROCEDURE dbo.spCalculaCuotaSindical 
  (
    @Empresa        varchar(5),
    @Personal       varchar(20),
    @FechaD         datetime,
    @FechaA         datetime,
    @Mov            varchar(20),
    @CuotaSindical  money OUTPUT
  )
  --//WITH ENCRYPTION
  AS
  BEGIN
    DECLARE @PorcentajeCuota  float,
            @DiasPeriodo      tinyint,
            @Faltas           float,
            @SueldoDiario     money

    SELECT @PorcentajeCuota = Valor / 100.00
      FROM PersonalPropValor
     WHERE Cuenta=@Empresa
       AND Rama = 'EMP'
       AND Propiedad = '% Cuota sindical'

    IF @FechaA IS NULL
        SELECT @FechaD = IncidenciaD,
               @FechaA = IncidenciaA
          FROM MovTipoNomAutoCalendarioEsp  
         WHERE FechaNomina = @FechaD
           AND Mov = @Mov

    SELECT @Faltas = SUM(Cantidad) FROM Incidencia
      JOIN NominaConcepto ON Incidencia.NominaConcepto=NominaConcepto.NominaConcepto
       AND Especial IN ('Faltas','Incapacidades')
     WHERE Incidencia.Estatus='PENDIENTE'
       AND Incidencia.FechaEmision BETWEEN @FechaD AND @FechaA
       AND Personal = @Personal
  GROUP BY Personal

    SELECT @SueldoDiario = SueldoDiario,
           @DiasPeriodo =  PeriodoTipo.DiasPeriodo 
      FROM Personal
      JOIN PeriodoTipo ON Personal.PeriodoTipo = PeriodoTipo.PeriodoTipo
     WHERE sindicato='SI'
       AND Personal.Personal = @Personal

    SELECT @CuotaSindical = (@SueldoDiario * (@DiasPeriodo - COALESCE(@Faltas,0))) * @PorcentajeCuota
  END
GO

/*************************** spCalculaAyudaFamiliar     ***************** cambioABC endonde lo pongo*/
if exists(select * from sysobjects where object_id('dbo.spCalculaAyudaFamiliar')=id and type='P') 
drop procedure dbo.spCalculaAyudaFamiliar
go
CREATE PROCEDURE dbo.spCalculaAyudaFamiliar 
  (
    @Empresa        varchar(5),
    @Personal       varchar(20),
    @AyudaFamiliar  money OUTPUT
  )
  --//WITH ENCRYPTION
  AS
  BEGIN
    DECLARE @PorcentajeCuota      float,
            @DiasPeriodo          tinyint,
            @SueldoDiario         money,
            @AyudaFamiliarImporte money

    SELECT @PorcentajeCuota = Valor / 100.00
      FROM PersonalPropValor
     WHERE Cuenta=@Empresa
       AND Rama = 'EMP'
       AND Propiedad = '% Ayuda Familiar'

    SELECT @AyudaFamiliarImporte = convert(money,Valor) 
      FROM PersonalPropValor
     WHERE Cuenta    = @Personal
       AND Rama      = 'PER'
       AND Propiedad = 'Ayuda Familiar'


    SELECT @SueldoDiario = SueldoDiario,
           @DiasPeriodo =  PeriodoTipo.DiasPeriodo 
      FROM Personal
      JOIN PeriodoTipo ON Personal.PeriodoTipo = PeriodoTipo.PeriodoTipo
     WHERE Personal.Personal = @Personal

    SELECT @AyudaFamiliarImporte = (@SueldoDiario * @DiasPeriodo) * ISNULL(@PorcentajeCuota, 0) + ISNULL(@AyudaFamiliarImporte, 0)
  END
GO

/********************  spCalculaValesDespensa *************************************** cambioABC*/

if exists (select * from sysobjects where object_id('dbo.spCalculaValesDespensa')=id and type='P') drop procedure dbo.spCalculaValesDespensa
go
CREATE PROCEDURE dbo.spCalculaValesDespensa 
  (
    @Empresa        varchar(5),
    @Personal       varchar(20),
    @ValesDespensa  money OUTPUT
  )
  --//WITH ENCRYPTION
  AS
  BEGIN
    DECLARE @PorcentajeVales  float,
            @DiasPeriodo      tinyint,
            @SueldoDiario     money

    SELECT @PorcentajeVales = Valor / 100.00
      FROM PersonalPropValor
     WHERE Cuenta=@Empresa
       AND Rama = 'EMP'
       AND Propiedad = '% Vales Despensa por periodo'


    SELECT @SueldoDiario = SueldoDiario,
           @DiasPeriodo =  PeriodoTipo.DiasPeriodo 
      FROM Personal
      JOIN PeriodoTipo ON Personal.PeriodoTipo = PeriodoTipo.PeriodoTipo
     WHERE Personal.Personal = @Personal

    SELECT @ValesDespensa = (@SueldoDiario * @DiasPeriodo) * @PorcentajeVales
  END
GO


/************************   spNominaIVAHProfesional   **************************/
IF exists (select * from sysobjects where object_id('dbo.spNominaIVAHProfesional')=id and type='P') drop procedure dbo.spNominaIVAHProfesional
go
CREATE PROCEDURE dbo.spNominaIVAHProfesional
@ISRBase		money,
@FactorIva		float,
@FactorIvaRetenido	float,
@FactorISR		float,
@IVAHP		money	OUTPUT,
@IVAHPRetenido	money	OUTPUT,
@IRSHP		money	OUTPUT
WITH ENCRYPTION
AS BEGIN
  SELECT @IVAHP = 0, @IVAHPRetenido = 0, @IRSHP = 0
  SELECT @IVAHP=ISNULL(@ISRBase,0) * ISNULL(ISNULL(@FactorIva, 100) /100,0)
  SELECT @IVAHPRetenido=ISNULL(@ISRBase,0) * ISNULL(ISNULL(@FactorIvaRetenido, 100) /100,0) 
  SELECT @IRSHP=ISNULL(@ISRBase,0) * ISNULL(ISNULL(@FactorISR, 100) /100,0)
RETURN
END
GO


if exists (select * from sysobjects where object_id('dbo.spNominaDiasFestivos')=id and type='P') drop procedure dbo.spNominaDiasFestivos
go
Create  Procedure spNominaDiasFestivos  
    (  
      @FechaD         datetime,  
      @FechaA         datetime, @Personal char(10) ,
      @DiasFestivos int  output  
    )  
--//WITH ENCRYPTION
AS  BEGIN  
   SET DATEFIRST 7  

   Declare @TipoPeriodo varchar(20), @Fh  datetime, @DiasDiferencia int, @Cfestivo int
   Declare @loop_dia INT, @item_dia INT, @cuenta int, @semana int  
   Select @DiasDiferencia = datediff(day,@FechaD,@FechaA)
   Select @item_dia = 0, @DiasFestivos = 0
   Select @fh = @FechaD
    WHILE datediff(day,@fh,@FechaA)<> 0
        BEGIN	
	  Select @fh = dateadd(day,@item_dia,@FechaD)

	  SELECT     @Cfestivo =sum(incd.Cantidad) 
		FROM   CfgNominaConcepto cfgn INNER JOIN
                      		IncidenciaD incd ON cfgn.NominaConcepto = incd.NominaConcepto INNER JOIN
	                        Incidencia inc ON incd.ID = inc.ID
			WHERE    (cfgn.ClaveInterna = 'Vacaciones') and (incd.FechaAplicacion=@fh) and (inc.personal=@Personal)
	if isnull(@Cfestivo,0)>0
		Select @DiasFestivos = @DiasFestivos + @Cfestivo	
	   
	select @Cfestivo=count(fecha)  from diafestivo  where  eslaborable=0 and @fh = fecha
	if isnull(@Cfestivo,0)>0
		Select @DiasFestivos = @DiasFestivos + @Cfestivo	

	  IF  Datepart(weekday,@fh) IN (7,1)
	  BEGIN
		Select @DiasFestivos = @DiasFestivos +1
	  END 
              SET @item_dia = @item_dia + 1
        END
RETURN
END
GO


/**************** spNominaCancelarLinea ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaCancelarLinea') and type = 'P') drop procedure dbo.spNominaCancelarLinea
GO             
CREATE PROCEDURE spNominaCancelarLinea
			@ID		int,
			@Renglon	float
--//WITH ENCRYPTION
AS BEGIN
  IF EXISTS(SELECT * FROM Nomina WHERE ID = @ID AND Estatus = 'PROCESAR')
    UPDATE NominaD SET Cantidad = NULL, CantidadPendiente = NULL WHERE ID = @ID AND Renglon = @Renglon
  RETURN
END
GO

/**************** spNominaAcumuladoFechas *************** cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAcumuladoFechas') and type = 'P') drop procedure dbo.spNominaAcumuladoFechas
GO             
CREATE PROCEDURE spNominaAcumuladoFechas
			@Empresa	char(5),
			@Personal	char(10),
			@Concepto	varchar(50),
			@FechaD		datetime,
			@FechaA		datetime,
			@Movimiento	varchar(50),
			@Importe	money	OUTPUT,
 			@Cantidad	float	OUTPUT,
      @NoEnMov  	char(20)	= NULL,    
      @Estatus 	varchar(15)	= NULL  
WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM EmpresaCfgNominaAcum WHERE Empresa = @Empresa)
    INSERT EmpresaCfgNominaAcum (Empresa, EmpresaAcum) VALUES (@Empresa, @Empresa)
    
  SELECT @Personal   = NULLIF(RTRIM(@Personal), ''),
         @Concepto   = NULLIF(RTRIM(@Concepto), ''),
         @Movimiento = NULLIF(RTRIM(@Movimiento), '')

  SELECT @Importe = 0.0, @Cantidad = 0.0

  SELECT @Importe = @Importe + ISNULL(SUM(ISNULL(d.Importe,0)), 0.0), @Cantidad = @Cantidad + ISNULL(SUM(ISNULL(d.Cantidad,0)), 0.0)
    FROM Nomina n, NominaD d, MovTipo mt
   WHERE n.ID = d.ID
     AND n.Estatus in('CONCLUIDO',Case WHEN @Estatus = 'BORRADOR' then 'BORRADOR' else 'CONCLUIDO' END)
     AND n.Empresa IN (SELECT EmpresaAcum FROM EmpresaCfgNominaAcum WHERE Empresa = @Empresa) 
     AND n.FechaA BETWEEN @FechaD AND @FechaA AND mt.Clave IN ('NOM.N', 'NOM.NE') 
     AND n.Mov = mt.Mov
     AND mt.Modulo = 'NOM'
     AND d.Personal = @Personal
     AND d.Concepto = @Concepto
     AND d.Movimiento = ISNULL(@Movimiento, d.Movimiento)
     AND n.Mov not in(@NoEnMov)

  SELECT @Importe = @Importe + ISNULL(SUM(ISNULL(d.Importe,0)), 0.0), @Cantidad = @Cantidad + ISNULL(SUM(ISNULL(d.Cantidad,0)), 0.0)
    FROM Nomina n, NominaD d, MovTipo mt
   WHERE n.ID = d.ID
     AND n.Estatus in('CONCLUIDO',Case WHEN @Estatus = 'BORRADOR' then 'BORRADOR' else 'CONCLUIDO' END)
     AND n.Empresa IN (SELECT EmpresaAcum FROM EmpresaCfgNominaAcum WHERE Empresa = @Empresa) 
     AND n.FechaEmision BETWEEN @FechaD AND @FechaA AND mt.Clave IN ('NOM.NA', 'NOM.NC')
     AND n.Mov = mt.Mov
     AND mt.Modulo = 'NOM'
     AND d.Personal = @Personal
     AND d.Concepto = @Concepto
     AND d.Movimiento = ISNULL(@Movimiento, d.Movimiento)
     AND n.Mov not in(@NoEnMov)

  RETURN
END
GO

/**************** spVerNominaAcumuladoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerNominaAcumuladoFechas') and type = 'P') drop procedure dbo.spVerNominaAcumuladoFechas
GO             
CREATE PROCEDURE spVerNominaAcumuladoFechas
			@Empresa	char(5),
			@EsImporte	bit,
			@Personal	char(10),
			@Concepto	varchar(50),
			@FechaD		datetime,
			@FechaA		datetime,
			@Movimiento	varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Importe	money,
    @Cantidad	float

  EXEC spNominaAcumuladoFechas @Empresa, @Personal, @Concepto, @FechaD, @FechaA, @Movimiento, @Importe OUTPUT, @Cantidad OUTPUT
  IF @EsImporte = 1
    SELECT "Importe" = @Importe
  ELSE
    SELECT "Cantidad" = @Cantidad
END
GO

/**************** spVerUltimaNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerUltimaNomina') and type = 'P') drop procedure dbo.spVerUltimaNomina
GO             
CREATE PROCEDURE spVerUltimaNomina
--//WITH ENCRYPTION
AS BEGIN
  SELECT ID, Mov, MovID, FechaD, FechaA
    FROM Nomina 
   WHERE ID = (SELECT MAX(ID) FROM Nomina n, MovTipo mt WHERE n.Mov = mt.Mov AND mt.Clave = 'NOM.N' AND n.Estatus = 'CONCLUIDO')
END
GO


-- spVerPersonalProp 'SL', NULL, 0, 'DEMO'
/**************** spVerPersonalProp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerPersonalProp') and type = 'P') drop procedure dbo.spVerPersonalProp
GO             
CREATE PROCEDURE spVerPersonalProp
                        @Personal	char(10),
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Sucursal	int,
			@Empresa	char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Propiedad	varchar(50),
    @Valor	varchar(50),
    @Orden	int,
    @SucursalSt	varchar(20)

  SELECT @SucursalSt = CONVERT(varchar, @Sucursal)
  SELECT "Propiedad" = NULLIF(RTRIM(Propiedad), ''), "Valor" = NULLIF(RTRIM(Valor), '')
    INTO #PersonalProp
    FROM PersonalPropValor
   WHERE Rama   = 'EMP' 
     AND Cuenta = @Empresa
     AND NULLIF(RTRIM(Propiedad), '') IS NOT NULL 
     AND NULLIF(RTRIM(Valor), '') IS NOT NULL

  DECLARE crPersonalProp CURSOR
     FOR SELECT NULLIF(RTRIM(Propiedad), ''), NULLIF(RTRIM(Valor), ''), 
                "Orden" = CASE Rama WHEN 'SUC' THEN 1 WHEN 'CAT' THEN 2 WHEN 'PER' THEN 3 END
           FROM PersonalPropValor
          WHERE ((Rama = 'CAT' AND Cuenta = @Categoria) OR 
                 (Rama = 'PUE' AND Cuenta = @Puesto) OR 
                 (Rama = 'SUC' AND Cuenta = @SucursalSt) OR 
                 (Rama = 'PER' AND Cuenta = @Personal))          
          ORDER BY Orden
  OPEN crPersonalProp
  FETCH NEXT FROM crPersonalProp INTO @Propiedad, @Valor, @Orden
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Propiedad IS NOT NULL AND @Valor IS NOT NULL
    BEGIN
      IF EXISTS(SELECT * FROM #PersonalProp WHERE Propiedad = @Propiedad)
        UPDATE #PersonalProp SET Valor = @Valor WHERE Propiedad = @Propiedad
      ELSE
        INSERT #PersonalProp (Propiedad, Valor) VALUES (@Propiedad, @Valor)
    END
    FETCH NEXT FROM crPersonalProp INTO @Propiedad, @Valor, @Orden
  END  -- While
  CLOSE crPersonalProp
  DEALLOCATE crPersonalProp

  SELECT Propiedad, Valor 
    FROM #PersonalProp
   ORDER BY Propiedad
  RETURN
END
GO

-- spVerNominaCorresponde 'EMP-15', 'DEMO', 'Otras Deducciones', NULL, '10/9/3', 'SALDO'
/**************** spVerNominaCorresponde ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerNominaCorresponde') and type = 'P') drop procedure dbo.spVerNominaCorresponde
GO             
CREATE PROCEDURE spVerNominaCorresponde
                        @Personal	char(10),
			@Empresa	char(5),
			@Mov		char(20),
			@Concepto	varchar(50),
			@Fecha		datetime,
			@Comando	char(10)
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
    @PersonalTipoCambio	float,
    @Saldo		money,
    @RedondeoMonetarios	int

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()

  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @Suma = 0.0, @Comando = UPPER(@Comando), 
         @Mov = NULLIF(RTRIM(@Mov), ''), @Concepto = NULLIF(RTRIM(@Concepto), '')

  IF @Comando = 'PRESTAMO'
  BEGIN
     SELECT "Suma" = SUM(ISNULL(d.Importe*m.TipoCambio, 0.0))
       FROM Nomina n, NominaD d, MovTipo mt, Mon m
      WHERE n.ID = d.ID
        AND n.Estatus IN ('PROCESAR', 'VIGENTE')
        AND n.Empresa = @Empresa
        AND n.FechaEmision <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
        AND n.Mov = @Mov
        AND n.Mov = mt.Mov
        AND mt.Modulo = 'NOM'
        AND mt.Clave = 'NOM.PD'
        AND d.Personal = @Personal
        AND d.Activo = 1  
        AND d.Importe = d.Saldo
        AND n.Moneda = m.Moneda
    RETURN
  END ELSE
  IF @Comando = 'PRESTAMOI'
  BEGIN
     SELECT "Suma" = SUM(ISNULL(d.Importe*m.TipoCambio, 0.0))
       FROM Nomina n, NominaD d, MovTipo mt, Mon m
      WHERE n.ID = d.ID
        AND n.Estatus IN ('PROCESAR', 'VIGENTE')
        AND n.Empresa = @Empresa
        AND n.FechaEmision <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
        AND n.Mov = @Mov
        AND n.Mov = mt.Mov
        AND mt.Modulo = 'NOM'
        AND mt.Clave = 'NOM.PI'
        AND d.Personal = @Personal
        AND d.Activo = 1  
        AND d.Importe = d.Saldo
        AND n.Moneda = m.Moneda
    RETURN
  END 

  IF @Comando = 'SALDO'
  BEGIN
    IF @Concepto IS NULL
      DECLARE crNomSaldo CURSOR FOR 
       SELECT NULLIF(RTRIM(UPPER(n.Condicion)), ''), ISNULL(d.Importe*m.TipoCambio, 0.0), ISNULL(d.Cantidad, 0.0), ISNULL(d.Porcentaje, 0.0), ISNULL(d.Monto*m.TipoCambio, 0.0), d.FechaD, d.FechaA, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.Saldo*m.TipoCambio, 0.0)
         FROM Nomina n, NominaD d, MovTipo mt, Mon m
        WHERE n.ID = d.ID
          AND n.Estatus IN ('PROCESAR', 'VIGENTE')
          AND n.Empresa = @Empresa
          AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
          AND n.Mov = @Mov
          AND n.Mov = mt.Mov
          AND mt.Modulo = 'NOM'
          AND mt.Clave IN ('NOM.P', 'NOM.D', 'NOM.PD', 'NOM.PI')
          AND d.Personal = @Personal
          AND d.Activo = 1
          AND n.Moneda = m.Moneda
    ELSE
      DECLARE crNomSaldo CURSOR FOR 
       SELECT NULLIF(RTRIM(UPPER(n.Condicion)), ''), ISNULL(d.Importe*m.TipoCambio, 0.0), ISNULL(d.Cantidad, 0.0), ISNULL(d.Porcentaje, 0.0), ISNULL(d.Monto*m.TipoCambio, 0.0), d.FechaD, d.FechaA, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.Saldo*m.TipoCambio, 0.0)
         FROM Nomina n, NominaD d, MovTipo mt, Mon m
        WHERE n.ID = d.ID
          AND n.Estatus IN ('PROCESAR', 'VIGENTE')
          AND n.Empresa = @Empresa
          AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
          AND n.Mov = @Mov
          AND n.Concepto = @Concepto
          AND n.Mov = mt.Mov
          AND mt.Modulo = 'NOM'
          AND mt.Clave IN ('NOM.P', 'NOM.D', 'NOM.PD', 'NOM.PI')
          AND d.Personal = @Personal
          AND d.Activo = 1
          AND n.Moneda = m.Moneda
 
    OPEN crNomSaldo
    FETCH NEXT FROM crNomSaldo INTO @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Condicion IS NULL OR @Condicion = 'UNA VEZ' SELECT @Suma = @Suma + @Saldo ELSE
        IF @Condicion = 'REPETIR SIEMPRE' SELECT @Suma = @Suma + @Importe ELSE	
--	IF @Condicion = '% SUELDO' SELECT @Suma = @Suma + (ISNULL(SueldoDiario, 0.0) * (@Porcentaje / 100)) FROM Personal WHERE Personal = @Personal ELSE
        IF @Condicion = 'REPETIR' AND @CantidadPendiente > 0 SELECT @Suma = @Suma + @Importe ELSE
        IF @Condicion = 'REPETIR FECHAS' AND @Fecha BETWEEN @FechaD AND @FechaA SELECT @Suma = @Suma + @Importe ELSE
	IF @Condicion IN ('PRORRATEAR', 'PRORRATEAR %', 'PRORRATEAR $', 'CON ENGANCHE')
        BEGIN
          IF @Condicion = 'CON ENGANCHE' AND @Saldo = @Importe SELECT @Monto = @Cantidad ELSE
	  IF @Condicion = 'PRORRATEAR' AND @CantidadPendiente > 0 SELECT @Monto = ROUND(@Importe / @Cantidad, @RedondeoMonetarios) ELSE
          IF @Condicion = 'PRORRATEAR %' SELECT @Monto = ROUND(@Importe * (@Porcentaje / 100), @RedondeoMonetarios)
          IF ROUND(@Saldo - @Monto, 0) <= 0 SELECT @Monto = @Monto + (@Saldo - @Monto) - ROUND(@Saldo - @Monto, 0)

          IF @Monto > @Saldo SELECT @Suma = @Suma + @Saldo ELSE SELECT @Suma = @Suma + @Monto
        END

      END
      FETCH NEXT FROM crNomSaldo INTO @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo
    END
    CLOSE crNomSaldo
    DEALLOCATE crNomSaldo
  END ELSE 
  IF @Comando = 'CANTIDAD'
  BEGIN
   IF @Concepto IS NULL
     SELECT @Suma = SUM(d.CantidadPendiente)
       FROM Nomina n, NominaD d, MovTipo mt
       WHERE n.ID = d.ID
         AND n.Estatus = 'PROCESAR'
         AND n.Empresa = @Empresa
         AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
         AND n.Mov = @Mov
         AND n.Mov = mt.Mov
         AND mt.Modulo = 'NOM'
         AND mt.Clave IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
         AND d.Personal = @Personal
         AND d.Activo = 1
   ELSE
     SELECT @Suma = SUM(d.CantidadPendiente)
       FROM Nomina n, NominaD d, MovTipo mt
       WHERE n.ID = d.ID
         AND n.Estatus = 'PROCESAR'
         AND n.Empresa = @Empresa
         AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, @Mov, @Fecha)
         AND n.Mov = @Mov
         AND n.Concepto = @Concepto
         AND n.Mov = mt.Mov
         AND mt.Modulo = 'NOM'
         AND mt.Clave IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
         AND d.Personal = @Personal
         AND d.Activo = 1
  END
  SELECT @PersonalTipoCambio = NULL
  SELECT @PersonalTipoCambio = NULLIF(m.TipoCambio, 0.0)
    FROM Personal p, Mon m
   WHERE p.Personal = @Personal AND p.Moneda = m.Moneda


  SELECT "Suma" = ROUND(@Suma/ISNULL(@PersonalTipoCambio, 1.0), @RedondeoMonetarios)
  RETURN
END
GO

-- spVerNominaCorrespondeLote 'EMP-15', 'DEMO', '10/9/3'
/**************** spVerNominaCorrespondeLote ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerNominaCorrespondeLote') and type = 'P') drop procedure dbo.spVerNominaCorrespondeLote
GO             
CREATE PROCEDURE spVerNominaCorrespondeLote
                        @Personal	char(10),
			@Empresa	char(5),
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Suma				money,
    @Condicion			varchar(50),
    @Importe			money,
    @Cantidad			money,
    @Porcentaje			money,
    @Monto				money,
    @FechaD				datetime,
    @FechaA				datetime,
    @CantidadPendiente	money,
    @PersonalTipoCambio	float,
    @Saldo				money,
    @Mov				varchar(20),
    @Concepto			varchar(50),	
    @RedondeoMonetarios	int,
    @ID					int,
    @IDNomina			int,
	@MovNomina			varchar(20),
	@MovTipoNomina		varchar(20),
    @MovTipo			varchar(20),
	@Renglon	        float, --BUG22055
	@NomProcesarIncidencias	bit

  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  
  --BUG22055
  CREATE TABLE #Corresponde (IDNomina Int, ID Int, Comando char(10) COLLATE Database_Default NULL, Mov varchar(20) COLLATE Database_Default NULL, Concepto varchar(50) COLLATE Database_Default NULL, Monto float NULL, Personal varchar(10) COLLATE Database_Default NULL, DRenglon float NULL)

  SELECT @IDNomina = Numerico FROM SPIDTemp WHERE SPID = @@SPID
  SELECT @MovNomina = Mov FROM Nomina WHERE ID = @IDNomina
  SELECT @MovTipoNomina = Clave, @NomProcesarIncidencias = NomProcesarIncidencias FROM MovTipo WHERE Modulo = 'NOM' AND Mov = @MovNomina

  SELECT @MovTipo = Clave FROM MovTipo WHERE Modulo = 'NOM' AND Mov = @Mov
  EXEC spExtraerFecha @Fecha OUTPUT

  SELECT @PersonalTipoCambio = NULL
  SELECT @PersonalTipoCambio = NULLIF(m.TipoCambio, 0.0)
    FROM Personal p, Mon m
   WHERE p.Personal = @Personal AND p.Moneda = m.Moneda

  --BUG22055
  INSERT #Corresponde (IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon) --BUG22055
   SELECT @IDNomina, n.ID, 'PRESTAMO', n.Mov, n.Concepto, d.Importe*m.TipoCambio, d.Personal, d.Renglon --BUG22055
     FROM Nomina n, NominaD d, MovTipo mt, Mon m
    WHERE n.ID = d.ID
      AND n.Estatus IN ('PROCESAR', 'VIGENTE')
      AND n.Empresa = @Empresa
      AND n.FechaEmision <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @Fecha)
      AND n.Mov = mt.Mov
      AND mt.Modulo = 'NOM'
      AND mt.Clave = 'NOM.PD'
      AND d.Personal = @Personal
      AND d.Activo = 1  
      AND d.Importe = d.Saldo
      AND n.Moneda = m.Moneda

  INSERT #Corresponde (IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon) --BUG22055
   SELECT @IDNomina, n.ID, 'PRESTAMOI', n.Mov, n.Concepto, d.Importe*m.TipoCambio, d.Personal, d.Renglon --BUG22055
     FROM Nomina n, NominaD d, MovTipo mt, Mon m
    WHERE n.ID = d.ID
      AND n.Estatus IN ('PROCESAR', 'VIGENTE')
      AND n.Empresa = @Empresa
      AND n.FechaEmision <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @Fecha)
      AND n.Mov = mt.Mov
      AND mt.Modulo = 'NOM'
      AND mt.Clave = 'NOM.PI'
      AND d.Personal = @Personal
      AND d.Activo = 1  
      AND d.Importe = d.Saldo
      AND n.Moneda = m.Moneda

  INSERT #Corresponde (IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon) --BUG22055
   SELECT @IDNomina, n.ID, 'CANTIDAD', n.Mov, n.Concepto, d.CantidadPendiente, d.Personal, d.Renglon --BUG22055
     FROM Nomina n, NominaD d, MovTipo mt
     WHERE n.ID = d.ID
       AND n.Estatus = 'PROCESAR'
       AND n.Empresa = @Empresa
       AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @Fecha)
       AND n.Mov = mt.Mov
       AND mt.Modulo = 'NOM'
       AND mt.Clave IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
       AND d.Personal = @Personal
       AND d.Activo = 1
       AND d.CantidadPendiente <> 0

    DECLARE crNomSaldo CURSOR FOR 
     SELECT n.ID, d.Renglon, n.Mov, n.Concepto, NULLIF(RTRIM(UPPER(n.Condicion)), ''), ISNULL(d.Importe*m.TipoCambio, 0.0), ISNULL(d.Cantidad, 0.0), ISNULL(d.Porcentaje, 0.0), ISNULL(d.Monto*m.TipoCambio, 0.0), d.FechaD, d.FechaA, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.Saldo*m.TipoCambio, 0.0) --BUG22055
       FROM Nomina n, NominaD d, MovTipo mt, Mon m
      WHERE n.ID = d.ID
        AND n.Estatus IN ('PROCESAR', 'VIGENTE')
        AND n.Empresa = @Empresa
        AND d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @Fecha)
        AND n.Mov = mt.Mov
        AND mt.Modulo = 'NOM'
        AND mt.Clave IN ('NOM.P', 'NOM.D', 'NOM.PD', 'NOM.PI')
        AND d.Personal = @Personal
        AND d.Activo = 1
        AND n.Moneda = m.Moneda

  OPEN crNomSaldo
  FETCH NEXT FROM crNomSaldo INTO @ID, @Renglon, @Mov, @Concepto, @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Suma = 0.0
      IF @Condicion IS NULL OR @Condicion = 'UNA VEZ' SELECT @Suma = @Suma + @Saldo ELSE
      IF @Condicion = 'REPETIR SIEMPRE' SELECT @Suma = @Suma + @Importe ELSE	
--    IF @Condicion = '% SUELDO' SELECT @Suma = @Suma + (ISNULL(SueldoDiario, 0.0) * (@Porcentaje / 100)) FROM Personal WHERE Personal = @Personal ELSE
      IF @Condicion = 'REPETIR' AND @CantidadPendiente > 0 SELECT @Suma = @Suma + @Importe ELSE
      IF @Condicion = 'REPETIR FECHAS' AND @Fecha BETWEEN @FechaD AND @FechaA SELECT @Suma = @Suma + @Importe ELSE
      IF @Condicion IN ('PRORRATEAR', 'PRORRATEAR %', 'PRORRATEAR $', 'CON ENGANCHE')
      BEGIN
        IF @Condicion = 'CON ENGANCHE' AND @Saldo = @Importe SELECT @Monto = @Cantidad ELSE
	    IF @Condicion = 'PRORRATEAR' AND @CantidadPendiente > 0 SELECT @Monto = ROUND(@Importe / @Cantidad, @RedondeoMonetarios) ELSE
        IF @Condicion = 'PRORRATEAR %' SELECT @Monto = ROUND(@Importe * (@Porcentaje / 100), @RedondeoMonetarios)

        IF @MovTipoNomina = 'NOM.NE' AND @MovTipo IN ('NOM.PD', 'NOM.PI') SELECT @Monto = @Saldo
        IF ROUND(@Saldo - @Monto, 0) <= 0 SELECT @Monto = @Monto + (@Saldo - @Monto) - ROUND(@Saldo - @Monto, 0)
        IF @Monto > @Saldo SELECT @Suma = @Suma + @Saldo ELSE SELECT @Suma = @Suma + @Monto
      END
      --BUG22055
      INSERT #Corresponde (IDNomina, ID, Comando, Mov,  Concepto,  Monto, Personal, DRenglon)   --BUG22055 
                   VALUES (@IDNomina, @ID, 'SALDO', @Mov, @Concepto, ROUND(@Suma/ISNULL(@PersonalTipoCambio, 1.0), @RedondeoMonetarios), @Personal, @Renglon) --BUG22055
    END
    FETCH NEXT FROM crNomSaldo INTO @ID, @Renglon, @Mov, @Concepto, @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo --BUG22055
  END
  CLOSE crNomSaldo
  DEALLOCATE crNomSaldo
  	
  IF ISNULL(@NomProcesarIncidencias,0) = 0
    INSERT INTO NominaCorrespondeLote (IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon) SELECT IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon FROM #Corresponde WHERE Mov IN (SELECT Incidencia FROM MovTipoIncidencias WHERE Mov = @MovNomina)
  ELSE
    INSERT INTO NominaCorrespondeLote (IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon) SELECT IDNomina, ID, Comando, Mov, Concepto, Monto, Personal, DRenglon FROM #Corresponde

  SELECT Comando, Mov, Concepto, "Monto" = SUM(Monto), IDNomina
    FROM #Corresponde 
   GROUP BY Comando, Mov, Concepto, IDNomina
   ORDER BY Comando, Mov, Concepto
  RETURN
END
GO

/**************** spNominaMatarCorresponde ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaMatarCorresponde') and type = 'P') drop procedure dbo.spNominaMatarCorresponde
GO  
CREATE PROCEDURE spNominaMatarCorresponde
                        @Sucursal		int,
		    	@Accion			char(20),
			@Modulo			char(5),
			@Empresa		char(5),
			@ID			int,
			@Mov			char(20),
			@MovID			varchar(20),
			@MovTipo		char(20),
                        @Personal		char(10),
			@PersonalFechaD		datetime,
			@PersonalFechaA		datetime,
			@GenerarBaja		bit,
			@ProcesarIncidencias	bit,

    		    	@Ok             	int          OUTPUT,
			@OkRef			varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Suma 				money,
    @Condicion			varchar(50),
    @Importe			money,
    @Cantidad			money,
    @Porcentaje			money,
    @Monto				money,
    @FechaD				datetime,
    @FechaA				datetime,
    @CantidadPendiente	money,
    @Saldo				money,
    @Activo				bit,
    @SaldoAnterior		money,
    @CantidadAnterior	money,
    @DID				int,
    @DRenglon			float,
    @DMov				char(20),
    @DMovID				varchar(20),
    @Procesar			bit,
    @DEstatus			char(15),
    @Origen				char(20),
    @OrigenID			varchar(20),
	@DMovTipo			varchar(20),
    @ConsecutivoPorPeriodo		bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa		char(20),
    @ConsecutivoSucursalEsp		bit,
    @Ejercicio					int,
    @Periodo					int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  IF @Accion = 'CANCELAR' OR (@MovTipo = 'NOM.NC' AND @Accion <> 'CANCELAR')
  BEGIN
    IF @MovTipo = 'NOM.NC'
    BEGIN
      SELECT @Origen = Origen, @OrigenID = OrigenID, @Periodo = Periodo, @Ejercicio = Ejercicio FROM Nomina WHERE ID = @ID
      SELECT @ID = NULL
      SELECT @ID = ID FROM Nomina WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END
    END
    DECLARE crLog CURSOR FOR 
     SELECT l.DID, l.DRenglon, l.Importe, l.Cantidad, l.Procesar, n.Mov, n.MovID
       FROM NominaLog l, Nomina n
      WHERE n.ID = l.ID
        AND l.ID = @ID 
        AND l.Personal = @Personal 
        AND l.Referencia = 0

    OPEN crLog 
    FETCH NEXT FROM crLog INTO @DID, @DRenglon, @Importe, @Cantidad, @Procesar, @DMov, @DMovID
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Procesar = 1 
        BEGIN
          UPDATE NominaD SET Activo = 1, CantidadPendiente = @Cantidad WHERE ID = @DID AND Renglon = @DRenglon

          EXEC spValidarTareas @Empresa, @Modulo, @DID, 'PROCESAR', @Ok OUTPUT, @OkRef OUTPUT
          UPDATE Nomina SET @DEstatus = Estatus = 'PROCESAR' WHERE ID = @DID
          IF @DEstatus NOT IN ('CONCLUIDO', 'PROCESAR') SELECT @Ok = 60060
        END ELSE
        BEGIN
          UPDATE NominaD 
             SET Saldo = ISNULL(Saldo, 0.0) + @Importe,
                 CantidadPendiente = ISNULL(CantidadPendiente, 0.0) + @Cantidad,
                 Activo = 1
           WHERE ID = @DID AND Renglon = @DRenglon
        END
       EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DID, @DMov, @DMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crLog INTO @DID, @DRenglon, @Importe, @Cantidad, @Procesar, @DMov, @DMovID
    END
    CLOSE crLog 
    DEALLOCATE crLog 
  END ELSE 
  BEGIN
    -- Disminuir los Movimientos Vigentes  
    DECLARE crVigente CURSOR FOR 
     SELECT NULLIF(RTRIM(UPPER(n.Condicion)), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Cantidad, 0.0), ISNULL(d.Porcentaje, 0.0), ISNULL(d.Monto, 0.0), d.FechaD, d.FechaA, ISNULL(d.CantidadPendiente, 0.0), ISNULL(d.Saldo, 0.0), d.Activo, n.ID, n.Mov, n.MovID, d.Renglon
       FROM Nomina n, NominaD d
      WHERE n.ID = d.ID
        AND n.Estatus = 'VIGENTE'
        AND n.Empresa = @Empresa
        AND (d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @PersonalFechaA) OR @GenerarBaja = 1)
        AND n.Condicion NOT IN ('REPETIR SIEMPRE', '% SUELDO')
        AND d.Personal = @Personal
        AND d.Activo = 1
        AND (@ProcesarIncidencias = 1 OR n.Mov IN (SELECT Incidencia FROM MovTipoIncidencias WHERE Modulo = @Modulo AND Mov = @Mov AND Concepto IN ('(Todos)', n.Concepto)))
 -- ARL BUG 6853  
        AND n.ID IN (SELECT ID FROM NominaCorrespondeLote WHERE IDNomina = @ID AND Personal = @Personal AND Utilizado = 1)
    OPEN crVigente
    FETCH NEXT FROM crVigente INTO @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo, @Activo, @DID, @DMov, @DMovID, @DRenglon
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
	    SELECT @DMovTipo = Clave FROM MovTipo WHERE Mov = @DMov AND Modulo = 'NOM' 
        SELECT @SaldoAnterior = @Saldo, @CantidadAnterior = @CantidadPendiente
        IF @Condicion = 'REPETIR FECHAS' AND (@PersonalFechaA >= @FechaA OR @GenerarBaja = 1) SELECT @Activo = 0 ELSE
        IF @Condicion IN ('REPETIR', 'PRORRATEAR') 
        BEGIN
          IF @CantidadPendiente > 0.0 AND @Saldo > 0.0 AND @GenerarBaja = 0
          BEGIN
            IF @Condicion = 'REPETIR'    SELECT @Saldo = @Saldo - @Importe ELSE
            IF @Condicion = 'PRORRATEAR' 
            BEGIN
              IF @MovTipo = 'NOM.NE' AND @DMovTipo IN ('NOM.P', 'NOM.D', 'NOM.PD', 'NOM.PI')
              BEGIN
                SELECT @Monto = @Saldo
                SELECT @Saldo = @Saldo - @Monto
              END ELSE			
			    SELECT @Saldo = @Saldo - (@Importe / @Cantidad)
            END
            SELECT @CantidadPendiente = @CantidadPendiente - 1
          END ELSE SELECT @Activo = 0
        END 
        ELSE
        IF @Condicion IN ('PRORRATEAR %', 'PRORRATEAR $', 'CON ENGANCHE') 
        BEGIN
          IF @MovTipo = 'NOM.NE' AND @DMovTipo IN ('NOM.P', 'NOM.D', 'NOM.PD', 'NOM.PI')
          BEGIN
            SELECT @Monto = @Saldo
            SELECT @Saldo = @Saldo - @Monto
          END ELSE

          IF @Saldo > 0.0 AND @GenerarBaja = 0
          BEGIN
            IF @Condicion = 'PRORRATEAR %' SELECT @Saldo = @Saldo - (@Importe * (@Porcentaje / 100)) ELSE
--JGD 13Enero2011 ticket 2865
--BUG22055
            IF @Condicion = 'PRORRATEAR $' EXEC xpRecalcularSaldoMovVigentes @Modulo,@ID,@DRenglon,@DMov,@DMovID,@Personal,@Monto,@Saldo OUTPUT, @DID -- SELECT @Saldo = @Saldo - @Monto ELSE --BUG22055
            IF @Condicion = 'CON ENGANCHE'
            BEGIN
              IF @Saldo = @Importe 
                SELECT @Saldo = @Saldo - @Cantidad 
              ELSE
                SELECT @Saldo = @Saldo - @Monto
            END
          END ELSE SELECT @Activo = 0
        END 

        IF @Activo = 0 
          SELECT @Saldo = 0.0, @CantidadPendiente = 0.0
        ELSE BEGIN
          IF ROUND(@Saldo, 0) <= 0.0 SELECT @Saldo = 0.0
          IF ROUND(@CantidadPendiente, 0) <= 0.0 SELECT @CantidadPendiente = 0.0
        END

        IF @Saldo = 0.0 AND @CantidadPendiente = 0.0 
          SELECT @Activo = 0

        UPDATE NominaD 
           SET Saldo = NULLIF(@Saldo, 0.0), CantidadPendiente = NULLIF(@CantidadPendiente, 0.0), Activo = @Activo 
         WHERE CURRENT OF crVigente

        /* Hay un trigger que cambia el Estatus del Encabezado a 'CONCLUIDO' cuando no tiene detalles activos */
  
        INSERT NominaLog (Sucursal, Personal, ID, DID, DRenglon, Importe, Cantidad) 
                  VALUES (@Sucursal, @Personal, @ID, @DID, @DRenglon, (@SaldoAnterior-@Saldo), (@CantidadAnterior-@CantidadPendiente))
   
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DID, @DMov, @DMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crVigente INTO @Condicion, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @CantidadPendiente, @Saldo, @Activo, @DID, @DMov, @DMovID, @DRenglon
    END
    CLOSE crVigente
    DEALLOCATE crVigente

     -- Log
     INSERT NominaLog (Sucursal, Personal, ID, DID, DRenglon, Cantidad, Procesar) 
     SELECT @Sucursal, @Personal, @ID, d.ID, d.Renglon, d.CantidadPendiente, d.Activo
       FROM Nomina n, NominaD d, MovTipo mt
      WHERE n.ID = d.ID
        AND n.Estatus = 'PROCESAR'
        AND n.Empresa = @Empresa
        AND d.Personal = @Personal
        AND d.Activo = 1
        AND mt.Modulo = 'NOM' AND mt.Mov = n.Mov
        AND (d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @PersonalFechaA) OR @GenerarBaja = 1) 
        AND (@ProcesarIncidencias = 1 OR n.Mov IN (SELECT Incidencia FROM MovTipoIncidencias WHERE Modulo = @Modulo AND Mov = @Mov AND Concepto IN ('(Todos)', n.Concepto)))
 -- ARL BUG 6853
        AND n.ID IN (SELECT ID FROM NominaCorrespondeLote WHERE IDNomina = @ID AND Personal = @Personal AND Utilizado = 1)

    -- Desactivar los Movimientos por Procesar
    DECLARE crProcesar CURSOR FOR 
     SELECT d.Personal, d.Activo, n.ID, n.Mov, n.MovID
       FROM Nomina n, NominaD d, MovTipo mt
      WHERE n.ID = d.ID
        AND n.Estatus = 'PROCESAR'      
        AND n.Empresa = @Empresa
        AND d.Personal = @Personal
        AND d.Activo = 1      
        AND mt.Modulo = 'NOM' AND mt.Mov = n.Mov
        AND (d.FechaD <= dbo.fnNominaFechaDesfasada(@Empresa, n.Mov, @PersonalFechaA) OR @GenerarBaja = 1) 
        AND (@ProcesarIncidencias = 1 OR n.Mov IN (SELECT Incidencia FROM MovTipoIncidencias WHERE Modulo = @Modulo AND Mov = @Mov AND Concepto IN ('(Todos)', n.Concepto)))
 -- ARL BUG 6853 
        AND n.ID IN (SELECT ID FROM NominaCorrespondeLote WHERE IDNomina = @ID AND Personal = @Personal AND Utilizado = 1)
      
    OPEN crProcesar
    FETCH NEXT FROM crProcesar INTO @Personal, @Activo, @DID, @DMov, @DMovID
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        UPDATE NominaD SET Activo = 0, CantidadPendiente = NULL WHERE CURRENT OF crProcesar
        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @DID, @DMov, @DMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crProcesar INTO @Personal, @Activo, @DID, @DMov, @DMovID
    END
    CLOSE crProcesar
    DEALLOCATE crProcesar
  END  

  RETURN
END
GO
/**************** spNominaDevolucionPrestamo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaDevolucionPrestamo') and type = 'P') drop procedure dbo.spNominaDevolucionPrestamo
GO  
CREATE PROCEDURE spNominaDevolucionPrestamo
			@Sucursal		int,
			@ID			int,
		    	@Accion			char(20),
			@Empresa		char(5),
			@Personal		char(10),
			@FechaD			datetime,
			@Importe		money,
    		    	@Ok               	int          OUTPUT,
    		    	@OkRef            	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Saldo		money,
    @PrestamoID		int,
    @PrestamoImporte	money,
    @PrestamoSaldo	money,
    @PrestamoCondicion	varchar(50),
    @PrestamoMovTipo	char(20),
    @PrestamoEstatus	char(15),
    @Max		money

  SELECT @Saldo = ISNULL(@Importe, 0.0)
  DECLARE crPrestamos CURSOR FOR
   SELECT n.ID, NULLIF(RTRIM(n.Condicion), ''), mt.Clave, ISNULL(Importe, 0.0), ISNULL(Saldo, 0.0)
     FROM Nomina n, NominaD d, MovTipo mt 
    WHERE n.ID = d.ID AND mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave IN ('NOM.PD', 'NOM.PI')
      AND n.Empresa = @Empresa AND n.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.Personal = @Personal AND d.FechaD = @FechaD 

  OPEN crPrestamos
  FETCH NEXT FROM crPrestamos INTO @PrestamoID, @PrestamoCondicion, @PrestamoMovTipo, @PrestamoImporte, @PrestamoSaldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL AND @Saldo <> 0.0
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @Accion = 'CANCELAR'
      BEGIN 
        SELECT @Max = @PrestamoImporte - @PrestamoSaldo
        IF @Saldo >= @Max
          SELECT @PrestamoSaldo = @PrestamoSaldo + @Max, @Saldo = @Saldo - @Max
        ELSE
          SELECT @PrestamoSaldo = @PrestamoSaldo + @Saldo, @Saldo = 0.0
      END ELSE
      BEGIN
        IF @PrestamoSaldo >= @Saldo
          SELECT @PrestamoSaldo = @PrestamoSaldo - @Saldo, @Saldo = 0.0
        ELSE
          SELECT @Saldo = @Saldo - @PrestamoSaldo, @PrestamoSaldo = 0.0
      END
      UPDATE NominaD SET Saldo = NULLIF(@PrestamoSaldo, 0.0), Activo = CASE WHEN NULLIF(@PrestamoSaldo, 0.0) IS NULL THEN 0 ELSE 1 END WHERE CURRENT OF crPrestamos
      IF EXISTS(SELECT * FROM NominaD WHERE ID = @PrestamoID AND NULLIF(Saldo, 0.0) IS NOT NULL)
      BEGIN
        IF @PrestamoCondicion IS NULL OR UPPER(@PrestamoCondicion) = 'UNA VEZ'
          SELECT @PrestamoEstatus = 'PROCESAR'
        ELSE
          SELECT @PrestamoEstatus = 'VIGENTE'
      END ELSE
        SELECT @PrestamoEstatus = 'CONCLUIDO'

      EXEC spValidarTareas @Empresa, 'NOM', @PrestamoID, @PrestamoEstatus, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Nomina SET Estatus = @PrestamoEstatus WHERE ID = @PrestamoID AND Estatus <> @PrestamoEstatus
    END
    FETCH NEXT FROM crPrestamos INTO @PrestamoID, @PrestamoCondicion, @PrestamoMovTipo, @PrestamoImporte, @PrestamoSaldo
  END
  CLOSE crPrestamos
  DEALLOCATE crPrestamos

  IF @Saldo <> 0.0 SELECT @Ok = 20180, @OkRef = 'Personal - '+RTRIM(@Personal)+', Diferencia -'+CONVERT(varchar, @Saldo)
  RETURN
END
GO

/**************** spNominaMatarReferencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaMatarReferencia') and type = 'P') drop procedure dbo.spNominaMatarReferencia
GO  
CREATE PROCEDURE spNominaMatarReferencia
			@Sucursal		int,
			@ID			int,
		    	@Accion			char(20),
			@Empresa		char(5),
			@Personal		char(10),
			@Referencia		varchar(50),
			@Importe		money,
    		    	@Ok               	int          OUTPUT,
    		    	@OkRef            	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DID	int,
    @DRenglon	float,
    @Saldo	money,
    @Quitar	money

  IF @Accion <> 'CANCELAR'
  BEGIN
    DECLARE crOtrosCargos CURSOR FOR 
     SELECT n.ID, d.Renglon, ISNULL(d.Saldo, 0)
       FROM Nomina n, NominaD d, MovTipo mt
      WHERE n.ID = d.ID
        AND n.Estatus = 'PENDIENTE'      
        AND n.Empresa = @Empresa
        AND RTRIM(n.Mov)+' '+RTRIM(n.MovID) = @Referencia
        AND d.Personal = @Personal
        AND d.Activo = 1      
        AND ISNULL(d.Saldo, 0) > 0
        AND mt.Modulo = 'NOM' AND mt.Mov = n.Mov AND mt.Clave = 'NOM.CA'
      ORDER BY n.FechaEmision, n.ID

    OPEN crOtrosCargos
    FETCH NEXT FROM crOtrosCargos INTO @DID, @DRenglon, @Saldo
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @Importe > @Saldo
          SELECT @Quitar = @Saldo
        ELSE
          SELECT @Quitar = @Importe

        UPDATE NominaD SET Saldo = NULLIF(Saldo - @Quitar, 0) WHERE CURRENT OF crOtrosCargos
        INSERT NominaLog (Sucursal,  Personal,  ID,  DID,  DRenglon,  Importe, Referencia) 
                  VALUES (@Sucursal, @Personal, @ID, @DID, @DRenglon, @Quitar, 1)

        IF NOT EXISTS(SELECT * FROM NominaD WHERE ID = @DID AND ISNULL(ROUND(Saldo, 0), 0) > 0)
        BEGIN
          EXEC spValidarTareas @Empresa, 'NOM', @DID, 'CONCLUIDO', @Ok OUTPUT, @OkRef OUTPUT
          UPDATE Nomina SET Estatus = 'CONCLUIDO' WHERE ID = @DID AND Estatus <> 'CONCLUIDO'
        END
        SELECT @Importe = @Importe - @Quitar
      END
      FETCH NEXT FROM crOtrosCargos INTO @DID, @DRenglon, @Saldo
    END
    CLOSE crOtrosCargos
    DEALLOCATE crOtrosCargos
    IF @Importe <> 0.0 
      SELECT @Ok = 55380, @OkRef = @Referencia
  END
  RETURN
END
GO

/**************** spNominaMatarReferenciaCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaMatarReferenciaCancelar') and type = 'P') drop procedure dbo.spNominaMatarReferenciaCancelar
GO  
CREATE PROCEDURE spNominaMatarReferenciaCancelar
			@Sucursal		int,
			@ID			int,
		    	@Accion			char(20),
			@Empresa		char(5),
    		    	@Ok               	int          OUTPUT,
    		    	@OkRef            	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DID	int,
    @DRenglon	float,
    @Saldo	money,
    @Quitar	money,
    @Importe	money

  IF @Accion = 'CANCELAR'
  BEGIN
    DECLARE crCancelarOtrosCargos CURSOR FOR 
     SELECT DID, DRenglon, Importe
       FROM NominaLog
      WHERE ID = @ID AND Referencia = 1 
    OPEN crCancelarOtrosCargos
    FETCH NEXT FROM crCancelarOtrosCargos INTO @DID, @DRenglon, @Importe
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        UPDATE NominaD SET Saldo = ISNULL(Saldo, 0) + @Importe WHERE ID = @DID AND Renglon = @DRenglon
        EXEC spValidarTareas @Empresa, 'NOM', @DID, 'PENDIENTE', @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Nomina SET Estatus = 'PENDIENTE' WHERE ID = @DID AND Estatus <> 'PENDIENTE'
      END
      FETCH NEXT FROM crCancelarOtrosCargos INTO @DID, @DRenglon, @Importe
    END
    CLOSE crCancelarOtrosCargos
    DEALLOCATE crCancelarOtrosCargos
  END 
  RETURN
END
GO

/**************** spNominaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaVerificar') and type = 'P') drop procedure dbo.spNominaVerificar
GO
CREATE PROCEDURE spNominaVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
		    @Condicion			varchar(50),
		    @PeriodoTipo		varchar(50), 
		    @MovFechaD			datetime, 
		    @MovFechaA			datetime,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @UsaImporte			bit, 
		    @UsaCantidad		bit, 
		    @UsaPorcentaje		bit, 
		    @UsaMonto			bit,
                    @UsaFechas			bit,
                    @CfgValidarReferencias	bit, 
		    @MovIncapacidades		varchar(20), 

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NomModulo  		char(5),
    @Movimiento 		char(20),
    @Personal			char(10),
    @PersonalEmpresa		varchar(5),
    @PersonalEstatus		char(15),
    @PersonalMoneda		char(10),
    @PersonalPeriodoTipo	varchar(50),
    @PersonalUltimoPago		datetime,
    @Cuenta			char(10),
    @Importe			money,
    @Saldo			money,
    @Cantidad			money,
    @Porcentaje			money,
    @Monto			money,
    @FechaD			datetime,
    @FechaA			datetime,
    @Referencia			varchar(50),
    @ValidarFechas		bit,
-- Mejora 6834    
    @InterfazAspel              bit,
    @InterfazAspelNOI           bit,
    @NOI                        bit,
    @Concepto                   varchar(50)



-- Mejora 6834
  SELECT @InterfazAspel = ISNULL(InterfazAspel,0),@InterfazAspelNOI = ISNULL(InterfazAspelNOI,0)
    FROM EmpresaGral WHERE Empresa = @Empresa
    
  SELECT @NOI = ISNULL(NOI,0) FROM Nomina WHERE ID = @ID  
    
    
  SELECT @ValidarFechas = 0
  IF @Accion IN ('CANCELAR', 'DESAFECTAR') AND @Ok IS NULL
  BEGIN
    IF @Estatus = 'PROCESAR' 
    BEGIN
      IF @MovTipo IN ('NOM.P', 'NOM.PI', 'NOM.D', 'NOM.PD', 'NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
      BEGIN
        IF @MovTipo IN ('NOM.P', 'NOM.PI', 'NOM.D', 'NOM.PD') 
        BEGIN
          IF EXISTS(SELECT * FROM NominaD WHERE ID = @ID AND ISNULL(Importe, 0)<>ISNULL(Saldo, 0)) SELECT @Ok = 60081
        END ELSE
        BEGIN
          IF EXISTS(SELECT * FROM NominaD WHERE ID = @ID AND ISNULL(Cantidad, 0)<>ISNULL(CantidadPendiente, 0)) SELECT @Ok = 60081
        END
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO' AND @GenerarPoliza = 0 SELECT @Ok = 60200
      END ELSE SELECT @Ok = 60040
    END
    -- Checar que se haya capturado el movimiento en este modulo
	 IF @Conexion = 0 AND @MovTipo <> 'NOM.CH'
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
       IF @Accion = 'DESAFECTAR' SELECT @Ok = 60075 ELSE SELECT @Ok = 60070

	 IF @Conexion = 0 AND @MovTipo = 'NOM.CH'
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND OModulo = @Modulo AND OID = @ID AND OModulo <> DModulo)
       IF @Accion = 'DESAFECTAR' SELECT @Ok = 60075 ELSE SELECT @Ok = 60070

  END 
  
  IF @MovTipo IN ('NOM.N', 'NOM.NE') AND @Accion = 'AFECTAR'
  IF EXISTS (SELECT * FROM Nomina n JOIN NominaCorrespondeLote c ON n.ID = c.ID WHERE n.Estatus = 'CANCELADO' AND c.IDNomina = @ID)
    SELECT @Ok = 30690, @OkRef = (SELECT TOP 1 RTRIM(n.Mov)+' '+RTRIM(n.MovID) FROM Nomina n JOIN NominaCorrespondeLote c ON n.ID = c.ID WHERE n.Estatus = 'CANCELADO' AND c.IDNomina = @ID)

  IF @MovTipo = 'NOM.N' AND @PeriodoTipo IS NULL SELECT @Ok = 55140 
  IF EXISTS(SELECT * FROM NominaValidarFecha WHERE Mov = @Mov) SELECT @ValidarFechas = 1

-- Mejora 6834
  IF @MovTipo = 'NOM.N' AND @Accion = 'AFECTAR' AND @InterfazAspel = 1 AND @InterfazAspelNOI = 1 AND @NOI = 0
  SELECT @Ok = 55170
  
  IF @Ok IS NOT NULL RETURN
  DECLARE crNominaVerificar CURSOR
     FOR SELECT NULLIF(RTRIM(d.Personal), ''), p.Empresa, RTRIM(p.Estatus), RTRIM(p.Moneda), NULLIF(RTRIM(p.PeriodoTipo), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Cantidad, 0.0), ISNULL(d.Porcentaje, 0.0), ISNULL(d.Monto, 0.0), d.FechaD, d.FechaA, NULLIF(RTRIM(d.Modulo), ''), NULLIF(RTRIM(d.Movimiento), ''), NULLIF(RTRIM(d.Cuenta), ''), ISNULL(d.Saldo, 0), NULLIF(RTRIM(d.Referencia), ''),d.Concepto
           FROM NominaD d
           LEFT OUTER JOIN Personal p ON d.Personal = p.Personal
          WHERE ID = @ID 
  OPEN crNominaVerificar
  FETCH NEXT FROM crNominaVerificar INTO @Personal, @PersonalEmpresa, @PersonalEstatus, @PersonalMoneda, @PersonalPeriodoTipo, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @NomModulo, @Movimiento, @Cuenta, @Saldo, @Referencia, @Concepto
  IF @@ERROR <> 0 SELECT @Ok = 1
  IF @@FETCH_STATUS = -1 SELECT @Ok = 60010

  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      IF @Empresa <> ISNULL(@PersonalEmpresa, @Empresa) SELECT @Ok = 45050

      SELECT @PersonalUltimoPago = NULL 
      SELECT @PersonalUltimoPago = UltimoPago FROM PersonalUltimoPago WHERE Personal = @Personal AND Mov = @Mov AND Empresa = @Empresa
      IF @PersonalUltimoPago IS NULL 
        SELECT @PersonalUltimoPago = UltimoPago FROM PersonalUltimoPago WHERE Personal = @Personal AND Mov = @Mov AND Empresa = ''
      IF @Accion = 'CANCELAR'
      BEGIN
        IF @MovTipo = 'NOM.N' AND @NomModulo = 'NOM' AND @PersonalUltimoPago <> @MovFechaA SELECT @Ok = 60190
        IF @MovTipo = 'NOM.CA' AND @Saldo <> @Importe SELECT @Ok = 60060, @OkRef = @Referencia
      END ELSE
      BEGIN
        IF @MovTipo = 'NOM.N' AND @NomModulo = 'NOM' 
        BEGIN
          IF @PersonalPeriodoTipo <> @PeriodoTipo SELECT @Ok = 55150 ELSE
          IF @PersonalPeriodoTipo IS NULL SELECT @Ok = 55140
          -- Mejora 6834           
          IF @InterfazAspel = 1 AND @InterfazAspelNOI = 1 AND @NOI = 1 AND NOT EXISTS(SELECT * FROM NominaConcepto WHERE Concepto = @Concepto AND ConceptoNOI = 1 AND ConceptoNOIValidado = 1)
          SELECT @Ok =55175,@OkRef = @OkRef +' Concepto ('+ @Concepto+')'
        END ELSE
        IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC')
        BEGIN
          IF @NomModulo = 'NOM' AND @Personal IS NULL SELECT @Ok = 55100 ELSE
 
          IF @NomModulo = 'CXP' AND @Cuenta   IS NULL SELECT @Ok = 55110 ELSE
          IF @NomModulo = 'CXC' AND @Cuenta   IS NULL SELECT @Ok = 55115 ELSE
          IF @NomModulo = 'GAS' AND @Cuenta   IS NULL SELECT @Ok = 55110 ELSE
          IF @NomModulo = 'DIN' AND @Cuenta   IS NULL SELECT @Ok = 55120 ELSE
          IF @NomModulo <> 'DIN' AND @Movimiento IS NULL SELECT @Ok = 55130
        END 
        IF (@MovTipo NOT IN ('NOM.N', 'NOM.NE', 'NOM.NA') OR @NomModulo = 'NOM') AND @MovTipo <> 'NOM.NC' AND @Personal IS NOT NULL AND @PersonalEstatus <> 'ALTA'
        BEGIN 
          IF @PersonalEstatus <> 'BAJA' OR NOT EXISTS(SELECT * FROM NomX WHERE NomMov = @Mov AND AceptaBajas =1 AND Estatus = 'ACTIVA' AND Empresa IN ('(Todas)', @Empresa))
            SELECT @Ok = 55020
        END

        IF @Ok = 55020
          EXEC xpOk_55020 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = 'Persona - '+ISNULL(RTRIM(@Personal), '')+', Importe - '+LTRIM(CONVERT(char, @Importe))
        IF @MovTipo = 'NOM.N' AND @NomModulo = 'NOM' AND (@PersonalUltimoPago BETWEEN @MovFechaD AND @MovFechaA OR @PersonalUltimoPago > @MovFechaD) 
        BEGIN
          -- Si se Trata del mismo Tipo de Periodo manda el error, no mandar error en caso de cambiar su Tipo de Semanal a Quincenal
          IF (SELECT Top 1 PeriodoTipo FROM Nomina n JOIN NominaD d ON n.Id = d.ID WHERE Empresa = @Empresa AND Personal = @Personal AND n.Estatus ='CONCLUIDO' AND n.Mov = @Mov AND n.ID < @ID ORDER BY n.ID DESC) = @PeriodoTipo    
            SELECT @Ok = 55160 
        END ELSE          
        IF @MovTipo = 'NOM.DP'
        BEGIN
          IF NOT EXISTS(SELECT * 
            FROM Nomina n, NominaD d, MovTipo mt 
           WHERE n.ID = d.ID AND mt.Modulo = @Modulo AND mt.Mov = n.Mov AND mt.Clave IN ('NOM.PD', 'NOM.PI')
             AND n.Empresa = @Empresa AND n.Estatus IN ('PENDIENTE', 'PROCESAR', 'VIGENTE') AND d.Personal = @Personal AND d.FechaD = @FechaD AND NULLIF(Saldo, 0) IS NOT NULL)
           SELECT @Ok = 30620
        END
        IF @UsaImporte    = 1 AND @Importe    <= 0 AND @MovTipo NOT IN ('NOM.VA', 'NOM.VT') AND @Conexion = 0 SELECT @Ok = 55050 
        IF @UsaCantidad   = 1 AND @Cantidad   < 0  AND @MovTipo NOT IN ('NOM.VA', 'NOM.VT') SELECT @Ok = 55060 
        IF @UsaPorcentaje = 1 AND @Porcentaje < 0 SELECT @Ok = 55070 
        IF @UsaMonto      = 1 AND @Monto      < 0 SELECT @Ok = 55080 
        IF @UsaFechas     = 1 AND (@FechaD IS NULL OR @FechaA IS NULL) SELECT @Ok = 55090 
        IF @ValidarFechas = 1 AND @Accion IN ('AFECTAR', 'VERIFICAR')
        BEGIN
          SELECT @FechaA = DATEADD(day, @Cantidad-1, @FechaD)
          IF EXISTS(SELECT * 
                      FROM Nomina n, NominaD d, NominaValidarFecha v
                     WHERE n.Empresa = @Empresa AND n.Estatus IN ('PROCESAR', 'VIGENTE') AND n.Mov = v.Mov
                       AND d.ID = n.ID AND d.Personal = @Personal AND (d.FechaD BETWEEN @FechaD AND @FechaA OR DATEADD(day, d.Cantidad-1, d.FechaD) BETWEEN @FechaD AND @FechaA OR @FechaD BETWEEN d.FechaD AND DATEADD(day, d.Cantidad-1, d.FechaD) OR @FechaA BETWEEN d.FechaD AND DATEADD(day, d.Cantidad-1, d.FechaD)))
            SELECT @Ok = 10190
        END

        IF @Referencia IS NOT NULL AND @CfgValidarReferencias = 1 AND @Mov = @MovIncapacidades AND @Accion IN ('AFECTAR', 'VERIFICAR')
        BEGIN
          IF EXISTS(SELECT * 
                      FROM Nomina n, NominaD d
                     WHERE n.Empresa = @Empresa AND Mov = @Mov AND n.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
                       AND d.ID = n.ID AND d.Referencia = @Referencia)
            SELECT @Ok = 20915, @OkRef = @Referencia
        END
      END
      IF @Ok IS NOT NULL AND @OkRef IS NULL 
        SELECT @OkRef = 'Persona - '+RTRIM(@Personal)
    END
    FETCH NEXT FROM crNominaVerificar INTO @Personal, @PersonalEmpresa, @PersonalEstatus, @PersonalMoneda, @PersonalPeriodoTipo, @Importe, @Cantidad, @Porcentaje, @Monto, @FechaD, @FechaA, @NomModulo, @Movimiento, @Cuenta, @Saldo, @Referencia, @Concepto
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crNominaVerificar
  DEALLOCATE crNominaVerificar

  IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA') AND @Ok IS NULL
  BEGIN
    SELECT @OkRef = NULL
    SELECT @OkRef = MIN(Personal) 
      FROM NominaD 
     WHERE /*Modulo = 'NOM' AND */UPPER(Movimiento) IN ('PERCEPCION', 'DEDUCCION') AND ID = @ID 
     GROUP BY Personal 
    HAVING SUM(ISNULL(Importe, 0) * CASE WHEN UPPER(Movimiento)='DEDUCCION' THEN -1 ELSE 1 END) < 0

    IF @OkRef IS NOT NULL  SELECT @Ok = 30570
  END

  IF @Ok IS NULL
    EXEC xpNominaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @Condicion, @PeriodoTipo, @MovFechaD, @MovFechaA, @FechaEmision, @Estatus, 
		           @UsaImporte, @UsaCantidad, @UsaPorcentaje, @UsaMonto, @UsaFechas,
                           @CfgValidarReferencias, @MovIncapacidades, 
			   @Conexion, @SincroFinal, @Sucursal,
			   @CfgContX, @CfgContXGenerar, @GenerarPoliza,
			   @Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** spNominaSugerirSDI ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSugerirSDI') and type = 'P') drop procedure dbo.spNominaSugerirSDI
GO             
CREATE PROCEDURE spNominaSugerirSDI
		   @Accion			char(20),
		   @Sucursal			int,
    		   @Empresa	      		char(5),
    		   @FechaEmision      		datetime,
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @FechaRegistro		datetime,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RHID		int,
    @RHMov		char(20),
    @RHMovID		varchar(20),
    @IDGenerar		int,
    @ConsecutivoPorPeriodo	bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa	char(20),
    @ConsecutivoSucursalEsp	bit,
    @Ejercicio			int,
    @Periodo			int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  SELECT @Ejercicio = YEAR(@FechaRegistro), @Periodo = MONTH(@FechaRegistro)

  SELECT @RHMov = RHModificaciones
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @RHID = NULL
    SELECT @RHID = MIN(ID) FROM RH WHERE Mov = @RHMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END
    IF @RHID IS NOT NULL      
      EXEC spRH @RHID, 'RH', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @RHMov, @RHMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  BEGIN
    IF NOT EXISTS(SELECT * FROM #SDI s, Personal p WHERE s.Personal = p.Personal AND s.SDI <> p.SDI) RETURN 

    INSERT RH (Sucursal, SucursalOrigen, Empresa,  Mov,    FechaEmision,  Proyecto,  Usuario,  Moneda,     TipoCambio,     OrigenTipo, Origen, OrigenID, Estatus)
       VALUES (@Sucursal, @Sucursal,     @Empresa, @RHMov, @FechaEmision, @Proyecto, @Usuario, @MovMoneda, @MovTipoCambio, @Modulo,    @Mov,   @MovID,   'CONFIRMAR')
    SELECT @RHID = SCOPE_IDENTITY()

    INSERT RHD (ID,    Renglon,   Personal,   SueldoDiario,   SDI,   TipoContrato,   VencimientoContrato,   PeriodoTipo,   Jornada,   TipoSueldo,   Puesto,   Departamento,   Categoria,   Grupo,   SucursalTrabajo,   CentroCostos,   FechaAlta,   FechaAntiguedad, Plaza,ReportaA)
    SELECT      @RHID, s.Renglon, p.Personal, p.SueldoDiario, s.SDI, p.TipoContrato, p.VencimientoContrato, p.PeriodoTipo, p.Jornada, p.TipoSueldo, p.Puesto, p.Departamento, p.Categoria, p.Grupo, p.SucursalTrabajo, p.CentroCostos, p.FechaAlta, p.FechaAntiguedad, p. Plaza,p.ReportaA
      FROM #SDI s, Personal p
     WHERE s.Personal = p.Personal AND s.SDI <> p.SDI

    SELECT @Ok = 80030, @OkRef = ISNULL(@OkRef, '') + '<BR>- Modificaciones al SDI, en Recursos Humanos (por Confirmar)'
  END
  RETURN
END
GO

/**************** spNominaGenerarBaja ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGenerarBaja') and type = 'P') drop procedure dbo.spNominaGenerarBaja
GO             
CREATE PROCEDURE spNominaGenerarBaja
		   @Accion			char(20),
		   @Sucursal			int,
    		   @Empresa	      		char(5),
    		   @FechaEmision      		datetime,
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Modulo	      		char(5),
		   @ID				int,
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @FechaRegistro		datetime,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal		char(20),
    @Renglon		float,
    @RHID		int,
    @RHMov		char(20),
    @RHMovID		varchar(20),
    @IDGenerar		int,
    @ConsecutivoPorPeriodo	bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa	char(20),
    @ConsecutivoSucursalEsp	bit,
    @Ejercicio			int,
    @Periodo			int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov
   
  SELECT @Ejercicio = YEAR(@FechaRegistro), @Periodo = MONTH(@FechaRegistro)

  SELECT @RHMov = RHBajas
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @RHID = NULL
    SELECT @RHID = MIN(ID) FROM RH WHERE Mov = @RHMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END

    IF @RHID IS NOT NULL
    BEGIN
      SELECT @RHMov = Mov, @RHMovID = MovID FROM RH WHERE ID = @RHID
      EXEC spRH @RHID, 'RH', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @RHMov, @RHMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
    END
  END ELSE
  BEGIN
    INSERT RH (Sucursal, SucursalOrigen, Empresa,  Mov,    FechaEmision,  Proyecto,  Usuario,  Moneda,     TipoCambio,     OrigenTipo, Origen, OrigenID, Estatus)
       VALUES (@Sucursal, @Sucursal,     @Empresa, @RHMov, @FechaEmision, @Proyecto, @Usuario, @MovMoneda, @MovTipoCambio, @Modulo,    @Mov,   @MovID,   'CONFIRMAR')
    SELECT @RHID = SCOPE_IDENTITY()

    SELECT @Renglon = 0
    DECLARE crGenerarBaja CURSOR FOR
     SELECT DISTINCT d.Personal
       FROM NominaD d
      WHERE ID = @ID AND NULLIF(RTRIM(d.Personal), '') IS NOT NULL

    OPEN crGenerarBaja
    FETCH NEXT FROM crGenerarBaja INTO @Personal
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0
        INSERT RHD (
               ID,    Renglon,  Personal, SueldoDiario, SDI, TipoContrato, VencimientoContrato, PeriodoTipo, Jornada, TipoSueldo, Puesto, Departamento, Categoria, Grupo, SucursalTrabajo, CentroCostos, FechaAlta, FechaAntiguedad, Plaza)
        SELECT @RHID, @Renglon, Personal, SueldoDiario, SDI, TipoContrato, VencimientoContrato, PeriodoTipo, Jornada, TipoSueldo, Puesto, Departamento, Categoria, Grupo, SucursalTrabajo, CentroCostos, FechaAlta, FechaAntiguedad, Plaza
          FROM Personal
         WHERE Personal = @Personal

      END
      FETCH NEXT FROM crGenerarBaja INTO @Personal
    END  -- While
    CLOSE crGenerarBaja
    DEALLOCATE crGenerarBaja

    EXEC spRH @RHID, 'RH', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @RHMov, @RHMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @RHID IS NOT NULL
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'RH', @RHID, @RHMov, @RHMovID, @Ok OUTPUT
  RETURN
END
GO

/**************** spNominaBajaVacaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaBajaVacaciones') and type = 'P') drop procedure dbo.spNominaBajaVacaciones
GO             
CREATE PROCEDURE spNominaBajaVacaciones
		   @Accion				char(20),
		   @Sucursal			int,
   		   @Empresa	      		char(5),
   		   @FechaEmision      	datetime,
   	 	   @Proyecto	      	varchar(50),
   		   @Usuario	      		char(10),
   		   @Modulo	      		char(5),
		   @ID					int,
   		   @Mov	  	      		char(20),
   		   @MovID             	varchar(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @FechaRegistro		datetime,
   		   @Ok                	int          OUTPUT,
   		   @OkRef             	varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NomID						int,
    @NomMov						char(20),
    @NomMovID					varchar(20),
    @IDGenerar					int,
    @ConsecutivoPorPeriodo		bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa		char(20),
    @ConsecutivoSucursalEsp		bit,
    @Ejercicio					int,
    @Periodo					int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  SELECT @Ejercicio = YEAR(@FechaRegistro), @Periodo = MONTH(@FechaRegistro)

  SELECT @NomMov = NomVacacionesTomadas
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @NomID = NULL
    SELECT @NomID = MIN(ID) FROM Nomina WHERE Mov = @NomMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END

    IF @NomID IS NOT NULL      
      EXEC spNomina @NomID, 'NOM', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  BEGIN
    INSERT Nomina (Sucursal,  SucursalOrigen, Empresa,  Mov,     FechaEmision,  Proyecto,  Usuario,  Moneda,     TipoCambio,     OrigenTipo, Origen, OrigenID, Estatus)
           VALUES (@Sucursal, @Sucursal,      @Empresa, @NomMov, @FechaEmision, @Proyecto, @Usuario, @MovMoneda, @MovTipoCambio, @Modulo,    @Mov,   @MovID,   'CONFIRMAR')
    SELECT @NomID = SCOPE_IDENTITY()

    INSERT NominaD (ID,  Renglon, Personal, Modulo, Cantidad, FechaD)
    SELECT @NomID, MIN(d.Renglon), d.Personal, 'NOM', v.Vacaciones, @FechaEmision
      FROM NominaD d, PersonalVacaciones v
     WHERE v.Empresa = @Empresa AND d.Personal = v.Personal AND d.ID = @ID AND NULLIF(v.Vacaciones, 0) IS NOT NULL
     GROUP BY d.Personal, v.Vacaciones

    IF @@ROWCOUNT > 0
      EXEC spNomina @NomID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT --BUG18164
    ELSE 
      DELETE Nomina WHERE ID = @NomID
  END
  RETURN
END
GO


/**************** spNominaSugerirAumentoVacaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSugerirAumentoVacaciones') and type = 'P') drop procedure dbo.spNominaSugerirAumentoVacaciones
GO             
CREATE PROCEDURE spNominaSugerirAumentoVacaciones
		   @Accion				char(20),
		   @Sucursal			int,
		   @Empresa	      		char(5),
   		   @FechaEmision      	datetime,
   	 	   @Proyecto	      	varchar(50),
   		   @Usuario	      		char(10),
   		   @Modulo	      		char(5),
   		   @Mov	  	      		char(20),
   		   @MovID             	varchar(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @FechaRegistro		datetime,
		   @CfgAfectarAumentoVacaciones bit,	
   		   @Ok                			int          OUTPUT,
   		   @OkRef             			varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NomID						int,
    @NomMov						char(20),
    @NomMovID					varchar(20),
    @IDGenerar					int,
    @ConsecutivoPorPeriodo		bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa		char(20),
    @ConsecutivoSucursalEsp		bit,
    @Ejercicio					int,
    @Periodo					int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  SELECT @Ejercicio = YEAR(@FechaRegistro), @Periodo = MONTH(@FechaRegistro)

  SELECT @NomMov = NomAumentoVacaciones
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @NomID = NULL
    SELECT @NomID = MIN(ID) FROM Nomina WHERE Mov = @NomMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END
    IF @NomID IS NOT NULL      
      EXEC spNomina @NomID, 'NOM', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  BEGIN
    IF NOT EXISTS(SELECT * FROM #AumentoVacaciones) RETURN

    INSERT Nomina (Sucursal,  SucursalOrigen, Empresa,  Mov,     FechaEmision,  Proyecto,  Usuario,  Moneda,     TipoCambio,     OrigenTipo, Origen, OrigenID, Estatus)
           VALUES (@Sucursal, @Sucursal,      @Empresa, @NomMov, @FechaEmision, @Proyecto, @Usuario, @MovMoneda, @MovTipoCambio, @Modulo,    @Mov,   @MovID,   'CONFIRMAR')
    SELECT @NomID = SCOPE_IDENTITY()

    INSERT NominaD (ID,  Renglon, Personal, Modulo, Cantidad)
    SELECT       @NomID, Renglon, Personal, 'NOM',  Cantidad
      FROM #AumentoVacaciones

    IF @CfgAfectarAumentoVacaciones = 1
      EXEC spNomina @NomID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
    ELSE
      SELECT @Ok = 80030, @OkRef = ISNULL(@OkRef, '') + '<BR>- Aumento Vacaciones (por Confirmar)'
  END
  RETURN
END
GO

/**************** spNominaSugerirDisminucionVacaciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSugerirDisminucionVacaciones') and type = 'P') drop procedure dbo.spNominaSugerirDisminucionVacaciones
GO             
CREATE PROCEDURE spNominaSugerirDisminucionVacaciones
		   @Accion				char(20),
		   @Sucursal			int,
  		   @Empresa	      		char(5),
   		   @FechaEmision      	datetime,
   	 	   @Proyecto	      	varchar(50),
   		   @Usuario	      		char(10),
   		   @Modulo	      		char(5),
   		   @Mov	  	      		char(20),
   		   @MovID             	varchar(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @FechaRegistro		datetime,
		   @CfgAfectarDisminucionVacaciones bit,	
   		   @Ok                	int          OUTPUT,
   		   @OkRef             	varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NomID						int,
    @NomMov						char(20),
    @NomMovID					varchar(20),
    @ConDismVac					varchar(50),
    @IDGenerar					int,
    @ConsecutivoPorPeriodo		bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa		char(20),
    @ConsecutivoSucursalEsp		bit,
    @Ejercicio					int,
    @Periodo					int

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  SELECT @Ejercicio = YEAR(@FechaRegistro), @Periodo = MONTH(@FechaRegistro)

  SELECT @NomMov = NomVacacionesTomadas
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @ConDismVac = NomConceptoDisminuirVacaciones
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @NomID = NULL
    SELECT @NomID = MIN(ID) FROM Nomina WHERE Mov = @NomMov AND OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END
    IF @NomID IS NOT NULL      
      EXEC spNomina @NomID, 'NOM', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE
  BEGIN
    IF NOT EXISTS(SELECT * FROM #DisminucionVacaciones) RETURN

    INSERT Nomina (Sucursal,  SucursalOrigen, Empresa,  Mov,     FechaEmision,  Proyecto,  Usuario,  Moneda,     TipoCambio,     OrigenTipo, Origen, OrigenID, Estatus)
           VALUES (@Sucursal, @Sucursal,      @Empresa, @NomMov, @FechaEmision, @Proyecto, @Usuario, @MovMoneda, @MovTipoCambio, @Modulo,    @Mov,   @MovID,   'CONFIRMAR')
    SELECT @NomID = SCOPE_IDENTITY()
    INSERT NominaD (ID,  Renglon, Personal, Modulo,  Cantidad, Concepto, FechaD)
    SELECT       @NomID, Renglon, Personal, 'NOM',  Cantidad, @NomMov, FechaD
      FROM #DisminucionVacaciones
    IF @CfgAfectarDisminucionVacaciones = 1
    BEGIN
      EXEC spNomina @NomID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @NomMov, @NomMovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000 SELECT @Ok = 80030, @OkRef = ISNULL(@OkRef, '') + '<BR>- '+RTRIM(@NomMov)+' '+RTRIM(@NomMovID)+'(Concluido)'
    END
    ELSE
      SELECT @Ok = 80030, @OkRef = ISNULL(@OkRef, '') + '<BR>- Disminución Vacaciones (por Confirmar)'
  END
  RETURN
END
GO

/**************** spNominaCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaCancelar') and type = 'P') drop procedure dbo.spNominaCancelar
GO             
CREATE PROCEDURE spNominaCancelar
		   @ID					int,
  		   @Mov	  	      		char(20),
   		   @MovID             	varchar(20),
   		   @Usuario	      		char(10),
		   @FechaRegistro		datetime,
   		   @Ok                	int          OUTPUT,
   		   @OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DestinoID					int,
    @IDGenerar					int,
    @Empresa					varchar(5),
    @Sucursal					int,
    @Ejercicio					int,
    @Periodo					int,
    @ConsecutivoPorPeriodo		bit,
    @ConsecutivoPorEjercicio	bit,
    @ConsecutivoPorEmpresa		char(20),
    @ConsecutivoSucursalEsp		bit

  SELECT @ConsecutivoPorPeriodo   = ConsecutivoPorPeriodo,
         @ConsecutivoPorEjercicio = ConsecutivoPorEjercicio,
         @ConsecutivoPorEmpresa   = ISNULL(UPPER(ConsecutivoPorEmpresa), 'SI'),
         @ConsecutivoSucursalEsp  = ISNULL(ConsecutivoSucursalEsp, 0)
    FROM MovTipo
   WHERE Modulo = 'NOM'
     AND Mov    = @Mov

  SELECT @Empresa = Empresa, @Sucursal = Sucursal, @Ejercicio = Ejercicio, @Periodo = Periodo
    FROM Nomina
   WHERE ID = @ID
  DECLARE crNominaCancelar CURSOR LOCAL FOR
   SELECT ID 
     FROM Nomina 
    WHERE ID <> @ID AND OrigenTipo = 'NOM' AND Origen = @Mov AND OrigenID = @MovID 
      AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa  END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal END
  OPEN crNominaCancelar
  FETCH NEXT FROM crNominaCancelar INTO @DestinoID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      EXEC spNomina @DestinoID, 'NOM', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @Mov, @MovID, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crNominaCancelar INTO @DestinoID
  END  -- While
  CLOSE crNominaCancelar
  DEALLOCATE crNominaCancelar

  DECLARE crRHCancelar CURSOR LOCAL FOR
   SELECT ID 
     FROM RH 
    WHERE OrigenTipo = 'NOM' AND Origen = @Mov AND OrigenID = @MovID 
      AND Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
      AND Periodo   = CASE WHEN @ConsecutivoPorPeriodo   = 1    THEN @Periodo   ELSE Periodo   END
      AND Ejercicio = CASE WHEN @ConsecutivoPorEjercicio = 1    THEN @Ejercicio ELSE Ejercicio END
      AND Empresa   = CASE WHEN @ConsecutivoPorEmpresa   = 'SI' THEN @Empresa   ELSE Empresa   END
      AND Sucursal  = CASE WHEN @ConsecutivoSucursalEsp  = 1    THEN @Sucursal  ELSE Sucursal  END
  OPEN crRHCancelar
  FETCH NEXT FROM crRHCancelar INTO @DestinoID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      EXEC spRH @DestinoID, 'RH', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @Mov, @MovID, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    FETCH NEXT FROM crRHCancelar INTO @DestinoID
  END  -- While
  CLOSE crRHCancelar
  DEALLOCATE crRHCancelar

  RETURN
END
GO

/**************** spNominaDividirCantidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaDividirCantidad') and type = 'P') drop procedure dbo.spNominaDividirCantidad
GO             
CREATE PROCEDURE spNominaDividirCantidad
		   @Empresa			char(5),
		   @ID				int,
           @FechaEmision	datetime,
		   @MovTipo			char(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasHabiles		char(20),
    @Renglon			float,
    @Sucursal			int,
    @SucursalOrigen		int,
    @Personal			char(10),
    @Cantidad			money,
    @FechaD				datetime,
    @Referencia			varchar(50),
    @PeriodoTipo		varchar(50),
    @Jornada			varchar(20),
    @Inicio				datetime,
    @Fin				datetime,
    @Dias				int,
    @DiasNetos			int,
    @DiasNoHabiles		int,
    @DividirCatorcenas	bit, --JGD 06Julio2011 Ticket 4867 
	@FechaDHabil		datetime,
	@DiasNoHabilFechaD	int

  SELECT @DiasHabiles = UPPER(DiasHabiles)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @DividirCatorcenas = DividirCatorcenas 
    FROM MovTipo
   WHERE Modulo = 'NOM' AND Clave = @MovTipo

  CREATE TABLE #NominaD (Renglon float NULL, Personal char(10) COLLATE Database_Default NULL, Cantidad float NULL, FechaD datetime NULL, Referencia varchar(50) COLLATE Database_Default NULL, Sucursal int NULL, SucursalOrigen int NULL)

  SELECT @Renglon = 0.0
  DECLARE crNominaD CURSOR
     FOR SELECT d.Sucursal, d.SucursalOrigen, d.Personal, d.Cantidad, ISNULL(d.FechaD, @FechaEmision), d.Referencia, p.PeriodoTipo, p.Jornada
           FROM NominaD d, Personal p
          WHERE ID = @ID 
            AND d.Personal = p.Personal 
  OPEN crNominaD
  FETCH NEXT FROM crNominaD INTO @Sucursal, @SucursalOrigen, @Personal, @Cantidad, @FechaD, @Referencia, @PeriodoTipo, @Jornada
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      WHILE @Cantidad > 0
      BEGIN

        EXEC spExtraerFecha @FechaD OUTPUT

--JGD 06Julio2011 Ticket 4867
        IF @DividirCatorcenas = 1 AND (SELECT PeriodoTipo FROM Personal WHERE Personal = @Personal) LIKE 'CATORCENAL%' 
          EXEC spPeriodoDACatorcena @FechaD, @Fin OUTPUT
        ELSE
          EXEC spPeriodoDA @PeriodoTipo, @FechaD, @Inicio OUTPUT, @Fin OUTPUT, @Empresa = @Empresa
--Fin JGD 06Julio2011 Ticket 4867

--        EXEC spPeriodoDA @PeriodoTipo, @FechaD, @Inicio OUTPUT, @Fin OUTPUT, @Empresa = @Empresa
        SELECT @Dias = DATEDIFF(day, @FechaD, @Fin)
        IF @PeriodoTipo LIKE 'QUINCENAL%' OR @PeriodoTipo LIKE 'DECENAL' OR @PeriodoTipo LIKE 'CATORCENAL%' SELECT @Dias = @Dias + 1

        IF @MovTipo IN ('NOM.CDH', 'NOM.VT')
        BEGIN
          SELECT @FechaDHabil = @FechaD
          EXEC spRecorrerDiaHabilJornada @Empresa, @FechaDHabil OUTPUT, @Jornada
          SELECT @DiasNoHabilFechaD = DATEDIFF(day, @FechaD, @FechaDHabil)
          SELECT @FechaD = @FechaDHabil

          EXEC spDiasNoHabiles @FechaD, @Fin, @DiasHabiles, 0, @Jornada, @DiasNoHabiles OUTPUT

          SELECT @DiasNetos = @Dias - @DiasNoHabiles - @DiasNoHabilFechaD
        END ELSE
          SELECT @DiasNetos = @Dias

        IF @DiasNetos > @Cantidad 
          SELECT @DiasNetos = @Cantidad, @Cantidad = 0
        ELSE SELECT @Cantidad = @Cantidad - @DiasNetos

        SELECT @Renglon = @Renglon + 2048.0
        INSERT #NominaD (Renglon,  Personal,  Cantidad,   FechaD,  Referencia,  Sucursal,  SucursalOrigen) 
                 VALUES (@Renglon, @Personal, @DiasNetos, @FechaD, @Referencia, @Sucursal, @SucursalOrigen)
        IF @PeriodoTipo LIKE 'QUINCENAL%' OR @PeriodoTipo LIKE 'CATORCENAL%'
          SELECT @FechaD = DATEADD(day, 1, @Fin) 
        ELSE
          SELECT @FechaD = DATEADD(day, @Dias, @FechaD) 
      END
    END
    FETCH NEXT FROM crNominaD INTO @Sucursal, @SucursalOrigen, @Personal, @Cantidad, @FechaD, @Referencia, @PeriodoTipo, @Jornada
  END  -- While
  CLOSE crNominaD
  DEALLOCATE crNominaD

  DELETE NominaD WHERE ID = @ID

  INSERT NominaD (ID, Renglon,  Personal,  Cantidad, FechaD,  Referencia,  Sucursal,  SucursalOrigen)
  SELECT @ID, Renglon,  Personal,  Cantidad, FechaD,  Referencia,  Sucursal,  SucursalOrigen
    FROM #NominaD
   WHERE Cantidad > 0
  RETURN
END
GO

/**************** spNominaAfectarGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAfectarGasto') and type = 'P') drop procedure dbo.spNominaAfectarGasto
GO             
CREATE PROCEDURE dbo.spNominaAfectarGasto
           @ID					int,
           @GastoID				int,
           @GastoMov			char(20),
           @Acreedor			char(10),
           @Vencimiento			datetime,
           @CfgGastoUENDetalle  bit,
           @GastoUEN			int,
           @CentroCostos		VARCHAR(9),
           @NomAuto				bit
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto			varchar(50), 
    @Referencia			varchar(50), 
    @ContUso			varchar(20),
    @UEN				int,
    @Proyecto			varchar(50),
    @Actividad			varchar(50),
    @Importe			money,
    @Renglon			float,
    @Impuestos			float,
    @Retencion			float,
    @Retencion2			float,
    @Retencion3			float,
    @TieneRetencion		bit,
    @ClavePresupuestal	varchar(50) --REQ 13451

  SELECT @Renglon = 0.0, @TieneRetencion = 0

  IF @NomAuto = 0
  BEGIN
    IF @CfgGastoUENDetalle = 1
      DECLARE crNominaGastoD CURSOR FOR
       SELECT d.Concepto, /*d.Referencia,*/ d.ContUso, @GastoUEN, NULLIF(p.Proyecto, ''), SUM(d.Importe), NULLIF(p.Actividad, ''), P.CentroCostos, d.ClavePresupuestal --REQ 13451
         FROM NominaD d
         LEFT OUTER JOIN Personal p ON p.Personal = d.Personal
        WHERE d.ID = @ID AND d.Modulo = 'GAS' AND d.Movimiento = @GastoMov AND d.Cuenta = @Acreedor AND d.FechaA = @Vencimiento AND d.UEN = @GastoUEN
        GROUP BY d.Concepto, /*d.Referencia,*/ d.ContUso, p.Proyecto, p.Actividad, P.CentroCostos, d.ClavePresupuestal --REQ 13451
    ELSE
      DECLARE crNominaGastoD CURSOR FOR
       SELECT d.Concepto, /*d.Referencia,*/ d.ContUso, d.UEN, NULLIF(p.Proyecto, ''), SUM(d.Importe), NULLIF(p.Actividad, ''), P.CentroCostos, d.ClavePresupuestal --REQ 13451
         FROM NominaD d
         LEFT OUTER JOIN Personal p ON p.Personal = d.Personal
        WHERE d.ID = @ID AND d.Modulo = 'GAS' AND d.Movimiento = @GastoMov AND d.Cuenta = @Acreedor AND d.FechaA = @Vencimiento
        GROUP BY d.Concepto, /*d.Referencia,*/ d.ContUso, d.UEN, p.Proyecto, p.Actividad, P.CentroCostos, d.ClavePresupuestal --REQ 13451
  END ELSE 
  BEGIN
    IF @CfgGastoUENDetalle = 1
      DECLARE crNominaGastoD CURSOR FOR
       SELECT d.Concepto/*, d.Referencia*/, d.ContUso, @GastoUEN, NULLIF(p.Proyecto, ''), SUM(d.Importe), NULLIF(p.Actividad, ''), P.CentroCostos, d.ClavePresupuestal --REQ 13451
         FROM NominaD d
         LEFT OUTER JOIN Personal p ON p.Personal = d.Personal 
         LEFT OUTER JOIN NominaConcepto c ON c.NominaConcepto = d.NominaConcepto -- agregue esto para buscar el modulomov
        WHERE d.ID = @ID AND (d.Modulo = 'GAS' or c.GenerarEstadisticaGas=1) AND (c.ModuloMov = @GastoMov or  (c.GenerarEstadisticaGas=1 and @GastoMov='ESTADISTICA') )
          AND d.Cuenta = @Acreedor AND d.FechaA = @Vencimiento AND d.UEN = @GastoUEN 
          AND ISNULL(d.Importe,0) <> 0
         -- AND d.Referencia = @ReferenciaD
            AND P.CentroCostos = @CentroCostos
        GROUP BY d.Concepto/*, d.Referencia*/, d.ContUso, p.Proyecto, p.Actividad, P.CentroCostos, d.ClavePresupuestal --REQ 13451
    ELSE
      DECLARE crNominaGastoD CURSOR FOR
       SELECT d.Concepto/*, d.Referencia*/, d.ContUso, d.UEN, NULLIF(p.Proyecto, ''), SUM(d.Importe), NULLIF(p.Actividad, ''), P.CentroCostos, d.ClavePresupuestal --REQ 13451
         FROM NominaD d
         LEFT OUTER JOIN Personal p ON p.Personal = d.Personal
         LEFT OUTER JOIN NominaConcepto c ON c.NominaConcepto = d.NominaConcepto -- agregue esto para buscar el modulomov
        WHERE d.ID = @ID AND  (d.Modulo = 'GAS' or c.GenerarEstadisticaGas=1) AND (c.ModuloMov = @GastoMov or  (c.GenerarEstadisticaGas=1 and @GastoMov='ESTADISTICA') ) AND d.Cuenta = @Acreedor AND d.FechaA = @Vencimiento AND ISNULL(d.Importe,0) <> 0.0  
          --AND d.Referencia = @ReferenciaD
          AND P.CentroCostos = @CentroCostos
        GROUP BY d.Concepto/*, d.Referencia*/, d.ContUso, d.UEN, p.Proyecto, p.Actividad,  P.CentroCostos, d.ClavePresupuestal --REQ 13451
  END
  OPEN crNominaGastoD
  FETCH NEXT FROM crNominaGastoD INTO @Concepto/*, @Referencia*/, @ContUso, @UEN, @Proyecto, @Importe, @Actividad, @CentroCostos, @ClavePresupuestal --REQ 13451
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN

      SELECT @Renglon = @Renglon + 2048.0
      SELECT @Impuestos = NULL, @Retencion = NULL, @Retencion2 = NULL, @Retencion3 = NULL
      SELECT @Impuestos = Impuestos, @Retencion = Retencion, @Retencion2 = Retencion2, @Retencion3 = Retencion3 
        FROM Concepto 
       WHERE Modulo = 'GAS' AND Concepto = @Concepto
      IF NULLIF(@Retencion, 0) IS NOT NULL OR NULLIF(@Retencion2, 0) IS NOT NULL OR NULLIF(@Retencion3, 0) IS NOT NULL SELECT @TieneRetencion = 1
      SELECT @Impuestos  = @Importe * (@Impuestos  / 100),
             @Retencion  = @Importe * (@Retencion  / 100),
             @Retencion2 = @Importe * (@Retencion2 / 100),
             @Retencion3 = @Importe * (@Retencion3 / 100)
      INSERT GastoD (ID,       Renglon,  RenglonSub, Concepto,  Cantidad, Precio,   Importe,  Referencia,  ContUso,  UEN,             Proyecto,  Impuestos,  Retencion,  Retencion2,  Retencion3,   Actividad, fecha,        ClavePresupuestal) --REQ 13451
             VALUES (@GastoID, @Renglon, 0,          @Concepto, 1,        @Importe, @Importe, @Referencia, @ContUso, NULLIF(@UEN, 0), @Proyecto, @Impuestos, @Retencion, @Retencion2, @Retencion3, @Actividad, @Vencimiento, @ClavePresupuestal) --REQ 13451

-- spAfectar 'NOM', 1689, 'AFECTAR', 'Todo', NULL, 'INTELISIS', @Estacion =100
-- select * from acredor
    END    
    FETCH NEXT FROM crNominaGastoD INTO @Concepto/*, @Referencia*/, @ContUso, @UEN, @Proyecto, @Importe, @Actividad, @CentroCostos, @ClavePresupuestal --REQ 13451
  END  -- While
  CLOSE crNominaGastoD
  DEALLOCATE crNominaGastoD
  UPDATE Gasto SET TieneRetencion = @TieneRetencion WHERE ID = @GastoID AND TieneRetencion <> @TieneRetencion


  RETURN
END  
GO

/**************** spNominaAfectarCxc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAfectarCxc') and type = 'P') drop procedure dbo.spNominaAfectarCxc
GO             
CREATE PROCEDURE spNominaAfectarCxc
				@ID                		int,
				@Accion					char(20),
				@Empresa	      		char(5),
				@Sucursal				int,
				@Usuario				char(10),
				@FechaRegistro			datetime,
				@Modulo	      			char(5),
				@Mov	  	      		char(20),
				@MovID             		varchar(20),
				@MovTipo     			char(20),
				@MovMoneda				char(10),
				@MovTipoCambio			float,
				@MovAplicacionNomina	varchar(20),
				@Cliente				char(10),
				@ReferenciaD			varchar(50),
				@Importe				money,
				@Ok                		int          OUTPUT,
				@OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @AplicacionID		int,
    @AplicacionMovID	varchar(20),
    @CxcID 				int,
    @CxcMov 			varchar(20), 
    @CxcMovID 			varchar(20),	
    @CxcTipoCambio		float,
    @Impuestos			money 

  IF @Accion = 'CANCELAR' OR (@MovTipo = 'NOM.NC' AND @Accion <> 'CANCELAR')
  BEGIN
    SELECT @AplicacionID = ID, @AplicacionMovID = MovID
      FROM Cxc 
     WHERE Empresa = @Empresa AND Cliente = @Cliente AND Mov = @MovAplicacionNomina AND Referencia = @ReferenciaD AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    IF @AplicacionID IS NOT NULL
    BEGIN
      EXEC spAfectar 'CXC', @AplicacionID, 'CANCELAR', 'TODO', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    END
  END ELSE 
  BEGIN
    SELECT @CxcID = ID, @CxcMov = Mov, @CxcMovID = MovID, @CxcTipoCambio = TipoCambio
      FROM Cxc 
     WHERE Empresa = @Empresa AND Cliente = @Cliente AND @ReferenciaD = RTRIM(Mov) + ' ' + RTRIM(MovID) AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    IF @CxcID IS NOT NULL
    BEGIN
      EXEC @AplicacionID = spAfectar 'CXC', @CxcID, 'GENERAR', 'TODO', @MovAplicacionNomina, @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @Ok IS NULL
      BEGIN
        SELECT @Importe = @Importe*@MovTipoCambio/@CxcTipoCambio, @Impuestos = 0.0
        UPDATE CxcD SET Importe = @Importe WHERE ID = @AplicacionID
--        SELECT @Impuestos = ISNULL(SUM(d.Importe*a.IVAFiscal), 0.0) FROM CxcD d, CxcAplica a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @AplicacionID
        SELECT @Impuestos = ISNULL(SUM(d.Importe*a.IVAFiscal), 0.0) FROM CxcD d, Cxc a WHERE d.Aplica = a.Mov AND d.AplicaID = a.MovID AND a.Empresa = @Empresa AND d.id = @AplicacionID AND UPPER(Estatus) NOT IN ('SINAFECTAR', 'CANCELADO')

        UPDATE Cxc SET Importe = @Importe - @Impuestos, Impuestos = @Impuestos, Referencia = @ReferenciaD WHERE ID = @AplicacionID
        EXEC spAfectar 'CXC', @AplicacionID, 'AFECTAR', 'TODO', @Usuario = @Usuario, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        SELECT @AplicacionMovID = MovID FROM Cxc WHERE ID = @AplicacionID
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      END
    END
  END

  IF @AplicacionID IS NOT NULL
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'CXC', @AplicacionID, @MovAplicacionNomina, @AplicacionMovID, @Ok OUTPUT
  RETURN
END  
GO

/**************** spNominaMatarIncidencia ****************/ 
if exists (select * from sysobjects where id = object_id('dbo.spNominaMatarIncidencia') and type = 'P') drop procedure dbo.spNominaMatarIncidencia
GO             
CREATE PROCEDURE spNominaMatarIncidencia
			@Empresa	char(5),
			@Sucursal	int,
			@Modulo		char(5),
			@ID		int,
			@Mov		varchar(20),
			@MovID		varchar(20),
			@MovTipo	varchar(20), 
			@Accion		varchar(20), 
			@Cantidad	float,
			@Importe	money, 
			@MovTipoCambio	float,
			@RID		int, 
   			@NomAutoTipo	varchar(50),
			@Ok 		int 		OUTPUT, 
			@OkRef 		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsCancelacion 		bit,
    @IncidenciaID		int,
    @IncidenciaMov		varchar(20),
    @IncidenciaMovID		varchar(20),
    @Numero			int,
    @Estatus			varchar(15),
    @Saldo			money,
    @TipoCambio			float,
    @Tolerancia			float

  IF @MovTipo = 'NOM.NC' OR @Accion = 'CANCELAR' SELECT @EsCancelacion = 1 ELSE SELECT @EsCancelacion = 0
  IF @MovTipo = 'NOM.NC' SELECT @Cantidad = -@Cantidad   

  SELECT @IncidenciaID = i.ID, @Estatus = i.Estatus, @IncidenciaMov = i.Mov, @IncidenciaMovID = i.MovID, @TipoCambio = i.TipoCambio,
         @Saldo = ISNULL(d.Saldo, 0.0), @Numero = d.Numero
    FROM IncidenciaD d
    JOIN Incidencia i ON i.ID = d.ID
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
   WHERE d.RID = @RID

  IF @EsCancelacion = 0
  BEGIN
    IF @Estatus <> 'PENDIENTE' OR (ROUND(@Importe*@MovTipoCambio, 2) > ROUND(@Saldo*@TipoCambio, 2))
      SELECT @Ok = 30680, @OkRef = 'Incidencia id=' + Convert(varchar, @IncidenciaID) + 'Importe'+ convert(varchar,ROUND(@Importe*@MovTipoCambio, 2))+'saldo'+convert(varchar,ROUND(@Saldo, 2))+'-'+convert(varchar,@RID  )
    ELSE
    BEGIN
      UPDATE IncidenciaD 
         SET CantidadPendiente = NULLIF(CantidadPendiente - @Cantidad, 0.0), 
             Saldo = NULLIF(Saldo - ((@Importe*@MovTipoCambio)/@TipoCambio), 0.0) 
       WHERE RID = @RID

      UPDATE IncidenciaD
         SET CantidadPendiente = CASE WHEN ABS(CantidadPendiente) < .05 THEN 0.0 ELSE CantidadPendiente END,
             Saldo = CASE WHEN ABS(Saldo) < .05 THEN 0.0 ELSE Saldo END
       WHERE RID = @RID

      IF NOT EXISTS(SELECT * FROM IncidenciaD WHERE ID = @IncidenciaID AND (NULLIF(ROUND(CantidadPendiente, 4), 0.0) IS NOT NULL OR NULLIF(ROUND(Saldo, 1), 0.0) IS NOT NULL))
        UPDATE Incidencia SET Estatus = 'CONCLUIDO', FechaConclusion = GETDATE() WHERE ID = @IncidenciaID
    END
  END ELSE
  BEGIN
    IF @Estatus = 'CANCELADO' 
      SELECT @Ok = 30690
    ELSE
    BEGIN
      UPDATE IncidenciaD 
         SET CantidadPendiente = ISNULL(CantidadPendiente, 0.0) + @Cantidad, 
             Saldo = ISNULL(Saldo, 0.0) + ((CASE WHEN @MovTipo ='NOM.NC' THEN -@Importe ELSE @Importe END * @MovTipoCambio)/@TipoCambio)
       WHERE RID = @RID

      UPDATE IncidenciaD
         SET CantidadPendiente = CASE WHEN ABS(CantidadPendiente) < .05 THEN 0.0 ELSE CantidadPendiente END, 
             Saldo = CASE WHEN ABS(Saldo) < .05 THEN 0.0 ELSE Saldo END
       WHERE RID = @RID

      IF @Estatus = 'CONCLUIDO' AND EXISTS(SELECT * FROM IncidenciaD WHERE ID = @IncidenciaID AND (NULLIF(ROUND(Cantidad, 4), 0.0) IS NOT NULL OR NULLIF(ROUND(Saldo, 1), 0.0) IS NOT NULL))
        UPDATE Incidencia SET Estatus = 'PENDIENTE', FechaConclusion = NULL WHERE ID = @IncidenciaID 
    END
  END

  IF @Ok IS NOT NULL 
    SELECT @OkRef = @IncidenciaMov+' '+@IncidenciaMovID + ', Importe '+ convert(varchar,ROUND(@Importe*@MovTipoCambio, 2))+', Saldo '+convert(varchar,ROUND(@Saldo*@MovTipoCambio, 2))+' ('+convert(varchar, @Numero)+')'
  ELSE
    EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INC', @IncidenciaID, @IncidenciaMov, @IncidenciaMovID, @Ok OUTPUT
  RETURN
END
GO

/**************** spNominaAfectar ***************cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAfectar') and type = 'P') drop procedure dbo.spNominaAfectar
GO             
CREATE PROCEDURE dbo.spNominaAfectar
   	   @ID                	          int,
		   @Accion			                  char(20),
   	   @Empresa	      	              char(5),
   	   @Modulo	      	              char(5),
   	   @Mov	        	                char(20),
   	   @MovID             	          varchar(20)	OUTPUT,
   	   @MovTipo     	                char(20),
		   @MovMoneda			                char(10),
		   @MovTipoCambio		              float,
		   @Condicion			                varchar(50),
		   @PeriodoTipo			              varchar(50), 
		   @MovFechaD			                datetime, 
		   @MovFechaA			                datetime,
    	 @FechaEmision      	          datetime,
		   @FechaOrigen			              datetime,
    	 @FechaAfectacion               datetime,
		   @FechaConclusion		            datetime,
       @Proyecto	      	            varchar(50),
       @Concepto	                    varchar(50),
       @Usuario	                      char(10),
       @Autorizacion                  char(10),
       @DocFuente	                    int,
       @Observaciones                 varchar(255),
       @Estatus                       char(15),
       @EstatusNuevo	                char(15),
       @FechaRegistro                 datetime,
       @Ejercicio	                    int,
       @Periodo	                      int,
		   @UsaImporte			              bit, 
		   @UsaCantidad			              bit, 
		   @UsaPorcentaje		              bit, 
		   @UsaMonto			                bit,
		   @UsaFechas			                bit,
		   @Conexion			                bit,
		   @SincroFinal			              bit,
		   @Sucursal			                int,
		   @SucursalDestino		            int,
		   @SucursalOrigen		            int,
       @SugerirAumentoVacaciones	    bit,
       @CfgAfectarAumentoVacaciones	  bit,
       @CfgConceptoAumentoVacaciones  varchar(50),		    
       @SugerirDisminucionVacaciones    bit, 
       @CfgAfectarDisminucionVacaciones    bit, 
       @CfgConceptoDisminucionVacaciones  varchar(50), 
       @SugerirSDI			              bit,
       @CfgConceptoSDI		            varchar(50),
	   @MovAplicacionNomina		        varchar(20),
	   @CfgContX			                bit,
	   @CfgContXGenerar		            char(20),
	   @GenerarPoliza		              bit,
       @GenerarMov			              char(20),
	   @IDGenerar			                int OUTPUT,	
       @GenerarMovID	                varchar(20) OUTPUT,
       @Ok                	          int OUTPUT,
       @OkRef             	          varchar(255) OUTPUT
WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Renglon			       float,
    @Personal			       char(10),
    @Importe			       money,
    @Impuestos			     money,
    @Porcentaje			     float,
    @Cantidad			       money,
    @FechaD			         datetime,
    @FechaA			         datetime,
    @Cuenta			         char(10), 
    @ModuloD			       char(5), 
    @MovimientoD		     varchar(20), 
    @ConceptoD			     varchar(50), 
    @ReferenciaD		     varchar(50),
    @FormaPago			     varchar(50),
    @ReferenciaActual		 varchar(50),
    @DineroMov			     char(20),
    @DineroBeneficiario	 varchar(100),
    @PersonalUltimoPago	 datetime,
    @GastoMov			       char(20),
    @GastoMovID			     varchar(20),
    @GastoID			       int,    
    @CxCondicion		     varchar(50),
    @SumaPercepciones		 money,
    @SumaDeducciones		 money,
    @EsCargo			       bit,
    @NomXID			         int,
    @Clase			         varchar(50),
    @SubClase			       varchar(50),
    @GastoClase			     varchar(50),
    @GastoSubClase		   varchar(50),
    @CfgGastoUENDetalle	 bit,
    @GastoUEN			       int,
    @IncidenciaID		     int,
    @Generar			       bit,
    @GenerarAfectado		 bit,
    @GenerarModulo		   char(5),
    @GenerarMovTipo		   char(20),
    @GenerarEstatus		   char(15),
    @GenerarPeriodo 		 int, 
    @GenerarEjercicio 	 int,
    @FechaCancelacion		 datetime,
    @GenerarAccion		   char(20),
    @ProcesarIncidencias bit,
    @GenerarBaja		     bit,
    @DividirCantidades	 bit, 
    @DineroConcepto		   varchar(50),
    @PersonalFechaD		   datetime, 
    @PersonalFechaA		   datetime,
    @Origen              varchar(20),
    @NomAuto			       bit,
    @NomAutoTipo 		     varchar(50),
    @Beneficiario		     varchar(50),
    @Valor               varchar(50),
    @SucursalTrabajo     int,
    @Categoria           varchar(50),
    @Puesto              varchar(50),
    @UEN                 int,
    @CentroCostos		varchar(20)	,
    @FechaInicioV datetime,
	--BUG22105
	@PersonalAnt		varchar(10)     	
  
    
  -- Inicializar Variables
  SELECT @Generar = 0,
         @GenerarAfectado = 0,
         @IDGenerar = NULL,
         @GenerarModulo = NULL,
         @GenerarMovID = NULL,
         @GenerarMovTipo = NULL,
         @GenerarEstatus = 'SINAFECTAR',
         @SumaPercepciones = 0.0,
         @SumaDeducciones = 0.0

  SELECT @NomXID = MIN(ID) FROM NomX WHERE NomMov = @Mov AND Estatus = 'ACTIVA' AND Empresa IN ('(Todas)', @Empresa)
  SELECT @GastoClase = GastoClase,
         @GastoSubClase = GastoSubClase
    FROM NomX
   WHERE ID = @NomXID 

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @SugerirAumentoVacaciones = 1 AND @Accion <> 'CANCELAR' 
    CREATE TABLE #AumentoVacaciones (Renglon float NULL, Personal char(10) NULL, Cantidad float NULL)

  IF @SugerirDisminucionVacaciones = 1 AND @Accion <> 'CANCELAR' 
    CREATE TABLE #DisminucionVacaciones (Renglon float NULL, Personal char(10) NULL, Cantidad float NULL, FechaD datetime NULL)

  IF @SugerirSDI = 1 AND @Accion <> 'CANCELAR' 
    CREATE TABLE #SDI (Renglon float NULL, Personal char(10) NULL, SDI money NULL)

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, @GenerarEstatus, 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @@ERROR <> 0 SELECT @Ok = 1
--    IF @Ok IS NULL 
--      EXEC spNominaCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  SELECT @ProcesarIncidencias = NomProcesarIncidencias,
        @GenerarBaja = NomGenerarBaja,
         @DividirCantidades = NomDividirCantidades,
         @NomAuto = ISNULL(NomAuto, 0),
         @NomAutoTipo = NomAutoTipo
    FROM MovTipo
   WHERE Modulo = @Modulo AND Mov = @Mov

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR')
      IF (SELECT Sincro FROM Version) = 1
        UPDATE NominaD SET Sucursal = @Sucursal WHERE ID = @ID AND (Sucursal <> @Sucursal )

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @EstatusNuevo = 'PROCESAR' AND @MovTipo IN ('NOM.CD', 'NOM.CDH', 'NOM.VT') AND @DividirCantidades = 1
      EXEC spNominaDividirCantidad @Empresa, @ID, @FechaEmision, @MovTipo

    IF @GenerarBaja = 1 AND @Accion <> 'CANCELAR' 
      EXEC spNominaBajaVacaciones @Accion, @Sucursal, @Empresa, @FechaOrigen, @Proyecto, @Usuario, @Modulo, 
    			          @ID, @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaRegistro,
			          @Ok OUTPUT, @OkRef OUTPUT
    SELECT @ReferenciaActual = RTRIM(@Mov)+' '+LTRIM(CONVERT(char, @MovID))
    IF @Accion = 'DESAFECTAR' 
      EXEC spMovDesafectar @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
    ELSE BEGIN
      DECLARE crNomina CURSOR
         FOR SELECT d.Renglon, NULLIF(RTRIM(d.Personal), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Cantidad, 0.0), d.FechaD, d.FechaA, 
                    NULLIF(RTRIM(d.Cuenta), ''), NULLIF(RTRIM(d.Modulo), ''), NULLIF(RTRIM(d.Movimiento), ''), NULLIF(RTRIM(d.Concepto), ''), NULLIF(RTRIM(d.Referencia), ''), NULLIF(RTRIM(d.FormaPago), ''), d.Porcentaje, d.IncidenciaID
               FROM NominaD d
              WHERE ID = @ID 

      OPEN crNomina
      FETCH NEXT FROM crNomina INTO @Renglon, @Personal, @Importe, @Cantidad, @FechaD, @FechaA, 
                                    @Cuenta, @ModuloD, @MovimientoD, @ConceptoD, @ReferenciaD, @FormaPago, @Porcentaje, @IncidenciaID
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          IF @MovTipo = 'NOM.DP' AND @Personal IS NOT NULL
            EXEC spNominaDevolucionPrestamo @Sucursal, @ID, @Accion, @Empresa, @Personal, @FechaD, @Importe, @Ok OUTPUT, @OkRef OUTPUT

          IF @NomAuto = 0 AND @Accion <> 'CANCELAR' AND @ModuloD = 'NOM' AND @ReferenciaD IS NOT NULL AND @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NC') AND @Personal IS NOT NULL AND UPPER(@MovimientoD) IN ('PERCEPCION', 'DEDUCCION') 
          BEGIN
            /*IF EXISTS (SELECT * FROM Nomina n, MovTipo mt WHERE Empresa = @Empresa AND RTRIM(Mov)+' '+RTRIM(MovID) = @ReferenciaD AND Estatus = 'PENDIENTE' AND mt.Modulo = 'NOM' AND mt.Clave = 'NOM.CA' AND mt.Mov = n.Mov)
            BEGIN*/
              IF UPPER(@MovimientoD) IN ('DEDUCCION', 'PERCEPCION')
                EXEC spNominaMatarReferencia @Sucursal, @ID, @Accion, @Empresa, @Personal, @ReferenciaD, @Importe, @Ok OUTPUT, @OkRef OUTPUT
              ELSE SELECT @Ok = 55370, @OkRef = @ReferenciaD
            /*END*/
          END

          IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC') 
          BEGIN
            IF @Personal IS NOT NULL 
            BEGIN
              IF @SugerirSDI = 1 AND @Accion <> 'CANCELAR' AND UPPER(@ConceptoD) = UPPER(@CfgConceptoSDI)
                INSERT #SDI (Renglon, Personal, SDI) VALUES (@Renglon, @Personal, @Importe)

              IF @SugerirAumentoVacaciones = 1 AND @Accion <> 'CANCELAR' AND UPPER(@ConceptoD) = UPPER(@CfgConceptoAumentoVacaciones)
                INSERT #AumentoVacaciones (Renglon, Personal, Cantidad) VALUES (@Renglon, @Personal, @Cantidad)
              
              IF @SugerirDisminucionVacaciones = 1 AND @Accion <> 'CANCELAR' AND UPPER(@ConceptoD) = UPPER(@CfgConceptoDisminucionVacaciones)
              BEGIN
                --SELECT @FechaInicioV = FechaD FROM NominaD d JOIN NominaCorrespondeLote c ON d.ID=c.ID WHERE c.IDNomina = @ID 
                INSERT #DisminucionVacaciones (Renglon, Personal, Cantidad, FechaD) VALUES (@Renglon, @Personal, @Cantidad, @MovFechaD)
              END
            END
            IF @IncidenciaID IS NOT NULL AND (@Cantidad <> 0.0 OR @Importe <> 0.0)
              EXEC spNominaMatarIncidencia @Empresa, @Sucursal, @Modulo, @ID, @Mov, @MovID, @MovTipo, @Accion, @Cantidad, @Importe, @MovTipoCambio, @IncidenciaID, @NomAutoTipo, @Ok OUTPUT, @OkRef OUTPUT
          END

          IF @MovTipo IN ('NOM.VA', 'NOM.VT')
          BEGIN
            IF @MovTipo = 'NOM.VA' SELECT @EsCargo = 1 ELSE SELECT @EsCargo = 0
            IF @Accion = 'CANCELAR' SELECT @EsCargo = ~@EsCargo
            EXEC spSaldo @Sucursal, @Accion, @Empresa, @Usuario, 'VAC', @MovMoneda, @MovTipoCambio, @Personal, NULL, NULL, NULL,
                         @Modulo, @ID, @Mov, @MovID, @EsCargo, NULL, @Cantidad, NULL,
                         @FechaAfectacion, @Ejercicio, @Periodo, @Mov, @MovID, 0, 0, 0,
  		         @Ok OUTPUT, @OkRef OUTPUT
          END

          IF @MovTipo IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
            UPDATE NominaD 
               SET CantidadPendiente = CASE @Accion WHEN 'CANCELAR' THEN NULL ELSE @Cantidad END 
             WHERE CURRENT OF crNomina

  	  ELSE
          IF @MovTipo IN ('NOM.P', 'NOM.PD', 'NOM.PI', 'NOM.D', 'NOM.CA') 
            UPDATE NominaD 
               SET CantidadPendiente = CASE WHEN @UsaCantidad = 0 THEN NULL WHEN @Accion = 'CANCELAR' THEN NULL ELSE @Cantidad END,
                   Saldo = CASE WHEN UPPER(@Condicion) = 'REPETIR' THEN @Importe * @Cantidad
                                WHEN UPPER(@Condicion) IN ('REPETIR SIEMPRE', 'REPETIR FECHAS', '% SUELDO') THEN NULL 
				WHEN @UsaCantidad = 1 AND UPPER(@Condicion) <> 'PRORRATEAR' THEN NULL 
                                WHEN @Accion = 'CANCELAR' THEN NULL ELSE @Importe END 
             WHERE CURRENT OF crNomina

          IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC') AND @ModuloD = 'CXC' AND @ReferenciaD IS NOT NULL
            EXEC spNominaAfectarCxc @ID, @Accion, @Empresa, @Sucursal, @Usuario, @FechaRegistro, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @MovAplicacionNomina, @Cuenta, @ReferenciaD, @Importe, @Ok OUTPUT, @OkRef OUTPUT

          IF UPPER(@MovimientoD) = 'PERCEPCION' SELECT @SumaPercepciones = @SumaPercepciones + @Importe ELSE
          IF UPPER(@MovimientoD) = 'DEDUCCION'  SELECT @SumaDeducciones  = @SumaDeducciones  + @Importe

          EXEC xpNominaAfectarDetalle @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
		   		      @Condicion, @PeriodoTipo, @MovFechaD, @MovFechaA, @FechaEmision, @FechaOrigen, @FechaAfectacion, @FechaConclusion,
				      @Usuario, @Estatus, @EstatusNuevo, @FechaRegistro, @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
                                      @Renglon, @Personal, @Importe, @Cantidad, @Ok OUTPUT, @OkRef OUTPUT
        END
        FETCH NEXT FROM crNomina INTO @Renglon, @Personal, @Importe, @Cantidad, @FechaD, @FechaA, 
                                      @Cuenta, @ModuloD, @MovimientoD, @ConceptoD, @ReferenciaD, @FormaPago, @Porcentaje, @IncidenciaID
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crNomina
      DEALLOCATE crNomina
    END

    IF @NomAuto = 0 AND @Accion = 'CANCELAR'
      EXEC spNominaMatarReferenciaCancelar @Sucursal, @ID, @Accion, @Empresa, @Ok OUTPUT, @OkRef OUTPUT

    -- Afectar Cxp y Cxc sin Referencia
    IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC')
    BEGIN
      DECLARE crNominaCx CURSOR FOR
       SELECT Personal.UEN, NominaD.Modulo, NominaD.Cuenta, NominaD.Concepto, NominaD.FechaA, NominaD.Porcentaje, SUM(NominaD.Importe), NominaD.Beneficiario
         FROM NominaD
         LEFT OUTER JOIN  Personal on Personal.Personal= Nominad.Personal
        WHERE NominaD.ID = @ID AND (NominaD.Modulo = 'CXP' OR (NominaD.Modulo = 'CXC' AND NULLIF(RTRIM(NominaD.Referencia), '') IS NULL))
        GROUP BY Personal.UEN, NominaD.Modulo, NominaD.Cuenta, NominaD.Concepto, NominaD.FechaA, NominaD.Porcentaje, NominaD.Beneficiario
        ORDER BY Personal.UEN, NominaD.Modulo, NominaD.Cuenta, NominaD.Concepto, NominaD.FechaA, NominaD.Porcentaje, NominaD.Beneficiario
      OPEN crNominaCx
      FETCH NEXT FROM crNominaCx INTO @UEN, @ModuloD, @Cuenta, @ConceptoD, @FechaA, @Porcentaje, @Importe, @Beneficiario
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          IF @FechaA IS NOT NULL SELECT @CxCondicion = '(Fecha)' ELSE SELECT @CxCondicion = NULL
          SELECT @Impuestos = @Importe * (NULLIF(@Porcentaje, 0.0)/100.0)
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, 
                           @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaEmision,  @ConceptoD, @Proyecto, @Usuario, @Autorizacion,
          	               @ReferenciaActual, @DocFuente, @Beneficiario, @FechaRegistro, @Ejercicio, @Periodo,
		                       @CxCondicion, @FechaA, @Cuenta, NULL, NULL, NULL, NULL, NULL,
		                       @Importe, @Impuestos, NULL, NULL,
                           NULL, NULL, NULL, NULL, NULL, NULL,
      			               @GenerarModulo OUTPUT, @GenerarMov OUTPUT, @GenerarMovID OUTPUT,
	   	                     @Ok OUTPUT, @OkRef OUTPUT,
			                     @ModuloEspecifico = @ModuloD
			    /*if @GenerarModulo = 'CXP' 
			    BEGIN
			      IF @UEN in('1','3')                 
			        UPDATE CXP set NOTA ='FIDE',  UEN = @UEN, Proyecto ='AC-1-08'   WHERE MOV = @GenerarMov AND MOVID = @GenerarMovID                
			      IF @UEN in('2','4','5')                 
			        UPDATE CXP set NOTA ='PFAEE', UEN = @UEN, Proyecto ='PFAEE-08'   WHERE MOV = @GenerarMov AND MOVID = @GenerarMovID                
			    END    */
        END
        FETCH NEXT FROM crNominaCx INTO @UEN, @ModuloD, @Cuenta, @ConceptoD, @FechaA, @Porcentaje, @Importe, @Beneficiario
      END  -- While
      CLOSE crNominaCx
      DEALLOCATE crNominaCx
    END

    -- Afectar Dinero
    IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC', 'NOM.PI', 'NOM.DP')
    BEGIN
      IF @MovTipo IN ('NOM.PI', 'NOM.DP')
      BEGIN
        DECLARE crNominaDinero CURSOR FOR
         SELECT ISNULL(nc.ModuloMov, d.Movimiento), d.Cuenta, NULLIF(RTRIM(d.Personal), ''), NULLIF(RTRIM(d.Beneficiario), ''), SUM(d.Importe), @Concepto
           FROM NominaD d
           LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
          WHERE d.ID = @ID
          GROUP BY ISNULL(nc.ModuloMov, d.Movimiento), d.Cuenta, d.Personal, d.Beneficiario 
      END ELSE
      BEGIN
        DECLARE crNominaDinero CURSOR FOR
         SELECT ISNULL(nc.ModuloMov, d.Movimiento), d.Cuenta, NULLIF(RTRIM(d.Personal), ''), NULLIF(RTRIM(d.Beneficiario), ''), SUM(Importe), d.Concepto
           FROM NominaD d
           LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
          WHERE d.ID = @ID AND d.Modulo = 'DIN'
          GROUP BY ISNULL(nc.ModuloMov, d.Movimiento), d.Cuenta, d.Personal, d.Beneficiario, d.Concepto
      END

      OPEN crNominaDinero
      FETCH NEXT FROM crNominaDinero INTO @DineroMov, @Cuenta, @Personal, @DineroBeneficiario, @Importe, @DineroConcepto
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
           IF @DineroBeneficiario IS NULL AND @Personal IS NOT NULL
             SELECT @DineroBeneficiario = ApellidoPaterno +' '+ ApellidoMaterno +' '+ Nombre FROM Personal WHERE Personal = @Personal

           EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                @FechaEmision, @DineroConcepto, @Proyecto, @Usuario, @Autorizacion, @ReferenciaActual, @DocFuente, @Observaciones, 1, 0,
                                @FechaRegistro, @Ejercicio, @Periodo, 
                                NULL, NULL, NULL,
                                NULL, @Cuenta, NULL, @Importe, NULL,
      		                      @DineroMov, @DineroBeneficiario, NULL,
		  		                      @GenerarMov OUTPUT, @GenerarMovID OUTPUT,
                                @Ok OUTPUT, @OkRef OUTPUT,
                                @ContactoEspecifico = @Personal
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        END
        FETCH NEXT FROM crNominaDinero INTO @DineroMov, @Cuenta, @Personal, @DineroBeneficiario, @Importe, @DineroConcepto
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crNominaDinero
      DEALLOCATE crNominaDinero
    END

    -- Afectar Gastos
    IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC')
    BEGIN
      IF @Accion = 'CANCELAR'
      BEGIN
        DECLARE crNominaGasto CURSOR FOR
         SELECT g.ID, g.Mov, g.MovID 
           FROM Gasto g
           JOIN MovFlujo mf ON mf.Empresa = @Empresa AND mf.OModulo = @Modulo AND mf.OID = @ID AND mf.DModulo = 'GAS' AND mf.DID = g.ID  
          WHERE g.Empresa = @Empresa AND g.OrigenTipo = @Modulo AND g.Origen = @Mov AND g.OrigenID = @MovID AND g.Estatus NOT IN ('SINAFECTAR', 'CANCELADO')
        OPEN crNominaGasto
        FETCH NEXT FROM crNominaGasto INTO @GastoID, @GastoMov, @GastoMovID
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
            EXEC spGasto @GastoID, 'GAS', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, @GastoID, @Ok OUTPUT, @OkRef OUTPUT

          FETCH NEXT FROM crNominaGasto INTO @GastoID, @GastoMov, @GastoMovID
        END  -- While
        CLOSE crNominaGasto
        DEALLOCATE crNominaGasto
      END ELSE 
      BEGIN
        SELECT @CfgGastoUENDetalle = GastoUENDetalle FROM EmpresaCfg2 WHERE Empresa = @Empresa
        IF @CfgGastoUENDetalle = 1
          DECLARE crNominaGasto CURSOR FOR
           SELECT CASE when nc.GenerarEstadisticaGas = 1 then 'ESTADISTICA' else  ISNULL(nc.ModuloMov, d.Movimiento) END, 
                  d.Referencia, d.Cuenta, d.FechaA, d.UEN, Personal.CentroCostos
             FROM NominaD d 
             LEFT OUTER JOIN PERSONAL ON D.PERSONAL=PERSONAL.PERSONAL
             LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
            WHERE d.ID = @ID AND (d.Modulo = 'GAS' or nc.GenerarEstadisticaGas = 1) 
            GROUP BY ISNULL(nc.ModuloMov, d.Movimiento),nc.GenerarEstadisticaGas, 
                   d.Referencia, d.Cuenta, d.FechaA, d.UEN, Personal.CentroCostos
        ELSE
          DECLARE crNominaGasto CURSOR FOR
           SELECT ISNULL(nc.ModuloMov, d.Movimiento), d.Referencia, d.Cuenta, d.FechaA, CONVERT(int, NULL), Personal.CentroCostos
             FROM NominaD d
             LEFT OUTER JOIN PERSONAL ON D.PERSONAL=PERSONAL.PERSONAL
             LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
            WHERE d.ID = @ID AND (d.Modulo = 'GAS' OR nc.GenerarEstadisticaGas = 1) 
            GROUP BY ISNULL(nc.ModuloMov, d.Movimiento), d.Referencia, d.Cuenta, d.FechaA, Personal.CentroCostos
        OPEN crNominaGasto
        FETCH NEXT FROM crNominaGasto INTO @GastoMov, @ReferenciaD, @Cuenta, @FechaA, @GastoUEN, @CentroCostos
        IF @@ERROR <> 0 SELECT @Ok = 1
        WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
        BEGIN
          IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
          BEGIN

            SELECT @Clase = @GastoClase, @SubClase = @GastoSubClase
                   
                  -- @clase ='FIDE', 'PFAEE'
                  -- @SubClase = 'Gastos Operativos' 
            
  
            EXEC xpNominaGastoClase @ID, @GastoMov, @ReferenciaD, @Cuenta, @FechaA, @GastoUEN, @Clase OUTPUT, @SubClase OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            INSERT Gasto (UltimoCambio, Sucursal,  SucursalOrigen, SucursalDestino, UEN,       OrigenTipo,  Origen,  OrigenID,  Empresa,  Usuario,  Estatus,      Mov,       Acreedor, FechaEmision, Moneda, TipoCambio, Observaciones, Condicion, Vencimiento, Clase,  SubClase,  fecharequerida)
                  SELECT GETDATE(),     @Sucursal, @Sucursal,      @Sucursal,       @GastoUEN, @Modulo,     Mov,     MovID,     @Empresa, @Usuario, 'SINAFECTAR', @GastoMov, @Cuenta,  FechaEmision, Moneda, TipoCambio, Observaciones, '(Fecha)', @FechaA,     @Clase, @SubClase, fechaemision
                    FROM Nomina
                   WHERE ID = @ID 
            SELECT @GastoID = SCOPE_IDENTITY()
            EXEC spNominaAfectarGasto @ID, @GastoID, @GastoMov, @Cuenta, @FechaA, @CfgGastoUENDetalle, @GastoUEN, @Centrocostos, @NomAuto
             --ojo sp_helptext spNominaAfectarGasto
            IF @GastoID IS NOT NULL AND @Ok IS NULL
            BEGIN
              EXEC spGasto @GastoID, 'GAS', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @GastoMov, @GastoMovID OUTPUT, @GastoID, @Ok OUTPUT, @OkRef OUTPUT
              IF @Ok IS NULL
                EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'GAS', @GastoID, @GastoMov, @GastoMovID, @Ok OUTPUT
            END
          END
          FETCH NEXT FROM crNominaGasto INTO @GastoMov, @ReferenciaD, @Cuenta, @FechaA, @GastoUEN, @CentroCostos
          IF @@ERROR <> 0 SELECT @Ok = 1
        END  -- While
        CLOSE crNominaGasto
        DEALLOCATE crNominaGasto
      END
    END  

-- kike 22-Mar-2007 Pase este bloque para que antes de que el ultimo cambio se actualice, lo guarde en la tabla
    IF @MovTipo IN ('NOM.N', 'NOM.NA', 'NOM.NE', 'NOM.NC') AND @EstatusNuevo = 'CONCLUIDO'
    BEGIN
      SELECT  TOP 1 @SucursalTrabajo=SucursalTrabajo,@Personal=Personal.Personal,@Categoria=Categoria, @Puesto=Puesto
        FROM  Personal
        JOIN  NominaD ON NominaD.Personal=Personal.Personal
       WHERE  NominaD.ID =  @ID
      EXEC spPersonalPropValor      @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'REGISTRO PATRONAL',
                                    @Valor OUTPUT

      DELETE NominaPersonal WHERE ID = @ID
      DELETE NominaPersonalProy WHERE ID = @ID
      --Gonzalo 19-abr-2007 Se agregaron los campos nuevos a partir de Sueldo diario
      INSERT NominaPersonal 
            (
             ID, Personal, SucursalTrabajo, CentroCostos, Actividad, UEN, Puesto, FormaPago, Proyecto, UltimoPago, Sucursal, SucursalOrigen, SucursalDestino,
             SueldoDiario, SDIEstaNomina, Departamento, Categoria, Grupo, Jornada, TipoContrato, TipoSueldo, ZonaEconomica,
             RegistroPatronal,FechaAntiguedad, Estado
            )
      SELECT DISTINCT d.ID, p.Personal, p.SucursalTrabajo, p.CentroCostos, p.Actividad, p.UEN, p.Puesto, p.FormaPago, p.Proyecto, p.UltimoPago, @Sucursal, @SucursalOrigen, @SucursalDestino,
             p.SueldoDiario, p.SDI, p.Departamento, p.Categoria, p.Grupo, p.Jornada, p.TipoContrato, p.TipoSueldo,  p.ZonaEconomica,
             @Valor,p.FechaAntiguedad, p.Estado--,  dbo.fnFidePropiedadPersonal (p.Personal, 'Estado Impuesto Estatal')
        FROM NominaD d, Personal p
        --LEFT JOIN PersonalPropValor ppv ON ppv.cuenta=p.SucursalTrabajo AND ppv.Rama='SUC'
        --          AND ppv.propiedad='REGISTRO PATRONAL'
       WHERE d.ID = @ID AND d.Personal = p.Personal
       --GROUP BY d.ID, p.Personal, p.SucursalTrabajo, p.CentroCostos, p.Actividad, p.UEN, p.Puesto, p.FormaPago, p.Proyecto, p.UltimoPago
	   	   
      --BUG22105
      SELECT @PersonalAnt = ''
      WHILE(1=1)
      BEGIN
        SELECT @Personal = MIN(Personal) 
          FROM NominaD
         WHERE NominaD.ID =  @ID
           AND NominaD.Personal > @PersonalAnt

        IF @Personal IS NULL BREAK
        
        SELECT @PersonalAnt = @Personal
        
        SELECT @SucursalTrabajo = SucursalTrabajo, @Categoria = Categoria, @Puesto = Puesto
          FROM Personal
          JOIN NominaD ON NominaD.Personal=Personal.Personal
         WHERE NominaD.ID =  @ID    
           AND Personal.Personal = @Personal
    
        SELECT @Valor = NULL
        EXEC spPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'REGISTRO PATRONAL', @Valor OUTPUT

        UPDATE NominaPersonal
           SET RegistroPatronal = @Valor
          FROM NominaPersonal n
          JOIN Personal p ON n.Personal = p.Personal
         WHERE n.ID = @ID        
           AND n.Personal = @Personal
      END

      INSERT NominaPersonalProy (ID, Personal, Proyecto, Sucursal, SucursalOrigen, SucursalDestino)
      SELECT d.ID, p.Personal, yd.Proyecto, @Sucursal, @SucursalOrigen, @SucursalDestino
        FROM NominaD d, Personal p, ProyD yd, Proy y
       WHERE d.ID = @ID AND d.Personal = p.Personal
         AND yd.Personal = p.Personal 
         AND y.Proyecto = yd.Proyecto AND y.Estatus = 'ALTA'
       GROUP BY d.ID, p.Personal, yd.Proyecto
    END

    IF @MovTipo IN ('NOM.N', 'NOM.NE', 'NOM.NA', 'NOM.NC') AND @Ok IS NULL
    BEGIN
      DECLARE crNominaPersonal CURSOR
         FOR SELECT DISTINCT RTRIM(Personal)
               FROM NominaD
              WHERE ID = @ID AND NULLIF(RTRIM(Personal), '') IS NOT NULL 

      OPEN crNominaPersonal
      FETCH NEXT FROM crNominaPersonal INTO @Personal
      IF @@ERROR <> 0 SELECT @Ok = 1
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          SELECT @PersonalFechaD = @MovFechaD,
                 @PersonalFechaA = @MovFechaA
          SELECT @PersonalFechaD = ISNULL(FechaD, @MovFechaD),
                 @PersonalFechaA = ISNULL(FechaA, @MovFechaA)
            FROM NominaPersonalFecha
           WHERE ID = @ID AND Personal = @Personal

          EXEC spNominaMatarCorresponde @Sucursal, @Accion, @Modulo, @Empresa, @ID, @Mov, @MovID, @MovTipo, @Personal, @PersonalFechaD, @PersonalFechaA, @GenerarBaja, @ProcesarIncidencias, @Ok OUTPUT, @OkRef OUTPUT

          -- Actualizar Ultimo Dia Pago
          IF @MovTipo IN ('NOM.N', 'NOM.NC')
          BEGIN
           SELECT @PersonalUltimoPago = NULL
           IF (@MovTipo = 'NOM.N' AND @Accion = 'CANCELAR') OR (@MovTipo = 'NOM.NC' AND @Accion <> 'CANCELAR')
		     BEGIN
			 Declare @OrigenN Varchar(20), @OrigenIDN Int
			  IF @Mov = 'Cancelacion Parcial' AND @Accion = 'AFECTAR' 
			     BEGIN
				   Select @OrigenN = Origen, @OrigenIDN = OrigenID From nomina Where id = @ID
			       Select @PersonalUltimoPago = UltimoPago From NominaPersonal NP JOIN  Nomina N ON N.ID=NP.ID Where Mov = @OrigenN AND MovID = @OrigenIDN
			     END
			  ELSE
                 SELECT @PersonalUltimoPago = UltimoPago FROM NominaPersonal WHERE ID = @ID AND Personal = @Personal
             END
		  
		   ELSE
             SELECT @PersonalUltimoPago = @PersonalFechaA

            UPDATE Personal SET UltimoPago = @PersonalUltimoPago WHERE Personal = @Personal

            UPDATE PersonalUltimoPago SET UltimoPago = @PersonalUltimoPago WHERE Personal = @Personal AND Mov = @Mov AND Empresa = @Empresa

            IF @@ROWCOUNT = 0
              INSERT PersonalUltimoPago (Personal, Mov, Empresa, UltimoPago) VALUES (@Personal, @Mov, @Empresa, @PersonalUltimoPago)

            IF (@MovTipo = 'NOM.NC' AND @Accion <> 'CANCELAR')
            BEGIN
              /*  Código agregado para el bug 24341  */
              DECLARE @OrigenID varchar(20), @FechaUP datetime, @Persona varchar(10)
              SELECT @Origen = Origen, @OrigenID = OrigenID FROM Nomina WHERE ID = @ID
              SELECT @FechaUP = FechaD FROM Nomina WHERE Mov = @Origen AND MovID = @OrigenID
              SELECT @FechaUP = DATEADD(day, -1, @FechaUP)
              SELECT DISTINCT @Persona = ISNULL(Personal, '') FROM NominaD WHERE ID = @ID and ISNULL(Personal, '') <> ''
              IF EXISTS (SELECT n.ID, n.Empresa, n.Mov, n.MovID, n.FechaD, n.FechaA 
                           FROM Nomina n
                                JOIN NominaPersonal np on np.ID = n.ID
                          WHERE n.Empresa = @Empresa
                            AND n.Mov = @Origen 
                            AND n.Estatus = 'CONCLUIDO' 
                            AND n.FechaA = @FechaUP
                            AND np.Personal = @Persona) BEGIN
                UPDATE PersonalUltimoPago SET UltimoPago = @FechaUP WHERE Personal = @Personal AND Mov = @Origen AND Empresa = @Empresa
                IF @@ROWCOUNT = 0
                  INSERT PersonalUltimoPago (Personal, Mov, Empresa, UltimoPago) VALUES (@Personal, @Origen, @Empresa, @FechaUP)
                   
                UPDATE Personal SET UltimoPago = @FechaUP WHERE Personal = @Personal
              END ELSE BEGIN
                /*  Código Original antes del cambio para el bug 24341 */
                SELECT @Origen = Origen FROM Nomina WHERE ID = @ID  
                UPDATE PersonalUltimoPago SET UltimoPago = @PersonalUltimoPago WHERE Personal = @Personal AND Mov = @Origen AND Empresa = @Empresa
                IF @@ROWCOUNT = 0
                  INSERT PersonalUltimoPago (Personal, Mov, Empresa, UltimoPago) VALUES (@Personal, @Origen, @Empresa, @PersonalUltimoPago)
              END
            END
          END
        END
        FETCH NEXT FROM crNominaPersonal INTO @Personal
        IF @@ERROR <> 0 SELECT @Ok = 1
      END  -- While
      CLOSE crNominaPersonal
      DEALLOCATE crNominaPersonal

      IF @Ok IS NULL AND @MovTipo IN ('NOM.N', 'NOM.E') AND @EstatusNuevo = 'CONCLUIDO'
        EXEC spNominaProrrateo @ID, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL AND @MovTipo IN ('NOM.N', 'NOM.NC')
        IF (@MovTipo = 'NOM.N' AND @Accion = 'CANCELAR') OR (@MovTipo = 'NOM.NC' AND @Accion <> 'CANCELAR')
        BEGIN
          UPDATE PeriodoTipo    SET UltimoDiaPagado = DATEADD(day, -1, @MovFechaD) WHERE PeriodoTipo = @PeriodoTipo

          UPDATE PeriodoTipoMov SET UltimoDiaPagado = DATEADD(day, -1, @MovFechaD) WHERE PeriodoTipo = @PeriodoTipo AND Mov = @Mov
          IF @@ROWCOUNT = 0
            INSERT PeriodoTipoMov (PeriodoTipo, Mov, UltimoDiaPagado) VALUES (@PeriodoTipo, @Mov, DATEADD(day, -1, @MovFechaD))

          UPDATE PeriodoTipoMovEmpresa SET UltimoDiaPagado = DATEADD(day, -1, @MovFechaD) WHERE PeriodoTipo = @PeriodoTipo AND Mov = @Mov AND Empresa = @Empresa
          IF @@ROWCOUNT = 0
            INSERT PeriodoTipoMovEmpresa (PeriodoTipo, Mov, Empresa, UltimoDiaPagado) VALUES (@PeriodoTipo, @Mov, @Empresa, DATEADD(day, -1, @MovFechaD))

        END ELSE
        BEGIN
          UPDATE PeriodoTipo    SET UltimoDiaPagado = @MovFechaA WHERE PeriodoTipo = @PeriodoTipo

          UPDATE PeriodoTipoMov SET UltimoDiaPagado = @MovFechaA WHERE PeriodoTipo = @PeriodoTipo AND Mov = @Mov
          IF @@ROWCOUNT = 0
            INSERT PeriodoTipoMov (PeriodoTipo, Mov, UltimoDiaPagado) VALUES (@PeriodoTipo, @Mov, @MovFechaA)

          UPDATE PeriodoTipoMovEmpresa SET UltimoDiaPagado = @MovFechaA WHERE PeriodoTipo = @PeriodoTipo AND Mov = @Mov AND Empresa = @Empresa
          IF @@ROWCOUNT = 0
            INSERT PeriodoTipoMovEmpresa (PeriodoTipo, Mov, Empresa, UltimoDiaPagado) VALUES (@PeriodoTipo, @Mov, @Empresa, @MovFechaA)
        END
    END

    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus     IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Nomina
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion, 
             FechaA           = CASE WHEN @MovTipo = 'NOM.NA' THEN FechaEmision ELSE FechaA END,
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
	     Concepto	      = @Concepto,
             GenerarPoliza    = @GenerarPoliza,
             Percepciones     = @SumaPercepciones,
             Deducciones      = @SumaDeducciones
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
/*
      IF @MovTipo IN ('NOM.N', 'NOM.NA', 'NOM.NE', 'NOM.NC') AND @EstatusNuevo = 'CONCLUIDO'
      BEGIN
        DELETE NominaPersonal WHERE ID = @ID
        DELETE NominaPersonalProy WHERE ID = @ID
        INSERT NominaPersonal (
               ID,   Personal,   SucursalTrabajo,   CentroCostos,   Actividad,   UEN,   Puesto,   FormaPago,   Proyecto,   Sucursal,  SucursalOrigen,  SucursalDestino)
        SELECT d.ID, p.Personal, p.SucursalTrabajo, p.CentroCostos, p.Actividad, p.UEN, p.Puesto, p.FormaPago, p.Proyecto, @Sucursal, @SucursalOrigen, @SucursalDestino
          FROM NominaD d, Personal p
         WHERE d.ID = @ID AND d.Personal = p.Personal
         GROUP BY d.ID, p.Personal, p.SucursalTrabajo, p.CentroCostos, p.Actividad, p.UEN, p.Puesto, p.FormaPago, p.Proyecto

        INSERT NominaPersonalProy (ID, Personal, Proyecto, Sucursal, SucursalOrigen, SucursalDestino)
        SELECT d.ID, p.Personal, yd.Proyecto, @Sucursal, @SucursalOrigen, @SucursalDestino
          FROM NominaD d, Personal p, ProyD yd, Proy y
         WHERE d.ID = @ID AND d.Personal = p.Personal
           AND yd.Personal = p.Personal 
           AND y.Proyecto = yd.Proyecto AND y.Estatus = 'ALTA'
         GROUP BY d.ID, p.Personal, yd.Proyecto
      END
*/
    END

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  IF @Accion <> 'CANCELAR' AND @Ok IS NULL
  BEGIN
    IF @SugerirAumentoVacaciones = 1
      EXEC spNominaSugerirAumentoVacaciones @Accion, @Sucursal, @Empresa, @FechaOrigen, @Proyecto, @Usuario, @Modulo, 
         	      		            @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaRegistro,
					    @CfgAfectarAumentoVacaciones, 
    			   	            @Ok OUTPUT, @OkRef OUTPUT
 
     IF @SugerirDisminucionVacaciones = 1
      EXEC spNominaSugerirDisminucionVacaciones @Accion, @Sucursal, @Empresa, @FechaOrigen, @Proyecto, @Usuario, @Modulo, 
         	      		            @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaRegistro,
					    @CfgAfectarDisminucionVacaciones, 
    			   	            @Ok OUTPUT, @OkRef OUTPUT
    			   	            
    IF @SugerirSDI = 1 
      EXEC spNominaSugerirSDI @Accion, @Sucursal, @Empresa, @FechaOrigen, @Proyecto, @Usuario, @Modulo, 
		  	      @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaRegistro,
			      @Ok OUTPUT, @OkRef OUTPUT

    IF @GenerarBaja = 1 
      EXEC spNominaGenerarBaja @Accion, @Sucursal, @Empresa, @FechaOrigen, @Proyecto, @Usuario, @Modulo, 
			       @ID, @Mov, @MovID, @MovMoneda, @MovTipoCambio, @FechaRegistro,
			       @Ok OUTPUT, @OkRef OUTPUT
  END
/*
JGD 28Enero2011 y 31Enero2011. Solución Ticket 2743 Y 2789. Se manda llamar a los SP's spNominaSugerirAumentoVacaciones y spNominaSugerirSDI
  para Cancelar los Movimientos de Aumento de Vacaciones (NOM) y Modicicaciones (RH), si es que se generarón
*/
--  IF @Accion = 'CANCELAR' AND @Ok IS NULL
--    EXEC spNominaCancelar @ID, @Mov, @MovID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion = 'CANCELAR' AND @Ok IS NULL
  BEGIN
    EXEC spNominaCancelar @ID, @Mov, @MovID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT
    IF @SugerirAumentoVacaciones = 1
      EXEC spNominaSugerirAumentoVacaciones @Accion,@Sucursal,@Empresa,@FechaEmision,@Proyecto,@Usuario,@Modulo,@Mov,@MovID,@MovMoneda,@MovTipoCambio,@FechaRegistro,0,@Ok OUTPUT, @OkRef OUTPUT
    IF @SugerirDisminucionVacaciones = 1
      EXEC spNominaSugerirDisminucionVacaciones @Accion,@Sucursal,@Empresa,@FechaEmision,@Proyecto,@Usuario,@Modulo,@Mov,@MovID,@MovMoneda,@MovTipoCambio,@FechaRegistro,0,@Ok OUTPUT, @OkRef OUTPUT            
    IF @SugerirSDI = 1
      EXEC spNominaSugerirSDI @Accion,@Sucursal,@Empresa,@FechaEmision,@Proyecto,@Usuario,@Modulo,@Mov,@MovID,@MovMoneda,@MovTipoCambio,@FechaRegistro,@Ok OUTPUT, @OkRef OUTPUT
  END
--Fin JGD

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      BEGIN
        DECLARE @PolizaDescuadrada TABLE (Cuenta varchar(20) NULL, SubCuenta varchar(50) NULL, Concepto varchar(50) NULL, Debe money NULL, Haber money NULL, SucursalContable int NULL)
        IF EXISTS(SELECT * FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID)
        INSERT @PolizaDescuadrada (Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID 
        ROLLBACK TRANSACTION
        DELETE PolizaDescuadrada WHERE Modulo = @Modulo AND ID = @ID
        INSERT PolizaDescuadrada (Modulo, ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable) SELECT @Modulo, @ID, Cuenta, SubCuenta, Concepto, Debe, Haber, SucursalContable FROM @PolizaDescuadrada
      END
    
  RETURN
END
GO


/**************** spNomina **************** cambio ABC*/
if exists (select * from sysobjects where id = object_id('dbo.spNomina') and type = 'P') drop procedure dbo.spNomina
GO             
CREATE PROCEDURE dbo.spNomina
  @ID               	int,
  @Modulo	      		char(5),
  @Accion			char(20),
  @Base			char(20),
  @FechaRegistro		datetime,
  @GenerarMov			char(20),
  @Usuario			char(10),
  @Conexion			bit,
  @SincroFinal			bit,
  @Mov	      			char(20)	OUTPUT,
  @MovID            		varchar(20)	OUTPUT,
  @IDGenerar			int		OUTPUT,
  @Ok				int		OUTPUT,
  @OkRef			varchar(255)	OUTPUT
  WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @MovMoneda			char(10),
    @MovTipoCambio		float,
    @FechaEmision     		datetime,
    @FechaOrigen		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @Condicion			varchar(50),
    @UsaImporte			bit,
    @UsaCantidad		bit,
    @UsaPorcentaje		bit,
    @UsaMonto			bit,
    @UsaFechas			bit,
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @PeriodoTipo		varchar(50),
    @MovFechaD			datetime,
    @MovFechaA			datetime,
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @Concepto			varchar(50),
    @SugerirAumentoVacaciones  	bit,
    @CfgAfectarAumentoVacaciones  bit,
    @CfgConceptoAumentoVacaciones varchar(50),
    @SugerirDisminucionVacaciones  	bit,
    @CfgAfectarDisminucionVacaciones  	bit,
    @CfgConceptoDisminucionVacaciones varchar(50),
    @CfgValidarReferencias	bit,
    @MovIncapacidades		varchar(20),
    @MovAplicacionNomina	varchar(20),
    @SugerirSDI			bit,
    @CfgConceptoSDI		varchar(50),
    @CfgContX			bit,
    @CfgContXGenerar		char(20)/*,
    @Verificar			bit*/
  SELECT @CfgContX        = 0,
         @CfgContXGenerar = 'NO',
         @UsaImporte	  = 0,
         @UsaCantidad     = 0,
         @UsaPorcentaje	  = 0,
         @UsaMonto	  = 0,
         @UsaFechas	  = 0/*,
         @Verificar	  = 1*/
  SELECT @Sucursal = Sucursal, 
         @SucursalDestino = SucursalDestino, 
         @SucursalOrigen = SucursalOrigen, 
         @Empresa = Empresa, 
         @MovID = MovID, 
         @Mov = Mov, 
         @FechaEmision = FechaEmision, 
         @FechaOrigen = FechaOrigen, 
         @Proyecto = Proyecto,
         @MovUsuario = Usuario, 
         @Autorizacion = Autorizacion,
         @MovMoneda = Moneda, 
         @MovTipoCambio = TipoCambio,
         @Condicion = NULLIF(RTRIM(Condicion), ''), 
         @PeriodoTipo = NULLIF(RTRIM(PeriodoTipo), ''), 
         @MovFechaD = FechaD, 
         @MovFechaA = FechaA,
         @DocFuente = DocFuente, 
         @Observaciones = Observaciones, 
         @Estatus = UPPER(Estatus),
         @GenerarPoliza = GenerarPoliza, 
         @FechaConclusion = FechaConclusion,
         @Concepto = NULLIF(RTRIM(Concepto), '')
    FROM Nomina
   WHERE ID = @ID

  IF @@ERROR <> 0 SELECT @Ok = 1
  IF NULLIF(RTRIM(@Usuario), '') IS NULL 
    SELECT @Usuario = @MovUsuario

  EXEC spExtraerFecha @MovFechaD OUTPUT
  EXEC spExtraerFecha @MovFechaA OUTPUT
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT
  IF @Ok IS NULL
  BEGIN
    IF @SucursalDestino IS NOT NULL AND @SucursalDestino <> @Sucursal AND @Accion = 'AFECTAR'
    BEGIN
      EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
      IF @EnLinea = 1
      BEGIN
        EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, NULL
        SELECT @Sucursal = @SucursalDestino
      END ELSE
        SELECT @Accion = 'SINCRO'
    END
    IF @Estatus = 'SINCRO' AND @Accion = 'CANCELAR'
    BEGIN
      EXEC spPuedeEditarMovMatrizSucursal @Sucursal, @SucursalOrigen, @ID, @Modulo, @Empresa, @Usuario, @Mov, @Estatus, 1, @PuedeEditar OUTPUT
      IF @PuedeEditar = 0
        SELECT @Ok = 60300
      ELSE BEGIN
        SELECT @Estatus = 'SINAFECTAR'/*, @Verificar = 0*/
        EXEC spAsignarSucursalEstatus @ID, @Modulo, @Sucursal, @Estatus
      END
    END
  END
  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'PENDIENTE', 'PROCESAR', 'VIGENTE')) OR
     (@Accion =  'CANCELAR' AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'PROCESAR', 'VIGENTE'))
  BEGIN
    SELECT @SugerirSDI                   = NomSugerirSDI,
           @CfgConceptoSDI               = NULLIF(RTRIM(NomConceptoSDI), ''),
           @SugerirAumentoVacaciones	   = NomSugerirAumentoVacaciones,
           @CfgAfectarAumentoVacaciones  = NomAfectarAumentoVacaciones,
           @CfgConceptoAumentoVacaciones = NomConceptoAumentoVacaciones,
           @CfgValidarReferencias        = NomValidarReferencias,
           @SugerirDisminucionVacaciones      = NomSugerirDisminuirVacaciones,
           @CfgAfectarDisminucionVacaciones   = NomAfectarDisminuirVacaciones,
           @CfgConceptoDisminucionVacaciones  = NomConceptoDisminuirVacaciones
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

  IF @@ERROR <> 0 SELECT @Ok = 1
  IF @MovTipo <> 'NOM.N'
    SELECT  @SugerirAumentoVacaciones = 0
  SELECT @MovIncapacidades = NomIncapacidades,
         @MovAplicacionNomina = CxcAplicacionNomina
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @@ERROR <> 0 SELECT @Ok = 1

  SELECT @CfgContX = ContX
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  IF @@ERROR <> 0 SELECT @Ok = 1
  IF @CfgContX = 1
    SELECT @CfgContXGenerar = ContXGenerar 
      FROM EmpresaCfgModulo
     WHERE Empresa = @Empresa
       AND Modulo  = @Modulo
  IF @@ERROR <> 0 SELECT @Ok = 1
  IF @Accion = 'DESAFECTAR'
    SELECT @EstatusNuevo = 'SINAFECTAR'
  ELSE
    IF @Accion = 'CANCELAR'
      SELECT @EstatusNuevo = 'CANCELADO'
    ELSE BEGIN
      SELECT @EstatusNuevo = 'CONCLUIDO'
      IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR')
      BEGIN
        IF @MovTipo = 'NOM.CA' SELECT @EstatusNuevo = 'PENDIENTE'
        --BUG18734
        --IF @MovTipo = 'NOM.VT' SELECT @EstatusNuevo = 'CONCLUIDO'   
        IF @MovTipo IN ('NOM.C', 'NOM.CH', 'NOM.CD', 'NOM.CDH', 'NOM.VT')
          SELECT @EstatusNuevo = 'PROCESAR', @UsaCantidad = 1
        ELSE
          IF @MovTipo IN ('NOM.P', 'NOM.PD', 'NOM.PI', 'NOM.D')
          BEGIN
            SELECT @UsaImporte = 1
            IF @Condicion IS NULL OR UPPER(@Condicion) = 'UNA VEZ'
              SELECT @EstatusNuevo = 'PROCESAR'
          ELSE BEGIN
            SELECT @EstatusNuevo = 'VIGENTE'
            IF UPPER(@Condicion) IN ('REPETIR', 'PRORRATEAR') SELECT @UsaCantidad = 1 ELSE
            IF UPPER(@Condicion) = 'REPETIR FECHAS' SELECT @UsaFechas = 1 ELSE
            IF UPPER(@Condicion) IN ('PRORRATEAR %', '% SUELDO') SELECT @UsaPorcentaje = 1 ELSE
            IF UPPER(@Condicion) IN ('PRORRATEAR $', 'CON ENGANCHE') SELECT @UsaMonto = 1
            IF UPPER(@Condicion) = '% SUELDO' SELECT @UsaImporte = 0
          END
        END
      END
    END
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spNominaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @Condicion, @PeriodoTipo, @MovFechaD, @MovFechaA, @FechaEmision, @Estatus,
                             @UsaImporte, @UsaCantidad, @UsaPorcentaje, @UsaMonto, @UsaFechas,
	  		     @CfgValidarReferencias, @MovIncapacidades, 
	 		     @Conexion, @SincroFinal, @Sucursal,
    		 	     @CfgContX, @CfgContXGenerar, @GenerarPoliza,
		             @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL SELECT @Ok = 80000
    END
    IF @Accion IN ('AFECTAR', 'DESAFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spNominaAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio,
			   @Condicion, @PeriodoTipo, @MovFechaD, @MovFechaA, @FechaEmision, @FechaOrigen, @FechaAfectacion, @FechaConclusion,
		 	   @Proyecto, @Concepto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
			   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo,
			   @UsaImporte, @UsaCantidad, @UsaPorcentaje, @UsaMonto, @UsaFechas,
			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
			   @SugerirAumentoVacaciones, @CfgAfectarAumentoVacaciones, @CfgConceptoAumentoVacaciones, 
               @SugerirDisminucionVacaciones,@CfgAfectarDisminucionVacaciones,@CfgConceptoDisminucionVacaciones,
               @SugerirSDI, @CfgConceptoSDI,
			   @MovAplicacionNomina,
			   @CfgContX, @CfgContXGenerar, @GenerarPoliza,
			   @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
			   @Ok OUTPUT, @OkRef OUTPUT
    /*IF @Accion = 'CANCELAR' AND @Ok IS NULL
      EXEC spNominaCancelar @ID, @Mov, @MovID, @Usuario, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT*/
  END ELSE
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    --ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END
  IF @Accion = 'SINCRO' AND @Ok = 80060
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END
  IF @Ok IS NOT NULL AND @OkRef IS NULL
  IF @Ok = 80030
    SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))
  ELSE
   SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL
  RETURN
END
GO

/**************** spGenerarNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarNomina') and type = 'P') drop procedure dbo.spGenerarNomina
GO
CREATE PROCEDURE spGenerarNomina
		   @Sucursal			int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
    		   @FechaAfectacion  		datetime,
    		   @FechaRegistro   		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),

		   @Personal			char(10),

		   @NominaID			int		OUTPUT,
		   @NominaMov			char(20)	OUTPUT,
		   @NominaMovID			varchar(20)	OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon		float,
    @Importe		money,
    @Referencia		varchar(50),
/*    @PersonalMoneda	char(10),
    @PersonalFactor	float,
    @PersonalTipoCambio	float,*/
    @PersonalEstatus	char(15),
    @IDGenerar 		int

  IF @Accion <> 'CANCELAR'
  BEGIN
    SELECT @Accion = 'AFECTAR', @PersonalEstatus = NULL
    SELECT /*@PersonalMoneda = Moneda, */@PersonalEstatus = Estatus FROM Personal WHERE Personal = @Personal
    IF @PersonalEstatus <> 'ALTA' SELECT @Ok = 55020

    IF @Ok = 55020
      EXEC xpOk_55020 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NOT NULL RETURN
--    EXEC spMoneda @Accion, @MovMoneda, @MovTipoCambio, @PersonalMoneda, @PersonalFactor OUTPUT, @PersonalTipoCambio OUTPUT, @Ok OUTPUT

    INSERT INTO Nomina (Sucursal,  Empresa,  Mov,        MovID,        FechaEmision,     Concepto,  Proyecto,  Moneda,     TipoCambio,     Usuario,  Autorizacion,  DocFuente,  Observaciones,  Estatus,      OrigenTipo, Origen, OrigenID)
                VALUES (@Sucursal, @Empresa, @NominaMov, @NominaMovID, @FechaAfectacion, @Concepto, @Proyecto, @MovMoneda, @MovTipoCambio, @Usuario, @Autorizacion, @DocFuente, @Observaciones, 'SINAFECTAR', @Modulo,    @Mov,   @MovID)
    IF @@ERROR <> 0 SELECT @Ok = 1
    SELECT @NominaID = SCOPE_IDENTITY()

    -- Copiar Anexos
    EXEC spMovCopiarAnexos @Sucursal, @Modulo, @ID, 'NOM', @NominaID

    IF @MovTipo IN ('AGENT.P', 'AGENT.CO') 
    BEGIN
      DECLARE crAgentD CURSOR
         FOR SELECT d.Importe, u.Referencia
               FROM AgentD d, AgentUnico u
              WHERE d.ID = @ID AND u.Empresa = @Empresa AND u.Mov = d.Aplica AND u.MovID = d.AplicaID

      SELECT @Renglon = 0.0
      OPEN crAgentD
      FETCH NEXT FROM crAgentD INTO @Importe, @Referencia
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          SELECT @Renglon = @Renglon + 2048
          IF @MovTipo = 'AGENT.CO' SELECT @Importe = -@Importe
          INSERT NominaD (Sucursal,  ID,        Renglon,  Personal,  Importe,  Referencia,  FechaD) 
                  VALUES (@Sucursal, @NominaID, @Renglon, @Personal, @Importe, @Referencia, @FechaAfectacion)
        END 
        FETCH NEXT FROM crAgentD INTO @Importe, @Referencia
      END  -- While
      CLOSE crAgentD
      DEALLOCATE crAgentD
    END
  END ELSE
  BEGIN
    SELECT @NominaID = DID, @NominaMov = DMov, @NominaMovID = DMovID 
      FROM MovFlujo 
     WHERE Cancelado = 0 
       AND Empresa = @Empresa 
       AND OModulo = @Modulo 
       AND OID     = @ID 
       AND DModulo = 'NOM'
    IF @@ERROR <> 0 SELECT @Ok = 1

    IF @NominaID IS NULL SELECT @Ok = 60060, @OkRef = RTRIM(@NominaMov)+' '+LTRIM(Convert(Char, @NominaMovID))
  END

  IF @Ok IS NULL 
    EXEC spNomina @NominaID, 'NOM', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @NominaMov OUTPUT, @NominaMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  -- Registrar el Flujo    
  EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'NOM', @NominaID, @NominaMov, @NominaMovID, @Ok OUTPUT

  -- Avisar Movimiento Generado
  IF @Accion <> 'CANCELAR' AND @Ok IS NULL 
    SELECT @Ok = 80030, @OkRef = 'Movimiento - '+RTRIM(@NominaMov)+' '+LTRIM(Convert(Char, @NominaMovID))

  IF @Ok IS NULL
    EXEC xpGenerarNomina @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
					@FechaAfectacion, @FechaRegistro, @Concepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
					@Personal, @NominaID OUTPUT, @NominaMov OUTPUT, @NominaMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
					

  RETURN
END
GO

/**************** spGenerarNominaAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.spGenerarNominaAuto') and type = 'P') drop procedure dbo.spGenerarNominaAuto
GO
CREATE PROCEDURE spGenerarNominaAuto
		@Sucursal			int,
		@Accion			char(20),
		@Empresa	      		char(5),
		@Modulo	      		char(5),
		@ID				int,
		@Mov				char(20),
		@MovID             		varchar(20),
		@MovTipo     		char(20),
		@MovMoneda	      		char(10),
		@MovTipoCambio	 	float,
		@FechaAfectacion  		datetime,
		@FechaRegistro   		datetime,
		@Concepto	      		varchar(50),
		@Proyecto	      		varchar(50),
		@Usuario	      		char(10),
		@Autorizacion      		char(10),
		@DocFuente	      		int,
		@Observaciones     		varchar(255),

		@Personal			char(10),

		@NominaID			int		OUTPUT,
		@NominaMov			char(20)	OUTPUT,
		@NominaMovID			varchar(20)	OUTPUT,


		@Ok		            int         OUTPUT,
		@OkRef			varchar(255)	OUTPUT

WITH ENCRYPTION
AS BEGIN
  DECLARE
	@Renglon		float,
	@Importe		money,
	@Referencia		varchar(50),
	@PersonalEstatus	char(15),
	@IDGenerar 		int,

	@NominaConcepto     varchar (10),

	@Cantidad   float, 
	@Porcentaje float,
	@Repetir bit,
	@Prorratear bit,
	@Veces float,
	@ImporteUnitario money,
	@Frecuencia varchar (20),
	@IncMovID varchar(20)

  IF @Accion <> 'CANCELAR'
  BEGIN
    SELECT @Accion = 'AFECTAR', @PersonalEstatus = NULL
    SELECT @PersonalEstatus = Estatus FROM Personal WHERE Personal = @Personal
    IF @PersonalEstatus <> 'ALTA' SELECT @Ok = 55020

    IF @Ok = 55020
      EXEC xpOk_55020 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT

    IF @Ok IS NOT NULL RETURN
    
    ---insertamos encabezado de la insidencia
	SELECT @NominaConcepto=NominaConcepto, @Cantidad= 1.0, @Porcentaje = 100.0,@Repetir=0,@Prorratear=0,@Veces=0, @ImporteUnitario =0, @Frecuencia='Cada Nomina'  FROM NominaConcepto nc
	WHERE nc.Concepto='Comisiones'
  
    IF @MovTipo IN ('AGENT.P', 'AGENT.CO') 
    BEGIN
      DECLARE crAgentD CURSOR
         FOR SELECT d.Importe, u.Referencia
               FROM AgentD d, AgentUnico u
              WHERE d.ID = @ID AND u.Empresa = @Empresa AND u.Mov = d.Aplica AND u.MovID = d.AplicaID

      SELECT @Renglon = 0.0
      OPEN crAgentD
      FETCH NEXT FROM crAgentD INTO @Importe, @Referencia
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          SELECT @Renglon = @Renglon + 2048
          IF @MovTipo = 'AGENT.CO' SELECT @Importe = -@Importe

		SET @IDGenerar=0

        --insertamos la incidencia       
		INSERT INTO Incidencia
		(Empresa, Mov, FechaEmision, UltimoCambio, Usuario, Estatus, GenerarPoliza, Sucursal, SucursalOrigen, Moneda, TipoCambio, FechaAplicacion, Personal, 
		NominaConcepto, FechaD, FechaA,					Cantidad, Valor,      Porcentaje,   Repetir, Prorratear, Veces, ImporteUnitario, Frecuencia,Referencia,Proyecto)
		VALUES     (@Empresa, 'Incidencia', @FechaAfectacion,@FechaAfectacion,  @Usuario, 'SINAFECTAR', 0, @Sucursal, @Sucursal, @MovMoneda,@MovTipoCambio, @FechaAfectacion, @Personal,
		 @NominaConcepto,@FechaAfectacion, @FechaAfectacion, @Cantidad, @Importe, @Porcentaje, @Repetir, @Prorratear, @Veces, @ImporteUnitario, @Frecuencia,@Referencia,@Proyecto)
		SET @IDGenerar=SCOPE_IDENTITY()
		
		IF @IDGenerar>0
		EXEC  spAfectar 'INC', @IDGenerar, 'AFECTAR', 'Todo', NULL, @Usuario, NULL, 1, @Ok OUTPUT, @OkRef OUTPUT
        
        END 
        FETCH NEXT FROM crAgentD INTO @Importe, @Referencia
      END  -- While
      CLOSE crAgentD
      DEALLOCATE crAgentD
    END
  END 

  SELECT @IncMovID=MovID FROM Incidencia WHERE ID=@IDGenerar

  -- Registrar el Flujo    
  EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'INC', @IDGenerar, 'Incidencia', @IncMovID, @Ok OUTPUT

  IF @Ok IS NULL
    EXEC xpGenerarNominaAuto @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
					@FechaAfectacion, @FechaRegistro, @Concepto, @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones,
					@Personal, @IDGenerar, @NominaID OUTPUT, @NominaMov OUTPUT, @NominaMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  -- Avisar Movimiento Generado
--  IF @Accion <> 'CANCELAR' AND @Ok IS NULL 
--    SELECT @Ok = 80030, @OkRef = 'Movimiento - Incidencia'+ltrim(rtrim(@IncMovID))

  RETURN
END
GO

/**************** spPersonalCostoEstandar ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spPersonalCostoEstandar') AND type = 'P') DROP PROCEDURE dbo.spPersonalCostoEstandar
GO
CREATE PROCEDURE spPersonalCostoEstandar 
	     @Personal		varchar(10), 
             @CostoEstandar	money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  EXEC xpPersonalCostoEstandar @Personal, @CostoEstandar OUTPUT
END
GO

/**************** spVerPersonalCostoEstandar ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('spVerPersonalCostoEstandar') AND type = 'P') DROP PROCEDURE dbo.spVerPersonalCostoEstandar
GO
CREATE PROCEDURE spVerPersonalCostoEstandar
	     @Personal		varchar(10)
--//WITH ENCRYPTION
AS BEGIN             
  DECLARE @CostoEstandar money
  BEGIN
    EXEC spPersonalCostoEstandar @Personal, @CostoEstandar OUTPUT
    SELECT @CostoEstandar
  END
END	
GO

/**************** spPersonalPropValor ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValor') and type = 'P') drop procedure dbo.spPersonalPropValor
GO             
CREATE PROCEDURE spPersonalPropValor
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		varchar(50) OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mensaje	varchar(255)

  SELECT @Valor = NULL

  IF @Personal IS NOT NULL
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'PER' AND Cuenta = @Personal AND Propiedad = @Propiedad
  IF @Categoria IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'CAT' AND Cuenta = @Categoria AND Propiedad = @Propiedad
  IF @Puesto IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'PUE' AND Cuenta = @Puesto AND Propiedad = @Propiedad
  IF @Sucursal IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'SUC' AND Cuenta = CONVERT(varchar, @Sucursal) AND Propiedad = @Propiedad
  IF @Empresa IS NOT NULL AND @Valor IS NULL 
    SELECT @Valor = NULLIF(RTRIM(Valor), '') FROM PersonalPropValor WHERE Rama = 'EMP' AND Cuenta = @Empresa AND Propiedad = @Propiedad

  IF NOT EXISTS(SELECT * FROM PersonalProp WHERE Propiedad = @Propiedad) AND @SinError = 0
  BEGIN
    SELECT @Mensaje = '"'+REPLACE(@Propiedad,'%','%%')+'" '+RTRIM(Descripcion) FROM MensajeLista WHERE Mensaje = 10460
    RAISERROR (@Mensaje, 16, -1) 
  END
  RETURN
END
GO

/**************** spPersonalPropValorInt ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValorInt') and type = 'P') drop procedure dbo.spPersonalPropValorInt
GO             
CREATE PROCEDURE spPersonalPropValorInt
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		int 	OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(50)

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @ValorSt OUTPUT, @SinError
  SELECT @Valor = 0
  IF dbo.fnEsNumerico(@ValorSt) = 1
    SELECT @Valor = ISNULL(CONVERT(int, @ValorSt), 0)
END
GO

/**************** spPersonalPropValorDMA ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValorDMA') and type = 'P') drop procedure dbo.spPersonalPropValorDMA
GO             
CREATE PROCEDURE spPersonalPropValorDMA
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		datetime 	OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(50)

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @ValorSt OUTPUT, @SinError
  SELECT @Valor = NULL
  EXEC spDMAToDateTime @ValorSt, @Valor OUTPUT
END
GO


/**************** spPersonalPropValorFloat ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValorFloat') and type = 'P') drop procedure dbo.spPersonalPropValorFloat
GO             
CREATE PROCEDURE spPersonalPropValorFloat
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		float 	OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(50)

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @ValorSt OUTPUT, @SinError
  SELECT @Valor = 0.0
  IF dbo.fnEsNumerico(@ValorSt) = 1
    SELECT @Valor = ISNULL(CONVERT(float, @ValorSt), 0.0)
END
GO

/**************** spPersonalPropValorMoney ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValorMoney') and type = 'P') drop procedure dbo.spPersonalPropValorMoney
GO             
CREATE PROCEDURE spPersonalPropValorMoney
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		money 	OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(50)

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @ValorSt OUTPUT, @SinError
  SELECT @Valor = 0.0
  IF dbo.fnEsNumerico(@ValorSt) = 1
    SELECT @Valor = ISNULL(CONVERT(money, @ValorSt), 0.0)
END
GO

/**************** spPersonalPropValorBit ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalPropValorBit') and type = 'P') drop procedure dbo.spPersonalPropValorBit
GO             
CREATE PROCEDURE spPersonalPropValorBit
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@Propiedad	varchar(50),	
			@Valor		bit 	OUTPUT,
			@SinError	bit	= 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ValorSt	varchar(50)

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @Propiedad, @ValorSt OUTPUT, @SinError
  SELECT @Valor = 0
  IF UPPER(SUBSTRING(@ValorSt, 1, 1)) IN ('S', 'Y')
    SELECT @Valor = 1
END
GO

/**************** spNominaFactorIntegracion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaFactorIntegracion') and type = 'P') drop procedure dbo.spNominaFactorIntegracion
GO             
CREATE PROCEDURE spNominaFactorIntegracion
			@Empresa	char(5),
			@Sucursal	int,
			@Categoria	varchar(50),
			@Puesto		varchar(50),
			@Personal	char(10),
			@AnosCumplidos	int,
			@Factor		float OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Numero		int,
    @TablaVacaciones	varchar(50),
    @Valor		varchar(50),
    @DiasVacacionesIMSS	int,
    @PrimaVacacional	float,
    @DiasAguinaldo	float,
    @DiasAno		float  

  SELECT @PrimaVacacional = NULL, @DiasAguinaldo = NULL, @DiasAno = NULL, @Factor = NULL
  SELECT @TablaVacaciones = TablaVacaciones FROM EmpresaCfg WHERE Empresa = @Empresa
 /* IF ((@AnosCumplidos+1) < 5)  
    SELECT @DiasVacacionesIMSS = 6 + ((@AnosCumplidos)*2) 
  ELSE 
    SELECT @DiasVacacionesIMSS = 10 + (CONVERT(int, (@AnosCumplidos+1)/5)*2)
*/
  SELECT @Numero = @AnosCumplidos
  IF NOT EXISTS(SELECT * FROM TablaNumD WHERE TablaNum = @TablaVacaciones AND Numero = @Numero)
    SELECT @Numero = MAX(Numero) FROM TablaNumD WHERE TablaNum = @TablaVacaciones

  SELECT @DiasVacacionesIMSS = ISNULL(Valor,0)
    FROM TablaNumD
   WHERE TablaNum = @TablaVacaciones AND Numero = @Numero

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, '% Prima Vacacional', @Valor OUTPUT

  IF (SELECT dbo.fnEsNumerico(@Valor)) = 1
    SELECT @PrimaVacacional = CONVERT(float, @Valor)
  ELSE  SELECT @PrimaVacacional = Valor FROM TablaNumD WHERE TablaNum=@Valor AND Numero = @AnosCumplidos

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, '# Dias Aguinaldo', @Valor OUTPUT

  IF (SELECT dbo.fnEsNumerico(@Valor)) = 1
    SELECT @DiasAguinaldo = CONVERT(float, @Valor)    
  ELSE
    SELECT @DiasAguinaldo = Valor FROM TablaNumD WHERE TablaNum=@Valor AND Numero = @AnosCumplidos

  EXEC spPersonalPropValor @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, '# Dias Ano', @Valor OUTPUT
  SELECT @DiasAno = CONVERT(float, @Valor)

  SELECT @Factor = ((((@DiasVacacionesIMSS * @PrimaVacacional / 100) + @DiasAguinaldo) / @DiasAno) + 1)

  RETURN
END
GO

/**************** spNominaDiasBimestre ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spNominaDiasBimestre') and type = 'P') drop procedure dbo.spNominaDiasBimestre
GO             
CREATE PROCEDURE spNominaDiasBimestre
                                   @Fecha     datetime,
                                   @FechaD    datetime OUTPUT,
                                   @FechaA    datetime OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @FechaT varchar(15),
    @Dia int,
    @Mes int,
    @Año int
  
  SELECT @Fecha = DATEADD(month,-1,@Fecha)
  SELECT @Mes   = DATEPART(mm,@Fecha)
  WHILE @Mes/2.0 <> @Mes/2 
  BEGIN
    SELECT @Fecha=DATEADD(month,-1,@Fecha)
    SELECT @Mes=DATEPART(mm,@Fecha)
  END
  SELECT @Fecha=DATEADD(month,1,@Fecha)
  SELECT @Mes=DATEPART(mm,@Fecha)
  SELECT @Año=DATEPART(yyyy,@Fecha)

  SELECT @FechaT=CONVERT(VarChar,@Año)+'.'+CONVERT(VarChar,@Mes)+'.01'
  SELECT @FechaA=CONVERT(DateTime,@FechaT,102)
  SELECT @FechaA=DATEADD(Day,-1,@FechaA)
  SELECT @FechaD=DATEADD(Month,-2,@FechaA)
  SELECT @FechaD=DATEADD(Day,1,@FechaD)
  SELECT @Dia=DATEPART(Day,@FechaD)
  WHILE @Dia <> 1
  BEGIN
      SELECT @FechaD=DATEADD(Day,1,@FechaD)
      SELECT @Dia=DATEPART(Day,@FechaD)
  END
RETURN
END
GO

-- spVerSDI 'DEMO', 0, 'A', 'CJ', 1, 1000, 'Fijo'
-- spVerSDI 'DEMO', 0, 0, 'SS', 2, 4000, 'Fijo', @ZonaEconomica='A'
-- spVerSDI 'DEMO', 0, 'A', 'CJ', 0, 1050, 'Fijo'

/**************** spVerSDI ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.spVerSDI') and type = 'P') drop procedure dbo.spVerSDI
GO             
CREATE PROCEDURE spVerSDI
			@Empresa       	char(5),
			@Sucursal      	int,
			@Categoria     	varchar(50),
			@Puesto     	varchar(50),
			@Personal      	char(10),
			@AnosCumplidos 	int,
			@SueldoDiario  	money,
			@TipoSueldo 	varchar(10),
			@EnSilencio	int 		= 0,
		    	@SDI     	money		= NULL	OUTPUT,
			@ZonaEconomica	varchar(50) 	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Factor  		float,
    @Dias    		int,
    @GravableIMSS 	money,
    @FechaD   		datetime,
    @FechaA   		datetime,
    @Fecha    		datetime,
    @Autotransportes	bit,
    @CANAPAT		bit, 
    @FactorCANAPAT	float,
    @SDIMaximo          money,
    @Jornada		varchar(20)

  SELECT @Dias		= 0,
         @GravableIMSS  = 0,
         @CANAPAT       = 0,
         @FactorCANAPAT = NULL,
         @SDI		= NULL

  EXEC xpVerSDI @Empresa, @Sucursal, @Categoria, @Personal, @AnosCumplidos, @SueldoDiario, @TipoSueldo, @EnSilencio, @SDI OUTPUT, @ZonaEconomica
  IF @SDI IS NOT NULL
  BEGIN
    IF @EnSilencio = 0
      SELECT "SDI" = @SDI
    RETURN
  END

  SELECT @Jornada = Jornada, @ZonaEconomica = ISNULL(@ZonaEconomica, ZonaEconomica) FROM Personal WHERE Personal = @Personal

  SELECT @Autotransportes = ISNULL(Autotransportes, 0) FROM EmpresaGral WHERE Empresa = @Empresa
  IF @Autotransportes = 1
    SELECT @CANAPAT = AutoCANAPAT FROM EmpresaCfg2 WHERE Empresa = @Empresa

  IF @CANAPAT = 1
  BEGIN
    SELECT @FactorCANAPAT = NULLIF(FactorCANAPAT, 0) FROM PersonalCat WHERE Categoria = @Categoria
    SELECT @SDI = @FactorCANAPAT * SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica
  END
  
  IF @SDI IS NULL
  BEGIN
    SELECT @Fecha= GETDATE()
    EXEC spNominaDiasBimestre  @Fecha, @FechaD  OUTPUT,  @FechaA  OUTPUT
    IF UPPER(@TipoSueldo) <> 'FIJO'
    BEGIN 
      EXEC spNominaAcumuladoFechas @Empresa, @Personal,'Sueldo', @FechaD, @FechaA, NULL, NULL, @Dias OUTPUT    
      EXEC spNominaAcumuladoFechas @Empresa, @Personal,'Acumulado Gravable IMSS', @FechaD, @FechaA, NULL, @GravableIMSS OUTPUT, NULL
    END

    EXEC spNominaFactorIntegracion @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @AnosCumplidos, @Factor OUTPUT
    IF ISNULL(@Dias, 0) > 0
      SELECT @SDI = (@Factor * @SueldoDiario)+(ISNULL(@GravableIMSS, 0)/@Dias)
    ELSE
      SELECT @SDI = (@Factor * @SueldoDiario)
	
	-- Suma al SDI los pagos fijos (Artículo 30 fracción I de la Ley del Seguro Social)
	EXEC xpSDIFijo @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @SueldoDiario, @SDI OUTPUT
    
  END
--Inicia  condicion para que el sdi no Exceda a 25 veces el salario minimo del DF segun dice la ley*/
    SELECT @SDIMaximo     = 25.0 * ISNULL( SueldoMinimo, 0 ) FROM ZonaEconomica WHERE Zona='A'
    IF @SDI > @SDIMaximo 
      SELECT @SDI = @SDIMaximo

    -- esto sirve para checar que el SDI no quede por debajo del minimo de la ZonaEconomica y Que no Sea jornada Reducida
    IF ISNULL((SELECT JornadaReducida FROM Jornada WHERE Jornada = @Jornada), 0) = 0
      IF EXISTS(SELECT SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica AND SueldoMinimo>@SDI)
       SELECT @SDI = SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica

--Termina  condicion para que el sdi no Exceda a 25 veces el salario minimo del DF segun dice la ley*/
  IF @EnSilencio = 0
    SELECT "SDI" = @SDI
  RETURN
END
GO

/**************** spNominaIMSS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaIMSS') and type = 'P') drop procedure dbo.spNominaIMSS
GO             
CREATE PROCEDURE spNominaIMSS
  			@Empresa				char(5), 
			@SucursalTrabajo			int, 
			@Categoria				varchar(50), 
			@Puesto					varchar(50), 
			@Personal				char(10),
                 	@SDI                  			money,
                 	@DiasPeriodo          			int,
                 	@Incapacidades        			int,  
                 	@Faltas               			int,
          	 	@SMGDF                                  money,
			@CalcPatron				bit,
          	 	@IMSSObrero    				money	= NULL OUTPUT,
			@IMSSObreroCV				money	= NULL OUTPUT,
          	 	@IMSSPatron    				money	= NULL OUTPUT,
    		        @IMSSPatronMensual		        money	= NULL OUTPUT,
			@IMSSPatronCV				money	= NULL OUTPUT,
			@IMSSPatronRetiro			money	= NULL OUTPUT,
			@IMSSPatronInfonavit			money	= NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SDITopadoMaternidad                money,
    @IMSSObreroPrestacionesDinero       money,
    @SDITopado                          money,
    @IMSSObreroCoutaAdicionalExcedente  money,
    @IMSSObreroCuotaAdicionalMinimo     money,
    @IMSSObreroGastosMedicos            money,
    @IMSSObreroIV                       money,
    @IMSSObreroCuotaAdicional           money,
    @IMSSObreroEMExecenteTope           float,
    @IMSSObreroCVTope                   float,
    @IMSSObreroGastosMedicosTope        float,
    @IMSSObreroIVTope                   float,
    @IMSSObreroPrestacionesDineroTope   float,
    @IMSSObreroEMExcedentePct        	float,
    @IMSSObreroPrestacionesDineroPct 	float,
    @IMSSObreroGastosMedicosPct      	float,
    @IMSSObreroIVPct                 	float,
    @IMSSObreroCVPct                 	float,
    @IMSSPatronGastosMedicos            money,
    @IMSSPatronIV                       money,
    @IMSSPatronCuotaAdicional           money,
    @IMSSPatronCuotaFija	        money,
    @IMSSPatronRiesgo			money,
    @IMSSPatronGuarderias		money,
    @IMSSPatronPrestacionesDinero       money,
    @IMSSPatronInfonavitTope		float,
    @IMSSPatronRetiroTope		float,
    @IMSSPatronEMExcedentePct        	float,
    @IMSSPatronPrestacionesDineroPct 	float,
    @IMSSPatronGastosMedicosPct      	float,
    @IMSSPatronIVPct                 	float,
    @IMSSPatronCVPct                 	float,
    @IMSSPatronRiesgoPct             	float,
    @IMSSPatronGuarderiasPct         	float,
    @IMSSPatronInfonavitPct          	float,
    @IMSSPatronRetiroPct             	float,
    @IMSSPatronEMCuotaFijaPct  		float

  -- Obrero
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Obrero EM Excente', 	  	@IMSSObreroEMExecenteTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Obrero CV', 		  	@IMSSObreroCVTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Obrero Gastos Medicos',	@IMSSObreroGastosMedicosTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Obrero IV',			@IMSSObreroIVTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Obrero Prestaciones Dinero',	@IMSSObreroPrestacionesDineroTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Obrero EM Excedente',		@IMSSObreroEMExcedentePct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Obrero Prestaciones Dinero',	@IMSSObreroPrestacionesDineroPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Obrero Gastos Medicos',		@IMSSObreroGastosMedicosPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Obrero IV',				@IMSSObreroIVPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Obrero CV',				@IMSSObreroCVPct OUTPUT 

  IF (@IMSSObreroEMExecenteTope * @SMGDF) < @SDI SELECT @SDITopadoMaternidad = @IMSSObreroEMExecenteTope * @SMGDF ELSE SELECT @SDITopadoMaternidad = @SDI
  IF @SDI > ( @SMGDF * @IMSSObreroPrestacionesDineroTope) SELECT @SDITopado = @SMGDF * @IMSSObreroPrestacionesDineroTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSObreroPrestacionesDinero = @IMSSObreroPrestacionesDineroPct / 100.0 * (@DiasPeriodo - @Incapacidades) * @SDITopado

  IF @SDI > ( @SMGDF * @IMSSObreroGastosMedicosTope) SELECT @SDITopado = @SMGDF * @IMSSObreroGastosMedicosTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSObreroGastosMedicos = @IMSSObreroGastosMedicosPct/100.0 * (@DiasPeriodo-@Incapacidades) * @SDITopado

  IF @SDI > (@SMGDF * @IMSSObreroIVTope) SELECT @SDITopado = @SMGDF * @IMSSObreroIVTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSObreroIV = @IMSSObreroIVPct / 100.0 *  (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado

  IF @SDI > ( @SMGDF * @IMSSObreroCVTope) SELECT @SDITopado = @SMGDF * @IMSSObreroCVTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSObreroCV = @IMSSObreroCVPct/100.0 *  (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado

  SELECT @IMSSObreroCuotaAdicionalMinimo = @SMGDF * 3.0
  IF (@SDITopadoMaternidad-@IMSSObreroCuotaAdicionalMinimo) > 0
    SELECT @IMSSObreroCoutaAdicionalExcedente = @SDITopadoMaternidad-@IMSSObreroCuotaAdicionalMinimo
  ELSE
    SELECT @IMSSObreroCoutaAdicionalExcedente = 0
  SELECT @IMSSObreroCuotaAdicional = (@DiasPeriodo-@Incapacidades)*@IMSSObreroCoutaAdicionalExcedente*@IMSSObreroEMExcedentePct/100.0

  SELECT @IMSSObrero = @IMSSObreroCuotaAdicional + @IMSSObreroCV + @IMSSObreroIV + @IMSSObreroGastosMedicos + @IMSSObreroPrestacionesDinero

  IF @CalcPatron = 0 RETURN

  -- Patron
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Patron Infonavit', 	  	@IMSSPatronInfonavitTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# IMSS Tope Patron Retiro', 	  	@IMSSPatronRetiroTope OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron EM Excedente',		@IMSSPatronEMExcedentePct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron Prestaciones Dinero',	@IMSSPatronPrestacionesDineroPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron Gastos Medicos',		@IMSSPatronGastosMedicosPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron IV',				@IMSSPatronIVPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron CV',				@IMSSPatronCVPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron Riesgo',			@IMSSPatronRiesgoPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron Guarderias',			@IMSSPatronGuarderiasPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron Retiro',			@IMSSPatronRetiroPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% Infonavit Patron ',			@IMSSPatronInfonavitPct OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% IMSS Patron EM Cuota Fija',		@IMSSPatronEMCuotaFijaPct OUTPUT 

  IF @SDI > ( @SMGDF * @IMSSObreroPrestacionesDineroTope) SELECT @SDITopado = @SMGDF * @IMSSObreroPrestacionesDineroTope ELSE  SELECT @SDITopado = @SDI
  SELECT @IMSSPatronRiesgo = (@IMSSPatronRiesgoPct/100.0) * (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado
  SELECT @IMSSPatronPrestacionesDinero = (@IMSSPatronPrestacionesDineroPct/100.0) * (@DiasPeriodo-@Incapacidades) * @SDITopado
  SELECT @IMSSPatronGuarderias = (@IMSSPatronGuarderiasPct/100.0) * (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado

  IF @SDI > (@SMGDF * @IMSSObreroIVTope) SELECT @SDITopado = @SMGDF * @IMSSObreroIVTope ELSE SELECT @SDITopado = @SDI 
  SELECT @IMSSPatronIV = (@IMSSPatronIVPct/100.0) * (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado

  IF @SDI > ( @SMGDF * @IMSSObreroGastosMedicosTope) SELECT @SDITopado = @SMGDF * @IMSSObreroGastosMedicosTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSPatronGastosMedicos = (@IMSSPatronGastosMedicosPct/100.0) * (@DiasPeriodo-@Incapacidades) * @SDITopado

  SELECT @IMSSPatronMensual = @IMSSPatronRiesgo + @IMSSPatronPrestacionesDinero + @IMSSPatronGuarderias + @IMSSPatronIV + @IMSSPatronGastosMedicos

  IF @SDI > (@SMGDF * @IMSSPatronInfonavitTope) SELECT @SDITopado = @SMGDF * @IMSSPatronInfonavitTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSPatronInfonavit = (@IMSSPatronInfonavitPct/100.0) * (@DiasPeriodo-@Faltas) * @SDITopado

  IF @SDI > ( @SMGDF * @IMSSObreroCVTope) SELECT @SDITopado = @SMGDF * @IMSSObreroCVTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSPatronCV = (@IMSSPatronCVPct/100.0) * (@DiasPeriodo-@Incapacidades-@Faltas) * @SDITopado

  IF @SDI > (@SMGDF * @IMSSPatronRetiroTope) SELECT @SDITopado = @SMGDF * @IMSSPatronRetiroTope ELSE SELECT @SDITopado = @SDI
  SELECT @IMSSPatronRetiro = (@IMSSPatronRetiroPct/100.0) * (@DiasPeriodo-@Faltas) * @SDITopado

  IF (@IMSSObreroEMExecenteTope * @SMGDF) < @SDI 
    SELECT @SDITopadoMaternidad = @IMSSObreroEMExecenteTope * @SMGDF
  ELSE
    SELECT @SDITopadoMaternidad = @SDI

  SELECT @IMSSObreroCuotaAdicionalMinimo = @SMGDF * 3.0
  IF (@SDITopadoMaternidad-@IMSSObreroCuotaAdicionalMinimo) > 0
    SELECT @IMSSObreroCoutaAdicionalExcedente = @SDITopadoMaternidad-@IMSSObreroCuotaAdicionalMinimo
  ELSE
    SELECT @IMSSObreroCoutaAdicionalExcedente = 0
  SELECT @IMSSPatronCuotaAdicional = (@DiasPeriodo-@Incapacidades) * @IMSSObreroCoutaAdicionalExcedente*(@IMSSPatronEMExcedentePct/100.0)

  SELECT @IMSSPatronCuotaFija = @SMGDF * (@DiasPeriodo-@Incapacidades) * (@IMSSPatronEMCuotaFijaPct/100.0)

  SELECT @IMSSPatron = @IMSSPatronMensual + @IMSSPatronCuotaAdicional + @IMSSPatronCuotaFija 

  EXEC xpNominaIMSS @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @SDI, @DiasPeriodo, @Incapacidades, @Faltas,
		    @SMGDF, @CalcPatron, @IMSSObrero, @IMSSObreroCV, @IMSSPatron, @IMSSPatronMensual, @IMSSPatronCV, @IMSSPatronRetiro,
		    @IMSSPatronInfonavit, @SDITopadoMaternidad, @IMSSObreroPrestacionesDinero, @SDITopado, @IMSSObreroCoutaAdicionalExcedente,
		    @IMSSObreroCuotaAdicionalMinimo, @IMSSObreroGastosMedicos, @IMSSObreroIV, @IMSSObreroCuotaAdicional, @IMSSObreroEMExecenteTope,
		    @IMSSObreroCVTope, @IMSSObreroGastosMedicosTope, @IMSSObreroIVTope, @IMSSObreroPrestacionesDineroTope, @IMSSObreroEMExcedentePct,
		    @IMSSObreroPrestacionesDineroPct, @IMSSObreroGastosMedicosPct, @IMSSObreroIVPct, @IMSSObreroCVPct, @IMSSPatronGastosMedicos,
		    @IMSSPatronIV, @IMSSPatronCuotaAdicional, @IMSSPatronCuotaFija, @IMSSPatronRiesgo, @IMSSPatronGuarderias,
		    @IMSSPatronPrestacionesDinero, @IMSSPatronInfonavitTope, @IMSSPatronRetiroTope, @IMSSPatronEMExcedentePct,
		    @IMSSPatronPrestacionesDineroPct, @IMSSPatronGastosMedicosPct, @IMSSPatronIVPct, @IMSSPatronCVPct,
		    @IMSSPatronRiesgoPct, @IMSSPatronGuarderiasPct, @IMSSPatronInfonavitPct, @IMSSPatronRetiroPct, @IMSSPatronEMCuotaFijaPct
  RETURN
END
GO

/*

Declare @TotalIMSSObrero money
Select @TotalIMSSObrero = 0
           --sdi,dias,incapacidades,faltas 
Exec spIMSS  964.00, 15,4,4,@TotalIMSSObrero output
Select @TotalIMSSObrero 	
select * from periodotipo
select * from tablaimpuestod
*/


/*
declare
   @ISR  money
 exec spNominaISR 'Quincenal', 5713.46, 100, @ISR output
 SELECT @isr
*/

/**************** spNominaISR ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaISR') and type = 'P') drop procedure dbo.spNominaISR

go
CREATE PROCEDURE spNominaISR
  			@PeriodoTipo		char(20),
  			@Sueldo         	money,
  			@SubsidioAcreditable	float,
  			@TotalISR		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ISR		money,
    @Subsidio		money,
    @SubsidioNeto	money,
    @Credito		money,
    @DiasPeriodo 	int


  SELECT @ISR = NULL, @Subsidio = NULL, @Credito = NULL
  SELECT @DiasPeriodo = DiasPeriodo FROM PeriodoTipo WHERE PeriodoTipo = @Periodotipo
  SELECT @Sueldo      = @Sueldo / @DiasPeriodo * 30
  EXEC   spTablaImpuesto 'ISR', NULL,     	     'Mensual', @Sueldo,  	@ISR 		OUTPUT
  EXEC   spTablaImpuesto 'Subsidio', 'ISR',	     'Mensual', @Sueldo,    	@Subsidio 	OUTPUT
  EXEC   spTablaImpuesto 'Credito al Salario', NULL, 'Mensual', @Sueldo,     	@Credito 	OUTPUT
  SELECT @SubsidioNeto = ( ISNULL(@Subsidio, 0.0) * (ISNULL(@SubsidioAcreditable, 100.0) /100.0))
  SELECT @TotalISR     = ( ISNULL(@ISR, 0.0) - @SubsidioNeto - ISNULL(@Credito, 0.0) ) * @DiasPeriodo / 30.0

  RETURN
END
GO

/**************** spNominaISRAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaISRAnual') and type = 'P') drop procedure dbo.spNominaISRAnual
go
CREATE PROCEDURE spNominaISRAnual
  			@SueldoAcumulado	money,
  			@SubsidioAcreditable	float,
  			@TotalISR		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ISR		money,
    @Subsidio		money,
    @SubsidioNeto	money,
    @Credito		money,
    @DiasPeriodo 	int

  SELECT @ISR = NULL, @Subsidio = NULL, @Credito = NULL
  EXEC   spTablaImpuesto 'ISR', NULL,     	     'Anual', @SueldoAcumulado,  	@ISR 		OUTPUT
  EXEC   spTablaImpuesto 'Subsidio', 'ISR',	     'Anual', @SueldoAcumulado,    	@Subsidio 	OUTPUT
  EXEC   spTablaImpuesto 'Credito al Salario', NULL, 'Anual', @SueldoAcumulado,     	@Credito 	OUTPUT
  SELECT @SubsidioNeto = ISNULL(@Subsidio, 0.0) * (ISNULL(@SubsidioAcreditable, 100.0) /100.0)
  SELECT @TotalISR     = ISNULL(@ISR, 0.0) - @SubsidioNeto - ISNULL(@Credito, 0.0)

  RETURN
END
GO

/**************** spNominaISRProporcional ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaISRProporcional') and type = 'P') drop procedure dbo.spNominaISRProporcional
go
CREATE PROCEDURE spNominaISRProporcional
			@DiasPeriodo		float,
			@DiasMes		float,	
  			@ImportePeriodo        	money,
  			@SubsidioAcreditable	float,
  			@ISRNeto		money	OUTPUT,
			@Credito		money	OUTPUT,
			@SubsidioNeto		money	OUTPUT,
			@ISRBruto		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteMensual	money,
    @Subsidio		money,
    @FactorDiasMes	float

  SELECT @ISRBruto = NULL, @Subsidio = NULL, @Credito = NULL, @FactorDiasMes = @DiasPeriodo / NULLIF(@DiasMes, 0)
  SELECT @ImporteMensual = @ImportePeriodo / NULLIF(@FactorDiasMes, 0)
  EXEC   spTablaImpuesto 'ISR', NULL,     	     'Mensual', @ImporteMensual,  	@ISRBruto	OUTPUT
  EXEC   spTablaImpuesto 'Subsidio', 'ISR',	     'Mensual', @ImporteMensual,    	@Subsidio 	OUTPUT
  EXEC   spTablaImpuesto 'Credito al Salario', NULL, 'Mensual', @ImporteMensual,     	@Credito 	OUTPUT
  SELECT @SubsidioNeto = ( ISNULL(@Subsidio, 0.0) * (ISNULL(@SubsidioAcreditable, 100) /100))
  SELECT @ISRNeto     = ( ISNULL(@ISRBruto, 0.0) - @SubsidioNeto - ISNULL(@Credito, 0.0) ) 

  -- Para convertir de Mensual a Periodo
  SELECT @ISRNeto = @ISRNeto * @FactorDiasMes, @Credito = @Credito * @FactorDiasMes, @SubsidioNeto = @SubsidioNeto * @FactorDiasMes, @ISRBruto = @ISRBruto * @FactorDiasMes

  RETURN
END
GO


/**************** spVerNominaCalculoInverso ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerNominaCalculoInverso') and type = 'P') drop procedure dbo.spVerNominaCalculoInverso

go
CREATE PROCEDURE spVerNominaCalculoInverso
			@Empresa	 	char(5),
			@SueldoDeseado         	money,
			@PeriodoTipo		char(20),
			@AnosCumplidos	 	int,
			@Personal		char(10) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo				  int,
    @FactorIntegracion			  float,
    @DiasPeriodo          		  int,
    @SueldoBruto			  money,
    @SueldoNeto				  money,
    @SDI                  		  money,
    @SMGDF                                money,
    @SubsidioAcreditable	    	  float,
    @ISR				  money,
    @IMSSObrero				  money,
    @RedondeoMonetarios			  int,
    @Sucursal 				  int, 
    @Categoria                  	  varchar(50),
    @Puesto				  varchar(50)

  SELECT @Sucursal=SucursalTrabajo, @Categoria=Categoria, @Puesto=Puesto FROM Personal WHERE Personal=@Personal
  SELECT @SueldoBruto = NULL
  SELECT @DiasPeriodo = DiasPeriodo FROM PeriodoTipo WHERE PeriodoTipo = @PeriodoTipo
  EXEC xpVerNominaCalculoInverso @Empresa, @SueldoDeseado, @PeriodoTipo, @AnosCumplidos, @Personal, @DiasPeriodo, @SueldoBruto OUTPUT
  IF @SueldoBruto IS NOT NULL
  BEGIN
    SELECT "SueldoBruto" = @SueldoBruto, "SueldoDiario" = @SueldoBruto/@DiasPeriodo
    RETURN
  END
  SELECT @RedondeoMonetarios = dbo.fnRedondeoMonetarios()
  EXEC spNominaFactorIntegracion @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @AnosCumplidos, @FactorIntegracion OUTPUT
  SELECT @Conteo = 0

  SELECT @SMGDF = SueldoMinimo FROM ZonaEconomica WHERE Zona = 'A'
  EXEC spPersonalPropValorFloat @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, '% Subsidio Acreditable', @SubsidioAcreditable OUTPUT 
  SELECT @SueldoBruto = @SueldoDeseado * 1.2, @SueldoNeto = 0.0
  WHILE ROUND(@SueldoDeseado, @RedondeoMonetarios) <> ROUND(@SueldoNeto, @RedondeoMonetarios) AND @Conteo < 100
  BEGIN
    EXEC spNominaISR @PeriodoTipo, @SueldoBruto, @SubsidioAcreditable, @ISR OUTPUT
    SELECT @SDI = (@SueldoBruto/@DiasPeriodo) * @FactorIntegracion


    EXEC spNominaIMSS @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, @SDI, @DiasPeriodo, 0, 0, @SMGDF, 0,
                      @IMSSObrero = @IMSSObrero OUTPUT
    SELECT @SueldoNeto = @SueldoBruto - @ISR - @IMSSObrero
    IF @SueldoNeto <> @SueldoDeseado
      SELECT @SueldoBruto = @SueldoBruto + @SueldoDeseado - @SueldoNeto
    SELECT @Conteo = @Conteo + 1
  END
  SELECT "SueldoBruto" = @SueldoBruto, "SueldoDiario" = @SueldoBruto/@DiasPeriodo
  RETURN
END
go
-- exec spVerNominaCalculoInverso  'demo', 5000, 'Quincenal', 3

/******** spSUAMovimientos *************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'spSUAMovimientos ' and type = 'P') DROP PROCEDURE spSUAMovimientos 
go
CREATE PROCEDURE spSUAMovimientos 
                 @EMPRESA CHAR(10),
                 @FechaD DATETIME,  
                 @FechaA DATETIME 
--//WITH ENCRYPTION
AS BEGIN
  CREATE TABLE #SUAMovimiento(
            RegistroPatronal 	CHAR(11) 	COLLATE Database_Default ,
            IMSS 		CHAR(11)	COLLATE Database_Default ,
            TipoMovimiento 	CHAR(2)		COLLATE Database_Default ,
            FechaMovimiento 	CHAR(8)		COLLATE Database_Default ,
            FolioIncapacidad 	CHAR(8)		COLLATE Database_Default ,
            Dias 		CHAR(2)		COLLATE Database_Default ,
            SDI 		MONEY)

  INSERT INTO #SUAMovimiento (RegistroPatronal,Imss,TipoMovimiento,FechaMovimiento,SDI,DIAS,FolioIncapacidad)
  SELECT DISTINCT
    CAST(RIGHT(ISNULL(PersonalPropValor.Valor,''),11) AS CHAR(11)) RegistroPatronal,
    CAST(RIGHT(ISNULL(Registro3,''),11) AS CHAR(11))               IMSS,
    TipoMovimiento = CASE A.Mov
                     WHEN 'Modificaciones'		THEN '07'
                     WHEN 'Altas'				THEN '08'
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
    A.FechaEmision BETWEEN @FechaD AND @FechaA AND
    B.Personal=Personal.Personal  AND
    A.EMPRESA=@Empresa AND
    A.ID=B.ID AND
    PersonalPropValor.Rama      =  'SUC'  AND 
    PersonalPropValor.Cuenta    =  Personal.SucursalTrabajo   AND 
    PersonalPropValor.Propiedad =  'Registro Patronal'  AND
    A.Estatus='Concluido' AND
    A.Mov IN('ALTAS','Modificaciones','Bajas','Alta Reg. Patronal','Baja Reg. Patronal')
  ORDER BY FechaEmision


  INSERT INTO #SUAMovimiento (RegistroPatronal,Imss,TipoMovimiento,FechaMovimiento,dias,FolioIncapacidad,SDI)
  SELECT 
    CAST(RIGHT(ISNULL(PersonalPropValor.Valor,''),11) AS CHAR(11)) RegistroPatronal,
    CAST(RIGHT(ISNULL(Registro3,''),11) AS CHAR(11))               IMSS,
    TipoMovimiento = CASE Nomina.Mov
                       WHEN 'Incapacidades' THEN '12'
                       WHEN 'Faltas'        THEN '11'
                     END,
    RIGHT('0'+LTRIM(DATEPART(dd,Nomina.FechaEmision)),2)+RIGHT('0'+LTRIM(DATEPART(mm,Nomina.FechaEmision)),2)+LTRIM(DATEPART(yyyy,Nomina.FechaEmision)) FECHAEMISION,
    LEFT('0'+LTRIM(RIGHT(Convert(CHAR, ISNULL(NominaD.Cantidad,0)),20)),2),
    ISNULL(NominaD.Referencia,''),0
  FROM 
    Nomina, 
    NominaD, 
    Personal, 
    PersonalPropValor 
  WHERE
    Nomina.FechaEmision BETWEEN @FechaD AND @FechaA AND
    NominaD.id=Nomina.id AND
    Nomina.EMPRESA=@Empresa AND
    Mov in('Incapacidades','Faltas') AND 
    Nomina.Estatus in('PROCESAR','CONCLUIDO') AND 
    NominaD.Personal            = Personal.Personal AND
    PersonalPropValor.Rama      =  'SUC'  AND 
    PersonalPropValor.Cuenta    =  Personal.SucursalTrabajo   AND 
    PersonalPropValor.Propiedad =  'Registro Patronal'
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
go


/********** spNominaTotales ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spNominaTotales' and type = 'P') DROP PROCEDURE spNominaTotales 
go
CREATE PROCEDURE spNominaTotales 
                   @Empresa Char(10),
                   @FechaD  DateTime,  
                   @FechaA  DateTime,
                   @DiasAno Float   
--//WITH ENCRYPTION
AS BEGIN
  Declare @Incapacidades         Float,
          @DiasTrabajados        Float,
          @FaltasDias            Float,
          @FaltasImporte         Float,
          @TrabajadoresExpuestos Float,          
          @ImporteTrabajado      money

  SELECT 
    @DiasTrabajados=ISNULL(Sum(NominaD.Cantidad),0) 
  FROM 
    Movtipo,Nomina,NominaD 
  WHERE 
    Clave='NOM.N' AND 
    MovTipo.Mov=Nomina.Mov AND 
    Nomina.ID=NominaD.ID AND 
    Nomina.Estatus='CONCLUIDO' AND
    Nominad.Concepto in('Sueldo Normal') AND
    Nomina.Empresa=@Empresa AND
    Nomina.FechaD Between @FechaD AND @FechaA

  SELECT 
    @ImporteTrabajado=ISNULL(Sum(NominaD.Importe),0)
  FROM 
    Movtipo,Nomina,NominaD 
  WHERE 
    Clave='NOM.N' AND 
    MovTipo.Mov=Nomina.Mov AND 
    Nomina.ID=NominaD.ID AND 
    Nomina.Estatus='CONCLUIDO' AND
    Nominad.Concepto in('Sueldo Normal') AND
    Nomina.Empresa=@Empresa AND
    Nomina.FechaD Between @FechaD AND @FechaA


  SELECT 
    @FaltasDias=-ISNULL(Sum(NominaD.Cantidad),0) 
  FROM 
    Movtipo,Nomina,NominaD 
  WHERE 
    Clave='NOM.N' AND 
    MovTipo.Mov=Nomina.Mov AND 
    Nomina.ID=NominaD.ID AND 
    Nomina.Estatus='CONCLUIDO' AND
    Nominad.Concepto in('Faltas') AND
    Nomina.Empresa=@Empresa AND
    Nomina.FechaD Between @FechaD AND @FechaA

  SELECT 
    @FaltasImporte=-ISNULL(Sum(NominaD.Importe),0)
  FROM 
    Movtipo,Nomina,NominaD 
  WHERE 
    Clave='NOM.N' AND 
    MovTipo.Mov=Nomina.Mov AND 
    Nomina.ID=NominaD.ID AND 
    Nomina.Estatus='CONCLUIDO' AND
    Nominad.Concepto in('Faltas') AND
    Nomina.Empresa=@Empresa AND
    Nomina.FechaD Between @FechaD AND @FechaA


  SELECT 
    @Incapacidades=ISNULL(Sum(NominaD.Cantidad),0)
  FROM 
    Movtipo,Nomina,NominaD 
  WHERE 
    Clave='NOM.N' AND 
    MovTipo.Mov=Nomina.Mov AND 
    Nomina.ID=NominaD.ID AND 
    Nomina.Estatus='CONCLUIDO' AND
    Nominad.Concepto in('Incapacidades') AND
    Nomina.Empresa=@Empresa AND
    Nomina.FechaD Between @FechaD AND @FechaA

    SELECT @TrabajadoresExpuestos = (@DiasTrabajados -@FaltasDias- @Incapacidades)/@DiasAno
    
    SELECT @DiasTrabajados DiasTrabajados,@Incapacidades Incapacidades,@FaltasDias FaltasDias,@FaltasImporte FaltasImporte,@ImporteTrabajado ImporteTrabajado, @TrabajadoresExpuestos TrabajadoresExpuestos  into #Totales
    Select * from #totales
END
GO

/********** spPersonalBloquear ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spPersonalBloquear' and type = 'P') DROP PROCEDURE spPersonalBloquear
go
CREATE PROCEDURE spPersonalBloquear
			@Personal	char(10),
			@Estatus	char(15)
--//WITH ENCRYPTION
AS BEGIN
  UPDATE Personal SET Estatus = @Estatus WHERE Personal = @Personal
END
GO

/********** spNominaCancelacionParcial ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spNominaCancelacionParcial' and type = 'P') DROP PROCEDURE spNominaCancelacionParcial
go
CREATE PROCEDURE spNominaCancelacionParcial
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@ID		int,
			@Personal	char(10),
			@FechaEmision	datetime = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mov	char(20),
    @Concepto	varchar(50),
    @Referencia	varchar(50),
    @Importe	money,
    @Cantidad	float,
    @Renglon	float,
    @IDNuevo	int,
    @Origen	char(20),
    @OrigenID	varchar(20)

  SELECT @Mov = NomCancelacionParcial
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @Origen = Mov, @OrigenID = MovID FROM Nomina WHERE ID = @ID

  IF EXISTS(SELECT * FROM Nomina n, NominaD d WHERE n.Mov = @Mov AND n.Empresa = @Empresa AND n.OrigenTipo = 'NOM' AND n.Origen = @Origen AND OrigenID = @OrigenID AND n.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') AND d.ID = n.ID AND d.Personal = @Personal)
  BEGIN
    SELECT 'Esta Persona Ya Tiene una Cancelacion Parcial Realizada '+RTRIM(@Personal)
    RETURN
  END

  BEGIN TRANSACTION 
    INSERT Nomina (Sucursal,  SucursalOrigen, SucursalDestino, Empresa,  Mov,  FechaEmision,                         FechaCancelacion, Proyecto, Usuario,  Moneda, TipoCambio,  Estatus,    FechaOrigen, PeriodoTipo, FechaD, FechaA, OrigenTipo, Origen, OrigenID)
    SELECT Sucursal,         @Sucursal,      Sucursal,       @Empresa, @Mov, ISNULL(@FechaEmision, FechaEmision),  GETDATE(),        Proyecto, @Usuario,  Moneda, TipoCambio, 'BORRADOR', FechaOrigen, PeriodoTipo, FechaD, FechaA, 'NOM',      @Origen, @OrigenID
      FROM Nomina
     WHERE ID = @ID
    SELECT @IDNuevo = SCOPE_IDENTITY()

    SELECT * INTO #NominaD FROM cNominaD WHERE ID = @ID AND Personal = @Personal
    UPDATE #NominaD SET SucursalOrigen = @Sucursal, ID = @IDNuevo, Importe = -Importe, Cantidad = -Cantidad
    INSERT INTO cNominaD SELECT * FROM #NominaD

    /* 
	Para calcular la proporcion que se debe de cancelar de los movimientos que afectan a cxp y dinero, 
        los conceptos de los movimientos deben exitir en un movimiento de la nomina.

    */
    DECLARE crNominaD CURSOR FOR
    SELECT Concepto, ISNULL(Referencia, ''), MIN(Renglon) 
      FROM NominaD 
     WHERE ID = @ID AND Modulo IN ('CXP', 'DIN', 'GAS')
     GROUP BY Concepto, ISNULL(Referencia, '')
    OPEN crNominaD
    FETCH NEXT FROM crNominaD INTO @Concepto, @Referencia, @Renglon
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Importe = NULL, @Cantidad = NULL
        SELECT @Importe = Importe, @Cantidad = Cantidad FROM NominaD WHERE ID = @ID AND Concepto = @Concepto AND ISNULL(Referencia, '') = @Referencia AND Modulo = 'NOM' AND Personal = @Personal
        IF @Importe IS NOT NULL
        BEGIN
          SELECT * INTO #NominaD2 FROM cNominaD WHERE ID = @ID AND Renglon = @Renglon
          UPDATE #NominaD2 SET SucursalOrigen = @Sucursal, ID = @IDNuevo, Importe = -@Importe, Cantidad = -@Cantidad, Referencia = NULL
          INSERT INTO cNominaD SELECT * FROM #NominaD2
          DROP TABLE #NominaD2
        END
      END
      FETCH NEXT FROM crNominaD INTO @Concepto, @Referencia, @Renglon
    END  -- While
    CLOSE crNominaD
    DEALLOCATE crNominaD

  IF EXISTS(SELECT * FROM NominaD WHERE ID = @IDNuevo)
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Genero '+RTRIM(@Mov)+' en Borrador.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'La Persona Indicada No Existe, En Este Movimiento.'
  END
  
  RETURN
END
GO

/********** spNominaEliminacionParcial ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spNominaEliminacionParcial' and type = 'P') DROP PROCEDURE spNominaEliminacionParcial
go
CREATE PROCEDURE spNominaEliminacionParcial
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@ID		int,
			@Personal	char(10),
			@FechaEmision	datetime = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto	varchar(50),
    @Referencia	varchar(50),
    @Importe	money,
    @Cantidad	float,
    @Renglon	float,
    @IDNuevo	int

  BEGIN TRANSACTION 
    /* 
	Para calcular la proporcion que se debe de cancelar de los movimientos que afectan a cxp y dinero, 
        los conceptos de los movimientos deben exitir en un movimiento de la nomina.

    */
    DECLARE crNominaD CURSOR FOR
    SELECT Concepto, ISNULL(Referencia, ''), MIN(Renglon) 
      FROM NominaD 
     WHERE ID = @ID AND Modulo IN ('CXP', 'DIN', 'GAS')
     GROUP BY Concepto, ISNULL(Referencia, '')
    OPEN crNominaD
    FETCH NEXT FROM crNominaD INTO @Concepto, @Referencia, @Renglon
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Importe = NULL, @Cantidad = NULL
        SELECT @Importe = ISNULL(Importe, 0), @Cantidad = ISNULL(Cantidad, 0) FROM NominaD WHERE ID = @ID AND Concepto = @Concepto AND ISNULL(Referencia, '') = @Referencia AND Modulo = 'NOM' AND Personal = @Personal
        IF @Importe IS NOT NULL
          UPDATE NominaD SET Importe = NULLIF(ISNULL(Importe, 0)-@Importe, 0), Cantidad = NULLIF(ISNULL(Cantidad, 0)-@Cantidad, 0) WHERE ID = @ID AND Concepto = @Concepto AND ISNULL(Referencia, '') = @Referencia AND Modulo IN ('CXP', 'DIN', 'GAS')
      END
      FETCH NEXT FROM crNominaD INTO @Concepto, @Referencia, @Renglon
    END  -- While
    CLOSE crNominaD
    DEALLOCATE crNominaD

    DELETE NominaD WHERE ID = @ID AND Personal = @Personal

    /*
    Bug 24358. Cuando hay incidencias, el generar el borrador de la nómina implica agregar registros en la tabla NominaCorrespondeLote.
               Si se elimina un empleado (Eliminación Parcial) de dicho borrador, también se debe eliminar esa información de la 
               tabla NominaCorrespondeLote.
    */
    DELETE NominaCorrespondeLote WHERE IDNomina = @ID AND Personal = @Personal

  IF @@ROWCOUNT > 0
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Elimino a '+RTRIM(@Personal)+' del Borrador.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'La Persona indicada No Existe, en este Movimiento.'
  END
  
  RETURN
END
GO

/********** spNominaEditarPorProcesar ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'spNominaEditarPorProcesar' and type = 'P') DROP PROCEDURE spNominaEditarPorProcesar
go
CREATE PROCEDURE spNominaEditarPorProcesar
			@ID		int,
			@Renglon	float,
			@Cantidad	float,
			@Importe	money
--//WITH ENCRYPTION
AS BEGIN
  IF (SELECT Estatus FROM Nomina WHERE ID = @ID) = 'PROCESAR'
  BEGIN
    IF @Cantidad IS NOT NULL
      UPDATE NominaD SET Cantidad = @Cantidad, CantidadPendiente = @Cantidad WHERE ID = @ID AND Renglon = @Renglon AND Cantidad = CantidadPendiente
    IF @Importe IS NOT NULL
      UPDATE NominaD SET Importe = @Importe, Saldo = @Importe WHERE ID = @ID AND Renglon = @Renglon AND Importe = Saldo
  END
  RETURN
END
GO

/**************** spNominaHD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaHD') and type = 'P') drop procedure dbo.spNominaHD
GO             
CREATE PROCEDURE spNominaHD
		   @Estacion		int,
    		   @Empresa		char(5),
		   @ID			int,
    		   @Mov			char(20),
    		   @FechaEmision	datetime,
    		   @Concepto		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Renglon	float,
    @Personal	char(10), 
    @Referencia	varchar(50),
    @Horas	varchar(5),
    @MovTipo	varchar(20),
    @FechaD	datetime,
    @FechaA	datetime,
    @Cantidad	float, 
    @Importe 	money

  SELECT @Renglon = 0.0

  DECLARE crNominaHD CURSOR FOR
   SELECT RTRIM(h.Personal), NULLIF(h.Cantidad, 0), NULLIF(h.Importe, 0), h.FechaD, h.FechaA, NULLIF(NULLIF(RTRIM(h.Horas), ''), '00'+CHAR(58)+'00'), NULLIF(RTRIM(h.Referencia), ''), mt.Clave
     FROM NominaH h, MovTipo mt
    WHERE h.Estacion = @Estacion AND h.Empresa = @Empresa AND h.Mov = @Mov AND h.FechaEmision = @FechaEmision AND ISNULL(h.Concepto, '') = ISNULL(@Concepto, '')
      AND NULLIF(RTRIM(h.Personal), '') IS NOT NULL
      AND mt.Modulo = 'NOM' AND mt.mov = h.Mov

  OPEN crNominaHD
  FETCH NEXT FROM crNominaHD INTO @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas, @Referencia, @MovTipo
  WHILE @@FETCH_STATUS <> -1 AND (@Cantidad IS NOT NULL OR @Importe IS NOT NULL)
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      IF @MovTipo = 'NOM.CH' AND @Horas IS NOT NULL
        EXEC spHorasToCantidad @Horas, @Cantidad OUTPUT
      INSERT NominaD (ID,  Renglon,  Personal,  Cantidad,  Importe,  FechaD,  FechaA,  Horas,  Referencia) 
              VALUES (@ID, @Renglon, @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas, @Referencia)
    END
    FETCH NEXT FROM crNominaHD INTO @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas, @Referencia, @MovTipo
  END  -- While
  CLOSE crNominaHD
  DEALLOCATE crNominaHD
  RETURN
END
GO

/**************** spNominaH ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaH') and type = 'P') drop procedure dbo.spNominaH
GO             
CREATE PROCEDURE spNominaH
		   @Estacion	int,
		   @Sucursal	int,
    		   @Empresa	char(5),
    		   @Usuario	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @IDGenerar		int,
    @Mov		char(20),
    @MovID		varchar(20),
    @FechaEmision	datetime,
    @FechaRegistro	datetime,
    @Concepto		varchar(50),
    @Moneda		char(10),
    @TipoCambio		float,
    @Ok			int,
    @OkRef		varchar(255),
    @Conteo		int,
    @Mensaje		varchar(255),
    @Proyecto		varchar(50),
    @UEN		int

  SELECT @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL, @Conteo = 0
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda      
  SELECT @Proyecto = DefProyecto, @UEN = UEN FROM Usuario WHERE Usuario = @Usuario

  BEGIN TRANSACTION 

  DECLARE crNominaH CURSOR FOR
   SELECT Mov, FechaEmision, NULLIF(RTRIM(Concepto), '')
     FROM NominaH
    WHERE Estacion = @Estacion AND Empresa = @Empresa
    GROUP BY Mov, FechaEmision, NULLIF(RTRIM(Concepto), '')
    ORDER BY Mov, FechaEmision, NULLIF(RTRIM(Concepto), '')

  OPEN crNominaH
  FETCH NEXT FROM crNominaH INTO @Mov, @FechaEmision, @Concepto
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT Nomina (Sucursal,  SucursalOrigen, Empresa,  Mov,  FechaEmision,  FechaOrigen,   Usuario,  Moneda,  TipoCambio,  Estatus,     Proyecto,  UEN,  Concepto)
             VALUES (@Sucursal, @Sucursal,      @Empresa, @Mov, @FechaEmision, @FechaEmision, @Usuario, @Moneda, @TipoCambio, 'CONFIRMAR', @Proyecto, @UEN, @Concepto)
      SELECT @ID = SCOPE_IDENTITY()
      EXEC spNominaHD @Estacion, @Empresa, @ID, @Mov, @FechaEmision, @Concepto
      EXEC xpNominaH @Estacion, @ID, @Ok OUTPUT, @OkRef OUTPUT

      IF @ID IS NOT NULL      
        EXEC spNomina @ID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @Mov, @MovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT
 
      IF @Ok IS NULL
      BEGIN
        DELETE NominaH WHERE Estacion = @Estacion AND Empresa = @Empresa AND Mov = @Mov AND FechaEmision = @FechaEmision AND ISNULL(Concepto, '') = ISNULL(@Concepto, '')
        SELECT @Conteo = @Conteo + 1
      END
    END
    FETCH NEXT FROM crNominaH INTO @Mov, @FechaEmision, @Concepto
  END  -- While
  CLOSE crNominaH
  DEALLOCATE crNominaH

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Movimientos Generados.'
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = RTRIM(Descripcion)+' '+@OkRef FROM MensajeLista WHERE Mensaje = @Ok  
  END
  SELECT @Mensaje

  RETURN
END
GO

--BUG19819
/**************** spNominaGenerarCampoExtra ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGenerarCampoExtra') and type = 'P') drop procedure dbo.spNominaGenerarCampoExtra
GO
CREATE PROC spNominaGenerarCampoExtra
			@ID				int, 
			@Proyecto		varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Estatus		varchar(15)
  
  SELECT @Estatus = Estatus FROM Nomina WHERE ID = @ID
  
  IF @Estatus = 'BORRADOR'
   UPDATE Nomina SET Proyecto = @Proyecto WHERE ID = @ID

  RETURN
END
GO

-- spNominaH 13, 0, 'DEMO', 'DEMO'

/**************** spNominaProrrateo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaProrrateo') and type = 'P') drop procedure dbo.spNominaProrrateo
GO             
CREATE PROCEDURE spNominaProrrateo
    @ID	                    int,
    @Ok                     int             OUTPUT,
    @OkRef                  varchar(255)    OUTPUT
--//WITH ENCRYPTION
AS BEGIN

  DECLARE
    @Empresa                varchar(5),
    @Sucursal               int,
    @Concepto               varchar(50),
    @CentroCostos           varchar(50),
    @Importe                money,

    @GenerarID              int,
    @GenerarMov             varchar(20),
    @GenerarMovID           varchar(20),

    @Mov                    varchar(20),
    @MovID                  varchar(20),
    @Usuario                varchar(10),
    @FechaEmision           datetime,
    @UltimoCambio           datetime,
    @Moneda                 varchar(10),
    @TipoCambio             float,
    @Renglon                float,
    @PorcentajeDeducible    float,
    @Proveedor              varchar(20),
    @GastoID                int

  DELETE FROM NominaProrrateoLog WHERE ID = @ID

  SELECT @Mov = Mov, @MovID = MovID, @Usuario = Usuario, @Moneda = Moneda, @TipoCambio = TipoCambio, @FechaEmision = FechaEmision FROM Nomina WHERE ID = @ID

  SELECT @UltimoCambio = GETDATE()
  --EXEC spExtraerFecha @FechaEmision OUTPUT

  SELECT nd.ID, nd.Movimiento, ec.Proveedor, ecd.ConceptoGasto, ecd.Concepto, p.Personal, p.ApellidoPaterno + ' ' + p.ApellidoMaterno + ' ' + p.Nombre AS Nombre, 
         ep.CentroCostos, ep.Empresa, ep.Sucursal, ep.Porcentaje, nd.Importe * (ep.Porcentaje / 100) * CASE WHEN Movimiento = 'Deduccion' THEN -1 ELSE 1 END AS ImporteProrrateo
    INTO #ProrrateoNomina
    FROM NominaProrrateoConcepto ec
    JOIN NominaProrrateoConceptoD ecd ON ec.ConceptoGasto = ecd.ConceptoGasto
    JOIN NominaD nd ON ecd.Concepto = nd.Concepto
    JOIN Personal p ON nd.Personal = p.Personal
    JOIN NominaProrrateoD ep ON p.NominaProrrateo = ep.Prorrateo
   WHERE nd.ID = @ID
    ORDER BY nd.Renglon

 --select * from #ProrrateoNomina 
  INSERT NominaProrrateoLog(ID, Concepto, Personal, Nombre, CentroCostos, Empresa, Sucursal, Porcentaje, Importe, Proveedor)
  SELECT ID, ConceptoGasto, Personal, Nombre, CentroCostos, Empresa, Sucursal, Porcentaje, SUM(ImporteProrrateo), Proveedor
    FROM #ProrrateoNomina
   GROUP BY ID, ConceptoGasto, Personal, Nombre, CentroCostos, Empresa, Sucursal, Porcentaje, Proveedor

  DECLARE crProrrateo CURSOR FOR
   SELECT DISTINCT Empresa, Sucursal, Proveedor FROM NominaProrrateoLog WHERE ID = @ID
  OPEN crProrrateo
  FETCH NEXT FROM crProrrateo INTO @Empresa, @Sucursal, @Proveedor

  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SELECT @GenerarID = NULL, @GastoID = NULL, @GenerarMovID = NULL

      INSERT Gasto(Empresa,  Mov ,     FechaEmision,  UltimoCambio,  Moneda,  TipoCambio,  Usuario, Estatus,      OrigenTipo, Origen, OrigenID, FechaRegistro,  Sucursal, Acreedor)
           SELECT @Empresa, 'Nomina', @FechaEmision, @UltimoCambio, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', 'NOM',  @Mov,       @MovID,   @UltimoCambio, @Sucursal, @Proveedor
      SELECT @GenerarID = SCOPE_IDENTITY()

      DECLARE crProrrateoD CURSOR FOR
      SELECT Concepto, CentroCostos, Importe
        FROM NominaProrrateoLog
       WHERE ID = @ID
         AND Empresa = @Empresa
         AND Sucursal = @Sucursal
         AND Proveedor = @Proveedor
      OPEN crProrrateoD
      FETCH NEXT FROM crProrrateoD INTO @Concepto, @CentroCostos, @Importe

      WHILE @@FETCH_STATUS = 0 AND @GenerarID IS NOT NULL
      BEGIN
        SELECT @Renglon = ISNULL(@Renglon, 0) + 2048

        SELECT @PorcentajeDeducible = PorcentajeDeducible FROM Concepto WHERE Modulo = 'GAS' AND Concepto = @Concepto

        INSERT GastoD(ID,          Renglon, RenglonSub, Concepto, Cantidad, Precio,   Importe,  ContUso,       PorcentajeDeducible)
               VALUES(@GenerarID, @Renglon, 0,         @Concepto, 1,       @Importe, @Importe, @CentroCostos, @PorcentajeDeducible)

        FETCH NEXT FROM crProrrateoD INTO @Concepto, @CentroCostos, @Importe
      END
      CLOSE crProrrateoD
      DEALLOCATE crProrrateoD

      IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID)
      BEGIN
        --EXEC spAfectar 'GAS', @GenerarID, 'AFECTAR', @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        EXEC spGasto @GenerarID, 'GAS', 'AFECTAR', 'TODO', @UltimoCambio, NULL, @Usuario, 1, 0, 'Nomina', @GenerarMovID OUTPUT, @GastoID, @Ok OUTPUT, @OkRef OUTPUT

        --SELECT @Sucursal, 'AFECTAR', @Empresa, 'NOM', @ID, @Mov, @MovID, 'GAS', @GenerarID, 'Nomina', @GenerarMovID, @Ok

        --IF @GastoID IS NOT NULL
          EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'NOM', @ID, @Mov, @MovID, 'GAS', @GenerarID, 'Nomina', @GenerarMovID, @Ok OUTPUT

      END

    END
    FETCH NEXT FROM crProrrateo INTO @Empresa, @Sucursal, @Proveedor
  END
  CLOSE crProrrateo
  DEALLOCATE crProrrateo

  RETURN
END
GO

/************** spEjecutaAsistenciasLaboradas *************/
if exists (select * from sysobjects where id = object_id('dbo.spEjecutaAsistenciasLaboradas') and type = 'P') drop procedure dbo.spEjecutaAsistenciasLaboradas
GO
CREATE PROCEDURE [dbo].[spEjecutaAsistenciasLaboradas]    
    @rID        int,
    @Empresa	varchar(5),
    @Sucursal   int,
    @Estacion   int,
    @Usuario	varchar(10)
--//WITH ENCRYPTION 
AS BEGIN
    DECLARE 
        @cPersonal                  varchar(10),
        @cDia                       datetime,
        @Jornada                    varchar(20),
        @MinutosJor                 float,
        @MinutosAs                  float,
        @MinutosLab                 float,
        @Fecha                      datetime,
		@Moneda                     varchar(20),
		@TipoCambio                 float,
        @Modulo                     varchar(20),
		@Mov                        varchar(20), 
		@MovID                      varchar(20),
        @IDNomina                   int,
        @IDIdentity                 int,
        @Renglon                    float,
        @DiaSemanaAsist             int,
        @Domingo                    bit, 
        @Sabado                     bit,
        @Lunes                      bit,    
        @Martes                     bit, 
        @Miercoles                  bit,
        @Jueves                     bit,   
        @Viernes                    bit,
        @Horas                      varchar(5),
        @Cantidad                   money,
        @TipoMov                    varchar(20),
        @RegEncabezado              int,
        @crPersonal                 varchar(10),
        @crID                       int,
        @crFecha                    datetime,
        @crTipo                     varchar(20),
        @crCantidad                 money,
        @crHoras                    varchar(5),
        @Estatus                    varchar(15),
        @AsistDescansolaborado      bit,
        @AsistDiaFestivolaborado    bit,
        @AsistDomingoLaborado       bit        
        
      DECLARE @TABLE TABLE
		(	
			Id          Int,
			IdMov       Int,
			Personal	Varchar(10),
            Fecha       Datetime,
            Tipo        varchar(20),
            Cantidad    money,
            Horas       varchar(5)
		)	

    SELECT @Estatus = 'CONFIRMAR'

    SELECT @AsistDescansolaborado   = ISNULL(AsistDescansolaborado,0),
           @AsistDiaFestivolaborado = ISNULL(AsistDiaFestivolaborado,0), 
           @AsistDomingoLaborado    = ISNULL(AsistDomingoLaborado,0)
      FROM EmpresaCfg 
     WHERE Empresa = @Empresa
------------------------------------------------------------------------------------
    DECLARE cPersonal CURSOR FOR
        SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) ID, B.Personal, B.Fecha
          FROM Asiste A
          JOIN AsisteD B
            ON A.ID = B.ID
          JOIN MovTipo C
            ON A.Mov = C.Mov
         WHERE C.Clave = 'ASIS.C'
           AND A.Empresa = @Empresa
           AND A.Id = @rID
           AND A.Estatus <> 'CANCELADO'
      GROUP BY A.ID, B.Personal, B.Fecha
      ORDER BY A.ID, B.Personal ASC

    OPEN cPersonal
    FETCH NEXT FROM cPersonal INTO @IDIdentity, @cPersonal, @cDia
    WHILE @@FETCH_STATUS = 0
        BEGIN

            SELECT @Cantidad = 0, @Horas = 0, @MinutosAs = 0, @MinutosLab = 0
            SELECT @Jornada = Jornada FROM Personal WHERE Personal = @cPersonal

            SELECT @Domingo   = Domingo   FROM Jornada WHERE Jornada = @Jornada
            SELECT @Sabado    = Sabado    FROM Jornada WHERE Jornada = @Jornada
            SELECT @Lunes     = Lunes     FROM Jornada WHERE Jornada = @Jornada
            SELECT @Martes    = Martes    FROM Jornada WHERE Jornada = @Jornada
            SELECT @Miercoles = Miercoles FROM Jornada WHERE Jornada = @Jornada
            SELECT @Jueves    = Jueves    FROM Jornada WHERE Jornada = @Jornada
            SELECT @Viernes   = Viernes   FROM Jornada WHERE Jornada = @Jornada   
            
            SELECT @MinutosJor = ISNULL(SUM(DATEDIFF(mi,Entrada,Salida)),0)
              FROM VerJornadaTiempo 
             WHERE Jornada = @Jornada 
               AND DATEPART(YEAR,@cDia) = Ano
               AND DATEPART(MONTH,@cDia) = Mes
               AND DATEPART(DAY,@cDia) = Dia
             GROUP BY Ano, Mes, Dia

            SELECT @Fecha = Fecha FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia             
            SELECT @MinutosAs = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia' 
            SELECT @DiaSemanaAsist =  DATEPART (DW, @Fecha) 
            
            IF CONVERT(VARCHAR(10), @Fecha, 105) NOT IN ( SELECT CONVERT(VARCHAR(10), Entrada, 105) FROM VerJornadaTiempo WHERE Jornada = @Jornada )
            BEGIN
                IF @@DATEFIRST = 7
                BEGIN
                    IF ((@Fecha IN (SELECT Fecha FROM DiaFestivo)) OR (@Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Jornada = @Jornada))) AND @AsistDiaFestivolaborado = 1
                    BEGIN   
                            SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                            SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                            SELECT @TipoMov = 'Día Festivo laborado'  
                                
                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                                
                            IF(@DiaSemanaAsist = 1) AND @AsistDomingoLaborado = 1
                            BEGIN
                                SELECT @TipoMov = 'Domingo Laborado'  

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                        SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                            END
                               
                    END
                    IF @DiaSemanaAsist = 1 AND @AsistDomingoLaborado = 1
                    BEGIN
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Domingo Laborado' 

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                           
                            
                        IF (@Domingo = 1 AND @DiaSemanaAsist = 1) AND @AsistDescansolaborado = 1
                        BEGIN
                            IF @MinutosJor >= @MinutosLab                        
                                SELECT @TipoMov = 'Descanso laborado' 

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                        END                           

                    END

                    IF (@Sabado = 1 AND @DiaSemanaAsist = 7) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00')) 
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado' 

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Lunes = 1 AND @DiaSemanaAsist = 2) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Martes = 1 AND @DiaSemanaAsist = 3) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas

                    END
                    IF (@Miercoles = 1 AND @DiaSemanaAsist = 4) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Jueves = 1 AND @DiaSemanaAsist = 5) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Viernes = 1 AND @DiaSemanaAsist = 6) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                END

                IF @@DATEFIRST = 1
                BEGIN
                    IF ((@Fecha IN (SELECT Fecha FROM DiaFestivo)) OR (@Fecha IN (SELECT Fecha FROM JornadaDiaFestivo WHERE Jornada = @Jornada))) AND @AsistDiaFestivolaborado = 1
                    BEGIN   
                            SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                            SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                            SELECT @TipoMov = 'Día Festivo laborado'  
                                
                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                                
                            IF(@DiaSemanaAsist = 7) AND @AsistDomingoLaborado = 1
                            BEGIN
                                SELECT @TipoMov = 'Domingo Laborado'  

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                        SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                            END
                               
                    END
                    IF @DiaSemanaAsist = 7 AND @AsistDomingoLaborado = 1
                    BEGIN
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Domingo Laborado' 

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                           
                            
                        IF (@Domingo = 1 AND @DiaSemanaAsist = 7) AND @AsistDescansolaborado = 1
                        BEGIN
                            IF @MinutosJor >= @MinutosLab                        
                                SELECT @TipoMov = 'Descanso laborado' 

                                INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                        END                           

                    END

                    IF (@Sabado = 1 AND @DiaSemanaAsist = 6) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00')) 
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado' 

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Lunes = 1 AND @DiaSemanaAsist = 1) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Martes = 1 AND @DiaSemanaAsist = 2) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas

                    END
                    IF (@Miercoles = 1 AND @DiaSemanaAsist = 3) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Jueves = 1 AND @DiaSemanaAsist = 4) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                    IF (@Viernes = 1 AND @DiaSemanaAsist = 5) AND @AsistDescansolaborado = 1
                    BEGIN                            
                        SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = 'Minutos Asistencia'                 
                        SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                        IF @MinutosJor >= @MinutosLab                        
                            SELECT @TipoMov = 'Descanso laborado'

                            INSERT @TABLE (Id,          IdMov, Personal,   Fecha, Tipo,  Cantidad,  Horas)
                                    SELECT @IDIdentity, @rID,  @cPersonal, @cDia, @TipoMov, @Cantidad, @Horas
                    END
                END


            END
            ELSE 
            BEGIN
                SELECT @TipoMov = Tipo FROM Asisted WHERE Id = @rID AND Personal = @cPersonal AND Fecha = @cDia
                IF (@TipoMov <> 'Dias Ausencia')
                BEGIN 
                    SELECT @Cantidad = ISNULL(Cantidad,0) FROM ASISTED WHERE ID = @rID AND Personal = @cPersonal AND Fecha = @cDia AND Tipo = @TipoMov                
                    SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                END
                ELSE
                BEGIN 
                    SELECT @Cantidad =  @MinutosJor 
                    SELECT @Horas = CONVERT(TIME,DATEADD(MI,CONVERT(INT,@Cantidad),'00:00'))
                END
            END
            FETCH NEXT FROM cPersonal INTO @IDIdentity, @cPersonal, @cDia
        END
    CLOSE cPersonal
    DEALLOCATE cPersonal
------------------------------------------------------------------------------------

-----------------------------------------------------------------' Festivo laborado'
    DECLARE crAsisteTab CURSOR FOR
	    SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) Id,       
               Personal,
               Fecha,    
               Tipo,     
               Cantidad, 
               Horas    
          FROM @TABLE
         WHERE Tipo = 'Día Festivo laborado'

	OPEN crAsisteTab
	FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	WHILE @@FETCH_STATUS = 0 
	BEGIN

        SELECT @RegEncabezado = ISNULL(@RegEncabezado,0) + 1

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

        SELECT @crTipo = 'Festivo laborado'

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @crPersonal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda     = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
	     WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float, @crID)

		IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN			
			IF @RegEncabezado = 1
			BEGIN
			    INSERT INTO Nomina (Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, Sucursal, SucursalOrigen, UEN, FechaOrigen, NOI)
                            SELECT @Empresa, @crTipo, NULL, GETDATE(), GETDATE(), '', NULL, @Moneda, @TipoCambio, @Usuario, NULL, NULL, NULL, @Estatus, NULL, NULL, NULL, NULL, @Modulo, @Mov, @MovID, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0

				SET @IDNomina = @@IDENTITY
			END
			
                INSERT INTO NominaD (ID, Renglon, Modulo, Plaza, Personal, Importe, Cuenta, FormaPago, Horas, Cantidad, Porcentaje, Monto, FechaD, FechaA, Movimiento, Saldo, Concepto, Referencia, CantidadPendiente, Activo, Sucursal, SucursalOrigen, Beneficiario, ContUso, CuentaContable, UEN, ObligacionFiscal, ClavePresupuestal)
                             SELECT @IDNomina, @Renglon, 'NOM', NULL, @crPersonal, NULL, NULL, NULL, @crHoras, 1, NULL, NULL, @crFecha, @crFecha, NULL, NULL, NULL, NULL, NULL, 1, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL                    
		END	
		FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	END
	CLOSE crAsisteTab
	DEALLOCATE crAsisteTab
------------------------------------------------------------------------------------
    SELECT @RegEncabezado = 0
-----------------------------------------------------------------'Descanso laborado'
    DECLARE crAsisteTab CURSOR FOR
	    SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) Id,       
               Personal,
               Fecha,    
               Tipo,     
               Cantidad, 
               Horas    
          FROM @TABLE
         WHERE Tipo = 'Descanso laborado'

	OPEN crAsisteTab
	FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	WHILE @@FETCH_STATUS = 0 
	BEGIN

        SELECT @RegEncabezado = ISNULL(@RegEncabezado,0) + 1

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

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @crPersonal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda     = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
	     WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float, @crID)

		IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN			
			IF @RegEncabezado = 1
			BEGIN
			    INSERT INTO Nomina (Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, Sucursal, SucursalOrigen, UEN, FechaOrigen, NOI)
                            SELECT @Empresa, @crTipo, NULL, GETDATE(), GETDATE(), '', NULL, @Moneda, @TipoCambio, @Usuario, NULL, NULL, NULL, @Estatus, NULL, NULL, NULL, NULL, @Modulo, @Mov, @MovID, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0

				SET @IDNomina = @@IDENTITY
			END
			
                INSERT INTO NominaD (ID, Renglon, Modulo, Plaza, Personal, Importe, Cuenta, FormaPago, Horas, Cantidad, Porcentaje, Monto, FechaD, FechaA, Movimiento, Saldo, Concepto, Referencia, CantidadPendiente, Activo, Sucursal, SucursalOrigen, Beneficiario, ContUso, CuentaContable, UEN, ObligacionFiscal, ClavePresupuestal)
                             SELECT @IDNomina, @Renglon, 'NOM', NULL, @crPersonal, NULL, NULL, NULL, @crHoras, 1, NULL, NULL, @crFecha, @crFecha, NULL, NULL, NULL, NULL, NULL, 1, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL                    
		END	
		FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	END
	CLOSE crAsisteTab
	DEALLOCATE crAsisteTab
------------------------------------------------------------------------------------
    SELECT @RegEncabezado = 0
-----------------------------------------------------------------''Domingo Laborado'
    DECLARE crAsisteTab CURSOR FOR
	    SELECT ROW_NUMBER() OVER(ORDER BY Personal ASC) Id,       
               Personal,
               Fecha,    
               Tipo,     
               Cantidad, 
               Horas    
          FROM @TABLE
         WHERE Tipo = 'Domingo Laborado'

	OPEN crAsisteTab
	FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	WHILE @@FETCH_STATUS = 0 
	BEGIN
        
        SELECT @RegEncabezado = ISNULL(@RegEncabezado,0) + 1

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

		SELECT @Moneda = Moneda 
		  FROM Personal 
		 WHERE personal = @crPersonal

		SELECT @TipoCambio = TipoCambio 
		  FROM Mon 
		 WHERE moneda = @Moneda  	 

		SELECT @TipoCambio = ISNULL(@TipoCambio,TipoCambio) ,
		       @Moneda     = ISNULL(@Moneda,Moneda) 
		  FROM Mon 
	     WHERE Orden = 1

		SELECT @Renglon = 2048.0 * CONVERT(float, @crID)

		IF @Cantidad <> 0.00 AND @Horas <> '00:00'
		BEGIN			
			IF @RegEncabezado = 1
			BEGIN
			    INSERT INTO Nomina (Empresa, Mov, MovID, FechaEmision, UltimoCambio, Concepto, Proyecto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Poliza, PolizaID, Sucursal, SucursalOrigen, UEN, FechaOrigen, NOI)
                            SELECT @Empresa, @crTipo, NULL, GETDATE(), GETDATE(), '', NULL, @Moneda, @TipoCambio, @Usuario, NULL, NULL, NULL, @Estatus, NULL, NULL, NULL, NULL, @Modulo, @Mov, @MovID, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, GETDATE(), 0

				SET @IDNomina = @@IDENTITY
			END
			
                INSERT INTO NominaD (ID, Renglon, Modulo, Plaza, Personal, Importe, Cuenta, FormaPago, Horas, Cantidad, Porcentaje, Monto, FechaD, FechaA, Movimiento, Saldo, Concepto, Referencia, CantidadPendiente, Activo, Sucursal, SucursalOrigen, Beneficiario, ContUso, CuentaContable, UEN, ObligacionFiscal, ClavePresupuestal)
                             SELECT @IDNomina, @Renglon, 'NOM', NULL, @crPersonal, NULL, NULL, NULL, @crHoras, 1, NULL, NULL, @crFecha, @crFecha, NULL, NULL, NULL, NULL, NULL, 1, @Sucursal, @Sucursal, NULL, NULL, NULL, NULL, NULL, NULL                    
		END	
		FETCH NEXT FROM crAsisteTab INTO @crID, @crPersonal, @crFecha, @crTipo, @crCantidad, @crHoras
	END
	CLOSE crAsisteTab
	DEALLOCATE crAsisteTab
------------------------------------------------------------------------------------
END
GO

PRINT "******************* SP NOMINA ******************"
