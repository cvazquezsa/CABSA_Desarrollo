/* SP ACTIVOS FIJOS   */

-- AF.DP Depreciacion
-- AF.DT Depreciacion Total
-- AF.RE Reparacion
-- AF.MA Mantenimiento
-- AF.PM Poliza Mantenimiento
-- AF.PS Poliza Seguro
-- AF.RV Revaluacion

SET NOCOUNT ON

/**************** fnSubClaveFiscal ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnSubClaveFiscal') DROP FUNCTION fnSubClaveFiscal
GO
CREATE FUNCTION fnSubClaveFiscal (@Clave varchar(20))
RETURNS int
--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
     @Resultado	int

  SELECT @Resultado = NULL
  IF NULLIF(RTRIM(@Clave), '') IS NOT NULL
  BEGIN
    IF @Clave LIKE '%/F2' SELECT @Resultado = 2 ELSE
    IF @Clave LIKE '%/F'  SELECT @Resultado = 1 
  END
  RETURN(@Resultado)
END
GO

/**************** spActivoFLectura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFLectura') and type = 'P') drop procedure dbo.spActivoFLectura
GO       
CREATE PROCEDURE spActivoFLectura
			@Accion			char(20),
			@Empresa		char(5),
			@Articulo		char(20),
			@Serie			varchar(50),
			@Concepto		varchar(50),
			@Fecha			datetime,
			@Lectura		int,
			@LecturaAnterior	int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  IF @Accion = 'CANCELAR'
  BEGIN
    UPDATE ActivoFLectura 
       SET Lectura = @LecturaAnterior 
     WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie AND Concepto = @Concepto
  END ELSE
  BEGIN
    SELECT @LecturaAnterior = NULL
    SELECT @LecturaAnterior = Lectura 
      FROM ActivoFLectura
     WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie AND Concepto = @Concepto

    UPDATE ActivoFLectura
       SET Lectura = @Lectura, Fecha = @Fecha
     WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie AND Concepto = @Concepto
    IF @@ROWCOUNT = 0
      INSERT ActivoFLectura (Empresa,  Articulo,  Serie,  Concepto,  Lectura,  Fecha)
                     VALUES (@Empresa, @Articulo, @Serie, @Concepto, @Lectura, @Fecha)
  END
  RETURN
END
GO


/**************** spActivoFijoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoVerificar') and type = 'P') drop procedure dbo.spActivoFijoVerificar
GO
CREATE PROCEDURE spActivoFijoVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @MovMoneda			char(10),
		    @FechaEmision		datetime,
    		    @Condicion			varchar(50),
    		    @Vencimiento		datetime,
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),
    		    @Ejercicio	      		int,
    		    @Periodo	      		int,

		    @Personal			char(10),
		    @Espacio			char(10),
		    @ContUso			varchar(20),
		    -- 9036
		    @ContUso2			varchar(20),
		    @ContUso3			varchar(20),
		    @Todo			bit,
                    @Revaluar			bit, 
		    @ValorMercado		bit,

		    @CfgTabla			varchar(50),

    		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
		    -- 9150
		    @FormaPago			varchar(50),
	
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT,
    		    @SubClave			varchar(20) = NULL,
    		    @SubClaveFiscal		int	    = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
     @Articulo			char(20),
     @Serie			varchar(50),
     @ActivoFEstatus		char(15),
     @SeguroVence		datetime,
     @MantenimientoVence	datetime,
     @VidaUtil			int,
     @DepreciacionMeses		int,
     @Moneda			char(10),
     @AFEspacio			char(10),
     @AFResponsable		char(10),
     @AFContUso			varchar(20),
     
     -- 9036
     @AFContUso2		varchar(20),
     @AFContUso3		varchar(20),
     
     @AFCategoria		varchar(50)

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    -- 9036
    IF @MovTipo IN ('AF.A', 'AF.D') AND @Ok IS NULL
      IF (@Personal IS NULL AND @Espacio IS NULL AND @ContUso IS NULL AND @ContUso2 IS NULL AND @ContUso3 IS NULL) OR (@Personal IS NOT NULL AND @Espacio IS NOT NULL AND @ContUso IS NOT NULL AND @ContUso2 IS NOT NULL AND @ContUso3 IS NOT NULL) SELECT @Ok = 55105

    IF @MovTipo IN ('AF.PM', 'AF.PS') AND @Ok IS NULL
      EXEC spVerificarVencimiento @Condicion, @Vencimiento, @FechaEmision, @Ok OUTPUT

    -- 9150
    IF @MovTipo IN('AF.PS', 'AF.PM', 'AF.RE', 'AF.MA') AND @Ok IS NULL AND NULLIF(@FormaPago, '') IS NOT NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago    
    END

    IF @Ok IS NOT NULL RETURN
    IF @MovTipo IN ('AF.DP', 'AF.RV') AND @Todo = 1 RETURN

    -- 9036
    DECLARE crVerificarActivoFijo CURSOR FOR
     SELECT NULLIF(RTRIM(d.Articulo), ''), NULLIF(RTRIM(d.Serie), ''), NULLIF(RTRIM(af.Estatus), ''), af.MantenimientoVence, af.SeguroVence, 
            ISNULL(CASE @SubClaveFiscal WHEN 1 THEN af.VidaUtilF	  WHEN 2 THEN af.VidaUtilF2	     ELSE af.VidaUtil END, 0), 
            ISNULL(CASE @SubClaveFiscal WHEN 1 THEN af.DepreciacionMesesF WHEN 2 THEN af.DepreciacionMesesF2 ELSE af.DepreciacionMeses END, 0), 
            RTRIM(af.Moneda), NULLIF(RTRIM(af.Responsable), ''), NULLIF(RTRIM(af.Espacio), ''), NULLIF(RTRIM(af.CentroCostos), ''), NULLIF(RTRIM(af.Categoria), ''),
            NULLIF(RTRIM(af.ContUso2), ''), NULLIF(RTRIM(af.ContUso3), '')
       FROM ActivoFijoD d
       LEFT OUTER JOIN ActivoF af ON d.Articulo = af.Articulo AND d.Serie = af.Serie AND af.Empresa = @Empresa
      WHERE d.ID = @ID 

    OPEN crVerificarActivoFijo
    FETCH NEXT FROM crVerificarActivoFijo INTO @Articulo, @Serie, @ActivoFEstatus, @MantenimientoVence, @SeguroVence, @VidaUtil, @DepreciacionMeses, @Moneda, @AFResponsable, @AFEspacio, @AFContUso, @AFCategoria, @AFContUso2, @AFContUso3
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @MovTipo IN ('AF.DP', 'AF.DT', 'AF.RV') 
          IF (SELECT UPPER(Propietario) FROM ActivoFCat WHERE Categoria = @AFCategoria) <> 'EMPRESA' SELECT @Ok = 44190
 
        IF @MovTipo IN ('AF.DP', 'AF.DT') AND (@VidaUtil - @DepreciacionMeses) <= 0 SELECT @Ok = 44080 ELSE
        IF @ActivoFEstatus IN (NULL, 'INACTIVO') SELECT @Ok = 44030 ELSE
        IF @MovTipo = 'AF.RE' AND @Estatus = 'PENDIENTE' AND @ActivoFEstatus <> 'REPARACION'    SELECT @Ok = 44050 ELSE
        IF @MovTipo = 'AF.MA' AND @Estatus = 'PENDIENTE' AND @ActivoFEstatus <> 'MANTENIMIENTO' SELECT @Ok = 44060 ELSE
        IF @Estatus IN ('CONCLUIDO', 'VIGENTE') AND @ActivoFEstatus <> 'ACTIVO' SELECT @Ok = 44030
        IF @MovTipo = 'AF.PM' AND @Estatus = 'VIGENTE' AND @MantenimientoVence IS NOT NULL AND @FechaEmision < @MantenimientoVence SELECT @Ok = 44070 ELSE
        IF @MovTipo = 'AF.PS' AND @Estatus = 'VIGENTE' AND @SeguroVence IS NOT NULL AND @FechaEmision < @SeguroVence SELECT @Ok = 44070 ELSE
        IF @MovTipo IN ('AF.DP', 'AF.DT', 'AF.RV') AND @MovMoneda <> @Moneda SELECT @Ok = 44090
  
        IF @MovTipo IN ('AF.A', 'AF.D') 
        BEGIN
          IF @Espacio IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @MovTipo = 'AF.A' AND @AFEspacio IS NOT NULL  SELECT @Ok = 44130 ELSE
            IF @MovTipo = 'AF.D' AND @AFEspacio IS NULL      SELECT @Ok = 44140 ELSE
            IF @MovTipo = 'AF.D' AND @AFEspacio <> @Espacio  SELECT @Ok = 44150
            IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie) + ' ('+RTRIM(@AFEspacio)+')'
          END
          IF @Personal IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @MovTipo = 'AF.A' AND @AFResponsable IS NOT NULL  SELECT @Ok = 44130 ELSE
            IF @MovTipo = 'AF.D' AND @AFResponsable IS NULL      SELECT @Ok = 44140 ELSE
            IF @MovTipo = 'AF.D' AND @AFResponsable <> @Personal SELECT @Ok = 44150
            IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie) + ' ('+RTRIM(@AFResponsable)+')'
          END
          IF @ContUso IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @MovTipo = 'AF.A' AND @AFContUso IS NOT NULL SELECT @Ok = 44130 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso IS NULL     SELECT @Ok = 44140 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso <> @ContUso SELECT @Ok = 44150
            IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie) + ' ('+RTRIM(@AFContUso)+')'
          END
          -- 9036
          IF @ContUso2 IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @MovTipo = 'AF.A' AND @AFContUso2 IS NOT NULL  SELECT @Ok = 44130 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso2 IS NULL      SELECT @Ok = 44140 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso2 <> @ContUso2 SELECT @Ok = 44150
            IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie) + ' ('+RTRIM(@AFContUso2)+')'
          END          
          IF @ContUso3 IS NOT NULL AND @Ok IS NULL
          BEGIN
            IF @MovTipo = 'AF.A' AND @AFContUso3 IS NOT NULL  SELECT @Ok = 44130 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso3 IS NULL      SELECT @Ok = 44140 ELSE
            IF @MovTipo = 'AF.D' AND @AFContUso3 <> @ContUso3 SELECT @Ok = 44150
            IF @Ok IS NOT NULL SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie) + ' ('+RTRIM(@AFContUso3)+')'
          END                    
        END

        IF @Ok IS NOT NULL AND @OkRef IS NULL 
          SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie)
      END
      -- 9036
      FETCH NEXT FROM crVerificarActivoFijo INTO @Articulo, @Serie, @ActivoFEstatus, @MantenimientoVence, @SeguroVence, @VidaUtil, @DepreciacionMeses, @Moneda, @AFResponsable, @AFEspacio, @AFContUso, @AFCategoria, @AFContUso2, @AFContUso3
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crVerificarActivoFijo
    DEALLOCATE crVerificarActivoFijo

  END 
  RETURN
END
GO

/**************** spActivoFijoCopiarTodo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoCopiarTodo') and type = 'P') drop procedure dbo.spActivoFijoCopiarTodo
GO             
CREATE PROCEDURE spActivoFijoCopiarTodo
		   @Sucursal		int,
 		   @Empresa		char(5),
    		   @ID  		int,
		   @MovTipo		char(20),
		   @MovMoneda		char(10),
		   @FechaEmision	datetime,
		   @Ok			int	OUTPUT,
    		   @SubClave		varchar(20) = NULL,
    		   @SubClaveFiscal	int	    = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo	char(20),
    @Serie	varchar(50),
    @Renglon	float

  SELECT @Renglon = 0
  DELETE ActivoFijoD WHERE ID = @ID

  IF @MovTipo = 'AF.DP' 
  BEGIN
    IF @SubClaveFiscal = 1
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtilF, 0) - ISNULL(af.DepreciacionMesesF, 0) > 0)
          AND af.DepreciacionInicioF <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltimaF,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltimaF,0)) < DATEPART(YEAR, @FechaEmision))
    ELSE
    IF @SubClaveFiscal = 2
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtilF2, 0) - ISNULL(af.DepreciacionMesesF2, 0) > 0)
          AND af.DepreciacionInicioF2 <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltimaF2,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltimaF2,0)) < DATEPART(YEAR, @FechaEmision))
    ELSE
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtil, 0) - ISNULL(af.DepreciacionMeses, 0) > 0)
          AND af.DepreciacionInicio <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltima,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltima,0)) < DATEPART(YEAR, @FechaEmision))

  END ELSE
    DECLARE crActivoFijoTodo CURSOR FOR SELECT NULLIF(RTRIM(Articulo), ''), NULLIF(RTRIM(Serie), '') FROM ActivoF WHERE Empresa = @Empresa AND Estatus <> 'INACTIVO' AND Moneda = @MovMoneda 

  OPEN crActivoFijoTodo
  FETCH NEXT FROM crActivoFijoTodo INTO @Articulo, @Serie
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048
      INSERT ActivoFijoD (Sucursal, ID, Renglon, RenglonSub, Articulo, Serie) 
                  VALUES (@Sucursal, @ID, @Renglon, 0, @Articulo, @Serie)
    END
    FETCH NEXT FROM crActivoFijoTodo INTO @Articulo, @Serie
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crActivoFijoTodo
  DEALLOCATE crActivoFijoTodo
  RETURN
END
GO

/**************** spActivoFijoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoAfectar') and type = 'P') drop procedure dbo.spActivoFijoAfectar
GO             
CREATE PROCEDURE spActivoFijoAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
                   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
		   @FechaConclusion		datetime,

    		   @Condicion			varchar(50),
    		   @Vencimiento			datetime,

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
		   @Concepto			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Proveedor			char(10),
		   @Personal			char(10),
		   @Espacio			char(10),
                   @ContUso			varchar(20),
                   -- 9036
                   @ContUso2		varchar(20),
                   @ContUso3		varchar(20),
		   @FormaPago			varchar(50),
		   @CtaDinero			char(10),

		   @Todo			bit,
                   @Revaluar			bit, 
		   @ValorMercado		bit,
		   @FechaRegistroAnterior	datetime,

		   @Conexion			bit,
		   @SincroFinal			bit,
                   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgTabla			varchar(50),
		   @CfgAfectarDinero		bit,
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),

		   @IDGenerar			int	     	OUTPUT,	
		   @GenerarMovID	  	varchar(20)	OUTPUT,

           -- 11042
		   @AFGenerarGasto		bit,
		   @AFGenerarGastoCfg	varchar(20),
    
       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT,
    		   @SubClave			varchar(20) = NULL,
    		   @SubClaveFiscal		int	    = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @a					int,
    @DineroMov				char(20),
    @DineroMovID			varchar(20),
    @Generar				bit,
    @GenerarAfectado			bit,
    @GenerarModulo			char(5),
    @GenerarMovTipo			char(20),
    @GenerarEstatus			char(15),
    @GenerarPeriodo 			int, 
    @GenerarEjercicio 			int,
    @Articulo				char(20),
    @ArtMoneda				char(10),
    @ArtTipoCambio			float,
    @ArtFactor				float,
    @Serie				varchar(50),
    @Horas				float,
    @Importe				money, 
    @Impuestos				money, 
    @NuevoValor				money,
    @ArtImporte    			money,
    @SumaImporte			money, 
    @SumaImpuestos			money,
    @SumaDepreciacion			money,
    @ImporteTotal			money,
    @FechaCancelacion			datetime,
    @AdquisicionFecha			datetime,
    @AdquisicionValor			money,
    @AdquisicionPeridodo 		int,  
    @AdquisicionEjercicio 		int,
    @AdquisicionIndice			float,
    @DepreciacionInicio 		datetime,  
    @DepreciacionPeridodo 		int,  
    @DepreciacionEjercicio 		int,
    @DepreciacionIndice			float,
    @DepreciacionUltima			datetime,
    @DepreciacionUltimaPeridodo 	int,  
    @DepreciacionUltimaEjercicio 	int,
    @DepreciacionUltimaIndice		float,
    @FechaEmisionIndice			float,
    @RevaluacionUltima			datetime,
    @RevaluacionPeridodo 		int,  
    @RevaluacionEjercicio 		int,
    @RevaluacionIndice			float,
    @Revaluacion			money,
    @ValorRevaluado			money,
    @DepreciacionAcum			money,
    @ActualizacionCapital		money, 
    @ActualizacionGastos		money, 
    @ActualizacionDepreciacion		money,
    @Depreciacion			money,
    @DepreciacionPorcentaje		float,
    @MesesDepreciados			int,
    @Dias				int,
    @MesesDepreciado			int,
    @ValorAnterior			money,
    @ValorActual			money,
    @ValorDesecho			money,
    @DepreciacionAnterior		datetime,
    @RevaluacionAnterior		datetime,
    @ReparacionAnterior			datetime,
    @MantenimientoAnterior		datetime,
    @MantenimientoSiguiente		datetime,
    @MantenimientoSiguienteAnt		datetime,
    @MantenimientoPeriodicidad 		varchar(20),
    @PolizaMantenimientoAnterior 	datetime,
    @PolizaSeguroAnterior		datetime,
    @EsDevolucion			bit,

    @DepreciacionFecha			datetime,
    @DepreciacionMeses			int,
    @DepreciacionAnual			float,
    @VidaUtil				int,
    @Inflacion				float,
    @Factor				float,
    @IDActivoF				int,
    @IDAnterior				int, 
    @Categoria				varchar(50),
    @CategoriaVidaUtil			int,
    @CategoriaDepreciacionAnualAjustada	bit,
    @CategoriaMetodoDepreciacion	varchar(50),
    @SumaDigitos			float,
    
    -- 11042
    @MovTipoGenerarGasto	bit,
	@AFMovGenerarGastoCfg	varchar(20)
    
    
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMovID	        = NULL,
         @GenerarMovTipo        = NULL,
         @GenerarEstatus 	= 'SINAFECTAR'

  -- 11042
  SELECT @MovTipoGenerarGasto	= ISNULL(GenerarGasto, 0),
		 @AFMovGenerarGastoCfg	= AFMovGenerarGastoCfg
    FROM MovTipo
   WHERE Modulo = @Modulo 
     AND Mov	= @Mov		 

  -- Calcular la Fecha de Vencimiento
  IF @MovTipo IN ('AF.PM', 'AF.PS')
    EXEC spCalcularVencimiento 'CXP', @Empresa, @Proveedor, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT 

  -- Asignar el Consecutivo al Movimiento
  EXEC spMovConsecutivo @Sucursal, @SucursalOrigen, @SucursalDestino, @Empresa, @Usuario, @Modulo, @Ejercicio, @Periodo, @ID, @Mov, NULL, @Estatus, @Concepto, @Accion, @Conexion, @SincroFinal, @MovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

  IF @Estatus IN ('SINAFECTAR', 'BORRADOR', 'CONFIRMAR') AND @Accion <> 'CANCELAR' AND @Ok IS NULL
    EXEC spMovChecarConsecutivo	@Empresa, @Modulo, @Mov, @MovID, NULL, @Ejercicio, @Periodo, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion IN ('CONSECUTIVO', 'SINCRO') AND @Ok IS NULL
  BEGIN
    IF @Accion = 'SINCRO' EXEC spAsignarSucursalEstatus @ID, @Modulo, @SucursalDestino, @Accion
    SELECT @Ok = 80060, @OkRef = @MovID
    RETURN
  END

  IF @Accion = 'AFECTAR' AND @Ok IS NULL
  BEGIN
	IF EXISTS(SELECT Articulo, Serie, COUNT(*) FROM ActivoFijoD WHERE ID = @ID GROUP BY Articulo, Serie HAVING COUNT(*) > 1)
	BEGIN
		SELECT TOP 1 'Artículo Duplicado: <BR>Art.:'+ Articulo+' Serie: '+Serie FROM ActivoFijoD WHERE ID = @ID GROUP BY Articulo, Serie HAVING COUNT(*) > 1
		SELECT @Ok = 10245
	END
  END

  IF @OK IS NOT NULL RETURN 

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
--      EXEC spActivoFijoCopiarDetalle @ID, @IDGenerar, @GenerarMovTipo, @Ok OUTPUT
 
    IF @Ok IS NULL SELECT @Ok = 80030
    RETURN
  END

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR'
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE ActivoFijoD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID
        
    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         NULL, @Proyecto, @MovMoneda, @MovTipoCambio,
                       	         @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @MovTipo IN ('AF.DP', 'AF.RV') AND @Todo = 1 AND @Estatus = 'SINAFECTAR' AND @Accion <> 'CANCELAR'
      EXEC spActivoFijoCopiarTodo @Sucursal, @Empresa, @ID, @MovTipo, @MovMoneda, @FechaEmision, @Ok OUTPUT, @SubClave = @SubClave, @SubClaveFiscal = @SubClaveFiscal

    IF @MovTipo = 'AF.RV' OR (@MovTipo IN ('AF.DP', 'AF.DT') AND @Revaluar = 1)
      EXEC spTablaAnual @CfgTabla, @Ejercicio, @Periodo, 1, @FechaEmisionIndice OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    IF @Accion = 'CANCELAR' 
    BEGIN
      SELECT @IDAnterior = NULL
      IF @MovTipo IN ('AF.DP', 'AF.DT')
        SELECT @IDAnterior = MIN(af.ID)
          FROM ActivoFijo af, ActivoFijoD d, ActivoFijoD da, MovTipo mt 
         WHERE af.Mov=mt.Mov 
           AND af.Empresa = @Empresa 
           AND mt.Modulo = 'AF'
           AND mt.clave IN ('AF.DP', 'AF.DT')
           AND af.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
           AND af.FechaRegistro > @FechaRegistroAnterior
           AND d.ID = af.ID 
           AND da.ID = @ID AND da.Articulo = d.Articulo AND da.Serie = d.Serie
      ELSE
        SELECT @IDAnterior = MIN(af.ID)
          FROM ActivoFijo af, ActivoFijoD d, ActivoFijoD da, MovTipo mt 
         WHERE af.Mov=mt.Mov 
           AND af.Empresa = @Empresa 
           AND mt.Modulo = 'AF'
           AND mt.clave = @MovTipo 
           AND af.Estatus NOT IN ('SINAFECTAR', 'CANCELADO') 
           AND af.FechaRegistro > @FechaRegistroAnterior
           AND d.ID = af.ID 
           AND da.ID = @ID AND da.Articulo = d.Articulo AND da.Serie = d.Serie

      IF @IDAnterior IS NOT NULL AND @MovTipo NOT IN ('AF.MA', 'AF.PM', 'AF.PS', 'AF.RE')
       SELECT @Ok = 60190, @OkRef = RTRIM(Mov)+' '+RTRIM(MovID) FROM ActivoFijo WHERE ID = @IDAnterior
    END 
    
    SELECT @SumaImporte      = 0.0, 
    	   @SumaImpuestos    = 0.0,
           @SumaDepreciacion = 0.0

    IF @SubClaveFiscal = 1
      DECLARE crActivoFijo CURSOR FOR
       SELECT NULLIF(RTRIM(d.Articulo), ''), NULLIF(RTRIM(d.Serie), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Impuestos, 0.0), ISNULL(d.Horas, 0.0),
              ISNULL(d.Depreciacion, 0.0), ISNULL(d.MesesDepreciados, 0), ISNULL(d.NuevoValor, 0.0), ISNULL(d.Inflacion, 0.0), ISNULL(d.ActualizacionCapital, 0.0), ISNULL(d.ActualizacionGastos, 0.0), ISNULL(d.ActualizacionDepreciacion, 0.0), 
              ISNULL(d.ValorAnterior, 0.0), d.DepreciacionAnterior, d.RevaluacionAnterior, d.ReparacionAnterior, d.MantenimientoAnterior, d.MantenimientoSiguienteAnterior, d.PolizaMantenimientoAnterior, d.PolizaSeguroAnterior,
	      NULLIF(RTRIM(af.Moneda), ''), af.AdquisicionFechaF, af.DepreciacionInicioF, ISNULL(af.AdquisicionValorF, 0.0), ISNULL(af.ValorRevaluadoF, 0.0), ISNULL(af.DepreciacionAcumF, 0.0), af.DepreciacionUltimaF, af.RevaluacionUltimaF, ISNULL(af.VidaUtilF, 0), ISNULL(af.DepreciacionAnualF, 0), ISNULL(af.DepreciacionMesesF, 0), NULLIF(RTRIM(af.MantenimientoPeriodicidad), ''), af.ID, af.Categoria, af.ValorDesechoF
         FROM ActivoFijoD d, Art a, ActivoF af
        WHERE d.ID = @ID 
          AND d.Articulo = a.Articulo
          AND d.Articulo = af.Articulo
          AND d.Serie    = af.Serie
          AND af.Empresa = @Empresa
    ELSE
    IF @SubClaveFiscal = 2
      DECLARE crActivoFijo CURSOR FOR
       SELECT NULLIF(RTRIM(d.Articulo), ''), NULLIF(RTRIM(d.Serie), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Impuestos, 0.0), ISNULL(d.Horas, 0.0),
              ISNULL(d.Depreciacion, 0.0), ISNULL(d.MesesDepreciados, 0), ISNULL(d.NuevoValor, 0.0), ISNULL(d.Inflacion, 0.0), ISNULL(d.ActualizacionCapital, 0.0), ISNULL(d.ActualizacionGastos, 0.0), ISNULL(d.ActualizacionDepreciacion, 0.0), 
              ISNULL(d.ValorAnterior, 0.0), d.DepreciacionAnterior, d.RevaluacionAnterior, d.ReparacionAnterior, d.MantenimientoAnterior, d.MantenimientoSiguienteAnterior, d.PolizaMantenimientoAnterior, d.PolizaSeguroAnterior,
	      NULLIF(RTRIM(af.Moneda), ''), af.AdquisicionFechaF2, af.DepreciacionInicioF2, ISNULL(af.AdquisicionValorF2, 0.0), ISNULL(af.ValorRevaluadoF2, 0.0), ISNULL(af.DepreciacionAcumF2, 0.0), af.DepreciacionUltimaF2, af.RevaluacionUltimaF2, ISNULL(af.VidaUtilF2, 0), ISNULL(af.DepreciacionAnualF2, 0), ISNULL(af.DepreciacionMesesF2, 0), NULLIF(RTRIM(af.MantenimientoPeriodicidad), ''), af.ID, af.Categoria, af.ValorDesechoF2
         FROM ActivoFijoD d, Art a, ActivoF af
        WHERE d.ID = @ID 
          AND d.Articulo = a.Articulo
          AND d.Articulo = af.Articulo
          AND d.Serie    = af.Serie
          AND af.Empresa = @Empresa
    ELSE
      DECLARE crActivoFijo CURSOR FOR
       SELECT NULLIF(RTRIM(d.Articulo), ''), NULLIF(RTRIM(d.Serie), ''), ISNULL(d.Importe, 0.0), ISNULL(d.Impuestos, 0.0), ISNULL(d.Horas, 0.0),
              ISNULL(d.Depreciacion, 0.0), ISNULL(d.MesesDepreciados, 0), ISNULL(d.NuevoValor, 0.0), ISNULL(d.Inflacion, 0.0), ISNULL(d.ActualizacionCapital, 0.0), ISNULL(d.ActualizacionGastos, 0.0), ISNULL(d.ActualizacionDepreciacion, 0.0), 
              ISNULL(d.ValorAnterior, 0.0), d.DepreciacionAnterior, d.RevaluacionAnterior, d.ReparacionAnterior, d.MantenimientoAnterior, d.MantenimientoSiguienteAnterior, d.PolizaMantenimientoAnterior, d.PolizaSeguroAnterior,
	      NULLIF(RTRIM(af.Moneda), ''), af.AdquisicionFecha, af.DepreciacionInicio, ISNULL(af.AdquisicionValor, 0.0), ISNULL(af.ValorRevaluado, 0.0), ISNULL(af.DepreciacionAcum, 0.0), af.DepreciacionUltima, af.RevaluacionUltima, ISNULL(af.VidaUtil, 0), ISNULL(af.DepreciacionAnual, 0), ISNULL(af.DepreciacionMeses, 0), NULLIF(RTRIM(af.MantenimientoPeriodicidad), ''), af.ID, af.Categoria, af.ValorDesecho
         FROM ActivoFijoD d, Art a, ActivoF af
        WHERE d.ID = @ID 
          AND d.Articulo = a.Articulo
          AND d.Articulo = af.Articulo
          AND d.Serie    = af.Serie
          AND af.Empresa = @Empresa

    OPEN crActivoFijo
    FETCH NEXT 
          FROM crActivoFijo 
          INTO @Articulo, @Serie, @Importe, @Impuestos, @Horas,
               @Depreciacion, @MesesDepreciados, @NuevoValor, @Inflacion, @ActualizacionCapital, @ActualizacionGastos, @ActualizacionDepreciacion,
	       @ValorAnterior, @DepreciacionAnterior, @RevaluacionAnterior, @ReparacionAnterior, @MantenimientoAnterior, @MantenimientoSiguienteAnt, @PolizaMantenimientoAnterior, @PolizaSeguroAnterior,
               @ArtMoneda, @AdquisicionFecha, @DepreciacionInicio, @AdquisicionValor, @ValorRevaluado, @DepreciacionAcum, @DepreciacionUltima, @RevaluacionUltima, @VidaUtil, @DepreciacionAnual, @DepreciacionMeses, @MantenimientoPeriodicidad, @IDActivoF, @Categoria, @ValorDesecho
    IF @@ERROR <> 0 SELECT @Ok = 1
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @MovTipo NOT IN ('AF.A', 'AF.D') AND @Articulo IS NOT NULL AND @Serie IS NOT NULL AND @Ok IS NULL
      BEGIN
      	IF @SubClaveFiscal = 1
          SELECT @CategoriaMetodoDepreciacion = UPPER(MetodoDepreciacionF), @CategoriaVidaUtil = VidaUtilF, @CategoriaDepreciacionAnualAjustada = ISNULL(DepreciacionAnualAjustadaF, 0) FROM ActivoFCat WHERE Categoria = @Categoria
      	ELSE
      	IF @SubClaveFiscal = 2
          SELECT @CategoriaMetodoDepreciacion = UPPER(MetodoDepreciacionF2), @CategoriaVidaUtil = VidaUtilF2, @CategoriaDepreciacionAnualAjustada = ISNULL(DepreciacionAnualAjustadaF2, 0) FROM ActivoFCat WHERE Categoria = @Categoria
      	ELSE
          SELECT @CategoriaMetodoDepreciacion = UPPER(MetodoDepreciacion), @CategoriaVidaUtil = VidaUtil, @CategoriaDepreciacionAnualAjustada = ISNULL(DepreciacionAnualAjustada, 0) FROM ActivoFCat WHERE Categoria = @Categoria
          
        EXEC spMoneda NULL, @MovMoneda, @MovTipoCambio, @ArtMoneda, @ArtFactor OUTPUT, @ArtTipoCambio OUTPUT, @Ok OUTPUT
        SELECT @ArtImporte = @Importe / @ArtFactor
        IF @ValorRevaluado > 0 SELECT @ValorActual = @ValorRevaluado ELSE SELECT @ValorActual = @AdquisicionValor
        SELECT @ValorActual = @ValorActual - ISNULL(@ValorDesecho, 0.0)

	IF @Accion <> 'CANCELAR' 
        BEGIN
          IF @MovTipo = 'AF.RV' AND @RevaluacionUltima >= @FechaEmision SELECT @Ok = 44120
          
          IF @MovTipo = 'AF.RV' OR (@MovTipo IN ('AF.DP', 'AF.DT') AND @Revaluar = 1)
          BEGIN
            IF @SubClaveFiscal = 1
              SELECT @ValorAnterior = ValorRevaluadoF, @RevaluacionAnterior = RevaluacionUltimaF FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
            ELSE
            IF @SubClaveFiscal = 2
              SELECT @ValorAnterior = ValorRevaluadoF2, @RevaluacionAnterior = RevaluacionUltimaF2 FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
            ELSE
              SELECT @ValorAnterior = ValorRevaluado, @RevaluacionAnterior = RevaluacionUltima FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
          END
          IF @MovTipo IN ('AF.DP', 'AF.DT') 
          BEGIN
            IF @SubClaveFiscal = 1
              SELECT @DepreciacionAnterior = DepreciacionUltimaF FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie 	
            ELSE
            IF @SubClaveFiscal = 2
              SELECT @DepreciacionAnterior = DepreciacionUltimaF2 FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie 	
            ELSE
              SELECT @DepreciacionAnterior = DepreciacionUltima FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie 	
          END

          IF @MovTipo = 'AF.RE' SELECT @ReparacionAnterior = ReparacionUltima FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE
          IF @MovTipo = 'AF.MA' SELECT @MantenimientoAnterior = MantenimientoUltimo, @MantenimientoSiguienteAnt = MantenimientoSiguiente FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE
          IF @MovTipo = 'AF.PM' SELECT @PolizaMantenimientoAnterior = MantenimientoVence FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE
          IF @MovTipo = 'AF.PS' SELECT @PolizaSeguroAnterior = SeguroVence FROM ActivoF WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie 

 	  IF @MovTipo IN ('AF.DP', 'AF.DT', 'AF.RV')
          BEGIN
            SELECT @DepreciacionFecha = @FechaEmision 
            IF @MovTipo IN ('AF.DP', 'AF.DT')
            BEGIN
              IF @MovTipo = 'AF.DT'
                SELECT @MesesDepreciados = @VidaUtil - @DepreciacionMeses
              ELSE
                SELECT @MesesDepreciados = DATEDIFF(month, ISNULL(@DepreciacionUltima, DATEADD(month, -1, @DepreciacionInicio)), @FechaEmision)
              IF @MesesDepreciados < 0 SELECT @MesesDepreciados = 0
              IF @MesesDepreciados > (@VidaUtil - @DepreciacionMeses)
              BEGIN
	        SELECT @DepreciacionFecha = DATEADD(month, @VidaUtil - @DepreciacionMeses - @MesesDepreciados, @FechaEmision)
                SELECT @MesesDepreciados = (@VidaUtil - @DepreciacionMeses) 
              END
              IF @MesesDepreciados < 0 AND @MovTipo <> 'AF.RV' SELECT @Ok = 44100
            END ELSE
            IF @MovTipo = 'AF.RV'
            BEGIN           
              SELECT @MesesDepreciados = DATEDIFF(month, ISNULL(@RevaluacionUltima, DATEADD(month, -1, @DepreciacionInicio)), @FechaEmision) 
              IF @MesesDepreciados < 0 SELECT @MesesDepreciados = 0
            END
            EXEC spPeriodoEjercicio @Empresa, @Modulo, @DepreciacionFecha, @DepreciacionPeridodo OUTPUT, @DepreciacionEjercicio OUTPUT, @Ok OUTPUT
            IF @MovTipo = 'AF.RV' OR (@MovTipo IN ('AF.DP', 'AF.DT') AND @Revaluar = 1)
              EXEC spTablaAnual @CfgTabla, @DepreciacionEjercicio, @DepreciacionPeridodo, 1, @DepreciacionIndice OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            SELECT @DepreciacionPorcentaje = NULL, @Depreciacion = NULL

            -- Calcular Depreciacion
            IF /*@MovTipo IN ('AF.DP', 'AF.DT') AND */@MesesDepreciados > 0
            BEGIN
              IF @CategoriaMetodoDepreciacion = 'SUMA DIGITOS'
              BEGIN
                SELECT @SumaDigitos = dbo.fnSumaDigitos(@CategoriaVidaUtil)
                SELECT @DepreciacionPorcentaje = 0.0, @a = 0
                WHILE @a<@MesesDepreciados
                BEGIN
                  SELECT @DepreciacionPorcentaje = @DepreciacionPorcentaje + (((@VidaUtil - @DepreciacionMeses - @a) / @SumaDigitos)* 100.0)
                  SELECT @a = @a + 1
                END
              END ELSE 
              BEGIN
                IF @DepreciacionAnual = 0.0 --OR (@MesesDepreciados = @VidaUtil)
                  SELECT @DepreciacionPorcentaje = 100.0 / @VidaUtil 
                ELSE BEGIN
                  IF @CategoriaDepreciacionAnualAjustada = 1 
                    SELECT @DepreciacionPorcentaje = 100.0 / @DepreciacionAnual
                  ELSE SELECT @DepreciacionPorcentaje = @DepreciacionAnual / 12.0

                  IF ((@Depreciacion + @DepreciacionAcum) >= @AdquisicionValor) OR ABS((@Depreciacion + @DepreciacionAcum) - @AdquisicionValor) < 1.0
                  BEGIN
                    SELECT @Depreciacion = @AdquisicionValor - @DepreciacionAcum
                    SELECT @DepreciacionPorcentaje = (@AdquisicionValor - @DepreciacionAcum) / (@AdquisicionValor /100.0)                     
                  END
                END
              END
              IF @CategoriaMetodoDepreciacion = 'SUMA DIGITOS'
                SELECT @Depreciacion = @AdquisicionValor * (@DepreciacionPorcentaje / 100.0) -- * @MesesDepreciados
              ELSE
                SELECT @Depreciacion = @AdquisicionValor * (@DepreciacionPorcentaje / 100.0) * @MesesDepreciados
            END

  	    -- Calcular Revaluacion
            IF (@MesesDepreciados > 0 OR @MovTipo = 'AF.RV') AND ((@MovTipo = 'AF.RV' AND (@Todo = 1 OR @ValorMercado = 0)) OR (@MovTipo IN ('AF.DP', 'AF.DT') AND @Revaluar = 1))
            BEGIN
              EXEC spPeriodoEjercicio @Empresa, @Modulo, @AdquisicionFecha, @AdquisicionPeridodo OUTPUT, @AdquisicionEjercicio OUTPUT, @Ok OUTPUT
              EXEC spTablaAnual @CfgTabla, @AdquisicionEjercicio, @AdquisicionPeridodo, 1, @AdquisicionIndice OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              IF @Ok IS NULL
              BEGIN
                SELECT @Factor = @FechaEmisionIndice / @AdquisicionIndice
                SELECT @NuevoValor = @AdquisicionValor * @Factor
                SELECT @Revaluacion = @NuevoValor - @ValorActual
        
                IF @MovTipo IN ('AF.RV', 'AF.DP', 'AF.DT')
                BEGIN
		  IF @RevaluacionUltima IS NOT NULL
		  BEGIN
                    EXEC spPeriodoEjercicio @Empresa, @Modulo, @RevaluacionUltima, @RevaluacionPeridodo OUTPUT, @RevaluacionEjercicio OUTPUT, @Ok OUTPUT
                    EXEC spTablaAnual @CfgTabla, @RevaluacionEjercicio, @RevaluacionPeridodo, 1, @RevaluacionIndice OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
                    SELECT @Inflacion = ((@FechaEmisionIndice / @RevaluacionIndice) - 1) * 100.0
                  END ELSE
                    SELECT @Inflacion = ((@FechaEmisionIndice / @AdquisicionIndice) - 1) * 100.0

                  IF @MesesDepreciados > 0
       	            SELECT @ActualizacionDepreciacion = (@Depreciacion/@MesesDepreciados) * (@Inflacion / 100.0)
                  ELSE
                    SELECT @ActualizacionDepreciacion = 0.0
     	          SELECT @ActualizacionCapital = @Revaluacion /*- @ActualizacionDepreciacion*/
