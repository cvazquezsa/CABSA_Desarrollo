/* SP ADMINISTRACION CREDITOS   */
-- select importe, * from cxc
-- select * from lc
-- spLCExpress 'cxc', 436
/**************** spLCExpress ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLCExpress') and type = 'P') drop procedure dbo.spLCExpress
GO             
CREATE PROCEDURE spLCExpress
			@Modulo		char(5),
			@ID		int,
			@LineaCredito	varchar(20)	= NULL	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Fecha		datetime,
    @Descripcion	varchar(20),
    @Acreditado		varchar(10),
    @Acreedor		varchar(10),
    @Uso		varchar(20),
    @Estatus		varchar(15),
    @Moneda		varchar(10),
    @Importe		money,
    @Empresa		varchar(5)

  SELECT @LineaCredito = RTRIM(@Modulo)+CONVERT(varchar(20), @ID), @Estatus = 'ALTA'

  IF @Modulo = 'CXC' SELECT @Empresa = Empresa, @Fecha = FechaEmision, @Moneda = Moneda, @Importe = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @Descripcion = RTRIM(Mov)+' '+RTRIM(MovID), @Acreditado = Cliente,   @Uso = 'Colocacion' FROM Cxc WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' SELECT @Empresa = Empresa, @Fecha = FechaEmision, @Moneda = Moneda, @Importe = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0), @Descripcion = RTRIM(Mov)+' '+RTRIM(MovID), @Acreedor   = Proveedor, @Uso = 'Fondeo'     FROM Cxp WHERE ID = @ID 

  UPDATE LC
     SET Empresa = @Empresa,
         Fecha = @Fecha,
	 Descripcion = @Descripcion,
         Acreditado = @Acreditado,
         Acreedor = @Acreedor,
         Uso = @Uso,
         DisposicionTipo = 'Revolvente',
         TipoCredito = 'Credito Simple',
         VigenciaDesde = @Fecha,
         Moneda = @Moneda,
         Importe = @Importe,
         Estatus = @Estatus
   WHERE LineaCredito = @LineaCredito
  IF @@ROWCOUNT = 0
    INSERT LC (
            Express, LineaCredito,  Empresa,  Fecha,  Descripcion,  Acreditado,  Acreedor,  Uso,  DisposicionTipo, TipoCredito,      VigenciaDesde,  Moneda,  Importe,  Estatus,  Alta) 
    VALUES (1,       @LineaCredito, @Empresa, @Fecha, @Descripcion, @Acreditado, @Acreedor, @Uso, 'Revolvente',    'Credito Simple', @Fecha,         @Moneda, @Importe, @Estatus, GETDATE()) 
  RETURN
END
GO

/**************** spTasaBase ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTasaBase') and type = 'P') drop procedure dbo.spTasaBase
GO             
CREATE PROCEDURE spTasaBase
                        @TasaBase1        varchar(50),
                        @TasaBase2        varchar(50),
                        @TasaBase3        varchar(50),
                        @TasaBase         varchar(50)        OUTPUT,
                        @TasaDias         int                OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  SELECT @TasaBase = NULL, @TasaDias = NULL

  SELECT @TasaDias = Dias FROM Tasa WHERE Tasa = @TasaBase1 AND Estatus = 'ALTA'
  IF @@ROWCOUNT > 0 
    SELECT @TasaBase = @TasaBase1
  ELSE BEGIN
    SELECT @TasaDias = Dias FROM Tasa WHERE Tasa = @TasaBase2 AND Estatus = 'ALTA'
    IF @@ROWCOUNT > 0 
      SELECT @TasaBase = @TasaBase2
    ELSE BEGIN
      SELECT @TasaDias = Dias FROM Tasa WHERE Tasa = @TasaBase3 AND Estatus = 'ALTA'
      IF @@ROWCOUNT > 0 
        SELECT @TasaBase = @TasaBase3
    END
  END
  SELECT @TasaDias = ISNULL(@TasaDias, 360)
  RETURN
END
GO
/*
DECLARE
  @TasaDiaria	float
EXEC spTipoTasa '80 %', @TasaDiaria OUTPUT
SELECT @TasaDiaria
*/
/**************** spTipoTasa ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTipoTasa') and type = 'P') drop procedure dbo.spTipoTasa
GO             
CREATE PROCEDURE spTipoTasa
						@TipoTasa	varchar(20),
                        @TasaDiaria     float        		OUTPUT,
						@TasaTotal	float        = NULL 	OUTPUT ,
                        @TieneTasaEsp	bit 	     = 0,
                        @TasaEsp	float	     = NULL,
                        @TasaRetencion	float	     = NULL	OUTPUT
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
    @Mensaje          	varchar(255)

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

  EXEC spTasaBase @TasaBase, @TasaBase2, @TasaBase3, @TasaBase OUTPUT, @TasaDias OUTPUT

  SELECT @TasaTotal = 0.0, @TasaRetencion = 0.0
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

  SELECT @TasaDiaria = @TasaTotal / @TasaDias,
         @TasaRetencion = @RetencionPuntos / @TasaDias    
  RETURN
END
GO


-- EXEC spVerTipoTasaAnual 'TIIE+2'

/**************** spVerTipoTasaAnual ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerTipoTasaAnual') and type = 'P') drop procedure dbo.spVerTipoTasaAnual
GO             
CREATE PROCEDURE spVerTipoTasaAnual
			@TipoTasa	varchar(20)
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TasaDiaria	float,
    @TasaTotal	float

  EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT, @TasaTotal OUTPUT
  SELECT "TasaAnual" = @TasaTotal
  RETURN
END
GO


/**************** spPagosIgualesCalcTotal ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPagosIgualesCalcTotal') and type = 'P') drop procedure dbo.spPagosIgualesCalcTotal
GO             
CREATE PROCEDURE spPagosIgualesCalcTotal
			@Metodo			int,
			@CapitalTotal		money,
			@TasaDiaria		float,
			@Plazo			int,
			@Amortizaciones		int,
			@ImporteAmortizacion 	money	OUTPUT,
			@InteresTotal		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InteresPct 	float

  IF @Metodo IN (30, 50)
  BEGIN
    SELECT @InteresPct = @TasaDiaria*@Plazo/@Amortizaciones/100.0
    SELECT @ImporteAmortizacion = (@CapitalTotal * @InteresPct) / (1.0-(POWER(1.0+@InteresPct, -@Amortizaciones)))
    SELECT @InteresTotal     = (@ImporteAmortizacion * @Amortizaciones) - @CapitalTotal
  END ELSE
  IF @Metodo = 31 
  BEGIN
    SELECT @InteresTotal     = @CapitalTotal * (@TasaDiaria*@Plazo/100.0)
    SELECT @ImporteAmortizacion = (@CapitalTotal + @InteresTotal) / @Amortizaciones
  END
--select @TasaDiaria*100.0, @Plazo, @Amortizaciones, @InteresPct*100.0, @ImporteAmortizacion
  RETURN
END
GO

/**************** spPagosIgualesCalcAmortizacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spPagosIgualesCalcAmortizacion') and type = 'P') drop procedure dbo.spPagosIgualesCalcAmortizacion
GO             
CREATE PROCEDURE spPagosIgualesCalcAmortizacion
			@Metodo			int,
			@CapitalTotal		money,
			@InteresTotal		money,
			@TasaDiaria		float,
			@Plazo			int,
			@Amortizaciones		int,
			@ImporteAmortizacion 	money,
                        @Amortizacion           int,
                        @SaldoCapital           money	OUTPUT,
                        @SaldoIntereses         money	OUTPUT,
			@Capital		money	OUTPUT,
			@Intereses		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @InteresPct 	float
			
  IF @Metodo IN (30, 50)
  BEGIN
    SELECT @InteresPct = @TasaDiaria*@Plazo/@Amortizaciones/100.0
    SELECT @Capital = @SaldoCapital - ((@CapitalTotal * POWER(1+@InteresPct, @Amortizacion)) - (@ImporteAmortizacion * ((POWER(1+@InteresPct, @Amortizacion)-1)/@InteresPct)))
    SELECT @Intereses = @ImporteAmortizacion - @Capital
  END ELSE
  IF @Metodo = 31
  BEGIN
    IF @Amortizacion = @Amortizaciones 
      SELECT @Capital = @SaldoCapital, @Intereses = @SaldoIntereses
    ELSE
      SELECT @Capital = CEILING(@CapitalTotal / @Amortizaciones), @Intereses = CEILING(@InteresTotal / @Amortizaciones)
  END
  SELECT @SaldoCapital = @SaldoCapital - @Capital, @SaldoIntereses = @SaldoIntereses - @Intereses
  RETURN
END
GO

/**************** spTablaAmortizacionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacionGenerar') and type = 'P') drop procedure dbo.spTablaAmortizacionGenerar
GO
CREATE PROCEDURE spTablaAmortizacionGenerar
			@Empresa		char(5),
    			@Sucursal		int,
			@Usuario		char(10),
			@Modulo			char(5),
			@ID			int,
			@Mov			char(20),
			@MovID			varchar(20),
    			@FechaEmision		datetime,
    		        @FechaRegistro		datetime,
    			@TipoTasa		varchar(20),
			@TasaDiaria		float,
			@TieneTasaEsp		bit,
			@TasaEsp		float,
    			@TipoAmortizacion 	varchar(20),
			@Amortizaciones		int,
			@LineaCredito		varchar(20),
    		    	@Ok             	int          = NULL OUTPUT,
    		    	@OkRef          	varchar(255) = NULL OUTPUT,
			@Migracion		bit	     = 0
--//WITH ENCRYPTION
AS BEGIN
  IF @Modulo NOT IN ('CXC', 'CXP') RETURN

  -- SET nocount ON
  DECLARE
    @AmortizacionID		int,
    @AmortizacionMov		varchar(20),
    @AmortizacionMovID		varchar(20),
    @AjusteID			int,
    @AjusteMov			varchar(20),
    @AjusteMovID		varchar(20),
    @Referencia			varchar(50),
    @Amortizacion		int,
    @FechaD			datetime,
    @FechaA			datetime,
    @Capital			money,
    @Intereses			money,
    @IVAInteres					float,
    @IVAInteresPorcentaje		float,
    @Retencion					money,
    @InteresesFijos				money,
    @InteresesFijosRetencion		money,
    @InteresesOrdinarios			money,
    @InteresesOrdinariosIVA			float,
    @InteresesMoratorios			money,
    @InteresesMoratoriosIVA			float,    
    @SaldoInteresesOrdinarios		money,
    @SaldoInteresesOrdinariosIVA	float,    
    @CobroIntereses		varchar(20),
    @Pendiente			bit,
    @FechaCobro			datetime,
    @DesglosarImpuestos 	bit,
    @CarteraVencidaCBNV		bit,
    @GenerarCxpTotal		bit,
    @FechaOriginal		datetime,
    @DisposicionCxpMov		varchar(20),
    @OrigenTipo			varchar(10),
    @Origen			varchar(20),
    @OrigenID			varchar(20),
    @CxpID			int,
    @CxpMov			varchar(20),
    @CxpMovID			varchar(20),
    @CxpImporte			money,
    @InteresesMov		varchar(20), --MEJORA10041
    @InteresesMovID		varchar(20), --MEJORA10041    
    @InteresesID		int, --MEJORA10041
    @Renglon			float --MEJORA10041
    
  SELECT @GenerarCxpTotal = 0
  SELECT @CarteraVencidaCBNV = ISNULL(CarteraVencidaCBNV, 0),
         @CobroIntereses = UPPER(CobroIntereses)
    FROM LC 
   WHERE LineaCredito = @LineaCredito
  SELECT @DesglosarImpuestos = 0

  IF @Modulo = 'CXC'
  BEGIN
    SELECT @DesglosarImpuestos = ISNULL(CxcCobroImpuestos, 0) FROM EmpresaCfg2 WHERE Empresa = @Empresa
    SELECT @GenerarCxpTotal    = ACAcreedorEnDisposiciones    FROM EmpresaCfg  WHERE Empresa = @Empresa
  END

  SELECT @AmortizacionMov   = CASE WHEN @Modulo = 'CXC' THEN CxcAmortizacion  ELSE CxpAmortizacion END,
         @AjusteMov         = CASE WHEN @Modulo = 'CXC' THEN CxcAjuste        ELSE CxpAjuste       END,
         @DisposicionCxpMov = CASE WHEN @Modulo = 'CXC' THEN ACDisposicionCxp ELSE NULL            END,
         @InteresesMov      = CASE WHEN @Modulo = 'CXC' THEN CxcIntereses     ELSE CxpIntereses    END --MEJORA10041
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @CobroIntereses = 'FIJOS' --MEJORA10041
  BEGIN
    IF @Modulo = 'CXC'
    BEGIN
      INSERT Cxc (OrigenTipo, Origen, OrigenID, Sucursal,  Empresa,  Mov,           FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,   ClienteMoneda, ClienteTipoCambio, EsInteresFijo)
          SELECT  @Modulo,    @Mov,   @MovID,   @Sucursal, @Empresa, @InteresesMov, @FechaEmision, Moneda,  TipoCambio,  @Usuario, 'SINAFECTAR', Cliente,   ClienteMoneda, ClienteTipoCambio, 1
            FROM Cxc
           WHERE ID = @ID
          SELECT @InteresesID = SCOPE_IDENTITY()
          
    END ELSE
    BEGIN
      INSERT Cxp (OrigenTipo, Origen, OrigenID, Sucursal,  Empresa,  Mov,           FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Proveedor,   ProveedorMoneda, ProveedorTipoCambio, EsInteresFijo)
          SELECT  @Modulo,    @Mov,   @MovID,   @Sucursal, @Empresa, @InteresesMov, @FechaEmision, Moneda,  TipoCambio,  @Usuario, 'SINAFECTAR', Proveedor,   ProveedorMoneda, ProveedorTipoCambio, 0
            FROM Cxp
           WHERE ID = @ID
          SELECT @InteresesID = SCOPE_IDENTITY()
    
    END
  END
  
  IF EXISTS(SELECT * FROM EmpresaCfgMovAmortizacion WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov)
    SELECT @AmortizacionMov = Amortizacion FROM EmpresaCfgMovAmortizacion WHERE Empresa = @Empresa AND Modulo = @Modulo AND Mov = @Mov

  IF @Ok IS NULL
  BEGIN
    SET @Renglon = 2048.0 --MEJORA10041
    
    DECLARE crCapital CURSOR LOCAL FOR
     SELECT Amortizacion, ISNULL(Capital, 0.0), ISNULL(Intereses, 0.0), ISNULL(IVAInteres,0.0), ISNULL(IVAInteresPorcentaje,0.0), ISNULL(Retencion, 0.0), FechaD, FechaA --MEJORA10041
       FROM TablaAmortizacion
      WHERE Modulo = @Modulo AND ID = @ID

    OPEN crCapital
    FETCH NEXT FROM crCapital INTO @Amortizacion, @Capital, @Intereses, @IVAInteres, @IVAInteresPorcentaje, @Retencion, @FechaD, @FechaA --MEJORA10041
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        SELECT @AmortizacionID              = NULL, 
               @InteresesFijos              = NULL,
               @InteresesFijosRetencion     = NULL,
    	       @InteresesOrdinarios         = NULL,
    	       @InteresesOrdinariosIVA      = NULL, --MEJORA10041
    	       @InteresesMoratorios         = NULL,
    	       @InteresesMoratoriosIVA      = NULL, --MEJORA10041    	       
               @SaldoInteresesOrdinarios    = NULL,
               @SaldoInteresesOrdinariosIVA = NULL, --MEJORA10041
               @Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID) + ' ('+CONVERT(varchar, @Amortizacion)+'/'+CONVERT(varchar, @Amortizaciones)+')'

        IF @Migracion = 1
          SELECT @InteresesOrdinarios = InteresesOrdinarios,
                 @InteresesOrdinariosIVA = InteresesOrdinariosIVA, --MEJORA10041
                 @InteresesMoratorios = InteresesMoratorios,
                 @InteresesMoratoriosIVA = InteresesMoratoriosIVA, --MEJORA10041                 
                 @TasaDiaria          = TasaDiaria,
                 @Pendiente	      = ISNULL(Pendiente, 0),
                 @FechaCobro	      = FechaCobro
            FROM TablaAmortizacionMigracion
           WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion = @Amortizacion

        SELECT @InteresesFijos = @Intereses, @InteresesFijosRetencion = @Retencion
        IF @CobroIntereses = 'FIJOS' SELECT @SaldoInteresesOrdinarios = @InteresesFijos, @SaldoInteresesOrdinariosIVA = @IVAInteres --MEJORA10041
        IF @Modulo = 'CXC'
        BEGIN
          INSERT Cxc
                 (OrigenTipo, Origen, OrigenID, RamaID, Sucursal,  Empresa,  Mov,              FechaEmision, Condicion, Vencimiento, Referencia,  Importe,  Moneda, TipoCambio, Usuario,   Estatus,     UltimoCambio,   Cliente, ClienteMoneda, ClienteTipoCambio, AplicaManual, Concepto,  Proyecto,  UEN, TasaDiaria,  LineaCredito,  TipoAmortizacion,  TipoTasa, TieneTasaEsp,  TasaEsp,   InteresesFijos,  InteresesOrdinarios,  InteresesMoratorios,  SaldoInteresesOrdinarios,  SaldoInteresesOrdinariosIVA,  IVAInteresPorcentaje) --MEJORA10041
          SELECT  @Modulo,    @Mov,   @MovID,   @ID,    @Sucursal, @Empresa, @AmortizacionMov, @FechaD,      '(Fecha)', @FechaA,     @Referencia, @Capital, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, Cliente, ClienteMoneda, ClienteTipoCambio, 1,            Concepto,  Proyecto,  UEN, @TasaDiaria, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @InteresesFijos, @InteresesOrdinarios, @InteresesMoratorios, 0.0,                       0.0,                          @IVAInteresPorcentaje --MEJORA10041
            FROM Cxc
           WHERE ID = @ID
          SELECT @AmortizacionID = SCOPE_IDENTITY()

          INSERT CxcD (
                  Sucursal,  ID,              Renglon, Aplica, AplicaID, Importe) 
          VALUES (@Sucursal, @AmortizacionID, 2048.0,  @Mov,   @MovID,   @Capital)

/*          IF @DesglosarImpuestos = 1
            SELECT @Impuestos = NULLIF(SUM(d.Importe*c.IVAFiscal*ISNULL(c.IEPSFiscal, 1)), 0)
              FROM CxcD d, Cxc c
             WHERE d.ID = @AmortizacionID AND c.Empresa = @Empresa AND c.Mov = d.Aplica AND c.MovID = d.AplicaID AND c.Estatus = 'PENDIENTE'     

          UPDATE Cxc SET Importe = @Capital - ISNULL(@Impuestos, 0.0), Impuestos = @Impuestos WHERE ID = @AmortizacionID
*/
          UPDATE TablaAmortizacion SET CxcID = @AmortizacionID WHERE CURRENT OF crCapital
        END ELSE
        BEGIN
          INSERT Cxp
                 (OrigenTipo, Origen, OrigenID, RamaID, Sucursal,  Empresa,  Mov,              FechaEmision, Condicion, Vencimiento, Referencia,  Importe,  Moneda, TipoCambio, Usuario,   Estatus,     UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio, AplicaManual, Concepto,  Proyecto,  UEN, TasaDiaria,  LineaCredito,  TipoAmortizacion,  TipoTasa,  TieneTasaEsp,  TasaEsp,  InteresesFijos,  InteresesFijosRetencion,  InteresesOrdinarios,  InteresesMoratorios,  SaldoInteresesOrdinarios,  SaldoInteresesOrdinariosIVA,  IVAInteresPorcentaje) --MEJORA10041
          SELECT  @Modulo,    @Mov,   @MovID,   @ID,    @Sucursal, @Empresa, @AmortizacionMov, @FechaD,      '(Fecha)', @FechaA,     @Referencia, @Capital, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, Proveedor, ProveedorMoneda, ProveedorTipoCambio, 1,            Concepto,  Proyecto,  UEN, @TasaDiaria, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @InteresesFijos, @InteresesFijosRetencion, @InteresesOrdinarios, @InteresesMoratorios, 0.0,                       0.0,                          @IVAInteresPorcentaje --MEJORA10041
            FROM Cxp
           WHERE ID = @ID
          SELECT @AmortizacionID = SCOPE_IDENTITY()

          INSERT CxpD (
                  Sucursal,  ID,              Renglon, Aplica, AplicaID, Importe) 
          VALUES (@Sucursal, @AmortizacionID, 2048.0,  @Mov,   @MovID,   @Capital)
          UPDATE TablaAmortizacion SET CxpID = @AmortizacionID WHERE CURRENT OF crCapital
        END

        IF @AmortizacionID IS NOT NULL AND @Ok IS NULL
        BEGIN
          EXEC spCx @AmortizacionID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @AmortizacionMov OUTPUT, @AmortizacionMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
          EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @AmortizacionID, @AmortizacionMov, @AmortizacionMovID, @Ok OUTPUT 

          IF @Migracion = 1 AND @Pendiente = 0 AND @Ok IS NULL
          BEGIN
            IF @Capital = 0.0
              UPDATE Cxc SET Estatus = 'CONCLUIDO' WHERE ID = @AmortizacionID
            ELSE BEGIN
              EXEC spCx @AmortizacionID, @Modulo, 'GENERAR', 'TODO', @FechaRegistro, @AjusteMov, @Usuario, 1, 0, @AmortizacionMov,  @AmortizacionMovID,  @AjusteID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
              UPDATE Cxc 
                 SET AplicaManual = 1, FechaEmision = ISNULL(@FechaCobro, FechaEmision)
               WHERE ID = @AjusteID

              DELETE CxcD WHERE ID = @AjusteID
              INSERT CxcD (
                     Sucursal,  ID,        Renglon, Aplica, AplicaID, Importe) 
              SELECT @Sucursal, @AjusteID, 2048.0,  Mov,    MovID,    Importe
                FROM Cxc
               WHERE ID = @AmortizacionID

              EXEC spCx @AjusteID,       @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL,       @Usuario, 1, 0, @AjusteMov OUTPUT, @AjusteMovID OUTPUT, NULL,             @Ok OUTPUT, @OkRef OUTPUT
            END
          END
        END
        
        IF @CobroIntereses = 'FIJOS' AND @Ok IS NULL AND @InteresesID IS NOT NULL --MEJORA10041
        BEGIN
          IF @Modulo = 'CXC'
          BEGIN
            --MEJORA10041
            INSERT CxcD (ID,           Sucursal,  Renglon,  Aplica,             AplicaID,           InteresesOrdinarios,       InteresesOrdinariosIVA) 
                 VALUES (@InteresesID, @Sucursal, @Renglon, @AmortizacionMov,   @AmortizacionMovID, @SaldoInteresesOrdinarios, @SaldoInteresesOrdinariosIVA) --MEJORA10041
          END ELSE
          BEGIN
            --MEJORA10041
            INSERT CxpD (ID,           Sucursal,  Renglon,  Aplica,             AplicaID,           InteresesOrdinarios,       InteresesOrdinariosIVA) 
                 VALUES (@InteresesID, @Sucursal, @Renglon, @AmortizacionMov,   @AmortizacionMovID, @SaldoInteresesOrdinarios, @SaldoInteresesOrdinariosIVA) --MEJORA10041        
          END
          SET @Renglon = @Renglon + 2048.0          
        END
              
      END
      FETCH NEXT FROM crCapital INTO @Amortizacion, @Capital, @Intereses, @IVAInteres, @IVAInteresPorcentaje, @Retencion, @FechaD, @FechaA --MEJORA10041
    END
    CLOSE crCapital
    DEALLOCATE crCapital

    IF @InteresesID IS NOT NULL AND @Ok IS NULL AND @CobroIntereses = 'FIJOS' --MEJORA10041
    BEGIN
      EXEC spCx @InteresesID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT        

      EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @InteresesID, @InteresesMov, @InteresesMovID, @Ok OUTPUT       
    END
    
    IF @GenerarCxpTotal = 1 AND @DisposicionCxpMov IS NOT NULL
    BEGIN
      SELECT @FechaOriginal = @FechaEmision
      SELECT @CxpImporte = Importe, @OrigenTipo = OrigenTipo, @Origen = Origen, @OrigenID = OrigenID FROM Cxc WHERE ID = @ID
      IF @OrigenTipo = 'VTAS'
        SELECT @FechaOriginal = MIN(FechaOriginal) FROM Venta WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('CONCLUIDO', 'PENDIENTE')
      INSERT Cxp
             (OrigenTipo, Origen, OrigenID, RamaID, Sucursal,  Empresa,  Mov,                FechaEmision,  Condicion, Vencimiento,                      Importe,     Moneda,   TipoCambio,   Usuario,   Estatus,     UltimoCambio,   Proveedor,   ProveedorSucursal,   ProveedorMoneda, ProveedorTipoCambio, Concepto,   Proyecto,    UEN)
      SELECT  @Modulo,    @Mov,   @MovID,   @ID,    @Sucursal, @Empresa, @DisposicionCxpMov, @FechaEmision, '(Fecha)', DATEADD(day, 30, @FechaOriginal), @CxpImporte, c.Moneda, c.TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, lc.Acreedor, lc.AcreedorSucursal, c.Moneda,        c.TipoCambio,        c.Concepto, c.Proyecto,  c.UEN
        FROM Cxc c
        JOIN LC ON lc.LineaCredito = c.LineaCredito
       WHERE ID = @ID
      SELECT @CxpID = SCOPE_IDENTITY()
      EXEC spCx @CxpID, 'CXP', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @CxpMov OUTPUT, @CxpMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
    END

    IF @CarteraVencidaCBNV = 1 AND @Modulo = 'CXC' AND @Ok IS NULL
    BEGIN
      UPDATE Cxc SET CarteraVencidaCNBV = 1 WHERE ID     = @ID AND CarteraVencidaCNBV = 0
      UPDATE Cxc SET CarteraVencidaCNBV = 1 WHERE RamaID = @ID AND CarteraVencidaCNBV = 0
    END
  END
  RETURN
