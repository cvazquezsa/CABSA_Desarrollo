
/***************************  spNominaMexicoImpuestoEstatal  ***************************** nuevo arreglar*/
if exists (select * from sysobjects where object_id('dbo.spNominaMexicoImpuestoEstatal')=id and type='P') drop procedure dbo.spNominaMexicoImpuestoEstatal
go
CREATE PROCEDURE dbo.spNominaMexicoImpuestoEstatal
    @Empresa                          char(5),   
    @SucursalTrabajo                  int,    
    @Personal                         char(10),  
    @NomTipo                          varchar(50),   
    @DiasNaturales                    float,  
    @SMZ                              float,  
    @PrimerDiaBimestre                datetime,  
    @PrimerDiaMes                     datetime,  
    @SucursalTrabajoEstado            varchar(50),  
    @ImpuestoEstatalExento            Float ,  
    @ImpuestoEstatalBase              float,  
    @ImpuestoEstatal                  float,  
    @PersonalPercepciones             float,  
    @FechaA                           datetime,  
    @FechaD                           datetime,  
    @ImpuestoEstatalPct               float ,  
    @ImpuestoEstatalGastoOperacionPct float ,  
    @AcreedorImpuestoEstatal          varchar(50),  
    @ImpuestoEstatalVencimiento       datetime,  
    @CalcImporte                      float,  
    @Estacion                         int,
    @id                               int,
    @Ok                               int    OUTPUT,  
    @OkRef                            varchar(255)  OUTPUT  
--//WITH ENCRYPTION  
AS BEGIN  
 DECLARE 
   @Importe                       float, 
   @ImporteP                      float, 
   @ImporteLista                  float, 
   @ImporteListaPersonal          float, 
   @ImpuestoEstatalBaseGrava      float, 
   @ImpuestoEstatalGastoOperacion float,
   @Cantidad                      int,  
   @ImpuestoEstatalExentoT        money, 
   @Porcentaje                    float, 
   @Categoria                     varchar(10), 
   @Puesto                        varchar(10),
   @TasaAdicionalImpuestoEstatal  float, 
   @TasaAdicionalImp              float

 EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# SM ImpuestoEstatalExento'    ,  @ImpuestoEstatalExento OUTPUT  
 EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '% TasaAdicionalImpuestoEstatal',  @TasaAdicionalImpuestoEstatal OUTPUT  
 EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'GastosOperacionImpuestoEstatal',  @ImpuestoEstatalGastoOperacion OUTPUT  
 
 IF @NomTipo = 'Impuesto Estatal'  
 BEGIN  
  SELECT @PrimerDiaMes = DATEADD(day, 1-DAY(@FechaA), @FechaA)    
  SELECT @Importe = 0.0 , @Cantidad =0.0  
  
  SELECT @Importe = ISNULL(SUM(ISNULL(d.Importe,0)), 0.0)   
    FROM Nomina n, NominaD d, MovTipo mt,Cfgnominaconcepto c, Personal p, sucursal s  
   WHERE n.ID = d.ID  
     AND n.Estatus in('CONCLUIDO')  
     AND n.Empresa = @Empresa  
     AND n.FechaA BETWEEN @PrimerDiaMes AND @FechaA AND mt.Clave IN ('NOM.N', 'NOM.NE','NOM.NA')   
     AND n.Mov = mt.Mov  
     AND mt.Modulo = 'NOM'  
     AND d.Concepto = c.Descripcion  
	   AND d.personal = p.personal  
     AND c.claveinterna ='ImpuestoEstatal/Base'  
	   AND p.SucursalTrabajo = s.sucursal  -- aqui esta el error
	   AND s.estado = @SucursalTrabajoEstado  -- aqui esta el error
  

  SELECT @ImpuestoEstatalBase = @Importe  

  SELECT @ImporteLista = ISNULL(SUM(ISNULL(d.Importe,0)), 0.0)   
    FROM Nomina n, 
         NominaD d, 
         MovTipo mt,
         Cfgnominaconcepto c, 
         Personal p, 
         Sucursal s  
   WHERE n.ID              = d.ID  
     AND n.Estatus in('CONCLUIDO')  
     AND n.Empresa         = @Empresa  
     AND n.FechaA          BETWEEN @PrimerDiaMes AND @FechaA AND mt.Clave IN ('NOM.N', 'NOM.NE','NOM.NA')   
     AND n.Mov             = mt.Mov  
     AND mt.Modulo         = 'NOM'  
     AND d.Concepto        = c.Descripcion  
	   AND d.personal        = p.Personal  
     AND c.claveinterna    = 'ImpuestoEstatal/Base'  
	   AND p.SucursalTrabajo = s.Sucursal  
	   AND s.Estado          = @SucursalTrabajoEstado
	   AND d.Personal in(SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)  

  SELECT @ImporteLista = ISNULL(@ImporteLista,1)
  SELECT @Cantidad = COUNT(PERSONAL) 
    FROM Personal p, sucursal s  
   WHERE p.SucursalTrabajo = s.sucursal  
     AND s.estado = @SucursalTrabajoEstado  
     AND PERSONAL IN (SELECT Clave FROM ListaSt WHERE Estacion = @Estacion)  
  
  SELECT @ImporteP =  ISNULL(SUM(ISNULL(d.Importe,0)), 0.0)   
    FROM Nomina n, NominaD d, MovTipo mt,Cfgnominaconcepto c, Personal p, sucursal s  
   WHERE n.ID = d.ID  
     AND n.Estatus in('CONCLUIDO')  
     AND n.Empresa = @Empresa  
     AND n.FechaA BETWEEN @PrimerDiaMes AND @FechaA AND mt.Clave IN ('NOM.N', 'NOM.NE','NOM.NA')   
     AND n.Mov = mt.Mov  
     AND mt.Modulo = 'NOM'  
     AND d.Concepto = c.Descripcion  
	   AND d.personal = p.personal  
     AND c.claveinterna ='ImpuestoEstatal/Base'  
	   AND p.SucursalTrabajo = s.sucursal  
	   AND s.estado = @SucursalTrabajoEstado
	   AND d.personal = @Personal  

    --select '@ImporteP'=@ImporteP
  SELECT @Cantidad = ISNULL(@Cantidad,0.0)  
  IF @Cantidad=0 SELECT @Cantidad=0.0  
  SELECT @ImporteP = isnull(@ImporteP,0.0)
  IF @ImporteP=0 SELECT @ImporteP=0.0
  
  SELECT @ImpuestoEstatalExento = ISNULL(@ImpuestoEstatalExento,0.0)  
  IF ISNULL(@ImpuestoEstatalPct,0)=0 SELECT @ImpuestoEstatalPct=0.0
  IF ISNULL(@ImporteLista,0) =0 SELECT @ImporteLista=1.0

  IF UPPER(@SucursalTrabajoEstado) IS NOT NULL 
  BEGIN  
    SELECT @ImpuestoEstatalExento = @ImpuestoEstatalExento * (@SMZ * 30.4) 
    SELECT @ImpuestoEstatalExentoT = @ImpuestoEstatalExento
    SELECT @ImpuestoEstatal = (@ImpuestoEstatalBase - @ImpuestoEstatalExento) * (@ImpuestoEstatalPct/100.0) 
    SELECT @ImporteListaPersonal =  @ImporteP/@ImporteLista

