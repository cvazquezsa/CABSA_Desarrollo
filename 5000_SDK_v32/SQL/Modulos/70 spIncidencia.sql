/********* Incidencia ***********/
SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO

/**************** spIncidenciaAcumuladoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaAcumuladoFechas') and type = 'P') drop procedure dbo.spIncidenciaAcumuladoFechas
GO             
CREATE PROCEDURE spIncidenciaAcumuladoFechas
			@Empresa	char(5),
			@Personal	char(10),
			@NominaConcepto	varchar(10),
			@FechaD		datetime,
			@FechaA		datetime,
			@Movimiento	varchar(50),
			@Importe	money	OUTPUT,
 			@Cantidad	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Personal   = NULLIF(RTRIM(@Personal), ''),
         @NominaConcepto   = NULLIF(RTRIM(@NominaConcepto), '')

  SELECT @Importe = 0.0, @Cantidad = 0.0

  SELECT @Importe = @Importe + ISNULL(SUM(ISNULL(d.Importe,0)), 0.0), @Cantidad = @Cantidad + ISNULL(SUM(ISNULL(d.Cantidad,0)), 0.0)
    FROM Incidencia n, IncidenciaD d, MovTipo mt
   WHERE n.ID = d.ID
     AND n.Estatus in('CONCLUIDO', 'PENDIENTE')
     AND n.Empresa = @Empresa
     AND D.FechaAplicacion BETWEEN @FechaD AND @FechaA AND mt.Clave IN ('INC.I') 
     AND n.Mov = mt.Mov
     AND mt.Modulo = 'INC'
     AND n.Personal = @Personal
     AND d.NominaConcepto = @NominaConcepto

  RETURN
END
GO

/**************** spIncidenciaClaveInternaAcumuladoFechas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaClaveInternaAcumuladoFechas') and type = 'P') drop procedure dbo.spIncidenciaClaveInternaAcumuladoFechas
GO             
CREATE PROCEDURE spIncidenciaClaveInternaAcumuladoFechas
			@Empresa	char(5),
			@Personal	char(10),
			@ClaveInterna	varchar(50),
			@FechaD		datetime,
			@FechaA		datetime,
			@Movimiento	varchar(50),
			@Importe	money	OUTPUT,
 			@Cantidad	float	OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NominaConcepto	varchar(10)

  SELECT @NominaConcepto = nc.NominaConcepto 
    FROM CfgNominaConcepto cfg
    JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
   WHERE cfg.ClaveInterna = @ClaveInterna
  EXEC spIncidenciaAcumuladoFechas @Empresa, @Personal, @NominaConcepto, @FechaD, @FechaA, @Movimiento, @Importe OUTPUT, @Cantidad OUTPUT
  RETURN
END
GO

/**************** spIncidenciaBasePanama ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaBasePanama') and type = 'P') drop procedure dbo.spIncidenciaBasePanama
GO             
CREATE PROCEDURE spIncidenciaBasePanama
			@Empresa		  char(5),
			@FechaEmision		  datetime,
			@FechaAplicacion	  datetime,
			@Personal		  char(10),
			@NominaConcepto		  varchar(10),
			@EnSilencio		  bit		= 0,
			@Cantidad		  float		= NULL	OUTPUT,
			@Valor			  money		= NULL	OUTPUT,
			@Porcentaje		  float		= NULL	OUTPUT,
			@Acreedor                 varchar(10)	= NULL	OUTPUT,
			@Vencimiento		  datetime	= NULL	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasMes			    float,
    @DiasAno			    float,
    @DiasTrabajados         float,
    @DiasPeriodoEstandar	float,
    @HorasDia			    float,
    @FactorAusentismo		float,
    @Categoria			    varchar(50),
    @Puesto			        varchar(50),
    @PeriodoTipo		    varchar(20),
    @SucursalTrabajo		int,
    @ZonaEconomica		    varchar(30),
    @Ejercicio			    int,
    @Periodo			    int,
    @SemanasPeriodo		    int,
    @SDI	    		    money,
    @SueldoDiario		    money,
    @SueldoDiarioVariable   money,
    @FechaAlta              datetime,
    @SueldoHora		        money,
    @SueldoPeriodo 		    money,
    @SueldoMensual 		    money,
    @SueldoMensualPersonal  money,
    @SMZ			            money,
    @SMDF			            money,
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
    @ImportePrimProd                    money,
    @ImporteComisiones                  money,       
    @ImporteViaticos                    money,
    @VencimientoMes		varchar(50),
    @RedondeoMonetarios int

  SELECT @RedondeoMonetarios      = RedondeoMonetarios FROM Version
  SELECT @SucursalTrabajo 	      = p.SucursalTrabajo,
         @Categoria 	  	      = p.Categoria,
         @Puesto	  	          = p.Puesto,
         @SDI	    	  	      = ISNULL(p.SDI, 0.0),
      	 @SueldoDiario	  	      = ISNULL(p.SueldoDiario, 0.0),
      	 @Sueldohora	          = ISNULL(p.RataHora, 0.0),
         @ZonaEconomica	  	      = p.ZonaEconomica,
         @HorasDia	  	          = j.HorasPromedio,
         @FactorAusentismo        = j.FactorAusentismo,
         @DiasPeriodoEstandar     = ISNULL(pt.DiasPeriodo, 0),
         @PeriodoTipo		      = p.PeriodoTipo,
         @SueldoMensualPersonal   = p.SueldoMensual,
         @FechaAlta               = p.FechaAlta
    FROM Personal p
    LEFT OUTER JOIN Jornada j ON           j.Jornada = p.Jornada 
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo
   WHERE                                  p.Personal = @Personal

  SELECT @Periodo = Periodo, @Ejercicio = Ejercicio, @SemanasPeriodo = SemanasPeriodo
    FROM PeriodoTipoCalendario
   WHERE PeriodoTipo = @PeriodoTipo AND Abierto = 1

  SELECT @SMZ  = SueldoMinimo FROM ZonaEconomica WHERE Zona = @ZonaEconomica
  SELECT @SMDF = SueldoMinimo FROM ZonaEconomica WHERE Zona = 'A'

  SELECT @CantidadBase	      	= UPPER(CantidadBase),
         @CantidadPropiedad   	= CantidadPropiedad,
         @Cantidad	      	    = CantidadDef,
         @CantidadEsPorcentaje  = ISNULL(CantidadEsPorcentaje, 0),
         @PorcentajeBase      	= UPPER(PorcentajeBase),
         @PorcentajePropiedad 	= PorcentajePropiedad,
         @Porcentaje      	    = PorcentajeDef,
         @ValorBase	      	    = UPPER(ValorBase),
         @ValorPropiedad      	= ValorPropiedad,
         @Valor		      	    = ValorDef,
         @TieneSubConceptos   	= TieneSubConceptos,
         @AcreedorBase		    = UPPER(AcreedorBase),
         @AcreedorPropiedad	    = AcreedorPropiedad,
         @Acreedor		        = AcreedorDef,
         @VencimientoBase	    = UPPER(VencimientoBase),
         @VencimientoDia	    = VencimientoDia,
         @VencimientoMes	    = VencimientoMes
    FROM NominaConcepto
   WHERE NominaConcepto         = @NominaConcepto

  SELECT @SueldoMensual         = dbo.fnPanamaSueldoMensual(@Personal, @FechaAplicacion)
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Importe Comisiones',		 @ImporteComisiones OUTPUT 
  EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, 'Importe PRIM.PRODUCC.', @ImportePrimProd OUTPUT 

  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Mes', @DiasMes OUTPUT 
  EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, '# Dias Ano', @DiasAno OUTPUT 

  SELECT @SueldoPeriodo = @SueldoDiario * @DiasPeriodoEstandar

  -- Cantidad
  IF @CantidadBase = 'PROPIEDAD'    EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @CantidadPropiedad, @Cantidad OUTPUT ELSE
  IF @CantidadBase = 'DIAS PERIODO' SELECT @Cantidad = @DiasPeriodoEstandar

  -- Porcentaje
  IF @PorcentajeBase = 'PROPIEDAD'         EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @PorcentajePropiedad, @Porcentaje OUTPUT ELSE
  IF @PorcentajeBase = 'FACTOR AUSENTISMO' SELECT @Porcentaje = @FactorAusentismo * 100.0 

 -- Valor
  SELECT @SueldoDiarioVariable = 0

  IF @ValorBase = 'SUELDO DIARIO VAC'
    EXEC spNominaPanamaSueldoDiarioVariableVacaciones  @Empresa, @Personal, @FechaAlta, @SueldoMensual/*@SueldoMensualPersonal*/ , @ImporteComisiones, @ImportePrimProd, @FechaAplicacion, @SueldoDiarioVariable OUTPUT

  IF @ValorBase = 'DIARIO VAC GASTO'
    EXEC spNominaPanamaSueldoDiarioVariableVacaciones  @Empresa, @Personal, @FechaAlta, @SueldoMensual/*@SueldoMensualPersonal*/ , @ImporteComisiones, @ImportePrimProd, @FechaAplicacion, @SueldoDiarioVariable OUTPUT, @GastosRepresentacion=1