END
GO


/**************** spLCGastoGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spLCGastoGenerar') and type = 'P') drop procedure dbo.spLCGastoGenerar
GO
CREATE PROCEDURE spLCGastoGenerar
			@Empresa		char(5),
    			@Sucursal		int,
			@Usuario		char(10),
			@Modulo			char(5),
			@ID			int,
			@Mov			char(20),
			@MovID			varchar(20),
    			@FechaEmision		datetime,
    		        @FechaRegistro		datetime,
			@Moneda			varchar(10),
			@TipoCambio		float,
			@ImporteTotal		money,
			@LineaCredito		varchar(20),
			@Acreedor		varchar(10),
    		    	@Ok             	int          = NULL OUTPUT,
    		    	@OkRef          	varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @GastoID	int,
    @GastoMov	varchar(20),
    @GastoMovID	varchar(20),
    @Condicion	varchar(50),
    @Renglon	float,
    @Concepto	varchar(50),
    @Porcentaje	float,
    @Importe	money,
    @Impuestos	float,
    @Referencia	varchar(50)

  SELECT @GastoMov = ACGasto FROM EmpresaCfgMov WHERE Empresa = @Empresa
  IF @Acreedor IS NULL SELECT @Ok = 40020
  SELECT @Condicion = Condicion FROM Prov WHERE Proveedor = @Acreedor
  INSERT Gasto (Sucursal,  Empresa,  Mov,       FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      UltimoCambio, Acreedor,  Condicion,  OrigenTipo, Origen, OrigenID, Prioridad)
        VALUES (@Sucursal, @Empresa, @GastoMov, @FechaEmision, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', GETDATE(),    @Acreedor, @Condicion, @Modulo,    @Mov,   @MovID,   'Normal')

  SELECT @GastoID = SCOPE_IDENTITY()

  SELECT @Renglon    = 0.0, 
         @Referencia = @Mov+' '+@MovID
      
  DECLARE crLCGasto CURSOR LOCAL FOR
   SELECT g.Concepto, NULLIF(g.Importe, 0.0), NULLIF(g.Porcentaje, 0.0), c.Impuestos
     FROM LCGasto g
     LEFT OUTER JOIN Concepto c ON c.Concepto = g.Concepto AND c.Modulo = 'GAS'
    WHERE g.LineaCredito = @LineaCredito
  OPEN crLCGasto
  FETCH NEXT FROM crLCGasto INTO @Concepto, @Importe, @Porcentaje, @Impuestos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Renglon = @Renglon + 2048.0
      IF @Porcentaje IS NOT NULL SELECT @Importe = @ImporteTotal * (@Porcentaje/100.0)

      INSERT GastoD (
             ID,       Sucursal,  Renglon,  Concepto,  Fecha,         Referencia,  Cantidad,  Precio,   Importe,  Impuestos )
      SELECT @GastoID, @Sucursal, @Renglon, @Concepto, @FechaEmision, @Referencia, 1,         @Importe, @Importe, @Importe*(@Impuestos/100.0)
    END
    FETCH NEXT FROM crLCGasto INTO @Concepto, @Importe, @Porcentaje, @Impuestos
  END 
  CLOSE crLCGasto
  DEALLOCATE crLCGasto

  IF EXISTS(SELECT * FROM GastoD WHERE ID = @GastoID)
  BEGIN
    EXEC spAfectar 'GAS', @GastoID, @Conexion = 1, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    SELECT @GastoMovID = MovID FROM Gasto WHERE ID = @GastoID
    EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, 'GAS', @GastoID, @GastoMov, @GastoMovID, @Ok OUTPUT
  END ELSE
    DELETE Gasto WHERE ID = @GastoID

  RETURN
END
GO


-- spTablaAmortizacion 'CXC', 242, 'UCCP'
-- spTablaAmortizacion 'VTAS', 2, 'UCCP'
-- spTablaAmortizacion 'CREDI', 1, 'DEMO'
/**************** spTablaAmortizacion ***************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacion') and type = 'P') drop procedure dbo.spTablaAmortizacion
GO             
CREATE PROCEDURE spTablaAmortizacion
			@Modulo				char(5),
			@ID					int,
			@Usuario			char(10),
			@Generar			bit	     = 0,
			@FechaRegistro		datetime     = NULL,
    		@Ok             	int          = NULL OUTPUT,
    		@OkRef          	varchar(255) = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Empresa		   char(5),
    @CfgPlazoDias	   varchar(20),	
    @ImpuestoPct	   float,
    @MinimoDias		   int,
    @Sucursal		   int,
    @Mov		   char(20),
    @MovID		   varchar(20),
    @FechaEmision	   datetime,
    @Vencimiento	   datetime,
    @LineaCredito     	   varchar(20),
    @TipoTasa	   	   varchar(20),
    @TieneTasaEsp	   bit,
    @TasaEsp		   float,
    @TipoAmortizacion 	   varchar(20),
    @Impuestos		   money,
    @ImporteTotal	   money,
    @TotalComisiones	   money,
    @Capital        	   money,
    @CapitalBase	   money,
    @InteresTotal      	   money,
    @Plazo                 int,
    @Periodo               int,
    @Amortizacion          int,
    @Amortizaciones        int,
    @PeriodoInicial        datetime,
    @PeriodoFinal          datetime,
    @Dias                  int,    
    @TasaDiaria            float,
    @SaldoCapital          money,
    @SaldoInicial          money,
    @SaldoIntereses        money,
    @SaldoFinal            money,
    @ImporteAmortizacion   money,
    @ImporteCapital        money,
    @ImporteIntereses      money,
    @ImporteImpuestos	   money,
    @ImporteRetencion	   money,
    @SaldoRetencion	   money,
    @Metodo	           int,
    @PagoInhabiles         varchar(20),        -- Posterior Habil/Anterior Habil
    @PagoVencimiento       varchar(20),        -- Fin de Mes/Dia Especifico/Dias
    @PagoDias              int,
    @PagoPromedio          money,
    @PeriodosGraciaCapital int, 
    @Uso		   varchar(20),
    @UltFecha              datetime,
    @FechaAmortizacion     datetime,
    @SumaCapital           money,
    @SumaImpuestos	   money,
    @Mensualidad           money,
    @Intereses             money,
    @InteresesAnticipados  money,
    @RecorrerVencimiento   int,
    @ComisionesFinanciadas bit,
    @RedondeoMonetarios    int,
    @Hoy		   datetime,
    @Guia		   bit,
    @Migracion		     bit,
    @MinistracionHipotecaria bit,
    @PorcentajeResidual      float,
    @MovBajaParcial	     char(20),
    @Referencia5	     varchar(50),
    @TieneImporteFijo	     bit,
    @ImporteFijo             money,
    @Acreedor		     varchar(10),
    @LCMoneda		     varchar(10),
    @Moneda		     varchar(10),
    @TipoCambio		     float,
    @TasaRetencion	     float,
    @ACCobroIntereses		varchar(20), --MEJORA10041 
    @Deudor					varchar(10), --MEJORA10041
    @Concepto				varchar(50), --MEJORA10041
    @Impuesto1				float,       --MEJORA10041
    @TipoImpuesto1			varchar(10), --MEJORA10041
    @MovTipo				varchar(20), --MEJORA10041
    @SubMovTipo				varchar(20), --MEJORA10041
    @ZonaImpuesto			varchar(30), --MEJORA10041
    @IVAInteres				float,       --MEJORA10041
    @IVAInteresPorcentaje	float        --MEJORA10041
    
  SELECT @Hoy = GETDATE(), @InteresesAnticipados = NULL, @Guia = 0, @Migracion = 0, @TieneTasaEsp = 0
  EXEC spExtraerFecha @Hoy OUTPUT

  IF EXISTS(SELECT * FROM TablaAmortizacionGuia WHERE Modulo = @Modulo AND ID = @ID)
    SELECT @Guia = 1
  IF EXISTS(SELECT * FROM TablaAmortizacionMigracion WHERE Modulo = @Modulo AND ID = @ID)
    SELECT @Migracion = 1

  IF @Modulo = 'VTAS'
  BEGIN
     SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @LineaCredito = LineaCredito, @TipoTasa = TipoTasa, @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = TasaEsp, @TipoAmortizacion = TipoAmortizacion, @TotalComisiones = ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0), @Deudor = Cliente, @Concepto = Concepto FROM Venta  WHERE ID = @ID --MEJORA10041
     SELECT @Impuestos = SUM(Impuestos), @ImporteTotal = SUM(ImporteTotal) FROM VentaTCalc WHERE ID = @ID
     
     --MEJORA10041
     SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --MEJORA10041       
     SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo      
     SELECT @ZonaImpuesto = ZonaImpuesto FROM Cte WHERE Cliente = @Deudor
     EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
     EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Deudor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT, @ConceptoMov = 1       
     
  END ELSE
  IF @Modulo = 'COMS' 
  BEGIN
    SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @LineaCredito = LineaCredito, @TipoTasa = TipoTasa, @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = TasaEsp, @TipoAmortizacion = TipoAmortizacion, @TotalComisiones = ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0), @Acreedor = Proveedor, @Concepto = Concepto FROM Compra WHERE ID = @ID --MEJORA10041
    SELECT @Impuestos = SUM(Impuestos), @ImporteTotal = SUM(ImporteTotal) FROM CompraTCalc WHERE ID = @ID

    --MEJORA10041    
    SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --MEJORA10041       
    SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo      
    SELECT @ZonaImpuesto = ZonaImpuesto FROM Prov WHERE Proveedor = @Acreedor
    EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
    EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Deudor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT, @ConceptoMov = 1       
     
  END ELSE
  IF @Modulo = 'CXC'
  BEGIN --MEJORA10041  
    SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @LineaCredito = LineaCredito, @TipoTasa = TipoTasa, @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = TasaEsp, @TipoAmortizacion = TipoAmortizacion, @Impuestos = ISNULL(Impuestos, 0.0), @ImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0) - ISNULL(Retencion, 0.0), @TotalComisiones = ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0), @Referencia5 = NULLIF(RTRIM(Referencia5), ''), @Deudor = Cliente, @Concepto = Concepto FROM Cxc    WHERE ID = @ID --MEJORA10041

    --MEJORA10041
    SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --MEJORA10041       
    SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo      
    SELECT @ZonaImpuesto = ZonaImpuesto FROM Cte WHERE Cliente = @Deudor
    EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
    EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Deudor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT

  END ELSE --MEJORA10041  
  IF @Modulo = 'CXP'
  BEGIN --MEJORA10041
    SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @LineaCredito = LineaCredito, @TipoTasa = TipoTasa, @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = TasaEsp, @TipoAmortizacion = TipoAmortizacion, @Impuestos = ISNULL(Impuestos, 0.0), @ImporteTotal = ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0) - ISNULL(Retencion, 0.0) - ISNULL(Retencion2, 0.0) - ISNULL(Retencion3, 0.0), @TotalComisiones = ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0), @Acreedor = Proveedor, @Concepto = Concepto FROM Cxp WHERE ID = @ID --MEJORA10041
    
    --MEJORA10041
    SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --MEJORA10041       
    SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo      
    SELECT @ZonaImpuesto = ZonaImpuesto FROM Prov WHERE Proveedor = @Acreedor
    EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
    EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Acreedor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT       
    
  END ELSE --MEJORA10041  
  IF @Modulo = 'CREDI'  
  BEGIN --MEJORA10041  
    SELECT @Moneda = Moneda, @TipoCambio = TipoCambio, @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @FechaEmision = FechaEmision, @Vencimiento = Vencimiento, @LineaCredito = LineaCredito, @TipoTasa = TipoTasa, @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = TasaEsp, @TipoAmortizacion = TipoAmortizacion, @Impuestos = 0.0, @ImporteTotal = ISNULL(Importe, 0.0), @TotalComisiones = ISNULL(Comisiones, 0.0)+ISNULL(ComisionesIVA, 0.0), @Deudor = Deudor, @Acreedor = Acreedor, @Concepto = Concepto FROM Credito WHERE ID = @ID
        
    --MEJORA10041
    SELECT @MovTipo = Clave, @SubMovTipo = SubClave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo --MEJORA10041       
    SELECT @Impuesto1 = Impuestos FROM Concepto WHERE Concepto = @Concepto AND Modulo = @Modulo      
    IF @MovTipo IN ('CREDI.FON','CREDI.DA','CFEDI.FOA')
    BEGIN
      SELECT @ZonaImpuesto = ZonaImpuesto FROM Cte WHERE Cliente = @Deudor
    	EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Acreedor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT 
    END  
    ELSE IF @MovTipo IN ('CFEDI.FEX','CREDI.FIN','CREDI.CES','CREDI.DIS','CREDI.BTB')  
    BEGIN
      SELECT @ZonaImpuesto = ZonaImpuesto FROM Prov WHERE Proveedor = @Acreedor
      EXEC spZonaImp @ZonaImpuesto, @Impuesto1 OUTPUT
      EXEC spTipoImpuesto @Modulo, @ID, @Mov, @FechaEmision, @Empresa, @Sucursal, @Deudor, @Concepto = @Concepto, @VerTipos = 0, @EnSilencio = 1, @Impuesto1 = @Impuesto1 OUTPUT, @TipoImpuesto1 = @TipoImpuesto1 OUTPUT 
    END
  END  

  --MEJORA10041
  SELECT @ACCobroIntereses = UPPER(ACCobroIntereses) FROM EmpresaCfg WHERE Empresa = @Empresa

  IF NULLIF(RTRIM(@TipoAmortizacion), '') IS NULL RETURN

--  SELECT @Hoy = @FechaEmision

  IF @Migracion = 0 AND (SELECT ACPermitirMovFechaAnterior FROM EmpresaCfg WHERE Empresa = @Empresa) = 0
    IF @Hoy>@FechaEmision OR (EXISTS(SELECT * FROM FechaTrabajo WHERE Empresa = @Empresa AND Sucursal = @Sucursal AND FechaTrabajo>@FechaEmision)) SELECT @Ok = 12010

  IF @Ok IS NOT NULL RETURN
   
  DELETE TablaAmortizacion WHERE Modulo = @Modulo AND ID = @ID

  SET DATEFIRST 7  
  SELECT @RedondeoMonetarios = RedondeoMonetarios FROM Version

  IF @Migracion = 0
  BEGIN
    SELECT @CfgPlazoDias = UPPER(ACPlazoDias)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa
  
    SELECT @ImpuestoPct = DefImpuesto
      FROM EmpresaGral
     WHERE Empresa = @Empresa

    SELECT @MovBajaParcial = ACBajaParcial
      FROM EmpresaCfgMov
     WHERE Empresa = @Empresa

    SELECT @Metodo	        = Metodo,
           @PagoInhabiles         = UPPER(PagoInhabiles),
           @PagoVencimiento       = UPPER(PagoVencimiento),
           @PagoDias              = NULLIF(PagoDias, 0),
           @ComisionesFinanciadas = ISNULL(ComisionesFinanciadas, 0)         
      FROM TipoAmortizacion
     WHERE TipoAmortizacion = @TipoAmortizacion

    SELECT @PeriodosGraciaCapital = ISNULL(PeriodosGraciaCapital, 0),
           @MinistracionHipotecaria = ISNULL(MinistracionHipotecaria, 0),
           @PorcentajeResidual = ISNULL(PorcentajeResidual, 0.0),
           @TieneImporteFijo = ISNULL(TieneImporteFijo, 0),
           @ImporteFijo = NULLIF(ImporteFijo, 0.0),
           @Uso = Uso,
           @Acreedor = NULLIF(RTRIM(Acreedor), ''),
           @LCMoneda = Moneda
      FROM LC
     WHERE LineaCredito = @LineaCredito

    IF @LCMoneda <> @Moneda SELECT @Ok = 30046, @OkRef = @LCMoneda
    IF (@MinistracionHipotecaria = 1 AND @Metodo <> 40) OR (@MinistracionHipotecaria = 0 AND @Metodo = 40)
      SELECT @Ok = 12020

    IF @Metodo = 40 RETURN

    EXEC xpPorcentajeResidual @Modulo, @ID, @PorcentajeResidual OUTPUT
    IF @Metodo <> 50 SELECT @PorcentajeResidual = 0.0

    SELECT @Capital = @ImporteTotal, @RecorrerVencimiento = 0
    IF @ComisionesFinanciadas = 1 
      SELECT @Capital = @Capital + @TotalComisiones

    IF @PagoInhabiles IN ('POSTERIOR HABIL', 'ANTERIOR HABIL')
    BEGIN
      IF @PagoInhabiles = 'ANTERIOR HABIL' SELECT @RecorrerVencimiento = -1 ELSE SELECT @RecorrerVencimiento = 1 
      SELECT @Vencimiento = dbo.fnChecarDiaHabil(@Vencimiento, @RecorrerVencimiento)
    END
    EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp, @TasaRetencion = @TasaRetencion OUTPUT

    IF @CfgPlazoDias = 'MESES 30'
      SELECT @Plazo = DATEDIFF(month, @FechaEmision, @Vencimiento)*30
    ELSE
      SELECT @Plazo = DATEDIFF(day, @FechaEmision, @Vencimiento)

    CREATE TABLE #TablaAmortizacion (
      ID									int             NOT NULL IDENTITY(1,1) PRIMARY KEY,
      Vencimiento							datetime        NULL,
      SaldoInicial							money		    NULL,
      Capital								money           NULL,
      Intereses								money           NULL,
      IVAInteresPorcentaje					float			NULL, --MEJORA10041
      IVAInteres							float           NULL, --MEJORA10041
      Retencion								money			NULL)

    IF @Guia = 1
    BEGIN
      SELECT @Metodo = 0
      SELECT @SumaCapital = ISNULL(SUM(Capital), 0.0)
        FROM TablaAmortizacionGuia 
       WHERE Modulo = @Modulo AND ID = @ID
 
      IF @Capital <> @SumaCapital
        UPDATE TablaAmortizacionGuia  
           SET Capital = ISNULL(Capital, 0.0) - (@SumaCapital - @Capital)
         WHERE Modulo = @Modulo AND ID = @ID AND Vencimiento = (SELECT MAX(Vencimiento) FROM TablaAmortizacionGuia WHERE Modulo = @Modulo AND ID = @ID)

      INSERT #TablaAmortizacion 
            (Vencimiento, Capital) 
      SELECT Vencimiento, Capital
        FROM TablaAmortizacionGuia 
       WHERE Modulo = @Modulo AND ID = @ID
    END ELSE 
    BEGIN
      -- Capital al Vencimiento
      IF @Metodo IN (20,21,22) INSERT #TablaAmortizacion (Vencimiento, Capital) VALUES (@Vencimiento, @Capital) 

      -- Plan de Pagos
      IF @Metodo IN (10,11,12,20,30,31,50)
      BEGIN
        IF @Metodo IN (50,30) SELECT @MinimoDias = 16 ELSE SELECT @MinimoDias = 1
        INSERT #TablaAmortizacion (Vencimiento) SELECT FechaA FROM dbo.fnProyectarFecha (@FechaEmision, @Vencimiento, @RecorrerVencimiento, @PagoVencimiento, @PagoDias, @MinimoDias, @TipoAmortizacion) ORDER BY Periodo
        SELECT @Amortizaciones = COUNT(*), @UltFecha = MAX(Vencimiento) FROM #TablaAmortizacion
      END
    END

    -- Pagos Iguales
    IF @Metodo IN (30,31,50)
    BEGIN
      IF @Metodo = 50
      BEGIN
        SELECT @CapitalBase = (@ImporteTotal - @Impuestos) * (1.0-(@PorcentajeResidual/100.0))
        IF @Mov = @MovBajaParcial AND @Referencia5 IS NOT NULL AND dbo.fnEsNumerico(@Referencia5) = 1
          SELECT @CapitalBase = CONVERT(money, @Referencia5)      
      END ELSE SELECT @CapitalBase = @Capital
      EXEC spPagosIgualesCalcTotal @Metodo, @CapitalBase, @TasaDiaria, @Plazo, @Amortizaciones, @ImporteAmortizacion OUTPUT, @InteresTotal OUTPUT

      SELECT @Amortizacion = 1, @SaldoCapital = @CapitalBase, @SaldoIntereses = @InteresTotal

      WHILE @Amortizacion <= @Amortizaciones
      BEGIN
        EXEC spPagosIgualesCalcAmortizacion @Metodo, @CapitalBase, @InteresTotal, @TasaDiaria, @Plazo, @Amortizaciones, @ImporteAmortizacion, @Amortizacion, @SaldoCapital OUTPUT, @SaldoIntereses OUTPUT, @ImporteCapital OUTPUT, @ImporteIntereses OUTPUT
        SELECT @ImporteRetencion = ROUND(@ImporteCapital*(@TasaRetencion/100.0)*@Plazo, @RedondeoMonetarios)
		IF @ACCobroIntereses = 'FIJOS' --MEJORA10041
		  SELECT @IVAInteres = ISNULL(@ImporteIntereses,0.0) * (ISNULL(@Impuesto1,0.0)/100.0), @IVAInteresPorcentaje = ISNULL(@Impuesto1,0.0) --MEJORA10041        
        ELSE --MEJORA10041
          SELECT @IVAInteres = NULL, @IVAInteresPorcentaje = ISNULL(@Impuesto1,0.0) --MEJORA10041
          
        UPDATE #TablaAmortizacion SET Capital = @ImporteCapital, Intereses = @ImporteIntereses, IVAInteres = @IVAInteres, IVAInteresPorcentaje = @IVAInteresPorcentaje, Retencion = @ImporteRetencion WHERE ID = @Amortizacion
        SELECT @Amortizacion = @Amortizacion + 1
      END
    END 

    -- Capital por Periodos
    IF @Metodo IN (10,11,12) AND ISNULL(@Amortizaciones, 0) > 0
    BEGIN
      IF @PeriodosGraciaCapital >= @Amortizaciones SELECT @PeriodosGraciaCapital = @Amortizaciones - 1
      UPDATE #TablaAmortizacion SET Capital = ROUND(@Capital/(@Amortizaciones-@PeriodosGraciaCapital), @RedondeoMonetarios) WHERE ID > @PeriodosGraciaCapital
      SELECT @SumaCapital = SUM(Capital) FROM #TablaAmortizacion
      IF @SumaCapital <> @Capital   
        UPDATE #TablaAmortizacion SET Capital = Capital + (@Capital-@SumaCapital) WHERE Vencimiento = @UltFecha
    END

    IF @Metodo NOT IN (30, 31)
    BEGIN
      SELECT @SaldoCapital =  @Capital, @SumaImpuestos = 0.0, @SaldoIntereses = 0.0, @SaldoRetencion = 0.0, @UltFecha = @FechaEmision
      DECLARE crIntereses CURSOR FOR 
       SELECT Vencimiento, ISNULL(Capital, 0.0) 
         FROM #TablaAmortizacion 
        ORDER BY Vencimiento
      OPEN crIntereses
      FETCH NEXT FROM crIntereses INTO @FechaAmortizacion, @ImporteCapital
      WHILE @@FETCH_STATUS <> -1 
      BEGIN
        IF @@FETCH_STATUS <> -2 
        BEGIN
          SELECT @Dias = DATEDIFF(day, @UltFecha, @FechaAmortizacion)
          SELECT @ImporteIntereses = ROUND(@SaldoCapital*(@TasaDiaria/100.0)*@Dias, @RedondeoMonetarios)
          SELECT @ImporteRetencion = ROUND(@SaldoCapital*(@TasaRetencion/100.0)*@Dias, @RedondeoMonetarios)
          IF @ACCobroIntereses = 'FIJOS' --MEJORA10041
            SELECT @IVAInteres = ISNULL(@ImporteIntereses,0.0) * (ISNULL(@Impuesto1,0.0)/100.0), @IVAInteresPorcentaje = ISNULL(@Impuesto1,0.0) --MEJORA10041        
          ELSE --MEJORA10041
            SELECT @IVAInteres = NULL, @IVAInteresPorcentaje = ISNULL(@Impuesto1,0.0) --MEJORA10041  

          IF @Metodo = 50
            UPDATE #TablaAmortizacion SET SaldoInicial = @SaldoCapital, Intereses = @ImporteIntereses, IVAInteres = @IVAInteres, IVAInteresPorcentaje = @IVAInteresPorcentaje, Retencion = @ImporteRetencion WHERE CURRENT OF crIntereses --MEJORA10041
          ELSE IF @Metodo IN (0, 10, 20, 50)
            UPDATE #TablaAmortizacion SET Intereses = @ImporteIntereses, IVAInteres = @IVAInteres, IVAInteresPorcentaje = @IVAInteresPorcentaje, Retencion = @ImporteRetencion WHERE CURRENT OF crIntereses --MEJORA10041
          ELSE
            SELECT @SaldoIntereses = @SaldoIntereses + @ImporteIntereses, @SaldoRetencion = @SaldoRetencion + @ImporteRetencion

          IF @Metodo = 50
          BEGIN
            SELECT @ImporteImpuestos = (@ImporteCapital + @ImporteIntereses) * (@ImpuestoPct/100.0)
            IF @SumaImpuestos + @ImporteImpuestos > @Impuestos SELECT @ImporteImpuestos = @Impuestos - @SumaImpuestos
            SELECT @SumaImpuestos = @SumaImpuestos + @ImporteImpuestos,
                   @SaldoCapital = @SaldoCapital - @ImporteCapital - @ImporteImpuestos
          END ELSE 
            SELECT @SaldoCapital = @SaldoCapital - @ImporteCapital

          SELECT @UltFecha = @FechaAmortizacion
        END
        FETCH NEXT FROM crIntereses INTO @FechaAmortizacion, @ImporteCapital
      END  -- While
      CLOSE crIntereses
      DEALLOCATE crIntereses

      IF @Metodo IN (11, 21) INSERT #TablaAmortizacion (Vencimiento, Intereses, Retencion) VALUES (@Vencimiento, @SaldoIntereses, @SaldoRetencion) ELSE
      IF @Metodo IN (12, 22) SELECT @InteresesAnticipados = @SaldoIntereses
    END

    SELECT @SaldoCapital =  @Capital, @UltFecha = @FechaEmision, @Periodo = 1
    DECLARE crTablaAmortizacion CURSOR FOR 
     SELECT Vencimiento, ISNULL(SUM(SaldoInicial), 0), ISNULL(SUM(Capital), 0), ISNULL(SUM(Intereses), 0), ISNULL(SUM(IVAInteres), 0.0), ISNULL(AVG(IVAInteresPorcentaje), 0.0), ISNULL(SUM(Retencion), 0) --MEJORA10041
       FROM #TablaAmortizacion 
      GROUP BY Vencimiento 
      ORDER BY Vencimiento

    OPEN crTablaAmortizacion
    FETCH NEXT FROM crTablaAmortizacion INTO @FechaAmortizacion, @SaldoInicial, @ImporteCapital, @ImporteIntereses, @IVAInteres, @IVAInteresPorcentaje, @ImporteRetencion --MEJORA10041
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 AND (ROUND(@ImporteCapital, 4)<>0.0 OR ROUND(@ImporteIntereses, 4)<>0.0)
      BEGIN
        IF @Metodo <> 50 SELECT @SaldoInicial = @SaldoCapital
        EXEC xpTablaAmortizacion @Modulo, @ID, @Periodo, @ImporteCapital OUTPUT, @ImporteIntereses OUTPUT, @SaldoInicial OUTPUT

        INSERT TablaAmortizacion
               (Modulo, ID,  Amortizacion, FechaD,    FechaA,             SaldoInicial,             Capital,                    Intereses,                    IVAInteres,              IVAInteresPorcentaje,              Retencion) --MEJORA10041
        SELECT @Modulo, @ID, @Periodo,     @UltFecha, @FechaAmortizacion, ISNULL(@SaldoInicial, 0), ISNULL(@ImporteCapital, 0), ISNULL(@ImporteIntereses, 0), ISNULL(@IVAInteres,0.0), ISNULL(@IVAInteresPorcentaje,0.0), ISNULL(@ImporteRetencion, 0) --MEJORA10041

        SELECT @Periodo = @Periodo + 1, @UltFecha = @FechaAmortizacion, @SaldoCapital = @SaldoCapital - @ImporteCapital
      END
      FETCH NEXT FROM crTablaAmortizacion INTO @FechaAmortizacion, @SaldoInicial, @ImporteCapital, @ImporteIntereses, @IVAInteres, @IVAInteresPorcentaje, @ImporteRetencion --MEJORA10041
    END  -- While
    CLOSE crTablaAmortizacion
    DEALLOCATE crTablaAmortizacion

    SELECT @Vencimiento = @UltFecha
    SELECT @Amortizaciones = @Periodo - 1
  END ELSE
  BEGIN
    INSERT TablaAmortizacion
          (Modulo, ID, Amortizacion, FechaD, FechaA, SaldoInicial, Capital, Intereses, IVAInteres, IVAInteresPorcentaje) --MEJORA10041
    SELECT Modulo, ID, Amortizacion, FechaD, FechaA, SaldoInicial, Capital, Intereses, IVAInteres, IVAInteresPorcentaje  --MEJORA10041
      FROM TablaAmortizacionMigracion
     WHERE Modulo = @Modulo AND ID = @ID

    SELECT @Amortizaciones = MAX(Amortizacion)
      FROM TablaAmortizacionMigracion
     WHERE Modulo = @Modulo AND ID = @ID
    SELECT @InteresesAnticipados = NULL
  END

  IF @Modulo = 'CXC' UPDATE Cxc SET Amortizaciones = @Amortizaciones, InteresesAnticipados = @InteresesAnticipados WHERE ID = @ID ELSE
  IF @Modulo = 'CXP' UPDATE Cxp SET Amortizaciones = @Amortizaciones, InteresesAnticipados = @InteresesAnticipados WHERE ID = @ID

  IF @Ok IS NULL AND @Generar = 1 
  BEGIN
    EXEC spTablaAmortizacionGenerar @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @TipoTasa, @TasaDiaria, @TieneTasaEsp, @TasaEsp, @TipoAmortizacion, @Amortizaciones, @LineaCredito, @Ok OUTPUT, @OkRef OUTPUT, @Migracion = @Migracion
    IF @Guia = 1 AND @ImporteFijo IS NOT NULL
      UPDATE LC SET TieneImporteFijo = 1 WHERE LineaCredito = @LineaCredito
    IF UPPER(@Uso) = 'FONDEO' AND @Acreedor IS NOT NULL AND EXISTS(SELECT * FROM LCGasto WHERE LineaCredito = @LineaCredito)
      EXEC spLCGastoGenerar @Empresa, @Sucursal, @Usuario, @Modulo, @ID, @Mov, @MovID, @FechaEmision, @FechaRegistro, @Moneda, @TipoCambio, @ImporteTotal, @LineaCredito, @Acreedor, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

/**************** spTablaAmortizacionEliminar ***************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacionEliminar') and type = 'P') drop procedure dbo.spTablaAmortizacionEliminar
GO             
CREATE PROCEDURE spTablaAmortizacionEliminar
			@Modulo			char(5),
			@ID			int
--//WITH ENCRYPTION
AS BEGIN
  DELETE TablaAmortizacionGuia WHERE Modulo = @Modulo AND ID = @ID
  RETURN
END
GO

-- spTablaAmortizacionSugerir 'VTAS', 81, 4000
/**************** spTablaAmortizacionSugerir ***************/
if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacionSugerir') and type = 'P') drop procedure dbo.spTablaAmortizacionSugerir
GO             
CREATE PROCEDURE spTablaAmortizacionSugerir
			@Modulo			char(5),
			@ID			int,
			@ImporteFijo		money = NULL
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @LineaCredito	varchar(20),
    @TipoTasa		varchar(20),
    @TasaDiaria		float,
    @SaldoInicial	money,
    @Capital		money,
    @CapitalAcum	money,
    @CapitalTotal	money,
    @Intereses		money,
    @Vencimiento	datetime,
    @UltVencimiento	datetime,
    @Dias		int

  EXEC spTablaAmortizacionEliminar @Modulo, @ID
  IF @ImporteFijo IS NULL
    INSERT TablaAmortizacionGuia
          (Modulo, ID, Vencimiento,  Capital)
    SELECT Modulo, ID, FechaA,       Capital
      FROM TablaAmortizacion
     WHERE Modulo = @Modulo AND ID = @ID
  ELSE BEGIN
    IF @Modulo = 'VTAS' SELECT @LineaCredito = LineaCredito, @TipoTasa = TipoTasa FROM Venta  WHERE ID = @ID ELSE
    IF @Modulo = 'COMS' SELECT @LineaCredito = LineaCredito, @TipoTasa = TipoTasa FROM Compra WHERE ID = @ID ELSE
    IF @Modulo = 'CXC'  SELECT @LineaCredito = LineaCredito, @TipoTasa = TipoTasa FROM Cxc    WHERE ID = @ID ELSE
    IF @Modulo = 'CXP'  SELECT @LineaCredito = LineaCredito, @TipoTasa = TipoTasa FROM Cxp    WHERE ID = @ID
    EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT

    SELECT @CapitalAcum = 0.0
    SELECT @CapitalTotal = SUM(Capital) FROM TablaAmortizacion WHERE Modulo = @Modulo AND ID = @ID
    SELECT @SaldoInicial = @CapitalTotal

    DECLARE crTablaAmortizacion CURSOR FOR 
     SELECT FechaA, DATEDIFF(day, FechaD, FechaA)
       FROM TablaAmortizacion 
      WHERE Modulo = @Modulo AND ID = @ID
      ORDER BY FechaA

    OPEN crTablaAmortizacion
    FETCH NEXT FROM crTablaAmortizacion INTO @Vencimiento, @Dias
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Intereses = @SaldoInicial * @Dias * (@TasaDiaria/100)
        SELECT @Capital = @ImporteFijo - @Intereses
        IF @CapitalAcum + @Capital > @CapitalTotal SELECT @Capital = @CapitalTotal - @CapitalAcum
        INSERT TablaAmortizacionGuia (Modulo, ID, Vencimiento, Capital)
        VALUES (@Modulo, @ID, @Vencimiento, @Capital)
        SELECT @CapitalAcum = @CapitalAcum + @Capital
        SELECT @UltVencimiento = @Vencimiento, @SaldoInicial = @SaldoInicial - @Capital
      END
      FETCH NEXT FROM crTablaAmortizacion INTO @Vencimiento, @Dias
    END  -- While
    CLOSE crTablaAmortizacion
    DEALLOCATE crTablaAmortizacion
    IF @CapitalAcum <> @CapitalTotal UPDATE TablaAmortizacionGuia SET Capital = ISNULL(Capital, 0.0) + @CapitalTotal - @CapitalAcum WHERE Modulo = @Modulo AND ID = @ID AND Vencimiento = @UltVencimiento
    UPDATE LC SET ImporteFijo = @ImporteFijo WHERE LineaCredito = @LineaCredito
  END
  RETURN
