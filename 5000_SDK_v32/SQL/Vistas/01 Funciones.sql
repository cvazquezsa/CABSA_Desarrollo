/* FUNCIONES */
SET ANSI_DEFAULTS OFF
GO

/**************** fnFechaRegistro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaRegistro') DROP FUNCTION fnFechaRegistro
GO
CREATE FUNCTION fnFechaRegistro(
				@Modulo		varchar(10),
				@ID int
)
RETURNS datetime
AS
BEGIN
DECLARE
			@FechaRegistro	datetime

  IF @Modulo = 'VTAS'  SELECT @FechaRegistro = FechaRegistro FROM Venta WHERE ID = @ID ELSE
  IF @Modulo = 'COMS'  SELECT @FechaRegistro = FechaRegistro FROM Compra WHERE ID = @ID ELSE
  IF @Modulo = 'PROD'  SELECT @FechaRegistro = FechaRegistro FROM Prod WHERE ID = @ID ELSE
  IF @Modulo = 'INV'   SELECT @FechaRegistro = FechaRegistro FROM Inv WHERE ID = @ID
  SELECT @FechaRegistro = dbo.fnFechasinhora(@FechaRegistro)

  RETURN @FechaRegistro
END
GO

/**************** fnRenglonID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRenglonID') DROP FUNCTION fnRenglonID
GO
CREATE FUNCTION fnRenglonID(
				@Modulo		varchar(10),
				@ID int,
				@Renglon float,
				@RenglonSub int
)
RETURNS int
AS
BEGIN
DECLARE
			@RenglonID	int

  IF @Modulo = 'VTAS'  SELECT @RenglonID = RenglonID FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
  IF @Modulo = 'COMS'  SELECT @RenglonID = RenglonID FROM CompraD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
  IF @Modulo = 'PROD'  SELECT @RenglonID = RenglonID FROM ProdD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub ELSE
  IF @Modulo = 'INV'   SELECT @RenglonID = RenglonID FROM InvD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub 

  RETURN @RenglonID
END
GO

/**************** fnFechaTrabajo ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaTrabajo') DROP FUNCTION fnFechaTrabajo
GO
CREATE FUNCTION fnFechaTrabajo 
	(
	@Empresa				varchar(5), 
	@Sucursal				int
	)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado				datetime

  SELECT @Resultado = FechaTrabajo 
    FROM FechaTrabajo 
   WHERE Empresa = @Empresa AND Sucursal = @Sucursal

  IF @Resultado IS NULL
  BEGIN
    SELECT @Resultado = dbo.fnFechaSinHora(GETDATE())
  END

  RETURN (@Resultado)
END
GO

/**************** fnInflacionActualDiaria ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnInflacionActualDiaria') DROP FUNCTION fnInflacionActualDiaria
GO
CREATE FUNCTION fnInflacionActualDiaria 
	(
	@Empresa			varchar(5),
	@Sucursal			int
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado				float,
  @FechaTrabajo				datetime,
  @FechaDiaAnterior			datetime,
  @ValorUDIDiaActual		float,
  @ValorUDIDiaAnterior		float,
  @ACConsiderarInflacionIVA	bit,
  @Moneda					varchar(10)
  
  SELECT @ACConsiderarInflacionIVA = ISNULL(ACConsiderarInflacionIVA,0), @Moneda = NULLIF(ACMonedaCalculoInflacionIVA,'') FROM EmpresaCfg WHERE Empresa = @Empresa

  IF @ACConsiderarInflacionIVA = 0 RETURN 0.0
    
  SET @FechaTrabajo = dbo.fnFechaSinHora(dbo.fnFechaTrabajo(@Empresa, @Sucursal))
  SET @FechaDiaAnterior = DATEADD(dd,-1,@FechaTrabajo)

  SELECT TOP 1 @ValorUDIDiaActual = TipoCambio FROM MonHist WHERE FechaSinHora = @FechaTrabajo AND Moneda = @Moneda AND Sucursal = @Sucursal ORDER BY ID DESC
  SELECT TOP 1 @ValorUDIDiaAnterior = TipoCambio FROM MonHist WHERE FechaSinHora = @FechaDiaAnterior AND Moneda = @Moneda AND Sucursal = @Sucursal ORDER BY ID DESC
  
  IF @ValorUDIDiaActual IS NULL OR @ValorUDIDiaAnterior IS NULL 
  BEGIN
    SET @Resultado = -1    
  END  
  ELSE
  BEGIN
    SET @Resultado = (@ValorUDIDiaActual / @ValorUDIDiaAnterior) - 1.0  
    IF @Resultado < 0.0 SET @Resultado = 0.0
  END  
    	
  RETURN (@Resultado)
END
GO

--spCerrarDia 'DEMO', 0, '26/07/2012'
--select dbo.fnInflacionActualDiaria('DEMO',0) --MEJORA10041
--IF (SELECT Version FROM Version) < 4600 UPDATE MonHist SET FechaSinHora = dbo.fnFechaSinHora(Fecha) WHERE FechaSinHora IS NULL --MEJORA10041

/**************** fnTasaRealDiaria ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTasaRealDiaria') DROP FUNCTION fnTasaRealDiaria
GO
CREATE FUNCTION fnTasaRealDiaria 
	(
	@TasaDiaria				float,
	@MoratoriosFactor		float,
	@Inflacion				float
	)
	
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @Resultado				float,
  @TasaRealDiaria			float
    	    	
  IF @TasaDiaria = -1
  BEGIN
    SET @Resultado = @TasaDiaria
  END  
  ELSE
  BEGIN
    SET @TasaRealDiaria = (@TasaDiaria * ISNULL(NULLIF(@MoratoriosFactor,0.0),1.0)) - @Inflacion
    IF @TasaRealDiaria < 0.0 SET @TasaRealDiaria = 0.0
    SET @Resultado = @TasaRealDiaria  
  END      	
  RETURN (@Resultado)
END
GO

--SELECT dbo.fnTasaRealDiaria(0.0166666666666667,0.0013)

/**************** fnTasaBase ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTasaBase') DROP FUNCTION fnTasaBase
GO
CREATE FUNCTION fnTasaBase 
	(
	@TasaBase1				varchar(50), 
	@TasaBase2				varchar(50),
	@TasaBase3				varchar(50)
	)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @Resultado			varchar(50)
  
  SELECT @Resultado = NULL

  SELECT @Resultado = Tasa FROM Tasa WHERE Tasa = @TasaBase1 AND Estatus = 'ALTA'
  IF @@ROWCOUNT = 0 
  BEGIN
    SELECT @Resultado = Tasa FROM Tasa WHERE Tasa = @TasaBase2 AND Estatus = 'ALTA'
    IF @@ROWCOUNT = 0
    BEGIN
      SELECT @Resultado = Tasa FROM Tasa WHERE Tasa = @TasaBase3 AND Estatus = 'ALTA'
    END 
  END  

  RETURN (@Resultado)
END
GO

/**************** fnTasaBaseDias ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTasaBaseDias') DROP FUNCTION fnTasaBaseDias
GO
CREATE FUNCTION fnTasaBaseDias 
	(
	@TasaBase				varchar(50)
	)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
  @Resultado			int
  
  SELECT @Resultado = NULL

  SELECT @Resultado = Dias FROM Tasa WHERE Tasa = @TasaBase AND Estatus = 'ALTA'

  RETURN (ISNULL(@Resultado,360)) -- BUG 14119
END
GO

/**************** fnTasaDiaria ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTasaDiaria') DROP FUNCTION fnTasaDiaria
GO
CREATE FUNCTION fnTasaDiaria 
	(
	@TipoTasa				varchar(20),
	@TieneTasaEsp			bit = 0,
	@TasaEsp				float = NULL
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha            	datetime,
    @EsTasaFija	      	bit,
    @TasaBase         	varchar(50),          -- TIIE 
    @TasaBase2        	varchar(50),          -- TIIE 
    @TasaBase3        	varchar(50),          -- TIIE 
    @TasaFija         	float,                -- Tasa Fija    
    @SobreTasaEn      	varchar(20),          -- Puntos / %
    @SobreTasa        	float,
    @RetencionPuntos	float,
    @ComisionPorcentaje	float,
    @TasaTotalMinima  	float,                -- Tasa Variable
    @TasaTotalMaxima  	float,                -- Tasa Variable
    @TasaDias         	int,
    @Mensaje          	varchar(255),
	@TasaDiaria			float,
	@TasaTotal			float    

  SELECT @EsTasaFija         = UPPER(EsTasaFija), 
         @TasaFija           = ISNULL(TasaFija, 0),
         @TasaBase           = TasaBase,
         @TasaBase2          = TasaBase2,
         @TasaBase3          = TasaBase3,
         @SobreTasaEn        = UPPER(SobreTasaEn),
         @SobreTasa          = ISNULL(SobreTasa, 0),
         @TasaTotalMinima    = NULLIF(TasaTotalMinima, 0),
         @TasaTotalMaxima    = NULLIF(TasaTotalMaxima, 0),
    	 @RetencionPuntos    = NULLIF(RetencionPuntos, 0),
         @ComisionPorcentaje = NULLIF(ComisionPorcentaje, 0)
    FROM TipoTasa
   WHERE TipoTasa = @TipoTasa

  SELECT @TasaBase = dbo.fnTasaBase(@TasaBase, @TasaBase2, @TasaBase3)
  SELECT @TasaDias = dbo.fnTasaBaseDias(@TasaBase)

  SELECT @TasaTotal = 0.0
  IF @TieneTasaEsp = 1
    SELECT @TasaTotal = @TasaEsp
  ELSE 
  IF @EsTasaFija = 1
    SELECT @TasaTotal = @TasaFija
  ELSE BEGIN
    SELECT @TasaTotal = ISNULL(Porcentaje, 0) FROM TasaD WHERE Tasa = @TasaBase AND Fecha = @Fecha
    IF @@ROWCOUNT = 0
      SELECT @TasaTotal = ISNULL(Porcentaje, 0) FROM Tasa WHERE Tasa = @TasaBase

    IF @SobreTasaEn = '%' 
      SELECT @TasaTotal = @TasaTotal * (1+(@SobreTasa/100.0))
    ELSE
      SELECT @TasaTotal = @TasaTotal + @SobreTasa

    IF @TasaTotalMinima IS NOT NULL AND @TasaTotal < @TasaTotalMinima SELECT @TasaTotal = @TasaTotalMinima
    IF @TasaTotalMaxima IS NOT NULL AND @TasaTotal > @TasaTotalMaxima SELECT @TasaTotal = @TasaTotalMaxima
  END

  IF @ComisionPorcentaje IS NOT NULL 
    SELECT @TasaTotal = @TasaTotal - (@TasaTotal * (@ComisionPorcentaje/100))

  IF @RetencionPuntos IS NOT NULL 
    SELECT @TasaTotal = @TasaTotal - @RetencionPuntos

  SELECT @TasaDiaria = @TasaTotal / @TasaDias

  RETURN (@TasaDiaria)
END
GO

/**************** fnInteresIVAImporte ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnInteresIVAImporte') DROP FUNCTION fnInteresIVAImporte
GO
CREATE FUNCTION fnInteresIVAImporte 
	(
	@TipoTasa			varchar(20),
	@TieneTasaEsp		bit = 0,
	@TasaEsp			float = NULL,	
	@Inflacion			float,
	@InteresImporte		float,
	@IVAPorcentaje		float,
	@Quita				float,
	@Moratorios			bit = 0
	)

RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @InteresIVAImporte		float,
  @TasaDiaria				float,
  @TasaRealDiaria			float,
  @MoratoriosFactor			float
  
  IF @Moratorios = 1
    SELECT @MoratoriosFactor = ISNULL(NULLIF(MoratoriosFactor,0.0),1.0) FROM TipoTasa WHERE TipoTasa = @TipoTasa
  ELSE 
    SELECT @MoratoriosFactor = 1.0  
    
  SET @Quita = ISNULL(@Quita,0.0)
  SET @Inflacion = ISNULL(@Inflacion,0.0)
  SET @InteresImporte = ISNULL(@InteresImporte,0.0) * (1-(@Quita/100.0))
  SET @IVAPorcentaje = ISNULL(@IVAPorcentaje,0.0)
  
  SET @InteresIVAImporte = -1
  
  SELECT @TasaDiaria = dbo.fnTasaDiaria(@TipoTasa,@TieneTasaEsp,@TasaEsp) * @MoratoriosFactor
  
  IF @TasaDiaria >= 0.0 AND @Inflacion >= 0.0
  BEGIN
      SET @TasaRealDiaria = dbo.fnTasaRealDiaria(@TasaDiaria, @MoratoriosFactor, @Inflacion)
      
    IF @InteresImporte >= 0.0 AND @IVAPorcentaje >= 0.0
    BEGIN
      SET @InteresIVAImporte = (@TasaRealDiaria/@TasaDiaria)*@InteresImporte*(@IVAPorcentaje/100.0)
    END  
  END
  
  RETURN @InteresIVAImporte
  
END
GO

--SELECT dbo.fnInteresIVAImporte('6%',0.0013,15.00,16.0,0.0,0)

/**************** fnImporteInflacion ****************/ --MEJORA10041
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteInflacion') DROP FUNCTION fnImporteInflacion
GO
CREATE FUNCTION fnImporteInflacion 
	(
	@TipoTasa			varchar(20),
	@TieneTasaEsp		bit = 0,
	@TasaEsp			float = NULL,	
	@Inflacion			float,
	@InteresImporte		float,
	@IVAPorcentaje		float,
	@Quita				float
	)

RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @ImporteInflacion			float,
  @TasaDiaria				float
      
  SET @Quita = ISNULL(@Quita,0.0)
  SET @Inflacion = ISNULL(@Inflacion,0.0)
  SET @InteresImporte = ISNULL(@InteresImporte,0.0) * (1-(@Quita/100.0))
  SET @IVAPorcentaje = ISNULL(@IVAPorcentaje,0.0) / 100.0
  
  SET @ImporteInflacion = 0.0
  
  SELECT @TasaDiaria = dbo.fnTasaDiaria(@TipoTasa,@TieneTasaEsp,@TasaEsp)
  
  IF @TasaDiaria > 0.0 AND @Inflacion >= 0.0
  BEGIN
    IF @Inflacion > @TasaDiaria
      SET @ImporteInflacion = 1.0
    ELSE
      SET @ImporteInflacion = (@Inflacion / @TasaDiaria) 
    
    SET @ImporteInflacion = @ImporteInflacion * @InteresImporte * @IVAPorcentaje
      
  END ELSE
  BEGIN
    SET @ImporteInflacion = -1.0
  END

  RETURN @ImporteInflacion
  
END
GO