-- SELECT * FROM vacaciontocumen

  IF @ValorBase = 'PROPIEDAD'      	      	EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @ValorPropiedad, @Valor OUTPUT ELSE 
  IF @ValorBase = 'SUELDO DIARIO'  	SELECT  @Valor = @SueldoDiario ELSE
  IF @ValorBase = 'SUELDO DIARIO VAC'  	SELECT  @Valor = @SueldoDiarioVariable ELSE
  IF @ValorBase = 'DIARIO VAC GASTO'  	SELECT  @Valor = @SueldoDiarioVariable ELSE
  
  IF @ValorBase = 'SUELDO DIARIO MES'  	SELECT  @Valor = @SueldoMensual / 30.0 ELSE
--  IF @ValorBase = 'ACUM MES ANT MENOS VAC '    EXEC   spCalculaPremioAsistencia  @Empresa, @Personal, @FechaAplicacion, @Valor   OUTPUT
  
  IF @ValorBase = 'SDI' 	   	      SELECT @Valor = @SDI ELSE
  IF @ValorBase = 'SUELDO PERIODO' 	SELECT @Valor = @SueldoDiario*@DiasPeriodoEstandar ELSE
  IF @ValorBase = 'SUELDO MENSUAL' 	SELECT @Valor = @SueldoDiario*@DiasMes ELSE
  IF @ValorBase = 'SUELDO ANUAL'   	SELECT @Valor = @SueldoDiario*@DiasAno ELSE
  IF @ValorBase = 'SUELDO HORA'     	SELECT @Valor = @SueldoHora ELSE
  IF @ValorBase = 'SUELDO HORA JORNADA' SELECT @Valor = (@SueldoDiario/NULLIF(@HorasDia, 0.0))*@FactorAusentismo ELSE
  IF @ValorBase = 'SALARIO MINIMO ZONA' SELECT @Valor = @SMZ ELSE
  IF @ValorBase = 'SALARIO MINIMO DF'   SELECT @Valor = @SMDF 
--  IF @AcreedorBase = 'PROPIEDAD' EXEC spPersonalPropValor @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @AcreedorPropiedad, @Acreedor OUTPUT

  -- Acreedor

  -- Vencimiento
  IF @VencimientoBase = 'FECHA EMISION INCIDENCIA'    SELECT @Vencimiento = @FechaEmision ELSE
  IF @VencimientoBase = 'FECHA APLICACION INCIDENCIA' SELECT @Vencimiento = @FechaAplicacion 
--
--  SELECT @Valor = ROUND(@Valor, @RedondeoMonetarios)
  SELECT @Porcentaje = ISNULL(@Porcentaje, 100.0)
  IF @EnSilencio = 0
    SELECT "Cantidad" = @Cantidad, "Valor" = @Valor, "Porcentaje" = @Porcentaje, "Acreedor" = @Acreedor, "Vencimiento" = @Vencimiento

  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaBase') and type = 'P') drop procedure dbo.spIncidenciaBase
GO 
CREATE PROCEDURE spIncidenciaBase
			@Empresa		  char(5),
			@FechaEmision		  datetime,
			@FechaAplicacion	  datetime,
			@Personal		  char(10),
			@NominaConcepto		  varchar(10),
			@EnSilencio		  bit		= 0,
			@Cantidad		  float		= NULL	OUTPUT,
			@Valor			  money		= NULL	OUTPUT,
			@Porcentaje		  float		= NULL	OUTPUT,
			@Acreedor                 varchar(10)	= NULL	OUTPUT,
			@Vencimiento		  datetime	= NULL	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE @Pais varchar(30)

  SELECT @Pais = Pais from Empresa where empresa=@Empresa
  SELECT @Pais = UPPER(ISNULL(@Pais, 'MEXICO'))
  
  IF @Pais IN ('MEXICO', 'EL SALVADOR')
    EXEC spIncidenciaBaseMexico @Empresa,@FechaEmision, @FechaAplicacion, @Personal, 	@NominaConcepto, 	@EnSilencio,	@Cantidad OUTPUT,	@Valor OUTPUT,	@Porcentaje OUTPUT,	@Acreedor OUTPUT,	@Vencimiento OUTPUT

  IF @Pais = 'PANAMA'
    EXEC spIncidenciaBasePanama @Empresa,@FechaEmision, @FechaAplicacion, @Personal, 	@NominaConcepto, 	@EnSilencio,	@Cantidad OUTPUT,	@Valor OUTPUT,	@Porcentaje OUTPUT,	@Acreedor OUTPUT,	@Vencimiento OUTPUT

  SELECT @Valor = @Valor
  SELECT @Porcentaje = ISNULL(@Porcentaje, 100.0)
  IF @EnSilencio = 0
    SELECT "Cantidad" = @Cantidad, "Valor" = @Valor, "Porcentaje" = @Porcentaje, "Acreedor" = @Acreedor, "Vencimiento" = @Vencimiento

  RETURN
END
GO

