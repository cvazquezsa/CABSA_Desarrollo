/*** Nomina Automatica ****/

/**************** spNominaTope ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaTope') and type = 'P') drop procedure dbo.spNominaTope
GO             
CREATE PROCEDURE spNominaTope
			@Importe	money,
			@Tope		money,
			@Exento		money	OUTPUT,
			@Gravable	money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteEnRojo	bit

  IF @Importe < 0.0 SELECT @ImporteEnRojo = 1 ELSE SELECT @ImporteEnRojo = 0

  SELECT @Importe = ISNULL(ABS(@Importe), 0.0), @Tope = ISNULL(@Tope, 0.0), @Exento = 0.0, @Gravable = 0.0

  IF @Importe < @Tope
    SELECT @Exento = @Importe 
  ELSE 
    SELECT @Exento = @Tope, @Gravable = @Importe - @Tope

  IF @ImporteEnRojo = 1
    SELECT @Exento = -@Exento, @Gravable = -@Gravable
  RETURN
END
GO

/**************** spNominaClaveInternaAcumuladoFechas ****************  cambioABC*/  
if exists (select * from sysobjects where id = object_id('dbo.spNominaClaveInternaAcumuladoFechas') and type = 'P') drop procedure dbo.spNominaClaveInternaAcumuladoFechas
GO             
CREATE PROCEDURE spNominaClaveInternaAcumuladoFechas
			@Empresa		     char(5),
			@Personal		     char(10),
			@ClaveInterna		 varchar(50),
			@FechaD			     datetime,
			@FechaA			     datetime,
			@Movimiento		   varchar(50),
			@Importe		     money	OUTPUT,
 			@Cantidad		     float	OUTPUT,
			@NoEnMov         char(20)		= NULL,
			@Estatus         varchar(15)		= NULL  

WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Concepto	varchar(50)
    
  SELECT @NoEnMov= iSNULL(@NoEnMov,'')
  
  SELECT @Concepto = nc.Concepto 
    FROM CfgNominaConcepto cfg
    JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
   WHERE cfg.ClaveInterna = @ClaveInterna
  EXEC spNominaAcumuladoFechas @Empresa, @Personal, @Concepto, @FechaD, @FechaA, @Movimiento, @Importe OUTPUT, @Cantidad OUTPUT,@NoEnMov, @Estatus
  
  RETURN
END
GO

/**************** spNominaClaveInternaAcumuladoFechasTotal *************** cambioABC*/--no lo encontre en SQL version
if exists (select * from sysobjects where object_id('dbo.spNominaClaveInternaAcumuladoFechasTotal')=id and type='P') drop procedure dbo.spNominaClaveInternaAcumuladoFechasTotal
go
CREATE PROCEDURE dbo.spNominaClaveInternaAcumuladoFechasTotal
			@Empresa	    char(5),
			@ClaveInterna	varchar(50),
			@FechaD		    datetime,
			@FechaA		    datetime,
			@Tope		      money,
			@Importe	    money	OUTPUT,
			@Cantidad	    float	OUTPUT,
      @PTU          bit = 1
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal		      varchar(10),
    @PersonalImporte	money,
    @PersonalCantidad	float

  SELECT @Importe  = 0.0, 
         @Cantidad = 0.0
         
  DECLARE crPersonal CURSOR FOR
   SELECT Personal 
     FROM Personal 
  OPEN crPersonal
  FETCH NEXT FROM crPersonal INTO @Personal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, @ClaveInterna, @FechaD, @FechaA, NULL, @PersonalImporte OUTPUT, @PersonalCantidad OUTPUT
      IF ISNULL(@Tope, 0.0) > 0.0 AND @PersonalImporte > @Tope SELECT @PersonalImporte = @Tope
      IF @PTU = 1
      BEGIN 
        IF ISNULL(@PersonalCantidad, 0.0) >= 60.0
          SELECT @Importe = @Importe   + ISNULL(@PersonalImporte, 0.0), 
                 @Cantidad = @Cantidad + ISNULL(@PersonalCantidad, 0.0)
      END ELSE 
        SELECT @Importe = @Importe + ISNULL(@PersonalImporte, 0.0), @Cantidad = @Cantidad + ISNULL(@PersonalCantidad, 0.0)
    END
    FETCH NEXT FROM crPersonal INTO @Personal
  END -- While
  CLOSE crPersonal
  DEALLOCATE crPersonal
  RETURN
END
go

/**************** spNominaClaveInternaEstaNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaClaveInternaEstaNomina') and type = 'P') drop procedure dbo.spNominaClaveInternaEstaNomina
GO             
CREATE PROCEDURE spNominaClaveInternaEstaNomina
			@Personal	    char(10),
			@ClaveInterna	varchar(50),
    	@Cantidad	    float	= NULL OUTPUT,
			@Importe	    money	= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Cantidad = 0.0, @Importe = 0.0

  SELECT @Cantidad = ISNULL(SUM(n.Cantidad), 0.0), @Importe = ISNULL(SUM(n.Importe), 0.0)
    FROM #Nomina n
    JOIN NominaConcepto nc     ON nc.NominaConcepto = n.NominaConcepto
    JOIN CfgNominaConcepto cfg ON nc.NominaConcepto = cfg.NominaConcepto AND cfg.ClaveInterna = @ClaveInterna
   WHERE n.Personal = @Personal 
  RETURN
END
GO

/**************** spNominaAgregarClaveInterna ****************cambio ABC*/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAgregarClaveInterna') and type = 'P') drop procedure dbo.spNominaAgregarClaveInterna
GO             
CREATE PROCEDURE dbo.spNominaAgregarClaveInterna  
         @Ok           int  OUTPUT,  
         @OkRef        varchar(255) OUTPUT,  
         @ClaveInterna varchar(50),  
         @Empresa      char(5),     
         @Personal     char(10),  
         @Cantidad     float       = NULL,  
         @Importe      money       = NULL,  
         @Cuenta       varchar(10) = NULL,  
         @Vencimiento  datetime    = NULL,  
         @Referencia   varchar(50) = NULL,  
         @Mov          varchar(20) = NULL,  
         @Concepto     varchar(50) = NULL,  
         @Semana       int  = NULL,  
         @Beneficiario varchar(100) = NULL ,
         @UEN          int  = NULL  
WITH ENCRYPTION  
AS BEGIN  
  DECLARE  
    @RedondeoMonetarios int,  
    @NominaConcepto     varchar(10),  
    @AcreedorBase       varchar(20),  
    @AcreedorPropiedad  varchar(50),  
    @AcreedorDef        varchar(10),  
    @SucursalTrabajo    int,   
    @Categoria          varchar(50),   
    @Puesto             varchar(50)  
  
  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version  
  
  SELECT @Importe  = NULLIF(@Importe, 0.0), 
         @Cantidad = NULLIF(@Cantidad, 0.0), 
         @Cuenta   = NULLIF(RTRIM(@Cuenta), '')  
         
  IF @Importe IS NOT NULL OR @Cantidad IS NOT NULL  
  BEGIN  
    SELECT @NominaConcepto = NULL  
    IF @Mov IS NOT NULL  
      SELECT @NominaConcepto    = NULLIF(RTRIM(nc.NominaConcepto), ''),  
             @AcreedorBase      = UPPER(NULLIF(RTRIM(nc.AcreedorBase), '')),  
             @AcreedorPropiedad = NULLIF(RTRIM(nc.AcreedorPropiedad), ''),  
             @AcreedorDef       = NULLIF(RTRIM(nc.AcreedorDef), '')  
        FROM CfgNominaConceptoMov cfg  
        JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto  
       WHERE cfg.ClaveInterna = @ClaveInterna AND cfg.Mov = @Mov AND ISNULL(cfg.Concepto, '') = ISNULL(@Concepto, '')  
  
    IF @NominaConcepto IS NULL   
      SELECT @NominaConcepto = NULLIF(RTRIM(nc.NominaConcepto), ''),  
             @AcreedorBase = UPPER(NULLIF(RTRIM(nc.AcreedorBase), '')),  
             @AcreedorPropiedad = NULLIF(RTRIM(nc.AcreedorPropiedad), ''),  
             @AcreedorDef = NULLIF(RTRIM(nc.AcreedorDef), '')  
        FROM CfgNominaConcepto cfg  
        JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto  
       WHERE cfg.ClaveInterna = @ClaveInterna  
  
  
    IF @Cuenta IS NULL  
    BEGIN  
      IF @AcreedorBase = 'ESPECIFICO' SELECT @Cuenta = @AcreedorDef ELSE  
      IF @AcreedorBase = 'PROPIEDAD'  
      BEGIN  
        SELECT @SucursalTrabajo = SucursalTrabajo, @Categoria = Categoria, @Puesto = Puesto FROM Personal WHERE Personal = @Personal  
        EXEC spPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @AcreedorPropiedad, @Cuenta OUTPUT   
      END  
    END  
    
    IF @UEN IS NULL
        SELECT @UEN = UEN FROM Personal WHERE Personal = @Personal  
        
    IF @NominaConcepto IS NULL  
      SELECT @Ok = 10034, @OkRef = @ClaveInterna  
    ELSE  
      INSERT #Nomina (  
             Personal,  NominaConcepto,  Cantidad,  Importe,                              Cuenta,  Vencimiento,  Referencia,  Semana,  Beneficiario,   UEN)   
     VALUES (@Personal, @NominaConcepto, @Cantidad, ROUND(@Importe, @RedondeoMonetarios), @Cuenta, @Vencimiento, @Referencia, @Semana, @Beneficiario, @UEN)  
  END  
  RETURN  
