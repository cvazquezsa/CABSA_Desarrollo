/* SP VISTAS CONTABILIDAD */

/**************** spContEmpresaGrupo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spContEmpresaGrupo') and type = 'P') drop procedure dbo.spContEmpresaGrupo
GO   
CREATE PROCEDURE spContEmpresaGrupo   
   @Empresa        varchar(5) = NULL OUTPUT,  
   @Controladora   varchar(5) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN  
SELECT @Empresa = NULLIF(NULLIF(RTRIM(@Empresa), ''), '0')  
SELECT @Controladora = NULLIF(NULLIF(RTRIM(@Controladora), ''), '0')  
IF @Controladora IS NOT NULL SELECT @Empresa = NULL  
 RETURN    
END  
GO

-- EXEC spVerContBalanza 'DEMO',  2002,  1,  2,  'No',  'Mayor',  '100-00-000',  '500-00-000',  '(Todos)', '(Todos)', '(Todos)', '(Todos)'


/**************** spVerContBalanzaTotal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanzaTotal') and type = 'P') drop procedure dbo.spVerContBalanzaTotal
go
CREATE PROCEDURE spVerContBalanzaTotal
	@Empresa		varchar(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@CuentaD		varchar(20) = NULL,
	@CuentaA		varchar(20) = NULL,
	@CentroCostos		varchar(50) = NULL,
	@Categoria		varchar(50) = NULL,
	@Grupo			varchar(50) = NULL,
	@Familia		varchar(50) = NULL,
	@Sucursal		int         = NULL,
	@Moneda			varchar(10) = NULL,
	@Controladora		varchar(5)  = NULL,
	@UEN			int	    = NULL,
	@Proyecto		varchar(50) = NULL,
	@CentroCostos2		varchar(50) = NULL,
	@CentroCostos3		varchar(50) = NULL
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @SaldoInicial 	money,
  @Cargos		money,
  @Abonos		money

IF UPPER(@CentroCostos)  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos = NULL
IF UPPER(@Categoria)     IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Categoria = NULL
IF UPPER(@Grupo) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Grupo = NULL
IF UPPER(@Familia) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Familia = NULL
IF UPPER(@Empresa) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Empresa = NULL
IF UPPER(@Proyecto)  	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

IF @UEN = 0 SELECT @UEN = NULL
IF @Sucursal<0 SELECT @Sucursal = NULL

SELECT @SaldoInicial = SUM(a.Cargos)-SUM(a.Abonos)
  FROM Acum a, Cta c 
 WHERE a.Cuenta = c.Cuenta 
   AND a.Rama = 'CONT'
   AND a.Ejercicio = @Ejercicio
   AND a.Periodo BETWEEN 0 AND @PeriodoD-1
   AND c.Tipo = 'Mayor'
   AND a.Cuenta BETWEEN @CuentaD AND @CuentaA
   AND a.Moneda = @Moneda
   AND a.Empresa = @Empresa
   AND ISNULL(a.Sucursal, 0)   = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
   AND ISNULL(c.Categoria, '') = ISNULL(ISNULL(@Categoria, c.Categoria) , '')
   AND ISNULL(c.Grupo, '')     = ISNULL(ISNULL(@Grupo, c.Grupo) , '')
   AND ISNULL(c.Familia, '')   = ISNULL(ISNULL(@Familia, c.Familia) , '')
   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
   AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')

SELECT @Cargos = SUM(a.Cargos),
       @Abonos = SUM(a.Abonos)
  FROM Acum a, Cta c
 WHERE a.Cuenta = c.Cuenta
   AND a.Rama = 'CONT'
   AND a.Ejercicio = @Ejercicio
   AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
   AND c.Tipo = 'Mayor'
   AND a.Cuenta BETWEEN @CuentaD AND @CuentaA
   AND a.Moneda = @Moneda
   AND a.Empresa = @Empresa
   AND ISNULL(a.Sucursal, 0)   = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
   AND ISNULL(c.Categoria, '') = ISNULL(ISNULL(@Categoria, c.Categoria) , '')
   AND ISNULL(c.Grupo, '')     = ISNULL(ISNULL(@Grupo, c.Grupo) , '')
   AND ISNULL(c.Familia, '')   = ISNULL(ISNULL(@Familia, c.Familia) , '')
   AND ISNULL(a.UEN, 0)        = ISNULL(ISNULL(@UEN, a.UEN), 0)
   AND ISNULL(a.Proyecto, '')  = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
   AND ISNULL(a.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a.SubCuenta), '')
   AND ISNULL(a.SubCuenta2, '')= ISNULL(ISNULL(@CentroCostos2, a.SubCuenta2), '')
   AND ISNULL(a.SubCuenta3, '')= ISNULL(ISNULL(@CentroCostos3, a.SubCuenta3), '')

SELECT "SaldoInicial" = @SaldoInicial, "Cargos" = @Cargos, "Abonos" = @Abonos
RETURN
END
GO

/**************** spVerContBalanza ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanza') and type = 'P') drop procedure dbo.spVerContBalanza
go
CREATE PROCEDURE spVerContBalanza
	@Empresa		varchar(5),
	@Ejercicio		int,
	@PeriodoD		int,
	@PeriodoA		int,
	@ConMovs		varchar(20) = 'NO',
	@Tipo			varchar(20) = 'MAYOR',
	@CuentaD		varchar(20) = NULL,
	@CuentaA		varchar(20) = NULL,
	@CentroCostos		varchar(20) = NULL,
	@Categoria		varchar(50) = NULL,
	@Grupo			varchar(50) = NULL,
	@Familia		varchar(50) = NULL,
	@Sucursal		int 	    = NULL,
        @Moneda			varchar(10) = NULL,
	@Controladora		varchar(5)  = NULL,
	@UEN			int	    = NULL,
	@Proyecto		varchar(50) = NULL,
	@CentroCostos2		varchar(50) = NULL,
	@CentroCostos3		varchar(50) = NULL,
	@ReExpresar     char(20) = 'NO', --REQ2162
	@ReExpresarTipoCambio float = NULL --REQ2162
--//WITH ENCRYPTION
AS BEGIN
DECLARE
  @Rama   		varchar(5),
  @CuentaRangoD		varchar(20),
  @CuentaRangoA		varchar(20),
  @Tipos  		varchar(100),
  @Inicio 		money

SELECT @Rama = 'CONT',
       @Tipo = NULLIF(RTRIM(UPPER(@Tipo)), '')
SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
IF UPPER(@CentroCostos)  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos = NULL
IF UPPER(@Categoria)     IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Categoria = NULL
IF UPPER(@Grupo) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Grupo = NULL
IF UPPER(@Familia) 	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Familia = NULL
IF UPPER(@Proyecto)  	 IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

IF @UEN = 0 SELECT @UEN = NULL
IF @Sucursal <0 SELECT @Sucursal = NULL

SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

CREATE TABLE #VerContBalanza(
	Cuenta		varchar(20)	COLLATE Database_Default NULL,
	Descripcion	varchar(100)	COLLATE Database_Default NULL,
	Tipo		varchar(15)	COLLATE Database_Default NULL,
	Categoria	varchar(50)	COLLATE Database_Default NULL,
	Grupo		varchar(50)	COLLATE Database_Default NULL,
	Familia		varchar(50)	COLLATE Database_Default NULL,
	EsAcumulativa	bit		NULL,
	EsAcreedora	bit		NULL,
	Inicio		money		NULL,
	Cargos		money		NULL,
	Abonos		money		NULL)
IF @ConMovs='NO'
BEGIN
  IF @Tipo = 'MAYOR'
  BEGIN
    INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
    SELECT aa.Cuenta,
           aa.Descripcion,
           aa.Tipo,
           aa.Categoria,
           aa.Grupo,
           aa.Familia,
           "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
           "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
           "Inicio" = ( 
                       SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                         FROM Cta ab
                         LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta
                          AND a2.Empresa = @Empresa
                          AND a2.Rama = @Rama
                          AND a2.Ejercicio = @Ejercicio
                          AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                          AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                          AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                          AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                          AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                          AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                          AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                          AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                          AND a2.Moneda = @Moneda
                        WHERE UPPER(ab.Tipo) = @Tipo
                          AND aa.Cuenta = ab.Cuenta
                       ),
           "Cargos" = Sum(Acum.Cargos),
           "Abonos" = Sum(Acum.Abonos)
      FROM Cta aa
      LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta
       AND Acum.Empresa = @Empresa
       AND Acum.Rama = @Rama
       AND Acum.Ejercicio = @Ejercicio
       AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
       AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
       AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
       AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
       AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
       AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
       AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
       AND Acum.Moneda = @Moneda
     WHERE UPPER(aa.Tipo) = @Tipo
       AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
     GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
     ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  END
  ELSE
  IF @Tipo = 'SUBCUENTA'
  BEGIN
    INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
    SELECT aa.Cuenta,
           aa.Descripcion,
           aa.Tipo,
           aa.Categoria,
           aa.Grupo,
           aa.Familia,
           "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
           "EsAcreedora" = Convert(varchar,aa.EsAcreedora), 
           "Inicio" = (
                       SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                         FROM Cta ab
                         LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta
                          AND a2.Empresa = @Empresa
                          AND a2.Rama = @Rama
                          AND a2.Ejercicio = @Ejercicio
                          AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                          AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                          AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                          AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                          AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                          AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                          AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                          AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                          AND a2.Moneda = @Moneda
                        WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA')
                          AND aa.Cuenta = ab.Cuenta
                      ),
           "Cargos" = Sum(Acum.Cargos),
           "Abonos" = Sum(Acum.Abonos)
      FROM Cta aa
      LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta  
       AND Acum.Empresa = @Empresa
       AND Acum.Rama = @Rama
       AND Acum.Ejercicio = @Ejercicio
       AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
       AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
       AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
       AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
       AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
       AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
       AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
       AND Acum.Moneda = @Moneda
     WHERE UPPER(aa.Tipo) IN ('MAYOR', 'SUBCUENTA')
       AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
     GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
     ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  END
  ELSE
  IF @Tipo = 'AUXILIAR'
  BEGIN
    INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
    SELECT aa.Cuenta,
           aa.Descripcion,
           aa.Tipo,
           aa.Categoria,
           aa.Grupo,
           aa.Familia,
           "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
           "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
           "Inicio" = (
                       SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                         FROM Cta ab
                         LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta 
                          AND a2.Empresa = @Empresa
                          AND a2.Rama = @Rama
                          AND a2.Ejercicio = @Ejercicio
                          AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                          AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                          AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                          AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                          AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                          AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                          AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                          AND a2.Moneda = @Moneda
                          AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                        WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR')
                          AND aa.Cuenta = ab.Cuenta
                      ),
           "Cargos" = Sum(Acum.Cargos),
           "Abonos" = Sum(Acum.Abonos)
      FROM Cta aa
      LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta 
       AND Acum.Empresa = @Empresa
       AND Acum.Rama = @Rama
       AND Acum.Ejercicio = @Ejercicio
       AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
       AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
       AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
       AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
       AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
       AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
       AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
       AND Acum.Moneda = @Moneda
     WHERE UPPER(aa.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR')
       AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
     GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
     ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  END
END
ELSE
IF @Tipo = 'MAYOR'
BEGIN
  INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
  SELECT aa.Cuenta,
         aa.Descripcion,
         aa.Tipo,
         aa.Categoria,
         aa.Grupo,
         aa.Familia,
         "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
         "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
         "Inicio" = (
                     SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                       FROM Cta ab
                       LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta 
                        AND a2.Empresa = @Empresa
                        AND a2.Rama = @Rama
                        AND a2.Ejercicio = @Ejercicio
                        AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                        AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                        AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                        AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                        AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                        AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                        AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                        AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                        AND a2.Moneda = @Moneda
                      WHERE UPPER(ab.Tipo) = @Tipo
                        AND aa.Cuenta = ab.Cuenta
                    ),
         "Cargos" = Sum(Acum.Cargos),
         "Abonos" = Sum(Acum.Abonos)
    FROM Cta aa
    LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta 
     AND Acum.Empresa = @Empresa
     AND Acum.Rama = @Rama
     AND Acum.Ejercicio = @Ejercicio
     AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
     AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
     AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
     AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
     AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
     AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
     AND Acum.Moneda = @Moneda
   WHERE UPPER(aa.Tipo) = @Tipo
     AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
   GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  HAVING ( Sum(ISNULL(Acum.Cargos,0.0))<>0.0 OR Sum(ISNULL(Acum.Abonos,0.0))<>0.0 OR
 (SELECT SUM(ISNULL(a2.Cargos,0.0))-SUM(ISNULL(a2.Abonos,0.0)) FROM Cta ab LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta AND a2.Empresa = @Empresa AND a2.Rama = @Rama AND a2.Ejercicio = @Ejercicio AND a2.Periodo BETWEEN 0 AND @PeriodoD-1 AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA WHERE UPPER(ab.Tipo) = @Tipo AND aa.Cuenta = ab.Cuenta) <> 0.0)
   ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
END
ELSE
IF @Tipo = 'SUBCUENTA'
BEGIN
  INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
  SELECT aa.Cuenta,
         aa.Descripcion,
         aa.Tipo,
         aa.Categoria,
         aa.Grupo,
         aa.Familia,
         "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
         "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
         "Inicio" = (
                     SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                       FROM Cta ab
                       LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta 
                        AND a2.Empresa = @Empresa
                        AND a2.Rama = @Rama
                        AND a2.Ejercicio = @Ejercicio
                        AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                        AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                        AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                        AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                        AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                        AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                        AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                        AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                        AND a2.Moneda = @Moneda
                      WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA')
                        AND aa.Cuenta = ab.Cuenta
                    ),
         "Cargos" = Sum(Acum.Cargos),
         "Abonos" = Sum(Acum.Abonos)
    FROM Cta aa
    LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta 
     AND Acum.Empresa = @Empresa
     AND Acum.Rama = @Rama
     AND Acum.Ejercicio = @Ejercicio
     AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
     AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
     AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
     AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
     AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
     AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
     AND Acum.Moneda = @Moneda
   WHERE UPPER(aa.Tipo) IN ('MAYOR', 'SUBCUENTA')
     AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
   GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  HAVING ( Sum(ISNULL(Acum.Cargos,0.0))<>0.0 OR Sum(ISNULL(Acum.Abonos,0.0))<>0.0 OR
 (SELECT SUM(ISNULL(a2.Cargos,0.0))-SUM(ISNULL(a2.Abonos,0.0)) FROM Cta ab LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta AND a2.Empresa = @Empresa AND a2.Rama = @Rama AND a2.Ejercicio = @Ejercicio AND a2.Periodo BETWEEN 0 AND @PeriodoD-1 AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA') AND aa.Cuenta = ab.Cuenta) <> 0.0)
   ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
END
ELSE
IF @Tipo = 'AUXILIAR'
BEGIN
  INSERT #VerContBalanza (Cuenta, Descripcion, Tipo, Categoria, Grupo, Familia, EsAcumulativa, EsAcreedora, Inicio, Cargos, Abonos)
  SELECT aa.Cuenta,
         aa.Descripcion,
         aa.Tipo,
         aa.Categoria,
         aa.Grupo,
         aa.Familia,
         "EsAcumulativa" = Convert(varchar,aa.EsAcumulativa),
         "EsAcreedora" = Convert(varchar,aa.EsAcreedora),
         "Inicio" = (
                     SELECT SUM(a2.Cargos)-SUM(a2.Abonos)
                       FROM Cta ab
                       LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta 
                        AND a2.Empresa = @Empresa
                        AND a2.Rama = @Rama
                        AND a2.Ejercicio = @Ejercicio
                        AND a2.Periodo BETWEEN 0 AND @PeriodoD-1
                        AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
                        AND ISNULL(a2.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a2.Sucursal), 0)
                        AND ISNULL(a2.UEN, 0) = ISNULL(ISNULL(@UEN, a2.UEN), 0)
                        AND ISNULL(a2.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a2.Proyecto), '')
                        AND ISNULL(a2.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, a2.SubCuenta), '')
                        AND ISNULL(a2.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, a2.SubCuenta2), '')
                        AND ISNULL(a2.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, a2.SubCuenta3), '')
                        AND a2.Moneda = @Moneda
                      WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR')
                        AND aa.Cuenta = ab.Cuenta
                    ),
         "Cargos" = Sum(Acum.Cargos),
         "Abonos" = Sum(Acum.Abonos)
    FROM Cta aa
    LEFT OUTER JOIN Acum ON aa.Cuenta = Acum.Cuenta 
     AND Acum.Empresa = @Empresa
     AND Acum.Rama = @Rama
     AND Acum.Ejercicio = @Ejercicio
     AND Acum.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND ISNULL(Acum.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, Acum.Sucursal), 0)
     AND ISNULL(Acum.UEN, 0) = ISNULL(ISNULL(@UEN, Acum.UEN), 0)
     AND ISNULL(Acum.Proyecto, '') = ISNULL(ISNULL(@Proyecto, Acum.Proyecto), '')
     AND ISNULL(Acum.SubCuenta, '') = ISNULL(ISNULL(@CentroCostos, Acum.SubCuenta), '')
     AND ISNULL(Acum.SubCuenta2, '') = ISNULL(ISNULL(@CentroCostos2, Acum.SubCuenta2), '')
     AND ISNULL(Acum.SubCuenta3, '') = ISNULL(ISNULL(@CentroCostos3, Acum.SubCuenta3), '')
     AND Acum.Moneda = @Moneda
   WHERE UPPER(aa.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR')
     AND aa.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
   GROUP BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
  HAVING ( Sum(ISNULL(Acum.Cargos,0.0))<>0.0 OR Sum(ISNULL(Acum.Abonos,0.0))<>0.0 OR
 (SELECT SUM(ISNULL(a2.Cargos,0.0))-SUM(ISNULL(a2.Abonos,0.0)) FROM Cta ab LEFT OUTER JOIN Acum a2 ON ab.Cuenta = a2.Cuenta AND a2.Empresa = @Empresa AND a2.Rama = @Rama AND a2.Ejercicio = @Ejercicio AND a2.Periodo BETWEEN 0 AND @PeriodoD-1 AND a2.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA WHERE UPPER(ab.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') AND aa.Cuenta = ab.Cuenta) <> 0.0)
   ORDER BY aa.Cuenta, aa.Descripcion, aa.Tipo, aa.Categoria, aa.Grupo, aa.Familia, Convert(varchar,aa.EsAcumulativa), Convert(varchar,aa.EsAcreedora)
END

--REQ2162
IF @ReExpresar='Si'
  UPDATE #VerContBalanza
  SET Inicio=Inicio/ISNULL(@ReExpresarTipoCambio,1), Cargos=Cargos/ISNULL(@ReExpresarTipoCambio,1), Abonos=Abonos/ISNULL(@ReExpresarTipoCambio,1)

SELECT Cuenta,
       Descripcion,
       Tipo,
       EsAcumulativa,
       EsAcreedora,
       Inicio,
       Cargos,
       Abonos
  FROM #VerContBalanza
 WHERE ISNULL(Categoria, '') = ISNULL(ISNULL(@Categoria, Categoria) , '')
   AND ISNULL(Grupo, '')     = ISNULL(ISNULL(@Grupo, Grupo) , '')
   AND ISNULL(Familia, '')   = ISNULL(ISNULL(@Familia, Familia) , '')

END
GO

/**************** spVerContBalance ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalance') and type = 'P') drop procedure dbo.spVerContBalance
GO             
CREATE PROCEDURE spVerContBalance
		    @Empresa		varchar(5),
		    @Ejercicio		int,
		    @PeriodoA		int,
		    @ConMovs		varchar(20) = 'NO',
                    @Reporte		varchar(2)  = 'SI',
                    @CentroCostos	varchar(20) = NULL,
		    @Sucursal		int	    = NULL,
		    @Moneda		varchar(10) = NULL,
		    @Controladora	varchar(5)  = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL,
		    @AlCentroCostos	varchar(20) = NULL,
		    @AlCentroCostos2	varchar(20) = NULL,
		    @AlCentroCostos3	varchar(20) = NULL
--//WITH ENCRYPTION
AS BEGIN
  SET nocount ON
  DECLARE 
    @ID			int,
    @Lado		int,
    @UltLado		int,
    @Renglon		int,
    @UltRenglon		int,
    @UltRama		varchar(20),
    @UltRama1		varchar(20),
    @UltRama2		varchar(20),
    @LadoDesc		varchar(100), 
    @UltLadoDesc	varchar(100), 
    @Rama		varchar(20), 
    @RamaDesc		varchar(100), 
    @Cuenta		varchar(20), 
    @Descripcion	varchar(100), 
    @EsAcreedora	bit, 
    @EsTitulo		bit,
    @EsFinRama		bit,
    @EsFinLado		bit,
    @Saldo    		money,
    @CtaActivo		varchar(20),
    @CtaPasivo		varchar(20),
    @CtaCapital		varchar(20),
    @CtaResultados	varchar(20),
    @ContMoneda		varchar(10)

  CREATE TABLE #Balance(
     ID			int		IDENTITY(1,1) NOT NULL,

     Renglon 		int		NULL,

     EsTitulo		bit		NOT NULL DEFAULT 0,
     EsFinRama		bit		NOT NULL DEFAULT 0,
     EsFinLado		bit		NOT NULL DEFAULT 0,
     Lado		int		NULL,
     LadoDesc		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,
     Saldo		money		NULL,

     CONSTRAINT priTempBalance PRIMARY KEY CLUSTERED (ID)
  )

  CREATE TABLE #VerBalance(
     Renglon 		int		NULL,
     Lado		int		NULL,

     EsTitulo1		bit		NOT NULL DEFAULT 0,
     EsFinRama1		bit		NOT NULL DEFAULT 0,
     EsFinLado1		bit		NOT NULL DEFAULT 0,
     LadoDesc1		varchar(20)	COLLATE Database_Default NULL,
     Rama1		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc1		varchar(100)	COLLATE Database_Default NULL,
     Cuenta1		varchar(20)	COLLATE Database_Default NULL,
     Descripcion1	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora1	bit		NOT NULL DEFAULT 0,
     Saldo1		money		NULL,

     EsTitulo2		bit		NOT NULL DEFAULT 0,
     EsFinRama2		bit		NOT NULL DEFAULT 0,
     EsFinLado2		bit		NOT NULL DEFAULT 0,
     LadoDesc2		varchar(20)	COLLATE Database_Default NULL,
     Rama2		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc2		varchar(100)	COLLATE Database_Default NULL,
     Cuenta2		varchar(20)	COLLATE Database_Default NULL,
     Descripcion2	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora2	bit		NOT NULL DEFAULT 0,
     Saldo2		money		NULL
  )

   SELECT @ConMovs = UPPER(@ConMovs), @Reporte = UPPER(@Reporte), @CentroCostos = NULLIF(RTRIM(@CentroCostos), ''), @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
   IF @Sucursal <0 SELECT @Sucursal = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)        IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos)    IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos = NULL
   IF UPPER(@CentroCostos2)   IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3)   IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL
   IF UPPER(@AlCentroCostos)  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos = NULL
   IF UPPER(@AlCentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos2 = NULL
   IF UPPER(@AlCentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos3 = NULL
   SELECT @AlCentroCostos  = ISNULL(@AlCentroCostos, @CentroCostos),
          @AlCentroCostos2 = ISNULL(@AlCentroCostos2, @CentroCostos2),
          @AlCentroCostos3 = ISNULL(@AlCentroCostos3, @CentroCostos3)

   SELECT @CtaActivo	  = CtaActivo,
     	  @CtaPasivo	  = CtaPasivo,
    	  @CtaCapital	  = CtaCapital,
          @CtaResultados  = CtaResultados,
          @ContMoneda	  = ContMoneda
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

   IF @Moneda IS NULL SELECT @Moneda = @ContMoneda
 
  -- Activo
  INSERT #Balance
  SELECT 0,0,0,0,1,
         'Activo',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL
    FROM Cta, Cta E1, Cta E2
   WHERE Cta.Rama   = E2.Cuenta
     AND E2.Rama    = E1.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaActivo OR E1.Rama = @CtaActivo OR E2.Rama = @CtaActivo)
   ORDER BY Cta.Cuenta

  -- Pasivo
  INSERT #Balance
  SELECT 0,0,0,0,2,
         'Pasivo',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL
    FROM Cta, Cta E1, Cta E2
   WHERE Cta.Rama   = E2.Cuenta
     AND E2.Rama    = E1.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaPasivo OR E1.Rama = @CtaPasivo OR E2.Rama = @CtaPasivo)
   ORDER BY Cta.Cuenta

  -- Capital
  INSERT #Balance
  SELECT 0,0,0,0,2,
         'Capital',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL
    FROM Cta, Cta E1, Cta E2
   WHERE Cta.Rama   = E2.Cuenta
     AND E2.Rama    = E1.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCapital OR E1.Rama = @CtaCapital OR E2.Rama = @CtaCapital)
   ORDER BY Cta.Cuenta

  -- Resultados
  INSERT #Balance
  SELECT 0,0,0,0,2,
         'Capital',
         E2.Cuenta,
         E2.Descripcion,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL
    FROM Cta, Cta E2
   WHERE E2.Cuenta = @CtaCapital
     AND Cta.Cuenta = @CtaResultados
   ORDER BY Cta.Cuenta

  SELECT @UltLado = NULL, @UltRama = NULL, @UltLadoDesc = NULL

  DECLARE crBalance CURSOR FOR
   SELECT ID, Lado, LadoDesc, Rama, RamaDesc, EsTitulo, Cuenta
     FROM #Balance b
  OPEN crBalance
  FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Cuenta
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @EsTitulo = 0
    BEGIN
      SELECT @Saldo = NULL
      SELECT @Saldo = SUM(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
        FROM Acum a
       WHERE a.Empresa = @Empresa
         AND a.Rama = 'CONT'
         AND a.Cuenta = @Cuenta 
         AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
         AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
         AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
         AND (@CentroCostos  IS NULL OR a.SubCuenta  BETWEEN @CentroCostos  AND @AlCentroCostos)
         AND (@CentroCostos2 IS NULL OR a.SubCuenta2 BETWEEN @CentroCostos2 AND @AlCentroCostos2)
         AND (@CentroCostos2 IS NULL OR a.SubCuenta3 BETWEEN @CentroCostos3 AND @AlCentroCostos3)
         AND a.Moneda = @Moneda
         AND a.Ejercicio = @Ejercicio 
         AND a.Periodo BETWEEN 0 AND @PeriodoA
       
      IF ISNULL(@Saldo, 0.0) = 0.0 AND @ConMovs = 'SI'
        DELETE FROM #Balance WHERE ID = @ID
      ELSE 
      BEGIN
        IF @Rama <> @UltRama 
        BEGIN
          SELECT @Renglon = @Renglon + 1 
          INSERT #Balance (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
        END
        IF @UltLadoDesc<>@LadoDesc
        BEGIN
          SELECT @Renglon = @Renglon + 1 
          INSERT #Balance (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
        END
        IF @Lado <> @UltLado SELECT @Renglon = 1 ELSE SELECT @Renglon = @Renglon + 1
        IF @Rama <> @UltRama 
        BEGIN
          INSERT #Balance (EsTitulo, Renglon, Lado, Descripcion) VALUES (1, @Renglon, @Lado, @RamaDesc)
          SELECT @Renglon = @Renglon + 1 
        END
        UPDATE #Balance 
           SET Renglon = @Renglon,
               Saldo = @Saldo
         WHERE ID = @ID
        SELECT @UltLado = @Lado, @UltLadoDesc = @LadoDesc, @UltRama = @Rama
      END
    END
    FETCH NEXT FROM crBalance INTO @ID, @Lado, @LadoDesc, @Rama, @RamaDesc, @EsTitulo, @Cuenta
  END
  SELECT @Renglon = @Renglon + 1 
  INSERT #Balance (EsTitulo, EsFinRama, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
  SELECT @Renglon = @Renglon + 1 
  INSERT #Balance (EsTitulo, EsFinLado, Renglon, Lado) VALUES (1, 1, @Renglon, @UltLado)
  CLOSE crBalance
  DEALLOCATE crBalance

  SELECT @UltRenglon = NULL, @UltRama1 = NULL, @UltRama2 = NULL
  DECLARE crVerBalance CURSOR FOR
  SELECT EsTitulo, EsFinRama, EsFinLado, Renglon, Lado, LadoDesc, Rama, RamaDesc, Cuenta, Descripcion, EsAcreedora, Saldo 
    FROM #Balance ORDER BY Renglon, Lado, Rama
  OPEN crVerBalance
  FETCH NEXT FROM crVerBalance INTO @EsTitulo, @EsFinRama, @EsFinLado, @Renglon, @Lado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      IF @Lado = 1
      BEGIN
        IF @UltRenglon <> @Renglon OR @Reporte <> 'NO'
          INSERT #VerBalance (Renglon, Lado, EsTitulo1, EsFinRama1, EsFinLado1, LadoDesc1, Rama1, RamaDesc1, Cuenta1, Descripcion1, EsAcreedora1, Saldo1)
                      VALUES (@Renglon, @Lado, @EsTitulo, @EsFinRama, @EsFinLado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo)
        ELSE
          UPDATE #VerBalance  
             SET EsTitulo1 = @EsTitulo, EsFinRama1 = @EsFinRama, EsFinLado1 = @EsFinLado, LadoDesc1 = @LadoDesc, Rama1 = @Rama, RamaDesc1 = @RamaDesc, Cuenta1 = @Cuenta, Descripcion1 = @Descripcion, EsAcreedora1 = @EsAcreedora, Saldo1 = @Saldo
           WHERE Renglon = @Renglon       
      END ELSE BEGIN
        IF @UltRenglon <> @Renglon OR @Reporte <> 'NO'
          INSERT #VerBalance (Renglon, Lado, EsTitulo2, EsFinRama2, EsFinLado2, LadoDesc2, Rama2, RamaDesc2, Cuenta2, Descripcion2, EsAcreedora2, Saldo2)
                      VALUES (@Renglon, @Lado, @EsTitulo, @EsFinRama, @EsFinLado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo)
        ELSE
          UPDATE #VerBalance  
             SET EsTitulo2 = @EsTitulo, EsFinRama2 = @EsFinRama, EsFinLado2 = @EsFinLado, LadoDesc2 = @LadoDesc, Rama2 = @Rama, RamaDesc2 = @RamaDesc, Cuenta2 = @Cuenta, Descripcion2 = @Descripcion, EsAcreedora2 = @EsAcreedora, Saldo2 = @Saldo
           WHERE Renglon = @Renglon
      END
      SELECT @UltRenglon = @Renglon
    END
    FETCH NEXT FROM crVerBalance INTO @EsTitulo, @EsFinRama, @EsFinLado, @Renglon, @Lado, @LadoDesc, @Rama, @RamaDesc, @Cuenta, @Descripcion, @EsAcreedora, @Saldo
  END
  CLOSE crVerBalance
  DEALLOCATE crVerBalance

  IF @Reporte = 'NO'
    SELECT * FROM #VerBalance
  ELSE
    SELECT * FROM #VerBalance 
     WHERE Renglon IS NOT NULL 
     ORDER BY Lado
END
GO

-- spVerContResultados 'DEMO', 2002, 1, 12, 'SI', NULL, NULL, 'SI', 'Dolar', 'Dos'
/**************** spVerContResultados ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultados') and type = 'P') drop procedure dbo.spVerContResultados
GO
CREATE PROCEDURE spVerContResultados
		    @Empresa		varchar(5)  = NULL,
		    @Ejercicio		int,
		    @PeriodoD		int,
		    @PeriodoA		int,
		    @ConMovs		varchar(20) = 'NO',
                    @CentroCostos	varchar(50) = NULL,
		    @Sucursal		int	    = NULL,
		    @OrdenCC		varchar(20) = 'NO',
		    @Moneda		varchar(10) = NULL,
		    @CCGrupo		varchar(50) = NULL,
                    @Controladora	varchar(5)  = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL,
		    @AlCentroCostos	varchar(20) = NULL,
		    @AlCentroCostos2	varchar(20) = NULL,
		    @AlCentroCostos3	varchar(20) = NULL,
	        @ReExpresar     char(20) = 'NO', --REQ2162
	        @ReExpresarTipoCambio float = NULL --REQ2162
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID				int,
    @CtaResultados		varchar(20),
    @CtaIngresos		varchar(20),
    @CtaCostoDirecto		varchar(20),
    @CtaGastosOperacion		varchar(20),
    @CtaOtrosGastosProductos	varchar(20),
    @CtaImpuestos		varchar(20),
    @Saldo			money,
    @Ingresos			money,
    @IngresosAl			money

  SELECT @Moneda        = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0'),
         @CCGrupo       = NULLIF(NULLIF(RTRIM(@CCGrupo), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #Resultado (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,

     Clase		varchar(30)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,

     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,

     Cuenta		varchar(20)	COLLATE Database_Default NULL,
     Descripcion	varchar(100)	COLLATE Database_Default NULL,
     EsAcreedora	bit		NOT NULL DEFAULT 0,

     SubCuenta		varchar(20)	COLLATE Database_Default NULL,
     CentroCostos	varchar(100)	COLLATE Database_Default NULL,

     Saldo		money		NULL,
     Ingresos		money		NULL,
     Porcentaje		float		NULL,

     SaldoAl		money		NULL,
     IngresosAl		money		NULL,
     PorcentajeAl	float		NULL,

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (Orden, ID)
  )

   SELECT @ConMovs = UPPER(@ConMovs), @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF @Sucursal<0 SELECT @Sucursal = NULL

   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)        IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos)    IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos = NULL
   IF UPPER(@CentroCostos2)   IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3)   IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL
   IF UPPER(@AlCentroCostos)  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos = NULL
   IF UPPER(@AlCentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos2 = NULL
   IF UPPER(@AlCentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @AlCentroCostos3 = NULL
   SELECT @AlCentroCostos  = ISNULL(@AlCentroCostos, @CentroCostos),
          @AlCentroCostos2 = ISNULL(@AlCentroCostos2, @CentroCostos2),
          @AlCentroCostos3 = ISNULL(@AlCentroCostos3, @CentroCostos3)

   SELECT DISTINCT
          @CtaResultados   		= CtaResultados,
    	  @CtaIngresos	   		= CtaIngresos,
    	  @CtaCostoDirecto 		= CtaCostoDirecto,
    	  @CtaGastosOperacion		= CtaGastosOperacion,
    	  @CtaOtrosGastosProductos	= CtaOtrosGastosProductos,
    	  @CtaImpuestos			= CtaImpuestos
     FROM EmpresaCfg
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #Resultado
  SELECT DISTINCT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Rama.Cuenta = Cta.Rama 
    JOIN ContSubSaldo cc ON cc.Cuenta = Cta.cuenta AND cc.Moneda = @Moneda AND cc.Empresa = @Empresa
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #Resultado
  SELECT DISTINCT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Rama.Cuenta = Cta.Rama
    JOIN ContSubSaldo cc ON cc.Cuenta = Cta.cuenta AND cc.Moneda = @Moneda AND cc.Empresa = @Empresa
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)

  -- Gastos Operacion
  INSERT #Resultado
  SELECT DISTINCT 3, "UAFIR",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Rama.Cuenta = Cta.Rama
    JOIN ContSubSaldo cc ON cc.Cuenta = Cta.cuenta AND cc.Moneda = @Moneda AND cc.Empresa = @Empresa
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  -- Otros Gastos y Productos
  INSERT #Resultado
  SELECT DISTINCT 4, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Rama.Cuenta = Cta.Rama
    JOIN ContSubSaldo cc ON cc.Cuenta = Cta.cuenta AND cc.Moneda = @Moneda AND cc.Empresa = @Empresa 
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
  
  -- Otros
  INSERT #Resultado
  SELECT DISTINCT 5, "Utilidad Neta",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         cc.SubCuenta,
   	 cc.CentroCostos,
         NULL,NULL,NULL,
         NULL,NULL,NULL
    FROM Cta
    JOIN Cta Rama ON Rama.Cuenta = Cta.Rama
    JOIN ContSubSaldo cc ON cc.Cuenta = Cta.cuenta AND cc.Moneda = @Moneda AND cc.Empresa = @Empresa
   WHERE UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
     AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
     AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  -- Ingresos Acumulados
  SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
    FROM Acum a 
   WHERE a.Rama = 'CONT'
     AND a.Cuenta = @CtaIngresos
     AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
     AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
     AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
     AND (@CentroCostos  IS NULL OR a.SubCuenta  BETWEEN @CentroCostos  AND @AlCentroCostos)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta2 BETWEEN @CentroCostos2 AND @AlCentroCostos2)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta3 BETWEEN @CentroCostos3 AND @AlCentroCostos3)
     AND a.Ejercicio = @Ejercicio 
     AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND a.Moneda = @Moneda
     AND a.Empresa = @Empresa

  -- Ingresos al Mes
  SELECT @IngresosAl = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
    FROM Acum a
   WHERE a.Rama = 'CONT'
     AND a.Cuenta = @CtaIngresos
     AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
     AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
     AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
     AND (@CentroCostos  IS NULL OR a.SubCuenta  BETWEEN @CentroCostos  AND @AlCentroCostos)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta2 BETWEEN @CentroCostos2 AND @AlCentroCostos2)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta3 BETWEEN @CentroCostos3 AND @AlCentroCostos3)
     AND a.Moneda = @Moneda
     AND a.Ejercicio = @Ejercicio 
     AND a.Periodo = @PeriodoA
     AND a.Empresa = @Empresa

  -- Saldo Acumulado
  UPDATE #Resultado
     SET Saldo = (
  SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
    FROM Acum a
   WHERE a.Rama = 'CONT'
     AND a.Cuenta = b.Cuenta 
     AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '')
     AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
     AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
     AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
     AND (@CentroCostos  IS NULL OR a.SubCuenta  BETWEEN @CentroCostos  AND @AlCentroCostos)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta2 BETWEEN @CentroCostos2 AND @AlCentroCostos2)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta3 BETWEEN @CentroCostos3 AND @AlCentroCostos3)
     AND a.Moneda = @Moneda
     AND a.Ejercicio = @Ejercicio 
     AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA
     AND a.Empresa = @Empresa)
    FROM #Resultado b

  UPDATE #Resultado
     SET Ingresos = @Ingresos,
         Porcentaje = (Saldo/dbo.fnEvitarDivisionCero(@Ingresos))*100 

  -- Saldo al Mes
  UPDATE #Resultado
     SET SaldoAl = (
  SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
    FROM Acum a
   WHERE a.Rama = 'CONT'
     AND a.Cuenta = b.Cuenta 
     AND ISNULL(a.SubCuenta, '') = ISNULL(b.SubCuenta, '')
     AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
     AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
     AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
     AND (@CentroCostos  IS NULL OR a.SubCuenta  BETWEEN @CentroCostos  AND @AlCentroCostos)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta2 BETWEEN @CentroCostos2 AND @AlCentroCostos2)
     AND (@CentroCostos2 IS NULL OR a.SubCuenta3 BETWEEN @CentroCostos3 AND @AlCentroCostos3)
     AND a.Moneda = @Moneda
     AND a.Ejercicio = @Ejercicio 
     AND a.Periodo = @PeriodoA
     AND a.Empresa = @Empresa)
    FROM #Resultado b

  UPDATE #Resultado 
     SET IngresosAl = @IngresosAl,
         PorcentajeAl = (SaldoAl/dbo.fnEvitarDivisionCero(@IngresosAl))*100

  --REQ2162
  IF @ReExpresar = 'Si'
    UPDATE #Resultado
	   SET Saldo=Saldo/ISNULL(@ReExpresarTipoCambio,1),
	       Ingresos=Ingresos/ISNULL(@ReExpresarTipoCambio,1),
		   SaldoAl=SaldoAl/ISNULL(@ReExpresarTipoCambio,1),
		   IngresosAl=IngresosAl/ISNULL(@ReExpresarTipoCambio,1)


  IF @OrdenCC = 'NO' 
  BEGIN
    IF @ConMovs = 'SI' 
      SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), null) 
        FROM #Resultado r 
       WHERE ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0 ORDER BY r.Orden, r.ID
    ELSE
      SELECT r.*, "Grupo" = CONVERT(varchar(50), null), "SubGrupo" = CONVERT(varchar(50), null), "SubSubGrupo" = CONVERT(varchar(50), null) 
        FROM #Resultado r 
       ORDER BY r.Orden, r.ID
  END ELSE
  BEGIN
    IF @CCGrupo <> 'NULL'
    BEGIN
      IF @ConMovs = 'SI' 
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #Resultado r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo) 
         WHERE ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0            
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #Resultado r JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos AND cc.Grupo = ISNULL(@CCGrupo, cc.Grupo) 
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END ELSE
    BEGIN
      IF @ConMovs = 'SI' 
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #Resultado r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos 
         WHERE ISNULL(r.Saldo, 0.0) <> 0.0 OR ISNULL(r.SaldoAl, 0.0) <> 0.0 
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
      ELSE
        SELECT r.*, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo 
          FROM #Resultado r LEFT OUTER JOIN CentroCostos cc ON r.SubCuenta = cc.CentroCostos 
         ORDER BY r.Orden, r.Rama, cc.Grupo, cc.SubGrupo, cc.SubSubGrupo, r.SubCuenta, r.ID
    END
  END

 

END
GO

/**************** spVerContResultadosAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosAnual') and type = 'P') drop procedure dbo.spVerContResultadosAnual
GO
CREATE PROCEDURE spVerContResultadosAnual
		    @Empresa		varchar(5),
		    @Ejercicio		int,
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            @Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL,
	        @ReExpresar     char(20) = 'NO', --REQ2162
	        @ReExpresarTipoCambio float = NULL --REQ2162

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
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
    @SaldoAlDic         money,
    @Ingresos		money,
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
    @PorcentajeAlDic    money
 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     ID			int		IDENTITY(1,1) NOT NULL,

     Clase		varchar(20)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
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
     Ingresos		money		NULL,
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

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

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
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
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
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
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
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b

  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
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
             SaldoAlDic = @SaldoAlDic,
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
	     IngresosAlDic = @IngresosAlDic,
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
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

  --REQ2162
  IF @ReExpresar='Si'
    UPDATE #ResultadoAnual
	   SET   SaldoAlEne = SaldoAlEne/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlFeb = SaldoAlFeb/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlMar = SaldoAlMar/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlAbr = SaldoAlAbr/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlMay = SaldoAlMay/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlJun = SaldoAlJun/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlJul = SaldoAlJul/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlAgo = SaldoAlAgo/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlSep = SaldoAlSep/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlOct = SaldoAlOct/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlNov = SaldoAlNov/ISNULL(@ReExpresarTipoCambio,1),
             SaldoAlDic = SaldoAlDic/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlEne = IngresosAlEne/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlFeb = IngresosAlFeb/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlMar = IngresosAlMar/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlAbr = IngresosAlAbr/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlMay = IngresosAlMay/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlJun = IngresosAlJun/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlJul = IngresosAlJul/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlAgo = IngresosAlAgo/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlSep = IngresosAlSep/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlOct = IngresosAlOct/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlNov = IngresosAlNov/ISNULL(@ReExpresarTipoCambio,1),
	     IngresosAlDic = IngresosAlDic/ISNULL(@ReExpresarTipoCambio,1)

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO
--REQ2301 Preconfigurado
/**************** spVerContResultadosAnualRS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosAnualRS') and type = 'P') drop procedure dbo.spVerContResultadosAnualRS
GO
CREATE PROCEDURE spVerContResultadosAnualRS
		    @Empresa		varchar(5),
		    @Ejercicio		int,
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            @Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
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
    @SaldoAlDic         money,
    @Ingresos		money,
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
    @PorcentajeAlDic    money,

	@CtaGastosOperacion varchar(20),
	@CtaOtrosGastosProductos  varchar(20)
 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,
     Clase		varchar(50)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
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
     Ingresos		money		NULL,
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

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto,
		  @CtaGastosOperacion = CtaGastosOperacion,
	      @CtaOtrosGastosProductos = CtaOtrosGastosProductos
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #ResultadoAnual
  SELECT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #ResultadoAnual
  SELECT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)
  
  -- Gastos de Operacion
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  -- Otros Gastos y Productos
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
     
  -- Otros
  INSERT #ResultadoAnual
  SELECT 5, "Utilidad Después de Impuestos",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
	 AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
	 AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b

  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
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
             SaldoAlDic = @SaldoAlDic,
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
	     IngresosAlDic = @IngresosAlDic,
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
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO
--REQ2165 Preconfigurado
/**************** spVerContResultadosAnualRSProy ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosAnualRSProy') and type = 'P') drop procedure dbo.spVerContResultadosAnualRSProy
GO
CREATE PROCEDURE spVerContResultadosAnualRSProy
		    @Empresa		varchar(5),
		    @Ejercicio		int,
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            @Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
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
    @SaldoAlDic         money,
    @Ingresos		money,
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
    @PorcentajeAlDic    money,

	@CtaGastosOperacion varchar(20),
	@CtaOtrosGastosProductos  varchar(20)
 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,
     Clase		varchar(50)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
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
     Ingresos		money		NULL,
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

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto,
		  @CtaGastosOperacion = CtaGastosOperacion,
	      @CtaOtrosGastosProductos = CtaOtrosGastosProductos
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #ResultadoAnual
  SELECT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #ResultadoAnual
  SELECT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)
  
  -- Gastos de Operacion
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  -- Otros Gastos y Productos
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
     
  -- Otros
  INSERT #ResultadoAnual
  SELECT 5, "Utilidad Después de Impuestos",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
	 AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
	 AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        --AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b

  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
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
             SaldoAlDic = @SaldoAlDic,
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
	     IngresosAlDic = @IngresosAlDic,
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
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO
--REQ25870
/**************** spRSVerContResultadosAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSVerContResultadosAnual') and type = 'P') drop procedure dbo.spRSVerContResultadosAnual
GO
CREATE PROCEDURE spRSVerContResultadosAnual
		    @Empresa		varchar(5),
		    @SEjercicio		varchar(4),
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
		    @SUEN			varchar(10)	= NULL,
		    @Proyecto		varchar(max)= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Ejercicio		int,
		  @UEN				int,
          @ProyectoAux		varchar(50),
		  @ProyectoAuxAnt	varchar(50)

  CREATE TABLE #Temp(
     Orden		        int		    NOT NULL,
     ID					int			NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NOT NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     IngresosAlEne		money		NULL,
     IngresosAlFeb		money		NULL,
     IngresosAlMar		money		NULL,
     IngresosAlAbr		money		NULL,
     IngresosAlMay		money		NULL,
     IngresosAlJun		money		NULL,
     IngresosAlJul		money		NULL,
     IngresosAlAgo		money		NULL,
     IngresosAlSep		money		NULL,
     IngresosAlOct		money		NULL,
     IngresosAlNov		money		NULL,
     IngresosAlDic		money		NULL,
     Porcentaje			float		NULL,
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
  )

  CREATE TABLE #Consolidado(
     Orden		        int		    NOT NULL,
     RID				int			IDENTITY(1,1) NOT NULL,
     Proyecto			varchar(50)	COLLATE Database_Default NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NOT NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     IngresosAlEne		money		NULL,
     IngresosAlFeb		money		NULL,
     IngresosAlMar		money		NULL,
     IngresosAlAbr		money		NULL,
     IngresosAlMay		money		NULL,
     IngresosAlJun		money		NULL,
     IngresosAlJul		money		NULL,
     IngresosAlAgo		money		NULL,
     IngresosAlSep		money		NULL,
     IngresosAlOct		money		NULL,
     IngresosAlNov		money		NULL,
     IngresosAlDic		money		NULL,
     Porcentaje			float		NULL,
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
  )

  IF @CentroCostos='' SELECT @CentroCostos = NULL
  IF @Moneda='' SELECT @Moneda = NULL
  IF @SUEN='' SELECT @SUEN = NULL
  IF @CentroCostos2='' SELECT @CentroCostos2 = NULL
  IF @CentroCostos3='' SELECT @CentroCostos3 = NULL

  SELECT @Ejercicio = CONVERT(int, @SEjercicio),
		 @UEN = CONVERT(int, @SUEN)

  CREATE TABLE #Proy(Proyecto	varchar(50) COLLATE Database_Default )

  --SELECT * INTO #Consolidado2 FROM #Consolidado

  IF @Proyecto = ''
  BEGIN
	INSERT INTO #Temp(
         Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
    EXEC spVerContResultadosAnualRSProy @Empresa, @Ejercicio, @CentroCostos, @Moneda, NULL, @UEN, '', @CentroCostos2, @CentroCostos3

    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
               Proyecto, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
        SELECT '',       Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic
          FROM #Temp
  END

  IF @Proyecto LIKE '%(Todos)%'
  BEGIN
    
    INSERT INTO #Proy SELECT Proyecto FROM Proy
	INSERT INTO #Proy SELECT 'Sin Proyecto'

    SELECT @Proyecto = NULL
  END

  IF @Proyecto IS NOT NULL
    INSERT INTO #Proy SELECT ValorTexto FROM dbo.fnParseaCadena(@Proyecto, ',')
  --SELECT * FROM #Proy

  SELECT @ProyectoAuxAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @ProyectoAux = MIN(Proyecto)
      FROM #Proy
     WHERE Proyecto > @ProyectoAuxAnt

    IF @ProyectoAux IS NULL BREAK

    SELECT @ProyectoAuxAnt = @ProyectoAux 

    TRUNCATE TABLE #Temp

    INSERT INTO #Temp(
            Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
       EXEC spVerContResultadosAnualRSProy @Empresa, @Ejercicio, @CentroCostos, @Moneda, NULL, @UEN, @ProyectoAux, @CentroCostos2, @CentroCostos3

    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
                Proyecto,    Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
        SELECT @ProyectoAux, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic
          FROM #Temp
  END

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            Proyecto, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
  SELECT '', 4, 'Utilidad Bruta – Gastos de Operación', 'UAFIRDA', Rama, 'UAFIRDA', RamaEsAcreedora, '', '', 0,
     	 SUM(Saldo) Saldo,
		 SUM(SaldoAlEne) SaldoAlEne,
		 SUM(SaldoAlFeb) SaldoAlFeb,
		 SUM(SaldoAlMar) SaldoAlMar,
		 SUM(SaldoAlAbr) SaldoAlAbr,
		 SUM(SaldoAlMay) SaldoAlMay,
		 SUM(SaldoAlJun) SaldoAlJun,
		 SUM(SaldoAlJul) SaldoAlJul,
		 SUM(SaldoAlAgo) SaldoAlAgo,
		 SUM(SaldoAlSep) SaldoAlSep,
		 SUM(SaldoAlOct) SaldoAlOct,
		 SUM(SaldoAlNov) SaldoAlNov,
		 SUM(SaldoAlDic) SaldoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('S','T','U','U2')
  GROUP BY Rama, RamaEsAcreedora

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            Proyecto, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
  SELECT '', 6, 'Utilidad Neta', '', Rama, 'Utilidad Neta', RamaEsAcreedora, '', '', 0,
     	 SUM(Saldo) Saldo,
		 SUM(SaldoAlEne) SaldoAlEne,
		 SUM(SaldoAlFeb) SaldoAlFeb,
		 SUM(SaldoAlMar) SaldoAlMar,
		 SUM(SaldoAlAbr) SaldoAlAbr,
		 SUM(SaldoAlMay) SaldoAlMay,
		 SUM(SaldoAlJun) SaldoAlJun,
		 SUM(SaldoAlJul) SaldoAlJul,
		 SUM(SaldoAlAgo) SaldoAlAgo,
		 SUM(SaldoAlSep) SaldoAlSep,
		 SUM(SaldoAlOct) SaldoAlOct,
		 SUM(SaldoAlNov) SaldoAlNov,
		 SUM(SaldoAlDic) SaldoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('S','T','U','U2','U3') AND SubClase<>'UAFIRDA'
  GROUP BY Rama, RamaEsAcreedora

  UPDATE #Consolidado SET Proyecto='' WHERE Proyecto='Sin Proyecto' --REQ2313

  SELECT RID, Orden,
         Proyecto, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora,
     	 ISNULL(Saldo,0) Saldo, ISNULL(SaldoAlEne,0) SaldoAlEne, ISNULL(SaldoAlFeb,0) SaldoAlFeb, ISNULL(SaldoAlMar,0) SaldoAlMar,
		 ISNULL(SaldoAlAbr,0) SaldoAlAbr, ISNULL(SaldoAlMay,0) SaldoAlMay,	ISNULL(SaldoAlJun,0) SaldoAlJun,
		 ISNULL(SaldoAlJul,0) SaldoAlJul, ISNULL(SaldoAlAgo,0) SaldoAlAgo,	ISNULL(SaldoAlSep,0) SaldoAlSep,
		 ISNULL(SaldoAlOct,0) SaldoAlOct, ISNULL(SaldoAlNov,0) SaldoAlNov,  ISNULL(SaldoAlDic,0) SaldoAlDic,
		 ISNULL(Ingresos,0) Ingresos, ISNULL(IngresosAlEne,0) IngresosAlEne, ISNULL(IngresosAlFeb,0) IngresosAlFeb,
		 ISNULL(IngresosAlMar,0) IngresosAlMar, ISNULL(IngresosAlAbr,0) IngresosAlAbr, ISNULL(IngresosAlMay,0) IngresosAlMay,
		 ISNULL(IngresosAlJun,0) IngresosAlJun, ISNULL(IngresosAlJul,0) IngresosAlJul, ISNULL(IngresosAlAgo,0) IngresosAlAgo,
		 ISNULL(IngresosAlSep,0) IngresosAlSep, ISNULL(IngresosAlOct,0) IngresosAlOct, ISNULL(IngresosAlNov,0) IngresosAlNov,  ISNULL(Porcentaje,0),
		 ISNULL(PorcentajeAlEne,0),ISNULL(PorcentajeAlFeb,0) PorcentajeAlFeb, ISNULL(PorcentajeAlMar,0) PorcentajeAlMar, ISNULL(PorcentajeAlAbr,0) PorcentajeAlAbr,
		 ISNULL(PorcentajeAlMay,0) PorcentajeAlMay, ISNULL(PorcentajeAlJun,0) PorcentajeAlJun, ISNULL(PorcentajeAlJul,0) PorcentajeAlJul,
		 ISNULL(PorcentajeAlAgo,0) PorcentajeAlAgo, ISNULL(PorcentajeAlSep,0) PorcentajeAlSep, ISNULL(PorcentajeAlOct,0) PorcentajeAlOct,
		 ISNULL(PorcentajeAlNov,0) PorcentajeAlNov, ISNULL(PorcentajeAlDic,0) PorcentajeAlDic
  FROM #Consolidado
  ORDER BY Orden, Clase, Rama, Cuenta, Proyecto	 

  RETURN
END
GO

/********* VerContBalanzaAnual *********/ 
if exists ( select * from sysobjects where id = object_id('dbo.VerContBalanzaAnual') and sysstat & 0xf = 3 ) drop table dbo.VerContBalanzaAnual
go
CREATE TABLE dbo.VerContBalanzaAnual (
	Estacion	int		NOT NULL,
	Cuenta		varchar(20)	NOT NULL,
	Tipo		varchar(15)	NULL,
	Inicio		float		NULL,
	CargosEne	float		NULL,
	AbonosEne	float		NULL,
	CargosFeb	float		NULL,
	AbonosFeb	float		NULL,
	CargosMar	float		NULL,
	AbonosMar	float		NULL,
	CargosAbr	float		NULL,
	AbonosAbr	float		NULL,
	CargosMay	float		NULL,
	AbonosMay	float		NULL,
	CargosJun	float		NULL,
	AbonosJun	float		NULL,
	CargosJul	float		NULL,
	AbonosJul	float		NULL,
	CargosAgo	float		NULL,
	AbonosAgo	float		NULL,
	CargosSep	float		NULL,
	AbonosSep	float		NULL,
	CargosOct	float		NULL,
	AbonosOct	float		NULL,
	CargosNov	float		NULL,
	AbonosNov	float		NULL,
	CargosDic	float		NULL,
	AbonosDic	float		NULL,
CONSTRAINT PriVerContBalanzaAnual PRIMARY KEY CLUSTERED(Estacion, Cuenta))
Go