/**************** spIncidenciaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaVerificar') and type = 'P') drop procedure dbo.spIncidenciaVerificar
GO
CREATE PROCEDURE spIncidenciaVerificar
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
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070

    IF @Estatus = 'PENDIENTE'
      IF EXISTS(SELECT * FROM IncidenciaD WHERE ID = @ID AND (Importe<>Saldo OR Cantidad<>CantidadPendiente))
        SELECT @Ok = 45030
  END 

  RETURN
END
GO


/**************** spIncidenciaCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaCalc') and type = 'P') drop procedure dbo.spIncidenciaCalc
GO             
CREATE PROCEDURE spIncidenciaCalc
			@NominaConcepto		varchar(10),
			@Empresa		char(5),
			@Personal		char(10),
			@Cantidad		float	OUTPUT,
			@Valor			float,
			@Porcentaje		float,
			@Importe		money		OUTPUT,
			@PeriodoTipo		varchar(20)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasPeriodoEstandar	float,
    @Categoria			varchar(50),
    @Puesto			varchar(50),
    @SucursalTrabajo		int,
    @ZonaEconomica		varchar(30),
    @Ejercicio			int,
    @Periodo			int,
    @SemanasPeriodo		int,
    @Factor			float,
    @CantidadEsPorcentaje	bit,
    @CantidadTope		float,
    @CantidadTopeBase		varchar(50),
    @CantidadTopePropiedad	varchar(50),
    @CantidadTopeDef		float,
    @ImporteTope		money,
    @ImporteTopeBase		varchar(50),
    @ImporteTopePropiedad	varchar(50),
    @ImporteTopeDef		money

  SELECT @SucursalTrabajo 	= p.SucursalTrabajo,
         @Categoria 	  	= p.Categoria,
         @Puesto	  	= p.Puesto,
         @DiasPeriodoEstandar	= ISNULL(pt.DiasPeriodo, 0),
         @PeriodoTipo		= p.PeriodoTipo
    FROM Personal p
    LEFT OUTER JOIN Jornada j ON j.Jornada = p.Jornada 
    LEFT OUTER JOIN PeriodoTipo pt ON pt.PeriodoTipo = p.PeriodoTipo
   WHERE p.Personal = @Personal

  SELECT @Periodo = Periodo, @Ejercicio = Ejercicio, @SemanasPeriodo = SemanasPeriodo
    FROM PeriodoTipoCalendario
   WHERE PeriodoTipo = @PeriodoTipo AND Abierto = 1

  SELECT @CantidadEsPorcentaje  = CantidadEsPorcentaje,
         @CantidadTopeBase	= CantidadTopeBase,
         @CantidadTopePropiedad	= CantidadTopePropiedad,
         @CantidadTopeDef	= CantidadTopeDef,
         @ImporteTopeBase	= ImporteTopeBase,
         @ImporteTopePropiedad	= ImporteTopePropiedad,
         @ImporteTopeDef	= ImporteTopeDef
    FROM NominaConcepto
   WHERE NominaConcepto = @NominaConcepto

  -- CantidadTope
  IF @CantidadTopeBase = 'PROPIEDAD'       EXEC spPersonalPropValorFloat @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @CantidadTopePropiedad, @CantidadTope OUTPUT ELSE
  IF @CantidadTopeBase = 'SEMANAS PERIODO' SELECT @CantidadTope = @SemanasPeriodo ELSE
  IF @CantidadTopeBase = 'DIAS PERIODO'    SELECT @CantidadTope = @DiasPeriodoEstandar

  -- ImporteTope
  IF @ImporteTopeBase = 'PROPIEDAD' EXEC spPersonalPropValorMoney @Empresa, @SucursalTrabajo, @Categoria, @Puesto, @Personal, @ImporteTopePropiedad, @ImporteTope OUTPUT 

  IF NULLIF(@CantidadTope, 0.0) IS NOT NULL AND @Cantidad > @CantidadTope SELECT @Cantidad = @CantidadTope
  IF @CantidadEsPorcentaje = 1 SELECT @Factor = @Cantidad/100.0 ELSE SELECT @Factor = @Cantidad
  IF NULLIF(@Porcentaje, 0.0) IS NOT NULL SELECT @Factor=@Factor*(@Porcentaje/100.0)
  SELECT @Importe = @Valor * @Factor
  IF NULLIF(@ImporteTope, 0.0) IS NOT NULL AND @Importe > @ImporteTope SELECT @Importe = @ImporteTope

  RETURN
END
GO

/**************** spIncidenciaD ***************cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaD') and type = 'P') drop procedure dbo.spIncidenciaD
GO             
CREATE PROCEDURE dbo.spIncidenciaD
			@ID			int,
			@Numero			int,
			@NominaConcepto		varchar(10),
			@Empresa		char(5),
			@Sucursal		int,
			@Usuario		char(10),
			@Moneda			char(10),
			@TipoCambio		float,
			@Personal		char(10),
			@FechaEmision		datetime,
			@FechaAplicacion	datetime,
			@Referencia		varchar(50),

			@Cantidad		float,
			@Importe		money,
			@Acreedor		varchar(10),
			@Vencimiento		datetime
WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @RedondeoMonetarios int,
    @Tope   float 

  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version
  SELECT  @Tope = ImporteTopeDef  FROM NominaConcepto  WHERE  NominaConcepto = @NominaConcepto
  IF @Tope  IS NOT  NULL
  BEGIN 
    IF @Importe < 0  AND @Tope < 0
      SELECT @Importe = dbo.fnMayor(@Tope,@Importe)
    ELSE    
      SELECT @Importe = dbo.fnMenor(@Tope,@Importe)
  END   
  INSERT IncidenciaD (
          Numero,  ID,  Sucursal,  FechaAplicacion,  NominaConcepto,  Cantidad,            CantidadPendiente,   Importe,                              Saldo) 
  VALUES (@Numero, @ID, @Sucursal, @FechaAplicacion, @NominaConcepto, ROUND(@Cantidad, 4), ROUND(@Cantidad, 4), ROUND(@Importe, @RedondeoMonetarios), ROUND(@Importe, @RedondeoMonetarios))
   
  RETURN
END
GO

/*
declare
  @fecha	datetime
select @fecha = '6/23/5'
exec spIncidenciaFrecuencia 1, 'FIN MES', 'Quincenal', @Fecha OUTPUT, NULL, NULL
select @fecha
exec spIncidenciaFrecuencia 2, 'FIN MES', 'Quincenal', @Fecha OUTPUT, NULL, NULL
select @fecha
exec spIncidenciaFrecuencia 3, 'FIN MES', 'Quincenal', @Fecha OUTPUT, NULL, NULL
select @fecha
*/

