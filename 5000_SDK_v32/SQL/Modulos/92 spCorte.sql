/**************** fnCorteImporteCantidadEnTexto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCorteImporteCantidadEnTexto') DROP FUNCTION fnCorteImporteCantidadEnTexto
GO
CREATE FUNCTION fnCorteImporteCantidadEnTexto(
				@TipoTotalizador		varchar(255),
				@Importe				float,
				@SaldoU					float)
RETURNS varchar(30)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Valor  varchar(30)
  
  IF @TipoTotalizador = 'Monetario'
    SELECT @Valor = dbo.fnMonetarioEnTexto(@Importe)
  ELSE IF @TipoTotalizador = 'Unidad'
    SELECT @Valor = dbo.fnCantidadEnTexto(@SaldoU)

  RETURN @Valor
END
GO

/**************** fnCorteReporteTitulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCorteReporteTitulo') DROP FUNCTION fnCorteReporteTitulo
GO
CREATE FUNCTION fnCorteReporteTitulo(
				@ID			int)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Titulo	varchar(255)
  
  SELECT @Titulo = Columna1 FROM CorteDReporte WHERE Tipo = 'TIT' AND ID = @ID
  
  IF ISNULL(RTRIM(@Titulo), '') = ''
    SELECT @Titulo = RTRIM(Mov)+' '+RTRIM(MovID) FROM Corte WHERE ID = @ID
  
  RETURN @Titulo
END
GO

/**************** fnCorteCalcPeriodoFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCorteCalcPeriodoFecha') DROP FUNCTION fnCorteCalcPeriodoFecha
GO
CREATE FUNCTION fnCorteCalcPeriodoFecha 
	(	
	@Tipo					varchar(20),
	@ID						varchar(50),
	@Fecha					datetime,
	@ParamNumeroPeriodos	varchar(100),
	@ParamTipoPeriodo		varchar(100)
	)
	
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado				datetime,
    @FechaFinal				datetime,
	@FechaInicial			datetime,
	@NumeroPeriodos			int,
	@PeriodoTipo			varchar(255)
	
  SET @FechaFinal = dbo.fnFechaSinHora(DATEADD(DD,-1,@Fecha))
  
  SET @Resultado = NULL
    
  SELECT @NumeroPeriodos = CONVERT(int,ISNULL(CorteNoPeriodos,1)),
		 @PeriodoTipo = ISNULL(NULLIF(CorteTipoPeriodo,''),'DIA')
    FROM Corte 
   WHERE ID	= @ID 
     
  IF @@ERROR <> 0 SET @NumeroPeriodos = 1
    
  IF @PeriodoTipo NOT IN ('DIA','MES','AÑO') SET @PeriodoTipo = 'DIA'    

  IF @NumeroPeriodos >= 1 SET @NumeroPeriodos = @NumeroPeriodos -1 ELSE
  IF @NumeroPeriodos < 0 SET @NumeroPeriodos = 0       
  
  IF @Tipo = 'FINAL'
  BEGIN
    SET @Resultado = @FechaFinal
  END 
  ELSE IF @Tipo = 'INICIAL'
  BEGIN
    IF @PeriodoTipo = 'DIA' 
    BEGIN
      SET @Resultado = DATEADD(dd,0-@NumeroPeriodos,@FechaFinal)
    END ELSE 
    IF @PeriodoTipo = 'MES' 
    BEGIN
      SET @FechaInicial = DATEADD(dd,0-(DAY(@FechaFinal)-1),@FechaFinal)
      SET @Resultado = DATEADD(mm,0-@NumeroPeriodos,@FechaInicial)
    END ELSE  
    IF @PeriodoTipo = 'AÑO' 
    BEGIN      
      SET @FechaInicial = DATEADD(dd,0-(DAY(@FechaFinal)-1),@FechaFinal)
      SET @FechaInicial = DATEADD(mm,0-(MONTH(@FechaInicial)-1),@FechaInicial)      
      SET @Resultado = DATEADD(yy,0-@NumeroPeriodos,@FechaInicial)
    END  
  END
  
  RETURN (@Resultado)
END
GO

/**************** spCorteCalcPeriodoFecha ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCalcPeriodoFecha') and type = 'P') drop procedure dbo.spCorteCalcPeriodoFecha
GO             
CREATE PROCEDURE spCorteCalcPeriodoFecha
				@ID				int,
				@IDGenerar		int,
				@Ok				int			 OUTPUT
--//WITH ENCRYPTION				
AS
BEGIN
  DECLARE @CorteFechaD			datetime,
		  @CorteFechaA			datetime,
		  @CorteEjercicio		int,
		  @CortePeriodo			int,
		  @CorteFiltrarFechas	bit

  SELECT @CorteFiltrarFechas	= ISNULL(CorteFiltrarFechas, 0),
		 @CorteFechaD			= CorteFechaD,
		 @CorteFechaA			= CorteFechaA,
		 @CorteEjercicio		= CorteEjercicio,
		 @CortePeriodo			= CortePeriodo
    FROM Corte
   WHERE ID = @ID

  IF @CorteFiltrarFechas = 1
  BEGIN
    UPDATE Corte
       SET CorteFechaD = dbo.fnCorteCalcPeriodoFecha('INICIAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO'),
           CorteFechaA = dbo.fnCorteCalcPeriodoFecha('FINAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO')
      FROM Corte
     WHERE ID = @IDGenerar
  END
  ELSE
  BEGIN
    IF ISNULL(@CorteEjercicio, 0) <> 0
      UPDATE Corte
         SET CorteEjercicio = YEAR(dbo.fnCorteCalcPeriodoFecha('FINAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO'))
        FROM Corte
       WHERE ID = @IDGenerar
    IF ISNULL(@CortePeriodo, 0) <> 0
      UPDATE Corte
         SET CortePeriodo = MONTH(dbo.fnCorteCalcPeriodoFecha('FINAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO'))
        FROM Corte
       WHERE ID = @IDGenerar
    IF ISNULL(@CorteEjercicio, 0) = 0 AND ISNULL(@CortePeriodo, 0) = 0
      UPDATE Corte
         SET CorteFiltrarFechas = 1,
			 CorteFechaD = dbo.fnCorteCalcPeriodoFecha('INICIAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO'),
             CorteFechaA = dbo.fnCorteCalcPeriodoFecha('FINAL', @ID, GETDATE(), 'NUMERO PERIODOS','TIPO PERIODO')
        FROM Corte
       WHERE ID = @IDGenerar    
  END
END
GO

/**************** fnFechaInicialEjercicio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaInicialEjercicio') DROP FUNCTION fnFechaInicialEjercicio
GO
CREATE FUNCTION fnFechaInicialEjercicio(
				@Ejercicio			int,
				@Periodo			int)
RETURNS datetime
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Fecha	datetime
  
  SELECT @Fecha = 0
  
  SELECT @Fecha = dbo.fnFechaSinHora(@Fecha)

  SELECT @Fecha = DATEADD(yy, @Ejercicio - 1900, @Fecha)
  
  IF @Periodo IS NOT NULL
    SELECT @Fecha = DATEADD(mm, @Periodo - 1, @Fecha)
    
  RETURN @Fecha 
END
GO

/**************** spCorteTotalizadorAyudaCaptura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteTotalizadorAyudaCaptura') and type = 'P') drop procedure dbo.spCorteTotalizadorAyudaCaptura
GO
CREATE PROC spCorteTotalizadorAyudaCaptura
			@Mov			varchar(20)	= NULL,
			@Modulo			varchar(5)	= NULL
--//WITH ENCRYPTION
AS
BEGIN
  CREATE TABLE #Totalizador(Totalizador		varchar(255) COLLATE DATABASE_DEFAULT NULL)

  IF ISNULL(@Mov, '') = '' AND ISNULL(@Modulo, '') = ''
  BEGIN
    INSERT INTO #Totalizador(
			  Totalizador)
       SELECT Campo 
         FROM SysCampoExt
        WHERE TipoDatos IN('money', 'float')
          AND Tabla IN(SELECT dbo.fnMovTabla(Modulo) FROM Modulo)
        GROUP BY Campo
        ORDER BY Campo
  END
  ELSE
  BEGIN
    INSERT INTO #Totalizador(
			  Totalizador)
       SELECT Campo 
         FROM SysCampoExt
         JOIN CorteMovTotalizador ON SysCampoExt.Campo = CorteMovTotalizador.Totalizador
        WHERE TipoDatos IN('money', 'float')
          AND CorteMovTotalizador.Mov = @Mov
          AND Tabla IN(SELECT dbo.fnMovTabla(@Modulo))
        GROUP BY Campo
        ORDER BY Campo  
  END
  
  SELECT * FROM #Totalizador
END
GO

/**************** spCorteDConsultaCtaSaldoI ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaCtaSaldoI') and type = 'P') drop procedure dbo.spCorteDConsultaCtaSaldoI
GO
CREATE PROC spCorteDConsultaCtaSaldoI
			@ID					int,
			@RID				int,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CDesglosar			varchar(20),
			@CMoneda			varchar(10),
			@Moneda				varchar(10),
			@TipoCambio			float,
			@MovTipo			varchar(20),
			@CAlmacen			varchar(10),
			@CValuacion			varchar(50),
			@CModulo			varchar(5),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Fecha			datetime,
		  @RIDAux			int,
		  @RIDAuxAnt		int,
		  @Cuenta			varchar(20),
		  @CuentaAnt		varchar(20),
		  @ContMoneda		varchar(10),
		  @Sucursal			int,
		  @SubCuenta		varchar(50),
		  @Empresa			varchar(5),
		  @Saldo			float,
		  @Grupo			varchar(10),
		  @Cargo			float,
		  @Abono			float,
		  @SaldoI			float
		  
  IF ISNULL(@CFiltrarFechas, 0) = 0
    SELECT @Fecha = dbo.fnFechaInicialEjercicio(@CEjercicio, @CPeriodo)
  ELSE
    SELECT @Fecha = @CFechaD

  CREATE TABLE #Saldo(Saldo float NULL)

  IF @MovTipo = 'CORTE.CORTECONTABLE' OR(@MovTipo IN('CORTE.CORTEUNIDADES', 'CORTE.CORTECX') AND ISNULL(@CDesglosar, '') <> 'Movimiento')
  BEGIN
    SELECT @RIDAuxAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @RIDAux = MIN(RID)
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND RID			> @RIDAuxAnt

      IF @RIDAux IS NULL BREAK
    
      SELECT @RIDAuxAnt = @RIDAux
    
      SELECT @Cuenta = NULL, @ContMoneda = NULL, @Sucursal = NULL, @SubCuenta = NULL, @Empresa = NULL, @Grupo = NULL
    
      SELECT @Cuenta	= Cuenta, 
		     @Sucursal	= Sucursal, 
		     @SubCuenta	= SubCuenta,
		     @Empresa	= Empresa,
		     @Grupo		= Grupo
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND RID			= @RIDAux

      DELETE #Saldo

      IF @MovTipo IN('CORTE.CORTECONTABLE')
      BEGIN
        SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
     
        INSERT INTO #Saldo
        EXEC spVerSaldoInicialMSucursal @Empresa, 'CONT', @ContMoneda, @Cuenta, @Fecha, @Sucursal, @SubCuenta
      
        SELECT @Saldo = Saldo / @TipoCambio FROM #Saldo
    
        UPDATE #CorteD
           SET SaldoI		= @Saldo,
               Saldo		= ISNULL(@Saldo, 0) + ISNULL(Cargo, 0) - ISNULL(Abono, 0)
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND RID			= @RIDAux      
      END
      ELSE IF @MovTipo = 'CORTE.CORTEUNIDADES'
      BEGIN 
        INSERT INTO #Saldo
        EXEC spVerSaldoInicialU @Empresa, 'INV', @CMoneda, @Cuenta, @Grupo, @Fecha, ''
      
        SELECT @Saldo = Saldo FROM #Saldo      
 
        UPDATE #CorteD
           SET SaldoUI		= @Saldo,
               SaldoU		= ISNULL(@Saldo, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0)
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND RID			= @RIDAux
      END
      ELSE IF @MovTipo = 'CORTE.CORTECX'      
      BEGIN     
        INSERT INTO #Saldo
        EXEC spVerSaldoInicialMSucursal @Empresa, @CModulo, @CMoneda, @Cuenta, @Fecha, @Sucursal, @SubCuenta
      
        SELECT @Saldo = Saldo / @TipoCambio FROM #Saldo
    
        UPDATE #CorteD
           SET SaldoI		= @Saldo,
               Saldo		= ISNULL(@Saldo, 0) + ISNULL(Cargo, 0) - ISNULL(Abono, 0)
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND RID			= @RIDAux
      END
    END
  END
  ELSE IF @MovTipo = 'CORTE.CORTEUNIDADES' AND ISNULL(@CDesglosar, '') = 'Movimiento'
  BEGIN
    SELECT @CuentaAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Cuenta = MIN(Cuenta)
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			> @CuentaAnt
    
      IF @Cuenta IS NULL BREAK
      
      SELECT @CuentaAnt = @Cuenta
      
      SELECT @Saldo = NULL

      SELECT @Empresa	= Empresa
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			= @CuentaAnt

      INSERT INTO #Saldo
      EXEC spVerSaldoInicialU @Empresa, 'INV', @CMoneda, @Cuenta, @CAlmacen, @Fecha, ''
      
      SELECT @Saldo = ISNULL(Saldo, 0) FROM #Saldo

      SELECT @RIDAuxAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @RIDAux = MIN(RID)
          FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			> @RIDAuxAnt

        IF @RIDAux IS NULL BREAK
    
        SELECT @RIDAuxAnt = @RIDAux, @Cargo = NULL, @Abono = NULL
        
        SELECT @Cargo	= ISNULL(CargoU, 0),
			   @Abono	= ISNULL(AbonoU, 0)
		  FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			= @RIDAux
        
        UPDATE #CorteD 
           SET SaldoUI	= @Saldo,
			   SaldoU	= @Saldo + @Cargo - @Abono
		  FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			= @RIDAux

        SELECT @Saldo = @Saldo + @Cargo - @Abono        
      END

      UPDATE #CorteD
         SET Importe = CASE ISNULL(@CValuacion, '')
					     WHEN '(Sin Valuar)'		THEN NULL
					     WHEN ''					THEN NULL
					     WHEN 'Costo Promedio'		THEN CostoPromedio * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Ultimo Costo'		THEN UltimoCosto * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Estandar'		THEN CostoEstandar * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Reposicion'	THEN CostoReposicion * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'UEPS'				THEN NULL
					     WHEN 'PEPS'				THEN NULL
					     WHEN 'Precio Lista'		THEN PrecioLista * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 2'			THEN Precio2 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 3'			THEN Precio3 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 4'			THEN Precio4 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 5'			THEN Precio5 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 6'			THEN Precio6 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 7'			THEN Precio7 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 8'			THEN Precio8 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 9'			THEN Precio9 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 10'			THEN Precio10 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Promedio (Nivel Opción)'	THEN NULL
					     WHEN 'Ultimo Costo (Nivel Opción)'	THEN NULL
					   END         
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			= @Cuenta
         AND RID			= (SELECT MAX(RID) FROM #CorteD WHERE Cuenta = @Cuenta AND ID = @ID AND RIDConsulta	= @RID)

      UPDATE #CorteD
         SET SaldoUI = NULL
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			= @Cuenta
         AND RID			<> (SELECT MIN(RID) FROM #CorteD WHERE Cuenta = @Cuenta AND ID = @ID AND RIDConsulta	= @RID)         
    END
  END
  ELSE IF @MovTipo = 'CORTE.CORTECX' AND ISNULL(@CDesglosar, '') = 'Movimiento'
  BEGIN
    SELECT @CuentaAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @Cuenta = MIN(Cuenta)
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			> @CuentaAnt
    
      IF @Cuenta IS NULL BREAK
      
      SELECT @CuentaAnt = @Cuenta
      
      SELECT @Saldo = NULL

      SELECT @Empresa	= Empresa
        FROM #CorteD
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			= @CuentaAnt

      INSERT INTO #Saldo
      EXEC spVerSaldoInicialMSucursal @Empresa, @CModulo, @CMoneda, @Cuenta, @Fecha, @Sucursal, @SubCuenta
      
      SELECT @Saldo = ISNULL(Saldo, 0) / @TipoCambio FROM #Saldo

      SELECT @RIDAuxAnt = 0
      WHILE(1=1)
      BEGIN
        SELECT @RIDAux = MIN(RID)
          FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			> @RIDAuxAnt

        IF @RIDAux IS NULL BREAK
    
        SELECT @RIDAuxAnt = @RIDAux, @Cargo = NULL, @Abono = NULL
        
        SELECT @Cargo	= ISNULL(Cargo, 0),
			   @Abono	= ISNULL(Abono, 0)
		  FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			= @RIDAux
        
        UPDATE #CorteD 
           SET SaldoI	= @Saldo,
			   Saldo	= @Saldo + @Cargo - @Abono
		  FROM #CorteD
         WHERE ID			= @ID
           AND RIDConsulta	= @RID
           AND Cuenta		= @Cuenta
           AND RID			= @RIDAux

        SELECT @Saldo = @Saldo + @Cargo - @Abono        
      END

      --UPDATE #CorteD
      --   SET Importe		= Saldo
      -- WHERE ID				= @ID
      --   AND RIDConsulta	= @RID
      --   AND Cuenta			= @Cuenta
      --   AND RID			= (SELECT MAX(RID) FROM #CorteD WHERE Cuenta = @Cuenta AND ID = @ID AND RIDConsulta	= @RID)

      UPDATE #CorteD
         SET SaldoI = NULL
       WHERE ID				= @ID
         AND RIDConsulta	= @RID
         AND Cuenta			= @Cuenta
         AND RID			<> (SELECT MIN(RID) FROM #CorteD WHERE Cuenta = @Cuenta AND ID = @ID AND RIDConsulta	= @RID)         
    END
  END  
END
GO

/**************** spCorteDConsultaObtenerCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaObtenerCx') and type = 'P') drop procedure dbo.spCorteDConsultaObtenerCx
GO
CREATE PROC spCorteDConsultaObtenerCx
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),			
			@Moneda				varchar(10),
			@TipoCambio			float,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
		    @CCuenta			varchar(20),
		    @CCtaCategoria		varchar(50),
		    @CCtaFamilia		varchar(50),
		    @CCtaGrupo			varchar(50),		
		    @CCtaFabricante		varchar(50),
		    @CCtaLinea			varchar(50),
		    @CRama				varchar(50),
		    @CAlmacen			varchar(50),
		    @CValuacion			varchar(50),
		    @CCtaTipo			varchar(50),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  SELECT CxcAux.Empresa,	CxcAux.ID,				CxcAux.Fecha,			(CxcAux.Cargo*TipoCambio)/@TipoCambio,		(CxcAux.Cargo*TipoCambio)/CxcAux.Abono,
         Cte.Cliente,		@ID,					@RID,					CxcAux.Mov,									CxcAux.MovID,
         EsCancelacion
    FROM CxcAux
    JOIN Cte ON CxcAux.Cliente = Cte.Cliente
   WHERE ISNULL(CxcAux.Empresa, '')  =  ISNULL(@CEmpresa, ISNULL(CxcAux.Empresa, ''))
     AND ISNULL(CxcAux.Moneda, '')	 =  ISNULL(@CMoneda, ISNULL(CxcAux.Moneda, ''))
     AND ISNULL(Cte.Cliente, '')	 = ISNULL(@CContacto, ISNULL(Cte.Cliente, ''))
     AND CxcAux.Fecha				 >= ISNULL(@CFechaD, CxcAux.Fecha) 
     AND CxcAux.Fecha				 <= ISNULL(@CFechaA, CxcAux.Fecha) 
	 AND ISNULL(CxcAux.Ejercicio, 0) = ISNULL(@CEjercicio, ISNULL(CxcAux.Ejercicio, 0))
	 AND ISNULL(CxcAux.Periodo, 0)	 = ISNULL(@CPeriodo, ISNULL(CxcAux.Periodo, 0))
     AND ISNULL(CxcAux.Mov, '')		 =  ISNULL(@CMovimiento, ISNULL(CxcAux.Mov, ''))	      
     AND ISNULL(Cte.Categoria, '')	 =  ISNULL(@CCtaCategoria, ISNULL(Cte.Categoria, ''))
     AND ISNULL(Cte.Familia, '')	 =  ISNULL(@CCtaFamilia, ISNULL(Cte.Familia, ''))
     AND ISNULL(Cte.Grupo, '')		 =  ISNULL(@CCtaGrupo, ISNULL(Cte.Grupo, ''))
     AND ISNULL(Cte.Tipo, '')		 =  ISNULL(@CCtaTipo, ISNULL(Cte.Tipo, ''))
     AND ISNULL(CxcAux.Rama, '')	 =  ISNULL(@CRama, ISNULL(CxcAux.Rama, ''))     
   ORDER BY Cte.Cliente, CxcAux.Fecha, CxcAux.ID 
  
  RETURN
END
GO

/**************** spCorteDConsultaObtenerUnidades ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaObtenerUnidades') and type = 'P') drop procedure dbo.spCorteDConsultaObtenerUnidades
GO
CREATE PROC spCorteDConsultaObtenerUnidades
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),			
			@Moneda				varchar(10),
			@TipoCambio			float,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
		    @CCuenta			varchar(20),
		    @CCtaCategoria		varchar(50),
		    @CCtaFamilia		varchar(50),
		    @CCtaGrupo			varchar(50),		
		    @CCtaFabricante		varchar(50),
		    @CCtaLinea			varchar(50),
		    @CRama				varchar(50),
		    @CAlmacen			varchar(50),
		    @CValuacion			varchar(50),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  SELECT InvAuxU.Empresa,				InvAuxU.Cuenta,					InvAuxU.SubCuenta,					InvAuxU.Fecha,							InvAuxU.CargoU,
		 Art.PrecioLista/@TipoCambio,	Art.Precio2/@TipoCambio,		Art.Precio3/@TipoCambio,			InvAuxU.AbonoU,							Art.Precio4/@TipoCambio,					
		 Art.Precio5/@TipoCambio,		Art.Precio6/@TipoCambio,		Art.Precio7/@TipoCambio,			Art.Precio8/@TipoCambio,				Art.Precio9/@TipoCambio,
		 Art.Precio10/@TipoCambio,		Art.CostoEstandar/@TipoCambio,	Art.CostoReposicion/@TipoCambio,	ArtConCosto.CostoPromedio/@TipoCambio,	ArtConCosto.UltimoCosto/@TipoCambio,
		 InvAuxU.Mov,					InvAuxU.MovID,					@ID,								@RID,									ID,							
		 EsCancelacion,					InvAuxU.Grupo
    FROM InvAuxU
   RIGHT OUTER JOIN Art ON InvAuxU.Articulo=Art.Articulo
   RIGHT OUTER JOIN ArtConCosto ON Art.Articulo=ArtConCosto.Articulo AND ISNULL(ArtConCosto.Empresa, '') = ISNULL(@CEmpresa, ISNULL(ArtConCosto.Empresa, ''))
   WHERE ISNULL(InvAuxU.Empresa, '') =  ISNULL(@CEmpresa, ISNULL(InvAuxU.Empresa, ''))
     AND ISNULL(InvAuxU.Rama, '')	 =  ISNULL(@CRama, ISNULL(InvAuxU.Rama, ''))
     AND ISNULL(InvAuxU.Moneda, '')	 =  ISNULL(@CMoneda, ISNULL(InvAuxU.Moneda, ''))
     AND ISNULL(Art.Articulo, '')	 = ISNULL(@CCuenta, ISNULL(Art.Articulo, ''))
     AND ISNULL(InvAuxU.Mov, '')	 =  ISNULL(@CMovimiento, ISNULL(InvAuxU.Mov, ''))
     AND ISNULL(InvAuxU.Grupo, '')	 =  ISNULL(@CAlmacen, ISNULL(InvAuxU.Grupo, ''))
     AND ISNULL(Art.Categoria, '')	 =  ISNULL(@CCtaCategoria, ISNULL(Art.Categoria, ''))
     AND ISNULL(Art.Familia, '')	 =  ISNULL(@CCtaFamilia, ISNULL(Art.Familia, ''))
     AND ISNULL(Art.Grupo, '')		 =  ISNULL(@CCtaGrupo, ISNULL(Art.Grupo, ''))
     AND ISNULL(Art.Fabricante, '')	 =  ISNULL(@CCtaFabricante, ISNULL(Art.Fabricante, ''))
     AND ISNULL(Art.Linea, '')		 =  ISNULL(@CCtaLinea, ISNULL(Art.Linea, ''))  
     AND InvAuxU.Fecha				 >= ISNULL(@CFechaD, InvAuxU.Fecha) 
     AND InvAuxU.Fecha				 <= ISNULL(@CFechaA, InvAuxU.Fecha) 
	 AND ISNULL(InvAuxU.Ejercicio, 0)= ISNULL(@CEjercicio, ISNULL(InvAuxU.Ejercicio, 0))
	 AND ISNULL(InvAuxU.Periodo, 0)	 = ISNULL(@CPeriodo, ISNULL(InvAuxU.Periodo, 0))
   ORDER BY Art.Articulo, InvAuxU.SubCuenta, InvAuxU.Fecha, InvAuxU.ID

  RETURN
END
GO

/**************** spCorteDConsultaObtenerCta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaObtenerCta') and type = 'P') drop procedure dbo.spCorteDConsultaObtenerCta
GO
CREATE PROC spCorteDConsultaObtenerCta
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),			
			@Moneda				varchar(10),
			@TipoCambio			float,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
		    @CCuenta			varchar(20),
		    @CCtaCategoria		varchar(50),
		    @CCtaFamilia		varchar(50),
		    @CCtaGrupo			varchar(50),			
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  SELECT ContAux.ID,				ContAux.Empresa,					ContAux.Cuenta,						ContAux.SubCuenta,
		 ContAux.Ejercicio,			ContAux.Periodo,					ContAux.Renglon,					ContAux.RenglonSub,
		 ContAux.Concepto,			ContAux.Debe/@TipoCambio 'Debe',	ContAux.Haber/@TipoCambio 'Haber',	ContAux.FechaContable,
		 ContAux.Movimiento,		ContMov = ContAux.Mov,				ContAux.Referencia,					ContAux.Estatus,
		 ContAux.SucursalContable,	ContAux.MovID,						ContAux.ContactoTipo,				ContAux.Contacto
    INTO #TempContAux
    FROM ContAux
    JOIN dbo.fnCtaAuxiliar(@CCuenta) Cta ON ContAux.Cuenta = Cta.Cuenta
   WHERE ISNULL(ContAux.Empresa, '')			= ISNULL(@CEmpresa, ISNULL(ContAux.Empresa, ''))  
     AND ISNULL(ContAux.Estatus, '')			= ISNULL(@CEstatus, ISNULL(ContAux.Estatus, ''))  
     AND ContAux.FechaContable					>= ISNULL(@CFechaD, ContAux.FechaContable) 
     AND ContAux.FechaContable					<= ISNULL(@CFechaA, ContAux.FechaContable) 
	 AND ISNULL(ContAux.Ejercicio, 0)			= ISNULL(@CEjercicio, ISNULL(ContAux.Ejercicio, 0))
	 AND ISNULL(ContAux.Periodo, 0)				= ISNULL(@CPeriodo, ISNULL(ContAux.Periodo, 0))
     AND ISNULL(ContAux.Mov, '')				= ISNULL(@CMovimiento, ISNULL(ContAux.Mov, ''))
     AND ISNULL(ContAux.SucursalContable, 0)	= ISNULL(@CSucursal, ISNULL(ContAux.SucursalContable, 0))
     AND ISNULL(ContAux.UEN, 0)					= ISNULL(@CUEN, ISNULL(ContAux.UEN, 0))
     AND ISNULL(ContAux.Proyecto, '')			= ISNULL(@CProyecto, ISNULL(ContAux.Proyecto, ''))
     AND ISNULL(ContAux.ContactoTipo, '')		= ISNULL(@CContactoTipo, ISNULL(ContAux.ContactoTipo, ''))
     AND ISNULL(ContAux.Contacto, '')			= ISNULL(@CContacto, ISNULL(ContAux.Contacto, ''))
     AND (ISNULL(ContAux.Debe, 0)				BETWEEN ISNULL(@CImporteMin, ISNULL(ContAux.Debe, 0)) AND ISNULL(@CImporteMax, ISNULL(ContAux.Debe, 0))
      OR ISNULL(ContAux.Haber, 0)				BETWEEN ISNULL(@CImporteMin, ISNULL(ContAux.Haber, 0)) AND ISNULL(@CImporteMax, ISNULL(ContAux.Haber, 0))
         )
  ORDER BY ContAux.Cuenta, ContAux.FechaContable, ContAux.ID 

  SELECT @ID,								Cta.Cuenta,					t.SubCuenta,		
		 t.Debe,							t.Haber,					t.SucursalContable,		
		 @RID,								t.ContMov,					t.MovID,			
		 t.Periodo,							t.Ejercicio,				dbo.fnCtaMayor(Cta.Cuenta),
		 dbo.fnCtaSubCuenta(Cta.Cuenta),	t.Empresa,					t.FechaContable
    FROM Cta
    JOIN #TempContAux t ON Cta.Cuenta = t.Cuenta
   WHERE Cta.TieneMovimientos	 = 1 
     AND Cta.EsAcumulativa		 = 0
     AND ISNULL(Cta.Categoria, 0) = ISNULL(ISNULL(@CCtaCategoria, Cta.Categoria), 0)
     AND ISNULL(Cta.Familia, 0)	 = ISNULL(ISNULL(@CCtaFamilia, Cta.Familia), 0)
     AND ISNULL(Cta.Grupo, 0)	 = ISNULL(ISNULL(@CCtaGrupo, Cta.Grupo), 0)
  ORDER BY Cta.Cuenta, t.FechaContable, t.ID  ASC
  
  RETURN
END
GO

/**************** spCorteDConsultaObtenerMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaObtenerMov') and type = 'P') drop procedure dbo.spCorteDConsultaObtenerMov
GO
CREATE PROC spCorteDConsultaObtenerMov
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),			
			@Moneda				varchar(10),
			@TipoCambio			float,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  IF @CModulo = 'AF'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM ActivoFijo e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Proveedor, '')	= ISNULL(@CContacto, ISNULL(e.Proveedor, ''))	   
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'AGENT'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Agent e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(Agente, '')		= ISNULL(@CContacto, ISNULL(Agente, ''))	   
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'ASIS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Asiste e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CAM'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Cambio e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CAP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Capital e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CAPT'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Captura e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CMP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Campana e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'COMS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Compra e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Proveedor, '')	= ISNULL(@CContacto, ISNULL(e.Proveedor, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CONC'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Conciliacion e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CONT'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Cont e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(Contacto, '')		= ISNULL(@CContacto, ISNULL(Contacto, ''))	   
	   AND ISNULL(ContactoTipo, '')	= ISNULL(@CContactoTipo, ISNULL(ContactoTipo, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	     
  END ELSE IF @CModulo = 'CORTE'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
	  FROM Corte e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))
	   AND e.ID					   <> @ID
  END ELSE IF @CModulo = 'CP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM CP e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, '')) 
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	      
  END ELSE IF @CModulo = 'CR'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM CR e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))      
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CREDI'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Credito e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))       
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	    
  END ELSE IF @CModulo = 'CXC'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Cxc e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, '')) 
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'CXP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Cxp e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Proveedor, '')	= ISNULL(@CContacto, ISNULL(e.Proveedor, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, '')) 
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	    
  END ELSE IF @CModulo = 'DIN'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Dinero e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(Contacto, '')		= ISNULL(@CContacto, ISNULL(Contacto, ''))	   
	   AND ISNULL(ContactoTipo, '')	= ISNULL(@CContactoTipo, ISNULL(ContactoTipo, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	       
  END ELSE IF @CModulo = 'EMB'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Embarque e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   --AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))	   
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, '')) 
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	        
  END ELSE IF @CModulo = 'FIS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Fiscal e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'OPORT'
  --REQ16092
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Oportunidad e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'FRM'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM FormaExtra e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'GAS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				NULL 'Referencia',
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Gasto e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(Acreedor, '')		= ISNULL(@CContacto, ISNULL(Acreedor, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))      
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	     
  END ELSE IF @CModulo = 'GES'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Gestion e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'INC'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Incidencia e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(Acreedor, '')		= ISNULL(@CContacto, ISNULL(Acreedor, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	            
  END ELSE IF @CModulo = 'INV'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Inv e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))     
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	            
  END ELSE IF @CModulo = 'ISL'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM ISL e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))   
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	                
  END ELSE IF @CModulo = 'NOM'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				NULL 'Referencia',
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Nomina e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'OFER'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Oferta e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Proveedor, '')	= ISNULL(@CContacto, ISNULL(e.Proveedor, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))      
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'ORG'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Organiza e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))   
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'PACTO'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Contrato e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND (ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	    OR ISNULL(e.Proveedor, '')	= ISNULL(@CContacto, ISNULL(e.Proveedor, ''))
	    OR ISNULL(Agente, '')		= ISNULL(@CContacto, ISNULL(Agente, '')))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	    
  END ELSE IF @CModulo = 'PC'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM PC e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))     
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'PCP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM PCP e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'PPTO'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Presup e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))     
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	    
  END ELSE IF @CModulo = 'PROD'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Prod e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'PROY'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Proyecto e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))   
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	    
  END ELSE IF @CModulo = 'RE'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Recluta e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))      
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'RH'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM RH e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))    
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'RSS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM RSS e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'SAUX'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM SAUX e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'ST'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Soporte e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'TMA'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL 'Moneda',		Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL 'Importe',
		   @RID 'RID',			@ID 'ID',		NULL 'TipoCambio',	e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM TMA e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0)			= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'VALE'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
      FROM Vale e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))  
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))       
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   	   
  END ELSE IF @CModulo = 'VTAS'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		Moneda,				Referencia,			
		   e.Almacen 'Grupo',	e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		TipoCambio,			e.Periodo,			e.Ejercicio,
		   e.Estatus
	  FROM Venta e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND ISNULL(e.Cliente, '')	= ISNULL(@CContacto, ISNULL(e.Cliente, ''))
	   AND ISNULL(e.Importe, 0)		BETWEEN ISNULL(@CImporteMin, ISNULL(e.Importe, 0)) AND ISNULL(@CImporteMax, ISNULL(e.Importe, 0))
	   AND ISNULL(e.Moneda, '')		= ISNULL(@CMoneda, ISNULL(e.Moneda, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   
  --REQ25014
  END ELSE IF @CModulo = 'CONTP'
  BEGIN
    SELECT Mov,					MovID,			FechaEmision,		NULL,				Referencia,			
		   NULL 'Grupo',		e.Sucursal,		@CModulo 'Modulo',	e.ID 'ModuloID',	NULL,
		   @RID 'RID',			@ID 'ID',		NULL,				e.Periodo,			e.Ejercicio,
		   e.Estatus
	  FROM ContParalela e
     WHERE ISNULL(e.Empresa, '')	= ISNULL(@CEmpresa, ISNULL(e.Empresa, ''))
	   AND ISNULL(e.Sucursal, 0)	= ISNULL(@CSucursal, ISNULL(e.Sucursal, 0))
	   AND ISNULL(e.UEN, 0) 		= ISNULL(@CUEN, ISNULL(e.UEN, 0))
	   AND ISNULL(e.Usuario, '')	= ISNULL(@CUsuario, ISNULL(e.Usuario, ''))
	   AND ISNULL(e.Mov, '')		= ISNULL(@CMovimiento, ISNULL(e.Mov, ''))
	   AND ISNULL(e.Estatus, '')	= ISNULL(@CEstatus, ISNULL(e.Estatus, ''))
	   AND ISNULL(e.Situacion, '')	= ISNULL(@CSituacion, ISNULL(e.Situacion, ''))
	   AND ISNULL(e.Proyecto, '')	= ISNULL(@CProyecto, ISNULL(e.Proyecto, ''))
	   AND e.FechaEmision			BETWEEN ISNULL(@CFechaD, e.FechaEmision) AND ISNULL(@CFechaA, e.FechaEmision)
	   AND ISNULL(e.Ejercicio, 0)	= ISNULL(@CEjercicio, ISNULL(e.Ejercicio, 0))
	   AND ISNULL(e.Periodo, 0)		= ISNULL(@CPeriodo, ISNULL(e.Periodo, 0))	   	   
  END
  
  RETURN 
END
GO

/**************** spCorteDConsultaMovImporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaMovImporte') and type = 'P') drop procedure dbo.spCorteDConsultaMovImporte
GO
CREATE PROC spCorteDConsultaMovImporte
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),			
			@Moneda				varchar(10),
			@TipoCambio			float,
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @SQL				nvarchar(max),
		  @Parametros		nvarchar(max),
		  @Tabla			varchar(255),
		  @TipoTotalizador	varchar(255)

  SELECT @TipoTotalizador = Tipo FROM CorteMovTotalizadorTipoCampo WHERE Totalizador = @CTotalizador

  SELECT @Tabla = ISNULL(dbo.fnMovTabla(@CModulo), '')
 
  IF @Tabla = ''
  BEGIN
    SELECT @Ok = 10380, @OkRef = @CModulo
    RETURN
  END
  
  SELECT @Parametros = '@RID				int,
						@TipoCambio			float'
  
  IF @TipoTotalizador = 'Monetario'
    SELECT @SQL = 'UPDATE c 
                      SET c.Importe = (m.' + ISNULL(@CTotalizador, '') + ' * m.TipoCambio) / @TipoCambio
                     FROM #CorteDTmp c
                     JOIN ' + @Tabla + ' m ON c.ModuloID = m.ID
                    WHERE c.RIDConsulta = @RID'
  ELSE IF @TipoTotalizador = 'Unidad'
    SELECT @SQL = 'UPDATE c 
                      SET c.SaldoU = m.' + ISNULL(@CTotalizador, '') + '
                     FROM #CorteDTmp c
                     JOIN ' + @Tabla + ' m ON c.ModuloID = m.ID
                    WHERE c.RIDConsulta = @RID'
                    
  BEGIN TRY
    EXEC sp_executesql @SQL, @Parametros, @RID = @RID, @TipoCambio = @TipoCambio
  END TRY
  BEGIN CATCH
    SELECT @Ok = 1, @OkRef = dbo.fnOkRefSQL(ERROR_NUMBER(), ERROR_MESSAGE())
  END CATCH
END
GO

/**************** spCorteDConsultaImporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaImporte') and type = 'P') drop procedure dbo.spCorteDConsultaImporte
GO
CREATE PROC spCorteDConsultaImporte
			@ID					int, 
			@RID				int, 
			@MovTipo			varchar(20),
			@CorteValuacion		varchar(50),
			@CDesglosar			varchar(20),
			@Ok					int				OUTPUT, 
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Importe		float,
		  @SaldoU		float,
		  @SaldoI		float,
		  @Cargo		float,
		  @Abono		float

  IF @MovTipo = 'CORTE.CORTEIMPORTE'
  BEGIN
    SELECT @Importe = SUM(Importe) ,
		   @SaldoU	= SUM(SaldoU)
      FROM #CorteD
     WHERE RIDConsulta = @RID
  
    UPDATE CorteDConsulta
       SET Importe	= @Importe,
		   SaldoU	= @SaldoU
     WHERE ID		= @ID
       AND RID		= @RID  
  END
  ELSE IF @MovTipo IN('CORTE.CORTECONTABLE', 'CORTE.CORTECX')
  BEGIN  
    SELECT Cuenta, ISNULL(SaldoI, 0) 'SaldoI', SUM(ISNULL(Cargo, 0)) 'Cargo', SUM(ISNULL(Abono, 0)) 'Abono'
      INTO #Total
      FROM #CorteD
     WHERE ID			= @ID
       AND RIDConsulta	= @RID  
	 GROUP BY Cuenta, SaldoI

    SELECT @SaldoI = SUM(SaldoI),
		   @Cargo  = SUM(Cargo),
		   @Abono  = SUM(Abono)
	  FROM #Total

    UPDATE CorteDConsulta
       SET SaldoI	= @SaldoI,
		   Cargo	= @Cargo,
		   Abono	= @Abono,
		   Saldo	= @SaldoI + @Cargo - @Abono
     WHERE ID		= @ID
       AND RID		= @RID	  
  END
  ELSE IF @MovTipo = 'CORTE.CORTEUNIDADES'
  BEGIN
    IF ISNULL(@CDesglosar, '') IN('Articulo', 'No')
      UPDATE #CorteD
         SET Importe = CASE ISNULL(@CorteValuacion, '')
					     WHEN '(Sin Valuar)'		THEN NULL
					     WHEN ''					THEN NULL
					     WHEN 'Costo Promedio'		THEN CostoPromedio * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Ultimo Costo'		THEN UltimoCosto * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Estandar'		THEN CostoEstandar * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Reposicion'	THEN CostoReposicion * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'UEPS'				THEN NULL
					     WHEN 'PEPS'				THEN NULL
					     WHEN 'Precio Lista'		THEN PrecioLista * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 2'			THEN Precio2 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 3'			THEN Precio3 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 4'			THEN Precio4 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 5'			THEN Precio5 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 6'			THEN Precio6 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 7'			THEN Precio7 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 8'			THEN Precio8 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 9'			THEN Precio9 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Precio 10'			THEN Precio10 * (ISNULL(SaldoUI, 0) + ISNULL(CargoU, 0) - ISNULL(AbonoU, 0))
					     WHEN 'Costo Promedio (Nivel Opción)'	THEN NULL
					     WHEN 'Ultimo Costo (Nivel Opción)'	THEN NULL
					   END

    SELECT Cuenta,					Grupo,			ISNULL(SaldoUI, 0) 'SaldoUI',	SUM(ISNULL(CargoU, 0)) 'CargoU',	SUM(ISNULL(AbonoU, 0)) 'AbonoU',
		   CostoPromedio,			UltimoCosto,	PrecioLista,					Precio2,							Precio3, 
		   Precio4,					Precio5,		Precio6,						Precio7,							Precio8, 
		   Precio9,					Precio10,		CostoEstandar,					CostoReposicion,					CostoUnitario, 
		   CostoUnitarioOtraMoneda, MonedaContable,	SUM(Importe) 'Importe'
	  INTO #TotalU
      FROM #CorteD
     WHERE ID			= @ID
       AND RIDConsulta	= @RID
	 GROUP BY Cuenta, Grupo, ISNULL(SaldoUI, 0), CostoPromedio, UltimoCosto, PrecioLista, Precio2, Precio3, Precio4, Precio5, Precio6, 
			  Precio7, Precio8, Precio9, Precio10, CostoEstandar, CostoReposicion, CostoUnitario, CostoUnitarioOtraMoneda, MonedaContable

    SELECT @SaldoI  = SUM(SaldoUI),
		   @Cargo   = SUM(CargoU),
		   @Abono   = SUM(AbonoU),
		   @Importe	= SUM(Importe)
	  FROM #TotalU

    UPDATE CorteDConsulta
       SET SaldoUI	= @SaldoI,
		   CargoU	= @Cargo,
		   AbonoU	= @Abono,
		   SaldoU	= @SaldoI + @Cargo - @Abono,
		   Importe	= @Importe
     WHERE ID		= @ID
       AND RID		= @RID	    
  END
END
GO

/**************** spCorteDConsultaProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsultaProcesar') and type = 'P') drop procedure dbo.spCorteDConsultaProcesar
GO
CREATE PROC spCorteDConsultaProcesar
			@ID					int,
			@RID				int,

			@CEmpresa			varchar(5),
			@CSucursal			int,
			@CUEN				int,
			@CUsuario			varchar(10),
			@CModulo			varchar(5),
			@CMovimiento		varchar(20),
			@CEstatus			varchar(15),
			@CSituacion			varchar(50),
			@CProyecto			varchar(50),
			@CContactoTipo		varchar(20),
			@CContacto			varchar(10),
			@CImporteMin		float,
			@CImporteMax		float,
			@CValidarAlEmitir	bit,
			@CAccion			varchar(8),
			@CDesglosar			varchar(20),
			@CAgrupador			varchar(50),
			@CMoneda			varchar(10),
			@Moneda				varchar(10),
			@TipoCambio			float,
			@MovTipo     		char(20),
			@SubMovTipo			char(20),
			@CFiltrarFechas		bit,
			@CPeriodo			int, 
			@CEjercicio			int, 
			@CFechaD			datetime, 
			@CFechaA			datetime,
			@CTotalizador		varchar(255),
		    @CCuenta			varchar(20),
		    @CCtaCategoria		varchar(50),
		    @CCtaFamilia		varchar(50),
		    @CCtaGrupo			varchar(50),
		    @CCtaFabricante		varchar(50),
		    @CCtaLinea			varchar(50),
		    @CRama				varchar(50),
		    @CAlmacen			varchar(50),
		    @CValuacion			varchar(50),
		    @CCtaTipo			varchar(50),
			@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  CREATE TABLE #CorteDTmp(
    Mov				varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    MovID			varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    Fecha			datetime	NULL, 
    Moneda			varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    Referencia		varchar(50)	COLLATE DATABASE_DEFAULT NULL, 
    Grupo			varchar(10)	COLLATE DATABASE_DEFAULT NULL, 
    Sucursal		int			NULL, 
    Modulo			varchar(5)	COLLATE DATABASE_DEFAULT NULL, 
    ModuloID		int			NULL, 
    Importe			float		NULL, 
    RIDConsulta		int			NULL, 
    ID				int			NULL, 
    TipoCambio		float		NULL,
    Periodo			int			NULL,
    Ejercicio		int			NULL,
    Cuenta			varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    SubCuenta		varchar(50)	COLLATE DATABASE_DEFAULT NULL, 
    Cargo			float		NULL,
    Abono			float		NULL,
    Estatus			varchar(15)	NULL,
    CtaMayor		varchar(20)	COLLATE DATABASE_DEFAULT NULL, 
    CtaSubCuenta	varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    Empresa			varchar(5)	COLLATE DATABASE_DEFAULT NULL,
    CargoU			float		NULL,
    PrecioLista		float		NULL, 
    Precio2			float		NULL, 
    Precio3			float		NULL, 
    AbonoU			float		NULL, 
    Precio4			float		NULL, 
    Precio5			float		NULL, 
    Precio6			float		NULL, 
    Precio7			float		NULL, 
    Precio8			float		NULL, 
    Precio9			float		NULL, 
    Precio10		float		NULL, 
    CostoEstandar	float		NULL, 
    CostoReposicion	float		NULL, 
    CostoPromedio	float		NULL, 
    UltimoCosto		float		NULL,
    AuxID			int			NULL,
    EsCancelacion	bit			NULL,
	SaldoU			float		NULL,
	SaldoUI			float		NULL
    )
        
  IF @MovTipo = 'CORTE.CORTEIMPORTE'
  BEGIN
    INSERT INTO #CorteDTmp(Mov, MovID, Fecha, Moneda, Referencia, Grupo, Sucursal, Modulo, ModuloID, Importe, RIDConsulta, ID, TipoCambio, Periodo, Ejercicio, Estatus)
    EXEC spCorteDConsultaObtenerMov @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								    @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								    @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @CFiltrarFechas,
									@CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CTotalizador, 
									@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    EXEC spCorteDConsultaMovImporte @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								    @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								    @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @CFiltrarFechas,
								    @CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CTotalizador,
								    @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @CDesglosar IN('Movimiento', 'No')
      INSERT INTO #CorteD(
				Mov,		MovID,			Fecha,		Moneda,			Referencia,			Grupo,		Sucursal,		Modulo,			ModuloID,	
				Importe,	RIDConsulta,	ID,			TipoCambio,		Periodo,			Ejercicio,	Estatus,		SaldoU)
		 SELECT Mov,		MovID,			Fecha,		Moneda,			Referencia,			Grupo,		Sucursal,		Modulo,			ModuloID,	
				Importe,	RIDConsulta,	ID,			TipoCambio,		Periodo,			Ejercicio,	Estatus,		SaldoU
		   FROM #CorteDTmp
		  WHERE ID			= @ID
		    AND RIDConsulta	= @RID
		  ORDER BY Fecha, Mov, MovID
    ELSE IF @CDesglosar = 'Periodo'
      INSERT INTO #CorteD(
				Mov,			MovID,			Fecha,		Moneda,			Referencia,			Grupo,		Sucursal,		Modulo,			ModuloID,	
				Importe,		RIDConsulta,	ID,			TipoCambio,		Periodo,			Ejercicio,	Estatus,		SaldoU)
		 SELECT NULL,			NULL,			NULL,		NULL,			NULL,				NULL,		NULL,			NULL,			NULL,	
				SUM(Importe),	RIDConsulta,	ID,			NULL,			Periodo,			Ejercicio,	NULL,			SUM(SaldoU)
		   FROM #CorteDTmp
		  WHERE ID			= @ID
		    AND RIDConsulta	= @RID
         GROUP BY RIDConsulta, ID, Periodo, Ejercicio
         ORDER BY RIDConsulta, ID, Periodo, Ejercicio
    ELSE IF @CDesglosar = 'Ejercicio'
      INSERT INTO #CorteD(
				Mov,			MovID,			Fecha,		Moneda,			Referencia,			Grupo,		Sucursal,		Modulo,			ModuloID,	
				Importe,		RIDConsulta,	ID,			TipoCambio,		Periodo,			Ejercicio,	Estatus,		SaldoU)
		 SELECT NULL,			NULL,			NULL,		NULL,			NULL,				NULL,		NULL,			NULL,			NULL,	
				SUM(Importe),	RIDConsulta,	ID,			NULL,			NULL,				Ejercicio,	NULL,			SUM(SaldoU)
		   FROM #CorteDTmp
		  WHERE ID			= @ID
		    AND RIDConsulta	= @RID
         GROUP BY RIDConsulta, ID, Ejercicio
         ORDER BY RIDConsulta, ID, Ejercicio
  END
  ELSE IF @MovTipo = 'CORTE.CORTECONTABLE'
  BEGIN  
    INSERT INTO #CorteDTmp(ID, Cuenta, SubCuenta, Cargo, Abono, Sucursal, RIDConsulta, Mov, MovID, Periodo, Ejercicio, CtaMayor, CtaSubCuenta, Empresa, Fecha)
    EXEC spCorteDConsultaObtenerCta @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								    @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								    @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @CFiltrarFechas,
									@CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CTotalizador, @CCuenta, @CCtaCategoria,
									@CCtaFamilia, @CCtaGrupo, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
									
    IF @CDesglosar IN('Movimiento')
      INSERT INTO #CorteD(
			    RIDConsulta,	ID,			Cuenta,			Cargo,			Abono,		Mov,		MovID,		Empresa,
			    Sucursal)
	     SELECT RIDConsulta,	ID,			Cuenta,			Cargo,			Abono,		Mov,		MovID,		Empresa,
				Sucursal
  		   FROM #CorteDTmp
          ORDER BY Cuenta, Fecha, ID  ASC
    IF @CDesglosar IN('No', 'Auxiliar')
      INSERT INTO #CorteD(
			    RIDConsulta,	ID,			Cuenta,			Cargo,			Abono,			Empresa,
			    Sucursal)
	     SELECT RIDConsulta,	ID,			Cuenta,			SUM(Cargo),		SUM(Abono),		Empresa,
				Sucursal
  		   FROM #CorteDTmp
		  GROUP BY RIDConsulta, ID, Cuenta, Empresa, Sucursal
		  ORDER BY RIDConsulta, ID, Cuenta, Empresa, Sucursal
    ELSE IF @CDesglosar IN('Mayor')
      INSERT INTO #CorteD(
			    RIDConsulta,		ID,			Cuenta,			Cargo,			Abono,			Empresa,
			    Sucursal)
	     SELECT RIDConsulta,		ID,			CtaMayor,		SUM(Cargo),		SUM(Abono),		Empresa,
				Sucursal
  		   FROM #CorteDTmp
		  GROUP BY RIDConsulta, ID, CtaMayor, Empresa, Sucursal
    ELSE IF @CDesglosar IN('SubCuenta')
      INSERT INTO #CorteD(
			    RIDConsulta,		ID,			Cuenta,			Cargo,			Abono,			Empresa,
			    Sucursal)
	     SELECT RIDConsulta,		ID,			CtaSubCuenta,	SUM(Cargo),		SUM(Abono),		Empresa,
				Sucursal
  		   FROM #CorteDTmp
		  GROUP BY RIDConsulta, ID, CtaSubCuenta, Empresa, Sucursal
		  ORDER BY RIDConsulta, ID, CtaSubCuenta, Empresa, Sucursal
  END
  ELSE IF @MovTipo = 'CORTE.CORTEUNIDADES'
  BEGIN  
    INSERT INTO #CorteDTmp(Empresa, Cuenta, SubCuenta, Fecha, CargoU, PrecioLista, Precio2, Precio3, AbonoU, Precio4, Precio5, Precio6, Precio7, Precio8, Precio9, Precio10, CostoEstandar, CostoReposicion, CostoPromedio, UltimoCosto, Mov, MovID, ID, RIDConsulta, AUXID, EsCancelacion, Grupo)
    EXEC spCorteDConsultaObtenerUnidades @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								    @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								    @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @CFiltrarFechas,
									@CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CTotalizador, @CCuenta, @CCtaCategoria,
									@CCtaFamilia, @CCtaGrupo, @CCtaFabricante, @CCtaLinea, @CRama, @CAlmacen, @CValuacion,
									@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @CDesglosar IN('Movimiento')
      INSERT INTO #CorteD(
				Empresa,		Cuenta,				SubCuenta,		Fecha,			CargoU,			PrecioLista,		Precio2,		Precio3, 
				AbonoU,			Precio4,			Precio5,		Precio6,		Precio7,		Precio8,			Precio9,		Precio10, 
				CostoEstandar,	CostoReposicion,	CostoPromedio,	UltimoCosto,	Mov,			MovID,				ID,				RIDConsulta,
				EsCancelacion,	Grupo)
		 SELECT Empresa,		Cuenta,				SubCuenta,		Fecha,			CargoU,			PrecioLista,		Precio2,		Precio3, 
				AbonoU,			Precio4,			Precio5,		Precio6,		Precio7,		Precio8,			Precio9,		Precio10, 
				CostoEstandar,	CostoReposicion,	CostoPromedio,	UltimoCosto,	Mov,			MovID,				ID,				RIDConsulta,
				EsCancelacion,	Grupo
		   FROM #CorteDTmp
          ORDER BY Cuenta, SubCuenta, Fecha, ID		   
 
    ELSE IF @CDesglosar IN('Articulo', 'No')
      INSERT INTO #CorteD(
				Empresa,		Cuenta,				SubCuenta,		Fecha,			CargoU,			PrecioLista,		Precio2,		Precio3, 
				AbonoU,			Precio4,			Precio5,		Precio6,		Precio7,		Precio8,			Precio9,		Precio10, 
				CostoEstandar,	CostoReposicion,	CostoPromedio,	UltimoCosto,	Mov,			MovID,				ID,				RIDConsulta,
				EsCancelacion,	Grupo)
		 SELECT Empresa,		Cuenta,				SubCuenta,		NULL,			SUM(CargoU),	PrecioLista,		Precio2,		Precio3, 
				SUM(AbonoU),	Precio4,			Precio5,		Precio6,		Precio7,		Precio8,			Precio9,		Precio10, 
				CostoEstandar,	CostoReposicion,	CostoPromedio,	UltimoCosto,	NULL,			NULL,				ID,				RIDConsulta,
				NULL,			Grupo
		   FROM #CorteDTmp
		  GROUP BY Empresa, Cuenta, SubCuenta, PrecioLista, Precio2, Precio3, Precio4, Precio5, Precio6, Precio7, Precio8, Precio9, Precio10, 
				   CostoEstandar, CostoReposicion, CostoPromedio, UltimoCosto, ID, RIDConsulta, Grupo
          ORDER BY Cuenta, SubCuenta
  END
  IF @MovTipo = 'CORTE.CORTECX'
  BEGIN  
    INSERT INTO #CorteDTmp(Empresa, AUXID, Fecha, Cargo, Abono, Cuenta, ID, RIDConsulta, Mov, MovID, EsCancelacion)
    EXEC spCorteDConsultaObtenerCx @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								    @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								    @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @CFiltrarFechas,
									@CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CTotalizador, @CCuenta, @CCtaCategoria,
									@CCtaFamilia, @CCtaGrupo, @CCtaFabricante, @CCtaLinea, @CRama, @CAlmacen, @CValuacion,
									@CCtaTipo,
									@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

    IF @CDesglosar IN('Movimiento')
      INSERT INTO #CorteD( 
				Empresa,		Fecha,		Cargo,			Abono,		Cuenta,		ID,		RIDConsulta,
				Mov,			MovID,		EsCancelacion)
		 SELECT Empresa,		Fecha,		Cargo,			Abono,		Cuenta,		ID,		RIDConsulta,
				Mov,			MovID,		EsCancelacion
		   FROM #CorteDTmp
		  ORDER BY Cuenta, Fecha, AuxID
    ELSE IF @CDesglosar IN('Contacto', 'No')
      INSERT INTO #CorteD(
				Empresa,		Cargo,			Abono,			Cuenta,		ID,		RIDConsulta)
		 SELECT Empresa,		SUM(Cargo),		SUM(Abono),		Cuenta,		ID,		RIDConsulta
		   FROM #CorteDTmp
		  GROUP BY Empresa, Cuenta, ID, RIDConsulta
		  ORDER BY Cuenta
  END

  IF @MovTipo IN('CORTE.CORTECX', 'CORTE.CORTEUNIDADES', 'CORTE.CORTECONTABLE', 'CORTE.CORTECX') AND NULLIF(NULLIF(@CMovimiento, ''), '(TODOS)') IS NULL 
    EXEC spCorteDConsultaCtaSaldoI @ID, @RID, @CFiltrarFechas, @CPeriodo, @CEjercicio, @CFechaD, @CFechaA, @CDesglosar,
								   @CMoneda, @Moneda, @TipoCambio, @MovTipo, @CAlmacen, @CValuacion, @CModulo, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT  

  EXEC spCorteDConsultaImporte @ID, @RID, @MovTipo, @CValuacion, @CDesglosar, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT

  RETURN
END
GO

/**************** spCorteDRecalcEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDRecalcEncabezado') and type = 'P') drop procedure dbo.spCorteDRecalcEncabezado
GO
CREATE PROC spCorteDRecalcEncabezado
			@ID			int, 
			@MovTipo	varchar(20),
			@Ok			int				OUTPUT, 
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Suma			float,
		  @Resta		float,
		  @SumaSaldoI	float,
		  @RestaSaldoI	float,
		  @SumaCargo	float,
		  @RestaCargo	float,
		  @SumaAbono	float,
		  @RestaAbono	float,		  
		  @SumaSaldo	float,
		  @RestaSaldo	float,
		  @Importe		float,
		  @SumaImporte	float,
		  @RestaImporte	float
		    
  IF @MovTipo = 'CORTE.CORTEIMPORTE'
  BEGIN
    SELECT @Suma		= SUM(Importe),
		   @SumaSaldo	= SUM(SaldoU)
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Sumar'

    SELECT @Resta		= SUM(Importe),
		   @RestaSaldo	= SUM(SaldoU)
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Restar'

    UPDATE Corte
       SET Importe	= ISNULL(@Suma, 0) - ISNULL(@Resta, 0),
		   SaldoU	= ISNULL(@SumaSaldo, 0) - ISNULL(@RestaSaldo, 0)
     WHERE ID = @ID
  END
  ELSE IF @MovTipo IN('CORTE.CORTECONTABLE', 'CORTE.CORTECX')
  BEGIN
    SELECT @SumaSaldoI	= SUM(SaldoI),
		   @SumaCargo	= SUM(Cargo),
		   @SumaAbono	= SUM(Abono),
		   @SumaSaldo	= SUM(Saldo)
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Sumar'

    SELECT @RestaSaldoI	= SUM(SaldoI),
		   @RestaCargo	= SUM(Cargo),
		   @RestaAbono	= SUM(Abono),
		   @RestaSaldo	= SUM(Saldo)
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Restar'
       
    UPDATE Corte
       SET SaldoI	= ISNULL(@SumaSaldoI, 0) - ISNULL(@RestaSaldoI, 0),
		   Cargo	= ISNULL(@SumaCargo, 0)  - ISNULL(@RestaCargo, 0),
		   Abono	= ISNULL(@SumaAbono, 0)  - ISNULL(@RestaAbono, 0),
		   Saldo	= ISNULL(@SumaSaldo, 0) - ISNULL(@RestaSaldo, 0)
     WHERE ID = @ID       
  END
  ELSE IF @MovTipo IN('CORTE.CORTEUNIDADES')
  BEGIN
    SELECT @SumaSaldoI	= SUM(SaldoUI),
		   @SumaCargo	= SUM(CargoU),
		   @SumaAbono	= SUM(AbonoU),
		   @SumaSaldo	= SUM(SaldoU),
		   @SumaImporte	= SUM(Importe)
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Sumar'

    SELECT @RestaSaldoI	 = SUM(SaldoUI),
		   @RestaCargo	 = SUM(CargoU),
		   @RestaAbono	 = SUM(AbonoU),
		   @RestaSaldo	 = SUM(SaldoU),
		   @RestaImporte = SUM(Importe)		   
      FROM CorteDConsulta
     WHERE ID = @ID
       AND Accion = 'Restar'
       
    UPDATE Corte
       SET SaldoUI	= ISNULL(@SumaSaldoI, 0)  - ISNULL(@RestaSaldoI, 0),
		   CargoU	= ISNULL(@SumaCargo, 0)   - ISNULL(@RestaCargo, 0),
		   AbonoU	= ISNULL(@SumaAbono, 0)   - ISNULL(@RestaAbono, 0),
		   SaldoU	= ISNULL(@SumaSaldo, 0)   - ISNULL(@RestaSaldo, 0),
		   Importe = ISNULL(@SumaImporte, 0) - ISNULL(@RestaImporte, 0)
     WHERE ID = @ID       
  END  
END
GO

/**************** spCorteDConsulta ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDConsulta') and type = 'P') drop procedure dbo.spCorteDConsulta
GO
CREATE PROC spCorteDConsulta
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
			@CorteFiltrarFechas	bit,
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @RID				int,
		  @RIDAnt			int,

		  @CEmpresa			varchar(5),
		  @CSucursal		int,
		  @CUEN				int,
		  @CUsuario			varchar(10),
		  @CModulo			varchar(5),
		  @CMovimiento		varchar(20),
		  @CEstatus			varchar(15),
		  @CSituacion		varchar(50),
		  @CProyecto		varchar(50),
		  @CContactoTipo	varchar(20),
		  @CContacto		varchar(10),
		  @CImporteMin		float,
		  @CImporteMax		float,
		  @CValidarAlEmitir	bit,
		  @CAccion			varchar(8),
		  @CDesglosar		varchar(20),
		  @CAgrupador		varchar(50),
		  @CMoneda			varchar(10),
		  @CTotalizador		varchar(255),
		  @CCuenta			varchar(20),
		  @CCtaCategoria	varchar(50),
		  @CCtaFamilia		varchar(50),
		  @CCtaGrupo		varchar(50),
		  @CCtaFabricante	varchar(50),
		  @CCtaLinea		varchar(50),
		  @CCtaTipo			varchar(50),
		  @CRama			varchar(50),
		  @CAlmacen			varchar(50)

  SELECT @RIDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @RID = MIN(RID)
      FROM CorteDConsultaNormalizada
     WHERE ID	= @ID
       AND RID	> @RIDAnt

    IF @RID IS NULL BREAK
    
    SELECT @RIDAnt = @RID
    
    SELECT @CEmpresa = NULL, @CSucursal = NULL, @CUEN = NULL, @CUsuario = NULL, @CModulo = NULL, @CMovimiento = NULL, @CEstatus = NULL, 
		   @CSituacion = NULL, @CProyecto = NULL, @CContactoTipo = NULL, @CContacto = NULL, @CImporteMin = NULL, @CImporteMax = NULL, 
		   @CValidarAlEmitir = NULL, @CAccion = NULL, @CDesglosar = NULL, @CAgrupador = NULL, @CMoneda = NULL, @CTotalizador = NULL, 
		   @CCuenta = NULL, @CCtaCategoria = NULL, @CCtaFamilia = NULL, @CCtaGrupo = NULL, @CCtaFabricante = NULL, @CCtaLinea = NULL, 
		   @CRama = NULL, @CAlmacen = NULL, @CCtaTipo = NULL
		   
    SELECT @CEmpresa			= Empresa,
		   @CSucursal			= Sucursal,
		   @CUEN				= UEN,
		   @CUsuario			= Usuario,
		   @CModulo				= Modulo,
		   @CMovimiento			= Movimiento,
		   @CEstatus			= Estatus,
		   @CSituacion			= Situacion,
		   @CProyecto			= Proyecto,
		   @CContactoTipo		= ContactoTipo,
		   @CContacto			= Contacto,
		   @CImporteMin			= ImporteMin,
		   @CImporteMax			= ImporteMax,
		   @CValidarAlEmitir	= ValidarAlEmitir,
		   @CAccion				= Accion,
		   @CDesglosar			= Desglosar,
		   @CAgrupador			= Agrupador,
		   @CMoneda				= Moneda,
		   @CTotalizador		= Totalizador,
		   @CCuenta				= Cuenta,
		   @CCtaCategoria		= CtaCategoria,
		   @CCtaFamilia			= CtaFamilia,
		   @CCtaGrupo			= CtaGrupo,
		   @CCtaFabricante		= CtaFabricante,
		   @CCtaLinea			= CtaLinea,
		   @CRama				= Rama,
		   @CAlmacen			= Almacen,
		   @CCtaTipo			= CtaTipo
      FROM CorteDConsultaNormalizada
     WHERE ID	= @ID
       AND RID	= @RID

    SELECT @CRama = Rama
      FROM Rama  
     WHERE Descripcion = @CRama

    EXEC spCorteDConsultaProcesar @ID, @RID, @CEmpresa, @CSucursal, @CUEN, @CUsuario, @CModulo, @CMovimiento, @CEstatus, 
								  @CSituacion, @CProyecto, @CContactoTipo, @CContacto, @CImporteMin, @CImporteMax, @CValidarAlEmitir, 
								  @CAccion, @CDesglosar, @CAgrupador, @CMoneda, @Moneda, @TipoCambio, @MovTipo, @SubMovTipo, 
								  @CorteFiltrarFechas, @CortePeriodo, @CorteEjercicio, @CorteFechaD, @CorteFechaA, @CTotalizador, 
								  @CCuenta, @CCtaCategoria, @CCtaFamilia, @CCtaGrupo, @CCtaFabricante, @CCtaLinea,
								  @CRama, @CAlmacen, @CorteValuacion,
								  @CCtaTipo,
								  @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
								  
  END
  
  EXEC xpCorteDConsulta @ID, @Accion, @Empresa, @Modulo, @Mov, MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion, 
						@Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, 
						@Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, 
						@CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, 
						@CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De, @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, 
						@CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA, 
						@Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas, 
						@CortePeriodo, @CorteEjercicio, @CorteFechaD, @CorteFechaA, @CTotalizador, @CCuenta, @CCtaCategoria, @CCtaFamilia, @CCtaGrupo,
						@Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  RETURN
END
GO

/**************** spCorteD ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteD') and type = 'P') drop procedure dbo.spCorteD
GO
CREATE PROC spCorteD
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  UPDATE #CorteD 
     SET RenglonSub = 0,
		 Renglon	= RID * 2048

  INSERT INTO CorteD(
			ID,						Renglon,					RenglonSub,					Cuenta,					Mov,					MovID,
			Fecha,					Vencimiento,				Moneda,						Aplica,					AplicaID,				Referencia,
			CtaCreditoDias,			CtaCondicion,				CtaLimiteCredito,			CtaLimiteCreditoMoneda,	Cargo,					Abono,
			CargoU,					AbonoU,						SaldoU,						ValuacionNombre,		ValuacionValor,			ValuacionValorArtConCosto,
			CostoPromedio,			UltimoCosto,				PrecioLista,				Precio2,				Precio3,				Precio4,
			Precio5,				Precio6,					Precio7,					Precio8,				Precio9,				Precio10,
			CostoEstandar,			CostoReposicion,			Grupo,						Sucursal,				SubCuenta,				CostoUnitario,
			CostoUnitarioOtraMoneda,MonedaContable,				Modulo,						ModuloID,				Cantidad,				Importe,
			RIDConsulta,			TipoCambio,					Saldo,						Empresa,				Periodo,				Ejercicio,
			Estatus,				SaldoI,						EsCancelacion,				SaldoUI)
	 SELECT ID,						Renglon,					RenglonSub,					Cuenta,					Mov,					MovID,
			Fecha,					Vencimiento,				Moneda,						Aplica,					AplicaID,				Referencia,
			CtaCreditoDias,			CtaCondicion,				CtaLimiteCredito,			CtaLimiteCreditoMoneda,	Cargo,					Abono,
			CargoU,					AbonoU,						SaldoU,						ValuacionNombre,		ValuacionValor,			ValuacionValorArtConCosto,
			CostoPromedio,			UltimoCosto,				PrecioLista,				Precio2,				Precio3,				Precio4,
			Precio5,				Precio6,					Precio7,					Precio8,				Precio9,				Precio10,
			CostoEstandar,			CostoReposicion,			Grupo,						Sucursal,				SubCuenta,				CostoUnitario,
			CostoUnitarioOtraMoneda,MonedaContable,				Modulo,						ModuloID,				Cantidad,				Importe,
			RIDConsulta,			TipoCambio,					Saldo,						Empresa,				Periodo,				Ejercicio,
			Estatus,				SaldoI,						EsCancelacion,				SaldoUI
	   FROM #CorteD
	   
  EXEC xpCorteD @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
				@Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
				@Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   	@CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   	@CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   	@CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   	@CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			    @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,
               	@Ok OUTPUT, @OkRef OUTPUT
  RETURN
END
GO

/**************** spCorteDReporteInvValOtraMoneda ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteInvValOtraMoneda') and type = 'P') drop procedure dbo.spCorteDReporteInvValOtraMoneda
GO
CREATE PROC spCorteDReporteInvValOtraMoneda
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),				
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CuentaAux		varchar(10),
		  @CuentaAuxAnt		varchar(10),
		  @SucursalAux		int,
		  @SucursalAuxAnt	int,
		  @FechaA			datetime,
		  @MonedaD			varchar(10)
		  
  SELECT @FechaA = GETDATE()
  		  
  SELECT @CuentaAux = MIN(Cuenta)
    FROM CorteD
   WHERE ID	= @ID  
   
  SELECT @MonedaD	= Moneda
    FROM CorteD
   WHERE ID	= @ID     
   
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@CuentaAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	


  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC5', Empresa.Nombre,	@CuentaAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC6', Direccion2, @CuentaAux FROM #ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC7', Direccion3, @CuentaAux FROM #ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8', Direccion4, @CuentaAux FROM #ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,		Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC9',		@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@CuentaAux
	   FROM #ContactoDireccion
	   
  INSERT INTO #CorteDReporte(
			ID,				Tipo,				Columna1,				Columna2,				Columna3,										
			Columna4,		Columna5,			Columna6,				Columna7,				Columna8,
			Agrupador1)
	 SELECT @ID,			'NOM',				'Del Artículo',			@CorteCuentaDe,			'Al Artículo',										
			@CorteCuentaA,	'Valuación:',		@CorteValuacion,		'A la Fecha:',			dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),	
			@CuentaAux

  INSERT INTO #CorteDReporte(
			ID,				Tipo,				Columna1,							Columna2,							Columna3,										
			Columna4,		Columna5,			Columna6,							Columna7,							Columna8,
			Agrupador1)
	 SELECT @ID,			'NOM',				'Artículo',							'Descripción',						'SubCuenta',										
			'Existencias',	'Costo Unitario',	'Costo',							'Costo U. ' + ISNULL(@MonedaD,''),	'Costo ' + ISNULL(@MonedaD, ''),
			@CuentaAux

  SELECT @SucursalAuxAnt = -1
  WHILE(1=1)
  BEGIN
    SELECT @SucursalAux =  MIN(Sucursal)
      FROM CorteD
     WHERE ID		= @ID
       AND Sucursal	> @SucursalAuxAnt  

    IF @SucursalAux IS NULL BREAK
    
    SELECT @SucursalAuxAnt = @SucursalAux

    SELECT @CuentaAuxAnt = ''
    WHILE(1=1)
    BEGIN
      SELECT @CuentaAux =  MIN(Cuenta)
        FROM CorteD
       WHERE ID			= @ID
         AND Sucursal	= @SucursalAux       
         AND Cuenta		> @CuentaAuxAnt
       
      IF @CuentaAux IS NULL BREAK
    
      SELECT @CuentaAuxAnt = @CuentaAux
    
      INSERT INTO #CorteDReporte(
			    ID,														Tipo,													Columna1,							
			    Columna2,												Columna3,												Columna4,							
			    Columna5,												Columna6,												Columna7,						
			    Columna8,												Agrupador1)   
         SELECT ID,														'DET',													CorteD.Cuenta,						
			    Descripcion1,											SubCuenta,												CONVERT(varchar, CONVERT(money, SaldoU), 1),		
			    dbo.fnMonetarioEnTexto(ISNULL(CostoUnitario, 0)),		dbo.fnMonetarioEnTexto(ISNULL(SaldoU*CostoUnitario, 0)),dbo.fnMonetarioEnTexto(ISNULL(CostoUnitarioOtraMoneda, 0)),
			    dbo.fnMonetarioEnTexto(ISNULL(SaldoU*CostoUnitarioOtraMoneda, 0)),
			    @CuentaAux
		   FROM CorteD
		   JOIN Art ON CorteD.Cuenta = Art.Articulo
		  WHERE ID			  = @ID
		    AND Sucursal	  = @SucursalAux       
            AND CorteD.Cuenta = @CuentaAux
          
      INSERT INTO #CorteDReporte(
			    ID,																Tipo,																	Columna1,							
			    Columna2,														Columna3,																Columna4,							
			    Columna5,														Columna6,																Agrupador1)   
         SELECT ID,																'SUBT1',																'Total Artículo',						
			    CorteD.Cuenta,													SubCuenta,																CONVERT(varchar, CONVERT(money, SUM(SaldoU)), 1),		
			    dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitario), 0)),	dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitarioOtraMoneda), 0)),	@CuentaAux
		   FROM CorteD
		   JOIN Art ON CorteD.Cuenta = Art.Articulo
		  WHERE ID			  = @ID
            AND CorteD.Cuenta = @CuentaAux          
            AND Sucursal	  = @SucursalAux
          GROUP BY ID, CorteD.Cuenta, SubCuenta
    END
    
    INSERT INTO #CorteDReporte(
			  ID,															Tipo,																	Columna1,							
			  Columna2,														Columna3,																Columna4,							
			  Columna5,														Columna6,																Agrupador1)   
       SELECT ID,															'SUBT2',																'Total Sucursal',						
			  @SucursalAux,													'',																		CONVERT(varchar, CONVERT(money, SUM(SaldoU)), 1),		
			  dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitario), 0)),	dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitarioOtraMoneda), 0)),	@CuentaAux
		 FROM CorteD
		 JOIN Art ON CorteD.Cuenta = Art.Articulo
		WHERE ID			= @ID
          AND Sucursal		= @SucursalAux
        GROUP BY ID
  END  

  INSERT INTO #CorteDReporte(
			ID,																Tipo,																	Columna1,							
		    Columna2,														Columna3,																Columna4,							
			Columna5,														Columna6,																Agrupador1)   
     SELECT ID,																'TOT',																	'Total General',						
			@SucursalAux,													'',																		CONVERT(varchar, CONVERT(money, SUM(SaldoU)), 1),		
		    dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitario), 0)),	dbo.fnMonetarioEnTexto(ISNULL(SUM(SaldoU*CostoUnitarioOtraMoneda), 0)),	@CuentaAux
	   FROM CorteD
	   JOIN Art ON CorteD.Cuenta = Art.Articulo
  	  WHERE ID	= @ID
      GROUP BY ID  
  RETURN
END
GO

/**************** spCorteDReporteCorteCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteCorteCx') and type = 'P') drop procedure dbo.spCorteDReporteCorteCx
GO
CREATE PROC spCorteDReporteCorteCx
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),		
			@CorteFiltrarFechas	bit,					
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @FechaA					datetime,
		  @AgrupadorAux				varchar(50),
		  @AgrupadorAuxAnt			varchar(50),
		  @RID						int,
		  @RIDAnt					int,
		  
		  @Desglosar				varchar(20),

		  @ConsMoneda				varchar(10),
		  @ConsEmpresa				varchar(10),
		  @ConsContacto				varchar(20),
		  @ConsCtaCategoria			varchar(50),
		  @ConsCtaFamilia			varchar(50),
		  @ConsCtaGrupo				varchar(50),
		  @ConsCtaFabricante		varchar(50),
		  @ConsCtaLinea				varchar(50),
		  @ConsAlmacen				varchar(50),
		  @ConsMovimiento			varchar(20),
		  @ConsRama					varchar(50),
		  @ConsAccion				varchar(8),
		  @ConsModulo				varchar(10),
		  
		  @PrimerCiclo		bit,
		  
		  @TotalSumaDebe	float,
		  @TotalSumaHaber	float,
		  @TotalSumaSaldo	float,		 
		  @TotalSumaSaldoI	float,		  		  
		  @TotalRestaDebe	float,
		  @TotalRestaHaber	float,
		  @TotalRestaSaldo	float,
		  @TotalRestaSaldoI	float,
		  @TotalInfDebe		float,
		  @TotalInfHaber	float,
		  @TotalInfSaldo	float,
		  @TotalInfSaldoI	float,

		  @Total			 float,		  
		  @RangoFecha		 varchar(255),
		  
		  @Cuenta			 varchar(20),
		  @CuentaAnt		 varchar(20),
		  @RenglonAux		 int,
		  @Saldo			 float
		  

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @Estacion, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @Estacion

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion

  SELECT @FechaA = GETDATE()
  		  
  SELECT @AgrupadorAux = MIN(Agrupador)
    FROM CorteDConsulta
   WHERE ID	= @ID  
   
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  	  
	  
  IF ISNULL(@CorteFiltrarFechas, 0) = 1
  BEGIN
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC5',		'De la fecha ' + dbo.fnFormatearFecha(@CorteFechaD, 'dd/MM/aaaa') + ' A la fecha ' + dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),
  			  @AgrupadorAux
  END
  ELSE
  BEGIN
    SELECT @RangoFecha = ''
    IF ISNULL(@CorteEjercicio, 0) <> 0
      SELECT @RangoFecha = 'Ejercicio ' + CONVERT(varchar, ISNULL(@CorteEjercicio, 0)) + ' '

    IF ISNULL(@CortePeriodo, 0) <> 0
      SELECT @RangoFecha = @RangoFecha + 'Periodo ' + CONVERT(varchar, ISNULL(@CortePeriodo, 0))
      
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC6',		@RangoFecha,
  			  @AgrupadorAux
  END

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC7', Empresa.Nombre,	@AgrupadorAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8',  Direccion2, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC9',  Direccion3, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC10', Direccion4, @AgrupadorAux FROM @ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,			Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC11',		@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,							Tipo,						Columna1,						Columna2,				
			Columna3,					Columna4,					Agrupador1) 
	 SELECT @ID,						'ENC12',					'Informar (' + @Moneda + ')',	'Sumar (' + @Moneda + ')',
			'Restar (' + @Moneda + ')',	'Total (' + @Moneda + ')',	@AgrupadorAux


  INSERT INTO #CorteDReporte(
			ID,													Tipo,													Columna1,
			Columna2,											Columna3,												Columna4,
			Columna5,											Columna6,												Columna7,
			Columna8,											Columna9,												Columna10,
			Columna11,											Columna12,												Columna13,
			Columna14,											Columna15,												Columna16,
			Agrupador1)
     SELECT @ID,												'NOM',													'Contacto',
			'Movimiento',										'Fecha',												'Saldo Inicial',									
			'Debe',												'Haber',												'Saldo Final',										
			'Saldo Inicial',									'Debe',													'Haber',											
			'Saldo Final',										'Saldo Inicial',										'Debe',												
			'Haber',											'Saldo Final',											'Saldo Total',
			@AgrupadorAux

  SELECT @AgrupadorAuxAnt = '', @PrimerCiclo = 1
  WHILE(1=1)
  BEGIN
    IF @PrimerCiclo = 1
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') >= @AgrupadorAuxAnt
    ELSE
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') > @AgrupadorAuxAnt
                         
    IF @AgrupadorAux IS NULL AND @PrimerCiclo = 0 BREAK
    
    SELECT @AgrupadorAuxAnt = @AgrupadorAux, @PrimerCiclo = 0, @TotalSumaDebe = NULL, @TotalSumaHaber = NULL, @TotalSumaSaldo = NULL, 
		   @TotalSumaSaldoI = NULL, @TotalRestaDebe = NULL, @TotalRestaHaber = NULL, @TotalRestaSaldo = NULL, @TotalRestaSaldoI = NULL, 
		   @TotalInfDebe = NULL, @TotalInfHaber = NULL, @TotalInfSaldo = NULL, @TotalInfSaldoI = NULL

    INSERT INTO #CorteDReporte(
			  ID,	Tipo,		Columna1,					Agrupador1)
       SELECT @ID,	'SUBT3',	ISNULL(@AgrupadorAux, ''),	@AgrupadorAux    

    SELECT @RIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @RID = MIN(RID)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	> @RIDAnt
      
      IF @RID IS NULL BREAK
      
      SELECT @RIDAnt = @RID, @Desglosar = ''

      SELECT @ConsMoneda = NULL, @ConsEmpresa = NULL, @ConsContacto = NULL, @ConsCtaCategoria = NULL, @ConsCtaFamilia = NULL,
			 @ConsCtaGrupo = NULL, @ConsCtaFabricante = NULL, @ConsCtaLinea = NULL, @ConsAlmacen = NULL, @ConsMovimiento = NULL,
		     @ConsRama = NULL, @ConsAccion = NULL, @ConsModulo = NULL

      SELECT @Desglosar			= ISNULL(Desglosar, 'No'),
			 @ConsMoneda		= ISNULL(Moneda, '(TODOS)'), 
			 @ConsEmpresa		= ISNULL(Empresa, '(TODOS)'), 
			 @ConsContacto		= ISNULL(Contacto, '(TODOS)'), 
			 @ConsCtaCategoria	= ISNULL(CtaCategoria, '(TODOS)'), 
			 @ConsCtaFamilia	= ISNULL(CtaFamilia, '(TODOS)'), 
			 @ConsCtaGrupo		= ISNULL(CtaGrupo, '(TODOS)'), 			 			 			 
			 @ConsCtaFabricante	= ISNULL(CtaFabricante, '(TODOS)'), 			 			 			 
			 @ConsCtaLinea		= ISNULL(CtaLinea, '(TODOS)'), 			 			 			 			 
			 @ConsAlmacen		= ISNULL(Almacen, '(TODOS)'), 			 			 			 			 
			 @ConsMovimiento	= ISNULL(Movimiento, '(TODOS)'), 
			 @ConsRama			= ISNULL(Rama, '(TODOS)'),
			 @ConsAccion		= Accion,
			 @ConsModulo		= ISNULL(Modulo, '(TODOS)')
        FROM CorteDConsultaNormalizada
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	= @RID

      SELECT @TotalInfDebe   = SUM(Cargo),
			 @TotalInfHaber  = SUM(Abono),
			 @TotalInfSaldo  = SUM(Saldo),
			 @TotalInfSaldoI = SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Informar'      

      SELECT @TotalSumaDebe		= SUM(Cargo),
			 @TotalSumaHaber	= SUM(Abono),
			 @TotalSumaSaldo	= SUM(Saldo),
			 @TotalSumaSaldoI	= SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Sumar'

      SELECT @TotalRestaDebe   = SUM(Cargo),
			 @TotalRestaHaber  = SUM(Abono),
			 @TotalRestaSaldo  = SUM(Saldo),
			 @TotalRestaSaldoI = SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Restar'

      IF @Desglosar <> 'No'         
      BEGIN
        SELECT @CuentaAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @Cuenta  = MIN(d.Cuenta)
            FROM CorteD d
            JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
           WHERE c.ID		= @ID 
             AND c.RID	= @RID
             AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
             AND d.Cuenta	> @CuentaAnt
            
          IF @Cuenta IS NULL BREAK
            
          SELECT @CuentaAnt = @Cuenta

          IF @Desglosar <> 'Movimiento'
          BEGIN
            INSERT INTO #CorteDReporte(
			          ID,
    			      Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna4,
			          Columna5,
			          Columna6,
			          Columna7,
    				  Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')	= 'Informar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha

            INSERT INTO #CorteDReporte(
			          ID,																				
			          Tipo,														
			          Columna1,																			
			          Columna2,				
			          Columna3,																			
			          Columna8,			
			          Columna9,																			
			          Columna10,													
			          Columna11,
			          Columna16,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Sumar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha
                            
            INSERT INTO #CorteDReporte(
			          ID,
			          Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna12,
			          Columna13,
			          Columna14,
			          Columna15,
			          Columna16,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(-SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Restar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha
          END 
          ELSE IF @Desglosar = 'Movimiento'
          BEGIN
            INSERT INTO #CorteDReporte(
			          ID,
    			      Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna4,
			          Columna5,
			          Columna6,
			          Columna7,
    				  Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')	= 'Informar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID

            INSERT INTO #CorteDReporte(
			          ID,																				
			          Tipo,														
			          Columna1,																			
			          Columna2,				
			          Columna3,																			
			          Columna8,			
			          Columna9,																			
			          Columna10,													
			          Columna11,
			          Columna16,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Sumar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID
                            
            INSERT INTO #CorteDReporte(
			          ID,
			          Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna12,
			          Columna13,
			          Columna14,
			          Columna15,
			          Columna16,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(-SUM(d.Saldo)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Restar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID
                  
            SELECT @RenglonAux = NULL, @Saldo = NULL
            
            SELECT @RenglonAux = MAX(d.RID)
              FROM CorteD d
              JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
             WHERE c.ID		= @ID 
               AND c.RID		= @RID
               AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
               AND d.Cuenta	= @Cuenta
            
            SELECT @Saldo = SaldoU
              FROM CorteD
             WHERE RID = @RenglonAux
            
            IF @ConsAccion = 'Informar'
              INSERT INTO #CorteDReporte(
			            ID,
    			        Tipo,
			            Columna1,
			            Columna4,
			            Columna5,
			            Columna6,
			            Columna7,
    				    Agrupador1)             
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Saldo)), ''),
					    @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
            ELSE IF @ConsAccion = 'Sumar'          
              INSERT INTO #CorteDReporte(
			            ID,																				
			            Tipo,														
			            Columna1,																			
			            Columna8,			
  			            Columna9,																			
			            Columna10,													
			            Columna11,
			            Columna16,
				        Agrupador1)
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(@Saldo), ''),
				        NULLIF(dbo.fnCantidadEnTexto(@Saldo), ''),
				        @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
                    AND ISNULL(c.Accion, '')	= 'Sumar'		
            ELSE IF @ConsAccion = 'Restar'
              INSERT INTO #CorteDReporte(
			            ID,
			            Tipo,
			            Columna1,
			            Columna12,
			            Columna13,
			            Columna14,
			            Columna15,
			            Columna16,
				        Agrupador1)   
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Cargo)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.Abono)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(@Saldo), ''),
				        NULLIF(dbo.fnCantidadEnTexto(@Saldo), ''),
				        @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
                    AND ISNULL(c.Accion, '')		= 'Restar'						                   		      
          END
        END
      END
      ELSE
      BEGIN
        IF @ConsAccion = 'Informar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna4,					
			        Columna5,												Columna6,					
			        Columna7,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsContacto,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),	@AgrupadorAux
        ELSE IF @ConsAccion = 'Sumar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna8,					
			        Columna9,												Columna10,					
			        Columna11,												Columna16,				
			        Agrupador1)
             SELECT @ID,													'DET',						
					@ConsContacto,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),	
					@AgrupadorAux
        ELSE IF @ConsAccion = 'Restar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna12,					
			        Columna13,												Columna14,					
			        Columna15,												Columna16,
			        Agrupador1)
             SELECT @ID,													'DET',						
					@ConsContacto,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),	NULLIF(dbo.fnCantidadEnTexto(-@TotalRestaSaldo), ''),	
					@AgrupadorAux
      END

      INSERT INTO #CorteDReporte(
				ID,														Tipo,													Columna1,			
				Columna2,												Columna3,												Columna4,			
				Columna5,												Columna6,												Columna7, 
				Columna8,												Columna9,												Columna10,			
				Columna11,												Columna12,												Columna13,			
				Columna14,												Columna15,												Columna16, 
				Columna17,												Columna18,												Columna19,			
				Columna20,												Columna21,												Columna22,			
				Columna23,												Columna24,												Columna25, 
				Columna26,												Columna27,												Columna28,			
				Columna29,												Columna30,												Columna31,
				Columna32,												Columna33,												Columna34,
				Columna35,												Agrupador1)
		 SELECT @ID,													'SUBT',													'Empresa',
				@ConsEmpresa,											'Moneda',												@ConsMoneda,											
				'Cuenta',												@ConsContacto,											'Categoria',											
				@ConsCtaCategoria,										'Familia',												@ConsCtaFamilia,										
				'Grupo',												@ConsCtaGrupo,											'Fabricante',
				@ConsCtaFabricante,										'Linea',												@ConsCtaLinea,
				'Almacen',												@ConsAlmacen,											'Movimiento',											
				@ConsMovimiento,										'Rama',													@ConsRama,
				NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),	
				NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''),						@AgrupadorAux
    END

    SELECT @TotalInfDebe     = SUM(Cargo),
		   @TotalInfHaber    = SUM(Abono),
		   @TotalInfSaldo    = SUM(Saldo),
		   @TotalInfSaldoI   = SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Informar'      

    SELECT @TotalSumaDebe		= SUM(Cargo),
		   @TotalSumaHaber		= SUM(Abono),
		   @TotalSumaSaldo		= SUM(Saldo),
		   @TotalSumaSaldoI		= SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Sumar'

    SELECT @TotalRestaDebe		= SUM(Cargo),
		   @TotalRestaHaber		= SUM(Abono),
		   @TotalRestaSaldo		= SUM(Saldo),
		   @TotalRestaSaldoI	= SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Restar'

    INSERT INTO #CorteDReporte(
			  ID,														Tipo,													Columna1,
			  Columna2,													Columna3,												Columna4,
			  Columna5,													Columna6,												Columna7,
			  Columna8,													Columna9,												Columna10,
			  Columna11,												Columna12,												Columna13,
			  Columna14,												Agrupador1)
       SELECT @ID,														'SUBT2',												CASE @TipoCambio WHEN 1.0 THEN 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ')' ELSE 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			  NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),
			  NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''),						@AgrupadorAux
  END
  
  SELECT @TotalInfDebe   = SUM(Cargo),
		 @TotalInfHaber  = SUM(Abono),
		 @TotalInfSaldo  = SUM(Saldo),
		 @TotalInfSaldoI = SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Informar'      

  SELECT @TotalSumaDebe		= SUM(Cargo),
		 @TotalSumaHaber	= SUM(Abono),
		 @TotalSumaSaldo	= SUM(Saldo),
		 @TotalSumaSaldoI	= SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Sumar'

  SELECT @TotalRestaDebe	= SUM(Cargo),
		 @TotalRestaHaber	= SUM(Abono),
		 @TotalRestaSaldo	= SUM(Saldo),
		 @TotalRestaSaldoI	= SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Restar'
      
  INSERT INTO #CorteDReporte(
			ID,														Tipo,													Columna1,										
			Columna2,												Columna3,												Columna4,
			Columna5,												Columna6,												Columna7,
			Columna8,												Columna9,												Columna10,
			Columna11,												Columna12,												Columna13,
			Columna14,												Agrupador1)  
     SELECT @ID,													'TOT',													CASE @TipoCambio WHEN 1.0 THEN 'Gran Total' + ' (' + @Moneda + ')' ELSE 'Gran Total' + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),			
			NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),			
			NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),		
			NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),		
			NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''), 						@AgrupadorAux

  RETURN
END
GO

/**************** spCorteDReporteCorteUnidades ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteCorteUnidades') and type = 'P') drop procedure dbo.spCorteDReporteCorteUnidades
GO
CREATE PROC spCorteDReporteCorteUnidades
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),		
			@CorteFiltrarFechas	bit,					
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @FechaA					datetime,
		  @AgrupadorAux				varchar(50),
		  @AgrupadorAuxAnt			varchar(50),
		  @RID						int,
		  @RIDAnt					int,
		  
		  @Desglosar				varchar(20),

		  @ConsMoneda				varchar(10),
		  @ConsEmpresa				varchar(10),
		  @ConsCuenta				varchar(20),
		  @ConsCtaCategoria			varchar(50),
		  @ConsCtaFamilia			varchar(50),
		  @ConsCtaGrupo				varchar(50),
		  @ConsCtaFabricante		varchar(50),
		  @ConsCtaLinea				varchar(50),
		  @ConsAlmacen				varchar(50),
		  @ConsMovimiento			varchar(20),
		  @ConsRama					varchar(50),
		  @ConsAccion				varchar(8),
		  
		  @PrimerCiclo		bit,
		  
		  @TotalSumaDebe	float,
		  @TotalSumaHaber	float,
		  @TotalSumaSaldo	float,		 
		  @TotalSumaSaldoI	float,		  		  
		  @TotalRestaDebe	float,
		  @TotalRestaHaber	float,
		  @TotalRestaSaldo	float,
		  @TotalRestaSaldoI	float,
		  @TotalInfDebe		float,
		  @TotalInfHaber	float,
		  @TotalInfSaldo	float,
		  @TotalInfSaldoI	float,

		  @TotalSumaImporte	 float,		  
		  @TotalRestaImporte float,		  
		  @Total			 float,		  
		  @RangoFecha		 varchar(255),
		  
		  @Cuenta			 varchar(20),
		  @CuentaAnt		 varchar(20),
		  @RenglonAux		 int,
		  @SaldoU			 float
		  

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @Estacion, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @Estacion

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion

  SELECT @FechaA = GETDATE()
  		  
  SELECT @AgrupadorAux = MIN(Agrupador)
    FROM CorteDConsulta
   WHERE ID	= @ID  
   
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  	  
	  
  IF ISNULL(@CorteFiltrarFechas, 0) = 1
  BEGIN
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC5',		'De la fecha ' + dbo.fnFormatearFecha(@CorteFechaD, 'dd/MM/aaaa') + ' A la fecha ' + dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),
  			  @AgrupadorAux
  END
  ELSE
  BEGIN
    SELECT @RangoFecha = ''
    IF ISNULL(@CorteEjercicio, 0) <> 0
      SELECT @RangoFecha = 'Ejercicio ' + CONVERT(varchar, ISNULL(@CorteEjercicio, 0)) + ' '

    IF ISNULL(@CortePeriodo, 0) <> 0
      SELECT @RangoFecha = @RangoFecha + 'Periodo ' + CONVERT(varchar, ISNULL(@CortePeriodo, 0))
      
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC6',		@RangoFecha,
  			  @AgrupadorAux
  END

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC7', Empresa.Nombre,	@AgrupadorAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8',  Direccion2, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC9',  Direccion3, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC10', Direccion4, @AgrupadorAux FROM @ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,			Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC11',		@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,							Tipo,						Columna1,		Columna2,				
			Columna3,					Columna4,					Agrupador1) 
	 SELECT @ID,						'ENC12',					'Informar',		'Sumar',				
			'Restar',					'Total (' + @Moneda + ')',	@AgrupadorAux


  INSERT INTO #CorteDReporte(
			ID,													Tipo,													Columna1,
			Columna2,											Columna3,												Columna4,
			Columna5,											Columna6,												Columna7,
			Columna8,											Columna9,												Columna10,
			Columna11,											Columna12,												Columna13,
			Columna14,											Columna15,												Columna16,
			Columna17,											Agrupador1)
     SELECT @ID,												'NOM',													'Artículo',
			'Movimiento',										'Fecha',												'Saldo Inicial',									
			'Debe',												'Haber',												'Saldo Final',										
			'Saldo Inicial',									'Debe',													'Haber',											
			'Saldo Final',										'Saldo Inicial',										'Debe',												
			'Haber',											'Saldo Final',											'Saldo Total',
			'Importe Total',									@AgrupadorAux

  SELECT @AgrupadorAuxAnt = '', @PrimerCiclo = 1
  WHILE(1=1)
  BEGIN
    IF @PrimerCiclo = 1
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') >= @AgrupadorAuxAnt
    ELSE
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') > @AgrupadorAuxAnt
                         
    IF @AgrupadorAux IS NULL AND @PrimerCiclo = 0 BREAK
    
    SELECT @AgrupadorAuxAnt = @AgrupadorAux, @PrimerCiclo = 0, @TotalSumaDebe = NULL, @TotalSumaHaber = NULL, @TotalSumaSaldo = NULL, 
		   @TotalSumaSaldoI = NULL, @TotalRestaDebe = NULL, @TotalRestaHaber = NULL, @TotalRestaSaldo = NULL, @TotalRestaSaldoI = NULL, 
		   @TotalInfDebe = NULL, @TotalInfHaber = NULL, @TotalInfSaldo = NULL, @TotalInfSaldoI = NULL, @TotalSumaImporte = NULL,
		   @TotalRestaImporte = NULL

    INSERT INTO #CorteDReporte(
			  ID,	Tipo,		Columna1,					Agrupador1)
       SELECT @ID,	'SUBT3',	ISNULL(@AgrupadorAux, ''),	@AgrupadorAux    

    SELECT @RIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @RID = MIN(RID)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	> @RIDAnt
      
      IF @RID IS NULL BREAK
      
      SELECT @RIDAnt = @RID, @Desglosar = ''

      SELECT @ConsMoneda = NULL, @ConsEmpresa = NULL, @ConsCuenta = NULL, @ConsCtaCategoria = NULL, @ConsCtaFamilia = NULL,
			 @ConsCtaGrupo = NULL, @ConsCtaFabricante = NULL, @ConsCtaLinea = NULL, @ConsAlmacen = NULL, @ConsMovimiento = NULL,
		     @ConsRama = NULL, @ConsAccion = NULL

      SELECT @Desglosar			= ISNULL(Desglosar, 'No'),
			 @ConsMoneda		= ISNULL(Moneda, '(TODOS)'), 
			 @ConsEmpresa		= ISNULL(Empresa, '(TODOS)'), 
			 @ConsCuenta		= ISNULL(Cuenta, '(TODOS)'), 
			 @ConsCtaCategoria	= ISNULL(CtaCategoria, '(TODOS)'), 
			 @ConsCtaFamilia	= ISNULL(CtaFamilia, '(TODOS)'), 
			 @ConsCtaGrupo		= ISNULL(CtaGrupo, '(TODOS)'), 			 			 			 
			 @ConsCtaFabricante	= ISNULL(CtaFabricante, '(TODOS)'), 			 			 			 
			 @ConsCtaLinea		= ISNULL(CtaLinea, '(TODOS)'), 			 			 			 			 
			 @ConsAlmacen		= ISNULL(Almacen, '(TODOS)'), 			 			 			 			 
			 @ConsMovimiento	= ISNULL(Movimiento, '(TODOS)'), 
			 @ConsRama			= ISNULL(Rama, '(TODOS)'),
			 @ConsAccion		= Accion
        FROM CorteDConsultaNormalizada
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	= @RID

      SELECT @TotalInfDebe   = SUM(CargoU),
			 @TotalInfHaber  = SUM(AbonoU),
			 @TotalInfSaldo  = SUM(SaldoU),
			 @TotalInfSaldoI = SUM(SaldoUI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Informar'      

      SELECT @TotalSumaDebe		= SUM(CargoU),
			 @TotalSumaHaber	= SUM(AbonoU),
			 @TotalSumaSaldo	= SUM(SaldoU),
			 @TotalSumaSaldoI	= SUM(SaldoUI),
			 @TotalSumaImporte	= SUM(Importe)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Sumar'

      SELECT @TotalRestaDebe   = SUM(CargoU),
			 @TotalRestaHaber  = SUM(AbonoU),
			 @TotalRestaSaldo  = SUM(SaldoU),
			 @TotalRestaSaldoI = SUM(SaldoUI),
			 @TotalRestaImporte	= SUM(Importe)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Restar'

      IF @Desglosar <> 'No'         
      BEGIN
        SELECT @CuentaAnt = ''
        WHILE(1=1)
        BEGIN
          SELECT @Cuenta  = MIN(d.Cuenta)
            FROM CorteD d
            JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
           WHERE c.ID		= @ID 
             AND c.RID	= @RID
             AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
             AND d.Cuenta	> @CuentaAnt
            
          IF @Cuenta IS NULL BREAK
            
          SELECT @CuentaAnt = @Cuenta

          IF @Desglosar <> 'Movimiento'
          BEGIN
            INSERT INTO #CorteDReporte(
			          ID,
    			      Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna4,
			          Columna5,
			          Columna6,
			          Columna7,
    				  Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')	= 'Informar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha

            INSERT INTO #CorteDReporte(
			          ID,																				
			          Tipo,														
			          Columna1,																			
			          Columna2,				
			          Columna3,																			
			          Columna8,			
			          Columna9,																			
			          Columna10,													
			          Columna11,
			          Columna16,
			          Columna17,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Importe)), '$'),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Sumar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha
                            
            INSERT INTO #CorteDReporte(
			          ID,
			          Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna12,
			          Columna13,
			          Columna14,
			          Columna15,
			          Columna16,
			          Columna17,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(-SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnMonetarioEnTexto(-SUM(d.Importe)), '$'),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Restar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha
          END 
          ELSE IF @Desglosar = 'Movimiento'
          BEGIN
            INSERT INTO #CorteDReporte(
			          ID,
    			      Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna4,
			          Columna5,
			          Columna6,
			          Columna7,
    				  Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')	= 'Informar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID

            INSERT INTO #CorteDReporte(
			          ID,																				
			          Tipo,														
			          Columna1,																			
			          Columna2,				
			          Columna3,																			
			          Columna8,			
			          Columna9,																			
			          Columna10,													
			          Columna11,
			          Columna16,
			          Columna17,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Importe)), '$'),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Sumar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID
                            
            INSERT INTO #CorteDReporte(
			          ID,
			          Tipo,
			          Columna1,
			          Columna2,
			          Columna3,
			          Columna12,
			          Columna13,
			          Columna14,
			          Columna15,
			          Columna16,
			          Columna17,
				      Agrupador1)
               SELECT @ID,
				      'DET',
				      d.Cuenta,
				      CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				      CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnCantidadEnTexto(-SUM(d.SaldoU)), ''),
				      NULLIF(dbo.fnMonetarioEnTexto(-SUM(d.Importe)), '$'),
				      @AgrupadorAux
                 FROM CorteD d
                 JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                WHERE c.ID		= @ID 
                  AND c.RID		= @RID
                  AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                  AND ISNULL(c.Accion, '')		= 'Restar'
                  AND d.Cuenta	= @Cuenta
                GROUP BY d.Cuenta, d.Mov, d.MovID, d.Fecha, d.RID
                ORDER BY d.RID
                  
            SELECT @RenglonAux = NULL, @SaldoU = NULL
            
            SELECT @RenglonAux = MAX(d.RID)
              FROM CorteD d
              JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
             WHERE c.ID		= @ID 
               AND c.RID		= @RID
               AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
               AND d.Cuenta	= @Cuenta
            
            SELECT @SaldoU = SaldoU
              FROM CorteD
             WHERE RID = @RenglonAux
            
            IF @ConsAccion = 'Informar'
              INSERT INTO #CorteDReporte(
			            ID,
    			        Tipo,
			            Columna1,
			            Columna4,
			            Columna5,
			            Columna6,
			            Columna7,
    				    Agrupador1)             
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoU)), ''),
					    @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
            ELSE IF @ConsAccion = 'Sumar'          
              INSERT INTO #CorteDReporte(
			            ID,																				
			            Tipo,														
			            Columna1,																			
			            Columna8,			
  			            Columna9,																			
			            Columna10,													
			            Columna11,
			            Columna16,
			            Columna17,
				        Agrupador1)
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(@SaldoU), ''),
				        NULLIF(dbo.fnCantidadEnTexto(@SaldoU), ''),
				        NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Importe)), '$'),
				        @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
                    AND ISNULL(c.Accion, '')	= 'Sumar'		
            ELSE IF @ConsAccion = 'Restar'
              INSERT INTO #CorteDReporte(
			            ID,
			            Tipo,
			            Columna1,
			            Columna12,
			            Columna13,
			            Columna14,
			            Columna15,
			            Columna16,
			            Columna17,
				        Agrupador1)   
                 SELECT @ID,
					    'DET2',
					    @Cuenta,
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.SaldoUI)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.CargoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(SUM(d.AbonoU)), ''),
					    NULLIF(dbo.fnCantidadEnTexto(@SaldoU), ''),
				        NULLIF(dbo.fnCantidadEnTexto(@SaldoU), ''),
				        NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Importe)), '$'),
				        @AgrupadorAux
                   FROM CorteD d
                   JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
                  WHERE c.ID		= @ID 
                    AND c.RID		= @RID
                    AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
                    AND d.Cuenta	= @Cuenta
                    AND ISNULL(c.Accion, '')		= 'Restar'						                   		      
          END
        END
      END
      ELSE
      BEGIN
        IF @ConsAccion = 'Informar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna4,					
			        Columna5,												Columna6,					
			        Columna7,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),	@AgrupadorAux
        ELSE IF @ConsAccion = 'Sumar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna8,					
			        Columna9,												Columna10,					
			        Columna11,												Columna16,				
			        Columna17,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),	
					NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaImporte), '$'),	@AgrupadorAux
        ELSE IF @ConsAccion = 'Restar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna12,					
			        Columna13,												Columna14,					
			        Columna15,												Columna16,
			        Columna17,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											@ConsMovimiento,										
					'(TODOS)',												NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	
					NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),	NULLIF(dbo.fnCantidadEnTexto(-@TotalRestaSaldo), ''),	
					NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaImporte), '$'),@AgrupadorAux
      END

      INSERT INTO #CorteDReporte(
				ID,														Tipo,													Columna1,			
				Columna2,												Columna3,												Columna4,			
				Columna5,												Columna6,												Columna7, 
				Columna8,												Columna9,												Columna10,			
				Columna11,												Columna12,												Columna13,			
				Columna14,												Columna15,												Columna16, 
				Columna17,												Columna18,												Columna19,			
				Columna20,												Columna21,												Columna22,			
				Columna23,												Columna24,												Columna25, 
				Columna26,												Columna27,												Columna28,			
				Columna29,												Columna30,												Columna31,
				Columna32,												Columna33,												Columna34,
				Columna35,												Columna36,												Agrupador1)
		 SELECT @ID,													'SUBT',													'Empresa',
				@ConsEmpresa,											'Moneda',												@ConsMoneda,											
				'Cuenta',												@ConsCuenta,											'Categoria',											
				@ConsCtaCategoria,										'Familia',												@ConsCtaFamilia,										
				'Grupo',												@ConsCtaGrupo,											'Fabricante',
				@ConsCtaFabricante,										'Linea',												@ConsCtaLinea,
				'Almacen',												@ConsAlmacen,											'Movimiento',											
				@ConsMovimiento,										'Rama',													@ConsRama,
				NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),	
				NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),	
				NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''), 
				NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaImporte, 0)-ISNULL(@TotalRestaImporte, 0)), '$'),				@AgrupadorAux
    END

    SELECT @TotalInfDebe     = SUM(CargoU),
		   @TotalInfHaber    = SUM(AbonoU),
		   @TotalInfSaldo    = SUM(SaldoU),
		   @TotalInfSaldoI   = SUM(SaldoUI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Informar'      

    SELECT @TotalSumaDebe		= SUM(CargoU),
		   @TotalSumaHaber		= SUM(AbonoU),
		   @TotalSumaSaldo		= SUM(SaldoU),
		   @TotalSumaSaldoI		= SUM(SaldoUI),
		   @TotalSumaImporte	= SUM(Importe)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Sumar'

    SELECT @TotalRestaDebe		= SUM(CargoU),
		   @TotalRestaHaber		= SUM(AbonoU),
		   @TotalRestaSaldo		= SUM(SaldoU),
		   @TotalRestaSaldoI	= SUM(SaldoUI),
		   @TotalRestaImporte	= SUM(Importe)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Restar'

    INSERT INTO #CorteDReporte(
			  ID,														Tipo,													Columna1,
			  Columna2,													Columna3,												Columna4,
			  Columna5,													Columna6,												Columna7,
			  Columna8,													Columna9,												Columna10,
			  Columna11,												Columna12,												Columna13,
			  Columna14,												
			  Columna15,												
			  Agrupador1)
       SELECT @ID,														'SUBT2',												CASE @TipoCambio WHEN 1.0 THEN 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ')' ELSE 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			  NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),
			  NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),
			  NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''), 
			  NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaImporte, 0)-ISNULL(@TotalRestaImporte, 0)), '$'), 
			  @AgrupadorAux
  END
  
  SELECT @TotalInfDebe   = SUM(CargoU),
		 @TotalInfHaber  = SUM(AbonoU),
		 @TotalInfSaldo  = SUM(SaldoU),
		 @TotalInfSaldoI = SUM(SaldoUI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Informar'      

  SELECT @TotalSumaDebe		= SUM(CargoU),
		 @TotalSumaHaber	= SUM(AbonoU),
		 @TotalSumaSaldo	= SUM(SaldoU),
		 @TotalSumaSaldoI	= SUM(SaldoUI),
		 @TotalSumaImporte	= SUM(Importe)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Sumar'

  SELECT @TotalRestaDebe	= SUM(CargoU),
		 @TotalRestaHaber	= SUM(AbonoU),
		 @TotalRestaSaldo	= SUM(SaldoU),
		 @TotalRestaSaldoI	= SUM(SaldoUI),
		 @TotalRestaImporte	= SUM(Importe)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Restar'
      
  INSERT INTO #CorteDReporte(
			ID,														Tipo,													Columna1,										
			Columna2,												Columna3,												Columna4,
			Columna5,												Columna6,												Columna7,
			Columna8,												Columna9,												Columna10,
			Columna11,												Columna12,												Columna13,
			Columna14,												
			Columna15,											
			Agrupador1)  
     SELECT @ID,													'TOT',													CASE @TipoCambio WHEN 1.0 THEN 'Gran Total' + ' (' + @Moneda + ')' ELSE 'Gran Total' + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldoI), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalInfHaber), ''),			
			NULLIF(dbo.fnCantidadEnTexto(@TotalInfSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldoI), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalSumaDebe), ''),			
			NULLIF(dbo.fnCantidadEnTexto(@TotalSumaHaber), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalSumaSaldo), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldoI), ''),		
			NULLIF(dbo.fnCantidadEnTexto(@TotalRestaDebe), ''),		NULLIF(dbo.fnCantidadEnTexto(@TotalRestaHaber), ''),	NULLIF(dbo.fnCantidadEnTexto(@TotalRestaSaldo), ''),		
			NULLIF(dbo.fnCantidadEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), ''), 
			NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaImporte, 0)-ISNULL(@TotalRestaImporte, 0)), ''), 
			@AgrupadorAux
  RETURN
END
GO

/**************** spCorteDReporteCorteCont ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteCorteCont') and type = 'P') drop procedure dbo.spCorteDReporteCorteCont
GO
CREATE PROC spCorteDReporteCorteCont
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),		
			@CorteFiltrarFechas	bit,					
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @FechaA					datetime,
		  @AgrupadorAux				varchar(50),
		  @AgrupadorAuxAnt			varchar(50),
		  @RID						int,
		  @RIDAnt					int,
		  
		  @Desglosar				varchar(20),

		  @ConsEmpresa				varchar(10),
		  @ConsCuenta				varchar(20),
		  @ConsCtaCategoria			varchar(50),
		  @ConsCtaFamilia			varchar(50),
		  @ConsCtaGrupo				varchar(50),	 
		  @ConsSucursal				varchar(10),
		  @ConsUEN					varchar(10),
		  @ConsMovimiento			varchar(20),
		  @ConsEstatus				varchar(15),
		  @ConsProyecto				varchar(50),		  
		  @ConsContactoTipo			varchar(20),
		  @ConsContacto				varchar(10),
		  @ConsImporteMinimo		float,
		  @ConsImporteMaximo		float,
		  @ConsTotalizador			varchar(255),
		  @ConsAccion				varchar(8),
		  
		  @PrimerCiclo		bit,
		  
		  @TotalSumaDebe	float,
		  @TotalSumaHaber	float,
		  @TotalSumaSaldo	float,		 
		  @TotalSumaSaldoI	float,		  		  
		  @TotalRestaDebe	float,
		  @TotalRestaHaber	float,
		  @TotalRestaSaldo	float,
		  @TotalRestaSaldoI	float,
		  @TotalInfDebe		float,
		  @TotalInfHaber	float,
		  @TotalInfSaldo	float,
		  @TotalInfSaldoI	float,
		  
		  @Total			float,		  
		  @RangoFecha		varchar(255)

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @Estacion, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @Estacion

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion

  SELECT @FechaA = GETDATE()
  		  
  SELECT @AgrupadorAux = MIN(Agrupador)
    FROM CorteDConsulta
   WHERE ID	= @ID  
   
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  	  
	  
  IF ISNULL(@CorteFiltrarFechas, 0) = 1
  BEGIN
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC5',		'De la fecha ' + dbo.fnFormatearFecha(@CorteFechaD, 'dd/MM/aaaa') + ' A la fecha ' + dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),
  			  @AgrupadorAux
  END
  ELSE
  BEGIN
    SELECT @RangoFecha = ''
    IF ISNULL(@CorteEjercicio, 0) <> 0
      SELECT @RangoFecha = 'Ejercicio ' + CONVERT(varchar, ISNULL(@CorteEjercicio, 0)) + ' '

    IF ISNULL(@CortePeriodo, 0) <> 0
      SELECT @RangoFecha = @RangoFecha + 'Periodo ' + CONVERT(varchar, ISNULL(@CortePeriodo, 0))
      
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC6',		@RangoFecha,
  			  @AgrupadorAux
  END

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC7', Empresa.Nombre,	@AgrupadorAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8',  Direccion2, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC9',  Direccion3, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC10', Direccion4, @AgrupadorAux FROM @ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,		Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC11',	@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,							Tipo,						Columna1,						Columna2,				
			Columna3,					Columna4,					Agrupador1) 
	 SELECT @ID,						'ENC12',					'Informar (' + @Moneda + ')',	'Sumar (' + @Moneda + ')',				
			'Restar (' + @Moneda + ')',	'Total (' + @Moneda + ')',	@AgrupadorAux
			
  INSERT INTO #CorteDReporte(
			ID,													Tipo,													Columna1,
			Columna2,											Columna3,												Columna4,
			Columna5,											Columna6,												Columna7,
			Columna8,											Columna9,												Columna10,
			Columna11,											Columna12,												Columna13,
			Columna14,											Columna15,												Columna16,
			Columna17,											Agrupador1)
     SELECT @ID,												'NOM',													'Cuenta',
			'Descripción',										'Movimiento',											'Fecha',
			'Saldo Inicial',									'Debe',													'Haber',
			'Saldo Final',										'Saldo Inicial',										'Debe',
			'Haber',											'Saldo Final',											'Saldo Inicial',
			'Debe',												'Haber',												'Saldo Final',
			'Importe Total',									@AgrupadorAux

  SELECT @AgrupadorAuxAnt = '', @PrimerCiclo = 1
  WHILE(1=1)
  BEGIN
    IF @PrimerCiclo = 1
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') >= @AgrupadorAuxAnt
    ELSE
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') > @AgrupadorAuxAnt
                         
    IF @AgrupadorAux IS NULL AND @PrimerCiclo = 0 BREAK
    
    SELECT @AgrupadorAuxAnt = @AgrupadorAux, @PrimerCiclo = 0, @TotalSumaDebe = NULL, @TotalSumaHaber = NULL, @TotalSumaSaldo = NULL, 
		   @TotalSumaSaldoI = NULL, @TotalRestaDebe = NULL, @TotalRestaHaber = NULL, @TotalRestaSaldo = NULL, @TotalRestaSaldoI = NULL, 
		   @TotalInfDebe = NULL, @TotalInfHaber = NULL, @TotalInfSaldo = NULL, @TotalInfSaldoI = NULL

    INSERT INTO #CorteDReporte(
			  ID,	Tipo,		Columna1,					Agrupador1)
       SELECT @ID,	'SUBT3',	ISNULL(@AgrupadorAux, ''),	@AgrupadorAux    
			      
    SELECT @RIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @RID = MIN(RID)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	> @RIDAnt
      
      IF @RID IS NULL BREAK
      
      SELECT @RIDAnt = @RID, @Desglosar = ''

      SELECT @ConsEmpresa = NULL, @ConsCuenta = NULL, @ConsCtaCategoria = NULL, @ConsCtaFamilia = NULL, @ConsCtaGrupo = NULL, @ConsSucursal = NULL, 
			 @ConsUEN = NULL, @ConsMovimiento = NULL, @ConsEstatus = NULL, @ConsProyecto = NULL, @ConsContactoTipo = NULL, @ConsContacto = NULL, 
		     @ConsImporteMinimo = NULL, @ConsImporteMaximo = NULL, @ConsTotalizador = NULL, @ConsAccion = NULL
      
      SELECT @Desglosar			= ISNULL(Desglosar, 'No'),
			 @ConsEmpresa		= ISNULL(Empresa, '(TODOS)'), 
			 @ConsCuenta		= ISNULL(Cuenta, '(TODOS)'), 
			 @ConsCtaCategoria	= ISNULL(CtaCategoria, '(TODOS)'), 
			 @ConsCtaFamilia	= ISNULL(CtaFamilia, '(TODOS)'), 
			 @ConsCtaGrupo		= ISNULL(CtaGrupo, '(TODOS)'), 			 			 			 
			 @ConsSucursal		= ISNULL(CONVERT(varchar, Sucursal), '(TODOS)'), 
			 @ConsUEN			= ISNULL(CONVERT(varchar, UEN), '(TODOS)'), 
			 @ConsMovimiento	= ISNULL(Movimiento, '(TODOS)'), 
			 @ConsEstatus		= ISNULL(Estatus, '(TODOS)'), 
			 @ConsProyecto		= ISNULL(Proyecto, '(TODOS)'), 
			 @ConsContactoTipo	= ISNULL(ContactoTipo, '(TODOS)'), 
			 @ConsContacto		= ISNULL(Contacto, '(TODOS)'), 
			 @ConsImporteMinimo = ISNULL(ImporteMin, 0), 
			 @ConsImporteMaximo	= ISNULL(ImporteMax, 0),
			 @ConsTotalizador	= Totalizador,
			 @ConsAccion		= Accion
        FROM CorteDConsultaNormalizada
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	= @RID

      SELECT @TotalInfDebe   = SUM(Cargo),
			 @TotalInfHaber  = SUM(Abono),
			 @TotalInfSaldo  = SUM(Saldo),
			 @TotalInfSaldoI = SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Informar'      

      SELECT @TotalSumaDebe   = SUM(Cargo),
			 @TotalSumaHaber  = SUM(Abono),
			 @TotalSumaSaldo  = SUM(Saldo),
			 @TotalSumaSaldoI = SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Sumar'

      SELECT @TotalRestaDebe   = SUM(Cargo),
			 @TotalRestaHaber  = SUM(Abono),
			 @TotalRestaSaldo  = SUM(Saldo),
			 @TotalRestaSaldoI = SUM(SaldoI)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND RID	= @RID
         AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(Accion, '')		= 'Restar'
      
      IF @Desglosar <> 'No'         
      BEGIN
        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna5,																			
			      Columna6,													
			      Columna7,																			
			      Columna8,
				  Agrupador1)
           SELECT @ID,
				  'DET',
				  d.Cuenta,
				  Cta.Descripcion,
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.SaldoI)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Cargo)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Abono)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Saldo)), '$'),
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
             JOIN Cta ON d.Cuenta = Cta.Cuenta
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Informar'
            GROUP BY d.Cuenta, Cta.Descripcion, d.Mov, d.MovID, d.Fecha

        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna9,																			
			      Columna10,													
			      Columna11,																			
			      Columna12,
			      Columna17,
				  Agrupador1)
           SELECT @ID,
				  'DET',
				  d.Cuenta,
				  Cta.Descripcion,
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.SaldoI)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Cargo)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Abono)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Saldo)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Saldo)), '$'),
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
             JOIN Cta ON d.Cuenta = Cta.Cuenta
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Sumar'
            GROUP BY d.Cuenta, Cta.Descripcion, d.Mov, d.MovID, d.Fecha
             
        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna13,																			
			      Columna14,													
			      Columna15,																			
			      Columna16,
			      Columna17,
				  Agrupador1)
           SELECT @ID,
				  'DET',
				  d.Cuenta,
				  Cta.Descripcion,
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.SaldoI)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Cargo)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Abono)), '$'),
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(d.Saldo)), '$'),				  				  				  
				  NULLIF(dbo.fnMonetarioEnTexto(SUM(-d.Saldo)), '$'),				  				  
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
             JOIN Cta ON d.Cuenta = Cta.Cuenta
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Restar'
            GROUP BY d.Cuenta, Cta.Descripcion, d.Mov, d.MovID, d.Fecha
      END
      ELSE
      BEGIN
        IF @ConsAccion = 'Informar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna4,					
			        Columna5,												Columna6,					
			        Columna7,												Columna8,				
			        Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											'',
					@ConsMovimiento,										'(TODOS)',					
					NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalInfDebe), '$'),	
					NULLIF(dbo.fnMonetarioEnTexto(@TotalInfHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldo), '$'),
					@AgrupadorAux
        ELSE IF @ConsAccion = 'Sumar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna4,					
			        Columna9,												Columna10,					
			        Columna11,												Columna12,				
			        Columna17,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											'',
					@ConsMovimiento,										'(TODOS)',					
					NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaDebe), '$'),	
					NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldo), '$'),
					NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldo), '$'),	@AgrupadorAux
        ELSE IF @ConsAccion = 'Restar'
          INSERT INTO #CorteDReporte(
			        ID,														Tipo,						
			        Columna1,												Columna2,				
			        Columna3,												Columna4,					
			        Columna13,												Columna14,					
			        Columna15,												Columna16,
			        Columna17,												Agrupador1)
             SELECT @ID,													'DET',						
					@ConsCuenta,											'',
					@ConsMovimiento,										'(TODOS)',					
					NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaDebe), '$'),	
					NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldo), '$'),
					NULLIF(dbo.fnMonetarioEnTexto(-@TotalRestaSaldo), '$'),	@AgrupadorAux
      END

      INSERT INTO #CorteDReporte(
				ID,														Tipo,													Columna1,			
				Columna2,												Columna3,												Columna4,			
				Columna5,												Columna6,												Columna7, 
				Columna8,												Columna9,												Columna10,			
				Columna11,												Columna12,												Columna13,			
				Columna14,												Columna15,												Columna16, 
				Columna17,												Columna18,												Columna19,			
				Columna20,												Columna21,												Columna22,			
				Columna23,												Columna24,												Columna25, 
				Columna26,												Columna27,												Columna28,			
				Columna29,												Columna30,												Columna31,
				Columna32,												Columna33,												Columna34,
				Columna35,												Columna36,												Columna37,
				Columna38,												Columna39,												Columna40,
				Columna41,												Columna42,												Columna43,
				Agrupador1)
		 SELECT @ID,													'SUBT',													'Empresa',
				@ConsEmpresa,											'Cuenta',												@ConsCuenta,
				'Categoria',											@ConsCtaCategoria,										'Familia',
				@ConsCtaFamilia,										'Grupo',												@ConsCtaGrupo,	 
			   'Sucursal',												@ConsSucursal,											'UEN',
				@ConsUEN,												'Movimiento',											@ConsMovimiento,
				'Estatus',												@ConsEstatus,											'Proyecto',
				@ConsProyecto,											'Tipo Contacto',										@ConsContactoTipo,
				'Contacto',												@ConsContacto,											'Importe Min.',
				dbo.fnMonetarioEnTexto(@ConsImporteMinimo),				'Importe Max.',											NULLIF(dbo.fnMonetarioEnTexto(@ConsImporteMaximo), '$'),
				'Totalizador',											@ConsTotalizador,										NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldoI), '$'),
				NULLIF(dbo.fnMonetarioEnTexto(@TotalInfDebe), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalInfHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldo), '$'),
				NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaDebe), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaHaber), '$'),			
				NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldo), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaDebe), '$'),				  
				NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldo), '$'),	NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), '$'),
				@AgrupadorAux
    END

    SELECT @TotalInfDebe   = SUM(Cargo),
		   @TotalInfHaber  = SUM(Abono),
		   @TotalInfSaldo  = SUM(Saldo),
		   @TotalInfSaldoI = SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Informar'      

    SELECT @TotalSumaDebe   = SUM(Cargo),
		   @TotalSumaHaber  = SUM(Abono),
		   @TotalSumaSaldo  = SUM(Saldo),
		   @TotalSumaSaldoI = SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Sumar'

    SELECT @TotalRestaDebe   = SUM(Cargo),
		   @TotalRestaHaber  = SUM(Abono),
		   @TotalRestaSaldo  = SUM(Saldo),
		   @TotalRestaSaldoI = SUM(SaldoI)
      FROM CorteDConsulta
     WHERE ID		= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')		= 'Restar'
      
    INSERT INTO #CorteDReporte(
			  ID,														Tipo,													Columna1,										
			  Columna2,													Columna3,												Columna4,
			  Columna5,													Columna6,												Columna7,
			  Columna8,													Columna9,												Columna10,
			  Columna11,												Columna12,												Columna13,
			  Columna14,												Agrupador1)
       SELECT @ID,														'SUBT2',												CASE @TipoCambio WHEN 1.0 THEN 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ')' ELSE 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			  NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldoI), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalInfDebe), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalInfHaber), '$'),			
			  NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldo), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaDebe), '$'),			
			  NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaHaber), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldo), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldoI), '$'),		
			  NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaDebe), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldo), '$'),		
			  NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), '$'), @AgrupadorAux
  END
  
  SELECT @TotalInfDebe   = SUM(Cargo),
		 @TotalInfHaber  = SUM(Abono),
		 @TotalInfSaldo  = SUM(Saldo),
		 @TotalInfSaldoI = SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Informar'      

  SELECT @TotalSumaDebe   = SUM(Cargo),
		 @TotalSumaHaber  = SUM(Abono),
		 @TotalSumaSaldo  = SUM(Saldo),
		 @TotalSumaSaldoI = SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Sumar'

  SELECT @TotalRestaDebe   = SUM(Cargo),
		 @TotalRestaHaber  = SUM(Abono),
		 @TotalRestaSaldo  = SUM(Saldo),
		 @TotalRestaSaldoI = SUM(SaldoI)
    FROM CorteDConsulta
   WHERE ID		= @ID 
     AND ISNULL(Accion, '')		= 'Restar'
      
  INSERT INTO #CorteDReporte(
			ID,														Tipo,													Columna1,										
			Columna2,												Columna3,												Columna4,
			Columna5,												Columna6,												Columna7,
			Columna8,												Columna9,												Columna10,
			Columna11,												Columna12,												Columna13,
			Columna14,												Agrupador1)  
     SELECT @ID,													'TOT',													CASE @TipoCambio WHEN 1.0 THEN 'Gran Total' + ' (' + @Moneda + ')' ELSE 'Gran Total' + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalInfDebe), '$'),		NULLIF(dbo.fnMonetarioEnTexto(@TotalInfHaber), '$'),			
			NULLIF(dbo.fnMonetarioEnTexto(@TotalInfSaldo), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldoI), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaDebe), '$'),			
			NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalSumaSaldo), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldoI), '$'),		
			NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaDebe), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaHaber), '$'),	NULLIF(dbo.fnMonetarioEnTexto(@TotalRestaSaldo), '$'),		
			NULLIF(dbo.fnMonetarioEnTexto(ISNULL(@TotalSumaSaldo, 0)-ISNULL(@TotalRestaSaldo, 0)), '$'), @AgrupadorAux

  RETURN
END
GO

/**************** spCorteDReporteCorteImp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteCorteImp') and type = 'P') drop procedure dbo.spCorteDReporteCorteImp
GO
CREATE PROC spCorteDReporteCorteImp
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
			@CorteFiltrarFechas	bit,				
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @Direccion2				varchar(100),
		  @Direccion3				varchar(100),
		  @Direccion4				varchar(100),
		  @FechaA					datetime,
		  @AgrupadorAux				varchar(50),
		  @AgrupadorAuxAnt			varchar(50),
		  @RID						int,
		  @RIDAnt					int,
		  
		  @Desglosar				varchar(20),
		  @ConsMoneda				varchar(10),
		  @ConsEmpresa				varchar(10),
		  @ConsSucursal				varchar(10),
		  @ConsUEN					varchar(10),
		  @ConsUsuario				varchar(10),
		  @ConsModulo				varchar(10),
		  @ConsMovimiento			varchar(20),
		  @ConsEstatus				varchar(15),
		  @ConsSituacion			varchar(50),
		  @ConsProyecto				varchar(50),
		  @ConsContactoTipo			varchar(20),
		  @ConsContacto				varchar(10),
		  @ConsImporteMinimo		float,
		  @ConsImporteMaximo		float,
		  @ConsTotalizador			varchar(255),
		  @ConsAccion				varchar(8),
		  
		  @PrimerCiclo			bit,
		  @TotalSuma			float,
		  @TotalResta			float,
		  @TotalInformativo		float,

		  @TotalSumaU			float,
		  @TotalRestaU			float,
		  @TotalInformativoU	float,		  
		  
		  @Total				float,		  
		  @TotalU				float,
		  
		  @RangoFecha			varchar(255),
		  @TipoTotalizador		varchar(255)

  SELECT @TipoTotalizador = Tipo
    FROM CorteMovTotalizadorTipoCampo
    JOIN CorteDConsulta ON CorteMovTotalizadorTipoCampo.Totalizador = CorteDConsulta.Totalizador
   WHERE CorteDConsulta.ID = @ID
   
  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @Estacion, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @Estacion

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion

  SELECT @FechaA = GETDATE()
  		  
  SELECT @AgrupadorAux = MIN(Agrupador)
    FROM CorteDConsulta
   WHERE ID	= @ID  
   
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@AgrupadorAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@AgrupadorAux			
	   FROM Corte
	  WHERE ID = @ID	  	  
	  
  IF ISNULL(@CorteFiltrarFechas, 0) = 1
  BEGIN
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC5',		'De la fecha ' + dbo.fnFormatearFecha(@CorteFechaD, 'dd/MM/aaaa') + ' A la fecha ' + dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),
  			  @AgrupadorAux
  END
  ELSE
  BEGIN
    SELECT @RangoFecha = ''
    IF ISNULL(@CorteEjercicio, 0) <> 0
      SELECT @RangoFecha = 'Ejercicio ' + CONVERT(varchar, ISNULL(@CorteEjercicio, 0)) + ' '

    IF ISNULL(@CortePeriodo, 0) <> 0
      SELECT @RangoFecha = @RangoFecha + 'Periodo ' + CONVERT(varchar, ISNULL(@CortePeriodo, 0))
      
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,		Columna1,		
			  Agrupador1)
  	   SELECT @ID,		'ENC6',		@RangoFecha,
  			  @AgrupadorAux
  END

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC7', Empresa.Nombre,	@AgrupadorAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8',  Direccion2, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC9',  Direccion3, @AgrupadorAux FROM @ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC10', Direccion4, @AgrupadorAux FROM @ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,		Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC11',	@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@AgrupadorAux

  IF @TipoTotalizador = 'Monetario'
    INSERT INTO #CorteDReporte(
  		      ID,											Tipo,													Columna1,				
		      Columna2,										Columna3,												Columna4,
			  Columna5,										Columna6,												Columna7,				
			  Columna8,										Columna9,												Columna10,
			  Columna11,									Columna12,												Agrupador1)
       SELECT @ID,											'NOM',													'Movimiento',			
			  'Estatus',									'Fecha',												'Moneda',
			  'Tipo Cambio',								'Sucursal',												'Ejercicio',			
			  'Periodo',									'Informar (' + ISNULL(@Moneda, '') + ')',				'Sumar (' + ISNULL(@Moneda, '') + ')',
			  'Restar (' + ISNULL(@Moneda, '') + ')',		'Total (' + ISNULL(@Moneda, '') + ')',					@AgrupadorAux
  ELSE IF @TipoTotalizador = 'Unidad'
    INSERT INTO #CorteDReporte(
  		      ID,					Tipo,				Columna1,				
		      Columna2,				Columna3,			Columna4,
			  Columna5,				Columna6,			Columna7,				
			  Columna8,				Columna9,			Columna10,
			  Columna11,			Columna12,			Agrupador1)
       SELECT @ID,					'NOM',				'Movimiento',			
			  'Estatus',			'Fecha',			'Moneda',
			  'Tipo Cambio',		'Sucursal',			'Ejercicio',			
			  'Periodo',			'Informar',			'Sumar',
			  'Restar',				'Total',			@AgrupadorAux
			    
  SELECT @AgrupadorAuxAnt = '', @PrimerCiclo = 1
  WHILE(1=1)
  BEGIN
    IF @PrimerCiclo = 1
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') >= @AgrupadorAuxAnt
    ELSE
      SELECT @AgrupadorAux = MIN(Agrupador)
        FROM CorteDConsulta
       WHERE ID	= @ID 
         AND ISNULL(Agrupador, '') > @AgrupadorAuxAnt
                         
    IF @AgrupadorAux IS NULL AND @PrimerCiclo = 0 BREAK
    
    SELECT @AgrupadorAuxAnt = @AgrupadorAux, @PrimerCiclo = 0, @TotalInformativo = 0, @TotalResta = 0, @TotalSuma = 0, @Total = 0,
		   @TotalInformativoU = 0, @TotalRestaU = 0, @TotalSumaU = 0, @TotalU = 0

    INSERT INTO #CorteDReporte(
			  ID,	Tipo,		Columna1,					Agrupador1)
       SELECT @ID,	'SUBT3',	ISNULL(@AgrupadorAux, ''),	@AgrupadorAux    
			      
    SELECT @RIDAnt = 0
    WHILE(1=1)
    BEGIN
      SELECT @RID = MIN(RID)
        FROM CorteDConsulta
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	> @RIDAnt
      
      IF @RID IS NULL BREAK
      
      SELECT @RIDAnt = @RID, @Desglosar = ''

      SELECT @ConsMoneda = NULL, @ConsEmpresa = NULL, @ConsSucursal = NULL, @ConsUEN = NULL, @ConsUsuario = NULL, @ConsModulo = NULL, 
			 @ConsMovimiento = NULL, @ConsEstatus = NULL, @ConsSituacion = NULL, @ConsProyecto = NULL, @ConsContactoTipo = NULL, 
			 @ConsContacto = NULL, @ConsImporteMinimo = NULL, @ConsImporteMaximo = NULL, @ConsTotalizador = NULL, @ConsAccion = NULL

      SELECT @Desglosar			= ISNULL(Desglosar, 'No'),
			 @ConsMoneda		= ISNULL(Moneda, '(TODOS)'), 
			 @ConsEmpresa		= ISNULL(Empresa, '(TODOS)'), 
			 @ConsSucursal		= ISNULL(CONVERT(varchar, Sucursal), '(TODOS)'), 
			 @ConsUEN			= ISNULL(CONVERT(varchar, UEN), '(TODOS)'), 
			 @ConsUsuario		= ISNULL(Usuario, '(TODOS)'), 
			 @ConsModulo		= Modulo, 
			 @ConsMovimiento	= ISNULL(Movimiento, '(TODOS)'), 
			 @ConsEstatus		= ISNULL(Estatus, '(TODOS)'), 
			 @ConsSituacion		= ISNULL(Situacion, '(TODOS)'), 
			 @ConsProyecto		= ISNULL(Proyecto, '(TODOS)'), 
			 @ConsContactoTipo	= ISNULL(ContactoTipo, '(TODOS)'), 
			 @ConsContacto		= ISNULL(Contacto, '(TODOS)'), 
			 @ConsImporteMinimo = ISNULL(ImporteMin, 0), 
			 @ConsImporteMaximo	= ISNULL(ImporteMax, 0),
			 @ConsTotalizador	= Totalizador,
			 @ConsAccion		= Accion
        FROM CorteDConsultaNormalizada
       WHERE ID		= @ID 
         AND ISNULL(Agrupador, '') = ISNULL(@AgrupadorAux, '')
         AND RID	= @RID

      SELECT @TotalInformativo  = SUM(d.Importe),
			 @TotalInformativoU = SUM(d.SaldoU)
        FROM CorteD d
        JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
       WHERE c.ID		= @ID 
         AND c.RID		= @RID
         AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(c.Accion, '')		= 'Informar'      

      SELECT @TotalSuma  = SUM(d.Importe),
			 @TotalSumaU = SUM(d.SaldoU)
        FROM CorteD d
        JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
       WHERE c.ID		= @ID 
         AND c.RID		= @RID
         AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(c.Accion, '')		= 'Sumar'               

      SELECT @TotalResta  = SUM(d.Importe),
			 @TotalRestaU = SUM(d.SaldoU)
        FROM CorteD d
        JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
       WHERE c.ID		= @ID 
         AND c.RID		= @RID
         AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
         AND ISNULL(c.Accion, '')		= 'Restar'
      
      SELECT @Total  = ISNULL(@TotalSuma, 0)  - ISNULL(@TotalResta, 0),
			 @TotalU = ISNULL(@TotalSumaU, 0) - ISNULL(@TotalRestaU, 0)
      
      IF @Desglosar <> 'No'         
      BEGIN
        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna5,																			
			      Columna6,													
			      Columna7,																			
			      Columna8,				
				  Columna9,	
				  --Columna12,										
				  Agrupador1)
           SELECT @ID,																				
				  'DET',
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Estatus ELSE @ConsEstatus END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Moneda ELSE @ConsMoneda END,
				  CASE @Desglosar WHEN 'Movimiento' THEN dbo.fnMonetarioEnTexto(d.TipoCambio) ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Sucursal) ELSE CONVERT(varchar, @ConsSucursal) END,
				  d.Ejercicio,																		
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Periodo) WHEN 'Ejercicio' THEN '(TODOS)' WHEN 'Periodo' THEN CONVERT(varchar, d.Periodo) END,
				  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, d.Importe, d.SaldoU), '$'),
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Informar'

        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna5,																			
			      Columna6,													
			      Columna7,																			
			      Columna8,				
			      Columna10,
			      Columna12,
			      Agrupador1)
           SELECT @ID,																				
				  'DET',
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Estatus ELSE @ConsEstatus END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Moneda ELSE @ConsMoneda END,
				  CASE @Desglosar WHEN 'Movimiento' THEN dbo.fnMonetarioEnTexto(d.TipoCambio) ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Sucursal) ELSE CONVERT(varchar, @ConsSucursal) END,
				  d.Ejercicio,
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Periodo) WHEN 'Ejercicio' THEN '(TODOS)' WHEN 'Periodo' THEN CONVERT(varchar, d.Periodo) END,
				  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, d.Importe, d.SaldoU), '$'),										
				  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, d.Importe, d.SaldoU), '$'),										
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Sumar'
              
        INSERT INTO #CorteDReporte(
			      ID,																				
			      Tipo,														
			      Columna1,																			
			      Columna2,				
			      Columna3,																			
			      Columna4,			
			      Columna5,																			
			      Columna6,													
			      Columna7,																			
			      Columna8,				
			      Columna11,	
			      Columna12,												
			      Agrupador1)
           SELECT @ID,																				
				  'DET',
				  CASE @Desglosar WHEN 'Movimiento' THEN RTRIM(d.Mov) +' '+ RTRIM(ISNULL(d.MovID, '')) ELSE @ConsMovimiento END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Estatus ELSE @ConsEstatus END,
				  CASE @Desglosar WHEN 'Movimiento' THEN NULLIF(dbo.fnFormatearFecha(d.Fecha, 'dd/MM/aaaa'), '//') ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN d.Moneda ELSE @ConsMoneda END,
				  CASE @Desglosar WHEN 'Movimiento' THEN dbo.fnMonetarioEnTexto(d.TipoCambio) ELSE '(TODOS)' END,
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Sucursal) ELSE CONVERT(varchar, @ConsSucursal) END,
				  d.Ejercicio,																		
				  CASE @Desglosar WHEN 'Movimiento' THEN CONVERT(varchar, d.Periodo) WHEN 'Ejercicio' THEN '(TODOS)' WHEN 'Periodo' THEN CONVERT(varchar, d.Periodo) END,
				  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, d.Importe, d.SaldoU), '$'),										
				  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, -d.Importe, -d.SaldoU), '$'),										
				  @AgrupadorAux
             FROM CorteD d
             JOIN CorteDConsulta c ON d.ID = c.ID AND d.RIDConsulta = c.RID
            WHERE c.ID		= @ID 
              AND c.RID		= @RID
              AND ISNULL(c.Agrupador, '')	= ISNULL(@AgrupadorAux, '')
              AND ISNULL(c.Accion, '')		= 'Restar'
      END
      ELSE
      BEGIN
        IF @ConsAccion = 'Informar'
          INSERT INTO #CorteDReporte(
			        ID,						Tipo,						Columna1,						Columna2,
					Columna3,				Columna4,					Columna5,						Columna6,
					Columna7,				Columna8,					Columna9,						--Columna12,
					Agrupador1)
             SELECT @ID,					'DET',						@ConsMovimiento,				
					@ConsEstatus,			'(TODOS)',					@ConsMoneda,					'(TODOS)',
					@ConsSucursal,			'(TODOS)',					'(TODOS)',						NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),
					@AgrupadorAux
        ELSE IF @ConsAccion = 'Sumar'
          INSERT INTO #CorteDReporte(
			        ID,						Tipo,						Columna1,						Columna2,
					Columna3,				Columna4,					Columna5,						Columna6,
					Columna7,				Columna8,					Columna10,						Columna12,
					Agrupador1)
             SELECT @ID,					'DET',						@ConsMovimiento,				
					@ConsEstatus,			'(TODOS)',					@ConsMoneda,					'(TODOS)',
					@ConsSucursal,			'(TODOS)',					'(TODOS)',						NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),
					NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),	@AgrupadorAux
        ELSE IF @ConsAccion = 'Restar'
          INSERT INTO #CorteDReporte(
			        ID,						Tipo,						Columna1,						Columna2,
					Columna3,				Columna4,					Columna5,						Columna6,
					Columna7,				Columna8,					Columna11,						Columna12,
					Agrupador1)
             SELECT @ID,					'DET',						@ConsMovimiento,				
					@ConsEstatus,			'(TODOS)',					@ConsMoneda,					'(TODOS)',
					@ConsSucursal,			'(TODOS)',					'(TODOS)',						NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'),
					NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'),	@AgrupadorAux					
      END

      INSERT INTO #CorteDReporte(
				ID,													  Tipo,												Columna1,			
				Columna2,											  Columna3,											Columna4,			
				Columna5,											  Columna6,											Columna7, 
				Columna8,											  Columna9,											Columna10,			
				Columna11,											  Columna12,										Columna13,			
				Columna14,											  Columna15,										Columna16, 
				Columna17,											  Columna18,										Columna19,			
				Columna20,											  Columna21,										Columna22,			
				Columna23,											  Columna24,										Columna25, 
				Columna26,											  Columna27,										Columna28,			
				Columna29,											  Columna30,										Columna31,			
				Columna32,											  Columna33,										Columna34,
				Agrupador1)
		 SELECT @ID,												  'SUBT',											'Moneda',			
				@ConsMoneda,										  'Empresa',										@ConsEmpresa,		
				'Sucursal',											  @ConsSucursal,									'UEN', 
				@ConsUEN,											  'Usuario',										@ConsUsuario,		
				'Modulo',											  @ConsModulo,										'Movimiento',		
				@ConsMovimiento,									  'Estatus',										@ConsEstatus, 
				'Situación',										  @ConsSituacion,									'Proyecto',			
				@ConsProyecto,										  'Tipo Contacto',									@ConsContactoTipo,	
				'Contacto',											  @ConsContacto,									'Importe Min.', 
				dbo.fnMonetarioEnTexto(@ConsImporteMinimo),'Importe Max.', 
				dbo.fnMonetarioEnTexto(ISNULL(@ConsImporteMaximo, 0)), 
				'Totalizador',										  @ConsTotalizador,									NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),
				NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),							
				NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'),	
				NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @Total, @TotalU), '$'),
				@AgrupadorAux
    END
    
    SELECT @TotalInformativo  = SUM(Importe),
           @TotalInformativoU = SUM(SaldoU)
      FROM CorteDConsulta
     WHERE ID	= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')
       AND ISNULL(Accion, '')	= 'Informar'

    SELECT @TotalSuma	= SUM(Importe),
		   @TotalSumaU	= SUM(SaldoU)
      FROM CorteDConsulta
     WHERE ID	= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')     
       AND ISNULL(Accion, '')	= 'Sumar'

    SELECT @TotalResta	= SUM(Importe),
		   @TotalRestaU = SUM(SaldoU)
      FROM CorteDConsulta
     WHERE ID	= @ID 
       AND ISNULL(Agrupador, '')	= ISNULL(@AgrupadorAux, '')     
       AND ISNULL(Accion, '')	= 'Restar'
       
    SELECT @Total  = ISNULL(@TotalSuma, 0) - ISNULL(@TotalResta, 0),
		   @TotalU = ISNULL(@TotalSumaU, 0) - ISNULL(@TotalRestaU, 0)
    
    IF @TipoTotalizador = 'Monetario'
      INSERT INTO #CorteDReporte(
			    ID,																	Tipo,												Columna1,										
			    Columna2,															Columna3,											Columna4,
			    Columna5,															Agrupador1)
         SELECT @ID,																'SUBT2',											CASE @TipoCambio WHEN 1.0 THEN 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ')' ELSE 'Total ' + ISNULL(@AgrupadorAux, '') + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'), 
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @Total, @TotalU), '$'),				
			    @AgrupadorAux    
    ELSE IF @TipoTotalizador = 'Unidad'
      INSERT INTO #CorteDReporte(
			    ID,																	Tipo,														Columna1,										
			    Columna2,															Columna3,													Columna4,
			    Columna5,															Agrupador1)
         SELECT @ID,																'SUBT2',													'Total ' + ISNULL(@AgrupadorAux, ''),	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),	
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'), 
			    NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @Total, @TotalU), '$'),				
			    @AgrupadorAux  
  END
  
  SELECT @TotalInformativo	= SUM(Importe),
		 @TotalInformativoU = SUM(SaldoU)
    FROM CorteDConsulta
   WHERE ID	= @ID 
     AND ISNULL(Accion, '')	= 'Informar'

  SELECT @TotalSuma	 = SUM(Importe),
		 @TotalSumaU = SUM(SaldoU)
    FROM CorteDConsulta
   WHERE ID	= @ID 
     AND ISNULL(Accion, '')	= 'Sumar'

  SELECT @TotalResta  = SUM(Importe),
		 @TotalRestaU = SUM(SaldoU)
    FROM CorteDConsulta
   WHERE ID	= @ID 
     AND ISNULL(Accion, '')	= 'Restar'

  SELECT @Total  = ISNULL(@TotalSuma, 0) - ISNULL(@TotalResta, 0),
		 @TotalU = ISNULL(@TotalSumaU, 0) - ISNULL(@TotalRestaU, 0)

  IF @TipoTotalizador = 'Monetario'  
    INSERT INTO #CorteDReporte(
			  ID,																Tipo,												Columna1,		
			  Columna2,															Columna3,											Columna4,
		      Columna5,															Agrupador1)
       SELECT @ID,																'TOT',												CASE @TipoCambio WHEN 1.0 THEN 'Gran Total' + ' (' + @Moneda + ')' ELSE 'Gran Total' + ' (' + @Moneda + ' - ' + RTRIM(dbo.fnMonetarioEnTexto(@TipoCambio)) + ')' END,
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),	
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'), 
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @Total, @TotalU), '$'),			
			  @AgrupadorAux    
  ELSE IF @TipoTotalizador = 'Unidad'
    INSERT INTO #CorteDReporte(
			  ID,																Tipo,														Columna1,		
			  Columna2,															Columna3,													Columna4,
		      Columna5,															Agrupador1)
       SELECT @ID,																'TOT',														'Gran Total',
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalInformativo, @TotalInformativoU), '$'),
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalSuma, @TotalSumaU), '$'),	
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @TotalResta, @TotalRestaU), '$'), 
			  NULLIF(dbo.fnCorteImporteCantidadEnTexto(@TipoTotalizador, @Total, @TotalU), '$'),			
			  @AgrupadorAux    
  RETURN
END
GO

/**************** spCorteDReporteInvVal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteInvVal') and type = 'P') drop procedure dbo.spCorteDReporteInvVal
GO
CREATE PROC spCorteDReporteInvVal
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),				
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @CuentaAux		varchar(10),
		  @CuentaAuxAnt		varchar(10),
		  @FechaA			datetime

  SELECT @FechaA = GETDATE()
  		  
  SELECT @CuentaAux = MIN(Cuenta)
    FROM CorteD
   WHERE ID	= @ID  
  
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@CuentaAux


  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'ENC5', Empresa.Nombre,	@CuentaAux
       FROM Empresa
	  WHERE Empresa = @Empresa

  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC6', Direccion2, @CuentaAux FROM #ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC7', Direccion3, @CuentaAux FROM #ContactoDireccion
  INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'ENC8', Direccion4, @CuentaAux FROM #ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,												Tipo,		Columna1,		Columna2,		
			Columna3,										Agrupador1) 
	 SELECT @ID,											'ENC9',		@CorteTitulo,	'',
			dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),	@CuentaAux
	   FROM #ContactoDireccion

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,
			Agrupador1)
	 SELECT @ID,	'ENC10', 'A la Fecha',	dbo.fnFormatearFecha(@CorteFechaA, 'dd/MM/aaaa'),
			@CuentaAux

   INSERT INTO #CorteDReporte(
			 ID,		Tipo,		Columna1,		Columna2,		Columna3,		Columna4,											 Columna5,
			 Agrupador1)
	  SELECT @ID,		'NOM1',		'Artículo',		'Descripción',	'Existencias',	ISNULL(NULLIF(@CorteValuacion, '(Sin Valuar)'), ''), CASE @CorteValuacion WHEN '(Sin Valuar)' THEN '' ELSE 'Total' END,
			 @CuentaAux

  SELECT @CuentaAuxAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @CuentaAux =  MIN(Cuenta)
      FROM CorteD
     WHERE ID = @ID
       AND Cuenta > @CuentaAuxAnt
       
    IF @CuentaAux IS NULL BREAK
    
    SELECT @CuentaAuxAnt = @CuentaAux

    INSERT INTO #CorteDReporte(
			   ID,		Tipo,		Columna1,		Columna2,		Agrupador1)
	    SELECT @ID,		'NOM2',		@CuentaAux,		Descripcion1,	@CuentaAux
	      FROM Art WHERE Articulo = @CuentaAux    

    INSERT INTO #CorteDReporte(
			   ID,																														Tipo,
			   Columna1,																												Columna2,
			   Columna3,																												Columna4,
			   Columna5,																												Agrupador1)
        SELECT @ID,																														'DET',
			   Almacen,																													Nombre,
			   CONVERT(varchar, CONVERT(money, SaldoU), 1),																				CASE @CorteValuacion WHEN '(Sin Valuar)' THEN NULL ELSE dbo.fnMonetarioEnTexto(ISNULL(ValuacionValor, 0)) END,	
			   CASE @CorteValuacion WHEN '(Sin Valuar)' THEN NULL ELSE dbo.fnMonetarioEnTexto(ISNULL(ValuacionValor * SaldoU, 0)) END,	@CuentaAux
		  FROM CorteD
		  JOIN Alm ON CorteD.Grupo = Alm.Almacen
         WHERE ID			 = @ID
           AND CorteD.Cuenta = @CuentaAux
         ORDER BY Alm.Almacen

    INSERT INTO #CorteDReporte(
			   ID,																														Tipo,						
			   Columna1,																												Columna2,				
			   Columna3,																												Columna4,											
			   Columna5,																												Columna6,				
			   Agrupador1)
        SELECT @ID,																														'SUBT',						
			   'Total',																													@CuentaAux,				
			   Descripcion1,																											CONVERT(varchar, CONVERT(money, SUM(SaldoU)), 1),	
			   CASE @CorteValuacion WHEN '(Sin Valuar)' THEN NULL ELSE dbo.fnMonetarioEnTexto(ISNULL(ValuacionValorArtConCosto, 0)) END,CASE @CorteValuacion WHEN '(Sin Valuar)' THEN NULL ELSE dbo.fnMonetarioEnTexto(ISNULL(SUM(ValuacionValor * SaldoU), 0)) END,
			   @CuentaAux
          FROM CorteD
		  JOIN Art ON CorteD.Cuenta = Art.Articulo
         WHERE ID			 = @ID
           AND CorteD.Cuenta = @CuentaAux
         GROUP BY Descripcion1, ValuacionValorArtConCosto
  END

  INSERT INTO #CorteDReporte(
			 ID,																															Tipo,						
			 Columna1,																														Columna2,
			 Columna3,																														Columna4,
			 Agrupador1)
      SELECT @ID,																															'TOT',						
			 'Total General',																												CONVERT(varchar, CONVERT(money, SUM(SaldoU)), 1),	
			 CASE @CorteValuacion WHEN '(Sin Valuar)' THEN NULL ELSE dbo.fnMonetarioEnTexto(ISNULL(SUM(ValuacionValor * SaldoU), 0)) END,	Moneda,
			 @CuentaAux
        FROM CorteD
		JOIN Art ON CorteD.Cuenta = Art.Articulo
       WHERE ID				= @ID
       GROUP BY Moneda
  RETURN
END
GO

/**************** spCorteDReporteCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporteCx') and type = 'P') drop procedure dbo.spCorteDReporteCx
GO
CREATE PROC spCorteDReporteCx
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),						
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @FechaA			datetime,
		  @CuentaAux		varchar(10),
		  @CuentaAuxAnt		varchar(10),
		  @MonedaAux		varchar(10),
		  @MonedaAuxAnt		varchar(10),
		  @AplicaAux		varchar(20),
		  @AplicaAuxAnt		varchar(20),
		  @AplicaIDAux		varchar(20),
	      @AplicaIDAuxAnt	varchar(20)

  SELECT @CuentaAux = MIN(Cuenta)
    FROM CorteD
   WHERE ID	= @ID  

  SELECT @FechaA = GETDATE()
    
  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Agrupador1)
	 SELECT @ID,	'TIT',	@CorteTitulo,	@CuentaAux

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC1',	'Referencia:',	Referencia,			'Tipo:',			CorteTipo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC2',	'Concepto:',	Concepto,			'Grupo:',			CorteGrupo,			@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		 Columna2,			Columna3,			Columna4,			Agrupador1)
	 SELECT @ID,	'ENC3',	'Observaciones:',Observaciones,		'Frecuencia:',		CorteFrecuencia,	@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	  

  INSERT INTO #CorteDReporte(
			ID,		Tipo,	Columna1,		Columna2,			Agrupador1)
	 SELECT @ID,	'ENC4',	'Origen:',		CorteOrigen,		@CuentaAux			
	   FROM Corte
	  WHERE ID = @ID	
	  
  IF @MovTipo = 'CORTE.EDOCTACXC'
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,	Columna1,									Columna2,		Agrupador1)
	   SELECT @ID,		'ENC5', 'Estado de Cuenta Simplificado - Clientes',	Empresa.Nombre,	@CuentaAux
    	   FROM Empresa
	    WHERE Empresa = @Empresa
  ELSE IF @MovTipo = 'CORTE.EDOCTACXP'
    INSERT INTO #CorteDReporte(
			  ID,		Tipo,	Columna1,										Columna2,		Agrupador1)
	   SELECT @ID,		'ENC5', 'Estado de Cuenta Simplificado - Proveedores',	Empresa.Nombre,	@CuentaAux
    	   FROM Empresa
	    WHERE Empresa = @Empresa
	    
  INSERT INTO #CorteDReporte(
			ID,			Tipo,										Columna1,		Columna2,
			Columna3,		Columna4,								Agrupador1)
	 SELECT @ID,			'ENC6',									'De la Fecha',	dbo.fnFormatearFecha(@CorteFechaD, 'dd/MM/aaaa'),
			'A la Fecha',	dbo.fnFormatearFecha(@FechaA, 'dd/MM/aaaa'),@CuentaAux  	  
	  
  SELECT @CuentaAuxAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @CuentaAux = MIN(Cuenta)
      FROM CorteD
     WHERE ID		= @ID
       AND Cuenta	> @CuentaAuxAnt

    IF @CuentaAux IS NULL BREAK
      
    SELECT @CuentaAuxAnt = @CuentaAux

    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', @CuentaAux, @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion1, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion2, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion3, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion4, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion5, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion6, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion7, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux
    INSERT INTO #CorteDReporte(ID, Tipo, Columna1, Agrupador1) SELECT @ID, 'DATOS1', Direccion8, @CuentaAux FROM #ContactoDireccion WHERE Contacto = @CuentaAux

    IF @MovTipo = 'CORTE.EDOCTACXC'
      INSERT INTO #CorteDReporte(
			     ID,			Tipo,		Columna1,			Columna2,		Agrupador1) 
          SELECT @ID,			'DATOS2',	'Días de Crédito',	CtaCreditoDias, @CuentaAux
            FROM CorteD
           WHERE ID		= @ID
             AND Cuenta	= @CuentaAux
           GROUP BY CtaCreditoDias

     INSERT INTO #CorteDReporte(
			   ID,		Tipo,		Columna1,				Columna2,		Agrupador1) 
        SELECT @ID,		'DATOS2',	'Condición de Pago',	CtaCondicion,	@CuentaAux
          FROM CorteD
         WHERE ID		= @ID
           AND Cuenta	= @CuentaAux
         GROUP BY CtaCondicion

     INSERT INTO #CorteDReporte(
			   ID,				Tipo,		Columna1,			
			   Columna2,		Agrupador1) 
        SELECT @ID,				'DATOS2',	'Límite de Crédito ' + ISNULL(CtaLimiteCreditoMoneda, ''),   
               CtaLimiteCredito,@CuentaAux
          FROM CorteD
         WHERE ID		= @ID
           AND Cuenta	= @CuentaAux
         GROUP BY CtaLimiteCreditoMoneda, CtaLimiteCredito
           
     INSERT INTO #CorteDReporte(
			   ID,			Tipo,		Columna1,		Columna2,		Columna3,		Columna4,	Columna5,		Columna6,
			   Columna7,	Columna8,	Agrupador1)
  		SELECT @ID,			'NOM',		'Movimiento',	'Consecutivo',	'Referencia',	'Fecha',	'Vencimiento',	'Cargo',
			   'Abono',		'Saldo',	@CuentaAux

     SELECT @MonedaAuxAnt = ''
     WHILE(1=1)
     BEGIN
       SELECT @MonedaAux = MIN(Moneda)
         FROM CorteD
        WHERE ID		= @ID
          AND Cuenta	= @CuentaAux
          AND Moneda	> @MonedaAuxAnt
                
       IF @MonedaAux IS NULL BREAK
         
       SELECT @MonedaAuxAnt = @MonedaAux

       SELECT @AplicaAuxAnt = ''
       WHILE(1=1)
       BEGIN
         SELECT @AplicaAux = MIN(Aplica)
           FROM CorteD
          WHERE ID		= @ID
            AND Cuenta	= @CuentaAux
            AND Moneda	= @MonedaAux
            AND Aplica	> @AplicaAuxAnt
       
         IF @AplicaAux IS NULL BREAK
         
         SELECT @AplicaAuxAnt = @AplicaAux

         SELECT @AplicaIDAuxAnt = ''
         WHILE(1=1)
         BEGIN
           SELECT @AplicaIDAux = MIN(AplicaID)
             FROM CorteD
            WHERE ID			= @ID
              AND Cuenta		= @CuentaAux
              AND Moneda		= @MonedaAux
              AND Aplica		= @AplicaAux
              AND AplicaID	> @AplicaIDAuxAnt
       
           IF @AplicaIDAux IS NULL BREAK
         
           SELECT @AplicaIDAuxAnt = @AplicaIDAux

           INSERT INTO #CorteDReporte(
				     ID,									Tipo,															Columna1,											Columna2,		
				     Columna3,								Columna4,														Columna5,											Columna6,	
				     Columna7,								Columna8,														Agrupador1,											Agrupador2,
				     Agrupador3)
              SELECT @ID,									'DET',															Mov,												MovID,			
				     Referencia,							dbo.fnFormatearFecha(Fecha, 'dd/MM/aaaa'),						dbo.fnFormatearFecha(Vencimiento, 'dd/MM/aaaa'),	dbo.fnMonetarioEnTexto(ISNULL(Cargo, 0)),
				     dbo.fnMonetarioEnTexto(ISNULL(Abono, 0)),dbo.fnMonetarioEnTexto(ISNULL(Cargo, 0.0) - ISNULL(Abono, 0.0)),@CuentaAux,											@AplicaAux,
				     @AplicaIDAux
                FROM CorteD
               WHERE ID			= @ID
                 AND Cuenta		= @CuentaAux
                 AND Moneda		= @MonedaAux
                 AND Aplica		= @AplicaAux
                 AND AplicaID	= @AplicaIDAux

           INSERT INTO #CorteDReporte(
				     ID,											Tipo,											Columna1,					
				     Columna2,										Columna3,										Columna4,																Agrupador1,											
				     Agrupador2,																						Agrupador3)
              SELECT @ID,											'SUBT',											'Saldo ' + ISNULL(@AplicaAux, '') + ' ' + ISNULL(@AplicaIDAux, ''),
				     dbo.fnMonetarioEnTexto(SUM(ISNULL(Cargo, 0))),	dbo.fnMonetarioEnTexto(SUM(ISNULL(Abono, 0))),	dbo.fnMonetarioEnTexto(SUM(ISNULL(Cargo, 0)) - SUM(ISNULL(Abono, 0))),	@CuentaAux,
				     @AplicaAux,									@AplicaIDAux
                FROM CorteD
               WHERE ID			= @ID
                 AND Cuenta		= @CuentaAux
                 AND Moneda		= @MonedaAux
                 AND Aplica		= @AplicaAux
                 AND AplicaID		= @AplicaIDAux
         END           
       END      

       INSERT INTO #CorteDReporte(
				 ID,											Tipo,											Columna1,					
				 Columna2,										Columna3,										Columna4,																Agrupador1,
				 Agrupador2,									Agrupador3)
          SELECT @ID,											'TOT',											'Total ' + ISNULL(@MonedaAux, ''),
				 dbo.fnMonetarioEnTexto(SUM(ISNULL(Cargo, 0))),	dbo.fnMonetarioEnTexto(SUM(ISNULL(Abono, 0))),	dbo.fnMonetarioEnTexto(SUM(ISNULL(Cargo, 0)) - SUM(ISNULL(Abono, 0))),	@CuentaAux,
				 @AplicaAux,				@AplicaIDAux
            FROM CorteD
           WHERE ID			= @ID
             AND Cuenta		= @CuentaAux
             AND Moneda		= @MonedaAux
     END        
  END
    
  RETURN
END
GO

/**************** spCorteDReporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDReporte') and type = 'P') drop procedure dbo.spCorteDReporte
GO
CREATE PROC spCorteDReporte
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),	
			@CorteFiltrarFechas	bit,		
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE @FechaA			datetime,
		  @CuentaAux		varchar(10),
		  @CuentaAuxAnt		varchar(10),
		  @MonedaAux		varchar(10),
		  @MonedaAuxAnt		varchar(10),
		  @AplicaAux		varchar(20),
		  @AplicaAuxAnt		varchar(20),
		  @AplicaIDAux		varchar(20),
	      @AplicaIDAuxAnt	varchar(20)    

  IF @MovTipo IN('CORTE.EDOCTACXC', 'CORTE.EDOCTACXP')
  BEGIN
    EXEC spCorteDReporteCx @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,	
               			   @Ok OUTPUT, @OkRef OUTPUT
  END
  ELSE IF @MovTipo IN('CORTE.INVVAL')
  BEGIN
    IF @CorteValuacion NOT IN('PEPS', 'UEPS')
      EXEC spCorteDReporteInvVal 
                             @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						     @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						     @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			     @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			     @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			     @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			     @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			     @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,	
               			     @Ok OUTPUT, @OkRef OUTPUT      
    ELSE IF @CorteValuacion IN('PEPS', 'UEPS')
      EXEC spCorteDReporteInvValOtraMoneda
                             @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						     @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						     @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			     @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			     @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			     @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			     @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			     @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,	
               			     @Ok OUTPUT, @OkRef OUTPUT                     			     
  END
  ELSE IF @MovTipo IN('CORTE.CORTEIMPORTE') AND ISNULL(@SubMovTipo, '') = ''
  BEGIN
    EXEC spCorteDReporteCorteImp @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
								 @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
								 @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   					 @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   					 @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   					 @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   					 @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   					 @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               					 @Ok OUTPUT, @OkRef OUTPUT    
  END
  ELSE IF @MovTipo IN('CORTE.CORTECONTABLE') AND ISNULL(@SubMovTipo, '') = ''
  BEGIN
    EXEC spCorteDReporteCorteCont @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
 								  @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
								  @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   					  @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   					  @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   					  @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   					  @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   					  @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               					  @Ok OUTPUT, @OkRef OUTPUT    
  END
  ELSE IF @MovTipo IN('CORTE.CORTEUNIDADES') AND ISNULL(@SubMovTipo, '') = ''
  BEGIN
    EXEC spCorteDReporteCorteUnidades @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
 								  @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
								  @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   					  @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   					  @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   					  @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   					  @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   					  @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               					  @Ok OUTPUT, @OkRef OUTPUT    
  END  
  ELSE IF @MovTipo IN('CORTE.CORTECX') AND ISNULL(@SubMovTipo, '') = ''
  BEGIN
    EXEC spCorteDReporteCorteCx @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
 								@Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
								@Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   					@CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   					@CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   					@CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   					@CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   					@Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               					@Ok OUTPUT, @OkRef OUTPUT    
  END  
  
  EXEC xpCorteDReporte @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
					   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
					   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   		   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   		   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   		   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   		   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   		   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,
               		   @Ok OUTPUT, @OkRef OUTPUT
  
  INSERT INTO CorteDReporte(
			ID,				Renglon,			RenglonSub,				Tipo,			Columna1,			Columna2,			Columna3, 
			Columna4,		Columna5,			Columna6,				Columna7,		Columna8,			Columna9,			Columna10, 
			Columna11,		Columna12,			Columna13,				Columna14,		Columna15,			Columna16,			Columna17, 
			Columna18,		Columna19,			Columna20,				Columna21,		Columna22,			Columna23,			Columna24, 
			Columna25,		Columna26,			Columna27,				Columna28,		Columna29,			Columna30,			Columna31, 
			Columna32,		Columna33,			Columna34,				Columna35,		Columna36,			Columna37,			Columna38, 
			Columna39,		Columna40,			Columna41,				Columna42,		Columna43,			Columna44,			Columna45, 
			Columna46,		Columna47,			Columna48,				Columna49,		Columna50,			Agrupador1,			Agrupador2,
			Agrupador3,		Agrupador4,			Agrupador5,				Agrupador6,		Agrupador7,			Agrupador8,			Agrupador9,
			Agrupador10)
	 SELECT ID,				RID * 2048,			0,						Tipo,			Columna1,			Columna2,			Columna3, 
			Columna4,		Columna5,			Columna6,				Columna7,		Columna8,			Columna9,			Columna10, 
			Columna11,		Columna12,			Columna13,				Columna14,		Columna15,			Columna16,			Columna17, 
			Columna18,		Columna19,			Columna20,				Columna21,		Columna22,			Columna23,			Columna24, 
			Columna25,		Columna26,			Columna27,				Columna28,		Columna29,			Columna30,			Columna31, 
			Columna32,		Columna33,			Columna34,				Columna35,		Columna36,			Columna37,			Columna38, 
			Columna39,		Columna40,			Columna41,				Columna42,		Columna43,			Columna44,			Columna45, 
			Columna46,		Columna47,			Columna48,				Columna49,		Columna50,			Agrupador1,			Agrupador2,
			Agrupador3,		Agrupador4,			Agrupador5,				Agrupador6,		Agrupador7,			Agrupador8,			Agrupador9,
			Agrupador10
	   FROM #CorteDReporte

  RETURN
END
GO

/**************** spCorteGenerarEstadoCuentaSimple ****************/					
if exists (select * from sysobjects where id = object_id('dbo.spCorteGenerarEstadoCuentaSimple') and type = 'P') drop procedure dbo.spCorteGenerarEstadoCuentaSimple
GO
CREATE PROCEDURE spCorteGenerarEstadoCuentaSimple
		    @Estacion			int,
		    @Empresa			char(5),
		    @Modulo				char(5),
		    @FechaD				datetime,
		    @CuentaD			char(10),
		    @CuentaA			char(10),
		    @Sucursal			int,
		    @EstatusEspecifico	char(15) = NULL,
		    @Moneda				varchar(10)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Ejercicio				int,
    @Periodo				int,
    @CuentaCursor			varchar(10),
    @MonedaCursor			varchar(10)    

  DECLARE @AgrupacionGrafica TABLE
  (
  Cuenta					varchar(10) COLLATE DATABASE_DEFAULT NULL,
  Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,  
  Ejercicio					int NULL,
  Periodo					int NULL
  )    

  DECLARE @GraficaTemporal TABLE
  (
  Estacion					int NULL,  
  Empresa					varchar(5) COLLATE DATABASE_DEFAULT NULL,
  Modulo					varchar(5)  COLLATE DATABASE_DEFAULT NULL,
  Moneda					varchar(10) COLLATE DATABASE_DEFAULT NULL,    
  Cuenta					varchar(10) COLLATE DATABASE_DEFAULT NULL,
  SaldoDescripcion			varchar(50) COLLATE DATABASE_DEFAULT NULL,
  SaldoImporte				float NULL
  )    
  
  EXEC spExtraerFecha @FechaD OUTPUT
  IF @CuentaD = '0' SELECT @CuentaD = NULL
  IF @CuentaD = '' SELECT @CuentaD = NULL
  IF @CuentaD IN ('', '(Todos)') SELECT @CuentaD = NULL
  
  IF @CuentaA = '0' SELECT @CuentaA = NULL
  IF @CuentaA = '' SELECT @CuentaA = NULL
  IF @CuentaA IN ('', '(Todos)') SELECT @CuentaA = NULL
    
  IF @Sucursal = -1 SELECT @Sucursal = NULL
  SELECT @EstatusEspecifico = NULLIF(RTRIM(@EstatusEspecifico), '')
  IF @EstatusEspecifico = '0' SELECT @EstatusEspecifico = NULL

  DELETE EstadoCuenta WHERE Estacion = @Estacion AND Modulo = @Modulo
  DELETE EstadoCuentaGrafica WHERE Estacion = @Estacion AND Modulo = @Modulo
  IF @Modulo = 'CXC' 
  BEGIN
     INSERT @AgrupacionGrafica (Cuenta,   Moneda,   Ejercicio,   Periodo)
                        SELECT  a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo
                          FROM Auxiliar a JOIN Cxc c
                            ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxc ca
                            ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                            ON mt.Mov = ca.Mov JOIN MovTipo mt2
                            ON mt2.Mov = c.Mov 
                         WHERE a.Modulo = 'CXC'
                           AND mt2.Modulo = 'CXC'
                           AND ISNULL(mt2.Interno,0) = 0
                           AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
                           AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                           AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                           AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                           AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
                           AND c.Moneda = ISNULL(@Moneda, c.Moneda)