/**************** spVerContBalanzaAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanzaAnual') and type = 'P') drop procedure dbo.spVerContBalanzaAnual
GO             
SET ANSI_NULLS OFF
Go
CREATE PROCEDURE spVerContBalanzaAnual
		    @Empresa		varchar(5),
		    @Estacion		int,
		    @Ejercicio		int,
--		    @PeriodoD		int,
--		    @PeriodoA		int,
--		    @ConMovs		varchar(20) = 'NO',
                    @Tipo		varchar(20) = 'MAYOR',
		    @CuentaD		varchar(20) = NULL,
                    @CuentaA		varchar(20) = NULL,
                    @CentroCostos       varchar(50) = NULL,
		    @Moneda		varchar(10) = NULL,
                    @Controladora	varchar(5)  = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL
			--@ReExpresar     char(20) = 'NO', --REQ2162
			--@ReExpresarTipoCambio float = NULL --REQ2162
		    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Cuenta		varchar(20),
    @Periodo		int,
    @Cargos		float,
    @Abonos		float,
    @CargosEne		float,
    @AbonosEne		float,
    @CargosFeb		float,
    @AbonosFeb		float,
    @CargosMar		float,
    @AbonosMar		float,
    @CargosAbr		float,
    @AbonosAbr		float,
    @CargosMay		float,
    @AbonosMay		float,
    @CargosJun		float,
    @AbonosJun		float,
    @CargosJul		float,
    @AbonosJul		float,
    @CargosAgo		float,
    @AbonosAgo		float,
    @CargosSep		float,
    @AbonosSep		float,
    @CargosOct		float,
    @AbonosOct		float,
    @CargosNov		float,
    @AbonosNov		float,
    @CargosDic		float,
    @AbonosDic		float,
    @Rama   		varchar(5),
--    @Cuenta 		varchar(20),
    @CuentaRangoD	varchar(20),
    @CuentaRangoA	varchar(20),
    @Tipos  		varchar(100),
    @Inicio 		money

 SELECT @Rama = 'CONT', --@ConMovs = NULLIF(RTRIM(UPPER(@ConMovs)), ''), 
         @Tipo = NULLIF(RTRIM(UPPER(@Tipo)), ''),
         @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
  IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
  IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
  IF UPPER(@Empresa) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Empresa = NULL
  IF UPPER(@Controladora) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Controladora = NULL
  EXEC spContEmpresaGrupo @Empresa OUTPUT, @Controladora OUTPUT
  IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
  IF @UEN = 0 SELECT @UEN = NULL
  IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
  IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
  IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

  DELETE VerContBalanzaAnual WHERE Estacion = @Estacion
 
  IF @Tipo = 'MAYOR' 
     BEGIN     
     IF @CentroCostos = NULL
        BEGIN
	     DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
     ELSE
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END   

  IF @Tipo = 'SUBCUENTA'  
      BEGIN
      IF @CentroCostos = NULL
        BEGIN
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
      ELSE
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END
   IF @Tipo = 'AUXILIAR'   
      BEGIN
      IF @CentroCostos= NULL
        BEGIN   
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
      ELSE 
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) -- BUG2160 Preconf
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END

  OPEN ContBalanzaAnual 
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
   WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
   BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN  
 
      SELECT @Inicio=Null,
	     @CargosEne = Null, @AbonosEne = Null, 
             @CargosFeb = Null, @AbonosFeb = Null, 
             @CargosMar = Null, @AbonosMar = Null, 
             @CargosAbr = Null, @AbonosAbr = Null,
             @CargosMay = Null, @AbonosMay = Null, 
             @CargosJun = Null, @AbonosJun = Null, 
             @CargosJul = Null, @AbonosJul = Null, 
             @CargosAgo = Null, @AbonosAgo = Null, 
             @CargosSep = Null, @AbonosSep = Null, 
             @CargosOct = Null, @AbonosOct = Null, 
             @CargosNov = Null, @AbonosNov = Null, 
             @CargosDic = Null, @AbonosDic = Null

      IF @Periodo = 0 	SELECT @Inicio = ( @Cargos - @Abonos )
      IF @Periodo = 1 	SELECT @CargosEne = @Cargos, @AbonosEne = @Abonos 
      IF @Periodo = 2 	SELECT @CargosFeb = @Cargos, @AbonosFeb = @Abonos 
      IF @Periodo = 3	SELECT @CargosMar = @Cargos, @AbonosMar = @Abonos 
      IF @Periodo = 4 	SELECT @CargosAbr = @Cargos, @AbonosAbr = @Abonos 
      IF @Periodo = 5 	SELECT @CargosMay = @Cargos, @AbonosMay = @Abonos 
      IF @Periodo = 6 	SELECT @CargosJun = @Cargos, @AbonosJun = @Abonos 
      IF @Periodo = 7 	SELECT @CargosJul = @Cargos, @AbonosJul = @Abonos 
      IF @Periodo = 8 	SELECT @CargosAgo = @Cargos, @AbonosAgo = @Abonos 
      IF @Periodo = 9 	SELECT @CargosSep = @Cargos, @AbonosSep = @Abonos 
      IF @Periodo = 10  SELECT @CargosOct = @Cargos, @AbonosOct = @Abonos 
      IF @Periodo = 11  SELECT @CargosNov = @Cargos, @AbonosNov = @Abonos 
      IF @Periodo = 12  SELECT @CargosDic = @Cargos, @AbonosDic = @Abonos 

      UPDATE VerContBalanzaAnual
         SET Inicio    = ISNULL(Inicio,0.0)    + ISNULL(@Inicio,0.0),
	         CargosEne = ISNULL(CargosEne,0.0) + ISNULL(@CargosEne,0.0),
             AbonosEne = ISNULL(AbonosEne,0.0) + ISNULL(@AbonosEne,0.0),
             CargosFeb = ISNULL(CargosFeb,0.0) + ISNULL(@CargosFeb,0.0),
             AbonosFeb = ISNULL(AbonosFeb,0.0) + ISNULL(@AbonosFeb,0.0),
             CargosMar = ISNULL(CargosMar,0.0) + ISNULL(@CargosMar,0.0),
             AbonosMar = ISNULL(AbonosMar,0.0) + ISNULL(@AbonosMar,0.0),
             CargosAbr = ISNULL(CargosAbr,0.0) + ISNULL(@CargosAbr,0.0),
             AbonosAbr = ISNULL(AbonosAbr,0.0) + ISNULL(@AbonosAbr,0.0),
             CargosMay = ISNULL(CargosMay,0.0) + ISNULL(@CargosMay,0.0),
             AbonosMay = ISNULL(AbonosMay,0.0) + ISNULL(@AbonosMay,0.0),
             CargosJun = ISNULL(CargosJun,0.0) + ISNULL(@CargosJun,0.0),
             AbonosJun = ISNULL(AbonosJun,0.0) + ISNULL(@AbonosJun,0.0),
             CargosJul = ISNULL(CargosJul,0.0) + ISNULL(@CargosJul,0.0),
             AbonosJul = ISNULL(AbonosJul,0.0) + ISNULL(@AbonosJul,0.0),
             CargosAgo = ISNULL(CargosAgo,0.0) + ISNULL(@CargosAgo,0.0),
             AbonosAgo = ISNULL(AbonosAgo,0.0) + ISNULL(@AbonosAgo,0.0),
             CargosSep = ISNULL(CargosSep,0.0) + ISNULL(@CargosSep,0.0),
             AbonosSep = ISNULL(AbonosSep,0.0) + ISNULL(@AbonosSep,0.0),
             CargosOct = ISNULL(CargosOct,0.0) + ISNULL(@CargosOct,0.0),
             AbonosOct = ISNULL(AbonosOct,0.0) + ISNULL(@AbonosOct,0.0),
             CargosNov = ISNULL(CargosNov,0.0) + ISNULL(@CargosNov,0.0),
             AbonosNov = ISNULL(AbonosNov,0.0) + ISNULL(@AbonosNov,0.0),
             CargosDic = ISNULL(CargosDic,0.0) + ISNULL(@CargosDic,0.0),
             AbonosDic = ISNULL(AbonosDic,0.0) + ISNULL(@AbonosDic,0.0)
       WHERE Estacion = @Estacion AND Cuenta = @Cuenta

     IF @@ROWCOUNT = 0
     INSERT VerContBalanzaAnual (Estacion, Cuenta, Tipo, Inicio, CargosEne, AbonosEne, CargosFeb, AbonosFeb, CargosMar, AbonosMar, CargosAbr, AbonosAbr, CargosMay, AbonosMay, CargosJun, AbonosJun, CargosJul, AbonosJul, CargosAgo, AbonosAgo, CargosSep, AbonosSep, CargosOct, AbonosOct, CargosNov, AbonosNov, CargosDic, AbonosDic)
                      VALUES (@Estacion,@Cuenta,@Tipo,@Inicio,@CargosEne,@AbonosEne,@CargosFeb,@AbonosFeb,@CargosMar,@AbonosMar,@CargosAbr,@AbonosAbr,@CargosMay,@AbonosMay,@CargosJun,@AbonosJun,@CargosJul,@AbonosJul,@CargosAgo,@AbonosAgo,@CargosSep,@AbonosSep,@CargosOct,@AbonosOct,@CargosNov,@AbonosNov,@CargosDic,@AbonosDic)

   END
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
  END
  CLOSE ContBalanzaAnual
  DEALLOCATE ContBalanzaAnual

  --REQ2162
  --IF @ReExpresar='Si'
  --  UPDATE VerContBalanzaAnual
	 --  SET   Inicio    = (ISNULL(Inicio,0.0)    + ISNULL(@Inicio,0.0))/ISNULL(@ReExpresarTipoCambio,1),
	 --        CargosEne = CargosEne/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosEne = AbonosEne/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosFeb = CargosFeb/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosFeb = AbonosFeb/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosMar = CargosMar/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosMar = AbonosMar/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosAbr = CargosAbr/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosAbr = AbonosAbr/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosMay = CargosMay/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosMay = AbonosMay/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosJun = CargosJun/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosJun = AbonosJun/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosJul = CargosJul/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosJul = AbonosJul/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosAgo = CargosAgo/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosAgo = AbonosAgo/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosSep = CargosSep/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosSep = AbonosSep/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosOct = CargosOct/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosOct = AbonosOct/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosNov = CargosNov/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosNov = AbonosNov/ISNULL(@ReExpresarTipoCambio,1),
  --           CargosDic = CargosDic/ISNULL(@ReExpresarTipoCambio,1),
  --           AbonosDic = AbonosDic/ISNULL(@ReExpresarTipoCambio,1)
  --  WHERE Estacion = @Estacion
	
  RETURN
END
GO

/*
spVerContBalanzaAnual 'Globe',73, 2000,'MAYOR','000-000-000','999-999-999', '(TODOS)'
*/


