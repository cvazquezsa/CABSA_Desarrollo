/* SP CAMBIOS    */

-- CAM.C = Cotizacion
-- CAM.O = Operacion
-- CAM.S = Sustitucion Cheque
-- CAM.V = Ventanilla
SET ANSI_NULLS OFF
GO
/**************** spCalcCoberturaSilencio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcCoberturaSilencio') and sysstat & 0xf = 4) drop procedure dbo.spCalcCoberturaSilencio
GO             
CREATE PROCEDURE spCalcCoberturaSilencio
			@Empresa 		char(5), 
			@Moneda			char(10),
			@Tipo			varchar(20), 
			@Instrumento	        char(10),
			@Cobertura		float	OUTPUT,
			@Sucursal		int = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @TieneCobertura	bit,
    @MargenCompra	float,
    @MargenVenta	float,
    @Ibk        	float,
    @Spread 		float,
    @Swap 		float,
    @Dias 		float

  SELECT @Cobertura = NULL
  SELECT @TieneCobertura = Cobertura, @MargenCompra = ISNULL(MargenCompra, 0.0), @MargenVenta = ISNULL(MargenVenta, 0.0)
    FROM Instrumento 
   WHERE Instrumento = @Instrumento
  IF @TieneCobertura = 1 
  BEGIN
    SELECT @Tipo = UPPER(@Tipo), @Instrumento = UPPER(@Instrumento)
    SELECT @Ibk    = ISNULL(Interbancario, 0) 		FROM Mon 		WHERE Moneda = @Moneda
    SELECT @Swap   = ISNULL(CambioTasa, 0)    		FROM EmpresaCfg 	WHERE Empresa = @Empresa
    SELECT @Spread = ISNULL(CxcMoratoriosTasa, 0) 	FROM EmpresaCfg 	WHERE Empresa = @Empresa
    SELECT @Dias   = ISNULL(DiasNaturales48Horas, 0) 	FROM FechaTrabajo 	WHERE Empresa = @Empresa AND Sucursal = @Sucursal
 
    IF @Tipo = 'COMPRA'
      SELECT @Cobertura = (@Ibk - (@Swap * @Dias)) - @Spread - @MargenCompra
    ELSE
      SELECT @Cobertura = (@Ibk - (@Swap * @Dias)) - @Spread + @MargenVenta
  END

  RETURN
END
GO

-- spCalcCobertura 'DEMO', 'Dolar', 'Venta', 'DE'
/**************** spCalcCobertura ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcCobertura') and sysstat & 0xf = 4) drop procedure dbo.spCalcCobertura
GO             
CREATE PROCEDURE spCalcCobertura
			@Empresa 		char(5), 
			@Moneda			char(10),
			@Tipo			varchar(20), 
			@Instrumento	        char(10),
			@Sucursal		int = 0
--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Cobertura  float

  EXEC spCalcCoberturaSilencio @Empresa, @Moneda, @Tipo, @Instrumento, @Cobertura OUTPUT, @Sucursal

  SELECT "Cobertura" = ROUND(@Cobertura, 4)
  RETURN
END
GO

/**************** spCambioVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioVerificar') and type = 'P') drop procedure dbo.spCambioVerificar
GO
CREATE PROCEDURE spCambioVerificar
    		    @ID               		int,
		    @Accion			char(20),
    		    @Empresa          		char(5),
		    @Usuario			char(10),
    		    @Modulo	      		char(5),
    		    @Mov              		char(20),
	            @MovID			varchar(20),
    		    @MovTipo	      		char(20),
		    @FechaEmision		datetime,
		    @Estatus			char(15),

                    @Cliente			char(10),
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,
		    @FechaRegistro		datetime,

		    @CfgValidarCobertura	bit,	
		    @CfgOperacionRelevante	money,
		    @CfgMonedaRelevante		char(10),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Tipo			varchar(20),
    @Instrumento		char(10),
    @BeneficiarioMoneda		char(10),
    @BeneficiarioFormaCompra	varchar(50),
    @BeneficiarioFormaVenta	varchar(50),
    @MovFormaPagoCompra		varchar(50),
    @MovFormaPagoVenta		varchar(50),
    @CtaDineroVenta		char(10),
    @CtaDineroCompra		char(10),
    @CtaDinero			char(10),
    @Uso			varchar(20),
    @Monto			money,
    @Importe			money,
    @Saldo			money,
    @SumaSaldo			money,
    @MovMoneda			char(10),
    @UltMoneda			char(10),
    @MovTipoCambio		float,
    @Cobertura			float,
    @TipoCambioBase		float,
    @ToleranciaBase		float,
    @Minimo			float,
    @Maximo			float,
    @UnidadMinima		float,
    @Lineas			int,
    @Beneficiario		int,
    @Descripcion		varchar(50),
    @RequiereBeneficiario	bit,
    @MismoDia			bit,
    @DifMonedas			bit,
    @HuboCobro			bit,
    @HuboPago			bit,
    @MontoDolares		money, 
    @VentasUS			money,
    @ComprasUS			money,
    @RelevanteTipoCambio	float

  -- Inicializar Variables
  SELECT @SumaSaldo = 0.0, @DifMonedas = 0, @UltMoneda = NULL, @Lineas = 0, @HuboCobro = 0, @HuboPago = 0
  SELECT @RelevanteTipoCambio = Mon.Interbancario FROM Mon WHERE Moneda = @CfgMonedaRelevante

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 AND @MovTipo <> 'CAM.C'
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    -- Validaciones Extras
    SELECT @VentasUS = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d
     WHERE c.Empresa = @Empresa AND c.FechaEmision = @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'VENTA'

    SELECT @ComprasUS = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d
     WHERE c.Empresa = @Empresa AND c.FechaEmision = @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'COMPRA'

    EXEC spVerificarVencimiento @Condicion, @Vencimiento, @FechaEmision, @Ok OUTPUT 

    IF @Ok IS NULL
    BEGIN
      EXEC spMismoDia @FechaEmision, @FechaRegistro, @MismoDia OUTPUT
      IF @MovTipo = 'CAM.V' AND @MismoDia = 0 SELECT @Ok = 35300
--      IF @MismoDia = 0 SELECT @Ok = 60140
    END

    IF @Ok IS NOT NULL RETURN

    DECLARE crCambioVerificar CURSOR
       FOR SELECT NULLIF(RTRIM(d.Tipo), ''), NULLIF(RTRIM(d.Instrumento), ''), ISNULL(d.Monto, 0.0), ISNULL(d.TipoCambio, 0.0), ISNULL(d.Cobertura, 0.0), NULLIF(d.Beneficiario, 0), NULLIF(RTRIM(i.Moneda), ''), NULLIF(RTRIM(i.Descripcion), ''), i.RequiereBeneficiario, NULLIF(RTRIM(i.Uso), ''), ISNULL(i.UnidadMinima, 0.0), NULLIF(RTRIM(i.FormaPagoCompra), ''), NULLIF(RTRIM(i.FormaPagoVenta), ''), ISNULL(Mon.TipoCambio, 0.0), ISNULL(Mon.Tolerancia, 0.0), NULLIF(RTRIM(i.CtaDineroVenta), ''), NULLIF(RTRIM(i.CtaDineroCompra), '')
             FROM CambioD d, Instrumento i, Mon
            WHERE d.ID = @ID 
              AND d.Instrumento = i.Instrumento
              AND i.Moneda = Mon.Moneda

    OPEN crCambioVerificar
    FETCH NEXT FROM crCambioVerificar INTO @Tipo, @Instrumento, @Monto, @MovTipoCambio, @Cobertura, @Beneficiario, @MovMoneda, @Descripcion, @RequiereBeneficiario, @Uso, @UnidadMinima, @MovFormaPagoCompra, @MovFormaPagoVenta, @TipoCambioBase, @ToleranciaBase, @CtaDineroVenta, @CtaDineroCompra
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Lineas = @Lineas + 1
        IF @Lineas > 10 SELECT @Ok = 35200

        IF UPPER(@Tipo) = 'COBRO' SELECT @HuboCobro = 1 ELSE
        IF UPPER(@Tipo) = 'PAGO'  SELECT @HuboPago  = 1

        IF UPPER(@Tipo) = 'COBRO'     AND UPPER(@Uso) NOT IN ('COBRO',  'COBRO/PAGO')   SELECT @Ok = 35290 
        IF UPPER(@Tipo) = 'PAGO'      AND UPPER(@Uso) NOT IN ('PAGO',   'COBRO/PAGO')   SELECT @Ok = 35290 
        IF UPPER(@Tipo) = 'COMPRA'    AND UPPER(@Uso) NOT IN ('COMPRA', 'COMPRA/VENTA') SELECT @Ok = 35290 
        IF UPPER(@Tipo) = 'VENTA'     AND UPPER(@Uso) NOT IN ('VENTA',  'COMPRA/VENTA') SELECT @Ok = 35290 
        IF UPPER(@Tipo) IN ('INVERSION', 'RETIRO') AND UPPER(@Uso) NOT IN ('INVERSION')	SELECT @Ok = 35290 

        IF UPPER(@Tipo) IN ('VENTA', 'INVERSION', 'PAGO')
          SELECT @CtaDinero = @CtaDineroVenta
        ELSE
          SELECT @CtaDinero = @CtaDineroCompra

        IF @CtaDinero IS NULL SELECT @Ok = 35280

        IF @UltMoneda IS NOT NULL AND @UltMoneda <> @MovMoneda SELECT @DifMonedas = 1
        SELECT @UltMoneda = @MovMoneda

        IF UPPER(@Tipo) NOT IN ('VENTA', 'COMPRA', 'COBRO', 'PAGO', 'INVERSION', 'RETIRO') SELECT @Ok = 35010 ELSE
        IF @RequiereBeneficiario = 1 AND UPPER(@Tipo) IN ('VENTA', 'PAGO') AND @Beneficiario IS NULL SELECT @Ok = 35020 ELSE
        IF @Monto = 0.0 SELECT @Ok = 35030 ELSE
        IF @MovTipoCambio = 0.0 SELECT @Ok = 35040 ELSE
        IF @TipoCambioBase = 1.0 AND @MovTipoCambio <> 1.0 SELECT @Ok = 35110

        IF @UnidadMinima > 0.0 AND @Ok IS NULL
          IF Convert(Money, Round(@Monto, 2)/@UnidadMinima) <> Convert(money, Round(Round(@Monto, 2)/@UnidadMinima, 0)) SELECT @Ok = 35100

        IF @Beneficiario IS NOT NULL AND @Ok IS NULL
        BEGIN
          SELECT @BeneficiarioMoneda      = i.Moneda,
                 @BeneficiarioFormaCompra = i.FormaPagoCompra,
                 @BeneficiarioFormaVenta  = i.FormaPagoVenta
            FROM Beneficiario b, Instrumento i
           WHERE b.Instrumento = i.Instrumento
             AND b.Beneficiario = @Beneficiario

          IF @MovMoneda <> @BeneficiarioMoneda SELECT @Ok = 35170 ELSE
          IF UPPER(@Tipo) = 'PAGO'  AND @MovFormaPagoCompra <> @BeneficiarioFormaCompra SELECT @Ok = 35180 ELSE
          IF UPPER(@Tipo) = 'COBRO' AND @MovFormaPagoVenta  <> @BeneficiarioFormaVenta  SELECT @Ok = 35180
        END

        IF @Ok IS NULL
        BEGIN
          IF @CfgValidarCobertura = 1
          BEGIN
            IF UPPER(@Tipo) = 'VENTA'  AND @MovTipoCambio < @Cobertura SELECT @Ok = 35080 ELSE
            IF UPPER(@Tipo) = 'COMPRA' AND @MovTipoCambio > @Cobertura SELECT @Ok = 35090
          END

          IF UPPER(@Tipo) IN ('VENTA', 'COMPRA') 
          BEGIN
	    SELECT @Minimo = @TipoCambioBase * (1 - (@ToleranciaBase/100)), 
                   @Maximo = @TipoCambioBase * (1 + (@ToleranciaBase/100))

            IF @MovTipoCambio < @Minimo SELECT @Ok = 35080 ELSE
            IF @MovTipoCambio > @Maximo SELECT @Ok = 35090 ELSE
            IF @MovTipoCambio = 1.0 AND @MovTipo <> 'CAM.S' SELECT @Ok = 35120
          END 
          ELSE BEGIN
            IF @TipoCambioBase <> 1.0 SELECT @Ok = 35070 ELSE
            IF @MovTipo = 'CAM.S' SELECT @Ok = 35140
          END
        END
        SELECT @Importe = ROUND(convert(money, (convert(float, @Monto) * @MovTipoCambio)), 2)
        IF UPPER(@Tipo) IN ('VENTA', 'INVERSION', 'PAGO') SELECT @Saldo = @Importe ELSE SELECT @Saldo = - @Importe
        SELECT @SumaSaldo = @SumaSaldo + @Saldo

        IF @MovMoneda = @CfgMonedaRelevante 
          SELECT @MontoDolares = @Monto
        ELSE
          SELECT @MontoDolares = ROUND(@Monto * @MovTipoCambio / @RelevanteTipoCambio, 2)

        IF UPPER(@Tipo) = 'VENTA'  SELECT @VentasUS  = @VentasUS  + @MontoDolares ELSE
        IF UPPER(@Tipo) = 'COMPRA' SELECT @ComprasUS = @ComprasUS + @MontoDolares 

        IF @Ok IS NOT NULL AND @OkRef IS NULL
          SELECT @OkRef = RTRIM(@Tipo) + ': ' + RTRIM(@Descripcion)
      END
      IF @Ok IS NULL
      BEGIN
        FETCH NEXT FROM crCambioVerificar INTO @Tipo, @Instrumento, @Monto, @MovTipoCambio, @Cobertura, @Beneficiario, @MovMoneda, @Descripcion, @RequiereBeneficiario, @Uso, @UnidadMinima, @MovFormaPagoCompra, @MovFormaPagoVenta, @TipoCambioBase, @ToleranciaBase, @CtaDineroVenta, @CtaDineroCompra
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END  -- While
    CLOSE crCambioVerificar
    DEALLOCATE crCambioVerificar

    IF @HuboCobro = 1 AND @HuboPago = 1 SELECT @Ok = 35210

    IF @MovTipo IN ('CAM.O', 'CAM.V', 'CAM.S') AND @Ok IS NULL 
    BEGIN
      IF @SumaSaldo > 0.0 SELECT @Ok = 35050 ELSE 
      IF @SumaSaldo < 0.0 SELECT @Ok = 35060
    END 
    IF @MovTipo = 'CAM.S' AND @DifMonedas = 1 AND @Ok IS NULL
      SELECT @Ok = 35130

    
    EXEC spExtraerFecha @FechaEmision OUTPUT
    IF @MovTipo IN ('CAM.O', 'CAM.V') AND @Ok IS NULL
      IF NOT EXISTS (SELECT * FROM CambioAcum WHERE Sucursal = @Sucursal AND Fecha = @FechaEmision AND Cerrado = 0) SELECT @Ok = 35150

    -- Documentacion Completa
    IF @VentasUS >= @CfgOperacionRelevante OR @ComprasUS >= @CfgOperacionRelevante
      IF (SELECT ISNULL(DocumentacionCompleta, 0) FROM Cte WHERE Cliente = @Cliente) = 0
        SELECT @Ok = 10430

  END

  IF @Ok IS NULL
    UPDATE Cambio 
       SET ImporteVentaUS = @VentasUS,
           ImporteCompraUS = @ComprasUS
     WHERE ID = @ID
  RETURN
END
GO

/**************** spCambioAcum ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioAcum') and type = 'P') drop procedure dbo.spCambioAcum
GO             
CREATE PROCEDURE spCambioAcum
		   @Accion		char(20),
		   @Empresa		char(5),
		   @Sucursal		int,
		   @Fecha		datetime,
		   @Moneda		char(10),
		   @Dias		int,
		   @Tipo		varchar(20),
		   @Monto		money,
		   @Importe		money,

		   @CfgContMoneda	char(10),
		
		   @Ok			int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @MontoHoy	money,
    @Monto24	money,
    @Monto48	money,
    @ImporteHoy	money,
    @Importe24	money,
    @Importe48	money

  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @Dias = ISNULL(@Dias, 0),
         @MontoHoy   = 0.0, @Monto24    = 0.0, @Monto48    = 0.0,
         @ImporteHoy = 0.0, @Importe24  = 0.0, @Importe48  = 0.0
  IF @Accion = 'CANCELAR' SELECT @Monto = -@Monto, @Importe = -@Importe

  IF @Dias = 0 SELECT @MontoHoy = @Monto, @ImporteHoy = @Importe ELSE
  IF @Dias = 1 SELECT @Monto24  = @Monto, @Importe24  = @Importe ELSE
  IF @Dias = 2 SELECT @Monto48  = @Monto, @Importe48  = @Importe 
  ELSE SELECT @Ok = 30030
  IF @Ok IS NOT NULL RETURN

  IF UPPER(@Tipo) = 'VENTA'
  BEGIN
    UPDATE CambioAcum 
       SET VentaHoy   = ISNULL(VentaHoy,   0.0) + @MontoHoy, 
           Venta24    = ISNULL(Venta24,    0.0) + @Monto24,
           Venta48    = ISNULL(Venta48,    0.0) + @Monto48, 
           VentaHoyMN = ISNULL(VentaHoyMN, 0.0) + @ImporteHoy,
           Venta24MN  = ISNULL(Venta24MN,  0.0) + @Importe24, 
           Venta48MN  = ISNULL(Venta48MN,  0.0) + @Importe48
     WHERE Empresa  = @Empresa
       AND Sucursal = @Sucursal
       AND Moneda   = @Moneda
       AND Fecha    = @Fecha
       AND Cerrado  = 0
    IF @@ROWCOUNT = 0 SELECT @Ok = 35150  

    UPDATE CambioAcum 
       SET VentaHoy   = ISNULL(VentaHoy,   0.0) + @ImporteHoy,
           Venta24    = ISNULL(Venta24,    0.0) + @Importe24, 
           Venta48    = ISNULL(Venta48,    0.0) + @Importe48, 
           VentaHoyMN = ISNULL(VentaHoyMN, 0.0) + @ImporteHoy,
           Venta24MN  = ISNULL(Venta24MN,  0.0) + @Importe24, 
           Venta48MN  = ISNULL(Venta48MN,  0.0) + @Importe48
     WHERE Empresa  = @Empresa
       AND Sucursal = @Sucursal
       AND Moneda   = @CfgContMoneda
       AND Fecha    = @Fecha
       AND Cerrado  = 0
    IF @@ROWCOUNT = 0 SELECT @Ok = 35150  

  END ELSE
  BEGIN
    UPDATE CambioAcum 
       SET CompraHoy   = ISNULL(CompraHoy,   0.0) + @MontoHoy, 
           Compra24    = ISNULL(Compra24,    0.0) + @Monto24,
           Compra48    = ISNULL(Compra48,    0.0) + @Monto48, 
           CompraHoyMN = ISNULL(CompraHoyMN, 0.0) + @ImporteHoy,
           Compra24MN  = ISNULL(Compra24MN,  0.0) + @Importe24, 
           Compra48MN  = ISNULL(Compra48MN,  0.0) + @Importe48
     WHERE Empresa  = @Empresa
       AND Sucursal = @Sucursal
       AND Moneda   = @Moneda
       AND Fecha    = @Fecha
       AND Cerrado  = 0
    IF @@ROWCOUNT = 0 SELECT @Ok = 35150  

    UPDATE CambioAcum 
       SET CompraHoy   = ISNULL(CompraHoy,   0.0) + @ImporteHoy,
           Compra24    = ISNULL(Compra24,    0.0) + @Importe24, 
           Compra48    = ISNULL(Compra48,    0.0) + @Importe48,
           CompraHoyMN = ISNULL(CompraHoyMN, 0.0) + @ImporteHoy,
           Compra24MN  = ISNULL(Compra24MN,  0.0) + @Importe24, 
           Compra48MN  = ISNULL(Compra48MN,  0.0) + @Importe48
     WHERE Empresa  = @Empresa
       AND Sucursal = @Sucursal
       AND Moneda   = @CfgContMoneda
       AND Fecha    = @Fecha
       AND Cerrado  = 0
    IF @@ROWCOUNT = 0 SELECT @Ok = 35150  
  END
    
  RETURN
END
GO

/**************** spCambioAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioAfectar') and type = 'P') drop procedure dbo.spCambioAfectar
GO             
CREATE PROCEDURE spCambioAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)         OUTPUT,
    		   @MovTipo     		char(20),

    		   @FechaEmision      		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Cliente			char(10),
		   @Condicion			varchar(50),
		   @Vencimiento			datetime,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgOperacionRelevante	money,
		   @CfgMonedaRelevante		char(10),
		   @CfgCategoriaRelevante1	varchar(50),
		   @CfgCategoriaRelevante2	varchar(50),
		   @CfgDiasRemesas		int,

		   @CfgContMoneda		char(10),
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Tipo			varchar(20),
    @Instrumento		char(10),
    @Monto			money,
    @MontoDolares		money,
    @Importe			money,
    @SumaImporte		money,
    @MovTipoCambio		float,
    @RelevanteTipoCambio	float,
    @MovMoneda			char(10),
    @CtaDineroVenta		char(10),
    @CtaDineroCompra		char(10),
    @CtaDinero			char(10),
    @FormaPagoVenta		varchar(50),
    @FormaPagoCompra		varchar(50),
    @FormaPago			varchar(50),
    @Beneficiario		int,
    @Dias			int,
    @HuboVenta			bit,
    @HuboCompra			bit,
    @HuboInversion		bit,
    @HuboRetiro			bit,
    @MismoDia			bit,
    @ObservacionesD    		varchar(60),
    @Relevante			bit,
    @ParaisoFiscal		bit,
    @CiudadRiesgo		bit,
    @InstrumentoTipo		char(20),
    @Institucion		varchar(20),
    @LimiteRemesas		money,
    @TipoCambioRemesas		float,
    @SumaRemesas		money,
    @RemesasAnteriores		money,
    @SumaCargosMonetario	money,
    @SumaAbonosMonetario	money,
    @SumaCargosDolarMonetario	money,
    @SumaAbonosDolarMonetario	money,
    @SumaInversionRetiro	money,
    @CargosAnteriores		money,
    @AbonosAnteriores		money,
    @CargosDolarAnteriores	money,
    @AbonosDolarAnteriores	money,
    @ImporteMonetario		money,
    @Ventas			money,
    @Compras			money,
    @Folio			int,
    @FolioSt			varchar(20),
    @OperacionLimite		money,

    @Generar			bit,
    @GenerarAfectado		bit,
    @IDGenerar			int,
    @GenerarModulo		char(5),
    @GenerarMov			char(20),
    @GenerarMovID		varchar(20),
    @FechaCancelacion		datetime,
    @FechaConclusion		datetime,  
    @CoberturaAfectacion	float,
    @CfgDiasHabiles		varchar(20),
    @CteCategoria		varchar(50),
    @FechaInicial		datetime,
    @FormaEnvio 		varchar(50),
    @CfgEmbarcar		bit
    
  -- Inicializar Variables
  SELECT @Generar 		= 0,
         @GenerarAfectado	= 0,
         @IDGenerar		= NULL,
         @GenerarModulo		= NULL,
         @GenerarMov		= NULL,
         @GenerarMovID	        = NULL,
         @HuboVenta		= 0,
         @HuboCompra		= 0,
	 @HuboInversion		= 0,
	 @HuboRetiro		= 0,
         @Relevante		= 0,
         @ParaisoFiscal		= 0,
         @CiudadRiesgo		= 0,
         @SumaImporte		= 0.0,
         @SumaRemesas           = 0.0,
         @SumaCargosMonetario 	= 0.0,
         @SumaAbonosMonetario 	= 0.0,
         @SumaCargosDolarMonetario = 0.0,
         @SumaAbonosDolarMonetario = 0.0,
         @SumaInversionRetiro	   = 0.0

  SELECT @FormaEnvio = FormaEnvio
    FROM Cambio
   WHERE ID = @ID

  SELECT @CfgEmbarcar = Embarcar 
    FROM FormaEnvio 
   WHERE FormaEnvio = @FormaEnvio

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

  IF @OK IS NOT NULL RETURN 

  IF @Conexion = 0 
    BEGIN TRANSACTION

    -- Poner el Estatus del Movimiento en "AFECTANDO"
    EXEC spMovEstatus @Modulo, 'AFECTANDO', @ID, @Generar, @IDGenerar, @GenerarAfectado, @Ok OUTPUT

    -- Actualizar Sucursal Detalle
    IF @Accion = 'AFECTAR' AND @Estatus = 'SINAFECTAR'
      IF (SELECT Sincro FROM Version) = 1
        EXEC sp_executesql N'UPDATE CambioD SET Sucursal = @Sucursal, SincroC = 1 WHERE ID = @ID AND (Sucursal <> @Sucursal OR SincroC <> 1)', N'@Sucursal int, @ID int', @Sucursal, @ID

    IF @Accion <> 'CANCELAR' 
      -- Registrar el Movimiento en "Mov"
      EXEC spRegistrarMovimiento @Sucursal, @Empresa, @Modulo, @Mov, @MovID, @ID, @Ejercicio, @Periodo, @FechaRegistro, @FechaEmision,
                       	         @Concepto, @Proyecto, NULL, NULL,
                       	         @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
			         @Generar, @GenerarMov, @GenerarMovID, @IDGenerar,
				 @Ok OUTPUT

    IF @MovTipo = 'CAM.S' 
      SELECT @Vencimiento = @FechaEmision
    ELSE
      -- Calcular Fecha Vencimiento
      EXEC spCalcularVencimiento 'CXC', @Empresa, @Cliente, @Condicion, @FechaEmision, @Vencimiento OUTPUT, @Dias OUTPUT, @Ok OUTPUT

    EXEC spExtraerFecha @Vencimiento OUTPUT

    DECLARE crCambio CURSOR
       FOR SELECT NULLIF(RTRIM(Tipo), '')
             FROM CambioD 
            WHERE ID = @ID 
    OPEN crCambio
    FETCH NEXT FROM crCambio INTO @Tipo
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF UPPER(@Tipo) = 'VENTA' SELECT @HuboVenta   = 1 ELSE
      IF UPPER(@Tipo) = 'COMPRA' SELECT @HuboCompra = 1 ELSE
      IF UPPER(@Tipo) = 'INVERSION' SELECT @HuboInversion = 1 ELSE
      IF UPPER(@Tipo) = 'RETIRO' SELECT @HuboRetiro = 1

      FETCH NEXT FROM crCambio INTO @Tipo
    END  
    CLOSE crCambio
    DEALLOCATE crCambio
    SELECT @Concepto = NULL
    IF @HuboInversion = 1 AND @HuboRetiro = 1 SELECT @Ok = 35350 ELSE
    IF @HuboVenta = 1 AND @HuboCompra = 1 SELECT @Concepto = 'Canje' ELSE
    IF @HuboVenta = 1 SELECT @Concepto = 'Venta' ELSE 
    IF @HuboCompra = 1 SELECT @Concepto = 'Compra' ELSE
    IF @HuboVenta = 0 AND @HuboCompra = 0
    BEGIN
      IF @HuboInversion = 1 SELECT @Concepto = 'Inversion' ELSE
      IF @HuboRetiro = 1 SELECT @Concepto = 'Retiro' 
    END

    IF @Concepto IS NOT NULL 
    BEGIN
      /*EXEC spMismoDia @FechaEmision, @Vencimiento, @MismoDia OUTPUT
      IF @MismoDia = 1 
        SELECT @Concepto = @Concepto + ' (Mismo Dia)' 
      ELSE*/ SELECT @Concepto = @Concepto + ' - ' + @Condicion/*' (24/48)'*/
    END

    SELECT @RelevanteTipoCambio = Mon.Interbancario FROM Mon WHERE Moneda = @CfgMonedaRelevante
    SELECT @CteCategoria = Categoria FROM Cte WHERE Cliente = @Cliente

    DECLARE crCambio CURSOR
       FOR SELECT NULLIF(RTRIM(d.Tipo), ''), NULLIF(RTRIM(d.Instrumento), ''), ISNULL(d.Monto, 0.0), ISNULL(d.TipoCambio, 0.0), NULLIF(d.Beneficiario, 0), NULLIF(RTRIM(i.CtaDineroVenta), ''), NULLIF(RTRIM(i.CtaDineroCompra), ''), NULLIF(RTRIM(i.Moneda), ''), NULLIF(RTRIM(i.FormaPagoVenta), ''), NULLIF(RTRIM(i.FormaPagoCompra), ''), NULLIF(RTRIM(d.Observaciones), ''), UPPER(i.Tipo), NULLIF(d.Folio, 0)
             FROM CambioD d, Instrumento i
            WHERE d.ID = @ID 
              AND d.Instrumento = i.Instrumento
    OPEN crCambio
    FETCH NEXT FROM crCambio INTO @Tipo, @Instrumento, @Monto, @MovTipoCambio, @Beneficiario, @CtaDineroVenta, @CtaDineroCompra, @MovMoneda, @FormaPagoVenta, @FormaPagoCompra, @ObservacionesD, @InstrumentoTipo, @Folio
    IF @@ERROR <> 0 SELECT @Ok = 1
    IF @@FETCH_STATUS = -1 SELECT @Ok = 60010
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN 
        SELECT @MontoDolares = NULL
        IF @Beneficiario IS NOT NULL 
        BEGIN
          IF @ParaisoFiscal = 0
          BEGIN
            IF EXISTS(SELECT * FROM Beneficiario b, InstitucionFin i WHERE b.Beneficiario = @Beneficiario AND b.Institucion   = i.Institucion AND i.ParaisoFiscal = 1) SELECT @ParaisoFiscal = 1
            IF EXISTS(SELECT * FROM Beneficiario b, InstitucionFin i WHERE b.Beneficiario = @Beneficiario AND b.Intermediario = i.Institucion AND i.ParaisoFiscal = 1) SELECT @ParaisoFiscal = 1
          END
          IF @CiudadRiesgo = 0
          BEGIN
            IF EXISTS(SELECT * FROM Beneficiario b, InstitucionFin i WHERE b.Beneficiario = @Beneficiario AND b.Institucion   = i.Institucion AND i.CiudadRiesgo = 1) SELECT @CiudadRiesgo = 1
            IF EXISTS(SELECT * FROM Beneficiario b, InstitucionFin i WHERE b.Beneficiario = @Beneficiario AND b.Intermediario = i.Institucion AND i.CiudadRiesgo = 1) SELECT @CiudadRiesgo = 1
          END
        END

        SELECT @Importe = ROUND(@Monto * @MovTipoCambio, 2)   -- Antes = ROUND((@Monto * @MovTipoCambio) + 0.001, 4)   

        IF @MovMoneda = @CfgMonedaRelevante 
          SELECT @MontoDolares = @Monto
        ELSE
          SELECT @MontoDolares = ROUND(@Monto * @MovTipoCambio / @RelevanteTipoCambio, 2)

        IF UPPER(@Tipo) IN ('VENTA', 'INVERSION', 'PAGO')
        BEGIN
          SELECT @SumaImporte = @SumaImporte + @Importe
          SELECT @CtaDinero = @CtaDineroVenta, @FormaPago = @FormaPagoVenta
          IF @InstrumentoTipo = 'MONETARIO'
            IF @MovMoneda = @CfgMonedaRelevante 
              SELECT @SumaCargosDolarMonetario = @SumaCargosDolarMonetario + @Monto
            ELSE
              SELECT @SumaCargosMonetario = @SumaCargosMonetario + @Importe
        END ELSE
        BEGIN
          SELECT @CtaDinero = @CtaDineroCompra, @FormaPago = @FormaPagoCompra
          IF @InstrumentoTipo = 'MONETARIO'
            IF @MovMoneda = @CfgMonedaRelevante 
              SELECT @SumaAbonosDolarMonetario = @SumaAbonosDolarMonetario + @Monto
            ELSE
              SELECT @SumaAbonosMonetario = @SumaAbonosMonetario + @Importe
          IF @InstrumentoTipo = 'REMESA'
            SELECT @SumaRemesas = @SumaRemesas + @Importe
        END

        IF UPPER(@Tipo) IN ('INVERSION', 'RETIRO')
          SELECT @SumaInversionRetiro = @SumaInversionRetiro + @Importe

        IF @CtaDinero IS NULL SELECT @Ok = 35280
      
        IF @MovTipo IN ('CAM.O', 'CAM.V') AND UPPER(@Tipo) IN ('VENTA', 'COMPRA') AND @Ok IS NULL
          EXEC spCambioAcum @Accion, @Empresa, @Sucursal, @FechaEmision, @MovMoneda, @Dias, @Tipo, @Monto, @Importe, @CfgContMoneda, @Ok OUTPUT

        IF (@MovTipo = 'CAM.V' OR UPPER(@Tipo) IN ('VENTA', 'INVERSION', 'PAGO')) AND @Ok IS NULL
        BEGIN
          IF ISNULL(@Dias, 0) = 0 OR @MovTipo = 'CAM.V'
            EXEC spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                 @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @ObservacionesD, 0, 0,
                                 @FechaRegistro, @Ejercicio, @Periodo, 
                                 @FormaPago, @Tipo, @Beneficiario,
                                 @Cliente, @CtaDinero, NULL, @Monto, NULL,
				 NULL, NULL, NULL,
				 @GenerarMov OUTPUT, @GenerarMovID OUTPUT,
                                 @Ok OUTPUT, @OkRef OUTPUT
          ELSE
            EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                             @FechaEmision,  @Concepto, @Proyecto, @Usuario, @Autorizacion,
 	      	             @Referencia, @DocFuente, @ObservacionesD, @FechaRegistro, @Ejercicio, @Periodo,
		             @Condicion, @Vencimiento, @Cliente, NULL, NULL, @Tipo, @CtaDinero, @FormaPago,
		             @Monto, NULL, NULL, NULL,
                             @Beneficiario, NULL, NULL, NULL, NULL, NULL,
      			     @GenerarModulo OUTPUT, @GenerarMov OUTPUT, @GenerarMovID OUTPUT,
	   	             @Ok OUTPUT, @OkRef OUTPUT
        END

        IF @MovTipo <> 'CAM.V' AND UPPER(@Tipo) IN ('COMPRA', 'RETIRO', 'COBRO') AND @Ok IS NULL
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, NULL, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                           @FechaEmision,  @Concepto, @Proyecto, @Usuario, @Autorizacion,
 	    	           @Referencia, @DocFuente, @ObservacionesD, @FechaRegistro, @Ejercicio, @Periodo,
		           @Condicion, @Vencimiento, @Cliente, NULL, NULL, @Tipo, @CtaDinero, @FormaPago,
		           @Monto, NULL, NULL, NULL, 
                           @Beneficiario, NULL, NULL, NULL, NULL, NULL,
			   @GenerarModulo OUTPUT, @GenerarMov OUTPUT, @GenerarMovID OUTPUT,
	   	           @Ok OUTPUT, @OkRef OUTPUT

        SELECT @CoberturaAfectacion = NULL
        IF UPPER(@Tipo) IN ('COMPRA', 'VENTA') AND @Accion <> 'CANCELAR' AND @Ok IS NULL 
          EXEC spCalcCoberturaSilencio @Empresa, @MovMoneda, @Tipo, @Instrumento, @CoberturaAfectacion OUTPUT, @Sucursal

        IF @Folio IS NULL
        BEGIN
          EXEC spConsecutivo @Tipo, @Sucursal, @FolioSt OUTPUT
          SELECT @Folio = CONVERT(int, @FolioSt)
        END

        UPDATE CambioD 
           SET CoberturaAfectacion = @CoberturaAfectacion,
               GeneroModulo = @GenerarModulo,
               GeneroMov    = @GenerarMov,
               GeneroMovID  = @GenerarMovID,
               MontoDolares = @MontoDolares,
               Folio        = @Folio
         WHERE CURRENT OF crCambio

	-- Poner al Beneficiario En Uso
        IF @Beneficiario IS NOT NULL AND @Accion <> 'CANCELAR' AND @Ok IS NULL
          UPDATE Beneficiario SET ESTATUS = 'ENUSO' WHERE Beneficiario = @Beneficiario
      END
      FETCH NEXT FROM crCambio INTO @Tipo, @Instrumento, @Monto, @MovTipoCambio, @Beneficiario, @CtaDineroVenta, @CtaDineroCompra, @MovMoneda, @FormaPagoVenta, @FormaPagoCompra, @ObservacionesD, @InstrumentoTipo, @Folio
      IF @@ERROR <> 0 SELECT @Ok = 1
    END  -- While
    CLOSE crCambio
    DEALLOCATE crCambio

    IF @Ok IS NULL
    BEGIN
      IF @SumaCargosMonetario > 0.0 OR @SumaAbonosMonetario > 0.0 OR @SumaCargosDolarMonetario > 0.0 OR @SumaAbonosDolarMonetario > 0.0
      BEGIN
        SELECT @CargosAnteriores = SUM(ISNULL(d.Monto, 0.0)*ISNULL(d.TipoCambio, 0.0))
          FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
         WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
           AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
           AND UPPER(d.Tipo) IN ('VENTA', 'PAGO') AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO'
           AND i.Moneda <> @CfgMonedaRelevante

        SELECT @CargosDolarAnteriores = SUM(ISNULL(d.Monto, 0.0))
          FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
         WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
           AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
           AND UPPER(d.Tipo) IN ('VENTA', 'PAGO') AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO'
           AND i.Moneda = @CfgMonedaRelevante

        SELECT @AbonosAnteriores = SUM(ISNULL(d.Monto, 0.0)*ISNULL(d.TipoCambio, 0.0))
          FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
         WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
           AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
           AND UPPER(d.Tipo) IN ('COMPRA', 'COBRO') AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO'
           AND i.Moneda <> @CfgMonedaRelevante

        SELECT @AbonosDolarAnteriores = SUM(ISNULL(d.Monto, 0.0))
          FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
         WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
           AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
           AND UPPER(d.Tipo) IN ('COMPRA', 'COBRO') AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO'
           AND i.Moneda = @CfgMonedaRelevante

        SELECT @SumaCargosMonetario      = @SumaCargosMonetario      + ISNULL(@CargosAnteriores, 0.0),
               @SumaAbonosMonetario      = @SumaAbonosMonetario      + ISNULL(@AbonosAnteriores, 0.0),
	       @SumaCargosDolarMonetario = @SumaCargosDolarMonetario + ISNULL(@CargosDolarAnteriores, 0.0),
               @SumaAbonosDolarMonetario = @SumaAbonosDolarMonetario + ISNULL(@AbonosDolarAnteriores, 0.0)

        IF @SumaCargosMonetario > @SumaAbonosMonetario 
          SELECT @ImporteMonetario = @SumaCargosMonetario 
        ELSE SELECT @ImporteMonetario = @SumaAbonosMonetario 

        SELECT @ImporteMonetario = @ImporteMonetario / @RelevanteTipoCambio

        IF (@ImporteMonetario >= @CfgOperacionRelevante) OR 
           (@SumaCargosDolarMonetario >= @CfgOperacionRelevante) OR 
           (@SumaAbonosDolarMonetario >= @CfgOperacionRelevante) 
          SELECT @Relevante = 1

        IF @Relevante = 1
          IF @CteCategoria IN (@CfgCategoriaRelevante1, @CfgCategoriaRelevante2)
            SELECT @Relevante = 0
      END

      IF @SumaRemesas > 0.0
      BEGIN
        SELECT @LimiteRemesas = ISNULL(CreditoLimite*Mon.TipoCambio, 0.0),
               @TipoCambioRemesas = Mon.TipoCambio
          FROM Cte, Mon
         WHERE Cliente = @Cliente AND Cte.CreditoMoneda = Mon.Moneda AND CreditoEspecial = 1 AND CreditoConLimite = 1
        IF @@ROWCOUNT > 0
        BEGIN
          SELECT @RemesasAnteriores = SUM(ISNULL(d.Monto, 0.0)*m.TipoCambio)
            FROM Cambio c, CambioD d, MovTipo mt, Instrumento i, Mon m
           WHERE c.ID = d.ID AND c.FechaEmision BETWEEN DATEADD(day, -@CfgDiasRemesas+1, @FechaEmision) AND @FechaEmision AND c.Cliente = @Cliente 
             AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
             AND UPPER(d.Tipo) IN ('COMPRA', 'COBRO') AND d.Instrumento = i.Instrumento AND i.Tipo = 'REMESA'
             AND i.Moneda = m.Moneda
        END
        IF @LimiteRemesas < ISNULL(@SumaRemesas, 0) + ISNULL(@RemesasAnteriores, 0)
          SELECT @Ok = 35270, @OkRef = CONVERT(char, (ISNULL(@SumaRemesas, 0) + ISNULL(@RemesasAnteriores, 0) - @LimiteRemesas) / @TipoCambioRemesas)
      END

      IF @EstatusNuevo = 'CANCELADO' SELECT @FechaCancelacion = @FechaRegistro ELSE SELECT @FechaCancelacion = NULL
      IF @EstatusNuevo = 'CONCLUIDO' SELECT @FechaConclusion  = @FechaEmision  ELSE IF @EstatusNuevo <> 'CANCELADO' SELECT @FechaConclusion  = NULL
      IF @CfgContX = 1 AND @CfgContXGenerar <> 'NO'
      BEGIN
	IF @Estatus =  'SINAFECTAR' AND @EstatusNuevo <> 'CANCELADO' SELECT @GenerarPoliza = 1 ELSE
        IF @Estatus <> 'SINAFECTAR' AND @EstatusNuevo =  'CANCELADO' IF @GenerarPoliza = 1 SELECT @GenerarPoliza = 0 ELSE SELECT @GenerarPoliza = 1
      END  

      EXEC spEmbarqueMov @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @Estatus, @EstatusNuevo, @CfgEmbarcar, @Ok OUTPUT
      EXEC spValidarTareas @Empresa, @Modulo, @ID, @EstatusNuevo, @Ok OUTPUT, @OkRef OUTPUT
      UPDATE Cambio
         SET FechaConclusion  = @FechaConclusion, 
             FechaCancelacion = @FechaCancelacion, 
             UltimoCambio     = /*CASE WHEN UltimoCambio IS NULL THEN */@FechaRegistro /*ELSE UltimoCambio END*/,
	     Vencimiento      = @Vencimiento,
             Concepto	      = @Concepto,
             Estatus          = @EstatusNuevo,
	     Situacion 	      = CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
             GenerarPoliza    = @GenerarPoliza,
             Relevante	      = @Relevante,
             ParaisoFiscal    = @ParaisoFiscal,
             CiudadRiesgo     = @CiudadRiesgo,
             ImporteMN	      = @SumaImporte,
             DeTerceros	      = @SumaInversionRetiro/NULLIF(@SumaImporte, 0.0)
       WHERE ID = @ID 
      IF @@ERROR <> 0 SELECT @Ok = 1

      IF @Relevante = 1
      BEGIN
        UPDATE CambioD 
           SET Relevante = 1 
          FROM CambioD d
          JOIN Instrumento i ON i.Instrumento = d.Instrumento AND UPPER(i.Tipo) = 'MONETARIO'
         WHERE d.ID = @ID 

        UPDATE Cambio
           SET Relevante = 1 
         WHERE ID IN (SELECT DISTINCT c.ID 
            FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
           WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
             AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
             AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO' AND i.Moneda <> @CfgMonedaRelevante)

        UPDATE CambioD 
           SET Relevante = 1 
          FROM CambioD d
          JOIN Instrumento i ON i.Instrumento = d.Instrumento AND UPPER(i.Tipo) = 'MONETARIO'
         WHERE d.ID IN (SELECT DISTINCT c.ID 
            FROM Cambio c, CambioD d, MovTipo mt, Instrumento i
           WHERE c.ID = d.ID AND c.FechaEmision = @FechaEmision AND c.Cliente = @Cliente 
             AND mt.Modulo = 'CAM' AND mt.Mov = c.Mov AND mt.Clave IN ('CAM.O', 'CAM.V') AND c.Estatus = 'CONCLUIDO'
             AND d.Instrumento = i.Instrumento AND i.Tipo = 'MONETARIO' AND i.Moneda <> @CfgMonedaRelevante)
      END
    END

    -- Validaciones Extras
    SELECT @Ventas = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d
     WHERE c.Empresa = @Empresa AND c.FechaEmision = @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'VENTA'

    SELECT @Compras = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d
     WHERE c.Empresa = @Empresa AND c.FechaEmision = @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'COMPRA'

    -- Validar Operacion Limite 
    IF (SELECT ISNULL(CambioAutorizarOperacionLimite, 0) FROM Usuario WHERE Usuario = @Usuario) = 0
    BEGIN
      SELECT @OperacionLimite = ISNULL(OperacionLimite, 0.0) FROM Cte WHERE Cliente = @Cliente
      IF @OperacionLimite > 0.0
        IF @Ventas > @OperacionLimite OR @Compras > @OperacionLimite
          SELECT @Ok = 65100
    END

    -- Documentacion Completa
    IF @Ventas >= @CfgOperacionRelevante OR @Compras >= @CfgOperacionRelevante
      IF (SELECT ISNULL(DocumentacionCompleta, 0) FROM Cte WHERE Cliente = @Cliente) = 0
        SELECT @Ok = 10430

    -- Candidatos Inusual Suma de Operaciones Relvantes de los ultimos cinco dias Instrumento.Tipo = 'Monetario'
    SELECT @CfgDiasHabiles = DiasHabiles
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    EXEC spCalcularDiasHabiles @FechaEmision, -4, @CfgDiasHabiles, 0, @FechaInicial OUTPUT

    SELECT @Ventas = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d, Instrumento i
     WHERE c.Empresa = @Empresa AND c.FechaEmision BETWEEN @FechaInicial AND @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'VENTA' AND d.Instrumento = i.Instrumento AND i.Tipo = 'Monetario'
       AND c.Relevante = 0 

    SELECT @Compras = ISNULL(SUM(d.MontoDolares), 0.0)
      FROM Cambio c, CambioD d, Instrumento i
     WHERE c.Empresa = @Empresa AND c.FechaEmision BETWEEN @FechaInicial AND @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
       AND c.ID = d.ID AND UPPER(d.Tipo) = 'COMPRA' AND d.Instrumento = i.Instrumento AND i.Tipo = 'Monetario'
       AND c.Relevante = 0 

    IF @CteCategoria NOT IN (@CfgCategoriaRelevante1, @CfgCategoriaRelevante2)
      IF @Ventas >= @CfgOperacionRelevante OR @Compras >= @CfgOperacionRelevante
        UPDATE Cambio
           SET CandidatoInsusual = 1 
          FROM Cambio c, CambioD d, Instrumento i
         WHERE c.Empresa = @Empresa AND c.FechaEmision BETWEEN @FechaInicial AND @FechaEmision AND c.Estatus = 'CONCLUIDO' AND c.Cliente = @Cliente
           AND c.ID = d.ID AND UPPER(d.Tipo) IN ('VENTA', 'COMPRA') AND d.Instrumento = i.Instrumento AND i.Tipo = 'Monetario'
           AND c.Relevante = 0 
/*
        UPDATE Cambio
           SET CandidatoInsusual = 1 
         WHERE Empresa = @Empresa AND FechaEmision BETWEEN @FechaInicial AND @FechaEmision AND Estatus = 'CONCLUIDO' AND Cliente = @Cliente
           AND Relevante = 0*/

  -- Agregar a Estatus Log
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
    EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

  -- Cancelar el Flujo
  IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
    EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT

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

/**************** spCambio ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambio') and type = 'P') drop procedure dbo.spCambio
GO
CREATE PROCEDURE spCambio
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
    @FechaEmision     		datetime,
    @Concepto	      		varchar(50),
    @Proyecto	      		varchar(50),
    @MovUsuario	      		char(10),
    @Autorizacion     		char(10),
    @Referencia	      		varchar(50),
    @DocFuente	      		int,
    @Observaciones    		varchar(255),
    @Estatus          		char(15),
    @EstatusNuevo		char(15),
    @Ejercicio	      		int,
    @Periodo	      		int,
    @GenerarPoliza		bit,
    @CfgContX			bit,
    @CfgContXGenerar		char(20),
    @CfgContMoneda		char(10),
    @CfgOperacionRelevante	money,
    @CfgMonedaRelevante		char(10),
    @CfgCategoriaRelevante1	varchar(50),
    @CfgCategoriaRelevante2	varchar(50),
    @CfgDiasRemesas		int,
    @CfgValidarCobertura	bit,

    @Cliente		        char(10),
    @Condicion			varchar(50),
    @Vencimiento		datetime/*,
    @Verificar			bit*/

  -- Inicializar Variables
  SELECT @CfgContX        = 0,
         @CfgContXGenerar = 'NO'/*,
         @Verificar	  = 1*/

  IF @Accion = 'CANCELAR' SELECT @EstatusNuevo = 'CANCELADO' ELSE SELECT @EstatusNuevo = 'CONCLUIDO' 

  IF (SELECT CambioBloquear FROM Empresa WHERE Empresa = @Empresa) = 1 SELECT @Ok = 35155

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Concepto = Concepto, @Proyecto = Proyecto,
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, @Referencia = Referencia,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @Cliente = NULLIF(RTRIM(Cliente), ''), @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento,
	 @GenerarPoliza = GenerarPoliza
    FROM Cambio
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1
  
  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  EXEC spMovTipo @Modulo, @Mov, @FechaRegistro, @Empresa, @Estatus, @Concepto OUTPUT, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaEmision, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

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

  IF (@Accion <> 'CANCELAR' AND @Estatus = 'SINAFECTAR') OR 
     (@Accion = 'CANCELAR'  AND @Estatus = 'CONCLUIDO')
  BEGIN
    SELECT @CfgContX = ContX
      FROM EmpresaGral
     WHERE Empresa = @Empresa
    IF @@ERROR <> 0 SELECT @Ok = 1

   SELECT @CfgValidarCobertura = CambioValidarCobertura
     FROM Usuario
    WHERE Usuario = @Usuario

    SELECT @CfgContMoneda = NULLIF(RTRIM(ContMoneda), ''),
           @CfgOperacionRelevante  = CambioOperacionRelevante,
           @CfgMonedaRelevante     = CambioMonedaRelevante,
	   @CfgCategoriaRelevante1 = CambioCategoriaRelevante1,
	   @CfgCategoriaRelevante2 = CambioCategoriaRelevante2,
           @CfgDiasRemesas         = CambioDiasRemesas
      FROM EmpresaCfg
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
      EXEC spCambioVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @FechaEmision, @Estatus, 
			     @Cliente, @Condicion, @Vencimiento, @FechaRegistro, 
			     @CfgValidarCobertura, @CfgOperacionRelevante, @CfgMonedaRelevante,
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
    
    IF @Accion IN ('AFECTAR','CANCELAR','CONSECUTIVO','SINCRO') AND @MovTipo <> 'CAM.C' AND @Ok IS NULL
      EXEC spCambioAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, 
                           @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 
                           @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, 
                           @Cliente, @Condicion, @Vencimiento, 
		           @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen,   
			   @CfgOperacionRelevante, @CfgMonedaRelevante, @CfgCategoriaRelevante1, @CfgCategoriaRelevante2, @CfgDiasRemesas,
                           @CfgContMoneda, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                           @Ok OUTPUT, @OkRef OUTPUT

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
    SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO


/**************** spVerCambioDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCambioDinero') and type = 'P') drop procedure dbo.spVerCambioDinero
GO
CREATE PROCEDURE spVerCambioDinero
    		   @Empresa	 		char(5), 
                   @Fecha	 		datetime,
		   @Moneda			char(10),
		   @OtrosIngresos		money	OUTPUT,
		   @OtrosEgresos		money	OUTPUT,
		   @DepositosAnticipados	money	OUTPUT,
		   @SolicitudesDeposito		money	OUTPUT,
		   @SolicitudesCheque		money	OUTPUT,

		   @Sucursal			int = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
     @Manana		datetime,
     @AjusteEfectivoCxc	money,
     @AjusteEfectivoCxp	money, 
     @AjusteEfectivo	money

  SELECT @OtrosIngresos	       = 0.0, 
         @OtrosEgresos         = 0.0,
	 @DepositosAnticipados = 0.0,
         @SolicitudesDeposito  = 0.0,
         @SolicitudesCheque    = 0.0


  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @Manana = DATEADD(day, 1, @Fecha)

  SELECT @OtrosIngresos = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.AB'
     AND Dinero.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND Dinero.Sucursal = ISNULL(@Sucursal, Dinero.Sucursal)

  SELECT @OtrosEgresos = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.CB'
     AND Dinero.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND Dinero.Sucursal = ISNULL(@Sucursal, Dinero.Sucursal)

  SELECT @AjusteEfectivoCxc = SUM(ISNULL(Importe, 0.0))
    FROM Cxc, MovTipo 
   WHERE Cxc.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Cxc.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'CXC'
     AND MovTipo.Clave IN ('CXC.AJE', 'CXC.AJR')
     AND Cxc.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND Cxc.Sucursal = ISNULL(@Sucursal, Cxc.Sucursal)

  SELECT @AjusteEfectivoCxp = SUM(ISNULL(Importe, 0.0))
    FROM Cxp, MovTipo 
   WHERE Cxp.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Cxp.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'CXP'
     AND MovTipo.Clave IN ('CXP.AJE', 'CXP.AJR')
     AND Cxp.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     AND Cxp.Sucursal = ISNULL(@Sucursal, Cxp.Sucursal)

  SELECT @DepositosAnticipados = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.DA'
     AND Dinero.Estatus = 'PENDIENTE'
     AND Dinero.Sucursal = ISNULL(@Sucursal, Dinero.Sucursal)

  SELECT @SolicitudesDeposito = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.SD'
     AND Dinero.Estatus = 'PENDIENTE'
     AND Dinero.Sucursal = ISNULL(@Sucursal, Dinero.Sucursal)

  SELECT @SolicitudesCheque = SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaEmision >= @Fecha AND FechaEmision < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.SCH'
     AND Dinero.Estatus = 'PENDIENTE'
     AND Dinero.Sucursal = ISNULL(@Sucursal, Dinero.Sucursal)

/*
  SELECT @DepositosAnticipados = @DepositosAnticipados - ISNULL(SUM(ISNULL(Importe, 0.0) + ISNULL(Impuestos, 0.0)), 0.0) 
    FROM Dinero, MovTipo 
   WHERE Dinero.Empresa = @Empresa 
     AND FechaConclusion >= @Fecha AND FechaConclusion < @Manana
     AND Dinero.Mov = MovTipo.Mov
     AND Moneda = @Moneda
     AND MovTipo.Modulo = 'DIN'
     AND MovTipo.Clave = 'DIN.DA'
     AND Dinero.Estatus = 'CONCLUIDO'
*/
  SELECT @OtrosIngresos	       = ISNULL(@OtrosIngresos, 0.0), 
         @OtrosEgresos         = ISNULL(@OtrosEgresos, 0.0),
	 @DepositosAnticipados = ISNULL(@DepositosAnticipados, 0.0)
  SELECT @AjusteEfectivo = ISNULL(@AjusteEfectivoCxc, 0.0) - ISNULL(@AjusteEfectivoCxp, 0.0)

  IF @AjusteEfectivo > 0.0 
    SELECT @OtrosIngresos = @OtrosIngresos + @AjusteEfectivo 
  ELSE
    SELECT @OtrosEgresos = @OtrosEgresos - @AjusteEfectivo 

  RETURN
END
GO

/**************** spCambioPosicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioPosicion') and type = 'P') drop procedure dbo.spCambioPosicion
GO
CREATE PROCEDURE spCambioPosicion
			@Estacion		int,
			@Empresa		char(5),
			@Fecha			datetime,
			@Moneda			char(10),

                   	@OcultarResultados	bit   = 0	OUTPUT,
			@Saldo48		money = NULL	OUTPUT,
			@Posicion48		money = NULL	OUTPUT,

			@Sucursal		int   = NULL
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @DiasHabiles	  char(20),
    @TipoCambio		  float,
    @Cerrado		  bit,
    @Vencimiento	  datetime,
    @Hoy		  datetime,
    @24			  datetime,
    @48			  datetime,
    @Inicio		  money,
    @VentaHoy		  money,
    @Venta24		  money,
    @Venta48		  money,
    @VentaHoyMN		  money,
    @Venta24MN		  money,
    @Venta48MN		  money,
    @OtrosIngresos  	  money,	
    @OtrosEgresos	  money,
    @DepositosAnticipados money,
    @CompraHoy		  money,
    @Compra24		  money,
    @Compra48		  money,
    @CompraHoyMN	  money,
    @Compra24MN		  money,
    @Compra48MN		  money,
    @BancosHoy		  money,
    @Bancos24		  money,
    @CxcHoy		  money,
    @Cxc24		  money,
    @Cxc48		  money,
    @CxcMas		  money,
    @CxpHoy		  money,
    @Cxp24		  money,
    @Cxp48		  money,
    @CxpMas		  money,
    @Saldo		  money,
    @SaldoHoy		  money,
    @Saldo24		  money,
    @PosicionHoy	  money,
    @Posicion24		  money,
    @SolicitudesDeposito  money,
    @SolicitudesCheque	  money

  SELECT @CxcHoy 		= 0.0,
    	 @Cxc24  		= 0.0,
    	 @Cxc48	 		= 0.0,
    	 @CxcMas 		= 0.0,
    	 @CxpHoy 		= 0.0,
    	 @Cxp24	 		= 0.0,
    	 @Cxp48	 		= 0.0,
    	 @CxpMas 		= 0.0,	
    	 @OtrosIngresos         = 0.0,
    	 @OtrosEgresos          = 0.0, 
    	 @DepositosAnticipados  = 0.0,
         @SolicitudesDeposito   = 0.0,
         @SolicitudesCheque     = 0.0,
         @Cerrado		= 0

  SELECT @DiasHabiles = 'LUN-VIE'

  EXEC spExtraerFecha @Fecha OUTPUT
  SELECT @Hoy = @Fecha
  EXEC spCalcularDiasHabiles @Fecha, 1, @DiasHabiles, 1, @24 OUTPUT
  EXEC spCalcularDiasHabiles @Fecha, 2, @DiasHabiles, 1, @48 OUTPUT
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  SELECT @BancosHoy = ISNULL(SUM(Saldo), 0.0) 
    FROM DineroSaldoSucursal s, CtaDinero cta
   WHERE s.CtaDinero = cta.CtaDinero 
     AND s.Empresa = @Empresa 
     AND s.Moneda  = @Moneda 
     AND cta.Uso = 'Operacion'
     AND s.Sucursal = ISNULL(@Sucursal, s.Sucursal)

  SELECT @Bancos24 = ISNULL(SUM(Saldo), 0.0) 
    FROM DineroSaldoSucursal s, CtaDinero cta
   WHERE s.CtaDinero = cta.CtaDinero 
     AND s.Empresa = @Empresa 
     AND s.Moneda  = @Moneda 
     AND cta.Uso = 'Inversion'
     AND s.Sucursal = ISNULL(@Sucursal, s.Sucursal)

  DECLARE crCxc CURSOR FOR
   SELECT Vencimiento, ISNULL(SUM(Saldo), 0.0)
     FROM Cxc 
    WHERE Cxc.Empresa       = @Empresa
      AND Cxc.ClienteMoneda = @Moneda
      AND Cxc.Estatus       = 'PENDIENTE'
      AND Sucursal = ISNULL(@Sucursal, Sucursal)
    GROUP BY Vencimiento
    ORDER BY Vencimiento

  OPEN crCxc
  FETCH NEXT FROM crCxc INTO @Vencimiento, @Saldo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spExtraerFecha @Vencimiento OUTPUT
      IF @Vencimiento <= @Hoy SELECT @CxcHoy = @CxcHoy + @Saldo ELSE
      IF @Vencimiento = @24   SELECT @Cxc24  = @Cxc24  + @Saldo ELSE
      IF @Vencimiento = @48   SELECT @Cxc48  = @Cxc48  + @Saldo 
      ELSE SELECT @CxcMas = @CxcMas + @Saldo      
    END
    FETCH NEXT FROM crCxc INTO @Vencimiento, @Saldo
  END  
  CLOSE crCxc
  DEALLOCATE crCxc

  DECLARE crCxp CURSOR FOR
   SELECT Vencimiento, ISNULL(SUM(Saldo), 0.0)
     FROM Cxp
    WHERE Cxp.Empresa         = @Empresa
      AND Cxp.ProveedorMoneda = @Moneda
      AND Cxp.Estatus         = 'PENDIENTE'
      AND Sucursal = ISNULL(@Sucursal, Sucursal)
    GROUP BY Vencimiento
    ORDER BY Vencimiento

  OPEN crCxp
  FETCH NEXT FROM crCxp INTO @Vencimiento, @Saldo
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spExtraerFecha @Vencimiento OUTPUT
      IF @Vencimiento <= @Hoy SELECT @CxpHoy = @CxpHoy + @Saldo ELSE
      IF @Vencimiento = @24   SELECT @Cxp24  = @Cxp24  + @Saldo ELSE
      IF @Vencimiento = @48   SELECT @Cxp48  = @Cxp48  + @Saldo 
      ELSE SELECT @CxpMas = @CxpMas + @Saldo      
    END
    FETCH NEXT FROM crCxp INTO @Vencimiento, @Saldo
  END  
  CLOSE crCxp
  DEALLOCATE crCxp

  EXEC spVerCambioDinero @Empresa, @Fecha, @Moneda, 
                         @OtrosIngresos OUTPUT, @OtrosEgresos OUTPUT, @DepositosAnticipados OUTPUT,
                         @SolicitudesDeposito OUTPUT, @SolicitudesCheque OUTPUT,
                         @Sucursal

  SELECT @CxcHoy = @CxcHoy + ISNULL(@SolicitudesDeposito, 0),
         @CxpHoy = @CxpHoy + ISNULL(@SolicitudesCheque, 0)

  SELECT @Inicio      = ISNULL(SUM(Inicio), 0.0),
         @VentaHoy    = ISNULL(SUM(VentaHoy), 0.0),    @Venta24    = ISNULL(SUM(Venta24), 0.0),    @Venta48    = ISNULL(SUM(Venta48), 0.0),
         @VentaHoyMN  = ISNULL(SUM(VentaHoyMN), 0.0),  @Venta24MN  = ISNULL(SUM(Venta24MN), 0.0),  @Venta48MN  = ISNULL(SUM(Venta48MN), 0.0),
         @CompraHoy   = ISNULL(SUM(CompraHoy), 0.0),   @Compra24   = ISNULL(SUM(Compra24), 0.0),   @Compra48   = ISNULL(SUM(Compra48), 0.0), 
         @CompraHoyMN = ISNULL(SUM(CompraHoyMN), 0.0), @Compra24MN = ISNULL(SUM(Compra24MN), 0.0), @Compra48MN = ISNULL(SUM(Compra48MN), 0.0)
    FROM CambioAcum
   WHERE Empresa  = @Empresa 
     AND Sucursal = ISNULL(@Sucursal, Sucursal)
     AND Fecha    = @Fecha
     AND Moneda   = @Moneda

  SELECT @Cerrado = ISNULL(Cerrado, 0)
    FROM CambioAcum
   WHERE Empresa  = @Empresa 
     AND Sucursal = ISNULL(@Sucursal, Sucursal)
     AND Fecha    = @Fecha
     AND Moneda   = @Moneda

  IF @TipoCambio = 1.0
  BEGIN
    SELECT @SaldoHoy = @Inicio   - @CompraHoy + @VentaHoy + @OtrosIngresos - @OtrosEgresos + @DepositosAnticipados
    SELECT @Saldo24  = @SaldoHoy - @Compra24 + @Venta24
    SELECT @Saldo48  = @Saldo24  - @Compra48 + @Venta48
  END 
  ELSE BEGIN
    SELECT @SaldoHoy = @Inicio   + @CompraHoy - @VentaHoy + @OtrosIngresos - @OtrosEgresos + @DepositosAnticipados
    SELECT @Saldo24  = @SaldoHoy + @Compra24 - @Venta24
    SELECT @Saldo48  = @Saldo24  + @Compra48 - @Venta48
  END

  SELECT @PosicionHoy = @BancosHoy   - @CxpHoy   + @CxcHoy
  SELECT @Posicion24  = @PosicionHoy + @Bancos24 - @Cxp24 + @Cxc24
  SELECT @Posicion48  = @Posicion24   - @Cxp48   + @Cxc48

  IF @OcultarResultados = 0 
  INSERT INTO VerCambioPos (Estacion, Empresa, Sucursal, Fecha, Moneda, Cerrado, FechaHoy, Fecha24, Fecha48,
                            Inicio, VentaHoy, Venta24, Venta48, VentaHoyMN, Venta24MN, Venta48MN,
			    OtrosIngresos, OtrosEgresos, DepositosAnticipados,
			    CompraHoy, Compra24, Compra48, CompraHoyMN, Compra24MN, Compra48MN,
			    BancosHoy, Bancos24, 
			    CxcHoy, Cxc24, Cxc48, CxcMas, 
			    CxpHoy, Cxp24, Cxp48, CxpMas,
			    Saldo, SaldoHoy, Saldo24, Saldo48,
			    PosicionHoy, Posicion24, Posicion48)
                    VALUES (@Estacion, @Empresa, @Sucursal, @Fecha, @Moneda, @Cerrado, @Hoy, @24, @48,
                            @Inicio, @VentaHoy, @Venta24, @Venta48, @VentaHoyMN, @Venta24MN, @Venta48MN,
			    @OtrosIngresos, @OtrosEgresos, @DepositosAnticipados,
			    @CompraHoy, @Compra24, @Compra48, @CompraHoyMN, @Compra24MN, @Compra48MN,
			    @BancosHoy, @Bancos24, 
			    @CxcHoy, @Cxc24, @Cxc48, @CxcMas, 
			    @CxpHoy, @Cxp24, @Cxp48, @CxpMas,
			    @Saldo, @SaldoHoy, @Saldo24, @Saldo48,
			    @PosicionHoy, @Posicion24, @Posicion48)
  RETURN
END
GO


/**************** spVerCambioPosicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCambioPosicion') and type = 'P') drop procedure dbo.spVerCambioPosicion
GO
CREATE PROCEDURE spVerCambioPosicion
			@Estacion		int,
			@Empresa		char(5),
			@Fecha			datetime,
			@Moneda			char(10),
			@Sucursal		int = NULL
--//WITH ENCRYPTION
AS BEGIN
  DELETE FROM VerCambioPos WHERE Estacion = @Estacion
  EXEC spCambioPosicion @Estacion, @Empresa, @Fecha, @Moneda, @Sucursal = @Sucursal
  SELECT * FROM VerCambioPos WHERE Estacion = @Estacion
END
GO



/**************** spCalcCambioPosiciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCalcCambioPosiciones') and type = 'P') drop procedure dbo.spCalcCambioPosiciones
GO
CREATE PROCEDURE spCalcCambioPosiciones
			@Estacion		int,
			@Empresa		char(5),
			@Fecha			datetime,
			@Sucursal		int = NULL

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda		  char(10)

  DELETE FROM VerCambioPos WHERE Estacion = @Estacion
  DECLARE crMon CURSOR FOR SELECT Moneda FROM Mon
  OPEN crMon
  FETCH NEXT FROM crMon INTO @Moneda
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
      EXEC spCambioPosicion @Estacion, @Empresa, @Fecha, @Moneda, @Sucursal = @Sucursal
    FETCH NEXT FROM crMon INTO @Moneda
  END  
  CLOSE crMon
  DEALLOCATE crMon
  RETURN
END
GO

/**************** spVerCambioPosiciones ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCambioPosiciones') and type = 'P') drop procedure dbo.spVerCambioPosiciones
GO
CREATE PROCEDURE spVerCambioPosiciones
			@Estacion		int,
			@Empresa		char(5),
			@Fecha			datetime,
			@Sucursal		int	= NULL

--//WITH ENCRYPTION
AS BEGIN
  IF @Sucursal<0 SELECT @Sucursal = NULL
  EXEC spCalcCambioPosiciones @Estacion, @Empresa, @Fecha, @Sucursal = @Sucursal
  SELECT v.* 
    FROM VerCambioPos v, Mon 
   WHERE Estacion = @Estacion
     AND v.Moneda = Mon.Moneda
     AND (ISNULL(Inicio, 0) <> 0
      OR ISNULL(VentaHoy, 0) <> 0
      OR ISNULL(Venta24, 0) <> 0
      OR ISNULL(Venta48, 0) <> 0
      OR ISNULL(VentaHoyMN, 0) <> 0
      OR ISNULL(Venta24MN, 0) <> 0
      OR ISNULL(Venta48MN, 0) <> 0
      OR ISNULL(OtrosIngresos, 0) <> 0
      OR ISNULL(OtrosEgresos, 0) <> 0
      OR ISNULL(DepositosAnticipados, 0) <> 0
      OR ISNULL(CompraHoy, 0) <> 0
      OR ISNULL(Compra24, 0) <> 0
      OR ISNULL(Compra48, 0) <> 0
      OR ISNULL(CompraHoyMN, 0) <> 0
      OR ISNULL(Compra24MN, 0) <> 0
      OR ISNULL(Compra48MN, 0) <> 0
      OR ISNULL(BancosHoy, 0) <> 0
      OR ISNULL(Bancos24, 0) <> 0
      OR ISNULL(CxcHoy, 0) <> 0
      OR ISNULL(Cxc24, 0) <> 0
      OR ISNULL(Cxc48, 0) <> 0
      OR ISNULL(CxcMas, 0) <> 0
      OR ISNULL(CxpHoy, 0) <> 0
      OR ISNULL(Cxp24, 0) <> 0
      OR ISNULL(Cxp48, 0) <> 0
      OR ISNULL(CxpMas, 0) <> 0
      OR ISNULL(Saldo, 0) <> 0
      OR ISNULL(SaldoHoy, 0) <> 0
      OR ISNULL(Saldo24, 0) <> 0
      OR ISNULL(Saldo48, 0) <> 0
      OR ISNULL(PosicionHoy, 0) <> 0
      OR ISNULL(Posicion24, 0) <> 0
      OR ISNULL(Posicion48, 0) <> 0)
  ORDER BY Mon.Orden, v.Estacion
END
GO

/**************** spVerCambioUtil ****************/
if exists (select * from sysobjects where id = object_id('dbo.spVerCambioUtil') and type = 'P') drop procedure dbo.spVerCambioUtil
GO
CREATE PROCEDURE spVerCambioUtil
			@Estacion	int,
			@Empresa	char(5),
			@FechaD		datetime,
			@FechaA		datetime,
                        @Sucursal	int

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @Moneda		char(10),
    @CfgContMoneda	char(10),
    @Inicio		money, 
    @InicioMN		money, 
    @InicioTC		float, 
    @Compra		money, 
    @CompraMN		money, 
    @CompraTC		float, 
    @Venta		money,
    @VentaMN		money, 
    @VentaTC		float, 
    @Final		money, 
    @FinalMN		money, 
    @FinalTC		float,
    @UtilidadMN		money,
    @FechaIni		datetime,
    @FechaFin		datetime

  DELETE FROM VerCambioUtil WHERE Estacion = @Estacion
  SELECT @CfgContMoneda = NULLIF(RTRIM(ContMoneda), '')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  DECLARE crMon CURSOR FOR SELECT Moneda FROM Mon WHERE Moneda <> @CfgContMoneda
  OPEN crMon
  FETCH NEXT FROM crMon INTO @Moneda
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2
    BEGIN
      SELECT @FechaIni = MIN(Fecha) 
        FROM CambioAcum 
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Moneda = @Moneda AND Fecha >= @FechaD 

      SELECT @FechaFin = MAX(Fecha) 
        FROM CambioAcum 
       WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Moneda = @Moneda AND Fecha <= @FechaA AND (VentaHoy IS NOT NULL OR CompraHoy IS NOT NULL)

     SELECT @Inicio = Inicio, @InicioMN = InicioMN 
       FROM CambioAcum 
      WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Moneda = @Moneda AND Fecha = @FechaIni 

     SELECT @Compra   = SUM(ISNULL(CompraHoy, 0.0)   + ISNULL(Compra24, 0.0)   + ISNULL(Compra48, 0.0)),
            @CompraMN = SUM(ISNULL(CompraHoyMN, 0.0) + ISNULL(Compra24MN, 0.0) + ISNULL(Compra48MN, 0.0)), 
            @Venta    = SUM(ISNULL(VentaHoy, 0.0)    + ISNULL(Venta24, 0.0)    + ISNULL(Venta48, 0.0)), 
            @VentaMN  = SUM(ISNULL(VentaHoyMN, 0.0)  + ISNULL(Venta24MN, 0.0)  + ISNULL(Venta48MN, 0.0)) 
       FROM CambioAcum 
      WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Moneda = @Moneda AND Fecha BETWEEN @FechaIni AND @FechaFin

     SELECT @Final = @Inicio + @Compra - @Venta
     SELECT @InicioTC = @InicioMN / NULLIF(@Inicio, 0.0), 
            @CompraTC = @CompraMN / NULLIF(@Compra, 0.0),
            @VentaTC  = @VentaMN  / NULLIF(@Venta, 0.0)

    SELECT @FinalTC = FinalMN / NULLIF(Final, 0.0) 
      FROM CambioAcumFinal
     WHERE Sucursal = @Sucursal AND Empresa = @Empresa AND Fecha = @FechaFin AND Moneda = @Moneda

    SELECT @FinalMN = @Final * @FinalTC

     SELECT @UtilidadMN = -(ISNULL(@InicioMN, 0.0) + ISNULL(@CompraMN, 0.0) - ISNULL(@VentaMN, 0.0) - ISNULL(@FinalMN, 0.0))
     INSERT VerCambioUtil (Estacion,  Empresa,  FechaD,    FechaA,    Moneda,  Inicio,  InicioMN,  InicioTC,  Compra,  CompraMN,  CompraTC,  Venta,  VentaMN,  VentaTC,  Final,  FinalMN,  FinalTC,  UtilidadMN)
                   VALUES (@Estacion, @Empresa, @FechaIni, @FechaFin, @Moneda, @Inicio, @InicioMN, @InicioTC, @Compra, @CompraMN, @CompraTC, @Venta, @VentaMN, @VentaTC, @Final, @FinalMN, @FinalTC, @UtilidadMN)
    END
    FETCH NEXT FROM crMon INTO @Moneda
  END  
  CLOSE crMon
  DEALLOCATE crMon
END
GO

/**************** spCambioCerrarCxp ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioCerrarCxp') and type = 'P') drop procedure dbo.spCambioCerrarCxp
GO

/*
CREATE PROCEDURE spCambioCerrarCxp
    		   @Empresa	 char(5),
		   @Fecha	 datetime,
  	      	   @Ok		 int	OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @ID			int,
    @FechaRegistro	datetime,
    @Mov		char(20),
    @MovID		varchar(20),
    @GenerarMov		char(20),
    @Mov1		char(20),
    @Mov2		char(20),
    @IDGenerar		int,
    @OkRef		varchar(255)

  SELECT @GenerarMov = 'Pago',
         @Mov1       = 'Venta',
         @Mov2       = 'Compra',
         @FechaRegistro = GETDATE()

  DECLARE crCxp CURSOR FOR 
   SELECT ID 
     FROM Cxp 
    WHERE Empresa = @Empresa 
      AND Mov IN (@Mov1, @Mov2)
      AND Estatus = 'PENDIENTE'
      AND Vencimiento = @Fecha

  OPEN crCxp
  FETCH NEXT FROM crCxp INTO @ID
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
    BEGIN
      EXEC spCx @ID, 'CXP', 'GENERAR', 'TODO', @FechaRegistro, @GenerarMov, NULL, 1, 0,
                @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                @Ok OUTPUT, @OkRef OUTPUT

      IF @Ok = 80030 SELECT @Ok = NULL
      IF @Ok IS NULL AND @IDGenerar IS NOT NULL
        EXEC spCx @IDGenerar, 'CXP', 'AFECTAR', 'TODO', @FechaRegistro, NULL, NULL, 1, 0,
                  @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
                  @Ok OUTPUT, @OkRef OUTPUT
    END
    FETCH NEXT FROM crCxp INTO @ID
  END  
  CLOSE crCxp
  DEALLOCATE crCxp

  RETURN
END
*/
GO


-- spCambioCerrarDia 'DEMO' 
/**************** spCambioCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCambioCerrarDia') and type = 'P') drop procedure dbo.spCambioCerrarDia
GO
CREATE PROCEDURE spCambioCerrarDia
    		   @Empresa	 char(5), 
                   @Fecha	 datetime = NULL,
                   @Sucursal	 int = 0
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Estacion			int,
    @Inicio			money,
    @InicioMN			money,
    @InicioMNAnterior		money,
    @Volumen			money,
    @VolumenMN			money,
    @VentaHoy			money,
    @CompraHoy			money,
    @OtrosIngresos 		money,
    @OtrosEgresos 		money, 
    @DepositosAnticipados 	money,
    @Saldo48 			money, 
    @Posicion48 		money,
    @SolicitudesDeposito  	money,
    @SolicitudesCheque	  	money,
    @UltimaFecha		datetime,
    @Mensaje			varchar(255),
    @CfgContMoneda		char(10),
    @UnDia			datetime,
    @DosDias			datetime,
    @Moneda			char(10),
    @DiasHabiles		char(20),
    @DiasNaturales48Horas	int,
    @Ok				int

  SELECT @Ok = NULL, @UltimaFecha = NULL, @Estacion = 9999
  IF @Fecha IS NULL
    SELECT @Fecha = GETDATE()
  EXEC spExtraerFecha @Fecha OUTPUT

  EXEC spCalcCambioPosiciones @Estacion, @Empresa, @Fecha, @Sucursal = @Sucursal

  IF (SELECT SUM(ROUND(ISNULL(CxcHoy, 0), 0)+ROUND(ISNULL(CxpHoy, 0), 0)) FROM VerCambioPos WHERE Estacion = @Estacion AND Empresa = @Empresa AND Sucursal = @Sucursal AND Fecha = @Fecha) <> 0.0
    SELECT @Ok = 35260

  SELECT @DiasHabiles = UPPER(DiasHabiles)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @CfgContMoneda = NULLIF(RTRIM(ContMoneda), '')
    FROM EmpresaCfg
   WHERE Empresa = @Empresa

  SELECT @UltimaFecha = MAX(Fecha) FROM CambioAcum WHERE Sucursal = @Sucursal
  IF @Ok IS NULL AND @UltimaFecha IS NOT NULL
  BEGIN
    DECLARE crMon CURSOR FOR SELECT Moneda FROM Mon
    OPEN crMon
    FETCH NEXT FROM crMon INTO @Moneda
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spCambioPosicion @Estacion, @Empresa, @Fecha, @Moneda, @Saldo48 OUTPUT, @Posicion48 OUTPUT, @Sucursal = @Sucursal
        IF ROUND(@Saldo48, 0) <> ROUND(@Posicion48, 0) SELECT @Ok = 35230
      END
      FETCH NEXT FROM crMon INTO @Moneda
    END  
    CLOSE crMon
    DEALLOCATE crMon
  END
  
  IF @Ok IS NULL
  BEGIN
    BEGIN TRANSACTION
      IF EXISTS (SELECT * FROM CambioAcum WHERE Sucursal = @Sucursal AND Empresa = @Empresa)
      BEGIN
        SELECT @VentaHoy = NULL, @CompraHoy = NULL
        SELECT @VentaHoy = SUM(VentaHoy), @CompraHoy = SUM(CompraHoy) FROM CambioAcum WHERE Sucursal = @Sucursal AND Fecha = @UltimaFecha
        IF @VentaHoy IS NOT NULL OR @CompraHoy IS NOT NULL -- Se cierra si tuvo movimientos
        BEGIN
          SELECT @UnDia = @Fecha
          IF @UnDia = @UltimaFecha EXEC spCalcularDiasHabiles @UltimaFecha, 1, @DiasHabiles, 0, @UnDia OUTPUT
          IF @UnDia > @UltimaFecha
          BEGIN
            EXEC spCalcularDiasHabiles @UnDia, 2, @DiasHabiles, 1, @DosDias OUTPUT
            SELECT @DiasNaturales48Horas = DATEDIFF(day, @UnDia, @DosDias)

            UPDATE CambioAcum 
               SET Cerrado = 1
             WHERE Sucursal = @Sucursal
               AND Empresa = @Empresa
               AND Fecha   = @UltimaFecha
               AND Cerrado = 0
            
            UPDATE FechaTrabajo
               SET FechaTrabajo         = @UnDia,
                   DiasNaturales48Horas = @DiasNaturales48Horas
             WHERE Empresa = @Empresa 
               AND Sucursal = @Sucursal
  
            IF @@ROWCOUNT = 0 
              INSERT FechaTrabajo (Empresa, Sucursal, FechaTrabajo, DiasNaturales48Horas) VALUES (@Empresa, @Sucursal, @UnDia, @DiasNaturales48Horas)
  
	    -- Pesos
            INSERT CambioAcum (Sucursal, Empresa, Moneda, Fecha, Inicio, InicioMN)
            SELECT @Sucursal, @Empresa, @CfgContMoneda, @UnDia, SUM(Final), SUM(FinalMN)
             FROM CambioAcumFinalMN
            WHERE Empresa = @Empresa
              AND Sucursal = @Sucursal
              AND Fecha   = @UltimaFecha
              AND Moneda  = @CfgContMoneda
            IF @@ERROR = 1 SELECT @Ok = 1

	    -- Otras Monedas
            DECLARE crCambioAnterior CURSOR FOR
             SELECT Moneda, SUM(Final), SUM(FinalMN), SUM(InicioMN)
              FROM CambioAcumFinal
             WHERE Empresa = @Empresa
               AND Sucursal = @Sucursal
               AND Fecha   = @UltimaFecha
               AND Moneda  <> @CfgContMoneda
             GROUP BY Moneda

            OPEN crCambioAnterior
            FETCH NEXT FROM crCambioAnterior INTO @Moneda, @Inicio, @InicioMN, @InicioMNAnterior
            WHILE @@FETCH_STATUS <> -1 
            BEGIN
              IF @@FETCH_STATUS <> -2 
              BEGIN
                IF @InicioMN IS NULL SELECT @InicioMN = @InicioMNAnterior
                INSERT CambioAcum (Sucursal, Empresa, Moneda, Fecha, Inicio, InicioMN)
                           VALUES (@Sucursal, @Empresa, @Moneda, @UnDia, @Inicio, @InicioMN)
                IF @@ERROR = 1 SELECT @Ok = 1
              END
              FETCH NEXT FROM crCambioAnterior INTO @Moneda, @Inicio, @InicioMN, @InicioMNAnterior
            END  
            CLOSE crCambioAnterior
            DEALLOCATE crCambioAnterior

            DECLARE crMoneda CURSOR FOR
              SELECT Moneda FROM Mon
            OPEN crMoneda
            FETCH NEXT FROM crMoneda INTO @Moneda
            WHILE @@FETCH_STATUS <> -1 
            BEGIN
              IF @@FETCH_STATUS <> -2 
              BEGIN
                EXEC spVerCambioDinero @Empresa, @UltimaFecha, @Moneda,
                                       @OtrosIngresos OUTPUT, @OtrosEgresos OUTPUT, @DepositosAnticipados OUTPUT,  
                             	       @SolicitudesDeposito OUTPUT, @SolicitudesCheque OUTPUT, 
				       @Sucursal

                UPDATE CambioAcum 
                   SET OtrosIngresos = @OtrosIngresos,
                       OtrosEgresos  = @OtrosEgresos
                 WHERE Sucursal = @Sucursal
                   AND Empresa  = @Empresa
                   AND Fecha    = @UltimaFecha
                   AND Moneda   = @Moneda

                UPDATE CambioAcum 
                   SET Inicio   = ISNULL(Inicio, 0)   + @OtrosIngresos - @OtrosEgresos + @DepositosAnticipados,
                       InicioMN = ISNULL(InicioMN, 0) + @OtrosIngresos - @OtrosEgresos + @DepositosAnticipados
                 WHERE Sucursal = @Sucursal
                   AND Empresa  = @Empresa
                   AND Fecha    = @UnDia
                   AND Moneda   = @Moneda
              END
              FETCH NEXT FROM crMoneda INTO @Moneda
            END  
            CLOSE crMoneda
            DEALLOCATE crMoneda
          END
        END ELSE SELECT @Ok = 35220  -- No puede Cerrar un Dia sin Movimientos
      END ELSE 
      BEGIN
        SELECT @Fecha = DATEADD(day, -1, @Fecha)
        EXEC spCalcularDiasHabiles @Fecha, 1, @DiasHabiles, 0, @UnDia OUTPUT

        EXEC spCalcularDiasHabiles @Fecha, 2, @DiasHabiles, 1, @DosDias OUTPUT
        SELECT @DiasNaturales48Horas = DATEDIFF(day, @Fecha, @DosDias)

        INSERT CambioAcum (Sucursal, Empresa, Moneda, Fecha) SELECT @Sucursal, @Empresa, Moneda, @UnDia FROM Mon
        IF @@ERROR = 1 SELECT @Ok = 1

        UPDATE FechaTrabajo
           SET FechaTrabajo = @UnDia,
               DiasNaturales48Horas = @DiasNaturales48Horas
         WHERE Empresa = @Empresa 
           AND Sucursal = @Sucursal
  
        IF @@ROWCOUNT = 0 
          INSERT FechaTrabajo (Empresa, Sucursal, FechaTrabajo, DiasNaturales48Horas) VALUES (@Empresa, @Sucursal, @UnDia, @DiasNaturales48Horas)
      END
    IF @Ok IS NULL
    BEGIN
      UPDATE Empresa SET CambioBloquear = 0 WHERE Empresa = @Empresa
      COMMIT TRANSACTION
    END ELSE 
      ROLLBACK TRANSACTION
  END

  IF @Ok IS NOT NULL
  BEGIN
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END
  RETURN
END
GO
PRINT "******************* SP CAMBIOS ******************"
GO