/**************** fnCorreosAUsuarios ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCorreosAUsuarios') DROP FUNCTION fnCorreosAUsuarios --MEJORA5066
GO
CREATE FUNCTION fnCorreosAUsuarios 
	(
	@Correos				varchar(max) 
	)
RETURNS @Usuarios TABLE
        (
		Usuario			varchar(10)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
  @CorreosSobrantes				varchar(max),
  @Correo						varchar(255),
  @FinCorreo					bigint,
  @PosicionComa					bigint,
  @Usuario						varchar(10)
  
  
  DECLARE @UsuariosTemp TABLE
        (
		Usuario			varchar(10)
        )
  
  SET @CorreosSobrantes = ISNULL(@Correos,'')
  
  WHILE NULLIF(@CorreosSobrantes,'') IS NOT NULL
  BEGIN
    SET @PosicionComa = CHARINDEX(',',@CorreosSobrantes)
    IF @PosicionComa > 0
      SET @FinCorreo = @PosicionComa - 1
    ELSE   
      SET @FinCorreo = LEN(@CorreosSobrantes)
      
    SET @Correo = RTRIM(SUBSTRING(@CorreosSobrantes,1,@FinCorreo))
    
    IF @PosicionComa > 0 
      SET @CorreosSobrantes = SUBSTRING(@CorreosSobrantes,@PosicionComa + 1,LEN(@CorreosSobrantes))
    ELSE
      SET @CorreosSobrantes = ''
      
     INSERT @UsuariosTemp (Usuario)
     SELECT  
      NULLIF(Usuario,'')
      FROM Usuario 
     WHERE RTRIM(Email) = @Correo    

    INSERT @UsuariosTemp (Usuario)
    SELECT 
      u.Usuario
      FROM Personal p LEFT OUTER JOIN Usuario u
        ON u.Personal = p.Personal
     WHERE RTRIM(p.Email) = @Correo   

  END
  
  INSERT @Usuarios (Usuario)
  SELECT DISTINCT Usuario
    FROM @UsuariosTemp
   WHERE NULLIF(Usuario,'') IS NOT NULL 
  RETURN
END
GO

--SELECT * FROM dbo.fnCorreosAUsuarios('aromano@intelisis.com,aromanocohen@hotmail.com') 

/**************** fnModuloNombre ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnModuloNombre') DROP FUNCTION fnModuloNombre
GO
CREATE FUNCTION fnModuloNombre 
	(
	@Modulo				varchar(5)
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(100)

  SELECT @Resultado = RTRIM(Nombre) FROM Modulo WHERE Modulo = RTRIM(@Modulo) 
  RETURN (@Resultado)
END
GO

-- select dbo.fnEjercicioPeriodoEnValor(2009, 1)
/**************** fnEjercicioPeriodoEnValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEjercicioPeriodoEnValor') DROP FUNCTION fnEjercicioPeriodoEnValor
GO
CREATE FUNCTION fnEjercicioPeriodoEnValor (@Ejercicio int, @Periodo int)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  RETURN(@Ejercicio+(@Periodo/100.0))
END
GO

-- select dbo.fnMovTipo('VTAS', 'Pedido')
/**************** fnMovTipo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovTipo') DROP FUNCTION fnMovTipo
GO
CREATE FUNCTION fnMovTipo (@Modulo varchar(5), @Mov varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Clave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov)
END
GO

/**************** fnSubTotal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSubTotal') DROP FUNCTION fnSubTotal
GO
CREATE FUNCTION fnSubTotal (@Importe float, @DescuentoGlobal float, @SobrePrecio float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado float

  SELECT @Resultado = @Importe
  IF NULLIF(@DescuentoGlobal, 0) IS NOT NULL SELECT @Resultado = @Resultado - (@Importe * (@DescuentoGlobal/100.0))
  IF NULLIF(@SobrePrecio, 0)     IS NOT NULL SELECT @Resultado = @Resultado + (@Importe * (@SobrePrecio/100.0))

  RETURN(@Resultado)
END
GO

-- select dbo.fnDiaDelAno(GETDATE())
/**************** fnDiaDelAno ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiaDelAno') DROP FUNCTION fnDiaDelAno
GO
CREATE FUNCTION fnDiaDelAno (@Fecha datetime)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(DATEDIFF(day, dbo.fnIntToDateTime(31, 12, YEAR(@Fecha)-1), @Fecha))
END
GO


-- select dbo.fnMaxInt()
/**************** fnMaxInt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMaxInt') DROP FUNCTION fnMaxInt
GO
CREATE FUNCTION fnMaxInt ()
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(2147483647)
END
GO

/**************** fnConsecutivoEnMovID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnConsecutivoEnMovID') DROP FUNCTION fnConsecutivoEnMovID
GO
CREATE FUNCTION fnConsecutivoEnMovID (@Sucursal int, @Empresa varchar(5), @Modulo varchar(5), @Mov varchar(20), @Ejercicio int, @Periodo int, @Serie varchar(50), @Consecutivo bigint)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(CONVERT(varchar, @Consecutivo))
END
GO


-- select dbo.fnUnidadFactor('pza')
/**************** fnUnidadFactor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUnidadFactor') DROP FUNCTION fnUnidadFactor
GO
CREATE FUNCTION fnUnidadFactor (@Unidad varchar(50))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  SELECT @Resultado = 1.0
  IF NULLIF(RTRIM(@Unidad), '') IS NOT NULL 
    SELECT @Resultado = ISNULL(NULLIF(Factor, 0.0), 1.0) FROM Unidad WHERE Unidad = @Unidad

  RETURN(@Resultado)
END
GO

-- select dbo.fnArtUnidadFactor('DEMO', 'A1', 'pza')
/**************** fnArtUnidadFactor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArtUnidadFactor') DROP FUNCTION fnArtUnidadFactor
GO
CREATE FUNCTION fnArtUnidadFactor (@Empresa varchar(5), @Articulo varchar(20), @Unidad varchar(50))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			float,
    @CfgMultiUnidadesNivel	varchar(20)

  SELECT @CfgMultiUnidadesNivel = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2 
   WHERE Empresa = @Empresa

  SELECT @Resultado = NULL
  IF @CfgMultiUnidadesNivel = 'ARTICULO'
    SELECT @Resultado = NULLIF(Factor, 0.0)
      FROM ArtUnidad 
     WHERE Articulo = @Articulo AND Unidad = @Unidad

  IF @Resultado IS NULL
    SELECT @Resultado = dbo.fnUnidadFactor(@Unidad)

  RETURN(@Resultado)
END
GO



--select dbo.fnMovEstatusValor('PENDIENTE')
/**************** fnMovEstatusValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovEstatusValor') DROP FUNCTION fnMovEstatusValor
GO
CREATE FUNCTION fnMovEstatusValor (@Estatus varchar(20))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado int

  SELECT @Resultado = 0
  IF @Estatus = 'PLANTILLA'     SELECT @Resultado = 05 ELSE
  IF @Estatus = 'RECURRENTE'    SELECT @Resultado = 06 ELSE
  IF @Estatus = 'SINAFECTAR'    SELECT @Resultado = 10 ELSE
  IF @Estatus = 'SINCRO'    	SELECT @Resultado = 11 ELSE
  IF @Estatus = 'FUERALINEA'    SELECT @Resultado = 12 ELSE
  IF @Estatus = 'BORRADOR'      SELECT @Resultado = 13 ELSE
  IF @Estatus = 'CONFIRMADO'    SELECT @Resultado = 14 ELSE
  IF @Estatus = 'RECHAZADO'     SELECT @Resultado = 15 ELSE
  IF @Estatus = 'AUTORIZAR'     SELECT @Resultado = 16 ELSE
  IF @Estatus = 'AUTORIZARE'    SELECT @Resultado = 17 ELSE
  IF @Estatus = 'PROCESAR'      SELECT @Resultado = 20 ELSE
  IF @Estatus = 'PENDIENTE'     SELECT @Resultado = 30 ELSE
  IF @Estatus = 'ALTAPRIORIDAD' SELECT @Resultado = 31 ELSE
  IF @Estatus = 'PRIORIDADBAJA' SELECT @Resultado = 32 ELSE
  IF @Estatus = 'VIGENTE'       SELECT @Resultado = 33 ELSE
  IF @Estatus = 'POSFECHADO'    SELECT @Resultado = 34 ELSE
  IF @Estatus = 'CONCLUIDO'     SELECT @Resultado = 50 ELSE
  IF @Estatus = 'CANCELADO'     SELECT @Resultado = 90

  RETURN (@Resultado)
END
GO


-- select dbo.fnSumaDigitos(120)
/**************** fnSumaDigitos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSumaDigitos') DROP FUNCTION fnSumaDigitos
GO
CREATE FUNCTION fnSumaDigitos (@Veces int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a		int,
    @Resultado	int
 
  SELECT @a = 1, @Resultado = 0
  WHILE @a<=@Veces
  BEGIN
    SELECT @Resultado = @Resultado + @a
    SELECT @a = @a +1
  END  
  RETURN(@Resultado)
END
GO

-- select dbo.fnPorcentaje(200, 10)
/**************** fnPorcentaje ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPorcentaje') DROP FUNCTION fnPorcentaje
GO
CREATE FUNCTION fnPorcentaje (@Importe float, @Porcentaje float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Importe = NULLIF(@Importe, 0.0), @Porcentaje = NULLIF(@Porcentaje, 0.0)

  RETURN (@Importe*(@Porcentaje/100.0))
END
GO

-- select dbo.fnPorcentajeImporte(200, 20)
/**************** fnPorcentajeImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPorcentajeImporte') DROP FUNCTION fnPorcentajeImporte
GO
CREATE FUNCTION fnPorcentajeImporte (@Importe1 float, @Importe2 float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado float

  SELECT @Resultado = 0.0
  SELECT @Importe1 = NULLIF(@Importe1, 0.0), @Importe2 = NULLIF(@Importe2, 0.0)

  IF @Importe1 IS NOT NULL 
    SELECT @Resultado = (@Importe2/@Importe1)*100.0
  RETURN (@Resultado)
END
GO



-- select dbo.fnDisminuyePorcentaje(200, 0.0)
/**************** fnDisminuyePorcentaje ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDisminuyePorcentaje') DROP FUNCTION fnDisminuyePorcentaje
GO
CREATE FUNCTION fnDisminuyePorcentaje (@Importe float, @Porcentaje float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Importe = NULLIF(@Importe, 0.0), @Porcentaje = ISNULL(@Porcentaje, 0.0)

  RETURN (@Importe*((100.0-@Porcentaje)/100.0))
END
GO

-- select dbo.fnAumentaPorcentaje(200, 10)
/**************** fnAumentaPorcentaje ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAumentaPorcentaje') DROP FUNCTION fnAumentaPorcentaje
GO
CREATE FUNCTION fnAumentaPorcentaje (@Importe float, @Porcentaje float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Importe = NULLIF(@Importe, 0.0), @Porcentaje = ISNULL(@Porcentaje, 0.0)

  RETURN (@Importe*(1.0+(@Porcentaje/100.0)))
END
GO

-- select dbo.fnPrecioMargen(200, 10)
/**************** fnPrecioMargen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPrecioMargen') DROP FUNCTION fnPrecioMargen
GO
CREATE FUNCTION fnPrecioMargen (@Costo float, @Margen float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado float

  SELECT @Costo = ISNULL(@Costo, 0.0), @Margen = ISNULL(@Margen, 0.0)

  SELECT @Resultado = 0.0
  IF @Margen <> 100.0 
    SELECT @Resultado = (@Costo*100.0)/(100.0-@Margen)
  
  RETURN (@Resultado)
END
GO

/**************** fnImporteMargen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteMargen') DROP FUNCTION fnImporteMargen
GO
CREATE FUNCTION fnImporteMargen (@Importe float, @Costo float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado float

  SELECT @Resultado = 0.0
  SELECT @Importe = ISNULL(@Importe, 0.0), @Costo = ISNULL(@Costo, 0.0)

  IF @Importe <> 0.0 
    SELECT @Resultado = 100.0-((@Costo*100.0)/@Importe)

  RETURN (@Resultado)
END
GO

/**************** fnR3 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnR3') DROP FUNCTION fnR3
GO
CREATE FUNCTION fnR3 (@Cantidad1 float, @Importe1 float, @Cantidad2 float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  RETURN (NULLIF(@Cantidad2, 0) * NULLIF(@Importe1, 0) / NULLIF(@Cantidad1, 0))
END
GO

/**************** fnImporteSimilar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteSimilar') DROP FUNCTION fnImporteSimilar
GO
CREATE FUNCTION fnImporteSimilar (@Importe1 money, @Importe2 money)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF ROUND(@Importe1, 0) = ROUND(@Importe2, 0) OR
     ROUND(@Importe1, 1) = ROUND(@Importe2, 1) OR
     ROUND(@Importe1, 2) = ROUND(@Importe2, 2) 
    SELECT @Resultado = 1

  RETURN (@Resultado)
END
GO

/**************** fnMovTipoCambio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovTipoCambio') DROP FUNCTION fnMovTipoCambio
GO
CREATE FUNCTION fnMovTipoCambio (@Moneda char(10), @MovMoneda char(10), @MovTipoCambio float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  IF @Moneda = @MovMoneda 
    SELECT @Resultado = @MovTipoCambio 
  ELSE
    SELECT @Resultado = TipoCambio FROM Mon WHERE Moneda = @Moneda
  RETURN (@Resultado)
END
GO

-- fnFechaSinHora 
-- se movio a Previo Tablas

-- select dbo.fnFechaConHora(getdate(), '1015')
/**************** fnFechaConHora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFechaConHora' AND type = 'FN') DROP FUNCTION fnFechaConHora
GO
CREATE FUNCTION fnFechaConHora (@Fecha	datetime, @Hora varchar(5))
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime,
    @h		int,
    @m		int

  SELECT @Resultado = dbo.fnFechaSinHora(@Fecha)
  SELECT @Hora = NULLIF(RTRIM(@Hora), '')
  IF @Hora IS NOT NULL
  BEGIN
    SELECT @h = CONVERT(int, SUBSTRING(@Hora, 1, 2)), @m = CONVERT(int, SUBSTRING(@Hora, 4, 2))
    SELECT @Resultado = DATEADD(hh, @h, DATEADD(mi, @m, @Resultado))
  END
  RETURN (@Resultado)
END
GO


-- select dbo.fnExtraerHora(GETDATE())
/**************** fnExtraerHora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerHora' AND type = 'FN') DROP FUNCTION fnExtraerHora
GO
CREATE FUNCTION fnExtraerHora (@Fecha	datetime)
RETURNS varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SUBSTRING(CONVERT(varchar(10), @Fecha, 108), 1, 5))
END
GO

/**************** fnEstaVigente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaVigente') DROP FUNCTION fnEstaVigente
GO
CREATE FUNCTION fnEstaVigente (@Fecha datetime, @Desde datetime, @Hasta datetime)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  IF @Fecha BETWEEN ISNULL(@Desde, @Fecha) AND ISNULL(@Hasta, @Fecha) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
  RETURN (@Resultado)
END
GO

/**************** fnEstaVencido ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaVencido') DROP FUNCTION fnEstaVencido
GO
CREATE FUNCTION fnEstaVencido (@Fecha datetime, @Hasta datetime)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  IF @Fecha > ISNULL(@Hasta, @Fecha) SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
  RETURN (@Resultado)
END
GO


--SET DATEFIRST 7
-- select dbo.fnDiaSemanaEspanol(getdate())
/**************** fnEstaVigenteAvanzado ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstaVigenteAvanzado') DROP FUNCTION fnEstaVigenteAvanzado
GO
CREATE FUNCTION fnEstaVigenteAvanzado (@FechaHora datetime, @Desde datetime, @Hasta datetime, @HoraD varchar(5), @HoraA varchar(5), @DiasEsp varchar(50))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit,
    @Fecha      datetime,
    @Hora	varchar(5)

  SELECT @Resultado = 0, @HoraD = NULLIF(RTRIM(@HoraD), ''), @HoraA = NULLIF(RTRIM(@HoraA), ''), @DiasEsp = NULLIF(RTRIM(@DiasEsp), '')
  SELECT @Fecha = dbo.fnFechaSinHora(@FechaHora)
  IF @Fecha BETWEEN ISNULL(@Desde, @Fecha) AND ISNULL(@Hasta, @Fecha) 
  BEGIN
    SELECT @Hora = dbo.fnExtraerHora(@FechaHora)
    IF @Hora BETWEEN ISNULL(@HoraD, @Hora) AND ISNULL(@HoraA, @Hora)
    BEGIN
      IF @DiasEsp IS NULL OR EXISTS(SELECT * FROM DiasEspD WHERE DiasEsp = @DiasEsp AND Dia = dbo.fnDiaSemanaEspanol(@FechaHora))
        SELECT @Resultado = 1
      IF @DiasEsp IS NULL OR EXISTS(SELECT * FROM DiasEspD WHERE DiasEsp = @DiasEsp AND ISNUMERIC(Dia) = 1 AND CASE WHEN ISNUMERIC(Dia) = 1 THEN Dia ELSE 0 END = DATEPART(dd,@FechaHora))
        SELECT @Resultado = 1
    END
  END
  RETURN (@Resultado)
END
GO

-- select dbo.fnEsFinMes('2/1/1')
/**************** fnEsFinMes ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsFinMes') DROP FUNCTION fnEsFinMes
GO
CREATE FUNCTION fnEsFinMes (@Fecha datetime)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit,
    @Dia	int, 
    @Dias	int, 
    @Mes	int, 
    @Ano	int

  SELECT @Dia = DAY(@Fecha),
         @Mes = MONTH(@Fecha),
         @Ano = YEAR(@Fecha)

  SELECT @Dias = 0
  IF @Mes IN (1,3,5,7,8,10,12) 
    SELECT @Dias = 31  
  ELSE 
  IF @Mes IN (4,6,9,11)        
    SELECT @Dias = 30 
  ELSE
  IF @Mes = 2                  
  BEGIN 
    IF @Ano % 4 = 0 
      SELECT @Dias = 29 
    ELSE SELECT @Dias = 28 
  END

  IF @Dias = @Dia SELECT @Resultado = 1 ELSE SELECT @Resultado = 0 
  RETURN (@Resultado)
END
GO


-- select dbo.fnTieneAlfa('12345678')
/**************** fnTieneAlfa ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTieneAlfa') DROP FUNCTION fnTieneAlfa
GO
CREATE FUNCTION fnTieneAlfa (@Clave varchar(100))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit,
    @l		int,
    @p		int

  SELECT @Resultado = 0, @p = 1, @l = LEN(@Clave)
  WHILE @p<=@l AND @Resultado = 0
    IF SUBSTRING(@Clave, @p, 1) NOT BETWEEN '0' AND '9' 
      SELECT @Resultado = 1 
    ELSE SELECT @p = @p + 1

  RETURN (@Resultado)
END
GO

-- select dbo.fnTieneNumero('DEMODEMO1')
/**************** fnTieneNumero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTieneNumero') DROP FUNCTION fnTieneNumero
GO
CREATE FUNCTION fnTieneNumero (@Clave varchar(100))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit,
    @l		int,
    @p		int

  SELECT @Resultado = 0, @p = 1, @l = LEN(@Clave)
  WHILE @p<=@l AND @Resultado = 0
    IF SUBSTRING(@Clave, @p, 1) BETWEEN '0' AND '9' 
      SELECT @Resultado = 1 
    ELSE SELECT @p = @p + 1

  RETURN (@Resultado)
END
GO


/**************** fnMenor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMenor') DROP FUNCTION fnMenor
GO
CREATE FUNCTION fnMenor (@Cantidad1 float, @Cantidad2 float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  IF @Cantidad1 < @Cantidad2
    SELECT @Resultado = @Cantidad1
  ELSE
    SELECT @Resultado = @Cantidad2

  RETURN (@Resultado)
END
GO

/**************** fnMayor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMayor') DROP FUNCTION fnMayor
GO
CREATE FUNCTION fnMayor (@Cantidad1 float, @Cantidad2 float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  IF @Cantidad1 > @Cantidad2
    SELECT @Resultado = @Cantidad1
  ELSE
    SELECT @Resultado = @Cantidad2

  RETURN (@Resultado)
END
GO


--select dbo.fnImporteEnMN(100, 'Dolar')
/**************** fnImporteEnMN ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteEnMN') DROP FUNCTION fnImporteEnMN
GO
CREATE FUNCTION fnImporteEnMN (@Importe money, @Moneda char(10))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SELECT @Importe*TipoCambio FROM Mon WHERE Moneda = @Moneda)
END
GO

--select dbo.fnMNEnImporte(1150, 'Dolar')
/**************** fnMNEnImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMNEnImporte') DROP FUNCTION fnMNEnImporte
GO
CREATE FUNCTION fnMNEnImporte (@Importe money, @Moneda char(10))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SELECT @Importe/TipoCambio FROM Mon WHERE Moneda = @Moneda)
END
GO

-- select dbo.fnJuntarDescuentos(50, 50)
/**************** fnJuntarDescuentos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnJuntarDescuentos') DROP FUNCTION fnJuntarDescuentos
GO
CREATE FUNCTION fnJuntarDescuentos (@Desc1 float, @Desc2 float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  RETURN (100.0-(((100.0-ISNULL(@Desc1, 0))/100.0 * (100.0-ISNULL(@Desc2, 0))/100.0)*100.0))
END
GO

/**************** fnMoratoriosTasaDiaria ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMoratoriosTasaDiaria' AND type = 'FN') DROP FUNCTION fnMoratoriosTasaDiaria
GO
CREATE FUNCTION fnMoratoriosTasaDiaria(@Empresa char(5), @Saldo money, @FechaD datetime, @FechaA datetime)
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  RETURN (SELECT SUM(@Saldo*(Plazo2Tasa/100)) FROM EmpresaCostoPiso WHERE Empresa = @Empresa AND Fecha BETWEEN @FechaD AND @FechaA)
END
GO

/**************** fnCantidadLote ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCantidadLote' AND type = 'TF') DROP FUNCTION fnCantidadLote
GO
CREATE FUNCTION fnCantidadLote (@Empresa char(5), @Almacen char(10), @Articulo char(20), @SubCuenta varchar(50), @Lotes int, @Orden varchar(20))
RETURNS @Resultado TABLE (SerieLote varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @SerieLote	varchar(50)

  SELECT @Conteo = 0
  IF @Orden = 'DESCENDENTE'
    DECLARE crSerieLote CURSOR
        FOR SELECT SerieLote
              FROM SerieLote
             WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')
               AND NULLIF(Existencia, 0) IS NOT NULL
             ORDER BY SerieLote DESC
  ELSE
    DECLARE crSerieLote CURSOR
        FOR SELECT SerieLote
              FROM SerieLote
             WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')
               AND NULLIF(Existencia, 0) IS NOT NULL
             ORDER BY SerieLote ASC
  OPEN crSerieLote
  FETCH NEXT FROM crSerieLote INTO @SerieLote
  WHILE @@FETCH_STATUS <> -1 AND @Conteo < @Lotes
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      INSERT @Resultado VALUES (@SerieLote)
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crSerieLote INTO @SerieLote
  END  -- While
  CLOSE crSerieLote
  DEALLOCATE crSerieLote
  RETURN 
END
GO

-- select * from dbo.fnCantidadLote('DEMO', 'STOCK', 'L1', NULL, 3)
-- select dbo.fnSerieLoteCalidad(Empresa, Articulo, SubCuenta, SerieLote), * from serielote 
-- select dbo.fnSerieLoteCalidad('DEMO', 'L1', '', 'MX100')

/**************** fnSerieLoteCalidad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteCalidad' AND type = 'FN') DROP FUNCTION fnSerieLoteCalidad
GO
CREATE FUNCTION fnSerieLoteCalidad (@Empresa char(5), @Articulo	varchar(20), @SubCuenta varchar(50), @SerieLote varchar(50))
RETURNS varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Salir	bit,
    @Evaluacion	varchar(50),
    @Valor	float,
    @Minimo	float,
    @Maximo	float,
    @Estatus	varchar(15)

  IF EXISTS(SELECT * FROM SerieLoteAutorizacion WHERE Empresa = @Empresa AND SerieLote = @SerieLote AND NULLIF(RTRIM(Autorizacion), '') IS NOT NULL)
    RETURN ('AUTORIZADO')

  SELECT @Estatus = 'PENDIENTE', @Salir = NULL
  DECLARE crCalidad CURSOR
      FOR SELECT sc.Evaluacion, sc.Valor, ac.Minimo, ac.Maximo
            FROM SerieLoteCalidad sc
            LEFT OUTER JOIN ArtCalidad ac ON ac.Articulo = sc.Articulo AND ac.Evaluacion = sc.Evaluacion
           WHERE sc.Empresa = @Empresa AND sc.Articulo = @Articulo AND sc.SubCuenta = ISNULL(@SubCuenta, '') AND sc.SerieLote = @SerieLote
  OPEN crCalidad
  FETCH NEXT FROM crCalidad INTO @Evaluacion, @Valor, @Minimo, @Maximo
  WHILE @@FETCH_STATUS <> -1 AND ISNULL(@Salir, 0) = 0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Valor IS NULL SELECT @Salir = 1 ELSE
      IF @Valor NOT BETWEEN @Minimo AND @Maximo SELECT @Estatus = 'RECHAZADO', @Salir = 1 ELSE
      SELECT @Salir = 0
    END
    FETCH NEXT FROM crCalidad INTO @Evaluacion, @Valor, @Minimo, @Maximo
  END  -- While
  CLOSE crCalidad
  DEALLOCATE crCalidad
  IF @Salir = 0 SELECT @Estatus = 'APROBADO'
  RETURN (@Estatus)
END
GO


-- select * from fnSerieLoteMovParcial ('DEMO', 'INV', 16, 'L1', NULL, 6)
/**************** fnSerieLoteMovParcial ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteMovParcial' AND type = 'TF') DROP FUNCTION fnSerieLoteMovParcial
GO
CREATE FUNCTION fnSerieLoteMovParcial (@Empresa char(5), @Modulo char(5), @ID int, @Articulo char(20), @SubCuenta varchar(50), @Cantidad float)
RETURNS @Resultado TABLE (SerieLote varchar(50), Cantidad float NULL, ArtCostoInv money)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SerieLote		varchar(50),
    @CantidadTotal	float,
    @SerieLoteCantidad	float,
    @ArtCostoInv	money

  SELECT @CantidadTotal = 0.0
  DECLARE crSerieLoteMov CURSOR
      FOR SELECT SerieLote, Cantidad, ArtCostoInv
            FROM SerieLoteMov
           WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '')
  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @SerieLoteCantidad, @ArtCostoInv
  WHILE @@FETCH_STATUS <> -1 AND @CantidadTotal < @Cantidad
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @CantidadTotal + @SerieLoteCantidad > @Cantidad SELECT @SerieLoteCantidad = @Cantidad - @CantidadTotal
      INSERT @Resultado VALUES (@SerieLote, @SerieLoteCantidad, @ArtCostoInv)
      SELECT @CantidadTotal = @CantidadTotal + @SerieLoteCantidad
    END
    FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @SerieLoteCantidad, @ArtCostoInv
  END  -- While
  CLOSE crSerieLoteMov
  DEALLOCATE crSerieLoteMov
  RETURN 
END
GO

-- select * from fnSerieLoteMovParcialConExistencia ('DEMO', 'INV', 16, 'L1', NULL, 6, 'STOCK')
/**************** fnSerieLoteMovParcialConExistencia ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteMovParcialConExistencia' AND type = 'TF') DROP FUNCTION fnSerieLoteMovParcialConExistencia
GO
CREATE FUNCTION fnSerieLoteMovParcialConExistencia (@Empresa char(5), @Modulo char(5), @ID int, @Articulo char(20), @SubCuenta varchar(50), @Cantidad float, @Almacen char(10))
RETURNS @Resultado TABLE (SerieLote varchar(50), Cantidad float NULL, ArtCostoInv money)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @SerieLote		varchar(50),
    @CantidadTotal	float,
    @SerieLoteCantidad	float,
    @Existencia		float,
    @ArtCostoInv	money

  SELECT @CantidadTotal = 0.0
  DECLARE crSerieLoteMov CURSOR
      FOR SELECT slm.SerieLote, slm.Cantidad, slm.ArtCostoInv, sl.Existencia
            FROM SerieLoteMov slm
            JOIN SerieLote sl ON sl.Empresa = @Empresa AND sl.Almacen = @Almacen AND sl.Articulo = @Articulo AND sl.SubCuenta = ISNULL(@SubCuenta, '') AND sl.SerieLote = slm.SerieLote AND ISNULL(sl.Existencia, 0) > 0
           WHERE slm.Empresa = @Empresa AND slm.Modulo = @Modulo AND slm.ID = @ID AND slm.Articulo = @Articulo AND slm.SubCuenta = ISNULL(@SubCuenta, '')
  OPEN crSerieLoteMov
  FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @SerieLoteCantidad, @ArtCostoInv, @Existencia
  WHILE @@FETCH_STATUS <> -1 AND @CantidadTotal < @Cantidad
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Existencia < @SerieLoteCantidad SELECT @SerieLoteCantidad = @Existencia
      IF @CantidadTotal + @SerieLoteCantidad > @Cantidad SELECT @SerieLoteCantidad = @Cantidad - @CantidadTotal
      INSERT @Resultado VALUES (@SerieLote, @SerieLoteCantidad, @ArtCostoInv)
      SELECT @CantidadTotal = @CantidadTotal + @SerieLoteCantidad
    END
    FETCH NEXT FROM crSerieLoteMov INTO @SerieLote, @SerieLoteCantidad, @ArtCostoInv, @Existencia
  END  -- While
  CLOSE crSerieLoteMov
  DEALLOCATE crSerieLoteMov
  RETURN 
END
GO

-- select * from dbo.fnSerieLoteMovDelAl('DEMO', 'VTAS', 26, 1, 'BA', NULL, 'MX107', 3)
/**************** fnSerieLoteMovDelAl ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteMovDelAl' AND type = 'TF') DROP FUNCTION fnSerieLoteMovDelAl
GO
CREATE FUNCTION fnSerieLoteMovDelAl (@Empresa char(5), @Modulo char(5), @ID int, @RenglonID int, @Articulo char(20), @SubCuenta varchar(50), @SerieLote varchar(50), @Cantidad int)
RETURNS @Resultado TABLE (SerieLoteD varchar(50), SerieLoteA varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Conteo	int,
    @SerieLoteD	varchar(50),
    @SerieLoteA	varchar(50)

  SELECT @Conteo = 1, @SerieLoteD = NULL, @SerieLoteA = NULL
  DECLARE crfnSerieLoteMov CURSOR FOR
   SELECT SerieLote
     FROM SerieLoteMov 
    WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID AND RenglonID = @RenglonID AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
      AND SerieLote > ISNULL(@SerieLote, '')

  OPEN crfnSerieLoteMov
  FETCH NEXT FROM crfnSerieLoteMov INTO @SerieLoteA
  WHILE @@FETCH_STATUS <> -1 AND @Conteo < @Cantidad
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Conteo = 1 SELECT @SerieLoteD = @SerieLoteA
      SELECT @Conteo = @Conteo + 1
    END
    FETCH NEXT FROM crfnSerieLoteMov INTO @SerieLoteA
  END -- While
  CLOSE crfnSerieLoteMov
  DEALLOCATE crfnSerieLoteMov

  INSERT @Resultado VALUES (@SerieLoteD, @SerieLoteA)
  RETURN 
END
GO


/**************** fnIDMov ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIDMov' AND type = 'FN') DROP FUNCTION fnIDMov
GO
CREATE FUNCTION fnIDMov (@Empresa char(5), @Modulo char(5), @Mov varchar(20), @MovID varchar(50))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID	int

  SELECT @ID = NULL
  IF @Modulo = 'VTAS'  SELECT @ID = MAX(ID) FROM Venta      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'PROD'  SELECT @ID = MAX(ID) FROM Prod       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'COMS'  SELECT @ID = MAX(ID) FROM Compra     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'CXC'   SELECT @ID = MAX(ID) FROM Cxc        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'CXP'   SELECT @ID = MAX(ID) FROM Cxp        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'AGENT' SELECT @ID = MAX(ID) FROM Agent      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'INV'   SELECT @ID = MAX(ID) FROM Inv        WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'GAS'   SELECT @ID = MAX(ID) FROM Gasto      WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'DIN'   SELECT @ID = MAX(ID) FROM Dinero     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'CONT'  SELECT @ID = MAX(ID) FROM Cont       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'EMB'   SELECT @ID = MAX(ID) FROM Embarque   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'NOM'   SELECT @ID = MAX(ID) FROM Nomina     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'RH'    SELECT @ID = MAX(ID) FROM RH         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'ASIS'  SELECT @ID = MAX(ID) FROM Asiste     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'AF'    SELECT @ID = MAX(ID) FROM ActivoFijo WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'PC'    SELECT @ID = MAX(ID) FROM PC         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'VALE'  SELECT @ID = MAX(ID) FROM Vale       WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'CR'    SELECT @ID = MAX(ID) FROM CR         WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'ST'    SELECT @ID = MAX(ID) FROM Soporte    WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') ELSE
  IF @Modulo = 'CAM'   SELECT @ID = MAX(ID) FROM Cambio     WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus NOT IN ('SINAFECTAR', 'CONFIRMAR', 'BORRADOR', 'CANCELADO') 

  RETURN (@ID)
END
GO

/**************** fnVINValidarCh ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVINValidarCh' AND type = 'FN') DROP FUNCTION fnVINValidarCh
GO
CREATE FUNCTION fnVINValidarCh (@Ch char(1))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN (
    CASE @ch 
      WHEN 'A' THEN 1
      WHEN 'B' THEN 2
      WHEN 'C' THEN 3
      WHEN 'D' THEN 4
      WHEN 'E' THEN 5
      WHEN 'F' THEN 6
      WHEN 'G' THEN 7
      WHEN 'H' THEN 8
      WHEN 'J' THEN 1
      WHEN 'K' THEN 2
      WHEN 'L' THEN 3
      WHEN 'M' THEN 4
      WHEN 'N' THEN 5
      WHEN 'P' THEN 7
      WHEN 'R' THEN 9
      WHEN 'S' THEN 2
      WHEN 'T' THEN 3
      WHEN 'U' THEN 4
      WHEN 'V' THEN 5
      WHEN 'W' THEN 6
      WHEN 'X' THEN 7
      WHEN 'Y' THEN 8
      WHEN 'Z' THEN 9
      ELSE CONVERT(int, @ch)
  END)
END
GO

-- select dbo.fnVINValidarPos(10)
/**************** fnVINValidarPos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVINValidarPos' AND type = 'FN') DROP FUNCTION fnVINValidarPos
GO
CREATE FUNCTION fnVINValidarPos (@p int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN (
    CASE @p
      WHEN  1 THEN 8
      WHEN  2 THEN 7
      WHEN  3 THEN 6
      WHEN  4 THEN 5
      WHEN  5 THEN 4
      WHEN  6 THEN 3
      WHEN  7 THEN 2
      WHEN  8 THEN 10
      WHEN 10 THEN 9
      WHEN 11 THEN 8
      WHEN 12 THEN 7
      WHEN 13 THEN 6
      WHEN 14 THEN 5
      WHEN 15 THEN 4
      WHEN 16 THEN 3
      WHEN 17 THEN 2
      ELSE NULL
  END)
END
GO


-- select dbo.fnVINValidar('1B4HR28N71F539764')
/**************** fnVINValidar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVINValidar' AND type = 'FN') DROP FUNCTION fnVINValidar
GO
CREATE FUNCTION fnVINValidar (@VIN varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @r        bit,
    @a        int,
    @Ch        char(1),
    @Total    float,
    @Total11  float

  SELECT @a = 1, @Total = 0.0
  WHILE @a<18
  BEGIN
    IF @a<>9 
      SELECT @Total = @Total + (dbo.fnVINValidarPos(@a) * dbo.fnVINValidarCh(SUBSTRING(@VIN, @a, 1)))
    SELECT @a = @a + 1
  END
  SELECT @Total11 = @Total / 11
  SELECT @a = @Total - (FLOOR(@Total11) * 11)


  IF @a = 10 SELECT @Ch = 'X' ELSE SELECT @Ch = CONVERT(char, @a)
  IF LEN(@VIN) = 17 AND SUBSTRING(@VIN, 9, 1) = @Ch 
    SELECT @r = 1
  ELSE
    SELECT @r = 0

  RETURN (@r)
END
GO

-- select dbo.fnUPCValidar('7502123450197')
-- select dbo.fnUPCValidar('A1')
/**************** fnUPCValidar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUPCValidar' AND type = 'FN') DROP FUNCTION fnUPCValidar
GO
CREATE FUNCTION fnUPCValidar (@UPC varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @r          bit,
    @a        	int,
    @valor	int,
    @por3	bit,
    @Ch       	char(1),
    @Total	int

  SELECT @r = 0
  IF dbo.fnEsNumerico(@UPC) = 1 AND LEN(@UPC) IN (13, 8)
  BEGIN
    SELECT @a = LEN(@UPC)-1, @Total = 0, @por3 = 1
    WHILE @a>0
    BEGIN
      SELECT @valor = CONVERT(int, SUBSTRING(@UPC, @a, 1))
      IF @por3 = 1 SELECT @valor = @valor * 3
      SELECT @por3 = ~@por3
      SELECT @Total = @Total + @valor
      SELECT @a = @a - 1
    END
    SELECT @Total = 10 - (@Total % 10)
    IF @Total = 10 SELECT @Total = 0
    SELECT @Ch = CONVERT(char, @Total)

    IF SUBSTRING(@UPC, LEN(@UPC), 1) = @Ch 
      SELECT @r = 1
  END
  RETURN (@r)
END
GO




/**************** fnDiasMes ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiasMes' AND type = 'FN') DROP FUNCTION fnDiasMes
GO
CREATE FUNCTION fnDiasMes (@Mes int, @Ano int)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Dias        int

  SELECT @Dias = 0
  IF @Mes IN (1,3,5,7,8,10,12) 
    SELECT @Dias = 31  
  ELSE 
  IF @Mes IN (4,6,9,11)        
    SELECT @Dias = 30 
  ELSE
  IF @Mes = 2                  
  BEGIN 
    IF @Ano % 4 = 0 
      SELECT @Dias = 29 
    ELSE SELECT @Dias = 28 
  END

  RETURN (@Dias)
END 
GO

-- select dbo.fnIntToDateTime(1,1,2004)
/**************** fnIntToDateTime ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIntToDateTime' AND type = 'FN') DROP FUNCTION fnIntToDateTime
GO
CREATE FUNCTION fnIntToDateTime (@Dia int, @Mes int, @Ano int)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  RETURN (CONVERT(datetime, CONVERT(varchar, @Dia) + '/' + CONVERT(varchar, @Mes) + '/' + CONVERT(varchar, @Ano), 103))
END
GO

/**************** fnEsDiaHabil ****************/
-- Hay que poner SET DATEFIRST 7 Antes de Ejecutar
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsDiaHabil' AND type = 'FN') DROP FUNCTION fnEsDiaHabil
GO
CREATE FUNCTION fnEsDiaHabil (@Fecha datetime)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado        bit

  SELECT @Resultado = 1
  IF DATEPART(weekday, @Fecha) IN (1, 7) SELECT @Resultado = 0 ELSE
  IF EXISTS(SELECT * FROM DiaFestivo WHERE Fecha = @Fecha) SELECT @Resultado = 0 
  RETURN (@Resultado)
END
GO

/**************** fnChecarDiaHabil ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnChecarDiaHabil' AND type = 'FN') DROP FUNCTION fnChecarDiaHabil
GO
CREATE FUNCTION fnChecarDiaHabil (@Fecha datetime, @Recorrer int)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN  
  IF ISNULL(@Recorrer, 0) IN (1, -1)
  BEGIN
    WHILE (dbo.fnEsDiaHabil(@Fecha) = 0)
      IF @Recorrer = 1 
        SELECT @Fecha = DATEADD(day, 1, @Fecha) 
      ELSE
      IF @Recorrer = -1
        SELECT @Fecha = DATEADD(day, -1, @Fecha) 
  END

  RETURN (@Fecha)
END
GO

-- select *, "Dias" = DATEDIFF(day, FechaD, FechaA)  from dbo.fnProyectarFecha('13/10/4', '13/10/5', 0, 'DIA ESPECIFICO', 13, 1)
/**************** fnProyectarFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnProyectarFecha' AND type = 'TF') DROP FUNCTION fnProyectarFecha
GO
CREATE FUNCTION fnProyectarFecha (@FechaD datetime, @FechaA datetime, @RecorrerVencimiento int, @TipoVencimiento varchar(20), @Dias int, @MinimoDias int, @TipoAmortizacion varchar(20))
RETURNS @Resultado TABLE (Periodo int, FechaD datetime, FechaA datetime)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a		int,
    @Periodo    int,
    @UltFecha   datetime,
    @Fecha      datetime,
    @FechaHabil datetime,
    @Dia        int,
    @DiasMes    int,
    @Mes        int,
    @Ano        int,
    @UFechaD    datetime,
    @UFechaA    datetime,
    @UPeriodo   int,
    @FinMes		bit,
    @PagoQ1		int,
    @PagoQ2		int,
    @FechaPago1 datetime,
    @FechaPAgo2 datetime,
    @FechaHabilF datetime,
    @DiasIncluirUltima	bit

  SELECT @Periodo = 1, @Fecha = @FechaD, @TipoVencimiento = UPPER(@TipoVencimiento)

  SELECT @UltFecha = @Fecha
  WHILE @Fecha <= @FechaA
  BEGIN
    IF @TipoVencimiento = 'DIAS'
    BEGIN
      SELECT @DiasIncluirUltima = DiasIncluirUltima FROM TipoAmortizacion WHERE TipoAmortizacion = @TipoAmortizacion

      SELECT @Fecha = DATEADD(day, @Dias, @Fecha)
	  IF @DiasIncluirUltima = 1
	  BEGIN
		IF @UltFecha BETWEEN @FechaD AND @FechaA AND DATEADD(day, FLOOR(@Dias/2), @FechaA) >  @Fecha
		BEGIN
	      SELECT @Fecha = dbo.fnChecarDiaHabil(@Fecha, @RecorrerVencimiento)
		  INSERT @Resultado VALUES (@Periodo, @UltFecha, @Fecha)
		  SELECT @UltFecha = @Fecha
		END
	  END ELSE
      IF @Fecha BETWEEN @FechaD AND @FechaA 
      BEGIN
        SELECT @Fecha = dbo.fnChecarDiaHabil(@Fecha, @RecorrerVencimiento)
        INSERT @Resultado VALUES (@Periodo, @UltFecha, @Fecha)
        SELECT @UltFecha = @Fecha
      END
    END ELSE
    IF @TipoVencimiento = 'DIA ESPECIFICO'
    BEGIN
      SELECT @Mes = MONTH(@Fecha), @Ano = YEAR(@Fecha)
      SELECT @DiasMes = dbo.fnDiasMes(@Mes, @Ano)
      IF @Dias>@DiasMes 
        SELECT @Fecha = dbo.fnIntToDateTime(@DiasMes, @Mes, @Ano) 
      ELSE
        SELECT @Fecha = dbo.fnIntToDateTime(@Dias, @Mes, @Ano) 
      IF @Fecha BETWEEN @FechaD AND @FechaA 
      BEGIN
        SELECT @FechaHabil = dbo.fnChecarDiaHabil(@Fecha, @RecorrerVencimiento)
        INSERT @Resultado VALUES (@Periodo, @UltFecha, @FechaHabil)
        SELECT @UltFecha = @FechaHabil
      END
      SELECT @Fecha = DATEADD(month, 1, @Fecha)
    END ELSE
    IF @TipoVencimiento = 'FIN DE MES'
    BEGIN
      SELECT @Dia = DAY(@Fecha), @Mes = MONTH(@Fecha), @Ano = YEAR(@Fecha)
      SELECT @DiasMes = dbo.fnDiasMes(@Mes, @Ano)
      SELECT @Fecha = dbo.fnIntToDateTime(@DiasMes, @Mes, @Ano) 
      IF @Fecha BETWEEN @FechaD AND @FechaA 
      BEGIN
        SELECT @FechaHabil = dbo.fnChecarDiaHabil(@Fecha, @RecorrerVencimiento)
        INSERT @Resultado VALUES (@Periodo, @UltFecha, @FechaHabil)
        SELECT @UltFecha = @FechaHabil
      END
      SELECT @Fecha = DATEADD(month, 1, @Fecha)
    END ELSE
	IF @TipoVencimiento = 'QUINCENAL'
	BEGIN
		SELECT	@FinMes = FinMes, 
				@PagoQ1 = ISNULL(PagoDiasQ1,0), 
				@PagoQ2 = ISNULL(PagoDiasQ2,0) 
		FROM TipoAmortizacion 
		WHERE TipoAmortizacion = @TipoAmortizacion
		
		SELECT @Mes = MONTH(@Fecha), @Ano = YEAR(@Fecha)
		
		IF @FinMes = 1
		BEGIN
			SELECT @DiasMes = dbo.fnDiasMes(@Mes, @Ano)
			SELECT @FechaPago1 = dbo.fnIntToDateTime(15, @Mes, @Ano),
				   @FechaPago2 = dbo.fnIntToDateTime(@DiasMes, @Mes, @Ano)
			IF @Fecha BETWEEN @FechaD AND @FechaA 
			BEGIN
				SELECT @FechaHabil = dbo.fnChecarDiaHabil(@FechaPago1, @RecorrerVencimiento)
				SELECT @FechaHabilF = dbo.fnChecarDiaHabil(@FechaPago2, @RecorrerVencimiento)
				INSERT @Resultado VALUES(@Periodo, @FechaHabil, @FechaHabilF)
			END
		END 
		ELSE
		BEGIN
			SELECT	@FechaPago1 = dbo.fnIntToDateTime(@PagoQ1, @Mes, @Ano),
					@FechaPago2 = CASE WHEN @PagoQ2 <= dbo.fnDiasMes(@Mes, @Ano)
									   THEN dbo.fnIntToDateTime(@PagoQ2, @Mes, @Ano)
									   ELSE dbo.fnIntToDateTime(dbo.fnDiasMes(@Mes, @Ano), @Mes, @Ano)
								  END
			IF @Fecha BETWEEN @FechaD AND @FechaA 
			BEGIN
				SELECT @FechaHabil = dbo.fnChecarDiaHabil(@FechaPago1, @RecorrerVencimiento)
				SELECT @FechaHabilF = dbo.fnChecarDiaHabil(@FechaPago2, @RecorrerVencimiento)
				INSERT @Resultado VALUES(@Periodo, @FechaHabil, @FechaHabilF)
			END		
		END
		SELECT @Fecha = DATEADD(month, 1, @Fecha)
	END

    SELECT @Periodo = @Periodo + 1
  END

  IF ISNULL(@MinimoDias, 0)>0 
  BEGIN
    SELECT @Periodo = MIN(Periodo) FROM @Resultado
    SELECT @FechaD = FechaD, @FechaA = FechaA FROM @Resultado WHERE Periodo = @Periodo
    IF DATEDIFF(day, @FechaD, @FechaA) < @MinimoDias
    BEGIN 
      DELETE @Resultado WHERE Periodo = @Periodo
      SELECT @Periodo = MIN(Periodo) FROM @Resultado       
      UPDATE @Resultado SET FechaD = @FechaD WHERE Periodo = @Periodo
      SELECT @a = 0
      UPDATE @Resultado SET @a = Periodo = @a + 1

      -- para empujar el primer vencimiento 
      SELECT @UPeriodo = MAX(Periodo) FROM @Resultado
      SELECT @UFechaD = FechaD, @UFechaA = FechaA FROM @Resultado WHERE Periodo = @UPeriodo
      SELECT @UFechaD = DATEADD(month, 1, @UFechaD), @UFechaA = DATEADD(month, 1, @UFechaA)
      INSERT @Resultado VALUES (@UPeriodo+1, @UFechaD, @UFechaA)
    END
  END
  RETURN
END
GO

-- SELECT dbo.fnEsDiaCorte('13/1/5', 'DIA ESPECIFICO', 13, '1/1/5')
-- SELECT dbo.fnEsDiaCorte('31/1/5', 'FIN DE MES', 30, '1/1/5')
-- SELECT dbo.fnEsDiaCorte('22/9/6', 'DIAS', 10, '1/1/5')
/**************** fnEsDiaCorte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsDiaCorte' AND type = 'FN') DROP FUNCTION fnEsDiaCorte
GO
CREATE FUNCTION fnEsDiaCorte (@Fecha datetime, @TipoVencimiento varchar(20), @Dias int, @FechaInicio datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Desde	datetime,
    @DiasMes	int,
    @FechaDias	datetime

  SELECT @Desde = NULL
  IF @TipoVencimiento = 'DIA ESPECIFICO'
  BEGIN
    IF DAY(@Fecha) = @Dias SELECT @Desde = DATEADD(month, -1, @Fecha)
  END ELSE
  IF @TipoVencimiento = 'FIN DE MES'
  BEGIN
    SELECT @DiasMes = dbo.fnDiasMes(MONTH(@Fecha), YEAR(@Fecha))
    IF DAY(@Fecha) = @DiasMes SELECT @Desde = DATEADD(month, -1, @Fecha)
  END ELSE 
  IF @TipoVencimiento = 'DIAS'
  BEGIN
    SELECT @FechaDias = DATEADD(day, -1, @FechaInicio)
    WHILE @Desde IS NULL AND @FechaDias < @Fecha
    BEGIN
      SELECT @FechaDias = DATEADD(day, @Dias, @FechaDias)
      IF @FechaDias = @Fecha SELECT @Desde = DATEADD(day, -@Dias, @FechaDias)
    END
  END

  SELECT @Desde = DATEADD(day, 1, @Desde)
  RETURN (@Desde)
END
GO

-- SELECT VIN FROM dbo.fnExplorarVINFiltro(100, 'Opciones')
/**************** fnExplorarVINFiltro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExplorarVINFiltro' AND type = 'TF') DROP FUNCTION fnExplorarVINFiltro
GO
CREATE FUNCTION fnExplorarVINFiltro (@Estacion int, @Tipo varchar(50))
RETURNS @Resultado TABLE (VIN varchar(20))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cuantos	int,
    @VIN	varchar(20)

  SELECT @Cuantos = ISNULL(COUNT(*), 0) FROM ListaSt WHERE Estacion = @Estacion
  IF @Cuantos = 0
  BEGIN
    INSERT @Resultado (VIN)
    SELECT v.VIN
      FROM Art a
      JOIN VIN v ON v.Articulo = a.Articulo
      JOIN ExplorarVINFiltro f ON f.Estacion = @Estacion
     WHERE a.Fabricante = ISNULL(f.Fabricante, a.Fabricante) 
       AND a.Modelo = ISNULL(f.Modelo, a.Modelo)
       AND a.Linea = ISNULL(f.Linea, a.Linea)
       AND a.Version = ISNULL(f.Version, a.Version)
       AND a.Articulo = ISNULL(f.Articulo, a.Articulo)
       AND NOT EXISTS(SELECT * FROM VINAccesorio va WHERE va.VIN = v.VIN AND va.Tipo = @Tipo)
     GROUP BY v.VIN
  END ELSE
  BEGIN
    DECLARE crExplorarVINFiltro CURSOR FOR
    SELECT v.VIN
      FROM Art a
      JOIN VIN v ON v.Articulo = a.Articulo
      JOIN VINAccesorio va ON va.VIN = v.VIN AND va.Tipo = @Tipo 
      JOIN ExplorarVINFiltro f ON f.Estacion = @Estacion
     WHERE a.Fabricante = ISNULL(f.Fabricante, a.Fabricante) 
       AND a.Modelo = ISNULL(f.Modelo, a.Modelo)
       AND a.Linea = ISNULL(f.Linea, a.Linea)
       AND a.Version = ISNULL(f.Version, a.Version)
       AND a.Articulo = ISNULL(f.Articulo, a.Articulo)
     GROUP BY v.VIN

    OPEN crExplorarVINFiltro
    FETCH NEXT FROM crExplorarVINFiltro INTO @VIN
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @Cuantos <= (SELECT COUNT(DISTINCT va.Accesorio) FROM VINAccesorio va, ListaSt l WHERE va.VIN = @VIN AND va.Tipo = @Tipo AND l.Estacion = @Estacion AND l.Clave = va.Accesorio)
          INSERT @Resultado (VIN) VALUES (@VIN)
      END
      FETCH NEXT FROM crExplorarVINFiltro INTO @VIN
    END  -- While
    CLOSE crExplorarVINFiltro
    DEALLOCATE crExplorarVINFiltro
  END
  RETURN
END
GO

-- select dbo.fnPosUltAlfa('AAA1231234')
/**************** fnPosUltAlfa ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPosUltAlfa') DROP FUNCTION fnPosUltAlfa
GO
CREATE FUNCTION fnPosUltAlfa (@Valor varchar(50))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p	int
  SELECT @p = LEN(ISNULL(@Valor, ''))
  WHILE @p>0 AND SUBSTRING(@Valor, @p, 1) BETWEEN '0' AND '9'
    SELECT @p = @p - 1
  RETURN (@p)
END
GO

/**************** fnNominaFechaDesfasada ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNominaFechaDesfasada') DROP FUNCTION fnNominaFechaDesfasada
GO
CREATE FUNCTION fnNominaFechaDesfasada (@Empresa char(5), @Mov varchar(20), @Fecha datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Desfaso	int

  SELECT @Desfaso = 0
  SELECT @Desfaso = ISNULL(NomDiasDesfasoIncidencias, 0) FROM EmpresaCfg WHERE Empresa = @Empresa
  IF @Desfaso <> 0
    SELECT @Fecha = DATEADD(day, -@Desfaso, @Fecha)

  RETURN (@Fecha)
END
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCostoSugeridoCapas') DROP FUNCTION fnCostoSugeridoCapas
GO
CREATE FUNCTION fnCostoSugeridoCapas (@Empresa char(5), @Sucursal int, @Articulo char(20), @SubCuenta varchar(50))
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CostoSugeridoCapas money

  IF NULLIF(RTRIM(@SubCuenta), '') IS NOT NULL
    SELECT @CostoSugeridoCapas = ISNULL(NULLIF(UltimoCosto, 0.0), CostoPromedio)
      FROM ArtSubCosto
     WHERE Articulo = @Articulo AND SubCuenta = @SubCuenta AND Empresa = @Empresa AND Sucursal = @Sucursal     
  ELSE
    SELECT @CostoSugeridoCapas = ISNULL(NULLIF(UltimoCosto, 0.0), CostoPromedio)
      FROM ArtCosto
     WHERE Articulo = @Articulo AND Empresa = @Empresa AND Sucursal = @Sucursal

  RETURN (@CostoSugeridoCapas)
END
GO


/**************** fnWMSSurtirTarimas ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnWMSSurtirTarimas' AND type = 'TF') DROP FUNCTION fnWMSSurtirTarimas
GO
/*CREATE FUNCTION fnWMSSurtirTarimas (@Empresa char(5), @Almacen char(10), @Articulo char(20), @SubCuenta varchar(50), @CantidadInventario float)
RETURNS @Resultado TABLE (Tarima varchar(20), Posicion char(10), Cantidad float, Unidad varchar(50), Factor float)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tarima		varchar(20),
    @Posicion		char(10),
    @Cantidad		float,
    @Unidad		varchar(50),
    @Factor		float,
    @CantidadA		float,
    @CantidadSaldo	float

  SELECT @CantidadSaldo = @CantidadInventario
  DECLARE crSurtirTarimas CURSOR LOCAL FOR
   SELECT Tarima, Posicion, ISNULL(Cantidad, 0.0), Unidad, Factor
     FROM Tarima
    WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '') AND Estatus = 'ENUSO'
    ORDER BY Cantidad*Factor DESC

  OPEN crSurtirTarimas
  FETCH NEXT FROM crSurtirTarimas INTO @Tarima, @Posicion, @Cantidad, @Unidad, @Factor
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Cantidad > 0.0
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @CantidadSaldo >= @Cantidad*@Factor
      BEGIN
        SELECT @CantidadSaldo = @CantidadSaldo - (@Cantidad*@Factor)
        INSERT @Resultado (Tarima, Posicion, Cantidad, Unidad, Factor) VALUES (@Tarima, @Posicion, @Cantidad, @Unidad, @Factor)
      END 
    END
    FETCH NEXT FROM crSurtirTarimas INTO @Tarima, @Posicion, @Cantidad, @Unidad, @Factor
  END
  CLOSE crSurtirTarimas
  DEALLOCATE crSurtirTarimas

  IF @CantidadSaldo > 0.0
  BEGIN
    DECLARE crSurtirTarimas CURSOR LOCAL FOR
     SELECT t.Tarima, t.Posicion, ISNULL(t.Cantidad, 0.0), t.Unidad, t.Factor
       FROM Tarima t
       JOIN AlmPos p ON p.Almacen = @Almacen AND p.Posicion = t.Posicion
      WHERE t.Empresa = @Empresa AND t.Almacen = @Almacen AND t.Articulo = @Articulo AND ISNULL(t.SubCuenta, '') = ISNULL(@SubCuenta, '') AND t.Estatus = 'ENUSO'
        AND t.Tarima NOT IN (SELECT Tarima FROM @Resultado)
      ORDER BY p.Tipo	-- Primero los Domicilios

    OPEN crSurtirTarimas
    FETCH NEXT FROM crSurtirTarimas INTO @Tarima, @Posicion, @Cantidad, @Unidad, @Factor
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @Cantidad > 0.0
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @CantidadSaldo >= @Cantidad*@Factor
          SELECT @CantidadA = @Cantidad*@Factor
        ELSE
          SELECT @CantidadA = @CantidadSaldo
        SELECT @CantidadSaldo = @CantidadSaldo - @CantidadA
        INSERT @Resultado (Tarima, Posicion, Cantidad, Unidad, Factor) SELECT @Tarima, @Posicion, @CantidadA/@Factor, @Unidad, @Factor
      END
      FETCH NEXT FROM crSurtirTarimas INTO @Tarima, @Posicion, @Cantidad, @Unidad, @Factor
    END
    CLOSE crSurtirTarimas
    DEALLOCATE crSurtirTarimas
  END

  RETURN
END*/
GO

