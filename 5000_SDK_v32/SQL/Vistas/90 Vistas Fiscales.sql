-- spVerContReexAf 'Reex', 1,12, 2003, 'INPC'

/**************** spVerContReexAf ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContReexAf') and sysstat & 0xf = 4) drop procedure dbo.spVerContReexAf
go
CREATE PROCEDURE spVerContReexAf
		@Empresa	char(5),
		@PeriodoD	int,
		@PeriodoA	int,
		@Ejercicio	int,
		@Tabla		char(20)
--//WITH ENCRYPTION
AS
BEGIN
DECLARE
	@Articulo	char(20),
	@Serie		char(20),
	@IndiceCierre	float

	SELECT @IndiceCierre = Importe
	  FROM TablaAnualD
	 WHERE Ejercicio = @Ejercicio AND Periodo = @PeriodoA
	   AND TablaAnual = @Tabla

CREATE TABLE #VerContReexAf (
Articulo		char(20)	COLLATE Database_Default,
Serie			varchar(50)	COLLATE Database_Default ,
ID			int,
Modulo			char(5)		COLLATE Database_Default ,
Mov			char(20)	COLLATE Database_Default ,
MovID			char(20)	COLLATE Database_Default ,
Fecha			datetime,
AdquisicionFecha	datetime	NULL,
Categoria		char(50)	COLLATE Database_Default NULL,
Periodo			int,
Ejercicio		int,
IndiceAdq		float		NULL,
IndiceCierre		float		NULL,
Saldo			money		NULL
-- PRIMARY KEY (Articulo, Serie)
)

	INSERT INTO #VerContReexAf(Articulo, Serie, ID, Modulo, Mov, MovID, Fecha, AdquisicionFecha, Categoria, Periodo, Ejercicio, IndiceAdq, IndiceCierre, Saldo)
	SELECT  f.Articulo, f.Serie, c.ID, 'COMS', c.Mov, c.MovID, c.FechaEmision, f.AdquisicionFecha, f.Categoria, c.Periodo, c.Ejercicio, b.Importe, @IndiceCierre, ISNULL(f.AdquisicionValor,0)
	  FROM Compra c
          JOIN CompraD d ON c.ID = d.ID 
          JOIN ActivoF f ON d.Articulo = f.Articulo AND f.Empresa = c.Empresa
          JOIN SerieLoteMov s ON c.Empresa = s.Empresa AND c.ID = s.ID AND d.RenglonID = s.RenglonID AND d.Articulo = s.Articulo AND ISNULL(d.SubCuenta,'') = ISNULL(s.Subcuenta,'') AND f.Serie = s.SerieLote
          JOIN MovTipo m ON c.mov = m.Mov 
          LEFT OUTER JOIN TablaAnualD t ON c.Ejercicio = t.Ejercicio AND c.Periodo = t.Periodo AND t.TablaAnual = @Tabla
          LEFT OUTER JOIN TablaAnualD b ON c.Ejercicio = b.Ejercicio AND c.Periodo = b.Periodo AND b.TablaAnual = @Tabla
	 WHERE m.Modulo = 'COMS' AND m.Clave in ('COMS.F', 'COMS.EG', 'COMS.FL')
	   AND s.Modulo = 'COMS'
	   AND c.Estatus = 'CONCLUIDO'
           AND c.Empresa = @Empresa
           AND DATEPART(month, c.FechaEmision) BETWEEN @PeriodoD AND @PeriodoA
           AND DATEPART(year, c.FechaEmision) = @Ejercicio

	DECLARE crVerContReexAf CURSOR FOR
	SELECT DISTINCT f.Articulo, f.Serie
	  FROM ActivoF f, SerieLoteD s, AuxiliarU u
	 WHERE f.articulo = s.Articulo
	   AND f.serie = s.serielote
	   AND s.Articulo = u.Cuenta
	   AND s.Modulo = u.Modulo
	   AND s.ID = u.ModuloID
	   AND ISNULL(u.AbonoU,0)-ISNULL(u.CargoU,0)>=1
	   AND DATEPART(year, u.Fecha) = @Ejercicio
	   AND DATEPART(month, u.Fecha) BETWEEN @PeriodoD AND @PeriodoA
	   AND u.Mov not in (SELECT Mov FROM MovTipo WHERE Clave in ('INV.P', 'INV.R'))
	   AND f.Empresa = @Empresa AND f.Empresa = s.Empresa AND f.Empresa = u.Empresa

OPEN crVerContReexAf
FETCH NEXT FROM crVerContReexAf INTO @Articulo, @Serie
	WHILE @@FETCH_STATUS = 0
		BEGIN
			INSERT INTO #VerContReexAf(Articulo, Serie, ID, Modulo, Mov, MovID, Fecha, AdquisicionFecha, Categoria, Periodo, Ejercicio, IndiceAdq, IndiceCierre, Saldo)
			SELECT top 1 f.Articulo, f.Serie, s.id, s.modulo, u.Mov, u.MovID, u.Fecha, f.AdquisicionFecha, f.Categoria, 'Periodo' = DATEPART(month, u.Fecha), 'Ejercicio' = DATEPART(year, u.Fecha), d.Importe, b.Importe, ISNULL(-f.AdquisicionValor,0)
			  FROM ActivoF f
                          JOIN SerieLoteD s ON f.articulo = s.Articulo AND f.serie = s.serielote AND f.Empresa = s.Empresa 
                          JOIN AuxiliarU u ON s.Articulo = u.Cuenta AND s.Modulo = u.Modulo AND s.ID = u.ModuloID AND f.Empresa = u.Empresa
                          LEFT OUTER JOIN TablaAnualD d ON DATEPART(year,f.AdquisicionFecha) = d.Ejercicio AND DATEPART(month,f.AdquisicionFecha) = d.Periodo AND d.TablaAnual = @Tabla
                          LEFT OUTER JOIN TablaAnualD b ON DATEPART(year,u.Fecha) = b.Ejercicio AND DATEPART(month,u.Fecha) = b.Periodo AND b.TablaAnual = @Tabla
			 WHERE ISNULL(u.AbonoU,0)-ISNULL(u.CargoU,0)>=1
			   AND DATEPART(year, u.Fecha) = @Ejercicio
			   AND DATEPART(month, u.Fecha) BETWEEN @PeriodoD AND @PeriodoA
			   AND u.Mov not in (SELECT Mov FROM MovTipo WHERE Clave in ('INV.P', 'INV.R'))
			   AND f.Articulo = @Articulo AND f.Serie = @Serie
			   AND f.Empresa = @Empresa
			 ORDER BY u.Fecha desc

			FETCH NEXT FROM crVerContReexAf INTO @Articulo, @Serie
		END

CLOSE crVerContReexAf
DEALLOCATE crVerContReexAf

SELECT Categoria, Periodo, Ejercicio, IndiceAdq, IndiceCierre, 'Saldo' = SUM(Saldo)
 FROM #VerContReexAf
 GROUP BY Categoria, Periodo, Ejercicio, IndiceAdq, IndiceCierre
ORDER BY Categoria, Periodo

RETURN
END
GO


-- spVerContReexMonetarios 'INTEL',  2003, 12

/**************** spVerContReexMonetarios ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContReexMonetarios') and type = 'P') drop procedure dbo.spVerContReexMonetarios
GO
CREATE PROCEDURE spVerContReexMonetarios
		@Empresa	char(5),
		@Ejercicio	int,
		@Periodo	int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @ID				int,
    @CtaActivo			char(20),
    @CtaActivoD			char(20),
    @CtaPasivo			char(20),
    @CtaPasivoD			char(20),
    @CtaPasivoA			char(20),
    @CtaInventarios		char(20),
    @CtaAF			char(20),
    @SaldoActivo		money,
    @SaldoPasivo		money,
    @Moneda			char(10),
    @Tipo			char(50),
    @Mes			int,
    @Saldo			money

	SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa


CREATE TABLE #ContReexMonetarios(
Periodo		int	NULL,
Activo		float	NULL,
Pasivo		float	NULL,
)

   SELECT DISTINCT
          @CtaActivo   		= CtaActivo,
    	  @CtaPasivo   		= CtaPasivo
     FROM EmpresaCfg a
     JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)

  SELECT @CtaActivoD = Min(Cta.Cuenta)
    FROM Cta, Cta Rama
   WHERE Cta.Rama = Rama.Cuenta
--     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND Rama.Rama = @CtaActivo

  SELECT @CtaPasivoD = Min(Cta.Cuenta)
    FROM Cta, Cta Rama
   WHERE Cta.Rama = Rama.Cuenta
--     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND Rama.Rama = @CtaPasivo

  SELECT @CtaPasivoA = Max(Cta.Cuenta)
    FROM Cta, Cta Rama
   WHERE Cta.Rama = Rama.Cuenta
--     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND Rama.Rama = @CtaPasivo

-- select @CtaActivoD, @CtaPasivoD, @CtaPasivoA

	DECLARE crContReexMonetarios CURSOR FOR
	SELECT 'Tipo' = 'Activo', a.Periodo, 'Saldo' =  SUM(ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))
	  FROM Cta c, Acum a
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio
	   AND a.Periodo <= @Periodo
	   AND a.Moneda = @Moneda
	   AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   AND c.EsAcumulativa = 0
-- 	   AND AjusteInflacionario = 0
	   AND ISNULL(c.Categoria,'') <> 'No Monetario'
	GROUP BY a.Periodo
	UNION
	SELECT 'Tipo' = 'Pasivo', a.Periodo, 'Saldo' = SUM(ISNULL(a.Abonos,0)-ISNULL(a.Cargos,0))
	  FROM Cta c, Acum a
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Periodo <= @Periodo
	   AND a.Ejercicio = @Ejercicio
	   AND a.Moneda = @Moneda
	   AND c.Cuenta >= @CtaPasivoD AND c.Cuenta <= @CtaPasivoA
	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	GROUP BY a.Periodo

OPEN crContReexMonetarios
FETCH NEXT FROM crContReexMonetarios INTO @Tipo, @Mes, @Saldo
	WHILE @@FETCH_STATUS = 0
		BEGIN

			IF @Tipo = 'Activo'
			BEGIN
				UPDATE #ContReexMonetarios SET Activo = ISNULL(Activo,0) + @Saldo WHERE Periodo = @Mes

				IF @@ROWCOUNT = 0
	
				INSERT INTO #ContReexMonetarios (Periodo, Activo) VALUES(@Mes, @Saldo)
			END
			ELSE
			BEGIN
				UPDATE #ContReexMonetarios SET Pasivo = ISNULL(Pasivo,0) + @Saldo WHERE Periodo = @Mes

				IF @@ROWCOUNT = 0
	
				INSERT INTO #ContReexMonetarios (Periodo, Pasivo) VALUES(@Mes, @Saldo)
			END

			FETCH NEXT FROM crContReexMonetarios INTO @Tipo, @Mes, @Saldo
		END
	CLOSE crContReexMonetarios
	DEALLOCATE crContReexMonetarios

SELECT c.*, t.Importe --Tipo, 'S1' = ISNULL(S1,0), 'S2' = ISNULL(S2,0), 'S3' = ISNULL(S3,0), 'S4' = ISNULL(S4,0), 'S5' = ISNULL(S5,0), 'S6' = ISNULL(S6,0), 'S7' = ISNULL(S7,0), 'S8' = ISNULL(S8,0), 'S9' = ISNULL(S9,0), 'S10' = ISNULL(S10,0), 'S11' = ISNULL(S11,0), 'S12' = ISNULL(S12,0)
FROM #ContReexMonetarios c
LEFT OUTER JOIN TablaAnualD t ON c.Periodo = t.Periodo AND t.Ejercicio = @Ejercicio AND t.TablaAnual = (SELECT ContTablaINPC FROM EmpresaCfg WHERE Empresa = @Empresa)
RETURN
END
GO

-- spVerContReexResultados 'viana', 2003, NULL

/**************** spVerContReexResultados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContReexResultados') and type = 'P') drop procedure dbo.spVerContReexResultados
GO
CREATE PROCEDURE spVerContReexResultados
		    @Empresa		char(5),
		    @Ejercicio		int,
/* 		    @ConMovs		char(20) = 'NO',*/
                    @CentroCostos	char(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Moneda		char(10),
    @CtaResultados	char(20),
    @CtaIngresos	char(20),
    @CtaCostoDirecto	char(20),
    @Saldo               money,
    @SaldoAlEne         money,
    @SaldoAlFeb         money,
    @SaldoAlMar         money,
    @SaldoAlAbr         money,
    @SaldoAlMay         money,
    @SaldoAlJun         money,
    @SaldoAlJul         money,
    @SaldoAlAgo         money,
    @SaldoAlSep         money,
    @SaldoAlOct         money,
    @SaldoAlNov         money,
    @SaldoAlDic         money
/*    @Ingresos		money,
    @IngresosAlEne 	money,
    @IngresosAlFeb 	money,
    @IngresosAlMar 	money,
    @IngresosAlAbr 	money,
    @IngresosAlMay 	money,
    @IngresosAlJun 	money,
    @IngresosAlJul 	money,
    @IngresosAlAgo 	money,
    @IngresosAlSep 	money,
    @IngresosAlOct 	money,
    @IngresosAlNov 	money,
    @IngresosAlDic 	money,
    @PorcentajeAlEne    money,
    @PorcentajeAlFeb    money,
    @PorcentajeAlMar    money,
    @PorcentajeAlAbr    money,
    @PorcentajeAlMay    money,
    @PorcentajeAlJun    money,
    @PorcentajeAlJul    money,
    @PorcentajeAlAgo    money,
    @PorcentajeAlSep    money,
    @PorcentajeAlOct    money,
    @PorcentajeAlNov    money,
    @PorcentajeAlDic    money*/
 
SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     ID			int		IDENTITY(1,1) NOT NULL,
     Clase		char(20)	COLLATE Database_Default NULL,
     SubClase		char(20)	COLLATE Database_Default NULL,
     Rama		char(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		char(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,
     Saldo		money		NULL,
     SaldoAlEne		money		NULL,
     SaldoAlFeb		money		NULL,
     SaldoAlMar		money		NULL,
     SaldoAlAbr		money		NULL,
     SaldoAlMay		money		NULL,
     SaldoAlJun		money		NULL,
     SaldoAlJul		money		NULL,
     SaldoAlAgo		money		NULL,
     SaldoAlSep		money		NULL,
     SaldoAlOct 	money		NULL,
     SaldoAlNov		money		NULL,
     SaldoAlDic		money		NULL,
/*     Ingresos		money		NULL,
     IngresosAlEne	money		NULL,
     IngresosAlFeb	money		NULL,
     IngresosAlMar	money		NULL,
     IngresosAlAbr	money		NULL,
     IngresosAlMay	money		NULL,
     IngresosAlJun	money		NULL,
     IngresosAlJul	money		NULL,
     IngresosAlAgo	money		NULL,
     IngresosAlSep	money		NULL,
     IngresosAlOct	money		NULL,
     IngresosAlNov	money		NULL,
     IngresosAlDic	money		NULL,
     Porcentaje		float		NULL,
     PorcentajeAlEne	float		NULL,
     PorcentajeAlFeb	float		NULL,
     PorcentajeAlMar	float		NULL,
     PorcentajeAlAbr	float		NULL,
     PorcentajeAlMay	float		NULL,
     PorcentajeAlJun	float		NULL,
     PorcentajeAlJul	float		NULL,
     PorcentajeAlAgo	float		NULL,
     PorcentajeAlSep	float		NULL,
     PorcentajeAlOct	float		NULL,
     PorcentajeAlNov	float		NULL,
     PorcentajeAlDic	float		NULL
*/
     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)') SELECT @CentroCostos = NULL
--   IF UPPER(@Empresa) 	   IN ('0', 'NULL', '(TODOS)','') SELECT @Empresa = NULL
--   IF UPPER(@Controladora) IN ('0', 'NULL', '(TODOS)','') SELECT @Controladora = NULL
--   EXEC spContEmpresaGrupo @Empresa OUTPUT, @Controladora OUTPUT

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto
     FROM EmpresaCfg a
     JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)


  -- Ventas
  INSERT #ResultadoAnual
  SELECT "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL/*,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL*/
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #ResultadoAnual
  SELECT "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL/*,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL*/
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)

  -- Otros
  INSERT #ResultadoAnual
  SELECT "Utilidad Neta",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL/*,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL*/
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)