/** Cuadre Contable */

-- select * from cta where Cuenta in (select cuenta from dbo.fnCtaExplosion('B'))
/**************** fnCtaExplosion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaExplosion' AND type = 'TF') DROP FUNCTION fnCtaExplosion
GO
CREATE FUNCTION fnCtaExplosion (@Cuenta varchar(20))
RETURNS @Resultado TABLE (Cuenta varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado 
  SELECT c.Cuenta
    FROM Cta c
    JOIN Cta r ON r.Cuenta = c.Rama
   WHERE c.Cuenta = @Cuenta OR c.Rama = @Cuenta OR r.Rama = @Cuenta

  RETURN 
END
GO

--REQ25870
/**************** fnParseaCadena ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnParseaCadena') DROP FUNCTION fnParseaCadena
GO
CREATE FUNCTION fnParseaCadena(
		@Cadena		varchar(max),
		@Separador	varchar(100) = ','
)
RETURNS @Tabla TABLE 
 (
  Posicion		int identity(1,1),
  ValorTexto	varchar(max)
 )
AS
BEGIN
 DECLARE @w_Continue  int
  ,@w_StartPos  int
  ,@w_Length  int
  ,@w_Delimeter_pos int
  ,@w_tmp_txt   varchar(max)
  ,@w_Delimeter_Len tinyint
 if len(@Cadena) = 0
 begin
  SET  @w_Continue = 0 -- force early exit
 end 
 else
 begin
 -- parse the original @Cadena array into a temp table
  SET  @w_Continue = 1
  SET @w_StartPos = 1
  SET @Cadena = RTRIM( LTRIM( @Cadena))
  SET @w_Length   = DATALENGTH( RTRIM( LTRIM( @Cadena)))
  SET @w_Delimeter_Len = len(@Separador)
 end
 WHILE @w_Continue = 1
 BEGIN
  SET @w_Delimeter_pos = CHARINDEX( @Separador
      ,(SUBSTRING( @Cadena, @w_StartPos
      ,((@w_Length - @w_StartPos) + @w_Delimeter_Len)))
      )
 
  IF @w_Delimeter_pos > 0  -- delimeter(s) found, get the value
  BEGIN
   SET @w_tmp_txt = LTRIM(RTRIM( SUBSTRING( @Cadena, @w_StartPos 
        ,(@w_Delimeter_pos - 1)) ))

   SET @w_StartPos = @w_Delimeter_pos + @w_StartPos + (@w_Delimeter_Len- 1)
  END
  ELSE -- No more delimeters, get last value
  BEGIN
   SET @w_tmp_txt = LTRIM(RTRIM( SUBSTRING( @Cadena, @w_StartPos 
      ,((@w_Length - @w_StartPos) + @w_Delimeter_Len)) ))
      
   SELECT @w_Continue = 0
  END
  INSERT INTO @Tabla VALUES(@w_tmp_txt)
 END
RETURN
END
GO
--REQ25847
/**************** spVerContResultadosAnualRSCC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosAnualRSCC') and type = 'P') drop procedure dbo.spVerContResultadosAnualRSCC
GO
CREATE PROCEDURE spVerContResultadosAnualRSCC
		    @Empresa		varchar(5),
		    @Ejercicio		int,
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            @Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
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
    @SaldoAlDic         money,
    @Ingresos		money,
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
    @PorcentajeAlDic    money,

	@CtaGastosOperacion varchar(20),
	@CtaOtrosGastosProductos  varchar(20)
 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     Orden		int		NOT NULL,
     ID			int		IDENTITY(1,1) NOT NULL,
     Clase		varchar(50)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
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
     Ingresos		money		NULL,
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

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   IF @CentroCostos='Sin CC' SELECT @CentroCostos = ''

   --SELECT * FROM Acum WHERE Ejercicio=@Ejercicio AND SubCuenta=@CentroCostos

   IF NOT EXISTS (SELECT * FROM Acum WHERE Ejercicio=@Ejercicio AND SubCuenta=@CentroCostos)
     SELECT @CentroCostos = NULL
   
   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto,
		  @CtaGastosOperacion = CtaGastosOperacion,
	      @CtaOtrosGastosProductos = CtaOtrosGastosProductos
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

  -- Ventas
  INSERT #ResultadoAnual
  SELECT 1, "Utilidad Bruta",
	 "Ventas",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaIngresos OR Rama.Rama = @CtaIngresos)

  -- Costos
  INSERT #ResultadoAnual
  SELECT 2, "Utilidad Bruta",
	 "Costos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaCostoDirecto OR Rama.Rama = @CtaCostoDirecto)
  
  -- Gastos de Operacion
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
         FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaGastosOperacion OR Rama.Rama = @CtaGastosOperacion)

  -- Otros Gastos y Productos
  INSERT #ResultadoAnual
  SELECT 3, "Utilidad Antes de Impuestos",
	 "Gastos", 
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaOtrosGastosProductos OR Rama.Rama = @CtaOtrosGastosProductos)
     
  -- Otros
  INSERT #ResultadoAnual
  SELECT 5, "Utilidad Después de Impuestos",
	 "Otros",
         Rama.Cuenta,
         Rama.Descripcion,
         Rama.EsAcreedora,
	 Cta.Cuenta,
         Cta.Descripcion,
         Cta.EsAcreedora,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)
	 AND (Cta.Rama <> @CtaGastosOperacion AND Rama.Rama <> @CtaGastosOperacion)
	 AND (Cta.Rama <> @CtaOtrosGastosProductos AND Rama.Rama <> @CtaOtrosGastosProductos)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
	   AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   --AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b

  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND (CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
			"SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')), --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto)),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')) --(CASE WHEN a.Proyecto = '' THEN 'Sin Proyecto' Else a.Proyecto END) = ISNULL(@Proyecto, a.Proyecto))
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
             SaldoAlDic = @SaldoAlDic,
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
	     IngresosAlDic = @IngresosAlDic,
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
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO
--REQ25847
/**************** spRSVerContResultadosAnualCC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSVerContResultadosAnualCC') and type = 'P') drop procedure dbo.spRSVerContResultadosAnualCC
GO
CREATE PROCEDURE spRSVerContResultadosAnualCC
		    @Empresa		varchar(5),
		    @SEjercicio		varchar(4),
			@CentroCostos	varchar(Max) = NULL,
		    @Moneda			varchar(10) = NULL,
		    @SUEN			varchar(10)	= NULL,
			@Proyecto		varchar(50)= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Ejercicio		int,
		  @UEN				int,
 		  @CentroCostosAux		varchar(20),
		  @CentroCostosAuxAnt	varchar(20)

  CREATE TABLE #Temp(
     Orden		        int		    NOT NULL, --REQ2301
     ID					int			NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NOT NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     IngresosAlEne		money		NULL,
     IngresosAlFeb		money		NULL,
     IngresosAlMar		money		NULL,
     IngresosAlAbr		money		NULL,
     IngresosAlMay		money		NULL,
     IngresosAlJun		money		NULL,
     IngresosAlJul		money		NULL,
     IngresosAlAgo		money		NULL,
     IngresosAlSep		money		NULL,
     IngresosAlOct		money		NULL,
     IngresosAlNov		money		NULL,
     IngresosAlDic		money		NULL,
     Porcentaje			float		NULL,
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
  )

  CREATE TABLE #Consolidado(
     Orden		        int		    NOT NULL, --REQ2301
     RID				int			IDENTITY(1,1) NOT NULL,
	 CentroCostos       varchar(20) COLLATE Database_Default NULL,
     Clase				varchar(50)	COLLATE Database_Default NULL,
     SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
     EsAcreedora		bit			NOT NULL DEFAULT 0,
     Saldo				money		NULL,
     SaldoAlEne			money		NULL,
     SaldoAlFeb			money		NULL,
     SaldoAlMar			money		NULL,
     SaldoAlAbr			money		NULL,
     SaldoAlMay			money		NULL,
     SaldoAlJun			money		NULL,
     SaldoAlJul			money		NULL,
     SaldoAlAgo			money		NULL,
     SaldoAlSep			money		NULL,
     SaldoAlOct 		money		NULL,
     SaldoAlNov			money		NULL,
     SaldoAlDic			money		NULL,
     Ingresos			money		NULL,
     IngresosAlEne		money		NULL,
     IngresosAlFeb		money		NULL,
     IngresosAlMar		money		NULL,
     IngresosAlAbr		money		NULL,
     IngresosAlMay		money		NULL,
     IngresosAlJun		money		NULL,
     IngresosAlJul		money		NULL,
     IngresosAlAgo		money		NULL,
     IngresosAlSep		money		NULL,
     IngresosAlOct		money		NULL,
     IngresosAlNov		money		NULL,
     IngresosAlDic		money		NULL,
     Porcentaje			float		NULL,
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
  )

  IF @Moneda='' SELECT @Moneda = NULL
  IF @SUEN='' SELECT @SUEN = NULL
  IF @Proyecto='' SELECT @Proyecto = NULL
  IF @CentroCostos2='' SELECT @CentroCostos2 = NULL
  IF @CentroCostos3='' SELECT @CentroCostos3 = NULL

  SELECT @Ejercicio = CONVERT(int, @SEjercicio),
		 @UEN = CONVERT(int, @SUEN)

  CREATE TABLE #CentroCostos(CentroCostos varchar(20) COLLATE Database_Default )

  IF @CentroCostos='(Sin Desglose)' AND LEN(@CentroCostos)<=14 SELECT @CentroCostos = NULL --BUG2771
  IF @CentroCostos<>'(Sin Desglose)' AND LEN(@CentroCostos)>14 SELECT @CentroCostos = '(Todos)' --BUG2771
  --SELECT @CentroCostos, LEN(@CentroCostos)

  IF @CentroCostos = ''
  BEGIN
	INSERT INTO #Temp(
         Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic) --REQ2301
	EXEC spVerContResultadosAnualRSCC @Empresa, @Ejercicio, '', @Moneda, NULL, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

	--REQ2301
    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
			   Orden, CentroCostos, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic) --REQ2301
        SELECT Orden, '', Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic
          FROM #Temp

	  SELECT @CentroCostos = NULL
  END

  IF @CentroCostos LIKE '%(Todos)%'
  BEGIN
    INSERT INTO #CentroCostos SELECT CentroCostos FROM CentroCostos
	INSERT INTO #CentroCostos SELECT 'Sin CC'

	SELECT @CentroCostos = NULL
  END

  IF @CentroCostos IS NOT NULL
  BEGIN
   INSERT INTO #CentroCostos SELECT ValorTexto FROM dbo.fnParseaCadena(@CentroCostos, ',')
   DELETE FROM #CentroCostos WHERE CentroCostos='(Sin Desglose)'  --BUG2771
  END

  SELECT @CentroCostosAuxAnt = ''
  WHILE(1=1)
  BEGIN
	 SELECT @CentroCostosAux = MIN(CentroCostos)
      FROM #CentroCostos
     WHERE CentroCostos > @CentroCostosAuxAnt

    IF @CentroCostosAux IS NULL BREAK

    SELECT @CentroCostosAuxAnt = @CentroCostosAux 

    TRUNCATE TABLE #Temp

	--REQ2301
    INSERT INTO #Temp(
            Orden, ID, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
	   EXEC spVerContResultadosAnualRSCC @Empresa, @Ejercicio, @CentroCostosAux, @Moneda, NULL, @UEN,  @Proyecto, @CentroCostos2, @CentroCostos3

	--REQ2301
    IF EXISTS(SELECT * FROM #Temp)
      INSERT INTO #Consolidado(
		          Orden, CentroCostos,    Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic)
        SELECT Orden, @CentroCostosAux, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic, Ingresos, IngresosAlEne, IngresosAlFeb, IngresosAlMar, IngresosAlAbr, IngresosAlMay, IngresosAlJun, IngresosAlJul, IngresosAlAgo, IngresosAlSep, IngresosAlOct, IngresosAlNov, IngresosAlDic, Porcentaje, PorcentajeAlEne, PorcentajeAlFeb, PorcentajeAlMar, PorcentajeAlAbr, PorcentajeAlMay, PorcentajeAlJun, PorcentajeAlJul, PorcentajeAlAgo, PorcentajeAlSep, PorcentajeAlOct, PorcentajeAlNov, PorcentajeAlDic
          FROM #Temp
  END

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
  SELECT '', 4, 'Utilidad Bruta – Gastos de Operación', 'UAFIRDA', Rama, 'UAFIRDA', RamaEsAcreedora, '', '', 0,
     	 SUM(Saldo) Saldo,
		 SUM(SaldoAlEne) SaldoAlEne,
		 SUM(SaldoAlFeb) SaldoAlFeb,
		 SUM(SaldoAlMar) SaldoAlMar,
		 SUM(SaldoAlAbr) SaldoAlAbr,
		 SUM(SaldoAlMay) SaldoAlMay,
		 SUM(SaldoAlJun) SaldoAlJun,
		 SUM(SaldoAlJul) SaldoAlJul,
		 SUM(SaldoAlAgo) SaldoAlAgo,
		 SUM(SaldoAlSep) SaldoAlSep,
		 SUM(SaldoAlOct) SaldoAlOct,
		 SUM(SaldoAlNov) SaldoAlNov,
		 SUM(SaldoAlDic) SaldoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('S','T','U','U2')
  GROUP BY Rama, RamaEsAcreedora

  --REQ2301 Preconfigurado
  INSERT INTO #Consolidado(
            CentroCostos, Orden, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora, Saldo, SaldoAlEne, SaldoAlFeb, SaldoAlMar, SaldoAlAbr, SaldoAlMay, SaldoAlJun, SaldoAlJul, SaldoAlAgo, SaldoAlSep, SaldoAlOct, SaldoAlNov, SaldoAlDic)
  SELECT '', 6, 'Utilidad Neta', '', Rama, 'Utilidad Neta', RamaEsAcreedora, '', '', 0,
     	 SUM(Saldo) Saldo,
		 SUM(SaldoAlEne) SaldoAlEne,
		 SUM(SaldoAlFeb) SaldoAlFeb,
		 SUM(SaldoAlMar) SaldoAlMar,
		 SUM(SaldoAlAbr) SaldoAlAbr,
		 SUM(SaldoAlMay) SaldoAlMay,
		 SUM(SaldoAlJun) SaldoAlJun,
		 SUM(SaldoAlJul) SaldoAlJul,
		 SUM(SaldoAlAgo) SaldoAlAgo,
		 SUM(SaldoAlSep) SaldoAlSep,
		 SUM(SaldoAlOct) SaldoAlOct,
		 SUM(SaldoAlNov) SaldoAlNov,
		 SUM(SaldoAlDic) SaldoAlDic
  FROM #Consolidado 
  WHERE Rama IN ('S','T','U','U2','U3') AND SubClase<>'UAFIRDA'
  GROUP BY Rama, RamaEsAcreedora

  UPDATE #Consolidado SET CentroCostos='Sin Centro Costos' WHERE CentroCostos='Sin CC' --BUG2771

  --BUG2924
  SELECT Clase, SubClase, Rama,
--         SUM(Saldo) Saldo,
--		 SUM(SaldoAlEne) SaldoAlEne,
--		 SUM(SaldoAlFeb) SaldoAlFeb,
--		 SUM(SaldoAlMar) SaldoAlMar,
--		 SUM(SaldoAlAbr) SaldoAlAbr,
--		 SUM(SaldoAlMay) SaldoAlMay,
--		 SUM(SaldoAlJun) SaldoAlJun,
--		 SUM(SaldoAlJul) SaldoAlJul,
--		 SUM(SaldoAlAgo) SaldoAlAgo,
--		 SUM(SaldoAlSep) SaldoAlSep,
--		 SUM(SaldoAlOct) SaldoAlOct,
--		 SUM(SaldoAlNov) SaldoAlNov,
--		 SUM(SaldoAlDic) SaldoAlDic
         SUM(CASE WHEN RamaEsAcreedora=1 THEN Saldo*-1 ELSE Saldo END) Saldo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlEne*-1 ELSE SaldoAlEne END) SaldoAlEne,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlFeb*-1 ELSE SaldoAlFeb END) SaldoAlFeb,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMar*-1 ELSE SaldoAlMar END) SaldoAlMar,
		 SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAbr*-1 ELSE SaldoAlAbr END) SaldoAlAbr,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlMay*-1 ELSE SaldoAlMay END) SaldoAlMay,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJun*-1 ELSE SaldoAlJun END) SaldoAlJun,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlJul*-1 ELSE SaldoAlJul END) SaldoAlJul,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlAgo*-1 ELSE SaldoAlAgo END) SaldoAlAgo,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlSep*-1 ELSE SaldoAlSep END) SaldoAlSep,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlOct*-1 ELSE SaldoAlOct END) SaldoAlOct,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlNov*-1 ELSE SaldoAlNov END) SaldoAlNov,
         SUM(CASE WHEN RamaEsAcreedora=1 THEN SaldoAlDic*-1 ELSE SaldoAlDic END) SaldoAlDic
  INTO #ConsolidadoAcumClaseSubClaseRama 
  FROM #Consolidado
  GROUP BY Clase, SubClase, Rama

  --SELECT -107530.00/SaldoAlJun, * FROM #ConsolidadoAcumClaseSubClaseRama WHERE Clase='Utilidad Bruta' AND SubClase='Ventas' AND Rama='S'
  --SELECT Clase, SubClase, Rama, Count(*) FROM #ConsolidadoAcumClaseSubClaseRama GROUP BY Clase, SubClase, Rama HAVING COUNT(*)>1

  --BUG2924
  UPDATE #Consolidado
  SET Saldo=ISNULL(SaldoAlEne,0)+ISNULL(SaldoAlFeb,0)+ISNULL(SaldoAlMar,0)+ISNULL(SaldoAlAbr,0)+ 
            ISNULL(SaldoAlMay,0)+ISNULL(SaldoAlJun,0)+ISNULL(SaldoAlJul,0)+ISNULL(SaldoAlAgo,0)+
            ISNULL(SaldoAlSep,0)+ISNULL(SaldoAlOct,0)+ISNULL(SaldoAlNov,0)+ISNULL(SaldoAlDic,0)
   --BUG2924
  UPDATE #Consolidado
  SET Porcentaje=Saldo/(SELECT CASE 
                            WHEN ISNULL(csr.SaldoAlEne,0)+ISNULL(csr.SaldoAlFeb,0)+ISNULL(csr.SaldoAlMar,0)+
                                 ISNULL(csr.SaldoAlAbr,0)+ISNULL(csr.SaldoAlMay,0)+ISNULL(csr.SaldoAlJun,0)+
                                 ISNULL(csr.SaldoAlJul,0)+ISNULL(csr.SaldoAlAgo,0)+ISNULL(csr.SaldoAlSep,0)+
                                 ISNULL(csr.SaldoAlOct,0)+ISNULL(csr.SaldoAlNov,0)+ISNULL(csr.SaldoAlDic,0)=0
                              THEN 1 
                              ELSE ISNULL(csr.SaldoAlEne,0)+ISNULL(csr.SaldoAlFeb,0)+ISNULL(csr.SaldoAlMar,0)+
                                 ISNULL(csr.SaldoAlAbr,0)+ISNULL(csr.SaldoAlMay,0)+ISNULL(csr.SaldoAlJun,0)+
                                 ISNULL(csr.SaldoAlJul,0)+ISNULL(csr.SaldoAlAgo,0)+ISNULL(csr.SaldoAlSep,0)+
                                 ISNULL(csr.SaldoAlOct,0)+ISNULL(csr.SaldoAlNov,0)+ISNULL(csr.SaldoAlDic,0) 
                          END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')

--ISNULL(SaldoAlEne,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlEne,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlEne,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlFeb,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlFeb,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlFeb,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlMar,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlMar,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlMar,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlAbr,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlAbr,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlAbr,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlMay,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlMay,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlMay,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlJun,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlJun,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlJun,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlJul,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlJul,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlJul,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlAgo,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlAgo,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlAgo,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlSep,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlSep,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlSep,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlOct,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlOct,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlOct,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlNov,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlNov,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlNov,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')+
--		         ISNULL(SaldoAlDic,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlDic,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlDic,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S')

  SELECT RID, Orden,
         CentroCostos, Clase, SubClase, Rama, RamaDesc, RamaEsAcreedora, Cuenta, Descripcion, EsAcreedora,
     	 ISNULL(Saldo,0) Saldo, ISNULL(SaldoAlEne,0) SaldoAlEne, ISNULL(SaldoAlFeb,0) SaldoAlFeb, ISNULL(SaldoAlMar,0) SaldoAlMar,
		 ISNULL(SaldoAlAbr,0) SaldoAlAbr, ISNULL(SaldoAlMay,0) SaldoAlMay,	ISNULL(SaldoAlJun,0) SaldoAlJun,
		 ISNULL(SaldoAlJul,0) SaldoAlJul, ISNULL(SaldoAlAgo,0) SaldoAlAgo,	ISNULL(SaldoAlSep,0) SaldoAlSep,
		 ISNULL(SaldoAlOct,0) SaldoAlOct, ISNULL(SaldoAlNov,0) SaldoAlNov,  ISNULL(SaldoAlDic,0) SaldoAlDic,
		 ISNULL(Ingresos,0) Ingresos, ISNULL(IngresosAlEne,0) IngresosAlEne, ISNULL(IngresosAlFeb,0) IngresosAlFeb,
		 ISNULL(IngresosAlMar,0) IngresosAlMar, ISNULL(IngresosAlAbr,0) IngresosAlAbr, 
		 ISNULL(IngresosAlMay,0) IngresosAlMay, ISNULL(IngresosAlJun,0) IngresosAlJun, 
		 ISNULL(IngresosAlJul,0) IngresosAlJul, ISNULL(IngresosAlAgo,0) IngresosAlAgo,
		 ISNULL(IngresosAlSep,0) IngresosAlSep, ISNULL(IngresosAlOct,0) IngresosAlOct, 
		 ISNULL(IngresosAlNov,0) IngresosAlNov,  ISNULL(IngresosAlDic,0) IngresosAlDic,  

         --BUG2924
		 ISNULL(Porcentaje,0) Porcentaje,		 
         --ISNULL(PorcentajeAlEne,0) PorcentajeAlEne,
         ISNULL(SaldoAlEne,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlEne,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlEne,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlEne,
		 --ISNULL(PorcentajeAlFeb,0) PorcentajeAlFeb, 
         ISNULL(SaldoAlFeb,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlFeb,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlFeb,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlFeb,
		 --ISNULL(PorcentajeAlMar,0) PorcentajeAlMar, 
         ISNULL(SaldoAlMar,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlMar,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlMar,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlMar,
		 --ISNULL(PorcentajeAlAbr,0) PorcentajeAlAbr,
         ISNULL(SaldoAlAbr,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlAbr,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlAbr,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlAbr,
		 --ISNULL(PorcentajeAlMay,0) PorcentajeAlMay, 
         ISNULL(SaldoAlMay,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlMay,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlMay,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlMay,
		 
         --ISNULL(PorcentajeAlJun,0) PorcentajeAlJun, 
		 --ISNULL(SaldoAlJun,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlJun,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlJun,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase=c.Clase AND csr.SubClase=c.SubClase AND csr.Rama=c.Rama) PorcentajeAlJun,
         ISNULL(SaldoAlJun,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlJun,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlJun,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlJun,
		 
         --ISNULL(PorcentajeAlJul,0) PorcentajeAlJul,
         ISNULL(SaldoAlJul,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlJul,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlJul,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlJul,   
		 --ISNULL(PorcentajeAlAgo,0) PorcentajeAlAgo, 
         ISNULL(SaldoAlAgo,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlAgo,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlAgo,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlAgo,
		 --ISNULL(PorcentajeAlSep,0) PorcentajeAlSep, 
         ISNULL(SaldoAlSep,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlSep,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlSep,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlSep,
		 --ISNULL(PorcentajeAlOct,0) PorcentajeAlOct,
         ISNULL(SaldoAlOct,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlOct,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlOct,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlOct,
		 --ISNULL(PorcentajeAlNov,0) PorcentajeAlNov, 
         ISNULL(SaldoAlNov,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlNov,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlNov,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlNov,
		 --ISNULL(PorcentajeAlDic,0) PorcentajeAlDic
         ISNULL(SaldoAlDic,0)/(SELECT CASE WHEN ISNULL(csr.SaldoAlDic,0)=0 THEN 1 ELSE ISNULL(csr.SaldoAlDic,0) END  FROM #ConsolidadoAcumClaseSubClaseRama csr WHERE csr.Clase='Utilidad Bruta' AND csr.SubClase='Ventas' AND csr.Rama='S') PorcentajeAlDic
  FROM #Consolidado c
  ORDER BY Orden, Clase, Rama, Cuenta, CentroCostos	 

  RETURN
END
GO
--REQ25875
/**************** spVerContBalanzaAnualRS ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanzaAnualRS') and type = 'P') drop procedure dbo.spVerContBalanzaAnualRS
GO             
SET ANSI_NULLS OFF
Go
CREATE PROCEDURE spVerContBalanzaAnualRS
		    @Empresa		varchar(5),
		    @Estacion		int,
		    @Ejercicio		int,
--		    @PeriodoD		int,
--		    @PeriodoA		int,
--		    @ConMovs		varchar(20) = 'NO',
                    @Tipo		varchar(20) = 'MAYOR',
		    @CuentaD		varchar(20) = NULL,
                    @CuentaA		varchar(20) = NULL,
                    @CentroCostos       varchar(50) = NULL,
		    @Moneda		varchar(10) = NULL,
                    @Controladora	varchar(5)  = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL

		    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Cuenta		varchar(20),
    @Periodo		int,
    @Cargos		float,
    @Abonos		float,
    @CargosEne		float,
    @AbonosEne		float,
    @CargosFeb		float,
    @AbonosFeb		float,
    @CargosMar		float,
    @AbonosMar		float,
    @CargosAbr		float,
    @AbonosAbr		float,
    @CargosMay		float,
    @AbonosMay		float,
    @CargosJun		float,
    @AbonosJun		float,
    @CargosJul		float,
    @AbonosJul		float,
    @CargosAgo		float,
    @AbonosAgo		float,
    @CargosSep		float,
    @AbonosSep		float,
    @CargosOct		float,
    @AbonosOct		float,
    @CargosNov		float,
    @AbonosNov		float,
    @CargosDic		float,
    @AbonosDic		float,
    @Rama   		varchar(5),
--    @Cuenta 		varchar(20),
    @CuentaRangoD	varchar(20),
    @CuentaRangoA	varchar(20),
    @Tipos  		varchar(100),
    @Inicio 		money

  SELECT @Rama = 'CONT', --@ConMovs = NULLIF(RTRIM(UPPER(@ConMovs)), ''), 
         @Tipo = NULLIF(RTRIM(UPPER(@Tipo)), ''),
         @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
  IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
  IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
  IF UPPER(@Empresa) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Empresa = NULL
  IF UPPER(@Controladora) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Controladora = NULL
  EXEC spContEmpresaGrupo @Empresa OUTPUT, @Controladora OUTPUT
  IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
  IF @UEN = 0 SELECT @UEN = NULL
  IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
  IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
  IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

  IF @CentroCostos='Sin CC' SELECT @CentroCostos=''

  DELETE VerContBalanzaAnual WHERE Estacion = @Estacion
 
  IF @Tipo = 'MAYOR' 
     BEGIN     
     IF @CentroCostos = NULL
        BEGIN
	     DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) 
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
     ELSE
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END   

  IF @Tipo = 'SUBCUENTA'  
      BEGIN
      IF @CentroCostos = NULL
        BEGIN
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
      ELSE
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END
   IF @Tipo = 'AUXILIAR'   
      BEGIN
      IF @CentroCostos= NULL
        BEGIN   
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
      ELSE 
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
      END

  OPEN ContBalanzaAnual 
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
   WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
   BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN  
 
      SELECT @Inicio=Null,
	     @CargosEne = Null, @AbonosEne = Null, 
             @CargosFeb = Null, @AbonosFeb = Null, 
             @CargosMar = Null, @AbonosMar = Null, 
             @CargosAbr = Null, @AbonosAbr = Null,
             @CargosMay = Null, @AbonosMay = Null, 
             @CargosJun = Null, @AbonosJun = Null, 
             @CargosJul = Null, @AbonosJul = Null, 
             @CargosAgo = Null, @AbonosAgo = Null, 
             @CargosSep = Null, @AbonosSep = Null, 
             @CargosOct = Null, @AbonosOct = Null, 
             @CargosNov = Null, @AbonosNov = Null, 
             @CargosDic = Null, @AbonosDic = Null

      IF @Periodo = 0 	SELECT @Inicio = ( @Cargos - @Abonos )
      IF @Periodo = 1 	SELECT @CargosEne = @Cargos, @AbonosEne = @Abonos 
      IF @Periodo = 2 	SELECT @CargosFeb = @Cargos, @AbonosFeb = @Abonos 
      IF @Periodo = 3	SELECT @CargosMar = @Cargos, @AbonosMar = @Abonos 
      IF @Periodo = 4 	SELECT @CargosAbr = @Cargos, @AbonosAbr = @Abonos 
      IF @Periodo = 5 	SELECT @CargosMay = @Cargos, @AbonosMay = @Abonos 
      IF @Periodo = 6 	SELECT @CargosJun = @Cargos, @AbonosJun = @Abonos 
      IF @Periodo = 7 	SELECT @CargosJul = @Cargos, @AbonosJul = @Abonos 
      IF @Periodo = 8 	SELECT @CargosAgo = @Cargos, @AbonosAgo = @Abonos 
      IF @Periodo = 9 	SELECT @CargosSep = @Cargos, @AbonosSep = @Abonos 
      IF @Periodo = 10  SELECT @CargosOct = @Cargos, @AbonosOct = @Abonos 
      IF @Periodo = 11  SELECT @CargosNov = @Cargos, @AbonosNov = @Abonos 
      IF @Periodo = 12  SELECT @CargosDic = @Cargos, @AbonosDic = @Abonos 

      UPDATE VerContBalanzaAnual
         SET Inicio    = ISNULL(Inicio,0.0)    + ISNULL(@Inicio,0.0),
	     CargosEne = ISNULL(CargosEne,0.0) + ISNULL(@CargosEne,0.0),
             AbonosEne = ISNULL(AbonosEne,0.0) + ISNULL(@AbonosEne,0.0),
             CargosFeb = ISNULL(CargosFeb,0.0) + ISNULL(@CargosFeb,0.0),
             AbonosFeb = ISNULL(AbonosFeb,0.0) + ISNULL(@AbonosFeb,0.0),
             CargosMar = ISNULL(CargosMar,0.0) + ISNULL(@CargosMar,0.0),
             AbonosMar = ISNULL(AbonosMar,0.0) + ISNULL(@AbonosMar,0.0),
             CargosAbr = ISNULL(CargosAbr,0.0) + ISNULL(@CargosAbr,0.0),
             AbonosAbr = ISNULL(AbonosAbr,0.0) + ISNULL(@AbonosAbr,0.0),
             CargosMay = ISNULL(CargosMay,0.0) + ISNULL(@CargosMay,0.0),
             AbonosMay = ISNULL(AbonosMay,0.0) + ISNULL(@AbonosMay,0.0),
             CargosJun = ISNULL(CargosJun,0.0) + ISNULL(@CargosJun,0.0),
             AbonosJun = ISNULL(AbonosJun,0.0) + ISNULL(@AbonosJun,0.0),
             CargosJul = ISNULL(CargosJul,0.0) + ISNULL(@CargosJul,0.0),
             AbonosJul = ISNULL(AbonosJul,0.0) + ISNULL(@AbonosJul,0.0),
             CargosAgo = ISNULL(CargosAgo,0.0) + ISNULL(@CargosAgo,0.0),
             AbonosAgo = ISNULL(AbonosAgo,0.0) + ISNULL(@AbonosAgo,0.0),
             CargosSep = ISNULL(CargosSep,0.0) + ISNULL(@CargosSep,0.0),
             AbonosSep = ISNULL(AbonosSep,0.0) + ISNULL(@AbonosSep,0.0),
             CargosOct = ISNULL(CargosOct,0.0) + ISNULL(@CargosOct,0.0),
             AbonosOct = ISNULL(AbonosOct,0.0) + ISNULL(@AbonosOct,0.0),
             CargosNov = ISNULL(CargosNov,0.0) + ISNULL(@CargosNov,0.0),
             AbonosNov = ISNULL(AbonosNov,0.0) + ISNULL(@AbonosNov,0.0),
             CargosDic = ISNULL(CargosDic,0.0) + ISNULL(@CargosDic,0.0),
             AbonosDic = ISNULL(AbonosDic,0.0) + ISNULL(@AbonosDic,0.0)
       WHERE Estacion = @Estacion AND Cuenta = @Cuenta

     IF @@ROWCOUNT = 0
     INSERT VerContBalanzaAnual (Estacion, Cuenta, Tipo, Inicio, CargosEne, AbonosEne, CargosFeb, AbonosFeb, CargosMar, AbonosMar, CargosAbr, AbonosAbr, CargosMay, AbonosMay, CargosJun, AbonosJun, CargosJul, AbonosJul, CargosAgo, AbonosAgo, CargosSep, AbonosSep, CargosOct, AbonosOct, CargosNov, AbonosNov, CargosDic, AbonosDic)
                      VALUES (@Estacion,@Cuenta,@Tipo,@Inicio,@CargosEne,@AbonosEne,@CargosFeb,@AbonosFeb,@CargosMar,@AbonosMar,@CargosAbr,@AbonosAbr,@CargosMay,@AbonosMay,@CargosJun,@AbonosJun,@CargosJul,@AbonosJul,@CargosAgo,@AbonosAgo,@CargosSep,@AbonosSep,@CargosOct,@AbonosOct,@CargosNov,@AbonosNov,@CargosDic,@AbonosDic)

   END
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
  END
  CLOSE ContBalanzaAnual
  DEALLOCATE ContBalanzaAnual
  RETURN
END
GO
--BUG2923
/**************** spVerContBalanzaAnualRSCC ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContBalanzaAnualRSCC') and type = 'P') drop procedure dbo.spVerContBalanzaAnualRSCC
GO             
SET ANSI_NULLS OFF
Go
CREATE PROCEDURE spVerContBalanzaAnualRSCC
		    @Empresa		varchar(5),
		    @Estacion		int,
		    @Ejercicio		int,
--		    @PeriodoD		int,
--		    @PeriodoA		int,
--		    @ConMovs		varchar(20) = 'NO',
                    @Tipo		varchar(20) = 'MAYOR',
		    @CuentaD		varchar(20) = NULL,
                    @CuentaA		varchar(20) = NULL,
                    @CentroCostos       varchar(50) = NULL,
		    @Moneda		varchar(10) = NULL,
                    @Controladora	varchar(5)  = NULL,
		    @UEN		int	    = NULL,
		    @Proyecto		varchar(50) = NULL,
		    @CentroCostos2	varchar(50) = NULL,
		    @CentroCostos3	varchar(50) = NULL

		    
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Cuenta		varchar(20),
    @Periodo		int,
    @Cargos		float,
    @Abonos		float,
    @CargosEne		float,
    @AbonosEne		float,
    @CargosFeb		float,
    @AbonosFeb		float,
    @CargosMar		float,
    @AbonosMar		float,
    @CargosAbr		float,
    @AbonosAbr		float,
    @CargosMay		float,
    @AbonosMay		float,
    @CargosJun		float,
    @AbonosJun		float,
    @CargosJul		float,
    @AbonosJul		float,
    @CargosAgo		float,
    @AbonosAgo		float,
    @CargosSep		float,
    @AbonosSep		float,
    @CargosOct		float,
    @AbonosOct		float,
    @CargosNov		float,
    @AbonosNov		float,
    @CargosDic		float,
    @AbonosDic		float,
    @Rama   		varchar(5),
--    @Cuenta 		varchar(20),
    @CuentaRangoD	varchar(20),
    @CuentaRangoA	varchar(20),
    @Tipos  		varchar(100),
    @Inicio 		money

  SELECT @Rama = 'CONT', --@ConMovs = NULLIF(RTRIM(UPPER(@ConMovs)), ''), 
         @Tipo = NULLIF(RTRIM(UPPER(@Tipo)), ''),
         @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')

  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @CuentaRangoD = NULLIF(RTRIM(@CuentaD), '0'), @CuentaRangoA = NULLIF(RTRIM(@CuentaA), '0')
  IF @CuentaRangoD IS NULL SELECT @CuentaRangoD = MIN(Cuenta) FROM Cta
  IF @CuentaRangoA IS NULL SELECT @CuentaRangoA = MAX(Cuenta) FROM Cta
  IF UPPER(@Empresa) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Empresa = NULL
  IF UPPER(@Controladora) 	  IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Controladora = NULL
  EXEC spContEmpresaGrupo @Empresa OUTPUT, @Controladora OUTPUT
  IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
  IF @UEN = 0 SELECT @UEN = NULL
  IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
  IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
  IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

  IF @CentroCostos='Sin CC' SELECT @CentroCostos=''

  DELETE VerContBalanzaAnual WHERE Estacion = @Estacion
 
--  IF @Tipo = 'MAYOR' 
--     BEGIN     
     IF @CentroCostos = NULL
        BEGIN
	     DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,'')) 
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.Moneda = @Moneda
        END
     ELSE
        DECLARE ContBalanzaAnual CURSOR FOR 
         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos 
           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
          WHERE a.Rama = @Rama 
            AND a.Ejercicio = @Ejercicio 
            AND a.Periodo BETWEEN 0 AND 12
            AND UPPER(c.Tipo) = @Tipo 
            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
            AND a.SubCuenta = @CentroCostos
            AND a.Moneda = @Moneda
--      END   

--  IF @Tipo = 'SUBCUENTA'  
--      BEGIN
--      IF @CentroCostos = NULL
--        BEGIN
--        DECLARE ContBalanzaAnual CURSOR FOR 
--         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
--           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
--                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
--          WHERE a.Rama = @Rama 
--            AND a.Ejercicio = @Ejercicio 
--            AND a.Periodo BETWEEN 0 AND 12
--            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
--            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
--            AND a.Moneda = @Moneda
--        END
--      ELSE
--        DECLARE ContBalanzaAnual CURSOR FOR 
--         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
--           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
--                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
--          WHERE a.Rama = @Rama 
--            AND a.Ejercicio = @Ejercicio 
--            AND a.Periodo BETWEEN 0 AND 12
--            AND UPPER(c.Tipo) IN ('MAYOR','SUBCUENTA') 
--            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
--            AND a.SubCuenta = @CentroCostos
--            AND a.Moneda = @Moneda
--      END
--   IF @Tipo = 'AUXILIAR'   
--      BEGIN
--      IF @CentroCostos= NULL
--        BEGIN   
--        DECLARE ContBalanzaAnual CURSOR FOR 
--         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
--           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
--                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
--          WHERE a.Rama = @Rama 
--            AND a.Ejercicio = @Ejercicio 
--            AND a.Periodo BETWEEN 0 AND 12
--            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
--            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
--            AND a.Moneda = @Moneda
--        END
--      ELSE 
--        DECLARE ContBalanzaAnual CURSOR FOR 
--         SELECT c.Cuenta, c.Tipo, a.Periodo, a.Cargos, a.Abonos
--           FROM Acum a JOIN Empresa e ON e.Empresa = a.Empresa AND e.Empresa = ISNULL(@Empresa, e.Empresa) AND ISNULL(e.Controladora,'') = ISNULL(@Controladora, ISNULL(e.Controladora,''))
--                       LEFT OUTER JOIN Cta c ON c.Cuenta = a.Cuenta
--          WHERE a.Rama = @Rama 
--            AND a.Ejercicio = @Ejercicio 
--            AND a.Periodo BETWEEN 0 AND 12
--            AND UPPER(c.Tipo) IN ('MAYOR', 'SUBCUENTA', 'AUXILIAR') 
--            AND c.Cuenta BETWEEN @CuentaRangoD AND @CuentaRangoA
--            AND a.SubCuenta = @CentroCostos
--            AND a.Moneda = @Moneda
--      END

  OPEN ContBalanzaAnual 
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
   WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
   BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN  
 
      SELECT @Inicio=Null,
	     @CargosEne = Null, @AbonosEne = Null, 
             @CargosFeb = Null, @AbonosFeb = Null, 
             @CargosMar = Null, @AbonosMar = Null, 
             @CargosAbr = Null, @AbonosAbr = Null,
             @CargosMay = Null, @AbonosMay = Null, 
             @CargosJun = Null, @AbonosJun = Null, 
             @CargosJul = Null, @AbonosJul = Null, 
             @CargosAgo = Null, @AbonosAgo = Null, 
             @CargosSep = Null, @AbonosSep = Null, 
             @CargosOct = Null, @AbonosOct = Null, 
             @CargosNov = Null, @AbonosNov = Null, 
             @CargosDic = Null, @AbonosDic = Null

      IF @Periodo = 0 	SELECT @Inicio = ( @Cargos - @Abonos )
      IF @Periodo = 1 	SELECT @CargosEne = @Cargos, @AbonosEne = @Abonos 
      IF @Periodo = 2 	SELECT @CargosFeb = @Cargos, @AbonosFeb = @Abonos 
      IF @Periodo = 3	SELECT @CargosMar = @Cargos, @AbonosMar = @Abonos 
      IF @Periodo = 4 	SELECT @CargosAbr = @Cargos, @AbonosAbr = @Abonos 
      IF @Periodo = 5 	SELECT @CargosMay = @Cargos, @AbonosMay = @Abonos 
      IF @Periodo = 6 	SELECT @CargosJun = @Cargos, @AbonosJun = @Abonos 
      IF @Periodo = 7 	SELECT @CargosJul = @Cargos, @AbonosJul = @Abonos 
      IF @Periodo = 8 	SELECT @CargosAgo = @Cargos, @AbonosAgo = @Abonos 
      IF @Periodo = 9 	SELECT @CargosSep = @Cargos, @AbonosSep = @Abonos 
      IF @Periodo = 10  SELECT @CargosOct = @Cargos, @AbonosOct = @Abonos 
      IF @Periodo = 11  SELECT @CargosNov = @Cargos, @AbonosNov = @Abonos 
      IF @Periodo = 12  SELECT @CargosDic = @Cargos, @AbonosDic = @Abonos 

      UPDATE VerContBalanzaAnual
         SET Inicio    = ISNULL(Inicio,0.0)    + ISNULL(@Inicio,0.0),
	     CargosEne = ISNULL(CargosEne,0.0) + ISNULL(@CargosEne,0.0),
             AbonosEne = ISNULL(AbonosEne,0.0) + ISNULL(@AbonosEne,0.0),
             CargosFeb = ISNULL(CargosFeb,0.0) + ISNULL(@CargosFeb,0.0),
             AbonosFeb = ISNULL(AbonosFeb,0.0) + ISNULL(@AbonosFeb,0.0),
             CargosMar = ISNULL(CargosMar,0.0) + ISNULL(@CargosMar,0.0),
             AbonosMar = ISNULL(AbonosMar,0.0) + ISNULL(@AbonosMar,0.0),
             CargosAbr = ISNULL(CargosAbr,0.0) + ISNULL(@CargosAbr,0.0),
             AbonosAbr = ISNULL(AbonosAbr,0.0) + ISNULL(@AbonosAbr,0.0),
             CargosMay = ISNULL(CargosMay,0.0) + ISNULL(@CargosMay,0.0),
             AbonosMay = ISNULL(AbonosMay,0.0) + ISNULL(@AbonosMay,0.0),
             CargosJun = ISNULL(CargosJun,0.0) + ISNULL(@CargosJun,0.0),
             AbonosJun = ISNULL(AbonosJun,0.0) + ISNULL(@AbonosJun,0.0),
             CargosJul = ISNULL(CargosJul,0.0) + ISNULL(@CargosJul,0.0),
             AbonosJul = ISNULL(AbonosJul,0.0) + ISNULL(@AbonosJul,0.0),
             CargosAgo = ISNULL(CargosAgo,0.0) + ISNULL(@CargosAgo,0.0),
             AbonosAgo = ISNULL(AbonosAgo,0.0) + ISNULL(@AbonosAgo,0.0),
             CargosSep = ISNULL(CargosSep,0.0) + ISNULL(@CargosSep,0.0),
             AbonosSep = ISNULL(AbonosSep,0.0) + ISNULL(@AbonosSep,0.0),
             CargosOct = ISNULL(CargosOct,0.0) + ISNULL(@CargosOct,0.0),
             AbonosOct = ISNULL(AbonosOct,0.0) + ISNULL(@AbonosOct,0.0),
             CargosNov = ISNULL(CargosNov,0.0) + ISNULL(@CargosNov,0.0),
             AbonosNov = ISNULL(AbonosNov,0.0) + ISNULL(@AbonosNov,0.0),
             CargosDic = ISNULL(CargosDic,0.0) + ISNULL(@CargosDic,0.0),
             AbonosDic = ISNULL(AbonosDic,0.0) + ISNULL(@AbonosDic,0.0)
       WHERE Estacion = @Estacion AND Cuenta = @Cuenta

     IF @@ROWCOUNT = 0
     INSERT VerContBalanzaAnual (Estacion, Cuenta, Tipo, Inicio, CargosEne, AbonosEne, CargosFeb, AbonosFeb, CargosMar, AbonosMar, CargosAbr, AbonosAbr, CargosMay, AbonosMay, CargosJun, AbonosJun, CargosJul, AbonosJul, CargosAgo, AbonosAgo, CargosSep, AbonosSep, CargosOct, AbonosOct, CargosNov, AbonosNov, CargosDic, AbonosDic)
                      VALUES (@Estacion,@Cuenta,@Tipo,@Inicio,@CargosEne,@AbonosEne,@CargosFeb,@AbonosFeb,@CargosMar,@AbonosMar,@CargosAbr,@AbonosAbr,@CargosMay,@AbonosMay,@CargosJun,@AbonosJun,@CargosJul,@AbonosJul,@CargosAgo,@AbonosAgo,@CargosSep,@AbonosSep,@CargosOct,@AbonosOct,@CargosNov,@AbonosNov,@CargosDic,@AbonosDic)

   END
   FETCH NEXT FROM ContBalanzaAnual INTO @Cuenta, @Tipo, @Periodo, @Cargos, @Abonos
  END
  CLOSE ContBalanzaAnual
  DEALLOCATE ContBalanzaAnual
  RETURN
END
GO
if exists (select * from sysobjects where id = object_id('dbo.spRSVerContBalanzaAnualCC') and type = 'P') drop procedure dbo.spRSVerContBalanzaAnualCC
GO
CREATE PROCEDURE spRSVerContBalanzaAnualCC
		    @Empresa		varchar(5),
		    @SEjercicio		varchar(4),
			@Tipo           varchar(15),
			@CentroCostos	varchar(Max) = NULL,
		    @Moneda			varchar(10) = NULL,
		    @SUEN			varchar(10)	= NULL,
			@Proyecto		varchar(50)= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Ejercicio		int,
		  @UEN				int,
 		  @CentroCostosAux		varchar(20),
		  @CentroCostosAuxAnt	varchar(20),
		  @CentroCostosMin		varchar(20),
		  @CentroCostosMax	    varchar(20)


  CREATE TABLE #Temp(
     --ID					int			IDENTITY(1,1) NOT NULL,
     --Clase				varchar(20)	COLLATE Database_Default NULL,
     --SubClase			varchar(20)	COLLATE Database_Default NULL,
     Rama				varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc			varchar(100)COLLATE Database_Default NULL,
     --RamaEsAcreedora	bit			NOT NULL DEFAULT 0,
	 CentroCostos       varchar(20) COLLATE Database_Default NULL,
	 DescripcionCC      varchar(100)COLLATE Database_Default NULL,
     Cuenta				varchar(20)	COLLATE Database_Default NULL,
     Descripcion		varchar(100)COLLATE Database_Default NULL,
	 Tipo               varchar(15) COLLATE Database_Default NULL,
     --EsAcreedora		bit			NOT NULL DEFAULT 0,
	 Inicio             money		NULL,
	 CargosEne          money		NULL,
	 AbonosEne          money		NULL,
     CargosFeb			money		NULL,
     AbonosFeb			money		NULL,
	 CargosMar			money		NULL,
     AbonosMar			money		NULL,
	 CargosAbr			money		NULL,
     AbonosAbr			money		NULL,
	 CargosMay			money		NULL,
     AbonosMay			money		NULL,
	 CargosJun			money		NULL,
     AbonosJun			money		NULL,
	 CargosJul			money		NULL,
     AbonosJul			money		NULL,
	 CargosAgo			money		NULL,
     AbonosAgo			money		NULL,
	 CargosSep			money		NULL,
     AbonosSep			money		NULL,
	 CargosOct			money		NULL,
     AbonosOct			money		NULL,
	 CargosNov			money		NULL,
     AbonosNov			money		NULL,
	 CargosDic			money		NULL,
     AbonosDic			money		NULL,
	 Final              money       NULL   
  )

  IF @Moneda='' SELECT @Moneda = NULL
  IF @SUEN='' SELECT @SUEN = NULL
  IF @Proyecto='' SELECT @Proyecto = NULL
  IF @CentroCostos2='' SELECT @CentroCostos2 = NULL
  IF @CentroCostos3='' SELECT @CentroCostos3 = NULL

  SELECT @CentroCostosMin=Min(CentroCostos), @CentroCostosMax=Max(CentroCostos) FROM CentroCostos
		  	    
  SELECT @Ejercicio = CONVERT(int, @SEjercicio),
		 @UEN = CONVERT(int, @SUEN)

  CREATE TABLE #CentroCostos(CentroCostos varchar(20) COLLATE Database_Default )

  IF @CentroCostos='(Sin Desglose)' AND LEN(@CentroCostos)<=14 SELECT @CentroCostos = NULL --BUG2771
  IF @CentroCostos<>'(Sin Desglose)' AND LEN(@CentroCostos)>14 SELECT @CentroCostos = '(Todos)' --BUG2771
  --SELECT @CentroCostos, LEN(@CentroCostos)

  IF ISNULL(@CentroCostos,'') = ''
  BEGIN
	EXEC spVerContBalanzaAnualRSCC @Empresa, @@SPID, @Ejercicio, @Tipo, NULL, NULL, '', @Moneda, NULL, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3
	
	INSERT INTO #Temp --( 	       '',     Cuenta,     Descripcion,     Tipo, Inicio, CargosEne, AbonosEne, CargosFeb, AbonosFeb, CargosMar, AbonosMar, CargosAbr, AbonosAbr, CargosMay, AbonosMay, CargosJun, AbonosJun, CargosJul, AbonosJul, CargosAgo, AbonosAgo, CargosSep, AbonosSep, CargosOct, AbonosOct, CargosNov, AbonosNov, CargosDic, AbonosDic, Final)
	SELECT '', '', 'Global', 'Acumulado del Ejercicio' , Cta.Cuenta, Cta.Descripcion, Cta.Tipo, ISNULL(Inicio,0), ISNULL(CargosEne,0), ISNULL(AbonosEne,0), ISNULL(CargosFeb,0), ISNULL(AbonosFeb,0), ISNULL(CargosMar,0), ISNULL(AbonosMar,0), ISNULL(CargosAbr,0), ISNULL(AbonosAbr,0), ISNULL(CargosMay,0), ISNULL(AbonosMay,0), ISNULL(CargosJun,0), ISNULL(AbonosJun,0), ISNULL(CargosJul,0), ISNULL(AbonosJul,0), ISNULL(CargosAgo,0), ISNULL(AbonosAgo,0), ISNULL(CargosSep,0), ISNULL(AbonosSep,0), ISNULL(CargosOct,0), ISNULL(AbonosOct,0), ISNULL(CargosNov,0), ISNULL(AbonosNov,0), ISNULL(CargosDic,0), ISNULL(AbonosDic,0), NULL
	FROM VerContBalanzaAnual vcb
	LEFT OUTER JOIN Cta ON Cta.Cuenta=vcb.Cuenta
	WHERE Estacion=@@SPID
	
  	SELECT @CentroCostos = NULL
  END

  IF @CentroCostos LIKE '%(Todos)%'
  BEGIN
    INSERT INTO #CentroCostos SELECT CentroCostos FROM CentroCostos
	INSERT INTO #CentroCostos SELECT 'Sin CC'

	SELECT @CentroCostos = NULL
  END

  IF @CentroCostos IS NOT NULL
  BEGIN
   INSERT INTO #CentroCostos SELECT ValorTexto FROM dbo.fnParseaCadena(@CentroCostos, ',')
   DELETE FROM #CentroCostos WHERE CentroCostos='(Sin Desglose)'  --BUG2771
  END

  SELECT @CentroCostosAuxAnt = ''
  WHILE(1=1)
  BEGIN
	 SELECT @CentroCostosAux = MIN(CentroCostos)
      FROM #CentroCostos
     WHERE CentroCostos > @CentroCostosAuxAnt

    IF @CentroCostosAux IS NULL BREAK

    SELECT @CentroCostosAuxAnt = @CentroCostosAux 

    EXEC spVerContBalanzaAnualRSCC @Empresa, @@SPID, @Ejercicio, @Tipo, NULL, NULL,  @CentroCostosAux, @Moneda, NULL, @UEN, @Proyecto, @CentroCostos2, @CentroCostos3

	INSERT INTO #Temp --( 	       '',     Cuenta,     Descripcion,     Tipo, Inicio, CargosEne, AbonosEne, CargosFeb, AbonosFeb, CargosMar, AbonosMar, CargosAbr, AbonosAbr, CargosMay, AbonosMay, CargosJun, AbonosJun, CargosJul, AbonosJul, CargosAgo, AbonosAgo, CargosSep, AbonosSep, CargosOct, AbonosOct, CargosNov, AbonosNov, CargosDic, AbonosDic, Final)
	SELECT '', '', @CentroCostosAux, Cc.Descripcion, Cta.Cuenta, Cta.Descripcion, Cta.Tipo, ISNULL(Inicio,0), ISNULL(CargosEne,0), ISNULL(AbonosEne,0), ISNULL(CargosFeb,0), ISNULL(AbonosFeb,0), ISNULL(CargosMar,0), ISNULL(AbonosMar,0), ISNULL(CargosAbr,0), ISNULL(AbonosAbr,0), ISNULL(CargosMay,0), ISNULL(AbonosMay,0), ISNULL(CargosJun,0), ISNULL(AbonosJun,0), ISNULL(CargosJul,0), ISNULL(AbonosJul,0), ISNULL(CargosAgo,0), ISNULL(AbonosAgo,0), ISNULL(CargosSep,0), ISNULL(AbonosSep,0), ISNULL(CargosOct,0), ISNULL(AbonosOct,0), ISNULL(CargosNov,0), ISNULL(AbonosNov,0), ISNULL(CargosDic,0), ISNULL(AbonosDic,0), NULL
	FROM VerContBalanzaAnual vcb
	LEFT OUTER JOIN Cta ON Cta.Cuenta=vcb.Cuenta
	LEFT OUTER JOIN CentroCostos Cc ON Cc.CentroCostos=@CentroCostosAux
	WHERE Estacion=@@SPID

  END

  UPDATE #Temp
  ---Inicio+Cargos-Abonos
  SET Final=ISNULL(Inicio+(CargosEne+CargosFeb+CargosMar+CargosAbr+CargosMay+CargosJun+CargosJul+CargosAgo+CargosSep+CargosOct+CargosNov+CargosDic)-(AbonosEne+AbonosFeb+AbonosMar+AbonosAbr+AbonosMay+AbonosJun+AbonosJul+AbonosAgo+AbonosSep+AbonosOct+AbonosNov+AbonosDic),0)

  SELECT * FROM #Temp ORDER BY Cuenta, CentroCostos

  RETURN
END
GO
--REQ25979
/******************************* spRSFlujoEfectivo *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spRSFlujoEfectivo') and type = 'P') drop procedure dbo.spRSFlujoEfectivo
GO             
CREATE PROCEDURE spRSFlujoEfectivo
		
		 @Empresa		varchar(10),
		 @Sucursal	    int,  
		 @CtaDineroD	varchar(10),
         @CtaDineroA    varchar(10),		
		 @Moneda		varchar(10),
		 @FechaD        datetime,
		 @FechaA        datetime

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @EstacionTrabajo		    int,
  @InfoUso					varchar(20),
  @InfoMov					varchar(20),
  @InfoNivel				varchar(20),
  
  @InfoTitulo				varchar(100),
  @InfoUsuario				varchar(10),
  @MonedaInicial			varchar(10),
  @CuentaInicial			varchar(10),
  @MovInicial				varchar(20),    
  @ID						int,

  @Cuenta					varchar(10),
  @Fecha					datetime,
  @Cargos					float,
  @Abonos					float,
  @CargosMC					float,
  @AbonosMC					float,
  @Saldo					float,
  @SaldoMC					float,
  @Mov						varchar(20),
  @MovTotalCargos			float,
  @MovTotalAbonos			float,
  @MovTotalCargosMC			float,
  @MovTotalAbonosMC			float,
  @ContMoneda				varchar(10),
  @InformeGraficarTipo		varchar(30),
  @InformeGraficarCantidad	int,
  @EmpresaNombre			varchar(100),
  @Positivo					integer,
  @VerGraficaDetalle		bit
  
  SELECT @EstacionTrabajo=@@SPID

  SELECT @InfoUso='(Todos)', @InfoMov='(Todos)', @InfoNivel=NULL

  SELECT @InfoUso    = CASE WHEN @InfoUso IN( '(Todos)', '') THEN NULL ELSE @InfoUso END,    
         @InfoMov    = CASE WHEN @InfoMov IN( '(Todos)', '') THEN NULL ELSE @InfoMov END,    
         @InfoNivel  =   ISNULL(@InfoNivel,'Desglosado'),
         @InfoTitulo = NULL,
		 @Moneda     = CASE WHEN @Moneda IN( '(Todas)', '') THEN NULL ELSE @Moneda END,
		 @Empresa     = CASE WHEN @Empresa IN( '(Todas)', '') THEN NULL ELSE @Empresa END
 
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
    
  DECLARE @Datos TABLE
  (
   Estacion					int NOT NULL,
   ID						int identity(1,1) NOT NULL,
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   Descripcion				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Tipo						varchar(20) COLLATE DATABASE_DEFAULT NULL,   
   Uso						varchar(20) COLLATE DATABASE_DEFAULT NULL, 
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,
   TipoCambio				float NULL,
   Beneficiario				varchar(100) COLLATE DATABASE_DEFAULT NULL,
   Fecha					datetime NULL,
   Movimiento				varchar(50) COLLATE DATABASE_DEFAULT NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   CargosMC					float NULL,
   AbonosMC					float NULL,   
   SaldoMC					float NULL,      
   EsCancelacion			bit NULL DEFAULT 0,
   Grafica					int NULL DEFAULT 0,
   GraficaArgumento			varchar(20) COLLATE DATABASE_DEFAULT NULL,
   GraficaValor1			float,
   GraficaValor2			float,
   GraficaValor3			float,
   GraficaValor4			float,   
   GraficaPositivo			integer NULL DEFAULT 0,
   Titulo					varchar(50) COLLATE DATABASE_DEFAULT NULL,
   ContMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroEmpresa			varchar(100) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroD			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroCtaDineroA			varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroFechaD				datetime NULL,
   FiltroFechaA				datetime NULL,
   FiltroUso				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMov				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroNivel				varchar(20) COLLATE DATABASE_DEFAULT NULL,
   FiltroMoneda				varchar(10) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarTipo		varchar(30) COLLATE DATABASE_DEFAULT NULL,
   FiltroGraficarCantidad	int NULL
  )    

  DECLARE @DatosDin TABLE
  (
   Modulo                   varchar(5),
   ModuloNombre             varchar(50),
   CtaDinero				varchar(10) COLLATE DATABASE_DEFAULT NULL,   
   NumeroCta				varchar(100) COLLATE DATABASE_DEFAULT NULL,   
   CtaDineroDescripcion		varchar(100) COLLATE DATABASE_DEFAULT NULL,
   ClienteProveedor         varchar(10) NULL, 
   Nombre                   varchar(100) NULL, 
   Mov      		        varchar (50) NULL, --COLLATE DATABASE_DEFAULT NULL, 
   MovID		            varchar (20) COLLATE DATABASE_DEFAULT NULL,   
   FechaEmision				datetime NULL,
   FechaVencimiento     	datetime NULL,
   Importe					float NULL,
   Cargos					float NULL,
   Abonos					float NULL,
   Saldo					float NULL,
   TotalClienteProveedor    float NULL, --PGC21042015
   Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL
  )    


  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),
    RTRIM(c.Descripcion),
    NULL,
    NULL,
    c.Moneda,
    NULL,
    NULL,
    DATEADD(day,-1,@FechaD),
    dbo.fnIdiomaTraducir(@InfoUsuario,'Saldo Inicial'),
    SUM(ISNULL(a.Cargo,0.0)),    
    SUM(ISNULL(a.Abono,0.0)),        
    NULL,
    SUM(ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0)),    
    SUM(ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0)),        
    NULL,
    0,
    0,
    @InfoTitulo,
    @ContMoneda,
    @EmpresaNombre,    
    @CtaDineroD,	
    @CtaDineroA,	
    @FechaD,		
    @FechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@Moneda,'(Todas)'),		    
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad
  FROM
    CtaDinero c 
	LEFT OUTER JOIN Auxiliar a ON a.Empresa = ISNULL(@Empresa,a.Empresa) AND a.Sucursal=ISNULL(@Sucursal,a.Sucursal) AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta 
	                             --AND a.Fecha < @FechaD AND a.Mov = ISNULL(@InfoMov,a.Mov) --BUG2911
								 AND a.Moneda = ISNULL(@Moneda,a.Moneda)
	LEFT OUTER JOIN Dinero d ON d.ID = a.ModuloID AND d.Empresa=a.Empresa AND d.Sucursal=a.Sucursal
 WHERE c.CtaDinero BETWEEN @CtaDineroD AND @CtaDineroA
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
 GROUP BY RTRIM(c.CtaDinero), RTRIM(c.NumeroCta), RTRIM(c.Descripcion), c.Moneda

  DELETE FROM @Datos WHERE ISNULL(Cargos,0.0) = 0.0 AND ISNULL(Abonos,0.0) = 0.0

  -- Movimientos Actuales
  INSERT @Datos (Estacion, CtaDinero, NumeroCta, Descripcion, Tipo, Uso, Moneda, TipoCambio, Beneficiario, Fecha, Movimiento, Cargos, Abonos, Saldo, CargosMC, AbonosMC, SaldoMC, EsCancelacion, Grafica, Titulo, GraficaArgumento, ContMoneda, FiltroEmpresa, FiltroCtaDineroD, FiltroCtaDineroA, FiltroFechaD, FiltroFechaA, FiltroUso, FiltroMov, FiltroNivel, FiltroMoneda, FiltroGraficarTipo, FiltroGraficarCantidad)
  SELECT
    @EstacionTrabajo,
    RTRIM(c.CtaDinero),
    RTRIM(c.NumeroCta),    
    RTRIM(c.Descripcion),
    c.Tipo,
    c.Uso,
    a.Moneda,
    a.TipoCambio,
    d.BeneficiarioNombre,
    a.Fecha,
    RTRIM(RTRIM(ISNULL(a.Mov,'')) + ' ' + RTRIM(ISNULL(a.MovID,''))),
    ISNULL(a.Cargo,0.0),    
    ISNULL(a.Abono,0.0),        
    NULL,
    ISNULL(a.Cargo,0.0)*ISNULL(a.TipoCambio,0),    
    ISNULL(a.Abono,0.0)*ISNULL(a.TipoCambio,0),        
    NULL,
    ISNULL(a.EsCancelacion,0),
    0,
    @InfoTitulo,
    RTRIM(ISNULL(a.Mov,'')),
    @ContMoneda,
    @EmpresaNombre,
    @CtaDineroD,	
    @CtaDineroA,	
    @FechaD,		
    @FechaA,		
    ISNULL(@InfoUso,'(Todos)'),		
    ISNULL(@InfoMov,'(Todos)'),		
    @InfoNivel,		
    ISNULL(@Moneda,'(Todas)'),
    ISNULL(@InformeGraficarTipo,'(Todos)'),		        
    @InformeGraficarCantidad    		        
  FROM
    CtaDinero c JOIN Auxiliar a 
    --ON a.Empresa = @Empresa AND a.Sucursal=@Sucursal AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d
    ON a.Empresa = ISNULL(@Empresa,a.Empresa) AND a.Sucursal=ISNULL(@Sucursal,a.Sucursal) AND a.Rama = 'DIN' AND c.CtaDinero = a.Cuenta JOIN Dinero d --BUG2935
    ON d.ID = a.ModuloID AND d.Empresa=a.Empresa AND d.Sucursal=a.Sucursal
 WHERE a.Empresa = @Empresa
   AND a.Cuenta BETWEEN @CtaDineroD AND @CtaDineroA
   --AND a.Fecha BETWEEN @FechaD AND @FechaA --BUG2911
   AND ISNULL(c.Uso,'') = ISNULL(@InfoUso,ISNULL(c.Uso,''))
   --AND a.Mov = ISNULL(@InfoMov,a.Mov) 
   AND a.Moneda = ISNULL(@Moneda,a.Moneda)   


  SELECT @MonedaInicial = '', @CuentaInicial = '', @Saldo = 0.0, @SaldoMC = 0.0
  DECLARE crDineroAux CURSOR FOR
   SELECT ID, Moneda, CtaDinero, Fecha, ISNULL(Cargos,0.0), ISNULL(Abonos,0.0), ISNULL(CargosMC,0.0), ISNULL(AbonosMC,0.0)  
     FROM @Datos
    ORDER BY CtaDinero, Moneda, Fecha

  OPEN crDineroAux
  FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Moneda <> @MonedaInicial OR @Cuenta <> @CuentaInicial
    BEGIN
      SET @Saldo = 0.0
      SET @SaldoMC = 0.0
      SET @MonedaInicial = @Moneda
      SET @CuentaInicial = @Cuenta
    END     

    UPDATE @Datos 
       SET 
       Saldo = @Saldo + (@Cargos - @Abonos), 
       SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
     WHERE ID = @ID

    SET @Saldo = @Saldo + (@Cargos - @Abonos)
    SET @SaldoMC = @SaldoMC + (@CargosMC - @AbonosMC)
        
    FETCH NEXT FROM crDineroAux INTO @ID, @Moneda, @Cuenta, @Fecha, @Cargos, @Abonos, @CargosMC, @AbonosMC
  END
  CLOSE crDineroAux
  DEALLOCATE crDineroAux
   
  -- SELECT 'DIN', 'Cuentas de Dinero', d.CtaDinero, cd.SaldoInicial, d.NumeroCta, d.CtaDinero+' - '+d.Descripcion, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SUM(d.Cargos) AS Cargos, SUM(d.Abonos) AS Abonos, SUM(d.Saldo)- CASE WHEN cd.Tipo='Caja' THEN ISNULL(cd.FondoFijo,0) ELSE ISNULL(cd.SaldoInicial,0) END AS Saldo, d.Moneda
  --FROM @Datos d, CtaDinero cd
  --WHERE cd.CtaDinero=d.CtaDinero
  --GROUP BY d.CtaDinero, d.NumeroCta, d.Descripcion, d.Moneda, cd.Tipo, cd.FondoFijo, cd.SaldoInicial
  
 INSERT INTO @DatosDin ( Modulo, ModuloNombre, CtaDinero, NumeroCta, CtaDineroDescripcion, ClienteProveedor, Nombre, Mov, MovID, FechaEmision, FechaVencimiento, Importe, Cargos, Abonos, Saldo, TotalClienteProveedor, Moneda)
 --DINERO
 SELECT 'DIN', 'Cuentas de Dinero', d.CtaDinero, d.NumeroCta, d.CtaDinero+' - '+d.Descripcion, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SUM(d.Cargos) AS Cargos, SUM(d.Abonos) AS Abonos, SUM(d.Saldo)- CASE WHEN cd.Tipo='Caja' THEN ISNULL(cd.FondoFijo,0) ELSE ISNULL(cd.SaldoInicial,0) END AS Saldo, NULL, d.Moneda --BUG2404 Preconfig
  FROM @Datos d, CtaDinero cd
  WHERE cd.CtaDinero=d.CtaDinero
  GROUP BY d.CtaDinero, d.NumeroCta, d.Descripcion, d.Moneda, cd.Tipo, cd.FondoFijo, cd.SaldoInicial
 UNION
 --Cxc
 SELECT 'CXC', 'Cuentas por Cobrar', 'CXC', NULL, 'CXC', Cxc.Cliente, Cxc.Cliente+' - '+Cte.Nombre, Cxc.Mov+' - '+ Cxc.MovID, Cxc.MovID, Cxc.FechaEmision, Cxc.Vencimiento,
        Sum(Cxc.Importe) as Importe, NULL, NULL, SUM(CASE WHEN mt.Clave IN ('CXC.A','CXC.FACX') THEN Cxc.Saldo*-1 ELSE Cxc.Saldo END), SUM(CASE WHEN mt.Clave IN ('CXC.A','CXC.FACX') THEN Cxc.Saldo*-1 ELSE Cxc.Saldo END), Cxc.Moneda
  FROM Cxc
	JOIN Cte on Cte.Cliente=Cxc.Cliente
    JOIN MovTipo Mt ON Mt.Modulo='CXC' AND Mt.Mov=Cxc.Mov
 WHERE Cxc.Empresa=ISNULL(@Empresa,Cxc.Empresa) AND Cxc.Sucursal=ISNULL(@Sucursal,Cxc.Sucursal)
   --AND a.Fecha BETWEEN @FechaD AND @FechaA
   AND Cxc.Vencimiento BETWEEN @FechaD AND @FechaA
   --AND Cxc.FechaEmision BETWEEN @FechaD AND @FechaA
   AND Cxc.Estatus='PENDIENTE'
   AND Cxc.Mov = ISNULL(@InfoMov,Cxc.Mov)
   AND Cxc.Moneda = ISNULL(@Moneda,Cxc.Moneda)
   AND mt.Clave IN ('CXC.F', 'CXC.NC', 'CXC.FA', 'CXC.A', 'CXC.FAC', 'CXC.D', 'CXC.CAP', 'CXC.C', 'CXC.NET', 'CXC.SD') --PGC21042015 --BUG2911
 GROUP BY Cxc.Cliente, Cte.Nombre, Cxc.Mov, Cxc.MovID, Cxc.FechaEmision, Cxc.Vencimiento, Cxc.Moneda
 UNION
 --Cxp
 SELECT 'CXP', 'Cuentas por Pagar', 'CXP', NULL, 'CXP', Cxp.Proveedor, Cxp.Proveedor+' - '+Prov.Nombre, Cxp.Mov+' - '+Cxp.MovID, Cxp.MovID, Cxp.FechaEmision, Cxp.Vencimiento,
        Sum(Cxp.Importe) as Importe, NULL, NULL, SUM(Cxp.Saldo), SUM(Cxp.Saldo), Cxp.Moneda
  FROM Cxp
	JOIN Prov on Prov.Proveedor=Cxp.Proveedor
    JOIN MovTipo Mt ON Mt.Modulo='CXP' AND Mt.Mov=Cxp.Mov
 WHERE Cxp.Empresa=ISNULL(@Empresa, Cxp.Empresa) AND Cxp.Sucursal=ISNULL(@Sucursal, Cxp.Sucursal)
   AND Cxp.Vencimiento BETWEEN @FechaD AND @FechaA
   --AND Cxp.FechaEmision BETWEEN @FechaD AND @FechaA
   AND Cxp.Estatus='PENDIENTE'
   AND Cxp.Mov = ISNULL(@InfoMov,Cxp.Mov)
   AND Cxp.Moneda = ISNULL(@Moneda, Cxp.Moneda)
   AND mt.Clave IN ('CXP.NC', 'CXP.CA', 'CXP.F', 'CXP.FAC', 'CXP.D', 'CXP.P', 'CXP.SCH', 'CXP.CAP')
 GROUP BY Cxp.Proveedor, Prov.Nombre, Cxp.Mov, Cxp.MovID, Cxp.FechaEmision, Cxp.Vencimiento, Cxp.Moneda
 	  
  SELECT * FROM @DatosDin ORDER BY Modulo DESC, ClienteProveedor, FechaEmision ASC
END
GO
--REQ1997 Preconfigurado
/**************** spRSRazonesFinancieras ****************/
if exists (select * from sysobjects where id = object_id('dbo.spRSRazonesFinancieras') and type = 'P') drop procedure dbo.spRSRazonesFinancieras
GO
--BUG2426
CREATE PROCEDURE spRSRazonesFinancieras
		@Empresa	 char(5),
		@Ejercicio	 int,
		@TipoPeriodo varchar(10)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
    @ID				int,
    @CtaActivo			char(20),
	@CtaActivoFijo		char(20),
	@CtaActivoDiferido	char(20),
    @CtaActivoD			char(20),
	@CtaActivoA			char(20),
    @CtaPasivo			char(20),
	@CtaPasivoLargoPlazo char(20),
	@CtaPasivoDiferido	char(20),
    @CtaPasivoD			char(20),
    @CtaPasivoA			char(20),
	@CtaInventario		char(20),
    @CtaInventarioD		char(20),
	@CtaInventarioA		char(20),
    @CtaAF			char(20),
    @SaldoActivo		money,
    @SaldoPasivo		money,
    @Moneda			char(10),
    @Tipo			char(50),
    @Mes			int,
    @Saldo			money,
	@DescPeriodo    varchar(20),
	@CtaEfectivoCaja varchar(20),
	@CtaEfectivoCajaD varchar(20),
	@CtaEfectivoCajaA varchar(20),
	@CtaEfectivoBanco varchar(20),
	@CtaEfectivoBancoD varchar(20),
	@CtaEfectivoBancoA varchar(20),
	@CtaEfectivoInversion varchar(20),
	@CtaEfectivoInversionD varchar(20),
	@CtaEfectivoInversionA varchar(20),

    @CtaActivoFijoD			char(20),
	@CtaActivoFijoA			char(20),
    @CtaActivoDiferidoD		char(20),
	@CtaActivoDiferidoA			char(20),

    @CtaPasivoLargoPlazoD		char(20),
	@CtaPasivoLargoPlazoA			char(20),
    @CtaPasivoDiferidoD		char(20),
	@CtaPasivoDiferidoA			char(20),

	@CtaCompras		char(20),
	@CtaComprasD		char(20),
	@CtaComprasA	    char(20),

	@CtaDevoCompras		char(20),
	@CtaDevoComprasD		char(20),
	@CtaDevoComprasA	    char(20),

	@CtaGastosFinancieros	char(20),
	@CtaGastosFinancierosD		char(20),
	@CtaGastosFinancierosA	    char(20),

	@CtaVentas           	char(20), --S
	@CtaVentasD		        char(20),
	@CtaVentasA	            char(20),

	@CtaCostoVentas       	char(20), --T
	@CtaCostoVentasD        char(20),
	@CtaCostoVentasA        char(20),

	@CtaGastosOperacion     char(20), --U
	@CtaGastosOperacionD    char(20),
	@CtaGastosOperacionA    char(20),
	@CtaOtrosGastosProductos   char(20), --U2
	@CtaOtrosGastosProductosD   char(20),
	@CtaOtrosGastosProductosA   char(20),
	@CtaOtrosIngresos        char(20), --U3
	@CtaOtrosIngresosD        char(20),
	@CtaOtrosIngresosA        char(20),

	@CtaCuentasPorCobrar       	char(20),
	@CtaCuentasPorCobrarD        char(20),
	@CtaCuentasPorCobrarA        char(20),

	@CtaProveedores       	char(20),
	@CtaProveedoresD        char(20),
	@CtaProveedoresA        char(20),

	@CtaDepreAmort  char(20),
	@CtaDepreAmortD char(20),
	@CtaDepreAmortA char(20),

	@CtaCuentasPorPagar       	char(20),
	@CtaCuentasPorPagarD        char(20),
	@CtaCuentasPorPagarA        char(20),

	@CtaAcreedores       	char(20),
	@CtaAcreedoresD        char(20),
	@CtaAcreedoresA        char(20),

	@CtaImpuestosPagados       	char(20),
	@CtaImpuestosPagadosD        char(20),
	@CtaImpuestosPagadosA        char(20),

	@CtaCapitalContable       	char(20),
	@CtaCapitalContableD        char(20),
	@CtaCapitalContableA        char(20),

	@CtaInversionCapital       	char(20),
	@CtaInversionCapitalD        char(20),
	@CtaInversionCapitalA        char(20),

	@EsAcreedora                 int
		
	
	SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa


	CREATE TABLE #RazonesFinancieras(
	--Periodo		int	NULL,
	DescripcionPeriodo varchar(20),
	Activo		float	NULL,
	Pasivo		float	NULL,
	ActivoFijo float NULL,
	ActivoDiferido float NULL,
	PasivoLargoPlazo float NULL,
	PasivoDiferido float NULL,
	ActivoTotal float NULL,
	PasivoTotal float NULL,
	RazonCirculante  float   NULL,
	Inventario  float   NULL,
	RazonAcida  float   NULL,
	Efectivo  float   NULL,
	RazonEfectivo  float   NULL,
	CapitalTrabajo float NULL,
	CapitalTrabajo2 float NULL,
	Compras float NULL,
	DevolucionCompras float NULL,
	MedicionIntervaloTiempo float NULL,
	TotalDeuda float NULL,
	RelacionFlujoCajaOperativo float NULL,
	GastosFinancieros float NULL,
	ImpuestosPagados float NULL,
	Ventas float NULL, --S
	CostoVentas float NULL, --T
	GastosOperacion float NULL, --U
	OtrosGastosProductos float NULL, --U2
	OtrosIngresos float NULL, --U3
	UtilidadAntesImpuestosIntereses float NULL,
	CuentasPorCobrar float NULL,
	Proveedores float NULL,
	CuentasPorPagar float NULL,
	Acreedores float NULL,
	UtilidadBruta float NULL,
	UtilidadOperacion float NULL,
	DepreciacionesAmortizaciones float NULL,
	CapitalContable float NULL,
	UAFIR float NULL,
	UAFIRDA float NULL,
	AplacamientoTotal float NULL,
	AplacamientoCostoTotal float NULL,
	AplacamientoCortoPlazo float NULL,
	AplacamientoLargoPlazo float NULL,
	CoberturaGastosFinancieros float NULL,
	CoberturaEfectivo float NULL,
	RotacionInventarios float NULL,
	DiasInventarios float NULL,
	RotacionCxc float NULL,
	DiasCxc float NULL,
	RotacionCxp float NULL,
	DiasCxp float NULL,
	RotacionTotalActivos float NULL,
	RotacionActivosFijos float NULL,
	InversionCapital float NULL,
	MargenNeto float NULL,
	RendimientoSobreActivos float NULL,
	RendimientoSobreCapital float NULL,
	MargenBruto float NULL,
	MargenOperativo float NULL,
	MargenUAFIRDA float NULL,
	ROIC float NULL
	)

	CREATE TABLE #TiposPeriodo(
	TipoPeriodo	varchar(10),
	DescripcionPeriodo varchar(20),
	--NumPeriodo int NULL,
	--Factor int NULL,
	PeriodoD	int	NULL,
	PeriodoA	int	NULL,
	)

	CREATE TABLE #CuentasAplicar(
	 Cuenta varchar(20),
     CuentaA varchar(20)
	)

	INSERT #TiposPeriodo
	SELECT 'Trimestral','Trimestre 1', 1,3
	UNION
	SELECT 'Trimestral','Trimestre 2', 4,6
	UNION
	SELECT 'Trimestral','Trimestre 3',  7,9
	UNION
	SELECT 'Trimestral','Trimestre 4', 10,12
	UNION
	SELECT 'Semestral','Semestre 1', 1,6
	UNION
	SELECT 'Semestral','Semestre 2', 7,12
	UNION
	SELECT 'Anual','Anual', 1,12

	--SELECT * FROM #TiposPeriodo

   SELECT DISTINCT
          @CtaActivo   		= CtaActivo,
		  @CtaActivoFijo 	= CtaActivoFijo,
		  @CtaActivoDiferido  = CtaActivoDiferido,
    	  @CtaPasivo   		= CtaPasivo,
		  @CtaPasivoLargoPlazo = CtaPasivoLargoPlazo,
		  @CtaPasivoDiferido = CtaPasivoDiferido,
		  @CtaInventario    = CtaInventario,
		  @CtaEfectivoCaja  = CtaEfectivoCaja,
		  @CtaEfectivoBanco  = CtaEfectivoBanco,
		  @CtaEfectivoInversion  = CtaEfectivoInversion,
		  @CtaCompras		 = CtaCompras,
		  @CtaDevoCompras    = CtaDevoluciones,
		  @CtaGastosFinancieros = CtaGastosFinancieros,
		  @CtaVentas            = CtaVentas,
		  @CtaCostoVentas            = CtaCostoVentas,
		  @CtaGastosOperacion            = CtaGastosOperacion,
		  @CtaOtrosGastosProductos   =CtaOtrosGastosProductos,
	      @CtaOtrosIngresos        =CtaOtrosIngresos,
		  @CtaCuentasPorCobrar     =CtaCuentasPorCobrar,
		  @CtaProveedores          =CtaProveedores,
		  @CtaDepreAmort=CtaDepreAmort,
		  @CtaImpuestosPagados=CtaImpuestosPagados,
		  @CtaCapitalContable=CtaCapitalContable,
		  @CtaInversionCapital=CtaInversionCapital,
		  @CtaAcreedores=CtaAcreedores
     FROM CtaRazonFinanciera
	  
	 --select @CtaActivo, @CtaActivoFijo, @CtaActivoDiferido --5, @CtaPasivo, @CtaInventario, @CtaEfectivoCaja, @CtaEfectivoBanco, @CtaEfectivoInversion

	-- Inserta Cuentas a Considerar
	INSERT INTO #CuentasAplicar (Cuenta, CuentaA)
	SELECT DISTINCT @CtaActivo, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	   
    WHERE C.Rama  = 'B'
	  AND C.Cuenta = @CtaActivo
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaActivo as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaActivo
	UNION
	SELECT DISTINCT @CtaActivoFijo, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	    
    WHERE C.Rama  = 'B'
	  AND C.Cuenta = @CtaActivoFijo
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaActivoFijo as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaActivoFijo
	UNION
	SELECT DISTINCT @CtaActivoDiferido, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	  
    WHERE C.Rama  = 'B'
	  AND C.Cuenta = @CtaActivoDiferido
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaActivoDiferido as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaActivoDiferido
	UNION
	SELECT DISTINCT @CtaPasivo, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	     
    WHERE C.Rama  = 'H'
	  AND C.Cuenta = @CtaPasivo
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaPasivo as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaPasivo
	UNION	
    SELECT DISTINCT @CtaPasivoDiferido, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	     
    WHERE C.Rama  = 'H'
	  AND C.Cuenta = @CtaPasivoDiferido
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaPasivoDiferido as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaPasivoDiferido
	UNION
	SELECT DISTINCT @CtaPasivoLargoPlazo, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE		   
    WHERE C.Rama  = 'H'
	  AND C.Cuenta = @CtaPasivoLargoPlazo
	  AND CtaE.CuentaE IS NULL
    UNION
    SELECT DISTINCT @CtaPasivoLargoPlazo as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
    WHERE Cta.Cuenta = @CtaPasivoLargoPlazo
	UNION
	SELECT DISTINCT @CtaInventario, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE		   
    WHERE C.Rama  = 'B'
	  AND Ct.Cuenta = @CtaInventario
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaInventario as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaInventario
	UNION
	SELECT DISTINCT @CtaEfectivoCaja, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	  
    WHERE C.Rama  = 'B'
	  AND Ct.Cuenta = @CtaEfectivoCaja
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaEfectivoCaja as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaEfectivoCaja
	UNION
	SELECT DISTINCT @CtaEfectivoBanco, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	   	   
    WHERE C.Rama  = 'B'
	  AND Ct.Cuenta = @CtaEfectivoBanco
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaEfectivoBanco as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaEfectivoBanco
	UNION
	SELECT DISTINCT @CtaEfectivoInversion, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	  	   
    WHERE C.Rama  = 'B'
	  AND Ct.Cuenta = @CtaEfectivoInversion
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaEfectivoInversion as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaEfectivoInversion
	UNION
	SELECT DISTINCT @CtaCompras, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	 	   
    WHERE --C.Rama  = 'T' AND
	  Ct.Cuenta = @CtaCompras
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaCompras as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaCompras
	UNION
	SELECT DISTINCT @CtaDevoCompras, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	 	  	   
    WHERE --C.Rama  = 'T' AND 
	  Ct.Cuenta = @CtaDevoCompras
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaDevoCompras as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaDevoCompras
	UNION
	SELECT DISTINCT @CtaGastosFinancieros, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	 
    WHERE --C.Rama  = 'U2' AND
	  Ct.Cuenta = @CtaGastosFinancieros
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaGastosFinancieros as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaGastosFinancieros
	UNION
	SELECT DISTINCT @CtaVentas, Ctx.Cuenta
     FROM Cta C           
     JOIN Cta Ct ON Ct.Rama = C.Cuenta            
     JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	 LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	 
    WHERE C.Rama  = @CtaVentas
     --AND C.Cuenta = @CtaVentas
	 AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaVentas as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaVentas
	UNION
	SELECT DISTINCT @CtaCostoVentas, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
    WHERE C.Rama  = @CtaCostoVentas
     --AND C.Cuenta = @CtaVentas
	 AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaCostoVentas as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaCostoVentas
	UNION
	SELECT DISTINCT @CtaGastosOperacion, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Cty.Cuenta=CtaE.CuentaE	 
    WHERE --C.Rama  = 'U' AND
	  Ct.Cuenta = @CtaGastosOperacion
	  AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaGastosOperacion as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaGastosOperacion
	UNION
	SELECT DISTINCT @CtaOtrosGastosProductos, Ctx.Cuenta
       FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
    WHERE C.Rama  = @CtaOtrosGastosProductos
     --AND C.Cuenta = @CtaVentas
	 AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaOtrosGastosProductos as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaOtrosGastosProductos
	UNION
	SELECT DISTINCT @CtaOtrosIngresos, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
     WHERE C.Rama  = 'U2'
       AND C.Cuenta = @CtaOtrosIngresos
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaOtrosIngresos as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaOtrosIngresos
	UNION
	SELECT DISTINCT @CtaProveedores, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	    
     WHERE --C.Rama  = 'H' AND
       C.Cuenta = @CtaProveedores
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaProveedores as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaProveedores
	UNION
	SELECT DISTINCT @CtaAcreedores, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	    
     WHERE --C.Rama  = 'H' AND
       C.Cuenta = @CtaAcreedores
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaAcreedores as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaAcreedores
	UNION
	SELECT DISTINCT @CtaImpuestosPagados, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
     WHERE --C.Rama  = 'U3' AND
       C.Cuenta = @CtaImpuestosPagados
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaImpuestosPagados as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaImpuestosPagados
	UNION
	SELECT DISTINCT @CtaCapitalContable, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	
     WHERE --C.Rama  = 'Q' AND
       Ct.Cuenta = @CtaCapitalContable
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaCapitalContable as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaCapitalContable
	UNION
	SELECT DISTINCT @CtaInversionCapital, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
     WHERE --C.Rama  = 'Q' AND
       C.Cuenta = @CtaInversionCapital
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaInversionCapital as CuentaAgrup, CtaA.CuentaA
	 FROM Cta
	 JOIN CtaRazonesFinancierasAdicionar CtaA ON CtaA.Cuenta=Cta.Cuenta
	WHERE Cta.Cuenta = @CtaInversionCapital
	UNION
	SELECT DISTINCT @CtaCuentasPorCobrar, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
     WHERE --C.Rama  = 'U'
       C.Cuenta = @CtaCuentasPorCobrar
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaCuentasPorCobrar, /*C.Cuenta, Ct.Cuenta, Ctx.Cuenta,*/ Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  --JOIN CtaRazonesFinancierasAdicionar CtaA ON Ctx.Cuenta=CtaA.CuentaA
	  JOIN CtaRazonesFinancierasAdicionar CtaA ON Ct.Cuenta=CtaA.CuentaA
    WHERE C.Rama  = 'B'
	  AND CtaA.Cuenta = @CtaCuentasPorCobrar
	 -- AND Ctx.Cuenta = CtaA.CuentaA
	UNION
	SELECT DISTINCT @CtaDepreAmort, Ctx.Cuenta
      FROM Cta C           
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta  
	  LEFT OUTER JOIN CtaRazonesFinancierasExcepcionar CtaE ON CtaE.Cuenta=C.Cuenta AND Ctx.Cuenta=CtaE.CuentaE	  
     WHERE --C.Rama  = 'U'
       C.Cuenta = @CtaDepreAmort
	   AND CtaE.CuentaE IS NULL
	UNION
	SELECT DISTINCT @CtaDepreAmort, Cty.Cuenta
      FROM Cta C          
      JOIN Cta Ct ON Ct.Rama = C.Cuenta            
      JOIN Cta Ctx ON Ctx.Rama = Ct.Cuenta 
	  JOIN Cta Cty ON Cty.Rama = Ctx.Cuenta    
	  --JOIN CtaRazonesFinancierasAdicionar CtaA ON Ctx.Cuenta=CtaA.CuentaA
	  JOIN CtaRazonesFinancierasAdicionar CtaA ON Ct.Cuenta=CtaA.CuentaA	  
     WHERE --C.Rama  = 'U'
       CtaA.Cuenta = @CtaDepreAmort
	 -- AND Ctx.Cuenta = CtaA.CuentaA

	--SELECT @CtaDepreAmort
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaDepreAmort

	--SELECT @CtaCuentasPorCobrar
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaCuentasPorCobrar

	--SELECT @CtaProveedores
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaProveedores

	--SELECT @CtaAcreedores
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaAcreedores

 --   SELECT @CtaImpuestosPagados
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaImpuestosPagados

	-- SELECT @CtaInversionCapital
	--SELECT * FROM #CuentasAplicar WHERE Cuenta=@CtaInversionCapital

    --SELECT * FROM #CuentasAplicar WHERE Cuenta='I'
				
  DECLARE #crRazonesFinancieras CURSOR FOR
	 SELECT 'Tipo' = 'Activo', /*c.Cuenta, a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaActivo
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
-- 	   AND AjusteInflacionario = 0
	   AND ISNULL(c.Categoria,'') <> 'No Monetario'
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'ActivoFijo', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaActivoFijo
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
-- 	   AND AjusteInflacionario = 0
	   AND ISNULL(c.Categoria,'') <> 'No Monetario'
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'ActivoDiferido', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	 FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaActivoDiferido
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
-- 	   AND AjusteInflacionario = 0
	   AND ISNULL(c.Categoria,'') <> 'No Monetario'
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Pasivo', /*a.Periodo*/ tp.DescripcionPeriodo,  'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2926
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaPasivo
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'PasivoLargoPlazo', /*a.Periodo*/ tp.DescripcionPeriodo,  'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2926
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaPasivoLargoPlazo
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'PasivoDiferido', /*a.Periodo*/ tp.DescripcionPeriodo,  'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2926
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaPasivoDiferido
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Inventario', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaInventario
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Efectivo', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	 FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaEfectivoCaja
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Efectivo', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaEfectivoBanco
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Efectivo', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	 FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaEfectivoInversion
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Compras', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaCompras
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'DevoCompras', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaDevoCompras
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'GastosFinancieros', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	  FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaGastosFinancieros
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Ventas', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	 FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaVentas
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'CostoVentas', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaCostoVentas
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'GastosOperacion', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaGastosOperacion
	   AND c.Cuenta=ca.CuentaA

	   --AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'OtrosGastosProductos', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaOtrosGastosProductos
	   AND c.Cuenta=ca.CuentaA

	   --AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'OtrosIngresos', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaOtrosGastosProductos
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'CuentasPorCobrar', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaCuentasPorCobrar
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Proveedores', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2937
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaProveedores
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'Acreedores', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2937
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaAcreedores
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'DepreciacionesAmortizaciones', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaDepreAmort
	   AND c.Cuenta=ca.CuentaA

	   --AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'ImpuestosPagados', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaImpuestosPagados
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo, c.EsAcreedora
	UNION
	SELECT 'Tipo' = 'CapitalContable', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*-1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END) --BUG2926
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaCapitalContable
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	UNION
	SELECT 'Tipo' = 'InversionCapital', /*a.Periodo*/ tp.DescripcionPeriodo, 'Saldo' =  SUM(CASE WHEN c.EsAcreedora=1 THEN (ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0))*1 ELSE ISNULL(a.Cargos,0)-ISNULL(a.Abonos,0) END)
	   FROM Cta c, Acum a, #TiposPeriodo tp , #CuentasAplicar ca
	 WHERE c.Cuenta = a.Cuenta
	   AND a.Rama = 'CONT'
	   AND a.Empresa = @Empresa
	   AND a.Ejercicio = @Ejercicio

	   AND tp.TipoPeriodo=@TipoPeriodo
	   --AND a.Periodo <= @Periodo
	   AND a.Periodo BETWEEN tp.PeriodoD AND tp.PeriodoA

	   AND a.Moneda = @Moneda
	   --AND c.Cuenta >= @CtaActivoD AND c.Cuenta < @CtaPasivoD
	   --AND c.Cuenta BETWEEN @CtaActivoD AND @CtaActivoA

	   AND ca.Cuenta=@CtaInversionCapital
	   AND c.Cuenta=ca.CuentaA

	   AND c.EsAcumulativa = 0