--                           AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)
                           AND a.Empresa = @Empresa --BUG13609
                         GROUP BY a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo

     INSERT @AgrupacionGrafica (Cuenta,   Moneda,   Ejercicio,   Periodo)
                        SELECT  a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo
                          FROM Auxiliar a JOIN Dinero c
                            ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
                            ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                            ON mt.Mov = ca.Mov JOIN MovTipo mt2
                            ON mt2.Mov = c.Mov 
                         WHERE a.Modulo = 'DIN'
                           AND mt2.Modulo = 'DIN'
                           AND ISNULL(mt2.Interno,0) = 0
                           AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH')
                           AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                           AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                           AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                           AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
                           AND c.Moneda = ISNULL(@Moneda, c.Moneda)
--                           AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)
                           AND a.Empresa = @Empresa --BUG13609
                         GROUP BY a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo                         

    DECLARE crCuenta CURSOR FOR
     SELECT Cuenta
       FROM @AgrupacionGrafica
      GROUP BY Cuenta 

    OPEN crCuenta
    FETCH NEXT FROM crCuenta INTO @CuentaCursor
    WHILE @@FETCH_STATUS = 0
    BEGIN

      DECLARE crMoneda CURSOR FOR
       SELECT Moneda
         FROM @AgrupacionGrafica
        WHERE Cuenta = @CuentaCursor
        GROUP BY Moneda

      OPEN crMoneda
      FETCH NEXT FROM crMoneda INTO @MonedaCursor
      WHILE @@FETCH_STATUS = 0
      BEGIN
        DECLARE crAuxiliar CURSOR FOR
         SELECT TOP 4 Ejercicio, Periodo
           FROM @AgrupacionGrafica
          WHERE Cuenta = @CuentaCursor
            AND Moneda = @MonedaCursor 
          GROUP BY Ejercicio, Periodo 
          ORDER BY Ejercicio DESC, Periodo DESC

        OPEN crAuxiliar
        FETCH NEXT FROM crAuxiliar INTO @Ejercicio, @Periodo
        WHILE @@FETCH_STATUS = 0
        BEGIN
          INSERT @GraficaTemporal (Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion,                                                                                             SaldoImporte)
                           SELECT  @Empresa, @Estacion, @Modulo, a.Moneda, a.Cuenta, CONVERT(varchar,@Ejercicio) + '-' + CASE WHEN @Periodo < 10 THEN '0' ELSE '' END + CONVERT(varchar,@Periodo), ISNULL(SUM(dbo.fnImporteAMonedaContable(ISNULL(a.Cargo,0.0)-ISNULL(a.Abono,0.0),c.TipoCambio,ec.ContMoneda)),0.0)
                             FROM Auxiliar a JOIN Cxc c
                               ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxc ca
                               ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                               ON mt.Mov = ca.Mov JOIN MovTipo mt2
                               ON mt2.Mov = c.Mov JOIN EmpresaCFG ec
                               ON ec.Empresa = a.Empresa 
                            WHERE a.Modulo = 'CXC'
                              AND mt2.Modulo = 'CXC'
                              AND ISNULL(mt2.Interno,0) = 0
                              AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
                              AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                              AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                              AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                              AND (a.Ejercicio < @Ejercicio OR (a.Ejercicio = @Ejercicio AND a.Periodo <= @Periodo))                   
                              AND a.Cuenta = @CuentaCursor
                              AND a.Moneda = @MonedaCursor
                              AND a.Empresa = @Empresa --BUG13609                          
                       GROUP BY a.Cuenta, a.Moneda

          INSERT @GraficaTemporal (Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion,                                                                                             SaldoImporte)
                           SELECT  @Empresa, @Estacion, @Modulo, a.Moneda, a.Cuenta, CONVERT(varchar,@Ejercicio) + '-' + CASE WHEN @Periodo < 10 THEN '0' ELSE '' END + CONVERT(varchar,@Periodo), ISNULL(SUM(dbo.fnImporteAMonedaContable(ISNULL(a.Cargo,0.0)-ISNULL(a.Abono,0.0),c.TipoCambio,ec.ContMoneda)),0.0)
                             FROM Auxiliar a JOIN Dinero c
                               ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
                               ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                               ON mt.Mov = ca.Mov JOIN MovTipo mt2
                               ON mt2.Mov = c.Mov JOIN EmpresaCFG ec
                               ON ec.Empresa = a.Empresa 
                            WHERE a.Modulo = 'DIN'
                              AND mt2.Modulo = 'DIN'
                              AND ISNULL(mt2.Interno,0) = 0
                              AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
                              AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                              AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                              AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                              AND (a.Ejercicio < @Ejercicio OR (a.Ejercicio = @Ejercicio AND a.Periodo <= @Periodo))                   
                              AND a.Cuenta = @CuentaCursor
                              AND a.Moneda = @MonedaCursor  
                              AND a.Empresa = @Empresa --BUG13609                        
                       GROUP BY a.Cuenta, a.Moneda                       
                       
          FETCH NEXT FROM crAuxiliar INTO @Ejercicio, @Periodo
        END
        CLOSE crAuxiliar
        DEALLOCATE crAuxiliar

        FETCH NEXT FROM crMoneda INTO @MonedaCursor
      END
      CLOSE crMoneda
      DEALLOCATE crMoneda

      FETCH NEXT FROM crCuenta INTO @CuentaCursor
    END
    CLOSE crCuenta
    DEALLOCATE crCuenta
 
    DELETE FROM EstadoCuentaGrafica WHERE Estacion = @Estacion AND Modulo = @Modulo
    
    INSERT EstadoCuentaGrafica (Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion, SaldoImporte, Grafica)
                        SELECT  Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion, SaldoImporte, 1 
                          FROM  @GraficaTemporal 
                         ORDER  BY Cuenta, SaldoDescripcion
                                      
    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia
                   FROM Auxiliar a JOIN Cxc c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxc ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'CXC'
                    AND mt2.Modulo = 'CXC'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('CXC.A', 'CXC.AR', 'CXC.F', 'CXC.FAC', 'CXC.FA', 'CXC.D', 'CXC.DM', 'CXC.DA', 'CXC.DP', 'CXC.NC', 'CXC.DAC', 'CXC.NCD','CXC.NCF', 'CXC.DV', 'CXC.NCP', 'CXC.CA', 'CXC.CAD', 'CXC.CAP','CXC.CD', 'CXC.RM', 'CXC.IM', 'CXC.SD', 'CXC.SCH') 
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia
                   FROM Auxiliar a JOIN Dinero c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'DIN'
                    AND mt2.Modulo = 'DIN'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID                  
  END ELSE
  IF @Modulo = 'CXP'
  BEGIN
     INSERT @AgrupacionGrafica (Cuenta,   Moneda,   Ejercicio,   Periodo)
                        SELECT  a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo
                          FROM Auxiliar a JOIN Cxp c
                            ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxp ca
                            ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                            ON mt.Mov = ca.Mov JOIN MovTipo mt2
                            ON mt2.Mov = c.Mov 
                         WHERE a.Modulo = 'CXP'
                           AND mt2.Modulo = 'CXP'
                           AND ISNULL(mt2.Interno,0) = 0
                           AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH')          
                           AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                           AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                           AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                           AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
                           AND c.Moneda = ISNULL(@Moneda, c.Moneda)