--                  SELECT @ActualizacionGastos = ((@NuevoValor / @VidaUtil) * (@DepreciacionMeses + @MesesDepreciados)) - @Depreciacion - @DepreciacionAcum - @ActualizacionDepreciacion
                  SELECT @ActualizacionGastos = 0.0
                END
              END
            END 
	  END
        END

        IF @Ok IS NULL 
        BEGIN
          IF @MovTipo IN ('AF.DP', 'AF.DT', 'AF.RV')
          BEGIN
            IF @MovTipo IN ('AF.DP', 'AF.DT') AND @MesesDepreciados > 0
            BEGIN
              IF @SubClaveFiscal = 1
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET DepreciacionMesesF = ISNULL(DepreciacionMesesF, 0) + @MesesDepreciados, DepreciacionUltimaF = @DepreciacionFecha,    DepreciacionAcumF = ISNULL(DepreciacionAcumF, 0.0) + @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET DepreciacionMesesF = ISNULL(DepreciacionMesesF, 0) - @MesesDepreciados, DepreciacionUltimaF = @DepreciacionAnterior, DepreciacionAcumF = ISNULL(DepreciacionAcumF, 0.0) - @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie             	
              END ELSE
              IF @SubClaveFiscal = 2
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET DepreciacionMesesF2 = ISNULL(DepreciacionMesesF2, 0) + @MesesDepreciados, DepreciacionUltimaF2 = @DepreciacionFecha,    DepreciacionAcumF2 = ISNULL(DepreciacionAcumF2, 0.0) + @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET DepreciacionMesesF2 = ISNULL(DepreciacionMesesF2, 0) - @MesesDepreciados, DepreciacionUltimaF2 = @DepreciacionAnterior, DepreciacionAcumF2 = ISNULL(DepreciacionAcumF2, 0.0) - @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie             	            	
              END ELSE
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET DepreciacionMeses = ISNULL(DepreciacionMeses, 0) + @MesesDepreciados, DepreciacionUltima = @DepreciacionFecha,    DepreciacionAcum = ISNULL(DepreciacionAcum, 0.0) + @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET DepreciacionMeses = ISNULL(DepreciacionMeses, 0) - @MesesDepreciados, DepreciacionUltima = @DepreciacionAnterior, DepreciacionAcum = ISNULL(DepreciacionAcum, 0.0) - @Depreciacion WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie 
              END
            END 
            IF @MovTipo = 'AF.RV' OR (@MovTipo IN ('AF.DP', 'AF.DT') AND @Revaluar = 1 AND @MesesDepreciados > 0)
            BEGIN
              IF @SubClaveFiscal = 1
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET RevaluacionUltimaF = @DepreciacionFecha,   ValorRevaluadoF = @NuevoValor    WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET RevaluacionUltimaF = @RevaluacionAnterior, ValorRevaluadoF = @ValorAnterior WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
              END ELSE
              IF @SubClaveFiscal = 2
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET RevaluacionUltimaF2 = @DepreciacionFecha,   ValorRevaluadoF2 = @NuevoValor    WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET RevaluacionUltimaF2 = @RevaluacionAnterior, ValorRevaluadoF2 = @ValorAnterior WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
              END ELSE
              BEGIN
                IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET RevaluacionUltima = @DepreciacionFecha,   ValorRevaluado = @NuevoValor    WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
                IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET RevaluacionUltima = @RevaluacionAnterior, ValorRevaluado = @ValorAnterior WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
              END
            END
          END ELSE
	  IF @MovTipo = 'AF.RE'
          BEGIN
            IF @EstatusNuevo = 'PENDIENTE' UPDATE ActivoF SET Estatus = 'REPARACION' WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET Estatus = 'ACTIVO', ReparacionUltima = @FechaEmision,       ReparacionAcum = ISNULL(ReparacionAcum, 0.0) + @ArtImporte, Reparaciones = ISNULL(Reparaciones, 0) + 1, ReparacionHoras = ISNULL(ReparacionHoras, 0.0) + @Horas WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET Estatus = 'ACTIVO', ReparacionUltima = @ReparacionAnterior, ReparacionAcum = ISNULL(ReparacionAcum, 0.0) - @ArtImporte, Reparaciones = ISNULL(Reparaciones, 0) - 1, ReparacionHoras = ISNULL(ReparacionHoras, 0.0) - @Horas WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
          END ELSE
	  IF @MovTipo = 'AF.MA'
          BEGIN
	    IF @Accion <> 'CANCELAR' 
	      EXEC spCalcularPeriodicidad @FechaEmision, @MantenimientoPeriodicidad, @MantenimientoSiguiente OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

            IF @EstatusNuevo = 'PENDIENTE' UPDATE ActivoF SET Estatus = 'MANTENIMIENTO', MantenimientoSiguiente = @MantenimientoSiguiente                                           	     								                                                                                                                    WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CONCLUIDO' UPDATE ActivoF SET Estatus = 'ACTIVO',        MantenimientoSiguiente = @MantenimientoSiguiente, MantenimientoUltimo = @FechaEmision, 	    MantenimientoAcum = ISNULL(MantenimientoAcum, 0.0) + @ArtImporte, Mantenimientos = ISNULL(Mantenimientos, 0) + 1, MantenimientoHoras = ISNULL(MantenimientoHoras, 0.0) + @Horas WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET Estatus = 'ACTIVO',  	 MantenimientoUltimo = @MantenimientoAnterior, MantenimientoSiguiente = @MantenimientoSiguienteAnt, MantenimientoAcum = ISNULL(MantenimientoAcum, 0.0) - @ArtImporte, Mantenimientos = ISNULL(Mantenimientos, 0) - 1, MantenimientoHoras = ISNULL(MantenimientoHoras, 0.0) - @Horas WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
          END ELSE
	  IF @MovTipo = 'AF.PM'
          BEGIN
            IF @EstatusNuevo = 'VIGENTE'   UPDATE ActivoF SET MantenimientoVence = @Vencimiento,        	 MantenimientoAcum = ISNULL(MantenimientoAcum, 0.0) + @ArtImporte WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET MantenimientoVence = @PolizaMantenimientoAnterior, MantenimientoAcum = ISNULL(MantenimientoAcum, 0.0) - @ArtImporte WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
          END ELSE
  	  IF @MovTipo = 'AF.PS'
          BEGIN
            IF @EstatusNuevo = 'VIGENTE'   UPDATE ActivoF SET SeguroVence = @Vencimiento, 	   SeguroAcum = ISNULL(SeguroAcum, 0.0) + @ArtImporte WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie ELSE 
            IF @EstatusNuevo = 'CANCELADO' UPDATE ActivoF SET SeguroVence = @PolizaSeguroAnterior, SeguroAcum = ISNULL(SeguroAcum, 0.0) - @ArtImporte WHERE Empresa = @Empresa AND Articulo = @Articulo AND Serie = @Serie
          END 

          EXEC spSerieLoteFlujo @Sucursal, @Sucursal, @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Articulo, NULL, @Serie, NULL, 0

          SELECT @SumaImporte      = @SumaImporte      + ISNULL(@Importe, 0),
	         @SumaImpuestos    = @SumaImpuestos    + ISNULL(@Impuestos, 0),
                 @SumaDepreciacion = @SumaDepreciacion + ISNULL(@Depreciacion, 0)

          IF @Accion <> 'CANCELAR' 
          BEGIN
            UPDATE ActivoFijoD 
               SET NuevoValor			  = @NuevoValor,
                   Depreciacion			  = @Depreciacion,
		   DepreciacionPorcentaje	  = @DepreciacionPorcentaje,
		   Inflacion			  = @Inflacion,
		   MesesDepreciados		  = @MesesDepreciados, 
		   ActualizacionDepreciacion	  = @ActualizacionDepreciacion,
		   ActualizacionCapital		  = @ActualizacionCapital,
		   ActualizacionGastos		  = @ActualizacionGastos,
                   ValorAnterior		  = @ValorAnterior,
	    	   DepreciacionAnterior		  = @DepreciacionAnterior,
		   RevaluacionAnterior		  = @RevaluacionAnterior,
		   ReparacionAnterior		  = @ReparacionAnterior,
		   MantenimientoSiguienteAnterior = @MantenimientoSiguienteAnt,
		   MantenimientoAnterior	  = @MantenimientoAnterior,
		   PolizaMantenimientoAnterior	  = @PolizaMantenimientoAnterior,
		   PolizaSeguroAnterior		  = @PolizaSeguroAnterior
             WHERE CURRENT OF crActivoFijo
          END
	END
      END

      IF @@FETCH_STATUS <> -2 AND @MovTipo IN ('AF.A', 'AF.D') AND @Ok IS NULL
      BEGIN                
        IF (@MovTipo = 'AF.A' AND @Accion = 'AFECTAR') OR (@MovTipo = 'AF.D' AND @Accion = 'CANCELAR')
          SELECT @EsDevolucion = 0
        ELSE
          SELECT @EsDevolucion = 1

        IF @Personal IS NOT NULL UPDATE ActivoF SET Responsable  = CASE WHEN @EsDevolucion = 0 THEN @Personal ELSE NULL END WHERE ID = @IDActivoF
        IF @Espacio  IS NOT NULL UPDATE ActivoF SET Espacio      = CASE WHEN @EsDevolucion = 0 THEN @Espacio  ELSE NULL END WHERE ID = @IDActivoF
        IF @ContUso  IS NOT NULL UPDATE ActivoF SET CentroCostos = CASE WHEN @EsDevolucion = 0 THEN @ContUso  ELSE NULL END WHERE ID = @IDActivoF
        
        -- 9036
        IF @ContUso2  IS NOT NULL UPDATE ActivoF SET ContUso2 = CASE WHEN @EsDevolucion = 0 THEN @ContUso2  ELSE NULL END WHERE ID = @IDActivoF
        IF @ContUso3  IS NOT NULL UPDATE ActivoF SET ContUso3 = CASE WHEN @EsDevolucion = 0 THEN @ContUso3  ELSE NULL END WHERE ID = @IDActivoF                
      END

      IF @Ok IS NOT NULL AND @OkRef IS NULL 
        SELECT @OkRef = RTRIM(@Articulo)+' - '+RTRIM(@Serie)
      FETCH NEXT 
            FROM crActivoFijo 
            INTO @Articulo, @Serie, @Importe, @Impuestos, @Horas,
                 @Depreciacion, @MesesDepreciados, @NuevoValor, @Inflacion, @ActualizacionCapital, @ActualizacionGastos, @ActualizacionDepreciacion,
	         @ValorAnterior, @DepreciacionAnterior, @RevaluacionAnterior, @ReparacionAnterior, @MantenimientoAnterior, @MantenimientoSiguienteAnt, @PolizaMantenimientoAnterior, @PolizaSeguroAnterior,
                 @ArtMoneda, @AdquisicionFecha, @DepreciacionInicio, @AdquisicionValor, @ValorRevaluado, @DepreciacionAcum, @DepreciacionUltima, @RevaluacionUltima, @VidaUtil, @DepreciacionAnual, @DepreciacionMeses, @MantenimientoPeriodicidad, @IDActivoF, @Categoria, @ValorDesecho
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crActivoFijo
    DEALLOCATE crActivoFijo

    SELECT @ImporteTotal = @SumaImporte + @SumaImpuestos
    -- Actualizar Movimiento
    IF @Ok IS NULL
    BEGIN
      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @EstatusNuevo = 'CONCLUIDO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus = 'CONCLUIDO' AND @EstatusNuevo = 'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE ActivoFijo
         SET Importe	      = NULLIF(@SumaImporte, 0.0),
	     Impuestos        = NULLIF(@SumaImpuestos, 0.0),
             FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion, 
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
	     Vencimiento      = @Vencimiento,
             Estatus          = @EstatusNuevo,
             Situacion 	      = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1
    END

    -- 11042
    --IF @MovTipoGenerarGasto = 1 AND @AFGenerarGasto = 1 AND ((@MovTipo IN ('AF.DP', 'AF.DT') AND @SumaDepreciacion > 0.0) OR (@MovTipo IN ('AF.A', 'AF.D', 'AF.MA', 'AF.PM', 'AF.PS', 'AF.RV', 'AF.RE') AND @ImporteTotal > 0.0)) AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO', 'VIGENTE') AND @Ok IS NULL
    IF @AFGenerarGasto = 1 AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO', 'VIGENTE') AND @Ok IS NULL
    BEGIN
      IF (@AFGenerarGastoCfg = 'Empresa' AND @MovTipo IN ('AF.DP', 'AF.DT') AND @SumaDepreciacion > 0.0) OR(@AFGenerarGastoCfg = 'Movimiento' AND @MovTipoGenerarGasto = 1 AND @MovTipo IN ('AF.DP', 'AF.DT') AND @SumaDepreciacion > 0.0)
        EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo, @MovTipoGenerarGasto = @MovTipoGenerarGasto
      ELSE IF @AFGenerarGastoCfg = 'Movimiento' AND @MovTipoGenerarGasto = 1 AND @MovTipo IN ('AF.RE', 'AF.MA', 'AF.PM', 'AF.PS', 'AF.RV') AND @ImporteTotal > 0.0
        EXEC spGenerarGasto @Accion, @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT, @MovTipo = @MovTipo, @MovTipoGenerarGasto = @MovTipoGenerarGasto
    END
    
    IF @CfgAfectarDinero = 1 AND @MovTipo IN ('AF.RE', 'AF.MA', 'AF.PS', 'AF.PM') AND @EstatusNuevo IN ('CONCLUIDO', 'CANCELADO', 'VIGENTE') AND @ImporteTotal > 0.0
      EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaAfectacion, NULL, @Proyecto, @Usuario, @Autorizacion, NULL, @DocFuente, @Observaciones, 0, 0,
                           @FechaRegistro, @Ejercicio, @Periodo, 
                           @FormaPago, NULL, NULL,
                           @Proveedor, @CtaDinero, NULL, @ImporteTotal, NULL,
			   NULL, NULL, NULL,
                           @DineroMov OUTPUT, @DineroMovID OUTPUT,
                           @Ok OUTPUT, @OkRef OUTPUT
 
  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT 