/************************   spIncidenciaFrecuencia   **********************************cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaFrecuencia') and type = 'P') drop procedure dbo.spIncidenciaFrecuencia
GO             
CREATE PROCEDURE dbo.spIncidenciaFrecuencia
			@Numero			int,
			@Frecuencia		varchar(20), 
    			@PeriodoTipo		varchar(20), 
			@Fecha			datetime	OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dia	int,
    @Mes	int,
    @Ano	int

IF @PeriodoTipo='CONFIDENCIAL' 
	SELECT @PeriodoTipo='QUINCENAL'
  IF @Frecuencia = 'CADA NOMINA'
  BEGIN
--    IF @Numero > 1 SELECT @Fecha = DATEADD(day, 1, @Fecha)
    EXEC spCalcularPeriodicidad @Fecha, @PeriodoTipo, @Fecha OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  END ELSE 
  BEGIN
--    IF @Numero > 1 OR (@Frecuencia = 'INICIO MES' AND DAY(@Fecha)>1)   SELECT @Fecha = DATEADD(month, 1, @Fecha)

    SELECT @Dia = DAY(@Fecha), @Mes = MONTH(@Fecha), @Ano = YEAR(@Fecha)
    IF @Frecuencia = 'INICIO MES' SELECT @Dia = 1 ELSE
    IF @Frecuencia = 'FIN MES' EXEC spDiasMes @Mes, @Ano, @Dia OUTPUT
    EXEC spIntToDateTime @Dia, @Mes, @Ano, @Fecha OUTPUT
  END
  EXEC xpIncidenciaFrecuencia @Numero, @Frecuencia, @PeriodoTipo, @Fecha OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO


/***********************  spIncidenciaGenerar  ****************cambio ABC*/
go
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaGenerar') and type = 'P') drop procedure dbo.spIncidenciaGenerar
go
CREATE PROCEDURE dbo.spIncidenciaGenerar
@ID			int,
@NominaConcepto		varchar(10),
@Empresa		char(5),
@Sucursal		int,
@Usuario		char(10),
@Moneda			char(10),
@TipoCambio		float,
@Personal		char(10),
@FechaEmision		datetime,
@FechaAplicacion	datetime,
@Referencia		varchar(50),
@FechaD			datetime,
@FechaA			datetime,
@Cantidad		float,
@Valor			float,
@Porcentaje		float,
@Acreedor		varchar(10),
@Vencimiento		datetime,
@Repetir		bit,
@Prorratear		bit,
@Frecuencia		varchar(20),
@Veces			float,
@Especial		varchar(50),
@Ok			int		OUTPUT,
@OkRef			varchar(255)	OUTPUT
WITH ENCRYPTION
AS BEGIN
DECLARE
  @a			int,
  @Importe		money,
  @Fecha		datetime,
  @PeriodoTipo	varchar(20)
  
  SELECT @a = 1
 
  EXEC spIncidenciaCalc @NominaConcepto, @Empresa, @Personal, @Cantidad OUTPUT, @Valor, @Porcentaje, @Importe OUTPUT, @PeriodoTipo OUTPUT
  IF @Especial IN ('FALTAS', 'INCAPACIDADES', 'VACACIONES')
  BEGIN
    SELECT @Importe = @Importe / @Cantidad, @Fecha = @FechaD
    IF @Cantidad < 0 SELECT @Importe = @Importe * -1

    WHILE @a<=abs(@Cantidad) 
    BEGIN
      IF @Cantidad < 0 
      BEGIN
        EXEC spIncidenciaD @ID, @a, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Personal, @FechaEmision, @Fecha, @Referencia, -1.0, @Importe, @Acreedor, @Vencimiento
        SELECT @Fecha = DATEADD(day, -1, @Fecha)
      end else
      begin
        EXEC spIncidenciaD @ID, @a, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Personal, @FechaEmision, @Fecha, @Referencia, 1.0, @Importe, @Acreedor, @Vencimiento
        SELECT @Fecha = DATEADD(day, 1, @Fecha)
      end
      SELECT @a = @a + 1
    END
  END ELSE
  IF @Repetir = 1
  BEGIN
    WHILE @a<=@Veces
    BEGIN
      EXEC spIncidenciaFrecuencia @a, @Frecuencia, @PeriodoTipo, @FechaAplicacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      EXEC spIncidenciaD @ID, @a, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Personal, @FechaEmision, @FechaAplicacion, @Referencia, @Cantidad, @Importe, @Acreedor, @Vencimiento
      SELECT @a = @a + 1
    END
  END ELSE
    IF @Prorratear = 1
    BEGIN
      SELECT @Importe = @Importe / @Veces
      WHILE @a<=@Veces
      BEGIN
        EXEC spIncidenciaFrecuencia @a, @Frecuencia, @PeriodoTipo, @FechaAplicacion OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spIncidenciaD @ID, @a, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Personal, @FechaEmision, @FechaAplicacion, @Referencia, @Cantidad, @Importe, @Acreedor, @Vencimiento
        SELECT @a = @a + 1
      END
    END ELSE
      EXEC spIncidenciaD @ID, @a, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @Moneda, @TipoCambio, @Personal, @FechaEmision, @FechaAplicacion, @Referencia, @Cantidad, @Importe, @Acreedor, @Vencimiento
      
    RETURN
  END
GO

/**************** spIncidenciaAfectar ***************cambioABC*/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaAfectar') and type = 'P') drop procedure dbo.spIncidenciaAfectar
GO             
CREATE PROCEDURE dbo.spIncidenciaAfectar
    		   @ID                int,
     		   @Accion			      char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             varchar(20)	OUTPUT,
    		   @MovTipo     		  char(20),
		       @MovMoneda			    char(10),
		       @MovTipoCambio		  float,
    		   @FechaEmision      datetime,
    		   @FechaAfectacion   datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      	varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      char(10),
    		   @DocFuente	      	int,
    		   @Observaciones     varchar(255),
    		   @Concepto     		  varchar(50),
    		   @Referencia			  varchar(50),
    		   @Estatus           char(15),
 	    	   @EstatusNuevo	    char(15),
    		   @FechaRegistro     datetime,
    		   @Ejercicio	      	int,
    		   @Periodo	      		int,
		       @MovUsuario			  char(10),

    		   @FechaAplicacion		datetime,
		       @Personal			    varchar(10),
		       @NominaConcepto		varchar(10),
		       @FechaD			      datetime,
		       @FechaA			      datetime,
		       @Cantidad			    float,
		       @Valor			        float,
		       @Porcentaje			  float,
		       @Acreedor			    varchar(10),
		       @Vencimiento			  datetime,
		       @Repetir			      bit,
		       @Prorratear			  bit,
		       @Frecuencia			  varchar(20),
    		   @Veces			        float,

    		   @Conexion			    bit,
           @SincroFinal			  bit,
           @Sucursal			    int,
           @SucursalDestino		int,
           @SucursalOrigen		int,

    		   @CfgContX			    bit,
		       @CfgContXGenerar		char(20),
		       @GenerarPoliza		  bit,

    		   @Generar			      bit,
    		   @GenerarMov			  char(20),
	         @GenerarAfectado		bit,
		       @IDGenerar			    int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

     		   @Ok                int          OUTPUT,
    		   @OkRef             varchar(255) OUTPUT
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Especial			      varchar(50),
    @SubEspecial		    varchar(50),
    @Fecha			        datetime,
    @TieneSubConceptos	bit,
    @NominaSubConcepto	varchar(10),
    @FechaCancelacion		datetime,
    @GenerarMovTipo		  char(20),
    @GenerarPeriodo		  int,
    @GenerarEjercicio		int,
		@CantidadSUB		    float,
    @ValorSUB			      float,
    @PorcentajeSUB		  float,
    @AcreedorSUB        varchar(10),
    @VencimientoSUB		  varchar(10) 
  -- Asignar el Consecutivo al Movimiento


  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