--                           AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                           
                          AND a.Empresa = @Empresa --BUG13609
                         GROUP BY a.Cuenta, a.Moneda, a.Ejercicio, a.Periodo

    DECLARE crCuenta CURSOR FOR
     SELECT Cuenta
       FROM @AgrupacionGrafica
      GROUP BY Cuenta 

    OPEN crCuenta
    FETCH NEXT FROM crCuenta INTO @CuentaCursor
    WHILE @@FETCH_STATUS = 0
    BEGIN

      DECLARE crMoneda CURSOR FOR
       SELECT Moneda
         FROM @AgrupacionGrafica
        WHERE Cuenta = @CuentaCursor
        GROUP BY Moneda

      OPEN crMoneda
      FETCH NEXT FROM crMoneda INTO @MonedaCursor
      WHILE @@FETCH_STATUS = 0
      BEGIN
        DECLARE crAuxiliar CURSOR FOR
         SELECT TOP 4 Ejercicio, Periodo
           FROM @AgrupacionGrafica
          WHERE Cuenta = @CuentaCursor
            AND Moneda = @MonedaCursor 
          GROUP BY Ejercicio, Periodo 
          ORDER BY Ejercicio DESC, Periodo DESC

        OPEN crAuxiliar
        FETCH NEXT FROM crAuxiliar INTO @Ejercicio, @Periodo
        WHILE @@FETCH_STATUS = 0
        BEGIN
        
          INSERT @GraficaTemporal (Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion,                                                                                             SaldoImporte)
                           SELECT  @Empresa, @Estacion, @Modulo, a.Moneda, a.Cuenta, CONVERT(varchar,@Ejercicio) + '-' + CASE WHEN @Periodo < 10 THEN '0' ELSE '' END + CONVERT(varchar,@Periodo), ISNULL(SUM(dbo.fnImporteAMonedaContable(ISNULL(a.Cargo,0.0)-ISNULL(a.Abono,0.0),c.TipoCambio,ec.ContMoneda)),0.0)
                             FROM Auxiliar a JOIN Cxp c
                               ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxp ca
                               ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                               ON mt.Mov = ca.Mov JOIN MovTipo mt2
                               ON mt2.Mov = c.Mov JOIN EmpresaCfg ec
                               ON ec.Empresa = a.Empresa
                            WHERE a.Modulo = 'CXP'
                              AND mt2.Modulo = 'CXP'
                              AND ISNULL(mt2.Interno,0) = 0
                              AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH')          
                              AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                              AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                              AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                              AND (a.Ejercicio < @Ejercicio OR (a.Ejercicio = @Ejercicio AND a.Periodo <= @Periodo))                   
                              AND a.Cuenta = @CuentaCursor
                              AND a.Moneda = @MonedaCursor                          
                              AND a.Empresa = @Empresa --BUG13609                              
                            GROUP BY a.Cuenta, a.Moneda
          
          FETCH NEXT FROM crAuxiliar INTO @Ejercicio, @Periodo
        END
        CLOSE crAuxiliar
        DEALLOCATE crAuxiliar

        FETCH NEXT FROM crMoneda INTO @MonedaCursor
      END
      CLOSE crMoneda
      DEALLOCATE crMoneda

      FETCH NEXT FROM crCuenta INTO @CuentaCursor
    END
    CLOSE crCuenta
    DEALLOCATE crCuenta

    DELETE FROM EstadoCuentaGrafica WHERE Estacion = @Estacion AND Modulo = @Modulo
    
    INSERT EstadoCuentaGrafica (Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion, SaldoImporte, Grafica)
                        SELECT  Empresa,  Estacion,  Modulo,  Moneda,   Cuenta,   SaldoDescripcion, SaldoImporte, 1 
                          FROM  @GraficaTemporal 
                         ORDER  BY Cuenta, SaldoDescripcion

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia    
                   FROM Auxiliar a JOIN Cxp c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Cxp ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'CXP'
                    AND mt2.Modulo = 'CXP'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('CXP.A', 'CXP.F', 'CXP.D', 'CXP.DM', 'CXP.PAG', 'CXP.DA', 'CXP.DP', 'CXP.NC', 'CXP.DAC', 'CXP.NCD','CXP.NCF', 'CXP.NCP', 'CXP.CA', 'CXP.CAD', 'CXP.CAP','CXP.CD', 'CXP.FAC', 'CXP.SD', 'CXP.SCH')          
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID

    INSERT EstadoCuenta (Empresa,  Estacion,  Modulo,  Cuenta,   Moneda,   AuxiliarID, ModuloID,   Vencimiento,   Referencia) 
                 SELECT  @Empresa, @Estacion, @Modulo, a.Cuenta, a.Moneda, a.ID,       a.ModuloID, c.Vencimiento, c.Referencia
                   FROM Auxiliar a JOIN Dinero c
                     ON c.Empresa = a.Empresa AND c.ID = a.ModuloID JOIN Dinero ca
                     ON ca.Empresa = c.Empresa AND ca.Mov = a.Aplica AND ca.MovID = a.AplicaID JOIN MovTipo mt
                     ON mt.Mov = ca.Mov JOIN MovTipo mt2
                     ON mt2.Mov = c.Mov 
                  WHERE a.Modulo = 'DIN'
                    AND mt2.Modulo = 'DIN'
                    AND ISNULL(mt2.Interno,0) = 0
                    AND mt.Clave IN ('DIN.SD','DIN.D','DIN.CH','DIN.SCH') 
                    AND c.Estatus NOT IN ('SINAFECTAR','CANCELADO')
                    AND (ca.Estatus = 'PENDIENTE' OR (ca.Estatus = 'CONCLUIDO' AND ca.FechaConclusion >= @FechaD))
                    AND ca.Estatus = CASE WHEN @EstatusEspecifico IS NULL THEN ca.Estatus ELSE @EstatusEspecifico END
                    AND a.Cuenta BETWEEN ISNULL(@CuentaD, a.Cuenta) AND ISNULL(@CuentaA, a.Cuenta)