--IF @Ok IS NULL SELECT @Ok = 1 -- breakpoint
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

/**************** spActivoFijo ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijo') and type = 'P') drop procedure dbo.spActivoFijo
GO
CREATE PROCEDURE spActivoFijo
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
    @Sucursal			int,
    @SucursalDestino		int,
    @SucursalOrigen		int,
    @EnLinea			bit,
    @PuedeEditar		bit,
    @Empresa	      		char(5),
    @MovTipo   			char(20),
    @SubClave			varchar(20),
    @SubClaveFiscal		int,
    @MovMoneda	      		char(10),
    @MovTipoCambio	   	float,
    @FechaEmision     		datetime,
    @FechaAfectacion		datetime,
    @FechaConclusion		datetime,
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @FechaRegistroAnterior	datetime,
    @Ejercicio	      		int,
    @Periodo	      		int,
    @Condicion			varchar(50),
    @Vencimiento		datetime,
    @Todo			bit,
    @Revaluar			bit,
    @ValorMercado		bit,
    @Proveedor			char(10),
    @Personal			char(10),
    @Espacio			char(10),
    @ContUso			varchar(20),
    
    -- 9036
    @ContUso2			varchar(20),
    @ContUso3			varchar(20),
    
    @FormaPago			varchar(50),
    @Concepto			varchar(50),
    @CtaDinero			char(10),
    @GenerarMovID		varchar(20),
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgMantenimientoPendiente 	bit,
    @CfgAfectarDinero		bit,
    -- 11042
    @CfgTabla			varchar(50),/*,
    @Verificar			bit*/
    @AFGenerarGasto		bit,
    @AFGenerarGastoCfg	varchar(20)

  -- Inicializar Variables
  SELECT @CfgMantenimientoPendiente = 0,
	 @CfgContX         	    = 0,
         @CfgContXGenerar  	    = 'NO',
         @CfgAfectarDinero	    = 0,
         @CfgTabla		    = NULL/*,
	 @Verificar		    = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = Proyecto,
	 @MovMoneda = Moneda, @MovTipoCambio = TipoCambio, @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus),
	 @Condicion = Condicion, @Vencimiento = Vencimiento, @Todo = Todo, @Revaluar = Revaluar, @ValorMercado = ValorMercado,
         @Proveedor = Proveedor, @FormaPago = FormaPago, @CtaDinero = CtaDinero, 
         @GenerarPoliza = GenerarPoliza, @FechaRegistroAnterior = FechaRegistro, @FechaConclusion = FechaConclusion,
         @Personal = NULLIF(RTRIM(Personal), ''), @Espacio = NULLIF(RTRIM(Espacio), ''), @ContUso = NULLIF(RTRIM(ContUso), ''),
         -- 9036
         @ContUso2 = NULLIF(RTRIM(ContUso2), ''), @ContUso3 = NULLIF(RTRIM(ContUso3), ''),
         @Concepto = Concepto
    FROM ActivoFijo
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario

  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('VERIFICAR', 'AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT, @SubClave = @SubClave OUTPUT
  SELECT @SubClaveFiscal = dbo.fnSubClaveFiscal(@SubClave)
  
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
     (@Accion = 'CANCELAR'  AND @Estatus IN ('CONCLUIDO', 'PENDIENTE', 'VIGENTE'))
  BEGIN
    -- 11042
    SELECT @CfgMantenimientoPendiente = AFMantenimientoPendiente,
           --@CfgAfectarDinero          = FAfectarDinero,
           @CfgTabla 		      = NULLIF(RTRIM(ContTablaINPC), ''),
           @AFGenerarGasto		 = ISNULL(AFGenerarGasto, 0),
		   @AFGenerarGastoCfg	 = AFGenerarGastoCfg
      FROM EmpresaCfg
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
  
    IF @Accion = 'CANCELAR'
      SELECT @EstatusNuevo = 'CANCELADO'
    ELSE BEGIN
      IF @MovTipo IN ('AF.RE', 'AF.MA') AND @CfgMantenimientoPendiente = 1
      BEGIN
        IF @Estatus = 'SINAFECTAR' SELECT @EstatusNuevo = 'PENDIENTE'
        IF @Estatus = 'PENDIENTE'  SELECT @EstatusNuevo = 'CONCLUIDO'
      END ELSE 
      IF @MovTipo IN ('AF.PM', 'AF.PS') 
         SELECT @EstatusNuevo = 'VIGENTE' 
      ELSE SELECT @EstatusNuevo = 'CONCLUIDO'
    END

    -- Verificar antes de Afectar
    IF (@Conexion = 0 OR @Accion = 'CANCELAR') AND @Accion NOT IN ('GENERAR', 'CONSECUTIVO'/*, 'SINCRO'*/) AND @Ok IS NULL
    BEGIN
      -- 9036
      -- 9150
      EXEC spActivoFijoVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @FechaEmision, 
                                 @Condicion, @Vencimiento, @Estatus, @EstatusNuevo, @Ejercicio, @Periodo,
				 @Personal, @Espacio, @ContUso, @ContUso2, @ContUso3, @Todo, @Revaluar, @ValorMercado, 
				 @CfgTabla,
            			 @Conexion, @SincroFinal, @Sucursal, @FormaPago, @Ok OUTPUT, @OkRef OUTPUT, @SubClave = @SubClave, @SubClaveFiscal = @SubClaveFiscal

      -- Quitar los mensajes cuando la afectarcion es normal 
      IF @Ok BETWEEN 80000 AND 89999 AND @Accion IN ('AFECTAR', 'CANCELAR') SELECT @Ok = NULL ELSE

      -- Si Verifico y todo estubo bien
      IF @Accion = 'VERIFICAR' AND @Ok IS NULL
      BEGIN
        SELECT @Ok = 80000
        EXEC xpOk_80000 @Empresa, @Usuario, @Accion, @Modulo, @ID, @Ok OUTPUT, @OkRef OUTPUT
      END
    END
    
    -- 9036
    -- 11042
    IF @Accion IN ('AFECTAR', 'GENERAR', 'CANCELAR','CONSECUTIVO','SINCRO') AND @Ok IS NULL
      EXEC spActivoFijoAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaEmision, @FechaAfectacion, @FechaConclusion, @Condicion, @Vencimiento, 
			     @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto,
                             @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
    			     @Proveedor, @Personal, @Espacio, @ContUso, @ContUso2, @ContUso3, @FormaPago, @CtaDinero,
    			     @Todo, @Revaluar, @ValorMercado, @FechaRegistroAnterior,
		             @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,
			     @CfgTabla, @CfgAfectarDinero, @CfgContX, @CfgContXGenerar, @GenerarPoliza, 
                             @GenerarMov, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
                             @AFGenerarGasto, @AFGenerarGastoCfg,
                             @Ok OUTPUT, @OkRef OUTPUT, @SubClave = @SubClave, @SubClaveFiscal = @SubClaveFiscal

  END ELSE 
  BEGIN
    IF @Estatus = 'SINAFECTAR' AND @Accion = 'CANCELAR' EXEC spMovCancelarSinAfectar @Modulo, @ID, @Ok OUTPUT ELSE
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

  -- Si hay Mensaje pero no tiene referencia
  IF @Ok IS NOT NULL AND @OkRef IS NULL 

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