-- spNominaGenerar 114, 15471, '01/16/2008 00:00:00', '01/31/2008 00:00:00', 'Quincenal', '02/12/2008 00:00:00'
-- select * from listast where estacion=114
-- select estado,* from sucursal
--Por diferencia 
  SELECT @ImpuestoEstatalBaseGrava = @ImpuestoEstatal * @ImporteListaPersonal
  SELECT @ImpuestoEstatalExento = @ImpuestoEstatalExento *  @ImporteListaPersonal
  SELECT @Porcentaje = ((@ImporteP*100.0)/@ImporteLista)/100.0
  SELECT @TasaAdicionalImp = @ImpuestoEstatalBaseGrava * (@TasaAdicionalImpuestoEstatal/100.0) 
  SELECT @ImporteP=(@ImpuestoEstatalBase - @ImpuestoEstatalExento) * @ImporteListaPersonal
  IF ISNULL(@Cantidad,0)<>0
	BEGIN
	  SELECT @Cantidad = ISNULL(@Cantidad,0.0) * 1.00
	  SELECT @ImpuestoEstatalGastoOperacion = ISNULL(@ImpuestoEstatalGastoOperacion,0.0) * 1.00  
          IF NOT EXISTS(SELECT * FROM ImpuestoEstatalGastoOperacion WHERE ID = @ID AND Sucursal = @SucursalTrabajo) 
            INSERT ImpuestoEstatalGastoOperacion(ID , GastoOperacion, Sucursal)   VALUES(@ID, @ImpuestoEstatalGastoOperacion, @SucursalTrabajo)

	  SELECT @CalcImporte = @ImpuestoEstatalGastoOperacion/@Cantidad 
	  SELECT @CalcImporte = ROUND(@CalcImporte,7)
	END
  ELSE
	SELECT @CalcImporte = 0.0
 
  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal',         @Empresa, @Personal,@Cantidad=1, @Importe = @ImpuestoEstatalBaseGrava ,                    @Cuenta     = @AcreedorImpuestoEstatal, @Vencimiento = @ImpuestoEstatalVencimiento  
  
  IF ISNULL(@ImpuestoEstatalExento,0) <>0 
	EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/Exento',         @Empresa, @Personal,@Cantidad=1, @Importe = @ImpuestoEstatalExento,                    @Cuenta     = @AcreedorImpuestoEstatal, @Vencimiento = @ImpuestoEstatalVencimiento  

  IF ISNULL(@ImpuestoEstatalBaseGrava,0) <>0   
	EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/Base',                @Empresa, @Personal,@Cantidad=1, @Importe = @ImporteP,                 @Cuenta     = @AcreedorImpuestoEstatal, @Vencimiento = @ImpuestoEstatalVencimiento  

      --BEGIN
  IF ISNULL(@TasaAdicionalImp,0) <>0 
         EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/TasaAdicional',  @Empresa, @Personal,@Cantidad=1, @Importe = @TasaAdicionalImp,                        @Cuenta     = @AcreedorImpuestoEstatal, @Vencimiento = @ImpuestoEstatalVencimiento  

  IF ISNULL(@CalcImporte,0) <>0 
	 EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'ImpuestoEstatal/GastoOperacion', @Empresa, @Personal,@Cantidad=1, @Importe = @CalcImporte,           @Cuenta     = @AcreedorImpuestoEstatal, @Vencimiento = @ImpuestoEstatalVencimiento  
      -- END
 END  
END 
RETURN  
END  
GO  
  