END
GO

/**************** spTablaAmortizacionAjustar ***************/
--if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacionAjustar') and type = 'P') drop procedure dbo.spTablaAmortizacionAjustar
GO             
/*CREATE PROCEDURE spTablaAmortizacionAjustar
			@Modulo			char(5),
			@ID			int,
			@Fecha			datetime,
 			@SaldoActual		money
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Amortizacion	int,
    @SaldoInicial	money,
    @Saldo		money,
    @Capital		money

  SELECT @Amortizacion = NULL, @SaldoInicial = NULL
  SELECT @SaldoInicial = SaldoInicial, @Amortizacion = Amortizacion FROM TablaAmortizacion WHERE Modulo = @Modulo AND ID = @ID AND @Fecha BETWEEN FechaD AND FechaA
  IF @Amortizacion IS NULL RETURN

  DECLARE crTablaAmortizacion CURSOR FOR 
   SELECT Capital
     FROM TablaAmortizacion
    WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion >= @Amortizacion

  SELECT @Saldo = @SaldoActual
  OPEN crTablaAmortizacion
  FETCH NEXT FROM crTablaAmortizacion INTO @Capital
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @Capital > @Saldo SELECT @Capital = @Saldo
    UPDATE TablaAmortizacion SET SaldoInicial = @Saldo, Capital = @Capital WHERE CURRENT OF crTablaAmortizacion
    SELECT @Saldo = @Saldo - @Capital
    FETCH NEXT FROM crTablaAmortizacion INTO @Capital
  END  -- While
  CLOSE crTablaAmortizacion
  DEALLOCATE crTablaAmortizacion

  RETURN
END*/
GO