--	   AND AjusteInflacionario = 0
	--GROUP BY a.Periodo
	GROUP BY tp.DescripcionPeriodo
	
  OPEN #crRazonesFinancieras
  FETCH NEXT FROM #crRazonesFinancieras INTO @Tipo, @DescPeriodo, @Saldo
	WHILE @@FETCH_STATUS = 0
		BEGIN

			IF @Tipo = 'Activo'
			BEGIN
				UPDATE #RazonesFinancieras SET Activo = ISNULL(Activo,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Activo) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			ELSE
			BEGIN
			  IF @Tipo = 'Pasivo'
			    BEGIN
				  UPDATE #RazonesFinancieras SET Pasivo = ISNULL(Pasivo,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				  IF @@ROWCOUNT = 0	
				    INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Pasivo) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			    END
			END

			IF @Tipo = 'ActivoFijo'
			BEGIN
				UPDATE #RazonesFinancieras SET ActivoFijo = ISNULL(ActivoFijo,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, ActivoFijo) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			ELSE
			BEGIN
			  IF @Tipo = 'ActivoDiferido'
			    BEGIN
				  UPDATE #RazonesFinancieras SET ActivoDiferido = ISNULL(ActivoDiferido,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				  IF @@ROWCOUNT = 0	
				    INSERT INTO #RazonesFinancieras (DescripcionPeriodo, ActivoDiferido) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			    END
			END

			IF @Tipo = 'PasivoLargoPlazo'
			BEGIN
				UPDATE #RazonesFinancieras SET PasivoLargoPlazo = ISNULL(PasivoLargoPlazo,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, PasivoLargoPlazo) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			ELSE
			BEGIN
			  IF @Tipo = 'PasivoDiferido'
			    BEGIN
				  UPDATE #RazonesFinancieras SET PasivoDiferido = ISNULL(PasivoDiferido,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				  IF @@ROWCOUNT = 0	
				    INSERT INTO #RazonesFinancieras (DescripcionPeriodo, PasivoDiferido) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
				END
			END

			IF @Tipo = 'Inventario'
			BEGIN
				UPDATE #RazonesFinancieras SET Inventario = ISNULL(Inventario,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Inventario) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'Efectivo'
			BEGIN
				UPDATE #RazonesFinancieras SET Efectivo = ISNULL(Efectivo,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Efectivo) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'Compras'
			BEGIN
				UPDATE #RazonesFinancieras SET Compras = ISNULL(Compras,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Compras) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'DevoCompras'
			BEGIN
				UPDATE #RazonesFinancieras SET DevolucionCompras = ISNULL(DevolucionCompras,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, DevolucionCompras) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'GastosFinancieros'
			BEGIN
				UPDATE #RazonesFinancieras SET GastosFinancieros = ISNULL(GastosFinancieros,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, GastosFinancieros) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			
			IF @Tipo = 'Ventas'
			BEGIN
			    SELECT @EsAcreedora=CASE WHEN EsAcreedora=0 THEN 1 ELSE -1 END FROM Cta WHERE Cuenta=@CtaVentas

				UPDATE #RazonesFinancieras SET Ventas = ISNULL(Ventas,0) + (ISNULL(@Saldo,0)*ISNULL(@EsAcreedora,1)) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Ventas) VALUES(@DescPeriodo, (ISNULL(@Saldo,0)*ISNULL(@EsAcreedora,1)))
			END

			IF @Tipo = 'CostoVentas'
			BEGIN
				UPDATE #RazonesFinancieras SET CostoVentas = ISNULL(CostoVentas,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, CostoVentas) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'GastosOperacion'
			BEGIN
				UPDATE #RazonesFinancieras SET GastosOperacion = ISNULL(GastosOperacion,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, GastosOperacion) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			IF @Tipo = 'OtrosGastosProductos'
			BEGIN
				UPDATE #RazonesFinancieras SET OtrosGastosProductos = ISNULL(OtrosGastosProductos,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, OtrosGastosProductos) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
			IF @Tipo = 'OtrosIngresos'
			BEGIN
				UPDATE #RazonesFinancieras SET OtrosIngresos = ISNULL(OtrosIngresos,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, OtrosIngresos) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'CuentasPorCobrar'
			BEGIN
				UPDATE #RazonesFinancieras SET CuentasPorCobrar = ISNULL(CuentasPorCobrar,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, CuentasPorCobrar) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'Proveedores'
			BEGIN
				UPDATE #RazonesFinancieras SET Proveedores = ISNULL(Proveedores,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Proveedores) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'Acreedores'
			BEGIN
				UPDATE #RazonesFinancieras SET Proveedores = ISNULL(Acreedores,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, Acreedores) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'DepreciacionesAmortizaciones'
			BEGIN
				UPDATE #RazonesFinancieras SET DepreciacionesAmortizaciones = ISNULL(DepreciacionesAmortizaciones,0) + @Saldo WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, DepreciacionesAmortizaciones) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'ImpuestosPagados'
			BEGIN
				UPDATE #RazonesFinancieras SET ImpuestosPagados = ISNULL(ImpuestosPagados,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, ImpuestosPagados) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'CapitalContable'
			BEGIN
				UPDATE #RazonesFinancieras SET CapitalContable = ISNULL(CapitalContable,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, CapitalContable) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END

			IF @Tipo = 'InversionCapital'
			BEGIN
				UPDATE #RazonesFinancieras SET InversionCapital = ISNULL(InversionCapital,0) + ISNULL(@Saldo,0) WHERE DescripcionPeriodo = @DescPeriodo

				IF @@ROWCOUNT = 0	
				  INSERT INTO #RazonesFinancieras (DescripcionPeriodo, InversionCapital) VALUES(@DescPeriodo, ISNULL(@Saldo,0))
			END
					
			
			UPDATE #RazonesFinancieras 
			   SET RazonCirculante = ISNULL(Activo,0)/(CASE WHEN ISNULL(Pasivo,1)=0 THEN 1 ELSE ISNULL(Pasivo,1) END),
			       RazonAcida=  (ISNULL(Activo,0)-ISNULL(Inventario,0))/CASE WHEN ISNULL(Pasivo,1)=0 THEN 1 ELSE ISNULL(Pasivo,1) END,
				   RazonEfectivo=  ISNULL(Efectivo,0)/(CASE WHEN ISNULL(Pasivo,1)=0 THEN 1 ELSE ISNULL(Pasivo,1) END),

				   -- CAPITAL TRABAJO NETO (ACTIVO CIRCULANTE-PASIVO CIRCULANTE)
				   CapitalTrabajo=ISNULL(Activo,0)-ISNULL(Pasivo,0),
				   
				   -- CAPITAL TRABAJO NETO SOBRE TOTAL DE ACTIVOS
				   CapitalTrabajo2=(ISNULL(Activo,0)-ISNULL(Pasivo,0))/CASE WHEN ISNULL(Activo,0)+ISNULL(ActivoFijo,0)+ISNULL(ActivoDiferido,0)=0 THEN 1 ELSE ISNULL(Activo,0)+ISNULL(ActivoFijo,0)+ISNULL(ActivoDiferido,0) END,
				   				   				   
				   -- MEDICION DE INTERVALO TIEMPO
				   MedicionIntervaloTiempo=ISNULL(Activo,0)/CASE WHEN ISNULL(Compras,0)-ISNULL(DevolucionCompras,0)=0 THEN 1 ELSE ISNULL(Compras,0)-ISNULL(DevolucionCompras,0) END,
		   
				   
				   -- Total de Deuda (Sumatoria de Pasivo Circulante y Pasivo a Largo Plazo sin Impuestos)
				   -- OJO: FALTA DEFINIR (Pasivo a Largo Plazo sin Impuestos)
				   TotalDeuda=ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0), -- menos (Pasivo a Largo Plazo sin Impuestos)

				   ActivoTotal=ISNULL(Activo,0)+ ISNULL(ActivoFijo,0)+ISNULL(ActivoDiferido,0),
				   PasivoTotal=ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0)+ISNULL(PasivoDiferido,0),

				   -- Utilidad de antes de Impuestos e Intereses (Ingresos Ventas-Costos de Ventas-Gastos de Operacion-Otros Gastos y Productos)
				   UtilidadAntesImpuestosIntereses = Ventas-ISNULL(CostoVentas,0)-ISNULL(GastosOperacion,0), -- -ISNULL(OtrosGastosProductos,0) --BUG2937
				   -- Utilida Bruta (Ingresos Ventas - Costos de Ventas)
				   UtilidadBruta=(Ventas-ISNULL(CostoVentas,0)),
				   -- Utilidad de Operacion (Ingresos Ventas-Costos de Ventas-Gastos de Operacion)
				   UtilidadOperacion=(Ventas-CostoVentas)-GastosOperacion,
				  
				   -- Relacion de flujo de caja operativo= UAFIRDA / Total de Deuda
				   RelacionFlujoCajaOperativo=(Ventas+CostoVentas+GastosOperacion)/CASE WHEN ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0)=0 THEN 1 ELSE ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0) END
				   
			 WHERE DescripcionPeriodo = @DescPeriodo

			 UPDATE #RazonesFinancieras
			       SET
			       -- UAFIR= Es la utilidad antes de gastos financieros e impuestos. Se obtiene al restar de ... generarlos
				   UAFIR=UtilidadAntesImpuestosIntereses,


				   -- UAFIRDA = Ingresos Ventas+Costos de Ventas+ (Gastos de Operacion --> INCLUYE Depreciaciones y amortizaciones)
				   --UAFIRDA = Ventas+CostoVentas+GastosOperacion+DepreciacionesAmortizaciones,
				   --UAFIRDA = UAFIR+ISNULL(DepreciacionesAmortizaciones,0),
				   --UAFIRDA = UtilidadAntesImpuestosIntereses+ISNULL(DepreciacionesAmortizaciones,0),
                   UAFIRDA = UtilidadAntesImpuestosIntereses-ISNULL(OtrosGastosProductos,0)+ISNULL(DepreciacionesAmortizaciones,0), --BUG2937

				   -- Relacion de flujo de caja operativo= UAFIRDA / Total de Deuda
				   RelacionFlujoCajaOperativo=(Ventas+CostoVentas+GastosOperacion)/CASE WHEN ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0)=0 THEN 1 ELSE ISNULL(Pasivo,0)+ISNULL(PasivoLargoPlazo,0) END
				   
			 WHERE DescripcionPeriodo = @DescPeriodo

			 -- Razones de Solvencia a Largo Plazo o Aplacamiento Financiero
			 UPDATE #RazonesFinancieras 
			   SET AplacamientoTotal=PasivoTotal/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               AplacamientoCostoTotal=(Pasivo+ISNULL(PasivoLargoPlazo,0))/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               AplacamientoCortoPlazo=Pasivo/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               AplacamientoLargoPlazo=ISNULL(PasivoLargoPlazo,0)/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               CoberturaGastosFinancieros=UAFIR/CASE WHEN GastosFinancieros=0 THEN 1 ELSE GastosFinancieros END,
	               CoberturaEfectivo=UAFIRDA/CASE WHEN GastosFinancieros=0 THEN 1 ELSE GastosFinancieros END
			 WHERE DescripcionPeriodo = @DescPeriodo

			 -- Razones de Administración de Activos o de Rotación
			 UPDATE #RazonesFinancieras 
			   SET RotacionInventarios=CostoVentas/CASE WHEN Inventario=0 THEN 1 ELSE Inventario END,
	               DiasInventarios=365.00/CASE WHEN (CostoVentas/CASE WHEN Inventario=0 THEN 1 ELSE Inventario END )=0 THEN 1 ELSE CostoVentas/CASE WHEN Inventario=0 THEN 1 ELSE Inventario END END,
				   --DiasInventarios=CASE WHEN Inventario<>0 THEN 365.00/(CostoVentas/Inventario) ELSE 0 END,
				   
	               RotacionCxc=Ventas/CASE WHEN CuentasPorCobrar=0 THEN 1 ELSE CuentasPorCobrar END,
	               --DiasCxc=PasivoLargoPlazo/CASE WHEN CuentasPorCobrar=0 THEN 1 ELSE ActivoTotal END,
				   DiasCxc=365.00/(Ventas/CASE WHEN CuentasPorCobrar=0 THEN 1 ELSE CuentasPorCobrar END),
	               RotacionCxp=CostoVentas/CASE WHEN Proveedores+Acreedores=0 THEN 1 ELSE Proveedores+Acreedores END
			 WHERE DescripcionPeriodo = @DescPeriodo

			 UPDATE #RazonesFinancieras
			   SET --DiasCxp=365.00/(CASE WHEN CostoVentas/(CASE WHEN Proveedores+CuentasPorCobrar=0 THEN 1 ELSE Proveedores+CuentasPorCobrar END)=0 THEN 1 ELSE CostoVentas/(CASE WHEN Proveedores+CuentasPorCobrar=0 THEN 1 ELSE Proveedores+CuentasPorCobrar END) END),
				   DiasCxp=CASE WHEN RotacionCxp<>0 THEN 365.00/RotacionCxp ELSE 0 END,
				   --RotacionTotalActivos=Ventas/CASE WHEN Activo+ActivoFijo+ActivoDiferido=0 THEN 1 ELSE Activo+ActivoFijo+ActivoDiferido END,
				   RotacionTotalActivos=Ventas/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               RotacionActivosFijos=Ventas/CASE WHEN ActivoFijo=0 THEN 1 ELSE ActivoFijo END
			 WHERE DescripcionPeriodo = @DescPeriodo

			 -- Medidas de Rentabilidad
			 UPDATE #RazonesFinancieras 
			   SET MargenNeto=(UtilidadAntesImpuestosIntereses-ISNULL(ImpuestosPagados,0))/CASE WHEN Ventas=0 THEN 1 ELSE Ventas END,
	               RendimientoSobreActivos=(UtilidadAntesImpuestosIntereses-ISNULL(ImpuestosPagados,0))/CASE WHEN ActivoTotal=0 THEN 1 ELSE ActivoTotal END,
	               --RendimientoSobreCapital=(UtilidadAntesImpuestosIntereses-ISNULL(ImpuestosPagados,0))/CASE WHEN ISNULL(CapitalContable,0)=0 THEN 1 ELSE CapitalContable END,
				   RendimientoSobreCapital=CASE WHEN ISNULL(CapitalContable,0)<>0 THEN (UtilidadAntesImpuestosIntereses-ISNULL(ImpuestosPagados,0))/ISNULL(CapitalContable,0) ELSE 0 END,
	               MargenBruto=UtilidadBruta/CASE WHEN Ventas<=0 THEN 1 ELSE Ventas END,
	               MargenOperativo=UAFIR/CASE WHEN Ventas=0 THEN 1 ELSE Ventas END,
	               MargenUAFIRDA=UAFIRDA/CASE WHEN Ventas=0 THEN 1 ELSE Ventas END,
				   --ROIC=(UAFIRDA-ISNULL(ImpuestosPagados,0))/CASE WHEN ISNULL(InversionCapital,0)=0 THEN 1 ELSE ISNULL(InversionCapital,0) END
				   ROIC=CASE WHEN ISNULL(InversionCapital,0)<>0 THEN (UAFIRDA-ISNULL(ImpuestosPagados,0))/ISNULL(InversionCapital,0) ELSE 0 END
			 WHERE DescripcionPeriodo = @DescPeriodo

			FETCH NEXT FROM #crRazonesFinancieras INTO @Tipo, @DescPeriodo, @Saldo
		END
	CLOSE #crRazonesFinancieras
	DEALLOCATE #crRazonesFinancieras
 
  SELECT *
  FROM #RazonesFinancieras