/*********************************   spNominaMexicoCalcSDI  ********************** */
if exists (select * from sysobjects where object_id('dbo.spNominaMexicoCalcSdi')=id and type='P') drop procedure dbo.spNominaMexicoCalcSDI
go
CREATE PROCEDURE dbo.spNominaMexicoCalcSDI
			@Empresa			char(5), 
			@SucursalTrabajo		int, 
			@Categoria			Varchar(50), 
			@Puesto				Varchar(50), 			
			@Personal			Char(10),
			@NomTipo			Varchar(50),	
			@EsSocio			Bit,
			@SDI				Money,
			@DiasNaturales			Float,
			@Incapacidades			Float,
			@Faltas				Float,
			@SMDF				Money,
			@EsBimestre			Bit,
			@NomCalcSDI			Bit,
			@PrimerDiaBimestre		Datetime,
			@FechaA				Datetime,
			@DiasAguinaldoSiguienteSDI	Float,
			@DiasAguinaldoSDI		Float,
			@PrimaVacacionalPct		Float,
			@DiasVacacionesSiguiente	Float,
			@DiasAno			Float,
			@DiasVacaciones			Float,
			@AntiguedadSDI			Float,
			@DiasBimestre			Float,
			@DiasBimestreTrabajados		Float,
			@SueldoDiario			Money,
			@SDIAnterior			Money,
			@SDIVariableDiario		Money,
			@SDINuevo			Money,
			@FechaAntiguedad		Datetime,
			--@FechaAntiguedadImp		Money,
			@SDIBruto			Money,
			@FhiAntiguedad			Int,
			@ISRLiquidacionGravable		Money,
			@CfgFactorIntegracionAntiguedad	Varchar(20),
			@FaltasAcumulado		Float			OUTPUT,
			@IncapacidadesAcumulado		Float			OUTPUT,
			@FactorIntegracion		Float			OUTPUT,
			@IMSSObrero			Money 			OUTPUT,
			@IMSSObreroCV			Money 			OUTPUT,
			@IMSSPatron 			Money 			OUTPUT, 
			@IMSSPatronMensual 		Money 			OUTPUT,
			@IMSSPatronCV 			Money 			OUTPUT,
			@IMSSPatronRetiro	 	Money 			OUTPUT,
			@IMSSPatronInfonavit		Money 			OUTPUT,
			@IMSSBase			Money 			OUTPUT,
			@IMSSBaseMes			Money 			OUTPUT,
			@IMSSBaseAcumulado		Money 			OUTPUT,
			@IMSSObreroSinCV		Money 			OUTPUT,
			@Ok				Int			OUTPUT,
			@CfgFactorIntegracionTabla	Varchar(50)		OUTPUT,
			@OkRef				Varchar(255) 		OUTPUT,
			@Salida				int =0 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @OtorgarPrimaVacacionalAguinaldo bit, 
    @AyudaFamiliar money,
    @Vales         money,
    @Antiguedad    float
    
-- NUEVO SDI.

  SET @EsSocio=0
  IF @NomTipo = 'SDI'
  BEGIN
    EXEC spPersonalPropValorBit   @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Prima Vacacional Tipo Aguinaldo (S/N)', @OtorgarPrimaVacacionalAguinaldo OUTPUT  
    SELECT  @NomCalcSDI=1,@EsSocio=0
    IF @EsSocio = 0
    BEGIN
      EXEC spNominaIMSS @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @SDI, @DiasNaturales, @Incapacidades, @Faltas, @SMDF, 1,
                        @IMSSObrero OUTPUT, @IMSSObreroCV OUTPUT,
                        @IMSSPatron OUTPUT, @IMSSPatronMensual OUTPUT, @IMSSPatronCV OUTPUT, @IMSSPatronRetiro OUTPUT, @IMSSPatronInfonavit OUTPUT
      SELECT @IMSSObreroSinCV = @IMSSObrero-@IMSSObreroCV
      
     IF EXISTS(SELECT  EsfinBimestre  FROM MovTipoNomAutoCalendarioEsp WHERE Modulo = 'NOM' AND IncidenciaA = @FechaA and EsFinBimestre = 1)  OR  @OtorgarPrimaVacacionalAguinaldo = 1 
       SELECT @EsBimestre = 1 
     ELSE   
       IF  @OtorgarPrimaVacacionalAguinaldo = 1
         SELECT @EsBimestre = 0 
         
    
      IF @EsBimestre = 1 AND @NomCalcSDI = 1
      BEGIN
        IF @OtorgarPrimaVacacionalAguinaldo = 1 
        BEGIN
          EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'SDI Desde (DD/MM/AAAA)', @PrimerDiaBimestre OUTPUT  
          EXEC spPersonalPropValorDMA   @Empresa, NULL,   NULL, NULL, NULL, 'SDI Hasta (DD/MM/AAAA)', @FechaA OUTPUT  
        END  
        EXEC spNominaClaveInternaAcumuladoFechas @Empresa, @Personal, 'IMSS/Base', @PrimerDiaBimestre, @FechaA, NULL, @IMSSBaseAcumulado OUTPUT, NULL
        
        IF @OtorgarPrimaVacacionalAguinaldo <> 1 
        begin
          SELECT  @FaltasAcumulado=0 /*sum (a.cantidad)*/
          FROM NOMINAD a, nomina b
         WHERE a.id=b.id
           and b.estatus='concluido'
           and b.fechaemision between @PrimerDiaBimestre and @FechaA
           AND a.CONCEPTO in ('Falta Injustificada','Incapacidad EG','Incapacidad Enfermedad Continua','Incapacidad Maternidad','Incapacidad Accidente','Incapacidad Accidente Trayecto','Sancion','Permiso sin goce')
           AND A.PERSONAL=@PERSONAL
        END 
        ELSE
        BEGIN
          SELECT @FaltasAcumulado=0, @IncapacidadesAcumulado=0,@Faltas=0, @incapacidades=0
        END  
        SELECT @IMSSBaseMes =  ISNULL(@IMSSBaseAcumulado,0) + ISNULL(@IMSSBase,0)
        SELECT @FactorIntegracion = NULL
        IF @CfgFactorIntegracionAntiguedad = 'SIGUIENTE'
        BEGIN
          SELECT @FactorIntegracion = 1+((@DiasAguinaldoSiguienteSDI+((@PrimaVacacionalPct/100.0)*@DiasVacacionesSiguiente))/@DiasAno)
        END ELSE
        IF @CfgFactorIntegracionAntiguedad = 'ACTUAL' 
        BEGIN
          
          SELECT @FactorIntegracion = 1+((@DiasAguinaldoSDI+((@PrimaVacacionalPct/100.0)*@DiasVacaciones))/@DiasAno)