/**************** spTablaAmortizacionIntereses ***************/
--if exists (select * from sysobjects where id = object_id('dbo.spTablaAmortizacionIntereses') and type = 'P') drop procedure dbo.spTablaAmortizacionIntereses
GO             
/*CREATE PROCEDURE spTablaAmortizacionIntereses
			@Modulo			char(5),
			@ID			int,
			@AmortizacioA		int,
			@Intereses		money	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @AmortizacionD	int

  SELECT @AmortizacionD = 0
  SELECT @AmortizacionD = ISNULL(MAX(Amortizacion), 0) 
    FROM TablaAmortizacion 
   WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion < @AmortizacionA AND ISNULL(LiquidarIntereses, 0) = 1

  IF @Modulo = 'CXC'
    SELECT @Intereses = SUM(ISNULL(c.Saldo, 0.0)*(ta.TasaDiaria/100.0)*DATEDIFF(day, ta.FechaD, ta.FechaA))
      FROM TablaAmortizacion ta
      JOIN Cxc c ON c.ID = ta.CapitalID AND c.Estatus = 'PENDIENTE'
     WHERE ta.Modulo = @Modulo AND ta.ID = @ID AND ta.Amortizacion > @AmortizacionD
  ELSE
    SELECT @Intereses = SUM(ISNULL(c.Saldo, 0.0)*(ta.TasaDiaria/100.0)*DATEDIFF(day, ta.FechaD, ta.FechaA))
      FROM TablaAmortizacion ta
      JOIN Cxp c ON c.ID = ta.CapitalID AND c.Estatus = 'PENDIENTE'
     WHERE ta.Modulo = @Modulo AND ta.ID = @ID AND ta.Amortizacion > @AmortizacionD

  SELECT @Intereses = ISNULL(@Intereses, 0.0)
  RETURN
END*/
GO


/**************** spACGenerarIntereses ****************/
--if exists (select * from sysobjects where id = object_id('dbo.spACGenerarIntereses') and type = 'P') drop procedure dbo.spACGenerarIntereses
GO
/*CREATE PROCEDURE spACGenerarIntereses
	           @Empresa		char(5),
		   @Sucursal		int,
        	   @Usuario		char(10),
    		   @Modulo		char(5),
		   @Hoy			datetime,
    		   @FechaRegistro	datetime,
		   @Conteo		int		OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @InteresesID	int,
    @InteresesMov	varchar(20),
    @InteresesMovID	varchar(20),
    @ID			int,
    @Mov		varchar(20),
    @MovID		varchar(20),
    @Referencia		varchar(50),
    @Amortizacion	int,
    @Amortizaciones	int,
    @SaldoInicial	money,
    @SaldoActual	money,
    @Capital		money,
    @Intereses		money,
    @Importe		money,
    @Impuestos		money,
    @FechaD		datetime,
    @FechaA		datetime, 
    @TasaDiaria		float,
    @TipoTasa		varchar(20),
    @EsTasaFija		bit,
    @LiquidarIntereses	bit,
    @ImpuestoIncluido	float

  SELECT @InteresesMov = CASE WHEN @Modulo = 'CXC' THEN CxcIntereses ELSE CxpIntereses END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Ok IS NULL
  BEGIN
    IF @Modulo = 'CXC'
      DECLARE crAmortizacion CURSOR FOR
       SELECT c.ID, c.Mov, c.MovID, c.TipoTasa, ta.TasaDiaria, ta.Amortizacion, c.Amortizaciones, NULLIF(ta.Capital, 0.0), ta.FechaD, ta.FechaA, ISNULL(ta.SaldoInicial, 0.0), ISNULL(c.Saldo, 0.0), ISNULL(ta.LiquidarIntereses, 0)
         FROM Cxc c
         JOIN TablaAmortizacion ta ON ta.Modulo = @Modulo AND ta.ID = c.ID AND ta.FechaD = @Hoy 
        WHERE c.Empresa = @Empresa
          AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO')
    ELSE
      DECLARE crAmortizacion CURSOR FOR
       SELECT c.ID, c.Mov, c.MovID, c.TipoTasa, ta.TasaDiaria, ta.Amortizacion, c.Amortizaciones, NULLIF(ta.Capital, 0.0), ta.FechaD, ta.FechaA, ISNULL(ta.SaldoInicial, 0.0), ISNULL(c.Saldo, 0.0), ISNULL(ta.LiquidarIntereses, 0)
         FROM Cxp c
         JOIN TablaAmortizacion ta ON ta.Modulo = @Modulo AND ta.ID = c.ID AND ta.FechaD = @Hoy 
        WHERE c.Empresa = @Empresa
          AND c.Estatus IN ('PENDIENTE', 'CONCLUIDO')
 
    OPEN crAmortizacion
    FETCH NEXT FROM crAmortizacion INTO @ID, @Mov, @MovID, @TipoTasa, @TasaDiaria, @Amortizacion, @Amortizaciones, @Capital, @FechaD, @FechaA, @SaldoInicial, @SaldoActual, @LiquidarIntereses
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        SELECT @InteresesID = NULL
        SELECT @EsTasaFija = ISNULL(EsTasaFija, 0) FROM TipoTasa WHERE TipoTasa = @TipoTasa
        SELECT @Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID) + ' ('+CONVERT(varchar, @Amortizacion)+'/'+CONVERT(varchar, @Amortizaciones)+')'

        IF @EsTasaFija = 0
        BEGIN
          EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT
          UPDATE TablaAmortizacion SET TasaDiaria = @TasaDiaria WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion >= @Amortizacion
          IF @Modulo = 'CXC' UPDATE Cxc SET TasaDiaria = @TasaDiaria WHERE ID IN (SELECT CapitalID FROM TablaAmortizacion WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion >= @Amortizacion) ELSE
          IF @Modulo = 'CXP' UPDATE Cxp SET TasaDiaria = @TasaDiaria WHERE ID IN (SELECT CapitalID FROM TablaAmortizacion WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion >= @Amortizacion) 
        END

	-- Cargar Intereses
        IF @LiquidarIntereses = 1
        BEGIN
          EXEC spTablaAmortizacionIntereses @Modulo, @ID, @Amortizacion, @Intereses OUTPUT
          SELECT @ImpuestoIncluido = NULL 
          SELECT @ImpuestoIncluido = NULLIF(ImpuestoIncluido, 0.0) FROM TipoTasa WHERE TipoTasa = @TipoTasa

          IF @ImpuestoIncluido IS NOT NULL
          BEGIN
            SELECT @Importe = ROUND(@Intereses/(1+(@ImpuestoIncluido/100.0)), 2)
            SELECT @Impuestos = @Intereses - @Importe
          END ELSE
            SELECT @Importe = @Intereses, @Impuestos = NULL
       
          IF NULLIF(@Importe, 0.0) IS NOT NULL
          BEGIN
            IF @Modulo = 'CXC' 
            BEGIN
              INSERT Cxc
                     (OrigenTipo, Origen, OrigenID, Sucursal,  Empresa,  Mov,           FechaEmision,  Condicion, Vencimiento, Referencia,  Importe,  Impuestos,  Moneda, TipoCambio, Usuario,   Estatus,     UltimoCambio,   Cliente, ClienteMoneda, ClienteTipoCambio, Concepto,  Proyecto,  UEN, TipoTasa)
              SELECT  @Modulo,    @Mov,   @MovID,   @Sucursal, @Empresa, @InteresesMov, @FechaD,       '(Fecha)', @FechaA,     @Referencia, @Importe, @Impuestos, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, Cliente, ClienteMoneda, ClienteTipoCambio, Concepto,  Proyecto,  UEN, @TipoTasa
                FROM Cxc
               WHERE ID = @ID
              SELECT @InteresesID = SCOPE_IDENTITY()
            END ELSE
            BEGIN
              INSERT Cxp
                     (OrigenTipo, Origen, OrigenID, Sucursal,  Empresa,  Mov,           FechaEmision,  Condicion, Vencimiento, Referencia,  Importe,  Impuestos,  Moneda, TipoCambio, Usuario,   Estatus,     UltimoCambio,   Proveedor, ProveedorMoneda, ProveedorTipoCambio, Concepto,  Proyecto,  UEN, TipoTasa)
              SELECT  @Modulo,    @Mov,   @MovID,   @Sucursal, @Empresa, @InteresesMov, @FechaD,       '(Fecha)', @FechaA,     @Referencia, @Importe, @Impuestos, Moneda, TipoCambio, @Usuario, 'SINAFECTAR', @FechaRegistro, Proveedor, ProveedorMoneda, ProveedorTipoCambio, Concepto,  Proyecto,  UEN, @TipoTasa
                FROM Cxp
               WHERE ID = @ID
              SELECT @InteresesID = SCOPE_IDENTITY()
            END

            IF @InteresesID IS NOT NULL AND @Ok IS NULL
            BEGIN
              EXEC spCx @InteresesID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
              EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, @Modulo, @ID, @Mov, @MovID, @Modulo, @InteresesID, @InteresesMov, @InteresesMovID, @Ok OUTPUT 
            END
          END

          UPDATE TablaAmortizacion SET InteresesID = @InteresesID WHERE Modulo = @Modulo AND ID = @ID AND Amortizacion = @Amortizacion
        END
      END
      FETCH NEXT FROM crAmortizacion INTO @ID, @Mov, @MovID, @TipoTasa, @TasaDiaria, @Amortizacion, @Amortizaciones, @Capital, @FechaD, @FechaA, @SaldoInicial, @SaldoActual, @LiquidarIntereses
    END
    CLOSE crAmortizacion
    DEALLOCATE crAmortizacion
  END
  RETURN
END*/
GO