--                    AND a.Sucursal = ISNULL(@Sucursal, a.Sucursal)                    
                    AND a.Empresa = @Empresa --BUG13609
                  ORDER BY a.Moneda, a.Cuenta, a.Aplica, a.AplicaID, a.ID                    
   END
END
GO

/****************************** spCorteInvValOtraMoneda *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteInvValOtraMoneda') and type = 'P') drop procedure dbo.spCorteInvValOtraMoneda
GO
CREATE PROC spCorteInvValOtraMoneda
		@EstacionTrabajo		int,
		@ModuloCorte			bit			= 0,
		@ModuloID				int			= 0,
		@Ok                		int         = NULL OUTPUT,
    	@OkRef             		varchar(255)= NULL OUTPUT		
    	
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @ArticuloD			varchar	(20),
    @ArticuloA			varchar	(20),
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@FechaA				datetime,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Falso				bit,
	@Sucursal			int,
	@Sistema			char(1),
	@ContMoneda			varchar(10),
	@SubCuenta			varchar	(20),
	@VerGraficaDetalle	bit

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  SELECT @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaA			=	InfoFechaA,
	@ArticuloD		=	CASE WHEN NULLIF(InfoArticuloD, '') IS NULL THEN (SELECT MIN(Articulo) FROM Art) ELSE NULLIF(InfoArticuloD, '') END,
	@ArticuloA		=	CASE WHEN NULLIF(InfoArticuloA, '') IS NULL THEN (SELECT MAX(Articulo) FROM Art) ELSE NULLIF(InfoArticuloA, '') END,
	@Titulo			=	RepTitulo,
	@GraficarTipo	=	ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		=	ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
	@Sucursal		=	CASE WHEN InfoSucursal IN(NULL, '') THEN NULL ELSE InfoSucursal END,
	@Sistema		=	CASE WHEN InfoInvValOtraMoneda = 'UEPS' THEN 'U' ELSE 'P' END,
	@VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa
  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @EstacionTrabajo

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion

      
  DECLARE @InvValOtraMoneda TABLE
  (
	Empresa						char(5)		COLLATE Database_Default NULL,
	Sucursal					int			NULL,
	Articulo					varchar(20)	COLLATE Database_Default NULL,
	Descripcion					varchar(100)COLLATE Database_Default NULL,
	SubCuenta					varchar(20)	COLLATE Database_Default NULL,
	Existencia					float		NULL,
	CostoUnitario				money		NULL,
	CostoUnitarioOtraMoneda		money		NULL,
	OtraMoneda					varchar(10)	COLLATE Database_Default NULL,
	EmpresaSucursal				varchar(100)COLLATE DATABASE_DEFAULT NULL,

    FechaA						datetime	NULL,

	GraficaArgumento			varchar(100)COLLATE DATABASE_DEFAULT NULL,   
    GraficaValor				float		NULL,
    Grafica1					int			NULL DEFAULT 0,
    Titulo						varchar(100)NULL,
    Reporte						varchar(200)NULL,
    Direccion2					varchar(100)NULL,
    Direccion3					varchar(100)NULL,
    Direccion4					varchar(100)NULL,
    GraficaSerie				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    ArticuloDesde				varchar(20)	COLLATE Database_Default NULL,
    ArticuloHasta				varchar(20)	COLLATE Database_Default NULL,
    MonedaContable				varchar(10) COLLATE DATABASE_DEFAULT NULL,
	Valuacion					varchar(10) COLLATE DATABASE_DEFAULT NULL

  )

  INSERT INTO @InvValOtraMoneda
  SELECT 
      ic.Empresa, 
      ic.Sucursal,  
      ic.Articulo,
      a.Descripcion1,
      ic.SubCuenta,
      SUM(ISNULL(ica.CargoU,0.0) - ISNULL(ica.AbonoU,0.0)) Existencia,      
      ic.Costo CostoUnitario,
      ic.Costo * ISNULL(ic.OtraMonedaTipoCambio, 1) CostoUnitarioOtraMoneda,
      ISNULL(ic.OtraMoneda, @ContMoneda),
      s.Nombre,
      @FechaA, NULL, NULL, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, @ArticuloD, @ArticuloA, @ContMoneda, CASE WHEN @Sistema = 'U' THEN 'UEPS' ELSE 'PEPS' END
    FROM InvCapa ic JOIN InvCapaAux ica
      ON ic.ID = ica.ID JOIN Art a
      ON ic.Articulo = a.Articulo JOIN Sucursal s
      ON ic.Sucursal = s.Sucursal
   WHERE ic.Empresa = @Empresa
     AND ic.Articulo BETWEEN @ArticuloD AND @ArticuloA
     AND ic.SubCuenta = ISNULL(@SubCuenta, ic.SubCuenta)
     AND ic.Sucursal = ISNULL(@Sucursal, ic.Sucursal)
     AND ica.Fecha <= @FechaA
     AND ic.Sistema = @Sistema
     AND ic.Activa = 1
   GROUP BY ic.Empresa, ic.Sucursal, ic.Articulo, ic.SubCuenta, ic.Costo, a.Descripcion1, ic.OtraMonedaTipoCambio, ic.OtraMoneda, s.Nombre

  INSERT INTO @InvValOtraMoneda
        (GraficaArgumento, GraficaSerie,            GraficaValor,                         Grafica1)
  SELECT Articulo,         CostoUnitarioOtraMoneda, Existencia * CostoUnitarioOtraMoneda, 1
    FROM @InvValOtraMoneda
  
  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @InvValOtraMoneda
   WHERE Grafica1 = 1
--select @GraficarTipo, @GraficarCantidad, @Graficar
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvValOtraMoneda
     WHERE GraficaArgumento NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaArgumento
      FROM
      (
      SELECT
          'GraficaArgumento'   = GraficaArgumento,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvValOtraMoneda
       WHERE Grafica1 = 1
        GROUP BY GraficaArgumento
      ) AS x
     GROUP BY x.GraficaArgumento
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvValOtraMoneda
     WHERE GraficaArgumento NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaArgumento
      FROM
      (
      SELECT
          'GraficaArgumento'   = GraficaArgumento,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvValOtraMoneda
       WHERE Grafica1 = 1
        GROUP BY GraficaArgumento
      ) AS x
     GROUP BY x.GraficaArgumento
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1

  IF ISNULL(@ModuloCorte, 0) = 0
    SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @InvValOtraMoneda
  ELSE
  BEGIN
    INSERT INTO #CorteD(
			Sucursal,					Cuenta,					SubCuenta,			SaldoU,				CostoUnitario,		
			CostoUnitarioOtraMoneda,	Moneda,					Fecha,				MonedaContable,		ValuacionNombre,
			ID)
	 SELECT Sucursal,					Articulo,				SubCuenta,			Existencia,			CostoUnitario,		
			CostoUnitarioOtraMoneda,	OtraMoneda,				FechaA,				MonedaContable,		Valuacion,
			@ModuloID
       FROM @InvValOtraMoneda		
	  WHERE ISNULL(Grafica1, 0) = 0       	
    
    INSERT INTO #ContactoDireccion(
			Contacto,				Direccion2,				Direccion3,				Direccion4)
	 SELECT @Empresa,				@Direccion2,			@Direccion3,			@Direccion4 
  END    
END
GO

/******************************* spCorteInvVal *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteInvVal') and type = 'P') drop procedure dbo.spCorteInvVal
GO             
CREATE PROCEDURE spCorteInvVal
		@EstacionTrabajo		int,
		@ModuloCorte			bit		= 0,
		@ModuloID				int		= 0,
		@Ok                		int         = NULL OUTPUT,
    	@OkRef             		varchar(255)= NULL OUTPUT		

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  	@Empresa			varchar	(5),
    @Articulo			varchar	(20),
    @ArticuloD			varchar	(20),
    @ArticuloA			varchar	(20),
    @Almacen			varchar	(20),
    @Valuacion			varchar	(50),
    @Nombre				varchar	(100),
    @Contador			int,
    @Orden				int,
	@EmpresaNombre		varchar	(100),
	@Titulo				varchar	(100),
	@Reporte			varchar	(200),
	@Direccion2			varchar	(100),
	@Direccion3			varchar	(100),
	@Direccion4			varchar	(100),
	@Desglosar			varchar	(50),
	@FechaD				datetime,
	@FechaA				datetime,
	@ContMoneda			varchar	(30),
	@Venta				float,
	@Costo				float,
	@Utilidad			float,
	@Graficar			int,
	@GraficarFecha		int,
	@GraficarTipo		varchar(30),
	@Etiqueta			bit,
	@GraficarCantidad	int,
	@Verdadero			bit,
	@Falso				bit,
	@VerGraficaDetalle	bit

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )
  
  SELECT @Verdadero = 1, @Falso = 0
  SELECT
    @Empresa		=	InfoEmpresa,
	@FechaA			=	InfoFechaA,
	@ArticuloD		=	InfoArticuloD,
	@ArticuloA		=	InfoArticuloA,
	@Almacen		=	CASE WHEN InfoAlmacen IN('', '(Todos)', '(Todas)') THEN NULL ELSE InfoAlmacen END,
	@Valuacion		=	ISNULL(InfoInvVal, '(Sin Valuar)'),
	@Desglosar		=	InfoDesglosar,
	@Titulo			=	RepTitulo,
	@GraficarTipo	= ISNULL(InformeGraficarTipo,  '(Todos)'),
	@Etiqueta		= ISNULL(InfoEtiqueta, @Falso),
	@GraficarCantidad = ISNULL(InformeGraficarCantidad, 5),
	@VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo

  SELECT @ContMoneda = ContMoneda FROM EmpresaCfg WHERE Empresa = @Empresa
  
  SELECT @EmpresaNombre = Nombre FROM Empresa WHERE Empresa = @Empresa

  -- Se reemplaza el uso de la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Empresa', @Empresa, @Empresa, 1,1,1,1
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @EstacionTrabajo

  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM @ContactoDireccion
    
/*  
  SELECT @Direccion2 = Direccion2,
         @Direccion3 = Direccion3,
         @Direccion4 = Direccion4 
    FROM dbo.fnContactoDireccionHorizontal('Empresa', @Empresa, 1, 1, 1, 1)
*/