--spNominaGenerar 100, 1567, '04/28/2008 00:00:00', '05/11/2008 00:00:00', 'Catorcenal', '05/02/2008 00:00:00'   
--SELECT   FACTOR =@FactorIntegracion, DiasAguinaldoSDI=@DiasAguinaldoSDI, PrimaVacacionalPct=@PrimaVacacionalPct, DiasVacaciones=@DiasVacaciones, DiasAno=@DiasAno, antiguedad = @Antiguedad INTO BORR
   
-- spVerSDI 'UCCP', 0, 'DESARROLLO REGIONAL', 'Coordinador de Proyectos', '545', 0, 666.67, 'Fijo', @ZonaEconomica='C'          

          --select  convert(varchar,@DiasAguinaldoSDI)+','+ convert(varchar,@DiasVacaciones) +','+convert(varchar,@DiasAno)
        END
        ELSE
          IF @CfgFactorIntegracionAntiguedad = 'TABLA'
            EXEC spTablaNum @CfgFactorIntegracionTabla, @AntiguedadSDI, @FactorIntegracion OUTPUT
        SELECT @DiasBimestre = DATEDIFF(day, @PrimerDiaBimestre, @FechaA) + 1
        SELECT @DiasBimestreTrabajados = dbo.fnmenor(@DiasBimestre, @DiasBimestre - ISNULL(@FaltasAcumulado, 0.0) - ISNULL(@IncapacidadesAcumulado, 0.0) - @Faltas - @Incapacidades)
        
        EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Ayuda Familiar', @AyudaFamiliar OUTPUT  
        EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Vales Despensa Importe', @Vales OUTPUT  
        IF @OtorgarPrimaVacacionalAguinaldo = 1 
          SELECT @SDINuevo = dbo.fnMayor(dbo.fnMenor((@SueldoDiario * @FactorIntegracion) + (@Ayudafamiliar / 14.0)+ ((@Vales/14.0) - (@SMDF * 0.40)) + (@IMSSBaseMes / @DiasBimestreTrabajados), 25*@SMDF),@SMDF*1.0452)

        ELSE
          SELECT @SDINuevo = dbo.fnMayor(dbo.fnMenor(@SueldoDiario * @FactorIntegracion + (@IMSSBaseMes / @DiasBimestreTrabajados), 25*@SMDF),@SMDF*1.0452)   
--spNominaGenerar 100, 1587, '04/14/2008 00:00:00', '04/27/2008 00:00:00', 'Catorcenal', '05/05/2008 00:00:00'  
 -- drop table borr 
  --SELECT @PrimerDiaBimestre,(@Ayudafamiliar / 14.0), ((@Vales/14.0) - (@SMDF * 0.40))
 --SELECT * FROM BORR
 -- SELECT  @pERSONAL, @FactorIntegracion
		    SET @SDIAnterior=0
		    SELECT @SDIAnterior=isnull(sdi,0) from PERSONAL WHERE PERSONAL = @Personal
		    IF @SDIAnterior=NULL SET @SDIAnterior=0
		    SELECT @SDIVariableDiario = (@IMSSBaseAcumulado / (isnull(@DiasBimestreTrabajados,1)))

        if @Salida = 0
        BEGIN 
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI', @Empresa, @Personal, @DiasBimestreTrabajados, @SDINuevo
          EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/Factor', @Empresa, @Personal, @FactorIntegracion
        END
		    SELECT @SDIBruto = @SueldoDiario* @FactorIntegracion
		    SELECT @FhiAntiguedad=CONVERT(int,dbo.fnFormatDateTime(@FechaAntiguedad, 'YYYYMMDD'))
		    SELECT @FhiAntiguedad=(DATEDIFF(day, @fechaAntiguedad, @FechaA) + 1)/(@DiasAno)--365

		    if @Salida = 0
        BEGIN 
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/FechaAntiguedad', @Empresa, @Personal, @FhiAntiguedad
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/Bruto', @Empresa, @Personal, @Importe = @SDIBruto
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/AcumuladoGravable', @Empresa, @Personal, @Importe = @IMSSBaseAcumulado
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Dias/IMSSBimestre', @Empresa, @Personal, @DiasBimestreTrabajados
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/VariableDiario', @Empresa, @Personal, @Importe = @SDIVariableDiario
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/Neto', @Empresa, @Personal, @Importe = @SDINuevo
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'SDI/Anterior', @Empresa, @Personal, @Importe = @SDIAnterior
--		    EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/SueldoDiario', 	@Empresa, @Personal, @Importe = @SueldoDiario
		      EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Indemnizacion/Gravable', @Empresa, @Personal, @Importe = @ISRLiquidacionGravable
		    END
      END
	END
  END
  if @Salida <> 0
    SELECT @Personal,@SDINuevo
  