/**************** spACReinversionAutomatica ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACReinversionAutomatica') and type = 'P') drop procedure dbo.spACReinversionAutomatica
GO
CREATE PROCEDURE spACReinversionAutomatica
	           @Empresa		char(5),
		   @Usuario		char(10),
    		   @Modulo		char(5),
		   @Hoy			datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @Conexion		bit = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RamaID             int,
    @ID             	int,
    @LineaCredito	varchar(20), 
    @TipoAmortizacion	varchar(20), 
    @TipoTasa		varchar(20), 
    @TieneTasaEsp	bit,
    @TasaEsp		float,
    @Condicion		varchar(50), 
    @Comisiones		money, 
    @ComisionesIVA	money,
    @ReinversionID	int,
    @ReinversionMov	char(20)

  SELECT @ReinversionMov = CASE @Modulo WHEN 'CXC' THEN ACReinversionCxc WHEN 'CXP' THEN ACReinversionCxp END FROM EmpresaCfgMov WHERE Empresa = @Empresa

  IF @Conexion = 0
    BEGIN TRANSACTION

  IF @Modulo = 'CXC'
    DECLARE crReinversionAutomatica CURSOR FOR
     SELECT c.RamaID, c.ID, c.LineaCredito, c.TipoAmortizacion, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.Condicion, c.Comisiones, c.ComisionesIVA
       FROM Cxc c
       JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion AND ta.ReinversionAutomatica = 1
      WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND ISNULL(c.Saldo, 0.0) > 0.0
        AND c.Vencimiento = @Hoy
  ELSE
  IF @Modulo = 'CXP'
    DECLARE crReinversionAutomatica CURSOR FOR
     SELECT c.RamaID, c.ID, c.LineaCredito, c.TipoAmortizacion, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.Condicion, c.Comisiones, c.ComisionesIVA
       FROM Cxp c
       JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion AND ta.ReinversionAutomatica = 1
      WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND ISNULL(c.Saldo, 0.0) > 0.0
        AND c.Vencimiento = @Hoy
 
  OPEN crReinversionAutomatica
  FETCH NEXT FROM crReinversionAutomatica INTO @RamaID, @ID, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Condicion, @Comisiones, @ComisionesIVA
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      EXEC @ReinversionID = spAfectar @Modulo, @ID, 'GENERAR','TODO', @ReinversionMov, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      IF @ReinversionID IS NOT NULL AND @Ok IS NULL
      BEGIN
        IF @Modulo = 'CXC' 
        BEGIN 
          SELECT @Condicion = Condicion FROM Cxc WHERE ID = @RamaID 
          UPDATE Cxc SET FechaEmision = @Hoy, LineaCredito = @LineaCredito, TipoAmortizacion = @TipoAmortizacion, TipoTasa = @TipoTasa, TieneTasaEsp = @TieneTasaEsp, TasaEsp = @TasaEsp, Condicion = @Condicion, Comisiones = @Comisiones, ComisionesIVA = @ComisionesIVA WHERE ID = @ReinversionID 
        END ELSE 
        IF @Modulo = 'CXP' 
        BEGIN 
          SELECT @Condicion = Condicion FROM Cxp WHERE ID = @RamaID 
          UPDATE Cxp SET FechaEmision = @Hoy, LineaCredito = @LineaCredito, TipoAmortizacion = @TipoAmortizacion, TipoTasa = @TipoTasa, TieneTasaEsp = @TieneTasaEsp, TasaEsp = @TasaEsp, Condicion = @Condicion, Comisiones = @Comisiones, ComisionesIVA = @ComisionesIVA WHERE ID = @ReinversionID 
        END

        EXEC xpACReinversionAutomatica @Modulo, @ReinversionID, @Ok OUTPUT, @OkRef OUTPUT
        EXEC spAfectar @Modulo, @ReinversionID, 'AFECTAR','TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
      END
    END
    FETCH NEXT FROM crReinversionAutomatica INTO @RamaID, @ID, @LineaCredito, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, @Condicion, @Comisiones, @ComisionesIVA
  END  -- While
  CLOSE crReinversionAutomatica
  DEALLOCATE crReinversionAutomatica

  IF @Conexion = 0
  BEGIN
    IF @Ok IS NULL
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
  END

  RETURN
END
GO


/**************** spACActualizarTasas ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACActualizarTasas') and type = 'P') drop procedure dbo.spACActualizarTasas
GO
CREATE PROCEDURE spACActualizarTasas
	           @Empresa		char(5),
    		   @Modulo		char(5),
		   @Hoy			datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TipoTasa		varchar(20),
    @TasaDiariaN 	float,
    @TasaDiariaA 	float,
    @RamaID             int

  IF @Modulo = 'CXC'
    DECLARE crActualizarTasas CURSOR FOR
     SELECT TipoTasa, TasaDiaria, RamaID
       FROM Cxc c
      WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' 
        AND c.FechaEmision = @Hoy+0 
        AND c.RamaID IS NOT NULL AND c.TipoTasa IS NOT NULL
        AND TieneTasaEsp = 0
  ELSE
    DECLARE crActualizarTasas CURSOR FOR
     SELECT TipoTasa, TasaDiaria
       FROM Cxp c
      WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' 
        AND c.FechaEmision = @Hoy+0 
        AND c.RamaID IS NOT NULL AND c.TipoTasa IS NOT NULL
        AND TieneTasaEsp = 0
 
  OPEN crActualizarTasas
  FETCH NEXT FROM crActualizarTasas INTO @TipoTasa, @TasaDiariaA, @RamaID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      EXEC spTipoTasa @TipoTasa, @TasaDiariaN OUTPUT
      IF @TasaDiariaN <> @TasaDiariaA
      BEGIN
        IF @Modulo = 'CXC'
          BEGIN
          --  UPDATE Cxc SET TasaDiaria = @TasaDiariaN WHERE CURRENT OF crActualizarTasas 
            UPDATE Cxc 
               SET InteresesFijos = dbo.fnR3 (TasaDiaria, InteresesFijos, @TasaDiariaN), 
                   TasaDiaria = @TasaDiariaN 
             WHERE RamaID  = @RamaID 
               AND Empresa = @Empresa 
               AND Estatus = 'PENDIENTE' 
               AND FechaEmision >= @Hoy 
               AND Vencimiento > @Hoy
          END
        ELSE
          UPDATE Cxp 
             SET InteresesFijos = dbo.fnR3 (TasaDiaria, InteresesFijos, @TasaDiariaN), 
                 InteresesFijosRetencion = dbo.fnR3 (TasaDiaria, InteresesFijosRetencion, @TasaDiariaN),  
                 TasaDiaria = @TasaDiariaN 
           WHERE RamaID  = @RamaID 
             AND Empresa = @Empresa 
             AND Estatus = 'PENDIENTE' 
             AND FechaEmision >= @Hoy 
             AND Vencimiento > @Hoy 
      END
    END
    FETCH NEXT FROM crActualizarTasas INTO @TipoTasa, @TasaDiariaA, @RamaID
  END  -- While
  CLOSE crActualizarTasas
  DEALLOCATE crActualizarTasas
  RETURN
END
GO

/**************** spACDevengarIntereses ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACDevengarIntereses') and type = 'P') drop procedure dbo.spACDevengarIntereses
GO
CREATE PROCEDURE spACDevengarIntereses
	           @Empresa		char(5),
		   @Sucursal		int,
        	   @Usuario		char(10),
    		   @Modulo		char(5),
		   @Hoy			datetime,
    		   @FechaRegistro	datetime,
		   @Vencidos		bit,
		   @Conteo		int		OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @InteresesID		int,
    @InteresesMov		varchar(20),
    @InteresesMovID		varchar(20),
    @Moneda			char(10),
    @TipoCambio			float,
    @RamaID			int,
    @ID				int,
    @Mov			varchar(20),
    @MovID			varchar(20),
    @Contacto			char(10),
    @Ordinarios			money,
    @Saldo			money,
    @Moratorios			money,
    @MoratoriosFactor		float,
    @InteresesFijos		money,
    @InteresesAcumulados	money,
    @Metodo			int,
    @TasaDiaria			float,
    @SumaIntereses		money,
    @Renglon			float,
    @FactorMes			float,
    @Retencion			money,
    @RamaEmision		datetime,
    @DiasIntereses		float,
    @Inflacion			float, --MEJORA10041
    @AcCobroIntereses					varchar(20), --MEJORA10041
    @AcConsiderarInflacionIVA			bit, --MEJORA10041
    @AcMonedaCalculoInflacionIVA		varchar(10), --MEJORA10041
    @CobroIntereses						varchar(20), --MEJORA10041
    @TipoTasa							varchar(20), --MEJORA10041
    @TieneTasaEsp						bit, --MEJORA10041
    @TasaEsp							float, --MEJORA10041							
    @IVAInteresPorcentaje				float, --MEJORA10041
    @InteresIVAImporte					float --MEJORA10041

  EXEC xpACDevengarInteresesFactorMes @Hoy, @FactorMes OUTPUT
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  SELECT --MEJORA10041
    @AcCobroIntereses = UPPER(RTRIM(ISNULL(ACCobroIntereses,''))),
    @ACConsiderarInflacionIVA = ISNULL(ACConsiderarInflacionIVA,0),
    @ACMonedaCalculoInflacionIVA = NULLIF(LTRIM(RTRIM(ACMonedaCalculoInflacionIVA)),'')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 

  IF @ACConsiderarInflacionIVA = 1 --MEJORA10041
  BEGIN
    SELECT @Inflacion = dbo.fnInflacionActualDiaria(@Empresa, @Sucursal)
      
    IF @Inflacion = -1.0
    BEGIN
      SELECT @Ok = 30075, @OkRef = dbo.fnIdiomaTraducir(@Usuario,'Verifique la moneda utilizada para el cálculo de inflación.')
      RETURN    
    END
  END ELSE
  BEGIN
    SELECT @Inflacion = 0.0
  END  

  SELECT @Contacto = CASE WHEN @Modulo = 'CXC' THEN ACClienteDevengados ELSE ACProveedorDevengados END
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC' AND @Vencidos = 1
    SELECT @InteresesMov = CxcInteresesVencidos FROM EmpresaCfgMov WHERE Empresa = @Empresa
  ELSE
  IF @Modulo = 'CXC' AND @Vencidos = 0
    SELECT @InteresesMov = CxcIntereses FROM EmpresaCfgMov WHERE Empresa = @Empresa
  ELSE
  IF @Modulo = 'CXP' AND @Vencidos = 0 --MEJORA10015
    SELECT @InteresesMov = CxpIntereses FROM EmpresaCfgMov WHERE Empresa = @Empresa
  ELSE --MEJORA10015 
  IF @Modulo = 'CXP' AND @Vencidos = 1
    SELECT @InteresesMov = CxpInteresMoratorio FROM EmpresaCfgMovCxp WHERE Empresa = @Empresa --MEJORA10015

  -- Cancelar Anterior
  SELECT @InteresesID = NULL
  IF @Modulo = 'CXC'
    SELECT @InteresesID = ID FROM Cxc WHERE Empresa = @Empresa AND Mov = @InteresesMov AND FechaEmision = @Hoy AND Moneda = @Moneda AND Estatus IN ('CONCLUIDO', 'PENDIENTE') AND ISNULL(EsInteresFijo,0) = 0
  ELSE
    SELECT @InteresesID = ID FROM Cxp WHERE Empresa = @Empresa AND Mov = @InteresesMov AND FechaEmision = @Hoy AND Moneda = @Moneda AND Estatus IN ('CONCLUIDO', 'PENDIENTE') AND ISNULL(EsInteresFijo,0) = 0
  IF @InteresesID IS NOT NULL
    EXEC spCx @InteresesID, @Modulo, 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Modulo = 'CXC'
    INSERT Cxc (Sucursal,  Empresa,  Mov,           FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,   ClienteMoneda, ClienteTipoCambio)
        VALUES (@Sucursal, @Empresa, @InteresesMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,       @TipoCambio)
  ELSE
    INSERT Cxp (Sucursal,  Empresa,  Mov,           FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Proveedor, ProveedorMoneda, ProveedorTipoCambio)
        VALUES (@Sucursal, @Empresa, @InteresesMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,         @TipoCambio)

  SELECT @InteresesID = SCOPE_IDENTITY()

  SELECT @Renglon = 0.0, @SumaIntereses = 0.0
  IF @InteresesID IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF @Vencidos = 0 --MEJORA10015
    BEGIN
      -- Intereses Ordinarios
      IF @Modulo = 'CXC'
        DECLARE crInteresesOrdinarios CURSOR FOR
         SELECT c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje, SUM(c.Saldo*(c.TasaDiaria/100.0)*c.TipoCambio), SUM(c.Saldo*c.TipoCambio) --MEJORA10041
           FROM Cxc c
           JOIN Cxc r ON r.ID = c.RamaID AND r.CarteraVencidaCNBV = @Vencidos
           JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion AND ta.Metodo <> 50
           JOIN LC ON lc.LineaCredito = r.LineaCredito AND lc.MinistracionHipotecaria = 0 --AND UPPER(lc.CobroIntereses) = 'DEVENGADOS'
          WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Vencimiento > @Hoy AND r.FechaEmision <= @Hoy
          GROUP BY c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje --MEJORA10041
          ORDER BY c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje --MEJORA10041
      ELSE
        DECLARE crInteresesOrdinarios CURSOR FOR
         SELECT c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje, SUM(c.Saldo*(c.TasaDiaria/100.0)*c.TipoCambio), SUM(c.Saldo*c.TipoCambio) --MEJORA10041
           FROM Cxp c
           JOIN Cxp r ON r.ID = c.RamaID 
           JOIN LC ON lc.LineaCredito = r.LineaCredito --MEJORA10041
          WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Vencimiento > @Hoy AND r.FechaEmision <= @Hoy
          GROUP BY c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje --MEJORA10041
          ORDER BY c.RamaID, r.FechaEmision, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje --MEJORA10041

      OPEN crInteresesOrdinarios
      FETCH NEXT FROM crInteresesOrdinarios INTO @RamaID, @RamaEmision, @CobroIntereses, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje, @Ordinarios, @Saldo --MEJORA10041
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN                         
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
         IF @Modulo = 'CXC'
           SELECT @Retencion = @Saldo*(t.RetencionPuntos/360.0/100.0)
             FROM Cxc c
             JOIN TipoTasa t ON t.TipoTasa = c.TipoTasa
            WHERE c.ID = @RamaID
         ELSE
           SELECT @Retencion = @Saldo*(t.RetencionPuntos/360.0/100.0)
             FROM Cxp c
             JOIN TipoTasa t ON t.TipoTasa = c.TipoTasa
            WHERE c.ID = @RamaID

         IF @RamaID IS NOT NULL AND ISNULL(@Ordinarios, 0.0) <> 0.0 
          BEGIN
            SELECT @ID = NULL, @InteresesAcumulados = NULL
            IF @Modulo = 'CXC'
            BEGIN
              SELECT @InteresesAcumulados = SUM(InteresesOrdinarios) FROM Cxc WHERE RamaID  = @RamaID
              SELECT @ID = MAX(ID) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' AND @Hoy BETWEEN FechaEmision AND Vencimiento-1
              IF @ID IS NULL
                SELECT @ID = MIN(ID) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' 
            END ELSE
            BEGIN
              SELECT @InteresesAcumulados = SUM(InteresesOrdinarios) FROM Cxp WHERE RamaID  = @RamaID
              SELECT @ID = MAX(ID) FROM Cxp WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' AND @Hoy BETWEEN FechaEmision AND Vencimiento-1
              IF @ID IS NULL
                SELECT @ID = MIN(ID) FROM Cxp WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' 
            END

           IF NULLIF(@InteresesAcumulados, 0.0) IS NULL
             SELECT @DiasIntereses = DATEDIFF(day, @RamaEmision, @Hoy) + 1.0
           ELSE
             SELECT @DiasIntereses = 1.0

           SELECT @Ordinarios = @Ordinarios * @FactorMes * @DiasIntereses

           IF UPPER(@CobroIntereses) = 'DEVENGADOS' --MEJORA10041
           BEGIN
             SET @InteresIVAImporte = dbo.fnInteresIVAImporte(@TipoTasa, @TieneTasaEsp, @TasaEsp, @Inflacion, @Ordinarios, @IVAInteresPorcentaje, 0.0, 0)            
           END ELSE
             SELECT @InteresIVAImporte = NULL, @Ordinarios = NULL
             
            SELECT @Renglon = @Renglon + 2048.0, @SumaIntereses = @SumaIntereses + ISNULL(@Ordinarios, 0.0)
            IF @Modulo = 'CXC' AND @Ordinarios IS NOT NULL --MEJORA10041
              INSERT CxcD (ID,          Sucursal,  Renglon,  Aplica, AplicaID, InteresesOrdinarios,      Retencion,               InteresesOrdinariosIVA) --MEJORA10041
                   SELECT @InteresesID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@Ordinarios, 0.0), NULLIF(@Retencion, 0.0), @InteresIVAImporte --MEJORA10041
                     FROM Cxc
                    WHERE ID = @ID
            ELSE IF @Modulo = 'CXP' AND @Ordinarios IS NOT NULL --MEJORA10041
              INSERT CxpD (ID,          Sucursal,  Renglon,  Aplica, AplicaID, InteresesOrdinarios,      Retencion,               InteresesOrdinariosIVA) --MEJORA10041
                   SELECT @InteresesID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@Ordinarios, 0.0), NULLIF(@Retencion, 0.0), @InteresIVAImporte --MEJORA10041
                     FROM Cxp
                    WHERE ID = @ID
          END
          EXEC xpACDevengarInteresesOrdinarios @Modulo, @ID, @Ordinarios OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

        END
        FETCH NEXT FROM crInteresesOrdinarios INTO @RamaID, @RamaEmision, @CobroIntereses, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje, @Ordinarios, @Saldo --MEJORA10041
      END  -- While
      CLOSE crInteresesOrdinarios
      DEALLOCATE crInteresesOrdinarios
    END
    
    -- Intereses Arrendamiento
    IF @Modulo = 'CXC' AND @Vencidos = 0
    BEGIN
      DECLARE crInteresesArrendamiento CURSOR FOR
       SELECT c.ID, c.InteresesFijos/NULLIF(DATEDIFF(day, c.FechaEmision, c.Vencimiento), 0)
         FROM Cxc c
         JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion AND ta.Metodo = 50
         JOIN LC ON lc.LineaCredito = c.LineaCredito AND lc.MinistracionHipotecaria = 0 AND UPPER(lc.CobroIntereses) = 'DEVENGADOS'
        WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND @Hoy BETWEEN c.FechaEmision AND c.Vencimiento
 
      OPEN crInteresesArrendamiento
      FETCH NEXT FROM crInteresesArrendamiento INTO @ID, @Ordinarios
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN                         
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          SELECT @Ordinarios = @Ordinarios * @FactorMes
          EXEC xpACDevengarInteresesArrendamiento @Modulo, @ID, @Ordinarios OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF ISNULL(@Ordinarios, 0.0) <> 0.0 
          BEGIN
            SELECT @Renglon = @Renglon + 2048.0, @SumaIntereses = @SumaIntereses + ISNULL(@Ordinarios, 0.0)
            INSERT CxcD (ID,          Sucursal,  Renglon,  Aplica, AplicaID, InteresesOrdinarios)  
                 SELECT @InteresesID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@Ordinarios, 0.0)
                   FROM Cxc
                  WHERE ID = @ID
          END
        END
        FETCH NEXT FROM crInteresesArrendamiento INTO @ID, @Ordinarios
      END  -- While
      CLOSE crInteresesArrendamiento
      DEALLOCATE crInteresesArrendamiento
    END

    --IF @Vencidos = 0 --MEJORA10015
    IF @Vencidos = 1 --MEJORA10015
    BEGIN
      -- Intereses Moratorios
      IF @Modulo = 'CXC'
        DECLARE crInteresesMoratorios CURSOR FOR
         SELECT c.ID, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje, c.Saldo*c.TipoCambio, c.InteresesFijos*c.TipoCambio, c.TasaDiaria, tt.MoratoriosFactor, ta.Metodo --MEJORA10041
           FROM Cxc c
           JOIN TipoTasa tt ON tt.TipoTasa = c.TipoTasa
           JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion
           JOIN LC ON lc.LineaCredito = c.LineaCredito AND lc.MinistracionHipotecaria = 0
          WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Vencimiento <= @Hoy
      ELSE
        DECLARE crInteresesMoratorios CURSOR FOR
         SELECT c.ID, lc.CobroIntereses, c.TipoTasa, c.TieneTasaEsp, c.TasaEsp, c.IVAInteresPorcentaje, c.Saldo*c.TipoCambio, c.InteresesFijos*c.TipoCambio, c.TasaDiaria, tt.MoratoriosFactor, ta.Metodo --MEJORA10041
           FROM Cxp c
           JOIN TipoTasa tt ON tt.TipoTasa = c.TipoTasa
           JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion
           JOIN LC ON lc.LineaCredito = c.LineaCredito --MEJORA10041
          WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Vencimiento <= @Hoy
 
      OPEN crInteresesMoratorios
      FETCH NEXT FROM crInteresesMoratorios INTO @ID, @CobroIntereses, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje, @Saldo, @InteresesFijos, @TasaDiaria, @MoratoriosFactor, @Metodo --MEJORA10041
      WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
      BEGIN                         
        IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
        BEGIN
          /*IF @Metodo = 50*/
            SELECT @Moratorios = (ISNULL(@Saldo, 0.0)+ISNULL(@InteresesFijos, 0.0))*(@TasaDiaria/100.0)*@MoratoriosFactor
          /*ELSE
            SELECT @Moratorios = @Saldo*(@TasaDiaria/100.0)*@MoratoriosFactor*/

          SELECT @Moratorios = @Moratorios * @FactorMes
          EXEC xpACDevengarInteresesMoratorios @Modulo, @ID, @Moratorios OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
          IF @ID IS NOT NULL AND ISNULL(@Moratorios, 0.0) <> 0.0
          BEGIN
             IF UPPER(@CobroIntereses) = 'DEVENGADOS' --MEJORA10041
             BEGIN
               SET @InteresIVAImporte = dbo.fnInteresIVAImporte(@TipoTasa, @TieneTasaEsp, @TasaEsp, @Inflacion, @Moratorios, @IVAInteresPorcentaje, 0.0, 0)            
             END ELSE
               SET @InteresIVAImporte = NULL
                    
            SELECT @Renglon = @Renglon + 2048.0, @SumaIntereses = @SumaIntereses + ISNULL(@Moratorios, 0.0)
            IF @Modulo = 'CXC'          
              INSERT CxcD (ID,          Sucursal,  Renglon,  Aplica, AplicaID, InteresesMoratorios,      InteresesMoratoriosIVA) --MEJORA10041
                   SELECT @InteresesID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@Moratorios, 0.0), @InteresIVAImporte --MEJORA10041
                     FROM Cxc
                    WHERE ID = @ID
            ELSE
              INSERT CxpD (ID,          Sucursal,  Renglon,  Aplica, AplicaID, InteresesMoratorios,      InteresesMoratoriosIVA) --MEJORA10041
                   SELECT @InteresesID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@Moratorios, 0.0), @InteresIVAImporte --MEJORA10041
                     FROM Cxp
                    WHERE ID = @ID
          END
        END
        FETCH NEXT FROM crInteresesMoratorios INTO @ID, @CobroIntereses, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje, @Saldo, @InteresesFijos, @TasaDiaria, @MoratoriosFactor, @Metodo --MEJORA10041
      END  -- While
      CLOSE crInteresesMoratorios
      DEALLOCATE crInteresesMoratorios
    END

    IF @Modulo = 'CXC'
    BEGIN
      IF EXISTS(SELECT * FROM CxcD WHERE ID = @InteresesID)
        UPDATE Cxc SET Importe = @SumaIntereses WHERE ID = @InteresesID
      ELSE 
      BEGIN
        DELETE Cxc WHERE ID = @InteresesID
        SELECT @InteresesID = NULL
      END
    END ELSE
    BEGIN
      IF EXISTS(SELECT * FROM CxpD WHERE ID = @InteresesID)
        UPDATE Cxp SET Importe = @SumaIntereses WHERE ID = @InteresesID
      ELSE 
      BEGIN
        DELETE Cxp WHERE ID = @InteresesID
        SELECT @InteresesID = NULL
      END
    END

    IF @InteresesID IS NOT NULL
      EXEC spCx @InteresesID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
  END
  RETURN