-- 9036
/**************** spActivoFijoSugerirCategorias ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoSugerirCategorias') and type = 'P') drop procedure dbo.spActivoFijoSugerirCategorias
GO
CREATE PROCEDURE spActivoFijoSugerirCategorias
			@EstacionTrabajo		int
--//WITH ENCRYPTION
AS BEGIN			
  DELETE ActivoFijoSugerir WHERE Estacion = @EstacionTrabajo
  
  INSERT INTO ActivoFijoSugerir(Estacion, Categoria) SELECT @EstacionTrabajo, Categoria FROM ActivoFCat ORDER BY Categoria
  RETURN
END
GO

/**************** spActivoFijoCopiarCategoria ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoCopiarCategoria') and type = 'P') drop procedure dbo.spActivoFijoCopiarCategoria
GO             
CREATE PROC spActivoFijoCopiarCategoria
			@Sucursal		int,
 			@Empresa		char(5),
    		@ID  			int,
			@MovTipo		char(20),
			@MovMoneda		char(10),
			@FechaEmision	datetime,
    		@Categoria		varchar(50),			
			@Ok				int			OUTPUT,
    		@SubClave		varchar(20) = NULL,
    		@SubClaveFiscal	int			= NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Articulo	char(20),
    @Serie		varchar(50),
    @Renglon	float

  SELECT @Renglon = ISNULL(MAX(Renglon) + 2048, 2048) FROM ActivoFijoD WHERE ID = @ID

  IF @MovTipo = 'AF.DP' 
  BEGIN
    IF @SubClaveFiscal = 1
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtilF, 0) - ISNULL(af.DepreciacionMesesF, 0) > 0)
          AND af.DepreciacionInicioF <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltimaF,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltimaF,0)) < DATEPART(YEAR, @FechaEmision))
          AND af.Categoria		= @Categoria
    ELSE
    IF @SubClaveFiscal = 2
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtilF2, 0) - ISNULL(af.DepreciacionMesesF2, 0) > 0)
          AND af.DepreciacionInicioF2 <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltimaF2,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltimaF2,0)) < DATEPART(YEAR, @FechaEmision))
          AND af.Categoria		= @Categoria
    ELSE
    BEGIN    
      DECLARE crActivoFijoTodo CURSOR FOR 
       SELECT NULLIF(RTRIM(af.Articulo), ''), NULLIF(RTRIM(af.Serie), '') 
         FROM ActivoF af
         JOIN ActivoFCat cat ON af.Categoria = cat.Categoria AND cat.Propietario = 'Empresa'
        WHERE af.Empresa = @Empresa AND af.Estatus <> 'INACTIVO' AND af.Moneda = @MovMoneda AND (ISNULL(af.VidaUtil, 0) - ISNULL(af.DepreciacionMeses, 0) > 0)
          AND af.DepreciacionInicio <= @FechaEmision
          AND (DATEPART(MONTH,ISNULL(af.DepreciacionUltima,0)) < DATEPART(MONTH, @FechaEmision) OR DATEPART(YEAR,ISNULL(af.DepreciacionUltima,0)) < DATEPART(YEAR, @FechaEmision))
          AND af.Categoria		= @Categoria
    END
  END ELSE
    DECLARE crActivoFijoTodo CURSOR FOR 
    SELECT NULLIF(RTRIM(Articulo), ''), NULLIF(RTRIM(Serie), '') 
      FROM ActivoF 
     WHERE Empresa = @Empresa 
       AND Estatus <> 'INACTIVO' 
       AND Moneda = @MovMoneda 
       AND Categoria		= @Categoria
  
  OPEN crActivoFijoTodo
  FETCH NEXT FROM crActivoFijoTodo INTO @Articulo, @Serie
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048
      INSERT ActivoFijoD (Sucursal, ID, Renglon, RenglonSub, Articulo, Serie) 
                  VALUES (@Sucursal, @ID, @Renglon, 0, @Articulo, @Serie)
    END
    FETCH NEXT FROM crActivoFijoTodo INTO @Articulo, @Serie
    IF @@ERROR <> 0 SELECT @Ok = 1
  END  -- While
  CLOSE crActivoFijoTodo
  DEALLOCATE crActivoFijoTodo
  RETURN
END
GO

/**************** spActivoFijoSugerirProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spActivoFijoSugerirProcesar') and type = 'P') drop procedure dbo.spActivoFijoSugerirProcesar
GO
CREATE PROCEDURE spActivoFijoSugerirProcesar
			@ID						int,
			@EstacionTrabajo		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE @Clave			varchar(255),
		  @ClaveAnt			varchar(255),
		  @MovTipo			varchar(20),
		  @SubClave			varchar(20),
		  @SubClaveFiscal	int,
		  @Mov				varchar(20),  
		  @Moneda			varchar(10),  
		  @Sucursal			int,		
		  @Empresa			varchar(5),
		  @Fecha			datetime,
		  @Ok				int

  SELECT @Mov		= Mov,
		 @Moneda	= Moneda,
         @Sucursal	= Sucursal,
         @Empresa	= Empresa,
         @Fecha		= FechaEmision
    FROM ActivoFijo
   WHERE ID = @ID
     
  SELECT @MovTipo	= MovTipo.Clave, 
         @SubClave	= MovTipo.SubClave
    FROM MovTipo 
   WHERE Modulo = 'AF' 
     AND Mov = @Mov
  
  SELECT @SubClaveFiscal = dbo.fnSubClaveFiscal(@SubClave)		  

  DELETE ActivoFijoD WHERE ID = @ID
  
  SELECT @ClaveAnt = ''
  WHILE(1=1)
  BEGIN
    SELECT @Clave = MIN(Clave)
      FROM ListaSt
     WHERE Estacion = @EstacionTrabajo
       AND Clave > @ClaveAnt
  
    IF @Clave IS NULL BREAK 
    
    SELECT @ClaveAnt = @Clave, @Ok = NULL

    EXEC spActivoFijoCopiarCategoria @Sucursal, @Empresa, @ID, @MovTipo, @Moneda, @Fecha, @Clave, @Ok OUTPUT, @SubClave, 
									 @SubClaveFiscal
  END
  RETURN
END
GO

/************** spAplicaValAdquisicionAF*************/
if exists (select * from sysobjects where id = object_id('dbo.spAplicaValAdquisicionAF') and type = 'P') drop procedure dbo.spAplicaValAdquisicionAF
GO
CREATE PROCEDURE dbo.spAplicaValAdquisicionAF
	@ID			int,
	@Modulo		varchar(5),
	@Estatus	varchar(20),
	@Empresa	varchar(5),
	@Usuario    varchar(10),
	@Ok			int		OUTPUT,
	@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