RETURN
-- FIN SDI 
END
GO

/**************** spNominaISRSubsidioAlEmpleoProporcional ****************/
if exists (select * from sysobjects where id = object_id('dbo.spNominaISRSubsidioAlEmpleoProporcional') and type = 'P') drop procedure dbo.spNominaISRSubsidioAlEmpleoProporcional
go
CREATE PROCEDURE dbo.spNominaISRSubsidioAlEmpleoProporcional
			@DiasPeriodo		     float,
			@DiasPeriodoSubsidio float,
			@DiasMes             float,
			@ImportePeriodo      money,
			@ISRNeto		         money	OUTPUT,
			@SubsidioAlEmpleo	   money	OUTPUT,
			@ISRBruto		         money	OUTPUT,
      @Esfinmes                        int = 0
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteMensual	money,
    @Subsidio		    money
  IF @ImportePeriodo <= 0 
  BEGIN
    SELECT @ISRNeto=0, @SubsidioAlEmpleo=0, @ISRBruto=0
    RETURN
  END 
  SELECT @DiasPeriodo = dbo.fnMayor(0,@DiasPeriodo)
  SELECT @ISRBruto = NULL, @SubsidioAlEmpleo = NULL
  IF @Esfinmes = 0  
    SELECT @ImporteMensual = @ImportePeriodo * @DiasMes /  @DiasPeriodo
  ELSE 
    SELECT @ImporteMensual = @ImportePeriodo 

  EXEC   spTablaImpuesto 'ISR', NULL,'Mensual', @ImporteMensual,  	@ISRBruto	OUTPUT
-- por la ley es siempre 30.4  
  SELECT @ImporteMensual = @ImportePeriodo * 30.4 / @DiasPeriodoSubsidio
  EXEC   spTablaImpuesto 'Subsidio Al Empleo', NULL, 'Mensual', @ImporteMensual,     	@SubsidioAlEmpleo 	OUTPUT
                          
  IF @Esfinmes = 0  
    SELECT  @ISRBruto= ISNULL(@ISRBruto, 0.0) * @DiasPeriodo / @DiasMes 
  SELECT @SubsidioAlEmpleo = @SubsidioAlEmpleo * @DiasPeriodoSubsidio / 30.4
  SELECT @ISRNeto = ISNULL(@ISRBruto, 0.0) - ISNULL(@SubsidioAlEmpleo, 0.0)  
  RETURN
END
GO

/*********************   spNominaSueldoComplemento   ********************endonde lo pongo*/

if exists (select * from sysobjects where object_id('dbo.spNominaSueldoComplemento')=id and type='P') drop procedure dbo.spNominaSueldoComplemento
go
CREATE PROCEDURE dbo.spNominaSueldoComplemento
	@Empresa								Char(5),   
	@Personal								Char(10),  
	@NomTipo								Varchar(50),   
	@DiasNaturalesTrabajados				Float,  
	@DiasVacaciones							Float,
	@EsAniversario							bit,  
	@Faltas									Int,
	@Antiguedad								float,
	@OtorgarPrimaVacacionalAniversario		Float, 
	@OtorgarDiasVacacionesAniversario		Float,
	@TipoCambio								Float,
	@RedondeoMonetarios						Float,
	@FechaA									Datetime,  
	@FechaD									Datetime,  
	@SueldoDiarioComplemento FLOAT,
	@Mov                    varchar(20), 
	@Ok										Int    OUTPUT,  
	@OkRef									Varchar(255)  OUTPUT  
--//WITH ENCRYPTION
AS BEGIN  
 
DECLARE @AnticipoDeUtilidadesImporte float,  @PrimaVacacionalPct Float, @PrimaVacacional float, @FaltasImporte Float,
        @Cantidad int,
        @Plaza varchar(10)