END
GO

-- update fechatrabajo set fechatrabajo= '13/08/2012'
-- spCerrarDia 'DEMO', 0, '14/08/2012', 'DEMO', @Debug = 1

/**************** spACIVADescontarInflacion ****************/ --MEJORA10041
if exists (select * from sysobjects where id = object_id('dbo.spACIVADescontarInflacion') and type = 'P') drop procedure dbo.spACIVADescontarInflacion
GO
CREATE PROCEDURE spACIVADescontarInflacion
			@Empresa		char(5),
			@Sucursal		int,
			@Usuario		char(10),
			@Modulo		char(5),
			@Hoy			datetime,
			@FechaRegistro	datetime,
			@Conteo		int		OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DescuentoInflacionID		int,
    @DescuentoInflacionMov		varchar(20),
    @DescuentoInflacionMovID	varchar(20),
    @Moneda						char(10),
    @TipoCambio					float,
    @RamaID						int,
    @ID							int,
    @Mov						varchar(20),
    @MovID						varchar(20),
    @Contacto					char(10),
    @Ordinarios					float,
    @Saldo						float,
    @Moratorios					float,
    @MoratoriosFactor			float,
    @InteresesFijos				float,
    @InteresesAcumulados		float,
    @Metodo						int,
    @TasaDiaria					float,
    @SumaInflacion				float,
    @Renglon					float,
    @FactorMes					float,
    @Retencion					float,
    @RamaEmision				datetime,
	@ImporteInflacion			float,
	@TipoTasa					varchar(20),
	@TieneTasaEsp				bit, 
	@TasaEsp					float,
	@Inflacion					float,
	@IvaInteresPorcentaje		float,
	@DiasInflacion				float

  EXEC xpACDevengarInteresesFactorMes @Hoy, @FactorMes OUTPUT
  
  SELECT @Inflacion = dbo.fnInflacionActualDiaria(@Empresa, @Sucursal) 
  IF @Inflacion = -1.0 
  BEGIN
    SELECT @Ok = 30075, @OkRef = dbo.fnIdiomaTraducir(@Usuario,'Verifique la moneda utilizada para el cálculo de inflación.')
    RETURN
  END  
  
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg JOIN Mon m
      ON m.Moneda = cfg.ContMoneda
   WHERE cfg.Empresa = @Empresa 

  SELECT @Contacto = CASE WHEN @Modulo = 'CXC' THEN ACClienteDevengados ELSE ACProveedorDevengados END
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  IF @Modulo = 'CXC' SELECT @DescuentoInflacionMov = CxcDescuentoInflacion FROM EmpresaCfgMovCxc WHERE Empresa = @Empresa ELSE
  IF @Modulo = 'CXP' SELECT @DescuentoInflacionMov = CxpDescuentoInflacion FROM EmpresaCfgMovCxp WHERE Empresa = @Empresa

  -- Cancelar Anterior
  SELECT @DescuentoInflacionID = NULL
  IF @Modulo = 'CXC'
    SELECT @DescuentoInflacionID = ID FROM Cxc WHERE Empresa = @Empresa AND Mov = @DescuentoInflacionMov AND FechaEmision = @Hoy AND Moneda = @Moneda AND Estatus IN ('CONCLUIDO')
  ELSE
    SELECT @DescuentoInflacionID = ID FROM Cxp WHERE Empresa = @Empresa AND Mov = @DescuentoInflacionMov AND FechaEmision = @Hoy AND Moneda = @Moneda AND Estatus IN ('CONCLUIDO')

  IF @DescuentoInflacionID IS NOT NULL
    EXEC spCx @DescuentoInflacionID, @Modulo, 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @DescuentoInflacionMov OUTPUT, @DescuentoInflacionMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
  
  IF @Modulo = 'CXC'
    INSERT Cxc (Sucursal,  Empresa,  Mov,                    FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,   ClienteMoneda, ClienteTipoCambio)
        VALUES (@Sucursal, @Empresa, @DescuentoInflacionMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,       @TipoCambio)
  ELSE
    INSERT Cxp (Sucursal,  Empresa,  Mov,           FechaEmision,  Moneda,  TipoCambio,  Usuario,  Estatus,      Proveedor, ProveedorMoneda, ProveedorTipoCambio)
        VALUES (@Sucursal, @Empresa, @DescuentoInflacionMov, @Hoy,          @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Contacto, @Moneda,         @TipoCambio)

  SELECT @DescuentoInflacionID = SCOPE_IDENTITY()

  SELECT @Renglon = 0.0, @SumaInflacion = 0.0
  IF @DescuentoInflacionID IS NOT NULL AND @Ok IS NULL
  BEGIN
    IF @Modulo = 'CXC'
      DECLARE crInflacion CURSOR FOR
       SELECT c.RamaID, r.FechaEmision, SUM(c.Saldo*(c.TasaDiaria/100.0)*c.TipoCambio), SUM(c.Saldo*c.TipoCambio), ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)
         FROM Cxc c
         JOIN Cxc r ON r.ID = c.RamaID AND r.CarteraVencidaCNBV = 0
         JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = c.TipoAmortizacion AND ta.Metodo <> 50
         JOIN LC ON lc.LineaCredito = r.LineaCredito AND lc.MinistracionHipotecaria = 0 --AND UPPER(lc.CobroIntereses) = 'DEVENGADOS'
        WHERE c.Empresa = @Empresa 
          AND c.Estatus = 'PENDIENTE' 
          AND c.Vencimiento > @Hoy 
          AND r.FechaEmision <= @Hoy
          AND lc.CobroIntereses = 'FIJOS'
        GROUP BY c.RamaID, r.FechaEmision, ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)
        ORDER BY c.RamaID, r.FechaEmision, ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)
    ELSE
      DECLARE crInflacion CURSOR FOR
       SELECT c.RamaID, r.FechaEmision, SUM(c.Saldo*(c.TasaDiaria/100.0)*c.TipoCambio), SUM(c.Saldo*c.TipoCambio), ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)
         FROM Cxp c
         JOIN Cxp r ON r.ID = c.RamaID 
         JOIN LC ON lc.LineaCredito = r.LineaCredito
        WHERE c.Empresa = @Empresa 
          AND c.Estatus = 'PENDIENTE' 
          AND c.Vencimiento > @Hoy 
          AND r.FechaEmision <= @Hoy
          AND lc.CobroIntereses = 'FIJOS'
        GROUP BY c.RamaID, r.FechaEmision, ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)
        ORDER BY c.RamaID, r.FechaEmision, ISNULL(c.TipoTasa,''), ISNULL(c.TieneTasaEsp,0), ISNULL(c.TasaEsp,0.0), ISNULL(c.IVAInteresPorcentaje,0.0)

    OPEN crInflacion
    FETCH NEXT FROM crInflacion INTO @RamaID, @RamaEmision, @Ordinarios, @Saldo, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
      BEGIN
        IF @RamaID IS NOT NULL AND ISNULL(@Ordinarios, 0.0) <> 0.0 
        BEGIN
          
          SELECT @ID = NULL, @InteresesAcumulados = NULL
          IF @Modulo = 'CXC'
          BEGIN
            SELECT @InteresesAcumulados = SUM(InteresesOrdinarios) FROM Cxc WHERE RamaID  = @RamaID
            SELECT @ID = MAX(ID) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' AND @Hoy BETWEEN FechaEmision AND Vencimiento-1
            IF @ID IS NULL
              SELECT @ID = MIN(ID) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' 
          END ELSE
          BEGIN
            SELECT @InteresesAcumulados = SUM(InteresesOrdinarios) FROM Cxp WHERE RamaID  = @RamaID
            SELECT @ID = MAX(ID) FROM Cxp WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' AND @Hoy BETWEEN FechaEmision AND Vencimiento-1
            IF @ID IS NULL
              SELECT @ID = MIN(ID) FROM Cxp WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE' 
          END

          IF NULLIF(@InteresesAcumulados, 0.0) IS NULL
            SELECT @DiasInflacion = DATEDIFF(day, @RamaEmision, @Hoy) + 1.0
          ELSE
            SELECT @DiasInflacion = 1.0

          SELECT @Ordinarios = @Ordinarios * @FactorMes * @DiasInflacion
          
  		  SET @ImporteInflacion = dbo.fnImporteInflacion(@TipoTasa, @TieneTasaEsp, @TasaEsp, @Inflacion, @Ordinarios, @IVAInteresPorcentaje, 0.0) 
  		  
  		  IF @ImporteInflacion = -1.0
  		  BEGIN
            SELECT @Ok = 30075, @OkRef = dbo.fnIdiomaTraducir(@Usuario,'Verifique la moneda utilizada para el cálculo de inflación.')           
            RETURN
          END  
          IF @ImporteInflacion > 0.0
          BEGIN
            SELECT @Renglon = @Renglon + 2048.0, @SumaInflacion = @SumaInflacion + ISNULL(@ImporteInflacion, 0.0)
            IF @Modulo = 'CXC'          
              INSERT CxcD (ID,                   Sucursal,  Renglon,  Aplica, AplicaID, InteresesOrdinariosIVADescInfl)  
                   SELECT @DescuentoInflacionID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@ImporteInflacion, 0.0)
                     FROM Cxc
                    WHERE ID = @ID
            ELSE
              INSERT CxpD (ID,                   Sucursal,  Renglon,  Aplica, AplicaID, InteresesOrdinariosIVADescInfl)  
                   SELECT @DescuentoInflacionID, @Sucursal, @Renglon, Mov,    MovID,    NULLIF(@ImporteInflacion, 0.0)
                     FROM Cxp
                    WHERE ID = @ID
          END
        END

      END
      FETCH NEXT FROM crInflacion INTO @RamaID, @RamaEmision, @Ordinarios, @Saldo, @TipoTasa, @TieneTasaEsp, @TasaEsp, @IVAInteresPorcentaje
    END  -- While
    CLOSE crInflacion
    DEALLOCATE crInflacion
    
    IF @Modulo = 'CXC'
    BEGIN
      IF EXISTS(SELECT * FROM CxcD WHERE ID = @DescuentoInflacionID)
        UPDATE Cxc SET Importe = @SumaInflacion WHERE ID = @DescuentoInflacionID
      ELSE 
      BEGIN
        DELETE Cxc WHERE ID = @DescuentoInflacionID
        SELECT @DescuentoInflacionID = NULL
      END
    END ELSE
    BEGIN
      IF EXISTS(SELECT * FROM CxpD WHERE ID = @DescuentoInflacionID)
        UPDATE Cxp SET Importe = @SumaInflacion WHERE ID = @DescuentoInflacionID
      ELSE 
      BEGIN
        DELETE Cxp WHERE ID = @DescuentoInflacionID
        SELECT @DescuentoInflacionID = NULL
      END
    END

    IF @DescuentoInflacionID IS NOT NULL
      EXEC spCx @DescuentoInflacionID, @Modulo, 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 0, 0, @DescuentoInflacionMov OUTPUT, @DescuentoInflacionMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
      
  END
  RETURN