--  SELECT @Reporte = 'Del Articulo  ' + @ArticuloD + '  Al Articulo  ' + @ArticuloA + '  En ' + ISNULL(@ContMoneda,'')  
  
  DECLARE @VerInvVal TABLE
  (
    ID					int			NULL,

	Articulo			char(20)	COLLATE Database_Default NULL,
	Descripcion			varchar(100)COLLATE Database_Default NULL,
	PrecioLista			money		NULL,
	Precio2				money		NULL,
	Precio3				money		NULL,
	Precio4				money		NULL,
	Precio5				money		NULL,
	Precio6				money		NULL,
	Precio7				money		NULL,
	Precio8				money		NULL,
	Precio9				money		NULL,
	Precio10			money		NULL,
	CostoEstandar		money		NULL,
	CostoReposicion		money		NULL,
	CostoPromedio		money		NULL,
	UltimoCosto			money		NULL,
	Moneda				char(10)	COLLATE Database_Default NULL,
	Almacen				char(10)	COLLATE Database_Default NULL,
	Nombre2				varchar(100)COLLATE Database_Default NULL,
	Existencias			float		NULL
  )

  DECLARE @InvVal TABLE
  (
    ID					int			NULL,

	Articulo			char(20)	COLLATE Database_Default NULL,
	Descripcion			varchar(100)COLLATE Database_Default NULL,
	PrecioLista			money		NULL,
	Precio2				money		NULL,
	Precio3				money		NULL,
	Precio4				money		NULL,
	Precio5				money		NULL,
	Precio6				money		NULL,
	Precio7				money		NULL,
	Precio8				money		NULL,
	Precio9				money		NULL,
	Precio10			money		NULL,
	CostoEstandar		money		NULL,
	CostoReposicion		money		NULL,
	CostoPromedio		money		NULL,
	UltimoCosto			money		NULL,
	Moneda				char(10)	COLLATE Database_Default NULL,
	Almacen				char(10)	COLLATE Database_Default NULL,
	Nombre2				varchar(100)COLLATE Database_Default NULL,
	Existencias			float		NULL,

	Desglosar			varchar(5)	NULL,
	Desglosar2			varchar(5)	NULL,
    FechaD				datetime	NULL,
    FechaA				datetime	NULL,
    Orden1				int			NULL,
     

	GraficaArgumento	varchar(100) COLLATE DATABASE_DEFAULT NULL,   
    GraficaValor		float		NULL,
    Grafica1			int			NULL DEFAULT 0,
    Grafica2			int			NULL DEFAULT 0,
    Titulo				varchar(100)NULL,
    Reporte				varchar(200)NULL,
    Direccion2			varchar(100)NULL,
    Direccion3			varchar(100)NULL,
    Direccion4			varchar(100)NULL,
    GraficaSerie		varchar(100) COLLATE DATABASE_DEFAULT NULL,
    EmpresaNombre		varchar(100) COLLATE DATABASE_DEFAULT NULL,
    Nombre				varchar(100)COLLATE DATABASE_DEFAULT NULL,
    ValuacionNombre		varchar(100)COLLATE DATABASE_DEFAULT NULL,
    ValuacionValor		float		NULL,

	ValuacionValorArtConCosto		float		NULL
	        
  )