--SELECT '@NomTipo'=@NomTipo,'@DiasNaturalesTrabajados'=@DiasNaturalesTrabajados
 IF @NomTipo = 'Sueldo Complemento'  
 BEGIN
   IF @Mov = 'Presupuesto' 
     SELECT @DiasNaturalesTrabajados = 30

	 IF @DiasNaturalesTrabajados > 0.0
	 BEGIN
     IF ((@DiasNaturalesTrabajados = 14)  AND MONTH(@FechaA) = 2) or (@DiasNaturalesTrabajados = 16)
       SELECT @DiasNaturalesTrabajados=15
  
     INSERT #Nomina (  
           Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
     SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
       FROM IncidenciaD d  
       JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE' 
       JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto --AND nc.Movimiento = 'Percepcion'  
      WHERE NULLIF(d.SALDO, 0.0) IS NOT NULL  
 		   AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina= 'Sueldo Complemento')
			 AND d.FechaAplicacion between @FechaD AND @FechaA

		--SELECT @SueldoDiarioComplemento = ISNULL(SueldoDiarioComplemento,0.0) FROM Personal WHERE Personal.Personal = @Personal

	-- Faltas   
      SELECT @Faltas = SUM(d.Cantidad), @FaltasImporte = SUM(d.Saldo)  
         FROM IncidenciaD d  
        JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto --AND nc.Movimiento = 'DEDUCCION'  
       WHERE NULLIF(d.SALDO, 0.0) IS NOT NULL  
			AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina= 'Sueldo Complemento' AND NominaConcepto IN ('254 A'))
		GROUP BY Personal


		  IF (@OtorgarDiasVacacionesAniversario = 1 OR @OtorgarPrimaVacacionalAniversario = 1) AND @EsAniversario=1
			  BEGIN  
				IF @DiasVacaciones > 0  
				BEGIN  
				   SELECT @PrimaVacacionalPct = CASE WHEN dbo.fnEsNumerico(Valor)=1 THEN  CONVERT(tinyint,Valor)  ELSE NULL END FROM PersonalPropValor  
						WHERE Cuenta = @Empresa  AND Rama = 'EMP' AND Propiedad = '% Prima Vacacional' 
				   IF @PrimaVacacionalPct IS NULL  
					EXEC spTablaNum 'Prima Vacacional', @Antiguedad, @PrimaVacacionalPct OUTPUT  
	
				END  
				SELECT @PrimaVacacional = @SueldoDiarioComplemento * @DiasVacaciones * (ISNULL(@PrimaVacacionalPct,0)/100.0)  
			  END
			SELECT @PrimaVacacional = ISNULL(@PrimaVacacional,0), @FaltasImporte=ISNULL(@FaltasImporte,0)
               SET @AnticipoDeUtilidadesImporte=0
		SELECT @AnticipoDeUtilidadesImporte = (@SueldoDiarioComplemento*@DiasNaturalesTrabajados) - ISNULL(@FaltasImporte,0)
		SELECT @AnticipoDeUtilidadesImporte = ISNULL(@AnticipoDeUtilidadesImporte, 0) + ISNULL(@PrimaVacacional,0)
		SELECT @AnticipoDeUtilidadesImporte = @AnticipoDeUtilidadesImporte * 0.90
		SELECT @Cantidad = @DiasNaturalesTrabajados - @Faltas
		SELECT @Plaza = Plaza FROM Personal WHERE Personal = @Personal
	  EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/NomSueldoComplemento',  @Empresa, @Personal, @Importe = @AnticipoDeUtilidadesImporte, @Cantidad=@Cantidad,  @Referencia = @Plaza  
	END
 END

RETURN
END
GO
 