END  
GO
 
/**************** spNominaSemanaDelAno ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSemanaDelAno') and type = 'P') drop procedure dbo.spNominaSemanaDelAno
GO             
CREATE PROCEDURE spNominaSemanaDelAno
                    @Fecha	datetime,
		                @Semana	int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SET DATEFIRST 7  
  SELECT @Semana = DATEPART(Week, DATEADD(day, -1, @Fecha))
-- se agrego esto por que el dia primero decia que era de la semana 53 por la resta.
  IF MONTH(@Fecha) = 1 AND DAY(@Fecha) = 1
    SELECT @Semana = 1
  RETURN
END
GO

/**************** spNominaAgregarHorasExtras ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaAgregarHorasExtras') and type = 'P') drop procedure dbo.spNominaAgregarHorasExtras
GO             
CREATE PROCEDURE spNominaAgregarHorasExtras
			@NomTipo	    varchar(50),
			@Empresa	    char(5),
			@Personal	    char(10),
			@FechaD		    datetime,
			@FechaA		    datetime,
			@IncidenciaD	datetime, 
			@IncidenciaA	datetime,
			@TipoCambio	  float,
			@Ok		        int		        OUTPUT,
			@OkRef		    varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CfgTopeHorasExtrasSemanal bit,	
    @FechaAplicacion	         datetime, 
    @Cantidad		               float,
    @AcumSemana		             float,
    @AcumSemanaDobles	         float,
    @AcumSemanaTriples	       float,
    @Precio		                 money,
    @Importe		               money,
    @ImporteDoble	             money,
    @ImporteTriple	           money,
    @UltSemana		             int,
    @Semana		                 int,
    @VecesSemana	             int,
    @HorasDobles 	             float, 
    @HorasTriples 	           float

  SELECT @CfgTopeHorasExtrasSemanal = ISNULL(TopeHorasExtrasSemanal, 0) 
    FROM EmpresaCfgNomAuto 
   WHERE Empresa = @Empresa

  SELECT @UltSemana         = NULL, 
         @VecesSemana       = 0, 
         @AcumSemana        = 0.0, 
         @AcumSemanaDobles  = 0.0, 
         @AcumSemanaTriples = 0.0
         
  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')
    DECLARE crHorasExtras CURSOR FOR
     SELECT d.FechaAplicacion, SUM(d.Cantidad), SUM(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)))
       FROM IncidenciaD d
       JOIN Incidencia i ON i.ID = d.ID AND i.Estatus = 'PENDIENTE' AND i.Empresa = @Empresa AND i.Personal = @Personal
       JOIN NominaConcepto nc ON nc.NominaConcepto = i.NominaConcepto AND nc.Especial = 'Horas Extras'
      WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL /*AND d.FechaAplicacion BETWEEN @IncidenciaD AND @IncidenciaA*/
      GROUP BY d.FechaAplicacion
      ORDER BY d.FechaAplicacion
  ELSE
    DECLARE crHorasExtras CURSOR FOR
     SELECT d.FechaAplicacion, SUM(d.Cantidad), SUM(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)))
       FROM IncidenciaD d
       JOIN Incidencia i ON i.ID = d.ID AND i.Estatus = 'PENDIENTE' AND i.Empresa = @Empresa AND i.Personal = @Personal
       JOIN NominaConcepto nc ON nc.NominaConcepto = i.NominaConcepto AND nc.Especial = 'Horas Extras'
      WHERE NULLIF(d.Saldo, 0.0) IS NOT NULL AND d.FechaAplicacion BETWEEN @IncidenciaD AND @IncidenciaA
      GROUP BY d.FechaAplicacion
      ORDER BY d.FechaAplicacion

  OPEN crHorasExtras
  FETCH NEXT FROM crHorasExtras INTO @FechaAplicacion, @Cantidad, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND ISNULL(@Cantidad, 0) <> 0.0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Precio = @Importe / @Cantidad
      SELECT @HorasDobles = 0.0, @HorasTriples = 0.0
      EXEC spNominaSemanaDelAno @FechaAplicacion, @Semana OUTPUT
      IF @Semana <> @UltSemana 
      BEGIN
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras', @Empresa, @Personal, @AcumSemana
        SELECT @ImporteDoble = @Precio * @AcumSemanaDobles
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras/Dobles', @Empresa, @Personal, @AcumSemanaDobles, @ImporteDoble, @Semana = @Semana
        SELECT @ImporteTriple = ((@Precio/2.0)*3.0) * @AcumSemanaTriples
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras/Triples', @Empresa, @Personal, @AcumSemanaTriples, @ImporteTriple
        SELECT @VecesSemana = 0, @AcumSemana = 0.0, @AcumSemanaDobles = 0.0, @AcumSemanaTriples = 0.0, @UltSemana = @Semana
      END
      SELECT @VecesSemana = @VecesSemana + 1
      IF @VecesSemana > 3 
        SELECT @HorasTriples = @Cantidad
      ELSE BEGIN
        IF @CfgTopeHorasExtrasSemanal = 1 AND @AcumSemana + @Cantidad > 9
          SELECT @HorasTriples = @AcumSemana + @Cantidad - 9

        SELECT @HorasDobles = @Cantidad - @HorasTriples
        IF @HorasDobles > 3 
          SELECT @HorasTriples = @HorasTriples + @HorasDobles - 3, @HorasDobles = 3
      END
      SELECT @AcumSemana = @AcumSemana + @Cantidad,
             @AcumSemanaDobles = @AcumSemanaDobles + @HorasDobles,
             @AcumSemanaTriples = @AcumSemanaTriples + @HorasTriples
    END
    FETCH NEXT FROM crHorasExtras INTO @FechaAplicacion, @Cantidad, @Importe
  END
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras', @Empresa, @Personal, @AcumSemana
  SELECT @ImporteDoble = @Precio * @AcumSemanaDobles
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras/Dobles', @Empresa, @Personal, @AcumSemanaDobles, @ImporteDoble
  SELECT @ImporteTriple = ((@Precio/2.0)*3.0) * @AcumSemanaTriples
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'HorasExtras/Triples', @Empresa, @Personal, @AcumSemanaTriples, @ImporteTriple

  CLOSE crHorasExtras
  DEALLOCATE crHorasExtras
  RETURN
END
GO