-- select dbo.fnPrecioSinImpuestos('DEMO', 'A1', 100)
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPrecioSinImpuestos') DROP FUNCTION fnPrecioSinImpuestos
GO
CREATE FUNCTION fnPrecioSinImpuestos (@Empresa char(5), @Articulo char(20), @Precio float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		float,
    @Impuesto2Info	bit,
    @Impuesto3Info	bit
    
  IF (SELECT VentaPreciosImpuestoIncluido FROM EmpresaCfg WHERE Empresa = @Empresa) =1
  BEGIN
    SELECT @Impuesto2Info = ISNULL(Impuesto2Info, 0), @Impuesto3Info = ISNULL(Impuesto3Info, 0)
      FROM Version
      
    SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3
      FROM Art 
     WHERE Articulo = @Articulo
     IF @Impuesto2Info = 1 SELECT @Impuesto2 = 0.0
     IF @Impuesto3Info = 1 SELECT @Impuesto3 = 0.0

    SELECT @Precio = @Precio / (1.0+(((100.0+ISNULL(@Impuesto2, 0.0))*(1+((ISNULL(@Impuesto1, 0.0)/*+ISNULL(Impuesto3, 0.0)*/)/100.0))-100.0)/100.0)) 
  END
  RETURN (@Precio)
END
GO

-- select dbo.fnPrecioConImpuestos('DEMO', 'A1', 100)
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPrecioConImpuestos') DROP FUNCTION fnPrecioConImpuestos
GO
CREATE FUNCTION fnPrecioConImpuestos (@Empresa char(5), @Articulo char(20), @Precio float)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Impuesto1		float,
    @Impuesto2		float,
    @Impuesto3		float,
    @Impuesto2Info	bit,
    @Impuesto3Info	bit

  SELECT @Impuesto2Info = ISNULL(Impuesto2Info, 0), @Impuesto3Info = ISNULL(Impuesto3Info, 0)
    FROM Version
  SELECT @Impuesto1 = Impuesto1, @Impuesto2 = Impuesto2, @Impuesto3 = Impuesto3
    FROM Art 
   WHERE Articulo = @Articulo
   IF @Impuesto2Info = 1 SELECT @Impuesto2 = 0.0
   IF @Impuesto3Info = 1 SELECT @Impuesto3 = 0.0

  SELECT @Precio = @Precio * (1.0+(((100.0+ISNULL(@Impuesto2, 0.0))*(1+((ISNULL(@Impuesto1, 0.0)/*+ISNULL(Impuesto3, 0.0)*/)/100.0))-100.0)/100.0)) 

  RETURN (@Precio)
END
GO

-- select dbo.fnListaDescuentos('10 + 20 + 30', '+')
-- select dbo.fnListaDescuentos('10, 20, 30', ',')
/**************** fnListaDescuentos ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnListaDescuentos') DROP FUNCTION fnListaDescuentos
GO
CREATE FUNCTION fnListaDescuentos (@Lista varchar(255), @Separador char(1))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cascada		float,
    @DescuentoSt	varchar(20),
    @Descuento		float,
    @p			int

  SELECT @Cascada = 100.0, @Lista = ISNULL(RTRIM(@Lista), '')
  WHILE LEN(@Lista) > 0
  BEGIN
    SELECT @p = CHARINDEX(@Separador, @Lista)
    IF @p>0 
    BEGIN
      SELECT @DescuentoSt = LTRIM(RTRIM(SUBSTRING(@Lista, 1, @p-1)))
      SELECT @Lista = SUBSTRING(@Lista, @p + 1, LEN(@Lista))
    END ELSE
    BEGIN
      SELECT @DescuentoSt = LTRIM(RTRIM(@Lista))
      SELECT @Lista = ''
    END

    IF dbo.fnEsNumerico(@DescuentoSt) = 1 
      SELECT @Descuento = CONVERT(float, @DescuentoSt)
    ELSE
      SELECT @Descuento = 0.0
    IF @Descuento > 0.0
      SELECT @Cascada = @Cascada - (@Cascada * (@Descuento/100))
  END

  RETURN (100.0-@Cascada)
END
GO

IF EXISTS (SELECT name FROM sysobjects WHERE name = 'xnMovTabla') DROP FUNCTION xnMovTabla
GO
CREATE FUNCTION xnMovTabla (@Modulo char(5))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
    DECLARE
        @Tabla  varchar(50)
    SELECT @Tabla = @Modulo
    RETURN(@Tabla)
END
GO

-- select dbo.fnMovTabla('vtas')
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovTabla') DROP FUNCTION fnMovTabla
GO
CREATE FUNCTION fnMovTabla (@Modulo char(5))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(50)
  SELECT @Tabla = NULL
  SELECT @Tabla = CASE @Modulo 
    WHEN 'VTAS'  THEN 'Venta' 
    WHEN 'COMS'  THEN 'Compra'
    WHEN 'ST'    THEN 'Soporte'
    WHEN 'EMB'   THEN 'Embarque'
    WHEN 'DIN'   THEN 'Dinero' 
    WHEN 'AF'    THEN 'ActivoFijo'
    WHEN 'NOM'   THEN 'Nomina'
    WHEN 'ASIS'  THEN 'Asiste'
    WHEN 'GAS'   THEN 'Gasto'
    WHEN 'CAP'   THEN 'Capital'
    WHEN 'CAM'   THEN 'Cambio'
    WHEN 'PROY'  THEN 'Proyecto'
    WHEN 'INC'   THEN 'Incidencia'
    WHEN 'CONC'  THEN 'Conciliacion'
    WHEN 'PPTO'  THEN 'Presup'
    WHEN 'CREDI' THEN 'Credito'
    WHEN 'CMP'   THEN 'Campana'
    WHEN 'FIS'   THEN 'Fiscal'
	--REQ25014
    WHEN 'CONTP' THEN 'ContParalela'
	--REQ16092
    WHEN 'OPORT' THEN 'Oportunidad'    	
    WHEN 'CORTE' THEN 'Corte'    
    --WHEN 'MEX01' THEN 'ModuloExtra01'
    --WHEN 'MEX02' THEN 'ModuloExtra02'
    --WHEN 'MEX03' THEN 'ModuloExtra03'
    --WHEN 'MEX04' THEN 'ModuloExtra04'
    --WHEN 'MEX05' THEN 'ModuloExtra05'
    --WHEN 'MEX06' THEN 'ModuloExtra06'
    --WHEN 'MEX07' THEN 'ModuloExtra07'
    --WHEN 'MEX08' THEN 'ModuloExtra08'
    --WHEN 'MEX09' THEN 'ModuloExtra09'
    WHEN 'ORG'   THEN 'Organiza'
    WHEN 'RE'	 THEN 'Recluta'
    WHEN 'FRM'   THEN 'FormaExtra'
    WHEN 'CAPT'  THEN 'Captura'
    WHEN 'GES'   THEN 'Gestion'
    WHEN 'OFER'  THEN 'Oferta'
    WHEN 'PACTO' THEN 'Contrato'
    WHEN 'CXP'   THEN 'CXP'   
    WHEN 'TMA'	 THEN 'TMA'	 
    WHEN 'AGENT' THEN 'AGENT' 
    WHEN 'ISL'	 THEN 'ISL'	 
    WHEN 'PROD'	 THEN 'PROD'	 
    WHEN 'CONT'	 THEN 'CONT'	 
    WHEN 'CP'	 THEN 'CP'	 
    WHEN 'PCP'	 THEN 'PCP'	     
    WHEN 'PC'    THEN 'PC'    
    WHEN 'RH'	 THEN 'RH'
    WHEN 'CXC'	 THEN 'CXC'
    WHEN 'VALE'	 THEN 'VALE'
    WHEN 'RSS'	 THEN 'RSS'
    WHEN 'CR'	 THEN 'CR'
    WHEN 'INV'	 THEN 'INV'
    WHEN 'SAUX'	 THEN 'SAUX'
    ELSE dbo.xnMovTabla(@Modulo)
  END
  
  RETURN (@Tabla)
END
GO

-- select dbo.fnRamaCatalogo('CXC')
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRamaCatalogo') DROP FUNCTION fnRamaCatalogo
GO
CREATE FUNCTION fnRamaCatalogo (@Rama char(5))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Catalogo	varchar(50)
  SELECT @Catalogo = NULL
  SELECT @Catalogo = CASE @Rama 
    WHEN 'CXC'   THEN 'Cliente' 
    WHEN 'CXP'   THEN 'Proveedor' 
    WHEN 'CMP'   THEN 'Prospecto' 
    WHEN 'AGENT' THEN 'Agente' 
    WHEN 'ALM'   THEN 'Almacen' 
    WHEN 'EMP'   THEN 'Empresa' 
    WHEN 'SUC'   THEN 'Sucursal' 
    WHEN 'PER'   THEN 'Personal' 
  END
  RETURN (@Catalogo)
END
GO


-- select dbo.fnContactoNivel('Cliente', 'MEX', 'Nombre')
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoNivel') DROP FUNCTION fnContactoNivel
GO
CREATE FUNCTION fnContactoNivel (@Tipo varchar(20), @Contacto varchar(20), @Nivel varchar(20))
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado		varchar(100),
    @SubTipo 		varchar(20),
    @Rama    		varchar(20),
    @Clave		varchar(20),
    @Nombre		varchar(100),
    @RFC		varchar(20),
    @CURP		varchar(20),
    @Categoria		varchar(50),
    @Grupo		varchar(50),
    @Familia		varchar(50),
    @Puesto		varchar(50),
    @Departamento	varchar(50)

  SELECT @Resultado = NULL, @Nivel = UPPER(@Nivel)

  IF @Tipo = 'Cliente'   SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = Rama,     @Clave = Cliente,   @RFC = RFC, @CURP = CURP, @Categoria = Categoria, @Grupo = Grupo, @Familia = Familia FROM Cte       WHERE Cliente   = @Contacto ELSE
  IF @Tipo = 'Prospecto' SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = NULL,     @Clave = Prospecto, @RFC = RFC, @CURP = CURP, @Categoria = Categoria, @Grupo = Grupo, @Familia = Familia FROM Prospecto WHERE Prospecto = @Contacto ELSE
  IF @Tipo = 'Proveedor' SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = Rama,     @Clave = Proveedor, @RFC = RFC, @CURP = CURP, @Categoria = Categoria, /*@Grupo = Grupo, */@Familia = Familia FROM Prov      WHERE Proveedor = @Contacto ELSE
  IF @Tipo = 'Agente'    SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = NULL,     @Clave = Agente,    @RFC = RFC, @CURP = CURP, @Categoria = Categoria, @Grupo = Grupo, @Familia = Familia FROM Agente    WHERE Agente    = @Contacto ELSE
  IF @Tipo = 'Almacen'   SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = Rama,     @Clave = Almacen/*, @RFC = RFC, @CURP = CURP*/   FROM Alm       WHERE Almacen   = @Contacto ELSE
  IF @Tipo = 'Empresa'   SELECT @SubTipo = Tipo, @Nombre = Nombre, @Rama = NULL,     @Clave = Empresa,   @RFC = RFC/*, @CURP = CURP*/ FROM Empresa   WHERE Empresa   = @Contacto ELSE
  IF @Tipo = 'Personal'  
    SELECT @SubTipo = Tipo, @Nombre = RTRIM(ISNULL(ApellidoPaterno, ''))+' '+RTRIM(ISNULL(ApellidoMaterno, ''))+' '+RTRIM(Nombre), @Rama = ReportaA, @Clave = Personal,
           @Categoria = Categoria, @Grupo = Grupo, /*@Familia = Familia, */@Puesto = Puesto, @Departamento = Departamento
      FROM Personal  
      WHERE Personal = @Contacto 

  IF @Nivel = 'SUB TIPO'	SELECT @Resultado = @SubTipo	ELSE
  IF @Nivel = 'RAMA'		SELECT @Resultado = @Rama	ELSE
  IF @Nivel = 'CLAVE'		SELECT @Resultado = @Clave	ELSE
  IF @Nivel = 'NOMBRE'		SELECT @Resultado = @Nombre	ELSE
  IF @Nivel = 'RFC'		SELECT @Resultado = @RFC	ELSE
  IF @Nivel = 'CURP'		SELECT @Resultado = @CURP	ELSE
  IF @Nivel = 'CATEGORIA'	SELECT @Resultado = @Categoria  ELSE
  IF @Nivel = 'GRUPO'		SELECT @Resultado = @Grupo	ELSE
  IF @Nivel = 'FAMILIA'		SELECT @Resultado = @Familia	ELSE
  IF @Nivel = 'PUESTO'		SELECT @Resultado = @Puesto	ELSE
  IF @Nivel = 'DEPARTAMENTO'	SELECT @Resultado = @Departamento

  RETURN (@Resultado)
END
GO

-- select dbo.fnCtoTabla('Personal')
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtoTabla') DROP FUNCTION fnCtoTabla
GO
CREATE FUNCTION fnCtoTabla (@Tipo varchar(20))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Tabla	varchar(50)
  SELECT @Tabla = NULL
  SELECT @Tabla = CASE @Tipo
    WHEN 'Cliente'   THEN 'Cte'
    WHEN 'Proveedor' THEN 'Prov'
    WHEN 'Almacen'   THEN 'Alm'
	-- BUG 14106
	WHEN 'Articulo'	 THEN 'Art'
    ELSE @Tipo
  END
  RETURN (@Tabla)
END
GO

-- select dbo.fnAntiguedad('1/1/1', '12/30/1')
/**************** fnAntiguedad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAntiguedad') DROP FUNCTION fnAntiguedad
GO
CREATE FUNCTION fnAntiguedad (@FechaD datetime, @FechaA datetime)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha  datetime
  select @Fecha = @FechaA - @FechaD + 1.0
  RETURN (YEAR(@Fecha)-1900)
END
GO

-- select dbo.fnAntiguedadFloat('1/1/4', '3/30/5')
/**************** fnAntiguedadFloat ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAntiguedadFloat') DROP FUNCTION fnAntiguedadFloat
GO
CREATE FUNCTION fnAntiguedadFloat (@FechaD datetime, @FechaA datetime)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float

  SELECT @Resultado = (DATEDIFF(day, @FechaD, @FechaA) + 1.0) / 365.0
  RETURN (@Resultado)
END
GO


/**************** fnNominaCuentaContable ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNominaCuentaContable') DROP FUNCTION fnNominaCuentaContable
GO
CREATE FUNCTION fnNominaCuentaContable (@CuentaBase varchar(50), @Cuenta varchar(20), @Personal varchar(10), @NominaConcepto varchar(10), @Proveedor varchar(10), @Empresa varchar(5))
RETURNS varchar(20)
--WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado		       varchar(20),
    @CuentaGrupo	       varchar(20),
    @Rama		             varchar(20),
    @SubSubGrupo	       varchar(50),
    @Proveedor2  	       varchar(10),
    @UEN        	       int,
    @CuentaGrupo2        varchar(20),
    @SucursalTrabajo     int,
    @Categoria           varchar(50),
    @Puesto              varchar(50)


  SELECT @CuentaBase = UPPER(@CuentaBase), @Resultado = NULL

  IF @CuentaBase = 'ESPECIFICA' SELECT @Resultado = @Cuenta ELSE
  IF @CuentaBase = 'PERSONAL'   SELECT @Resultado = Cuenta FROM Personal WHERE Personal = @Personal 
  ELSE BEGIN
    SELECT @CuentaGrupo = ISNULL(CuentaGrupo, '')
      FROM NominaConcepto 
     WHERE NominaConcepto = @NominaConcepto
     
     SELECT @CuentaGrupo2 = ISNULL(CuentaGrupo2, '')
      FROM NominaConcepto 
     WHERE NominaConcepto = @NominaConcepto

    SELECT @Rama        = UPPER(cc.Rama), 
           @SubSubGrupo = UPPER(cc.SubSubGrupo),
           @UEN         = P.UEN
      FROM Personal p
      JOIN CentroCostos cc ON cc.CentroCostos = p.CentroCostos
     WHERE p.Personal = @Personal
    

    IF @CuentaBase = 'LOCALIDAD'
      SELECT @Resultado = @CuentaGrupo + '-' + 
             CASE @SubSubGrupo
                  WHEN 'DF' 		THEN '000002'
                  WHEN 'EDO MEX'	THEN '000003'
                  WHEN 'PROVINCIA'	THEN '000004'
             END


    IF @CuentaBase = 'PREFIJO'
      SELECT @Resultado = @CuentaGrupo + '-' + @Personal

    IF @CuentaBase = 'TIPO GASTO'
      SELECT @Resultado =              
             CASE WHEN @Rama IN ('ALMACEN', 'DEPARTAMENTO')   THEN '602'
                  WHEN @Rama IN ('FORANEA', 'LOCAL', 'VENTA') THEN '601'
             END + '-' + @CuentaGrupo

    IF @CuentaBase = 'TIPO GASTO UEN '
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '5100'
                  WHEN @UEN IN (2,4,5)     THEN '5150'
             END + '-' + @CuentaGrupo -- AQUI NOSE QUE HACERLE PERO DEBE SER POR EL CAMPODE UEN
             
    IF @CuentaBase = 'TIPO GASTO UEN 2'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '2102'
                  WHEN @UEN IN (2,4,5)     THEN '2152'
             END + '-' + @CuentaGrupo2 -- AQUI NOSE QUE HACERLE PERO DEBE SER POR EL CAMPODE UEN

	IF @CuentaBase = 'TIPO GASTO UEN 5'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '2102'
                  WHEN @UEN IN (2,4,5)     THEN '2152'
             END + '-' + @CuentaGrupo -- AQUI NOSE QUE HACERLE PERO DEBE SER POR EL CAMPODE UEN
	
	
	IF @CuentaBase = 'TIPO GASTO UEN 4'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '1305'
                  WHEN @UEN IN (2,4,5)     THEN '1354'
             END + '-' + @CuentaGrupo -- AQUI NOSE QUE HACERLE PERO DEBE SER POR EL CAMPODE UEN

	IF @CuentaBase = 'TIPO GASTO UEN 3'
	  SELECT @Resultado =				   
             CASE WHEN @UEN IN (1,3)   THEN '2101'
                  WHEN @UEN IN (2,4,5)     THEN '2151'
             END + '-' + @CuentaGrupo -- AQUI NOSE QUE HACERLE PERO DEBE SER POR EL CAMPODE UEN

	IF @CuentaBase = 'TIPO GASTO UEN F'
       SELECT @Resultado =				   
             CASE WHEN @UEN IN (1,3)   THEN '2101'
                  WHEN @UEN IN (2,4,5)     THEN '2151'
             END + '-' + @CuentaGrupo2 

	IF @CuentaBase = 'TIPO GASTO UEN N'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '2103'
                  WHEN @UEN IN (2,4,5)     THEN '2153'
             END + '-' + @CuentaGrupo 

	IF @CuentaBase = 'TIPO GASTO UEN V'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '2103-0001-000'
                  WHEN @UEN IN (2,4,5)     THEN '2153-0001-000'
             END --+ '-' + @CuentaGrupo2 
	
	IF @CuentaBase = 'TIPO GASTO UEN PF'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '9101-0001-000'
                  WHEN @UEN IN (2,4,5)     THEN '9101-0001-000'
             END --+ '-' + @CuentaGrupo2 

	IF @CuentaBase = 'TIPO GASTO UEN P'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '2101-0006-001'
                  WHEN @UEN IN (2,4,5)     THEN '2151-0007-001'
             END --+ '-' + @CuentaGrupo2 

	IF @CuentaBase = 'TIPO GASTO UEN R'
      SELECT @Resultado =              
             CASE WHEN @UEN IN (1,3)   THEN '1300-1183-000'
                  WHEN @UEN IN (2,4,5)     THEN '1354-0698-000'
             END --+ '-' + @CuentaGrupo2 


    IF @CuentaBase = 'GASTO LOCALIDAD'
    BEGIN
        SELECT @Proveedor  = PersonalPropValor.VALOR 
            FROM  Personal, PersonalPropValor 
            WHERE PersonalPropValor.cuenta=Personal.SucurSaltrabajo 
              AND PersonalPropValor.Rama='SUC'
              AND Personal.personal=@Personal
              AND PersonalPropValor.Propiedad='Acreedor Impuesto Estatal'
       SELECT @Resultado = CASE WHEN @Rama IN ('ALMACEN', 'DEPARTAMENTO')   THEN '602'
                  WHEN @Rama IN ('FORANEA', 'LOCAL', 'VENTA') THEN '601'
             END + '-' + ( SELECT RIGHT(RTRIM(Prov.CuentaRetencion),6) 
           FROM PROV WHERE  Proveedor = @Proveedor)

    END   

    IF @CuentaBase = 'TIPO ACREEDOR PENSION'
    BEGIN
       SELECT 
              @SucursalTrabajo = SucursalTrabajo,
              @Categoria       = Categoria,        
              @Puesto          = Puesto   
         FROM Personal 
        WHERE PERSONAL         = @Personal

        SELECT  @Proveedor2 = Valor 
          FROM PersonalPropValor 
         WHERE Rama = 'PER' AND Propiedad = 'Acreedor Pension Alimenticia' AND Cuenta = @Personal

        IF @Proveedor = @Proveedor2 
          SELECT  @Resultado = Valor 
            FROM PersonalPropValor 
           WHERE Rama = 'PER' AND Propiedad = 'Cuenta Pension Alimenticia' AND Cuenta = @Personal

        SELECT  @Proveedor2 = Valor 
          FROM PersonalPropValor 
         WHERE Rama = 'PER' AND Propiedad = 'Acreedor Pension Alimenticia 2' AND Cuenta = @Personal
        IF @Proveedor = @Proveedor2  
          SELECT  @Resultado = Valor 
            FROM PersonalPropValor 
           WHERE Rama = 'PER' 
             AND Propiedad = 'Cuenta Pension Alimenticia 2' 
             AND Cuenta = @Personal
      
       SELECT  @Proveedor2 = Valor 
          FROM PersonalPropValor 
         WHERE Rama = 'PER' AND Propiedad = 'Acreedor Pension Alimenticia 3' AND Cuenta = @Personal
        IF @Proveedor = @Proveedor2  
          SELECT  @Resultado = Valor 
            FROM PersonalPropValor 
           WHERE Rama = 'PER' AND Propiedad = 'Cuenta Pension Alimenticia 3' AND Cuenta = @Personal
    END
  END
  RETURN (@Resultado)
END
GO

/**************** fnCtaMayor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaMayor') DROP FUNCTION fnCtaMayor
GO
CREATE FUNCTION fnCtaMayor (@Cuenta varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Rama	char(20),
    @Tipo	char(15)

  SELECT @Cuenta = Cuenta, @Rama = NULLIF(RTRIM(Rama), ''), @Tipo = Tipo FROM Cta WHERE Cuenta = @Cuenta
  WHILE UPPER(@Tipo) <> 'MAYOR' AND @Rama IS NOT NULL
    SELECT @Cuenta = Cuenta, @Rama = NULLIF(RTRIM(Rama), ''), @Tipo = Tipo FROM Cta WHERE Cuenta = @Rama

  RETURN (@Cuenta)
END
GO

-- 'CORTE'
/**************** fnCtaSubCuenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaSubCuenta') DROP FUNCTION fnCtaSubCuenta
GO
CREATE FUNCTION fnCtaSubCuenta (@Cuenta varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Rama	char(20),
    @Tipo	char(15)

  SELECT @Cuenta = Cuenta, @Rama = NULLIF(RTRIM(Rama), ''), @Tipo = Tipo FROM Cta WHERE Cuenta = @Cuenta
  WHILE UPPER(@Tipo) <> 'SUBCUENTA' AND @Rama IS NOT NULL
    SELECT @Cuenta = Cuenta, @Rama = NULLIF(RTRIM(Rama), ''), @Tipo = Tipo FROM Cta WHERE Cuenta = @Rama

  RETURN (@Cuenta)
END
GO

/**************** fnCtaAuxiliar ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnCtaAuxiliar') and type in ('tf')) drop function dbo.fnCtaAuxiliar
GO
CREATE FUNCTION fnCtaAuxiliar (@Cuenta varchar(20))
RETURNS @Auxiliar	TABLE(Cuenta	varchar(20), Tipo varchar(15))
AS
BEGIN
  DECLARE
    @Rama		char(20),
    @Tipo		char(15),
    @CuentaAnt	varchar(20)

  IF ISNULL(@Cuenta, '') = ''
    INSERT INTO @Auxiliar(Cuenta, Tipo) SELECT Cuenta, Tipo FROM Cta WHERE Tipo = 'AUXILIAR'
  ELSE
  BEGIN
    SELECT @Tipo = Tipo FROM Cta WHERE Cuenta = @Cuenta  

    IF ISNULL(@Tipo, '') <> 'AUXILIAR'
    BEGIN
      INSERT INTO @Auxiliar(Cuenta, Tipo) SELECT Cuenta, Tipo FROM Cta WHERE Rama = @Cuenta    
      
      SELECT @CuentaAnt = ''      
      WHILE(1=1)
      BEGIN
        SELECT @Cuenta = MIN(Cta.Cuenta)
          FROM @Auxiliar Cta
         WHERE Cta.Cuenta		> @CuentaAnt
           AND Cta.Tipo	   <> 'AUXILIAR'
  
        IF @Cuenta IS NULL BREAK
    
        SELECT @CuentaAnt = @Cuenta
    
        INSERT INTO @Auxiliar(Cuenta, Tipo) SELECT Cuenta, Tipo FROM Cta WHERE Rama = @Cuenta
      
        DELETE @Auxiliar WHERE Cuenta = @Cuenta
      END
    END
    ELSE
      INSERT INTO @Auxiliar(Cuenta, Tipo) SELECT Cuenta, Tipo FROM Cta WHERE Cuenta = @Cuenta    
  END
  RETURN
END
GO

/*
select "Mayor" = dbo.fnCtaMayor(Cuenta), "DescMayor" = (SELECT Descripcion FROM Cta m WHERE m.Cuenta=dbo.fnCtaMayor(cta.Cuenta)), * from cta 
*/

-- select dbo.fnExtraerClaveID('VTAS123')
/**************** fnExtraerClaveID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerClaveID') DROP FUNCTION fnExtraerClaveID
GO
CREATE FUNCTION fnExtraerClaveID (@Clave varchar(20))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p	int,
    @c	char(1),
    @ID	varchar(20)
  
  SELECT @ID = ''
  SELECT @p = LEN(@Clave)
  WHILE @p > 0 
  BEGIN
    SELECT @c = SUBSTRING(@Clave, @p, 1)
    IF (@c <> '.') AND dbo.fnEsNumerico(@c) = 1 SELECT @ID = @c + @ID ELSE BREAK
    SELECT @p = @p - 1
  END
  RETURN (NULLIF(CONVERT(int, @ID), 0))
END
GO

-- select dbo.fnExtraerClaveModulo('VTAS123')
/**************** fnExtraerClaveModulo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerClaveModulo') DROP FUNCTION fnExtraerClaveModulo
GO
CREATE FUNCTION fnExtraerClaveModulo (@Clave varchar(20))
RETURNS char(5)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p		int,
    @c		char(1),
    @Modulo	varchar(5)
  
  SELECT @Modulo = ''
  SELECT @p = 1
  WHILE @p <= LEN(@Clave)
  BEGIN
    SELECT @c = SUBSTRING(@Clave, @p, 1)
    IF dbo.fnEsNumerico(@c) = 0 SELECT @Modulo = @Modulo + @c ELSE BREAK
    SELECT @p = @p + 1
  END
  RETURN (NULLIF(@Modulo, ''))
END
GO

-- select dbo.fnSegundoEntreParentesis('Sin Afectar', 'En Espera')
/**************** fnSegundoEntreParentesis ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSegundoEntreParentesis') DROP FUNCTION fnSegundoEntreParentesis
GO
CREATE FUNCTION fnSegundoEntreParentesis (@Nombre varchar(100), @Nombre2 varchar(100))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Nombre = NULLIF(RTRIM(@Nombre), ''), @Nombre2 = NULLIF(RTRIM(@Nombre2), '')
  SELECT @Resultado = @Nombre
  IF @Nombre2 IS NOT NULL
    SELECT @Resultado = @Resultado + ' ('+@Nombre2+')'
  RETURN (@Resultado)
END
GO


-- select dbo.fnCamposTabla('VentaD')
-- select MatrizOut.dbo.fnCamposTabla('VentaD')
/**************** fnCamposTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCamposTabla') DROP FUNCTION fnCamposTabla
GO
CREATE FUNCTION fnCamposTabla (@Tabla varchar(100))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Campo	varchar(100),
    @Resultado	varchar(8000)

  SELECT @Resultado = ''
  DECLARE crSysCampo CURSOR LOCAL FOR
   SELECT RTRIM(Campo)
     FROM SysCampo
    WHERE Tabla = @Tabla AND Campo <> 'SincroID' AND EsCalculado = 0

  OPEN crSysCampo
  FETCH NEXT FROM crSysCampo INTO @Campo
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Resultado <> '' SELECT @Resultado = @Resultado + ','
      SELECT @Resultado = @Resultado + @Campo
    END
    FETCH NEXT FROM crSysCampo INTO @Campo
  END
  CLOSE crSysCampo
  DEALLOCATE crSysCampo
  
  RETURN (@Resultado)
END
GO

-- select dbo.fnMovEstatus('VTAS', 79)
-- select * from venta
/**************** fnMovEstatus ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovEstatus') DROP FUNCTION fnMovEstatus
GO
CREATE FUNCTION fnMovEstatus (@Modulo char(5), @ID int)
RETURNS varchar(15)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Estatus	varchar(15)
  SELECT @Estatus = NULL

  IF @Modulo = 'VTAS'  SELECT @Estatus = Estatus FROM Venta 		WHERE ID = @ID ELSE
  IF @Modulo = 'CXC'   SELECT @Estatus = Estatus FROM Cxc 		WHERE ID = @ID ELSE
  IF @Modulo = 'ST'    SELECT @Estatus = Estatus FROM Soporte 		WHERE ID = @ID ELSE
  IF @Modulo = 'COMS'  SELECT @Estatus = Estatus FROM Compra 		WHERE ID = @ID ELSE
  IF @Modulo = 'CXP'   SELECT @Estatus = Estatus FROM Cxp 		WHERE ID = @ID ELSE
  IF @Modulo = 'AGENT' SELECT @Estatus = Estatus FROM Agent 		WHERE ID = @ID ELSE
  IF @Modulo = 'GAS'   SELECT @Estatus = Estatus FROM Gasto 		WHERE ID = @ID ELSE
  IF @Modulo = 'DIN'   SELECT @Estatus = Estatus FROM Dinero    	WHERE ID = @ID ELSE
  IF @Modulo = 'AF'    SELECT @Estatus = Estatus FROM ActivoFijo 	WHERE ID = @ID ELSE
  IF @Modulo = 'VALE'  SELECT @Estatus = Estatus FROM Vale 		WHERE ID = @ID ELSE
  IF @Modulo = 'CR'    SELECT @Estatus = Estatus FROM CR 		WHERE ID = @ID ELSE
  IF @Modulo = 'CAM'   SELECT @Estatus = Estatus FROM Cambio 		WHERE ID = @ID ELSE
  IF @Modulo = 'CAP'   SELECT @Estatus = Estatus FROM Capital 		WHERE ID = @ID ELSE
  IF @Modulo = 'INC'   SELECT @Estatus = Estatus FROM Incidencia 	WHERE ID = @ID ELSE
  IF @Modulo = 'CONC'  SELECT @Estatus = Estatus FROM Conciliacion	WHERE ID = @ID ELSE
  IF @Modulo = 'PPTO'  SELECT @Estatus = Estatus FROM Presup		WHERE ID = @ID ELSE
  IF @Modulo = 'CREDI' SELECT @Estatus = Estatus FROM Credito		WHERE ID = @ID ELSE
  IF @Modulo = 'TMA'   SELECT @Estatus = Estatus FROM TMA 		WHERE ID = @ID ELSE
  IF @Modulo = 'RSS'   SELECT @Estatus = Estatus FROM RSS 		WHERE ID = @ID ELSE
  IF @Modulo = 'CMP'   SELECT @Estatus = Estatus FROM Campana		WHERE ID = @ID ELSE
  IF @Modulo = 'FIS'   SELECT @Estatus = Estatus FROM Fiscal		WHERE ID = @ID ELSE
  --REQ25014
  IF @Modulo = 'CONTP' SELECT @Estatus = Estatus FROM ContParalela	WHERE ID = @ID ELSE  
  --REQ16092
  IF @Modulo = 'OPORT' SELECT @Estatus = Estatus FROM Oportunidad   WHERE ID = @ID ELSE  
  IF @Modulo = 'CORTE' SELECT @Estatus = Estatus FROM Corte		    WHERE ID = @ID ELSE  
  --IF @Modulo = 'ACT'   SELECT @Estatus = Estatus FROM Act        	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX01' SELECT @Estatus = Estatus FROM ModuloExtra01	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX02' SELECT @Estatus = Estatus FROM ModuloExtra02	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX03' SELECT @Estatus = Estatus FROM ModuloExtra03	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX04' SELECT @Estatus = Estatus FROM ModuloExtra04	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX05' SELECT @Estatus = Estatus FROM ModuloExtra05	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX06' SELECT @Estatus = Estatus FROM ModuloExtra06	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX07' SELECT @Estatus = Estatus FROM ModuloExtra07	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX08' SELECT @Estatus = Estatus FROM ModuloExtra08	WHERE ID = @ID ELSE
  --IF @Modulo = 'MEX09' SELECT @Estatus = Estatus FROM ModuloExtra09	WHERE ID = @ID ELSE
  IF @Modulo = 'ORG'   SELECT @Estatus = Estatus FROM Organiza		WHERE ID = @ID ELSE
  IF @Modulo = 'RE'    SELECT @Estatus = Estatus FROM Recluta		WHERE ID = @ID ELSE
  IF @Modulo = 'ISL'   SELECT @Estatus = Estatus FROM ISL		WHERE ID = @ID ELSE
  IF @Modulo = 'FRM'   SELECT @Estatus = Estatus FROM FormaExtra	WHERE ID = @ID ELSE
  IF @Modulo = 'CAPT'  SELECT @Estatus = Estatus FROM Captura		WHERE ID = @ID ELSE
  IF @Modulo = 'GES'   SELECT @Estatus = Estatus FROM Gestion		WHERE ID = @ID ELSE
  IF @Modulo = 'CP'    SELECT @Estatus = Estatus FROM CP		WHERE ID = @ID ELSE
  IF @Modulo = 'PCP'   SELECT @Estatus = Estatus FROM PCP		WHERE ID = @ID ELSE  
  IF @Modulo = 'CONT'  SELECT @Estatus = Estatus FROM Cont 		WHERE ID = @ID ELSE
  IF @Modulo = 'PROD'  SELECT @Estatus = Estatus FROM Prod 		WHERE ID = @ID ELSE
  IF @Modulo = 'INV'   SELECT @Estatus = Estatus FROM Inv 		WHERE ID = @ID ELSE
  IF @Modulo = 'PC'    SELECT @Estatus = Estatus FROM PC 		WHERE ID = @ID ELSE
  IF @Modulo = 'OFER'  SELECT @Estatus = Estatus FROM Oferta		WHERE ID = @ID ELSE
  IF @Modulo = 'PACTO' SELECT @Estatus = Estatus FROM Contrato		WHERE ID = @ID ELSE
  IF @Modulo = 'NOM'   SELECT @Estatus = Estatus FROM Nomina 		WHERE ID = @ID ELSE
  IF @Modulo = 'RH'    SELECT @Estatus = Estatus FROM RH 			WHERE ID = @ID ELSE
  IF @Modulo = 'ASIS'  SELECT @Estatus = Estatus FROM Asiste 		WHERE ID = @ID ELSE
  IF @Modulo = 'EMB'   SELECT @Estatus = Estatus FROM Embarque 		WHERE ID = @ID ELSE
  IF @Modulo = 'SAUX'  SELECT @Estatus = Estatus FROM SAUX 			WHERE ID = @ID 

  RETURN (@Estatus)
END
GO 

-- select dbo.fnExtraerOpcionNumero('C123T456A', 'C')
/**************** fnExtraerOpcionNumero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerOpcionNumero') DROP FUNCTION fnExtraerOpcionNumero
GO
CREATE FUNCTION fnExtraerOpcionNumero (@SubCuenta varchar(50), @Opcion char(1))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @p		int,
    @s		varchar(50),
    @c		varchar(1),
    @Resultado	int
  SELECT @Resultado = NULL
  SELECT @p = CHARINDEX(@Opcion, @SubCuenta)
  IF @p>0 
  BEGIN
    SELECT @s = ''
    WHILE @p<LEN(@SubCuenta)
    BEGIN
      SELECT @p = @p + 1
      SELECT @c = SUBSTRING(@SubCuenta, @p, 1)
      IF dbo.fnEsNumerico(@c) = 1
        SELECT @s = @s + @c
      ELSE BREAK
    END
    IF @s <> '' AND dbo.fnEsNumerico(@s) = 1
      SELECT @Resultado = CONVERT(int, @s)
  END
  RETURN (@Resultado)
END
GO

-- select lower(dbo.fnNumeroEnEspanol(123456.123, 'Pesos'))
/**************** fnNumeroEnEspanol ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnNumeroEnEspanol') DROP FUNCTION fnNumeroEnEspanol
GO
--BUG12424
CREATE FUNCTION fnNumeroEnEspanol (@Numero decimal(38,2), @Moneda varchar(10))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Letras	varchar(255),
    @lnEntero 	int, 
    @lcRetorno 	varchar(512), 
    @lnTerna 	int, 
    @lcMiles 	varchar(512),
    @lcCadena 	varchar(512),
    @lnUnidades int, 
    @lnDecenas 	int,
    @lnCentenas int,
    @lnFraccion int

  SELECT @lnEntero   = CAST(@Numero AS INT),
         @lnFraccion = (@Numero - @lnEntero) * 100,
         @lcRetorno  = '', 
         @lnTerna    = 1

  WHILE @lnEntero > 0
  BEGIN /* WHILE */
    -- Recorro terna por terna
    SELECT @lcCadena   = ''
    SELECT @lnUnidades = @lnEntero % 10
    SELECT @lnEntero   = CAST(@lnEntero/10 AS INT)
    SELECT @lnDecenas  = @lnEntero % 10
    SELECT @lnEntero   = CAST(@lnEntero/10 AS INT)
    SELECT @lnCentenas = @lnEntero % 10
    SELECT @lnEntero   = CAST(@lnEntero/10 AS INT)

    -- Analizo las unidades
    SELECT @lcCadena =
    CASE /* UNIDADES */
      WHEN @lnUnidades = 1 AND @lnTerna = 1 THEN 'UN ' + @lcCadena
      WHEN @lnUnidades = 1 AND @lnTerna <> 1 THEN 'UN ' + @lcCadena
      WHEN @lnUnidades = 2 THEN 'DOS ' + @lcCadena
      WHEN @lnUnidades = 3 THEN 'TRES ' + @lcCadena
      WHEN @lnUnidades = 4 THEN 'CUATRO ' + @lcCadena
      WHEN @lnUnidades = 5 THEN 'CINCO ' + @lcCadena
      WHEN @lnUnidades = 6 THEN 'SEIS ' + @lcCadena
      WHEN @lnUnidades = 7 THEN 'SIETE ' + @lcCadena
      WHEN @lnUnidades = 8 THEN 'OCHO ' + @lcCadena
      WHEN @lnUnidades = 9 THEN 'NUEVE ' + @lcCadena
      ELSE @lcCadena
    END /* UNIDADES */

    -- Analizo las decenas
    SELECT @lcCadena =
    CASE /* DECENAS */
      WHEN @lnDecenas = 1 THEN
        CASE @lnUnidades
          WHEN 0 THEN 'DIEZ '
          WHEN 1 THEN 'ONCE '
          WHEN 2 THEN 'DOCE '
          WHEN 3 THEN 'TRECE '
          WHEN 4 THEN 'CATORCE '
          WHEN 5 THEN 'QUINCE '
          ELSE 'DIECI' + @lcCadena
        END
      WHEN @lnDecenas = 2 AND @lnUnidades = 0 THEN 'VEINTE ' + @lcCadena
      WHEN @lnDecenas = 2 AND @lnUnidades <> 0 THEN 'VEINTI' + @lcCadena
      WHEN @lnDecenas = 3 AND @lnUnidades = 0 THEN 'TREINTA ' + @lcCadena
      WHEN @lnDecenas = 3 AND @lnUnidades <> 0 THEN 'TREINTA Y ' + @lcCadena
      WHEN @lnDecenas = 4 AND @lnUnidades = 0 THEN 'CUARENTA ' + @lcCadena
      WHEN @lnDecenas = 4 AND @lnUnidades <> 0 THEN 'CUARENTA Y ' + @lcCadena
      WHEN @lnDecenas = 5 AND @lnUnidades = 0 THEN 'CINCUENTA ' + @lcCadena
      WHEN @lnDecenas = 5 AND @lnUnidades <> 0 THEN 'CINCUENTA Y ' + @lcCadena
      WHEN @lnDecenas = 6 AND @lnUnidades = 0 THEN 'SESENTA ' + @lcCadena
      WHEN @lnDecenas = 6 AND @lnUnidades <> 0 THEN 'SESENTA Y ' + @lcCadena
      WHEN @lnDecenas = 7 AND @lnUnidades = 0 THEN 'SETENTA ' + @lcCadena
      WHEN @lnDecenas = 7 AND @lnUnidades <> 0 THEN 'SETENTA Y ' + @lcCadena
      WHEN @lnDecenas = 8 AND @lnUnidades = 0 THEN 'OCHENTA ' + @lcCadena
      WHEN @lnDecenas = 8 AND @lnUnidades <> 0 THEN 'OCHENTA Y ' + @lcCadena
      WHEN @lnDecenas = 9 AND @lnUnidades = 0 THEN 'NOVENTA ' + @lcCadena
      WHEN @lnDecenas = 9 AND @lnUnidades <> 0 THEN 'NOVENTA Y ' + @lcCadena
      ELSE @lcCadena
    END /* DECENAS */


    -- Analizo las centenas
    SELECT @lcCadena =
    CASE /* CENTENAS */
      WHEN @lnCentenas = 1 AND @lnUnidades = 0 AND @lnDecenas = 0 THEN 'CIEN ' + @lcCadena
      WHEN @lnCentenas = 1 AND NOT(@lnUnidades = 0 AND @lnDecenas = 0) THEN 'CIENTO ' + @lcCadena
      WHEN @lnCentenas = 2 THEN 'DOSCIENTOS ' + @lcCadena
      WHEN @lnCentenas = 3 THEN 'TRESCIENTOS ' + @lcCadena
      WHEN @lnCentenas = 4 THEN 'CUATROCIENTOS ' + @lcCadena
      WHEN @lnCentenas = 5 THEN 'QUINIENTOS ' + @lcCadena
      WHEN @lnCentenas = 6 THEN 'SEISCIENTOS ' + @lcCadena
      WHEN @lnCentenas = 7 THEN 'SETECIENTOS ' + @lcCadena
      WHEN @lnCentenas = 8 THEN 'OCHOCIENTOS ' + @lcCadena
      WHEN @lnCentenas = 9 THEN 'NOVECIENTOS ' + @lcCadena
      ELSE @lcCadena
    END /* CENTENAS */

    -- Analizo la terna
    SELECT @lcCadena = 
    CASE /* TERNA */
      WHEN @lnTerna = 1 THEN @lcCadena
      WHEN @lnTerna = 2 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) THEN @lcCadena + 'MIL '
      WHEN @lnTerna = 3 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) AND 
        @lnUnidades = 1 AND @lnDecenas = 0 AND @lnCentenas = 0 THEN @lcCadena + 'MILLON '
      WHEN @lnTerna = 3 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) AND
        NOT (@lnUnidades = 1 AND @lnDecenas = 0 AND @lnCentenas = 0) THEN @lcCadena + 'MILLONES '
      WHEN @lnTerna = 4 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) THEN @lcCadena + 'MIL MILLONES '
      ELSE ''
    END /* TERNA */

    -- Armo el retorno terna a terna
    SELECT @lcRetorno = @lcCadena  + @lcRetorno
    SELECT @lnTerna = @lnTerna + 1

  END /* WHILE */

  IF @lnTerna = 1  
    SELECT @lcRetorno = 'CERO'
    
    
    IF EXISTS (SELECT Clave FROM Mon WHERE Clave = @Moneda)
    SELECT @Moneda = Moneda FROM Mon WHERE Clave = @Moneda