END
GO
--REQ1584 Preconf
/**************** spVerContResultadosEmpresaSucursalAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerContResultadosEmpresaSucursalAnual') and type = 'P') drop procedure dbo.spVerContResultadosEmpresaSucursalAnual
GO
CREATE PROCEDURE spVerContResultadosEmpresaSucursalAnual
		    @Empresa		varchar(5),
		    @Ejercicio		int,
			@Sucursal		int	    = NULL, 
            @CentroCostos	varchar(20) = NULL,
		    @Moneda			varchar(10) = NULL,
            --@Controladora	varchar(5)  = NULL,
		    @UEN			int		= NULL,
		    @Proyecto		varchar(50)	= NULL,
		    @CentroCostos2	varchar(50)	= NULL,
		    @CentroCostos3	varchar(50)	= NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @CtaResultados	varchar(20),
    @CtaIngresos	varchar(20),
    @CtaCostoDirecto	varchar(20),
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
    @SaldoAlDic         money,
    @Ingresos		money,
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
    @PorcentajeAlDic    money
 
  SELECT @Moneda = NULLIF(NULLIF(RTRIM(@Moneda), ''), '0')
  IF @Moneda IS NULL SELECT @Moneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  CREATE TABLE #ResultadoAnual (
     ID			int		IDENTITY(1,1) NOT NULL,

     Clase		varchar(20)	COLLATE Database_Default NULL,
     SubClase		varchar(20)	COLLATE Database_Default NULL,
     Rama		varchar(20)	COLLATE Database_Default NULL, 
     RamaDesc		varchar(100)	COLLATE Database_Default NULL,
     RamaEsAcreedora	bit		NOT NULL DEFAULT 0,
     Cuenta		varchar(20)	COLLATE Database_Default NULL,
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
     Ingresos		money		NULL,
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

     CONSTRAINT priTempResultado PRIMARY KEY CLUSTERED (ID)
  )

   SELECT /*@ConMovs = UPPER(@ConMovs),*/ @CentroCostos = NULLIF(RTRIM(@CentroCostos), '')
   IF UPPER(@CentroCostos) IN ('0', 'NULL', '(TODOS)', '(ALL)') SELECT @CentroCostos = NULL
   IF @UEN = 0 SELECT @UEN = NULL
   IF UPPER(@Proyecto)      IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @Proyecto = NULL
   IF UPPER(@CentroCostos2) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos2 = NULL
   IF UPPER(@CentroCostos3) IN ('0', 'NULL', '(TODOS)','', '(ALL)') SELECT @CentroCostos3 = NULL

   SELECT DISTINCT
          @CtaResultados   = CtaResultados,
    	  @CtaIngresos	   = CtaIngresos,
    	  @CtaCostoDirecto = CtaCostoDirecto
     FROM EmpresaCfg 
    WHERE Empresa = @Empresa

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
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
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
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
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
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
	 NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
         NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
    FROM Cta, Cta Rama
   WHERE Cta.Rama   = Rama.Cuenta
     AND UPPER(Cta.Tipo) = 'MAYOR'
     AND (Cta.Rama = @CtaResultados OR Rama.Rama = @CtaResultados)
     AND (Cta.Rama <> @CtaIngresos AND Rama.Rama <> @CtaIngresos)
     AND (Cta.Rama <> @CtaCostoDirecto AND Rama.Rama <> @CtaCostoDirecto)

  -- Ingresos Acumulados
  IF @CentroCostos IS NULL
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Ejercicio = @Ejercicio 
       AND a.Moneda = @Moneda
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/
   ELSE
    SELECT @Ingresos = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Periodo BETWEEN 1 AND 12
       AND a.Empresa = @Empresa
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*       AND Periodo BETWEEN @PeriodoD AND @PeriodoA*/

  -- Ingresos al Mes 
  IF @CentroCostos IS NULL
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlEne = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.SubCuenta = @CentroCostos
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 1
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlFeb = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       --AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 2
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  --SELECT @IngresosAlFeb, @CtaIngresos, @CentroCostos, @Ejercicio, @Moneda, @Empresa, @CentroCostos2, @CentroCostos3, @UEN, @Proyecto

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlMar = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 3
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlAbr = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 4
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlMay = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 5
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlJun = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 6
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlJul = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 7
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlAgo = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 8
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlSep = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 9
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlOct = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 10
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  IF @CentroCostos IS NULL
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
  ELSE
    SELECT @IngresosAlNov = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 11
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  IF @CentroCostos IS NULL
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
  ELSE
    SELECT @IngresosAlDic = Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
      FROM Acum a
     WHERE a.Rama = 'CONT'
       AND a.Cuenta = @CtaIngresos
       AND a.SubCuenta = @CentroCostos
       AND a.Moneda = @Moneda
       AND a.Ejercicio = @Ejercicio 
       AND a.Empresa = @Empresa
       AND a.Periodo = 12
       --REQ25870
       AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
       AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
       AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
       AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
	   AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)

  -- Saldo Acumulado
  IF @CentroCostos IS NULL
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND a.Moneda = @Moneda
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultado CURSOR FOR
     SELECT ID,
            "Saldo" = (
     SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0))
       FROM Acum a
      WHERE a.Rama = 'CONT'
        AND a.Cuenta = b.Cuenta 
        AND a.SubCuenta = @CentroCostos
        AND a.Moneda = @Moneda
        AND a.Ejercicio = @Ejercicio 
        AND a.Empresa = @Empresa
        AND Periodo BETWEEN 1 AND 12
        --REQ25870
        AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2)
        AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3)
        AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0)
        AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')
		AND ISNULL(a.Sucursal, 0) = ISNULL(ISNULL(@Sucursal, a.Sucursal), 0)