/***************************  spNominaGrava  ***********************************cambioABC*/
GO
if exists (select * from sysobjects where object_id('dbo.spNominaGrava')=id and type='P') drop procedure dbo.spNominaGrava
GO
CREATE  PROCEDURE dbo.spNominaGrava
			@Empresa			          char(5),
			@Sucursal			          int,
			@ID				              int,
			@Personal			          char(10),
			@SucursalTrabajoEstado	varchar(50),
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
			@ISRBase			          money		OUTPUT,
			@IMSSBase			          money		OUTPUT,
			@ImpuestoEstatalBase		money		OUTPUT,
			@CedularBase			      money		OUTPUT,
			@Ok				              int		OUTPUT,
			@OkRef				          varchar(255)	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Semana				            int,
    @Movimiento				        varchar(20),
    @Factor				            float,
    @Cantidad 				        float, 
    @Importe 				          money, 
    @Tope				              money,
    @Exento				            money,
    @ExentoF				          money,
    @Gravable				          money,
    @GravableF				        money,
    @ClaveInterna			        varchar(50),
    @ClaveInternaPrefijo	    varchar(50),
    @GravaISR				          varchar(50), 
    @GravaIMSS				        varchar(50), 
    @GravaImpuestoEstatal	    varchar(50), 
    @GravaCedular			        varchar(50),
    @TopeHorasDoblesSemanal	  money, 
    @TopePrimaDominical			  money,
    @TopePrimaVacacional		  money,
    @TopeAguinaldo			      money,
    @TopePTU				          money,
    @TopePremioPuntualidad	  money,
    @TopePremioAsistencia		  money,
    @TopeValesDespensaISR		  money,
    @TopeValesDespensaIMSS	  money,
    @ImporteHorasExtrasDobles	money,
    @NominaConcepto			      varchar(10)

  IF @Ok IS NOT NULL RETURN

  SELECT @TopePrimaVacacional    = @SMZ * 15,
         @TopeAguinaldo          = @SMZ * 30,
         @TopePTU                = @SMZ * 15,
         @TopePremioPuntualidad  = (@DiasMes * @SDI * 0.1) / @DiasMes * @DiasPeriodo,
         @TopePremioAsistencia   = (@DiasMes * @SDI * 0.1) / @DiasMes * @DiasPeriodo,
         @TopeValesDespensaIMSS  = @SMZ *  @DiasPeriodo * 0.4,
         @TopeValesDespensaISR   = @SMZ * (@DiasAno / 12.0),  
         @TopeHorasDoblesSemanal = @SMZTopeHorasDobles * @SMZ

  DECLARE crNominaGrava CURSOR FOR 
   SELECT nc.NominaConcepto, nc.Movimiento, d.Semana, SUM(d.Cantidad), SUM(d.Importe), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaISR)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaIMSS)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaImpuestoEstatal)), ''), 'NO'), ISNULL(NULLIF(RTRIM(UPPER(nc.GravaCedular)), ''), 'NO') 
     FROM #Nomina d
     JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
    WHERE d.Personal = @Personal AND nc.Movimiento IN ('Percepcion', 'Deduccion', 'Estadistica')
    GROUP BY nc.NominaConcepto, nc.Movimiento, nc.GravaISR, nc.GravaIMSS, nc.GravaImpuestoEstatal, nc.GravaCedular, d.Semana
    ORDER BY nc.NominaConcepto, nc.Movimiento, nc.GravaISR, nc.GravaIMSS, nc.GravaImpuestoEstatal, nc.GravaCedular, d.Semana

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
        SELECT @TopePrimaDominical = abs(@Cantidad)*@SMZ
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
          IF @GravaISR = 'PRIMA DOMINICAL'  SELECT @ClaveInternaPrefijo = 'PrimaDominical',  @Tope = @TopePrimaDominical   ELSE
          IF @GravaISR = 'PRIMA VACACIONAL' SELECT @ClaveInternaPrefijo = 'PrimaVacacional', @Tope = @TopePrimaVacacional  ELSE
          IF @GravaISR = 'VALES DESPENSA'   SELECT @ClaveInternaPrefijo = 'ValesDespensa',   @Tope = @TopeValesDespensaISR ELSE
          IF @GravaISR = 'AGUINALDO'        SELECT @ClaveInternaPrefijo = 'Aguinaldo', 	     @Tope = @TopeAguinaldo        ELSE
          IF @GravaISR = 'PTU'        		  SELECT @ClaveInternaPrefijo = 'PTU', 	 	         @Tope = @TopePTU              ELSE
          IF @GravaISR = 'ISR LIQUIDACION'  SELECT @ClaveInternaPrefijo = 'Indemnizacion',   @Tope = @IndemnizacionTope
          IF @Importe < 0
          BEGIN
            SELECT @Importe= @Importe * -1
            EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
            SELECT @Exento= @Exento * -1
            SELECT @Gravable= @Gravable * -1
            SELECT @Importe= @Importe * -1
           END ELSE 
             EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        END
 
        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor

        IF ISNULL(@GravaISR,'') <> 'ISR LIQUIDACION'
          SELECT @ISRBase = @ISRBase + @GravableF


        IF @ClaveInternaPrefijo IS NOT NULL
        BEGIN
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Exento'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @ExentoF
          SELECT @ClaveInterna = @ClaveInternaPrefijo + '/Gravable'
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, @ClaveInterna, @Empresa, @Personal, @Importe = @GravableF
        END
      END

      -- IMSS
      IF @GravaIMSS <> 'NO'
      BEGIN
        SELECT @Tope = 0.0
        IF @GravaIMSS = 'PREMIO PUNTUALIDAD'  SELECT @Tope = @TopePremioPuntualidad  ELSE
        IF @GravaIMSS = 'PREMIO ASISTENCIA'   SELECT @Tope = @TopePremioAsistencia   ELSE
        IF @GravaIMSS = 'VALES DESPENSA'      SELECT @Tope = @TopeValesDespensaIMSS  
 
        IF @Importe < 0
        BEGIN
          SELECT @Importe = @Importe * -1
          EXEC   spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
          SELECT @Exento= @Exento * -1
          SELECT @Gravable= @Gravable * -1
          SELECT @Importe= @Importe * -1
        END ELSE 
          EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT

        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @IMSSBase = @IMSSBase + @GravableF
      END

      -- Estatal
      IF @GravaImpuestoEstatal <> 'NO' 
      BEGIN
        SELECT @Tope = 0.0
        EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @ImpuestoEstatalBase = @ImpuestoEstatalBase + @GravableF
      END

      -- Cedular
      IF @GravaCedular <> 'NO' 
      BEGIN
        SELECT @Tope = 0.0
        EXEC spNominaTope @Importe, @Tope, @Exento OUTPUT, @Gravable OUTPUT
        SELECT @GravableF = @Gravable * @Factor, @ExentoF = @Exento * @Factor
        SELECT @CedularBase = @CedularBase + @GravableF
      END

    END
    FETCH NEXT FROM crNominaGrava INTO @NominaConcepto, @Movimiento, @Semana, @Cantidad, @Importe, @GravaISR, @GravaIMSS, @GravaImpuestoEstatal, @GravaCedular
  END
  CLOSE crNominaGrava
  DEALLOCATE crNominaGrava

  RETURN
END 
GO


/**************** spNominaSubsidioIncapacidadEG ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSubsidioIncapacidadEG') and type = 'P') drop procedure dbo.spNominaSubsidioIncapacidadEG
go
CREATE PROCEDURE spNominaSubsidioIncapacidadEG
			@Empresa	    char(5),
			@Personal	    char(10),
			@SueldoDiario	money,
			@SDI		      money,
			@Ok		        int		OUTPUT,
			@OkRef		    varchar(255)	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ClaveInterna	varchar(50),
    @Referencia		varchar(50),
    @Afectadas		int,
    @Tope		      int,
    @Cantidad		  float,
    @Cantidad40		float,
    @Cantidad100	float,
    @Importe		  money,
    @IncidenciaID	int

  DECLARE crIncapacidadEG CURSOR FOR 
   SELECT cfg.ClaveInterna, n.IncidenciaID, n.Referencia, SUM(n.Cantidad)
     FROM #Nomina n
     JOIN CfgNominaConcepto cfg ON cfg.NominaConcepto = n.NominaConcepto AND cfg.ClaveInterna IN ('Incapacidad/EG/Inicial', 'Incapacidad/EG/Continua')
    WHERE n.Personal = @Personal 
    GROUP BY cfg.ClaveInterna, n.IncidenciaID, n.Referencia
    ORDER BY cfg.ClaveInterna, n.IncidenciaID, n.Referencia
  OPEN crIncapacidadEG
  FETCH NEXT FROM crIncapacidadEG INTO @ClaveInterna, @IncidenciaID, @Referencia, @Cantidad
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(@Cantidad, 0.0) IS NOT NULL
    BEGIN
      SELECT @Cantidad100 = 0.0, @Cantidad40 = 0.0
      IF @ClaveInterna = 'Incapacidad/EG/Inicial'
      BEGIN
        SELECT @Afectadas = ISNULL(COUNT(*), 0) FROM IncidenciaD WHERE ID = @IncidenciaID AND NULLIF(CantidadPendiente, 0.0) IS NULL
        IF @Afectadas < 3 
        BEGIN
          SELECT @Tope = 3 - @Afectadas
          IF @Cantidad > @Tope SELECT @Cantidad100 = @Tope, @Cantidad40 = @Cantidad - @Tope ELSE SELECT @Cantidad100 = @Cantidad, @Cantidad40 = 0.0
        END ELSE
          SELECT @Cantidad40 = @Cantidad
      END ELSE
        SELECT @Cantidad40 = @Cantidad
        
      IF @Cantidad100 > 0.0
      BEGIN
        SELECT @Importe = @SueldoDiario * @Cantidad100
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Subsidio/Incapacidad/100', @Empresa, @Personal, @Cantidad100, @Importe, @Referencia = @Referencia
      END
      IF @Cantidad40 > 0.0
      BEGIN
        SELECT @Importe = (@SueldoDiario * @Cantidad40) - (@SDI * @Cantidad40 * 0.6)
        IF @Importe < 0.0 SELECT @Importe = 0.0	
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Subsidio/Incapacidad/40', @Empresa, @Personal, @Cantidad40, @Importe, @Referencia = @Referencia
      END
    END
    FETCH NEXT FROM crIncapacidadEG INTO @ClaveInterna, @IncidenciaID, @Referencia, @Cantidad
  END
  CLOSE crIncapacidadEG
  DEALLOCATE crIncapacidadEG
  RETURN
END 
GO

/************************    spNominaCxc  *********************cambio ABC*/
if exists (select * from sysobjects where id = object_id('dbo.spNominaCxc') and type = 'P') drop procedure dbo.spNominaCxc
GO
CREATE PROCEDURE dbo.spNominaCxc
   @NomCxc          varchar(20),  
   @NomTipo         varchar(50),  
   @Empresa         char(5),  
   @Sucursal        int,  
   @ID              int,  
   @Personal        char(10),  
   @Cliente         char(10),  
   @FechaD          datetime,  
   @FechaA          datetime,  
   @Moneda          char(10),  
   @TipoCambio      float,  
   @ConSueldoMinimo bit,  
   @SueldoMinimo    money,   
   @PersonalNeto    money        OUTPUT,  
   @Ok              int          OUTPUT,  
   @OkRef           varchar(255) OUTPUT  