/*  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
--       AND Periodo BETWEEN @PeriodoD AND @PeriodoA
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
--       AND Periodo BETWEEN @PeriodoD AND @PeriodoA

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 1
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 1

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 2
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 2

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 3
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 3

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 4
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 4

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 5
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 5

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 6
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 6

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 7
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 7

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 8
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 8

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 9
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 9

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 10
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 10

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 11
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 11

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 12
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
      JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo = 12
*/
  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
       JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
       JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)-- AND e.Controladora = ISNULL(@Controladora, e.Controladora)
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
       AND Periodo BETWEEN 1 AND 12
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b

  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo
--             Ingresos = @Ingresos
--             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 1),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 2),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 3),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 4),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 5),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 6),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 7),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 8),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 9),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 10),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 11),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa)/* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Ejercicio = @Ejercicio AND a.Periodo = 12)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 1),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 2),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 3),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 4),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 5),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 6),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 7),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 8),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 9),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 10),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 11),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) /* AND e.Controladora = ISNULL(@Controladora, e.Controladora) */WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos  AND a.Ejercicio = @Ejercicio AND a.Periodo = 12)
        FROM #ResultadoAnual b

  OPEN crResultadoAl
  FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual 
         SET SaldoAlEne = @SaldoAlEne,
             SaldoAlFeb = @SaldoAlFeb,
             SaldoAlMar = @SaldoAlMar,
             SaldoAlAbr = @SaldoAlAbr,
             SaldoAlMay = @SaldoAlMay,
             SaldoAlJun = @SaldoAlJun,
             SaldoAlJul = @SaldoAlJul,
             SaldoAlAgo = @SaldoAlAgo,
             SaldoAlSep = @SaldoAlSep,
             SaldoAlOct = @SaldoAlOct,
             SaldoAlNov = @SaldoAlNov,
             SaldoAlDic = @SaldoAlDic/*,
	     IngresosAlEne = @IngresosAlEne,
	     IngresosAlFeb = @IngresosAlFeb,
	     IngresosAlMar = @IngresosAlMar,
	     IngresosAlAbr = @IngresosAlAbr,
	     IngresosAlMay = @IngresosAlMay,
	     IngresosAlJun = @IngresosAlJun,
	     IngresosAlJul = @IngresosAlJul,
	     IngresosAlAgo = @IngresosAlAgo,
	     IngresosAlSep = @IngresosAlSep,
	     IngresosAlOct = @IngresosAlOct,
	     IngresosAlNov = @IngresosAlNov,
	     IngresosAlDic = @IngresosAlDic
             PorcentajeAlEne = (@SaldoAlEne/@IngresosAlEne)*100,
             PorcentajeAlFeb = (@SaldoAlFeb/@IngresosAlFeb)*100,
             PorcentajeAlMar = (@SaldoAlMar/@IngresosAlMar)*100,
             PorcentajeAlAbr = (@SaldoAlAbr/@IngresosAlAbr)*100,
             PorcentajeAlMay = (@SaldoAlMay/@IngresosAlMay)*100,
             PorcentajeAlJun = (@SaldoAlJun/@IngresosAlJun)*100,
             PorcentajeAlJul = (@SaldoAlJul/@IngresosAlJul)*100,
             PorcentajeAlAgo = (@SaldoAlAgo/@IngresosAlAgo)*100,
             PorcentajeAlSep = (@SaldoAlSep/@IngresosAlSep)*100,
             PorcentajeAlOct = (@SaldoAlOct/@IngresosAlOct)*100,
             PorcentajeAlNov = (@SaldoAlNov/@IngresosAlNov)*100,
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100*/
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT 'Orden' = 1, r.*
      FROM #ResultadoAnual r
     UNION
    SELECT 'Orden' = 2, r.*
      FROM #ResultadoAnual r
     ORDER BY Orden, Clase, Rama, Cuenta


END
GO