DECLARE
	@Clave		Varchar(20),
	@RenglonSL		Int,
	@ValorCancelado	Money,
	@cID			Int,
	@cRenglon		Float,
	@cModulo		Varchar(5),
	@cArt			Varchar(20),
	@cSerie			Varchar(50),
	@cTotal			Money,
	@cTotalMov		Money,
	@cFechaIniDep	Datetime


	IF @Modulo = 'COMS'
		SELECT @Clave = m.Clave
		  FROM Compra c
		  JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = @Modulo AND c.ID = @ID

	IF @Modulo = 'GAS'
		SELECT @Clave = m.Clave
		  FROM Gasto c
		  JOIN MovTipo m ON c.Mov = m.Mov AND m.Modulo = @Modulo AND c.ID = @ID

	DECLARE cActivoFijo CURSOR FOR 
	SELECT B.ID, A.Renglon, A.Modulo, A.Articulo, A.Serie, A.Total, A.ImporteMov, A.FechaInicioDepreciacion
	  FROM AuxiliarActivoFijo A
 LEFT JOIN ActivoF B ON B.Articulo = A.Articulo AND B.Serie = A.Serie
	 WHERE A.IDMov = @ID AND A.Modulo = @Modulo
	   AND A.Aplicar = 1
	
	OPEN cActivoFijo
	FETCH NEXT FROM cActivoFijo INTO @cID, @cRenglon, @cModulo, @cArt, @cSerie, @cTotal, @cTotalMov, @cFechaIniDep
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Estatus = 'CONCLUIDO' AND (@Clave IN ('COMS.EI','COMS.EG') OR @cModulo = 'GAS')
		BEGIN
			
			UPDATE ActivoF
			   SET AdquisicionValor = AdquisicionValor + @cTotalMov
			 WHERE ID = @cID 
			   AND ISNULL(DepreciacionInicio,GETDATE()) <= ISNULL(@cFechaIniDep,GETDATE())
			   
			IF @Clave = 'COMS.EG'
			BEGIN
				UPDATE ActivoF
				   SET AdquisicionValor = AdquisicionValor + @cTotalMov,
					   AdquisicionValorF = AdquisicionValorF + @cTotalMov,
					   AdquisicionValorF2 = AdquisicionValorF2 + @cTotalMov
				 WHERE ID = @cID 
				   AND ISNULL(DepreciacionInicio,GETDATE()) <= ISNULL(@cFechaIniDep,GETDATE())
			
			END
		
			SELECT @RenglonSL = MAX(ISNULL(RenglonID,0))+1
			  FROM SerieLoteD A
			 WHERE Empresa = @Empresa 
			   AND Articulo = @cArt
			   AND SerieLote = @cSerie
			   AND Modulo = @cModulo
			   AND ID = @ID

			DELETE FROM SerieLoteD 
			      WHERE Articulo = @cArt 
			        AND SerieLote = @cSerie 
			        AND Modulo = @cModulo 
			        AND ID = @ID
			        AND Empresa = @Empresa 

			INSERT INTO SerieLoteD(Empresa, Articulo, Subcuenta, SerieLote, Modulo, ID, RenglonID, Sucursal)
							SELECT A.Empresa, A.Articulo, B.Subcuenta, A.Serie, @cModulo, @ID, @cRenglon, A.Sucursal
							  FROM ActivoF A
							  JOIN SerieLote B ON A.Articulo = B.Articulo 
							   AND A.Serie = B.SerieLote
							 WHERE A.Articulo = @cArt 
							   AND A.ID = @cID
							EXCEPT
							SELECT Empresa, Articulo, Subcuenta, SerieLote, Modulo, ID, RenglonID, Sucursal
							  FROM SerieLoteD
							 WHERE Empresa = @Empresa
							   AND Modulo = @cModulo
							   AND ID = @ID
							
		END
		
		IF (@Estatus = 'CANCELADO'  AND (@Clave IN ('COMS.EI','COMS.EG') OR  @cModulo = 'GAS')) OR (@Estatus = 'CONCLUIDO' AND @Clave IN ('COMS.D','COMS.B'))
		BEGIN
			
			SELECT @ValorCancelado = ISNULL(A.AdquisicionValor,0) - ISNULL(@cTotalMov,0)
			  FROM ActivoF A
			  JOIN AuxiliarActivoFijo B ON A.ID = B.ID
			 WHERE B.ID = @cID 
			   AND B.IDMov = @ID
			   AND B.Empresa = @Empresa 
			   AND B.Modulo = @cModulo 
			   AND B.Articulo = @cArt 
			   AND B.Serie =	@cSerie
			   
			UPDATE ActivoF
			   SET AdquisicionValor = @ValorCancelado 
			 WHERE ID = @cID
			   AND Articulo = @cArt
			   AND Serie = @cSerie
			   AND ISNULL(DepreciacionInicio,GETDATE()) <= ISNULL(@cFechaIniDep,GETDATE())
		
			DELETE FROM SerieLoteD 
				  WHERE Empresa = @Empresa
				    AND Articulo = @cArt
				    AND SerieLote = @cSerie
				    AND Modulo = @cModulo
				    AND	ID = @ID
		END
		FETCH NEXT FROM cActivoFijo INTO @cID, @cRenglon, @cModulo, @cArt, @cSerie, @cTotal, @cTotalMov, @cFechaIniDep
	END
	CLOSE cActivoFijo
	DEALLOCATE cActivoFijo