WITH ENCRYPTION  
AS BEGIN  
  DECLARE  
    @Mov         varchar(20),  
    @MovID       varchar(20),  
    @Concepto    varchar(50),  
    @Referencia  varchar(50),  
    @Saldo       money,  
    @Importe     money  
  
  SELECT @Ok = NULL
  SELECT @Mov = MOV FROM NOMINA WHERE ID=@ID 

  IF @NomTipo IN ('FINIQUITO', 'LIQUIDACION')  
    DECLARE crNominaCxc CURSOR FOR   
     SELECT c.Mov, c.MovID, c.Concepto, ISNULL(c.Saldo, 0.0)*TipoCambio/@TipoCambio  
       FROM Cxc c  
       JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D')  
      WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente AND c.Estatus = 'PENDIENTE' AND ISNULL(c.Saldo, 0.0)>0.0 /*AND c.Vencimiento <= @FechaA*/  
      		-- AND nc.NominaConcepto  in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina =@MOV )
      ORDER BY c.Vencimiento  
  ELSE  IF @NomTipo IN ('SUELDO COMPLEMENTO')
    DECLARE crNominaCxc CURSOR FOR   
     SELECT c.Mov, c.MovID, c.Concepto, ISNULL(c.Saldo, 0.0)*TipoCambio/@TipoCambio  
       FROM Cxc c  
       JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D')  
	   JOIN CfgNominaConceptoMov cf ON cf.Mov=mt.Mov AND cf.Concepto = c.Concepto
	   JOIN NominaConcepto nc ON nc.NominaConcepto = cf.NominaConcepto
      WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente AND c.Estatus = 'PENDIENTE' AND ISNULL(c.Saldo, 0.0)>0.0 AND c.Vencimiento <= @FechaA  
		 AND nc.NominaConcepto  in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina =@MOV )
      ORDER BY c.Vencimiento  
  ELSE
    DECLARE crNominaCxc CURSOR FOR   
     SELECT c.Mov, c.MovID, c.Concepto, ISNULL(c.Saldo, 0.0)*TipoCambio/@TipoCambio  
       FROM Cxc c  
       JOIN MovTipo mt ON mt.Modulo = 'CXC' AND mt.Mov = c.Mov AND mt.Clave IN ('CXC.F', 'CXC.CA', 'CXC.CAP', 'CXC.CAD', 'CXC.D')  
	   JOIN CfgNominaConceptoMov cf ON cf.Mov=mt.Mov AND cf.Concepto = c.Concepto
	   JOIN NominaConcepto nc ON nc.NominaConcepto = cf.NominaConcepto
      WHERE c.Empresa = @Empresa AND c.Cliente = @Cliente AND c.Estatus = 'PENDIENTE' AND ISNULL(c.Saldo, 0.0)>0.0 AND c.Vencimiento <= @FechaA  
		 AND nc.NominaConcepto  in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina =@MOV )
      ORDER BY c.Vencimiento  
	
  OPEN crNominaCxc  
  FETCH NEXT FROM crNominaCxc INTO @Mov, @MovID, @Concepto, @Saldo  
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL  
  BEGIN  
    IF @@FETCH_STATUS <> -2   
    BEGIN  
      SELECT @Importe = 0.0, @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)  
      IF @ConSueldoMinimo = 1  
      BEGIN  
        IF @PersonalNeto - @Saldo >= @SueldoMinimo  
          SELECT @Importe = @Saldo  
        ELSE   
          IF @NomCxc = 'PARCIALES' SELECT @Importe = @PersonalNeto - @SueldoMinimo  
      END ELSE  
        SELECT @Importe = @Saldo  
  
      IF @Importe > 0.0  
      BEGIN  
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Cxc', @Empresa, @Personal, @Importe = @Importe, @Cuenta = @Cliente, @Referencia = @Referencia, @Mov = @Mov, @Concepto = @Concepto  
        SELECT @PersonalNeto = @PersonalNeto - @Importe  
      END  
    END  
    FETCH NEXT FROM crNominaCxc INTO @Mov, @MovID, @Concepto, @Saldo  
  END  
  CLOSE crNominaCxc  
  DEALLOCATE crNominaCxc  
  RETURN  
END   
GO