--  SELECT @Letras = RTRIM(@lcRetorno) + ' ' +RTRIM(UPPER(@Moneda))+ ' ' + LTRIM(STR(@lnFraccion,2)) + '/100'
  

--  SELECT @Letras = RTRIM(@lcRetorno) + ' ' +RTRIM(UPPER(@Moneda))+ ' ' + LTRIM(STR(@lnFraccion,2)) + '/100'
  --SELECT @Letras = RTRIM(@lcRetorno) + ' ' +RTRIM(UPPER(@Moneda))+ ' ' + REPLICATE('0',2-LEN(LTRIM(STR(@lnFraccion,2)))) + LTRIM(STR(@lnFraccion,2)) + '/100'
  --SELECT @Letras = RTRIM(@lcRetorno) + ' ' + REPLICATE('0',2-LEN(LTRIM(STR(@lnFraccion,2)))) + LTRIM(STR(@lnFraccion,2)) + '/100'+ ' ' +RTRIM(UPPER(@Moneda))
  
  IF @Moneda = 'Pesos'

       SELECT @Letras = RTRIM(@lcRetorno)+ ' ' +RTRIM(UPPER(@Moneda)) + ' ' + REPLICATE('0',2-LEN(LTRIM(STR(@lnFraccion,2)))) + LTRIM(STR(@lnFraccion,2)) + '/100 M.N.'
       ELSE
       SELECT @Letras = RTRIM(@lcRetorno)+ ' ' +RTRIM(UPPER(@Moneda)) + ' ' + REPLICATE('0',2-LEN(LTRIM(STR(@lnFraccion,2)))) + LTRIM(STR(@lnFraccion,2)) + '/100'
 


  RETURN (@Letras)
END
GO
/**************** fnQuitarDoblesEspacios ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnQuitarDoblesEspacios') DROP FUNCTION fnQuitarDoblesEspacios
GO
CREATE FUNCTION fnQuitarDoblesEspacios (@Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltValor varchar(8000)

  SELECT @Valor = LTRIM(RTRIM(@Valor)), @UltValor = NULL
  WHILE @Valor <> @UltValor
  BEGIN
    SELECT @UltValor = @Valor
    SELECT @Valor = REPLACE(@Valor, '  ', ' ')
  END
  RETURN (@Valor)
END
GO

-- select dbo.fnComillas('Hola')
/**************************** fnComillas ********************************/
if exists (select * from sysobjects where id = object_id('dbo.fnComillas') and type in ('fn','tf')) drop function dbo.fnComillas
GO
CREATE FUNCTION fnComillas (@Valor varchar(max))
RETURNS varchar(max)
AS BEGIN		
  RETURN ('''' + LTRIM(RTRIM(ISNULL(@Valor, ''))) + '''')
END
GO

-- select dbo.fnQuitarComillas('"pepe"')
-- select dbo.fnQuitarComillas('"')
/**************** fnQuitarComillas ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnQuitarComillas') DROP FUNCTION fnQuitarComillas
GO
CREATE FUNCTION fnQuitarComillas (@Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  IF @Valor IS NOT NULL AND LEN(@Valor)>1
  BEGIN
    IF SUBSTRING(@Valor, 1, 1) IN ('"', '''') AND 
       SUBSTRING(@Valor, 1, 1) = SUBSTRING(@Valor, LEN(@Valor), 1)
     SELECT @Valor = SUBSTRING(@Valor, 2, LEN(@Valor)-2)
  END
  RETURN (@Valor)
END
GO


/**************** fnXMLValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLValor') DROP FUNCTION fnXMLValor
GO
CREATE FUNCTION fnXMLValor (@Valor varchar(max))
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
/*
  SELECT @Valor = REPLACE(@Valor,'€', 'euros')
  SELECT @Valor = REPLACE(@Valor,'‚',',')
  SELECT @Valor = REPLACE(@Valor,'ƒ','')
  SELECT @Valor = REPLACE(@Valor,'„',',,')
  SELECT @Valor = REPLACE(@Valor,'…','...')
  SELECT @Valor = REPLACE(@Valor,'†','')
  SELECT @Valor = REPLACE(@Valor,'‡','')
  SELECT @Valor = REPLACE(@Valor,'ˆ','')
  SELECT @Valor = REPLACE(@Valor,'‰','0/00')
  SELECT @Valor = REPLACE(@Valor,'Š','')
  SELECT @Valor = REPLACE(@Valor,'‹','<')
  SELECT @Valor = REPLACE(@Valor,'Œ','OE')
  SELECT @Valor = REPLACE(@Valor,'‘',CHAR(39))
  SELECT @Valor = REPLACE(@Valor,'’',CHAR(39))
  SELECT @Valor = REPLACE(@Valor,'“',CHAR(34))
  SELECT @Valor = REPLACE(@Valor,'”',CHAR(34))
  SELECT @Valor = REPLACE(@Valor,'•','-')
  SELECT @Valor = REPLACE(@Valor,'–','-')
  SELECT @Valor = REPLACE(@Valor,'—','-')
  SELECT @Valor = REPLACE(@Valor,'˜','')
  SELECT @Valor = REPLACE(@Valor,'™','Trade Mark')
  SELECT @Valor = REPLACE(@Valor,'š','')
  SELECT @Valor = REPLACE(@Valor,'›','>')
  SELECT @Valor = REPLACE(@Valor,'œ','OE')
  SELECT @Valor = REPLACE(@Valor,'Ÿ','')
  SELECT @Valor = REPLACE(@Valor,'Ž','')
  SELECT @Valor = REPLACE(@Valor,'ž','')
  */
  
  SELECT @Valor = dbo.fnQuitarDoblesEspacios(@Valor)
  SELECT @Valor = NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Valor, '&', '&amp;'), '<', '&lt;'), '>', '&gt;'), '"', '&quot;'), '''', '&#39;'))),'')
   
  RETURN (@Valor)
END
GO

/**************** fnXMLValor2 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLValor2') DROP FUNCTION fnXMLValor2
GO
CREATE FUNCTION fnXMLValor2 (@Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN

  SELECT @Valor = dbo.fnQuitarDoblesEspacios(@Valor)
  SELECT @Valor = NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Valor, '&', ''), '<', ''), '>', ''), '"', ''), '''', ''))),'')
  RETURN (@Valor)
END
GO

-- select dbo.fnXMLValor('  ho    la  ')
-- select dbo.fnXML('Tag', 'Hola') 
-- select dbo.fnXML('Tag', '"Hola" & "Hola"') 
/**************** fnXML ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXML') DROP FUNCTION fnXML
GO
CREATE FUNCTION fnXML (@Parametro varchar(255), @Valor varchar(max))
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(max)

  SELECT @Valor = dbo.fnXMLValor(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+@Valor+'"'

  RETURN(@Resultado)
END
GO

/**************** fnXML4000 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXML4000') DROP FUNCTION fnXML4000
GO
CREATE FUNCTION fnXML4000 (@Parametro varchar(255), @Valor varchar(4000))
RETURNS varchar(4000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(4000)

  SELECT @Valor = dbo.fnXMLValor(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+@Valor+'"'

  RETURN(@Resultado)
END
GO


/**************** fnXML8000 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXML8000') DROP FUNCTION fnXML8000
GO
CREATE FUNCTION fnXML8000 (@Parametro varchar(255), @Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(8000)

  SELECT @Valor = dbo.fnXMLValor(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+@Valor+'"'

  RETURN(@Resultado)
END
GO

-- select dbo.fnXMLBit('param', NULL)
/**************** fnXMLBit ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLBit') DROP FUNCTION fnXMLBit
GO
CREATE FUNCTION fnXMLBit (@Parametro varchar(255), @Valor bit)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, @Valor)+'"'

  RETURN(@Resultado)
END
GO

-- select dbo.fnBitTF(1)
/**************** fnBitTF ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnBitTF') DROP FUNCTION fnBitTF
GO
CREATE FUNCTION fnBitTF (@Valor bit)
RETURNS varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(CASE @Valor WHEN 1 THEN 'TRUE' ELSE 'FALSE' END)
END
GO

-- select dbo.fnXMLBitTF('param', 0)
/**************** fnXMLBitTF ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLBitTF') DROP FUNCTION fnXMLBitTF
GO
CREATE FUNCTION fnXMLBitTF (@Parametro varchar(255), @Valor bit)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+dbo.fnBitTF(@Valor)+'"'

  RETURN(@Resultado)
END
GO

/**************** fnXMLGID ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLGID') DROP FUNCTION fnXMLGID
GO
CREATE FUNCTION fnXMLGID (@Parametro varchar(255), @Valor uniqueidentifier)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar(255), @Valor)+'"'

  RETURN(@Resultado)
END
GO

/**************** fnXMLInt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLInt') DROP FUNCTION fnXMLInt
GO
CREATE FUNCTION fnXMLInt (@Parametro varchar(255), @Valor int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, @Valor)+'"'

  RETURN(@Resultado)
END
GO


/**************** fnXMLBigint ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLBigint') DROP FUNCTION fnXMLBigint
GO
CREATE FUNCTION fnXMLBigint (@Parametro varchar(255), @Valor bigint)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, @Valor)+'"'

  RETURN(@Resultado)
END
GO


/**************** fnXMLFloat ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLFloat') DROP FUNCTION fnXMLFloat
GO
CREATE FUNCTION fnXMLFloat (@Parametro varchar(255), @Valor float)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, @Valor)+'"'

  RETURN(@Resultado)
END
GO

/**************** fnXMLFloat2 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLFloat2') DROP FUNCTION fnXMLFloat2
GO
CREATE FUNCTION fnXMLFloat2 (@Parametro varchar(255), @Valor float)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, ROUND(@Valor, 2))+'"'

  RETURN(@Resultado)
END
GO

/**************** fnXMLDecimal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLDecimal') DROP FUNCTION fnXMLDecimal
GO
CREATE FUNCTION fnXMLDecimal (@Parametro varchar(255), @Valor float, @Decimales int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255),
    @Valor2 varchar(100)
    
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
  BEGIN
    IF @Decimales = 1 SELECT @Valor2 = CONVERT(Decimal(38,1),@Valor)
    IF @Decimales = 2 SELECT @Valor2 = CONVERT(Decimal(38,2),@Valor)
    IF @Decimales = 3 SELECT @Valor2 = CONVERT(Decimal(38,3),@Valor)
    IF @Decimales = 4 SELECT @Valor2 = CONVERT(Decimal(38,4),@Valor)
    IF @Decimales = 5 SELECT @Valor2 = CONVERT(Decimal(38,5),@Valor)
    IF @Decimales >= 6 SELECT @Valor2 = CONVERT(Decimal(38,6),@Valor)
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar,@Valor2)+'"'
  END

  RETURN(@Resultado)
END
GO

/**************** fnXMLMoney ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLMoney') DROP FUNCTION fnXMLMoney
GO
CREATE FUNCTION fnXMLMoney (@Parametro varchar(255), @Valor money)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+CONVERT(varchar, @Valor)+'"'

  RETURN(@Resultado)
END
GO
-- select dbo.fnXMLDatetime('Fecha', getdate())
/**************** fnXMLDatetime ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLDatetime') DROP FUNCTION fnXMLDatetime
GO
CREATE FUNCTION fnXMLDatetime (@Parametro varchar(255), @Valor datetime)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+LEFT(CONVERT(varchar, @Valor, 126),19)+'"'

  RETURN(@Resultado)
END
GO

/************** fnLlenarCeros *************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnLlenarCeros') DROP FUNCTION fnLlenarCeros
GO
/*
CREATE FUNCTION fnLlenarCeros (@Consecutivo bigint, @Digitos int)
RETURNS varchar(16)
			
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Negativo	bit,
    @Clave	varchar(16)
  SELECT @Negativo = 0
  IF @Consecutivo < 0 SELECT @Digitos = @Digitos - 1, @Consecutivo = -@Consecutivo, @Negativo = 1
  SELECT @Clave = LTRIM(Convert(char, @Consecutivo))
  IF @Digitos > 1  AND @Consecutivo < 10               SELECT @Clave = '0' + @Clave
  IF @Digitos > 2  AND @Consecutivo < 100              SELECT @Clave = '0' + @Clave
  IF @Digitos > 3  AND @Consecutivo < 1000             SELECT @Clave = '0' + @Clave
  IF @Digitos > 4  AND @Consecutivo < 10000            SELECT @Clave = '0' + @Clave
  IF @Digitos > 5  AND @Consecutivo < 100000           SELECT @Clave = '0' + @Clave
  IF @Digitos > 6  AND @Consecutivo < 1000000          SELECT @Clave = '0' + @Clave
  IF @Digitos > 7  AND @Consecutivo < 10000000         SELECT @Clave = '0' + @Clave
  IF @Digitos > 8  AND @Consecutivo < 100000000        SELECT @Clave = '0' + @Clave
  IF @Digitos > 9  AND @Consecutivo < 1000000000       SELECT @Clave = '0' + @Clave
  IF @Digitos > 10 AND @Consecutivo < 10000000000      SELECT @Clave = '0' + @Clave
  IF @Digitos > 11 AND @Consecutivo < 100000000000     SELECT @Clave = '0' + @Clave
  IF @Digitos > 12 AND @Consecutivo < 1000000000000    SELECT @Clave = '0' + @Clave
  IF @Digitos > 13 AND @Consecutivo < 10000000000000   SELECT @Clave = '0' + @Clave
  IF @Digitos > 14 AND @Consecutivo < 100000000000000  SELECT @Clave = '0' + @Clave
  IF @Digitos > 16 AND @Consecutivo < 1000000000000000 SELECT @Clave = '0' + @Clave
  IF @Negativo = 1 SELECT @Clave = '-' + @Clave
  SELECT @Clave = RTRIM(@Clave)
  RETURN (@Clave)
END
*/
-- SELECT dbo.fnllenarCeros('A1',10)
CREATE FUNCTION fnLlenarCeros (@Consecutivo varchar(Max), @Digitos int)
RETURNS varchar(16)
		
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @Negativo	bit,
    @Clave	varchar(16), 
    @DigitosConsecutivo int
  SELECT @Negativo = 0

 IF ISNUMERIC(@Consecutivo) = 1
  IF @Consecutivo < 0 SELECT /*@Digitos = @Digitos - 1, @Consecutivo = -@Consecutivo,*/ @Negativo = 1

IF @Negativo = 1
  SELECT @DigitosConsecutivo = LEN(@Consecutivo), @Clave = Stuff(@Consecutivo, 1, 1,'')
ELSE 
SELECT @DigitosConsecutivo = LEN(@Consecutivo), @Clave = LTRIM(Convert(char, @Consecutivo))

  IF @Digitos > 1  AND @DigitosConsecutivo < 2  SELECT @Clave = '0' + @Clave
  IF @Digitos > 2  AND @DigitosConsecutivo < 3  SELECT @Clave = '0' + @Clave
  IF @Digitos > 3  AND @DigitosConsecutivo < 4  SELECT @Clave = '0' + @Clave
  IF @Digitos > 4  AND @DigitosConsecutivo < 5  SELECT @Clave = '0' + @Clave
  IF @Digitos > 5  AND @DigitosConsecutivo < 6  SELECT @Clave = '0' + @Clave
  IF @Digitos > 6  AND @DigitosConsecutivo < 7  SELECT @Clave = '0' + @Clave
  IF @Digitos > 7  AND @DigitosConsecutivo < 8  SELECT @Clave = '0' + @Clave
  IF @Digitos > 8  AND @DigitosConsecutivo < 9  SELECT @Clave = '0' + @Clave
  IF @Digitos > 9  AND @DigitosConsecutivo < 10 SELECT @Clave = '0' + @Clave
  IF @Digitos > 10 AND @DigitosConsecutivo < 11 SELECT @Clave = '0' + @Clave
  IF @Digitos > 11 AND @DigitosConsecutivo < 12 SELECT @Clave = '0' + @Clave
  IF @Digitos > 12 AND @DigitosConsecutivo < 13 SELECT @Clave = '0' + @Clave
  IF @Digitos > 13 AND @DigitosConsecutivo < 14 SELECT @Clave = '0' + @Clave
  IF @Digitos > 14 AND @DigitosConsecutivo < 15 SELECT @Clave = '0' + @Clave
  IF @Digitos > 16 AND @DigitosConsecutivo < 17 SELECT @Clave = '0' + @Clave
  IF @Negativo = 1 SELECT @Clave = '-' + @Clave
  SELECT @Clave = RTRIM(@Clave)
  RETURN (@Clave)
END
GO