END
GO

/**************** spACCarteraVencidaCNBV ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACCarteraVencidaCNBV') and type = 'P') drop procedure dbo.spACCarteraVencidaCNBV
GO
CREATE PROCEDURE spACCarteraVencidaCNBV
	           @Empresa		char(5),
		   @Sucursal		int,
        	   @Usuario		char(10),
    		   @Modulo		char(5),
		   @Hoy			datetime,
    		   @FechaRegistro	datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RamaID		int,
    @Metodo		int,
    @DisposicionTipo 	varchar(20),
    @Capital		money,
    @Intereses		money,
    @DiasVencido	int,
    @Marcar		bit

  IF @Modulo <> 'CXC' RETURN
  DECLARE crCarteraVencidaCNBV CURSOR FOR
   SELECT r.ID, ta.Metodo, UPPER(lc.DisposicionTipo), ISNULL(ROUND(c.Saldo, 0), 0.0), ISNULL(ROUND(c.InteresesOrdinarios, 0), 0.0), DATEDIFF(day, c.Vencimiento, @Hoy)
     FROM Cxc c
     JOIN Cxc r ON r.ID = c.RamaID
     JOIN LC ON lc.LineaCredito = r.LineaCredito
     JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = r.TipoAmortizacion
    WHERE c.Empresa = @Empresa AND c.Estatus = 'PENDIENTE' AND c.Vencimiento < @Hoy

  OPEN crCarteraVencidaCNBV
  FETCH NEXT FROM crCarteraVencidaCNBV INTO @RamaID, @Metodo, @DisposicionTipo, @Capital, @Intereses, @DiasVencido
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND (@Capital <> 0.0 OR @Intereses <> 0.0)
    BEGIN
      SELECT @Marcar = 0
      IF @DisposicionTipo = 'REVOLVENTE' AND @DiasVencido >= 60 SELECT @Marcar = 1 ELSE
      IF @Metodo IN (21, 22)             AND @DiasVencido >= 30 SELECT @Marcar = 1 ELSE
      IF @Metodo IN (10, 11, 12, 30, 31) AND @DiasVencido >= 90 SELECT @Marcar = 1 ELSE
      IF @Metodo = 20
      BEGIN
        IF @Capital   <> 0.0 AND @DiasVencido >= 30 SELECT @Marcar = 1 ELSE
        IF @Intereses <> 0.0 AND @DiasVencido >= 90 SELECT @Marcar = 1
      END
      IF @Marcar = 1 
      BEGIN
        UPDATE Cxc SET CarteraVencidaCNBV  = 1 WHERE ID     = @RamaID AND CarteraVencidaCNBV  = 0
        UPDATE Cxc SET CarteraVencidaCNBV  = 1 WHERE RamaID = @RamaID AND CarteraVencidaCNBV  = 0
      END
    END
    FETCH NEXT FROM crCarteraVencidaCNBV INTO @RamaID, @Metodo, @DisposicionTipo, @Capital, @Intereses, @DiasVencido
  END  -- While
  CLOSE crCarteraVencidaCNBV
  DEALLOCATE crCarteraVencidaCNBV
  RETURN
END
GO

/**************** spACMinistracionHipotecaria ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACMinistracionHipotecaria') and type = 'P') drop procedure dbo.spACMinistracionHipotecaria
GO
CREATE PROCEDURE spACMinistracionHipotecaria
	           @Empresa		char(5),
		   @Sucursal		int,
        	   @Usuario		char(10),
		   @Hoy			datetime,
    		   @FechaRegistro	datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Intereses			money,
    @InteresesID		int,
    @InteresesMov		varchar(20),
    @InteresesMovID		varchar(20),
    @Bonificacion		money,
    @BonificacionID		int,
    @BonificacionMov		varchar(20),
    @BonificacionMovID		varchar(20),
    @Documento			money,
    @DocumentoID		int,
    @DocumentoMov		varchar(20),
    @DocumentoMovID		varchar(20),
    @LineaCredito		varchar(20),
    @Importe			money,
    @Disposiciones		money,
    @Moneda			char(10),
    @TipoCambio			float,
    @Acreditado			varchar(10),
    @TipoTasa			varchar(20),
    @TipoTasaBonificacion	varchar(20),
    @TasaDiaria			float, 
    @TasaDiariaBonificacion	float,
    @TieneTasaEsp		bit,
    @TasaEsp			float,
    @VigenciaDesde		datetime,
    @CorteDesde			datetime,
    @TipoVencimiento		varchar(20),
    @Dias			int,
    @Aplica			varchar(20),
    @AplicaID			varchar(20),
    @Saldo			money,
    @Renglon			float

  BEGIN TRANSACTION 

  SELECT @InteresesMov = ACMHIntereses,
         @BonificacionMov = ACMHInteresesBonificacion,
         @DocumentoMov = ACMHInteresesDocumento
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  DECLARE crLC CURSOR FOR
   SELECT lc.LineaCredito, lc.Importe, lc.Moneda, m.TipoCambio, lc.Acreditado, lc.TipoTasa, ISNULL(lc.TieneTasaEsp, 0), lc.TasaEsp, NULLIF(lc.TipoTasaBonificacion, ''), lc.VigenciaDesde,
          ta.PagoVencimiento, ta.PagoDias
     FROM LC
     JOIN TipoAmortizacion ta ON ta.TipoAmortizacion = lc.TipoAmortizacion
     JOIN Mon m ON m.Moneda = lc.Moneda
    WHERE lc.Empresa = @Empresa AND lc.MinistracionHipotecaria = 1 AND lc.Estatus = 'ALTA' AND @Hoy BETWEEN lc.VigenciaDesde AND lc.VigenciaHasta

  OPEN crLC
  FETCH NEXT FROM crLC INTO @LineaCredito, @Importe, @Moneda, @TipoCambio, @Acreditado, @TipoTasa, @TieneTasaEsp, @TasaEsp, @TipoTasaBonificacion, @VigenciaDesde, @TipoVencimiento, @Dias
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN                         
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL 
    BEGIN
      EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp
      SELECT @Intereses = @Importe * (@TasaDiaria / 100.0)
      INSERT Cxc (Sucursal,  Empresa,  Mov,           FechaEmision,  Referencia,    Importe,    Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,     ClienteMoneda, ClienteTipoCambio)
          VALUES (@Sucursal, @Empresa, @InteresesMov, @Hoy,          @LineaCredito, @Intereses, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Acreditado, @Moneda,       @TipoCambio)
      SELECT @InteresesID = SCOPE_IDENTITY()
      EXEC spCx @InteresesID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @InteresesMov OUTPUT, @InteresesMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL

      IF @TipoTasaBonificacion IS NOT NULL AND @Ok IS NULL
      BEGIN
        SELECT @Disposiciones = SUM(Importe)
          FROM Cxc
         WHERE Empresa = @Empresa AND Cliente = @Acreditado AND LineaCredito = @LineaCredito AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND Moneda = @Moneda
        IF @Disposiciones IS NOT NULL
        BEGIN    
          EXEC spTipoTasa @TipoTasaBonificacion, @TasaDiariaBonificacion OUTPUT
          SELECT @Bonificacion = (@Importe - ISNULL(@Disposiciones, 0.0)) * (@TasaDiariaBonificacion/100.0)
          IF NULLIF(@Bonificacion, 0.0) IS NOT NULL
          BEGIN
            INSERT Cxc (Sucursal,  Empresa,  Mov,              FechaEmision,  Referencia,    Importe,       Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,     ClienteMoneda, ClienteTipoCambio)
                VALUES (@Sucursal, @Empresa, @BonificacionMov, @Hoy,          @LineaCredito, @Bonificacion, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Acreditado, @Moneda,       @TipoCambio)
            SELECT @BonificacionID = SCOPE_IDENTITY()
            EXEC spCx @BonificacionID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @BonificacionMov OUTPUT, @BonificacionMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          END
        END
      END
      SELECT @CorteDesde = NULL
      SELECT @CorteDesde = dbo.fnEsDiaCorte (@Hoy, @TipoVencimiento, @Dias, @VigenciaDesde)
      IF @CorteDesde IS NOT NULL
      BEGIN
        SELECT @Documento = NULL
        SELECT @Documento = SUM(Saldo)
          FROM dbo.fnCxcInfo(@Empresa, @Acreditado, @Acreditado)
         WHERE Referencia = @LineaCredito AND Estatus = 'PENDIENTE' AND Mov IN (@InteresesMov, @BonificacionMov) AND FechaEmision BETWEEN @CorteDesde AND @Hoy AND Moneda = @Moneda
        IF NULLIF(@Documento, 0.0) IS NOT NULL
        BEGIN
          INSERT Cxc (Sucursal,  Empresa,  Mov,           FechaEmision,  Referencia,    Importe,    Moneda,  TipoCambio,  Usuario,  Estatus,      Cliente,     ClienteMoneda, ClienteTipoCambio, AplicaManual)
              VALUES (@Sucursal, @Empresa, @DocumentoMov, @Hoy,          @LineaCredito, @Documento, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR', @Acreditado, @Moneda,       @TipoCambio,       1)
          SELECT @DocumentoID = SCOPE_IDENTITY()
          SELECT @Renglon = 0.0

          DECLARE crDocumento CURSOR LOCAL FOR
           SELECT Mov, MovID, NULLIF(Saldo, 0.0)
             FROM dbo.fnCxcInfo(@Empresa, @Acreditado, @Acreditado)
            WHERE Referencia = @LineaCredito AND Estatus = 'PENDIENTE' AND Mov IN (@InteresesMov, @BonificacionMov) AND FechaEmision BETWEEN @CorteDesde AND @Hoy AND Moneda = @Moneda 
          OPEN crDocumento
          FETCH NEXT FROM crDocumento INTO @Aplica, @AplicaID, @Saldo
          WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
          BEGIN                         
            IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Saldo IS NOT NULL
            BEGIN
              SELECT @Renglon = @Renglon + 2048.0
              INSERT CxcD (ID, Renglon, Sucursal, Aplica, AplicaID, Importe) VALUES (@DocumentoID, @Renglon, @Sucursal, @Aplica, @AplicaID, @Saldo)
            END
            FETCH NEXT FROM crDocumento INTO @Aplica, @AplicaID, @Saldo
          END  -- While
          CLOSE crDocumento
          DEALLOCATE crDocumento

          EXEC spCx @DocumentoID, 'CXC', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0, @DocumentoMov OUTPUT, @DocumentoMovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        END
      END
    END
    FETCH NEXT FROM crLC INTO @LineaCredito, @Importe, @Moneda, @TipoCambio, @Acreditado, @TipoTasa, @TieneTasaEsp, @TasaEsp, @TipoTasaBonificacion, @VigenciaDesde, @TipoVencimiento, @Dias
  END  -- While
  CLOSE crLC
  DEALLOCATE crLC

  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE
    ROLLBACK TRANSACTION

  RETURN
END
GO

/*
 DECLARE
   @Ok 		int,
   @OkRef	varchar(255)
EXEC spACCerrarDia 0, 'DEMO', 'DEMO', '8/8/4', '8/9/4', @Ok OUTPUT, @OkRef OUTPUT
*/
/**************** spACCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACCerrarDia') and type = 'P') drop procedure dbo.spACCerrarDia
GO
CREATE PROCEDURE spACCerrarDia
		   @Sucursal		int,
                   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaD		datetime,
		   @FechaA		datetime,
                   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @ModuloEspecifico	char(5) = NULL
--//WITH ENCRYPTION
AS BEGIN
  IF NOT EXISTS(SELECT * FROM Empresa WHERE Empresa = @Empresa) RETURN

  DECLARE
    @FechaRegistro					datetime,
    @Conteo							int,
    @Hoy							datetime,
    @AcCobroIntereses				varchar(20), --MEJORA10041
    @AcConsiderarInflacionIVA		bit, --MEJORA10041
    @ACMonedaCalculoInflacionIVA	varchar(10) --MEJORA10041
    
  SELECT --MEJORA10041
    @AcCobroIntereses = UPPER(RTRIM(ISNULL(ACCobroIntereses,''))),
    @ACConsiderarInflacionIVA = ISNULL(ACConsiderarInflacionIVA,0),
    @ACMonedaCalculoInflacionIVA = NULLIF(LTRIM(RTRIM(ACMonedaCalculoInflacionIVA)),'')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa 

  SELECT @Conteo = 0
  EXEC spExtraerFecha @FechaD OUTPUT
  EXEC spExtraerFecha @FechaA OUTPUT
  SELECT @FechaRegistro = GETDATE() 

  SELECT @Hoy = @FechaD
  WHILE @Hoy < @FechaA AND @Ok IS NULL
  BEGIN
    IF NOT EXISTS(SELECT * FROM ACDiaCerrado WHERE Fecha = @Hoy)
    BEGIN
      -- Reinversion Automatica
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACReinversionAutomatica @Empresa, @Usuario, 'CXC', @Hoy, @Ok OUTPUT, @OkRef OUTPUT, 1
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXP') EXEC spACReinversionAutomatica @Empresa, @Usuario, 'CXP', @Hoy, @Ok OUTPUT, @OkRef OUTPUT, 1

      -- Actualizar Tasas
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACActualizarTasas @Empresa, 'CXC', @Hoy, @Ok OUTPUT, @OkRef OUTPUT
      --EXEC spACActualizarTasas @Empresa, 'CXP', @Hoy, @Ok OUTPUT, @OkRef OUTPUT

      -- Marcar Cartera Vencida CNBV
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACCarteraVencidaCNBV @Empresa, @Sucursal, @Usuario, 'CXC', @Hoy, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

      IF  @ACConsiderarInflacionIVA = 1 --MEJORA10041
      BEGIN
        IF @ACMonedaCalculoInflacionIVA IS NOT NULL 
        BEGIN
          IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACIVADescontarInflacion @Empresa, @Sucursal, @Usuario, 'CXC', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --MEJORA10041
          IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXP') EXEC spACIVADescontarInflacion @Empresa, @Sucursal, @Usuario, 'CXP', @Hoy, @FechaRegistro, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT --MEJORA10041
        END ELSE
        BEGIN
          SELECT @Ok = 30075, @OkRef = dbo.fnIdiomaTraducir(@Usuario,'Verifique la moneda utilizada para el cálculo de inflación.')
        END
      END
    
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACDevengarIntereses @Empresa, @Sucursal, @Usuario, 'CXC', @Hoy, @FechaRegistro, 0, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACDevengarIntereses @Empresa, @Sucursal, @Usuario, 'CXC', @Hoy, @FechaRegistro, 1, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXP') EXEC spACDevengarIntereses @Empresa, @Sucursal, @Usuario, 'CXP', @Hoy, @FechaRegistro, 0, @Conteo OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

      -- Ministracion Hipotecaria
      IF @Ok IS NULL AND @ModuloEspecifico IN (NULL, 'CXC') EXEC spACMinistracionHipotecaria @Empresa, @Sucursal, @Usuario, @Hoy, @FechaRegistro, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL EXEC xpACCerrarDia @Empresa, @Usuario, @Hoy, @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok IS NULL INSERT ACDiaCerrado (Fecha) VALUES (@Hoy)
      SELECT @Hoy = DATEADD(day, 1, @Hoy)
    END ELSE SELECT @Ok = 35151, @OkRef = CONVERT(varchar, @Hoy)
  END
  RETURN
END
GO


-- spACCerrarDia 0, 'DEMO', 'DEMO', '6/19/4', '8/18/4', NULL, NULL

/**************** spCarteraVencidaCNBV ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCarteraVencidaCNBV') and type = 'P') drop procedure dbo.spCarteraVencidaCNBV
GO             
CREATE PROCEDURE spCarteraVencidaCNBV
                    @Estacion		int,
		    @Marcar		bit

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID		int

  DECLARE crLista CURSOR 
      FOR SELECT ID FROM ListaID WHERE Estacion = @Estacion
  OPEN crLista
  FETCH NEXT FROM crLista INTO @ID
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      UPDATE Cxc SET CarteraVencidaCNBV = @Marcar WHERE ID     = @ID AND CarteraVencidaCNBV <> @Marcar
      UPDATE Cxc SET CarteraVencidaCNBV = @Marcar WHERE RamaID = @ID AND CarteraVencidaCNBV <> @Marcar
    END
    FETCH NEXT FROM crLista INTO @ID
  END -- While
  CLOSE crLista
  DEALLOCATE crLista

  DELETE ListaID WHERE Estacion = @Estacion
  RETURN
END
GO

/**************** spACReciprocidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACReciprocidad') and type = 'P') drop procedure dbo.spACReciprocidad
GO             
CREATE PROCEDURE spACReciprocidad
		    @Empresa		char(5),
                    @Cliente		char(10),
		    @Importe		money,
		    @TipoCredito	varchar(50),
		    @Articulo		char(20),
		    @EnSilencio		bit = 0,
		    @Acciones		float = NULL OUTPUT,
    		    @AccionesImporte	money = NULL OUTPUT,
    		    @InversionTotal	money = NULL OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Existencia		float,
    @LineaCredito	varchar(20),
    @ImporteLinea	float,
    @SaldoLinea		float,
    @Moneda		char(10),
    @Reciprocidad	float,
    @CfgReciprocidad	float,
    @ValorContable	float,
    @ValorMercado	float,
    @Disposiciones	float, 
    @Prestamos		money

  SELECT @ValorMercado = PrecioLista, @ValorContable = Precio3
    FROM Art
   WHERE Articulo = @Articulo
  SELECT @CfgReciprocidad = ACReciprocidad FROM EmpresaCfg WHERE Empresa = @Empresa

  SELECT @Existencia = SUM(Inventario) 
    FROM ArtExistenciaInv
   WHERE Empresa = @Empresa AND Articulo = @Articulo AND Almacen = @Cliente

  SELECT @Reciprocidad = Reciprocidad FROM TipoCredito WHERE TipoCredito = @TipoCredito
  SELECT @Acciones = ((@Importe * (@Reciprocidad / 100.0)) / @ValorContable),
         @Prestamos = @Importe

  DECLARE crLC CURSOR FOR
   SELECT lc.LineaCredito, lc.Importe, lc.Moneda, ISNULL(tc.Reciprocidad, 0.0)
     FROM LC
     JOIN TipoCredito tc ON tc.TipoCredito = lc.TipoCredito
    WHERE lc.Empresa = @Empresa AND lc.Estatus = 'ALTA' AND Acreditado = @Cliente

  OPEN crLC
  FETCH NEXT FROM crLC INTO @LineaCredito, @ImporteLinea, @Moneda, @Reciprocidad
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Disposiciones = NULL
      SELECT @Disposiciones = SUM(Importe) 
        FROM Cxc
       WHERE LineaCredito=@LineaCredito AND Estatus IN ('PENDIENTE', 'CONCLUIDO') AND Cliente = @Cliente AND Empresa = @Empresa AND Moneda = @Moneda

      SELECT @SaldoLinea = ISNULL(@ImporteLinea, 0.0) - ISNULL(@Disposiciones, 0.0)
      SELECT @Acciones = @Acciones + ((@SaldoLinea * (@Reciprocidad / 100.0)) / @ValorContable)
      SELECT @Prestamos = @Prestamos + @SaldoLinea
    END
    FETCH NEXT FROM crLC INTO @LineaCredito, @ImporteLinea, @Moneda, @Reciprocidad
  END -- While
  CLOSE crLC
  DEALLOCATE crLC
  SELECT @Acciones = CEILING(@Acciones) - ISNULL(@Existencia, 0.0)
  SELECT @AccionesImporte = @Acciones * @ValorMercado
  SELECT @InversionTotal  = (@Prestamos * (@CfgReciprocidad / 100.0)) - @AccionesImporte

  IF @EnSilencio = 0
    SELECT "Acciones" = @Acciones, "AccionesImporte" = @AccionesImporte, "InversionTotal" = @InversionTotal
  RETURN
END
GO


-- spACRecorrerVencimiento 'UCCP', 'CXC', 'Arrendamiento', '1', 20
/**************** spACRecorrerVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACRecorrerVencimiento') and type = 'P') drop procedure dbo.spACRecorrerVencimiento
GO             
CREATE PROCEDURE spACRecorrerVencimiento
		    @Empresa		char(5),
                    @Modulo		char(5),
		    @Mov		varchar(20),
		    @MovID		varchar(20),
		    @Dias		int
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @RamaID		int,
    @Primera		bit,
    @DiasA		int,
    @DiasN		int,
    @FechaEmision	datetime,
    @Vencimiento	datetime,
    @InteresesFijos	money

  IF @Modulo <> 'CXC' RETURN

  SELECT @Primera = 1, @RamaID = NULL
  SELECT @RamaID = ID 
    FROM Cxc 
   WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus = 'CONCLUIDO'

  IF @RamaID IS NULL OR NULLIF(@Dias, 0) IS NULL RETURN

  DECLARE crAmortizacion CURSOR FOR
   SELECT FechaEmision, Vencimiento, InteresesFijos
     FROM Cxc
    WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE'
    ORDER BY Vencimiento

  OPEN crAmortizacion
  FETCH NEXT FROM crAmortizacion INTO @FechaEmision, @Vencimiento, @InteresesFijos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN                         
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @DiasA = DATEDIFF(day, @FechaEmision, @Vencimiento)
      IF @Primera = 0 
        SELECT @FechaEmision = DATEADD(day, @Dias, @FechaEmision)
      SELECT @Vencimiento = DATEADD(day, @Dias, @Vencimiento)
      SELECT @DiasN = DATEDIFF(day, @FechaEmision, @Vencimiento)
      SELECT @InteresesFijos = dbo.fnR3(@DiasA, @InteresesFijos, @DiasN)

      UPDATE Cxc 
         SET FechaEmision = @FechaEmision, Vencimiento = @Vencimiento, InteresesFijos = @InteresesFijos 
       WHERE CURRENT OF crAmortizacion

       -- si se agrega cxp hay que considerar InteresesFijosRetencion al UPDATE

      SELECT @Primera = 0
    END
    FETCH NEXT FROM crAmortizacion INTO @FechaEmision, @Vencimiento, @InteresesFijos
  END -- While
  CLOSE crAmortizacion
  DEALLOCATE crAmortizacion

  RETURN
END
GO


-- spACBajaParcial 'UCCP', 0, 'UCCP', 'CXC', 'Arrendamiento', '1', '6/3/5', 10
/**************** spACBajaParcial ****************/
if exists (select * from sysobjects where id = object_id('dbo.spACBajaParcial') and type = 'P') drop procedure dbo.spACBajaParcial
GO             
CREATE PROCEDURE spACBajaParcial
		    @Empresa			char(5),
	            @Sucursal			int,
		    @Usuario			char(10),
                    @Modulo			char(5),		    
		    @Mov			varchar(20),
		    @MovID			varchar(20),
		    @Hoy			datetime,
		    @PorcentajeBajaParcial	float
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @CxcID			int,
    @DocID			int,
    @DocMov			varchar(20),
    @DocMovID			varchar(20),
    @NCargoID			int,
    @NCargoMov			varchar(20),
    @AjusteID			int,
    @AjusteMov			varchar(20),
    @RamaID			int,
    @Importe			money,
    @ImpuestoPct		float,
    @ImportePendiente		money,
    @ImporteConcluido		money,
    @ValorUnitario		money,
    @ValorUnitarioConIVA	money,
    @ValorResidualPct		float,
    @ImporteTotal		money,
    @CapitalBase		money,
    @Dif			money,
    @Saldo			money,
    @Ok				int,
    @OkRef			varchar(255)

  IF @Modulo <> 'CXC' RETURN

  SELECT @NCargoID = NULL, @Ok = NULL, @OkRef = NULL

  BEGIN TRANSACTION

  SELECT @NCargoMov = CxcNCargo, 
         @DocMov = ACBajaParcial,  
         @AjusteMov = CxcAjuste
    FROM EmpresaCfgMov WHERE Empresa = @Empresa
  SELECT @RamaID = NULL
  SELECT @RamaID = c.ID, @Importe = c.Importe, @ImpuestoPct = ISNULL(c.Impuestos, 0.0)/NULLIF(c.Importe, 0.0)*100.0, 
         @ValorResidualPct = lc.PorcentajeResidual
    FROM Cxc c
    JOIN LC on lc.LineaCredito = c.LineaCredito
   WHERE c.Empresa = @Empresa AND c.Mov = @Mov AND c.MovID = @MovID AND c.Estatus = 'CONCLUIDO'

  EXEC xpPorcentajeResidual @Modulo, @RamaID, @ValorResidualPct OUTPUT
  IF @RamaID IS NULL OR NULLIF(@PorcentajeBajaParcial, 0) IS NULL RETURN

  SELECT @ImportePendiente = SUM(Saldo) FROM Cxc WHERE RamaID = @RamaID
  SELECT @ImporteConcluido = SUM(Importe) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'CONCLUIDO'
  SELECT @CxcID = MIN(ID) FROM Cxc WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE'


  SELECT @ValorUnitario = (@Importe - @ImporteConcluido) * (@PorcentajeBajaParcial/100.0) 
  SELECT @ValorUnitarioConIVA = @ValorUnitario * (1.0+(@ImpuestoPct/100.0))

  SELECT @CapitalBase = @ImportePendiente - @ValorUnitario + ((@Importe*(@ValorResidualPct/100.0))*@PorcentajeBajaParcial/100.0)
  SELECT @ImporteTotal = ISNULL(ta.SaldoInicial, 0.0) - @ValorUnitarioConIVA
    FROM TablaAmortizacion ta
   WHERE ta.Modulo = @Modulo AND ta.ID = @RamaID AND CxcID = @CxcID

  SELECT @Dif = @ImporteTotal - @ImportePendiente
  IF ISNULL(@Dif, 0.0) > 0.0
  BEGIN
    INSERT Cxc
           (Sucursal,  Empresa, Mov,        FechaEmision, Referencia, Importe, Moneda,   TipoCambio,   Usuario,   Estatus,     Cliente, ClienteMoneda, ClienteTipoCambio, Concepto,  Proyecto,  UEN)
    SELECT  @Sucursal, Empresa, @NCargoMov, @Hoy,         Referencia, @Dif,    m.Moneda, m.TipoCambio, @Usuario, 'SINAFECTAR', Cliente, m.Moneda,      m.TipoCambio,      Concepto,  Proyecto,  UEN
      FROM Cxc c
      JOIN Mon m ON m.Moneda = c.Moneda
     WHERE ID = @RamaID
    SELECT @NCargoID = SCOPE_IDENTITY()
    EXEC spAfectar @Modulo, @NCargoID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
  END

  IF @Ok IS NULL
  BEGIN
    SELECT @Importe = @ImporteTotal/(1+(@ImpuestoPct/100.0))
    INSERT Cxc
           (Sucursal,  Empresa, Mov,     FechaEmision, Condicion, Vencimiento, Referencia, Importe,  Impuestos,                     Moneda,   TipoCambio,   Usuario,   Estatus,     Cliente, ClienteMoneda, ClienteTipoCambio, AplicaManual, Concepto,  Proyecto,  UEN, TasaDiaria, LineaCredito, TipoAmortizacion, TipoTasa, TieneTasaEsp, TasaEsp, InteresesFijos, Referencia5)
    SELECT  @Sucursal, Empresa, @DocMov, @Hoy,        '(Fecha)',  Vencimiento, Referencia, @Importe, @Importe*(@ImpuestoPct/100.0), m.Moneda, m.TipoCambio, @Usuario, 'SINAFECTAR', Cliente, m.Moneda,      m.TipoCambio,      1,            Concepto,  Proyecto,  UEN, TasaDiaria, LineaCredito, TipoAmortizacion, TipoTasa, TieneTasaEsp, TasaEsp, InteresesFijos, CONVERT(varchar, @CapitalBase)
      FROM Cxc c
      JOIN Mon m ON m.Moneda = c.Moneda
     WHERE ID = @RamaID
    SELECT @DocID = SCOPE_IDENTITY()

    INSERT CxcD (
           Sucursal,  ID,     Renglon,    Aplica, AplicaID, Importe) 
    SELECT @Sucursal, @DocID, ID-@RamaID, Mov,    MovID,    Saldo
      FROM Cxc
     WHERE RamaID = @RamaID AND Estatus = 'PENDIENTE'
    INSERT CxcD (
           Sucursal,  ID,     Renglon,    Aplica, AplicaID, Importe) 
    SELECT @Sucursal, @DocID, ID-@RamaID, Mov,    MovID,    Saldo
      FROM Cxc
     WHERE ID = @NCargoID AND Estatus = 'PENDIENTE'
 
    EXEC spAfectar @Modulo, @DocID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    SELECT @DocMovID = MovID FROM Cxc WHERE ID = @DocID
  END

  SELECT @Saldo = 0.0
  SELECT @Saldo = Saldo FROM Cxc WHERE ID = @DocID AND Estatus = 'PENDIENTE'
  IF @Ok IS NULL AND ISNULL(@Saldo, 0.0) > 0.0
  BEGIN
    EXEC @AjusteID = spAfectar @Modulo, @DocID, 'GENERAR', 'PENDIENTE', @AjusteMov, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT
    
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
    UPDATE Cxc SET Importe = @Saldo, Impuestos = NULL WHERE ID = @AjusteID
    DELETE CxcD WHERE ID = @AjusteID
    INSERT CxcD (Sucursal,  ID,        Renglon,    Aplica,  AplicaID,  Importe) 
    VALUES      (@Sucursal, @AjusteID, 2048,       @DocMov, @DocMovID, @Saldo)    
    EXEC spAfectar @Modulo, @AjusteID, @EnSilencio = 1, @Conexion = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT    
  END

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Se Genero con Exito '+RTRIM(@DocMov)+' '+RTRIM(@DocMovID)
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion+' '+ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END
  RETURN