/*        AND a.Periodo BETWEEN @PeriodoD AND @PeriodoA*/)
       FROM #ResultadoAnual b
  
  OPEN crResultado
  FETCH NEXT FROM crResultado INTO @ID, @Saldo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      UPDATE #ResultadoAnual
         SET Saldo = @Saldo,
             Ingresos = @Ingresos,
             Porcentaje = (@Saldo/@Ingresos)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultado INTO @ID, @Saldo
  END
  CLOSE crResultado
  DEALLOCATE crResultado

  --SELECT 'XXXX', Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = 'S' AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')

  -- Saldo al Mes 
  IF @CentroCostos IS NULL
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
       FROM #ResultadoAnual b
  ELSE
    DECLARE crResultadoAl CURSOR FOR
     --REQ25870
     SELECT ID,
            "SaldoAlEne" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 1  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlFeb" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 2  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMar" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 3  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAbr" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 4  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlMay" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 5  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJun" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 6  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlJul" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 7  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlAgo" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 8  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlSep" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 9  AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlOct" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 10 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlNov" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 11 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), '')),
            "SaldoAlDic" = (SELECT Sum(ISNULL(a.Cargos, 0.0)-ISNULL(a.Abonos, 0.0)) FROM Acum a WHERE a.Moneda = @Moneda AND a.Rama = 'CONT' AND a.Cuenta = b.Cuenta AND a.SubCuenta = @CentroCostos AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio AND a.Periodo = 12 AND (@CentroCostos2 IS NULL OR a.SubCuenta2 = @CentroCostos2) AND (@CentroCostos3 IS NULL OR a.SubCuenta3 = @CentroCostos3) AND ISNULL(a.UEN, 0) = ISNULL(ISNULL(@UEN, a.UEN), 0) AND ISNULL(a.Proyecto, '') = ISNULL(ISNULL(@Proyecto, a.Proyecto), ''))
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
             SaldoAlDic = @SaldoAlDic,
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
	     IngresosAlDic = @IngresosAlDic,
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
             PorcentajeAlDic = (@SaldoAlDic/@IngresosAlDic)*100
       WHERE ID = @ID
    FETCH NEXT FROM crResultadoAl INTO @ID, @SaldoAlEne, @SaldoAlFeb, @SaldoAlMar, @SaldoAlAbr, @SaldoAlMay, @SaldoAlJun, @SaldoAlJul, @SaldoAlAgo, @SaldoAlSep, @SaldoAlOct, @SaldoAlNov, @SaldoAlDic/*, @IngresosAlEne, @IngresosAlFeb, @IngresosAlMar, @IngresosAlAbr, @IngresosAlMay, @IngresosAlJun, @IngresosAlJul, @IngresosAlAgo, @IngresosAlSep, @IngresosAlOct, @IngresosAlNov, @IngresosAlDic, @PorcentajeAlEne, @PorcentajeAlFeb, @PorcentajeAlMar, @PorcentajeAlAbr, @PorcentajeAlMay, @PorcentajeAlJun, @PorcentajeAlJul, @PorcentajeAlAgo, @PorcentajeAlSep, @PorcentajeAlOct, @PorcentajeAlNov, @PorcentajeAlDic*/
  END
  CLOSE crResultadoAl
  DEALLOCATE crResultadoAl

/*  IF @ConMovs = 'SI' 
  SELECT * FROM #ResultadoAnual WHERE ISNULL(Saldo, 0.0) <> 0.0 OR ISNULL(SaldoAlEne, 0.0) <> 0.0
  ELSE*/
    SELECT * FROM #ResultadoAnual
END
GO