END
GO

/************************     spCalculoValorAdquisicionAF     ************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spCalculoValorAdquisicionAF') AND type = 'P') 
	DROP PROCEDURE dbo.spCalculoValorAdquisicionAF
GO
CREATE PROCEDURE dbo.spCalculoValorAdquisicionAF
	@Estacion	    int,
	@IdMov		    int,
	@Renglon        int,
	@Empresa	    varchar(5),
	@Modulo         varchar(5),
	@Bandera        int = 0,
	@Ok			    int          = NULL OUTPUT,
	@OkRef		    varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
SET NOCOUNT ON
DECLARE @Id                 int,
        @Ids                int,
        @Articulo           varchar(20),
		@Serie              varchar(50),
		@AFArticulo         varchar(20),
		@AFSerie			varchar(50),
		@AdquisicionValor   money,
		@Importe            money,
		@FechaEmision       datetime,
		@Cantidad           float,
		@DepreciacionInicio datetime,
		@Total              money,
		@EsActivoFijo       bit,
		@SerieLote          varchar(50),
		@Renglones          int,
		@CantidadNeta       money, 
		@CostoTotal         money,
		@DescLinea          money,
		@ImpuestoIVA        bit,
		@DescGlobal         money,
		@Subtotal           money,
		@iva                money,
		@Impuesto1          money,
		@ImpuestoIVA2       bit,
		@SubImpuesto2       money,
		@Impuesto           money,
		@Costo              money,
		@Gastodiverso       money,
		@TotalCA            money,
		@ImporteMov         money,
		@Factor             money,
		@TotalGD            money,
		@ClaveMov           varchar(20),
        @Estatus            varchar(15),
		@Conteo             int,
		@ConteoID           int,
		@RenglonID          int,
		@ExisteArt			int,
		@ExisteSer			int 

IF @Renglon IS NULL
RETURN
	IF @Modulo = 'GAS'
	BEGIN
	  IF EXISTS (SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IdMov AND @Modulo = @Modulo AND Empresa = @Empresa AND Aplicar <> 1) 
		DELETE AuxiliarActivoFijo WHERE IDMov = @IdMov AND @Modulo = @Modulo AND Empresa = @Empresa

      SELECT @Estatus =  Estatus FROM Gasto WHERE ID = @IdMov
      IF @Estatus = 'CONCLUIDO'
       RETURN

	   SELECT @ExisteArt = 0, @ExisteSer = 0

	   IF (SELECT COUNT(AFArticulo) FROM Gasto WHERE ID = @IdMov AND AFArticulo <> '') >= 1
		SET @ExisteArt = 1
	   
	   IF (SELECT COUNT(AFSerie) FROM Gasto WHERE ID = @IdMov AND AFSerie <> '') >= 1
		SET @ExisteSer = 1

	   DECLARE crArtSLS CURSOR FOR
	    SELECT GD.Importe + ISNULL(GD.Impuestos,0),
		       G.FechaEmision,
			   G.AFArticulo,
			   G.AFSerie,
			   G.AF,
			   GD.Cantidad			   
		  FROM Gasto AS G
		  JOIN GastoD AS GD ON GD.ID = G.ID
		 WHERE G.Id = @IdMov
		   AND G.Empresa = @Empresa

		OPEN crArtSLS
		FETCH NEXT FROM crArtSLS INTO @Importe, @FechaEmision, @AFArticulo, @AFSerie, @EsActivoFijo, @Cantidad
		WHILE @@FETCH_STATUS = 0 	   
		BEGIN	
			IF ISNULL(@AFArticulo,'') <> '' AND ISNULL(@AFSerie,'') <> '' AND @EsActivoFijo = 1
			BEGIN
				SELECT @AdquisicionValor   = AdquisicionValor,
					   @DepreciacionInicio = DepreciacionInicio,
					   @Id                 = ID
				  FROM ActivoF 
				 WHERE Articulo = @AFArticulo AND Serie = @AFSerie 
				   AND Empresa = @Empresa
				   AND @FechaEmision <= ISNULL(DepreciacionInicio,@FechaEmision)

				 SET @Total = ISNULL(@AdquisicionValor,0) + @Importe

				IF /*ISNULL(CONVERT(VARCHAR(50),@AdquisicionValor),'') <> '' AND*/ ISNULL(CONVERT(VARCHAR(50),@DepreciacionInicio),'') <> '' AND ISNULL(@Id,0) > 0
				BEGIN
					IF EXISTS(SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Articulo = @AFArticulo AND Serie = @AFSerie)
					BEGIN
						UPDATE AuxiliarActivoFijo
						   SET ImporteMov = (ImporteMov + @Importe), Total = (@Total + ImporteMov)
						 WHERE IDMov = @IDMov AND Articulo = @AFArticulo AND Serie = @AFSerie AND Empresa = @Empresa
					END
					ELSE
					BEGIN
						INSERT INTO AuxiliarActivoFijo (ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, Total, FechaEmision, 
														FechaInicioDepreciacion) 
												SELECT  ISNULL(@Id,0), @IDMov, ISNULL(@Renglon,0), @Empresa, @Modulo, @AFArticulo, @AFSerie,  @Cantidad,  @AdquisicionValor, @Importe, @Total, @FechaEmision,
														@DepreciacionInicio
						EXCEPT
						SELECT @Id, IDMov, @Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, Total, FechaEmision, 
														FechaInicioDepreciacion
						  FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Articulo = @AFArticulo AND Serie = @AFSerie
					END
				END
			END
		FETCH NEXT FROM crArtSLS INTO @Importe, @FechaEmision, @AFArticulo, @AFSerie, @EsActivoFijo, @Cantidad
		END
		CLOSE crArtSLS
		DEALLOCATE crArtSLS	

	
			IF (ISNULL(@AFArticulo,'') = '' OR ISNULL(@AFSerie,'') = '') AND @EsActivoFijo = 1
			BEGIN	
				DECLARE crArtAF CURSOR FOR
				SELECT A.id
				  FROM ListaID A
				 WHERE A.Estacion = @Estacion
				 UNION
				SELECT B.ID
				  FROM AuxiliarActivoFijo B
				 WHERE B.Modulo = @Modulo 
				   AND B.IDMov = @IdMov 
				   AND B.Empresa = @Empresa

				OPEN crArtAF
				FETCH NEXT FROM crArtAF INTO @Ids
				WHILE @@FETCH_STATUS = 0 
				BEGIN	

				SET @Importe = 0

				SELECT @Importe = SUM((GD.Importe + ISNULL(GD.Impuestos,0)))
				  FROM Gasto AS G
				  JOIN GastoD AS GD ON GD.ID = G.ID
				 WHERE G.Id = @IdMov
				   AND G.Empresa = @Empresa
						
				SELECT @Conteo = COUNT(*) FROM (SELECT A.id
												  FROM ListaID A
												 WHERE A.Estacion = @Estacion
												 UNION
												SELECT B.ID
												  FROM AuxiliarActivoFijo B
												 WHERE B.Modulo = @Modulo 
												   AND B.IDMov = @IdMov
												   AND B.Empresa = @Empresa
												) A
				
					SELECT @Importe = ROUND(@Importe / @Conteo,2)
					  FROM Gasto AS G
					  JOIN GastoD AS GD ON GD.ID = G.ID
					 WHERE G.Id = @IdMov
					   AND GD.Renglon = @Renglon
           			
					SELECT @Articulo           = Articulo, 
						   @Serie              = Serie, 
						   @AdquisicionValor   = AdquisicionValor,
						   @DepreciacionInicio = DepreciacionInicio
					  FROM ActivoF 
					 WHERE ID = @Ids
					   AND Empresa = @Empresa
					   AND @FechaEmision <= ISNULL(DepreciacionInicio,@FechaEmision)

					 SET @Total = ISNULL(@AdquisicionValor,0) + @Importe

					IF ISNULL(@Articulo,'') <> '' AND ISNULL(@Serie, '') <> '' /*AND /SNULL(CONVERT(VARCHAR(50),@AdquisicionValor),'') <> '' */AND ISNULL(CONVERT(VARCHAR(50),@DepreciacionInicio),'') <> ''
					BEGIN
					
						IF EXISTS(SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Articulo = @Articulo AND Serie = @Serie AND Renglon = @Renglon)
						BEGIN
							
							UPDATE AuxiliarActivoFijo
							   SET ImporteMov = @Importe, Total = (@AdquisicionValor + @Importe) -- @Importe, Total = @Total
							 WHERE IDMov = @IDMov AND Articulo = @Articulo AND Serie = @Serie AND Renglon = @Renglon AND ID = @Ids AND Empresa = @Empresa
						END
				
						IF NOT EXISTS(SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Articulo = @Articulo AND Serie = @Serie AND Renglon = @Renglon)
						BEGIN
							INSERT INTO AuxiliarActivoFijo (ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, Total, FechaEmision, 
															FechaInicioDepreciacion) 
													SELECT  @Ids, @IDMov, @Renglon, @Empresa, @Modulo, @Articulo, @Serie,  @Cantidad,  @AdquisicionValor, @Importe, @Total, @FechaEmision,
															@DepreciacionInicio
							EXCEPT
							SELECT ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, Total, FechaEmision, 
															FechaInicioDepreciacion
							  FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Articulo = @Articulo AND Serie = @Serie AND Renglon = @Renglon
  						END
  		        
  					END
					FETCH NEXT FROM crArtAF INTO @Ids
				END
				CLOSE crArtAF
				DEALLOCATE crArtAF
			END	
	END	
    
	IF @Modulo = 'COMS'
	BEGIN	
	  IF EXISTS (SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IdMov AND Modulo = @Modulo AND Empresa = @Empresa) 
		DELETE AuxiliarActivoFijo WHERE IDMov = @IdMov AND @Modulo = Modulo AND Empresa = @Empresa
	  
	  SELECT @ExisteArt = 1, @ExisteSer = 1, @Bandera = 1

	  SET @ConteoID = 0
	  DECLARE @RenglonLista TABLE (ConteoID int identity(1,1) NOT NULL, RenglonID int NOT NULL)
	  
      SELECT @Estatus =  Estatus FROM Compra WHERE ID = @IdMov
      IF @Estatus = 'CONCLUIDO'
       RETURN

      IF NOT EXISTS (SELECT * FROM Compragastodiverso WHERE ID = @IdMov)
        RETURN 
	
	    DECLARE crArtAF CURSOR FOR
			SELECT CD.Articulo, CD.Renglon FROM Compra AS C JOIN CompraD AS CD ON CD.ID = C.ID WHERE C.Id = @IdMov AND C.Empresa = @Empresa

		OPEN crArtAF
		FETCH NEXT FROM crArtAF INTO @Articulo, @Renglon
		WHILE @@FETCH_STATUS = 0 
		BEGIN	
			SELECT @Cantidad     = CD.Cantidad,
				   @FechaEmision = C.FechaEmision,
			       @ClaveMov     = MovTipo.Clave
			  FROM Compra AS C JOIN CompraD AS CD ON CD.ID = C.ID 
			  JOIN MovTipo ON C.Mov = MovTipo.Mov AND MovTipo.Modulo = @Modulo
			 WHERE C.Id = @IdMov AND CD.Renglon = @Renglon
			   AND C.Empresa = @Empresa

			SELECT @ImpuestoIVA  = Impuesto2BaseImpuesto1,
			       @ImpuestoIVA2 = Impuesto2Info
			  FROM Version

			SELECT @DepreciacionInicio =CASE InicioDepreciacion WHEN 'Siguiente Mes' 
																THEN DATEADD(MONTH,1,CONVERT(DATETIME,'01/'+CAST(DATEPART(MONTH,@FechaEmision) AS VARCHAR)+'/'+
																							CAST(DATEPART(YEAR,@FechaEmision) AS VARCHAR)))
																WHEN 'Siguiente Año' 
																THEN DATEADD(YEAR,1,CONVERT(DATETIME,'01/'+CAST(DATEPART(MONTH,@FechaEmision) AS VARCHAR)+'/'+
																							CAST(DATEPART(YEAR,@FechaEmision) AS VARCHAR)))
																ELSE @FechaEmision
										END
			  FROM Art A
			  JOIN ActivoFCat B
				ON A.CategoriaActivoFijo = B.Categoria
			 WHERE A.Articulo = @Articulo

			   SET @ConteoID = @ConteoID + 1
			  
			    DECLARE crArtSLS CURSOR FOR
					SELECT DISTINCT RenglonID FROM SerieLoteMov WHERE ID = @IdMov AND Articulo = @Articulo AND Modulo = @Modulo AND Empresa = @Empresa
					
				OPEN crArtSLS
				FETCH NEXT FROM crArtSLS INTO @RenglonID
				WHILE @@FETCH_STATUS = 0 
				BEGIN
									
					IF NOT EXISTS (SELECT * FROM @RenglonLista WHERE RenglonID = @RenglonID)
						INSERT INTO @RenglonLista (RenglonID) VALUES (@RenglonID)				

					FETCH NEXT FROM crArtSLS INTO @RenglonID
		        END
				CLOSE crArtSLS
				DEALLOCATE crArtSLS				

				SELECT @RenglonID = RenglonID
				  FROM @RenglonLista
				 WHERE ConteoID = @ConteoID		

				DECLARE crArtSL CURSOR FOR
					SELECT Articulo, SerieLote FROM SerieLoteMov WHERE ID = @IdMov AND Articulo = @Articulo AND Modulo = @Modulo AND Empresa = @Empresa AND RenglonID = @RenglonID

								
				OPEN crArtSL
				FETCH NEXT FROM crArtSL INTO @Articulo, @SerieLote
				WHILE @@FETCH_STATUS = 0 
				BEGIN	
					
					SELECT @CantidadNeta = ISNULL(CD.Cantidad,0) - ISNULL(CD.CantidadCancelada,0),
						   @CostoTotal   = ISNULL(CD.Costo,0), --* @CantidadNeta,
						   @DescLinea    = CASE WHEN ISNULL(CD.DescuentoTipo,'') = '$' THEN ISNULL(CD.DescuentoLinea,0) ELSE @CostoTotal * (ISNULL(CD.DescuentoLinea,0)/100) END,
						   @Importe      = @CostoTotal - @DescLinea,
						   @DescGlobal   = @Importe * (ISNULL(C.DescuentoGlobal,0)/100),
						   @Subtotal     = @Importe - @DescGlobal,
						   @SubImpuesto2 = CASE WHEN @ImpuestoIVA2 = 1 THEN 0 ELSE @SubTotal * (ISNULL(CD.Impuesto2,0)/100) END,
						   @Impuesto     = CASE WHEN @ImpuestoIVA = 1 THEN @SubImpuesto2 ELSE 0 END,
						   @Impuesto1    = ISNULL(CD.Impuesto1,0),
						   @IVA          = (@Subtotal + @Impuesto) * (ISNULL(cd.Impuesto1,0)/100),
						   @Costo        = (@Importe + @IVA)* C.TipoCambio
						FROM Compra AS C
						JOIN CompraD AS CD ON CD.ID = C.ID
						WHERE C.Id = @IdMov
					      AND C.Empresa = @Empresa
						  AND CD.Renglon = @Renglon
						  
					SELECT @Cantidad = @CantidadNeta / COUNT(*) FROM SerieLoteMov WHERE ID = @IdMov AND Articulo = @Articulo AND Modulo = @Modulo AND Empresa = @Empresa						  
						
					IF @ClaveMov IN ('COMS.EG','COMS.EI')
					BEGIN
						SELECT @AdquisicionValor   = @CostoTotal,
							   --@DepreciacionInicio = DepreciacionInicio,
							   @Ids                = ID
						  FROM ActivoF 
						 WHERE Articulo = @Articulo
						   AND Empresa = @Empresa
						 ORDER BY ID DESC
					END
					
					SET @Total = ISNULL(@AdquisicionValor,0) + @Importe
					
					IF ISNULL(@Articulo,'') <> '' AND ISNULL(@SerieLote, '') <> '' AND ISNULL(@Ids,0) > 0
					BEGIN
					
						INSERT INTO AuxiliarActivoFijo (ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, Total, FechaEmision, 
														FechaInicioDepreciacion) 
												SELECT  ISNULL(@Ids,0), @IDMov, ISNULL(@Renglon,0), @Empresa, @Modulo, @Articulo, @SerieLote,  @Cantidad,  @AdquisicionValor, @Costo, 0, @FechaEmision,
														@DepreciacionInicio 
						EXCEPT
						SELECT ID, IDMov, Renglon, Empresa, Modulo, Articulo, Serie, Cantidad, ValorAdquisicion, ImporteMov, 0, FechaEmision, 
													FechaInicioDepreciacion
						  FROM AuxiliarActivoFijo 
						  WHERE IDMov = @IDMov AND Articulo = @Articulo AND Serie = @SerieLote AND Renglon = @Renglon
					  
					END
					FETCH NEXT FROM crArtSL INTO @Articulo, @SerieLote
		        END
				CLOSE crArtSL
				DEALLOCATE crArtSL

					FETCH NEXT FROM crArtAF INTO @Articulo, @Renglon
		END
		CLOSE crArtAF
		DEALLOCATE crArtAF

			SELECT @Gastodiverso = SUM(((Importe + Impuestos)-(Retencion + Retencion2 + Retencion3))*TipoCambio)
			  FROM Compragastodiverso
			 WHERE ID = @IdMov

			 SELECT @TotalCA = SUM(ImporteMov) 
			   FROM AuxiliarActivoFijo 
			  WHERE IDMov = @IdMov AND Modulo = @Modulo AND Empresa = @Empresa
			  

	    DECLARE crAuxArtAF CURSOR FOR
			SELECT IDMov, Renglon, Articulo, Serie, ImporteMov FROM AuxiliarActivoFijo WHERE IDMov = @IdMov 
			   AND Modulo = @Modulo

	    OPEN crAuxArtAF
		FETCH NEXT FROM crAuxArtAF INTO @IDMov, @Renglon, @Articulo, @Serie, @ImporteMov
		WHILE @@FETCH_STATUS = 0 
		BEGIN			
			
			IF @ImporteMov <> 0 AND @TotalCA <> 0
				BEGIN
					SET @Factor  = @ImporteMov / @TotalCA
					SET @TotalGD = @Factor * @Gastodiverso
					SET @Factor = ROUND(@Factor,2)
				END
			ELSE
				IF @ImporteMov = 0 AND @TotalCA = 0
				BEGIN
					SET @Factor  = 0
					SET @TotalGD = 0
				END

			IF @ClaveMov IN ('COMS.D','COMS.B')
				SET @Total = @ImporteMov - @TotalGD
			ELSE
				SET @Total = @ImporteMov + @TotalGD

			UPDATE AuxiliarActivoFijo 
			   SET FactorCalculo = @Factor, Total = @Total, ImporteMov = @TotalGD, ValorAdquisicion = @ImporteMov
			 WHERE Articulo = @Articulo AND Serie = @Serie AND IDMov = @IDMov AND Renglon = @Renglon AND Empresa = @Empresa	

			FETCH NEXT FROM crAuxArtAF INTO @IDMov, @Renglon, @Articulo, @Serie, @ImporteMov
		END
		CLOSE crAuxArtAF
		DEALLOCATE crAuxArtAF   
	END
	