--select '@Accion'=@Accion
  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, NULL, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT
    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      SELECT @Especial = Especial, @TieneSubConceptos = TieneSubConceptos
        FROM NominaConcepto
       WHERE NominaConcepto = @NominaConcepto
      IF @Accion = 'AFECTAR'
      BEGIN
        DELETE IncidenciaD WHERE ID = @ID
        EXEC spIncidenciaGenerar @ID, @NominaConcepto, @Empresa, @Sucursal, @Usuario, @MovMoneda, @MovTipoCambio, @Personal, @FechaEmision, @FechaAplicacion, @Referencia, @FechaD, @FechaA, @Cantidad, @Valor, @Porcentaje, @Acreedor, @Vencimiento, @Repetir, @Prorratear, @Frecuencia, @Veces, @Especial, @Ok OUTPUT, @OkRef OUTPUT

        IF @TieneSubConceptos = 1 
        BEGIN
          DECLARE crNominaSubConcepto CURSOR LOCAL FOR
           SELECT sub.NominaSubConcepto, nc.Especial 
             FROM NominaSubConcepto sub
             JOIN NominaConcepto nc ON nc.NominaConcepto = sub.NominaSubConcepto
            WHERE sub.NominaConcepto = @NominaConcepto
          OPEN crNominaSubConcepto
          FETCH NEXT FROM crNominaSubConcepto INTO @NominaSubConcepto, @SubEspecial
          WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
          BEGIN
            IF @@FETCH_STATUS <> -2 
            BEGIN
              EXEC spIncidenciaBase @Empresa, @FechaEmision,	@FechaAplicacion	,		@Personal,
			            @NominaSubConcepto, 1,
                                    @Cantidad,	@ValorSUB     OUTPUT,
                                    @PorcentajeSUB		 OUTPUT,
                                    @AcreedorSUB       OUTPUT,
                                    @VencimientoSUB		 OUTPUT -- ojo agrege lo de el if hay que probarlo
              if @ValorSUB <> 0
                EXEC spIncidenciaGenerar @ID, @NominaSubConcepto, @Empresa, @Sucursal, @Usuario, @MovMoneda, @MovTipoCambio, @Personal, @FechaEmision, @FechaAplicacion, @Referencia, @FechaD, @FechaA, 
                                          @Cantidad, @ValorSUB, @PorcentajeSUB, @AcreedorSUB, @VencimientoSUB, @Repetir, @Prorratear, @Frecuencia, @Veces, @SubEspecial, @Ok OUTPUT, @OkRef OUTPUT
            END
            FETCH NEXT FROM crNominaSubConcepto INTO @NominaSubConcepto, @SubEspecial
          END
          CLOSE crNominaSubConcepto
          DEALLOCATE crNominaSubConcepto
        END
      END

      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030) 
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
        IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
        BEGIN
	        IF @Estatus IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
          IF @Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR') AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
        END  

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
        UPDATE Incidencia
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
      	       Estatus          = @EstatusNuevo,
               Situacion      	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza,
               PersonalSucursal = CASE @Accion WHEN 'AFECTAR' THEN (SELECT SucursalTrabajo FROM Personal WHERE Personal = @Personal) ELSE PersonalSucursal END
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
        IF @Accion = 'AFECTAR'
        BEGIN
/*          SELECT TOP 1 d.FechaAplicacion
            FROM IncidenciaD d
            JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Especial IN ('Faltas', 'Incapacidades')
            JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO')
           GROUP BY d.FechaAplicacion
           ORDER BY d.FechaAplicacion*/
--       HAVING COUNT(*) > 1 */

          SELECT @Fecha = NULL

/*          SELECT TOP 1 @Fecha = d.FechaAplicacion
            FROM IncidenciaD d
            JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Especial IN ('Faltas', 'Incapacidades')
            JOIN Incidencia i ON i.ID = d.ID AND i.Empresa = @Empresa AND i.Personal = @Personal AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND i.id <> @ID
           GROUP BY d.FechaAplicacion
          HAVING ABS(SUM(d.Cantidad)) > 1 
           ORDER BY d.FechaAplicacion
*/
          IF @Fecha IS NOT NULL
            SELECT @Ok = 30700, @OkRef = RTRIM(@Personal)+' - '+@NominaConcepto+' ('+CONVERT(varchar, @Fecha, 103)+')'
        END
      END
    END

    IF @Acreedor IS NOT NULL
    BEGIN
      IF (SELECT TieneMovimientos FROM Prov WHERE Proveedor = @Acreedor) = 0
        UPDATE Prov SET TieneMovimientos = 1 WHERE Proveedor = @Acreedor
    END


    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 

  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  RETURN
END
GO

