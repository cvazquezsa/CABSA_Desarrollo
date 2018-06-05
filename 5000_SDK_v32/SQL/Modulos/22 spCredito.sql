/********* Credito ***********/

/**************** spCreditoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCreditoVerificar') and type = 'P') drop procedure dbo.spCreditoVerificar
GO
CREATE PROCEDURE spCreditoVerificar
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
		    @Referencia			varchar(50),

		    @Deudor			varchar(10),
		    @Acreedor			varchar(10),
		    @Importe			money,
                    @LineaCreditoEsp		bit,
                    @LineaCredito		varchar(20),
                    @LineaCreditoFondeo		varchar(20),
		    @TipoAmortizacion		varchar(20),
		    @TipoTasa			varchar(20),
		    @TieneTasaEsp		bit, 
		    @TasaEsp			float,
		    @Condicion			varchar(50),
		    @Vencimiento		datetime,
		    @Comisiones			money,
		    @ComisionesIVA		money,
		    @CtaDinero			varchar(10),
		    @FormaPago			varchar(50),

    		    @OrigenTipo			varchar(10),
    		    @Origen			varchar(20),
    		    @OrigenID			varchar(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

--//WITH ENCRYPTION
AS BEGIN 
  DECLARE
    @OrigenEstatus	varchar(15),
    @OrigenAcreedor 	varchar(10), 
    @OrigenImporte	money,
    @OrigenMoneda	varchar(10)

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Checar que se haya capturado el movimiento en este modulo
    IF @Conexion = 0 
      IF EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)
	SELECT @Ok = 60070
  END ELSE
  BEGIN
    -- 9150
    IF NULLIF(@FormaPago, '') IS NOT NULL AND NULLIF(@Ok, 0) IS NULL
    BEGIN
      IF dbo.fnFormaPagoVerificar(@Empresa, @FormaPago, @Modulo, @Mov, @Usuario, '(Forma Pago)', 0) = 0
        SELECT @Ok = 30600, @OkRef = dbo.fnIdiomaTraducir(@Usuario, 'Forma Pago') + '. ' + @FormaPago    
    END
    
    IF @Importe = 0.0 SELECT @Ok = 40140 ELSE
    IF @Referencia IS NULL SELECT @Ok = 20910 

    IF @MovTipo <> 'CREDI.DA'
    BEGIN
      IF @LineaCreditoEsp = 1 AND NOT EXISTS (SELECT * FROM LC WHERE LineaCredito = @LineaCredito AND Estatus = 'ALTA') SELECT @Ok = 20073, @OkRef = @LineaCredito ELSE
      IF @LineaCreditoEsp = 0 AND @LineaCredito IS NOT NULL SELECT @Ok = 20072 ELSE
      IF @TipoTasa   IS NULL SELECT @Ok = 40200 ELSE
      IF @TipoAmortizacion IS NULL SELECT @Ok = 40210 ELSE
      IF @Vencimiento IS NULL SELECT @Ok = 40230 ELSE
      IF @Vencimiento < @FechaEmision SELECT @Ok = 30020 
    END

    IF @MovTipo IN ('CREDI.FEX', 'CREDI.FIN', 'CREDI.CES', 'CREDI.DIS', 'CREDI.BTB') AND @Ok IS NULL
    BEGIN
      IF @Deudor IS NULL SELECT @Ok = 40011 ELSE
      IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @Deudor AND Estatus = 'ALTA') SELECT @Ok = 20940, @OkRef = @Deudor
    END

    IF @MovTipo = 'CREDI.BTB'
    BEGIN
      IF NOT EXISTS(SELECT * FROM LC WHERE LineaCredito = @LineaCreditoFondeo AND Estatus = 'ALTA')
        SELECT @Ok = 20074, @OkRef = @LineaCreditoFondeo
    END

    IF @MovTipo IN ('CREDI.FEX', 'CREDI.FIN', 'CREDI.CES', 'CREDI.FON', 'CREDI.DA', 'CREDI.FOA') AND @Ok IS NULL
    BEGIN
      IF @Acreedor IS NULL SELECT @Ok = 40021
    END
  END

  IF @MovTipo = 'CREDI.FOA'
  BEGIN
    SELECT @OrigenEstatus = NULL
    SELECT @OrigenEstatus = Estatus, @OrigenAcreedor = Acreedor, @OrigenImporte = Importe, @OrigenMoneda = Moneda
      FROM Credito
     WHERE Empresa = @Empresa AND Mov = @Origen AND MovID = @OrigenID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')

    IF @OrigenEstatus <> CASE WHEN @Accion = 'CANCELAR' THEN 'CONCLUIDO' ELSE 'PENDIENTE' END OR @OrigenAcreedor <> @Acreedor OR @OrigenImporte <> @Importe OR @OrigenTipo <> @Modulo OR @OrigenMoneda <> @MovMoneda
      SELECT @Ok = 20380, @OkRef = @Origen+' '+@OrigenID
  END
  RETURN
END
GO

/**************** spCreditoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCreditoAfectar') and type = 'P') drop procedure dbo.spCreditoAfectar
GO             
CREATE PROCEDURE spCreditoAfectar
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

    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Concepto     		varchar(50),
		   @Referencia			varchar(50),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,
		   @MovUsuario			char(10),

		   @Deudor			varchar(10),
		   @Acreedor			varchar(10),
		   @Importe			money,
                   @LineaCreditoEsp		bit,
                   @LineaCredito		varchar(20),
                   @LineaCreditoFondeo		varchar(20),
		   @TipoAmortizacion		varchar(20),
		   @TipoTasa			varchar(20),
		   @TieneTasaEsp		bit, 
		   @TasaEsp			float,
		   @Condicion			varchar(50),
		   @Vencimiento			datetime,
		   @Comisiones			money,
		   @ComisionesIVA		money,
		   @CtaDinero			varchar(10),
		   @FormaPago			varchar(50),

    		   @OrigenTipo			varchar(10),
    		   @Origen			varchar(20),
    		   @OrigenID			varchar(20),

		   @Conexion			bit,
                   @SincroFinal			bit,
                   @Sucursal			int,
                   @SucursalDestino		int,
                   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

		   @Generar			bit,
    		   @GenerarMov			char(20),
	           @GenerarAfectado		bit,
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
--//WITH ENCRYPTION
AS BEGIN
  -- SET nocount ON
  DECLARE
    @Fecha			datetime,
    @FechaCancelacion		datetime,
    @GenerarMovTipo		char(20),
    @GenerarPeriodo		int,
    @GenerarEjercicio		int,
    @MovDocumentoCxc		varchar(20), 
    @MovDocumentoCxp		varchar(20), 
    @MovPrestamoCxc		varchar(20), 
    @MovPrestamoCxp		varchar(20), 
    @MovComisiones		varchar(20),
    @MovFondeo			varchar(20),
    @MovFondeoAnticipado	varchar(20),
    @MovDisposicion		varchar(20),
    @MovBackToBack		varchar(20),
    @MovDepositoAnticipado	varchar(20),
    @CxModulo			varchar(5),
    @CxID			int,
    @CxMov			varchar(20),
    @CxMovID			varchar(20),
    @CxContacto			varchar(10),
    @CxImporte			money,
    @CxCondicion		varchar(50),
    @CxVencimiento		datetime,
    @DineroID			int,
    @DineroMov			varchar(20),
    @DineroMovID		varchar(20),
    @TasaDiaria 		float, 
    @TasaTotal			float,
    @Dias			int,
    @Descuento			money,
    @IDOrigen			int,
    @GenerarLineaCreditoExpress	bit,
    @GenerarLineaCredito	varchar(20)


  SELECT @GenerarLineaCreditoExpress = 0, 
         @GenerarLineaCredito        = NULL
 
  SELECT @MovDocumentoCxc     = CreditoDocumentoCxc,
         @MovDocumentoCxp     = CreditoDocumentoCxp,
         @MovPrestamoCxc      = CreditoPrestamoCxc,
         @MovPrestamoCxp      = CreditoPrestamoCxp,
         @MovComisiones       = CreditoComisiones,
         @MovDisposicion      = CreditoDisposicion,
         @MovBackToBack       = CreditoBackToBack,
         @MovFondeo           = CreditoFondeo,
         @MovFondeoAnticipado = CreditoFondeoAnticipado,
         @MovDepositoAnticipado = CreditoDepositoAnticipado
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @LineaCreditoEsp = 0 
    SELECT @GenerarLineaCreditoExpress = 1 
  ELSE 
    SELECT @GenerarLineaCredito = @LineaCredito

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

  -- Generar Mov Nuevo
  IF @Accion = 'GENERAR' AND @Ok IS NULL
  BEGIN
    EXEC spMovGenerar @Sucursal, @Empresa, @Modulo, @Ejercicio, @Periodo, @Usuario, @FechaRegistro, 'SINAFECTAR', 
		      NULL, NULL, 
                      @Mov, @MovID, 0,
		      @GenerarMov, NULL, @GenerarMovID OUTPUT, @IDGenerar OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    -- Leer MovTipo, Periodo y Ejercicio	
    EXEC spMovTipo @Modulo, @GenerarMov, @FechaAfectacion, @Empresa, NULL, NULL, @GenerarMovTipo OUTPUT, @GenerarPeriodo OUTPUT, @GenerarEjercicio OUTPUT, @Ok OUTPUT
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
      IF @Accion = 'AFECTAR'
      BEGIN
        -- Calcular ImporteHoy     
        IF @MovTipo = 'CREDI.CES'
          SELECT @CxImporte = @Importe
        ELSE
        BEGIN
          SELECT @Dias = DATEDIFF(day, @FechaEmision, @Vencimiento)
          EXEC spTipoTasa @TipoTasa, @TasaDiaria OUTPUT, @TasaTotal OUTPUT, @TieneTasaEsp, @TasaEsp
          SELECT @Descuento = @Importe * (@TasaDiaria/100.0) * @Dias
          SELECT @CxImporte = @Importe 

          IF @MovTipo IN ('CREDI.FEX', 'CREDI.FIN', 'CREDI.CES')
            SELECT @CxImporte = @CxImporte - ISNULL(@Descuento, 0.0)
        END

        IF @MovTipo = 'CREDI.DA'
        BEGIN
          EXEC @DineroID = spGenerarDinero @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                               @FechaAfectacion, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones, 0, 0,
                               @FechaRegistro, @Ejercicio, @Periodo, 
                               @FormaPago, NULL, NULL,
                               @Acreedor, @CtaDinero, NULL, @Importe, NULL,
		               NULL, NULL, NULL,
	      	               @DineroMov OUTPUT, @DineroMovID OUTPUT,
                               @Ok OUTPUT, @OkRef OUTPUT
          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'DIN', @DineroID, @DineroMov, @DineroMovID, @Ok OUTPUT
        END

        IF @MovTipo IN ('CREDI.FON', 'CREDI.FOA')
        BEGIN
          SELECT @CxModulo = 'CXP', @CxMov = CASE @MovTipo WHEN 'CREDI.FON' THEN @MovFondeo WHEN 'CREDI.FOA' THEN @MovFondeoAnticipado END, @CxMovID = NULL, @CxContacto = @Acreedor
          EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, @CtaDinero, @FormaPago, 
                                   @CxImporte, NULL, NULL, NULL, 
                                   NULL, NULL, NULL, NULL, NULL, @CxMov,
                                   @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID,
                                   @LineaCreditoExpress = @GenerarLineaCreditoExpress, @LineaCredito = @GenerarLineaCredito, 
			           @TipoAmortizacion = @TipoAmortizacion, @TipoTasa = @TipoTasa, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
        END

        IF @MovTipo IN ('CREDI.DIS', 'CREDI.BTB')
        BEGIN
          SELECT @CxModulo = 'CXC', @CxMov = CASE @MovTipo WHEN 'CREDI.DIS' THEN @MovDisposicion WHEN 'CREDI.BTB' THEN @MovBackToBack END, @CxMovID = NULL, @CxContacto = @Deudor
          EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, @CtaDinero, @FormaPago, 
                                   @CxImporte, NULL, NULL, NULL, 
                                   NULL, NULL, NULL, NULL, NULL, @CxMov,
                                   @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID,
                                   @LineaCreditoExpress = @GenerarLineaCreditoExpress, @LineaCredito = @GenerarLineaCredito, 
			           @TipoAmortizacion = @TipoAmortizacion, @TipoTasa = @TipoTasa, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
        END

        IF @MovTipo IN ('CREDI.FEX', 'CREDI.FIN', 'CREDI.CES')
        BEGIN
          SELECT @CxCondicion = @Condicion, @CxVencimiento = @Vencimiento
          IF @MovTipo IN ('CREDI.FEX', 'CREDI.FIN')
            SELECT @CxCondicion = '(Fecha)', @CxVencimiento = @FechaEmision
          
          SELECT @CxModulo = 'CXP', @CxMov = @MovDocumentoCxp, @CxMovID = NULL, @CxContacto = @Acreedor
          EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @CxCondicion, @CxVencimiento, @CxContacto, NULL, NULL, NULL, NULL, NULL, 
                                   @CxImporte, NULL, NULL, NULL, 
                                   NULL, NULL, NULL, NULL, NULL, @CxMov,
                                   @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT

          SELECT @CxModulo = 'CXC', @CxMov = @MovDocumentoCxc, @CxContacto = @Deudor
          IF @MovTipo = 'CREDI.CES'
            EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                     @FechaRegistro, @Ejercicio, @Periodo, 
                                     @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, NULL, NULL, 
                                     @CxImporte, NULL, NULL, NULL, 
                                     NULL, NULL, NULL, NULL, NULL, @CxMov,
                                     @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID
          ELSE
            EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                     @FechaRegistro, @Ejercicio, @Periodo, 
                                     @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, NULL, NULL, 
                                     @CxImporte, NULL, NULL, NULL, 
                                     NULL, NULL, NULL, NULL, NULL, @CxMov,
                                     @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID,
                                     @LineaCreditoExpress = @GenerarLineaCreditoExpress, @LineaCredito = @GenerarLineaCredito, 
                                     @TipoAmortizacion = @TipoAmortizacion, @TipoTasa = @TipoTasa, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
        END
        
        IF @MovTipo = 'CREDI.FEX'
        BEGIN
          SELECT @CxModulo = 'CXP', @CxMov = @MovPrestamoCxp, @CxMovID = NULL, @CxContacto = @Deudor
          EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, @CtaDinero, @FormaPago, 
                                   @CxImporte, NULL, NULL, NULL, 
                                   NULL, NULL, NULL, NULL, NULL, @CxMov,
                                   @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID,
                                   @LineaCreditoExpress = @GenerarLineaCreditoExpress, @LineaCredito = @GenerarLineaCredito, 
			           @TipoAmortizacion = @TipoAmortizacion, @TipoTasa = @TipoTasa, @TieneTasaEsp = @TieneTasaEsp, @TasaEsp = @TasaEsp
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT


          SELECT @CxModulo = 'CXC', @CxMov = @MovPrestamoCxc
          EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                   @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                   @FechaRegistro, @Ejercicio, @Periodo, 
                                   '(Fecha)', @FechaEmision, @CxContacto, NULL, NULL, NULL, @CtaDinero, @FormaPago, 
                                   @CxImporte, NULL, NULL, NULL, 
                                   NULL, NULL, NULL, NULL, NULL, @CxMov,
                                   @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID
          EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT

          IF NULLIF(@Comisiones, 0.0) IS NOT NULL
          BEGIN
            SELECT @CxModulo = 'CXC', @CxMov = @MovComisiones, @CxMovID = NULL
            EXEC @CxID = spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, @CxModulo, @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio,
                                     @FechaAfectacion, @Concepto, @Proyecto, @Usuario,  @Autorizacion, @Referencia, @DocFuente, @Observaciones,
                                     @FechaRegistro, @Ejercicio, @Periodo, 
                                     @Condicion, @Vencimiento, @CxContacto, NULL, NULL, NULL, NULL, NULL, 
                                     @Comisiones, @ComisionesIVA, NULL, NULL, 
                                     NULL, NULL, NULL, NULL, NULL, @CxMov,
                                     @CxModulo, @CxMov OUTPUT, @CxMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT, @ModuloEspecifico = @CxModulo, @MovIDEspecifico = @CxMovID
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, @CxModulo, @CxID, @CxMov, @CxMovID, @Ok OUTPUT
          END
        END
      END

      IF @MovTipo = 'CREDI.FOA'
      BEGIN
        UPDATE Credito
           SET @IDOrigen = ID,
               Estatus = CASE WHEN @Accion = 'CANCELAR' THEN 'PENDIENTE' ELSE 'CONCLUIDO' END
         WHERE Empresa = @Empresa AND Estatus = CASE WHEN @Accion = 'CANCELAR' THEN 'CONCLUIDO' ELSE 'PENDIENTE' END AND Mov = @Origen AND MovID = @OrigenID
        IF @@ROWCOUNT = 0 
          SELECT @Ok = 20380, @OkRef = @Origen+' '+@OrigenID

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @IDOrigen, @Origen, @OrigenID, @Modulo, @ID, @Mov, @MovID, @Ok OUTPUT
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
        UPDATE Credito
           SET FechaConclusion  = @FechaConclusion, 
               FechaCancelacion = @FechaCancelacion, 
               UltimoCambio     = CASE WHEN UltimoCambio IS NULL THEN @FechaRegistro ELSE UltimoCambio END,
	       Estatus          = @EstatusNuevo,
               Situacion 	= CASE WHEN @Estatus<>@EstatusNuevo THEN NULL ELSE Situacion END,
               GenerarPoliza    = @GenerarPoliza
         WHERE ID = @ID 
        IF @@ERROR <> 0 SELECT @Ok = 1
      END
    END

    -- Agregar a Estatus Log
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      EXEC spMovFinal @Empresa, @Sucursal, @Modulo, @ID, @Estatus, @EstatusNuevo, @Usuario, @FechaEmision, @FechaRegistro, @Mov, @MovID, @MovTipo, @IDGenerar, @Ok OUTPUT, @OkRef OUTPUT

    -- Cancelar el Flujo
    IF @Accion = 'CANCELAR' AND @EstatusNuevo = 'CANCELADO' AND @Ok IS NULL
      EXEC spCancelarFlujo @Empresa, @Modulo, @ID, @Ok OUTPUT, @CancelarHijos = 1

--if @Ok IS NULL SELECT @Ok = 1  -- breakpoint
  IF @Conexion = 0
    IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
      COMMIT TRANSACTION
    ELSE
      ROLLBACK TRANSACTION
    
  RETURN
END
GO

/**************** spCredito ****************/
if exists (select * from sysobjects where id = object_id('dbo.spCredito') and type = 'P') drop procedure dbo.spCredito
GO
CREATE PROCEDURE spCredito
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
    @Deudor		varchar(10), 
    @Acreedor		varchar(10), 
    @Importe		money, 
    @LineaCreditoEsp	bit,
    @LineaCredito	varchar(20),
    @LineaCreditoFondeo	varchar(20),
    @TipoAmortizacion	varchar(20), 
    @TipoTasa		varchar(20), 
    @TieneTasaEsp	bit,
    @TasaEsp		float,
    @Condicion		varchar(50),
    @Vencimiento	datetime,
    @Comisiones		money,
    @ComisionesIVA	money,
    @CtaDinero		varchar(10),
    @FormaPago		varchar(50),
    @OrigenTipo		varchar(10),
    @Origen		varchar(20),
    @OrigenID		varchar(20),
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

  -- Leer Datos Generales del Movimiento
  SELECT @Sucursal = Sucursal, @SucursalDestino = SucursalDestino, @SucursalOrigen = SucursalOrigen, @Empresa = Empresa, @MovID = MovID, @Mov = Mov, @FechaEmision = FechaEmision, @Proyecto = NULLIF(RTRIM(Proyecto), ''),
         @MovUsuario = Usuario, @Autorizacion = Autorizacion, 
         @MovMoneda = Moneda, @MovTipoCambio = TipoCambio,
         @DocFuente = DocFuente, @Observaciones = Observaciones, @Estatus = UPPER(Estatus), 
         @GenerarPoliza = GenerarPoliza, @FechaConclusion = FechaConclusion,
         @Concepto = Concepto, @Referencia = Referencia,
         @Deudor = NULLIF(RTRIM(Deudor), ''), @Acreedor = NULLIF(RTRIM(Acreedor), ''), @Importe = ISNULL(Importe, 0.0), 
         @LineaCreditoEsp = ISNULL(LineaCreditoEsp, 0), @LineaCredito = NULLIF(RTRIM(LineaCredito), ''), @LineaCreditoFondeo = NULLIF(RTRIM(LineaCreditoFondeo), ''),
         @TipoAmortizacion = NULLIF(RTRIM(TipoAmortizacion), ''), @TipoTasa = NULLIF(RTRIM(TipoTasa), ''), @TieneTasaEsp = ISNULL(TieneTasaEsp, 0), @TasaEsp = NULLIF(TasaEsp, 0.0), 
         @Condicion = NULLIF(RTRIM(Condicion), ''), @Vencimiento = Vencimiento, @Comisiones = NULLIF(Comisiones, 0.0), @ComisionesIVA = NULLIF(ComisionesIVA, 0.0),
         @CtaDinero = NULLIF(RTRIM(CtaDinero), ''), @FormaPago = NULLIF(RTRIM(FormaPago), ''),
         @OrigenTipo = NULLIF(RTRIM(OrigenTipo), ''), @Origen = NULLIF(RTRIM(Origen), ''), @OrigenID = NULLIF(RTRIM(OrigenID), '')
    FROM Credito
   WHERE ID = @ID
  IF @@ERROR <> 0 SELECT @Ok = 1

  IF NULLIF(RTRIM(@Usuario), '') IS NULL SELECT @Usuario = @MovUsuario
  -- Leer MovTipo, Periodo y Ejercicio	
  -- IF @Accion IN ('AFECTAR', 'GENERAR') SELECT @FechaAfectacion = @FechaEmision ELSE SELECT @FechaAfectacion = @FechaRegistro
  EXEC spFechaAfectacion @Empresa, @Modulo, @ID, @Accion, @FechaEmision OUTPUT, @FechaRegistro, @FechaAfectacion OUTPUT
  EXEC spExtraerFecha @FechaAfectacion OUTPUT
  EXEC spMovTipo @Modulo, @Mov, @FechaAfectacion, @Empresa, NULL, NULL, @MovTipo OUTPUT, @Periodo OUTPUT, @Ejercicio OUTPUT, @Ok OUTPUT
  EXEC spMovOk @SincroFinal, @ID, @Estatus, @Sucursal, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @FechaAfectacion, @FechaRegistro, @Ejercicio, @Periodo, @Proyecto, @Ok OUTPUT, @OkRef OUTPUT

  IF @Accion = 'CANCELAR' 
    SELECT @EstatusNuevo = 'CANCELADO' 
  ELSE BEGIN
    IF @MovTipo = 'CREDI.DA' 
      SELECT @EstatusNuevo = 'PENDIENTE'
    ELSE
      SELECT @EstatusNuevo = 'CONCLUIDO'
  END

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
      EXEC spCreditoVerificar @ID, @Accion, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @Estatus, @EstatusNuevo, @Referencia, 
                              @Deudor, @Acreedor, @Importe, @LineaCreditoEsp, @LineaCredito, @LineaCreditoFondeo, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, 
                              @Condicion, @Vencimiento, @Comisiones, @ComisionesIVA, @CtaDinero, @FormaPago, 
      	               	      @OrigenTipo, @Origen, @OrigenID, 
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
      EXEC spCreditoAfectar @ID, @Accion, @Empresa, @Modulo, @Mov, @MovID OUTPUT, @MovTipo, @MovMoneda, @MovTipoCambio, @FechaEmision, @FechaAfectacion, @FechaConclusion,
			    @Proyecto, @Usuario, @Autorizacion, @DocFuente, @Observaciones, @Concepto, @Referencia, 
                            @Estatus, @EstatusNuevo, @FechaRegistro, @Ejercicio, @Periodo, @MovUsuario,
                            @Deudor, @Acreedor, @Importe, @LineaCreditoEsp, @LineaCredito, @LineaCreditoFondeo, @TipoAmortizacion, @TipoTasa, @TieneTasaEsp, @TasaEsp, 
                            @Condicion, @Vencimiento, @Comisiones, @ComisionesIVA, @CtaDinero, @FormaPago,
                            @OrigenTipo, @Origen, @OrigenID, 
		            @Conexion, @SincroFinal, @Sucursal, @SucursalDestino, @SucursalOrigen, @CfgContX, @CfgContXGenerar, @GenerarPoliza,
                            @Generar, @GenerarMov, @GenerarAfectado, @IDGenerar OUTPUT, @GenerarMovID OUTPUT,
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

    -- Si se Genero un Movimiento, Desplegarlo
    IF @Ok = 80030
      SELECT @OkRef = 'Movimiento: '+RTRIM(@GenerarMov)+' '+LTRIM(Convert(Char, @GenerarMovID))

    -- Si hubo un error poner como referencia el Movimiento
    ELSE
      SELECT @OkRef = 'Movimiento: '+RTRIM(@Mov)+' '+LTRIM(Convert(Char, @MovID)), @IDGenerar = NULL

  RETURN
END
GO

PRINT "******************* SP Credito ******************"
GO