--SET DATEFIRST 7
-- select dbo.fnDiaSemanaIngles(getdate())
/**************** fnDiaSemanaIngles ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiaSemanaIngles') DROP FUNCTION fnDiaSemanaIngles
GO
CREATE FUNCTION fnDiaSemanaIngles (@Fecha datetime)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @d		int,
    @Resultado	varchar(20)

  SELECT @d = DATEPART(weekday, @Fecha)
  IF @d = 1 SELECT @Resultado = 'Sunday' 	ELSE
  IF @d = 2 SELECT @Resultado = 'Monday' 	ELSE
  IF @d = 3 SELECT @Resultado = 'Tuesday' 	ELSE
  IF @d = 4 SELECT @Resultado = 'Wednesday' 	ELSE
  IF @d = 5 SELECT @Resultado = 'Thursday' 	ELSE
  IF @d = 6 SELECT @Resultado = 'Friday' 	ELSE
  IF @d = 7 SELECT @Resultado = 'Saturday' 	

  RETURN(@Resultado)
END
GO


--SET DATEFIRST 7
-- select dbo.fnDiaSemanaEspanol(getdate())
/**************** fnDiaSemanaEspanol ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiaSemanaEspanol') DROP FUNCTION fnDiaSemanaEspanol
GO
CREATE FUNCTION fnDiaSemanaEspanol (@Fecha datetime)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @d		int,
    @Resultado	varchar(20)

  SELECT @d = DATEPART(weekday, @Fecha)
  IF @d = 1 SELECT @Resultado = 'Domingo' 	ELSE
  IF @d = 2 SELECT @Resultado = 'Lunes' 	ELSE
  IF @d = 3 SELECT @Resultado = 'Martes' 	ELSE
  IF @d = 4 SELECT @Resultado = 'Miercoles' 	ELSE
  IF @d = 5 SELECT @Resultado = 'Jueves' 	ELSE
  IF @d = 6 SELECT @Resultado = 'Viernes' 	ELSE
  IF @d = 7 SELECT @Resultado = 'Sabado' 	

  RETURN(@Resultado)
END
GO

-- select dbo.fnDateTimeFmt(GETDATE(), 'RFC822')
-- select CONVERT(varchar, GETDATE(), 113)
/**************** fnDateTimeFmt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDateTimeFmt') DROP FUNCTION fnDateTimeFmt
GO
CREATE FUNCTION fnDateTimeFmt (@Valor datetime, @Formato varchar(20))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @FechaSt	varchar(50)

  IF @Formato = 'AAAAMMDD' 
    SELECT @FechaSt = CONVERT(varchar, @Valor, 112)
  ELSE
  IF @Formato = 'AAAA-MM-DD' 
    SELECT @FechaSt = dbo.fnLlenarCeros(YEAR(@Valor), 4)+'-'+dbo.fnLlenarCeros(MONTH(@Valor), 2)+'-'+dbo.fnLlenarCeros(DAY(@Valor), 2)
  ELSE
  IF @Formato = 'AAMMDDHHMMSSMM'
    SELECT @FechaSt = CONVERT(varchar, @Valor, 12)+SUBSTRING(REPLACE(CONVERT(varchar, @Valor, 14), ':', ''), 1, 8)
  ELSE
  IF @Formato = 'DD/MM/AAAA'
    SELECT @FechaSt = dbo.fnLlenarCeros(DAY(@Valor), 2)+'/'+dbo.fnLlenarCeros(MONTH(@Valor), 2)+'/'+dbo.fnLlenarCeros(YEAR(@Valor), 4)
  ELSE
  IF @Formato = 'RFC822'
    SELECT @FechaSt = SUBSTRING(dbo.fnDiaSemanaIngles(@Valor), 1, 3)+', '+SUBSTRING(CONVERT(varchar(50), @Valor, 113), 1, 20)

  RETURN(@FechaSt)
END
GO

/**************** fnXMLParametro ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLParametro') DROP FUNCTION fnXMLParametro
GO
CREATE FUNCTION fnXMLParametro (@Parametro varchar(max))
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(max)
  SELECT @Resultado = REPLACE(@Parametro, ' ', '_')
  IF dbo.fnEsNumerico(SUBSTRING(@Resultado, 1, 1)) = 1 SELECT @Resultado = '_' + @Resultado
  RETURN(@Resultado)
END
GO

/**************** fnXMLDateTimeFmt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLDateTimeFmt') DROP FUNCTION fnXMLDateTimeFmt
GO
CREATE FUNCTION fnXMLDateTimeFmt (@Parametro varchar(255), @Valor datetime, @Formato varchar(20))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = ' '+dbo.fnXMLParametro(@Parametro)+'="'+dbo.fnDatetimeFmt(@Valor, @Formato)+'"'

  RETURN(@Resultado)
END
GO
-- select dbo.fnXMLDateTimeFmt('Fecha', GETDATE(), 'AAAA-MM-DD')

/**************** fnTag ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTag') DROP FUNCTION fnTag
GO
CREATE FUNCTION fnTag (@Parametro varchar(255), @Valor varchar(8000))
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(8000)

  SELECT @Valor = dbo.fnXMLValor(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+@Valor+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO
-- select dbo.fnTag2('Clave', 'Valor', 'Nombre', 'Prueba', 0)
-- select dbo.fnTag2('Clave', 'Valor', 'Nombre', NULL, 0)

/**************** fnTag2 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTag2') DROP FUNCTION fnTag2
GO
CREATE FUNCTION fnTag2 (@Parametro varchar(255), @Valor varchar(8000), @Etiqueta1 varchar(100), @Nombre1 varchar(255), @CDATA bit)
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(8000)

  SELECT @Valor = dbo.fnXMLValor(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE BEGIN
    IF @CDATA = 1 SELECT @Valor = '<![CDATA['+@Valor+']]>'
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+dbo.fnXML(@Etiqueta1, @Nombre1)+'>'+@Valor+'</'+dbo.fnXMLParametro(@Parametro)+'>'
  END

  RETURN(@Resultado)
END
GO


/**************** fnTagInt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagInt') DROP FUNCTION fnTagInt
GO
CREATE FUNCTION fnTagInt (@Parametro varchar(255), @Valor int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Valor = RTRIM(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+CONVERT(varchar, @Valor)+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO

/**************** fnTagFloat ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagFloat') DROP FUNCTION fnTagFloat
GO
CREATE FUNCTION fnTagFloat (@Parametro varchar(255), @Valor float)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Valor = RTRIM(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+CONVERT(varchar, @Valor)+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO

/**************** fnTagMoney ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagMoney') DROP FUNCTION fnTagMoney
GO
CREATE FUNCTION fnTagMoney (@Parametro varchar(255), @Valor Money)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

--  SELECT @Valor = RTRIM(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+CONVERT(varchar, @Valor)+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO

/**************** fnTagDatetime ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagDatetime') DROP FUNCTION fnTagDatetime
GO
CREATE FUNCTION fnTagDatetime (@Parametro varchar(255), @Valor datetime)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Valor = RTRIM(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+CONVERT(varchar, @Valor, 126)+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO
-- select dbo.fnTagDatetime('Ahora', GETDATE())

/**************** fnTagDatetimeFmt ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagDatetimeFmt') DROP FUNCTION fnTagDatetimeFmt
GO
CREATE FUNCTION fnTagDatetimeFmt (@Parametro varchar(255), @Valor datetime, @Formato varchar(20))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Valor = RTRIM(@Valor)
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+dbo.fnDatetimeFmt(@Valor, @Formato)+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO
-- select dbo.fnTagDatetimeFmt('Hoy', GETDATE(), 'RFC822')


/**************** fnTagDatetimeFmtZH ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTagDatetimeFmtZH') DROP FUNCTION fnTagDatetimeFmtZH
GO
CREATE FUNCTION fnTagDatetimeFmtZH (@Parametro varchar(255), @Valor datetime, @Formato varchar(20), @ZonaHoraria varchar(20))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Valor = RTRIM(@Valor), @ZonaHoraria = NULLIF(RTRIM(@ZonaHoraria), '')
  IF @ZonaHoraria IS NOT NULL SELECT @ZonaHoraria = ' '+@ZonaHoraria
  IF @Valor IS NULL
    SELECT @Resultado = ''
  ELSE
    SELECT @Resultado = '<'+dbo.fnXMLParametro(@Parametro)+'>'+dbo.fnDatetimeFmt(@Valor, @Formato)+ISNULL(@ZonaHoraria, '')+'</'+dbo.fnXMLParametro(@Parametro)+'>'

  RETURN(@Resultado)
END
GO
-- select dbo.fnTagDatetimeFmtZH('Hoy', GETDATE(), 'RFC822', 'GMT')

/**************** fnEDIMax ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEDIMax') DROP FUNCTION fnEDIMax
GO
CREATE FUNCTION fnEDIMax (@Valor varchar(255), @Max int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)

  SELECT @Resultado = ''
  IF LEN(@Valor)>@Max
  BEGIN
    WHILE @Valor <> ''
    BEGIN
      IF @Resultado <> '' SELECT @Resultado = @Resultado + ':'

      IF LEN(@Valor) <= @Max 
      BEGIN
        SELECT @Resultado = @Resultado + @Valor
        SELECT @Valor = ''
      END ELSE 
      BEGIN
        SELECT @Resultado = @Resultado + SUBSTRING(@Valor, 1, @Max)
        SELECT @Valor = SUBSTRING(@Valor, @Max+1, LEN(@Valor))
      END
    END
  END ELSE
    SELECT @Resultado = @Valor

  RETURN(@Resultado)
END
GO
-- select dbo.fnEDIMAX('NUEVA WAL MART DE MEXICO S DE RL DE CV', 35)

/**************** fnEDIDatetime ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEDIDatetime') DROP FUNCTION fnEDIDatetime
GO
CREATE FUNCTION fnEDIDatetime (@Valor datetime)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(CONVERT(varchar, @Valor, 12)+':'+CONVERT(varchar, datepart(hh, @Valor))+CONVERT(varchar, datepart(mi, @Valor)))
END
GO
-- select dbo.fnEDIDatetime(getdate())


-- select dbo.fnContactoTipo1('Cliente')
/**************** fnContactoTipo1 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoTipo1') DROP FUNCTION fnContactoTipo1
GO
CREATE FUNCTION fnContactoTipo1 (@ContactoTipo varchar(20))
RETURNS char(1)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado char(1)

  SELECT @Resultado = '', @ContactoTipo = UPPER(@ContactoTipo)
  IF @ContactoTipo = 'CLIENTE'   SELECT @Resultado = 'C' ELSE
  IF @ContactoTipo = 'PROVEEDOR' SELECT @Resultado = 'P' ELSE
  IF @ContactoTipo = 'PERSONAL'  SELECT @Resultado = 'E' ELSE
  IF @ContactoTipo = 'AGENTE'    SELECT @Resultado = 'A' ELSE
  IF @ContactoTipo = 'PROSPECTO' SELECT @Resultado = 'R' ELSE
  IF @ContactoTipo = 'SUCURSAL'  SELECT @Resultado = 'S' ELSE
  IF @ContactoTipo = 'EMPRESA'   SELECT @Resultado = 'M' ELSE
  SELECT @Resultado = SUBSTRING(@ContactoTipo, 1, 1)

  RETURN (@Resultado)
END
GO

-- select dbo.fnEstructuraRama('1123123.1')
/**************** fnEstructuraRama ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraRama') DROP FUNCTION fnEstructuraRama
GO
CREATE FUNCTION fnEstructuraRama (@Clave varchar(50))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a 		int,
    @Resultado 	varchar(50)

  SELECT @Resultado = NULL
  SELECT @a = CHARINDEX('.', REVERSE(@Clave), 1)
  IF @a > 0
    SELECT @Resultado = SUBSTRING(@Clave, 1, LEN(@Clave)-@a) 
  
  RETURN (@Resultado)
END
GO


-- select dbo.fnEstructuraOk('1.1')
/**************** fnEstructuraOk ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraOk') DROP FUNCTION fnEstructuraOk
GO
/*CREATE FUNCTION fnEstructuraOk (@Clave varchar(20))
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a 		int,
    @Resultado 	bit

  SELECT @Resultado = 1
  IF LEN(ISNULL(@Clave, '')) > 0
  BEGIN
    IF SUBSTRING(@Clave, 1, 1) NOT BETWEEN '0' AND '9' SELECT @Resultado = 0 ELSE
    IF SUBSTRING(@Clave, LEN(@Clave), 1) NOT BETWEEN '0' AND '9' SELECT @Resultado = 0 ELSE 
    IF CHARINDEX('..', @Clave) > 0 SELECT @Resultado = 0 ELSE 
    BEGIN
      SELECT @a = 1
      WHILE @a <= LEN(@Clave) AND @Resultado = 1
      BEGIN
        IF (SUBSTRING(@Clave, @a, 1) BETWEEN '0' AND '9') OR (SUBSTRING(@Clave, @a, 1)='.') SELECT @Resultado = 1 ELSE SELECT @Resultado = 0
        SELECT @a = @a + 1
      END
    END
  END

  RETURN (@Resultado)
END*/
GO

-- select dbo.fnEstructuraEnOrden('1.2.3.4.5.6.7.8', 6)
/**************** fnEstructuraEnOrden ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraEnOrden') DROP FUNCTION fnEstructuraEnOrden
GO
CREATE FUNCTION fnEstructuraEnOrden (@Clave varchar(50), @Digitos int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a 		int,
    @b		int,
    @Resultado 	varchar(255),
    @Separador	char(1)

  SELECT @Clave = NULLIF(RTRIM(@Clave), '')
  IF @Clave IS NULL 
    SELECT @Resultado = NULL
  ELSE 
  BEGIN
    IF CHARINDEX('.', @Clave) > 0 SELECT @Separador = '.' ELSE
    IF CHARINDEX('-', @Clave) > 0 SELECT @Separador = '-' ELSE
    IF CHARINDEX('/', @Clave) > 0 SELECT @Separador = '/' ELSE
    IF CHARINDEX('\', @Clave) > 0 SELECT @Separador = '\' 
    ELSE SELECT @Separador = '.'
    SELECT @Resultado = ''
    SELECT @a = 1

    SELECT @b = CHARINDEX(@Separador, @Clave, 1)
--    if @b=0 SELECT @b = CHARINDEX('/', @Clave, 1)
    WHILE @b > 0
    BEGIN
      SELECT @Resultado = @Resultado + dbo.fnLlenarCeros(SUBSTRING(@Clave, 1, @b-1), @Digitos) + SUBSTRING(@Clave, @b, 1)

      SELECT @a = @b+1
      SELECT @Clave = SUBSTRING(@Clave, @a, LEN(@Clave))
      SELECT @b = CHARINDEX(@Separador, @Clave, 1)
--      if @b=0 SELECT @b = CHARINDEX('/', @Clave, 1)
    END
    IF NULLIF(@Clave, '') IS NOT NULL
     SELECT @Resultado = @Resultado + dbo.fnLlenarCeros(SUBSTRING(@Clave, 1, LEN(@Clave)), @Digitos)
  END
  RETURN (@Resultado)
END
GO

-- select dbo.fnEstructuraCambiarFase('10.123', 10, 100)
/**************** fnEstructuraCambiarFase ****************/
--IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraCambiarFase') DROP FUNCTION fnEstructuraCambiarFase
GO
/*CREATE FUNCTION fnEstructuraCambiarFase (@Clave varchar(20), @FaseA int, @FaseN int)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	varchar(20),
    @FaseASt	varchar(20),
    @FaseNSt	varchar(20)
    
  SELECT @Resultado = @Clave
  SELECT @FaseASt = CONVERT(varchar, @FaseA), @FaseNSt = CONVERT(varchar, @FaseN)
  IF @Clave = @FaseASt 
    SELECT @Resultado = @FaseNSt
  ELSE BEGIN
    SELECT @FaseASt = @FaseASt + '.', @FaseNSt = @FaseNSt + '.'
    IF SUBSTRING(@Clave, 1, LEN(@FaseASt)) = @FaseASt
      SELECT @Resultado = @FaseNSt + SUBSTRING(@Clave, LEN(@FaseASt)+1, LEN(@Clave))
  END
  RETURN (@Resultado)
END*/
GO

-- select dbo.fnIncCantidad(200, 13.127, 1, 2)
/**************** fnIncCantidad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIncCantidad') DROP FUNCTION fnIncCantidad
GO
CREATE FUNCTION fnIncCantidad (@Cantidad float, @Inc float, @Redondear bit, @Digitos int)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float
 
  SELECT @Resultado = @Cantidad
  IF NULLIF(@Inc, 0) IS NOT NULL
    SELECT @Resultado = @Resultado + (@Resultado*(@Inc/100.0))

  IF @Redondear = 1
    SELECT @Resultado = ROUND(@Resultado, @Digitos)

  RETURN(@Resultado)
END
GO

-- select dbo.fnIncImporte(200, 13.127, 1, 2)
/**************** fnIncImporte ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIncImporte') DROP FUNCTION fnIncImporte
GO
CREATE FUNCTION fnIncImporte (@Importe money, @Inc float, @Redondear bit, @Digitos int)
RETURNS money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	money
 
  SELECT @Resultado = @Importe
  IF NULLIF(@Inc, 0) IS NOT NULL
    SELECT @Resultado = @Resultado + (@Resultado*(@Inc/100.0))

  IF @Redondear = 1
    SELECT @Resultado = ROUND(@Resultado, @Digitos)

  RETURN(@Resultado)
END
GO

/**************** fnProyectoAvance ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnProyectoAvance') DROP FUNCTION fnProyectoAvance
GO
CREATE FUNCTION fnProyectoAvance (@ID int)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float,
    @Dias	float,
    @Avance	float

  SELECT @Dias = SUM(DuracionDias), @Avance = SUM(Avance*DuracionDias)
    FROM ProyectoD
   WHERE ID = @ID 

  SELECT @Resultado = @Avance / @Dias

  RETURN(@Resultado)
END
GO
-- select dbo.fnActRama(dbo.fnActRama('1.1.1'))
/******************* dbo.fnActRama ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnActRama') and type = 'fn') drop function dbo.fnActRama
GO
CREATE FUNCTION dbo.fnActRama (@Actividad  varchar(50))
RETURNS varchar(50)
AS BEGIN
  DECLARE 
    @Estructura         varchar(50),
    @Punto              int,
    @p                  int

  SELECT @Punto = 0, @p = 1
  WHILE @p <= LEN(@Actividad)
  BEGIN
    IF (SELECT SUBSTRING(@Actividad, @p, 1)) = '.'
      SELECT @Punto = @p
    SELECT @p = @p + 1
  END

  IF @Punto > 0
    SELECT @Estructura = SUBSTRING(@Actividad, 1, @Punto - 1)
  RETURN(@Estructura)
END
GO

/********************* dbo.fnActRamaDesglosar *****************/
if exists (select * from sysobjects where id = object_id('dbo.fnActRamaDesglosar') and type = 'tf') drop function dbo.fnActRamaDesglosar
GO
CREATE FUNCTION dbo.fnActRamaDesglosar (
                @Actividad              varchar(50)
)
RETURNS @Tabla TABLE (
                ID                      int             IDENTITY(1,1),
                Rama                    varchar(50)
)
AS BEGIN
  DECLARE
    @Rama               varchar(20)

  SELECT @Rama = dbo.fnActRama(@Actividad) 
 
  WHILE @Rama IS NOT NULL
  BEGIN
    INSERT @Tabla (Rama) VALUES (@Rama)
    SELECT @Rama = dbo.fnActRama(@Rama)
  END

  RETURN
END
GO

/**************** fnRamaPredecesora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRamaPredecesora') DROP FUNCTION fnRamaPredecesora
GO
CREATE FUNCTION fnRamaPredecesora (@ID int, @Actividad varchar(50))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Rama		varchar(50),
    @Predecesora	varchar(50)

  SELECT @Predecesora = NULL
  SELECT @Rama = dbo.fnActRama(@Actividad)
  IF @Rama IS NOT NULL 
  BEGIN
    SELECT @Predecesora = NULLIF(RTRIM(Predecesora), '') FROM ProyectoD WHERE ID = @ID AND Actividad = @Rama
    IF @Predecesora IS NULL SELECT @Predecesora = dbo.fnRamaPredecesora (@ID, @Rama)
  END
  RETURN(@Predecesora)
END
GO

/**************** fnFaseEnGrupo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseEnGrupo') DROP FUNCTION fnFaseEnGrupo
GO

-- select dbo.fnFaseActividades(2, '2')
/**************** fnFaseActividades ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseActividades') DROP FUNCTION fnFaseActividades
GO

-- select * from act
-- select dbo.fnFaseDias(2, '3')
-- select dbo.fnFaseDias(15, '0.1.1.1')
-- select datediff(hour, '1/1/7', getdate())
/**************** fnFaseDias ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseDias') DROP FUNCTION fnFaseDias
GO
GO

/**************** fnFaseAvance ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseAvance') DROP FUNCTION fnFaseAvance
GO

-- select estatus, * from proyecto
-- select dbo.fnFaseActual(2)

/**************** fnFaseActual ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseActual') DROP FUNCTION fnFaseActual
GO


/**************** fnFaseSiguiente ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseSiguiente') DROP FUNCTION fnFaseSiguiente
GO

-- select dbo.fnFaseSiguienteGrupo(13, '1')
/**************** fnFaseSiguienteGrupo ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFaseSiguienteGrupo') DROP FUNCTION fnFaseSiguienteGrupo
GO

-- select * FROM dbo.fnTextoEnLista(',,,1,2,3,4,5, 6, 7, 8, 9, 10,,,,,    ', ',')
-- select l.texto, * from art join dbo.fnTextoEnLista(',,,1,2,3,4,5, 6, 7, 8, 9, 10,,,,,    ', ',') l on art.articulo=art.articulo where l.Texto in ('1', '2')
/**************** fnTextoEnLista ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTextoEnLista' AND type = 'TF') DROP FUNCTION fnTextoEnLista
GO
CREATE FUNCTION fnTextoEnLista (@Lista varchar(255), @Separador char(1))
RETURNS @Resultado TABLE (Texto varchar(50))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Texto 	varchar(50),
    @p		int

  SELECT @Lista = ISNULL(RTRIM(@Lista), '')
  WHILE LEN(@Lista) > 0
  BEGIN   
    SELECT @Texto = '', @p = CHARINDEX(@Separador, @Lista)
    IF @p > 0 
    BEGIN
      SELECT @Texto = LTRIM(RTRIM(SUBSTRING(@Lista, 1, @p-1)))
      SELECT @Lista = SUBSTRING(@Lista, @p+1, LEN(@Lista))
    END ELSE
    BEGIN
      SELECT @Texto = LTRIM(RTRIM(@Lista))
      SELECT @Lista = ''
    END
    SELECT @Texto = NULLIF(RTRIM(@Texto), '')
    IF @Texto IS NOT NULL
      INSERT @Resultado (Texto) VALUES (@Texto)
  END
  
  RETURN 
END
GO


/**************** fnGanttFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnGanttFecha') DROP FUNCTION fnGanttFecha
GO
CREATE FUNCTION fnGanttFecha (@Fecha datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  IF DATEPART(hour, @Fecha) > 0 
    SELECT @Fecha = DATEADD(hour, 8, @Fecha)
  RETURN(@Fecha)
END
GO

/**************** fnMesNumeroNombre ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMesNumeroNombre') DROP FUNCTION fnMesNumeroNombre
GO
CREATE FUNCTION fnMesNumeroNombre (@Mes int)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Texto 	varchar(20)

  SELECT @Texto = NULL
  IF @Mes =  1 SELECT @Texto = 'Enero'      ELSE
  IF @Mes =  2 SELECT @Texto = 'Febrero'    ELSE
  IF @Mes =  3 SELECT @Texto = 'Marzo'      ELSE
  IF @Mes =  4 SELECT @Texto = 'Abril'      ELSE
  IF @Mes =  5 SELECT @Texto = 'Mayo'       ELSE
  IF @Mes =  6 SELECT @Texto = 'Junio'      ELSE
  IF @Mes =  7 SELECT @Texto = 'Julio'      ELSE 
  IF @Mes =  8 SELECT @Texto = 'Agosto'     ELSE
  IF @Mes =  9 SELECT @Texto = 'Septiembre' ELSE
  IF @Mes = 10 SELECT @Texto = 'Octubre'    ELSE
  IF @Mes = 11 SELECT @Texto = 'Noviembre'  ELSE 
  IF @Mes = 12 SELECT @Texto = 'Diciembre'  ELSE 
  IF @Mes = 13 SELECT @Texto = '13'         

  RETURN(@Texto)
END
GO


/**************** fnMesNombre ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMesNombre') DROP FUNCTION fnMesNombre
GO
CREATE FUNCTION fnMesNombre (@Fecha datetime)
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Mes	int,
    @Texto 	varchar(20)

  SELECT @Texto = NULL
  IF @Fecha IS NOT NULL
    SELECT @Texto = dbo.fnMesNumeroNombre(MONTH(@Fecha))

  RETURN(@Texto)
END
GO

-- select dbo.fnMesNombre(GETDATE())
-- select dbo.fnDateTimeToDDMMMAA(GETDATE())
/**************** fnDateTimeToDDMMMAA ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDateTimeToDDMMMAA') DROP FUNCTION fnDateTimeToDDMMMAA
GO
CREATE FUNCTION fnDateTimeToDDMMMAA (@Fecha datetime)
RETURNS varchar(11)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(11)

  SELECT @Resultado = NULL
  IF @Fecha IS NOT NULL
    SELECT @Resultado = CONVERT(varchar, DAY(@Fecha))+'/'+SUBSTRING(dbo.fnMesNombre(@Fecha), 1, 3)+'/'+CONVERT(varchar, YEAR(@Fecha))

  RETURN(@Resultado)
END
GO


/**************** fnFormatDateTime  ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatDateTime ') DROP FUNCTION fnFormatDateTime 
GO
CREATE FUNCTION dbo.fnFormatDateTime 
( 
    @dt DATETIME, 
    @format VARCHAR(16) 
) 
RETURNS VARCHAR(64) 
AS 
BEGIN 
  DECLARE 
    @MMM	int,
    @Mes	int,
    @dtVC 	VARCHAR(64) 

  SELECT @MMM = CHARINDEX('MMM', @format)
  IF @MMM > 0 SELECT @format = STUFF(@format, @MMM, 3, 'MM')

  SELECT @dtVC = CASE @format 
    WHEN 'LONGDATE' THEN 
 
        DATENAME(dw, @dt) 
        + ',' + SPACE(1) + DATENAME(m, @dt) 
        + SPACE(1) + CAST(DAY(@dt) AS VARCHAR(2)) 
        + ',' + SPACE(1) + CAST(YEAR(@dt) AS CHAR(4)) 
 
    WHEN 'LONGDATEANDTIME' THEN 
 
        DATENAME(dw, @dt) 
        + ',' + SPACE(1) + DATENAME(m, @dt) 
        + SPACE(1) + CAST(DAY(@dt) AS VARCHAR(2)) 
        + ',' + SPACE(1) + CAST(YEAR(@dt) AS CHAR(4)) 
        + SPACE(1) + RIGHT(CONVERT(CHAR(20), 
        @dt - CONVERT(DATETIME, CONVERT(CHAR(8), 
        @dt, 112)), 22), 11) 
 
    WHEN 'SHORTDATE' THEN 
 
        LEFT(CONVERT(CHAR(19), @dt, 0), 11) 
 
    WHEN 'SHORTDATEANDTIME' THEN 
 
        REPLACE(REPLACE(CONVERT(CHAR(19), @dt, 0), 
            'AM', ' AM'), 'PM', ' PM') 
 
    WHEN 'UNIXTIMESTAMP' THEN 
 
        CAST(DATEDIFF(SECOND, '19700101', @dt) 
        AS VARCHAR(64)) 
 
    WHEN 'YYYYMMDD' THEN 
 
        CONVERT(CHAR(8), @dt, 112) 
 
    WHEN 'YYYY-MM-DD' THEN 
 
        CONVERT(CHAR(10), @dt, 23) 
 
    WHEN 'YYMMDD' THEN 
 
        CONVERT(VARCHAR(8), @dt, 12) 
 
    WHEN 'YY-MM-DD' THEN 
 
        STUFF(STUFF(CONVERT(VARCHAR(8), @dt, 12), 
        5, 0, '-'), 3, 0, '-') 
 
    WHEN 'MMDDYY' THEN 
 
        REPLACE(CONVERT(CHAR(8), @dt, 10), '-', SPACE(0)) 
 
    WHEN 'MM-DD-YY' THEN 
 
        CONVERT(CHAR(8), @dt, 10) 
 
    WHEN 'MM/DD/YY' THEN 
 
        CONVERT(CHAR(8), @dt, 1) 
 
    WHEN 'MM/DD/YYYY' THEN 
 
        CONVERT(CHAR(10), @dt, 101) 
 
    WHEN 'DDMMYY' THEN 
 
        REPLACE(CONVERT(CHAR(8), @dt, 3), '/', SPACE(0)) 
 
    WHEN 'DD-MM-YY' THEN 
 
        REPLACE(CONVERT(CHAR(8), @dt, 3), '/', '-') 
 
    WHEN 'DD/MM/YY' THEN 
 
        CONVERT(CHAR(8), @dt, 3) 
 
    WHEN 'DD/MM/YYYY' THEN 
 
        CONVERT(CHAR(10), @dt, 103) 
 
    WHEN 'HH:MM:SS 24' THEN 
 
        CONVERT(CHAR(8), @dt, 8) 
 
    WHEN 'HH:MM 24' THEN 
 
        LEFT(CONVERT(VARCHAR(8), @dt, 8), 5) 
 
    WHEN 'HH:MM:SS 12' THEN 
 
        LTRIM(RIGHT(CONVERT(VARCHAR(20), @dt, 22), 11)) 
 
    WHEN 'HH:MM 12' THEN 
 
        LTRIM(SUBSTRING(CONVERT( 
        VARCHAR(20), @dt, 22), 10, 5) 
        + RIGHT(CONVERT(VARCHAR(20), @dt, 22), 3)) 
 
    ELSE 
 
        'Invalid format specified' 
 
    END 

    IF @MMM > 0
    BEGIN
      SELECT @Mes = LTRIM(CONVERT(int, SUBSTRING(@dtVC, @MMM, 2)))
      SELECT @dtVC = STUFF(@dtVC , @MMM, 2, SUBSTRING(dbo.fnMesNombre(@Mes), 1, 3))      
    END
    RETURN @dtVC 
END 
GO

/*
PRINT dbo.fnFormatDateTime(GETDATE(), 'LONGDATEANDTIME') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'SHORTDATE') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'SHORTDATEANDTIME') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'UNIXTIMESTAMP') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'YYYYMMDD') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'YYYY-MM-DD') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'YYMMDD') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'YY-MM-DD') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'MMDDYY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'MM-DD-YY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'MM/DD/YY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'MM/DD/YYYY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'DDMMYY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'DD-MM-YY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'DD/MM/YY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'DD/MMM/YYYY') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'HHMMSS 24') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'HHMM 24') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'HHMMSS 12') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'HHMM 12') 
PRINT dbo.fnFormatDateTime(GETDATE(), 'goofy')

*/

-- select * from auxiliar
-- select dbo.fnAuxiliarMovimiento(543)
/**************** fnAuxiliarMovimiento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAuxiliarMovimiento') DROP FUNCTION fnAuxiliarMovimiento
GO
CREATE FUNCTION fnAuxiliarMovimiento (@ID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado	varchar(50)

  SELECT @Resultado = NULL
  IF @ID IS NOT NULL
    SELECT @Resultado = RTRIM(Mov)+' '+RTRIM(MovID) FROM Auxiliar WHERE ID = @ID

  RETURN(@Resultado)
END
GO

-- select rid,* from ContD
-- select dbo.fnContDMovimiento(1)
/**************** fnContDMovimiento ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContDMovimiento') DROP FUNCTION fnContDMovimiento
GO
CREATE FUNCTION fnContDMovimiento (@RID int)
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado	varchar(50)

  SELECT @Resultado = NULL
  IF @RID IS NOT NULL
    SELECT @Resultado = RTRIM(e.Mov)+' '+RTRIM(e.MovID) FROM ContD d JOIN Cont e ON e.ID = d.ID WHERE d.RID = @RID
  RETURN(@Resultado)
END
GO

-- SELECT dbo.fnCampanaDTarea(4)
/**************** fnCampanaDTarea ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCampanaDTarea') DROP FUNCTION fnCampanaDTarea
GO
CREATE FUNCTION fnCampanaDTarea (@RID int)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado	varchar(100)

  SELECT @Resultado = NULL
  SELECT @Resultado = (SELECT TOP 1 Asunto FROM Tarea WHERE Modulo = 'CMP' AND ModuloID = @RID AND Estado = 'No comenzada' ORDER BY Vencimiento, Orden, ID)
  RETURN(@Resultado)
END
GO


-- select dbo.fnSQL2005()
/**************** fnSQL2005 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSQL2005') DROP FUNCTION fnSQL2005
GO
CREATE FUNCTION fnSQL2005 ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF substring(@@version, 1, 25)= 'Microsoft SQL Server 2005' 
    SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO

-- select dbo.fnSQL2008()
/**************** fnSQL2008 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSQL2008') DROP FUNCTION fnSQL2008
GO
CREATE FUNCTION fnSQL2008 ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF substring(@@version, 1, 25)= 'Microsoft SQL Server 2008' 
    SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO

-- select dbo.fnSQL2012()
/**************** fnSQL2012 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSQL2012') DROP FUNCTION fnSQL2012
GO
CREATE FUNCTION fnSQL2012 ()
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF substring(@@version, 1, 25) IN ('Microsoft SQL Server 2012', 'Microsoft SQL Server 2014', 'Microsoft SQL Server 2016') 
    SELECT @Resultado = 1

  RETURN(@Resultado)
END
GO


-- select dbo.fnEstructuraNivel('1.1/123.22')
/**************** fnEstructuraNivel ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraNivel') DROP FUNCTION fnEstructuraNivel
GO
CREATE FUNCTION fnEstructuraNivel (@Estructura varchar(255))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	int,
    @p		int

  SELECT @Resultado = 0
  SELECT @Estructura = NULLIF(RTRIM(@Estructura), '')
  IF @Estructura IS NOT NULL
  BEGIN
    SELECT @Resultado = 1, @p = 1
    WHILE @p <= LEN(@Estructura)
    BEGIN
      IF SUBSTRING(@Estructura, @p, 1) IN ('.', '/')
        SELECT @Resultado = @Resultado + 1
      SELECT @p = @p + 1
    END
  END
  RETURN(@Resultado)
END
GO

/**************** fnEstructuraNivelSeparador ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEstructuraNivelSeparador') DROP FUNCTION fnEstructuraNivelSeparador
GO
CREATE FUNCTION fnEstructuraNivelSeparador (@Estructura varchar(255), @Separador	varchar(10))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	int,
    @p		int

  SELECT @Resultado = 0
  SELECT @Estructura = NULLIF(RTRIM(@Estructura), '')
  IF @Estructura IS NOT NULL
  BEGIN
    SELECT @Resultado = 1, @p = 1
    WHILE @p <= LEN(@Estructura)
    BEGIN
      IF SUBSTRING(@Estructura, @p, LEN(@Separador)) = @Separador
        SELECT @Resultado = @Resultado + 1
      SELECT @p = @p + 1
    END
  END
  RETURN(@Resultado)
END
GO


-- select * FROM dbo.fnProyectoActividadLista(15)
/************* dbo.fnProyectoActividadLista *************/
if exists (select * from sysobjects where id = object_id('dbo.fnProyectoActividadLista') and type = 'tf') drop function dbo.fnProyectoActividadLista
GO