--select @Articulo = NULL
--  SELECT @Empresa, @FechaD, @FechaA, @Articulo, @Desglosar
-- select 'ACAB.EXT.INM.01', 'VTA. INMUEBLES', 'NULL', 'Costo Promedio', '31/03/2011', 'E-007'
 --SELECT @ArticuloD, @ArticuloA, @Almacen, @Valuacion, @FechaA, @Empresa
  INSERT INTO @VerInvVal
    EXEC spInvVal @ArticuloD, @ArticuloA, @Almacen, @Valuacion, @FechaA, @Empresa
  
  INSERT INTO @InvVal
  SELECT *, @Desglosar, @Desglosar, @FechaD, @FechaA, NULL, NULL, NULL, 0, 0, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, NULL, @EmpresaNombre, @Nombre, @Valuacion,  
    CASE @Valuacion WHEN 'Costo Promedio'	THEN ISNULL(CostoPromedio,0.00)
				    WHEN 'Ultimo Costo'		THEN ISNULL(UltimoCosto,0.00)
				    WHEN 'Costo Estandar'	THEN ISNULL(CostoEstandar,0.00)
				    WHEN 'Costo Reposicion' THEN ISNULL(CostoReposicion,0.00)
				    WHEN 'Precio Lista'		THEN ISNULL(PrecioLista,0.00)
				    WHEN 'Precio 2'			THEN ISNULL(Precio2,0.00)
				    WHEN 'Precio 3'			THEN ISNULL(Precio3,0.00)
				    WHEN 'Precio 4'			THEN ISNULL(Precio4,0.00)
				    WHEN 'Precio 5'			THEN ISNULL(Precio5,0.00)
				    WHEN 'Precio 6'			THEN ISNULL(Precio6,0.00)
				    WHEN 'Precio 7'			THEN ISNULL(Precio7,0.00)
				    WHEN 'Precio 8'			THEN ISNULL(Precio8,0.00)
				    WHEN 'Precio 9'			THEN ISNULL(Precio9,0.00)
				    WHEN 'Precio 10'		THEN ISNULL(Precio10,0.00)
				    ELSE 0.00				END, NULL

    FROM @VerInvVal


  SELECT @Contador = 0
  DECLARE crOrden CURSOR FAST_FORWARD FOR
   SELECT Articulo
     FROM @InvVal
    ORDER BY Articulo

  OPEN crOrden
  FETCH NEXT FROM crOrden INTO @Articulo
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
  
    IF EXISTS(SELECT * FROM @InvVal WHERE Articulo = @Articulo AND Orden1 IS NULL) 
    BEGIN
      SELECT @Nombre = Descripcion1 FROM Art WHERE articulo = @Articulo
      SELECT @Contador = @Contador + 1
      UPDATE @InvVal SET Orden1 = @Contador, Nombre = @Nombre WHERE Articulo = @Articulo     
    END

    UPDATE @InvVal 
       SET ValuacionValorArtConCosto =	CASE @Valuacion	WHEN 'Costo Promedio'	THEN (SELECT CostoPromedio	 FROM ArtConCosto WHERE Articulo = @Articulo AND Empresa = @Empresa)
														WHEN 'Ultimo Costo'		THEN (SELECT UltimoCosto	 FROM ArtConCosto WHERE Articulo = @Articulo AND Empresa = @Empresa)
														WHEN 'Costo Estandar'	THEN (SELECT CostoEstandar	 FROM ArtConCosto WHERE Articulo = @Articulo AND Empresa = @Empresa)
														WHEN 'Costo Reposicion' THEN (SELECT CostoReposicion FROM ArtConCosto WHERE Articulo = @Articulo AND Empresa = @Empresa)
										ELSE ValuacionValor				
										END
     WHERE Articulo = @Articulo
     
    FETCH NEXT FROM crOrden INTO @Articulo
  END
  CLOSE crOrden
  DEALLOCATE crOrden


  SELECT @Costo  = 0.00
  DECLARE crGrafica CURSOR FAST_FORWARD FOR
   SELECT Articulo, Orden1, SUM(ISNULL(CostoPromedio,0.00)), Nombre
     FROM @InvVal 
    GROUP BY Articulo, Nombre, Orden1
    ORDER BY Orden1, Articulo

  OPEN crGrafica
  FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @Costo, @Nombre
  WHILE @@FETCH_STATUS = 0-- AND @Ok IS NULL
  BEGIN
    
--    INSERT INTO @InvVal(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
--      SELECT 'Utilidad', @Utilidad, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

--    INSERT INTO @InvVal(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA)
--      SELECT 'Importe Venta', @Venta, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA

    INSERT INTO @InvVal(GraficaArgumento, GraficaValor, Grafica1, Grafica2, Orden1, GraficaSerie, Titulo, Reporte, Direccion2, Direccion3, Direccion4, EmpresaNombre, Desglosar, Desglosar2, FechaD, FechaA, ValuacionNombre, ValuacionValor)
      SELECT @Valuacion, @Costo, 1, 0, 0, @Nombre, @Titulo, @Reporte, @Direccion2, @Direccion3, @Direccion4, @EmpresaNombre, '', @Desglosar, @FechaD, @FechaA, @Valuacion, 0.00
    
    FETCH NEXT FROM crGrafica INTO @Articulo, @Orden, @Costo, @Nombre
  END
  
  CLOSE crGrafica
  DEALLOCATE crGrafica
  

  SELECT @Graficar = NULL
  SELECT @Graficar = ISNULL(COUNT(DISTINCT GraficaSerie),0)
    FROM @InvVal
   WHERE Grafica1 = 1
       
  IF @GraficarTipo = 'Mas Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvVal 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvVal
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))DESC)
       AND Grafica1 = 1

  IF @GraficarTipo = 'Menos Sobresalientes' AND @Graficar > @GraficarCantidad
    DELETE @InvVal 
     WHERE GraficaSerie NOT IN(
    SELECT  TOP (@GraficarCantidad) GraficaSerie
      FROM
      (
      SELECT
          'GraficaSerie'   = GraficaSerie,
          'GraficaValor'   = SUM(ISNULL(GraficaValor,0.00))
     
        FROM @InvVal
       WHERE Grafica1 = 1
        GROUP BY GraficaSerie
      ) AS x
     GROUP BY x.GraficaSerie
     ORDER BY SUM(ISNULL(x.GraficaValor,0.00))ASC)
       AND Grafica1 = 1

  IF ISNULL(@ModuloCorte, 0) = 0
    SELECT *, @Etiqueta as Etiqueta, @VerGraficaDetalle as VerGraficaDetalle FROM @InvVal
  ELSE
  BEGIN
    INSERT INTO #CorteD(
			Cuenta,						PrecioLista,			Precio2,			Precio3,			Precio4,			Precio5,			Precio6, 
			Precio7,					Precio8,				Precio9,			Precio10,			CostoEstandar,		CostoReposicion,	CostoPromedio, 
			UltimoCosto,				Moneda,					Grupo,				SaldoU,				Fecha,				ValuacionNombre,	ValuacionValor, 
			ValuacionValorArtConCosto,	ID)
	 SELECT Articulo,					PrecioLista,			Precio2,			Precio3,			Precio4,			Precio5,			Precio6, 
			Precio7,					Precio8,				Precio9,			Precio10,			CostoEstandar,		CostoReposicion,	CostoPromedio, 
			UltimoCosto,				Moneda,					Almacen,			Existencias,		FechaA,				ValuacionNombre,	ValuacionValor, 
			ValuacionValorArtConCosto,	@ModuloID
	   FROM @InvVal
	  WHERE ISNULL(Orden1, 0) <> 0
	  
    INSERT INTO #ContactoDireccion(
			Contacto,				Direccion2,				Direccion3,				Direccion4)
	 SELECT @Empresa,				@Direccion2,			@Direccion3,			@Direccion4
  END
END
GO