IF NOT EXISTS (SELECT * FROM AuxiliarActivoFijo WHERE IDMov = @IDMov AND Modulo = @Modulo) AND ((@ExisteArt = 0 AND @ExisteSer = 0 AND @Bandera = 1) OR (@ExisteArt = 1 AND @ExisteSer = 1 AND @Bandera = 0))
BEGIN
	SELECT 'La Fecha de Inicio de la depreciación del Artículo AF dede ser mayor o igual a la fecha emisión del movimiento'	
END
ELSE
BEGIN
	SELECT 'Proceso concluido.'
END
DELETE ListaID WHERE Estacion = @Estacion
END
SET NOCOUNT OFF
GO

/************************     spAplicaGastoActivoFijo     ************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spAplicaGastoActivoFijo') AND type = 'P') 
	DROP PROCEDURE dbo.spAplicaGastoActivoFijo
GO
CREATE PROCEDURE dbo.spAplicaGastoActivoFijo
  @Empresa  varchar(5),
  @Modulo   varchar(20),
  @IDMov    int
--//WITH ENCRYPTION
AS
BEGIN
  DECLARE
  @FechaEmision              datetime,
  @cID                       int,
  @cRenglon                  Float,
  @cArticulo                 varchar(20), 
  @cSerie                    varchar(20),
  @cFechaInicioDepreciacion  datetime

  DECLARE cActivoFijo CURSOR FOR
  SELECT ID, Renglon, Articulo, Serie, FechaInicioDepreciacion
    FROM AuxiliarActivoFijo
   WHERE IDMov = @IDMov
     AND Empresa = @Empresa
     AND Modulo = @Modulo

  OPEN cActivoFijo
  FETCH NEXT FROM cActivoFijo INTO @cID, @cRenglon, @cArticulo, @cSerie, @cFechaInicioDepreciacion

  WHILE @@FETCH_STATUS = 0
  BEGIN
    IF @Modulo = 'GAS'
      SELECT @FechaEmision = FechaEmision FROM Gasto WHERE ID = @IDMov

    IF @Modulo = 'COMS'
      SELECT @FechaEmision = FechaEmision FROM Compra WHERE ID = @IDMov

    IF @FechaEmision <= ISNULL(@cFechaInicioDepreciacion,@FechaEmision) OR @Modulo = 'COMS'
    BEGIN
      UPDATE AuxiliarActivoFijo SET Aplicar = 1, Icono = 339
      WHERE ID = @cID 
        AND IDMov = @IDMov 
        AND Renglon = @cRenglon
        AND Empresa = @Empresa 
        AND Modulo = @Modulo
        AND Articulo = @cArticulo
        AND Serie = @cSerie
    END

    IF @FechaEmision > @cFechaInicioDepreciacion AND @Modulo <> 'COMS'
    BEGIN
      UPDATE AuxiliarActivoFijo SET Icono = 522
      WHERE ID = @cID 
        AND IDMov = @IDMov 
        AND Renglon = @cRenglon
        AND Empresa = @Empresa 
        AND Modulo = @Modulo
        AND Articulo = @cArticulo
        AND Serie = @cSerie
    END

    FETCH NEXT FROM cActivoFijo INTO @cID, @cRenglon, @cArticulo, @cSerie, @cFechaInicioDepreciacion
  END

  CLOSE cActivoFijo
  DEALLOCATE cActivoFijo

END
GO
/************************     spEliminaAuxiliarAF     ************************/
IF EXISTS (SELECT id FROM sysobjects WHERE id = object_id('spEliminaAuxiliarAF') AND type = 'P') 
	DROP PROCEDURE dbo.spEliminaAuxiliarAF