/**************** fnPolizasSinOrigen ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPolizasSinOrigen' AND type = 'TF') DROP FUNCTION fnPolizasSinOrigen
GO
CREATE FUNCTION fnPolizasSinOrigen (@Empresa varchar(5), @Cuenta varchar(20))
RETURNS @Resultado TABLE (ID int)
--//WITH ENCRYPTION
AS BEGIN
  SELECT @Cuenta = NULLIF(NULLIF(NULLIF(RTRIM(@Cuenta), ''), '0'), 'NULL')

  IF @Cuenta IS NULL
    INSERT @Resultado (ID) 
    SELECT ID 
      FROM Cont 
     WHERE Empresa = @Empresa AND Estatus = 'CONCLUIDO' AND NULLIF(OrigenID, '') IS NULL
  ELSE 
    INSERT @Resultado (ID) 
    SELECT DISTINCT e.ID
      FROM Cont e
      JOIN ContD d ON d.ID = e.ID
     WHERE e.Empresa = @Empresa AND e.Estatus = 'CONCLUIDO' AND NULLIF(e.OrigenID, '') IS NULL
       AND d.Cuenta = @Cuenta
  RETURN 
END
GO

-- select dbo.fnDir('c\')
/**************** fnDir ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDir') DROP FUNCTION fnDir
GO
CREATE FUNCTION fnDir (@Dir varchar(255))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @Resultado varchar(255)

  SELECT @Resultado = ISNULL(RTRIM(@Dir), '')
  IF (@Resultado='') OR (SUBSTRING(@Resultado, LEN(@Resultado), 1) <> '\')
    SELECT @Resultado = @Resultado + '\'

  RETURN(@Resultado)
END
GO


-- select dbo.fnExtraerActividad('1.2/3.4')
-- select dbo.fnExtraerActividad('1.2')
/**************** fnExtraerActividad ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerActividad') DROP FUNCTION fnExtraerActividad
GO
/*CREATE FUNCTION fnExtraerActividad (@Actividad varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @p		int,
    @Resultado  varchar(20)

  SELECT @Resultado = @Actividad
  SELECT @p = CHARINDEX('/', @Resultado)
  IF @p = 0
    SELECT @Resultado = NULL	-- esto es aproposito para que elimine la fase
  ELSE
    SELECT @Resultado = SUBSTRING(@Resultado, @p+1, LEN(@Resultado))

  RETURN(@Resultado)
END*/
GO

-- select dbo.fnExtraerFase('1.2/3.4')
-- select dbo.fnExtraerFase('1.2')
/**************** fnExtraerFase ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnExtraerFase') DROP FUNCTION fnExtraerFase
GO
/*CREATE FUNCTION fnExtraerFase (@Actividad varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @p		int,
    @Resultado  varchar(50)

  SELECT @Resultado = @Actividad
  SELECT @p = CHARINDEX('/', @Resultado)
  IF @p = 0
    SELECT @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado))
  ELSE
    SELECT @Resultado = SUBSTRING(@Resultado, 1, @p-1)

  RETURN(@Resultado)
END*/
GO

/******************* dbo.fnActividadRamaAvance ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnActividadRamaAvance') and type = 'fn') drop function dbo.fnActividadRamaAvance
GO
CREATE FUNCTION dbo.fnActividadRamaAvance ( @ID int, @Rama varchar(50))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Avance             float

  SELECT @Avance = (ISNULL(SUM(ISNULL(dbo.fnR3(100.0, DuracionDias, Avance), 0)), 0) / ISNULL(SUM(DuracionDias), 0)) * 100.0 
    FROM ProyectoD 
   WHERE ID = @ID 
     AND dbo.fnActRama(Actividad) = @Rama

  RETURN(@Avance)
END
GO

-- select dbo.fnUltimoDiaSemana('5/27/7')
/**************** fnUltimoDiaSemana ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltimoDiaSemana') DROP FUNCTION fnUltimoDiaSemana
GO
CREATE FUNCTION fnUltimoDiaSemana (@Fecha datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime

  SELECT @Resultado = @Fecha
  SELECT @Resultado = DATEADD(week, 1, @Resultado)
  SELECT @Resultado = DATEADD(day, -DATEPART(weekday, @Resultado), @Resultado)
  RETURN (@Resultado)
END
GO

-- select dbo.fnUltimoDiaMes('5/30/7')
/**************** fnUltimoDiaMes ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltimoDiaMes') DROP FUNCTION fnUltimoDiaMes
GO
CREATE FUNCTION fnUltimoDiaMes(@Fecha datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime

  SELECT @Resultado = @Fecha
  SELECT @Resultado = DATEADD(month, 1, @Resultado)
  SELECT @Resultado = DATEADD(day, -DAY(@Resultado), @Resultado)
  RETURN (@Resultado)
END
GO


-- select dbo.fnUltimoDiaAno('12/31/7')
/**************** fnUltimoDiaAno ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltimoDiaAno') DROP FUNCTION fnUltimoDiaAno
GO
CREATE FUNCTION fnUltimoDiaAno(@Fecha datetime)
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime

  SELECT @Resultado = @Fecha
  SELECT @Resultado = DATEADD(year, 1, @Resultado)
  SELECT @Resultado = DATEADD(month, -MONTH(@Resultado)+1, @Resultado)
  SELECT @Resultado = DATEADD(day, -DAY(@Resultado), @Resultado)

  RETURN (@Resultado)
END
GO

-- select dbo.fnDuracion(getdate(), 'este', 'mes')
/**************** fnDuracion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDuracion') DROP FUNCTION fnDuracion
GO
CREATE FUNCTION fnDuracion(@Fecha datetime, @CantidadSt varchar(20), @Unidad varchar(20))
RETURNS datetime
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	datetime,
    @Cantidad	float,
    @Hoy	datetime,
    @Dia	int,
    @DiaSemana	int,
    @Mes	int,
    @Hora	int,
    @Minuto	int,
    @Segundo	int,
    @ms		int

  SELECT @CantidadSt = NULLIF(RTRIM(UPPER(@CantidadSt)), ''), @Unidad = UPPER(@Unidad)

  IF @Unidad = 'AÑO' SELECT @Unidad = 'ANO'
  IF @Unidad IN ('ANO', 'MES', 'SEMANA', 'DIA')
    SELECT @Hoy = dbo.fnFechaSinHora(@Fecha)
  ELSE
    SELECT @Hoy = @Fecha

  SELECT @Dia = DAY(@Hoy), @DiaSemana = DATEPART(weekday, @Hoy), @Mes = MONTH(@Hoy),
         @Hora = DATEPART(hour, @Hoy), @Minuto = DATEPART(minute, @Hoy), @Segundo = DATEPART(second, @Hoy), @ms = DATEPART(millisecond, @hoy)
  SELECT @Resultado = @Hoy
  IF dbo.fnEsNumerico(@CantidadSt) = 1 
  BEGIN
    SELECT @Cantidad = CONVERT(float, @CantidadSt)
    IF @Unidad = 'ANO'     SELECT @Resultado = DATEADD(year,   @Cantidad, @Resultado) ELSE
    IF @Unidad = 'MES'     SELECT @Resultado = DATEADD(month,  @Cantidad, @Resultado) ELSE
    IF @Unidad = 'SEMANA'  SELECT @Resultado = DATEADD(week,   @Cantidad, @Resultado) ELSE
    IF @Unidad = 'DIA'     SELECT @Resultado = DATEADD(day,    @Cantidad, @Resultado) ELSE
    IF @Unidad = 'HORA'    SELECT @Resultado = DATEADD(hour,   @Cantidad, @Resultado) ELSE
    IF @Unidad = 'MINUTO'  SELECT @Resultado = DATEADD(minute,  @Cantidad, @Resultado) ELSE
    IF @Unidad = 'SEGUNDO' SELECT @Resultado = DATEADD(second,  @Cantidad, @Resultado)
  END ELSE
  IF @CantidadSt IN ('ESTE', 'ESTA')
  BEGIN
    IF @Unidad = 'ANO'    SELECT @Resultado = dbo.fnUltimoDiaAno(@Resultado) ELSE
    IF @Unidad = 'MES'    SELECT @Resultado = dbo.fnUltimoDiaMes(@Resultado) ELSE
    IF @Unidad = 'SEMANA' SELECT @Resultado = dbo.fnUltimoDiaSemana(@Resultado) ELSE
    SELECT @Resultado = NULL		-- falta calcular esto bien
  END
  RETURN (@Resultado)
END
GO 

/*
    IF @Unidad IN ('MES', 'ANO') SELECT @Resultado = DATEADD(day, -@Dia+1, @Resultado)
    IF @Unidad = 'ANO'    SELECT @Resultado = DATEADD(month, -@Mes+1, @Resultado)
    IF @Unidad = 'SEMANA' SELECT @Resultado = DATEADD(weekday, -@DiaSemana+1, @Resultado)
    IF @Unidad = 'HORA' SELECT @Resultado = DATEADD(minute, -@Minuto, @Resultado)
    IF @Unidad IN ('HORA', 'MINUTO') SELECT @Resultado = DATEADD(second, -@Segundo, @Resultado)
    IF @Unidad IN ('HORA', 'MINUTO', 'SEGUNDO') SELECT @Resultado = DATEADD(millisecond, -@ms, @Resultado)
*/


/**************** fnEsFaseAgrupadora ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnEsFaseAgrupadora') DROP FUNCTION fnEsFaseAgrupadora
GO
CREATE FUNCTION fnEsFaseAgrupadora (@ID int, @Fase varchar(20), @EsFase bit)
RETURNS bit
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	bit

  SELECT @Resultado = 0
  IF @EsFase = 1 AND @Fase IS NOT NULL AND @ID IS NOT NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM ProyectoD WHERE ID = @ID AND Predecesora = @Fase AND EsFase = 0)
      SELECT @Resultado = 1
  END

  RETURN(@Resultado)
END
GO


/*
select * 
  from venta e
  JOIN ventad d ON d.ID = e.ID
  LEFT OUTER join dbo.fnSerieLoteMovEnLinea('DEMO', 'VTAS', 139, 0, 100, 1, 'CADENA ORIGINAL') s ON s.Articulo = d.Articulo AND ISNULL(s.SubCuenta, '') = ISNULL(d.SubCuenta, '') AND s.RenglonID = d.RenglonID
where e.id = 139

*/

if exists (select * from sysobjects where id = object_id('dbo.EmpresaCFD') and type = 'U') 
  EXEC spALTER_TABLE 'EmpresaCFD', 'CadenaOriginal8000', 'bit NULL DEFAULT 0 WITH VALUES'
go
if exists (select * from sysobjects where id = object_id('dbo.CFD') and type = 'U') 
BEGIN
  EXEC spALTER_TABLE 'CFD', 'CadenaOriginal1', 'text NULL'
  EXEC spALTER_TABLE 'CFD', 'CadenaOriginal2', 'text NULL'
  EXEC spALTER_TABLE 'CFD', 'CadenaOriginal3', 'text NULL'
  EXEC spALTER_TABLE 'CFD', 'CadenaOriginal4', 'text NULL'
  EXEC spALTER_TABLE 'CFD', 'CadenaOriginal5', 'text NULL'
END
GO
/**************** fnSerieLoteMovEnLinea ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSerieLoteMovEnLinea' AND type = 'TF') DROP FUNCTION fnSerieLoteMovEnLinea
GO
CREATE FUNCTION fnSerieLoteMovEnLinea (@Empresa varchar(5), @Modulo varchar(5), @ID int, @DesglosarCantidad bit, @Ancho int, @IncluirCadenaOriginal bit, @CadenaOriginalLeyenda varchar(50))
RETURNS @Resultado TABLE (Articulo varchar(20), SubCuenta varchar(50), RenglonID int, LineaID int IDENTITY(1,1), Linea varchar(255))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @a			int,
    @Articulo 		varchar(20), 
    @uArticulo 		varchar(20), 
    @SubCuenta 		varchar(50), 
    @uSubCuenta 	varchar(50), 
    @RenglonID 		int, 
    @uRenglonID 	int, 
    @SerieLote		varchar(50),
    @Cantidad		float,
    @Registro		varchar(255),
    @Linea		varchar(255),
    @Renglon		float,
    @RenglonSub		int,
    @CadenaOriginal	varchar(8000)

  SELECT @Linea = '', @uArticulo = NULL, @uSubCuenta = NULL, @uRenglonID = NULL
  IF @Modulo = 'VTAS'
    DECLARE crSerieLote CURSOR LOCAL FOR
     SELECT Articulo, SubCuenta, RenglonID, SerieLote, SUM(Cantidad)
       FROM SerieLoteMov
      WHERE Empresa = @Empresa AND Modulo = @Modulo AND ID = @ID 
      GROUP BY RenglonID, Articulo, SubCuenta, SerieLote
      ORDER BY RenglonID, Articulo, SubCuenta, SerieLote

  OPEN crSerieLote
  FETCH NEXT FROM crSerieLote INTO @Articulo, @SubCuenta, @RenglonID, @SerieLote, @Cantidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      IF @Linea <> '' AND (@Articulo<>@uArticulo OR @SubCuenta<>@uSubCuenta OR @RenglonID<>@uRenglonID)
      BEGIN
        SELECT @Linea = @Linea + '.'
        INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @Linea)
        SELECT @Linea = ''
      END

      IF @Linea <> '' SELECT @Linea = @Linea+', '
      SELECT @Registro = ''
      IF @DesglosarCantidad = 1
        SELECT @Registro = CONVERT(varchar, @Cantidad)+' '
      SELECT @Registro = @Registro + @SerieLote

      SELECT @uArticulo = @Articulo, @uSubCuenta = @SubCuenta, @uRenglonID = @RenglonID
      IF LEN(@Linea)+LEN(@Registro)>@Ancho
      BEGIN
        INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @Linea)
        SELECT @Linea = ''
      END
      SELECT @Linea = @Linea + @Registro
    END
    FETCH NEXT FROM crSerieLote INTO @Articulo, @SubCuenta, @RenglonID, @SerieLote, @Cantidad
  END  -- While
  CLOSE crSerieLote
  DEALLOCATE crSerieLote
  IF @Linea <> ''
  BEGIN
    SELECT @Linea = @Linea + '.'
    INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @Linea)
    SELECT @Linea = ''
  END
  
  IF @IncluirCadenaOriginal = 1
  BEGIN
    IF NULLIF(@uArticulo, '') IS NULL
    BEGIN
      IF @Modulo = 'VTAS'
      BEGIN
        SELECT @Renglon = MAX(Renglon) FROM VentaD WHERE ID = @ID
        SELECT @RenglonSub = MAX(RenglonSub) FROM VentaD WHERE ID = @ID AND Renglon = @Renglon
        SELECT @uArticulo = Articulo, @uSubCuenta = SubCuenta, @uRenglonID = RenglonID FROM VentaD WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub
      END
    END

    IF (SELECT CadenaOriginal8000 FROM EmpresaCFD WHERE Empresa = @Empresa) = 1
    BEGIN
      SELECT @a = 1
      WHILE @a<=5
      BEGIN
        SELECT @CadenaOriginal = NULLIF(RTRIM(CONVERT(varchar(8000), CASE @a WHEN 1 THEN CadenaOriginal1 WHEN 2 THEN CadenaOriginal2 WHEN 3 THEN CadenaOriginal3 WHEN 4 THEN CadenaOriginal4 WHEN 5 THEN CadenaOriginal5 END)), '') FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
        IF @CadenaOriginal IS NOT NULL
        BEGIN
          INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, '')
          IF @CadenaOriginalLeyenda IS NOT NULL
            INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @CadenaOriginalLeyenda)
          WHILE LEN(@CadenaOriginal) > 0 
          BEGIN
            SELECT @Linea = SUBSTRING(@CadenaOriginal, 1, @Ancho)
            INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @Linea)
            SELECT @CadenaOriginal = SUBSTRING(@CadenaOriginal, @Ancho+1, 8000)
          END         
        END
        SELECT @a = @a + 1
      END
    END ELSE
    BEGIN
      SELECT @CadenaOriginal = NULLIF(RTRIM(CONVERT(varchar(8000), CadenaOriginal)), '') FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
      IF @CadenaOriginal IS NOT NULL
      BEGIN
        INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, '')
        IF @CadenaOriginalLeyenda IS NOT NULL
          INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @CadenaOriginalLeyenda)
        WHILE LEN(@CadenaOriginal) > 0 
        BEGIN
          SELECT @Linea = SUBSTRING(@CadenaOriginal, 1, @Ancho)
          INSERT @Resultado (Articulo, SubCuenta, RenglonID, Linea) VALUES (@uArticulo, @uSubCuenta, @uRenglonID, @Linea)
          SELECT @CadenaOriginal = SUBSTRING(@CadenaOriginal, @Ancho+1, 8000)
        END
      END
    END
  END

  RETURN 
END
GO


if exists (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.fnCalculaHomoClave') AND type='FN')
  DROP FUNCTION dbo.fnCalculaHomoClave
GO
CREATE FUNCTION dbo.fnCalculaHomoClave
    (
        @T_NomTot         char(52),
        @Rfc              varchar(16)
    )
RETURNS varchar(16)
AS
  BEGIN
    --DECLARACION DE VARIABLES
        DECLARE  @VarLoops              int,
                 @T_NomNum              char(102),
                 @T_Suma                int,
                 @T_Divid               int, 
                 @T_Mod                 int,
                 @T_HomoClv             char(3),
                 @T_Numero              int,
                 @T_Parcial             int


  --HOMOCLAVE
    SELECT @T_NomNum = '0'

  --SACA NOMBRE NUMERICO
    SELECT @VarLoops = 1
    WHILE @VarLoops <= 52
    BEGIN
      SELECT @T_NomNum = LTRIM(RTRIM (@T_NomNum)) +
      CASE
          WHEN SUBSTRING (@T_NomTot , @VarLoops, 1) = 'A' THEN '11'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'B' THEN '12'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'C' THEN '13'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'D' THEN '14'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'E' THEN '15'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'F' THEN '16'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'G' THEN '17'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'H' THEN '18'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'I' THEN '19'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'J' THEN '21'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'K' THEN '22'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'L' THEN '23'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'M' THEN '24'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'N' THEN '25'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'O' THEN '26'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'P' THEN '27'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Q' THEN '28'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'R' THEN '29'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'S' THEN '32'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'T' THEN '33'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'U' THEN '34'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'V' THEN '35'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'W' THEN '36'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'X' THEN '37'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Y' THEN '38'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Z' THEN '39'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) >= '0' AND 
          SUBSTRING (@T_NomTot , @VarLoops , 1) <= '9' THEN 
            CONVERT(varchar,CONVERT(int, SUBSTRING (@T_NomTot , @VarLoops , 1)) , 2)
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) IN ('&','Ñ') THEN '10'
          ELSE '00'
      END
      SELECT @VarLoops = @VarLoops + 1
    END
    SELECT @VarLoops = 1
    SELECT @T_Suma = 0
    while @VarLoops <= 99
    BEGIN
      SELECT @T_Suma = @T_Suma + ((CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops , 1))*10) + CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops+1 , 1))) * CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops+1 , 1))
      SELECT @VarLoops = @VarLoops + 1
    END

    -- Obtener HOMOCLAVE
    SELECT @T_Divid = @T_Suma%1000 -- Obtener residuo de los ultimos 3 digitos
    SELECT @T_Mod = @T_Divid%34 -- Obtener el residuo de los ultimos 3 digitos-- entre 34
    SELECT @T_Divid = (@T_Divid - @T_Mod) / 34 -- Obtener el Cociente entero

    -- Checar Cociente y residuo
    SELECT @VarLoops = 0

    WHILE @VarLoops <= 1
      BEGIN
        SELECT @T_HomoClv =
        CASE CASE @VarLoops WHEN 0 THEN @T_Divid ELSE @T_Mod END
            WHEN 0 THEN '1' 
            WHEN 1 THEN '2'
            WHEN 2 THEN '3'
            WHEN 3 THEN '4'
            WHEN 4 THEN '5'
            WHEN 5 THEN '6'
            WHEN 6 THEN '7'
            WHEN 7 THEN '8'
            WHEN 8 THEN '9' 
            WHEN 9 THEN 'A'
            WHEN 10 THEN 'B'
            WHEN 11 THEN 'C'
            WHEN 12 THEN 'D'
            WHEN 13 THEN 'E'
            WHEN 14 THEN 'F'
            WHEN 15 THEN 'G'
            WHEN 16 THEN 'H'
            WHEN 17 THEN 'I'
            WHEN 18 THEN 'J'
            WHEN 19 THEN 'K'
            WHEN 20 THEN 'L'
            WHEN 21 THEN 'M'
            WHEN 22 THEN 'N'
            WHEN 23 THEN 'P'
            WHEN 24 THEN 'Q'
            WHEN 25 THEN 'R'
            WHEN 26 THEN 'S'
            WHEN 27 THEN 'T'
            WHEN 28 THEN 'U'
            WHEN 29 THEN 'V'
            WHEN 30 THEN 'W'
            WHEN 31 THEN 'X'
            WHEN 32 THEN 'Y'
            ELSE 'Z'
        END
        SELECT @VarLoops = @VarLoops + 1
        -- Incluir la parte de la homoclave
        SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + LTRIM(RTRIM (@T_HomoClv))
      END
 
      SELECT @VarLoops = 0
      SELECT @T_Parcial = 0
      WHILE @VarLoops < 12
        BEGIN
          SELECT @VarLoops = @VarLoops + 1
          SELECT @T_Numero =
          CASE
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'A' THEN 10
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'B' THEN 11
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'C' THEN 12
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'D' THEN 13
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'E' THEN 14
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'F' THEN 15
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'G' THEN 16
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'H' THEN 17
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'I' THEN 18
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'J' THEN 19
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'K' THEN 20
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'L' THEN 21
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'M' THEN 22
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'N' THEN 23
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'O' THEN 25
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'P' THEN 26
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Q' THEN 27
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'R' THEN 28
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'S' THEN 29
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'T' THEN 30
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'U' THEN 31
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'V' THEN 32
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'W' THEN 33
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'X' THEN 34
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Y' THEN 35
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Z' THEN 36
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) >= '0' AND 
              SUBSTRING (@Rfc , @VarLoops , 1) <= '9'
              THEN CONVERT(int,SUBSTRING (@Rfc , @VarLoops , 1))
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = ''
              THEN 24
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = ' '
              THEN 37
              ELSE 0
          END
          -- Contabilizar el nuevo digito
          SELECT @T_Parcial = @T_Parcial + (@T_Numero * (14 - @VarLoops))
        END 

      SELECT @T_Mod = ROUND(@T_Parcial%11,1)
      IF @T_Mod = 0
        SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + '0'
      ELSE
        BEGIN
          SELECT @T_Parcial = 11 - @T_Mod
          IF @T_Parcial = 10
            SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + 'A'
          ELSE
            SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + CONVERT(varchar ,@T_Parcial)
        END
    RETURN @Rfc
  END 
GO

/********************* fnCalculaRFC *****************************/
if exists (SELECT * FROM SysObjects WHERE Id=OBJECT_ID('dbo.fnCalculaRFC') AND type='FN') DROP FUNCTION dbo.fnCalculaRFC
GO
CREATE FUNCTION dbo.fnCalculaRFC
    (
        @Nombres_Aux      varchar(100),
        @Apaterno_Aux     varchar(100),
        @Amaterno_Aux     varchar(100),
        @FechaNacimiento  datetime,
        @Regimen          varchar(20)
    )
RETURNS varchar(16)
AS
  BEGIN
    --DECLARACION DE VARIABLES
        DECLARE  @Rfc_Out               char(16),
                 @Nombres               varchar(100),
                 @Apaterno              varchar(100),
                 @Amaterno              varchar(100),
                 @T_NomTot              char(52),
                 @Nombre1               varchar(100),
                 @Nombre2               varchar(100),
                 @Nombres_Longitud      int,
                 @Nombre1_Longitud      int,
                 @Apaterno1             varchar(100),
                 @Apaterno2             varchar(100), 
                 @Apaterno_Longitud     int,
                 @Apaterno1_Longitud    int, 
                 @Amaterno1             varchar(100),
                 @Amaterno2             varchar(100),
                 @Amaterno_Longitud     int, 
                 @Amaterno1_Longitud    int,
                 @VarLoops              int,
                 @Rfc                   varchar(16),
                 @T_NomNum              char(102),
                 @T_Suma                int,
                 @T_Divid               int, 
                 @T_Mod                 int,
                 @T_HomoClv             char(3),
                 @T_Numero              int,
                 @T_Parcial             int

    --INICIALZA VARIABLES
      SELECT @Nombres = UPPER(LTRIM(RTRIM(@Nombres_Aux)))
      SELECT @Apaterno = UPPER(LTRIM(RTRIM(@Apaterno_Aux)))
      SELECT @Amaterno = UPPER(LTRIM(RTRIM(@Amaterno_Aux)))
      SELECT @Regimen = UPPER(LTRIM(RTRIM(@Regimen)))
      SELECT @T_NomTot =@Apaterno+' '+@Amaterno+' '+@Nombres

    --PROCESAR NOMBRES DE PILA
      SELECT @VarLoops = 0
      WHILE @VarLoops <> 1
        BEGIN
          SELECT @Nombres_Longitud = LEN(@Nombres)
          SELECT @Nombre1_Longitud = PATINDEX('% %',@Nombres)

          IF @Nombre1_Longitud = 0
          SELECT @Nombre1_Longitud = @Nombres_Longitud

          SELECT @Nombre1 = RTRIM(LEFT(@Nombres,@Nombre1_Longitud))
          SELECT @Nombre2 = LTRIM(RIGHT(@Nombres,@Nombres_Longitud - @Nombre1_Longitud))

          --SE QUINTAN LOS NOMBRES DE JOSE, MARIA,MA,MA.
          IF @Nombre1 IN ('JOSE','MARIA','MA.','MA','DE','LA','LAS','MC','VON','DEL','LOS','Y','MAC','VAN') AND @Nombre2 <> ''
            BEGIN
              SELECT @Nombres = @Nombre2
            END 
          ELSE
            BEGIN
              SELECT @VarLoops = 1
            END
        END

      --PROCESAMOS APELLIDOS, PATERNO EN UN LOOP
      SELECT @VarLoops = 0
      WHILE @VarLoops <> 1
        BEGIN
          SELECT @Apaterno_Longitud = LEN(@Apaterno)
          SELECT @Apaterno1_Longitud = PATINDEX('% %',@Apaterno)
          IF @Apaterno1_Longitud = 0
            SELECT @Apaterno1_Longitud = @Apaterno_Longitud
          SELECT @Apaterno1 = RTRIM(LEFT(@Apaterno,@Apaterno1_Longitud))
          SELECT @Apaterno2 = LTRIM(RIGHT(@Apaterno,@Apaterno_Longitud - @Apaterno1_Longitud))

          --SE QUINTAN LOS SUFIJOS
          IF @Apaterno1 IN ('DE','LA','LAS','MC','VON','DEL','LOS','Y','MAC','VAN') AND @Apaterno2 <> ''
            BEGIN
              SELECT @Apaterno = @Apaterno2
            END 
          ELSE
            BEGIN
              SELECT @VarLoops = 1
            END
        END
  
      --PROCESAMOS APELLIDOS, MATERNO EN UN LOOP
      SELECT @VarLoops = 0
      WHILE @VarLoops <> 1
        BEGIN
          SELECT @Amaterno_Longitud = LEN(@Amaterno)
          SELECT @Amaterno1_Longitud = PATINDEX('% %',@Amaterno)
          IF @Amaterno1_Longitud = 0
            SELECT @Amaterno1_Longitud = @Amaterno_Longitud
          SELECT @Amaterno1 = RTRIM(LEFT(@Amaterno,@Amaterno1_Longitud))
          SELECT @Amaterno2 = LTRIM(RIGHT(@Amaterno,@Amaterno_Longitud - @Amaterno1_Longitud))

          --SE QUINTAN LOS SUFIJOS
          IF @Amaterno1 IN ('DE','LA','LAS','MC','VON','DEL','LOS','Y','MAC','VAN') AND @Amaterno2 <> ''
            BEGIN
              SELECT @Amaterno = @Amaterno2
            END 
          ELSE
            BEGIN
              SELECT @VarLoops = 1
            END
        END

      --SE OBTIENE DEL PRIMER APELLIDO LA PRIMER LETRA Y LA PRIMER VOCAL INTERNA
      SELECT @Rfc = LEFT(@Apaterno1,1)
      SELECT @Apaterno1_Longitud= LEN(@Apaterno1)
      SELECT @VarLoops = 1 --EMPIEZA EN UNO POR LA PRIMERA LETRA SE LA VA A SALTAR

      WHILE @Apaterno1_Longitud > @VarLoops
        BEGIN
          SELECT @VarLoops = @VarLoops + 1
          IF SUBSTRING(@Apaterno1,@VarLoops,1) IN ('A','E','I','O','U')
            BEGIN
              SELECT @Rfc = RTRIM(@Rfc)+CONVERT(char(1),SUBSTRING(@Apaterno1,@VarLoops,1))
              SELECT @VarLoops = @Apaterno1_Longitud
            END
        END

      --SE OBTIENE LA PRIMER LETRA DEL APELLIDO MATERNO SI NO TIENE APELLIDO MATERNO SE PONE UNA X
      --DICE QUE SI NO TIENE APELLIDO MATERNO LE PONGAS LA PRIMER LETRA DEL APELLIDO PATERNO EN EL RFX
      IF ISNULL(@Amaterno1,'') = ''
        BEGIN
          SELECT @Rfc = RTRIM(@Rfc)+CONVERT(char(1),SUBSTRING(@Apaterno1,1,1))
        END
      ELSE
        BEGIN
          SELECT @Rfc = RTRIM(@Rfc)+CONVERT(char(1),SUBSTRING(@Amaterno1,1,1))
        END

    --SE LE AGREGA LA PRIMER LETRA DEL NOMBRE
    SELECT @Rfc = RTRIM(@Rfc)+CONVERT(char(1),SUBSTRING(@Nombre1,1,1))

    --CHEAS QUE NO SEA UNA PALABRA INCONVENIENTE
    /*
    IF EXISTS ( SELECT INC_PALINC FROM NINCO WHERE INC_PALINC = @Rfc )
    BEGIN
    SELECT @Rfc = LTRIM(RTRIM (SUBSTRING (@Rfc , 1 , 3))) + 'X'
    END
    */
  --SE LE AGREGA LA FECHA DE NACIMIENTO
    SELECT @Rfc = RTRIM(@Rfc) + CONVERT(char,@FechaNacimiento,12)
  --HOMOCLAVE
    SELECT @T_NomNum = '0'

  --SACA NOMBRE NUMERICO
    SELECT @VarLoops = 1
    WHILE @VarLoops <= 52
    BEGIN
      SELECT @T_NomNum = LTRIM(RTRIM (@T_NomNum)) +
      CASE
          WHEN SUBSTRING (@T_NomTot , @VarLoops, 1) = 'A' THEN '11'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'B' THEN '12'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'C' THEN '13'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'D' THEN '14'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'E' THEN '15'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'F' THEN '16'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'G' THEN '17'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'H' THEN '18'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'I' THEN '19'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'J' THEN '21'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'K' THEN '22'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'L' THEN '23'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'M' THEN '24'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'N' THEN '25'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'O' THEN '26'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'P' THEN '27'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Q' THEN '28'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'R' THEN '29'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'S' THEN '32'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'T' THEN '33'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'U' THEN '34'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'V' THEN '35'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'W' THEN '36'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'X' THEN '37'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Y' THEN '38'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) = 'Z' THEN '39'
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) >= '0' AND 
          SUBSTRING (@T_NomTot , @VarLoops , 1) <= '9' THEN CONVERT(varchar,CONVERT(int, SUBSTRING (@T_NomTot , @VarLoops , 1)) , 2)
          WHEN SUBSTRING (@T_NomTot , @VarLoops , 1) IN ('&','Ñ') THEN '10'
          ELSE '00'
      END
      SELECT @VarLoops = @VarLoops + 1
    END

    SELECT @VarLoops = 1
    SELECT @T_Suma = 0
    while @VarLoops <= 99
    BEGIN
      SELECT @T_Suma = @T_Suma + ((CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops , 1))*10) + CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops+1 , 1))) * CONVERT(int,SUBSTRING (@T_NomNum , @VarLoops+1 , 1))
      SELECT @VarLoops = @VarLoops + 1
    END

    -- Obtener HOMOCLAVE
    SELECT @T_Divid = @T_Suma%1000 -- Obtener residuo de los ultimos 3 digitos
    SELECT @T_Mod = @T_Divid%34 -- Obtener el residuo de los ultimos 3 digitos-- entre 34
    SELECT @T_Divid = (@T_Divid - @T_Mod) / 34 -- Obtener el Cociente entero
    --select @T_Divid,@T_Mod
    -- Checar Cociente y residuo
    SELECT @VarLoops = 0

    WHILE @VarLoops <= 1
      BEGIN
        SELECT @T_HomoClv =
        CASE CASE @VarLoops WHEN 0 THEN @T_Divid ELSE @T_Mod END
            WHEN 0 THEN '1' 
            WHEN 1 THEN '2'
            WHEN 2 THEN '3'
            WHEN 3 THEN '4'
            WHEN 4 THEN '5'
            WHEN 5 THEN '6'
            WHEN 6 THEN '7'
            WHEN 7 THEN '8'
            WHEN 8 THEN '9' 
            WHEN 9 THEN 'A'
            WHEN 10 THEN 'B'
            WHEN 11 THEN 'C'
            WHEN 12 THEN 'D'
            WHEN 13 THEN 'E'
            WHEN 14 THEN 'F'
            WHEN 15 THEN 'G'
            WHEN 16 THEN 'H'
            WHEN 17 THEN 'I'
            WHEN 18 THEN 'J'
            WHEN 19 THEN 'K'
            WHEN 20 THEN 'L'
            WHEN 21 THEN 'M'
            WHEN 22 THEN 'N'
            WHEN 23 THEN 'P'
            WHEN 24 THEN 'Q'
            WHEN 25 THEN 'R'
            WHEN 26 THEN 'S'
            WHEN 27 THEN 'T'
            WHEN 28 THEN 'U'
            WHEN 29 THEN 'V'
            WHEN 30 THEN 'W'
            WHEN 31 THEN 'X'
            WHEN 32 THEN 'Y'
            ELSE 'Z'
        END
        SELECT @VarLoops = @VarLoops + 1
        -- Incluir la parte de la homoclave
        SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + LTRIM(RTRIM (@T_HomoClv))
      END
      SELECT @VarLoops = 0
      SELECT @T_Parcial = 0
      WHILE @VarLoops < 12
        BEGIN
          SELECT @VarLoops = @VarLoops + 1
          SELECT @T_Numero =
          CASE
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'A' THEN 10
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'B' THEN 11
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'C' THEN 12
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'D' THEN 13
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'E' THEN 14
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'F' THEN 15
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'G' THEN 16
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'H' THEN 17
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'I' THEN 18
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'J' THEN 19
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'K' THEN 20
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'L' THEN 21
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'M' THEN 22
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'N' THEN 23
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'O' THEN 25
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'P' THEN 26
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Q' THEN 27
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'R' THEN 28
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'S' THEN 29
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'T' THEN 30
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'U' THEN 31
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'V' THEN 32
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'W' THEN 33
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'X' THEN 34
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Y' THEN 35
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = 'Z' THEN 36
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) >= '0' AND 
              SUBSTRING (@Rfc , @VarLoops , 1) <= '9'
              THEN CONVERT(int,SUBSTRING (@Rfc , @VarLoops , 1))
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = ''
              THEN 24
              WHEN SUBSTRING (@Rfc , @VarLoops , 1) = ' '
              THEN 37
              ELSE 0
          END
          -- Contabilizar el nuevo digito
          SELECT @T_Parcial = @T_Parcial + (@T_Numero * (14 - @VarLoops))
        END 

      SELECT @T_Mod = ROUND(@T_Parcial%11,1)
      IF @T_Mod = 0
        SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + '0'
      ELSE
        BEGIN
          SELECT @T_Parcial = 11 - @T_Mod
          IF @T_Parcial = 10
            SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + 'A'
          ELSE
            SELECT @Rfc = LTRIM(RTRIM (@Rfc)) + CONVERT(varchar ,@T_Parcial)
        END
      SELECT @Rfc_Out = @Rfc
    RETURN @Rfc
  END 
