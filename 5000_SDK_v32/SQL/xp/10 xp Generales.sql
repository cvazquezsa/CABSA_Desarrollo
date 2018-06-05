/**************** xpGenerarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCx') and type = 'P') drop procedure dbo.xpGenerarCx
GO
CREATE PROCEDURE xpGenerarCx
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
		   @ModuloAfectar		char(5),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
                   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,       
    		   @FechaEmision      		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Condicion			varchar(50), 
		   @Vencimiento			datetime,
		   @Contacto			char(10),
		   @EnviarA			int,
		   @Agente			char(10),
                   @Tipo			char(20),
                   @CtaDinero			char(10),
		   @FormaPago			varchar(50),

		   @Importe			money,
		   @Impuestos			money,
		   @Retencion			money,
		   @ComisionTotal		money,

		   @Beneficiario		int,
		   @Aplica			char(20),
		   @AplicaMovID			varchar(20),
		   @ImporteAplicar		money,
		   @VIN				varchar(20),
		   @MovEspecifico		char(20),

    		   @CxModulo			char(5),
    		   @CxMov			char(20),
    		   @CxMovID			varchar(20),

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,
		   @INSTRUCCIONES_ESP		varchar(20) 	= NULL,
		   @IVAFiscal			float		= NULL,
		   @IEPSFiscal			float		= NULL,

    		   @CxID			int		= NULL,
		   @ContUso			varchar(20)	= NULL
AS BEGIN
  RETURN
END
GO


/**************** xpGenerarCxFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCxFinal') and type = 'P') drop procedure dbo.xpGenerarCxFinal
GO
CREATE PROCEDURE xpGenerarCxFinal
    		   @Modulo	char(5),
                   @ID		int,
		   @IDGenerar	int,
		   @Ok		int		OUTPUT,
		   @OkRef	varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpGenerarDinero ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarDinero') and type = 'P') drop procedure dbo.xpGenerarDinero
GO
CREATE PROCEDURE xpGenerarDinero
                   @Sucursal			int,
	           @SucursalOrigen		int, 
	           @SucursalDestino		int, 
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
    		   @FechaAfectacion    		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),

		   @ConDesglose			bit,
		   @GenerarSolicitud		bit,

    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @FormaPago			varchar(50),
		   @Tipo			char(20),
                   @Beneficiario		int,

		   @Cuenta			char(10), 
		   @CtaDinero			char(10),
		   @Cajero			char(10),
		   @Importe			money,
    		   @Impuestos			money,

		   @MovEspecifico		char(20),
		   @BeneficiarioEspecifico	varchar(100),
		   @Vencimiento			datetime,

    		   @DineroMov			char(20),
    		   @DineroMovID			varchar(20),

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,

    		   @DineroID			int		= NULL
AS BEGIN
  RETURN
END
GO

/************** xpSaldoM (Monetarios) ***************/
if exists (select * from sysobjects where id = object_id('dbo.xpSaldoM') and sysstat & 0xf = 4) drop procedure dbo.xpSaldoM
GO
CREATE PROCEDURE xpSaldoM	
		   @Sucursal		int,
		   @Accion		char(20),
	           @Empresa		char(5),
		   @Rama		char(5),
		   @Moneda		char(10),
		   @TipoCambio		float,
	           @Cuenta		char(20),
	           @SubCuenta		varchar(50),
	           @Grupo		char(10),
	           @Modulo		char(5),
		   @ID			int,
	           @Mov			char(20),
	           @MovID		varchar(20),
	           @Cargo		money,
	           @Abono		money,
	           @Fecha		datetime,
                   @EjercicioAfectacion int,
                   @PeriodoAfectacion   int,
		   @AcumulaSinDetalles	bit,
                   @AcumulaEnLinea	bit,
                   @GeneraAuxiliar	bit,
                   @GeneraSaldo	        bit,
                   @Conciliar		bit,
		   @Aplica		char(20),
		   @AplicaID		varchar(20),

		   @EsResultados	bit,

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @Renglon		float	= NULL,
		   @RenglonSub		int	= NULL,
		   @RenglonID		int	= NULL
AS BEGIN
  RETURN
END
GO

-- REQ13987 eCommerce
/************** xpSaldoU (Unidades) ***************/
if exists (select * from sysobjects where id = object_id('dbo.xpSaldoU') and sysstat & 0xf = 4) drop procedure dbo.xpSaldoU
GO
CREATE PROCEDURE xpSaldoU
		   @Sucursal		int,
		   @Accion		char(20),
	           @Empresa		char(5),
		   @Usuario		char(10),
		   @Rama		char(5),
		   @Moneda		char(10),
	           @Cuenta		char(20),
	           @SubCuenta		varchar(50),
	           @Grupo		char(10),
	           @Modulo		char(5),
		   @ID			int,
	           @Mov			char(20),
	           @MovID		varchar(20),
		   @Cargo		money,
		   @Abono		money,
	           @CargoU		float,
	           @AbonoU		float,
	           @Fecha		datetime,
                   @EjercicioAfectacion int,
                   @PeriodoAfectacion   int,
		   @AcumulaSinDetalles	bit,
                   @AcumulaEnLinea	bit,
                   @GeneraAuxiliar	bit,
                   @GeneraSaldo	        bit,
                   @Conciliar		bit,
		   @Aplica		char(20),
		   @AplicaID		varchar(20),

		   @EsTransferencia     bit,
		   @EsResultados	bit,
		   @EsTipoSerie		bit,

		   @InvNegativoU   	float,
		   @ConsignacionU	float,

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @Renglon		float		= NULL,
		   @RenglonSub		int		= NULL,
		   @RenglonID		int		= NULL,
	           @SubGrupo		varchar(20)	= NULL
AS BEGIN
  DECLARE 
    @eCommerce       bit
    
  SELECT @eCommerce = ISNULL(eCommerce,0) FROM EmpresaGral WHERE Empresa = @Empresa  

  IF @eCommerce = 1
  BEGIN
    IF NOT EXISTS(SELECT * FROM eCommerceSaldoU WHERE Articulo = @Cuenta AND SubCuenta = @SubCuenta)
    INSERT eCommerceSaldoU(Articulo, SubCuenta)
    SELECT                 @Cuenta, @SubCuenta
  END  




  RETURN
END
GO

/**************** xpDineroVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDineroVerificar') and sysstat & 0xf = 4) drop procedure dbo.xpDineroVerificar
GO
CREATE PROCEDURE xpDineroVerificar
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
		    @Estatus			char(15),
 	    	    @EstatusNuevo	      	char(15),
		    @BeneficiarioNombre		varchar(100),

                    @CtaDinero			char(10),
		    @CtaDineroTipo		char(20),         
		    @CtaDineroDestino		char(10),
		    @CtaDineroFactor		float,
		    @CtaDineroTipoCambio	float,
		    @CtaDineroMoneda		char(10),
		    @CtaDineroDestinoMoneda	char(10),
		    @CtaDineroDestinoTipo	char(20),
		    @CtaEmpresa			char(5),
    		    @Cajero			char(10),

		    @Importe			money,
		    @Impuestos			money,
		    @Saldo			money,
		    @Corte			int,
		    @CorteDestino		int,

  		    @Directo	                bit,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @OrigenMovTipo		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
AS BEGIN
  RETURN
  
  IF EXISTS(SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo AND @OrigenMovTipo='CONC.B' AND @Estatus='CONCLUIDO') AND @Accion='CANCELAR'  
    SELECT @Ok = 60070, @OkRef = @Mov + ' ' + @MovID
  
END
GO

/**************** xpDineroAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDineroAfectar') and sysstat & 0xf = 4) drop procedure dbo.xpDineroAfectar
GO
CREATE PROCEDURE xpDineroAfectar
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
		    @Estatus			char(15),
 	    	    @EstatusNuevo	      	char(15),

                    @CtaDinero			char(10),
		    @CtaDineroTipo		char(20),         
		    @CtaDineroDestino		char(10),
		    @CtaDineroFactor		float,
		    @CtaDineroTipoCambio	float,
		    @CtaDineroMoneda		char(10),
    		    @Cajero			char(10),

		    @Importe			money,
		    @Impuestos			money,
		    @Saldo			money,

  		    @Directo	                bit,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpDineroAplicaFactorMovImpuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDineroAplicaFactorMovImpuesto') and type = 'P') drop procedure dbo.xpDineroAplicaFactorMovImpuesto
GO             
CREATE PROCEDURE xpDineroAplicaFactorMovImpuesto
		    @Sucursal			int, 	
            @ID		  			int,
		    @Accion				char(20),
            @Empresa			char(5),
		    @Usuario			char(10),
        	@Modulo				char(5),
		    @Mov				char(20),
		    @MovID				varchar(20),
		    @MovTipo			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
            @IDAplica			int,
            @AplicaMov			char(20),
            @AplicaMovID		varchar(20),
            @AplicaMovTipo		char(20),
            @AplicaImporte		money,
		    @VerificarAplica	bit,
		    @AplicaFactor		float			OUTPUT,
		    @Ok 				int				OUTPUT, 
		    @OkRef 				varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpDineroOrigenFactorMovImpuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDineroOrigenFactorMovImpuesto') and type = 'P') drop procedure dbo.xpDineroOrigenFactorMovImpuesto
GO             
CREATE PROCEDURE xpDineroOrigenFactorMovImpuesto
		    @Sucursal			int, 	
            @ID		  			int,
		    @Accion				char(20),
            @Empresa			char(5),
		    @Usuario			char(10),
        	@Modulo				char(5),
		    @Mov				char(20),
		    @MovID				varchar(20),
		    @MovTipo			char(20),
		    @MovMoneda			char(10),
		    @MovTipoCambio		float,
            @OrigenID			int,
            @OrigenMov			char(20),
            @OrigenMovID		varchar(20),
            @OrigenTipo		char(20),
            @OrigenImporte		money,
		    @VerificarOrigen	bit,
		    @OrigenFactor		float			OUTPUT,
		    @Ok 				int				OUTPUT, 
		    @OkRef 				varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpCxVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCxVerificar') and sysstat & 0xf = 4) drop procedure dbo.xpCxVerificar
GO
CREATE PROCEDURE xpCxVerificar
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
    		    @Condicion			varchar(50),
    		    @Vencimiento		datetime,
		    @FormaPago			varchar(50),
                    @ClienteProv		char(10),
                    @CPMoneda			char(10),
		    @CPFactor			float,
		    @CPTipoCambio		float,
		    @Importe			money,
		    @Impuestos			money,
		    @Saldo			money,
		    @CtaDinero			char(10),
  		    @AplicaManual               bit,
		    @ConDesglose		bit,
		    @CobroDesglosado		money, 
		    @CobroDelEfectivo		money, 
		    @CobroCambio		money,
                      
		    @Indirecto			bit,
		    @Conexion			bit,
	            @SincroFinal		bit,
		    @Sucursal			int,
 	    	    @EstatusNuevo	      	char(15),
                    @AfectarCantidadPendiente  	bit,
                    @AfectarCantidadA   	bit,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
                    @CfgEmbarcar		bit,
		    @CfgAutoAjuste		money,
		    @CfgFormaCobroDA		varchar(50),
		    @CfgRefinanciamientoTasa	float,

		    @MovAplica			char(20),
 		    @MovAplicaID		varchar(20),

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCxAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCxAfectar') and sysstat & 0xf = 4) drop procedure dbo.xpCxAfectar
GO
CREATE PROCEDURE xpCxAfectar
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
    		    @Condicion			varchar(50),
    		    @Vencimiento		datetime,
		    @FormaPago			varchar(50),
                    @ClienteProv		char(10),
                    @CPMoneda			char(10),
		    @CPFactor			float,
		    @CPTipoCambio		float,

		    @Importe			money,
		    @Impuestos			money,
		    @Saldo			money,
		    @CtaDinero			char(10),
  		    @AplicaManual               bit,
		    @ConDesglose		bit,
                      
		    @Conexion			bit,
	            @SincroFinal		bit,
		    @Sucursal			int,
 	    	    @EstatusNuevo	      	char(15),
		    @MovAplica			char(20),
 		    @MovAplicaID		varchar(20),

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT,
				@Estatus				varchar(15) = NULL
AS BEGIN
  RETURN
END
GO

/**************** xpInvVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificar') and sysstat & 0xf = 4) drop procedure dbo.xpInvVerificar
GO             
CREATE PROCEDURE xpInvVerificar
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpInvVerificarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificarDetalle') and sysstat & 0xf = 4) drop procedure dbo.xpInvVerificarDetalle
GO             
CREATE PROCEDURE xpInvVerificarDetalle
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,

		   @Renglon			float,
		   @RenglonSub			int,
		   @Articulo			char(20),
                   @Cantidad		        float,
		   @Importe			money,
                   @ImporteNeto			money,
		   @Impuestos			money,
		   @ImpuestosNetos		money,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpInvAfectarAntes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvAfectarAntes') and sysstat & 0xf = 4) drop procedure dbo.xpInvAfectarAntes
GO             
CREATE PROCEDURE xpInvAfectarAntes
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
	    	   @Sucursal			int,

		   @UtilizarID			int,
    		   @UtilizarMovTipo    		char(20),

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpInvAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvAfectar') and sysstat & 0xf = 4) drop procedure dbo.xpInvAfectar
GO             
CREATE PROCEDURE xpInvAfectar
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
	    	   @Sucursal			int,

		   @UtilizarID			int,
    		   @UtilizarMovTipo    		char(20),

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  DECLARE
   @Error		int,
   @ErrorRef	varchar(255),

   --BUG24438
   @Origen                 char(5),
   @OrigenID               varchar(20),
   @OrigenMov              varchar(20),
   @OrigenMovID            varchar(20),
   @OrigenMovTipo          varchar(20),
   @OID                    int,
   @OrigenTipo             varchar(10),
   @IDCancelar             int,
   @ModuloCancelar         varchar(5),
   @IDCancelarA            int,
   @ModuloCancelarA        char(5),
   @SubClave               char(20) --BUG23987

--MES
   
  IF @Ok IS NULL OR @Ok BETWEEN 80030 AND 81000
  BEGIN
    EXEC spINFORInvAfectar  @ID, @Accion, @Base, @Empresa, @Usuario, @Modulo, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, @Estatus, @EstatusNuevo, @FechaEmision, @FechaRegistro, @FechaAfectacion, @Conexion, @SincroFinal, @Sucursal, NULL, NULL,@Error OUTPUT, @ErrorRef OUTPUT
    IF @Error IS NOT NULL OR @Error BETWEEN 80030 AND 81000
      SELECT @Ok = @Error, @OkRef = @OkRef
  END

  --BUG24438
  SELECT @SubClave = ISNULL(SubClave,'') FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Mov AND Clave = @MovTipo
  IF @Ok IS NULL AND @Modulo = 'INV' AND @MovTipo = 'INV.SOL' and @SubClave='INV.ENT' AND @Accion='CANCELAR' AND @Conexion = 0  
   BEGIN    
     -- Checar que se haya capturado el movimiento en este modulo    
     --EWQ.Tuning2	 
	 SELECT @Origen = OrigenTipo, @OrigenMov = Origen, @OrigenMovID = OrigenID FROM Inv WHERE ID = @ID
     SELECT @OrigenMovTipo = Clave, @SubClave=SubClave FROM MovTipo WHERE Modulo = @Modulo AND Mov = @OrigenMov     
     IF @Conexion = 0     
       IF --EXISTS (SELECT * FROM MovFlujo WHERE Cancelado = 0 AND Empresa = @Empresa AND DModulo = @Modulo AND DID = @ID AND OModulo <> DModulo)                  AND
          @Estatus IN('CONCLUIDO', 'PROCESAR', 'PENDIENTE')
			 AND @OrigenMovTipo = 'INV.A' AND @Origen = 'INV' AND @SubClave='INV.ATMAORENT'
         SELECT @Ok = 60070        	        
   END      

  RETURN
END
GO


/**************** xpInvAfectarDetalleAntes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvAfectarDetalleAntes') and sysstat & 0xf = 4) drop procedure dbo.xpInvAfectarDetalleAntes
GO             
CREATE PROCEDURE xpInvAfectarDetalleAntes
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,

		   @Renglon			float,
		   @RenglonSub			int,
		   @Articulo			char(20),
                   @Cantidad		        float,
		   @Importe			money,
                   @ImporteNeto			money,
		   @Impuestos			money,
		   @ImpuestosNetos		money,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpInvAfectarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvAfectarDetalle') and sysstat & 0xf = 4) drop procedure dbo.xpInvAfectarDetalle
GO             
CREATE PROCEDURE xpInvAfectarDetalle
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,

		   @Renglon			float,
		   @RenglonSub			int,
		   @Articulo			char(20),
                   @Cantidad		        float,
		   @Importe			money,
                   @ImporteNeto			money,
		   @Impuestos			money,
		   @ImpuestosNetos		money,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpVentaRetencionCalcular ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaRetencionCalcular') and sysstat & 0xf = 4) drop procedure dbo.xpVentaRetencionCalcular
GO             
CREATE PROCEDURE xpVentaRetencionCalcular
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Cliente	 	      	char(10),

		   @Renglon			float,
		   @RenglonSub			int,
		   @Articulo			char(20),
                   @Cantidad		        float,
		   @Importe			money,
                   @ImporteNeto			money,
		   @Impuestos			money,
		   @ImpuestosNetos		money,

		   @Retencion			money		OUTPUT,
		   @BorrarRetencionCx		bit		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
DECLARE
  @p    char(1),
  @RFC 	varchar(20)

  -- Si el Movimiento es una Factura o Devolucion (VTAS.F)
  IF @MovTipo IN ('VTAS.F', 'VTAS.D', 'VTAS.DF', 'VTAS.B')
  BEGIN
    -- Si el Articulo Facturado es un Flete o la clave indicada para fletes
    IF @Articulo = 'FLETE'
    BEGIN
      SELECT @RFC = NULLIF(LTRIM(RTRIM(RFC)), '') FROM Cte WHERE Cliente = @Cliente

      -- Si tiene RFC y el RFC Tiene un tamaño minimo de 9 caracteres
      IF @RFC IS NOT NULL AND LEN(@RFC) >= 9
      BEGIN
        -- Para Conocer si el RFC es de una Persona Moral (Empresa) en la cuarta posicion no debe ser una letra
        SELECT @p = SUBSTRING(@RFC, 4, 1)
        IF UPPER(@p) NOT IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
        BEGIN
          -- Entonces Calcula el Importe de la Retencion = 4% del Importe del Flete
          SELECT @Retencion = @ImporteNeto * 0.04, @BorrarRetencionCx = 1
        END
      END
    END
  END
  RETURN
END
GO


/**************** xpVentaRetencionTotalCalcular ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaRetencionTotalCalcular') and sysstat & 0xf = 4) drop procedure dbo.xpVentaRetencionTotalCalcular
GO             
CREATE PROCEDURE xpVentaRetencionTotalCalcular
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Cliente	 	      	char(10),

		   @SumaImpuesto1Neto		money,
		   @SumaImpuesto2Neto		money,
		   @SumaImpuesto3Neto		money,

		   @SumaRetencion		money		OUTPUT,
		   @SumaRetencion2		money		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,

		   @SumaRetencion3		money		= NULL OUTPUT 
AS BEGIN
  ---- Si el Movimiento es una Factura o Devolucion (VTAS.F)
  --IF @MovTipo IN ('VTAS.F', 'VTAS.D', 'VTAS.DF', 'VTAS.B')
  --BEGIN
  --  -- Si el Cliente Tiene Registro PITEX Retener IVA
  --  IF EXISTS(SELECT * FROM Cte WHERE Cliente = @Cliente AND NULLIF(RTRIM(PITEX), '') IS NOT NULL)
  --  BEGIN
  --    SELECT @SumaRetencion = @SumaImpuesto1Neto
  --  END
  --END
  RETURN
END
GO

/**************** xpInvReservado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvReservado') and sysstat & 0xf = 4) drop procedure dbo.xpInvReservado
GO             
CREATE PROCEDURE xpInvReservado
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
		   @Renglon			float,
		   @RenglonSub			int,
		   @EsCargo			bit,
		   @Cantidad			float,
		   @Factor			float,
		   @Articulo			char(20),
		   @SubCuenta			varchar(50),
		   @FechaRegistro		datetime,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpComisionCalcular ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpComisionCalcular') and sysstat & 0xf = 4) drop procedure dbo.xpComisionCalcular
GO             
CREATE PROCEDURE xpComisionCalcular
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Agente			char(10),
		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,

		   @Renglon			float,
		   @RenglonSub			int,
		   @Articulo			char(20), 
                   @Cantidad		        float,
		   @Importe			money,
                   @ImporteNeto			money,
		   @Impuestos			money,
		   @ImpuestosNetos		money,
		   @CostoUnitario		money,
                   @ArtCosto			money,
                   @ArtComision			varchar(20),

		   @ImporteComision		money		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
/* 
   La Comision se Calcula en los Movimientos de Tipo VTAS.F (Facturas), VTAS.D (Devoluciones) VTAS.B (Bonificaciones)
   y no se re-calcula cuando se cancela un movimiento.
*/
  DECLARE
    @TipoComisionAgente 	char(20),
    @TipoComisionArticulo	char(20),
    @ComisionFactura		float,
    @Comision   		float,
    @MovComisionImporte		money,
    @ArtComisionImporte		money,
    @CfgVentaComisionVariable	bit
 
  IF @Modulo = 'PROD'
  BEGIN
    -- Aqui se hace el calculo de comisiones o destajos de Produccion
    SELECT @ImporteComision = 0.0
    RETURN
  END ELSE
  IF @Agente IS NOT NULL AND @Accion <> 'CANCELAR'
  BEGIN
    SELECT @CfgVentaComisionVariable = ISNULL(VentaComisionVariable, 0)
      FROM EmpresaCfg
     WHERE Empresa = @Empresa

    SELECT @ArtComisionImporte = 0.0, @MovComisionImporte = 0.0
    SELECT @TipoComisionAgente = RTRIM(TipoComision),
           @ComisionFactura    = ISNULL(Porcentaje, 0)
      FROM Agente 
     WHERE Agente = @Agente
  
    IF @TipoComisionAgente = 'por Factura'
    BEGIN 
      IF @CfgVentaComisionVariable = 1
        SELECT @Comision = AgenteComision FROM Venta WHERE ID = @ID
      ELSE
        SELECT @Comision = @ComisionFactura      
    END

    IF @TipoComisionAgente = 'por Tipo Factura' 
      SELECT @Comision = ISNULL(Porcentaje, 0), 
             @MovComisionImporte = ISNULL(Importe, 0.0)
        FROM AgenteComisionTipoFactura
       WHERE Agente = @Agente AND Mov = @Mov

    IF @TipoComisionAgente = 'por Articulo'
      SELECT @Comision = ISNULL(Porcentaje, 0),
             @ArtComisionImporte = ISNULL(Importe, 0.0)
        FROM ArtComision 
       WHERE Comision = @ArtComision
                                          
    IF @TipoComisionAgente in ('Ambas', 'por Factura/Articulo')
      SELECT @Comision = @ComisionFactura + ISNULL(Porcentaje, 0),
             @ArtComisionImporte = ISNULL(Importe, 0.0)
        FROM ArtComision 
       WHERE Comision = @ArtComision

    IF @TipoComisionAgente = 'por Cliente' AND @Modulo = 'VTAS'
      SELECT @Comision = ISNULL(Comision, 0)
        FROM AgenteCte ac, Venta v
       WHERE ac.Agente = @Agente AND ac.Cliente = v.Cliente AND v.ID = @ID

    SELECT @TipoComisionArticulo = Tipo 
      FROM ArtComision 
      WHERE Comision = @ArtComision

    IF @TipoComisionArticulo = 'Utilidad' 
      SELECT @ImporteComision = (@ImporteNeto - (@CostoUnitario * @Cantidad)) * (@Comision / 100)
    ELSE
      SELECT @ImporteComision = @ImporteNeto * (@Comision / 100)

    -- Aumentar la Posible Comision x Importe x Articulo
    SELECT @ImporteComision = ISNULL(@ImporteComision, 0) + (ISNULL(@ArtComisionImporte, 0)*ISNULL(@Cantidad, 0)) + ISNULL(@MovComisionImporte, 0)

  END
  RETURN
END
GO

/**************** xpComisionCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpComisionCobro') and sysstat & 0xf = 4) drop procedure dbo.xpComisionCobro
GO             
CREATE PROCEDURE xpComisionCobro
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
		   @FechaEmision		datetime,
		   @FechaRegistro		datetime,
    		   @FechaAfectacion    		datetime,
		   @Agente			char(10),
		   @Conexion			bit,
	           @SincroFinal			bit,
		   @Sucursal			int,

 		   @IDAplica			int,
		   @AplicaMov			char(20),
		   @AplicaMovID			varchar(20),
		   @AplicaMovTipo		char(20),
		   @AplicaFechaEmision		datetime,
		   @AplicaVencimiento		datetime,
		   @AplicaImporteTotal		money,
		   @AplicaSaldo			money,
		   @AplicaComisionTotal		money,
		   @AplicaComisionPendiente	money,
		   @ImporteAplicar		money,
 	
		   @ImporteComision		money		OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
/* 
  En base al Importe Cobrado (@ImporteAplicar) y el Saldo del Movimiento (@AplicaSaldo) 
  el sistema sugiere el Importe de la Comision que Corresponde (@ImporteComision). 
  Si lo desea usted puede modificar este Importe.

   Ejemplo
      Si usted no quiere pagar comisiones despues de 20 dias de Emision 
      de la Factura, entonces agrege el siguiente comando

     IF DATEDIFF(day, @AplicaFechaEmision, @FechaEmision) > 20 SELECT @ImporteComision = 0.0
   
*/

  RETURN
END
GO

/**************** xpUnidadFactor ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpUnidadFactor') and sysstat & 0xf = 4) drop procedure dbo.xpUnidadFactor
GO             
CREATE PROCEDURE xpUnidadFactor
		    	@Articulo	char(20),
		    	@SubCuenta	varchar(50),
		    	@MovUnidad	varchar(50),
			@Factor	 	float	OUTPUT,
                        @Decimales	int	OUTPUT
AS BEGIN
  SELECT @Factor = 1.0
  SELECT @Factor = ISNULL(NULLIF(Factor, 0.0), 1.0), @Decimales = ISNULL(Decimales, 0.0) 
    FROM Unidad 
   WHERE Unidad = @MovUnidad
  RETURN
END
GO

/**************** xpArtUnidadFactor ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtUnidadFactor') and sysstat & 0xf = 4) drop procedure dbo.xpArtUnidadFactor
GO             
CREATE PROCEDURE xpArtUnidadFactor
		    	@Articulo	char(20),
		    	@SubCuenta	varchar(50),
		    	@MovUnidad	varchar(50),
			@Factor	 	float	OUTPUT,
                        @Decimales	int	OUTPUT,
			@Ok		int	OUTPUT
AS BEGIN
  SELECT @Factor = Factor
    FROM ArtUnidad 
   WHERE Articulo = @Articulo AND Unidad = @MovUnidad
--  IF @@ROWCOUNT = 0 SELECT @Ok = 20560

  SELECT @Decimales = 0
  SELECT @Decimales = ISNULL(Decimales, 0.0) 
    FROM Unidad 
   WHERE Unidad = @MovUnidad

  RETURN
END
GO


/**************** xpCantidadInventario ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCantidadInventario') and sysstat & 0xf = 4) drop procedure dbo.xpCantidadInventario
GO             
CREATE PROCEDURE xpCantidadInventario
		    	@Articulo		char(20),
		    	@SubCuenta		varchar(50),
		    	@MovUnidad		varchar(50),
			@CfgMultiUnidades	bit,
			@CfgMultiUnidadesNivel	char(20),
			@Cantidad		float,
			@CantidadInventario	float	OUTPUT
AS BEGIN
  DECLARE
     @Factor	 float,
     @Decimales	 int

  SELECT @Factor = 1.0
  IF @CfgMultiUnidades = 1
  BEGIN
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @Factor OUTPUT, @Decimales OUTPUT, NULL
    ELSE
      EXEC xpUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @Factor OUTPUT, @Decimales OUTPUT
  END

  SELECT @CantidadInventario = @Cantidad * ISNULL(@Factor, 1.0)
  
  RETURN
END
GO



/**************** xpUnidadFactorMov ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpUnidadFactorMov') and sysstat & 0xf = 4) drop procedure dbo.xpUnidadFactorMov
GO             
CREATE PROCEDURE xpUnidadFactorMov
			@Empresa		char(5), 
			@CfgMultiUnidades	bit,
			@CfgMultiUnidadesNivel	char(20),
    	      	    	@CfgCompraFactorDinamico bit,
		    	@CfgInvFactorDinamico   bit,
		    	@CfgProdFactorDinamico  bit,
		    	@CfgVentaFactorDinamico bit,
		    	@Accion			char(20),
		    	@Base			char(20),
		    	@Modulo			char(5),
			@ID			int,
			@Renglon		float,
			@RenglonSub		int,
                    	@Estatus		char(15),
                    	@EstatusNuevo		char(15),
                    	@MovTipo		char(20),
		    	@EsTransferencia	bit,
		    	@AfectarConsignacion	bit,
                    	@AlmacenTipo		char(15),
                    	@AlmacenDestinoTipo	char(15),
		    	@Articulo		char(20),
		    	@SubCuenta		varchar(50),
		    	@MovUnidad		varchar(50),
			@ArtUnidad		varchar(50),
                    	@ArtTipo		varchar(20),
                    	@RenglonTipo		char(1),
		    	@AplicaMovTipo		varchar(20),
			@Cantidad		float,	
			@CantidadInventario	float,
			@Factor			float		OUTPUT,
                        @Decimales		int		OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  SELECT @Factor = 1.0
  SELECT @ArtUnidad = NULLIF(RTRIM(@ArtUnidad), ''), @MovUnidad = NULLIF(RTRIM(@MovUnidad), '')
  IF @CfgMultiUnidades = 1 AND @MovTipo NOT IN ('COMS.PR') 
  BEGIN
    IF @ArtUnidad IS NULL SELECT @Ok = 20145 ELSE
    IF @MovUnidad IS NULL SELECT @Ok = 20150 ELSE
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
      -- Nivel Articulo
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @Factor OUTPUT, @Decimales OUTPUT, @OK OUTPUT
    ELSE BEGIN
      -- Nivel Unidad
      IF @MovUnidad <> @ArtUnidad 
      BEGIN
        IF NOT EXISTS(SELECT * FROM UnidadConversion WHERE Unidad IN (@ArtUnidad, @MovUnidad) AND Conversion IN (@MovUnidad, @ArtUnidad))--Bug 18854
          SELECT @Ok = 20540
      END
      IF @Ok IS NULL 
        EXEC xpUnidadFactor @Articulo, @SubCuenta, @MovUnidad, @Factor OUTPUT, @Decimales OUTPUT
    END

    IF @Ok IS NULL AND 
       ((@Modulo = 'VTAS' AND @CfgVentaFactorDinamico  = 1) OR 
        (@Modulo = 'COMS' AND @CfgCompraFactorDinamico = 1) OR
        (@Modulo = 'INV'  AND @CfgInvFactorDinamico    = 1) OR
        (@Modulo = 'PROD' AND @CfgProdFactorDinamico   = 1))
    BEGIN 
      -- Calcular el Factor Dinamico
      IF @CantidadInventario = 0.0 AND @MovTipo NOT IN ('VTAS.EST', 'INV.EST') SELECT @Ok = 20570 ELSE SELECT @Factor = ABS(@CantidadInventario) / NULLIF(@Cantidad, 0.0)
      IF @Ok = 20570 AND @MovTipo = 'INV.IF' SELECT @Ok = NULL
    END 
  END
  IF @Ok IS NOT NULL SELECT @OkRef = @Articulo
  RETURN
END
GO

/**************** xpSugerirCompra ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSugerirCompra') and sysstat & 0xf = 4) drop procedure dbo.xpSugerirCompra
GO             
CREATE PROCEDURE xpSugerirCompra
			@Empresa		char(5), 
			@CfgMultiUnidades	bit,
			@CfgMultiUnidadesNivel	char(20),
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@Almacen		char(10), 
                        @Existencia		float, 
			@ExistenciaConsignacion	float, 
			@ExistenciaReservada	float, 
			@VentasMostrador	float, 
			@Garantias		float, 
			@ActivosFijos		float, 
			@Piezas			float, 
		      	@PuntoOrden		float, 
			@PuntoOrdenOrdenar	float, 
			@Minimo			float, 
			@Maximo			float, 
			@CompraPendiente	float, 
			@VentaPendiente		float, 
			@ProdPendiente		float,
			@CantidadOrdenada	float, 
			@VentaRemisionada	float, 
			@InvPendiente		float, 
			@ClaveProveedor		char(20), 
			@UnidadCompra		varchar(50),
			@CompraMinima		float, 
			@Multiplos		int, 
			@MultiplosUnidad	varchar(50),
			@Disponible		float, 
			@porRecibir		float, 
			@porRecibirDisponible	float, 
			@porSurtir		float, 
			@Necesario		float, 
			@Flujo			float, 
			@SugerirNecesario	float, 
			@SugerirPuntoOrden	float, 

			@Sugerencia 		float		OUTPUT, 
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  DECLARE
    @Factor 	float,
    @Decimales	int

  SELECT @Factor = 1.0, @Decimales = 0
  IF @CfgMultiUnidades = 1
  BEGIN
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
    BEGIN
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @UnidadCompra, @Factor OUTPUT, @Decimales OUTPUT, @OK OUTPUT
      SELECT @Ok = NULL
    END ELSE
      EXEC xpUnidadFactor @Articulo, @SubCuenta, @UnidadCompra, @Factor OUTPUT, @Decimales OUTPUT
  END
  SELECT @Sugerencia = @SugerirPuntoOrden / @Factor
  IF @Ok IS NOT NULL SELECT @OkRef = @Articulo
  RETURN
END
GO


/**************** xpArtUnidadFactorRecalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtUnidadFactorRecalc') and sysstat & 0xf = 4) drop procedure dbo.xpArtUnidadFactorRecalc
GO
CREATE PROCEDURE xpArtUnidadFactorRecalc
			@Empresa		char(5), 
		    	@Accion			char(20),
		    	@Modulo			char(5),
			@ID			int,
			@Renglon		float,
			@RenglonSub		int,
                    	@MovTipo		char(20),
                    	@AlmacenTipo		char(15),
		    	@Articulo		char(20),
		    	@SubCuenta		varchar(50),
		    	@MovUnidad		varchar(50),
                    	@ArtTipo		varchar(20),
			@Factor			float,
 		        @Almacen		char(10), 
                        @Cantidad		float, 
	                @CantidadInventario	float, 
			@EsEntrada		bit, 
			@EsSalida		bit,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  IF NOT EXISTS(SELECT Empresa FROM EmpresaCfg2 WHERE Empresa = @Empresa AND AutoAjustarArtUnidadFactor = 1 AND UPPER(NivelFactorMultiUnidad) = 'ARTICULO') RETURN
  DECLARE
    @Aumentar		bit,
    @ArtUnidadFactor	float,
    @NuevoFactor	float,
    @InvAnterior	float,
    @ExistenciaAnterior	float

  IF @EsEntrada = 1 SELECT @Aumentar = 1 ELSE
  IF @EsSalida  = 1 SELECT @Aumentar = 0 ELSE RETURN

  SELECT @InvAnterior = SUM(Inventario) 
    FROM ArtSubExistenciaInv 
   WHERE Empresa = @Empresa AND Almacen = @Almacen AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
--   WHERE Articulo = @Articulo -- al parecer hay un error y deberia ser asi

  IF @Aumentar = 1 
    SELECT @InvAnterior = ISNULL(@InvAnterior, 0) - ISNULL(@CantidadInventario, 0)
  ELSE
    SELECT @InvAnterior = ISNULL(@InvAnterior, 0) + ISNULL(@CantidadInventario, 0)

  SELECT @ArtUnidadFactor = ISNULL(Factor, 1) FROM ArtUnidad WHERE Articulo = @Articulo AND Unidad = @MovUnidad
  SELECT @ExistenciaAnterior = ISNULL(@InvAnterior / NULLIF(@ArtUnidadFactor, 0), 0)

--select @Aumentar, @InvAnterior, @ExistenciaAnterior, @CantidadInventario
-- 1    2500.0  100.0  2600.0    2500.0 + 2600.0 / (100 + 100) = 25.5
-- 0    5100.0  200.0  2600.0    5100   - 2600   / 100
  IF @Aumentar = 1 
    SELECT @NuevoFactor = (@InvAnterior + ISNULL(@CantidadInventario, 0)) / NULLIF(@ExistenciaAnterior + @Cantidad, 0)
  ELSE
    SELECT @NuevoFactor = (@InvAnterior - ISNULL(@CantidadInventario, 0)) / NULLIF(@ExistenciaAnterior - @Cantidad, 0)

  --UPDATE ArtUnidad SET Factor = @NuevoFactor WHERE Articulo = @Articulo AND Unidad = @MovUnidad -- Bug 24107

  IF @@ROWCOUNT = 0
    INSERT ArtUnidad (Articulo, Unidad, Factor) VALUES (@Articulo, @MovUnidad, @NuevoFactor)

  RETURN
END
GO


/**************** xpCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCerrarDia') and sysstat & 0xf = 4) drop procedure dbo.xpCerrarDia
GO             
CREATE PROCEDURE xpCerrarDia
    		   @Empresa	 char(5), 
                   @Fecha	 datetime,
		   @Ok		 int	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCerrarDiaFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCerrarDiaFinal') and sysstat & 0xf = 4) drop procedure dbo.xpCerrarDiaFinal
GO             
CREATE PROCEDURE xpCerrarDiaFinal
    		   @Empresa	 char(5), 
                   @Fecha	 datetime,
		   @Ok		 int	OUTPUT
AS BEGIN
  RETURN
END
GO

/* xpImportarPrecios */
if exists (select * from sysobjects where id = object_id('dbo.xpImportarPrecios') and sysstat & 0xf = 4) drop procedure dbo.xpImportarPrecios
GO             
CREATE PROCEDURE xpImportarPrecios @Estacion int
AS BEGIN
  SET nocount ON
  DECLARE
    @FechaRegistro	datetime,
    @Articulo		char(20),
    @Clave		char(20),
    @Descripcion	varchar(100),
    @PrecioActual	money,
    @PrecioAnterior	money,
    @Estatus		char(15)

  -- Obtiene la Fecha del Servidor
  SELECT @FechaRegistro = GETDATE()

--  BEGIN TRANSACTION
    DECLARE crListaPrecios CURSOR FOR 
     SELECT NULLIF(RTRIM(ip.Articulo), ''), NULLIF(RTRIM(ip.Descripcion), ''), ip.Precio, a.Articulo, a.PrecioLista
       FROM ImportarPrecios ip
       LEFT OUTER JOIN Art a ON ip.Articulo = a.Articulo
      WHERE Estacion = @Estacion

    OPEN crListaPrecios
    FETCH NEXT FROM crListaPrecios INTO @Clave, @Descripcion, @PrecioActual, @Articulo, @PrecioAnterior
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        -- Si no Existe
        IF @Articulo IS NULL 
        BEGIN
           INSERT INTO Art (Articulo,  Descripcion1, PrecioLista,  UltimoCambio,  Estatus,  MonedaCosto, MonedaPrecio, Impuesto1, Tipo)
                    VALUES (@Clave, @Descripcion, @PrecioActual,@FechaRegistro, 'NUEVO', 'Pesos',     'Pesos',      15,        'Normal')
        END ELSE
        BEGIN
          IF @PrecioActual < @PrecioAnterior SELECT @Estatus = 'BAJO'  ELSE
          IF @PrecioActual > @PrecioAnterior SELECT @Estatus = 'SUBIO' ELSE 
          SELECT @Estatus = 'SINCAMBIO'
          UPDATE Art
             SET PrecioAnterior = @PrecioAnterior,
                 PrecioLista    = @PrecioActual,
                 UltimoCambio   = @FechaRegistro,
                 Estatus        = @Estatus
           WHERE Articulo = @Articulo
        END
      END 
      FETCH NEXT FROM crListaPrecios INTO @Clave, @Descripcion, @PrecioActual, @Articulo, @PrecioAnterior
    END 
    CLOSE crListaPrecios
    DEALLOCATE crListaPrecios
--  COMMIT TRANSACTION 
  RETURN
END
GO

/**************** xpUnidadFactorProd ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpUnidadFactorProd') and sysstat & 0xf = 4) drop procedure dbo.xpUnidadFactorProd
GO             
CREATE PROCEDURE xpUnidadFactorProd
			@CfgMultiUnidades	bit,
			@CfgMultiUnidadesNivel	char(20),
		    	@Articulo		char(20),
			@SubCuenta		varchar(50),
		    	@Unidad			varchar(50),
			@Factor			float		OUTPUT,
                        @Decimales		int		OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  SELECT @Factor = 1.0
  SELECT @Unidad = NULLIF(RTRIM(@Unidad), '')
  IF @CfgMultiUnidades = 1
  BEGIN
    IF @Unidad IS NULL SELECT @Ok = 20150 ELSE
    IF @CfgMultiUnidadesNivel = 'ARTICULO'
      -- Nivel Articulo
      EXEC xpArtUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT, @OK OUTPUT
    ELSE BEGIN
      -- Nivel Unidad
      IF @Ok IS NULL 
        EXEC xpUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT
    END
  END
  IF @Ok IS NOT NULL SELECT @OkRef = @Articulo
  RETURN
END
GO

/**************** xpInvVerificarCteArtBloqueo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificarCteArtBloqueo') and sysstat & 0xf = 4) drop procedure dbo.xpInvVerificarCteArtBloqueo
GO             
CREATE PROCEDURE xpInvVerificarCteArtBloqueo
			@Empresa		char(5), 
			@ID			int,
		    	@Usuario		char(10),
		    	@Cliente		char(10),
		    	@Articulo		char(20),

		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
DECLARE
  @Categoria	varchar(50),
  @Grupo	varchar(50),
  @Familia	varchar(50),
  @Fabricante	varchar(50)

  IF EXISTS(SELECT * FROM CteArtBloqueo WHERE Cliente = @Cliente)
  BEGIN
    SELECT @Categoria  = Categoria,
	   @Grupo      = Grupo,
	   @Familia    = Familia,
	   @Fabricante = Fabricante
      FROM Art
     WHERE Articulo = @Articulo

     IF EXISTS(
       SELECT * 
         FROM CteArtBloqueo 
         WHERE Cliente = @Cliente 
           AND ((UPPER(Agrupador) = 'CATEGORIA'  AND Nombre = @Categoria)
            OR (UPPER(Agrupador)  = 'GRUPO'      AND Nombre = @Grupo) 
            OR (UPPER(Agrupador)  = 'FAMILIA'    AND Nombre = @Familia) 
            OR (UPPER(Agrupador)  = 'FABRICANTE' AND Nombre = @Fabricante)))
       SELECT @Ok = 65050, @OkRef = @Articulo
  END
  RETURN
END
GO

/**************** xpConsecutivoSerie ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpConsecutivoSerie') and sysstat & 0xf = 4) drop procedure dbo.xpConsecutivoSerie
GO             
CREATE PROCEDURE xpConsecutivoSerie
			@Empresa		char(5), 
		    	@Modulo			char(5),
			@ID			int,
			@Mov			char(20),
			@Serie			char(20)	OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  -- Este procedimiento sirve para generar o validar una serie de consecutivos
  RETURN
END
GO

/**************** xpConsecutivoPrefijo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpConsecutivoPrefijo') and sysstat & 0xf = 4) drop procedure dbo.xpConsecutivoPrefijo
GO             
CREATE PROCEDURE xpConsecutivoPrefijo
			@Empresa		char(5), 
		    	@Modulo			char(5),
			@ID			int,
			@Mov			varchar(20),
			@MovID			varchar(20),
			@Prefijo		char(10)	OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  -- Este procedimiento sirve para generar o validar un prefijo de consecutivos
  RETURN
END
GO

/**************** xpMovConsecutivo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovConsecutivo') and type = 'P') drop procedure dbo.xpMovConsecutivo
GO             
CREATE PROCEDURE xpMovConsecutivo
			@Sucursal		int,
			@SucursalOrigen		int,
			@SucursalDestino	int,
		    	@Empresa		char(5), 
			@Usuario		char(10),
			@Modulo			char(5), 
			@Ejercicio		int, 
			@Periodo		int,
			@ID			int,
			@Mov			char(20), 
			@Serie			char(20),
			@Estatus		char(15),
			@Concepto		varchar(50),

	      	        @Accion			char(20),
			@Conexion		bit,
			@SincroFinal		bit,

			@MovID 			varchar(20)	OUTPUT, 

			@Ok			int		OUTPUT,
		        @OkRef			varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO


/**************** xpVerCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVerCosto') and sysstat & 0xf = 4) drop procedure dbo.xpVerCosto
GO             
CREATE PROCEDURE xpVerCosto
                        @Empresa	char(5),
			@Proveedor	char(10),
			@Articulo	char(20),		
			@MovUnidad	varchar(50),
			@Cual		char(20),
			@MovMoneda	char(10),
			@MovTipoCambio	float,
                        @Costo 		money OUTPUT
AS BEGIN

  -- Este procedimiento sirve para sugerir un costo
  RETURN
END
GO

/**************** xpPrecioCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPrecioCalc') and sysstat & 0xf = 4) drop procedure dbo.xpPrecioCalc
GO             
CREATE PROCEDURE xpPrecioCalc
			@Sucursal	int,
                        @Empresa	char(5),
			@Articulo	char(20),
			@SubCuenta	varchar(50),
			@Unidad		varchar(50),
			@Moneda		char(10),
			@TipoCambio	float,
     			@ListaPrecios	varchar(20),
     			@Base		varchar(20),
     			@PrecioBase	money,
			@Porcentaje	float, 
     			@Precio		money 	OUTPUT
AS BEGIN

  -- Este procedimiento sirve para calcular un precio especial
  /* Ejemplo 
	Precio = (Costo Estandar * 1.15 / (1-Margen)
	Redondear < 250 a un peso
        Renondear >= 250 a cinco pesos*/
	
    DECLARE
      @Margen		float,
      @Dif		money,
      @PrecioBruto	money

    SELECT @Margen = Margen FROM Art WHERE Articulo = @Articulo
    SELECT @PrecioBruto = @PrecioBase * 1.15 / ( 1- (@Margen/100))
    IF @PrecioBruto < 250 
      SELECT @Precio = ROUND(@PrecioBruto, 0)
    ELSE   
    BEGIN
      SELECT @Precio = ROUND(@PrecioBruto, -1)
      SELECT @Dif = ROUND(@PrecioBruto - @Precio, 4)
      IF ABS(@Dif) > 2.5
      BEGIN
        IF @Dif > 0 SELECT @Precio = @Precio + 5 ELSE SELECT @Precio = @Precio - 5 
      END       
    END
  
  RETURN
END
GO

/**************** xpCompraAutoCargos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCompraAutoCargos') and sysstat & 0xf = 4) drop procedure dbo.xpCompraAutoCargos
GO             
CREATE PROCEDURE xpCompraAutoCargos
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
		   @Modulo			char(5),
    		   @Empresa	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,       
    		   @FechaEmision      		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Condicion			varchar(50), 
		   @Vencimiento			datetime,
		   @Proveedor			char(10),

		   @Importe			money,
		   @Impuestos			money,

		   @VIN				varchar(20),
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT

AS BEGIN
  DECLARE
     @CxModulo		char(5),
     @CxMov		char(20),
     @CxMovID		varchar(20),
     @Porcentaje	float,
     @MovCargo		char(20),
     @EsCargo		bit,
     @ImporteCargo	money,
     @ImpuestosCargo	money,
     @ImporteTotal	money,
     @Aplica		char(20),
     @AplicaID		varchar(20),
     @Tipo		varchar(20)

--  IF @MovTipo = 'COMS.B' RETURN

  SELECT @EsCargo = 1, @Aplica = @Mov, @AplicaID = @MovID
  IF @MovTipo IN ('COMS.D', 'COMS.B', 'GAS.DG', 'GAS.DC') SELECT @EsCargo = ~@EsCargo
  SELECT @Tipo = ISNULL(UPPER(RTRIM(CompraAutoCargosTipo)), 'NO'),
         @Porcentaje = NULLIF(CompraAutoCargos, 0)
    FROM Prov
   WHERE Proveedor = @Proveedor
  SELECT @MovCargo = CASE WHEN @EsCargo = 1 THEN CxpCreditoProveedor ELSE CxpCargoProveedor END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  IF @Porcentaje < 0 SELECT @Ok = 55070

  IF @Tipo = 'DIRECTA'
  BEGIN
    SELECT @Porcentaje = AutoCargos FROM Compra WHERE ID = @ID
    SELECT @ImporteCargo   = @Importe   * (@Porcentaje / 100),
           @ImpuestosCargo = @Impuestos * (@Porcentaje / 100)
    SELECT @ImporteTotal = @ImporteCargo + @ImpuestosCargo

    IF @ImporteCargo IS NOT NULL
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXP', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
	               @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		       @FechaRegistro, @Ejercicio, @Periodo,
  		       @Condicion, @Vencimiento, @Proveedor, NULL, NULL, NULL, NULL, NULL,
                       @ImporteCargo, @ImpuestosCargo, NULL, NULL, 
                       NULL, @Aplica, @AplicaID, @ImporteTotal, @VIN, @MovCargo,
		       @CxModulo, @CxMov, @CxMovID,
                       @Ok OUTPUT, @OkRef OUTPUT, 'SIN_ORIGEN'
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
  END ELSE
  IF @Tipo = 'MULTIPLE'
  BEGIN
    DECLARE crProvAutoCargos CURSOR FOR 
     SELECT Concepto, Porcentaje
       FROM ProvAutoCargos
      WHERE Proveedor = @Proveedor 
        AND (@FechaEmision BETWEEN FechaD AND FechaA OR (@FechaEmision >= FechaD AND FechaA IS NULL) OR (FechaD IS NULL AND @FechaEmision <= FechaA) OR (FechaD IS NULL AND FechaA IS NULL))

    OPEN crProvAutoCargos
    FETCH NEXT FROM crProvAutoCargos INTO @Concepto, @Porcentaje
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        IF @Porcentaje < 0 SELECT @Ok = 55070
        SELECT @ImporteCargo   = @Importe   * (@Porcentaje / 100),
               @ImpuestosCargo = @Impuestos * (@Porcentaje / 100)
        SELECT @ImporteTotal = @ImporteCargo + @ImpuestosCargo

        IF @ImporteCargo IS NOT NULL AND @Ok IS NULL
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXP', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
	                   @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		           @FechaRegistro, @Ejercicio, @Periodo,
 		           @Condicion, @Vencimiento, @Proveedor, NULL, NULL, NULL, NULL, NULL,
                           @ImporteCargo, @ImpuestosCargo, NULL, NULL, 
                           NULL, @Aplica, @AplicaID, @ImporteTotal, @VIN, @MovCargo,
		           @CxModulo, @CxMov, @CxMovID,
                           @Ok OUTPUT, @OkRef OUTPUT, 'SIN_ORIGEN'
        FETCH NEXT FROM crProvAutoCargos INTO @Concepto, @Porcentaje
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
      END
    END 
    CLOSE crProvAutoCargos
    DEALLOCATE crProvAutoCargos
  END
  RETURN
END
GO

/**************** xpVentaAutoBonif ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaAutoBonif') and sysstat & 0xf = 4) drop procedure dbo.xpVentaAutoBonif
GO             
CREATE PROCEDURE xpVentaAutoBonif
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
		   @Modulo			char(5),
    		   @Empresa	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,       
    		   @FechaEmision      		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Condicion			varchar(50), 
		   @Vencimiento			datetime,
		   @Cliente			char(10),
		   @CobroIntegrado		bit, 

		   @Importe			money,
		   @Impuestos			money,

		   @VIN				varchar(20),
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT,

		   -- BUG 16650
		   @Agente		varchar(10)=NULL

AS BEGIN
  DECLARE
     @CxModulo		char(5),
     @CxMov		char(20),
     @CxMovID		varchar(20),
     @Porcentaje	float,
     @MovCargo		char(20),
     @EsCredito		bit,
     @ImporteCargo	money,
     @ImpuestosCargo	money,
     @ImporteTotal	money,
     @Aplica		char(20),
     @AplicaID		varchar(20),
     @BonificacionTipo	varchar(20),
     @EnviarA		int

--  IF @MovTipo = 'VTAS.B' RETURN

  
  SELECT @Aplica = @Mov, @AplicaID = @MovID
--  Comentando esto no autoaplica la bonificacion automatica

  SELECT @EsCredito = 1
  IF @MovTipo IN ('VTAS.D', 'VTAS.DF','VTAS.B')
  BEGIN
    SELECT @EsCredito = ~@EsCredito

    -- EToral. Debe aplicar a la Nota de Credito, aplicaba a Devolución venta y mandaba error de que el importa excedia al saldo a aplicar. BUG10848
    SELECT @Aplica = mf.DMov, @AplicaID = mf.DMovID
      FROM MovFlujo mf
     WHERE mf.OModulo = 'VTAS' AND mf.OID = @ID AND mf.DModulo = 'CXC'
  END

  IF @CobroIntegrado = 1 SELECT @Aplica = NULL, @AplicaID = NULL
  SELECT @BonificacionTipo = ISNULL(UPPER(RTRIM(BonificacionTipo)), 'NO') FROM Cte WHERE Cliente = @Cliente
  SELECT @MovCargo = CASE WHEN @EsCredito = 1 THEN CxcNCredito ELSE CxcNCargo END
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  SELECT @EnviarA = EnviarA FROM Venta WHERE ID = @ID

  IF @BonificacionTipo = 'DIRECTA'
  BEGIN
    SELECT @Porcentaje = NULLIF(Bonificacion, 0) FROM Venta WHERE ID = @ID
    IF @Porcentaje < 0 SELECT @Ok = 55070
    SELECT @ImporteCargo   = @Importe   * (@Porcentaje / 100),
           @ImpuestosCargo = @Impuestos * (@Porcentaje / 100)
    SELECT @ImporteTotal = @ImporteCargo + @ImpuestosCargo
    IF @ImporteCargo IS NOT NULL AND @Ok IS NULL
      EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXC', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
	               @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		       @FechaRegistro, @Ejercicio, @Periodo,
  		       @Condicion, @Vencimiento, @Cliente, @EnviarA, @Agente, NULL, NULL, NULL, -- BUG 16650
                       @ImporteCargo, @ImpuestosCargo, NULL, NULL, 
                       NULL, @Aplica, @AplicaID, @ImporteTotal, @VIN, @MovCargo,
		       @CxModulo, @CxMov, @CxMovID,
                       @Ok OUTPUT, @OkRef OUTPUT, 'SIN_ORIGEN', @NoAutoAplicar = 1 -- BUG10848
    IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
  END ELSE
  IF @BonificacionTipo = 'MULTIPLE'
  BEGIN
    DECLARE crCteBonificacion CURSOR FOR 
     SELECT Concepto, Porcentaje
       FROM CteBonificacion
      WHERE Cliente = @Cliente
        AND (@FechaEmision BETWEEN FechaD AND FechaA OR (@FechaEmision >= FechaD AND FechaA IS NULL) OR (FechaD IS NULL AND @FechaEmision <= FechaA) OR (FechaD IS NULL AND FechaA IS NULL))

    OPEN crCteBonificacion
    FETCH NEXT FROM crCteBonificacion INTO @Concepto, @Porcentaje
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        IF @Porcentaje < 0 SELECT @Ok = 55070
        SELECT @ImporteCargo   = @Importe   * (@Porcentaje / 100),
               @ImpuestosCargo = @Impuestos * (@Porcentaje / 100)
        SELECT @ImporteTotal = @ImporteCargo + @ImpuestosCargo

        IF @ImporteCargo IS NOT NULL AND @Ok IS NULL
          EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXC', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
	                   @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   		           @FechaRegistro, @Ejercicio, @Periodo,
    		           @Condicion, @Vencimiento, @Cliente, @EnviarA, @Agente, NULL, NULL, NULL, -- BUG 16650
                           @ImporteCargo, @ImpuestosCargo, NULL, NULL, 
                           NULL, @Aplica, @AplicaID, @ImporteTotal, @VIN, @MovCargo,
		           @CxModulo, @CxMov, @CxMovID,
                           @Ok OUTPUT, @OkRef OUTPUT, 'SIN_ORIGEN', @NoAutoAplicar = 1 -- BUG10848
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        FETCH NEXT FROM crCteBonificacion INTO @Concepto, @Porcentaje
      END
    END 
    CLOSE crCteBonificacion
    DEALLOCATE crCteBonificacion
  END
  RETURN
END
GO

/**************** xpVentaAutoAplicarAnticiposPedidos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaAutoAplicarAnticiposPedidos') and sysstat & 0xf = 4) drop procedure dbo.xpVentaAutoAplicarAnticiposPedidos
GO             
CREATE PROCEDURE xpVentaAutoAplicarAnticiposPedidos
		   @Sucursal			int,
		   @SucursalOrigen		int,
		   @SucursalDestino		int,
		   @Accion			char(20),
		   @Modulo			char(5),
    		   @Empresa	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,       
    		   @FechaEmision      		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @Referencia	      		varchar(50),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Condicion			varchar(50), 
		   @Vencimiento			datetime,
		   @Cliente			char(10),
		   @CobroIntegrado		bit, 

		   @Importe			money,
		   @Impuestos			money,

		   @VIN				varchar(20),
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT

AS BEGIN
  DECLARE
     @CxID		int,
     @CxModulo		char(5),
     @CxMov		char(20),
     @CxMovID		varchar(20),
     @Porcentaje	float,
     @MovAplicacion	char(20),
     @ImporteAplicar	money,
     @Saldo		money,
     @Aplica		char(20),
     @AplicaID		varchar(20),
     @BonificacionTipo	varchar(20),
     @EnviarA		int

  SELECT @Importe = 0.0, @Saldo = 0.0

  SELECT @MovAplicacion = CxcAplicacionSaldo
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa
  SELECT @EnviarA = EnviarA FROM Venta WHERE ID = @ID

  IF @Accion = 'CANCELAR'
  BEGIN
    SELECT @CxID = MIN(ID) FROM Cxc WHERE Empresa = @Empresa AND Mov = @MovAplicacion AND DocFuente = @ID AND Estatus IN ('PENDIENTE', 'CONCLUIDO')
    IF @CxID IS NOT NULL
    BEGIN
      SELECT @CxMov = Mov, @CxMovID = MovID FROM Cxc WHERE ID = @CxID
      EXEC spCx @CxID, 'CXC', @Accion, 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                @CxMov, @CxMovID, NULL, 
                @Ok OUTPUT, @OkRef OUTPUT

      EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'CXC', @CxID, @CxMov, @CxMovID, @Ok OUTPUT    
    END
  END ELSE
  BEGIN
    EXEC spSugerirVentaCobroEfectivo @ID, 1, @ImporteAplicar OUTPUT, @MovAplicacion
    SELECT @Saldo = ISNULL(Saldo, 0) FROM Cxc WHERE Empresa = @Empresa AND Mov = @Mov AND MovID = @MovID AND Estatus = 'PENDIENTE'
    IF @Saldo < @ImporteAplicar SELECT @ImporteAplicar = @Saldo
    IF ISNULL(@ImporteAplicar, 0) <= 0 RETURN
    SELECT @DocFuente = @ID
    EXEC spGenerarCx @Sucursal, @SucursalOrigen, @SucursalDestino, @Accion, 'CXC', @Empresa, @Modulo, @ID, @Mov, @MovID, @MovTipo, @MovMoneda, @MovTipoCambio, 
                     @FechaEmision, @Concepto, @Proyecto, @Usuario, @Autorizacion, @Referencia, @DocFuente, @Observaciones,
   	  	     @FechaRegistro, @Ejercicio, @Periodo,
  		     NULL, NULL, @Cliente, @EnviarA, NULL, NULL, NULL, NULL,
                     @ImporteAplicar, NULL, NULL, NULL, 
                     NULL, @Mov, @MovID, @ImporteAplicar, @VIN, @MovAplicacion,
		     @CxModulo, @CxMov, @CxMovID,
                     @Ok OUTPUT, @OkRef OUTPUT, 'SIN_ORIGEN'
  END
  RETURN
END
GO

/************** xpValeAplicacion ***************/
if exists (select * from sysobjects where id = object_id('dbo.xpValeAplicacion') and sysstat & 0xf = 4) drop procedure dbo.xpValeAplicacion
GO
CREATE PROCEDURE xpValeAplicacion
		   @Sucursal		int,
		   @Accion		char(20),
		   @Modulo		char(5),
    		   @Empresa	      	char(5),
                   @ID			int,
 		   @Mov			char(20),
    		   @MovID             	varchar(20),
    		   @MovTipo     	char(20),
    		   @MovMoneda	      	char(10),
    		   @MovTipoCambio	float,       
    		   @FechaEmision      	datetime,
    		   @Concepto	      	varchar(50),
    	 	   @Proyecto	      	varchar(50),
    		   @Usuario	      	char(10),
    		   @Autorizacion      	char(10),
    		   @Referencia	      	varchar(50),
    		   @DocFuente	      	int,
    		   @Observaciones     	varchar(255),
    		   @FechaRegistro     	datetime,
    		   @Ejercicio	      	int,
    		   @Periodo	      	int,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN

/* Ejemplo Control de Vales para Viana */

/*
  DECLARE
    @EMov		char(20),
    @PMov		char(20),
    @FMov		char(20),
    @EConcepto		varchar(50),
    @PConcepto		varchar(50),
    @FConcepto		varchar(50),
    @Serie		varchar(20),
    @Importe		money,
    @Moneda		char(10),
    @TipoCambio		float,
    @Tipo		char(1),
    @Contacto		char(10),
    @Proveedor		char(10),
    @Personal		char(10),
    @Condicion		varchar(50),
    @GenerarMov		char(20),
    @GenerarMovID	varchar(20),
    @GenerarModulo	char(5),
    @GenerarID		int,
    @GenerarConcepto	varchar(50)

  SELECT @PMov = 'Nota Cargo', 		@PConcepto = @Concepto,
	 @FMov = 'Nota Cargo',		@FConcepto = @Concepto,
         @EMov = 'Otras Deducciones',	@EConcepto = @Concepto

  SELECT @Referencia = RTRIM(@Mov)+' '+RTRIM(@MovID)

  IF @Accion = 'CANCELAR'
  BEGIN
    -- Cancelar Cxp
    DECLARE crValesCxp CURSOR FOR
     SELECT ID
       FROM Cxp
      WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID
    OPEN crValesCxp

    FETCH NEXT FROM crValesCxp INTO @GenerarID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spCx @GenerarID, 'CXP', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @GenerarMov OUTPUT, @GenerarMovID OUTPUT, NULL, 
                  @Ok OUTPUT, @OkRef OUTPUT

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'CXP', @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crValesCxp INTO @GenerarID
    END
    CLOSE crValesCxp
    DEALLOCATE crValesCxp   

    -- Cancelar Nomina
    DECLARE crValesNomina CURSOR FOR
     SELECT ID
       FROM Nomina
      WHERE OrigenTipo = @Modulo AND Origen = @Mov AND OrigenID = @MovID
    OPEN crValesNomina

    FETCH NEXT FROM crValesNomina INTO @GenerarID
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        EXEC spNomina @GenerarID, 'NOM', 'CANCELAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @GenerarMov OUTPUT, @GenerarMovID OUTPUT, NULL, 
                      @Ok OUTPUT, @OkRef OUTPUT

        EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'NOM', @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
      END
      FETCH NEXT FROM crValesNomina INTO @GenerarID
    END
    CLOSE crValesNomina
    DEALLOCATE crValesNomina
  END ELSE
  BEGIN
    DECLARE crVales CURSOR FOR
     SELECT NULLIF(RTRIM(SUBSTRING(d.Serie, 1, 7)), ''), s.Moneda, SUM(s.Precio)
       FROM ValeD d, ValeSerie s 
      WHERE d.ID = @ID AND s.Serie = d.Serie
      GROUP BY NULLIF(RTRIM(SUBSTRING(d.Serie, 1, 7)), ''), s.Moneda
      ORDER BY NULLIF(RTRIM(SUBSTRING(d.Serie, 1, 7)), ''), s.Moneda
    
    OPEN crVales
    FETCH NEXT FROM crVales INTO @Serie, @Moneda, @Importe
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN                         
      IF @@FETCH_STATUS <> -2 AND @Serie IS NOT NULL AND @Ok IS NULL
      BEGIN
        IF @Moneda = @MovMoneda SELECT @TipoCambio = @MovTipoCambio ELSE SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

        SELECT @Proveedor = NULL, @Condicion = NULL, @Personal = NULL
        SELECT @Tipo = UPPER(SUBSTRING(@Serie, 1, 1))		-- E = Empleado, P = Proveedor, F = Fletero
        SELECT @Contacto = NULLIF(RTRIM(UPPER(SUBSTRING(@Serie, 2, 6))), '')

        IF @Tipo = 'P' SELECT @GenerarMov = @PMov, @GenerarConcepto = @PConcepto ELSE
        IF @Tipo = 'F' SELECT @GenerarMov = @FMov, @GenerarConcepto = @FConcepto ELSE
        IF @Tipo = 'E' SELECT @GenerarMov = @EMov, @GenerarConcepto = @EConcepto 

        IF @Tipo IN ('P', 'F') 
        BEGIN
          SELECT @Proveedor = Proveedor, @Condicion = Condicion FROM Prov WHERE Proveedor = @Contacto
          IF @Proveedor IS NOT NULL
          BEGIN
            INSERT Cxp (Sucursal,  OrigenTipo, Origen, OrigenID, Empresa,  Mov,         FechaEmision,  Concepto,         Proyecto,  Moneda,  TipoCambio,  Usuario,  Referencia,  Observaciones,  Estatus,      Proveedor,  ProveedorMoneda, ProveedorTipoCambio, Importe)
                VALUES (@Sucursal, @Modulo,    @Mov,   @MovID,   @Empresa, @GenerarMov, @FechaEmision, @GenerarConcepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Referencia, @Observaciones, 'SINAFECTAR', @Proveedor, @Moneda,         @TipoCambio,         @Importe)
            SELECT @GenerarID = SCOPE_IDENTITY()

            EXEC spCx @GenerarID, 'CXP', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                      @GenerarMov OUTPUT, @GenerarMovID OUTPUT, NULL, 
                      @Ok OUTPUT, @OkRef OUTPUT
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'CXP', @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
          END ELSE SELECT @Ok = 36180, @OkRef = @Serie 
        END

        IF @Tipo = 'E' 
        BEGIN
          SELECT @Personal = Personal FROM Personal WHERE Personal = @Contacto
          IF @Personal IS NOT NULL
          BEGIN
            INSERT Nomina (Sucursal,  OrigenTipo, Origen, OrigenID, Empresa,  Mov,         FechaEmision,  Concepto,         Proyecto,  Moneda,  TipoCambio,  Usuario,  Observaciones,  Estatus)
                   VALUES (@Sucursal, @Modulo,    @Mov,   @MovID,   @Empresa, @GenerarMov, @FechaEmision, @GenerarConcepto, @Proyecto, @Moneda, @TipoCambio, @Usuario, @Observaciones, 'SINAFECTAR')
            SELECT @GenerarID = SCOPE_IDENTITY()
            INSERT NominaD (ID,         Renglon, Modulo, Personal,  Importe,  Referencia) 
                    VALUES (@GenerarID, 2048.0,  'NOM',  @Personal, @Importe, @Referencia) 

            EXEC spNomina @GenerarID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                          @GenerarMov OUTPUT, @GenerarMovID OUTPUT, NULL, 
                          @Ok OUTPUT, @OkRef OUTPUT
            EXEC spMovFlujo @Sucursal, @Accion, @Empresa, @Modulo, @ID, @Mov, @MovID, 'NOM', @GenerarID, @GenerarMov, @GenerarMovID, @Ok OUTPUT
          END ELSE SELECT @Ok = 36180, @OkRef = @Serie 
        END
      END
      FETCH NEXT FROM crVales INTO @Serie, @Moneda, @Importe
    END
    CLOSE crVales
    DEALLOCATE crVales
  END  */
  RETURN
END
GO


/************** xpPlanArtOPLiberar ***************/
if exists (select * from sysobjects where id = object_id('dbo.xpPlanArtOPLiberar') and sysstat & 0xf = 4) drop procedure dbo.xpPlanArtOPLiberar
GO
CREATE PROCEDURE xpPlanArtOPLiberar
			@Empresa		char(5),
			@Sucursal		int,
			@Usuario		char(10),
        		@Modulo			char(5), 
			@ID			int, 
			@Moneda			char(10),
			@Renglon		float, 
			@RenglonSub		int, 
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@Almacen		char(10), 
			@Cantidad		float, 
			@Unidad			varchar(50), 
			@CantidadInventario	float, 
			@ProvRutaDestino	char(10), 
			@FechaEntrega		datetime,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
/*  IF @Modulo <> 'INV' RETURN

  DECLARE
    @Promedio	float,
    @Precio	money

  SELECT @Promedio = NULL, @Precio = NULL
  EXEC spPrecioEsp NULL, @Moneda, @Articulo, @SubCuenta, @Precio OUTPUT
  SELECT @Promedio = NULLIF(Promedio, 0)
    FROM DemandaPaquetesPromedio 
   WHERE Empresa = @Empresa AND Almacen = @ProvRutaDestino AND Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(RTRIM(@SubCuenta), '')

  UPDATE InvD 
     SET Paquete = Cantidad / @Promedio,
         Precio = @Precio
   WHERE ID = @ID AND Renglon = @Renglon AND RenglonSub = @RenglonSub*/
  RETURN
END
GO

/**************** xpCompactarOrdenes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCompactarOrdenes') and type = 'P') drop procedure dbo.xpCompactarOrdenes
GO             
CREATE PROCEDURE xpCompactarOrdenes
			@Empresa	char(5),
			@Usuario	char(10),
			@Modulo		char(5),
			@AlmacenEsp	char(10),
			@SinReservar	bit		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpPCSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPCSugerir') and sysstat & 0xf = 4) drop procedure dbo.xpPCSugerir
GO             
CREATE PROCEDURE xpPCSugerir

   @ID int  
   AS BEGIN  
   DECLARE  
   @Sucursal int,  
   @Empresa char(5),  
   @Articulo char(20),  
   @SubCuenta varchar(50),  
   @Unidad varchar(50),  
   @Moneda char(10),  
   @TipoCambio float,  
   @Lista varchar(20),  
   @Precio money,  
   @Nuevo money,  
   @Anterior money,  
   @Renglon float,  
   @MovTipo char(20),  
   @PrecioNivelUnidad bit  
SELECT @Sucursal = pc.Sucursal, @Empresa = pc.Empresa, @Lista = pc.ListaModificar, @Moneda = pc.Moneda, @TipoCambio = pc.TipoCambio, @MovTipo = mt.Clave  
FROM PC, MovTipo mt  
WHERE pc.ID = @ID AND mt.Modulo = 'PC' AND mt.Mov = pc.Mov  
SELECT @PrecioNivelUnidad = ISNULL(PrecioNivelUnidad, 0)  
FROM EmpresaCfg2  
WHERE Empresa = @Empresa  
DELETE PCD WHERE ID = @ID  
SELECT @Renglon = 0  
IF @PrecioNivelUnidad = 1  
BEGIN  
IF EXISTS(SELECT * FROM ListaPreciosSubUnidad WHERE Lista = @Lista AND Moneda = @Moneda)  
DECLARE crPCSugerir CURSOR FOR  
SELECT Articulo, SubCuenta, Unidad, MIN(Precio)  
FROM ListaPreciosSubUnidad  
WHERE Lista = @Lista AND Moneda = @Moneda AND ISNULL(Precio, 0.0) > 0.0  
GROUP BY Articulo, SubCuenta, Unidad  
ORDER BY Articulo, SubCuenta, Unidad  
ELSE  
DECLARE crPCSugerir CURSOR FOR  
SELECT Articulo, CONVERT(varchar, NULL), Unidad, MIN(Precio)  
FROM ListaPreciosDUnidad  
WHERE Lista = @Lista AND Moneda = @Moneda AND ISNULL(Precio, 0.0) > 0.0  
GROUP BY Articulo, Unidad  
ORDER BY Articulo, Unidad  
END ELSE  
BEGIN  
IF EXISTS(SELECT * FROM ListaPreciosSub WHERE Lista = @Lista AND Moneda = @Moneda)  
DECLARE crPCSugerir CURSOR FOR  
SELECT Articulo, SubCuenta, CONVERT(varchar, NULL), MIN(Precio)  
FROM ListaPreciosSub  
WHERE Lista = @Lista AND Moneda = @Moneda AND ISNULL(Precio, 0.0) > 0.0  
GROUP BY Articulo, SubCuenta  
ORDER BY Articulo, SubCuenta  
ELSE  
DECLARE crPCSugerir CURSOR FOR  
SELECT Articulo, CONVERT(varchar, NULL), CONVERT(varchar, NULL), MIN(Precio)  
FROM ListaPreciosD  
WHERE Lista = @Lista AND Moneda = @Moneda AND ISNULL(Precio, 0.0) > 0.0  
GROUP BY Articulo  
ORDER BY Articulo  
END  
OPEN crPCSugerir  
FETCH NEXT FROM crPCSugerir INTO @Articulo, @SubCuenta, @Unidad, @Precio  
WHILE @@FETCH_STATUS <> -1 AND @@Error = 0  
BEGIN  
IF @@FETCH_STATUS <> -2  
BEGIN  
SELECT @Renglon = @Renglon + 2048.0,  
@Nuevo = @Precio /* -1.0*/  
EXEC spPCGet @Sucursal, @Empresa, @Articulo, @SubCuenta, @Unidad, @Moneda, @TipoCambio, @Lista, @Anterior OUTPUT, 0  
IF @Nuevo <> @Anterior  
	--BEGIN  
	--IF @MovTipo = 'PC.C'  
INSERT PCD (ID, Renglon, Articulo, SubCuenta, Unidad, Nuevo, Anterior, Sucursal) VALUES (@ID, @Renglon, @Articulo, @SubCuenta, @Unidad, @Anterior, @Nuevo, @Sucursal)  
ELSE  
INSERT PCD (ID, Renglon, Articulo, SubCuenta, Unidad, Nuevo, Anterior, Sucursal) VALUES (@ID, @Renglon, @Articulo, @SubCuenta, @Unidad, @Nuevo, @Anterior, @Sucursal)  
--END  
FETCH NEXT FROM crPCSugerir INTO @Articulo, @SubCuenta, @Unidad, @Precio  
END  
END  
CLOSE crPCSugerir  
DEALLOCATE crPCSugerir  
RETURN  
END  
GO
/**************** xpOtrosCargos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOtrosCargos') and sysstat & 0xf = 4) drop procedure dbo.xpOtrosCargos
GO             
CREATE PROCEDURE xpOtrosCargos
      			@Empresa	char(5), 
			@ID		int, 
			@Cliente	char(10), 
			@MovMoneda	char(10), 
			@MovTipoCambio	float, 
			@Ok 		int		OUTPUT, 
			@OkRef 		varchar(255)	OUTPUT
AS BEGIN
  DECLARE
    @OtrosCargos	varchar(50),
    @Articulo		char(20),
    @Tipo		varchar(20),
    @Porcentaje		float,
    @Importe		money,
    @Moneda		char(10),
    @Renglon		float,
    @RenglonID		int,
    @RenglonTipo	char(1),
    @ArtTipo		char(20),
    @ArtImpuesto1	float,
    @ArtImpuesto2	float,
    @ArtImpuesto3	money,
    @ArtUnidad		varchar(50),
    @Almacen		char(10),
    @DescuentoGlobal	float,
    @DescuentoLinea	float,
    @Precio		money

  SELECT @DescuentoLinea = NULL, @Precio = NULL
  SELECT @OtrosCargos = NULLIF(RTRIM(OtrosCargos), '') FROM Cte WHERE Cliente = @Cliente
  IF @OtrosCargos IS NOT NULL
  BEGIN
    SELECT @Articulo     = o.Articulo,
           @Tipo         = UPPER(o.Tipo),
           @Porcentaje   = o.Porcentaje,
           @Importe      = o.Importe,
           @Moneda       = o.Moneda,
           @ArtTipo      = a.Tipo,
           @ArtImpuesto1 = a.Impuesto1,
           @ArtImpuesto2 = a.Impuesto2,
           @ArtImpuesto3 = a.Impuesto3,
           @ArtUnidad    = a.Unidad
      FROM OtrosCargos o, Art a
     WHERE o.OtrosCargos = @OtrosCargos AND a.Articulo = o.Articulo

    IF @Articulo IS NOT NULL AND NOT EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND Articulo = @Articulo)
    BEGIN
      SELECT @RenglonID = ISNULL(RenglonID, 0), 
             @Almacen = Almacen,
             @DescuentoGlobal = ISNULL(DescuentoGlobal, 0) 
        FROM Venta WHERE ID = @ID
      SELECT @Renglon = ISNULL(MAX(Renglon), 0) FROM VentaD WHERE ID = @ID
   
      EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
      SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1

      IF @Tipo = 'IMPORTE FIJO'
      BEGIN
        IF @Moneda = @MovMoneda 
          SELECT @Precio = @Importe
        ELSE 
          SELECT @Precio = (@Importe * TipoCambio) / @MovTipoCambio FROM Mon WHERE Moneda = @Moneda
      END ELSE
      IF @Tipo = '% SUBTOTAL'
        SELECT @Precio = SUM(SubTotal) * (@Porcentaje / 100) FROM VentaTCalc WHERE ID = @ID

      IF @DescuentoGlobal <> 0 SELECT @DescuentoLinea = (@DescuentoGlobal / (100-@DescuentoGlobal))*-100

      INSERT VentaD (ID,  Renglon,  RenglonSub, RenglonID,  RenglonTipo,  Impuesto1,     Impuesto2,     Impuesto3,     Almacen,  Articulo,  Cantidad, Unidad,     CantidadInventario, Precio,  DescuentoLinea)
             VALUES (@ID, @Renglon, 0,          @RenglonID, @RenglonTipo, @ArtImpuesto1, @ArtImpuesto2, @ArtImpuesto3, @Almacen, @Articulo, 1.0,      @ArtUnidad, 1.0,                @Precio, @DescuentoLinea)
    END
  END
  RETURN
END
GO

-- xpLiberarCobranza 'DEMO', 'DEMO', '8/5/2002'
/**************** xpLiberarCobranza ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpLiberarCobranza') and type = 'P') drop procedure dbo.xpLiberarCobranza
GO             
CREATE PROCEDURE xpLiberarCobranza
			@Empresa	char(5),
			@Usuario	char(10),
			@Fecha		datetime
AS BEGIN
  DECLARE
    @Ok			int,
    @OkRef		varchar(255),
    @Contador		int,
    @Mensaje		varchar(255),
    @ID			int,
    @Mov		char(20),
    @MovID		varchar(20),
    @Situacion		varchar(50),
    @NuevaSituacion	varchar(50),
    @PersonalCobrador	char(10),
    @CambiarCobrador    bit,
    @Semanas		int,

    @MovCxc		char(20),
    @Blanco		varchar(50),
    @Azul		varchar(50),
    @Verde		varchar(50),
    @Gris		varchar(50),
    @Roja		varchar(50),
    @Gris2		varchar(50),
    @Roja2		varchar(50),
    @Verde2		varchar(50)

  SELECT @MovCxc		= 'Documento',
    	 @Blanco		= 'Blanco',	
    	 @Azul			= 'Azul',
    	 @Verde			= 'Verde',
    	 @Gris			= 'Gris',
    	 @Roja			= 'Roja',
    	 @Gris2			= 'Gris 2',
    	 @Roja2			= 'Roja 2',
    	 @Verde2		= 'Verde 2'

  SELECT @Ok = NULL, @OkRef = NULL, @Contador = 0

  BEGIN TRANSACTION
    DECLARE crLiberarCxc CURSOR LOCAL FOR 
     SELECT ID, Mov, MovID, NULLIF(RTRIM(Situacion), ''), NULLIF(RTRIM(PersonalCobrador), ''), DATEDIFF(day, Vencimiento, @Fecha) / 7
       FROM Cxc
      WHERE Empresa = @Empresa AND Estatus = 'PENDIENTE' AND DATEDIFF(day, Vencimiento, @Fecha) >= 0
        AND Mov = @MovCxc
        AND NULLIF(RTRIM(PersonalCobrador), '') IS NOT NULL

    OPEN crLiberarCxc
    FETCH NEXT FROM crLiberarCxc INTO @ID, @Mov, @MovID, @Situacion, @PersonalCobrador, @Semanas
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        SELECT @CambiarCobrador = 0
        IF @Situacion IN (NULL, @Blanco) EXEC spEmbarqueManual @Empresa, 'CXC', @ID, @Mov, @MovID, 'PENDIENTE', 0, 1

        IF @Semanas BETWEEN 0  AND 1  SELECT @NuevaSituacion = @Azul 			    ELSE 
        IF @Semanas BETWEEN 2  AND 3  SELECT @NuevaSituacion = @Verde 			    ELSE 
        IF @Semanas BETWEEN 4  AND 5  SELECT @NuevaSituacion = @Gris,  @CambiarCobrador = 1 ELSE 
        IF @Semanas BETWEEN 6  AND 7  SELECT @NuevaSituacion = @Roja,  @CambiarCobrador = 1 ELSE 
        IF @Semanas BETWEEN 8  AND 9  SELECT @NuevaSituacion = @Gris2, @CambiarCobrador = 1 ELSE 
        IF @Semanas BETWEEN 10 AND 10 SELECT @NuevaSituacion = @Roja2 			    ELSE
        IF @Semanas >= 11             SELECT @NuevaSituacion = @Verde2, @CambiarCobrador = 1

        IF @Situacion <> @NuevaSituacion
        BEGIN
          IF @CambiarCobrador = 1
            SELECT @PersonalCobrador = NULLIF(RTRIM(ReportaA), '') FROM Personal WHERE Personal = @PersonalCobrador

          IF (SELECT Sincro FROM Version) = 1
          EXEC sp_executesql N'UPDATE Cxc SET Situacion = @NuevaSituacion, PersonalCobrador = @PersonalCobrador, SincroC = SincroC WHERE ID = @ID',
                             N'@NuevaSituacion varchar(50), @PersonalCobrador char(10), @ID int', 
                             @NuevaSituacion = @NuevaSituacion, @PersonalCobrador = @PersonalCobrador, @ID = @ID
          SELECT @Contador = @Contador + 1
        END      
      END
      FETCH NEXT FROM crLiberarCxc INTO @ID, @Mov, @MovID, @Situacion, @PersonalCobrador, @Semanas
    END 
    CLOSE crLiberarCxc
    DEALLOCATE crLiberarCxc

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = CONVERT(varchar, @Contador)+' Cambios Realizados.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** xpGenerarComisionesCobranzaNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarComisionesCobranzaNomina') and type = 'P') drop procedure dbo.xpGenerarComisionesCobranzaNomina
GO             
CREATE PROCEDURE xpGenerarComisionesCobranzaNomina
			@Empresa	char(5),
			@Usuario	char(10),
			@Sucursal	int,
			@FechaEmision	datetime,
			@Mov		char(20),
			@Concepto	varchar(50),
			@Moneda		char(10),
			@EsBono		bit,
			@MovID		varchar(20)	OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  DECLARE
    @NominaID		int, 
    @Renglon		float,
    @FechaRegistro	datetime,
    @TipoCambio		float,
    @Personal		char(10),
    @Importe		money

  SELECT @FechaRegistro = GETDATE()
  SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

  INSERT INTO Nomina (Sucursal,  Empresa,  Mov,  FechaEmision,  Concepto,  Moneda,  TipoCambio,  Usuario,  Estatus)
              VALUES (@Sucursal, @Empresa, @Mov, @FechaEmision, @Concepto, @Moneda, @TipoCambio, @Usuario, 'SINAFECTAR')
  SELECT @NominaID = SCOPE_IDENTITY()
  DECLARE crNominaD CURSOR FOR
   SELECT Personal, NULLIF(SUM(CASE WHEN @EsBono = 1 THEN Bono ELSE Comision END), 0.0)
     FROM #Comision
    GROUP BY Personal
    ORDER BY Personal
  SELECT @Renglon = 0.0
  OPEN crNominaD
  FETCH NEXT FROM crNominaD INTO @Personal, @Importe
  WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
  BEGIN
    IF @@FETCH_STATUS <> -2 AND @Ok IS NULL AND @Importe IS NOT NULL
    BEGIN
      SELECT @Renglon = @Renglon + 2048
      INSERT NominaD (Sucursal,  ID,        Renglon,  Personal, Importe) 
              VALUES (@Sucursal, @NominaID, @Renglon, @Personal, @Importe)
    END 
    FETCH NEXT FROM crNominaD INTO @Personal, @Importe
  END  -- While
  CLOSE crNominaD
  DEALLOCATE crNominaD

  IF EXISTS(SELECT * FROM NominaD WHERE ID = @NominaID)
    EXEC spNomina @NominaID, 'NOM', 'AFECTAR', 'TODO', @FechaRegistro, NULL, @Usuario, 1, 0,
                  @Mov OUTPUT, @MovID OUTPUT, NULL, @Ok OUTPUT, @OkRef OUTPUT
  ELSE
    DELETE Nomina WHERE ID = @NominaID

  RETURN
END
GO
			
-- update EmpresaGral set UltimoCorteComisionesCobranza = NULL
-- xpGenerarComisionesCobranza 'DEMO', 'DEMO', '8/5/2002' ,0
/**************** xpGenerarComisionesCobranza ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarComisionesCobranza') and type = 'P') drop procedure dbo.xpGenerarComisionesCobranza
GO             
CREATE PROCEDURE xpGenerarComisionesCobranza
			@Empresa	char(5),
			@Usuario	char(10),
			@Fecha		datetime,
			@Sucursal	int
AS BEGIN
  DECLARE
    @Ok				int,
    @OkRef			varchar(255),
    @CorteAnterior		datetime,
    @Semanas			int,
    @Dias			int,
    @Mensaje			varchar(255),
    @Personal			char(10),
    @Cobrados			int,
    @NoCobrados			int,
    @Ventas			int,
    @Eficiencia			float,
    @Cobertura			float,
    @Desde			float,
    @Cantidad			float,
    @Puntos			float,
    @PuntosDia			float,
    @TablaComision		varchar(50),
    @TablaBono			varchar(50),
    @TablaVenta			varchar(50),
    @Comision			money,
    @Bono			money,
    @Importe			money,
    @TipoTabla			varchar(20),
    @TipoAgente			varchar(20),
    @Moneda			char(10),
    @ComisionMov		char(20),
    @ComisionMovID		varchar(20),
    @ComisionConcepto		varchar(50),
    @BonoMov			char(20),
    @BonoMovID			varchar(20),
    @BonoConcepto		varchar(50),
    @GrupoCobrador		varchar(50),
    @Desechos			varchar(50),
    @Devoluciones		varchar(50),
    @Violaciones		varchar(50),
    @Violaciones31a5		varchar(50),
    @ComisionAspirantes		money,
    @ComisionCambioDomicilio 	money,
    @SituacionCambioDomicilio	varchar(50),
    @SituacionNormal		varchar(50)

  SELECT @Moneda		  = 'Pesos',
	 @GrupoCobrador           = 'Cobradores',
	 @ComisionMov		  = 'Comisiones',
	 @ComisionConcepto	  = NULL,
	 @BonoMov	  	  = 'Bonos',
         @BonoConcepto		  = NULL,
         @Desechos		  = 'Desechos',
	 @Devoluciones		  = 'Devoluciones',
	 @Violaciones		  = 'Violaciones',
	 @Violaciones31a5	  = 'Violaciones 3.1 a 5',
         @ComisionAspirantes	  = 100.0,
         @ComisionCambioDomicilio = 50.0,
	 @SituacionCambioDomicilio= 'Cambio Domicilio',
         @SituacionNormal         = NULL

  SELECT @Ok = NULL, @OkRef = NULL, @ComisionMovID = NULL, @BonoMovID = NULL

  SELECT @CorteAnterior = ISNULL(UltimoCorteComisionesCobranza, 0)
    FROM EmpresaGral
   WHERE Empresa = @Empresa

  SELECT @Semanas = DATEDIFF(week, @CorteAnterior, @Fecha),
         @Dias    = DATEDIFF(day, @CorteAnterior, @Fecha)

  CREATE TABLE #OC (
        	Personal 	char(10) 	COLLATE Database_Default NULL, 
		Cobrados	int		NULL,
		NoCobrados	int		NULL,
		Directo		bit		NULL)

  CREATE TABLE #Venta (
        	Personal 	char(10) 	COLLATE Database_Default NULL, 
		TipoAgente	varchar(20)	COLLATE Database_Default NULL,
		TablaComision	varchar(50)	COLLATE Database_Default NULL,
		Ventas		int		NULL,
		Puntos		float		NULL,
		Cantidad	float		NULL)

  CREATE TABLE #Comision (
        	Personal 	char(10) 	COLLATE Database_Default NULL, 
		Comision	money		NULL,
		Bono		money		NULL)

  BEGIN TRANSACTION
    -- Agregar Cobranza
    INSERT #OC (Personal, Cobrados, Directo)
    SELECT e.PersonalCobrador, COUNT(*), 1
      FROM Embarque e, EmbarqueD d, EmbarqueEstado ee
     WHERE e.Estatus = 'CONCLUIDO' AND e.Empresa = @Empresa AND e.DiaRetorno > @CorteAnterior AND e.DiaRetorno <= @Fecha
       AND e.ID = d.ID AND d.Estado = ee.Estado
       AND NULLIF(RTRIM(e.PersonalCobrador), '') IS NOT NULL
       AND UPPER(ee.Tipo) = 'COBRADO'
     GROUP BY e.PersonalCobrador

    INSERT #OC (Personal, NoCobrados, Directo)
    SELECT e.PersonalCobrador, COUNT(*), 1
      FROM Embarque e, EmbarqueD d, EmbarqueEstado ee
     WHERE e.Estatus = 'CONCLUIDO' AND e.Empresa = @Empresa AND e.DiaRetorno > @CorteAnterior AND e.DiaRetorno <= @Fecha
       AND e.ID = d.ID AND d.Estado = ee.Estado
       AND NULLIF(RTRIM(e.PersonalCobrador), '') IS NOT NULL
       AND UPPER(ee.Tipo) <> 'COBRADO'
     GROUP BY e.PersonalCobrador

    -- Generar Cascada Cobranza
    DECLARE crCascada CURSOR FOR 
     SELECT oc.Personal, SUM(oc.Cobrados), SUM(oc.NoCobrados)
       FROM #OC oc, Personal p
      WHERE oc.Personal = p.Personal AND p.Grupo = @GrupoCobrador
      GROUP BY oc.Personal

    OPEN crCascada
    FETCH NEXT FROM crCascada INTO @Personal, @Cobrados, @NoCobrados
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        WHILE @Personal IS NOT NULL
        BEGIN
          SELECT @Personal = NULLIF(RTRIM(ReportaA), '') FROM Personal WHERE Personal = @Personal
          IF @Personal IS NOT NULL
            INSERT #OC (Personal, Cobrados, NoCobrados, Directo) VALUES (@Personal, @Cobrados, @NoCobrados, 0)
        END
      END
      FETCH NEXT FROM crCascada INTO @Personal, @Cobrados, @NoCobrados
    END 
    CLOSE crCascada
    DEALLOCATE crCascada

    -- Generar Comisiones Cobros Directos
    DECLARE crDirecto CURSOR FOR 
     SELECT oc.Personal, p.TablaCobranza, p.TablaCobranzaBono, SUM(oc.Cobrados), SUM(oc.NoCobrados)
       FROM #OC oc, Personal p
      WHERE oc.Personal = p.Personal AND oc.Directo = 1 
      GROUP BY oc.Personal, p.TablaCobranza, p.TablaCobranzaBono
    OPEN crDirecto
    FETCH NEXT FROM crDirecto INTO @Personal, @TablaComision, @TablaBono, @Cobrados, @NoCobrados
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Eficiencia = (CONVERT(float, @Cobrados) / CONVERT(float, @Cobrados + ISNULL(@NoCobrados, 0))) * 100

        SELECT @Comision = NULL, @Bono = NULL
        IF @TablaComision IS NOT NULL
          SELECT @Comision = @Cobrados * MIN(Importe)
            FROM TablaComisionEspD
           WHERE TablaComisionEsp = @TablaComision
             AND @Eficiencia > Desde AND @Eficiencia <= Hasta

        IF @TablaBono IS NOT NULL AND @Comision IS NOT NULL
          SELECT @Bono = @Comision * (MIN(Porcentaje)/100)
            FROM TablaComisionEspD
           WHERE TablaComisionEsp = @TablaBono
             AND @Eficiencia > Desde AND @Eficiencia <= Hasta

        IF @Comision IS NOT NULL 
          INSERT #Comision (Personal, Comision, Bono) VALUES (@Personal, @Comision, @Bono)

      END
      FETCH NEXT FROM crDirecto INTO @Personal, @TablaComision, @TablaBono, @Cobrados, @NoCobrados
    END 
    CLOSE crDirecto
    DEALLOCATE crDirecto

    -- Generar Comisiones Indirectas
    DECLARE crIndirecto CURSOR FOR 
     SELECT oc.Personal, p.TablaCobranzaCascada, UPPER(tcc.Tipo), p.TablaCobranzaBonoCascada, SUM(oc.Cobrados), (SUM(oc.Cobrados)/NULLIF((SUM(oc.Cobrados)+SUM(oc.NoCobrados)), 0))*100
       FROM #OC oc, Personal p, TablaComisionEsp tcc
      WHERE oc.Personal = p.Personal AND tcc.TablaComisionEsp = p.TablaCobranzaCascada AND oc.Directo = 0 
      GROUP BY oc.Personal, p.TablaCobranzaCascada, tcc.Tipo, p.TablaCobranzaBonoCascada
    OPEN crIndirecto
    FETCH NEXT FROM crIndirecto INTO @Personal, @TablaComision, @TipoTabla, @TablaBono, @Cobrados, @Eficiencia
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Comision = NULL, @Bono = NULL
        IF @TipoTabla = 'PREMIACION COBRANZA'
        BEGIN
          SELECT @Cobertura = @Eficiencia - ISNULL(SUM(CONVERT(float, Valor)), 0)
            FROM PersonalPropValor
           WHERE Rama = 'PER' AND Cuenta = @Personal AND Propiedad IN (@Desechos, @Devoluciones, @Violaciones, @Violaciones31a5)

          SELECT @Comision = CASE WHEN @Semanas = 3 THEN MIN(Importe2) ELSE MIN(Importe) END
            FROM TablaComisionEspD
           WHERE TablaComisionEsp = @TablaComision
             AND @Cobertura > Desde AND @Cobertura <= Hasta

          UPDATE PersonalPropValor
             SET Valor = NULL
           WHERE Rama = 'PER' AND Cuenta = @Personal AND Propiedad IN (@Desechos, @Devoluciones, @Violaciones, @Violaciones31a5)
        END ELSE
        BEGIN
          IF @TablaComision IS NOT NULL
            SELECT @Comision = @Cobrados * MIN(Importe)
              FROM TablaComisionEspD
             WHERE TablaComisionEsp = @TablaComision
               AND @Eficiencia > Desde AND @Eficiencia <= Hasta

          IF @TablaBono IS NOT NULL AND @Comision IS NOT NULL
            SELECT @Bono = @Comision * (MIN(Porcentaje)/100)
              FROM TablaComisionEspD
             WHERE TablaComisionEsp = @TablaBono
               AND @Eficiencia > Desde AND @Eficiencia <= Hasta
        END

        IF @Comision IS NOT NULL OR @Bono IS NOT NULL
          INSERT #Comision (Personal, Comision, Bono) VALUES (@Personal, @Comision, @Bono)

      END
      FETCH NEXT FROM crIndirecto INTO @Personal, @TablaComision, @TipoTabla, @TablaBono, @Cobrados, @Eficiencia
    END 
    CLOSE crIndirecto
    DEALLOCATE crIndirecto

    -- Agregar Ventas
    INSERT #Venta (Personal, TipoAgente, TablaComision, Cantidad, Puntos)
    SELECT Agente.Personal, Agente.Tipo, ag.TablaComision, SUM(d.Cantidad*CASE WHEN Alm.Segundas=1 THEN 3 ELSE 1 END), SUM(d.Cantidad*ag.Puntos*CASE WHEN Alm.Segundas=1 THEN 3 ELSE 1 END)
      FROM VentaD d, Venta v, MovTipo mt, Art a, ArtGrupo ag, Agente, Alm
     WHERE v.ID = d.ID AND d.Articulo = a.Articulo AND a.Grupo = ag.Grupo AND mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F' AND v.Agente = Agente.Agente
       AND v.FechaEmision > @CorteAnterior AND v.FechaEmision <= @Fecha       
       AND d.Almacen = alm.Almacen
     GROUP BY Agente.Personal, Agente.Tipo, ag.TablaComision

    -- Cantidad de Ventas 
    INSERT #Venta (Personal, TipoAgente, Ventas)
    SELECT Agente.Personal, Agente.Tipo, COUNT(*)
      FROM Venta v, MovTipo mt, Agente 
     WHERE mt.Modulo = 'VTAS' AND mt.Mov = v.Mov AND mt.Clave = 'VTAS.F' AND v.Agente = Agente.Agente AND UPPER(Agente.Tipo) = 'ASPIRANTE'
       AND v.FechaEmision > @CorteAnterior AND v.FechaEmision <= @Fecha       
     GROUP BY Agente.Personal, Agente.Tipo

    -- Generar Cascada Ventas
    DECLARE crCascada CURSOR FOR 
     SELECT v.Personal, SUM(v.Puntos)
       FROM #Venta v, Personal p
      WHERE v.Personal = p.Personal
      GROUP BY v.Personal

    OPEN crCascada
    FETCH NEXT FROM crCascada INTO @Personal, @Puntos
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN 
        WHILE @Personal IS NOT NULL
        BEGIN
          SELECT @Personal = NULLIF(RTRIM(ReportaA), '') FROM Personal WHERE Personal = @Personal
          IF @Personal IS NOT NULL
            INSERT #Venta (Personal, Puntos) VALUES (@Personal, @Puntos)
        END
      END
      FETCH NEXT FROM crCascada INTO @Personal, @Puntos
    END 
    CLOSE crCascada
    DEALLOCATE crCascada

    -- Generar Comisiones Ventas
    DECLARE crVenta CURSOR FOR 
     SELECT v.Personal, v.TipoAgente, v.TablaComision, p.TablaVentaCascada, SUM(v.Cantidad), SUM(v.Puntos), SUM(v.Ventas)
       FROM #Venta v, Personal p
      WHERE v.Personal = p.Personal
      GROUP BY v.Personal, v.TipoAgente, v.TablaComision, p.TablaVentaCascada
    OPEN crVenta
    FETCH NEXT FROM crVenta INTO @Personal, @TipoAgente, @TablaComision, @TablaVenta, @Cantidad, @Puntos, @Ventas
    WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Comision = NULL, @Bono = NULL,
               @PuntosDia = @Puntos / NULLIF(@Dias, 0)

        -- Ventas Directas 
        IF @TipoAgente IS NOT NULL
        BEGIN
          IF UPPER(@TipoAgente) = 'ASPIRANTE' 
            SELECT @Comision = @ComisionAspirantes * @Ventas
          ELSE
          SELECT @Comision = @Cantidad * MIN(Importe)
            FROM TablaComisionEspD
           WHERE TablaComisionEsp = @TablaComision
             AND @Cantidad > Desde AND @Cantidad <= Hasta
        END
        ELSE BEGIN
          SELECT @TipoTabla = UPPER(Tipo) FROM TablaComisionEsp WHERE TablaComisionEsp = @TablaVenta
          IF @TipoTabla = 'COMISION VENTA'
            SELECT @Comision = @Puntos * MIN(Importe)
              FROM TablaComisionEspD
             WHERE TablaComisionEsp = @TablaVenta
               AND @Puntos > Desde AND @Puntos <= Hasta

          IF @TipoTabla = 'BONO VENTA'
            SELECT @Bono = MIN(Importe)
              FROM TablaComisionEspD
             WHERE TablaComisionEsp = @TablaVenta
               AND @PuntosDia > Desde AND @PuntosDia <= Hasta

          IF @TipoTabla = 'BONO PROPORCIONAL'
          BEGIN
            SELECT @Importe = NULL, @Desde = NULL
            SELECT @Importe = MIN(Importe),
                   @Desde = MIN(Desde)
              FROM TablaComisionEspD
             WHERE TablaComisionEsp = @TablaVenta

            SELECT @Bono = (@Puntos * @Importe) / @Desde
          END
        END

        IF @Comision IS NOT NULL OR @Bono IS NOT NULL
          INSERT #Comision (Personal, Comision, Bono) VALUES (@Personal, @Comision, @Bono)

      END
      FETCH NEXT FROM crVenta INTO @Personal, @TipoAgente, @TablaComision, @TablaVenta, @Cantidad, @Puntos, @Ventas
    END 
    CLOSE crVenta
    DEALLOCATE crVenta

    -- Cambio de Domicilio
    INSERT #Comision (Personal, Comision) 
    SELECT PersonalCobrador, COUNT(*)*@ComisionCambioDomicilio
      FROM Cte
     WHERE Situacion = @SituacionCambioDomicilio
     GROUP BY PersonalCobrador

    UPDATE Cte
       SET Situacion = @SituacionNormal,
           SituacionFecha = GETDATE()
     WHERE Situacion = @SituacionCambioDomicilio

    -- Generar Comision
    EXEC xpGenerarComisionesCobranzaNomina @Empresa, @Usuario, @Sucursal, @Fecha, @ComisionMov, @ComisionConcepto, @Moneda, 0, @ComisionMovID OUTPUT, @Ok OUTPUT, @OkRef OUTPUT

    -- Generar Bono
    EXEC xpGenerarComisionesCobranzaNomina @Empresa, @Usuario, @Sucursal, @Fecha, @BonoMov,     @BonoConcepto,     @Moneda, 1, @BonoMovID     OUTPUT, @Ok OUTPUT, @OkRef OUTPUT
    
    IF @Ok IS NULL
     UPDATE EmpresaGral SET UltimoCorteComisionesCobranza = @Fecha WHERE Empresa = @Empresa

  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    IF @ComisionMovID IS NOT NULL
    BEGIN
      SELECT @Mensaje = 'Movimientos Generados: <BR>  '+@ComisionMov + ' ' + @ComisionMovID
      IF @BonoMovID IS NOT NULL
        SELECT @Mensaje = @Mensaje+ '<BR>  '+@BonoMov + ' ' + @BonoMovID
    END ELSE
      SELECT @Mensaje = 'Sin Cambios.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** xpVentaAutoProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaAutoProcesar') and sysstat & 0xf = 4) drop procedure dbo.xpVentaAutoProcesar
GO             
CREATE PROCEDURE xpVentaAutoProcesar
    		   @ID   	int
AS BEGIN
  RETURN
END
GO

/* xpImportarAutoVenta */
if exists (select * from sysobjects where id = object_id('dbo.xpImportarAutoVenta') and sysstat & 0xf = 4) drop procedure dbo.xpImportarAutoVenta
GO             
CREATE PROCEDURE xpImportarAutoVenta
			 @Estacion 	int,
			 @Empresa  	char(5),
			 @Usuario  	char(10),
			 @Sucursal 	int
AS BEGIN
  RETURN
END
GO


/**************** xpInvMatar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvMatar') and sysstat & 0xf = 4) drop procedure dbo.xpInvMatar
GO             
CREATE PROCEDURE xpInvMatar
		   @Accion	char(20),
    		   @ID   	int,
		   @MovTipo	char(20),
		   @Cantidad	float	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpMovGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovGenerar') and type = 'P') drop procedure dbo.xpMovGenerar
GO             
CREATE PROCEDURE xpMovGenerar
			@Sucursal	int,
		    	@Empresa	char(5), 
			@Modulo		char(5), 
			@ID		int,
			@Usuario	char(10), 
			@FechaEmision	datetime, 
			@Mov		char(20),
			@MovID 		varchar(20), 

			@GenerarDirecto	bit,
			@GenerarMov	char(20),
			@GenerarSerie	char(20),
			@GenerarMovID 	varchar(20), 
			@GenerarID	int,

			@Ok		int			OUTPUT,
			@OkRef		varchar(255)	= NULL 	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpInvUtilizarTodoDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvUtilizarTodoDetalle') and type = 'P') drop procedure dbo.xpInvUtilizarTodoDetalle
GO             
CREATE PROCEDURE xpInvUtilizarTodoDetalle
		   @Sucursal		int,
		   @Modulo		char(5),
		   @Base		char(20), 		-- IDENTICO
    		   @OID           	int,
                   @OrigenMov		char(20),
                   @OrigenMovID		varchar(20),
                   @OrigenMovTipo	char(20),
                   @DID			int,
		   @GenerarDirecto	bit,

		   @Ok			int	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpGastoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGastoVerificar') and type = 'P') drop procedure dbo.xpGastoVerificar
GO             
CREATE PROCEDURE xpGastoVerificar
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
		    @Estatus			char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpGastoAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGastoAfectar') and type = 'P') drop procedure dbo.xpGastoAfectar
GO             
CREATE PROCEDURE xpGastoAfectar
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
		    @Estatus			char(15),
		    @EstatusNuevo		char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpInvGenerarGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvGenerarGasto') and type = 'P') drop procedure dbo.xpInvGenerarGasto
GO
CREATE PROCEDURE xpInvGenerarGasto
		   @Sucursal		int,
		   @Accion		char(20),
    		   @Modulo	      	char(5),
                   @ID                  int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Empresa		char(5),
		   @Usuario		char(10),
		   @FechaRegistro	datetime,
		   @Cliente		char(10),

		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpPVSuntuario ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPVSuntuario') and type = 'P') drop procedure dbo.xpPVSuntuario
GO
CREATE PROCEDURE xpPVSuntuario
			@Cliente		char(10),
			@Articulo		char(20),
			@Precio			money,
			@PrecioConDescuentos	money,	
			@PrecioNeto		money
AS BEGIN
/*
Precio 			= VentaD.Precio
PrecioConDescuentos	= Precio - Descuento Linea - Descuento Global
PrecioNeto		= Precio sin Impuestos
*/

  DECLARE
    @Suntuario		float,
    @RFC		varchar(20),
    @Grupo		varchar(50)

  SELECT @Suntuario = NULL
  /*IF (SELECT NULLIF(RTRIM(RFC), '') FROM Cte WHERE Cliente = @Cliente) IS NULL
  BEGIN
    SELECT @Grupo = UPPER(NULLIF(RTRIM(Grupo), '')) FROM Art WHERE Articulo = @Articulo
    IF @Grupo = 'SUNT TODOS' OR (@Grupo = 'SUNT MY PRECIO' AND @PrecioConDescuentos > 5750) SELECT @Suntuario = 5.0
  END*/

  SELECT "Suntuario" = @Suntuario
  RETURN
END
GO


/**************** xpSoporteVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSoporteVerificar') and type = 'P') drop procedure dbo.xpSoporteVerificar
GO
CREATE PROCEDURE xpSoporteVerificar
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
		    @EstatusNuevo		char(15),

		    @RefInicial			char(20),
		    @RefInicialID		char(20),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN 
  RETURN
END
GO

/**************** xpSoporteAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSoporteAfectar') and type = 'P') drop procedure dbo.xpSoporteAfectar
GO             
CREATE PROCEDURE xpSoporteAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,
    		   @Ok               		int          OUTPUT,
    		   @OkRef            		varchar(255) OUTPUT
AS BEGIN 
  RETURN
END
GO


/************** xpArtUlt *************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtUlt') and sysstat & 0xf = 4) drop procedure dbo.xpArtUlt
GO
CREATE PROCEDURE xpArtUlt
			@Articulo	char(20),
			@Fecha		datetime,
		   	@Modulo		char(5),
			@MovTipo	varchar(20),
			@ID		int
AS BEGIN
  RETURN
END
GO

/* xpGenerarArchivo */
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarArchivo') and sysstat & 0xf = 4) drop procedure dbo.xpGenerarArchivo
GO             
CREATE PROCEDURE xpGenerarArchivo @Estacion 	int,
			          @Empresa 	char(5)  = NULL,
				  @Sucursal	int	 = NULL,
				  @Usuario 	char(10) = NULL
AS BEGIN
  SELECT 'Este es un Ejemplo'
  RETURN
END
GO


/************** xpValidarFormaPago *************/
if exists (select * from sysobjects where id = object_id('dbo.xpValidarFormaPago') and sysstat & 0xf = 4) drop procedure dbo.xpValidarFormaPago
GO
CREATE PROCEDURE xpValidarFormaPago
			@FormaPago	varchar(50), 
			@Referencia	varchar(50),
			@Importe	money, 
			@Ok 		int	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpMovEstatus *************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovEstatus') and type = 'P') drop procedure dbo.xpMovEstatus
GO
CREATE PROCEDURE xpMovEstatus
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpMovFinal *************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovFinal') and type = 'P') drop procedure dbo.xpMovFinal
GO
CREATE PROCEDURE xpMovFinal
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @IDGenerar		int,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpInterfacesMovFinal *************/
if exists (select * from sysobjects where id = object_id('dbo.xpInterfacesMovFinal') and type = 'P') drop procedure dbo.xpInterfacesMovFinal
GO
CREATE PROCEDURE xpInterfacesMovFinal
           @Empresa         char(5),
           @Sucursal        int,
           @Modulo          char(5), 
           @ID              int, 			
           @Estatus         char(15), 
           @EstatusNuevo    char(15),
           @Usuario         char(10),
           @FechaEmision    datetime, 	
           @FechaRegistro   datetime,
           @Mov             char(20),
           @MovID           varchar(20),
           @MovTipo         char(20),
           @IDGenerar       int,
           @Ok              int		OUTPUT,
           @OkRef           varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpOperacionRelevante *************/
if exists (select * from sysobjects where id = object_id('dbo.xpOperacionRelevante') and type = 'P') drop procedure dbo.xpOperacionRelevante
GO
CREATE PROCEDURE xpOperacionRelevante
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpAntesAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAntesAfectar') and type = 'P') drop procedure dbo.xpAntesAfectar
GO
CREATE PROCEDURE xpAntesAfectar
		   @Modulo		char(5),
                   @ID                  int,
                   @Accion		char(20),
		   @Base		char(20),
                   @GenerarMov		char(20),
		   @Usuario		char(10),
		   @SincroFinal		bit,
                   @EnSilencio	        bit,
    		   @Ok               	int 		OUTPUT,
    		   @OkRef            	varchar(255) 	OUTPUT,
		   @FechaRegistro	datetime
AS BEGIN
  RETURN
END
GO

/**************** xpInterfacesAntesAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInterfacesAntesAfectar') and type = 'P') drop procedure dbo.xpInterfacesAntesAfectar
GO
CREATE PROCEDURE xpInterfacesAntesAfectar
           @Modulo          char(5),
           @ID              int,
           @Accion          char(20),
           @Base            char(20),
           @GenerarMov      char(20),
           @Usuario         char(10),
           @SincroFinal     bit,
           @EnSilencio      bit,
           @Ok              int             OUTPUT,
           @OkRef           varchar(255)    OUTPUT,
           @FechaRegistro   datetime
AS BEGIN
  RETURN
END
GO
/**************** xpMovValidar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovValidar') and type = 'P') drop procedure dbo.xpMovValidar
GO
CREATE PROCEDURE xpMovValidar
		   @Modulo		char(5),
                   @ID                  int,
                   @Accion		char(20),
		   @Base		char(20),
                   @GenerarMov		char(20),
		   @Usuario		char(10),
		   @SincroFinal		bit,
                   @EnSilencio	        bit,
    		   @Ok               	int 		OUTPUT,
    		   @OkRef            	varchar(255) 	OUTPUT,
		   @FechaRegistro	datetime
AS BEGIN
  RETURN
END
GO


/**************** xpDespuesAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpDespuesAfectar') and type = 'P') drop procedure dbo.xpDespuesAfectar
GO
CREATE PROCEDURE xpDespuesAfectar
		   @Modulo		  char(5),
           @ID            int,
           @Accion		  char(20),
		   @Base		  char(20),
           @GenerarMov	  char(20),
		   @Usuario		  char(10),
		   @SincroFinal	  bit,
           @EnSilencio	  bit,
    	   @Ok            int 		   OUTPUT,
    	   @OkRef         varchar(255) OUTPUT,
		   @FechaRegistro datetime
AS BEGIN

 --REQ 14790
 --EXEC spCFDFlexGenerarPDFSinTransaccion @Modulo, @ID, @Accion, @Usuario, @Ok OUTPUT, @OkRef OUTPUT

 --REQ 15739
 DECLARE 
	@Empresa	varchar(10),
	@Mov		varchar(20),
	@DModulo	varchar(20), 
	@DMov		varchar(20),
	@DID		varchar(20),
	@Sucursal	int,
	@Estatus    varchar(20),
	@EstatusNuevo	varchar(20),
	@Clave      varchar(20),
	@Timbrado	bit,
	@Aplica		varchar(20), 
	@AplicaID	varchar(20),
	@MovAplica	varchar(20),
	@MovAplicaID varchar(20)

/*CFDI Cancelacion*/
	SELECT @Timbrado=Timbrado  FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID
	IF @Accion = 'CANCELAR' AND @Timbrado=1
	BEGIN	
	  EXEC spMovInfo @ID, @Modulo, @Estatus=@Estatus OUTPUT, @Sucursal=@Sucursal OUTPUT, @Empresa = @Empresa OUTPUT, @Mov = @Mov OUTPUT
	  IF @Estatus = 'CANCELADO' 
	  IF EXISTS(SELECT ModuloID FROM CFD WHERE Modulo = @Modulo AND ModuloID = @ID AND (UUID IS NOT NULL OR SelloSAT IS NOT NULL))
         AND (SELECT TimbrarCFDIServidor FROM EmpresaCFD WHERE Empresa = @Empresa) IN (SELECT * FROM dbo.fnIntelisisCFDIListaPAC(@Empresa))
         BEGIN
	         EXEC spCFDICancelacion @Modulo, @ID, @Estatus, @Empresa, @Sucursal, @Ok OUTPUT, @okref OUTPUT
	       
					 /***************************************************/
						 -- Las siguientes líneas de código, deberán ser habiitadas
						 -- en aquellos casos en los que se requiera concluir la
						 -- póliza de Conexión Contable aunque exista un error al
						 -- crear el documento de CFDI. Además se deberá utilizar
						 -- el objeto especial ErrorCFDFlex.esp
					 /*
					 IF(SELECT ContX FROM EmpresaGral WHERE Empresa = @Empresa) = 1 
					 AND (SELECT EnLinea FROM ContX WHERE Modulo = @Modulo AND Mov = @Mov) = 1 
					 AND @Ok IS NOT NULL
					 BEGIN
					   INSERT INTO ErrorCFDFlex VALUES (@Accion, @Modulo, @ID, @Ok, @OkRef)
						 SELECT @Ok = NULL
					 END
					 */
					 /***************************************************/
				 END

	END
 /*CFDI Cancelacion*/	
    EXEC spMovInfo    @ID, @Modulo , @Empresa = @Empresa OUTPUT, @Mov=@Mov OUTPUT

    IF(SELECT  CFDFlex  FROM  Movtipo WHERE Modulo=@Modulo AND Mov =@Mov)=1 AND (SELECT CFD FROM Empresa WHERE CFD =0 and Empresa= @Empresa)=0
	  IF EXISTS(SELECT * FROM CFDFlexTemp WHERE Estacion = @@SPID and Modulo =@Modulo and ID=@ID )  AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) 	  
		BEGIN
			EXEC  spCFDFlexGenerar @@SPID, @ID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT
		  
			/***************************************************/
				-- Las siguientes líneas de código, deberán ser habiitadas
				-- en aquellos casos en los que se requiera concluir la
				-- póliza de Conexión Contable aunque exista un error al
				-- crear el documento de CFDI. Además se deberá utilizar
				-- el objeto especial ErrorCFDFlex.esp
			/*
		  IF(SELECT ContX FROM EmpresaGral WHERE Empresa = @Empresa) = 1 
		  AND (SELECT EnLinea FROM ContX WHERE Modulo = @Modulo AND Mov = @Mov) = 1 
		  AND @Ok IS NOT NULL
			BEGIN
				INSERT INTO ErrorCFDFlex VALUES (@Accion, @Modulo, @ID, @Ok, @OkRef)
				SELECT @Ok = NULL
      END
      */      
			/***************************************************/            
    END
			
	IF EXISTS (SELECT DID FROM MovFlujo where OModulo = @Modulo and OID = @ID and Empresa= @Empresa )
	AND (SELECT CFD FROM Empresa WHERE CFD =0 and Empresa= @Empresa) = 0
	AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000) 
	AND @Accion = 'AFECTAR'	  
	BEGIN	  
		DECLARE CFDFlexMovTipo CURSOR FOR SELECT DModulo,DMov,DID FROM MovFlujo where OModulo =@Modulo and OID =@ID and Empresa= @Empresa
		OPEN CFDFlexMovTipo  
		FETCH NEXT FROM CFDFlexMovTipo INTO @DModulo,@DMov,@DID
		WHILE @@fetch_status = 0 
		BEGIN	
			IF(SELECT  CFDFlex FROM MovTipo  WHERE Modulo =@DModulo AND Mov =@DMov)=1 
				EXEC  spCFDFlexGenerar @@SPID, @DID, @DModulo, @Ok OUTPUT, @OkRef OUTPUT 
			FETCH NEXT FROM CFDFlexMovTipo INTO @DModulo,@DMov,@DID  
		END 
		CLOSE CFDFlexMovTipo  
		DEALLOCATE CFDFlexMovTipo 
	END

	IF @Modulo = 'CXC'
	AND (SELECT CFD FROM Empresa WHERE CFD = 0 and Empresa = @Empresa) = 0
	AND (@Ok IS NULL OR @Ok BETWEEN 80030 AND 81000)
	AND @Accion = 'AFECTAR'
	BEGIN
		IF EXISTS (SELECT * FROM CxcD WHERE ID = @ID)
		BEGIN
			DECLARE CFDFlexAplica CURSOR FOR SELECT Aplica, AplicaID FROM CxcD WHERE ID = @ID
			OPEN CFDFlexAplica  
			FETCH NEXT FROM CFDFlexAplica INTO @Aplica, @AplicaID
			WHILE @@FETCH_STATUS = 0
			BEGIN	
				SELECT @DID = ID FROM Cxc WHERE Mov = @Aplica AND MovID = @AplicaID AND Empresa = @Empresa
				IF(SELECT CFDFlex FROM MovTipo WHERE Modulo = @Modulo AND Mov = @Aplica) = 1
				  EXEC spCFDFlexGenerar @@SPID, @DID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT 
				FETCH NEXT FROM CFDFlexAplica INTO @Aplica, @AplicaID
			END
			CLOSE CFDFlexAplica
			DEALLOCATE CFDFlexAplica
		END
		
		SELECT @MovAplica = MovAplica, @MovAplicaID = MovAplicaID FROM Cxc WHERE ID = @ID
		IF (ISNULL(@MovAplica,'') <> '') AND (ISNULL(@MovAplicaID,'') <> '')
			SELECT @DID = ID, @EstatusNuevo = Estatus FROM Cxc WHERE Mov = @MovAplica AND MovID = @MovAplicaID AND Empresa = @Empresa
			IF(SELECT CFDFlex FROM MovTipo WHERE Modulo = @Modulo AND Mov = @MovAplica) = 1
			BEGIN
				IF EXISTS(SELECT * FROM CFDFlexTemp WHERE ID = @DID AND Modulo = @Modulo)
				BEGIN
					SELECT @Estatus = Estatus FROM CFDFlexTemp WHERE ID = @DID AND Modulo = @Modulo
					DELETE CFDFlexTemp WHERE ID = @DID AND Modulo = @Modulo
					EXEC spInsertarCFDFlexTemp @@SPID, @Empresa, @Modulo, @DID, @EstatusNuevo, @Estatus, @MovAplica, @MovAplicaID, @Ok OUTPUT, @OkRef OUTPUT
					IF @Ok IS NULL
						EXEC spCFDFlexGenerar @@SPID, @DID, @Modulo, @Ok OUTPUT, @OkRef OUTPUT
				END
		    END
	END

 --REQ 17525
	DECLARE  @OrigenTipo varchar(10), @Estacion int
	
	SELECT @Estacion = EstacionTrabajo 
	  FROM Acceso
	 WHERE SPID = @@SPID

	SELECT @Clave = M.Clave
	   FROM Compra C
	   JOIN MovTipo M ON C.Mov = M.Mov AND M.modulo = @Modulo --AND M.Clave = 'COMS.F' --AND I.OrigenTipo = 'I:MES' AND I.Estatus = 'PENDIENTE'
	  WHERE C.ID = @ID
	
	SELECT @OrigenTipo = C.OrigenTipo
	   FROM MovFlujo F JOIN Compra C ON F.OID = C.ID
	  WHERE F.DID = @ID

	IF @Modulo = 'COMS' AND @Accion = 'AFECTAR' 
	  EXEC spInforReservarSolicitudInv @Modulo, @ID, @Accion, @Base, @GenerarMov, @Usuario, @SincroFinal, @EnSilencio, @Ok OUTPUT, @OkRef OUTPUT

  RETURN
END
GO

/**************** xpInterfacesDespuesAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInterfacesDespuesAfectar') and type = 'P') drop procedure dbo.xpInterfacesDespuesAfectar
GO
CREATE PROCEDURE xpInterfacesDespuesAfectar
		   @Modulo		  char(5),
           @ID            int,
           @Accion		  char(20),
		   @Base		  char(20),
           @GenerarMov	  char(20),
		   @Usuario		  char(10),
		   @SincroFinal	  bit,
           @EnSilencio	  bit,
    	   @Ok            int 		   OUTPUT,
    	   @OkRef         varchar(255) OUTPUT,
		   @FechaRegistro datetime
AS BEGIN
  RETURN
END
GO
/**************** xpRecorrerVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpRecorrerVencimiento') and type = 'P') drop procedure dbo.xpRecorrerVencimiento
GO             
CREATE PROCEDURE xpRecorrerVencimiento
                    @Vencimiento	datetime	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpGenerarAutoCorrida ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarAutoCorrida') and type = 'P') drop procedure dbo.xpGenerarAutoCorrida
GO
CREATE PROCEDURE xpGenerarAutoCorrida
                   	@ID			int,
			@Empresa		char(5),
			@Sucursal		int,
                        @Mov			char(20),
			@AutoCorrida		varchar(20),
			@AlmacenOperador	char(10),
			@FechaRequerida		datetime,
			@Espacio		varchar(10),
			@MovMoneda		char(10),
			@MovTipoCambio		float,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN		
END
GO


/**************** xpAutoMant ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAutoMant') and type = 'P') drop procedure dbo.xpAutoMant
GO
CREATE PROCEDURE xpAutoMant
                   	@ID			int,
			@Mov			char(20),
			@Almacen		char(10),
			@Usuario		char(10),
                        @Empresa		char(5),
			@FechaEmision		datetime,
			@FechaRegistro		datetime,
			@Espacio		char(10),
			@AutoKmsActuales	int,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN		
END
GO


/**************** xpSugerirGastoDiverso ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSugerirGastoDiverso') and type = 'P') drop procedure dbo.xpSugerirGastoDiverso
GO
CREATE PROCEDURE xpSugerirGastoDiverso
			@Empresa		char(5),
			@Modulo			char(10),
                   	@ID			int
AS BEGIN
  RETURN		
END
GO

/* xpImportarArchivo */
if exists (select * from sysobjects where id = object_id('dbo.xpImportarArchivo') and sysstat & 0xf = 4) drop procedure dbo.xpImportarArchivo
GO             
CREATE PROCEDURE xpImportarArchivo @Estacion 	int,
			           @Empresa 	char(5),
				   @Usuario 	char(10),
				   @Sucursal	int
AS BEGIN
  DECLARE
    @Datos	varchar(255),
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION
    DECLARE crLista CURSOR 
        FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Datos
    WHILE @@FETCH_STATUS <> -1 AND @Datos IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SET @Datos = @Datos
        /* Ejemplo 
        SELECT @Prefijo     = RTRIM(LTRIM(SUBSTRING(@Datos,  2,  8))),
               @Basico      = RTRIM(LTRIM(SUBSTRING(@Datos, 10,  8))),
               @Sufijo      = RTRIM(LTRIM(SUBSTRING(@Datos, 18,  6))),
               @Ordenado    = CONVERT(int, SUBSTRING(@Datos, 24, 7)),
               @Remisionado = CONVERT(int, SUBSTRING(@Datos, 31, 7)),
               @Aviso       = NULLIF(RTRIM(SUBSTRING(@Datos, 38,  2)), ''),
               @Costo       = CONVERT(int, SUBSTRING(@Datos, 46, 8))/100,
               @Descripcion = SUBSTRING(@Datos, 54,  9)*/
 
      END
      FETCH NEXT FROM crLista INTO @Datos
    END
    CLOSE crLista
    DEALLOCATE crLista
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END

  RETURN
END
GO


/* xpImportarXML */
if exists (select * from sysobjects where id = object_id('dbo.xpImportarXML') and sysstat & 0xf = 4) drop procedure dbo.xpImportarXML
GO             
CREATE PROCEDURE xpImportarXML @Empresa 	char(5),
			       @Usuario 	char(10),
			       @Sucursal	int,
			       @Fecha		datetime,
			       @XML		text
AS BEGIN
 -- El resultado de lo que se proceso se encuentra en la variable @XML 
 -- se deja a consideración del cliente el manejo de esa información obtenida 
 -- insertar en esta parte su código
SELECT 'Proceso Concluido'
  RETURN
END
GO



/* xpImportarGastoDProrrateo */
if exists (select * from sysobjects where id = object_id('dbo.xpImportarGastoDProrrateo') and sysstat & 0xf = 4) drop procedure dbo.xpImportarGastoDProrrateo
GO             
CREATE PROCEDURE xpImportarGastoDProrrateo @Estacion 	int,
			           	   @Empresa 	char(5),
				   	   @Usuario 	char(10),
				   	   @Sucursal	int,
			           	   @ID		int,
				   	   @Renglon	float,
				   	   @RenglonSub	int,
				   	   @Concepto	varchar(50)
AS BEGIN
  DECLARE
    @Datos	varchar(255),
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION
    DECLARE crLista CURSOR 
        FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Datos
    WHILE @@FETCH_STATUS <> -1 AND @Datos IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SET @Datos = @Datos
        /* Ejemplo 
        SELECT @Prefijo     = RTRIM(LTRIM(SUBSTRING(@Datos,  2,  8))),
               @Basico      = RTRIM(LTRIM(SUBSTRING(@Datos, 10,  8))),
               @Sufijo      = RTRIM(LTRIM(SUBSTRING(@Datos, 18,  6))),
               @Ordenado    = CONVERT(int, SUBSTRING(@Datos, 24, 7)),
               @Remisionado = CONVERT(int, SUBSTRING(@Datos, 31, 7)),
               @Aviso       = NULLIF(RTRIM(SUBSTRING(@Datos, 38,  2)), ''),
               @Costo       = CONVERT(int, SUBSTRING(@Datos, 46, 8))/100,
               @Descripcion = SUBSTRING(@Datos, 54,  9)*/
      END
      FETCH NEXT FROM crLista INTO @Datos
    END
    CLOSE crLista
    DEALLOCATE crLista
  IF @Ok IS NULL
    COMMIT TRANSACTION
  ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok
    RAISERROR (@Mensaje,16,-1) 
  END

  RETURN
END
GO


/**************** xpCambioPresentacionUnidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCambioPresentacionUnidad') and type = 'P') drop procedure dbo.xpCambioPresentacionUnidad
GO              
CREATE PROCEDURE xpCambioPresentacionUnidad
			@Articulo	char(20),
			@MovUnidad	varchar(50)	OUTPUT
AS BEGIN

  RETURN
END
GO


/**************** xpMovArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovArt') and type = 'P') drop procedure dbo.xpMovArt
GO              
CREATE PROCEDURE xpMovArt
			@Empresa	char(5),
			@Sucursal	int,
			@Usuario	char(10),
			@Fecha		datetime,
			@Articulo	char(20)
AS BEGIN
  DECLARE
    @Mov	char(20),
    @Almacen 	char(10),
    @ID		int,
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  EXEC spExtraerFecha @Fecha OUTPUT

  SELECT @Almacen = NULLIF(RTRIM(DefAlmacen), '') FROM Usuario WHERE Usuario = @Usuario
  IF @Almacen IS NULL SELECT @Ok = 10576, @OkRef = @Usuario

  IF @Ok IS NULL
  BEGIN
    INSERT Inv (Empresa,  Mov,                    Usuario,  FechaEmision, FechaRequerida, Estatus,     Almacen,  Sucursal,    Directo, Moneda,   TipoCambio,   Proyecto,      UEN)
         SELECT @Empresa, cm.InvSolicitud, @Usuario, @Fecha,       @Fecha,         'CONFIRMAR', @Almacen, al.Sucursal, 1,       m.Moneda, m.TipoCambio, u.DefProyecto, u.UEN
            FROM EmpresaCfgMov cm, EmpresaCfg c, Mon m, Alm al, Usuario u
           WHERE cm.Empresa = @Empresa AND c.Empresa = @Empresa AND m.Moneda = c.ContMoneda
             AND al.Almacen = @Almacen AND u.Usuario = @Usuario

    SELECT @ID = SCOPE_IDENTITY()
    IF @ID IS NOT NULL
      INSERT InvD (ID, Renglon, Articulo, Cantidad, Unidad, CantidadInventario, FechaRequerida, Almacen, Sucursal)
            SELECT @ID, 2048.0, @Articulo, 1, a.Unidad, 1, @Fecha, @Almacen, al.Sucursal 
              FROM Art a, Alm al
             WHERE a.Articulo = @Articulo AND al.Almacen = @Almacen               
  END
  IF @Ok IS NULL
    SELECT @Mensaje = 'Se Genero "'+ISNULL(RTRIM(Mov), '')+'" por Confirmar.' FROM Inv WHERE ID = @ID
  ELSE
    SELECT @Mensaje = Descripcion + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

/**************** xpVINNumeroEconomico ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVINNumeroEconomico') and type = 'P') drop procedure dbo.xpVINNumeroEconomico
GO              
CREATE PROCEDURE xpVINNumeroEconomico
			@VIN			varchar(20), 
			@TipoUnidad		varchar(20), 
			@Articulo		varchar(20), 
			@FechaEntrada		datetime, 
			@NumeroEconomico	varchar(20)	OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpVINFechaMRS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVINFechaMRS') and type = 'P') drop procedure dbo.xpVINFechaMRS
GO              
CREATE PROCEDURE xpVINFechaMRS
			@VIN			varchar(20), 
			@Mov			varchar(20), 
			@FechaEntrada		datetime, 
			@FechaRequerida		datetime, 
			@FechaMRS		datetime	OUTPUT, 
			@IntercambioDirecto	bit		OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO
  
/************** xpContAuto *************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAuto') and type = 'P') drop procedure dbo.xpContAuto
GO
CREATE PROCEDURE xpContAuto
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime,
		   @FechaRegistro 	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @ContMov		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,

		   @Referencia		varchar(50)	OUTPUT
AS BEGIN
  SELECT @Referencia = RTRIM(@Mov) + ' ' + RTRIM(@MovID)
  RETURN
END
GO

/************** xpEmbarqueManual *************/
if exists (select * from sysobjects where id = object_id('dbo.xpEmbarqueManual') and type = 'P') drop procedure dbo.xpEmbarqueManual
GO
CREATE PROCEDURE xpEmbarqueManual
    		   @Empresa		char(5),
                   @Modulo  		char(5),
                   @ID	    		int,
		   @Mov			char(20),
		   @MovID		varchar(20),
                   @Estatus		char(15),
		   @DesEmbarcar		bit,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpMovDPrecioImpuestos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovDPrecioImpuestos') and type = 'P') drop procedure dbo.xpMovDPrecioImpuestos
GO              
CREATE PROCEDURE xpMovDPrecioImpuestos
			@Empresa	char(5),
			@Modulo 	char(5),
			@ID 		int,
			@Mov		char(20),
			@MovID		varchar(20),
			@MovTipo	char(20),
			@Renglon	float,
			@RenglonSub	int,
			@RenglonID 	int,
			@ArtTipo	char(20),
			@Articulo	char(20),			
			@SubCuenta	varchar(50),
			@Almacen	char(10),
			@Cantidad	float,
			@Precio		float		OUTPUT,
			@Impuesto1	float 		OUTPUT,
			@Impuesto2	float 		OUTPUT,
			@Impuesto3	float 		OUTPUT,
			@Impuesto5	float 		OUTPUT,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpTareasPorOmision ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTareasPorOmision') and type = 'P') drop procedure dbo.xpTareasPorOmision
GO             
CREATE PROCEDURE xpTareasPorOmision
			@Modulo		char(5),
			@ID 		int,
			@Empresa	char(5)	 = NULL,
			@Mov		char(20) = NULL,
			@Usuario	char(10) = NULL

AS BEGIN
  RETURN
END
GO

/**************** xpCRVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCRVerificar') and type = 'P') drop procedure dbo.xpCRVerificar
GO
CREATE PROCEDURE xpCRVerificar
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

		    @Caja			char(10),
		    @Cajero			char(10),
		    @CajaFolio			int,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgMaxCRZ			int,
		    @CfgValidarCRCero		bit,
		    @CfgValidarCRZCero		bit,
                    @CfgValidarFolio		bit,
	
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpCRAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCRAfectar') and type = 'P') drop procedure dbo.xpCRAfectar
GO             
CREATE PROCEDURE xpCRAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

		   @UEN				int,
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Caja			char(10),
		   @Cajero			char(10),
		   @Concepto			varchar(50),
		   @Referencia			varchar(50),

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int,
    		   @GenerarMovID	  	varchar(20),

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpPCVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPCVerificar') and type = 'P') drop procedure dbo.xpPCVerificar
GO
CREATE PROCEDURE xpPCVerificar
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

		    @ListaModificar		varchar(20),
		    @Proveedor			varchar(10),
		    @FechaInicio		datetime,
		    @FechaTermino		datetime,
		    @Hoy			datetime,

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgListaModificarDetalle	bit,
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO



/**************** xpContVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContVerificar') and type = 'P') drop procedure dbo.xpContVerificar
GO
CREATE PROCEDURE xpContVerificar
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
                    @ContMoneda			char(10),
		    @Estatus			char(15),

		    @FechaContable		datetime,
		    @CfgVerificarIVA		bit,
		    @CfgCentrosCostos		bit,
                    @CfgToleraciaRedondeo	float,

		    @Ejercicio			int,
		    @Periodo			int,
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpNominaVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaVerificar') and type = 'P') drop procedure dbo.xpNominaVerificar
GO
CREATE PROCEDURE xpNominaVerificar
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
		    @Condicion			varchar(50),
		    @PeriodoTipo		varchar(50), 
		    @MovFechaD			datetime, 
		    @MovFechaA			datetime,
		    @FechaEmision		datetime,
		    @Estatus			char(15),
		    @UsaImporte			bit, 
		    @UsaCantidad		bit, 
		    @UsaPorcentaje		bit, 
		    @UsaMonto			bit,
                    @UsaFechas			bit,
                    @CfgValidarReferencias	bit, 
		    @MovIncapacidades		varchar(20), 

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpNominaAfectarDetalle ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaAfectarDetalle') and type = 'P') drop procedure dbo.xpNominaAfectarDetalle
GO             
CREATE PROCEDURE xpNominaAfectarDetalle
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20)	OUTPUT,
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
		   @Condicion			varchar(50),
		   @PeriodoTipo			varchar(50), 
		   @MovFechaD			datetime, 
		   @MovFechaA			datetime,
    		   @FechaEmision      		datetime,
		   @FechaOrigen			datetime,
    		   @FechaAfectacion      	datetime,
		   @FechaConclusion		datetime,
	
    		   @Usuario	      		char(10),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @Renglon			float, 
		   @Personal			char(10), 
		   @Importe			money, 
		   @Cantidad			float,

    		   @Ok               		int          OUTPUT,
    		   @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO



-- xpVerAgenteAgenda 'MECA01', '02/25/2004'
/**************** xpVerAgenteAgenda ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVerAgenteAgenda') and sysstat & 0xf = 4) drop procedure dbo.xpVerAgenteAgenda
GO             
CREATE PROCEDURE xpVerAgenteAgenda
		    	@Agente		char(10),
		    	@Fecha		datetime
AS BEGIN
  SELECT @Agente = NULLIF(NULLIF(NULLIF(RTRIM(@Agente), '0'), ''), 'NULL')
  IF @Agente IS NULL
    SELECT aa.Agente, aa.Hora, aa.Modulo, aa.ID, m.Mov, m.MovID 
      FROM AgenteAgenda aa, Mov m 
     WHERE aa.Fecha = @Fecha AND m.Modulo = aa.Modulo AND m.ID = aa.ID
  ELSE
  SELECT aa.Agente, aa.Hora, aa.Modulo, aa.ID, m.Mov, m.MovID 
    FROM AgenteAgenda aa, Mov m 
   WHERE aa.Agente = @Agente AND aa.Fecha = @Fecha AND m.Modulo = aa.Modulo AND m.ID = aa.ID
  UNION
  SELECT @Agente, Hora, NULL, NULL, NULL, NULL 
    FROM AgendaHora 
   WHERE Hora NOT IN (SELECT Hora FROM AgenteAgenda WHERE Agente = @Agente AND Fecha = @Fecha)
  RETURN
END
GO

/************** xpFechaAfectacion *************/
if exists (select * from sysobjects where id = object_id('dbo.xpFechaAfectacion') and type = 'P') drop procedure dbo.xpFechaAfectacion
GO
CREATE PROCEDURE xpFechaAfectacion
		   @Empresa		char(5),
		   @Modulo		char(10),
		   @ID			int,
		   @Accion 		char(20),
		   @FechaEmision	datetime,
		   @FechaNueva		datetime	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpRHVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpRHVerificar') and type = 'P') drop procedure dbo.xpRHVerificar
GO
CREATE PROCEDURE xpRHVerificar
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
		    @Evaluacion			varchar(50),

		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,

		    @CfgControlPlazas		varchar(20),
		    @CfgContX			bit,
		    @CfgContXGenerar		char(20),
		    @GenerarPoliza		bit,

    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpRHAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpRHAfectar') and type = 'P') drop procedure dbo.xpRHAfectar
GO             
CREATE PROCEDURE xpRHAfectar
    		   @ID                		int,

		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
		   @MovMoneda			char(10),
		   @MovTipoCambio		float,
    		   @FechaEmision      		datetime,
    		   @FechaAfectacion      	datetime,
    		   @FechaConclusion		datetime,

    	 	   @Proyecto	      		varchar(50),
                   @Concepto			varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),
    		   @Estatus           		char(15),
 	    	   @EstatusNuevo	      	char(15),
    		   @FechaRegistro     		datetime,
    		   @Ejercicio	      		int,
    		   @Periodo	      		int,

		   @Conexion			bit,
		   @SincroFinal			bit,
		   @Sucursal			int,
		   @SucursalDestino		int,
		   @SucursalOrigen		int,

		   @CfgControlPlazas		varchar(20),
		   @CfgContX			bit,
		   @CfgContXGenerar		char(20),
		   @GenerarPoliza		bit,

    		   @GenerarMov			char(20),
		   @IDGenerar			int,	
    		   @GenerarMovID	  	varchar(20),

       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpPlanBitacoraFin ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPlanBitacoraFin') and type = 'P') drop procedure dbo.xpPlanBitacoraFin
GO
CREATE PROCEDURE xpPlanBitacoraFin
			@ID			int
AS BEGIN
  RETURN
END
GO

/**************** xpVerSDI ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.xpVerSDI') and type = 'P') drop procedure dbo.xpVerSDI
GO             
CREATE PROCEDURE xpVerSDI
			@Empresa       	char(5),
			@Sucursal      	int,
			@Categoria     	varchar(50),
			@Personal      	char(10),
			@AnosCumplidos 	int,
			@SueldoDiario  	money,
			@TipoSueldo 	varchar(10),
			@EnSilencio	int 		= 0,
		    	@SDI     	money		= NULL	OUTPUT,
			@ZonaEconomica	varchar(50) 	= NULL

AS BEGIN
  RETURN
END
GO


/**************** xpVerNominaCalculoInverso ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVerNominaCalculoInverso') and type = 'P') drop procedure dbo.xpVerNominaCalculoInverso
GO             
CREATE PROCEDURE xpVerNominaCalculoInverso
		 	@Empresa	 	char(5),
                 	@SueldoDeseado         	money,
			@PeriodoTipo		char(20),
 		 	@AnosCumplidos	 	int,
			@Personal		char(10),
			@DiasPeriodo		int,
			@SueldoBruto		money	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpTransmitirCB ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTransmitirCB') and type = 'P') drop procedure dbo.xpTransmitirCB
GO             
CREATE PROCEDURE xpTransmitirCB
		 	@Codigo		varchar(50),
		 	@MovArticulo	varchar(20),
		 	@MovSubCuenta	varchar(50),
		 	@MovUnidad	varchar(50),
		 	@MovPendiente	float,
		 	@Cantidad	float,
			@Modulo		char(5)		= NULL,
			@ID		int		= NULL
AS BEGIN

  SELECT @Cantidad
  RETURN
END
GO


/**************** xpSugerirArtActividad ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSugerirArtActividad') and type = 'P') drop procedure dbo.xpSugerirArtActividad
GO
CREATE PROCEDURE xpSugerirArtActividad
                   	@Empresa	char(5),
			@Sucursal	int,
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@Articulo	char(20),
			@Cantidad	float = 1.0,
			@Agente		char(10) = NULL
AS BEGIN
  RETURN
END
GO



/**************** xpInvSugerirArtAlm ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvSugerirArtAlm') and type = 'P') drop procedure dbo.xpInvSugerirArtAlm
GO             
CREATE PROCEDURE xpInvSugerirArtAlm
			@ID		int,
			@Empresa	char(5),
			@Sucursal	int,
			@Almacen	char(10),
			@Referencia	varchar(50)
AS BEGIN
  DECLARE
    @TipoCosteo		varchar(50),
    @Articulo		char(20),
    @SubCuenta		varchar(50),
    @Renglon		float,
    @Unidad		varchar(50),
    @Cantidad		float,
    @CantidadInventario	float,
    @Factor		float,
    @Decimales		int,
    @Costo		money,
    @Moneda		char(10),
    @TipoCambio		float,
    @Proveedor		char(10),
    @RenglonID		int

  SELECT @TipoCosteo = ISNULL(NULLIF(RTRIM(UPPER(TipoCosteo)), ''), 'PROMEDIO')

    FROM EmpresaCfg
   WHERE Empresa = @Empresa  SELECT @Moneda = Moneda, @TipoCambio = TipoCambio FROM Inv WHERE ID = @ID
  DELETE InvD WHERE ID = @ID
  DELETE SerieLoteMov WHERE Empresa = @Empresa AND Modulo = 'INV' AND ID = @ID

  SELECT @Renglon = 0.0, @RenglonID = 0
  DECLARE crArtAlm CURSOR FOR 
   SELECT Articulo, SubCuenta 
     FROM ArtAlm 
    WHERE Empresa = @Empresa AND Almacen = @Almacen
  OPEN crArtAlm
  FETCH NEXT FROM crArtAlm INTO @Articulo, @SubCuenta
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      SELECT @Cantidad = NULL, @Costo = NULL
      SELECT @Unidad = Unidad, @Proveedor = Proveedor FROM Art WHERE Articulo = @Articulo
      /*EXEC xpUnidadFactor @Articulo, @SubCuenta, @Unidad, @Factor OUTPUT, @Decimales OUTPUT
      SELECT @CantidadInventario = SUM(Inventario) FROM ArtSubExistenciaInv WHERE Empresa = @Empresa AND Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND Almacen = @Almacen
      SELECT @Cantidad = @CantidadInventario / @Factor*/

      /*IF NULLIF(@Cantidad, 0.0) IS NOT NULL
      BEGIN
        EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, @SubCuenta, @Unidad, @TipoCosteo, @Moneda, @TipoCambio, @Costo OUTPUT, 0*/
        SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
        INSERT InvD (ID, Sucursal, Renglon, RenglonID, Articulo, SubCuenta, Cantidad, Unidad, CantidadInventario, Almacen, Costo) VALUES (@ID, @Sucursal, @Renglon, @RenglonID, @Articulo, NULLIF(@SubCuenta, ''), @Cantidad, @Unidad, @CantidadInventario, @Almacen, @Costo)
      /*END*/
    END
    FETCH NEXT FROM crArtAlm INTO @Articulo, @SubCuenta
  END
  CLOSE crArtAlm
  DEALLOCATE crArtAlm
  UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @ID --Bug 21407

  RETURN
END
GO


/**************** xpVINTransferirComponente ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVINTransferirComponente') and type = 'P') drop procedure dbo.xpVINTransferirComponente
GO
CREATE PROCEDURE xpVINTransferirComponente
			@VIN		char(20),
			@ID		int,
			@VINDestino	char(20),
			@Usuario	char(10),
			@Fecha		datetime
AS BEGIN
  DECLARE
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL

  BEGIN TRANSACTION

  IF @VIN = @VINDestino SELECT @Ok = 20036 ELSE
  IF NOT EXISTS(SELECT * FROM VIN WHERE VIN = @VINDestino) SELECT @Ok = 20035, @OkRef = @VINDestino

  IF @Ok IS NULL
  BEGIN
    INSERT VINAccesorio
           (VIN,        Tipo, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado, Estatus, Usuario, FechaAlta) 
    SELECT @VINDestino, Tipo, Accesorio, Descripcion, PrecioDistribuidor, PrecioPublico, PrecioContado, 'ALTA',  @Usuario, @Fecha
      FROM VINAccesorio
     WHERE VIN = @VIN AND ID = @ID
    UPDATE VINAccesorio SET Estatus = 'BAJA', VINDestino = @VINDestino WHERE VIN = @VIN AND ID = @ID
  END
  IF @Ok IS NULL 
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Transferencia Completada.'
  END ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = 'ERROR - '+Descripcion FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** xpVentaVINAsignar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaVINAsignar') and type = 'P') drop procedure dbo.xpVentaVINAsignar
GO
CREATE PROCEDURE xpVentaVINAsignar
			@ID		int,
			@Renglon	float,
			@RenglonSub	int,
			@VIN		char(20)
AS BEGIN
  RETURN
END
GO


/**************** xpInvSucursalDestino ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvSucursalDestino') and type = 'P') drop procedure dbo.xpInvSucursalDestino
GO
CREATE PROCEDURE xpInvSucursalDestino
			@Accion			varchar(20),
			@Empresa		char(5),
			@ID			int,
			@MovTipo		varchar(20),
			@Almacen		char(10),
			@AlmacenDestino		char(10),
			@SucursalDestino	int		OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO



/**************** xpFacturacionRapida ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpFacturacionRapida') and type = 'P') drop procedure dbo.xpFacturacionRapida
GO             
CREATE PROCEDURE xpFacturacionRapida
			@ID				int,
			@Usuario			char(10),
			@Empresa			char(5),
			@FacturacionRapidaAgrupada 	bit,
			@Base				char(20)	OUTPUT,
			@Ok				int		OUTPUT,
			@OkRef				varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

-- EXEC xpAccesoInterface 'DEMO', 0, 'DEMO', 1, 'HAND PUNCH', '1234,31,12,3,15,6'
/**************** xpAccesoInterface ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAccesoInterface') and type = 'P') drop procedure dbo.xpAccesoInterface
GO             
CREATE PROCEDURE xpAccesoInterface
			@Empresa       	char(5),
			@Sucursal      	int,
			@Usuario	char(10),
			@Estacion 	int,
			@Hardware	varchar(50),
			@Datos		varchar(255) = NULL
AS BEGIN
  DECLARE
    @Personal		varchar(10),
    @FechaHora		datetime,
    @Dia		int,
    @Mes		int,
    @Ano		int,
    @Hora		int,
    @Minuto		int

  SELECT @Hardware = UPPER(@Hardware)
  SELECT @Personal = NULL, @FechaHora = NULL

  IF @Datos IS NOT NULL
  BEGIN
    IF @Hardware = 'HAND PUNCH'
    BEGIN
      EXEC spExtraerDato   @Datos OUTPUT, @Personal OUTPUT, ','   
      EXEC spExtraerNumero @Datos OUTPUT, @Dia 	    OUTPUT, ','   
      EXEC spExtraerNumero @Datos OUTPUT, @Mes 	    OUTPUT, ','   
      EXEC spExtraerNumero @Datos OUTPUT, @Ano 	    OUTPUT, ',' IF @Ano < 100 SELECT @Ano = @Ano + 2000
      EXEC spExtraerNumero @Datos OUTPUT, @Hora     OUTPUT, ','   
      EXEC spExtraerNumero @Datos OUTPUT, @Minuto   OUTPUT, ','
     
      EXEC spISO8601ToDateTime @Ano, @Mes, @Dia, @Hora, @Minuto, 0, 0, @FechaHora OUTPUT
    END
  END /*ELSE
  BEGIN
  BEGIN TRANSACTION
    DECLARE crLista CURSOR 
        FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Datos
    WHILE @@FETCH_STATUS <> -1 AND @Datos IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
	.. Aqui va el codigo

      END
      FETCH NEXT FROM crLista INTO @Datos
    END
    CLOSE crLista
    DEALLOCATE crLista
  END*/

  SELECT @Personal, @FechaHora
  RETURN
END
GO

/**************** xpValidarPrecios ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpValidarPrecios') and type = 'P') drop procedure dbo.xpValidarPrecios
GO             
CREATE PROCEDURE xpValidarPrecios
			@Empresa		char(5), 
			@Modulo			char(5), 
			@ID			int, 
			@Accion			char(20), 
			@Articulo		char(20), 
			@SubCuenta		varchar(50), 
			@CfgValidarPrecios	varchar(20), 
			@Ok 			int		OUTPUT, 
			@OkRef 			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpMovCopiarEncabezado ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovCopiarEncabezado') and type = 'P') drop procedure dbo.xpMovCopiarEncabezado
GO             
CREATE PROCEDURE xpMovCopiarEncabezado
			@Sucursal		int,
			@Modulo			char(5), 
			@ID				int,
		    @Empresa		char(5), 
			@Mov			char(20),
			@MovID 			varchar(20),
			@Usuario		char(10), 
			@FechaEmision	datetime, 
			@Estatus		char(15),
			@Moneda			char(10),
			@TipoCambio		float,
			@Almacen		char(10),
		    @AlmacenDestino char(10),
			@GenerarDirecto	bit,
			@GenerarMov		char(20),
			@GenerarMovID 	varchar(20), 
			@GenerarID		int,
			@Ok				int	OUTPUT,
			@CopiarBitacora	bit
AS BEGIN
  RETURN
END
GO

/**************** xpCambioPresentacionGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCambioPresentacionGenerar') and type = 'P') drop procedure dbo.xpCambioPresentacionGenerar
GO             
CREATE PROCEDURE xpCambioPresentacionGenerar
                        @Empresa               char(5),
                        @Almacen               char(10),
                        @Articulo              char(20),
                        @NuevaPresentacion     char(20),
                        @Cantidad              float,
                        @Unidad                varchar(50),
                        @Modulo                char(5),
                        @ID                    int

AS BEGIN
  RETURN
END
GO

/**************** xpValidacionMorosos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpValidacionMorosos') and type = 'P') drop procedure dbo.xpValidacionMorosos
GO             
CREATE PROCEDURE xpValidacionMorosos
                        @Empresa                char(5),
		        @Accion		        char(20),
                        @Modulo                 char(5),
                        @ID                     int,
                        @MovTipo                varchar(20),
                        @ServicioGarantia       bit,
                        @Ok                     int        OUTPUT

AS BEGIN
  /* Esta rutina se ejecuta cuando falla por morosidad y siver para condicionar el error */

  IF @MovTipo IN ('VTAS.C', 'VTAS.CS', 'VTAS.SG', 'VTAS.EG') OR (@MovTipo = 'VTAS.S' AND @ServicioGarantia = 1)
    SELECT @Ok = NULL
  RETURN
END
GO

/**************** xpCompraAutoEndoso ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCompraAutoEndoso') and type = 'P') drop procedure dbo.xpCompraAutoEndoso
GO             
CREATE PROCEDURE xpCompraAutoEndoso 
                        @Empresa                char(5),
		        @Accion		        char(20),
                        @Modulo                 char(5),
                        @ID                     int,
		        @Mov		        char(20),
		        @MovID		        varchar(20),
                        @MovTipo                varchar(20),
                        @Endoso			char(10)	OUTPUT,
                        @Ok                     int        	OUTPUT,
                        @OkRef                  varchar(255)   	OUTPUT

AS BEGIN
  /* Esta rutina sirve para cambiar el Endoso en Commpras cuando maneja la opcion de CompraAutoEndoso */

  RETURN
END
GO

/**************** xpArtCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtCosto') and type = 'P') drop procedure dbo.xpArtCosto
GO             
CREATE PROCEDURE xpArtCosto
                        @Empresa                char(5),
			@Sucursal		int,
		        @Accion		        char(20),
                        @Modulo                 char(5),
                        @ID                     int,
			@RenglonID		int,
			@Articulo		char(20),
			@SubCuenta		varchar(50),
			@CostoEstandar		float		OUTPUT,
			@CostoReposicion 	float		OUTPUT, 
			@CostoPromedio		float		OUTPUT,
			@UltimoCosto 		float		OUTPUT, 
			@UltimoCostoSinGastos 	float		OUTPUT, 
			@Ok 			int		OUTPUT
AS BEGIN
  /* Esta rutina sirve para cambiar el Costo a gravar en la transaccion */

  RETURN
END
GO

/**************** xpFacturarVINNuevoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpFacturarVINNuevoVerificar') and sysstat & 0xf = 4) drop procedure dbo.xpFacturarVINNuevoVerificar
GO             
CREATE PROCEDURE xpFacturarVINNuevoVerificar
    		   @ID                		int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
		   @VIN				char(20),
		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpACDevengarInteresesMoratorios ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACDevengarInteresesMoratorios') and type = 'P') drop procedure dbo.xpACDevengarInteresesMoratorios
GO
CREATE PROCEDURE xpACDevengarInteresesMoratorios
		   @Modulo	char(5),
		   @ID		int,
		   @Moratorios	money		OUTPUT,
		   @Ok		int		OUTPUT,
		   @OkRef	varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpInvLimiteRenFacturas ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvLimiteRenFacturas') and type = 'P') drop procedure dbo.xpInvLimiteRenFacturas
GO             
CREATE PROCEDURE xpInvLimiteRenFacturas
			@Modulo		char(5),
			@ID		int,
			@Limite		int	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_14050 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_14050') and type = 'P') drop procedure dbo.xpOk_14050
GO
CREATE PROCEDURE xpOk_14050
  @Empresa	char(5),
  @Usuario	char(10),
  @Accion		char(20),
  @Modulo		char(5),
  @MovTipo    char(20),
  @Mov	  	char(20),
  @Estatus	char(15),
  @Actividad	varchar(50),
  @Ok         int				OUTPUT,
  @OkRef      varchar(255)	OUTPUT

AS BEGIN

  RETURN
END
GO

/**************** xpOk_20670 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20670') and type = 'P') drop procedure dbo.xpOk_20670
GO             
CREATE PROCEDURE xpOk_20670
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,
			@Renglon	float, 
			@RenglonSub	int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_20880 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20880') and type = 'P') drop procedure dbo.xpOk_20880
GO             
CREATE PROCEDURE xpOk_20880
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_20740 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20740') and type = 'P') drop procedure dbo.xpOk_20740
GO             
CREATE PROCEDURE xpOk_20740
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_30180 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_30180') and type = 'P') drop procedure dbo.xpOk_30180
GO
CREATE PROCEDURE xpOk_30180
           @Empresa			char(5),
		   @Usuario			char(10),
		   @Accion			char(20),
		   @Modulo			char(5),
		   @ID				int,
           @MovAplica		varchar(20),		
           @MovAplicaID		varchar(20),
    	   @Ok              int 		OUTPUT,
    	   @OkRef           varchar(255) 	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpOk_55020 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_55020') and type = 'P') drop procedure dbo.xpOk_55020
GO             
CREATE PROCEDURE xpOk_55020
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_20290 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20290') and type = 'P') drop procedure dbo.xpOk_20290
GO             
CREATE PROCEDURE xpOk_20290
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpVentaPendienteAceptarCantidad ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaPendienteAceptarCantidad') and type = 'P') drop procedure dbo.xpVentaPendienteAceptarCantidad
GO             
CREATE PROCEDURE xpVentaPendienteAceptarCantidad
			@CantidadOrdenada	float, 
			@CantidadPendiente	float, 
			@CantidadResevada	float, 
			@CantidadA		float, 	
			@Cantidad 		float	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpCxcVoucherAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCxcVoucherAfectar') and type = 'P') drop procedure dbo.xpCxcVoucherAfectar
GO             
CREATE PROCEDURE xpCxcVoucherAfectar
		    @ID		int,

  		    @Ok         int          OUTPUT,
    		    @OkRef      varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpCancelarFacturaOtroMes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCancelarFacturaOtroMes') and type = 'P') drop procedure dbo.xpCancelarFacturaOtroMes
GO             
CREATE PROCEDURE xpCancelarFacturaOtroMes
		    @ID			int,
		    @CancelacionID	int,

  		    @Ok         	int          OUTPUT,
    		    @OkRef      	varchar(255) OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpContMoneda2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContMoneda2') and type = 'P') drop procedure dbo.xpContMoneda2
GO             
CREATE PROCEDURE xpContMoneda2
		    @ID			int,
		    @Moneda2 		char(10) 	OUTPUT, 
		    @TipoCambio2 	float	 	OUTPUT,
  		    @Ok         	int          	OUTPUT,
    		    @OkRef      	varchar(255) 	OUTPUT

AS BEGIN
  -- ID es ID de la Poliza que se esta afectando
  -- Origen, OrigenID, OrigenTipo para alterar el Tipo de Cambio
  RETURN
END
GO

/**************** xpContMoneda2Update ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContMoneda2Update') and type = 'P') drop procedure dbo.xpContMoneda2Update
GO             
CREATE PROCEDURE xpContMoneda2Update
		    @ID			int,
		    @Moneda2 		char(10) 	OUTPUT, 
		    @TipoCambio2 	float	 	OUTPUT,
  		    @Ok         	int          	OUTPUT,
    		    @OkRef      	varchar(255) 	OUTPUT

AS BEGIN
  -- Este xp se corre despues de haber generado Debe2 y Haber2
  UPDATE ContD 
     SET Debe2 = Debe / @TipoCambio2, 
         Haber2 = Haber / @TipoCambio2
   WHERE ID = @ID
  RETURN
END
GO

/**************** xpMovCopiar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovCopiar') and type = 'P') drop procedure dbo.xpMovCopiar
GO             
CREATE PROCEDURE xpMovCopiar
		     @Sucursal		int,
    		     @Modulo		char(5),
		     @ID		int,
		     @Usuario		char(10),
		     @FechaTrabajo	datetime,
		     @EnSilencio	bit,
		     @Identico		bit,
		     @Directo		bit,
		     @Sub		bit,
		     @GenerarID		int,
		     @GenerarMov	char(20),
		     @GenerarMovID	varchar(20),
                     @CopiarArtCostoInv bit
AS BEGIN
  RETURN
END
GO

/**************** xpInvInventarioFisico ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvInventarioFisico') and type = 'P') drop procedure dbo.xpInvInventarioFisico
GO             
CREATE PROCEDURE xpInvInventarioFisico
		   @Sucursal			int,
      		   @ID				int, 
		   @Empresa			char(5), 
		   @Almacen			char(10),
		   @IDGenerar			int, 
		   @Base			char(20),
		   @CfgSeriesLotesMayoreo	bit,
		   @Estatus			char(15),

		   @Ok 				int 		OUTPUT, 
		   @OkRef 			varchar(255)	OUTPUT,
		   @Modulo			varchar(5) = 'INV',
		   @Proveedor			varchar(10) = NULL
AS BEGIN
  RETURN
END
GO

/**************** xpProcesarArt ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProcesarArt') and type = 'P') drop procedure dbo.xpProcesarArt
GO             
CREATE PROCEDURE xpProcesarArt
		     @Empresa		char(5),
		     @Sucursal		int,
		     @Usuario		char(10),
		     @Estacion		int,
		     @FechaTrabajo	datetime,
		     @Titulo		varchar(100)
AS BEGIN
  DECLARE
    @Conteo		int,
    @Articulo		char(20),
    @Ok			int,
    @OkRef		varchar(255),
    @Mensaje		varchar(255)

  SELECT @Conteo = 0, @Ok = NULL, @OkRef = NULL

  BEGIN TRANSACTION 
    DECLARE crProcesarArt CURSOR LOCAL
        FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion
    OPEN crProcesarArt
    FETCH NEXT FROM crProcesarArt INTO @Articulo
    WHILE @@FETCH_STATUS <> -1 AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 AND @Ok IS NULL
      BEGIN
        SELECT @Conteo = @Conteo + 1
      END
      FETCH NEXT FROM crProcesarArt INTO @Articulo
    END -- While
    CLOSE crProcesarArt
    DEALLOCATE crProcesarArt
  IF @Ok IS NULL
  BEGIN
    DELETE ListaSt WHERE Estacion = @Estacion 
    COMMIT TRANSACTION 
  END ELSE
    ROLLBACK TRANSACTION 

  IF @Ok IS NULL 
    SELECT @Mensaje = CONVERT(varchar, @Conteo)+' Articulos Procesados.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO

-- xpInvReciboTraspaso 'DEMO', 'DEMO', 0, 100, '11/1/4', 4
--select * from listadatos
/**************** xpInvReciboTraspaso ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvReciboTraspaso') and type = 'P') drop procedure dbo.xpInvReciboTraspaso
GO             
CREATE PROCEDURE xpInvReciboTraspaso
			@Empresa	char(5),
			@Usuario	char(10),
			@Sucursal	int,
			@Estacion	int,
			@Fecha		datetime,			
                        @ID             int
AS BEGIN
  DECLARE
    @CfgMultiUnidades		bit,
    @CfgMultiUnidadesNivel	char(20),
    @Conteo			int,
    @Mov			char(20),
    @MovID			varchar(20),
    @MovReciboTraspaso		char(20),
    @MovTransitoFaltante	char(20),
    @MovTransitoSobrante	char(20),
    @Almacen			char(10),
    @AlmacenDestino		char(10),
    @GenerarID			int,
    @Renglon			float,
    @RenglonID			int,
    @Datos			varchar(255),
    @Dato			varchar(255),
    @Articulo			char(20),
    @ArtTipo			varchar(20),
    @RenglonTipo		char(1),
    @SubCuenta			varchar(50),
    @Cantidad			float,
    @CantidadInventario		float,
    @Precio			money,
    @Costo			money,
    @CantidadRecibida		float,
    @CantidadTransito		float,
    @Unidad			varchar(50),
    @Ok				int,
    @OkRef			varchar(255),
    @Mensaje			varchar(255),
    @TransitoSucursal		int

  SELECT @Conteo = 0
  SELECT @MovReciboTraspaso = InvReciboTraspaso,
         @MovTransitoFaltante = InvTransitoFaltante,
         @MovTransitoSobrante = InvTransitoSobrante
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  SELECT @CfgMultiUnidades       = MultiUnidades,
	 @CfgMultiUnidadesNivel  = ISNULL(UPPER(NivelFactorMultiUnidad), 'UNIDAD')
    FROM EmpresaCfg2
   WHERE Empresa = @Empresa

  SELECT @Mov = Mov, 
         @MovID = MovID,
         @Almacen = Almacen,
         @AlmacenDestino = AlmacenDestino,
         @TransitoSucursal = Sucursal
    FROM Inv 
   WHERE ID = @ID

  UPDATE InvD SET Almacen = @AlmacenDestino WHERE ID = @ID AND Almacen <> @AlmacenDestino 

  CREATE TABLE #Recibo (
        	Articulo 		char(20) 	COLLATE Database_Default NULL, 
		SubCuenta		varchar(50)	COLLATE Database_Default NULL,
		Unidad			varchar(50)	COLLATE Database_Default NULL,
		Precio			money		NULL,
		Costo			money		NULL,
		CantidadTransito	float		NULL,
		CantidadRecibida	float		NULL)

  INSERT #Recibo (Articulo, SubCuenta, Unidad, Precio, Costo, CantidadTransito)
  SELECT Articulo, SubCuenta, Unidad, Precio, Costo, SUM(CantidadPendiente)
    FROM InvD 
   WHERE ID = @ID
   GROUP BY Articulo, SubCuenta, Unidad, Precio, Costo

  DECLARE crListaDatos CURSOR FOR
   SELECT CONVERT(varchar(255), Datos)
     FROM ListaDatos
    WHERE Estacion = @Estacion 
    ORDER BY ID

  OPEN crListaDatos
  FETCH NEXT FROM crListaDatos INTO @Datos
  WHILE @@FETCH_STATUS <> -1 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spExtraerDato @Datos OUTPUT, @Dato OUTPUT, ',' 
      EXEC spQuitarEntreComillas @Dato OUTPUT
      SELECT @Articulo = @Dato

      EXEC spExtraerDato @Datos OUTPUT, @Dato OUTPUT, ',' 
      EXEC spQuitarEntreComillas @Dato OUTPUT
      SELECT @Cantidad = CONVERT(float, @Dato)/100

      EXEC spExtraerDato @Datos OUTPUT, @Dato OUTPUT, ',' 
      EXEC spQuitarEntreComillas @Dato OUTPUT
      SELECT @SubCuenta = NULLIF(RTRIM(@Dato), '')

      UPDATE #Recibo
         SET CantidadRecibida = ISNULL(CantidadRecibida, 0.0) + ISNULL(@Cantidad, 0.0)
       WHERE Articulo = @Articulo AND ISNULL(SubCuenta, '') = ISNULL(@SubCuenta, '')
      IF @@ROWCOUNT = 0
        INSERT #Recibo (
               Articulo,  SubCuenta,  Unidad, CantidadRecibida)
        SELECT @Articulo, @SubCuenta, Unidad, @Cantidad
          FROM Art
         WHERE Articulo = @Articulo

    END
    FETCH NEXT FROM crListaDatos INTO @Datos
  END -- While
  CLOSE crListaDatos
  DEALLOCATE crListaDatos
  UPDATE #Recibo SET CantidadRecibida = ISNULL(CantidadRecibida, 0.0), CantidadTransito = ISNULL(CantidadTransito, 0.0)

  -- Recibo Traspaso
  IF EXISTS(SELECT * FROM #Recibo WHERE CantidadRecibida > 0.0 AND CantidadTransito > 0.0)
  BEGIN
    SELECT @Conteo = @Conteo + 1
    INSERT Inv (
           Empresa,  Mov,                Usuario,  FechaEmision, Estatus,     Almacen,  AlmacenDestino,  SucursalOrigen,    Sucursal,          Directo, Moneda, TipoCambio, Proyecto, UEN, Referencia, OrigenTipo, Origen, OrigenID)
    SELECT @Empresa, @MovReciboTraspaso, @Usuario, @Fecha,       'CONFIRMAR', @Almacen, @AlmacenDestino, @TransitoSucursal, @TransitoSucursal, 0,       Moneda, TipoCambio, Proyecto, UEN, Referencia, 'INV',      Mov,    MovID
      FROM Inv
     WHERE ID = @ID
    SELECT @GenerarID = SCOPE_IDENTITY()

    SELECT @Renglon = 0.0, @RenglonID = 0
    DECLARE crRecibo CURSOR FOR
     SELECT Articulo, SubCuenta, Unidad, Precio, Costo, CantidadTransito, CantidadRecibida
       FROM #Recibo
      WHERE CantidadRecibida > 0.0 AND CantidadTransito > 0.0
    OPEN crRecibo
    FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        IF @CantidadRecibida > @CantidadTransito SELECT @Cantidad = @CantidadTransito ELSE SELECT @Cantidad = @CantidadRecibida
        IF @Cantidad > 0.0
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
     	  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

          INSERT InvD (
                  ID,         Aplica, AplicaID, Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad,  Precio,  Costo,  Almacen,  SucursalOrigen,    Sucursal)
          VALUES (@GenerarID, @Mov,   @MovID,   @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Unidad, @Precio, @Costo, @Almacen, @TransitoSucursal, @TransitoSucursal)
        END
      END
      FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    END -- While
    CLOSE crRecibo
    DEALLOCATE crRecibo
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @GenerarID
  END

  -- Transito Faltante
  IF EXISTS(SELECT * FROM #Recibo WHERE CantidadTransito > CantidadRecibida)
  BEGIN
    SELECT @Conteo = @Conteo + 1
    INSERT Inv (
           Empresa,  Mov,                  Usuario,  FechaEmision, Estatus,     Almacen,  AlmacenDestino,  SucursalOrigen,    Sucursal,          Directo, Moneda, TipoCambio, Proyecto, UEN, Referencia, OrigenTipo, Origen, OrigenID)
    SELECT @Empresa, @MovTransitoFaltante, @Usuario, @Fecha,       'CONFIRMAR', @Almacen, @AlmacenDestino, @TransitoSucursal, @TransitoSucursal, 0,       Moneda, TipoCambio, Proyecto, UEN, Referencia, 'INV',      Mov,    MovID
      FROM Inv
     WHERE ID = @ID
    SELECT @GenerarID = SCOPE_IDENTITY()

    SELECT @Renglon = 0.0, @RenglonID = 0
    DECLARE crRecibo CURSOR FOR
     SELECT Articulo, SubCuenta, Unidad, Precio, Costo, CantidadTransito, CantidadRecibida
       FROM #Recibo
      WHERE CantidadTransito > CantidadRecibida
    OPEN crRecibo
    FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Cantidad = @CantidadTransito - @CantidadRecibida
        IF @Cantidad > 0.0
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
     	  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT

          INSERT InvD (
                  ID,         Aplica, AplicaID, Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad,  Precio,  Costo,  Almacen,         SucursalOrigen,    Sucursal)
          VALUES (@GenerarID, @Mov,   @MovID,   @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Unidad, @Precio, @Costo, @AlmacenDestino, @TransitoSucursal, @TransitoSucursal)
        END
      END
      FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    END -- While
    CLOSE crRecibo
    DEALLOCATE crRecibo
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @GenerarID
  END

  -- Transito Sobrante
  IF EXISTS(SELECT * FROM #Recibo WHERE CantidadTransito < CantidadRecibida)
  BEGIN
    SELECT @Conteo = @Conteo + 1
    INSERT Inv (
           Empresa,  Mov,                  Usuario,  FechaEmision, Estatus,     Almacen,  AlmacenDestino,  SucursalOrigen,    Sucursal,          Directo, Moneda, TipoCambio, Proyecto, UEN, Referencia, OrigenTipo, Origen, OrigenID)
    SELECT @Empresa, @MovTransitoSobrante, @Usuario, @Fecha,       'CONFIRMAR', @Almacen, @AlmacenDestino, @TransitoSucursal, @TransitoSucursal, 0,       Moneda, TipoCambio, Proyecto, UEN, Referencia, 'INV',      Mov,    MovID
      FROM Inv
     WHERE ID = @ID
    SELECT @GenerarID = SCOPE_IDENTITY()

    SELECT @Renglon = 0.0, @RenglonID = 0
    DECLARE crRecibo CURSOR FOR
     SELECT Articulo, SubCuenta, Unidad, Precio, Costo, CantidadTransito, CantidadRecibida
       FROM #Recibo
      WHERE CantidadTransito < CantidadRecibida
    OPEN crRecibo
    FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    WHILE @@FETCH_STATUS <> -1 
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SELECT @Cantidad = @CantidadRecibida - @CantidadTransito
        IF @Cantidad > 0.0
        BEGIN
          SELECT @Renglon = @Renglon + 2048.0, @RenglonID = @RenglonID + 1
          SELECT @ArtTipo = Tipo FROM Art WHERE Articulo = @Articulo
     	  EXEC spRenglonTipo @ArtTipo, @SubCuenta, @RenglonTipo OUTPUT
          EXEC xpCantidadInventario @Articulo, @SubCuenta, @Unidad, @CfgMultiUnidades, @CfgMultiUnidadesNivel, @Cantidad, @CantidadInventario OUTPUT
          INSERT InvD (
                  ID,         Aplica, AplicaID, Renglon,  RenglonID,  RenglonTipo,  Articulo,  SubCuenta,  Cantidad,  CantidadInventario,  Unidad,  Precio,  Costo,  Almacen,         SucursalOrigen,    Sucursal)
          VALUES (@GenerarID, @Mov,   @MovID,   @Renglon, @RenglonID, @RenglonTipo, @Articulo, @SubCuenta, @Cantidad, @CantidadInventario, @Unidad, @Precio, @Costo, @AlmacenDestino, @TransitoSucursal, @TransitoSucursal)
        END
      END
      FETCH NEXT FROM crRecibo INTO @Articulo, @SubCuenta, @Unidad, @Precio, @Costo, @CantidadTransito, @CantidadRecibida
    END -- While
    CLOSE crRecibo
    DEALLOCATE crRecibo
    UPDATE Inv SET RenglonID = @RenglonID WHERE ID = @GenerarID
  END

  IF @Ok IS NULL 
    SELECT @Mensaje = 'Se Generaron '+CONVERT(varchar, @Conteo)+' Movimientos por Confirmar.'
  ELSE
    SELECT @Mensaje = Descripcion+' '+RTRIM(ISNULL(@OkRef, '')) FROM MensajeLista WHERE Mensaje = @Ok

  SELECT @Mensaje
  RETURN
END
GO


/**************** xpGenerarGasto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarGasto') and sysstat & 0xf = 4) drop procedure dbo.xpGenerarGasto
GO             
CREATE PROCEDURE xpGenerarGasto
			@GastoID	int,
			@Accion		char(20),
		   	@Empresa	char(5),
		   	@Sucursal	int,
			@Usuario	char(10),
			@Modulo		char(5),
			@ID		int,
			@Mov		char(20),
			@MovID		varchar(20),
			@FechaEmision	datetime,
			@FechaRegistro	datetime,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpAfectarGastoDiversoCursor ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAfectarGastoDiversoCursor') and sysstat & 0xf = 4) drop procedure dbo.xpAfectarGastoDiversoCursor
GO             
CREATE PROCEDURE xpAfectarGastoDiversoCursor
			@Accion		char(20),
		   	@Empresa	char(5),
		   	@Sucursal	int,
			@Usuario	char(10),
			@Modulo		char(5),
			@ID		int,
    			@Concepto	varchar(50), 
    			@Acreedor	char(10), 
			@RenglonID	int,
			@CxpID		int,
			@GastoID	int,

			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCRAlmacenPrincipal ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCRAlmacenPrincipal') and sysstat & 0xf = 4) drop procedure dbo.xpCRAlmacenPrincipal
GO             
CREATE PROCEDURE xpCRAlmacenPrincipal
			@ID			int,
			@AlmacenPrincipal 	char(10)	OUTPUT,

			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/* xpRecibirPDT */
if exists (select * from sysobjects where id = object_id('dbo.xpRecibirPDT') and sysstat & 0xf = 4) drop procedure dbo.xpRecibirPDT
GO             
CREATE PROCEDURE xpRecibirPDT @Estacion 	int,
    	    	              @Empresa 		char(5),
			      @Usuario 		char(10),
       	  		      @Sucursal		int,
			      @Modulo		char(5),
			      @ID		int,
			      @AppPDT		varchar(50)
AS BEGIN
  DECLARE
    @Datos	varchar(255),
    @Ok		int,
    @OkRef	varchar(255),
    @Mensaje	varchar(255)

  SELECT @Ok = NULL, @OkRef = NULL
  BEGIN TRANSACTION
    DECLARE crLista CURSOR 
        FOR SELECT NULLIF(RTRIM(Clave), '') FROM ListaSt WHERE Estacion = @Estacion ORDER BY ID
    OPEN crLista
    FETCH NEXT FROM crLista INTO @Datos
    WHILE @@FETCH_STATUS <> -1 AND @Datos IS NOT NULL AND @Ok IS NULL
    BEGIN
      IF @@FETCH_STATUS <> -2 
      BEGIN
        SET @Datos = @Datos
        /* Ejemplo 
        SELECT @Prefijo     = RTRIM(LTRIM(SUBSTRING(@Datos,  2,  8))),
               @Basico      = RTRIM(LTRIM(SUBSTRING(@Datos, 10,  8))),
               @Sufijo      = RTRIM(LTRIM(SUBSTRING(@Datos, 18,  6))),
               @Ordenado    = CONVERT(int, SUBSTRING(@Datos, 24, 7)),
               @Remisionado = CONVERT(int, SUBSTRING(@Datos, 31, 7)),
               @Aviso       = NULLIF(RTRIM(SUBSTRING(@Datos, 38,  2)), ''),
               @Costo       = CONVERT(int, SUBSTRING(@Datos, 46, 8))/100,
               @Descripcion = SUBSTRING(@Datos, 54,  9)*/
 
      END
      FETCH NEXT FROM crLista INTO @Datos
    END
    CLOSE crLista
    DEALLOCATE crLista

  IF @Ok IS NULL
  BEGIN
    COMMIT TRANSACTION
    SELECT @Mensaje = 'Se Recibio con Exito'
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT @Mensaje = Descripcion + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok
  END

  SELECT @Mensaje
  RETURN
END
GO

/**************** xpNominaH ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaH') and sysstat & 0xf = 4) drop procedure dbo.xpNominaH
GO             
CREATE PROCEDURE xpNominaH
			@Estacion	int,
			@ID		int,
		
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpIncidenciaH ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpIncidenciaH') and sysstat & 0xf = 4) drop procedure dbo.xpIncidenciaH
GO             
CREATE PROCEDURE xpIncidenciaH
			@IncidenciaHID	int,
			@IncidenciaID	int,
		
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpVentaTraspasarArticulosSugerir ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaTraspasarArticulosSugerir') and sysstat & 0xf = 4) drop procedure dbo.xpVentaTraspasarArticulosSugerir
GO             
CREATE PROCEDURE xpVentaTraspasarArticulosSugerir
			@ID		int,
			@Articulo	char(20)
AS BEGIN
  DECLARE
    @Sucursal		int,
    @Empresa		char(5),
    @ListaPrecios	varchar(50),
    @Moneda		char(10),    
    @TipoCambio		float,
    @Precio		float,
    @Costo		float

  SELECT @Sucursal = Sucursal, @Empresa = Empresa, @Moneda = Moneda, @TipoCambio = TipoCambio, @ListaPrecios = ListaPreciosEsp
    FROM Venta 
   WHERE ID = @ID

  EXEC spPCGet @Sucursal, @Empresa, @Articulo, NULL, NULL, @Moneda, @TipoCambio, @ListaPrecios,      @Precio OUTPUT
  EXEC spPCGet @Sucursal, @Empresa, @Articulo, NULL, NULL, @Moneda, @TipoCambio, '(Costo Promedio)', @Costo OUTPUT

  SELECT "Precio" = @Precio, "Costo" = @Costo
  RETURN
END
GO


-- xpVentaTraspasarArticulosProcesar 1, 104, 'DEMO', '2/16/5'
/**************** xpVentaTraspasarArticulosProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaTraspasarArticulosProcesar') and sysstat & 0xf = 4) drop procedure dbo.xpVentaTraspasarArticulosProcesar
GO             
CREATE PROCEDURE xpVentaTraspasarArticulosProcesar
			@ID		int,
			@Estacion	int,
			@Usuario	char(10),
			@FechaTrabajo	datetime
AS BEGIN
  DECLARE
    @Sucursal			int,
    @Empresa			char(5),
    @Moneda			char(10),    
    @Mov			char(20),
    @MovID			varchar(20),
    @TipoCambio			float,
    @Articulo			char(20),
    @ArtTipo			varchar(20),
    @RenglonTipo		char(1), 
    @Cantidad			float,
    @Precio			float,
    @Costo			float,
    @Accion			varchar(20),
    @CantidadPendiente		float,
    @CantidadSaldo		float,
    @CantidadA			float,
    @CantidadNueva		float,
    @CantidadReservada		float,
    @GenerarID			int,
    @FechaRegistro		datetime,
    @AlmacenDestino		char(10),
    @AlmacenOrigen		char(10),
    @Unidad			varchar(50),
    @Impuesto1			float,
    @Referencia			varchar(50),
    @OrdenTraspasoID		int,
    @OrdenTraspasoMov		char(20),
    @SalidaTraspasoID		int,
    @SalidaTraspasoMov		char(20),
    @SalidaTraspasoMovID 	varchar(20),
    @ReciboTraspasoID		int,
    @ReciboTraspasoMov		char(20),
    @TransitoID			int,
    @Ok				int,
    @OkRef			varchar(255)

  BEGIN TRANSACTION

  SELECT @FechaRegistro = GETDATE(), @Ok = NULL, @OkRef = NULL

  SELECT @Mov = Mov, @MovID = MovID, @Empresa = Empresa, @Sucursal = Sucursal, @Moneda = Moneda, @TipoCambio = TipoCambio, @AlmacenDestino = Almacen 
    FROM Venta 
   WHERE ID = @ID

  SELECT @OrdenTraspasoMov = InvOrdenTraspaso, @SalidaTraspasoMov = InvSalidaTraspaso, @ReciboTraspasoMov = InvReciboTraspaso
    FROM EmpresaCfgMov
   WHERE Empresa = @Empresa

  UPDATE VentaD SET CantidadA = NULL WHERE ID = @ID
  DECLARE crVentaTraspasarArticulos CURSOR FOR
   SELECT t.Articulo, ISNULL(t.Cantidad, 0.0), t.Precio, t.Costo, t.Accion, t.Referencia, a.Tipo, a.Unidad, a.Impuesto1
     FROM VentaTraspasarArticulos t
     JOIN Art a ON a.Articulo = t.Articulo
    WHERE ID = @ID AND Estacion = @Estacion
  OPEN crVentaTraspasarArticulos
  FETCH NEXT FROM crVentaTraspasarArticulos INTO @Articulo, @Cantidad, @Precio, @Costo, @Accion, @Referencia, @ArtTipo, @Unidad, @Impuesto1
  WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 
  BEGIN
    IF @@FETCH_STATUS <> -2 
    BEGIN
      EXEC spRenglonTipo @ArtTipo, NULL, @RenglonTipo OUTPUT
      IF @Accion = 'Agregar'
      BEGIN
        SELECT @GenerarID = NULL, @CantidadNueva = 0.0, @CantidadPendiente = 0.0
        SELECT @CantidadPendiente = ISNULL(SUM(CantidadPendiente), 0.0) FROM VentaD WHERE ID = @ID AND Articulo = @Articulo
        IF @Cantidad > @CantidadPendiente SELECT @CantidadNueva = @Cantidad - @CantidadPendiente
        IF @CantidadNueva > 0.0
        BEGIN
          EXEC @GenerarID = spMovCopiar @Sucursal, 'VTAS', @ID, @Usuario, @FechaTrabajo, @Sub = 1, @EnSilencio = 1, @Conexion = 1
          IF @GenerarID IS NOT NULL
          BEGIN
            SELECT @Mov = Mov, @MovID = MovID FROM Venta WHERE ID = @GenerarID
            INSERT VentaD (ID, Sucursal, Renglon, RenglonID, RenglonTipo, Almacen, Articulo, Unidad, Cantidad, Costo, Precio, Impuesto1)
                   VALUES (@GenerarID, @Sucursal, 2048.0, 1, @RenglonTipo, @AlmacenDestino, @Articulo, @Unidad, @CantidadNueva, @Costo, @Precio, @Impuesto1)

            EXEC spAfectar 'VTAS', @GenerarID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
          END
        END
      END
      IF @Accion = 'Cancelar'
      BEGIN 
        -- Desreservar
        SELECT @CantidadSaldo = @Cantidad
        DECLARE crVentaD CURSOR LOCAL FOR
         SELECT CantidadReservada
           FROM VentaD
          WHERE ID = @ID AND Articulo = @Articulo
        OPEN crVentaD
        FETCH NEXT FROM crVentaD INTO @CantidadReservada
        WHILE @@FETCH_STATUS <> -1 AND @@Error = 0 AND @CantidadSaldo > 0.0
        BEGIN
          IF @@FETCH_STATUS <> -2 
          BEGIN
            IF @CantidadReservada > @CantidadSaldo SELECT @CantidadA = @CantidadSaldo ELSE SELECT @CantidadA = @CantidadReservada
            IF ISNULL(@CantidadA, 0.0) > 0.0
            BEGIN
              UPDATE VentaD SET CantidadA = @CantidadA WHERE CURRENT OF crVentaD
              SELECT @CantidadSaldo = @CantidadSaldo - @CantidadA
            END
          END
          FETCH NEXT FROM crVentaD INTO @CantidadReservada
        END
        CLOSE crVentaD
        DEALLOCATE crVentaD
        EXEC spAfectar 'VTAS', @ID, 'CANCELAR', 'SELECCION', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1

        -- Ajustar a la Cantidad Real Desreservada
        SELECT @Cantidad = @Cantidad - ISNULL(@CantidadSaldo, 0.0)

        -- Traspasar Cantidad
        IF ISNULL(@Cantidad, 0.0) > 0.0 AND @Ok IS NULL
        BEGIN
          EXEC spArtAlmacenOrigenOT @Empresa, @Articulo, @AlmacenDestino, @AlmacenOrigen OUTPUT
      
          INSERT Inv (OrigenTipo, Origen, OrigenID, UltimoCambio,  Sucursal, Empresa, Usuario,  Estatus,     Mov,                FechaEmision,  Almacen,         AlmacenDestino,  Proyecto, Moneda, TipoCambio, Referencia,  Observaciones, FechaRequerida)
              SELECT 'VTAS',     Mov,    MovID,    GETDATE(),     @Sucursal, Empresa, Usuario, 'SINAFECTAR', @SalidaTraspasoMov, @FechaTrabajo, @AlmacenDestino, @AlmacenOrigen,  Proyecto, Moneda, TipoCambio, @Referencia, Observaciones, FechaRequerida
            FROM Venta
          WHERE ID = @ID 
          SELECT @SalidaTraspasoID = SCOPE_IDENTITY()
          INSERT InvD (ID, Sucursal, Renglon, RenglonID, RenglonTipo, Articulo, Unidad, Cantidad, Costo, Precio, Almacen)
               VALUES (@SalidaTraspasoID, @Sucursal, 2048.0, 1, @RenglonTipo, @Articulo, @Unidad, @Cantidad, @Costo, @Precio, @AlmacenDestino)

          EXEC @TransitoID = spAfectar 'INV', @SalidaTraspasoID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1

          IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
          IF @TransitoID IS NOT NULL AND @Ok IS NULL
          BEGIN
            SELECT @SalidaTraspasoMovID = MovID FROM Inv WHERE ID = @SalidaTraspasoID
            EXEC spMovFlujo @Sucursal, 'AFECTAR', @Empresa, 'VTAS', @ID, @Mov, @MovID, 'INV', @SalidaTraspasoID, @SalidaTraspasoMov, @SalidaTraspasoMovID, @Ok OUTPUT 

            EXEC @ReciboTraspasoID = spAfectar 'INV', @TransitoID, 'GENERAR', 'PENDIENTE', @ReciboTraspasoMov, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
            IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            IF @ReciboTraspasoID IS NOT NULL AND @Ok IS NULL
            BEGIN
              EXEC spAfectar 'INV', @ReciboTraspasoID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
              IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
            END
          END
        END
      END
    END
    FETCH NEXT FROM crVentaTraspasarArticulos INTO @Articulo, @Cantidad, @Precio, @Costo, @Accion, @Referencia, @ArtTipo, @Unidad, @Impuesto1
  END
  CLOSE crVentaTraspasarArticulos
  DEALLOCATE crVentaTraspasarArticulos
  
  IF @Accion = 'Agregar'
  BEGIN
    IF EXISTS(SELECT * FROM VentaD WHERE ID = @ID AND ISNULL(CantidadPendiente, 0.0) > 0.0)
    BEGIN
      EXEC @OrdenTraspasoID = spPedidoGenerarOT @Empresa, @ID, @Sucursal, @Usuario, @OrdenTraspasoMov, @EnSilencio = 1
      IF @OrdenTraspasoID IS NOT NULL
      BEGIN
        EXEC spAfectar 'INV', @OrdenTraspasoID, 'RESERVAR', 'PENDIENTE', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF @Ok IS NULL
          EXEC @SalidaTraspasoID = spAfectar 'INV', @OrdenTraspasoID, 'GENERAR', 'RESERVADO', @SalidaTraspasoMov, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
        IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
        IF EXISTS(SELECT * FROM InvD WHERE ID = @SalidaTraspasoID) AND @Ok IS NULL
        BEGIN
           EXEC @TransitoID = spAfectar 'INV', @SalidaTraspasoID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
           IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
           IF @TransitoID IS NOT NULL AND @Ok IS NULL
           BEGIN
             EXEC @ReciboTraspasoID = spAfectar 'INV', @TransitoID, 'GENERAR', 'PENDIENTE', @ReciboTraspasoMov, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
             IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
             IF @ReciboTraspasoID IS NOT NULL AND @Ok IS NULL
             BEGIN
               DECLARE crReciboTraspaso CURSOR FOR
                SELECT Articulo, Costo
                  FROM InvD
                 WHERE ID = @ReciboTraspasoID
               OPEN crReciboTraspaso
               FETCH NEXT FROM crReciboTraspaso INTO @Articulo, @Costo
               WHILE @@FETCH_STATUS <> -1 AND @@Error = 0  AND @Ok IS NULL
               BEGIN
                 IF @@FETCH_STATUS <> -2 
                 BEGIN
                   SELECT @Costo = NULL
                   SELECT @Costo = MIN(Costo) FROM VentaTraspasarArticulos WHERE ID = @ID AND Estacion = @Estacion AND Articulo = @Articulo
                   IF @Costo IS NOT NULL 
                     UPDATE InvD SET Costo = @Costo WHERE CURRENT OF crReciboTraspaso
                 END
                 FETCH NEXT FROM crReciboTraspaso INTO @Articulo, @Costo
               END
               CLOSE crReciboTraspaso
               DEALLOCATE crReciboTraspaso

               IF @Ok IS NULL
                 EXEC spAfectar 'INV', @ReciboTraspasoID, 'AFECTAR', 'TODO', NULL, @Usuario, @EnSilencio = 1, @Ok = @Ok OUTPUT, @OkRef = @OkRef OUTPUT, @Conexion = 1
               IF @Ok = 80030 SELECT @Ok = NULL, @OkRef = NULL
             END              
           END           
        END ELSE
          DELETE Inv WHERE ID = @SalidaTraspasoID
      END
    END
  END

  IF @Ok IS NULL
  BEGIN 
    DELETE VentaTraspasarArticulos WHERE ID = @ID AND Estacion = @Estacion

    COMMIT TRANSACTION
    SELECT 'Se Proceso con Exito el Traspaso'
  END ELSE 
  BEGIN
    ROLLBACK TRANSACTION
    SELECT Descripcion + ' ' + ISNULL(RTRIM(@OkRef), '') FROM MensajeLista WHERE Mensaje = @Ok  
  END

  RETURN
END
GO

/**************** xpGenerarTransito ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarTransito') and sysstat & 0xf = 4) drop procedure dbo.xpGenerarTransito
GO             
CREATE PROCEDURE xpGenerarTransito 
			@Empresa	char(5), 
			@Sucursal	int, 
			@Usuario	char(10), 
			@Modulo		char(5), 
			@MovTipo	varchar(20), 
			@Referencia	varchar(50), 
			@ID		int, 
			@IDTransito	int
AS BEGIN
  RETURN
END
GO

/**************** xpACCerrarDia ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACCerrarDia') and type = 'P') drop procedure dbo.xpACCerrarDia
GO
CREATE PROCEDURE xpACCerrarDia
	           @Empresa		char(5),
		   @Usuario		char(10), 
		   @Hoy			datetime,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpMovModificarCostoPrecio ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovModificarCostoPrecio') and type = 'P') drop procedure dbo.xpMovModificarCostoPrecio
GO
CREATE PROCEDURE xpMovModificarCostoPrecio
		   @Accion		char(20),
	           @Empresa		char(5),
		   @Modulo		char(5), 
		   @ID			int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		varchar(20),
		   @AfectarCostos	bit,	
		   @EsEntrada		bit, 
		   @EsSalida		bit, 
		   @EsTransferencia	bit, 	
		   @Renglon		float,
		   @RenglonSub		int,
		   @Articulo		varchar(20),
		   @SubCuenta		varchar(50),
		   @Unidad		varchar(50),
		   @ArtCosto		float,
		   @ArtFactor		float,
		   @Costo		float		OUTPUT,
		   @Precio		float		OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  /* nota - El precio que llega no incluye descuentos */

  RETURN
END
GO


/**************** xpGenerarCxImportacionCondicionVencimiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCxImportacionCondicionVencimiento') and type = 'P') drop procedure dbo.xpGenerarCxImportacionCondicionVencimiento
GO
CREATE PROCEDURE xpGenerarCxImportacionCondicionVencimiento
		   @Modulo		char(5), 
		   @ID			int,
		   @Accion		char(20),
	           @Proveedor		char(10),
		   @Referencia		varchar(50),
		   @Importe		money,
		   @Impuestos		money,
		   @Condicion		varchar(50)	OUTPUT,
		   @Vencimiento		datetime	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpNominaGenerar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaGenerar') and type = 'P') drop procedure dbo.xpNominaGenerar
go
CREATE PROCEDURE xpNominaGenerar
			@Estacion	int,
			@ID		int,
			@FechaD		datetime,
			@FechaA		datetime,
			@PeriodoTipo	varchar(20)
AS BEGIN
  RETURN
END
GO

/**************** xpInvConsumoMaterialAfectarEntradaProducto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvConsumoMaterialAfectarEntradaProducto') and type = 'P') drop procedure dbo.xpInvConsumoMaterialAfectarEntradaProducto
GO
CREATE PROCEDURE xpInvConsumoMaterialAfectarEntradaProducto
				   @Accion	varchar(20),
				   @Empresa	char(5),
				   @Sucursal	int,
		                   @ID          int,
				   @Mov		varchar(20),
				   @MovID	varchar(20),
    				   @Articulo	varchar(20),
    				   @SubCuenta	varchar(50),
    				   @Cantidad	float,
    				   @Costo	float		OUTPUT,
				   @Ok		int		OUTPUT,
				   @OkRef	varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpACReinversionAutomatica ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACReinversionAutomatica') and type = 'P') drop procedure dbo.xpACReinversionAutomatica
GO
CREATE PROCEDURE xpACReinversionAutomatica
    		   @Modulo		char(5),
		   @ReinversionID	int,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/* Sincro Final */ 
if exists (select * from sysobjects where id = object_id('dbo.xpSincroFinal') and type = 'P') drop procedure dbo.xpSincroFinal
GO
CREATE PROCEDURE xpSincroFinal
AS BEGIN
  RETURN
END
GO

/**************** xpAutoAplicarCx ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAutoAplicarCx') and type = 'P') drop procedure dbo.xpAutoAplicarCx
GO
CREATE PROCEDURE xpAutoAplicarCx
    		   @Modulo		char(5),
		   @ID			int,
		   @AutoAplicar		bit		OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpInvInitRenglon ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvInitRenglon') and type = 'P') drop procedure dbo.xpInvInitRenglon
GO             
CREATE PROCEDURE xpInvInitRenglon
		    @Empresa			char(5),
		    @CfgDecimalesCantidades	int,
		    @CfgMultiUnidades		bit,
		    @CfgMultiUnidadesNivel	char(20),
    	      	    @CfgCompraFactorDinamico 	bit,
		    @CfgInvFactorDinamico   	bit,
		    @CfgProdFactorDinamico  	bit,
		    @CfgVentaFactorDinamico 	bit,
		    @CfgBloquearNotasNegativas	bit,	
                    @AlVerificar		bit,
		    @Matando			bit,
		    @Accion			char(20),
		    @Base			char(20),
		    @Modulo			char(5),
		    @ID				int,		-- Este campo no pasa cuando Matando = 1
		    @Renglon			float,		-- Este campo no pasa cuando Matando = 1
		    @RenglonSub			int,		-- Este campo no pasa cuando Matando = 1
                    @Estatus			char(15),
                    @EstatusNuevo		char(15),
                    @MovTipo			char(20),
		    @FacturarVtasMostrador	bit,
		    @EsTransferencia		bit,
		    @AfectarConsignacion	bit,
		    @ExplotandoSubCuenta	bit,
                    @AlmacenTipo		char(15),
                    @AlmacenDestinoTipo		char(15),
		    @Articulo			char(20),
		    @MovUnidad			varchar(50),
		    @ArtUnidad			varchar(50),
                    @ArtTipo			varchar(20),
                    @RenglonTipo		char(1),
		    @AplicaMovTipo		varchar(20),
		    @CantidadOriginal		float,
		    @CantidadInventario		float,
                    @CantidadPendiente		float,
                    @CantidadA			float,
		    @DetalleTipo		varchar(20),
	            @Cantidad			float		OUTPUT,
	            @CantidadCalcularImporte	float		OUTPUT,
                    @CantidadReservada		float		OUTPUT,
                    @CantidadOrdenada		float		OUTPUT,
 		    @EsEntrada			bit		OUTPUT,
		    @EsSalida			bit		OUTPUT,
		    @SubCuenta			varchar(50)	OUTPUT,
		    @AfectarPiezas		bit		OUTPUT,
		    @AfectarCostos		bit		OUTPUT,
		    @AfectarUnidades		bit		OUTPUT,
                    @Factor			float		OUTPUT,
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpContAntes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAntes') and type = 'P') drop procedure dbo.xpContAntes
GO
CREATE PROCEDURE xpContAntes
                   @ID                  	int,
    		   @Modulo	      		char(5),
		   @Accion			char(20),
		   @Base			char(20),
		   @FechaRegistro		datetime,
		   @GenerarMov			char(20), 
		   @Usuario			char(10), 

    		   @Conexion			bit,
		   @SincroFinal			bit,
    		   @Mov	      			char(20),
    		   @MovID            		varchar(20),
		   @GenerarID			int,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpInvMatarAlmacenOrigen ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvMatarAlmacenOrigen') and type = 'P') drop procedure dbo.xpInvMatarAlmacenOrigen
GO             
CREATE PROCEDURE xpInvMatarAlmacenOrigen
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,
			@MovTipo	varchar(20),
			@IDAplica	int, 
			@AplicaMovTipo	varchar(20), 
			@Articulo	varchar(20), 
			@SubCuenta	varchar(50), 
			@MovUnidad	varchar(50), 
			@AlmacenOrigen 	varchar(10) 	OUTPUT,
    		    	@Ok             int          	OUTPUT,
    		    	@OkRef          varchar(255) 	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpNominaCalcIncidencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaCalcIncidencia') and type = 'P') drop procedure dbo.xpNominaCalcIncidencia
GO             
CREATE PROCEDURE xpNominaCalcIncidencia
			@NomTipo	varchar(50),
			@Empresa	char(5),
			@Personal	char(10),
			@FechaD		datetime,
			@FechaA		datetime,
			@IncidenciaD	datetime, 
			@IncidenciaA	datetime,
			@TipoCambio	float,
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT
AS BEGIN
  -- En este momento se acaban de agregar a #Nomina todas las Incidencias, para que se puedan manipular antes de generar la nomina
  RETURN
END
GO

/************** xpCopiarUsuarioCfg *************/
if exists (select * from sysobjects where id = object_id('dbo.xpCopiarUsuarioCfg') and sysstat & 0xf = 4) drop procedure dbo.xpCopiarUsuarioCfg
GO
CREATE PROCEDURE xpCopiarUsuarioCfg
                   @UsuarioD    char(10),
                   @UsuarioA	char(10)
AS BEGIN
  RETURN
END
GO

/*************** xpEndosoGenerado *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpEndosoGenerado') and type = 'P') drop procedure dbo.xpEndosoGenerado
GO             
CREATE PROCEDURE xpEndosoGenerado
			@Sucursal	int,
			@ID 		int, 
			@CxID 		int, 
			@EndosoID 	int, 
			@EndosoModulo	char(5), 
			@CxMovTipo	char(20), 
			@Ok 		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT


AS BEGIN
  RETURN
END
GO

/**************** xpTablaImpuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTablaImpuesto') and type = 'P') drop procedure dbo.xpTablaImpuesto
go
CREATE PROCEDURE xpTablaImpuesto
  			@Tabla		varchar(50),
  			@PeriodoTipo	char(20),
  			@Importe	money,
  			@Impuesto	money	OUTPUT
AS BEGIN
  RETURN
END
go


/**************** xpGastoAfectarOtrosModulos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGastoAfectarOtrosModulos') and type = 'P') drop procedure dbo.xpGastoAfectarOtrosModulos
go
CREATE PROCEDURE xpGastoAfectarOtrosModulos
  			@MovTipo		varchar(20), 
			@OrigenMovTipo		varchar(20), 
			@AfectarOtrosModulos 	bit 		OUTPUT, 
			@Ok 			int		OUTPUT, 
			@OkRef 			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
go

/**************** xpContXLog ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContXLog') and type = 'P') drop procedure dbo.xpContXLog
go
CREATE PROCEDURE xpContXLog
  			@Empresa	char(5),
  			@Usuario	char(10),
  			@Sucursal	int,
  			@Estacion	int,
			@EsInicio	bit
AS BEGIN
  RETURN
END
go

/**************** xpNominaIMSS ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaIMSS') and type = 'P') drop procedure dbo.xpNominaIMSS
GO             
CREATE PROCEDURE xpNominaIMSS
  			@Empresa				char(5), 
			@SucursalTrabajo			int, 
			@Categoria				varchar(50), 
			@Puesto					varchar(50), 
			@Personal				char(10),
                 	@SDI                  			money,
                 	@DiasPeriodo          			int,
                 	@Incapacidades        			int,  
                 	@Faltas               			int,
          	 	@SMGDF                                  money,
			@CalcPatron				bit,
          	 	@IMSSObrero    				money,
			@IMSSObreroCV				money,
          	 	@IMSSPatron    				money,
    		        @IMSSPatronMensual		        money,
			@IMSSPatronCV				money,
			@IMSSPatronRetiro			money,
			@IMSSPatronInfonavit			money,
			@SDITopadoMaternidad                	money,
			@IMSSObreroPrestacionesDinero       	money,
			@SDITopado                          	money,
			@IMSSObreroCoutaAdicionalExcedente  	money,
			@IMSSObreroCuotaAdicionalMinimo     	money,
			@IMSSObreroGastosMedicos            	money,
			@IMSSObreroIV                       	money,
			@IMSSObreroCuotaAdicional           	money,
			@IMSSObreroEMExecenteTope           	float,
			@IMSSObreroCVTope                   	float,
			@IMSSObreroGastosMedicosTope        	float,
			@IMSSObreroIVTope                   	float,
			@IMSSObreroPrestacionesDineroTope   	float,
			@IMSSObreroEMExcedentePct        	float,
			@IMSSObreroPrestacionesDineroPct 	float,
			@IMSSObreroGastosMedicosPct      	float,
			@IMSSObreroIVPct                 	float,
			@IMSSObreroCVPct                 	float,
			@IMSSPatronGastosMedicos            	money,
			@IMSSPatronIV                       	money,
			@IMSSPatronCuotaAdicional           	money,
			@IMSSPatronCuotaFija	        	money,
			@IMSSPatronRiesgo			money,
			@IMSSPatronGuarderias			money,
			@IMSSPatronPrestacionesDinero       	money,
			@IMSSPatronInfonavitTope		float,
			@IMSSPatronRetiroTope			float,
			@IMSSPatronEMExcedentePct        	float,
			@IMSSPatronPrestacionesDineroPct 	float,
			@IMSSPatronGastosMedicosPct      	float,
			@IMSSPatronIVPct                 	float,
			@IMSSPatronCVPct                 	float,
			@IMSSPatronRiesgoPct             	float,
			@IMSSPatronGuarderiasPct         	float,
			@IMSSPatronInfonavitPct          	float,
			@IMSSPatronRetiroPct             	float,
			@IMSSPatronEMCuotaFijaPct  		float
AS BEGIN
  RETURN
END
go

/**************** xpACDevengarInteresesFactorMes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACDevengarInteresesFactorMes') and type = 'P') drop procedure dbo.xpACDevengarInteresesFactorMes
go
CREATE PROCEDURE xpACDevengarInteresesFactorMes
			@Hoy		datetime,
			@FactorMes	float	OUTPUT
AS BEGIN
  DECLARE
    @Mes	int,
    @Ano	int,
    @Dias	int

  SELECT @FactorMes = 1.0
/*
  SELECT @Mes = MONTH(@Hoy), @Ano = YEAR(@Hoy)
  EXEC spDiasMes @Mes, @Ano, @Dias OUTPUT
  SELECT @FactorMes = 30.0 / @Dias
*/
  RETURN
END
go



/*************** xpFEAGenerar *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpFEAGenerar') and type = 'P') drop procedure dbo.xpFEAGenerar
GO
CREATE PROCEDURE xpFEAGenerar
			@ID   		int

AS BEGIN

  RETURN
END
GO


/************ xpOk_50160 ************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_50160') and type = 'p') drop procedure xpOk_50160
GO
CREATE PROCEDURE xpOk_50160
	@Origen		varchar(20),
	@OrigenTipo	varchar(20),
	@Cuenta		varchar(10),
	@Ok		int		OUTPUT

AS BEGIN
  RETURN
END
GO


-- xpGastoPresupuestoAuto 'DEMO', 2005, 1, 1, 'DEMO'
-- xpGastoPresupuestoAuto 'INTEL', 2006, 1, 1, 'ADMIN'
/**************** xpGastoPresupuestoAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGastoPresupuestoAuto') and type = 'P') drop procedure dbo.xpGastoPresupuestoAuto
GO
CREATE PROCEDURE xpGastoPresupuestoAuto
		@Empresa	char(5),
		@Ejercicio	int,
		@PeriodoD	int,
		@PeriodoA	int,
		@Usuario	char(10)

AS
BEGIN
	DECLARE
	@ID			int,
	@Mov			char(20),
	@Periodo		int,
	@FechaBase		char(11),
	@FechaEmision		datetime,
	@AcreedorDef		char(10),
	@Acreedor		char(10),
	@Concepto		char(50),
	@Moneda			char(10),
	@Clase			char(50),
	@SubClase		char(50),
	@TC			float,
	@Cantidad		float,  
	@Importe		money,
	@CentroCostos		char(20),
	@Impuestos		money,
	@Inflacion		money,
	@InflacionSubClase	money,
	@Contador		int,
	@Renglon		float,
	@PD			float,
	@Sucursal		int

	CREATE TABLE #GastoPresupuestoAuto(
	Clase			char(50)	COLLATE Database_Default NULL,
	SubClase		char(50)	COLLATE Database_Default NULL,
	Periodo			int		NULL,
	Sucursal		int		NULL,
	Concepto		char(50)	COLLATE Database_Default NULL,
	Moneda			char(10)	COLLATE Database_Default NULL,
	Cantidad		float		NULL,
	Importe			money		NULL,
	ContUso			char(20)	COLLATE Database_Default NULL,
	Impuestos		money		NULL,
	Acreedor		char(10)	COLLATE Database_Default NULL)
	
	SELECT @AcreedorDef = 'PRESUP', @Renglon = 1024

	SELECT @Mov = GastoPresupuesto
	  FROM EmpresaCfgMov WHERE Empresa = @Empresa

/*	IF Exists(SELECT * FROM Gasto g, MovTipo m WHERE g.Mov = m.Mov AND m.Modulo = 'GAS' AND m.Clave = 'GAS.PR'
	   AND g.Empresa = @Empresa AND g.Estatus in ('SINAFECTAR', 'CONCLUIDO', 'CONFIRMAR')
	   AND DATEPART(month, g.FechaEmision) = @Periodo AND DATEPART(year, g.FechaEmision) = @Ejercicio)
	
	BEGIN
		SELECT 'Ya Existen Presupuestos en la Empresa en el Periodo y Ejercicio'
		RETURN
	END
*/

BEGIN TRANSACTION

	SELECT @FechaBase = '1/1/' + RTRIM(@Ejercicio)

	IF NOT EXISTS(SELECT * FROM Prov WHERE Proveedor = @AcreedorDef)
	INSERT INTO Prov(Proveedor, Nombre, Estatus, Tipo)
	VALUES(@AcreedorDef, 'Presupuesto', 'ALTA', 'Acreedor')

	INSERT INTO #GastoPresupuestoAuto(Clase, SubClase, Periodo, Sucursal, Concepto, Moneda, Cantidad, 			Importe, 		ContUso, 		Impuestos, Acreedor)
--	SELECT c.Clase, c.SubClase, DATEPART(month, g.FechaEmision), g.Sucursal, d.Concepto, g.Moneda, SUM(d.Cantidad*m.Factor), SUM(d.Importe*m.Factor), d.ContUso, SUM(d.Impuestos*m.Factor), ISNULL((SELECT Top 1 Acreedor FROM ConceptoAcreedor WHERE Modulo = 'GAS' AND Concepto = c.Concepto AND porOmision = 1), @AcreedorDef)
	SELECT c.Clase, c.SubClase, DATEPART(month, g.FechaEmision), g.Sucursal, d.Concepto, g.Moneda, SUM(d.Cantidad*m.Factor), SUM(d.Importe*m.Factor), d.ContUso, SUM(d.Impuestos*m.Factor), @AcreedorDef
	  FROM Gasto g, GastoD d, MovTipo m, Concepto c
	 WHERE g.ID = d.ID
	   AND d.Concepto = c.Concepto
	   AND g.Mov = m.Mov AND m.Modulo = 'GAS' AND m.Clave in ('GAS.C', 'GAS.DC', 'GAS.DG', 'GAS.EST', 'GAS.CI', 'GAS.G', 'GAS.GTC')
-- Comprobante, Dev. Comprobante, Devolucion Gasto, Estadistica, Gasto, Gasto T/Credito
	   AND g.Empresa = @Empresa AND g.Estatus = 'CONCLUIDO'
	   AND DATEPART(year, g.FechaEmision) = @Ejercicio - 1 AND DATEPART(month, g.FechaEmision) BETWEEN @PeriodoD AND @PeriodoA
	   AND c.Modulo = 'GAS' AND c.CalcularPresupuesto = 1
	   AND ISNULL(d.Importe,0) <> 0
	 GROUP BY c.Clase, c.SubClase, DATEPART(month, g.FechaEmision), g.Sucursal, d.Concepto, c.Concepto, g.Moneda, d.ContUso

	SELECT @Contador = 0

	DECLARE crGastoPresupuestoAuto CURSOR STATIC FOR
	SELECT DISTINCT Moneda, Periodo, Sucursal, Clase, SubClase, Acreedor
	  FROM #GastoPresupuestoAuto

OPEN crGastoPresupuestoAuto
FETCH NEXT FROM crGastoPresupuestoAuto INTO @Moneda, @Periodo, @Sucursal, @Clase, @SubClase, @Acreedor
WHILE @@FETCH_STATUS = 0 AND @@ERROR = 0
	BEGIN
		IF @Periodo = 1  SELECT @FechaEmision = Convert(datetime, @FechaBase, 103) ELSE
		IF @Periodo = 2  SELECT @FechaEmision = DATEADD(month, 1,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 3  SELECT @FechaEmision = DATEADD(month, 2,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 4  SELECT @FechaEmision = DATEADD(month, 3,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 5  SELECT @FechaEmision = DATEADD(month, 4,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 6  SELECT @FechaEmision = DATEADD(month, 5,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 7  SELECT @FechaEmision = DATEADD(month, 6,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 8  SELECT @FechaEmision = DATEADD(month, 7,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 9  SELECT @FechaEmision = DATEADD(month, 8,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 10 SELECT @FechaEmision = DATEADD(month, 9,  Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 11 SELECT @FechaEmision = DATEADD(month, 10, Convert(datetime, @FechaBase, 103)) ELSE
		IF @Periodo = 12 SELECT @FechaEmision = DATEADD(month, 11, Convert(datetime, @FechaBase, 103))

		SELECT @TC = TipoCambio FROM Mon WHERE Moneda = @Moneda

		INSERT INTO Gasto(Empresa, Mov, FechaEmision, Moneda, TipoCambio, Usuario, Estatus, Acreedor, Clase, SubClase, SubModulo, Sucursal)
			VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TC, @Usuario, 'CONFIRMAR', @AcreedorDef, @Clase, @SubClase, 'GAS', @Sucursal)

		SELECT @ID = SCOPE_IDENTITY()

			DECLARE crGastoPresupuestoAuto2 CURSOR STATIC FOR
			SELECT g.Concepto, g.Cantidad, g.Importe, g.ContUso, g.Impuestos, c.InflacionPresupuesto, c.PorcentajeDeducible
			  FROM #GastoPresupuestoAuto g, Concepto c
			 WHERE g.Concepto = c.Concepto
			   AND g.Moneda = @Moneda
			   AND c.Clase = @Clase AND c.SubClase = @SubClase
			   AND c.Modulo = 'GAS' AND c.CalcularPresupuesto = 1
			   AND ISNULL(c.InflacionPresupuesto,0) >= 0
			   AND g.Periodo = @Periodo
			   AND g.Sucursal = @Sucursal

			OPEN crGastoPresupuestoAuto2
			FETCH NEXT FROM crGastoPresupuestoAuto2 INTO @Concepto, @Cantidad, @Importe, @CentroCostos, @Impuestos, @Inflacion, @PD
			WHILE @@FETCH_STATUS = 0 AND @@ERROR = 0
				BEGIN

				IF ISNULL(@Inflacion,0) = 0 AND ISNULL(@SubClase,'') <> ''
					BEGIN
						SELECT @InflacionSubClase = InflacionPresupuesto FROM SubClase WHERE SubClase = @SubClase AND Clase = @Clase AND Modulo = 'GAS'
						IF ISNULL(@InflacionSubClase,0) <> 0
							SELECT @Inflacion = @InflacionSubClase
					END
				
				SELECT @Importe = @Importe*(1+(ISNULL(@Inflacion,0)/100))
				SELECT @Impuestos = @Impuestos*(1+(ISNULL(@Inflacion,0)/100))

				INSERT INTO GastoD(ID, Renglon, Concepto, Cantidad, Precio, Importe, Impuestos, PorcentajeDeducible, Contuso)
				VALUES(@ID, @Renglon, @Concepto, @Cantidad, @Importe/@Cantidad, @Importe, @Impuestos, @PD, @CentroCostos)

				SELECT @Renglon = @Renglon + 1024, @Contador = @Contador + 1

				FETCH NEXT FROM crGastoPresupuestoAuto2 INTO @Concepto, @Cantidad, @Importe, @CentroCostos, @Impuestos, @Inflacion, @PD
				END

			CLOSE crGastoPresupuestoAuto2
			DEALLOCATE crGastoPresupuestoAuto2
		
		FETCH NEXT FROM crGastoPresupuestoAuto INTO @Moneda, @Periodo, @Sucursal, @Clase, @SubClase, @Acreedor
	END

CLOSE crGastoPresupuestoAuto
DEALLOCATE crGastoPresupuestoAuto

IF @@ERROR = 0
BEGIN
	COMMIT TRANSACTION
	SELECT 'Proceso Concluido ' + RTRIM(@Contador) + ' Conceptos Generados'
END
ELSE
BEGIN
	ROLLBACK TRANSACTION
	SELECT 'Error Durante la Ejecución del Proceso'
END
 
RETURN
END
GO

-- xpVentaPresupuestoAuto 'DEMO', 2007, 1, 12, 'DEMO'
/**************** xpVentaPresupuestoAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpVentaPresupuestoAuto') and type = 'P') drop procedure dbo.xpVentaPresupuestoAuto
GO
CREATE PROCEDURE xpVentaPresupuestoAuto
		@Empresa	char(5),
		@Ejercicio	int,
		@PeriodoD	int,
		@PeriodoA	int,
		@Usuario	char(10)

AS
BEGIN
  DECLARE
    @ID					int,
    @Mov				char(20),
    @Periodo				int,
    @FechaBase				char(11),
    @FechaEmision			datetime,
    @Almacen				char(10),
    @Articulo				char(20),
    @SubCuenta				char(20),
    @Moneda				char(10),
    @Categoria				char(50),
    @Grupo				char(50),
    @TipoCambio				float,
    @Cantidad				float,  
    @Importe				money,
    @CentroCostos			char(20),
    @Impuesto1				float,
    @Impuesto2				float,
    @Impuesto3				float,
    @Inflacion				money,
    @InflacionGrupo			money,
    @Contador				int,
    @Renglon				float,
    @Sucursal				int,
    @VentaPreciosImpuestoIncluido	bit

  CREATE TABLE #VentaPresupuestoAuto(
  Categoria		char(50)	COLLATE Database_Default NULL,
  Grupo			char(50)	COLLATE Database_Default NULL,
  Periodo		int		NULL,
  Sucursal		int		NULL,
  Almacen		char(10)	COLLATE Database_Default NULL,
  Articulo		char(20)	COLLATE Database_Default NULL,
  SubCuenta		char(20)	COLLATE Database_Default NULL,
  Moneda		char(10)	COLLATE Database_Default NULL,
  Cantidad		float		NULL,
  Importe		money		NULL,
  ContUso		char(20)	COLLATE Database_Default NULL,
  Impuesto1		money		NULL,
  Impuesto2		money		NULL,
  Impuesto3		money		NULL,
  Inflacion		float		NULL)
	
  SELECT @Renglon = 1024

  SELECT @Mov = VentaPresupuesto
    FROM EmpresaCfgMov WHERE Empresa = @Empresa

  SELECT @VentaPreciosImpuestoIncluido = VentaPreciosImpuestoIncluido 
    FROM EmpresaCfg 
   WHERE Empresa = @Empresa
/*
  IF Exists(SELECT * FROM Venta e, MovTipo m WHERE e.Mov = m.Mov AND m.Modulo = 'VTAS' AND m.Clave = 'VTAS.PR'
	   AND e.Empresa = @Empresa AND e.Estatus in ('SINAFECTAR', 'CONCLUIDO', 'CONFIRMAR')
	   AND DATEPART(month, e.FechaEmision) = @Periodo AND DATEPART(year, e.FechaEmision) = @Ejercicio)
  BEGIN
    SELECT 'Ya Existen Presupuestos en la Empresa en el Periodo y Ejercicio'
    RETURN
  END
*/
  BEGIN TRANSACTION

  SELECT @FechaBase = '1/1/' + RTRIM(@Ejercicio)

  IF NOT EXISTS(SELECT * FROM Cte WHERE Cliente = 'PRESUP')
    INSERT INTO Cte(Cliente, Nombre, Estatus, Tipo)
 	VALUES('PRESUP', 'Presupuesto', 'ALTA', 'Provision')

  INSERT INTO #VentaPresupuestoAuto(Categoria, Grupo, Periodo, Sucursal, Almacen,             Articulo,          SubCuenta,        Moneda, Cantidad, 		  Importe, 																																			ContUso, Impuesto1, Impuesto2, Impuesto3, Inflacion)
  SELECT a.Categoria, a.Grupo, DATEPART(month, e.FechaEmision), e.SucursalVenta, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), e.Moneda, SUM(d.Cantidad*m.Factor), SUM((1-(ISNULL(e.DescuentoGlobal,0)/100))*(d.Precio*(d.Cantidad))*((1-(case d.DescuentoTipo when '$' then (ISNULL(d.DescuentoLinea, 0.0)/d.Precio)*100 else ISNULL(d.DescuentoLinea,0.0) end)/100))/(1.0+((CASE @VentaPreciosImpuestoIncluido WHEN 1 THEN d.Impuesto1 ELSE 0 END)/100.0))), d.ContUso, a.Impuesto1, a.Impuesto2, a.Impuesto3, ISNULL(a.InflacionPresupuesto, '')
    FROM Venta e, VentaD d, Art a, MovTipo m
   WHERE e.ID = d.ID
     AND d.Articulo = a.Articulo
     AND e.Mov = m.Mov AND m.Modulo = 'VTAS' AND m.Clave in ('VTAS.F','VTAS.FAR', 'VTAS.FC', 'VTAS.FG', 'VTAS.FX', 'VTAS.D', 'VTAS.DFC')
     -- Factura, Recaudacion, Consumo interno, Factura Gasto, Factura Externa, Devolucion Venta, Devolucion Consumo Interno
     AND e.Empresa = @Empresa
     AND e.Estatus = 'CONCLUIDO'
     AND DATEPART(year, e.FechaEmision) = @Ejercicio - 1 AND DATEPART(month, e.FechaEmision) BETWEEN @PeriodoD AND @PeriodoA
     AND a.CalcularPresupuesto = 1
   GROUP BY a.Categoria, a.Grupo, DATEPART(month, e.FechaEmision), e.SucursalVenta, d.Almacen, d.Articulo, ISNULL(d.SubCuenta, ''), e.Moneda, d.ContUso, a.Impuesto1, a.Impuesto2, a.Impuesto3, ISNULL(a.InflacionPresupuesto, '')

  SELECT @Contador = 0

  DECLARE crVentaPresupuestoAuto CURSOR STATIC FOR
  SELECT DISTINCT Moneda, Periodo, Sucursal, Almacen, /*Categoria, */Grupo
    FROM #VentaPresupuestoAuto

  OPEN crVentaPresupuestoAuto
  FETCH NEXT FROM crVentaPresupuestoAuto INTO @Moneda, @Periodo, @Sucursal, @Almacen, /*@Categoria, */@Grupo
  WHILE @@FETCH_STATUS = 0 AND @@ERROR = 0
  BEGIN
    IF @Periodo = 1  SELECT @FechaEmision = Convert(datetime, @FechaBase, 103) ELSE
    IF @Periodo = 2  SELECT @FechaEmision = DATEADD(month, 1,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 3  SELECT @FechaEmision = DATEADD(month, 2,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 4  SELECT @FechaEmision = DATEADD(month, 3,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 5  SELECT @FechaEmision = DATEADD(month, 4,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 6  SELECT @FechaEmision = DATEADD(month, 5,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 7  SELECT @FechaEmision = DATEADD(month, 6,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 8  SELECT @FechaEmision = DATEADD(month, 7,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 9  SELECT @FechaEmision = DATEADD(month, 8,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 10 SELECT @FechaEmision = DATEADD(month, 9,  Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 11 SELECT @FechaEmision = DATEADD(month, 10, Convert(datetime, @FechaBase, 103)) ELSE
    IF @Periodo = 12 SELECT @FechaEmision = DATEADD(month, 11, Convert(datetime, @FechaBase, 103))

    SELECT @TipoCambio = TipoCambio FROM Mon WHERE Moneda = @Moneda

    INSERT INTO Venta(Empresa,  Mov,  FechaEmision,  Moneda,  TipoCambio,  Almacen, Usuario,  Estatus,     Cliente,  Referencia, 						SucursalVenta)
              VALUES(@Empresa, @Mov, @FechaEmision, @Moneda, @TipoCambio, @Almacen, @Usuario, 'CONFIRMAR', 'PRESUP', 'Grupo: ' + RTRIM(@Grupo), @Sucursal)

    SELECT @ID = SCOPE_IDENTITY()

    DECLARE crVentaPresupuestoAuto2 CURSOR LOCAL FOR
     SELECT v.Articulo, ISNULL(v.SubCuenta, ''), SUM(v.Cantidad), SUM(v.Importe), v.ContUso, v.Impuesto1, v.Impuesto2, v.Impuesto3, v.Inflacion
       FROM #VentaPresupuestoAuto v
       LEFT OUTER JOIN ArtGrupo g ON v.Grupo = g.Grupo
      WHERE V.Moneda = @Moneda
--        AND v.Categoria = @Categoria
        AND v.Grupo = @Grupo
        AND v.Periodo = @Periodo
        AND v.Sucursal = @Sucursal
        AND v.Almacen = @Almacen
     GROUP BY v.Articulo, ISNULL(v.SubCuenta, ''), v.ContUso, v.Impuesto1, v.Impuesto2, v.Impuesto3, v.Inflacion

    OPEN crVentaPresupuestoAuto2
    FETCH NEXT FROM crVentaPresupuestoAuto2 INTO @Articulo, @SubCuenta, @Cantidad, @Importe, @CentroCostos, @Impuesto1, @Impuesto2, @Impuesto3, @Inflacion
    WHILE @@FETCH_STATUS = 0 AND @@ERROR = 0
    BEGIN
      IF ISNULL(@Inflacion,0) = 0 AND ISNULL(@Grupo,'') <> ''
      BEGIN
        SELECT @InflacionGrupo = InflacionPresupuesto FROM ArtGrupo WHERE Grupo = @Grupo
	IF ISNULL(@InflacionGrupo,0) <> 0
          SELECT @Inflacion = @InflacionGrupo
      END
				
      SELECT @Importe = @Importe*(1+(ISNULL(@Inflacion,0)/100))

      INSERT INTO VentaD(ID,  Renglon,  Almacen, Articulo, SubCuenta,               Cantidad, Precio,             Impuesto1, Impuesto2, Impuesto3, Contuso)
                 VALUES(@ID, @Renglon, @Almacen, @Articulo, ISNULL(@SubCuenta, ''), @Cantidad, @Importe/@Cantidad, @Impuesto1, @Impuesto2, @Impuesto3, @CentroCostos)

      SELECT @Renglon = @Renglon + 1024, @Contador = @Contador + 1

      FETCH NEXT FROM crVentaPresupuestoAuto2 INTO @Articulo, @SubCuenta, @Cantidad, @Importe, @CentroCostos, @Impuesto1, @Impuesto2, @Impuesto3, @Inflacion
    END

    CLOSE crVentaPresupuestoAuto2
    DEALLOCATE crVentaPresupuestoAuto2

    FETCH NEXT FROM crVentaPresupuestoAuto INTO @Moneda, @Periodo, @Sucursal, @Almacen, /*@Categoria, */@Grupo
  END

  CLOSE crVentaPresupuestoAuto
  DEALLOCATE crVentaPresupuestoAuto

  IF @@ERROR = 0
  BEGIN
    COMMIT TRANSACTION
    SELECT 'Proceso Concluido ' + RTRIM(@Contador) + ' Artículos Generados'
  END
  ELSE
  BEGIN
    ROLLBACK TRANSACTION
    SELECT 'Error Durante la Ejecución del Proceso'
  END
 
RETURN
END
GO

/**************** xpPorcentajeResidual ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPorcentajeResidual') and type = 'P') drop procedure dbo.xpPorcentajeResidual
go
CREATE PROCEDURE xpPorcentajeResidual
  			@Modulo			char(5),
  			@ID			int,
  			@PorcentajeResidual 	float	OUTPUT
AS BEGIN
  RETURN
END
go

/**************** xpTablaAmortizacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTablaAmortizacion') and sysstat & 0xf = 4) drop procedure dbo.xpTablaAmortizacion
GO             
CREATE PROCEDURE xpTablaAmortizacion
		    	@Modulo			char(5),
			@ID			int,
			@Periodo		int,
			@ImporteCapital		money	OUTPUT,
		   	@ImporteIntereses	money	OUTPUT,
			@SaldoInicial          	money	OUTPUT

AS BEGIN

  RETURN
END
GO

/**************** xpACDevengarInteresesOrdinarios ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACDevengarInteresesOrdinarios') and type = 'P') drop procedure dbo.xpACDevengarInteresesOrdinarios
GO
CREATE PROCEDURE xpACDevengarInteresesOrdinarios
		   @Modulo	char(5),
		   @ID		int,
		   @Ordinarios	money		OUTPUT,
		   @Ok		int		OUTPUT,
		   @OkRef	varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpACDevengarInteresesArrendamiento ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpACDevengarInteresesArrendamiento') and type = 'P') drop procedure dbo.xpACDevengarInteresesArrendamiento
GO
CREATE PROCEDURE xpACDevengarInteresesArrendamiento
		   @Modulo	char(5),
		   @ID		int,
		   @Ordinarios	money		OUTPUT,
		   @Ok		int		OUTPUT,
		   @OkRef	varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpGenerarAfectarCxOrigenID ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarAfectarCxOrigenID') and type = 'P') drop procedure dbo.xpGenerarAfectarCxOrigenID
GO
CREATE PROCEDURE xpGenerarAfectarCxOrigenID
		   @Modulo	char(5),
		   @ID		int,
		   @OrgenID	varchar(20)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpConsecutivo *************/
if exists (select * from sysobjects where id = object_id('dbo.xpConsecutivo') and type = 'P') drop procedure dbo.xpConsecutivo
GO
CREATE PROCEDURE xpConsecutivo
		   @Tipo		char(20),
		   @Sucursal		int,
		   @Consecutivo		varchar(20)		OUTPUT,
                   @Maximo              int,
		   @Referencia		varchar(50)		OUTPUT,
		   @Ok			int			OUTPUT,
		   @OkRef		varchar(255)		OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_60420 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_60420') and type = 'P') drop procedure dbo.xpOk_60420
GO             
CREATE PROCEDURE xpOk_60420
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_60071 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_60071') and type = 'P') drop procedure dbo.xpOk_60071
GO             
CREATE PROCEDURE xpOk_60071
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_35310 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_35310') and type = 'P') drop procedure dbo.xpOk_35310
GO             
CREATE PROCEDURE xpOk_35310
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_20600 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20600') and type = 'P') drop procedure dbo.xpOk_20600
GO             
CREATE PROCEDURE xpOk_20600
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,
			@Renglon	float, 
			@RenglonSub	int, 

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_20610 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20610') and type = 'P') drop procedure dbo.xpOk_20610
GO             
CREATE PROCEDURE xpOk_20610
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,
			@Renglon	float, 
			@RenglonSub	int, 

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpSumaAnticiposFacturados  ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSumaAnticiposFacturados') and type = 'P') drop procedure dbo.xpSumaAnticiposFacturados
GO             
CREATE PROCEDURE xpSumaAnticiposFacturados 
    		    	@Empresa        		char(5),
		    	@Usuario			char(10),
		    	@Accion				char(20),
			@Modulo				char(5),
			@ID				int,
			@MovMoneda			char(10), 
			@MovTipoCambio			float, 
			@SumaAnticiposFacturados 	money 	OUTPUT, 
			@Ok 				int		OUTPUT, 
			@OkRef 				varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpArtProv ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtProv') and sysstat & 0xf = 4) drop procedure dbo.xpArtProv
GO
CREATE PROCEDURE xpArtProv
			@Empresa		char(5), 
		    	@Accion			char(20),
		    	@Modulo			char(5),
			@ID			int,
			@Renglon		float,
			@RenglonSub		int,
                    	@MovTipo		char(20),
                    	@AlmacenTipo		char(15),
		    	@Articulo		char(20),
		    	@SubCuenta		varchar(50),
		    	@MovUnidad		varchar(50),
                    	@ArtTipo		varchar(20),
			@Factor			float,
 		        @Almacen		char(10), 
                        @Cantidad		float, 
	                @CantidadInventario	float, 
			@EsEntrada		bit, 
			@EsSalida		bit,
			@ProveedorRef		varchar(10), 
			@ArtProvCosto		float, 
			@FechaEmision		datetime,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  UPDATE ArtProv SET UltimoCosto = @ArtProvCosto, UltimaCompra = @FechaEmision WHERE Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND Proveedor = @ProveedorRef
  IF @@ROWCOUNT = 0 
    INSERT ArtProv (Articulo,  SubCuenta,              Proveedor,     UltimoCosto, UltimaCompra) 
            VALUES (@Articulo, ISNULL(@SubCuenta, ''), @ProveedorRef, @ArtProvCosto,   @FechaEmision)

  IF EXISTS(SELECT * FROM Art WHERE Articulo = @Articulo AND NULLIF(RTRIM(Proveedor), '') IS NULL)
    UPDATE Art SET Proveedor = @ProveedorRef WHERE Articulo = @Articulo
  IF NULLIF(RTRIM(@MovUnidad), '') IS NOT NULL
  BEGIN
    UPDATE ArtProvUnidad SET UltimoCosto = @ArtProvCosto, UltimaCompra = @FechaEmision WHERE Articulo = @Articulo AND SubCuenta = ISNULL(@SubCuenta, '') AND Proveedor = @ProveedorRef AND Unidad = @MovUnidad
    IF @@ROWCOUNT = 0 
      INSERT ArtProvUnidad (Articulo,  SubCuenta,              Proveedor,     Unidad,     UltimoCosto,   UltimaCompra) 
                   VALUES (@Articulo, ISNULL(@SubCuenta, ''), @ProveedorRef, @MovUnidad, @ArtProvCosto, @FechaEmision)
  END
END
GO

/**************** xpInvGenerarFinal ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvGenerarFinal') and sysstat & 0xf = 4) drop procedure dbo.xpInvGenerarFinal
GO
CREATE PROCEDURE xpInvGenerarFinal
			@Empresa		char(5), 
			@Usuario		char(10),
		    	@Accion			char(20),
		    	@Modulo			char(5),
			@ID			int,
			@IDGenerar		int,
			@GenerarEstatus		varchar(15), 

		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_40035 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_40035') and type = 'P') drop procedure dbo.xpOk_40035
GO             
CREATE PROCEDURE xpOk_40035
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

if exists (select * from sysobjects where id = object_id('dbo.xpImportarPDT') and type = 'P') drop procedure dbo.xpImportarPDT
GO             
CREATE PROCEDURE xpImportarPDT
		@Estacion	int,
		@ID		int,
		@Modulo		char(5),
		@Usuario	char(10),
		@Empresa	char(5)

AS
BEGIN
DECLARE
	@Clave		char(20),
	@Articulo	char(20),
	@Cantidad	char(100),
	@Almacen	char(10),
	@Sucursal	int,
	@Renglon	float,
	@Unidad		char(50),
	@Separador	char(1),
	@Texto		varchar(255), 
	@MonedaCosto	char(10),
	@TCCosto	money,
	@TCPrecio	money,
	@Costo		money,
	@TipoCosteo	char(20),
	@Proveedor	char(10)

	SELECT @Separador = ',' 

	IF @Modulo = 'INV' SELECT @Almacen = Almacen FROM Inv WHERE ID = @ID ELSE
	IF @Modulo = 'VTAS' SELECT @Almacen = Almacen FROM Venta WHERE ID = @ID ELSE
	IF @Modulo = 'COMS' SELECT @Almacen = Almacen, @Proveedor = ISNULL(Proveedor,'') FROM Compra WHERE ID = @ID

	DECLARE crInvImportarPDT CURSOR FOR
	SELECT RTRIM(LTRIM(Clave))
	  FROM ListaST
	 WHERE Estacion = @Estacion

	IF @Modulo = 'INV' DELETE InvD WHERE ID = @ID ELSE
	IF @Modulo = 'VTAS' DELETE VentaD WHERE ID = @ID ELSE
	IF @Modulo = 'COMS' DELETE CompraD WHERE ID = @ID

	SELECT @Renglon = 2048
	SELECT @Sucursal = Sucursal FROM UsuarioSucursal WHERE Usuario = @Usuario

OPEN crInvImportarPDT
FETCH NEXT FROM crInvImportarPDT INTO @Texto
	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC spExtraerDato @Texto OUTPUT, @Cantidad OUTPUT, @Separador
			EXEC spExtraerDato @Texto OUTPUT, @Clave OUTPUT, @Separador

			SELECT @Articulo = NULL
			SELECT @Articulo = Cuenta FROM CB WHERE Tipocuenta = 'Articulos' AND Codigo = @Clave

			IF @Articulo is not null
				BEGIN
					SELECT @Unidad = Unidad FROM Art WHERE Articulo = @Articulo
		
					IF @Modulo = 'INV'
						BEGIN
							INSERT INTO InvD(ID, Renglon, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Unidad, Factor, Sucursal)
							VALUES(@ID, @Renglon, 1, 'N', @Cantidad, @Almacen, @Articulo, @Unidad, 1, @Sucursal)
				
							SELECT @Renglon = ISNULL(@Renglon,0) + 2048
						END ELSE
					IF @Modulo = 'VTAS'
						BEGIN
							SELECT @TCPrecio = m.TipoCambio
							  FROM Art a, Mon m
							 WHERE a.Articulo = @Articulo AND a.MonedaPrecio = m.Moneda

							SELECT @TCCosto = m.TipoCambio, @MonedaCosto = a.MonedaCosto
							  FROM Art a, Mon m
							 WHERE a.Articulo = @Articulo AND a.MonedaCosto = m.Moneda

							IF (SELECT FormaCosteo FROM EmpresaCfg WHERE Empresa = @Empresa) <> 'Empresa'
								SELECT @TipoCosteo = TipoCosteo FROM Art WHERE Articulo = @Articulo
							ELSE
								SELECT @TipoCosteo = TipoCosteo FROM EmpresaCfg WHERE Empresa = @Empresa

							EXEC spVerCosto @Sucursal, @Empresa, NULL, @Articulo, '0', @Unidad, @TipoCosteo, @MonedaCosto, @TCCosto, @Costo Output

							INSERT INTO VentaD(ID, Renglon, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Precio, Impuesto1, Impuesto2, Impuesto3, Costo, Unidad, Factor, PrecioMoneda, PrecioTipoCambio, Sucursal, SucursalOrigen)
							SELECT @ID, @Renglon, 1, 'N', @Cantidad, @Almacen, a.Articulo, ISNULL(a.PrecioLista,0), ISNULL(a.Impuesto1,0), ISNULL(a.Impuesto2,0), ISNULL(a.Impuesto3,0), @Costo, a.Unidad, 1, a.MonedaPrecio, @TCPrecio, @Sucursal, @Sucursal
							  FROM Art a WHERE Articulo = @Articulo
				
							SELECT @Renglon = ISNULL(@Renglon,0) + 2048
						END ELSE
					IF @Modulo = 'COMS'
						BEGIN
							SELECT @TCCosto = m.TipoCambio, @MonedaCosto = a.MonedaCosto
							  FROM Art a, Mon m
							 WHERE a.Articulo = @Articulo AND a.MonedaCosto = m.Moneda

							SELECT @TipoCosteo = CompraCostoSugerido FROM EmpresaCfg WHERE Empresa = @Empresa

							EXEC spVerCosto @Sucursal, @Empresa, @Proveedor, @Articulo, '0', '0', @TipoCosteo, @MonedaCosto, @TCCosto, @Costo Output

							INSERT INTO CompraD(ID, Renglon, RenglonID, RenglonTipo, Cantidad, Almacen, Articulo, Costo, Impuesto1, Impuesto2, Impuesto3, Unidad, Factor, Sucursal, SucursalOrigen)
							SELECT @ID, @Renglon, 1, 'N', @Cantidad, @Almacen, @Articulo, @Costo, a.Impuesto1, a.Impuesto2, a.Impuesto3, a.UnidadCompra, 1, @Sucursal, @Sucursal
							  FROM Art a WHERE Articulo = @Articulo
				
							SELECT @Renglon = ISNULL(@Renglon,0) + 2048
						END
				END
			FETCH NEXT FROM crInvImportarPDT INTO @Texto
		END

CLOSE crInvImportarPDT
DEALLOCATE crInvImportarPDT

RETURN
END
GO

/**************** xpCRAfectarCobro ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCRAfectarCobro') and type = 'P') drop procedure dbo.xpCRAfectarCobro
GO             
CREATE PROCEDURE xpCRAfectarCobro
			@ID		int,
		    	@Accion		char(20),
			@Moneda		char(10),
			@TipoCambio	float,
			@DineroID	int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpContAutoCuentaExtra *************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAutoCuentaExtra') and type = 'P') drop procedure dbo.xpContAutoCuentaExtra
GO
CREATE PROCEDURE xpContAutoCuentaExtra
			@Modulo			varchar(5),
			@ID			int,
			@Cuenta			varchar(20),
    			@CuentaOmision		varchar(20),
			@CtaCtoTipo		varchar(20),
			@CtaCtoTipoAplica	varchar(20), 
			@CtaClase		varchar(50),
			@Articulo		varchar(20),
			@Almacen		varchar(10),
			@AlmacenTipo		varchar(20),
			@Concepto		varchar(50),
			@Contacto		varchar(10),
			@ContactoTipo		varchar(20),
                        @CtaDinero		varchar(10),
                        @CtaDineroDestino	varchar(10),
			@FormaPago		varchar(50),
			@Cta			varchar(20)	OUTPUT,
		   	@Ok			int		OUTPUT,
		   	@OkRef			varchar(255)	OUTPUT	
AS BEGIN
  RETURN
END
GO

/**************** xpContAutoCampoExtra ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAutoCampoExtra') and type = 'P') drop procedure dbo.xpContAutoCampoExtra
GO             
CREATE PROCEDURE xpContAutoCampoExtra
			@Modulo		char(5),
			@ID		int,
		    	@Renglon	float,
		    	@RenglonSub	int,
			@Campo		varchar(20),
			@Monto		money	     OUTPUT,
    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpProdSerieLoteCosto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProdSerieLoteCosto') and type = 'P') drop procedure dbo.xpProdSerieLoteCosto
GO             
CREATE PROCEDURE xpProdSerieLoteCosto
		   @Sucursal		int,
		   @Accion		char(20),
    		   @Empresa		char(5),
		   @Modulo		char(5),
		   @ID			int,
    		   @MovTipo     	char(20),		
		   @DetalleTipo		varchar(20),
		   @ProdSerieLote	varchar(50),
		   @Articulo		char(20),
		   @SubCuenta		varchar(50),
		   @ImporteNeto		money,	
		   @Moneda		char(10),
		   @Concepto		varchar(50),
		   @EnAvance		bit,
		   @CostoExtra		bit	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpIncidenciaFrecuencia ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpIncidenciaFrecuencia') and type = 'P') drop procedure dbo.xpIncidenciaFrecuencia
GO             
CREATE PROCEDURE xpIncidenciaFrecuencia
			@Numero			int,
			@Frecuencia		varchar(20), 
    			@PeriodoTipo		varchar(20), 
			@Fecha			datetime	OUTPUT,
			@Ok			int		OUTPUT,
			@OkRef			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpNominaAgregarClaveInterna ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaAgregarClaveInterna') and type = 'P') drop procedure dbo.xpNominaAgregarClaveInterna
GO             
CREATE PROCEDURE xpNominaAgregarClaveInterna
			@Ok		int		OUTPUT,
			@OkRef		varchar(255)	OUTPUT,
			@ClaveInterna	varchar(50),
			@Empresa	char(5),			
			@Personal	char(10),
			@Cantidad	float		OUTPUT,
			@Importe	money		OUTPUT,
			@Cuenta		varchar(10)	OUTPUT,
			@Vencimiento	datetime	OUTPUT,
			@Referencia	varchar(50)	OUTPUT,
			@Mov		varchar(20)	OUTPUT,
			@Concepto	varchar(50)	OUTPUT,
			@Semana		int		OUTPUT,
			@Beneficiario	varchar(100)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpAfectarOtrosModulos ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAfectarOtrosModulos') and type = 'P') drop procedure dbo.xpAfectarOtrosModulos
GO
CREATE PROCEDURE xpAfectarOtrosModulos
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
		   @OkRef			varchar(255)	OUTPUT,
           @Estacion		int 

AS BEGIN
  /*IF @Modulo = 'CE' AND @Ok IS NULL
    EXEC spCE @ID, @Modulo, @Accion, @Base, @FechaRegistro, @GenerarMov, @Usuario, @Conexion, @SincroFinal, 
              @Mov OUTPUT, @MovID OUTPUT, @IDGenerar OUTPUT, 
              @Ok OUTPUT, @OkRef OUTPUT
  ELSE*/
    SELECT @Ok = 70020, @OkRef = @Modulo 

  RETURN
END 
GO



/**************** xpArtOpcionInfo ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtOpcionInfo') and type = 'P') drop procedure dbo.xpArtOpcionInfo
GO             
CREATE PROCEDURE xpArtOpcionInfo
			@Empresa	char(5),
			@Articulo	varchar(20),
			@SubCuenta	varchar(50),
			@Referencia	varchar(50)
AS BEGIN
  DECLARE 
    @Info	varchar(8000)

  SELECT @Info = 'Información de '+@Articulo+' / ' +@SubCuenta
  SELECT 'Info' = @Info
  RETURN
END
GO

/**************** xpOpcionD ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOpcionD') and type = 'P') drop procedure dbo.xpOpcionD
GO             
CREATE PROCEDURE xpOpcionD
			@Empresa	char(5),
			@Opcion		char(1),
			@Articulo	varchar(20),
			@SubCuenta	varchar(50)
AS BEGIN
-- Aqui se pueden hacer cambios en la ayuda
  SELECT Numero, Nombre
    FROM OpcionD
   WHERE Opcion = @Opcion

-- AND SubCuenta = ???
  RETURN
END
GO


/**************** xpAccesoVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAccesoVerificar') and type = 'P') drop procedure dbo.xpAccesoVerificar
GO             
CREATE PROCEDURE xpAccesoVerificar
			@Empresa	char(5), 
			@Sucursal	int, 
			@Usuario	char(10), 
			@Estacion	int, 	
			@FechaTrabajo	datetime
AS BEGIN
  DECLARE
    @Mensaje 	varchar(255)
  SELECT @Mensaje = NULL

  SELECT 'Mensaje' = @Mensaje
  RETURN
END
GO

/**************** xpContAfectarDetalleAntes  ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAfectarDetalleAntes ') and type = 'P') drop procedure dbo.xpContAfectarDetalleAntes 
GO             
CREATE PROCEDURE xpContAfectarDetalleAntes 
				@ID			int, 
				@Accion			char(20), 
				@Empresa		char(5), 
				@Sucursal		int, 
				@SucursalOrigen		int, 
				@SucursalContable	int, 
				@Usuario		char(10), 
				@FechaContable		datetime, 
				@FechaRegistro		datetime, 
				@Ok 			int		OUTPUT, 
				@OkRef 			varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO
		
-- xpCBCte 'RPU1'
/**************** xpCBCte ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCBCte') and type = 'P') drop procedure dbo.xpCBCte
GO             
CREATE PROCEDURE xpCBCte
			@Codigo		varchar(30) 
AS BEGIN
  DECLARE
    @Cliente	varchar(10)

  SELECT @Cliente = NULL
  SELECT @Cliente = Cuenta
    FROM CB
   WHERE Codigo = @Codigo AND TipoCuenta = 'Clientes'

  SELECT 'Cliente' = @Cliente
  RETURN
END
GO

/**************** xpMovInsertar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovInsertar') and type = 'P') drop procedure dbo.xpMovInsertar
GO             
CREATE PROCEDURE xpMovInsertar
			@Sucursal	int,
			@Empresa	char(5), 
			@Modulo		char(5), 
			@Mov		char(20), 
			@MovID		varchar(20), 
			@ID		int,
			@Ejercicio	int, 
			@Periodo	int, 
			@FechaRegistro	datetime, 
			@FechaEmision	datetime,
                        @Concepto	varchar(50), 
			@Proyecto	varchar(50), 
			@Moneda		char(10), 
			@TipoCambio	float,
                        @Usuario	char(10), 
			@Autorizacion	char(10), 
			@Referencia	varchar(50), 
			@DocFuente	int, 
			@Observaciones	varchar(255),
			@Turno		int	OUTPUT,
			@Integradora	bit	OUTPUT,

			@Ok		int	OUTPUT
AS BEGIN
  IF @MovID IS NOT NULL
    SELECT @Turno = MIN(Turno) FROM MovTurno WHERE CONVERT(char, getdate(), 14) > HoraD AND CONVERT(char, getdate(), 14) < HoraA
  ELSE
    SELECT @Turno = NULL

  RETURN
END
GO


/**************** xpOk_65032 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_65032') and type = 'P') drop procedure dbo.xpOk_65032
GO             
CREATE PROCEDURE xpOk_65032
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpNominaGastoClase ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpNominaGastoClase') and type = 'P') drop procedure dbo.xpNominaGastoClase
GO             
CREATE PROCEDURE xpNominaGastoClase 
			@ID		int, 
			@GastoMov	varchar(20), 
			@ReferenciaD	varchar(50), 
			@Cuenta		varchar(10), 
			@FechaA		datetime, 
			@GastoUEN	int, 
			@Clase 		varchar(50)	OUTPUT, 
			@SubClase 	varchar(50)	OUTPUT, 
    		    	@Ok             int          	OUTPUT,
    		    	@OkRef          varchar(255) 	OUTPUT
AS BEGIN
  RETURN
END
GO

-- xpProyectoGantt 8
-- xpProyectoGanttD 9
-- select * from proyecto
-- xpProyectoGantt NULL, NULL, 'R1'
/**************** xpProyectoGantt ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProyectoGantt') and type = 'P') drop procedure dbo.xpProyectoGantt
GO
CREATE PROCEDURE xpProyectoGantt
                   @ID		int,
		   @Fase	varchar(20)	= NULL,
		   @Recurso	varchar(10)	= NULL,
		   @Comparar	varchar(20)	= NULL
AS BEGIN
/*  DECLARE
    @Titulo		varchar(255),
    @DiasHabiles	varchar(20),
    @Comienzo		datetime,
    @Fin		datetime,
    @Nombre		varchar(100),
    @Zoom		int,
    @Dias		float

  SELECT @ID = NULLIF(@ID, 0), @Fase = NULLIF(NULLIF(RTRIM(@Fase), ''), '0'), @Recurso = NULLIF(NULLIF(RTRIM(@Recurso), ''), '0'), @Zoom = 15

  IF @ID IS NOT NULL
  BEGIN
    SELECT @Dias = DATEDIFF(day, Comienzo, Fin)
      FROM Proyecto
     WHERE ID = @ID
    IF @Dias <= 1 SELECT @Zoom = 12 ELSE
    IF @Dias <= 7 SELECT @Zoom = 13 ELSE
    IF @Dias <= 30 SELECT @Zoom = 14 
  END

  IF @Recurso IS NOT NULL
  BEGIN
    SELECT @DiasHabiles = 'Todos'
    SELECT @Comienzo = MIN(a.Comienzo), @Fin = MAX(a.Fin)
      FROM Act a
      JOIN ActRecurso ar ON ar.ActID = a.ID 
      JOIN Proyecto p ON p.ID = a.ProyectoID AND p.Estatus IN ('PENDIENTE', 'CONCLUIDO')
     WHERE ar.Recurso = @Recurso

    SELECT @Nombre = Nombre FROM Recurso WHERE Recurso = @Recurso
    SELECT @Titulo = 'Recurso '+@Recurso+' - '+ISNULL(@Nombre, '')
  END ELSE
  IF @Fase IS NOT NULL
  BEGIN
    SELECT @Titulo = 'Fase '+ISNULL(f.Fase, '')+' - '+ISNULL(f.Nombre, ''), @Comienzo = f.Comienzo, @Fin = f.Fin, @DiasHabiles = p.DiasHabiles
      FROM Fase f
      JOIN Proyecto p ON p.ID = f.ProyectoID
     WHERE f.ProyectoID = @ID AND f.Fase = @Fase
  END ELSE
    SELECT @Titulo = 'Proyecto - '+ISNULL(Proyecto, ''), @Comienzo = Comienzo, @Fin = Fin, @DiasHabiles = DiasHabiles
      FROM Proyecto
     WHERE ID = @ID

    SELECT @Titulo, @Comienzo, DATEADD(day, 1, @Fin), @DiasHabiles, @Zoom*/
  RETURN
END
GO

/*
 select * from act where proyectoid = 7
 select * from ProyectoLineaBase where proyectoid = 7

exec xpProyectoGanttD 8
exec xpProyectoGanttD 8, @Comparar = 'Linea Base'
*/
-- xpProyectoGanttD NULL, NULL, 'R1'
/**************** xpProyectoGanttD ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProyectoGanttD') and type = 'P') drop procedure dbo.xpProyectoGanttD
GO
/*CREATE PROCEDURE xpProyectoGanttD
                   @ID		int,
		   @Fase	varchar(20)	= NULL,
		   @Recurso	varchar(10)	= NULL,
		   @Comparar	varchar(20)	= NULL
AS BEGIN
  DECLARE
    @Proyecto	varchar(50),
    @Comienzo	datetime,
    @Fin	datetime

  SELECT @ID = NULLIF(@ID, 0), @Fase = NULLIF(RTRIM(@Fase), ''), @Recurso = NULLIF(RTRIM(@Recurso), '')
  
  IF @Recurso IS NOT NULL
    SELECT 'Actividad' = a.Fase+'/'+a.Actividad, 'Asunto' = a.Fase+'/'+a.Actividad+' - '+ISNULL(a.Asunto, ''), a.Tipo, 'TipoIcono' = t.Icono, 'Predecesora' = a.Predecesora, 'Comienzo' = dbo.fnGanttFecha(a.Comienzo), 'Fin' = dbo.fnGanttFecha(a.Fin), 'Avance' = ISNULL(a.Avance, 0), 
           'ComienzoForma' = NULL, 'FinForma' = NULL, 'Color' = f.Color,
           'Fase' = NULL, 'FaseNombre' = NULL, 'FaseComienzo' = NULL, 'FaseFin' = NULL,
           'Proyecto' = NULL, 'ProyectoComienzo' = NULL, 'ProyectoFin' = NULL
      FROM Act a
      JOIN ActRecurso ar ON ar.ActID = a.ID
      JOIN Fase f ON f.ProyectoID = a.ProyectoID AND f.Fase = a.Fase
      JOIN Proyecto p ON p.ID = f.ProyectoID AND p.Estatus IN  ('PENDIENTE', 'CONCLUIDO')
      LEFT OUTER JOIN ActividadTipo t ON t.Tipo = a.Tipo
     WHERE ar.Recurso = @Recurso
     ORDER BY a.FaseOrden, a.ActividadOrden
  ELSE BEGIN
    IF @Comparar IS NULL
    BEGIN
      SELECT @Comienzo = MIN(Comienzo),
             @Fin      = MAX(Fin)
        FROM Fase
       WHERE ProyectoID = @ID AND Fase = ISNULL(@Fase, Fase)
      SELECT 'Actividad' = a.Actividad, 'Asunto' = a.Actividad+' - '+ISNULL(a.Asunto, ''), a.Tipo, 'TipoIcono' = t.Icono, 'Predecesora' = a.Predecesora, 'Comienzo' = dbo.fnGanttFecha(a.Comienzo), 'Fin' = dbo.fnGanttFecha(a.Fin), 'Avance' = ISNULL(a.Avance, 0), 
             'ComienzoForma' = NULL, 'FinForma' = NULL, 'Color' = f.Color,
             f.Fase, 'FaseNombre' = f.Nombre, 'FaseComienzo' = dbo.fnGanttFecha(f.Comienzo), 'FaseFin' = dbo.fnGanttFecha(f.Fin),
             p.Proyecto, dbo.fnGanttFecha(@Comienzo), dbo.fnGanttFecha(@Fin)
        FROM Act a
        JOIN Fase f ON f.ProyectoID = a.ProyectoID AND f.Fase = a.Fase
        JOIN Proyecto p ON p.ID = f.ProyectoID 
        LEFT OUTER JOIN ActividadTipo t ON t.Tipo = a.Tipo
       WHERE a.ProyectoID = @ID AND a.Fase = ISNULL(@Fase, a.Fase)
       ORDER BY a.FaseOrden, a.ActividadOrden
    END ELSE
      IF UPPER(@Comparar) = 'LINEA_BASE'
      BEGIN
        SELECT @Proyecto = 'Linea Base'
        SELECT @Comienzo = MIN(Comienzo),
               @Fin      = MAX(Fin)
          FROM FaseLineaBase
         WHERE ProyectoID = @ID AND Fase = ISNULL(@Fase, Fase)
        SELECT 'Actividad' = a.Actividad, 'Asunto' = a.Actividad+' - '+ISNULL(a.Asunto, ''), a.Tipo, 'TipoIcono' = t.Icono, 'Predecesora' = a.Predecesora, 'Comienzo' = dbo.fnGanttFecha(a.Comienzo), 'Fin' = dbo.fnGanttFecha(a.Fin), 'Avance' = NULL, 
               'ComienzoForma' = NULL, 'FinForma' = NULL, 'Color' = f.Color,
               f.Fase, 'FaseNombre' = f.Nombre, 'FaseComienzo' = dbo.fnGanttFecha(f.Comienzo), 'FaseFin' = dbo.fnGanttFecha(f.Fin),
               @Proyecto, dbo.fnGanttFecha(@Comienzo), dbo.fnGanttFecha(@Fin)
          FROM ActLineaBase a
          JOIN FaseLineaBase f ON f.ProyectoID = a.ProyectoID AND f.Fase = a.Fase
          JOIN Proyecto p ON p.ID = f.ProyectoID 
          LEFT OUTER JOIN ActividadTipo t ON t.Tipo = a.Tipo
         WHERE a.ProyectoID = @ID AND a.Fase = ISNULL(@Fase, a.Fase)
         ORDER BY a.FaseOrden, a.ActividadOrden 
      END
    END

  RETURN
END*/
GO

-- select * from actividadtipo

/**************** xpSetVentaProdID ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpSetVentaProdID') and type = 'P') drop procedure dbo.xpSetVentaProdID
GO
CREATE PROCEDURE xpSetVentaProdID
                   @VentaID	int,
                   @ProdID	int
AS BEGIN
  RETURN
END
GO

/**************** xpGetVentaProdID ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGetVentaProdID') and type = 'P') drop procedure dbo.xpGetVentaProdID
GO
CREATE PROCEDURE xpGetVentaProdID
                   @VentaID	int,
                   @ProdID	int	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCuentaDineroNivelSucursal *****************/
if exists(select * from sysobjects where type = 'p' and id = object_id('dbo.xpCuentaDineroNivelSucursal')) DROP PROCEDURE xpCuentaDineroNivelSucursal
GO
CREATE PROCEDURE xpCuentaDineroNivelSucursal
                   @Empresa                    char(5),
                   @Sucursal                   int,
                   @FormaPago                  varchar(50),
                   @CtaDinero                  char(10)        OUTPUT,
                   @Ok                         int             OUTPUT,
                   @OkRef                      varchar(255)    OUTPUT
AS BEGIN

RETURN
END
GO


/**************** fxReservarJuego ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fxReservarJuego') DROP FUNCTION fxReservarJuego
GO
CREATE FUNCTION fxReservarJuego (@Empresa char(5))
RETURNS bit
AS BEGIN
  DECLARE
    @Resultado	bit
  SELECT @Resultado = 0

  RETURN (@Resultado)
END
GO

/**************** xpInvAccion *****************/
if exists(select * from sysobjects where type = 'p' and id = object_id('dbo.xpInvAccion')) DROP PROCEDURE xpInvAccion
GO
CREATE PROCEDURE xpInvAccion 
                   @Empresa      char(5),
                   @Sucursal     int,
                   @Usuario	 varchar(10), 
                   @Modulo	 char(5), 
                   @ID		 int, 
                   @MovTipo	 varchar(20), 
		   @Base	 varchar(20), 
		   @Estatus	 varchar(15), 
		   @EstatusNuevo varchar(15),  
		   @Directo	 bit, 
		   @Accion 	 varchar(20)	 OUTPUT,  
                   @Ok           int             OUTPUT,
                   @OkRef        varchar(255)    OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpPrecioMetodoCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPrecioMetodoCalc') and type = 'P') drop procedure dbo.xpPrecioMetodoCalc
GO
CREATE PROCEDURE xpPrecioMetodoCalc
			@Modulo			char(5),
		     	@ID			int,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Usuario		varchar(10),
			@Moneda			varchar(10),
			@TipoCambio		float,
			@Proveedor		varchar(10),

			@OfertaTipo		varchar(20),
			@Forma			varchar(20),
			@Metodo			varchar(50),
			@Base			varchar(20),
			@Usar			varchar(20),
			@MontoFijo		float,
			@Redondear		bit,
			@Redondeo		money,

			@Renglon		float,
			@RenglonSub		int,
			@Articulo		varchar(20), 
			@SubCuenta		varchar(50), 
			@Unidad			varchar(50), 
			@PrecioAnterior		money,
			@SucursalEsp		int, 
			@ListaModificarD	varchar(50),

			@Monto			float	OUTPUT, 
			@PrecioNuevo		money	OUTPUT
AS BEGIN

  RETURN
END
GO


/**************** xpOfertaTipoCalc ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOfertaTipoCalc') and type = 'P') drop procedure dbo.xpOfertaTipoCalc
GO
CREATE PROCEDURE xpOfertaTipoCalc
			@ID				int,
			@Empresa			varchar(5),
			@Sucursal			int,
			@Usuario			varchar(10),
			@Renglon			float,
			@RenglonSub			int,
			@OfertaTipo			varchar(20),
			@Articulo			varchar(20), 
			@SubCuenta			varchar(50), 
			@Proveedor			varchar(10), 
			@Cantidad			float, 
			@Unidad				varchar(50), 
			@CantidadInventario		float, 
			@Total				float, 
			@Monto				float,
			@Obsequio			varchar(20),
			@MovMoneda			varchar(10), 
			@MovTipoCambio			float, 
			@DescuentoGlobal		float,

			@PrecioActual 			float, 
			@Precio 			float	OUTPUT, 
			@Descuento			float	OUTPUT, 
			@Puntos				float	OUTPUT, 
			@Comision			float	OUTPUT, 
			@CantidadObsequio		float 	OUTPUT 
AS BEGIN

  RETURN
END
GO


/**************** xpOk_20620 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_20620') and type = 'P') drop procedure dbo.xpOk_20620
GO             
CREATE PROCEDURE xpOk_20620
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,
			@Renglon	float, 
			@RenglonSub	int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO


/************** xpECollaborationGenerarPedido *************/
if exists (select * from sysobjects where id = object_id('dbo.xpECollaborationGenerarPedido') and type = 'P') drop procedure dbo.xpECollaborationGenerarPedido
GO
CREATE PROCEDURE xpECollaborationGenerarPedido
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @MovEmpresa		varchar(5)	OUTPUT,
		   @MovAlmacen		varchar(10)	OUTPUT,
		   @MovCliente		varchar(10)	OUTPUT,
		   @MovEnviarA		int		OUTPUT,
		   @MovAgente		varchar(10)	OUTPUT,
		   @MovReferencia	varchar(50)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpECollaborationGenerarEntradaCompra *************/
if exists (select * from sysobjects where id = object_id('dbo.xpECollaborationGenerarEntradaCompra') and type = 'P') drop procedure dbo.xpECollaborationGenerarEntradaCompra
GO
CREATE PROCEDURE xpECollaborationGenerarEntradaCompra
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @MovEmpresa		varchar(5)	OUTPUT,
		   @MovAlmacen		varchar(10)	OUTPUT,
		   @MovCliente		varchar(10)	OUTPUT,
		   @MovEnviarA		int		OUTPUT,
		   @MovAgente		varchar(10)	OUTPUT,
		   @MovReferencia	varchar(50)	OUTPUT
AS BEGIN
  RETURN
END
GO

/************** xpECollaboration *************/
if exists (select * from sysobjects where id = object_id('dbo.xpECollaboration') and type = 'P') drop procedure dbo.xpECollaboration
GO
CREATE PROCEDURE xpECollaboration
                   @Empresa		char(5),
		   @Sucursal		int,
		   @Modulo		char(5), 
		   @ID			int, 			
		   @Estatus		char(15), 
                   @EstatusNuevo	char(15),
		   @Usuario		char(10),
		   @FechaEmision	datetime, 	
		   @FechaRegistro	datetime,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,

		   @VentaID		int,
		   @CompraID		int,
		   @CxcID		int,
		   @CxpID		int
AS BEGIN
  RETURN
END
GO

/**************** xpMovCopiarFormaAnexa *************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovCopiarFormaAnexa') and type = 'p') drop procedure dbo.xpMovCopiarFormaAnexa
GO
CREATE PROCEDURE xpMovCopiarFormaAnexa
                @Modulo                 varchar(5),
                @OID                    int,
                @DID                    int

AS BEGIN

  RETURN
END
GO

/************** xpConsecutivoAuto *************/
if exists (select * from sysobjects where id = object_id('dbo.xpConsecutivoAuto') and type = 'P') drop procedure dbo.xpConsecutivoAuto
GO
CREATE PROCEDURE xpConsecutivoAuto
		   @Sucursal		int		OUTPUT,
                   @Empresa     	char(5)		OUTPUT,
                   @Modulo		char(5)		OUTPUT,
                   @Mov      		char(20)	OUTPUT,
                   @Ejercicio	        int		OUTPUT,
                   @Periodo	        int		OUTPUT,
		   @Serie		varchar(50)	OUTPUT,
                   @MovID		varchar(20)	OUTPUT,
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @CFD			bit		OUTPUT
AS BEGIN
  RETURN
END
GO


/**************** xpOk_80000 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_80000') and type = 'P') drop procedure dbo.xpOk_80000
GO             
CREATE PROCEDURE xpOk_80000
    		    	@Empresa        char(5),
		    	@Usuario	char(10),
		    	@Accion		char(20),
			@Modulo		char(5),
			@ID		int,

    		    	@Ok             int          OUTPUT,
    		    	@OkRef          varchar(255) OUTPUT
AS BEGIN
  RETURN
END
GO



/*************** xpGenerarGastoConceptoAcreedor *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarGastoConceptoAcreedor') and type = 'P') drop procedure dbo.xpGenerarGastoConceptoAcreedor
GO             
CREATE PROCEDURE xpGenerarGastoConceptoAcreedor
			@Modulo		char(5),
			@ID		int,
			@Acreedor	char(10)	OUTPUT,
			@Concepto   	varchar(50)	OUTPUT
AS BEGIN
  RETURN
END
GO

/*************** xpGenerarAfectarCxMov *******************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarAfectarCxMov') and type = 'P') drop procedure dbo.xpGenerarAfectarCxMov
GO             
CREATE PROCEDURE xpGenerarAfectarCxMov 
			@Accion		varchar(20), 
			@ModuloAfectar	varchar(5), 
			@Empresa	varchar(5), 
			@Modulo		varchar(5), 
			@ID		int, 
			@Mov		varchar(20), 
			@MovID		varchar(20), 
			@MovTipo	varchar(20), 
			@Referencia	varchar(50), 
			@CxMov		varchar(20)	OUTPUT, 
			@CxMovID	varchar(20)	OUTPUT, 
			@Ok		int		OUTPUT, 
			@OkRef		varchar(255)	OUTPUT			
AS BEGIN
  RETURN
END
GO

/**************** xpOfertaActiva ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOfertaActiva') and type = 'P') drop procedure dbo.xpOfertaActiva
GO
CREATE PROCEDURE xpOfertaActiva
			@Empresa	varchar(5),
			@Sucursal	int,
			@FechaHora	datetime,
			@ImporteTotalMN	money,
			@ID		int, 
			@FiltroOk	bit	OUTPUT
AS BEGIN
  RETURN
END
GO


/************** xpMovTipoCFD *************/
if exists (select * from sysobjects where id = object_id('dbo.xpMovTipoCFD') and type = 'P') drop procedure dbo.xpMovTipoCFD
GO
CREATE PROCEDURE xpMovTipoCFD
			@Empresa				varchar(5),
			@Modulo					varchar(5),
			@Mov					varchar(20),
			@CFD					bit		OUTPUT,   --Cambio CFD Flexible
			@CFDFlex				bit = NULL OUTPUT --Cambio CFD Flexible
AS BEGIN

  RETURN 
END
GO

--SET ANSI_NULLS OFF
GO
/**************** xpContXFiltroAdicional ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpContXFiltroAdicional') and type = 'P') drop procedure dbo.xpContXFiltroAdicional
go
CREATE PROCEDURE xpContXFiltroAdicional
  			@Empresa	char(5),
  			@Modulo		char(5)
AS BEGIN
  DECLARE
    @Filtro	varchar(255)

  SELECT @Filtro = NULL

  -- IF @Modulo = 'CR' SELECT @Filtro = 'AND CR.Estatus="CONCLUIDO"'
  SELECT 'Filtro' = @Filtro
  RETURN
END
go

/**************** xpWebPaginaBusqueda ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpWebPaginaBusqueda') and sysstat & 0xf = 4) drop procedure dbo.xpWebPaginaBusqueda
GO
CREATE PROCEDURE xpWebPaginaBusqueda
			@SesionID	uniqueidentifier,
			@Origen		varchar(255),
			@Pagina		varchar(20),
			@Texto		varchar(255),

			@Mensaje	varchar(255)	= NULL OUTPUT
AS BEGIN
-- INSERT #Resultado (Nombre, Descripcion, Pagina,URL) SELECT * FROM abc WHERE Nombre LIKE '%'+@Texto+'%'

  RETURN
END
GO

/**************** xpIportal ****************/
-- Ultima modificacion 07/May/2009
-- Yessenia Villacis C.

if exists (select * from sysobjects where id = object_id('dbo.xpIportal') and type = 'P') drop procedure dbo.xpIportal
GO
CREATE PROCEDURE xpIportal
                  @Accion           Varchar(40) = '',
                  @Sitio			Varchar(20) = '',
                  @SesionID			Varchar(50) = '',
                  @UsuarioWeb		Varchar(50) = '',
                  @Pagina			Varchar(20) = '',
                  @Dia				Varchar(20) = '',
                  @Origen			Varchar(40) = ''

 
AS BEGIN
  DECLARE 
      @ID              VARCHAR(10),
      @Nombre_Temp            Varchar(250),
      @Descripcion_Temp       Varchar(250),
      @Html_Temp              Varchar(3500),
      @Url_Temp               Varchar(250)



--Exec xpIportal 'GUID','','',''
IF @Accion = 'GUID'
BEGIN
     SELECT NEWID() 
            AS 'GUID'
END

IF @Accion = 'LOGIN'
BEGIN
     SELECT * FROM WebUsuario 
     Where Estatus='ALTA' 
     --and UPPER(UsuarioWeb) = UPPER(@UsuarioWeb) and (UPPER(Contrasena) = @Origen or Contrasena = @Origen)
     and UPPER(UsuarioWeb) = UPPER(@UsuarioWeb) and (UPPER(Contrasena) = @Origen or Contrasena = @Origen OR UPPER(Contrasena) = UPPER(@Dia))
END

--Exec xpIportal 'ENCABEZADOPIE','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMO'
IF @Accion = 'ENCABEZADOPIE'
BEGIN
     SELECT EncabezadoHTML, PieHTML
          FROM    WebSitio
       WHERE      Estatus = 'ALTA'
            AND Sitio = @Sitio
END


IF @Accion = 'OLVIDOPASSWORD'
BEGIN
        SELECT  *
        FROM WebSitio 
         INNER  JOIN WebPagina ON WebSitio.PaginaOlvidoclave = WebPagina.Pagina 
         WHERE  (WebSitio.Sitio = @Sitio) 
            AND (WebSitio.Estatus = 'ALTA') 
            AND (WebPagina.Estatus = 'ALTA') 
END

--Exec xpIportal 'INICIO','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMO'
IF @Accion = 'INICIO'
BEGIN
        SELECT    *
          FROM    WebSitio
       WHERE      Estatus = 'ALTA'
            AND Sitio = @Sitio
END

--Exec xpIportal 'MENU','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS',''
--Exec xpIportal 'MENU','DESARROLLO','36cb582f-358f-4985-b99a-f31483264483','ANONIMOS'
--SELECT * FROM WEBPAGINA WHERE PAGINA = '500'
IF @Accion = 'MENU'
BEGIN
        SELECT  WebSitio.Sitio, WebSitioD.Referencia, WebSitioD.EsGrupo, WebSitioD.MenuPosicion, WebSitioD.Orden, 
                WebSitioD.Pagina, WebSitioD.Nombre, WebPagina.Descripcion,WebPagina.Tipo, WebPagina.TieneParametros,
				WebPagina.ModoVentana, WebPagina.CatalogoRama, WebPagina.CatalogoClasificacion,WebPagina.TipoClasificacion, 
				WebPagina.CatalogoSP, WebPagina.SP , WebSitio.AnchoMenuEncabezado, WebSitio.AnchoMenuCuerpo, 
				WebSitio.AnchoMenuPie, 
				CASE LEN(WebPagina.Icono) 
				WHEN 0 THEN ''
				ELSE WebPagina.Icono 
				END	AS 'Icono'
				--WebSitio.URL_Documentos + WebPagina.Icono AS 'Icono'
          FROM  WebSitioD 
         INNER  JOIN WebPagina ON WebSitioD.Pagina = WebPagina.Pagina 
         INNER  JOIN WebSitio ON WebSitioD.Sitio = WebSitio.Sitio 
         INNER  JOIN WebPaginaAcceso ON WebSitioD.Pagina = WebPaginaAcceso.Pagina
         WHERE       (WebSitio.Estatus = 'ALTA') 
                     AND (WebSitio.Sitio = @Sitio) 
                     AND (WebPagina.Estatus = 'ALTA') 
                     AND (WebPaginaAcceso.Rol = @UsuarioWeb) 
                     AND (WebPagina.ControlAcceso = 1)
                     AND (WebSitioD.MenuPosicion<>'')
         ORDER  BY WebSitioD.Orden
END

--Exec xpIportal 'PAGINA','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','206'
IF @Accion = 'PAGINA'
BEGIN
        SELECT  *
          FROM  WebSitioD
         INNER  JOIN WebPagina ON WebSitioD.Pagina = WebPagina.Pagina 
         INNER  JOIN WebPaginaAcceso ON WebSitioD.Pagina = WebPaginaAcceso.Pagina 
         INNER  JOIN WebSitio ON WebSitioD.Sitio = WebSitio.Sitio
         WHERE       (WebSitioD.Sitio = @Sitio) 
                     AND (WebPaginaAcceso.Rol = @UsuarioWeb) 
                     AND (WebSitio.Estatus = 'ALTA') 
                     AND (WebPagina.Estatus = 'ALTA') 
                     AND (WebPagina.Pagina = @Pagina)            
END

--Exec xpIportal 'BLOGCOMENTARIOS','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','25'
IF @Accion = 'BLOGCOMENTARIOS'
BEGIN
        SELECT WebPaginaBlog.UsuarioWeb, WebPaginaBlog.Comentarios , WebPaginaBlog.Fecha, WebPaginaBlog.URL, WebPaginaBlog.Calificacion
          FROM WebPagina 
         INNER JOIN WebPaginaBlog ON WebPagina.Pagina = WebPaginaBlog.Pagina
         WHERE (WebPagina.Pagina = @Pagina) 
               AND (WebPagina.Estatus = 'ALTA') 
               AND (WebPagina.Tipo = 'Blog')
               --AND (WebPaginaBlog.UsuarioWeb = @UsuarioWeb)
         ORDER BY WebPaginaBlog.Fecha DESC
END


--Exec xpIportal 'BLOGCUENTA','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','25'
IF @Accion = 'BLOGCUENTA'
BEGIN
        SELECT COUNT(Pagina) 
          FROM WebPaginaBlog
         WHERE Pagina = @Pagina
END

--Exec xpIportal 'CALENDARIO','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','13'
IF @Accion = 'CALENDARIO'
BEGIN
        SELECT WebPaginaCalendario.RID, WebPaginaCalendario.Asunto, WebPaginaCalendario.Ubicacion, 
               dbo.fnFormatDateTime(WebPaginaCalendario.Comienzo, 'MM/DD/YYYY') + ' ' + dbo.fnFormatDateTime(WebPaginaCalendario.Comienzo, 'HH:MM 24') as Comienzo,
               dbo.fnFormatDateTime(WebPaginaCalendario.Fin, 'MM/DD/YYYY') + ' ' + dbo.fnFormatDateTime(WebPaginaCalendario.Fin, 'HH:MM 24') as Fin,  
               WebPaginaCalendario.TodoElDia, 
               WebPaginaCalendario.Comentarios, WebPaginaTipoEvento.Numero as TipoCita, 
               WebPaginaCalendario.TipoEvento, WebPaginaTipoEvento.Color
          FROM WebPaginaTipoEvento INNER JOIN WebPaginaCalendario ON WebPaginaTipoEvento.Tipo = WebPaginaCalendario.TipoEvento
         WHERE Pagina = @Pagina
END


--Exec xpIportal 'HORAS','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','56', '22/10/2007'
IF @Accion = 'HORAS'
BEGIN
        SELECT Asunto, Ubicacion,  
               dbo.fnFormatDateTime(Comienzo, 'DD/MM/YYYY') as Comienzo, 
               dbo.fnFormatDateTime(Comienzo, 'HH:MM 24') as Hora_Comienzo, 
               dbo.fnFormatDateTime(Fin, 'DD/MM/YYYY') as Fin, 
               dbo.fnFormatDateTime(Fin, 'HH:MM 24') as Hora_Fin, 
               TodoElDia, Comentarios 
          FROM WebPaginaCalendario
         WHERE Pagina = @Pagina
               AND dbo.fnFormatDateTime(Comienzo, 'DD/MM/YYYY')= @Dia
END

--Exec xpIportal 'VISTA','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','202', '22/10/2007'
IF @Accion = 'VISTA'
BEGIN
        SELECT Vista, Datos 
          FROM WebPaginaVista
         WHERE Pagina = @Pagina
END

--Exec xpIportal 'DOCUMENTOS','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','206'
--MODIFICADO - 17-Junio-2009
--David Ongay
IF @Accion = 'DOCUMENTOS'
BEGIN
	IF (@Origen <> 0)
        SELECT  @Pagina AS Pagina, 1 AS Orden, Nombre, Descripcion, Archivo
          FROM WebSitioDoc
         WHERE  Documento = @Origen
	ELSE
        SELECT WebPaginaDoc.Pagina, WebPaginaDoc.Orden, WebSitioDoc.Nombre, WebSitioDoc.Descripcion, WebSitioDoc.Archivo
          FROM WebPaginaDoc
               INNER JOIN WebSitioDoc ON WebPaginaDoc.Documento = WebSitioDoc.Documento
         WHERE WebPaginaDoc.PAGINA = @Pagina
         ORDER BY WebPaginaDoc.ORDEN
END

--Exec xpIportal 'METODO','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','206','DIA','ORIGEN'
IF @Accion = 'METODO'
BEGIN
        SELECT 'FUNCIONANDO' AS UNO,'OK' AS DOS
END

--Exec xpIportal 'BUSQUEDA','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','206','BL','ORIGEN'
IF @Accion = 'BUSQUEDA'
BEGIN
        SELECT * FROM WEBPAGINA 
		WHERE Descripcion LIKE @Dia +'%'
END

--Exec xpIportal 'WIKIINICIO','PRINCIPAL','07878e45-878d-4b67-acfe-c85c5e2549c9','ANONIMOS','252','','0'
--Exec xpIportal 'WIKIINICIO','PRINCIPAL','07878e45-878d-4b67-acfe-c85c5e2549c9','ANONIMOS','252','','3'
IF @Accion = 'WIKIINICIO'
BEGIN
	IF @Origen != '0'
		BEGIN
			SELECT WikiPagina.Pagina, WikiPagina.PaginaID, WikiPagina.Titulo, WikiPagina.FechaModificacion, WikiPagina.Autor, UsuariosWeb.Nombre, WikiPagina.CategoriaID, 
				   WikiCategoria.Descripcion, WikiPagina.Discusiones
			  FROM WikiPagina AS WikiPagina INNER JOIN
				   WikiCategoria AS WikiCategoria ON WikiPagina.CategoriaID = WikiCategoria.CategoriaID INNER JOIN
				   WebUsuario AS UsuariosWeb ON UsuariosWeb.UsuarioWeb = WikiPagina.Autor
			 WHERE (WikiPagina.CategoriaID = CONVERT(varchar, @Origen)) AND (WikiPagina.Estado = 'ALTA')
		END
	ELSE
	BEGIN
			SELECT WikiPagina.Pagina, WikiPagina.PaginaID, WikiPagina.Titulo, WikiPagina.FechaModificacion, WikiPagina.Autor, UsuariosWeb.Nombre, WikiPagina.CategoriaID, 
				   WikiCategoria.Descripcion, WikiPagina.Discusiones
			  FROM WikiPagina AS WikiPagina INNER JOIN
				   WikiCategoria AS WikiCategoria ON WikiPagina.CategoriaID = WikiCategoria.CategoriaID INNER JOIN
				   WebUsuario AS UsuariosWeb ON UsuariosWeb.UsuarioWeb = WikiPagina.Autor
			 WHERE WikiPagina.Estado = 'ALTA'
	END
END


--Exec xpIportal 'WIKIINFOPAGINA','PRINCIPAL','9d1925b7-a9cc-4f26-8ba6-e2212b0fdc69','ANONIMOS','252','12','27' --CON HISTORIA 

IF @Accion = 'WIKIINFOPAGINA'
BEGIN
 IF @Dia='0'
	BEGIN
		SELECT WikiPagina.PaginaID,  WikiPagina.Titulo,  WikiPagina.Mensaje,  WikiPagina.FechaModificacion,  WikiPagina.Autor, 
		   WebUsuario.Nombre,  WikiPagina.CategoriaID,  WikiCategoria.Descripcion,  WikiPagina.Discusiones
		FROM   WikiCategoria INNER JOIN
			   WikiPagina ON  WikiCategoria.CategoriaID =  WikiPagina.CategoriaID INNER JOIN
			   WebUsuario ON  WikiPagina.Autor =  WebUsuario.UsuarioWeb
		WHERE Pagina=@Pagina and PaginaID=@Origen AND WikiPagina.Estado='ALTA'	
	END
 ELSE
    BEGIN
		SELECT WikiPaginaHistoria.PaginaID,  WikiPaginaHistoria.Titulo,  WikiPaginaHistoria.Mensaje,  WikiPaginaHistoria.FechaModificacion,  WikiPaginaHistoria.Autor, 
		   WebUsuario.Nombre,  WikiPaginaHistoria.CategoriaID,  WikiCategoria.Descripcion,  WikiPaginaHistoria.Discusiones
		FROM   WikiCategoria INNER JOIN
			   WikiPaginaHistoria ON  WikiCategoria.CategoriaID =  WikiPaginaHistoria.CategoriaID INNER JOIN
			   WebUsuario ON  WikiPaginaHistoria.Autor =  WebUsuario.UsuarioWeb
		WHERE PaginaHistoriaID=@Dia and WikiPaginaHistoria.Estado='ALTA'
	END
END

--Exec xpIportal 'WIKIHISTORIA','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','206','BL','ORIGEN'
IF @Accion = 'WIKIHISTORIA'
BEGIN
		SELECT * 
		 FROM WikiPaginaHistoria 
		WHERE paginaID= @Origen AND
			  Pagina = @Pagina 
     ORDER BY PaginaHistoriaID DESC
END

--Exec xpIportal 'FOROS','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','258','','0'
--Exec xpIportal 'FOROS','PRINCIPAL','85d6dd4e-95ad-44f5-8e61-46951dfc03b7','int','258','','0'

IF @Accion = 'FOROS'
BEGIN
	IF (@Origen='0')
		SELECT WebPaginaForo.ID, WebPaginaForo.Pagina, WebPaginaForo.Foro, WebPaginaForo.Descripcion, WebPaginaForo.Temas, WebPaginaForo.Participaciones, 
			   WebPaginaForoComentario.ID AS 'ComentarioID', WebPaginaForoComentario.TemaID, WebPaginaForoComentario.Titulo, WebPaginaForoComentario.Usuario, 
			   WebPaginaForoComentario.Fecha AS 'FechaComentario'
		FROM  WebPaginaForoComentario INNER JOIN
			  WebPaginaForoTema ON WebPaginaForoComentario.TemaID = WebPaginaForoTema.ID RIGHT OUTER JOIN
			  WebPaginaForo ON WebPaginaForoComentario.ID = WebPaginaForo.ComentarioID
		WHERE WebPaginaForo.Estatus = 'ALTA' AND Pagina = @Pagina
	ELSE
		SELECT WebPaginaForo.ID, WebPaginaForo.Pagina, WebPaginaForo.Foro, WebPaginaForo.Descripcion, WebPaginaForo.Temas, WebPaginaForo.Participaciones, 
			   WebPaginaForoComentario.ID AS 'ComentarioID', WebPaginaForoComentario.TemaID, WebPaginaForoComentario.Titulo, WebPaginaForoComentario.Usuario, 
			   WebPaginaForoComentario.Fecha AS 'FechaComentario'
		FROM  WebPaginaForoComentario INNER JOIN
			  WebPaginaForoTema ON WebPaginaForoComentario.TemaID = WebPaginaForoTema.ID RIGHT OUTER JOIN
			  WebPaginaForo ON WebPaginaForoComentario.ID = WebPaginaForo.ComentarioID
		WHERE WebPaginaForo.Estatus = 'ALTA' AND Pagina = @Pagina
				And (FORO LIKE '%' + @Origen + '%' OR Descripcion LIKE '%' + @Origen + '%' )
END

--Exec xpIportal 'COMENTARIOSPORAPROBAR','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','INT','258','',''
IF @Accion = 'COMENTARIOSPORAPROBAR'
BEGIN
      SELECT     WebPaginaForo.ID AS IDForo,   WebPaginaForo.Foro,   WebPaginaForoTema.ID AS IDTema,   WebPaginaForoTema.Titulo AS Tema, COUNT(  WebPaginaForoComentario.ID) AS Comentarios
      FROM       WebPagina INNER JOIN
                     WebPaginaForo ON  WebPagina.Pagina =  WebPaginaForo.Pagina INNER JOIN
                     WebPaginaForoTema ON  WebPaginaForo.ID =  WebPaginaForoTema.MovID INNER JOIN
                     WebPaginaForoComentario ON  WebPaginaForoTema.ID =  WebPaginaForoComentario.TemaID INNER JOIN
                     WebUsuario ON  WebPagina.AdminPagina =  WebUsuario.eMail
      WHERE     ( WebPagina.Estatus = 'ALTA') AND ( WebPagina.Pagina = @Pagina) AND ( WebPaginaForo.Estatus = 'ALTA') AND 
                    ( WebPaginaForoComentario.Estatus = 'ALTA') AND ( WebPaginaForoComentario.Aprobado = 'False') AND 
				( WebUsuario.UsuarioWeb = @UsuarioWeb)
      GROUP BY   WebPaginaForo.ID,   WebPaginaForo.Foro,   WebPaginaForoTema.ID,   WebPaginaForoTema.Titulo
      ORDER BY WebPaginaForo.Foro
END

IF @Accion = 'MULTIPAGINAINFO'
BEGIN

        DECLARE @Estatus varchar(20)
        SELECT    @Estatus= Estatus FROM WebPagina WHERE Pagina=@Pagina
        SELECT    WebPaginaMultiPagina.Pagina, @Estatus AS 'Estatus', (Select max(fila) from WebPaginaMultiPagina where Pagina=@Pagina) as 'NumeroFilas',
                        WebPaginaMultiPagina.RID, WebPaginaMultiPagina.WebPagina, WebPagina.Nombre,WebPagina.Tipo,
                      WebPaginaMultiPagina.Fila,  WebPaginaMultiPagina.Columna,   WebPaginaMultiPagina.WebPaginaAlto, WebPaginaMultiPagina.PonerBorde,
                        WebPaginaMultiPagina.WebPaginaAncho, WebPaginaMultiPagina.VerScroll,WebPaginaMultiPagina.WebPaginaAnchoPorcentaje
        FROM      WebPaginaMultiPagina INNER JOIN
                        WebPagina ON   WebPaginaMultiPagina.WebPagina =   WebPagina.Pagina
        WHERE     WebPaginaMultiPagina.Pagina=@Pagina and @Estatus='ALTA' and WebPagina.Estatus='ALTA'
        ORDER BY  WebPaginaMultiPagina.Fila,WebPaginaMultiPagina.Columna

END

IF @Accion = 'TEMASPORAPROBAR'
BEGIN
      SELECT   WebPaginaForo.ID AS IDForo,   WebPaginaForo.Foro, COUNT(WebPaginaForoTema.ID) as 'Temas'
      FROM     WebPagina INNER JOIN
                   WebPaginaForo ON   WebPagina.Pagina =   WebPaginaForo.Pagina INNER JOIN
                   WebPaginaForoTema ON   WebPaginaForo.ID =   WebPaginaForoTema.MovID 
      WHERE    (WebPagina.Pagina = @Pagina) AND (WebPagina.Estatus = 'ALTA') AND (  WebPaginaForo.Estatus = 'ALTA') and WebPaginaForoTema.Aprobado='False'
      GROUP BY  WebPaginaForo.ID,   WebPaginaForo.Foro
END

--Exec xpIportal 'USUARIOINFO','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','INT','','',''
IF @Accion = 'USUARIOINFO'
BEGIN
      SELECT   *
      FROM     WebUsuario 
      WHERE    (WebUsuario.Estatus = 'ALTA') AND (  WebUsuario.UsuarioWeb=@UsuarioWeb)
END

--Exec xpIportal 'PORAPROBAR_PORUSUARIO','PRINCIPAL','41062d47-e567-42cb-afe7-92dd1adb327b','ANONIMOS','','',''
IF @Accion = 'PORAPROBAR_PORUSUARIO'
BEGIN
      SELECT     WebPagina.pagina,WebPaginaForo.ID AS IDForo,   WebPaginaForo.Foro,   WebPaginaForoTema.ID AS IDTema,   WebPaginaForoTema.Titulo AS Tema, COUNT(  WebPaginaForoComentario.ID) AS Comentarios
      FROM       WebPagina INNER JOIN
                     WebPaginaForo ON  WebPagina.Pagina =  WebPaginaForo.Pagina INNER JOIN
                     WebPaginaForoTema ON  WebPaginaForo.ID =  WebPaginaForoTema.MovID INNER JOIN
                     WebPaginaForoComentario ON  WebPaginaForoTema.ID =  WebPaginaForoComentario.TemaID INNER JOIN
                     WebUsuario ON  WebPagina.AdminPagina =  WebUsuario.eMail
      WHERE     ( WebPagina.Estatus = 'ALTA')  AND ( WebPaginaForo.Estatus = 'ALTA') AND 
                    ( WebPaginaForoComentario.Estatus = 'ALTA') AND ( WebPaginaForoComentario.Aprobado = 'False') AND ( WebUsuario.UsuarioWeb = @UsuarioWeb)
      GROUP BY   WebPagina.pagina,WebPaginaForo.ID,   WebPaginaForo.Foro,   WebPaginaForoTema.ID,   WebPaginaForoTema.Titulo
      ORDER BY WebPaginaForo.Foro

END
  RETURN
END
GO


/************** xpContAutoPolizaClave *************/
if exists (select * from sysobjects where id = object_id('dbo.xpContAutoPolizaClave') and type = 'P') drop procedure dbo.xpContAutoPolizaClave
GO
CREATE PROCEDURE xpContAutoPolizaClave
           @Empresa					char(5),
		   @Sucursal				int,
		   @Modulo					char(5), 
		   @ID						int, 			
		   @Mov						varchar(20),
		   @MovID					varchar(20),
		   @MovTipo					char(20),
		   @Estatus					char(15), 
           @EstatusNuevo			char(15),
		   @Usuario					char(10),
		   @FechaEmision			datetime,
		   @FechaRegistro			datetime,
           @Clave					varchar(20)     OUTPUT,
		   @Ok						int				OUTPUT,
		   @OkRef					varchar(255)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpProdExplotar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProdExplotar') and type = 'P') drop procedure dbo.xpProdExplotar
GO
CREATE PROCEDURE xpProdExplotar
			@Sucursal		int,
		 	@Empresa		char(5),
			@Usuario		char(10),
                        @Accion			char(20),
	           	@Modulo			char(5),
                        @ID			int,
			@FechaRegistro		datetime,
			@Preliminar		bit,

   		   	@Ok             	int          OUTPUT,
    		   	@OkRef          	varchar(255) OUTPUT
    		   	

AS BEGIN
	
  RETURN
END
GO

/**************** xpCalculaImporte1 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCalculaImporte1') and sysstat & 0xf = 4) drop procedure dbo.xpCalculaImporte1
GO
CREATE PROCEDURE xpCalculaImporte1
			@RedondeoMonetarios	int,
			@Importe		float	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpCalculaImporte2 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCalculaImporte2') and sysstat & 0xf = 4) drop procedure dbo.xpCalculaImporte2
GO
CREATE PROCEDURE xpCalculaImporte2
			@RedondeoMonetarios	int,
			@Importe		float	OUTPUT,
			@ImporteNeto		float	OUTPUT, 
			@DescuentoLineaImporte	float	OUTPUT, 
			@DescuentoGlobalImporte float	OUTPUT, 
			@SobrePrecioImporte	float	OUTPUT, 
			@Impuestos		float	OUTPUT, 
			@ImpuestosNetos		float	OUTPUT, 
			@Impuesto1Neto		float	OUTPUT, 
			@Impuesto2Neto		float	OUTPUT, 
			@Impuesto3Neto		float	OUTPUT,
			@Impuesto5Neto		float	OUTPUT
AS BEGIN

  RETURN
END
GO

/**************** xpProdCostearAvanceCxp ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProdCostearAvanceCxp') and type = 'P') drop procedure dbo.xpProdCostearAvanceCxp
GO             
CREATE PROCEDURE xpProdCostearAvanceCxp
		   @Sucursal		int,
		   @Accion		char(20),
		   @Empresa		char(5),
		   @Modulo		char(5),
		   @ID			int,
		   @Mov			char(20),
		   @MovID		varchar(20),
		   @MovTipo		char(20),
		   @MovMoneda		char(10),
		   @MovTipoCambio	float,
		   @FechaEmision	datetime,
		   @FechaRegistro	datetime,
		   @Usuario		char(10),
		   @Proyecto		varchar(50),
		   @Ejercicio		int,
		   @Periodo		int,
    		   @Referencia	      	varchar(50),
    		   @Observaciones     	varchar(255),
		   @Ok			int		OUTPUT,
		   @OkRef		varchar(255)	OUTPUT,
		   @Cxp			bit		OUTPUT,
		   @Proveedor		varchar(10)	OUTPUT,
		   @CxpMov		varchar(20)	OUTPUT, 
		   @Concepto		varchar(50)	OUTPUT, 
		   @Impuesto1		float		OUTPUT,
		   @Condicion		varchar(50)	OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpCxGenerarEnBorrador ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCxGenerarEnBorrador') and type = 'P') drop procedure dbo.xpCxGenerarEnBorrador
GO
CREATE PROCEDURE xpCxGenerarEnBorrador
    		   @Modulo		char(5),
			   @ID			int,
			   @CxEstatus   varchar(15)		OUTPUT
AS BEGIN
  RETURN
END
GO

/**************** xpOk_60110 ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOk_60110') and type = 'P') drop procedure dbo.xpOk_60110
GO             
CREATE PROCEDURE xpOk_60110
            @Empresa            char(5),
            @Usuario            char(10),
            @Accion             char(20),
            @Modulo             char(5),
            @ID                 int,
            @ModuloInicial      char(5),

            @Ok                 int             OUTPUT,
            @OkRef              varchar(255)    OUTPUT
AS BEGIN

  DECLARE   @ConcPolizaGenerar   bit

  SELECT @ConcPolizaGenerar = ISNULL(ConcPolizaGenerar, 0)
    FROM EmpresaCFG2
   WHERE Empresa = @Empresa


  IF @ConcPolizaGenerar = 1 AND @ModuloInicial = 'CONC'
    SELECT @Ok = NULL

  RETURN
END
GO

/**************** xpSDIFijo ****************/
if exists (SELECT * FROM sysobjects where id = object_id('dbo.xpSDIFijo') and type = 'P') drop procedure dbo.xpSDIFijo
GO             
CREATE PROCEDURE xpSDIFijo
			@Empresa   		char(5),
			@Sucursal  		int,
			@Categoria 		varchar(50),
			@Puesto			varchar(50),
			@Personal		char(10),
			@SueldoDiario  	money,
		    @SDI     		money		= NULL	OUTPUT
AS BEGIN
  DECLARE
    @AyudaTransportePct	   float
  SELECT @AyudaTransportePct = 0.0	
   -- Integrar ayuda de transporte 
   -- Si se agregan nuevos pagos que integren al SDI en la parte fija, aquí se adicionan al SDI 
	EXEC spPersonalPropValorFloat @Empresa, @Sucursal, @Categoria, @Puesto, @Personal, '% Ayuda Transporte', @AyudaTransportePct OUTPUT, @SinError = 1
	SELECT @SDI = @SDI + (@SueldoDiario * (@AyudaTransportePct/100.0))
	-- Integrar ayuda de transporte
  RETURN
END
GO

/**************** xpPoliticaPrecioTipoCambio ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPoliticaPrecioTipoCambio') and type = 'P') drop procedure dbo.xpPoliticaPrecioTipoCambio
GO
CREATE PROCEDURE xpPoliticaPrecioTipoCambio
    		   @Empresa	varchar(5),
    		   @Moneda	varchar(10)
AS BEGIN
  SELECT TipoCambio FROM Mon WHERE Moneda = @Moneda
END
GO


/**************** xpAceptarSituacion ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAceptarSituacion') and type = 'P') drop procedure dbo.xpAceptarSituacion
GO
CREATE PROCEDURE xpAceptarSituacion
			@Empresa		varchar(5),
			@Sucursal		int,
			@Estacion		int,
			@EsMovimiento		bit, 
			@Modulo			varchar(5), 
			@ModuloID		int, 
			@SituacionAnterior	varchar(50),
			@SituacionNueva		varchar(50), 
			@FechaSeguimiento	datetime, 
			@UsuarioSeguimiento	varchar(10), 
			@Comentarios		varchar(255)
AS BEGIN
  DECLARE
    @Expresion	varchar(max)

--  SELECT @Expresion = "PLUGIN('FIRMA') Si(Temp.Texto='Ok', Verdadero, Error('Firma Incorrecta') Falso)"
  SELECT 'Expresion' = @Expresion
END
GO

/**************** xpPeriodoDAOtro ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpPeriodoDAOtro') and type = 'P') drop procedure dbo.xpPeriodoDAOtro
GO             
CREATE PROCEDURE xpPeriodoDAOtro
			@PeriodoTipo	varchar(50),
			@Fecha		datetime,
			@FechaD		datetime	OUTPUT,
			@FechaA		datetime	OUTPUT,
			@Empresa	varchar(5)	= NULL
AS BEGIN
  DECLARE
    @DiasPeriodo	float

  IF @PeriodoTipo IN ('Quincenal Periodo', 'Quincenal Natural')
  BEGIN
    SELECT @DiasPeriodo = DiasPeriodo FROM PeriodoTipo WHERE PeriodoTipo = @PeriodoTipo
    SELECT @FechaD = @Fecha + 1
    SELECT @FechaA = DATEADD(DAY, @DiasPeriodo, @Fecha)
  END

  RETURN
END
GO

/**************** xpGenerarNomina ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarNomina') and type = 'P') drop procedure dbo.xpGenerarNomina
GO
CREATE PROCEDURE xpGenerarNomina
		   @Sucursal			int,
		   @Accion			char(20),
    		   @Empresa	      		char(5),
    		   @Modulo	      		char(5),
                   @ID				int,
 		   @Mov				char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
    		   @FechaAfectacion  		datetime,
    		   @FechaRegistro   		datetime,
    		   @Concepto	      		varchar(50),
    	 	   @Proyecto	      		varchar(50),
    		   @Usuario	      		char(10),
    		   @Autorizacion      		char(10),
    		   @DocFuente	      		int,
    		   @Observaciones     		varchar(255),

		   @Personal			char(10),

		   @NominaID			int		OUTPUT,
		   @NominaMov			char(20)	OUTPUT,
		   @NominaMovID			varchar(20)	OUTPUT,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT


AS BEGIN
  RETURN
END
GO

/**************** xpGenerarNominaAuto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarNominaAuto') and type = 'P') drop procedure dbo.xpGenerarNominaAuto
GO
CREATE PROCEDURE xpGenerarNominaAuto
		@Sucursal			int,
		@Accion			char(20),
		@Empresa	      		char(5),
		@Modulo	      		char(5),
		@ID				int,
		@Mov				char(20),
		@MovID             		varchar(20),
		@MovTipo     		char(20),
		@MovMoneda	      		char(10),
		@MovTipoCambio	 	float,
		@FechaAfectacion  		datetime,
		@FechaRegistro   		datetime,
		@Concepto	      		varchar(50),
		@Proyecto	      		varchar(50),
		@Usuario	      		char(10),
		@Autorizacion      		char(10),
		@DocFuente	      		int,
		@Observaciones     		varchar(255),

		@Personal			char(10),
		
		@IDGenerar			int,

		@NominaID			int		OUTPUT,
		@NominaMov			char(20)	OUTPUT,
		@NominaMovID			varchar(20)	OUTPUT,


		@Ok		            int         OUTPUT,
		@OkRef			varchar(255)	OUTPUT

AS BEGIN
  RETURN
END
GO

/**************** xpPersonalCostoEstandar ****************/
IF EXISTS (SELECT * FROM SysObjects WHERE ID = object_id('xpPersonalCostoEstandar') AND type = 'P') DROP PROCEDURE dbo.xpPersonalCostoEstandar
GO
CREATE PROCEDURE xpPersonalCostoEstandar 
             @Personal		varchar(10), 
             @CostoEstandar	money	OUTPUT
AS BEGIN
  DECLARE @Percepciones		float,
	  @CargaSocial		float,
	  @SDI			float,
	  @SueldoDiario		float,
	  @SueldoDiarioComplemento	float,
	  @SueldoDiarioAsimilado	float,
	  @Fecha		DateTime,
	  @FechaAlta		DateTime,
	  @FechaBaja		DateTime,
	  @MesActual		int,
	  @AnioActual		int,
	  @MesAnterior		int,
	  @AnioAnterior		int,
	  @DiasMes		int,
	  @DiasLibres		int,
	  @FechaD		DateTime,
	  @FechaA		DateTime,
	  @FechaMenor		DateTime,
	  @FechaMayor		DateTime,
	  @Jornada		varchar(20),
	  @HorasPromedio	float,
	  @Empresa		varchar(5),
	  @FactorEmpresa	float
	  
	 	
  SELECT @Fecha  = GETDATE ()
  
  SELECT @MesActual = MONTH(@Fecha), 
         @AnioActual = YEAR(@Fecha)
  
  -- El costo estandar se calculará sobre su nomina del mes anterior, por lo que aqui se calculan los factores
  SELECT @MesAnterior = CASE WHEN @MesActual = 1 THEN 12
			     ELSE @MesActual -1
			END,
	 @AnioAnterior = CASE WHEN @MesActual = 1 THEN @AnioActual -1
			      ELSE @AnioActual			              
			 END
    
  EXEC spDiasMes @MesAnterior, @AnioAnterior, @DiasMes OUTPUT
  EXEC spIntToDateTime 1, @MesAnterior, @AnioAnterior, @FechaD OUTPUT
  EXEC spIntToDateTime @DiasMes, @MesAnterior, @AnioAnterior, @FechaA OUTPUT
  
  SELECT @Empresa = p.Empresa,
	 @Jornada = p.Jornada,
	 @FechaAlta = p.FechaAlta,
	 @FechaBaja = p.FechaBaja,
	 @SDI = ISNULL(p.SDI, p.SueldoDiario),
	 @SueldoDiario = (ISNULL(p.SueldoDiario,0)),
	 @SueldoDiarioComplemento = (ISNULL(p.SueldoDiarioComplemento,0)),
	 @SueldoDiarioAsimilado = (ISNULL(p.SueldoDiarioAsimilable,0))
    FROM Personal p
   WHERE p.Personal = @Personal
    
  SELECT @HorasPromedio = j.HorasPromedio
    FROM Jornada j  
   WHERE j.Jornada = @Jornada    
  
  SELECT @FactorEmpresa = ec.PersonalCostoHoraFactor
    FROM EmpresaCfg ec 
  WHERE ec.Empresa = @Empresa
  
  --Aqui se determina todo lo que percibió el mes pasado
  SELECT @Percepciones = SUM(nd.Importe),
         @FechaMenor = MIN(n.FechaD),
         @FechaMayor = MAX(n.FechaA)
    FROM Nomina n
   INNER JOIN NominaD nd ON n.ID = nd.ID
			 AND n.Estatus = 'CONCLUIDO'   
			 AND nd.Movimiento = 'Percepcion' 
			 AND nd.Personal = @Personal
			 AND n.FechaA BETWEEN @FechaD AND @FechaA 
  			 
  SELECT @CargaSocial = SUM(nd.Importe)
    FROM Nomina n
   INNER JOIN NominaD nd ON n.ID = nd.ID
			 AND n.Estatus = 'CONCLUIDO'   
			 AND nd.Movimiento = 'Estadistica'
			 AND nd.Concepto IN ('Impuesto Estatal',
					     'IMSS Patron',
                                             'Infonavit',
                                             'Retiro y Cesantia')
			 AND nd.Personal = @Personal
			 AND n.FechaA BETWEEN @FechaD AND @FechaA
  
  -- Si la persona ingresó a medio mes del mes anterior, sus percepciones no se dividiran entre todo el mes sino entre la fecha que ingresó y fin de mes 
  IF @FechaAlta > @FechaMenor
    SELECT @FechaMenor = @FechaAlta

  -- Si la persona dejo de laborar a medio mes del mes anterior, sus percepciones no se dividiran entre todo el mes sino entre la fecha que ingresó y la fecha que salió
  IF @FechaBaja < @FechaMayor AND @FechaBaja > @FechaMenor
    SELECT @FechaMayor = @FechaBaja    
    
  -- Aqui se calcula los dias de la jornada que no se laboró  
  EXEC spJornadaDiasLibres @Jornada, @FechaMenor, @FechaMayor, @DiasLibres OUTPUT			 
  
  -- Se calcula el Costo Estandar x Hora
  SELECT @CostoEstandar = (((ISNULL(@Percepciones,0) + ISNULL(@CargaSocial,0)) / (DATEDIFF(dd, @FechaMenor, @FechaMayor + 1) - ISNULL(@DiasLibres, 0))) / @HorasPromedio) * ISNULL(@FactorEmpresa, 1)
  
  --Solamente Cuando la persona sea nueva y no tenga historial de nómina del mes anterior, se calcula basado en su SDI.
  IF @CostoEstandar IS NULL 
    SELECT @CostoEstandar = ((@SueldoDiario + @SueldoDiarioComplemento + @SueldoDiarioAsimilado) / @HorasPromedio) * ISNULL(@FactorEmpresa, 1)
  
-- SueldoDiario + SueldoDiarioComplemento + SueldoDiarioAsimilado
  	
END
GO	

/********** xpEcuadorValidaMascara ************/
IF EXISTS (SELECT name FROM sysobjects  WHERE name = 'xpEcuadorValidaMascara' and type = 'P') DROP PROCEDURE xpEcuadorValidaMascara
GO
CREATE PROCEDURE xpEcuadorValidaMascara
			@TipoRegistro	varchar(20),
			@Registro       varchar(50),
			@EnSilencio	bit	= 0,
			@Valido		bit 	= 1	OUTPUT  -- 1= esta bien  0= esta mal


AS BEGIN

  RETURN
END
GO

/**************** xpInvVerificarGuatemala ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpInvVerificarGuatemala') and sysstat & 0xf = 4) drop procedure dbo.xpInvVerificarGuatemala
GO             
CREATE PROCEDURE xpInvVerificarGuatemala
    		   @ID                		int,
		   @Accion			char(20),
		   @Base			char(20),
    		   @Empresa	      		char(5),
		   @Usuario			char(10),
    		   @Modulo	      		char(5),
    		   @Mov	  	      		char(20),
    		   @MovID             		varchar(20),
    		   @MovTipo     		char(20),
    		   @MovMoneda	      		char(10),
    		   @MovTipoCambio	 	float,
     	    	   @Estatus	 	      	char(15),
     	    	   @EstatusNuevo	      	char(15),
		   @FechaEmision		datetime,

		   @Ok				int		OUTPUT,
		   @OkRef			varchar(255)	OUTPUT
AS BEGIN
   DECLARE
     @EsGuatemala				int,
     @GtImporteMinimoSinRetencion		float,
     @ImporteTotal				float

     SELECT @EsGuatemala = EsGuatemala, @GtImporteMinimoSinRetencion = GtImporteMinimoSinRetencion FROM Empresa WHERE Empresa = @Empresa
     SELECT @ImporteTotal = Importe FROM Compra WHERE ID = @ID

     If @EsGuatemala = 1 AND @Modulo = 'COMS' AND @Accion = 'AFECTAR' AND @EstatusNuevo = 'CONCLUIDO'
     BEGIN
       IF @ImporteTotal >= @GtImporteMinimoSinRetencion
       BEGIN
         IF EXISTS(SELECT * FROM CompraD WHERE ID = @ID AND Retencion2 > 0)
         BEGIN
           SELECT @Ok = 20905
           SELECT @OkRef = 'El importe de retenciones excede al mínimo sin retención permitido'
         END
       END
     END
  RETURN
END
GO

/**************** xpGastoVerificarGuatemala ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGastoVerificarGuatemala') and type = 'P') drop procedure dbo.xpGastoVerificarGuatemala
GO             
CREATE PROCEDURE xpGastoVerificarGuatemala
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
		    @Estatus			char(15),
                    @Acreedor			char(10),
		    @Ok				int		OUTPUT,
		    @OkRef			varchar(255)	OUTPUT

AS BEGIN
   DECLARE
     @EsGuatemala				int,
     @GtImporteMinimoSinRetencion		float,
     @ImporteTotal				float

     SELECT @EsGuatemala = EsGuatemala, @GtImporteMinimoSinRetencion = GtImporteMinimoSinRetencion FROM Empresa WHERE Empresa = @Empresa
     SELECT @ImporteTotal = Importe FROM Gasto WHERE ID = @ID

     If @EsGuatemala = 1 AND @Modulo = 'GAS' AND @Accion = 'AFECTAR' AND @Estatus = 'CONCLUIDO'
     BEGIN
       IF @ImporteTotal >= @GtImporteMinimoSinRetencion
       BEGIN
         IF EXISTS(SELECT * FROM GastoD WHERE ID = @ID AND Retencion2 > 0)
         BEGIN
           SELECT @Ok = 20905
           SELECT @OkRef = 'El importe de retenciones excede al mínimo sin retención permitido'
         END
       END
     END
  RETURN
END
GO

/**************** xpArtOpcionInfoExp ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpArtOpcionInfoExp') and type = 'P') drop procedure dbo.xpArtOpcionInfoExp
GO            
CREATE PROCEDURE xpArtOpcionInfoExp
                  @Empresa    char(5),
                  @Articulo   varchar(20),
                  @SubCuenta  varchar(50),
                  @Referencia varchar(50)
AS BEGIN
  DECLARE
    @Exp				varchar(8000)
   
  SELECT @Exp = 'Asigna(Info.Articulo,' + CHAR(39) + @Articulo + CHAR(39) + ') ' + 
                'Forma(' + CHAR(39) + 'ArtInfo' + CHAR(39) + ')'
  
  SELECT 'Expresion' = @Exp
  RETURN
END
GO
--JGD 13Enero2011
/**************** xpRecalcularSaldoMovVigentes ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpRecalcularSaldoMovVigentes') and type = 'P') drop procedure dbo.xpRecalcularSaldoMovVigentes
GO
CREATE PROCEDURE xpRecalcularSaldoMovVigentes
		   @Modulo		char(5),
           @ID          int,
		   @DRenglon    float, --BUG22055
           @Mov			varchar(20),
           @MovID		varchar(20),
           @Personal	char(10),
           @Monto		money,
           @Saldo		money OUTPUT,
           @DID         int = NULL
AS 
BEGIN
  DECLARE 
	@MovTipo	char(20),
    @Clave		char(20),
    @Referencia varchar(50)


  SELECT @MovTipo = Clave FROM MovTipo WHERE Mov = @Mov AND Modulo = @Modulo 
  IF @Modulo = 'NOM' AND @MovTipo IN ('NOM.PD','NOM.PI')
  BEGIN
    --BUG22055
    SELECT @Monto = Monto FROM NominaCorrespondeLote WHERE IDNomina = @ID AND ID = @DID AND Comando = 'SALDO' AND Personal = @Personal AND DRenglon=@DRenglon --BUG22055
	   
    SELECT @Saldo = ISNULL(@Saldo,0) - ISNULL(@Monto,0)
  END
  RETURN
END
GO

/**************** xpAgendaAbrir ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAgendaAbrir') and type = 'P') 
  drop procedure dbo.xpAgendaAbrir
GO
CREATE PROCEDURE xpAgendaAbrir
                  @EstacionTrabajo	int
AS BEGIN
  DECLARE
    @Ok 	bit,
    @OkRef	varchar(255),
    @OkDesc	varchar(255),
    @OkTipo	varchar(50)		-- INFORMACION, ERROR, ADVERTENCIA,

  SELECT @Ok = NULL, @OkRef = NULL, @OkDesc = NULL, @OkTipo = NULL
  SELECT "Ok" = @Ok, "OkRef" = @OkRef, "OkDesc" = @OkDesc, "OkTipo" = @OkTipo
  RETURN
END
GO

-- EXEC xpAgendaAbrir @EstacionTrabajo = 59



/**************** xpAgendaAceptar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAgendaAceptar') and type = 'P') 
  drop procedure dbo.xpAgendaAceptar
GO
CREATE PROCEDURE xpAgendaAceptar
                  @EstacionTrabajo	int

AS BEGIN
  DECLARE
    @Ok 	bit,
    @OkRef	varchar(255),
    @OkDesc	varchar(255),
    @OkTipo	varchar(50)		-- INFORMACION, ERROR, ADVERTENCIA,

  SELECT @Ok = NULL, @OkRef = NULL, @OkDesc = NULL, @OkTipo = NULL
  SELECT "Ok" = @Ok, "OkRef" = @OkRef, "OkDesc" = @OkDesc, "OkTipo" = @OkTipo
  RETURN
END
GO

-- EXEC xpAgendaAceptar @EstacionTrabajo = 59



/**************** xpAgendaCancelar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAgendaCancelar') and type = 'P') 
  drop procedure dbo.xpAgendaCancelar
GO
CREATE PROCEDURE xpAgendaCancelar
                  @EstacionTrabajo	int

AS BEGIN
  DECLARE
    @Ok 	bit,
    @OkRef	varchar(255),
    @OkDesc	varchar(255),
    @OkTipo	varchar(50)		-- INFORMACION, ERROR, ADVERTENCIA,

  SELECT @Ok = NULL, @OkRef = NULL, @OkDesc = NULL, @OkTipo = NULL
  SELECT "Ok" = @Ok, "OkRef" = @OkRef, "OkDesc" = @OkDesc, "OkTipo" = @OkTipo
  RETURN
END
GO

-- EXEC xpAgendaCancelar @EstacionTrabajo = 59

/**************** xpAgendaCerrar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpAgendaCerrar') and type = 'P') 
  drop procedure dbo.xpAgendaCerrar
GO
CREATE PROCEDURE xpAgendaCerrar
                  @EstacionTrabajo	int

AS BEGIN
  DECLARE
    @Ok 	bit,
    @OkRef	varchar(255),
    @OkDesc	varchar(255),
    @OkTipo	varchar(50)		-- INFORMACION, ERROR, ADVERTENCIA,

  SELECT @Ok = NULL, @OkRef = NULL, @OkDesc = NULL, @OkTipo = NULL
  SELECT "Ok" = @Ok, "OkRef" = @OkRef, "OkDesc" = @OkDesc, "OkTipo" = @OkTipo
  RETURN
END
GO

-- EXEC xpAgendaCerrar @EstacionTrabajo = 59

/******************************* xpNotificacionPPGenerica *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpNotificacionPPGenerica') and type = 'P') drop procedure dbo.xpNotificacionPPGenerica
GO             
CREATE PROCEDURE xpNotificacionPPGenerica
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,		
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT


AS BEGIN
  -- SET nocount ON
  RETURN
END
GO

/******************************* xpNotificacionPPAutorizacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpNotificacionPPAutorizacion') and type = 'P') drop procedure dbo.xpNotificacionPPAutorizacion --AUTORIZACIONREMOTA
GO             
CREATE PROCEDURE xpNotificacionPPAutorizacion
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(20),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,		
		@GenerarNotificacion		bit = 0 OUTPUT,			    		
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT



AS BEGIN
  -- SET nocount ON
  RETURN
END
GO

/******************************* xpNotificacionPMGenerica *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpNotificacionPMGenerica') and type = 'P') drop procedure dbo.xpNotificacionPMGenerica
GO             
CREATE PROCEDURE xpNotificacionPMGenerica
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),
		@UsuarioNombre				varchar(100),				
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Asunto						varchar(255) OUTPUT,			    		
		@Mensaje					varchar(max) OUTPUT,			    				
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT



AS BEGIN
  -- SET nocount ON
    
  RETURN
END
GO

/******************************* xpNotificacionPMAutorizacion *************************************************/
if exists (select * from sysobjects where id = object_id('dbo.xpNotificacionPMAutorizacion') and type = 'P') drop procedure dbo.xpNotificacionPMAutorizacion --AUTORIZACIONREMOTA
GO             
CREATE PROCEDURE xpNotificacionPMAutorizacion
		@ID							int,
		@Modulo						varchar(5),
		@Notificacion				varchar(50),
		@NotificacionClave			varchar(50),		
		@Empresa					varchar(5),
		@Sucursal					int,
	    @UEN						int,
		@Usuario					varchar(10),
		@Mov						varchar(50),
		@Estatus					varchar(15),
		@Situacion					varchar(50),
		@Proyecto					varchar(50),		
		@ContactoTipo				varchar(20),				
		@Contacto					varchar(10),						
		@Importe					float,
		@EmpresaNombre				varchar(100),
		@SucursalNombre				varchar(100),
		@UENNombre					varchar(100),
		@UsuarioNombre				varchar(100),				
		@ContactoNombre				varchar(100),
		@FechaEmision				datetime,
		@Asunto						varchar(255) OUTPUT,			    		
		@Mensaje					varchar(max) OUTPUT,			    				
		@Ok							int = NULL OUTPUT,
		@OkRef						varchar(255) = NULL OUTPUT



AS BEGIN
  -- SET nocount ON
    
  RETURN
END
GO

/**************** xpPoliticaPrecio ****************/
/*
if exists (select * from sysobjects where id = object_id('dbo.xpPoliticaPrecio') and type = 'P') drop procedure dbo.xpPoliticaPrecio
*/
GO
/*
CREATE PROCEDURE xpPoliticaPrecio
   		   @Empresa	varchar(5),
   		   @ID		int,   		   
		   @Params	varchar(max),
		   @Precio	float
AS BEGIN

 SELECT @Precio
END
*/
GO


/********** xpFormaExtraVisible *****************/
IF EXISTS (select * from sysobjects where id = object_id('dbo.xpFormaExtraVisible') and type = 'P') drop procedure dbo.xpFormaExtraVisible
GO
CREATE PROCEDURE xpFormaExtraVisible
  @Aplica		varchar(50), 
  @Modulo 		varchar(5)	= NULL, 
  @Movimiento 	varchar(20)	= NULL, 
  @Categoria 	varchar(50)	= NULL, 
  @Grupo 		varchar(50)	= NULL, 
  @Familia 		varchar(50)	= NULL, 
  @Departamento varchar(50)	= NULL, 
  @Puesto 		varchar(50)	= NULL, 
  @SIC 			varchar(10)	= NULL,
  @Uso			varchar(50) = NULL
AS BEGIN

RETURN 
END
GO

/************** xpCambiarSituacion *************/
if exists (select * from sysobjects where id = object_id('dbo.xpCambiarSituacion') and type = 'P') drop procedure dbo.xpCambiarSituacion
GO
CREATE PROCEDURE xpCambiarSituacion
                   @Modulo              char(5),
                   @ID                  int,
                   @Situacion           char(50),
                   @SituacionFecha      datetime,
                   @Usuario             char(10),
                   @SituacionUsuario    varchar(10) = NULL,
                   @SituacionNota       varchar(100) = NULL

AS BEGIN
	-- NES: Para enviar Solicitudes IS de cambio de Situacion. Se puede modificar este xp, pero siempre incluir este llamado en algun punto
	EXEC xpeCommerceCambiarSituacion @Modulo, @ID, @Situacion, @SituacionFecha, @Usuario, @SituacionUsuario, @SituacionNota
    RETURN
END
GO

-- 'CORTE'
/**************** xpCorteD ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCorteD') and type = 'P') drop procedure dbo.xpCorteD
GO
CREATE PROC xpCorteD
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
			@CorteDesglosar		varchar(2),			
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
AS
BEGIN
  RETURN
END
GO

/**************** xpCorteDReporte ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCorteDReporte') and type = 'P') drop procedure dbo.xpCorteDReporte
GO
CREATE PROC xpCorteDReporte
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
			@CorteDesglosar		varchar(2),			
       		@Ok                	int          OUTPUT,
    		@OkRef             	varchar(255) OUTPUT
AS
BEGIN
  RETURN
END
GO

/**************** xpCorteDConsulta ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpCorteDConsulta') and type = 'P') drop procedure dbo.xpCorteDConsulta
GO
CREATE PROC xpCorteDConsulta
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
			@CorteDesglosar		varchar(2),
			@CorteFiltrarFechas	bit,
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
AS
BEGIN
  RETURN
END
GO

/************** xpCxAplicaDifMov *************/
IF EXISTS(SELECT * FROM sysobjects s WHERE s.id = OBJECT_ID('dbo.xpCxAplicaDifMov') AND s.[type] = 'P') DROP PROCEDURE dbo.xpCxAplicaDifMov
GO
CREATE PROCEDURE dbo.xpCxAplicaDifMov
    @ID                                 int,
    @AplicaDifID                        int,
    @Modulo                             char(5),
    @Accion                             char(20),
    @Base                               char(20),
    @FechaRegistro                      datetime,
    @GenerarMov                         char(20),
    @Usuario                            char(10),
    @Conexion                           bit,
    @SincroFinal                        bit,
    @Mov                                char(20)        OUTPUT,
    @MovID                              varchar(20)     OUTPUT,
    @IDGenerar                          int             OUTPUT,
    @Ok                                 int             OUTPUT,
    @OkRef                              varchar(255)    OUTPUT,
    @INSTRUCCIONES_ESP                  varchar(20)     = NULL
AS BEGIN
    RETURN
END
GO

/**************** xpIntelisisServiceProcesar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpIntelisisServiceProcesar') and type = 'P') drop procedure dbo.xpIntelisisServiceProcesar
GO
CREATE PROCEDURE xpIntelisisServiceProcesar
               @Sistema			varchar(100),
               @ID              int,
               @iSolicitud      int,
               @Solicitud		varchar(max),
               @Version			float,
               @Referencia		varchar(100),
               @SubReferencia	varchar(100),
               @Resultado		varchar(max) OUTPUT,
               @Ok              int OUTPUT,
               @OkRef			varchar(255) OUTPUT,
               @CambiarEstatus  bit = 0 OUTPUT
AS BEGIN
 
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadunidadDInsertar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadunidadDInsertar') and type = 'P') drop procedure dbo.xpOportunidadunidadDInsertar
GO
CREATE PROC xpOportunidadunidadDInsertar
			@ID			int, 
			@Plantilla	varchar(50),
			@Usuario	varchar(10),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT					
AS
BEGIN
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadPropuestaAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadPropuestaAgregar') and type = 'P') drop procedure dbo.xpOportunidadPropuestaAgregar
GO
CREATE PROC xpOportunidadPropuestaAgregar
			@ID			int, 
			@Usuario	varchar(10),
			@Sucursal	int,
			@Plantilla	varchar(20),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT					
AS
BEGIN
  RETURN
END
GO

/**************** xpOportunidadPlanPreliminarAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadPlanPreliminarAgregar') and type = 'P') drop procedure dbo.xpOportunidadPlanPreliminarAgregar
GO
CREATE PROC xpOportunidadPlanPreliminarAgregar
			@ID			int, 
			@Usuario	varchar(10),
			@Sucursal	int,
			@Plantilla	varchar(20),
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT					
AS
BEGIN
  RETURN
END
GO

/**************** xpProyectoPropuestaAgregar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpProyectoPropuestaAgregar') and type = 'P') drop procedure dbo.xpProyectoPropuestaAgregar
GO
CREATE PROC xpProyectoPropuestaAgregar
			@ID			int, 
			@Usuario	varchar(10),
			@Sucursal	int,			
			@Ok			int			 = NULL OUTPUT,
			@OkRef		varchar(255) = NULL OUTPUT					
AS
BEGIN
  RETURN
END
GO


--REQ16092
/**************** xpOportunidadVerificar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadVerificar') and type = 'P') drop procedure dbo.xpOportunidadVerificar
GO
CREATE PROCEDURE xpOportunidadVerificar
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

		    @NivelInteres		varchar(50),
		    @Plantilla			varchar(20),
		    @ContactoTipo		varchar(20),
		    @Contacto			varchar(10),
		    @ImporteOportunidad	float,
		    @PorcentajeCierre	float,
		    @ImportePonderado	float,
		    @ProbCierre			float,
		    @Competidor			varchar(50),
		    @Motivo				varchar(100),
		    @Propuesta			varchar(50),
		    @Intermediario		varchar(10),
		    @Conexion			bit,
		    @SincroFinal		bit,
		    @Sucursal			int,
    		    @Ok               		int          OUTPUT,
    		    @OkRef            		varchar(255) OUTPUT
AS
BEGIN
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadMatar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadMatar') and type = 'P') drop procedure dbo.xpOportunidadMatar
GO
CREATE PROC xpOportunidadMatar
            @Empresa		varchar(5),
            @Usuario		varchar(5),
            @FechaEmision	datetime,
            @FechaRegistro	datetime,
            @Sucursal		int,
			@ID				int, 
			@Accion			varchar(20), 
			@OrigenTipo		varchar(5), 
			@Origen			varchar(20), 
			@OrigenID		varchar(20),
			@ContactoTipo	varchar(10),
			@Contacto		varchar(20),
			@Ok				int				OUTPUT, 
			@OkRef			varchar(255)	OUTPUT
AS
BEGIN
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadOportunidadGanar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadOportunidadGanar') and type = 'P') drop procedure dbo.xpOportunidadOportunidadGanar
GO             
CREATE PROC xpOportunidadOportunidadGanar
			@Empresa			varchar(5), 
			@Usuario			varchar(10), 
			@FechaEmision		datetime, 
			@FechaRegistro		datetime, 
			@Sucursal			int, 
			@ID					int, 
			@Accion				varchar(20), 
			@OrigenTipo			varchar(5), 
			@Origen				varchar(20), 
			@OrigenID			varchar(20), 
			@ContactoTipo		varchar(20),
			@Contacto			varchar(10), 
			@Propuesta			varchar(50),
			@Plantilla			varchar(20),
			@IDPropuesta		int,		  
			@Mensaje			int				OUTPUT,
			@Ok					int				OUTPUT,
			@OkRef				varchar(255)	OUTPUT
AS
BEGIN
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadOAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadOAfectar') and type = 'P') drop procedure dbo.xpOportunidadOAfectar
GO             
CREATE PROC xpOportunidadOAfectar
			@ID                	int,

			@Accion				char(20),
			@Empresa	      	char(5),
			@Modulo	      		char(5),
			@Mov	  	      	char(20),
			@MovID             	varchar(20)	OUTPUT,
			@MovTipo     		char(20),
			@MovMoneda			char(10),
			@MovTipoCambio		float,
			@FechaEmision      	datetime,
			@FechaAfectacion    datetime,
			@FechaConclusion	datetime,

			@Proyecto	      	varchar(50),
			@Usuario	      	char(10),
			@Autorizacion      	char(10),
			@DocFuente	      	int,
			@Observaciones     	varchar(255),
			@Concepto     		varchar(50),
			@Referencia			varchar(50),

			@Estatus           	char(15),
			@EstatusNuevo	    char(15),
			@FechaRegistro     	datetime,
			@Ejercicio	      	int,
			@Periodo	      	int,
			@MovUsuario			char(10),

			@NivelInteres		varchar(50),
			@Plantilla			varchar(20),
			@ContactoTipo		varchar(20),
			@Contacto			varchar(10),
			@ImporteOportunidad	float,
			@PorcentajeCierre	float,
			@ImportePonderado	float,
			@ProbCierre			float,
			@Competidor			varchar(50),
			@Motivo				varchar(100),
			@Propuesta			varchar(50),
			@Intermediario		varchar(10),

			@Conexion			bit,
			@SincroFinal		bit,
			@Sucursal			int,
			@SucursalDestino	int,
			@SucursalOrigen		int,

			@CfgContX			bit,
			@CfgContXGenerar	char(20),
			@GenerarPoliza		bit,

			@Generar			bit,
			@GenerarMov			char(20),
			@GenerarAfectado	bit,

			@OrigenTipo			varchar(5),
			@Origen				varchar(20),
			@OrigenID			varchar(20),

			@IDGenerar			int	     	OUTPUT,	
			@GenerarMovID	  	varchar(20)	OUTPUT,

			@Mensaje			int          OUTPUT,
			@Ok                	int          OUTPUT,
			@OkRef             	varchar(255) OUTPUT


AS BEGIN
  RETURN
END
GO

--REQ16092
/**************** xpOportunidadGAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadGAfectar') and type = 'P') drop procedure dbo.xpOportunidadGAfectar
GO             
CREATE PROCEDURE xpOportunidadGAfectar
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

		    @NivelInteres		varchar(50),
		    @Plantilla			varchar(20),
		    @ContactoTipo		varchar(20),
		    @Contacto			varchar(10),
		    @ImporteOportunidad	float,
		    @PorcentajeCierre	float,
		    @ImportePonderado	float,
		    @ProbCierre			float,
		    @Competidor			varchar(50),
		    @Motivo				varchar(100),
		    @Propuesta			varchar(50),
		    @Intermediario		varchar(10),

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
AS 
BEGIN
  RETURN 
END
GO

--REQ16092
/**************** xpOportunidadAfectar ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpOportunidadAfectar') and type = 'P') drop procedure dbo.xpOportunidadAfectar
GO             
CREATE PROCEDURE xpOportunidadAfectar
    		   @ID                		int,

		   @Accion			char(20),
		   @Base			char(20),
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

		    @NivelInteres		varchar(50),
		    @Plantilla			varchar(20),
		    @ContactoTipo		varchar(20),
		    @Contacto			varchar(10),
		    @ImporteOportunidad	float,
		    @PorcentajeCierre	float,
		    @ImportePonderado	float,
		    @ProbCierre			float,
		    @Competidor			varchar(50),
		    @Motivo				varchar(100),
		    @Propuesta			varchar(50),
		    @Intermediario		varchar(10),

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
	           
	           @OrigenTipo			varchar(5),
	           @Origen				varchar(20),
	           @OrigenID			varchar(20),
	           
		   @IDGenerar			int	     	OUTPUT,	
    		   @GenerarMovID	  	varchar(20)	OUTPUT,
			   @Mensaje                	int          OUTPUT,
       		   @Ok                		int          OUTPUT,
    		   @OkRef             		varchar(255) OUTPUT

AS 
BEGIN
  RETURN
END
GO

/**************** fnIntelisisCFDIListaPAC ****************/
IF EXISTS (SELECT name FROM sysobjects WHERE name = 'fnIntelisisCFDIListaPAC') DROP FUNCTION dbo.fnIntelisisCFDIListaPAC
GO
CREATE FUNCTION dbo.fnIntelisisCFDIListaPAC 
	(
	@Empresa			varchar(5)
	)
RETURNS @Lista TABLE
        (
	Servidor		varchar(100)
        )

--//WITH ENCRYPTION
AS BEGIN
  DECLARE
    @EsGuatemala			bit
  
  SELECT @EsGuatemala = 0
--  SELECT @EsGuatemala = ISNULL(EsGuatemala,0) FROM Empresa WHERE Empresa = @Empresa
  
  IF @EsGuatemala = 0  
    INSERT @Lista (Servidor)
    SELECT 'EDICOM'
      UNION
    SELECT 'SOLUCIONFACTIBLE'
      UNION
	SELECT 'FacturaInteligente'
	UNION
    SELECT 'InvoiceOne'
    UNION
    SELECT 'FormasDigitales'
    UNION
    SELECT 'eKomercio'
    UNION
	SELECT 'Aspel'
	 UNION
    SELECT 'MASTEREDI'
      UNION
    SELECT 'FEL'
      UNION
    SELECT 'KONESH'
      UNION
    SELECT 'Levicom'
/*
     
         
      UNION
    SELECT 'FoliosDigitales'
      UNION
    SELECT 'ExpidetuFactura'
      	  
      UNION
    SELECT 'Servisim'
	  
    ELSE
    INSERT @Lista (Servidor)
    SELECT 'MYSUITEGUATEMALA'
*/  
  RETURN
END
GO

--SELECT * FROM dbo.fnIntelisisCFDIListaPAC('DEMO')


/**************** xpJuegoHeredarOpcion ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpJuegoHeredarOpcion') and type = 'P') drop procedure dbo.xpJuegoHeredarOpcion
GO
CREATE PROCEDURE xpJuegoHeredarOpcion
			@Juego		varchar(20),
			@Componente	varchar(20),
   			@SubCuenta	varchar(50)	

AS BEGIN
  SELECT @Subcuenta
  RETURN
END
GO

/**************** xpAccesoControl ****************/
if exists (select * from sysobjects where id  =  object_id('dbo.xpAccesoControl') and type  =  'P') drop procedure dbo.xpAccesoControl
GO
CREATE PROCEDURE xpAccesoControl 
       @Empresa  	char(5),
       @Sucursal 	int, 
       @Usuario 	char(10),
       @Codigo		varchar(255),
       @FechaHora 	datetime
AS BEGIN
DECLARE 
  @Color 		    char(10),
  @Mensaje  		varchar(255),
  @Personal 		char(10),
  @Vencimiento  	datetime,
  @EstaPresente 	bit,
  @HoraRegistro 	char(5),
  @Jornada      	varchar(20),
  @FechaEmision		datetime,
  @Entrada		    datetime,
  @MinEntrada		datetime,
  @SalIDa		    datetime,
  @MinutosComida 	int,
  @DiferenciaMin 	int,
  @Tolerancia       int,
  @NumRetardo       int,
  @ID               int,
  @ApellidoPaterno  varchar(30),  
  @ApellidoMaterno  varchar (30),
  @Nombre           varchar(30),
  @Retardo          int,
  @SalidaMax		datetime

  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = object_id('[dbo].[LogControlAcceso]'))
    CREATE TABLE LogControlAcceso(Personal char(10), Fecha DateTime, Mensaje varchar(255), Color char(10)) 

  SELECT @Color        = 'VERDE', 
         @Mensaje      = '',
         @Personal     = NULL,
         @Vencimiento  = NULL,
         @estapresente = NULL,
         @HoraRegistro = NULL,
         @Entrada      = NULL,
      	 @MinEntrada   = NULL, 
         @Salida       = NULL,
         @MinutosComida = 60,
         @NumRetardo	= NULL,
         @Retardo 	= 0,
         @SalidaMax      = NULL  

  SELECT @Personal        = Personal,
         @EstaPresente    = EstaPresente,
         @Vencimiento     = VencimientoContrato,
         @Jornada         = Jornada ,
         @ApellidoPaterno = ApellidoPaterno,
         @ApellidoMaterno = ApellidoMaterno,
         @Nombre          = Nombre
    FROM Personal 
   WHERE Personal = @Codigo

  IF NOT EXISTS( SELECT * FROM PersonalPropValor WHERE CUENTA = @Personal AND  Propiedad='CHEQUEO LIBRE' and Valor='1')
  BEGIN
      IF @SalidaMax IS NULL  
          SELECT  @SalidaMax = MAX(SALIDA)
            FROM VerJornadaTiempo  
           WHERE CONVERT(DateTime, FLOOR( CONVERT( float, Salida)), 103) = CONVERT(DateTime, FLOOR(CONVERT(float, @FechaHora)), 103)
             AND @Jornada = Jornada
           GROUP BY salida
           ORDER BY Salida


    IF @Codigo       =  '0999'                                    SELECT @Color = 'ROJO', @Mensaje = '', @Retardo = 0 ELSE
    IF @Personal     IS NULL                                      SELECT @Color = 'ROJO', @Mensaje = 'No existe esa clave de Personal'  ELSE 
    IF @Vencimiento  IS NOT  NULL AND @Vencimiento <= @FechaHora  SELECT @Color = 'ROJO', @Mensaje = 'Contrato Vencido'  ELSE 
    --IF @EstaPresente IS NOT  NULL AND @Estapresente <> 1 -- estaba afuera
    BEGIN
      SELECT @Tolerancia = AsisteToleraEntrada FROM EmpresaCfg WHERE Empresa = @Empresa
      SELECT @Entrada = Entrada, @Salida = Salida  
        FROM VerJornadaTiempo  
       WHERE Jornada = @Jornada
         AND @FechaHora  BETWEEN  Entrada AND Salida
      IF NOT EXISTS (SELECT TOP 1  HoraRegistro,  FechaEmision-- se checa su ultima entrada
                       FROM AsisteD d, Asiste a 
                      WHERE a.ID           = d.ID 
                        AND FechaEmision   = CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103) -- para quitar horas,min,seg
                        AND Personal       = @Personal
                        AND UPPER(REGISTRO)= 'ENTRADA' 
                        AND UPPER(Mov)     = 'REGISTRO'
                        ORDER BY a.fechaemision,d.horaregistro DESC) 
        IF @Entrada IS NULL  
          SELECT TOP 1 @Entrada = MIN(Entrada)
            FROM VerJornadaTiempo  
           WHERE CONVERT(DateTime, FLOOR( CONVERT( float, Entrada)), 103) = CONVERT(DateTime, FLOOR(CONVERT(float, @FechaHora)), 103)
             AND @Jornada = Jornada
           GROUP BY Entrada
           ORDER BY Entrada
      
      IF @Entrada IS NULL  
        SELECT @Entrada = MIN(Entrada)
          FROM VerJornadaTiempo  
         WHERE CONVERT(DateTime, FLOOR( CONVERT( float, Entrada)), 103) = CONVERT(DateTime, FLOOR(CONVERT(float, @FechaHora)), 103)
           AND @FechaHora < Entrada
           AND @Jornada = Jornada
         GROUP BY Entrada
         ORDER BY Entrada
      SELECT @Entrada = ISNULL(@Entrada, @FechaHora)    
      IF DATEDIFF(MI,@Entrada,@FechaHora) > @Tolerancia-- llego tarde segun su jornada checamos a que hora salio a comer
      BEGIN    
        SELECT TOP 1 @HoraRegistro = HoraRegistro, @FechaEmision = FechaEmision-- se checa su ultima salida
          FROM AsisteD d, Asiste a 
         WHERE a.ID           = d.ID 
           AND FechaEmision   = CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103) -- para quitar horas,min,seg
           AND Personal       = @Personal
           AND UPPER(REGISTRO)= 'SALIDA' 
           AND UPPER(Mov)     = 'REGISTRO'
         ORDER BY a.fechaemision,d.horaregistro DESC
        
        IF @HoraRegistro IS NOT NULL -- quiere decir que es su segundo chequeo del dia
        BEGIN 
         SELECT @DiferenciaMin = abs((60 * DATEPART(HOUR, @FechaHora - CONVERT(datetime,  LEFT( CONVERT(varchar, @FechaEmision, 126), 10) + 'T' + @HoraRegistro + ':00', 126) ))+ DATEPART(MI, @FechaHora - CONVERT(datetime, LEFT( CONVERT(varchar, @FechaEmision, 126), 10) + 'T' + @HoraRegistro + ':00', 126) ))
         IF @DiferenciaMin > (@MinutosComida + @Tolerancia)
           SELECT @Color = 'AMARILLO', @Mensaje = 'Este es un Retardo de comida', @Retardo = 2
        END ELSE -- es su primer chequeo del dia y llego tarde
        BEGIN
          SELECT @Color = 'AMARILLO', @Mensaje = 'Este es un Retardo'  , @Retardo = 1
          IF DATEDIFF(MI,@Entrada,@FechaHora) > 20
            SELECT @Color = 'AMARILLO', @Mensaje = 'LLegaste muy tarde.'  , @Retardo = 1
        END
      END
    END /*ELSE 
      IF  NOT (EXISTS( SELECT *  FROM VerJornadaTiempo  WHERE Jornada = @Jornada AND @FechaHora  < = Entrada
                    AND CONVERT(datetime, CONVERT(int, Entrada), 103) = CONVERT(datetime, CONVERT(int,Salida),103)
                    AND CONVERT(datetime, CONVERT(int, @FechaHora),103) = CONVERT(datetime,CONVERT(int,Entrada),103)) 
      AND EXISTS (SELECT *,convert(datetime,convert(int,entrada),103) , convert(datetime,convert(int,Salida),103) 
                    FROM VerJornadaTiempo  
                   WHERE Jornada = @Jornada
                     AND @FechaHora  >= Salida
                     AND CONVERT(datetime, floor(CONVERT(float,Entrada)),103) = CONVERT(datetime,floor(CONVERT(float,Salida)),103)
                     AND CONVERT(datetime, floor(CONVERT(float,@FechaHora)),103)  = CONVERT(datetime,floor(CONVERT(float,Salida)),103))
       )
        IF (NOT EXISTS( SELECT * FROM PersonalPropValor WHERE CUENTA = @Personal AND  Propiedad='Salida Abierta' and Valor='1')) 
            and @Fechahora  < @SalidaMax
        BEGIN
           SELECT @Color = 'ROJO', @Mensaje = 'No tienes permitido salir a esta hora'
           INSERT LogControlAcceso (Personal,fecha,mensaje,color) values (@Personal,@FechaHora,@mensaje,@color)

        END */ 
    IF @Retardo = 1 
    BEGIN
      SELECT @NumRetardo = COUNT(*) 
        FROM AsisteD d, Asiste a 
       WHERE a.ID      = d.ID 
         AND Retardo = 1      
         AND FechaEmision BETWEEN CONVERT(datetime, RIGHT('0'+RTRIM(LTRIM(CAST(MONTH(@FechaHora) AS varchar))),2) + '/01/' + LTRIM(RTRIM(CAST(YEAR(@FechaHora) AS varchar))), 101) AND @FechaHora 
         AND Personal = @Personal
      SELECT @NumRetardo = ISNULL(@NumRetardo,0) + 1

      IF @Numretardo < 3 AND @Color <> 'ROJO'
      BEGIN
         IF @Numretardo = 1 
           SELECT @Color = 'AMARILLO', @Mensaje = 'Este es el retardo numero: ' + CAST(@NumRetardo AS varchar), @Retardo=1
        IF @Numretardo = 2 
           SELECT @Color = 'AMARILLO', @Mensaje = 'Este es el retardo numero: ' + CAST(@NumRetardo AS varchar)+' Al siguiente retardo no podras Entrar', @Retardo=1
      END
      ELSE
        IF NOT EXISTS (SELECT * 
                         FROM Asiste a, Asisted d 
                        WHERE d.ID           = a.ID 
                          AND a.Mov          = 'Permiso Acceso' 
                          AND Personal       = @Personal
                          AND ESTATUS        = 'CONCLUIDO'
                          AND FechaEmision   = CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103)
                          AND @FechaHora    <= CONVERT(datetime, LEFT(CONVERT(varchar, FechaEmision, 126), 10) 
                                             + 'T' + HoraRegistro + ':00', 126))
          SELECT @Color = 'AMARILLO', @Mensaje = 'Este es tu retardo numero: ' + CAST(@NumRetardo AS varchar) + '. Se reportara a tu jefe', @Retardo = 1
        ELSE
          SELECT @Color = 'AMARILLO', @Mensaje = 'Este es tu retardo numero: ' + CAST(@NumRetardo AS varchar), @Retardo = 1
        IF EXISTS(select * FROM Personal WHERE Departamento = 'HELP DESK' AND Personal = @Personal)
        IF DATEDIFF(MI,@Entrada,@FechaHora) > @Tolerancia
           SELECT @Color = 'Rojo', @Mensaje = 'No puedes entrar Este es tu retardo numero : ' + CAST(@NumRetardo AS varchar), @Retardo = 1
    END
    IF  EXISTS (SELECT * 
                  FROM Asiste a, Asisted d 
                 WHERE d.ID           = a.ID 
                   AND a.Mov          = 'Permiso HORAS' 
                   AND Personal       = @Personal
                   AND ESTATUS        in( 'CONCLUIDO','PROCESAR')
                   AND a.TIPO            ='AUSENCIA'
                   AND FechaEmision   = CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103)
                   AND @FechaHora    BETWEEN   CONVERT(datetime, LEFT(CONVERT(varchar, FechaEmision, 126), 10) + 'T' + HoraD + ':00', 126) AND  
                                               CONVERT(datetime, LEFT(CONVERT(varchar, FechaEmision, 126), 10) + 'T' + HoraA + ':00', 126))
      SELECT @COLOR='VERDE', @Retardo = 0,@Mensaje = 'Puedes entrar'

/*  IF @Color = 'ROJO' AND @Codigo <> '0999'
  BEGIN
    INSERT INTO Asiste  (Empresa,   Mov,             FechaEmision,                                                  UltimoCambio,  Usuario,  Estatus,      Referencia,                                                Observaciones                                             )
                VALUES  (@Empresa, 'Permiso Acceso', CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103)  , @FechaHora,    @Usuario, 'SINAFECTAR', @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno, @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno )
    SELECT @ID = @@IDENTITY 
    INSERT INTO AsisteD (ID, Renglon, Personal,  Registro, HoraRegistro,                                                                                                          FechaD,                                                     FechaA                                                     )
                VALUES  (@ID, 2048.0, @Personal, 'Entrada', RIGHT('00'+Convert(varchar,DATEPART(hh,@FechaHora)),2)+':'+RIGHT('00'+Convert(varchar,DATEPART(mi,@FechaHora)+ 5),2), CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103),CONVERT(DateTime, FLOOR( CONVERT( float, @FechaHora)), 103))
  END*/
  END
  IF EXISTS (SELECT * 
               FROM ASISTED, Asiste
              WHERE ASISTED.ID = Asiste.ID 
                AND Personal   = @Personal 
                AND SUBSTRING(CONVERT(VARCHAR,@FechaHora,108),1,5) = Horaregistro
                AND  CONVERT(VARCHAR,@FechaHora,103) = CONVERT(VARCHAR,FechaEmision,103))
  SELECT @Color='Rojo', @Mensaje = 'Tienes que esperar al menos un minuto. Checado Duplicado, intenta de nuevo'

 
  SELECT "Color" = @Color, "Mensaje" = @Mensaje, "Retardo" = @Retardo
END
GO


/**************** xpServerImpresionCondicion ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpServerImpresionCondicion') and type = 'P') drop procedure dbo.xpServerImpresionCondicion
GO             
CREATE PROCEDURE xpServerImpresionCondicion
            @Empresa varchar(10),
		    @Modulo		char(5),
			@Mov		varchar(20),
			@Serie		varchar(20),
			@MovID		varchar(20),
			@Estatus	varchar(20)

AS BEGIN
DECLARE @ID int

  /*
  IF @Modulo ='VTAS' and @mOV = 'FACTURA' AND @Empresa = 'DEMO'
  BEGIN
    EXEC spMovInfo @Modulo = @Modulo, @Empresa = @Empresa, @Mov = @Mov, @MovID = @MovID, @ID = @ID OUTPUT
    EXEC xpMostrarAccion @empresa, @Mov, @ID, @Modulo, 'IMPRIMIR'
  END
  ELSE*/
    SELECT 'Imprimir' = 1

  RETURN
END
GO

/**************** xpGenerarCFDAddendaTag ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpGenerarCFDAddendaTag') and type = 'P') drop procedure dbo.xpGenerarCFDAddendaTag
GO             
CREATE PROCEDURE xpGenerarCFDAddendaTag
			@Estacion		int,
			@Modulo			char(5),
			@ID				int,
			@Layout			varchar(50),
			@EsCFDI			bit		= 0,
			@EsTagInicial	bit		= 0
AS BEGIN
/*
  IF  @Layout = 'CHEDRAUI' AND @EsCFDI = 1
  BEGIN
    IF @EsTagInicial = 1 
      SELECT  '<cfdi:Addenda>    <lev1add:EDCINVOICE xsi:schemaLocation='+char(34)+'http://www.edcinvoice.com/lev1add http://www.edcinvoice.com/lev1add/lev1add.xsd'+char(34)+' xmlns:lev1add='+char(34)+'http://www.edcinvoice.com/lev1add'+char(34)+'>'  
    ELSE  
	  SELECT '</lev1add:EDCINVOICE></cfdi:Addenda>'
  END ELSE*/
  SELECT ''
  
RETURN 
END
GO

/**************** xpTipoImpuesto ****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTipoImpuesto') and sysstat & 0xf = 4) drop procedure dbo.xpTipoImpuesto
GO             
CREATE PROCEDURE xpTipoImpuesto
			@Modulo			varchar(5),
			@ID			int,
			
			@Mov			varchar(20),
			@Fecha			datetime,
			@Empresa		varchar(5),
			@Sucursal		int,
			@Contacto		varchar(10),
			@EnviarA		int		= NULL,
			@Articulo		varchar(20)	= NULL,
			@Concepto		varchar(50)	= NULL,
			@VerTipos		bit		= 0,
			@EnSilencio		bit		= 0,
			@Impuesto1		float		= NULL	OUTPUT,
			@Impuesto2		float		= NULL	OUTPUT,
			@Impuesto3		float		= NULL	OUTPUT,
			@Retencion1		float		= NULL	OUTPUT,
			@Retencion2		float		= NULL	OUTPUT,
			@Retencion3		float		= NULL	OUTPUT,
			@TipoImpuesto1		varchar(10)	= NULL	OUTPUT,
			@TipoImpuesto2		varchar(10)	= NULL	OUTPUT,
			@TipoImpuesto3		varchar(10)	= NULL	OUTPUT,
			@TipoRetencion1		varchar(10)	= NULL	OUTPUT,
			@TipoRetencion2		varchar(10)	= NULL	OUTPUT,
			@TipoRetencion3		varchar(10)	= NULL	OUTPUT,
			@TipoImpuesto4		varchar(10)	= NULL	OUTPUT,
			@Impuesto5		float		= NULL	OUTPUT,
			@TipoImpuesto5		varchar(10)	= NULL	OUTPUT

AS BEGIN
/*
 DECLARE @CedulaIEPS varchar(20)

   IF @Modulo = 'VTAS'
   BEGIN
     SELECT @CedulaIEPS = IEPS FROM Cte WHERE Cliente = @Contacto
     IF NULLIF(@CedulaIEPS,'') IS NULL
       SELECT @Impuesto2 = NULL, @TipoImpuesto2 = NULL
   END
*/
RETURN
  END
GO
--BUG24191
/**************** xpTMAAfectarPosicion *****************/
if exists (select * from sysobjects where id = object_id('dbo.xpTMAAfectarPosicion') and type = 'P') drop procedure dbo.xpTMAAfectarPosicion
GO
CREATE PROCEDURE xpTMAAfectarPosicion
				@ID                	int,

				@Accion				char(20),
				@Base				char(20),
				@Empresa	      	char(5),
				@Modulo	      		char(5),
				@Mov	  	      	char(20),
				@MovID             	varchar(20)	OUTPUT,
				@MovTipo     		char(20),

				@Usuario	      	char(10),
				@Estatus           	char(15),
				@EstatusNuevo	    char(15),

				@Almacen			char(10), 
				@Agente				varchar(10),
				@Tarima				varchar(20),
				@Posicion			varchar(10), 
				@PosicionDestino	varchar(10),
				@Articiulo			varchar(20),

				@Ok                	int          OUTPUT,
				@OkRef             	varchar(255) OUTPUT
		    


AS BEGIN 
  DECLARE
	@Tipo								varchar(20),
	@TipoDestino						varchar(20),
    @WMSPermitirReacomodosDomicilio		bit
    
    
  SELECT @WMSPermitirReacomodosDomicilio = ISNULL(WMSPermitirReacomodosDomicilio,0) FROM EmpresaCfg WHERE Empresa = @Empresa
  SELECT @Tipo = Tipo FROM AlmPos WHERE Posicion = @Posicion AND Almacen = @Almacen
  SELECT @TipoDestino = Tipo FROM AlmPos WHERE Posicion = @PosicionDestino AND Almacen = @Almacen

  IF @Tipo = 'Domicilio' AND @TipoDestino = 'Domicilio' AND @WMSPermitirReacomodosDomicilio = 1
  BEGIN

    UPDATE AlmPos SET ArticuloEsp = '' WHERE Posicion = @Posicion AND Almacen = @Almacen
    UPDATE AlmPos SET ArticuloEsp = @Articiulo WHERE Posicion = @PosicionDestino AND Almacen = @Almacen
    
    UPDATE TMAD SET TMAD.PosicionDestino = @PosicionDestino
      FROM TMAD JOIN TMA ON TMAD.ID = TMA.ID
        JOIN MovTipo
        ON TMA.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
     WHERE TMA.Estatus = 'PENDIENTE'
       AND TMAD.PosicionDestino = @Posicion
       AND MovTipo.Clave IN('TMA.SADO', 'TMA.SRADO')

    UPDATE TMAD SET TMAD.Posicion = @PosicionDestino
      FROM TMAD JOIN TMA ON TMAD.ID = TMA.ID
        JOIN MovTipo
        ON TMA.Mov = MovTipo.Mov AND MovTipo.Modulo = 'TMA'
     WHERE TMA.Estatus = 'PENDIENTE'
       AND TMAD.Posicion = @Posicion
       AND MovTipo.Clave = 'TMA.OSUR'
       AND MovTipo.SubClave = 'TMA.OSURP'    
  END
  
--  SELECT * FROM TMA  WHERE ID IN(11647, 11648, 11649, 11650)
--  SELECT * FROM TMAD  WHERE ID IN(11647, 11648, 11649, 11650)
  
--SELECT @OK = 1
END
GO