/**************** spNominaDomingosLaborados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaDomingosLaborados') and type = 'P') drop procedure dbo.spNominaDomingosLaborados
go
CREATE PROCEDURE spNominaDomingosLaborados
			@Empresa		        char(5),
			@Personal		        char(10),
			@FechaD			        datetime,
			@FechaA			        datetime,
			@IncidenciaD		    datetime,
			@IncidenciaA		    datetime,
			@DomingosLaborados	float	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
SET DATEFIRST 7
DECLARE
   @Domingos	int,
   @Ausentismo	int

   SELECT @Domingos = DATEDIFF(week, @IncidenciaD-1, @IncidenciaA)
   SELECT @Ausentismo = SUM(d.Cantidad)
     FROM IncidenciaD d
     JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'
     JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Especial IN ('Faltas', 'Incapacidades', 'Vacaciones')
    WHERE d.FechaAplicacion BETWEEN @IncidenciaD AND @IncidenciaA AND DATEPART(weekday, d.FechaAplicacion) = 1

   SELECT @DomingosLaborados = ISNULL(@Domingos, 0) - ISNULL(@Ausentismo, 0)
RETURN
END
GO

/**************** spNominaSueldoVariableAcumuladoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSueldoVariableAcumuladoFechas') and type = 'P') drop procedure dbo.spNominaSueldoVariableAcumuladoFechas
GO             
CREATE PROCEDURE spNominaSueldoVariableAcumuladoFechas
			@Empresa	char(5),
			@Personal	char(10),
			@FechaD		datetime,
			@FechaA		datetime,
			@Importe	money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Personal   = NULLIF(RTRIM(@Personal), '')

  SELECT @Importe = 0.0

  SELECT @Importe = @Importe + ISNULL(SUM(d.Importe), 0.0)
    FROM Nomina n, NominaD d, MovTipo mt, NominaConcepto nc
   WHERE n.ID = d.ID
     AND n.Estatus = 'CONCLUIDO'
     AND n.Empresa = @Empresa
     AND n.FechaA BETWEEN @FechaD AND @FechaA AND mt.Clave IN ('NOM.N', 'NOM.NE') 
     AND n.Mov = mt.Mov
     AND mt.Modulo = 'NOM'
     AND d.Personal = @Personal
     AND nc.Concepto = d.Concepto AND nc.SueldoVariable = 1

  SELECT @Importe = @Importe + ISNULL(SUM(d.Importe), 0.0)
    FROM Nomina n, NominaD d, MovTipo mt, NominaConcepto nc
   WHERE n.ID = d.ID
     AND n.Estatus = 'CONCLUIDO'
     AND n.Empresa = @Empresa
     AND n.FechaEmision BETWEEN @FechaD AND @FechaA AND mt.Clave IN ('NOM.NA', 'NOM.NC')
     AND n.Mov = mt.Mov
     AND mt.Modulo = 'NOM'
     AND d.Personal = @Personal
     AND nc.Concepto = d.Concepto AND nc.SueldoVariable = 1

  RETURN
END
GO

/**************** spFechaAniversario ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFechaAniversario') and type = 'P') drop procedure dbo.spFechaAniversario
GO             
CREATE PROCEDURE spFechaAniversario
	  		@Antiguedad	  datetime,
		  	@Hoy		      datetime,
			  @Aniversario 	datetime	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia	int,
    @Mes	int,
    @Ano	int

  SELECT @Dia = DAY(@Antiguedad), @Mes = MONTH(@Antiguedad), @Ano = YEAR(@Hoy)
  EXEC spIntToDateTime @Dia, @Mes, @Ano, @Aniversario OUTPUT
  IF @Aniversario > @Hoy 
    SELECT @Aniversario = DATEADD(year, -1, @Aniversario)
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spNominaCalc') and type = 'P') drop procedure dbo.spNominaCalc
go
CREATE PROCEDURE dbo.spNominaCalc
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
    	@NomCxc			                    varchar(20),
			@RepartirDesde                  datetime,
			@RepartirHasta                  datetime,
      @RepartirIngresoTope		        money,
			@RepartirIngresoFactor          float,
			@RepartirDiasFactor             float,
			@CalendarioEsp                  bit, 
			@IncidenciaD                    datetime, 
			@IncidenciaA                    datetime,
			@Ok                             int		OUTPUT,
			@OkRef                          varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN	
  DECLARE  
    @Pais varchar(30)

  SELECT @Pais = Pais from Empresa where empresa=@Empresa
  SELECT @Pais = UPPER(ISNULL(@Pais, 'MEXICO'))
	
  IF @Pais = 'MEXICO'
    EXEC spNominaCalcMexico     @Empresa,@FechaTrabajo,@Sucursal, @ID, @Mov, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,  
                                @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,  
                                @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,  
                                @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,  
                                @CalendarioEsp, @IncidenciaD, @IncidenciaA, @Ok OUTPUT, @OkRef OUTPUT

  ELSE IF @Pais ='EL SALVADOR'
    EXEC spNominaCalcElSalvador @Empresa, @FechaTrabajo, @Sucursal,  @ID, @Mov, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,
                                @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,
                                @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,
                                @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                                @CalendarioEsp, @IncidenciaD, @IncidenciaA, @Ok OUTPUT, @OkRef OUTPUT
  ELSE IF @Pais = 'PANAMA'
    EXEC spNominaCalcPanama     @Empresa, @FechaTrabajo, @Sucursal, @ID, @Mov, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo, 
                                @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto, 
                                @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla, 
                                @NomTipo, @NomCalcSDI, @NomCxc, @RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                                @CalendarioEsp, @IncidenciaD, @IncidenciaA, @Ok OUTPUT, @OkRef OUTPUT

  IF @Ok IS NOT NULL AND @OkRef IS NULL SELECT @OkRef = @Personal
  RETURN
END 
GO


/**************** spNominaImpuestoEstatalEspecial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaImpuestoEstatalEspecial') and type = 'P') drop procedure dbo.spNominaImpuestoEstatalEspecial
GO             
CREATE PROCEDURE spNominaImpuestoEstatalEspecial
			@Empresa	char(5),
			@Ok		    int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @VecesSMZ			            float,
    @ImpuestoEstatalPct		    float,
    @GastoOperacionPct		    float,
    @Personal			            char(10),
    @Cuenta			              char(10),
    @Vencimiento		          datetime,
    @SMZ			                money,
    @Total			              money,
    @Base			                money,
    @ImpuestoEstatalTotal	    money,
    @GastoOperacionTotal	    money,
    @PersonalImpuestoEstatal	money,
    @PersonalGastoOperacion	  money

  -- Queretaro
  SELECT @VecesSMZ           = 8.0, 
         @ImpuestoEstatalPct = 1.6, 
	       @GastoOperacionPct  = 25.0

  SELECT @Total = ISNULL(SUM(n.Importe), 0.0), @Personal = MIN(n.Personal)
    FROM #Nomina n
    JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto
    JOIN CfgNominaConcepto cfg ON nc.NominaConcepto = cfg.NominaConcepto 
   WHERE cfg.ClaveInterna = 'ImpuestoEstatal/Base' AND UPPER(n.Referencia) = 'QUERETARO'

  SELECT @SMZ = SueldoMinimo 
    FROM Personal p
    JOIN ZonaEconomica ze ON ze.Zona = p.ZonaEconomica
   WHERE p.Personal = @Personal

  SELECT @Base = @Total - (@VecesSMZ*@SMZ)
  IF ISNULL(@Base, 0.0) > 0.0
  BEGIN
    SELECT @ImpuestoEstatalTotal = @Base * (@ImpuestoEstatalPct/100.0)
    SELECT @GastoOperacionTotal  = @ImpuestoEstatalTotal * (@GastoOperacionPct/100.0)

    DECLARE crImpuestoEstatalEspecial CURSOR FOR
     SELECT n.Personal, dbo.fnR3(@Total, @ImpuestoEstatalTotal, n.Importe), dbo.fnR3(@Total, @GastoOperacionTotal, n.Importe), n.Cuenta, n.Vencimiento
       FROM #Nomina n
       JOIN NominaConcepto nc ON nc.NominaConcepto = n.NominaConcepto
       JOIN CfgNominaConcepto cfg ON nc.NominaConcepto = cfg.NominaConcepto 
      WHERE cfg.ClaveInterna = 'ImpuestoEstatal/Base' AND UPPER(n.Referencia) = 'QUERETARO'
    OPEN crImpuestoEstatalEspecial
    FETCH NEXT FROM crImpuestoEstatalEspecial INTO @Personal, @PersonalImpuestoEstatal, @PersonalGastoOperacion, @Cuenta, @Vencimiento
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal',                @Empresa, @Personal, @Importe = @PersonalImpuestoEstatal, @Cuenta = @Cuenta, @Vencimiento = @Vencimiento
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/GastoOperacion', @Empresa, @Personal, @Importe = @PersonalGastoOperacion,  @Cuenta = @Cuenta, @Vencimiento = @Vencimiento
        DELETE #Nomina WHERE CURRENT OF crImpuestoEstatalEspecial
      END
      FETCH NEXT FROM crImpuestoEstatalEspecial INTO @Personal, @PersonalImpuestoEstatal, @PersonalGastoOperacion, @Cuenta, @Vencimiento
    END -- While
    CLOSE crImpuestoEstatalEspecial
    DEALLOCATE crImpuestoEstatalEspecial
  END

  -- Otros Estados

  RETURN
END
GO

 
/**************** spNominaGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaGenerar') and type = 'P') drop procedure dbo.spNominaGenerar
GO
CREATE PROCEDURE dbo.spNominaGenerar
                @Estacion	    int,
                @ID		        int,
                @FechaD		    datetime,
                @FechaA		    datetime,
                @PeriodoTipo	varchar(20),
                @FechaTrabajo	datetime    = NULL,
                @NomTipo	    varchar(50) = NULL
WITH ENCRYPTION
AS BEGIN
DECLARE
  @Empresa				                    char(5),
  @RedondeoMonetarios 		            int,
  @CfgAjusteMensualISR		            bit,
  @CfgSueldoMinimo			              varchar(20),
  @CfgTablaVacaciones			            varchar(50),
  @CfgSubsidioIncapacidadEG		        bit,
  @CfgPrimaDominicalAuto		          bit,
  @CfgISRReglamentoAguinaldo		      bit,
  @CfgISRReglamentoPTU      		      bit,
  @CfgISRLiquidacionSueldoMensual	    varchar(50),
  @CfgFactorIntegracionAntiguedad	    varchar(20),
  @CfgFactorIntegracionTabla	        varchar(50),
  @CfgFondoAhorroRepartirInteres      varchar(20),
  @CfgCajaAhorroRepartirInteres	      varchar(20),
  @Sucursal			                  	  int,
  @Mov				                        varchar(20),
  @NomCalcSDI		                      bit,
  @NomCxc 			                  	  varchar(20),
  @Moneda				                      char(10),
  @TipoCambio		                  		float,
  @Personal			                  	  char(10),
  @ClaveInterna	                  		varchar(10),
  @Conteo				                      int,
  @RepartirDesde			                datetime,
  @RepartirHasta			                datetime,
  @RepartirImporte			              money,
  @RepartirIngresoTope		            money,
  @RepartirIngresoTotal		            money,
  @RepartirTotalDias			            float,
  @RepartirIngresoFactor	            float,
  @RepartirDiasFactor			            float,
  @Renglon				                    float,
  @CalendarioEsp		                  bit,
  @IncidenciaD			                  datetime,
  @IncidenciaA			                  datetime,
  @IDMAX       			                  int,
  @Ok					                        int,
  @OkRef				                      varchar(255),
  @Pais                               varchar(30),
  @ImpuestoEstatalGastoOperacionTotal money, 
  @ImpuestoEstatalGastoOperacionSuma  money,
  @SueldoDiario			                  money ,
  @Valor                              varchar(50),
  @UEN                                int,
  @UEN0                               int,
  @ID1                                int                 

  CREATE TABLE #Nomina (
    ID		         int		  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    IncidenciaID	 int		  NULL,
    IncidenciaRID	 int		  NULL,
    Fecha		       datetime	NULL,
    Personal	     varchar(10)  COLLATE Database_Default NULL,
    Semana		     int		  NULL,
    NominaConcepto varchar(10)	COLLATE Database_Default NULL,
    Movimiento	   varchar(20)	COLLATE Database_Default NULL,
    Referencia	   varchar(50)	COLLATE Database_Default NULL,
    Cantidad	     float		NULL,
    Importe		     money		NULL,
    Cuenta	 	     varchar(10) 	COLLATE Database_Default NULL,
    Vencimiento  	 datetime NULL,
    Beneficiario	 varchar(100)	COLLATE Database_Default NULL,
    UEN            int      NULL)

  CREATE INDEX Consulta       ON #Nomina (Personal, IncidenciaID, IncidenciaRID, NominaConcepto, Referencia, Cuenta, Vencimiento, Beneficiario)
  CREATE INDEX Referencia     ON #Nomina (Referencia)
  CREATE INDEX Personal 	ON #Nomina (Personal, NominaConcepto)
  CREATE INDEX IncidenciaID 	ON #Nomina (Personal, IncidenciaID)
  CREATE INDEX IncidenciaRID 	ON #Nomina (Personal, IncidenciaRID)
  CREATE INDEX IndiceCursor   ON #Nomina (Personal, Cuenta, Vencimiento)
  CREATE INDEX NominaConcepto ON #Nomina (NominaConcepto, Personal, IncidenciaID, IncidenciaRID, Referencia, Cuenta, Vencimiento, Beneficiario, Importe, Cantidad)

  CREATE TABLE #Nomina2 (
          ID		          int		    NOT NULL IDENTITY(1,1) PRIMARY KEY,
  	      IncidenciaID	  int		    NULL,
  	      IncidenciaRID	  int		    NULL,
          Fecha		        datetime	NULL,
          Personal	      varchar(10)	COLLATE Database_Default  NULL,  
          NominaConcepto	varchar(10)	COLLATE Database_Default  NULL, 
          Movimiento	    varchar(20)	COLLATE Database_Default  NULL,
  	      Referencia	    varchar(50)	COLLATE Database_Default  NULL, 
  	      Cantidad	      float		  NULL, 
  	      Importe		      money		  NULL,
  	      Cuenta	 	      varchar(10) COLLATE Database_Default  	NULL,
    	    Vencimiento  	  datetime 	NULL,
  	      Beneficiario	  varchar(100) COLLATE Database_Default  	NULL,
          UEN             int       NULL)



  CREATE INDEX NominaConcepto ON #Nomina2(NominaConcepto, ID, IncidenciaRID, Referencia, Cuenta, Vencimiento, Beneficiario, Cantidad, Personal, Importe)

  DELETE  ImpuestoEstatalGastoOperacion WHERE ID = @ID
  SELECT @Empresa = Empresa from nomina where id=@ID
  SELECT @Pais = Pais from Empresa where empresa=@Empresa
  SELECT @Pais = ISNULL(@Pais,'')

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version
  SELECT @IncidenciaD = @FechaD, @IncidenciaA = @FechaA
  IF @FechaTrabajo IS NULL
  BEGIN
    SELECT @FechaTrabajo = GETDATE()
    EXEC spExtraerFecha @FechaTrabajo OUTPUT
  END

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL
  SELECT @Empresa = n.Empresa, @Sucursal = n.Sucursal, @Mov = n.Mov, @Moneda = n.Moneda, @TipoCambio = n.TipoCambio,
         @NomTipo = ISNULL(@NomTipo,ISNULL(NULLIF(RTRIM(UPPER(mt.NomAutoTipo)), ''), 'NORMAL')),
         @NomCalcSDI = ISNULL(mt.NomAutoCalcSDI, 0),
         @NomCxc  = UPPER(mt.NomAutoCxc)
         FROM Nomina n
         JOIN MovTipo mt ON mt.Modulo = 'NOM' AND mt.Mov = n.Mov
    WHERE n.ID = @ID

  SELECT @CalendarioEsp = NomAutoCalendarioEsp FROM MovTipo WHERE Modulo = 'NOM' AND Mov = @Mov
  IF @CalendarioEsp = 1
    SELECT @IncidenciaD = IncidenciaD, @IncidenciaA = IncidenciaA
      FROM MovTipoNomAutoCalendarioEsp
     WHERE Modulo = 'NOM' AND Mov = @Mov AND FechaNomina = @FechaA

  SELECT @CfgTablaVacaciones = TablaVacaciones
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @CfgAjusteMensualISR      = AjusteMensualISR,
         @CfgSueldoMinimo          = UPPER(SueldoMinimo),
         @CfgSubsidioIncapacidadEG = ISNULL(SubsidioIncapacidadEG, 0),
         @CfgPrimaDominicalAuto    = ISNULL(PrimaDominicalAuto, 0),
         @CfgISRReglamentoAguinaldo= ISNULL(ISRReglamentoAguinaldo, 0),
         @CfgISRReglamentoPTU      = ISNULL(ISRReglamentoPTU, 0),
         @CfgISRLiquidacionSueldoMensual = UPPER(ISRLiquidacionSueldoMensual),
         @CfgFactorIntegracionAntiguedad = UPPER(FactorIntegracionAntiguedad),
         @CfgFactorIntegracionTabla      = FactorIntegracionTabla,
         @CfgFondoAhorroRepartirInteres  = FondoAhorroRepartirInteres,
         @CfgCajaAhorroRepartirInteres   = CajaAhorroRepartirInteres
    FROM EmpresaCfgNomAuto
   WHERE Empresa = @Empresa
      
  -- select    @NomTipo
  IF @NomTipo IN ('PTU', 'LIQUIDACION FONDO AHORRO', 'LIQUIDACION CAJA AHORRO')
  BEGIN
    IF @NomTipo = 'PTU'
    BEGIN
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'PTU Desde (DD/MM/AAAA)', @RepartirDesde OUTPUT
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'PTU Hasta (DD/MM/AAAA)', @RepartirHasta OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'PTU Importe a Repartir', @RepartirImporte OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'PTU Ingreso Tope',       @RepartirIngresoTope OUTPUT
      EXEC spNominaClaveInternaAcumuladoFechasTotal @Empresa, 'DiasTrabajados', @RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoTotal OUTPUT, @RepartirTotalDias OUTPUT
      SELECT @RepartirIngresoFactor = (@RepartirImporte/2.0)/NULLIF(@RepartirIngresoTotal, 0.0),
             @RepartirDiasFactor    = (@RepartirImporte/2.0)/NULLIF(@RepartirTotalDias, 0.0)

    END ELSE
    IF @NomTipo = 'LIQUIDACION FONDO AHORRO'
    BEGIN
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'Fondo de Ahorro Desde (DD/MM/AAAA)', @RepartirDesde OUTPUT
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'Fondo de Ahorro Hasta (DD/MM/AAAA)', @RepartirHasta OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'Fondo de Ahorro Interes a Repartir', @RepartirImporte OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'Fondo de Ahorro Ingreso Tope',       @RepartirIngresoTope OUTPUT
      EXEC spNominaClaveInternaAcumuladoFechasTotal @Empresa, 'FondoAhorro', @RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoTotal OUTPUT, @RepartirTotalDias OUTPUT
      IF @CfgFondoAhorroRepartirInteres = 'PTU'
        SELECT @RepartirIngresoFactor = (@RepartirImporte/2.0)/NULLIF(@RepartirIngresoTotal, 0.0),
               @RepartirDiasFactor    = (@RepartirImporte/2.0)/NULLIF(@RepartirTotalDias, 0.0)
      ELSE
        SELECT @RepartirIngresoFactor = @RepartirImporte/NULLIF(@RepartirIngresoTotal, 0.0),
               @RepartirDiasFactor    = NULL
    END ELSE
    IF @NomTipo = 'LIQUIDACION CAJA AHORRO'
    BEGIN
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'Caja de Ahorro Desde (DD/MM/AAAA)', @RepartirDesde OUTPUT
      EXEC spPersonalPropValorDMA   @Empresa, NULL, NULL, NULL, NULL, 'Caja de Ahorro Hasta (DD/MM/AAAA)', @RepartirHasta OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'Caja de Ahorro Interes a Repartir', @RepartirImporte OUTPUT
      EXEC spPersonalPropValorMoney @Empresa, NULL, NULL, NULL, NULL, 'Caja de Ahorro Ingreso Tope',       @RepartirIngresoTope OUTPUT
      EXEC spNominaClaveInternaAcumuladoFechasTotal @Empresa, 'CajaAhorro', @RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoTotal OUTPUT, @RepartirTotalDias OUTPUT
      IF @CfgCajaAhorroRepartirInteres = 'PTU'
        SELECT @RepartirIngresoFactor = (@RepartirImporte/2.0)/NULLIF(@RepartirIngresoTotal, 0.0),
               @RepartirDiasFactor    = (@RepartirImporte/2.0)/NULLIF(@RepartirTotalDias, 0.0)
      ELSE
        SELECT @RepartirIngresoFactor = @RepartirImporte/NULLIF(@RepartirIngresoTotal, 0.0), @RepartirDiasFactor    = NULL
    END
  END
  SELECT @ClaveInterna = NULL
  
  IF EXISTS (SELECT * from version  where version < 3000) 
  BEGIN
    SELECT  @Pais ='Mexico' 
    SELECT @ClaveInterna = MIN(cfg.ClaveInterna)
      FROM CfgNominaConcepto cfg
      LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
     WHERE nc.NominaConcepto IS NULL
  END
  ELSE BEGIN
    IF EXISTS(SELECT * FROM Version WHERE Version >= 3000)
      SELECT @ClaveInterna = MIN(cfg.ClaveInterna)
        FROM CfgNominaConcepto cfg
        LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
       WHERE nc.NominaConcepto IS NULL
         AND nc.Pais  = cfg.Pais
         AND cfg.Pais = @Pais
    ELSE
      SELECT @ClaveInterna = MIN(cfg.ClaveInterna)
        FROM CfgNominaConcepto cfg
        LEFT OUTER JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
       WHERE nc.NominaConcepto IS NULL
  END

  IF @ClaveInterna IS NOT NULL
    SELECT @Ok = 10034, @OkRef = @ClaveInterna

  IF isnull(@Pais,'')='' SELECT @Pais ='Mexico'

  /*IF @Pais = 'Mexico' AND @NomTipo IN('Impuesto Estatal')
    EXEC spFideNominaImpuestoEstatal @ID, @FechaD, @FechaA,  @Ok OUTPUT, @OkRef   OUTPUT
  ELSE*/  
  IF @Pais ='Mexico'
  BEGIN
    IF @MOV = 'PRESUPUESTO'  
      EXEC spNominaPresupuestoPlazaIntelisis  
    DECLARE crLista CURSOR FOR
    SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Personal
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        IF @MOV = 'PRESUPUESTO'  EXEC spNominaPresupuestoPlazaIntelisis2  @Personal, @FechaD
 	      SELECT @SueldoDiario = isnull(SueldoDiario,0) FROM Personal where personal = @Personal
	      SELECT @SueldoDiario = isnull(@SueldoDiario,0)
	      IF (@SueldoDiario > 11  AND @NomTipo NOT IN ('Sueldo Complemento','AguinaldoComplemento')) 
           or (@NomTipo IN('Liquidacion Caja ahorro','SDI','Finiquito','Liquidacion','Ajuste','Impuesto Estatal'))
          EXEC spNominaCalcMexico @Empresa, @FechaTrabajo, @Sucursal, @ID, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,
                                  @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,
                                  @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,
                                  @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                                  @CalendarioEsp, @IncidenciaD, @IncidenciaA,@Estacion,
                                  @Ok OUTPUT, @OkRef OUTPUT
	      IF  @NomTipo IN ('Sueldo Complemento','AguinaldoComplemento')
	      BEGIN
	        SELECT @SueldoDiario = isnull(SueldoDiarioComplemento,0) from personal where personal=@Personal
	        SELECT @SueldoDiario = isnull(@SueldoDiario,0) 
	        IF @Mov = 'Presupuesto' SELECT @SueldoDiario = @SueldoDiario * (1+(isnull(Incremento,0)/100.0)) FROM Personal WHERE Personal = @Personal
		      IF @SueldoDiario >1
		        EXEC spNominaCalcMexico @Empresa, @FechaTrabajo, @Sucursal, @ID, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,
						       @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,
						       @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,
						       @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
						       @CalendarioEsp, @IncidenciaD, @IncidenciaA,@Estacion,
	    				     @Ok OUTPUT, @OkRef OUTPUT
  	    END	
        --ELSE  SET @Ok=null
        IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
      END
      FETCH NEXT FROM crLista INTO @Personal
    END
    CLOSE crLista
    DEALLOCATE crLista
  END ELSE 
  IF @Pais ='El Salvador'
  BEGIN
    DECLARE crLista CURSOR FOR
    SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Personal
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spNominaCalcElSalvador @Empresa, @FechaTrabajo, @Sucursal, @ID, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,
                        @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,
                        @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,
                        @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                        @CalendarioEsp, @IncidenciaD, @IncidenciaA,
                        @Ok OUTPUT, @OkRef OUTPUT
        IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
      END
      FETCH NEXT FROM crLista INTO @Personal
    END
    CLOSE crLista
    DEALLOCATE crLista
  END
  ELSE IF @Pais ='Panama'
  BEGIN
    IF @NomTipo='VACACIONES' 
      EXEC spNominaGenerarVacacionesPanama @Estacion, @ID,@FechaD,@FechaA,@PeriodoTipo,	@FechaTrabajo
    ELSE BEGIN
      DECLARE crLista CURSOR FOR
      SELECT Clave FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
      OPEN crLista
      FETCH NEXT FROM crLista INTO @Personal
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
        BEGIN
          EXEC spNominaCalcPanama @Empresa, @FechaTrabajo, @Sucursal, @ID, @Moneda, @TipoCambio, @Personal, @FechaD, @FechaA, @PeriodoTipo,
                           @CfgAjusteMensualISR, @CfgSueldoMinimo, @CfgTablaVacaciones, @CfgSubsidioIncapacidadEG, @CfgPrimaDominicalAuto,
                           @CfgISRReglamentoAguinaldo, @CfgISRReglamentoPTU, @CfgISRLiquidacionSueldoMensual, @CfgFactorIntegracionAntiguedad, @CfgFactorIntegracionTabla,
                           @NomTipo, @NomCalcSDI, @NomCxc,@RepartirDesde, @RepartirHasta, @RepartirIngresoTope, @RepartirIngresoFactor, @RepartirDiasFactor,
                           @CalendarioEsp, @IncidenciaD, @IncidenciaA,
                           @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok IS NULL SELECT @Conteo = @Conteo + 1
        END
        FETCH NEXT FROM crLista INTO @Personal
      END
      CLOSE crLista
      DEALLOCATE crLista
    END
  END
  IF @Ok IS NULL
  BEGIN
    SELECT  SucursalTrabajo, ImpuestoEstatalGastoOperacionSuma = SUM(ISNULL(Importe,0)) 
      into #ImpuestoEstatalGastoOperacion
      FROM #Nomina 
      JOIN cfgNominaConcepto  ON #Nomina.NominaConcepto = cfgNominaConcepto.Nominaconcepto 
      JOIN Personal ON   #Nomina.Personal = Personal.Personal
     WHERE ClaveInterna ='ImpuestoEstatal/GastoOperacion' 
     GROUP BY Personal.SucursalTrabajo
    
    UPDATE #ImpuestoEstatalGastoOperacion 
       SET ImpuestoEstatalGastoOperacionSuma = (
           SELECT  GastoOperacion- ImpuestoEstatalGastoOperacionSuma
             FROM ImpuestoEstatalGastoOperacion
             JOIN #ImpuestoEstatalGastoOperacion on ImpuestoEstatalGastoOperacion.Sucursal=#ImpuestoEstatalGastoOperacion.SucursalTrabajo
            WHERE ImpuestoEstatalGastoOperacion.ID = @ID )

    UPDATE #Nomina SET Importe = Importe + ImpuestoEstatalGastoOperacionSuma 
      FROM #Nomina 
      JOIN PERSONAL on #Nomina.Personal = Personal.Personal
      JOIN #ImpuestoEstatalGastoOperacion ON Personal.SucursalTrabajo = #ImpuestoEstatalGastoOperacion.SucursalTrabajo
      JOIN cfgNominaConcepto ON #Nomina.NominaConcepto = cfgNominaConcepto.Nominaconcepto AND ClaveInterna ='ImpuestoEstatal/GastoOperacion' 
     WHERE #Nomina.ID in (SELECT MAX(#Nomina.ID)FROM #Nomina 
      JOIN PERSONAL on #Nomina.Personal = Personal.Personal  AND Personal.SucursalTrabajo = #ImpuestoEstatalGastoOperacion.SucursalTrabajo
      JOIN #ImpuestoEstatalGastoOperacion ON Personal.SucursalTrabajo = #ImpuestoEstatalGastoOperacion.SucursalTrabajo )

    EXEC spNominaImpuestoEstatalEspecial @Empresa,@Ok OUTPUT, @OkRef OUTPUT

    DELETE NominaD WHERE ID = @ID

    INSERT #Nomina2 (Personal,   IncidenciaID,   IncidenciaRID,   NominaConcepto,   Referencia,   Cuenta,   Vencimiento,   Beneficiario,   Importe,        Cantidad, UEN)
    SELECT d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, SUM(d.Importe), SUM(d.Cantidad), D.UEN
      FROM #Nomina d
      JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto
     WHERE NULLIF(d.Importe, 0.0) IS NOT NULL OR NULLIF(d.Cantidad, 0.0) IS NOT NULL
     GROUP BY nc.Modulo,      d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, nc.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario,D.UEN
     ORDER BY nc.Modulo DESC, d.Personal, d.IncidenciaID, d.IncidenciaRID, d.NominaConcepto, nc.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, D.UEN
    SELECT @UEN = NULL , @UEN0 = NULL, @Valor='N'
    EXEC spPersonalPropValor   @Empresa, NULL, NULL, NULL, NULL, 'Separa Nominas Por UEN', @Valor OUTPUT

    IF LEFT(ISNULL(rtrim(@Valor),''),1) ='S'
    BEGIN
      SELECT @UEN0 = @UEN,  @ID1 = @ID
      DECLARE crNominaSeparaUEN CURSOR local FOR SELECT DISTINCT UEN FROM #Nomina2 ORDER by UEN
      OPEN crNominaSeparaUEN
      FETCH NEXT FROM crNominaSeparaUEN INTO @UEN
      SELECT @UEN0 = @UEN
      WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          UPDATE Nomina  SET UEN = @UEN  WHERE ID = @ID1
          INSERT NominaD (
                       ID,  Sucursal,   Renglon, Modulo,    Personal,   IncidenciaID,    NominaConcepto,   Movimiento,    Concepto,    Referencia,   Cuenta,   FechaA,        Beneficiario,   Importe,                               Cantidad,   CuentaContable, ContUso, CuentaContable2, UEN)
                SELECT @ID1, @Sucursal, d.ID,    nc.Modulo, d.Personal, d.IncidenciaRID, d.NominaConcepto, nc.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, ROUND(d.Importe, @RedondeoMonetarios), d.Cantidad, dbo.fnNominaCuentaContable (nc.CuentaBase, nc.Cuenta, d.Personal, d.NominaConcepto, d.Cuenta, @Empresa),(SELECT CentroCostos FROM Personal WHERE Personal.Personal = d.Personal), dbo.fnNominaCuentaContable (nc.CuentaBase2, nc.Cuenta2, d.Personal, d.NominaConcepto, d.Cuenta, @Empresa), D.UEN
                  FROM #Nomina2 d
                  JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto 
                  JOIN Personal on d.Personal = Personal.Personal 
                 WHERE d.UEN = @UEN order by d.personal
        END
        SELECT @UEN0 = @UEN
        FETCH NEXT FROM crNominaSeparaUEN INTO @UEN
        IF  @UEN0 <> ISNULL(@UEN, @UEN0) AND @@FETCH_STATUS = 0
        BEGIN
          UPDATE Nomina SET  RamaID = @ID WHERE ID = @ID
          INSERT Nomina( ramaid, Empresa, Mov,  FechaEmision, UltimoCambio, Proyecto, UEN, Concepto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, Estatus, Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, FechaD, FechaA, Sucursal, Percepciones, Deducciones, FechaOrigen, FechaRegistroNomXD, FechaRegistroNomXA, SucursalOrigen,SucursalDestino)
          SELECT         ramaid, Empresa, Mov,  FechaEmision, UltimoCambio, Proyecto, UEN, Concepto, Moneda, TipoCambio, Usuario, Autorizacion, DocFuente, Observaciones, 'BORRADOR', Situacion, SituacionFecha, SituacionUsuario, SituacionNota, OrigenTipo, Origen, OrigenID, Ejercicio, Periodo, FechaRegistro, FechaConclusion, FechaCancelacion, Condicion, PeriodoTipo, @FechaD, @FechaA, Sucursal, Percepciones, Deducciones, FechaOrigen, FechaRegistroNomXD, FechaRegistroNomXA, SucursalOrigen,SucursalDestino 
            FROM Nomina WHERE ID = @ID 
          SELECT @ID1 = SCOPE_IDENTITY()
        END
      END
      CLOSE crNominaSeparaUEN
      DEALLOCATE crNominaSeparaUEN
    END ELSE
    BEGIN
      INSERT NominaD (
                ID,  Sucursal,  Renglon, Modulo,    Personal,   IncidenciaID,    NominaConcepto,   Movimiento,    Concepto,    Referencia,   Cuenta,   FechaA,        Beneficiario,   Importe,                               Cantidad,   CuentaContable, ContUso, CuentaContable2,UEN)
        SELECT @ID, @Sucursal, d.ID,    nc.Modulo, d.Personal, d.IncidenciaRID, d.NominaConcepto, nc.Movimiento, nc.Concepto, d.Referencia, d.Cuenta, d.Vencimiento, d.Beneficiario, ROUND(d.Importe, @RedondeoMonetarios), d.Cantidad, dbo.fnNominaCuentaContable (nc.CuentaBase, nc.Cuenta, d.Personal, d.NominaConcepto, d.Cuenta, @Empresa),(SELECT CentroCostos FROM Personal WHERE Personal.Personal = d.Personal), dbo.fnNominaCuentaContable (nc.CuentaBase2, nc.Cuenta2, d.Personal, d.NominaConcepto, d.Cuenta, @Empresa), D.UEN
          FROM #Nomina2 d
          JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto 
          JOIN Personal on d.Personal = Personal.Personal 
        SELECT @IDMAX = MAX(ID) from #nomina2
    END
    INSERT NominaD (
          ID,  Sucursal,  Renglon, Modulo,    Personal,       NominaConcepto,   Movimiento,    Concepto,
          Referencia,   Cuenta,   FechaA,        Beneficiario,   Importe,                               Cantidad,   CuentaContable )
          SELECT @ID, @Sucursal, d.ID + @idmax + 1,    'CXP', d.Personal, d.NominaConcepto, 'Estadistica', nc.Concepto,
          d.Referencia, nc.AcreedorDef, d.Vencimiento, d.Beneficiario, ROUND(d.Importe, @RedondeoMonetarios), d.Cantidad, NULL
          FROM #Nomina2 d
          JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto WHERE nc.Modulo = 'CXC'
               AND isnull(nc.GenerarEstadisticaCxp,0) <> 0  
      
      
    UPDATE NominaD SET MODULO = 'NOM', REFERENCIA = 'DEVOLUCION' WHERE ID = @ID AND Modulo = 'CXC' AND IMPORTE < 0.0
      
    UPDATE Nomina SET PeriodoTipo = @PeriodoTipo, FechaD = @FechaD, FechaA = @FechaA, Estatus = 'BORRADOR' WHERE ID = @ID
      
    EXEC xpNominaGenerar @Estacion, @ID, @FechaD, @FechaA, @PeriodoTipo
    SELECT CONVERT(varchar, @Conteo)+ ' Personas Procesadas'
    END ELSE
    BEGIN
      SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok
    END
  RETURN
END
GO