GO


-- SELECT dbo.fnCalculaRFC('GONZALO','RUIZ','JIMENEZ','01-18-1962','Persona Moral')
-- SELECT dbo.fnCalculaRFC('HEFFES', 'ANTAR', 'JOSE', '05-08-1968','Persona Moral')
-- SELECT dbo.fnCalculaRFC('Heffes', 'Antar', 'Jose', '08/05/1968 ', 'Persona Fisica')
-- select Fiscalregimen from cte


IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCambiaFormatoFecha') DROP FUNCTION dbo.fnCambiaFormatoFecha
go
CREATE FUNCTION dbo.fnCambiaFormatoFecha (@FechaOrigen VARCHAR(32),@FormatoOrigen CHAR(32),@FormatoDef CHAR(32))
RETURNS VARCHAR(32)
AS
BEGIN
  DECLARE @Temp VARCHAR(32),
          @Ano VARCHAR(4),
          @Mes VARCHAR(2),
          @Dia VARCHAR(2),
          @Hora VARCHAR(8),
          @PosAnoD TINYINT,
          @LenAnoD TINYINT,
          @PosMesD TINYINT,
          @PosDiaD TINYINT,
          @PosHoraD TINYINT,
          @PosAnoO TINYINT,
          @LenAnoO TINYINT,
          @PosMesO TINYINT,
          @PosDiaO TINYINT,
          @PosHoraO TINYINT,
          @DefSeparador VARCHAR(1),
          @Contador TINYINT

  -- Busca el caracter del separador
             SELECT @DefSeparador=''
             SELECT @Contador=1
             WHILE @DefSeparador='' OR @Contador=LEN(@FormatoDef)
                    BEGIN
                           IF ASCII(UPPER(SUBSTRING(@FormatoDef,@Contador,1))) NOT IN (58,65,68,72,77,83,89) 
                                        AND ASCII(SUBSTRING(@FormatoDef,@Contador,1))<>32
                                        SELECT @DefSeparador=SUBSTRING(@FormatoDef,@Contador,1)
                           SELECT @Contador=@Contador+1
                    END      

       -- Busca la posición y longitud del ano default
         IF CHARINDEX('AAAA',UPPER(@FormatoDef))>0
                    BEGIN
                           SELECT @PosAnoD = CHARINDEX('AAAA',UPPER(@FormatoDef))
                           SELECT @LenAnoD = 4
                    END
             ELSE
               IF CHARINDEX('AA',UPPER(@FormatoDef))>0
                           BEGIN
                                  SELECT @PosAnoD = CHARINDEX('AA',UPPER(@FormatoDef))
                                  SELECT @LenAnoD = 2
                           END
                    ELSE
                      IF CHARINDEX('YYYY',UPPER(@FormatoDef))>0
                                  BEGIN
                                        SELECT @PosAnoD = CHARINDEX('YYYY',UPPER(@FormatoDef))
                                        SELECT @LenAnoD = 4
                                  END
                           ELSE
                             IF CHARINDEX('YY',UPPER(@FormatoDef))>0
                                        BEGIN
                                               SELECT @PosAnoD = CHARINDEX('YY',UPPER(@FormatoDef))
                                               SELECT @LenAnoD = 2
                                        END

       -- Busca las posiciones del mes, dia y hora default
                    SELECT @PosMesD = CHARINDEX('MM',UPPER(@FormatoDef))               
                    SELECT @PosDiaD = CHARINDEX('DD',UPPER(@FormatoDef))        
                    SELECT @PosHoraD = CHARINDEX('HH',UPPER(@FormatoDef))              

       -- Busca la posición y longitud del ano origen
         IF CHARINDEX('AAAA',UPPER(@FormatoOrigen))>0
                    BEGIN
                           SELECT @PosAnoO = CHARINDEX('AAAA',UPPER(@FormatoOrigen))
                           SELECT @LenAnoO = 4
                    END
             ELSE
               IF CHARINDEX('AA',UPPER(@FormatoOrigen))>0
                           BEGIN
                                  SELECT @PosAnoO = CHARINDEX('AA',UPPER(@FormatoOrigen))
                                  SELECT @LenAnoO = 2
                           END
                    ELSE
                      IF CHARINDEX('YYYY',UPPER(@FormatoOrigen))>0
                                  BEGIN
                                        SELECT @PosAnoO = CHARINDEX('YYYY',UPPER(@FormatoOrigen))
                                        SELECT @LenAnoO = 4
                                  END
                           ELSE
                             IF CHARINDEX('YY',UPPER(@FormatoOrigen))>0
                                        BEGIN
                                               SELECT @PosAnoO = CHARINDEX('YY',UPPER(@FormatoOrigen))
                                               SELECT @LenAnoO = 2
                                        END

       -- Busca las posiciones del mes, dia y hora default
                    SELECT @PosMesO = CHARINDEX('MM',UPPER(@FormatoOrigen))                   
                    SELECT @PosDiaO = CHARINDEX('DD',UPPER(@FormatoOrigen))            
                    SELECT @PosHoraO = CHARINDEX('HH',UPPER(@FormatoOrigen))                  

       -- Busca el ano, mes, dia y hora del dato original
             SELECT @Ano=SUBSTRING(@FechaOrigen,@PosAnoO,@LenAnoO)
             SELECT @Mes=SUBSTRING(@FechaOrigen,@PosMesO,2)
             SELECT @Dia=SUBSTRING(@FechaOrigen,@PosDiaO,2)
             SELECT @Hora=SUBSTRING(@FechaOrigen,@PosHoraO,8)

       -- Da formato default a la fecha original
             SELECT @Temp=@FormatoDef
             SELECT @Temp=STUFF(@Temp,@PosAnoD,@LenAnoD,@Ano)
             SELECT @Temp=REPLACE(UPPER(@Temp),'MM',@Mes)
             SELECT @Temp=REPLACE(UPPER(@Temp),'DD',@Dia)
             SELECT @Temp=REPLACE(UPPER(@Temp),'HH:NN:SS',@Hora)

       -- Asigna el resultado
  RETURN(@Temp)
END
GO

-- select dbo.fnCaracterEspecial('<ESP>')
/**************** fnCaracterEspecial ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCaracterEspecial') DROP FUNCTION fnCaracterEspecial
GO
CREATE FUNCTION fnCaracterEspecial (@Etiqueta varchar(50))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado varchar(50)

  SELECT @Etiqueta = UPPER(@Etiqueta)

  IF @Etiqueta IN ('<ESP>', '<ESPACIO>', '<SPC>') SELECT @Resultado = ' ' 
  ELSE IF @Etiqueta = '<CR>'   SELECT @Resultado = CHAR(13) 
  ELSE IF @Etiqueta = '<TAB>'  SELECT @Resultado = CHAR(9)
  ELSE IF @Etiqueta = '<PIPE>' SELECT @Resultado = '|'
  ELSE IF @Etiqueta = '<AND>'  SELECT @Resultado = '&'

  RETURN(@Resultado)
END
GO

/**************** fnContrasenaOk ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContrasenaOk') DROP FUNCTION fnContrasenaOk
GO
/*CREATE FUNCTION fnContrasenaOk (@Contrasena varchar(32), @Encriptada varchar(32))
RETURNS bit
AS BEGIN
  DECLARE
    @Resultado bit

  SELECT @Resultado = 0
  IF @Contrasena = @Encriptada
    SELECT @Resultado = 1

  RETURN(@Resultado)
END*/
GO

-- select dbo.fnArtOtrosGastosRegion('DEMO', 0, 'A1', NULL, NULL)
/**************** fnArtOtrosGastosSucursal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArtOtrosGastosSucursal') DROP FUNCTION fnArtOtrosGastosSucursal
GO
CREATE FUNCTION fnArtOtrosGastosSucursal (@Empresa varchar(5), @Sucursal int, @Articulo varchar(20), @SubCuenta varchar(50), @Unidad varchar(50))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @Resultado float,
    @ID		int

  SELECT @ID = NULL, @Resultado = NULL, @SubCuenta = NULLIF(RTRIM(@SubCuenta), ''), @Unidad = NULLIF(RTRIM(@Unidad), '')
  SELECT @ID = (SELECT TOP(1) c.ID 
    FROM Compra c 
    JOIN CompraD d ON d.ID = c.ID  AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = ISNULL(@Unidad, d.Unidad)
   WHERE c.Empresa = @Empresa AND c.Estatus = 'CONCLUIDO' AND c.Sucursal = @Sucursal 
   --ORDER BY c.FechaEmision ASC, c.ID ASC)
     ORDER BY c.FechaEmision DESC, c.ID DESC)
  IF @ID IS NOT NULL
    SELECT @Resultado = ((d.CostoInv/NULLIF(d.Costo, 0.0))-1.0)*100.0
      FROM CompraD d
     WHERE d.ID = @ID AND d.Articulo = @Articulo AND ISNULL(d.SubCuenta, '') = ISNULL(@SubCuenta, '') AND d.Unidad = ISNULL(@Unidad, d.Unidad)

  RETURN(@Resultado)
END
GO

-- select * from dbo.fnArtOtrosGastosRegion('DEMO', 'Norte', 'A1', NULL, NULL)
/**************** fnArtOtrosGastosRegion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnArtOtrosGastosRegion') DROP FUNCTION fnArtOtrosGastosRegion
GO
CREATE FUNCTION fnArtOtrosGastosRegion (@Empresa varchar(5), @Region varchar(50), @Articulo varchar(20), @SubCuenta varchar(50), @Unidad varchar(50))
RETURNS @Resultado TABLE (Maximo float, Minimo float, Promedio float)
--//WITH ENCRYPTION
AS BEGIN
DECLARE
    @Sucursal	int,
    @Conteo	float,
    @Gastos	float,
    @Suma	float,
    @Maximo	float,
    @Minimo	float

  SELECT @Maximo = NULL, @Minimo = NULL, @Suma = 0.0, @Conteo = 0
  DECLARE crSucursal CURSOR LOCAL FOR
   SELECT Sucursal
     FROM Sucursal
    WHERE Region = @Region

  OPEN crSucursal
  FETCH NEXT FROM crSucursal INTO @Sucursal
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Gastos = dbo.fnArtOtrosGastosSucursal (@Empresa, @Sucursal, @Articulo, @SubCuenta, @Unidad)
      IF NULLIF(@Gastos, 0.0) IS NOT NULL
      BEGIN
        SELECT @Conteo = @Conteo + 1, @Suma = @Suma + @Gastos
        IF @Maximo IS NULL OR @Gastos > @Maximo SELECT @Maximo = @Gastos
        IF @Minimo IS NULL OR @Gastos < @Minimo SELECT @Minimo = @Gastos
      END      
    END
    FETCH NEXT FROM crSucursal INTO @Sucursal
  END -- While
  CLOSE crSucursal
  DEALLOCATE crSucursal

  INSERT @Resultado (Maximo, Minimo, Promedio) 
  SELECT @Maximo, @Minimo, @Suma/NULLIF(@Conteo, 0)
 
  RETURN 
END
GO
-- select * FROM dbo.fnArtOtrosGastosRegion('DEMO', 'Norte', 'A1', NULL, NULL)


/**************** fnDescCascada_H1 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDescCascada_H1') DROP FUNCTION fnDescCascada_H1
GO
CREATE FUNCTION fnDescCascada_H1 
(
    @U1		bit,
    @U2		bit,
    @U3		bit,
    @U4		bit,
    @U5		bit,
    @U6		bit,
    @U7		bit,
    @U8		bit,
    @U9		bit,
    @U10	bit,
    @U11	bit,
    @U12	bit,
    @U13	bit,
    @U14	bit,
    @U15	bit,
    @Desc1	float,
    @Desc2	float,
    @Desc3	float,
    @Desc4	float,
    @Desc5	float,
    @Desc6	float,
    @Desc7	float,
    @Desc8	float,
    @Desc9	float,
    @Desc10	float,
    @Desc11	float,
    @Desc12	float,
    @Desc13	float,
    @Desc14	float,
    @Desc15	float
)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	float,
    @Suma	float,
    @p		float

  SELECT @Desc1  = NULLIF(@Desc1, 0),  @Desc2  = NULLIF(@Desc2, 0),  @Desc3  = NULLIF(@Desc3, 0),  @Desc4  = NULLIF(@Desc4, 0),  @Desc5 = NULLIF(@Desc5, 0),
         @Desc6  = NULLIF(@Desc6, 0),  @Desc7  = NULLIF(@Desc7, 0),  @Desc8  = NULLIF(@Desc8, 0),  @Desc9  = NULLIF(@Desc9, 0),  @Desc10 = NULLIF(@Desc10, 0),
         @Desc11 = NULLIF(@Desc11, 0), @Desc12 = NULLIF(@Desc12, 0), @Desc13 = NULLIF(@Desc13, 0), @Desc14 = NULLIF(@Desc14, 0), @Desc15 = NULLIF(@Desc15, 0)

  SELECT @Suma = 0.0, @p = 100.0
  IF @U1  = 1 AND @Desc1  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc1/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U2  = 1 AND @Desc2  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc2/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U3  = 1 AND @Desc3  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc3/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U4  = 1 AND @Desc4  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc4/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U5  = 1 AND @Desc5  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc5/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U6  = 1 AND @Desc6  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc6/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U7  = 1 AND @Desc7  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc7/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U8  = 1 AND @Desc8  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc8/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U9  = 1 AND @Desc9  IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc9/100.0)  SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U10 = 1 AND @Desc10 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc10/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U11 = 1 AND @Desc11 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc11/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U12 = 1 AND @Desc12 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc12/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U13 = 1 AND @Desc13 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc13/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U14 = 1 AND @Desc14 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc14/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END
  IF @U15 = 1 AND @Desc15 IS NOT NULL BEGIN SELECT @Resultado = @p *(@Desc15/100.0) SELECT @p = @p - @Resultado, @Suma = @Suma + @Resultado END     

  SELECT @Resultado = @Suma  
  RETURN(@Resultado)
END
GO

/****************************** fnXMLTrim ******************************/
if exists (select * from sysobjects where id = object_id('dbo.fnXMLTrim') and type in ('fn','tf')) drop function dbo.fnXMLTrim
GO
CREATE FUNCTION  fnXMLTrim (@xml nvarchar(max))
RETURNS	nvarchar(max)
BEGIN
  DECLARE	
    @CampoAnterior	varchar(max),
    @CampoNuevo		varchar(max),
    @Datos		varchar(max),		
    @CuantosEspacios	int,		
    @PosI		int,		
    @PosF		int,
    @PatronI		char(2),
    @PatronF		char(2)
		
  SELECT @PosI = 0
  SELECT @PosF = 0
  SELECT @PatronI = '="'
  SELECT @PatronF = ' "'
  SELECT @Datos = CONVERT(nvarchar(max), @xml)

  WHILE CHARINDEX(@PatronF, @Datos)>0
    SELECT @Datos = REPLACE(@Datos, @PatronF, '"')

  RETURN (@Datos)
END
GO

/****************************** fnOkRefSQL ******************************/
if exists (select * from sysobjects where id = object_id('dbo.fnOkRefSQL') and type in ('fn','tf')) drop function dbo.fnOkRefSQL
GO
CREATE FUNCTION fnOkRefSQL (@Numero int, @Mensaje varchar(255))
RETURNS	nvarchar(255)
BEGIN
  RETURN (CONVERT(varchar, @Numero) + ' ' + @Mensaje)
END
GO

/**************** fnCtaDescripcion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaDescripcion') DROP FUNCTION fnCtaDescripcion
GO
CREATE FUNCTION fnCtaDescripcion (@Cuenta varchar(20))
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Descripcion FROM Cta WHERE Cuenta = @Cuenta)
END
GO

-- select dbo.fnVersion()
/**************** fnVersion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVersion') DROP FUNCTION fnVersion
GO
CREATE FUNCTION fnVersion ()
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Version FROM Version)
END
GO

-- select dbo.fnVersionBase()
/**************** fnVersionBase ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnVersionBase') DROP FUNCTION fnVersionBase
GO
CREATE FUNCTION fnVersionBase ()
RETURNS varchar(5)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT Base FROM Version)
END
GO

-- select dbo.fnXMLBase()
/**************** fnXMLBase() ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnXMLBase') DROP FUNCTION fnXMLBase
GO
CREATE FUNCTION fnXMLBase()
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  RETURN(SELECT ' Base="'+Base+'"'+dbo.fnXMLDatetime('FechaBase', GETDATE()) FROM Version)
END
GO


-- select dbo.fnCorreoPara('Jose', 'Heffes', NULL, 'jheffes@intelisis.com')
-- select dbo.fnCorreoPara(NULL, NULL, NULL, 'jheffes@intelisis.com')
/**************** fnCorreoPara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCorreoPara') DROP FUNCTION fnCorreoPara
GO
CREATE FUNCTION fnCorreoPara(@Nombre varchar(100), @ApellidoPaterno varchar(100), @ApellidoMaterno varchar(100), @eMail varchar(100))
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(255)
  SELECT @Resultado = '', @Nombre = NULLIF(RTRIM(@Nombre), ''), @ApellidoPaterno = NULLIF(RTRIM(@ApellidoPaterno), ''), @ApellidoMaterno = NULLIF(RTRIM(@ApellidoMaterno), ''), @eMail = NULLIF(RTRIM(@eMail), '')

  IF @eMail IS NOT NULL  
  BEGIN
    IF @Nombre IS NOT NULL SELECT @Resultado = @Nombre + ' '
    IF @ApellidoPaterno IS NOT NULL SELECT @Resultado = @Resultado + @ApellidoPaterno + ' ' 
    IF @ApellidoMaterno IS NOT NULL SELECT @Resultado = @Resultado + @ApellidoMaterno + ' ' 
    IF @Resultado = '' SELECT @Resultado = @eMail ELSE SELECT @Resultado = @Resultado + '<'+@eMail+'>'
  END ELSE 
    SELECT @Resultado = NULL
  RETURN(@Resultado)
END
GO

-- select dbo.fnDataPacketField('Nombre', 'varchar', 0, 100, NULL, NULL, 1, 0)
/**************** fnDataPacketField ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDataPacketField') DROP FUNCTION fnDataPacketField
GO
CREATE FUNCTION fnDataPacketField (@Campo varchar(255), @TipoDatos varchar(100), @Ancho int, @Precision int, @Escala int, @AceptaNulos bit, @EsIdentity bit, @EsCalculado bit)
RETURNS varchar(8000)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(8000),
    @fieldtype	varchar(255),
    @subtype	varchar(255),
    @width	int,
    @decimals	int,
    @readonly	bit

  SELECT @fieldtype = NULL, @subtype = NULL, @width = NULL, @decimals = NULL, @readonly = NULL
  SELECT @TipoDatos = LOWER(@TipoDatos), @Precision = NULLIF(@Precision, 0), @Escala = NULLIF(@Escala, 0)

  IF @TipoDatos IN ('varchar', 'nchar', 'nvarchar') 
  BEGIN 
    IF @Ancho < 0 
      SELECT @fieldtype = 'bin.hex', @subtype = 'Text' 
    ELSE 
      SELECT @fieldtype = 'string', @width = @Ancho 
  END 
  ELSE IF @TipoDatos = 'int'                    SELECT @fieldtype = 'i4' 
  ELSE IF @TipoDatos IN ('money', 'smallmoney') BEGIN SELECT @fieldtype = 'r8', @subtype = 'Money' IF @TipoDatos = 'smallmoney' SELECT @width = 10, @decimals = 4 END
  ELSE IF @TipoDatos IN ('datetime', 'smalldatetime ') SELECT @fieldtype = 'dateTime' 
  ELSE IF @TipoDatos = 'bit'                    SELECT @fieldtype = 'boolean' 
  ELSE IF @TipoDatos = 'char'             SELECT @fieldtype = 'string', @subtype = 'FixedChar', @width = @Ancho
  ELSE IF @TipoDatos = 'timestamp'              SELECT @fieldtype = 'bin.hex', @width = 8, @readonly = 1
  ELSE IF @TipoDatos = 'image'                  SELECT @fieldtype = 'bin.hex', @subtype = 'Binary'
  ELSE IF @TipoDatos = 'xml'                    SELECT @fieldtype = 'bin.hex', @subtype = 'Text'
  ELSE IF @TipoDatos = 'uniqueidentifier'       SELECT @fieldtype = 'string', @subtype = 'Guid', @width = 38
  ELSE IF @TipoDatos IN ('text', 'ntext') SELECT @fieldtype = 'bin.hex', @subtype = 'Text' 
  ELSE IF @TipoDatos IN ('smallint', 'tinyint') SELECT @fieldtype = 'i2' 
  ELSE IF @TipoDatos = 'bigint'                 SELECT @fieldtype = 'i8' 
  ELSE IF @TipoDatos IN ('float', 'real')       SELECT @fieldtype = 'r8' 
  ELSE IF @TipoDatos IN ('decimal', 'numeric')  SELECT @fieldtype = 'fixed', @width = ISNULL(@Precision, 18), @decimals = @Escala
  ELSE IF @TipoDatos = 'binary'                 SELECT @fieldtype = 'bin.hex', @width = ISNULL(@Ancho, 1)
  ELSE IF @TipoDatos = 'varbinary'              SELECT @fieldtype = 'bin.hex', @width = ISNULL(@Ancho, 1), @subtype = 'Binary'

  IF @width < 0 SELECT @width = NULL
  IF @EsIdentity = 1 SELECT @readonly = 1, @subtype='Autoinc'

  SELECT @Resultado = '<FIELD '+
                      dbo.fnXML('attrname', @Campo)+
                      dbo.fnXML('fieldtype', @fieldtype)+
                      dbo.fnXML('subtype', @subtype)+
                      dbo.fnXMLInt('width', @width)+
                      dbo.fnXMLInt('decimals', @decimals)+
		      dbo.fnXMLBitTF('readonly', @readonly)+
                      '/>'
  RETURN (@Resultado)
END
GO
-- select dbo.fnUltEvaluacion('Desempeño', 'P1')
/**************** fnUltEvaluacion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltEvaluacion') DROP FUNCTION fnUltEvaluacion
GO
CREATE FUNCTION fnUltEvaluacion(@Evaluacion varchar(50), @Contacto varchar(20))
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha	datetime,
    @Resultado	float

  SELECT @Resultado = NULL
  SELECT @Fecha = MAX(Fecha) FROM EvaluacionCalificacion WHERE Evaluacion = @Evaluacion AND Contacto = @Contacto
  IF @Fecha IS NOT NULL
    SELECT TOP 1 @Resultado = Calificacion FROM EvaluacionCalificacion WHERE Evaluacion = @Evaluacion AND Contacto = @Contacto AND Fecha = @Fecha
  RETURN (@Resultado)
END
GO

-- select dbo.fnUltimoCHARINDEX('-', 'DICO-123-456')
/**************** fnUltimoCHARINDEX ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnUltimoCHARINDEX') DROP FUNCTION fnUltimoCHARINDEX
GO
CREATE FUNCTION fnUltimoCHARINDEX (@Valor varchar(max), @Texto varchar(max))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @UltP	int,
    @p		int

  SELECT @UltP = 0
  SELECT @p = CHARINDEX(@Valor, @Texto)
  WHILE @p > 0
  BEGIN
    SELECT @UltP = @p
    SELECT @p = CHARINDEX(@Valor, @Texto, @UltP+1)
  END

  RETURN(@UltP)
END
GO


-- select dbo.fnProyectoOriginal('DICO-1-1')
/**************** fnProyectoOriginal ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnProyectoOriginal') and type = 'fn') drop function dbo.fnProyectoOriginal
GO
CREATE FUNCTION dbo.fnProyectoOriginal (@Proyecto varchar(50))
RETURNS varchar(50)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE 
    @p		int,
    @Resultado	varchar(50)
 
  
  SELECT @p = dbo.fnUltimoCHARINDEX('-', @Proyecto)

  IF @p > 0 
    SELECT @Resultado = SUBSTRING(@Proyecto, 1, @p-1)
  ELSE SELECT @Resultado = @Proyecto

  RETURN(@Resultado)
END
GO

-- select dbo.fnRenglonTipo('SERIE')
/**************** fnRenglonTipo ****************/
if exists (select * from sysobjects where id = object_id('dbo.fnRenglonTipo') and type = 'fn') drop function dbo.fnRenglonTipo
GO
CREATE FUNCTION dbo.fnRenglonTipo (@ArtTipo varchar(50))
RETURNS char(1)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado char(1)
  -- SET nocount ON
  -- 'C' y 'E' Componente de un Juego
  -- No poner 'C' ni 'N'
  SELECT @ArtTipo = NULLIF(RTRIM(UPPER(@ArtTipo)), ''), @Resultado = 'N'
  IF @ArtTipo = 'SERIE'       SELECT @Resultado = 'S' ELSE
  IF @ArtTipo = 'LOTE'        SELECT @Resultado = 'L' ELSE
  IF @ArtTipo = 'VIN'         SELECT @Resultado = 'V' ELSE
  IF @ArtTipo = 'JUEGO'	      SELECT @Resultado = 'J' /*ELSE
  IF @ArtTipo = 'MATRIZ'      SELECT @Resultado = 'M' ELSE
  IF @ArtTipo = 'PARTIDA'     SELECT @Resultado = 'A' ELSE
*/
  RETURN(@Resultado)
END
GO

/*****************************   fnDiasBimestre   ************************* */
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnDiasBimestre' AND type = 'FN') DROP FUNCTION fnDiasBimestre
GO
CREATE FUNCTION fnDiasBimestre (@Fecha Datetime)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @DiasBimestre int,
	@Mes		  int,
	@Ano		  int,
	@Dias		  int, 
	@Fh			  datetime

	SELECT @Ano = DATEPART(YEAR,@Fecha)
	SELECT @Mes = DATEPART(MONTH,@Fecha)


	IF @Mes IN (1,2)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(1,@Ano)+dbo.fnDiasMes(2,@Ano)
	END
	ELSE IF @Mes IN (3,4)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(3,@Ano)+dbo.fnDiasMes(4,@Ano)
	END
	ELSE IF @Mes IN (5,6)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(5,@Ano)+dbo.fnDiasMes(6,@Ano)
	END
	ELSE IF @Mes IN (7,8)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(7,@Ano)+dbo.fnDiasMes(8,@Ano)
	END
	ELSE IF @Mes IN (9,10)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(9,@Ano)+dbo.fnDiasMes(10,@Ano)
	END
	ELSE IF @Mes IN (11,12)
	BEGIN
		SELECT @DiasBimestre = dbo.fnDiasMes(11,@Ano)+dbo.fnDiasMes(12,@Ano)
	END
        RETURN (@DiasBimestre)
END 
GO

-- select dbo.fnAlmacenTarima('A3', '123')
/*****************************   fnAlmacenTarima   ************************* */
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAlmacenTarima' AND type = 'FN') DROP FUNCTION fnAlmacenTarima
GO
CREATE FUNCTION fnAlmacenTarima (@Almacen varchar(10), @Tarima varchar(20))
RETURNS varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(20)
    
  SELECT @Resultado = NULL
  IF NULLIF(RTRIM(@Almacen), '') IS NOT NULL AND NULLIF(RTRIM(@Tarima), '') IS NOT NULL
     IF (SELECT ISNULL(WMS, 0) FROM Alm WHERE Almacen = @Almacen) = 1 SELECT @Resultado = @Tarima
    
  RETURN (ISNULL(@Resultado, ''))
END 
GO

/**************** fnCtaNivel ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCtaNivel') DROP FUNCTION fnCtaNivel
GO
CREATE FUNCTION fnCtaNivel (@Cuenta varchar(20), @ConEstructura bit)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Nivel  int,
    @Rama   varchar(20),
    @Tipo   varchar(20)
    
  SELECT @Nivel = NULL, @Rama = ''
  WHILE @Rama IS NOT NULL
  BEGIN
    SELECT @Rama = NULLIF(RTRIM(Rama), ''), @Tipo = Tipo FROM Cta WHERE Cuenta = @Cuenta 
    IF @ConEstructura = 0 AND UPPER(@Tipo) = 'ESTRUCTURA'
      SELECT @Rama = NULL
    ELSE
      SELECT @Nivel = ISNULL(@Nivel, 0) + 1, @Cuenta = @Rama
  END
  RETURN(@Nivel)
END
GO

/**************** fnCentrar ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCentrar') DROP FUNCTION fnCentrar
GO
CREATE FUNCTION fnCentrar (@Texto varchar(max), @Espacio int)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  IF LEN(@Texto)>@Espacio SELECT @Texto = SUBSTRING(@Texto, 1, @Espacio)
  RETURN(SPACE((@Espacio-LEN(@Texto))/2)+@Texto)
END
GO

/**************** fnAlinearDerecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAlinearDerecha') DROP FUNCTION fnAlinearDerecha
GO
CREATE FUNCTION fnAlinearDerecha (@Texto varchar(max), @Espacio int)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  IF LEN(@Texto)>@Espacio SELECT @Texto = SUBSTRING(@Texto, 1, @Espacio)
  RETURN(SPACE(@Espacio-LEN(@Texto))+@Texto)
END
GO

/**************** fnAlinearCampoValor ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnAlinearCampoValor') DROP FUNCTION fnAlinearCampoValor
GO
CREATE FUNCTION fnAlinearCampoValor (@Campo varchar(max), @Valor varchar(max), @Espacio int)
RETURNS varchar(max)
--//WITH ENCRYPTION
AS BEGIN
  IF LEN(@Valor)>@Espacio SELECT @Valor = SUBSTRING(@Valor, 1, @Espacio)
  IF LEN(@Campo)+LEN(@Valor)>@Espacio SELECT @Campo = SUBSTRING(@Campo, 1, @Espacio-LEN(@Campo))
  RETURN(@Campo+SPACE(@Espacio-LEN(@Campo)-LEN(@Valor))+@Valor)
END
GO

/*
select dbo.fnAlinearCampoValor('SubTotal','$10,000.00', 41)
select dbo.fnAlinearCampoValor('IVA','$1,500.00', 41)
select dbo.fnAlinearCampoValor('Total','$11,500.00', 41)

12345678901234567890*12345678901234567890
SubTotal                      $10,000.00
IVA                            $1,500.00
Total                         $11,500.00

*/