/******************************* spCorteCxpEstadoCuentaSimple *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCxpEstadoCuentaSimple') and type = 'P') drop procedure dbo.spCorteCxpEstadoCuentaSimple
GO        
CREATE PROCEDURE spCorteCxpEstadoCuentaSimple
		@EstacionTrabajo		int,
		@ModuloCorte			bit		= 0,
		@ModuloID				int		= 0,
		@Ok                		int         = NULL OUTPUT,
    	@OkRef             		varchar(255)= NULL OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa				varchar(5),
    @Modulo					varchar(5),
    @FechaD					datetime,
    @CuentaD				varchar(10),
    @CuentaA				varchar(10),
    @Titulo					varchar(100),
    @Sucursal				int,
    @Moneda					varchar(10),
    @EstatusEspecifico		varchar(15),
    @Etiqueta				bit,
    @GraficarTipo			varchar(30),
    @Contacto				varchar(10),
	@VerGraficaDetalle		bit

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )
      
  SELECT
    @Empresa           = InfoEmpresa,
    @Modulo            = InfoModulo,
    @FechaD            = InfoFechaD,
    @CuentaD           = NULLIF(InfoProveedorD,''),
    @CuentaA           = NULLIF(InfoProveedorA,''),    
    @Sucursal          = ISNULL(InfoSucursal,-1),
    @EstatusEspecifico = CASE 
			               WHEN InfoEstatusEspecifico = 'Pendientes' THEN 'PENDIENTE'
                           WHEN InfoEstatusEspecifico = 'Concluidos' THEN 'CONCLUIDO'
                           WHEN InfoEstatusEspecifico = '(Todos)'	THEN NULL
                           WHEN InfoEstatusEspecifico = 'PENDIENTE'	THEN InfoEstatusEspecifico
                           WHEN InfoEstatusEspecifico = 'CONCLUIDO'	THEN InfoEstatusEspecifico
                         END,
                         
    @Moneda            = CASE WHEN InfoMoneda = '(Todas)' THEN NULL WHEN RTRIM(InfoMoneda) = '' THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   = ISNULL(InfoEtiqueta,0),
    @GraficarTipo	   = ISNULL(InformeGraficarTipo,  '(Todos)'),
    @Titulo			   = ISNULL(InfoTitulo,  ''),
	@VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  EXEC spCorteGenerarEstadoCuentaSimple @EstacionTrabajo, @Empresa, @Modulo, @FechaD, @CuentaD, @CuentaA, @Sucursal, @EstatusEspecifico, @Moneda

  -- Se reemplaza el uso del cursor y la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Proveedor', @CuentaD, @CuentaA, 1,1,1,0  
  
  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @EstacionTrabajo
  
  /*  
  DECLARE crContactoDireccion CURSOR FAST_FORWARD FOR
   SELECT DISTINCT Prov.Proveedor
     FROM EstadoCuenta
     JOIN Prov ON EstadoCuenta.Cuenta = Prov.Proveedor
    WHERE EstadoCuenta.Estacion = @EstacionTrabajo
      AND EstadoCuenta.Modulo = @Modulo

  OPEN crContactoDireccion
  FETCH NEXT FROM crContactoDireccion INTO @Contacto
  WHILE @@FETCH_STATUS = 0
  BEGIN

    INSERT @ContactoDireccion(Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT					   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8 
      FROM dbo.fnContactoDireccionHorizontal('Proveedor',@Contacto,1,1,1,0)
            
    FETCH NEXT FROM crContactoDireccion INTO @Contacto
  END
  CLOSE crContactoDireccion
  DEALLOCATE crContactoDireccion
  */
  
  SELECT Empresa.Nombre EmpresaNombre,					EstadoCuenta.ID,							EstadoCuenta.Estacion,					EstadoCuenta.AuxiliarID,
		 EstadoCuenta.ModuloID,							RTRIM(LTRIM(EstadoCuenta.Modulo)) Modulo,	EstadoCuenta.Cuenta,					EstadoCuenta.Moneda,
		 EstadoCuenta.Efectivo,							EstadoCuenta.Consumos,						EstadoCuenta.Vales,						EstadoCuenta.Redondeo,
		 EstadoCuenta.ClienteEnviarA,					EstadoCuenta.Grafica,						EstadoCuenta.SaldoDescripcion,			EstadoCuenta.SaldoImporte,
		 EstadoCuenta.Vencimiento,						EstadoCuenta.Referencia,					/*Auxiliar.ID,*/						Auxiliar.Empresa,
		 Auxiliar.Rama,									/*Auxiliar.Cuenta,*/						Auxiliar.SubCuenta,						Auxiliar.Ejercicio,
		 Auxiliar.Periodo,								Auxiliar.Fecha,								Auxiliar.Grupo,							/*Auxiliar.Modulo,*/
		 /*Auxiliar.ModuloID,*/							Auxiliar.Mov,								Auxiliar.MovID,							Auxiliar.Cargo,
		 Auxiliar.Abono,								Auxiliar.Aplica,							Auxiliar.AplicaID,						Auxiliar.Acumulado,
		 Auxiliar.Conciliado,							Auxiliar.EsCancelacion,						/*Auxiliar.Moneda,*/					Auxiliar.TipoCambio,
		 Auxiliar.FechaConciliacion,					Auxiliar.Sucursal,							Prov.Proveedor,							Prov.Nombre,
		 Prov.NombreCorto,								Prov.Tipo,									Prov.Direccion,							Prov.EntreCalles,
		 Prov.Plano,									Prov.Observaciones,							Prov.Colonia,							Prov.CodigoPostal,
		 Prov.Poblacion,								Prov.Estado,								Prov.Pais,								Prov.Zona,
		 Prov.RFC,										Prov.Telefonos,								Prov.Fax,								Prov.PedirTono,
		 Prov.Contacto1,								Prov.Contacto2,								Prov.eMail1,							Prov.eMail2,
		 Prov.DirInternet,								Prov.Categoria,								Prov.Familia,							Prov.DiaRevision1,
		 Prov.DiaRevision2,								Prov.HorarioRevision,						Prov.DiaPago1,							Prov.DiaPago2,
		 Prov.HorarioPago,								Prov.ZonaImpuesto,							Prov.Clase,								Prov.Estatus,
		 Prov.UltimoCambio,								Prov.Alta,									Prov.Conciliar,							Prov.Descuento,
		 Prov.Proyecto,									Prov.Agente,								Prov.FormaEnvio,						Prov.Condicion,
		 Prov.Ruta,										Prov.DefMoneda,								Prov.Mensaje,							Prov.Extencion1,
		 Prov.Extencion2,								Prov.CURP,									d.Direccion1 DireccionNormalizada1,		d.Direccion2 DireccionNormalizada2,    
		 d.Direccion3 DireccionNormalizada3,			d.Direccion4 DireccionNormalizada4,			d.Direccion5 DireccionNormalizada5,     d.Direccion6 DireccionNormalizada6,            
		 d.Direccion7 DireccionNormalizada7,			d.Direccion8 DireccionNormalizada8,			cc.LineaCredito ProveedorLimiteCredito,	ISNULL(cc.Moneda,Prov.DefMoneda) ProveedorLimiteCreditoMoneda,
		 ISNULL(Prov.Condicion,'') ProveedorCondicionPago,
		 CASE 
           WHEN Condicion.PorMeses = 1 AND Condicion.PorSemanas = 0 THEN ISNULL(Condicion.Meses,0)
           WHEN Condicion.PorSemanas = 1 AND Condicion.PorMeses = 0 THEN ISNULL(Condicion.Semanas,0)
         END ProveedorTiempoCredito,  
         CASE 
           WHEN Condicion.PorMeses = 1 AND Condicion.PorSemanas = 0 THEN 'Meses'
           WHEN Condicion.PorSemanas = 1 AND Condicion.PorMeses = 0 THEN 'Semanas'
         END ProveedorUnidadTiempoCredito,  
         ec.ContMoneda MonedaContable,					@Etiqueta as Etiqueta,						@FechaD as FechaDesde,					GETDATE() as FechaHasta,	@VerGraficaDetalle as VerGraficaDetalle
    INTO #EstadoCuenta    
    FROM EstadoCuenta
    LEFT OUTER JOIN Auxiliar ON EstadoCuenta.AuxiliarID=Auxiliar.ID
    JOIN Prov ON EstadoCuenta.Cuenta=Prov.Proveedor
    JOIN Empresa ON Empresa.Empresa = EstadoCuenta.Empresa 
    JOIN @ContactoDireccion d ON d.Contacto = Prov.Proveedor
    LEFT OUTER JOIN ProvCredito cc ON cc.Proveedor = Prov.Proveedor AND cc.Empresa = @Empresa AND cc.Moneda = Prov.DefMoneda     
    JOIN EmpresaCFG ec ON ec.Empresa = Empresa.Empresa 
    LEFT OUTER JOIN Condicion ON Condicion.Condicion = Prov.Condicion
   WHERE EstadoCuenta.Estacion= @EstacionTrabajo 
     AND EstadoCuenta.Modulo = 'CXP'
     AND EstadoCuenta.Moneda = ISNULL(@Moneda,EstadoCuenta.Moneda) 

  IF ISNULL(@ModuloCorte, 0) = 0
    SELECT * FROM #EstadoCuenta
  ELSE
  BEGIN
    INSERT INTO #CorteD(
			Cuenta,					Mov,					MovID,							Fecha,					Vencimiento,			Moneda,
			Aplica,					AplicaID,				Referencia,						Cargo,					Abono,					CtaCreditoDias,
			CtaCondicion,			CtaLimiteCredito,		CtaLimiteCreditoMoneda,			ID)
	 SELECT Cuenta,					Mov,					MovID,							Fecha,					Vencimiento,			Moneda,
			Aplica,					AplicaID,				Referencia,						Cargo,					Abono,					ProveedorTiempoCredito,
			ProveedorCondicionPago,	ProveedorLimiteCredito,	ProveedorLimiteCreditoMoneda,	@ModuloID
	   FROM #EstadoCuenta

    INSERT INTO #ContactoDireccion(
			Contacto,				Direccion1,				Direccion2,						Direccion3,				Direccion4,				Direccion5,
			Direccion6,				Direccion7,				Direccion8)
	 SELECT Contacto,				Direccion1,				Direccion2,						Direccion3,				Direccion4,				Direccion5,
			Direccion6,				Direccion7,				Direccion8
	   FROM @ContactoDireccion  
  END
END
GO

/******************************* spCorteCxcEstadoCuentaSimple *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCxcEstadoCuentaSimple') and type = 'P') drop procedure dbo.spCorteCxcEstadoCuentaSimple
GO             
CREATE PROCEDURE spCorteCxcEstadoCuentaSimple
		@EstacionTrabajo		int,
		@ModuloCorte			bit		= 0,
		@ModuloID				int		= 0,
		@Ok                		int         = NULL OUTPUT,
    	@OkRef             		varchar(255)= NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa				varchar(5),
    @Modulo					varchar(5),
    @FechaD					datetime,
    @CuentaD				varchar(10),
    @CuentaA				varchar(10),
    @Sucursal				int,
    @Moneda					varchar(10),
    @EstatusEspecifico		varchar(15),
    @Etiqueta				bit,
	@GraficarTipo			varchar(30),
    @Contacto				varchar(10),
    @Titulo					varchar(100),
    @FechaA					datetime,
	@VerGraficaDetalle		bit

  DECLARE @ContactoDireccion TABLE
  (
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
  )

  SELECT
    @Empresa           = InfoEmpresa,
    @Modulo            = InfoModulo,
    @FechaD            = InfoFechaD,
    @CuentaD           = NULLIF(InfoClienteD,''),
    @CuentaA           = NULLIF(InfoClienteA,''),    
    @Sucursal          = ISNULL(InfoSucursal,-1),
    @EstatusEspecifico = CASE 
			               WHEN InfoEstatusEspecifico = 'Pendientes' THEN 'PENDIENTE'
                           WHEN InfoEstatusEspecifico = 'Concluidos' THEN 'CONCLUIDO'
                           WHEN InfoEstatusEspecifico = '(Todos)'	THEN NULL
                           WHEN InfoEstatusEspecifico = 'PENDIENTE'	THEN InfoEstatusEspecifico
                           WHEN InfoEstatusEspecifico = 'CONCLUIDO'	THEN InfoEstatusEspecifico
                         END,
    @Moneda            = CASE WHEN InfoMoneda = '(Todas)' THEN NULL WHEN RTRIM(InfoMoneda) = '' THEN NULL ELSE InfoMoneda END,
    @Etiqueta		   = ISNULL(InfoEtiqueta,0),
    @GraficarTipo	   = ISNULL(InformeGraficarTipo,  '(Todos)'),
    @Titulo			   = ISNULL(InfoTitulo,  ''),
	@VerGraficaDetalle = ISNULL(VerGraficaDetalle,0)
    FROM RepParam
   WHERE Estacion = @EstacionTrabajo 

  EXEC spCorteGenerarEstadoCuentaSimple @EstacionTrabajo, @Empresa, @Modulo, @FechaD, @CuentaD, @CuentaA, @Sucursal, @EstatusEspecifico, @Moneda
 
  -- Se reemplaza el uso del cursor y la funcion tipo tabla por el uso del Stored Procedure
  EXEC spContactoDireccionHorizontal @EstacionTrabajo, 'Cliente', @CuentaD, @CuentaA, 1,1,1,0  

  INSERT @ContactoDireccion(
		   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8
      FROM ContactoDireccionHorizontal 
     WHERE Estacion = @EstacionTrabajo

/*
  DECLARE crContactoDireccion CURSOR FAST_FORWARD FOR
   SELECT DISTINCT Cte.Cliente
     FROM EstadoCuenta
     JOIN Cte ON EstadoCuenta.Cuenta = Cte.Cliente
    WHERE EstadoCuenta.Estacion = @EstacionTrabajo
      AND EstadoCuenta.Modulo = @Modulo

  OPEN crContactoDireccion
  FETCH NEXT FROM crContactoDireccion INTO @Contacto
  WHILE @@FETCH_STATUS = 0
  BEGIN
    
    INSERT @ContactoDireccion(Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8)
    SELECT					   Contacto, Direccion1, Direccion2, Direccion3, Direccion4,Direccion5, Direccion6, Direccion7, Direccion8 
      FROM dbo.fnContactoDireccionHorizontal('Cliente',@Contacto,1,1,1,0)
        
    FETCH NEXT FROM crContactoDireccion INTO @Contacto
  END
  CLOSE crContactoDireccion
  DEALLOCATE crContactoDireccion
*/

  SELECT Empresa.Nombre EmpresaNombre,					EstadoCuenta.ID,							EstadoCuenta.Estacion,					EstadoCuenta.AuxiliarID,
		 EstadoCuenta.ModuloID,							RTRIM(LTRIM(EstadoCuenta.Modulo)) Modulo,	EstadoCuenta.Cuenta,					EstadoCuenta.Moneda,
		 EstadoCuenta.Efectivo,							EstadoCuenta.Consumos,						EstadoCuenta.Vales,						EstadoCuenta.Redondeo,
		 EstadoCuenta.ClienteEnviarA,					EstadoCuenta.Grafica,						EstadoCuenta.SaldoDescripcion,			EstadoCuenta.SaldoImporte,
		 EstadoCuenta.Vencimiento,						EstadoCuenta.Referencia,					/*Auxiliar.ID,*/						Auxiliar.Empresa,
		 Auxiliar.Rama,									/*Auxiliar.Cuenta,*/						Auxiliar.SubCuenta,						Auxiliar.Ejercicio,
		 Auxiliar.Periodo,								Auxiliar.Fecha,								Auxiliar.Grupo,							/*Auxiliar.Modulo,*/
		 /*Auxiliar.ModuloID,*/							Auxiliar.Mov,								Auxiliar.MovID,							Auxiliar.Cargo,
		 Auxiliar.Abono,								Auxiliar.Aplica,							Auxiliar.AplicaID,						Auxiliar.Acumulado,
		 Auxiliar.Conciliado,							Auxiliar.EsCancelacion,						/*Auxiliar.Moneda,*/					Auxiliar.TipoCambio,
		 Auxiliar.FechaConciliacion,					Auxiliar.Sucursal,							Cte.Cliente,							Cte.Nombre,
		 Cte.NombreCorto,								Cte.Numero,									Cte.Tipo,								Cte.Direccion,
		 Cte.EntreCalles,								Cte.Plano,									Cte.Observaciones,						Cte.Colonia,
		 Cte.CodigoPostal,								Cte.Poblacion,								Cte.Estado,								Cte.Pais,
		 Cte.Zona,										Cte.RFC,									Cte.Telefonos,							Cte.Fax,
		 Cte.PedirTono,									Cte.Contacto1,								Cte.Contacto2,							Cte.eMail1,
		 Cte.eMail2,									Cte.DirInternet,							Cte.Categoria,							Cte.Familia,
		 Cte.Credito,									Cte.Grupo 'CteGrupo',						Cte.DiaRevision1,						Cte.DiaRevision2,
		 Cte.HorarioRevision,							Cte.DiaPago1,								Cte.DiaPago2,							Cte.HorarioPago,
		 Cte.ZonaImpuesto,								Cte.PedidosParciales,						Cte.Clase,								Cte.Estatus,
		 Cte.UltimoCambio,								Cte.Alta,									Cte.Conciliar,							Cte.Descuento,
		 Cte.Proyecto,									Cte.Agente,									Cte.AgenteServicio,						Cte.EnviarA,
		 Cte.FormaEnvio,								Cte.Condicion,								Cte.Ruta,								Cte.ListaPrecios,
		 Cte.DefMoneda,									Cte.VtasConsignacion,						Cte.AlmacenVtasConsignacion,			Cte.Mensaje,
		 Cte.Extencion1,								Cte.Extencion2,								Cte.CURP,								d.Direccion1 DireccionNormalizada1,
		 d.Direccion2 DireccionNormalizada2,			d.Direccion3 DireccionNormalizada3,			d.Direccion4 DireccionNormalizada4,		d.Direccion5 DireccionNormalizada5,    
		 d.Direccion6 DireccionNormalizada6,			d.Direccion7 DireccionNormalizada7,			d.Direccion8 DireccionNormalizada8,		Cte.CreditoEspecial,
		 Cte.CreditoConDias,							Cte.CreditoDias,							cc.ConDias,								cc.Dias,
		 Cte.CreditoConCondiciones,						Cte.CreditoCondiciones,						cc.Condiciones,							cc.ConCondiciones,
		 Cte.CreditoConLimite,							Cte.CreditoLimite,							cc.ConLimiteCredito,					cc.LimiteCredito,
		 Cte.CreditoMoneda,								cc.MonedaCredito,							ec.ContMoneda MonedaContable,			@Etiqueta as Etiqueta,
	     @FechaD as FechaDesde,							GETDATE() as FechaHasta,
         CASE WHEN Cte.CreditoEspecial = 1 THEN
           CASE WHEN Cte.CreditoConLimite = 1 THEN ISNULL(Cte.CreditoLimite,0.0) ELSE NULL END
         ELSE  
           CASE WHEN cc.ConLimiteCredito = 1 THEN ISNULL(cc.LimiteCredito,0.0) ELSE NULL END       
         END ClienteLimiteCredito,
         CASE WHEN Cte.CreditoEspecial = 1 THEN
           CASE WHEN Cte.CreditoConLimite = 1 THEN ISNULL(Cte.CreditoMoneda,'') ELSE NULL END
         ELSE  
           CASE WHEN cc.ConLimiteCredito = 1 THEN ISNULL(cc.MonedaCredito,'') ELSE NULL END       
         END ClienteLimiteCreditoMoneda,    
         ISNULL(CASE WHEN Cte.CreditoEspecial = 1 THEN
           CASE WHEN Cte.CreditoConCondiciones = 1 THEN NULLIF(Cte.CreditoCondiciones,'') ELSE NULL END
         ELSE  
           CASE WHEN cc.ConCondiciones = 1 THEN NULLIF(cc.Condiciones,'') ELSE CONVERT(varchar,NULL) END       
         END,Cte.Condicion) ClienteCondicionPago,
         CASE WHEN Cte.CreditoEspecial = 1 THEN
           CASE WHEN Cte.CreditoConDias = 1 THEN ISNULL(Cte.CreditoDias,0) ELSE CONVERT(int,NULL) END
         ELSE  
           CASE WHEN cc.ConDias = 1 THEN ISNULL(cc.Dias,0) ELSE CONVERT(int,NULL) END       
         END ClienteCreditoDias,
		 @VerGraficaDetalle VerGraficaDetalle
    INTO #EstadoCuenta
    FROM EstadoCuenta
    LEFT OUTER JOIN Auxiliar ON EstadoCuenta.AuxiliarID=Auxiliar.ID
    JOIN Cte ON EstadoCuenta.Cuenta=Cte.Cliente
    JOIN Empresa ON Empresa.Empresa = EstadoCuenta.Empresa 
    JOIN @ContactoDireccion d ON d.Contacto = Cte.Cliente
    LEFT OUTER JOIN CteCredito cc ON cc.Credito = Cte.Credito AND cc.Empresa = @Empresa      
    JOIN EmpresaCFG ec ON ec.Empresa = Empresa.Empresa
   WHERE EstadoCuenta.Estacion= @EstacionTrabajo 
     AND EstadoCuenta.Modulo = 'CXC'
     AND EstadoCuenta.Moneda = ISNULL(@Moneda,EstadoCuenta.Moneda) 
 --ORDER BY EstadoCuenta.Grafica, Auxiliar.Ejercicio, Auxiliar.Periodo
 --select * from ctecredito 
 
  IF ISNULL(@ModuloCorte, 0) = 0
    SELECT * FROM #EstadoCuenta
  ELSE
  BEGIN
    INSERT INTO #CorteD(
			Cuenta,					Mov,					MovID,							Fecha,					Vencimiento,			Moneda,
			Aplica,					AplicaID,				Referencia,						Cargo,					Abono,					CtaCreditoDias,
			CtaCondicion,			CtaLimiteCredito,		CtaLimiteCreditoMoneda,			ID)
	 SELECT Cuenta,					Mov,					MovID,							Fecha,					Vencimiento,			Moneda,
			Aplica,					AplicaID,				Referencia,						Cargo,					Abono,					ClienteCreditoDias,
			ClienteCondicionPago,	ClienteLimiteCredito,	ClienteLimiteCreditoMoneda,		@ModuloID
	   FROM #EstadoCuenta

    INSERT INTO #ContactoDireccion(
			Contacto,				Direccion1,				Direccion2,						Direccion3,				Direccion4,				Direccion5,
			Direccion6,				Direccion7,				Direccion8)
	 SELECT Contacto,				Direccion1,				Direccion2,						Direccion3,				Direccion4,				Direccion5,
			Direccion6,				Direccion7,				Direccion8
	   FROM @ContactoDireccion
  END
END
GO