/**************** spIncidencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidencia') and type = 'P') drop procedure dbo.spIncidencia
GO
CREATE PROCEDURE spIncidencia
                   @ID                  	int,
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
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Generar		bit,
    @GenerarAfectado	bit,
    @Sucursal		int,
    @SucursalDestino	int,
    @SucursalOrigen	int,
    @EnLinea		bit,
    @PuedeEditar	bit,
    @Empresa	      	char(5),
    @MovTipo   		char(20),
    @MovMoneda		char(10),
    @MovTipoCambio	float,
    @FechaEmision     	datetime,
    @FechaAfectacion	datetime,
    @FechaConclusion	datetime,
    @Proyecto	      	varchar(50),
    @MovUsuario	      	char(10),
    @Autorizacion     	char(10),
    @DocFuente	      	int,
    @Concepto    	varchar(50),
    @Referencia 	varchar(50),
    @Observaciones    	varchar(255),
    @Estatus          	char(15),
    @EstatusNuevo	char(15),
    @Ejercicio	      	int,
    @Periodo	      	int,
    @FechaAplicacion	datetime,
    @Personal		varchar(10),
    @NominaConcepto	varchar(10),
    @FechaD		datetime,
    @FechaA		datetime,
    @Cantidad		float,
    @Valor		float,
    @Porcentaje		float,
    @Acreedor		varchar(10),
    @Vencimiento	datetime,
    @Repetir		bit,
    @Prorratear		bit,
    @Frecuencia		varchar(20),
    @Veces		float,
    @GenerarMovID	varchar(20),
    @GenerarPoliza	bit,
    @CfgContX		bit,
    @CfgContXGenerar	char(20)/*,
    @Verificar		bit*/

  -- Inicializar Variables
  SELECT @Generar	   = 0,
	 @GenerarAfectado  = 0,
         @CfgContX         = 0,
         @CfgContXGenerar  = 'NO'/*,
	 @Verificar        = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'PENDIENTE'

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
    	 @FechaAplicacion = FechaAplicacion, @Personal = Personal, @NominaConcepto = NominaConcepto, @FechaD = FechaD, @FechaA = FechaA,
         @Cantidad = Cantidad, @Valor = Valor, @Porcentaje = Porcentaje, @Acreedor = Acreedor, @Vencimiento = Vencimiento,
         @Repetir = Repetir, @Prorratear = Prorratear, @Frecuencia = UPPER(Frecuencia), @Veces = Veces
    FROM Incidencia
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'PENDIENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE'))
  BEGIN
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
  
    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spIncidenciaVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, 
          	               @Conexion, @SincroFinal, @Sucursal, @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
   
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spIncidenciaAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			       @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                               @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
    	 		       @FechaAplicacion, @Personal, @NominaConcepto, @FechaD, @FechaA,
		               @Cantidad, @Valor, @Porcentaje, @Acreedor, @Vencimiento,
		               @Repetir, @Prorratear, @Frecuencia, @Veces,
		               @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                               @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT

  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus - '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento - '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento - '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

/**************** spIncidenciaH ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaH') and type = 'P') drop procedure dbo.spIncidenciaH
GO             
CREATE PROCEDURE spIncidenciaH
		   @Estacion	int,
		   @Sucursal	int,
    		   @Empresa	char(5),
    		   @Usuario	char(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @IncidenciaID	int,
    @IDGenerar		int,
    @Mov		char(20),
    @MovID		varchar(20),
    @FechaEmision	datetime,
    @FechaAplicacion	datetime,
    @FechaRegistro	datetime,
    @Personal		varchar(10),
    @NominaConcepto	varchar(10),
    @Referencia		varchar(50),
    @Moneda		char(10),   
    @TipoCambio		float,
    @Cantidad		float,
    @CantidadBase	float,
    @Valor		float,
    @Importe		money,
    @Porcentaje 	float, 
    @Acreedor 		varchar(10),
    @Vencimiento	datetime,
    @FechaD		datetime,
    @FechaA		datetime,
    @Horas		varchar(5),
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

  DECLARE crIncidenciaH CURSOR FOR
   SELECT ID, Mov, FechaEmision, NULLIF(RTRIM(NominaConcepto), ''), NULLIF(RTRIM(Referencia), ''), NULLIF(RTRIM(Personal), ''), NULLIF(Cantidad, 0.0), NULLIF(Importe, 0.0), FechaD, FechaA, NULLIF(NULLIF(RTRIM(Horas), ''), '00'+CHAR(58)+'00')
     FROM IncidenciaH
    WHERE Usuario = @Usuario AND Empresa = @Empresa

  OPEN crIncidenciaH
  FETCH NEXT FROM crIncidenciaH INTO @ID, @Mov, @FechaEmision, @NominaConcepto, @Referencia, @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND (@Personal IS NOT NULL AND @NominaConcepto IS NOT NULL)
    BEGIN
      SELECT @FechaAplicacion = ISNULL(@FechaD, @FechaEmision)
      EXEC spIncidenciaBase @Empresa, @FechaEmision, @FechaAplicacion, @Personal, @NominaConcepto, 
                            @EnSilencio = 1, @Cantidad = @CantidadBase OUTPUT, @Valor = @Valor OUTPUT, @Porcentaje = @Porcentaje OUTPUT, @Acreedor = @Acreedor OUTPUT, @Vencimiento = @Vencimiento OUTPUT
      IF @Horas IS NOT NULL EXEC spHorasToCantidad @Horas, @Cantidad OUTPUT
      IF @Cantidad IS NULL SELECT @Cantidad = @CantidadBase
      IF @Importe IS NOT NULL SELECT @Valor = (@Importe / @Cantidad) * ISNULL(NULLIF(@Porcentaje, 0.0), 100.0) / 100.0
      INSERT Incidencia (
              Sucursal,  SucursalOrigen, Empresa,  Mov,  FechaEmision,  FechaAplicacion,   Usuario,  Moneda,  TipoCambio,  Estatus,      Proyecto,  UEN,  NominaConcepto,  Personal,  Referencia,  Cantidad,  Valor,  Porcentaje,  Acreedor,  Vencimiento,  FechaD,  FechaA)
      VALUES (@Sucursal, @Sucursal,      @Empresa, @Mov, @FechaEmision, @FechaAplicacion, @Usuario, @Moneda, @TipoCambio, 'SINAFECTAR', @Proyecto, @UEN, @NominaConcepto, @Personal, @Referencia, @Cantidad, @Valor, @Porcentaje, @Acreedor, @Vencimiento, @FechaD, @FechaA)
      SELECT @IncidenciaID = SCOPE_IDENTITY()
      EXEC xpIncidenciaH @ID, @IncidenciaID, @Ok OUTPUT, @OkRef OUTPUT

      IF @ID IS NOT NULL      
        EXEC spIncidencia @IncidenciaID, 'INC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @Mov, @MovID OUTPUT, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL
      BEGIN
        DELETE IncidenciaH WHERE CURRENT OF crIncidenciaH
        SELECT @Conteo = @Conteo + 1
      END
    END
    FETCH NEXT FROM crIncidenciaH INTO @ID, @Mov, @FechaEmision, @NominaConcepto, @Referencia, @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas
  END  -- While
  CLOSE crIncidenciaH
  DEALLOCATE crIncidenciaH

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

/**************** spFaltaPersonal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spFaltaPersonal') and type = 'P') drop procedure dbo.spFaltaPersonal
GO             
CREATE PROCEDURE spFaltaPersonal
    		   @Empresa		char(5),
		   @Fecha		datetime,
	           @Personal		varchar(10),
		   @FaltaConcepto	varchar(10)	OUTPUT,
		   @FaltaEspecial	varchar(50)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @FaltaConcepto = NULL, @FaltaEspecial = NULL
  SELECT @FaltaConcepto = nc.NominaConcepto, @FaltaEspecial = nc.Especial
    FROM IncidenciaD d
    JOIN Incidencia i ON i.ID = d.ID AND i.Estatus IN ('PENDIENTE', 'CONCLUIDO') AND i.Empresa = @Empresa AND i.Personal = @Personal
    JOIN NominaConcepto nc ON nc.NominaConcepto = d.NominaConcepto AND nc.Especial IN ('Faltas', 'Incapacidades', 'Vacaciones')
   WHERE d.FechaAplicacion = @Fecha
  SELECT @FaltaConcepto = NULLIF(RTRIM(@FaltaConcepto), ''), @FaltaEspecial = NULLIF(RTRIM(@FaltaEspecial), '')
  RETURN
END
GO


/*
declare
    @HoraEntradaReal 		char(5),
    @HorasAsistenciaReal	float
exec spAsistePersonal 'DEMO', '8/21/2006', 'CJ', @HoraEntradaReal OUTPUT, @HorasAsistenciaReal OUTPUT
SELECT @HoraEntradaReal, @HorasAsistenciaReal
*/