/*****************************   spIncidenciaBaseMexico   ********************************cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaBaseMexico') and type = 'P') drop procedure dbo.spIncidenciaBaseMexico
GO 
CREATE  PROCEDURE spIncidenciaBaseMexico
			@Empresa		     char(5),
			@FechaEmision		  datetime,
			@FechaAplicacion	datetime,
			@Personal		char(10),
			@NominaConcepto		varchar(10),
			@EnSilencio		bit		= 0,
			@Cantidad		float		= NULL	OUTPUT,
			@Valor			money		= NULL	OUTPUT,
			@Porcentaje		float		= NULL	OUTPUT,
			@Acreedor         	varchar(10)	= NULL	OUTPUT,
			@Vencimiento		datetime	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasMes			float,
    @DiasMesSueldo			float,
    @DiasAno		  	float,
    @DiasVacaciones       	float,
    @DiasVacaciones2      	float,
    @DiasVacaciones3      	float,
    @DiasTrabajados       	float,
    @MasVacaciones        	bit,
    @DiasPeriodoEstandar	float,
    @HorasDia			float,
    @FactorAusentismo		float,
    @Categoria			varchar(50),
    @Puesto			varchar(50),
    @PeriodoTipo		varchar(20),
    @SucursalTrabajo		int,
    @ZonaEconomica		varchar(30),
    @Ejercicio			int,
    @Periodo			int,
    @SemanasPeriodo		int,
    @SDI	    		money,
    @SueldoDiario		money,
    @SueldoDiarioVariable 	money,
    @SueldoVariableVacacionesA 	datetime,
    @SueldoVariableVacacionesD 	datetime,
    @FechaAlta 			datetime,

    @SueldoVariableAcumulado 	money,
    @SueldoHora		        money,
    @SueldoPeriodo 		money,
    @SueldoMensual 		money,
    @SueldoMensualPersonal 	money,

    @SMZ			money,
    @SMDF			money,

    @TieneSubConceptos		bit,
    @CantidadBase		varchar(50),
    @CantidadPropiedad		varchar(50),
    @CantidadEsPorcentaje 	bit,
    @Factor			float,
    @PorcentajeBase		varchar(50),
    @PorcentajePropiedad	varchar(50),
    @ValorBase			varchar(50),
    @ValorPropiedad		varchar(50),
    @AcreedorBase		varchar(50),
    @AcreedorPropiedad		varchar(50),
    @VencimientoBase		varchar(50),
    @VencimientoDia		int,
    @ImportePrimProd            money,
    @ImporteComisiones          money,       
    @ImporteViaticos            money,
    @VencimientoMes		varchar(50),
    @RedondeoMonetarios 	int,
    @SueldoDiarioComplemento Float

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version
  SELECT @SucursalTrabajo 	  = p.SucursalTrabajo,
         @Categoria 	  	    = p.Categoria,
         @Puesto	  	        = p.Puesto,
         @SDI	    	  	      = ISNULL(p.SDI, 0.0),
      	 @SueldoDiario	  	  = ISNULL(p.SueldoDiario, 0.0),
      	 --@Sueldohora	  	    = ISNULL(p.RataHora, 0.0),
         @ZonaEconomica	  	  = p.ZonaEconomica,
         @HorasDia	  	      = j.HorasPromedio,
         @FactorAusentismo    = j.FactorAusentismo,
         @DiasPeriodoEstandar	= ISNULL(pt.DiasPeriodo, 0),
         @PeriodoTipo		      = p.PeriodoTipo,
         @SueldoDiarioComplemento = p.SueldoDiarioComplemento,
		
         @FechaAlta             = p.FechaAlta
    FROM Personal p
    LEFT OUTER JOIN Jornada j ON j.Jornada = p.Jornada 
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo
   WHERE p.Personal = @Personal

  SELECT @Periodo = Periodo, @Ejercicio = Ejercicio, @SemanasPeriodo = SemanasPeriodo
    FROM PeriodoTipoCalendario
   WHERE PeriodoTipo = @PeriodoTipo AND Abierto = 1

  SELECT @SMZ = SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica
  SELECT @SMDF = SueldoMinimo FROM ZonaEconomica WHERE Zona = 'A'

  SELECT @CantidadBase	      	= UPPER(CantidadBase),
         @CantidadPropiedad   	= CantidadPropiedad,
         @Cantidad	      	= CantidadDef,
         @CantidadEsPorcentaje  = ISNULL(CantidadEsPorcentaje, 0),
         @PorcentajeBase      	= UPPER(PorcentajeBase),
         @PorcentajePropiedad 	= PorcentajePropiedad,
         @Porcentaje      	= PorcentajeDef,
         @ValorBase	      	= UPPER(ValorBase),
         @ValorPropiedad      	= ValorPropiedad,
         @Valor		      	= ValorDef,
         @TieneSubConceptos   	= TieneSubConceptos,
         @AcreedorBase		= UPPER(AcreedorBase),
         @AcreedorPropiedad	= AcreedorPropiedad,
         @Acreedor		= AcreedorDef,
         @VencimientoBase	= UPPER(VencimientoBase),
         @VencimientoDia	= VencimientoDia,
         @VencimientoMes	= VencimientoMes
    FROM NominaConcepto
   WHERE NominaConcepto = @NominaConcepto

  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Mes', @DiasMes OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Mes Sueldo', @DiasMesSueldo OUTPUT  
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Ano', @DiasAno OUTPUT 
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Importe Comisiones',		 @ImporteComisiones OUTPUT 
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Importe PRIM.PRODUCC.', @ImportePrimProd OUTPUT 

  SELECT @SueldoPeriodo = @SueldoDiario * @DiasPeriodoEstandar
  SELECT @SueldoMensual = @SueldoDiario * ISNULL(@DiasMesSueldo,30)

  -- Cantidad
  IF @CantidadBase = 'PROPIEDAD'    EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @CantidadPropiedad, @Cantidad OUTPUT ELSE
  IF @CantidadBase = 'DIAS PERIODO' SELECT @Cantidad = @DiasPeriodoEstandar

  -- Porcentaje
  IF @PorcentajeBase = 'PROPIEDAD'         EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @PorcentajePropiedad, @Porcentaje OUTPUT ELSE
  IF @PorcentajeBase = 'FACTOR AUSENTISMO' SELECT @Porcentaje = @FactorAusentismo*100.0 

  IF @ValorBase = 'PROPIEDAD'      	      	EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @ValorPropiedad, @Valor OUTPUT ELSE 
  IF @ValorBase = 'SUELDO DIARIO'  	SELECT  @Valor = @SueldoDiario ELSE
  IF @ValorBase = 'SUELDO DIARIO COMPLEMENTO'  	SELECT  @Valor = @SueldoDiarioComplemento ELSE
  IF @ValorBase = 'SUELDO DIARIO VAC'  	SELECT  @Valor = @SueldoDiarioVariable ELSE
  IF @ValorBase = 'SUELDO DIARIO MES'  	SELECT  @Valor = @SueldoMensualPersonal/30.0 ELSE
  IF @ValorBase = 'ACUM MES ANT MENOS VAC '    EXEC   spCalculaPremioAsistencia  @Empresa, @Personal, @FechaAplicacion, @Valor   OUTPUT
  
  IF @ValorBase = 'SDI' 	   	      SELECT @Valor = @SDI ELSE
  IF @ValorBase = 'SUELDO PERIODO' 	SELECT @Valor = @SueldoDiario*@DiasPeriodoEstandar ELSE
  IF @ValorBase = 'SUELDO MENSUAL' 	SELECT @Valor = @SueldoDiario*@DiasMesSueldo ELSE
  IF @ValorBase = 'SUELDO ANUAL'   	SELECT @Valor = @SueldoDiario*@DiasAno ELSE
  IF @ValorBase = 'SUELDO HORA'     	SELECT @Valor = @SueldoDiario/NULLIF (@HorasDia ,0.0)ELSE
  IF @ValorBase = 'SUELDO HORA JORNADA' SELECT @Valor = (@SueldoDiario/NULLIF(@HorasDia, 0.0))*@FactorAusentismo ELSE
  IF @ValorBase = 'SALARIO MINIMO ZONA' SELECT @Valor = @SMZ ELSE
  IF @ValorBase = 'SALARIO MINIMO DF'   SELECT @Valor = @SMDF 
  -- Vencimiento
  IF @VencimientoBase = 'FECHA EMISION INCIDENCIA'    SELECT @Vencimiento = @FechaEmision ELSE
  IF @VencimientoBase = 'FECHA APLICACION INCIDENCIA' SELECT @Vencimiento = @FechaAplicacion 

  SELECT @Valor = @Valor
  SELECT @Porcentaje = ISNULL(@Porcentaje, 100.0)
  IF @EnSilencio = 0
    SELECT "Cantidad" = @Cantidad, "Valor" = @Valor, "Porcentaje" = @Porcentaje, "Acreedor" = @Acreedor, "Vencimiento" = @Vencimiento,
		"ValorBase"=@ValorBase

  RETURN
END
GO
-- spIncidenciaBase 'DEMO', '04/04/2008 00:00:00', '04/04/2008 00:00:00', '00106', '0'
-- update empresa set pais='Mexi'

/************************   spAguinaldoComplemento        ***********************************donde lo pongo*/
if exists (select * from sysobjects where object_id('dbo.spAguinaldoComplemento')=id and type='P') drop procedure dbo.spAguinaldoComplemento
go
CREATE PROCEDURE dbo.spAguinaldoComplemento
	@Empresa								Char(5),   
	@Personal								Char(10),  
	@NomTipo								Varchar(50),   
	@DiasNaturalesTrabajados				Float,  
	@DiasVacaciones							Float,
	@EsAniversario							bit,  
	@Faltas									Int,
	@Antiguedad								float,
	@OtorgarPrimaVacacionalAniversario		Float, 
	@OtorgarDiasVacacionesAniversario		Float,
	@TipoCambio								Float,
	@RedondeoMonetarios						Float,
	@FechaA									Datetime,  
	@FechaD									Datetime,  
	@Ok										Int    OUTPUT,  
	@OkRef									Varchar(255)  OUTPUT  