/**************** fnGestionPara ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnGestionPara') DROP FUNCTION fnGestionPara
GO
CREATE FUNCTION fnGestionPara (@ID int)
RETURNS varchar(255)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado  varchar(255),
    @Usuario	varchar(10)
  SELECT @Resultado = ''
 
  DECLARE crGestionPara CURSOR LOCAL FOR
   SELECT Usuario
     FROM GestionPara
    WHERE ID = @ID
  OPEN crGestionPara
  FETCH NEXT FROM crGestionPara INTO @Usuario
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(RTRIM(@Usuario), '') IS NOT NULL
    BEGIN
      IF @Resultado <> '' SELECT @Resultado = @Resultado + ', '
      SELECT @Resultado = @Resultado + @Usuario
    END
    FETCH NEXT FROM crGestionPara INTO @Usuario
  END -- While
  CLOSE crGestionPara
  DEALLOCATE crGestionPara
  RETURN (NULLIF(RTRIM(@Resultado), ''))
END
GO

-- SELECT Personal FROM dbo.fnPersonalAsignadoProyecto('P1')
/**************** fnPersonalAsignadoProyecto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnPersonalAsignadoProyecto' AND type = 'TF') DROP FUNCTION fnPersonalAsignadoProyecto
GO
CREATE FUNCTION fnPersonalAsignadoProyecto (@Proyecto varchar(50))
RETURNS @Resultado TABLE (Personal varchar(10))
--//WITH ENCRYPTION
AS BEGIN
  INSERT @Resultado (Personal)
  SELECT DISTINCT r.Personal
    FROM Proyecto p
    JOIN ProyectoRecurso pr ON pr.ID = p.ID AND pr.Estatus = 'ALTA'
    JOIN Recurso r ON r.Recurso = pr.Recurso
   WHERE p.Proyecto = @Proyecto AND p.Estatus IN ('PENDIENTE', 'CONCLUIDO')
  RETURN 
END
GO

-- 'CORTE'
if exists (select * from sysobjects where id = object_id('dbo.fnCantidadEnTexto') and type = 'FN') DROP FUNCTION dbo.fnCantidadEnTexto
GO
CREATE FUNCTION dbo.fnCantidadEnTexto(@Importe money)
RETURNS char(30)
AS
BEGIN
  DECLARE
  @Coma                 varchar(1),
  @Punto                varchar(1),
  @Largo                int,
  @LargoPunto           int,
  @Cadena               varchar(30),
  @CadenaPunto          varchar(5),
  @CadenaEntero         varchar(30),
  @Negativo             bit,
  @Texto                varchar(30)
  
  SELECT @Negativo = 0
  IF @Importe < 0
    SELECT @Negativo = 1
  SELECT @Importe = ABS(@Importe)
  
  SELECT @Coma = ',', @Punto = '.'
  SELECT @Cadena = @Importe
  SELECT @LargoPunto = CHARINDEX(@Punto, @Cadena, 1)
  SELECT @CadenaPunto = SUBSTRING(@Cadena, @LargoPunto+1, 20)
  SELECT @CadenaEntero = SUBSTRING(@Cadena, 1, @LargoPunto-1)
  SELECT @CadenaEntero = LTRIM(@CadenaEntero)
  SELECT @Largo = LEN(@CadenaEntero)
  
  WHILE @Largo > 3
  BEGIN
      SELECT @Cadena = RIGHT(@CadenaEntero, 3)
      SELECT @Texto = @Coma + LTRIM(@Cadena) + ISNULL(@Texto, '')
      SELECT @CadenaEntero = SUBSTRING(@CadenaEntero, 1, @Largo - 3)
      SELECT @Largo = LEN(@CadenaEntero)
  END
  
  IF @Largo > 0
    SELECT @Texto = LTRIM(@CadenaEntero) + ISNULL(@Texto, '')
  
  IF @LargoPunto > 0
    SELECT @Texto = ISNULL(@Texto, '') + @Punto + @CadenaPunto
      
  IF @Negativo = 1
    SELECT @Texto = '-' + @Texto
  
  RETURN @Texto
END
GO

if exists (select * from sysobjects where id = object_id('dbo.fnMonetarioEnTexto') and type = 'FN') DROP FUNCTION dbo.fnMonetarioEnTexto
GO
CREATE FUNCTION dbo.fnMonetarioEnTexto(@Importe money)
RETURNS char(30)
AS
BEGIN
  DECLARE
  @Signo                varchar(1),
  @Coma                 varchar(1),
  @Punto                varchar(1),
  @Largo                int,
  @LargoPunto           int,
  @Cadena               varchar(30),
  @CadenaPunto          varchar(5),
  @CadenaEntero         varchar(30),
  @Negativo             bit,
  @Texto                varchar(30)
  
  SELECT @Negativo = 0
  IF @Importe < 0
    SELECT @Negativo = 1
  SELECT @Importe = ABS(@Importe)
  
  SELECT @Signo = '$', @Coma = ',', @Punto = '.'
  SELECT @Cadena = @Importe
  SELECT @LargoPunto = CHARINDEX(@Punto, @Cadena, 1)
  SELECT @CadenaPunto = SUBSTRING(@Cadena, @LargoPunto+1, 20)
  SELECT @CadenaEntero = SUBSTRING(@Cadena, 1, @LargoPunto-1)
  SELECT @CadenaEntero = LTRIM(@CadenaEntero)
  SELECT @Largo = LEN(@CadenaEntero)
  
  WHILE @Largo > 3
  BEGIN
      SELECT @Cadena = RIGHT(@CadenaEntero, 3)
      SELECT @Texto = @Coma + LTRIM(@Cadena) + ISNULL(@Texto, '')
      SELECT @CadenaEntero = SUBSTRING(@CadenaEntero, 1, @Largo - 3)
      SELECT @Largo = LEN(@CadenaEntero)
  END
  
  IF @Largo > 0
    SELECT @Texto = LTRIM(@CadenaEntero) + ISNULL(@Texto, '')
  
  IF @LargoPunto > 0
    SELECT @Texto = ISNULL(@Texto, '') + @Punto + @CadenaPunto
    
  SELECT @Texto = @Signo + @Texto
  
  IF @Negativo = 1
    SELECT @Texto = '-' + @Texto
  
  RETURN @Texto
END
GO

/**************** fnRellenarConCaracter ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarConCaracter') DROP FUNCTION fnRellenarConCaracter
GO
CREATE FUNCTION fnRellenarConCaracter 
	(
	@Texto				varchar(100), 
	@Longitud				int,
	@Direccion				varchar(1),
	@Caracter				varchar(1)
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)
 IF @Direccion IN ('I','i') SELECT @Resultado = RIGHT(REPLICATE(@Caracter,(CASE WHEN @Longitud -LEN (@Texto) > 0 THEN @Longitud -LEN(@Texto) ELSE 0 END))+@Texto,@Longitud) ELSE
 IF @Direccion IN ('D','d') SELECT @Resultado = RIGHT(@Texto + REPLICATE(@Caracter,(@Longitud -LEN (@Texto))),@Longitud)
 
 RETURN (@Resultado)
  
END
GO


/**************** fnRellenarCerosIzquierda ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarCerosIzquierda') DROP FUNCTION fnRellenarCerosIzquierda
GO
CREATE FUNCTION fnRellenarCerosIzquierda 
	(
	@Numero				varchar(100), 
	@Longitud				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)

  SET @Numero =RTRIM(LTRIM(@Numero)) 
  SELECT  @Resultado =  dbo.fnRellenarConCaracter (@Numero,@Longitud,'I','0')
RETURN (@Resultado)
END
GO

/**************** fnContarLetras ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContarLetras') DROP FUNCTION fnContarLetras
GO
CREATE FUNCTION fnContarLetras 
	(
	@Texto				varchar(100), 
	@Letra				varchar(1)
		)
RETURNS int
--//WITH ENCRYPTION
AS BEGIN
   RETURN  (LEN(@Texto) - LEN(REPLACE(@Texto, @Letra, '')))
END
GO

/**************** fnFormatearFecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatearFecha') DROP FUNCTION fnFormatearFecha
GO
CREATE FUNCTION fnFormatearFecha
    (
        @fecha		 datetime,
		@forma		varchar(100)
	)
RETURNS VARCHAR (100)
AS
	BEGIN
	DECLARE @d int,
	        @m int,
	        @a  int,
	        @dia int,
	        @mes int,
	        @año int,
	        @ad varchar(100),
	        @am varchar(100),
	        @aa varchar(100),
	        @day varchar(100),
	        @month varchar(100),
	        @year varchar(100),
	        @rd varchar (100),
	        @rm varchar (100),
	        @ra varchar (100),
            @resultado varchar(100)

	SELECT @dia = DATEPART(d, @fecha) 
	SELECT @mes = DATEPART(m, @fecha)
	SELECT @año = DATEPART(yy, @fecha)

	SELECT @d = dbo.fnContarLetras(@forma,'D')
	SELECT @m = dbo.fnContarLetras(@forma,'M')
	SELECT @a = dbo.fnContarLetras(@forma,'A')

	SELECT @ad = dbo.fnRellenarCerosIzquierda(@dia,@d)
	SELECT @am = dbo.fnRellenarCerosIzquierda(@mes,@m)
	SELECT @aa = dbo.fnRellenarCerosIzquierda(@año,@a)

	SELECT @day=REPLICATE('D',@d)
	SELECT @month=REPLICATE('M',@m)
	SELECT @year=REPLICATE('A',@a)

	SELECT @rd=REPLACE(@forma, @day, @ad)
	SELECT @rm=REPLACE(@rd, @month, @am)
	SELECT @ra=REPLACE(@rm, @year, @aa)
    SET @resultado=@ra
RETURN @resultado
END
GO

/**************** fnRellenarEspaciosDerecha ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarEspaciosDerecha ') DROP FUNCTION fnRellenarEspaciosDerecha 
GO
CREATE FUNCTION fnRellenarEspaciosDerecha 
	(
	@Numero				varchar(100), 
	@Longitud				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)

  SET @Numero =RTRIM(LTRIM(@Numero)) 
  SELECT  @Resultado =  dbo.fnRellenarConCaracter (@Numero,@Longitud,'d',' ')
RETURN (@Resultado)
END
GO


/**************** fnRellenarEspaciosIzquierda ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnRellenarEspaciosIzquierda ') DROP FUNCTION fnRellenarEspaciosIzquierda 
GO
CREATE FUNCTION fnRellenarEspaciosIzquierda
	(
	@Numero				varchar(100), 
	@Longitud				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado   varchar(100)

  SET @Numero =RTRIM(LTRIM(@Numero)) 
  SELECT  @Resultado =  dbo.fnRellenarConCaracter (@Numero,@Longitud,'i',' ')
RETURN (@Resultado)
END
GO


/**************** fnFormatearNumero ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatearNumero') DROP FUNCTION fnFormatearNumero
GO
CREATE FUNCTION fnFormatearNumero 
	(
	@Numero				float, 
	@Enteros				int,
	@Decimales				int
	)
RETURNS varchar(100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado	varchar(100),
	@a			varchar(100)
    SELECT @a = CONVERT(varchar,FLOOR(@Numero*POWER(10,@Decimales)))
    SElECT @Resultado =dbo.fnRellenarCerosIzquierda(@a,@Enteros + @Decimales )

  RETURN (@Resultado)
END
GO


/**************** fnFormatearNumeroConPunto ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatearNumeroConPunto') DROP FUNCTION fnFormatearNumeroConPunto
GO
CREATE FUNCTION fnFormatearNumeroConPunto
	(
	@Numero					float, 
	@Enteros				int,
	@Decimales				int
	)
RETURNS varchar (100)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado			varchar(100),
	@TextoNumero		varchar(100),
    @TextoEnteros		varchar(100),
	@TextoDecimal		varchar(100)
 
  SELECT @TextoNumero = dbo.fnFormatearNumero(@numero,@Enteros,@Decimales)
  SELECT @TextoEnteros = ISNULL(LEFT(@TextoNumero,@Enteros),'')
  SELECT @TextoDecimal = ISNULL(RIGHT(@TextoNumero,@Decimales),'')
  SELECT @Resultado = @TextoEnteros + '.' + @TextoDecimal 	

  RETURN (@Resultado)
END
GO

/**************** fnFormatearNumero2 ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnFormatearNumero2') DROP FUNCTION fnFormatearNumero2
GO
CREATE FUNCTION fnFormatearNumero2 
	(
	@Numero				float,
	@Decimal			int
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
 @Resultado float
select  @Resultado=ROUND(@Numero, @Decimal, 1)

  RETURN (@Resultado)
END
GO

/**************** fnContactoDireccion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoDireccion') DROP FUNCTION fnContactoDireccion
GO
CREATE FUNCTION fnContactoDireccion 
	(
	@ContactoTipo				varchar(20), 
	@Contacto					varchar(10),
	@IncluirNombre				bit,		
	@IncluirContacto			bit,	
	@IncluirRFC					bit,
	@IncluirTelefono			bit
	)
RETURNS @Resultado TABLE
        (
		ID				int,
		ContactoTipo	varchar(20) COLLATE DATABASE_DEFAULT NULL,
		Contacto		varchar(10) COLLATE DATABASE_DEFAULT NULL,		
		Direccion		varchar(255) COLLATE DATABASE_DEFAULT NULL
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @Direccion						varchar(100),
    @DireccionNumero				varchar(20),
    @DireccionNumeroInt				varchar(20),
    @EntreCalles					varchar(100),
    @Colonia						varchar(100),
    @Delegacion						varchar(100),    
    @Poblacion						varchar(100),
    @Estado							varchar(30),
    @Pais							varchar(30),
    @CodigoPostal					varchar(15),
    @RFC							varchar(15),
    @Telefonos						varchar(100),  
    @Espacio						char(1),
    @Coma							char(1),
    @Contador						int,
    @ContactoCursor					varchar(10),
    @ContactoRegistro				varchar(50),
    @Nombre							varchar(255)
    
  SELECT @Espacio = ' ', @Coma = ',', @Contacto = NULLIF(@Contacto,'')
  
  IF @ContactoTipo = 'Cliente'   DECLARE crContacto CURSOR FOR SELECT Cliente,   NULLIF(RTRIM(Nombre),''),                                                                                         NULLIF(ISNULL(RTRIM(Contacto1),RTRIM(Contacto2)),''),   NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''), NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(Telefonos),'') FROM Cte      WHERE Cliente   = ISNULL(@Contacto,Cliente)   ELSE 
  IF @ContactoTipo = 'Proveedor' DECLARE crContacto CURSOR FOR SELECT Proveedor, NULLIF(RTRIM(Nombre),''),                                                                                         NULLIF(ISNULL(RTRIM(Contacto1),RTRIM(Contacto2)),''), NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''), NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(RFC),''),      NULLIF(RTRIM(Telefonos),'') FROM Prov     WHERE Proveedor = ISNULL(@Contacto,Proveedor) ELSE
  IF @ContactoTipo = 'Personal'  DECLARE crContacto CURSOR FOR SELECT Personal,  NULLIF(LTRIM(RTRIM(ISNULL(Nombre,'') + ' ' + ISNULL(ApellidoPaterno,'') + ' ' + ISNULL(ApellidoMaterno,''))),''), NULL,                                                 NULLIF(RTRIM(Direccion),''), NULLIF(RTRIM(DireccionNumero),''), NULLIF(RTRIM(DireccionNumeroInt),''), NULLIF(RTRIM(EntreCalles),''), NULLIF(RTRIM(Delegacion),''), NULLIF(RTRIM(Colonia),''), NULLIF(RTRIM(Poblacion),''), NULLIF(RTRIM(Estado),''), NULLIF(RTRIM(Pais),''), NULLIF(RTRIM(CodigoPostal),''), NULLIF(RTRIM(Registro),''), NULLIF(RTRIM(Telefono),'')  FROM Personal WHERE Personal  = ISNULL(@Contacto, Personal)

  OPEN crContacto
  FETCH NEXT FROM crContacto INTO @ContactoCursor, @Nombre, @ContactoRegistro, @Direccion, @DireccionNumero, @DireccionNumeroInt, @EntreCalles, @Colonia, @Delegacion, @Poblacion, @Estado, @Pais, @CodigoPostal, @RFC, @Telefonos      
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @Contador = 0

    IF @Nombre IS NOT NULL AND @IncluirNombre = 1
    BEGIN
      SET @Contador = @Contador + 1
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Nombre,'')
    END     

    IF @ContactoRegistro IS NOT NULL AND @IncluirContacto = 1
    BEGIN
      SET @Contador = @Contador + 1
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@ContactoRegistro,'')
    END     
    
    IF @Direccion IS NOT NULL OR @DireccionNumero IS NOT NULL OR @DireccionNumeroInt IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Direccion,'') + @Espacio + ISNULL(@DireccionNumero,'') + @Espacio + ISNULL(@DireccionNumeroInt,'')
    END     

    IF @EntreCalles IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1    
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@EntreCalles,'')
    END     
  
    IF @Colonia IS NOT NULL OR @Delegacion IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Colonia,'') + CASE WHEN @Colonia + @Delegacion IS NOT NULL THEN @Coma + @Espacio ELSE '' END + ISNULL(@Delegacion,'') 
    END  
  
    IF @Poblacion IS NOT NULL OR @Estado IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Poblacion,'') + CASE WHEN @Poblacion + @Estado IS NOT NULL THEN @Coma + @Espacio ELSE '' END + ISNULL(@Estado,'') 
    END  

    IF @Pais IS NOT NULL OR @CodigoPostal IS NOT NULL
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Pais,'') + CASE WHEN @Pais + @CodigoPostal IS NOT NULL  THEN @Coma + @Espacio ELSE '' END + ISNULL(@CodigoPostal,'') 
    END  

    IF @RFC IS NOT NULL AND @IncluirRFC = 1
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@RFC,'')
    END  

    IF @Telefonos IS NOT NULL AND @IncluirTelefono = 1
    BEGIN
      SET @Contador = @Contador + 1        
      INSERT @Resultado (ID,        ContactoTipo,  Contacto,        Direccion)
                 SELECT  @Contador, @ContactoTipo, @ContactoCursor, ISNULL(@Telefonos,'')
    END  

    FETCH NEXT FROM crContacto INTO @ContactoCursor, @Nombre, @ContactoRegistro, @Direccion, @DireccionNumero, @DireccionNumeroInt, @EntreCalles, @Colonia, @Delegacion, @Poblacion, @Estado, @Pais, @CodigoPostal, @RFC, @Telefonos        
  END
  CLOSE crContacto
  DEALLOCATE crContacto

  RETURN
END
GO

--SELECT * FROM dbo.fnContactoDireccion('Cliente',NULL,1,1,1,1)

/**************** fnContactoDireccionHorizontal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnContactoDireccionHorizontal') DROP FUNCTION fnContactoDireccionHorizontal
GO
CREATE FUNCTION fnContactoDireccionHorizontal 
	(
	@ContactoTipo				varchar(20), 
	@Contacto					varchar(10),
	@IncluirNombre				bit,		
	@IncluirContacto			bit,	
	@IncluirRFC					bit,
	@IncluirTelefono			bit
	)
RETURNS @Resultado TABLE
        (
        ContactoTipo	varchar(20) COLLATE DATABASE_DEFAULT NULL,
		Contacto		varchar(10) COLLATE DATABASE_DEFAULT NULL,
		Direccion1		varchar(255) COLLATE DATABASE_DEFAULT NULL,
		Direccion2		varchar(255) COLLATE DATABASE_DEFAULT NULL,		
		Direccion3		varchar(255) COLLATE DATABASE_DEFAULT NULL,
		Direccion4		varchar(255) COLLATE DATABASE_DEFAULT NULL,		
		Direccion5		varchar(255) COLLATE DATABASE_DEFAULT NULL,
		Direccion6		varchar(255) COLLATE DATABASE_DEFAULT NULL,
		Direccion7		varchar(255) COLLATE DATABASE_DEFAULT NULL,
		Direccion8		varchar(255) COLLATE DATABASE_DEFAULT NULL,																						
		Direccion9		varchar(255) COLLATE DATABASE_DEFAULT NULL																								
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ContactoCursor				varchar(10),
    @ContactoTipoCursor			varchar(20),
    @DireccionCursor			varchar(255),
    @ID							int
    
  SET @Contacto = NULLIF(@Contacto,'')
  
  DECLARE @Direccion TABLE
          (
          ContactoTipo	varchar(20) COLLATE DATABASE_DEFAULT NULL,
          Contacto		varchar(10) COLLATE DATABASE_DEFAULT NULL,          
	  	  ID			int,
		  Direccion		varchar(255) COLLATE DATABASE_DEFAULT NULL
          )
        
  INSERT @Direccion (ContactoTipo, Contacto, ID, Direccion)      
             SELECT  ContactoTipo, Contacto, ID, Direccion
               FROM dbo.fnContactoDireccion(@ContactoTipo,@Contacto,@IncluirNombre,@IncluirContacto,@IncluirRFC, @IncluirTelefono)  
  

  DECLARE crContacto CURSOR FOR
   SELECT ContactoTipo, Contacto
     FROM @Direccion 
    GROUP BY ContactoTipo, Contacto 

  OPEN crContacto
  FETCH NEXT FROM crContacto INTO @ContactoTipoCursor, @ContactoCursor
  WHILE @@FETCH_STATUS = 0
  BEGIN
       
    INSERT @Resultado (ContactoTipo,        Contacto,        Direccion1) 
               SELECT  @ContactoTipoCursor, @ContactoCursor, d.Direccion
                 FROM  @Direccion d
                WHERE  d.ID = 1
                  AND  d.Contacto = @ContactoCursor
                  AND  d.ContactoTipo = @ContactoTipoCursor
                  
    
    UPDATE @Resultado SET Direccion2 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 2 
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion3 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 3 
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion4 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 4 
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion5 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 5 
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion6 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 6
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion7 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 7
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion8 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 8
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor

    UPDATE @Resultado SET Direccion9 = d.Direccion 
      FROM @Resultado r JOIN @Direccion d 
        ON d.ContactoTipo = r.ContactoTipo AND d.Contacto = r.Contacto
     WHERE d.ID = 9
       AND d.Contacto = @ContactoCursor 
       AND d.ContactoTipo = @ContactoTipoCursor
    
    FETCH NEXT FROM crContacto INTO @ContactoTipoCursor, @ContactoCursor    
  END
  CLOSE crContacto
  DEALLOCATE crContacto
  
  RETURN
END
GO

--SELECT * FROM dbo.fnContactoDireccionHorizontal('Cliente','',1,1,1,1)

/**************** fnTipoCambio ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoCambio') DROP FUNCTION fnTipoCambio
GO
CREATE FUNCTION fnTipoCambio 
	(
	@Moneda				varchar(10)
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambio	float

  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda
  
  RETURN (@TipoCambio)
END
GO

/**************** fnTipoCambioVenta ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoCambioVenta') DROP FUNCTION fnTipoCambioVenta --MEJORA6230
GO
CREATE FUNCTION fnTipoCambioVenta 
	(
	@Moneda				varchar(10)
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambio	float

  SELECT @TipoCambio = ISNULL(TipoCambioVenta,TipoCambio) FROM Mon WHERE Moneda = @Moneda
  
  RETURN (@TipoCambio)
END
GO

/**************** fnTipoCambioCompra ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTipoCambioCompra') DROP FUNCTION fnTipoCambioCompra --MEJORA6230
GO
CREATE FUNCTION fnTipoCambioCompra 
	(
	@Moneda				varchar(10)
	)
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoCambio	float

  SELECT @TipoCambio = ISNULL(TipoCambioCompra,TipoCambio) FROM Mon WHERE Moneda = @Moneda
  
  RETURN (@TipoCambio)
END
GO


/**************** fnImporteAMoneda ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnImporteAMoneda') DROP FUNCTION fnImporteAMoneda
GO
CREATE FUNCTION fnImporteAMoneda 
	(
	@Importe				float,
	@ImporteTipoCambio		float,
	@MonedaDestino			varchar(10)
	)
	
RETURNS float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ImporteDestino				float,
    @TipoCambioDestino			float
    
  SET @ImporteDestino = NULL
  
  SET @TipoCambioDestino = dbo.fnTipoCambio(@MonedaDestino)  
  IF @TipoCambioDestino IS NOT NULL
    SET @ImporteDestino = (@Importe*@ImporteTipoCambio)/@TipoCambioDestino
  
  RETURN (@ImporteDestino)
END
GO

/**************** fnMovOpcionActiva ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovOpcionActiva') DROP FUNCTION dbo.fnMovOpcionActiva
GO
CREATE FUNCTION dbo.fnMovOpcionActiva 
	(
	@Opcion			varchar(1)
	)

RETURNS bit

--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @Resultado				bit

  SET @Resultado = 0
  
  IF EXISTS(SELECT * FROM Opcion WHERE Opcion = @Opcion)
    SET @Resultado = 1

  RETURN @Resultado
END
GO

/**************** fnMovOpcionEncabezado ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovOpcionEncabezado') DROP FUNCTION dbo.fnMovOpcionEncabezado
GO
CREATE FUNCTION dbo.fnMovOpcionEncabezado 
	(
	@Opcion			varchar(1)
	)

RETURNS varchar(100)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE    
    @Resultado		varchar(100)

  SET @Resultado = ''
  
  SELECT @Resultado = ISNULL(DescripcionCorta,'Opción ' + @Opcion) FROM Opcion WHERE Opcion = @Opcion

  RETURN @Resultado
END
GO

/**************** fnMovOpcionListaSeleccion ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovOpcionListaSeleccion') DROP FUNCTION dbo.fnMovOpcionListaSeleccion
GO
CREATE FUNCTION dbo.fnMovOpcionListaSeleccion 
	(
	@OpcionOriginal			varchar(50),
	@Verificar				bit
	)

RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @LongitudTexto			bigint,
    @Caracter				char(1),
    @Contador				bigint,
    @Estado					int,
    @EstadoAnterior			int,
    @Resultado				varchar(max),
    @OpcionNoValida			varchar(50),
    @Opcion					varchar(1)
            

  SELECT @LongitudTexto = LEN(@OpcionOriginal), @Contador = 1, @Estado = 0, @Resultado = ''
  WHILE @Contador <= @LongitudTexto
  BEGIN
    SELECT @Caracter = SUBSTRING(@OpcionOriginal,@Contador,1)
    SET @EstadoAnterior = @Estado
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z') THEN 1
      WHEN @Estado = 1 AND @Caracter NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z') THEN 0
      ELSE @Estado
    END

    IF @Estado = 1
    BEGIN            
      SELECT @Opcion = @Caracter
      IF SUBSTRING(@OpcionOriginal,@Contador+1,1) NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z')
      BEGIN
        IF @Verificar = 0
          SELECT @Resultado = @Resultado + @Opcion + ', '
        ELSE
          SELECT @Resultado = @Resultado + CHAR(39) + @Opcion + CHAR(39) + ', '
      END
    END
    
    SET @Contador = @Contador + 1
  END

  IF LEN(@Resultado) > 1
    SELECT @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado)-1)

  RETURN @Resultado
END
GO

/**************** fnMovOpcionValores ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnMovOpcionValores') DROP FUNCTION dbo.fnMovOpcionValores
GO
CREATE FUNCTION dbo.fnMovOpcionValores 
	(
	@OpcionOriginal			varchar(50)
	)

RETURNS varchar(max)

--//WITH ENCRYPTION
AS BEGIN

  DECLARE
    @LongitudTexto			bigint,
    @Caracter				char(1),
    @Contador				bigint,
    @Estado					int,
    @EstadoAnterior			int,
    @NoOpcion				int,
    @Resultado				varchar(max),
    @Numero					varchar(50),
    @Letra					varchar(1)
          

  SELECT @LongitudTexto = LEN(@OpcionOriginal), @Contador = 1, @Estado = 0, @Resultado = '', @Resultado = '', @Numero = '', @Letra = ''
  WHILE @Contador <= @LongitudTexto
  BEGIN
    SELECT @Caracter = SUBSTRING(@OpcionOriginal,@Contador,1)
	SET @EstadoAnterior = @Estado
    SET @Estado = CASE 
      WHEN @Estado = 0 AND @Caracter IN ('Ñ','A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z') THEN 1
      WHEN @Estado = 1 AND @Caracter NOT IN ('Ñ', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z') THEN 0
      ELSE @Estado
    END

    IF @Estado = 0
    BEGIN
      IF @NoOpcion <> 0
	    SELECT @Numero = @Numero + @Caracter
    END
    
    IF @Estado = 1
    BEGIN
      IF @Letra = 'Ñ' SET @Numero = ''      
      IF LEN(@Letra) > 0 AND LEN(@Numero) > 0
      BEGIN
        SELECT @Resultado = @Resultado + CHAR(39) + RTRIM(d.Nombre) + CHAR(39) + ','
          FROM OpcionD d
         WHERE d.Opcion = @Letra 
           AND d.Numero = CONVERT(int,@Numero)   
     
        SET @Letra = ''
        SET @Numero = ''
      END
          
      SET @Letra = @Caracter
    END 
      
    SET @Contador = @Contador + 1
  END

  IF @Letra = 'Ñ' SET @Numero = ''  
  IF LEN(@Letra) > 0 AND LEN(@Numero) > 0
  BEGIN
    SELECT @Resultado = @Resultado + CHAR(39) + RTRIM(d.Nombre) + CHAR(39) + ','
      FROM OpcionD d
     WHERE d.Opcion = @Letra 
       AND d.Numero = CONVERT(int,@Numero)     
  END
  IF LEN(@Letra) > 0 AND LEN(@Numero) < 1 AND @EstadoAnterior = @Estado
  BEGIN
    SELECT @Resultado = @Resultado + CHAR(39) + RTRIM(Descripcion) + CHAR(39) + ','
      FROM Opcion
     WHERE Opcion = @Letra 
  END

  
  IF LEN(@Resultado) > 1
    SELECT @Resultado = SUBSTRING(@Resultado, 1, LEN(@Resultado)-1)

  RETURN @Resultado
END
GO

/**************** fnQuitarCerosIzq ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnQuitarCerosIzq') DROP FUNCTION fnQuitarCerosIzq
GO
CREATE FUNCTION fnQuitarCerosIzq 
	(
			@Clave		varchar(100)
    )
RETURNS varchar(100)    
--//WITH ENCRYPTION
AS BEGIN    
  WHILE SUBSTRING(@Clave, 1, 1) = '0'
    SELECT @Clave = SUBSTRING(@Clave, 2, LEN(@Clave)-1)
  RETURN (@Clave)
END
GO

/**************** fnConvertirTextoaTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnConvertirTextoaTabla') DROP FUNCTION fnConvertirTextoaTabla
GO
CREATE FUNCTION fnConvertirTextoaTabla (@Texto varchar(max), @Longitud int, @Caracter char(1))
RETURNS @Tabla TABLE (Resultado varchar(255))
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Resultado 	varchar(max)

  SELECT @Texto = ISNULL(RTRIM(@Texto), ''),
         @Caracter = NULLIF(@Caracter, '')

  WHILE LEN(@Texto) > 0 AND @Longitud > 0 AND @Caracter IS NULL
  BEGIN   
      SELECT @Resultado = LTRIM(RTRIM(SUBSTRING(@Texto, 1, @Longitud-1)))
      SELECT @Texto = SUBSTRING(@Texto, @Longitud, LEN(@Texto))
    
    SELECT @Resultado = NULLIF(RTRIM(@Resultado), '')
    
	IF @Resultado IS NOT NULL
      INSERT @Tabla (Resultado)
      SELECT        @Resultado
  END
  
  WHILE CHARINDEX(@Caracter, @Texto) > 0 AND @Longitud = 0
  BEGIN
    INSERT @Tabla (Resultado)
    SELECT LTRIM(RTRIM(SUBSTRING(@Texto, 1, CHARINDEX(',', @Texto)-1)))

    SELECT @Texto = SUBSTRING(@Texto,CHARINDEX(',', @Texto)+1, LEN(@Texto))
  END
    
  RETURN 
END
GO

/**************** fnCopiarTabla ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnCopiarTabla') DROP FUNCTION fnCopiarTabla
GO
CREATE FUNCTION fnCopiarTabla
	(
	@Tabla varchar(50)
	)
RETURNS @Resultado TABLE
        (
        Tabla		varchar(50) COLLATE DATABASE_DEFAULT NULL
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Campo varchar(50)
  
  SELECT @Campo = @Tabla, @Tabla = @Tabla + '%'
  
  INSERT @Resultado
  SELECT CASE WHEN @Campo = 'UsuarioAcceso' THEN 'UsuarioMenuOpcion' END Tabla
  UNION ALL
  SELECT Tabla
    FROM SysCampoExt
   WHERE Tabla LIKE @Tabla
     AND Tabla <> CASE WHEN @Campo = 'UsuarioAcceso' THEN '' ELSE @Campo END
     AND Campo = CASE WHEN @Campo = 'UsuarioAcceso' THEN Campo ELSE @Campo END
     AND Tabla <> CASE WHEN @Campo = 'Usuario' THEN 'UsuarioAcceso' ELSE '' END
     AND Tabla <> CASE WHEN @Campo = 'Usuario' THEN 'UsuarioAccesoForma' ELSE '' END
     AND Tabla <> CASE WHEN @Campo = 'Usuario' THEN 'UsuarioMenuOpcion' ELSE '' END
   GROUP BY Tabla
   ORDER BY Tabla
   
  RETURN
END
GO

/**************** fnTablaCamposPK ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnTablaCamposPK') DROP FUNCTION fnTablaCamposPK
GO
CREATE FUNCTION fnTablaCamposPK(@Texto varchar(max), @Caracter char(1))
RETURNS int  
AS
BEGIN 
	DECLARE
	  @Resultado varchar(max)
	  
	SET @Resultado = REPLACE(@Texto,@Caracter,'')
	RETURN (LEN(@Texto) - LEN(@Resultado))+1
END
GO