/**************** spCorteVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteVerificar') and type = 'P') drop procedure dbo.spCorteVerificar
GO
CREATE PROC spCorteVerificar
    		@ID               	int,
		    @Accion				char(20),
    		@Empresa          	char(5),
		    @Usuario			char(10),
    		@Modulo	      		char(5),
    		@Mov              	char(20),
	        @MovID				varchar(20),
    		@MovTipo	      	char(20),
    		@SubMovTipo	      	char(20),
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
		    @Estacion			int,
		    @CorteFiltrarFechas	bit,
    		@Ok               	int          OUTPUT,
    		@OkRef            	varchar(255) OUTPUT

--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @VigenciaD		datetime,
		  @VigenciaA		datetime,
		  @CorteNoPeriodos	int,
		  @CorteTipoPeriodo	varchar(3)

  SELECT @VigenciaD			= VigenciaD,
		 @VigenciaA			= VigenciaA,
		 @CorteNoPeriodos	= CorteNoPeriodos,
		 @CorteTipoPeriodo	= CorteTipoPeriodo
    FROM Corte
   WHERE ID = @ID

  IF ISNULL(@TipoCambio, 0) = 0
  BEGIN
    SELECT @Ok = 30140, @OkRef = @Moneda
    RETURN
  END
  
  IF ISNULL(@MovTipo, '') = 'CORTE.REPEXTERNO' AND ISNULL(@CorteOrigen, '') IN('Intelisis', '') AND @Accion = 'AFECTAR'
  BEGIN
    SELECT @Ok = 20380
    RETURN
  END
  
  IF ISNULL(@MovTipo, '') = 'CORTE.REPEXTERNO' AND NOT EXISTS(SELECT ID FROM CorteDReporte WHERE ID = @ID) AND @Accion = 'AFECTAR'
  BEGIN
    SELECT @Ok = 60010
    RETURN
  END
  
  IF ISNULL(@MovTipo, '') IN('CORTE.CORTEIMPORTE') AND @Accion = 'AFECTAR'
  BEGIN
    IF EXISTS(SELECT ID FROM CorteDConsulta WHERE ID = @ID AND ISNULL(Totalizador, '') = '')
    BEGIN
      SELECT @Ok = 10010, @OkRef = 'Totalizador'
      RETURN
    END
    
    IF @Ok IS NULL AND NOT EXISTS(SELECT ID FROM CorteDConsulta WHERE ID = @ID)
    BEGIN
      SELECT @Ok = 60010
      RETURN
    END
    
    IF @Ok IS NULL AND EXISTS(SELECT RID FROM CorteDConsulta WHERE ID = @ID AND ISNULL(Modulo, '') IN('', '(TODOS)'))
    BEGIN
      SELECT @Ok = 70020, @OkRef = Modulo
        FROM CorteDConsulta 
       WHERE ID = @ID 
         AND ISNULL(Modulo, '') IN('', '(TODOS)')

      RETURN    
    END
    
    IF @Ok IS NULL AND ISNULL(@CorteFiltrarFechas, 0) = 1 AND(@CorteFechaD IS NULL OR @CorteFechaA IS NULL)
    BEGIN
      SELECT @Ok = 46100
      RETURN
    END
    
    IF @Ok IS NULL AND ISNULL(@CorteFiltrarFechas, 0) = 0 AND @CorteEjercicio IS NULL AND @CortePeriodo IS NULL
    BEGIN
      SELECT @Ok = 10050
      RETURN
    END    
    
    IF EXISTS(SELECT CorteDConsulta.Totalizador, CorteMovTotalizadorTipoCampo.Tipo
                FROM CorteDConsulta
                LEFT OUTER JOIN CorteMovTotalizadorTipoCampo ON CorteDConsulta.Totalizador = CorteMovTotalizadorTipoCampo.Totalizador
               WHERE CorteDConsulta.ID = @ID
                 AND Tipo IS NULL)
    BEGIN
      SELECT @Ok = 10386, @OkRef = CorteDConsulta.Totalizador
        FROM CorteDConsulta
        LEFT OUTER JOIN CorteMovTotalizadorTipoCampo ON CorteDConsulta.Totalizador = CorteMovTotalizadorTipoCampo.Totalizador
       WHERE CorteDConsulta.ID = @ID
         AND Tipo IS NULL
      RETURN
    END
    
    IF (SELECT COUNT(DISTINCT CorteMovTotalizadorTipoCampo.Tipo)
          FROM CorteDConsulta
          LEFT OUTER JOIN CorteMovTotalizadorTipoCampo ON CorteDConsulta.Totalizador = CorteMovTotalizadorTipoCampo.Totalizador
         WHERE CorteDConsulta.ID = @ID) > 1
    BEGIN
      SELECT @Ok = 10387
      RETURN
    END
  END

  IF ISNULL(@MovTipo, '') IN('CORTE.CORTECONTABLE') AND @Accion = 'AFECTAR'
  BEGIN
    IF NOT EXISTS(SELECT ID FROM CorteDConsulta WHERE ID = @ID)
    BEGIN
      SELECT @Ok = 60010
      RETURN
    END
      
    IF @Ok IS NULL AND ISNULL(@CorteFiltrarFechas, 0) = 1 AND(@CorteFechaD IS NULL OR @CorteFechaA IS NULL)
    BEGIN
      SELECT @Ok = 46100
      RETURN
    END
    
    IF @Ok IS NULL AND ISNULL(@CorteFiltrarFechas, 0) = 0 AND @CorteEjercicio IS NULL AND @CortePeriodo IS NULL
    BEGIN
      SELECT @Ok = 10050
      RETURN
    END    
    
    IF @Ok IS NULL AND ISNULL(@CorteFiltrarFechas, 0) = 0 AND @CorteEjercicio IS NULL
    BEGIN
      SELECT @Ok = 10050
      RETURN
    END        

    --IF ISNULL(@CorteFiltrarFechas, 0) = 0
    --BEGIN
    --  SELECT @Ok = 28050
    --  RETURN
    --END

    IF EXISTS(SELECT RID FROM CorteDConsulta WHERE ID = @ID AND ISNULL(Modulo, '') NOT IN('CONT'))
    BEGIN
      SELECT @Ok = 70020, @OkRef = Modulo
        FROM CorteDConsulta 
       WHERE ID = @ID 
         AND ISNULL(Modulo, '') NOT IN('CONT')
         
      RETURN    
    END    
  END

  IF ISNULL(@MovTipo, '') IN('CORTE.EDOCTACXC') AND @Accion = 'AFECTAR'  
  BEGIN    
    IF @Ok IS NULL AND @CorteFechaD IS NULL AND ISNULL(@SubMovTipo, '') = ''
    BEGIN
      SELECT @Ok = 41020
      RETURN
    END          
  END

  IF ISNULL(@MovTipo, '') IN('CORTE.CORTECX') AND @Accion = 'AFECTAR'  
  BEGIN
    IF @Ok IS NULL AND EXISTS(SELECT RID FROM CorteDConsulta WHERE ID = @ID AND ISNULL(Modulo, '') IN('', '(TODOS)'))
    BEGIN
      SELECT @Ok = 70020, @OkRef = Modulo
        FROM CorteDConsulta 
       WHERE ID = @ID 
         AND ISNULL(Modulo, '') IN('', '(TODOS)')

      RETURN    
    END

    IF @Ok IS NULL AND NOT EXISTS(SELECT ID FROM CorteDConsulta WHERE ID = @ID)
    BEGIN
      SELECT @Ok = 60010
      RETURN
    END    
  END
  
  IF ISNULL(@SubMovTipo, '') IN('CORTE.GENERACORTECON', 'CORTE.GENERACORTECX', 'CORTE.GENERACORTEIMP', 'CORTE.GENERACORTEU') AND @Accion = 'AFECTAR'  
  BEGIN
    IF @VigenciaD IS NULL OR @VigenciaA IS NULL
    BEGIN
      SELECT @Ok = 10095
      RETURN
    END
    
    IF ISNULL(@CorteTipoPeriodo, '') = ''
    BEGIN
      SELECT @Ok = 55140
      RETURN
    END

    IF ISNULL(@CorteNoPeriodos, 0) = 0
    BEGIN
      SELECT @Ok = 10385
      RETURN
    END    
  END
  RETURN
END
GO

/**************** spCorteDinamicoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteDinamicoAfectar') and type = 'P') drop procedure dbo.spCorteDinamicoAfectar
GO             
CREATE PROC spCorteDinamicoAfectar
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20),
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
			@CorteFiltrarFechas	bit,
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  -- Primero Actualizamos las variables de Fechas, Periodo y Ejercicio segun sea el caso
  IF ISNULL(@CorteFiltrarFechas, 0) = 0
    SELECT @CorteFechaD = NULL, @CorteFechaA = NULL
  ELSE
    SELECT @CortePeriodo = NULL, @CorteEjercicio = NULL

  EXEC spCorteDConsulta @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						@Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						@Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			@CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			@CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			@CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			@CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			@Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               			@Ok OUTPUT, @OkRef OUTPUT    

  IF @Ok IS NULL
    EXEC spCorteDRecalcEncabezado @ID, @MovTipo, @Ok OUTPUT, @OkRef OUTPUT
  
  RETURN
END
GO

/**************** spCorteInvValAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteInvValAfectar') and type = 'P') drop procedure dbo.spCorteInvValAfectar
GO             
CREATE PROC spCorteInvValAfectar
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20)	OUTPUT,
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  UPDATE RepParam
     SET InfoEmpresa			 = @Empresa,
		 InfoFechaA				 = @CorteFechaA,
		 InfoArticuloD			 = @CorteCuentaDe,
		 InfoArticuloA			 = @CorteCuentaA,
		 InfoAlmacen			 = CASE WHEN @CorteGrupoDe IN('', '(Todos)', '(Todas)') THEN NULL ELSE @CorteGrupoDe END,
		 InfoInvVal				 = ISNULL(@CorteValuacion, '(Sin Valuar)'),
		 InfoDesglosar			 = ISNULL(@CorteDesglosar, 'No'),
		 RepTitulo				 = @CorteTitulo,
		 InformeGraficarTipo	 = '(Todos)',
		 InfoEtiqueta			 = 0,
		 InformeGraficarCantidad = 5,
		 VerGraficaDetalle		 = 0
   WHERE Estacion = @Estacion

  IF @CorteValuacion NOT IN('PEPS', 'UEPS')
    EXEC spCorteInvVal @Estacion, 1, @ID
  ELSE IF @CorteValuacion IN('PEPS', 'UEPS')
    EXEC spCorteInvValOtraMoneda @Estacion, 1, @ID
  RETURN 
END
GO

/**************** spCorteEdoCtaCxAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteEdoCtaCxAfectar') and type = 'P') drop procedure dbo.spCorteEdoCtaCxAfectar
GO             
CREATE PROC spCorteEdoCtaCxAfectar
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20)	OUTPUT,
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @CorteMoneda		varchar(10),
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
       		@Ok                		int          OUTPUT,
    		@OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  IF @MovTipo = 'CORTE.EDOCTACXC'
  BEGIN
    UPDATE RepParam
       SET InfoEmpresa				= @Empresa,
		   InfoFechaD				= @CorteFechaD,
		   InfoClienteD				= NULLIF(@CorteCuentaDe, ''),
		   InfoClienteA				= NULLIF(@CorteCuentaA, ''),
		   InfoSucursal				= ISNULL(@Sucursal, -1),
		   InfoEstatusEspecifico	= @CorteEstatus,
           InfoMoneda				= CASE 
                                        WHEN @CorteMoneda = '(Todas)' THEN NULL 
                                        ELSE @CorteMoneda
                                      END,
           InformeGraficarTipo		= '(Todos)',
           InfoTitulo				= ISNULL(@CorteTitulo, ''),
           InfoModulo				= 'CXC',
		   VerGraficaDetalle		= 0
     WHERE Estacion = @Estacion
     
    EXEC spCorteCxcEstadoCuentaSimple @Estacion, 1, @ID
  END	 

  IF @MovTipo = 'CORTE.EDOCTACXP'
  BEGIN
    UPDATE RepParam
       SET InfoEmpresa				= @Empresa,
		   InfoFechaD				= @CorteFechaD,
		   InfoProveedorD			= NULLIF(@CorteCuentaDe, ''),
		   InfoProveedorA			= NULLIF(@CorteCuentaA, ''),
		   InfoSucursal				= ISNULL(@Sucursal, -1),
		   InfoEstatusEspecifico	= @CorteEstatus,
           InfoMoneda				= CASE 
                                        WHEN @CorteMoneda = '(Todas)' THEN NULL 
                                        ELSE @CorteMoneda
                                      END,
           InformeGraficarTipo		= '(Todos)',
           InfoTitulo				= ISNULL(@CorteTitulo, ''),
           InfoModulo				= 'CXP',
		   VerGraficaDetalle		= 0
     WHERE Estacion = @Estacion
     
    EXEC spCorteCxpEstadoCuentaSimple @Estacion, 1, @ID
  END	   
  RETURN
END
GO

/**************** spCorteAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteAfectar') and type = 'P') drop procedure dbo.spCorteAfectar
GO             
CREATE PROC spCorteAfectar
    	    @ID                	int,
			@Accion				char(20),
    		@Empresa	      	char(5),
    		@Modulo	      		char(5),
    		@Mov	  	      	char(20),
    		@MovID             	varchar(20)	OUTPUT,
    		@MovTipo     		char(20),
    		@SubMovTipo     	char(20),
    		@FechaEmision      	datetime,
    		@FechaAfectacion    datetime,
    		@FechaConclusion	datetime,
    	 	@Proyecto	      	varchar(50),
    		@Usuario	      	char(10),
    		@Autorizacion      	char(10),
    		@Observaciones     	varchar(255),
    		@Concepto     		varchar(50),
			@Referencia			varchar(50),
    		@Estatus           	char(15),
 	    	@EstatusNuevo	    char(15),
    		@FechaRegistro     	datetime,
    		@Ejercicio	      	int,
    		@Periodo	      	int,
			@MovUsuario			char(10),
		    @CorteFrecuencia	varchar(50),
		    @CorteGrupo			varchar(50),
		    @CorteTipo			varchar(50),
		    @CortePeriodo		int,
		    @CorteEjercicio		int,
		    @CorteOrigen		varchar(50),
		    @CorteCuentaTipo	varchar(20),
		    @CorteGrupoDe		varchar(10),
		    @CorteGrupoA		varchar(10),
		    @CorteSubGrupoDe	varchar(20),
		    @CorteSubGrupoA		varchar(20),
		    @CorteCuentaDe		varchar(10),
		    @CorteCuentaA		varchar(10),
		    @CorteSubCuentaDe	varchar(50),
		    @CorteSubCuenta2A	varchar(50),
		    @CorteSubCuenta2De	varchar(50),
		    @CorteSubCuenta3A	varchar(50),
		    @CorteSubCuenta3De	varchar(50),
		    @CorteSubCuentaA	varchar(50),
		    @CorteUENDe			int,
		    @CorteUENA			int,
		    @CorteProyectoDe	varchar(50),
		    @CorteProyectoA		varchar(50),
		    @CorteFechaD		datetime,
		    @CorteFechaA		datetime,
		    @CorteMoneda		varchar(10),
		    @Moneda				varchar(10),
		    @TipoCambio			float,
		    @CorteTitulo		varchar(100),
		    @CorteMensaje		varchar(100),
		    @CorteEstatus		varchar(15),
		    @CorteSucursalDe	int,
		    @CorteSucursalA		int,
			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,
			@Estacion			int,
			@CorteValuacion		varchar(50),
			@CorteDesglosar		varchar(20),
			@CorteFiltrarFechas	bit,

			@Generar			bit,
    		@GenerarMov			char(20),
	        @GenerarAfectado	bit,
		    @IDGenerar			int	     	OUTPUT,	
    		@GenerarMovID	  	varchar(20)	OUTPUT,
			
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @FechaCancelacion		datetime,
		  @GenerarMovTipo		varchar(20),
		  @GenerarPeriodo		int,
		  @GenerarEjercicio		int,
		  @OModulo				varchar(5),
		  @OMov					varchar(20),
		  @OMovID				varchar(20),
		  @OID					int

  SELECT @OModulo	= OrigenTipo,
		 @OMov		= Origen,
		 @OMovID	= OrigenID
    FROM Corte
   WHERE ID = @ID

  CREATE TABLE #CorteD(
    ID						int			NULL,
    Renglon					float		NULL,
    RenglonSub				int			NULL,

    RID						int			NOT NULL IDENTITY(1, 1),    
    Cuenta					varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    Mov						varchar(20) COLLATE DATABASE_DEFAULT NULL,
    MovID					varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    Fecha					datetime	NULL,
    Vencimiento				datetime	NULL,
    Moneda					varchar(10)	COLLATE DATABASE_DEFAULT NULL,
    Aplica					varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    AplicaID				varchar(20)	COLLATE DATABASE_DEFAULT NULL,
    Referencia				varchar(50)	COLLATE DATABASE_DEFAULT NULL,
    CtaCreditoDias			int			NULL,
    CtaCondicion			varchar(50)	COLLATE DATABASE_DEFAULT NULL,
    CtaLimiteCredito		float		NULL,
    CtaLimiteCreditoMoneda	varchar(10) NULL,
    
    Cargo					float		NULL,
    Abono					float		NULL,
    CargoU					float		NULL,
    AbonoU					float		NULL,
    SaldoU					float		NULL,

    CostoPromedio			float		NULL,
    UltimoCosto				float		NULL,
    ValuacionNombre			varchar(50)	NULL,
    ValuacionValor			float		NULL,
    ValuacionValorArtConCosto float		NULL,
    PrecioLista				float		NULL,
    Precio2					float		NULL,
    Precio3					float		NULL,
    Precio4					float		NULL,
    Precio5					float		NULL,
    Precio6					float		NULL,
    Precio7					float		NULL,
    Precio8					float		NULL,
    Precio9					float		NULL,
    Precio10				float		NULL,
    CostoEstandar			float		NULL,
    CostoReposicion			float		NULL,
    Grupo					varchar(10)	NULL,
    Sucursal				int			NULL,
    SubCuenta				varchar(50)	NULL,
    CostoUnitario			float		NULL,
    CostoUnitarioOtraMoneda	float		NULL,
    MonedaContable			varchar(10)	NULL,
    Modulo					varchar(5)	NULL,
    ModuloID				int			NULL,
    Cantidad				float		NULL,
    Importe					float		NULL,
    RIDConsulta				int			NULL,
    TipoCambio				float		NULL,
    Saldo					float		NULL,
    Empresa					varchar(5)	NULL,
    Periodo					int			NULL,
    Ejercicio				int			NULL,
    Estatus					varchar(15)	NULL,
    SaldoI					float		NULL,
    EsCancelacion			bit			NULL,
    SaldoUI					float		NULL
    )
    
  CREATE TABLE #CorteDReporte(
    ID					int			NULL,
    Renglon				float		NULL,
    RenglonSub			int			NULL,
    
    RID					int			NOT NULL IDENTITY(1, 1),
	Tipo				varchar(5)	COLLATE DATABASE_DEFAULT NULL,
	Columna1			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Columna2			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna3			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna4			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna5			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna6			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna7			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna8			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna9			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna10			varchar(100)COLLATE DATABASE_DEFAULT NULL,	

	Columna11			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Columna12			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna13			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna14			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna15			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna16			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna17			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna18			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna19			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna20			varchar(100)COLLATE DATABASE_DEFAULT NULL,	

	Columna21			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Columna22			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna23			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna24			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna25			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna26			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna27			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna28			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna29			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna30			varchar(100)COLLATE DATABASE_DEFAULT NULL,	

	Columna31			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Columna32			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna33			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna34			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna35			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna36			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna37			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna38			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna39			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna40			varchar(100)COLLATE DATABASE_DEFAULT NULL,	

	Columna41			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Columna42			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna43			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna44			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna45			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna46			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna47			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna48			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna49			varchar(100)COLLATE DATABASE_DEFAULT NULL,	
	Columna50			varchar(100)COLLATE DATABASE_DEFAULT NULL,

	Agrupador1			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador2			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador3			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador4			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador5			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador6			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador7			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador8			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador9			varchar(100)COLLATE DATABASE_DEFAULT NULL,
	Agrupador10			varchar(100)COLLATE DATABASE_DEFAULT NULL
    )

  CREATE TABLE #ContactoDireccion(
    Contacto				varchar(10)  COLLATE DATABASE_DEFAULT NULL,
    Direccion1				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion2				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion3				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion4				varchar(255) COLLATE DATABASE_DEFAULT NULL,		
    Direccion5				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion6				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion7				varchar(255) COLLATE DATABASE_DEFAULT NULL,
    Direccion8				varchar(255) COLLATE DATABASE_DEFAULT NULL																						
	)

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END
  
  IF @OK IS NOT NULL RETURN 

  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
					  NULL, NULL, @Mov, @MovID, 0, @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    EXEC spCorteCalcPeriodoFecha @ID, @IDGenerar, @Ok = @Ok OUTPUT					  
    
    -- Leer MovTipo, Periodo y Ejercicio	    
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT

    IF @Ok IS NULL
    BEGIN
      SELECT * INTO #CorteDConsulta FROM cCorteDConsulta WHERE ID = @ID
      UPDATE #CorteDConsulta SET ID = @IDGenerar
      INSERT INTO cCorteDConsulta SELECT * FROM #CorteDConsulta    
    END

    IF @Ok IS NULL SELECT @Ok = 80030

    RETURN
  END

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, NULL, NULL, NULL, @Ok OUTPUT

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, NULL, NULL, @Observaciones,
								 NULL, NULL, NULL, NULL, @Ok OUTPUT
				   
    IF @Accion IN ('AFECTAR', 'CANCELAR')
    BEGIN
      IF @MovTipo IN('CORTE.EDOCTACXC', 'CORTE.EDOCTACXP') AND @Accion = 'AFECTAR'
      BEGIN
        EXEC spCorteEdoCtaCxAfectar 
						   @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @CorteMoneda, 
			   			   @Moneda, @TipoCambio, @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion,
               			   @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @MovTipo IN('CORTE.INVVAL') AND @Accion = 'AFECTAR'
      BEGIN
        EXEC spCorteInvValAfectar 
						   @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,
               			   @Ok OUTPUT, @OkRef OUTPUT
      END

      IF @MovTipo IN('CORTE.CORTEIMPORTE', 'CORTE.CORTECONTABLE', 'CORTE.CORTEUNIDADES', 'CORTE.CORTECX') AND ISNULL(@SubMovTipo, '') NOT IN('CORTE.GENERACORTEIMP', 'CORTE.GENERACORTECON', 'CORTE.GENERACORTEU', 'CORTE.GENERACORTECX') AND @Accion = 'AFECTAR'
      BEGIN
        EXEC spCorteDinamicoAfectar 
						   @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               			   @Ok OUTPUT, @OkRef OUTPUT      
      END

      IF @Accion = 'AFECTAR' AND ISNULL(@SubMovTipo, '') NOT IN('CORTE.GENERACORTEIMP', 'CORTE.GENERACORTECON', 'CORTE.GENERACORTEU', 'CORTE.GENERACORTECX')
      BEGIN
        EXEC spCorteD @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar,
               			   @Ok OUTPUT, @OkRef OUTPUT

        EXEC spCorteDReporte @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						     @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						     @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			     @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			     @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			     @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			     @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			     @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
               			     @Ok OUTPUT, @OkRef OUTPUT
      END              			                  			   

      -- Actualizar Movimiento
      IF @Ok IN (NULL, 80030)
      BEGIN
        IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
        IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL

        EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT

        UPDATE Corte
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
			   Estatus          = @EstatusNuevo,
               Situacion 		= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, NULL, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, 1

  -- Generar el Flujo
  IF @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO' AND @Ok IS NULL
  BEGIN
    IF ISNULL(@OModulo, '') <> ''
    BEGIN
      EXEC spMovEnID @OModulo, @Empresa, @OMov, @OMovID, @OID OUTPUT, NULL, @Ok OUTPUT

      IF @Ok IS NULL
       EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @OModulo, @OID, @OMov, @OMovID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
    END
  END
  
  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
END
GO

/**************** spCorte ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorte') and type = 'P') drop procedure dbo.spCorte
GO
CREATE PROC spCorte
            @ID                 int,
    		@Modulo	      		char(5),
			@Accion				char(20),
			@Base				char(20),
			@FechaRegistro		datetime,
			@GenerarMov			char(20),
			@Usuario			char(10),
    		@Conexion			bit,
			@SincroFinal		bit,
			@Estacion			int,
    		@Mov	      		char(20)		OUTPUT,
    		@MovID            	varchar(20)		OUTPUT,
			@IDGenerar			int				OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @EstatusNuevo			char(15),
		  @Sucursal				int,
		  @SucursalDestino		int,
		  @SucursalOrigen		int,
		  @Empresa	      		char(5),
		  @FechaEmision			datetime,
		  @FechaAfectacion		datetime,
		  @FechaConclusion		datetime,
		  @Proyecto	      		varchar(50),
		  @MovUsuario			char(10),
		  @Autorizacion			char(10),

		  @Generar				bit,
	      @GenerarAfectado		bit,
    	  @GenerarMovID	  		varchar(20),
		  
		  @CorteFrecuencia		varchar(50),
		  @CorteGrupo			varchar(50),
		  @CorteTipo			varchar(50),
		  @CortePeriodo			int,
		  @CorteEjercicio		int,
		  @CorteOrigen			varchar(50),
		  @CorteCuentaTipo		varchar(20),
		  @CorteGrupoDe			varchar(10),
		  @CorteGrupoA			varchar(10),
		  @CorteSubGrupoDe		varchar(20),
		  @CorteSubGrupoA		varchar(20),
		  @CorteCuentaDe		varchar(10),
		  @CorteCuentaA			varchar(10),
		  @CorteSubCuentaDe		varchar(50),
		  @CorteSubCuenta2A		varchar(50),
		  @CorteSubCuenta2De	varchar(50),
		  @CorteSubCuenta3A		varchar(50),
		  @CorteSubCuenta3De	varchar(50),
		  @CorteSubCuentaA		varchar(50),
		  @CorteUENDe			int,
		  @CorteUENA			int,
		  @CorteProyectoDe		varchar(50),
		  @CorteProyectoA		varchar(50),
		  @CorteFechaD			datetime,
		  @CorteFechaA			datetime,
		  @CorteMoneda			varchar(10),
		  @Moneda				varchar(10),
		  @TipoCambio			float,
		  @CorteTitulo			varchar(100),
		  @CorteMensaje			varchar(100),
		  @CorteEstatus			varchar(15),
		  @CorteSucursalDe		int,
		  @CorteSucursalA		int,
		  @CorteValuacion		varchar(50),
		  @CorteDesglosar		varchar(20),		  
		  @CorteFiltrarFechas	bit,
		  
		  @Observaciones		varchar(255),
		  @Estatus				char(15),
		  @Concepto    			varchar(50),
		  @Referencia 			varchar(50),
		  @Condicion			varchar(50),
		  @MovTipo   			char(20),
		  @SubMovTipo			varchar(20),
		  @Periodo				int,
		  @Ejercicio			int,
		  @EnLinea				bit,
		  @PuedeEditar			bit
      
  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal				= Sucursal, 
		 @SucursalDestino		= SucursalDestino, 
		 @SucursalOrigen		= SucursalOrigen, 
		 @Empresa				= Empresa, 
		 @MovID					= MovID, 
		 @Mov					= Mov, 
		 @FechaEmision			= FechaEmision, 
		 @Proyecto				= NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario			= Usuario, 
         @Autorizacion			= Autorizacion, 
         @Observaciones			= Observaciones, 
         @Estatus				= UPPER(Estatus), 
         @FechaConclusion		= FechaConclusion,
         @Concepto				= Concepto, 
         @Referencia			= Referencia,
		 @CorteFrecuencia		= CorteFrecuencia,
		 @CorteGrupo			= CorteGrupo,
		 @CorteTipo				= CorteTipo,
		 @CortePeriodo			= CortePeriodo,
		 @CorteEjercicio		= CorteEjercicio,
		 @CorteOrigen			= CorteOrigen,
		 @CorteCuentaTipo		= CorteCuentaTipo,
		 @CorteGrupoDe			= CorteGrupoDe,
		 @CorteGrupoA			= CorteGrupoA,
		 @CorteSubGrupoDe		= CorteSubGrupoDe,
		 @CorteSubGrupoA		= CorteSubGrupoA,
		 @CorteCuentaDe			= CorteCuentaDe,
		 @CorteCuentaA			= CorteCuentaA,
		 @CorteSubCuentaDe		= CorteSubCuentaDe,
		 @CorteSubCuenta2A		= CorteSubCuenta2A,
		 @CorteSubCuenta2De		= CorteSubCuenta2De,
		 @CorteSubCuenta3A		= CorteSubCuenta3A,
		 @CorteSubCuenta3De		= CorteSubCuenta3De,
		 @CorteSubCuentaA		= CorteSubCuentaA,
		 @CorteUENDe			= CorteUENDe,
		 @CorteUENA				= CorteUENA,
		 @CorteProyectoDe		= CorteProyectoDe,
		 @CorteProyectoA		= CorteProyectoA,
		 @CorteFechaD			= CorteFechaD,
		 @CorteFechaA			= CorteFechaA,
		 @CorteMoneda			= CorteMoneda,
		 @Moneda				= Moneda,
		 @TipoCambio			= TipoCambio,
		 @CorteTitulo			= CorteTitulo,
		 @CorteMensaje			= CorteMensaje,
		 @CorteEstatus			= CorteEstatus,
		 @CorteSucursalDe		= CorteSucursalDe,
		 @CorteSucursalA		= CorteSucursalA,
		 @CorteValuacion		= CorteValuacion,
		 @CorteDesglosar		= CorteDesglosar,
		 @CorteFiltrarFechas	= ISNULL(CorteFiltrarFechas, 0)
    FROM Corte
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1
          
  IF @Ok IS NULL
  BEGIN
    IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
    -- Leer MovTipo, Periodo y Ejercicio	
    -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
    EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
    EXEC spExtraerFecha @FechaAfectacion OUTPUT
    EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT

    SELECT @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo
    
    EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT  
  
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

  IF (@Accion <> 'CANCELAR' AND @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR', 'PENDIENTE', 'VIGENTE')) OR 
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'VIGENTE'))
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR'
    BEGIN
      IF ISNULL(@SubMovTipo, '') NOT IN('CORTE.GENERACORTEIMP', 'CORTE.GENERACORTECON', 'CORTE.GENERACORTEU', 'CORTE.GENERACORTECX')
        SELECT @EstatusNuevo = 'CONCLUIDO'
      ELSE
        SELECT @EstatusNuevo = 'VIGENTE'
    END   

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      EXEC spCorteVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @SubMovTipo, @FechaEmision, @Estatus, @EstatusNuevo, 
							@CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			    @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			    @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			    @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @Moneda, @TipoCambio, 
			   			    @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
							@Conexion, @SincroFinal, @Sucursal, @Estacion, @CorteFiltrarFechas, @Ok OUTPUT, @OkRef OUTPUT

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estuvo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
         
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spCorteAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @SubMovTipo, @FechaEmision, @FechaAfectacion, @FechaConclusion,
						   @Proyecto, @Usuario, @Autorizacion, @Observaciones, @Concepto, @Referencia, 
						   @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario, @CorteFrecuencia, @CorteGrupo, @CorteTipo, 
			   			   @CortePeriodo, @CorteEjercicio, @CorteOrigen, @CorteCuentaTipo, @CorteGrupoDe, @CorteGrupoA, @CorteSubGrupoDe, @CorteSubGrupoA, 
			   			   @CorteCuentaDe, @CorteCuentaA, @CorteSubCuentaDe, @CorteSubCuenta2A, @CorteSubCuenta2De, @CorteSubCuenta3A, @CorteSubCuenta3De,
			   			   @CorteSubCuentaA, @CorteUENDe, @CorteUENA, @CorteProyectoDe, @CorteProyectoA, @CorteFechaD, @CorteFechaA, @CorteMoneda, @Moneda, @TipoCambio, 
			   			   @CorteTitulo, @CorteMensaje, @CorteEstatus, @CorteSucursalDe, @CorteSucursalA,                           
			   			   @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @Estacion, @CorteValuacion, @CorteDesglosar, @CorteFiltrarFechas,
						   @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT, 
               			   @Ok OUTPUT, @OkRef OUTPUT
  END ELSE 
  BEGIN
    IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
    IF @Estatus = 'AFECTANDO' SELECT @Ok = 80020 ELSE
    IF @Estatus = 'CONCLUIDO' SELECT @Ok = 80010
    ELSE SELECT @Ok = 60040, @OkRef = 'Estatus: '+@Estatus
  END

  IF @Accion = 'SINCRO' AND @Ok = 80060 
  BEGIN
    SELECT @Ok = NULL, @OkRef = NULL
    EXEC spSucursalEnLinea @SucursalDestino, @EnLinea OUTPUT
    IF @EnLinea = 1 EXEC spSincroFinalModulo @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
  END

  -- Si se Genero un Movimiento, Desplegarlo
  IF @Ok = 80030
    SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))
  -- Si hubo un error poner como referencia el Movimiento
  --ELSE
  --  SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  ---- Si hay Mensaje pero no tiene referencia
  --IF @Ok IS NOT NULL AND @OkRef IS NULL
  --  SELECT @OkRef = RTRIM(ISNULL(@Mov, ''))+' '+RTRIM(ISNULL(@MovID, '')), @IDGenerar = NULL

  RETURN
END
GO

/******************************* spCorteEnFrecuencia *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteEnFrecuencia') and type = 'P') drop procedure dbo.spCorteEnFrecuencia
GO             
CREATE PROCEDURE spCorteEnFrecuencia
		@ID							int,
		@FechaEmision				datetime,
		@Resultado					bit OUTPUT,
		@Ok							int	= NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
  @RID							int,
  @FechaD						datetime,
  @FechaA						datetime,
  @PrimerDiaSemana				int,
  @Frecuencia					varchar(20),
  @DiaSemanaEmision				int,
  @DiaEmision					int,
  @MesEmision					int,
  @AnoEmision					int,
  @DiasMesEmision				int,
  @Lunes						bit,
  @Martes						bit,
  @Miercoles					bit,
  @Jueves						bit,
  @Viernes						bit,
  @Sabado						bit,
  @Domingo						bit,
  @DiaMes						int,
  @VigenciaD					datetime,
  @Diferencia					int,
  @Mov							varchar(20),
  @MovID						varchar(20)
  
  SET @PrimerDiaSemana = @@DATEFIRST
  SET DATEFIRST 1

  SET @DiaSemanaEmision = DATEPART(dw,@FechaEmision)
  SET @DiaEmision       = DATEPART(d,@FechaEmision)
  SET @MesEmision       = DATEPART(mm,@FechaEmision)        
  SET @AnoEmision       = DATEPART(yy,@FechaEmision)        
  SET @DiasMesEmision = dbo.fnDiasMes(@MesEmision,@AnoEmision)

  SET @Resultado = 0
  
  SELECT 
    @Frecuencia = ISNULL(Frecuencia,'(Diaria)'), 
    @DiaMes = ISNULL(DiaMes,0),
    @VigenciaD = VigenciaD,
    @Lunes = ISNULL(Lunes,0),
    @Martes = ISNULL(Martes,0),
    @Miercoles = ISNULL(Miercoles,0),
    @Jueves = ISNULL(Jueves,0),
    @Viernes = ISNULL(Viernes,0), 
    @Sabado = ISNULL(Sabado,0),
    @Domingo = ISNULL(Domingo,0),
    @Mov = Mov,
    @MovID = ISNULL(MovID, '')
    FROM Corte 
   WHERE ID = @ID

  IF @DiasMesEmision < @DiaMes SET @DiaMes = @DiasMesEmision

  SET @Diferencia = DATEDIFF(mm,CONVERT(datetime,@VigenciaD),CONVERT(datetime,@FechaEmision))
  
  IF @Frecuencia IN ('(Mensual)','(Bimestral)','(Trimestral)','(Semestral)','(Anual)') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @VigenciaD IS NULL SELECT @Ok = 41020, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID) ELSE
  IF @Frecuencia IN ('(Mensual)','(Bimestral)','(Trimestral)','(Semestral)','(Anual)') AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) AND @DiaMes = 0 SELECT @Ok = 10060, @OkRef = RTRIM(@Mov)+' '+RTRIM(@MovID)
 
  IF @Frecuencia = '(Diaria)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    SET @Resultado = 1
  END ELSE
  IF @Frecuencia = '(Semanal)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN    
    IF @DiaSemanaEmision = 1 SET @Resultado = ISNULL(@Lunes,0) ELSE
    IF @DiaSemanaEmision = 2 SET @Resultado = ISNULL(@Martes,0) ELSE    
    IF @DiaSemanaEmision = 3 SET @Resultado = ISNULL(@Miercoles,0) ELSE        
    IF @DiaSemanaEmision = 4 SET @Resultado = ISNULL(@Jueves,0) ELSE            
    IF @DiaSemanaEmision = 5 SET @Resultado = ISNULL(@Viernes,0) ELSE                
    IF @DiaSemanaEmision = 6 SET @Resultado = ISNULL(@Sabado,0) ELSE                    
    IF @DiaSemanaEmision = 7 SET @Resultado = ISNULL(@Domingo,0)
  END ELSE  
  IF @Frecuencia = '(Mensual)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF @FechaEmision >= @VigenciaD
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END
  END ELSE
  IF @Frecuencia = '(Bimestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @VigenciaD) AND ( @Diferencia % 2 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END  
  END ELSE
  IF @Frecuencia = '(Trimestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @VigenciaD) AND ( @Diferencia % 3 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END  
  END ELSE
  IF @Frecuencia = '(Semestral)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @VigenciaD) AND ( @Diferencia % 6 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END    
  END ELSE
  IF @Frecuencia = '(Anual)' AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
  BEGIN
    IF (@FechaEmision >= @VigenciaD) AND ( @Diferencia % 12 = 0)
    BEGIN
      IF @DiaEmision = @DiaMes SELECT @Resultado = 1    
    END      
  END
  
  SET DATEFIRST @PrimerDiaSemana
    
END
GO

/**************** spCorteCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCerrarDia') and type = 'P') drop procedure dbo.spCorteCerrarDia
GO             
CREATE PROCEDURE spCorteCerrarDia
		@Sucursal				int,
		@Empresa				varchar(5),
		@Usuario				varchar(10),
		@Fecha					datetime,
		@Estacion				int,
		@Ok						int OUTPUT,
		@OkRef					varchar(255) OUTPUT

--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @ID			int,
		  @IDAnt		int,
		  @IDGenera		int,
		  @VigenciaD	datetime,
		  @VigenciaA	datetime,
		  @MovGenera	varchar(20),
		  @SubMovTipo	varchar(20),
		  @GenerarCorte	bit

  IF ISNULL(@Estacion, 0) = 0
    SELECT @Estacion = @@SPID

  SELECT @IDAnt = 0
  WHILE(1=1)
  BEGIN
    SELECT @ID = MIN(ID)
      FROM Corte
      JOIN MovTipo ON Corte.Mov = MovTipo.Mov AND Modulo = 'CORTE' AND ISNULL(SubClave, '') IN('CORTE.GENERACORTECON', 'CORTE.GENERACORTECX', 'CORTE.GENERACORTEIMP', 'CORTE.GENERACORTEU')      
     WHERE Estatus = 'VIGENTE'
       AND ID > @IDAnt
  
    IF @ID IS NULL BREAK
    
    SELECT @IDAnt = @ID
    
    SELECT @VigenciaD = NULL, @VigenciaA = NULL, @MovGenera = NULL, @SubMovTipo = NULL, @Ok = NULL, @OkRef = NULL, @IDGenera = NULL, @GenerarCorte = 0
    
    SELECT @VigenciaD = VigenciaD,
		   @VigenciaA = VigenciaA
	  FROM Corte
	 WHERE ID = @ID

    IF @Fecha BETWEEN @VigenciaD AND @VigenciaA
    BEGIN
      EXEC spCorteEnFrecuencia @ID, @Fecha, @GenerarCorte OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      
      IF @GenerarCorte = 1
      BEGIN
        SELECT @SubMovTipo = MovTipo.SubClave
          FROM Corte
          JOIN MovTipo ON Corte.Mov = MovTipo.Mov AND Modulo = 'CORTE'
         WHERE ID = @ID    

        IF @SubMovTipo = 'CORTE.GENERACORTECON'
          SELECT @MovGenera = CorteContable FROM EmpresaCfgMovCorte WHERE Empresa = @Empresa
        ELSE IF @SubMovTipo = 'CORTE.GENERACORTECX'
          SELECT @MovGenera = CorteCx FROM EmpresaCfgMovCorte WHERE Empresa = @Empresa      
        ELSE IF @SubMovTipo = 'CORTE.GENERACORTEIMP'
          SELECT @MovGenera = CorteImporte FROM EmpresaCfgMovCorte WHERE Empresa = @Empresa      
        ELSE IF @SubMovTipo = 'CORTE.GENERACORTEU'
          SELECT @MovGenera = CorteUnidades FROM EmpresaCfgMovCorte WHERE Empresa = @Empresa      

        EXEC @IDGenera = spAfectar 'CORTE', @ID, 'GENERAR', 'Todo', @MovGenera, @Usuario = @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
      
        IF @IDGenera IS NOT NULL AND @Ok = 80030
        BEGIN
          SELECT @Ok = NULL, @OkRef = NULL
        
          EXEC spAfectar 'CORTE', @IDGenera, 'AFECTAR', 'Todo', NULL, @Usuario = @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
        END
      END
    END
    ELSE IF @Fecha > @VigenciaA
    BEGIN
      EXEC spAfectar 'CORTE', @ID, 'AFECTAR', 'Todo', NULL, @Usuario = @Usuario, @Estacion = @Estacion, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    END
  END
END
GO

/**************** spCorteJobStep ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteJobStep') and type = 'P') drop procedure dbo.spCorteJobStep
GO             
CREATE PROCEDURE spCorteJobStep
		@Sucursal				int,
		@Empresa				varchar(5),
		@Usuario				varchar(10)
--//WITH ENCRYPTION
AS 
BEGIN
  DECLARE @Fecha		datetime,
		  @Estacion		int,
		  @Ok			int,
		  @OkRef		varchar(255)

  SELECT @Fecha = dbo.fnFechaSinHora(GETDATE())
  
  SELECT @Estacion = @@SPID
  
  EXEC spCorteCerrarDia @Sucursal, @Empresa, @Usuario, @Fecha, @Estacion, @Ok = @ok OUTPUT, @OkRef = @OkRef OUTPUT
  RETURN
END
GO

/**************** spCorteCrearJobs ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCorteCrearJobs') and type = 'P') drop procedure dbo.spCorteCrearJobs
GO             
CREATE PROCEDURE spCorteCrearJobs
  @Nombre   varchar(100),
  @BaseDatos        varchar(30),
  @UsuarioI         varchar(30)
 
 
--//WITH ENCRYPTION
AS
  DECLARE
  @TrabajoID        binary (16),
  @ReturnCode       int,
  @Usuario                 varchar(30),
  @Contrasena       varchar(30),
  @Activo                  bit,
  @Trabajo                 char(20),
  @Cadena                  varchar(100),
  @Servidor                varchar(30),   
  @HoraInicial             int,
  @HoraFinal        int,
  @Frecuencia       tinyint,
  @Valor                   tinyint,
  @Recurrencia             tinyint, 
  @FrecuenciaD             tinyint,
  @ValorD                  tinyint,
 
  @Domingo                 bit,
  @Lunes                   bit,
  @Martes                  bit,
  @Miercoles        bit,
  @Jueves                  bit,
  @Viernes                 bit,
  @Sabado                  bit,
  @Valor2                  tinyint,
  @Tipo                           tinyint,
  @Dia                     tinyint,
  @Fecha2                  int,
 
  @Estatus                 bit,
 
  @spSucursal       int,
  @spEmpresa        varchar(5),
  @spUsuario        varchar(30),
  @spFecha                 datetime,
  @NombreOriginal   varchar(100),
  @Procesar                varchar(30)
 
  BEGIN TRANSACTION
    DECLARE @SQLServerAgent TABLE
    (
    Estatus                       varchar(50)
    )
 
    SELECT @NombreOriginal = ISNULL(@Nombre,'')
    SELECT @Nombre = ISNULL(@Nombre,'') + '.' + @@SERVERNAME + '.' + @BaseDatos
    SELECT @ReturnCode = 0    
    IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = '[Uncategorized (Local)]') < 1
      EXECUTE msdb.dbo.sp_add_category @name = '[Uncategorized (Local)]'
   
    SELECT @TrabajoID = job_id FROM   msdb.dbo.sysjobs WHERE (name = @Nombre)
    IF (@TrabajoID IS NOT NULL)   
    BEGIN 
       IF (EXISTS (SELECT  * FROM    msdb.dbo.sysjobservers WHERE   (job_id = @TrabajoID) AND (server_id <> 0)))
         BEGIN
            RAISERROR ('Unable to import job ''Corte '' since there is already a multi-server job with this name.', 16, 1)
            SELECT @ReturnCode = 1    
         END
       ELSE
         EXECUTE msdb.dbo.sp_delete_job @job_name = @Nombre
      SELECT @TrabajoID = NULL
    END
 
 
  IF (@@ERROR = 0 AND @ReturnCode = 0) AND EXISTS(SELECT * FROM CorteTrabajo WHERE Trabajo = @NombreOriginal)
  BEGIN
    IF @ReturnCode = 0
      EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @TrabajoID OUTPUT , @job_name = @Nombre, @owner_login_name = @Usuario, @description =  @Nombre, @category_name = '[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
 
       DECLARE crTrabajo SCROLL CURSOR FOR
       SELECT Trabajo, Usuario, Contrasena, CONVERT(int, SUBSTRING(HoraInicial,1,2) + SUBSTRING(HoraInicial,4,2) + '00'), CONVERT(int, SUBSTRING(HoraFinal,1,2) + SUBSTRING(HoraFinal,4,2) + '00'), CASE Frecuencia WHEN 'Diaria' THEN 4 WHEN 'Semanal' THEN 8 WHEN 'Mensual' THEN 16 WHEN 'Mensual 2' THEN 32 END, Valor, Recurrencia, CASE FrecuenciaD WHEN 'Minutos' THEN 4 WHEN 'Horas' THEN 8 END , ValorD, Activo, Domingo, Lunes, Martes, Miercoles, Jueves, Viernes, Sabado, CASE Tipo WHEN 'Primer' THEN 1 WHEN 'Segundo' THEN 2 WHEN 'Tercer' THEN 4 WHEN 'Cuarto' THEN 8 WHEN 'Ultimo' THEN 16 END, CASE Dia WHEN 'Domingo' THEN 1 WHEN 'Lunes' THEN 2 WHEN 'Martes' THEN 3 WHEN 'Miercoles' THEN 4 WHEN 'Jueves' THEN 5 WHEN 'Viernes' THEN 6 WHEN 'Sabado' THEN 7 WHEN 'Día' THEN 8 WHEN 'Día de la semana' THEN 9 WHEN 'Día del fin de semana' THEN 10 END, CONVERT(int, CONVERT(varchar,DATEPART(YEAR,FechaInicial)) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(MONTH,FechaInicial)),2) + dbo.fnRellenarCerosIzquierda(CONVERT(varchar,DATEPART(DAY,FechaInicial)),2)), spSucursal, spEmpresa, spUsuario, GETDATE(), ISNULL(Procesar,'')
         FROM CorteTrabajo
       WHERE Trabajo = @NombreOriginal
      
       IF ISNULL(@Contrasena,'') = ''
             SELECT @Contrasena = 'NULL'
 
       OPEN crTrabajo
 
       FETCH NEXT FROM crTrabajo INTO @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
 
       WHILE @@FETCH_STATUS = 0 AND @ReturnCode = 0
       BEGIN
--select @Frecuencia = 32
         SELECT @Valor2 = 0
      IF @Frecuencia = 8
      BEGIN
        IF @Domingo = 1
          SELECT @Valor2 = @Valor2 + 1
       
        IF @Lunes = 1
          SELECT @Valor2 = @Valor2 + 2
       
        IF @Martes = 1
          SELECT @Valor2 = @Valor2 + 4
       
        IF @Miercoles = 1
          SELECT @Valor2 = @Valor2 + 8
        
        IF @Jueves = 1
          SELECT @Valor2 = @Valor2 + 16
       
        IF @Viernes = 1
          SELECT @Valor2 = @Valor2 + 32
       
        IF @Sabado = 1
          SELECT @Valor2 = @Valor2 + 64
     
        SELECT @Valor = @Valor2
      END
 
      ELSE
      IF @Frecuencia = 32
        SELECT @Valor = @Dia
 
         IF @Procesar = 'Procesar Cortes'
           SET @cadena     = 'EXEC spCorteJobStep ' + '''' + RTRIM(@spSucursal) + '''' + ', ' + '''' + RTRIM(@spEmpresa) + '''' + ', ' + '''' + RTRIM(@spUsuario) + ''''
 
--       select @Cadena
 
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @TrabajoID, @step_id = 1, @step_name = @Trabajo, @command = @cadena, @database_name = @BaseDatos, @server = '', @database_user_name = '', @subsystem = 'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = '', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
 
         UPDATE CorteTrabajo SET UltimaActualizacion = GETDATE() WHERE Trabajo = @Trabajo
        
         FETCH NEXT FROM crTrabajo INTO  @Trabajo, @Usuario, @Contrasena, @HoraInicial, @HoraFinal, @Frecuencia, @Valor, @Recurrencia, @FrecuenciaD, @ValorD, @Activo, @Domingo, @Lunes, @Martes, @Miercoles, @Jueves, @Viernes, @Sabado, @Tipo, @Dia, @Fecha2, @spSucursal, @spEmpresa, @spUsuario, @spFecha, @Procesar
       END
 
--select @Trabajo Trabajo, @Usuario Usuario, @Contrasena Contrasena, @HoraInicial HoraInicial, @HoraFinal HoraFinal, @Frecuencia Frecuencia, @Valor Valor, @Recurrencia Recurrencia, @FrecuenciaD FrecuenciaD, @ValorD ValorD, @Activo Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @TrabajoID, @start_step_id = 1, @enabled  = @Activo
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @TrabajoID, @name = @Nombre, @enabled = @Activo, @freq_type = @Frecuencia, @active_start_date = @Fecha2, @active_start_time = @HoraInicial, @freq_interval = @Valor, @freq_subday_type = @FrecuenciaD , @freq_subday_interval = @ValorD, @freq_relative_interval = @Tipo, @freq_recurrence_factor = @Recurrencia, @active_end_date = 99991231, @active_end_time = @HoraFinal
 
    IF @ReturnCode = 0
         EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @TrabajoID, @server_name = @@SERVERNAME
 
 
  CLOSE crTrabajo
  DEALLOCATE crTrabajo
--select @ReturnCode = 1
  END 
  INSERT @SQLServerAgent (Estatus)
  EXEC master.dbo.xp_ServiceControl 'QUERYSTATE', 'SQLServerAgent'
 
  IF (SELECT TOP 1 Estatus FROM @SQLServerAgent) = 'Running.' SELECT @Estatus = 1 ELSE SELECT @Estatus = 0
 
  IF @ReturnCode = 0
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    COMMIT TRANSACTION
  END
  ELSE
  BEGIN
    IF @Estatus = 1 SELECT 'Proceso terminado.' ELSE SELECT 'Favor de verificar el servicio del Agente SQL Server para la ejecución del trabajo.'
    ROLLBACK TRANSACTION
  END
GO