GO
CREATE PROCEDURE dbo.spEliminaAuxiliarAF
  @Empresa     varchar(5),
  @Modulo      varchar(20),
  @ID          int,
  @ArticuloID  int,
  @Bandera     bit
--//WITH ENCRYPTION
AS
BEGIN

  DECLARE @Estatus varchar(15)

  IF @Modulo = 'GAS'
  BEGIN
    SELECT @Estatus =  Estatus FROM Gasto WHERE ID = @ID

    IF (@Estatus = 'CONCLUIDO' OR @Estatus = 'CANCELADO')
      RETURN
  END

  IF @Modulo = 'COMS'
  BEGIN
    SELECT @Estatus =  Estatus FROM Compra WHERE ID = @ID

    IF (@Estatus = 'CONCLUIDO' OR @Estatus = 'CANCELADO')
      RETURN
  END

  IF @Bandera = 0
	DELETE AuxiliarActivoFijo 
	 WHERE Modulo = @Modulo AND IDMov = @ID AND Empresa = @Empresa AND ID = @ArticuloID

  IF @Bandera = 1
    DELETE AuxiliarActivoFijo 
     WHERE Modulo = @Modulo AND IDMov = @ID AND Empresa = @Empresa

END
GO
PRINT "******************* SP ActivoFijos ******************"