/**************** spAsistePersonal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spAsistePersonal') and type = 'P') drop procedure dbo.spAsistePersonal
GO             
CREATE PROCEDURE spAsistePersonal
    		   @Empresa		char(5),
		   @Fecha		datetime,
	           @Personal		varchar(10),
		   @HoraEntradaReal 	char(5)	OUTPUT,
		   @HorasAsistenciaReal	float	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Registro		varchar(10),
    @HoraRegistro	char(5),
    @Cantidad		float

  SELECT @HoraEntradaReal = NULL, @HorasAsistenciaReal = 0.0

  DECLARE crAsiste CURSOR LOCAL FOR
   SELECT d.Registro, d.HoraRegistro
     FROM Asiste a 
     JOIN AsisteD d ON d.ID = a.ID AND d.Personal = @Personal 
    WHERE a.Empresa = @Empresa AND a.Estatus IN ('PROCESAR', 'CONCLUIDO') AND a.FechaEmision = @Fecha

  OPEN crAsiste
  FETCH NEXT FROM crAsiste INTO @Registro, @HoraRegistro
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spHorasToCantidad @HoraRegistro, @Cantidad OUTPUT
      IF @HoraEntradaReal IS NULL AND @Registro = 'Entrada'
        SELECT @HoraEntradaReal = @HoraRegistro
      IF @Registro = 'Entrada' 
        SELECT @HorasAsistenciaReal = @HorasAsistenciaReal - @Cantidad
      ELSE
        SELECT @HorasAsistenciaReal = @HorasAsistenciaReal + @Cantidad
    END
    FETCH NEXT FROM crAsiste INTO @Registro, @HoraRegistro
  END  -- While
  CLOSE crAsiste
  DEALLOCATE crAsiste

  -- esto es por si no checo la salida, pero este tema hay que analizarlo mas, tambien si sale despues de las 2359
  IF @HorasAsistenciaReal < 0.0 SELECT @HorasAsistenciaReal = 0.0
  SELECT @HorasAsistenciaReal = ISNULL(@HorasAsistenciaReal, 0.0)
  RETURN
END
GO

/**************** spIncidenciaHAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaHAgregar') and type = 'P') drop procedure dbo.spIncidenciaHAgregar
GO             
CREATE PROCEDURE spIncidenciaHAgregar
		   @Usuario		char(10),
    		   @Empresa		char(5),
		   @FechaEmision	datetime,
		   @Mov			varchar(20),
	           @Personal		varchar(10),
                   @ClaveInterna	varchar(50),
		   @Cantidad		float		= 1.0,
		   @Importe		money		= NULL,
		   @Referencia		varchar(50)	= NULL,
		   @FechaD		datetime	= NULL,
 		   @FechaA		datetime	= NULL,
		   @Horas		char(5)		= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @NominaConcepto	varchar(10)

  SELECT @NominaConcepto = nc.NominaConcepto
    FROM CfgNominaConcepto cfg
    JOIN NominaConcepto nc ON nc.NominaConcepto = cfg.NominaConcepto
   WHERE cfg.ClaveInterna = @ClaveInterna

  if not exists(select * from IncidenciaH WHERE Empresa = @Empresa AND Mov = @Mov AND NominaConcepto = @NominaConcepto AND Personal = @Personal AND FechaEmision = @FechaEmision AND FechaD = @FechaD AND @FechaA = FechaA AND ISNULL(Referencia, '') = ISNULL(@Referencia, ''))
    INSERT IncidenciaH
           (Usuario,  Empresa,  Mov,  NominaConcepto,  Referencia,  FechaEmision,  Personal,  Cantidad,  Importe,  FechaD,  FechaA,  Horas)
    VALUES (@Usuario, @Empresa, @Mov, @NominaConcepto, @Referencia, @FechaEmision, @Personal, @Cantidad, @Importe, @FechaD, @FechaA, @Horas)

  RETURN
END
GO

-- spIncidenciaSugerir 1, 'LPNOM', 0, 'VIANA', 'Incidencia', '7/9/2006', '9/8/2006', '23/8/2006'
/**************** spIncidenciaSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spIncidenciaSugerir') and type = 'P') drop procedure dbo.spIncidenciaSugerir
GO             
CREATE PROCEDURE spIncidenciaSugerir
		   @Estacion		int,
    		   @Usuario		char(10),
		   @Sucursal		int,
    		   @Empresa		char(5),
		   @Mov			varchar(20),
		   @FechaEmision	datetime,
		   @FechaD		datetime,
		   @FechaA		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ok				int,
    @OkRef			varchar(255),
    @Personal			varchar(10),
    @Fecha			datetime,
    @DiaSemanaD			int,
    @HorasPromedio		float,
    @HorasSemana		float,
    @HorasComida		float,
    @Horas			char(5),
    @HoraEntrada		char(5),
    @HoraEntradaReal 		char(5),
    @HorasAsistenciaReal	float,
    @SumaHorasAsistenciaReal	float,
    @FaltaConcepto		varchar(10),
    @FaltaEspecial		varchar(50),
    @PremioAsistencia		bit,
    @PremioPuntalidad		bit,
    @Dif			float,
    @Retardo			float,
    @SumaRetardo		float,
    @SumaRetardoHoras		float,
    @ToleraciaRetardo		float

  SET DATEFIRST 7
  SELECT @ToleraciaRetardo = 40.0, @SumaRetardo = 0.0, @Retardo = 0.0

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @DiaSemanaD = DATEPART(weekday, @FechaD)

  DECLARE crPersonal CURSOR LOCAL FOR
   SELECT p.Personal, j.HorasPromedio, j.HorasSemana, j.HorasComida
     FROM Personal p
     JOIN Jornada j ON j.Jornada = p.Jornada AND j.Tipo = 'Personal'
    WHERE p.Estatus = 'ALTA'

  OPEN crPersonal
  FETCH NEXT FROM crPersonal INTO @Personal, @HorasPromedio, @HorasSemana, @HorasComida
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND EXISTS(SELECT * FROM PersonalEntrada WHERE Personal = @Personal AND Fecha BETWEEN @FechaD AND @FechaA) AND @Ok IS NULL
    BEGIN
      SELECT @Fecha = @FechaD    
      WHILE @Fecha BETWEEN @FechaD AND @FechaA
      BEGIN      
        IF DATEPART(weekday, @Fecha) = @DiaSemanaD
          SELECT @PremioAsistencia = 1, @PremioPuntalidad = 1, @SumaHorasAsistenciaReal = 0.0, @SumaRetardo = 0.0

        SELECT @HoraEntrada = NULL
        SELECT @HoraEntrada = NULLIF(NULLIF(RTRIM(Hora), ''), '00'+CHAR(58)+'00') FROM PersonalEntrada WHERE Personal = @Personal AND Fecha = @Fecha
        IF @HoraEntrada IS NOT NULL
        BEGIN
          EXEC spAsistePersonal @Empresa, @Fecha, @Personal, @HoraEntradaReal OUTPUT, @HorasAsistenciaReal OUTPUT
          EXEC spDifHoras @HoraEntrada, @HoraEntradaReal, @Dif OUTPUT, @EnMinutos = 1
          SELECT @Dif = ISNULL(@Dif ,0.0)
          IF @Dif > 0.0 
            SELECT @Retardo = @Dif

          SELECT @SumaHorasAsistenciaReal = @SumaHorasAsistenciaReal + @HorasAsistenciaReal,
                 @SumaRetardo = @SumaRetardo + @Retardo
          SELECT @Retardo = 0

          IF @HorasAsistenciaReal > 0.0 
          BEGIN
            -- si asistio
            IF @HoraEntradaReal > @HoraEntrada SELECT @PremioPuntalidad = 0

            IF @HorasAsistenciaReal >= @HorasPromedio
            BEGIN
              IF DATEPART(weekday, @Fecha) = 1 
                EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'PrimaDominical', @FechaD = @Fecha
              IF EXISTS(SELECT * FROM DiaFestivo WHERE Fecha = @Fecha AND EsLaborable = 0)
                EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'DiaFestivo', @FechaD = @Fecha
            END
          END ELSE
          BEGIN
            -- si falto
	    SELECT @PremioAsistencia = 0, @PremioPuntalidad = 0
            EXEC spFaltaPersonal @Empresa, @Fecha, @Personal, @FaltaConcepto OUTPUT, @FaltaEspecial OUTPUT
            IF @FaltaConcepto IS NULL EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'Falta/Injustificada', @FechaD = @Fecha
          END         
        END      
        SELECT @Fecha = DATEADD(day, 1, @Fecha)

        -- Generar Incidencias del Personal x Semana
        IF DATEPART(weekday, @Fecha) = @DiaSemanaD
        BEGIN
          IF @SumaHorasAsistenciaReal >= @HorasSemana AND @SumaRetardo < @ToleraciaRetardo
            EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'PremioAsistencia', @FechaD = @Fecha

          IF @PremioPuntalidad = 1                    
            EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'PremioPuntualidad', @FechaD = @Fecha
 
          IF @SumaRetardo > 0.0
          BEGIN
            SELECT @SumaRetardoHoras = @SumaRetardo / 60.0
            EXEC spCantidadToHoras @SumaRetardoHoras, @Horas OUTPUT
            EXEC spIncidenciaHAgregar @Usuario, @Empresa, @FechaEmision, @Mov, @Personal, 'HorasNoTrabajadas', @FechaD = @Fecha, @Horas = @Horas, @Cantidad = 0.0
          END
        END
      END
    END
    FETCH NEXT FROM crPersonal INTO @Personal, @HorasPromedio, @HorasSemana, @HorasComida
  END  -- While
  CLOSE crPersonal
  DEALLOCATE crPersonal
  RETURN
END
GO


/**************** spPersonalEntradaHSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalEntradaHSugerir') and type = 'P') drop procedure dbo.spPersonalEntradaHSugerir
GO             
CREATE PROCEDURE spPersonalEntradaHSugerir
		@Sucursal	int
--//WITH ENCRYPTION
AS BEGIN
  DELETE PersonalEntradaH WHERE Sucursal = @Sucursal
  INSERT PersonalEntradaH (Personal, Sucursal) SELECT Personal, @Sucursal FROM Personal WHERE Estatus = 'ALTA' AND SucursalTrabajo = @Sucursal
  RETURN
END
GO

/**************** spPersonalEntradaHProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPersonalEntradaHProcesar') and type = 'P') drop procedure dbo.spPersonalEntradaHProcesar
GO             
CREATE PROCEDURE spPersonalEntradaHProcesar
			@Sucursal	int,
			@Fecha		datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Personal	char(10),
    @Domingo	varchar(5),
    @Lunes	varchar(5),
    @Martes	varchar(5),
    @Miercoles	varchar(5),
    @Jueves	varchar(5),
    @Viernes	varchar(5),
    @Sabado	varchar(5),
    @FLunes	datetime,
    @FMartes	datetime,
    @FMiercoles	datetime,
    @FJueves	datetime,
    @FViernes	datetime,
    @FSabado	datetime,
    @Hoy	datetime,
    @Ok		int,
    @OkRef	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  SELECT @Hoy = GETDATE()
  SELECT @FLunes = @Fecha + 1, @FMartes = @Fecha + 2, @FMiercoles = @Fecha + 3, @FJueves = @Fecha + 4, @FViernes = @Fecha + 5, @FSabado = @Fecha + 6
--  DELETE PersonalEntrada WHERE Fecha BETWEEN @Fecha AND DATEADD(day, 6, @Fecha) AND Sucursal = @Sucursal

  DECLARE crPersonalEntradaH CURSOR LOCAL FOR
   SELECT Personal, NULLIF(Domingo,''), NULLIF(Lunes,''), NULLIF(Martes,''), NULLIF(Miercoles,''), NULLIF(Jueves,''), NULLIF(Viernes,''), NULLIF(Sabado,'')
     FROM PersonalEntradaH
    WHERE Sucursal = @Sucursal

  OPEN crPersonalEntradaH
  FETCH NEXT FROM crPersonalEntradaH INTO @Personal, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Domingo IS NOT NULL AND @Fecha > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Domingo WHERE Personal = @Personal AND Fecha = @Fecha
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @Fecha, @Domingo
      END

      IF @Lunes IS NOT NULL AND @FLunes > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Lunes WHERE Personal = @Personal AND Fecha = @FLunes
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FLunes, @Lunes
      END

      IF @Martes IS NOT NULL AND @FMartes > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Martes WHERE Personal = @Personal AND Fecha = @FMartes
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FMartes, @Martes
      END

      IF @Miercoles IS NOT NULL AND @FMiercoles > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Miercoles WHERE Personal = @Personal AND Fecha = @FMiercoles
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FMiercoles, @Miercoles
      END

      IF @Jueves IS NOT NULL AND @FJueves > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Jueves WHERE Personal = @Personal AND Fecha = @FJueves
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FJueves, @Jueves
      END

      IF @Viernes IS NOT NULL AND @FViernes > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Viernes WHERE Personal = @Personal AND Fecha = @FViernes
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FViernes, @Viernes
      END

      IF @Sabado IS NOT NULL AND @FSabado > @Hoy
      BEGIN
        UPDATE PersonalEntrada SET Hora = @Sabado WHERE Personal = @Personal AND Fecha = @FSabado
        IF @@ROWCOUNT = 0
        INSERT PersonalEntrada (Personal, Fecha, Hora) SELECT @Personal, @FSabado, @Sabado
      END

    END
    FETCH NEXT FROM crPersonalEntradaH INTO @Personal, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado
  END  -- While
  CLOSE crPersonalEntradaH
  DEALLOCATE crPersonalEntradaH

  DELETE PersonalEntradaH

  IF @Ok IS NULL
    SELECT 'Se Proceso con Exito el Registro de Horario Entrada'
  ELSE
    SELECT 'Error al Procesar'
  RETURN
END
GO


if exists (select * from sysobjects where id = object_id('spCancelarSaldoIncidencia') and type = 'P') drop procedure spCancelarSaldoIncidencia
GO
CREATE PROCEDURE spCancelarSaldoIncidencia 
				 @ID int, 
				 @Rid int 
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @A INT
  UPDATE INCIDENCIAD 
     SET Saldo=0, Cantidad=0, Importe=0, CantidadPendiente = 0,fechaaplicacion=null, nominaconcepto =''
   WHERE ID = @ID 
     AND Saldo <> 0 
     AND rid   = @Rid

  SELECT @A=@@ROWCOUNT
  IF @A >0
  BEGIN
    SELECT 'Se Cancelaror ' + Convert(varchar,@A) + ' Detalles.'
    IF ( SELECT SUM(isnull(saldo,0)) FROM  IncidenciaD WHERE ID = @ID) = 0
      UPDATE incidencia SET Estatus = 'CONCLUIDO' WHERE ID = @ID and Estatus <> 'CANCELADO'   
  END
END
GO


PRINT "******************* SP Incidencia ******************"
GO