--//WITH ENCRYPTION
AS BEGIN  
 
DECLARE @AnticipoDeUtilidadesImporte float, @SueldoDiarioComplemento FLOAT, @PrimaVacacionalPct Float, @PrimaVacacional float, @FaltasImporte Float,
        @Cantidad int


 IF @NomTipo = 'AguinaldoComplemento'  
 BEGIN
   IF @DiasNaturalesTrabajados > 0.0
   BEGIN

     DELETE #Nomina

     SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
       FROM IncidenciaD d  
       JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
       JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto 
      WHERE NULLIF(d.SALDO, 0.0) IS NOT NULL  
	AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina= 'Aguinaldo Complemento' )

      INSERT #Nomina (  
             Personal,  IncidenciaID, IncidenciaRID, NominaConcepto,   Referencia,   Fecha,             Cuenta,     Vencimiento,   Cantidad,   Importe)  
      SELECT @Personal, d.ID,         d.RID,         d.NominaConcepto, i.Referencia, d.FechaAplicacion, i.Acreedor, i.Vencimiento, d.Cantidad, ROUND(d.Saldo*(i.TipoCambio/NULLIF(@TipoCambio, 0.0)), @RedondeoMonetarios)  
        FROM IncidenciaD d  
        JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus = 'PENDIENTE'  
        JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto 
       WHERE NULLIF(d.saldo, 0.0) IS NOT NULL  
	 AND nc.NominaConcepto in ( SELECT NominaConcepto FROM MovEspecificoNomina WHERE MovEspecificoNomina= 'Aguinaldo Complemento' )

 	SELECT @SueldoDiarioComplemento = ISNULL(SueldoDiarioComplemento,0.0) FROM Personal 
         WHERE Personal.Personal = @Personal

	SELECT @Faltas = COUNT(Cantidad), @FaltasImporte = ISNULL(SUM(valor), 0) 
	  FROM Incidencia
	  JOIN NominaConcepto ON Incidencia.NominaConcepto=NominaConcepto.NominaConcepto
	   AND Especial IN ('Faltas')
	 WHERE Incidencia.Estatus='CONCLUIDO'
	   AND Incidencia.FechaEmision BETWEEN @FechaD AND @FechaA
	   AND NominaConcepto.MovEspecificoNomina ='Sueldo Complemento'
	   AND TieneSubConceptos =1
	   AND Personal = @Personal
         GROUP BY Personal

	SELECT @PrimaVacacional = ISNULL(@PrimaVacacional,0), @FaltasImporte=ISNULL(@FaltasImporte,0)
	SELECT @AnticipoDeUtilidadesImporte = (@SueldoDiarioComplemento*@DiasNaturalesTrabajados) - ISNULL(@FaltasImporte,0)
	SELECT @AnticipoDeUtilidadesImporte = ISNULL(@AnticipoDeUtilidadesImporte, 0) + @PrimaVacacional
	SELECT @AnticipoDeUtilidadesImporte = @AnticipoDeUtilidadesImporte * 0.90
        EXEC spNominaAgregarClaveInterna @Ok OUTPUT, @OkRef OUTPUT, 'Personal/NomSueldoComplemento',  @Empresa, @Personal, @Importe = @AnticipoDeUtilidadesImporte, @Cantidad=@Cantidad 
      END
 END

RETURN
END
GO


/**************** spNominaSubsidioProporcional ***************endonde lo pongo*/
if exists (select * from sysobjects where id = object_id('dbo.spNominaSubsidioProporcional') and type = 'P') drop procedure dbo.spNominaSubsidioProporcional
go
CREATE PROCEDURE dbo.spNominaSubsidioProporcional
			@DiasPeriodo		float,
			@DiasMes		float,	
  			@ImportePeriodo        	money,
  			@SubsidioAcreditable	float,
  			@Credito		money	OUTPUT

WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteMensual	money,
    @Subsidio		money,
    @FactorDiasMes	float

  SELECT  @Subsidio = NULL, @Credito = NULL, @FactorDiasMes =  NULLIF(@DiasMes, 0)
  SELECT @ImporteMensual = @ImportePeriodo * NULLIF(@FactorDiasMes, 0)
  EXEC   spTablaImpuesto 'Subsidio al Empleo', NULL, 'Mensual', @ImporteMensual,     	@Credito 	OUTPUT
  -- Para convertir de Mensual a Periodo
  SELECT @Credito = @Credito / @DiasMes

  RETURN
END
GO

GO
PRINT "******************* SP NOMINA MEXICO ******************"