END
GO

PRINT "******************* SP ADMON CREDITOS ******************"
GO
if exists (select * from sysobjects where id = object_id('dbo.spACSugerirPagoDividendos') and type = 'P') drop procedure dbo.spACSugerirPagoDividendos
GO             

CREATE  PROCEDURE spACSugerirPagoDividendos
			@Empresa	varchar(5),
			@Sucursal	int,
			@Usuario	char(20),
			@Fecha		datetime,
			@Ejercicio	int
WITH ENCRYPTION
AS BEGIN
  DECLARE
    @ID			int,
    @Mov		varchar(20),
    @Articulo		varchar(20),
    @Almacen		char(10),
    @Existencia		float,
    @Precio		float,
    @Renglon		float,
    @RenglonID		int,
    @RenglonTipo	char(1),
    @ArtTipo 		varchar(20), 
    @ArtUnidad 		varchar(50),
    @Moneda		char(10),
    @TipoCambio		float

  SELECT @Mov = 'Pago Dividendos'
  SELECT @Renglon = 0.0, @RenglonID = 0
  SELECT @Moneda = m.Moneda, @TipoCambio = m.TipoCambio
    FROM EmpresaCfg cfg, Mon m
   WHERE cfg.Empresa = @Empresa AND m.Moneda = cfg.ContMoneda

  DECLARE crExistencia CURSOR FOR
  SELECT a.Cuenta, a.Grupo, SUM(a.CargosU)-SUM(a.AbonosU)
    FROM AcumU a
   WHERE a.Rama = 'INV'
     AND a.Empresa = @Empresa AND a.Ejercicio = @Ejercicio
   GROUP BY a.Cuenta, a.Grupo

  OPEN crExistencia
  FETCH NEXT FROM crExistencia INTO @Articulo, @Almacen, @Existencia
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 AND NULLIF(@Existencia, 0.0) IS NOT NULL
    BEGIN
      IF @ID IS NULL
      BEGIN
        INSERT Inv (Sucursal,  Empresa,  Usuario,  Estatus,     Mov,  FechaEmision, Almacen,  Moneda,  TipoCambio, Referencia)
            VALUES (@Sucursal, @Empresa, @Usuario, 'CONFIRMAR', @Mov, @Fecha,       @Almacen, @Moneda, @TipoCambio, @Ejercicio)
        SELECT @ID = SCOPE_IDENTITY()
      END
      SELECT @Precio = NULL
      SELECT @Precio = NULLIF(MIN(Importe), 0.0) 
        FROM ArtACCupon 
       WHERE Articulo = @Articulo AND PagoDividendos = 1
      IF @Precio IS NOT NULL
      BEGIN
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        SELECT @ArtTipo = Tipo, @ArtUnidad = Unidad FROM Art WHERE Articulo = @Articulo
        EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
        INSERT InvD (ID,  Renglon,  RenglonTipo,  RenglonID,  Articulo,  Almacen,  Cantidad,    Precio,  Unidad) 
             VALUES (@ID, @Renglon, @RenglonTipo, @RenglonID, @Articulo, @Almacen, @Existencia, @Precio, @ArtUnidad) 
      END
    END
    FETCH NEXT FROM crExistencia INTO @Articulo, @Almacen, @Existencia
  END
  CLOSE crExistencia
  DEALLOCATE crExistencia
  IF @ID IS NOT NULL
    SELECT 'Se Genero con Exito "'+@Mov+'" por Confirmar.'
  ELSE
    SELECT 'No Tiene Existencias en este Ejercicio'
  RETURN
END

GO
 